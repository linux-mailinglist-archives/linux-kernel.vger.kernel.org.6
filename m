Return-Path: <linux-kernel+bounces-211585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B8090540A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 15:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4B35B21357
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 13:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0129C17C7C1;
	Wed, 12 Jun 2024 13:46:26 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204D27FB
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 13:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718199985; cv=none; b=az/D8x605I8lJeh+AHmhsF+Lif1mm9FxVBZTj64uutZofk6pbRCmbTp5gifbV0IbYySolCJMvw+gcLBV456w+sKIuFg/CTL/pIYZ0cWlFX7v4n7NHbNOsu1nQY2Ghkk9NJzpfd54Leb8MGK8FH/dvSRinK9S821t5GSWqK8x2LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718199985; c=relaxed/simple;
	bh=enYU9795cBzStQtdGNP3wA0LSi6gU7vJzy/bNPSiwWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TjViECnJNcpXv2eRu7e9vPxOofVu4gf1YEzF+MFg3cQVdth4Q6Eudn0SirPHo6U4AiOLCtMf5OCDx8FCbhm7VPjvEf1nIp8T8DH8+dCP/SZpw7tFPWVW1kAHg9MuI50EAWQo7wzqvPVdM96g24Yjs2ZbYKUduvHrJNZZM0aATIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VzmtZ3VDyzxSRP;
	Wed, 12 Jun 2024 21:42:14 +0800 (CST)
Received: from dggpemf100008.china.huawei.com (unknown [7.185.36.138])
	by mail.maildlp.com (Postfix) with ESMTPS id 0EAB118007A;
	Wed, 12 Jun 2024 21:46:19 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemf100008.china.huawei.com (7.185.36.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 12 Jun 2024 21:46:18 +0800
Message-ID: <e60808c6-5d50-42c4-a736-f1f417f85327@huawei.com>
Date: Wed, 12 Jun 2024 21:46:17 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/6] mm: shmem: add mTHP counters for anonymous shmem
Content-Language: en-US
To: Baolin Wang <baolin.wang@linux.alibaba.com>, <akpm@linux-foundation.org>,
	<hughd@google.com>
CC: <willy@infradead.org>, <david@redhat.com>, <ying.huang@intel.com>,
	<21cnbao@gmail.com>, <ryan.roberts@arm.com>, <shy828301@gmail.com>,
	<ziy@nvidia.com>, <ioworker0@gmail.com>, <da.gomez@samsung.com>,
	<p.raghav@samsung.com>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <cover.1718090413.git.baolin.wang@linux.alibaba.com>
 <4fd9e467d49ae4a747e428bcd821c7d13125ae67.1718090413.git.baolin.wang@linux.alibaba.com>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <4fd9e467d49ae4a747e428bcd821c7d13125ae67.1718090413.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf100008.china.huawei.com (7.185.36.138)



On 2024/6/11 18:11, Baolin Wang wrote:
> Add mTHP counters for anonymous shmem.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>   include/linux/huge_mm.h |  3 +++
>   mm/huge_memory.c        |  6 ++++++
>   mm/shmem.c              | 18 +++++++++++++++---
>   3 files changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 909cfc67521d..212cca384d7e 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -281,6 +281,9 @@ enum mthp_stat_item {
>   	MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
>   	MTHP_STAT_SWPOUT,
>   	MTHP_STAT_SWPOUT_FALLBACK,
> +	MTHP_STAT_FILE_ALLOC,
> +	MTHP_STAT_FILE_FALLBACK,
> +	MTHP_STAT_FILE_FALLBACK_CHARGE,
>   	__MTHP_STAT_COUNT
>   };
>   
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 1360a1903b66..3fbcd77f5957 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -555,6 +555,9 @@ DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTHP_STAT_ANON_FAULT_FALLBACK);
>   DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
>   DEFINE_MTHP_STAT_ATTR(swpout, MTHP_STAT_SWPOUT);
>   DEFINE_MTHP_STAT_ATTR(swpout_fallback, MTHP_STAT_SWPOUT_FALLBACK);
> +DEFINE_MTHP_STAT_ATTR(file_alloc, MTHP_STAT_FILE_ALLOC);
> +DEFINE_MTHP_STAT_ATTR(file_fallback, MTHP_STAT_FILE_FALLBACK);
> +DEFINE_MTHP_STAT_ATTR(file_fallback_charge, MTHP_STAT_FILE_FALLBACK_CHARGE);
>   
>   static struct attribute *stats_attrs[] = {
>   	&anon_fault_alloc_attr.attr,
> @@ -562,6 +565,9 @@ static struct attribute *stats_attrs[] = {
>   	&anon_fault_fallback_charge_attr.attr,
>   	&swpout_attr.attr,
>   	&swpout_fallback_attr.attr,
> +	&file_alloc_attr.attr,
> +	&file_fallback_attr.attr,
> +	&file_fallback_charge_attr.attr,
>   	NULL,
>   };
>   
> diff --git a/mm/shmem.c b/mm/shmem.c
> index f5469c357be6..99bd3c34f0fb 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1773,6 +1773,9 @@ static struct folio *shmem_alloc_and_add_folio(struct vm_fault *vmf,
>   
>   			if (pages == HPAGE_PMD_NR)
>   				count_vm_event(THP_FILE_FALLBACK);
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +			count_mthp_stat(order, MTHP_STAT_FILE_FALLBACK);
> +#endif
>   			order = next_order(&suitable_orders, order);
>   		}
>   	} else {
> @@ -1792,9 +1795,15 @@ static struct folio *shmem_alloc_and_add_folio(struct vm_fault *vmf,
>   		if (xa_find(&mapping->i_pages, &index,
>   				index + pages - 1, XA_PRESENT)) {
>   			error = -EEXIST;
> -		} else if (pages == HPAGE_PMD_NR) {
> -			count_vm_event(THP_FILE_FALLBACK);
> -			count_vm_event(THP_FILE_FALLBACK_CHARGE);
> +		} else if (pages > 1) {
> +			if (pages == HPAGE_PMD_NR) {
> +				count_vm_event(THP_FILE_FALLBACK);
> +				count_vm_event(THP_FILE_FALLBACK_CHARGE);
> +			}
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +			count_mthp_stat(folio_order(folio), MTHP_STAT_FILE_FALLBACK);
> +			count_mthp_stat(folio_order(folio), MTHP_STAT_FILE_FALLBACK_CHARGE);

pages > 1, we have correct order, count_mthp_stat(order, MTHP_XXX) ?

> +#endif
>   		}
>   		goto unlock;
>   	}
> @@ -2168,6 +2177,9 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
>   		if (!IS_ERR(folio)) {
>   			if (folio_test_pmd_mappable(folio))
>   				count_vm_event(THP_FILE_ALLOC);
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +			count_mthp_stat(folio_order(folio), MTHP_STAT_FILE_ALLOC);
> +#endif
>   			goto alloced;
>   		}
>   		if (PTR_ERR(folio) == -EEXIST)

