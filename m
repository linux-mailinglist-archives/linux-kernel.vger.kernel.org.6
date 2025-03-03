Return-Path: <linux-kernel+bounces-540873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5604CA4B608
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 03:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE9453AF771
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 02:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDD6189913;
	Mon,  3 Mar 2025 02:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fcdQkdjA"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B8217CA1B
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 02:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740968683; cv=none; b=Jh7MyIrLDr0INay0xHqKP50yV8idmhWRNz00NuRX9BriO5Fl5rybz0Ts188sZ19gqquOUNnPMQzSSyh5kZl6K2GePdyg3xvW5ANyJSbVnH6UW2pnJkJ+IY/B/ypxVAFccYlYaI98bHtEezcwMs9EgeYIYSzA0ch+MYrpRWTs6ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740968683; c=relaxed/simple;
	bh=Ueba+oa0oa0PlNzLN9Uzd8MRvSnqENM622OyfHdWL+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rc0aAWALOqxUV8SRzZHOn8Kiux6p+wsxz0cuznukNkKS9BtURNODTdiXb6Dt91X5lpNWDSKuflYb7FWTvcqOiDAzcvebU/U19d1vbDW2YjxRObLMMOQvkVq2yjWaoh1RyA3S/4GNL7rblLoy72q/OD0DMILOQFYQMXTWjSxlw7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fcdQkdjA; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2f9b9c0088fso6591084a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 18:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740968681; x=1741573481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=24epfTRD5B0/Gn0qvdHVkfmT+fNP4MZPLg9AakHcZPk=;
        b=fcdQkdjArD+e0N5ajKPC2TgXyj2kIraBpBQpLvB9yzX+eYZwvHH863qGOu3eTO0/5F
         6zOa9pcUdPcompt4bmCo0QlqC2D8iTdD9yTi8WGEHsb/2I6RASB9EumE2aUPELfa3T2c
         ADgR6OFpm7Ys4MzY1QWzPICrQUxezV5Ct22Lg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740968681; x=1741573481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=24epfTRD5B0/Gn0qvdHVkfmT+fNP4MZPLg9AakHcZPk=;
        b=BxWHpTu3ZLBhUGlxa/PO/R/e2sKtMlQOypxchNvJVMpD9wl38gYcT2IR5NsTJL8IX3
         5yLoI9hvnAu2hueLRL9xOPc30zMorEZ4Ax24HSru0WAx5KGr8fKHI3TKqnD9kICn2CYV
         B2vmVUT4l0RINduZIj8CZLVA26xzpXKpfOjm28uC2+o5aqtpfW9WIHyxwmKBp37FxNbX
         B1PfhY9+o3pi3QyTNVJiXG/Jriycs5vyE/ZW6rEJ1TnyPFQJgliDQFSGUFx35eOpe4I/
         c1czYVuMkb5f/Rm9Rf3CAzqajSwI7pGqP/Axo9zbYzaZrFrjkNXO6KIw6ndAf7pI5Faq
         TGzg==
X-Forwarded-Encrypted: i=1; AJvYcCVNrKxGz/RcDExgmbpNkExSSv/UpP8Op+cL4QkS27k7CKS6xelA9+etJEB5dEWXvWyds+8fl7vcPTxxNcc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzmcCZjFWbAjhR1dYijyACkOXaQ7yT5001pNczlCFKzS05uLpd
	RsIWk0uAR0JLDxejT8nUp2Ig6Ko6iPjyKjPOYTa9ch7BzS7RPRSzGx4nVJdZYQ==
X-Gm-Gg: ASbGncuA6TNXwRk5qsYIHWbaHwPvZMbRWgu16IxLzCIofq3ErC2S4sf/tuu8kEe8Thc
	V6NWJ6I52tZ/Veqgg4ZbE+O18T3OKSi79nTpwkUU5NHZueTWEwTSa7wpKBsuCz4M/0yxDQ4dxxp
	qARUn4hUS2jv9b0+3w2X/16dVcOzeODDMRGXfw2uxK300il7PhOQp0/WssBDBqbPxEAez+urZiV
	JgCReOzybKKFPZYpM1obAAwREYXh5dNkrMusnDnaGS1qcwR8hDx6G3kHaZIHpAt7iX8nk2Z05jv
	T9xRgMYJZrPyJYSYKfD5GWwR/GymChDGEuZf9EHuFO0/ovc=
X-Google-Smtp-Source: AGHT+IEzPpFTdNA4qdxJB0dxJj4fKFXJpJ2zIhvE5aIYLQNZyq296Wz9RmH9FDhwIK3/6h7XuPIjIQ==
X-Received: by 2002:a17:90b:3884:b0:2fa:2252:f436 with SMTP id 98e67ed59e1d1-2feba5ced0cmr17673056a91.3.1740968680936;
        Sun, 02 Mar 2025 18:24:40 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:1513:4f61:a4d3:b418])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-223501d2610sm66715445ad.14.2025.03.02.18.24.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Mar 2025 18:24:40 -0800 (PST)
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
Subject: [PATCH v10 01/19] zram: sleepable entry locking
Date: Mon,  3 Mar 2025 11:03:10 +0900
Message-ID: <20250303022425.285971-2-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
In-Reply-To: <20250303022425.285971-1-senozhatsky@chromium.org>
References: <20250303022425.285971-1-senozhatsky@chromium.org>
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
 drivers/block/zram/zram_drv.c | 54 ++++++++++++++++++++++++++++-------
 drivers/block/zram/zram_drv.h | 15 ++++++----
 2 files changed, 52 insertions(+), 17 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 9f5020b077c5..70599d41b828 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -58,19 +58,56 @@ static void zram_free_page(struct zram *zram, size_t index);
 static int zram_read_from_zspool(struct zram *zram, struct page *page,
 				 u32 index);
 
-static int zram_slot_trylock(struct zram *zram, u32 index)
+#define slot_dep_map(zram, index) (&(zram)->table[(index)].dep_map)
+
+static void zram_slot_lock_init(struct zram *zram, u32 index)
+{
+	static struct lock_class_key __key;
+
+	lockdep_init_map(slot_dep_map(zram, index), "zram->table[index].lock",
+			 &__key, 0);
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
 {
-	return spin_trylock(&zram->table[index].lock);
+	unsigned long *lock = &zram->table[index].flags;
+
+	if (!test_and_set_bit_lock(ZRAM_ENTRY_LOCK, lock)) {
+		mutex_acquire(slot_dep_map(zram, index), 0, 1, _RET_IP_);
+		lock_acquired(slot_dep_map(zram, index), _RET_IP_);
+		return true;
+	}
+
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
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index db78d7c01b9a..c804f78a7fa8 100644
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
-- 
2.48.1.711.g2feabab25a-goog


