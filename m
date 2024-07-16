Return-Path: <linux-kernel+bounces-253679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 321EE9324DA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 13:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A163B21379
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 11:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9B819925F;
	Tue, 16 Jul 2024 11:14:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F099B199EB4
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 11:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721128485; cv=none; b=AQEuece7wBmtqPhES/rW0llV0GWWJHoeldmgSCvzBROry3mz6hSd0GJCDtd7xWZdhTnHN4mzl6PbfQqxSmoyObyxfbpyL8URfkdva3fYVvU+mWOhWdeItPAzH99yRUqbLA06gnw1hwn3Nu2F7TlcpEb+5f4qbld+SsStvssvzHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721128485; c=relaxed/simple;
	bh=A4ASAIAygHPA80+BfertKRDL/0UuZQwV8jMbZ331tko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U+M1FkEq6AU44hMeXDb6hTL4tThKeznRsTeVSFwEaEYE09YFlhU4TloXK03EY265UwL2jla+pH6mAyVqmJcEorQCAesgfnb58GFW0LGfO9xm0OnenaKMcNTvuJr3A67D7cPD37tn7LkTmsXR2FUQdmpljOEUWOatNyfRvbhE2U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9118F1063;
	Tue, 16 Jul 2024 04:15:07 -0700 (PDT)
Received: from [10.1.34.200] (XHFQ2J9959.cambridge.arm.com [10.1.34.200])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B46563F766;
	Tue, 16 Jul 2024 04:14:40 -0700 (PDT)
Message-ID: <f03deb7c-9a67-4096-9d33-32b357b52152@arm.com>
Date: Tue, 16 Jul 2024 12:14:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] mm: mTHP stats for pagecache folio allocations
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>, Lance Yang <ioworker0@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins
 <hughd@google.com>, Jonathan Corbet <corbet@lwn.net>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Barry Song <baohua@kernel.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20240711072929.3590000-1-ryan.roberts@arm.com>
 <20240711072929.3590000-3-ryan.roberts@arm.com>
 <9e0d84e5-2319-4425-9760-2c6bb23fc390@linux.alibaba.com>
 <CAK1f24nCDZM8aa9z_ZtgLbdj695JJri01q2HJUJb9pJt2uqy=w@mail.gmail.com>
 <756c359e-bb8f-481e-a33f-163c729afa31@redhat.com>
 <8c32a2fc-252d-406b-9fec-ce5bab0829df@arm.com>
 <a8441245-ae35-443f-9aea-325007492741@arm.com>
 <5c58d9ea-8490-4ae6-b7bf-be816dab3356@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <5c58d9ea-8490-4ae6-b7bf-be816dab3356@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 16/07/2024 11:19, David Hildenbrand wrote:
> On 16.07.24 10:31, Ryan Roberts wrote:
>> On 13/07/2024 11:45, Ryan Roberts wrote:
>>> On 13/07/2024 02:08, David Hildenbrand wrote:
>>>> On 12.07.24 14:22, Lance Yang wrote:
>>>>> On Fri, Jul 12, 2024 at 11:00 AM Baolin Wang
>>>>> <baolin.wang@linux.alibaba.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 2024/7/11 15:29, Ryan Roberts wrote:
>>>>>>> Expose 3 new mTHP stats for file (pagecache) folio allocations:
>>>>>>>
>>>>>>>      /sys/kernel/mm/transparent_hugepage/hugepages-*kB/stats/file_alloc
>>>>>>>      /sys/kernel/mm/transparent_hugepage/hugepages-*kB/stats/file_fallback
>>>>>>>    
>>>>>>> /sys/kernel/mm/transparent_hugepage/hugepages-*kB/stats/file_fallback_charge
>>>>>>>
>>>>>>> This will provide some insight on the sizes of large folios being
>>>>>>> allocated for file-backed memory, and how often allocation is failing.
>>>>>>>
>>>>>>> All non-order-0 (and most order-0) folio allocations are currently done
>>>>>>> through filemap_alloc_folio(), and folios are charged in a subsequent
>>>>>>> call to filemap_add_folio(). So count file_fallback when allocation
>>>>>>> fails in filemap_alloc_folio() and count file_alloc or
>>>>>>> file_fallback_charge in filemap_add_folio(), based on whether charging
>>>>>>> succeeded or not. There are some users of filemap_add_folio() that
>>>>>>> allocate their own order-0 folio by other means, so we would not count
>>>>>>> an allocation failure in this case, but we also don't care about order-0
>>>>>>> allocations. This approach feels like it should be good enough and
>>>>>>> doesn't require any (impractically large) refactoring.
>>>>>>>
>>>>>>> The existing mTHP stats interface is reused to provide consistency to
>>>>>>> users. And because we are reusing the same interface, we can reuse the
>>>>>>> same infrastructure on the kernel side. The one small wrinkle is that
>>>>>>> the set of folio sizes supported by the pagecache are not identical to
>>>>>>> those supported by anon and shmem; pagecache supports order-1, unlike
>>>>>>> anon and shmem, and the max pagecache order may be less than PMD-size
>>>>>>> (see arm64 with 64K base pages), again unlike anon and shmem. So we now
>>>>>>> create a hugepages-*kB directory for the union of the sizes supported by
>>>>>>> all 3 memory types and populate it with the relevant stats and controls.
>>>>>>
>>>>>> Personally, I like the idea that can help analyze the allocation of
>>>>>> large folios for the page cache.
>>>>>>
>>>>>> However, I have a slight concern about the consistency of the interface.
>>>>>>
>>>>>> For 64K, the fields layout:
>>>>>> ├── hugepages-64kB
>>>>>> │   ├── enabled
>>>>>> │   ├── shmem_enabled
>>>>>> │   └── stats
>>>>>> │       ├── anon_fault_alloc
>>>>>> │       ├── anon_fault_fallback
>>>>>> │       ├── anon_fault_fallback_charge
>>>>>> │       ├── file_alloc
>>>>>> │       ├── file_fallback
>>>>>> │       ├── file_fallback_charge
>>>>>> │       ├── shmem_alloc
>>>>>> │       ├── shmem_fallback
>>>>>> │       ├── shmem_fallback_charge
>>>>>> │       ├── split
>>>>>> │       ├── split_deferred
>>>>>> │       ├── split_failed
>>>>>> │       ├── swpout
>>>>>> │       └── swpout_fallback
>>>>>>
>>>>>> But for 8K (for pagecache), you removed some fields (of course, I
>>>>>> understand why they are not supported).
>>>>>>
>>>>>> ├── hugepages-8kB
>>>>>> │   └── stats
>>>>>> │       ├── file_alloc
>>>>>> │       ├── file_fallback
>>>>>> │       └── file_fallback_charge
>>>>>>
>>>>>> This might not be user-friendly for some user-space parsing tools, as
>>>>>> they lack certain fields for the same pattern interfaces. Of course,
>>>>>> this might not be an issue if we have clear documentation describing the
>>>>>> differences here:)
>>>>>>
>>>>>> Another possible approach is to maintain the same field layout to keep
>>>>>> consistent, but prohibit writing to the fields that are not supported by
>>>>>> the pagecache, and any stats read from them would be 0.
>>>>>
>>>>> I agree that maintaining a uniform field layout, especially at the stats
>>>>> level, might be necessary ;)
>>>>>
>>>>> Keeping a consistent interface could future-proof the design. It allows
>>>>> for the possibility that features not currently supported for 8kB pages
>>>>> might be enabled in the future.
>>>>
>>>> I'll just note that, with shmem/file effectively being disabled for order > 11,
>>>> we'll also have entries there that are effectively unused.
>>>
>>> Indeed, I mentioned that in the commit log :)
> 
> Well, I think it's more extreme than what you mentioned.
> 
> For example, shmem_enable on arm64 with 64k is now effectively non-functional.
> Just like it will be for other orders in the anon-shmem case when the order
> exceeds MAX_PAGECACHE_ORDER.

