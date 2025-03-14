Return-Path: <linux-kernel+bounces-561494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF456A612A5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 14:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F294346231B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 13:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977251FF7B8;
	Fri, 14 Mar 2025 13:29:13 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6600C12FF6F
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 13:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741958952; cv=none; b=JK658rT84wTZmxQJDiBJAbvliwj6YllNCjK2ub54G9Zmqu2LPpYeFUDMZ9G2KuRZv2VNoCmQpcR3WDujpJou95+9aw3SUhPyOSAekCF9D3H9FjxDn6fXeKC88Q2Jx5ikI1QRnnk8ueEs4iwY4PENgRuoW8PTaQimBMT3UN5rPyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741958952; c=relaxed/simple;
	bh=c0XpQDsTNNGbWmWUg60jwWLokGJjl+/qKWv0aVFa0bI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eV4+awPgbtXM/K8Ea06c6JyBkjLdQ9raE/run9yCrlVgC2GwYpLrrMqKNBEdtcB9CrCsY5EPnTCZ9pBJy78lyUZhAgBpn9twO01JwxoSFsd9S478wtMuGepMNHk8NGDns8mansGeIaOa5eQ/Co/dBZER+tSAzXnfmoSkrhDXi/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3F971424;
	Fri, 14 Mar 2025 06:29:19 -0700 (PDT)
Received: from [10.57.85.159] (unknown [10.57.85.159])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E0D5F3F673;
	Fri, 14 Mar 2025 06:29:06 -0700 (PDT)
Message-ID: <f745ab79-55e7-406a-a3cb-9f85fa461444@arm.com>
Date: Fri, 14 Mar 2025 13:29:05 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v3 PATCH 4/6] arm64: mm: support large block mapping when
 rodata=full
Content-Language: en-GB
To: Yang Shi <yang@os.amperecomputing.com>, will@kernel.org,
 catalin.marinas@arm.com, Miko.Lenczewski@arm.com,
 scott@os.amperecomputing.com, cl@gentwo.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250304222018.615808-1-yang@os.amperecomputing.com>
 <20250304222018.615808-5-yang@os.amperecomputing.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20250304222018.615808-5-yang@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/03/2025 22:19, Yang Shi wrote:
> When rodata=full is specified, kernel linear mapping has to be mapped at
> PTE level since large page table can't be split due to break-before-make
> rule on ARM64.
> 
> This resulted in a couple of problems:
>   - performance degradation
>   - more TLB pressure
>   - memory waste for kernel page table
> 
> With FEAT_BBM level 2 support, splitting large block page table to
> smaller ones doesn't need to make the page table entry invalid anymore.
> This allows kernel split large block mapping on the fly.
> 
> Add kernel page table split support and use large block mapping by
> default when FEAT_BBM level 2 is supported for rodata=full.  When
> changing permissions for kernel linear mapping, the page table will be
> split to PTE level.
> 
> The machine without FEAT_BBM level 2 will fallback to have kernel linear
> mapping PTE-mapped when rodata=full.
> 
> With this we saw significant performance boost with some benchmarks and
> much less memory consumption on my AmpereOne machine (192 cores, 1P) with
> 256GB memory.
> 
> * Memory use after boot
> Before:
> MemTotal:       258988984 kB
> MemFree:        254821700 kB
> 
> After:
> MemTotal:       259505132 kB
> MemFree:        255410264 kB
> 
> Around 500MB more memory are free to use.  The larger the machine, the
> more memory saved.
> 
> * Memcached
> We saw performance degradation when running Memcached benchmark with
> rodata=full vs rodata=on.  Our profiling pointed to kernel TLB pressure.
> With this patchset we saw ops/sec is increased by around 3.5%, P99
> latency is reduced by around 9.6%.
> The gain mainly came from reduced kernel TLB misses.  The kernel TLB
> MPKI is reduced by 28.5%.
> 
> The benchmark data is now on par with rodata=on too.
> 
> * Disk encryption (dm-crypt) benchmark
> Ran fio benchmark with the below command on a 128G ramdisk (ext4) with disk
> encryption (by dm-crypt).
> fio --directory=/data --random_generator=lfsr --norandommap --randrepeat 1 \
>     --status-interval=999 --rw=write --bs=4k --loops=1 --ioengine=sync \
>     --iodepth=1 --numjobs=1 --fsync_on_close=1 --group_reporting --thread \
>     --name=iops-test-job --eta-newline=1 --size 100G
> 
> The IOPS is increased by 90% - 150% (the variance is high, but the worst
> number of good case is around 90% more than the best number of bad case).
> The bandwidth is increased and the avg clat is reduced proportionally.
> 
> * Sequential file read
> Read 100G file sequentially on XFS (xfs_io read with page cache populated).
> The bandwidth is increased by 150%.
> 
> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
> ---
>  arch/arm64/include/asm/cpufeature.h |  10 ++
>  arch/arm64/include/asm/mmu.h        |   1 +
>  arch/arm64/include/asm/pgtable.h    |   7 +-
>  arch/arm64/kernel/cpufeature.c      |   2 +-
>  arch/arm64/mm/mmu.c                 | 169 +++++++++++++++++++++++++++-
>  arch/arm64/mm/pageattr.c            |  35 +++++-
>  6 files changed, 211 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index 108ef3fbbc00..e24edc32b0bd 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -871,6 +871,16 @@ static inline bool system_supports_bbml2_noabort(void)
>  	return alternative_has_cap_unlikely(ARM64_HAS_BBML2_NOABORT);
>  }
>  
> +bool cpu_has_bbml2_noabort(unsigned int cpu_midr);
> +/*
> + * Called at early boot stage on boot CPU before cpu info and cpu feature
> + * are ready.
> + */
> +static inline bool bbml2_noabort_available(void)
> +{
> +	return cpu_has_bbml2_noabort(read_cpuid_id());

You'll want to incorporate the IS_ENABLED(CONFIG_ARM64_BBML2_NOABORT) and
arm64_test_sw_feature_override(ARM64_SW_FEATURE_OVERRIDE_NOBBML2) checks from
Miko's new series to avoid block mappings when BBML2 is disabled. (that second
check will change a bit based on Maz's feedback against Miko's v3).

Hopefully we can factor out into a common helper that is used by Miko's stuff too?

