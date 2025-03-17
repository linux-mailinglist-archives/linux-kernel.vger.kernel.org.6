Return-Path: <linux-kernel+bounces-563396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82453A640F3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 07:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A95811891151
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 06:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97224219301;
	Mon, 17 Mar 2025 06:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZnW6bLv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA502E3373
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 06:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742191956; cv=none; b=eMNF4Y+U7bFoTWJDbuvG0wsIw8XJzcG+wuENBPw0HfSAvzFMSjSDb/sidljFZNXXZ+Lq8XXoasPdxWfntv8N7OkIuE+oyA6zNWVOOiZKxz3y/hSjbqwmExlL8jJqSplIIDl6FllkbpY/Mv9YlSXc/u59Z1nIWlhn5Mqt/vdbcb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742191956; c=relaxed/simple;
	bh=kB3XUPS5Ai98F8oaOEOR7FwcKHwmT0G2hG0d2y72Kyw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=d1xsOQmuPIA7au//nDmo7v9Swt2k/8o8aFYOqCE/rnlolxE7LE+b1WKCPaIx1dtgagnhDBG4COC2i24OjnIL2nwjRiHjRJFgAJMK6Ay12hxg1ypkr2m8D/rca5MTDCodYcUsg4HyuYAtDwqaNfV8fZcIOguswpQTKOVRhYSeZfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZnW6bLv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1CACC4CEE3;
	Mon, 17 Mar 2025 06:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742191955;
	bh=kB3XUPS5Ai98F8oaOEOR7FwcKHwmT0G2hG0d2y72Kyw=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=hZnW6bLvTinXFWr1KhG5kwdsgAM0Dn97tnQzX/70ejeFeOtxJnRtXTzNtMr6fedIm
	 94EtySg8pheTizrSVQC7xM6jR8mj93+u9NMMOSAvZo9sZCHlGMSKMSxTOsZK2/YQCL
	 eQDB/p+3zYlZsF6rvXjp/lThieAWLrBTrjLLSEKiDBoSjacrZUAyPIXMSnEEn6A7SZ
	 BanHZqO6OROWYOZZ3r3XBFxoh6iF3ktAUNlmrCasnXCVzwQX5GdnCZbxu3wHlO0oI9
	 qzfTdMGefItafTL1/TWt2KFdhAubclZCMg5Bt7lyAeRL1254q6mwoeFF1+s36rkknl
	 xGzh6gO+31nVg==
Message-ID: <9c552d9a-2d46-4069-a9c4-35fab857bfc3@kernel.org>
Date: Mon, 17 Mar 2025 07:12:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linux-next] genirq: use sysfs_emit() instead of
 scnprintf().
From: Jiri Slaby <jirislaby@kernel.org>
To: xie.ludan@zte.com.cn, tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org
References: <20250315141721157LhKSIQccKZ3ZgAzuvbQo1@zte.com.cn>
 <e177acba-24d3-4202-a0a8-92bfbfdf87e7@suse.cz>
Content-Language: en-US
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <e177acba-24d3-4202-a0a8-92bfbfdf87e7@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17. 03. 25, 7:07, Jiri Slaby wrote:
> Hi,
> 
> your e-mail is both multipart and base64 encoded :(. Pls fix up your 
> setup first.
> 
> On 15. 03. 25, 7:17, xie.ludan@zte.com.cn wrote:
>> From: XieLudan <xie.ludan@zte.com.cn>
>>
>>
>> Follow the advice in Documentation/filesystems/sysfs.rst:
>>
>> show() should only use sysfs_emit() or sysfs_emit_at() when formatting
>>
>> the value to be returned to user space.
>>
>>
>> Signed-off-by: XieLudan <xie.ludan@zte.com.cn>
>>
>> ---
>>
>>   kernel/irq/irqdesc.c | 12 ++++++------
>>
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>>
>> diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
>>
>> index 287830739783..8ffe12fe5af6 100644
>>
>> --- a/kernel/irq/irqdesc.c
>>
>> +++ b/kernel/irq/irqdesc.c
>>
>> @@ -257,11 +257,11 @@ static ssize_t per_cpu_count_show(struct kobject 
>> *kobj,
>>
>> for_each_possible_cpu(cpu) {
>>
>> unsigned int c = irq_desc_kstat_cpu(desc, cpu);
>>
>> -ret += scnprintf(buf + ret, PAGE_SIZE - ret, "%s%u", p, c);
>>
>> +ret += sysfs_emit(buf + ret, "%s%u", p, c);
> 
> Well, so the PAGE_SIZE boundary is never checked for this stacking write 
> now, right?

^^^ not really clear what I mean, so:

If you advance buf by ret every time, sysfs_emit() still would only 
check if buf is not written more than "PAGE_SIZE" bytes. But the 
original code performs this proper "PAGE_SIZE - ret" check.

> thanks,

-- 
js
suse labs

