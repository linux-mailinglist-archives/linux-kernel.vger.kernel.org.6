Return-Path: <linux-kernel+bounces-510577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2831CA31F07
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 07:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 064247A2797
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 06:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3501FF1C5;
	Wed, 12 Feb 2025 06:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RdFGV9Sk"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C024C20102D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 06:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739341975; cv=none; b=KmLQpsouLH8+ww4GqPPyGxoF4L7oOnZl8u9uQO6VqjX9pSnT22mGUJnRu9n3CaHhrK4j2WrIhLFPjYlMDuqb5gg/au9vqe4MUsVkWBnplNA7WN1NpfSE0DmIAR6z9q6M1CZZ/N8SkPpE3Kag0RNoZMpmB9IA3UmymHUijR2JaMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739341975; c=relaxed/simple;
	bh=9Vx0WYJ2miMeZYqFk4IUJzt8mlgRl+8ieJ507QhwuX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UZXJrqZZv88lyHoGfQ1fLSSVeT62SrfYjTuPysGzgtjsIjiePJhGY5c+3uXg6FaV2/xPhP5D6jDdzEg2a7zJi54pzoG1HE/XMqaIT+Fyp6X5ZHyx4Cv+QwlDlVPJOsUPUGwLPeA+VLq1FRWE9Vu6vnRDXcMXzdcQUV4Q+S4QO9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RdFGV9Sk; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21f710c17baso68787605ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 22:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739341973; x=1739946773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+hKSGhtq9SEMO5RmXUCmDriDLy9gufp9/zvmYkmXcc=;
        b=RdFGV9SkC678DZKlba0/QjiP2iMebkjJ1+XDk8geyJ6XDLQByNGzKs4CEblmgGfFyO
         XlbWI33ozsQUrvaeOUQlqifiCoSHEBq0m3T8Cqe8B9/MqrZqlYd8ilbiViip3YK8FMge
         Ds4c/ZWAex89iZRVYgcemOF8sAOHzSwi1pQaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739341973; x=1739946773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J+hKSGhtq9SEMO5RmXUCmDriDLy9gufp9/zvmYkmXcc=;
        b=TODbaTIgBFpvi6A8jETOma+pWu+8yyemwBxDM+vVzFKIY0TdUq5TJ07eVY9Pk6GgCw
         LX3/ugYt/VXYEVdN6bxQ5AJrhRG6s9oKRHjJZIIi8NyRyB7zhUC80vsj+JhM4uGIUsCn
         uh158Rfrxb4So4MRlf3+az0PeBGxQ7LzV236ANcj9qes8Tz1QgU+w4WWM8tf47o6jETF
         UsP6aGu13BHkLA/fU3L7K95ihW6Idb6iVcUucdbp5io9QrUqtK08wFa138TYpNLx6a/M
         0cNzHCoEI/rwLKu/ltx1JlomtEatYlhisWk9Ci6UbHSgA5e63pSk5WiAn3T1Vgw++uWg
         7sRQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5WoUw5U7rTIMiSqK1EJHZMeBQ1vJImhSvVz+w89/8+jbyNfKqx4GvNBZmWYNaYDEYq+N5VRRNEgneSPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbXLHT61Euv16BcU88MK3uXbAgcbg5sU2lL8N7wECcsQ8TBkon
	pD5rLgU4RMHjp5gesmgsU8sBAVO0CdYlFu902Z5ysN8AQlCOUTH4Z/hINmWfgw==
X-Gm-Gg: ASbGncuGgUQOjCMgl363lAGQmQy4lrhwaBjF2mkRQTlR0MZ+skD5m2duqagFoANkfGM
	+Co9gExgnZ6vtqOSXokX1kUfJH/oHswqssz+RGZWbg824usY4APGU6Lj1kLjO3iTH9Rox849IIR
	pWoXJ42SEGkWQu2vHONDvyhZ7j5vkzNMxRstnE0DOnwJHEuAZ0fGWaQOhh7vs044CopE1i1DuE8
	ZvJ043mNvg9T6W8YkgCh3LqaJjSNT/WnTsJZhFoIS0XDQ0gRNbZwlDHwtyfvTBpL7aqenEu3bxF
	HI02e/dJfx6lQiHCnQ==
