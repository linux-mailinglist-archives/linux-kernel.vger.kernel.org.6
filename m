Return-Path: <linux-kernel+bounces-532018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EBDA44799
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2FD01883A08
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A271991CB;
	Tue, 25 Feb 2025 17:10:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95EE192590
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740503418; cv=none; b=cKr/aiM/YiDDuaH3DrAHCsocLWCuka3hhNQUtxTp2kC5fLDX5dTegXTh6LuAShemLcHXB8zs1Hgmj7LRRU4LuWsbfB7W4ZDlB5BUNcH+hey8gkB4nCbPhr9A2Buyit9ju0qxsedF/Y4sUJGPs7qzfvcisoPy/xFyL/5BVblhSqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740503418; c=relaxed/simple;
	bh=ybMU1uJz0xa0s84a/PuKG30I9Xz/uFfhyq+giB+ZHAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NxZL4H/gDHELOF4Nchj/zVvwSW6dz/9CMGIBIv0z1zhWi9vK06cJZjf/Y/DzvGCPio2cVpod6iDme+U8TWdVufv1iRSqhtlIc/kbelxQA4jQzhpycfTDUqvEkF3nJcKbxz3+6v3oj4PhpCp1Tec4nMgzC9NsJkiRGRxCqnBep2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 43B871BCB;
	Tue, 25 Feb 2025 09:10:30 -0800 (PST)
Received: from [10.1.27.154] (XHFQ2J9959.cambridge.arm.com [10.1.27.154])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E56C63F5A1;
	Tue, 25 Feb 2025 09:10:11 -0800 (PST)
Message-ID: <4fad245f-a8a6-468b-82d5-13f089aa525b@arm.com>
Date: Tue, 25 Feb 2025 17:10:10 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/14] mm: Generalize arch_sync_kernel_mappings()
Content-Language: en-GB
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>,
 David Hildenbrand <david@redhat.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Alexandre Ghiti <alexghiti@rivosinc.com>,
 Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250217140809.1702789-1-ryan.roberts@arm.com>
 <20250217140809.1702789-13-ryan.roberts@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20250217140809.1702789-13-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/02/2025 14:08, Ryan Roberts wrote:
> arch_sync_kernel_mappings() is an optional hook for arches to allow them
> to synchonize certain levels of the kernel pgtables after modification.
> But arm64 could benefit from a hook similar to this, paired with a call
> prior to starting the batch of modifications.
> 
> So let's introduce arch_update_kernel_mappings_begin() and
> arch_update_kernel_mappings_end(). Both have a default implementation
> which can be overridden by the arch code. The default for the former is
> a nop, and the default for the latter is to call
> arch_sync_kernel_mappings(), so the latter replaces previous
> arch_sync_kernel_mappings() callsites. So by default, the resulting
> behaviour is unchanged.

Thanks to Kevin Brodsky; after some discussion we realised that while this works
on arm64 today, it isn't really robust in general.

arch_update_kernel_mappings_{begin|end}() are called at the outer scope of the
page table walker. It's possible that a pgtable page could be allocatd within
that scope (if you get to the pmd and its not yet present for example). Some
arches will need to kmap that from himem (I think?) and will need any PTE
manipulations to be "immediate" so we can access the pgtable. But since we are
in the arch_update_kernel_mappings_{begin|end}() scope, we are in the lazy mode,
which could delay those PTE manipulations. arm64 doesn't use himem, so it's not
an issue, but it doesn't exactly feel robust. There are also some other, similar
interactions with Keven's in-progress kpkeys series.

As an alternative, I'm proposing to remove this change (keeping
arch_sync_kernel_mappings() as it was), and instead start wrapping the vmap pte
table walker functions with
arch_enter_lazy_mmu_mode()/arch_exit_lazy_mmu_mode(). These have a smaller scope
so there is no risk of the nesting (pgtable allocations happen outside the
scope). arm64 will then use these lazy mmu hooks for it's purpose of deferring
barriers. There might be a small amount of performance loss due to the reduced
scope, but I'm guessing most of the performance is in batching the operations of
a single pte table.

