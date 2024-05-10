Return-Path: <linux-kernel+bounces-175770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 322078C24B3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 14:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B43E3281F4A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 12:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0AF16F0DA;
	Fri, 10 May 2024 12:20:53 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D744168AFC
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 12:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715343653; cv=none; b=DtYhMpPqkOeFbq6m7SJ66OnDf1mbnQQ+NBpviOvzHfOhVpY/GkL5aLe+Vcg+CLwaa8EWsAWNrtjvDoT2tzIY0XDtfwGFKVK3lO/nqb4JICZbfdxcOPsP9OzdSOSaLR/PbqP/HOzlYWTqO/RnXZOc05J3D0RcvBbPyeQYxTRWSh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715343653; c=relaxed/simple;
	bh=/dcMy3NKodqJ3PZ1wc9yOe0gVTFk0uy8pUpDi0JZV0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WJFz+lk4lK/mD8AXrFCjLOpOuDMUL4cyYN/ucW9eIm81+CkwGT//tDeg531cFUoT5cjIaYTV5stIsQCUb4GX8NgcfeV+t9GM+sr33eaUV55X1WQ7CFqfL3V0vbdq8oq/Z1UHPChpOdjzFu7hX8whX1vcfIcsG9hpQhBR5C2sXWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C921D106F;
	Fri, 10 May 2024 05:21:15 -0700 (PDT)
