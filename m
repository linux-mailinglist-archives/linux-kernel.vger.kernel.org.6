Return-Path: <linux-kernel+bounces-241799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22337927FBB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 03:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95D2B1F22830
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 01:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B3910A24;
	Fri,  5 Jul 2024 01:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fbsWc1fw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7C1EEB3
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 01:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720142656; cv=none; b=BCdPXX4kON8La0lijlEUw/zgTDFao9ZKZSC5IoZdec6HYKL2S3KEiuNVK9kOeP1z3Tj97BneN/1Rd2Y22gb7BjyrZklDpw8l5ZLOREnSJOVhOjkyuBhnyl5WDwRGEWQ61m7IkdFWVuSo2GEL7npwqSKFsxakuOkuBCd2BMnbo7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720142656; c=relaxed/simple;
	bh=w9puIpS8VMB+MS2zX5V9H6c+crpLlqBpagbnHiU+0kI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iCEDj2d5B+RK4k7xggKkQdSIqqv8uXMXv/lF2eYZ9y8b0hs8uy9Ub88R6+dGUJfXe1nLO1y8hrWQ3MZ9QfqbNcw1+SNYPx3kNAALol2QQ3jiRRtljxUjFLrwCIcPe91OVKAk0Oaz7hb0pBBITEMO0KeY+MlYU3/GPGf/FM1zTKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fbsWc1fw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720142652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HWUJkQMzumL4n+pm05+tGpHfPd7avCXbI9PCl2jnQIY=;
	b=fbsWc1fwP5x1JjD0OPO4q2VQGwyI8AW9Srj2WRhS74cIk7abozpM9w1bnsLoDYKBCMqz02
	AH6i5z7g9opp/7e5UVVuw7heAKAtFtR2OL7DXpbV4ZGs8UZZFsLmUaeFVeAj4hOOyjAj1D
	m/VrE39xXOgagQGX+wGfb8hUVGUyNZQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-6wuChQ-iMcKkHU5X_9ciVA-1; Thu, 04 Jul 2024 21:24:10 -0400
X-MC-Unique: 6wuChQ-iMcKkHU5X_9ciVA-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-79d9ee5e460so128129785a.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 18:24:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720142649; x=1720747449;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HWUJkQMzumL4n+pm05+tGpHfPd7avCXbI9PCl2jnQIY=;
        b=kyF0E52x0Q/Zpj8Vr64i/bDnq4AIrWrNvVwckPE+wcUPes50Osfv2qEZeEM4LZbYUA
         z9mV8zkLWglrG2Ch52xiCYeqJ5TVMk5bH2dcmaOsA7hTIh7o6V1rcj08eXJ19E+u3GYG
         wQkThQb0An6eoLHorFAE3LGUtbjtMF8qllmepIbUeJdBsYZOjdDkNYLR0HS7mDEgPHVX
         KYpCUXPfmORfm9Xu3MqTyMill62PLe81Hlc1ccHGlcu3e8X3epx6TeyARsM6SnEnuQzq
         1flq/VisuHIJ4g8yoFMj0vLs6Pn9HOEZ3IkKKmzQTV/2o+N+FIjgMRcUqosEzctblddd
         IQbg==
X-Forwarded-Encrypted: i=1; AJvYcCU0x3H1SIUHiArXUcJ9lR/SlCFWEuY5N9FiWgicuPeIWPbiX8MuIhEENFtYwD40omwzh2gY3JawJ06zg4ndN0+e14vcs7SuRHHOPrnk
X-Gm-Message-State: AOJu0Yx72b+3OkhHW9GV5ASYn78h51t//rnOnQT2bCXBJNiPxELlEP/0
	3ZDgar9RJufiOuu9DfoetBDcaXHpnfxr+d2znPDHm3aBzNzlQtSB7o38AS1zpXPTl+RquhIdRMq
	StPfpbWBR/FWYaBBD4meXR1IP+twsGqKDcqKylH/PfPC0/5HzragHHiblKc5+gA==
X-Received: by 2002:a05:620a:72a5:b0:797:b88e:f321 with SMTP id af79cd13be357-79eee1dfae6mr356786785a.46.1720142649116;
        Thu, 04 Jul 2024 18:24:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/rH69IVRg6SdAubr8nZ1Vgt6Lj6nCNDF6X5dUK86EQ21eO2yd8XTpgsp7/1C1ANHMurllew==
