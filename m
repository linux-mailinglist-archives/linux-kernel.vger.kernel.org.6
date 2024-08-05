Return-Path: <linux-kernel+bounces-274841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FD6947D6F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3C6728375C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37A115B977;
	Mon,  5 Aug 2024 14:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AEQO/VV3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE0E158DCC
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 14:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722869995; cv=none; b=DSC1EOvR0ekYIalwtjXek2pgWSJ5UQgk3mP0PUyZ45XOpFhiT5aQKnqDZyTCf6FJiYzrZIxfPXRZMJZdW5GT9eDxchCU6JodUxLxF2CX0PD2CZHZCO/FIgRX3Vrl/I+7rCXZ1Y4F8romnqnXZuQ37dZcKm4cROdQ1+6Os80maX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722869995; c=relaxed/simple;
	bh=l0KMEXpzdLDtoI2/tzFTr7rANQva0av+agV+dlIXFcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IVxP36ode2aoU9JLYm3vf29tqSgbP2WvBzrsBwSiTcBCJlaOzh2l+XLZ389wc4A5q+Za10YUKGVgttJK20GcRXFTB0gVqOaCM63pHwOmxoCFtTq7I8ag2bmRjTqw4IdYL6jGEprKP+TqpaiSsR6+G5kAjXpDJC5y8fxrsTSS6xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AEQO/VV3; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722869994; x=1754405994;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l0KMEXpzdLDtoI2/tzFTr7rANQva0av+agV+dlIXFcU=;
  b=AEQO/VV3YhYAeTQOVd+jOawwIZd/OmVbWxEATAB074lL1mC7gWJGaBYU
   hvAa2hVFh/C6hA1qPBbL49P4IFNYUeTGKJPN2oPYq4qIbEAwbYfhGlN47
   WHTG2wobq6Y1okCm+7IlLkxXYts2Ww/0iYuCYqwnNint/VszYNc/Vd5A2
   N2qJQwt0tib5Y+DMOnU2M+kK/8xpRGajaUX8/wIYHBdb9VSrwuVURQJg1
   xvYeCsnDbrO72jpH84P1aPngXSWIhOv9LNTfS97nU7zTjfdflJtr3WlUa
   ih9zfLdheZL/OdIQncyZOPvGli3EM2n3vEjXnHGl+e2wEakZ6I8nF1Y63
   g==;
X-CSE-ConnectionGUID: puNrvoMuTYqcTKfeu9szOg==
X-CSE-MsgGUID: XxFsv/AhQ1CsgEqAeVcSvw==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="20980963"
X-IronPort-AV: E=Sophos;i="6.09,264,1716274800"; 
   d="scan'208";a="20980963"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 07:59:54 -0700
X-CSE-ConnectionGUID: WIo67eKrSgGxalNdG6yvhg==
X-CSE-MsgGUID: UGUbRBmzTOWsmfDpnnECFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,264,1716274800"; 
   d="scan'208";a="61157258"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 05 Aug 2024 07:59:51 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id BA8168F3; Mon, 05 Aug 2024 17:59:45 +0300 (EEST)
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
Subject: [PATCH 8/8] mm: Accept to promo watermark
Date: Mon,  5 Aug 2024 17:59:40 +0300
Message-ID: <20240805145940.2911011-9-kirill.shutemov@linux.intel.com>
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

Commit c574bbe91703 ("NUMA balancing: optimize page placement for memory
tiering system") introduced a new watermark above "high" -- "promo".

Accept memory memory to the highest watermark which is WMARK_PROMO now.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 mm/page_alloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 5f33e92b0a55..fcb15d0e7549 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7019,8 +7019,8 @@ static bool cond_accept_memory(struct zone *zone, unsigned int order)
 	if (list_empty(&zone->unaccepted_pages))
 		return false;
 
-	/* How much to accept to get to high watermark? */
-	to_accept = high_wmark_pages(zone) -
+	/* How much to accept to get to promo watermark? */
+	to_accept = promo_wmark_pages(zone) -
 		    (zone_page_state(zone, NR_FREE_PAGES) -
 		    __zone_watermark_unusable_free(zone, order, 0) -
 		    zone_page_state(zone, NR_UNACCEPTED));
-- 
2.43.0


