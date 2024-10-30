Return-Path: <linux-kernel+bounces-389026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C27B9B67B2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 16:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 848D61F228B5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F42217664;
	Wed, 30 Oct 2024 15:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IonSn0w3"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618BF213EE5
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 15:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730301580; cv=none; b=CvK8py1MXO2AtOgCbf5GbfStWcaECFd73xZ9cf0lAnMeDDK4PnIbtdLE0hMBImkA4kGiInI3cVIjdSZvzTkqSOqGOKD3zxPjHkEqP5qH9BJ3UzG5sMmn2ZSObZlz1LCTODfddDZ/3S7PIyrWszuoHjBP83mMMkXlkzFDYuKblrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730301580; c=relaxed/simple;
	bh=lVq0THqesWrbRDHgaTHhyb2hSQgSbz+MeHe4pFi+xmQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g28VfUGztlX4wZyaumYpAGc0aD1/4YpJWV3/8kNjJM5csZ8JPlmxh5ZseLRHyMQSgvBPKx6jVKFhsoj58VtbpSqfWpp9dlVLsQiSUCG4/EzfN1d8WX2GArrSXkAe5+EzkZBJ/0PNS52sOmBkjz5NX3lRufTa2rs3eFGrMR6S1VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IonSn0w3; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-20c94f450c7so70892395ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 08:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730301578; x=1730906378; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TbmHgHCMHct7ja7tBp7WoUbqZrSZHPEjmtPQJRynpPM=;
        b=IonSn0w300aONPHre/XcEJSO00XY6u2GQrhQxqDEao43UrRjnaXHQOioUMwPGPQTbT
         JomOPUgCpPRolbsUY9wBLjWmZ8ahLMBigULTE5+VNhiXq+3OVECDDb+Qrgra/bKmID0U
         JA1FO2X92nqu4zXsBNDrZ1rhkN5D0rHO19YjeCP3wCyOjLiqzXUdmz4jNM0Q/IsYF+zx
         OO/vokajaaHkwfNU3LmvsTd1nGN1Q1mG2sk4dCMHLys5VTskWXdGVW4JKSVDr0WG5Wed
         DPUfqob1Kp3en/oBSlYzdLdzuBcyVv15DzbT2XU3r9t1vE9Ufxl8kN2xOv9qIanY6GWV
         kMQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730301578; x=1730906378;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TbmHgHCMHct7ja7tBp7WoUbqZrSZHPEjmtPQJRynpPM=;
        b=QdAqI/OlLMFCimA4wnop2syAtG4WXR1qKztHWJU14eWVFrA9IjGivRJRwVZG1bve9U
         d78XtdySjzbC02TOdYZ9xnLpYYdYMKFePyM0RTB7VeQoGitml2GCmYc+qnVfFzG+Gv/x
         T7c6IO0FQ16Sh/P8U7rJHqNeEV5suUKzjsCz7tpQUzD5zOCv2Z5C/3pYPwuztIgxfaXc
         ygeIiZbgSY2hl/BKkZhN2Px05WRnXr6fxL2RERKKJtPqGqWihZ9aHjHurx9HIirLYkmY
         mT6UFHBod4c1aEZbO63xTT+6O1d15UqhlyKPeu+C3gnmsuyLGQsY72g6ec5FuZGsgc0W
         Xw9A==
X-Forwarded-Encrypted: i=1; AJvYcCWy+vVvgdoae327TPe1Y5PqZvIGthf550ir47rmzLvYXrVvGdlq9hKmXhkCuO933MXeUqUsvEVlqhsYekY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxetaFss9rUgPxdCW4JD5lIMX4LtLCFSY/eHxynEs0SSgXZErqS
	J9jVzCVgOGgCy7Q2o6QtveLosA0Jylk+YC0O3+6ueQUMDtoqBWsdK1vShhg8cp0qsYZaJlT0OxJ
	35w==
X-Google-Smtp-Source: AGHT+IHLcmxgumoIUe/OVSD/96C25ogheuF2IbDfRMGBuoerGrc50P/BdVnx8nqn1BifYZyjbSILHmecuw4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a17:903:2310:b0:20c:686e:28c6 with SMTP id
 d9443c01a7336-210f729e85fmr294755ad.0.1730301577606; Wed, 30 Oct 2024
 08:19:37 -0700 (PDT)
Date: Wed, 30 Oct 2024 08:19:36 -0700
In-Reply-To: <f7394b88a22e52774f23854950d45c1bfeafe42c.1730120881.git.kai.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1730120881.git.kai.huang@intel.com> <f7394b88a22e52774f23854950d45c1bfeafe42c.1730120881.git.kai.huang@intel.com>
Message-ID: <ZyJOiPQnBz31qLZ7@google.com>
Subject: Re: [PATCH 3/3] KVM: VMX: Initialize TDX during KVM module load
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, rick.p.edgecombe@intel.com, 
	isaku.yamahata@intel.com, reinette.chatre@intel.com, 
	binbin.wu@linux.intel.com, xiaoyao.li@intel.com, yan.y.zhao@intel.com, 
	adrian.hunter@intel.com, tony.lindgren@intel.com, kristen@linux.intel.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Oct 29, 2024, Kai Huang wrote:
> diff --git a/arch/x86/kvm/Makefile b/arch/x86/kvm/Makefile
> index f9dddb8cb466..fec803aff7ad 100644
> --- a/arch/x86/kvm/Makefile
> +++ b/arch/x86/kvm/Makefile
> @@ -20,6 +20,7 @@ kvm-intel-y		+= vmx/vmx.o vmx/vmenter.o vmx/pmu_intel.o vmx/vmcs12.o \
>  
>  kvm-intel-$(CONFIG_X86_SGX_KVM)	+= vmx/sgx.o
>  kvm-intel-$(CONFIG_KVM_HYPERV)	+= vmx/hyperv.o vmx/hyperv_evmcs.o
> +kvm-intel-$(CONFIG_INTEL_TDX_HOST)	+= vmx/tdx.o

IMO, INTEL_TDX_HOST should be a KVM Kconfig, e.g. KVM_INTEL_TDX.  Forcing the user
to bounce between KVM's menu and the generic menu to enable KVM support for TDX is
kludgy.  Having INTEL_TDX_HOST exist before KVM support came along made sense, as
it allowed compile-testing a bunch of code, but I don't think it should be the end
state.

If others disagree, then we should adjust KVM_AMD_SEV in the opposite direction,
because doing different things for SEV vs. TDX is confusing and messy.

>  kvm-amd-y		+= svm/svm.o svm/vmenter.o svm/pmu.o svm/nested.o svm/avic.o
>  
> diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
> index 433ecbd90905..053294939eb1 100644
> --- a/arch/x86/kvm/vmx/main.c
> +++ b/arch/x86/kvm/vmx/main.c
> @@ -6,6 +6,7 @@
>  #include "nested.h"
>  #include "pmu.h"
>  #include "posted_intr.h"
> +#include "tdx.h"
>  
>  #define VMX_REQUIRED_APICV_INHIBITS				\
>  	(BIT(APICV_INHIBIT_REASON_DISABLED) |			\
> @@ -170,6 +171,7 @@ struct kvm_x86_init_ops vt_init_ops __initdata = {
>  static void vt_exit(void)
>  {
>  	kvm_exit();
> +	tdx_cleanup();
>  	vmx_exit();
>  }
>  module_exit(vt_exit);
> @@ -182,6 +184,9 @@ static int __init vt_init(void)
>  	if (r)
>  		return r;
>  
> +	/* tdx_init() has been taken */
> +	tdx_bringup();

tdx_module_init()?  And honestly, even though Linux doesn't currently support
unloading the TDX module, I think tdx_module_exit() is a perfectly fine name,
because not being able to unload the TDX module and reclaim all of that memory
is a flaw that should be addressed at some point.
> +static enum cpuhp_state tdx_cpuhp_state;
> +
> +static int tdx_online_cpu(unsigned int cpu)
> +{
> +	unsigned long flags;
> +	int r;
> +
> +	/* Sanity check CPU is already in post-VMXON */
> +	WARN_ON_ONCE(!(cr4_read_shadow() & X86_CR4_VMXE));
> +
> +	/* tdx_cpu_enable() must be called with IRQ disabled */

I don't find this comment helpfu.  If it explained _why_ tdx_cpu_enable() requires
IRQs to be disabled, then I'd feel differently, but as is, IMO it doesn't add value.

> +	local_irq_save(flags);
> +	r = tdx_cpu_enable();
> +	local_irq_restore(flags);
> +
> +	return r;
> +}
> +

...

> +static int __init __do_tdx_bringup(void)
> +{
> +	int r;
> +
> +	/*
> +	 * TDX-specific cpuhp callback to call tdx_cpu_enable() on all
> +	 * online CPUs before calling tdx_enable(), and on any new
> +	 * going-online CPU to make sure it is ready for TDX guest.
> +	 */
> +	r = cpuhp_setup_state_cpuslocked(CPUHP_AP_ONLINE_DYN,
> +					 "kvm/cpu/tdx:online",
> +					 tdx_online_cpu, NULL);
> +	if (r < 0)
> +		return r;
> +
> +	tdx_cpuhp_state = r;
> +
> +	/* tdx_enable() must be called with cpus_read_lock() */

This comment is even less valuable, IMO.

> +	r = tdx_enable();
> +	if (r)
> +		__do_tdx_cleanup();
> +
> +	return r;
> +}
> +
> +static int __init __tdx_bringup(void)
> +{
> +	int r;
> +
> +	if (!enable_ept) {
> +		pr_err("Cannot enable TDX with EPT disabled.\n");

Why wait until now to check for EPT?  Force enable_tdx to false if enable_ept is
false, don't fail the module load.

> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Enabling TDX requires enabling hardware virtualization first,
> +	 * as making SEAMCALLs requires CPU being in post-VMXON state.
> +	 */
> +	r = kvm_enable_virtualization();
> +	if (r)
> +		return r;
> +
> +	cpus_read_lock();
> +	r = __do_tdx_bringup();
> +	cpus_read_unlock();
> +
> +	if (r)
> +		goto tdx_bringup_err;
> +
> +	/*
> +	 * Leave hardware virtualization enabled after TDX is enabled
> +	 * successfully.  TDX CPU hotplug depends on this.
> +	 */
> +	return 0;
> +tdx_bringup_err:
> +	kvm_disable_virtualization();
> +	return r;
> +}
> +
> +void tdx_cleanup(void)
> +{
> +	if (enable_tdx) {
> +		__do_tdx_cleanup();
> +		kvm_disable_virtualization();
> +	}
> +}
> +
> +void __init tdx_bringup(void)
> +{
> +	enable_tdx = enable_tdx && !__tdx_bringup();

Ah.  I don't love this approach because it mixes "failure" due to an unsupported
configuration, with failure due to unexpected issues.  E.g. if enabling virtualization
fails, loading KVM-the-module absolutely should fail too, not simply disable TDX.

