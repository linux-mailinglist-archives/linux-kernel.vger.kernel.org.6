Return-Path: <linux-kernel+bounces-530594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD265A43591
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 07:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 005123B57E6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 06:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A1B256C9F;
	Tue, 25 Feb 2025 06:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ieHfg/aq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368DE254855
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 06:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740465822; cv=none; b=hQF/5omtkLl/NssTYenhs8NC01kFwv0lkZbAlRDtiTs+WTYhGKRdoPkyGwCm1GQepMHTa/LyprA+h1EYjZ1lXfOYSWbHrMbXd2nNNonRvjcAIZO6/8L/y/TP5A+Z4qJcqxDQXKSiIxqbanVArBSIXSjVEDAc7NvyPDIcgmcQZNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740465822; c=relaxed/simple;
	bh=HeayC6McXnK+QCn3tS6w6f3rfKI2lyW7MYFhv1VLot4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Twhk7d0QanE3pRDm2/55uZqjVpnZR+mTFSk71RUf7vdwwWoTLggzx8IBtAoNwjUMnCjEtjy4s2iE6DJwizSgQJcx3RvjKfSRewW2E8cmhgH3oRXhoQskE68AcwQnFDSllJqv4hNQ19QV+RlK6e4Dyb9fsTQjIL40gZtG9vHExzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ieHfg/aq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740465820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JrGIcEv+jzbLfhxhyPqK901c2WdYTEZ2bh/GwMiJWiI=;
	b=ieHfg/aqqY2dP/c5aOMIdXj63YB08Rj/zawYUM+gxHwxUGGtXNt0eSTSIbivwbsjkHSMv/
	YoqpOJq7naA4aMsJ2I+DruU4F86qZZuPKwTnX7D3USK8HVNASOKN8Z0ujou4Voww9HdeEx
	n2kYwBIqHLDsmJxI+ohSPZqjwqLKZ4Q=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-486-ZxQAVhyFOl6-nef4plbVHA-1; Tue,
 25 Feb 2025 01:43:31 -0500
X-MC-Unique: ZxQAVhyFOl6-nef4plbVHA-1
X-Mimecast-MFC-AGG-ID: ZxQAVhyFOl6-nef4plbVHA_1740465809
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4074B196E078;
	Tue, 25 Feb 2025 06:43:29 +0000 (UTC)
Received: from localhost (unknown [10.72.112.127])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5E02519560A3;
	Tue, 25 Feb 2025 06:43:25 +0000 (UTC)
Date: Tue, 25 Feb 2025 14:43:21 +0800
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
Subject: Re: [PATCH v2 7/7] mm, swap: simplify folio swap allocation
Message-ID: <Z71miSXHnSuW1wHE@MiWiFi-R3L-srv>
References: <20250224180212.22802-1-ryncsn@gmail.com>
 <20250224180212.22802-8-ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224180212.22802-8-ryncsn@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 02/25/25 at 02:02am, Kairui Song wrote:
......snip...
> @@ -1265,20 +1249,68 @@ swp_entry_t folio_alloc_swap(struct folio *folio)
>  			goto start_over;
>  	}
>  	spin_unlock(&swap_avail_lock);
> -out_failed:
> +	return false;
> +}
> +
> +/**
> + * folio_alloc_swap - allocate swap space for a folio
> + * @folio: folio we want to move to swap
> + * @gfp: gfp mask for shadow nodes
> + *
> + * Allocate swap space for the folio and add the folio to the
> + * swap cache.
> + *
> + * Context: Caller needs to hold the folio lock.
> + * Return: Whether the folio was added to the swap cache.

If only returning on whether folio being added or not, it's better to
return bool value for now. Anyway, this is trivial. This whole
patch looks good to me.

Reviewed-by: Baoquan He <bhe@redhat.com>

> + */
> +int folio_alloc_swap(struct folio *folio, gfp_t gfp)
> +{
> +	unsigned int order = folio_order(folio);
> +	unsigned int size = 1 << order;
> +	swp_entry_t entry = {};
> +
> +	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
> +	VM_BUG_ON_FOLIO(!folio_test_uptodate(folio), folio);
> +
> +	/*
> +	 * Should not even be attempting large allocations when huge
> +	 * page swap is disabled. Warn and fail the allocation.
> +	 */
> +	if (order && (!IS_ENABLED(CONFIG_THP_SWAP) || size > SWAPFILE_CLUSTER)) {
> +		VM_WARN_ON_ONCE(1);
> +		return -EINVAL;
> +	}
> +
> +	local_lock(&percpu_swap_cluster.lock);
> +	if (swap_alloc_fast(&entry, SWAP_HAS_CACHE, order))
> +		goto out_alloced;
> +	if (swap_alloc_slow(&entry, SWAP_HAS_CACHE, order))
> +		goto out_alloced;
>  	local_unlock(&percpu_swap_cluster.lock);
> -	return entry;
> +	return -ENOMEM;
>  
>  out_alloced:
>  	local_unlock(&percpu_swap_cluster.lock);
> -	if (mem_cgroup_try_charge_swap(folio, entry)) {
> -		put_swap_folio(folio, entry);
> -		entry.val = 0;
> -	} else {
> -		atomic_long_sub(size, &nr_swap_pages);
> -	}
> +	if (mem_cgroup_try_charge_swap(folio, entry))
> +		goto out_free;
>  
> -	return entry;
> +	/*
> +	 * XArray node allocations from PF_MEMALLOC contexts could
> +	 * completely exhaust the page allocator. __GFP_NOMEMALLOC
> +	 * stops emergency reserves from being allocated.
> +	 *
> +	 * TODO: this could cause a theoretical memory reclaim
> +	 * deadlock in the swap out path.
> +	 */
> +	if (add_to_swap_cache(folio, entry, gfp | __GFP_NOMEMALLOC, NULL))
> +		goto out_free;
> +
> +	atomic_long_sub(size, &nr_swap_pages);
> +	return 0;
> +
> +out_free:
> +	put_swap_folio(folio, entry);
> +	return -ENOMEM;
>  }
>  
>  static struct swap_info_struct *_swap_info_get(swp_entry_t entry)
....snip....


