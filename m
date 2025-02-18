Return-Path: <linux-kernel+bounces-520454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 110A7A3AA0D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 21:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01BC6189A0B4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 20:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9894E1DC993;
	Tue, 18 Feb 2025 20:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="xxlgMlqu"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B57E17A304
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 20:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739911119; cv=none; b=ud0A56on9qilRlZ9JaDXtQWsioMIRHGOpfdMY+GMFM9V+ELpAykOncM5AYOVwoWGaw1q/wEWduo4rEvh8H+4EAH/HgPnLPlFd2D9I0dRHMK/LKku8DK0RCRoePMIfUFUPV28+OwfyBqKy++g0KxxgHGNDDwqPLZrOfhhJ3LUm7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739911119; c=relaxed/simple;
	bh=HtG8hLnKFHL1m/PGSd3tobK9mufpegVVjmtn1vvWv4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pm0G4NTbUiPwlKj7QAzoQuI+NnZkBRxyivj3rz/J97HqHeTPajktXtqYq6ShrvRbHV9Ke5H2q6ZjdYfvDRWEpeHi4fawD+CJ7A38YTu02FeJ0RUO2djXJAgyTtMZwXOFDGA0tLPvanrpAWeWjL2SkY2lVx75BT/ZL9aHjf4ol6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=xxlgMlqu; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6e6698667c7so53712926d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 12:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1739911115; x=1740515915; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xiogs8K0wkN/JcL/xShcpaN2YEfhgzzsEDBVwZbdHNw=;
        b=xxlgMlqukb4V0jHVjzYDWYvq31sPNfTlvgIKJw1avC+Og5pzVUZmfgVNjrlrxcd1yc
         HCLynTk0YbmwQELWFAa8AZi3KPvkY5l+SuX7x4U/Mf03TSYk/Tm3MyJYttK88syCBkqt
         tClROVhXBEb95wFtsNIsJkKjlE8I5IS7hDoy/IWuEULhAZtIPRm9ZaKef4IcoNuVT9aM
         8jMGCTsRcDEKVJam6PeaCBSlhbsqaOHNVUr7sTyq4LdwUDi45WcjJPxV+zYETXI2NbdV
         Z1x6WbMeFt8Lg3zDKfkmsFVbXsMbHDTd/kvoazpVFVcQVKe39GDSDAiqupGT2tbneBzJ
         9VdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739911115; x=1740515915;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xiogs8K0wkN/JcL/xShcpaN2YEfhgzzsEDBVwZbdHNw=;
        b=vKHsycu9yEGZrh1d0KuI0KjqK7hc6BLxO+kuaovA1d0AiIbn7W89cZul66DqUX/Kg6
         V7rnAbuVF/JeD4JqqDz7fAG0W8MZ6fYoVt81ee3P7NTzSCZUcSLvuA5k+Svdjmrr8dHH
         cH4ZcKwoBZviThucYjlxMGrp4aVHOpW9T7rDLO615ckS6o3d3yhetMSkj+dUBpflpITK
         q8CCTMmkyPNC0U4UGDmdWZRrgP91iAiMAgaVd+qKP+W6DMbi88Wh8kuzNDFQKJ993sXV
         dhQKstvyToe1knsrb/087ZQvMHsPH1tV40RciR4KwQbMIV3sbla6hhdGQYeztxwG3NN5
         YAog==
X-Forwarded-Encrypted: i=1; AJvYcCVNYl+FseYnvPaPhaUmCH0s7yZZcfycxZk4+8c/OEQe8gV/0FxZFpn7w7Tj19o1Z1vtJ+FC+tnQJKAixKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyY6bha8+0+vpywVMhKvxg+1QOaxai91lo5Wdix9dv6kGp+hVq
	IyJrgAw9UjfIpHwwJ/6qCNR1HIvBDLVcbWFJcl7+cqE2dt6e4UaHr2z3bF6Wozo=
