Return-Path: <linux-kernel+bounces-448865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7C09F468E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EFB5188AFE5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 08:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03EE71DD872;
	Tue, 17 Dec 2024 08:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xe4VSM7C"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDA11DD54C
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 08:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734425654; cv=none; b=q3jcAyeeCP5kscMJ4Z2u9qYOfbUZkJlYA7QtjL9yjfZhuMml0oUzyHzrR/RGkndGvW2rsC/jVOmRmrekDwNYnGMtC7teSufB9j4gZt5McXnGbl0lWmYLxkng2BDbHchRbuDyApVKZ0Y0sfxKpJRNxnbdG06KEDPU3dW0aIXXqmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734425654; c=relaxed/simple;
	bh=giwLdFGQ9QlV8fdrB8UsMVez9KDIiCZEOK3inRQmSq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uf7ClbprDzPCAV1eU5Nz56ivz1ZhKsXNUae0jJ56AEt2y6WvZ4ufu400OvksEJZTqnyvgTZIQ6XiHMZng4Et5TqmXoisqD4sDKYB/d8H4ji2tHcjSGsdNQbX4FC6TFHler8FFAgYlfwej8sAPcfY095XM5u3yA0YX1is1TvGXdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xe4VSM7C; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-435b0df5dbdso39475e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 00:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734425651; x=1735030451; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KifjnGKVqQ3XbGB/V/sFyzHQHhRGanZQhXvxaYt/h1o=;
        b=xe4VSM7Cdx+6BmOqYoI8A2sltf/lAmW8acFMGvQ6qfeL+0uIqL1xhk8KHcZAUzMGuo
         lhDeW3azYPj8ULKjMyayUoxzprh8UwNqlZgORL5RMzmNqcyum6RBypmvd0zXftwuSAS0
         qz+S4gvgcJlHrSB+9rB+g5N52EL9S8clLV1ga1Ol8QRdCp5A8B4U1WpR+ek79TKDox85
         JVwd48AxG2KjGxor4CxiRIHePGjHQo4dzW7ovC8BtA1mzAFkS6Zx/i5lbiuYYxuPpIWq
         lMdtt9IgV6WvPQs93rVHlHanTH0o6IMk/NY/F99CpxS+pjnrEnerKvWWOstp9QDY9T7t
         XYYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734425651; x=1735030451;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KifjnGKVqQ3XbGB/V/sFyzHQHhRGanZQhXvxaYt/h1o=;
        b=tBlItHsVb3tFmuWBNQjapB9icen0Ybu4cnIgrw592xlmoYKfhnlA7fGN1WE2jY3K9s
         WTIew5AJsx8M6MLQGgC2fku3vYtlgmKFydzilQgv0ffUN2ON9uS4XOR+0TpDp/hG7SKH
         dJRqhzK0/kgK7MoB9aidHIR3qQMZGkZyQFStqzRebkDzh9z5SkbaKRoewkw7SEtkeKoB
         W0kBgxBw+x74L9ES6mwLn1nB9dLVWQprOLKP73h5GHVswWln9EPZeYVLtWXE3Q690mk/
         KFWE6IZNSDtvuKKbimE8BTfeTh2lbFQEFvtkrDOS34ppXJ3o2lVovf3MMoQO3F33vR6W
         UW8A==
X-Forwarded-Encrypted: i=1; AJvYcCUI5h3Fc2xhhpoeeokWux3UTL2yDm+Lh2k/GA7hUzRLEvgExQarVHo6oQ66SMFRHtSnszk3tqYvFgHPZVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHYG5C7W1RQG6wEPcGr7jt8i3w/mhGYDIz3r2h8ac/H15qbVyD
	i1yAicK1hKCVBVDCXPe+ygQj+FfE4I1zo5OwQDYnJ0UmQYh9SFf1zHw1Xs2awQK6eXTVyWBr4J9
	Ga0JS6LLqapP8c/EGFiaZKOMerQBFCZorcRDu
X-Gm-Gg: ASbGncu4S6PGyDhArNN+F8Hfh95gB3n6C3SH07XG5CZw9CwxNsT95CItfZd80NJNjmN
	75tKxAvQNWSoMLL/hqoSdpGK8UW3XWJq4LmuK4jCNQ9XUim/LReFCIy5F1XLrAQNrwcM=
X-Google-Smtp-Source: AGHT+IGO+h+C3q+EgS7FY8mjqUfew8qNlrw1ag/9aHnM+aCXQqiv7j2ErBqu43XDUVsb+Ip/LmfLThnGVSL5NVKFt2s=
X-Received: by 2002:a05:600c:5707:b0:434:f7fc:1b18 with SMTP id
 5b1f17b1804b1-436492cfbfamr901235e9.4.1734425650625; Tue, 17 Dec 2024
 00:54:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216175803.2716565-1-qperret@google.com> <20241216175803.2716565-12-qperret@google.com>
