Return-Path: <linux-kernel+bounces-523144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C612A3D2A5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 08:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60E88177E56
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 07:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558991E9B01;
	Thu, 20 Feb 2025 07:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NVl/BmJi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E891ADC7D
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 07:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740038180; cv=none; b=D/UrODLD/Mxbve+ajqVOZdaN0MrZb+tev6EcRFiwMi60VcpbYoHF/6zgFv/73sb01zNioJeBkK0ibfwQocNEhiZ1708Qpw5p+wvkYP2aR7UIiGu4TO2Xl1lc8KzcgF7dOd4VX+96e2/1X5Kj74QtDEEeYrEQ7e4/hg28FGxhJok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740038180; c=relaxed/simple;
	bh=vGBT/xVYwXruBLvwiTsyM0K2w/4npJ1cJh6y4gdzD8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kkOZrVz9F1Hc2gwEUCTcxXyXfSde/9q8zQlrTG39kiCo9nyzIyGzEMQDo2czI9QuJAJi7kVC3ZjdiE0WXTUoiB0rQsCPg95TOxUJEFPsI/1px2K+FcqVN2i1WAEbKzLKsK68numJskC/vybiSj5K+Eqmo6Ni4+8BtGEUU2XGVdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NVl/BmJi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740038176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q/q+cYyOUSWwYcE6Cpu7Ct2AeqH6ryENKC48JCkFcSg=;
	b=NVl/BmJiYRRafpeo0ndVzQlTZgdPYIizaDjdKagnIZgZgcnCximHLtc8jBwzJJ5gler+Yc
	746n4hjYIE/4M9SzNMOxrvdzWs2kLsVxhjdsDkCLxNXkX1YWN+0SmtLfYZ7W/FbnC6kqLe
	tdClYZUSJjZgS21p3p3Ez5mOmiN+Gr0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-527-6ufifHc2Mc-1S5GcnXcobg-1; Thu,
 20 Feb 2025 02:56:08 -0500
X-MC-Unique: 6ufifHc2Mc-1S5GcnXcobg-1
X-Mimecast-MFC-AGG-ID: 6ufifHc2Mc-1S5GcnXcobg_1740038166
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 535221955F28;
	Thu, 20 Feb 2025 07:56:05 +0000 (UTC)
Received: from localhost (unknown [10.72.112.127])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2CA1519560A3;
	Thu, 20 Feb 2025 07:56:02 +0000 (UTC)
Date: Thu, 20 Feb 2025 15:55:58 +0800
From: Baoquan He <bhe@redhat.com>
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Barry Song <v-songbaohua@oppo.com>,
	Hugh Dickins <hughd@google.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>,
	Kalesh Singh <kaleshsingh@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] mm, swap: remove swap slot cache
Message-ID: <Z7bgDhZmg9Vs+btw@MiWiFi-R3L-srv>
References: <20250214175709.76029-1-ryncsn@gmail.com>
 <20250214175709.76029-7-ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214175709.76029-7-ryncsn@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hi Kairui,

On 02/15/25 at 01:57am, Kairui Song wrote:
......snip....  
> -int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_order)
> +swp_entry_t folio_alloc_swap(struct folio *folio)
>  {
> -	int order = swap_entry_order(entry_order);
> -	unsigned long size = 1 << order;
> +	unsigned int order = folio_order(folio);
> +	unsigned int size = 1 << order;
>  	struct swap_info_struct *si, *next;
> -	int n_ret = 0;
> +	swp_entry_t entry = {};
> +	unsigned long offset;
>  	int node;
>  
> +	if (order) {
> +		/*
> +		 * Should not even be attempting large allocations when huge
> +		 * page swap is disabled. Warn and fail the allocation.
> +		 */
> +		if (!IS_ENABLED(CONFIG_THP_SWAP) || size > SWAPFILE_CLUSTER) {
> +			VM_WARN_ON_ONCE(1);
> +			return entry;
> +		}
> +	}
> +
>  	/* Fast path using percpu cluster */
>  	local_lock(&percpu_swap_cluster.lock);
> -	n_ret = swap_alloc_fast(swp_entries,
> -				SWAP_HAS_CACHE,
> -				order, n_goal);
> -	if (n_ret == n_goal)
> -		goto out;
> +	if (swap_alloc_fast(&entry, SWAP_HAS_CACHE, order))
> +		goto out_alloced;
>  
> -	n_goal = min_t(int, n_goal - n_ret, SWAP_BATCH);
>  	/* Rotate the device and switch to a new cluster */
>  	spin_lock(&swap_avail_lock);
>  start_over:
> @@ -1268,11 +1236,14 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_order)
>  		plist_requeue(&si->avail_lists[node], &swap_avail_heads[node]);
>  		spin_unlock(&swap_avail_lock);
>  		if (get_swap_device_info(si)) {
> -			n_ret += scan_swap_map_slots(si, SWAP_HAS_CACHE, n_goal,
> -					swp_entries + n_ret, order);
> +			offset = cluster_alloc_swap_entry(si, order, SWAP_HAS_CACHE);
>  			put_swap_device(si);
> -			if (n_ret || size > 1)
> -				goto out;
> +			if (offset) {
> +				entry = swp_entry(si->type, offset);
> +				goto out_alloced;
> +			}
> +			if (order)
> +				goto out_failed;

This is not related to this patch, do you know why non order-0 case
can't start over on different devices?

>  		}
>  
>  		spin_lock(&swap_avail_lock);
> @@ -1291,10 +1262,20 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_order)
>  			goto start_over;
>  	}
>  	spin_unlock(&swap_avail_lock);
> -out:
> +out_failed:
> +	local_unlock(&percpu_swap_cluster.lock);
> +	return entry;
> +
> +out_alloced:
>  	local_unlock(&percpu_swap_cluster.lock);
> -	atomic_long_sub(n_ret * size, &nr_swap_pages);
> -	return n_ret;
> +	if (mem_cgroup_try_charge_swap(folio, entry)) {
> +		put_swap_folio(folio, entry);
> +		entry.val = 0;
> +	} else {
> +		atomic_long_sub(size, &nr_swap_pages);
> +	}
> +
> +	return entry;
>  }
>  
>  static struct swap_info_struct *_swap_info_get(swp_entry_t entry)
......snip....
> @@ -2623,16 +2591,6 @@ static bool __has_usable_swap(void)
>  	return !plist_head_empty(&swap_active_head);
>  }

seems the __has_usable_swap() function need be moved into the ifdeffery
scope where __folio_throttle_swaprate() is located to fix the lkp
warning.

>  
> -bool has_usable_swap(void)
> -{
> -	bool ret;
> -
> -	spin_lock(&swap_lock);
> -	ret = __has_usable_swap();
> -	spin_unlock(&swap_lock);
> -	return ret;
> -}
> -
>  /*
>   * Called after clearing SWP_WRITEOK, ensures cluster_alloc_range
>   * see the updated flags, so there will be no more allocations.

Other than the test robot reported warning, this patch looks good to me.
Thanks.


