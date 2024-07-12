Return-Path: <linux-kernel+bounces-250081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1801892F407
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 04:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C873228110A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 02:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392828C0B;
	Fri, 12 Jul 2024 02:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ERJpJECu"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0795F8F40
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 02:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720751481; cv=none; b=njfV2vIXkyy6ws98iOgmDOn/5ojUeOa9wrbBQeHJ6NGCyTNGKl4qO67GONb/hUWcAiDHZJnFjfh82xRgsXU0QE2EDRbZXQfZQEP2SQctqYNk6Y8dmuK4dXtxYeMYB5iz+Ko8mpxBFtOLquPabyyFtlxCtS4krf/85omzx9WkT9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720751481; c=relaxed/simple;
	bh=bkX1L8BAxd0Yt78uCL3HyZR9DSkCzmU45zLgJuRysfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D7zC6K1f33xMTPHSEIMA7nwO/9SYg9Z2LOwYmLjWESGth2dspPJk9H9ojGuQtJSI1lJErAv3Z0xoroX6MzmAqIr9bwAmbt5HoCwlJOOGXSt1hU1k5O0PehC2Wyk5fxHlJifN3w8OYMnn9p/4/zBMs9fCkanqEUj8+oZ0+vqGZqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ERJpJECu; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720751470; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=lok5tuEdeyByFVRG4EgUL7JH/PFSJe458NPgFNKRyXE=;
	b=ERJpJECuFIM1FI6voBur+XkQMejcofKVCl1b2qvC+zB33rA1PHVmheDwocdqI78rs4P8OPyJLrFTh5ML+Wt2d9EaHO+FnsL+HYXHQ5dP4nd4uyLkO+jy36vODvGwnqdDTs4rAzw1EqpJhy0U7CAf0BXstydFbx96yYcU1tZPKmE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0WAMLwvw_1720751467;
Received: from 30.97.56.66(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WAMLwvw_1720751467)
          by smtp.aliyun-inc.com;
          Fri, 12 Jul 2024 10:31:08 +0800
Message-ID: <0037de9e-bd64-4203-960d-bbc31fff611f@linux.alibaba.com>
Date: Fri, 12 Jul 2024 10:31:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] mm: Cleanup count_mthp_stat() definition
To: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>,
 Jonathan Corbet <corbet@lwn.net>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 David Hildenbrand <david@redhat.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <ioworker0@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240711072929.3590000-1-ryan.roberts@arm.com>
 <20240711072929.3590000-2-ryan.roberts@arm.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20240711072929.3590000-2-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/7/11 15:29, Ryan Roberts wrote:
> Let's move count_mthp_stat() so that it's always defined, even when THP
> is disabled. Previously uses of the function in files such as shmem.c,
> which are compiled even when THP is disabled, required ugly THP
> ifdeferry. With this cleanup, we can remove those ifdefs and the
> function resolves to a nop when THP is disabled.
> 
> I shortly plan to call count_mthp_stat() from more THP-invariant source
> files.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   include/linux/huge_mm.h | 70 ++++++++++++++++++++---------------------
>   mm/memory.c             |  2 --
>   mm/shmem.c              |  6 ----
>   3 files changed, 35 insertions(+), 43 deletions(-)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index cff002be83eb..cb93b9009ce4 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -108,6 +108,41 @@ extern struct kobj_attribute thpsize_shmem_enabled_attr;
>   #define HPAGE_PUD_MASK	(~(HPAGE_PUD_SIZE - 1))
>   #define HPAGE_PUD_SIZE	((1UL) << HPAGE_PUD_SHIFT)
>   
> +enum mthp_stat_item {
> +	MTHP_STAT_ANON_FAULT_ALLOC,
> +	MTHP_STAT_ANON_FAULT_FALLBACK,
> +	MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
> +	MTHP_STAT_SWPOUT,
> +	MTHP_STAT_SWPOUT_FALLBACK,
> +	MTHP_STAT_SHMEM_ALLOC,
> +	MTHP_STAT_SHMEM_FALLBACK,
> +	MTHP_STAT_SHMEM_FALLBACK_CHARGE,
> +	MTHP_STAT_SPLIT,
> +	MTHP_STAT_SPLIT_FAILED,
> +	MTHP_STAT_SPLIT_DEFERRED,
> +	__MTHP_STAT_COUNT
> +};
> +
> +#if defined(CONFIG_TRANSPARENT_HUGEPAGE) && defined(CONFIG_SYSFS)
> +struct mthp_stat {
> +	unsigned long stats[ilog2(MAX_PTRS_PER_PTE) + 1][__MTHP_STAT_COUNT];
> +};
> +
> +DECLARE_PER_CPU(struct mthp_stat, mthp_stats);
> +
> +static inline void count_mthp_stat(int order, enum mthp_stat_item item)
> +{
> +	if (order <= 0 || order > PMD_ORDER)
> +		return;
> +
> +	this_cpu_inc(mthp_stats.stats[order][item]);
> +}
> +#else
> +static inline void count_mthp_stat(int order, enum mthp_stat_item item)
> +{
> +}
> +#endif
> +
>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>   
>   extern unsigned long transparent_hugepage_flags;
> @@ -263,41 +298,6 @@ struct thpsize {
>   
>   #define to_thpsize(kobj) container_of(kobj, struct thpsize, kobj)
>   
> -enum mthp_stat_item {
> -	MTHP_STAT_ANON_FAULT_ALLOC,
> -	MTHP_STAT_ANON_FAULT_FALLBACK,
> -	MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
> -	MTHP_STAT_SWPOUT,
> -	MTHP_STAT_SWPOUT_FALLBACK,
> -	MTHP_STAT_SHMEM_ALLOC,
> -	MTHP_STAT_SHMEM_FALLBACK,
> -	MTHP_STAT_SHMEM_FALLBACK_CHARGE,
> -	MTHP_STAT_SPLIT,
> -	MTHP_STAT_SPLIT_FAILED,
> -	MTHP_STAT_SPLIT_DEFERRED,
> -	__MTHP_STAT_COUNT
> -};
> -
> -struct mthp_stat {
> -	unsigned long stats[ilog2(MAX_PTRS_PER_PTE) + 1][__MTHP_STAT_COUNT];
> -};
> -
> -#ifdef CONFIG_SYSFS
> -DECLARE_PER_CPU(struct mthp_stat, mthp_stats);
> -
> -static inline void count_mthp_stat(int order, enum mthp_stat_item item)
> -{
> -	if (order <= 0 || order > PMD_ORDER)
> -		return;
> -
> -	this_cpu_inc(mthp_stats.stats[order][item]);
> -}
> -#else
> -static inline void count_mthp_stat(int order, enum mthp_stat_item item)
> -{
> -}
> -#endif
> -
>   #define transparent_hugepage_use_zero_page()				\
>   	(transparent_hugepage_flags &					\
>   	 (1<<TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG))
> diff --git a/mm/memory.c b/mm/memory.c
> index 802d0d8a40f9..a50fdefb8f0b 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4597,9 +4597,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>   
>   	folio_ref_add(folio, nr_pages - 1);
>   	add_mm_counter(vma->vm_mm, MM_ANONPAGES, nr_pages);
> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>   	count_mthp_stat(folio_order(folio), MTHP_STAT_ANON_FAULT_ALLOC);
> -#endif
>   	folio_add_new_anon_rmap(folio, vma, addr, RMAP_EXCLUSIVE);
>   	folio_add_lru_vma(folio, vma);
>   setpte:
> diff --git a/mm/shmem.c b/mm/shmem.c
> index f24dfbd387ba..fce1343f44e6 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1776,9 +1776,7 @@ static struct folio *shmem_alloc_and_add_folio(struct vm_fault *vmf,
>   
>   			if (pages == HPAGE_PMD_NR)
>   				count_vm_event(THP_FILE_FALLBACK);
> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>   			count_mthp_stat(order, MTHP_STAT_SHMEM_FALLBACK);
> -#endif
>   			order = next_order(&suitable_orders, order);
>   		}
>   	} else {
> @@ -1803,10 +1801,8 @@ static struct folio *shmem_alloc_and_add_folio(struct vm_fault *vmf,
>   				count_vm_event(THP_FILE_FALLBACK);
>   				count_vm_event(THP_FILE_FALLBACK_CHARGE);
>   			}
> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>   			count_mthp_stat(folio_order(folio), MTHP_STAT_SHMEM_FALLBACK);
>   			count_mthp_stat(folio_order(folio), MTHP_STAT_SHMEM_FALLBACK_CHARGE);
> -#endif
>   		}
>   		goto unlock;
>   	}
> @@ -2180,9 +2176,7 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
>   		if (!IS_ERR(folio)) {
>   			if (folio_test_pmd_mappable(folio))
>   				count_vm_event(THP_FILE_ALLOC);
> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>   			count_mthp_stat(folio_order(folio), MTHP_STAT_SHMEM_ALLOC);
> -#endif
>   			goto alloced;
>   		}
>   		if (PTR_ERR(folio) == -EEXIST)

