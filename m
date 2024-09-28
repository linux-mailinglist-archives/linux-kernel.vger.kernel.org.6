Return-Path: <linux-kernel+bounces-342317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94368988D88
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 04:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC7C01C20AF7
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 02:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339E713B5AE;
	Sat, 28 Sep 2024 02:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nHc/sPCj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0C52FB6
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 02:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727489789; cv=none; b=b9jBDGumVOY437CeajEuCur2vjTyGXN0N+d/bRESel18j3nu34QDREAbWudw6GrggDzM3KKZdrPRLO31CGWHR/alKvKfmk8ktAitIF0c2MhnybJ7YY+60SoYxJjj9ixWqW4lVFy7C8ol1ThxKKyIg4d6LbmiJmGJ5SGy4sjH6Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727489789; c=relaxed/simple;
	bh=7AZStRs4Lxum8UQacAgZWzRz8QxxXzYiQ2pEjwK5j3g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iSUkQUXfmAVkTSULbk6rV9ooLUh2ZkxG93CMAyutsZcCxhBp5RdyBDPfAYsZPA2VyoJks4puFc7w9WzCYJV55I5c6Exy9ZUrLk9utuwBXtyUrNSkg5eqIeieFbahoiCjwUcw9ACuYN+VNdnICi/LCqD+rDHQm3nOXB7dQPwD7hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nHc/sPCj; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727489787; x=1759025787;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7AZStRs4Lxum8UQacAgZWzRz8QxxXzYiQ2pEjwK5j3g=;
  b=nHc/sPCj6bnl60olaesxAZPUqsUaJpRDRNQreFy0bui9OmdwkQy8fMVy
   vAbFJZMsH6j5TUK5/+AhypmYoKhZPuJikDHg0L0aB6KJzhd2ppUp6vFL/
   iDXT0A9hZdq/Gp3cx3auPIRka5EV7T5YsFU34nDZ3JyUSjdBR+aTsq0nt
   AIpnby8kPJoeFndo6p3Wn/i8m6kZP1XQSjRz4gLx6tiygM7WLTAtAdJGe
   001OGpNb40Y3PxyNa+16tn+SUw5D7LbVBa4TxHtCb8keRDrWcPrw9PTmG
   iDI/shgYfFgg4B6DeaBCjLyKOQCSTqNZ+SiqJDazs4X5fL6NVHErB9BqO
   w==;
X-CSE-ConnectionGUID: iCJnneY3SWqH/ouuIGN40w==
X-CSE-MsgGUID: OiyhXdC3QR+yIQ0ay12Rkw==
X-IronPort-AV: E=McAfee;i="6700,10204,11208"; a="29526893"
X-IronPort-AV: E=Sophos;i="6.11,160,1725346800"; 
   d="scan'208";a="29526893"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2024 19:16:21 -0700
X-CSE-ConnectionGUID: mDT8is80RWObT6fFc36rng==
X-CSE-MsgGUID: ugrimwV2TuCBBwZcCwdPzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,160,1725346800"; 
   d="scan'208";a="73507127"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.6])
  by orviesa008.jf.intel.com with ESMTP; 27 Sep 2024 19:16:21 -0700
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
Subject: [PATCH v8 5/8] mm: zswap: Modify zswap_stored_pages to be atomic_long_t.
Date: Fri, 27 Sep 2024 19:16:17 -0700
Message-Id: <20240928021620.8369-6-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240928021620.8369-1-kanchana.p.sridhar@intel.com>
References: <20240928021620.8369-1-kanchana.p.sridhar@intel.com>
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
index 0f281e50a034..43e4e216db41 100644
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


