Return-Path: <linux-kernel+bounces-444329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B05C99F04E2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 07:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C78A282B51
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 06:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C3818C32C;
	Fri, 13 Dec 2024 06:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mxPU0tvT"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A62418B460
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 06:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734071757; cv=none; b=jbR8XlLhcupe1Mm7PuUEny3aGae1wvLNnFy+KPT8Ltl/KQ4paDqKL3wntkFxouzfoeBGrQ3Xh7NSCSNMTo1itb/jPchS1xCUegpWombxdBNggvB9l3I6DfD3d8db4VbCGODiDDWi35kZ2fIrjoxY4OL3sU61Pf1GrlSdSyjubRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734071757; c=relaxed/simple;
	bh=rNUsgX1UFCjmM3w5YyQDZmvzkXmAPOTIj5ZYr8WQY6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pmCO/IszcRBCsOtAcQFzDtfhULe58FCOpNsvhJtWI8Fzy1RPFO9b8C2r5TS2Gf/v/5XpofY1nwbKouuDCCoNkEM/Gqh4jP0OAdEv8TiB8i0uQWDDJ2hQoJNgvyZUoCI4r961/0h3URoRDzNqnO7mvZKjaIjJjcMAgHeY+D4z8nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mxPU0tvT; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1734071746; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=GuERQIdIT/vwm6N56w1N+DSK0yIlarH/qYLcXAvrhv8=;
	b=mxPU0tvT2XX5SdIbAvePLJrQodT/MBoZgIIgiIPMUr5JXzHUFHuF6VaKouM+Oltv0cDX6rL2f8xuRPpWnJn53cnQIMqQlrrQNSQ3u65iEnqLVD6CjnLE0Y6kBj+8bd/VMXAZjE1lxR6bKyqXROHu42CyA8qKZunSJGqmfyK02A0=
