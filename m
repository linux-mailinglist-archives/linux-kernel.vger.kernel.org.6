Return-Path: <linux-kernel+bounces-280808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CE194CF7F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 13:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 448C31C213C9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 11:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B316194089;
	Fri,  9 Aug 2024 11:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RSpFxGTY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A1819308F
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 11:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723204151; cv=none; b=GDpME3PeiEAmlVfY88W4h0pWVQaVDmpcWPJaDsc7z9yMGb1nQDRsxnCB6/LDBXX9MCsnBt6t3diW+fcdEiY//ipoq9F8LGEGFuwGCtCtCNrYrhX4qHWq5REV2ju6ePBmye2vt1Eph4rpHHxoHfI51oQpUCTZc7co+Sca5sQH/EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723204151; c=relaxed/simple;
	bh=8uQZF5Uhz2ovztR/I7NMgOMJfpN3cl6gEDHYcVKTSDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lHuvAvTihqWmN2PrzAJtIXnfPCtpHlkyatVM/W4MUJNF/gZkemlCga/w86JjACbDNBALX1iyL/O8HDTpUuyKeskDOYD+kC8TasA/2pIW3ySUt+JwtpHC4EDyWC07p20e/iQNC44fMaygjzBY0XXjlodWKryOAzSsq/5byl8julc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RSpFxGTY; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723204151; x=1754740151;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8uQZF5Uhz2ovztR/I7NMgOMJfpN3cl6gEDHYcVKTSDE=;
  b=RSpFxGTYaxgsG+7YdWeCDe27xKaoLT7lDcDSAY+CKiJXJjYoCp3b3dm+
   AThQ+sf0giNNI1gp43ju8snnXo+tNPSuajYmK7xr57aXoH61u5K+AWOrG
   2er0CZ9lF9yHsXQHNLA3jy5BNdhKNdHCG4HmirjknvC/GY8VLRwT94HV2
   meHYGat0ACEuUrknDC1yhWSmblnnbGlhlIoGyccDvqtf+U62h1lLsYcTy
   nEJD1TosuGPOq0iaJAal21n9XKSWXHYWIaIBeDRATaIC4QzrofDg22OZ5
   siq55UaZVlWhavT/4iVRio/jtt52SLhPfNzSe0SNNTYra+vo8CpENKz8F
   w==;
X-CSE-ConnectionGUID: Bfa/Nx3XTMG2mUtelnW/vg==
X-CSE-MsgGUID: kkeMamHXTz+30V/TzCB5Lw==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="24280286"
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="24280286"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 04:49:10 -0700
X-CSE-ConnectionGUID: 8I4v0cgrQSGm09kCFwGCrg==
X-CSE-MsgGUID: 44H2KFQgQ/C/ttA/2Zxb9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="57423598"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 09 Aug 2024 04:49:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 3C4E3597; Fri, 09 Aug 2024 14:49:02 +0300 (EEST)
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
Subject: [PATCHv2 2/8] mm: Reduce deferred struct page init ifdeffery
Date: Fri,  9 Aug 2024 14:48:48 +0300
Message-ID: <20240809114854.3745464-3-kirill.shutemov@linux.intel.com>
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

Add dummy _deferred_grow_zone() for !DEFERRED_STRUCT_PAGE_INIT and
remove #ifdefs in two places.

No functional changes.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Suggested-by: David Hildenbrand <david@redhat.com>
---
 mm/page_alloc.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a9a89980f3f2..f7bb885aab07 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -322,6 +322,11 @@ static inline bool deferred_pages_enabled(void)
 {
 	return false;
 }
+
+static inline bool _deferred_grow_zone(struct zone *zone, unsigned int order)
+{
+	return false;
+}
 #endif /* CONFIG_DEFERRED_STRUCT_PAGE_INIT */
 
 /* Return a pointer to the bitmap storing bits affecting a block of pages */
@@ -3431,7 +3436,6 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 			if (cond_accept_memory(zone, order))
 				goto try_this_zone;
 
-#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
 			/*
 			 * Watermark failed for this zone, but see if we can
 			 * grow this zone if it contains deferred pages.
@@ -3440,7 +3444,6 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 				if (_deferred_grow_zone(zone, order))
 					goto try_this_zone;
 			}
-#endif
 			/* Checked here to keep the fast path fast */
 			BUILD_BUG_ON(ALLOC_NO_WATERMARKS < NR_WMARK);
 			if (alloc_flags & ALLOC_NO_WATERMARKS)
@@ -3486,13 +3489,11 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 			if (cond_accept_memory(zone, order))
 				goto try_this_zone;
 
-#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
 			/* Try again if zone has deferred pages */
 			if (deferred_pages_enabled()) {
 				if (_deferred_grow_zone(zone, order))
 					goto try_this_zone;
 			}
-#endif
 		}
 	}
 
-- 
2.43.0


