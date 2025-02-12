Return-Path: <linux-kernel+bounces-510579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F9CA31F0A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 07:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 415453A96F0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 06:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2A61FF5EB;
	Wed, 12 Feb 2025 06:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="awL+YitN"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B93202C2D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 06:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739341985; cv=none; b=C7qxUy1f3hzvjhPd7LFKfXYnaJf4hfEs/tnegn17HZTTqaaBnHUeymo/eJLfk8dssZ0LrdyyxesZQxpSFXNVxLAVaJ/qC3Pr7LYoZ64ldFEnajC52ycTkVVKSOQ9lpuzEcUvfXcAbOJchK7VuNz+WRjGLUaHzSzm6qCaMUyDf+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739341985; c=relaxed/simple;
	bh=+ZmibeS3s1Hk7g8ASbFMW04vf9D0deCx4rN7HHvjO0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZuHtSPCP/uhrOFFt2H/8cGqwRtL/pLu5HD4KxzWZ4cIjKJ+vztrU49U8FOYpnVkog/I0C5qYIVbyCDgy0QyZE6ZDn4Ze9dXaUzswTZEoVtKuV2r+pBrDLc/3L1v3qXwoIsIq9p389TmrsYtt0soBYJ1x0emY0yCD7yt4r920SDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=awL+YitN; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2fbffe0254fso20738a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 22:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739341982; x=1739946782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BwlPMmfdw4MbZw7eUNqN2h6GCS8i0cwiXU5uZLysFGk=;
        b=awL+YitNpJ23rZWcwLyUeOnn7crThAYD+3xioyHds/cXeUnJlmO4xuB0c1IDqRHyKb
         2Pw3NdyOsuFP89oQ2jWRMPlflC438CddxX4ybh9uw5ZNd616V9yjis0s06uu2HPAUmf3
         5lVrEzm9cKf17Tbo/NwrFJYJLPR0WWgLRcqGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739341982; x=1739946782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BwlPMmfdw4MbZw7eUNqN2h6GCS8i0cwiXU5uZLysFGk=;
        b=QPkliBquFyO6AiJa3l2LWYO4ADRpbpn1ixYEciCg9Q0ThM+KxV30J5EeIeKYdnshE+
         SFEpTofBBnm9DCeMXRF/Ji7dPyTHLNEPFRV9osuYM3QM2+z3PQ6n563Hvlpxqa1cva97
         U83PAE6AWBLqRIGQ/iPPf/ynS+Q0fbeBoDnXTLZGPoyTrnZbKziFi4vi+XjEMGyPhoDv
         Wz4tuf96C6TsQ+VdgZGROy/cnhw8dCwg1ncCgkQw4Q96VC0n1T7qIQ/MEGPZ+8u0p+5Y
         O0WX4a9r0bnZtXihIwIGPf2PiO5/YhTdVDd0qT/KKXZX0Dzqr29MOlR91hrrkjI5kmXl
         FmMA==
X-Forwarded-Encrypted: i=1; AJvYcCVtjgEBrSzxWO0uy2P1rcuvJFtMJqoa1CVxFX8bhfCgQHjDnLpz4S2IU8kwSXwRzR6OqV/gA1IM2ekNDUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YynyS+aic95MTSE/cWn8jdBQKijHGKmLipSndlpB0x4DmJ6JOdi
	we3F/enbV9O2psl+o+tgODt0U+95EWZqYq0qg/kOVupmQokArchiKfRAEgL0Mw==
X-Gm-Gg: ASbGnctqEXF0BU0eLUpvuvuVuYWgvSHPhID+ih7DYU5KFKBLfIQ+zjTCQt6pT2tIjBH
	1c1x2nw/LlA+z7x9OZbgrUxmI5nel+tqDnfOt3Kw5DTY0hbhzSzJENmlpPnWX7rZIlJhmi0oHcB
	JGMBgiGb4ei/xdmwNODMuSBpNTbdg2bq9POf6Co6jE8EKN38zbdxwrxkiqfLo+zdDScoSnJTwbB
	zLiivzHSWUoicjKDreapbFGKBmmwKobwK3Da4sgZlt79sh6ul/2HDkysadzrqn5m3372U+Xf5qf
	CoYRi/nsZtiCKGm7ZA==
