Return-Path: <linux-kernel+bounces-199877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB668FA71D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 02:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 639E8283A92
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 00:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B933F4C91;
	Tue,  4 Jun 2024 00:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="POQizCQL"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDED611B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 00:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717461936; cv=none; b=VEHcFZ9jzbnw9u9FAi+HbTjZRlonaXp4SbZgwIHowtvSAQcc+fBp6RCnZiPXwU2bFQFnHWWCRbjY3TW5H1iui8wkPuHGdSIeKqAABjd4dxZdA2OMc7Ss40tEV86gZqhVtgiF6iJI2LAUMnfdsE5Y34KEGlJKy9/w3ai+GrWv0Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717461936; c=relaxed/simple;
	bh=0feO/7C+CrLgGRjOb5ae1CaJ7O4SHCcHI6Yy37sOBhI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iDpGvwvopKnBKjn2hmxGbz3PktXJ7M3155g8GCcGXzvwRbfJKI2FLld5c/z34hDtvO7OOa6KFQ5a6pLeHK1sD+9is0KUoe7Odq6wQjwoXx842OYf5W4I9IaEX4/EfHNNSCTMD+SHP1AlMvxlUPkqELq+5kDwXUC4wDkcU4tQ6lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=POQizCQL; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7027585df9bso1289310b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 17:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717461934; x=1718066734; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+Bm5sO14VbwMd1xIPVmZquFgInZWUqDJbdvBe8VoG78=;
        b=POQizCQLBooCYBuuAVFjMjuPaUY6s0WvhqBuNap7OOV6sTO+diQg4pU1S5cLtFwt2l
         tKx86irXweu37F6G+lGQa+WBW+pqFYJKMRXOpn25hcS6TvMSoiMWGTbhn7LpxSevKtvn
         79H97BLzw5NgSSdRH6mTQKnIDrb4YOGLIL+ucg0hcag2L3Ab+ktFeRp6e5+kXhse8wi5
         9tSBARBRo5np0avYWAu4GXzeRKzGm9Eb2jaO/VX7rhqaiKL54hHz+Di9Xd3oY8Vh/nHT
         kALnedrWrOKl+78HqUcbVboxsXHP0NY2ZFzApluLvr8dJWdnPPBFM3fdx/jcUCM1vPEC
         vNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717461934; x=1718066734;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Bm5sO14VbwMd1xIPVmZquFgInZWUqDJbdvBe8VoG78=;
        b=GUAULxvmMjGIcRW5kfHPVBMGznvqoGuFW8fdsRbxeCp9aJPW5X+iyHZ94zksm/uHW5
         FBboc4u1pzMKUMzUtF+n9744yL3xxkqG/cw8tUiN4EN3epfxVWBX+BhI5UK3Kzd/jmQC
         747eP1giZgaArvzrxoKym+GvnlhQm+kI6UNg3/Mkfgnihl7ZuCV0B7LGvgsBdVT2PkvK
         MVkyLI5v9Upho+0sJRZt1Jjivib4KpzfEQrZFKR4lqF1Z9twBxk1VbnsnbKC6YUPBWbB
         S1EzBc3kQGBD6B8wE1taVYi/KRN5/kL66ou0/qEwxEfakXz6liQK3tAdzbwbtIJLr//s
         SAWg==
X-Forwarded-Encrypted: i=1; AJvYcCXLq2YxvxOLVf+HXcJAj1eGEFDwXDzPqgOcVnoCjxi49CcBlsACN2l9ar31IXdO9XcaU9SEtfN8QPjWxfEYkm0MwcYWOl/4NHtmH+Dz
X-Gm-Message-State: AOJu0Ywioun4GjPIYHymJBOpwznF+1t+9h8OVQLM9gKu++/gXtgKLkIv
	NA0QjbBXcbcrx13T8Ncbi64xEyb8DZ/zygVr/tiJKBow/Q+odBvmjMTGOaLeJ+7cfJ7imPVTx4X
	YTA==
X-Google-Smtp-Source: AGHT+IFJPIM5O78GbEgTJkoYIbaMsDfaMyloYqJ1aZGLTAMlZeqHlKfhFkYbfVbqXlLT1sYbBZGJlR/eHek=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:27a1:b0:6ec:f407:ec0c with SMTP id
 d2e1a72fcca58-7024785a3ccmr349295b3a.2.1717461933286; Mon, 03 Jun 2024
 17:45:33 -0700 (PDT)