In-Reply-To: <20241216175803.2716565-12-qperret@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Tue, 17 Dec 2024 08:53:34 +0000
Message-ID: <CA+EHjTxRt=XoCZbRLE1UjMg4bzgoLYD9Lh0nzmjvPZ2Q4xQOkg@mail.gmail.com>
Subject: Re: [PATCH v3 11/18] KVM: arm64: Introduce __pkvm_host_unshare_guest()
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
> In preparation for letting the host unmap pages from non-protected
> guests, introduce a new hypercall implementing the host-unshare-guest
> transition.
>
> Signed-off-by: Quentin Perret <qperret@google.com>

Apart from nit below.
Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad


> ---
>  arch/arm64/include/asm/kvm_asm.h              |  1 +
>  arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  1 +
>  arch/arm64/kvm/hyp/include/nvhe/pkvm.h        |  6 ++
>  arch/arm64/kvm/hyp/nvhe/hyp-main.c            | 21 ++++++
>  arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 67 +++++++++++++++++++
>  arch/arm64/kvm/hyp/nvhe/pkvm.c                | 12 ++++
>  6 files changed, 108 insertions(+)
>
> diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
> index 449337f5b2a3..0b6c4d325134 100644
> --- a/arch/arm64/include/asm/kvm_asm.h
> +++ b/arch/arm64/include/asm/kvm_asm.h
> @@ -66,6 +66,7 @@ enum __kvm_host_smccc_func {
>         __KVM_HOST_SMCCC_FUNC___pkvm_host_share_hyp,
>         __KVM_HOST_SMCCC_FUNC___pkvm_host_unshare_hyp,
>         __KVM_HOST_SMCCC_FUNC___pkvm_host_share_guest,
> +       __KVM_HOST_SMCCC_FUNC___pkvm_host_unshare_guest,
>         __KVM_HOST_SMCCC_FUNC___kvm_adjust_pc,
>         __KVM_HOST_SMCCC_FUNC___kvm_vcpu_run,
>         __KVM_HOST_SMCCC_FUNC___kvm_flush_vm_context,
> diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> index a7976e50f556..e528a42ed60e 100644
> --- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> +++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> @@ -40,6 +40,7 @@ int __pkvm_hyp_donate_host(u64 pfn, u64 nr_pages);
>  int __pkvm_host_share_ffa(u64 pfn, u64 nr_pages);
>  int __pkvm_host_unshare_ffa(u64 pfn, u64 nr_pages);
>  int __pkvm_host_share_guest(u64 pfn, u64 gfn, struct pkvm_hyp_vcpu *vcpu, enum kvm_pgtable_prot prot);
> +int __pkvm_host_unshare_guest(u64 gfn, struct pkvm_hyp_vm *hyp_vm);
>
>  bool addr_is_memory(phys_addr_t phys);
>  int host_stage2_idmap_locked(phys_addr_t addr, u64 size, enum kvm_pgtable_prot prot);
> diff --git a/arch/arm64/kvm/hyp/include/nvhe/pkvm.h b/arch/arm64/kvm/hyp/include/nvhe/pkvm.h
> index be52c5b15e21..0cc2a429f1fb 100644
> --- a/arch/arm64/kvm/hyp/include/nvhe/pkvm.h
> +++ b/arch/arm64/kvm/hyp/include/nvhe/pkvm.h
> @@ -64,6 +64,11 @@ static inline bool pkvm_hyp_vcpu_is_protected(struct pkvm_hyp_vcpu *hyp_vcpu)
>         return vcpu_is_protected(&hyp_vcpu->vcpu);
>  }
>
> +static inline bool pkvm_hyp_vm_is_protected(struct pkvm_hyp_vm *hyp_vm)
> +{
> +       return kvm_vm_is_protected(&hyp_vm->kvm);
> +}
> +
>  void pkvm_hyp_vm_table_init(void *tbl);
>
>  int __pkvm_init_vm(struct kvm *host_kvm, unsigned long vm_hva,
> @@ -78,6 +83,7 @@ void pkvm_put_hyp_vcpu(struct pkvm_hyp_vcpu *hyp_vcpu);
>  struct pkvm_hyp_vcpu *pkvm_get_loaded_hyp_vcpu(void);
>
>  struct pkvm_hyp_vm *get_pkvm_hyp_vm(pkvm_handle_t handle);
> +struct pkvm_hyp_vm *get_np_pkvm_hyp_vm(pkvm_handle_t handle);
>  void put_pkvm_hyp_vm(struct pkvm_hyp_vm *hyp_vm);
>
>  #endif /* __ARM64_KVM_NVHE_PKVM_H__ */
> diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> index d659462fbf5d..3c3a27c985a2 100644
> --- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> +++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> @@ -244,6 +244,26 @@ static void handle___pkvm_host_share_guest(struct kvm_cpu_context *host_ctxt)
>         cpu_reg(host_ctxt, 1) =  ret;
>  }
>
> +static void handle___pkvm_host_unshare_guest(struct kvm_cpu_context *host_ctxt)
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
> +       ret = __pkvm_host_unshare_guest(gfn, hyp_vm);
> +       put_pkvm_hyp_vm(hyp_vm);
> +out:
> +       cpu_reg(host_ctxt, 1) =  ret;
> +}
> +
>  static void handle___kvm_adjust_pc(struct kvm_cpu_context *host_ctxt)
>  {
>         DECLARE_REG(struct kvm_vcpu *, vcpu, host_ctxt, 1);
> @@ -454,6 +474,7 @@ static const hcall_t host_hcall[] = {
>         HANDLE_FUNC(__pkvm_host_share_hyp),
>         HANDLE_FUNC(__pkvm_host_unshare_hyp),
>         HANDLE_FUNC(__pkvm_host_share_guest),
> +       HANDLE_FUNC(__pkvm_host_unshare_guest),
>         HANDLE_FUNC(__kvm_adjust_pc),
>         HANDLE_FUNC(__kvm_vcpu_run),
>         HANDLE_FUNC(__kvm_flush_vm_context),
> diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> index fb9592e721cf..30243b7922f1 100644
> --- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> +++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> @@ -1421,3 +1421,70 @@ int __pkvm_host_share_guest(u64 pfn, u64 gfn, struct pkvm_hyp_vcpu *vcpu,
>
>         return ret;
>  }
> +
> +static int __check_host_shared_guest(struct pkvm_hyp_vm *vm, u64 *__phys, u64 ipa)

nit: This parameter in this patch, and others, is sometimes hyp_vm, at
others just vm. It would be nicer if it was always the same.


> +{
> +       enum pkvm_page_state state;
> +       struct hyp_page *page;
> +       kvm_pte_t pte;
> +       u64 phys;
> +       s8 level;
> +       int ret;
> +
> +       ret = kvm_pgtable_get_leaf(&vm->pgt, ipa, &pte, &level);
> +       if (ret)
> +               return ret;
> +       if (level != KVM_PGTABLE_LAST_LEVEL)
> +               return -E2BIG;
> +       if (!kvm_pte_valid(pte))
> +               return -ENOENT;
> +
> +       state = guest_get_page_state(pte, ipa);
> +       if (state != PKVM_PAGE_SHARED_BORROWED)
> +               return -EPERM;
> +
> +       phys = kvm_pte_to_phys(pte);
> +       ret = check_range_allowed_memory(phys, phys + PAGE_SIZE);
> +       if (WARN_ON(ret))
> +               return ret;
> +
> +       page = hyp_phys_to_page(phys);
> +       if (page->host_state != PKVM_PAGE_SHARED_OWNED)
> +               return -EPERM;
> +       if (WARN_ON(!page->host_share_guest_count))
> +               return -EINVAL;
> +
> +       *__phys = phys;
> +
> +       return 0;
> +}
> +
> +int __pkvm_host_unshare_guest(u64 gfn, struct pkvm_hyp_vm *vm)
> +{
> +       u64 ipa = hyp_pfn_to_phys(gfn);
> +       struct hyp_page *page;
> +       u64 phys;
> +       int ret;
> +
> +       host_lock_component();
> +       guest_lock_component(vm);
> +
> +       ret = __check_host_shared_guest(vm, &phys, ipa);
> +       if (ret)
> +               goto unlock;
> +
> +       ret = kvm_pgtable_stage2_unmap(&vm->pgt, ipa, PAGE_SIZE);
> +       if (ret)
> +               goto unlock;
> +
> +       page = hyp_phys_to_page(phys);
> +       page->host_share_guest_count--;
> +       if (!page->host_share_guest_count)
> +               WARN_ON(__host_set_page_state_range(phys, PAGE_SIZE, PKVM_PAGE_OWNED));
> +
> +unlock:
> +       guest_unlock_component(vm);
> +       host_unlock_component();
> +
> +       return ret;
> +}
> diff --git a/arch/arm64/kvm/hyp/nvhe/pkvm.c b/arch/arm64/kvm/hyp/nvhe/pkvm.c
> index f2e363fe6b84..1b0982fa5ba8 100644
> --- a/arch/arm64/kvm/hyp/nvhe/pkvm.c
> +++ b/arch/arm64/kvm/hyp/nvhe/pkvm.c
> @@ -376,6 +376,18 @@ void put_pkvm_hyp_vm(struct pkvm_hyp_vm *hyp_vm)
>         hyp_spin_unlock(&vm_table_lock);
>  }
>
> +struct pkvm_hyp_vm *get_np_pkvm_hyp_vm(pkvm_handle_t handle)
> +{
> +       struct pkvm_hyp_vm *hyp_vm = get_pkvm_hyp_vm(handle);
> +
> +       if (hyp_vm && pkvm_hyp_vm_is_protected(hyp_vm)) {
> +               put_pkvm_hyp_vm(hyp_vm);
> +               hyp_vm = NULL;
> +       }
> +
> +       return hyp_vm;
> +}
> +
>  static void pkvm_init_features_from_host(struct pkvm_hyp_vm *hyp_vm, const struct kvm *host_kvm)
>  {
>         struct kvm *kvm = &hyp_vm->kvm;
> --
> 2.47.1.613.gc27f4b7a9f-goog
>