One wrinkle is that arm64 needs to know if we are operating on kernel or user
mappings in lazy mode. The lazy_mmu hooks apply to both kernel and user
mappings, unlike my previous method which were kernel only. So I'm proposing to
pass mm to arch_enter_lazy_mmu_mode().

Thanks,
Ryan

> 
> To avoid include hell, the pgtbl_mod_mask type and it's associated
> macros are moved to their own header.
> 
> In a future patch, arm64 will opt-in to overriding both functions.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  include/linux/pgtable.h         | 24 +----------------
>  include/linux/pgtable_modmask.h | 32 ++++++++++++++++++++++
>  include/linux/vmalloc.h         | 47 +++++++++++++++++++++++++++++++++
>  mm/memory.c                     |  5 ++--
>  mm/vmalloc.c                    | 15 ++++++-----
>  5 files changed, 92 insertions(+), 31 deletions(-)
>  create mode 100644 include/linux/pgtable_modmask.h
> 
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 94d267d02372..7f70786a73b3 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -4,6 +4,7 @@
>  
>  #include <linux/pfn.h>
>  #include <asm/pgtable.h>
> +#include <linux/pgtable_modmask.h>
>  
>  #define PMD_ORDER	(PMD_SHIFT - PAGE_SHIFT)
>  #define PUD_ORDER	(PUD_SHIFT - PAGE_SHIFT)
> @@ -1786,29 +1787,6 @@ static inline bool arch_has_pfn_modify_check(void)
>  # define PAGE_KERNEL_EXEC PAGE_KERNEL
>  #endif
>  
> -/*
> - * Page Table Modification bits for pgtbl_mod_mask.
> - *
> - * These are used by the p?d_alloc_track*() set of functions an in the generic
> - * vmalloc/ioremap code to track at which page-table levels entries have been
> - * modified. Based on that the code can better decide when vmalloc and ioremap
> - * mapping changes need to be synchronized to other page-tables in the system.
> - */
> -#define		__PGTBL_PGD_MODIFIED	0
> -#define		__PGTBL_P4D_MODIFIED	1
> -#define		__PGTBL_PUD_MODIFIED	2
> -#define		__PGTBL_PMD_MODIFIED	3
> -#define		__PGTBL_PTE_MODIFIED	4
> -
> -#define		PGTBL_PGD_MODIFIED	BIT(__PGTBL_PGD_MODIFIED)
> -#define		PGTBL_P4D_MODIFIED	BIT(__PGTBL_P4D_MODIFIED)
> -#define		PGTBL_PUD_MODIFIED	BIT(__PGTBL_PUD_MODIFIED)
> -#define		PGTBL_PMD_MODIFIED	BIT(__PGTBL_PMD_MODIFIED)
> -#define		PGTBL_PTE_MODIFIED	BIT(__PGTBL_PTE_MODIFIED)
> -
> -/* Page-Table Modification Mask */
> -typedef unsigned int pgtbl_mod_mask;
> -
>  #endif /* !__ASSEMBLY__ */
>  
>  #if !defined(MAX_POSSIBLE_PHYSMEM_BITS) && !defined(CONFIG_64BIT)
> diff --git a/include/linux/pgtable_modmask.h b/include/linux/pgtable_modmask.h
> new file mode 100644
> index 000000000000..5a21b1bb8df3
> --- /dev/null
> +++ b/include/linux/pgtable_modmask.h
> @@ -0,0 +1,32 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_PGTABLE_MODMASK_H
> +#define _LINUX_PGTABLE_MODMASK_H
> +
> +#ifndef __ASSEMBLY__
> +
> +/*
> + * Page Table Modification bits for pgtbl_mod_mask.
> + *
> + * These are used by the p?d_alloc_track*() set of functions an in the generic
> + * vmalloc/ioremap code to track at which page-table levels entries have been
> + * modified. Based on that the code can better decide when vmalloc and ioremap
> + * mapping changes need to be synchronized to other page-tables in the system.
> + */
> +#define		__PGTBL_PGD_MODIFIED	0
> +#define		__PGTBL_P4D_MODIFIED	1
> +#define		__PGTBL_PUD_MODIFIED	2
> +#define		__PGTBL_PMD_MODIFIED	3
> +#define		__PGTBL_PTE_MODIFIED	4
> +
> +#define		PGTBL_PGD_MODIFIED	BIT(__PGTBL_PGD_MODIFIED)
> +#define		PGTBL_P4D_MODIFIED	BIT(__PGTBL_P4D_MODIFIED)
> +#define		PGTBL_PUD_MODIFIED	BIT(__PGTBL_PUD_MODIFIED)
> +#define		PGTBL_PMD_MODIFIED	BIT(__PGTBL_PMD_MODIFIED)
> +#define		PGTBL_PTE_MODIFIED	BIT(__PGTBL_PTE_MODIFIED)
> +
> +/* Page-Table Modification Mask */
> +typedef unsigned int pgtbl_mod_mask;
> +
> +#endif /* !__ASSEMBLY__ */
> +
> +#endif /* _LINUX_PGTABLE_MODMASK_H */
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index 16dd4cba64f2..cb5d8f1965a1 100644
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -11,6 +11,7 @@
>  #include <asm/page.h>		/* pgprot_t */
>  #include <linux/rbtree.h>
>  #include <linux/overflow.h>
> +#include <linux/pgtable_modmask.h>
>  
>  #include <asm/vmalloc.h>
>  
> @@ -213,6 +214,26 @@ extern int remap_vmalloc_range(struct vm_area_struct *vma, void *addr,
>  int vmap_pages_range(unsigned long addr, unsigned long end, pgprot_t prot,
>  		     struct page **pages, unsigned int page_shift);
>  
> +#ifndef arch_update_kernel_mappings_begin
> +/**
> + * arch_update_kernel_mappings_begin - A batch of kernel pgtable mappings are
> + * about to be updated.
> + * @start: Virtual address of start of range to be updated.
> + * @end: Virtual address of end of range to be updated.
> + *
> + * An optional hook to allow architecture code to prepare for a batch of kernel
> + * pgtable mapping updates. An architecture may use this to enter a lazy mode
> + * where some operations can be deferred until the end of the batch.
> + *
> + * Context: Called in task context and may be preemptible.
> + */
> +static inline void arch_update_kernel_mappings_begin(unsigned long start,
> +						     unsigned long end)
> +{
> +}
> +#endif
> +
> +#ifndef arch_update_kernel_mappings_end
>  /*
>   * Architectures can set this mask to a combination of PGTBL_P?D_MODIFIED values
>   * and let generic vmalloc and ioremap code know when arch_sync_kernel_mappings()
> @@ -229,6 +250,32 @@ int vmap_pages_range(unsigned long addr, unsigned long end, pgprot_t prot,
>   */
>  void arch_sync_kernel_mappings(unsigned long start, unsigned long end);
>  
> +/**
> + * arch_update_kernel_mappings_end - A batch of kernel pgtable mappings have
> + * been updated.
> + * @start: Virtual address of start of range that was updated.
> + * @end: Virtual address of end of range that was updated.
> + *
> + * An optional hook to inform architecture code that a batch update is complete.
> + * This balances a previous call to arch_update_kernel_mappings_begin().
> + *
> + * An architecture may override this for any purpose, such as exiting a lazy
> + * mode previously entered with arch_update_kernel_mappings_begin() or syncing
> + * kernel mappings to a secondary pgtable. The default implementation calls an
> + * arch-provided arch_sync_kernel_mappings() if any arch-defined pgtable level
> + * was updated.
> + *
> + * Context: Called in task context and may be preemptible.
> + */
> +static inline void arch_update_kernel_mappings_end(unsigned long start,
> +						   unsigned long end,
> +						   pgtbl_mod_mask mask)
> +{
> +	if (mask & ARCH_PAGE_TABLE_SYNC_MASK)
> +		arch_sync_kernel_mappings(start, end);
> +}
> +#endif
> +
>  /*
>   *	Lowlevel-APIs (not for driver use!)
>   */
> diff --git a/mm/memory.c b/mm/memory.c
> index a15f7dd500ea..f80930bc19f6 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3035,6 +3035,8 @@ static int __apply_to_page_range(struct mm_struct *mm, unsigned long addr,
>  	if (WARN_ON(addr >= end))
>  		return -EINVAL;
>  
> +	arch_update_kernel_mappings_begin(start, end);
> +
>  	pgd = pgd_offset(mm, addr);
>  	do {
>  		next = pgd_addr_end(addr, end);
> @@ -3055,8 +3057,7 @@ static int __apply_to_page_range(struct mm_struct *mm, unsigned long addr,
>  			break;
>  	} while (pgd++, addr = next, addr != end);
>  
> -	if (mask & ARCH_PAGE_TABLE_SYNC_MASK)
> -		arch_sync_kernel_mappings(start, start + size);
> +	arch_update_kernel_mappings_end(start, end, mask);
>  
>  	return err;
>  }
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 50fd44439875..c5c51d86ef78 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -312,10 +312,10 @@ int vmap_page_range(unsigned long addr, unsigned long end,
>  	pgtbl_mod_mask mask = 0;
>  	int err;
>  
> +	arch_update_kernel_mappings_begin(addr, end);
>  	err = vmap_range_noflush(addr, end, phys_addr, pgprot_nx(prot),
>  				 ioremap_max_page_shift, &mask);
> -	if (mask & ARCH_PAGE_TABLE_SYNC_MASK)
> -		arch_sync_kernel_mappings(addr, end);
> +	arch_update_kernel_mappings_end(addr, end, mask);
>  
>  	flush_cache_vmap(addr, end);
>  	if (!err)
> @@ -463,6 +463,9 @@ void __vunmap_range_noflush(unsigned long start, unsigned long end)
>  	pgtbl_mod_mask mask = 0;
>  
>  	BUG_ON(addr >= end);
> +
> +	arch_update_kernel_mappings_begin(start, end);
> +
>  	pgd = pgd_offset_k(addr);
>  	do {
>  		next = pgd_addr_end(addr, end);
> @@ -473,8 +476,7 @@ void __vunmap_range_noflush(unsigned long start, unsigned long end)
>  		vunmap_p4d_range(pgd, addr, next, &mask);
>  	} while (pgd++, addr = next, addr != end);
>  
> -	if (mask & ARCH_PAGE_TABLE_SYNC_MASK)
> -		arch_sync_kernel_mappings(start, end);
> +	arch_update_kernel_mappings_end(start, end, mask);
>  }
>  
>  void vunmap_range_noflush(unsigned long start, unsigned long end)
> @@ -625,6 +627,8 @@ int __vmap_pages_range_noflush(unsigned long addr, unsigned long end,
>  
>  	WARN_ON(page_shift < PAGE_SHIFT);
>  
> +	arch_update_kernel_mappings_begin(start, end);
> +
>  	if (!IS_ENABLED(CONFIG_HAVE_ARCH_HUGE_VMALLOC) ||
>  			page_shift == PAGE_SHIFT) {
>  		err = vmap_small_pages_range_noflush(addr, end, prot, pages,
> @@ -642,8 +646,7 @@ int __vmap_pages_range_noflush(unsigned long addr, unsigned long end,
>  		}
>  	}
>  
> -	if (mask & ARCH_PAGE_TABLE_SYNC_MASK)
> -		arch_sync_kernel_mappings(start, end);
> +	arch_update_kernel_mappings_end(start, end, mask);
>  
>  	return err;
>  }


