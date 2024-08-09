Return-Path: <linux-kernel+bounces-280561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF48894CC29
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 10:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B1EC1C214D9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 08:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E0F18DF7B;
	Fri,  9 Aug 2024 08:27:28 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76C517556C
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 08:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723192047; cv=none; b=jk6el6CKhq0IjJEfhL2zTigjXaHCMOqnujQSM7czpi4sFE5zr3KJQPUTbwv/SrRpnUEOHVE/FcwVJv7hKrbo0NWgVStkRTmyBxH9Y4MyxYP42IbCGTg3/+IbOuzSPd3mJxDqBxQ0a1q9jfPKKd0c8qZJRWo7K3H3xkfHRnaODTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723192047; c=relaxed/simple;
	bh=l0fYxfMbpqasnGNrj5CdzGJRfT6q4tbYxcGMGdENI3s=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=jlG3+PI0cd4qd9g/9H5FzakQcgUQqmmaERwnZyH1yl6oc2gx+khm64WxIbFdOIffriQ6ggvM+OYhUWW61cMkEqRcxqwjtAb83dMWL3cdypaMm4B927zkDQ/3cefZPE2AoODxNHkF0SawZ9oSf3Qc7Dfsv0tHk7L1GP/g4WFi25U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 12EF4FEC;
	Fri,  9 Aug 2024 01:27:51 -0700 (PDT)
Received: from [10.57.95.64] (unknown [10.57.95.64])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F4E93F6A8;
	Fri,  9 Aug 2024 01:27:23 -0700 (PDT)
Message-ID: <1222cd76-e732-4238-9413-61843249c1e8@arm.com>
Date: Fri, 9 Aug 2024 09:27:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/2] mm: collect the number of anon large folios
Content-Language: en-GB
From: Ryan Roberts <ryan.roberts@arm.com>
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: chrisl@kernel.org, david@redhat.com, kaleshsingh@google.com,
 kasong@tencent.com, linux-kernel@vger.kernel.org, ioworker0@gmail.com,
 baolin.wang@linux.alibaba.com, ziy@nvidia.com, hanchuanhua@oppo.com,
 Barry Song <v-songbaohua@oppo.com>
References: <20240808010457.228753-1-21cnbao@gmail.com>
 <20240808010457.228753-2-21cnbao@gmail.com>
 <e9f82fd8-e1da-49ea-a735-b174575c02bc@arm.com>
In-Reply-To: <e9f82fd8-e1da-49ea-a735-b174575c02bc@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/08/2024 09:13, Ryan Roberts wrote:
> On 08/08/2024 02:04, Barry Song wrote:
>> From: Barry Song <v-songbaohua@oppo.com>
>>
>> When a new anonymous mTHP is added to the rmap, we increase the count.
>> We reduce the count whenever an mTHP is completely unmapped.
>>
>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>> ---
>>  Documentation/admin-guide/mm/transhuge.rst |  5 +++++
>>  include/linux/huge_mm.h                    | 15 +++++++++++++--
>>  mm/huge_memory.c                           |  2 ++
>>  mm/rmap.c                                  |  3 +++
>>  4 files changed, 23 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
>> index 058485daf186..715f181543f6 100644
>> --- a/Documentation/admin-guide/mm/transhuge.rst
>> +++ b/Documentation/admin-guide/mm/transhuge.rst
>> @@ -527,6 +527,11 @@ split_deferred
>>          it would free up some memory. Pages on split queue are going to
>>          be split under memory pressure, if splitting is possible.
>>  
>> +anon_num
>> +       the number of anon huge pages we have in the whole system.
>> +       These huge pages could be still entirely mapped and have partially
>> +       unmapped and unused subpages.
> 
> nit: "entirely mapped and have partially unmapped and unused subpages" ->
> "entirely mapped or have partially unmapped/unused subpages"
> 
>> +
>>  As the system ages, allocating huge pages may be expensive as the
>>  system uses memory compaction to copy data around memory to free a
>>  huge page for use. There are some counters in ``/proc/vmstat`` to help
>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>> index e25d9ebfdf89..294c348fe3cc 100644
>> --- a/include/linux/huge_mm.h
>> +++ b/include/linux/huge_mm.h
>> @@ -281,6 +281,7 @@ enum mthp_stat_item {
>>  	MTHP_STAT_SPLIT,
>>  	MTHP_STAT_SPLIT_FAILED,
>>  	MTHP_STAT_SPLIT_DEFERRED,
>> +	MTHP_STAT_NR_ANON,
>>  	__MTHP_STAT_COUNT
>>  };
>>  
>> @@ -291,14 +292,24 @@ struct mthp_stat {
>>  #ifdef CONFIG_SYSFS
>>  DECLARE_PER_CPU(struct mthp_stat, mthp_stats);
>>  
>> -static inline void count_mthp_stat(int order, enum mthp_stat_item item)
>> +static inline void mod_mthp_stat(int order, enum mthp_stat_item item, int delta)
>>  {
>>  	if (order <= 0 || order > PMD_ORDER)
>>  		return;
>>  
>> -	this_cpu_inc(mthp_stats.stats[order][item]);
>> +	this_cpu_add(mthp_stats.stats[order][item], delta);
>> +}
>> +
>> +static inline void count_mthp_stat(int order, enum mthp_stat_item item)
>> +{
>> +	mod_mthp_stat(order, item, 1);
>>  }
>> +
>>  #else
>> +static inline void mod_mthp_stat(int order, enum mthp_stat_item item, int delta)
>> +{
>> +}
>> +
>>  static inline void count_mthp_stat(int order, enum mthp_stat_item item)
>>  {
>>  }
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 697fcf89f975..b6bc2a3791e3 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -578,6 +578,7 @@ DEFINE_MTHP_STAT_ATTR(shmem_fallback_charge, MTHP_STAT_SHMEM_FALLBACK_CHARGE);
>>  DEFINE_MTHP_STAT_ATTR(split, MTHP_STAT_SPLIT);
>>  DEFINE_MTHP_STAT_ATTR(split_failed, MTHP_STAT_SPLIT_FAILED);
>>  DEFINE_MTHP_STAT_ATTR(split_deferred, MTHP_STAT_SPLIT_DEFERRED);
>> +DEFINE_MTHP_STAT_ATTR(anon_num, MTHP_STAT_NR_ANON);

Why are the user-facing and internal names different? Perhaps it would be
clearer to call this nr_anon in sysfs?

>>  
>>  static struct attribute *stats_attrs[] = {
>>  	&anon_fault_alloc_attr.attr,
>> @@ -591,6 +592,7 @@ static struct attribute *stats_attrs[] = {
>>  	&split_attr.attr,
>>  	&split_failed_attr.attr,
>>  	&split_deferred_attr.attr,
>> +	&anon_num_attr.attr,
>>  	NULL,
>>  };
>>  
>> diff --git a/mm/rmap.c b/mm/rmap.c
>> index 901950200957..2b722f26224c 100644
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -1467,6 +1467,7 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
>>  	}
>>  
>>  	__folio_mod_stat(folio, nr, nr_pmdmapped);
>> +	mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON, 1);
>>  }
>>  
>>  static __always_inline void __folio_add_file_rmap(struct folio *folio,
>> @@ -1582,6 +1583,8 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
>>  	    list_empty(&folio->_deferred_list))
>>  		deferred_split_folio(folio);
>>  	__folio_mod_stat(folio, -nr, -nr_pmdmapped);
>> +	if (folio_test_anon(folio) && !atomic_read(mapped))
> 
> Agree that atomic_read() is dodgy here.
> 
> Not sure I fully understand why David prefers to do the unaccounting at
> free-time though? It feels unbalanced to me to increment when first mapped but
> decrement when freed. Surely its safer to either use alloc/free or use first
> map/last map?
> 
> If using alloc/free isn't there a THP constructor/destructor that prepares the
> deferred list? (My memory may be failing me). Could we use that?

Additionally, if we wanted to extend (eventually) to track the number of shmem
and file mthps in additional counters, could we also account using similar folio
free-time hooks? If not, it might be an argument to account in rmap_unmap to be
consistent for all?


> 
>> +		mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON, -1);
>>  
>>  	/*
>>  	 * It would be tidy to reset folio_test_anon mapping when fully
> 


