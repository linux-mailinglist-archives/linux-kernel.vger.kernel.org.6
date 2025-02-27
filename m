Return-Path: <linux-kernel+bounces-535562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE352A4748B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 05:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3E6616F878
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 04:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498331EB5E2;
	Thu, 27 Feb 2025 04:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GFuSPvHy"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866D01EB5D6
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 04:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740630999; cv=none; b=W656edPWTN7140B3jSg+s6CpAvjSQ8cb7fjHqEUlFSvoTk9U/oPmliFDyFBGHoW7LSTrdr3l993RtRSXPePIWWi1oUvwrLt20n2JYKperkVhhCIIl6ZCNySWNZYsKwzPhMAZwhc/hEEk9H0VFYcaaAuH4cezrJgiH3muPxjgNcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740630999; c=relaxed/simple;
	bh=vQyIdQY0kaLvNLjXmsmXnP/oCIc/09Y9M1Oedf4ZMVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NefvLqqCuVAHNbUkqmFPfUdd5zE2hpOt7BvXEzpZEbl/KFR5gyjXZuG8Z9YGG1dVqneOcQNHv2GzLSlKOYphw3Tj9oKRXGhVXp/HMZaIJiyVAo8FeR6fs1MptWnotTfmc+maG3D98umhx+EH3DQsaqj30r05G7q/NLn01O0FieU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GFuSPvHy; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2fea795bafeso256425a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 20:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740630997; x=1741235797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NR62rHb3pebtfvQHNCZtoXwLqkDdn/SbiRV6/pPxB7w=;
        b=GFuSPvHyPSF3fK4HRTEOfM9mT3M3gCS7oUdJUs1k284FhI396lE2yiaMKmlXOW2aCb
         b+CUVqonh84w6wRtbaUy7iRRAgGOCILeeIyQvDsvnOXeBm9A/igNe/RoljtvR51yDCCH
         mjFyWzlq/r1ZugCBBI0i6RZGZc1G2fMe/YVos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740630997; x=1741235797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NR62rHb3pebtfvQHNCZtoXwLqkDdn/SbiRV6/pPxB7w=;
        b=bQRuLZVAFIYU+YDYgB/KalwuGkQ9Gvx6WNfOjny2oZ0SlGwqT2Jf0mcp5/Mgd56y2F
         zRhBE1hotfsRpbU7780NQ4g/cm4CJB0MQWq4YGP1XE+1dvr7OWFMW7/uIyjvaZFXep6d
         LDjoQkTps3+RGpeLfzpUwGJe0HurSFWrc17J0U4UzOQtFOpB92q3ASKnATh2MWee4YEq
         CTyX1NplcdQ2vduh9SYeU6nTBxJ+riy1+4hn6/t8n/A7xnqPQxq5tlK0v4P6Ry7xQNd1
         3xzNzfJ2/AThkX3okHIAxLiF+4yooaW4UEvHfubgTishupYwio6J7cFU6rol4Wxh7QpV
         rbYA==
X-Forwarded-Encrypted: i=1; AJvYcCVbVnpnYodwZWkZ73gshRCRGjeBpaBEBECM5udGGxwjmTyHoEtyrfa2OiiYzFq/RglvDXPs6k3cergHyjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKnK/k2Z2Oc+rtYnZXZwY5jN8qQqRNKP6vP91U3c3xdYsAjKqU
	3Pe4GB+aR6CVIrQKdPaiOEk7SNr60iyo7oc97rEUXKqQwDtZWB9RY8dshPjI7w==
X-Gm-Gg: ASbGncue/CMgu/i8Zk7v4C8CBDhNb00acoC2i3oPDJ5yeVwjMhN93CS8EA83Ne7pWAp
	XVbymdx4YVejPX/iOqsPbtJXFTjlaNtv85xKvkZTHbn+O7Ei4uXvM95hS0TGPIRj1whwQZH8DeS
	HXpK+zBKT4PStveZUGdTuNiOn4ZffCKOgo5t/pUT1SPRgrTguRGdxvIpHlSBU9ljMbuUStzeLPa
	tTFwo8mOkFCRG/AMu1uvAuYRzc3URte33P84X7aEvA0p69ci/+wLRwGo3yXASfCK8sMOT8J/3jz
	vJ6aTCbbxZComPKhT8eMrJL6kVCS
