Return-Path: <linux-kernel+bounces-285940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A61951482
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 08:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3E67B24D31
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 06:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1A113A268;
	Wed, 14 Aug 2024 06:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bU3eDmGs"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A66D6A022
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 06:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723616917; cv=none; b=PaOfIUiqN/NsbVRIRIRSpJ8muECw+DpNJiriTf+RePqxYE1IQHv3hzf8WRIdbVqU+qgV8sTy8LFfQWGmZi/B2aqnLt1Xl4Yxv53w4WLp4u0z9HZIyO999XdBHPRjuqv7mleb9FegeUG5J8+QK61DwnROUU4e3R5P5XeUVpZllDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723616917; c=relaxed/simple;
	bh=uqrNeGBRRJSKgfNeNGYme2bhngEOXyV0SlU+NTOqopU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o005LV+tvJEtBq/u/d4TibUVDAm7s+2q7PyVOAApppo1nyliZEcED2r8Q4LNrdLv0bUfSbHX/PS3qoa+C6UJJaJV1k2LexjrgXsu+611HNu1aCB5RRlOnuR1xFt+RSwGKSIbtmGEnfU2ADIfGWiI6b3dLiV7776fwY+izmer/sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bU3eDmGs; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723616916; x=1755152916;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uqrNeGBRRJSKgfNeNGYme2bhngEOXyV0SlU+NTOqopU=;
  b=bU3eDmGskH16eVbpSbwy25Rzd5uHd9cUBiDPZyE8X1oAZIAWxPzMPxM5
   6IzZRp+VHGr96qzuPyvbcIkNaJ6wF19M6nq4njVzP7ha/+9XtXiYB3THs
   4g4EuzkGleuSsRjZDA/aqRpIuROTVP+LGspfJcbu/0M7nriJqV+EzzkU8
   R4YCCeCdoZSaFoLnw214N4vpuGKkLkzPfcRH78oDGz7S1yZOp5MwDk9LC
   yzYmjVd/PlpNhNlPp+Spl1dm/NyJMylevj80WN+N4NgpdVX/a2ZEeJ/Qt
   UGIwM+HJ7J2lLrFCN4TkJuj4YSroKVjN45d1E6fjHA51vzpMSWnfyD+F7
   A==;
X-CSE-ConnectionGUID: DU5wGKZKRhy5WFjyF6qDdQ==
X-CSE-MsgGUID: VewcjTSyQk20lil1Sxl73w==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="44333010"
X-IronPort-AV: E=Sophos;i="6.09,288,1716274800"; 
   d="scan'208";a="44333010"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 23:28:33 -0700
X-CSE-ConnectionGUID: OhOjY6yjTM6kgTZgOGWk0w==
X-CSE-MsgGUID: 0vYFo0pvQu2aqwWrMol5Rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,288,1716274800"; 
   d="scan'208";a="63568753"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.6])
  by fmviesa004.fm.intel.com with ESMTP; 13 Aug 2024 23:28:32 -0700
From: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	ryan.roberts@arm.com,
	ying.huang@intel.com,
	21cnbao@gmail.com,
	akpm@linux-foundation.org
Cc: nanhai.zou@intel.com,
	wajdi.k.feghali@intel.com,
	vinodh.gopal@intel.com,
	kanchana.p.sridhar@intel.com
Subject: [RFC PATCH v1 2/4] mm: vmstat: Per mTHP-size zswap_store vmstat event counters.
Date: Tue, 13 Aug 2024 23:28:28 -0700
Message-Id: <20240814062830.26833-3-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240814062830.26833-1-kanchana.p.sridhar@intel.com>
References: <20240814062830.26833-1-kanchana.p.sridhar@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added vmstat event counters per mTHP-size that can be used to account
for folios of different sizes being successfully stored in ZSWAP.

For this RFC, it is not clear if these zswpout counters should instead
be added as part of the existing mTHP stats in
/sys/kernel/mm/transparent_hugepage/hugepages-*kB/stats.

The following is also a viable option, should it make better sense,
for instance, as:

/sys/kernel/mm/transparent_hugepage/hugepages-*kB/stats/zswpout.

If so, we would be able to distinguish between mTHP zswap and
non-zswap swapouts through:

/sys/kernel/mm/transparent_hugepage/hugepages-*kB/stats/zswpout

and

/sys/kernel/mm/transparent_hugepage/hugepages-*kB/stats/swpout

respectively.

Comments would be appreciated as to which approach is preferable.

Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
---
 include/linux/vm_event_item.h | 15 +++++++++++++++
 mm/vmstat.c                   | 15 +++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index 747943bc8cc2..2451bcfcf05c 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -114,6 +114,9 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		THP_ZERO_PAGE_ALLOC,
 		THP_ZERO_PAGE_ALLOC_FAILED,
 		THP_SWPOUT,
+#ifdef CONFIG_ZSWAP
+		ZSWPOUT_PMD_THP_FOLIO,
+#endif
 		THP_SWPOUT_FALLBACK,
 #endif
 #ifdef CONFIG_MEMORY_BALLOON
@@ -143,6 +146,18 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		ZSWPIN,
 		ZSWPOUT,
 		ZSWPWB,
+		ZSWPOUT_4KB_FOLIO,
+#ifdef CONFIG_THP_SWAP
+		mTHP_ZSWPOUT_8kB,
+		mTHP_ZSWPOUT_16kB,
+		mTHP_ZSWPOUT_32kB,
+		mTHP_ZSWPOUT_64kB,
+		mTHP_ZSWPOUT_128kB,
+		mTHP_ZSWPOUT_256kB,
+		mTHP_ZSWPOUT_512kB,
+		mTHP_ZSWPOUT_1024kB,
+		mTHP_ZSWPOUT_2048kB,
+#endif
 #endif
 #ifdef CONFIG_X86
 		DIRECT_MAP_LEVEL2_SPLIT,
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 8507c497218b..0e66c8b0c486 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1375,6 +1375,9 @@ const char * const vmstat_text[] = {
 	"thp_zero_page_alloc",
 	"thp_zero_page_alloc_failed",
 	"thp_swpout",
+#ifdef CONFIG_ZSWAP
+	"zswpout_pmd_thp_folio",
+#endif
 	"thp_swpout_fallback",
 #endif
 #ifdef CONFIG_MEMORY_BALLOON
@@ -1405,6 +1408,18 @@ const char * const vmstat_text[] = {
 	"zswpin",
 	"zswpout",
 	"zswpwb",
+	"zswpout_4kb_folio",
+#ifdef CONFIG_THP_SWAP
+	"mthp_zswpout_8kb",
+	"mthp_zswpout_16kb",
+	"mthp_zswpout_32kb",
+	"mthp_zswpout_64kb",
+	"mthp_zswpout_128kb",
+	"mthp_zswpout_256kb",
+	"mthp_zswpout_512kb",
+	"mthp_zswpout_1024kb",
+	"mthp_zswpout_2048kb",
+#endif
 #endif
 #ifdef CONFIG_X86
 	"direct_map_level2_splits",
-- 
2.27.0


