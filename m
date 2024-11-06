Return-Path: <linux-kernel+bounces-397548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2AF9BDD4F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 03:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CA6B1F22B02
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 02:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69D218FC9F;
	Wed,  6 Nov 2024 02:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SYR4/KZl"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147B3187848
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 02:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730861570; cv=none; b=H5w2B2vpTIzHF77qvDrdEL4dykgT9pjlXbNBabf1DN+MD3AMeO6errZ+du9qTQgEdk9+b8/DLRzOV8iUnYRJnnCk1K1qKsk1ajsZeuAVgfdxAMxM9KllJ3JGB3MQbAJFr5e9JJSglSdmygxM26hg4ixHN1Q+o6ostdkGlk2LaG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730861570; c=relaxed/simple;
	bh=uCsZwpC7dmdc5UEVx5YxcX1liFeE3sIKtFwudsKQW/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sw8EMzExn/Qio8BvPXbtRIpGNvX7GE4d/PscAmBL8a//DYVjtDDaYc8DiWglND3YU+Wc1IHmSHiGU33N6yPFBGkqOQLWRsdOXyalM46a/zwrCjIJlGTeH7Wnd+WGwV/y3+MnjwyOikKM8yOjchRKxpc8yxTntHlFVH2jl6jwYME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SYR4/KZl; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <067039c2-5656-40b5-ab6e-a2325e3a9f4e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730861565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cV6dJd0Z+fIOMfEtL/0r1shAJgGhenmAKhtEa57be4M=;
	b=SYR4/KZl6gWuWteE8cAhyqv6HsCgyVyi3J3r7yHvpMpHr3cxllwbDEPnQPsyOrqApfsCx+
	X+iaQPBMwg90YM+t6A9J6HgspPJWRQvedfNtn2Tvvqg4kw1F/PytCKmYztrR/8qqsQYT+/
	NZShQBOxYg5pqsZn6P89vV+uOVjegDY=
Date: Wed, 6 Nov 2024 10:52:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3] mm: count zeromap read and set for swapout and swapin
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>,
 Nhat Pham <nphamcs@gmail.com>, Usama Arif <usamaarif642@gmail.com>,
 Yosry Ahmed <yosryahmed@google.com>, Hailong Liu <hailong.liu@oppo.com>,
 Johannes Weiner <hannes@cmpxchg.org>, David Hildenbrand <david@redhat.com>,
 Hugh Dickins <hughd@google.com>, Matthew Wilcox <willy@infradead.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, Andi Kleen <ak@linux.intel.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Chris Li <chrisl@kernel.org>,
 "Huang, Ying" <ying.huang@intel.com>, Kairui Song <kasong@tencent.com>,
 Ryan Roberts <ryan.roberts@arm.com>
