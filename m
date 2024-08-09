Return-Path: <linux-kernel+bounces-280811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D86794CF82
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 13:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCA9D1F213CF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 11:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D1F19413F;
	Fri,  9 Aug 2024 11:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e6TSFpMw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0676B19309E
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 11:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723204153; cv=none; b=U8aO3wyO5kmGb9TLAvLEzddSyJI7Dc9TEocVg+4LJnpOVNOZ2BRbbCySvtZbqe63FLQMjMAKHPyhtLqY/ncdM1kzWwoi//Er4mVo3Z3iniYB923b6FioJa2ROhgFlYMR5/MVnmIoijvobCB91bt50GyhCUGoocDo6RqvAoyOiTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723204153; c=relaxed/simple;
	bh=tiHFKee3PrdQg/q59/O8kANn06DyhKlIl9RN3/Z3JdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dn+t4mNfqjFEWy1fA0ebUykdmyJ4GxlMIO/TIeCmfyIM4XZWDbJn7FxXwG6cgVqPkX+pChR4Udbzs5b8JSEihgluyAB+sHCG6v7j2He4IvLysEfGt0w+fVRppCplMmD7Mvca5mZgUtD+fXhg5e7/12Lb5m5n3JU4p+3taK8q768=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e6TSFpMw; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723204152; x=1754740152;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tiHFKee3PrdQg/q59/O8kANn06DyhKlIl9RN3/Z3JdM=;
  b=e6TSFpMws82C+DaYXOHM3FTw4Y+iFNXte4BNuBrbyM6UP7JHrrwOgSPT
   jCtMF6gKhlP7E3AWjDnPaNyAKcRhAcpiNfqaqzRBxPaEWqu4VSjOTTyyN
   5INcU3pr50r/cW/kE08yco/+P6S48bmtBwczjJOpgDDniiaLKUi1LZtCr
   8I1Iy0vihvEqhtU7iXBhKGKIfOAuoKsNUiODsxV5WVrXSVJBcd0JJC+R6
   7dLV2MEG2iE8Bw1xSJB3G5zGhtZppN0NW9AEPlGGjpG4z+VTZJ+qTBB5k
   +crLah4j95XXB+tTV1jUDsqvmO52YzlSJfz7Goj55O8XUYvCLYvIYv1Gd
   Q==;
X-CSE-ConnectionGUID: lmrNCFCJQ4m776HxDGmIYA==
X-CSE-MsgGUID: U8eNsVTCTNCcekPmARJtsQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="24280297"
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="24280297"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 04:49:10 -0700
X-CSE-ConnectionGUID: cW0eGtWmR0KLF4LZPKS19A==
X-CSE-MsgGUID: ti0C+JuCS1mYpXpUXFIYhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="57423599"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 09 Aug 2024 04:49:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 517609C0; Fri, 09 Aug 2024 14:49:02 +0300 (EEST)
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
Subject: [PATCHv2 4/8] mm: Introduce PageUnaccepted() page type
Date: Fri,  9 Aug 2024 14:48:50 +0300
Message-ID: <20240809114854.3745464-5-kirill.shutemov@linux.intel.com>
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

The new page type allows physical memory scanners to detect unaccepted
memory and handle it accordingly.

The page type is serialized with zone lock.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 include/linux/page-flags.h | 8 ++++++++
 mm/page_alloc.c            | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index a0a29bd092f8..17175a328e6b 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -939,6 +939,7 @@ enum pagetype {
 	PG_hugetlb	= 0x04000000,
 	PG_slab		= 0x02000000,
 	PG_zsmalloc	= 0x01000000,
+	PG_unaccepted	= 0x00800000,
 
 	PAGE_TYPE_BASE	= 0x80000000,
 
@@ -1072,6 +1073,13 @@ FOLIO_TEST_FLAG_FALSE(hugetlb)
 
 PAGE_TYPE_OPS(Zsmalloc, zsmalloc, zsmalloc)
 
+/*
+ * Mark pages that has to be accepted before touched for the first time.
+ *
+ * Serialized with zone lock.
+ */
+PAGE_TYPE_OPS(Unaccepted, unaccepted, unaccepted)
+
 /**
  * PageHuge - Determine if the page belongs to hugetlbfs
  * @page: The page to test.
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ed62ecd6775f..f4368c2fa395 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7008,6 +7008,7 @@ static bool try_to_accept_memory_one(struct zone *zone)
 
 	account_freepages(zone, -MAX_ORDER_NR_PAGES, MIGRATE_MOVABLE);
 	__mod_zone_page_state(zone, NR_UNACCEPTED, -MAX_ORDER_NR_PAGES);
+	__ClearPageUnaccepted(page);
 	spin_unlock_irqrestore(&zone->lock, flags);
 
 	accept_page(page, MAX_PAGE_ORDER);
@@ -7066,6 +7067,7 @@ static bool __free_unaccepted(struct page *page)
 	list_add_tail(&page->lru, &zone->unaccepted_pages);
 	account_freepages(zone, MAX_ORDER_NR_PAGES, MIGRATE_MOVABLE);
 	__mod_zone_page_state(zone, NR_UNACCEPTED, MAX_ORDER_NR_PAGES);
+	__SetPageUnaccepted(page);
 	spin_unlock_irqrestore(&zone->lock, flags);
 
 	if (first)
-- 
2.43.0