X-Google-Smtp-Source: AGHT+IGBqbR5rsHnduepMOHV/sDsvhxru/3OZYfP4l3JaDq83WR0FHW+hFPpJFYdg17e8CIob6LH9g==
X-Received: by 2002:a05:6a00:1804:b0:732:24ad:8e15 with SMTP id d2e1a72fcca58-7322c39ac1amr3180602b3a.11.1739341982467;
        Tue, 11 Feb 2025 22:33:02 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:69f5:6852:451e:8142])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7308e22e7e3sm4826244b3a.6.2025.02.11.22.33.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 22:33:02 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>,
	Kairui Song <ryncsn@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v5 12/18] zsmalloc: make zspage lock preemptible
Date: Wed, 12 Feb 2025 15:27:10 +0900
Message-ID: <20250212063153.179231-13-senozhatsky@chromium.org>
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

Switch over from rwlock_t to a atomic_t variable that takes negative
value when the page is under migration, or positive values when the
page is used by zsmalloc users (object map, etc.)   Using a rwsem
per-zspage is a little too memory heavy, a simple atomic_t should
suffice.

zspage lock is a leaf lock for zs_map_object(), where it's read-acquired.
Since this lock now permits preemption extra care needs to be taken when
it is write-acquired - all writers grab it in atomic context, so they
cannot spin and wait for (potentially preempted) reader to unlock zspage.
There are only two writers at this moment - migration and compaction.  In
both cases we use write-try-lock and bail out if zspage is read locked.
Writers, on the other hand, never get preempted, so readers can spin
waiting for the writer to unlock zspage.

With this we can implement a preemptible object mapping.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>
---
 mm/zsmalloc.c | 183 +++++++++++++++++++++++++++++++++++---------------
 1 file changed, 128 insertions(+), 55 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index c82c24b8e6a4..80261bb78cf8 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -226,6 +226,9 @@ struct zs_pool {
 	/* protect page/zspage migration */
 	rwlock_t lock;
 	atomic_t compaction_in_progress;
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	struct lock_class_key lockdep_key;
+#endif
 };
 
 static void pool_write_unlock(struct zs_pool *pool)
@@ -292,6 +295,9 @@ static inline void free_zpdesc(struct zpdesc *zpdesc)
 	__free_page(page);
 }
 
