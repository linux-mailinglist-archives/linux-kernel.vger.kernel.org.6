Return-Path: <linux-kernel+bounces-439823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 147839EB461
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 16:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 493F01886010
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D351B0433;
	Tue, 10 Dec 2024 15:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VcYtG5vE"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA711A072A
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 15:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733843554; cv=none; b=eqP3Eiw0aWGBpDoKzWxwr2GXHmPPmxq4ri0IYvkmoU4jtJKB41f0f849Jy/zHFmkIFHDtWdnmAa+tLaT9Y0yk/DedjKcxjtR/REcSPqrOfBEJtwA7OiB8P+iWefOzkTROHbZigLY9ECtokRJwFvElNfZvryEfy6savRlwhM/4UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733843554; c=relaxed/simple;
	bh=zNUIMA0r+arxv7Jhqh9dwlo/rMZuYJV4lXPbAwZ6K68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XavPr9iocc9iv0XLMBXzFjd5tw8EXbq0EWEKU5a1/1jtyciHASmGNHOb5/qQ1HKC+r0dPMKpmhjHlxwWwqguoCxsdTF/3NKwKJP49soSgxqefUpbHLLh11biq+dhXA1phOGh/eWY2JXcf1lWCxKVVO02FBgMoSYDLeYaUPHLvVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VcYtG5vE; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-435b0df5dbdso40735e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 07:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733843550; x=1734448350; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PMyTiyNfmKdhDjVhUzsIJIaEqQor0TbKt2tHvDNxOCE=;
        b=VcYtG5vE9g4n/jUVwgw2yYU5nX9Wuh5H/RIkKYfBXtJ/g1ZU4kiCVKREJE7NnBv0si
         rHtSuCDLXNED9eFejv9LHaXbBkL2ss8wrepaaYWITtXCLvXN/rW0J7Y412TMwJpAfLfz
         WdJXk0Di09C8tmyxuhqv7oNXLq0Y25ZlqSrmYN3rVICt7KkGRbiuPU4w3c7C9KPUb58M
         bGTASRmKtMgOuK6f9xEuwrUEdkQJ1tQUYncA/3xvw1SWXkDbTTR06PLpJHQx7rfnGScD
         Azn2rMNU//2mhHpkYWXJs3WEGZMu7pzBLahcLHgMwuASNbbswQ7xleFuCROdNN7stlEn
         u3SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733843550; x=1734448350;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PMyTiyNfmKdhDjVhUzsIJIaEqQor0TbKt2tHvDNxOCE=;
        b=J4QMltAzS2wqkO1Ly0Sw+Zrkd/3FsJRKecbQ4Ya9zbNgrOZ6LKqJJNZkxIP/OUrsxR
         7wA77DQ4xFyhLLhNaEFWCd25NtuMxix/SDsWzXP2nzzHZhZIR5J1MMXWRbTStngBkJ9N
         3MuL33FZpqe69by1PZA2KkkHnQPrR65rRI4H8qZ2o5+5UUV405HHXY7kRySpHym/wUb0
         zAfWeaR2E75q4sacC9QbopCpjihWQOt4MEOqK604uTB3rH5gSGukYHro58KCbbOZVczQ
         Qd197FXjc4uKVwxNbSSBbAlzmom9L9rHPOZOfao87e10IsTRzwI9PwbMYdEVxZu/8A6/
         KxOg==
X-Forwarded-Encrypted: i=1; AJvYcCWp+37eq/Wf9PEiLgDBL5XvyeEa8fZSHinxf3mo+3J+FRAtHV3l1uLh26Jzb6iBhIKOseMLUeKxLqjdu4I=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl6PqVjm0QhjIEEZd7DmcZAh2DjVXtuialZB6wrvsJaWXpAGSi
	9RGZ3XYnnn1lMijqhT4+0EA1DOJD1y4H9l4P8agvzBVOlM9mCKDlqFGz8tsHUk8RSmj3XZpstJ3
	/muIuhUzqYkqjAZG9v1WmlEy0+AogZUYbzFFD
X-Gm-Gg: ASbGncsGHYAI/6jTdQIrjcLJPCXYMfDqw9WeWSpyKf266VlIG+SH2m8GxdmchNTI/od
	LDXBNgnhZUVn78adt+WkIEZ/IQogCWsyCniZmTSUGSYkTIiOV9t6WmhXubwrpeTYm
X-Google-Smtp-Source: AGHT+IFHeRD8jtlR7tKAgJUTx/0YJEujzi94LrDfE3Tbouy+VcFbttMaIzZI3qcxqGjKUaoNiPtT/88hZA1vV3f/nHA=
X-Received: by 2002:a05:600c:4907:b0:434:f7fc:1b18 with SMTP id
 5b1f17b1804b1-435028ac13amr1349455e9.4.1733843549772; Tue, 10 Dec 2024
 07:12:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203103735.2267589-1-qperret@google.com> <20241203103735.2267589-15-qperret@google.com>
