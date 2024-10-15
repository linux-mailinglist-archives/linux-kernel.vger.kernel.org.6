Return-Path: <linux-kernel+bounces-364978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C8699DBD8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 03:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F87F1F23859
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 01:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E70A156C74;
	Tue, 15 Oct 2024 01:47:41 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 2700E54738;
	Tue, 15 Oct 2024 01:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728956860; cv=none; b=Jm6bXHiZSIe5mbi+hLcMx10mP/YZdOOTjJQLx+aV0g3XgGqqz/tH6hXRW4vlIM6lTALivDB4FNsUJdCrbTR7M+ZzpFXlv/BKkXnXgoVAffv6JvV4vh/aLpeg1e9kmyu/q6hMk66gO0wOgROEdKg3XAy8mqSuxT/8fOgZ7ZZ2M6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728956860; c=relaxed/simple;
	bh=mKuzTgXZ5SrzCglC2W7yV36DIGk73UAm3Drpg1dOslg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type; b=PMm72HaRfKfPUGf6GwLWZ9tsn4f8iFQiztAHad4uMXEGVdN2slI8g9aFWtgbIrqeq+Oz/MFvwWVFpMK7CLHdNZ/X3ezhtOijX0yOUuVfZ/tlGCnl2nK/ZuF4CCeyw820wAcpeyaRaFe4MLr5/5NO/jao/eOjx9MwD3KDxxaLrd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from [172.30.20.101] (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id 7E0A760BFCF20;
	Tue, 15 Oct 2024 09:47:29 +0800 (CST)
Message-ID: <725540a7-b3ab-d116-8410-8fe077e008c7@nfschina.com>
Date: Tue, 15 Oct 2024 09:47:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH] smb: client: fix possible double free in smb2_set_ea()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: sfrench@samba.org, pc@manguebit.com, ronniesahlberg@gmail.com,
 sprasad@microsoft.com, stfrench@microsoft.com, tom@talpey.com,
 bharathsm@microsoft.com, nathan@kernel.org, ndesaulniers@google.com,
 morbo@google.com, justinstitt@google.com, linux-cifs@vger.kernel.org,
 samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, kernel-janitors@vger.kernel.org
Content-Language: en-US
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
In-Reply-To: <8bd0fae3-82fe-41c4-a4e8-3c28aa2b1826@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/10/14 20:53, Dan Carpenter wrote:

> On Mon, Oct 14, 2024 at 07:34:17PM +0800, Su Hui wrote:
>> Clang static checker(scan-build) warning：
>> fs/smb/client/smb2ops.c:1304:2: Attempt to free released memory.
>>   1304 |         kfree(ea);
>>        |         ^~~~~~~~~
>>
>> There is a double free in such case:
>> 'ea is initialized to NULL' -> 'first successful memory allocation for
>> ea' -> 'something failed, goto sea_exit' -> 'first memory release for ea'
>> -> 'goto replay_again' -> 'second goto sea_exit before allocate memory
>> for ea' -> 'second memory release for ea resulted in double free'.
>>
>> Assign NULL value to 'ea' after 'kfree(ea)', it can fix this double free
>> problem.
>>
>> Fixes: 4f1fffa23769 ("cifs: commands that are retried should have replay flag set")
>> Signed-off-by: Su Hui <suhui@nfschina.com>
>> ---
>>   fs/smb/client/smb2ops.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
>> index 6b385fce3f2a..5b42b352b703 100644
>> --- a/fs/smb/client/smb2ops.c
>> +++ b/fs/smb/client/smb2ops.c
>> @@ -1302,6 +1302,7 @@ smb2_set_ea(const unsigned int xid, struct cifs_tcon *tcon,
>>   
>>    sea_exit:
>>   	kfree(ea);
>> +	ea = NULL;
> That's very clever.  But I think that it would be better to do the "ea = NULL"
> near to the replay_again label.  There are some lines where we re-initialize
> resp_buftype[], utf16_path and vars etc.
>
> 	ea = NULL;
> 	resp_buftype[0] = resp_buftype[1] = resp_buftype[2] = CIFS_NO_BUFFER;

Yes, it's better! Thanks for your suggestions. I will send v2 patch soon.

Su Hui


