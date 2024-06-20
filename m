Return-Path: <linux-kernel+bounces-222558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6568C9103A5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 14:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F3871C21DE5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 12:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC751AAE2E;
	Thu, 20 Jun 2024 12:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WgcTr6Yf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32611A00C2
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 12:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718885092; cv=none; b=uTWEM252JY5fN/TMTVduv6BpxdeR2dSCCYxEN5ocewRy2bC348eekR5vQIaOAYApKbe3a4HPU7S3T1HtlbDGWyhqTrFkZ3DUMBWtStIgGRGP0aDwMSzwre5gprmRq2BGNh7Z0a56AvV3VALoSt7S9u3D7oUywZcNVtO9SHcMwew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718885092; c=relaxed/simple;
	bh=p8i4kgsSXiThvs104+IQObiSdDnBCcWSCkYwC99CoHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X5y60W4Bqbl5bVPuQFR2zPIBYmxVcT0+JTiXOaNEt6WEBaSazINwAIO+5OW4d4JauAB3jWh/CKFAybylVtYC8eagE/S4qIyL6sgGRSoS+r3pdMgl5Fm6tJ9Mv6nTs1Uad0S7p5km3iU57F377iU/+JoGJRDjWiKNn9oiorFRHfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WgcTr6Yf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718885089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tBTGVX4bvUyxrx4ohv02xbwKgf7bYjyve7BA15u6MEQ=;
	b=WgcTr6Yf3k2FAAr40bYTv0O/9YmB8SdpRxpLx+szww0HM9tIHC82ZFZvXgzNvOsxSz0r/g
	CN+kancUfcaCLP2y06SLINv4lQ6fkM7mG5RMtrPbuuOhfk9r34eMx2n66qB+4QcNNdsg7d
	jeUqN/M+BHl6kW8ijChEcoTnuNFW6ZY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-YFrvsQQvNS-zacy7seOvog-1; Thu, 20 Jun 2024 08:04:48 -0400
X-MC-Unique: YFrvsQQvNS-zacy7seOvog-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6b22e2dfa6cso10729126d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 05:04:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718885087; x=1719489887;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tBTGVX4bvUyxrx4ohv02xbwKgf7bYjyve7BA15u6MEQ=;
        b=LVuTaN+f95siWZRez2HNRWxMp4EASUyMoexQVUUSex7lPROxW0SyeDDRlkmEdZMRCg
         wRn0KP6N2pXBGtuCx6x5lOuJD34g6M0E8SW9LMmWf2La7a8rvDTR0dvi4dcTjyjj9BgU
         6OxkSrOJWv464lw3ehZ3qwnGUExZpBQ7X3MrNSSaictLZXsqIBMWPNJr/W8MLbuCX+4K
         kvq2lEpz850jgswd4rET+ZOJs3neBzpOSjmmH50G6fuNUn+B57l35bNrakHN6XzHBJfM
         DIQwNcmRIOoUOcanpN/IKsJi6WLwVidKPsCpFaAcCFWsFCA/F5FF2U2xB7iXo4C3wfcQ
         Z+2w==
X-Forwarded-Encrypted: i=1; AJvYcCWmm1Cjk0lI/pf4QRWt1snFgCjiyswCMLc0q7cd2z7iSCksT7JzMSFZimiCQmJ9hh/Al0dDm0T4zNvswBhdTkI/Mt7EetdD1NcXPTZv
X-Gm-Message-State: AOJu0YxRwDKHcNybzjTl4LU8QYfcjWMmx0D6dh78zzhr5Uvq2YDSY8BX
	t9Epjy8b7p8TJojhgZG0uoFFGF6xFoLNwijyN3DrCjMOL+qEz/8UH/a/d+yNp9lx8lNNFGiV1ge
	wKwBhDEHIYlcnXVeXahRj+qGmLTnAgJGYbYFOiR/YVTNwkaqvClclH/G5OztX0k8zuinEvQ==
X-Received: by 2002:ad4:5c8b:0:b0:6b5:6f9:9207 with SMTP id 6a1803df08f44-6b506f9925dmr56113936d6.20.1718885087367;
        Thu, 20 Jun 2024 05:04:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXBwop604Y5LJHb0b34gI7Je4i9x8IkF784us5Ea9E+Z1DVF2QvWsWClXZaaHI9SoMFqaGOw==
X-Received: by 2002:ad4:5c8b:0:b0:6b5:6f9:9207 with SMTP id 6a1803df08f44-6b506f9925dmr56113586d6.20.1718885086970;
        Thu, 20 Jun 2024 05:04:46 -0700 (PDT)
