Return-Path: <linux-kernel+bounces-274842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE6F947D70
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 994341F21F78
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADFA149000;
	Mon,  5 Aug 2024 14:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NTwN5PM9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FFE15AD9E
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 14:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722869995; cv=none; b=tgUgUeSDD4Wjp1eB9gzq3XgQAdiUw8RfKVxUPf0gv8P9bCBPVCI0T6fUWrwsZJ7wdBlFJXfUHRvZCLSjqzytCEvLYpahbnPIrtpw2xrAdEYycfjb2Ol9Domr9xfhrfrFw8HNO0pxgTelUJQdCzeKrWJpGcpeB2ZrxxuFu9SqlEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722869995; c=relaxed/simple;
	bh=ILver/yjQFclHBCvNLc3z4GjK/nbM+kDF5WFxwHYofI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sNVp5Jot0zB2fKsurHwhcgL0BwjhCEFGfD7tijqEs5DVDDMfYVbcxNLaWA0SDnBnqbQwlakQpjyu/iCXtK8KLKPEcr3epX9ClUzFVNe4QIulQn93kXNLnPrYVuXLiN3lL9hmt8i7r0gVdxid3XOp+ouYrBLNAH8gS1w1Jd6nlJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NTwN5PM9; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722869994; x=1754405994;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ILver/yjQFclHBCvNLc3z4GjK/nbM+kDF5WFxwHYofI=;
  b=NTwN5PM9+wdliWx90aOqamoTZpgVL7K7FIQFOP4stJKsPBqQEy/0Rtj0
   0UMZ1BcfRvdP72ufBc0mBebG/FG7Mv3wjcnDOxgfQRZQhkDgenJTYF85M
   +Dygc35wVQwNUAtg+dLRHEGfZuV5kVxu9H4q0eYAEiWfGQExquq4+VwTP
   kzul97oCbQ2W96r5Ku3lgmwyQui5FdD4j8Hi2hsTYI4my7K8EXod9+Ua6
   O+PGaWiJTYmeDpeA6v6a5qf2Rxiune53wTt75FLHpR7y/JF+lBG6mghs/
   bVscMLxSEkeccZ9hGbIoNucZ+Kujs1lL+zMda3Q+ib9StFyo/qaJExrd/
   g==;
X-CSE-ConnectionGUID: kLiHX0A3Tr+wyKOmqVX0wA==
X-CSE-MsgGUID: jq3OrPU3QN2K7oALQ6x3Jw==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="31472770"
X-IronPort-AV: E=Sophos;i="6.09,264,1716274800"; 
   d="scan'208";a="31472770"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 07:59:53 -0700
X-CSE-ConnectionGUID: 544BcHRcRjq358UvEvXv6g==
X-CSE-MsgGUID: xeTDIhPcRNix/6cdDWg9Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,264,1716274800"; 
   d="scan'208";a="56913244"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 05 Aug 2024 07:59:51 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id A7127865; Mon, 05 Aug 2024 17:59:45 +0300 (EEST)
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
Subject: [PATCH 6/8] mm: page_isolation: Handle unaccepted memory isolation
Date: Mon,  5 Aug 2024 17:59:38 +0300
Message-ID: <20240805145940.2911011-7-kirill.shutemov@linux.intel.com>
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