+#define ZS_PAGE_UNLOCKED	0
+#define ZS_PAGE_WRLOCKED	-1
+
 struct zspage {
 	struct {
 		unsigned int huge:HUGE_BITS;
@@ -304,7 +310,11 @@ struct zspage {
 	struct zpdesc *first_zpdesc;
 	struct list_head list; /* fullness list */
 	struct zs_pool *pool;
-	rwlock_t lock;
+	atomic_t lock;
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	struct lockdep_map lockdep_map;
+#endif
 };
 
 struct mapping_area {
@@ -314,6 +324,88 @@ struct mapping_area {
 	enum zs_mapmode vm_mm; /* mapping mode */
 };
 
+static void zspage_lock_init(struct zspage *zspage)
+{
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	lockdep_init_map(&zspage->lockdep_map, "zsmalloc-page",
+			 &zspage->pool->lockdep_key, 0);
+#endif
+
+	atomic_set(&zspage->lock, ZS_PAGE_UNLOCKED);
+}
+
+/*
+ * zspage locking rules:
+ *
+ * 1) writer-lock is exclusive
+ *
+ * 2) writer-lock owner cannot sleep
+ *
+ * 3) writer-lock owner cannot spin waiting for the lock
+ *   - caller (e.g. compaction and migration) must check return value and
+ *     handle locking failures
+ *   - there is only TRY variant of writer-lock function
+ *
+ * 4) reader-lock owners (multiple) can sleep
+ *
+ * 5) reader-lock owners can spin waiting for the lock, in any context
+ *   - existing readers (even preempted ones) don't block new readers
+ *   - writer-lock owners never sleep, always unlock at some point
+ */
+static void zspage_read_lock(struct zspage *zspage)
+{
+	atomic_t *lock = &zspage->lock;
+	int old = atomic_read_acquire(lock);
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	rwsem_acquire_read(&zspage->lockdep_map, 0, 0, _RET_IP_);
+#endif
+
+	do {
+		if (old == ZS_PAGE_WRLOCKED) {
+			cpu_relax();
+			old = atomic_read_acquire(lock);
+			continue;
+		}
+	} while (!atomic_try_cmpxchg_acquire(lock, &old, old + 1));
+}
+
+static void zspage_read_unlock(struct zspage *zspage)
+{
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	rwsem_release(&zspage->lockdep_map, _RET_IP_);
+#endif
+	atomic_dec_return_release(&zspage->lock);
+}
+
+static __must_check bool zspage_try_write_lock(struct zspage *zspage)
+{
+	atomic_t *lock = &zspage->lock;
+	int old = ZS_PAGE_UNLOCKED;
+
+	WARN_ON_ONCE(preemptible());
+
+	preempt_disable();
+	if (atomic_try_cmpxchg_acquire(lock, &old, ZS_PAGE_WRLOCKED)) {
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+		rwsem_acquire(&zspage->lockdep_map, 0, 1, _RET_IP_);
+#endif
+		return true;
+	}
+
+	preempt_enable();
+	return false;
+}
+
+static void zspage_write_unlock(struct zspage *zspage)
+{
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	rwsem_release(&zspage->lockdep_map, _RET_IP_);
+#endif
+	atomic_set_release(&zspage->lock, ZS_PAGE_UNLOCKED);
+	preempt_enable();
+}
+
 /* huge object: pages_per_zspage == 1 && maxobj_per_zspage == 1 */
 static void SetZsHugePage(struct zspage *zspage)
 {
@@ -325,12 +417,6 @@ static bool ZsHugePage(struct zspage *zspage)
 	return zspage->huge;
 }
 
-static void migrate_lock_init(struct zspage *zspage);
-static void migrate_read_lock(struct zspage *zspage);
-static void migrate_read_unlock(struct zspage *zspage);
-static void migrate_write_lock(struct zspage *zspage);
-static void migrate_write_unlock(struct zspage *zspage);
-
 #ifdef CONFIG_COMPACTION
 static void kick_deferred_free(struct zs_pool *pool);
 static void init_deferred_free(struct zs_pool *pool);
@@ -1026,7 +1112,9 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
 		return NULL;
 
 	zspage->magic = ZSPAGE_MAGIC;
-	migrate_lock_init(zspage);
+	zspage->pool = pool;
+	zspage->class = class->index;
+	zspage_lock_init(zspage);
 
 	for (i = 0; i < class->pages_per_zspage; i++) {
 		struct zpdesc *zpdesc;
@@ -1049,8 +1137,6 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
 
 	create_page_chain(class, zspage, zpdescs);
 	init_zspage(class, zspage);
-	zspage->pool = pool;
-	zspage->class = class->index;
 
 	return zspage;
 }
@@ -1251,7 +1337,7 @@ void *zs_map_object(struct zs_pool *pool, unsigned long handle,
 	 * zs_unmap_object API so delegate the locking from class to zspage
 	 * which is smaller granularity.
 	 */
-	migrate_read_lock(zspage);
+	zspage_read_lock(zspage);
 	pool_read_unlock(pool);
 
 	class = zspage_class(pool, zspage);
@@ -1311,7 +1397,7 @@ void zs_unmap_object(struct zs_pool *pool, unsigned long handle)
 	}
 	local_unlock(&zs_map_area.lock);
 
-	migrate_read_unlock(zspage);
+	zspage_read_unlock(zspage);
 }
 EXPORT_SYMBOL_GPL(zs_unmap_object);
 
@@ -1705,18 +1791,18 @@ static void lock_zspage(struct zspage *zspage)
 	/*
 	 * Pages we haven't locked yet can be migrated off the list while we're
 	 * trying to lock them, so we need to be careful and only attempt to
-	 * lock each page under migrate_read_lock(). Otherwise, the page we lock
+	 * lock each page under zspage_read_lock(). Otherwise, the page we lock
 	 * may no longer belong to the zspage. This means that we may wait for
 	 * the wrong page to unlock, so we must take a reference to the page
-	 * prior to waiting for it to unlock outside migrate_read_lock().
+	 * prior to waiting for it to unlock outside zspage_read_lock().
 	 */
 	while (1) {
-		migrate_read_lock(zspage);
+		zspage_read_lock(zspage);
 		zpdesc = get_first_zpdesc(zspage);
 		if (zpdesc_trylock(zpdesc))
 			break;
 		zpdesc_get(zpdesc);
-		migrate_read_unlock(zspage);
+		zspage_read_unlock(zspage);
 		zpdesc_wait_locked(zpdesc);
 		zpdesc_put(zpdesc);
 	}
@@ -1727,41 +1813,16 @@ static void lock_zspage(struct zspage *zspage)
 			curr_zpdesc = zpdesc;
 		} else {
 			zpdesc_get(zpdesc);
-			migrate_read_unlock(zspage);
+			zspage_read_unlock(zspage);
 			zpdesc_wait_locked(zpdesc);
 			zpdesc_put(zpdesc);
-			migrate_read_lock(zspage);
+			zspage_read_lock(zspage);
 		}
 	}
-	migrate_read_unlock(zspage);
+	zspage_read_unlock(zspage);
 }
 #endif /* CONFIG_COMPACTION */
 
-static void migrate_lock_init(struct zspage *zspage)
-{
-	rwlock_init(&zspage->lock);
-}
-
-static void migrate_read_lock(struct zspage *zspage) __acquires(&zspage->lock)
-{
-	read_lock(&zspage->lock);
-}
-
-static void migrate_read_unlock(struct zspage *zspage) __releases(&zspage->lock)
-{
-	read_unlock(&zspage->lock);
-}
-
-static void migrate_write_lock(struct zspage *zspage)
-{
-	write_lock(&zspage->lock);
-}
-
-static void migrate_write_unlock(struct zspage *zspage)
-{
-	write_unlock(&zspage->lock);
-}
-
 #ifdef CONFIG_COMPACTION
 
 static const struct movable_operations zsmalloc_mops;
@@ -1803,7 +1864,7 @@ static bool zs_page_isolate(struct page *page, isolate_mode_t mode)
 }
 
 static int zs_page_migrate(struct page *newpage, struct page *page,
-		enum migrate_mode mode)
+			   enum migrate_mode mode)
 {
 	struct zs_pool *pool;
 	struct size_class *class;
@@ -1819,15 +1880,12 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 
 	VM_BUG_ON_PAGE(!zpdesc_is_isolated(zpdesc), zpdesc_page(zpdesc));
 
-	/* We're committed, tell the world that this is a Zsmalloc page. */
-	__zpdesc_set_zsmalloc(newzpdesc);
-
 	/* The page is locked, so this pointer must remain valid */
 	zspage = get_zspage(zpdesc);
 	pool = zspage->pool;
 
 	/*
-	 * The pool lock protects the race between zpage migration
+	 * The pool->lock protects the race between zpage migration
 	 * and zs_free.
 	 */
 	pool_write_lock(pool);
@@ -1837,8 +1895,15 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	 * the class lock protects zpage alloc/free in the zspage.
 	 */
 	size_class_lock(class);
-	/* the migrate_write_lock protects zpage access via zs_map_object */
-	migrate_write_lock(zspage);
+	/* the zspage write_lock protects zpage access via zs_map_object */
+	if (!zspage_try_write_lock(zspage)) {
+		size_class_unlock(class);
+		pool_write_unlock(pool);
+		return -EINVAL;
+	}
+
+	/* We're committed, tell the world that this is a Zsmalloc page. */
+	__zpdesc_set_zsmalloc(newzpdesc);
 
 	offset = get_first_obj_offset(zpdesc);
 	s_addr = kmap_local_zpdesc(zpdesc);
@@ -1869,7 +1934,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	 */
 	pool_write_unlock(pool);
 	size_class_unlock(class);
-	migrate_write_unlock(zspage);
+	zspage_write_unlock(zspage);
 
 	zpdesc_get(newzpdesc);
 	if (zpdesc_zone(newzpdesc) != zpdesc_zone(zpdesc)) {
@@ -2005,9 +2070,11 @@ static unsigned long __zs_compact(struct zs_pool *pool,
 		if (!src_zspage)
 			break;
 
-		migrate_write_lock(src_zspage);
+		if (!zspage_try_write_lock(src_zspage))
+			break;
+
 		migrate_zspage(pool, src_zspage, dst_zspage);
-		migrate_write_unlock(src_zspage);
+		zspage_write_unlock(src_zspage);
 
 		fg = putback_zspage(class, src_zspage);
 		if (fg == ZS_INUSE_RATIO_0) {
@@ -2267,7 +2334,9 @@ struct zs_pool *zs_create_pool(const char *name)
 	 * trigger compaction manually. Thus, ignore return code.
 	 */
 	zs_register_shrinker(pool);
-
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	lockdep_register_key(&pool->lockdep_key);
+#endif
 	return pool;
 
 err:
@@ -2304,6 +2373,10 @@ void zs_destroy_pool(struct zs_pool *pool)
 		kfree(class);
 	}
 
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	lockdep_unregister_key(&pool->lockdep_key);
+#endif
+
 	destroy_cache(pool);
 	kfree(pool->name);
 	kfree(pool);
-- 
2.48.1.502.g6dc24dfdaf-goog


