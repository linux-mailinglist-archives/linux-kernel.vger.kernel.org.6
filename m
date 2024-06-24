Return-Path: <linux-kernel+bounces-226963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D22A491467A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 11:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 879BD282150
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 09:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E4D131BDD;
	Mon, 24 Jun 2024 09:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="R91uzJJ+"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6EF256E
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 09:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719221554; cv=none; b=mOb/BB5ovBf0ndgTcIwGdYcEyyaSXwXE97kC1mYaZnt8mFvJUf4EHOCKTdWNmKb05lqpalvWW/yKP/aVdjmxd8gmYnt/z275EvQZFhpi5193vRVwsJ6VO+gRi3dC8k7Jg/RgdaQcrCCjipG1OAE5F5six5qRzy0INmoeTTAWRKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719221554; c=relaxed/simple;
	bh=cpjpeDG3Oi/Xaxnm8EApXaEf/9L0dpizxBqg7otXitA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Raji2P6/TCv9aMbzNkgbV+mjg+QVUa9X5fmj1kC1C1rsQi3AsDU34kx9Q9mTZUscqVotf/b6aA3474WwKZjWfbv1hxwZONfsX7O46bypU03mNeReD/XjidUUWoMv9eEs48nE19qYwDD1K9UYG/X0hUQc5jfTEE3W4KeHsSGHaLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=R91uzJJ+; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57d1d614049so4523648a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 02:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719221551; x=1719826351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ylP9hhefoKdB6RU1zDeF3Hm4NcbTZcv1z2JYeHMCiz0=;
        b=R91uzJJ+2u1BBwftt4T47R1zlNraZj9gfg9S2iZu5XUAddGVGclX1UnppKY2oFH+0C
         C5+bSEi+moQLYHs0tdUE9jHhRPieibHLleHPKVfTQLu7AUeqV3Q/VNiY3YJd0u08ll4k
         WyfJsgcJK8Ucbf/weEGhZFkM24Cn1n7Rex5DlLr92MvTeiNei4+4sOBlDv3u3wmn/ANe
         k396nrPxB+VRYDrxu0iQHR8tCQBd8s2xhtOqyB+ib2iJA2PzpYxXnfOI5vzHsDVTfNdX
         qf+ENpLNehv66Qn0Ko83hAJn3e3KaoV0j3zKTp8eR4J0jSjL0vDwWNHbXfhHXvONZV/5
         Xgbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719221551; x=1719826351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ylP9hhefoKdB6RU1zDeF3Hm4NcbTZcv1z2JYeHMCiz0=;
        b=js9je19H/8EaOOS06vN/LIVnxVoDwjQd3F/Rz+Gj02J9pXwan7PJH5Ys5Z+IOpcOk+
         2uo31KS/4Kg8WZSZmqyL1lNu/ou5gAFhQZRExEK4lyDkbNwUDv9IGiqZ01wZoJTyF/oC
         dN/3hVpnLqJbnv3V4+4BFo8tgDHq4IisECnWBAV5Aip0AfjC/dfLBuhKDI/hh9NO8/pl
         TXRAsUzeXqdZ6Anh7YnC0W1p2Kvom28rz5I9Ug5oclc4ZTx+zS9cXOIlF0D9dYAQVeeN
         HZ0UTsBXjPuMnvH68oNPz/1PTluCVnYLScnCFh8UNJaOaDHarfUPhb95E+i4eVJ5PpC9
         pTDA==
X-Forwarded-Encrypted: i=1; AJvYcCVFwfsHzkfMwHiAgxLzFxmbtQPBY6qlevNK6hACVSMAtzXxsYFvmdSc6wjWvDgmE/z1rI6+Gk6gEwj0MWNK7DaPiMTOLOSBiqSZTKDK
X-Gm-Message-State: AOJu0Yy4+hllGzDr/YcDcrGktkHGYlLQ4GMB0wbx1BHmJKxCKV+/dzjK
	MFFbXNQ+gZBUk5EfqOz6UmDqEl3oxQZfz92RSikFr9jSxW64OP8MquIBrxbDnml8SIi/mu1BBpT
	Pn+oB8Y12njI3oEXVagtP2oz8JgZuwmq1bX4MLg==
