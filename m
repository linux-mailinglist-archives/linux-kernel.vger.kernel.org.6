Return-Path: <linux-kernel+bounces-179366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C97B8C5F51
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 05:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 828071F223A5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 03:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A42B374D3;
	Wed, 15 May 2024 03:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CpZ4vKxj"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C5636AE0
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 03:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715742570; cv=none; b=m07fXJC0S1YMGm/eQfZUTupH3YMI0Jc9rn7HMukTOGF2g6AQcH5n5aBOHp5OTLIXt0HVoi8EkynfhhBTHSR9h/z4Pkw2KQ3aADosiN6Octmnp/BDaIugKu8H2VvzTkeYytSxJZIHHuWzVrFfOTx5BaG4eQcZ6xOupraNjq+gQK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715742570; c=relaxed/simple;
	bh=fFMaD7bkRnKf49O+yRK5VayqROvZg8Gd9vXrjEU3Eqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kzZIhxjX8l7zp2nIFeMmv39Z+SEr9Uo1kfJDlHKNxZyO0ynd4CBdDbZIbmAAkc15IYr/jZGOtL3aSI2cmmWGMGC1OZ972RdIOtLxhsJeiMbzxFVfw8V07O2i8dHx4TWNcUgpvV9iX1xq3P1uFCwPnjO4t5Op27KEtU7BPGcx/Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CpZ4vKxj; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715742565; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=dLPH3uRBAuSYs9DKZAOz31UzufSUxH5avu2Y4j0wRMM=;
	b=CpZ4vKxjTSpc6uehvI5imDlO4Rd0okOmFr+ROjjW/3bzJCRuMIsdvYykF8XXE90R3xKTtQ9VzjjEVzqDiSey5Ewz9HG4FPKpJEIXVzQHBJwCOmJewHrGF4p6MkewhTCAEyUcMNEHzt2qtDKCAPg+epp4zt+BmCUikl8qd8CFg1g=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R691e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W6WSbza_1715742561;
Received: from 30.97.56.58(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W6WSbza_1715742561)
          by smtp.aliyun-inc.com;
          Wed, 15 May 2024 11:09:23 +0800
Message-ID: <db36c444-0327-455b-9502-65d308237018@linux.alibaba.com>
Date: Wed, 15 May 2024 11:09:21 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] mm: shmem: add mTHP support for anonymous shmem
To: Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, hughd@google.com, willy@infradead.org,
 david@redhat.com, wangkefeng.wang@huawei.com, ying.huang@intel.com,
 21cnbao@gmail.com, ryan.roberts@arm.com, shy828301@gmail.com,
 ziy@nvidia.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1715571279.git.baolin.wang@linux.alibaba.com>
 <bc354692695d443e00b8c5e2106868a7f365e078.1715571279.git.baolin.wang@linux.alibaba.com>
 <CAK1f24m1LAK-+GKeTSGANXXfk3KahmpN7KvO8FCkA+2cdNtfzw@mail.gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <CAK1f24m1LAK-+GKeTSGANXXfk3KahmpN7KvO8FCkA+2cdNtfzw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/5/14 21:36, Lance Yang wrote:
> Hi Baolin,
> 
> On Mon, May 13, 2024 at 1:08 PM Baolin Wang
> <baolin.wang@linux.alibaba.com> wrote:
>>
>> Commit 19eaf44954df adds multi-size THP (mTHP) for anonymous pages, that
>> can allow THP to be configured through the sysfs interface located at
>> '/sys/kernel/mm/transparent_hugepage/hugepage-XXkb/enabled'.
>>
>> However, the anonymous share pages will ignore the anonymous mTHP rule
>> configured through the sysfs interface, and can only use the PMD-mapped
>> THP, that is not reasonable. Users expect to apply the mTHP rule for
>> all anonymous pages, including the anonymous share pages, in order to
>> enjoy the benefits of mTHP. For example, lower latency than PMD-mapped THP,
>> smaller memory bloat than PMD-mapped THP, contiguous PTEs on ARM architecture
>> to reduce TLB miss etc.
>>
>> The primary strategy is similar to supporting anonymous mTHP. Introduce
>> a new interface '/mm/transparent_hugepage/hugepage-XXkb/shmem_enabled',
>> which can have all the same values as the top-level
>> '/sys/kernel/mm/transparent_hugepage/shmem_enabled', with adding a new
>> additional "inherit" option. By default all sizes will be set to "never"
>> except PMD size, which is set to "inherit". This ensures backward compatibility
>> with the anonymous shmem enabled of the top level, meanwhile also allows
>> independent control of anonymous shmem enabled for each mTHP.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>   include/linux/huge_mm.h |  10 +++
>>   mm/shmem.c              | 179 +++++++++++++++++++++++++++++++++-------
>>   2 files changed, 161 insertions(+), 28 deletions(-)
>>
>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>> index 1fce6fee7766..b5339210268d 100644
>> --- a/include/linux/huge_mm.h
>> +++ b/include/linux/huge_mm.h
>> @@ -583,6 +583,16 @@ static inline bool thp_migration_supported(void)
>>   {
>>          return false;
>>   }
>> +
>> +static inline int highest_order(unsigned long orders)
>> +{
>> +       return 0;
>> +}
>> +
>> +static inline int next_order(unsigned long *orders, int prev)
>> +{
>> +       return 0;
>> +}
>>   #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>>
>>   static inline int split_folio_to_list_to_order(struct folio *folio,
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index 59cc26d44344..b50ddf013e37 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -1611,6 +1611,106 @@ static gfp_t limit_gfp_mask(gfp_t huge_gfp, gfp_t limit_gfp)
>>          return result;
>>   }
>>
>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> +static unsigned long anon_shmem_allowable_huge_orders(struct inode *inode,
>> +                               struct vm_area_struct *vma, pgoff_t index,
>> +                               bool global_huge)
>> +{
>> +       unsigned long mask = READ_ONCE(huge_anon_shmem_orders_always);
>> +       unsigned long within_size_orders = READ_ONCE(huge_anon_shmem_orders_within_size);
>> +       unsigned long vm_flags = vma->vm_flags;
>> +       /*
>> +        * Check all the (large) orders below HPAGE_PMD_ORDER + 1 that
>> +        * are enabled for this vma.
>> +        */
>> +       unsigned long orders = BIT(PMD_ORDER + 1) - 1;
>> +       loff_t i_size;
>> +       int order;
>> +
>> +       if ((vm_flags & VM_NOHUGEPAGE) ||
>> +           test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
>> +               return 0;
>> +
>> +       /* If the hardware/firmware marked hugepage support disabled. */
>> +       if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_UNSUPPORTED))
>> +               return 0;
>> +
>> +       /*
>> +        * Following the 'deny' semantics of the top level, force the huge
>> +        * option off from all mounts.
>> +        */
>> +       if (shmem_huge == SHMEM_HUGE_DENY)
>> +               return 0;
>> +       /*
>> +        * Only allow inherit orders if the top-level value is 'force', which
>> +        * means non-PMD sized THP can not override 'huge' mount option now.
>> +        */
>> +       if (shmem_huge == SHMEM_HUGE_FORCE)
>> +               return READ_ONCE(huge_anon_shmem_orders_inherit);
>> +
>> +       /* Allow mTHP that will be fully within i_size. */
>> +       order = highest_order(within_size_orders);
>> +       while (within_size_orders) {
>> +               index = round_up(index + 1, order);
>> +               i_size = round_up(i_size_read(inode), PAGE_SIZE);
>> +               if (i_size >> PAGE_SHIFT >= index) {
>> +                       mask |= within_size_orders;
>> +                       break;
>> +               }
>> +
>> +               order = next_order(&within_size_orders, order);
>> +       }
>> +
>> +       if (vm_flags & VM_HUGEPAGE)
>> +               mask |= READ_ONCE(huge_anon_shmem_orders_madvise);
>> +
>> +       if (global_huge)
>> +               mask |= READ_ONCE(huge_anon_shmem_orders_inherit);
>> +
>> +       return orders & mask;
>> +}
>> +
>> +static unsigned long anon_shmem_suitable_orders(struct inode *inode, struct vm_fault *vmf,
>> +                                       struct address_space *mapping, pgoff_t index,
>> +                                       unsigned long orders)
>> +{
>> +       struct vm_area_struct *vma = vmf->vma;
>> +       unsigned long pages;
>> +       int order;
>> +
>> +       orders = thp_vma_suitable_orders(vma, vmf->address, orders);
>> +       if (!orders)
>> +               return 0;
>> +
>> +       /* Find the highest order that can add into the page cache */
>> +       order = highest_order(orders);
>> +       while (orders) {
>> +               pages = 1UL << order;
>> +               index = round_down(index, pages);
>> +               if (!xa_find(&mapping->i_pages, &index,
>> +                            index + pages - 1, XA_PRESENT))
>> +                       break;
>> +               order = next_order(&orders, order);
>> +       }
>> +
>> +       return orders;
>> +}
>> +#else
>> +static unsigned long anon_shmem_allowable_huge_orders(struct inode *inode,
>> +                               struct vm_area_struct *vma, pgoff_t index,
>> +                               bool global_huge)
>> +{
>> +       return 0;
>> +}
>> +
>> +static unsigned long anon_shmem_suitable_orders(struct inode *inode, struct vm_fault *vmf,
>> +                                       struct address_space *mapping, pgoff_t index,
>> +                                       unsigned long orders)
>> +{
>> +       return 0;
>> +}
>> +#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>> +
>>   static struct folio *shmem_alloc_hugefolio(gfp_t gfp,
>>                  struct shmem_inode_info *info, pgoff_t index, int order)
>>   {
>> @@ -1639,38 +1739,55 @@ static struct folio *shmem_alloc_folio(gfp_t gfp,
>>          return (struct folio *)page;
>>   }
>>
>> -static struct folio *shmem_alloc_and_add_folio(gfp_t gfp,
>> -               struct inode *inode, pgoff_t index,
>> -               struct mm_struct *fault_mm, bool huge)
>> +static struct folio *shmem_alloc_and_add_folio(struct vm_fault *vmf,
>> +               gfp_t gfp, struct inode *inode, pgoff_t index,
>> +               struct mm_struct *fault_mm, bool huge, unsigned long orders)
> 
> IMO, it might be cleaner to drop the huge parameter and just set 'orders' as
> BIT(HPAGE_PMD_ORDER), then we only do the 'orders' check :)
> 
> Likely:
> 
> if (orders > 0) {
>         if (vma && vma_is_anon_shmem(vma)) {
>                ...
>         } else if (orders & BIT(HPAGE_PMD_ORDER)) {
>                ...
>         }
> }

Yes, looks better.

>>   {
>>          struct address_space *mapping = inode->i_mapping;
>>          struct shmem_inode_info *info = SHMEM_I(inode);
>> -       struct folio *folio;
>> +       struct vm_area_struct *vma = vmf ? vmf->vma : NULL;
>> +       unsigned long suitable_orders;
>> +       struct folio *folio = NULL;
>>          long pages;
>> -       int error;
>> +       int error, order;
>>
>>          if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
>>                  huge = false;
> 
> Currently, if THP is disabled, 'huge' will fall back to order-0, but 'orders'
> does not, IIUC. How about we make both consistent if THP is disabled?
> 
> if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
>          huge = false;
>          orders = 0;
> }

If THP is disabled, the 'orders' must be 0, so no need to reset it.

