Return-Path: <linux-kernel+bounces-370884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C8F9A333B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 05:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8416628557F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 03:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3395B155744;
	Fri, 18 Oct 2024 03:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEDbctta"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6865215573F
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 03:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729221299; cv=none; b=hrsTScALlBQmZ/y22x/iqJ1/s71Zy1V2Tp34yFswZ4jwlswI17pobYdkqSohIlKApa/HvNiUmdZgPB7Y2E3PetAWbx05TsBNCt06EnvLlZxuGL5rHw1Lmwg7cg3TPWM3tRhGzMtoS4nsR3lLFBYoVe6ln8zYue7zHN811AV7FJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729221299; c=relaxed/simple;
	bh=KmjEbRrzxhUWGgngpu8Dj+x57SzWITnUXqEIo2h7KmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bueugR2RUFP6t9VIfWXvZKn+paEpnWakWGy3niEod6sCdFknfUkQDcZOpIh1jjouo3Qn03fBloCHReXVLnSzsUHfe1ArtEb4SoVNdxmva6jsTnVR9okYXl7zCRA9ARukHxFcwZTuEh/CThRly6dlIFb1WWPbA8FS/8PEgD/P6zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEDbctta; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 151EAC4AF0B
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 03:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729221299;
	bh=KmjEbRrzxhUWGgngpu8Dj+x57SzWITnUXqEIo2h7KmI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KEDbcttaC0lftx/o5BrzS/1jUpAT4GohW8Gk/HxQkKAXr1ptcn2qEvn5lcbUhjI6R
	 ezYvgkhC9J0p7iYU8CcQ6aqtjHrCwdlWLsGZ56Vm2tn/Gl/prhxKLPYtpWN9OJipmx
	 AkOrmjMLeATT3109HsKfq+8o8g66xKI29JxMRvDVXIPm+SZ9HrSCdGaJ0VGXvx+ov8
	 PP9lviZOLbuWGJfJtFxoM+4bFrcA2H72moUY7giLAawy7j1w7KnzWyTafIDeHvEEGm
	 7zSJeaCdf3Zm58yXFzBLjWYVGVeEJlKULEiFKjAVV6cL1IPNVVSy5o4PDRjaJc+6Ok
	 0+JRS/rNxrqAQ==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c903f5bd0eso2855085a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 20:14:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW5286wbsdYgFOFiP3YKhO6DZ2SBXHt6H5gmNaJPvS1UnR1IQUatjlk8Bdef60VSNzbW785gnbhycymF6U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7vDustEPyLf9zzgmZM7ieQgoq3BiKb+7eYwYubzhuqr4n9fpP
	bXKCo93wdk+Iatkgt9AzOw+dJhVcOPIXBDwPNnfQr+pnNW8QqEwIw+KGTHyOsjRcvg60FfRy3Ay
	FWTl/jioho6BTq7pQ5vwqUyNlvcU=
X-Google-Smtp-Source: AGHT+IHMwkL76z+Ol37VNEyMkdkYO1NcJNpqPS9mcoMfV4MNVSUCFQBM09k1qZRevzoF1k9j62ZTRvRsKFV2zS/9W7c=
X-Received: by 2002:a17:907:6e86:b0:a99:e82a:87ee with SMTP id
 a640c23a62f3a-a9a69cd2ffemr63769566b.57.1729221297651; Thu, 17 Oct 2024
 20:14:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014035855.1119220-1-maobibo@loongson.cn> <20241014035855.1119220-2-maobibo@loongson.cn>
In-Reply-To: <20241014035855.1119220-2-maobibo@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 18 Oct 2024 11:14:45 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5QkULWp6fciR1Lnds0r00fUdrmj86K_wBuxd0D=RkaXQ@mail.gmail.com>
Message-ID: <CAAhV-H5QkULWp6fciR1Lnds0r00fUdrmj86K_wBuxd0D=RkaXQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] LoongArch: Set initial pte entry with PAGE_GLOBAL
 for kernel space
To: Bibo Mao <maobibo@loongson.cn>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Barry Song <baohua@kernel.org>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Bibo,

I applied this patch but drop the part of arch/loongarch/mm/kasan_init.c:
https://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.g=
it/commit/?h=3Dloongarch-next&id=3D15832255e84494853f543b4c70ced50afc403067

Because kernel_pte_init() should operate on page-table pages, not on
data pages. You have already handle page-table page in
mm/kasan/init.c, and if we don't drop the modification on data pages
in arch/loongarch/mm/kasan_init.c, the kernel fail to boot if KASAN is
enabled.

Huacai

