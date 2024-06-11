Return-Path: <linux-kernel+bounces-209192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C78902E8A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 04:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF3D9281A0C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 02:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A11F16F85D;
	Tue, 11 Jun 2024 02:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="iOWC10vJ"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3B415B0E2
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 02:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718073761; cv=none; b=tm0/NAeKJA7KKR7mgs4mXWvmgCjW9Fk9j1+g2Uc+Fd3SVdpPrA5vYVUIJmL6uFuNYAqTl55Hbgp5gg1KGdjDLFivh6l9JjdISroJe8a3DZsTNJNWBhUOxulaKMSKZnsguqW5BUt8N2dc0fqYjmzxzP0u7mzXZsGqEZ079DI4Eo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718073761; c=relaxed/simple;
	bh=SmsxwSsV7uah0iJgUJjfn0+CW8WplUCs1aYYV+QODSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yp9yPHTCqc4jrpFJPb52+iJ1teXNxsIK3+os7/Sn2z6QOuMGdEttB32iz9utobZmrEA1176ECpJ8ICnFxj67DXkShcbqC4ft6cIf/It2KEs3O1Iyclq+IOh+V2SLK1qQMAgEgc3Eueg4d6IRZEiK790GQ907V6KTxc7EVd6ofq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=iOWC10vJ; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718073749; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=4pLXlVR9FKPdQR7Bll9bIYZB5N2dx1NL/FBVohUtChM=;
	b=iOWC10vJVQEL0quDoMpOT3OdJEfZir7oAyL9iK/w64ryzdph4kGAXaP6Cv03vKbKEMRYXDOt82mM/3R6WD7SJuRq2JVTmlVVbDkXmzIcs+Sv4IHoRBQrOJLQ5STVz1PgQIfjTthEvl7ScHK43reqHSkO+jPpTzOMD+10a8TAhGA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W8Ek5.e_1718073746;
Received: from 30.97.56.68(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W8Ek5.e_1718073746)
          by smtp.aliyun-inc.com;
          Tue, 11 Jun 2024 10:42:27 +0800
Message-ID: <83c23f2a-9ea8-4120-859e-d69d20c17647@linux.alibaba.com>
Date: Tue, 11 Jun 2024 10:42:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/6] mm: shmem: add mTHP support for anonymous shmem
To: Daniel Gomez <da.gomez@samsung.com>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "hughd@google.com" <hughd@google.com>,
 "willy@infradead.org" <willy@infradead.org>,
 "david@redhat.com" <david@redhat.com>,
 "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
 "ying.huang@intel.com" <ying.huang@intel.com>,
 "21cnbao@gmail.com" <21cnbao@gmail.com>,
 "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
 "shy828301@gmail.com" <shy828301@gmail.com>, "ziy@nvidia.com"
 <ziy@nvidia.com>, "ioworker0@gmail.com" <ioworker0@gmail.com>,
 Pankaj Raghav <p.raghav@samsung.com>, "linux-mm@kvack.org"
 <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1717495894.git.baolin.wang@linux.alibaba.com>
 <9be6eeacd0304c82a1cb1b7487977a3e14d2b5df.1717495894.git.baolin.wang@linux.alibaba.com>
 <CGME20240610132756eucas1p1d892ccbabdb5f8fc4cff55c662f24d75@eucas1p1.samsung.com>
 <kzoo6v5tc44yztltdhbf2qbor3uladm3wsxvuahhkf3zdytp63@wt4hww4oj7gq>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <kzoo6v5tc44yztltdhbf2qbor3uladm3wsxvuahhkf3zdytp63@wt4hww4oj7gq>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/6/10 21:27, Daniel Gomez wrote:
> On Tue, Jun 04, 2024 at 06:17:48PM +0800, Baolin Wang wrote:
>> Commit 19eaf44954df adds multi-size THP (mTHP) for anonymous pages, that
>> can allow THP to be configured through the sysfs interface located at
>> '/sys/kernel/mm/transparent_hugepage/hugepage-XXkb/enabled'.
>>
>> However, the anonymous shmem will ignore the anonymous mTHP rule
>> configured through the sysfs interface, and can only use the PMD-mapped
>> THP, that is not reasonable. Users expect to apply the mTHP rule for
>> all anonymous pages, including the anonymous shmem, in order to enjoy
>> the benefits of mTHP. For example, lower latency than PMD-mapped THP,
>> smaller memory bloat than PMD-mapped THP, contiguous PTEs on ARM architecture
>> to reduce TLB miss etc. In addition, the mTHP interfaces can be extended
>> to support all shmem/tmpfs scenarios in the future, especially for the
>> shmem mmap() case.
>>
>> The primary strategy is similar to supporting anonymous mTHP. Introduce
>> a new interface '/mm/transparent_hugepage/hugepage-XXkb/shmem_enabled',
>> which can have almost the same values as the top-level
>> '/sys/kernel/mm/transparent_hugepage/shmem_enabled', with adding a new
>> additional "inherit" option and dropping the testing options 'force' and
>> 'deny'. By default all sizes will be set to "never" except PMD size,
>> which is set to "inherit". This ensures backward compatibility with the
>> anonymous shmem enabled of the top level, meanwhile also allows independent
>> control of anonymous shmem enabled for each mTHP.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>   include/linux/huge_mm.h |  10 +++
>>   mm/shmem.c              | 187 +++++++++++++++++++++++++++++++++-------
>>   2 files changed, 167 insertions(+), 30 deletions(-)
>>
>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>> index fac21548c5de..909cfc67521d 100644
>> --- a/include/linux/huge_mm.h
>> +++ b/include/linux/huge_mm.h
>> @@ -575,6 +575,16 @@ static inline bool thp_migration_supported(void)
>>   {
>>   	return false;
>>   }
>> +
>> +static inline int highest_order(unsigned long orders)
>> +{
>> +	return 0;
>> +}
>> +
>> +static inline int next_order(unsigned long *orders, int prev)
>> +{
>> +	return 0;
>> +}
>>   #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>>   
>>   static inline int split_folio_to_list_to_order(struct folio *folio,
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index 643ff7516b4d..9a8533482208 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -1611,6 +1611,107 @@ static gfp_t limit_gfp_mask(gfp_t huge_gfp, gfp_t limit_gfp)
>>   	return result;
>>   }
>>   
>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> +static unsigned long anon_shmem_allowable_huge_orders(struct inode *inode,
> 
> We want to get mTHP orders as well for tmpfs so, could we make this to work for > both paths? If true, I'd remove the anon prefix.

Yes, I can drop the 'anon' prefix for these functions. But like I said 
in the cover letter, this patch set is for supporting mTHP for anon 
shmem, as a start. For supporting mTHP for tmpfs, patches will be added 
iteratively.

>> +				struct vm_area_struct *vma, pgoff_t index,
>> +				bool global_huge)
> 
> Why did you rename 'huge' variable to 'global_huge'? We were using 'huge' in
> shmem_alloc_and_add_folio() before this commit. I guess it's just odd to me this
> var rename without seen any name conflict inside it.

This is to use the ‘inherit’ option of mTHP to be compatible with the 
top level 'shmem_enabled' configuration (located at 
'/mm/transparent_hugepage/shmem_enabled'). Original 'huge' can not 
reflect the settings of the top level huge configuration. Moreover 
'global' terminology also refers to the naming used by THP, for example, 
hugepage_global_enabled().

>> +{
>> +	unsigned long mask = READ_ONCE(huge_anon_shmem_orders_always);
>> +	unsigned long within_size_orders = READ_ONCE(huge_anon_shmem_orders_within_size);
>> +	unsigned long vm_flags = vma->vm_flags;
>> +	/*
>> +	 * Check all the (large) orders below HPAGE_PMD_ORDER + 1 that
>> +	 * are enabled for this vma.
>> +	 */
>> +	unsigned long orders = BIT(PMD_ORDER + 1) - 1;
>> +	loff_t i_size;
>> +	int order;
>> +
> 
> We can start the mm anon path here but we should exclude the ones that do not
> apply for tmpfs.

As I said above, this patch set is focus on the anon shmem. So we should 
talk about this in the patch of mTHP support tmpfs.

> 
>> +	if ((vm_flags & VM_NOHUGEPAGE) ||
>> +	    test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
>> +		return 0;
>> +
>> +	/* If the hardware/firmware marked hugepage support disabled. */
>> +	if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_UNSUPPORTED))
>> +		return 0;
>> +
>> +	/*
>> +	 * Following the 'deny' semantics of the top level, force the huge
>> +	 * option off from all mounts.
>> +	 */
>> +	if (shmem_huge == SHMEM_HUGE_DENY)
>> +		return 0;
>> +
>> +	/*
>> +	 * Only allow inherit orders if the top-level value is 'force', which
>> +	 * means non-PMD sized THP can not override 'huge' mount option now.
>> +	 */
>> +	if (shmem_huge == SHMEM_HUGE_FORCE)
>> +		return READ_ONCE(huge_anon_shmem_orders_inherit);
>> +
>> +	/* Allow mTHP that will be fully within i_size. */
>> +	order = highest_order(within_size_orders);
>> +	while (within_size_orders) {
>> +		index = round_up(index + 1, order);
>> +		i_size = round_up(i_size_read(inode), PAGE_SIZE);
>> +		if (i_size >> PAGE_SHIFT >= index) {
>> +			mask |= within_size_orders;
>> +			break;
>> +		}
>> +
>> +		order = next_order(&within_size_orders, order);
>> +	}
>> +
>> +	if (vm_flags & VM_HUGEPAGE)
>> +		mask |= READ_ONCE(huge_anon_shmem_orders_madvise);
>> +
>> +	if (global_huge)
>> +		mask |= READ_ONCE(huge_anon_shmem_orders_inherit);
>> +
>> +	return orders & mask;
>> +}
>> +
>> +static unsigned long anon_shmem_suitable_orders(struct inode *inode, struct vm_fault *vmf,
>> +					struct address_space *mapping, pgoff_t index,
>> +					unsigned long orders)
>> +{
>> +	struct vm_area_struct *vma = vmf->vma;
>> +	unsigned long pages;
>> +	int order;
>> +
>> +	orders = thp_vma_suitable_orders(vma, vmf->address, orders);
> 
> This won't apply to tmpfs. I'm thinking if we can apply
> shmem_mapping_size_order() [1] here for tmpfs path so we have the same suitable
> orders for both paths.
> 
> [1] https://lore.kernel.org/all/v5acpezkt4ml3j3ufmbgnq5b335envea7xfobvowtaetvbt3an@v3pfkwly5jh2/#t

Ditto.

> 
>> +	if (!orders)
>> +		return 0;
>> +
>> +	/* Find the highest order that can add into the page cache */
>> +	order = highest_order(orders);
>> +	while (orders) {
>> +		pages = 1UL << order;
>> +		index = round_down(index, pages);
>> +		if (!xa_find(&mapping->i_pages, &index,
>> +			     index + pages - 1, XA_PRESENT))
>> +			break;
>> +		order = next_order(&orders, order);
>> +	}
>> +
>> +	return orders;
>> +}
>> +#else
>> +static unsigned long anon_shmem_allowable_huge_orders(struct inode *inode,
>> +				struct vm_area_struct *vma, pgoff_t index,
>> +				bool global_huge)
>> +{
>> +	return 0;
>> +}
>> +
>> +static unsigned long anon_shmem_suitable_orders(struct inode *inode, struct vm_fault *vmf,
>> +					struct address_space *mapping, pgoff_t index,
>> +					unsigned long orders)
>> +{
>> +	return 0;
>> +}
>> +#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>> +
>>   static struct folio *shmem_alloc_folio(gfp_t gfp, int order,
>>   		struct shmem_inode_info *info, pgoff_t index)
>>   {
>> @@ -1625,38 +1726,55 @@ static struct folio *shmem_alloc_folio(gfp_t gfp, int order,
>>   	return folio;
>>   }
>>   
>> -static struct folio *shmem_alloc_and_add_folio(gfp_t gfp,
>> -		struct inode *inode, pgoff_t index,
>> -		struct mm_struct *fault_mm, bool huge)
>> +static struct folio *shmem_alloc_and_add_folio(struct vm_fault *vmf,
>> +		gfp_t gfp, struct inode *inode, pgoff_t index,
>> +		struct mm_struct *fault_mm, unsigned long orders)
>>   {
>>   	struct address_space *mapping = inode->i_mapping;
>>   	struct shmem_inode_info *info = SHMEM_I(inode);
>> -	struct folio *folio;
>> +	struct vm_area_struct *vma = vmf ? vmf->vma : NULL;
>> +	unsigned long suitable_orders = 0;
>> +	struct folio *folio = NULL;
>>   	long pages;
>> -	int error;
>> +	int error, order;
>>   
>>   	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
>> -		huge = false;
>> +		orders = 0;
>>   
>> -	if (huge) {
>> -		pages = HPAGE_PMD_NR;
>> -		index = round_down(index, HPAGE_PMD_NR);
>> +	if (orders > 0) {
> 
> Can we get rid of this condition if we handle all allowable orders in 'orders'?
> Including order-0 and PMD-order. I agree, we do not need the huge flag anymore
> since you have handled all cases in shmem_allowable_huge_orders().

IMO, for order-0, we do not need suitable validation, so just 
fallbacking to order 0 allocation is clear to me.

> 
>> +		if (vma && vma_is_anon_shmem(vma)) {
>> +			suitable_orders = anon_shmem_suitable_orders(inode, vmf,
>> +							mapping, index, orders);
>> +		} else if (orders & BIT(HPAGE_PMD_ORDER)) {
>> +			pages = HPAGE_PMD_NR;
>> +			suitable_orders = BIT(HPAGE_PMD_ORDER);
>> +			index = round_down(index, HPAGE_PMD_NR);
>>   
>> -		/*
>> -		 * Check for conflict before waiting on a huge allocation.
>> -		 * Conflict might be that a huge page has just been allocated
>> -		 * and added to page cache by a racing thread, or that there
>> -		 * is already at least one small page in the huge extent.
>> -		 * Be careful to retry when appropriate, but not forever!
>> -		 * Elsewhere -EEXIST would be the right code, but not here.
>> -		 */
>> -		if (xa_find(&mapping->i_pages, &index,
>> -				index + HPAGE_PMD_NR - 1, XA_PRESENT))
>> -			return ERR_PTR(-E2BIG);
>> +			/*
>> +			 * Check for conflict before waiting on a huge allocation.
>> +			 * Conflict might be that a huge page has just been allocated
>> +			 * and added to page cache by a racing thread, or that there
>> +			 * is already at least one small page in the huge extent.
>> +			 * Be careful to retry when appropriate, but not forever!
>> +			 * Elsewhere -EEXIST would be the right code, but not here.
>> +			 */
>> +			if (xa_find(&mapping->i_pages, &index,
>> +				    index + HPAGE_PMD_NR - 1, XA_PRESENT))
>> +				return ERR_PTR(-E2BIG);
>> +		}
>>   
>> -		folio = shmem_alloc_folio(gfp, HPAGE_PMD_ORDER, info, index);
>> -		if (!folio && pages == HPAGE_PMD_NR)
>> -			count_vm_event(THP_FILE_FALLBACK);
>> +		order = highest_order(suitable_orders);
>> +		while (suitable_orders) {
>> +			pages = 1UL << order;
>> +			index = round_down(index, pages);
>> +			folio = shmem_alloc_folio(gfp, order, info, index);
>> +			if (folio)
>> +				goto allocated;
>> +
>> +			if (pages == HPAGE_PMD_NR)
>> +				count_vm_event(THP_FILE_FALLBACK);
>> +			order = next_order(&suitable_orders, order);
>> +		}
>>   	} else {
>>   		pages = 1;
>>   		folio = shmem_alloc_folio(gfp, 0, info, index);
>> @@ -1664,6 +1782,7 @@ static struct folio *shmem_alloc_and_add_folio(gfp_t gfp,
>>   	if (!folio)
>>   		return ERR_PTR(-ENOMEM);
>>   
>> +allocated:
>>   	__folio_set_locked(folio);
>>   	__folio_set_swapbacked(folio);
>>   
>> @@ -1958,7 +2077,8 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
>>   	struct mm_struct *fault_mm;
>>   	struct folio *folio;
>>   	int error;
>> -	bool alloced;
>> +	bool alloced, huge;
>> +	unsigned long orders = 0;
>>   
>>   	if (WARN_ON_ONCE(!shmem_mapping(inode->i_mapping)))
>>   		return -EINVAL;
>> @@ -2030,14 +2150,21 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
>>   		return 0;
>>   	}
>>   
>> -	if (shmem_is_huge(inode, index, false, fault_mm,
>> -			  vma ? vma->vm_flags : 0)) {
>> +	huge = shmem_is_huge(inode, index, false, fault_mm,
>> +			     vma ? vma->vm_flags : 0);
>> +	/* Find hugepage orders that are allowed for anonymous shmem. */
>> +	if (vma && vma_is_anon_shmem(vma))
> 
> I guess we do not want to check the anon path here either (in case you agree to
> merge this with tmpfs path).

Ditto. Should do this in another patch.

> 
>> +		orders = anon_shmem_allowable_huge_orders(inode, vma, index, huge);
>> +	else if (huge)
>> +		orders = BIT(HPAGE_PMD_ORDER);
> 
> Why not handling this case inside allowable_huge_orders()?

Ditto.

> 
>> +
>> +	if (orders > 0) {
> 
> Does it make sense to handle these case anymore? Before, we had the huge
> path and order-0. If we handle all cases in allowable_orders() perhaps we can
> simplify this.
> 
>>   		gfp_t huge_gfp;
>>   
>>   		huge_gfp = vma_thp_gfp_mask(vma);
> 
> We are also setting this flag regardless of the final order. Meaning that
> suitable_orders() might return order-0 and yet we keep the huge gfp flag. Is
> that right?

If anon_shmem_suitable_orders() returns order-0, then 
shmem_alloc_and_add_folio() will return -ENOMEM, which will lead to 
fallback order-0 allocation with 'gfp' flag in this function.

> 
>>   		huge_gfp = limit_gfp_mask(huge_gfp, gfp);
>> -		folio = shmem_alloc_and_add_folio(huge_gfp,
>> -				inode, index, fault_mm, true);
>> +		folio = shmem_alloc_and_add_folio(vmf, huge_gfp,
>> +				inode, index, fault_mm, orders);
>>   		if (!IS_ERR(folio)) {
>>   			if (folio_test_pmd_mappable(folio))
>>   				count_vm_event(THP_FILE_ALLOC);
>> @@ -2047,7 +2174,7 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
>>   			goto repeat;
>>   	}
>>   
>> -	folio = shmem_alloc_and_add_folio(gfp, inode, index, fault_mm, false);
>> +	folio = shmem_alloc_and_add_folio(vmf, gfp, inode, index, fault_mm, 0);
>>   	if (IS_ERR(folio)) {
>>   		error = PTR_ERR(folio);
>>   		if (error == -EEXIST)
>> @@ -2058,7 +2185,7 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
>>   
>>   alloced:
>>   	alloced = true;
>> -	if (folio_test_pmd_mappable(folio) &&
>> +	if (folio_test_large(folio) &&
>>   	    DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE) <
>>   					folio_next_index(folio) - 1) {
>>   		struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
>> -- 
>> 2.39.3

