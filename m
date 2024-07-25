Return-Path: <linux-kernel+bounces-261622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6A693BA01
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 03:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52FA5283202
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 01:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168066AB6;
	Thu, 25 Jul 2024 01:01:41 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F124405
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 01:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721869300; cv=none; b=sclrERDjOCVhHMv/NLIcMS4J3MPXvOtFCCOZeUqACOe6VUaiL59jvLFQ4UPF1ynNbBxwIr7L8Sq7b+Ju8e9Jbz603At7vZVKFXBk976WkN5RSKHiDDvrPm882IJOPOyS/5t/7DSUXSCk4YtiEvS2Wtuv10QHrSUb+T4LB0Rj8Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721869300; c=relaxed/simple;
	bh=7wfYMA0GQuJH4PlLmQDkKiVN8eaLVgGpKfn0JP+Ks/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NfGzpJMk1lFoF32/SRZMVxA+C4a0/QxS/kGj6AcQ4z3HjT+G+BIcxls9/RC8VE4qjDogPaxYIqwtboYMxAHcX67akRjczYoH3sxU1jhhQ5TH1NGsn7lg62QG34pnWx5kAG/v4MdZKIoBsAWDufYGDTFBkjVhMrO5sOuz1Bf0NOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WTsyz5QMMz1L9K7;
	Thu, 25 Jul 2024 09:01:31 +0800 (CST)
Received: from dggpemf100008.china.huawei.com (unknown [7.185.36.138])
	by mail.maildlp.com (Postfix) with ESMTPS id 9D1BC14011B;
	Thu, 25 Jul 2024 09:01:34 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemf100008.china.huawei.com (7.185.36.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 25 Jul 2024 09:01:34 +0800
Message-ID: <60b10c39-3675-4cbc-96d8-2b6f1170464d@huawei.com>
Date: Thu, 25 Jul 2024 09:01:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] memory tiering: introduce folio_use_access_time()
 check
Content-Language: en-US
To: Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>,
	<linux-mm@kvack.org>
CC: David Hildenbrand <david@redhat.com>, "Huang, Ying"
	<ying.huang@intel.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, Lorenzo
 Stoakes <lorenzo.stoakes@oracle.com>, <linux-kernel@vger.kernel.org>
References: <20240724130115.793641-1-ziy@nvidia.com>
 <20240724130115.793641-3-ziy@nvidia.com>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20240724130115.793641-3-ziy@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf100008.china.huawei.com (7.185.36.138)



On 2024/7/24 21:01, Zi Yan wrote:
> If memory tiering mode is on and a folio is not in the top tier memory,
> folio's cpupid field is repurposed to store page access time. Instead of
> an open coded check, use a function to encapsulate the check.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> Acked-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>

> ---
>   include/linux/mm.h  |  6 ++++++
>   kernel/sched/fair.c |  3 +--
>   mm/huge_memory.c    |  6 ++----
>   mm/memory-tiers.c   | 19 +++++++++++++++++++
>   mm/memory.c         |  3 +--
>   mm/mprotect.c       |  3 +--
>   6 files changed, 30 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 17753a463e01..2c6ccf088c7b 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1717,6 +1717,8 @@ static inline void vma_set_access_pid_bit(struct vm_area_struct *vma)
>   		__set_bit(pid_bit, &vma->numab_state->pids_active[1]);
>   	}
>   }
> +
> +bool folio_use_access_time(struct folio *folio);
>   #else /* !CONFIG_NUMA_BALANCING */
>   static inline int folio_xchg_last_cpupid(struct folio *folio, int cpupid)
>   {
> @@ -1770,6 +1772,10 @@ static inline bool cpupid_match_pid(struct task_struct *task, int cpupid)
>   static inline void vma_set_access_pid_bit(struct vm_area_struct *vma)
>   {
>   }
> +static inline bool folio_use_access_time(struct folio *folio)
> +{
> +	return false;
> +}
>   #endif /* CONFIG_NUMA_BALANCING */
>   
>   #if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 9057584ec06d..416e29b56cc4 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1840,8 +1840,7 @@ bool should_numa_migrate_memory(struct task_struct *p, struct folio *folio,
>   	 * The pages in slow memory node should be migrated according
>   	 * to hot/cold instead of private/shared.
>   	 */
> -	if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
> -	    !node_is_toptier(src_nid)) {
> +	if (folio_use_access_time(folio)) {
>   		struct pglist_data *pgdat;
>   		unsigned long rate_limit;
>   		unsigned int latency, th, def_th;
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 15234b2e252e..5c0a6a4e3a6e 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1707,8 +1707,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
>   	 * For memory tiering mode, cpupid of slow memory page is used
>   	 * to record page access time.  So use default value.
>   	 */
> -	if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) ||
> -	    node_is_toptier(nid))
> +	if (!folio_use_access_time(folio))
>   		last_cpupid = folio_last_cpupid(folio);
>   	target_nid = numa_migrate_prep(folio, vmf, haddr, nid, &flags);
>   	if (target_nid == NUMA_NO_NODE)
> @@ -2061,8 +2060,7 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>   		    toptier)
>   			goto unlock;
>   
> -		if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
> -		    !toptier)
> +		if (folio_use_access_time(folio))
>   			folio_xchg_access_time(folio,
>   					       jiffies_to_msecs(jiffies));
>   	}
> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> index 4775b3a3dabe..2a642ea86cb2 100644
> --- a/mm/memory-tiers.c
> +++ b/mm/memory-tiers.c
> @@ -6,6 +6,7 @@
>   #include <linux/memory.h>
>   #include <linux/memory-tiers.h>
>   #include <linux/notifier.h>
> +#include <linux/sched/sysctl.h>
>   
>   #include "internal.h"
>   
> @@ -50,6 +51,24 @@ static const struct bus_type memory_tier_subsys = {
>   	.dev_name = "memory_tier",
>   };
>   
> +#ifdef CONFIG_NUMA_BALANCING
> +/**
> + * folio_use_access_time - check if a folio reuses cpupid for page access time
> + * @folio: folio to check
> + *
> + * folio's _last_cpupid field is repurposed by memory tiering. In memory
> + * tiering mode, cpupid of slow memory folio (not toptier memory) is used to
> + * record page access time.
> + *
> + * Return: the folio _last_cpupid is used to record page access time
> + */
> +bool folio_use_access_time(struct folio *folio)
> +{
> +	return (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) &&
> +	       !node_is_toptier(folio_nid(folio));
> +}
> +#endif
> +
>   #ifdef CONFIG_MIGRATION
>   static int top_tier_adistance;
>   /*
> diff --git a/mm/memory.c b/mm/memory.c
> index 802d0d8a40f9..833d2cad6eb2 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5337,8 +5337,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>   	 * For memory tiering mode, cpupid of slow memory page is used
>   	 * to record page access time.  So use default value.
>   	 */
> -	if ((sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) &&
> -	    !node_is_toptier(nid))
> +	if (folio_use_access_time(folio))
>   		last_cpupid = (-1 & LAST_CPUPID_MASK);
>   	else
>   		last_cpupid = folio_last_cpupid(folio);
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 222ab434da54..37cf8d249405 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -161,8 +161,7 @@ static long change_pte_range(struct mmu_gather *tlb,
>   				if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_NORMAL) &&
>   				    toptier)
>   					continue;
> -				if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
> -				    !toptier)
> +				if (folio_use_access_time(folio))
>   					folio_xchg_access_time(folio,
>   						jiffies_to_msecs(jiffies));
>   			}

