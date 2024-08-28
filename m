Return-Path: <linux-kernel+bounces-304537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD74962178
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8507D1C235B4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 07:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5EE15920B;
	Wed, 28 Aug 2024 07:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="K8mIT8JP"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DBB15530C
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 07:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724830853; cv=none; b=kmx20S7FiCOe1cWunwkQRvYugZSFLa9xdWyyayTqpLLUcq+CEnfPm/0WJbm/aXMzrCMNz3uzJACtrvvxvtEvC4vSUY1X3GN0L57YLc9SJsxNsPKEF6oYFvnEP4otYX76M3mE9EbEp20UzdmTHzFVl3IYSOOr2so3MspLTbOhzg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724830853; c=relaxed/simple;
	bh=d3zGjmQYUJ/OIGTEmdziRyvUPvGFdd4CTR1HDUtd3eE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKNIhCcI1Gim9oygeNLoMhXIqt6i2nYMEh87mf1uv9k/Gz/SKz0KQ91tEFKBjnPxratedPHHzn2cFXDbDlMS4AbRk7elOG+cVHA27uTVEcOHCGyDotvXGyi3M1zSdrqkIcJu8jMuufyxKoM+v5Vf3ZKXwBOHgHCnigQu/oO1GY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=K8mIT8JP; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a83597ce5beso54873166b.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 00:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724830849; x=1725435649; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8/HO53IZjem6ZqZU/Q133oXW+yDPYhQPPqizV4xDaYc=;
        b=K8mIT8JPucz+hBwyea8GqKYwG7BL+UMUBpZ3LkRuhGTyrp1owtOr/9ujgbL4XDX7YB
         wKmI7COEP4xiNqD6jVYDOBfTQK4EeCBP0n6sT/zUjnKK0CKaYkgvlrjmzBMqVGXqm3e/
         4xQsXXYv8fXzGZW8+Clorq1tIWcSdc/jx57EE0dZBlwEDtEbNBZl4QOxBazD6KygRReY
         sXFAj0+fNOSmiCHtrCTZc/xo2yf0iysgmRQZk49sGlKCAKIeCu5hOypeJnX5QY8XGyDd
         ETCkMLxL3DX3G0I5FzvBURrwGqnMzi9/nSxIWDwK/RNC13YOIym5MRy7UI8Zd9KuSrMe
         JC2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724830849; x=1725435649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8/HO53IZjem6ZqZU/Q133oXW+yDPYhQPPqizV4xDaYc=;
        b=BvcKvJ9UEhtCgONGgqw75mwCyjaKHBQgmvEU8/2uMrIK53lf/xQSt4xntYBjDos9ZW
         jkQ7aGa+6RVOrkDmvuSR31Y6lYCH0OpPTzvx7Byjx2bEDDKYwv3oaBfntR08YuCH5stQ
         1ShfCuyZkUnL7eCawc4w5E8vhqr+Lngi4eUudpQIWjjwF6CfirUm86pqfFl9UDfjMxfu
         30WR7MAJtMiythmnU89IY5xmzy7rPk9Nae1rAmUwSccWaGnHoS3cVA8lYtkB6RNP7rjf
         7+WOWereHIU+SbtUgIc9mfaQpmKTnVOWoVhPnIKyfxqROol7gpiuAUTN25axlLO63o3U
         rwVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxYWnfFrj+CnJItL9TlNbJGFwssQ+RaKc15rj+J3XY/no7hubVxHgwVHJoyX6NwkaHhTuys6jWSRXEcjg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmKfRpr2x/uFOmSDwH5m7RS7RE3dYYULofOULF7zXqx7+GUCPI
	KqsNyClkIJeLjl5HlwZnrvgCG1f3RiojjQx3uzz3wAv69/8fy5fJ+0HtqcAr73U=
X-Google-Smtp-Source: AGHT+IE9N33ZMb4zsUqXVziFRv2ddNM4ps7FAJMZxETN2W+HFqAa5MPv1xddujaLEs5wnqGN8cBZqg==
X-Received: by 2002:a17:906:6a01:b0:a86:b9c4:a439 with SMTP id a640c23a62f3a-a870aade09amr129904666b.21.1724830849421;
        Wed, 28 Aug 2024 00:40:49 -0700 (PDT)
Received: from localhost (109-81-92-122.rct.o2.cz. [109.81.92.122])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e591c015sm203103066b.191.2024.08.28.00.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 00:40:49 -0700 (PDT)
Date: Wed, 28 Aug 2024 09:40:48 +0200
From: Michal Hocko <mhocko@suse.com>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH] mm: vmalloc: Refactor vm_area_alloc_pages() function
Message-ID: <Zs7UgMEM4wW9Hrqy@tiehlicka>
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

On Tue 27-08-24 21:09:16, Uladzislau Rezki wrote:
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

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

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

-- 
Michal Hocko
SUSE Labs

