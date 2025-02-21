Return-Path: <linux-kernel+bounces-526743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3862CA402A9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 23:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12895422D73
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 22:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC55204599;
	Fri, 21 Feb 2025 22:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OY7o1aYE"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F51253B53
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 22:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740177017; cv=none; b=Rz0mQ/oP4lqUnReOpir4LWxb/tFTV6y4RnOyJgyk38cXB/ECFntUFi4MvDsoD6BfUJzMYWyaZ1VRH1fhn4cxtLLOucfnFZ7J9eP00YJKFOX/B0b771SZu9l1PQBFM664HcAFgHrUArpcrlgft0s75QB9MEZUzRDGEWSxoDKjMLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740177017; c=relaxed/simple;
	bh=NyFGcqmoYtnCAyTiqusVILoCVQf+i50FxvrQcze4GZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YbRXn5ycd9SFhRo3dSK3lsgPlS+MxprYOFn79CFosJIBtOvKKydKxqJCp3C5l0xKSbp5+sj3zHoasq+6wjyLCf1UPnxXRiw4zeXnDlqojEeFlsjU3t+TenY0vzAU34tVbQ7GyRKbR3YrIZJ2qGKdvVO5f/jn+OoFyyI94Yl3RHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OY7o1aYE; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-220bff984a0so53899275ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 14:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740177014; x=1740781814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vyf4VQS9dbJdyz0MwhcPGTpR7cg7WEhYb8zFP/ep/Cc=;
        b=OY7o1aYEoehrkN0L5XdCbq0m8bpHHHMCcm/I5Qp/b1e/7sW5mtfDFsMWdPRR0CvRhy
         TFUQk8r8z0txVb/ueYWmsjqthGrJ2A2NrI4WWBx775RUPpKWUVcnzz4fpvi5qp866WAn
         r1JlrkaFeq+pteM1FeZICsqYwe+VBg1IXW0rs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740177014; x=1740781814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vyf4VQS9dbJdyz0MwhcPGTpR7cg7WEhYb8zFP/ep/Cc=;
        b=b+Jlja358SUvHiFLOHxmliWxNZVVvW37MPpHfZvsV6Gw7rmRq10ShyYLc4jmVKrZc4
         xLUTn1aT1GsGBepGdYDj9xDd9Ntw6IHz9+8JcdQiyAJlivpHGLcD3JHhXfgKPIvLvKxU
         O3J9+DzRmtJOoALnxD0xVRfx5lizHQj5zMSupuGqbSizRHTow0Gwtf3urW5yBLsqeQPD
         pQARxwkH1PUjm2GQ0Bq9EazvqxF7lLUD8HzpLYJY38EDWpHNRRO1Ho6S0hgCX2gl3VJS
         fLXnQk5loK/PKm4YE2D3iOlhm40YramFe4lACpDAaJmz5ilGqEd4aQo42ToNzP/1UVG2
         4IXg==
X-Forwarded-Encrypted: i=1; AJvYcCXHYgj5Kkko4b8oyIt7CA8x/io3hFtg3oQKtW5EEsI0mdhlm32D692/KIVDE7rxPQIxD1PhUqUbStFBi88=@vger.kernel.org
X-Gm-Message-State: AOJu0YwspiHjMG5K6GVihg3L50HTD5QmbRTRWCj+yPWaFrUNBHVd581N
	2J+O4Y4Dje4bdjlSDk3SxCxtGfZbx/U1pwpBqZkAScNcwbDLeLO6PdJBP+AtbQ==
X-Gm-Gg: ASbGncukAeulqTRIvzGk1tbr1Snm7HwaIopyqaEEoTwJ0c8WwtBoptzsEjxDNwEEhE+
	Cf19AIJKhcbi9TXVgVNpWC2QvMop/gfhEp/UsyPIWi4EKw1EP5YlRrBV2HgDdxV02JxjYkoQ8mZ
	sm/9HXUzr+TNotgNzgEI6aILuZBcU9HuwotwU876ipTuPwQYvL9GGeGxzWr8E/MCmMm12qSxsLu
	oSaKGNqrHWOTGlF4YIPeqwxynWO/NHGk6PvX9ZrzU1cz5LbIH9DiFDFfHnycZ4G64z5GKcNJMeQ
	9gISTJrHWehW5uIdzQIAXrBBqCc=
X-Google-Smtp-Source: AGHT+IHofchBgt10CdVSO9Xcl4yHCl6fKy3NCLrLd0JwdaM3wh17mZmotiuBqqh8g/QoieHEYG/z2A==
X-Received: by 2002:a05:6a20:9149:b0:1ee:dd60:195b with SMTP id adf61e73a8af0-1eef3dea587mr9136695637.41.1740177014436;
        Fri, 21 Feb 2025 14:30:14 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:f987:e1e:3dbb:2191])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-adc9ff10056sm13408975a12.72.2025.02.21.14.30.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 14:30:14 -0800 (PST)
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
Subject: [PATCH v8 01/17] zram: sleepable entry locking
Date: Sat, 22 Feb 2025 07:25:32 +0900
Message-ID: <20250221222958.2225035-2-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
In-Reply-To: <20250221222958.2225035-1-senozhatsky@chromium.org>
References: <20250221222958.2225035-1-senozhatsky@chromium.org>
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
 drivers/block/zram/zram_drv.c | 62 ++++++++++++++++++++++++++++-------
 drivers/block/zram/zram_drv.h | 20 +++++++----
 2 files changed, 65 insertions(+), 17 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 9f5020b077c5..37c5651305c2 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -58,19 +58,62 @@ static void zram_free_page(struct zram *zram, size_t index);
 static int zram_read_from_zspool(struct zram *zram, struct page *page,
 				 u32 index);
 
-static int zram_slot_trylock(struct zram *zram, u32 index)
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#define slot_dep_map(zram, index) (&(zram)->table[(index)].dep_map)
+#define zram_lock_class(zram) (&(zram)->lock_class)
+#else
+#define slot_dep_map(zram, index) NULL
+#define zram_lock_class(zram) NULL
+#endif
+
+static void zram_slot_lock_init(struct zram *zram, u32 index)
 {
-	return spin_trylock(&zram->table[index].lock);
+	lockdep_init_map(slot_dep_map(zram, index),
+			 "zram->table[index].lock",
+			 zram_lock_class(zram), 0);
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
@@ -2625,6 +2663,7 @@ static int zram_add(void)
 	if (ret)
 		goto out_cleanup_disk;
 
+	lockdep_register_key(zram_lock_class(zram));
 	zram_debugfs_register(zram);
 	pr_info("Added device: %s\n", zram->disk->disk_name);
 	return device_id;
@@ -2653,6 +2692,7 @@ static int zram_remove(struct zram *zram)
 		zram->claim = true;
 	mutex_unlock(&zram->disk->open_mutex);
 
+	lockdep_unregister_key(zram_lock_class(zram));
 	zram_debugfs_unregister(zram);
 
 	if (claimed) {
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