X-Received: by 2002:a05:620a:72a5:b0:797:b88e:f321 with SMTP id af79cd13be357-79eee1dfae6mr356784085a.46.1720142648624;
        Thu, 04 Jul 2024 18:24:08 -0700 (PDT)
Received: from starship ([2607:fea8:fc01:7b7f:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d69302057sm727709085a.100.2024.07.04.18.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 18:24:08 -0700 (PDT)
Message-ID: <01ec3aeb03b5b56299205eafae0062fba237255a.camel@redhat.com>
Subject: Re: [PATCH v2 20/49] KVM: x86: Rename kvm_cpu_cap_mask() to
 kvm_cpu_cap_init()
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>,  Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Hou Wenlong
 <houwenlong.hwl@antgroup.com>, Kechen Lu <kechenl@nvidia.com>, Oliver Upton
 <oliver.upton@linux.dev>, Binbin Wu <binbin.wu@linux.intel.com>, Yang
 Weijiang <weijiang.yang@intel.com>, Robert Hoo <robert.hoo.linux@gmail.com>
Date: Thu, 04 Jul 2024 21:24:07 -0400
In-Reply-To: <20240517173926.965351-21-seanjc@google.com>
References: <20240517173926.965351-1-seanjc@google.com>
	 <20240517173926.965351-21-seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Fri, 2024-05-17 at 10:38 -0700, Sean Christopherson wrote:
> Rename kvm_cpu_cap_mask() to kvm_cpu_cap_init() in anticipation of merging
> it with kvm_cpu_cap_init_kvm_defined(), and in anticipation of _setting_
> bits in the helper (a future commit will play macro games to set emulated
> feature flags via kvm_cpu_cap_init()).
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/cpuid.c | 36 ++++++++++++++++++------------------
>  1 file changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index a802c09b50ab..5a4d6138c4f1 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -74,7 +74,7 @@ u32 xstate_required_size(u64 xstate_bv, bool compacted)
>   * Raw Feature - For features that KVM supports based purely on raw host CPUID,
>   * i.e. that KVM virtualizes even if the host kernel doesn't use the feature.
>   * Simply force set the feature in KVM's capabilities, raw CPUID support will
> - * be factored in by kvm_cpu_cap_mask().
> + * be factored in by __kvm_cpu_cap_mask().
>   */
>  #define RAW_F(name)						\
>  ({								\
> @@ -619,7 +619,7 @@ static __always_inline void __kvm_cpu_cap_mask(unsigned int leaf)
>  static __always_inline
>  void kvm_cpu_cap_init_kvm_defined(enum kvm_only_cpuid_leafs leaf, u32 mask)
>  {
> -	/* Use kvm_cpu_cap_mask for leafs that aren't KVM-only. */
> +	/* Use kvm_cpu_cap_init for leafs that aren't KVM-only. */
>  	BUILD_BUG_ON(leaf < NCAPINTS);
>  
>  	kvm_cpu_caps[leaf] = mask;
> @@ -627,7 +627,7 @@ void kvm_cpu_cap_init_kvm_defined(enum kvm_only_cpuid_leafs leaf, u32 mask)
>  	__kvm_cpu_cap_mask(leaf);
>  }
>  
> -static __always_inline void kvm_cpu_cap_mask(enum cpuid_leafs leaf, u32 mask)
> +static __always_inline void kvm_cpu_cap_init(enum cpuid_leafs leaf, u32 mask)
>  {
>  	/* Use kvm_cpu_cap_init_kvm_defined for KVM-only leafs. */
>  	BUILD_BUG_ON(leaf >= NCAPINTS);
> @@ -656,7 +656,7 @@ void kvm_set_cpu_caps(void)
>  	memcpy(&kvm_cpu_caps, &boot_cpu_data.x86_capability,
>  	       sizeof(kvm_cpu_caps) - (NKVMCAPINTS * sizeof(*kvm_cpu_caps)));
>  
> -	kvm_cpu_cap_mask(CPUID_1_ECX,
> +	kvm_cpu_cap_init(CPUID_1_ECX,
>  		/*
>  		 * NOTE: MONITOR (and MWAIT) are emulated as NOP, but *not*
>  		 * advertised to guests via CPUID!
> @@ -673,7 +673,7 @@ void kvm_set_cpu_caps(void)
>  	/* KVM emulates x2apic in software irrespective of host support. */
>  	kvm_cpu_cap_set(X86_FEATURE_X2APIC);
>  
> -	kvm_cpu_cap_mask(CPUID_1_EDX,
> +	kvm_cpu_cap_init(CPUID_1_EDX,
>  		F(FPU) | F(VME) | F(DE) | F(PSE) |
>  		F(TSC) | F(MSR) | F(PAE) | F(MCE) |
>  		F(CX8) | F(APIC) | 0 /* Reserved */ | F(SEP) |
> @@ -684,7 +684,7 @@ void kvm_set_cpu_caps(void)
>  		0 /* HTT, TM, Reserved, PBE */
>  	);
>  
> -	kvm_cpu_cap_mask(CPUID_7_0_EBX,
> +	kvm_cpu_cap_init(CPUID_7_0_EBX,
>  		F(FSGSBASE) | F(SGX) | F(BMI1) | F(HLE) | F(AVX2) |
>  		F(FDP_EXCPTN_ONLY) | F(SMEP) | F(BMI2) | F(ERMS) | F(INVPCID) |
>  		F(RTM) | F(ZERO_FCS_FDS) | 0 /*MPX*/ | F(AVX512F) |
> @@ -693,7 +693,7 @@ void kvm_set_cpu_caps(void)
>  		F(AVX512ER) | F(AVX512CD) | F(SHA_NI) | F(AVX512BW) |
>  		F(AVX512VL));
>  
> -	kvm_cpu_cap_mask(CPUID_7_ECX,
> +	kvm_cpu_cap_init(CPUID_7_ECX,
>  		F(AVX512VBMI) | RAW_F(LA57) | F(PKU) | 0 /*OSPKE*/ | F(RDPID) |
>  		F(AVX512_VPOPCNTDQ) | F(UMIP) | F(AVX512_VBMI2) | F(GFNI) |
>  		F(VAES) | F(VPCLMULQDQ) | F(AVX512_VNNI) | F(AVX512_BITALG) |
> @@ -708,7 +708,7 @@ void kvm_set_cpu_caps(void)
>  	if (!tdp_enabled || !boot_cpu_has(X86_FEATURE_OSPKE))
>  		kvm_cpu_cap_clear(X86_FEATURE_PKU);
>  
> -	kvm_cpu_cap_mask(CPUID_7_EDX,
> +	kvm_cpu_cap_init(CPUID_7_EDX,
>  		F(AVX512_4VNNIW) | F(AVX512_4FMAPS) | F(SPEC_CTRL) |
>  		F(SPEC_CTRL_SSBD) | F(ARCH_CAPABILITIES) | F(INTEL_STIBP) |
>  		F(MD_CLEAR) | F(AVX512_VP2INTERSECT) | F(FSRM) |
> @@ -727,7 +727,7 @@ void kvm_set_cpu_caps(void)
>  	if (boot_cpu_has(X86_FEATURE_AMD_SSBD))
>  		kvm_cpu_cap_set(X86_FEATURE_SPEC_CTRL_SSBD);
>  
> -	kvm_cpu_cap_mask(CPUID_7_1_EAX,
> +	kvm_cpu_cap_init(CPUID_7_1_EAX,
>  		F(AVX_VNNI) | F(AVX512_BF16) | F(CMPCCXADD) |
>  		F(FZRM) | F(FSRS) | F(FSRC) |
>  		F(AMX_FP16) | F(AVX_IFMA) | F(LAM)
> @@ -743,7 +743,7 @@ void kvm_set_cpu_caps(void)
>  		F(BHI_CTRL) | F(MCDT_NO)
>  	);
>  
> -	kvm_cpu_cap_mask(CPUID_D_1_EAX,
> +	kvm_cpu_cap_init(CPUID_D_1_EAX,
>  		F(XSAVEOPT) | F(XSAVEC) | F(XGETBV1) | F(XSAVES) | f_xfd
>  	);
>  
> @@ -751,7 +751,7 @@ void kvm_set_cpu_caps(void)
>  		SF(SGX1) | SF(SGX2) | SF(SGX_EDECCSSA)
>  	);
>  
> -	kvm_cpu_cap_mask(CPUID_8000_0001_ECX,
> +	kvm_cpu_cap_init(CPUID_8000_0001_ECX,
>  		F(LAHF_LM) | F(CMP_LEGACY) | 0 /*SVM*/ | 0 /* ExtApicSpace */ |
>  		F(CR8_LEGACY) | F(ABM) | F(SSE4A) | F(MISALIGNSSE) |
>  		F(3DNOWPREFETCH) | F(OSVW) | 0 /* IBS */ | F(XOP) |
> @@ -759,7 +759,7 @@ void kvm_set_cpu_caps(void)
>  		F(TOPOEXT) | 0 /* PERFCTR_CORE */
>  	);
>  
> -	kvm_cpu_cap_mask(CPUID_8000_0001_EDX,
> +	kvm_cpu_cap_init(CPUID_8000_0001_EDX,
>  		F(FPU) | F(VME) | F(DE) | F(PSE) |
>  		F(TSC) | F(MSR) | F(PAE) | F(MCE) |
>  		F(CX8) | F(APIC) | 0 /* Reserved */ | F(SYSCALL) |
> @@ -777,7 +777,7 @@ void kvm_set_cpu_caps(void)
>  		SF(CONSTANT_TSC)
>  	);
>  
> -	kvm_cpu_cap_mask(CPUID_8000_0008_EBX,
> +	kvm_cpu_cap_init(CPUID_8000_0008_EBX,
>  		F(CLZERO) | F(XSAVEERPTR) |
>  		F(WBNOINVD) | F(AMD_IBPB) | F(AMD_IBRS) | F(AMD_SSBD) | F(VIRT_SSBD) |
>  		F(AMD_SSB_NO) | F(AMD_STIBP) | F(AMD_STIBP_ALWAYS_ON) |
> @@ -811,13 +811,13 @@ void kvm_set_cpu_caps(void)
>  	 * Hide all SVM features by default, SVM will set the cap bits for
>  	 * features it emulates and/or exposes for L1.
>  	 */
> -	kvm_cpu_cap_mask(CPUID_8000_000A_EDX, 0);
> +	kvm_cpu_cap_init(CPUID_8000_000A_EDX, 0);
>  
> -	kvm_cpu_cap_mask(CPUID_8000_001F_EAX,
> +	kvm_cpu_cap_init(CPUID_8000_001F_EAX,
>  		0 /* SME */ | 0 /* SEV */ | 0 /* VM_PAGE_FLUSH */ | 0 /* SEV_ES */ |
>  		F(SME_COHERENT));
>  
> -	kvm_cpu_cap_mask(CPUID_8000_0021_EAX,
> +	kvm_cpu_cap_init(CPUID_8000_0021_EAX,
>  		F(NO_NESTED_DATA_BP) | F(LFENCE_RDTSC) | 0 /* SmmPgCfgLock */ |
>  		F(NULL_SEL_CLR_BASE) | F(AUTOIBRS) | 0 /* PrefetchCtlMsr */ |
>  		F(WRMSR_XX_BASE_NS)
> @@ -837,7 +837,7 @@ void kvm_set_cpu_caps(void)
>  	 * kernel.  LFENCE_RDTSC was a Linux-defined synthetic feature long
>  	 * before AMD joined the bandwagon, e.g. LFENCE is serializing on most
>  	 * CPUs that support SSE2.  On CPUs that don't support AMD's leaf,
> -	 * kvm_cpu_cap_mask() will unfortunately drop the flag due to ANDing
> +	 * kvm_cpu_cap_init() will unfortunately drop the flag due to ANDing
>  	 * the mask with the raw host CPUID, and reporting support in AMD's
>  	 * leaf can make it easier for userspace to detect the feature.
>  	 */
> @@ -847,7 +847,7 @@ void kvm_set_cpu_caps(void)
>  		kvm_cpu_cap_set(X86_FEATURE_NULL_SEL_CLR_BASE);
>  	kvm_cpu_cap_set(X86_FEATURE_NO_SMM_CTL_MSR);
>  
> -	kvm_cpu_cap_mask(CPUID_C000_0001_EDX,
> +	kvm_cpu_cap_init(CPUID_C000_0001_EDX,
>  		F(XSTORE) | F(XSTORE_EN) | F(XCRYPT) | F(XCRYPT_EN) |
>  		F(ACE2) | F(ACE2_EN) | F(PHE) | F(PHE_EN) |
>  		F(PMM) | F(PMM_EN)

Hi,

Not really sure if we need this patch, I see that this patch helped
with renaming things, but IMHO it can be squashed with the relevant patches.

But anyway,

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky


