Return-Path: <linux-kernel+bounces-560367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6A8A60335
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 22:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 920C68812D9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 21:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D472D1F4E30;
	Thu, 13 Mar 2025 21:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="sT9d9hXn"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDFB1F463F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 21:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741900023; cv=none; b=VOHhcDieSuRnOdJT9s91wGnc4jQS/KMqFdYflO1r1uj/OUGK/n4uQBbH9sEB7BCdQdVMnIT3JYGe9XZHPfxmTEQi99WBI+7Fyc5RDDWhz9MTi7wVR4zlwTv28GcBDaC2M6/u+ziQ+MziXPo5+ZD4vMU7XKag1+zL5G0H5xhHzLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741900023; c=relaxed/simple;
	bh=fJg1sbubYJbEynraiys1Xl4shibh+vkLbDd7XREzGuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pu2V9tBDopnlOHxhIGQ3eZG6mqT8eMuMgOzbziGzA004xo+z5KbEKcnsE5nIL2TqXM7+e+QCW5Bjc+a8P02IQwp9DIliZhbBb51WOhRh4TrpwNRyqde+Uv2bud6wSjvDFOGbND1Lm4z7lCR2iowNrXPbf37dixDB/x2XJFrhJbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=sT9d9hXn; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4769aef457bso16223561cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 14:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1741900018; x=1742504818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jrFqfcieZOq9at8nTRvNC7n7QX7bSrdSSf1BjUE4qFU=;
        b=sT9d9hXnhFdayOotyAI8Ec/a9d/4x87RiWayDZswu15o8a0mr4/G40mSAJRYz9UJ+w
         BdSL4z+ysRNYGf1tjGM9wKaI6cuNuX7wCay2FG1H/QGTktxpdi4hzeoxRn3OzXOslAcu
         t0OCsjWVuuNkNBG/4TaDTZy/3kZ8TadAVO0cguUoXgUefBsABV7kTmuhKc5eB89NS9Li
         UCQCbdN7XRCUULVs/h5q2Dw+RRxdFuhWhbnd2Kwot9ixO2B9fiO+JJJxElENepL5hn9W
         7N41HcZyc6qAoJSS8f6vUgnA0Cs4piEiei6A1UHmPKxqgJ0wS9yajMX0fCNDmPX8+UuF
         qHnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741900018; x=1742504818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jrFqfcieZOq9at8nTRvNC7n7QX7bSrdSSf1BjUE4qFU=;
        b=WA+vE4taTfTca1hUEdCT+fg3d+acrRbdFaraXFUVkATd0CIlWYbvjCMUAoZKeqhmAu
         RJmteGnFyi0Juj+a66bWQkUAPqZtxqsZrdQO9zrEnUWUAhgxXnPrtYBvLlN1Q2y88AWK
         yaudCe2A26NMesi9k4+RPb2IYqmSoOYSgDdj9vYbcy70SSiHItUnXnDN9ecFZEnxkgyA
         OOJzaqllWOMf1M1eYuladHdK0jNrd7nX06h9IEZrSzWhkLgxGyg6hPBllwDAXZqcyzFY
         ho1uEHqDyElzImR/Diyd8622qNnskmu3fMOIisr0Jh7fe8QhY0YvacF14brFIp4i0+AX
         MRfg==
X-Forwarded-Encrypted: i=1; AJvYcCX4k9AX+gjNJ3YBphmkDkilplLN739f2p7qDjkXOeA4XdnXmITxm7p3RpIGMwZ21SNqjymmCW2HZ7VV4lo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOiFT7MJx/yB7/1Lmcy330PuJ3FMEjtrEdFusTcmyABEBwc0nF
	RiZ5PMeksMXBia/xPaCbxZcd81L81o2kY2wXaK0EQ2xNuSm+EWPkA/P/Yik8qf0=
X-Gm-Gg: ASbGncuvUw5JmtnysK59r1NsZd2T1K4QpmR7uEO0kyj1x9vQJmFqrwY+hXAhGMxwC5l
	uvs4vOgHoXkgpqEGbFccdFqxZup5VwqTHuRSQVDkvmau1XhZzbZ0TBXU6Ft214MV30FJsdfRZXm
	WyiQV05rtzf4bqmwcMuGfsHRf81dTdmlR1IE7xFlJpkyrGz2BPaJP4ziz2QXNzNwkdIqKeDFlK4
	Uv5u25/U3thQ06HFCB7mmU4FidIckjor+h6ooX3SDe5njxtxdq5KirSFNzDjYlGAHZJlm1bnYgN
	xzbT8v088ZNs4VJBVcOaeKe2PcLNCMgzNlaXWmk6JL0=
X-Google-Smtp-Source: AGHT+IEDyN0M6bIcmPwzaon/X4MJTAlHo+m+s2WcqlwJf5d95cUnnQdEITXcrYwXBCRzts6TlH0+Zw==
X-Received: by 2002:a05:622a:45:b0:476:84c0:4864 with SMTP id d75a77b69052e-476c8152dfbmr1632161cf.31.1741900018472;
        Thu, 13 Mar 2025 14:06:58 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6eade231256sm13909986d6.32.2025.03.13.14.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 14:06:56 -0700 (PDT)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Mel Gorman <mgorman@techsingularity.net>,
	Zi Yan <ziy@nvidia.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] mm: compaction: push watermark into compaction_suitable() callers
Date: Thu, 13 Mar 2025 17:05:32 -0400
Message-ID: <20250313210647.1314586-2-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250313210647.1314586-1-hannes@cmpxchg.org>
References: <20250313210647.1314586-1-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

compaction_suitable() hardcodes the min watermark, with a boost to the
low watermark for costly orders. However, compaction_ready() requires
order-0 at the high watermark. It currently checks the marks twice.

Make the watermark a parameter to compaction_suitable() and have the
callers pass in what they require:

- compaction_zonelist_suitable() is used by the direct reclaim path,
  so use the min watermark.

- compact_suit_allocation_order() has a watermark in context derived
  from cc->alloc_flags.

  The only quirk is that kcompactd doesn't initialize cc->alloc_flags
  explicitly. There is a direct check in kcompactd_do_work() that
  passes ALLOC_WMARK_MIN, but there is another check downstack in
  compact_zone() that ends up passing the unset alloc_flags. Since
  they default to 0, and that coincides with ALLOC_WMARK_MIN, it is
  correct. But it's subtle. Set cc->alloc_flags explicitly.

- should_continue_reclaim() is direct reclaim, use the min watermark.

- Finally, consolidate the two checks in compaction_ready() to a
  single compaction_suitable() call passing the high watermark.

  There is a tiny change in behavior: before, compaction_suitable()
  would check order-0 against min or low, depending on costly
  order. Then there'd be another high watermark check.

  Now, the high watermark is passed to compaction_suitable(), and the
  costly order-boost (low - min) is added on top. This means
  compaction_ready() sets a marginally higher target for free pages.

  In a kernelbuild + THP pressure test, though, this didn't show any
  measurable negative effects on memory pressure or reclaim rates. As
  the comment above the check says, reclaim is usually stopped short
  on should_continue_reclaim(), and this just defines the worst-case
  reclaim cutoff in case compaction is not making any headway.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/compaction.h |  5 ++--
 mm/compaction.c            | 52 ++++++++++++++++++++------------------
 mm/vmscan.c                | 26 ++++++++++---------
 3 files changed, 45 insertions(+), 38 deletions(-)

diff --git a/include/linux/compaction.h b/include/linux/compaction.h
index 7bf0c521db63..173d9c07a895 100644
--- a/include/linux/compaction.h
+++ b/include/linux/compaction.h
@@ -95,7 +95,7 @@ extern enum compact_result try_to_compact_pages(gfp_t gfp_mask,
 		struct page **page);
 extern void reset_isolation_suitable(pg_data_t *pgdat);
 extern bool compaction_suitable(struct zone *zone, int order,
-					       int highest_zoneidx);
+				unsigned long watermark, int highest_zoneidx);
 
 extern void compaction_defer_reset(struct zone *zone, int order,
 				bool alloc_success);
