Return-Path: <linux-kernel+bounces-311227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DC7968656
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 13:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82016284DDB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0EB187847;
	Mon,  2 Sep 2024 11:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DQl7R2YW"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC85195
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 11:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725277075; cv=none; b=hZ6a3RzItoGUK5j4NnBUQ809U8lD5VF0tGvabK4M+e38cFnKIGV2bUI5SLZGYuWX6qBP+6fWDt9LePVwnB5sWwU0HMgsW0EUyUo5N+gfhTsHRImkpYZMLf3USDhs8KDL1zmNueYDdlAXAKdPWIjimYc9/NDNkfsq0sIUdh7n/Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725277075; c=relaxed/simple;
	bh=Tkki6xTePpiCUKrvVyB8P2cb6VokZ8xbzNC9Iy4jeH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gttDSLLvRfjMzrNj7I9l2yxBwqDM8QfpRtGfUKcQXVOuBQnnRXBv1AbPMK8uO5osrEFto0jc+xrnt7Qb9yK5U780FmXs7yz0MjXdXt0HYBbsR1/+elgPnrzyd+7XfAMmM0mjIA7c39Zryh7wuwIpeYo/Fe5Piq/WwcM+aCMFPV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DQl7R2YW; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <07e2365b-48d2-48e8-9ed3-81a2baf377fc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725277069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uyVq+8UTCbJtNv99fw/EL/a236+8T/SsMGDzI7q67Hs=;
	b=DQl7R2YWeDMLK08mR+LDb2G3+3KAYHpIaF7nTtHwcyU6e1KttuzNe7Tn3Cv5DljElnFAUI
	FDgvgagbFGt2NTq9UtCzYQ+vDHqrloKCAlZylwaCYRDyOC/EuMZ00tkWciStGDwy5NBRfM
	Bh6zt1efXld220i26UPUOTH6qAsO+7w=
Date: Mon, 2 Sep 2024 19:37:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v6 2/3] mm: zswap: zswap_store() extended to handle mTHP
 folios.
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, hannes@cmpxchg.org,
 yosryahmed@google.com, nphamcs@gmail.com, usamaarif642@gmail.com,
 ryan.roberts@arm.com, ying.huang@intel.com, 21cnbao@gmail.com,
 akpm@linux-foundation.org
Cc: nanhai.zou@intel.com, wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
References: <20240829212705.6714-1-kanchana.p.sridhar@intel.com>
 <20240829212705.6714-3-kanchana.p.sridhar@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240829212705.6714-3-kanchana.p.sridhar@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/8/30 05:27, Kanchana P Sridhar wrote:
> zswap_store() will now process and store mTHP and PMD-size THP folios.
> 
> A new config variable CONFIG_ZSWAP_STORE_THP_DEFAULT_ON (off by default)
> will enable/disable zswap storing of (m)THP.
> 
> This change reuses and adapts the functionality in Ryan Roberts' RFC
> patch [1]:
> 
>    "[RFC,v1] mm: zswap: Store large folios without splitting"
> 
>    [1] https://lore.kernel.org/linux-mm/20231019110543.3284654-1-ryan.roberts@arm.com/T/#u
> 
> This patch provides a sequential implementation of storing an mTHP in
> zswap_store() by iterating through each page in the folio to compress
> and store it in the zswap zpool.
> 
> Towards this goal, zswap_compress() is modified to take a page instead
> of a folio as input.
> 
> Each page's swap offset is stored as a separate zswap entry.
> 
> If an error is encountered during the store of any page in the mTHP,
> all previous pages/entries stored will be invalidated. Thus, an mTHP
> is either entirely stored in ZSWAP, or entirely not stored in ZSWAP.
> 
> This forms the basis for building batching of pages during zswap store
> of large folios, by compressing batches of up to say, 8 pages in an
> mTHP in parallel in hardware, with the Intel In-Memory Analytics
> Accelerator (Intel IAA).
> 
> Also, addressed some of the RFC comments from the discussion in [1].
> 
> Made a minor edit in the comments for "struct zswap_entry" to delete
> the comments related to "value" since same-filled page handling has
> been removed from zswap.
> 
> Co-developed-by: Ryan Roberts
> Signed-off-by:
> Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>

The code looks ok, but I also find this patch is a little hard to 
review, maybe it's better to split it into small patches as Yosry suggested.

