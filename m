Return-Path: <linux-kernel+bounces-280563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 492DF94CC2B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 10:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B55E1C211DD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 08:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3880118DF81;
	Fri,  9 Aug 2024 08:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H8Y4Eaxi"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23734175D2C
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 08:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723192103; cv=none; b=dGfPUFGXKA8S3+gnfQ+lQ/aSyD/3AOdd+L3/peMgmc+a4CbZknsa2P5dhp/3iFOgxqeYFY+/KzjsutFBsihg0ImjcJcrNQm5mMGi7fF1+6L1b8DEWSuPyGiaNQWJ7ftpphPs3tNwVgCkJ13zYxlS1Kxu6n88TGb+R1VAsU7nNMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723192103; c=relaxed/simple;
	bh=k/S7wi0MV0srnLj+h3/ApPQ8Z4yky6wJG7x9HEe6kGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dMDFEOjexKgkY+VL8QZLdqJMd246yzEh58a8gqR+0l4taXPQSe2oBzRTujyFW8RoVZ1d77bDaxUA5e9E47zFPmEJhsNfddZCh1+2O9jWwbgDb1JsNSNv686I3BGZ5xVXdxwNcOCGQK84Wd13KdYbBJQqQ9y7kyxbDImZKOhzawI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H8Y4Eaxi; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723192102; x=1754728102;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k/S7wi0MV0srnLj+h3/ApPQ8Z4yky6wJG7x9HEe6kGg=;
  b=H8Y4EaxikD2/D6i6VLfwhkjDsTCgcksmSRtT5jXJ54N/mBWLFQyyGr/c
   tHkT/WUzn0RVR+QUKknSWaJ0a+X2CYjb6W+hGkotia2XLE8HFSzPFRT6w
   oKm4gIYZZoggkctKJuXP5b6oO3manX33rnUa4AoLfIh27HUwY4aWNgKEZ
   bpfFcvI2YV9RsnaQkXyNfE1cYP1jbYH430e+ZiqJFzaC9OckQzCXHNOhe
   E8dIGCnl/PqXvm0eZaLBFq9YVMHyf35ekv2Mbm3BpsLd8MlQ1mSss3EtP
   QekZQZVsxnudmAHcVDAAfrDr8l4iaGQd38Qn8K9Gy4Jn7th0In4JvNvnU
   Q==;
X-CSE-ConnectionGUID: yylN7C4+Rxmk5AqxtWYImA==
X-CSE-MsgGUID: N1BuEKeASfa1jsh74pXhdA==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="21507904"
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="21507904"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 01:28:21 -0700
X-CSE-ConnectionGUID: sG9caBb3S1KMpp4TkGG8iQ==
X-CSE-MsgGUID: G7lr+5mwQhmtDmnKQjHpjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="62334736"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 09 Aug 2024 01:28:19 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 5B85219E; Fri, 09 Aug 2024 11:28:17 +0300 (EEST)
Date: Fri, 9 Aug 2024 11:28:17 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Borislav Petkov (AMD)" <bp@alien8.de>, Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Mike Rapoport <rppt@kernel.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] mm: Introduce PageUnaccepted() page type
Message-ID: <z5r4y4gb2ld2qa3moa33rzxyuzpzuim5ga6kk6oc4n6exdri7h@f6qbgdjhuu2z>
References: <20240805145940.2911011-1-kirill.shutemov@linux.intel.com>
 <20240805145940.2911011-4-kirill.shutemov@linux.intel.com>
 <56be9c2c-6f44-409f-bb66-3bb488f0d546@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56be9c2c-6f44-409f-bb66-3bb488f0d546@redhat.com>

On Tue, Aug 06, 2024 at 02:06:02PM +0200, David Hildenbrand wrote:
> On 05.08.24 16:59, Kirill A. Shutemov wrote:
> > The new page type allows physical memory scanners to detect unaccepted
> > memory and handle it accordingly.
> > 
> > The page type is serialized with zone lock.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> >   include/linux/page-flags.h | 3 +++
> >   mm/page_alloc.c            | 2 ++
> >   2 files changed, 5 insertions(+)
> > 
> > diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> > index 5769fe6e4950..e19eac9c2b5c 100644
> > --- a/include/linux/page-flags.h
> > +++ b/include/linux/page-flags.h
> > @@ -943,6 +943,7 @@ enum pagetype {
> >   	PG_hugetlb	= 0x04000000,
> >   	PG_slab		= 0x02000000,
> >   	PG_zsmalloc	= 0x01000000,
> > +	PG_unaccepted	= 0x00800000,
> >   	PAGE_TYPE_BASE	= 0x80000000,
> > @@ -1076,6 +1077,8 @@ FOLIO_TEST_FLAG_FALSE(hugetlb)
> >   PAGE_TYPE_OPS(Zsmalloc, zsmalloc, zsmalloc)
> > +PAGE_TYPE_OPS(Unaccepted, unaccepted, unaccepted)
> 
> I'm sure you're able to come up with some documentation ;)

Will do.

> > +
> >   /**
> >    * PageHuge - Determine if the page belongs to hugetlbfs
> >    * @page: The page to test.
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 90a1f01d5996..a35efb114496 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -6972,6 +6972,7 @@ static bool try_to_accept_memory_one(struct zone *zone)
> >   	account_freepages(zone, -MAX_ORDER_NR_PAGES, MIGRATE_MOVABLE);
> >   	__mod_zone_page_state(zone, NR_UNACCEPTED, -MAX_ORDER_NR_PAGES);
> > +	__ClearPageUnaccepted(page);
> >   	spin_unlock_irqrestore(&zone->lock, flags);
> >   	accept_page(page, MAX_PAGE_ORDER);
> > @@ -7030,6 +7031,7 @@ static bool __free_unaccepted(struct page *page)
> >   	list_add_tail(&page->lru, &zone->unaccepted_pages);
> >   	account_freepages(zone, MAX_ORDER_NR_PAGES, MIGRATE_MOVABLE);
> >   	__mod_zone_page_state(zone, NR_UNACCEPTED, MAX_ORDER_NR_PAGES);
> > +	__SetPageUnaccepted(page);
> >   	spin_unlock_irqrestore(&zone->lock, flags);
> >   	if (first)
> 
> At the point PG_unaccepted is set/cleared, we don't have another type set,
> right? (IOW, PG_buddy is only set after we cleared PG_unaccepted)

Right. PG_buddy is set after we clear PG_unaccepted.

There's brief period when the page is under accept when PG_unaccepted
already cleared, but PG_buddy is not yet set. But I don't think it can be
problematic.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

