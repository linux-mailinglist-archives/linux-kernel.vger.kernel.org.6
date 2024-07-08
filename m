Return-Path: <linux-kernel+bounces-244332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB71592A2CA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 14:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 382CF1F21011
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 12:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09798003A;
	Mon,  8 Jul 2024 12:30:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40ABA3C08A
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 12:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720441801; cv=none; b=Ze3eJHtdL6QTBIokDmGbvGoEMHrwT53CD93n6cobryf0beHBmfQKjzlSO5WlGoa/0e3xY7BfLxAiHHhbBX7+YR89B2ktNlLcvPunErI+1jtL9x4r7bvLi/SG5pD+UgJa1+mHcN67g7ht3HH9z+F8h5G+oodth6L9AhDqIKXLn9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720441801; c=relaxed/simple;
	bh=id54FDjgADDvP3ctGVx9HMmF5uGKGkkNb/mZ+FkysCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zn9GEJJhwN23gZGDwJizi1nQd2H1vm0w50DkpVWjNaxQGsN6Dj6MWc+RZXikrzDLD+BI4cghq1ds+MDhWaqTr7ig9FWcUSVXY7Ob5IkIl8S31SGzaiEstUhOmrIkK3LpATAZEvrRYGmhZp3UA64tcNN8lvRBXztfhmYK5u/CV3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91FC51042;
	Mon,  8 Jul 2024 05:30:22 -0700 (PDT)
Received: from [10.1.36.168] (XHFQ2J9959.cambridge.arm.com [10.1.36.168])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AA2E13F766;
	Mon,  8 Jul 2024 05:29:55 -0700 (PDT)
Message-ID: <744749c3-4506-40d9-ac48-0dbc59689f92@arm.com>
Date: Mon, 8 Jul 2024 13:29:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm: shmem: Rename mTHP shmem counters
Content-Language: en-GB
To: Barry Song <baohua@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins
 <hughd@google.com>, Jonathan Corbet <corbet@lwn.net>,
 David Hildenbrand <david@redhat.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Lance Yang
 <ioworker0@gmail.com>, Matthew Wilcox <willy@infradead.org>,
 Zi Yan <ziy@nvidia.com>, Daniel Gomez <da.gomez@samsung.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240708112445.2690631-1-ryan.roberts@arm.com>
 <CAGsJ_4zH72FyLq5gJm215oiWrtd6uf40L_F1UO6cFZ4sy7qt0A@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAGsJ_4zH72FyLq5gJm215oiWrtd6uf40L_F1UO6cFZ4sy7qt0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 08/07/2024 12:36, Barry Song wrote:
> On Mon, Jul 8, 2024 at 11:24 PM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> The legacy PMD-sized THP counters at /proc/vmstat include
>> thp_file_alloc, thp_file_fallback and thp_file_fallback_charge, which
>> rather confusingly refer to shmem THP and do not include any other types
>> of file pages. This is inconsistent since in most other places in the
>> kernel, THP counters are explicitly separated for anon, shmem and file
>> flavours. However, we are stuck with it since it constitutes a user ABI.
>>
>> Recently, commit 66f44583f9b6 ("mm: shmem: add mTHP counters for
>> anonymous shmem") added equivalent mTHP stats for shmem, keeping the
>> same "file_" prefix in the names. But in future, we may want to add
>> extra stats to cover actual file pages, at which point, it would all
>> become very confusing.
>>
>> So let's take the opportunity to rename these new counters "shmem_"
>> before the change makes it upstream and the ABI becomes immutable.
> 
> Personally, I think this approach is much clearer. However, I recall
> we discussed this
> before [1], and it seems that inconsistency is a concern?

Embarrassingly, I don't recall that converstation at all :-| but at least what I
said then is consistent with what I've done in this patch.

I think David's conclusion from that thread was to call them FILE_, and add both
shmem and pagecache counts to those counters, meaning we can keep the same name
as legacy THP counters. But those legacy THP counters only count shmem, and I
don't think we would get away with adding pagecache counts to those at this
point? (argument: they have been around for long time and there is a risk that
user space relies on them and if they were to dramatically increase due to
pagecache addition now that could break things). In that case, there is still
inconsistency, but its worse; the names are consistent but the semantics are
inconsistent.

So my vote is to change to SHMEM_ as per this patch :)

> 
> [1] https://lore.kernel.org/linux-mm/05d0096e4ec3e572d1d52d33a31a661321ac1551.1713755580.git.baolin.wang@linux.alibaba.com/
> 
> 
>>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>
>> Hi All,
>>
>> Applies on top of today's mm-unstable (2073cda629a4) and tested with mm
>> selftests; no regressions observed.
>>
>> The backstory here is that I'd like to introduce some counters for regular file
>> folio allocations to observe how often large folio allocation succeeds, but
>> these shmem counters are named "file" which is going to make things confusing.
>> So hoping to solve that before commit 66f44583f9b6 ("mm: shmem: add mTHP
>> counters for anonymous shmem") goes upstream (it is currently in mm-stable).
>>
>> Admittedly, this change means the mTHP stat names are not the same as the legacy
>> PMD-size THP names, but I think that's a smaller issue than having "file_" mTHP
>> stats that only count shmem, then having to introduce "file2_" or "pgcache_"
>> stats for the regular file memory, which is even more inconsistent IMHO. I guess
>> the alternative is to count both shmem and file in these mTHP stats (that's how
>> they were documented anyway) but I think it's better to be able to consider them
>> separately like we do for all the other counters.
>>
>> Thanks,
>> Ryan
>>
>>  Documentation/admin-guide/mm/transhuge.rst | 12 ++++++------
>>  include/linux/huge_mm.h                    |  6 +++---
>>  mm/huge_memory.c                           | 12 ++++++------
>>  mm/shmem.c                                 |  8 ++++----
>>  4 files changed, 19 insertions(+), 19 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
>> index 747c811ee8f1..8b891689fc13 100644
>> --- a/Documentation/admin-guide/mm/transhuge.rst
>> +++ b/Documentation/admin-guide/mm/transhuge.rst
>> @@ -496,16 +496,16 @@ swpout_fallback
>>         Usually because failed to allocate some continuous swap space
>>         for the huge page.
>>
>> -file_alloc
>> -       is incremented every time a file huge page is successfully
>> +shmem_alloc
>> +       is incremented every time a shmem huge page is successfully
>>         allocated.
>>
>> -file_fallback
>> -       is incremented if a file huge page is attempted to be allocated
>> +shmem_fallback
>> +       is incremented if a shmem huge page is attempted to be allocated
>>         but fails and instead falls back to using small pages.
>>
>> -file_fallback_charge
>> -       is incremented if a file huge page cannot be charged and instead
>> +shmem_fallback_charge
>> +       is incremented if a shmem huge page cannot be charged and instead
>>         falls back to using small pages even though the allocation was
>>         successful.
>>
>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>> index acb6ac24a07e..cff002be83eb 100644
>> --- a/include/linux/huge_mm.h
>> +++ b/include/linux/huge_mm.h
>> @@ -269,9 +269,9 @@ enum mthp_stat_item {
>>         MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
>>         MTHP_STAT_SWPOUT,
>>         MTHP_STAT_SWPOUT_FALLBACK,
>> -       MTHP_STAT_FILE_ALLOC,
>> -       MTHP_STAT_FILE_FALLBACK,
>> -       MTHP_STAT_FILE_FALLBACK_CHARGE,
>> +       MTHP_STAT_SHMEM_ALLOC,
>> +       MTHP_STAT_SHMEM_FALLBACK,
>> +       MTHP_STAT_SHMEM_FALLBACK_CHARGE,
>>         MTHP_STAT_SPLIT,
>>         MTHP_STAT_SPLIT_FAILED,
>>         MTHP_STAT_SPLIT_DEFERRED,
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 9ec64aa2be94..f9696c94e211 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -568,9 +568,9 @@ DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTHP_STAT_ANON_FAULT_FALLBACK);
>>  DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
>>  DEFINE_MTHP_STAT_ATTR(swpout, MTHP_STAT_SWPOUT);
>>  DEFINE_MTHP_STAT_ATTR(swpout_fallback, MTHP_STAT_SWPOUT_FALLBACK);
>> -DEFINE_MTHP_STAT_ATTR(file_alloc, MTHP_STAT_FILE_ALLOC);
>> -DEFINE_MTHP_STAT_ATTR(file_fallback, MTHP_STAT_FILE_FALLBACK);
>> -DEFINE_MTHP_STAT_ATTR(file_fallback_charge, MTHP_STAT_FILE_FALLBACK_CHARGE);
>> +DEFINE_MTHP_STAT_ATTR(shmem_alloc, MTHP_STAT_SHMEM_ALLOC);
>> +DEFINE_MTHP_STAT_ATTR(shmem_fallback, MTHP_STAT_SHMEM_FALLBACK);
>> +DEFINE_MTHP_STAT_ATTR(shmem_fallback_charge, MTHP_STAT_SHMEM_FALLBACK_CHARGE);
>>  DEFINE_MTHP_STAT_ATTR(split, MTHP_STAT_SPLIT);
>>  DEFINE_MTHP_STAT_ATTR(split_failed, MTHP_STAT_SPLIT_FAILED);
>>  DEFINE_MTHP_STAT_ATTR(split_deferred, MTHP_STAT_SPLIT_DEFERRED);
>> @@ -581,9 +581,9 @@ static struct attribute *stats_attrs[] = {
>>         &anon_fault_fallback_charge_attr.attr,
>>         &swpout_attr.attr,
>>         &swpout_fallback_attr.attr,
>> -       &file_alloc_attr.attr,
>> -       &file_fallback_attr.attr,
>> -       &file_fallback_charge_attr.attr,
>> +       &shmem_alloc_attr.attr,
>> +       &shmem_fallback_attr.attr,
>> +       &shmem_fallback_charge_attr.attr,
>>         &split_attr.attr,
>>         &split_failed_attr.attr,
>>         &split_deferred_attr.attr,
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index 921d59c3d669..f24dfbd387ba 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -1777,7 +1777,7 @@ static struct folio *shmem_alloc_and_add_folio(struct vm_fault *vmf,
>>                         if (pages == HPAGE_PMD_NR)
>>                                 count_vm_event(THP_FILE_FALLBACK);
>>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> -                       count_mthp_stat(order, MTHP_STAT_FILE_FALLBACK);
>> +                       count_mthp_stat(order, MTHP_STAT_SHMEM_FALLBACK);
>>  #endif
>>                         order = next_order(&suitable_orders, order);
>>                 }
>> @@ -1804,8 +1804,8 @@ static struct folio *shmem_alloc_and_add_folio(struct vm_fault *vmf,
>>                                 count_vm_event(THP_FILE_FALLBACK_CHARGE);
>>                         }
>>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> -                       count_mthp_stat(folio_order(folio), MTHP_STAT_FILE_FALLBACK);
>> -                       count_mthp_stat(folio_order(folio), MTHP_STAT_FILE_FALLBACK_CHARGE);
>> +                       count_mthp_stat(folio_order(folio), MTHP_STAT_SHMEM_FALLBACK);
>> +                       count_mthp_stat(folio_order(folio), MTHP_STAT_SHMEM_FALLBACK_CHARGE);
>>  #endif
>>                 }
>>                 goto unlock;
>> @@ -2181,7 +2181,7 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
>>                         if (folio_test_pmd_mappable(folio))
>>                                 count_vm_event(THP_FILE_ALLOC);
>>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> -                       count_mthp_stat(folio_order(folio), MTHP_STAT_FILE_ALLOC);
>> +                       count_mthp_stat(folio_order(folio), MTHP_STAT_SHMEM_ALLOC);
>>  #endif
>>                         goto alloced;
>>                 }
>> --
>> 2.43.0
>>
> 
> Thanks
> Barry


