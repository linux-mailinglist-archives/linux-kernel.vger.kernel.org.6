Return-Path: <linux-kernel+bounces-235516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E70C91D608
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 04:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFA191F218BD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 02:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358D48F66;
	Mon,  1 Jul 2024 02:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="eoLjNu9w"
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF238BF7
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 02:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719800597; cv=none; b=Ic+zUISt2KQr9lm/WxY8OK/L/UOxB7DYs9RF2oGLMBsuLk5uouAhfef/XR8PvRDkOKJRT+dSQW2HQ08jBIodmpbhopXea3R7BGJRuiasY7hHiRCtxgz7ukSmnVYfx7HUmw/fx5PUxPwA6pr/jwluQU3NRpE/G5ZmYIWdfKKRxoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719800597; c=relaxed/simple;
	bh=GtzqQRTJ0vFjfUzy8X4yfB8ZWlLj2oZonapJpFFyPdg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CE7Vef3nssibhr2swtah0evIe4gliM9+gty2rMjNsCYOgQZ8EWHAqD0+ft966GEAwsjAGxdZo0ahk0eyNYC6YO8j8HqTXQrvaS5gPGXIeatT5eq4wpBEs+Mq+9rEMDtbZ7lCgX7RXnr/TQz4GdUZsUuIHWAacli5OrO9PwiA6Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=eoLjNu9w; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719800586; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=iQAZMmCCiCK3m0UCQRu2cMIIfVfjKLwPg0eCs+HIhbs=;
	b=eoLjNu9wY/eTelagASGuwCFrtL2n8j8M0uVkmeTtaq4NoBjJAjPng/gy2grEjWX31wGL7uVylFKVhD0BhwDU7Of/DQQwa43BpC/odcWdlzcYxBDvXA7iAppnVfwNpS2dDhsVlMhHyEWfD0KH4X7LBhiv4IpTGU8M0/89Y2aJ8aI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W9XN76C_1719800584;
Received: from 30.97.56.67(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W9XN76C_1719800584)
          by smtp.aliyun-inc.com;
          Mon, 01 Jul 2024 10:23:05 +0800
Message-ID: <c0706b47-cdbc-4cff-bea8-e39ababc9b89@linux.alibaba.com>
Date: Mon, 1 Jul 2024 10:23:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mm: add per-order mTHP split counters
To: Barry Song <21cnbao@gmail.com>, Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, dj456119@gmail.com, ryan.roberts@arm.com,
 david@redhat.com, shy828301@gmail.com, ziy@nvidia.com,
 libang.li@antgroup.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Mingzhe Yang <mingzhe.yang@ly.com>
References: <20240628130750.73097-1-ioworker0@gmail.com>
 <20240628130750.73097-2-ioworker0@gmail.com>
 <CAGsJ_4yF6ucmLpMpdfjEgZXB6CP7vQkidqfugsmo1vGiaUb97g@mail.gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <CAGsJ_4yF6ucmLpMpdfjEgZXB6CP7vQkidqfugsmo1vGiaUb97g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/7/1 08:02, Barry Song wrote:
> On Sat, Jun 29, 2024 at 1:09 AM Lance Yang <ioworker0@gmail.com> wrote:
>>
>> Currently, the split counters in THP statistics no longer include
>> PTE-mapped mTHP. Therefore, we propose introducing per-order mTHP split
>> counters to monitor the frequency of mTHP splits. This will help developers
>> better analyze and optimize system performance.
>>
>> /sys/kernel/mm/transparent_hugepage/hugepages-<size>/stats
>>          split
>>          split_failed
>>          split_deferred
>>
>> Signed-off-by: Mingzhe Yang <mingzhe.yang@ly.com>
>> Signed-off-by: Lance Yang <ioworker0@gmail.com>
> 
> Personally, I'm not convinced that using a temporary variable order
> makes the code
> more readable. Functions like folio_test_pmd_mappable() seem more readable to
> me. In any case, it's a minor issue.

Yes, I have the same opinion as Barry. With that:
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>


> Acked-by: Barry Song <baohua@kernel.org>
> 
>> ---
>>   include/linux/huge_mm.h |  3 +++
>>   mm/huge_memory.c        | 19 ++++++++++++++-----
>>   2 files changed, 17 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>> index 212cca384d7e..cee3c5da8f0e 100644
>> --- a/include/linux/huge_mm.h
>> +++ b/include/linux/huge_mm.h
>> @@ -284,6 +284,9 @@ enum mthp_stat_item {
>>          MTHP_STAT_FILE_ALLOC,
>>          MTHP_STAT_FILE_FALLBACK,
>>          MTHP_STAT_FILE_FALLBACK_CHARGE,
>> +       MTHP_STAT_SPLIT,
>> +       MTHP_STAT_SPLIT_FAILED,
>> +       MTHP_STAT_SPLIT_DEFERRED,
>>          __MTHP_STAT_COUNT
>>   };
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index c7ce28f6b7f3..a633206375af 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -559,6 +559,9 @@ DEFINE_MTHP_STAT_ATTR(swpout_fallback, MTHP_STAT_SWPOUT_FALLBACK);
>>   DEFINE_MTHP_STAT_ATTR(file_alloc, MTHP_STAT_FILE_ALLOC);
>>   DEFINE_MTHP_STAT_ATTR(file_fallback, MTHP_STAT_FILE_FALLBACK);
>>   DEFINE_MTHP_STAT_ATTR(file_fallback_charge, MTHP_STAT_FILE_FALLBACK_CHARGE);
>> +DEFINE_MTHP_STAT_ATTR(split, MTHP_STAT_SPLIT);
>> +DEFINE_MTHP_STAT_ATTR(split_failed, MTHP_STAT_SPLIT_FAILED);
>> +DEFINE_MTHP_STAT_ATTR(split_deferred, MTHP_STAT_SPLIT_DEFERRED);
>>
>>   static struct attribute *stats_attrs[] = {
>>          &anon_fault_alloc_attr.attr,
>> @@ -569,6 +572,9 @@ static struct attribute *stats_attrs[] = {
>>          &file_alloc_attr.attr,
>>          &file_fallback_attr.attr,
>>          &file_fallback_charge_attr.attr,
>> +       &split_attr.attr,
>> +       &split_failed_attr.attr,
>> +       &split_deferred_attr.attr,
>>          NULL,
>>   };
>>
>> @@ -3068,7 +3074,7 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>>          XA_STATE_ORDER(xas, &folio->mapping->i_pages, folio->index, new_order);
>>          struct anon_vma *anon_vma = NULL;
>>          struct address_space *mapping = NULL;
>> -       bool is_thp = folio_test_pmd_mappable(folio);
>> +       int order = folio_order(folio);
>>          int extra_pins, ret;
>>          pgoff_t end;
>>          bool is_hzp;
>> @@ -3076,7 +3082,7 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>>          VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
>>          VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
>>
>> -       if (new_order >= folio_order(folio))
>> +       if (new_order >= order)
>>                  return -EINVAL;
>>
>>          if (folio_test_anon(folio)) {
>> @@ -3253,8 +3259,9 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>>                  i_mmap_unlock_read(mapping);
>>   out:
>>          xas_destroy(&xas);
>> -       if (is_thp)
>> +       if (order >= HPAGE_PMD_ORDER)
>>                  count_vm_event(!ret ? THP_SPLIT_PAGE : THP_SPLIT_PAGE_FAILED);
>> +       count_mthp_stat(order, !ret ? MTHP_STAT_SPLIT : MTHP_STAT_SPLIT_FAILED);
>>          return ret;
>>   }
>>
>> @@ -3278,13 +3285,14 @@ void deferred_split_folio(struct folio *folio)
>>   #ifdef CONFIG_MEMCG
>>          struct mem_cgroup *memcg = folio_memcg(folio);
>>   #endif
>> +       int order = folio_order(folio);
>>          unsigned long flags;
>>
>>          /*
>>           * Order 1 folios have no space for a deferred list, but we also
>>           * won't waste much memory by not adding them to the deferred list.
>>           */
>> -       if (folio_order(folio) <= 1)
>> +       if (order <= 1)
>>                  return;
>>
>>          /*
>> @@ -3305,8 +3313,9 @@ void deferred_split_folio(struct folio *folio)
>>
>>          spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
>>          if (list_empty(&folio->_deferred_list)) {
>> -               if (folio_test_pmd_mappable(folio))
>> +               if (order >= HPAGE_PMD_ORDER)
>>                          count_vm_event(THP_DEFERRED_SPLIT_PAGE);
>> +               count_mthp_stat(order, MTHP_STAT_SPLIT_DEFERRED);
>>                  list_add_tail(&folio->_deferred_list, &ds_queue->split_queue);
>>                  ds_queue->split_queue_len++;
>>   #ifdef CONFIG_MEMCG
>> --
>> 2.45.2
>>

