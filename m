Return-Path: <linux-kernel+bounces-514358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A776A355EC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 05:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BD1C3AD976
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 04:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169C8186E54;
	Fri, 14 Feb 2025 04:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZYpWOKf2"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDD6185B48
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 04:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739508810; cv=none; b=oMoq85HFWUUNtn03gqS2ag+ZDD83Zuq+fwg09nfyMID4ZsAz5AYpNqfDijoGW3uBCF35uDHYqgDsuUHyDjdIU6M7FqxQRDoM303vsE+xysA5DnK1fnwySAvyonyCbgo4NOeGWRKPgBLJYurvevuyovEsD25OET4EoT7ewz1eBqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739508810; c=relaxed/simple;
	bh=jmAx9VzBvJEcK7LEsaUKoFFJmtepfH49Z010DExZrxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YfcI7eDMaKKpI0Cob4gizi72RYYKMBZZFbfsRyjA0IbCrnD7OCnLDPY3aep1qZKdeJ/uDTY3+gjOMXYlBMhOn5RTVsC6NhaosTf9PuejZWnN2PcodfDwwGh0WOrbAsMfszZV+j8a97f2JNKGzsSjf6uV5IYque+D+DBXfr5iILU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZYpWOKf2; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-220e83d65e5so15993545ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 20:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739508807; x=1740113607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qnJprTwBbnPgr4JVTYJPq6LS7kls9Uwm5mA/DEYKF7Y=;
        b=ZYpWOKf2wIM9KTHARFXMzP3NPE0KiS4fmHm7jh//ot/FZDWKTERs+53YCKXutFiXQL
         aOSD5anUPRpMmmhoWnRkJhzipUZD5q+5pmryJASnkjLwBH0RJR5C4ytQFn3gGA2TVGT1
         8flELVpKecCHkWjuWpuZ1A0t8sR9oJvbCmtRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739508807; x=1740113607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qnJprTwBbnPgr4JVTYJPq6LS7kls9Uwm5mA/DEYKF7Y=;
        b=PCin6uzyEYVA12UcCqHSjnRl1jQE5y9DF0ZlKWUPo8o0YrKn/Frx5tZ3ihgw8L26Yl
         qFmVDfWAQxm8ui6kENAQ/iNXwH+unIOZF2vYx8ylarW0nTftmxWPRU8lvLeWRrLzMEpM
         CwsY8GwzFO9PBeY412oEbqtWZpl7He5ZmT4QqAbCrtmSD1XkmJMuDYpZxeQZKdGo0PWj
         GTwbiVhG42dGyJOcdUiis4FippX9DyHvPfJDe7+ksLiSx3i5/L9ZqE/k+AT7itQNXdAl
         +6qmlIxLVMVu026OQdmXX/eJ1/qMzXOGEOYq6BzuK6k3Lw/AF1A2X/ZGiZTDQEzUeMAQ
         wW1w==
X-Forwarded-Encrypted: i=1; AJvYcCWEUkZx/37FZn+DeznSojNYeJrn3j/0kgqww3Td0pye1n9RbzIR08dlk85hJZa7T0XAVzbLHl2DMPTRCAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNIXSzMir+1RwOjY53uhYLcn3z3orzxRmHTOrHAdGbp/BJLJZl
	NR25OCmLKU6A2oYvzuyuJqaDnGAPiQa5NPjiViMqFlNhxwFUeehvR5kCMXGhsQ==
X-Gm-Gg: ASbGncvdPGi9gpkz3zpI3OCL+D/JHKJ4SVhOSxRnBIkp+uzpbWUKmqh5ZhCUqm8eeZJ
	nVpd+J7bYGGX7ljVYOvViSoSqwaSMUp0YMFlyNSnW1hdv+/I/RSPldY7yej2TXlmjRbUH5wF1yF
	1VRAhAmzB10NnzuVV/3nip4z35dOehIhKa5b1DYBXj114VEfr97ZehW3UN/XptXshOIjG6Y+A32
	FNrOnrmgx53y5lE5Skzxk7ekMsXAZ2iMAx9v1rlCd3cHDcJ0LSxqiw92iCQYuxU9OBOiUC1Hyy5
	QZsk9TDZoVPXhlyssA==
X-Google-Smtp-Source: AGHT+IFFD5AmsVRlFVnjhldrCVgoR4+3BSYYM094ysV/C/O/38mcNtXqChtRYmpdp4CXK407opgp9w==
X-Received: by 2002:a17:903:32c8:b0:220:ea90:192a with SMTP id d9443c01a7336-220ea901a5fmr37761435ad.5.1739508807544;
        Thu, 13 Feb 2025 20:53:27 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:942d:9291:22aa:8126])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d53492d0sm20892945ad.35.2025.02.13.20.53.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 20:53:27 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>,
	Hillf Danton <hdanton@sina.com>,
	Kairui Song <ryncsn@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v6 11/17] zsmalloc: make zspage lock preemptible
Date: Fri, 14 Feb 2025 13:50:23 +0900
Message-ID: <20250214045208.1388854-12-senozhatsky@chromium.org>
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
 mm/zsmalloc.c | 246 +++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 192 insertions(+), 54 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 2e338cde0d21..bc679a3e1718 100644
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
@@ -279,6 +294,148 @@ struct mapping_area {
 	enum zs_mapmode vm_mm; /* mapping mode */
 };
 
+static void zspage_lock_init(struct zspage *zspage)
+{
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	lockdep_init_map(&zspage->zsl.dep_map, "zspage->lock",
+			 &zspage->pool->lock_class, 0);
+#endif
+
+	spin_lock_init(&zspage->zsl.lock);
+	zspage->zsl.cnt = ZS_PAGE_UNLOCKED;
+}
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+static inline void __read_lock(struct zspage *zspage)
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
+static inline void __read_unlock(struct zspage *zspage)
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
+static inline bool __write_trylock(struct zspage *zspage)
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
+	lock_contended(&zsl->dep_map, _RET_IP_);
+	spin_unlock(&zsl->lock);
+	return false;
+}
+
+static inline void __write_unlock(struct zspage *zspage)
+{
+	struct zspage_lock *zsl = &zspage->zsl;
+
+	rwsem_release(&zsl->dep_map, _RET_IP_);
+
+	zsl->cnt = ZS_PAGE_UNLOCKED;
+	spin_unlock(&zsl->lock);
+}
+#else
+static inline void __read_lock(struct zspage *zspage)
+{
+	struct zspage_lock *zsl = &zspage->zsl;
+
+	spin_lock(&zsl->lock);
+	zsl->cnt++;
+	spin_unlock(&zsl->lock);
+}
+
+static inline void __read_unlock(struct zspage *zspage)
+{
+	struct zspage_lock *zsl = &zspage->zsl;
+
+	spin_lock(&zsl->lock);
+	zsl->cnt--;
+	spin_unlock(&zsl->lock);
+}
+
+static inline bool __write_trylock(struct zspage *zspage)
+{
+	struct zspage_lock *zsl = &zspage->zsl;
+
+	spin_lock(&zsl->lock);
+	if (zsl->cnt == ZS_PAGE_UNLOCKED) {
+		zsl->cnt = ZS_PAGE_WRLOCKED;
+		return true;
+	}
+
+	spin_unlock(&zsl->lock);
+	return false;
+}
+
+static inline void __write_unlock(struct zspage *zspage)
+{
+	struct zspage_lock *zsl = &zspage->zsl;
+
+	zsl->cnt = ZS_PAGE_UNLOCKED;
+	spin_unlock(&zsl->lock);
+}
+#endif /* CONFIG_DEBUG_LOCK_ALLOC */
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
+	return __read_lock(zspage);
+}
+
+static void zspage_read_unlock(struct zspage *zspage)
+{
+	return __read_unlock(zspage);
+}
+
+static __must_check bool zspage_write_trylock(struct zspage *zspage)
+{
+	return __write_trylock(zspage);
+}
+
+static void zspage_write_unlock(struct zspage *zspage)
+{
+	return __write_unlock(zspage);
+}
+
 /* huge object: pages_per_zspage == 1 && maxobj_per_zspage == 1 */
 static void SetZsHugePage(struct zspage *zspage)
 {
@@ -290,12 +447,6 @@ static bool ZsHugePage(struct zspage *zspage)
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
@@ -992,7 +1143,9 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
 		return NULL;
 
 	zspage->magic = ZSPAGE_MAGIC;
-	migrate_lock_init(zspage);
+	zspage->pool = pool;
+	zspage->class = class->index;
+	zspage_lock_init(zspage);
 
 	for (i = 0; i < class->pages_per_zspage; i++) {
 		struct zpdesc *zpdesc;
@@ -1015,8 +1168,6 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
 
 	create_page_chain(class, zspage, zpdescs);
 	init_zspage(class, zspage);
-	zspage->pool = pool;
-	zspage->class = class->index;
 
 	return zspage;
 }
@@ -1217,7 +1368,7 @@ void *zs_map_object(struct zs_pool *pool, unsigned long handle,
 	 * zs_unmap_object API so delegate the locking from class to zspage
 	 * which is smaller granularity.
 	 */
-	migrate_read_lock(zspage);
+	zspage_read_lock(zspage);
 	read_unlock(&pool->lock);
 
 	class = zspage_class(pool, zspage);
@@ -1277,7 +1428,7 @@ void zs_unmap_object(struct zs_pool *pool, unsigned long handle)
 	}
 	local_unlock(&zs_map_area.lock);
 
-	migrate_read_unlock(zspage);
+	zspage_read_unlock(zspage);
 }
 EXPORT_SYMBOL_GPL(zs_unmap_object);
 
@@ -1671,18 +1822,18 @@ static void lock_zspage(struct zspage *zspage)
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
@@ -1693,41 +1844,16 @@ static void lock_zspage(struct zspage *zspage)
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
@@ -1769,7 +1895,7 @@ static bool zs_page_isolate(struct page *page, isolate_mode_t mode)
 }
 
 static int zs_page_migrate(struct page *newpage, struct page *page,
-		enum migrate_mode mode)
+			   enum migrate_mode mode)
 {
 	struct zs_pool *pool;
 	struct size_class *class;
@@ -1785,9 +1911,6 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 
 	VM_BUG_ON_PAGE(!zpdesc_is_isolated(zpdesc), zpdesc_page(zpdesc));
 
-	/* We're committed, tell the world that this is a Zsmalloc page. */
-	__zpdesc_set_zsmalloc(newzpdesc);
-
 	/* The page is locked, so this pointer must remain valid */
 	zspage = get_zspage(zpdesc);
 	pool = zspage->pool;
@@ -1803,8 +1926,15 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
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
@@ -1835,7 +1965,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	 */
 	write_unlock(&pool->lock);
 	spin_unlock(&class->lock);
-	migrate_write_unlock(zspage);
+	zspage_write_unlock(zspage);
 
 	zpdesc_get(newzpdesc);
 	if (zpdesc_zone(newzpdesc) != zpdesc_zone(zpdesc)) {
@@ -1971,9 +2101,11 @@ static unsigned long __zs_compact(struct zs_pool *pool,
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
@@ -2233,7 +2365,9 @@ struct zs_pool *zs_create_pool(const char *name)
 	 * trigger compaction manually. Thus, ignore return code.
 	 */
 	zs_register_shrinker(pool);
-
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	lockdep_register_key(&pool->lock_class);
+#endif
 	return pool;
 
 err:
@@ -2270,6 +2404,10 @@ void zs_destroy_pool(struct zs_pool *pool)
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


