Return-Path: <linux-kernel+bounces-289659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 642B39548D7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 14:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A34A28709C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 12:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C761B3F3D;
	Fri, 16 Aug 2024 12:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="X/lkLRCQ"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C85117C9B0
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 12:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723811582; cv=none; b=jhyvWRm21HNCxdnq/bZEVJ1+br+MPstnHXSR9R1Zs7Y62xB3mweLfPAv64KpsX4A76AyK87R8+ccsyBoekpKh/66/lP2dIn7UYywXrjP/7JEK2xJBq6edmrSLZQ5lQOR/ON6tW9kQt817mfkhdADWOP/F/2dSpT6G8J0SbQiOWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723811582; c=relaxed/simple;
	bh=j0MaI76PTKoeqeDQdZhV0ErnN5UMg+cqjx1sgt61kOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P328IRWXodZ6ZtIzi59nbOxFOOZEqfyvGCn6ZLCVJd9sg4da4vPtZYQnC3AT62jROxu0HxZDqHcejzglUSOo9Xk1Xr3QuQeE6yJxXVMYHmh0UbOEWlUEPTqACWcGTp/yO7AZqZxdah3FjtYt+EWcu2y1Pb55pRKq/VX9whumrvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=X/lkLRCQ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-428ec6c190eso14465315e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 05:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723811579; x=1724416379; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=imUnUTrQCkXERD1oWFs8dq4uU7ZTGW4Zz3wDRT4mvzE=;
        b=X/lkLRCQm7HJz0ykP9pouzG1XF4ZcbiSmg06xgw3lRMM9svqq38NMoFGpwcuBv+Bzv
         gVFzmkQhJtHiSJ4soCyHgQxqOzmtdHrBlJA1LO38RVzzopa197ZnjlBoDeZsVSvqx3R7
         reKUuyalVvT3xGo2VaM94T5V//HRyMPklQhYXtCTdNgrLPDjI5VAkaMjeWHluyiCBh//
         GiFGQ9CTJhruPlC7ANNNItSp2fwypnUkO0zKVbvFH9qeOWnUyP7wFBxFHV6x6an+EpD/
         pQmA2I6Y9Pnc7w5tKDaOtvdEbAWrLmI41phn4TKNwKOM/nyJK/SPqPTkVH2EIX3sGqpi
         svmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723811579; x=1724416379;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imUnUTrQCkXERD1oWFs8dq4uU7ZTGW4Zz3wDRT4mvzE=;
        b=oTE3pL7VsiDaFCbR86plQfCBNgOcBa/e+RUokrlAoapGx08IPbmJ9olYLXmVylnobt
         CB7VNmLTXUVebS6XuHfFPaNeaXC2JmCrkMj05OGi3aVDxptR1OjUAVfa+1o2CXxJRR1S
         YIe6yBzcGr3xPDLX52lii2eJfJghtd8toXDm/GSzkJ1PsH1T+MZbBZsPEpaDwKbYg5J9
         IWOapx76raYy+xFHyZU+iA93SXdHoY3MJQyUs0rVB/FVnqPYw9xXe4vIGhoUeQkbLdeV
         YI8GsWzpi9PDb04HCmMdV/9K1YCLhP309S7rh0jT1z5vjltOGV0cDU/kse+ya+5d4rIR
         jUXw==
X-Forwarded-Encrypted: i=1; AJvYcCV49hu3vRY5HhgZ6fjLJGotJxRzPgzI8ku3DishsLB/gWgHKar3nRNX0MRQ7DgSd440OkMrX/cRg7Rxxbe12twWkTFo1Ef1LIvacprZ
X-Gm-Message-State: AOJu0YxW1svhltVTaMadPdmstX9AvKYHIvqDb3qrmKMne0pocGl6QvAR
	jHcXasQipfuQBp12INGynptiQoVTHp0WeQyU/rfiQ7GGye0tOjDq+oHoFsUy9yZrM00UYt/wu6Q
	o
X-Google-Smtp-Source: AGHT+IEYox1YBAo6ykzkHRbM+Ew1Xh2yiN9lOFnrSfrmPCD8QsEhWd3lchIYN5j834cdCu2zZqrLAQ==
X-Received: by 2002:a05:600c:444d:b0:426:6220:cb57 with SMTP id 5b1f17b1804b1-429ed7d17d8mr16523875e9.25.1723811578716;
        Fri, 16 Aug 2024 05:32:58 -0700 (PDT)
