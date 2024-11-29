Return-Path: <linux-kernel+bounces-412623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C709D0B88
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 10:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C6CAB23017
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 09:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7ABF188A0D;
	Mon, 18 Nov 2024 09:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xwv68dID"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6100E188014
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 09:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731921754; cv=none; b=KXsZ4+IiuN1xis5a/7+DqlCvHO96ZcVe/UdONrznoPIyuJnkl3rcSYQkXjw38zLRPZiUEsKCpk+ZmTdMq55cuIfM7SL7iRi+jJrjD9ro0tjf099qHS0LQFMbZnrhTnu7+PDFawQUgn4xVGAk3EzEdzRJY9nctO6tDIEdrGVMLPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731921754; c=relaxed/simple;
	bh=6wJSLFCpyY+aHj33li6kEvGRyGIU/UY5NnjB6LORdb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KHShDVs9tCv4DeZeck0Eb5NlbFt7ezZpd0rxzFc2DFsKnS5BMSffkGWQ8LlYXeJW7cYlLRSqmTyrIQB4DnQ1XB8TnSWjjreinI2oHtfED6jwSzTWCQdgEar/KnbRvU7YnLnk4zBRuoZofQcTSRFlcxaxDh6kegw6wSRnBbPRiNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xwv68dID; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4315eeb2601so26658165e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 01:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731921751; x=1732526551; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nGmI8lbwR7NCYeW11AMDl/Et4oHvlVYfxI3t1NYlUOg=;
        b=xwv68dIDxZYqAgoEGiBRY+BDptsCPOl1j4VfiGXLEID31XvQm61rOdgzeLUlrOtWjo
         KAyB5+6/ULTfMRWO1PDq+D3pnFNuO/6Nxbm4DIbOzkWqMw161oCsYngCDwY+tt/DGLHl
         IApYHRbG0Li3exY+5d+p338Ol5gUYljN0pU0BXd7QL3Ciz/9sLSagIzk4cCSLXHSv5ij
         o3/k61t6L+rPtFw1XhbuvDZVtrUhDO80cXABVHjS5nhpZotRLyM/HHM2yiwHMpYsKRKo
         bcFc6JR47W/tAjyyrTz0lGlyy5S+cXtGvDAVHlAULIwcco70Ivky/aPNbNDOA7mQL3zn
         pknA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731921751; x=1732526551;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nGmI8lbwR7NCYeW11AMDl/Et4oHvlVYfxI3t1NYlUOg=;
        b=XO7a8Nm+xGQFaxU9brkHTTcQDF+dQhWRzJRGrMdl3I1YFcK/qAMq7dzB6rxdmiNxZc
         3yZH1Y48Kf5JPMo/AG2I0rmXpley4+DXTIxZfjkE3OaCmL9TkEwzDfQAK8VUpaJYcDTj
         6LoXIXZctzfi2sBk4KPH01Y+hxEPqdshHjDTDRIquhdTip2WC+M+VmxomRB5fffS5biW
         SJFJm8bld73t4LlalvA5bpCO/IEMqnqTb/ldTZp2V5XWk9GXEVdKpONHkx6gR45TBzDn
         wI3brFIbwf7ZTnG06ikgNrXkAtL4D4qgWJ7WYgXq7z50Q/CO02GInZhbAMJ8plijdsGz
         9TbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKGmmynYvREbQdq/VmM0kO+Fq4+HhovbTATkvW/WjWjYE/vJbsa80TWGaAZdxsm9xNA3+V0Qwg5MMRFwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YygAXOeA18atVrDMjyUmhCFxXX4HdfS+pllu0YvaJw20ZbK8nDE
	kJ7EPFmTFCXTvdxxKiX5Vhn3he/VsNN14yfBPNwKiiaUO13for9mgUN+4zSKE1M=
X-Google-Smtp-Source: AGHT+IE8sqN41IKDsVujhddClddX9c86bSpUR4FW8FB4X5ekJHU4YZ5thRdSh5CzRwHbbdczRsLpKA==
X-Received: by 2002:a05:600c:1e88:b0:431:5465:8072 with SMTP id 5b1f17b1804b1-432df793c69mr127392555e9.31.1731921750695;
        Mon, 18 Nov 2024 01:22:30 -0800 (PST)
Received: from [192.168.68.163] ([145.224.66.237])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da265668sm150597475e9.10.2024.11.18.01.22.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 01:22:30 -0800 (PST)
Message-ID: <1a843735-0a94-4df7-a8b4-cad68ee2449a@linaro.org>
Date: Mon, 18 Nov 2024 09:22:27 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 04/12] KVM: arm64: Make vcpu flag macros more generic
To: Marc Zyngier <maz@kernel.org>
Cc: suzuki.poulose@arm.com, oliver.upton@linux.dev,
 coresight@lists.linaro.org, kvmarm@lists.linux.dev,
 Joey Gouly <joey.gouly@arm.com>, Zenghui Yu <yuzenghui@huawei.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mike Leach <mike.leach@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 James Morse <james.morse@arm.com>, Fuad Tabba <tabba@google.com>,
 Shiqi Liu <shiqiliu@hust.edu.cn>, Raghavendra Rao Ananta
 <rananta@google.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241112103717.589952-1-james.clark@linaro.org>
 <20241112103717.589952-5-james.clark@linaro.org>
 <86y11gvruu.wl-maz@kernel.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <86y11gvruu.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 18/11/2024 9:00 am, Marc Zyngier wrote:
