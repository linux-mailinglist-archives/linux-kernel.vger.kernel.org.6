Return-Path: <linux-kernel+bounces-223011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 711A0910BC3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 18:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDD0B1F22A98
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 16:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DAF61B1506;
	Thu, 20 Jun 2024 16:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C0e008+T"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B779015B0E5
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 16:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718900205; cv=none; b=GrIThWI4uwOEKVOsA1SXWTKw/wM8Xuis+znKd2JS8fUcHSmCP6KCZdzbGFvEjeESnDevFL7FzEstltuQxnTGq1/oxrfuuP+oGLMmSZnNUH7tx2uvo9qucOTUShy5pJ3J65F1s2yRaI24j6sUcBrSxBydhSDXLAGZcmVbpmy5tA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718900205; c=relaxed/simple;
	bh=3F25YNJFqKhy4bYsXBenLOYPz74lQQHcEZxBGefIBRw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jGGJ9R6iOshgGtCW8DavGH3u9/N4TfhNIniklz5xB0Wtq4erq5po7ESjyxqq4qV/d6fSGp59jleTDmAgeDgjzrLyzPlcruYDqOlWtlER/QE2V0wqLFtukqRVWeKSubN+xjWNeivMmCOc+t3JCq/imZSfmPsKjstT7zy/dq0w5Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C0e008+T; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-63bab20b9f4so16663467b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 09:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718900203; x=1719505003; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BCZKNDHzfJBJVhIBZvZUEBrTAzEooayjC9bbFQcCP8A=;
        b=C0e008+T5bVLspMJrKa2RUGHNY7Br9p/8ytOj93JwAgxKIT58c4P9DmV5T1VALFb2c
         lDUdSEdMfLsGLkiQ6LRthy0mLN7u3HyHpJ5eb8XsvVt0crl33e3vAbTZx9seq/tP0U0g
         td3wkRjfsMwj5r2D8Gt8jVO6Q/3oLGkcE11Z5siumCeH30FIxfmL/qZNaFLfGWlSyLoe
         3uDQfCkMeVTARk9yqLuyBx4UPPXgTYWGrwS0+ENoT9etQVSKVYnQ7//VaUrQ80dgCZzN
         5JjUA4WLd76rtKZb6aZUMfJPXnzZ2kjz3X/hLdK6EVaW49UgZbFULS0qun6p/QnPIoYQ
         jUrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718900203; x=1719505003;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BCZKNDHzfJBJVhIBZvZUEBrTAzEooayjC9bbFQcCP8A=;
        b=YQQYeg9ycWz/4EhvPDflRu2WmtN2o6ne0gIZsdOOFLEWrPRfA42CKB+XLzOtRvcIHi
         8Np/zM1ehEDmoJWgJufJVsIhOXI9JvF6kHTVFxhiZfqIapIfLpZdoMD9LHJdNMxxOi2Q
         01IAeMkecnS2xix6n9OFiSgv560fmgq53qgPr5qHwrltp7kRs0XELBbslmnPe37mQ+Ny
         QqrrGVolOJQtrQW5mjhNfKC5dP4Dm4Ajzjjqvjmp8I8LTRvglFOXYNtB2rRYnszzK6WD
         9a9b5XNhyTYZkhp14+V3b8x0eGYa9kVpxi989yhyHPPvkmXhAtM+iv2EOaB2DWmwULfv
         V4CQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVnkXY5D+6YrVwALhrhc1qp52pSCyFVeHovlwW3aE3DDL3mkRPNS3jJviUi1srgAoumcWmIdoO0ZJ3ogMbaCY61P1zTluHoijAfee9
X-Gm-Message-State: AOJu0Yz9a3hiBV1TWb039rHHfH8DJiDti3wTWjAKmOZH6YO1JsCJZZ8H
	KdgZ4D6NnKGJo8M+UAP6u26wLI+Bv8BkDFLy5IM3wrSnoDPz8RbmPqNb6V7VoExTkdRi8cLsk3e
	mhg==
X-Google-Smtp-Source: AGHT+IHAW5Cu6uLeC2DeFrvw8mg2Wa8Sr6zlHDRn6IX74FBYp/Cbjsm3VmzOc1NPaMgFbVqucolfGz2nfUI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:ab33:0:b0:df4:d6ca:fed0 with SMTP id
 3f1490d57ef6-e02be133adfmr219127276.4.1718900202676; Thu, 20 Jun 2024
 09:16:42 -0700 (PDT)
