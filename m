Return-Path: <linux-kernel+bounces-516293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21635A36F54
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 17:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D251B17122A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 16:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B801DB34E;
	Sat, 15 Feb 2025 16:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="faWgu+ko"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84BA18F2DF
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 16:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739636221; cv=none; b=tNUMjgxd2RjaW0WgPU9I24U41z6vtY6Mx/981N61Im/AdqD5LHXvESZez5IAnbFAnglb+WRjxPWZ4kcGvgKoc2i8Dnkr6Ol7tUsKjoISplsV1otkvhh23fo+MEBSVcKJ2RJLGKLrOk2c5cVppg0XRDfXDuUZYTPCO6ZX6SZQYME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739636221; c=relaxed/simple;
	bh=pgsl/If+wA3j4FE+G3XExPBAamk7MSPy8GjTdtMB844=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iFsRykiHNqhOBqCpuqpghhV3mHKZTIkwxmzLUoUmdCldjElvBPEZOMhTG0xfI/kwlsPMV3tt5QuWp043s6HwosFUcWeSIJAddjDhjGyZcX/HNOP739xrOSG7p8hFHeR38hSYZqw5PSMjrUaggTZ+CsNswbWL4P8AZczlfkHRYDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=faWgu+ko; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5de3c29ebaeso3984161a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 08:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739636217; x=1740241017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=okAkfz3seOBQI9McoD6NBWS5lv1omzWEsYR9zMa/7M8=;
        b=faWgu+koIFylbEkR4KfuEUbJbF9Ixvc9tvkH93hgMDLODOr5UjQOCOPtjeb7TK6b14
         m5cPXD6N3MoqL+QApDkXm8LF58igRJ4skUDulFVTswGf3BfVqvumqTNOrHh650tan+Da
         ouHmBFrxv3d5ucIcAxJKt2vttTA1BxgLf+CLXK/8h4U87NiVOq7ZlGwhR79R1pt/+2jh
         p/XKKRYQ6ilsIMOy6TcB+4A930o+Bir3g8yw591zSOA0mTiIsS91oxtJ++VPwPtMGTUY
         pAsIHGg3E6FiAbAFnmZS0gKLv8rVB4kSJ1P/yb14viGvG8PXeIKJ5CoNAaMftCMD3Z8h
         6WqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739636217; x=1740241017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=okAkfz3seOBQI9McoD6NBWS5lv1omzWEsYR9zMa/7M8=;
        b=lj6I2rz+lVuGNC7hwv2or1U24IbNZx6NK4fIIim2ULziNUynduqo6Q2UJ5V68mgYg+
         VFPSfgk5GVdfrBXBaFbd+Oi3UeYQ+BayL66VGotrNMRjW5K6O9csRPtj9kwe3nhD8FUR
         kztMuM027vmSaJd7uEJIm2D5lIFwl3kQF7yvymyk+f4tpkuVK78e7g9qM8O0OVmHtTEt
         9aSz9oY1XM8xqN4ILowPzY+wjWGtm6jAlkJVifJiGtkXe4hzZS249Of9DgUP3CCP9U5n
         aEmRQ33sLKXEZLN/Io3edojS2JLxruYTmY2125uTeIAXOUestd/innfNeC/z2LF1DDYw
         alxA==
X-Forwarded-Encrypted: i=1; AJvYcCXh70YCnJ/Z6RxAJUoVwLbmvD8YClzzsazKIDo1JqorMPT4H1GvHcCV/LKED/9ShDPEdhmijesjGpmtsew=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQOsc3cUb9VyguH5v18EpDqMM7Ej0/hBofm5h/kwjWhg7SBJHi
	RhJ/s2cToWcW9MS6af+TmSpFJyS72JV6fLtZ7rKS5aViME5iMQ0yWdCHaRNWNOVyfNfPNkIta0D
	EAspz057oupguLd4+SJkiXbC/PQA=
