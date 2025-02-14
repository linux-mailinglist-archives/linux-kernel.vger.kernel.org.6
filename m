Return-Path: <linux-kernel+bounces-514357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06655A355EB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 05:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62AE53AD9A8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 04:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A8D198A11;
	Fri, 14 Feb 2025 04:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="N2MMCudz"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9A118D65C
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 04:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739508799; cv=none; b=mxxxs4rkVSekFhAibAgSk8UWgdh5Nc3yjlV4bVxgcUS2yDa+ojuQPqKCZnELIzzP85FcN2c4pMQfbUFLWK3E0LLPHD7Y2PD2e/MDSxDOu2LzwzaqIUyQU1AK/ttI047/ttD+wxYkk4eT+u+210fQ/u4mBk7dT8zF5qw4+PX3xKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739508799; c=relaxed/simple;
	bh=DY5fwEJgbhMX0yrNqukgQuyP+HTesDPA2ZycKuhFn/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tMVqEk+izU6PhGU7YeV8hMO3lUsMLvgXTbAAh4S4KADTAUX628W3HvPDecJUXY5GNHWiYJ5BHvzr0FKx4E9Mc3UCWrYkznR5Zxn3nuRxznqClozzDaktAosel6Cj0iv0eIKjPzBWvBMZQQMETY96WCIssUQ5lXATEY1VfaruwfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=N2MMCudz; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2fa1a3c88c5so2432013a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 20:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739508797; x=1740113597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nEsYVf2FanYsVWFazbZFyY/NjoKwvYYj/znay1eygdw=;
        b=N2MMCudzhQrddy9pC/m+isxXcJvPQ3Glmzzq4pdLE0SaIlL2VUHV7/F+jk/yKRNL/1
         I15grkwPTCPEgRBoGpKaGW4MiGoIAimk9KroG2ghuwzjqvbmNJbH83BgKaT85CobgCZx
         BYcHB66HLT0P8WOysMely6fUbZp5dl5k+b1dI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739508797; x=1740113597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nEsYVf2FanYsVWFazbZFyY/NjoKwvYYj/znay1eygdw=;
        b=l3vNkWBPySCLXYSMS0KIrv5xbryqyAIsDUoLQXxIgXYAnFqQMbg7kPlIMSef77XnC1
         8hREF5YGpw4MP+OvQ1b8olc+vtMRkvno5po1fzvQa6FYm+5i8StFkPxmihgRb8TIOqkC
         IQtigjCWPIeH07ZRTccn69MUKloV1XySQipkGQ3BZmEr1FD/l4S5qjY7S+7qrYoe/laB
         1XlcU2nhFTNt9ybf4OtYaZ1Z0VEMfLNR0j17hi5u36huRcPMVKEHqHn3Tz4HOQiZ+fe8
         1JWWQhdGqpQ+tL/o5HGPda/BZduMzQysETCR5Tz+KlLAY8OxNb7iN6NOjN+iU8Jau0Oe
         x19g==
X-Forwarded-Encrypted: i=1; AJvYcCXWvOLvxJnfIcrla7G/TeEvfjZ/rlYYC31n/Tr0YwA3Wh/oXcY62mPWx6BKT6w1Qmmmv/gpjB9R/GpFbfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOCUhadC4wqzGicA282tF1FyTSJ++RsH06giE++fSb2hIQsFXG
	eQgzqCufAUbf7TlXBMLObSO5mEZ2u5j+1MixZUdvnc/ElAdNci6nbj2B0T7CyQ==
X-Gm-Gg: ASbGncvP9SMeKpd2VoHycruu8wW2aVPflY+F4L5PvKvMqeknQzLbBPLtFnTuamixhaf
	CqT7MmFP3EMUPbWbBu6SKM2ImmWD7+qamZETXxuBMUvFfDHl7GH+ijRBDSL1hNGJkP4PICppN64
	CVI0hWEtbCEZD8sT7E8vbjY96pRiQ5ABzNFfWQwzX+AhNMj9MS78o+zeU7TcXZfP3Mo9YMa2Yg+
	bK6fimo7zdTHSGQzj92aFDpOtJwjPq7AAERMfhQ/jQyGq9Rx69WyhZjQ6myshmaWW5MkwksYn0O
	goyGPk5dh17cMnCrzQ==
X-Google-Smtp-Source: AGHT+IGwpYmFxf0CUvgBN28Mu9LR6po8v4fVBJ8EuK4NGdlYOspY9jkFKQ6vUxoKOF+lj1g+wrgKpQ==
X-Received: by 2002:a05:6a00:8c8:b0:730:7970:1f8f with SMTP id d2e1a72fcca58-7322c5a9058mr14486712b3a.12.1739508796987;
        Thu, 13 Feb 2025 20:53:16 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:942d:9291:22aa:8126])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73242764cd1sm2272338b3a.149.2025.02.13.20.53.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 20:53:16 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>,
	Hillf Danton <hdanton@sina.com>,
	Kairui Song <ryncsn@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v6 10/17] zsmalloc: rename pool lock
Date: Fri, 14 Feb 2025 13:50:22 +0900
Message-ID: <20250214045208.1388854-11-senozhatsky@chromium.org>
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

The old name comes from the times when the pool did not have
compaction (defragmentation).  Rename it to ->lock because these
days it synchronizes not only migration.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 mm/zsmalloc.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 6d0e47f7ae33..2e338cde0d21 100644
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


