Return-Path: <linux-kernel+bounces-274835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CD2947D63
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 16:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 369951F2233C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 14:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8F9149C69;
	Mon,  5 Aug 2024 14:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LNeBArFs"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EB113C827
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 14:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722869991; cv=none; b=WPm9abMuzDz6xNxnwF9qaZmgrbdCsx5u5kJuPqtA/QRMoNul0ZRMDVJYaqhOiKLXk24xAxuidzqyHfRHlTscgJalA4fB3bEd5TumoIuGiU49nQz2pjZr0hMhdWOQ0pCTPzekQswnbnQ77gthnIPAsyANwGFoeEyMfcpcMcA15XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722869991; c=relaxed/simple;
	bh=mNrd+G8W1pLswdroNW7rKEomKlvtnXxSHo1yiF8wIFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nnIkBK9xenrEW/kTkc5NGge0Q3QG1FVhbMXc2sP0zUFthg0d7S4xcacbel+L0VsqFz2JDOJxFyBOTXIDWEkduXNcADPdV1mkQgFMLwBJO1eiwyaeNA9dvlmLM9NmtcxqezCycqzGjhxcrWq3ZZ6AEBaCBBeX+/0k+MpbXm43gnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LNeBArFs; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722869990; x=1754405990;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mNrd+G8W1pLswdroNW7rKEomKlvtnXxSHo1yiF8wIFI=;
  b=LNeBArFs3daz6PogQTMsu6iecB7YIs8xfE/JcSC8kGoZHvFVJTwRGbD5
   pGUwbf6bgrAgJbBsBYYYTxT7dkAmkiHfzSo041zErCp5sZdWpSilNgp1t
   7q+bbjoqGGqbj/oTm1Uv+6arAb/UwgVMwEUHHV8i5RibBmmA1YrjeZWXK
   9swKjvJw0SiSdlWarqk3PhQ6ccskMo6mfh5ZKCHLl32MM/B8EGd9BKCJ6
   d+RyA3l5sBJGWiX0oN5vsh28AXqoAMJKj53cfW/GJ8brOo2gfmWIxTXSz
   4TvoGFsqyjXmVnTM0eaTZ5+mS1sXfU3UHf3wGyzzL6N6Gy81Vt7IgQOR0
   A==;
X-CSE-ConnectionGUID: W8FW3NtXQ+2ScHhe9zbnEg==
X-CSE-MsgGUID: RJHFouOrTYqPT5olWhFxiA==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="20980909"
X-IronPort-AV: E=Sophos;i="6.09,264,1716274800"; 
   d="scan'208";a="20980909"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 07:59:50 -0700
X-CSE-ConnectionGUID: nFlThEekQDSKA6Qsw8j86w==
X-CSE-MsgGUID: BYHwffoCSZuA75hvGsy6Og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,264,1716274800"; 
   d="scan'208";a="61157245"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 05 Aug 2024 07:59:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 6F7003A8; Mon, 05 Aug 2024 17:59:45 +0300 (EEST)
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
Subject: [PATCH 2/8] mm: Accept memory in __alloc_pages_bulk().
Date: Mon,  5 Aug 2024 17:59:34 +0300
Message-ID: <20240805145940.2911011-3-kirill.shutemov@linux.intel.com>
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

Currently, the kernel only accepts memory in get_page_from_freelist(),
but there is another path that directly takes pages from free lists -
__alloc_page_bulk(). This function can consume all accepted memory and
will resort to __alloc_pages_noprof() if necessary.

Conditionally accepted in __alloc_pages_bulk().

The same issue may arise due to deferred page initialization. Kick the
deferred initialization machinery before abandoning the zone, as the
kernel does in get_page_from_freelist().

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 mm/page_alloc.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index aa9b1eaa638c..90a1f01d5996 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4576,12 +4576,25 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 			goto failed;
 		}
 
+		cond_accept_memory(zone, 0);
+retry_this_zone:
 		mark = wmark_pages(zone, alloc_flags & ALLOC_WMARK_MASK) + nr_pages;
 		if (zone_watermark_fast(zone, 0,  mark,
 				zonelist_zone_idx(ac.preferred_zoneref),
 				alloc_flags, gfp)) {
 			break;
 		}
+
+		if (cond_accept_memory(zone, 0))
+			goto retry_this_zone;
+
+#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
+		/* Try again if zone has deferred pages */
+		if (deferred_pages_enabled()) {
+			if (_deferred_grow_zone(zone, 0))
+				goto retry_this_zone;
+		}
+#endif
 	}
 
 	/*
-- 
2.43.0


