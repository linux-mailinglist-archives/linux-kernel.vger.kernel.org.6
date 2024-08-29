Return-Path: <linux-kernel+bounces-306464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A741C963F59
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29C551F2588A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C9018CBF5;
	Thu, 29 Aug 2024 09:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HnqJb+CU"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90DB18CBE9
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 09:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724922062; cv=none; b=nMdVjfrwORyzl1v3kAoO+cXKcozBaz18UktYYjmt6mrnzRd+g6XPVEr0GiEYVQYMym62kGS6+MaqaEiPz84xnmyJ3a7QV9OdpfSIALVJE5ADzlAsvOOPX6fX2kCPHxwcU/79MK2kLFGd6UxbXq7NlcJV6SlJOHzh6FwKyjMQiv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724922062; c=relaxed/simple;
	bh=TjmGPAYAUbMxejDCGnA8JDrOGHpzuvnRZX4ONKhnOwg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gHXuRrsse435FPocj3farfknjxPqnwPQqL79ZHCqU6Pq4/fo72psbsLEjMjoLSlhW4xRzcxi86V4QaBvYfItn4Tld6G1Q2JVqLR++jakujhWSmAX7d1XKTEUue1hyd6UKxqeAO0hCG2isv7QqrUkq8iPEr+z0r2GsalxN2+ijkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HnqJb+CU; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f409c87b07so5127231fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 02:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724922059; x=1725526859; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mqrqAqaRSgrInF1coE2971HDeJozKvG8Ym+70UpmzmY=;
        b=HnqJb+CUT8cDtr/Z76yZBVt4TB0qazSG0veSjKCfTnd4Ga8hOtp9uUZICCNZbYiHAa
         0OQf+u+Gu1ujKzU6ZWnE39cHDvzO0GJIFJabbYJvsyeLKtawMWNae4Kx+Hiv6BI6yUZH
         KhH0SWIw8Yh3DLVnw80p4nAcZVTv363j/ffJIur5ZHyzfduOgTk8pzqJqXM8cRXMSUV+
         kbINAfHxI8ZBvoOL9O6D93+eP3b8oV0vBKZpuanhzH600bQhgpRxQmCOv/L7Xn7GW8Y4
         5kqemKkzQWE6xJJnKgciEeKqgGdbT4Yd3CQV/VQC0ITf7imrsU/wzlR0u38mE4lhfG8/
         Tu2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724922059; x=1725526859;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mqrqAqaRSgrInF1coE2971HDeJozKvG8Ym+70UpmzmY=;
        b=EPrY5yQIXnuaHj5cKEmCA/qhXEw90FZwTVhlNKU2jrxEfAHP7QOjq/Re9uspBqVHhc
         EmUpAJfULZuorne6MwLuNZVqwVwWou6LLaOYCP7qPHemMOQgk32hqxN7R5oBwmG0XxJx
         kosSaUDs2ucR7Mr7z59/GyNF0tF4BPTCNt5hFznEzVBQlrvsgXlYgwcc1WeaGZoZh/rl
         DR+xZGsa2s8UUtlzmSJAZD386WjEVxSFMEzFL3679EBk7zTDrC8fuOCtVmfXZH5n7nRI
         kKiZf6vr/1w1oHVJ6HSLBsIftL6CbxaMSiHCctFFa7JuKnRIKEiVjxIYhDoTlp1uQgfE
         7iSQ==
X-Forwarded-Encrypted: i=1; AJvYcCX//j5kcLMF5Rm11Ok4lH/061bA//I9HY1I2+PP1pupwgpREUjK2+rnzeP22AMyYU4SauI3qepx/uW4XTs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk/tIcbAEZY+g6lAwDvk7lzvrLN+xlE+3vhF4wAjpP5GQVBs03
	1f+MB+cD7Jqg2frukwy+OjcoNtlIMuGRopLJVjxMxTDxlq62JTZI
X-Google-Smtp-Source: AGHT+IGvhPGSk7+LB/aNy+FUpLxz7pd8E4OOIWgj18FiLvsH06laCDyXN+i/ssSX6zwLCl3/tf/Tbw==
X-Received: by 2002:a2e:4612:0:b0:2ef:2061:8bf5 with SMTP id 38308e7fff4ca-2f610552732mr17072841fa.40.1724922058008;
        Thu, 29 Aug 2024 02:00:58 -0700 (PDT)
Received: from pc636 (84-217-131-213.customers.ownit.se. [84.217.131.213])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f614f00926sm1226551fa.40.2024.08.29.02.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 02:00:57 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Thu, 29 Aug 2024 11:00:56 +0200
To: Baoquan He <bhe@redhat.com>
Cc: Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Michal Hocko <mhocko@suse.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH] mm: vmalloc: Refactor vm_area_alloc_pages() function
Message-ID: <ZtA4yAP7KqAA3tEh@pc636>
References: <20240827190916.34242-1-urezki@gmail.com>
 <Zs/vkLWrRNRkSvwC@MiWiFi-R3L-srv>
 <ZtAtYAARL2gx8De5@pc636>
 <ZtA1Aw3Vjb85xH6x@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtA1Aw3Vjb85xH6x@MiWiFi-R3L-srv>

