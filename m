Return-Path: <linux-kernel+bounces-521025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C481FA3B2D7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 08:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 917F43AD439
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 07:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C681C3F04;
	Wed, 19 Feb 2025 07:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RwfHN8sn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2E81BD9CD
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 07:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739951644; cv=none; b=niC8nMxNYAPi0K9qFypCGsSmbxitiMjUZvL1+Yn86ugMdFbBNHgyMMVrsh8mPzJ9EsghB7pCCxye6ub35R63YBlMLmTFu5VFqThhmIrHH6wW/ucPfqjzPQXid1mKECuXL4/OS+r9NtQFhdVI/kVbCjV7gYTcSIkAXOUEqafx0Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739951644; c=relaxed/simple;
	bh=j8Yp7X5WW0mWWmcOczTYAl4+eQ/L6jnws2W4QYdTmIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tAQ1Km1yX8rDp7dzk2eM2yLgI0Lq+PvOWwDHz58D8+RYOVqnBGl6MUx0QyGJZO+ZGBsooBNGf88QnSPHyz7ymhAmOswv+g96R3cgxopATLGivuVEaR+qiXvOD5C+raG0KK6ln49e173Sk1FcvBeVZLccNhIdS9xO2BoGm26qj2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RwfHN8sn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739951641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2ehLyl7Fs/LrWVTjQBcmkAJn6qcYboCHZr47QQOhS8U=;
	b=RwfHN8snn+5RfggJj3Y/TnAk/OgGdBW5j5fGTU83IaOYceZFNPmR1iPOWQnZpuFOrERm0t
	RML4QSmidNw6J2w8NmDe61qguOwuHOXszIF/WbIBMkFWTR1MDBSP6LLYEHqNdtkCqdmsn1
	DbVzlbKPxNf2CnHM6kMJwU+e3wSvYoU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-511-ZFcCn7E3OlWf0teHfGmaeA-1; Wed,
 19 Feb 2025 02:53:56 -0500
X-MC-Unique: ZFcCn7E3OlWf0teHfGmaeA-1
X-Mimecast-MFC-AGG-ID: ZFcCn7E3OlWf0teHfGmaeA_1739951634
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E4D9B18EB2C3;
	Wed, 19 Feb 2025 07:53:53 +0000 (UTC)
Received: from localhost (unknown [10.72.112.127])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 28CC51955BCB;
	Wed, 19 Feb 2025 07:53:51 +0000 (UTC)
Date: Wed, 19 Feb 2025 15:53:46 +0800
From: Baoquan He <bhe@redhat.com>
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Barry Song <v-songbaohua@oppo.com>,
	Hugh Dickins <hughd@google.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>,
	Kalesh Singh <kaleshsingh@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] mm, swap: use percpu cluster as allocation fast path
Message-ID: <Z7WOCvQq3xi9wxnt@MiWiFi-R3L-srv>
References: <20250214175709.76029-1-ryncsn@gmail.com>
 <20250214175709.76029-6-ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214175709.76029-6-ryncsn@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 02/15/25 at 01:57am, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> Current allocation workflow first traverses the plist with a global lock
> held, after choosing a device, it uses the percpu cluster on that swap
> device. This commit moves the percpu cluster variable out of being tied
> to individual swap devices, making it a global percpu variable, and will
> be used directly for allocation as a fast path.
> 
> The global percpu cluster variable will never point to a HDD device, and
> allocation on HDD devices is still globally serialized.
> 
> This improves the allocator performance and prepares for removal of the
> slot cache in later commits. There shouldn't be much observable behavior
> change, except one thing: this changes how swap device allocation
> rotation works.
> 
> Currently, each allocation will rotate the plist, and because of the
> existence of slot cache (64 entries), swap devices of the same priority
> are rotated for every 64 entries consumed. And, high order allocations
> are different, they will bypass the slot cache, and so swap device is
> rotated for every 16K, 32K, or up to 2M allocation.
> 
> The rotation rule was never clearly defined or documented, it was changed
> several times without mentioning too.
> 
> After this commit, once slot cache is gone in later commits, swap device
> rotation will happen for every consumed cluster. Ideally non-HDD devices
> will be rotated if 2M space has been consumed for each order, this seems

This breaks the rule where the high priority swap device is always taken
to allocate as long as there's free space in the device. After this patch,
it will try the percpu cluster firstly which is lower priority even though
the higher priority device has free space. However, this only happens when
the higher priority device is exhausted, not a generic case. If this is
expected, it may need be mentioned in log or doc somewhere at least.

> reasonable. HDD devices is rotated for every allocation regardless of the
> allocation order, which should be OK and trivial.
> 
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  include/linux/swap.h |  11 ++--
>  mm/swapfile.c        | 120 +++++++++++++++++++++++++++----------------
>  2 files changed, 79 insertions(+), 52 deletions(-)
......
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index ae3bd0a862fc..791cd7ed5bdf 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -116,6 +116,18 @@ static atomic_t proc_poll_event = ATOMIC_INIT(0);
>  
......snip....
>  int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_order)
>  {
>  	int order = swap_entry_order(entry_order);
> @@ -1211,19 +1251,28 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_order)
>  	int n_ret = 0;
>  	int node;
>  
> +	/* Fast path using percpu cluster */
> +	local_lock(&percpu_swap_cluster.lock);
> +	n_ret = swap_alloc_fast(swp_entries,
> +				SWAP_HAS_CACHE,
> +				order, n_goal);
> +	if (n_ret == n_goal)
> +		goto out;
> +
> +	n_goal = min_t(int, n_goal - n_ret, SWAP_BATCH);

Here, the behaviour is changed too. In old allocation, partial
allocation will jump out to return. In this patch, you try the percpu
cluster firstly, then call scan_swap_map_slots() to try best and will
jump out even though partial allocation succeed. But the allocation from
scan_swap_map_slots() could happen on different si device, this looks
bizarre. Do you think we need reconsider the design?

> +	/* Rotate the device and switch to a new cluster */
>  	spin_lock(&swap_avail_lock);
>  start_over:
>  	node = numa_node_id();
>  	plist_for_each_entry_safe(si, next, &swap_avail_heads[node], avail_lists[node]) {
> -		/* requeue si to after same-priority siblings */
>  		plist_requeue(&si->avail_lists[node], &swap_avail_heads[node]);
>  		spin_unlock(&swap_avail_lock);
>  		if (get_swap_device_info(si)) {
> -			n_ret = scan_swap_map_slots(si, SWAP_HAS_CACHE,
> -					n_goal, swp_entries, order);
> +			n_ret += scan_swap_map_slots(si, SWAP_HAS_CACHE, n_goal,
> +					swp_entries + n_ret, order);
>  			put_swap_device(si);
>  			if (n_ret || size > 1)
> -				goto check_out;
> +				goto out;
>  		}
>  
>  		spin_lock(&swap_avail_lock);
> @@ -1241,12 +1290,10 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_order)
>  		if (plist_node_empty(&next->avail_lists[node]))
>  			goto start_over;
>  	}
> -
>  	spin_unlock(&swap_avail_lock);
> -
> -check_out:
> +out:
> +	local_unlock(&percpu_swap_cluster.lock);
>  	atomic_long_sub(n_ret * size, &nr_swap_pages);
> -
>  	return n_ret;
>  }
>  
......snip...


