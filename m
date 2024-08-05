Return-Path: <linux-kernel+bounces-274843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1AFD947D71
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CA2CB22DEE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE0415CD4E;
	Mon,  5 Aug 2024 14:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZDikqa6l"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B1815B107
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 14:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722869996; cv=none; b=XNdrOn81/4wS9ryax1oTYn8mo1mCKL3TAUM+Nu2la5O8SJqaA0SFE2uM4LQTSn2gyWvmGDQ3bc9bc9YxmV9adC5mlfUxIFdq5Uk9E8EIQi1BVnToeNFMQz2q39Y0gOvbd0nW5jgkkP7G6nDbaKPPCVX2ToxHggM4geUrJ44yJVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722869996; c=relaxed/simple;
	bh=HZQzMMA1b4Met0TT3CuOG0tnltrjZmQkpNZYdJg4+Zg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TokVyIfZtR7NEhxvpsC97151gPtHToW3JJbxgILE9Nsp1zK0Q1WEH0yAj/9TBvWEep+mDXkioynpuaeVc9j8WhVfP5M2NKP2r0DqMXVaB0z6JYotQkDoacXdKXQI5aEv2mIY5l9O3em4Fl+iP+QFlWQ/i8JUxEkvdJcdvStn/Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZDikqa6l; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722869995; x=1754405995;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HZQzMMA1b4Met0TT3CuOG0tnltrjZmQkpNZYdJg4+Zg=;
  b=ZDikqa6lIaHJhhGCFuKPtbzl4X7Nwn/Irnys3kmlIZhbtM7k6kYCVGNr
   mtgReWJwzO+tkiz5WLCOGlOojunlzj/s4JxRG/YoFSnngKqiXONc9me+i
   +lYGbE78d8YeRaFKfnPxgIuCokMNtEWcws4afbF86sOASC8FxnuxN3Jpz
   Y9yFESMTREszf+clMIadOME9qGbxK/WQaAoknDmrwjJYixskvMQq7axlz
   rDr3dU0dEQ+nRqTsUlmxGzYVfpvs1It3e43y+35IrhMZwk4/d6fwbSl0B
   vZxIY+F5fyxHUmTWyyjd0eyfuU3aPE+qLs+Z7MY8hrU42ehaLJT/Ubxh6
   g==;
X-CSE-ConnectionGUID: KH5H5auKTomVydDNRjORRA==
X-CSE-MsgGUID: JK9WA2ygTha/4iHNoILpbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="20980974"
X-IronPort-AV: E=Sophos;i="6.09,264,1716274800"; 
   d="scan'208";a="20980974"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 07:59:54 -0700
X-CSE-ConnectionGUID: K0ky/TGeTRa3HniYOVe5rw==
X-CSE-MsgGUID: e1DtwlPgSQqL5yDU6fySYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,264,1716274800"; 
   d="scan'208";a="61157259"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 05 Aug 2024 07:59:51 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id B03458AC; Mon, 05 Aug 2024 17:59:45 +0300 (EEST)
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
Subject: [PATCH 7/8] mm: Introduce promo_wmark_pages()
Date: Mon,  5 Aug 2024 17:59:39 +0300
Message-ID: <20240805145940.2911011-8-kirill.shutemov@linux.intel.com>
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

Add promo_wmark_pages() helper to complement other zone watermark
accessors.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 include/linux/mmzone.h | 1 +
 kernel/sched/fair.c    | 2 +-
 mm/vmscan.c            | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 41458892bc8a..eb4ec70f6d53 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -671,6 +671,7 @@ enum zone_watermarks {
 #define min_wmark_pages(z) (z->_watermark[WMARK_MIN] + z->watermark_boost)
 #define low_wmark_pages(z) (z->_watermark[WMARK_LOW] + z->watermark_boost)
 #define high_wmark_pages(z) (z->_watermark[WMARK_HIGH] + z->watermark_boost)
+#define promo_wmark_pages(z) (z->_watermark[WMARK_PROMO] + z->watermark_boost)
 #define wmark_pages(z, i) (z->_watermark[i] + z->watermark_boost)
 
 /*
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9057584ec06d..6b2a032ba0c6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1742,7 +1742,7 @@ static bool pgdat_free_space_enough(struct pglist_data *pgdat)
 			continue;
 
 		if (zone_watermark_ok(zone, 0,
-				      wmark_pages(zone, WMARK_PROMO) + enough_wmark,
+				      promo_wmark_pages(zone) + enough_wmark,
 				      ZONE_MOVABLE, 0))
 			return true;
 	}
diff --git a/mm/vmscan.c b/mm/vmscan.c
index cfa839284b92..ad6473eaec28 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -6664,7 +6664,7 @@ static bool pgdat_balanced(pg_data_t *pgdat, int order, int highest_zoneidx)
 			continue;
 
 		if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING)
-			mark = wmark_pages(zone, WMARK_PROMO);
+			mark = promo_wmark_pages(zone);
 		else
 			mark = high_wmark_pages(zone);
 		if (zone_watermark_ok_safe(zone, order, mark, highest_zoneidx))
-- 
2.43.0


