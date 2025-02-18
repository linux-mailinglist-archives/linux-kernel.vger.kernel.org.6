Return-Path: <linux-kernel+bounces-518722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D8CA393C3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75856170BA8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 07:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B421B87CE;
	Tue, 18 Feb 2025 07:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="RLTlf6oW"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3467F7E1
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 07:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739863571; cv=none; b=Dp5L9m2IcWy5zR7qEUMCPh10Wl2weUt4RgMrql1G8aQRCzQmgofFjBLa2jaEWHBygTlECEsWW5+/Pkq1O+XHoIxCHnpUwDGHbDZYIV/JUnp21IHaOafOeCwEK0Pm8zKAXAYv7qdlM0IbFA62q+ja3NP7gt8WFTUrL+lD0Uxjiso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739863571; c=relaxed/simple;
	bh=KI0ERdClsDjBuXMHcQkIoc5RgQi86g0ro0j/JEFne3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MBSszd6tZiL8+zOD+2Rsz1EqGFSCLevfubvDf6JJRqzDzEDxm47e8En6IC3yFKFjpZ8X80EPqHe5LwplYeu3wzVdr6QeFe99yHmmDjaemWlO3J1BUwmVF+2aaPDYFUPDwk+KkEt4xVbvyQ4uMbq8NRB5CqPS8ClY8QrZDFTPptM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=RLTlf6oW; arc=none smtp.client-ip=117.135.210.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=zLzdik0C0YnWFe7OPEwXgLI3rtsrl+WgqVMk2VhKeMk=;
	b=RLTlf6oWJe2OZqfC4hQdnUUoTi9oFGNX82dKrYJuFXNK5+MdeR/aQ94RGO2Qvf
	k9/HjOTAJlBIMMNk8H4hHpe9sRCxNHhMJai/VeMiXYYLQVL3YfMCv6Dv9hTSBUC5
	G8J5Sukdq8Vx12ilHHY958ftd4yonJw96MX3dWWzMpIWs=
Received: from [172.19.20.199] (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCkvCgD3N_fzNbRnD98FBA--.29161S2;
	Tue, 18 Feb 2025 15:25:39 +0800 (CST)
Message-ID: <03bc60a1-bd71-4acf-804d-312202625be8@126.com>
Date: Tue, 18 Feb 2025 15:25:38 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] mm/hugetlb: wait for hugepage folios to be freed
To: Muchun Song <muchun.song@linux.dev>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, 21cnbao@gmail.com, david@redhat.com,
 baolin.wang@linux.alibaba.com, osalvador@suse.de, liuzixing@hygon.cn
References: <1739604026-2258-1-git-send-email-yangge1116@126.com>
 <BEEBE7BB-E242-40F0-B752-E878865B56EB@linux.dev>
From: Ge Yang <yangge1116@126.com>
In-Reply-To: <BEEBE7BB-E242-40F0-B752-E878865B56EB@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCkvCgD3N_fzNbRnD98FBA--.29161S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Ar1fJF1fGw43Jr1UuF1fCrg_yoW7CF4xpF
	yUKa1UGFWDJr9akrnrZwn0vr1I9rWvqFWUCrWSqw4fZ3ZxJ3srKFy2ywn0vayrArWkCFWI
	vrWjvrZruF1UZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jUyCJUUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiOhj3G2e0K8GzngAAsa



在 2025/2/18 15:05, Muchun Song 写道:
> 
> 
>> On Feb 15, 2025, at 15:20, yangge1116@126.com wrote:
>>
>> From: Ge Yang <yangge1116@126.com>
>>
>> Since the introduction of commit b65d4adbc0f0 ("mm: hugetlb: defer freeing
>> of HugeTLB pages"), which supports deferring the freeing of HugeTLB pages,
>> the allocation of contiguous memory through cma_alloc() may fail
>> probabilistically.
>>
>> In the CMA allocation process, if it is found that the CMA area is occupied
>> by in-use hugepage folios, these in-use hugepage folios need to be migrated
>> to another location. When there are no available hugepage folios in the
>> free HugeTLB pool during the migration of in-use HugeTLB pages, new folios
>> are allocated from the buddy system. A temporary state is set on the newly
>> allocated folio. Upon completion of the hugepage folio migration, the
>> temporary state is transferred from the new folios to the old folios.
>> Normally, when the old folios with the temporary state are freed, it is
>> directly released back to the buddy system. However, due to the deferred
>> freeing of HugeTLB pages, the PageBuddy() check fails, ultimately leading
>> to the failure of cma_alloc().
>>
>> Here is a simplified call trace illustrating the process:
>> cma_alloc()
>>     ->__alloc_contig_migrate_range() // Migrate in-use hugepage
>>         ->unmap_and_move_huge_page()
>>             ->folio_putback_hugetlb() // Free old folios
>>     ->test_pages_isolated()
>>         ->__test_page_isolated_in_pageblock()
>>              ->PageBuddy(page) // Check if the page is in buddy
>>
>> To resolve this issue, we have implemented a function named
>> wait_for_hugepage_folios_freed(). This function ensures that the hugepage
>> folios are properly released back to the buddy system after their migration
>> is completed. By invoking wait_for_hugepage_folios_freed() before calling
>> PageBuddy(), we ensure that PageBuddy() will succeed.
>>
>> Fixes: b65d4adbc0f0 ("mm: hugetlb: defer freeing of HugeTLB pages")
> 
> The actual blamed commit should be the
> 
> commit c77c0a8ac4c52 ("mm/hugetlb: defer freeing of huge pages if in non-task context")
> 
> which is the first to introducing the delayed work to free the hugetlb pages.
> It was removed by commit db71ef79b59bb2 and then was brought back by commit
> b65d4adbc0f0 immediately.
> 
Ok, thanks.
>> Signed-off-by: Ge Yang <yangge1116@126.com>
>> ---
>>
>> V2:
>> - flush all folios at once suggested by David
>>
>> include/linux/hugetlb.h |  5 +++++
>> mm/hugetlb.c            |  8 ++++++++
>> mm/page_isolation.c     | 10 ++++++++++
>> 3 files changed, 23 insertions(+)
>>
>> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
>> index 6c6546b..04708b0 100644
>> --- a/include/linux/hugetlb.h
>> +++ b/include/linux/hugetlb.h
>> @@ -697,6 +697,7 @@ bool hugetlb_bootmem_page_zones_valid(int nid, struct huge_bootmem_page *m);
>>
>> int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list);
>> int replace_free_hugepage_folios(unsigned long start_pfn, unsigned long end_pfn);
>> +void wait_for_hugepage_folios_freed(void);
>> struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
>> 				unsigned long addr, bool cow_from_owner);
>> struct folio *alloc_hugetlb_folio_nodemask(struct hstate *h, int preferred_nid,
>> @@ -1092,6 +1093,10 @@ static inline int replace_free_hugepage_folios(unsigned long start_pfn,
>> 	return 0;
>> }
>>
>> +static inline void wait_for_hugepage_folios_freed(void)
>> +{
>> +}
>> +
>> static inline struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
>>    			unsigned long addr,
>>    			bool cow_from_owner)
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index 30bc34d..36dd3e4 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -2955,6 +2955,14 @@ int replace_free_hugepage_folios(unsigned long start_pfn, unsigned long end_pfn)
>> return ret;
>> }
>>
>> +void wait_for_hugepage_folios_freed(void)
> 
> We usually use the "hugetlb" term now instead of "huge_page" to differentiate with THP.
> So I suggest naming it as wait_for_hugetlb_folios_freed().
> 
>> +{
>> + 	struct hstate *h;
>> +
>> + 	for_each_hstate(h)
>> + 		flush_free_hpage_work(h);
> 
> Because all hstate use the shared work to defer the freeing of hugetlb pages, we only
> need to flush once. Directly useing flush_work(&free_hpage_work) is enough.
> 
Ok, thanks.
>> +}
>> +
>> typedef enum {
>> 	/*
>> * For either 0/1: we checked the per-vma resv map, and one resv
>> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
>> index 8ed53ee0..f56cf02 100644
>> --- a/mm/page_isolation.c
>> +++ b/mm/page_isolation.c
>> @@ -615,6 +615,16 @@ int test_pages_isolated(unsigned long start_pfn, unsigned long end_pfn,
>> int ret;
>>
>> 	/*
>> +	 * Due to the deferred freeing of HugeTLB folios, the hugepage folios may
>> +	 * not immediately release to the buddy system. This can cause PageBuddy()
>> +	 * to fail in __test_page_isolated_in_pageblock(). To ensure that the
>> +	 * hugepage folios are properly released back to the buddy system, we
> 
> hugetlb folios.
> 
Ok, thanks.
> Muchun,
> Thanks.
> 
>> +	 * invoke the wait_for_hugepage_folios_freed() function to wait for the
>> +	 * release to complete.
>> +	 */
>> + 	wait_for_hugepage_folios_freed();
>> +
>> + 	/*
>> 	 * Note: pageblock_nr_pages != MAX_PAGE_ORDER. Then, chunks of free
>> 	 * pages are not aligned to pageblock_nr_pages.
>> 	 * Then we just check migratetype first.
>> -- 
>> 2.7.4
>>