Thanks!

[...]
> +
> +/*
> + * Modified to store mTHP folios. Each page in the mTHP will be compressed
> + * and stored sequentially.
> + */
> +bool zswap_store(struct folio *folio)
> +{
> +	long nr_pages = folio_nr_pages(folio);
> +	swp_entry_t swp = folio->swap;
> +	pgoff_t offset = swp_offset(swp);
> +	struct xarray *tree = swap_zswap_tree(swp);
> +	struct obj_cgroup *objcg = NULL;
> +	struct mem_cgroup *memcg = NULL;
> +	struct zswap_pool *pool;
> +	bool ret = false;
> +	long index;
> +
> +	VM_WARN_ON_ONCE(!folio_test_locked(folio));
> +	VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
> +
> +	/* Storing large folios isn't enabled */
> +	if (!zswap_mthp_enabled && folio_test_large(folio))
> +		return false;
> +
> +	if (!zswap_enabled)
> +		goto reject;
> +
>   	/*
> -	 * If the zswap store fails or zswap is disabled, we must invalidate the
> -	 * possibly stale entry which was previously stored at this offset.
> -	 * Otherwise, writeback could overwrite the new data in the swapfile.
> +	 * Check cgroup limits:
> +	 *
> +	 * The cgroup zswap limit check is done once at the beginning of an
> +	 * mTHP store, and not within zswap_store_page() for each page
> +	 * in the mTHP. We do however check the zswap pool limits at the
> +	 * start of zswap_store_page(). What this means is, the cgroup
> +	 * could go over the limits by at most (HPAGE_PMD_NR - 1) pages.
> +	 * However, the per-store-page zswap pool limits check should
> +	 * hopefully trigger the cgroup aware and zswap LRU aware global
> +	 * reclaim implemented in the shrinker. If this assumption holds,
> +	 * the cgroup exceeding the zswap limits could potentially be
> +	 * resolved before the next zswap_store, and if it is not, the next
> +	 * zswap_store would fail the cgroup zswap limit check at the start.
>   	 */
> -	entry = xa_erase(tree, offset);
> -	if (entry)
> -		zswap_entry_free(entry);
> -	return false;
> +	objcg = get_obj_cgroup_from_folio(folio);
> +	if (objcg && !obj_cgroup_may_zswap(objcg)) {
> +		memcg = get_mem_cgroup_from_objcg(objcg);
> +		if (shrink_memcg(memcg)) {
> +			mem_cgroup_put(memcg);
> +			goto put_objcg;
> +		}
> +		mem_cgroup_put(memcg);
> +	}
> +
> +	if (zswap_check_limits())
> +		goto put_objcg;
> +
> +	pool = zswap_pool_current_get();
> +	if (!pool)
> +		goto put_objcg;
> +
> +	if (objcg) {
> +		memcg = get_mem_cgroup_from_objcg(objcg);
> +		if (memcg_list_lru_alloc(memcg, &zswap_list_lru, GFP_KERNEL)) {
> +			mem_cgroup_put(memcg);
> +			goto put_pool;
> +		}
> +		mem_cgroup_put(memcg);
> +	}
> +
> +	/*
> +	 * Store each page of the folio as a separate entry. If we fail to store
> +	 * a page, unwind by removing all the previous pages we stored.
> +	 */
> +	for (index = 0; index < nr_pages; ++index) {
> +		if (!zswap_store_page(folio, index, objcg, pool))
> +			goto put_pool;
> +	}
> +
> +	ret = true;
> +
> +put_pool:
> +	zswap_pool_put(pool);
> +put_objcg:
> +	obj_cgroup_put(objcg);
> +	if (zswap_pool_reached_full)
> +		queue_work(shrink_wq, &zswap_shrink_work);
> +reject:
> +	/*
> +	 * If the zswap store fails or zswap is disabled, we must invalidate
> +	 * the possibly stale entries which were previously stored at the
> +	 * offsets corresponding to each page of the folio. Otherwise,
> +	 * writeback could overwrite the new data in the swapfile.
> +	 */
> +	if (!ret)
> +		zswap_delete_stored_offsets(tree, offset, nr_pages);
> +
> +	return ret;
>   }
>   
>   bool zswap_load(struct folio *folio)

