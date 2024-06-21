Return-Path: <linux-kernel+bounces-223845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFEE0911939
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 06:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 617862845A7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 04:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6055312BF23;
	Fri, 21 Jun 2024 04:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="TUnUGvqL"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D74EAD4E
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 04:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718942840; cv=none; b=eCoh+yz+yNbKs0ZHtfoHGg8cIlUwScOYvVptlfXRKDHk3E4xSdWzfYKn/UO7RvFlFD/nHHn647A9RpBnKQRC4JLdT4bD5h/5QVfI0xvIGJ91hALmcvKBOxkN3IYX4vi3R5C8wIf6uDqR4E3BgSzCs+J2eWJTz3+GhPmk8torKxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718942840; c=relaxed/simple;
	bh=uDq8QfZBOHisxeRvSqN3RSD8spaRim7uL7yyZ+lw9pQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EgodY077qBJimshKtx+duZ3Db0aHkVfxzcVfyV70MDt2RjQQG5ipqzE5tcneys7WOA9ovDxa6/5P0ig1Tr9a0PqbWaWthhFdohBge9pYu4rYqT262TYMirNYGdk/Uf1BMjwixRanDtUlIbWB1mSRVdkobCD8HKs5lq+Evp3LfnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=TUnUGvqL; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718942835; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=rxIbxagrj/Vedqxi//Pn/mRNtDSRg0EkKj8wPHa94BQ=;
	b=TUnUGvqL4MDH8Kki5ox/2qF8svGL0mNePHhoWT2WO2lHjhW/grI8SGNkIsWnkZ7jHFke6SltRU29QV8kjkZECx2/WTOk/l9CYfbjAdbbfY65AZ9k2mQd3McWxbOOoqXjLvLQOwG0ZILZDxQoWm/GOIGMMEwO1tV9MJMIyqn7BFw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W8uztnr_1718942833;
Received: from 192.168.43.81(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W8uztnr_1718942833)
          by smtp.aliyun-inc.com;
          Fri, 21 Jun 2024 12:07:14 +0800
Message-ID: <05b89531-4103-49cb-bbbf-5a2cfaa3106b@linux.alibaba.com>
Date: Fri, 21 Jun 2024 12:07:12 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] mm/migrate: move NUMA hinting fault folio
 isolation + checks under PTL
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
References: <20240620212935.656243-1-david@redhat.com>
 <20240620212935.656243-3-david@redhat.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20240620212935.656243-3-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/6/21 05:29, David Hildenbrand wrote:
> Currently we always take a folio reference even if migration will not
> even be tried or isolation failed, requiring us to grab+drop an additional
> reference.
> 
> Further, we end up calling folio_likely_mapped_shared() while the folio
> might have already been unmapped, because after we dropped the PTL, that
> can easily happen. We want to stop touching mapcounts and friends from
> such context, and only call folio_likely_mapped_shared() while the folio
> is still mapped: mapcount information is pretty much stale and unreliable
> otherwise.
> 
> So let's move checks into numamigrate_isolate_folio(), rename that
> function to migrate_misplaced_folio_prepare(), and call that function
> from callsites where we call migrate_misplaced_folio(), but still with
> the PTL held.
> 
> We can now stop taking temporary folio references, and really only take
> a reference if folio isolation succeeded. Doing the
> folio_likely_mapped_shared() + golio isolation under PT lock is now similar
> to how we handle MADV_PAGEOUT.

s/golio/folio

