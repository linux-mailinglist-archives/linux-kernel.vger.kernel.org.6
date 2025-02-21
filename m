Return-Path: <linux-kernel+bounces-525506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDF0A3F0B8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0828F861077
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6884C204F6B;
	Fri, 21 Feb 2025 09:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eZPY08Vj"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AC320A5DE
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 09:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740130786; cv=none; b=fUOuvKzO35sVzduniFQhaPBEDXJM4ATawQhsU2VhOQrzyhrzRYf01PtoXLu33xbvALtaauV39Phhoi3gbJ+KM1N+9c/BgkGGUN9NVKEmIOt0PHvdD7iMay1felBZUDI3DvGD56Q+8xYr+uRLF9LIZwOAVsJsUgKHIGbsj2ZXgw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740130786; c=relaxed/simple;
	bh=cAo/HQW5zQAU3/uebP+gQe6IvkUZ/gcH7MVwdPPmoxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mnf2eLPjfBqE64OpJJ3Yo7nPs6PL5/qLlYMy2za282dxJfAdlMC+Y161W1qRVaN69lWlOk9I0QUo696SNmyjoowoZ9o9/2pyNYJteXs4EEQk72NtWbusSTsdVaYAnAWTumEgxOo7jTeB5i1dM/cVRrPEaBRDGDiO/6dfrdDzsfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eZPY08Vj; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-220c8f38febso39303505ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 01:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740130784; x=1740735584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c43sUKc+c1340lwZZrmUjsY+PbdZGHYK9fwL3MZ7pbk=;
        b=eZPY08VjcSW/+n+ANd+csEvSIRm7cfVnHtL3Xjpy6Rzqul+NYM508Fr8rURI/7LwNV
         SMTahfovPfKU15nXc+v4J2LCCyJxjxiVYzM/IT8rDdUUDQrccMZovTwZwZTPzpaSnt4e
         ahlislT5QvB2ebba/hU61wiR6TJT1y8I62M2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740130784; x=1740735584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c43sUKc+c1340lwZZrmUjsY+PbdZGHYK9fwL3MZ7pbk=;
        b=kjgtHYs13Q+s+ak0tWxjkq6RVQ8Nr/3uHf63q4AJySnkI/BtFu/rrW8cvPVNG63+KF
         DRmSGmGXQyJZGmbVHKR4BcD7Snbw/cgVK0SKX6oMQXpBrAnmc3CtmAjcXs6Pf+mq/qUj
         Hgl8rs2BpuSnsUkeJJdq11fsqHEZ6WPgvJ0e9Df1oJVrtgqR4LuAO3TNqHzJjEMfAzIc
         Al57iaAeIm2uinpav55lW4HXQ6JOBbZQXlu3kAjYBdk6mOIdZvvA+axXfCAadGB+EJta
         2cjSWW1XW2mDWbhcuXtgxmy51UStDHqQUCTN899zx/sPQcQEMqzqjAt6Ojwe0rQ4SGxV
         badQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrYxDBoqkEARhFz13ljYPQbEiD8LbWkuJ6pmZR+ECKoLYbw4CcQ9sgoYMeBXUHeHWCsJsq88BH7szHwww=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOvqWChSbYWzmcjts88xbtSF62YLK0TLB2V5MFJnroq4VFmYz9
	YkwaRV/BfKSXCdMJ5lvBn1OKFZfgbU4wMO1qEdPEAf/S8ridEh1I/wa/T9EIFg==
X-Gm-Gg: ASbGncspCBRxCJPS6Y82cFNl7i10zry18m5qAP/GoMsDWSyLRWhr9nBQhpM1Jr5tCxM
	nW80OjlurQNYqFOtFe7hxUSEojjZwMZIaviAL7K8ga1c/9MK6CA/YlZxiCngaWh0OBNmQwVyin4
	JNzkgB1hfk2cXWTu5z3QfJyyumeA9CeRkyzPktuL+ITn3rGT//3gAaI0uLz+opOa4vJtQ0Wt0jI
	pupr1i5vYTCjyCLBc7PcWzE/vSX/bnZiJKfNgByBDG6el9lnHxYxVAoBAcu+AT5tr5dV22dqY5b
	j/UJBrJWOLuNbAvIzWxfpuGe5Fo=
X-Google-Smtp-Source: AGHT+IGQLO+1U1vS6Lct91u4p8i4NavSONuQ6g0x/XphxsfnVjWvF85vBjeEIzZsrJ0hPSWktsRKtw==
X-Received: by 2002:a17:902:e783:b0:219:e4b0:4286 with SMTP id d9443c01a7336-2219ffc00d7mr41532145ad.29.1740130783941;
        Fri, 21 Feb 2025 01:39:43 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:f987:e1e:3dbb:2191])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d545d4bcsm132919005ad.144.2025.02.21.01.39.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 01:39:43 -0800 (PST)
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
Subject: [PATCH v7 11/17] zsmalloc: make zspage lock preemptible
Date: Fri, 21 Feb 2025 18:38:04 +0900
Message-ID: <20250221093832.1949691-12-senozhatsky@chromium.org>
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
 mm/zsmalloc.c | 189 +++++++++++++++++++++++++++++++++++---------------
 1 file changed, 135 insertions(+), 54 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 1424ee73cbb5..250f1fddaf34 100644
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
@@ -279,6 +294,91 @@ struct mapping_area {
 	enum zs_mapmode vm_mm; /* mapping mode */
 };
 
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#define zsl_dep_map(zsl) (&(zsl)->dep_map)
+#else
+#define zsl_dep_map(zsl) NULL
+#endif
+
+static void zspage_lock_init(struct zspage *zspage)
+{
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	lockdep_init_map(&zspage->zsl.dep_map, "zspage->lock",
+			 &zspage->pool->lock_class, 0);
+#endif
+	spin_lock_init(&zspage->zsl.lock);
+	zspage->zsl.cnt = ZS_PAGE_UNLOCKED;
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
@@ -290,12 +390,6 @@ static bool ZsHugePage(struct zspage *zspage)
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
@@ -992,7 +1086,9 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
 		return NULL;
 
 	zspage->magic = ZSPAGE_MAGIC;
-	migrate_lock_init(zspage);
+	zspage->pool = pool;
+	zspage->class = class->index;
+	zspage_lock_init(zspage);
 
 	for (i = 0; i < class->pages_per_zspage; i++) {
 		struct zpdesc *zpdesc;
@@ -1015,8 +1111,6 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
 
 	create_page_chain(class, zspage, zpdescs);
 	init_zspage(class, zspage);
-	zspage->pool = pool;
-	zspage->class = class->index;
 
 	return zspage;
 }
@@ -1217,7 +1311,7 @@ void *zs_map_object(struct zs_pool *pool, unsigned long handle,
 	 * zs_unmap_object API so delegate the locking from class to zspage
 	 * which is smaller granularity.
 	 */
-	migrate_read_lock(zspage);
+	zspage_read_lock(zspage);
 	read_unlock(&pool->lock);
 
 	class = zspage_class(pool, zspage);
@@ -1277,7 +1371,7 @@ void zs_unmap_object(struct zs_pool *pool, unsigned long handle)
 	}
 	local_unlock(&zs_map_area.lock);
 
-	migrate_read_unlock(zspage);
+	zspage_read_unlock(zspage);
 }
 EXPORT_SYMBOL_GPL(zs_unmap_object);
 
@@ -1671,18 +1765,18 @@ static void lock_zspage(struct zspage *zspage)
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
@@ -1693,41 +1787,16 @@ static void lock_zspage(struct zspage *zspage)
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
@@ -1769,7 +1838,7 @@ static bool zs_page_isolate(struct page *page, isolate_mode_t mode)
 }
 
 static int zs_page_migrate(struct page *newpage, struct page *page,
-		enum migrate_mode mode)
+			   enum migrate_mode mode)
 {
 	struct zs_pool *pool;
 	struct size_class *class;
@@ -1785,9 +1854,6 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 
 	VM_BUG_ON_PAGE(!zpdesc_is_isolated(zpdesc), zpdesc_page(zpdesc));
 
-	/* We're committed, tell the world that this is a Zsmalloc page. */
-	__zpdesc_set_zsmalloc(newzpdesc);
-
 	/* The page is locked, so this pointer must remain valid */
 	zspage = get_zspage(zpdesc);
 	pool = zspage->pool;
@@ -1803,8 +1869,15 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
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
@@ -1835,7 +1908,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	 */
 	write_unlock(&pool->lock);
 	spin_unlock(&class->lock);
-	migrate_write_unlock(zspage);
+	zspage_write_unlock(zspage);
 
 	zpdesc_get(newzpdesc);
 	if (zpdesc_zone(newzpdesc) != zpdesc_zone(zpdesc)) {
@@ -1971,9 +2044,11 @@ static unsigned long __zs_compact(struct zs_pool *pool,
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
@@ -2233,7 +2308,9 @@ struct zs_pool *zs_create_pool(const char *name)
 	 * trigger compaction manually. Thus, ignore return code.
 	 */
 	zs_register_shrinker(pool);
-
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	lockdep_register_key(&pool->lock_class);
+#endif
 	return pool;
 
 err:
@@ -2270,6 +2347,10 @@ void zs_destroy_pool(struct zs_pool *pool)
 		kfree(class);
 	}
 
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	lockdep_unregister_key(&pool->lock_class);
+#endif
+
 	destroy_cache(pool);
 	kfree(pool->name);
 	kfree(pool);
-- 
2.48.1.601.g30ceb7b040-goog


