Return-Path: <linux-kernel+bounces-535574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83435A474B2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 05:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FEEC3AA4CA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 04:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDFF1EFF84;
	Thu, 27 Feb 2025 04:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Gf3zVeij"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CABC1EB5DF
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 04:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740631059; cv=none; b=k9H+EUg4mS6KAh8JiHuqTa1bXMxo33YiRlujfAJA/cnyNObhOKqqxKgE5Q/xT1rRg8plB7e5KrdeqBuEnQ0qG3Z4aYv4SvE729F8aeYmPWRj+6LHdbeCFmvEsDWjDpQkOH8JY/JAP2oO64UFIDhBVRVtKvVn2IidXfSOCs9MMoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740631059; c=relaxed/simple;
	bh=odlz8hoQ26Jw3Tf67oa3XzcHo7Ity+kkxSjAfuSnavQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tHXko/4kTlM1P9vMUh7t+EN07F1tpg5DlDL/UsRPo6tQhWnwJ9f1p9TfAqgPgAyBkBr/ywX1BMqPepTGAgG4e2LyMyfUFrp3f3rhh/QNZ9hObwhSgnKBG2G3DKrBmypEYrWD0qjl9yW+W6OjH/0jmwOcQwRd0gSNu7eiALU3cMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Gf3zVeij; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22114b800f7so8822775ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 20:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740631057; x=1741235857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZEqWbULFJyDHZ0uxeHUHEx9cW/XUYWqE9opCIKYGE7k=;
        b=Gf3zVeijwf5loopOVzjPHrAWXaGIlSG0wN11j3KJslXJRVoNJI3+Zv3dBQINarSyN8
         3+oJWnb3OLsigkxrkDwEwHl3qAEpP3Jn7Gj0+f64QVXrsSIG+HKCcAiyv7H3vCBs0vOl
         DYmbWxnfeLD4tcpk+V8yIxzFxDC1aMw+8FWbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740631057; x=1741235857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZEqWbULFJyDHZ0uxeHUHEx9cW/XUYWqE9opCIKYGE7k=;
        b=gLUeyL1GnrAUDlfRzH+GxhYKKQ7pYgoyR5H+7zklGbnIEfmUvWbIG42YzWUKPYZekI
         PYwGCy62lsJfTaXRy7ReslHSgb7dQZwo0nnr0z5ohemxG+2iLFfNraHzYFejAtVaDmW8
         04aIdShqJ8LpSHpq60sBOez4CiC2WpuZEmrubgc2qEz5uhO4UTwWByv7DbMFyZw6unB8
         OwMw120jIaNok1+VfnWGdfkueBmajb1CfFfL4wuPtJzcbZO6WFtgDR9It/efxJ6YWD4E
         D/k4JAyGzREjGIVQt5TUu0ozVfO+C8v0g+HZ+r98v3u54koAwdfEq4e39QejLkz4Wlyg
         ww6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVnmPXIAGhBrJpjHyNchq6EfTT8tq1sbDXIgRNfIdggsAtlgHbCGI/Aa/aGEMQErg3pXKqRNCb1R+K/T5U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4OdvjRI6AQmCMR9lcvdI5Zg9rMMbfR9ub1kkxMwC7bWAev7WF
	gU3eWkJ5Dd71id/d2eFjVaHdy1vj3NPyohiXGnihdOu/MyaddIj8xuQcVWye5g==
X-Gm-Gg: ASbGncuWwZqi2fhCqSk67MAK0rLiof2hq9CBawUe1Cl4uE/tMPPMF4zQ/9nOm7uRBLD
	7VQofX82KHAaP0D3IMCQ+P5d/ZcG6U0sTU8RMMMJlUCQMpYUsl1et+WKhU1ShvodOTOLMbTV3va
	h/KCB1uljfQ5wEg9JMHcUxqte3qp+v41FbfLBRwhBYgYJjVGlvSRk5DU7luJi/ddZjpcEjD/Gl9
	gnnTeYgj7xgiWT9dWkUjWbTUig9QjYl2kWOuHn7Ct8HE2wbGpYa8xkeMT1//mDqzUnkS0XQpvVl
	vAv3uq9GUonLhfaR6gJmtBs2fQO2
X-Google-Smtp-Source: AGHT+IGjRG1+LdYUr60qs0ikZWZDjzWHfWUJZUn2QU7B7wuT5jMjcjNdqY/z652mUps+J+R2kLTanA==
X-Received: by 2002:a05:6a21:48d:b0:1f0:e7e2:127e with SMTP id adf61e73a8af0-1f10ad3ffabmr9855132637.23.1740631057375;
        Wed, 26 Feb 2025 20:37:37 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:a9c0:1bc1:74e3:3e31])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7349fe6c1desm500488b3a.73.2025.02.26.20.37.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 20:37:37 -0800 (PST)
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
Subject: [PATCH v9 12/19] zsmalloc: rename pool lock
Date: Thu, 27 Feb 2025 13:35:30 +0900
Message-ID: <20250227043618.88380-13-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
In-Reply-To: <20250227043618.88380-1-senozhatsky@chromium.org>
References: <20250227043618.88380-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The old name comes from the times when the pool did not have
compaction (defragmentation).  Rename it to ->lock because these
days it synchronizes not only migration.

