Return-Path: <linux-kernel+bounces-434778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 393329E6B35
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 11:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF4C7284120
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DDA1FBCAC;
	Fri,  6 Dec 2024 10:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ORsI0wLg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5E31FA165
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 10:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733479204; cv=none; b=ugipzhCKfk8SuJumZOQFAjwQoeBC5IC/RN8PhYg9LG0ik0zgmIOhtyp3ST9irYwZEmzc1m1GHgeqiGWPZ+eDUMXfd4RYD8aEfeivtvHI9Pn0JGwZciInD7E+sWvp6n0AbLr4hPXnGoOFgWbhQEUxTaUU3IWTyWxtHJdqpsaHMJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733479204; c=relaxed/simple;
	bh=pjIRO/Y7PrYFo3jwVppsJYXQAqZQuh3fOfMXy7mxQag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S/W1Y9dkcLE2dyxLhxl5wdlszPivBNInH1ZWrO6EdVHLHXichL9WbrfPC2t8BzvPnr3frqtSxkXgEnXy0VrPoAE7ugqwBm+P5JKf2PG0huTIkjZ1+CdLEcHMNzi2+IRm/6hoFnVno9OR+e9J/4VdxYFX6cl3pIPd31vFn/3CyCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ORsI0wLg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733479201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OHFxPv9O3q7cC5DJx/fwSJeTT3u7bfbiSrofwZ2W0U4=;
	b=ORsI0wLgOmTqR5VfiK/XzRIXA8BP48tNylwi0MQEbPGeW/Q40yKMY+idjSr7mMc02T44xS
	eO5dn4kO0rXBbx0XXsLlZuUPxed3PlBiAqgjWi0vipek4TSd9N1uPMk2U/GUxwWkjefK+4
	e1XGdEx2Ituj3pFagbmYhRunIGojFc0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-s5u-IjJBNY6UVJ6ytmW9Vw-1; Fri, 06 Dec 2024 04:59:59 -0500
X-MC-Unique: s5u-IjJBNY6UVJ6ytmW9Vw-1
X-Mimecast-MFC-AGG-ID: s5u-IjJBNY6UVJ6ytmW9Vw
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-385fdff9db5so936191f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 01:59:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733479198; x=1734083998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OHFxPv9O3q7cC5DJx/fwSJeTT3u7bfbiSrofwZ2W0U4=;
        b=rh5dKEdTBwMCab8DQ4eGxYDO1/u0TMvwecJqs3jNsj/uEnIFmqXrPxkrITDAcxzXCv
         uUqEgYOHva1Z/4SmhRkNIHFy8GbNBpCUi+HJG+mlpxAN3oOMoOJmY08B+cHLjxy8MCXy
         zw0swv5qSEpVf2lXSMdpGQRBIWAQXa+ZzRpn40nCQw6Dk9uGnOUjCzRs2WuyOlT+iFw4
         Y5+ZvzalgimxfrmQMP+0ykcD4UjHe/p1vFQYjXowco1F7IYPXMnD5NF1Hj3coXkFHDvE
         JUCKAN8hEfH8ZpUenoKYElKS6n5DSH9UrX9Ga+GYC0NPJi5mc52/5Td8BoKJrrQV3GJP
         G24g==
X-Gm-Message-State: AOJu0Yxd3PlnnRXbHvYwWJoxk4iWBxkaeNJtT6fg9d8+XdGTWOzWwRjh
	mSzrHXeKW2DK4Oc4WbCDlKCb1i8XIMi0+0r4mGo5yU3zymXLnvLBH5924/TXNOu7GZk/N2sPBxu
	PvnsCcYRQTorKOgKyLpZi1nz0+Yw0IVWomHivLxTh1gvOs6qRcGmMr3pSgtWmCzkEzFI+uQe7mT
	IDSPWASH/whr6Ke8k3nKimGCBJHGSW0tM1TaIxtleHyA1q