Make sense to me. Feel free to add:
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> 
> While at it, combine the folio_is_file_lru() checks.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   include/linux/migrate.h |  7 ++++
>   mm/huge_memory.c        |  8 ++--
>   mm/memory.c             |  9 +++--
>   mm/migrate.c            | 81 +++++++++++++++++++----------------------
>   4 files changed, 55 insertions(+), 50 deletions(-)
> 
> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> index f9d92482d117..644be30b69c8 100644
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
> @@ -139,9 +139,16 @@ const struct movable_operations *page_movable_ops(struct page *page)
>   }
>   
>   #ifdef CONFIG_NUMA_BALANCING
> +int migrate_misplaced_folio_prepare(struct folio *folio,
> +		struct vm_area_struct *vma, int node);
>   int migrate_misplaced_folio(struct folio *folio, struct vm_area_struct *vma,
>   			   int node);
>   #else
> +static inline int migrate_misplaced_folio_prepare(struct folio *folio,
> +		struct vm_area_struct *vma, int node)
> +{
> +	return -EAGAIN; /* can't migrate now */
> +}
>   static inline int migrate_misplaced_folio(struct folio *folio,
>   					 struct vm_area_struct *vma, int node)
>   {
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index fc27dabcd8e3..4b2817bb2c7d 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1688,11 +1688,13 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
>   	if (node_is_toptier(nid))
>   		last_cpupid = folio_last_cpupid(folio);
>   	target_nid = numa_migrate_prep(folio, vmf, haddr, nid, &flags);
> -	if (target_nid == NUMA_NO_NODE) {
> -		folio_put(folio);
> +	if (target_nid == NUMA_NO_NODE)
> +		goto out_map;
> +	if (migrate_misplaced_folio_prepare(folio, vma, target_nid)) {
> +		flags |= TNF_MIGRATE_FAIL;
>   		goto out_map;
>   	}
> -
> +	/* The folio is isolated and isolation code holds a folio reference. */
>   	spin_unlock(vmf->ptl);
>   	writable = false;
>   
> diff --git a/mm/memory.c b/mm/memory.c
> index 118660de5bcc..4fd1ecfced4d 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5207,8 +5207,6 @@ int numa_migrate_prep(struct folio *folio, struct vm_fault *vmf,
>   {
>   	struct vm_area_struct *vma = vmf->vma;
>   
> -	folio_get(folio);
> -
>   	/* Record the current PID acceesing VMA */
>   	vma_set_access_pid_bit(vma);
>   
> @@ -5345,10 +5343,13 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>   	else
>   		last_cpupid = folio_last_cpupid(folio);
>   	target_nid = numa_migrate_prep(folio, vmf, vmf->address, nid, &flags);
> -	if (target_nid == NUMA_NO_NODE) {
> -		folio_put(folio);
> +	if (target_nid == NUMA_NO_NODE)
> +		goto out_map;
> +	if (migrate_misplaced_folio_prepare(folio, vma, target_nid)) {
> +		flags |= TNF_MIGRATE_FAIL;
>   		goto out_map;
>   	}
> +	/* The folio is isolated and isolation code holds a folio reference. */
>   	pte_unmap_unlock(vmf->pte, vmf->ptl);
>   	writable = false;
>   	ignore_writable = true;
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 0307b54879a0..27f070f64f27 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2530,9 +2530,37 @@ static struct folio *alloc_misplaced_dst_folio(struct folio *src,
>   	return __folio_alloc_node(gfp, order, nid);
>   }
>   
> -static int numamigrate_isolate_folio(pg_data_t *pgdat, struct folio *folio)
> +/*
> + * Prepare for calling migrate_misplaced_folio() by isolating the folio if
> + * permitted. Must be called with the PTL still held.
> + */
> +int migrate_misplaced_folio_prepare(struct folio *folio,
> +		struct vm_area_struct *vma, int node)
>   {
>   	int nr_pages = folio_nr_pages(folio);
> +	pg_data_t *pgdat = NODE_DATA(node);
> +
> +	if (folio_is_file_lru(folio)) {
> +		/*
> +		 * Do not migrate file folios that are mapped in multiple
> +		 * processes with execute permissions as they are probably
> +		 * shared libraries.
> +		 *
> +		 * See folio_likely_mapped_shared() on possible imprecision
> +		 * when we cannot easily detect if a folio is shared.
> +		 */
> +		if ((vma->vm_flags & VM_EXEC) &&
> +		    folio_likely_mapped_shared(folio))
> +			return -EACCES;
> +
> +		/*
> +		 * Do not migrate dirty folios as not all filesystems can move
> +		 * dirty folios in MIGRATE_ASYNC mode which is a waste of
> +		 * cycles.
> +		 */
> +		if (folio_test_dirty(folio))
> +			return -EAGAIN;
> +	}
>   
>   	/* Avoid migrating to a node that is nearly full */
>   	if (!migrate_balanced_pgdat(pgdat, nr_pages)) {
> @@ -2550,65 +2578,37 @@ static int numamigrate_isolate_folio(pg_data_t *pgdat, struct folio *folio)
>   		 * further.
>   		 */
>   		if (z < 0)
> -			return 0;
> +			return -EAGAIN;
>   
>   		wakeup_kswapd(pgdat->node_zones + z, 0,
>   			      folio_order(folio), ZONE_MOVABLE);
> -		return 0;
> +		return -EAGAIN;
>   	}
>   
>   	if (!folio_isolate_lru(folio))
> -		return 0;
> +		return -EAGAIN;
>   
>   	node_stat_mod_folio(folio, NR_ISOLATED_ANON + folio_is_file_lru(folio),
>   			    nr_pages);
> -
> -	/*
> -	 * Isolating the folio has taken another reference, so the
> -	 * caller's reference can be safely dropped without the folio
> -	 * disappearing underneath us during migration.
> -	 */
> -	folio_put(folio);
> -	return 1;
> +	return 0;
>   }

(just a nit: returning boolean seems more readable)

>   
>   /*
>    * Attempt to migrate a misplaced folio to the specified destination
> - * node. Caller is expected to have an elevated reference count on
> - * the folio that will be dropped by this function before returning.
> + * node. Caller is expected to have isolated the folio by calling
> + * migrate_misplaced_folio_prepare(), which will result in an
> + * elevated reference count on the folio. This function will un-isolate the
> + * folio, dereferencing the folio before returning.
>    */
>   int migrate_misplaced_folio(struct folio *folio, struct vm_area_struct *vma,
>   			    int node)
>   {
>   	pg_data_t *pgdat = NODE_DATA(node);
> -	int isolated;
>   	int nr_remaining;
>   	unsigned int nr_succeeded;
>   	LIST_HEAD(migratepages);
>   	int nr_pages = folio_nr_pages(folio);
>   
> -	/*
> -	 * Don't migrate file folios that are mapped in multiple processes
> -	 * with execute permissions as they are probably shared libraries.
> -	 *
> -	 * See folio_likely_mapped_shared() on possible imprecision when we
> -	 * cannot easily detect if a folio is shared.
> -	 */
> -	if (folio_likely_mapped_shared(folio) && folio_is_file_lru(folio) &&
> -	    (vma->vm_flags & VM_EXEC))
> -		goto out;
> -
> -	/*
> -	 * Also do not migrate dirty folios as not all filesystems can move
> -	 * dirty folios in MIGRATE_ASYNC mode which is a waste of cycles.
> -	 */
> -	if (folio_is_file_lru(folio) && folio_test_dirty(folio))
> -		goto out;
> -
> -	isolated = numamigrate_isolate_folio(pgdat, folio);
> -	if (!isolated)
> -		goto out;
> -
>   	list_add(&folio->lru, &migratepages);
>   	nr_remaining = migrate_pages(&migratepages, alloc_misplaced_dst_folio,
>   				     NULL, node, MIGRATE_ASYNC,
> @@ -2620,7 +2620,6 @@ int migrate_misplaced_folio(struct folio *folio, struct vm_area_struct *vma,
>   					folio_is_file_lru(folio), -nr_pages);
>   			folio_putback_lru(folio);
>   		}
> -		isolated = 0;
>   	}
>   	if (nr_succeeded) {
>   		count_vm_numa_events(NUMA_PAGE_MIGRATE, nr_succeeded);
> @@ -2629,11 +2628,7 @@ int migrate_misplaced_folio(struct folio *folio, struct vm_area_struct *vma,
>   					    nr_succeeded);
>   	}
>   	BUG_ON(!list_empty(&migratepages));
> -	return isolated ? 0 : -EAGAIN;
> -
> -out:
> -	folio_put(folio);
> -	return -EAGAIN;
> +	return nr_remaining ? -EAGAIN : 0;
>   }
>   #endif /* CONFIG_NUMA_BALANCING */
>   #endif /* CONFIG_NUMA */

