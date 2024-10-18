Return-Path: <linux-kernel+bounces-370913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA0E9A33AC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 06:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88CB628536B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 04:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5B616DEA9;
	Fri, 18 Oct 2024 04:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pO2C0poX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4FF13AA20
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 04:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729224688; cv=none; b=o7p/EL2gvfcU9Y1kwLrrNRzdyi5x+r15GdEt0UPd9dRXQtUXMA5l1VQ+PEY3n02t435Hna2YHAD+EU2uoqfLZtl1GNfMVoo0IPQm7grWkLv9M5Xn0uW5fdKpwG215yjb1UThhVFxR8c439KvubXerH7aPD6UB9sVN++I9HFOWqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729224688; c=relaxed/simple;
	bh=M4xMdzWUYDYsswzwreGWXW+5d57MFNxS5zGIeZrlts0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DhzpHxtnGX+vfrzKXi7mz65TFpjVCBRiueL8Nhz0G4AStGDN0FuMi1buN8Sp1U5H8jpykOsRVEqrRsm5ePHt+SYmQ7cTLpBIofmDF8elU/AUvFfOfYoWjj0ZZJD0l22QFlsTzeka+KMgnHUC7BTReNpm4WU/yKdHHIsnppRuNkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pO2C0poX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 234D2C4CED2
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 04:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729224688;
	bh=M4xMdzWUYDYsswzwreGWXW+5d57MFNxS5zGIeZrlts0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pO2C0poXyNekmwQdQIEoLgoLNUWJ1nViNplDQ3QxZ3gcD9lDMJgftxsWuuehf/x9L
	 dWj0RL14EoyGFoAJChuLT0UXKUz7un1kIoBG/nvg8DQsver+yaUZP/n1M6dczNEIN0
	 O28XUSDOXL02zm3Vk6+3wgZTLTV0Rd2WjDiX4bdIqQBxFeP0Mld67yHih+lkAhSJf5
	 /uGpoDopZvyTa7dc7HVsoCvDaYoh+33LITUi/9hpNW881tMD4MG1iKjj1LQ34Uj2vX
	 RSh3eHSwUmIlthkKfNMF0hn5cQ9TLThQ+hy4sTv/5gYE3JvfPB2wBhdbaQ/olCdaPT
	 JEmMsgoUpCTaQ==
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d473c4bb6so1443031f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 21:11:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUxd+mizfbch8zCeYzkyPDIdNKrCn3b2ikdjKGgZZEDAxqD7KMKIv9tJ539UAvm7l8NcpS/KXhwPOduCOg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze8Z8s1ByPlaj73cK8Ytb0sJrBv5zQHMhkeqRGTOpaeqmfZ1oB
	weppozFvW92lP/NuqvEQ7awg+w4GWKmGMY8dGRBeXWbMyMKEUk03TNukAoUk2I2In9lz8KwqvZh
	dxBbhWqJXAbZqt+68wjXnVBjwmXg=
X-Google-Smtp-Source: AGHT+IGWmAlgyNnGkEpy4UcuRLUazCnbZauBw8TXZzNt3+YAjsqrIF0+9cr2xJC1OJUIPNETW1cpoN5chrxuH7klFsc=
X-Received: by 2002:a5d:4d01:0:b0:37c:cc4b:d1d6 with SMTP id
 ffacd0b85a97d-37eab2e3550mr868073f8f.27.1729224686670; Thu, 17 Oct 2024
 21:11:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014035855.1119220-1-maobibo@loongson.cn> <20241014035855.1119220-2-maobibo@loongson.cn>
 <CAAhV-H5QkULWp6fciR1Lnds0r00fUdrmj86K_wBuxd0D=RkaXQ@mail.gmail.com> <f3089991-fd49-8d55-9ede-62ab1555c9fa@loongson.cn>
In-Reply-To: <f3089991-fd49-8d55-9ede-62ab1555c9fa@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 18 Oct 2024 12:11:04 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7yX6qinPL5E5tmNVpJk_xdKqFaSicUYy2k8NGM1owucw@mail.gmail.com>
Message-ID: <CAAhV-H7yX6qinPL5E5tmNVpJk_xdKqFaSicUYy2k8NGM1owucw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] LoongArch: Set initial pte entry with PAGE_GLOBAL
 for kernel space
