Return-Path: <linux-kernel+bounces-280815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6688694CF88
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 13:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F403BB2297A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 11:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3621C194C6C;
	Fri,  9 Aug 2024 11:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g85mnHiB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEB3192B9F
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 11:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723204157; cv=none; b=pAz5Gn4Wf9iIGPrG8+XdUOI5kL6RHCIcdTw0IpZ+ljTdwzablKRYyukk0ecmHTP4Vdl17za3NLammkdlsrw/igjo/Nqw19bn+9E27XWtxCMV0mxpqB388urdPaBJyHeSKnUuXlMUxYdzxKatUIVJgD58V6615WiEF1WBZ1dbNxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723204157; c=relaxed/simple;
	bh=ILver/yjQFclHBCvNLc3z4GjK/nbM+kDF5WFxwHYofI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RbHbpfcZzD/Weil/bm5XhX7DdOBgLyVDXkSNT793bvrakb32y9yrnsVT07VAegaI2Syc4ZUKpeb1jeveMaCa7EzMsOvNhLgl7sdpcCLsPpM2imreKpi0R9GCXtz+Q3o+HEnHayYVSraniary6FND2PXlpZsz48x+OmJt/Zsxp1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g85mnHiB; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723204156; x=1754740156;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ILver/yjQFclHBCvNLc3z4GjK/nbM+kDF5WFxwHYofI=;
  b=g85mnHiBzs05n7S66jRLg1V/e1s5mjTZVfrf/h7b0ps9PWzJ+e3D88c9
   JROqYDOEfYNhxhBDscMPLna0zgbbKmIy//XRxI/TMS7VOEzK/mV7Ta3FC
   cdm4v3QKRsW5Zpr2IKF67FUd+1gQowDjKp+fNYSf8rF44BNyuwAogAwEv
   z7PMcnpS0DothF8H/Cr+RIXg4ngVTrECJhbRB1oxQJK9pJBcETAQSDi2L
   PIDVqErIOZoMHouin1FTchY2VZQXwD3tO5LM3l/hnFpqatt+I8kss2tWE
   Vlz6eHKUbrz2zbRlRNCbnlkRr/mjcn54VQWPKQjAHx3GtW75hOzvHZOkP
   w==;
X-CSE-ConnectionGUID: mRO+uun/S2qf1OrhWEtWPQ==
X-CSE-MsgGUID: T+ztNsdRTCmH74M35Iy65w==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="24280359"
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="24280359"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 04:49:14 -0700
X-CSE-ConnectionGUID: 4fzhaZ4JR7yaZMFTdxS2Bg==
X-CSE-MsgGUID: I64npLpmRJC+ZULq1pND6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="57423633"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 09 Aug 2024 04:49:10 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 726E7A56; Fri, 09 Aug 2024 14:49:02 +0300 (EEST)
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
Subject: [PATCHv2 7/8] mm: page_isolation: Handle unaccepted memory isolation
Date: Fri,  9 Aug 2024 14:48:53 +0300
Message-ID: <20240809114854.3745464-8-kirill.shutemov@linux.intel.com>
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

Page isolation machinery doesn't know anything about unaccepted memory
and considers it non-free. It leads to alloc_contig_pages() failure.

Treat unaccepted memory as free and accept memory on pageblock
isolation. Once memory is accepted it becomes PageBuddy() and page
isolation knows how to deal with them.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 mm/page_isolation.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 042937d5abe4..39fb8c07aeb7 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -152,6 +152,9 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
 	unsigned long flags;
 	unsigned long check_unmovable_start, check_unmovable_end;
 
+	if (PageUnaccepted(page))
+		accept_page(page);
+
 	spin_lock_irqsave(&zone->lock, flags);
 
 	/*
@@ -367,6 +370,11 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
 		VM_BUG_ON(!page);
 		pfn = page_to_pfn(page);
 
+		if (PageUnaccepted(page)) {
+			pfn += MAX_ORDER_NR_PAGES;
+			continue;
+		}
+
 		if (PageBuddy(page)) {
 			int order = buddy_order(page);
 
-- 
2.43.0