In-Reply-To: <20241203103735.2267589-15-qperret@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Tue, 10 Dec 2024 15:11:53 +0000
Message-ID: <CA+EHjTwV2mXOXMF7u+pVaSqvJ2c-iPGMxPBhrj7oZrm+oaAi3A@mail.gmail.com>
Subject: Re: [PATCH v2 14/18] KVM: arm64: Introduce __pkvm_host_test_clear_young_guest()
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
> Plumb the kvm_stage2_test_clear_young() callback into pKVM for
> non-protected guest. It will be later be called from MMU notifiers.
>
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/include/asm/kvm_asm.h              |  1 +
>  arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  1 +
>  arch/arm64/kvm/hyp/nvhe/hyp-main.c            | 25 +++++++++++++++++++
>  arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 19 ++++++++++++++
>  4 files changed, 46 insertions(+)
>
> diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
> index 4d7d20ea03df..cb676017d591 100644
> --- a/arch/arm64/include/asm/kvm_asm.h
> +++ b/arch/arm64/include/asm/kvm_asm.h
> @@ -69,6 +69,7 @@ enum __kvm_host_smccc_func {
>         __KVM_HOST_SMCCC_FUNC___pkvm_host_unshare_guest,
>         __KVM_HOST_SMCCC_FUNC___pkvm_host_relax_guest_perms,
>         __KVM_HOST_SMCCC_FUNC___pkvm_host_wrprotect_guest,
> +       __KVM_HOST_SMCCC_FUNC___pkvm_host_test_clear_young_guest,
>         __KVM_HOST_SMCCC_FUNC___kvm_adjust_pc,
>         __KVM_HOST_SMCCC_FUNC___kvm_vcpu_run,
>         __KVM_HOST_SMCCC_FUNC___kvm_flush_vm_context,
> diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> index 8658b5932473..554ce31882e6 100644
> --- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> +++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> @@ -43,6 +43,7 @@ int __pkvm_host_share_guest(u64 pfn, u64 gfn, struct pkvm_hyp_vcpu *vcpu, enum k
>  int __pkvm_host_unshare_guest(u64 gfn, struct pkvm_hyp_vm *hyp_vm);
>  int __pkvm_host_relax_guest_perms(u64 gfn, enum kvm_pgtable_prot prot, struct pkvm_hyp_vcpu *vcpu);
>  int __pkvm_host_wrprotect_guest(u64 gfn, struct pkvm_hyp_vm *hyp_vm);
> +int __pkvm_host_test_clear_young_guest(u64 gfn, bool mkold, struct pkvm_hyp_vm *vm);

While I'm piling on the function names/parameters, some functions have
_guest as a postfix at the end (e.g., this one), others have it in the
middle (__pkvm_host_relax_guest_perms). I guess
__pkvm_host_relax_guest_perms is the odd one out. Could you rename it?

Cheers,
/fuad


>  bool addr_is_memory(phys_addr_t phys);
>  int host_stage2_idmap_locked(phys_addr_t addr, u64 size, enum kvm_pgtable_prot prot);
> diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> index 3feaf2119e51..67cb6e284180 100644
> --- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> +++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> @@ -309,6 +309,30 @@ static void handle___pkvm_host_wrprotect_guest(struct kvm_cpu_context *host_ctxt
>         cpu_reg(host_ctxt, 1) = ret;
>  }
>
> +static void handle___pkvm_host_test_clear_young_guest(struct kvm_cpu_context *host_ctxt)
> +{
> +       DECLARE_REG(pkvm_handle_t, handle, host_ctxt, 1);
> +       DECLARE_REG(u64, gfn, host_ctxt, 2);
> +       DECLARE_REG(bool, mkold, host_ctxt, 3);
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
> +
> +       ret = __pkvm_host_test_clear_young_guest(gfn, mkold, hyp_vm);
> +put_hyp_vm:
> +       put_pkvm_hyp_vm(hyp_vm);
> +out:
> +       cpu_reg(host_ctxt, 1) = ret;
> +}
> +
>  static void handle___kvm_adjust_pc(struct kvm_cpu_context *host_ctxt)
>  {
>         DECLARE_REG(struct kvm_vcpu *, vcpu, host_ctxt, 1);
> @@ -522,6 +546,7 @@ static const hcall_t host_hcall[] = {
>         HANDLE_FUNC(__pkvm_host_unshare_guest),
>         HANDLE_FUNC(__pkvm_host_relax_guest_perms),
>         HANDLE_FUNC(__pkvm_host_wrprotect_guest),
> +       HANDLE_FUNC(__pkvm_host_test_clear_young_guest),
>         HANDLE_FUNC(__kvm_adjust_pc),
>         HANDLE_FUNC(__kvm_vcpu_run),
>         HANDLE_FUNC(__kvm_flush_vm_context),
> diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> index 89312d7cde2a..0e064a7ed7c4 100644
> --- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> +++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> @@ -1522,3 +1522,22 @@ int __pkvm_host_wrprotect_guest(u64 gfn, struct pkvm_hyp_vm *vm)
>
>         return ret;
>  }
> +
> +int __pkvm_host_test_clear_young_guest(u64 gfn, bool mkold, struct pkvm_hyp_vm *vm)
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
> +               ret = kvm_pgtable_stage2_test_clear_young(&vm->pgt, ipa, PAGE_SIZE, mkold);
> +
> +       guest_unlock_component(vm);
> +       host_unlock_component();
> +
> +       return ret;
> +}
> --
> 2.47.0.338.g60cca15819-goog
>

