Return-Path: <linux-kernel+bounces-519515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC5FA39DAF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8A6D3B7672
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 13:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B0C26E14C;
	Tue, 18 Feb 2025 13:28:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD08926B2C2
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 13:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739885314; cv=none; b=pJp3IIsVjB4B/eDvWf0lrkmVO5hZvs+Kkm9gmDHNLbPKktlIhjMihmd8vSu929ZQY/YK7sAvfxpj7bnx5xQ6VaCy2zSDdpUgz1tWBc7t3sOezdQxYqp9a0cF2Vk8X/tPpf12onZpM8lCMQK7BnPxkLWn9d4FptNkJWvYdzaE5AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739885314; c=relaxed/simple;
	bh=O75fo14HnVCBU/D3SzoEqX/HIR80cQzpneEsdzXHPRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZW9CsoKnt0JO+/wxuBVb4V56mui4uhyKies/Wl7GnkG8epZ9b/MAcW9qK423I0urlDmZAJXCzdyKNF9Nl+RpiMs9bdPWiJ4jSl1SA6eGRwZny5ulNeJWbEFyK8Iqef6PICwB+ku3miErA/bc6ijtENbEBo3YMB+T4rmPy/DS3nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD493152B;
	Tue, 18 Feb 2025 05:28:49 -0800 (PST)
Received: from [10.1.27.186] (XHFQ2J9959.cambridge.arm.com [10.1.27.186])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B661B3F59E;
	Tue, 18 Feb 2025 05:28:29 -0800 (PST)
Message-ID: <48678288-c7a1-48a6-89d0-06e34e3b904a@arm.com>
Date: Tue, 18 Feb 2025 13:28:28 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 PATCH 2/2] arm64: mm: support large block mapping when
 rodata=full
Content-Language: en-GB
To: Yang Shi <yang@os.amperecomputing.com>, catalin.marinas@arm.com,
 will@kernel.org
Cc: cl@gentwo.org, scott@os.amperecomputing.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Miko Lenczewski <Miko.Lenczewski@arm.com>
References: <20250103011822.1257189-1-yang@os.amperecomputing.com>
 <20250103011822.1257189-3-yang@os.amperecomputing.com>
 <caf29133-a24f-47e4-ba38-d1f99e998d27@arm.com>
 <be09705e-2f85-47e0-b632-f2fdb32e54ba@os.amperecomputing.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <be09705e-2f85-47e0-b632-f2fdb32e54ba@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 13/02/2025 21:18, Yang Shi wrote:
> 
> 
> 
> On 2/11/25 4:58 AM, Ryan Roberts wrote:
>> On 03/01/2025 01:17, Yang Shi wrote:
>>> When rodata=full is specified, kernel linear mapping has to be mapped at
>>> PTE level since large page table can't be split due to break-before-make
>>> rule on ARM64.
>>>
>>> This resulted in a couple of problems:
>>>    - performance degradation
>>>    - more TLB pressure
>>>    - memory waste for kernel page table
>>>
>>> With FEAT_BBM level 2 support, splitting large block page table to
>>> smaller ones doesn't need to make the page table entry invalid anymore.
>>> This allows kernel split large block mapping on the fly.
>>>
>>> Add kernel page table split support and use large block mapping by
>>> default when FEAT_BBM level 2 is supported for rodata=full.  When
>>> changing permissions for kernel linear mapping, the page table will be
>>> split to PTE level.
>>>
>>> The machine without FEAT_BBM level 2 will fallback to have kernel linear
>>> mapping PTE-mapped when rodata=full.
>>>
>>> With this we saw significant performance boost with some benchmarks and
>>> much less memory consumption on my AmpereOne machine (192 cores, 1P) with
>>> 256GB memory.
>>>
>>> * Memory use after boot
>>> Before:
>>> MemTotal:       258988984 kB
>>> MemFree:        254821700 kB
>>>
>>> After:
>>> MemTotal:       259505132 kB
>>> MemFree:        255410264 kB
>>>
>>> Around 500MB more memory are free to use.  The larger the machine, the
>>> more memory saved.
>>>
>>> * Memcached
>>> We saw performance degradation when running Memcached benchmark with
>>> rodata=full vs rodata=on.  Our profiling pointed to kernel TLB pressure.
>>> With this patchset we saw ops/sec is increased by around 3.5%, P99
>>> latency is reduced by around 9.6%.
>>> The gain mainly came from reduced kernel TLB misses.  The kernel TLB
>>> MPKI is reduced by 28.5%.
>>>
>>> The benchmark data is now on par with rodata=on too.
>>>
>>> * Disk encryption (dm-crypt) benchmark
>>> Ran fio benchmark with the below command on a 128G ramdisk (ext4) with disk
>>> encryption (by dm-crypt).
>>> fio --directory=/data --random_generator=lfsr --norandommap --randrepeat 1 \
>>>      --status-interval=999 --rw=write --bs=4k --loops=1 --ioengine=sync \
>>>      --iodepth=1 --numjobs=1 --fsync_on_close=1 --group_reporting --thread \
>>>      --name=iops-test-job --eta-newline=1 --size 100G
>>>
>>> The IOPS is increased by 90% - 150% (the variance is high, but the worst
>>> number of good case is around 90% more than the best number of bad case).
>>> The bandwidth is increased and the avg clat is reduced proportionally.
>>>
>>> * Sequential file read
>>> Read 100G file sequentially on XFS (xfs_io read with page cache populated).
>>> The bandwidth is increased by 150%.
>>>
>>> Keep using PTE mapping when pagealloc debug is enabled.  It is not worth
>>> the complexity.
>>>
>>> Kfence can be converted to use page block mapping later.
>>>
>>> Signed-off-by: Yang Shi<yang@os.amperecomputing.com>
>>> ---
>>>   arch/arm64/include/asm/pgtable.h |   7 +-
>>>   arch/arm64/mm/mmu.c              |  32 +++++-
>>>   arch/arm64/mm/pageattr.c         | 173 +++++++++++++++++++++++++++++--
>>>   3 files changed, 203 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>>> index 6986345b537a..2927f59ae9e2 100644
>>> --- a/arch/arm64/include/asm/pgtable.h
>>> +++ b/arch/arm64/include/asm/pgtable.h
>>> @@ -749,7 +749,7 @@ static inline bool in_swapper_pgdir(void *addr)
>>>               ((unsigned long)swapper_pg_dir & PAGE_MASK);
>>>   }
>>>   -static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
>>> +static inline void __set_pmd_nosync(pmd_t *pmdp, pmd_t pmd)
>>>   {
>>>   #ifdef __PAGETABLE_PMD_FOLDED
>>>       if (in_swapper_pgdir(pmdp)) {
>>> @@ -759,6 +759,11 @@ static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
>>>   #endif /* __PAGETABLE_PMD_FOLDED */
>>>         WRITE_ONCE(*pmdp, pmd);
>>> +}
>>> +
>>> +static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
>>> +{
>>> +    __set_pmd_nosync(pmdp, pmd);
>> I have a series at [1] which enables batching/deferring these barriers. I reckon
>> it would be udeful to ultimately apply that same technique for painting the
>> linear map if/when that series goes upstream. The benefit is that we wouldn't
>> need to expose the _nosync helpers. But that's something to cleanup later. This
>> looks fine for now.
> 
> Thanks.
> 
>>>         if (pmd_valid(pmd)) {
>>>           dsb(ishst);
>>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>>> index e2739b69e11b..65b5b1ba48a7 100644
>>> --- a/arch/arm64/mm/mmu.c
>>> +++ b/arch/arm64/mm/mmu.c
>>> @@ -620,6 +620,19 @@ static inline void arm64_kfence_map_pool(phys_addr_t
>>> kfence_pool, pgd_t *pgdp) {
>>>     #endif /* CONFIG_KFENCE */
>>>   +static inline bool force_pte_mapping(void)
>>> +{
>>> +    /*
>>> +     * Can't use cpufeature API to determine whether BBM level 2
>>> +     * is supported or not since cpufeature have not been
>>> +     * finalized yet.
>>> +     */
>> I think assuming the system has BMML2 just because the boot CPU has it is going
>> to be problematic. I think you are going to continue to need to initially paint
>> the linear map with ptes then later, once the system cap is finalized, repaint
>> with blocks.
> 
> Please see the response for patch 1. We may be able to split it instead of
> collapse it.
> 
>>> +    return (rodata_full && !bbmlv2_available()) ||
>>> +        debug_pagealloc_enabled() ||
>>> +        arm64_kfence_can_set_direct_map() ||
>>> +        is_realm_world();
>>> +}
>> Previously the decision was determined by:
>>
>> bool can_set_direct_map(void)
>> {
>>     /*
>>      * rodata_full, DEBUG_PAGEALLOC and a Realm guest all require linear
>>      * map to be mapped at page granularity, so that it is possible to
>>      * protect/unprotect single pages.
>>      *
>>      * KFENCE pool requires page-granular mapping if initialized late.
>>      *
>>      * Realms need to make pages shared/protected at page granularity.
>>      */
>>     return rodata_full || debug_pagealloc_enabled() ||
>>         arm64_kfence_can_set_direct_map() || is_realm_world();
>> }
>>
>> But now that you can safely split block mappings to page mappings when needed
>> doesn't that cover some of these requirements? So perhaps you can do block
>> mappings even when some (all?) of these things are active?
> 
> I did look into some of them. I don't know too much about realm, so I can't tell.
> 
> But pagealloc will change kernel direct map to invalid when freeing page so it
> is called quite often. The pagealloc debug is typically not enabled for production.
> 
> Kfence will change it to invalid when allocating kfence object (typically when
> allocating slab), but kfence typically allocates and maps its pool very early on
> ARM64 and the pool is separate from direct map and mapped at PTE level. So IMHO
> I don't see to much value support large block mapping for them for now.

OK perhaps leave as is for now, and we can take a view on whether we want to
extend later as incremental patches.

> 
>>> +
>>>   static void __init map_mem(pgd_t *pgdp)
>>>   {
>>>       static const u64 direct_map_end = _PAGE_END(VA_BITS_MIN);
>>> @@ -645,9 +658,21 @@ static void __init map_mem(pgd_t *pgdp)
>>>         early_kfence_pool = arm64_kfence_alloc_pool();
>>>   -    if (can_set_direct_map())
>>> +    if (force_pte_mapping())
>>>           flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
>>>   +    /*
>>> +     * With FEAT_BBM level 2 we can split large block mapping without
>>> +     * making it invalid.  So kernel linear mapping can be mapped with
>>> +     * large block instead of PTE level.
>>> +     *
>>> +     * Need to break cont for CONT_MAPPINGS when changing permission,
>>> +     * and need to inspect the adjacent page table entries to make
>>> +     * them cont again later.  It sounds not worth the complexity.
>> I'm not sure I follow the argument? As far as I can tell, you only ever split
>> mappings. You never collapse. So I don't think it's too complex to check for
>> CONT bits and if set, clear the CONT bit from the block? That's a safe operation
>> with BBML2. It means you need to iterate over the ptes which you don't currently
>> do, but you only need to check a 1 PTE in every CONT_PTES.
> 
> Sorry for the confusion. Yes, I don't collapse. It seems I overthought this
> case, I thought I need to clear CONT bit for all PTEs in the block (for example,
> 16 PTEs). But it seems I just need to clear one PTE.

No you were right; you need to clear the CONT bit from all 16 PTEs in the block.
But since all PTEs in the block will either have CONT all set or all clear, you
only need to check 1 in every 16 PTEs. If that check shows that CONT is set, you
can clear the bit from the block that contains the PTE you checked. It will slow
down the split process though, because now you have to descend to the PTE table,
check 32 of the PTEs (512 / 16) and for any CONT blocks, clear the CONT bit.

Personally I think it's worth checking how much slower that is though, given you
already have a test case. In general, I've found that there is value in working
hard to keep the TLB usage as low as possible.

> 
>>> +     */
>>> +    if (rodata_full)
>>> +        flags |= NO_CONT_MAPPINGS;
>>> +
>>>       /*
>>>        * Take care not to create a writable alias for the
>>>        * read-only text and rodata sections of the kernel image.
>>> @@ -1342,9 +1367,12 @@ int arch_add_memory(int nid, u64 start, u64 size,
>>>         VM_BUG_ON(!mhp_range_allowed(start, size, true));
>>>   -    if (can_set_direct_map())
>>> +    if (force_pte_mapping())
>>>           flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
>>>   +    if (rodata_full)
>>> +        flags |= NO_CONT_MAPPINGS;
>>> +
>>>       __create_pgd_mapping(swapper_pg_dir, start, __phys_to_virt(start),
>>>                    size, params->pgprot, __pgd_pgtable_alloc,
>>>                    flags);
>>> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
>>> index 39fd1f7ff02a..ba2360ecb030 100644
>>> --- a/arch/arm64/mm/pageattr.c
>>> +++ b/arch/arm64/mm/pageattr.c
>>> @@ -49,6 +49,145 @@ static int change_page_range(pte_t *ptep, unsigned long
>>> addr, void *data)
>>>       return 0;
>>>   }
>>>   +static int __split_linear_mapping_pmd(pud_t *pudp,
>>> +                      unsigned long vaddr, unsigned long end)
>> nit: are the double really underscores needed?
> 
> No, not really.
> 
>>> +{
>>> +    pmd_t *pmdp;
>>> +    unsigned long next;
>>> +
>>> +    pmdp = pmd_offset(pudp, vaddr);
>>> +
>>> +    do {
>>> +        next = pmd_addr_end(vaddr, end);
>>> +
>>> +        if (pmd_leaf(pmdp_get(pmdp))) {
>>> +            struct page *pte_page;
>>> +            unsigned long pfn = pmd_pfn(pmdp_get(pmdp));
>>> +            pgprot_t prot = pmd_pgprot(pmdp_get(pmdp));
>>> +            pte_t *ptep_new;
>>> +            int i;
>>> +
>>> +            pte_page = alloc_page(GFP_KERNEL);
>>> +            if (!pte_page)
>>> +                return -ENOMEM;
>>> +
>>> +            prot = __pgprot(pgprot_val(prot) | PTE_TYPE_PAGE);
>>> +            ptep_new = (pte_t *)page_address(pte_page);
>>> +            for (i = 0; i < PTRS_PER_PTE; ++i, ++ptep_new)
>>> +                __set_pte_nosync(ptep_new,
>>> +                         pfn_pte(pfn + i, prot));
>>> +
>>> +            dsb(ishst);
>>> +            isb();
>>> +
>>> +            set_pmd(pmdp, pfn_pmd(page_to_pfn(pte_page),
>>> +                __pgprot(PMD_TYPE_TABLE)));
>> All the same comments that I made below for __split_linear_mapping_pud() apply
>> here.
> 
> Sure
> 
>>> +        }
>>> +    } while (pmdp++, vaddr = next, vaddr != end);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int __split_linear_mapping_pud(p4d_t *p4dp,
>>> +                      unsigned long vaddr, unsigned long end)
>>> +{
>>> +    pud_t *pudp;
>>> +    unsigned long next;
>>> +    int ret;
>>> +
>>> +    pudp = pud_offset(p4dp, vaddr);
>>> +
>>> +    do {
>>> +        next = pud_addr_end(vaddr, end);
>>> +
>>> +        if (pud_leaf(pudp_get(pudp))) {
>> Just do the pudp_get() once and cache the result. It's implemented by
>> READ_ONCE() so your 3 invocations are actually doing 3 separate loads.
> 
> Sure
> 
>>> +            struct page *pmd_page;
>>> +            unsigned long pfn = pud_pfn(pudp_get(pudp));
>>> +            pgprot_t prot = pud_pgprot(pudp_get(pudp));
>>> +            pmd_t *pmdp_new;
>>> +            int i;
>>> +            unsigned int step;
>>> +
>>> +            pmd_page = alloc_page(GFP_KERNEL);
>>> +            if (!pmd_page)
>>> +                return -ENOMEM;
>> Is this really how we allocate pgtable pages for kernel space? For user space we
>> have quite a lot of machinery for this.
> 
> The userspace page table allocation does something extra, for example,
>     - initialize ptlock
>     - set folio type
>     - update NR_PGTABLE counter
> 
> We don't need them for kernel direct map page table, so just took the most
> straightforward way. However, __get_free_page(GFP_PGTABLE_KERNEL) may be better
> than alloc_page(GFP_KERNEL). It is used by memory hotplug.

__create_pgd_mapping() takes a callback that it uses to allocate pgtable pages.
The initial linear map creation passes in early_pgtable_alloc(), which allocates
from memblock. I'm not sure if it's possible that we would ever need to split so
early that we need to use memblock too?

For late allocations, we have __pgd_pgtable_alloc() and pgd_pgtable_alloc(). The
latter constructs the ptdesc, although it's not completely clear to me when each
should be used. Both of those functions BUG_ON() memory allocation failure which
seems bad, especially given __pgd_pgtable_alloc() is used for mem hotplug, which
really should be returning an error. Ouch.

I think ideally we would rework __create_pgd_mapping() to be able to return an
error (so we can fix the mem hotplug issue), handle collapse, split and
permissions changes then use it universally. Or failing that,
__get_free_page(GFP_PGTABLE_KERNEL) is the second best option.

> 
>>> +
>>> +            pmdp_new = (pmd_t *)page_address(pmd_page);
>>> +            for (i = 0; i < PTRS_PER_PMD; ++i, ++pmdp_new) {
>>> +                step = (i * PMD_SIZE) >> PAGE_SHIFT;
>> Suggest hoisting this out of the loop, then just increment pfn by step every
>> iteration.
> 
> Yeah, sure
> 
>>> +                __set_pmd_nosync(pmdp_new,
>>> +                         pfn_pmd(pfn + step, prot));
>>> +            }
>>> +
>>> +            dsb(ishst);
>>> +            isb();
>> I'm not convinced by the need for this isb(). The dsb ensures that the table is
>> visible to the table walker; that's needed. The isb() present in set_pmd() and
>> friends to remove any "cached" speculative invalid translation marker from the
>> pipeline, if I understand things correctly. I don't think we need to solve that
>> problem here because you weren't working on a live table. The isb() in set_pud()
>> is sufficient, I think.
> 
> I see, we just need one isb() when the table becomes reachable. Will remove it
> and the isb() in __split_linear_mapping_pmd().
> >>> +
>>> +            set_pud(pudp, pfn_pud(page_to_pfn(pmd_page),
>>> +                __pgprot(PUD_TYPE_TABLE)));
>>> +        }
>>> +
>>> +        ret = __split_linear_mapping_pmd(pudp, vaddr, next);
>>> +        if (ret)
>>> +            return ret;
>>> +    } while (pudp++, vaddr = next, vaddr != end);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int __split_linear_mapping_p4d(pgd_t *pgdp,
>>> +                      unsigned long vaddr, unsigned long end)
>>> +{
>>> +    p4d_t *p4dp;
>>> +    unsigned long next;
>>> +    int ret;
>>> +
>>> +    p4dp = p4d_offset(pgdp, vaddr);
>>> +
>>> +    do {
>>> +        next = p4d_addr_end(vaddr, end);
>>> +
>>> +        ret = __split_linear_mapping_pud(p4dp, vaddr, next);
>>> +        if (ret)
>>> +            return ret;
>> nit: personally I would make this break. Then have single "return ret", like you
>> have for __split_linear_mapping_pgd(). Then all levels follow the same template.
> 
> Sure
> 
>>> +    } while (p4dp++, vaddr = next, vaddr != end);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int __split_linear_mapping_pgd(pgd_t *pgdp,
>>> +                      unsigned long vaddr,
>>> +                      unsigned long end)
>>> +{> +    unsigned long next;
>>> +    int ret = 0;
>>> +
>>> +    mmap_write_lock(&init_mm);
>> nit: I think the locking would be more natural in split_linear_mapping().
> 
> OK
> 
>>> +
>>> +    do {
>>> +        next = pgd_addr_end(vaddr, end);
>>> +        ret = __split_linear_mapping_p4d(pgdp, vaddr, next);
>>> +        if (ret)
>>> +            break;
>>> +    } while (pgdp++, vaddr = next, vaddr != end);
>>> +
>>> +    mmap_write_unlock(&init_mm);
>>> +
>>> +    return ret;
>>> +}
>>> +
>>> +static int split_linear_mapping(unsigned long start, unsigned long end)
>> As far as I can tell, you only ever split the linear mapping. You never collapse
>> it. In that case, won't it just degrade to pte-mappings over time? I suspect you
>> should aim to detect collapse opportunities.
> 
> In theory there may be kernel linear mapping fragmentation problem, for example,
> huge number of modules are loaded, but I've never heard of anyone reported this
> as a real issue. And AFAICT, no architecture supports this for now.

I'm not really talking about fragmentation. I'm talking about allocating
different portions of the linear map over time and having to split the mapping
down to ptes due to changing permissions. Over time this will tend towards the
entire linear map being pte mapped if you don't proactively collapse too?

I accept this is unlikely to happen due to module loading since you tend to load
the modules at boot and they stay loaded. But what about other features that
cause the linear map permissions to be changed? e.g. secret mem, bpf programs
being loaded, guest_memfd (although I don't think that's upstream yet).

> 
>>> +{
>>> +    int ret;
>>> +
>>> +    if (!system_supports_bbmlv2())
>>> +        return 0;
>>> +
>>> +    ret = __split_linear_mapping_pgd(pgd_offset_k(start), start, end);
>> nit: personally I would put pgd_offset_k() into __split_linear_mapping_pgd() so
>> that it takes the exact same form as the other levels. Or mege
>> __split_linear_mapping_pgd() into split_linear_mapping().
> 
> OK, I will clean it up
> 
>>> +    flush_tlb_kernel_range(start, end);
>>> +
>>> +    return ret;
>>> +}
>>> +
>>>   /*
>>>    * This function assumes that the range is mapped with PAGE_SIZE pages.
>>>    */
>>> @@ -80,8 +219,9 @@ static int change_memory_common(unsigned long addr, int
>>> numpages,
>>>       unsigned long start = addr;
>>>       unsigned long size = PAGE_SIZE * numpages;
>>>       unsigned long end = start + size;
>>> +    unsigned long l_start;
>>>       struct vm_struct *area;
>>> -    int i;
>>> +    int i, ret;
>>>         if (!PAGE_ALIGNED(addr)) {
>>>           start &= PAGE_MASK;
>>> @@ -118,7 +258,12 @@ static int change_memory_common(unsigned long addr, int
>>> numpages,
>>>       if (rodata_full && (pgprot_val(set_mask) == PTE_RDONLY ||
>>>                   pgprot_val(clear_mask) == PTE_RDONLY)) {
>>>           for (i = 0; i < area->nr_pages; i++) {
>>> -            __change_memory_common((u64)page_address(area->pages[i]),
>>> +            l_start = (u64)page_address(area->pages[i]);
>>> +            ret = split_linear_mapping(l_start, l_start + PAGE_SIZE);
>>> +            if (WARN_ON_ONCE(ret))
>>> +                return ret;
>>> +
>>> +            __change_memory_common(l_start,
>>>                              PAGE_SIZE, set_mask, clear_mask);
>>>           }
>>>       }
>>> @@ -174,6 +319,9 @@ int set_memory_valid(unsigned long addr, int numpages,
>>> int enable)
>> set_memory_valid() actually calls __change_memory_common() directly (so it
>> bypassed the split logic in change_memory_common()). Is it possible that it gets
>> called for a non-split region? I guess you'll need to handle that case too?
> 
> The set_memopry_valid() is called in the below places:
>     - kfence: it requires map at PTE level regardless of kfence_early_init or not
>     - pagealloc debug: it requires map at PTE level too
>     - execmem ROX cache: it seems like only x86 supports this right now
> 
> I don't think we are going to support large block mapping for direct map for
> pagealloc debug and kfence as I said above. We need make set_memory_valid()
> split page table when execmem ROX supported is added for arm64. But we don't
> need do it right now.

Fair enough.

Thanks,
Ryan

> 
> Thanks,
> Yang
> 
>> Thanks,
>> Ryan
>>
>>>     int set_direct_map_invalid_noflush(struct page *page)
>>>   {
>>> +    unsigned long l_start;
>>> +    int ret;
>>> +
>>>       struct page_change_data data = {
>>>           .set_mask = __pgprot(0),
>>>           .clear_mask = __pgprot(PTE_VALID),
>>> @@ -182,13 +330,21 @@ int set_direct_map_invalid_noflush(struct page *page)
>>>       if (!can_set_direct_map())
>>>           return 0;
>>>   +    l_start = (unsigned long)page_address(page);
>>> +    ret = split_linear_mapping(l_start, l_start + PAGE_SIZE);
>>> +    if (WARN_ON_ONCE(ret))
>>> +        return ret;
>>> +
>>>       return apply_to_page_range(&init_mm,
>>> -                   (unsigned long)page_address(page),
>>> -                   PAGE_SIZE, change_page_range, &data);
>>> +                   l_start, PAGE_SIZE, change_page_range,
>>> +                   &data);
>>>   }
>>>     int set_direct_map_default_noflush(struct page *page)
>>>   {
>>> +    unsigned long l_start;
>>> +    int ret;
>>> +
>>>       struct page_change_data data = {
>>>           .set_mask = __pgprot(PTE_VALID | PTE_WRITE),
>>>           .clear_mask = __pgprot(PTE_RDONLY),
>>> @@ -197,9 +353,14 @@ int set_direct_map_default_noflush(struct page *page)
>>>       if (!can_set_direct_map())
>>>           return 0;
>>>   +    l_start = (unsigned long)page_address(page);
>>> +    ret = split_linear_mapping(l_start, l_start + PAGE_SIZE);
>>> +    if (WARN_ON_ONCE(ret))
>>> +        return ret;
>>> +
>>>       return apply_to_page_range(&init_mm,
>>> -                   (unsigned long)page_address(page),
>>> -                   PAGE_SIZE, change_page_range, &data);
>>> +                   l_start, PAGE_SIZE, change_page_range,
>>> +                   &data);
>>>   }
>>>     static int __set_memory_enc_dec(unsigned long addr,
> 


