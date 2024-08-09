Return-Path: <linux-kernel+bounces-280613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AD494CCCD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 11:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF7311F21507
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 09:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D14D18E03A;
	Fri,  9 Aug 2024 09:00:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081C3C8D1
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 09:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723194028; cv=none; b=sOEXVQooAaVbY3m0kGEKltWlcrha6TXM/z7Mx1QFlw3oMzfnWSah0wAx9IRgyretxJAAHJgunqS9Ua1vnbj2nuG6Fnv7hATlWw0VtOwjKBjCC1bCrvv4cbxckmsQkCNbi1/l2YpiuzbnrMdxw5SJJ6/ILIBG60eTlwoRZNERuvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723194028; c=relaxed/simple;
	bh=/g6qj860acWqOWhRZdZ+bEN6+0J0OtAeu286wDE0O2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lFN9aY4Lwyt7ATkM2FTtHKjZPZbpwtrPcUk5/G45kBf3FdmvCdcZ8hexGxicCxUdPYQS83ZOS2iqHYgbxeRlX6IQDFz5yLHhBs6I4CLiS3Xsn+ATRXIqn6vEPqngvkcDD1raRUh7nrsU0VzHkpllbikjnpJihFIwalxaLgnz1ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 00A49FEC;
	Fri,  9 Aug 2024 02:00:51 -0700 (PDT)
Received: from [10.57.95.64] (unknown [10.57.95.64])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 21D0E3F6A8;
	Fri,  9 Aug 2024 02:00:22 -0700 (PDT)
Message-ID: <7e55d6eb-3384-4cc0-80ea-880ef2175121@arm.com>
Date: Fri, 9 Aug 2024 10:00:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/2] mm: collect the number of anon large folios
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>, Barry Song <21cnbao@gmail.com>,
 akpm@linux-foundation.org, linux-mm@kvack.org
Cc: chrisl@kernel.org, kaleshsingh@google.com, kasong@tencent.com,
 linux-kernel@vger.kernel.org, ioworker0@gmail.com,
 baolin.wang@linux.alibaba.com, ziy@nvidia.com, hanchuanhua@oppo.com,
 Barry Song <v-songbaohua@oppo.com>
References: <20240808010457.228753-1-21cnbao@gmail.com>
 <20240808010457.228753-2-21cnbao@gmail.com>
 <e9f82fd8-e1da-49ea-a735-b174575c02bc@arm.com>
 <537d7a30-2ad8-4c31-9ad3-ad86f1a7b519@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <537d7a30-2ad8-4c31-9ad3-ad86f1a7b519@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 09/08/2024 09:39, David Hildenbrand wrote:
> On 09.08.24 10:13, Ryan Roberts wrote:
>> On 08/08/2024 02:04, Barry Song wrote:
>>> From: Barry Song <v-songbaohua@oppo.com>
>>>
>>> When a new anonymous mTHP is added to the rmap, we increase the count.
>>> We reduce the count whenever an mTHP is completely unmapped.
>>>
>>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>>> ---
>>>   Documentation/admin-guide/mm/transhuge.rst |  5 +++++
>>>   include/linux/huge_mm.h                    | 15 +++++++++++++--
>>>   mm/huge_memory.c                           |  2 ++
>>>   mm/rmap.c                                  |  3 +++
>>>   4 files changed, 23 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/admin-guide/mm/transhuge.rst
>>> b/Documentation/admin-guide/mm/transhuge.rst
>>> index 058485daf186..715f181543f6 100644
>>> --- a/Documentation/admin-guide/mm/transhuge.rst
>>> +++ b/Documentation/admin-guide/mm/transhuge.rst
>>> @@ -527,6 +527,11 @@ split_deferred
>>>           it would free up some memory. Pages on split queue are going to
>>>           be split under memory pressure, if splitting is possible.
>>>   +anon_num
>>> +       the number of anon huge pages we have in the whole system.
>>> +       These huge pages could be still entirely mapped and have partially
>>> +       unmapped and unused subpages.
>>
>> nit: "entirely mapped and have partially unmapped and unused subpages" ->
>> "entirely mapped or have partially unmapped/unused subpages"
>>
>>> +
>>>   As the system ages, allocating huge pages may be expensive as the
>>>   system uses memory compaction to copy data around memory to free a
>>>   huge page for use. There are some counters in ``/proc/vmstat`` to help
>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>>> index e25d9ebfdf89..294c348fe3cc 100644
>>> --- a/include/linux/huge_mm.h
>>> +++ b/include/linux/huge_mm.h
>>> @@ -281,6 +281,7 @@ enum mthp_stat_item {
>>>       MTHP_STAT_SPLIT,
>>>       MTHP_STAT_SPLIT_FAILED,
>>>       MTHP_STAT_SPLIT_DEFERRED,
>>> +    MTHP_STAT_NR_ANON,
>>>       __MTHP_STAT_COUNT
>>>   };
>>>   @@ -291,14 +292,24 @@ struct mthp_stat {
>>>   #ifdef CONFIG_SYSFS
>>>   DECLARE_PER_CPU(struct mthp_stat, mthp_stats);
>>>   -static inline void count_mthp_stat(int order, enum mthp_stat_item item)
>>> +static inline void mod_mthp_stat(int order, enum mthp_stat_item item, int
>>> delta)
>>>   {
>>>       if (order <= 0 || order > PMD_ORDER)
>>>           return;
>>>   -    this_cpu_inc(mthp_stats.stats[order][item]);
>>> +    this_cpu_add(mthp_stats.stats[order][item], delta);
>>> +}
>>> +
>>> +static inline void count_mthp_stat(int order, enum mthp_stat_item item)
>>> +{
>>> +    mod_mthp_stat(order, item, 1);
>>>   }
>>> +
>>>   #else
>>> +static inline void mod_mthp_stat(int order, enum mthp_stat_item item, int
>>> delta)
>>> +{
>>> +}
>>> +
>>>   static inline void count_mthp_stat(int order, enum mthp_stat_item item)
>>>   {
>>>   }
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index 697fcf89f975..b6bc2a3791e3 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -578,6 +578,7 @@ DEFINE_MTHP_STAT_ATTR(shmem_fallback_charge,
>>> MTHP_STAT_SHMEM_FALLBACK_CHARGE);
>>>   DEFINE_MTHP_STAT_ATTR(split, MTHP_STAT_SPLIT);
>>>   DEFINE_MTHP_STAT_ATTR(split_failed, MTHP_STAT_SPLIT_FAILED);
>>>   DEFINE_MTHP_STAT_ATTR(split_deferred, MTHP_STAT_SPLIT_DEFERRED);
>>> +DEFINE_MTHP_STAT_ATTR(anon_num, MTHP_STAT_NR_ANON);
>>>     static struct attribute *stats_attrs[] = {
>>>       &anon_fault_alloc_attr.attr,
>>> @@ -591,6 +592,7 @@ static struct attribute *stats_attrs[] = {
>>>       &split_attr.attr,
>>>       &split_failed_attr.attr,
>>>       &split_deferred_attr.attr,
>>> +    &anon_num_attr.attr,
>>>       NULL,
>>>   };
>>>   diff --git a/mm/rmap.c b/mm/rmap.c
>>> index 901950200957..2b722f26224c 100644
>>> --- a/mm/rmap.c
>>> +++ b/mm/rmap.c
>>> @@ -1467,6 +1467,7 @@ void folio_add_new_anon_rmap(struct folio *folio,
>>> struct vm_area_struct *vma,
>>>       }
>>>         __folio_mod_stat(folio, nr, nr_pmdmapped);
>>> +    mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON, 1);
>>>   }
>>>     static __always_inline void __folio_add_file_rmap(struct folio *folio,
>>> @@ -1582,6 +1583,8 @@ static __always_inline void __folio_remove_rmap(struct
>>> folio *folio,
>>>           list_empty(&folio->_deferred_list))
>>>           deferred_split_folio(folio);
>>>       __folio_mod_stat(folio, -nr, -nr_pmdmapped);
>>> +    if (folio_test_anon(folio) && !atomic_read(mapped))
>>
>> Agree that atomic_read() is dodgy here.
>>
>> Not sure I fully understand why David prefers to do the unaccounting at
>> free-time though? It feels unbalanced to me to increment when first mapped but
>> decrement when freed. Surely its safer to either use alloc/free or use first
>> map/last map?
> 
> Doing it when we set/clear folio->mapping is straight forward.
> 
> Anon folios currently come to live when we first map them, and they stay that
> way until we free them.
> 
> In the future, we'll have to move that anon handling further out, when if have
> to allocate anon-specific memdesc ahead of time, then, it will be clued to that
> lifetime.
> 
>>
>> If using alloc/free isn't there a THP constructor/destructor that prepares the
>> deferred list? (My memory may be failing me). Could we use that?
> 
> Likely the deconstructor could work as well. Not sure if that is any better than
> the freeing path where folio->mapping currently gets cleared.
> 
> The generic constructor certainly won't work right now. That's not where the
> "anon" part comes to live.
> 
> Let's take a look how NR_FILE_THPS is handled:
> 
> __filemap_add_folio() increments it -- when we set folio->mapping
> __filemap_remove_folio() (->filemap_unaccount_folio) decrements it -- after
> which we usually call page_cache_delete() to set folio->mapping = NULL;
> 

OK got it, thanks!


