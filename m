Return-Path: <linux-kernel+bounces-439819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E77E9EB452
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 16:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9615C286072
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FDA51ACDE7;
	Tue, 10 Dec 2024 15:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gr54HGYn"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77B71AAA38
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 15:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733843253; cv=none; b=mFIFHkMVw/HIopS7fU16m69ekxfwmYU8GU+u0nptlSh8/K5vMdGqk50CN+zaFEc8c85lQZ2AUiCsSsEP/WEJDkL7pTQZEBVM9wG+/mAZli1DDWY9QW/Ktgrt9LMrp2ioE8dwZqX5DW9w4KL8bpigvNXhnVyxwE3yv78gsYI7Iq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733843253; c=relaxed/simple;
	bh=NNnB1DyfuoKzm2DmRXnXHiJG8hZpHzLTuRmfrd+D8Ls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YRz3oMFSVd+StJGxWcYGJc9Km+xURJz8OXT84ObV4eBUalM/C0vCmZE2Ne+ttZ764so04PnNyKsGUhyCe9eKVoue6E3rw6HGW81PDRbPHpmLgbhF3dNbiSaxBA0NQBhfCrA6Ya/CE9idUXUvnsvIGmcKDvpLSOHsVFpgC2gfD/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gr54HGYn; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-434e5e71a08so43835e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 07:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733843250; x=1734448050; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tmhmaaJdV6eQOFANMqIcIt0l8XrMzMUTFt9zdpoB/Zc=;
        b=Gr54HGYnKYrvY7p0GshUwqTwKLDl2bqK6S7TVqpzb4BQ+IfIL+1ihwRPISjlhLtJGo
         t0g00EoZFwH4+Y1C1BYZCrl0JOS7gGvxbv9nUNXGjV8gc37p0Dp8LIAmiDSyRXTwvza2
         HNK3mZb0j6YTuY9fpfl19nbXyHuj8LEQx89Sc5e4iDP1S2gJmuRWI8ZwC0LC9RK93Odb
         ikQN8SQy8i8tBuCfIBRYoHtM7ugrpA9ZkSqHY+eHWbcDYHQ6Gw82+mFfTxNSzCy0YVGu
         grElkIuBJDWJBqvTzkFLmRN6gP3/Urj37DS+KnlHBkHxg2c0AQ8n0KQfM7TgRF3m4mVN
         rhcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733843250; x=1734448050;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tmhmaaJdV6eQOFANMqIcIt0l8XrMzMUTFt9zdpoB/Zc=;
        b=Psx00HUjzVouKA+06LwjeaFit/k4O0w+JeRzGzouSU7JprvN3UbNiIrFJxFRnKRUXs
         dga99UeR/w7//V7Z5D2A3crszKz+YopSnJbobqcnKa5/53mKTajUo0EUfrfQ92j6GzOQ
         xJ9hcKdKneaGfBWVnWYWw/uepVnHSw2nlEBr2bkflSW2oxVH2dil11uUqCy8UfdcXUhh
         ZbIau+DSI8HZXeNrrzgBPaqKx4j6BT2fJkHLc3rJdRPqkiKABYx72kNE5fyhWAYdEcfI
         OU/th2l+nLdiF+aWTiQWAWYqqgMB8I9Pjiiv/tkaClLC4q5T8HgvYxnIx4W8rTdeen9O
         dtfg==
X-Forwarded-Encrypted: i=1; AJvYcCVQYZZkkBlZ4b9ZvDamLaAlj8zYicpjL6C8LhYzJE05v4jMtUuv2HsG71snxHi3xu0jW/PUq7VDNP8GAus=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRDIKLPXj+RR7Ge833Y5FqUTjTuvpNhIZ9RJExrTWeGb6el3gE
	cGI18HXArRODJR7V703tx5mC2BCiNV+2CE94havisintZ/XV8EnDMHaK1Z+mRCNLsontSgOsj9N
	Z0jt6RKYRGIi6NOk6Sqkzpkug4Qtm1kUryqHF
X-Gm-Gg: ASbGnculdeVh014HHSGhNNRfvBELHkMJRPhoa1cQqpJvHsGoS5hNyqAwg3vQR9ZdWok
	QgEqXK8O5JaVxZYFIEO6bkGDBNjwhwI+eWePjRGEj4viv1tA/9KynhWapVzpgLs9h
X-Google-Smtp-Source: AGHT+IF0v/8FkIfUp8V2WvAH5E1CeHZD7x+qAjIRtMSeRZsWGkiFZVc6N2lek4jfdw4f++/UM2MaP8BhSMOlA5+0cTs=
X-Received: by 2002:a05:600c:4595:b0:434:a0fd:95d9 with SMTP id
 5b1f17b1804b1-43539dd9c68mr1171885e9.5.1733843249949; Tue, 10 Dec 2024
 07:07:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203103735.2267589-1-qperret@google.com> <20241203103735.2267589-14-qperret@google.com>