Received: from 30.74.144.152(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WLO9-tL_1734071744 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 13 Dec 2024 14:35:45 +0800
Message-ID: <cdd7a630-2f16-4be2-bf03-65664bb23692@linux.alibaba.com>
Date: Fri, 13 Dec 2024 14:35:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: shmem: skip swapcache for swapin of synchronous swap
 device
To: akpm@linux-foundation.org, hughd@google.com
Cc: willy@infradead.org, david@redhat.com, wangkefeng.wang@huawei.com,
 kasong@tencent.com, ying.huang@linux.alibaba.com, 21cnbao@gmail.com,
 ryan.roberts@arm.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <8c40d045dc1ea46cc0983c0188b566615d9eb490.1733897892.git.baolin.wang@linux.alibaba.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <8c40d045dc1ea46cc0983c0188b566615d9eb490.1733897892.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/12/11 14:26, Baolin Wang wrote:
> With fast swap devices (such as zram), swapin latency is crucial to applications.
> For shmem swapin, similar to anonymous memory swapin, we can skip the swapcache
> operation to improve swapin latency. Testing 1G shmem sequential swapin without
> THP enabled, I observed approximately a 6% performance improvement:
> (Note: I repeated 5 times and took the mean data for each test)
> 
> w/o patch	w/ patch	changes
> 534.8ms		501ms		+6.3%
> 
> In addition, currently, we always split the large swap entry stored in the
> shmem mapping during shmem large folio swapin, which is not perfect, especially
> with a fast swap device. We can swap in the whole large folio instead of
> splitting the precious large folios to take advantage of the large folios
> and improve the swapin latency if the swap device is synchronous device,
> which is also similar to anonymous memory mTHP swapin. Testing 1G shmem
> sequential swapin with 64K mTHP and 2M mTHP, I observed obvious performance
> improvement:
> 
> mTHP=64K
> w/o patch	w/ patch	changes
> 550.4ms		169.6ms		+69%
> 
> mTHP=2M
> w/o patch	w/ patch	changes
> 542.8ms		126.8ms		+77%
> 
> Note that skipping swapcache requires attention to concurrent swapin scenarios.
> Fortunately the swapcache_prepare() and shmem_add_to_page_cache() can help
> identify concurrent swapin and large swap entry split scenarios, and return
> -EEXIST for retry.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>   mm/shmem.c | 102 +++++++++++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 100 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 41d7a181ed89..a110f973dec0 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1966,6 +1966,66 @@ static struct folio *shmem_alloc_and_add_folio(struct vm_fault *vmf,
>   	return ERR_PTR(error);
>   }
>   
> +static struct folio *shmem_swap_alloc_folio(struct inode *inode, struct vm_area_struct *vma,
> +					    pgoff_t index, swp_entry_t entry, int order, gfp_t gfp)
> +{
> +	struct shmem_inode_info *info = SHMEM_I(inode);
> +	struct folio *new;
> +	void *shadow;
> +	int nr_pages;
> +
> +	/*
> +	 * We have arrived here because our zones are constrained, so don't
> +	 * limit chance of success by further cpuset and node constraints.
> +	 */
> +	gfp &= ~GFP_CONSTRAINT_MASK;
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +	if (order > 0) {
> +		gfp_t huge_gfp = vma_thp_gfp_mask(vma);
> +
> +		gfp = limit_gfp_mask(huge_gfp, gfp);
> +	}
> +#endif
> +
> +	new = shmem_alloc_folio(gfp, order, info, index);
> +	if (!new)
> +		return ERR_PTR(-ENOMEM);
> +
> +	nr_pages = folio_nr_pages(new);
> +	if (mem_cgroup_swapin_charge_folio(new, vma ? vma->vm_mm : NULL,
> +					   gfp, entry)) {
> +		folio_put(new);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	/*
> +	 * Prevent parallel swapin from proceeding with the swap cache flag.
> +	 *
> +	 * Of course there is another possible concurrent scenario as well,
> +	 * that is to say, the swap cache flag of a large folio has already
> +	 * been set by swapcache_prepare(), while another thread may have
> +	 * already split the large swap entry stored in the shmem mapping.
> +	 * In this case, shmem_add_to_page_cache() will help identify the
> +	 * concurrent swapin and return -EEXIST.
> +	 */
> +	if (swapcache_prepare(entry, nr_pages)) {
> +		folio_put(new);
> +		return ERR_PTR(-EEXIST);
> +	}
> +
> +	__folio_set_locked(new);
> +	__folio_set_swapbacked(new);
> +	new->swap = entry;
> +
> +	mem_cgroup_swapin_uncharge_swap(entry, nr_pages);
> +	shadow = get_shadow_from_swap_cache(entry);
> +	if (shadow)
> +		workingset_refault(new, shadow);
> +	folio_add_lru(new);
> +	swap_read_folio(new, NULL);
> +	return new;
> +}
> +
>   /*
>    * When a page is moved from swapcache to shmem filecache (either by the
>    * usual swapin of shmem_get_folio_gfp(), or by the less common swapoff of
> @@ -2189,6 +2249,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
>   	struct shmem_inode_info *info = SHMEM_I(inode);
>   	struct swap_info_struct *si;
>   	struct folio *folio = NULL;
> +	bool skip_swapcache = false;
>   	swp_entry_t swap;
>   	int error, nr_pages;
>   
> @@ -2210,6 +2271,8 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
>   	/* Look it up and read it in.. */
>   	folio = swap_cache_get_folio(swap, NULL, 0);
>   	if (!folio) {
> +		int order = xa_get_order(&mapping->i_pages, index);
> +		bool fallback_order0 = false;
>   		int split_order;
>   
>   		/* Or update major stats only when swapin succeeds?? */
> @@ -2219,6 +2282,33 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
>   			count_memcg_event_mm(fault_mm, PGMAJFAULT);
>   		}
>   
> +		/*
> +		 * If uffd is active for the vma, we need per-page fault
> +		 * fidelity to maintain the uffd semantics, then fallback
> +		 * to swapin order-0 folio, as well as for zswap case.
> +		 */
> +		if (order > 0 && ((vma && unlikely(userfaultfd_armed(vma))) ||
> +				  !zswap_never_enabled()))
> +			fallback_order0 = true;
> +
> +		/* Skip swapcache for synchronous device. */
> +		if (!fallback_order0 && data_race(si->flags & SWP_SYNCHRONOUS_IO)) {
> +			folio = shmem_swap_alloc_folio(inode, vma, index, swap, order, gfp);
> +			if (!IS_ERR(folio)) {
> +				skip_swapcache = true;
> +				goto alloced;
> +			}
> +
> +			/*
> +			 * Fallback to swapin order-0 folio unless the swap entry
> +			 * already exists.
> +			 */
> +			error = PTR_ERR(folio);
> +			folio = NULL;
> +			if (error == -EEXIST)
> +				goto failed;
> +		}
> +
>   		/*
>   		 * Now swap device can only swap in order 0 folio, then we
>   		 * should split the large swap entry stored in the pagecache
> @@ -2249,9 +2339,10 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
>   		}
>   	}
>   
> +alloced:
>   	/* We have to do this with folio locked to prevent races */
>   	folio_lock(folio);
> -	if (!folio_test_swapcache(folio) ||
> +	if ((!skip_swapcache && !folio_test_swapcache(folio)) ||
>   	    folio->swap.val != swap.val ||
>   	    !shmem_confirm_swap(mapping, index, swap)) {
>   		error = -EEXIST;
> @@ -2287,7 +2378,12 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
>   	if (sgp == SGP_WRITE)
>   		folio_mark_accessed(folio);
>   
> -	delete_from_swap_cache(folio);
> +	if (skip_swapcache) {
> +		folio->swap.val = 0;
> +		swapcache_clear(si, swap, nr_pages);
> +	} else {
> +		delete_from_swap_cache(folio);
> +	}
>   	folio_mark_dirty(folio);
>   	swap_free_nr(swap, nr_pages);
>   	put_swap_device(si);
> @@ -2300,6 +2396,8 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
>   	if (error == -EIO)
>   		shmem_set_folio_swapin_error(inode, index, folio, swap);

Oops, I missed handling the uncommon swapin_error case when skipping the 
swapcache. Will fix in V2.

>   unlock:
> +	if (skip_swapcache)
> +		swapcache_clear(si, swap, folio_nr_pages(folio));
>   	if (folio) {
>   		folio_unlock(folio);
>   		folio_put(folio);

