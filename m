Return-Path: <linux-kernel+bounces-208371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA5F902422
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4720B1F2353E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 14:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F48E84A4A;
	Mon, 10 Jun 2024 14:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EVEKJivB"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7CF38FB0
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 14:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718029923; cv=none; b=AOCAddk75Kkxn7ovlS3NQf6S0egtfG9B1iaP87xMbYUzg457J1sULet0txHhKB2Z/MbXvQgvdI7UWRAwAwcGXTn+ipFjju24FRz0lbvwb/jAIedGLwjyjwUblDk/CSyZJ3JXw1O2zJ0os0CALiJRTZLwMqRyNk0QV/ZxrBXHXME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718029923; c=relaxed/simple;
	bh=YwIDCtzDhcwh+1uI494r2VXwyUPw8bVwvu4UDqPjf5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pTtc+XuY58RWnum5U8TMpYyE+5fJge9+VCkHr7qWxbyDCG5PlBP5MW3dghxylctLw9dbv+bVBPCwDJ7nSGXaIo4ygB1c3iBrFMDccLRbX/pC7R8+ReP2ELPrE75YSgBYaYIC9gA8cW5kcT+7bNGYtbAn/K+HnMiUB59XVQKMBc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EVEKJivB; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-35f24fabb81so884802f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 07:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718029919; x=1718634719; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3MaVOnN+h3M1y5FOd67tuekS93xubaycuhC8Oc45qW0=;
        b=EVEKJivBGbUjzJqEc0CMn9mnotjVbNs/1tpiymES2xeYbNDQAMcM7y1d4FjXyGfxSe
         pAZrlGCcESnNv1/lFFRpA5cQWqvLshl5E3XORgDnGXv0l6/+IpcGGZ2aN1jaaZ1tLj+7
         y/3oilo5U9ER2F9u39NpQD20tCWLJKX4RIF1iqizM1jWlQsXFIF8XBQETObWcd3ObHKY
         VfjFYcKKCzKVUCVVNLe+Qt5LoxHIkGwKHWfS6w0ao5la0AQT3d8pG1fr2cfK8cvHnAny
         UKO8BUuD/TaEfXWqS2PE0lArJxxdZsXWCgWqNUiJzJjqadNwTEKOGBwwRH+ZC+NamN6D
         E2Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718029919; x=1718634719;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3MaVOnN+h3M1y5FOd67tuekS93xubaycuhC8Oc45qW0=;
        b=EBrw1Ytb4ZCxHt/qc/WF2c52gyXVorYhIChE8/uOyy00jEQasvQ6MSaJaWpOXssqOQ
         rzwK/Vn3pCtWrINCmP3V95KLH18iecPOGdL2E3VEqbc4LfxJ/lkOgmsth1QCbZXCSHJW
         csNapaDjA7Q274R1t2JCHRIjfVIW5lsTbfokbwBuBx31VO1jbtU+PewdtFbaNEVEL1Mv
         FOv4R5+68SgRnDo/fWJqdtzakV2EytrKCgnJQNYIJFaILITUjHsOXmCoM6OTxMtWvRn9
         8bGQwfo6uDI4ySrVTRx+1mHOU0jMFmfD7a5Kw5jUV5c9rZh4kXv7zMLiUi9k5SjXxgwr
         ucEA==
X-Gm-Message-State: AOJu0YyJfFJUr05Osu+KS9tSCMX5mqArkL4WaTxGhj11itCmnDCtAK0d
	RgVq5vCw2IyAzu/W3lVGfjM3q8MEdKPEvOIqwn5eUlf7A1L6IUvxKgtlBnEQkL4=
X-Google-Smtp-Source: AGHT+IFM0m8eDu9ido96KegdI7AUOr01Ju6ZSbYdJA57J4Z2HgSEkq/gW2EIjFIZmC/4phuZXkgFPw==
X-Received: by 2002:a5d:4dd0:0:b0:358:4af8:b76e with SMTP id ffacd0b85a97d-35efee2dddbmr6455167f8f.62.1718029919618;
        Mon, 10 Jun 2024 07:31:59 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:7579:7285:c2ff:fedd:7e3a? ([2a10:bac0:b000:7579:7285:c2ff:fedd:7e3a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f24ebfbbbsm2714509f8f.61.2024.06.10.07.31.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 07:31:59 -0700 (PDT)
Message-ID: <231a8ee8-b66d-4d40-a9ff-9fdf4918944b@suse.com>
Date: Mon, 10 Jun 2024 17:31:58 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/cpu: Move identify_cpu_without_cpuid() into main
 branch
To: Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org
References: <20240521124823.486372-1-nik.borisov@suse.com>
 <87wmmwx5bk.ffs@tglx>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <87wmmwx5bk.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10.06.24 г. 17:03 ч., Thomas Gleixner wrote:
> On Tue, May 21 2024 at 15:48, Nikolay Borisov wrote:
>> No point in duplicating if (!have_cpuid_p()) check. Simply move
>> identify_cpu_without_cpuid() into the else branch. No functional
>> changes.
> 
> You wish :)
> 
>> Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
>> ---
>>   arch/x86/kernel/cpu/common.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
>> index 2b170da84f97..69265c0acaea 100644
>> --- a/arch/x86/kernel/cpu/common.c
>> +++ b/arch/x86/kernel/cpu/common.c
>> @@ -1578,9 +1578,6 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
>>   	memset(&c->x86_capability, 0, sizeof(c->x86_capability));
>>   	c->extended_cpuid_level = 0;
>>   
>> -	if (!have_cpuid_p())
>> -		identify_cpu_without_cpuid(c);
>> -
> 
> You might look what identify_cpu_without_cpuid() does and how the
> comment right here might be related:

Doh, fair enough. OTOH is Cyrix still relevant? Google says Defunct: 
November 11, 1997; 26 years ago


> 
>>   	/* cyrix could have cpuid enabled via c_identify()*/
>>   	if (have_cpuid_p()) {
> 
> Thanks,
> 
>          tglx

