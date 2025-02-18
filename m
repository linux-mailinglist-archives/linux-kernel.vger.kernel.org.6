Return-Path: <linux-kernel+bounces-518965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A104EA3969B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 092751790C5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D55322DF8E;
	Tue, 18 Feb 2025 09:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="B+VNOPaa"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CC222C35B
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 09:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739869603; cv=none; b=DEmuFs51yUxXXkhGO23hepImfTr7J+vK90BUSJJIasFhmiiBI3suUmLV9g90lOKvs/BWviJJay2UdHn4h+BiqB3khFFyxIW1KxDfFGH86+fxKbXI7vkQAf314ysGcAlfAXSNcMWEUtbDqF6zEm6PYz7V9ME7+Ox9oJGU3AJqnPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739869603; c=relaxed/simple;
	bh=iQDM7PKRru/CfAErGjv04c2iAj92tp0iIhcNKuR45xM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l12CknbBOfUk6eOHq/E1bLEuR61mwBUnPZNI2fUrryljJRU5GQOP4VoY+S6htzvjaHF8J5PFaweQn93O/8o/17+hTlxG1jPcc13sCMnuUuK9fKPMEE7nbw18gVHgOkVKT9W0rDN0bdNOzELV5cqjXcmJMnQOrVzGmpBvzWTCxKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=B+VNOPaa; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=lDvlHwS9RGejQMkA7x7QDWrKJ8ThUtuM7Gv/wwEBi6E=;
	b=B+VNOPaaXb/7GmPSbCUgQhp+K6aEyLke76aKXMEigt+8GZT+0sDSZ+gpx3yRU0
	QGFIZF38L/LzzCM2RWUJNYkMuM/n4GDb2Pkknaf+RCCm2jyaDMGMwaiJOfHzjRay
	m4YzPA5fADyRMVuIYSa8aiNF1TdW84nuJTKE27tPMkZxo=
Received: from [172.19.20.199] (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3FxN_TbRn7pLpBA--.55503S2;
	Tue, 18 Feb 2025 17:06:08 +0800 (CST)
Message-ID: <b2f6f122-fad5-4ed2-8c24-2cf4226a60d1@126.com>
Date: Tue, 18 Feb 2025 17:06:06 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] mm/hugetlb: wait for hugepage folios to be freed
To: David Hildenbrand <david@redhat.com>, Muchun Song <muchun.song@linux.dev>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, 21cnbao@gmail.com,
 baolin.wang@linux.alibaba.com, osalvador@suse.de, liuzixing@hygon.cn
References: <1739604026-2258-1-git-send-email-yangge1116@126.com>
 <574F9D6A-F370-4A8C-9044-BC0A6189F055@linux.dev>
 <4195424c-3147-402f-bb73-4f7b96f6a9bf@redhat.com>
From: Ge Yang <yangge1116@126.com>
In-Reply-To: <4195424c-3147-402f-bb73-4f7b96f6a9bf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3FxN_TbRn7pLpBA--.55503S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAryrur4xtFWrAw1rKr48Zwb_yoWrArW7pF
	WUGF45GFWkJr9akr12vwn0yr1IyrZYqrWxurWIqr43A3ZxtwnrKFy7Aw1Duay8Zr1xCF4I
	vrWjvFZxuF1UA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jUUUUUUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbifgD3G2e0PcjfYQABsL



在 2025/2/18 16:52, David Hildenbrand 写道:
> On 18.02.25 07:52, Muchun Song wrote:
>>
>>
>>> On Feb 15, 2025, at 15:20, yangge1116@126.com wrote:
>>>
>>> ﻿From: Ge Yang <yangge1116@126.com>
>>>
>>> Since the introduction of commit b65d4adbc0f0 ("mm: hugetlb: defer 
>>> freeing
>>> of HugeTLB pages"), which supports deferring the freeing of HugeTLB 
>>> pages,
>>> the allocation of contiguous memory through cma_alloc() may fail
>>> probabilistically.
>>>
>>> In the CMA allocation process, if it is found that the CMA area is 
>>> occupied
>>> by in-use hugepage folios, these in-use hugepage folios need to be 
>>> migrated
>>> to another location. When there are no available hugepage folios in the
>>> free HugeTLB pool during the migration of in-use HugeTLB pages, new 
>>> folios
>>> are allocated from the buddy system. A temporary state is set on the 
>>> newly
>>> allocated folio. Upon completion of the hugepage folio migration, the
>>> temporary state is transferred from the new folios to the old folios.
>>> Normally, when the old folios with the temporary state are freed, it is
>>> directly released back to the buddy system. However, due to the deferred
>>> freeing of HugeTLB pages, the PageBuddy() check fails, ultimately 
>>> leading
>>> to the failure of cma_alloc().
>>>
>>> Here is a simplified call trace illustrating the process:
>>> cma_alloc()
>>>    ->__alloc_contig_migrate_range() // Migrate in-use hugepage
>>>        ->unmap_and_move_huge_page()
>>>            ->folio_putback_hugetlb() // Free old folios
>>>    ->test_pages_isolated()
>>>        ->__test_page_isolated_in_pageblock()
>>>             ->PageBuddy(page) // Check if the page is in buddy
>>>
>>> To resolve this issue, we have implemented a function named
>>> wait_for_hugepage_folios_freed(). This function ensures that the 
>>> hugepage
>>> folios are properly released back to the buddy system after their 
>>> migration
>>> is completed. By invoking wait_for_hugepage_folios_freed() before 
>>> calling
>>> PageBuddy(), we ensure that PageBuddy() will succeed.
>>>
>>> Fixes: b65d4adbc0f0 ("mm: hugetlb: defer freeing of HugeTLB pages")
>>> Signed-off-by: Ge Yang <yangge1116@126.com>
>>> ---
>>>
>>> V2:
>>> - flush all folios at once suggested by David
>>>
>>> include/linux/hugetlb.h |  5 +++++
>>> mm/hugetlb.c            |  8 ++++++++
>>> mm/page_isolation.c     | 10 ++++++++++
>>> 3 files changed, 23 insertions(+)
>>>
>>> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
>>> index 6c6546b..04708b0 100644
>>> --- a/include/linux/hugetlb.h
>>> +++ b/include/linux/hugetlb.h
>>> @@ -697,6 +697,7 @@ bool hugetlb_bootmem_page_zones_valid(int nid, 
>>> struct huge_bootmem_page *m);
>>>
>>> int isolate_or_dissolve_huge_page(struct page *page, struct list_head 
>>> *list);
>>> int replace_free_hugepage_folios(unsigned long start_pfn, unsigned 
>>> long end_pfn);
>>> +void wait_for_hugepage_folios_freed(void);
>>> struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
>>>                unsigned long addr, bool cow_from_owner);
>>> struct folio *alloc_hugetlb_folio_nodemask(struct hstate *h, int 
>>> preferred_nid,
>>> @@ -1092,6 +1093,10 @@ static inline int 
>>> replace_free_hugepage_folios(unsigned long start_pfn,
>>>    return 0;
>>> }
>>>
>>> +static inline void wait_for_hugepage_folios_freed(void)
>>> +{
>>> +}
>>> +
>>> static inline struct folio *alloc_hugetlb_folio(struct vm_area_struct 
>>> *vma,
>>>                       unsigned long addr,
>>>                       bool cow_from_owner)
>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>> index 30bc34d..36dd3e4 100644
>>> --- a/mm/hugetlb.c
>>> +++ b/mm/hugetlb.c
>>> @@ -2955,6 +2955,14 @@ int replace_free_hugepage_folios(unsigned long 
>>> start_pfn, unsigned long end_pfn)
>>>    return ret;
>>> }
>>>
>>> +void wait_for_hugepage_folios_freed(void)
>>
>> We usually use the "hugetlb" term now instead of "huge_page" to 
>> differentiate with THP. So I suggest naming it as 
>> wait_for_hugetlb_folios_freed().
> 
> Maybe "wait_for_freed_hugetlb_folios" or "hugetlb_wait_for_freed_folios".
> 
> In general, LGTM
> 
Ok, thanks.