X-Gm-Gg: ASbGncur7SSbZpZLjFSxgVtfWUjsnMYsuM7ECwnyKleO1296sGC0tEdz9WK1M2mkyYm
	H7y09OX1+HV/58BddYk3eABXDCpMIHE4RGLKxQiNElPrNNc2Fp5IRCtI4d2SjKOR3EGwWCJI0e2
	kgRmDdGCDy4wQ2SuAoyKhxwlFBTKM3qA/8z7N24VftY9Xmxnh1UsQcOxkAMoYhAUxZMNoq01blW
	5Dj1Ymw0YeZCbyDRe0jSHdkuEOcYJVn3TL9s59ZAkErFG9RYtKbHYOjcSh7oQOV0fRC26Axr8If
	mw4XTmglt1K07w==
X-Google-Smtp-Source: AGHT+IFTX34tE4+Ke7FS5c46s2ZTF+CV5M73ALzr9YzSuUx/AHSZ8a3tBZmD0zWWK9U/Mb5cSWtk8Q==
X-Received: by 2002:ad4:5fcd:0:b0:6d8:a0c8:e468 with SMTP id 6a1803df08f44-6e66ccd4b26mr199962256d6.24.1739911114882;
        Tue, 18 Feb 2025 12:38:34 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6e65daffd71sm67277186d6.101.2025.02.18.12.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 12:38:34 -0800 (PST)
Date: Tue, 18 Feb 2025 15:38:30 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Brendan Jackman <jackmanb@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mel Gorman <mgorman@techsingularity.net>,
	Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosry.ahmed@linux.dev>
Subject: Re: [PATCH] mm/page_alloc: Clarify some migratetype fallback code
Message-ID: <20250218203830.GA1264207@cmpxchg.org>
References: <20250214-clarify-steal-v1-1-79dc5adf1b79@google.com>
 <20250214212647.GB233399@cmpxchg.org>
 <CA+i-1C3e_JUBBhMDYwrehvLZzLtb9pfgEy8=wQa=9uTBr1-b5g@mail.gmail.com>
 <764394d9-592c-4d68-8910-67362dd8810a@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <764394d9-592c-4d68-8910-67362dd8810a@suse.cz>

On Tue, Feb 18, 2025 at 11:19:58AM +0100, Vlastimil Babka wrote:
> On 2/17/25 17:26, Brendan Jackman wrote:
> > On Fri, 14 Feb 2025 at 22:26, Johannes Weiner <hannes@cmpxchg.org> wrote:
> >> >  2. can_steal_fallback() sounds as though it's answering the question "am
> >> >     I functionally permitted to allocate from that other type" but in
> >> >     fact it is encoding a heuristic preference.
> >>
> >> Here I don't see that nuance tbh.
> 
> I think I do.
> 
> >>
> >> >  3. The same piece of data has different names in different places:
> >> >     can_steal vs whole_block. This reinforces point 2 because it looks
> 
> I think some of the weirdness comes from the time before migratetype hygiene
> series. IIRC it was possible to steal just the page we want to allocate,
> that and extra pages but not the whole block, or whole block. Now it's
> either just the page or whole block.
> 
> >> >     like the different names reflect a shift in intent from "am I
> >> >     allowed to steal" to "do I want to steal", but no such shift exists.
> >> >
> >> > Fix 1. by avoiding the term "steal" in ambiguous contexts. This fixes
> >> > 3. automatically since the natural name for can_steal is whole_block.
> >>
> >> I'm not a fan of whole_block because it loses the action verb. It
> >> makes sense in the context of steal_suitable_fallback(), but becomes
> >> ominous in find_suitable_fallback().
> >>
> >> Maybe @block_claimable would be better?
> 
> How about @claim_block ? That's even more "action verb" as the verb is not
> passive.

Sounds good to me.