X-Gm-Gg: ASbGncvRhp3ekOk9/HPa4zaEVP7mvY2mGmW6X1BVgDvvEpcuWtQNNQjyqIplzNlC481
	DLVM0++kTeR2+FKcr/CmNSc8HC66fUTUGS+WEE+4i5EbQ47FW2AR/jAe0GylO4cD66fjlfCBO
X-Google-Smtp-Source: AGHT+IEwF6vLnEXWXotW293B/3xDlg0MfzJfP38jNk+QmBSe2iHne9w0GrH53Co4xrP5jB2HAYsv4KQ4ugP+Dsy31Qc=
X-Received: by 2002:a17:906:c399:b0:ab7:bcc0:9050 with SMTP id
 a640c23a62f3a-abb70b2f1a6mr268258766b.27.1739636216871; Sat, 15 Feb 2025
 08:16:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211143910.16775-1-sebott@redhat.com> <20250211143910.16775-2-sebott@redhat.com>
 <Z7BoydkyT_h0gwOV@linux.dev>
In-Reply-To: <Z7BoydkyT_h0gwOV@linux.dev>
Reply-To: luoyonggang@gmail.com
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Sun, 16 Feb 2025 00:16:44 +0800
X-Gm-Features: AWEUYZmnYv-KvGHpFE_jzJc8vV2oHyHLnjmQy49AKn3ynSRfnXjgHvmlK88ELt8
Message-ID: <CAE2XoE_8ihJZQF856w-_F+cgJW7fLWGz7M7Ztoxzw2vE51_m1A@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] KVM: arm64: Allow userspace to change MIDR_EL1
To: Oliver Upton <oliver.upton@linux.dev>
Cc: Sebastian Ott <sebott@redhat.com>, Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, Cornelia Huck <cohuck@redhat.com>, 
	Eric Auger <eric.auger@redhat.com>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 15, 2025 at 6:15=E2=80=AFPM Oliver Upton <oliver.upton@linux.de=
v> wrote:
>
> Hi Sebastian,
>
> On Tue, Feb 11, 2025 at 03:39:07PM +0100, Sebastian Ott wrote:
> > +static int set_id_reg_non_ftr(struct kvm_vcpu *vcpu, const struct sys_=
reg_desc *rd,
> > +                           u64 val)
> > +{
> > +     u32 id =3D reg_to_encoding(rd);
> > +     int ret;
> > +
> > +     mutex_lock(&vcpu->kvm->arch.config_lock);
>
> There's quite a few early outs, guard() might be a better fit than
> explicitly dropping the lock.
>
> > +     /*
> > +      * Since guest access to MIDR_EL1 is not trapped
> > +      * set up VPIDR_EL2 to hold the MIDR_EL1 value.
> > +      */
> > +     if (id =3D=3D SYS_MIDR_EL1)
> > +             write_sysreg(val, vpidr_el2);
>
> This is problematic for a couple reasons:
>
>  - If the kernel isn't running at EL2, VPIDR_EL2 is undefined
>
>  - VPIDR_EL2 needs to be handled as part of the vCPU context, not
>    written to without a running vCPU. What would happen if two vCPUs
>    have different MIDR values?
>
> Here's a new diff with some hacks thrown in to handle VPIDR_EL2
> correctly. Very lightly tested :)

Thans, I am also faced this issue, but other than this, I am also
facing a issue, after updating
MIDR_EL1, The CP15 register MIDR for aarch32 not updated.
The instruction is `MRC p15,0,<Rt>,c0,c0,0    ; Read CP15 Main ID Register`=
 from
https://developer.arm.com/documentation/ddi0406/b/System-Level-Architecture=
/Protected-Memory-System-Architecture--PMSA-/CP15-registers-for-a-PMSA-impl=
ementation/c0--Main-ID-Register--MIDR-

The value of this instruction is not updated