Reviewed-by: Yosry Ahmed <yosry.ahmed@linux.dev>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 mm/zsmalloc.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 817626a351f8..1424ee73cbb5 100644
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
@@ -223,8 +223,8 @@ struct zs_pool {
 #ifdef CONFIG_COMPACTION
 	struct work_struct free_work;
 #endif
-	/* protect page/zspage migration */
-	rwlock_t migrate_lock;
+	/* protect zspage migration/compaction */
+	rwlock_t lock;
 	atomic_t compaction_in_progress;
 };
 
@@ -1206,7 +1206,7 @@ void *zs_map_object(struct zs_pool *pool, unsigned long handle,
 	BUG_ON(in_interrupt());
 
 	/* It guarantees it can get zspage from handle safely */
-	read_lock(&pool->migrate_lock);
+	read_lock(&pool->lock);
 	obj = handle_to_obj(handle);
 	obj_to_location(obj, &zpdesc, &obj_idx);
 	zspage = get_zspage(zpdesc);
@@ -1218,7 +1218,7 @@ void *zs_map_object(struct zs_pool *pool, unsigned long handle,
 	 * which is smaller granularity.
 	 */
 	migrate_read_lock(zspage);
-	read_unlock(&pool->migrate_lock);
+	read_unlock(&pool->lock);
 
 	class = zspage_class(pool, zspage);
 	off = offset_in_page(class->size * obj_idx);
@@ -1450,16 +1450,16 @@ void zs_free(struct zs_pool *pool, unsigned long handle)
 		return;
 
 	/*
-	 * The pool->migrate_lock protects the race with zpage's migration
+	 * The pool->lock protects the race with zpage's migration
 	 * so it's safe to get the page from handle.
 	 */
-	read_lock(&pool->migrate_lock);
+	read_lock(&pool->lock);
 	obj = handle_to_obj(handle);
 	obj_to_zpdesc(obj, &f_zpdesc);
 	zspage = get_zspage(f_zpdesc);
 	class = zspage_class(pool, zspage);
 	spin_lock(&class->lock);
-	read_unlock(&pool->migrate_lock);
+	read_unlock(&pool->lock);
 
 	class_stat_sub(class, ZS_OBJS_INUSE, 1);
 	obj_free(class->size, obj);
@@ -1796,7 +1796,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	 * The pool migrate_lock protects the race between zpage migration
 	 * and zs_free.
 	 */
-	write_lock(&pool->migrate_lock);
+	write_lock(&pool->lock);
 	class = zspage_class(pool, zspage);
 
 	/*
@@ -1833,7 +1833,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	 * Since we complete the data copy and set up new zspage structure,
 	 * it's okay to release migration_lock.
 	 */
-	write_unlock(&pool->migrate_lock);
+	write_unlock(&pool->lock);
 	spin_unlock(&class->lock);
 	migrate_write_unlock(zspage);
 
@@ -1956,7 +1956,7 @@ static unsigned long __zs_compact(struct zs_pool *pool,
 	 * protect the race between zpage migration and zs_free
 	 * as well as zpage allocation/free
 	 */
-	write_lock(&pool->migrate_lock);
+	write_lock(&pool->lock);
 	spin_lock(&class->lock);
 	while (zs_can_compact(class)) {
 		int fg;
@@ -1983,14 +1983,14 @@ static unsigned long __zs_compact(struct zs_pool *pool,
 		src_zspage = NULL;
 
 		if (get_fullness_group(class, dst_zspage) == ZS_INUSE_RATIO_100
-		    || rwlock_is_contended(&pool->migrate_lock)) {
+		    || rwlock_is_contended(&pool->lock)) {
 			putback_zspage(class, dst_zspage);
 			dst_zspage = NULL;
 
 			spin_unlock(&class->lock);
-			write_unlock(&pool->migrate_lock);
+			write_unlock(&pool->lock);
 			cond_resched();
-			write_lock(&pool->migrate_lock);
+			write_lock(&pool->lock);
 			spin_lock(&class->lock);
 		}
 	}
@@ -2002,7 +2002,7 @@ static unsigned long __zs_compact(struct zs_pool *pool,
 		putback_zspage(class, dst_zspage);
 
 	spin_unlock(&class->lock);
-	write_unlock(&pool->migrate_lock);
+	write_unlock(&pool->lock);
 
 	return pages_freed;
 }
@@ -2014,10 +2014,10 @@ unsigned long zs_compact(struct zs_pool *pool)
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
@@ -2139,7 +2139,7 @@ struct zs_pool *zs_create_pool(const char *name)
 		return NULL;
 
 	init_deferred_free(pool);
-	rwlock_init(&pool->migrate_lock);
+	rwlock_init(&pool->lock);
 	atomic_set(&pool->compaction_in_progress, 0);
 
 	pool->name = kstrdup(name, GFP_KERNEL);
-- 
2.48.1.658.g4767266eb4-goog


