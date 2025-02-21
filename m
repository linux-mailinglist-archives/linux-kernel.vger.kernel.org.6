Return-Path: <linux-kernel+bounces-525488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F197A3F094
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5204189EA93
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8071720458B;
	Fri, 21 Feb 2025 09:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UQzPHBQN"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A252036E3
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 09:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740130730; cv=none; b=q7XYKfD+WzbypRT1rhc6gMSyy11AnZZlej4eNzhNmkiOQSEjTPWwsh6Na28XJFGcDORw1KTqo09W/PPVIVrz+Ttishbh0SqVQAqkYDi1K95ToNACrMrq/WvKhkE4HaidINj0aCLWOjcJOdbPTJhx7+LZxVao7rppV5XVtz87Gpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740130730; c=relaxed/simple;
	bh=2PHeV8nT/CIs0wVCCrZiQbqt2KzPBiFqKqwqGxUlrRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZyUbgfGKT6Izbr8rhFGxDpvzWXhxDoxPcdeahYPzy/vjaQnTxsJc715mQfELmM9p0nvNbr2yC8noHgwUuuBAR4r7LAOBzqopJ6VhvrybzeGASJZieCOs9xKOizc45ZWlUQ5wbo1ivz+1uby25GhD/nk4alwjBGJDHqbJhmWrAuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UQzPHBQN; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-220c4159f87so25834195ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 01:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740130728; x=1740735528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tEamf86sHM0Ptusd1ivjV+FzA+4m9NR9VbFHQMTSZrc=;
        b=UQzPHBQNiMxVvSgPDxEzVYSdYIRAOzIG30SyOO/8ilTW8Mz6U15c57V2VTNMUuBH1V
         lUR53fwlbw5nkA1bg3tmtuhkAb/DUc3lZ59V2okMdmDHA1LLSp1ETY6RTTLqhE3MfklS
         GJHvar3Xic033RMPRXx/Xt98NM3KfdQCeeoUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740130728; x=1740735528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tEamf86sHM0Ptusd1ivjV+FzA+4m9NR9VbFHQMTSZrc=;
        b=Jd/UE4ReB/Nuxxvqa70eljM7ggLiOp+36tdGV93TwRIYpOYs2ZEoBBf2Xu+cQjMJnP
         Ax1YP6K3fvVSH+oKtGet8qMjFfsVEAqtLpG86oSSTRvl0mKgXsH/WFzG+DfuQfs5p8dS
         cDne9HQxWR7IoRAnAq9VGXEVswSQMgC9Fx3597J044lPMiLOALfPn4N46Tpckxdn7i5R
         eRFn3jL9FT5Pqk8yK4CduJ6uO90FzDMMcW8Xor+KyQTufHBL05dSyGZ+XQi7lCXpp57E
         t1He9mkja78E34nrIDVqQvYD1tnxtzlqk7BIE6D/UJp7jqkDia3bnnIxMuqSo7s9aNUs
         LV4w==
X-Forwarded-Encrypted: i=1; AJvYcCUDeVs9GdTJLUw/62qYCXMOTVFb9OWHuXtFU/zUjcWO+BhrhT+CMYwljG1xJlCC7f8w8u6sNoODrDJcT5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxBFrTjeuNWOLxXbnH8dSh5OiXezDxngtsUsDu8uMYxDN9WE8+
	lK4KMzoJK1vMowwR9o0MRE7oevwXK42yItPRs6rq/gspTyTOgxQ8rrTz0URIFA==
X-Gm-Gg: ASbGncs2F/iHx9dIv/bYJHhzKh+jHMcfaQfJIutJdeYawKq9xoDQbtbNpfU8nmpV/Ua
	fxV0gDLwiPf6yN+PCF2WuK5qRzYkCm2xDsNUd4LnPWHfNrOoVN1tSXACuiSmYONTSqxSmaqRw3G
	w1G40QK77lFrNBNLPspak4fRNy6ZwEJPZi7joT9+WlTfxhkeHyHjwQ5dWdJTQyHQcwhMtWlObnX
	VkQLonqT/56C/pZGQwHUNtQ0S/u2J8lUbnx06DXkep1neOpygH0LhOdr2hCTB3SjPZwAMIC5xTB
	8IB6j3+2yAiUxcx2ZalSyEWEaQs=
X-Google-Smtp-Source: AGHT+IF6XPk6PTdI7TGgSavL9+4vaZz+bvaqDiLmdjUKVz/91xc480zPlBnpKvLh5Q/90+8Bn/sTSA==
X-Received: by 2002:a17:903:2350:b0:21f:515:d61 with SMTP id d9443c01a7336-2219ff4e78emr42043375ad.21.1740130728316;
        Fri, 21 Feb 2025 01:38:48 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:f987:e1e:3dbb:2191])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d556fb40sm132682925ad.193.2025.02.21.01.38.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 01:38:47 -0800 (PST)
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
Subject: [PATCH v7 01/17] zram: sleepable entry locking
Date: Fri, 21 Feb 2025 18:37:54 +0900
Message-ID: <20250221093832.1949691-2-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
In-Reply-To: <20250221093832.1949691-1-senozhatsky@chromium.org>
References: <20250221093832.1949691-1-senozhatsky@chromium.org>
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
 drivers/block/zram/zram_drv.c | 68 +++++++++++++++++++++++++++++------
 drivers/block/zram/zram_drv.h | 20 +++++++----
 2 files changed, 71 insertions(+), 17 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 9f5020b077c5..31bce7c3ce8b 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -58,19 +58,62 @@ static void zram_free_page(struct zram *zram, size_t index);
 static int zram_read_from_zspool(struct zram *zram, struct page *page,
 				 u32 index);
 
-static int zram_slot_trylock(struct zram *zram, u32 index)
+static void zram_slot_lock_init(struct zram *zram, u32 index)
 {
-	return spin_trylock(&zram->table[index].lock);
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	lockdep_init_map(&zram->table[index].dep_map,
+			 "zram->table[index].lock",
+			 &zram->lock_class, 0);
+#endif
+}
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#define slot_dep_map(zram, index) (&(zram)->table[(index)].dep_map)
+#else
+#define slot_dep_map(zram, index) NULL
+#endif
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
@@ -93,7 +136,6 @@ static void zram_set_handle(struct zram *zram, u32 index, unsigned long handle)
 	zram->table[index].handle = handle;
 }
 
-/* flag operations require table entry bit_spin_lock() being held */
 static bool zram_test_flag(struct zram *zram, u32 index,
 			enum zram_pageflags flag)
 {
@@ -1473,15 +1515,11 @@ static bool zram_meta_alloc(struct zram *zram, u64 disksize)
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
@@ -2625,6 +2663,10 @@ static int zram_add(void)
 	if (ret)
 		goto out_cleanup_disk;
 
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	lockdep_register_key(&zram->lock_class);
+#endif
+
 	zram_debugfs_register(zram);
 	pr_info("Added device: %s\n", zram->disk->disk_name);
 	return device_id;
@@ -2681,6 +2723,10 @@ static int zram_remove(struct zram *zram)
 	 */
 	zram_reset_device(zram);
 
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	lockdep_unregister_key(&zram->lock_class);
+#endif
+
 	put_disk(zram->disk);
 	kfree(zram);
 	return 0;
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index db78d7c01b9a..794c9234e627 100644
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
+	struct lockdep_map dep_map;
+#endif
 #ifdef CONFIG_ZRAM_TRACK_ENTRY_ACTIME
 	ktime_t ac_time;
 #endif
@@ -137,5 +142,8 @@ struct zram {
 	struct dentry *debugfs_dir;
 #endif
 	atomic_t pp_in_progress;
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	struct lock_class_key lock_class;
+#endif
 };
 #endif
-- 
2.48.1.601.g30ceb7b040-goog


