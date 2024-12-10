Return-Path: <linux-kernel+bounces-439803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A57A9EB416
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 684701882914
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5DD19CD16;
	Tue, 10 Dec 2024 14:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XBMT8dRE"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DE21A01D4
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 14:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733842605; cv=none; b=OlNWp1qsC5qEMA0ATjovRSaOKIhlhR5N8f56IEQZmondIqAWizfNNi3WLXv7GRom0WJSPOXvntYhc9sxp1zLf92bhYIZR5WJUd1LDRQ8WmO0SpOqBrETPxZXOD/1c8RL3WX3waEJr8elOqE+WajtUEej/rdYClZtm/ncfbQav3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733842605; c=relaxed/simple;
	bh=36l5sqTsyGB+zahHlHiYJEOq2y50QnU/gLvSH/lBzlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gRRBdc2boWGwsvvcaWeJGbwjL7F71O3q2ljLYtA2EZy3TZjQB3lXG1m9rm624MlNUt83HGXSTaruzzaeIhitiC8KT4PhuS1wUHJuMg3nwTGVC8SnEfL7O4MW38tw0sUF8ufqhW5bqVXN/8D/sn3qnWm0ch11UfBShkOTNdu4SeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XBMT8dRE; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-434fa6bf6e4so42315e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 06:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733842602; x=1734447402; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CPwwSGhVOWXHBjvSfy9QVGaBSD0H0DxOIeEJkupGNUU=;
        b=XBMT8dREY5C8rR0zefXFJ5MzHrvpGrJ1HYVO4/V96zHCGoQ60pitU00VxjcALYZK4d
         mbBiN8KA1QFFTlLt/pqGYBN1J6jjiPsW+TmX6V1bmj+lxvyRTsSx2Gx8JI/1+8EeSJX2
         Bp5eGJ0RcyYXfnIzCrONXdpOKoZjHNlUk8SaLye6XxtZtT3/oOvWRBZkzCN688ftmIlo
         dLL80HPHy/f2necqn0nkUUT5l8KUZfg4tM2a4judZwRAbkfDohTfruWlURlwqyIQNzT5
         /WW3aVs8wn1KK803mzgVUm/DJUG2ba20Rn69TnU6KMS2rgh7777sokL2qqcdDF/BJQPL
         AkdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733842602; x=1734447402;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CPwwSGhVOWXHBjvSfy9QVGaBSD0H0DxOIeEJkupGNUU=;
        b=dQsqgdw275IrSFJPUueuR2zWo48hWfy7dN8INnjhbCcl6mBFTJAhuMdb94+4umFzgt
         FRJkItCEY0TcCOoFk8BXbyAj3NWUasus00rOEaS5kqQ6oWRQCff3Yv3K1O/Y3/WB7Cia
         bJZvgEVItVmWqnTCwlLYfXnhVV4dC/kbi7ZbJGdJkUmVgE/EXEgpPMfw28LO/3vfs41n
         fIYZRSE8DLLUvprLnqjVPK+jXJdTBTev5qjpS+NAbgfzk1n/yRvJ2b5FnOnSGnK4T+or
         RD18qlczWb4NmJdr/zJlHKQgGelBjYovH///c4KGXzdwDiywMKvlfdDn/mKLKQgIK56d
         ooVg==
X-Forwarded-Encrypted: i=1; AJvYcCVOGpVl4/TPqf02rEUnhREHGMw9K1qrkFKGzKBUKjdrlBmQf4R+Uku04Wo8YDExe/4gBHOksjBmnpfqwZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuB1Uv5nikHHU+d4+WR8j3Jlkkhe0blYOKnOJ19mgVisjHkThY
	xuLLFhlyHoas3UqLuvNF8oO08SZptqzGuk4i51wXcvZkkZWAZ2AaPCVSOwTUHwnrb3SEES5odlQ
	L5XTfen1jRcy/KlJpxpps8CvZUSBKQK6h3f0c
X-Gm-Gg: ASbGncs/083bP/IlKhbs6d3fiQVRzjgR47qVZJgBpCGWusy3UDMOk+Yx3pY2vqYjGo8
	+fAe2Zvwo615pYMjfP3L+0c3RWlz4sIYmGXurG0Dnx4YLToahUpeDa30MB0mN2/pu
X-Google-Smtp-Source: AGHT+IFrek7ZOXFjbieOK3Z+KiuRhmB/JQIfCUTikq2lGnXrH/9Y4kZOz9Oyane5oNuACjRRiOYBT3El9OhjG5oV6Sc=
X-Received: by 2002:a05:600c:898:b0:436:1811:a79c with SMTP id
 5b1f17b1804b1-4361811a993mr606625e9.5.1733842602227; Tue, 10 Dec 2024
 06:56:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203103735.2267589-1-qperret@google.com> <20241203103735.2267589-13-qperret@google.com>
In-Reply-To: <20241203103735.2267589-13-qperret@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Tue, 10 Dec 2024 14:56:05 +0000
Message-ID: <CA+EHjTwNgf5fPuWMaPaN4mcdd5y4uydJsXi-zEBatFnbwoaLLQ@mail.gmail.com>
Subject: Re: [PATCH v2 12/18] KVM: arm64: Introduce __pkvm_host_relax_guest_perms()
To: Quentin Perret <qperret@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Vincent Donnefort <vdonnefort@google.com>, 
	Sebastian Ene <sebastianene@google.com>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Quentin,

