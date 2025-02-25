Return-Path: <linux-kernel+bounces-530299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84085A431BF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 01:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3219617447E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 00:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CDA4C8E;
	Tue, 25 Feb 2025 00:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="mYGo+OtQ"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F50036D
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 00:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740442238; cv=none; b=fI9ljAItsIk6PuPhaVJn4zGw/k4gUQ6x0Oztx2AP/xdp6Q2Cbbtvue4vIlnGNzY+dfW/QEZ7h4qtVezk6LRr4wksYHa3roDuxHOQqO7FTWkdhwlPys7NvltbO8BHjcW2sRfPrYkAtpfIa3y5x+KtsgvisugILXbgrCXNt+HwE4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740442238; c=relaxed/simple;
	bh=dzh9En4UkKwYrVaxUww9kNyMQJhaqTBw63J9KDBkO1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fhD4mI0b32oHQZ5uD1uvjSH7th6t55rlrau/OeF6M2ZFueYrybKY0kY4sBIB/swWV1HlKuRI0NmesDquPCs0PvR2K0Yd69Ap1AXwRIrlSmQncsMy2cYLh+fh0Q6xGV3KUOFWFrolhfmvJ8gqCc2tUF1pzy3UigAjYOmzdahUl7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=mYGo+OtQ; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c089b2e239so531704385a.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 16:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1740442235; x=1741047035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m4nVpOQMfdjSDVLItpR5dEn5Uy7LgPPGmplcVb1mIdw=;
        b=mYGo+OtQisgNhLJt+5xvOmo+BDS+u2SYjt0xIaHnNPbtrk3UPgrbrqvzzFbNCMLLFR
         Zc0uOjJBM8JqZzMZb+EI5vw1ND1Dani2oq1G/NKyANywGn9NQIAXC9jllxOU3ieUSFBd
         yKoc3A49zVRLOfvUlEvrX6KvGtRQ/kWZQx49u+Ddlm2obJ+suYKya7nPZ20M2IZ4iCRB
         MNogsfrvvAHb9XZlDxbDTWngBx2quUT2KAKKAix5KE7bL6R97DL55oKSa/TVOLOyL1CT
         su4U9m9/PiRDLFGh8cVOuqx//J1739IrODNiFabIi5MFLWCqCV9q9q5dhCnotTEJiiwn
         Daxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740442235; x=1741047035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m4nVpOQMfdjSDVLItpR5dEn5Uy7LgPPGmplcVb1mIdw=;
        b=KpGjFfWUXUltXOaC+8zMwWNtsIrO58ci8a+ScVGTzB0r4jG3Z1dKi2hxtHHQc2vdLp
         GOYnLSi/J1re0jMYy+TOITYIO7yppp3nNcwI/nAaepcMBmuJCBqHO9+0oTWZNagGYCcU
         VpCT9tnoskwNpyNtP2yNEdscWEV6xaQKNoby3n34WyY5I0+lmqzgWZXVmhcFWiPFgJyO
         Vpuv4NM7YRyzmETCABGmqdVaCnz3rfHxiuaiYdd1B/fKpopplJQRP7rDZAGsjKr40UoD
         4ySPzTXvQP1DGUDUgb8GlPjnQ1TJPDvzi9vc95yrSveRGCnggXgB33ElpcuiEd4Z210U
         cEaw==
X-Forwarded-Encrypted: i=1; AJvYcCUYx8n1ahzhoKhry2rnEErmq23Taq0hNi0aj/xbqOWl9VqXVJQUbAUMzout8uc66zuZqGVOkuY8Xc953hI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoCsJlqW2UAi26FzshEwBO+RX3Hw3nSYnFYKGn92epOAzkWyz+
	pxbUHQeW61OSaWIVU7qaJPklimsyAfHivYxRhheVTE2qLGX4RU7m2x0/ujstkNM=
X-Gm-Gg: ASbGncvWPQs/VtAqBCnbjlBR/bCwkY3ChHOcb8l+9C6qJqp2xPtDJrv2bKuybEXnejC
	7NFbe7ILsNr4VgF+PVSlGWlYm1H8EAhrTgY5K5HnRXT+V6WqOU6OpSaylTau3oR+RP21cp1UoHN
	E9HjK0wzvhUBY1zFkTwxki0+rKmlFLBIv1dkha4WUISkv2vmaUqFx+k987mT5AYE/QlrTp4jkl3
	K3DUJi8DYHZNGixmZ9GWyg88aWAqQbEOYz0qM3jaMb+P67n8eULsujj8VVopEht4cDZjDTSzzBj
	XfoyJimqA8IVJeiaOy9pErfJ