X-Google-Smtp-Source: AGHT+IGDl9mV+HtGUyn4myzfZBpkMQ7To3I2eCgVPnnWhAaFxnQ0KIUaHGWBSJNUrky9tjmUsZBSrQ==
X-Received: by 2002:a05:6a20:3943:b0:1ee:650b:ac22 with SMTP id adf61e73a8af0-1ee650bb853mr710537637.40.1739341972819;
        Tue, 11 Feb 2025 22:32:52 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:69f5:6852:451e:8142])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73077975f05sm7037787b3a.14.2025.02.11.22.32.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 22:32:52 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>,
	Kairui Song <ryncsn@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v5 10/18] zsmalloc: factor out pool locking helpers
Date: Wed, 12 Feb 2025 15:27:08 +0900
Message-ID: <20250212063153.179231-11-senozhatsky@chromium.org>
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

We currently have a mix of migrate_{read,write}_lock() helpers
that lock zspages, but it's zs_pool that actually has a ->migrate_lock
access to which is opene-coded.  Factor out pool migrate locking
into helpers, zspage migration locking API will be renamed to
reduce confusion.

It's worth mentioning that zsmalloc locks sync not only migration,
but also compaction.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 mm/zsmalloc.c | 63 +++++++++++++++++++++++++++++++++++----------------
 1 file changed, 44 insertions(+), 19 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 6d0e47f7ae33..47c638df47c5 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -18,7 +18,7 @@
 /*
  * lock ordering:
  *	page_lock
- *	pool->migrate_lock
+ *	pool->lock
  *	class->lock
  *	zspage->lock
  */
@@ -224,10 +224,35 @@ struct zs_pool {
 	struct work_struct free_work;
 #endif
 	/* protect page/zspage migration */
-	rwlock_t migrate_lock;
+	rwlock_t lock;
 	atomic_t compaction_in_progress;
 };
 