On Mon, Oct 14, 2024 at 11:59=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> wro=
te:
>
> Unlike general architectures, there are two pages in one TLB entry
> on LoongArch system. For kernel space, it requires both two pte
> entries with PAGE_GLOBAL bit set, else HW treats it as non-global
> tlb, there will be potential problems if tlb entry for kernel space
> is not global. Such as fail to flush kernel tlb with function
> local_flush_tlb_kernel_range() which only flush tlb with global bit.
>
> With function kernel_pte_init() added, it can be used to init pte
> table when it is created for kernel address space, and the default
> initial pte value is PAGE_GLOBAL rather than zero at beginning.
>
> Kernel address space areas includes fixmap, percpu, vmalloc, kasan
> and vmemmap areas set default pte entry with PAGE_GLOBAL set.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  arch/loongarch/include/asm/pgalloc.h | 13 +++++++++++++
>  arch/loongarch/include/asm/pgtable.h |  1 +
>  arch/loongarch/mm/init.c             |  4 +++-
>  arch/loongarch/mm/kasan_init.c       |  4 +++-
>  arch/loongarch/mm/pgtable.c          | 22 ++++++++++++++++++++++
>  include/linux/mm.h                   |  1 +
>  mm/kasan/init.c                      |  8 +++++++-
>  mm/sparse-vmemmap.c                  |  5 +++++
>  8 files changed, 55 insertions(+), 3 deletions(-)
>
> diff --git a/arch/loongarch/include/asm/pgalloc.h b/arch/loongarch/includ=
e/asm/pgalloc.h
> index 4e2d6b7ca2ee..b2698c03dc2c 100644
> --- a/arch/loongarch/include/asm/pgalloc.h
> +++ b/arch/loongarch/include/asm/pgalloc.h
> @@ -10,8 +10,21 @@
>
>  #define __HAVE_ARCH_PMD_ALLOC_ONE
>  #define __HAVE_ARCH_PUD_ALLOC_ONE
> +#define __HAVE_ARCH_PTE_ALLOC_ONE_KERNEL
>  #include <asm-generic/pgalloc.h>
>
> +static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
> +{
> +       pte_t *pte;
> +
> +       pte =3D (pte_t *) __get_free_page(GFP_KERNEL);
> +       if (!pte)
> +               return NULL;
> +
> +       kernel_pte_init(pte);
> +       return pte;
> +}
> +
>  static inline void pmd_populate_kernel(struct mm_struct *mm,
>                                        pmd_t *pmd, pte_t *pte)
>  {
> diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/includ=
e/asm/pgtable.h
> index 9965f52ef65b..22e3a8f96213 100644
> --- a/arch/loongarch/include/asm/pgtable.h
> +++ b/arch/loongarch/include/asm/pgtable.h
> @@ -269,6 +269,7 @@ extern void set_pmd_at(struct mm_struct *mm, unsigned=
 long addr, pmd_t *pmdp, pm
>  extern void pgd_init(void *addr);
>  extern void pud_init(void *addr);
>  extern void pmd_init(void *addr);
> +extern void kernel_pte_init(void *addr);
>
>  /*
>   * Encode/decode swap entries and swap PTEs. Swap PTEs are all PTEs that
> diff --git a/arch/loongarch/mm/init.c b/arch/loongarch/mm/init.c
> index 8a87a482c8f4..9f26e933a8a3 100644
> --- a/arch/loongarch/mm/init.c
> +++ b/arch/loongarch/mm/init.c
> @@ -198,9 +198,11 @@ pte_t * __init populate_kernel_pte(unsigned long add=
r)
>         if (!pmd_present(pmdp_get(pmd))) {
>                 pte_t *pte;
>
> -               pte =3D memblock_alloc(PAGE_SIZE, PAGE_SIZE);
> +               pte =3D memblock_alloc_raw(PAGE_SIZE, PAGE_SIZE);
>                 if (!pte)
>                         panic("%s: Failed to allocate memory\n", __func__=
);
> +
> +               kernel_pte_init(pte);
>                 pmd_populate_kernel(&init_mm, pmd, pte);
>         }
>
> diff --git a/arch/loongarch/mm/kasan_init.c b/arch/loongarch/mm/kasan_ini=
t.c
> index 427d6b1aec09..34988573b0d5 100644
> --- a/arch/loongarch/mm/kasan_init.c
> +++ b/arch/loongarch/mm/kasan_init.c
> @@ -152,6 +152,8 @@ static void __init kasan_pte_populate(pmd_t *pmdp, un=
signed long addr,
>                 phys_addr_t page_phys =3D early ?
>                                         __pa_symbol(kasan_early_shadow_pa=
ge)
>                                               : kasan_alloc_zeroed_page(n=
ode);
> +               if (!early)
> +                       kernel_pte_init(__va(page_phys));
>                 next =3D addr + PAGE_SIZE;
>                 set_pte(ptep, pfn_pte(__phys_to_pfn(page_phys), PAGE_KERN=
EL));
>         } while (ptep++, addr =3D next, addr !=3D end && __pte_none(early=
, ptep_get(ptep)));
> @@ -287,7 +289,7 @@ void __init kasan_init(void)
>                 set_pte(&kasan_early_shadow_pte[i],
>                         pfn_pte(__phys_to_pfn(__pa_symbol(kasan_early_sha=
dow_page)), PAGE_KERNEL_RO));
>
> -       memset(kasan_early_shadow_page, 0, PAGE_SIZE);
> +       kernel_pte_init(kasan_early_shadow_page);
>         csr_write64(__pa_symbol(swapper_pg_dir), LOONGARCH_CSR_PGDH);
>         local_flush_tlb_all();
>
> diff --git a/arch/loongarch/mm/pgtable.c b/arch/loongarch/mm/pgtable.c
> index eb6a29b491a7..228ffc1db0a3 100644
> --- a/arch/loongarch/mm/pgtable.c
> +++ b/arch/loongarch/mm/pgtable.c
> @@ -38,6 +38,28 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
>  }
>  EXPORT_SYMBOL_GPL(pgd_alloc);
>
> +void kernel_pte_init(void *addr)
> +{
> +       unsigned long *p, *end;
> +       unsigned long entry;
> +
> +       entry =3D (unsigned long)_PAGE_GLOBAL;
> +       p =3D (unsigned long *)addr;
> +       end =3D p + PTRS_PER_PTE;
> +
> +       do {
> +               p[0] =3D entry;
> +               p[1] =3D entry;
> +               p[2] =3D entry;
> +               p[3] =3D entry;
> +               p[4] =3D entry;
> +               p +=3D 8;
> +               p[-3] =3D entry;
> +               p[-2] =3D entry;
> +               p[-1] =3D entry;
> +       } while (p !=3D end);
> +}
> +
>  void pgd_init(void *addr)
>  {
>         unsigned long *p, *end;
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index ecf63d2b0582..6909fe059a2c 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3818,6 +3818,7 @@ void *sparse_buffer_alloc(unsigned long size);
>  struct page * __populate_section_memmap(unsigned long pfn,
>                 unsigned long nr_pages, int nid, struct vmem_altmap *altm=
ap,
>                 struct dev_pagemap *pgmap);
> +void kernel_pte_init(void *addr);
>  void pmd_init(void *addr);
>  void pud_init(void *addr);
>  pgd_t *vmemmap_pgd_populate(unsigned long addr, int node);
> diff --git a/mm/kasan/init.c b/mm/kasan/init.c
> index 89895f38f722..ac607c306292 100644
> --- a/mm/kasan/init.c
> +++ b/mm/kasan/init.c
> @@ -106,6 +106,10 @@ static void __ref zero_pte_populate(pmd_t *pmd, unsi=
gned long addr,
>         }
>  }
>
> +void __weak __meminit kernel_pte_init(void *addr)
> +{
> +}
> +
>  static int __ref zero_pmd_populate(pud_t *pud, unsigned long addr,
>                                 unsigned long end)
>  {
> @@ -126,8 +130,10 @@ static int __ref zero_pmd_populate(pud_t *pud, unsig=
ned long addr,
>
>                         if (slab_is_available())
>                                 p =3D pte_alloc_one_kernel(&init_mm);
> -                       else
> +                       else {
>                                 p =3D early_alloc(PAGE_SIZE, NUMA_NO_NODE=
);
> +                               kernel_pte_init(p);
> +                       }
>                         if (!p)
>                                 return -ENOMEM;
>
> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> index edcc7a6b0f6f..c0388b2e959d 100644
> --- a/mm/sparse-vmemmap.c
> +++ b/mm/sparse-vmemmap.c
> @@ -184,6 +184,10 @@ static void * __meminit vmemmap_alloc_block_zero(uns=
igned long size, int node)
>         return p;
>  }
>
> +void __weak __meminit kernel_pte_init(void *addr)
> +{
> +}
> +
>  pmd_t * __meminit vmemmap_pmd_populate(pud_t *pud, unsigned long addr, i=
nt node)
>  {
>         pmd_t *pmd =3D pmd_offset(pud, addr);
> @@ -191,6 +195,7 @@ pmd_t * __meminit vmemmap_pmd_populate(pud_t *pud, un=
signed long addr, int node)
>                 void *p =3D vmemmap_alloc_block_zero(PAGE_SIZE, node);
>                 if (!p)
>                         return NULL;
> +               kernel_pte_init(p);
>                 pmd_populate_kernel(&init_mm, pmd, p);
>         }
>         return pmd;
> --
> 2.39.3
>