Date: Thu, 20 Jun 2024 09:16:41 -0700
In-Reply-To: <20240619182128.4131355-2-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240619182128.4131355-1-dapeng1.mi@linux.intel.com> <20240619182128.4131355-2-dapeng1.mi@linux.intel.com>
Message-ID: <ZnRV6XrKkVwZB2TN@google.com>
Subject: Re: [PATCH 1/2] KVM: x86/pmu: Define KVM_PMC_MAX_GENERIC for platform independence
From: Sean Christopherson <seanjc@google.com>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, Mingwei Zhang <mizhang@google.com>, 
	Xiong Zhang <xiong.y.zhang@intel.com>, Zhenyu Wang <zhenyuw@linux.intel.com>, 
	Like Xu <like.xu.linux@gmail.com>, Jinrong Liang <cloudliang@tencent.com>, 
	Dapeng Mi <dapeng1.mi@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Jun 20, 2024, Dapeng Mi wrote:
> The existing macro, KVM_INTEL_PMC_MAX_GENERIC, ambiguously represents the
> maximum supported General Purpose (GP) counter number for both Intel and
> AMD platforms. This could lead to issues if AMD begins to support more GP
> counters than Intel.
> 
> To resolve this, a new platform-independent macro, KVM_PMC_MAX_GENERIC,
> is introduced to represent the maximum GP counter number across all x86
> platforms.
> 
> No logic changes are introduced in this patch.
> 
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  arch/x86/include/asm/kvm_host.h | 9 +++++----
>  arch/x86/kvm/svm/pmu.c          | 2 +-
>  arch/x86/kvm/vmx/pmu_intel.c    | 2 ++
>  3 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 57440bda4dc4..18137be6504a 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -534,11 +534,12 @@ struct kvm_pmc {
>  
>  /* More counters may conflict with other existing Architectural MSRs */
>  #define KVM_INTEL_PMC_MAX_GENERIC	8
> -#define MSR_ARCH_PERFMON_PERFCTR_MAX	(MSR_ARCH_PERFMON_PERFCTR0 + KVM_INTEL_PMC_MAX_GENERIC - 1)
> -#define MSR_ARCH_PERFMON_EVENTSEL_MAX	(MSR_ARCH_PERFMON_EVENTSEL0 + KVM_INTEL_PMC_MAX_GENERIC - 1)
> +#define KVM_AMD_PMC_MAX_GENERIC	6
> +#define KVM_PMC_MAX_GENERIC		KVM_INTEL_PMC_MAX_GENERIC

Since we're changing the macro, maybe take the opportunity to use a better name?
E.g. KVM_MAX_NR_GP_COUNTERS?  And then in a follow-up patch, give fixed counters
the same treatment, e.g. KVM_MAX_NR_FIXED_COUNTERS.  Or maybe KVM_MAX_NR_GP_PMCS
and KVM_MAX_NR_FIXED_PMCS?

> +#define MSR_ARCH_PERFMON_PERFCTR_MAX	(MSR_ARCH_PERFMON_PERFCTR0 + KVM_PMC_MAX_GENERIC - 1)
> +#define MSR_ARCH_PERFMON_EVENTSEL_MAX	(MSR_ARCH_PERFMON_EVENTSEL0 + KVM_PMC_MAX_GENERIC - 1)

And I'm very, very tempted to say we should simply delete these two, along with
MSR_ARCH_PERFMON_FIXED_CTR_MAX, and just open code the "end" MSR in the one user.
Especially since "KVM" doesn't appear anyone in the name, i.e. because the names
misrepresent KVM's semi-arbitrary max as the *architectural* max.

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 6ad19d913d31..547dfe40d017 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7432,17 +7432,20 @@ static void kvm_probe_msr_to_save(u32 msr_index)
                     intel_pt_validate_hw_cap(PT_CAP_num_address_ranges) * 2))
                        return;
                break;
-       case MSR_ARCH_PERFMON_PERFCTR0 ... MSR_ARCH_PERFMON_PERFCTR_MAX:
+       case MSR_ARCH_PERFMON_PERFCTR0 ...
+            MSR_ARCH_PERFMON_PERFCTR0 + KVM_MAX_NR_GP_COUNTERS - 1:
                if (msr_index - MSR_ARCH_PERFMON_PERFCTR0 >=
                    kvm_pmu_cap.num_counters_gp)
                        return;
                break;
-       case MSR_ARCH_PERFMON_EVENTSEL0 ... MSR_ARCH_PERFMON_EVENTSEL_MAX:
+       case MSR_ARCH_PERFMON_EVENTSEL0 ...
+            MSR_ARCH_PERFMON_EVENTSEL0 + KVM_MAX_NR_GP_COUNTERS - 1:
                if (msr_index - MSR_ARCH_PERFMON_EVENTSEL0 >=
                    kvm_pmu_cap.num_counters_gp)
                        return;
                break;
-       case MSR_ARCH_PERFMON_FIXED_CTR0 ... MSR_ARCH_PERFMON_FIXED_CTR_MAX:
+       case MSR_ARCH_PERFMON_FIXED_CTR0 ...
+            MSR_ARCH_PERFMON_FIXED_CTR0 + KVM_MAR_NR_FIXED_COUNTERS - 1:
                if (msr_index - MSR_ARCH_PERFMON_FIXED_CTR0 >=
                    kvm_pmu_cap.num_counters_fixed)
                        return;

>  #define KVM_PMC_MAX_FIXED	3
>  #define MSR_ARCH_PERFMON_FIXED_CTR_MAX	(MSR_ARCH_PERFMON_FIXED_CTR0 + KVM_PMC_MAX_FIXED - 1)
> -#define KVM_AMD_PMC_MAX_GENERIC	6
>  
>  struct kvm_pmu {
>  	u8 version;
> @@ -554,7 +555,7 @@ struct kvm_pmu {
>  	u64 global_status_rsvd;
>  	u64 reserved_bits;
>  	u64 raw_event_mask;
> -	struct kvm_pmc gp_counters[KVM_INTEL_PMC_MAX_GENERIC];
> +	struct kvm_pmc gp_counters[KVM_PMC_MAX_GENERIC];
>  	struct kvm_pmc fixed_counters[KVM_PMC_MAX_FIXED];
>  
>  	/*
> diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
> index 6e908bdc3310..2fca247798eb 100644
> --- a/arch/x86/kvm/svm/pmu.c
> +++ b/arch/x86/kvm/svm/pmu.c
> @@ -218,7 +218,7 @@ static void amd_pmu_init(struct kvm_vcpu *vcpu)
>  	int i;
>  
>  	BUILD_BUG_ON(KVM_AMD_PMC_MAX_GENERIC > AMD64_NUM_COUNTERS_CORE);
> -	BUILD_BUG_ON(KVM_AMD_PMC_MAX_GENERIC > INTEL_PMC_MAX_GENERIC);
> +	BUILD_BUG_ON(KVM_AMD_PMC_MAX_GENERIC > KVM_PMC_MAX_GENERIC);
>  
>  	for (i = 0; i < KVM_AMD_PMC_MAX_GENERIC ; i++) {
>  		pmu->gp_counters[i].type = KVM_PMC_GP;
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index fb5cbd6cbeff..a4b0bee04596 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -570,6 +570,8 @@ static void intel_pmu_init(struct kvm_vcpu *vcpu)
>  	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
>  	struct lbr_desc *lbr_desc = vcpu_to_lbr_desc(vcpu);
>  
> +	BUILD_BUG_ON(KVM_INTEL_PMC_MAX_GENERIC > KVM_PMC_MAX_GENERIC);

Rather than BUILD_BUG_ON() for both Intel and AMD, can't we just do?

#define KVM_MAX_NR_GP_COUNTERS max(KVM_INTEL_PMC_MAX_GENERIC, KVM_AMD_PMC_MAX_GENERIC)

> +
>  	for (i = 0; i < KVM_INTEL_PMC_MAX_GENERIC; i++) {
>  		pmu->gp_counters[i].type = KVM_PMC_GP;
>  		pmu->gp_counters[i].vcpu = vcpu;
> -- 
> 2.34.1
> 

