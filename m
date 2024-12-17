Return-Path: <linux-kernel+bounces-448872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 469DB9F46A0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD85718898AD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 08:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3A219B5B4;
	Tue, 17 Dec 2024 08:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wKZasLBk"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC780335C0
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 08:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734425840; cv=none; b=ImsF5umZOLT5jC/M0jwLE+NAzzA6rZGQBD2bZqIUnqqx9RbMg5x5rmEByCWju5watQL5V8AjXP6cE3H3N/MOD9A+uzjIeb6ampprkrTl/uWIyF9ygLP9x/OlNg06sbiXY4CDSpwmhX7o7ZHyCNqq6rmffORjCs5aEAMNr+zk6a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734425840; c=relaxed/simple;
	bh=3zTH0kNwccqauNcOYiqmZapk3cM6L6wlTZmZU5/8f2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kdfbKXTDo7bV9h/1UDo1uJwt1lmGIS0NNi9sMnQs8FUvicbabQuYUDxSpJWSAtsR3f+B9Jqw8dx2H7xDiOmJzhXoA6sg8Wa0PJDUyp+Uj2HI+NHin2JZmX/QZskEwbjKLtUHZ6k/DTt8IA/SclVyoAeRoS9kUJqpfbYijEhChPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wKZasLBk; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4361d5730caso27655e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 00:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734425837; x=1735030637; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2tNKY/TlgAJZwECcpDjiOAux1C82BMpjuzg6Q/icr8Q=;
        b=wKZasLBkRv/gNf7ZJjwnxphBrr1j+vYJFQMdfwj/id+2RVAGVt/Nbo++6SrQ1loZw8
         CSmpTxeCun79XyPqV8h0EjHJcbylkwxRay6HYbG1pYRAe5cPPTywwu6uHAwwGCGlJM8M
         eJlOXa3iy+V2Fow01SxHVNBZM0pnoRLiKQuYYO2Z3jIlYZjhoAX7DLLbBMw2Y3SZdhYW
         fh+SiUwCU9cCnQfw+w7lGI/+xY3O+HHJBbOL1THA0LyJL6oEn/2yg1TEEzNsaYRaMJyv
         xa1QTemQgmvgVjSZwWcxkyhSdDQmGXHK0aA4FJAsU8WQIy9leEh0Pps2o4R9FvhmQE36
         koRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734425837; x=1735030637;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2tNKY/TlgAJZwECcpDjiOAux1C82BMpjuzg6Q/icr8Q=;
        b=MIbXQ0hRU2Iwyw5+OEAYEr3CET+9U7irUVON13ezDOvqL5j1arfE6fR55FtOd7tyL7
         XRDFsZzNXsLBY7T8lYM9vWgNYmYCetU4eePpQaB+PnAAdBcZ69GWAVs4LcanZ7X+fr+u
         i49qEYNbTCo8i10nONWyDT+ejp8/9i36Gm9jJiileaHb/pK1iJnfFinmKJ/s5NhDc7as
         d75+BgpXv8xVtGkQJKqPhJllCOBrHxadEewTwwTS4cEBDK3XvU0ytS7Tb4VrIioDpqxW
         Bk8TispuPqsDXTAv9Bv4rVAQ+B1NEyHo58fgvuMQfOU3ZnqEOhfiw2e5UBm1fdkP2kBe
         3SRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXyAVEoQHsfjAanJao0Q7XnXdBpPr+lDO3tcssRzF2J4+YXyovt2MODhbBMXlj2blQx141ddQFpqljqVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YySkkFWTU1sxjCor+w+VpMRwvehfP74ddbaBT30lVzDouXh06Mb
	8ZL8viDIS/IZtk5ncUqy3Vmg1VY9lhTAUQZgbKZHcp6yrSU+u9ixwKBrmMtr3Sq9H5eJMS3C1ko
	GueoRbDS9LBMgwXytLiqvC4ll2RXzMb2wPjqe
X-Gm-Gg: ASbGncvMFWN09VgYRkfmJLIGpK56b+miE1o9ETgXL2X6RKv5KlLuGHapJ4+UDdR5pj8
	fQXBSLN7e5gnac5/FBa1qY/lBjisZ7QSNETly2TxrifXKHHshFwBWcrqPebTcvlM0ik0=
X-Google-Smtp-Source: AGHT+IHJFBzVsqBQ7C3d6yTsi/odA0JGrwK8w33gD0CPcudIBQqs7CYLPRRKl7DNZ+C9Q8RUdpCE/xYn1+Tolw0ZG1g=
X-Received: by 2002:a05:600c:258:b0:434:a0fd:95d9 with SMTP id
 5b1f17b1804b1-4364ad50a2bmr719945e9.5.1734425837197; Tue, 17 Dec 2024
 00:57:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216175803.2716565-1-qperret@google.com> <20241216175803.2716565-14-qperret@google.com>
In-Reply-To: <20241216175803.2716565-14-qperret@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Tue, 17 Dec 2024 08:56:40 +0000
Message-ID: <CA+EHjTzMOOkcX7GRtUZNDT5cbH5uXbu1ATgAhRq5DZV_Ev5=sw@mail.gmail.com>
Subject: Re: [PATCH v3 13/18] KVM: arm64: Introduce __pkvm_host_wrprotect_guest()
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
> Introduce a new hypercall to remove the write permission from a
> non-protected guest stage-2 mapping. This will be used for e.g. enabling
> dirty logging.
>
> Signed-off-by: Quentin Perret <qperret@google.com>

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad


> ---
>  arch/arm64/include/asm/kvm_asm.h              |  1 +
>  arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  1 +
>  arch/arm64/kvm/hyp/nvhe/hyp-main.c            | 21 +++++++++++++++++++
>  arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 19 +++++++++++++++++
>  4 files changed, 42 insertions(+)
>
> diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
> index 66ee8542dcc9..8663a588cf34 100644
> --- a/arch/arm64/include/asm/kvm_asm.h
> +++ b/arch/arm64/include/asm/kvm_asm.h
> @@ -68,6 +68,7 @@ enum __kvm_host_smccc_func {
>         __KVM_HOST_SMCCC_FUNC___pkvm_host_share_guest,
>         __KVM_HOST_SMCCC_FUNC___pkvm_host_unshare_guest,
>         __KVM_HOST_SMCCC_FUNC___pkvm_host_relax_perms_guest,
> +       __KVM_HOST_SMCCC_FUNC___pkvm_host_wrprotect_guest,
>         __KVM_HOST_SMCCC_FUNC___kvm_adjust_pc,
>         __KVM_HOST_SMCCC_FUNC___kvm_vcpu_run,
>         __KVM_HOST_SMCCC_FUNC___kvm_flush_vm_context,
> diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> index a308dcd3b5b8..fc9fdd5b0a52 100644
> --- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> +++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> @@ -42,6 +42,7 @@ int __pkvm_host_unshare_ffa(u64 pfn, u64 nr_pages);
>  int __pkvm_host_share_guest(u64 pfn, u64 gfn, struct pkvm_hyp_vcpu *vcpu, enum kvm_pgtable_prot prot);
>  int __pkvm_host_unshare_guest(u64 gfn, struct pkvm_hyp_vm *hyp_vm);
>  int __pkvm_host_relax_perms_guest(u64 gfn, struct pkvm_hyp_vcpu *vcpu, enum kvm_pgtable_prot prot);
> +int __pkvm_host_wrprotect_guest(u64 gfn, struct pkvm_hyp_vm *hyp_vm);
>
>  bool addr_is_memory(phys_addr_t phys);
>  int host_stage2_idmap_locked(phys_addr_t addr, u64 size, enum kvm_pgtable_prot prot);
> diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> index 287e4ee93ef2..98d317735107 100644
> --- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> +++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> @@ -283,6 +283,26 @@ static void handle___pkvm_host_relax_perms_guest(struct kvm_cpu_context *host_ct
>         cpu_reg(host_ctxt, 1) = ret;
>  }
>
> +static void handle___pkvm_host_wrprotect_guest(struct kvm_cpu_context *host_ctxt)
> +{
> +       DECLARE_REG(pkvm_handle_t, handle, host_ctxt, 1);
> +       DECLARE_REG(u64, gfn, host_ctxt, 2);
> +       struct pkvm_hyp_vm *hyp_vm;
> +       int ret = -EINVAL;
> +
> +       if (!is_protected_kvm_enabled())
> +               goto out;
> +
> +       hyp_vm = get_np_pkvm_hyp_vm(handle);
> +       if (!hyp_vm)
> +               goto out;
> +
> +       ret = __pkvm_host_wrprotect_guest(gfn, hyp_vm);
> +       put_pkvm_hyp_vm(hyp_vm);
> +out:
> +       cpu_reg(host_ctxt, 1) = ret;
> +}
> +
>  static void handle___kvm_adjust_pc(struct kvm_cpu_context *host_ctxt)
>  {
>         DECLARE_REG(struct kvm_vcpu *, vcpu, host_ctxt, 1);
> @@ -495,6 +515,7 @@ static const hcall_t host_hcall[] = {
>         HANDLE_FUNC(__pkvm_host_share_guest),
>         HANDLE_FUNC(__pkvm_host_unshare_guest),
>         HANDLE_FUNC(__pkvm_host_relax_perms_guest),
> +       HANDLE_FUNC(__pkvm_host_wrprotect_guest),
>         HANDLE_FUNC(__kvm_adjust_pc),
>         HANDLE_FUNC(__kvm_vcpu_run),
>         HANDLE_FUNC(__kvm_flush_vm_context),
> diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> index aa8e0408aebb..94e4251b5077 100644
> --- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> +++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> @@ -1511,3 +1511,22 @@ int __pkvm_host_relax_perms_guest(u64 gfn, struct pkvm_hyp_vcpu *vcpu, enum kvm_
>
>         return ret;
>  }
> +
> +int __pkvm_host_wrprotect_guest(u64 gfn, struct pkvm_hyp_vm *vm)
> +{
> +       u64 ipa = hyp_pfn_to_phys(gfn);
> +       u64 phys;
> +       int ret;
> +
> +       host_lock_component();
> +       guest_lock_component(vm);
> +
> +       ret = __check_host_shared_guest(vm, &phys, ipa);
> +       if (!ret)
> +               ret = kvm_pgtable_stage2_wrprotect(&vm->pgt, ipa, PAGE_SIZE);
> +
> +       guest_unlock_component(vm);
> +       host_unlock_component();
> +
> +       return ret;
> +}
> --
> 2.47.1.613.gc27f4b7a9f-goog
>

