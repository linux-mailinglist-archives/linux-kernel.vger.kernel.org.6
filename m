Return-Path: <linux-kernel+bounces-448848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDA59F466D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D64E21886CA3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 08:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACE21DB52D;
	Tue, 17 Dec 2024 08:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y8Y46NEA"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571701CF2A2
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 08:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734425260; cv=none; b=bkiGYath5urqDcSblZARLVGRnOzR7Yg6yUyxiKTTPG4O4KySrH00Iijz0p6oouMkhPq5iT1C33K3fBUcKfi5rpGA1ylEoxJRS8OtR+iSe5wQ5wMzRqOEzBVeQkAxq0J1pUZH2UOzoFC3RwrMQdRzW5XflE/h5ROzNo5bqv3CLRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734425260; c=relaxed/simple;
	bh=HQBVM1bY6318JGK+RLisUREKBGbdSBEQCrai9x+uRLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oktkxpjskTcC4uwLibp/MVLASmcjI1ELnMrAl6CSJxTOeM1ANZxMdZhNtlNBCUz+BA4wCkgh0SUtVElOc9Vl9CixIPmDrrJHg/b2eeYoa1+ZlXm2vSc6WlFRpU0aWbFjFjPu5XsCOcfeiABi2ULuYd3CUQElsdkLeD29n7yzfb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y8Y46NEA; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4361d5730caso27085e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 00:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734425256; x=1735030056; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TDDJBYOHP75ThTGcuMvIwooq7g+u4EFaZTyJ2gC5szU=;
        b=y8Y46NEAaeHkGVfHOHV8ps+a/k5yKNNva91FIfv3b7i6vLGkM6PuujxjPB71DfplSY
         gGMQH4uvqqTV5m0FHh3RZHbjH+wxhIENNSlJ9aAlLhdVJ6tNXRWVzBHpPWY3uyJW/7Mo
         2Rat+KjYrBdzlyuO4urfistrjquGGGGfREUVJHi3F6RfWZyCAm3DWcN1o52bR7EnlinS
         zv6nYxPtLGyT8tRyIVxHQ5+FrdPmCVT3lTBV8ykEmrZ+w1yuNaXdBjuxEc6YJtjfjyyz
         GaO1rklUIPIGMBoI8BYSQ0Ks9ln7t34AcJGmIK6M0ZUFO8Id7WdcS0BarrRCmYhsOCRM
         x9tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734425256; x=1735030056;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TDDJBYOHP75ThTGcuMvIwooq7g+u4EFaZTyJ2gC5szU=;
        b=mDihGoQA2RkjgS/q2hEcMBRxbOwenPqDtV4921YOfUa2wrpKu7FD4MUXIAkBQN7aUs
         /MCKySi8HPz/ZYf+mjgqtG8zx4ZaO9Pw75Ako46/PJyok1Rgi55DnnHfCxVSu78J2dDG
         P7uPf3/ozlt3Lxxrw3fBjdeYrKZQe0dWmimUani7izqXf/by8EtAiNMT4XiVfDxORVAB
         kWfjgwC6J3vGmuYMVEiFOscFq0gLRT33ch0RWK/ZRSh42+W7UFWo+JPcEUxmIue5JeNR
         OOIuHvDPAonHyqnHM3A9o5Aj+VrqtVnH9gUIrGs7EY/LQP8BCH8w/ZNkr7ixLMxKD5aQ
         aNww==
X-Forwarded-Encrypted: i=1; AJvYcCW+esClVz55tVbzJf7fr83x0mPrKorDSW4wP1K4tHXLFHwil/+QEFoO1IWfgD27kshyFAIEkYab9w59PYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YygW7+9iHsmjob+TI7odP4wTU0WBOWmfBUF7b5Sqz4RJ74sKDcd
	H1t/5k2w6J9AVKhhVw73ICjaI9laTxZIg3B8S3ON9PfGkZwkGx1T7OtvOBI/cAMchtwFNaiRarH
	1IqP1MzwmWBIQcestWP0LmgCCSVZpjIVnmKbM
