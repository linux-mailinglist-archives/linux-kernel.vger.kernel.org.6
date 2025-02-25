Return-Path: <linux-kernel+bounces-531973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6ADA44732
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F50C1665A9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60606192D7C;
	Tue, 25 Feb 2025 16:57:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9A01422A8
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 16:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740502674; cv=none; b=uGaLml3aSkGp99cu2M+mrdeRvxnN91yETRXKA92/yJb/nVOgc6IcE+lOR3zvpZtBPj9FiapzjX5QemiLQb9GgLCWaDhi99EuVZhoOQTANzP+2KlzSnnI37OZ+WKd1ZNeGeZyXF/3mErTlt0SLBuFFk2FNfoBbE06v0ytuWeAyv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740502674; c=relaxed/simple;
	bh=R2ZILA4ovUqbE6Hwq/fiwCbEt6d4ytV2rIk8FwhuoRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fJzmgEiitiv2ZsfM/TVlmFSLmK2e8+4o85ythVyah58MyOFuBnOaH/NH7iclNRYyNMxFWaD9A8YhtjdmoBsf0gPLmCouAe7ta/Sw1EXlEUtYNAhtBpJXhPK11wzmsQPqnd237RehyOs+PHOOYYG0UA3KGHEFOx07v0fByXq0Eds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC69C1BCB;
	Tue, 25 Feb 2025 08:58:07 -0800 (PST)
Received: from [10.1.27.154] (XHFQ2J9959.cambridge.arm.com [10.1.27.154])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F24403F5A1;
	Tue, 25 Feb 2025 08:57:48 -0800 (PST)
Message-ID: <601fa2ab-aa75-4a34-8754-65c1d0b9a8c7@arm.com>
Date: Tue, 25 Feb 2025 16:57:47 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/14] arm64/mm: Support huge pte-mapped pages in vmap
Content-Language: en-GB
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>, Pasha Tatashin
 <pasha.tatashin@soleen.com>, Andrew Morton <akpm@linux-foundation.org>,
 Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>,
 David Hildenbrand <david@redhat.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Alexandre Ghiti <alexghiti@rivosinc.com>,
 Kevin Brodsky <kevin.brodsky@arm.com>, linux-arm-kernel@lists.infradead.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250217140809.1702789-1-ryan.roberts@arm.com>
 <20250217140809.1702789-11-ryan.roberts@arm.com> <Z7xgKjhMZAY5mOwK@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <Z7xgKjhMZAY5mOwK@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/02/2025 12:03, Catalin Marinas wrote:
> On Mon, Feb 17, 2025 at 02:08:02PM +0000, Ryan Roberts wrote:
>> Implement the required arch functions to enable use of contpte in the
>> vmap when VM_ALLOW_HUGE_VMAP is specified. This speeds up vmap
>> operations due to only having to issue a DSB and ISB per contpte block
>> instead of per pte.
> 
> For non-cont PTEs, do you happen to know how often vmap_pte_range() is
> called for multiple entries? 

It's mostly when vmalloc_huge() is called and for remapping io regions I
believe. I don't have numbers though.

> It might be worth changing that to use
> set_ptes() directly and we get some benefit as well.

I thought about that, but it's a bit of a pain, given the current
arch_vmap_pte_range_map_size() opt-in for set_huge_pte_at().

Ideally I think we would just set_ptes() the whole lot (or at least in chunks of
max_page_shift so we honour the "must belong to same folio" requirement). Then
let contpte decide when to use contiguous mappings. But we currently block
contpte operations for kernel mappings because of the potential need to
invalidate, which can cause faults. So that would need work. And we would need
to rework powerpc somehow.

The alternative would be to keep the arch_vmap_pte_range_map_size() opt-in and
somehow expose the alignment/size requirements to vmap_pte_range() so it can do
set_ptes() in the gaps. But that all felt quite messy.

In the end, I decided we would be getting the benefits via arch_make_huge_pte()
for >=64K folios, and decided not to worry about the <=3K folio cases.