@@ -113,7 +113,8 @@ static inline void reset_isolation_suitable(pg_data_t *pgdat)
 }
 
 static inline bool compaction_suitable(struct zone *zone, int order,
-						      int highest_zoneidx)
+				       unsigned long watermark,
+				       int highest_zoneidx)
 {
 	return false;
 }
diff --git a/mm/compaction.c b/mm/compaction.c
index 550ce5021807..036353ef1878 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2382,40 +2382,42 @@ static enum compact_result compact_finished(struct compact_control *cc)
 }
 
 static bool __compaction_suitable(struct zone *zone, int order,
-				  int highest_zoneidx,
-				  unsigned long wmark_target)
+				  unsigned long watermark, int highest_zoneidx,
+				  unsigned long free_pages)
 {
-	unsigned long watermark;
 	/*
 	 * Watermarks for order-0 must be met for compaction to be able to
 	 * isolate free pages for migration targets. This means that the
-	 * watermark and alloc_flags have to match, or be more pessimistic than
-	 * the check in __isolate_free_page(). We don't use the direct
-	 * compactor's alloc_flags, as they are not relevant for freepage
-	 * isolation. We however do use the direct compactor's highest_zoneidx
-	 * to skip over zones where lowmem reserves would prevent allocation
-	 * even if compaction succeeds.
-	 * For costly orders, we require low watermark instead of min for
-	 * compaction to proceed to increase its chances.
+	 * watermark have to match, or be more pessimistic than the check in
+	 * __isolate_free_page().
+	 *
+	 * For costly orders, we require a higher watermark for compaction to
+	 * proceed to increase its chances.
+	 *
+	 * We use the direct compactor's highest_zoneidx to skip over zones
+	 * where lowmem reserves would prevent allocation even if compaction
+	 * succeeds.
+	 *
 	 * ALLOC_CMA is used, as pages in CMA pageblocks are considered
-	 * suitable migration targets
+	 * suitable migration targets.
 	 */
-	watermark = (order > PAGE_ALLOC_COSTLY_ORDER) ?
-				low_wmark_pages(zone) : min_wmark_pages(zone);
 	watermark += compact_gap(order);
+	if (order > PAGE_ALLOC_COSTLY_ORDER)
+		watermark += low_wmark_pages(zone) - min_wmark_pages(zone);
 	return __zone_watermark_ok(zone, 0, watermark, highest_zoneidx,
-				   ALLOC_CMA, wmark_target);
+				   ALLOC_CMA, free_pages);
 }
 
 /*
  * compaction_suitable: Is this suitable to run compaction on this zone now?
  */