Received: from [10.57.65.1] (unknown [10.57.65.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF89A3F6A8;
	Fri, 10 May 2024 05:20:48 -0700 (PDT)
Message-ID: <8aa0a606-f47c-4826-96ad-121ac1f7eb96@arm.com>
Date: Fri, 10 May 2024 13:20:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 1/9] riscv: Restore the pfn in a NAPOT pte when
 manipulated by core mm code
Content-Language: en-GB
To: Alexandre Ghiti <alexghiti@rivosinc.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Andrew Morton
 <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-mm@kvack.org
References: <20240508113419.18620-1-alexghiti@rivosinc.com>
 <20240508113419.18620-2-alexghiti@rivosinc.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240508113419.18620-2-alexghiti@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/05/2024 12:34, Alexandre Ghiti wrote:
> The core mm code expects to be able to extract the pfn from a pte. NAPOT
> mappings work differently since its ptes actually point to the first pfn
> of the mapping, the other bits being used to encode the size of the
> mapping.
> 
> So modify ptep_get() so that it returns a pte value that contains the
> *real* pfn (which is then different from what the HW expects) and right
> before storing the ptes to the page table, reset the pfn LSBs to the
> size of the mapping.

Did you consider leaving the pte as is and instead modifying your pte_pfn()
implementation?

For arm64 at least, it is beneficial to keep the pte marked as contiguous when
passing it up to core-mm because there are other helpers which need to parse the
contiguous bit (e.g. pte_leaf_size()). If we were to clear the cont bit in
ptep_get() that info would be lost and perf_get_pgtable_size() would always
conclude the leaf size is 4K even when it is actually 64K.

> 
> And make sure that all NAPOT mappings are set using set_ptes().
> 
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/include/asm/pgtable-64.h |  11 +++
>  arch/riscv/include/asm/pgtable.h    | 105 ++++++++++++++++++++++++++--
>  arch/riscv/mm/hugetlbpage.c         |  38 +++++-----
>  3 files changed, 128 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
> index 221a5c1ee287..9fe076fc503e 100644
> --- a/arch/riscv/include/asm/pgtable-64.h
> +++ b/arch/riscv/include/asm/pgtable-64.h
> @@ -106,6 +106,17 @@ enum napot_cont_order {
>  #define napot_cont_mask(order)	(~(napot_cont_size(order) - 1UL))
>  #define napot_pte_num(order)	BIT(order)
>  
> +static inline bool is_napot_order(unsigned int order)
> +{
> +	unsigned int napot_order;
> +
> +	for_each_napot_order(napot_order)
> +		if (order == napot_order)
> +			return true;
> +
> +	return false;
> +}
> +
>  #ifdef CONFIG_RISCV_ISA_SVNAPOT
>  #define HUGE_MAX_HSTATE		(2 + (NAPOT_ORDER_MAX - NAPOT_CONT_ORDER_BASE))
>  #else
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 9f8ea0e33eb1..268c828f5152 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -297,6 +297,8 @@ static inline unsigned long pte_napot(pte_t pte)
>  	return pte_val(pte) & _PAGE_NAPOT;
>  }
>  
> +#define pte_valid_napot(pte)	(pte_present(pte) && pte_napot(pte))
> +
>  static inline pte_t pte_mknapot(pte_t pte, unsigned int order)
>  {
>  	int pos = order - 1 + _PAGE_PFN_SHIFT;
> @@ -306,6 +308,12 @@ static inline pte_t pte_mknapot(pte_t pte, unsigned int order)
>  	return __pte((pte_val(pte) & napot_mask) | napot_bit | _PAGE_NAPOT);
>  }
>  
> +/* pte at entry must *not* encode the mapping size in the pfn LSBs. */
> +static inline pte_t pte_clear_napot(pte_t pte)
> +{
> +	return __pte(pte_val(pte) & ~_PAGE_NAPOT);
> +}
> +
>  #else
>  
>  static __always_inline bool has_svnapot(void) { return false; }
> @@ -315,17 +323,14 @@ static inline unsigned long pte_napot(pte_t pte)
>  	return 0;
>  }
>  
> +#define pte_valid_napot(pte)	false
> +
>  #endif /* CONFIG_RISCV_ISA_SVNAPOT */
>  
>  /* Yields the page frame number (PFN) of a page table entry */
>  static inline unsigned long pte_pfn(pte_t pte)
>  {
> -	unsigned long res  = __page_val_to_pfn(pte_val(pte));
> -
> -	if (has_svnapot() && pte_napot(pte))
> -		res = res & (res - 1UL);
> -
> -	return res;
> +	return __page_val_to_pfn(pte_val(pte));
>  }
>  
>  #define pte_page(x)     pfn_to_page(pte_pfn(x))
> @@ -525,9 +530,91 @@ static inline void __set_pte_at(struct mm_struct *mm, pte_t *ptep, pte_t pteval)
>  
>  #define PFN_PTE_SHIFT		_PAGE_PFN_SHIFT
>  
> +#ifdef CONFIG_RISCV_ISA_SVNAPOT
> +static inline int arch_contpte_get_num_contig(pte_t *ptep, unsigned long size,
> +					      size_t *pgsize)
> +{
> +	pte_t __pte;
> +
> +	/* We must read the raw value of the pte to get the size of the mapping */
> +	__pte = READ_ONCE(*ptep);
> +
> +	if (pgsize) {
> +		if (size >= PGDIR_SIZE)
> +			*pgsize = PGDIR_SIZE;
> +		else if (size >= P4D_SIZE)
> +			*pgsize = P4D_SIZE;
> +		else if (size >= PUD_SIZE)
> +			*pgsize = PUD_SIZE;
> +		else if (size >= PMD_SIZE)
> +			*pgsize = PMD_SIZE;
> +		else
> +			*pgsize = PAGE_SIZE;
> +	}
> +
> +	/* Make sure __pte is not a swap entry */
> +	if (pte_valid_napot(__pte))
> +		return napot_pte_num(napot_cont_order(__pte));
> +
> +	return 1;
> +}
> +#endif
> +
> +static inline pte_t ptep_get(pte_t *ptep)
> +{
> +	pte_t pte = READ_ONCE(*ptep);
> +
> +#ifdef CONFIG_RISCV_ISA_SVNAPOT
> +	/*
> +	 * The pte we load has the N bit set and the size of the mapping in
> +	 * the pfn LSBs: keep the N bit and replace the mapping size with
> +	 * the *real* pfn since the core mm code expects to find it there.
> +	 * The mapping size will be reset just before being written to the
> +	 * page table in set_ptes().
> +	 */
> +	if (unlikely(pte_valid_napot(pte))) {
> +		unsigned int order = napot_cont_order(pte);
> +		int pos = order - 1 + _PAGE_PFN_SHIFT;
> +		unsigned long napot_mask = ~GENMASK(pos, _PAGE_PFN_SHIFT);
> +		pte_t *orig_ptep = PTR_ALIGN_DOWN(ptep, sizeof(*ptep) * napot_pte_num(order));
> +
> +		pte = __pte((pte_val(pte) & napot_mask) + ((ptep - orig_ptep) << _PAGE_PFN_SHIFT));
> +	}
> +#endif
> +
> +	return pte;
> +}
> +#define ptep_get	ptep_get
> +
>  static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
>  		pte_t *ptep, pte_t pteval, unsigned int nr)
>  {
> +#ifdef CONFIG_RISCV_ISA_SVNAPOT
> +	if (unlikely(pte_valid_napot(pteval))) {
> +		unsigned int order = ilog2(nr);
> +
> +		if (!is_napot_order(order)) {
> +			/*
> +			 * Something's weird, we are given a NAPOT pte but the
> +			 * size of the mapping is not a known NAPOT mapping
> +			 * size, so clear the NAPOT bit and map this without
> +			 * NAPOT support: core mm only manipulates pte with the
> +			 * real pfn so we know the pte is valid without the N
> +			 * bit.
> +			 */
> +			pr_err("Incorrect NAPOT mapping, resetting.\n");
> +			pteval = pte_clear_napot(pteval);
> +		} else {
> +			/*
> +			 * NAPOT ptes that arrive here only have the N bit set
> +			 * and their pfn does not contain the mapping size, so
> +			 * set that here.
> +			 */
> +			pteval = pte_mknapot(pteval, order);
> +		}
> +	}
> +#endif

I think all this complexity comes along due to using this function both as a
public interface that the core-mm uses (which never sets napot) and also using
it as an internal interface that riscv-hugetlb uses (which does set napot)? It
might be more understandable if you layer it into a lower level/internal API and
a higher level/public API (similar to arm64)?

> +
>  	page_table_check_ptes_set(mm, ptep, pteval, nr);
>  
>  	for (;;) {
> @@ -535,6 +622,12 @@ static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
>  		if (--nr == 0)
>  			break;
>  		ptep++;
> +
> +#ifdef CONFIG_RISCV_ISA_SVNAPOT
> +		if (unlikely(pte_valid_napot(pteval)))
> +			continue;
> +#endif
> +
>  		pte_val(pteval) += 1 << _PAGE_PFN_SHIFT;
>  	}
>  }
> diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
> index 5ef2a6891158..fe8067ee71b4 100644
> --- a/arch/riscv/mm/hugetlbpage.c
> +++ b/arch/riscv/mm/hugetlbpage.c
> @@ -256,8 +256,7 @@ void set_huge_pte_at(struct mm_struct *mm,
>  
>  	clear_flush(mm, addr, ptep, pgsize, pte_num);
>  
> -	for (i = 0; i < pte_num; i++, ptep++, addr += pgsize)
> -		set_pte_at(mm, addr, ptep, pte);
> +	set_ptes(mm, addr, ptep, pte, pte_num);
>  }
>  
>  int huge_ptep_set_access_flags(struct vm_area_struct *vma,
> @@ -267,16 +266,16 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
>  			       int dirty)
>  {
>  	struct mm_struct *mm = vma->vm_mm;
> -	unsigned long order;
> +	size_t pgsize;
>  	pte_t orig_pte;
> -	int i, pte_num;
> +	int pte_num;
>  
>  	if (!pte_napot(pte))
>  		return ptep_set_access_flags(vma, addr, ptep, pte, dirty);
>  
> -	order = napot_cont_order(pte);
> -	pte_num = napot_pte_num(order);
> -	ptep = huge_pte_offset(mm, addr, napot_cont_size(order));
> +	pte_num = arch_contpte_get_num_contig(ptep, 0, &pgsize);
> +	ptep = huge_pte_offset(mm, addr, pte_num * pgsize);
> +
>  	orig_pte = get_clear_contig_flush(mm, addr, ptep, pte_num);
>  
>  	if (pte_dirty(orig_pte))
> @@ -285,8 +284,7 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
>  	if (pte_young(orig_pte))
>  		pte = pte_mkyoung(pte);
>  
> -	for (i = 0; i < pte_num; i++, addr += PAGE_SIZE, ptep++)
> -		set_pte_at(mm, addr, ptep, pte);
> +	set_ptes(mm, addr, ptep, pte, pte_num);
>  
>  	return true;
>  }
> @@ -301,7 +299,7 @@ pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
>  	if (!pte_napot(orig_pte))
>  		return ptep_get_and_clear(mm, addr, ptep);
>  
> -	pte_num = napot_pte_num(napot_cont_order(orig_pte));
> +	pte_num = arch_contpte_get_num_contig(ptep, 0, NULL);
>  
>  	return get_clear_contig(mm, addr, ptep, pte_num);
>  }
> @@ -311,24 +309,23 @@ void huge_ptep_set_wrprotect(struct mm_struct *mm,
>  			     pte_t *ptep)
>  {
>  	pte_t pte = ptep_get(ptep);
> -	unsigned long order;
> +	size_t pgsize;
>  	pte_t orig_pte;
> -	int i, pte_num;
> +	int pte_num;
>  
>  	if (!pte_napot(pte)) {
>  		ptep_set_wrprotect(mm, addr, ptep);
>  		return;
>  	}
>  
> -	order = napot_cont_order(pte);
> -	pte_num = napot_pte_num(order);
> -	ptep = huge_pte_offset(mm, addr, napot_cont_size(order));
> +	pte_num = arch_contpte_get_num_contig(ptep, 0, &pgsize);
> +	ptep = huge_pte_offset(mm, addr, pte_num * pgsize);
> +
>  	orig_pte = get_clear_contig_flush(mm, addr, ptep, pte_num);
>  
>  	orig_pte = pte_wrprotect(orig_pte);
>  
> -	for (i = 0; i < pte_num; i++, addr += PAGE_SIZE, ptep++)
> -		set_pte_at(mm, addr, ptep, orig_pte);
> +	set_ptes(mm, addr, ptep, orig_pte, pte_num);
>  }
>  
>  pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
> @@ -341,7 +338,7 @@ pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
>  	if (!pte_napot(pte))
>  		return ptep_clear_flush(vma, addr, ptep);
>  
> -	pte_num = napot_pte_num(napot_cont_order(pte));
> +	pte_num = arch_contpte_get_num_contig(ptep, 0, NULL);
>  
>  	return get_clear_contig_flush(vma->vm_mm, addr, ptep, pte_num);
>  }
> @@ -351,6 +348,7 @@ void huge_pte_clear(struct mm_struct *mm,
>  		    pte_t *ptep,
>  		    unsigned long sz)
>  {
> +	size_t pgsize;
>  	pte_t pte = ptep_get(ptep);
>  	int i, pte_num;
>  
> @@ -359,8 +357,8 @@ void huge_pte_clear(struct mm_struct *mm,
>  		return;
>  	}
>  
> -	pte_num = napot_pte_num(napot_cont_order(pte));
> -	for (i = 0; i < pte_num; i++, addr += PAGE_SIZE, ptep++)
> +	pte_num = arch_contpte_get_num_contig(ptep, 0, &pgsize);
> +	for (i = 0; i < pte_num; i++, addr += pgsize, ptep++)
>  		pte_clear(mm, addr, ptep);
>  }
>  


