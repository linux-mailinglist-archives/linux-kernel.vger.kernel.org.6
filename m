Return-Path: <linux-kernel+bounces-239941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C54992670B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 19:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 818181F2328D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 17:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0351B1849DF;
	Wed,  3 Jul 2024 17:25:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F6618308F
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 17:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720027517; cv=none; b=skoNmr09Qh/W5g8QdQSryRWWiRAk6ik4zVaPrPlNydB7UR5RKRompVARAecExLgmzh9QOxKPMjKQpewByL/4KVhS9ugJWRGwEi9NAVQvK8vgQKRQa4RFGaKWZfgRGQQVpVK+t+qiT0tU3sM6eAWawVl8hUsvYSRmRFl++vRtmyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720027517; c=relaxed/simple;
	bh=CGCtfY8+GED9Yud+kbO6It7oLF4kZojOflQr/uMk55I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f2ux1uFgOOOT5rId3LlbDWEYTLJs/dkKSe1pBfDJgnQvjZuxjQobxG48EP58L/ZPz+uByC0cRex7Q+MLkwcT1cDIy3iBQx6VEIjuNC42Bis0bCJ6zr7iDhUSWNV4MNcqdvOcIuPTykFSCx8ChKrAloGjU9ECcrVkMIzXcSCPJoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D2B2367;
	Wed,  3 Jul 2024 10:25:38 -0700 (PDT)
Received: from [10.57.74.76] (unknown [10.57.74.76])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1F9AC3F762;
	Wed,  3 Jul 2024 10:25:09 -0700 (PDT)
Message-ID: <65c37315-2741-481f-b433-cec35ef1af35@arm.com>
Date: Wed, 3 Jul 2024 18:25:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/6] mm: shmem: add mTHP support for anonymous shmem
Content-Language: en-GB
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
 hughd@google.com
Cc: willy@infradead.org, david@redhat.com, wangkefeng.wang@huawei.com,
 ying.huang@intel.com, 21cnbao@gmail.com, shy828301@gmail.com,
 ziy@nvidia.com, ioworker0@gmail.com, da.gomez@samsung.com,
 p.raghav@samsung.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1718090413.git.baolin.wang@linux.alibaba.com>
 <65796c1e72e51e15f3410195b5c2d5b6c160d411.1718090413.git.baolin.wang@linux.alibaba.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <65796c1e72e51e15f3410195b5c2d5b6c160d411.1718090413.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/06/2024 11:11, Baolin Wang wrote:
> Commit 19eaf44954df adds multi-size THP (mTHP) for anonymous pages, that
> can allow THP to be configured through the sysfs interface located at
> '/sys/kernel/mm/transparent_hugepage/hugepage-XXkb/enabled'.
> 
> However, the anonymous shmem will ignore the anonymous mTHP rule
> configured through the sysfs interface, and can only use the PMD-mapped
> THP, that is not reasonable. Users expect to apply the mTHP rule for
> all anonymous pages, including the anonymous shmem, in order to enjoy
> the benefits of mTHP. For example, lower latency than PMD-mapped THP,
> smaller memory bloat than PMD-mapped THP, contiguous PTEs on ARM architecture
> to reduce TLB miss etc. In addition, the mTHP interfaces can be extended
> to support all shmem/tmpfs scenarios in the future, especially for the
> shmem mmap() case.
> 
> The primary strategy is similar to supporting anonymous mTHP. Introduce
> a new interface '/mm/transparent_hugepage/hugepage-XXkb/shmem_enabled',
> which can have almost the same values as the top-level
> '/sys/kernel/mm/transparent_hugepage/shmem_enabled', with adding a new
> additional "inherit" option and dropping the testing options 'force' and
> 'deny'. By default all sizes will be set to "never" except PMD size,
> which is set to "inherit". This ensures backward compatibility with the
> anonymous shmem enabled of the top level, meanwhile also allows independent
> control of anonymous shmem enabled for each mTHP.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

[...]

Hi Baolin,

I'm currently trying to fix a bug where khugepaged is not started if only shmem
is enabled for THP. See discussion at [1]. It's been broken like this forever.

Assuming anon and shmem THP are initially both disabled:

# echo never > /sys/kernel/mm/transparent_hugepage/shmem_enabled
# echo never > /sys/kernel/mm/transparent_hugepage/enabled
<khugepaged is stopped here>

Then shemem THP is enabled:

# echo always > /sys/kernel/mm/transparent_hugepage/shmem_enabled
<khugepaged is not started, this is a bug>

As part of investigating the fix, I stumbled upon this patch, which I remember
reviewing an early version of but I've been out for a while and missed the
latter versions. See below for comments and questions; the answers to which will
help me figure out how to fix the above...

[1] https://lore.kernel.org/linux-mm/20240702144617.2291480-1-ryan.roberts@arm.com/


>  
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +static unsigned long shmem_allowable_huge_orders(struct inode *inode,
> +				struct vm_area_struct *vma, pgoff_t index,
> +				bool global_huge)
> +{
> +	unsigned long mask = READ_ONCE(huge_shmem_orders_always);
> +	unsigned long within_size_orders = READ_ONCE(huge_shmem_orders_within_size);
> +	unsigned long vm_flags = vma->vm_flags;
> +	/*
> +	 * Check all the (large) orders below HPAGE_PMD_ORDER + 1 that
> +	 * are enabled for this vma.
> +	 */
> +	unsigned long orders = BIT(PMD_ORDER + 1) - 1;
> +	loff_t i_size;
> +	int order;
> +
> +	if ((vm_flags & VM_NOHUGEPAGE) ||
> +	    test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
> +		return 0;
> +
> +	/* If the hardware/firmware marked hugepage support disabled. */
> +	if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_UNSUPPORTED))
> +		return 0;
> +
> +	/*
> +	 * Following the 'deny' semantics of the top level, force the huge
> +	 * option off from all mounts.
> +	 */
> +	if (shmem_huge == SHMEM_HUGE_DENY)
> +		return 0;

I don't quite get this, I don't think its the desirable behaviour. This is
saying that if the top-level shemem_enabled control is set to 'deny', then all
mTHP sizes, regardless of their control's setting are disabled?

The anon controls don't work like that; you can set the top-level control to
anything you like, but its only consumed if the per-size controls are inheriting it.

So for the deny case, wouldn't it be better to allow that as an option on all
the per-size controls (and implicitly let it be inherrited from the top-level)?

> +
> +	/*
> +	 * Only allow inherit orders if the top-level value is 'force', which
> +	 * means non-PMD sized THP can not override 'huge' mount option now.
> +	 */
> +	if (shmem_huge == SHMEM_HUGE_FORCE)
> +		return READ_ONCE(huge_shmem_orders_inherit);

I vaguely recall that we originally discussed that trying to set 'force' on the
top level control while any per-size controls were set to 'inherit' would be an
error, and trying to set 'force' on any per-size control except the PMD-size
would be an error?

I don't really understand this logic. Shouldn't we just be looking at the
per-size control settings (or the top-level control as a proxy for every
per-size control that has 'inherit' set)?

Then for tmpfs, which doesn't support non-PMD-sizes yet, we just always use the
PMD-size control for decisions.

I'm also really struggling with the concept of shmem_is_huge() existing along
side shmem_allowable_huge_orders(). Surely this needs to all be refactored into
shmem_allowable_huge_orders()?

> +
> +	/* Allow mTHP that will be fully within i_size. */
> +	order = highest_order(within_size_orders);
> +	while (within_size_orders) {
> +		index = round_up(index + 1, order);
> +		i_size = round_up(i_size_read(inode), PAGE_SIZE);
> +		if (i_size >> PAGE_SHIFT >= index) {
> +			mask |= within_size_orders;
> +			break;
> +		}
> +
> +		order = next_order(&within_size_orders, order);
> +	}
> +
> +	if (vm_flags & VM_HUGEPAGE)
> +		mask |= READ_ONCE(huge_shmem_orders_madvise);
> +
> +	if (global_huge)

Perhaps I've misunderstood global_huge, but I think its just the return value
from shmem_is_huge()? But you're also using shmem_huge directly in this
function. I find it all rather confusing.

Sorry if all this was discussed and agreed in my absence! But I think this needs
to be sorted in order to do the bug fix for khugepaged properly.

Thanks,
Ryan


> +		mask |= READ_ONCE(huge_shmem_orders_inherit);
> +
> +	return orders & mask;
> +}
> +
> +static unsigned long shmem_suitable_orders(struct inode *inode, struct vm_fault *vmf,
> +					   struct address_space *mapping, pgoff_t index,
> +					   unsigned long orders)
> +{
> +	struct vm_area_struct *vma = vmf->vma;
> +	unsigned long pages;
> +	int order;
> +
> +	orders = thp_vma_suitable_orders(vma, vmf->address, orders);
> +	if (!orders)
> +		return 0;
> +
> +	/* Find the highest order that can add into the page cache */
> +	order = highest_order(orders);
> +	while (orders) {
> +		pages = 1UL << order;
> +		index = round_down(index, pages);
> +		if (!xa_find(&mapping->i_pages, &index,
> +			     index + pages - 1, XA_PRESENT))
> +			break;
> +		order = next_order(&orders, order);
> +	}
> +
> +	return orders;
> +}
> +#else
> +static unsigned long shmem_allowable_huge_orders(struct inode *inode,
> +				struct vm_area_struct *vma, pgoff_t index,
> +				bool global_huge)
> +{
> +	return 0;
> +}
> +
> +static unsigned long shmem_suitable_orders(struct inode *inode, struct vm_fault *vmf,
> +					   struct address_space *mapping, pgoff_t index,
> +					   unsigned long orders)
> +{
> +	return 0;
> +}
> +#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> +
>  static struct folio *shmem_alloc_folio(gfp_t gfp, int order,
>  		struct shmem_inode_info *info, pgoff_t index)
>  {
> @@ -1625,38 +1726,55 @@ static struct folio *shmem_alloc_folio(gfp_t gfp, int order,
>  	return folio;
>  }
>  
> -static struct folio *shmem_alloc_and_add_folio(gfp_t gfp,
> -		struct inode *inode, pgoff_t index,
> -		struct mm_struct *fault_mm, bool huge)
> +static struct folio *shmem_alloc_and_add_folio(struct vm_fault *vmf,
> +		gfp_t gfp, struct inode *inode, pgoff_t index,
> +		struct mm_struct *fault_mm, unsigned long orders)
>  {
>  	struct address_space *mapping = inode->i_mapping;
>  	struct shmem_inode_info *info = SHMEM_I(inode);
> -	struct folio *folio;
> +	struct vm_area_struct *vma = vmf ? vmf->vma : NULL;
> +	unsigned long suitable_orders = 0;
> +	struct folio *folio = NULL;
>  	long pages;
> -	int error;
> +	int error, order;
>  
>  	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
> -		huge = false;
> +		orders = 0;
>  
> -	if (huge) {
> -		pages = HPAGE_PMD_NR;
> -		index = round_down(index, HPAGE_PMD_NR);
> +	if (orders > 0) {
> +		if (vma && vma_is_anon_shmem(vma)) {
> +			suitable_orders = shmem_suitable_orders(inode, vmf,
> +							mapping, index, orders);
> +		} else if (orders & BIT(HPAGE_PMD_ORDER)) {
> +			pages = HPAGE_PMD_NR;
> +			suitable_orders = BIT(HPAGE_PMD_ORDER);
> +			index = round_down(index, HPAGE_PMD_NR);
>  
> -		/*
> -		 * Check for conflict before waiting on a huge allocation.
> -		 * Conflict might be that a huge page has just been allocated
> -		 * and added to page cache by a racing thread, or that there
> -		 * is already at least one small page in the huge extent.
> -		 * Be careful to retry when appropriate, but not forever!
> -		 * Elsewhere -EEXIST would be the right code, but not here.
> -		 */
> -		if (xa_find(&mapping->i_pages, &index,
> -				index + HPAGE_PMD_NR - 1, XA_PRESENT))
> -			return ERR_PTR(-E2BIG);
> +			/*
> +			 * Check for conflict before waiting on a huge allocation.
> +			 * Conflict might be that a huge page has just been allocated
> +			 * and added to page cache by a racing thread, or that there
> +			 * is already at least one small page in the huge extent.
> +			 * Be careful to retry when appropriate, but not forever!
> +			 * Elsewhere -EEXIST would be the right code, but not here.
> +			 */
> +			if (xa_find(&mapping->i_pages, &index,
> +				    index + HPAGE_PMD_NR - 1, XA_PRESENT))
> +				return ERR_PTR(-E2BIG);
> +		}
>  
> -		folio = shmem_alloc_folio(gfp, HPAGE_PMD_ORDER, info, index);
> -		if (!folio && pages == HPAGE_PMD_NR)
> -			count_vm_event(THP_FILE_FALLBACK);
> +		order = highest_order(suitable_orders);
> +		while (suitable_orders) {
> +			pages = 1UL << order;
> +			index = round_down(index, pages);
> +			folio = shmem_alloc_folio(gfp, order, info, index);
> +			if (folio)
> +				goto allocated;
> +
> +			if (pages == HPAGE_PMD_NR)
> +				count_vm_event(THP_FILE_FALLBACK);
> +			order = next_order(&suitable_orders, order);
> +		}
>  	} else {
>  		pages = 1;
>  		folio = shmem_alloc_folio(gfp, 0, info, index);
> @@ -1664,6 +1782,7 @@ static struct folio *shmem_alloc_and_add_folio(gfp_t gfp,
>  	if (!folio)
>  		return ERR_PTR(-ENOMEM);
>  
> +allocated:
>  	__folio_set_locked(folio);
>  	__folio_set_swapbacked(folio);
>  
> @@ -1958,7 +2077,8 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
>  	struct mm_struct *fault_mm;
>  	struct folio *folio;
>  	int error;
> -	bool alloced;
> +	bool alloced, huge;
> +	unsigned long orders = 0;
>  
>  	if (WARN_ON_ONCE(!shmem_mapping(inode->i_mapping)))
>  		return -EINVAL;
> @@ -2030,14 +2150,21 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
>  		return 0;
>  	}
>  
> -	if (shmem_is_huge(inode, index, false, fault_mm,
> -			  vma ? vma->vm_flags : 0)) {
> +	huge = shmem_is_huge(inode, index, false, fault_mm,
> +			     vma ? vma->vm_flags : 0);
> +	/* Find hugepage orders that are allowed for anonymous shmem. */
> +	if (vma && vma_is_anon_shmem(vma))
> +		orders = shmem_allowable_huge_orders(inode, vma, index, huge);
> +	else if (huge)
> +		orders = BIT(HPAGE_PMD_ORDER);
> +
> +	if (orders > 0) {
>  		gfp_t huge_gfp;
>  
>  		huge_gfp = vma_thp_gfp_mask(vma);
>  		huge_gfp = limit_gfp_mask(huge_gfp, gfp);
> -		folio = shmem_alloc_and_add_folio(huge_gfp,
> -				inode, index, fault_mm, true);
> +		folio = shmem_alloc_and_add_folio(vmf, huge_gfp,
> +				inode, index, fault_mm, orders);
>  		if (!IS_ERR(folio)) {
>  			if (folio_test_pmd_mappable(folio))
>  				count_vm_event(THP_FILE_ALLOC);
> @@ -2047,7 +2174,7 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
>  			goto repeat;
>  	}
>  
> -	folio = shmem_alloc_and_add_folio(gfp, inode, index, fault_mm, false);
> +	folio = shmem_alloc_and_add_folio(vmf, gfp, inode, index, fault_mm, 0);
>  	if (IS_ERR(folio)) {
>  		error = PTR_ERR(folio);
>  		if (error == -EEXIST)
> @@ -2058,7 +2185,7 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
>  
>  alloced:
>  	alloced = true;
> -	if (folio_test_pmd_mappable(folio) &&
> +	if (folio_test_large(folio) &&
>  	    DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE) <
>  					folio_next_index(folio) - 1) {
>  		struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);


