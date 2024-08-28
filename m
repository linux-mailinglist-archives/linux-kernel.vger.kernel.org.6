Return-Path: <linux-kernel+bounces-304688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DCD962390
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 11:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D23D51F258D2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFC516C6A5;
	Wed, 28 Aug 2024 09:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f9dcPQ4L"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7427F16B3B8
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 09:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724837725; cv=none; b=IXWK0SaEhO3qI/CjUtDQfYBFutMiTGzGx24hFJcQ5c/EfIB4Ait1Sif79Z8/lHVqXkAd+szhJFS1blB/HPL/0aUvRatAo9NwSHW03+MgxZLEYGFdh9UHIk1xP5fTpTMsIFCmOReUnkBWeeewV2ojE5yUpgYgaEkIdFzuOQ/J74I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724837725; c=relaxed/simple;
	bh=z3IdVzEmkKayZcVA4c5Lx8bWa1kn1UvcXwMHQ9hiN50=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T/tt3rsZpAtf46xf617X2fPHC/DYFGOxI6+wxuDFvumFKyKTqbFVjqd+o0juzGOcGLdqVbP4cWlgSrnsYpMkCeLmFgn+shmwizlluveaMcU8LKjNjvQ7qKgepijM+KTXLz993YUVaLCgGJRb2+uNes6OLrq24+xACiQ24NeRQxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f9dcPQ4L; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724837724; x=1756373724;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z3IdVzEmkKayZcVA4c5Lx8bWa1kn1UvcXwMHQ9hiN50=;
  b=f9dcPQ4LnXbkXyPO3CeSn3dtBSc6flUacGydfCtBfFxTsr6O/uxLFTuh
   7i7zRpa516Gv/T8NMIO6dOTiLTeoW97Pd3OTwY2rfprxWevrcInyOBKda
   b9d/+BHEFEKP7W7SIMXoQzSpPVJDShn8AHoV7kMe/2vuQHlPSWtcio8j8
   GP6mlpjN4n57sdSDA679KVTo9UwqOr7IQ1ULGaHy8Trj4XSHLeX3HZf7X
   5U/wrqwsy/hxmPbjLSBGtumjNzo8I722mwpXoKdOLpWFwbcMlY8UnCtVm
   kU2Y8UMO5qtbqix8Ftk+8ibxRBR6/22fGj9ySLR9fuItJEE6aVh437cZQ
   A==;
X-CSE-ConnectionGUID: AD6WmsCHS0m9XUZqSpB9BA==
X-CSE-MsgGUID: zTl4uTECTkCyzEj265DYhw==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="34763884"
X-IronPort-AV: E=Sophos;i="6.10,182,1719903600"; 
   d="scan'208";a="34763884"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 02:35:17 -0700
X-CSE-ConnectionGUID: PdKxBT0kTjeKQaE0G6sGVw==
X-CSE-MsgGUID: qK/TMayGQfCohrla7Z6y4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,182,1719903600"; 
   d="scan'208";a="100678978"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.6])
  by orviesa001.jf.intel.com with ESMTP; 28 Aug 2024 02:35:16 -0700
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
Subject: [PATCH v5 3/3] mm: swap: Count successful mTHP ZSWAP stores in sysfs mTHP zswpout stats.
Date: Wed, 28 Aug 2024 02:35:16 -0700
Message-Id: <20240828093516.30228-4-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240828093516.30228-1-kanchana.p.sridhar@intel.com>
References: <20240828093516.30228-1-kanchana.p.sridhar@intel.com>
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
index 4902e2f7e896..8b8045d4a351 100644
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
index a81eab98d6b8..45b26c8b3d8a 100644
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


