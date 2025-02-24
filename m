Return-Path: <linux-kernel+bounces-528962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA7DA41E7D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59A8A3BB266
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A3D2571BD;
	Mon, 24 Feb 2025 12:03:59 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE372571A0
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 12:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740398639; cv=none; b=Chya+k0zpJHqDIlMWh+xntThXux//CtpH93NOFC6IID52XSduvg/bCLqTxxZbrV2f3JKPHS4IPhFKMo1eLG2j1R1CDBt8B4i7oO7W6c8KG9CLSSepwCibcDc6S1Bwo0L3H/YOTzu73O9TYe1MNYWCy4XziLwpnsSSvrX/MeqSyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740398639; c=relaxed/simple;
	bh=6rDMThJ76kRzwOyY/6qNoJyzhUDK6RUwFgvnyuTu6nU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DKry4522VXadVut/xniqofqYMB7Y1b7DkaQaiuOaOTDiF0IecUMERKONdvYbXZy5ViATSeLU940NlAp9T7KEes4VACaBrIqfYzfKKXOHmbohQrAI475NTe/by30dXg5Q0qwymuIojvz3jOS+y0HYntKCsR3eMa0WvldyDJWs3Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E55EC4CED6;
	Mon, 24 Feb 2025 12:03:56 +0000 (UTC)
Date: Mon, 24 Feb 2025 12:03:54 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Will Deacon <will@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/14] arm64/mm: Support huge pte-mapped pages in vmap
Message-ID: <Z7xgKjhMZAY5mOwK@arm.com>
References: <20250217140809.1702789-1-ryan.roberts@arm.com>
 <20250217140809.1702789-11-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217140809.1702789-11-ryan.roberts@arm.com>

On Mon, Feb 17, 2025 at 02:08:02PM +0000, Ryan Roberts wrote:
> Implement the required arch functions to enable use of contpte in the
> vmap when VM_ALLOW_HUGE_VMAP is specified. This speeds up vmap
> operations due to only having to issue a DSB and ISB per contpte block
> instead of per pte.

For non-cont PTEs, do you happen to know how often vmap_pte_range() is
called for multiple entries? It might be worth changing that to use
set_ptes() directly and we get some benefit as well.

> But it also means that the TLB pressure reduces due
> to only needing a single TLB entry for the whole contpte block.
> 
> Since vmap uses set_huge_pte_at() to set the contpte, that API is now
> used for kernel mappings for the first time. Although in the vmap case
> we never expect it to be called to modify a valid mapping so
> clear_flush() should never be called, it's still wise to make it robust
> for the kernel case, so amend the tlb flush function if the mm is for
> kernel space.
> 
> Tested with vmalloc performance selftests:
> 
>   # kself/mm/test_vmalloc.sh \
> 	run_test_mask=1
> 	test_repeat_count=5
> 	nr_pages=256
> 	test_loop_count=100000
> 	use_huge=1
> 
> Duration reduced from 1274243 usec to 1083553 usec on Apple M2 for 15%
> reduction in time taken.
> 
> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  arch/arm64/include/asm/vmalloc.h | 46 ++++++++++++++++++++++++++++++++
>  arch/arm64/mm/hugetlbpage.c      |  5 +++-
>  2 files changed, 50 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/vmalloc.h b/arch/arm64/include/asm/vmalloc.h
> index 38fafffe699f..40ebc664190b 100644
> --- a/arch/arm64/include/asm/vmalloc.h
> +++ b/arch/arm64/include/asm/vmalloc.h
> @@ -23,6 +23,52 @@ static inline bool arch_vmap_pmd_supported(pgprot_t prot)
>  	return !IS_ENABLED(CONFIG_PTDUMP_DEBUGFS);
>  }
>  
> +#define arch_vmap_pte_range_map_size arch_vmap_pte_range_map_size
> +static inline unsigned long arch_vmap_pte_range_map_size(unsigned long addr,
> +						unsigned long end, u64 pfn,
> +						unsigned int max_page_shift)
> +{
> +	/*
> +	 * If the block is at least CONT_PTE_SIZE in size, and is naturally
> +	 * aligned in both virtual and physical space, then we can pte-map the
> +	 * block using the PTE_CONT bit for more efficient use of the TLB.
> +	 */
> +

Nit: unnecessary empty line.

> +	if (max_page_shift < CONT_PTE_SHIFT)
> +		return PAGE_SIZE;
> +
> +	if (end - addr < CONT_PTE_SIZE)
> +		return PAGE_SIZE;
> +
> +	if (!IS_ALIGNED(addr, CONT_PTE_SIZE))
> +		return PAGE_SIZE;
> +
> +	if (!IS_ALIGNED(PFN_PHYS(pfn), CONT_PTE_SIZE))
> +		return PAGE_SIZE;
> +
> +	return CONT_PTE_SIZE;
> +}
> +
> +#define arch_vmap_pte_range_unmap_size arch_vmap_pte_range_unmap_size
> +static inline unsigned long arch_vmap_pte_range_unmap_size(unsigned long addr,
> +							   pte_t *ptep)
> +{
> +	/*
> +	 * The caller handles alignment so it's sufficient just to check
> +	 * PTE_CONT.
> +	 */
> +	return pte_valid_cont(__ptep_get(ptep)) ? CONT_PTE_SIZE : PAGE_SIZE;
> +}
> +
> +#define arch_vmap_pte_supported_shift arch_vmap_pte_supported_shift
> +static inline int arch_vmap_pte_supported_shift(unsigned long size)
> +{
> +	if (size >= CONT_PTE_SIZE)
> +		return CONT_PTE_SHIFT;
> +
> +	return PAGE_SHIFT;
> +}
> +
>  #endif
>  
>  #define arch_vmap_pgprot_tagged arch_vmap_pgprot_tagged
> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> index 8ac86cd180b3..a29f347fea54 100644
> --- a/arch/arm64/mm/hugetlbpage.c
> +++ b/arch/arm64/mm/hugetlbpage.c
> @@ -217,7 +217,10 @@ static void clear_flush(struct mm_struct *mm,
>  	for (i = 0; i < ncontig; i++, addr += pgsize, ptep++)
>  		ptep_get_and_clear_anysz(mm, ptep, pgsize);
>  
> -	__flush_hugetlb_tlb_range(&vma, saddr, addr, pgsize, true);
> +	if (mm == &init_mm)
> +		flush_tlb_kernel_range(saddr, addr);
> +	else
> +		__flush_hugetlb_tlb_range(&vma, saddr, addr, pgsize, true);
>  }
>  
>  void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

