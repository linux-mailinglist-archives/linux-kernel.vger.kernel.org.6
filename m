Return-Path: <linux-kernel+bounces-439878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 841779EB558
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 16:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A9AE283099
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C659023099A;
	Tue, 10 Dec 2024 15:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m+JikVRi"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08F31B4236
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 15:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733845657; cv=none; b=PbyzD85xmrItMUQIesapDmPlXNz+9eIdutpOOUBsomwCooyvxYoT1HLQds2K9SZ4Kcx8L9ueWBPbC4pUTVeavMcIP0NhhJ8c4+5LIQLlpgc5J/52tf2+puYd5/nESgunK/k4rk9MCg+VekxZ1ZyWRA1h5xw1xR1GLVHS5qDMHbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733845657; c=relaxed/simple;
	bh=PZZEammgNdh2NUYLCb/8Vsiz6c4IhmZXblQdT4wBqOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BCSVb+D4iMtAEQz1mpmCLMt2l5umDV7FZrDJu4/5zNtCsHeZddbr+OAxaxWP+GOPEVusxX691TdWRauHR0svp84Dys575Y/lK/3Wr+6yX5/Muk9PRJX5FmeeAlo6ma5POxB80qIEVG/ggQEawCd5LsZEoKE6mlgaCR3fTYa7Xn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m+JikVRi; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-435b0df5dbdso43615e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 07:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733845654; x=1734450454; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9SawISKbcHbBEI0ssfZRv2BZeIF5nHX4Umpgg65Fcs8=;
        b=m+JikVRikznY7mpGQdNe3IXG9IjfAYQ7TgRfVjQ2kpNXTaCSFk11p4jLqiaQaHYh+N
         vAxe+MQDWdpCn1vMP6TM1+2+n/W8tG36JGTp20hDXvZqng9Z9A3McDyZQGqiGKCgZdKH
         x89qG0WlFdqAkbsE5FbPf1AnaPe+g5tF36va6MN3K3PsN8jUCJ/X+qdJPsSA9aoDVU0o
         UyIjji8OtrWEWQgCVoO6qcktPx2oIyp6y9CRbcBe9YXqAHGQizZ9gaMJO7iZXMq7ugHa
         ZrBorHkejNDdRciFWiY4Erw21pioDi4SYfwGEZMZsGm27z061tzWIHdILQ9JCSzyuKBV
         HSMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733845654; x=1734450454;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9SawISKbcHbBEI0ssfZRv2BZeIF5nHX4Umpgg65Fcs8=;
        b=CZ8LVuffhW6iYhsuH2KIa3zk+hUK+M1rbXXeLr0zEhFEQQb9NSiR7Cmy+cwYIKSz4y
         XntmA6iDYplTS0EcwzBLQknkcrJVuONbI3FX2r+cyP93KUL1ZYoAX7uIzDvcFF2CSI5v
         NancnVyckzQ3k3CVINshUPV72EY9fNvm5BnQnJpYvav4UXNF/WGLEiIAfWHFqlamoh+4
         UFV48ygu/c9R1rN9ytWSFYu2j3vww+5u2MjeZ4k3ODaqneQesa3Vuigy0A6cXdJNhR8a
         Eet75XJ2umJHyavjspNX3MgljT+j3uV1TlQ44jVgSb0Sca3jnUEo9PcpbN9b2IEqeNub
         vmMg==
X-Forwarded-Encrypted: i=1; AJvYcCU+2CMwg6MduQ7IUqBLePAgHcKSLVZYDKlajpxfNephFQ3nl2NjO5C48/R6eEHKFmTAAh2fz0wfp0AU/7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQHO64IvmzoOdH9eWxQUZs2/gCu1Qx7di+cuFzrRbMledYnmZh
	idm6/ywTqFEAtZCUwk8GxMyzBRQK53BNuuC3OAdxgksZ0w9F+1H4UakH8/V35NZJZEdJGAueeuE
	chJKejNdo9l0+z4XoKBkdYK11w8WT1zdJLn9T
X-Gm-Gg: ASbGncuoozAHpZIWn31AWE8eS+lgJ0WJPx3sMId68mw7DyHdY8CF21ptH8N1jhCEkVC
	HsvNu6rD+8fmnnS+KuoPHxd9KsSC66H3oqyWP6YOD/nI07Wen83PQlzRDNYfma9U=
X-Google-Smtp-Source: AGHT+IGGKwWvf+MbcMLZQ+Dvv59umFEkXEcAZwN6Qg7pmxWmR4duWrar/9xMAIfp9y59JWFt/u8IskRA6dfuybd7WEU=
X-Received: by 2002:a05:600c:714:b0:436:1aa8:d05d with SMTP id
 5b1f17b1804b1-4361aa8d4c3mr345905e9.0.1733845653698; Tue, 10 Dec 2024
 07:47:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203103735.2267589-1-qperret@google.com> <20241203103735.2267589-5-qperret@google.com>
 <CA+EHjTx13V1BcyWEAjNSC0JCxr+dSUvutC7z2KSRu_8jwV_Vxw@mail.gmail.com> <Z1heckLsqrCBF6Nw@google.com>
In-Reply-To: <Z1heckLsqrCBF6Nw@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Tue, 10 Dec 2024 15:46:57 +0000
Message-ID: <CA+EHjTxiDiZ4P2AVSDErUfr612Ov0UZira+9qQkRQJK_Ki7uug@mail.gmail.com>
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

On Tue, 10 Dec 2024 at 15:29, Quentin Perret <qperret@google.com> wrote:
>
> Hey Fuad,
>
> On Tuesday 10 Dec 2024 at 13:02:45 (+0000), Fuad Tabba wrote:
> > Hi Quentin,
> >
> > On Tue, 3 Dec 2024 at 10:37, Quentin Perret <qperret@google.com> wrote:
> > >
> > > We currently store part of the page-tracking state in PTE software bits
> > > for the host, guests and the hypervisor. This is sub-optimal when e.g.
> > > sharing pages as this forces to break block mappings purely to support
> > > this software tracking. This causes an unnecessarily fragmented stage-2
> > > page-table for the host in particular when it shares pages with Secure,
> > > which can lead to measurable regressions. Moreover, having this state
> > > stored in the page-table forces us to do multiple costly walks on the
> > > page transition path, hence causing overhead.
> > >
> > > In order to work around these problems, move the host-side page-tracking
> > > logic from SW bits in its stage-2 PTEs to the hypervisor's vmemmap.
> > >
> > > Signed-off-by: Quentin Perret <qperret@google.com>
> > > ---
> > >  arch/arm64/kvm/hyp/include/nvhe/memory.h |  6 +-
> > >  arch/arm64/kvm/hyp/nvhe/mem_protect.c    | 94 ++++++++++++++++--------
> > >  arch/arm64/kvm/hyp/nvhe/setup.c          |  7 +-
> > >  3 files changed, 71 insertions(+), 36 deletions(-)
> > >
> > > diff --git a/arch/arm64/kvm/hyp/include/nvhe/memory.h b/arch/arm64/kvm/hyp/include/nvhe/memory.h
> > > index 88cb8ff9e769..08f3a0416d4c 100644
> > > --- a/arch/arm64/kvm/hyp/include/nvhe/memory.h
> > > +++ b/arch/arm64/kvm/hyp/include/nvhe/memory.h
> > > @@ -8,7 +8,7 @@
> > >  #include <linux/types.h>
> > >
> > >  /*
> > > - * SW bits 0-1 are reserved to track the memory ownership state of each page:
> > > + * Bits 0-1 are reserved to track the memory ownership state of each page:
> > >   *   00: The page is owned exclusively by the page-table owner.
> > >   *   01: The page is owned by the page-table owner, but is shared
> > >   *       with another entity.
> >
> > Not shown in this patch, but a couple of lines below, you might want
> > to update the comment on PKVM_NOPAGE to fix the reference to "PTE's SW
> > bits":
>
> I actually think the comment is still correct -- PKVM_NOPAGE never goes
> in the software bits, with or without this patch, so I figured we could
> leave it as-is. But happy to reword if you have a good idea :)

I see, no, that's fine.

> > > /* Meta-states which aren't encoded directly in the PTE's SW bits */
> > > PKVM_NOPAGE = BIT(2),
> >
> > > @@ -44,7 +44,9 @@ static inline enum pkvm_page_state pkvm_getstate(enum kvm_pgtable_prot prot)
> > >  struct hyp_page {
> > >         u16 refcount;
> > >         u8 order;
> > > -       u8 reserved;
> > > +
> > > +       /* Host (non-meta) state. Guarded by the host stage-2 lock. */
> > > +       enum pkvm_page_state host_state : 8;
> > >  };
> > >
> > >  extern u64 __hyp_vmemmap;
> > > diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > > index caba3e4bd09e..1595081c4f6b 100644
> > > --- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > > +++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > > @@ -201,8 +201,8 @@ static void *guest_s2_zalloc_page(void *mc)
> > >
> > >         memset(addr, 0, PAGE_SIZE);
> > >         p = hyp_virt_to_page(addr);
> > > -       memset(p, 0, sizeof(*p));
> > >         p->refcount = 1;
> > > +       p->order = 0;
> > >
> > >         return addr;
> > >  }
> > > @@ -268,6 +268,7 @@ int kvm_guest_prepare_stage2(struct pkvm_hyp_vm *vm, void *pgd)
> > >
> > >  void reclaim_guest_pages(struct pkvm_hyp_vm *vm, struct kvm_hyp_memcache *mc)
> > >  {
> > > +       struct hyp_page *page;
> > >         void *addr;
> > >
> > >         /* Dump all pgtable pages in the hyp_pool */
> > > @@ -279,7 +280,9 @@ void reclaim_guest_pages(struct pkvm_hyp_vm *vm, struct kvm_hyp_memcache *mc)
> > >         /* Drain the hyp_pool into the memcache */
> > >         addr = hyp_alloc_pages(&vm->pool, 0);
> > >         while (addr) {
> > > -               memset(hyp_virt_to_page(addr), 0, sizeof(struct hyp_page));
> > > +               page = hyp_virt_to_page(addr);
> > > +               page->refcount = 0;
> > > +               page->order = 0;
> > >                 push_hyp_memcache(mc, addr, hyp_virt_to_phys);
> > >                 WARN_ON(__pkvm_hyp_donate_host(hyp_virt_to_pfn(addr), 1));
> > >                 addr = hyp_alloc_pages(&vm->pool, 0);
> > > @@ -382,19 +385,25 @@ bool addr_is_memory(phys_addr_t phys)
> > >         return !!find_mem_range(phys, &range);
> > >  }
> > >
> > > -static bool addr_is_allowed_memory(phys_addr_t phys)
> > > +static bool is_in_mem_range(u64 addr, struct kvm_mem_range *range)
> > > +{
> > > +       return range->start <= addr && addr < range->end;
> > > +}
> > > +
> > > +static int range_is_allowed_memory(u64 start, u64 end)
> >
> > The name of this function "range_*is*_..." implies that it returns a
> > boolean, which other functions in this file (and patch) with similar
> > names do, but it returns an error instead. Maybe
> > check_range_allowed_memory)?
>
> Ack, I'll rename in v3.
>
> > >  {
> > >         struct memblock_region *reg;
> > >         struct kvm_mem_range range;
> > >
> > > -       reg = find_mem_range(phys, &range);
> > > +       /* Can't check the state of both MMIO and memory regions at once */
> >
> > I don't understand this comment in relation to the code. Could you
> > explain it to me please?
>
> find_mem_range() will iterate the list of memblocks to find the 'range'
> in which @start falls. That might either be in a memblock (so @addr is
> memory, and @reg != NULL) or outside of one (so @addr is mmio, and
> @reg == NULL). The check right after ensures that @end is in the same
> PA range as @start. IOW, this checks that [start, end[ doesn't overlap
> memory and MMIO, because the following logic wouldn't work for a mixed
> case like that.

I understand now. I think it might be worth elaborating a bit on the
comment to clarify that. What is confusing to me was that the comment
refers to checking state, but it's in a function that does not care
about page state, i.e., it's not immediately obvious that its primary
callers/users are __host_check_page_state_range(), and other functions
that check the state of a range.

> > > +       reg = find_mem_range(start, &range);
> > > +       if (!is_in_mem_range(end - 1, &range))
> > > +               return -EINVAL;
> > >
> > > -       return reg && !(reg->flags & MEMBLOCK_NOMAP);
> > > -}
> > > +       if (!reg || reg->flags & MEMBLOCK_NOMAP)
> > > +               return -EPERM;
> > >
> > > -static bool is_in_mem_range(u64 addr, struct kvm_mem_range *range)
> > > -{
> > > -       return range->start <= addr && addr < range->end;
> > > +       return 0;
> > >  }
> > >
> > >  static bool range_is_memory(u64 start, u64 end)
> > > @@ -454,8 +463,11 @@ static int host_stage2_adjust_range(u64 addr, struct kvm_mem_range *range)
> > >         if (kvm_pte_valid(pte))
> > >                 return -EAGAIN;
> > >
> > > -       if (pte)
> > > +       if (pte) {
> > > +               WARN_ON(addr_is_memory(addr) &&
> > > +                       !(hyp_phys_to_page(addr)->host_state & PKVM_NOPAGE));
> >
> > nit: since the host state is now an enum, should this just be an
> > equality check rather than an &? This makes it consistent with other
> > checks of pkvm_page_state in this patch too.
>
> We don't currently have a state that is additive to PKVM_NOPAGE, so no
> objection from me.
>
> > >                 return -EPERM;
> > > +       }
> > >
> > >         do {
> > >                 u64 granule = kvm_granule_size(level);
> > > @@ -477,10 +489,29 @@ int host_stage2_idmap_locked(phys_addr_t addr, u64 size,
> > >         return host_stage2_try(__host_stage2_idmap, addr, addr + size, prot);
> > >  }
> > >
> > > +static void __host_update_page_state(phys_addr_t addr, u64 size, enum pkvm_page_state state)
> > > +{
> > > +       phys_addr_t end = addr + size;
> >
> > nit: newline
> >
> > > +       for (; addr < end; addr += PAGE_SIZE)
> > > +               hyp_phys_to_page(addr)->host_state = state;
> > > +}
> > > +
> > >  int host_stage2_set_owner_locked(phys_addr_t addr, u64 size, u8 owner_id)
> > >  {
> > > -       return host_stage2_try(kvm_pgtable_stage2_set_owner, &host_mmu.pgt,
> > > -                              addr, size, &host_s2_pool, owner_id);
> > > +       int ret;
> > > +
> > > +       ret = host_stage2_try(kvm_pgtable_stage2_set_owner, &host_mmu.pgt,
> > > +                             addr, size, &host_s2_pool, owner_id);
> > > +       if (ret || !addr_is_memory(addr))
> > > +               return ret;
> >
> > Can hyp set an owner for an address that isn't memory? Trying to
> > understand why we need to update the host stage2 pagetable but not the
> > hypervisor's vmemmap in that case.
>
> I think the answer is not currently, but we will when we'll have to e.g.
> donate IOMMU registers to EL2 and things of that nature. Note that this
> does require an extension to __host_check_page_state_range() to go query
> the page-table 'the old way' for MMIO addresses, though that isn't done
> in this series. If you think strongly that this is confusing, I'm happy
> to drop that check and we'll add it back with the IOMMU series or
> something like that.

I think it's worth a comment if you're not dropping the check..

>
> > > +
> > > +       /* Don't forget to update the vmemmap tracking for the host */
> > > +       if (owner_id == PKVM_ID_HOST)
> > > +               __host_update_page_state(addr, size, PKVM_PAGE_OWNED);
> > > +       else
> > > +               __host_update_page_state(addr, size, PKVM_NOPAGE);
> > > +
> > > +       return 0;
> > >  }
> > >
> > >  static bool host_stage2_force_pte_cb(u64 addr, u64 end, enum kvm_pgtable_prot prot)
> > > @@ -604,35 +635,38 @@ static int check_page_state_range(struct kvm_pgtable *pgt, u64 addr, u64 size,
> > >         return kvm_pgtable_walk(pgt, addr, size, &walker);
> > >  }
> > >
> > > -static enum pkvm_page_state host_get_page_state(kvm_pte_t pte, u64 addr)
> > > -{
> > > -       if (!addr_is_allowed_memory(addr))
> > > -               return PKVM_NOPAGE;
> > > -
> > > -       if (!kvm_pte_valid(pte) && pte)
> > > -               return PKVM_NOPAGE;
> > > -
> > > -       return pkvm_getstate(kvm_pgtable_stage2_pte_prot(pte));
> > > -}
> > > -
> > >  static int __host_check_page_state_range(u64 addr, u64 size,
> > >                                          enum pkvm_page_state state)
> > >  {
> > > -       struct check_walk_data d = {
> > > -               .desired        = state,
> > > -               .get_page_state = host_get_page_state,
> > > -       };
> > > +       u64 end = addr + size;
> > > +       int ret;
> > > +
> > > +       ret = range_is_allowed_memory(addr, end);
> > > +       if (ret)
> > > +               return ret;
> > >
> > >         hyp_assert_lock_held(&host_mmu.lock);
> > > -       return check_page_state_range(&host_mmu.pgt, addr, size, &d);
> > > +       for (; addr < end; addr += PAGE_SIZE) {
> > > +               if (hyp_phys_to_page(addr)->host_state != state)
> > > +                       return -EPERM;
> > > +       }
> > > +
> > > +       return 0;
> > >  }
> > >
> > >  static int __host_set_page_state_range(u64 addr, u64 size,
> > >                                        enum pkvm_page_state state)
> > >  {
> > > -       enum kvm_pgtable_prot prot = pkvm_mkstate(PKVM_HOST_MEM_PROT, state);
> > > +       if (hyp_phys_to_page(addr)->host_state & PKVM_NOPAGE) {
> >
> > Same nit as above regarding checking for PKVM_NOPAGE
> >
> > Cheers,
> > /fuad
> >
> >
> > > +               int ret = host_stage2_idmap_locked(addr, size, PKVM_HOST_MEM_PROT);
> > >
> > > -       return host_stage2_idmap_locked(addr, size, prot);
> > > +               if (ret)
> > > +                       return ret;
> > > +       }
> > > +
> > > +       __host_update_page_state(addr, size, state);
> > > +
> > > +       return 0;
> > >  }
> > >
> > >  static int host_request_owned_transition(u64 *completer_addr,
> > > diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
> > > index cbdd18cd3f98..7e04d1c2a03d 100644
> > > --- a/arch/arm64/kvm/hyp/nvhe/setup.c
> > > +++ b/arch/arm64/kvm/hyp/nvhe/setup.c
> > > @@ -180,7 +180,6 @@ static void hpool_put_page(void *addr)
> > >  static int fix_host_ownership_walker(const struct kvm_pgtable_visit_ctx *ctx,
> > >                                      enum kvm_pgtable_walk_flags visit)
> > >  {
> > > -       enum kvm_pgtable_prot prot;
> > >         enum pkvm_page_state state;
> > >         phys_addr_t phys;
> > >
> > > @@ -203,16 +202,16 @@ static int fix_host_ownership_walker(const struct kvm_pgtable_visit_ctx *ctx,
> > >         case PKVM_PAGE_OWNED:
> > >                 return host_stage2_set_owner_locked(phys, PAGE_SIZE, PKVM_ID_HYP);
> > >         case PKVM_PAGE_SHARED_OWNED:
> > > -               prot = pkvm_mkstate(PKVM_HOST_MEM_PROT, PKVM_PAGE_SHARED_BORROWED);
> > > +               hyp_phys_to_page(phys)->host_state = PKVM_PAGE_SHARED_BORROWED;
> > >                 break;
> > >         case PKVM_PAGE_SHARED_BORROWED:
> > > -               prot = pkvm_mkstate(PKVM_HOST_MEM_PROT, PKVM_PAGE_SHARED_OWNED);
> > > +               hyp_phys_to_page(phys)->host_state = PKVM_PAGE_SHARED_OWNED;
> > >                 break;
> > >         default:
> > >                 return -EINVAL;
> > >         }
> > >
> > > -       return host_stage2_idmap_locked(phys, PAGE_SIZE, prot);
> > > +       return 0;
> > >  }
> > >
> > >  static int fix_hyp_pgtable_refcnt_walker(const struct kvm_pgtable_visit_ctx *ctx,
> > > --
> > > 2.47.0.338.g60cca15819-goog
> > >

