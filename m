Return-Path: <linux-kernel+bounces-172992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A01E8BF9CF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 042FC1F23EAF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 09:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E87768FC;
	Wed,  8 May 2024 09:51:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06E675803
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 09:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715161861; cv=none; b=IcajV/wex0isKKP3pipdgZttsTmLBh5rQGcbUcbRn3DDshs19DSlJ/WvgTD+h4jSrTF5NHEPE0xKsWgokLGXcuBmAdk/cc0f6WN0jJQIIWPNldOFrDEIdsM7mIr6LsCI40L2xb7VvXzS4r6xUp/6oPNB8rZHxXYIoF3JNEt9DA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715161861; c=relaxed/simple;
	bh=7fkcZU8LfFiIhbredwhVEaDQVg66SbZcA4NULSo3Q7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ct3Haro+LXstugMcLEF7THB8s/QJUszNLa++lMYO8DmXN52iOfngirR/YwXdUw+l1ElvB/Zbn0HitDUkVuskB0flvmDUbrEZ/Luqzc77uB/M/sgTCLuBiFz2WvueB/ZLdx/B21UleDR9Yh1F+Kyecg3eb/mc1c5RDNcinXGCQQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7529B1063;
	Wed,  8 May 2024 02:51:24 -0700 (PDT)
Received: from [10.163.34.220] (unknown [10.163.34.220])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 351533F587;
	Wed,  8 May 2024 02:50:53 -0700 (PDT)
Message-ID: <ac21f19d-6065-4a70-8172-5eb19d0d6a29@arm.com>
Date: Wed, 8 May 2024 15:20:56 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] arm64/mm: Remove PTE_PROT_NONE bit
Content-Language: en-US
To: Ryan Roberts <ryan.roberts@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Joey Gouly <joey.gouly@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, David Hildenbrand <david@redhat.com>,
 Peter Xu <peterx@redhat.com>, Mike Rapoport <rppt@linux.ibm.com>,
 Shivansh Vij <shivanshvij@outlook.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240503144604.151095-1-ryan.roberts@arm.com>
 <20240503144604.151095-3-ryan.roberts@arm.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20240503144604.151095-3-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/3/24 20:16, Ryan Roberts wrote:
