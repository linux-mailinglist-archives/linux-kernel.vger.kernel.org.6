Return-Path: <linux-kernel+bounces-414248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 178CB9D253D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 13:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCDDD282166
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 12:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285981CC152;
	Tue, 19 Nov 2024 12:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CCGW1Bmz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E98D1C9EDA
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 12:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732017936; cv=none; b=ByuzAcVCzwaNuqgTNYCJyw710XWPqzpXOotKjqPVe9H9qkNY4EdbgwxUW17b5YdVuirx7+nHaFcDsfUQ9YrHhIj25/6lZexbcZyKgbIS7C0op2Pfj/Ih3HWQVORrKNrApoW2ogWGUqqetDzFMVOII8iESq+ks/lZaeW4YF99W90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732017936; c=relaxed/simple;
	bh=HUzUhlo4obo2rgQavh6//YXocBjmo3RQfe35v1d8GYc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jL/fMB41MYhE+807g6S4LwcguCZsuibUciKsQ2Zx6QCpYTNXvykaoumh2O49B9rx5kALs5xAXTIAgJG55UosYCuYs1DmryVXsDIeS5PuZQBpSPPS2KvrA/RiSkkpvFnaAeJbKCiJdy3cQ7UKfnX9A6OVu8DN1Kvm1znzFMXFOsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CCGW1Bmz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732017933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r5XAlYK9G+UByY8zrOG+zpDqJcr9VNWUezYHjakCW+k=;
	b=CCGW1Bmz4BaeCm8A7U6YYNuFOSA82+6cRR2hwTnAIp4+8c191QsAKSefLRg2seXiPVTqwC
	lKClx0+ks0LCF5rY/uzQ601CQG5oJrT0KO+MpOqEHbxyA4Kv2/KFAfs8hHmxHOLpB+GLcR
	Ot+BtE/I3tR7XpPvHDVu+kziQGsUias=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-Tk_IsFxBMdKdU_xsysEZ0Q-1; Tue, 19 Nov 2024 07:05:32 -0500
X-MC-Unique: Tk_IsFxBMdKdU_xsysEZ0Q-1
X-Mimecast-MFC-AGG-ID: Tk_IsFxBMdKdU_xsysEZ0Q
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-382357b294aso437213f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 04:05:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732017931; x=1732622731;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r5XAlYK9G+UByY8zrOG+zpDqJcr9VNWUezYHjakCW+k=;
        b=vdUD+1MOMHwBwx3fkryguvfsW+zVnMEhnKn03M2YhO0oqIrU5+B3BWoRxp8sOFOYWB
         U2n9S0HAuLoiVxLxVSi2SWEeSTcMNUo1UnLVavU+f5gWOoljKw7q1Pb/aaNxc3fSoA85
         SEjJYqEABWooBpQSYFjh17hZuDL6rYcRGjtXqUqTjGD/IWoqMgUvMNSl0LkiimlXasSZ
         DsvjSfaFbls7bStRmdZRsgrXsdOv4xJ7JKw15H+UjjAJkk7lE/0xbGm5YithqMv2FH77
         Kao3SbglQLTw1VNKkxkYLsATQMX+N6a2mwR5B60Yg6oQbly/ngpSa7Eytw37JJBUfbIB
         BNJA==
X-Forwarded-Encrypted: i=1; AJvYcCUmswxGljw4/uX8UkqhDPG7VzUj7oSp2VMHIeZKvybs8eM6dON933lVbiGebclyPHNKyelYRN6KGgJWiYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfJTNB/OC/EanHkezmgALKAurXhP7CG83gO/YZrkr5ZtrldGxI
	KtnOY/biGajc/bCa+2gFjW7obj53pCvZ3s1KOWNTcSaNyxAF5od8VHoUklE0TS9OmXhEDfmTTZA
	IuBFKXzrZiFhtTy5/s4O8mZmxBjoE1wtngdL/4OsVg9P8sNyAXmneyWenRtI6hw==
X-Received: by 2002:a5d:47aa:0:b0:382:4145:d3a9 with SMTP id ffacd0b85a97d-3824145d6c8mr6389012f8f.25.1732017929277;
        Tue, 19 Nov 2024 04:05:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGV88RlxJ2SuUdlt2AZ7f8Jry84rlRwH9+6QGoZcrIl9Y+yoRyevy4w3JjfFQVDOuci1H1Wlw==