On Thu, Aug 29, 2024 at 04:44:51PM +0800, Baoquan He wrote:
> On 08/29/24 at 10:12am, Uladzislau Rezki wrote:
> > On Thu, Aug 29, 2024 at 11:48:32AM +0800, Baoquan He wrote:
> > > On 08/27/24 at 09:09pm, Uladzislau Rezki (Sony) wrote:
> > > > The aim is to simplify and making the vm_area_alloc_pages()
> > > > function less confusing as it became more clogged nowadays:
> > > > 
> > > > - eliminate a "bulk_gfp" variable and do not overwrite a gfp
> > > >   flag for bulk allocator;
> > > > - drop __GFP_NOFAIL flag for high-order-page requests on upper
> > > >   layer. It becomes less spread between levels when it comes to
> > > >   __GFP_NOFAIL allocations;
> > > > - add a comment about a fallback path if high-order attempt is
> > > >   unsuccessful because for such cases __GFP_NOFAIL is dropped;
> > > > - fix a typo in a commit message.
> > > > 
> > > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > ---
> > > >  mm/vmalloc.c | 37 +++++++++++++++++--------------------
> > > >  1 file changed, 17 insertions(+), 20 deletions(-)
> > > > 
> > > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > > index 3f9b6bd707d2..57862865e808 100644
> > > > --- a/mm/vmalloc.c
> > > > +++ b/mm/vmalloc.c
> > > > @@ -3531,8 +3531,6 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
> > > >  		unsigned int order, unsigned int nr_pages, struct page **pages)
> > > >  {
> > > >  	unsigned int nr_allocated = 0;
> > > > -	gfp_t alloc_gfp = gfp;
> > > > -	bool nofail = gfp & __GFP_NOFAIL;
> > > >  	struct page *page;
> > > >  	int i;
> > > >  
> > > > @@ -3543,9 +3541,6 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
> > > >  	 * more permissive.
> > > >  	 */
> > > >  	if (!order) {
> > > > -		/* bulk allocator doesn't support nofail req. officially */
> > > > -		gfp_t bulk_gfp = gfp & ~__GFP_NOFAIL;
> > > > -
> > > >  		while (nr_allocated < nr_pages) {
> > > >  			unsigned int nr, nr_pages_request;
> > > >  
> > > > @@ -3563,12 +3558,11 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
> > > >  			 * but mempolicy wants to alloc memory by interleaving.
> > > >  			 */
> > > >  			if (IS_ENABLED(CONFIG_NUMA) && nid == NUMA_NO_NODE)
> > > > -				nr = alloc_pages_bulk_array_mempolicy_noprof(bulk_gfp,
> > > > +				nr = alloc_pages_bulk_array_mempolicy_noprof(gfp,
> > > >  							nr_pages_request,
> > > >  							pages + nr_allocated);
> > > > -
> > > >  			else
> > > > -				nr = alloc_pages_bulk_array_node_noprof(bulk_gfp, nid,
> > > > +				nr = alloc_pages_bulk_array_node_noprof(gfp, nid,
> > > >  							nr_pages_request,
> > > >  							pages + nr_allocated);
> > > >  
> > > > @@ -3582,30 +3576,24 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
> > > >  			if (nr != nr_pages_request)
> > > >  				break;
> > > >  		}
> > > > -	} else if (gfp & __GFP_NOFAIL) {
> > > > -		/*
> > > > -		 * Higher order nofail allocations are really expensive and
> > > > -		 * potentially dangerous (pre-mature OOM, disruptive reclaim
> > > > -		 * and compaction etc.
> > > > -		 */
> > > > -		alloc_gfp &= ~__GFP_NOFAIL;
> > > >  	}
> > > >  
> > > >  	/* High-order pages or fallback path if "bulk" fails. */
> > > >  	while (nr_allocated < nr_pages) {
> > > > -		if (!nofail && fatal_signal_pending(current))
> > > > +		if (!(gfp & __GFP_NOFAIL) && fatal_signal_pending(current))
> > > >  			break;
> > > >  
> > > >  		if (nid == NUMA_NO_NODE)
> > > > -			page = alloc_pages_noprof(alloc_gfp, order);
> > > > +			page = alloc_pages_noprof(gfp, order);
> > > >  		else
> > > > -			page = alloc_pages_node_noprof(nid, alloc_gfp, order);
> > > > +			page = alloc_pages_node_noprof(nid, gfp, order);
> > > > +
> > > >  		if (unlikely(!page))
> > > >  			break;
> > > >  
> > > >  		/*
> > > >  		 * Higher order allocations must be able to be treated as
> > > > -		 * indepdenent small pages by callers (as they can with
> > > > +		 * independent small pages by callers (as they can with
> > > >  		 * small-page vmallocs). Some drivers do their own refcounting
> > > >  		 * on vmalloc_to_page() pages, some use page->mapping,
> > > >  		 * page->lru, etc.
> > > > @@ -3666,7 +3654,16 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
> > > >  	set_vm_area_page_order(area, page_shift - PAGE_SHIFT);
> > > >  	page_order = vm_area_page_order(area);
> > > >  
> > > > -	area->nr_pages = vm_area_alloc_pages(gfp_mask | __GFP_NOWARN,
> > > > +	/*
> > > > +	 * Higher order nofail allocations are really expensive and
> > >            ~~~~~~~~~~~~
> > > Seems we use both higher-order and high-order to describe the
> > > non 0-order pages in many places. I personally would take high-order,
> > > higher-order seems to be a little confusing because it's not explicit
> > > what is compared with and lower.
> > > 
> > > Surely this is not an issue to this patch, I see a lot of 'higher order'
> > > in kernel codes.
> > > 
> > I agree. It sounds like hard to figure out the difference between both.
> > Are you willing send the patch? If not, i can send it out :)
> 
> I am fine, please go ahead.
> 
Good! I will fix it.

--
Uladzislau Rezki