-bool compaction_suitable(struct zone *zone, int order, int highest_zoneidx)
+bool compaction_suitable(struct zone *zone, int order, unsigned long watermark,
+			 int highest_zoneidx)
 {
 	enum compact_result compact_result;
 	bool suitable;
 
-	suitable = __compaction_suitable(zone, order, highest_zoneidx,
+	suitable = __compaction_suitable(zone, order, highest_zoneidx, watermark,
 					 zone_page_state(zone, NR_FREE_PAGES));
 	/*
 	 * fragmentation index determines if allocation failures are due to
@@ -2453,6 +2455,7 @@ bool compaction_suitable(struct zone *zone, int order, int highest_zoneidx)
 	return suitable;
 }
 
+/* Used by direct reclaimers */
 bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
 		int alloc_flags)
 {
@@ -2475,8 +2478,8 @@ bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
 		 */
 		available = zone_reclaimable_pages(zone) / order;
 		available += zone_page_state_snapshot(zone, NR_FREE_PAGES);
-		if (__compaction_suitable(zone, order, ac->highest_zoneidx,
-					  available))
+		if (__compaction_suitable(zone, order, min_wmark_pages(zone),
+					  ac->highest_zoneidx, available))
 			return true;
 	}
 
@@ -2513,13 +2516,13 @@ compaction_suit_allocation_order(struct zone *zone, unsigned int order,
 	 */
 	if (order > PAGE_ALLOC_COSTLY_ORDER && async &&
 	    !(alloc_flags & ALLOC_CMA)) {
-		watermark = low_wmark_pages(zone) + compact_gap(order);
-		if (!__zone_watermark_ok(zone, 0, watermark, highest_zoneidx,
-					   0, zone_page_state(zone, NR_FREE_PAGES)))
+		if (!__zone_watermark_ok(zone, 0, watermark + compact_gap(order),
+					 highest_zoneidx, 0,
+					 zone_page_state(zone, NR_FREE_PAGES)))
 			return COMPACT_SKIPPED;
 	}
 
-	if (!compaction_suitable(zone, order, highest_zoneidx))
+	if (!compaction_suitable(zone, order, watermark, highest_zoneidx))
 		return COMPACT_SKIPPED;
 
 	return COMPACT_CONTINUE;
@@ -3082,6 +3085,7 @@ static void kcompactd_do_work(pg_data_t *pgdat)
 		.mode = MIGRATE_SYNC_LIGHT,
 		.ignore_skip_hint = false,
 		.gfp_mask = GFP_KERNEL,
+		.alloc_flags = ALLOC_WMARK_MIN,
 	};
 	enum compact_result ret;
 
@@ -3100,7 +3104,7 @@ static void kcompactd_do_work(pg_data_t *pgdat)
 			continue;
 
 		ret = compaction_suit_allocation_order(zone,
-				cc.order, zoneid, ALLOC_WMARK_MIN,
+				cc.order, zoneid, cc.alloc_flags,
 				false);
 		if (ret != COMPACT_CONTINUE)
 			continue;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 2bc740637a6c..3370bdca6868 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -5890,12 +5890,15 @@ static inline bool should_continue_reclaim(struct pglist_data *pgdat,
 
 	/* If compaction would go ahead or the allocation would succeed, stop */
 	for_each_managed_zone_pgdat(zone, pgdat, z, sc->reclaim_idx) {
+		unsigned long watermark = min_wmark_pages(zone);
+
 		/* Allocation can already succeed, nothing to do */
-		if (zone_watermark_ok(zone, sc->order, min_wmark_pages(zone),
+		if (zone_watermark_ok(zone, sc->order, watermark,
 				      sc->reclaim_idx, 0))
 			return false;
 
-		if (compaction_suitable(zone, sc->order, sc->reclaim_idx))
+		if (compaction_suitable(zone, sc->order, watermark,
+					sc->reclaim_idx))
 			return false;
 	}
 
@@ -6122,22 +6125,21 @@ static inline bool compaction_ready(struct zone *zone, struct scan_control *sc)
 			      sc->reclaim_idx, 0))
 		return true;
 
-	/* Compaction cannot yet proceed. Do reclaim. */
-	if (!compaction_suitable(zone, sc->order, sc->reclaim_idx))
-		return false;
-
 	/*
-	 * Compaction is already possible, but it takes time to run and there
-	 * are potentially other callers using the pages just freed. So proceed
-	 * with reclaim to make a buffer of free pages available to give
-	 * compaction a reasonable chance of completing and allocating the page.
+	 * Direct reclaim usually targets the min watermark, but compaction
+	 * takes time to run and there are potentially other callers using the
+	 * pages just freed. So target a higher buffer to give compaction a
+	 * reasonable chance of completing and allocating the pages.
+	 *
 	 * Note that we won't actually reclaim the whole buffer in one attempt
 	 * as the target watermark in should_continue_reclaim() is lower. But if
 	 * we are already above the high+gap watermark, don't reclaim at all.
 	 */
-	watermark = high_wmark_pages(zone) + compact_gap(sc->order);
+	watermark = high_wmark_pages(zone);
+	if (compaction_suitable(zone, sc->order, watermark, sc->reclaim_idx))
+		return true;
 
-	return zone_watermark_ok_safe(zone, 0, watermark, sc->reclaim_idx);
+	return false;
 }
 
 static void consider_reclaim_throttle(pg_data_t *pgdat, struct scan_control *sc)
-- 
2.48.1


