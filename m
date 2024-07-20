Return-Path: <linux-kernel+bounces-257870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD0B937FF7
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 10:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF14F281A99
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 08:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA83F2E62B;
	Sat, 20 Jul 2024 08:11:58 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B8A1A291
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 08:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721463118; cv=none; b=DIIEz8pMc8cHqjXFZLAem4jtdO+Ci5ggOUUYSK7ob9Lwt4GWecdkpkSZKK+bofDiVjPqUcaq/pDdyQQFWj3Gb5DfUXljZHTlYGg5HKyqDRGyRweYuDYKxjm6MUwgQWt31o44eHVXMsPmuNTLmPpZl2WInaKooGnDUGjTAusWAIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721463118; c=relaxed/simple;
	bh=wwdFiKdlkSc5q80BLYxYF2U+lKcoCHfh2eNCUDS2Rxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GO/Q21IR5PiCOGkwHwvMp6SHeu9Rt6nHr6I94YKJ30hRYYIMreVgAvvhP3fnFWeeJOlHvz3IiZ87J0sTl0OGVv++qjHPI6z85dVS2KVpp3BCh/vdo/zerYuqUF/ijdR/qIzZVu+ztdk1eAYxoOO7JVH99PEinnmnYyARnYjk92o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WQzf846hyzlXjK;
	Sat, 20 Jul 2024 16:06:56 +0800 (CST)
Received: from dggpemf100008.china.huawei.com (unknown [7.185.36.138])
	by mail.maildlp.com (Postfix) with ESMTPS id 55F2F1800A4;
	Sat, 20 Jul 2024 16:11:52 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemf100008.china.huawei.com (7.185.36.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 20 Jul 2024 16:11:51 +0800
Message-ID: <f4ae2c9c-fe40-4807-bdb2-64cf2d716c1a@huawei.com>
Date: Sat, 20 Jul 2024 16:11:51 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] memory tiering: read last_cpupid correctly in
 do_huge_pmd_numa_page()
Content-Language: en-US
To: Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>,
	<linux-mm@kvack.org>
CC: David Hildenbrand <david@redhat.com>, "Huang, Ying"
	<ying.huang@intel.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
	<linux-kernel@vger.kernel.org>
References: <20240719144306.258018-1-ziy@nvidia.com>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20240719144306.258018-1-ziy@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf100008.china.huawei.com (7.185.36.138)



On 2024/7/19 22:43, Zi Yan wrote:
> last_cpupid is only available when memory tiering is off or the folio
> is in toptier node. Complete the check to read last_cpupid when it is
> available.
> 
> Before the fix, the default last_cpupid will be used even if memory
> tiering mode is turned off at runtime instead of the actual value. This
> can prevent task_numa_fault() from getting right numa fault stats, but
> should not cause any crash. User might see performance changes after the
> fix.
> 
> Reported-by: David Hildenbrand <david@redhat.com>
> Closes: https://lore.kernel.org/linux-mm/9af34a6b-ca56-4a64-8aa6-ade65f109288@redhat.com/
> Fixes: 33024536bafd ("memory tiering: hot page selection with hint page fault latency")
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Acked-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>

and we better to check numabalance mode in migrate_misplaced_folio()?

--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2630,7 +2630,8 @@ int migrate_misplaced_folio(struct folio *folio, 
struct vm_area_struct *vma,
                 putback_movable_pages(&migratepages);
         if (nr_succeeded) {
                 count_vm_numa_events(NUMA_PAGE_MIGRATE, nr_succeeded);
-               if (!node_is_toptier(folio_nid(folio)) && 
node_is_toptier(node))
+               if ((sysctl_numa_balancing_mode & 
NUMA_BALANCING_MEMORY_TIERING)
+                   &&!node_is_toptier(folio_nid(folio)) && 
node_is_toptier(node))
                         mod_node_page_state(pgdat, PGPROMOTE_SUCCESS,
                                             nr_succeeded);
         }



> ---
>   mm/huge_memory.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index f4be468e06a4..825317aee88e 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1712,7 +1712,8 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
>   	 * For memory tiering mode, cpupid of slow memory page is used
>   	 * to record page access time.  So use default value.
>   	 */
> -	if (node_is_toptier(nid))
> +	if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) ||
> +	    node_is_toptier(nid))
>   		last_cpupid = folio_last_cpupid(folio);
>   	target_nid = numa_migrate_prep(folio, vmf, haddr, nid, &flags);
>   	if (target_nid == NUMA_NO_NODE)

