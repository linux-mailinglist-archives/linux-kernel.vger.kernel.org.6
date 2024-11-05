Return-Path: <linux-kernel+bounces-395736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0A69BC23A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 01:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70B301C21F52
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 00:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FF0125B9;
	Tue,  5 Nov 2024 00:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m334x/yC"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9FBF9CF
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 00:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730768244; cv=none; b=nKRthFR0KX/LdPUqS+DjrP1YsVMvJumUSui2lI2vvy4fGC18sz/RRm6W4nchzeY+EZ+B+oNgNdOZB50jwO+NM7eZG83j1IQ4GWBfyZ11oBc6GZ4EBOyFsaXWFUDfjhMGjgifC5sWsgTMaVP9DbqraFqu8TuOUA660JIOEeBDFxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730768244; c=relaxed/simple;
	bh=BJpX4pfx/ovNnecYUQictJY+gL1nnJcyuIouDsHXarg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZF/Eu9m6V3x98X3iNHJc9GxcwvpGYgV5bySPo/wB9eCWRxUW7IYm8b7E/OGPOQiwIeX9jDLFvzESShwzGVqWSnoAtM+XR1U+fYWptlLZ+pQM+FManoFKVaF83eb1lI94d+nq2P1qmACcc5LkKVD7SVnuGyWrhdUyxpFK7YcT/co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m334x/yC; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2e3be80e9f3so4901393a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 16:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730768242; x=1731373042; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qkJZYOAhDKySBCNGmvcff3rFRUfYJQFzs8GPre+BEJg=;
        b=m334x/yCMi1KzEGAxrAKYlec0SCKRceXhn95HQ6QCTLT+z2UOjRbRJ8ilFcTMNTUDD
         9ngiGqKOC6tRh9KXrc+1xlKCsiWN7VEhVhCqlBOdqz1Q505ENm2tjB/U0Zgz/9NeujE2
         YH0x3xbgvmfG8TqTOsaCfqZVBHv94k1pOQWb6V9gUamm1ZLOfdTOfQm2/+eWrDwG5vIf
         FqbJofGAzbBpwBGGYWB0WrQALbm0EjUmwMZc4MtG/EgITXpkLDumxOBGDNU/2FN89jur
         Lz2ltx2hbHiBom8b9uLUr5wAoypyAnUhSGyzkMmsoFMHEeTPphge86zOwjw1AV0LX9iW
         IClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730768242; x=1731373042;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qkJZYOAhDKySBCNGmvcff3rFRUfYJQFzs8GPre+BEJg=;
        b=fE/AcvPYsvvZ71vjEeYtriEumW71jOVW7DuSmRWqvAspQ6HBFGJjrisgu/nqaUS3p5
         59Y4aEH6vcrkMmEMOLQsvHM1wCKV80SRkxwF9fX2GpUfU8JqHg1iTk2szXZw6wnpITqd
         5o5PUY+fsgnhfTgpDM8uDZKtMfd6vB4pmjEyZHGiALiPLxb6e2tOFGa6Fl1khUdVO2Nz
         amNA5RSutK5DReAd04rIUkOUsoLNl46zLHZAxr0Cih9sTll84k9jbmCUtKWcPrLvwFeT
         3fECKJX6+UI7Gqj1lakt4CKl52fB7/euwvk7n+oH2CK44cjtIl7RgTEoY69EnCE8nFTr
         T6Qw==
X-Forwarded-Encrypted: i=1; AJvYcCUhjtgmA4OIeLmxIH1Dw/n5Kgk0AT6zOhIJxGR9P74aPC/N4HLkYo7R1H0FVtNRPRJTq+W1q3f/2AFE0sk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgPghjwYg/7nT89CAuOrluZl99N2e9iSsOUFr3a0X0xLHZ97he
	36gBMQ7hcMD0v2zEwZTXHNIaOACxH8uRygi5V5iCLpNOd1YBtg8hKXl1uXKxudKz1PUWWC9R3cZ
	9ng==
X-Google-Smtp-Source: AGHT+IFfqpmUBlYY9SRfm728D1I4LecfoAO/22H03qb1e8Sg2U28kJsg1kmfgCgpYW+HTiF5uEquq3SVuTU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a17:90b:2551:b0:2e2:9984:802b with SMTP id
 98e67ed59e1d1-2e94c244acfmr107162a91.3.1730768242222; Mon, 04 Nov 2024
 16:57:22 -0800 (PST)
Date: Mon, 4 Nov 2024 16:57:20 -0800
In-Reply-To: <20241104101543.31885-1-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241104101543.31885-1-bp@kernel.org>
Message-ID: <ZyltcHfyCiIXTsHu@google.com>
Subject: Re: [PATCH] x86/bugs: Adjust SRSO mitigation to new features
From: Sean Christopherson <seanjc@google.com>
To: Borislav Petkov <bp@kernel.org>
Cc: X86 ML <x86@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, kvm@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>
Content-Type: text/plain; charset="us-ascii"

scripts/get_maintainer.pl :-)

On Mon, Nov 04, 2024, Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> 
> If the machine has:
> 
>   CPUID Fn8000_0021_EAX[30] (SRSO_USER_KERNEL_NO) -- If this bit is 1, it
>   indicates the CPU is not subject to the SRSO vulnerability across
>   user/kernel boundaries.
> 
> have it fall back to IBPB on VMEXIT only, in the case it is going to run
> VMs:
> 
>   Speculative Return Stack Overflow: CPU user/kernel transitions protected, falling back to IBPB-on-VMEXIT
>   Speculative Return Stack Overflow: Mitigation: IBPB on VMEXIT only
> 
> Then, upon KVM module load

It's not strictly KVM module load, it's when KVM enables virtualization.  E.g.
if userspace clears enable_virt_at_load, the MSR will be toggled every time the
number of VMs goes from 0=>1 and 1=>0.

But why do this in KVM?  E.g. why not set-and-forget in init_amd_zen4()?

> and in case the machine has
> 
>   CPUID Fn8000_0021_EAX[31] (SRSO_MSR_FIX). If this bit is 1, it indicates
>   that software may use MSR BP_CFG[BpSpecReduce] to mitigate SRSO.
> 
> enable this BpSpecReduce bit to mitigate SRSO across guest/host
> boundaries.

Shouldn't these be two separate patches?  AFAICT, while the two are related, there
are no strict dependencies between SRSO_USER_KERNEL_NO and SRSO_MSR_FIX.

> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> ---

...

> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 41786b834b16..d54cd67c8c50 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -799,6 +799,7 @@ void kvm_set_cpu_caps(void)
>  
>  	kvm_cpu_cap_check_and_set(X86_FEATURE_SBPB);
>  	kvm_cpu_cap_check_and_set(X86_FEATURE_IBPB_BRTYPE);
> +	kvm_cpu_cap_check_and_set(X86_FEATURE_SRSO_USER_KERNEL_NO);

If the expectation is that X86_FEATURE_SRSO_USER_KERNEL_NO will only ever come
from hardware, i.e. won't be force-set by the kernel, then I would prefer to set
the bit in the "standard" way

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 41786b834b16..eb65336c2168 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -794,7 +794,7 @@ void kvm_set_cpu_caps(void)
        kvm_cpu_cap_mask(CPUID_8000_0021_EAX,
                F(NO_NESTED_DATA_BP) | F(LFENCE_RDTSC) | 0 /* SmmPgCfgLock */ |
                F(NULL_SEL_CLR_BASE) | F(AUTOIBRS) | 0 /* PrefetchCtlMsr */ |
-               F(WRMSR_XX_BASE_NS)
+               F(WRMSR_XX_BASE_NS) | F(SRSO_USER_KERNEL_NO)
        );
 
        kvm_cpu_cap_check_and_set(X86_FEATURE_SBPB);

The kvm_cpu_cap_check_and_set() trickery is necessary only for features that are
force-set by the kernel, in order to avoid kvm_cpu_cap_mask()'s masking of the
features by actual CPUID.  I'm trying to clean things up to make that more obvious;
hopefully that'll land in 6.14[*].

And advertising X86_FEATURE_SRSO_USER_KERNEL_NO should also be a separate patch,
no?  I.e. 

 1. Use SRSO_USER_KERNEL_NO in the host
 2. Update KVM to advertise SRSO_USER_KERNEL_NO to userspace, i.e. let userspace
    know that it can be enumerate to the guest.
 3. Add support for SRSO_MSR_FIX.

[*] https://lore.kernel.org/all/20240517173926.965351-49-seanjc@google.com

>  	kvm_cpu_cap_check_and_set(X86_FEATURE_SRSO_NO);
>  
>  	kvm_cpu_cap_init_kvm_defined(CPUID_8000_0022_EAX,
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 9df3e1e5ae81..03f29912a638 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -608,6 +608,9 @@ static void svm_disable_virtualization_cpu(void)
>  	kvm_cpu_svm_disable();
>  
>  	amd_pmu_disable_virt();
> +
> +	if (cpu_feature_enabled(X86_FEATURE_SRSO_MSR_FIX))
> +		msr_clear_bit(MSR_ZEN4_BP_CFG, MSR_ZEN4_BP_CFG_BP_SPEC_REDUCE_BIT);

I don't like assuming the state of hardware.  E.g. if MSR_ZEN4_BP_CFG_BP_SPEC_REDUCE_BIT
was already set, then KVM shouldn't clear it.  KVM's usual method of restoring
host MSRs is to snapshot the MSR into "struct kvm_host_values" on module load,
and then restore from there as needed.  But that assumes all CPUs have the same
value, which might not be the case here?

All that said, I'd still prefer that MSR_ZEN4_BP_CFG_BP_SPEC_REDUCE_BIT is set
during boot, unless there's a good reason not to do so.