> Currently the PTE_PRESENT_INVALID and PTE_PROT_NONE functionality
> explicitly occupy 2 bits in the PTE when PTE_VALID/PMD_SECT_VALID is
> clear. This has 2 significant consequences:
> 
>   - PTE_PROT_NONE consumes a precious SW PTE bit that could be used for
>     other things.
>   - The swap pte layout must reserve those same 2 bits and ensure they
>     are both always zero for a swap pte. It would be nice to reclaim at
>     least one of those bits.
> 
> But PTE_PRESENT_INVALID, which since the previous patch, applies
> uniformly to page/block descriptors at any level when PTE_VALID is
> clear, can already give us most of what PTE_PROT_NONE requires: If it is
> set, then the pte is still considered present; pte_present() returns
> true and all the fields in the pte follow the HW interpretation (e.g. SW
> can safely call pte_pfn(), etc). But crucially, the HW treats the pte as
> invalid and will fault if it hits.
> 
> So let's remove PTE_PROT_NONE entirely and instead represent PROT_NONE
> as a present but invalid pte (PTE_VALID=0, PTE_PRESENT_INVALID=1) with
> PTE_USER=0 and PTE_UXN=1. This is a unique combination that is not used
> anywhere else.
> 
> The net result is a clearer, simpler, more generic encoding scheme that
> applies uniformly to all levels. Additionally we free up a PTE SW bit
> and a swap pte bit (bit 58 in both cases).
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
>  arch/arm64/include/asm/pgtable-prot.h |  3 +--
>  arch/arm64/include/asm/pgtable.h      | 31 +++++++++++++++------------
>  2 files changed, 18 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
> index cdbf51eef7a6..81f07b44f7b8 100644
> --- a/arch/arm64/include/asm/pgtable-prot.h
> +++ b/arch/arm64/include/asm/pgtable-prot.h
> @@ -18,7 +18,6 @@
>  #define PTE_DIRTY		(_AT(pteval_t, 1) << 55)
>  #define PTE_SPECIAL		(_AT(pteval_t, 1) << 56)
>  #define PTE_DEVMAP		(_AT(pteval_t, 1) << 57)
> -#define PTE_PROT_NONE		(_AT(pteval_t, 1) << 58) /* only when !PTE_VALID */
>  
>  /*
>   * PTE_PRESENT_INVALID=1 & PTE_VALID=0 indicates that the pte's fields should be
> @@ -103,7 +102,7 @@ static inline bool __pure lpa2_is_enabled(void)
>  		__val;							\
>  	 })
>  
> -#define PAGE_NONE		__pgprot(((_PAGE_DEFAULT) & ~PTE_VALID) | PTE_PROT_NONE | PTE_RDONLY | PTE_NG | PTE_PXN | PTE_UXN)
> +#define PAGE_NONE		__pgprot(((_PAGE_DEFAULT) & ~PTE_VALID) | PTE_PRESENT_INVALID | PTE_RDONLY | PTE_NG | PTE_PXN | PTE_UXN)
>  /* shared+writable pages are clean by default, hence PTE_RDONLY|PTE_WRITE */
>  #define PAGE_SHARED		__pgprot(_PAGE_SHARED)
>  #define PAGE_SHARED_EXEC	__pgprot(_PAGE_SHARED_EXEC)
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 7156c940ac4f..c0f4471423db 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -105,7 +105,7 @@ static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
>  /*
>   * The following only work if pte_present(). Undefined behaviour otherwise.
>   */
> -#define pte_present(pte)	(!!(pte_val(pte) & (PTE_VALID | PTE_PROT_NONE)))
> +#define pte_present(pte)	(pte_valid(pte) || pte_present_invalid(pte))
>  #define pte_young(pte)		(!!(pte_val(pte) & PTE_AF))
>  #define pte_special(pte)	(!!(pte_val(pte) & PTE_SPECIAL))
>  #define pte_write(pte)		(!!(pte_val(pte) & PTE_WRITE))
> @@ -478,7 +478,16 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
>   */
>  static inline int pte_protnone(pte_t pte)
>  {
> -	return (pte_val(pte) & (PTE_VALID | PTE_PROT_NONE)) == PTE_PROT_NONE;
> +	/*
> +	 * pte_present_invalid() tells us that the pte is invalid from HW
> +	 * perspective but present from SW perspective, so the fields are to be
> +	 * interpretted as per the HW layout. The second 2 checks are the unique
> +	 * encoding that we use for PROT_NONE. It is insufficient to only use
> +	 * the first check because we share the same encoding scheme with pmds
> +	 * which support pmd_mkinvalid(), so can be present-invalid without
> +	 * being PROT_NONE.
> +	 */
> +	return pte_present_invalid(pte) && !pte_user(pte) && !pte_user_exec(pte);
>  }
>  
>  static inline int pmd_protnone(pmd_t pmd)
> @@ -487,12 +496,7 @@ static inline int pmd_protnone(pmd_t pmd)
>  }
>  #endif
>  
> -#define pmd_present_invalid(pmd)	pte_present_invalid(pmd_pte(pmd))
> -
> -static inline int pmd_present(pmd_t pmd)
> -{
> -	return pte_present(pmd_pte(pmd)) || pmd_present_invalid(pmd);
> -}
> +#define pmd_present(pmd)	pte_present(pmd_pte(pmd))
>  
>  /*
>   * THP definitions.
> @@ -1029,8 +1033,8 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
>  	 * in MAIR_EL1. The mask below has to include PTE_ATTRINDX_MASK.
>  	 */
>  	const pteval_t mask = PTE_USER | PTE_PXN | PTE_UXN | PTE_RDONLY |
> -			      PTE_PROT_NONE | PTE_VALID | PTE_WRITE | PTE_GP |
> -			      PTE_ATTRINDX_MASK;
> +			      PTE_PRESENT_INVALID | PTE_VALID | PTE_WRITE |
> +			      PTE_GP | PTE_ATTRINDX_MASK;
>  	/* preserve the hardware dirty information */
>  	if (pte_hw_dirty(pte))
>  		pte = set_pte_bit(pte, __pgprot(PTE_DIRTY));
> @@ -1078,17 +1082,17 @@ static inline int pgd_devmap(pgd_t pgd)
>  #ifdef CONFIG_PAGE_TABLE_CHECK
>  static inline bool pte_user_accessible_page(pte_t pte)
>  {
> -	return pte_present(pte) && (pte_user(pte) || pte_user_exec(pte));
> +	return pte_valid(pte) && (pte_user(pte) || pte_user_exec(pte));
>  }
>  
>  static inline bool pmd_user_accessible_page(pmd_t pmd)
>  {
> -	return pmd_leaf(pmd) && !pmd_present_invalid(pmd) && (pmd_user(pmd) || pmd_user_exec(pmd));
> +	return pmd_valid(pmd) && !pmd_table(pmd) && (pmd_user(pmd) || pmd_user_exec(pmd));
>  }
>  
>  static inline bool pud_user_accessible_page(pud_t pud)
>  {
> -	return pud_leaf(pud) && (pud_user(pud) || pud_user_exec(pud));
> +	return pud_valid(pud) && !pud_table(pud) && (pud_user(pud) || pud_user_exec(pud));
>  }
>  #endif
>  
> @@ -1252,7 +1256,6 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
>   *	bits 2:		remember PG_anon_exclusive
>   *	bits 3-7:	swap type
>   *	bits 8-57:	swap offset
> - *	bit  58:	PTE_PROT_NONE (must be zero)
>   *	bit  59:	PTE_PRESENT_INVALID (must be zero)
>   */
>  #define __SWP_TYPE_SHIFT	3

