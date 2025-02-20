Return-Path: <linux-kernel+bounces-523451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA3EA3D709
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF2D53A960B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16861F1302;
	Thu, 20 Feb 2025 10:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AfWIpzOr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FDF1CAA9C
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 10:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740048123; cv=none; b=CaJ2leqkGY4cuGRuQOcN6lLiq/CwSiUXoZ0CbLYJHeM/AWNrftokU2jh0JEPLw5HS62BWzLilTcFubr0xvI2eX4hNLPsv6vpGqF8+JSwzTHVJP4vd5s+c3rf2OWbVI8C3hq1VLVzNin/E2+s48RgiE3oz/usrZenR/qTHUKpSnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740048123; c=relaxed/simple;
	bh=QIh2IXQD2LEe4cEnbvUY6tPd5ieIy9Vn4hFzuKs9E4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8B7iXaNyZHwDp9U6XiBJzyHYWCfUZ5SveuKlrjC77HTIayFCwZErhDATj2ugtX+r+C3RDOIloIOUJH0KvaLLT9MQ4Vc7i5K2s+XQebW0NmzQOe8qT/09AAGmtWQcCJ7HoUHJDRWSuCv6VBnHe592kbEKl44p4UxSVfURex3i7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AfWIpzOr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740048120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zJLrvrZATxQwSHFwQqhKMeyeyoM6uX/LJNrP1uXVaNA=;
	b=AfWIpzOrxWjzsDyKcHs2ltKRn1ffUhiX4Zn4ksP0AFAG66RnVIn+2kxTkWMGDIYnHbF7/B
	ZTb/Ho4b9vjxDDKJHvr89nY1R1NNB9wKuSAmD6LTSlbMrA52ak0YbqFlRe0e1Io5pHfPUg
	D1enhYpssBoofPiPRuatrGEtd2I6pN4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-HHkdyKk-M7OVs5y2-Wr8jw-1; Thu,
 20 Feb 2025 05:41:56 -0500
X-MC-Unique: HHkdyKk-M7OVs5y2-Wr8jw-1
X-Mimecast-MFC-AGG-ID: HHkdyKk-M7OVs5y2-Wr8jw_1740048114
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E6C2718EB2C3;
	Thu, 20 Feb 2025 10:41:53 +0000 (UTC)
Received: from localhost (unknown [10.72.112.127])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3353A300019F;
	Thu, 20 Feb 2025 10:41:51 +0000 (UTC)
Date: Thu, 20 Feb 2025 18:41:47 +0800
From: Baoquan He <bhe@redhat.com>
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Barry Song <v-songbaohua@oppo.com>,
	Hugh Dickins <hughd@google.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>,
	Kalesh Singh <kaleshsingh@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] mm, swap: simplify folio swap allocation
Message-ID: <Z7cG636IwnSnC65d@MiWiFi-R3L-srv>
References: <20250214175709.76029-1-ryncsn@gmail.com>
 <20250214175709.76029-8-ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214175709.76029-8-ryncsn@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 02/15/25 at 01:57am, Kairui Song wrote:
......snip..  
> -swp_entry_t folio_alloc_swap(struct folio *folio)
> +/* Rotate the device and switch to a new cluster */
> +static bool swap_alloc_rotate(swp_entry_t *entry,
> +			      unsigned char usage,
> +			      int order)

The function name is misleading which may make people thing it's a HDD
swap allocation. I would call it swap_alloc_slow() relative to the
swap_alloc_fast().

>  {
> -	unsigned int order = folio_order(folio);
> -	unsigned int size = 1 << order;
> -	struct swap_info_struct *si, *next;
> -	swp_entry_t entry = {};
> -	unsigned long offset;
>  	int node;
> +	unsigned long offset;
> +	struct swap_info_struct *si, *next;
>  
> -	if (order) {
> -		/*
> -		 * Should not even be attempting large allocations when huge
> -		 * page swap is disabled. Warn and fail the allocation.
> -		 */
> -		if (!IS_ENABLED(CONFIG_THP_SWAP) || size > SWAPFILE_CLUSTER) {
> -			VM_WARN_ON_ONCE(1);
> -			return entry;
> -		}
> -	}
> -
> -	/* Fast path using percpu cluster */
> -	local_lock(&percpu_swap_cluster.lock);
> -	if (swap_alloc_fast(&entry, SWAP_HAS_CACHE, order))
> -		goto out_alloced;
> -
> -	/* Rotate the device and switch to a new cluster */
> +	node = numa_node_id();
>  	spin_lock(&swap_avail_lock);
>  start_over:
> -	node = numa_node_id();
>  	plist_for_each_entry_safe(si, next, &swap_avail_heads[node], avail_lists[node]) {
> +		/* Rotate the device and switch to a new cluster */
>  		plist_requeue(&si->avail_lists[node], &swap_avail_heads[node]);
>  		spin_unlock(&swap_avail_lock);
>  		if (get_swap_device_info(si)) {
>  			offset = cluster_alloc_swap_entry(si, order, SWAP_HAS_CACHE);
>  			put_swap_device(si);
>  			if (offset) {
> -				entry = swp_entry(si->type, offset);
> -				goto out_alloced;
> +				*entry = swp_entry(si->type, offset);
> +				return true;
>  			}
>  			if (order)
> -				goto out_failed;
> +				return false;
>  		}
>  
>  		spin_lock(&swap_avail_lock);


