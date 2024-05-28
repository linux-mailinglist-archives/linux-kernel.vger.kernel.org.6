Return-Path: <linux-kernel+bounces-191901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 471498D15D9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 10:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 692131C21A14
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 08:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B1513AA32;
	Tue, 28 May 2024 08:07:30 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABF613A25E
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 08:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716883650; cv=none; b=E1at/bv9SqDQwJ9H03WG9SAzYZoieAYf4d3G46BIPSzqXUoHpVYRTh/E6OX46w8mHKyM+QMPg+wlcgDzYqY7c+0WXn3e+TRMCdez96VKTT9EgN3P1Vbf9waeN2/QRFA4rBl8BFEzBqyf/4FsVVFpdTIITGgEo3AVZAV2stELbB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716883650; c=relaxed/simple;
	bh=I8F8ewdSYbaa5JmG69J80GiU/0yKMnjweiJ+yWiC858=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uPCg3zfmy1fRUC6qeQsqKhtLlfH3iH91N8DXWCYmCkJ2+l2+An3L8yNV6R0eW1aUZrrnjXbp2vtYM4myG1FhXLqxRX+oC22xAlQD8da5+thmZmJdCDA47hBdpH4Nxn6Ru6tukYs0WAyv1cN4FRedN7IowNdAlwbVQiYSCG457Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id D8D001C0002;
	Tue, 28 May 2024 08:07:21 +0000 (UTC)
Message-ID: <863092ed-2b04-46bb-8d99-5796346cef3a@ghiti.fr>
Date: Tue, 28 May 2024 10:07:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 0/9] Merge arm64/riscv hugetlbfs contpte support
Content-Language: en-US
To: Alexandre Ghiti <alexghiti@rivosinc.com>,
 Ryan Roberts <ryan.roberts@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Andrew Morton
 <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-mm@kvack.org
References: <20240508113419.18620-1-alexghiti@rivosinc.com>
 <6d37f914-d139-48ea-be63-c428ac767cc1@arm.com>
 <CAHVXubhmihZA50pdaek4=fx83ycdOyuYkRmVLPtZk59uKBoWPw@mail.gmail.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <CAHVXubhmihZA50pdaek4=fx83ycdOyuYkRmVLPtZk59uKBoWPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr

Hi Ryan,

On 12/05/2024 19:25, Alexandre Ghiti wrote:
> Hi Ryan,
>
> On Fri, May 10, 2024 at 3:49 PM Ryan Roberts <ryan.roberts@arm.com> wrote:
>> On 08/05/2024 12:34, Alexandre Ghiti wrote:
>>> This patchset intends to merge the contiguous ptes hugetlbfs implementation
>>> of arm64 and riscv.
>>>
>>> Both arm64 and riscv support the use of contiguous ptes to map pages that
>>> are larger than the default page table size, respectively called contpte
>>> and svnapot.
>>>
>>> The riscv implementation differs from the arm64's in that the LSBs of the
>>> pfn of a svnapot pte are used to store the size of the mapping, allowing
>>> for future sizes to be added (for now only 64KB is supported). That's an
>>> issue for the core mm code which expects to find the *real* pfn a pte points
>>> to. Patch 1 fixes that by always returning svnapot ptes with the real pfn
>>> and restores the size of the mapping when it is written to a page table.
>>>
>>> The following patches are just merges of the 2 different implementations
>>> that currently exist in arm64 and riscv which are very similar. It paves
>>> the way to the reuse of the recent contpte THP work by Ryan [1] to avoid
>>> reimplementing the same in riscv.
>> Hi Alexandre,
>>
>> I've skimmed through this series and the one that moves contpte. I can see there
>> is definitely value in sharing the implementation, and the rough shape of things
>> seems appropriate. I had some minor concerns about making it harder to implement
>> potential future arm64 errata workarounds but on reflection, most of the
>> now-shared code is really just wrapping the primitives that are still arch-specific.
>>
>> I'm going to need to spend proper time reviewing it to give detailed feedback,
>> but I'll be out on paternity leave for 3 weeks from end of Monday at the latest.
> Too bad, I expected to discuss that with you at LSF/MM...But congrats!
> Hope your wife is fine :)
>
>> So realistically I won't be able to do the detailed review until at least the
>> first week of June.
>>
>> Some high level thoughts:
>>
>>   - huge_ptep_* functions could be working on different sized huge ptes - arm64
>> supports contpte, pmd, contpmd and pud. Is keeping them in contpte.c
>> appropriate?
> Hmm indeed, I'll see what I can do.


So I took a look at that. It amounts to doing the same as what we do for 
THP contptes, ie having both contpte-aware and "normal" APIs. Let's take 
for example huge_ptep_get(), below is what I get. To me it's not that 
bad, so I'll implement this unless there is strong opposition.


diff --git a/arch/arm64/include/asm/pgtable.h 
b/arch/arm64/include/asm/pgtable.h
index f8efbc128446..869a9aae6c68 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1715,6 +1715,16 @@ static inline void clear_young_dirty_ptes(struct 
vm_area_struct *vma,
                 contpte_clear_young_dirty_ptes(vma, addr, ptep, nr, flags);
  }

+static inline pte_t huge_ptep_get(pte_t *ptep)
+{
+        pte_t orig_pte = __ptep_get(ptep);
+
+        if (!pte_present(orig_pte) || !pte_cont(orig_pte))
+                return orig_pte;
+
+        return contpte_huge_ptep_get(ptep);
+}
+
  #else /* CONFIG_ARM64_CONTPTE */

  #define ptep_get                               __ptep_get