On Tue, 3 Dec 2024 at 10:38, Quentin Perret <qperret@google.com> wrote:
>
> Introduce a new hypercall allowing the host to relax the stage-2
> permissions of mappings in a non-protected guest page-table. It will be
> used later once we start allowing RO memslots and dirty logging.
>
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/include/asm/kvm_asm.h              |  1 +
>  arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  1 +
>  arch/arm64/kvm/hyp/nvhe/hyp-main.c            | 20 ++++++++++++++++
>  arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 23 +++++++++++++++++++
>  4 files changed, 45 insertions(+)
>
> diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
> index 0b6c4d325134..5d51933e44fb 100644
> --- a/arch/arm64/include/asm/kvm_asm.h
> +++ b/arch/arm64/include/asm/kvm_asm.h
> @@ -67,6 +67,7 @@ enum __kvm_host_smccc_func {
>         __KVM_HOST_SMCCC_FUNC___pkvm_host_unshare_hyp,
>         __KVM_HOST_SMCCC_FUNC___pkvm_host_share_guest,
>         __KVM_HOST_SMCCC_FUNC___pkvm_host_unshare_guest,
> +       __KVM_HOST_SMCCC_FUNC___pkvm_host_relax_guest_perms,
>         __KVM_HOST_SMCCC_FUNC___kvm_adjust_pc,
>         __KVM_HOST_SMCCC_FUNC___kvm_vcpu_run,
>         __KVM_HOST_SMCCC_FUNC___kvm_flush_vm_context,
> diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> index e528a42ed60e..db0dd83c2457 100644
> --- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> +++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> @@ -41,6 +41,7 @@ int __pkvm_host_share_ffa(u64 pfn, u64 nr_pages);
>  int __pkvm_host_unshare_ffa(u64 pfn, u64 nr_pages);
>  int __pkvm_host_share_guest(u64 pfn, u64 gfn, struct pkvm_hyp_vcpu *vcpu, enum kvm_pgtable_prot prot);
>  int __pkvm_host_unshare_guest(u64 gfn, struct pkvm_hyp_vm *hyp_vm);
> +int __pkvm_host_relax_guest_perms(u64 gfn, enum kvm_pgtable_prot prot, struct pkvm_hyp_vcpu *vcpu);

The parameters are the same as __pkvm_host_share_guest, but in a
different order. I looked ahead at later patches in the series, and similar
issues regarding parameter type and ordering, so I won't mention it
for the later patches.


>  bool addr_is_memory(phys_addr_t phys);
>  int host_stage2_idmap_locked(phys_addr_t addr, u64 size, enum kvm_pgtable_prot prot);
> diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> index 04a9053ae1d5..60dd56bbd743 100644
> --- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> +++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> @@ -267,6 +267,25 @@ static void handle___pkvm_host_unshare_guest(struct kvm_cpu_context *host_ctxt)
>         cpu_reg(host_ctxt, 1) =  ret;
>  }
>
> +static void handle___pkvm_host_relax_guest_perms(struct kvm_cpu_context *host_ctxt)
> +{
> +       DECLARE_REG(u64, gfn, host_ctxt, 1);
> +       DECLARE_REG(enum kvm_pgtable_prot, prot, host_ctxt, 2);
> +       struct pkvm_hyp_vcpu *hyp_vcpu;
> +       int ret = -EINVAL;
> +
> +       if (!is_protected_kvm_enabled())
> +               goto out;
> +
> +       hyp_vcpu = pkvm_get_loaded_hyp_vcpu();
> +       if (!hyp_vcpu || pkvm_hyp_vcpu_is_protected(hyp_vcpu))
> +               goto out;
> +
> +       ret = __pkvm_host_relax_guest_perms(gfn, prot, hyp_vcpu);
> +out:
> +       cpu_reg(host_ctxt, 1) = ret;
> +}
> +
>  static void handle___kvm_adjust_pc(struct kvm_cpu_context *host_ctxt)
>  {
>         DECLARE_REG(struct kvm_vcpu *, vcpu, host_ctxt, 1);
> @@ -478,6 +497,7 @@ static const hcall_t host_hcall[] = {
>         HANDLE_FUNC(__pkvm_host_unshare_hyp),
>         HANDLE_FUNC(__pkvm_host_share_guest),
>         HANDLE_FUNC(__pkvm_host_unshare_guest),
> +       HANDLE_FUNC(__pkvm_host_relax_guest_perms),
>         HANDLE_FUNC(__kvm_adjust_pc),
>         HANDLE_FUNC(__kvm_vcpu_run),
>         HANDLE_FUNC(__kvm_flush_vm_context),
> diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> index aa27a3e42e5e..d4b28e93e790 100644
> --- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> +++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> @@ -1480,3 +1480,26 @@ int __pkvm_host_unshare_guest(u64 gfn, struct pkvm_hyp_vm *hyp_vm)
>
>         return ret;
>  }
> +
> +int __pkvm_host_relax_guest_perms(u64 gfn, enum kvm_pgtable_prot prot, struct pkvm_hyp_vcpu *vcpu)
> +{
> +       struct pkvm_hyp_vm *vm = pkvm_hyp_vcpu_to_hyp_vm(vcpu);
> +       u64 ipa = hyp_pfn_to_phys(gfn);
> +       u64 phys;
> +       int ret;
> +
> +       if ((prot & KVM_PGTABLE_PROT_RWX) != prot)
> +               return -EPERM;

Why not

+       if (prot & ~KVM_PGTABLE_PROT_RWX)

Simpler and consistent with similar checks in the file (e.g.,
__pkvm_host_share_guest)

Cheers,
/fuad


> +
> +       host_lock_component();
> +       guest_lock_component(vm);
> +
> +       ret = __check_host_unshare_guest(vm, &phys, ipa);
> +       if (!ret)
> +               ret = kvm_pgtable_stage2_relax_perms(&vm->pgt, ipa, prot, 0);
> +
> +       guest_unlock_component(vm);
> +       host_unlock_component();
> +
> +       return ret;
> +}
> --
> 2.47.0.338.g60cca15819-goog
>

