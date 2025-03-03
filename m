Return-Path: <linux-kernel+bounces-540885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E919A4B616
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 03:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E27613A346E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 02:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1271E2847;
	Mon,  3 Mar 2025 02:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hjH/w9Ob"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5780C188CDB
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 02:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740968740; cv=none; b=nB2L19wmmr1aFe3HViIiZxfHnLbaoM7bWhYalGVAk5D6UK8jdZX4bPsgjq+zhZ3MU/Waedaxn6+sXgOgbUbSy86nltlLmyFRuoXr67dKXZljXVLh6BizrPZVHwsieINRH6qInqqSvnomcdgFg7AOjH/RvyaY6FbfRrV412E6xNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740968740; c=relaxed/simple;
	bh=5e1Mw52dK5rWahT2ui1CD/SDhXblwaXUyFSdhkgPlkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jRRoG7jIQETymF0yRmQIouFJjL06MJ4024FIAmMXJz6PnrOv1VfhFg+BHkKtt14SSOIssHhu4pG+a9YoHiNgLl7j3A10DbqBQPLLSO4gJWhHclslerxqLTT5VLiJo0AUFEJ27ytgAdK+osoNK83xmMnNSZPlAFZSCxQIP7ynomI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hjH/w9Ob; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22337bc9ac3so72886855ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 18:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740968738; x=1741573538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ua9rnaxl59hYuly6c376LLOYIZDnLCeuJzWW228A97g=;
        b=hjH/w9Obudy67Qyw2NUgMapFo9xoB48ZgwujFADcGoDeR/K5qhhYli0mOIvCTrHU97
         DoGAiEs3XsiY6w4rO3UWGmOh5jftz300Iiu5ofiBITO7lTbZmFR1Sq/B/V2j8A1rFXGo
         t/BOeKnfxMGpmVVJ/yvOASKOgBMRXB5Nq15XI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740968738; x=1741573538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ua9rnaxl59hYuly6c376LLOYIZDnLCeuJzWW228A97g=;
        b=kqcepy4SfA/4zmAWEd194IVBUKo+rLUwjtYfGv0BBYx9YrAh/FuQTPHKqSESmeEBSZ
         RS/MLL3Wurv4N6W5+y8UHWacKqU1q27qCwOyGoAdOuXRmHohLhIkQUmNqO7P8ah7RNt6
         JpD8GJlKSV6sEHJbgFEH7REAZZML9OgZYjTguUmMYZDMU2QNGbiPZfSzgoZ6vTttE99P
         U6g/qRAh2UL3xdams8dais71gjU2+AlbcR4rJm1fK2lTlrDqqWYA+9GC/0SNwLZ1HQtW
         9vAWbHsL/h8++HDyLd139+ZatNQDyrNCMMNLfM0SybthxfAdvuE8DWt7tuqCUmjlOgx+
         qH1g==
X-Forwarded-Encrypted: i=1; AJvYcCUKss2rSLNveXxE0GtsbnGVlDbO7/4YcAkAP/7wGGmRAvpOnxoVugwQYfajC1JsIPz2FzW2fBwvJWMD4Wk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPyHFwvSaTexfT5T9NhtQ7i4qGZ1/EKcIJ4AXGaYouR/ynTHof
	LXzrS9T678osu+zoYUlPiSWmEISRUfbfU8yIZUY8iGhLiliuQ3da39yQQnU4Pw==
X-Gm-Gg: ASbGncuSKNBYwg0t3Fp1WpJW9ZpbhWYqHLp/Jeq+XnbJDb8pNnKwXhttjFaZuFcSkV9
	I1KIKyr3aWKu3HOnr5Z7SMakvU5KWuF1q6EL91KZ5nf5xKAS8yTyT+uhnHski7T2nFrv3oGnYpG
	egkKSY8ahsOXZ4ycsQNKv3Ao+m/7lPwzlNsQKZHyBRarHoftNQ/5rWvOU50s+4qe7qp9hoV1ku5
	+TiA2qeMrVw6nejL/sssuhlgF6HNTwj8DYR81c6oxuJmOouMG3e34iFLxMRoP40GusOLm66/v+K
	kbqe+C93g8uPq5hqGH3Z9JDg3q9X/R6xSG+FZ43wDvVfkCI=
X-Google-Smtp-Source: AGHT+IHtZ5c68bsAtTNZLqPzKISnIUv2uwTEuuqfc15VikOP6YUn0971YwA/MQ1+Ofo0Wu55CvXwCA==
X-Received: by 2002:a05:6a00:a91:b0:730:99cb:7c32 with SMTP id d2e1a72fcca58-734ac350410mr17588314b3a.7.1740968737528;
        Sun, 02 Mar 2025 18:25:37 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:1513:4f61:a4d3:b418])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7356173aedfsm5377318b3a.95.2025.03.02.18.25.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Mar 2025 18:25:37 -0800 (PST)
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
Subject: [PATCH v10 13/19] zsmalloc: sleepable zspage reader-lock
Date: Mon,  3 Mar 2025 11:03:22 +0900
Message-ID: <20250303022425.285971-14-senozhatsky@chromium.org>
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
 mm/zsmalloc.c | 166 ++++++++++++++++++++++++++++++++++----------------
 1 file changed, 114 insertions(+), 52 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 1424ee73cbb5..afbd72363731 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -257,6 +257,15 @@ static inline void free_zpdesc(struct zpdesc *zpdesc)
 	__free_page(page);
 }
 
+#define ZS_PAGE_UNLOCKED	0
+#define ZS_PAGE_WRLOCKED	-1
+
+struct zspage_lock {
+	spinlock_t lock;
+	int cnt;
+	struct lockdep_map dep_map;
+};
+
 struct zspage {
 	struct {
 		unsigned int huge:HUGE_BITS;
@@ -269,7 +278,7 @@ struct zspage {
 	struct zpdesc *first_zpdesc;
 	struct list_head list; /* fullness list */
 	struct zs_pool *pool;
-	rwlock_t lock;
+	struct zspage_lock zsl;
 };
 
 struct mapping_area {
@@ -279,6 +288,84 @@ struct mapping_area {
 	enum zs_mapmode vm_mm; /* mapping mode */
 };
 
+static void zspage_lock_init(struct zspage *zspage)
+{
+	static struct lock_class_key __key;
+	struct zspage_lock *zsl = &zspage->zsl;
+
+	lockdep_init_map(&zsl->dep_map, "zspage->lock", &__key, 0);
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
+	rwsem_acquire_read(&zsl->dep_map, 0, 0, _RET_IP_);
+
+	spin_lock(&zsl->lock);
+	zsl->cnt++;
+	spin_unlock(&zsl->lock);
+
+	lock_acquired(&zsl->dep_map, _RET_IP_);
+}
+
+static void zspage_read_unlock(struct zspage *zspage)
+{
+	struct zspage_lock *zsl = &zspage->zsl;
+
+	rwsem_release(&zsl->dep_map, _RET_IP_);
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
+		rwsem_acquire(&zsl->dep_map, 0, 1, _RET_IP_);
+		lock_acquired(&zsl->dep_map, _RET_IP_);
+		return true;
+	}
+
+	spin_unlock(&zsl->lock);
+	return false;
+}
+
+static void zspage_write_unlock(struct zspage *zspage)
+{
+	struct zspage_lock *zsl = &zspage->zsl;
+
+	rwsem_release(&zsl->dep_map, _RET_IP_);
+
+	zsl->cnt = ZS_PAGE_UNLOCKED;
+	spin_unlock(&zsl->lock);
+}
+
 /* huge object: pages_per_zspage == 1 && maxobj_per_zspage == 1 */
 static void SetZsHugePage(struct zspage *zspage)
 {
@@ -290,12 +377,6 @@ static bool ZsHugePage(struct zspage *zspage)
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
@@ -992,7 +1073,9 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
 		return NULL;
 
 	zspage->magic = ZSPAGE_MAGIC;
-	migrate_lock_init(zspage);
+	zspage->pool = pool;
+	zspage->class = class->index;
+	zspage_lock_init(zspage);
 
 	for (i = 0; i < class->pages_per_zspage; i++) {
 		struct zpdesc *zpdesc;
@@ -1015,8 +1098,6 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
 
 	create_page_chain(class, zspage, zpdescs);
 	init_zspage(class, zspage);
-	zspage->pool = pool;
-	zspage->class = class->index;
 
 	return zspage;
 }
@@ -1217,7 +1298,7 @@ void *zs_map_object(struct zs_pool *pool, unsigned long handle,
 	 * zs_unmap_object API so delegate the locking from class to zspage
 	 * which is smaller granularity.
 	 */
-	migrate_read_lock(zspage);
+	zspage_read_lock(zspage);
 	read_unlock(&pool->lock);
 
 	class = zspage_class(pool, zspage);
@@ -1277,7 +1358,7 @@ void zs_unmap_object(struct zs_pool *pool, unsigned long handle)
 	}
 	local_unlock(&zs_map_area.lock);
 
-	migrate_read_unlock(zspage);
+	zspage_read_unlock(zspage);
 }
 EXPORT_SYMBOL_GPL(zs_unmap_object);
 
@@ -1671,18 +1752,18 @@ static void lock_zspage(struct zspage *zspage)
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
@@ -1693,41 +1774,16 @@ static void lock_zspage(struct zspage *zspage)
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
@@ -1785,9 +1841,6 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 
 	VM_BUG_ON_PAGE(!zpdesc_is_isolated(zpdesc), zpdesc_page(zpdesc));
 
-	/* We're committed, tell the world that this is a Zsmalloc page. */
-	__zpdesc_set_zsmalloc(newzpdesc);
-
 	/* The page is locked, so this pointer must remain valid */
 	zspage = get_zspage(zpdesc);
 	pool = zspage->pool;
@@ -1803,8 +1856,15 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
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
@@ -1835,7 +1895,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	 */
 	write_unlock(&pool->lock);
 	spin_unlock(&class->lock);
-	migrate_write_unlock(zspage);
+	zspage_write_unlock(zspage);
 
 	zpdesc_get(newzpdesc);
 	if (zpdesc_zone(newzpdesc) != zpdesc_zone(zpdesc)) {
@@ -1971,9 +2031,11 @@ static unsigned long __zs_compact(struct zs_pool *pool,
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
-- 
2.48.1.711.g2feabab25a-goog


