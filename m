Return-Path: <linux-kernel+bounces-514348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 211A6A355E1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 05:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C992716DD9D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 04:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C849188CD8;
	Fri, 14 Feb 2025 04:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OMYBkowV"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B299188704
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 04:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739508747; cv=none; b=uJhnaMTaBQ1pNRYYMXoYaPGTDf9jE4tDDKI6wNxBMCT/yRiJ8b8oHLyaYYgpCulUnI0f4P+862sndbghypBrwujo/nuh9kua/zRLWTo9CcQFPCKUMouEqgYdnE7N7OEHj1nfZAUtwlXQ9aHOD5vrJejgfPE8+LbVsWPgRT90Mt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739508747; c=relaxed/simple;
	bh=Blyd3YPW6njqDUqhcU13sU79nqRZ3wtUsF7vCotFKpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vole9joegakjdZIfTYsRKzq0csD8VWC3UNJ6dkCjxPeDL2xQ/LrJC1YjOM8HsMMq/A1iiTf/4nU2cy8OjfHyA7WyuP4ddMSjyV0dyQaVx3l3A0t5m+jMQJDxk6caCfybCpMLjMNQAg4lilO8lx1PPHul2GFv7EfLvuwqOOxiuZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OMYBkowV; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2fa1a3c88c5so2431422a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 20:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739508745; x=1740113545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Ip299Sr+pOGhTseTfOOpc4VtCVbO+2qU2TEqvTRYlA=;
        b=OMYBkowV2nv1mZuyOh3ftnd8ohDjP7mAAp3Zg8yZw+SYVhqurETqOOAuBj0eMpNW3G
         4LkuXOcnLyMCh4sNaDvsvKC0woLUp8hsqHMemUiDM2yjtvrL02bfgfXCvj+1ccFQwyR1
         C7LJjQ24dEreiZ6xxsOMchOOZ7B6fSczz3ahY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739508745; x=1740113545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Ip299Sr+pOGhTseTfOOpc4VtCVbO+2qU2TEqvTRYlA=;
        b=dlkzhqZkw/NNaHlqNhbXl2uw6o7o8IPP+zMLrNP0oJNHDQuwVgZCmqSKb7Bsc3hZL0
         GfKoKkCsdbOsLA3sM6miiczKD18bGOPIYdE8QLxvxCjQv6YJ7CrqHoi6DSgkT1ZDar02
         uyu08mwAtFkEZvL5ViMFtsfVBNdmn7LKRdsZSv2a84yO9rcpHRl29+2gK1cLLfHJ2qZU
         v1ElmUKFBtIOL3bDjfWqJB8UfhLlBXe9ts39YhDDMVkInddfIJnbdhYeaHEw5L+4YGz7
         MjW4aEj4PUBMEH4FXq5utw9Yj4MUq9BoxOVNr3sjdoiwP1z97b9E233NAt1dyOkzOs3B
         NzDw==
X-Forwarded-Encrypted: i=1; AJvYcCVOaCacqKUrEz2zpKfzzjdYCSzlGn42YFkMQ6azyB6uRVYkSppV0i/FW4mqlnjSFiVQe5EGXPDWHyncXLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwyPKbzBkB6i5l49UOcmkKKzk5H4wzlzIndYbrIlQgMFdVmYob
	xC5q3pYuKihGzrpz5jVDcBYEaXgl761vCNCV1ehcWutGwDjsxJXHX4pne6jG8g==
X-Gm-Gg: ASbGncsqYYrlwtTlLzEbWxP7E3jEtDp/lp/qIMcG6g+dokpEGKKOLy7lLElY4HzKTG4
	qfwxQxUBdtNyoTVK9Nm35RweznlOCHCxn6EbvrFQ8A1LoOg8GYiG2v0udKbAwumVjeQrzWlCE7M
	8JBNnHL6IWPZcXTqeDWKKbdsgNXyC4kD/EeuLqIaRKbFFMH3cwkCLO6g/1GIO/crN/2XSQMC936
	3PGhHNCsOoLoQgD5YIez74WukP9qRr2duaEcX6u+VAml+BjdvU/8pSBTNNmS6A4ewDEw1AhMwmp
	eY1jmqMkP6uUcUxMZA==
X-Google-Smtp-Source: AGHT+IElhSM58kSia8Ygok9EIOPYpgVDSk1Jw5b34RsIuUpVrp592z+ExnE3ByHbPmlZ4fx+OfAh+g==
X-Received: by 2002:a05:6a00:3989:b0:729:a31:892d with SMTP id d2e1a72fcca58-7322c591baemr18875311b3a.8.1739508745187;
        Thu, 13 Feb 2025 20:52:25 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:942d:9291:22aa:8126])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7324f64a39asm588836b3a.69.2025.02.13.20.52.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 20:52:24 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>,
	Hillf Danton <hdanton@sina.com>,
	Kairui Song <ryncsn@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v6 01/17] zram: sleepable entry locking
Date: Fri, 14 Feb 2025 13:50:13 +0900
Message-ID: <20250214045208.1388854-2-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
In-Reply-To: <20250214045208.1388854-1-senozhatsky@chromium.org>
References: <20250214045208.1388854-1-senozhatsky@chromium.org>
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
 drivers/block/zram/zram_drv.c | 105 ++++++++++++++++++++++++++++++----
 drivers/block/zram/zram_drv.h |  20 +++++--
 2 files changed, 108 insertions(+), 17 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 9f5020b077c5..65e16117f2db 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -58,19 +58,99 @@ static void zram_free_page(struct zram *zram, size_t index);
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
+static inline bool __slot_trylock(struct zram *zram, u32 index)
+{
+	struct lockdep_map *dep_map = &zram->table[index].dep_map;
+	unsigned long *lock = &zram->table[index].flags;
+
+	if (!test_and_set_bit_lock(ZRAM_ENTRY_LOCK, lock)) {
+		mutex_acquire(dep_map, 0, 1, _RET_IP_);
+		lock_acquired(dep_map, _RET_IP_);
+		return true;
+	}
+
+	lock_contended(dep_map, _RET_IP_);
+	return false;
+}
+
+static inline void __slot_lock(struct zram *zram, u32 index)
+{
+	struct lockdep_map *dep_map = &zram->table[index].dep_map;
+	unsigned long *lock = &zram->table[index].flags;
+
+	mutex_acquire(dep_map, 0, 0, _RET_IP_);
+	wait_on_bit_lock(lock, ZRAM_ENTRY_LOCK, TASK_UNINTERRUPTIBLE);
+	lock_acquired(dep_map, _RET_IP_);
+}
+
+static inline void __slot_unlock(struct zram *zram, u32 index)
+{
+	struct lockdep_map *dep_map = &zram->table[index].dep_map;
+	unsigned long *lock = &zram->table[index].flags;
+
+	mutex_release(dep_map, _RET_IP_);
+	clear_and_wake_up_bit(ZRAM_ENTRY_LOCK, lock);
+}
+#else
+static inline bool __slot_trylock(struct zram *zram, u32 index)
+{
+	unsigned long *lock = &zram->table[index].flags;
+
+	if (!test_and_set_bit_lock(ZRAM_ENTRY_LOCK, lock))
+		return true;
+	return false;
+}
+
+static inline void __slot_lock(struct zram *zram, u32 index)
+{
+	unsigned long *lock = &zram->table[index].flags;
+
+	wait_on_bit_lock(lock, ZRAM_ENTRY_LOCK, TASK_UNINTERRUPTIBLE);
+}
+
+static inline void __slot_unlock(struct zram *zram, u32 index)
+{
+	unsigned long *lock = &zram->table[index].flags;
+
+	clear_and_wake_up_bit(ZRAM_ENTRY_LOCK, lock);
+}
+#endif /* CONFIG_DEBUG_LOCK_ALLOC */
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
+	return __slot_trylock(zram, index);
 }
 
 static void zram_slot_lock(struct zram *zram, u32 index)
 {
-	spin_lock(&zram->table[index].lock);
+	return __slot_lock(zram, index);
 }
 
 static void zram_slot_unlock(struct zram *zram, u32 index)
 {
-	spin_unlock(&zram->table[index].lock);
+	return __slot_unlock(zram, index);
 }
 
 static inline bool init_done(struct zram *zram)
@@ -93,7 +173,6 @@ static void zram_set_handle(struct zram *zram, u32 index, unsigned long handle)
 	zram->table[index].handle = handle;
 }
 
-/* flag operations require table entry bit_spin_lock() being held */
 static bool zram_test_flag(struct zram *zram, u32 index,
 			enum zram_pageflags flag)
 {
@@ -1473,15 +1552,11 @@ static bool zram_meta_alloc(struct zram *zram, u64 disksize)
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
@@ -2625,6 +2700,10 @@ static int zram_add(void)
 	if (ret)
 		goto out_cleanup_disk;
 
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	lockdep_register_key(&zram->lock_class);
+#endif
+
 	zram_debugfs_register(zram);
 	pr_info("Added device: %s\n", zram->disk->disk_name);
 	return device_id;
@@ -2681,6 +2760,10 @@ static int zram_remove(struct zram *zram)
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


