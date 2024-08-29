Return-Path: <linux-kernel+bounces-306371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEEA5963E1C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D44581C240EE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 08:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9D118A920;
	Thu, 29 Aug 2024 08:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AhHAI6c8"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC981189F31
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 08:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724919143; cv=none; b=sUAKsYSZ20BcnOSxYwlwKtr4tPHMTh5VWXZLlozZyaH3olY9WD47NPPh3Kzfto7qt7m27+p+fdoeF0wUTADp2u2E4DVDS/mPlJyJ/LRoRDGYWZ10ntvvOcmCFHDQZ6r0skKdbXDdF+ngXDgmV4j696MfnbjIYUIcFp7XgCaIra0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724919143; c=relaxed/simple;
	bh=SwcEWDSUdMV5ukDNPOjMI1oD9VsgTl4jG4xNQ+Vg6KY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QFp9Pj8x7HVwo9o7lwEyNCMnaOTq58C3cnzMHG+6A40qxXVL4HhY9EXsL8JZlQUCWZKk9bfcMXqq6yO7tyYe4Oe/dlN4rF2aPQLl8yGKbkhJzUmAhV6Ftk/j7/XNh75pvrKXK+5eA52jL49CifXAJ5ktrHmg5wfO2+9fs24U3DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AhHAI6c8; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5343e75c642so459426e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 01:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724919140; x=1725523940; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gy/6guuz7idIpkVI/MLnSgp3SDDwAbobV8+omG5Ebjs=;
        b=AhHAI6c8ckqoGtPF3Fj/OphkOeb1o2TkwygjhtK2zxUTwbfJpdCDkO161eD/bdmFlo
         UF4KK1PD9AwKNYHfujyVuOwmxjSPECuA3wCDySy+iXDd0w5tf34s52yhriU6peUJxv44
         QL811FN4OHUDyXCAFeOirAsLxHzhP8jwjHATsmTFMmQ0Fnbwb48PgpcCJHmzEAe8Ic+I
         Z88Z+XqIviMdCTNECWJTutYbNuiv/JpE5hryUNmwepGi6aTq5/nwmsZEmavsbVirO6J9
         57taD6Rc1gQl+BIsRiHAYT9exALkgeMLDfQ0LMMOG1/esre3R10Uv73tzBfC+H/37Lnu
         5aHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724919140; x=1725523940;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gy/6guuz7idIpkVI/MLnSgp3SDDwAbobV8+omG5Ebjs=;
        b=w3kom6tzX3kOpag22PtCZ8/H3V4BwDF/uWv+9CmQf0ZB1PPW5ln3ZENvyj7zxTdbrm
         izH7a0/H3GQbYDsPxpxNeFEOxpdQWuuJ3KgilBkDD4zuI9J0t8mv94KlaqxnXiaxwxks
         qnB3G2EH6HOL4WdDb+c6RZCAQdfJk7msjcHc0HmKnYQiMRof0KIRHMmG90/wW/XEpTSn
         hZf7F49Lu4LePovsljrPqfB7d82ZiFj2ml10g3jZW2Z4avgODaw1JUrgizDuifgRTGF/
         T9Fcwi8FyK2sQRIhlOWEm9kHIRhAOOH1rLCArVC8xqDyZQ82mbwiNhGTZtiG3G31R+2J
         WQlg==
X-Forwarded-Encrypted: i=1; AJvYcCVyvmKhNGdE24Q4o5i8BaEuaPvNvQc55qycUsfls3hf2zWxyDbWKlTHE4XNuO8q1CxYucSSaL1g/ltkIdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqJXvhevXyg4BFDg6CKXXJFZkFYj1Bj8dqWf1bfgGA7c+nIJKl
	t1bJili8qPL1Aat4++Iy6E7xg+nyFKbDzfAlWH1UfcmYffYmplBh
X-Google-Smtp-Source: AGHT+IF2g4rxh2v8IQWftNJuiEP0QcG43IxLAxXGGYSGojBTNn/K9uXK81bYx7P448zKtBIyqyNFbA==
X-Received: by 2002:a05:6512:ad3:b0:52e:9b92:4999 with SMTP id 2adb3069b0e04-5353e545f45mr1261010e87.2.1724919138914;
        Thu, 29 Aug 2024 01:12:18 -0700 (PDT)
Received: from pc636 (84-217-131-213.customers.ownit.se. [84.217.131.213])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-535408277a1sm87592e87.129.2024.08.29.01.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 01:12:18 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Thu, 29 Aug 2024 10:12:16 +0200
To: Baoquan He <bhe@redhat.com>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Michal Hocko <mhocko@suse.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH] mm: vmalloc: Refactor vm_area_alloc_pages() function
Message-ID: <ZtAtYAARL2gx8De5@pc636>
References: <20240827190916.34242-1-urezki@gmail.com>
 <Zs/vkLWrRNRkSvwC@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs/vkLWrRNRkSvwC@MiWiFi-R3L-srv>

On Thu, Aug 29, 2024 at 11:48:32AM +0800, Baoquan He wrote:
> On 08/27/24 at 09:09pm, Uladzislau Rezki (Sony) wrote:
> > The aim is to simplify and making the vm_area_alloc_pages()
> > function less confusing as it became more clogged nowadays:
> > 
> > - eliminate a "bulk_gfp" variable and do not overwrite a gfp
> >   flag for bulk allocator;
> > - drop __GFP_NOFAIL flag for high-order-page requests on upper
> >   layer. It becomes less spread between levels when it comes to
> >   __GFP_NOFAIL allocations;
> > - add a comment about a fallback path if high-order attempt is
> >   unsuccessful because for such cases __GFP_NOFAIL is dropped;
> > - fix a typo in a commit message.
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > ---
> >  mm/vmalloc.c | 37 +++++++++++++++++--------------------
> >  1 file changed, 17 insertions(+), 20 deletions(-)
> > 
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 3f9b6bd707d2..57862865e808 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -3531,8 +3531,6 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
> >  		unsigned int order, unsigned int nr_pages, struct page **pages)
> >  {
> >  	unsigned int nr_allocated = 0;
> > -	gfp_t alloc_gfp = gfp;
> > -	bool nofail = gfp & __GFP_NOFAIL;
> >  	struct page *page;
> >  	int i;
> >  
> > @@ -3543,9 +3541,6 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
> >  	 * more permissive.
> >  	 */
> >  	if (!order) {
> > -		/* bulk allocator doesn't support nofail req. officially */
> > -		gfp_t bulk_gfp = gfp & ~__GFP_NOFAIL;
> > -
> >  		while (nr_allocated < nr_pages) {
> >  			unsigned int nr, nr_pages_request;
> >  
> > @@ -3563,12 +3558,11 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
> >  			 * but mempolicy wants to alloc memory by interleaving.
> >  			 */
> >  			if (IS_ENABLED(CONFIG_NUMA) && nid == NUMA_NO_NODE)
> > -				nr = alloc_pages_bulk_array_mempolicy_noprof(bulk_gfp,
> > +				nr = alloc_pages_bulk_array_mempolicy_noprof(gfp,
> >  							nr_pages_request,
> >  							pages + nr_allocated);
> > -
> >  			else
> > -				nr = alloc_pages_bulk_array_node_noprof(bulk_gfp, nid,
> > +				nr = alloc_pages_bulk_array_node_noprof(gfp, nid,
> >  							nr_pages_request,
> >  							pages + nr_allocated);
> >  
> > @@ -3582,30 +3576,24 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
> >  			if (nr != nr_pages_request)
> >  				break;
> >  		}
> > -	} else if (gfp & __GFP_NOFAIL) {
> > -		/*
> > -		 * Higher order nofail allocations are really expensive and
> > -		 * potentially dangerous (pre-mature OOM, disruptive reclaim
> > -		 * and compaction etc.
> > -		 */
> > -		alloc_gfp &= ~__GFP_NOFAIL;
> >  	}
> >  
> >  	/* High-order pages or fallback path if "bulk" fails. */
> >  	while (nr_allocated < nr_pages) {
> > -		if (!nofail && fatal_signal_pending(current))
> > +		if (!(gfp & __GFP_NOFAIL) && fatal_signal_pending(current))
> >  			break;
> >  
> >  		if (nid == NUMA_NO_NODE)
> > -			page = alloc_pages_noprof(alloc_gfp, order);
> > +			page = alloc_pages_noprof(gfp, order);
> >  		else
> > -			page = alloc_pages_node_noprof(nid, alloc_gfp, order);
> > +			page = alloc_pages_node_noprof(nid, gfp, order);
> > +
> >  		if (unlikely(!page))
> >  			break;
> >  
> >  		/*
> >  		 * Higher order allocations must be able to be treated as
> > -		 * indepdenent small pages by callers (as they can with
> > +		 * independent small pages by callers (as they can with
> >  		 * small-page vmallocs). Some drivers do their own refcounting
> >  		 * on vmalloc_to_page() pages, some use page->mapping,
> >  		 * page->lru, etc.
> > @@ -3666,7 +3654,16 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
> >  	set_vm_area_page_order(area, page_shift - PAGE_SHIFT);
> >  	page_order = vm_area_page_order(area);
> >  
> > -	area->nr_pages = vm_area_alloc_pages(gfp_mask | __GFP_NOWARN,
> > +	/*
> > +	 * Higher order nofail allocations are really expensive and
>            ~~~~~~~~~~~~
> Seems we use both higher-order and high-order to describe the
> non 0-order pages in many places. I personally would take high-order,
> higher-order seems to be a little confusing because it's not explicit
> what is compared with and lower.
> 
> Surely this is not an issue to this patch, I see a lot of 'higher order'
> in kernel codes.
> 
I agree. It sounds like hard to figure out the difference between both.
Are you willing send the patch? If not, i can send it out :)

> For this patch,
> 
> Reviewed-by: Baoquan He <bhe@redhat.com>
> 
Thanks!

--
Uladzislau Rezki

