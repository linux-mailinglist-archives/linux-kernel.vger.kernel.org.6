Return-Path: <linux-kernel+bounces-306088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF549638F3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 05:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FAD81C20DBA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 03:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6C4481B1;
	Thu, 29 Aug 2024 03:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="amM+39++"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CF2132103
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 03:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724903327; cv=none; b=L/dU3zeM1kYoR7uGphKGozSpKs7seZP4R9QLqeNdqJCSbdjiXwI5II7nHv8PpXpDTCD7Kdzg8DGP8d+4ZY1Re3gaAtCy1pdYw7oBBVzG4IiGFDfpreGNV07WmnaYQTCUfbPNhnbGTfgPPT9nqvDsoBG3Cqw+WjYA7mLBJJc+2q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724903327; c=relaxed/simple;
	bh=gQPUqmCWgULDvv2fwuEEDcsWDIiTn120DtFH641zEbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hcXYxQsjqI69jL2KqDibzKWWzRQQrcwAoGnHa11J2sCMr5Gd7oPyC5L7fnXMvxT91upaESMQ8oK0gaIV3ltMaXMVymMqOa1zK2ESmZHSHaPVLafGJzhJGXzxCYC7V2li2jfSg0Zk/JRq9oVecMIwr7x7MY15UzNtb8G/174tj5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=amM+39++; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724903324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=72lhOeFspkLtOGTCbKaEW6OSZn0dDr96N8djAnUA6LU=;
	b=amM+39++hNEMPN2B+y0FIH3RnmAOoAGWFNxwUhhr5/ic2ggWYYS3zwWX+xoTEVJKp/2AmM
	dMfB5tpZuuv1mOHwUoHya9z/FCoGAoN0EmBhoPEO7TJ1GPx5J6HjVA9pK9WvJ9+25tXxPN
	HDrRkELAgOB71p36zfDz9XuzetVdQc0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-348-6aNmUtoDPzWVgpnDZP7fiA-1; Wed,
 28 Aug 2024 23:48:40 -0400
X-MC-Unique: 6aNmUtoDPzWVgpnDZP7fiA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 14B121955D48;
	Thu, 29 Aug 2024 03:48:39 +0000 (UTC)
Received: from localhost (unknown [10.72.112.42])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 80EFA1955F1B;
	Thu, 29 Aug 2024 03:48:37 +0000 (UTC)
