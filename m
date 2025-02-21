Return-Path: <linux-kernel+bounces-526481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B16F3A3FF3C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 20:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDDE170354D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4CF2512D9;
	Fri, 21 Feb 2025 19:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o8+qrWhj"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7901EE006
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 19:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740164550; cv=none; b=Ah42JkrojyafAnDpFYENd2LP5gkfMBCdT4hgJgEzy3dGczq7sLaC1SX93i+/ShSEzYhSa46VsX5MDNZmkUGIYQTP+jH0f5wHZKfVkB52S4cky+iVanZ2wlEMNKC0XgXU9u6PPpEAmZyLbLRjs/HXoTf8v1pk0QyidouE2+80VR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740164550; c=relaxed/simple;
	bh=HEK5y9n2KP11fE+qUXmbDpD27D2rA/U8M3pbfa8CGoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VlM1OfWQtovI5OMNgF/tXfIHGmMVPjHKFqbJaMdIbNv4fVRBJdjSYRCk93ln5qCwLBxkVRENX1/4Kq9tO+tOtfYxc6P65qYjEqSsb57zA8m5+87fQ6GupGIraqy153MRibQwcgh7koDYlPId0QUSjHGZIH5j+usxhlDwLB8oxtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o8+qrWhj; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3d18c325ee4so12725ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 11:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740164547; x=1740769347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gkjSg8CHwO2BzGPet94fnsXPSCLN8E0p9xE46iyhzFk=;
        b=o8+qrWhjXAPuJMiWUnXu/CDeeAVuHQu9ElXKXW9Nc2kZKZbppOeBlUgSBv5sB8Gjo7
         cBYwIrmyv72rVARelkoiFvFszRMp4JwnS9g0NowFpMjDs49MPXOK/+Oqw5unLAQSGnAD
         ne2yW/1TCGDtlLloR7XaEYblcnHa9rPFwtbgynrzrZG14WBiLlmtYJjZkwUBBncp5Rc/
         7uFwhy7tNinvqUw9aelr7Exd9ARi8n8OghUNbbTcMT+M3lc8muWXdf6NMDeziGSZgrnA
         6bKfotEp/L1rMbDDe5q++spLxesCYOc2Amsa3CIjsWykZfwRDLAEVkqz5u014acJN8zc
         bbeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740164547; x=1740769347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gkjSg8CHwO2BzGPet94fnsXPSCLN8E0p9xE46iyhzFk=;
        b=OiTR8m7wLJJWTC33LP8Kg9eq0qd9R1zdMyUVJdYUTlu3q0BFL2CKuKPVRaxxc9Pmau
         UsXIpj8sOuKEicUbdIVqyimAiXJzkLoe0c9m7ODiXHU1dd4lycXCQj/kcjDg2TMdy3OZ
         owGDI990qSmuSdpghQ9oxxxLtd2AF/Q8nKPqAqLZvMMzA8r2Lmdst0pzshhUwkje6TY7
         eddhsiV6ebxxI9eT3dHkXSk+kEU2d2TsvcOnlddxA6Z5ZGGLhxVTp9YQATGVkc/a+1x1
         boT0pIe93IDolFKjBn9PvTa3V5OlyFmd02toFRRLIPVzVryhKLnAVQfMqSxLUuWsaVlQ
         0Azg==
X-Forwarded-Encrypted: i=1; AJvYcCV9QcJv1rLZ7pkM1CpNiXH2RYfUoBkzga9DhDKWIuna9tkZFmnL0/zF3vnza2wfzav82rztavUhqpoLK5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwEwDuCE3GpvtLzIIPNzouOgR2dOjE7G38QAbhjdeTak4J9psX
	8We9O21RN60qBnl+/klQoe+FI4tX0Ji5SXy7RLiMoJuNOV+785JKXi5eifCbREIa1SzOo1qBGlV
	mRGDCGURc/1kf99q8nfFB5i85YgXuDzY3cA4n
X-Gm-Gg: ASbGncuA/HS2AtjwNsCinKDb2KvahdXkK7hCMzW17QOvUSIMxYWv7RIalXqcJ/vA9GL
	iRo9FACNOlj4VHfx8jf2SXqDR/tHGrzdYlZELo9kbcolNDKu6e4K6Lsj6AxH408BplcWzIXZr00
	rhiTZJLOQ=
