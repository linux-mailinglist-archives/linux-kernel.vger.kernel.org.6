Return-Path: <linux-kernel+bounces-179370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE7C8C5F5B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 05:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 340CD282F2E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 03:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A2F38DCD;
	Wed, 15 May 2024 03:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Sm7Jg0zX"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8338E38385
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 03:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715742857; cv=none; b=ps6SnXvaX5VB+LzGAhTn9CA1v1oOO7FdKcyG6htnqmUmqO/5rTILFKHUG80z1c/2W5eOEgA9lzNt6YHADeNX1SuaMYnKa7XoipG8aNhhuX9iZG7z6tFSmtnfScXic2Y7oZi8w3TVThI8wmw3kwmenkeyk1rAIWJByWHpQlI7neI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715742857; c=relaxed/simple;
	bh=TUvjzLLBV5p6w6yO+WR7yOiWHvvv+8d3ODga/cU1Gpc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DtjxPD73rRbDvxK6tLznZLc0LeGs2Emsg2nwNsDgtrzEWgzUOzt6otd4sG/Olrtl4wpQzdZ9ze958208cYblFM0AfmZ1ygOAbibplvP4JrCxd+P6I6AvhIytHzAO0QzXa7YeVd18qGfmjwp4dbRa5RgLix/MnzuWpn/NRbbICGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Sm7Jg0zX; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715742853; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=UJuzwdjUXcXXpYmOq4Y06/gX6rCmcwYb4f6sZ0kESE0=;
	b=Sm7Jg0zX3Oy34tc8KZ3XQAHzCSvNgYqleesSL65IckWfyUQel41H3mtxsANPlM5xWUJB90RlNC1jUYb881El1QRXJAnMhmE4wRAQFqwNlLdy3wPvAkuUHW183Gz00FU+xqViO2nWRI56UpSz2amRk51xQ4AE9KowYx4sYd33+os=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R781e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W6WW.n8_1715742850;
Received: from 30.97.56.58(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W6WW.n8_1715742850)
          by smtp.aliyun-inc.com;
          Wed, 15 May 2024 11:14:11 +0800
Message-ID: <eca43fd2-e704-4696-932a-2d3b5f3d5cdf@linux.alibaba.com>
Date: Wed, 15 May 2024 11:14:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] mm: shmem: add mTHP counters for anonymous shmem
To: Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, hughd@google.com, willy@infradead.org,
 david@redhat.com, wangkefeng.wang@huawei.com, ying.huang@intel.com,
 21cnbao@gmail.com, ryan.roberts@arm.com, shy828301@gmail.com,
 ziy@nvidia.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1715571279.git.baolin.wang@linux.alibaba.com>
 <b9babe1857917ff217ed0988d95ba3468845479c.1715571279.git.baolin.wang@linux.alibaba.com>
 <CAK1f24kfR-LOk_vvhBWddVnDdiDZYh8aZeknknWkhi7_5fhQ=A@mail.gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <CAK1f24kfR-LOk_vvhBWddVnDdiDZYh8aZeknknWkhi7_5fhQ=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/5/14 22:49, Lance Yang wrote:
> Hi Baolin,
> 
> On Mon, May 13, 2024 at 1:08 PM Baolin Wang
> <baolin.wang@linux.alibaba.com> wrote:
>>
>> Add mTHP counters for anonymous shmem.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>   include/linux/huge_mm.h |  3 +++
>>   mm/huge_memory.c        |  6 ++++++
>>   mm/shmem.c              | 18 +++++++++++++++---
>>   3 files changed, 24 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>> index b5339210268d..e162498fef82 100644
>> --- a/include/linux/huge_mm.h
>> +++ b/include/linux/huge_mm.h
>> @@ -281,6 +281,9 @@ enum mthp_stat_item {
>>          MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
>>          MTHP_STAT_ANON_SWPOUT,
>>          MTHP_STAT_ANON_SWPOUT_FALLBACK,
>> +       MTHP_STAT_FILE_ALLOC,
>> +       MTHP_STAT_FILE_FALLBACK,
>> +       MTHP_STAT_FILE_FALLBACK_CHARGE,
>>          __MTHP_STAT_COUNT
>>   };
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index d3080a8843f2..fcda6ae604f6 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -555,6 +555,9 @@ DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTHP_STAT_ANON_FAULT_FALLBACK);
>>   DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
>>   DEFINE_MTHP_STAT_ATTR(anon_swpout, MTHP_STAT_ANON_SWPOUT);
>>   DEFINE_MTHP_STAT_ATTR(anon_swpout_fallback, MTHP_STAT_ANON_SWPOUT_FALLBACK);
>> +DEFINE_MTHP_STAT_ATTR(file_alloc, MTHP_STAT_FILE_ALLOC);
>> +DEFINE_MTHP_STAT_ATTR(file_fallback, MTHP_STAT_FILE_FALLBACK);
>> +DEFINE_MTHP_STAT_ATTR(file_fallback_charge, MTHP_STAT_FILE_FALLBACK_CHARGE);
>>
>>   static struct attribute *stats_attrs[] = {
>>          &anon_fault_alloc_attr.attr,
>> @@ -562,6 +565,9 @@ static struct attribute *stats_attrs[] = {
>>          &anon_fault_fallback_charge_attr.attr,
>>          &anon_swpout_attr.attr,
>>          &anon_swpout_fallback_attr.attr,
>> +       &file_alloc_attr.attr,
>> +       &file_fallback_attr.attr,
>> +       &file_fallback_charge_attr.attr,
>>          NULL,
>>   };
>>
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index 8b020ff09c72..fd2cb2e73a21 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -1786,6 +1786,9 @@ static struct folio *shmem_alloc_and_add_folio(struct vm_fault *vmf,
>>
>>                          if (pages == HPAGE_PMD_NR)
>>                                  count_vm_event(THP_FILE_FALLBACK);
>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> +                       count_mthp_stat(order, MTHP_STAT_FILE_FALLBACK);
>> +#endif
> 
> Seems like we don't need these conditional compilation directives here.
> 
> The THP_FILE_FALLBACK above will result in a compilation error if
> CONFIG_TRANSPARENT_HUGEPAGE is not defined. So we don't
> worry about that :)
> 
> See THP_FILE_FALLBACK in include/linux/vm_event_item.h.
> 
>>                          order = next_order(&suitable_orders, order);
>>                  }
>>          } else {
>> @@ -1805,9 +1808,15 @@ static struct folio *shmem_alloc_and_add_folio(struct vm_fault *vmf,
>>                  if (xa_find(&mapping->i_pages, &index,
>>                                  index + pages - 1, XA_PRESENT)) {
>>                          error = -EEXIST;
>> -               } else if (pages == HPAGE_PMD_NR) {
>> -                       count_vm_event(THP_FILE_FALLBACK);
>> -                       count_vm_event(THP_FILE_FALLBACK_CHARGE);
>> +               } else if (pages > 1) {
>> +                       if (pages == HPAGE_PMD_NR) {
>> +                               count_vm_event(THP_FILE_FALLBACK);
>> +                               count_vm_event(THP_FILE_FALLBACK_CHARGE);
>> +                       }
>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> +                       count_mthp_stat(folio_order(folio), MTHP_STAT_FILE_FALLBACK);
>> +                       count_mthp_stat(folio_order(folio), MTHP_STAT_FILE_FALLBACK_CHARGE);
>> +#endif
> 
> As above.
> 
>>                  }
>>                  goto unlock;
>>          }
>> @@ -2178,6 +2187,9 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
>>                  if (!IS_ERR(folio)) {
>>                          if (folio_test_pmd_mappable(folio))
>>                                  count_vm_event(THP_FILE_ALLOC);
>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> +                       count_mthp_stat(folio_order(folio), MTHP_STAT_FILE_ALLOC);
>> +#endif
> 
> As above.
> 
> Perhaps we need to define MTHP_STAT_FILE_ALLOC and friends
> using a same way as THP_FILE_ALLOC, set as '{ BUILD_BUG(); 0; }'
> If CONFIG_TRANSPARENT_HUGEPAGE is not defined.
> 
> Likely:
> 
> #ifndef CONFIG_TRANSPARENT_HUGEPAGE
> #define MTHP_STAT_FILE_ALLOC ({ BUILD_BUG(); 0; })
> ...
> #endif

This is not enough, and we should also define a dummy function for 
count_mthp_stat() when CONFIG_TRANSPARENT_HUGEPAGE is not enabled. I was 
also hesitant about doing this before, but adding macro controls seems 
relatively simple:)

Thanks for reviewing.

