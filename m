Return-Path: <linux-kernel+bounces-336435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21EED983ABB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 03:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09E171C21AC6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 01:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1040917BA0;
	Tue, 24 Sep 2024 01:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y9cpEceA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03378C1F
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 01:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727140637; cv=none; b=UEjpofydH7qggXRnjf0ZOZR+HGdLmSJ7+oxDqIv0/m2ycpnG3AIXabjw1K2GkoaTXMA7/cPXzGqHQpyYOY+rPRfN99EAQZ+Xxzzh3sa1pkrOd5EcAZ9ehSSEeKqTvbYQHU7NvzKnicc6mB4lnGaLjNGNNXZ+1E6cI5JtybVS6po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727140637; c=relaxed/simple;
	bh=2mNeQTWJUlWcoSNPRsAXaDiBYPB5nqJS0eAJPgQB/Sk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dovguDgRYGgose89cXXwF+dXTIHrIWe1QCfhUaeas898xdz+n0pnupBC5X5wAN2Q9cSRwURWswZ74nV4XavHKTkRKDioJJ5+wIb/icmT03wOY5NC0icV6mHs6U+SaxK4+FqjUtl3v8OMeFcxsggoyXAFce8AcgsQCgcPqGEJ03Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y9cpEceA; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727140635; x=1758676635;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2mNeQTWJUlWcoSNPRsAXaDiBYPB5nqJS0eAJPgQB/Sk=;
  b=Y9cpEceAFeDdjyqpGqw6++5yVBVK1XGCFsM6N1F+Se5+Zq+jSfeSOV8z
   hrIGwTYj5HeutCYA1EkoCn9nSlcspgbOfEcmwAvQh6zvxrmeVXZYHzBld
   bUnNEprjNcV1cDQYAlS2tVB7nnlg2vEp2KAOG3AF5Iwv6WeQR0ZLS5LVs
   OXGqyQP1QBgcNjLx5YkD1ivmsQcSw3CZfBwzHyoICZUuBSNm1+gQbAkUc
   P3swWGLcyH9RyLevzYwUWRuaAqbtEumRGnzUEax1LZIMfFiUJwC92VoGU
   gXpO9lHosTbffnmuU+14cwCfBANAeh6vP6ieE7q01kvNm04/lXVXWz9zj
   A==;
X-CSE-ConnectionGUID: MMaIldbxQvuTiZoBlkF0sw==
X-CSE-MsgGUID: RAkJsktxTRGhow8uLSr1NQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="30002030"
X-IronPort-AV: E=Sophos;i="6.10,253,1719903600"; 
   d="scan'208";a="30002030"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 18:17:11 -0700
X-CSE-ConnectionGUID: e+1Xguk5Qg+HYwyEEGg18Q==
X-CSE-MsgGUID: zCaUK/6kQ9uT9pt7psyHcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,253,1719903600"; 
   d="scan'208";a="108688457"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.6])
  by orviesa001.jf.intel.com with ESMTP; 23 Sep 2024 18:17:10 -0700
From: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	usamaarif642@gmail.com,
	shakeel.butt@linux.dev,
	ryan.roberts@arm.com,
	ying.huang@intel.com,
	21cnbao@gmail.com,
	akpm@linux-foundation.org
Cc: nanhai.zou@intel.com,
	wajdi.k.feghali@intel.com,
	vinodh.gopal@intel.com,
	kanchana.p.sridhar@intel.com
Subject: [PATCH v7 5/8] mm: zswap: Compress and store a specific page in a folio.
Date: Mon, 23 Sep 2024 18:17:06 -0700
Message-Id: <20240924011709.7037-6-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240924011709.7037-1-kanchana.p.sridhar@intel.com>
References: <20240924011709.7037-1-kanchana.p.sridhar@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For zswap_store() to handle mTHP folios, we need to iterate through each
page in the mTHP, compress it and store it in the zswap pool. This patch
introduces an auxiliary function zswap_store_page() that provides this
functionality.

The function signature reflects the design intent, namely, for it
to be invoked by zswap_store() per-page in an mTHP. Hence, the folio's
objcg and the zswap_pool to use are input parameters for sake of
efficiency and consistency.

The functionality in zswap_store_page() is reused and adapted from
Ryan Roberts' RFC patch [1]:

  "[RFC,v1] mm: zswap: Store large folios without splitting"

  [1] https://lore.kernel.org/linux-mm/20231019110543.3284654-1-ryan.roberts@arm.com/T/#u

Co-developed-by: Ryan Roberts
Signed-off-by:
Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
---
 mm/zswap.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/mm/zswap.c b/mm/zswap.c
index 9bea948d653e..8f2e0ab34c84 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1463,6 +1463,94 @@ static void zswap_delete_stored_offsets(struct xarray *tree,
 	}
 }
 
+/*
+ * Stores the page at specified "index" in a folio.
+ *
+ * @folio: The folio to store in zswap.
+ * @index: Index into the page in the folio that this function will store.
+ * @objcg: The folio's objcg.
+ * @pool:  The zswap_pool to store the compressed data for the page.
+ */
+static bool __maybe_unused zswap_store_page(struct folio *folio, long index,
+					    struct obj_cgroup *objcg,
+					    struct zswap_pool *pool)
+{
+	swp_entry_t swp = folio->swap;
+	int type = swp_type(swp);
+	pgoff_t offset = swp_offset(swp) + index;
+	struct page *page = folio_page(folio, index);
+	struct xarray *tree = swap_zswap_tree(swp);
+	struct zswap_entry *entry;
+
+	if (objcg)
+		obj_cgroup_get(objcg);
+
+	if (zswap_check_limits())
+		goto reject;
+
+	/* allocate entry */
+	entry = zswap_entry_cache_alloc(GFP_KERNEL, folio_nid(folio));
+	if (!entry) {
+		zswap_reject_kmemcache_fail++;
+		goto reject;
+	}
+
+	/* if entry is successfully added, it keeps the reference */
+	if (!zswap_pool_get(pool))
+		goto freepage;
+
+	entry->pool = pool;
+
+	if (!zswap_compress(page, entry))
+		goto put_pool;
+
+	entry->swpentry = swp_entry(type, offset);
+	entry->objcg = objcg;
+	entry->referenced = true;
+
+	if (!zswap_store_entry(tree, entry))
+		goto store_failed;
+
+	if (objcg) {
+		obj_cgroup_charge_zswap(objcg, entry->length);
+		count_objcg_event(objcg, ZSWPOUT);
+	}
+
+	/*
+	 * We finish initializing the entry while it's already in xarray.
+	 * This is safe because:
+	 *
+	 * 1. Concurrent stores and invalidations are excluded by folio lock.
+	 *
+	 * 2. Writeback is excluded by the entry not being on the LRU yet.
+	 *    The publishing order matters to prevent writeback from seeing
+	 *    an incoherent entry.
+	 */
+	if (entry->length) {
+		INIT_LIST_HEAD(&entry->lru);
+		zswap_lru_add(&zswap_list_lru, entry);
+	}
+
+	/* update stats */
+	atomic_inc(&zswap_stored_pages);
+	count_vm_event(ZSWPOUT);
+
+	return true;
+
+store_failed:
+	zpool_free(entry->pool->zpool, entry->handle);
+put_pool:
+	zswap_pool_put(pool);
+freepage:
+	zswap_entry_cache_free(entry);
+reject:
+	obj_cgroup_put(objcg);
+	if (zswap_pool_reached_full)
+		queue_work(shrink_wq, &zswap_shrink_work);
+
+	return false;
+}
+
 bool zswap_store(struct folio *folio)
 {
 	long nr_pages = folio_nr_pages(folio);
-- 
2.27.0