Date: Thu, 29 Aug 2024 11:48:32 +0800
From: Baoquan He <bhe@redhat.com>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Michal Hocko <mhocko@suse.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH] mm: vmalloc: Refactor vm_area_alloc_pages() function
Message-ID: <Zs/vkLWrRNRkSvwC@MiWiFi-R3L-srv>
References: <20240827190916.34242-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827190916.34242-1-urezki@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 08/27/24 at 09:09pm, Uladzislau Rezki (Sony) wrote:
> The aim is to simplify and making the vm_area_alloc_pages()
> function less confusing as it became more clogged nowadays:
> 
> - eliminate a "bulk_gfp" variable and do not overwrite a gfp
>   flag for bulk allocator;
> - drop __GFP_NOFAIL flag for high-order-page requests on upper
>   layer. It becomes less spread between levels when it comes to
>   __GFP_NOFAIL allocations;
> - add a comment about a fallback path if high-order attempt is
>   unsuccessful because for such cases __GFP_NOFAIL is dropped;
> - fix a typo in a commit message.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  mm/vmalloc.c | 37 +++++++++++++++++--------------------
>  1 file changed, 17 insertions(+), 20 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 3f9b6bd707d2..57862865e808 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3531,8 +3531,6 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>  		unsigned int order, unsigned int nr_pages, struct page **pages)
>  {
>  	unsigned int nr_allocated = 0;
> -	gfp_t alloc_gfp = gfp;
> -	bool nofail = gfp & __GFP_NOFAIL;
>  	struct page *page;
>  	int i;
>  
> @@ -3543,9 +3541,6 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>  	 * more permissive.
>  	 */
>  	if (!order) {
> -		/* bulk allocator doesn't support nofail req. officially */
> -		gfp_t bulk_gfp = gfp & ~__GFP_NOFAIL;
> -
>  		while (nr_allocated < nr_pages) {
>  			unsigned int nr, nr_pages_request;
>  
> @@ -3563,12 +3558,11 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>  			 * but mempolicy wants to alloc memory by interleaving.
>  			 */
>  			if (IS_ENABLED(CONFIG_NUMA) && nid == NUMA_NO_NODE)
> -				nr = alloc_pages_bulk_array_mempolicy_noprof(bulk_gfp,
> +				nr = alloc_pages_bulk_array_mempolicy_noprof(gfp,
>  							nr_pages_request,
>  							pages + nr_allocated);
> -
>  			else
> -				nr = alloc_pages_bulk_array_node_noprof(bulk_gfp, nid,
> +				nr = alloc_pages_bulk_array_node_noprof(gfp, nid,
>  							nr_pages_request,
>  							pages + nr_allocated);
>  
> @@ -3582,30 +3576,24 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>  			if (nr != nr_pages_request)
>  				break;
>  		}
> -	} else if (gfp & __GFP_NOFAIL) {
> -		/*
> -		 * Higher order nofail allocations are really expensive and
> -		 * potentially dangerous (pre-mature OOM, disruptive reclaim
> -		 * and compaction etc.
> -		 */
> -		alloc_gfp &= ~__GFP_NOFAIL;
>  	}
>  
>  	/* High-order pages or fallback path if "bulk" fails. */
>  	while (nr_allocated < nr_pages) {
> -		if (!nofail && fatal_signal_pending(current))
> +		if (!(gfp & __GFP_NOFAIL) && fatal_signal_pending(current))
>  			break;
>  
>  		if (nid == NUMA_NO_NODE)
> -			page = alloc_pages_noprof(alloc_gfp, order);
> +			page = alloc_pages_noprof(gfp, order);
>  		else
> -			page = alloc_pages_node_noprof(nid, alloc_gfp, order);
> +			page = alloc_pages_node_noprof(nid, gfp, order);
> +
>  		if (unlikely(!page))
>  			break;
>  
>  		/*
>  		 * Higher order allocations must be able to be treated as
> -		 * indepdenent small pages by callers (as they can with
> +		 * independent small pages by callers (as they can with
>  		 * small-page vmallocs). Some drivers do their own refcounting
>  		 * on vmalloc_to_page() pages, some use page->mapping,
>  		 * page->lru, etc.
> @@ -3666,7 +3654,16 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>  	set_vm_area_page_order(area, page_shift - PAGE_SHIFT);
>  	page_order = vm_area_page_order(area);
>  
> -	area->nr_pages = vm_area_alloc_pages(gfp_mask | __GFP_NOWARN,
> +	/*
> +	 * Higher order nofail allocations are really expensive and
           ~~~~~~~~~~~~
Seems we use both higher-order and high-order to describe the
non 0-order pages in many places. I personally would take high-order,
higher-order seems to be a little confusing because it's not explicit
what is compared with and lower.

Surely this is not an issue to this patch, I see a lot of 'higher order'
in kernel codes.

For this patch,

Reviewed-by: Baoquan He <bhe@redhat.com>

> +	 * potentially dangerous (pre-mature OOM, disruptive reclaim
> +	 * and compaction etc.
> +	 *
> +	 * Please note, the __vmalloc_node_range_noprof() falls-back
> +	 * to order-0 pages if high-order attempt is unsuccessful.
> +	 */
> +	area->nr_pages = vm_area_alloc_pages((page_order ?
> +		gfp_mask & ~__GFP_NOFAIL : gfp_mask) | __GFP_NOWARN,
>  		node, page_order, nr_small_pages, area->pages);
>  
>  	atomic_long_add(area->nr_pages, &nr_vmalloc_pages);
> -- 
> 2.39.2
> 


