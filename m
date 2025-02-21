Return-Path: <linux-kernel+bounces-526753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 311F1A402B3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 23:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E79B7189E86A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 22:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04EF2512DB;
	Fri, 21 Feb 2025 22:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZR7KJhSm"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2975320966B
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 22:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740177073; cv=none; b=q5q/G9OAIfGSvga2rBoO6/n2Ibk4xH/HXmdM1V5VUAPUQF4d2R48wgC+WeaEq4rI0KXrMGz7Uh8BrCStwZY86mbyUwPG46L/PG4LY6uBi8W0V81+RkmirHswc62YQxoVXZ4aI/JS6+pIT/ElCZMGGDl/ySXyRtkPzvAi2A+BgZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740177073; c=relaxed/simple;
	bh=OoqWrtik41sphXCGZtsWoxLey9QRTTRk89oKKtGhD5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fTS9rBbWtEmaAH5QtjudHcpik05rJXfBBdX49v64VwuB+UFPZrhMTm0SbbHiACnpRQldhH4A72C4IWphH8zZvrVe04mw8qEqKozrL6Eg9TwrjQOJrIHy/VtNtr2GyTc5QJbiTmA+/pLf5906bZ1jw/5nRr20U7tojQBEd7MZuPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZR7KJhSm; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21c2f1b610dso75318405ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 14:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740177069; x=1740781869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y4hieFtM2l2Z0Gze73AM0fWmJUttGTKTNzwCP28e8QQ=;
        b=ZR7KJhSmx0ooyOXESN98TjPAMNzV1oS3AXy1FOIirDtik42XAJn6UwtXSSyYUFinmt
         e8pELLiV1NRH0fN0wX2+6fmheBWAJ/4rlRjbNcnFS051zHZRd7yaQyS0M1DI9yHsH9+u
         RTye+s/EKGOaNneEHC+TGdmOohfr9nPavs2UA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740177069; x=1740781869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y4hieFtM2l2Z0Gze73AM0fWmJUttGTKTNzwCP28e8QQ=;
        b=eY6BYs3S9wp8/sJehEYe71IpIUgD14TmFoZITw/Ms0tCVJhM3wx150+foOrleSfbWV
         RbH/E3tk3jzc+63XYd4EdAucoRAHjBGPVsdjeM2ySUkg18BKgRn/W2q4xfehfGBuuFo9
         HrOIX7x/SAURTbtRPuhdTO0ISlVLvN/oThhs0Y8+6h+HBVCcl4w+9/rbtbA8CSUmpKlM
         I7aHI1zNiBkJG5c7A8yeZ7JvGB5buWTnUUCOd+uSZyUKW2NgjnuZjIdqqsgWN6Jg6pon
         7Leomcyvi5DdutObZm1pVFhBhD73PRWge64WdFUhiPIeuABhgqc7AEqNmlHf3pZMm5We
         scEQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2g3MbsgrfCleVXvAqmrUsTRg5TWMAVifm6o4cBRqy85h2OG/T4CgqJtygV9KhdjYCydZ82I7hq/O/cCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ1QYn9ScG2xDyrsPKKnLRu7+Ay6Ni6NGHG11l0RmvhvQ05fW5
	8SEjceDmZJJqQDYmBGiH7Y3nyrGiKUQcukZc59poJ3VCPpw6+YrW2SYLbwqzzw==
X-Gm-Gg: ASbGncvlKVFeXcQ+r8LYP7FWDZjrJeVBnzWwz3I7iTsuyN8XU/kuR5B+UZWWNzZVC4U
	xuPkchZgsEnN6NJteKye2h4hteQhDzs3NZ9UCwOilwM5HC8OAc2stzrhEtQCskFPprTD5cgpQ7m
	3DVI+oA1ssqej/Gt8ygyv6tBTYnj67MNErPPj6iXIA2A43l+TcebDmAQRQ9n2NbzqXkAc/6oA1R
	FgbwRg/N8Ia2bsE0m1HGHCs5+F5y0gt44ngHHSkkzQ8lp7RWVUlzEdTJzkvrCAJzFsN7CzXwbzW
	CT0fxDKhnv+4lQI0V9MqtJz7UTc=