Date: Mon, 3 Jun 2024 17:45:31 -0700
In-Reply-To: <20240429060643.211-4-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240429060643.211-1-ravi.bangoria@amd.com> <20240429060643.211-4-ravi.bangoria@amd.com>
Message-ID: <Zl5jqwWO4FyawPHG@google.com>
Subject: Re: [PATCH 3/3] KVM SVM: Add Bus Lock Detect support
From: Sean Christopherson <seanjc@google.com>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, pbonzini@redhat.com, thomas.lendacky@amd.com, 
	hpa@zytor.com, rmk+kernel@armlinux.org.uk, peterz@infradead.org, 
	james.morse@arm.com, lukas.bulwahn@gmail.com, arjan@linux.intel.com, 
	j.granados@samsung.com, sibs@chinatelecom.cn, nik.borisov@suse.com, 
	michael.roth@amd.com, nikunj.dadhania@amd.com, babu.moger@amd.com, 
	x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	santosh.shukla@amd.com, ananth.narayan@amd.com, sandipan.das@amd.com
Content-Type: text/plain; charset="us-ascii"

On Mon, Apr 29, 2024, Ravi Bangoria wrote:
> Upcoming AMD uarch will support Bus Lock Detect. Add support for it
> in KVM. Bus Lock Detect is enabled through MSR_IA32_DEBUGCTLMSR and
> MSR_IA32_DEBUGCTLMSR is virtualized only if LBR Virtualization is
> enabled. Add this dependency in the KVM.

This is woefully incomplete, e.g. db_interception() needs to be updated to decipher
whether the #DB is the responsbility of the host or of the guest.

Honestly, I don't see any point in virtualizing this in KVM.  As Jim alluded to,
what's far, far more interesting for KVM is "Bus Lock Threshold".  Virtualizing
this for the guest would have been nice to have during the initial split-lock #AC
support, but now I'm skeptical the complexity is worth the payoff.

I suppose we could allow it if #DB isn't interecepted, at which point the enabling
required is minimal?

> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
>  arch/x86/kvm/svm/nested.c |  3 ++-
>  arch/x86/kvm/svm/svm.c    | 16 +++++++++++++++-
>  2 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index 55b9a6d96bcf..6e93c2d9e7df 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -586,7 +586,8 @@ static void nested_vmcb02_prepare_save(struct vcpu_svm *svm, struct vmcb *vmcb12
>  	/* These bits will be set properly on the first execution when new_vmc12 is true */
>  	if (unlikely(new_vmcb12 || vmcb_is_dirty(vmcb12, VMCB_DR))) {
>  		vmcb02->save.dr7 = svm->nested.save.dr7 | DR7_FIXED_1;
> -		svm->vcpu.arch.dr6  = svm->nested.save.dr6 | DR6_ACTIVE_LOW;
> +		/* DR6_RTM is not supported on AMD as of now. */
> +		svm->vcpu.arch.dr6  = svm->nested.save.dr6 | DR6_FIXED_1 | DR6_RTM;
>  		vmcb_mark_dirty(vmcb02, VMCB_DR);
>  	}
>  
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index d1a9f9951635..60f3af9bdacb 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -1038,7 +1038,8 @@ void svm_update_lbrv(struct kvm_vcpu *vcpu)
>  {
>  	struct vcpu_svm *svm = to_svm(vcpu);
>  	bool current_enable_lbrv = svm->vmcb->control.virt_ext & LBR_CTL_ENABLE_MASK;
> -	bool enable_lbrv = (svm_get_lbr_vmcb(svm)->save.dbgctl & DEBUGCTLMSR_LBR) ||
> +	u64 dbgctl_buslock_lbr = DEBUGCTLMSR_BUS_LOCK_DETECT | DEBUGCTLMSR_LBR;
> +	bool enable_lbrv = (svm_get_lbr_vmcb(svm)->save.dbgctl & dbgctl_buslock_lbr) ||
>  			    (is_guest_mode(vcpu) && guest_can_use(vcpu, X86_FEATURE_LBRV) &&
>  			    (svm->nested.ctl.virt_ext & LBR_CTL_ENABLE_MASK));
>  
> @@ -3119,6 +3120,10 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
>  		if (data & DEBUGCTL_RESERVED_BITS)
>  			return 1;
>  
> +		if ((data & DEBUGCTLMSR_BUS_LOCK_DETECT) &&
> +		    !guest_cpuid_has(vcpu, X86_FEATURE_BUS_LOCK_DETECT))
> +			return 1;
> +
>  		svm_get_lbr_vmcb(svm)->save.dbgctl = data;
>  		svm_update_lbrv(vcpu);
>  		break;
> @@ -5157,6 +5162,15 @@ static __init void svm_set_cpu_caps(void)
>  
>  	/* CPUID 0x8000001F (SME/SEV features) */
>  	sev_set_cpu_caps();
> +
> +	/*
> +	 * LBR Virtualization must be enabled to support BusLockTrap inside the
> +	 * guest, since BusLockTrap is enabled through MSR_IA32_DEBUGCTLMSR and
> +	 * MSR_IA32_DEBUGCTLMSR is virtualized only if LBR Virtualization is
> +	 * enabled.
> +	 */
> +	if (!lbrv)
> +		kvm_cpu_cap_clear(X86_FEATURE_BUS_LOCK_DETECT);
>  }
>  
>  static __init int svm_hardware_setup(void)
> -- 
> 2.44.0
> 