> 
>> But it also means that the TLB pressure reduces due
>> to only needing a single TLB entry for the whole contpte block.
>>
>> Since vmap uses set_huge_pte_at() to set the contpte, that API is now
>> used for kernel mappings for the first time. Although in the vmap case
>> we never expect it to be called to modify a valid mapping so
>> clear_flush() should never be called, it's still wise to make it robust
>> for the kernel case, so amend the tlb flush function if the mm is for
>> kernel space.
>>
>> Tested with vmalloc performance selftests:
>>
>>   # kself/mm/test_vmalloc.sh \
>> 	run_test_mask=1
>> 	test_repeat_count=5
>> 	nr_pages=256
>> 	test_loop_count=100000
>> 	use_huge=1
>>
>> Duration reduced from 1274243 usec to 1083553 usec on Apple M2 for 15%
>> reduction in time taken.
>>
>> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>  arch/arm64/include/asm/vmalloc.h | 46 ++++++++++++++++++++++++++++++++
>>  arch/arm64/mm/hugetlbpage.c      |  5 +++-
>>  2 files changed, 50 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/include/asm/vmalloc.h b/arch/arm64/include/asm/vmalloc.h
>> index 38fafffe699f..40ebc664190b 100644
>> --- a/arch/arm64/include/asm/vmalloc.h
>> +++ b/arch/arm64/include/asm/vmalloc.h
>> @@ -23,6 +23,52 @@ static inline bool arch_vmap_pmd_supported(pgprot_t prot)
>>  	return !IS_ENABLED(CONFIG_PTDUMP_DEBUGFS);
>>  }
>>  
>> +#define arch_vmap_pte_range_map_size arch_vmap_pte_range_map_size
>> +static inline unsigned long arch_vmap_pte_range_map_size(unsigned long addr,
>> +						unsigned long end, u64 pfn,
>> +						unsigned int max_page_shift)
>> +{
>> +	/*
>> +	 * If the block is at least CONT_PTE_SIZE in size, and is naturally
>> +	 * aligned in both virtual and physical space, then we can pte-map the
>> +	 * block using the PTE_CONT bit for more efficient use of the TLB.
>> +	 */
>> +
> 
> Nit: unnecessary empty line.

Will fix.

> 
>> +	if (max_page_shift < CONT_PTE_SHIFT)
>> +		return PAGE_SIZE;
>> +
>> +	if (end - addr < CONT_PTE_SIZE)
>> +		return PAGE_SIZE;
>> +
>> +	if (!IS_ALIGNED(addr, CONT_PTE_SIZE))
>> +		return PAGE_SIZE;
>> +
>> +	if (!IS_ALIGNED(PFN_PHYS(pfn), CONT_PTE_SIZE))
>> +		return PAGE_SIZE;
>> +
>> +	return CONT_PTE_SIZE;
>> +}
>> +
>> +#define arch_vmap_pte_range_unmap_size arch_vmap_pte_range_unmap_size
>> +static inline unsigned long arch_vmap_pte_range_unmap_size(unsigned long addr,
>> +							   pte_t *ptep)
>> +{
>> +	/*
>> +	 * The caller handles alignment so it's sufficient just to check
>> +	 * PTE_CONT.
>> +	 */
>> +	return pte_valid_cont(__ptep_get(ptep)) ? CONT_PTE_SIZE : PAGE_SIZE;
>> +}
>> +
>> +#define arch_vmap_pte_supported_shift arch_vmap_pte_supported_shift
>> +static inline int arch_vmap_pte_supported_shift(unsigned long size)
>> +{
>> +	if (size >= CONT_PTE_SIZE)
>> +		return CONT_PTE_SHIFT;
>> +
>> +	return PAGE_SHIFT;
>> +}
>> +
>>  #endif
>>  
>>  #define arch_vmap_pgprot_tagged arch_vmap_pgprot_tagged
>> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
>> index 8ac86cd180b3..a29f347fea54 100644
>> --- a/arch/arm64/mm/hugetlbpage.c
>> +++ b/arch/arm64/mm/hugetlbpage.c
>> @@ -217,7 +217,10 @@ static void clear_flush(struct mm_struct *mm,
>>  	for (i = 0; i < ncontig; i++, addr += pgsize, ptep++)
>>  		ptep_get_and_clear_anysz(mm, ptep, pgsize);
>>  
>> -	__flush_hugetlb_tlb_range(&vma, saddr, addr, pgsize, true);
>> +	if (mm == &init_mm)
>> +		flush_tlb_kernel_range(saddr, addr);
>> +	else
>> +		__flush_hugetlb_tlb_range(&vma, saddr, addr, pgsize, true);
>>  }
>>  
>>  void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>


