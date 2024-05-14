Return-Path: <linux-kernel+bounces-179018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 883C58C5A8D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 19:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F0521F231D6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 17:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A201802B2;
	Tue, 14 May 2024 17:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="gf/90FHw"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88F62AD1C
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 17:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715708989; cv=none; b=Bov0owkPAxxzo41iOUzhHLZifKdzIRBTT3DF99cJJXsruJlwOjUlEyC78hIbjqtEmfTPYhK/Oe/yYc8PFhbEASDZWy+UG14DCuVymmEtE1za8CG0jF8fe6jUAC0A/MqMmwCUPdPd6RxazsTN6KnNos+NfRGaq7tfuHgLv9YvM9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715708989; c=relaxed/simple;
	bh=USSz2yh2NYlKLXMHWWM6qYV2oO6VvlT9yxTYbKX//Go=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ovXUOUiftvJd0o30Bb613BzoH6ZPOYzEUTYp+P2Yrca4L9WQFAMo9CukNfHguwkMpqCcI0HD7GusyKrSiDDLRJyBnRBAxx1VFJyQHePwEUheCMW8/a++pi7PXtzq4pIURvrzwDP5RYKEjubqafZZHMOLfZzajBdwESvmla8rsL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=gf/90FHw; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a5a2d0d8644so77113966b.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 10:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715708985; x=1716313785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TY0tfx5oaYLrx0tYYs3sB08jBexY0Rsr4FzYN9NEWiA=;
        b=gf/90FHwVKJ7yCVDVv0HKuFC06vTg2UamYMrZ5dXgV3AV82Vg1k92JbCktneTnrCvq
         pMkAzYgd3LGbKVVSpoCJK5jss/p7yxPSV1jGQup0f7Pltyhm/MyTeztEcY8OTZhFu2Rw
         iAgAzr5m7G5WhdxrLIcgodBXdABYLUoQGaNNRk9lrM00oM+MXGVvQAu63l7y1nXjy6UM
         q0o/aeqTqFyoOcU4/FMg2M25rdgA1dW3dVbZ/SUHDrEQ1HbMpnnWMu0n5cnAibMpMBmJ
         u1/AoZCw1GjvxXZKCyhwBnpalVoKX4feKI005xpNMKQ8N0RFIg/o14ZPu8rulfH6Po3n
         NjbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715708985; x=1716313785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TY0tfx5oaYLrx0tYYs3sB08jBexY0Rsr4FzYN9NEWiA=;
        b=BdI3ZGs0GvdyPOLMsAuy9C9BqsnHRaA3gL28OMgGx4qsnP5DIWWD7BBvBAbc/ENImP
         5V/L0EXPH6pBLSqx05mkyWmhyISw9mK3CVu63JEULwrILGDe8wzj/7Sl0jXTRmJyhmtC
         PDb7+ghIbxpVMcOeV9bVcbtzmzNMywlZougn2PO+0+I8fiRI3FuSE4JA9idUaLqa+/wE
         iZhELnNBKnS/vTW67WcuiPFrsRjlfa7VnJAX+yjwI66UFj4wgQSCj/RNk7pVy1CrsGwm
         69nGavFyU7zS6DDMMMxDG3uyX+iuIraAzg4VDNEtlyuJh3nMELOCziV1sjG1vXWl0qrV
         02sA==
X-Forwarded-Encrypted: i=1; AJvYcCWOsXKAa8g1lXJkGyf7R3Y9yf+jLlBccIZp6ExZpPlyMnLCAAccXS+n0kyp1gphj16ucMyvgokQYIGe6d+mQM4zbLqgTkM5bWlfQTLB
X-Gm-Message-State: AOJu0Yw74zet4tTVZUXSh0haYGaoXlNApUvVqlR5gXeWPd1jyr0ZSzEZ
	pvbM9j27YZo0E5EQPVEKYFX+lqyCznQ87M+HQDwhfIZg2esslvFxDdQCbTM/l43sF/diUeOjLq1
	L7WENXqjuJKcn0WHciZmO7AcW2oZhs0iKvGC8yg==
X-Google-Smtp-Source: AGHT+IFg6npd6iD2j23oMq1V5Cn9b9652L/fy/5SUbmfC2mk/UjYsz6+j/RmnTO4+bQNIrS303JyyPb7kJb9Kle1ovg=
X-Received: by 2002:a17:906:3197:b0:a59:cf38:5339 with SMTP id
 a640c23a62f3a-a5a2d55a6e6mr962266966b.6.1715708985105; Tue, 14 May 2024
 10:49:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514140446.538622-1-bjorn@kernel.org> <20240514140446.538622-5-bjorn@kernel.org>
In-Reply-To: <20240514140446.538622-5-bjorn@kernel.org>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Tue, 14 May 2024 19:49:33 +0200
Message-ID: <CAHVXubh8VpOmFqXrAN+G_Om-+6VjfeEyTRAFp8EWae3mFgjB=Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] riscv: mm: Add memory hotplugging support
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Albert Ou <aou@eecs.berkeley.edu>, David Hildenbrand <david@redhat.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	linux-riscv@lists.infradead.org, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Andrew Bresticker <abrestic@rivosinc.com>, 
	Chethan Seshadri <Chethan.Seshadri@catalinasystems.io>, Lorenzo Stoakes <lstoakes@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, Santosh Mamila <santosh.mamila@catalinasystems.io>, 
	Sivakumar Munnangi <siva.munnangi@catalinasystems.io>, Sunil V L <sunilvl@ventanamicro.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 4:05=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel=
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
>  arch/riscv/mm/init.c | 242 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 242 insertions(+)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 6f72b0b2b854..7f0b921a3d3a 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -1493,3 +1493,245 @@ void __init pgtable_cache_init(void)
>         }
>  }
>  #endif
> +
> +#ifdef CONFIG_MEMORY_HOTPLUG
> +static void __meminit free_pte_table(pte_t *pte_start, pmd_t *pmd)
> +{
> +       pte_t *pte;
> +       int i;
> +
> +       for (i =3D 0; i < PTRS_PER_PTE; i++) {
> +               pte =3D pte_start + i;
> +               if (!pte_none(*pte))
> +                       return;
> +       }
> +
> +       free_pages((unsigned long)page_address(pmd_page(*pmd)), 0);
> +       pmd_clear(pmd);
> +}
> +
> +static void __meminit free_pmd_table(pmd_t *pmd_start, pud_t *pud)
> +{
> +       pmd_t *pmd;
> +       int i;
> +
> +       for (i =3D 0; i < PTRS_PER_PMD; i++) {
> +               pmd =3D pmd_start + i;
> +               if (!pmd_none(*pmd))
> +                       return;
> +       }
> +
> +       free_pages((unsigned long)page_address(pud_page(*pud)), 0);
> +       pud_clear(pud);
> +}
> +
> +static void __meminit free_pud_table(pud_t *pud_start, p4d_t *p4d)
> +{
> +       pud_t *pud;
> +       int i;
> +
> +       for (i =3D 0; i < PTRS_PER_PUD; i++) {
> +               pud =3D pud_start + i;
> +               if (!pud_none(*pud))
> +                       return;
> +       }
> +
> +       free_pages((unsigned long)page_address(p4d_page(*p4d)), 0);
> +       p4d_clear(p4d);
> +}
> +
> +static void __meminit free_vmemmap_storage(struct page *page, size_t siz=
e,
> +                                          struct vmem_altmap *altmap)
> +{
> +       if (altmap)
> +               vmem_altmap_free(altmap, size >> PAGE_SHIFT);
> +       else
> +               free_pages((unsigned long)page_address(page), get_order(s=
ize));
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
> +               pte =3D READ_ONCE(*ptep);
> +
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
> +               pmd =3D READ_ONCE(*pmdp);
> +
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
> +               pud =3D READ_ONCE(*pudp);
> +
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
> +               p4d =3D READ_ONCE(*p4dp);
> +
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
> +       int ret;
> +
> +       create_linear_mapping_range(start, start + size, 0, &params->pgpr=
ot);
> +       flush_tlb_all();
> +       ret =3D __add_pages(nid, start >> PAGE_SHIFT, size >> PAGE_SHIFT,=
 params);
> +       if (ret) {
> +               remove_linear_mapping(start, size);
> +               return ret;
> +       }
> +

You need to flush the TLB here too since __add_pages() populates the
page table with the new vmemmap mapping (only because riscv allows to
cache invalid entries, I'll adapt this in my next version of Svvptc
support).

> +       max_pfn =3D PFN_UP(start + size);
> +       max_low_pfn =3D max_pfn;
> +       return 0;
> +}
> +
> +void __ref arch_remove_memory(u64 start, u64 size, struct vmem_altmap *a=
ltmap)
> +{
> +       __remove_pages(start >> PAGE_SHIFT, size >> PAGE_SHIFT, altmap);
> +       remove_linear_mapping(start, size);

You need to flush the TLB here too.

> +}
> +
> +#ifdef CONFIG_SPARSEMEM_VMEMMAP
> +void __ref vmemmap_free(unsigned long start, unsigned long end, struct v=
mem_altmap *altmap)
> +{
> +       remove_pgd_mapping(start, end, true, altmap);
> +}
> +#endif /* CONFIG_SPARSEMEM_VMEMMAP */
> +#endif /* CONFIG_MEMORY_HOTPLUG */
> --
> 2.40.1
>

