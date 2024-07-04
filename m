Return-Path: <linux-kernel+bounces-241148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 228DF92778F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 15:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46A851C23079
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 13:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2451AED55;
	Thu,  4 Jul 2024 13:58:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F21B1ABC25
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 13:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720101534; cv=none; b=Ra8tE45JhMgani5+k/nKiFMdyWk+FHQORsupf8X5vq6iD5fVcMGzwVYIABO+I8rzEpLaLC2c6zB3cJFrzEXXrBxP/19gzGYUn0xlO06WJfe776CFMTVdnuwF/eT3n034d/KzQLm/G1FYLJwOf933Zm9Qsppil6V2KAglDupGHkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720101534; c=relaxed/simple;
	bh=NTOx9bFT6IvHddfCo/EfoZfl9p7AxnBLNeNP7OtJyrM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MXDjVWki2vntZJdNjZNEtIwYJ/FKKRoKGQUHnRb0OIw72nDSKaoCcHLLOm+UaEHu4OicQ9cuR6yiQoRwv/fcfZZtKP6h33ossSmKCRx+Ey2tq2rfUGfLuH5WP6CMzjf7bdotHBf8sdgO1+J+6Sr6R9NhPbfOHz0LV3iOlkpa2Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F5BA367;
	Thu,  4 Jul 2024 06:59:15 -0700 (PDT)
Received: from [10.1.29.168] (XHFQ2J9959.cambridge.arm.com [10.1.29.168])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 21F933F766;
	Thu,  4 Jul 2024 06:58:48 -0700 (PDT)
Message-ID: <b33b94bb-38c7-4b54-bdd3-51dec0535438@arm.com>
Date: Thu, 4 Jul 2024 14:58:46 +0100
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
 <65c37315-2741-481f-b433-cec35ef1af35@arm.com>
 <475332ea-a80b-421c-855e-a663d1d5bfc7@linux.alibaba.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <475332ea-a80b-421c-855e-a663d1d5bfc7@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 04/07/2024 12:15, Baolin Wang wrote:
> 
> 
> On 2024/7/4 01:25, Ryan Roberts wrote:
>> On 11/06/2024 11:11, Baolin Wang wrote:
>>> Commit 19eaf44954df adds multi-size THP (mTHP) for anonymous pages, that
>>> can allow THP to be configured through the sysfs interface located at
>>> '/sys/kernel/mm/transparent_hugepage/hugepage-XXkb/enabled'.
>>>
>>> However, the anonymous shmem will ignore the anonymous mTHP rule
>>> configured through the sysfs interface, and can only use the PMD-mapped
>>> THP, that is not reasonable. Users expect to apply the mTHP rule for
>>> all anonymous pages, including the anonymous shmem, in order to enjoy
>>> the benefits of mTHP. For example, lower latency than PMD-mapped THP,
>>> smaller memory bloat than PMD-mapped THP, contiguous PTEs on ARM architecture
>>> to reduce TLB miss etc. In addition, the mTHP interfaces can be extended
>>> to support all shmem/tmpfs scenarios in the future, especially for the
>>> shmem mmap() case.
>>>
>>> The primary strategy is similar to supporting anonymous mTHP. Introduce
>>> a new interface '/mm/transparent_hugepage/hugepage-XXkb/shmem_enabled',
>>> which can have almost the same values as the top-level
>>> '/sys/kernel/mm/transparent_hugepage/shmem_enabled', with adding a new
>>> additional "inherit" option and dropping the testing options 'force' and
>>> 'deny'. By default all sizes will be set to "never" except PMD size,
>>> which is set to "inherit". This ensures backward compatibility with the
>>> anonymous shmem enabled of the top level, meanwhile also allows independent
>>> control of anonymous shmem enabled for each mTHP.
>>>
>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>
>> [...]
>>
>> Hi Baolin,
>>
>> I'm currently trying to fix a bug where khugepaged is not started if only shmem
>> is enabled for THP. See discussion at [1]. It's been broken like this forever.
>>
>> Assuming anon and shmem THP are initially both disabled:
>>
>> # echo never > /sys/kernel/mm/transparent_hugepage/shmem_enabled
>> # echo never > /sys/kernel/mm/transparent_hugepage/enabled
>> <khugepaged is stopped here>
>>
>> Then shemem THP is enabled:
>>
>> # echo always > /sys/kernel/mm/transparent_hugepage/shmem_enabled
>> <khugepaged is not started, this is a bug>
> 
> Thanks Ryan. Yes, this is a real problem.
> 
>> As part of investigating the fix, I stumbled upon this patch, which I remember
>> reviewing an early version of but I've been out for a while and missed the
>> latter versions. See below for comments and questions; the answers to which will
>> help me figure out how to fix the above...
>>
>> [1]
>> https://lore.kernel.org/linux-mm/20240702144617.2291480-1-ryan.roberts@arm.com/
>>
>>
>>>   +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>> +static unsigned long shmem_allowable_huge_orders(struct inode *inode,
>>> +                struct vm_area_struct *vma, pgoff_t index,
>>> +                bool global_huge)
>>> +{
>>> +    unsigned long mask = READ_ONCE(huge_shmem_orders_always);
>>> +    unsigned long within_size_orders =
>>> READ_ONCE(huge_shmem_orders_within_size);
>>> +    unsigned long vm_flags = vma->vm_flags;
>>> +    /*
>>> +     * Check all the (large) orders below HPAGE_PMD_ORDER + 1 that
>>> +     * are enabled for this vma.
>>> +     */
>>> +    unsigned long orders = BIT(PMD_ORDER + 1) - 1;
>>> +    loff_t i_size;
>>> +    int order;
>>> +
>>> +    if ((vm_flags & VM_NOHUGEPAGE) ||
>>> +        test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
>>> +        return 0;
>>> +
>>> +    /* If the hardware/firmware marked hugepage support disabled. */
>>> +    if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_UNSUPPORTED))
>>> +        return 0;
>>> +
>>> +    /*
>>> +     * Following the 'deny' semantics of the top level, force the huge
>>> +     * option off from all mounts.
>>> +     */
>>> +    if (shmem_huge == SHMEM_HUGE_DENY)
>>> +        return 0;
>>
>> I don't quite get this, I don't think its the desirable behaviour. This is
>> saying that if the top-level shemem_enabled control is set to 'deny', then all
>> mTHP sizes, regardless of their control's setting are disabled?
>>
>> The anon controls don't work like that; you can set the top-level control to
>> anything you like, but its only consumed if the per-size controls are
>> inheriting it.
> 
> IMO, 'deny' option is not similar like 'never' option.
> 
>>
>> So for the deny case, wouldn't it be better to allow that as an option on all
>> the per-size controls (and implicitly let it be inherrited from the top-level)?
> 
> From 'deny' option's semantics:
> "disables huge on shm_mnt and all mounts, for emergency use;"

Right. Today, tmpfs only supports PMD-sized THP. So for all per-size controls
except the PMD-size control, 'deny' and 'never' would be the same practically
speaking. For the PMD-size control, 'deny' would disable THP for both anon shmem
and all tmpfs mounts, whereas 'never' would only disable THP for anon shmem.
When tmpfs gains mTHP support, 'deny' in the other per-size controls would also
disable that size for the tmpfs mounts.

I disagree with the current implementation where setting it up so that a
top-level 'deny' overrides whatever is in the per-size controls simply because
it's different to the model implemented for anon THP. That's my 2 cents. If
nobody else agrees then that ok - I'll fix the above bug according to the
current model.

> 
> It is usually used for testing to shut down all huge pages from the old ages.
> Moreover, mTHP interfaces will be used as a huge order filter to support tmpfs,
> so I think it will make life easier to disable all huge orders for testing or
> emergency use, as well as to maintain the original semantics.>
>>> +
>>> +    /*
>>> +     * Only allow inherit orders if the top-level value is 'force', which
>>> +     * means non-PMD sized THP can not override 'huge' mount option now.
>>> +     */
>>> +    if (shmem_huge == SHMEM_HUGE_FORCE)
>>> +        return READ_ONCE(huge_shmem_orders_inherit);
>>
>> I vaguely recall that we originally discussed that trying to set 'force' on the
>> top level control while any per-size controls were set to 'inherit' would be an
>> error, and trying to set 'force' on any per-size control except the PMD-size
>> would be an error?
> 
> Right.
> 
>> I don't really understand this logic. Shouldn't we just be looking at the
>> per-size control settings (or the top-level control as a proxy for every
>> per-size control that has 'inherit' set)?
> 
> ‘force’ will apply the huge orders for anon shmem and tmpfs, so now we only
> allow pmd-mapped THP to be forced. We should not look at per-size control
> settings for tmpfs now (mTHP for tmpfs will be discussed in future).

But why not just maintain per-size controls and refactor tmpfs to just look at
the PMD-size THP control for now. It can ignore the other sizes. That's much
simpler and cleaner IMHO.

> 
>>
>> Then for tmpfs, which doesn't support non-PMD-sizes yet, we just always use the
>> PMD-size control for decisions.
>>
>> I'm also really struggling with the concept of shmem_is_huge() existing along
>> side shmem_allowable_huge_orders(). Surely this needs to all be refactored into
>> shmem_allowable_huge_orders()?
> 
> I understood. But now they serve different purposes: shmem_is_huge() will be
> used to check the huge orders for the top level, for *tmpfs* and anon shmem;
> whereas shmem_allowable_huge_orders() will only be used to check the per-size
> huge orders for anon shmem (excluding tmpfs now). However, as I plan to add mTHP
> support for tmpfs, I think we can perform some cleanups.
> 
>>> +    /* Allow mTHP that will be fully within i_size. */
>>> +    order = highest_order(within_size_orders);
>>> +    while (within_size_orders) {
>>> +        index = round_up(index + 1, order);
>>> +        i_size = round_up(i_size_read(inode), PAGE_SIZE);
>>> +        if (i_size >> PAGE_SHIFT >= index) {
>>> +            mask |= within_size_orders;
>>> +            break;
>>> +        }
>>> +
>>> +        order = next_order(&within_size_orders, order);
>>> +    }
>>> +
>>> +    if (vm_flags & VM_HUGEPAGE)
>>> +        mask |= READ_ONCE(huge_shmem_orders_madvise);
>>> +
>>> +    if (global_huge)
>>
>> Perhaps I've misunderstood global_huge, but I think its just the return value
>> from shmem_is_huge()? But you're also using shmem_huge directly in this
> 
> Yes.
> 
>> function. I find it all rather confusing.
> 
> I think I have explained why need these logics as above. Since mTHP support for
> shmem has just started (tmpfs is still in progress). I will make it more clear
> in the following patches.

OK as long as you have a plan for the clean up, that's good enough for me.

> 
>> Sorry if all this was discussed and agreed in my absence! But I think this needs
>> to be sorted in order to do the bug fix for khugepaged properly.
> 
> No worries. Thanks for your input.


