Return-Path: <linux-kernel+bounces-272781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFEE9460D4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 17:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99F0F1C213E8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 15:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AF21537A0;
	Fri,  2 Aug 2024 15:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3AvOswIo"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FE1175D4B
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 15:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722614009; cv=none; b=JlYucdx/dKeDBFQt+kkf5TtI46abGIHvkJQqgkHQ6zoPz9VgzolsOngLLz5hB4ih3Mmc1X6sfnjaGEL5tn0D4MZ6hqAmVaxSfIdj3Laf9x0MM57SCVcGVUOJkhn5h9f4wJccUQfiD/sUK+waARZTdmSZnZbdQRai/PGbufzj1lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722614009; c=relaxed/simple;
	bh=HfRW5DmJhxhXde7xQghASIZD9c7a0wgm8T+Cw16zeMA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g6kfXqMXI1Q5ChR+XOpFrjmmTcdFQz7yxFrYK0coAYuBbMMRrs3UCHzcojjzVirprHCP+sddjKE9n9pul1KVRLZBrcUVPnr6uquLVHcQjMl6KRDjx4klpWV5/RaDgupEBNLgbfx0JSJca01cugz5+JzVUoHNuh0a86gmItZ1+60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3AvOswIo; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-70d1c8d98baso7523912b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 08:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722614007; x=1723218807; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OQflQF1VpeXc1q1T34zDznynP2cVcjD3C+kAeL3RI/M=;
        b=3AvOswIowHGrDrNrq7RCNaFP+zYg1JxAk6FngLPeJ3LzKbBLI6yimNRZE5FpMKzCY9
         sRnVyaZwzyB6MvuNUo2BQO8FAGQ+wO7+vFOLai1JPWO5X2oLFXID8jE08FlhvsUWTMJ+
         dw3HbT3oJBcwI06rQUaAEO9CPqr/pO3zpjSZpeh/RuYpVibpaXZZdRIz4SH0vag9TlXp
         os1XCI25snodu5e4U/fcQKEQ59oAGlXpcOiF8U1OA+TnzZn/VDQJYglGW0Ocs2CnyFn+
         ZnchZON2CNgPPycByVTIqvudZuYXZj87q+k+RxDFUuZ+aE/8CenN6I/9+3WfkO56aMRz
         IA4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722614007; x=1723218807;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OQflQF1VpeXc1q1T34zDznynP2cVcjD3C+kAeL3RI/M=;
        b=mi5uh81Osee9l9gFYorLJvJdSRFnEvUoIGWyGcvUxBJmA6JMBjjPcrBz4IMKfTvgjD
         xLCwlTdQkqi1xvjFD69GZBn62nGUZdFQNDvc9EipcImgQ9dqY8sGh0dmG1RAGyyT/q7C
         0ZgSjyB+zQ1HRiJ87gMY8smnuN2R1Hs7Lcoz+Ib02qWaTQ132NmFgjaXsPyFJYDjtTL8
         tKo8GvloNr8vPTeExRQQDqhQKrIPmGxpwUnB8NmJKROGNxJdSVcWV19E8gbuAEp8Mowc
         soTkr74xWLU6/o7zHZDUt5GUkEtcLBEcOMyen3yLOLKuvdBPTp61hFR/r6AGRFE77eSk
         G0pg==
X-Forwarded-Encrypted: i=1; AJvYcCWix0LSAy0dcbWabwGJAPo/rRQWy6y6GJ4cF3nEgRdRC/WwQJTRbBoIlcdwRPsyi/ZX/TcghCTuKDk/JQbqsCMBP3B0ST1yaQxxBmDY
X-Gm-Message-State: AOJu0Ywzgtb9Z9evczKAbcxeYorv1qE0jUTG4Bp83dOAqU4Nmp1fA+6l
	FbZpveP3AHTOoITOYJcVqzHdyH6LJewUDQ7EqN/qc1YbzxMrUZshWvsQGkSvAE6nYCgIuW1jz1h
	dig==
X-Google-Smtp-Source: AGHT+IGAq55hoq+7zWXDHX5qWCzZXyIak9Ckv9V5U//xtLLkFkk6XDyP9DgONLQBDJ79qPxHDM35sdQTUL4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:6f69:b0:70e:9e1e:e6ed with SMTP id
 d2e1a72fcca58-7106cf9c4dcmr32915b3a.2.1722614007037; Fri, 02 Aug 2024
 08:53:27 -0700 (PDT)