+static void pool_write_unlock(struct zs_pool *pool)
+{
+	write_unlock(&pool->lock);
+}
+
+static void pool_write_lock(struct zs_pool *pool)
+{
+	write_lock(&pool->lock);
+}
+
+static void pool_read_unlock(struct zs_pool *pool)
+{
+	read_unlock(&pool->lock);
+}
+
+static void pool_read_lock(struct zs_pool *pool)
+{
+	read_lock(&pool->lock);
+}
+
+static bool pool_lock_is_contended(struct zs_pool *pool)
+{
+	return rwlock_is_contended(&pool->lock);
+}
+
 static inline void zpdesc_set_first(struct zpdesc *zpdesc)
 {
 	SetPagePrivate(zpdesc_page(zpdesc));
@@ -1206,7 +1231,7 @@ void *zs_map_object(struct zs_pool *pool, unsigned long handle,
 	BUG_ON(in_interrupt());
 
 	/* It guarantees it can get zspage from handle safely */
-	read_lock(&pool->migrate_lock);
+	pool_read_lock(pool);
 	obj = handle_to_obj(handle);
 	obj_to_location(obj, &zpdesc, &obj_idx);
 	zspage = get_zspage(zpdesc);
@@ -1218,7 +1243,7 @@ void *zs_map_object(struct zs_pool *pool, unsigned long handle,
 	 * which is smaller granularity.
 	 */
 	migrate_read_lock(zspage);
-	read_unlock(&pool->migrate_lock);
+	pool_read_unlock(pool);
 
 	class = zspage_class(pool, zspage);
 	off = offset_in_page(class->size * obj_idx);
@@ -1450,16 +1475,16 @@ void zs_free(struct zs_pool *pool, unsigned long handle)
 		return;
 
 	/*
-	 * The pool->migrate_lock protects the race with zpage's migration
+	 * The pool->lock protects the race with zpage's migration
 	 * so it's safe to get the page from handle.
 	 */
-	read_lock(&pool->migrate_lock);
+	pool_read_lock(pool);
 	obj = handle_to_obj(handle);
 	obj_to_zpdesc(obj, &f_zpdesc);
 	zspage = get_zspage(f_zpdesc);
 	class = zspage_class(pool, zspage);
 	spin_lock(&class->lock);
-	read_unlock(&pool->migrate_lock);
+	pool_read_unlock(pool);
 
 	class_stat_sub(class, ZS_OBJS_INUSE, 1);
 	obj_free(class->size, obj);
@@ -1793,10 +1818,10 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	pool = zspage->pool;
 
 	/*
-	 * The pool migrate_lock protects the race between zpage migration
+	 * The pool lock protects the race between zpage migration
 	 * and zs_free.
 	 */
-	write_lock(&pool->migrate_lock);
+	pool_write_lock(pool);
 	class = zspage_class(pool, zspage);
 
 	/*
@@ -1833,7 +1858,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	 * Since we complete the data copy and set up new zspage structure,
 	 * it's okay to release migration_lock.
 	 */
-	write_unlock(&pool->migrate_lock);
+	pool_write_unlock(pool);
 	spin_unlock(&class->lock);
 	migrate_write_unlock(zspage);
 
@@ -1956,7 +1981,7 @@ static unsigned long __zs_compact(struct zs_pool *pool,
 	 * protect the race between zpage migration and zs_free
 	 * as well as zpage allocation/free
 	 */
-	write_lock(&pool->migrate_lock);
+	pool_write_lock(pool);
 	spin_lock(&class->lock);
 	while (zs_can_compact(class)) {
 		int fg;
@@ -1983,14 +2008,14 @@ static unsigned long __zs_compact(struct zs_pool *pool,
 		src_zspage = NULL;
 
 		if (get_fullness_group(class, dst_zspage) == ZS_INUSE_RATIO_100
-		    || rwlock_is_contended(&pool->migrate_lock)) {
+		    || pool_lock_is_contended(pool)) {
 			putback_zspage(class, dst_zspage);
 			dst_zspage = NULL;
 
 			spin_unlock(&class->lock);
-			write_unlock(&pool->migrate_lock);
+			pool_write_unlock(pool);
 			cond_resched();
-			write_lock(&pool->migrate_lock);
+			pool_write_lock(pool);
 			spin_lock(&class->lock);
 		}
 	}
@@ -2002,7 +2027,7 @@ static unsigned long __zs_compact(struct zs_pool *pool,
 		putback_zspage(class, dst_zspage);
 
 	spin_unlock(&class->lock);
-	write_unlock(&pool->migrate_lock);
+	pool_write_unlock(pool);
 
 	return pages_freed;
 }
@@ -2014,10 +2039,10 @@ unsigned long zs_compact(struct zs_pool *pool)
 	unsigned long pages_freed = 0;
 
 	/*
-	 * Pool compaction is performed under pool->migrate_lock so it is basically
+	 * Pool compaction is performed under pool->lock so it is basically
 	 * single-threaded. Having more than one thread in __zs_compact()
-	 * will increase pool->migrate_lock contention, which will impact other
-	 * zsmalloc operations that need pool->migrate_lock.
+	 * will increase pool->lock contention, which will impact other
+	 * zsmalloc operations that need pool->lock.
 	 */
 	if (atomic_xchg(&pool->compaction_in_progress, 1))
 		return 0;
@@ -2139,7 +2164,7 @@ struct zs_pool *zs_create_pool(const char *name)
 		return NULL;
 
 	init_deferred_free(pool);
-	rwlock_init(&pool->migrate_lock);
+	rwlock_init(&pool->lock);
 	atomic_set(&pool->compaction_in_progress, 0);
 
 	pool->name = kstrdup(name, GFP_KERNEL);
-- 
2.48.1.502.g6dc24dfdaf-goog


