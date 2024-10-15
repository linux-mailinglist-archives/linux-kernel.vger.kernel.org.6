Return-Path: <linux-kernel+bounces-366415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C1F99F507
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 20:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B37C81C23135
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 18:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47097212640;
	Tue, 15 Oct 2024 18:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AnU8ncF0"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEB4209683
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 18:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729016219; cv=none; b=by6OltTx+FnfeMxqjjwLMLdZdcNC97tePURVcOP7Pd7hn5buBemX8SnWydH0Hz4sJz9Q8KpSUpRdwmpKrl9ZGTfItnaaFS0t9i/USlbgNEDxaPQZOZTnQC517BWesTe/Ad6gH1q1zcy0za3STJIlsX0xSqi0Ob3t42ArkaQfLWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729016219; c=relaxed/simple;
	bh=tvWhqVZ+azkqS/p2nSYvXgUHuwmTr1/fYa6HINYnGCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tBCNBdhe9OA04xkG/xIWrXaoWIl4PmG5Nn1At9Qt57ClIOyxIakRoLi10LRnOslho+EwyBw2wJHVzfsDHVVa8OwOKUtyooTsvLS9NwPlJi0BTfmKescMDMdz6F9Aww2q4YD2j5iBnE40o1/i4eJWuJUcON4Y1exOq6Jpsg1IqSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AnU8ncF0; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <dd4be9f4-71e3-4d71-bd71-1fda2c9572b6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729016215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AM9YGLLMfMM3L05gwH2rP2Z6pyEbGrpsO5vilHNCUu0=;
	b=AnU8ncF0rkD1kJhHH+8taI6iKkayCtzo36kP/9QPUbO2+uRQ0xDeDTknluj5HpuAUl/k50
	1M5EiQrh+Cb7+g5DFWk9vaah9YL/0rADE4j/ZZniGz/DASDjD42NbA/N8OPrnBrjZ1Thj6
	oOaDo1Q3xpWCWJYSAUq+va262NUQP8I=
Date: Tue, 15 Oct 2024 11:16:42 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpftool: optimize if statement code
To: Liu Jing <liujing@cmss.chinamobile.com>
Cc: Quentin Monnet <qmo@kernel.org>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241015110944.6975-1-liujing@cmss.chinamobile.com>
 <fe9261d8-1e1d-4060-9a7e-1902d75cff7a@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <fe9261d8-1e1d-4060-9a7e-1902d75cff7a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 10/15/24 5:11 AM, Quentin Monnet wrote:
> 2024-10-15 19:09 UTC+0800 ~ Liu Jing <liujing@cmss.chinamobile.com>
>> Since both conditions are used to check whether len is valid, we can combine 
>> the two conditions into a single if statement
>> Signed-off-by: Liu Jing <liujing@cmss.chinamobile.com>
>> ---
>>   tools/bpf/bpftool/feature.c | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/bpf/bpftool/feature.c b/tools/bpf/bpftool/feature.c
>> index 4dbc4fcdf473..0121e0fd6949 100644
>> --- a/tools/bpf/bpftool/feature.c
>> +++ b/tools/bpf/bpftool/feature.c
>> @@ -158,10 +158,9 @@ static int get_vendor_id(int ifindex)
>>       len = read(fd, buf, sizeof(buf));
>>       close(fd);
>> -    if (len < 0)
>> -        return -1;
>> -    if (len >= (ssize_t)sizeof(buf))
>> +    if ((len < 0) || (len >= (ssize_t)sizeof(buf)))
>>           return -1;
>> +
>>       buf[len] = '\0';
>>       return strtol(buf, NULL, 0);
> 
> 
> Thanks. I'm not strictly opposed to the change, but it doesn't bring much value 
> in my opinion. I don't think this will "optimize" the statement beyond what the 
> compiler does already.

+1

The current code is good as is.

pw-bot: cr


