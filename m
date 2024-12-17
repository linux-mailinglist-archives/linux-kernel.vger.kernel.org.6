Return-Path: <linux-kernel+bounces-448856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F27D99F4678
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 703DE16871A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 08:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04351DD872;
	Tue, 17 Dec 2024 08:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X3gRde4i"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165041714BE
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 08:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734425358; cv=none; b=CdS7riLIYS5spGtAxdlo7WE5JRV8t9WEHDEboc9B+JYe+qNXwNdg/NKaX317OpGY4K6TCjZxjtvBqvTb98OIIaev2u5UVHmRpfOkcRxQB7Wz3yuPvIPPeZIT6rw5oNzfoTZ2PVGCA9vvByVL8JncDcDH+n8QN+7YTjODkjkUBe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734425358; c=relaxed/simple;
	bh=qnyJI2CV7nFoLCZEwEiK8T4hfhzDcQMFnniWR1YR5OY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oYFGvEDTEWMisgKdascC8rbZNXA9pknG2i4M3kNA9bRILb7+mawM23M4suKAaALlo66Qj/ND2u2iixKyXhCxL2Vltw7XuxfQ+cdgdWGf8C8HCyOfzmicVoK5XiGyyHRzdotIx7pvFFeuIu55Eid14FCtMXPFs/XXB2jTC8UV5bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X3gRde4i; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43621d2dd4cso38765e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 00:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734425354; x=1735030154; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QMj2MTphaNhvmvfco+RU0jx/OostWtK52BEcvWTxpsk=;
        b=X3gRde4ieMX4KkesC7VlfhAuefg/iZplHOZwC6TuJcpcWlLaBy3ED0OGkwBoxllZ/y
         FEbuhsui+mTyBqZjjSmmZOjkVR9A6DG87yJEuY4Y9XTB5dRqkeCFkhTAguLBTELxdZ15
         1WvEaPHGhawgL7TRtHuua8fhlqnIMRfskzB6pZ+vO3ZC5X3dAdEdrAKkiwYKJsOVVNIv
         P+GLd8DGf2N/6ru5aBTPhASUuSWA/B2yZIgsBkDv+JN3S+bSAhWohGHPsme9GZSXoaqJ
         +dTmjBBjRq0CIvTmdmIOQPGUA9BKpHILdTQinotmJrz0t8fs0X8XdSWDeqpMDkG3qK/5
         HcUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734425354; x=1735030154;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QMj2MTphaNhvmvfco+RU0jx/OostWtK52BEcvWTxpsk=;
        b=o3m3bV1ORrwdOB51x/MEwSguny8mF7DKdfDvUkbkcmrHF7XoV2Sff80mnT3KGwRf1i
         +sIzHUCnBZESrQolcv/a2bVySnloCBG2UGEc9pxrZBwjBlksXzqQpNPwSnKA14e9C9WR
         mwMZtLXFIrItx56N9OT3V4PfO7L4+OPjfxRtCPDyUXPKBKsITTbJNqUDRLDwrLoXfNsk
         gySiaY0OTkv8CyKW5pyxtbLRmEKAX1FnpB0O20cEGaPAkLm0GwJxEnlZ3kTssNd4L+ZE
         ahSQSjmQgNMUtx8Z2NqN5Qa5XeXX21StMPOD4dVID//wR7jzbNc/b1QC9ZEVsJmASVNe
         teCA==
X-Forwarded-Encrypted: i=1; AJvYcCW0O6qqAbugWkqBOMJXDhBAqxy/K01AA3NjkUsqfUdgBxVXT1Mf+bzwI4c++RnVdbLGJJK5vN/RiWwi5OM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLVLBSKweHxh5132RWoK2JB16nBY8XBn45L/PFh9OW9kcdT7V+
	dgTHop6kn0jAjn+7JRbYS0MUJaDq4J1CtBY7TFEQs11qPmc4qdlb8+fVk5q6g8xCmYO6qFmUVVu
	NUNZr8sWCMU3Pdq4CvH0AbqB/AjbXKXmI9/4F