X-Google-Smtp-Source: AGHT+IG+YQD8Ff1I4Iswviy17/gYOkHZnP9R8fQXLEM32G8qZxCJRmuB/wNKQA4NRcL1AKF02jcWBREMd9VWVodTEO0=
X-Received: by 2002:a05:6e02:b25:b0:3d2:b23f:a1e0 with SMTP id
 e9e14a558f8ab-3d2d72ce284mr124055ab.16.1740164547400; Fri, 21 Feb 2025
 11:02:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221163352.3818347-1-yosry.ahmed@linux.dev>
 <20250221163352.3818347-4-yosry.ahmed@linux.dev> <CALMp9eSPVDYC7v4Rm13ZUcE4wWPb8dUfm=qBx_jETAQEQrt4_w@mail.gmail.com>
 <Z7jISUVBeAbw8zt6@google.com>
In-Reply-To: <Z7jISUVBeAbw8zt6@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 21 Feb 2025 11:02:16 -0800
X-Gm-Features: AWEUYZkl1gRszTfN_btT3ay8IzV9cqEHInmNj-CuLmifQ8lA5-JtTnkIexLq_-0
Message-ID: <CALMp9eQmsFd1QyCPOsPXBnkUdGmsW-ZBW5CoDR4pmSwF7ic0XA@mail.gmail.com>
Subject: Re: [PATCH 3/3] KVM: x86: Generalize IBRS virtualization on emulated VM-exit
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: x86@kernel.org, Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, "Kaplan, David" <David.Kaplan@amd.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 10:39=E2=80=AFAM Yosry Ahmed <yosry.ahmed@linux.dev=
> wrote:
>
> On Fri, Feb 21, 2025 at 09:59:04AM -0800, Jim Mattson wrote:
> > On Fri, Feb 21, 2025 at 8:34=E2=80=AFAM Yosry Ahmed <yosry.ahmed@linux.=
dev> wrote:
> > >
> > > Commit 2e7eab81425a ("KVM: VMX: Execute IBPB on emulated VM-exit when
> > > guest has IBRS") added an IBPB in the emulated VM-exit path on Intel =
to
> > > properly virtualize IBRS by providing separate predictor modes for L1
> > > and L2.
> > >
> > > AMD requires similar handling, except when IbrsSameMode is enumerated=
 by
> > > the host CPU (which is the case on most/all AMD CPUs). With
> > > IbrsSameMode, hardware IBRS is sufficient and no extra handling is
> > > needed from KVM.
> > >
> > > Generalize the handling in nested_vmx_vmexit() by moving it into a
> > > generic function, add the AMD handling, and use it in
> > > nested_svm_vmexit() too. The main reason for using a generic function=
 is
> > > to have a single place to park the huge comment about virtualizing IB=
RS.
> > >
> > > Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
> > > ---
> > >  arch/x86/kvm/svm/nested.c |  2 ++
> > >  arch/x86/kvm/vmx/nested.c | 11 +----------
> > >  arch/x86/kvm/x86.h        | 18 ++++++++++++++++++
> > >  3 files changed, 21 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> > > index d77b094d9a4d6..61b73ff30807e 100644
> > > --- a/arch/x86/kvm/svm/nested.c
> > > +++ b/arch/x86/kvm/svm/nested.c
> > > @@ -1041,6 +1041,8 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
> > >
> > >         nested_svm_copy_common_state(svm->nested.vmcb02.ptr, svm->vmc=
b01.ptr);
> > >
> > > +       kvm_nested_vmexit_handle_spec_ctrl(vcpu);
> > > +
> > >         svm_switch_vmcb(svm, &svm->vmcb01);
> > >
> > >         /*
> > > diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> > > index 8a7af02d466e9..453d52a6e836a 100644
> > > --- a/arch/x86/kvm/vmx/nested.c
> > > +++ b/arch/x86/kvm/vmx/nested.c
> > > @@ -5018,16 +5018,7 @@ void nested_vmx_vmexit(struct kvm_vcpu *vcpu, =
u32 vm_exit_reason,
> > >
> > >         vmx_switch_vmcs(vcpu, &vmx->vmcs01);
> > >
> > > -       /*
> > > -        * If IBRS is advertised to the vCPU, KVM must flush the indi=
rect
> > > -        * branch predictors when transitioning from L2 to L1, as L1 =
expects
> > > -        * hardware (KVM in this case) to provide separate predictor =
modes.
> > > -        * Bare metal isolates VMX root (host) from VMX non-root (gue=
st), but
> > > -        * doesn't isolate different VMCSs, i.e. in this case, doesn'=
t provide
> > > -        * separate modes for L2 vs L1.
> > > -        */
> > > -       if (guest_cpu_cap_has(vcpu, X86_FEATURE_SPEC_CTRL))
> > > -               indirect_branch_prediction_barrier();
> > > +       kvm_nested_vmexit_handle_spec_ctrl(vcpu);
> > >
> > >         /* Update any VMCS fields that might have changed while L2 ra=
n */
> > >         vmcs_write32(VM_EXIT_MSR_LOAD_COUNT, vmx->msr_autoload.host.n=
r);
> > > diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
> > > index 7a87c5fc57f1b..008c8d381c253 100644
> > > --- a/arch/x86/kvm/x86.h
> > > +++ b/arch/x86/kvm/x86.h
> > > @@ -116,6 +116,24 @@ static inline void kvm_leave_nested(struct kvm_v=
cpu *vcpu)
> > >         kvm_x86_ops.nested_ops->leave_nested(vcpu);
> > >  }
> > >
> > > +/*
> > > + * If IBRS is advertised to the vCPU, KVM must flush the indirect br=
anch
> > > + * predictors when transitioning from L2 to L1, as L1 expects hardwa=
re (KVM in
> > > + * this case) to provide separate predictor modes.  Bare metal isola=
tes the host
> > > + * from the guest, but doesn't isolate different guests from one ano=
ther (in
> > > + * this case L1 and L2). The exception is if bare metal supports sam=
e mode IBRS,
> > > + * which offers protection within the same mode, and hence protects =
L1 from L2.
> > > + */
> > > +static inline void kvm_nested_vmexit_handle_spec_ctrl(struct kvm_vcp=
u *vcpu)
> >
> > Maybe just kvm_nested_vmexit_handle_ibrs?
>
> I was trying to use a generic name to accomodate any future handling
> needed for non-IBRS speculation control virtualization. But I could just
> be overthinking. Happy to take whatever name is agreed upon in during
> reviews.
>
> >
> > > +{
> > > +       if (cpu_feature_enabled(X86_FEATURE_AMD_IBRS_SAME_MODE))
> > > +               return;
> > > +
> > > +       if (guest_cpu_cap_has(vcpu, X86_FEATURE_SPEC_CTRL) ||
> > > +           guest_cpu_cap_has(vcpu, X86_FEATURE_AMD_IBRS))
> >
> > This is a bit conservative, but I don't think there's any ROI in being
> > more pedantic.
>
> Could you elaborate on this?
>
> Is this about doing the IBPB even if L1 does not actually execute an
> IBRS? I thought about this for a bit, but otherwise we'd have to
> intercept the MSR write IIUC, and I am not sure if that's better. Also,
> that's what we are already doing so I just kept it as-is.
>
> Or maybe about whether we need this on AMD only with AUTOIBRS? The APM
> is a bit unclear to me in this regard, but I believe may be needed even
> for 'normal' IBRS.

If IA32_SPEC_CTRL.IBRS is clear at emulated VM-exit, then this IBPB is
unnecessary.

However, since the host (L1) is running in a de-privileged prediction
domain, simply setting IA32_SPEC_CTRL.IBRS in the future won't protect
it from the guest (L2) that just exited. If we don't eagerly perform
an IBPB now, then L0 would have to intercept WRMSR(IA32_SPEC_CTRL)
from L1 so that we can issue an IBPB in the future, if L1 ever sets
IA32_SPEC_CTRL.IBRS.

Eagerly performing an IBPB now seems like the better option.

> >
> > For the series,
> >
> > Reviewed-by: Jim Mattson <jmattson@google.com>
>
> Thanks!
>
> >
> > > +               indirect_branch_prediction_barrier();
> > > +}
> > > +
> > >  static inline bool kvm_vcpu_has_run(struct kvm_vcpu *vcpu)
> > >  {
> > >         return vcpu->arch.last_vmentry_cpu !=3D -1;
> > > --
> > > 2.48.1.601.g30ceb7b040-goog
> > >