@@ -1736,6 +1746,8 @@ static inline void clear_young_dirty_ptes(struct 
vm_area_struct *vma,
  #define ptep_set_access_flags __ptep_set_access_flags
  #define clear_young_dirty_ptes __clear_young_dirty_ptes

+#define huge_ptep_get                          __ptep_get
+
  #endif /* CONFIG_ARM64_CONTPTE */

  #endif /* !__ASSEMBLY__ */
diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 3f09ac73cce3..aa0ee3f02226 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -127,28 +127,6 @@ static inline int num_contig_ptes(unsigned long 
size, size_t *pgsize)
         return contig_ptes;
  }

-pte_t huge_ptep_get(pte_t *ptep)
-{
-       int ncontig, i;
-       size_t pgsize;
-       pte_t orig_pte = __ptep_get(ptep);
-
-       if (!pte_present(orig_pte) || !pte_cont(orig_pte))
-               return orig_pte;
-
-       ncontig = num_contig_ptes(page_size(pte_page(orig_pte)), &pgsize);
-       for (i = 0; i < ncontig; i++, ptep++) {
-               pte_t pte = __ptep_get(ptep);
-
-               if (pte_dirty(pte))
-                       orig_pte = pte_mkdirty(orig_pte);
-
-               if (pte_young(pte))
-                       orig_pte = pte_mkyoung(orig_pte);
-       }
-       return orig_pte;
-}
-
  /*
   * Changing some bits of contiguous entries requires us to follow a
   * Break-Before-Make approach, breaking the whole contiguous set
diff --git a/mm/contpte.c b/mm/contpte.c
new file mode 100644
index 000000000000..4e742cf00b6f
--- /dev/null
+++ b/mm/contpte.c
@@ -0,0 +1,17 @@
+pte_t contpte_huge_ptep_get(pte_t *ptep)
+{
+        int ncontig, i;
+        size_t pgsize;
+
+        ncontig = num_contig_ptes(page_size(pte_page(orig_pte)), &pgsize);
+        for (i = 0; i < ncontig; i++, ptep++) {
+                pte_t pte = __ptep_get(ptep);
+
+                if (pte_dirty(pte))
+                        orig_pte = pte_mkdirty(orig_pte);
+
+                if (pte_young(pte))
+                        orig_pte = pte_mkyoung(orig_pte);
+        }
+        return orig_pte;
+}

>
>> Perhaps it's better to keep huge_pte and contpte separate? Also, it
>> only works on arm64 because we can get away with calling the lower-level pte
>> functions even when the huge_pte is actually a contpmd/pmd/pud, because the
>> format is the same. That might present challenges to other arches if the format
>> is different?
> Yes, but I think that if that happens, we could get away with it by
> choosing the right function depending on the size of the mapping?
>
>>   - It might be easier to review if the arm64 stuff is first moved (without
>> changes) then modified to make it suitable for riscv, then for riscv to be
>> hooked up. At the moment I'm trying to follow all 3 parts per-function.
> Ok, let me give it a try during your paternity leave!
>
>> Thanks,
>> Ryan
> Thanks,
>
> Alex
>
>>
>>> This patchset was tested by running the libhugetlbfs testsuite with 64KB
>>> and 2MB pages on both architectures (on a 4KB base page size arm64 kernel).
>>>
>>> [1] https://lore.kernel.org/linux-arm-kernel/20240215103205.2607016-1-ryan.roberts@arm.com/
>>>
>>> Changes in v2:
>>>    - Rebase on top of 6.9-rc3
>>>
>>> Alexandre Ghiti (9):
>>>    riscv: Restore the pfn in a NAPOT pte when manipulated by core mm code
>>>    riscv: Safely remove huge_pte_offset() when manipulating NAPOT ptes
>>>    mm: Use common huge_ptep_get() function for riscv/arm64
>>>    mm: Use common set_huge_pte_at() function for riscv/arm64
>>>    mm: Use common huge_pte_clear() function for riscv/arm64
>>>    mm: Use common huge_ptep_get_and_clear() function for riscv/arm64
>>>    mm: Use common huge_ptep_set_access_flags() function for riscv/arm64
>>>    mm: Use common huge_ptep_set_wrprotect() function for riscv/arm64
>>>    mm: Use common huge_ptep_clear_flush() function for riscv/arm64
>>>
>>>   arch/arm64/Kconfig                  |   1 +
>>>   arch/arm64/include/asm/pgtable.h    |  56 +++++-
>>>   arch/arm64/mm/hugetlbpage.c         | 291 +---------------------------
>>>   arch/riscv/Kconfig                  |   1 +
>>>   arch/riscv/include/asm/hugetlb.h    |   2 +-
>>>   arch/riscv/include/asm/pgtable-64.h |  11 ++
>>>   arch/riscv/include/asm/pgtable.h    | 153 +++++++++++++--
>>>   arch/riscv/mm/hugetlbpage.c         | 227 ----------------------
>>>   arch/riscv/mm/pgtable.c             |   6 +-
>>>   mm/Kconfig                          |   3 +
>>>   mm/Makefile                         |   1 +
>>>   mm/contpte.c                        | 272 ++++++++++++++++++++++++++
>>>   12 files changed, 480 insertions(+), 544 deletions(-)
>>>   create mode 100644 mm/contpte.c
>>>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

