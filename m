Return-Path: <linux-kernel+bounces-407029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5C69C6798
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 04:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77D731F21E6C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 03:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA9F1607AB;
	Wed, 13 Nov 2024 03:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hEHCOuem"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B0D137772
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 03:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731467249; cv=none; b=PR/J3xUc4/HxdRC5zDFZsuiPdlTwPRe4RL20bXinCDyRUM3rrJo8eQZbEWjYouVArGFEl4Otn9I6Ya1MG9qEQI6Ar3Zdbc4lNNntfpBx64NvUKwjBDki0vQXn78eun6mXILvBeGlkqvlW4U+ihV2RSa8nJ4n1XD5oJv1ZU33KpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731467249; c=relaxed/simple;
	bh=2kvly/XMrrvf4xxkpYg1RHMOmt6QNShJuLv/Cc5mGTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TCuh99dAk1MWANvaq3tXohYkevmeYg7Md7CvdgvkdXotqEv1jN35IIeoRrqCRqTPQYsdVqb5qVI3rvSOV9vkXWj24MOkt64ouwCzZSUq5ABoaNsBB8c0KyznjAN4Nuaw6D4BAQtk0SDqj/y0olQ5OtESygRBGGz0mYaPa8xW2mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hEHCOuem; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731467243; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Pbwpp087l87MJTWrl2ZjKKwDd9bxrq6hIeN+3zWIEJU=;
	b=hEHCOuemdq1B+T2DlE8DE3MDuG4wB+htw8HBhwmTY54k6t4k1Bmh13ZNRkKK2waFyyDfHB9GyhznG2YIy/ueddyPr2y3DwXQLMX8eb5zlHCI8irM2G59Wc77TwTgun5TkEfz5t/70XOlE3nLzcoTf+vN12LRCgskH41UaixLA7k=
Received: from 30.74.144.126(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WJJYp56_1731467240 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 13 Nov 2024 11:07:21 +0800
Message-ID: <6c2c25b7-3929-4d1c-8312-61a69f2c5b26@linux.alibaba.com>
Date: Wed, 13 Nov 2024 11:07:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] mm: shmem: add large folio support for tmpfs
To: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
 hughd@google.com
Cc: willy@infradead.org, wangkefeng.wang@huawei.com, 21cnbao@gmail.com,
 ryan.roberts@arm.com, ioworker0@gmail.com, da.gomez@samsung.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1731397290.git.baolin.wang@linux.alibaba.com>
 <eabd8c89fc1b4807eaf28750e04c44b718ae6487.1731397290.git.baolin.wang@linux.alibaba.com>
 <c7c3f529-4cd0-4209-b3b9-48a29dfcb08d@redhat.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <c7c3f529-4cd0-4209-b3b9-48a29dfcb08d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/11/13 00:19, David Hildenbrand wrote:
> On 12.11.24 08:45, Baolin Wang wrote:
>> Add large folio support for tmpfs write and fallocate paths matching the
>> same high order preference mechanism used in the iomap buffered IO path
>> as used in __filemap_get_folio().
>>
>> Add shmem_mapping_size_orders() to get a hint for the orders of the folio
>> based on the file size which takes care of the mapping requirements.
>>
>> Traditionally, tmpfs only supported PMD-sized huge folios. However 
>> nowadays
>> with other file systems supporting any sized large folios, and extending
>> anonymous to support mTHP, we should not restrict tmpfs to allocating 
>> only
>> PMD-sized huge folios, making it more special. Instead, we should allow
>> tmpfs can allocate any sized large folios.
>>
>> Considering that tmpfs already has the 'huge=' option to control the huge
>> folios allocation, we can extend the 'huge=' option to allow any sized 
>> huge
>> folios. The semantics of the 'huge=' mount option are:
>>
>> huge=never: no any sized huge folios
>> huge=always: any sized huge folios
>> huge=within_size: like 'always' but respect the i_size
>> huge=advise: like 'always' if requested with fadvise()/madvise()
>>
>> Note: for tmpfs mmap() faults, due to the lack of a write size hint, 
>> still
>> allocate the PMD-sized huge folios if huge=always/within_size/advise 
>> is set.
>>
>> Moreover, the 'deny' and 'force' testing options controlled by
>> '/sys/kernel/mm/transparent_hugepage/shmem_enabled', still retain the 
>> same
>> semantics. The 'deny' can disable any sized large folios for tmpfs, while
>> the 'force' can enable PMD sized large folios for tmpfs.
>>
>> Co-developed-by: Daniel Gomez <da.gomez@samsung.com>
>> Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>   mm/shmem.c | 91 +++++++++++++++++++++++++++++++++++++++++++++---------
>>   1 file changed, 77 insertions(+), 14 deletions(-)
>>
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index 86b2e417dc6f..a3203cf8860f 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -549,10 +549,50 @@ static bool shmem_confirm_swap(struct 
>> address_space *mapping,
>>   static int shmem_huge __read_mostly = SHMEM_HUGE_NEVER;
>> +/**
>> + * shmem_mapping_size_orders - Get allowable folio orders for the 
>> given file size.
>> + * @mapping: Target address_space.
>> + * @index: The page index.
>> + * @write_end: end of a write, could extend inode size.
>> + *
>> + * This returns huge orders for folios (when supported) based on the 
>> file size
>> + * which the mapping currently allows at the given index. The index 
>> is relevant
>> + * due to alignment considerations the mapping might have. The 
>> returned order
>> + * may be less than the size passed.
>> + *
>> + * Return: The orders.
>> + */
>> +static inline unsigned int
>> +shmem_mapping_size_orders(struct address_space *mapping, pgoff_t 
>> index, loff_t write_end)
>> +{
>> +    unsigned int order;
>> +    size_t size;
>> +
>> +    if (!mapping_large_folio_support(mapping) || !write_end)
>> +        return 0;
>> +
>> +    /* Calculate the write size based on the write_end */
>> +    size = write_end - (index << PAGE_SHIFT);
>> +    order = filemap_get_order(size);
>> +    if (!order)
>> +        return 0;
>> +
>> +    /* If we're not aligned, allocate a smaller folio */
>> +    if (index & ((1UL << order) - 1))
>> +        order = __ffs(index);
>> +
>> +    order = min_t(size_t, order, MAX_PAGECACHE_ORDER);
>> +    return order > 0 ? BIT(order + 1) - 1 : 0;
>> +}
>> +
>>   static unsigned int shmem_huge_global_enabled(struct inode *inode, 
>> pgoff_t index,
>>                             loff_t write_end, bool shmem_huge_force,
>> +                          struct vm_area_struct *vma,
>>                             unsigned long vm_flags)
>>   {
>> +    unsigned long within_size_orders;
>> +    unsigned int order;
>> +    pgoff_t aligned_index;
>>       loff_t i_size;
>>       if (HPAGE_PMD_ORDER > MAX_PAGECACHE_ORDER)
> 
> We can allow all orders up to MAX_PAGECACHE_ORDER, 
> shmem_mapping_size_orders() handles it properly.
> 
> So maybe we should drop this condition and use instead below where we have
> 
> return BIT(HPAGE_PMD_ORDER);
> 
> instead something like.
> 
> return HPAGE_PMD_ORDER > MAX_PAGECACHE_ORDER ? 0 : BIT(HPAGE_PMD_ORDER);
> 
> Ideally, factoring it out somehow
> 
> 
> int maybe_pmd_order = HPAGE_PMD_ORDER > MAX_PAGECACHE_ORDER ? 0 : 
> BIT(HPAGE_PMD_ORDER);
> 
> ...
> 
> return maybe_pmd_order;

Good point. Will do.

> 
>> @@ -564,15 +604,41 @@ static unsigned int 
>> shmem_huge_global_enabled(struct inode *inode, pgoff_t index
>>       if (shmem_huge_force || shmem_huge == SHMEM_HUGE_FORCE)
>>           return BIT(HPAGE_PMD_ORDER);
> 
> Why not force-enable all orders (of course, respecting 
> MAX_PAGECACHE_ORDER and possibly VMA)?

The ‘force’ option will affect the tmpfs mmap()'s huge allocation, which 
I intend to handle in a separate patch as we discussed. Additionally, 
for the huge page allocation of tmpfs mmap(), I am also considering the 
readahead approach for the pagecache.

>> +    /*
>> +     * The huge order allocation for anon shmem is controlled through
>> +     * the mTHP interface, so we still use PMD-sized huge order to
>> +     * check whether global control is enabled.
>> +     *
>> +     * For tmpfs mmap()'s huge order, we still use PMD-sized order to
>> +     * allocate huge pages due to lack of a write size hint.
>> +     *
>> +     * Otherwise, tmpfs will allow getting a highest order hint based on
>> +     * the size of write and fallocate paths, then will try each 
>> allowable
>> +     * huge orders.
>> +     */
>>       switch (SHMEM_SB(inode->i_sb)->huge) {
>>       case SHMEM_HUGE_ALWAYS:
>> -        return BIT(HPAGE_PMD_ORDER);
>> -    case SHMEM_HUGE_WITHIN_SIZE:
>> -        index = round_up(index + 1, HPAGE_PMD_NR);
>> -        i_size = max(write_end, i_size_read(inode));
>> -        i_size = round_up(i_size, PAGE_SIZE);
>> -        if (i_size >> PAGE_SHIFT >= index)
>> +        if (vma)
>>               return BIT(HPAGE_PMD_ORDER);
>> +
>> +        return shmem_mapping_size_orders(inode->i_mapping, index, 
>> write_end);
>> +    case SHMEM_HUGE_WITHIN_SIZE:
>> +        if (vma)
>> +            within_size_orders = BIT(HPAGE_PMD_ORDER);
>> +        else
>> +            within_size_orders = 
>> shmem_mapping_size_orders(inode->i_mapping,
>> +                                       index, write_end);
>> +
>> +        order = highest_order(within_size_orders);
>> +        while (within_size_orders) {
>> +            aligned_index = round_up(index + 1, 1 << order);
>> +            i_size = max(write_end, i_size_read(inode));
>> +            i_size = round_up(i_size, PAGE_SIZE);
>> +            if (i_size >> PAGE_SHIFT >= aligned_index)
>> +                return within_size_orders;
>> +
>> +            order = next_order(&within_size_orders, order);
>> +        }
>>           fallthrough;
>>       case SHMEM_HUGE_ADVISE:
>>           if (vm_flags & VM_HUGEPAGE)
> 
> I think the point here is that "write" -> no VMA -> vm_flags == 0 -> no 
> code changes needed :)

Yes. Currently the fadvise() have no HUGEPAGE handling, so I will drop 
the 'fadvise' in the doc.

