Return-Path: <linux-kernel+bounces-274840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C42947D6E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B428A1C21E53
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B029E15B57C;
	Mon,  5 Aug 2024 14:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fmhMDzbF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F2C156F41
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 14:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722869994; cv=none; b=Nm5Z6nZzf2UDaG6bKjoVszngLMduZf6uf28Uegp7H10mmidjs6yN7kPY1HdIf1ftRrGJMYb0FuVPrsQxxY8LYoYuIrbVojpwcZEY4JUjzdKvzSP6N5HgDN3fYjwq4ZJHIvtDuLGItww1+bApDe8VZVtwouOW3SzD0nJheexbhyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722869994; c=relaxed/simple;
	bh=IxVAKdU9izhThF8isuGr3/jEPcqRjyFdz2CDFuPt25A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ldDdRD7v48GJkuLK6CFht4vzYVJP0PDXNt8kv/Mnn2uKJ+dVsTc/hlGblnhal1D/Pceludy6IrFMyJGbhC4BInMePc7v8IeQ5rP/U8TnQigZAlwZLCA1pHymrVQU6IGcZXDe1N7wB69DoTSndym/lN99TEXFCVYyvBfOvYS/M8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fmhMDzbF; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722869993; x=1754405993;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IxVAKdU9izhThF8isuGr3/jEPcqRjyFdz2CDFuPt25A=;
  b=fmhMDzbFnL8rHwjUZy0m1r9Hzn4hnY37fWkvQsgxW5E9OA1j3D4JCpP8
   lgPOZGWhTrDQAahuK5IFU22DZyjel79IM6Gl3hmgR4ew/a/cMyPW5daV2
   86mzfNrF2brdqGUwCm+k3STJNXTVbBPct+FTKOSRj0xMd6O0wSOW90535
   gX9nbwTUkUXxIiuohu2TWXb79KN+9Ag+fugSTzknEeSx1H6DuEHCwTs/A
   PH85Onu1qulMQXiMeqK+opwCJY2ZiZ4giz+XpNUpOG/PA723C3+3QKsAn
   ftHFnVTMVLCLW04AfWEWCkA8lvvcStzXRR4XzEGVHDJTbLIIGwmr27L0J
   A==;
X-CSE-ConnectionGUID: H0N/gi9hTESrds7iB3OimQ==
X-CSE-MsgGUID: dUElt27BRju9n3xNcZ0wpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="31472758"
X-IronPort-AV: E=Sophos;i="6.09,264,1716274800"; 
   d="scan'208";a="31472758"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 07:59:53 -0700
X-CSE-ConnectionGUID: 7+wbMWgwSIyNeiuHNZ+IcQ==
X-CSE-MsgGUID: mD8ejDxOS2mcd74mvgMbRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,264,1716274800"; 
   d="scan'208";a="56913243"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 05 Aug 2024 07:59:51 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 9939F640; Mon, 05 Aug 2024 17:59:45 +0300 (EEST)
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
Subject: [PATCH 5/8] mm: Add a helper to accept page
Date: Mon,  5 Aug 2024 17:59:37 +0300
Message-ID: <20240805145940.2911011-6-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240805145940.2911011-1-kirill.shutemov@linux.intel.com>
References: <20240805145940.2911011-1-kirill.shutemov@linux.intel.com>
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
---
 mm/internal.h   |  8 ++++++++
 mm/page_alloc.c | 53 +++++++++++++++++++++++++++++++++++--------------
 2 files changed, 46 insertions(+), 15 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index b4d86436565b..d358535f8a7e 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1578,4 +1578,12 @@ void unlink_file_vma_batch_init(struct unlink_vma_file_batch *);
 void unlink_file_vma_batch_add(struct unlink_vma_file_batch *, struct vm_area_struct *);
 void unlink_file_vma_batch_final(struct unlink_vma_file_batch *);
 
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
index 34718852d576..5f33e92b0a55 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6953,11 +6953,46 @@ static void accept_page_memory(struct page *page, unsigned int order)
 	accept_memory(start, start + (PAGE_SIZE << order));
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
+	accept_page_memory(page, MAX_PAGE_ORDER);
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
@@ -6967,20 +7002,8 @@ static bool try_to_accept_memory_one(struct zone *zone)
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
-	accept_page_memory(page, MAX_PAGE_ORDER);
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


