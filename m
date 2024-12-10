Return-Path: <linux-kernel+bounces-439605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CB39EB199
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 292BF188B0AC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 13:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12AF1A2846;
	Tue, 10 Dec 2024 13:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xIRUm447"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA191A7AFD
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 13:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733835806; cv=none; b=GsQWGXNOlljSbeJ7o5QC/gsxCqMtrUagDKWRDUSU1vfw2rJshl/624xDJtNIXn1WYpdUG+0ck7sg0j9W3HQSXfQIBe/t7kSnuNcLwPdyo9Vc0Fn8yKx8uFwbEpGFl/sFN4jt32vaSqdsBQ6JWxGLyp4jIV65GqedF9ZLUC1tQlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733835806; c=relaxed/simple;
	bh=yu6/hKHXgcZjDLWJ011QiMAxT476nxn9P7LRyIB4f5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hddsSJKAZ+G5K6yXx16AI7j59LqEhztPTMW5j3czdoPIWS9HavVaVFK8NH8EDupfwJ/iMMtRy9cgQ6DcPo3/EP3VQf1VZ7MxdfL5ViGEWq5ue0w0AXQadVx8M47mBEEe13jo3kiBwjgiBQjE/OL8tb6Qq4gvdNjgyTpsIEBoKpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xIRUm447; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-434fa6bf6e4so34325e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 05:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733835802; x=1734440602; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aujkCb357SQF7t7uQ1hGpLUEmbwkr3OMZRi8Q4Vo/o0=;
        b=xIRUm447NddMcCDYNGaAY58HlQJQ82Rmq5u0Uwmxpz/DJFcwH0z6sVR3QMci5eOeS7
         KqBmcc47KSq9QpvUAGlaGTzIOjDpNtM8BLqTy9pPPqYVq9n6pkVhecwsCPw1IY3gWy00
         J5j6+LPjAkoOYHnDk9+OmZ3Xjcx94DgMP36dtfhzpis0IEiw5l9y+FnUh41Y6I2XFHSi
         FY8c2z84OgHplQNcmoc9OifWvc5iczXdb3XTJ2BaCpXb07pj8fs/OhwG02us22/JBZwJ
         PXtBtbQmQscl7idrDRZKHlzSv0XkVrX+CtYLAUCSkNHj502C+oEndcpro9ELqULZRI9Z
         l2mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733835802; x=1734440602;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aujkCb357SQF7t7uQ1hGpLUEmbwkr3OMZRi8Q4Vo/o0=;
        b=vYnlQwWz1+9RPE4mbLkmbb56ZFaFldJtQoXTOUFJe0dXRiGwbcuwRR/536vEvLcIG6
         uaes0Vph2Pt3pPIeMW4Oy9fVSjQfVVONdWcf6M/CYxoScwBqdSf+UM83aPbshfR0LAFl
         lss91C4re9p8YZwtbyP7B6lMepxs/hMFf+w2vU/cVPDI7jtmlLV8O4JbgcBAn8FGn1lx
         iGRIjkCux+s5VgdQS+YLZgnJ/PwmJGDvCBjxRpZRPwQDHaelPiJK5D6OmIZwt0dbGZ/R
         Zs0zc2Fidcm6lXaoQe07SKKeyo3uuCJyEbmuX2Wabo8m0yBIwJqJg9Dqa2lNevTAJCt7
         JC3w==
X-Forwarded-Encrypted: i=1; AJvYcCXJkS/9dgiOmYyKK6RLTdAx4zP/EUwF5Ayc+cXPCeUbIzqX1nybn+CLnIUEi5ESXS0HrMZDX8/RXXFcVu8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3lLvnWCkBm7MsWlBP9Fn4EW3RpCLRnJ3hpkOq9DJ5bbD0mReN
	T/F/Dx8+Td9YA0DS4Q1L4gkLopQMo6UJ7bgK0pOl8aJ7G0gMJC3otVYewYy9QIdWKFUbS3wty9G
	m4EZst3IqvzcyxSxF3IbNoYs6Jb1PXXYY3nzzn1ldfuQ0lkK7gA==
X-Gm-Gg: ASbGncs326e1vzjBunMYO4/AFNWjTuyFQkTbkC5k/gF1uZcKPo0M8GIn17IP9Z0dE9a
	M8SB1YsqKYB9xCI/RAbV0clOcvDuY5+D7I6Pek8haNvYb2e4UizDct0ezCHwd/Dl3
X-Google-Smtp-Source: AGHT+IEju+EdVjyKXpNSzt3ZW1EZn9eA80FYvMtoAjBenEmQ5Z6uA1TMlCxxzYwnLC56Dwl6ECANc2md5S/A8F135Mg=
X-Received: by 2002:a05:600c:35cb:b0:436:1868:b29f with SMTP id
 5b1f17b1804b1-4361868b697mr424865e9.6.1733835801992; Tue, 10 Dec 2024
 05:03:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203103735.2267589-1-qperret@google.com> <20241203103735.2267589-5-qperret@google.com>
In-Reply-To: <20241203103735.2267589-5-qperret@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Tue, 10 Dec 2024 13:02:45 +0000
Message-ID: <CA+EHjTx13V1BcyWEAjNSC0JCxr+dSUvutC7z2KSRu_8jwV_Vxw@mail.gmail.com>
Subject: Re: [PATCH v2 04/18] KVM: arm64: Move host page ownership tracking to
 the hyp vmemmap
To: Quentin Perret <qperret@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Vincent Donnefort <vdonnefort@google.com>, 
	Sebastian Ene <sebastianene@google.com>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Quentin,

On Tue, 3 Dec 2024 at 10:37, Quentin Perret <qperret@google.com> wrote:
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
> ---
>  arch/arm64/kvm/hyp/include/nvhe/memory.h |  6 +-
>  arch/arm64/kvm/hyp/nvhe/mem_protect.c    | 94 ++++++++++++++++--------
>  arch/arm64/kvm/hyp/nvhe/setup.c          |  7 +-
>  3 files changed, 71 insertions(+), 36 deletions(-)
>
> diff --git a/arch/arm64/kvm/hyp/include/nvhe/memory.h b/arch/arm64/kvm/hyp/include/nvhe/memory.h
> index 88cb8ff9e769..08f3a0416d4c 100644
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

Not shown in this patch, but a couple of lines below, you might want
to update the comment on PKVM_NOPAGE to fix the reference to "PTE's SW
bits":

> /* Meta-states which aren't encoded directly in the PTE's SW bits */
> PKVM_NOPAGE = BIT(2),

> @@ -44,7 +44,9 @@ static inline enum pkvm_page_state pkvm_getstate(enum kvm_pgtable_prot prot)
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
> index caba3e4bd09e..1595081c4f6b 100644
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
> @@ -382,19 +385,25 @@ bool addr_is_memory(phys_addr_t phys)
>         return !!find_mem_range(phys, &range);
>  }
>
> -static bool addr_is_allowed_memory(phys_addr_t phys)
> +static bool is_in_mem_range(u64 addr, struct kvm_mem_range *range)
> +{
> +       return range->start <= addr && addr < range->end;
> +}
> +
> +static int range_is_allowed_memory(u64 start, u64 end)

The name of this function "range_*is*_..." implies that it returns a
boolean, which other functions in this file (and patch) with similar
names do, but it returns an error instead. Maybe
check_range_allowed_memory)?

>  {
>         struct memblock_region *reg;
>         struct kvm_mem_range range;
>
> -       reg = find_mem_range(phys, &range);
> +       /* Can't check the state of both MMIO and memory regions at once */

I don't understand this comment in relation to the code. Could you
explain it to me please?

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
> @@ -454,8 +463,11 @@ static int host_stage2_adjust_range(u64 addr, struct kvm_mem_range *range)
>         if (kvm_pte_valid(pte))
>                 return -EAGAIN;
>
> -       if (pte)
> +       if (pte) {
> +               WARN_ON(addr_is_memory(addr) &&
> +                       !(hyp_phys_to_page(addr)->host_state & PKVM_NOPAGE));

nit: since the host state is now an enum, should this just be an
equality check rather than an &? This makes it consistent with other
checks of pkvm_page_state in this patch too.

>                 return -EPERM;
> +       }
>
>         do {
>                 u64 granule = kvm_granule_size(level);
> @@ -477,10 +489,29 @@ int host_stage2_idmap_locked(phys_addr_t addr, u64 size,
>         return host_stage2_try(__host_stage2_idmap, addr, addr + size, prot);
>  }
>
> +static void __host_update_page_state(phys_addr_t addr, u64 size, enum pkvm_page_state state)
> +{
> +       phys_addr_t end = addr + size;

nit: newline

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
> +       ret = host_stage2_try(kvm_pgtable_stage2_set_owner, &host_mmu.pgt,
> +                             addr, size, &host_s2_pool, owner_id);
> +       if (ret || !addr_is_memory(addr))
> +               return ret;

Can hyp set an owner for an address that isn't memory? Trying to
understand why we need to update the host stage2 pagetable but not the
hypervisor's vmemmap in that case.

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
> @@ -604,35 +635,38 @@ static int check_page_state_range(struct kvm_pgtable *pgt, u64 addr, u64 size,
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
> +       ret = range_is_allowed_memory(addr, end);
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
> +       if (hyp_phys_to_page(addr)->host_state & PKVM_NOPAGE) {

Same nit as above regarding checking for PKVM_NOPAGE

Cheers,
/fuad


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
> 2.47.0.338.g60cca15819-goog
>

