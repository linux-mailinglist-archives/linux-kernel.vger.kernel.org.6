Return-Path: <linux-kernel+bounces-224799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E01139126FB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E4BD1C25BCC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 13:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7F0EAC2;
	Fri, 21 Jun 2024 13:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bEcB1Dch"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF5B1FB5
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 13:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718977728; cv=none; b=SSC9wO4a4lJYGMLOrZGTOQEVxBiN/zkl40wzTOggac4csLpzRtYSVsjhDqvikTrjH9wh2erzMfGFyhgymP62+jqkzOTQ/pRXpsreeJpwqaQOKYDk/r3kGM/1EeKLfqF1JdF7GZTaWNiHG0f0cgkjdWEpMeRJVZuCR+7wnb+dJnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718977728; c=relaxed/simple;
	bh=AtF26wu5ITxZOmMyjwHLWmi4RNRt+/mPchc574Gfba0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KEMLHqKg2o2Z1nvMG9garyxo72CW8OM5i0Bms6btED8EyzwdzZ9PmvlAWhJM+9ZEjlwBClTqDCn1PWtecIBYLIQcCdGnyKMfoD3PC33WavL8j631SMxQvknKvG0qD5v+Bcm9i50hT2TGAbo+/7Wc0XANEYeQwoPMTTvyGqazxkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bEcB1Dch; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-df7721f2e70so3950104276.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 06:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718977725; x=1719582525; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xDDye/k9/SNfrM9XoCrmDhP+LFS11J4ZCLTae62jGvM=;
        b=bEcB1DchcqDqzju2M4J638owblNZ7ccHGXK/O8L3keSqpOoGulZ+Q8oMTm4OUJvE0W
         JGjHb1OQjz4i2Ye4R1MsN/Il/loF4ok1jLHqttam/C0oA7OeBkHnnR3H2BJPCjGwyb7B
         F2t2EILtdSR5kMGONs4tKiGHDpQg/jBypq2UPtMMOYg//d39Wo0dKc2MyNEpzAccphH6
         +nTJSgHMMrqbFrxbVJ45Je/YWHpvdG+QP+Tx/Ft+hIkxpw4L0aGc+13f89+0mpxQcdYA
         l+wZi7ajr9F3IoNKJ8HoRklM1hhVgjqRrcgfm7z9cq4rTqyddYWO8BQoSFsne1WcVkcm
         a3dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718977725; x=1719582525;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xDDye/k9/SNfrM9XoCrmDhP+LFS11J4ZCLTae62jGvM=;
        b=c87bGKi+balmQjw2r8w2JiiR8Ibf5JcUQFkWwMTOmPvweoKrtgi4GpfLJBcBA0z/NV
         X33VJZb4OgMm8RxUYiUynQW46juWmEfgdUOOZD+lD863JCe79DK0q0xIdP0xTER0aIJy
         2R16Uaa2tnVVCVAeocE0OulLfoF7KdnyJWI3wGfxrGfDBs2Qg/ZgD+UXAPKBVce6frl7
         /DeOpApWAnMM7EA58e/XYxGaIGxgV99BW7gfUaUNmzx4F+1BzQ3BIwpnXil9IeWF596S
         PFjtmGGgPJ217SbSNPTuiPzZySS1zAfXCSsT2vL3yOExFsNhXDCjdhptHDTcp6pREP1f
         M3/A==
X-Forwarded-Encrypted: i=1; AJvYcCUv9VPaPrCUB2L7M4nzFjjHoTasLqttYe1opVFYLTEP//8pVrDEi5VlAQqcyz7XQRjtDJwfhyi6EmZmEeQYBnaDn9jHarFfW1mBJdCI
X-Gm-Message-State: AOJu0YxDEfuolYW/PJKOvh5uGsycY/8Jn55gxzWYt+W3j+q0CmyaCImQ
	oCL7vOKhjBOeaDe52MUKSAi6EbuFXoca8FEk35iiDnljLy67GT4HMy+Z7cgtVIbqSBF/sSNtbMS
	wQg==
X-Google-Smtp-Source: AGHT+IEaeDMKYP+oZ4yMiooXp15i8OqFIPHPpI4Wq8AdBiUZOqVliGDQhA+kWAKZISxz+6sCeBULcy63Vr4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1502:b0:dfa:ff27:db9 with SMTP id
 3f1490d57ef6-e02be2e9dd4mr1632880276.5.1718977725069; Fri, 21 Jun 2024
 06:48:45 -0700 (PDT)
Date: Fri, 21 Jun 2024 06:48:43 -0700
In-Reply-To: <4b57f565-25b0-4b97-ac78-4913a8b1d225@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240619182128.4131355-1-dapeng1.mi@linux.intel.com>
 <20240619182128.4131355-2-dapeng1.mi@linux.intel.com> <ZnRV6XrKkVwZB2TN@google.com>
 <4b57f565-25b0-4b97-ac78-4913a8b1d225@linux.intel.com>
Message-ID: <ZnWEu13z3XOB4wjY@google.com>
Subject: Re: [PATCH 1/2] KVM: x86/pmu: Define KVM_PMC_MAX_GENERIC for platform independence
From: Sean Christopherson <seanjc@google.com>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, Mingwei Zhang <mizhang@google.com>, 
	Xiong Zhang <xiong.y.zhang@intel.com>, Zhenyu Wang <zhenyuw@linux.intel.com>, 
	Like Xu <like.xu.linux@gmail.com>, Jinrong Liang <cloudliang@tencent.com>, 
	Dapeng Mi <dapeng1.mi@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Jun 21, 2024, Dapeng Mi wrote:
> >> diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
> >> index 6e908bdc3310..2fca247798eb 100644
> >> --- a/arch/x86/kvm/svm/pmu.c
> >> +++ b/arch/x86/kvm/svm/pmu.c
> >> @@ -218,7 +218,7 @@ static void amd_pmu_init(struct kvm_vcpu *vcpu)
> >>  	int i;
> >>  
> >>  	BUILD_BUG_ON(KVM_AMD_PMC_MAX_GENERIC > AMD64_NUM_COUNTERS_CORE);
> >> -	BUILD_BUG_ON(KVM_AMD_PMC_MAX_GENERIC > INTEL_PMC_MAX_GENERIC);
> >> +	BUILD_BUG_ON(KVM_AMD_PMC_MAX_GENERIC > KVM_PMC_MAX_GENERIC);
> >>  
> >>  	for (i = 0; i < KVM_AMD_PMC_MAX_GENERIC ; i++) {
> >>  		pmu->gp_counters[i].type = KVM_PMC_GP;
> >> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> >> index fb5cbd6cbeff..a4b0bee04596 100644
> >> --- a/arch/x86/kvm/vmx/pmu_intel.c
> >> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> >> @@ -570,6 +570,8 @@ static void intel_pmu_init(struct kvm_vcpu *vcpu)
> >>  	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
> >>  	struct lbr_desc *lbr_desc = vcpu_to_lbr_desc(vcpu);
> >>  
> >> +	BUILD_BUG_ON(KVM_INTEL_PMC_MAX_GENERIC > KVM_PMC_MAX_GENERIC);
> > Rather than BUILD_BUG_ON() for both Intel and AMD, can't we just do?
> >
> > #define KVM_MAX_NR_GP_COUNTERS max(KVM_INTEL_PMC_MAX_GENERIC, KVM_AMD_PMC_MAX_GENERIC)
> 
> Actually I tried this, but compiler would report the below error since
> KVM_PMC_MAX_GENERIC would used to define the array
> gp_counters[KVM_PMC_MAX_GENERIC];
> 
> ./include/linux/minmax.h:48:50: error: braced-group within expression
> allowed only inside a function

Oh, right, the min/max macros are super fancy to deal with types.  How about this
(getting there over 2-3 patches)?

I don't love the "#define MAX", but I don't see a better option.  I suppose maybe
we should use __MAX or KVM_MAX since kvm_host.h is likely included outside of KVM?

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 5c0415899a07..ce0c9191eb85 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -532,13 +532,18 @@ struct kvm_pmc {
        u64 current_config;
 };
 
+#define MAX(a, b) ((a) >= (b) ? (a) : (b))
+
 /* More counters may conflict with other existing Architectural MSRs */
-#define KVM_INTEL_PMC_MAX_GENERIC      8
-#define MSR_ARCH_PERFMON_PERFCTR_MAX   (MSR_ARCH_PERFMON_PERFCTR0 + KVM_INTEL_PMC_MAX_GENERIC - 1)
-#define MSR_ARCH_PERFMON_EVENTSEL_MAX  (MSR_ARCH_PERFMON_EVENTSEL0 + KVM_INTEL_PMC_MAX_GENERIC - 1)
-#define KVM_PMC_MAX_FIXED      3
-#define MSR_ARCH_PERFMON_FIXED_CTR_MAX (MSR_ARCH_PERFMON_FIXED_CTR0 + KVM_PMC_MAX_FIXED - 1)
-#define KVM_AMD_PMC_MAX_GENERIC        6
+#define KVM_MAX_NR_INTEL_GP_COUNTERS   8
+#define KVM_MAX_NR_AMD_GP_COUNTERS     6
+#define KVM_MAX_NR_GP_COUNTERS         MAX(KVM_MAX_NR_INTEL_GP_COUNTERS, \
+                                           KVM_MAX_NR_AMD_GP_COUNTERS)
+
+#define KVM_MAX_NR_INTEL_FIXED_COUTNERS        3
+#define KVM_MAX_NR_AMD_FIXED_COUTNERS  0
+#define KVM_MAX_NR_FIXED_COUNTERS      MAX(KVM_MAX_NR_INTEL_FIXED_COUTNERS, \
+                                           KVM_MAX_NR_AMD_FIXED_COUTNERS)
 
 struct kvm_pmu {
        u8 version;
@@ -554,8 +559,8 @@ struct kvm_pmu {
        u64 global_status_rsvd;
        u64 reserved_bits;
        u64 raw_event_mask;
-       struct kvm_pmc gp_counters[KVM_INTEL_PMC_MAX_GENERIC];
-       struct kvm_pmc fixed_counters[KVM_PMC_MAX_FIXED];
+       struct kvm_pmc gp_counters[KVM_MAX_NR_GP_COUNTERS];
+       struct kvm_pmc fixed_counters[KVM_MAX_NR_FIXED_COUNTERS];
 
        /*
         * Overlay the bitmap with a 64-bit atomic so that all bits can be