X-Gm-Gg: ASbGncvZrS8jMFdb7F14yxQ7cYeHMJpuAjyeRpiDOjPXOzcJ8Xp5CQfPoqR6M8UwONO
	3VmKdXCnAtUKdWT10dzIe6bSgnvbTUGoVZar1gw2VZ6btI3hIbGiI3EVmz9t8M/XaPKU=
X-Google-Smtp-Source: AGHT+IHt2ytzKMSYHdWFUZre8Ll5zz2KLXOBJJTQt0g6EdacRR7mrV/+5ef0UfOv3wQWC9wfn2CB/36gV3U1R7AeKKg=
X-Received: by 2002:a05:600c:258:b0:434:a0fd:95d9 with SMTP id
 5b1f17b1804b1-4364ad50a2bmr710775e9.5.1734425255510; Tue, 17 Dec 2024
 00:47:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216175803.2716565-1-qperret@google.com> <20241216175803.2716565-5-qperret@google.com>
In-Reply-To: <20241216175803.2716565-5-qperret@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Tue, 17 Dec 2024 08:46:58 +0000
Message-ID: <CA+EHjTy9P4gt6z+NbxLLANUKJBe32g0HsyGvsobXSfGiFSZ5Lg@mail.gmail.com>
Subject: Re: [PATCH v3 04/18] KVM: arm64: Move host page ownership tracking to
 the hyp vmemmap
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
> We currently store part of the page-tracking state in PTE software bits
> for the host, guests and the hypervisor. This is sub-optimal when e.g.
> sharing pages as this forces to break block mappings purely to support
> this software tracking. This causes an unnecessarily fragmented stage-2
> page-table for the host in particular when it shares pages with Secure,
> which can lead to measurable regressions. Moreover, having this state
> stored in the page-table forces us to do multiple costly walks on the
> page transition path, hence causing overhead.
>
> In order to work around these problems, move the host-side page-tracking
> logic from SW bits in its stage-2 PTEs to the hypervisor's vmemmap.
>
> Signed-off-by: Quentin Perret <qperret@google.com>

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