Received: from localhost (109-81-92-77.rct.o2.cz. [109.81.92.77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed650a96sm21636315e9.17.2024.08.16.05.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 05:32:58 -0700 (PDT)
Date: Fri, 16 Aug 2024 14:32:57 +0200
From: Michal Hocko <mhocko@suse.com>
To: Hailong Liu <hailong.liu@oppo.com>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Barry Song <21cnbao@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Tangquan Zheng <zhengtangquan@oppo.com>, stable@vger.kernel.org,
	Baoquan He <bhe@redhat.com>, Matthew Wilcox <willy@infradead.org>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v1] mm/vmalloc: fix page mapping if
 vm_area_alloc_pages() with high order fallback to order 0
Message-ID: <Zr9G-d6bMU4_QodJ@tiehlicka>
References: <20240808122019.3361-1-hailong.liu@oppo.com>
 <CAGsJ_4z4+CCDoPR7+dPEhemBQN60Cj84rCeqRY7-xvWapY4LGg@mail.gmail.com>
 <ZrXiUvj_ZPTc0yRk@tiehlicka>
 <ZrXkVhEg1B0yF5_Q@pc636>
 <20240815220709.47f66f200fd0a072777cc348@linux-foundation.org>
 <20240816091232.fsliktqgza5o5x6t@oppo.com>
 <Zr8mQbc3ETdeOMIK@pc636>
 <20240816114626.jmhqh5ducbk7qeur@oppo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816114626.jmhqh5ducbk7qeur@oppo.com>

On Fri 16-08-24 19:46:26, Hailong Liu wrote:
> On Fri, 16. Aug 12:13, Uladzislau Rezki wrote:
> > On Fri, Aug 16, 2024 at 05:12:32PM +0800, Hailong Liu wrote:
> > > On Thu, 15. Aug 22:07, Andrew Morton wrote:
> > > > On Fri, 9 Aug 2024 11:41:42 +0200 Uladzislau Rezki <urezki@gmail.com> wrote:
> > > >
> > > > > > > Acked-by: Barry Song <baohua@kernel.org>
> > > > > > >
> > > > > > > because we already have a fallback here:
> > > > > > >
> > > > > > > void *__vmalloc_node_range_noprof :
> > > > > > >
> > > > > > > fail:
> > > > > > >         if (shift > PAGE_SHIFT) {
> > > > > > >                 shift = PAGE_SHIFT;
> > > > > > >                 align = real_align;
> > > > > > >                 size = real_size;
> > > > > > >                 goto again;
> > > > > > >         }
> > > > > >
> > > > > > This really deserves a comment because this is not really clear at all.
> > > > > > The code is also fragile and it would benefit from some re-org.
> > > > > >
> > > > > > Thanks for the fix.
> > > > > >
> > > > > > Acked-by: Michal Hocko <mhocko@suse.com>
> > > > > >
> > > > > I agree. This is only clear for people who know the code. A "fallback"
> > > > > to order-0 should be commented.
> > > >
> > > > It's been a week.  Could someone please propose a fixup patch to add
> > > > this comment?
> > >
> > > Hi Andrew:
> > >
> > > Do you mean that I need to send a v2 patch with the the comments included?
> > >
> > It is better to post v2.
> Got it.
> 
> >
> > But before, could you please comment on:
> >
> > in case of order-0, bulk path may easily fail and fallback to the single
> > page allocator. If an request is marked as NO_FAIL, i am talking about
> > order-0 request, your change breaks GFP_NOFAIL for !order.
> >
> > Am i missing something obvious?
> For order-0, alloc_pages(GFP_X | __GFP_NOFAIL, 0), buddy allocator will handle
> the flag correctly. IMO we don't need to handle the flag here.

Let me clarify what I would like to have clarified:

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 6b783baf12a1..fea90a39f5c5 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3510,13 +3510,13 @@ void *vmap_pfn(unsigned long *pfns, unsigned int count, pgprot_t prot)
 EXPORT_SYMBOL_GPL(vmap_pfn);
 #endif /* CONFIG_VMAP_PFN */
 
+/* GFP_NOFAIL semantic is implemented by __vmalloc_node_range_noprof */
 static inline unsigned int
 vm_area_alloc_pages(gfp_t gfp, int nid,
 		unsigned int order, unsigned int nr_pages, struct page **pages)
 {
 	unsigned int nr_allocated = 0;
-	gfp_t alloc_gfp = gfp;
-	bool nofail = gfp & __GFP_NOFAIL;
+	gfp_t alloc_gfp = gfp & ~ __GFP_NOFAIL;
 	struct page *page;
 	int i;
 
@@ -3527,9 +3527,6 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 	 * more permissive.
 	 */
 	if (!order) {
-		/* bulk allocator doesn't support nofail req. officially */
-		gfp_t bulk_gfp = gfp & ~__GFP_NOFAIL;
-
 		while (nr_allocated < nr_pages) {
 			unsigned int nr, nr_pages_request;
 
@@ -3547,12 +3544,12 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 			 * but mempolicy wants to alloc memory by interleaving.
 			 */
 			if (IS_ENABLED(CONFIG_NUMA) && nid == NUMA_NO_NODE)
-				nr = alloc_pages_bulk_array_mempolicy_noprof(bulk_gfp,
+				nr = alloc_pages_bulk_array_mempolicy_noprof(alloc_gfp,
 							nr_pages_request,
 							pages + nr_allocated);
 
 			else
-				nr = alloc_pages_bulk_array_node_noprof(bulk_gfp, nid,
+				nr = alloc_pages_bulk_array_node_noprof(alloc_gfp, nid,
 							nr_pages_request,
 							pages + nr_allocated);
 
@@ -3566,13 +3563,6 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 			if (nr != nr_pages_request)
 				break;
 		}
-	} else if (gfp & __GFP_NOFAIL) {
-		/*
-		 * Higher order nofail allocations are really expensive and
-		 * potentially dangerous (pre-mature OOM, disruptive reclaim
-		 * and compaction etc.
-		 */
-		alloc_gfp &= ~__GFP_NOFAIL;
 	}
 
 	/* High-order pages or fallback path if "bulk" fails. */
-- 
Michal Hocko
SUSE Labs

