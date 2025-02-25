Return-Path: <linux-kernel+bounces-530481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A826BA43407
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 05:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C46457A26CC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 04:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCAA2561D;
	Tue, 25 Feb 2025 04:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aLkonRPn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A2F2F2F
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 04:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740456110; cv=none; b=JSDEKwWxffiK9vut8oHMGU5qo25XH8ZRDpKgTvUffJGRWAgbgKGCp0On9F6cF/m5Ne7IW49+SEFzhL/W1WGtwlbFuFTz9eD/cD82nHtUU8HRYpEKPp5w76TMBhKJH1r2GMbxAJ6j7lkPgX83a0c1HizCyBJectVZt/ybOgR+pwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740456110; c=relaxed/simple;
	bh=8Q87iuuqf44O0rogPMTmxYNR2omPm2vPhzzbwQw1sRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KxPsUds66PUNoOR1PbbM5+iKamyyUFO24IBlfNjKvU0HpcYDmuHG0NXEmWpOIOwHCspA1tD+KufZGzg8vaTGy7ycrO2PTrX5H1LHg5ZdIaFKpOJCcHn6fP+Ms16Hm2eRpVTsiUycj6u8hEZe+IwRZnOuAvEZycsK/hShiWcwyzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aLkonRPn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740456106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aJCEL/JcHod2gpRQmwl4T/ssU5PjyZ46YyekLHWBr0Y=;
	b=aLkonRPnaSPs5DtDLMoV8ZF2M8DuoW+1X/abdF4lWNcY5r/5lkE9FhYYuw7cHpxt7P+qKH
	KZ7knqvsAF8m0dPwdNcuXwxuXTBRtrKtJkEHqf880eUG4Bckv3Q/0S1HxOYZ5M8MmUhLs2
	yHFT3GIrQQaRCbjFSf48JuuwDXLxS1E=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-YMRLKxqsPpab-5VKbCcA0Q-1; Mon,
 24 Feb 2025 23:01:43 -0500
X-MC-Unique: YMRLKxqsPpab-5VKbCcA0Q-1
X-Mimecast-MFC-AGG-ID: YMRLKxqsPpab-5VKbCcA0Q_1740456101
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 608F5180034A;
	Tue, 25 Feb 2025 04:01:40 +0000 (UTC)
Received: from localhost (unknown [10.72.112.127])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DCAFB180035E;
	Tue, 25 Feb 2025 04:01:37 +0000 (UTC)
Date: Tue, 25 Feb 2025 12:01:32 +0800
From: Baoquan He <bhe@redhat.com>
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Barry Song <v-songbaohua@oppo.com>,
	Hugh Dickins <hughd@google.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/7] mm, swap: use percpu cluster as allocation fast
 path
Message-ID: <Z71AnDX+LQuXhY1Y@MiWiFi-R3L-srv>
References: <20250224180212.22802-1-ryncsn@gmail.com>
 <20250224180212.22802-6-ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224180212.22802-6-ryncsn@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 02/25/25 at 02:02am, Kairui Song wrote:
......snip...
> @@ -1204,19 +1252,36 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_order)
>  	int n_ret = 0;
>  	int node;
>  
> +	/* Fast path using percpu cluster */
> +	local_lock(&percpu_swap_cluster.lock);
> +	n_ret = swap_alloc_fast(swp_entries,
> +				SWAP_HAS_CACHE,
> +				order, n_goal);

Since we always pass in the SWAP_HAS_CACHE for the 2nd parameter, we can
hard code it inside fucntion swap_alloc_fast(), unless there will be
other callsite where different value is passed in for 'usage'. And the
function 2nd parameter of swap_alloc_slow() too. Anyway, it's not a big
deal, could be my personal peference.

Other than this nit, this looks good to me.

> +	if (n_ret == n_goal)
> +		goto out;
> +
> +	n_goal = min_t(int, n_goal - n_ret, SWAP_BATCH);
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
> +			/*
> +			 * For order 0 allocation, try best to fill the request
> +			 * as it's used by slot cache.
> +			 *
> +			 * For mTHP allocation, it always have n_goal == 1,
> +			 * and falling a mTHP swapin will just make the caller
> +			 * fallback to order 0 allocation, so just bail out.
> +			 */
> +			n_ret += scan_swap_map_slots(si, SWAP_HAS_CACHE, n_goal,
> +					swp_entries + n_ret, order);
>  			put_swap_device(si);
>  			if (n_ret || size > 1)
> -				goto check_out;
> +				goto out;
>  		}
>  
>  		spin_lock(&swap_avail_lock);
> @@ -1234,12 +1299,10 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_order)
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
> @@ -2725,8 +2788,6 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
>  	arch_swap_invalidate_area(p->type);
>  	zswap_swapoff(p->type);
>  	mutex_unlock(&swapon_mutex);
> -	free_percpu(p->percpu_cluster);
> -	p->percpu_cluster = NULL;
>  	kfree(p->global_cluster);
>  	p->global_cluster = NULL;
>  	vfree(swap_map);
> @@ -3125,7 +3186,7 @@ static struct swap_cluster_info *setup_clusters(struct swap_info_struct *si,
>  	unsigned long nr_clusters = DIV_ROUND_UP(maxpages, SWAPFILE_CLUSTER);
>  	struct swap_cluster_info *cluster_info;
>  	unsigned long i, j, idx;
> -	int cpu, err = -ENOMEM;
> +	int err = -ENOMEM;
>  
>  	cluster_info = kvcalloc(nr_clusters, sizeof(*cluster_info), GFP_KERNEL);
>  	if (!cluster_info)
> @@ -3134,20 +3195,7 @@ static struct swap_cluster_info *setup_clusters(struct swap_info_struct *si,
>  	for (i = 0; i < nr_clusters; i++)
>  		spin_lock_init(&cluster_info[i].lock);
>  
> -	if (si->flags & SWP_SOLIDSTATE) {
> -		si->percpu_cluster = alloc_percpu(struct percpu_cluster);
> -		if (!si->percpu_cluster)
> -			goto err_free;
> -
> -		for_each_possible_cpu(cpu) {
> -			struct percpu_cluster *cluster;
> -
> -			cluster = per_cpu_ptr(si->percpu_cluster, cpu);
> -			for (i = 0; i < SWAP_NR_ORDERS; i++)
> -				cluster->next[i] = SWAP_ENTRY_INVALID;
> -			local_lock_init(&cluster->lock);
> -		}
> -	} else {
> +	if (!(si->flags & SWP_SOLIDSTATE)) {
>  		si->global_cluster = kmalloc(sizeof(*si->global_cluster),
>  				     GFP_KERNEL);
>  		if (!si->global_cluster)
> @@ -3424,8 +3472,6 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
>  bad_swap_unlock_inode:
>  	inode_unlock(inode);
>  bad_swap:
> -	free_percpu(si->percpu_cluster);
> -	si->percpu_cluster = NULL;
>  	kfree(si->global_cluster);
>  	si->global_cluster = NULL;
>  	inode = NULL;
> -- 
> 2.48.1
> 