>
> Thanks,
> Oliver
> ---
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/k=
vm_host.h
> index 7cfa024de4e3..3db8c773339e 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -373,6 +373,7 @@ struct kvm_arch {
>  #define KVM_ARM_ID_REG_NUM     (IDREG_IDX(sys_reg(3, 0, 0, 7, 7)) + 1)
>         u64 id_regs[KVM_ARM_ID_REG_NUM];
>
> +       u64 midr_el1;
>         u64 ctr_el0;
>
>         /* Masks for VNCR-backed and general EL2 sysregs */
> @@ -1469,6 +1470,8 @@ static inline u64 *__vm_id_reg(struct kvm_arch *ka,=
 u32 reg)
>         switch (reg) {
>         case sys_reg(3, 0, 0, 1, 0) ... sys_reg(3, 0, 0, 7, 7):
>                 return &ka->id_regs[IDREG_IDX(reg)];
> +       case SYS_MIDR_EL1:
> +               return &ka->midr_el1;
>         case SYS_CTR_EL0:
>                 return &ka->ctr_el0;
>         default:
> diff --git a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h b/arch/arm64/kvm/=
hyp/include/hyp/sysreg-sr.h
> index 76ff095c6b6e..866411621a39 100644
> --- a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
> +++ b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
> @@ -168,9 +168,11 @@ static inline void __sysreg_restore_user_state(struc=
t kvm_cpu_context *ctxt)
>  }
>
>  static inline void __sysreg_restore_el1_state(struct kvm_cpu_context *ct=
xt,
> -                                             u64 mpidr)
> +                                             u64 midr, u64 mpidr)
>  {
> -       write_sysreg(mpidr,                             vmpidr_el2);
> +       write_sysreg(midr, vpidr_el2);
> +       write_sysreg(mpidr, vmpidr_el2);
> +
>
>         if (has_vhe() ||
>             !cpus_have_final_cap(ARM64_WORKAROUND_SPECULATIVE_AT)) {
> diff --git a/arch/arm64/kvm/hyp/nvhe/sysreg-sr.c b/arch/arm64/kvm/hyp/nvh=
e/sysreg-sr.c
> index dba101565de3..a01be1add5ad 100644
> --- a/arch/arm64/kvm/hyp/nvhe/sysreg-sr.c
> +++ b/arch/arm64/kvm/hyp/nvhe/sysreg-sr.c
> @@ -28,7 +28,15 @@ void __sysreg_save_state_nvhe(struct kvm_cpu_context *=
ctxt)
>
>  void __sysreg_restore_state_nvhe(struct kvm_cpu_context *ctxt)
>  {
> -       __sysreg_restore_el1_state(ctxt, ctxt_sys_reg(ctxt, MPIDR_EL1));
> +       u64 midr;
> +
> +       if (ctxt_is_guest(ctxt))
> +               midr =3D kvm_read_vm_id_reg(kern_hyp_va(ctxt_to_vcpu(ctxt=
)->kvm),
> +                                         SYS_MIDR_EL1);
> +       else
> +               midr =3D read_cpuid_id();
> +
> +       __sysreg_restore_el1_state(ctxt, midr, ctxt_sys_reg(ctxt, MPIDR_E=
L1));
>         __sysreg_restore_common_state(ctxt);
>         __sysreg_restore_user_state(ctxt);
>         __sysreg_restore_el2_return_state(ctxt);
> diff --git a/arch/arm64/kvm/hyp/vhe/sysreg-sr.c b/arch/arm64/kvm/hyp/vhe/=
sysreg-sr.c
> index 90b018e06f2c..1d4b9597eb29 100644
> --- a/arch/arm64/kvm/hyp/vhe/sysreg-sr.c
> +++ b/arch/arm64/kvm/hyp/vhe/sysreg-sr.c
> @@ -87,11 +87,12 @@ static void __sysreg_restore_vel2_state(struct kvm_vc=
pu *vcpu)
>         write_sysreg(__vcpu_sys_reg(vcpu, PAR_EL1),     par_el1);
>         write_sysreg(__vcpu_sys_reg(vcpu, TPIDR_EL1),   tpidr_el1);
>
> -       write_sysreg(__vcpu_sys_reg(vcpu, MPIDR_EL1),           vmpidr_el=
2);
> -       write_sysreg_el1(__vcpu_sys_reg(vcpu, MAIR_EL2),        SYS_MAIR)=
;
> -       write_sysreg_el1(__vcpu_sys_reg(vcpu, VBAR_EL2),        SYS_VBAR)=
;
> -       write_sysreg_el1(__vcpu_sys_reg(vcpu, CONTEXTIDR_EL2),  SYS_CONTE=
XTIDR);
> -       write_sysreg_el1(__vcpu_sys_reg(vcpu, AMAIR_EL2),       SYS_AMAIR=
);
> +       write_sysreg(kvm_read_vm_id_reg(vcpu->kvm, SYS_MIDR_EL1),       v=
pidr_el2);
> +       write_sysreg(__vcpu_sys_reg(vcpu, MPIDR_EL1),                   v=
mpidr_el2);
> +       write_sysreg_el1(__vcpu_sys_reg(vcpu, MAIR_EL2),                S=
YS_MAIR);
> +       write_sysreg_el1(__vcpu_sys_reg(vcpu, VBAR_EL2),                S=
YS_VBAR);
> +       write_sysreg_el1(__vcpu_sys_reg(vcpu, CONTEXTIDR_EL2),          S=
YS_CONTEXTIDR);
> +       write_sysreg_el1(__vcpu_sys_reg(vcpu, AMAIR_EL2),               S=
YS_AMAIR);
>
>         if (vcpu_el2_e2h_is_set(vcpu)) {
>                 /*
> @@ -191,7 +192,7 @@ void __vcpu_load_switch_sysregs(struct kvm_vcpu *vcpu=
)
>  {
>         struct kvm_cpu_context *guest_ctxt =3D &vcpu->arch.ctxt;
>         struct kvm_cpu_context *host_ctxt;
> -       u64 mpidr;
> +       u64 midr, mpidr;
>
>         host_ctxt =3D host_data_ptr(host_ctxt);
>         __sysreg_save_user_state(host_ctxt);
> @@ -222,10 +223,9 @@ void __vcpu_load_switch_sysregs(struct kvm_vcpu *vcp=
u)
>                 if (vcpu_has_nv(vcpu)) {
>                         /*
>                          * Use the guest hypervisor's VPIDR_EL2 when in a
> -                        * nested state. The hardware value of MIDR_EL1 g=
ets
> -                        * restored on put.
> +                        * nested state.
>                          */
> -                       write_sysreg(ctxt_sys_reg(guest_ctxt, VPIDR_EL2),=
 vpidr_el2);
> +                       midr =3D ctxt_sys_reg(guest_ctxt, VPIDR_EL2);
>
>                         /*
>                          * As we're restoring a nested guest, set the val=
ue
> @@ -233,10 +233,11 @@ void __vcpu_load_switch_sysregs(struct kvm_vcpu *vc=
pu)
>                          */
>                         mpidr =3D ctxt_sys_reg(guest_ctxt, VMPIDR_EL2);
>                 } else {
> +                       midr =3D kvm_read_vm_id_reg(vcpu->kvm, SYS_MIDR_E=
L1);
>                         mpidr =3D ctxt_sys_reg(guest_ctxt, MPIDR_EL1);
>                 }
>
> -               __sysreg_restore_el1_state(guest_ctxt, mpidr);
> +               __sysreg_restore_el1_state(guest_ctxt, midr, mpidr);
>         }
>
>         vcpu_set_flag(vcpu, SYSREGS_ON_CPU);
> @@ -271,9 +272,5 @@ void __vcpu_put_switch_sysregs(struct kvm_vcpu *vcpu)
>         /* Restore host user state */
>         __sysreg_restore_user_state(host_ctxt);
>
> -       /* If leaving a nesting guest, restore MIDR_EL1 default view */
> -       if (vcpu_has_nv(vcpu))
> -               write_sysreg(read_cpuid_id(),   vpidr_el2);
> -
>         vcpu_clear_flag(vcpu, SYSREGS_ON_CPU);
>  }
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index f6cd1ea7fb55..aa1a0443dc6a 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -1656,7 +1656,7 @@ static bool is_feature_id_reg(u32 encoding)
>   */
>  static inline bool is_vm_ftr_id_reg(u32 id)
>  {
> -       if (id =3D=3D SYS_CTR_EL0)
> +       if (id =3D=3D SYS_CTR_EL0 || id =3D=3D SYS_MIDR_EL1)
>                 return true;
>
>         return (sys_reg_Op0(id) =3D=3D 3 && sys_reg_Op1(id) =3D=3D 0 &&
> @@ -1989,6 +1989,34 @@ static int get_id_reg(struct kvm_vcpu *vcpu, const=
 struct sys_reg_desc *rd,
>         return 0;
>  }
>
> +static int set_id_reg_non_ftr(struct kvm_vcpu *vcpu, const struct sys_re=
g_desc *rd,
> +                             u64 val)
> +{
> +       u32 id =3D reg_to_encoding(rd);
> +
> +       guard(mutex)(&vcpu->kvm->arch.config_lock);
> +
> +       /*
> +        * Once the VM has started the ID registers are immutable. Reject=
 any
> +        * write that does not match the final register value.
> +        */
> +       if (kvm_vm_has_ran_once(vcpu->kvm)) {
> +               if (val !=3D read_id_reg(vcpu, rd))
> +                       return -EBUSY;
> +
> +               return 0;
> +       }
> +
> +       /*
> +        * For non ftr regs do a limited test against the writable mask o=
nly.
> +        */
> +       if ((rd->val & val) !=3D val)
> +               return -EINVAL;
> +
> +       kvm_set_vm_id_reg(vcpu->kvm, id, val);
> +       return 0;
> +}
> +
>  static int set_id_reg(struct kvm_vcpu *vcpu, const struct sys_reg_desc *=
rd,
>                       u64 val)
>  {
> @@ -2483,6 +2511,15 @@ static bool access_mdcr(struct kvm_vcpu *vcpu,
>         return true;
>  }
>
> +#define FUNCTION_RESET(reg)                                            \
> +       static u64 reset_##reg(struct kvm_vcpu *v,                      \
> +                              const struct sys_reg_desc *r)            \
> +       {                                                               \
> +               return read_sysreg(reg);                                \
> +       }
> +
> +FUNCTION_RESET(midr_el1)
> +
>
>  /*
>   * Architected system registers.
> @@ -2532,6 +2569,8 @@ static const struct sys_reg_desc sys_reg_descs[] =
=3D {
>
>         { SYS_DESC(SYS_DBGVCR32_EL2), undef_access, reset_val, DBGVCR32_E=
L2, 0 },
>
> +       { ID_DESC(MIDR_EL1), .set_user =3D set_id_reg_non_ftr, .visibilit=
y =3D id_visibility,
> +         .reset =3D reset_midr_el1, .val =3D GENMASK_ULL(31, 0) },
>         { SYS_DESC(SYS_MPIDR_EL1), NULL, reset_mpidr, MPIDR_EL1 },
>
>         /*
> @@ -4584,13 +4623,11 @@ id_to_sys_reg_desc(struct kvm_vcpu *vcpu, u64 id,
>                 return ((struct sys_reg_desc *)r)->val;                 \
>         }
>
> -FUNCTION_INVARIANT(midr_el1)
>  FUNCTION_INVARIANT(revidr_el1)
>  FUNCTION_INVARIANT(aidr_el1)
>
>  /* ->val is filled in by kvm_sys_reg_table_init() */
>  static struct sys_reg_desc invariant_sys_regs[] __ro_after_init =3D {
> -       { SYS_DESC(SYS_MIDR_EL1), NULL, reset_midr_el1 },
>         { SYS_DESC(SYS_REVIDR_EL1), NULL, reset_revidr_el1 },
>         { SYS_DESC(SYS_AIDR_EL1), NULL, reset_aidr_el1 },
>  };
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

