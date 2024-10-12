Return-Path: <linux-kernel+bounces-362021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC2E99B008
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 04:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 265E1B228A8
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 02:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F0210940;
	Sat, 12 Oct 2024 02:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iu0MTPvZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE1CD531
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 02:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728699366; cv=none; b=puBA5q0d/XEiTfdSXWdgvInK64EVqhmxOUP3PStj+NOF8I0fV+iuTRBYFFMVvFmRhQnBzSYbYV0OXY5Iy4xZNJZnWJNHuUYlkgxhrzXTDfV6ikcifp139KOc1NddfyJV7pBJvcf2RcEx0f0w1pP6PmbBmX9NDy6xSLkCj288xa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728699366; c=relaxed/simple;
	bh=ipLevwVho6xfPxzQepi7i+HFT0CrMqTtqbhSK3Ab2sI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GxibI/VS9PI0JKGZVsOci1pZyB24VyyhnUkLFvgkxoGAU3Kcj0jo2PFK6fKniKJym1ENq1vMlyVHWULfVE72K2TgpmqC63iDAK1y24dkOMZ9fmw5in6vyd0gcRCm5hsalKVDVdd7F3Ppe/zG8WDFTUrkpyQ9363f8kC3sDdS0mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iu0MTPvZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B35DC4CED1
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 02:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728699366;
	bh=ipLevwVho6xfPxzQepi7i+HFT0CrMqTtqbhSK3Ab2sI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iu0MTPvZfNsm2olrMaH7g7ncBPxOpgvKVWTUHa9ZaOsWhCaMRZPvmFvyxqE1ngrLT
	 z3HyjRz8oXXB6Hncjyj96HSy3c47VHRx0gplYI2Kg2jawPkOl2/RPvt5+VSXjtr91i
	 RfJhK4XO5nzd3wSrqfeOYg6H0j0pTyu+MVg0d9h/bpLcHDzkGauGPGOZJ1XbBDSqho
	 mrgyEjUCd5hWLPBl88JywTqW24EuhDOi/Bqws+LiHecWXsXrPxdH/oSyloXTpEvPCc
	 j4N6W4QfK8O1RlvtSRRDp191T++Kr8n6F+MOiZPVwKp+lqi0hkCjy4/dV1UJi0Qd0B
	 58y+hf0Uj5g+g==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9960371b62so293311166b.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 19:16:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUXnABo2AEU9UviObUlwpk7Axa1+gT3IE/Mfy48/VuxtpX1IVeRNqPadgNmm29cvTDu/SufCNYr7vLyIF8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5XAmtUs+UUIocmhEo1goa/1Y9tCv93hOX20V/b5293oUBJ9pB
	VDj8FaFCD5EAUDbhqlkDvQOjd06YewzZr/Szp/5ax/wOCgCrjIP1UYviTkod41p1eTiMnmVkR/6
	r9ev6SM6D1wUnEMK5f4MCdB+/o88=
X-Google-Smtp-Source: AGHT+IFj/Gftu3mO/DwZxwaVooTnN2cbu/tWKknPFAqTcJHrOb/oJCsQc9HNnK+icjEcA28LkqkuHkNJsQl4A8usx9Q=
X-Received: by 2002:a17:907:368d:b0:a99:5466:2556 with SMTP id
 a640c23a62f3a-a99b966b636mr417240566b.61.1728699364644; Fri, 11 Oct 2024
 19:16:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010035048.3422527-1-maobibo@loongson.cn> <20241010035048.3422527-2-maobibo@loongson.cn>
In-Reply-To: <20241010035048.3422527-2-maobibo@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 12 Oct 2024 10:15:51 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4q_P1HL74k5k+er9QEvZjMaa2kTYz8N+7aJ1vDii=GKQ@mail.gmail.com>
Message-ID: <CAAhV-H4q_P1HL74k5k+er9QEvZjMaa2kTYz8N+7aJ1vDii=GKQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] LoongArch: Set pte entry with PAGE_GLOBAL for kernel space
To: Bibo Mao <maobibo@loongson.cn>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Barry Song <baohua@kernel.org>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Bibo,

On Thu, Oct 10, 2024 at 11:50=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> wro=
te:
>
> Unlike general architectures, there are two pages for one TLB entry
> on LoongArch system. For kernel space, it requires both two pte
> entries with PAGE_GLOBAL set, else HW treats it as non-global tlb,
> there will be potential problems if tlb entry for kernel space is
> not global. Such as fail to flush kernel tlb with function
> local_flush_tlb_kernel_range() which only flush tlb with global bit.
>
> Here function kernel_pte_init() is added, it can be used to init
> pte table when it is created, so the default inital pte is
> PAGE_GLOBAL rather than zero at beginning.
I think kernel_pte_init() is also needed in zero_pmd_populate() in
mm/kasan/init.c. And moreover, the second patch should be squashed in
this one because they should be as a whole. Though the second one
touches the common code, I can merge it with mm maintainer's acked-by.


Huacai

>
> Kernel space areas includes fixmap, percpu, vmalloc and kasan areas
> set default pte entry with PAGE_GLOBAL set.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  arch/loongarch/include/asm/pgalloc.h | 13 +++++++++++++
>  arch/loongarch/include/asm/pgtable.h |  1 +
>  arch/loongarch/mm/init.c             |  4 +++-
>  arch/loongarch/mm/kasan_init.c       |  4 +++-
>  arch/loongarch/mm/pgtable.c          | 22 ++++++++++++++++++++++
>  5 files changed, 42 insertions(+), 2 deletions(-)
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
> --
> 2.39.3
>

