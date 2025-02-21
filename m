Return-Path: <linux-kernel+bounces-526512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3133A3FFB0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 20:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8736189F3B2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7502512F6;
	Fri, 21 Feb 2025 19:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bdG1j7sX"
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0615223
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 19:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740165963; cv=none; b=Ob9OqoPdsitwvtz6g7sb5ylad+6bEjFLkBv1jsees3NmF7FG9ygMazlwo8tWCklNSba5G0GXPWdlZHcPED1AgIF+I2C4KWuOe3A03g5XzXvkQRjGQ+AqlNHp9BWRj4HUwuJ66Cm6TDLVfi1AB5hGRSt131QgN+E1wdB2GtK+RKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740165963; c=relaxed/simple;
	bh=/mK1sbxYtdS7KNsFcfkwSJqjmhdZTLl+tNSwL47ab5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U2fTZi3Eidkpz9I+fF7nIMMe+U2/86m0bEZ0Szb401yrEX8voBJyn4VzLj4mH9gmivO2yF0WFiwTTTK03YNK/NXWAIDR66Lfz3RX8vCLup8ZS3KwORmsE9J/WTC6EqNJmsCMfeB4rkyGFi7N0M8nRIzjqxwp+EKnRbcKBNX5wQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bdG1j7sX; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 21 Feb 2025 19:25:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740165958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4UOcBtNP/vA5fSS7SrK5qM5CrZoZVVvn7qxKW1BpsrE=;
	b=bdG1j7sXU6vv119c3ex8zymSN38mnLFtO8yBv/4VQ4mKXBGatbc9RFrImkR1ZfDAr2knZA
	r/mmJp5Y98BfqLBMUrfCo3evfnSNelf3TI7kjjWSdqPn5SC7g2Lwk/YBDk6Oo5miaSUJMp
	xS6sxJs0oayE0m41QPbLGSW6e2CZn+g=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Jim Mattson <jmattson@google.com>
Cc: x86@kernel.org, Sean Christopherson <seanjc@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	"Kaplan, David" <David.Kaplan@amd.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] KVM: x86: Generalize IBRS virtualization on emulated
 VM-exit
Message-ID: <Z7jTQc8FB4gpuNVN@google.com>
References: <20250221163352.3818347-1-yosry.ahmed@linux.dev>
 <20250221163352.3818347-4-yosry.ahmed@linux.dev>
 <CALMp9eSPVDYC7v4Rm13ZUcE4wWPb8dUfm=qBx_jETAQEQrt4_w@mail.gmail.com>
 <Z7jISUVBeAbw8zt6@google.com>
 <CALMp9eQmsFd1QyCPOsPXBnkUdGmsW-ZBW5CoDR4pmSwF7ic0XA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALMp9eQmsFd1QyCPOsPXBnkUdGmsW-ZBW5CoDR4pmSwF7ic0XA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Feb 21, 2025 at 11:02:16AM -0800, Jim Mattson wrote:
> On Fri, Feb 21, 2025 at 10:39 AM Yosry Ahmed <yosry.ahmed@linux.dev> wrote:
> >
> > On Fri, Feb 21, 2025 at 09:59:04AM -0800, Jim Mattson wrote:
> > > On Fri, Feb 21, 2025 at 8:34 AM Yosry Ahmed <yosry.ahmed@linux.dev> wrote:
> > > >
> > > > Commit 2e7eab81425a ("KVM: VMX: Execute IBPB on emulated VM-exit when
> > > > guest has IBRS") added an IBPB in the emulated VM-exit path on Intel to
> > > > properly virtualize IBRS by providing separate predictor modes for L1
> > > > and L2.
> > > >
> > > > AMD requires similar handling, except when IbrsSameMode is enumerated by
> > > > the host CPU (which is the case on most/all AMD CPUs). With
> > > > IbrsSameMode, hardware IBRS is sufficient and no extra handling is
> > > > needed from KVM.
> > > >
> > > > Generalize the handling in nested_vmx_vmexit() by moving it into a
> > > > generic function, add the AMD handling, and use it in
> > > > nested_svm_vmexit() too. The main reason for using a generic function is
> > > > to have a single place to park the huge comment about virtualizing IBRS.
> > > >
> > > > Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
> > > > ---
> > > >  arch/x86/kvm/svm/nested.c |  2 ++
> > > >  arch/x86/kvm/vmx/nested.c | 11 +----------
> > > >  arch/x86/kvm/x86.h        | 18 ++++++++++++++++++
> > > >  3 files changed, 21 insertions(+), 10 deletions(-)
> > > >
> > > > diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> > > > index d77b094d9a4d6..61b73ff30807e 100644
> > > > --- a/arch/x86/kvm/svm/nested.c
> > > > +++ b/arch/x86/kvm/svm/nested.c
> > > > @@ -1041,6 +1041,8 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
> > > >
> > > >         nested_svm_copy_common_state(svm->nested.vmcb02.ptr, svm->vmcb01.ptr);
> > > >
> > > > +       kvm_nested_vmexit_handle_spec_ctrl(vcpu);
> > > > +
> > > >         svm_switch_vmcb(svm, &svm->vmcb01);
> > > >
> > > >         /*
> > > > diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> > > > index 8a7af02d466e9..453d52a6e836a 100644
> > > > --- a/arch/x86/kvm/vmx/nested.c
> > > > +++ b/arch/x86/kvm/vmx/nested.c
> > > > @@ -5018,16 +5018,7 @@ void nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 vm_exit_reason,
> > > >
> > > >         vmx_switch_vmcs(vcpu, &vmx->vmcs01);
> > > >
> > > > -       /*
> > > > -        * If IBRS is advertised to the vCPU, KVM must flush the indirect
> > > > -        * branch predictors when transitioning from L2 to L1, as L1 expects
> > > > -        * hardware (KVM in this case) to provide separate predictor modes.
> > > > -        * Bare metal isolates VMX root (host) from VMX non-root (guest), but
> > > > -        * doesn't isolate different VMCSs, i.e. in this case, doesn't provide
> > > > -        * separate modes for L2 vs L1.
> > > > -        */
> > > > -       if (guest_cpu_cap_has(vcpu, X86_FEATURE_SPEC_CTRL))
> > > > -               indirect_branch_prediction_barrier();
> > > > +       kvm_nested_vmexit_handle_spec_ctrl(vcpu);
> > > >
> > > >         /* Update any VMCS fields that might have changed while L2 ran */
> > > >         vmcs_write32(VM_EXIT_MSR_LOAD_COUNT, vmx->msr_autoload.host.nr);
> > > > diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
> > > > index 7a87c5fc57f1b..008c8d381c253 100644
> > > > --- a/arch/x86/kvm/x86.h
> > > > +++ b/arch/x86/kvm/x86.h
> > > > @@ -116,6 +116,24 @@ static inline void kvm_leave_nested(struct kvm_vcpu *vcpu)
> > > >         kvm_x86_ops.nested_ops->leave_nested(vcpu);
> > > >  }
> > > >
> > > > +/*
> > > > + * If IBRS is advertised to the vCPU, KVM must flush the indirect branch
> > > > + * predictors when transitioning from L2 to L1, as L1 expects hardware (KVM in
> > > > + * this case) to provide separate predictor modes.  Bare metal isolates the host
> > > > + * from the guest, but doesn't isolate different guests from one another (in
> > > > + * this case L1 and L2). The exception is if bare metal supports same mode IBRS,
> > > > + * which offers protection within the same mode, and hence protects L1 from L2.
> > > > + */
> > > > +static inline void kvm_nested_vmexit_handle_spec_ctrl(struct kvm_vcpu *vcpu)
> > >
> > > Maybe just kvm_nested_vmexit_handle_ibrs?
> >
> > I was trying to use a generic name to accomodate any future handling
> > needed for non-IBRS speculation control virtualization. But I could just
> > be overthinking. Happy to take whatever name is agreed upon in during
> > reviews.
> >
> > >
> > > > +{
> > > > +       if (cpu_feature_enabled(X86_FEATURE_AMD_IBRS_SAME_MODE))
> > > > +               return;
> > > > +
> > > > +       if (guest_cpu_cap_has(vcpu, X86_FEATURE_SPEC_CTRL) ||
> > > > +           guest_cpu_cap_has(vcpu, X86_FEATURE_AMD_IBRS))
> > >
> > > This is a bit conservative, but I don't think there's any ROI in being
> > > more pedantic.
> >
> > Could you elaborate on this?
> >
> > Is this about doing the IBPB even if L1 does not actually execute an
> > IBRS? I thought about this for a bit, but otherwise we'd have to
> > intercept the MSR write IIUC, and I am not sure if that's better. Also,
> > that's what we are already doing so I just kept it as-is.
> >
> > Or maybe about whether we need this on AMD only with AUTOIBRS? The APM
> > is a bit unclear to me in this regard, but I believe may be needed even
> > for 'normal' IBRS.
> 
> If IA32_SPEC_CTRL.IBRS is clear at emulated VM-exit, then this IBPB is
> unnecessary.
> 
> However, since the host (L1) is running in a de-privileged prediction
> domain, simply setting IA32_SPEC_CTRL.IBRS in the future won't protect
> it from the guest (L2) that just exited. If we don't eagerly perform
> an IBPB now, then L0 would have to intercept WRMSR(IA32_SPEC_CTRL)
> from L1 so that we can issue an IBPB in the future, if L1 ever sets
> IA32_SPEC_CTRL.IBRS.

Right, that's what I meant by "we'd have to intercept the MSR write"
above, but I didn't put it as eloquently as you just did :)

We'd also need to have different handling for eIBRS/AUTOIBRS. It would
basically be:

if eIBRS/AUTOIBRS is enabled by L1:
  - Do not intercept IBRS MSR writes
  - Always IBPB on emulated VM-exits (unless IbrsSameMode).
else if IBRS is advertised to L1:
  - Intercept IBRS MSR writes and do an IBPB.
  - Do not IBPB on emulated VM-exits.

We'd basically have two modes of IBRS virtualization and we'd need to
switch between them at runtime according to L1's setting of
eIBRS/AUTOIBRS.

We can simplify it if we always intercept IBRS MSR writes assuming L1
won't do them with eIBRS/AUTOIBRS anyway, so this becomes:

- On emulated VM-exits, IBPB if eIBRS/AUTOIBRS is enabled (unless
  IbrsSameMode).
- On IBRS MSR writes, do an IBPB.

Simpler, but not sure if it buys us much.

> 
> Eagerly performing an IBPB now seems like the better option.

So yeah I definitely agree, unless we get regression reports caused by
the IBPB on emulated VM-exits, and the MSR write interception turns out
to be an improvement.