X-Google-Smtp-Source: AGHT+IH/JL/qIpbyxq7hJOXhkGJPFyzywZEiucA6mKuy0VX/4fU0m7YLa6uwthvClRi+aVrun5e0UNcYS0P4SB4gud0=
X-Received: by 2002:a50:d483:0:b0:57a:33a5:9b71 with SMTP id
 4fb4d7f45d1cf-57d4bdbe8famr3538087a12.33.1719221550794; Mon, 24 Jun 2024
 02:32:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605114100.315918-1-bjorn@kernel.org> <20240605114100.315918-7-bjorn@kernel.org>
In-Reply-To: <20240605114100.315918-7-bjorn@kernel.org>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Mon, 24 Jun 2024 11:32:19 +0200
Message-ID: <CAHVXubhO+Ew7dsykW63RcpCe6er2DohwUt51ZGxamdCc=EVi7w@mail.gmail.com>
Subject: Re: [PATCH v4 06/11] riscv: mm: Add memory hotplugging support
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Albert Ou <aou@eecs.berkeley.edu>, David Hildenbrand <david@redhat.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	linux-riscv@lists.infradead.org, Oscar Salvador <osalvador@suse.de>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Andrew Bresticker <abrestic@rivosinc.com>, 
	Chethan Seshadri <Chethan.Seshadri@catalinasystems.io>, Lorenzo Stoakes <lstoakes@gmail.com>, 
	Santosh Mamila <santosh.mamila@catalinasystems.io>, 
	Sivakumar Munnangi <siva.munnangi@catalinasystems.io>, Sunil V L <sunilvl@ventanamicro.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 1:41=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.=
