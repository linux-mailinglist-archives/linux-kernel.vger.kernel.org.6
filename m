Return-Path: <linux-kernel+bounces-345257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 113AD98B3B5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 07:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B68FD282826
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 05:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3551BCA05;
	Tue,  1 Oct 2024 05:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="maPrlA2p"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819E11BBBDD
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 05:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727761033; cv=none; b=MRVy+jvuHDF0zBUXOcaq++06/2cz/67IfQOW/+h55vKxY0vaIpeqZVqDX+dKSgsEvSeSbFBD9UfRA1uZxaxD+AhEgs9gvaAAUpCmqYrLNpNgPOGF1hRTurWnDNG+vQ4BzariZihJTwQk4pFoEatu7iCNW1do5pfuiU/QP5yXtHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727761033; c=relaxed/simple;
	bh=fh13koWj73Qksnj2l+56lXO4bpj9lkhBiLj2Y16CgXI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=prvvdnQghSVMC4EF8eztfLAW9PTZGjrXOrsKglzFTOtKKQcokrUgNjstQV/TfHimYOd3phkMR3OB7oGMfjhr+L+KVwuqIrQwamSs0N1/8S+LSbNM/vTfFCH1TIsk5uivHhmjX66EigOIlYZcsIoC8rqcVBw63UPievu9aTXJwrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=maPrlA2p; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727761031; x=1759297031;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fh13koWj73Qksnj2l+56lXO4bpj9lkhBiLj2Y16CgXI=;
  b=maPrlA2pMMXpV55fpPB0+xNtn5nctEAuAQKtRlYuMXRJvC8bDXIC8trS
   M4CEaTftPiVIXF/kElFw4Q5zIUyJh5o96bHynFBBh0WN/6RTw/X6+w+0+
   BJlhTjrvnQW9q7DGgdjgk+Ir4MKWVbyFGDQ+IH2aad0LJHkXb/uzlxQko
   A1+rvpZCjipDpGZOUhaKgHFD6dG+4w2yYyZ8kdqXQnQ4ffBmkyJZ2GrZE
   jVYf7NExAxtMg65pBFP/ooiqaNc0fXuVmSptmfQsfXrPPg1a2pRmBAX6R
   NOJGb93bivFsCJigaLdItO4Z5ZKpJl9EpoQ4wQc0z5/2TP7dU3VFjpkKj
   w==;
X-CSE-ConnectionGUID: xZ2ej7T+RQOeP9FDG2yKow==
X-CSE-MsgGUID: cihIhq6VQNKtum542kyyfg==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="37465115"
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="37465115"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 22:32:26 -0700
X-CSE-ConnectionGUID: kM2GQueiQaqyj/KDhjFPcA==
X-CSE-MsgGUID: kqT1lRAiTy6kXLW9DrzM5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="73205808"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.6])
  by fmviesa007.fm.intel.com with ESMTP; 30 Sep 2024 22:32:25 -0700
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
Subject: [PATCH v10 5/7] mm: zswap: Modify zswap_stored_pages to be atomic_long_t.
Date: Mon, 30 Sep 2024 22:32:20 -0700
Message-Id: <20241001053222.6944-6-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20241001053222.6944-1-kanchana.p.sridhar@intel.com>
References: <20241001053222.6944-1-kanchana.p.sridhar@intel.com>
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