> On Tue, 12 Nov 2024 10:37:03 +0000,
> James Clark <james.clark@linaro.org> wrote:
>>
>> Rename vcpu_* to kvm_* so that the same flags mechanism can be used in
>> places other than vcpu without being confusing. Wherever macros are
>> still related to vcpu like vcpu_get_flag() with hard coded v->arch, keep
>> the vcpu_* name, otherwise change it.
>>
>> Also move the "v->arch" access one macro higher for the same reason.
>>
>> This will be used for moving flags to host_data in a later commit.
>>
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>>   arch/arm64/include/asm/kvm_host.h | 88 +++++++++++++++----------------
>>   arch/arm64/kvm/hyp/exception.c    | 12 ++---
>>   arch/arm64/kvm/inject_fault.c     |  4 +-
>>   arch/arm64/kvm/mmio.c             | 10 ++--
>>   4 files changed, 57 insertions(+), 57 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
>> index f333b189fb43..34aa59f498c4 100644
>> --- a/arch/arm64/include/asm/kvm_host.h
>> +++ b/arch/arm64/include/asm/kvm_host.h
>> @@ -790,22 +790,22 @@ struct kvm_vcpu_arch {
>>   /*
>>    * Each 'flag' is composed of a comma-separated triplet:
>>    *
>> - * - the flag-set it belongs to in the vcpu->arch structure
>> + * - the flag-set it belongs to in the structure pointed to by 'v'
>>    * - the value for that flag
>>    * - the mask for that flag
>>    *
>> - *  __vcpu_single_flag() builds such a triplet for a single-bit flag.
>> - * unpack_vcpu_flag() extract the flag value from the triplet for
>> + *  __kvm_single_flag() builds such a triplet for a single-bit flag.
>> + * unpack_kvm_flag() extract the flag value from the triplet for
>>    * direct use outside of the flag accessors.
>>    */
>> -#define __vcpu_single_flag(_set, _f)	_set, (_f), (_f)
>> +#define __kvm_single_flag(_set, _f)	_set, (_f), (_f)
>>   
>>   #define __unpack_flag(_set, _f, _m)	_f
>> -#define unpack_vcpu_flag(...)		__unpack_flag(__VA_ARGS__)
>> +#define unpack_kvm_flag(...)		__unpack_flag(__VA_ARGS__)
>>   
>>   #define __build_check_flag(v, flagset, f, m)			\
>>   	do {							\
>> -		typeof(v->arch.flagset) *_fset;			\
>> +		typeof(v.flagset) *_fset;			\
>>   								\
>>   		/* Check that the flags fit in the mask */	\
>>   		BUILD_BUG_ON(HWEIGHT(m) != HWEIGHT((f) | (m)));	\
>> @@ -813,11 +813,11 @@ struct kvm_vcpu_arch {
>>   		BUILD_BUG_ON((sizeof(*_fset) * 8) <= __fls(m));	\
>>   	} while (0)
>>   
>> -#define __vcpu_get_flag(v, flagset, f, m)			\
>> +#define __kvm_get_flag(v, flagset, f, m)			\
>>   	({							\
>>   		__build_check_flag(v, flagset, f, m);		\
>>   								\
>> -		READ_ONCE(v->arch.flagset) & (m);		\
>> +		READ_ONCE(v.flagset) & (m);		\
>>   	})
>>   
>>   /*
>> @@ -826,64 +826,64 @@ struct kvm_vcpu_arch {
>>    */
>>   #ifdef __KVM_NVHE_HYPERVISOR__
>>   /* the nVHE hypervisor is always non-preemptible */
>> -#define __vcpu_flags_preempt_disable()
>> -#define __vcpu_flags_preempt_enable()
>> +#define __kvm_flags_preempt_disable()
>> +#define __kvm_flags_preempt_enable()
>>   #else
>> -#define __vcpu_flags_preempt_disable()	preempt_disable()
>> -#define __vcpu_flags_preempt_enable()	preempt_enable()
>> +#define __kvm_flags_preempt_disable()	preempt_disable()
>> +#define __kvm_flags_preempt_enable()	preempt_enable()
>>   #endif
>>   
>> -#define __vcpu_set_flag(v, flagset, f, m)			\
>> +#define __kvm_set_flag(v, flagset, f, m)			\
> 
> Hell no. Never. The whole point of this naming is that we know what
> this applies to. Here, you might as well have replaced 'vcpu' with
> 'carrot', and the result would be the same.
> 
> Not to mention the insane churn this generates.
> 
> So no, not happening.
> 
> 	M.
> 

Fair enough, I wasn't feeling to strongly about this either, was just 
anticipating that there might be objection to bare flags if this more 
abstracted mechanism existed elsewhere.

Looks like Oliver already did it with just flags for the same end goal 
here [1], so I will drop this.

[1]: 
https://lore.kernel.org/kvmarm/20241115224924.2132364-4-oliver.upton@linux.dev/T/#u


