Return-Path: <linux-kernel+bounces-565684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D53A66D64
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 09:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 857CD167A40
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 08:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8321E8356;
	Tue, 18 Mar 2025 08:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="mJ4/1SIg"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808661DFE23
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 08:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742285260; cv=none; b=VslJLm7ABba6lyq1x72GeivorLiv3XcorPOL6DFRGzs+jjxIxNVLTX+Ug35ojWmAFW3YSO/YggrvCFWLUJ5qDRbJpVLPRJDCHlHdlvRvQi/nVfHiNlTBnSOSpefDiSSHzYEgS/5KP3MFMcUxq7TxgDF1JzPb4amrG6okHeUgXy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742285260; c=relaxed/simple;
	bh=gj8ztjx4DDXc8wmr8TSvDP3057YD+rf2ndJtlNgm8o0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aouCmupPoHPCmQIlc2Ds/WxRnS+qWixtjCFn+5yhCT5uilx7RPKYvh4cFFN3WRwAD4l+7wgLLnSZBzTRdYwqMHbS4prqEF8S1/uYKcTRfDD29EmVAp3GLuLWgaFkeDIbaii2oO8VplFNJAv4D7yEOc9c/0AyL4NIDWNjoU1PK9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=mJ4/1SIg; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=xAv74FX3DoajPloCyOTTZZeRXTUHncsx5Pnyk67rO28=;
	b=mJ4/1SIg/aUMGV0gn9/9PCKruF2BIM3Yg1wS5VVSX04zaBkBte77Evc1xa0RIF
	kvz6MEj1iofetvtwEkoIELZIIrHP2OaneYo4lOjN4f1q+FoNTMt5QpmtNcKP3dvi
	CsRCBeWIXuVkkyMPkP7iTGZLxd3z9o10GJL28BxyHBtxU=
Received: from [172.19.20.199] (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PikvCgD3jrsGH9lnEPZYCA--.20701S2;
	Tue, 18 Mar 2025 15:21:43 +0800 (CST)
Message-ID: <09057869-eb32-45dd-a7a1-9b7e1850eb11@126.com>
Date: Tue, 18 Mar 2025 15:21:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] mm/cma: using per-CMA locks to improve concurrent
 allocation performance
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 21cnbao@gmail.com,
 david@redhat.com, baolin.wang@linux.alibaba.com, aisheng.dong@nxp.com,
 liuzixing@hygon.cn
References: <1739152566-744-1-git-send-email-yangge1116@126.com>
 <20250317204325.99b45373023ad2f901c1152e@linux-foundation.org>
From: Ge Yang <yangge1116@126.com>
In-Reply-To: <20250317204325.99b45373023ad2f901c1152e@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PikvCgD3jrsGH9lnEPZYCA--.20701S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxKFyxAF1fGrWxtFWxAF4Utwb_yoWxJFy5pF
	W8GFyDCr98Xry7Aw42k34DuF9a9ws7WFW7KFyjva4xZFnxCr90grs5tFy5u3y8urZrWFy0
	vryjqasrZw1UZ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jYGQhUUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiIh0UG2fZFYW67QAAsJ



在 2025/3/18 11:43, Andrew Morton 写道:
> On Mon, 10 Feb 2025 09:56:06 +0800 yangge1116@126.com wrote:
> 
>> From: yangge <yangge1116@126.com>
>>
>> For different CMAs, concurrent allocation of CMA memory ideally should not
>> require synchronization using locks. Currently, a global cma_mutex lock is
>> employed to synchronize all CMA allocations, which can impact the
>> performance of concurrent allocations across different CMAs.
>>
>> To test the performance impact, follow these steps:
>> 1. Boot the kernel with the command line argument hugetlb_cma=30G to
>>     allocate a 30GB CMA area specifically for huge page allocations. (note:
>>     on my machine, which has 3 nodes, each node is initialized with 10G of
>>     CMA)
>> 2. Use the dd command with parameters if=/dev/zero of=/dev/shm/file bs=1G
>>     count=30 to fully utilize the CMA area by writing zeroes to a file in
>>     /dev/shm.
>> 3. Open three terminals and execute the following commands simultaneously:
>>     (Note: Each of these commands attempts to allocate 10GB [2621440 * 4KB
>>     pages] of CMA memory.)
>>     On Terminal 1: time echo 2621440 > /sys/kernel/debug/cma/hugetlb1/alloc
>>     On Terminal 2: time echo 2621440 > /sys/kernel/debug/cma/hugetlb2/alloc
>>     On Terminal 3: time echo 2621440 > /sys/kernel/debug/cma/hugetlb3/alloc
>>
>> We attempt to allocate pages through the CMA debug interface and use the
>> time command to measure the duration of each allocation.
>> Performance comparison:
>>               Without this patch      With this patch
>> Terminal1        ~7s                     ~7s
>> Terminal2       ~14s                     ~8s
>> Terminal3       ~21s                     ~7s
>>
>> To slove problem above, we could use per-CMA locks to improve concurrent
>> allocation performance. This would allow each CMA to be managed
>> independently, reducing the need for a global lock and thus improving
>> scalability and performance.
> 
> This patch was in and out of mm-unstable for a while, as Frank's series
> "hugetlb/CMA improvements for large systems" was being added and
> dropped.
> 
> Consequently it hasn't received any testing for a while.
> 
> Below is the version which I've now re-added to mm-unstable.  Can
> you please check this and retest it?
Based on the latest mm-unstable code, after applying the patch and 
conducting tests, it works normally. Thanks.
> 
> Thanks.
> 
> From: Ge Yang <yangge1116@126.com>
> Subject: mm/cma: using per-CMA locks to improve concurrent allocation performance
> Date: Mon, 10 Feb 2025 09:56:06 +0800
> 
> For different CMAs, concurrent allocation of CMA memory ideally should not
> require synchronization using locks.  Currently, a global cma_mutex lock
> is employed to synchronize all CMA allocations, which can impact the
> performance of concurrent allocations across different CMAs.
> 
> To test the performance impact, follow these steps:
> 1. Boot the kernel with the command line argument hugetlb_cma=30G to
>     allocate a 30GB CMA area specifically for huge page allocations. (note:
>     on my machine, which has 3 nodes, each node is initialized with 10G of
>     CMA)
> 2. Use the dd command with parameters if=/dev/zero of=/dev/shm/file bs=1G
>     count=30 to fully utilize the CMA area by writing zeroes to a file in
>     /dev/shm.
> 3. Open three terminals and execute the following commands simultaneously:
>     (Note: Each of these commands attempts to allocate 10GB [2621440 * 4KB
>     pages] of CMA memory.)
>     On Terminal 1: time echo 2621440 > /sys/kernel/debug/cma/hugetlb1/alloc
>     On Terminal 2: time echo 2621440 > /sys/kernel/debug/cma/hugetlb2/alloc
>     On Terminal 3: time echo 2621440 > /sys/kernel/debug/cma/hugetlb3/alloc
> 
> We attempt to allocate pages through the CMA debug interface and use the
> time command to measure the duration of each allocation.
> Performance comparison:
>               Without this patch      With this patch
> Terminal1        ~7s                     ~7s
> Terminal2       ~14s                     ~8s
> Terminal3       ~21s                     ~7s
> 
> To solve problem above, we could use per-CMA locks to improve concurrent
> allocation performance.  This would allow each CMA to be managed
> independently, reducing the need for a global lock and thus improving
> scalability and performance.
> 
> Link: https://lkml.kernel.org/r/1739152566-744-1-git-send-email-yangge1116@126.com
> Signed-off-by: Ge Yang <yangge1116@126.com>
> Reviewed-by: Barry Song <baohua@kernel.org>
> Acked-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> Cc: Aisheng Dong <aisheng.dong@nxp.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>   mm/cma.c |    7 ++++---
>   mm/cma.h |    1 +
>   2 files changed, 5 insertions(+), 3 deletions(-)
> 
> --- a/mm/cma.c~mm-cma-using-per-cma-locks-to-improve-concurrent-allocation-performance
> +++ a/mm/cma.c
> @@ -34,7 +34,6 @@
>   
>   struct cma cma_areas[MAX_CMA_AREAS];
>   unsigned int cma_area_count;
> -static DEFINE_MUTEX(cma_mutex);
>   
>   static int __init __cma_declare_contiguous_nid(phys_addr_t base,
>   			phys_addr_t size, phys_addr_t limit,
> @@ -175,6 +174,8 @@ static void __init cma_activate_area(str
>   
>   	spin_lock_init(&cma->lock);
>   
> +	mutex_init(&cma->alloc_mutex);
> +
>   #ifdef CONFIG_CMA_DEBUGFS
>   	INIT_HLIST_HEAD(&cma->mem_head);
>   	spin_lock_init(&cma->mem_head_lock);
> @@ -813,9 +814,9 @@ static int cma_range_alloc(struct cma *c
>   		spin_unlock_irq(&cma->lock);
>   
>   		pfn = cmr->base_pfn + (bitmap_no << cma->order_per_bit);
> -		mutex_lock(&cma_mutex);
> +		mutex_lock(&cma->alloc_mutex);
>   		ret = alloc_contig_range(pfn, pfn + count, MIGRATE_CMA, gfp);
> -		mutex_unlock(&cma_mutex);
> +		mutex_unlock(&cma->alloc_mutex);
>   		if (ret == 0) {
>   			page = pfn_to_page(pfn);
>   			break;
> --- a/mm/cma.h~mm-cma-using-per-cma-locks-to-improve-concurrent-allocation-performance
> +++ a/mm/cma.h
> @@ -39,6 +39,7 @@ struct cma {
>   	unsigned long	available_count;
>   	unsigned int order_per_bit; /* Order of pages represented by one bit */
>   	spinlock_t	lock;
> +	struct mutex alloc_mutex;
>   #ifdef CONFIG_CMA_DEBUGFS
>   	struct hlist_head mem_head;
>   	spinlock_t mem_head_lock;
> _