> > Yeah that sounds good to me.
> > 
> >> > @@ -1948,7 +1948,7 @@ steal_suitable_fallback(struct zone *zone, struct page *page,
> >> >       if (boost_watermark(zone) && (alloc_flags & ALLOC_KSWAPD))
> >> >               set_bit(ZONE_BOOSTED_WATERMARK, &zone->flags);
> >> >
> >> > -     /* We are not allowed to try stealing from the whole block */
> >> > +     /* No point in stealing from the whole block */
> >>
> >> The original comment actually makes more sense to me. Why is there no
> >> point? It could well find enough free+alike pages to steal the
> >> block... It's just not allowed to.
> > 
> > OK so this is basically point 2 from the commit message, maybe I don't
> > really understand why this condition is here, and maybe I'm about to
> > look stupid.
> > 
> > Why don't we allow this code to steal the whole block? There wouldn't
> > be any functional bug if it did, right? I thought that !whole_block
> > just meant "flipping that block would not have any real benefit from a
> > fragmentation point of view". So we'd just be doing work and modifying
> > data structures for no good reason. Is there some stronger reason I'm
> > missing why we really _mustn't_ steal it?
> 
> Agreed with your view.

Thanks, I hadn't looked at it this way. There is also this comment

 * If we are stealing a relatively large buddy page, it is likely there will
 * be more free pages in the pageblock, so try to steal them all.

explaining that it's about whether there is a point in trying.

> >> I will say, the current code is pretty hard to reason about:
> >>
> >> On one hand we check the block size statically in can_steal_fallback;
> >> on the other hand, we do that majority scan for compatible pages in
> >> steal_suitable_fallback(). The effective outcomes are hard to discern,
> >> and I'm honestly not convinced they're all intentional.
> >>
> >> For example, if we're allowed to steal the block because of this in
> >> can_steal_fallback():
> >>
> >>         order >= pageblock_order/2
> >>
> >> surely, we'll always satisfy this in steal_suitable_fallback()
> >>
> >>         free_pages + alike_pages >= (1 << (pageblock_order-1)
> >>
> >> on free_pages alone.
> > 
> > No, the former is half the _order_ the latter is half the _number of
> > pages_. So e.g. we could have order=6 (assuming pageblock_order=10)
> > then free_pages might be only 1<<6 which is less than 1<<9.

Doh, absolute brainfart. I should have known better:

"On Fri, 14 Feb 2025 at 22:26, Johannes Weiner <hannes@cmpxchg.org> wrote:"
    ^^^                 ^^^^^

> Aha! Looks like this is also a leftover from before migratetype hygiene
> series that went unnoticed. The logic was, if we're making an unmovable
> allocation stealing from a movable block, even if we don't claim the whole
> block, at least steal the highest order available. Then more unmovable
> allocations can be satisfied from what remains of the high-order split,
> before we have to steal from another movable pageblock.

Ah, right. So it was

	1. buddy >= pageblock_order:	steal free pages & claim type
	2. buddy >= pageblock_order/2:	steal free pages
	3. otherwise:			steal only the requested page

The hygiene patches eliminated case 2 by disallowing type mismatches
between freelists and the pages on them.

That's why the pageblock_order/2 check looks a lot more spurious now
than it used to.

> If we're making a movable allocation stealing from an unmovable pageblock,
> we don't need to make this buffer, as polluting unmovable pageblocks with
> movable allocations is not that bad - they can be compacted later. So we go
> for the smallest order we need.
> 
> However IIUC this is all moot now. If we don't claim the whole pageblock,
> and split a high-order page, the remains of the split will go to the
> freelists of the migratetype of the unclaimed pageblock (i.e. movable),
> previously (before migratetype hygiene) they would got to the freelists of
> the migratetype we want to allocate (unmovable).
> 
> So now it makes no sense to want the highest order if we're not claiming the
> whole pageblock, we're just causing more fragmentation for no good reason.
> We should always do the find_smallest. It would be good to fix this.

That's a good point.

It still makes sense to have the two passes, though, right? One pass
where we try to steal a whole block starting from the biggest buddies;
and then one pass where we try to steal an individual page starting
from the smallest buddies.

Something like this, completely untested draft:

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d6644aeaabec..f16e3f2bf3dd 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1911,13 +1911,12 @@ static inline bool boost_watermark(struct zone *zone)
  * can claim the whole pageblock for the requested migratetype. If not, we check
  * the pageblock for constituent pages; if at least half of the pages are free
  * or compatible, we can still claim the whole block, so pages freed in the
- * future will be put on the correct free list. Otherwise, we isolate exactly
- * the order we need from the fallback block and leave its migratetype alone.
+ * future will be put on the correct free list.
  */
 static struct page *
-steal_suitable_fallback(struct zone *zone, struct page *page,
-			int current_order, int order, int start_type,
-			unsigned int alloc_flags, bool whole_block)
+try_to_steal_block(struct zone *zone, struct page *page,
+		   int current_order, int order, int start_type,
+		   unsigned int alloc_flags)
 {
 	int free_pages, movable_pages, alike_pages;
 	unsigned long start_pfn;
@@ -1930,7 +1929,7 @@ steal_suitable_fallback(struct zone *zone, struct page *page,
 	 * highatomic accounting.
 	 */
 	if (is_migrate_highatomic(block_type))
-		goto single_page;
+		return NULL;
 
 	/* Take ownership for orders >= pageblock_order */
 	if (current_order >= pageblock_order) {
@@ -1951,14 +1950,10 @@ steal_suitable_fallback(struct zone *zone, struct page *page,
 	if (boost_watermark(zone) && (alloc_flags & ALLOC_KSWAPD))
 		set_bit(ZONE_BOOSTED_WATERMARK, &zone->flags);
 
-	/* We are not allowed to try stealing from the whole block */
-	if (!whole_block)
-		goto single_page;
-
 	/* moving whole block can fail due to zone boundary conditions */
 	if (!prep_move_freepages_block(zone, page, &start_pfn, &free_pages,
 				       &movable_pages))
-		goto single_page;
+		return NULL;
 
 	/*
 	 * Determine how many pages are compatible with our allocation.
@@ -1991,9 +1986,7 @@ steal_suitable_fallback(struct zone *zone, struct page *page,
 		return __rmqueue_smallest(zone, order, start_type);
 	}
 
-single_page:
-	page_del_and_expand(zone, page, order, current_order, block_type);
-	return page;
+	return NULL;
 }
 
 /*
@@ -2216,23 +2209,16 @@ __rmqueue_fallback(struct zone *zone, int order, int start_migratetype,
 		if (fallback_mt == -1)
 			continue;
 
-		/*
-		 * We cannot steal all free pages from the pageblock and the
-		 * requested migratetype is movable. In that case it's better to
-		 * steal and split the smallest available page instead of the
-		 * largest available page, because even if the next movable
-		 * allocation falls back into a different pageblock than this
-		 * one, it won't cause permanent fragmentation.
-		 */
-		if (!can_steal && start_migratetype == MIGRATE_MOVABLE
-					&& current_order > order)
+		if (!can_steal)
 			goto find_smallest;
 
-		goto do_steal;
+		page = get_page_from_free_area(area, fallback_mt);
+		page = try_to_steal_block(zone, page, current_order, order,
+					  start_migratetype, alloc_flags);
+		if (page)
+			goto out;
 	}
 
-	return NULL;
-
 find_smallest:
 	for (current_order = order; current_order < NR_PAGE_ORDERS; current_order++) {
 		area = &(zone->free_area[current_order]);
@@ -2248,13 +2234,9 @@ __rmqueue_fallback(struct zone *zone, int order, int start_migratetype,
 	 */
 	VM_BUG_ON(current_order > MAX_PAGE_ORDER);
 
-do_steal:
 	page = get_page_from_free_area(area, fallback_mt);
-
-	/* take off list, maybe claim block, expand remainder */
-	page = steal_suitable_fallback(zone, page, current_order, order,
-				       start_migratetype, alloc_flags, can_steal);
-
+	page_del_and_expand(zone, page, order, current_order, fallback_mt);
+out:
 	trace_mm_page_alloc_extfrag(page, order, current_order,
 		start_migratetype, fallback_mt);
 