X-Received: by 2002:a5d:47aa:0:b0:382:4145:d3a9 with SMTP id ffacd0b85a97d-3824145d6c8mr6388908f8f.25.1732017927403;
        Tue, 19 Nov 2024 04:05:27 -0800 (PST)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38244220183sm7033141f8f.99.2024.11.19.04.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 04:05:26 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Sean Christopherson <seanjc@google.com>, Sean Christopherson
 <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Maxim Levitsky
 <mlevitsk@redhat.com>
Subject: Re: [PATCH] Revert "KVM: VMX: Move LOAD_IA32_PERF_GLOBAL_CTRL
 errata handling out of setup_vmcs_config()"
In-Reply-To: <20241119011433.1797921-1-seanjc@google.com>
References: <20241119011433.1797921-1-seanjc@google.com>
Date: Tue, 19 Nov 2024 13:05:25 +0100
Message-ID: <875xoj5sze.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sean Christopherson <seanjc@google.com> writes:

> Revert back to clearing VM_{ENTRY,EXIT}_LOAD_IA32_PERF_GLOBAL_CTRL in KVM's
> golden VMCS config, as applying the workaround during vCPU creation is
> pointless and broken.  KVM *unconditionally* clears the controls in the
> values returned by vmx_vmentry_ctrl() and vmx_vmexit_ctrl(), as KVM loads
> PERF_GLOBAL_CTRL if and only if its necessary to do so.  E.g. if KVM wants
> to run the guest with the same PERF_GLOBAL_CTRL as the host, then there's
> no need to re-load the MSR on entry and exit.

Agreed with 'pointless' part ...

>
> Even worse, the buggy commit failed to apply the erratum where it's
> actually needed, add_atomic_switch_msr().  As a result, KVM completely
> ignores the erratum for all intents and purposes, i.e. uses the flawed
> VMCS controls to load PERF_GLOBAL_CTRL.

... and with 'broken'. I think the original commit was never tested on
these old CPUs which need it in the first place.

