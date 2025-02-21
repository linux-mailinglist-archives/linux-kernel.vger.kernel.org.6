Return-Path: <linux-kernel+bounces-526752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4ACA402B5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 23:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97B4A3BE95A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 22:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B058255E21;
	Fri, 21 Feb 2025 22:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HfR9FhqV"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183F1253F06
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 22:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740177065; cv=none; b=Lz4MtKH3WHn4bJJYMhUfrrBKCusFCSw+m8cFItI5lZJgocH45KCLmNE+JdeuZ1qGT+XT02m5Q1uXSAojFv0CyAfWsKRG6QfEtIzZZ9y/IqiGMTidGrFm9xU8ADHgdh8tuU521CpIg1+9NSMaS5fAW568aZUWzWwyPP532NB8d2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740177065; c=relaxed/simple;
	bh=OmQqpQdAdpFq4en3WutiCoYviYGMtxAOkzqQFIWZZ2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LTCVXrWT/0WlrU0xrrsCU5NF2TcoiIWdPHG/t3zvkXu2a7nvpuTKPzER5tiepp88ZeAVCaPDydtZ2tX07LxsxWHL/8f9wAkXGgG0rbMtnZKbZ+2CDIKuDlJF/dM2CMk8eaP7esRGI4Wb4BnMcO//1nXTMYqz2Vt6lgRu2M5FkS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HfR9FhqV; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21c2f1b610dso75316225ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 14:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740177063; x=1740781863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5HvQEcjJeXsHC85jXzgvN7MoOE9VPDedZeSd2dLCsl4=;
        b=HfR9FhqVIJ2YvC7hqn3AHLCYSRQ+oD9q0wBUxDpU0a6y0BvWKpBhDFYD7akKThC96v
         QnBFx0L4jPF23kFRp7wwN3wGSU6Y7k2aubrEgRFhZGqnccO+IKK2HXYzFFdezyC7tRiL
         FeHSkydOCJeBif095tw7icg4yUBOfZ5xtYThU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740177063; x=1740781863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5HvQEcjJeXsHC85jXzgvN7MoOE9VPDedZeSd2dLCsl4=;
        b=FFXqj29ldW1s2T7HyqXjSiZ1YCIPARzlCQRMc/u5TrY9EGPWDE/pF9dqsy7oPcS2Yj
         QrLFqvc0luWivsGMEyot6b9f5FkxFJx1Q3aEbHOvx/Bq/jEby4h5esvQyETzzLDQcTJO
         QJ18ojFbBrzP2/wOoRKVioZSGt6b9xaQZ2bkYrWp9Qi1LLaEQaLRP3AnBKfkheMfMeJE
         tPg3d9uMjn0claKGn6I0l4pR1MzMuWWOGY8XMoED3rQF7Nm5zm0oX+IJVnI8SD5WHeMS
         Xc8fHPM3lfMrbizLCnhBkOHFcOwYIHQ4+Vs2U5r0MUPvK9fT1S4SyVnkZiczWUz6yX1x
         6L3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVKor7hYBcw1e/WE20AO+ZPOQEQ58ak7+XD5LXt1l1z89AaxJFecsvRTkwgikWGyTHV7ZR8OVVBZ0Gids8=@vger.kernel.org
X-Gm-Message-State: AOJu0YybH6f66+hv/DRav2z9AJ4x8ECA9d6IfYpyDxiVSTpBmuRFeDI8
	0dp4hTGxf2tasDxAU1ZnzZnXxZtDfoDhcNSS4mD9d03Oq3y8AxgmhInyhKOibA==
X-Gm-Gg: ASbGnctbZeOLbugputcQ6NFRd9EIx3d3a/ZzAeMFvCkMty2yt3kW7LeHKnVUuOQgO2n
	ldaPILyU9cvGFAAb5EanscSVoqlZd/x38o9svclYjgQP/apeTw4ZMiwCo1V2fT11fRMVfOySfJF
	jzeb3b84/kVEszU2XtWSxKMSoI49vL1nIB1/HBwbTeeYGOte7erxbaYidVw7mV0r7sAVCRQ0qRC
	EByc1qLgiViGKd4Gz3V7A+1+Ed7ZCu6Pxy+eucx/RFFSwywprG0nYq3v5MHIPryF4w/8Zn0VxEC
	zOjM7wqksL9wECTCxT863y/GEKw=
X-Google-Smtp-Source: AGHT+IGH+xDdgjkZXGk8hJrCHMpFTK6rCRlJkYunn5adYXvOt3xJPKeFvrD1nPrfp4BOcOqmXKFuTQ==
X-Received: by 2002:a05:6a21:730a:b0:1ee:e20f:f161 with SMTP id adf61e73a8af0-1eef3dc6819mr10529598637.34.1740177063308;
        Fri, 21 Feb 2025 14:31:03 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:f987:e1e:3dbb:2191])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-adecac2150csm10427909a12.67.2025.02.21.14.31.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 14:31:02 -0800 (PST)
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
Subject: [PATCH v8 10/17] zsmalloc: rename pool lock
Date: Sat, 22 Feb 2025 07:25:41 +0900
Message-ID: <20250221222958.2225035-11-senozhatsky@chromium.org>
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
2.48.1.601.g30ceb7b040-goog