In-Reply-To: <20241203103735.2267589-14-qperret@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Tue, 10 Dec 2024 15:06:53 +0000
Message-ID: <CA+EHjTx-MZHKwkGYPU+yN-CDkNh1kxTXN8FWTeaPfM95OSkjcQ@mail.gmail.com>
Subject: Re: [PATCH v2 13/18] KVM: arm64: Introduce __pkvm_host_wrprotect_guest()
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
> Introduce a new hypercall to remove the write permission from a
> non-protected guest stage-2 mapping. This will be used for e.g. enabling
> dirty logging.
>
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/include/asm/kvm_asm.h              |  1 +
>  arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  1 +
>  arch/arm64/kvm/hyp/nvhe/hyp-main.c            | 24 +++++++++++++++++++
>  arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 19 +++++++++++++++
>  4 files changed, 45 insertions(+)
>
> diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
> index 5d51933e44fb..4d7d20ea03df 100644
> --- a/arch/arm64/include/asm/kvm_asm.h
> +++ b/arch/arm64/include/asm/kvm_asm.h
> @@ -68,6 +68,7 @@ enum __kvm_host_smccc_func {
>         __KVM_HOST_SMCCC_FUNC___pkvm_host_share_guest,
>         __KVM_HOST_SMCCC_FUNC___pkvm_host_unshare_guest,
>         __KVM_HOST_SMCCC_FUNC___pkvm_host_relax_guest_perms,
> +       __KVM_HOST_SMCCC_FUNC___pkvm_host_wrprotect_guest,
>         __KVM_HOST_SMCCC_FUNC___kvm_adjust_pc,
>         __KVM_HOST_SMCCC_FUNC___kvm_vcpu_run,
>         __KVM_HOST_SMCCC_FUNC___kvm_flush_vm_context,
> diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> index db0dd83c2457..8658b5932473 100644
> --- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> +++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> @@ -42,6 +42,7 @@ int __pkvm_host_unshare_ffa(u64 pfn, u64 nr_pages);
>  int __pkvm_host_share_guest(u64 pfn, u64 gfn, struct pkvm_hyp_vcpu *vcpu, enum kvm_pgtable_prot prot);
>  int __pkvm_host_unshare_guest(u64 gfn, struct pkvm_hyp_vm *hyp_vm);
>  int __pkvm_host_relax_guest_perms(u64 gfn, enum kvm_pgtable_prot prot, struct pkvm_hyp_vcpu *vcpu);
> +int __pkvm_host_wrprotect_guest(u64 gfn, struct pkvm_hyp_vm *hyp_vm);
>
>  bool addr_is_memory(phys_addr_t phys);
>  int host_stage2_idmap_locked(phys_addr_t addr, u64 size, enum kvm_pgtable_prot prot);
> diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> index 60dd56bbd743..3feaf2119e51 100644
> --- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> +++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> @@ -286,6 +286,29 @@ static void handle___pkvm_host_relax_guest_perms(struct kvm_cpu_context *host_ct
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
> +       hyp_vm = get_pkvm_hyp_vm(handle);
> +       if (!hyp_vm)
> +               goto out;
> +       if (pkvm_hyp_vm_is_protected(hyp_vm))
> +               goto put_hyp_vm;

These checks are (unsurprisingly) the same for all these functions.
Does it make sense to have a helper do these checks?

Cheers,
/fuad

> +       ret = __pkvm_host_wrprotect_guest(gfn, hyp_vm);
> +put_hyp_vm:
> +       put_pkvm_hyp_vm(hyp_vm);
> +out:
> +       cpu_reg(host_ctxt, 1) = ret;
> +}
> +
>  static void handle___kvm_adjust_pc(struct kvm_cpu_context *host_ctxt)
>  {
>         DECLARE_REG(struct kvm_vcpu *, vcpu, host_ctxt, 1);
> @@ -498,6 +521,7 @@ static const hcall_t host_hcall[] = {
>         HANDLE_FUNC(__pkvm_host_share_guest),
>         HANDLE_FUNC(__pkvm_host_unshare_guest),
>         HANDLE_FUNC(__pkvm_host_relax_guest_perms),
> +       HANDLE_FUNC(__pkvm_host_wrprotect_guest),
>         HANDLE_FUNC(__kvm_adjust_pc),
>         HANDLE_FUNC(__kvm_vcpu_run),
>         HANDLE_FUNC(__kvm_flush_vm_context),
> diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> index d4b28e93e790..89312d7cde2a 100644
> --- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> +++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> @@ -1503,3 +1503,22 @@ int __pkvm_host_relax_guest_perms(u64 gfn, enum kvm_pgtable_prot prot, struct pk
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
> +       ret = __check_host_unshare_guest(vm, &phys, ipa);
> +       if (!ret)
> +               ret = kvm_pgtable_stage2_wrprotect(&vm->pgt, ipa, PAGE_SIZE);
> +
> +       guest_unlock_component(vm);
> +       host_unlock_component();
> +
> +       return ret;
> +}
> --
> 2.47.0.338.g60cca15819-goog
>

