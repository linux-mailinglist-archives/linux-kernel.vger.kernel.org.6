Return-Path: <linux-kernel+bounces-228922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 376E59168B7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 15:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9F001F220D9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 13:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5288515A86A;
	Tue, 25 Jun 2024 13:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BeXRLSau"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2652E3F7
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 13:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719321585; cv=none; b=p9IXbnRhdy20UoRxqpB+8CafUfwxrzHbz8ySDRgXQN1Hm3py+r110lNzvLhLkaHwP8I60KmHU51WskkgQ/AcKwz0JDV/DxVJRfu5bm81o0NmSJY82Ec2XFdQIGaNxVJvujwpnRXmPNktJ6yZyMj4xM4J6BNfBvo/fmzs5c5BHJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719321585; c=relaxed/simple;
	bh=Yyf/auCc31bC0oQe5Meh++bNvU4qDPsE/3v9n7a+Q2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bbxXCwozGahJOIiPi3fszaQvAfxABeXuOUrJ8+9W+/BRHhcgwHeKENn9Vw2NGsgiX0QSTxg90W4cy9BOmyHpKItCWzSzv3cvgyQ0G5cr33Zi0JjyBTgIAfc9rwJb8jjvkCxQZrD05oej+yM9yrXDZJ7ozr15SrhOmQxjCOPw+Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BeXRLSau; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-362f62ae4c5so3186693f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 06:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719321582; x=1719926382; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=48yte4gKSqaQnEHN3UMFhPgzd1yTJsSvbj40aM201ew=;
        b=BeXRLSauvvLFAp2orPzkTjMTZnKK5atj4qQ5ljciOVwSK2iDyIL2+oak2clIrmDZtZ
         3uZ2UPTbzxrmfezCxb3nDiMKgwalFQMmAz1LZ7G5rHr6Nc6/Z/VwCK3xwqci44/NcQh5
         w/4qhMMGmisuKmHatW4J51sDB8zXPsAIKH3feEUTW4KGgBqvJh+SsecMexgqtxgp/xvQ
         TDNvrYAU+aE4wNRUwiggKYaTaqzdvhaSJ9YT/D87YcXZue0ksi8FNAvZph1RH6F5wEev
         W2q4RhVBWZhUkpbDAUOsGXe/lQjy1mXCtdVnLfsiuzdkQHAwz/cXoOmeBV2Ksd6jXTzv
         vKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719321582; x=1719926382;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=48yte4gKSqaQnEHN3UMFhPgzd1yTJsSvbj40aM201ew=;
        b=A7IFe159ibdMCv8Aj/r0Vz3Suj+1r/UXdqsklv/Yi+IxIqScNqxStMBNM29Y5joMRP
         9lCAs+aEBbKKZoef2KCAhI46Lpz0kwurjTN3AfVxgVlkgq/0z+F/quxTMKq/0cSc+1sg
         n5FPP1PDy5L1ySjXxAPTai/AzleT4Fc9vsFMVRDHtYWDKd7k5eiUL2b6UTuRKZeMpnsT
         wuprAZger+e2R9IELQ+ODYfEOZqFLEuz1++Yn5a14qsT5SZUPYR9PiaibSFKIIPNSHDh
         WuxxgB22CFxjRHCpuI2tt9JWI5zAAd/5MSK6zGa9FnvyORz9rzj86Q88O5ax40mRN58Y
         SqgA==
X-Gm-Message-State: AOJu0Yz31vkyJG4gjpHQN5JfpnCgltqXx44jfrh6SPfeFACbqKqmPqhD
	Se4HM6O8PkrHggAb74vPKS74Lb+74OQpBsx6S/+VsiRK3o6KT50AqhyhawBxWBE=