X-Google-Smtp-Source: AGHT+IH/UF6t7IzFfea6GJp3N/IG0r3W9xlvoHcoiOhurhjeGRrnZ4qGrFjng8ecS9ungkxHCpZQfA==
X-Received: by 2002:a17:90b:184e:b0:2ee:c30f:33c9 with SMTP id 98e67ed59e1d1-2fea12f4accmr3176743a91.14.1740630996801;
        Wed, 26 Feb 2025 20:36:36 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:a9c0:1bc1:74e3:3e31])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fea6752060sm548358a91.3.2025.02.26.20.36.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 20:36:36 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>,
	Hillf Danton <hdanton@sina.com>,
	Kairui Song <ryncsn@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Minchan Kim <minchan@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v9 01/19] zram: sleepable entry locking
Date: Thu, 27 Feb 2025 13:35:19 +0900
Message-ID: <20250227043618.88380-2-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
In-Reply-To: <20250227043618.88380-1-senozhatsky@chromium.org>
References: <20250227043618.88380-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Concurrent modifications of meta table entries is now handled
by per-entry spin-lock.  This has a number of shortcomings.

First, this imposes atomic requirements on compression backends.
zram can call both zcomp_compress() and zcomp_decompress() under
entry spin-lock, which implies that we can use only compression
algorithms that don't schedule/sleep/wait during compression and
decompression.  This, for instance, makes it impossible to use
some of the ASYNC compression algorithms (H/W compression, etc.)
implementations.

Second, this can potentially trigger watchdogs.  For example,
entry re-compression with secondary algorithms is performed
under entry spin-lock.  Given that we chain secondary
compression algorithms and that some of them can be configured
for best compression ratio (and worst compression speed) zram
can stay under spin-lock for quite some time.

Having a per-entry mutex (or, for instance, a rw-semaphore)
significantly increases sizeof() of each entry and hence the
meta table.  Therefore entry locking returns back to bit
locking, as before, however, this time also preempt-rt friendly,
because if waits-on-bit instead of spinning-on-bit.  Lock owners
are also now permitted to schedule, which is a first step on the
path of making zram non-atomic.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 56 ++++++++++++++++++++++++++++-------
 drivers/block/zram/zram_drv.h | 16 ++++++----
 2 files changed, 55 insertions(+), 17 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 9f5020b077c5..ddf03f6cbeed 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -58,19 +58,56 @@ static void zram_free_page(struct zram *zram, size_t index);
 static int zram_read_from_zspool(struct zram *zram, struct page *page,
 				 u32 index);
 
-static int zram_slot_trylock(struct zram *zram, u32 index)
+#define slot_dep_map(zram, index) (&(zram)->table[(index)].dep_map)
+
+static void zram_slot_lock_init(struct zram *zram, u32 index)
 {
-	return spin_trylock(&zram->table[index].lock);
+	lockdep_init_map(slot_dep_map(zram, index),
+			 "zram->table[index].lock",
+			 &zram->lock_class, 0);
+}
+
+/*
+ * entry locking rules:
+ *
+ * 1) Lock is exclusive
+ *
+ * 2) lock() function can sleep waiting for the lock
+ *
+ * 3) Lock owner can sleep
+ *
+ * 4) Use TRY lock variant when in atomic context
+ *    - must check return value and handle locking failers
+ */
+static __must_check bool zram_slot_trylock(struct zram *zram, u32 index)
+{
+	unsigned long *lock = &zram->table[index].flags;
+
+	if (!test_and_set_bit_lock(ZRAM_ENTRY_LOCK, lock)) {
+		mutex_acquire(slot_dep_map(zram, index), 0, 1, _RET_IP_);
+		lock_acquired(slot_dep_map(zram, index), _RET_IP_);
+		return true;
+	}
+
+	lock_contended(slot_dep_map(zram, index), _RET_IP_);
+	return false;
 }
 
 static void zram_slot_lock(struct zram *zram, u32 index)
 {
-	spin_lock(&zram->table[index].lock);
+	unsigned long *lock = &zram->table[index].flags;
+
+	mutex_acquire(slot_dep_map(zram, index), 0, 0, _RET_IP_);
+	wait_on_bit_lock(lock, ZRAM_ENTRY_LOCK, TASK_UNINTERRUPTIBLE);
+	lock_acquired(slot_dep_map(zram, index), _RET_IP_);
 }
 
 static void zram_slot_unlock(struct zram *zram, u32 index)
 {
-	spin_unlock(&zram->table[index].lock);
+	unsigned long *lock = &zram->table[index].flags;
+
+	mutex_release(slot_dep_map(zram, index), _RET_IP_);
+	clear_and_wake_up_bit(ZRAM_ENTRY_LOCK, lock);
 }
 
 static inline bool init_done(struct zram *zram)
@@ -93,7 +130,6 @@ static void zram_set_handle(struct zram *zram, u32 index, unsigned long handle)
 	zram->table[index].handle = handle;
 }
 
-/* flag operations require table entry bit_spin_lock() being held */
 static bool zram_test_flag(struct zram *zram, u32 index,
 			enum zram_pageflags flag)
 {
@@ -1473,15 +1509,11 @@ static bool zram_meta_alloc(struct zram *zram, u64 disksize)
 		huge_class_size = zs_huge_class_size(zram->mem_pool);
 
 	for (index = 0; index < num_pages; index++)
-		spin_lock_init(&zram->table[index].lock);
+		zram_slot_lock_init(zram, index);
+
 	return true;
 }
 
-/*
- * To protect concurrent access to the same index entry,
- * caller should hold this table index entry's bit_spinlock to
- * indicate this index entry is accessing.
- */
 static void zram_free_page(struct zram *zram, size_t index)
 {
 	unsigned long handle;
@@ -2625,6 +2657,7 @@ static int zram_add(void)
 	if (ret)
 		goto out_cleanup_disk;
 
+	lockdep_register_key(&zram->lock_class);
 	zram_debugfs_register(zram);
 	pr_info("Added device: %s\n", zram->disk->disk_name);
 	return device_id;
@@ -2653,6 +2686,7 @@ static int zram_remove(struct zram *zram)
 		zram->claim = true;
 	mutex_unlock(&zram->disk->open_mutex);
 
+	lockdep_unregister_key(&zram->lock_class);
 	zram_debugfs_unregister(zram);
 
 	if (claimed) {
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index db78d7c01b9a..8a7d52fbab4d 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -28,7 +28,6 @@
 #define ZRAM_SECTOR_PER_LOGICAL_BLOCK	\
 	(1 << (ZRAM_LOGICAL_BLOCK_SHIFT - SECTOR_SHIFT))
 
-
 /*
  * ZRAM is mainly used for memory efficiency so we want to keep memory
  * footprint small and thus squeeze size and zram pageflags into a flags
@@ -46,6 +45,7 @@
 /* Flags for zram pages (table[page_no].flags) */
 enum zram_pageflags {
 	ZRAM_SAME = ZRAM_FLAG_SHIFT,	/* Page consists the same element */
+	ZRAM_ENTRY_LOCK, /* entry access lock bit */
 	ZRAM_WB,	/* page is stored on backing_device */
 	ZRAM_PP_SLOT,	/* Selected for post-processing */
 	ZRAM_HUGE,	/* Incompressible page */
@@ -58,16 +58,19 @@ enum zram_pageflags {
 	__NR_ZRAM_PAGEFLAGS,
 };
 
-/*-- Data structures */
-
-/* Allocated for each disk page */
+/*
+ * Allocated for each disk page.  We use bit-lock (ZRAM_ENTRY_LOCK bit
+ * of flags) to save memory.  There can be plenty of entries and standard
+ * locking primitives (e.g. mutex) will significantly increase sizeof()
+ * of each entry and hence of the meta table.
+ */
 struct zram_table_entry {
 	unsigned long handle;
-	unsigned int flags;
-	spinlock_t lock;
+	unsigned long flags;
 #ifdef CONFIG_ZRAM_TRACK_ENTRY_ACTIME
 	ktime_t ac_time;
 #endif
+	struct lockdep_map dep_map;
 };
 
 struct zram_stats {
@@ -137,5 +140,6 @@ struct zram {
 	struct dentry *debugfs_dir;
 #endif
 	atomic_t pp_in_progress;
+	struct lock_class_key lock_class;
 };
 #endif
-- 
2.48.1.658.g4767266eb4-goog