X-Gm-Gg: ASbGncsErfAkfCiAH8CuE23VYNuVp1feH200ZJxzoab27TY0YkTEWSMKLeXyXSWU/0Y
	qPmr42WUAYuExuysF3Hs84uwNqOyrsUv9XKwex+ceSh//vidYpIEDrb6NJsfQ21qVIqRD+gIGoX
	BLzNyibjiyGnNlSXKVGx+I7h4OHxYIkYYw9l7anPJkVdVpxDUUcbnExH6EmtUZnW1OSZn2QF1BI
	Es7oo89zIfkfBwbewy7vtDOwBSEcgVo+0wh/0fMxqVvkZXoredVOBkRcx9kEgEXMa5fbeOkQ4dX
	lA3xpFE4gRNydevLtKfmBqv9ijVx3su/TIk=
X-Received: by 2002:a05:600c:470b:b0:431:52cc:877e with SMTP id 5b1f17b1804b1-434ddecfed2mr18057195e9.20.1733479198262;
        Fri, 06 Dec 2024 01:59:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFe5tufop43b05VWxmmjhji+VfNWJUbfs4BReG0q0hG+8wMTpPLAIMsOI9sLBE+lqFnBAZ94w==
X-Received: by 2002:a05:600c:470b:b0:431:52cc:877e with SMTP id 5b1f17b1804b1-434ddecfed2mr18056965e9.20.1733479197845;
        Fri, 06 Dec 2024 01:59:57 -0800 (PST)
Received: from localhost (p200300cbc71bd0001d1f238eaeafdbf7.dip0.t-ipconnect.de. [2003:cb:c71b:d000:1d1f:238e:aeaf:dbf7])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-434d5273199sm88616395e9.14.2024.12.06.01.59.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 01:59:56 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Zi Yan <ziy@nvidia.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Yu Zhao <yuzhao@google.com>
Subject: [PATCH v1 1/2] mm/page_alloc: conditionally split > pageblock_order pages in free_one_page() and move_freepages_block_isolate()
Date: Fri,  6 Dec 2024 10:59:50 +0100
Message-ID: <20241206095951.98007-2-david@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241206095951.98007-1-david@redhat.com>
References: <20241206095951.98007-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's special-case for the common scenarios that:

(a) We are freeing pages <= pageblock_order
(b) We are freeing a page <= MAX_PAGE_ORDER and all pageblocks match
    (especially, no mixture of isolated and non-isolated pageblocks)

When we encounter a > MAX_PAGE_ORDER page, it can only come from
alloc_contig_range(), and we can process MAX_PAGE_ORDER chunks.

When we encounter a >pageblock_order <= MAX_PAGE_ORDER page,
check whether all pageblocks match, and if so (common case), don't
split them up just for the buddy to merge them back.

This makes sure that when we free MAX_PAGE_ORDER chunks to the buddy,
for example during system startups, memory onlining, or when isolating
consecutive pageblocks via alloc_contig_range()/memory offlining, that
we don't unnecessarily split up what we'll immediately merge again,
because the migratetypes match.

Rename split_large_buddy() to __free_one_page_maybe_split(), to make it
clearer what's happening, and handle in it only natural buddy orders,
not the alloc_contig_range(__GFP_COMP) special case: handle that in
free_one_page() only.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/page_alloc.c | 71 +++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 57 insertions(+), 14 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 48a291c485df4..ad19758a7779f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1225,24 +1225,50 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 	spin_unlock_irqrestore(&zone->lock, flags);
 }
 
-/* Split a multi-block free page into its individual pageblocks. */
-static void split_large_buddy(struct zone *zone, struct page *page,
-			      unsigned long pfn, int order, fpi_t fpi)
+static bool pfnblock_migratetype_equal(unsigned long pfn,
+		unsigned long end_pfn, int mt)
 {
-	unsigned long end = pfn + (1 << order);
+	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | end_pfn, pageblock_nr_pages));
 
+	while (pfn != end_pfn) {
+		struct page *page = pfn_to_page(pfn);
+
+		if (unlikely(mt != get_pfnblock_migratetype(page, pfn)))
+			return false;
+		pfn += pageblock_nr_pages;
+	}
+	return true;
+}
+
+static void __free_one_page_maybe_split(struct zone *zone, struct page *page,
+		unsigned long pfn, int order, fpi_t fpi_flags)
+{
+	const unsigned long end_pfn = pfn + (1 << order);
+	int mt = get_pfnblock_migratetype(page, pfn);
+
+	VM_WARN_ON_ONCE(order > MAX_PAGE_ORDER);
 	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn, 1 << order));
 	/* Caller removed page from freelist, buddy info cleared! */
 	VM_WARN_ON_ONCE(PageBuddy(page));
 
-	if (order > pageblock_order)
-		order = pageblock_order;
-
-	while (pfn != end) {
-		int mt = get_pfnblock_migratetype(page, pfn);
+	/*
+	 * With CONFIG_MEMORY_ISOLATION, we might be freeing MAX_ORDER_NR_PAGES
+	 * pages that cover pageblocks with different migratetypes; for example
+	 * only some migratetypes might be MIGRATE_ISOLATE. In that (unlikely)
+	 * case, fallback to freeing individual pageblocks so they get put
+	 * onto the right lists.
+	 */
+	if (!IS_ENABLED(CONFIG_MEMORY_ISOLATION) ||
+	    likely(order <= pageblock_order) ||
+	    pfnblock_migratetype_equal(pfn + pageblock_nr_pages, end_pfn, mt)) {
+		__free_one_page(page, pfn, zone, order, mt, fpi_flags);
+		return;
+	}
 
-		__free_one_page(page, pfn, zone, order, mt, fpi);
-		pfn += 1 << order;
+	while (pfn != end_pfn) {
+		mt = get_pfnblock_migratetype(page, pfn);
+		__free_one_page(page, pfn, zone, pageblock_order, mt, fpi_flags);
+		pfn += pageblock_nr_pages;
 		page = pfn_to_page(pfn);
 	}
 }
@@ -1254,7 +1280,24 @@ static void free_one_page(struct zone *zone, struct page *page,
 	unsigned long flags;
 
 	spin_lock_irqsave(&zone->lock, flags);
-	split_large_buddy(zone, page, pfn, order, fpi_flags);
+	if (likely(order <= MAX_PAGE_ORDER)) {
+		__free_one_page_maybe_split(zone, page, pfn, order, fpi_flags);
+	} else if (IS_ENABLED(CONFIG_CONTIG_ALLOC)) {
+		const unsigned long end_pfn = pfn + (1 << order);
+
+		/*
+		 * The only way we can end up with order > MAX_PAGE_ORDER is
+		 * through alloc_contig_range(__GFP_COMP).
+		 */
+		while (pfn != end_pfn) {
+			__free_one_page_maybe_split(zone, page, pfn,
+						    MAX_PAGE_ORDER, fpi_flags);
+			pfn += MAX_ORDER_NR_PAGES;
+			page = pfn_to_page(pfn);
+		}
+	} else {
+		WARN_ON_ONCE(1);
+	}
 	spin_unlock_irqrestore(&zone->lock, flags);
 
 	__count_vm_events(PGFREE, 1 << order);
@@ -1790,7 +1833,7 @@ bool move_freepages_block_isolate(struct zone *zone, struct page *page,
 		del_page_from_free_list(buddy, zone, order,
 					get_pfnblock_migratetype(buddy, pfn));
 		set_pageblock_migratetype(page, migratetype);
-		split_large_buddy(zone, buddy, pfn, order, FPI_NONE);
+		__free_one_page_maybe_split(zone, buddy, pfn, order, FPI_NONE);
 		return true;
 	}
 
@@ -1801,7 +1844,7 @@ bool move_freepages_block_isolate(struct zone *zone, struct page *page,
 		del_page_from_free_list(page, zone, order,
 					get_pfnblock_migratetype(page, pfn));
 		set_pageblock_migratetype(page, migratetype);
-		split_large_buddy(zone, page, pfn, order, FPI_NONE);
+		__free_one_page_maybe_split(zone, page, pfn, order, FPI_NONE);
 		return true;
 	}
 move:
-- 
2.47.1


