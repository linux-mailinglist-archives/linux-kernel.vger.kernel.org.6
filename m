Return-Path: <linux-kernel+bounces-306427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F69963EF4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0D0A284C40
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 08:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A3918CBE6;
	Thu, 29 Aug 2024 08:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bZaHhaE/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B31C18CBE2
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 08:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724921109; cv=none; b=CLQl19wdxvl9+0YdyT+tvQJCaXTWJCj0I4IOcTOsqS26bZDpTUN33Cj4hZu7uPrtDFbtHVe3I9/nt2Jy1HghrB2Wmb4Zjrxg0hOczvFpFiS/S+ljuymRfTfF49iowkTE9yh2mlw/wNn+KAmhOkIbIIxg/YGF8mnMLepM33Ku1e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724921109; c=relaxed/simple;
	bh=g+3gqHdeKWEVIXcxUbuNJCDA4wBG5ZNM32bIqfxY1Ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TW6RU9YAGUIqbhY91iiS7DERosCxl/Lft+xSNniOPgEBIAHHzCq0/n2VDqyZe53j39+82ru+YKcNebFktf2dVXmCVTL+pykn/TlcELkhqngie8BalyYLdJc8EgNYqu5HWUHN/RUoGBsBf0m1y33TrCGJ9ZPduPisySkr0fjBKa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bZaHhaE/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724921106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zwYKK7AMoFVBHc0427lIp+Y+u5sEYUEoBLFu6Dvvewk=;
	b=bZaHhaE/seQBOWFRj8DYC+EtzNmCOm7a92ZXPZzzh6Y7HYS262zo8+xDH/kNvHgQbnMH80
	dP/2ye98I/hXwOGNp7Agaayb1HyuqWRZh4hUjbl+IHm3WTO861/EFwg/QnyoOfm5aGB4vA
	BS2VG+HYJjUVWwFeQhU0r6nHEy63KLc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-i3eh0m0lOnKWNUoudfTD2g-1; Thu,
 29 Aug 2024 04:45:01 -0400
X-MC-Unique: i3eh0m0lOnKWNUoudfTD2g-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7E2EF1955BF8;
	Thu, 29 Aug 2024 08:44:59 +0000 (UTC)
Received: from localhost (unknown [10.72.112.42])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AD08819560AA;
	Thu, 29 Aug 2024 08:44:57 +0000 (UTC)
Date: Thu, 29 Aug 2024 16:44:51 +0800
From: Baoquan He <bhe@redhat.com>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Michal Hocko <mhocko@suse.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH] mm: vmalloc: Refactor vm_area_alloc_pages() function
Message-ID: <ZtA1Aw3Vjb85xH6x@MiWiFi-R3L-srv>
References: <20240827190916.34242-1-urezki@gmail.com>
 <Zs/vkLWrRNRkSvwC@MiWiFi-R3L-srv>
 <ZtAtYAARL2gx8De5@pc636>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtAtYAARL2gx8De5@pc636>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 08/29/24 at 10:12am, Uladzislau Rezki wrote:
> On Thu, Aug 29, 2024 at 11:48:32AM +0800, Baoquan He wrote:
> > On 08/27/24 at 09:09pm, Uladzislau Rezki (Sony) wrote:
> > > The aim is to simplify and making the vm_area_alloc_pages()
> > > function less confusing as it became more clogged nowadays:
> > > 
> > > - eliminate a "bulk_gfp" variable and do not overwrite a gfp
> > >   flag for bulk allocator;
> > > - drop __GFP_NOFAIL flag for high-order-page requests on upper
> > >   layer. It becomes less spread between levels when it comes to
> > >   __GFP_NOFAIL allocations;
> > > - add a comment about a fallback path if high-order attempt is
> > >   unsuccessful because for such cases __GFP_NOFAIL is dropped;
> > > - fix a typo in a commit message.
> > > 
> > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > ---
> > >  mm/vmalloc.c | 37 +++++++++++++++++--------------------
> > >  1 file changed, 17 insertions(+), 20 deletions(-)
> > > 
> > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > index 3f9b6bd707d2..57862865e808 100644
> > > --- a/mm/vmalloc.c
> > > +++ b/mm/vmalloc.c
> > > @@ -3531,8 +3531,6 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
> > >  		unsigned int order, unsigned int nr_pages, struct page **pages)
> > >  {
> > >  	unsigned int nr_allocated = 0;
> > > -	gfp_t alloc_gfp = gfp;
> > > -	bool nofail = gfp & __GFP_NOFAIL;
> > >  	struct page *page;
> > >  	int i;
> > >  
> > > @@ -3543,9 +3541,6 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
> > >  	 * more permissive.
> > >  	 */
> > >  	if (!order) {
> > > -		/* bulk allocator doesn't support nofail req. officially */
> > > -		gfp_t bulk_gfp = gfp & ~__GFP_NOFAIL;
> > > -
> > >  		while (nr_allocated < nr_pages) {
> > >  			unsigned int nr, nr_pages_request;
> > >  
> > > @@ -3563,12 +3558,11 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
> > >  			 * but mempolicy wants to alloc memory by interleaving.
> > >  			 */
> > >  			if (IS_ENABLED(CONFIG_NUMA) && nid == NUMA_NO_NODE)
> > > -				nr = alloc_pages_bulk_array_mempolicy_noprof(bulk_gfp,
> > > +				nr = alloc_pages_bulk_array_mempolicy_noprof(gfp,
> > >  							nr_pages_request,
> > >  							pages + nr_allocated);
> > > -
> > >  			else
> > > -				nr = alloc_pages_bulk_array_node_noprof(bulk_gfp, nid,
> > > +				nr = alloc_pages_bulk_array_node_noprof(gfp, nid,
> > >  							nr_pages_request,
> > >  							pages + nr_allocated);
> > >  
> > > @@ -3582,30 +3576,24 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
> > >  			if (nr != nr_pages_request)
> > >  				break;
> > >  		}
> > > -	} else if (gfp & __GFP_NOFAIL) {
> > > -		/*
> > > -		 * Higher order nofail allocations are really expensive and
> > > -		 * potentially dangerous (pre-mature OOM, disruptive reclaim
> > > -		 * and compaction etc.
> > > -		 */
> > > -		alloc_gfp &= ~__GFP_NOFAIL;
> > >  	}
> > >  
> > >  	/* High-order pages or fallback path if "bulk" fails. */
> > >  	while (nr_allocated < nr_pages) {
> > > -		if (!nofail && fatal_signal_pending(current))
> > > +		if (!(gfp & __GFP_NOFAIL) && fatal_signal_pending(current))
> > >  			break;
> > >  
> > >  		if (nid == NUMA_NO_NODE)
> > > -			page = alloc_pages_noprof(alloc_gfp, order);
> > > +			page = alloc_pages_noprof(gfp, order);
> > >  		else
> > > -			page = alloc_pages_node_noprof(nid, alloc_gfp, order);
> > > +			page = alloc_pages_node_noprof(nid, gfp, order);
> > > +
> > >  		if (unlikely(!page))
> > >  			break;
> > >  
> > >  		/*
> > >  		 * Higher order allocations must be able to be treated as
> > > -		 * indepdenent small pages by callers (as they can with
> > > +		 * independent small pages by callers (as they can with
> > >  		 * small-page vmallocs). Some drivers do their own refcounting
> > >  		 * on vmalloc_to_page() pages, some use page->mapping,
> > >  		 * page->lru, etc.
> > > @@ -3666,7 +3654,16 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
> > >  	set_vm_area_page_order(area, page_shift - PAGE_SHIFT);
> > >  	page_order = vm_area_page_order(area);
> > >  
> > > -	area->nr_pages = vm_area_alloc_pages(gfp_mask | __GFP_NOWARN,
> > > +	/*
> > > +	 * Higher order nofail allocations are really expensive and
> >            ~~~~~~~~~~~~
> > Seems we use both higher-order and high-order to describe the
> > non 0-order pages in many places. I personally would take high-order,
> > higher-order seems to be a little confusing because it's not explicit
> > what is compared with and lower.
> > 
> > Surely this is not an issue to this patch, I see a lot of 'higher order'
> > in kernel codes.
> > 
> I agree. It sounds like hard to figure out the difference between both.
> Are you willing send the patch? If not, i can send it out :)

I am fine, please go ahead.