X-Gm-Gg: ASbGncuytkq1d30WvgdhJiOchppswIgiq0krOSTLQDzdaL90JHE2rL8QiUsD/h3K25n
	weZuaSIEI9FN3NCzL+CTPfS6OnYx0kbbyj7IIX+tPZy+HkITVgncA1AErYxLpf3V8wto=
X-Google-Smtp-Source: AGHT+IHOqDBvsuCRwVSdzFIxc4m1v0LDPBTHgkxWdnJjCe9PWB8vWCwUxFKGVT5eyDUf8rbIIEvX6JFaEaD3ig31yzY=
X-Received: by 2002:a05:600c:5690:b0:434:9e1d:44ef with SMTP id
 5b1f17b1804b1-4364ad4d797mr745545e9.7.1734425354203; Tue, 17 Dec 2024
 00:49:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216175803.2716565-1-qperret@google.com> <20241216175803.2716565-10-qperret@google.com>
In-Reply-To: <20241216175803.2716565-10-qperret@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Tue, 17 Dec 2024 08:48:37 +0000
Message-ID: <CA+EHjTyTtQrG+8ONNg8hLiCMwcPfsuf+O-Xh0TOm+RzjW5=MWw@mail.gmail.com>
Subject: Re: [PATCH v3 09/18] KVM: arm64: Introduce __pkvm_vcpu_{load,put}()
To: Quentin Perret <qperret@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Vincent Donnefort <vdonnefort@google.com>, 
	Sebastian Ene <sebastianene@google.com>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Dec 2024 at 17:58, Quentin Perret <qperret@google.com> wrote:
>
> From: Marc Zyngier <maz@kernel.org>
>
> Rather than look-up the hyp vCPU on every run hypercall at EL2,
> introduce a per-CPU 'loaded_hyp_vcpu' tracking variable which is updated
> by a pair of load/put hypercalls called directly from
> kvm_arch_vcpu_{load,put}() when pKVM is enabled.
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Quentin Perret <qperret@google.com>

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