> ---
>  arch/arm64/kvm/hyp/include/nvhe/memory.h |   6 +-
>  arch/arm64/kvm/hyp/nvhe/mem_protect.c    | 100 ++++++++++++++++-------
>  arch/arm64/kvm/hyp/nvhe/setup.c          |   7 +-
>  3 files changed, 77 insertions(+), 36 deletions(-)
>
> diff --git a/arch/arm64/kvm/hyp/include/nvhe/memory.h b/arch/arm64/kvm/hyp/include/nvhe/memory.h
> index 45b8d1840aa4..8bd9a539f260 100644
> --- a/arch/arm64/kvm/hyp/include/nvhe/memory.h
> +++ b/arch/arm64/kvm/hyp/include/nvhe/memory.h
> @@ -8,7 +8,7 @@
>  #include <linux/types.h>
>
>  /*
> - * SW bits 0-1 are reserved to track the memory ownership state of each page:
> + * Bits 0-1 are reserved to track the memory ownership state of each page:
>   *   00: The page is owned exclusively by the page-table owner.
>   *   01: The page is owned by the page-table owner, but is shared
>   *       with another entity.
> @@ -43,7 +43,9 @@ static inline enum pkvm_page_state pkvm_getstate(enum kvm_pgtable_prot prot)
>  struct hyp_page {
>         u16 refcount;
>         u8 order;
> -       u8 reserved;
> +
> +       /* Host (non-meta) state. Guarded by the host stage-2 lock. */
> +       enum pkvm_page_state host_state : 8;
>  };
>
>  extern u64 __hyp_vmemmap;
> diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> index caba3e4bd09e..12bb5445fe47 100644
> --- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> +++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> @@ -201,8 +201,8 @@ static void *guest_s2_zalloc_page(void *mc)
>
>         memset(addr, 0, PAGE_SIZE);
>         p = hyp_virt_to_page(addr);
> -       memset(p, 0, sizeof(*p));
>         p->refcount = 1;
> +       p->order = 0;
>
>         return addr;
>  }
> @@ -268,6 +268,7 @@ int kvm_guest_prepare_stage2(struct pkvm_hyp_vm *vm, void *pgd)
>
>  void reclaim_guest_pages(struct pkvm_hyp_vm *vm, struct kvm_hyp_memcache *mc)
>  {
> +       struct hyp_page *page;
>         void *addr;
>
>         /* Dump all pgtable pages in the hyp_pool */
> @@ -279,7 +280,9 @@ void reclaim_guest_pages(struct pkvm_hyp_vm *vm, struct kvm_hyp_memcache *mc)
>         /* Drain the hyp_pool into the memcache */
>         addr = hyp_alloc_pages(&vm->pool, 0);
>         while (addr) {
> -               memset(hyp_virt_to_page(addr), 0, sizeof(struct hyp_page));
> +               page = hyp_virt_to_page(addr);
> +               page->refcount = 0;
> +               page->order = 0;
>                 push_hyp_memcache(mc, addr, hyp_virt_to_phys);
>                 WARN_ON(__pkvm_hyp_donate_host(hyp_virt_to_pfn(addr), 1));
>                 addr = hyp_alloc_pages(&vm->pool, 0);
> @@ -382,19 +385,28 @@ bool addr_is_memory(phys_addr_t phys)
>         return !!find_mem_range(phys, &range);
>  }
>
> -static bool addr_is_allowed_memory(phys_addr_t phys)
> +static bool is_in_mem_range(u64 addr, struct kvm_mem_range *range)
> +{
> +       return range->start <= addr && addr < range->end;
> +}
> +
> +static int check_range_allowed_memory(u64 start, u64 end)
>  {
>         struct memblock_region *reg;
>         struct kvm_mem_range range;
>
> -       reg = find_mem_range(phys, &range);
> +       /*
> +        * Callers can't check the state of a range that overlaps memory and
> +        * MMIO regions, so ensure [start, end[ is in the same kvm_mem_range.
> +        */
> +       reg = find_mem_range(start, &range);
> +       if (!is_in_mem_range(end - 1, &range))
> +               return -EINVAL;
>
> -       return reg && !(reg->flags & MEMBLOCK_NOMAP);
> -}
> +       if (!reg || reg->flags & MEMBLOCK_NOMAP)
> +               return -EPERM;
>
> -static bool is_in_mem_range(u64 addr, struct kvm_mem_range *range)
> -{
> -       return range->start <= addr && addr < range->end;
> +       return 0;
>  }
>
>  static bool range_is_memory(u64 start, u64 end)
> @@ -454,8 +466,10 @@ static int host_stage2_adjust_range(u64 addr, struct kvm_mem_range *range)
>         if (kvm_pte_valid(pte))
>                 return -EAGAIN;
>
> -       if (pte)
> +       if (pte) {
> +               WARN_ON(addr_is_memory(addr) && hyp_phys_to_page(addr)->host_state != PKVM_NOPAGE);
>                 return -EPERM;
> +       }
>
>         do {
>                 u64 granule = kvm_granule_size(level);
> @@ -477,10 +491,33 @@ int host_stage2_idmap_locked(phys_addr_t addr, u64 size,
>         return host_stage2_try(__host_stage2_idmap, addr, addr + size, prot);
>  }
>
> +static void __host_update_page_state(phys_addr_t addr, u64 size, enum pkvm_page_state state)
> +{
> +       phys_addr_t end = addr + size;
> +
> +       for (; addr < end; addr += PAGE_SIZE)
> +               hyp_phys_to_page(addr)->host_state = state;
> +}
> +
>  int host_stage2_set_owner_locked(phys_addr_t addr, u64 size, u8 owner_id)
>  {
> -       return host_stage2_try(kvm_pgtable_stage2_set_owner, &host_mmu.pgt,
> -                              addr, size, &host_s2_pool, owner_id);
> +       int ret;
> +
> +       if (!addr_is_memory(addr))
> +               return -EPERM;
> +
> +       ret = host_stage2_try(kvm_pgtable_stage2_set_owner, &host_mmu.pgt,
> +                             addr, size, &host_s2_pool, owner_id);
> +       if (ret)
> +               return ret;
> +
> +       /* Don't forget to update the vmemmap tracking for the host */
> +       if (owner_id == PKVM_ID_HOST)
> +               __host_update_page_state(addr, size, PKVM_PAGE_OWNED);
> +       else
> +               __host_update_page_state(addr, size, PKVM_NOPAGE);
> +
> +       return 0;
>  }
>
>  static bool host_stage2_force_pte_cb(u64 addr, u64 end, enum kvm_pgtable_prot prot)
> @@ -604,35 +641,38 @@ static int check_page_state_range(struct kvm_pgtable *pgt, u64 addr, u64 size,
>         return kvm_pgtable_walk(pgt, addr, size, &walker);
>  }
>
> -static enum pkvm_page_state host_get_page_state(kvm_pte_t pte, u64 addr)
> -{
> -       if (!addr_is_allowed_memory(addr))
> -               return PKVM_NOPAGE;
> -
> -       if (!kvm_pte_valid(pte) && pte)
> -               return PKVM_NOPAGE;
> -
> -       return pkvm_getstate(kvm_pgtable_stage2_pte_prot(pte));
> -}
> -
>  static int __host_check_page_state_range(u64 addr, u64 size,
>                                          enum pkvm_page_state state)
>  {
> -       struct check_walk_data d = {
> -               .desired        = state,
> -               .get_page_state = host_get_page_state,
> -       };
> +       u64 end = addr + size;
> +       int ret;
> +
> +       ret = check_range_allowed_memory(addr, end);
> +       if (ret)
> +               return ret;
>
>         hyp_assert_lock_held(&host_mmu.lock);
> -       return check_page_state_range(&host_mmu.pgt, addr, size, &d);
> +       for (; addr < end; addr += PAGE_SIZE) {
> +               if (hyp_phys_to_page(addr)->host_state != state)
> +                       return -EPERM;
> +       }
> +
> +       return 0;
>  }
>
>  static int __host_set_page_state_range(u64 addr, u64 size,
>                                        enum pkvm_page_state state)
>  {
> -       enum kvm_pgtable_prot prot = pkvm_mkstate(PKVM_HOST_MEM_PROT, state);
> +       if (hyp_phys_to_page(addr)->host_state == PKVM_NOPAGE) {
> +               int ret = host_stage2_idmap_locked(addr, size, PKVM_HOST_MEM_PROT);
>
> -       return host_stage2_idmap_locked(addr, size, prot);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       __host_update_page_state(addr, size, state);
> +
> +       return 0;
>  }
>
>  static int host_request_owned_transition(u64 *completer_addr,
> diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
> index cbdd18cd3f98..7e04d1c2a03d 100644
> --- a/arch/arm64/kvm/hyp/nvhe/setup.c
> +++ b/arch/arm64/kvm/hyp/nvhe/setup.c
> @@ -180,7 +180,6 @@ static void hpool_put_page(void *addr)
>  static int fix_host_ownership_walker(const struct kvm_pgtable_visit_ctx *ctx,
>                                      enum kvm_pgtable_walk_flags visit)
>  {
> -       enum kvm_pgtable_prot prot;
>         enum pkvm_page_state state;
>         phys_addr_t phys;
>
> @@ -203,16 +202,16 @@ static int fix_host_ownership_walker(const struct kvm_pgtable_visit_ctx *ctx,
>         case PKVM_PAGE_OWNED:
>                 return host_stage2_set_owner_locked(phys, PAGE_SIZE, PKVM_ID_HYP);
>         case PKVM_PAGE_SHARED_OWNED:
> -               prot = pkvm_mkstate(PKVM_HOST_MEM_PROT, PKVM_PAGE_SHARED_BORROWED);
> +               hyp_phys_to_page(phys)->host_state = PKVM_PAGE_SHARED_BORROWED;
>                 break;
>         case PKVM_PAGE_SHARED_BORROWED:
> -               prot = pkvm_mkstate(PKVM_HOST_MEM_PROT, PKVM_PAGE_SHARED_OWNED);
> +               hyp_phys_to_page(phys)->host_state = PKVM_PAGE_SHARED_OWNED;
>                 break;
>         default:
>                 return -EINVAL;
>         }
>
> -       return host_stage2_idmap_locked(phys, PAGE_SIZE, prot);
> +       return 0;
>  }
>
>  static int fix_hyp_pgtable_refcnt_walker(const struct kvm_pgtable_visit_ctx *ctx,
> --
> 2.47.1.613.gc27f4b7a9f-goog
>