Ahh I see what you are saying now; we already have precedent for non-functional
controls.

(Actually, looking at the code, it looks like the shmem stats will be
unconditionally exposed, but the shmem controls will only be exposed when
CONFIG_SHMEM is enabled. I guess that should be fixed - I'll post a patch).

> 
>>>
>>>>
>>>> Good question how we want to deal with that (stats are easy, but what about
>>>> when
>>>> we enable something? Maybe we should document that "enabled" is only effective
>>>> when supported).
>>>
>>> The documentation already says "If enabling multiple hugepage sizes, the kernel
>>> will select the most appropriate enabled size for a given allocation." for anon
>>> THP (and I've added similar wording for my as-yet-unposted patch to add controls
>>> for page cache folio sizes). So I think we could easily add dummy *enabled
>>> controls for all sizes, that can be written to and read back consistently, but
>>> the kernel just ignores them when deciding what size to use. It would also
>>> simplify the code that populates the controls.
>>>
>>> Personally though, I'm not convinced of the value of trying to make the controls
>>> for every size look identical. What's the real value to the user to pretend that
>>> they can select a size that they cannot? What happens when we inevitably want to
>>> add some new control in future which only applies to select sizes and there is
>>> no good way to fake it for the other sizes? Why can't user space just be
>>> expected to rely on the existance of the files rather than on the existance of
>>> the directories?
>>>
>>> As always, I'll go with the majority, but just wanted to register my opinion.
>>
>> Should I assume from the lack of reply on this that everyone else is in favour
>> of adding dummy controls so that all sizes have the same set of controls? If I
>> don't hear anything further, I'll post v2 with dummry controls today or tomorrow.
> 
> Sorry, busy with other stuff.
> 
> Indicating only what really exists sounds cleaner. But I wonder how we would
> want to handle in general orders that are effectively non-existant?

I'm not following your distinction between orders that don't "really exist" and
orders that are "effectively non-existant".

I guess the real supported orders are:

  anon:
    min order: 2
    max order: PMD_ORDER
  anon-shmem:
    min order: 1
    max order: MAX_PAGECACHE_ORDER
  tmpfs-shmem:
    min order: PMD_ORDER <= 11 ? PMD_ORDER : NONE
    max order: PMD_ORDER <= 11 ? PMD_ORDER : NONE
  file:
    min order: 1
    max order: MAX_PAGECACHE_ORDER

But today, controls and stats are exposed for:

  anon:
    min order: 2
    max order: PMD_ORDER
  anon-shmem:
    min order: 2
    max order: PMD_ORDER
  tmpfs-shmem:
    min order: PMD_ORDER
    max order: PMD_ORDER
  file:
    min order: Nothing yet (this patch proposes 1)
    max order: Nothing yet (this patch proposes MAX_PAGECACHE_ORDER)

So I think there is definitely a bug for shmem where the minimum order control
should be order-1 but its currently order-2.

I also wonder about PUD-order for DAX? We don't currently have a stat/control.
If we wanted to add it in future, if we take the "expose all stats/controls for
all orders" approach, we would end up extending all the way to PUD-order and all
the orders between PMD and PUD would be dummy for all memory types. That really
starts to feel odd, so I still favour only populating what's really supported.

I propose to fix shmem (extend down to 1, stop at MAX_PAGECACHE_ORDER) and
continue with the approach of "indicating only what really exists" for v2.

Shout if you disagree.

Thanks,
Ryan