> ---
>  arch/arm64/include/asm/kvm_asm.h       |  2 ++
>  arch/arm64/kvm/arm.c                   | 14 ++++++++
>  arch/arm64/kvm/hyp/include/nvhe/pkvm.h |  7 ++++
>  arch/arm64/kvm/hyp/nvhe/hyp-main.c     | 47 ++++++++++++++++++++------
>  arch/arm64/kvm/hyp/nvhe/pkvm.c         | 29 ++++++++++++++++
>  arch/arm64/kvm/vgic/vgic-v3.c          |  6 ++--
>  6 files changed, 93 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
> index ca2590344313..89c0fac69551 100644
> --- a/arch/arm64/include/asm/kvm_asm.h
> +++ b/arch/arm64/include/asm/kvm_asm.h
> @@ -79,6 +79,8 @@ enum __kvm_host_smccc_func {
>         __KVM_HOST_SMCCC_FUNC___pkvm_init_vm,
>         __KVM_HOST_SMCCC_FUNC___pkvm_init_vcpu,
>         __KVM_HOST_SMCCC_FUNC___pkvm_teardown_vm,
> +       __KVM_HOST_SMCCC_FUNC___pkvm_vcpu_load,
> +       __KVM_HOST_SMCCC_FUNC___pkvm_vcpu_put,
>  };
>
>  #define DECLARE_KVM_VHE_SYM(sym)       extern char sym[]
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index a102c3aebdbc..55cc62b2f469 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -619,12 +619,26 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
>
>         kvm_arch_vcpu_load_debug_state_flags(vcpu);
>
> +       if (is_protected_kvm_enabled()) {
> +               kvm_call_hyp_nvhe(__pkvm_vcpu_load,
> +                                 vcpu->kvm->arch.pkvm.handle,
> +                                 vcpu->vcpu_idx, vcpu->arch.hcr_el2);
> +               kvm_call_hyp(__vgic_v3_restore_vmcr_aprs,
> +                            &vcpu->arch.vgic_cpu.vgic_v3);
> +       }
> +
>         if (!cpumask_test_cpu(cpu, vcpu->kvm->arch.supported_cpus))
>                 vcpu_set_on_unsupported_cpu(vcpu);
>  }
>
>  void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
>  {
> +       if (is_protected_kvm_enabled()) {
> +               kvm_call_hyp(__vgic_v3_save_vmcr_aprs,
> +                            &vcpu->arch.vgic_cpu.vgic_v3);
> +               kvm_call_hyp_nvhe(__pkvm_vcpu_put);
> +       }
> +
>         kvm_arch_vcpu_put_debug_state_flags(vcpu);
>         kvm_arch_vcpu_put_fp(vcpu);
>         if (has_vhe())
> diff --git a/arch/arm64/kvm/hyp/include/nvhe/pkvm.h b/arch/arm64/kvm/hyp/include/nvhe/pkvm.h
> index f361d8b91930..be52c5b15e21 100644
> --- a/arch/arm64/kvm/hyp/include/nvhe/pkvm.h
> +++ b/arch/arm64/kvm/hyp/include/nvhe/pkvm.h
> @@ -20,6 +20,12 @@ struct pkvm_hyp_vcpu {
>
>         /* Backpointer to the host's (untrusted) vCPU instance. */
>         struct kvm_vcpu *host_vcpu;
> +
> +       /*
> +        * If this hyp vCPU is loaded, then this is a backpointer to the
> +        * per-cpu pointer tracking us. Otherwise, NULL if not loaded.
> +        */
> +       struct pkvm_hyp_vcpu **loaded_hyp_vcpu;
>  };
>
>  /*
> @@ -69,6 +75,7 @@ int __pkvm_teardown_vm(pkvm_handle_t handle);
>  struct pkvm_hyp_vcpu *pkvm_load_hyp_vcpu(pkvm_handle_t handle,
>                                          unsigned int vcpu_idx);
>  void pkvm_put_hyp_vcpu(struct pkvm_hyp_vcpu *hyp_vcpu);
> +struct pkvm_hyp_vcpu *pkvm_get_loaded_hyp_vcpu(void);
>
>  struct pkvm_hyp_vm *get_pkvm_hyp_vm(pkvm_handle_t handle);
>  void put_pkvm_hyp_vm(struct pkvm_hyp_vm *hyp_vm);
> diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> index 6aa0b13d86e5..95d78db315b3 100644
> --- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> +++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> @@ -141,16 +141,46 @@ static void sync_hyp_vcpu(struct pkvm_hyp_vcpu *hyp_vcpu)
>                 host_cpu_if->vgic_lr[i] = hyp_cpu_if->vgic_lr[i];
>  }
>
> +static void handle___pkvm_vcpu_load(struct kvm_cpu_context *host_ctxt)
> +{
> +       DECLARE_REG(pkvm_handle_t, handle, host_ctxt, 1);
> +       DECLARE_REG(unsigned int, vcpu_idx, host_ctxt, 2);
> +       DECLARE_REG(u64, hcr_el2, host_ctxt, 3);
> +       struct pkvm_hyp_vcpu *hyp_vcpu;
> +
> +       if (!is_protected_kvm_enabled())
> +               return;
> +
> +       hyp_vcpu = pkvm_load_hyp_vcpu(handle, vcpu_idx);
> +       if (!hyp_vcpu)
> +               return;
> +
> +       if (pkvm_hyp_vcpu_is_protected(hyp_vcpu)) {
> +               /* Propagate WFx trapping flags */
> +               hyp_vcpu->vcpu.arch.hcr_el2 &= ~(HCR_TWE | HCR_TWI);
> +               hyp_vcpu->vcpu.arch.hcr_el2 |= hcr_el2 & (HCR_TWE | HCR_TWI);
> +       }
> +}
> +
> +static void handle___pkvm_vcpu_put(struct kvm_cpu_context *host_ctxt)
> +{
> +       struct pkvm_hyp_vcpu *hyp_vcpu;
> +
> +       if (!is_protected_kvm_enabled())
> +               return;
> +
> +       hyp_vcpu = pkvm_get_loaded_hyp_vcpu();
> +       if (hyp_vcpu)
> +               pkvm_put_hyp_vcpu(hyp_vcpu);
> +}
> +
>  static void handle___kvm_vcpu_run(struct kvm_cpu_context *host_ctxt)
>  {
>         DECLARE_REG(struct kvm_vcpu *, host_vcpu, host_ctxt, 1);
>         int ret;
>
> -       host_vcpu = kern_hyp_va(host_vcpu);
> -
>         if (unlikely(is_protected_kvm_enabled())) {
> -               struct pkvm_hyp_vcpu *hyp_vcpu;
> -               struct kvm *host_kvm;
> +               struct pkvm_hyp_vcpu *hyp_vcpu = pkvm_get_loaded_hyp_vcpu();
>
>                 /*
>                  * KVM (and pKVM) doesn't support SME guests for now, and
> @@ -163,9 +193,6 @@ static void handle___kvm_vcpu_run(struct kvm_cpu_context *host_ctxt)
>                         goto out;
>                 }
>
> -               host_kvm = kern_hyp_va(host_vcpu->kvm);
> -               hyp_vcpu = pkvm_load_hyp_vcpu(host_kvm->arch.pkvm.handle,
> -                                             host_vcpu->vcpu_idx);
>                 if (!hyp_vcpu) {
>                         ret = -EINVAL;
>                         goto out;
> @@ -176,12 +203,10 @@ static void handle___kvm_vcpu_run(struct kvm_cpu_context *host_ctxt)
>                 ret = __kvm_vcpu_run(&hyp_vcpu->vcpu);
>
>                 sync_hyp_vcpu(hyp_vcpu);
> -               pkvm_put_hyp_vcpu(hyp_vcpu);
>         } else {
>                 /* The host is fully trusted, run its vCPU directly. */
> -               ret = __kvm_vcpu_run(host_vcpu);
> +               ret = __kvm_vcpu_run(kern_hyp_va(host_vcpu));
>         }
> -
>  out:
>         cpu_reg(host_ctxt, 1) =  ret;
>  }
> @@ -409,6 +434,8 @@ static const hcall_t host_hcall[] = {
>         HANDLE_FUNC(__pkvm_init_vm),
>         HANDLE_FUNC(__pkvm_init_vcpu),
>         HANDLE_FUNC(__pkvm_teardown_vm),
> +       HANDLE_FUNC(__pkvm_vcpu_load),
> +       HANDLE_FUNC(__pkvm_vcpu_put),
>  };
>
>  static void handle_host_hcall(struct kvm_cpu_context *host_ctxt)
> diff --git a/arch/arm64/kvm/hyp/nvhe/pkvm.c b/arch/arm64/kvm/hyp/nvhe/pkvm.c
> index d46a02e24e4a..496d186efb03 100644
> --- a/arch/arm64/kvm/hyp/nvhe/pkvm.c
> +++ b/arch/arm64/kvm/hyp/nvhe/pkvm.c
> @@ -23,6 +23,12 @@ unsigned int kvm_arm_vmid_bits;
>
>  unsigned int kvm_host_sve_max_vl;
>
> +/*
> + * The currently loaded hyp vCPU for each physical CPU. Used only when
> + * protected KVM is enabled, but for both protected and non-protected VMs.
> + */
> +static DEFINE_PER_CPU(struct pkvm_hyp_vcpu *, loaded_hyp_vcpu);
> +
>  /*
>   * Set trap register values based on features in ID_AA64PFR0.
>   */
> @@ -306,15 +312,30 @@ struct pkvm_hyp_vcpu *pkvm_load_hyp_vcpu(pkvm_handle_t handle,
>         struct pkvm_hyp_vcpu *hyp_vcpu = NULL;
>         struct pkvm_hyp_vm *hyp_vm;
>
> +       /* Cannot load a new vcpu without putting the old one first. */
> +       if (__this_cpu_read(loaded_hyp_vcpu))
> +               return NULL;
> +
>         hyp_spin_lock(&vm_table_lock);
>         hyp_vm = get_vm_by_handle(handle);
>         if (!hyp_vm || hyp_vm->nr_vcpus <= vcpu_idx)
>                 goto unlock;
>
>         hyp_vcpu = hyp_vm->vcpus[vcpu_idx];
> +
> +       /* Ensure vcpu isn't loaded on more than one cpu simultaneously. */
> +       if (unlikely(hyp_vcpu->loaded_hyp_vcpu)) {
> +               hyp_vcpu = NULL;
> +               goto unlock;
> +       }
> +
> +       hyp_vcpu->loaded_hyp_vcpu = this_cpu_ptr(&loaded_hyp_vcpu);
>         hyp_page_ref_inc(hyp_virt_to_page(hyp_vm));
>  unlock:
>         hyp_spin_unlock(&vm_table_lock);
> +
> +       if (hyp_vcpu)
> +               __this_cpu_write(loaded_hyp_vcpu, hyp_vcpu);
>         return hyp_vcpu;
>  }
>
> @@ -323,10 +344,18 @@ void pkvm_put_hyp_vcpu(struct pkvm_hyp_vcpu *hyp_vcpu)
>         struct pkvm_hyp_vm *hyp_vm = pkvm_hyp_vcpu_to_hyp_vm(hyp_vcpu);
>
>         hyp_spin_lock(&vm_table_lock);
> +       hyp_vcpu->loaded_hyp_vcpu = NULL;
> +       __this_cpu_write(loaded_hyp_vcpu, NULL);
>         hyp_page_ref_dec(hyp_virt_to_page(hyp_vm));
>         hyp_spin_unlock(&vm_table_lock);
>  }
>
> +struct pkvm_hyp_vcpu *pkvm_get_loaded_hyp_vcpu(void)
> +{
> +       return __this_cpu_read(loaded_hyp_vcpu);
> +
> +}
> +
>  struct pkvm_hyp_vm *get_pkvm_hyp_vm(pkvm_handle_t handle)
>  {
>         struct pkvm_hyp_vm *hyp_vm;
> diff --git a/arch/arm64/kvm/vgic/vgic-v3.c b/arch/arm64/kvm/vgic/vgic-v3.c
> index f267bc2486a1..c2ef41fff079 100644
> --- a/arch/arm64/kvm/vgic/vgic-v3.c
> +++ b/arch/arm64/kvm/vgic/vgic-v3.c
> @@ -734,7 +734,8 @@ void vgic_v3_load(struct kvm_vcpu *vcpu)
>  {
>         struct vgic_v3_cpu_if *cpu_if = &vcpu->arch.vgic_cpu.vgic_v3;
>
> -       kvm_call_hyp(__vgic_v3_restore_vmcr_aprs, cpu_if);
> +       if (likely(!is_protected_kvm_enabled()))
> +               kvm_call_hyp(__vgic_v3_restore_vmcr_aprs, cpu_if);
>
>         if (has_vhe())
>                 __vgic_v3_activate_traps(cpu_if);
> @@ -746,7 +747,8 @@ void vgic_v3_put(struct kvm_vcpu *vcpu)
>  {
>         struct vgic_v3_cpu_if *cpu_if = &vcpu->arch.vgic_cpu.vgic_v3;
>
> -       kvm_call_hyp(__vgic_v3_save_vmcr_aprs, cpu_if);
> +       if (likely(!is_protected_kvm_enabled()))
> +               kvm_call_hyp(__vgic_v3_save_vmcr_aprs, cpu_if);
>         WARN_ON(vgic_v4_put(vcpu));
>
>         if (has_vhe())
> --
> 2.47.1.613.gc27f4b7a9f-goog
>