Date: Fri, 2 Aug 2024 08:53:25 -0700
In-Reply-To: <20240802151608.72896-2-mlevitsk@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240802151608.72896-1-mlevitsk@redhat.com> <20240802151608.72896-2-mlevitsk@redhat.com>
Message-ID: <Zq0A9R5R_MAFrqTP@google.com>
Subject: Re: [PATCH v2 1/2] KVM: x86: relax canonical check for some x86
 architectural msrs
From: Sean Christopherson <seanjc@google.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Ingo Molnar <mingo@redhat.com>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Chao Gao <chao.gao@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Aug 02, 2024, Maxim Levitsky wrote:
> Several architectural msrs (e.g MSR_KERNEL_GS_BASE) must contain
> a canonical address, and according to Intel PRM, this is enforced
> by a #GP canonical check during MSR write.
> 
> However as it turns out, the supported address width
> used for this canonical check is determined only
> by host cpu model:

Please try to wrap consistently and sanely, this is unnecessarily hard to read
because every paragraph manages to wrap at a different column.

> if CPU *supports* 5 level paging, the width will be 57
> regardless of the state of CR4.LA57.
> 
> Experemental tests on a Sapphire Rapids CPU and on a Zen4 CPU
> confirm this behavior.
> 
> In addition to that, the Intel ISA extension manual mentions that this might
> be the architectural behavior:
> 
> Architecture Instruction Set Extensions and Future Features Programming Reference [1].
> Chapter 6.4:
> 
> "CANONICALITY CHECKING FOR DATA ADDRESSES WRITTEN TO CONTROL REGISTERS AND
> MSRS"
> 
> "In Processors that support LAM continue to require the addresses written to
> control registers or MSRs to be 57-bit canonical if the processor _supports_
> 5-level paging or 48-bit canonical if it supports only 4-level paging"
> 
> [1]: https://cdrdv2.intel.com/v1/dl/getContent/671368
> 
> Suggested-by: Chao Gao <chao.gao@intel.com>
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  arch/x86/kvm/x86.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index a6968eadd418..3582f0bb7644 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -1844,7 +1844,16 @@ static int __kvm_set_msr(struct kvm_vcpu *vcpu, u32 index, u64 data,
>  	case MSR_KERNEL_GS_BASE:
>  	case MSR_CSTAR:
>  	case MSR_LSTAR:
> -		if (is_noncanonical_address(data, vcpu))
> +
> +		/*
> +		 * Both AMD and Intel cpus allow values which
> +		 * are canonical in the 5 level paging mode but are not
> +		 * canonical in the 4 level paging mode to be written
> +		 * to the above MSRs, as long as the host CPU supports
> +		 * 5 level paging, regardless of the state of the CR4.LA57.
> +		 */
> +		if (!__is_canonical_address(data,
> +			kvm_cpu_cap_has(X86_FEATURE_LA57) ? 57 : 48))

Please align indentation.

Checking kvm_cpu_cap_has() is wrong.  What the _host_ supports is irrelevant,
what matters is what the guest CPU supports, i.e. this should check guest CPUID.
Ah, but for safety, KVM also needs to check kvm_cpu_cap_has() to prevent faulting
on a bad load into hardware.  Which means adding a "governed" feature until my
CPUID rework lands.

And I'm pretty sure this fix is incomplete, as nVMX's consistency checks on MSRs
that are loaded via dedicated VMCS fields likely need the same treatment, e.g.
presumably these checks should follow the MSR handling.

	if (CC(is_noncanonical_address(vmcs12->host_ia32_sysenter_esp, vcpu)) ||
	    CC(is_noncanonical_address(vmcs12->host_ia32_sysenter_eip, vcpu)))
		return -EINVAL;


	    (CC(is_noncanonical_address(vmcs12->guest_bndcfgs & PAGE_MASK, vcpu)) ||

So I think we probably need a dedicated helper for MSRs.

Hmm, and I suspect these are wrong too, but in a different way.  Toggling host
LA57 on VM-Exit is legal[*], so logically, KVM should use CR4.LA57 from
vmcs12->host_cr4, not the vCPU's current CR4 value.  Which makes me _really_
curious if Intel CPUs actually get that right.

	if (CC(is_noncanonical_address(vmcs12->host_fs_base, vcpu)) ||
	    CC(is_noncanonical_address(vmcs12->host_gs_base, vcpu)) ||
	    CC(is_noncanonical_address(vmcs12->host_gdtr_base, vcpu)) ||
	    CC(is_noncanonical_address(vmcs12->host_idtr_base, vcpu)) ||
	    CC(is_noncanonical_address(vmcs12->host_tr_base, vcpu)) ||
	    CC(is_noncanonical_address(vmcs12->host_rip, vcpu)))
		return -EINVAL;

[*] https://lore.kernel.org/all/20210622211124.3698119-1-seanjc@google.com

