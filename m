Return-Path: <linux-kernel+bounces-226803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88038914418
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 10:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D8F028388E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 08:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8137D45BEC;
	Mon, 24 Jun 2024 08:00:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B65D49649
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 08:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719216037; cv=none; b=OwpxkAJoHiMW0d0rNtRtwa8pRiUxytcZe4PuT8wE+yuUEc6MDnacV7ke5glG55a/JLa1HmQOOYHizaxAUNyzZzK+C9sgfnyZVZYPBkoM30HojEwwr7rp1EBUPHDneDvRyAde+YxHViKZxmjxUd9ASw03BYebccvrKoiL4VFM/MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719216037; c=relaxed/simple;
	bh=pTIYPek3qibjxMjGQSliJ2NO2Jb+RHxFTvff8ISTTWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z3YlZmcauUfr8gZ7LIGougbJIHXnu4LjErq5EXNYFsrk+YkaoU4BA/2jgLgPGhIeXR4eXsLMi/FA9R+4l1Y5BVitQKmRm6KeqJfrt/bTnO5DbGtV+ZN/kONVFYPavX/JfmhFJlvUv58uOlsCOJh7notYSqeAXzyr1YNyVk5Ur3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6825DA7;
	Mon, 24 Jun 2024 01:00:58 -0700 (PDT)
Received: from [10.57.74.104] (unknown [10.57.74.104])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B92E73F6A8;
	Mon, 24 Jun 2024 01:00:31 -0700 (PDT)
Message-ID: <b7ae4c41-5de8-4097-9f66-b98bb9885395@arm.com>
Date: Mon, 24 Jun 2024 09:00:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 0/9] Merge arm64/riscv hugetlbfs contpte support
Content-Language: en-GB
To: Alexandre Ghiti <alex@ghiti.fr>, Alexandre Ghiti <alexghiti@rivosinc.com>
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
 <863092ed-2b04-46bb-8d99-5796346cef3a@ghiti.fr>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <863092ed-2b04-46bb-8d99-5796346cef3a@ghiti.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 28/05/2024 09:07, Alexandre Ghiti wrote:
> Hi Ryan,
> 
> On 12/05/2024 19:25, Alexandre Ghiti wrote:
>> Hi Ryan,
>>
>> On Fri, May 10, 2024 at 3:49 PM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>> On 08/05/2024 12:34, Alexandre Ghiti wrote:
>>>> This patchset intends to merge the contiguous ptes hugetlbfs implementation
>>>> of arm64 and riscv.
>>>>
>>>> Both arm64 and riscv support the use of contiguous ptes to map pages that
>>>> are larger than the default page table size, respectively called contpte
>>>> and svnapot.
>>>>
>>>> The riscv implementation differs from the arm64's in that the LSBs of the
>>>> pfn of a svnapot pte are used to store the size of the mapping, allowing
>>>> for future sizes to be added (for now only 64KB is supported). That's an
>>>> issue for the core mm code which expects to find the *real* pfn a pte points
>>>> to. Patch 1 fixes that by always returning svnapot ptes with the real pfn
>>>> and restores the size of the mapping when it is written to a page table.
>>>>
>>>> The following patches are just merges of the 2 different implementations
>>>> that currently exist in arm64 and riscv which are very similar. It paves
>>>> the way to the reuse of the recent contpte THP work by Ryan [1] to avoid
>>>> reimplementing the same in riscv.
>>> Hi Alexandre,
>>>
>>> I've skimmed through this series and the one that moves contpte. I can see there
>>> is definitely value in sharing the implementation, and the rough shape of things
>>> seems appropriate. I had some minor concerns about making it harder to implement
>>> potential future arm64 errata workarounds but on reflection, most of the
>>> now-shared code is really just wrapping the primitives that are still
>>> arch-specific.
>>>
>>> I'm going to need to spend proper time reviewing it to give detailed feedback,
>>> but I'll be out on paternity leave for 3 weeks from end of Monday at the latest.
>> Too bad, I expected to discuss that with you at LSF/MM...But congrats!
>> Hope your wife is fine :)
>>
>>> So realistically I won't be able to do the detailed review until at least the
>>> first week of June.

Hi Alexandre,

