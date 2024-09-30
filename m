Return-Path: <linux-kernel+bounces-344916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4217298AFAD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 00:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1D1BB2273E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 22:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A2318CBE7;
	Mon, 30 Sep 2024 22:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wq5xHxLZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5155188934
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 22:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727734349; cv=none; b=AbNNnDyEjQ+06r7oS/fs+HUS4571C0OQARfyLpeSMOg+ZF5BOWrPWeg69lm+L4bhyz1S3mOPHwRSFXQXl6tFRTt8lFqQmyxdauygFCBwsxKMG4io7UOmv4CmPAvinsFcpeQTHcjnsEu2JMxYyoE14crmszolb0zBlVwLgxy3rl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727734349; c=relaxed/simple;
	bh=fh13koWj73Qksnj2l+56lXO4bpj9lkhBiLj2Y16CgXI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gTAkyLQ3YaVp5tcjk+GNgvt++dq5vYj0hwbQNGaf+xNANBGQS8BES+zI5PEpwRQhfzosesi8xyNH4nvSkxbkwjRDhClm0bCW2rDpNEGpELK4Onx5QBd1mBQBjrBAbgtniZeVlefiyanMR8sTfvB5pdnke4j6cisJ1h6+k+ovfRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wq5xHxLZ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727734348; x=1759270348;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fh13koWj73Qksnj2l+56lXO4bpj9lkhBiLj2Y16CgXI=;
  b=Wq5xHxLZ3lmduIrYKoalrPaC8HZ4Og+r1yFLNbiesMuiCMFfFj6pIp3k
   CcwB0D56n8DNG9g1+J4IN5IVfRcMkXabpJQlCQSVJ1y0zQGnGb3Y2rr1C
   AlVgBq6sMSCm+hEx+6N1GK3ghXdudbkutY3pftrSCNGy8i7995v8nq6Xx
   XYSVwBtuEwhiLlagQFjek/TpW+cRDsw5x0pFruQcGBTXdV2pMjTF/ejlt
   QCa/Dvbjjj6hQKR7zWaji+ceOryxOMax20+gEWSm0s1zIGM/cK+lu3UAa
   ABzUWJ1HR0ehclZ+HdbjQY8ua6DBzhXoOS5RYVHelL4uOdRpxsWvYbV0m
   g==;
X-CSE-ConnectionGUID: NMgCH244TeClF+nSsl6dBg==
X-CSE-MsgGUID: NrJkY5skRfiW8sf6LGSJ3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="49368436"
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="49368436"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 15:12:25 -0700
X-CSE-ConnectionGUID: vRKOb2DBRnOhm6ekko/j6Q==
X-CSE-MsgGUID: QaKdL+cPSRu5NCz+D5QRRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="77985589"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.6])
  by fmviesa004.fm.intel.com with ESMTP; 30 Sep 2024 15:12:24 -0700
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
	akpm@linux-foundation.org,
	willy@infradead.org
Cc: nanhai.zou@intel.com,
	wajdi.k.feghali@intel.com,
	vinodh.gopal@intel.com,
	kanchana.p.sridhar@intel.com
Subject: [PATCH v9 5/7] mm: zswap: Modify zswap_stored_pages to be atomic_long_t.
Date: Mon, 30 Sep 2024 15:12:19 -0700
Message-Id: <20240930221221.6981-6-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240930221221.6981-1-kanchana.p.sridhar@intel.com>
References: <20240930221221.6981-1-kanchana.p.sridhar@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For zswap_store() to support large folios, we need to be able to do
a batch update of zswap_stored_pages upon successful store of all pages
in the folio. For this, we need to add folio_nr_pages(), which returns
a long, to zswap_stored_pages.

Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Acked-by: Yosry Ahmed <yosryahmed@google.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Nhat Pham <nphamcs@gmail.com>
---
 fs/proc/meminfo.c     |  2 +-
 include/linux/zswap.h |  2 +-
 mm/zswap.c            | 19 +++++++++++++------
 3 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index 245171d9164b..8ba9b1472390 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -91,7 +91,7 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 #ifdef CONFIG_ZSWAP
 	show_val_kb(m, "Zswap:          ", zswap_total_pages());
 	seq_printf(m,  "Zswapped:       %8lu kB\n",
-		   (unsigned long)atomic_read(&zswap_stored_pages) <<
+		   (unsigned long)atomic_long_read(&zswap_stored_pages) <<
 		   (PAGE_SHIFT - 10));
 #endif
 	show_val_kb(m, "Dirty:          ",
diff --git a/include/linux/zswap.h b/include/linux/zswap.h
index 9cd1beef0654..d961ead91bf1 100644
--- a/include/linux/zswap.h
+++ b/include/linux/zswap.h
@@ -7,7 +7,7 @@
 
 struct lruvec;
 
-extern atomic_t zswap_stored_pages;
+extern atomic_long_t zswap_stored_pages;
 
 #ifdef CONFIG_ZSWAP
 
diff --git a/mm/zswap.c b/mm/zswap.c
index 69b9c025fd47..2b8da50f6322 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -43,7 +43,7 @@
 * statistics
 **********************************/
 /* The number of compressed pages currently stored in zswap */
-atomic_t zswap_stored_pages = ATOMIC_INIT(0);
+atomic_long_t zswap_stored_pages = ATOMIC_INIT(0);
 
 /*
  * The statistics below are not protected from concurrent access for
@@ -802,7 +802,7 @@ static void zswap_entry_free(struct zswap_entry *entry)
 		obj_cgroup_put(entry->objcg);
 	}
 	zswap_entry_cache_free(entry);
-	atomic_dec(&zswap_stored_pages);
+	atomic_long_dec(&zswap_stored_pages);
 }
 
 /*********************************
@@ -1232,7 +1232,7 @@ static unsigned long zswap_shrinker_count(struct shrinker *shrinker,
 		nr_stored = memcg_page_state(memcg, MEMCG_ZSWAPPED);
 	} else {
 		nr_backing = zswap_total_pages();
-		nr_stored = atomic_read(&zswap_stored_pages);
+		nr_stored = atomic_long_read(&zswap_stored_pages);
 	}
 
 	if (!nr_stored)
@@ -1501,7 +1501,7 @@ bool zswap_store(struct folio *folio)
 	}
 
 	/* update stats */
-	atomic_inc(&zswap_stored_pages);
+	atomic_long_inc(&zswap_stored_pages);
 	count_vm_event(ZSWPOUT);
 
 	return true;
@@ -1650,6 +1650,13 @@ static int debugfs_get_total_size(void *data, u64 *val)
 }
 DEFINE_DEBUGFS_ATTRIBUTE(total_size_fops, debugfs_get_total_size, NULL, "%llu\n");
 
+static int debugfs_get_stored_pages(void *data, u64 *val)
+{
+	*val = atomic_long_read(&zswap_stored_pages);
+	return 0;
+}
+DEFINE_DEBUGFS_ATTRIBUTE(stored_pages_fops, debugfs_get_stored_pages, NULL, "%llu\n");
+
 static int zswap_debugfs_init(void)
 {
 	if (!debugfs_initialized())
@@ -1673,8 +1680,8 @@ static int zswap_debugfs_init(void)
 			   zswap_debugfs_root, &zswap_written_back_pages);
 	debugfs_create_file("pool_total_size", 0444,
 			    zswap_debugfs_root, NULL, &total_size_fops);
-	debugfs_create_atomic_t("stored_pages", 0444,
-				zswap_debugfs_root, &zswap_stored_pages);
+	debugfs_create_file("stored_pages", 0444,
+			    zswap_debugfs_root, NULL, &stored_pages_fops);
 
 	return 0;
 }
-- 
2.27.0