X-Google-Smtp-Source: AGHT+IH0CMWNndifpo43wA5FkYclBGPAQbOql8DRY/i6lVJ+tERFRrZJIyogey7lkuy76vWAHz99qA==
X-Received: by 2002:a5d:688c:0:b0:361:94d9:1e9f with SMTP id ffacd0b85a97d-366e325bc07mr6692790f8f.7.1719321581772;
        Tue, 25 Jun 2024 06:19:41 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:7579:7285:c2ff:fedd:7e3a? ([2a10:bac0:b000:7579:7285:c2ff:fedd:7e3a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0c54d9sm217268865e9.28.2024.06.25.06.19.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 06:19:41 -0700 (PDT)
Message-ID: <bbdf9caa-7c0f-44d1-a69d-a5cecc7cd4fa@suse.com>
Date: Tue, 25 Jun 2024 16:19:40 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] x86/mce: Define mce_prep_record() helpers for
 common and per-CPU fields
To: Yazen Ghannam <yazen.ghannam@amd.com>, linux-edac@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
 avadhut.naik@amd.com, john.allen@amd.com
References: <20240624212008.663832-1-yazen.ghannam@amd.com>
 <20240624212008.663832-5-yazen.ghannam@amd.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <20240624212008.663832-5-yazen.ghannam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 25.06.24 г. 0:20 ч., Yazen Ghannam wrote:
> Generally, MCA information for an error is gathered on the CPU that
> reported the error. In this case, CPU-specific information from the
> running CPU will be correct.
> 
> However, this will be incorrect if the MCA information is gathered while
> running on a CPU that didn't report the error. One example is creating
> an MCA record using mce_prep_record() for errors reported from ACPI.
> 
> Split mce_prep_record() so that there is a helper function to gather
> common, i.e. not CPU-specific, information and another helper for
> CPU-specific information.
> 
> Leave mce_prep_record() defined as-is for the common case when running
> on the reporting CPU.
> 
> Get MCG_CAP in the global helper even though the register is per-CPU.
> This value is not already cached per-CPU like other values. And it does
> not assist with any per-CPU decoding or handling.
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
> Link:
> https://lkml.kernel.org/r/20240521125434.1555845-3-yazen.ghannam@amd.com
> 
> v1->v2:
> * No change.
> 
>   arch/x86/kernel/cpu/mce/core.c     | 34 ++++++++++++++++++++----------
>   arch/x86/kernel/cpu/mce/internal.h |  2 ++
>   2 files changed, 25 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index dd5192ef52e0..0133f88dfffb 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -117,20 +117,32 @@ static struct irq_work mce_irq_work;
>    */
>   BLOCKING_NOTIFIER_HEAD(x86_mce_decoder_chain);
>   
> -/* Do initial initialization of a struct mce */
> -void mce_prep_record(struct mce *m)
> +void mce_prep_record_common(struct mce *m)
>   {
>   	memset(m, 0, sizeof(struct mce));
> -	m->cpu = m->extcpu = smp_processor_id();
> +
> +	m->cpuid	= cpuid_eax(1);
> +	m->cpuvendor	= boot_cpu_data.x86_vendor;
> +	m->mcgcap	= __rdmsr(MSR_IA32_MCG_CAP);
>   	/* need the internal __ version to avoid deadlocks */
> -	m->time = __ktime_get_real_seconds();
> -	m->cpuvendor = boot_cpu_data.x86_vendor;
> -	m->cpuid = cpuid_eax(1);
> -	m->socketid = cpu_data(m->extcpu).topo.pkg_id;
> -	m->apicid = cpu_data(m->extcpu).topo.initial_apicid;
> -	m->mcgcap = __rdmsr(MSR_IA32_MCG_CAP);
> -	m->ppin = cpu_data(m->extcpu).ppin;
> -	m->microcode = boot_cpu_data.microcode;
> +	m->time		= __ktime_get_real_seconds();
> +}
> +
> +void mce_prep_record_per_cpu(unsigned int cpu, struct mce *m)
> +{
> +	m->cpu		= cpu;
> +	m->extcpu	= cpu;
> +	m->apicid	= cpu_data(m->extcpu).topo.initial_apicid;
> +	m->microcode	= cpu_data(m->extcpu).microcode;
> +	m->ppin		= cpu_data(m->extcpu).ppin;

nit: Similar to tglx's feedback for patch 2 you could use topology_ppin()

> +	m->socketid	= cpu_data(m->extcpu).topo.pkg_id;
nit: topology_physical_package_id()


> +}
> +


<snip>

