Return-Path: <linux-kernel+bounces-241872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DEA92808E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 04:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88BB7283FA3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 02:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CFF1D559;
	Fri,  5 Jul 2024 02:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fu3ceKBT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB111BC4F
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 02:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720147437; cv=none; b=KqJz4bamPuuOSq26d9jtMYnDyS8eczb4twdIi+YXDkVNaY50aWaz62wKkcdUjIy5rEZZKh0GjeNVzA6RcpwtVvosjPZ6Dm28A3L4pAez8771JXfkSHSbnfPBRPombQruCud5n+bRvtN6USTSTfYS9kyrtDC0NInXmTYb4mYqU2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720147437; c=relaxed/simple;
	bh=8MGFKcZ2Pb4lFttSMmZpH0a5HBiG2JsOZCRf3Wi6Moo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fidzTDgEPbo5m6tAD7GEv2pm5H+zVWBD9qY3Z9TV6XqOS52+P9HhSGL4JnKNj53TVCb1BVVrUXoLP51tmT81xRKZlac6fSfpubMfXkjVR7YaUeHpraFQ489TlI98pn4lJaBWP7qZoU1c7falPg1zPiV7ISpH+tEA4jv8xKoAB/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fu3ceKBT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720147434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fiIV52P1D3oTXD+BJX66re1vrwR0GUT0MIJ0IzN93Ps=;
	b=Fu3ceKBTR+iMbLEF78khfOZq2Mr1kLPj67rD0LFZKRYZ5GjTe+x3ywcMelqDe2VarvlcVY
	KkROU+DUpNXETK6HsJwPlRLAZjNhqxgmqHJ6DQihiIU8W5z/FWgj+Dd2loZYCieM9RCKNF
	hiG2qLT8kRnaKK8L52SbyIZJkBOJmeE=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-iMcGMoEPMja6iL3D3swicA-1; Thu, 04 Jul 2024 22:43:52 -0400
X-MC-Unique: iMcGMoEPMja6iL3D3swicA-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-6525230ceeaso23351357b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 19:43:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720147431; x=1720752231;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fiIV52P1D3oTXD+BJX66re1vrwR0GUT0MIJ0IzN93Ps=;
        b=P2Xp0rvZ/0PY9R+hx6QWqUOXhRbsVjhMT+0AlPFMhrg+Xb3mDmNyUMYsbXc8SrBLf9
         qiQ5X7PJQklkhRF72v4KCp9GkylpuiFmEQom9859uNWE9cenazEwXUr3W/Gr/NdproPp
         E7n8kM2X7+5lPqKolYkEmZ0HW1m9X9EUFe/DY5tE+5IfReR0A88Z5hC7H+ib3JxTGNqv
         CY2poLJipi1P4iIr7BUIrNqiLSEpmq63wqcnlGOnvcfb575lmq/cJZiyTzh6ugM01+YP
         PJlcUFYSiNkT2E5rNr8ataLsSUze0M4kZYIp3vQsweZJHuGDxi9Rsm1BlCYtWmhIRxMM
         AqWw==
X-Forwarded-Encrypted: i=1; AJvYcCVwb/pxeg/ocoThlYeBVr9VIeuwvasc9sVajx31B/3wKbvb2C2T1Z5gHVYjki+2vOZx0FDYHX79+/AWxqEBkFLa2rvsmHMEBQBroYD6
X-Gm-Message-State: AOJu0YyWttEHKCevcgdfO16Mk/vBJ26wbf0PzADxNwbZG0FXax1tTxN/
	5nDE/z6KFrMu4LX9OOWM0TWYDzcvjLC8oKgb/rsQ5LbxAFjIYOtkEuuGL2zyGw1W1vKdYCVW7vo
	wS8ydFuzM+kwDoqQfBPeIvThyVYs4kQjEzWSn+Bp2vGy3hbDkdG4tMcW8i+lYSA==
X-Received: by 2002:a05:690c:74c5:b0:615:2ed7:59c with SMTP id 00721157ae682-652d8536615mr38031977b3.47.1720147431626;
        Thu, 04 Jul 2024 19:43:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8ZHyYG9kGanBhGzs0UE6fXvMoL92JVnkqylPWvraJrBMpEdWdertJUGpk38GCqR0vItX/9A==
X-Received: by 2002:a05:690c:74c5:b0:615:2ed7:59c with SMTP id 00721157ae682-652d8536615mr38031797b3.47.1720147431304;
        Thu, 04 Jul 2024 19:43:51 -0700 (PDT)
