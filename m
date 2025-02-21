Return-Path: <linux-kernel+bounces-526386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04814A3FE0C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBB7518964F2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83DA2505AB;
	Fri, 21 Feb 2025 17:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KiIJ90zM"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4951EE028
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 17:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740160760; cv=none; b=saYg0XcxWeHREFGKUchWta/sMlGUJoaUC9xiyaM33y3F5WtUYqtHMsdxp/Ho5fMz6qeeyGDIKVG7rk4ebprwiA7qYUmcbSo5FVuAPH1+1+gIyUVGNb+OhOtH2luCQbUhXgLLLg/rU1dyLotnVuBaeb8q7aFIEI1W3vROfsBnJTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740160760; c=relaxed/simple;
	bh=CyMlJMe49dtCI1C7oW6yHzdSBo+lOci8YsZ/sxkb6c4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sGsCpKMFkfBNO1G0GG7GpmwOy9b5cSzGxubCSqbE4dwqL039BAtbWNz9IrYEosry+WTZ4smKK002vKMHaOd/vDAJmvFZo21zyIk68SBrFHzcP5DkErFVune1wVeb4Pd4Q8pOCGUpNiOW632gPu7H1iSMDEYF/rpolY9Q42D6dS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KiIJ90zM; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3d19702f977so3065ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 09:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740160758; x=1740765558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CFPr39VkmmOxeSrSHJh0/Wu5Z4JXTxhJP6/WQ8TPNMw=;
        b=KiIJ90zMvWd0nTfAHa2DEiglD6YWIjY8/aAykBP/qOPFubclplTB7aPaJUh7N5O40p
         XcAemYZsfWxwrO7CDtzr6PVYplXnXtUI24LdSZof86qmn3XRYCrnln5IvyS5k2Nz0q0S
         FncQy1VNlXZqe3ICzxaCEjruUFCjyMUHXTa6oBTSP2zfbJvajtgOJFPxXyg/plaVr5x3
         6iB8zxIRHp8agPLBa3ft9WOgA55BU1mAa7h2CcMS9g4SvLqg30sjrACs7Agdo94q1+yN
         Nr06qv8LTn+LiGrunFoA7sCaUEuwuwnUf2xPFOCBenuzL2fcOYaxH3/3UJD88VDVBxDl
         4lmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740160758; x=1740765558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CFPr39VkmmOxeSrSHJh0/Wu5Z4JXTxhJP6/WQ8TPNMw=;
        b=Ypu+CPQH+bqnPzq2SDP9eGvIH7gNNR/FFCWuWjgcJvxNAr2sXtjHqpo9+Ajvh+1/jS
         4aSZbzPqil4TL487Wr9N9pUEA/h3UuBCsfTsDlZnkcUQYoBrroU6x/Pow2DE0slfisU1
         jO/EeQ8iu5qXtgiQ5jGkncpgFCVUxfMQ/oX8DiNQspMJkzBqnsusxQKOtgEye4N9F2KA
         VVVhjyN7c0PQw7IunO2f/U+wj0vGgKc1VHb0rQ+MB+ZPsmaYkpqW1hKk0+w22ZtbFpeV
         ztPueorlbAPJRytNY0eM0N+iXQ7S3HjButObFOVXKrFTJPgFvFRpu6ZcF1nPx7LmGXYG
         Ef8g==
X-Forwarded-Encrypted: i=1; AJvYcCWz7z/oyHis9quzOWBPD31yO/ye9MmI/ZHXZIoCl06yFQg1Fk0rmNqOrtxyheCRdj2VbavuzpA7cy2ba6A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8KfnjZro1alQ+xkkiRBRrRWHM1JNTtUfHVMAzOVkg4Y67JaN/
	mQ2/nZWBiLdvXshEKBd0jHI0cb7TsD9wwzuwM3tfRrQksZT6SH2G3x78bGMO7PGgc2qhO0Xh/xk
	s0VIQ0Pm+Uu11mjkn9fNMmDdy/BXY0YrSbElr
X-Gm-Gg: ASbGncsalRVLiDBX/PZnjga1zfhwjk0VUg/izjIEBQr6JJNMbA8sewGoEaNH5K1xYcZ
	/KUc+KydlRlYxVa6c/2o3A6mRjeKrADPjY28Tsoj+65SKh5hozoSTtJo9By6JsUnK78dDTSur83
	z2TbbFNiI=
X-Google-Smtp-Source: AGHT+IFnOum0ttM4Vesa4j7BS4V1b1HS+JdyQLXvhh94IUPbFFJZJtKhFR7C2WnWnWLciQ4OgC/AGEzv5ut3LKeZKto=
X-Received: by 2002:a92:c26d:0:b0:3a7:a468:69df with SMTP id
 e9e14a558f8ab-3d2cc651b7bmr3185285ab.3.1740160757626; Fri, 21 Feb 2025
 09:59:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221163352.3818347-1-yosry.ahmed@linux.dev> <20250221163352.3818347-4-yosry.ahmed@linux.dev>
