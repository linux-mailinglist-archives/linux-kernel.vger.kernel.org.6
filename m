Return-Path: <linux-kernel+bounces-274836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87847947D64
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BCF01C21C9D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BD41552FF;
	Mon,  5 Aug 2024 14:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="niePIZ2o"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B23113C3F9
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 14:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722869992; cv=none; b=Jtib3ARgdYvkPNGyLxb7VGivroUe8E8x+yc2IYLw+0GbHKYJnqQwPwavgjZib5ei9xq5ppstQDEDoFzl1aGR3Az9xLdZoREtyAq8dh+rgmJN+pVziw6HR4BdIoD9ul4r5uH7pjEplwGb3HM/pRdz53yjhwojirYDG9djeaOWdnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722869992; c=relaxed/simple;
	bh=CYN1tKCYVanVKiVvnUFXLPkw+yb1l3W/6HydRlI1SRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EUopkqV6+nuNblqslYun1OjWHNBARQjTkbopNsDlHt//+/ZRK2ehOPBnf2QVISrftv1bl3fSez2bt4r0zddWfu/BaCT9q525+wmFvX5UsDVn2ets0np4/U6ZnC+3zb8wRtzqcsbszAX0NhBABybJzCgT9hvLwSvl3CsZaCzTnEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=niePIZ2o; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722869990; x=1754405990;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CYN1tKCYVanVKiVvnUFXLPkw+yb1l3W/6HydRlI1SRs=;
  b=niePIZ2oxWugCZe2+MILJ9NWNCmII25gj5Uqhb/SE+XRUXnwFQd33VqL
   6wADJ6i3MUkWGg/fwp17D5/LSivmsql6IJy4osfA7pofDZ1z2xeq9sdXm
   nDjRiYjPOc945QNZ7DiNXXPVPpo4Pz++z9/YSUr2lclzNaTJ/OrZIhq3W
   KvqJ7OHp76iA7NLSUbfweHSrjExx0hWYpEAWwUT8nextMyUEqh/AoV+wZ
   K+uGrOFT7emb+7Je+thQcKlWnHDhu5AZvPWmsftXO8XohtIOdMtsTEdH3
   SSowC5ttLTkTPkjpwNZfn/uYXOk3RgQvckPe1FW3RQW5Q3YHQuIKyJaRJ
   A==;
X-CSE-ConnectionGUID: EXCddbagSzeKdTGIOQ3JoA==
X-CSE-MsgGUID: oTb2PreCQE6buKcYnIe1vQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="31472749"
X-IronPort-AV: E=Sophos;i="6.09,264,1716274800"; 
   d="scan'208";a="31472749"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 07:59:50 -0700
X-CSE-ConnectionGUID: uU2CtQtHQ4iHzmZmtxQd1w==
X-CSE-MsgGUID: hxKVXcQ0SZuydzvDC0L52A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,264,1716274800"; 
   d="scan'208";a="56913231"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 05 Aug 2024 07:59:47 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 8F5F6628; Mon, 05 Aug 2024 17:59:45 +0300 (EEST)
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
Subject: [PATCH 4/8] mm: Rename accept_page() to accept_page_memory()
Date: Mon,  5 Aug 2024 17:59:36 +0300
Message-ID: <20240805145940.2911011-5-kirill.shutemov@linux.intel.com>
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

Rename the helper. The accept_page() name is going to be used for
different function.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 mm/page_alloc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a35efb114496..34718852d576 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -286,7 +286,7 @@ EXPORT_SYMBOL(nr_online_nodes);
 #endif
 
 static bool page_contains_unaccepted(struct page *page, unsigned int order);
-static void accept_page(struct page *page, unsigned int order);
+static void accept_page_memory(struct page *page, unsigned int order);
 static bool cond_accept_memory(struct zone *zone, unsigned int order);
 static inline bool has_unaccepted_memory(void);
 static bool __free_unaccepted(struct page *page);
@@ -1263,7 +1263,7 @@ void __meminit __free_pages_core(struct page *page, unsigned int order,
 		if (order == MAX_PAGE_ORDER && __free_unaccepted(page))
 			return;
 
-		accept_page(page, order);
+		accept_page_memory(page, order);
 	}
 
 	/*
@@ -6946,7 +6946,7 @@ static bool page_contains_unaccepted(struct page *page, unsigned int order)
 	return range_contains_unaccepted_memory(start, end);
 }
 
-static void accept_page(struct page *page, unsigned int order)
+static void accept_page_memory(struct page *page, unsigned int order)
 {
 	phys_addr_t start = page_to_phys(page);
 
@@ -6975,7 +6975,7 @@ static bool try_to_accept_memory_one(struct zone *zone)
 	__ClearPageUnaccepted(page);
 	spin_unlock_irqrestore(&zone->lock, flags);
 
-	accept_page(page, MAX_PAGE_ORDER);
+	accept_page_memory(page, MAX_PAGE_ORDER);
 
 	__free_pages_ok(page, MAX_PAGE_ORDER, FPI_TO_TAIL);
 
@@ -7047,7 +7047,7 @@ static bool page_contains_unaccepted(struct page *page, unsigned int order)
 	return false;
 }
 
-static void accept_page(struct page *page, unsigned int order)
+static void accept_page_memory(struct page *page, unsigned int order)
 {
 }
 
-- 
2.43.0