Received: from [10.26.1.93] ([66.187.232.136])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79bc266c496sm84674985a.20.2024.06.20.05.04.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 05:04:46 -0700 (PDT)
Message-ID: <4aff3fb4-cf1b-4c09-918a-3c4252a34bd6@redhat.com>
Date: Thu, 20 Jun 2024 08:04:45 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: Do not enable ACPI SPCR console by default on arm64
To: Liu Wei <liuwei09@cestc.cn>, sudeep.holla@arm.com,
 Will Deacon <will@kernel.org>
Cc: catalin.marinas@arm.com, guohanjun@huawei.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 lpieralisi@kernel.org, rafael@kernel.org
References: <20240530015332.7305-1-liuwei09@cestc.cn>
 <cb4c5fd0-9629-4362-918a-cb044eb9e558@redhat.com>
 <20240618152923.GB2354@willie-the-truck>
 <20240618164024.tehpbscax47jkluj@bogus>
Content-Language: en-US
From: Prarit Bhargava <prarit@redhat.com>
In-Reply-To: <20240618164024.tehpbscax47jkluj@bogus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/18/24 23:43, Liu Wei wrote:
> From: Sudeep Holla <sudeep.holla@arm.com>
> 
> On Tue, Jun 18, 2024 at 04:29:24PM +0100, Will Deacon wrote:
>>> On Thu, May 30, 2024 at 09:06:17AM -0400, Prarit Bhargava wrote:
>>>> On 5/29/24 21:53, Liu Wei wrote:
>>>>> Consistency with x86 and loongarch, don't enable ACPI SPCR console
>>>>> by default on arm64
>>>>>
>>>>> Signed-off-by: Liu Wei <liuwei09@cestc.cn>
>>>>> ---
>>>>>    arch/arm64/kernel/acpi.c | 3 ++-
>>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
>>>>> index dba8fcec7f33..1deda3e5a0d2 100644
>>>>> --- a/arch/arm64/kernel/acpi.c
>>>>> +++ b/arch/arm64/kernel/acpi.c
>>>>> @@ -227,7 +227,8 @@ void __init acpi_boot_table_init(void)
>>>>>    		if (earlycon_acpi_spcr_enable)
>>>>>    			early_init_dt_scan_chosen_stdout();
>>>>>    	} else {
>>>>> -		acpi_parse_spcr(earlycon_acpi_spcr_enable, true);
>>>>> +		/* Do not enable ACPI SPCR console by default */
>>>>> +		acpi_parse_spcr(earlycon_acpi_spcr_enable, false);
>>>>>    		if (IS_ENABLED(CONFIG_ACPI_BGRT))
>>>>>    			acpi_table_parse(ACPI_SIG_BGRT, acpi_parse_bgrt);
>>>>>    	}
>>>>
>>>> It's been a while, and the status of arm hardware may have changed. IIRC the
>>>> choice to force enable this is that most arm hardware is headless and this
>>>> was a _required_ option for booting.
>>>>
>>>> I'm not sure if that's still the case as it's been a long time.
>>>>
>>>> Can anyone from the ARM community provide an approval here?
>>>
>>> I don't have a strong opinion either way, but adding the Arm ACPI folks
>>> in case they care.
>>>
>>> Having said that, if the only rationale for this patch is consistency
>>> with other architectures, then I think I'd lean towards leaving the
>>> behaviour as-is so we don't give users a nasty surprise on their next
>>> kernel upgrade.
>>>
>>
>> +1, I am concerned about breaking existing behaviour on the platforms
>> in the wild. Also many platforms running ACPI would have already used
>> console cmdline parameter if SPCR is not their choice for the console.
>> So I don't see the need to align with other arch default behaviour here,
>> we can revisit if someone shouts with a real reason as why cmdline option
>> is not viable.
> 
> For varying privacy and security reasons, sometimes we would like to
> completely silence the serial console output, and only enable it through
> cmdline when needed.
> 

FWIW, I understand that concern but the feedback you're receiving is 
that there are many existing systems that depend on this behavior. 
Breaking users for your concerns is not a good idea.

Perhaps a solution is to add yet-another-config-option, or add a kernel 
parameter to disable the SPCR console on ARM?

Something like "acpi=nospcr"?

P.

> On ARM, it is difficult because SPCR is enabled by default.
> 
> Thanks for your patience,
> Liu Wei
> 
>>
>> --
>> Regards,
>> Sudeep
> 
> 
> 
> 


