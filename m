Return-Path: <linux-kernel+bounces-525505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41895A3F0B7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB3C88607FF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A633A204C3F;
	Fri, 21 Feb 2025 09:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MqvAihRp"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DE1204C28
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 09:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740130780; cv=none; b=fEXgQyfVT2jk3JfmWOcTbW1v5BIqDL12H/+CSBhVYznnVKiQYOdovF47xpvcNK6Z9xfe4uueKTkLytXA3yEdPNlmJRwdomO1WMTxjaC21U4EOCOEJ2Y0BKO3cP4bvcYI4AbsywmNA1c6qqxK15D4PAP3aDu0WjxaNwNpuaN/Oo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740130780; c=relaxed/simple;
	bh=OmQqpQdAdpFq4en3WutiCoYviYGMtxAOkzqQFIWZZ2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oUsNtu0hqudxi8H7gYcZVW1tdywBoKOP/dxRGMznfrvKj9s+7qZTu63lPZlm9kSc9/veYVieVZsxlxg2hGHrqWmpK44jcthqbGpfigNRXqYgaQg0t5TyCTD+vcnwX0L2bFLFS22bmUptJKVAqBFsfX7kMLW0z9yNI/+inp7AUuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MqvAihRp; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-220bff984a0so36176235ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 01:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740130778; x=1740735578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5HvQEcjJeXsHC85jXzgvN7MoOE9VPDedZeSd2dLCsl4=;
        b=MqvAihRp3RiUjewoeT2jIxxlIRAyrgc1G3Igzi0qjeuQla7QvWEudvGkyfZpB0kaNq
         Dysel4wWmedKsYMJoc6905gJQzZvojNCylEuQbMKfxzP4xd5HtFF03xYrXfyYkO58zCH
         FK2l18ZwcZCgYUzcAqzGcaU9rKyyvfSkRLqnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740130778; x=1740735578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5HvQEcjJeXsHC85jXzgvN7MoOE9VPDedZeSd2dLCsl4=;
        b=Cv2enNozugM7hbx3J3yh2Q2kPXtC3AOCgwJhOojlFQkpCoOlb9YqjaL2VOYWeWusZS
         E+fuP0WGoNk8I5O4K2r3j/o1TgqMmOkg7TdeW73Oiwip2LoDxs4DIu0Lc0TXv6/ECuED
         dc1g3xmJs1cpRmA6fmTTsdkX8ANTXqDN3BsN7HeQ/TNzSBQ38obJmQcp/LkmaVUkcRuH
         AQwOPFyNT+YkBVl+SolBZwxd++4gGhwFxmz3MKYBohHPZZzv8cxbX4hjO+TIGqNvDXvR
         zqmbrDPe2SfGRfHbUC07BZhkWTzoOB9Kz5HSmGyM9uQ1Fkx76K3pnmRfRKCQHqnBa1lB
         MiYw==
X-Forwarded-Encrypted: i=1; AJvYcCVuHfsXwO9Vwzh7yA81J0lyNgk+R1ubVjjvFZGMTPq/qvWiLCpDntsdVPlC645q+1rpNqNfM+oKIiht9uU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzmIs4jGGguz6QQTg2ApIpcL9khZRHRpW4lKiwspUlj8sjS5I0
	qhlLMGivU9WcdaqLzzexMi0W0nL1oKTcdnQ/cql7qDQBb6tennrsq4JsZRggkQ==
X-Gm-Gg: ASbGncu5d71RTCeNQqundHsVEgx5VbQi/lg/yM9k7Hh+y8scxhj3eBBEvrTXT0Ds+kX
	XVWP5qe831SOMHBUw21sVyz1flfyK5692QN1uOoQQSe60bPe+4sbnMRI8FVDAHvTI7tAQkYWOnw
	QpGIJNYq6sWJfz4qzcpRsmqwYY38knRCYxrdTG9p6pw4t5r+AZ3kpElwulwE+5VPi2sh5AguG4j
	aMTtKD2VbFo/KEEAdS3VUaOL6kIDzML6EF+hUkqGxz5iTH6jDwiKmT6Pf1vo1vS1jtCs91wx891
	7S4TLUggaMh01ugsG8gQ7TDhfx4=
X-Google-Smtp-Source: AGHT+IFJSxFh0kIH2ZWbOryRmu8nKtsDecZCxDfSknljeAwZwRajmYNb6qKYJjX34w+hU0iVAuRclw==
X-Received: by 2002:a05:6a21:6004:b0:1ee:c6bf:7c59 with SMTP id adf61e73a8af0-1eef3cdcb24mr4527195637.23.1740130778665;
        Fri, 21 Feb 2025 01:39:38 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:f987:e1e:3dbb:2191])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73274bdf0aasm9692864b3a.125.2025.02.21.01.39.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 01:39:38 -0800 (PST)
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
Subject: [PATCH v7 10/17] zsmalloc: rename pool lock
Date: Fri, 21 Feb 2025 18:38:03 +0900
Message-ID: <20250221093832.1949691-11-senozhatsky@chromium.org>
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