In-Reply-To: <20250221163352.3818347-4-yosry.ahmed@linux.dev>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 21 Feb 2025 09:59:04 -0800
X-Gm-Features: AWEUYZkxFQiGf-_lxDEUzcA7SqwrlvLQH5PgX1Cfgm8nfiHstooh97YlLZePtUM
Message-ID: <CALMp9eSPVDYC7v4Rm13ZUcE4wWPb8dUfm=qBx_jETAQEQrt4_w@mail.gmail.com>
Subject: Re: [PATCH 3/3] KVM: x86: Generalize IBRS virtualization on emulated VM-exit
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: x86@kernel.org, Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, "Kaplan, David" <David.Kaplan@amd.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 8:34=E2=80=AFAM Yosry Ahmed <yosry.ahmed@linux.dev>=
 wrote:
>
> Commit 2e7eab81425a ("KVM: VMX: Execute IBPB on emulated VM-exit when
> guest has IBRS") added an IBPB in the emulated VM-exit path on Intel to
> properly virtualize IBRS by providing separate predictor modes for L1
> and L2.
>
> AMD requires similar handling, except when IbrsSameMode is enumerated by
> the host CPU (which is the case on most/all AMD CPUs). With
> IbrsSameMode, hardware IBRS is sufficient and no extra handling is
> needed from KVM.
>
> Generalize the handling in nested_vmx_vmexit() by moving it into a
> generic function, add the AMD handling, and use it in
> nested_svm_vmexit() too. The main reason for using a generic function is
> to have a single place to park the huge comment about virtualizing IBRS.
>
> Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
> ---
>  arch/x86/kvm/svm/nested.c |  2 ++
>  arch/x86/kvm/vmx/nested.c | 11 +----------
>  arch/x86/kvm/x86.h        | 18 ++++++++++++++++++
>  3 files changed, 21 insertions(+), 10 deletions(-)
>
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index d77b094d9a4d6..61b73ff30807e 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -1041,6 +1041,8 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
>
>         nested_svm_copy_common_state(svm->nested.vmcb02.ptr, svm->vmcb01.=
ptr);
>
> +       kvm_nested_vmexit_handle_spec_ctrl(vcpu);
> +
>         svm_switch_vmcb(svm, &svm->vmcb01);
>
>         /*
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 8a7af02d466e9..453d52a6e836a 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -5018,16 +5018,7 @@ void nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 =
vm_exit_reason,
>
>         vmx_switch_vmcs(vcpu, &vmx->vmcs01);
>
> -       /*
> -        * If IBRS is advertised to the vCPU, KVM must flush the indirect
> -        * branch predictors when transitioning from L2 to L1, as L1 expe=
cts
> -        * hardware (KVM in this case) to provide separate predictor mode=
s.
> -        * Bare metal isolates VMX root (host) from VMX non-root (guest),=
 but
> -        * doesn't isolate different VMCSs, i.e. in this case, doesn't pr=
ovide
> -        * separate modes for L2 vs L1.
> -        */
> -       if (guest_cpu_cap_has(vcpu, X86_FEATURE_SPEC_CTRL))
> -               indirect_branch_prediction_barrier();
> +       kvm_nested_vmexit_handle_spec_ctrl(vcpu);
>
>         /* Update any VMCS fields that might have changed while L2 ran */
>         vmcs_write32(VM_EXIT_MSR_LOAD_COUNT, vmx->msr_autoload.host.nr);
> diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
> index 7a87c5fc57f1b..008c8d381c253 100644
> --- a/arch/x86/kvm/x86.h
> +++ b/arch/x86/kvm/x86.h
> @@ -116,6 +116,24 @@ static inline void kvm_leave_nested(struct kvm_vcpu =
*vcpu)
>         kvm_x86_ops.nested_ops->leave_nested(vcpu);
>  }
>
> +/*
> + * If IBRS is advertised to the vCPU, KVM must flush the indirect branch
> + * predictors when transitioning from L2 to L1, as L1 expects hardware (=
KVM in
> + * this case) to provide separate predictor modes.  Bare metal isolates =
the host
> + * from the guest, but doesn't isolate different guests from one another=
 (in
> + * this case L1 and L2). The exception is if bare metal supports same mo=
de IBRS,
> + * which offers protection within the same mode, and hence protects L1 f=
rom L2.
> + */
> +static inline void kvm_nested_vmexit_handle_spec_ctrl(struct kvm_vcpu *v=
cpu)

Maybe just kvm_nested_vmexit_handle_ibrs?

> +{
> +       if (cpu_feature_enabled(X86_FEATURE_AMD_IBRS_SAME_MODE))
> +               return;
> +
> +       if (guest_cpu_cap_has(vcpu, X86_FEATURE_SPEC_CTRL) ||
> +           guest_cpu_cap_has(vcpu, X86_FEATURE_AMD_IBRS))

This is a bit conservative, but I don't think there's any ROI in being
more pedantic.

For the series,

Reviewed-by: Jim Mattson <jmattson@google.com>

> +               indirect_branch_prediction_barrier();
> +}
> +
>  static inline bool kvm_vcpu_has_run(struct kvm_vcpu *vcpu)
>  {
>         return vcpu->arch.last_vmentry_cpu !=3D -1;
> --
> 2.48.1.601.g30ceb7b040-goog
>

