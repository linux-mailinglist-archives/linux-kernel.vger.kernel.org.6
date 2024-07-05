Return-Path: <linux-kernel+bounces-241831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB93928010
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 04:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 200B61C211EE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 02:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D405E1643A;
	Fri,  5 Jul 2024 02:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ULf+euSO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F61ECF
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 02:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720145465; cv=none; b=nc7yqJXgmrMUYui7PzU6C5FE9gTtldaGnx4Ye+LpljDw4Dd6mLJg5ejUZp9xRHOztOCgOmcc2fC7vQPJ2eahncq3VZAUcyNcoLmjV6ztw+EabrcUNMeXH4EWVY3saQliHyXuZXN3JJszkG3Ac9+l+AGXXKsIuF0e3FL5prb9WRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720145465; c=relaxed/simple;
	bh=D47wT4Qe3tN6reUvPqn3NCPXPG+1AeLzeL9l5Wmge3k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qDdd8l+X+lGRcYL3jvkc5BrNdrC23ECtEI/iTH/+Q6j5Iiyo99FLXra1bmIi2rdPwt6N1XV7EwcjOaFEhuKYXQDnMJ53JltheBqRfBimmhMYJXcz7frLQNvxTgh/WfLBL0XpoiULA3RwJAJWi4nuoCR4tNqyiA46G9b7jz6vEs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ULf+euSO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720145461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ipn82/l6JnPfFbue/8rndM0WolihvnS5Ok9q1zni6Bw=;
	b=ULf+euSOyTP1vlsQdRDcwzsn2cezuIqN+b9TCMbOuilA1m8WRyspgSltE/j2qVUEowopge
	PD+DaTTumCGgEsGsIaIZmWSx5ES5H2+ptKtdJxb4RzxD0o33j3JOMOvF4aeWyYH7YT6vtS
	oaBSseltb0X/2hyy5bg+kAmzb9II714=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-Qd8a1H7ZNIqggiDOt4ZPgQ-1; Thu, 04 Jul 2024 22:10:58 -0400
X-MC-Unique: Qd8a1H7ZNIqggiDOt4ZPgQ-1
Received: by mail-yb1-f198.google.com with SMTP id 3f1490d57ef6-e02a4de4f4eso2157732276.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 19:10:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720145457; x=1720750257;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ipn82/l6JnPfFbue/8rndM0WolihvnS5Ok9q1zni6Bw=;
        b=ZYUj7biXIDgl2p+bW7OmDmQMcvokjPnYLKIGvTT3E5AhD1Bq1YD85mcGVEcU8rXECf
         jBV1B13gAIqTm5pa88JJ+7NntaDvBGbJBLzvMEv7b7HIemMG7HBpmK+umdvSrn+D9QUn
         CQ7nk3bU6uqetAHAoruyGtVrp9Ye/JW+TCpMEC/yszFZcDET345LbpktdJywv/aKE2X+
         c0HO2wuGT86wO9NYo9ni2y1q7T++bSaMS4/8/72evQhx6HNbxP16NSAwIDnExCd5B4DG
         le1nCrgT4F9nDgmSqdjZecFb1Qwl/3opHOYluWjnuzrEHK8TKyG1s+1vM1kltxrKOZjj
         hCZw==
X-Forwarded-Encrypted: i=1; AJvYcCW5tiZ4u3f9J3NaHlACGVng+Wc6AnhMGWJiwvgsvNe9MDXRrNTPp+tajNIeItpczsVDDit2AXGsnpECJt0seyXM11djfosNmqOINeGY
X-Gm-Message-State: AOJu0YwftbDjB++l5GDUEldY7PoQ1xwF4E5pMbE5nWjyKySN/8tUrbLQ
	UyjGTQfGR+awVFjL3EBgWKg/Uh53eR38o/k8k7C8geXcHkvGthcKa+mTBzmsUY2AW0lGdycECIy
	JwSRPhqF0gpF9/MtyQOfGq9TjeS6FExfVvjZYHrEtd+JrmXkyIee1+mvj2NRXh313wPUm4A==