org> wrote:
>
> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>
> For an architecture to support memory hotplugging, a couple of
> callbacks needs to be implemented:
>
>  arch_add_memory()
>   This callback is responsible for adding the physical memory into the
>   direct map, and call into the memory hotplugging generic code via
>   __add_pages() that adds the corresponding struct page entries, and
>   updates the vmemmap mapping.
>
>  arch_remove_memory()
>   This is the inverse of the callback above.
>
>  vmemmap_free()
>   This function tears down the vmemmap mappings (if
>   CONFIG_SPARSEMEM_VMEMMAP is enabled), and also deallocates the
>   backing vmemmap pages. Note that for persistent memory, an
>   alternative allocator for the backing pages can be used; The
>   vmem_altmap. This means that when the backing pages are cleared,
>   extra care is needed so that the correct deallocation method is
>   used.
>
>  arch_get_mappable_range()
>   This functions returns the PA range that the direct map can map.
>   Used by the MHP internals for sanity checks.
>
> The page table unmap/teardown functions are heavily based on code from
> the x86 tree. The same remove_pgd_mapping() function is used in both
> vmemmap_free() and arch_remove_memory(), but in the latter function
> the backing pages are not removed.
>
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> ---
>  arch/riscv/mm/init.c | 267 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 267 insertions(+)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 1f7e7c223bec..bfa2dea95354 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -1534,3 +1534,270 @@ struct execmem_info __init *execmem_arch_setup(vo=
id)
>  }
>  #endif /* CONFIG_MMU */
>  #endif /* CONFIG_EXECMEM */
> +
> +#ifdef CONFIG_MEMORY_HOTPLUG
> +static void __meminit free_pte_table(pte_t *pte_start, pmd_t *pmd)
> +{
> +       struct page *page =3D pmd_page(*pmd);
> +       struct ptdesc *ptdesc =3D page_ptdesc(page);
> +       pte_t *pte;
> +       int i;
> +
> +       for (i =3D 0; i < PTRS_PER_PTE; i++) {
> +               pte =3D pte_start + i;
> +               if (!pte_none(*pte))
> +                       return;
> +       }
> +
> +       pagetable_pte_dtor(ptdesc);
> +       if (PageReserved(page))
> +               free_reserved_page(page);
> +       else
> +               pagetable_free(ptdesc);
> +       pmd_clear(pmd);
> +}
> +
> +static void __meminit free_pmd_table(pmd_t *pmd_start, pud_t *pud)
> +{
> +       struct page *page =3D pud_page(*pud);
> +       struct ptdesc *ptdesc =3D page_ptdesc(page);
> +       pmd_t *pmd;
> +       int i;
> +
> +       for (i =3D 0; i < PTRS_PER_PMD; i++) {
> +               pmd =3D pmd_start + i;
> +               if (!pmd_none(*pmd))
> +                       return;
> +       }
> +
> +       pagetable_pmd_dtor(ptdesc);
> +       if (PageReserved(page))
> +               free_reserved_page(page);
> +       else
> +               pagetable_free(ptdesc);
> +       pud_clear(pud);
> +}
> +
> +static void __meminit free_pud_table(pud_t *pud_start, p4d_t *p4d)
> +{
> +       struct page *page =3D p4d_page(*p4d);
> +       pud_t *pud;
> +       int i;
> +
> +       for (i =3D 0; i < PTRS_PER_PUD; i++) {
> +               pud =3D pud_start + i;
> +               if (!pud_none(*pud))
> +                       return;
> +       }
> +
> +       if (PageReserved(page))
> +               free_reserved_page(page);
> +       else
> +               free_pages((unsigned long)page_address(page), 0);
> +       p4d_clear(p4d);
> +}
> +
> +static void __meminit free_vmemmap_storage(struct page *page, size_t siz=
e,
> +                                          struct vmem_altmap *altmap)
> +{
> +       int order =3D get_order(size);
> +
> +       if (altmap) {
> +               vmem_altmap_free(altmap, size >> PAGE_SHIFT);
> +               return;
> +       }
> +
> +       if (PageReserved(page)) {
> +               unsigned int nr_pages =3D 1 << order;
> +
> +               while (nr_pages--)
> +                       free_reserved_page(page++);
> +               return;
> +       }
> +
> +       free_pages((unsigned long)page_address(page), order);
> +}
> +
> +static void __meminit remove_pte_mapping(pte_t *pte_base, unsigned long =
addr, unsigned long end,
> +                                        bool is_vmemmap, struct vmem_alt=
map *altmap)
> +{
> +       unsigned long next;
> +       pte_t *ptep, pte;
> +
> +       for (; addr < end; addr =3D next) {
> +               next =3D (addr + PAGE_SIZE) & PAGE_MASK;
> +               if (next > end)
> +                       next =3D end;
> +
> +               ptep =3D pte_base + pte_index(addr);
> +               pte =3D ptep_get(ptep);
> +               if (!pte_present(*ptep))
> +                       continue;
> +
> +               pte_clear(&init_mm, addr, ptep);
> +               if (is_vmemmap)
> +                       free_vmemmap_storage(pte_page(pte), PAGE_SIZE, al=
tmap);
> +       }
> +}
> +
> +static void __meminit remove_pmd_mapping(pmd_t *pmd_base, unsigned long =
addr, unsigned long end,
> +                                        bool is_vmemmap, struct vmem_alt=
map *altmap)
> +{
> +       unsigned long next;
> +       pte_t *pte_base;
> +       pmd_t *pmdp, pmd;
> +
> +       for (; addr < end; addr =3D next) {
> +               next =3D pmd_addr_end(addr, end);
> +               pmdp =3D pmd_base + pmd_index(addr);
> +               pmd =3D pmdp_get(pmdp);
> +               if (!pmd_present(pmd))
> +                       continue;
> +
> +               if (pmd_leaf(pmd)) {
> +                       pmd_clear(pmdp);
> +                       if (is_vmemmap)
> +                               free_vmemmap_storage(pmd_page(pmd), PMD_S=
IZE, altmap);
> +                       continue;
> +               }
> +
> +               pte_base =3D (pte_t *)pmd_page_vaddr(*pmdp);
> +               remove_pte_mapping(pte_base, addr, next, is_vmemmap, altm=
ap);
> +               free_pte_table(pte_base, pmdp);
> +       }
> +}
> +
> +static void __meminit remove_pud_mapping(pud_t *pud_base, unsigned long =
addr, unsigned long end,
> +                                        bool is_vmemmap, struct vmem_alt=
map *altmap)
> +{
> +       unsigned long next;
> +       pud_t *pudp, pud;
> +       pmd_t *pmd_base;
> +
> +       for (; addr < end; addr =3D next) {
> +               next =3D pud_addr_end(addr, end);
> +               pudp =3D pud_base + pud_index(addr);
> +               pud =3D pudp_get(pudp);
> +               if (!pud_present(pud))
> +                       continue;
> +
> +               if (pud_leaf(pud)) {
> +                       if (pgtable_l4_enabled) {
> +                               pud_clear(pudp);
> +                               if (is_vmemmap)
> +                                       free_vmemmap_storage(pud_page(pud=
), PUD_SIZE, altmap);
> +                       }
> +                       continue;
> +               }
> +
> +               pmd_base =3D pmd_offset(pudp, 0);
> +               remove_pmd_mapping(pmd_base, addr, next, is_vmemmap, altm=
ap);
> +
> +               if (pgtable_l4_enabled)
> +                       free_pmd_table(pmd_base, pudp);
> +       }
> +}
> +
> +static void __meminit remove_p4d_mapping(p4d_t *p4d_base, unsigned long =
addr, unsigned long end,
> +                                        bool is_vmemmap, struct vmem_alt=
map *altmap)
> +{
> +       unsigned long next;
> +       p4d_t *p4dp, p4d;
> +       pud_t *pud_base;
> +
> +       for (; addr < end; addr =3D next) {
> +               next =3D p4d_addr_end(addr, end);
> +               p4dp =3D p4d_base + p4d_index(addr);
> +               p4d =3D p4dp_get(p4dp);
> +               if (!p4d_present(p4d))
> +                       continue;
> +
> +               if (p4d_leaf(p4d)) {
> +                       if (pgtable_l5_enabled) {
> +                               p4d_clear(p4dp);
> +                               if (is_vmemmap)
> +                                       free_vmemmap_storage(p4d_page(p4d=
), P4D_SIZE, altmap);
> +                       }
> +                       continue;
> +               }
> +
> +               pud_base =3D pud_offset(p4dp, 0);
> +               remove_pud_mapping(pud_base, addr, next, is_vmemmap, altm=
ap);
> +
> +               if (pgtable_l5_enabled)
> +                       free_pud_table(pud_base, p4dp);
> +       }
> +}
> +
> +static void __meminit remove_pgd_mapping(unsigned long va, unsigned long=
 end, bool is_vmemmap,
> +                                        struct vmem_altmap *altmap)
> +{
> +       unsigned long addr, next;
> +       p4d_t *p4d_base;
> +       pgd_t *pgd;
> +
> +       for (addr =3D va; addr < end; addr =3D next) {
> +               next =3D pgd_addr_end(addr, end);
> +               pgd =3D pgd_offset_k(addr);
> +
> +               if (!pgd_present(*pgd))
> +                       continue;
> +
> +               if (pgd_leaf(*pgd))
> +                       continue;
> +
> +               p4d_base =3D p4d_offset(pgd, 0);
> +               remove_p4d_mapping(p4d_base, addr, next, is_vmemmap, altm=
ap);
> +       }
> +
> +       flush_tlb_all();
> +}
> +
> +static void __meminit remove_linear_mapping(phys_addr_t start, u64 size)
> +{
> +       unsigned long va =3D (unsigned long)__va(start);
> +       unsigned long end =3D (unsigned long)__va(start + size);
> +
> +       remove_pgd_mapping(va, end, false, NULL);
> +}
> +
> +struct range arch_get_mappable_range(void)
> +{
> +       struct range mhp_range;
> +
> +       mhp_range.start =3D __pa(PAGE_OFFSET);
> +       mhp_range.end =3D __pa(PAGE_END - 1);
> +       return mhp_range;
> +}
> +
> +int __ref arch_add_memory(int nid, u64 start, u64 size, struct mhp_param=
s *params)
> +{
> +       int ret =3D 0;
> +
> +       create_linear_mapping_range(start, start + size, 0, &params->pgpr=
ot);
> +       ret =3D __add_pages(nid, start >> PAGE_SHIFT, size >> PAGE_SHIFT,=
 params);
> +       if (ret) {
> +               remove_linear_mapping(start, size);
> +               goto out;
> +       }
> +
> +       max_pfn =3D PFN_UP(start + size);
> +       max_low_pfn =3D max_pfn;
> +
> + out:
> +       flush_tlb_all();
> +       return ret;
> +}
> +
> +void __ref arch_remove_memory(u64 start, u64 size, struct vmem_altmap *a=
ltmap)
> +{
> +       __remove_pages(start >> PAGE_SHIFT, size >> PAGE_SHIFT, altmap);
> +       remove_linear_mapping(start, size);
> +       flush_tlb_all();
> +}
> +
> +void __ref vmemmap_free(unsigned long start, unsigned long end, struct v=
mem_altmap *altmap)
> +{
> +       remove_pgd_mapping(start, end, true, altmap);
> +}
> +#endif /* CONFIG_MEMORY_HOTPLUG */
> --
> 2.43.0
>

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex

