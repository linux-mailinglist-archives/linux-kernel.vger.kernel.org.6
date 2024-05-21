Return-Path: <linux-kernel+bounces-185076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 098428CB034
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 16:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A8F0282012
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 14:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF467FBB7;
	Tue, 21 May 2024 14:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dh39Fdl1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00A57FBA3
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 14:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716301130; cv=none; b=O+vS6V/K0/J5SkW9jikEAsaT6VJVSgT8W3YjzL7BS3OtJGMBEPkC1BvZ9thmSIc3NR5CypT99AYgFwQbjlpnL5T22ckrx/UsqVKkph/by79HbIizjRBZbV1FJmYtPCYbF3pN70AOTeglzATh4qs4kQc76puMA3lMU1FdfurjU4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716301130; c=relaxed/simple;
	bh=tP7EG5a9H+6WQUK7/ZhP8N575ilx5NZpoxhPWsiIALA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KfsMIJDxXSirip5DPfC+tzifbkoGG1kaL8HM08BcMf68UVzaOyn0cx3M5sYZl0kCM4Rp/+znpIj3l+9EgjtQRYp8ZXbG+e0rzuxNYotekSyIQ1XenkNCT5umgU0yScwuqG2zYSxNLi7Pjz7PYz4cPuxA5k6eFCEBTzqUweNVLhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dh39Fdl1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 203FCC2BD11;
	Tue, 21 May 2024 14:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716301129;
	bh=tP7EG5a9H+6WQUK7/ZhP8N575ilx5NZpoxhPWsiIALA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Dh39Fdl1R6PctLN2xxAMhZZmzV1xeFmZv6jfhquWSpe6BUz1Unxn7w6GJWpQE6MXU
	 aQdXjmZeX0PRXfyv2mZj6vl5wivtAjUy7mfT7qUG5ycsi+/mVwUcN4s8MUCXn0teyi
	 vxI/lJtbRV1dZMsEQq+u++F3tNHEIumzcHrwC//+l/xX7P2O4p+vrDoIlUUpta01S+
	 CVaKDR1e8ozil0gg1jHkc4TZ2ji/jntKWe7atmY/hLZw8BfwTZCm9Mu+wVSqQ6Hc+3
	 GSUI+sIVyZhZ/iEd992Sfc+zUnalUN0RU0DS1VXc6443jCOyCX/9xJls8NlPp5EmYQ
	 9Ma41oadmcpYA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>, David Hildenbrand <david@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, linux-riscv@lists.infradead.org, Oscar
 Salvador <osalvador@suse.de>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>, Andrew
 Bresticker <abrestic@rivosinc.com>, Chethan Seshadri
 <Chethan.Seshadri@catalinasystems.io>, Lorenzo Stoakes
 <lstoakes@gmail.com>, Santosh Mamila <santosh.mamila@catalinasystems.io>,
 Sivakumar Munnangi <siva.munnangi@catalinasystems.io>, Sunil V L
 <sunilvl@ventanamicro.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v3 5/9] riscv: mm: Add memory hotplugging support
In-Reply-To: <CAHVXubi_yQ6L5g4dODoHMNvgO6kHy8i6YskRXSPoTU4N2P8rUA@mail.gmail.com>
References: <20240521114830.841660-1-bjorn@kernel.org>
 <20240521114830.841660-6-bjorn@kernel.org>
 <CAHVXubi_yQ6L5g4dODoHMNvgO6kHy8i6YskRXSPoTU4N2P8rUA@mail.gmail.com>
Date: Tue, 21 May 2024 16:18:46 +0200
Message-ID: <87jzjndz95.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexandre Ghiti <alexghiti@rivosinc.com> writes:

> On Tue, May 21, 2024 at 1:49=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kern=
el.org> wrote:
>>
>> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>>
>> For an architecture to support memory hotplugging, a couple of
>> callbacks needs to be implemented:
>>
>>  arch_add_memory()
>>   This callback is responsible for adding the physical memory into the
>>   direct map, and call into the memory hotplugging generic code via
>>   __add_pages() that adds the corresponding struct page entries, and
>>   updates the vmemmap mapping.
>>
>>  arch_remove_memory()
>>   This is the inverse of the callback above.
>>
>>  vmemmap_free()
>>   This function tears down the vmemmap mappings (if
>>   CONFIG_SPARSEMEM_VMEMMAP is enabled), and also deallocates the
>>   backing vmemmap pages. Note that for persistent memory, an
>>   alternative allocator for the backing pages can be used; The
>>   vmem_altmap. This means that when the backing pages are cleared,
>>   extra care is needed so that the correct deallocation method is
>>   used.
>>
>>  arch_get_mappable_range()
>>   This functions returns the PA range that the direct map can map.
>>   Used by the MHP internals for sanity checks.
>>
>> The page table unmap/teardown functions are heavily based on code from
>> the x86 tree. The same remove_pgd_mapping() function is used in both
>> vmemmap_free() and arch_remove_memory(), but in the latter function
>> the backing pages are not removed.
>>
>> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>> ---
>>  arch/riscv/mm/init.c | 261 +++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 261 insertions(+)
>>
>> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>> index 6f72b0b2b854..6693b742bf2f 100644
>> --- a/arch/riscv/mm/init.c
>> +++ b/arch/riscv/mm/init.c
>> @@ -1493,3 +1493,264 @@ void __init pgtable_cache_init(void)
>>         }
>>  }
>>  #endif
>> +
>> +#ifdef CONFIG_MEMORY_HOTPLUG
>> +static void __meminit free_pagetable(struct page *page, int order)
>> +{
>> +       unsigned int nr_pages =3D 1 << order;
>> +
>> +       /*
>> +        * vmemmap/direct page tables can be reserved, if added at
>> +        * boot.
>> +        */
>> +       if (PageReserved(page)) {
>> +               __ClearPageReserved(page);
>
> What's the difference between __ClearPageReserved() and
> ClearPageReserved()? Because it seems like free_reserved_page() calls
> the latter already, so why would you need to call
> __ClearPageReserved() on the first page?

Indeed! x86 copy pasta (which uses bootmem info page that RV doesn't).

>> +               while (nr_pages--)
>> +                       free_reserved_page(page++);
>> +               return;
>> +       }
>> +
>> +       free_pages((unsigned long)page_address(page), order);
>> +}
>> +
>> +static void __meminit free_pte_table(pte_t *pte_start, pmd_t *pmd)
>> +{
>> +       pte_t *pte;
>> +       int i;
>> +
>> +       for (i =3D 0; i < PTRS_PER_PTE; i++) {
>> +               pte =3D pte_start + i;
>> +               if (!pte_none(*pte))
>> +                       return;
>> +       }
>> +
>> +       free_pagetable(pmd_page(*pmd), 0);
>> +       pmd_clear(pmd);
>> +}
>> +
>> +static void __meminit free_pmd_table(pmd_t *pmd_start, pud_t *pud)
>> +{
>> +       pmd_t *pmd;
>> +       int i;
>> +
>> +       for (i =3D 0; i < PTRS_PER_PMD; i++) {
>> +               pmd =3D pmd_start + i;
>> +               if (!pmd_none(*pmd))
>> +                       return;
>> +       }
>> +
>> +       free_pagetable(pud_page(*pud), 0);
>> +       pud_clear(pud);
>> +}
>> +
>> +static void __meminit free_pud_table(pud_t *pud_start, p4d_t *p4d)
>> +{
>> +       pud_t *pud;
>> +       int i;
>> +
>> +       for (i =3D 0; i < PTRS_PER_PUD; i++) {
>> +               pud =3D pud_start + i;
>> +               if (!pud_none(*pud))
>> +                       return;
>> +       }
>> +
>> +       free_pagetable(p4d_page(*p4d), 0);
>> +       p4d_clear(p4d);
>> +}
>> +
>> +static void __meminit free_vmemmap_storage(struct page *page, size_t si=
ze,
>> +                                          struct vmem_altmap *altmap)
>> +{
>> +       if (altmap)
>> +               vmem_altmap_free(altmap, size >> PAGE_SHIFT);
>> +       else
>> +               free_pagetable(page, get_order(size));
>> +}
>> +
>> +static void __meminit remove_pte_mapping(pte_t *pte_base, unsigned long=
 addr, unsigned long end,
>> +                                        bool is_vmemmap, struct vmem_al=
tmap *altmap)
>> +{
>> +       unsigned long next;
>> +       pte_t *ptep, pte;
>> +
>> +       for (; addr < end; addr =3D next) {
>> +               next =3D (addr + PAGE_SIZE) & PAGE_MASK;
>
> Nit: use ALIGN() instead.
>
>> +               if (next > end)
>> +                       next =3D end;
>> +
>> +               ptep =3D pte_base + pte_index(addr);
>> +               pte =3D READ_ONCE(*ptep);
>
> Nit: Use ptep_get()
>
>> +
>> +               if (!pte_present(*ptep))
>> +                       continue;
>> +
>> +               pte_clear(&init_mm, addr, ptep);
>> +               if (is_vmemmap)
>> +                       free_vmemmap_storage(pte_page(pte), PAGE_SIZE, a=
ltmap);
>> +       }
>> +}
>> +
>> +static void __meminit remove_pmd_mapping(pmd_t *pmd_base, unsigned long=
 addr, unsigned long end,
>> +                                        bool is_vmemmap, struct vmem_al=
tmap *altmap)
>> +{
>> +       unsigned long next;
>> +       pte_t *pte_base;
>> +       pmd_t *pmdp, pmd;
>> +
>> +       for (; addr < end; addr =3D next) {
>> +               next =3D pmd_addr_end(addr, end);
>> +               pmdp =3D pmd_base + pmd_index(addr);
>> +               pmd =3D READ_ONCE(*pmdp);
>
> Nit: Use pmdp_get()
>
>> +
>> +               if (!pmd_present(pmd))
>> +                       continue;
>> +
>> +               if (pmd_leaf(pmd)) {
>> +                       pmd_clear(pmdp);
>> +                       if (is_vmemmap)
>> +                               free_vmemmap_storage(pmd_page(pmd), PMD_=
SIZE, altmap);
>> +                       continue;
>> +               }
>> +
>> +               pte_base =3D (pte_t *)pmd_page_vaddr(*pmdp);
>> +               remove_pte_mapping(pte_base, addr, next, is_vmemmap, alt=
map);
>> +               free_pte_table(pte_base, pmdp);
>> +       }
>> +}
>> +
>> +static void __meminit remove_pud_mapping(pud_t *pud_base, unsigned long=
 addr, unsigned long end,
>> +                                        bool is_vmemmap, struct vmem_al=
tmap *altmap)
>> +{
>> +       unsigned long next;
>> +       pud_t *pudp, pud;
>> +       pmd_t *pmd_base;
>> +
>> +       for (; addr < end; addr =3D next) {
>> +               next =3D pud_addr_end(addr, end);
>> +               pudp =3D pud_base + pud_index(addr);
>> +               pud =3D READ_ONCE(*pudp);
>
> Nit: Use pudp_get()
>
>> +
>> +               if (!pud_present(pud))
>> +                       continue;
>> +
>> +               if (pud_leaf(pud)) {
>> +                       if (pgtable_l4_enabled) {
>> +                               pud_clear(pudp);
>> +                               if (is_vmemmap)
>> +                                       free_vmemmap_storage(pud_page(pu=
d), PUD_SIZE, altmap);
>> +                       }
>> +                       continue;
>> +               }
>> +
>> +               pmd_base =3D pmd_offset(pudp, 0);
>> +               remove_pmd_mapping(pmd_base, addr, next, is_vmemmap, alt=
map);
>> +
>> +               if (pgtable_l4_enabled)
>> +                       free_pmd_table(pmd_base, pudp);
>> +       }
>> +}
>> +
>> +static void __meminit remove_p4d_mapping(p4d_t *p4d_base, unsigned long=
 addr, unsigned long end,
>> +                                        bool is_vmemmap, struct vmem_al=
tmap *altmap)
>> +{
>> +       unsigned long next;
>> +       p4d_t *p4dp, p4d;
>> +       pud_t *pud_base;
>> +
>> +       for (; addr < end; addr =3D next) {
>> +               next =3D p4d_addr_end(addr, end);
>> +               p4dp =3D p4d_base + p4d_index(addr);
>> +               p4d =3D READ_ONCE(*p4dp);
>
> Nit: Use p4dp_get()

..and I'll make sure to address these nits as well.


Thanks!
Bj=C3=B6rn

