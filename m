Return-Path: <linux-kernel+bounces-540884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B109AA4B614
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 03:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAC7C16C165
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 02:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3FC1E32C5;
	Mon,  3 Mar 2025 02:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YNB3VeBC"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB2D185E4A
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 02:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740968734; cv=none; b=D15rhqCzw9u6TEd5Nf2999g8IEnNEJxifKxRq+PvtOl4AOMxlF5XAYiDk9nm488PMA85MFQRKquPZv+RqR2lx9JEKvheAVNtH+sGPSoEgwf/FxdbgFo1G4ZjY+Y8vptq6JWI96A6zL/nKnl+xERdLVxBTxMpjhD14uRU8ZaxXuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740968734; c=relaxed/simple;
	bh=rb8a56w971m7nD0c4uVo5Hdp0pePYf++4G7cHJu/a1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qZp+FDWpnNUlcd12asZxg7qLeX5TZWrGWEXf0SYRvf5P6esthhV7wy2jrMZnWGwRob8bL777a/XMp9tViCkrUdb9TZ69T6v3Y3bO13yElMVt2nsSjwoui0YRietFsVwAZBA84CcB7zWjkYbJYnC0H/aKzDPj5OtgKusZGnf1Og0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YNB3VeBC; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2234e4b079cso69136865ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 18:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740968732; x=1741573532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CYVJH5MaLfbxaKGZoDOncyDyqc70bzD7eQWV2O8vsj8=;
        b=YNB3VeBCk+y4uxx+HPEyBKh5GlTi3hmsXycUj/yFMw8+yO1LGFOSi1p3TBvdZFdiJm
         gqE/hk/JopkOqsPMdUQIgOB9wKuVHcUeylMEdqqEazb2u7pGwZ448rGF/cyZHBiiyVzD
         5YihWvk6+q9YjDELmnet9G1zuCWGrCvlE9f2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740968732; x=1741573532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CYVJH5MaLfbxaKGZoDOncyDyqc70bzD7eQWV2O8vsj8=;
        b=JAA1x8o6CRqN8osL+kfur1AgduM8kxUAP06WfGCHfOAqs4N6/c2mLu6FJkcFdEYtYV
         OPsuJgup1a5XBiEqWRSlE5RaLpndxgbuTO1yG3s4CVzunjn/GjmhJ8B7ZCCU/a2pBnQF
         8fkLlCqzWD/cqbA47Xf5BkGHIx2iRcTDTyXlmtp3Yhfw7U7og2zxioyEZwYOZnp80INX
         ICaAYjVTWokeCkDq09D2eprLe3SePPCJ2Mmn3O1sgC3EPazytfpjcepJvqoC/p1QW5Mg
         44KWoZmIujnHujkZ3BKzaStc8cjfocRTkXiVnclGts3GfcSltOuupMF16B4gaCQchSKi
         qYhw==
X-Forwarded-Encrypted: i=1; AJvYcCWkkAi8rp5kUBofD1PApWn0Dmls0sMp3MMjTEDYjbV0zKJsN81AKRIfG24hLKcVR7V9p/Kc24fTG6npKEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOyBvrBFa7YV2UWh8aBSfDGCHIY7X/VE2ni+a34ZZ82xkRRrSy
	eJaz4251egkAdDRy67zeE7742SPyDIH/M6bShDKStn+EITGGHVhgfJWArcwJuA==
X-Gm-Gg: ASbGnctmga3H8prGOvwf+I+pNMK6Hq6idDgGHBJMNXgAc4k/tl6G6yxZSkJFgmDTvxV
	WTQ2tn7/5Urj5UP52fAkZnJhtd3vuNxQaEBLhcYKe7hX5JAfJgbasEb/iQBzD5NyEGRqSPMYcQk
	Kb5HrOMJZAKJcJbphttGcQ5ZzlSEE64G9KDPprjTv76gN/7e1HXIZ75jvPabGopHrkF6cQbSu8m
	ycuj0Fl4V2Y7IqmRl11OeOo/qH2rn8bahun+vT4uSgql/zVRIjPxAEog0seqL/4LNg5k7K+F4bW
	f7vPTSv39aF5rl7rPh/DfqaadL8AA3By5rm2BKGgxLcLk5s=
X-Google-Smtp-Source: AGHT+IEgYxZUnegN30z6tSMQEsHJ1L6y7oPydeFduqm2ElX6isqJ4TV2BparuhraX3uF1fCfP0eGTw==
X-Received: by 2002:a17:902:d2d0:b0:21f:6cb2:e949 with SMTP id d9443c01a7336-22369244fb0mr142389775ad.52.1740968732436;
        Sun, 02 Mar 2025 18:25:32 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:1513:4f61:a4d3:b418])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-223501fb004sm66940215ad.64.2025.03.02.18.25.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Mar 2025 18:25:32 -0800 (PST)
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
Subject: [PATCH v10 12/19] zsmalloc: rename pool lock
Date: Mon,  3 Mar 2025 11:03:21 +0900
Message-ID: <20250303022425.285971-13-senozhatsky@chromium.org>
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
2.48.1.711.g2feabab25a-goog


