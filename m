Return-Path: <linux-kernel+bounces-280521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D522094CBA1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 09:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 675A81F23FCB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 07:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24CD17557C;
	Fri,  9 Aug 2024 07:50:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778CB18C908
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 07:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723189806; cv=none; b=o7kUMl6dlQTo3FMpoppTxw6d48lhezDLEECK6cfQIkCu0eYC3bzCYHX740TDBpitnQzgo8aSwOyUjuYW2KszCWgLgTfm8HHRtezeyBIBbeh6x/Oe9ABiBSRhErD4bMasE/bvJZBkqAVOlay0iro/VoNyrjst1Qvl8wz+4aY4+Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723189806; c=relaxed/simple;
	bh=wvowNK+xjpvrALPymf1A/xsuwNtpEMJYLAEFACXuZ6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YUxZ7TP52qAFileY+3Iv/m/Ia3uu4bQI/GLCi2EmaUARhbFTsix2662//EAEoktYa3HXJeKBx+E49erfTTIEI/7kT0K9ofwPuLZTBlYMQOPWHqtINYZw543otlGYH1Mpc/REsywSmYu1cGNzSUpVoMHDCYetZLEMKILmPgxQZQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79DCDFEC;
	Fri,  9 Aug 2024 00:50:29 -0700 (PDT)
Received: from [10.57.95.64] (unknown [10.57.95.64])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E46B3F6A8;
	Fri,  9 Aug 2024 00:50:02 -0700 (PDT)
Message-ID: <41658cce-6cd8-47bf-b9bd-657e0a362d11@arm.com>
Date: Fri, 9 Aug 2024 08:50:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm: add per-order mTHP split counters
Content-Language: en-GB
To: Barry Song <baohua@kernel.org>
Cc: Lance Yang <ioworker0@gmail.com>, akpm@linux-foundation.org,
 david@redhat.com, baolin.wang@linux.alibaba.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240424135148.30422-1-ioworker0@gmail.com>
 <20240424135148.30422-2-ioworker0@gmail.com>
 <a0f57d90-a556-4b19-a925-a82a81fbb067@arm.com>
 <CAGsJ_4xSKWXGY9TPS_kvhp7FALH16cyVnZu5FkHy3nN_hsZ_kQ@mail.gmail.com>
 <CAK1f24=rC+iEHkwAHmPBk=SUQ9HRHLA+Q7aKcADdO3uQSs9pnA@mail.gmail.com>
 <71fdab06-0442-4c55-811b-b38d3b024c85@arm.com>
 <CAGsJ_4zO52_xGpbJ5MrJLqoxbGShgrwLChWCcr8O6Q6oHzceDw@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAGsJ_4zO52_xGpbJ5MrJLqoxbGShgrwLChWCcr8O6Q6oHzceDw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 08/08/2024 22:27, Barry Song wrote:
> On Mon, Jul 1, 2024 at 8:16 PM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> On 30/06/2024 12:34, Lance Yang wrote:
>>> Hi Barry,
>>>
>>> Thanks for following up!
>>>
>>> On Sun, Jun 30, 2024 at 5:48 PM Barry Song <baohua@kernel.org> wrote:
>>>>
>>>> On Thu, Apr 25, 2024 at 3:41 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>>
>>>>> + Barry
>>>>>
>>>>> On 24/04/2024 14:51, Lance Yang wrote:
>>>>>> At present, the split counters in THP statistics no longer include
>>>>>> PTE-mapped mTHP. Therefore, this commit introduces per-order mTHP split
>>>>>> counters to monitor the frequency of mTHP splits. This will assist
>>>>>> developers in better analyzing and optimizing system performance.
>>>>>>
>>>>>> /sys/kernel/mm/transparent_hugepage/hugepages-<size>/stats
>>>>>>         split_page
>>>>>>         split_page_failed
>>>>>>         deferred_split_page
>>>>>>
>>>>>> Signed-off-by: Lance Yang <ioworker0@gmail.com>
>>>>>> ---
>>>>>>  include/linux/huge_mm.h |  3 +++
>>>>>>  mm/huge_memory.c        | 14 ++++++++++++--
>>>>>>  2 files changed, 15 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>>>>>> index 56c7ea73090b..7b9c6590e1f7 100644
>>>>>> --- a/include/linux/huge_mm.h
>>>>>> +++ b/include/linux/huge_mm.h
>>>>>> @@ -272,6 +272,9 @@ enum mthp_stat_item {
>>>>>>       MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
>>>>>>       MTHP_STAT_ANON_SWPOUT,
>>>>>>       MTHP_STAT_ANON_SWPOUT_FALLBACK,
>>>>>> +     MTHP_STAT_SPLIT_PAGE,
>>>>>> +     MTHP_STAT_SPLIT_PAGE_FAILED,
>>>>>> +     MTHP_STAT_DEFERRED_SPLIT_PAGE,
>>>>>>       __MTHP_STAT_COUNT
>>>>>>  };
>>>>>>
>>>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>>>> index 055df5aac7c3..52db888e47a6 100644
>>>>>> --- a/mm/huge_memory.c
>>>>>> +++ b/mm/huge_memory.c
>>>>>> @@ -557,6 +557,9 @@ DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTHP_STAT_ANON_FAULT_FALLBACK);
>>>>>>  DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
>>>>>>  DEFINE_MTHP_STAT_ATTR(anon_swpout, MTHP_STAT_ANON_SWPOUT);
>>>>>>  DEFINE_MTHP_STAT_ATTR(anon_swpout_fallback, MTHP_STAT_ANON_SWPOUT_FALLBACK);
>>>>>> +DEFINE_MTHP_STAT_ATTR(split_page, MTHP_STAT_SPLIT_PAGE);
>>>>>> +DEFINE_MTHP_STAT_ATTR(split_page_failed, MTHP_STAT_SPLIT_PAGE_FAILED);
>>>>>> +DEFINE_MTHP_STAT_ATTR(deferred_split_page, MTHP_STAT_DEFERRED_SPLIT_PAGE);
>>>>>>
>>>>>>  static struct attribute *stats_attrs[] = {
>>>>>>       &anon_fault_alloc_attr.attr,
>>>>>> @@ -564,6 +567,9 @@ static struct attribute *stats_attrs[] = {
>>>>>>       &anon_fault_fallback_charge_attr.attr,
>>>>>>       &anon_swpout_attr.attr,
>>>>>>       &anon_swpout_fallback_attr.attr,
>>>>>> +     &split_page_attr.attr,
>>>>>> +     &split_page_failed_attr.attr,
>>>>>> +     &deferred_split_page_attr.attr,
>>>>>>       NULL,
>>>>>>  };
>>>>>>
>>>>>> @@ -3083,7 +3089,7 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>>>>>>       XA_STATE_ORDER(xas, &folio->mapping->i_pages, folio->index, new_order);
>>>>>>       struct anon_vma *anon_vma = NULL;
>>>>>>       struct address_space *mapping = NULL;
>>>>>> -     bool is_thp = folio_test_pmd_mappable(folio);
>>>>>> +     int order = folio_order(folio);
>>>>>>       int extra_pins, ret;
>>>>>>       pgoff_t end;
>>>>>>       bool is_hzp;
>>>>>> @@ -3262,8 +3268,10 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>>>>>>               i_mmap_unlock_read(mapping);
>>>>>>  out:
>>>>>>       xas_destroy(&xas);
>>>>>> -     if (is_thp)
>>>>>> +     if (order >= HPAGE_PMD_ORDER)
>>>>>>               count_vm_event(!ret ? THP_SPLIT_PAGE : THP_SPLIT_PAGE_FAILED);
>>>>>> +     count_mthp_stat(order, !ret ? MTHP_STAT_SPLIT_PAGE :
>>>>>> +                                   MTHP_STAT_SPLIT_PAGE_FAILED);
>>>>>>       return ret;
>>>>>>  }
>>>>>>
>>>>>> @@ -3327,6 +3335,8 @@ void deferred_split_folio(struct folio *folio)
>>>>>>       if (list_empty(&folio->_deferred_list)) {
>>>>>>               if (folio_test_pmd_mappable(folio))
>>>>>>                       count_vm_event(THP_DEFERRED_SPLIT_PAGE);
>>>>>> +             count_mthp_stat(folio_order(folio),
>>>>>> +                             MTHP_STAT_DEFERRED_SPLIT_PAGE);
>>>>>
>>>>> There is a very long conversation with Barry about adding a 'global "mTHP became
>>>>> partially mapped 1 or more processes" counter (inc only)', which terminates at
>>>>> [1]. There is a lot of discussion about the required semantics around the need
>>>>> for partial map to cover alignment and contiguity as well as whether all pages
>>>>> are mapped, and to trigger once it becomes partial in at least 1 process.
>>>>>
>>>>> MTHP_STAT_DEFERRED_SPLIT_PAGE is giving much simpler semantics, but less
>>>>> information as a result. Barry, what's your view here? I'm guessing this doesn't
>>>>> quite solve what you are looking for?
>>>>
>>>> This doesn't quite solve what I am looking for but I still think the
>>>> patch has its value.
>>>>
>>>> I'm looking for a solution that can:
>>>>
>>>>   *  Count the amount of memory in the system for each mTHP size.
>>>>   *  Determine how much memory for each mTHP size is partially unmapped.
>>>>
>>>> For example, in a system with 16GB of memory, we might find that we have 3GB
>>>> of 64KB mTHP, and within that, 512MB is partially unmapped, potentially wasting
>>>> memory at this moment.  I'm uncertain whether Lance is interested in
>>>> this job :-)
>>>
>>> Nice, that's an interesting/valuable job for me ;)
>>>
>>> Let's do it separately, as 'split' and friends probably can’t be the
>>> solution you
>>> mentioned above, IMHO.
>>>
>>> Hmm... I don't have a good idea about the solution for now, but will
>>> think it over
>>> and come back to discuss it here.
>>
>> I have a grad starting in a couple of weeks and I had been planning to initially
>> ask him to look at this to help him get up to speed on mTHP/mm stuff. But I have
>> plenty of other things for him to do if Lance wants to take this :)
> 
> Hi Ryan, Lance,
> 
> My performance profiling is pending on the mTHP size and partially
> unmapped mTHP size issues (understanding the distribution of folio
> sizes within the system), so I'm not waiting for either Ryan's grad
> or Lance. I've sent an RFC for this, and both of you are CC'd:
> 
> https://lore.kernel.org/all/20240808010457.228753-1-21cnbao@gmail.com/

Yes I saw that, I'll try to give it some review today.

> 
> Apologies for not waiting.  You are still warmly welcomed to participate
> in the discussion and review.

No problem; after this last discussion, I assumed Lance was going to work on it
so there has been no duplicated effort from my side. Glad to see it implemented.

> 
>>
>>>
>>>>
>>>> Counting deferred_split remains valuable as it can signal whether the system is
>>>> experiencing significant partial unmapping.
>>>
>>> Have a nice weekend!
>>> Lance
>>>
>>>>
>>>>>
>>>>> [1] https://lore.kernel.org/linux-mm/6cc7d781-884f-4d8f-a175-8609732b87eb@arm.com/
>>>>>
>>>>> Thanks,
>>>>> Ryan
>>>>>
>>>>>>               list_add_tail(&folio->_deferred_list, &ds_queue->split_queue);
>>>>>>               ds_queue->split_queue_len++;
>>>>>>  #ifdef CONFIG_MEMCG
>>>>>
>>>>
> 
> Thanks
> Barry