Received: from starship ([2607:fea8:fc01:7b7f:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d69260004sm731430685a.27.2024.07.04.19.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 19:43:51 -0700 (PDT)
Message-ID: <16658367af25852e4bb6abb0caf7c3bc58538db0.camel@redhat.com>
Subject: Re: [PATCH v2 48/49] KVM: x86: Add a macro for features that are
 synthesized into boot_cpu_data
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>,  Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Hou Wenlong
 <houwenlong.hwl@antgroup.com>, Kechen Lu <kechenl@nvidia.com>, Oliver Upton
 <oliver.upton@linux.dev>, Binbin Wu <binbin.wu@linux.intel.com>, Yang
 Weijiang <weijiang.yang@intel.com>, Robert Hoo <robert.hoo.linux@gmail.com>
Date: Thu, 04 Jul 2024 22:43:49 -0400
In-Reply-To: <20240517173926.965351-49-seanjc@google.com>
References: <20240517173926.965351-1-seanjc@google.com>
	 <20240517173926.965351-49-seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Fri, 2024-05-17 at 10:39 -0700, Sean Christopherson wrote:
> Add yet another CPUID macro, this time for features that the host kernel
> synthesizes into boot_cpu_data, i.e. that the kernel force sets even in
> situations where the feature isn't reported by CPUID.  Thanks to the
> macro shenanigans of kvm_cpu_cap_init(), such features can now be handled
> in the core CPUID framework, i.e. don't need to be handled out-of-band and
> thus without as many guardrails.
> 
> Adding a dedicated macro also helps document what's going on, e.g. the
> calls to kvm_cpu_cap_check_and_set() are very confusing unless the reader
> knows exactly how kvm_cpu_cap_init() generates kvm_cpu_caps (and even
> then, it's far from obvious).
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/cpuid.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 0130e0677387..0e64a6332052 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -106,6 +106,17 @@ u32 xstate_required_size(u64 xstate_bv, bool compacted)
>  	F(name);						\
>  })
>  
> +/*
> + * Synthesized Feature - For features that are synthesized into boot_cpu_data,
> + * i.e. may not be present in the raw CPUID, but can still be advertised to
> + * userspace.  Primarily used for mitigation related feature flags.
> + */
> +#define SYN_F(name)						\
> +({								\
> +	kvm_cpu_cap_synthesized |= F(name);			\
> +	F(name);						\
> +})
> +
>  /*
>   * Aliased Features - For features in 0x8000_0001.EDX that are duplicates of
>   * identical 0x1.EDX features, and thus are aliased from 0x1 to 0x8000_0001.
> @@ -727,13 +738,15 @@ do {									\
>  	const struct cpuid_reg cpuid = x86_feature_cpuid(leaf * 32);	\
>  	const u32 __maybe_unused kvm_cpu_cap_init_in_progress = leaf;	\
>  	u32 kvm_cpu_cap_emulated = 0;					\
> +	u32 kvm_cpu_cap_synthesized = 0;				\
>  									\
>  	if (leaf < NCAPINTS)						\
>  		kvm_cpu_caps[leaf] &= (mask);				\
>  	else								\
>  		kvm_cpu_caps[leaf] = (mask);				\
>  									\
> -	kvm_cpu_caps[leaf] &= raw_cpuid_get(cpuid);			\
> +	kvm_cpu_caps[leaf] &= (raw_cpuid_get(cpuid) |			\
> +			       kvm_cpu_cap_synthesized);		\
>  	kvm_cpu_caps[leaf] |= kvm_cpu_cap_emulated;			\
>  } while (0)
>  
> @@ -913,13 +926,10 @@ void kvm_set_cpu_caps(void)
>  	kvm_cpu_cap_init(CPUID_8000_0021_EAX,
>  		F(NO_NESTED_DATA_BP) | F(LFENCE_RDTSC) | 0 /* SmmPgCfgLock */ |
>  		F(NULL_SEL_CLR_BASE) | F(AUTOIBRS) | 0 /* PrefetchCtlMsr */ |
> -		F(WRMSR_XX_BASE_NS)
> +		F(WRMSR_XX_BASE_NS) | SYN_F(SBPB) | SYN_F(IBPB_BRTYPE) |
> +		SYN_F(SRSO_NO)
>  	);
>  
> -	kvm_cpu_cap_check_and_set(X86_FEATURE_SBPB);
> -	kvm_cpu_cap_check_and_set(X86_FEATURE_IBPB_BRTYPE);
> -	kvm_cpu_cap_check_and_set(X86_FEATURE_SRSO_NO);
> -
>  	kvm_cpu_cap_init(CPUID_8000_0022_EAX,
>  		F(PERFMON_V2)
>  	);


Hi,

Now that you added the final F_* macro, let's list all of them:


#define F(name)							\

/* Scattered Flag - For features that are scattered by cpufeatures.h. */
#define SF(name)						\



/* Features that KVM supports only on 64-bit kernels. */
#define X86_64_F(name)						\

/*
 * Raw Feature - For features that KVM supports based purely on raw host CPUID,
 * i.e. that KVM virtualizes even if the host kernel doesn't use the feature.
 * Simply force set the feature in KVM's capabilities, raw CPUID support will
 * be factored in by __kvm_cpu_cap_mask().
 */
#define RAW_F(name)						\

/*
 * Emulated Feature - For features that KVM emulates in software irrespective
 * of host CPU/kernel support.
 */
#define EMUL_F(name)						\

/*
 * Synthesized Feature - For features that are synthesized into boot_cpu_data,
 * i.e. may not be present in the raw CPUID, but can still be advertised to
 * userspace.  Primarily used for mitigation related feature flags.
 */
#define SYN_F(name)						\

/*
 * Aliased Features - For features in 0x8000_0001.EDX that are duplicates of
 * identical 0x1.EDX features, and thus are aliased from 0x1 to 0x8000_0001.
 */
#define AF(name)								\

/*
 * VMM Features - For features that KVM "supports" in some capacity, i.e. that
 * KVM may query, but that are never advertised to userspace.  E.g. KVM allows
 * userspace to enumerate MONITOR+MWAIT support to the guest, but the MWAIT
 * feature flag is never advertised to userspace because MONITOR+MWAIT aren't
 * virtualized by hardware, can't be faithfully emulated in software (KVM
 * emulates them as NOPs), and allowing the guest to execute them natively
 * requires enabling a per-VM capability.
 */
#define VMM_F(name)								\


Honestly, I already somewhat lost in what each of those macros means even when reading
the comments, which might indicate that a future reader might also have a 
hard time understanding those.

I now support even more the case of setting each feature bit in a separate statement
as I explained in an earlier patch.

What do you think?


Best regards,
	Maxim Levitsky