X-Google-Smtp-Source: AGHT+IGoJS6Omh/ikKjODCsa7sYHe0e2NcEJ5qqBqC2I0BPARGB9vb4PzMba6XBAw4fGsuwISK59Ag==
X-Received: by 2002:a05:620a:4621:b0:7be:73f6:9e86 with SMTP id af79cd13be357-7c0c227c72dmr2463429485a.20.1740442235091;
        Mon, 24 Feb 2025 16:10:35 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6e87b06dd05sm3185086d6.8.2025.02.24.16.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 16:10:34 -0800 (PST)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Brendan Jackman <jackmanb@google.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] mm: page_alloc: remove remnants of unlocked migratetype updates
Date: Mon, 24 Feb 2025 19:08:25 -0500
Message-ID: <20250225001023.1494422-3-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250225001023.1494422-1-hannes@cmpxchg.org>
References: <20250225001023.1494422-1-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The freelist hygiene patches made migratetype accesses fully protected
under the zone->lock. Remove remnants of handling the race conditions
that existed before from the MIGRATE_HIGHATOMIC code.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/page_alloc.c | 50 ++++++++++++++++---------------------------------
 1 file changed, 16 insertions(+), 34 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 9ea14ec52449..53d315aa69c4 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1991,20 +1991,10 @@ static inline bool boost_watermark(struct zone *zone)
 static struct page *
 try_to_steal_block(struct zone *zone, struct page *page,
 		   int current_order, int order, int start_type,
-		   unsigned int alloc_flags)
+		   int block_type, unsigned int alloc_flags)
 {
 	int free_pages, movable_pages, alike_pages;
 	unsigned long start_pfn;
-	int block_type;
-
-	block_type = get_pageblock_migratetype(page);
-
-	/*
-	 * This can happen due to races and we want to prevent broken
-	 * highatomic accounting.
-	 */
-	if (is_migrate_highatomic(block_type))
-		return NULL;
 
 	/* Take ownership for orders >= pageblock_order */
 	if (current_order >= pageblock_order) {
@@ -2179,33 +2169,22 @@ static bool unreserve_highatomic_pageblock(const struct alloc_context *ac,
 		spin_lock_irqsave(&zone->lock, flags);
 		for (order = 0; order < NR_PAGE_ORDERS; order++) {
 			struct free_area *area = &(zone->free_area[order]);
-			int mt;
+			unsigned long size;
 
 			page = get_page_from_free_area(area, MIGRATE_HIGHATOMIC);
 			if (!page)
 				continue;
 
-			mt = get_pageblock_migratetype(page);
 			/*
-			 * In page freeing path, migratetype change is racy so
-			 * we can counter several free pages in a pageblock
-			 * in this loop although we changed the pageblock type
-			 * from highatomic to ac->migratetype. So we should
-			 * adjust the count once.
+			 * It should never happen but changes to
+			 * locking could inadvertently allow a per-cpu
+			 * drain to add pages to MIGRATE_HIGHATOMIC
+			 * while unreserving so be safe and watch for
+			 * underflows.
 			 */
-			if (is_migrate_highatomic(mt)) {
-				unsigned long size;
-				/*
-				 * It should never happen but changes to
-				 * locking could inadvertently allow a per-cpu
-				 * drain to add pages to MIGRATE_HIGHATOMIC
-				 * while unreserving so be safe and watch for
-				 * underflows.
-				 */
-				size = max(pageblock_nr_pages, 1UL << order);
-				size = min(size, zone->nr_reserved_highatomic);
-				zone->nr_reserved_highatomic -= size;
-			}
+			size = max(pageblock_nr_pages, 1UL << order);
+			size = min(size, zone->nr_reserved_highatomic);
+			zone->nr_reserved_highatomic -= size;
 
 			/*
 			 * Convert to ac->migratetype and avoid the normal
@@ -2217,10 +2196,12 @@ static bool unreserve_highatomic_pageblock(const struct alloc_context *ac,
 			 * may increase.
 			 */
 			if (order < pageblock_order)
-				ret = move_freepages_block(zone, page, mt,
+				ret = move_freepages_block(zone, page,
+							   MIGRATE_HIGHATOMIC,
 							   ac->migratetype);
 			else {
-				move_to_free_list(page, zone, order, mt,
+				move_to_free_list(page, zone, order,
+						  MIGRATE_HIGHATOMIC,
 						  ac->migratetype);
 				change_pageblock_range(page, order,
 						       ac->migratetype);
@@ -2294,7 +2275,8 @@ __rmqueue_fallback(struct zone *zone, int order, int start_migratetype,
 
 		page = get_page_from_free_area(area, fallback_mt);
 		page = try_to_steal_block(zone, page, current_order, order,
-					  start_migratetype, alloc_flags);
+					  start_migratetype, fallback_mt,
+					  alloc_flags);
 		if (page)
 			goto got_one;
 	}
-- 
2.48.1