To: maobibo <maobibo@loongson.cn>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Barry Song <baohua@kernel.org>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 11:44=E2=80=AFAM maobibo <maobibo@loongson.cn> wrot=
e:
>
>
>
> On 2024/10/18 =E4=B8=8A=E5=8D=8811:14, Huacai Chen wrote:
> > Hi, Bibo,
> >
> > I applied this patch but drop the part of arch/loongarch/mm/kasan_init.=
c:
> > https://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongs=
on.git/commit/?h=3Dloongarch-next&id=3D15832255e84494853f543b4c70ced50afc40=
3067
> >
> > Because kernel_pte_init() should operate on page-table pages, not on
> > data pages. You have already handle page-table page in
> > mm/kasan/init.c, and if we don't drop the modification on data pages
> > in arch/loongarch/mm/kasan_init.c, the kernel fail to boot if KASAN is
> > enabled.
> >
> static inline void set_pte(pte_t *ptep, pte_t pteval)
>   {
>         WRITE_ONCE(*ptep, pteval);
> -
> -       if (pte_val(pteval) & _PAGE_GLOBAL) {
> -               pte_t *buddy =3D ptep_buddy(ptep);
> -               /*
> -                * Make sure the buddy is global too (if it's !none,
> -                * it better already be global)
> -                */
> -               if (pte_none(ptep_get(buddy))) {
> -#ifdef CONFIG_SMP
> -                       /*
> -                        * For SMP, multiple CPUs can race, so we need
> -                        * to do this atomically.
> -                        */
> -                       __asm__ __volatile__(
> -                       __AMOR "$zero, %[global], %[buddy] \n"
> -                       : [buddy] "+ZB" (buddy->pte)
> -                       : [global] "r" (_PAGE_GLOBAL)
> -                       : "memory");
> -
> -                       DBAR(0b11000); /* o_wrw =3D 0b11000 */
> -#else /* !CONFIG_SMP */
> -                       WRITE_ONCE(*buddy, __pte(pte_val(ptep_get(buddy))=
 | _PAGE_GLOBAL));
> -#endif /* CONFIG_SMP */
> -               }
> -       }
> +       DBAR(0b11000); /* o_wrw =3D 0b11000 */
>   }
>
> No, please hold on. This issue exists about twenty years, Do we need be
> in such a hurry now?
>
> why is DBAR(0b11000) added in set_pte()?
It exists before, not added by this patch. The reason is explained in
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
h=3Dv6.12-rc3&id=3Df93f67d06b1023313ef1662eac490e29c025c030

Huacai

>
> Regards
> Bibo Mao
> > Huacai
> >
> > On Mon, Oct 14, 2024 at 11:59=E2=80=AFAM Bibo Mao <maobibo@loongson.cn>=
 wrote:
> >>
> >> Unlike general architectures, there are two pages in one TLB entry
> >> on LoongArch system. For kernel space, it requires both two pte
> >> entries with PAGE_GLOBAL bit set, else HW treats it as non-global
> >> tlb, there will be potential problems if tlb entry for kernel space
> >> is not global. Such as fail to flush kernel tlb with function
> >> local_flush_tlb_kernel_range() which only flush tlb with global bit.
> >>
> >> With function kernel_pte_init() added, it can be used to init pte
> >> table when it is created for kernel address space, and the default
> >> initial pte value is PAGE_GLOBAL rather than zero at beginning.
> >>
> >> Kernel address space areas includes fixmap, percpu, vmalloc, kasan
> >> and vmemmap areas set default pte entry with PAGE_GLOBAL set.
> >>
> >> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> >> ---
> >>   arch/loongarch/include/asm/pgalloc.h | 13 +++++++++++++
> >>   arch/loongarch/include/asm/pgtable.h |  1 +
> >>   arch/loongarch/mm/init.c             |  4 +++-
> >>   arch/loongarch/mm/kasan_init.c       |  4 +++-
> >>   arch/loongarch/mm/pgtable.c          | 22 ++++++++++++++++++++++
> >>   include/linux/mm.h                   |  1 +
> >>   mm/kasan/init.c                      |  8 +++++++-
> >>   mm/sparse-vmemmap.c                  |  5 +++++
> >>   8 files changed, 55 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/arch/loongarch/include/asm/pgalloc.h b/arch/loongarch/inc=
lude/asm/pgalloc.h
> >> index 4e2d6b7ca2ee..b2698c03dc2c 100644
> >> --- a/arch/loongarch/include/asm/pgalloc.h
> >> +++ b/arch/loongarch/include/asm/pgalloc.h
> >> @@ -10,8 +10,21 @@
> >>
> >>   #define __HAVE_ARCH_PMD_ALLOC_ONE
> >>   #define __HAVE_ARCH_PUD_ALLOC_ONE
> >> +#define __HAVE_ARCH_PTE_ALLOC_ONE_KERNEL
> >>   #include <asm-generic/pgalloc.h>
> >>
> >> +static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
> >> +{
> >> +       pte_t *pte;
> >> +
> >> +       pte =3D (pte_t *) __get_free_page(GFP_KERNEL);
> >> +       if (!pte)
> >> +               return NULL;
> >> +
> >> +       kernel_pte_init(pte);
> >> +       return pte;
> >> +}
> >> +
> >>   static inline void pmd_populate_kernel(struct mm_struct *mm,
> >>                                         pmd_t *pmd, pte_t *pte)
> >>   {
> >> diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/inc=
lude/asm/pgtable.h
> >> index 9965f52ef65b..22e3a8f96213 100644
> >> --- a/arch/loongarch/include/asm/pgtable.h
> >> +++ b/arch/loongarch/include/asm/pgtable.h
> >> @@ -269,6 +269,7 @@ extern void set_pmd_at(struct mm_struct *mm, unsig=
ned long addr, pmd_t *pmdp, pm
> >>   extern void pgd_init(void *addr);
> >>   extern void pud_init(void *addr);
> >>   extern void pmd_init(void *addr);
> >> +extern void kernel_pte_init(void *addr);
> >>
> >>   /*
> >>    * Encode/decode swap entries and swap PTEs. Swap PTEs are all PTEs =
that
> >> diff --git a/arch/loongarch/mm/init.c b/arch/loongarch/mm/init.c
> >> index 8a87a482c8f4..9f26e933a8a3 100644
> >> --- a/arch/loongarch/mm/init.c
> >> +++ b/arch/loongarch/mm/init.c
> >> @@ -198,9 +198,11 @@ pte_t * __init populate_kernel_pte(unsigned long =
addr)
> >>          if (!pmd_present(pmdp_get(pmd))) {
> >>                  pte_t *pte;
> >>
> >> -               pte =3D memblock_alloc(PAGE_SIZE, PAGE_SIZE);
> >> +               pte =3D memblock_alloc_raw(PAGE_SIZE, PAGE_SIZE);
> >>                  if (!pte)
> >>                          panic("%s: Failed to allocate memory\n", __fu=
nc__);
> >> +
> >> +               kernel_pte_init(pte);
> >>                  pmd_populate_kernel(&init_mm, pmd, pte);
> >>          }
> >>
> >> diff --git a/arch/loongarch/mm/kasan_init.c b/arch/loongarch/mm/kasan_=
init.c
> >> index 427d6b1aec09..34988573b0d5 100644
> >> --- a/arch/loongarch/mm/kasan_init.c
> >> +++ b/arch/loongarch/mm/kasan_init.c
> >> @@ -152,6 +152,8 @@ static void __init kasan_pte_populate(pmd_t *pmdp,=
 unsigned long addr,
> >>                  phys_addr_t page_phys =3D early ?
> >>                                          __pa_symbol(kasan_early_shado=
w_page)
> >>                                                : kasan_alloc_zeroed_pa=
ge(node);
> >> +               if (!early)
> >> +                       kernel_pte_init(__va(page_phys));
> >>                  next =3D addr + PAGE_SIZE;
> >>                  set_pte(ptep, pfn_pte(__phys_to_pfn(page_phys), PAGE_=
KERNEL));
> >>          } while (ptep++, addr =3D next, addr !=3D end && __pte_none(e=
arly, ptep_get(ptep)));
> >> @@ -287,7 +289,7 @@ void __init kasan_init(void)
> >>                  set_pte(&kasan_early_shadow_pte[i],
> >>                          pfn_pte(__phys_to_pfn(__pa_symbol(kasan_early=
_shadow_page)), PAGE_KERNEL_RO));
> >>
> >> -       memset(kasan_early_shadow_page, 0, PAGE_SIZE);
> >> +       kernel_pte_init(kasan_early_shadow_page);
> >>          csr_write64(__pa_symbol(swapper_pg_dir), LOONGARCH_CSR_PGDH);
> >>          local_flush_tlb_all();
> >>
> >> diff --git a/arch/loongarch/mm/pgtable.c b/arch/loongarch/mm/pgtable.c
> >> index eb6a29b491a7..228ffc1db0a3 100644
> >> --- a/arch/loongarch/mm/pgtable.c
> >> +++ b/arch/loongarch/mm/pgtable.c
> >> @@ -38,6 +38,28 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
> >>   }
> >>   EXPORT_SYMBOL_GPL(pgd_alloc);
> >>
> >> +void kernel_pte_init(void *addr)
> >> +{
> >> +       unsigned long *p, *end;
> >> +       unsigned long entry;
> >> +
> >> +       entry =3D (unsigned long)_PAGE_GLOBAL;
> >> +       p =3D (unsigned long *)addr;
> >> +       end =3D p + PTRS_PER_PTE;
> >> +
> >> +       do {
> >> +               p[0] =3D entry;
> >> +               p[1] =3D entry;
> >> +               p[2] =3D entry;
> >> +               p[3] =3D entry;
> >> +               p[4] =3D entry;
> >> +               p +=3D 8;
> >> +               p[-3] =3D entry;
> >> +               p[-2] =3D entry;
> >> +               p[-1] =3D entry;
> >> +       } while (p !=3D end);
> >> +}
> >> +
> >>   void pgd_init(void *addr)
> >>   {
> >>          unsigned long *p, *end;
> >> diff --git a/include/linux/mm.h b/include/linux/mm.h
> >> index ecf63d2b0582..6909fe059a2c 100644
> >> --- a/include/linux/mm.h
> >> +++ b/include/linux/mm.h
> >> @@ -3818,6 +3818,7 @@ void *sparse_buffer_alloc(unsigned long size);
> >>   struct page * __populate_section_memmap(unsigned long pfn,
> >>                  unsigned long nr_pages, int nid, struct vmem_altmap *=
altmap,
> >>                  struct dev_pagemap *pgmap);
> >> +void kernel_pte_init(void *addr);
> >>   void pmd_init(void *addr);
> >>   void pud_init(void *addr);
> >>   pgd_t *vmemmap_pgd_populate(unsigned long addr, int node);
> >> diff --git a/mm/kasan/init.c b/mm/kasan/init.c
> >> index 89895f38f722..ac607c306292 100644
> >> --- a/mm/kasan/init.c
> >> +++ b/mm/kasan/init.c
> >> @@ -106,6 +106,10 @@ static void __ref zero_pte_populate(pmd_t *pmd, u=
nsigned long addr,
> >>          }
> >>   }
> >>
> >> +void __weak __meminit kernel_pte_init(void *addr)
> >> +{
> >> +}
> >> +
> >>   static int __ref zero_pmd_populate(pud_t *pud, unsigned long addr,
> >>                                  unsigned long end)
> >>   {
> >> @@ -126,8 +130,10 @@ static int __ref zero_pmd_populate(pud_t *pud, un=
signed long addr,
> >>
> >>                          if (slab_is_available())
> >>                                  p =3D pte_alloc_one_kernel(&init_mm);
> >> -                       else
> >> +                       else {
> >>                                  p =3D early_alloc(PAGE_SIZE, NUMA_NO_=
NODE);
> >> +                               kernel_pte_init(p);
> >> +                       }
> >>                          if (!p)
> >>                                  return -ENOMEM;
> >>
> >> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> >> index edcc7a6b0f6f..c0388b2e959d 100644
> >> --- a/mm/sparse-vmemmap.c
> >> +++ b/mm/sparse-vmemmap.c
> >> @@ -184,6 +184,10 @@ static void * __meminit vmemmap_alloc_block_zero(=
unsigned long size, int node)
> >>          return p;
> >>   }
> >>
> >> +void __weak __meminit kernel_pte_init(void *addr)
> >> +{
> >> +}
> >> +
> >>   pmd_t * __meminit vmemmap_pmd_populate(pud_t *pud, unsigned long add=
r, int node)
> >>   {
> >>          pmd_t *pmd =3D pmd_offset(pud, addr);
> >> @@ -191,6 +195,7 @@ pmd_t * __meminit vmemmap_pmd_populate(pud_t *pud,=
 unsigned long addr, int node)
> >>                  void *p =3D vmemmap_alloc_block_zero(PAGE_SIZE, node)=
;
> >>                  if (!p)
> >>                          return NULL;
> >> +               kernel_pte_init(p);
> >>                  pmd_populate_kernel(&init_mm, pmd, p);
> >>          }
> >>          return pmd;
> >> --
> >> 2.39.3
> >>
>
>