X-Google-Smtp-Source: AGHT+IFjDhSFSvfLZz11cldDF51zOwCTwD6xM3YT/eF2+EZ/8qQPdJ+e/mCN9snGHWZACIXCyeoKVQ==
X-Received: by 2002:a17:902:ea11:b0:216:55a1:35a with SMTP id d9443c01a7336-2219ff61e5cmr65829295ad.30.1740177069320;
        Fri, 21 Feb 2025 14:31:09 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:f987:e1e:3dbb:2191])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d545df28sm141974715ad.153.2025.02.21.14.31.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 14:31:09 -0800 (PST)
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
Subject: [PATCH v8 11/17] zsmalloc: make zspage lock preemptible
Date: Sat, 22 Feb 2025 07:25:42 +0900
Message-ID: <20250221222958.2225035-12-senozhatsky@chromium.org>
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

In order to implement preemptible object mapping we need a zspage lock
that satisfies several preconditions:
- it should be reader-write type of a lock
- it should be possible to hold it from any context, but also being
  preemptible if the context allows it
- we never sleep while acquiring but can sleep while holding in read
  mode

An rwsemaphore doesn't suffice, due to atomicity requirements, rwlock
doesn't satisfy due to reader-preemptability requirement.  It's also
worth to mention, that per-zspage rwsem is a little too memory heavy
(we can easily have double digits megabytes used only on rwsemaphores).

Switch over from rwlock_t to a atomic_t-based implementation of a
reader-writer semaphore that satisfies all of the preconditions.

The spin-lock based zspage_lock is suggested by Hillf Danton.

Suggested-by: Hillf Danton <hdanton@sina.com>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 mm/zsmalloc.c | 184 +++++++++++++++++++++++++++++++++++---------------
 1 file changed, 131 insertions(+), 53 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 1424ee73cbb5..03710d71d022 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -226,6 +226,9 @@ struct zs_pool {
 	/* protect zspage migration/compaction */
 	rwlock_t lock;
 	atomic_t compaction_in_progress;
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	struct lock_class_key lock_class;
+#endif
 };
 
 static inline void zpdesc_set_first(struct zpdesc *zpdesc)
@@ -257,6 +260,18 @@ static inline void free_zpdesc(struct zpdesc *zpdesc)
 	__free_page(page);
 }
 
+#define ZS_PAGE_UNLOCKED	0
+#define ZS_PAGE_WRLOCKED	-1
+
+struct zspage_lock {
+	spinlock_t lock;
+	int cnt;
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	struct lockdep_map dep_map;
+#endif
+};
+
 struct zspage {
 	struct {
 		unsigned int huge:HUGE_BITS;
@@ -269,7 +284,7 @@ struct zspage {
 	struct zpdesc *first_zpdesc;
 	struct list_head list; /* fullness list */
 	struct zs_pool *pool;
-	rwlock_t lock;
+	struct zspage_lock zsl;
 };
 
 struct mapping_area {
@@ -279,6 +294,93 @@ struct mapping_area {
 	enum zs_mapmode vm_mm; /* mapping mode */
 };
 
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#define zsl_dep_map(zsl) (&(zsl)->dep_map)
+#define zspool_lock_class(pool) (&(pool)->lock_class)
+#else
+#define zsl_dep_map(zsl) NULL
+#define zspool_lock_class(pool) NULL
+#endif
+
+static void zspage_lock_init(struct zspage *zspage)
+{
+	struct zspage_lock *zsl = &zspage->zsl;
+
+	lockdep_init_map(zsl_dep_map(zsl), "zspage->lock",
+			 zspool_lock_class(zspage->pool), 0);
+	spin_lock_init(&zsl->lock);
+	zsl->cnt = ZS_PAGE_UNLOCKED;
+}
+
+/*
+ * The zspage lock can be held from atomic contexts, but it needs to remain
+ * preemptible when held for reading because it remains held outside of those
+ * atomic contexts, otherwise we unnecessarily lose preemptibility.
+ *
+ * To achieve this, the following rules are enforced on readers and writers:
+ *
+ * - Writers are blocked by both writers and readers, while readers are only
+ *   blocked by writers (i.e. normal rwlock semantics).
+ *
+ * - Writers are always atomic (to allow readers to spin waiting for them).
+ *
+ * - Writers always use trylock (as the lock may be held be sleeping readers).
+ *
+ * - Readers may spin on the lock (as they can only wait for atomic writers).
+ *
+ * - Readers may sleep while holding the lock (as writes only use trylock).
+ */
+static void zspage_read_lock(struct zspage *zspage)
+{
+	struct zspage_lock *zsl = &zspage->zsl;
+
+	rwsem_acquire_read(zsl_dep_map(zsl), 0, 0, _RET_IP_);
+
+	spin_lock(&zsl->lock);
+	zsl->cnt++;
+	spin_unlock(&zsl->lock);
+
+	lock_acquired(zsl_dep_map(zsl), _RET_IP_);
+}
+
+static void zspage_read_unlock(struct zspage *zspage)
+{
+	struct zspage_lock *zsl = &zspage->zsl;
+
+	rwsem_release(zsl_dep_map(zsl), _RET_IP_);
+
+	spin_lock(&zsl->lock);
+	zsl->cnt--;
+	spin_unlock(&zsl->lock);
+}
+
+static __must_check bool zspage_write_trylock(struct zspage *zspage)
+{
+	struct zspage_lock *zsl = &zspage->zsl;
+
+	spin_lock(&zsl->lock);
+	if (zsl->cnt == ZS_PAGE_UNLOCKED) {
+		zsl->cnt = ZS_PAGE_WRLOCKED;
+		rwsem_acquire(zsl_dep_map(zsl), 0, 1, _RET_IP_);
+		lock_acquired(zsl_dep_map(zsl), _RET_IP_);
+		return true;
+	}
+
+	lock_contended(zsl_dep_map(zsl), _RET_IP_);
+	spin_unlock(&zsl->lock);
+	return false;
+}
+
+static void zspage_write_unlock(struct zspage *zspage)
+{
+	struct zspage_lock *zsl = &zspage->zsl;
+
+	rwsem_release(zsl_dep_map(zsl), _RET_IP_);
+
+	zsl->cnt = ZS_PAGE_UNLOCKED;
+	spin_unlock(&zsl->lock);
+}
+
 /* huge object: pages_per_zspage == 1 && maxobj_per_zspage == 1 */
 static void SetZsHugePage(struct zspage *zspage)
 {
@@ -290,12 +392,6 @@ static bool ZsHugePage(struct zspage *zspage)
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
@@ -992,7 +1088,9 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
 		return NULL;
 
 	zspage->magic = ZSPAGE_MAGIC;
-	migrate_lock_init(zspage);
+	zspage->pool = pool;
+	zspage->class = class->index;
+	zspage_lock_init(zspage);
 
 	for (i = 0; i < class->pages_per_zspage; i++) {
 		struct zpdesc *zpdesc;
@@ -1015,8 +1113,6 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
 
 	create_page_chain(class, zspage, zpdescs);
 	init_zspage(class, zspage);
-	zspage->pool = pool;
-	zspage->class = class->index;
 
 	return zspage;
 }
@@ -1217,7 +1313,7 @@ void *zs_map_object(struct zs_pool *pool, unsigned long handle,
 	 * zs_unmap_object API so delegate the locking from class to zspage
 	 * which is smaller granularity.
 	 */
-	migrate_read_lock(zspage);
+	zspage_read_lock(zspage);
 	read_unlock(&pool->lock);
 
 	class = zspage_class(pool, zspage);
@@ -1277,7 +1373,7 @@ void zs_unmap_object(struct zs_pool *pool, unsigned long handle)
 	}
 	local_unlock(&zs_map_area.lock);
 
-	migrate_read_unlock(zspage);
+	zspage_read_unlock(zspage);
 }
 EXPORT_SYMBOL_GPL(zs_unmap_object);
 
@@ -1671,18 +1767,18 @@ static void lock_zspage(struct zspage *zspage)
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
@@ -1693,41 +1789,16 @@ static void lock_zspage(struct zspage *zspage)
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
@@ -1785,9 +1856,6 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 
 	VM_BUG_ON_PAGE(!zpdesc_is_isolated(zpdesc), zpdesc_page(zpdesc));
 
-	/* We're committed, tell the world that this is a Zsmalloc page. */
-	__zpdesc_set_zsmalloc(newzpdesc);
-
 	/* The page is locked, so this pointer must remain valid */
 	zspage = get_zspage(zpdesc);
 	pool = zspage->pool;
@@ -1803,8 +1871,15 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	 * the class lock protects zpage alloc/free in the zspage.
 	 */
 	spin_lock(&class->lock);
-	/* the migrate_write_lock protects zpage access via zs_map_object */
-	migrate_write_lock(zspage);
+	/* the zspage write_lock protects zpage access via zs_map_object */
+	if (!zspage_write_trylock(zspage)) {
+		spin_unlock(&class->lock);
+		write_unlock(&pool->lock);
+		return -EINVAL;
+	}
+
+	/* We're committed, tell the world that this is a Zsmalloc page. */
+	__zpdesc_set_zsmalloc(newzpdesc);
 
 	offset = get_first_obj_offset(zpdesc);
 	s_addr = kmap_local_zpdesc(zpdesc);
@@ -1835,7 +1910,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	 */
 	write_unlock(&pool->lock);
 	spin_unlock(&class->lock);
-	migrate_write_unlock(zspage);
+	zspage_write_unlock(zspage);
 
 	zpdesc_get(newzpdesc);
 	if (zpdesc_zone(newzpdesc) != zpdesc_zone(zpdesc)) {
@@ -1971,9 +2046,11 @@ static unsigned long __zs_compact(struct zs_pool *pool,
 		if (!src_zspage)
 			break;
 
-		migrate_write_lock(src_zspage);
+		if (!zspage_write_trylock(src_zspage))
+			break;
+
 		migrate_zspage(pool, src_zspage, dst_zspage);
-		migrate_write_unlock(src_zspage);
+		zspage_write_unlock(src_zspage);
 
 		fg = putback_zspage(class, src_zspage);
 		if (fg == ZS_INUSE_RATIO_0) {
@@ -2141,6 +2218,7 @@ struct zs_pool *zs_create_pool(const char *name)
 	init_deferred_free(pool);
 	rwlock_init(&pool->lock);
 	atomic_set(&pool->compaction_in_progress, 0);
+	lockdep_register_key(zspool_lock_class(pool));
 
 	pool->name = kstrdup(name, GFP_KERNEL);
 	if (!pool->name)
@@ -2233,7 +2311,6 @@ struct zs_pool *zs_create_pool(const char *name)
 	 * trigger compaction manually. Thus, ignore return code.
 	 */
 	zs_register_shrinker(pool);
-
 	return pool;
 
 err:
@@ -2270,6 +2347,7 @@ void zs_destroy_pool(struct zs_pool *pool)
 		kfree(class);
 	}
 
+	lockdep_unregister_key(zspool_lock_class(pool));
 	destroy_cache(pool);
 	kfree(pool->name);
 	kfree(pool);
-- 
2.48.1.601.g30ceb7b040-goog


