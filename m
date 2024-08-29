Return-Path: <linux-kernel+bounces-307717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4D09651F0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 23:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 852E71F24F5C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 21:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D130E1BAEDD;
	Thu, 29 Aug 2024 21:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="elyfKI85"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406DE1B81D1
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 21:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724966834; cv=none; b=akBu/F46Ipzb+kAZGhq2iMYtjXXBdU1w4Yy0FTRbymxeQXmK6SiVvMlPMxhkCYg4hmy+WM1bCuhoasuvvEzcXdmYHMs+WPYbhnqZJ2oR1E6qTT9u9kGT3UOm6iVsHe4nrFbWev0R72jGCV7NegyF+QtzecQkHpa8slb3M/bSA6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724966834; c=relaxed/simple;
	bh=Or6JtsX4DElqSgWxB+UTsMM5LcYpKMfhZpaMRcyI7+E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cM9xzkIIFpk8qCwlWrmO4UbgaCdav5sO7prIk6+Mn9CF+xVzbUMEZyKFwDb0Dyn8O2otYmepiM3cHaNqjkSn6jrxkLeEPjATXaBNZOgkZTuVXFInT5UHBZXbeAcYDgdqmc5cxbZdFIGodcQ/6Q4QShwEZT3RTSbu0P2sw2dty+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=elyfKI85; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724966832; x=1756502832;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Or6JtsX4DElqSgWxB+UTsMM5LcYpKMfhZpaMRcyI7+E=;
  b=elyfKI85Bcct+DBr7uThd3JRakKDrzJY0l+gEzcOI3EcgX2xwwvrS60R
   jvpE0/i0oNsnaWXK9a6Y/RsWgb+G2s34NzPD46mOzfth2fI310WuNooeE
   bF5SO+ocaDHduUG+7Om4rGFayJU/T7sPV2/JaqVl4deOdlZeMk9Ni0uGR
   VsMFcnb62zY+9wy89jKd4JZ93rcvZbJtKiHaTNhEqw9+VXJbKrqB7hpt1
   KTm12CS06yAs0DabhkrW0OAagnx//Rd5qMgBlrnsCdj0+Kad8Sbk0dCbP
   Mi/WsO7R/0lqvk1vbG6BNT3GEpIt5JWUsaE4qz8K6Sw+fm0kXmiBvJ4q9
   w==;
X-CSE-ConnectionGUID: s88L/fDaSESPhY2k0j8uHw==
X-CSE-MsgGUID: gFraQzYtRKWgrNauyDuRFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="23455210"
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="23455210"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 14:27:07 -0700
X-CSE-ConnectionGUID: fjEjsifpSK+141+sdK48gQ==
X-CSE-MsgGUID: RCg+/KznR7G9xMttevfeqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="68365422"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.6])
  by fmviesa004.fm.intel.com with ESMTP; 29 Aug 2024 14:27:08 -0700
From: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	usamaarif642@gmail.com,
	ryan.roberts@arm.com,
	ying.huang@intel.com,
	21cnbao@gmail.com,
	akpm@linux-foundation.org
Cc: nanhai.zou@intel.com,
	wajdi.k.feghali@intel.com,
	vinodh.gopal@intel.com,
	kanchana.p.sridhar@intel.com
Subject: [PATCH v6 3/3] mm: swap: Count successful mTHP ZSWAP stores in sysfs mTHP zswpout stats.
Date: Thu, 29 Aug 2024 14:27:05 -0700
Message-Id: <20240829212705.6714-4-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240829212705.6714-1-kanchana.p.sridhar@intel.com>
References: <20240829212705.6714-1-kanchana.p.sridhar@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new MTHP_STAT_ZSWPOUT entry to the sysfs mTHP stats so that
per-order mTHP folio ZSWAP stores can be accounted.

If zswap_store() successfully swaps out an mTHP, it will be counted under
the per-order sysfs "zswpout" stats:

/sys/kernel/mm/transparent_hugepage/hugepages-*kB/stats/zswpout

Other block dev/fs mTHP swap-out events will be counted under
the existing sysfs "swpout" stats:

/sys/kernel/mm/transparent_hugepage/hugepages-*kB/stats/swpout

Based on changes made in commit 61e751c01466ffef5dc72cb64349454a691c6bfe
("mm: cleanup count_mthp_stat() definition"), this patch also moves
the call to count_mthp_stat() in count_swpout_vm_event() to be outside
the "ifdef CONFIG_TRANSPARENT_HUGEPAGE".

Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
---
 include/linux/huge_mm.h | 1 +
 mm/huge_memory.c        | 3 +++
 mm/page_io.c            | 3 ++-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 4da102b74a8c..8b690328e78b 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -118,6 +118,7 @@ enum mthp_stat_item {
 	MTHP_STAT_ANON_FAULT_ALLOC,
 	MTHP_STAT_ANON_FAULT_FALLBACK,
 	MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
+	MTHP_STAT_ZSWPOUT,
 	MTHP_STAT_SWPOUT,
 	MTHP_STAT_SWPOUT_FALLBACK,
 	MTHP_STAT_SHMEM_ALLOC,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 15418ffdd377..ad921c4b2ad8 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -587,6 +587,7 @@ static struct kobj_attribute _name##_attr = __ATTR_RO(_name)
 DEFINE_MTHP_STAT_ATTR(anon_fault_alloc, MTHP_STAT_ANON_FAULT_ALLOC);
 DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTHP_STAT_ANON_FAULT_FALLBACK);
 DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
+DEFINE_MTHP_STAT_ATTR(zswpout, MTHP_STAT_ZSWPOUT);
 DEFINE_MTHP_STAT_ATTR(swpout, MTHP_STAT_SWPOUT);
 DEFINE_MTHP_STAT_ATTR(swpout_fallback, MTHP_STAT_SWPOUT_FALLBACK);
 #ifdef CONFIG_SHMEM
@@ -605,6 +606,7 @@ static struct attribute *anon_stats_attrs[] = {
 	&anon_fault_fallback_attr.attr,
 	&anon_fault_fallback_charge_attr.attr,
 #ifndef CONFIG_SHMEM
+	&zswpout_attr.attr,
 	&swpout_attr.attr,
 	&swpout_fallback_attr.attr,
 #endif
@@ -637,6 +639,7 @@ static struct attribute_group file_stats_attr_grp = {
 
 static struct attribute *any_stats_attrs[] = {
 #ifdef CONFIG_SHMEM
+	&zswpout_attr.attr,
 	&swpout_attr.attr,
 	&swpout_fallback_attr.attr,
 #endif
diff --git a/mm/page_io.c b/mm/page_io.c
index b6f1519d63b0..26106e745d73 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -289,6 +289,7 @@ int swap_writepage(struct page *page, struct writeback_control *wbc)
 		swap_zeromap_folio_clear(folio);
 	}
 	if (zswap_store(folio)) {
+		count_mthp_stat(folio_order(folio), MTHP_STAT_ZSWPOUT);
 		folio_unlock(folio);
 		return 0;
 	}
@@ -308,8 +309,8 @@ static inline void count_swpout_vm_event(struct folio *folio)
 		count_memcg_folio_events(folio, THP_SWPOUT, 1);
 		count_vm_event(THP_SWPOUT);
 	}
-	count_mthp_stat(folio_order(folio), MTHP_STAT_SWPOUT);
 #endif
+	count_mthp_stat(folio_order(folio), MTHP_STAT_SWPOUT);
 	count_vm_events(PSWPOUT, folio_nr_pages(folio));
 }
 
-- 
2.27.0