X-Received: by 2002:a05:6902:2210:b0:dfa:ebf2:51ab with SMTP id 3f1490d57ef6-e03c19643dfmr3991794276.16.1720145457176;
        Thu, 04 Jul 2024 19:10:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQPObLjsjkQseFeCxWATY/EwMnqAetp+sdQgRfFVFlbYetVr9M80C8N6MpAmXwRZy5O2OFlg==
X-Received: by 2002:a05:6902:2210:b0:dfa:ebf2:51ab with SMTP id 3f1490d57ef6-e03c19643dfmr3991780276.16.1720145456788;
        Thu, 04 Jul 2024 19:10:56 -0700 (PDT)
Received: from starship ([2607:fea8:fc01:7b7f:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b59e5f2123sm68936026d6.99.2024.07.04.19.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 19:10:56 -0700 (PDT)
Message-ID: <34d209d318111677c1cd47ff321cc361bf06bd60.camel@redhat.com>
Subject: Re: [PATCH v2 37/49] KVM: x86: Replace guts of "governed" features
 with comprehensive cpu_caps
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>,  Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Hou Wenlong
 <houwenlong.hwl@antgroup.com>, Kechen Lu <kechenl@nvidia.com>, Oliver Upton
 <oliver.upton@linux.dev>, Binbin Wu <binbin.wu@linux.intel.com>, Yang
 Weijiang <weijiang.yang@intel.com>, Robert Hoo <robert.hoo.linux@gmail.com>
Date: Thu, 04 Jul 2024 22:10:55 -0400
In-Reply-To: <20240517173926.965351-38-seanjc@google.com>
References: <20240517173926.965351-1-seanjc@google.com>
	 <20240517173926.965351-38-seanjc@google.com>
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
> Replace the internals of the governed features framework with a more
> comprehensive "guest CPU capabilities" implementation, i.e. with a guest
> version of kvm_cpu_caps.  Keep the skeleton of governed features around
> for now as vmx_adjust_sec_exec_control() relies on detecting governed
> features to do the right thing for XSAVES, and switching all guest feature
> queries to guest_cpu_cap_has() requires subtle and non-trivial changes,
> i.e. is best done as a standalone change.
> 
> Tracking *all* guest capabilities that KVM cares will allow excising the
> poorly named "governed features" framework, and effectively optimizes all
> KVM queries of guest capabilities, i.e. doesn't require making a
> subjective decision as to whether or not a feature is worth "governing",
> and doesn't require adding the code to do so.
> 
> The cost of tracking all features is currently 92 bytes per vCPU on 64-bit
> kernels: 100 bytes for cpu_caps versus 8 bytes for governed_features.
> That cost is well worth paying even if the only benefit was eliminating
> the "governed features" terminology.  And practically speaking, the real
> cost is zero unless those 92 bytes pushes the size of vcpu_vmx or vcpu_svm
> into a new order-N allocation, and if that happens there are better ways
> to reduce the footprint of kvm_vcpu_arch, e.g. making the PMU and/or MTRR
> state separate allocations.
> 
> Suggested-by: Maxim Levitsky <mlevitsk@redhat.com>
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/include/asm/kvm_host.h | 45 +++++++++++++++++++++------------
>  arch/x86/kvm/cpuid.c            | 14 +++++++---
>  arch/x86/kvm/cpuid.h            | 12 ++++-----
>  arch/x86/kvm/reverse_cpuid.h    | 16 ------------
>  4 files changed, 46 insertions(+), 41 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 3003e99155e7..8840d21ee0b5 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -743,6 +743,22 @@ struct kvm_queued_exception {
>  	bool has_payload;
>  };
>  
> +/*
> + * Hardware-defined CPUID leafs that are either scattered by the kernel or are
> + * unknown to the kernel, but need to be directly used by KVM.  Note, these
> + * word values conflict with the kernel's "bug" caps, but KVM doesn't use those.
> + */
> +enum kvm_only_cpuid_leafs {
> +	CPUID_12_EAX	 = NCAPINTS,
> +	CPUID_7_1_EDX,
> +	CPUID_8000_0007_EDX,
> +	CPUID_8000_0022_EAX,
> +	CPUID_7_2_EDX,
> +	NR_KVM_CPU_CAPS,
> +
> +	NKVMCAPINTS = NR_KVM_CPU_CAPS - NCAPINTS,
> +};
> +
>  struct kvm_vcpu_arch {
>  	/*
>  	 * rip and regs accesses must go through
> @@ -861,23 +877,20 @@ struct kvm_vcpu_arch {
>  	bool is_amd_compatible;
>  
>  	/*
> -	 * FIXME: Drop this macro and use KVM_NR_GOVERNED_FEATURES directly
> -	 * when "struct kvm_vcpu_arch" is no longer defined in an
> -	 * arch/x86/include/asm header.  The max is mostly arbitrary, i.e.
> -	 * can be increased as necessary.
> +	 * cpu_caps holds the effective guest capabilities, i.e. the features
> +	 * the vCPU is allowed to use.  Typically, but not always, features can
> +	 * be used by the guest if and only if both KVM and userspace want to
> +	 * expose the feature to the guest.

Nitpick: Since even the comment mentions this, wouldn't it be better to call this
cpu_effective_caps? or at least cpu_eff_caps, to emphasize that these are indeed
effective capabilities, e.g these that both kvm and userspace support?


> +	 *
> +	 * A common exception is for virtualization holes, i.e. when KVM can't
> +	 * prevent the guest from using a feature, in which case the vCPU "has"
> +	 * the feature regardless of what KVM or userspace desires.
> +	 *
> +	 * Note, features that don't require KVM involvement in any way are
> +	 * NOT enforced/sanitized by KVM, i.e. are taken verbatim from the
> +	 * guest CPUID provided by userspace.
>  	 */
> -#define KVM_MAX_NR_GOVERNED_FEATURES BITS_PER_LONG
> -
> -	/*
> -	 * Track whether or not the guest is allowed to use features that are
> -	 * governed by KVM, where "governed" means KVM needs to manage state
> -	 * and/or explicitly enable the feature in hardware.  Typically, but
> -	 * not always, governed features can be used by the guest if and only
> -	 * if both KVM and userspace want to expose the feature to the guest.
> -	 */
> -	struct {
> -		DECLARE_BITMAP(enabled, KVM_MAX_NR_GOVERNED_FEATURES);
> -	} governed_features;
> +	u32 cpu_caps[NR_KVM_CPU_CAPS];
>  
>  	u64 reserved_gpa_bits;
>  	int maxphyaddr;
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 286abefc93d5..89c506cf649b 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -387,9 +387,7 @@ void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
>  	struct kvm_cpuid_entry2 *best;
>  	bool allow_gbpages;
>  
> -	BUILD_BUG_ON(KVM_NR_GOVERNED_FEATURES > KVM_MAX_NR_GOVERNED_FEATURES);
> -	bitmap_zero(vcpu->arch.governed_features.enabled,
> -		    KVM_MAX_NR_GOVERNED_FEATURES);
> +	memset(vcpu->arch.cpu_caps, 0, sizeof(vcpu->arch.cpu_caps));
>  
>  	kvm_update_cpuid_runtime(vcpu);
>  
> @@ -473,6 +471,7 @@ u64 kvm_vcpu_reserved_gpa_bits_raw(struct kvm_vcpu *vcpu)
>  static int kvm_set_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid_entry2 *e2,
>                          int nent)
>  {
> +	u32 vcpu_caps[NR_KVM_CPU_CAPS];
>  	int r;
>  
>  	/*
> @@ -480,10 +479,18 @@ static int kvm_set_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid_entry2 *e2,
>  	 * order to massage the new entries, e.g. to account for dynamic bits
>  	 * that KVM controls, without clobbering the current guest CPUID, which
>  	 * KVM needs to preserve in order to unwind on failure.
> +	 *
> +	 * Similarly, save the vCPU's current cpu_caps so that the capabilities
> +	 * can be updated alongside the CPUID entries when performing runtime
> +	 * updates.  Full initialization is done if and only if the vCPU hasn't
> +	 * run, i.e. only if userspace is potentially changing CPUID features.
>  	 */
>  	swap(vcpu->arch.cpuid_entries, e2);
>  	swap(vcpu->arch.cpuid_nent, nent);
>  
> +	memcpy(vcpu_caps, vcpu->arch.cpu_caps, sizeof(vcpu_caps));
> +	BUILD_BUG_ON(sizeof(vcpu_caps) != sizeof(vcpu->arch.cpu_caps));
> +
>  	/*
>  	 * KVM does not correctly handle changing guest CPUID after KVM_RUN, as
>  	 * MAXPHYADDR, GBPAGES support, AMD reserved bit behavior, etc.. aren't
> @@ -527,6 +534,7 @@ static int kvm_set_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid_entry2 *e2,
>  	return 0;
>  
>  err:
> +	memcpy(vcpu->arch.cpu_caps, vcpu_caps, sizeof(vcpu_caps));
>  	swap(vcpu->arch.cpuid_entries, e2);
>  	swap(vcpu->arch.cpuid_nent, nent);
>  	return r;
> diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
> index e021681f34ac..ad0168d3aec5 100644
> --- a/arch/x86/kvm/cpuid.h
> +++ b/arch/x86/kvm/cpuid.h
> @@ -259,10 +259,10 @@ static __always_inline bool kvm_is_governed_feature(unsigned int x86_feature)
>  static __always_inline void guest_cpu_cap_set(struct kvm_vcpu *vcpu,
>  					      unsigned int x86_feature)
>  {
> -	BUILD_BUG_ON(!kvm_is_governed_feature(x86_feature));
> +	unsigned int x86_leaf = __feature_leaf(x86_feature);
>  
> -	__set_bit(kvm_governed_feature_index(x86_feature),
> -		  vcpu->arch.governed_features.enabled);
> +	reverse_cpuid_check(x86_leaf);
Indeed, no need for reverse_cpuid_check here, as already mentioned.

> +	vcpu->arch.cpu_caps[x86_leaf] |= __feature_bit(x86_feature);
>  }
>  
>  static __always_inline void guest_cpu_cap_check_and_set(struct kvm_vcpu *vcpu,
> @@ -275,10 +275,10 @@ static __always_inline void guest_cpu_cap_check_and_set(struct kvm_vcpu *vcpu,
>  static __always_inline bool guest_cpu_cap_has(struct kvm_vcpu *vcpu,
>  					      unsigned int x86_feature)
>  {
> -	BUILD_BUG_ON(!kvm_is_governed_feature(x86_feature));
> +	unsigned int x86_leaf = __feature_leaf(x86_feature);
>  
> -	return test_bit(kvm_governed_feature_index(x86_feature),
> -			vcpu->arch.governed_features.enabled);
> +	reverse_cpuid_check(x86_leaf);
> +	return vcpu->arch.cpu_caps[x86_leaf] & __feature_bit(x86_feature);
>  }
>  
>  static inline bool kvm_vcpu_is_legal_cr3(struct kvm_vcpu *vcpu, unsigned long cr3)
> diff --git a/arch/x86/kvm/reverse_cpuid.h b/arch/x86/kvm/reverse_cpuid.h
> index 245f71c16272..63d5735fbc8a 100644
> --- a/arch/x86/kvm/reverse_cpuid.h
> +++ b/arch/x86/kvm/reverse_cpuid.h
> @@ -6,22 +6,6 @@
>  #include <asm/cpufeature.h>
>  #include <asm/cpufeatures.h>
>  
> -/*
> - * Hardware-defined CPUID leafs that are either scattered by the kernel or are
> - * unknown to the kernel, but need to be directly used by KVM.  Note, these
> - * word values conflict with the kernel's "bug" caps, but KVM doesn't use those.
> - */
> -enum kvm_only_cpuid_leafs {
> -	CPUID_12_EAX	 = NCAPINTS,
> -	CPUID_7_1_EDX,
> -	CPUID_8000_0007_EDX,
> -	CPUID_8000_0022_EAX,
> -	CPUID_7_2_EDX,
> -	NR_KVM_CPU_CAPS,
> -
> -	NKVMCAPINTS = NR_KVM_CPU_CAPS - NCAPINTS,
> -};
> -
>  /*
>   * Define a KVM-only feature flag.
>   *


Overall:

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky


