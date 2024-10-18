Return-Path: <linux-kernel+bounces-370919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6A19A33BF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 06:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A98FE1F235CD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 04:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2DC170A0C;
	Fri, 18 Oct 2024 04:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZIxFjafi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47E315EFA1
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 04:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729225434; cv=none; b=LOUiIf6IjuG8qno+vMa/yuZPu4v3QoSkA1BlOwZ5D/yuAMbBPawbIQ2aTJqm5qSStTFl3usdFzdkeLLuusYlzJKATqGtaDnEtnZrijZw4wp7oq4gx2vYUU69ZuB23KB/gJQCj/IEXfiO/C4HbRoK3hM7XaRE0AL6CVT70AraykY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729225434; c=relaxed/simple;
	bh=oaEjeBufgsxokyx9Vgf9icLrk7eQUprT5p8xylj9jQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lBBW+OS0ceVRltB5ny3Njio3Fazm3LJ6obGclSj0U+qBkm81DX96Yv3BxmGZlh3p4enUVf/drGze0dxci7w6A4sh+mGM3su76XbhOI8mdNhWdkbElLFMSurXybc1dhN5HdqONcjSt2ckDSPotMQqFGtkqXm5hyaAwK6wr2BWsLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZIxFjafi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 293B2C4CED1
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 04:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729225434;
	bh=oaEjeBufgsxokyx9Vgf9icLrk7eQUprT5p8xylj9jQ4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZIxFjafiStjWRCp1d+r4ob90W6qayNqtcr+hjNUqbzryHANDjlBxDH5aki8W2YGeJ
	 m48SjnoKiIrA8KrTW166zl7ZZsmV0mOhNt6LiGMvtgSCAX/a4ivv5IynxyfIu1fwPW
	 4wlOWptTkeGyVjwfEzW1b9wDuGdNod7Cnr6YF4gb/rYyPS2C04yLgcJ+r1wWD48y5U
	 RdY5AKHMpqP1e/+eq6ZPUDV5wh3qzjqBlD0SRcwXSCGIAyNFYkD1YhY8wXqUbW7Vnl
	 sIni7zRidxMRkOMcfoR05pzQpwyB5DZS2T1kMdn1RkofXc8vu/qKMMnanksCnKIlP8
	 35muu/zQsIFYw==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a99cc265e0aso218508666b.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 21:23:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXU6SPVWAVIYAr/nkr0atcrfBwZcs+nP5j1qTh0dKSuVXRVudvbK2dDL4bny/M4lVJPsl9sS0/86CSIEa0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOIJvNIk883yrMQ8gdlGmKQNsx/8KY5vd2SUljBp/XnlP5CPwd
	GyskqyKXJHK0iQu5OYk512SF9UsuIxi544JWzJ8qoJ36JGKqnFSjcu2D70spW7wxysrYlsKUtPt
	RC2bW0JmFz1vyIl57pHECcaKXNP4=
X-Google-Smtp-Source: AGHT+IHlmSDtooChjX+SfN2XokMXSg6kFIwiNyf8JhZt7ra0ZAiOpoQKFbNGZY3OeR8v7A0kztDyylIdvYDkvIt8u/k=
X-Received: by 2002:a17:906:c113:b0:a9a:1092:b10d with SMTP id
 a640c23a62f3a-a9a69b7af5dmr66882666b.33.1729225432608; Thu, 17 Oct 2024
 21:23:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014035855.1119220-1-maobibo@loongson.cn> <20241014035855.1119220-2-maobibo@loongson.cn>
 <CAAhV-H5QkULWp6fciR1Lnds0r00fUdrmj86K_wBuxd0D=RkaXQ@mail.gmail.com>
 <f3089991-fd49-8d55-9ede-62ab1555c9fa@loongson.cn> <CAAhV-H7yX6qinPL5E5tmNVpJk_xdKqFaSicUYy2k8NGM1owucw@mail.gmail.com>
 <a4c6b89e-4ffe-4486-4ccd-7ebc28734f6f@loongson.cn>
In-Reply-To: <a4c6b89e-4ffe-4486-4ccd-7ebc28734f6f@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 18 Oct 2024 12:23:39 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6FkJZwa-pALUhucrU5OXxsHg+ByM+4NN0wPQgOJTqOXA@mail.gmail.com>
Message-ID: <CAAhV-H6FkJZwa-pALUhucrU5OXxsHg+ByM+4NN0wPQgOJTqOXA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] LoongArch: Set initial pte entry with PAGE_GLOBAL
 for kernel space
To: maobibo <maobibo@loongson.cn>, wuruiyang@loongson.cn
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Barry Song <baohua@kernel.org>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 12:16=E2=80=AFPM maobibo <maobibo@loongson.cn> wrot=
e:
>
>
>
> On 2024/10/18 =E4=B8=8B=E5=8D=8812:11, Huacai Chen wrote:
> > On Fri, Oct 18, 2024 at 11:44=E2=80=AFAM maobibo <maobibo@loongson.cn> =
wrote:
> >>
> >>
> >>
> >> On 2024/10/18 =E4=B8=8A=E5=8D=8811:14, Huacai Chen wrote:
> >>> Hi, Bibo,
> >>>
> >>> I applied this patch but drop the part of arch/loongarch/mm/kasan_ini=
t.c:
> >>> https://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loon=
gson.git/commit/?h=3Dloongarch-next&id=3D15832255e84494853f543b4c70ced50afc=
403067
> >>>
> >>> Because kernel_pte_init() should operate on page-table pages, not on
> >>> data pages. You have already handle page-table page in
> >>> mm/kasan/init.c, and if we don't drop the modification on data pages
> >>> in arch/loongarch/mm/kasan_init.c, the kernel fail to boot if KASAN i=
s
> >>> enabled.
> >>>
> >> static inline void set_pte(pte_t *ptep, pte_t pteval)
> >>    {
> >>          WRITE_ONCE(*ptep, pteval);
> >> -
> >> -       if (pte_val(pteval) & _PAGE_GLOBAL) {
> >> -               pte_t *buddy =3D ptep_buddy(ptep);
> >> -               /*
> >> -                * Make sure the buddy is global too (if it's !none,
> >> -                * it better already be global)
> >> -                */
> >> -               if (pte_none(ptep_get(buddy))) {
> >> -#ifdef CONFIG_SMP
> >> -                       /*
> >> -                        * For SMP, multiple CPUs can race, so we need
> >> -                        * to do this atomically.
> >> -                        */
> >> -                       __asm__ __volatile__(
> >> -                       __AMOR "$zero, %[global], %[buddy] \n"
> >> -                       : [buddy] "+ZB" (buddy->pte)
> >> -                       : [global] "r" (_PAGE_GLOBAL)
> >> -                       : "memory");
> >> -
> >> -                       DBAR(0b11000); /* o_wrw =3D 0b11000 */
> >> -#else /* !CONFIG_SMP */
> >> -                       WRITE_ONCE(*buddy, __pte(pte_val(ptep_get(budd=
y)) | _PAGE_GLOBAL));
> >> -#endif /* CONFIG_SMP */
> >> -               }
> >> -       }
> >> +       DBAR(0b11000); /* o_wrw =3D 0b11000 */
> >>    }
> >>
> >> No, please hold on. This issue exists about twenty years, Do we need b=
e
> >> in such a hurry now?
> >>
> >> why is DBAR(0b11000) added in set_pte()?
> > It exists before, not added by this patch. The reason is explained in
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?h=3Dv6.12-rc3&id=3Df93f67d06b1023313ef1662eac490e29c025c030
> why speculative accesses may cause spurious page fault in kernel space
> with PTE enabled?  speculative accesses exists anywhere, it does not
> cause spurious page fault.
Confirmed by Ruiyang Wu, and even if DBAR(0b11000) is wrong, that
means another patch's mistake, not this one. This one just keeps the
old behavior.
+CC Ruiyang Wu here.

Huacai

>
> Obvious you do not it and you write wrong patch.
>
> >
> > Huacai
> >
> >>
> >> Regards
> >> Bibo Mao
> >>> Huacai
> >>>
> >>> On Mon, Oct 14, 2024 at 11:59=E2=80=AFAM Bibo Mao <maobibo@loongson.c=
n> wrote:
> >>>>
> >>>> Unlike general architectures, there are two pages in one TLB entry
> >>>> on LoongArch system. For kernel space, it requires both two pte
> >>>> entries with PAGE_GLOBAL bit set, else HW treats it as non-global
> >>>> tlb, there will be potential problems if tlb entry for kernel space
> >>>> is not global. Such as fail to flush kernel tlb with function
> >>>> local_flush_tlb_kernel_range() which only flush tlb with global bit.
> >>>>
> >>>> With function kernel_pte_init() added, it can be used to init pte
> >>>> table when it is created for kernel address space, and the default
> >>>> initial pte value is PAGE_GLOBAL rather than zero at beginning.
> >>>>
> >>>> Kernel address space areas includes fixmap, percpu, vmalloc, kasan
> >>>> and vmemmap areas set default pte entry with PAGE_GLOBAL set.
> >>>>
> >>>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> >>>> ---
> >>>>    arch/loongarch/include/asm/pgalloc.h | 13 +++++++++++++
> >>>>    arch/loongarch/include/asm/pgtable.h |  1 +
> >>>>    arch/loongarch/mm/init.c             |  4 +++-
> >>>>    arch/loongarch/mm/kasan_init.c       |  4 +++-
> >>>>    arch/loongarch/mm/pgtable.c          | 22 ++++++++++++++++++++++
> >>>>    include/linux/mm.h                   |  1 +
> >>>>    mm/kasan/init.c                      |  8 +++++++-
> >>>>    mm/sparse-vmemmap.c                  |  5 +++++
> >>>>    8 files changed, 55 insertions(+), 3 deletions(-)
> >>>>
> >>>> diff --git a/arch/loongarch/include/asm/pgalloc.h b/arch/loongarch/i=
nclude/asm/pgalloc.h
> >>>> index 4e2d6b7ca2ee..b2698c03dc2c 100644
> >>>> --- a/arch/loongarch/include/asm/pgalloc.h
> >>>> +++ b/arch/loongarch/include/asm/pgalloc.h
> >>>> @@ -10,8 +10,21 @@
> >>>>
> >>>>    #define __HAVE_ARCH_PMD_ALLOC_ONE
> >>>>    #define __HAVE_ARCH_PUD_ALLOC_ONE
> >>>> +#define __HAVE_ARCH_PTE_ALLOC_ONE_KERNEL
> >>>>    #include <asm-generic/pgalloc.h>
> >>>>
> >>>> +static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
> >>>> +{
> >>>> +       pte_t *pte;
> >>>> +
> >>>> +       pte =3D (pte_t *) __get_free_page(GFP_KERNEL);
> >>>> +       if (!pte)
> >>>> +               return NULL;
> >>>> +
> >>>> +       kernel_pte_init(pte);
> >>>> +       return pte;
> >>>> +}
> >>>> +
> >>>>    static inline void pmd_populate_kernel(struct mm_struct *mm,
> >>>>                                          pmd_t *pmd, pte_t *pte)
> >>>>    {
> >>>> diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/i=
nclude/asm/pgtable.h
> >>>> index 9965f52ef65b..22e3a8f96213 100644
> >>>> --- a/arch/loongarch/include/asm/pgtable.h
> >>>> +++ b/arch/loongarch/include/asm/pgtable.h
> >>>> @@ -269,6 +269,7 @@ extern void set_pmd_at(struct mm_struct *mm, uns=
igned long addr, pmd_t *pmdp, pm
> >>>>    extern void pgd_init(void *addr);
> >>>>    extern void pud_init(void *addr);
> >>>>    extern void pmd_init(void *addr);
> >>>> +extern void kernel_pte_init(void *addr);
> >>>>
> >>>>    /*
> >>>>     * Encode/decode swap entries and swap PTEs. Swap PTEs are all PT=
Es that
> >>>> diff --git a/arch/loongarch/mm/init.c b/arch/loongarch/mm/init.c
> >>>> index 8a87a482c8f4..9f26e933a8a3 100644
> >>>> --- a/arch/loongarch/mm/init.c
> >>>> +++ b/arch/loongarch/mm/init.c
> >>>> @@ -198,9 +198,11 @@ pte_t * __init populate_kernel_pte(unsigned lon=
g addr)
> >>>>           if (!pmd_present(pmdp_get(pmd))) {
> >>>>                   pte_t *pte;
> >>>>
> >>>> -               pte =3D memblock_alloc(PAGE_SIZE, PAGE_SIZE);
> >>>> +               pte =3D memblock_alloc_raw(PAGE_SIZE, PAGE_SIZE);
> >>>>                   if (!pte)
> >>>>                           panic("%s: Failed to allocate memory\n", _=
_func__);
> >>>> +
> >>>> +               kernel_pte_init(pte);
> >>>>                   pmd_populate_kernel(&init_mm, pmd, pte);
> >>>>           }
> >>>>
> >>>> diff --git a/arch/loongarch/mm/kasan_init.c b/arch/loongarch/mm/kasa=
n_init.c
> >>>> index 427d6b1aec09..34988573b0d5 100644
> >>>> --- a/arch/loongarch/mm/kasan_init.c
> >>>> +++ b/arch/loongarch/mm/kasan_init.c
> >>>> @@ -152,6 +152,8 @@ static void __init kasan_pte_populate(pmd_t *pmd=
p, unsigned long addr,
> >>>>                   phys_addr_t page_phys =3D early ?
> >>>>                                           __pa_symbol(kasan_early_sh=
adow_page)
> >>>>                                                 : kasan_alloc_zeroed=
_page(node);
> >>>> +               if (!early)
> >>>> +                       kernel_pte_init(__va(page_phys));
> >>>>                   next =3D addr + PAGE_SIZE;
> >>>>                   set_pte(ptep, pfn_pte(__phys_to_pfn(page_phys), PA=
GE_KERNEL));
> >>>>           } while (ptep++, addr =3D next, addr !=3D end && __pte_non=
e(early, ptep_get(ptep)));
> >>>> @@ -287,7 +289,7 @@ void __init kasan_init(void)
> >>>>                   set_pte(&kasan_early_shadow_pte[i],
> >>>>                           pfn_pte(__phys_to_pfn(__pa_symbol(kasan_ea=
rly_shadow_page)), PAGE_KERNEL_RO));
> >>>>
> >>>> -       memset(kasan_early_shadow_page, 0, PAGE_SIZE);
> >>>> +       kernel_pte_init(kasan_early_shadow_page);
> >>>>           csr_write64(__pa_symbol(swapper_pg_dir), LOONGARCH_CSR_PGD=
H);
> >>>>           local_flush_tlb_all();
> >>>>
> >>>> diff --git a/arch/loongarch/mm/pgtable.c b/arch/loongarch/mm/pgtable=
.c
> >>>> index eb6a29b491a7..228ffc1db0a3 100644
> >>>> --- a/arch/loongarch/mm/pgtable.c
> >>>> +++ b/arch/loongarch/mm/pgtable.c
> >>>> @@ -38,6 +38,28 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
> >>>>    }
> >>>>    EXPORT_SYMBOL_GPL(pgd_alloc);
> >>>>
> >>>> +void kernel_pte_init(void *addr)
> >>>> +{
> >>>> +       unsigned long *p, *end;
> >>>> +       unsigned long entry;
> >>>> +
> >>>> +       entry =3D (unsigned long)_PAGE_GLOBAL;
> >>>> +       p =3D (unsigned long *)addr;
> >>>> +       end =3D p + PTRS_PER_PTE;
> >>>> +
> >>>> +       do {
> >>>> +               p[0] =3D entry;
> >>>> +               p[1] =3D entry;
> >>>> +               p[2] =3D entry;
> >>>> +               p[3] =3D entry;
> >>>> +               p[4] =3D entry;
> >>>> +               p +=3D 8;
> >>>> +               p[-3] =3D entry;
> >>>> +               p[-2] =3D entry;
> >>>> +               p[-1] =3D entry;
> >>>> +       } while (p !=3D end);
> >>>> +}
> >>>> +
> >>>>    void pgd_init(void *addr)
> >>>>    {
> >>>>           unsigned long *p, *end;
> >>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
> >>>> index ecf63d2b0582..6909fe059a2c 100644
> >>>> --- a/include/linux/mm.h
> >>>> +++ b/include/linux/mm.h
> >>>> @@ -3818,6 +3818,7 @@ void *sparse_buffer_alloc(unsigned long size);
> >>>>    struct page * __populate_section_memmap(unsigned long pfn,
> >>>>                   unsigned long nr_pages, int nid, struct vmem_altma=
p *altmap,
> >>>>                   struct dev_pagemap *pgmap);
> >>>> +void kernel_pte_init(void *addr);
> >>>>    void pmd_init(void *addr);
> >>>>    void pud_init(void *addr);
> >>>>    pgd_t *vmemmap_pgd_populate(unsigned long addr, int node);
> >>>> diff --git a/mm/kasan/init.c b/mm/kasan/init.c
> >>>> index 89895f38f722..ac607c306292 100644
> >>>> --- a/mm/kasan/init.c
> >>>> +++ b/mm/kasan/init.c
> >>>> @@ -106,6 +106,10 @@ static void __ref zero_pte_populate(pmd_t *pmd,=
 unsigned long addr,
> >>>>           }
> >>>>    }
> >>>>
> >>>> +void __weak __meminit kernel_pte_init(void *addr)
> >>>> +{
> >>>> +}
> >>>> +
> >>>>    static int __ref zero_pmd_populate(pud_t *pud, unsigned long addr=
,
> >>>>                                   unsigned long end)
> >>>>    {
> >>>> @@ -126,8 +130,10 @@ static int __ref zero_pmd_populate(pud_t *pud, =
unsigned long addr,
> >>>>
> >>>>                           if (slab_is_available())
> >>>>                                   p =3D pte_alloc_one_kernel(&init_m=
m);
> >>>> -                       else
> >>>> +                       else {
> >>>>                                   p =3D early_alloc(PAGE_SIZE, NUMA_=
NO_NODE);
> >>>> +                               kernel_pte_init(p);
> >>>> +                       }
> >>>>                           if (!p)
> >>>>                                   return -ENOMEM;
> >>>>
> >>>> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> >>>> index edcc7a6b0f6f..c0388b2e959d 100644
> >>>> --- a/mm/sparse-vmemmap.c
> >>>> +++ b/mm/sparse-vmemmap.c
> >>>> @@ -184,6 +184,10 @@ static void * __meminit vmemmap_alloc_block_zer=
o(unsigned long size, int node)
> >>>>           return p;
> >>>>    }
> >>>>
> >>>> +void __weak __meminit kernel_pte_init(void *addr)
> >>>> +{
> >>>> +}
> >>>> +
> >>>>    pmd_t * __meminit vmemmap_pmd_populate(pud_t *pud, unsigned long =
addr, int node)
> >>>>    {
> >>>>           pmd_t *pmd =3D pmd_offset(pud, addr);
> >>>> @@ -191,6 +195,7 @@ pmd_t * __meminit vmemmap_pmd_populate(pud_t *pu=
d, unsigned long addr, int node)
> >>>>                   void *p =3D vmemmap_alloc_block_zero(PAGE_SIZE, no=
de);
> >>>>                   if (!p)
> >>>>                           return NULL;
> >>>> +               kernel_pte_init(p);
> >>>>                   pmd_populate_kernel(&init_mm, pmd, p);
> >>>>           }
> >>>>           return pmd;
> >>>> --
> >>>> 2.39.3
> >>>>
> >>
> >>
>
>