References: <20241105211934.5083-1-21cnbao@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20241105211934.5083-1-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2024/11/6 05:19, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> When the proportion of folios from the zeromap is small, missing their
> accounting may not significantly impact profiling. However, it’s easy
> to construct a scenario where this becomes an issue—for example,
> allocating 1 GB of memory, writing zeros from userspace, followed by
> MADV_PAGEOUT, and then swapping it back in. In this case, the swap-out
> and swap-in counts seem to vanish into a black hole, potentially
> causing semantic ambiguity.
> 
> On the other hand, Usama reported that zero-filled pages can exceed 10% in
> workloads utilizing zswap, while Hailong noted that some app in Android
> have more than 6% zero-filled pages. Before commit 0ca0c24e3211 ("mm: store
> zero pages to be swapped out in a bitmap"), both zswap and zRAM implemented
> similar optimizations, leading to these optimized-out pages being counted
> in either zswap or zRAM counters (with pswpin/pswpout also increasing for
> zRAM). With zeromap functioning prior to both zswap and zRAM, userspace
> will no longer detect these swap-out and swap-in actions.
> 
> We have three ways to address this:
> 
> 1. Introduce a dedicated counter specifically for the zeromap.
> 2. Use pswpin/pswpout accounting, treating the zero map as a standard
> backend. This approach aligns with zRAM's current handling of
> same-page fills at the device level. However, it would mean losing
> the optimized-out page counters previously available in zRAM and
> would not align with systems using zswap. Additionally, as noted by
> Nhat Pham, pswpin/pswpout counters apply only to I/O done directly
> to the backend device.
> 3. Count zeromap pages under zswap, aligning with system behavior when
> zswap is enabled. However, this would not be consistent with zRAM,
> nor would it align with systems lacking both zswap and zRAM.
> 
> Given the complications with options 2 and 3, this patch selects
> option 1.
> 
> We can find these counters from /proc/vmstat (counters for the whole
> system) and memcg's memory.stat (counters for the interested memcg).
> 
> For example:
> 
> $ grep -E 'swpin_zero|swpout_zero' /proc/vmstat
> swpin_zero 1648
> swpout_zero 33536
> 
> $ grep -E 'swpin_zero|swpout_zero' /sys/fs/cgroup/system.slice/memory.stat
> swpin_zero 3905
> swpout_zero 3985
> 
> This patch does not address any specific zeromap bug, but the missing
> swpout and swpin counts for zero-filled pages can be highly confusing
> and may mislead user-space agents that rely on changes in these counters
> as indicators. Therefore, we add a Fixes tag to encourage the inclusion
> of this counter in any kernel versions with zeromap.
> 
> Fixes: 0ca0c24e3211 ("mm: store zero pages to be swapped out in a bitmap")
> Reviewed-by: Nhat Pham <nphamcs@gmail.com>
> Cc: Usama Arif <usamaarif642@gmail.com>
> Cc: Chengming Zhou <chengming.zhou@linux.dev>
> Cc: Yosry Ahmed <yosryahmed@google.com>
> Cc: Hailong Liu <hailong.liu@oppo.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Shakeel Butt <shakeel.butt@linux.dev>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Chris Li <chrisl@kernel.org>
> Cc: "Huang, Ying" <ying.huang@intel.com>
> Cc: Kairui Song <kasong@tencent.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>

Looks good to me!

Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>

Thanks.

> ---
>   -v3:
>   * collected Nhat's reviewed-by, thanks!
>   * refine doc per Usama and David, thanks!
>   * refine changelog
> 
>   Documentation/admin-guide/cgroup-v2.rst |  9 +++++++++
>   include/linux/vm_event_item.h           |  2 ++
>   mm/memcontrol.c                         |  4 ++++
>   mm/page_io.c                            | 16 ++++++++++++++++
>   mm/vmstat.c                             |  2 ++
>   5 files changed, 33 insertions(+)
> 
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index db3799f1483e..13736a94edfd 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1599,6 +1599,15 @@ The following nested keys are defined.
>   	  pglazyfreed (npn)
>   		Amount of reclaimed lazyfree pages
>   
> +	  swpin_zero
> +		Number of pages swapped into memory and filled with zero, where I/O
> +		was optimized out because the page content was detected to be zero
> +		during swapout.
> +
> +	  swpout_zero
> +		Number of zero-filled pages swapped out with I/O skipped due to the
> +		content being detected as zero.
> +
>   	  zswpin
>   		Number of pages moved in to memory from zswap.
>   
> diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
> index aed952d04132..f70d0958095c 100644
> --- a/include/linux/vm_event_item.h
> +++ b/include/linux/vm_event_item.h
> @@ -134,6 +134,8 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
>   #ifdef CONFIG_SWAP
>   		SWAP_RA,
>   		SWAP_RA_HIT,
> +		SWPIN_ZERO,
> +		SWPOUT_ZERO,
>   #ifdef CONFIG_KSM
>   		KSM_SWPIN_COPY,
>   #endif
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 5e44d6e7591e..7b3503d12aaf 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -441,6 +441,10 @@ static const unsigned int memcg_vm_event_stat[] = {
>   	PGDEACTIVATE,
>   	PGLAZYFREE,
>   	PGLAZYFREED,
> +#ifdef CONFIG_SWAP
> +	SWPIN_ZERO,
> +	SWPOUT_ZERO,
> +#endif
>   #ifdef CONFIG_ZSWAP
>   	ZSWPIN,
>   	ZSWPOUT,
> diff --git a/mm/page_io.c b/mm/page_io.c
> index 5d9b6e6cf96c..4b4ea8e49cf6 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -204,7 +204,9 @@ static bool is_folio_zero_filled(struct folio *folio)
>   
>   static void swap_zeromap_folio_set(struct folio *folio)
>   {
> +	struct obj_cgroup *objcg = get_obj_cgroup_from_folio(folio);
>   	struct swap_info_struct *sis = swp_swap_info(folio->swap);
> +	int nr_pages = folio_nr_pages(folio);
>   	swp_entry_t entry;
>   	unsigned int i;
>   
> @@ -212,6 +214,12 @@ static void swap_zeromap_folio_set(struct folio *folio)
>   		entry = page_swap_entry(folio_page(folio, i));
>   		set_bit(swp_offset(entry), sis->zeromap);
>   	}
> +
> +	count_vm_events(SWPOUT_ZERO, nr_pages);
> +	if (objcg) {
> +		count_objcg_events(objcg, SWPOUT_ZERO, nr_pages);
> +		obj_cgroup_put(objcg);
> +	}
>   }
>   
>   static void swap_zeromap_folio_clear(struct folio *folio)
> @@ -507,6 +515,7 @@ static void sio_read_complete(struct kiocb *iocb, long ret)
>   static bool swap_read_folio_zeromap(struct folio *folio)
>   {
>   	int nr_pages = folio_nr_pages(folio);
> +	struct obj_cgroup *objcg;
>   	bool is_zeromap;
>   
>   	/*
> @@ -521,6 +530,13 @@ static bool swap_read_folio_zeromap(struct folio *folio)
>   	if (!is_zeromap)
>   		return false;
>   
> +	objcg = get_obj_cgroup_from_folio(folio);
> +	count_vm_events(SWPIN_ZERO, nr_pages);
> +	if (objcg) {
> +		count_objcg_events(objcg, SWPIN_ZERO, nr_pages);
> +		obj_cgroup_put(objcg);
> +	}
> +
>   	folio_zero_range(folio, 0, folio_size(folio));
>   	folio_mark_uptodate(folio);
>   	return true;
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 22a294556b58..c8ef7352f9ed 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1418,6 +1418,8 @@ const char * const vmstat_text[] = {
>   #ifdef CONFIG_SWAP
>   	"swap_ra",
>   	"swap_ra_hit",
> +	"swpin_zero",
> +	"swpout_zero",
>   #ifdef CONFIG_KSM
>   	"ksm_swpin_copy",
>   #endif