Sorry for the radio silence. I'm back at work now and have some cycles to review
this. Did you ever post a new version based on the suggestions below?

>>>
>>> Some high level thoughts:
>>>
>>>   - huge_ptep_* functions could be working on different sized huge ptes - arm64
>>> supports contpte, pmd, contpmd and pud. Is keeping them in contpte.c
>>> appropriate?
>> Hmm indeed, I'll see what I can do.
> 
> 
> So I took a look at that. It amounts to doing the same as what we do for THP
> contptes, ie having both contpte-aware and "normal" APIs. Let's take for example
> huge_ptep_get(), below is what I get. To me it's not that bad, so I'll implement
> this unless there is strong opposition.

I'm not sure I've understood what you are going here... see below.

> 
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index f8efbc128446..869a9aae6c68 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -1715,6 +1715,16 @@ static inline void clear_young_dirty_ptes(struct
> vm_area_struct *vma,
>                 contpte_clear_young_dirty_ptes(vma, addr, ptep, nr, flags);
>  }
> 
> +static inline pte_t huge_ptep_get(pte_t *ptep)
> +{
> +        pte_t orig_pte = __ptep_get(ptep);
> +
> +        if (!pte_present(orig_pte) || !pte_cont(orig_pte))
> +                return orig_pte;
> +
> +        return contpte_huge_ptep_get(ptep);

A "huge pte" is not the same as a "cont pte". A huge pte is an abstract thing,
which maybe of a number of different sizes; on arm64 with 4K base pages, 64K,
2M, 32M, 1G are supported. The 64K size is implemented using the PTE_CONT bit at
PTE level. 2M is a single PMD level block, 32M uses PMD_CONT at PMD level and 1G
is 1 PUD block. So I'm not sure it makes sense to tie this up with "contpte_"
functions?

> +}
> +
>  #else /* CONFIG_ARM64_CONTPTE */
> 
>  #define ptep_get                               __ptep_get
> @@ -1736,6 +1746,8 @@ static inline void clear_young_dirty_ptes(struct
> vm_area_struct *vma,
>  #define ptep_set_access_flags __ptep_set_access_flags
>  #define clear_young_dirty_ptes __clear_young_dirty_ptes
> 
> +#define huge_ptep_get                          __ptep_get

I don't quite understand the logic here. huge ptes are needed for hugetlb so
their definition needs to be tied to that, not to ARM64_CONTPTE, which is an
independent feature.

> +
>  #endif /* CONFIG_ARM64_CONTPTE */
> 
>  #endif /* !__ASSEMBLY__ */
> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> index 3f09ac73cce3..aa0ee3f02226 100644
> --- a/arch/arm64/mm/hugetlbpage.c
> +++ b/arch/arm64/mm/hugetlbpage.c
> @@ -127,28 +127,6 @@ static inline int num_contig_ptes(unsigned long size,
> size_t *pgsize)
>         return contig_ptes;
>  }
> 
> -pte_t huge_ptep_get(pte_t *ptep)
> -{
> -       int ncontig, i;
> -       size_t pgsize;
> -       pte_t orig_pte = __ptep_get(ptep);
> -
> -       if (!pte_present(orig_pte) || !pte_cont(orig_pte))
> -               return orig_pte;
> -
> -       ncontig = num_contig_ptes(page_size(pte_page(orig_pte)), &pgsize);
> -       for (i = 0; i < ncontig; i++, ptep++) {
> -               pte_t pte = __ptep_get(ptep);
> -
> -               if (pte_dirty(pte))
> -                       orig_pte = pte_mkdirty(orig_pte);
> -
> -               if (pte_young(pte))
> -                       orig_pte = pte_mkyoung(orig_pte);
> -       }
> -       return orig_pte;
> -}
> -
>  /*
>   * Changing some bits of contiguous entries requires us to follow a
>   * Break-Before-Make approach, breaking the whole contiguous set
> diff --git a/mm/contpte.c b/mm/contpte.c
> new file mode 100644
> index 000000000000..4e742cf00b6f
> --- /dev/null
> +++ b/mm/contpte.c
> @@ -0,0 +1,17 @@
> +pte_t contpte_huge_ptep_get(pte_t *ptep)
> +{
> +        int ncontig, i;
> +        size_t pgsize;
> +
> +        ncontig = num_contig_ptes(page_size(pte_page(orig_pte)), &pgsize);
> +        for (i = 0; i < ncontig; i++, ptep++) {
> +                pte_t pte = __ptep_get(ptep);
> +
> +                if (pte_dirty(pte))
> +                        orig_pte = pte_mkdirty(orig_pte);
> +
> +                if (pte_young(pte))
> +                        orig_pte = pte_mkyoung(orig_pte);
> +        }
> +        return orig_pte;
> +}

I guess your observation is that contpte_ and hugepte_ code looks similar so it
shold be grouped? I think if we can get some actual reuse that might make sense,
but as implemented, this function is completely separate from
contpte_ptep_get(). I wonder if its simpler just to have contpte.c for contpte_
and hugepte_.c for hugepte_ then they can be included in the build independently
based on arch/core Kconfigs (e.g. CONFIG_HUGETLB_PAGE vs CONFIG_ARM64_CONTPTE).

> 
>>
>>> Perhaps it's better to keep huge_pte and contpte separate? Also, it
>>> only works on arm64 because we can get away with calling the lower-level pte
>>> functions even when the huge_pte is actually a contpmd/pmd/pud, because the
>>> format is the same. That might present challenges to other arches if the format
>>> is different?
>> Yes, but I think that if that happens, we could get away with it by
>> choosing the right function depending on the size of the mapping?
>>
>>>   - It might be easier to review if the arm64 stuff is first moved (without
>>> changes) then modified to make it suitable for riscv, then for riscv to be
>>> hooked up. At the moment I'm trying to follow all 3 parts per-function.
>> Ok, let me give it a try during your paternity leave!

Review would certainly be easier with this approach!

Thanks,
Ryan

>>
>>> Thanks,
>>> Ryan
>> Thanks,
>>
>> Alex
>>
>>>
>>>> This patchset was tested by running the libhugetlbfs testsuite with 64KB
>>>> and 2MB pages on both architectures (on a 4KB base page size arm64 kernel).
>>>>
>>>> [1]
>>>> https://lore.kernel.org/linux-arm-kernel/20240215103205.2607016-1-ryan.roberts@arm.com/
>>>>
>>>> Changes in v2:
>>>>    - Rebase on top of 6.9-rc3
>>>>
>>>> Alexandre Ghiti (9):
>>>>    riscv: Restore the pfn in a NAPOT pte when manipulated by core mm code
>>>>    riscv: Safely remove huge_pte_offset() when manipulating NAPOT ptes
>>>>    mm: Use common huge_ptep_get() function for riscv/arm64
>>>>    mm: Use common set_huge_pte_at() function for riscv/arm64
>>>>    mm: Use common huge_pte_clear() function for riscv/arm64
>>>>    mm: Use common huge_ptep_get_and_clear() function for riscv/arm64
>>>>    mm: Use common huge_ptep_set_access_flags() function for riscv/arm64
>>>>    mm: Use common huge_ptep_set_wrprotect() function for riscv/arm64
>>>>    mm: Use common huge_ptep_clear_flush() function for riscv/arm64
>>>>
>>>>   arch/arm64/Kconfig                  |   1 +
>>>>   arch/arm64/include/asm/pgtable.h    |  56 +++++-
>>>>   arch/arm64/mm/hugetlbpage.c         | 291 +---------------------------
>>>>   arch/riscv/Kconfig                  |   1 +
>>>>   arch/riscv/include/asm/hugetlb.h    |   2 +-
>>>>   arch/riscv/include/asm/pgtable-64.h |  11 ++
>>>>   arch/riscv/include/asm/pgtable.h    | 153 +++++++++++++--
>>>>   arch/riscv/mm/hugetlbpage.c         | 227 ----------------------
>>>>   arch/riscv/mm/pgtable.c             |   6 +-
>>>>   mm/Kconfig                          |   3 +
>>>>   mm/Makefile                         |   1 +
>>>>   mm/contpte.c                        | 272 ++++++++++++++++++++++++++
>>>>   12 files changed, 480 insertions(+), 544 deletions(-)
>>>>   create mode 100644 mm/contpte.c
>>>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv


