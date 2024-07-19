Return-Path: <linux-kernel+bounces-257114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F3A937565
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 10:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC9031F21829
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 08:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F4D7CF30;
	Fri, 19 Jul 2024 08:56:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2DA3236
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 08:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721379403; cv=none; b=HeU6ZzXGxM6mofPjm6sWrRgjjLi6EyBA5Xx/ZkUUC6ENea2t8rsUaQa+uIly7/WXViXwr8FFgZbXNAhchIP8xTDXgwJRF3FPGPdMQWhbs3/bb1r6vTChcXs8fi7C++8gC/Ij0HGWEYvRuSTjr8CDLLJjz6Qn5CJdAK0tOGmsyjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721379403; c=relaxed/simple;
	bh=/uHY1h/nqn5QYu99ESjDs6FonOEec8RKGoklHW0LIjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s8Sdc1zCxoIK43dZ3WI1gnFpEzcZ83tpiC6hhmlgtGSdBPBpHXGY+3AKqG1lZQH2CYZWnAVu2Vwi1/vlQWFbpMkkdl0B9ct1Pt4/mtBC9vMpV0yojoM1wuDsL+1g+vI34P4czBj26RZpvcArA9jJYrerLm8pMNphsl5eyFHUDaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD3091042;
	Fri, 19 Jul 2024 01:57:04 -0700 (PDT)
Received: from [10.57.76.151] (unknown [10.57.76.151])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D2DFD3F762;
	Fri, 19 Jul 2024 01:56:37 -0700 (PDT)
Message-ID: <223acdf2-ba25-4c31-94df-a212d31bd6c3@arm.com>
Date: Fri, 19 Jul 2024 09:56:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] mm: mTHP stats for pagecache folio allocations
Content-Language: en-GB
To: Barry Song <baohua@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins
 <hughd@google.com>, Jonathan Corbet <corbet@lwn.net>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 David Hildenbrand <david@redhat.com>, Lance Yang <ioworker0@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Gavin Shan <gshan@redhat.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240716135907.4047689-1-ryan.roberts@arm.com>
 <20240716135907.4047689-4-ryan.roberts@arm.com>
 <CAGsJ_4xfiVNH-cQtD_rMrHvzx1a9Ap6CcqsqbxyAEOTB-9Jvhw@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAGsJ_4xfiVNH-cQtD_rMrHvzx1a9Ap6CcqsqbxyAEOTB-9Jvhw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 19/07/2024 01:12, Barry Song wrote:
> On Wed, Jul 17, 2024 at 1:59 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> Expose 3 new mTHP stats for file (pagecache) folio allocations:
>>
>>   /sys/kernel/mm/transparent_hugepage/hugepages-*kB/stats/file_alloc
>>   /sys/kernel/mm/transparent_hugepage/hugepages-*kB/stats/file_fallback
>>   /sys/kernel/mm/transparent_hugepage/hugepages-*kB/stats/file_fallback_charge
>>
>> This will provide some insight on the sizes of large folios being
>> allocated for file-backed memory, and how often allocation is failing.
>>
>> All non-order-0 (and most order-0) folio allocations are currently done
>> through filemap_alloc_folio(), and folios are charged in a subsequent
>> call to filemap_add_folio(). So count file_fallback when allocation
>> fails in filemap_alloc_folio() and count file_alloc or
>> file_fallback_charge in filemap_add_folio(), based on whether charging
>> succeeded or not. There are some users of filemap_add_folio() that
>> allocate their own order-0 folio by other means, so we would not count
>> an allocation failure in this case, but we also don't care about order-0
>> allocations. This approach feels like it should be good enough and
>> doesn't require any (impractically large) refactoring.
>>
>> The existing mTHP stats interface is reused to provide consistency to
>> users. And because we are reusing the same interface, we can reuse the
>> same infrastructure on the kernel side.
>>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>  Documentation/admin-guide/mm/transhuge.rst | 13 +++++++++++++
>>  include/linux/huge_mm.h                    |  3 +++
>>  include/linux/pagemap.h                    | 16 ++++++++++++++--
>>  mm/filemap.c                               |  6 ++++--
>>  mm/huge_memory.c                           |  7 +++++++
>>  5 files changed, 41 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
>> index 058485daf186..d4857e457add 100644
>> --- a/Documentation/admin-guide/mm/transhuge.rst
>> +++ b/Documentation/admin-guide/mm/transhuge.rst
>> @@ -512,6 +512,19 @@ shmem_fallback_charge
>>         falls back to using small pages even though the allocation was
>>         successful.
>>
>> +file_alloc
>> +       is incremented every time a file huge page is successfully
>> +       allocated.
>> +
>> +file_fallback
>> +       is incremented if a file huge page is attempted to be allocated
>> +       but fails and instead falls back to using small pages.
>> +
>> +file_fallback_charge
>> +       is incremented if a file huge page cannot be charged and instead
>> +       falls back to using small pages even though the allocation was
>> +       successful.
>> +
> 
> I realized that when we talk about fallback, it doesn't necessarily mean
> small pages; it could also refer to smaller huge pages.

Yes good point, I'll update the documentation to reflect that for all memory types.

> 
> anon_fault_alloc
>         is incremented every time a huge page is successfully
>         allocated and charged to handle a page fault.
> 
> anon_fault_fallback
>         is incremented if a page fault fails to allocate or charge
>         a huge page and instead falls back to using huge pages with
>         lower orders or small pages.
> 
> anon_fault_fallback_charge
>         is incremented if a page fault fails to charge a huge page and
>         instead falls back to using huge pages with lower orders or
>         small pages even though the allocation was successful.
> 
> This also applies to files, right?

It does in the place you highlight below, but page_cache_ra_order() just falls
back immediately to order-0. Regardless, I think we should just document the
user facing docs to allow for a lower high order. That gives the implementation
more flexibility.

> 
>                 do {
>                         gfp_t alloc_gfp = gfp;
> 
>                         err = -ENOMEM;
>                         if (order > 0)
>                                 alloc_gfp |= __GFP_NORETRY | __GFP_NOWARN;
>                         folio = filemap_alloc_folio(alloc_gfp, order);
>                         if (!folio)
>                                 continue;
> 
>                         /* Init accessed so avoid atomic
> mark_page_accessed later */
>                         if (fgp_flags & FGP_ACCESSED)
>                                 __folio_set_referenced(folio);
> 
>                         err = filemap_add_folio(mapping, folio, index, gfp);
>                         if (!err)
>                                 break;
>                         folio_put(folio);
>                         folio = NULL;
>                 } while (order-- > 0);
> 
> 
>>  split
>>         is incremented every time a huge page is successfully split into
>>         smaller orders. This can happen for a variety of reasons but a
>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>> index b8c63c3e967f..4f9109fcdded 100644
>> --- a/include/linux/huge_mm.h
>> +++ b/include/linux/huge_mm.h
>> @@ -123,6 +123,9 @@ enum mthp_stat_item {
>>         MTHP_STAT_SHMEM_ALLOC,
>>         MTHP_STAT_SHMEM_FALLBACK,
>>         MTHP_STAT_SHMEM_FALLBACK_CHARGE,
>> +       MTHP_STAT_FILE_ALLOC,
>> +       MTHP_STAT_FILE_FALLBACK,
>> +       MTHP_STAT_FILE_FALLBACK_CHARGE,
>>         MTHP_STAT_SPLIT,
>>         MTHP_STAT_SPLIT_FAILED,
>>         MTHP_STAT_SPLIT_DEFERRED,
>> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
>> index 6e2f72d03176..95a147b5d117 100644
>> --- a/include/linux/pagemap.h
>> +++ b/include/linux/pagemap.h
>> @@ -562,14 +562,26 @@ static inline void *detach_page_private(struct page *page)
>>  }
>>
>>  #ifdef CONFIG_NUMA
>> -struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order);
>> +struct folio *__filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order);
>>  #else
>> -static inline struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order)
>> +static inline struct folio *__filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order)
>>  {
>>         return folio_alloc_noprof(gfp, order);
>>  }
>>  #endif
>>
>> +static inline struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order)
>> +{
>> +       struct folio *folio;
>> +
>> +       folio = __filemap_alloc_folio_noprof(gfp, order);
>> +
>> +       if (!folio)
>> +               count_mthp_stat(order, MTHP_STAT_FILE_FALLBACK);
>> +
>> +       return folio;
>> +}
> 
> Do we need to add and export __filemap_alloc_folio_noprof()? 

It is exported. See the below change in filemap.c. Previously
filemap_alloc_folio_noprof() was exported, but that is now an inline and
__filemap_alloc_folio_noprof() is exported in its place.

> In any case,
> we won't call count_mthp_stat(order, MTHP_STAT_FILE_FALLBACK) and
> will only allocate the folio instead?

Sorry I don't understand what you mean by this?

> 
>> +
>>  #define filemap_alloc_folio(...)                               \
>>         alloc_hooks(filemap_alloc_folio_noprof(__VA_ARGS__))
>>
>> diff --git a/mm/filemap.c b/mm/filemap.c
>> index 53d5d0410b51..131d514fca29 100644
>> --- a/mm/filemap.c
>> +++ b/mm/filemap.c
>> @@ -963,6 +963,8 @@ int filemap_add_folio(struct address_space *mapping, struct folio *folio,
>>         int ret;
>>
>>         ret = mem_cgroup_charge(folio, NULL, gfp);
>> +       count_mthp_stat(folio_order(folio),
>> +               ret ? MTHP_STAT_FILE_FALLBACK_CHARGE : MTHP_STAT_FILE_ALLOC);
>>         if (ret)
>>                 return ret;
> 
> Would the following be better?
> 
>         ret = mem_cgroup_charge(folio, NULL, gfp);
>          if (ret) {
>                  count_mthp_stat(folio_order(folio),
> MTHP_STAT_FILE_FALLBACK_CHARGE);
>                  return ret;
>          }
>        count_mthp_stat(folio_order(folio), MTHP_STAT_FILE_ALLOC);
> 
> Anyway, it's up to you. The code just feels a bit off to me :-)

Yes, agree your version is better. I also noticed that anon and shmem increment
FALLBACK whenever FALLBACK_CHARGE is incremented so I should apply those same
semantics here.

Thanks,
Ryan


> 
>>
>> @@ -990,7 +992,7 @@ int filemap_add_folio(struct address_space *mapping, struct folio *folio,
>>  EXPORT_SYMBOL_GPL(filemap_add_folio);
>>
>>  #ifdef CONFIG_NUMA
>> -struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order)
>> +struct folio *__filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order)
>>  {
>>         int n;
>>         struct folio *folio;
>> @@ -1007,7 +1009,7 @@ struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order)
>>         }
>>         return folio_alloc_noprof(gfp, order);
>>  }
>> -EXPORT_SYMBOL(filemap_alloc_folio_noprof);
>> +EXPORT_SYMBOL(__filemap_alloc_folio_noprof);
>>  #endif
>>
>>  /*
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 578ac212c172..26d558e3e80f 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -608,7 +608,14 @@ static struct attribute_group anon_stats_attr_grp = {
>>         .attrs = anon_stats_attrs,
>>  };
>>
>> +DEFINE_MTHP_STAT_ATTR(file_alloc, MTHP_STAT_FILE_ALLOC);
>> +DEFINE_MTHP_STAT_ATTR(file_fallback, MTHP_STAT_FILE_FALLBACK);
>> +DEFINE_MTHP_STAT_ATTR(file_fallback_charge, MTHP_STAT_FILE_FALLBACK_CHARGE);
>> +
>>  static struct attribute *file_stats_attrs[] = {
>> +       &file_alloc_attr.attr,
>> +       &file_fallback_attr.attr,
>> +       &file_fallback_charge_attr.attr,
>>  #ifdef CONFIG_SHMEM
>>         &shmem_alloc_attr.attr,
>>         &shmem_fallback_attr.attr,
>> --
>> 2.43.0
>>
> 
> Thanks
> Barry