> +}
> +
>  int do_emulate_mrs(struct pt_regs *regs, u32 sys_reg, u32 rt);
>  bool try_emulate_mrs(struct pt_regs *regs, u32 isn);
>  
> diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
> index 662471cfc536..d658a33df266 100644
> --- a/arch/arm64/include/asm/mmu.h
> +++ b/arch/arm64/include/asm/mmu.h
> @@ -71,6 +71,7 @@ extern void create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
>  			       pgprot_t prot, bool page_mappings_only);
>  extern void *fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t prot);
>  extern void mark_linear_text_alias_ro(void);
> +extern int split_linear_mapping(unsigned long start, unsigned long end);
>  
>  /*
>   * This check is triggered during the early boot before the cpufeature
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 0b2a2ad1b9e8..ed2fc1dcf7ae 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -749,7 +749,7 @@ static inline bool in_swapper_pgdir(void *addr)
>  	        ((unsigned long)swapper_pg_dir & PAGE_MASK);
>  }
>  
> -static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
> +static inline void __set_pmd_nosync(pmd_t *pmdp, pmd_t pmd)
>  {
>  #ifdef __PAGETABLE_PMD_FOLDED
>  	if (in_swapper_pgdir(pmdp)) {
> @@ -759,6 +759,11 @@ static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
>  #endif /* __PAGETABLE_PMD_FOLDED */
>  
>  	WRITE_ONCE(*pmdp, pmd);
> +}
> +
> +static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
> +{
> +	__set_pmd_nosync(pmdp, pmd);
>  
>  	if (pmd_valid(pmd)) {
>  		dsb(ishst);
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index bf3df8407ca3..d39637d5aeab 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -2176,7 +2176,7 @@ static bool hvhe_possible(const struct arm64_cpu_capabilities *entry,
>  	return arm64_test_sw_feature_override(ARM64_SW_FEATURE_OVERRIDE_HVHE);
>  }
>  
> -static bool cpu_has_bbml2_noabort(unsigned int cpu_midr)
> +bool cpu_has_bbml2_noabort(unsigned int cpu_midr)
>  {
>  	/* We want to allow usage of bbml2 in as wide a range of kernel contexts
>  	 * as possible. This list is therefore an allow-list of known-good
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index dccf0877285b..ad0f1cc55e3a 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -45,6 +45,7 @@
>  #define NO_BLOCK_MAPPINGS	BIT(0)
>  #define NO_CONT_MAPPINGS	BIT(1)
>  #define NO_EXEC_MAPPINGS	BIT(2)	/* assumes FEAT_HPDS is not used */
> +#define SPLIT_MAPPINGS		BIT(3)
>  
>  u64 kimage_voffset __ro_after_init;
>  EXPORT_SYMBOL(kimage_voffset);
> @@ -166,6 +167,73 @@ static void init_clear_pgtable(void *table)
>  	dsb(ishst);
>  }
>  
> +static int split_pmd(pmd_t *pmdp, pmd_t pmdval,
> +		     phys_addr_t (*pgtable_alloc)(int))
> +{
> +	unsigned long pfn;
> +	pgprot_t prot;
> +	phys_addr_t pte_phys;
> +	pte_t *ptep;
> +
> +	if (!pmd_leaf(pmdval))
> +		return 0;
> +
> +	pfn = pmd_pfn(pmdval);
> +	prot = pmd_pgprot(pmdval);
> +
> +	pte_phys = pgtable_alloc(PAGE_SHIFT);
> +	if (!pte_phys)
> +		return -ENOMEM;
> +
> +	ptep = (pte_t *)phys_to_virt(pte_phys);
> +	init_clear_pgtable(ptep);

No need for this, you're about to fill the table with ptes so clearing it is a
waste of time.

> +	prot = __pgprot(pgprot_val(prot) | PTE_TYPE_PAGE);

This happen to work for D64 pgtables because of the way the bits are arranged.
But it won't work for D128 (when we get there). We are in the process of
cleaning up the code base to make it D128 ready. So let's fix this now:

	prot = __pgprot(pgprot_val(prot) & ~PMD_TYPE_MASK) | PTE_TYPE_PAGE);

nit: I'd move this up, next to the "prot = pmd_pgprot(pmdval);" line.

> +	for (int i = 0; i < PTRS_PER_PTE; i++, ptep++)
> +		__set_pte_nosync(ptep, pfn_pte(pfn + i, prot));

nit: you're incrementing ptep but adding i to pfn. Why not just increment pfn too?

> +
> +	dsb(ishst);
> +
> +	set_pmd(pmdp, pfn_pmd(__phys_to_pfn(pte_phys),
> +		__pgprot(PMD_TYPE_TABLE)));

You're missing some required pgprot flags and it would be better to follow what
alloc_init_cont_pte() does in general. Something like:

	pmdval = PMD_TYPE_TABLE | PMD_TABLE_UXN | PMD_TABLE_AF;
	if (flags & NO_EXEC_MAPPINGS)
		pmdval |= PMD_TABLE_PXN;
	__pmd_populate(pmdp, pte_phys, pmdval);

> +
> +	return 0;
> +}
> +
> +static int split_pud(pud_t *pudp, pud_t pudval,
> +		     phys_addr_t (*pgtable_alloc)(int))

All the same comments for split_pmd() apply here too.

> +{
> +	unsigned long pfn;
> +	pgprot_t prot;
> +	pmd_t *pmdp;
> +	phys_addr_t pmd_phys;
> +	unsigned int step;
> +
> +	if (!pud_leaf(pudval))
> +		return 0;
> +
> +	pfn = pud_pfn(pudval);
> +	prot = pud_pgprot(pudval);
> +	step = PMD_SIZE >> PAGE_SHIFT;
> +
> +	pmd_phys = pgtable_alloc(PMD_SHIFT);
> +	if (!pmd_phys)
> +		return -ENOMEM;
> +
> +	pmdp = (pmd_t *)phys_to_virt(pmd_phys);
> +	init_clear_pgtable(pmdp);
> +	for (int i = 0; i < PTRS_PER_PMD; i++, pmdp++) {
> +		__set_pmd_nosync(pmdp, pfn_pmd(pfn, prot));
> +		pfn += step;
> +	}
> +
> +	dsb(ishst);
> +
> +	set_pud(pudp, pfn_pud(__phys_to_pfn(pmd_phys),
> +		__pgprot(PUD_TYPE_TABLE)));
> +
> +	return 0;
> +}
> +
>  static void init_pte(pte_t *ptep, unsigned long addr, unsigned long end,
>  		     phys_addr_t phys, pgprot_t prot)
>  {
> @@ -251,12 +319,21 @@ static int init_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end,
>  {
>  	unsigned long next;
>  	int ret = 0;
> +	bool split = flags & SPLIT_MAPPINGS;
>  
>  	do {
>  		pmd_t old_pmd = READ_ONCE(*pmdp);
>  
>  		next = pmd_addr_end(addr, end);
>  
> +		if (split) {

I think this should be:

		if (flags & SPLIT_MAPPINGS &&
		    pmd_leaf(old_pmd) &&
		    next < addr + PMD_SIZE) {

So we only attempt a split if its a leaf and the leaf is not fully contained by
the range. Your current code is always splitting even if the block mapping is
fully contained which seems a waste. And if the pmd is not a leaf (either not
present or a table) split_pmd will currently do nothing and return 0, so there
is no opportunity to install mappings or visit the ptes.

> +			ret = split_pmd(pmdp, old_pmd, pgtable_alloc);

But... do we need the special split_pmd() and split_pud() functions at all?
Can't we just allocate a new table here, then let the existing code populate it,
then replace the block mapping with the table mapping? Same goes for huge puds.
If you take this approach, I think a lot of the code below will significantly
simplify.

> +			if (ret)
> +				break;
> +
> +			continue;
> +		}
> +
>  		/* try section mapping first */
>  		if (((addr | next | phys) & ~PMD_MASK) == 0 &&
>  		    (flags & NO_BLOCK_MAPPINGS) == 0) {

You'll want to modify this last bit to avoid setting up a block mapping if we
are trying to split?

		    (flags & (NO_BLOCK_MAPPINGS | SPLIT_MAPPINGS) == 0) {

Or perhaps it's an error to call this without NO_BLOCK_MAPPINGS if
SPLIT_MAPPINGS is specified? Or perhaps we don't even need SPLIT_MAPPINGS, and
NO_BLOCK_MAPPINGS means we will split if we find any block mappings? (similarly
for NO_CONT_MAPPINGS)?

> @@ -292,11 +369,19 @@ static int alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
>  	int ret = 0;
>  	pud_t pud = READ_ONCE(*pudp);
>  	pmd_t *pmdp;
> +	bool split = flags & SPLIT_MAPPINGS;
>  
>  	/*
>  	 * Check for initial section mappings in the pgd/pud.
>  	 */
>  	BUG_ON(pud_sect(pud));
> +
> +	if (split) {
> +		BUG_ON(pud_none(pud));
> +		pmdp = pmd_offset(pudp, addr);
> +		goto split_pgtable;
> +	}
> +
>  	if (pud_none(pud)) {
>  		pudval_t pudval = PUD_TYPE_TABLE | PUD_TABLE_UXN | PUD_TABLE_AF;
>  		phys_addr_t pmd_phys;
> @@ -316,6 +401,7 @@ static int alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
>  		pmdp = pmd_set_fixmap_offset(pudp, addr);
>  	}
>  
> +split_pgtable:
>  	do {
>  		pgprot_t __prot = prot;
>  
> @@ -334,7 +420,8 @@ static int alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
>  		phys += next - addr;
>  	} while (addr = next, addr != end);
>  
> -	pmd_clear_fixmap();
> +	if (!split)
> +		pmd_clear_fixmap();
>  
>  	return ret;
>  }
> @@ -348,6 +435,13 @@ static int alloc_init_pud(p4d_t *p4dp, unsigned long addr, unsigned long end,
>  	int ret = 0;
>  	p4d_t p4d = READ_ONCE(*p4dp);
>  	pud_t *pudp;
> +	bool split = flags & SPLIT_MAPPINGS;
> +
> +	if (split) {
> +		BUG_ON(p4d_none(p4d));
> +		pudp = pud_offset(p4dp, addr);
> +		goto split_pgtable;
> +	}
>  
>  	if (p4d_none(p4d)) {
>  		p4dval_t p4dval = P4D_TYPE_TABLE | P4D_TABLE_UXN | P4D_TABLE_AF;
> @@ -368,11 +462,25 @@ static int alloc_init_pud(p4d_t *p4dp, unsigned long addr, unsigned long end,
>  		pudp = pud_set_fixmap_offset(p4dp, addr);
>  	}
>  
> +split_pgtable:
>  	do {
>  		pud_t old_pud = READ_ONCE(*pudp);
>  
>  		next = pud_addr_end(addr, end);
>  
> +		if (split) {
> +			ret = split_pud(pudp, old_pud, pgtable_alloc);
> +			if (ret)
> +				break;
> +
> +			ret = alloc_init_cont_pmd(pudp, addr, next, phys, prot,
> +						  pgtable_alloc, flags);
> +			if (ret)
> +				break;
> +
> +			continue;
> +		}
> +
>  		/*
>  		 * For 4K granule only, attempt to put down a 1GB block
>  		 */
> @@ -399,7 +507,8 @@ static int alloc_init_pud(p4d_t *p4dp, unsigned long addr, unsigned long end,
>  		phys += next - addr;
>  	} while (pudp++, addr = next, addr != end);
>  
> -	pud_clear_fixmap();
> +	if (!split)
> +		pud_clear_fixmap();
>  
>  	return ret;
>  }
> @@ -413,6 +522,13 @@ static int alloc_init_p4d(pgd_t *pgdp, unsigned long addr, unsigned long end,
>  	int ret = 0;
>  	pgd_t pgd = READ_ONCE(*pgdp);
>  	p4d_t *p4dp;
> +	bool split = flags & SPLIT_MAPPINGS;
> +
> +	if (split) {
> +		BUG_ON(pgd_none(pgd));
> +		p4dp = p4d_offset(pgdp, addr);
> +		goto split_pgtable;
> +	}
>  
>  	if (pgd_none(pgd)) {
>  		pgdval_t pgdval = PGD_TYPE_TABLE | PGD_TABLE_UXN | PGD_TABLE_AF;
> @@ -433,6 +549,7 @@ static int alloc_init_p4d(pgd_t *pgdp, unsigned long addr, unsigned long end,
>  		p4dp = p4d_set_fixmap_offset(pgdp, addr);
>  	}
>  
> +split_pgtable:
>  	do {
>  		p4d_t old_p4d = READ_ONCE(*p4dp);
>  
> @@ -449,7 +566,8 @@ static int alloc_init_p4d(pgd_t *pgdp, unsigned long addr, unsigned long end,
>  		phys += next - addr;
>  	} while (p4dp++, addr = next, addr != end);
>  
> -	p4d_clear_fixmap();
> +	if (!split)
> +		p4d_clear_fixmap();
>  
>  	return ret;
>  }
> @@ -546,6 +664,23 @@ static phys_addr_t pgd_pgtable_alloc(int shift)
>  	return pa;
>  }
>  
> +int split_linear_mapping(unsigned long start, unsigned long end)
> +{
> +	int ret = 0;
> +
> +	if (!system_supports_bbml2_noabort())
> +		return 0;
> +
> +	mmap_write_lock(&init_mm);
> +	ret = __create_pgd_mapping_locked(init_mm.pgd, virt_to_phys((void *)start),
> +					  start, (end - start), __pgprot(0),
> +					  __pgd_pgtable_alloc, SPLIT_MAPPINGS);
> +	mmap_write_unlock(&init_mm);
> +	flush_tlb_kernel_range(start, end);
> +
> +	return ret;
> +}
> +
>  /*
>   * This function can only be used to modify existing table entries,
>   * without allocating new levels of table. Note that this permits the
> @@ -665,6 +800,24 @@ static inline void arm64_kfence_map_pool(phys_addr_t kfence_pool, pgd_t *pgdp) {
>  
>  #endif /* CONFIG_KFENCE */
>  
> +static inline bool force_pte_mapping(void)
> +{
> +	/*
> +	 * Can't use cpufeature API to determine whether BBML2 supported
> +	 * or not since cpufeature have not been finalized yet.
> +	 *
> +	 * Checking the boot CPU only for now.  If the boot CPU has
> +	 * BBML2, paint linear mapping with block mapping.  If it turns
> +	 * out the secondary CPUs don't support BBML2 once cpufeature is
> +	 * fininalized, the linear mapping will be repainted with PTE
> +	 * mapping.
> +	 */
> +	return (rodata_full && !bbml2_noabort_available()) ||
> +		debug_pagealloc_enabled() ||
> +		arm64_kfence_can_set_direct_map() ||
> +		is_realm_world();
> +}
> +
>  static void __init map_mem(pgd_t *pgdp)
>  {
>  	static const u64 direct_map_end = _PAGE_END(VA_BITS_MIN);
> @@ -690,9 +843,12 @@ static void __init map_mem(pgd_t *pgdp)
>  
>  	early_kfence_pool = arm64_kfence_alloc_pool();
>  
> -	if (can_set_direct_map())
> +	if (force_pte_mapping())
>  		flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
>  
> +	if (rodata_full)
> +		flags |= NO_CONT_MAPPINGS;
> +
>  	/*
>  	 * Take care not to create a writable alias for the
>  	 * read-only text and rodata sections of the kernel image.
> @@ -1388,9 +1544,12 @@ int arch_add_memory(int nid, u64 start, u64 size,
>  
>  	VM_BUG_ON(!mhp_range_allowed(start, size, true));
>  
> -	if (can_set_direct_map())
> +	if (force_pte_mapping())
>  		flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
>  
> +	if (rodata_full)
> +		flags |= NO_CONT_MAPPINGS;
> +
>  	__create_pgd_mapping(swapper_pg_dir, start, __phys_to_virt(start),
>  			     size, params->pgprot, __pgd_pgtable_alloc,
>  			     flags);
> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
> index 39fd1f7ff02a..5d42d87ea7e1 100644
> --- a/arch/arm64/mm/pageattr.c
> +++ b/arch/arm64/mm/pageattr.c
> @@ -10,6 +10,7 @@
>  #include <linux/vmalloc.h>
>  
>  #include <asm/cacheflush.h>
> +#include <asm/mmu.h>
>  #include <asm/pgtable-prot.h>
>  #include <asm/set_memory.h>
>  #include <asm/tlbflush.h>
> @@ -80,8 +81,9 @@ static int change_memory_common(unsigned long addr, int numpages,
>  	unsigned long start = addr;
>  	unsigned long size = PAGE_SIZE * numpages;
>  	unsigned long end = start + size;
> +	unsigned long l_start;
>  	struct vm_struct *area;
> -	int i;
> +	int i, ret;
>  
>  	if (!PAGE_ALIGNED(addr)) {
>  		start &= PAGE_MASK;
> @@ -118,7 +120,12 @@ static int change_memory_common(unsigned long addr, int numpages,
>  	if (rodata_full && (pgprot_val(set_mask) == PTE_RDONLY ||
>  			    pgprot_val(clear_mask) == PTE_RDONLY)) {
>  		for (i = 0; i < area->nr_pages; i++) {
> -			__change_memory_common((u64)page_address(area->pages[i]),
> +			l_start = (u64)page_address(area->pages[i]);
> +			ret = split_linear_mapping(l_start, l_start + PAGE_SIZE);

This isn't quite aligned with how I was thinking about it. You still have 2
passes here; one to split the range to base pages, then another to modify the
permissions.

I was thinking we could use the table walker in mmu.c to achieve 2 benefits:

  - Do both operations in a single pass (a bit like how calling
update_mapping_prot() will update the protections on an existing mapping, and
the table walker will split when it comes across a huge page)

  - Only split when needed; if the whole huge page is contained within the
range, then there is no need to split in the first place.

We could then split vmalloc regions for free using this infrastructure too.

Although there is a wrinkle that the mmu.c table walker only accepts a pgprot
and can't currently handle a set_mask/clear_mask. I guess that could be added,
but it starts to get a bit busy. I think this generic infra would be useful
though. What do you think?

[...]

Thanks,
Ryan