>
> To top things off, the patch was intended to be dropped, as the premise
> of an L1 VMM being able to pivot on FMS is flawed, and KVM can (and now
> does) fully emulate the controls in software.  Simply revert the commit,
> as all upstream supported kernels that have the buggy commit should also
> have commit f4c93d1a0e71 ("KVM: nVMX: Always emulate PERF_GLOBAL_CTRL
> VM-Entry/VM-Exit controls"), i.e. the (likely theoretical) live migration
> concern is a complete non-issue.

It seems that both f4c93d1a0e71 and 9d78d6fb186b landed in 6.1. In
theory, the former could've broken some L1s (not necessarily KVMs) by
exposing PERF_GLOBAL_CTRL where it was previously missing but then 
it would've been a VMM problem which doesn't sanitize controls and
passes everything KVM exposes to the guest unfiltered.

>
> Opportunistically drop the manual "kvm: " scope from the warning about
> the erratum, as KVM now uses pr_fmt() to provide the correct scope (v6.1
> kernels and earlier don't, but the erratum only applies to CPUs that are
> 15+ years old; it's not worth a separate patch).
>
> This reverts commit 9d78d6fb186bc4aff41b5d6c4726b76649d3cb53.

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

>
> Link: https://lore.kernel.org/all/YtnZmCutdd5tpUmz@google.com
> Fixes: 9d78d6fb186b ("KVM: VMX: Move LOAD_IA32_PERF_GLOBAL_CTRL errata handling out of setup_vmcs_config()")
> Cc: stable@vger.kernel.org
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: Maxim Levitsky <mlevitsk@redhat.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>
> Found by inspection, verified by hacking cpu_has_perf_global_ctrl_bug() to
> unconditionally return true, and warning if add_atomic_switch_msr_special()
> was called with for PERF_GLOBAL_GTRL.

s,GTRL,CTRL, even though it's below '---' :-)

>
>  arch/x86/kvm/vmx/vmx.c | 54 ++++++++++++++++--------------------------
>  1 file changed, 21 insertions(+), 33 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index d28618e9277e..92fee5e8a3c7 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -2551,28 +2551,6 @@ static bool cpu_has_sgx(void)
>  	return cpuid_eax(0) >= 0x12 && (cpuid_eax(0x12) & BIT(0));
>  }
>  
> -/*
> - * Some cpus support VM_{ENTRY,EXIT}_IA32_PERF_GLOBAL_CTRL but they
> - * can't be used due to errata where VM Exit may incorrectly clear
> - * IA32_PERF_GLOBAL_CTRL[34:32]. Work around the errata by using the
> - * MSR load mechanism to switch IA32_PERF_GLOBAL_CTRL.
> - */
> -static bool cpu_has_perf_global_ctrl_bug(void)
> -{
> -	switch (boot_cpu_data.x86_vfm) {
> -	case INTEL_NEHALEM_EP:	/* AAK155 */
> -	case INTEL_NEHALEM:	/* AAP115 */
> -	case INTEL_WESTMERE:	/* AAT100 */
> -	case INTEL_WESTMERE_EP:	/* BC86,AAY89,BD102 */
> -	case INTEL_NEHALEM_EX:	/* BA97 */
> -		return true;
> -	default:
> -		break;
> -	}
> -
> -	return false;
> -}
> -
>  static int adjust_vmx_controls(u32 ctl_min, u32 ctl_opt, u32 msr, u32 *result)
>  {
>  	u32 vmx_msr_low, vmx_msr_high;
> @@ -2732,6 +2710,27 @@ static int setup_vmcs_config(struct vmcs_config *vmcs_conf,
>  		_vmexit_control &= ~x_ctrl;
>  	}
>  
> +	/*
> +	 * Some cpus support VM_{ENTRY,EXIT}_IA32_PERF_GLOBAL_CTRL but they
> +	 * can't be used due to an errata where VM Exit may incorrectly clear
> +	 * IA32_PERF_GLOBAL_CTRL[34:32].  Workaround the errata by using the
> +	 * MSR load mechanism to switch IA32_PERF_GLOBAL_CTRL.
> +	 */
> +	switch (boot_cpu_data.x86_vfm) {
> +	case INTEL_NEHALEM_EP:	/* AAK155 */
> +	case INTEL_NEHALEM:	/* AAP115 */
> +	case INTEL_WESTMERE:	/* AAT100 */
> +	case INTEL_WESTMERE_EP:	/* BC86,AAY89,BD102 */
> +	case INTEL_NEHALEM_EX:	/* BA97 */
> +		_vmentry_control &= ~VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL;
> +		_vmexit_control &= ~VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL;
> +		pr_warn_once("VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL "
> +			     "does not work properly. Using workaround\n");
> +		break;
> +	default:
> +		break;
> +	}
> +
>  	rdmsrl(MSR_IA32_VMX_BASIC, basic_msr);
>  
>  	/* IA-32 SDM Vol 3B: VMCS size is never greater than 4kB. */
> @@ -4422,9 +4421,6 @@ static u32 vmx_vmentry_ctrl(void)
>  			  VM_ENTRY_LOAD_IA32_EFER |
>  			  VM_ENTRY_IA32E_MODE);
>  
> -	if (cpu_has_perf_global_ctrl_bug())
> -		vmentry_ctrl &= ~VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL;
> -
>  	return vmentry_ctrl;
>  }
>  
> @@ -4442,10 +4438,6 @@ static u32 vmx_vmexit_ctrl(void)
>  	if (vmx_pt_mode_is_system())
>  		vmexit_ctrl &= ~(VM_EXIT_PT_CONCEAL_PIP |
>  				 VM_EXIT_CLEAR_IA32_RTIT_CTL);
> -
> -	if (cpu_has_perf_global_ctrl_bug())
> -		vmexit_ctrl &= ~VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL;
> -
>  	/* Loading of EFER and PERF_GLOBAL_CTRL are toggled dynamically */
>  	return vmexit_ctrl &
>  		~(VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL | VM_EXIT_LOAD_IA32_EFER);
> @@ -8400,10 +8392,6 @@ __init int vmx_hardware_setup(void)
>  	if (setup_vmcs_config(&vmcs_config, &vmx_capability) < 0)
>  		return -EIO;
>  
> -	if (cpu_has_perf_global_ctrl_bug())
> -		pr_warn_once("VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL "
> -			     "does not work properly. Using workaround\n");
> -
>  	if (boot_cpu_has(X86_FEATURE_NX))
>  		kvm_enable_efer_bits(EFER_NX);
>  
>
> base-commit: adc218676eef25575469234709c2d87185ca223a

-- 
Vitaly


