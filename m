Return-Path: <linux-kernel+bounces-280812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A040594CF84
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 13:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C52A81C21858
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 11:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15F5194ACA;
	Fri,  9 Aug 2024 11:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XpY5q/lv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946D0192B8A
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 11:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723204156; cv=none; b=X6yaG8lkZOyrH4scs1TyDh/I7IlUyIpE3IxH2WVb6P7nQKQE6/SoXjztMiHKNYj01891mtsGcDbrjZmATjX5jubNXD7oCYlj73H3O+/g5jHLfkV31zXLihE2Hv3rnBkPVTEIxoX0pExAMQP7jWoq/YNNbSia0H9sv5H9DZMANr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723204156; c=relaxed/simple;
	bh=SzZoS9g7jt+luDGgY5b8GrGZZk7RG0DnODBwUGbdsd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T7bPC7z/ZhQIdPVpUzwkil/cVSgWCHssPGPzYcs2423a52j8actNwxjGzAnwj/YX8bgp9yEQAtkXd2IFWKGhA6khBbn1y/Y7Hw5FYnxWOMlqlVrd5wtPMQYlTOyMgvnBKH6Pk0VZYaQBSYq6j4Ppa2ZPKgb/2nSgBtlkWOb63U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XpY5q/lv; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723204155; x=1754740155;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SzZoS9g7jt+luDGgY5b8GrGZZk7RG0DnODBwUGbdsd4=;
  b=XpY5q/lvLIfXTa6Wjfk0fuBdqvwY/gJHiwVKToKC7D9oHS0WuvvBN1Vc
   q9MvWq719FtxPnM8FliYTjTB/UeaEkdr5HBdnzPIbJvfHcWIkUTQup6wq
   zevXzTHRAKx7edtdR8iXP95x35U/OmDc/i33quBCAAI5JyDR6g/iujkIH
   dk/mzpaZpzqyySN+OIpFuVpEfaTuFqW4GKBAXuMaEF4AdnheAe71ENXdg
   qp4m3zjVOomXj5wyWAZXjLlOQA0wiP9jTFqozd2yKCY4bbyVKCnaN71zX
   Bv12LdJx/zl4M8V5rBNqunQJjps5tnXzNR75hbPwYFKH065dJQm2mDJSe
   w==;
X-CSE-ConnectionGUID: 1BxHH9LhQv+r+4stuSyOtw==
X-CSE-MsgGUID: P1JkqN6yQACHvMeTZg7Q/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="24280336"
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="24280336"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 04:49:12 -0700
X-CSE-ConnectionGUID: qoa/OEsTQqCUYKdEPPPs8A==
X-CSE-MsgGUID: RsezZjkdSHGI0vZgO7toSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="57423606"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 09 Aug 2024 04:49:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 6624DA14; Fri, 09 Aug 2024 14:49:02 +0300 (EEST)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Mel Gorman <mgorman@suse.de>,
	Vlastimil Babka <vbabka@suse.cz>
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
	Mike Rapoport <rppt@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv2 6/8] mm: Add a helper to accept page
Date: Fri,  9 Aug 2024 14:48:52 +0300
Message-ID: <20240809114854.3745464-7-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240809114854.3745464-1-kirill.shutemov@linux.intel.com>
References: <20240809114854.3745464-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Accept a given struct page and add it free list.

The help is useful for physical memory scanners that want to use free
unaccepted memory.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 mm/internal.h   |  8 ++++++++
 mm/page_alloc.c | 53 +++++++++++++++++++++++++++++++++++--------------
 2 files changed, 46 insertions(+), 15 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 1159b04e76a3..ff47d57733ad 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1431,4 +1431,12 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 	unsigned long new_addr, unsigned long len,
 	bool need_rmap_locks, bool for_stack);
 
+#ifdef CONFIG_UNACCEPTED_MEMORY
+void accept_page(struct page *page);
+#else /* CONFIG_UNACCEPTED_MEMORY */
+static inline void accept_page(struct page *page)
+{
+}
+#endif /* CONFIG_UNACCEPTED_MEMORY */
+
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e7e304d9e739..f0610c691ae5 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6980,11 +6980,46 @@ static bool page_contains_unaccepted(struct page *page, unsigned int order)
 	return range_contains_unaccepted_memory(start, PAGE_SIZE << order);
 }
 
+static void __accept_page(struct zone *zone, unsigned long *flags,
+			  struct page *page)
+{
+	bool last;
+
+	list_del(&page->lru);
+	last = list_empty(&zone->unaccepted_pages);
+
+	account_freepages(zone, -MAX_ORDER_NR_PAGES, MIGRATE_MOVABLE);
+	__mod_zone_page_state(zone, NR_UNACCEPTED, -MAX_ORDER_NR_PAGES);
+	__ClearPageUnaccepted(page);
+	spin_unlock_irqrestore(&zone->lock, *flags);
+
+	accept_memory(page_to_phys(page), PAGE_SIZE << MAX_PAGE_ORDER);
+
+	__free_pages_ok(page, MAX_PAGE_ORDER, FPI_TO_TAIL);
+
+	if (last)
+		static_branch_dec(&zones_with_unaccepted_pages);
+}
+
+void accept_page(struct page *page)
+{
+	struct zone *zone = page_zone(page);
+	unsigned long flags;
+
+	spin_lock_irqsave(&zone->lock, flags);
+	if (!PageUnaccepted(page)) {
+		spin_unlock_irqrestore(&zone->lock, flags);
+		return;
+	}
+
+	/* Unlocks zone->lock */
+	__accept_page(zone, &flags, page);
+}
+
 static bool try_to_accept_memory_one(struct zone *zone)
 {
 	unsigned long flags;
 	struct page *page;
-	bool last;
 
 	spin_lock_irqsave(&zone->lock, flags);
 	page = list_first_entry_or_null(&zone->unaccepted_pages,
@@ -6994,20 +7029,8 @@ static bool try_to_accept_memory_one(struct zone *zone)
 		return false;
 	}
 
-	list_del(&page->lru);
-	last = list_empty(&zone->unaccepted_pages);
-
-	account_freepages(zone, -MAX_ORDER_NR_PAGES, MIGRATE_MOVABLE);
-	__mod_zone_page_state(zone, NR_UNACCEPTED, -MAX_ORDER_NR_PAGES);
-	__ClearPageUnaccepted(page);
-	spin_unlock_irqrestore(&zone->lock, flags);
-
-	accept_memory(page_to_phys(page), PAGE_SIZE << MAX_PAGE_ORDER);
-
-	__free_pages_ok(page, MAX_PAGE_ORDER, FPI_TO_TAIL);
-
-	if (last)
-		static_branch_dec(&zones_with_unaccepted_pages);
+	/* Unlocks zone->lock */
+	__accept_page(zone, &flags, page);
 
 	return true;
 }
-- 
2.43.0


