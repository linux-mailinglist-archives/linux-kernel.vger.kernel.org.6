Return-Path: <linux-kernel+bounces-274837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F34DB947D67
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D332B22199
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E83158DDF;
	Mon,  5 Aug 2024 14:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VL1Rkwrf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFB4142904
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 14:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722869993; cv=none; b=PdfEDpMDF2LQMQokM7koPkp3WEgy6RXAeYpCVisuGWTL4uhT07SxoZRVAND2YR+VB4txQMmUEepvuaNh16Qyd2TRsUg6az5gAiZ1cD/OTnZJD2mixV7QBdSU0GTKbTy7WKUtXUTJzbQl6k2TDo9yTcW+NdXzZtB09aFEAxgSBho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722869993; c=relaxed/simple;
	bh=Ni1u68tcCrDpDFX2jJrWgh2lUXexRhaqNdEAlro1U9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nvD77q6wPV31JMXDwH/bOWL6hBP+UWx+TE5Wvo4mXoDZrVTqiKIRC5T2+UQsYk8GUc6IqZ1BiVivoDpKFKlfchghvQkQgG86N5PYw/cfmko2XEAiCz1S9ZEXsOW5SOAROz2cFt7UEou2QyX5X6VEmQzuFf3oUeGQl53sU9BlNRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VL1Rkwrf; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722869992; x=1754405992;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ni1u68tcCrDpDFX2jJrWgh2lUXexRhaqNdEAlro1U9U=;
  b=VL1Rkwrf30xqLdIlY6IAT5eOELR5K/9t2SeOm6eGBxyZTp93KAx+uOrm
   kofeLbtDNncbYVbLRHhw6oxVPsGz51dKugFu6J+oL0gmuCQ+R1mi/dCO5
   v1gkj2DZsxtH03k8twAxA6T4w0om6A+Mn352BchxsTN3Cy2x2lPqXdKTK
   nwv17y2FuT1CCnhFQSA+gPp+UWmbZ74x9ckdTXjY+PE4wR00GCSLJ3PPd
   69MdddA4HJHZSgSSYnJA4Fas8AX/j1PI2rDqITl+Kbqrm38gHryIHfNV4
   eauyoQjAfSYa9TvlMDoH4JzSwlvF0EJzAA+iboeUr68bBOlbT3DUZWzGy
   g==;
X-CSE-ConnectionGUID: sZYrWFt3Q5e0fWN9E19YFA==
X-CSE-MsgGUID: kRKZcUUaRBu+9zK9i1kP3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="20980920"
X-IronPort-AV: E=Sophos;i="6.09,264,1716274800"; 
   d="scan'208";a="20980920"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 07:59:50 -0700
X-CSE-ConnectionGUID: EpZlzwukQHO/70HcLBnnoA==
X-CSE-MsgGUID: KEjXMtixTu6LFknu5rMdAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,264,1716274800"; 
   d="scan'208";a="61157246"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 05 Aug 2024 07:59:47 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 84FF257E; Mon, 05 Aug 2024 17:59:45 +0300 (EEST)
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
Subject: [PATCH 3/8] mm: Introduce PageUnaccepted() page type
Date: Mon,  5 Aug 2024 17:59:35 +0300
Message-ID: <20240805145940.2911011-4-kirill.shutemov@linux.intel.com>
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

The new page type allows physical memory scanners to detect unaccepted
memory and handle it accordingly.

The page type is serialized with zone lock.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 include/linux/page-flags.h | 3 +++
 mm/page_alloc.c            | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 5769fe6e4950..e19eac9c2b5c 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -943,6 +943,7 @@ enum pagetype {
 	PG_hugetlb	= 0x04000000,
 	PG_slab		= 0x02000000,
 	PG_zsmalloc	= 0x01000000,
+	PG_unaccepted	= 0x00800000,
 
 	PAGE_TYPE_BASE	= 0x80000000,
 
@@ -1076,6 +1077,8 @@ FOLIO_TEST_FLAG_FALSE(hugetlb)
 
 PAGE_TYPE_OPS(Zsmalloc, zsmalloc, zsmalloc)
 
+PAGE_TYPE_OPS(Unaccepted, unaccepted, unaccepted)
+
 /**
  * PageHuge - Determine if the page belongs to hugetlbfs
  * @page: The page to test.
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 90a1f01d5996..a35efb114496 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6972,6 +6972,7 @@ static bool try_to_accept_memory_one(struct zone *zone)
 
 	account_freepages(zone, -MAX_ORDER_NR_PAGES, MIGRATE_MOVABLE);
 	__mod_zone_page_state(zone, NR_UNACCEPTED, -MAX_ORDER_NR_PAGES);
+	__ClearPageUnaccepted(page);
 	spin_unlock_irqrestore(&zone->lock, flags);
 
 	accept_page(page, MAX_PAGE_ORDER);
@@ -7030,6 +7031,7 @@ static bool __free_unaccepted(struct page *page)
 	list_add_tail(&page->lru, &zone->unaccepted_pages);
 	account_freepages(zone, MAX_ORDER_NR_PAGES, MIGRATE_MOVABLE);
 	__mod_zone_page_state(zone, NR_UNACCEPTED, MAX_ORDER_NR_PAGES);
+	__SetPageUnaccepted(page);
 	spin_unlock_irqrestore(&zone->lock, flags);
 
 	if (first)
-- 
2.43.0


