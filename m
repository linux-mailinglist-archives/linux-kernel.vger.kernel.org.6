Return-Path: <linux-kernel+bounces-510566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A2CA31EF2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 07:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C60A3A2014
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 06:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA861FC7DC;
	Wed, 12 Feb 2025 06:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TjsqoVTP"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB231FBC8C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 06:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739341930; cv=none; b=rgor+hFsr90LeGNHM/G3K/O6h6P1RhjM7k68aEW/Kp9qRZ8c/vR5wun3jxK0rEGWFOoHqwXpCOzP4d3PgOvPRTttPWIMeheIPBDg3R8DbPK1pJZPhtj/s6WSq//1/FaiNeWMT53XuWHNPtfJYeRxcg+e1eqd7jvLu7SlL9H28DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739341930; c=relaxed/simple;
	bh=ftM5GNwd6HoMW8lSepoMzzNcEpey/3RV/ln/tuvRXA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LBlN7zUFXKdnSt7PTQn+WlPnLPoYHBtszYSRU9yyIQjJe45pkzyrQRi+H01JcnlaDzRg6D8+rIAimEdPWzyO9JA2QtNvAQg/M+EUNGSnwwoOyrMPjfNsKb6SR/eFAQkXOuhvw6Q8u9srUW+6g5qsVo/LkgMdfIwFcEPRX+sf3dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TjsqoVTP; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-220bfdfb3f4so6530105ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 22:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739341927; x=1739946727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nbviwh7jX+fyZgx+5zWo4yndOTBdlLf1Q5tRKthE6k8=;
        b=TjsqoVTPn4JxHTl9NQoIJJ9EddsPP/tnluhoC5vPcBaDWEfP9y5dBVa0lEVIh+d8Zl
         vuAF2PtxSjTjoKRKreB5S7VvZEjgfBFNF3lZEI2q8SOQsOJ2HKHUuPATsMtLFYA9BxmZ
         SdUOyZlXHmiWqditg6AaHTSjchxND7a2R4Bk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739341927; x=1739946727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nbviwh7jX+fyZgx+5zWo4yndOTBdlLf1Q5tRKthE6k8=;
        b=KkhGt4sAw33P7LKOYmgxq7AbwmKnRkauIGtDjV276n9ejQMLZQYqj5g2EfyRjOGUls
         qRz9fm4TJvFnDuczsjUKzdGWk9j3goR7HnKzsRR6ee9BCXV1T5WMXSU23edy+BZq+Afd
         emtTLhjZTEroglqUemLqYoBbIfHcG1Jwkp9zfE574mKj+d3XrGwQ/eqHcLbskiHO9LKN
         I7JLjEf8pUvEwKk+Wc2wDUbEGhDZ9hBZvZ771BFz4CBSzS2m7KYBMdyioh+yfw2R4YQI
         8aG3F0pNYd7YQDS1QYZWliI7dIZbi/G63z+O4tlS25fPyWJZT1hFei01CrkleMAhYe9t
         0fjw==
X-Forwarded-Encrypted: i=1; AJvYcCV0e9uupSDeCA1jB+wWqlyf8i3XKDCjQwuLjiu8aDoOthUXmrXAbirhdnGZW5yJLCtvfaEdP9CO0UVfr4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJJu3FLSvqJOFJ1YRoe3FfsKCmwPBUwe6cBGdkAZ+yDWuWzFlE
	YOcAzmsfWS8FB/ZWBoOgpDiiGQxkXdL4rFpMmlKa9w7QA3Hiqw9SKRvO5kkAxw==
X-Gm-Gg: ASbGnctdT8m9K3Y7IIGfgSfUhAHnRyMNdN9452esHUeu2OA+cQttxaMkNqpuJiXZUub
	qBxU1L51boN2mIDwla/hLupNqHFrNu3PVqB/qaOTJhHHd36jJwdHMpzQ1wyBIpQ0l7LVIsIUbGE
	Xhf9NnV23U7u63Pd3PzXUzhxsCJSFRwjaeh8+LGNou4PC4enqk6Va4jI7gokrTNSa0qBWhSTF4N
	RDBSmlP+17IxpA/tc2Zg5e3cyyswuahNzTNMxfZ40DVAwjYG3ohWVPIDWeYs3V3kC2jz8OncF0i
	N6pkPm33KoQgzOze2Q==
X-Google-Smtp-Source: AGHT+IFSvyC57xadlYDsJ2pjEf3GwKRx0RFUmqWoHBxBXjtPHZ1A+qKCAZJUZUiYg24snMECPbVRZA==
X-Received: by 2002:a17:902:ea11:b0:216:46f4:7e3d with SMTP id d9443c01a7336-220bbad6f94mr31042255ad.15.1739341925761;
        Tue, 11 Feb 2025 22:32:05 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:69f5:6852:451e:8142])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220c34f443bsm2839685ad.5.2025.02.11.22.32.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 22:32:05 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>,
	Kairui Song <ryncsn@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v5 01/18] zram: sleepable entry locking
Date: Wed, 12 Feb 2025 15:26:59 +0900
Message-ID: <20250212063153.179231-2-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
In-Reply-To: <20250212063153.179231-1-senozhatsky@chromium.org>
References: <20250212063153.179231-1-senozhatsky@chromium.org>
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
 drivers/block/zram/zram_drv.c | 65 ++++++++++++++++++++++++++++-------
 drivers/block/zram/zram_drv.h | 20 +++++++----
 2 files changed, 67 insertions(+), 18 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 9f5020b077c5..3708436f1d1f 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -58,19 +58,57 @@ static void zram_free_page(struct zram *zram, size_t index);
 static int zram_read_from_zspool(struct zram *zram, struct page *page,
 				 u32 index);
 
-static int zram_slot_trylock(struct zram *zram, u32 index)
+static void zram_slot_lock_init(struct zram *zram, u32 index)
 {
-	return spin_trylock(&zram->table[index].lock);
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	lockdep_init_map(&zram->table[index].lockdep_map, "zram-entry->lock",
+			 &zram->table_lockdep_key, 0);
+#endif
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
+static __must_check bool zram_slot_try_lock(struct zram *zram, u32 index)
+{
+	unsigned long *lock = &zram->table[index].flags;
+
+	if (!test_and_set_bit_lock(ZRAM_ENTRY_LOCK, lock)) {
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+		mutex_acquire(&zram->table[index].lockdep_map, 0, 1, _RET_IP_);
+#endif
+		return true;
+	}
+	return false;
 }
 
 static void zram_slot_lock(struct zram *zram, u32 index)
 {
-	spin_lock(&zram->table[index].lock);
+	unsigned long *lock = &zram->table[index].flags;
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	mutex_acquire(&zram->table[index].lockdep_map, 0, 0, _RET_IP_);
+#endif
+	wait_on_bit_lock(lock, ZRAM_ENTRY_LOCK, TASK_UNINTERRUPTIBLE);
 }
 
 static void zram_slot_unlock(struct zram *zram, u32 index)
 {
-	spin_unlock(&zram->table[index].lock);
+	unsigned long *lock = &zram->table[index].flags;
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	mutex_release(&zram->table[index].lockdep_map, _RET_IP_);
+#endif
+	clear_and_wake_up_bit(ZRAM_ENTRY_LOCK, lock);
 }
 
 static inline bool init_done(struct zram *zram)
@@ -93,7 +131,6 @@ static void zram_set_handle(struct zram *zram, u32 index, unsigned long handle)
 	zram->table[index].handle = handle;
 }
 
-/* flag operations require table entry bit_spin_lock() being held */
 static bool zram_test_flag(struct zram *zram, u32 index,
 			enum zram_pageflags flag)
 {
@@ -1473,15 +1510,11 @@ static bool zram_meta_alloc(struct zram *zram, u64 disksize)
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
@@ -2321,7 +2354,7 @@ static void zram_slot_free_notify(struct block_device *bdev,
 	zram = bdev->bd_disk->private_data;
 
 	atomic64_inc(&zram->stats.notify_free);
-	if (!zram_slot_trylock(zram, index)) {
+	if (!zram_slot_try_lock(zram, index)) {
 		atomic64_inc(&zram->stats.miss_free);
 		return;
 	}
@@ -2625,6 +2658,10 @@ static int zram_add(void)
 	if (ret)
 		goto out_cleanup_disk;
 
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	lockdep_register_key(&zram->table_lockdep_key);
+#endif
+
 	zram_debugfs_register(zram);
 	pr_info("Added device: %s\n", zram->disk->disk_name);
 	return device_id;
@@ -2681,6 +2718,10 @@ static int zram_remove(struct zram *zram)
 	 */
 	zram_reset_device(zram);
 
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	lockdep_unregister_key(&zram->table_lockdep_key);
+#endif
+
 	put_disk(zram->disk);
 	kfree(zram);
 	return 0;
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index db78d7c01b9a..63b933059cb6 100644
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
@@ -58,13 +58,18 @@ enum zram_pageflags {
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
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	struct lockdep_map lockdep_map;
+#endif
 #ifdef CONFIG_ZRAM_TRACK_ENTRY_ACTIME
 	ktime_t ac_time;
 #endif
@@ -137,5 +142,8 @@ struct zram {
 	struct dentry *debugfs_dir;
 #endif
 	atomic_t pp_in_progress;
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	struct lock_class_key table_lockdep_key;
+#endif
 };
 #endif
-- 
2.48.1.502.g6dc24dfdaf-goog


