Return-Path: <linux-kernel+bounces-242145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB10E92843D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 10:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58FFD1F22886
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 08:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1CA14658C;
	Fri,  5 Jul 2024 08:55:20 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7153713C809
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 08:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720169720; cv=none; b=gx1GR7Ex1xs8l9HnnR+EVzf/5R2hLtUWv+g/xD/G3Shis5SN8iFUq6Ll+Zk11evT1mDIyBVfOdUHJnjufnKWngmHS75HAA9E9/lhYsAL2WAIarAJm85cWeqyusjDDxg3kB86xoBgXOQO8AkVtgaMRN9wd+Ozs9IA/dG6zBw10Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720169720; c=relaxed/simple;
	bh=T+KklkpzTJzz7v9MtxyoQZ3FEfhFla1zATp2lIZDDpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k6q9cYkz8U569L0InNzKJpMqwpWXtrYIw3y5wwjeQBV6kJWL2tm8iyAA0GWdbfHz1cNuHAtRR9artuaA7EHpjdP24uTmNG9r4AJeIxeHPn/CIVh46gDLjpI4qgkmgcDsf0qOGPWQYS5c3FA51aHNHeQvYZ8LfS1KdaPphlS/Jcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8529D367;
	Fri,  5 Jul 2024 01:55:41 -0700 (PDT)
Received: from [10.57.74.223] (unknown [10.57.74.223])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 685F13F762;
	Fri,  5 Jul 2024 01:55:14 -0700 (PDT)
Message-ID: <781cefa8-7a55-46a5-914b-9097b00bd8db@arm.com>
Date: Fri, 5 Jul 2024 09:55:13 +0100
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
 <b33b94bb-38c7-4b54-bdd3-51dec0535438@arm.com>
 <4d8ee659-58ff-4dab-833e-84400bde932a@linux.alibaba.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <4d8ee659-58ff-4dab-833e-84400bde932a@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 05/07/2024 03:56, Baolin Wang wrote:
> 
> 
> On 2024/7/4 21:58, Ryan Roberts wrote:
>> On 04/07/2024 12:15, Baolin Wang wrote:
>>>
>>>
>>> On 2024/7/4 01:25, Ryan Roberts wrote:
>>>> On 11/06/2024 11:11, Baolin Wang wrote:
>>>>> Commit 19eaf44954df adds multi-size THP (mTHP) for anonymous pages, that
>>>>> can allow THP to be configured through the sysfs interface located at
>>>>> '/sys/kernel/mm/transparent_hugepage/hugepage-XXkb/enabled'.
>>>>>
>>>>> However, the anonymous shmem will ignore the anonymous mTHP rule
>>>>> configured through the sysfs interface, and can only use the PMD-mapped
>>>>> THP, that is not reasonable. Users expect to apply the mTHP rule for
>>>>> all anonymous pages, including the anonymous shmem, in order to enjoy
>>>>> the benefits of mTHP. For example, lower latency than PMD-mapped THP,
>>>>> smaller memory bloat than PMD-mapped THP, contiguous PTEs on ARM architecture
>>>>> to reduce TLB miss etc. In addition, the mTHP interfaces can be extended
>>>>> to support all shmem/tmpfs scenarios in the future, especially for the
>>>>> shmem mmap() case.
>>>>>
>>>>> The primary strategy is similar to supporting anonymous mTHP. Introduce
>>>>> a new interface '/mm/transparent_hugepage/hugepage-XXkb/shmem_enabled',
>>>>> which can have almost the same values as the top-level
>>>>> '/sys/kernel/mm/transparent_hugepage/shmem_enabled', with adding a new
>>>>> additional "inherit" option and dropping the testing options 'force' and
>>>>> 'deny'. By default all sizes will be set to "never" except PMD size,
>>>>> which is set to "inherit". This ensures backward compatibility with the
>>>>> anonymous shmem enabled of the top level, meanwhile also allows independent
>>>>> control of anonymous shmem enabled for each mTHP.
>>>>>
>>>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>>
>>>> [...]
>>>>
>>>> Hi Baolin,
>>>>
>>>> I'm currently trying to fix a bug where khugepaged is not started if only shmem
>>>> is enabled for THP. See discussion at [1]. It's been broken like this forever.
>>>>
>>>> Assuming anon and shmem THP are initially both disabled:
>>>>
>>>> # echo never > /sys/kernel/mm/transparent_hugepage/shmem_enabled
>>>> # echo never > /sys/kernel/mm/transparent_hugepage/enabled
>>>> <khugepaged is stopped here>
>>>>
>>>> Then shemem THP is enabled:
>>>>
>>>> # echo always > /sys/kernel/mm/transparent_hugepage/shmem_enabled
>>>> <khugepaged is not started, this is a bug>
>>>
>>> Thanks Ryan. Yes, this is a real problem.
>>>
>>>> As part of investigating the fix, I stumbled upon this patch, which I remember
>>>> reviewing an early version of but I've been out for a while and missed the
>>>> latter versions. See below for comments and questions; the answers to which
>>>> will
>>>> help me figure out how to fix the above...
>>>>
>>>> [1]
>>>> https://lore.kernel.org/linux-mm/20240702144617.2291480-1-ryan.roberts@arm.com/
>>>>
>>>>
>>>>>    +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>>>> +static unsigned long shmem_allowable_huge_orders(struct inode *inode,
>>>>> +                struct vm_area_struct *vma, pgoff_t index,
>>>>> +                bool global_huge)
>>>>> +{
>>>>> +    unsigned long mask = READ_ONCE(huge_shmem_orders_always);
>>>>> +    unsigned long within_size_orders =
>>>>> READ_ONCE(huge_shmem_orders_within_size);
>>>>> +    unsigned long vm_flags = vma->vm_flags;
>>>>> +    /*
>>>>> +     * Check all the (large) orders below HPAGE_PMD_ORDER + 1 that
>>>>> +     * are enabled for this vma.
>>>>> +     */
>>>>> +    unsigned long orders = BIT(PMD_ORDER + 1) - 1;
>>>>> +    loff_t i_size;
>>>>> +    int order;
>>>>> +
>>>>> +    if ((vm_flags & VM_NOHUGEPAGE) ||
>>>>> +        test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
>>>>> +        return 0;
>>>>> +
>>>>> +    /* If the hardware/firmware marked hugepage support disabled. */
>>>>> +    if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_UNSUPPORTED))
>>>>> +        return 0;
>>>>> +
>>>>> +    /*
>>>>> +     * Following the 'deny' semantics of the top level, force the huge
>>>>> +     * option off from all mounts.
>>>>> +     */
>>>>> +    if (shmem_huge == SHMEM_HUGE_DENY)
>>>>> +        return 0;
>>>>
>>>> I don't quite get this, I don't think its the desirable behaviour. This is
>>>> saying that if the top-level shemem_enabled control is set to 'deny', then all
>>>> mTHP sizes, regardless of their control's setting are disabled?
>>>>
>>>> The anon controls don't work like that; you can set the top-level control to
>>>> anything you like, but its only consumed if the per-size controls are
>>>> inheriting it.
>>>
>>> IMO, 'deny' option is not similar like 'never' option.
>>>
>>>>
>>>> So for the deny case, wouldn't it be better to allow that as an option on all
>>>> the per-size controls (and implicitly let it be inherrited from the top-level)?
>>>
>>>  From 'deny' option's semantics:
>>> "disables huge on shm_mnt and all mounts, for emergency use;"
>>
>> Right. Today, tmpfs only supports PMD-sized THP. So for all per-size controls
>> except the PMD-size control, 'deny' and 'never' would be the same practically
>> speaking. For the PMD-size control, 'deny' would disable THP for both anon shmem
>> and all tmpfs mounts, whereas 'never' would only disable THP for anon shmem.
>> When tmpfs gains mTHP support, 'deny' in the other per-size controls would also
>> disable that size for the tmpfs mounts.
> 
> Not really. We will not add 'deny' and 'force' testing option for each per-size
> mTHP control as suggested by Hugh in the previous MM meeting[1].
> 
> [1]
> https://lore.kernel.org/all/f1783ff0-65bd-4b2b-8952-52b6822a0835@redhat.com/T/#u
> 
>> I disagree with the current implementation where setting it up so that a
>> top-level 'deny' overrides whatever is in the per-size controls simply because
>> it's different to the model implemented for anon THP. That's my 2 cents. If
>> nobody else agrees then that ok - I'll fix the above bug according to the
>> current model.
> 
> I remember we have customers who use the 'deny' option to forcibly turn off the
> huge page option for all mounts (including shm_mnt). But if shmem/tmpfs uses
> mTHP and users set 'deny', they cannot force all huge orders off and they must
> also do 'echo never >
> /sys/kernel/mm/transparent_hugepage/hugepages-XXXkB/shmem_enabled' to disable
> all huge orders option, which breaks the previous user habits, IMHO.

But if they have enabled mTHP for shmem in the first place, they must be mTHP
aware. So its not unreasonable to expect them to call:

# echo deny > /sys/kernel/mm/transparent_hugepage/hugepages-XXXkB/shmem_enabled

That's the expectation for anon mTHP anyway. If the user enables mTHP then does:

# echo never > /sys/kernel/mm/transparent_hugepage/enabled

That *does not* disable all mTHP sizes. It only disables the sizes that have
been set to 'inherit'. The model is that a size is only influenced by the
top-level control if it has explicitly requested 'inherit'. But here you have
this special (and weird in my opinion) case where some values of the top-level
control apply unconditionally to the per-size control and some don't.

> 
> In additon, I do not think this creates a difference with the anon mTHP model,
> as anon mTHP does not have these shmem special 'deny' and 'force' options for
> testing purposes. In my view, the current 'deny' option fulfills the semantic
> definition of 'For use in emergencies, to force the *huge* option off from all
> mounts'.

OK. My opinion is logged :) But I'm not hearing anyone joining in support of
that opinion. I have a better understanding of the intent of your model as a
result of this discussion so thanks for that. As long as the documentation is
clear on this behaviour, let's leave it as is.

>>> It is usually used for testing to shut down all huge pages from the old ages.
>>> Moreover, mTHP interfaces will be used as a huge order filter to support tmpfs,
>>> so I think it will make life easier to disable all huge orders for testing or
>>> emergency use, as well as to maintain the original semantics.>
>>>>> +
>>>>> +    /*
>>>>> +     * Only allow inherit orders if the top-level value is 'force', which
>>>>> +     * means non-PMD sized THP can not override 'huge' mount option now.
>>>>> +     */
>>>>> +    if (shmem_huge == SHMEM_HUGE_FORCE)
>>>>> +        return READ_ONCE(huge_shmem_orders_inherit);
>>>>
>>>> I vaguely recall that we originally discussed that trying to set 'force' on the
>>>> top level control while any per-size controls were set to 'inherit' would be an
>>>> error, and trying to set 'force' on any per-size control except the PMD-size
>>>> would be an error?
>>>
>>> Right.
>>>
>>>> I don't really understand this logic. Shouldn't we just be looking at the
>>>> per-size control settings (or the top-level control as a proxy for every
>>>> per-size control that has 'inherit' set)?
>>>
>>> ‘force’ will apply the huge orders for anon shmem and tmpfs, so now we only
>>> allow pmd-mapped THP to be forced. We should not look at per-size control
>>> settings for tmpfs now (mTHP for tmpfs will be discussed in future).
>>
>> But why not just maintain per-size controls and refactor tmpfs to just look at
>> the PMD-size THP control for now. It can ignore the other sizes. That's much
>> simpler and cleaner IMHO.
> 
> As I said above, 'force' and 'deny' option will not be added for per-size controls.

Understood.

Thanks,
Ryan



