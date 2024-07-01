Return-Path: <linux-kernel+bounces-235550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBC491D67E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 05:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C202A28194F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 03:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195BFDF42;
	Mon,  1 Jul 2024 03:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Yqg0lssM"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8343EAD0
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 03:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719803520; cv=none; b=SO/qfVxO93p8T/Quql2I1KE7IPdhtlW4A6idEzqey5/XwLMlYrt/5kKiKJXgfL0kt8s52+uZcONIW+ET2qCyvcpUMeYQ35uyYRVfEhqnpspsvP0wYSUVO7LMX5Fr5iOoxh2lEOP6l+/yPlWiFpYq9LEfDuDC/fMMLWYdNc5mVo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719803520; c=relaxed/simple;
	bh=3/Xk6BsHjzdY2wbfmi/7aQGOSNAuDa96XhXbcddoLFk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u/r/hcYG09dMaCuOrvp1k1PvpaS3XMyUp4SHJDceisUI4Y5rEJK++NI70oamhSETniPhNG4bN2qSKtbzv2CR9uLmb6plHiB+2if6ZtTvODiCuAw9KQYmRFMeUsg1MAHFLRPtC5JWfcmt23pd5RZjZARmZN1vAJXhq6YVkoiFh7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Yqg0lssM; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7082dd9bbf8so1604601b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 20:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1719803518; x=1720408318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YyI1lf0+qLzw+2HsoEipA/tSeBu8AsIlRovbPpsWzPE=;
        b=Yqg0lssMl1ZNj59YscLhVmhN8RUmpZtKHMVVQAcPAl9AfOmXHbYegpU+q8K2Usiq2C
         uImap63WGq/awyLJaxeb0KfFXUqgcxHryTwScU8JWL7M+PQk1mp/7KZXDTc1dyEA4ZPd
         BL8DnVah27eVPnGQjcgh/WdlL4q9dp9wUCsfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719803518; x=1720408318;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YyI1lf0+qLzw+2HsoEipA/tSeBu8AsIlRovbPpsWzPE=;
        b=YcaSZV7EoJ0KNpVRhI8dwXxAr18r8iAvko/VKT2FhRdHdTLexH9i7xCQgeIFQTtmSS
         v0z6S/Jw42jBXprWmI9N+zM1vLC/p1nqrctksmFRcDYVcFZtY+uXAigT6Z2OgjH5KWUq
         Go9d/ko73SOXd91YYguEdsTS+osAO1TG9Onz1dTyFVnOgxVwo6CG/zeXOAaVIByJm2MN
         2Wyt6rNCvlIfHebeRVvz5eT+Shwkf0GYcQj8VzCnYtduszy5U351/DuEJbEwZvyYoC1x
         Jq5QELxismKDkqTJl4cRbhTVeN8gdtPPLGcDysA/EiELqsWFL7ct27HWpWKYPHLXA2Tf
         iOdg==
X-Forwarded-Encrypted: i=1; AJvYcCX0/TPCBbo3TEJvrRMw3kmNkTuB4mFhrpUOTMUhHWFfWoNCCaxlCBkt/xUNagkA6o4rIvmvaivlPcDgeoHp5V4QbBoYCj97r7A+qA8q
X-Gm-Message-State: AOJu0YxY/VXUcOwIaeIg/gA7Vk+YCEVwo6YfEGDrQOru/OSOVro1sV2D
	93VF+VOo2NZnLWC7KXJ8pa7KEs/cuQprDCItdYNFC5f/DWHdIkBnugC58In3rJkjY4XA+UZopt7
	+Qg==
X-Google-Smtp-Source: AGHT+IFhBvIB4Wq6MR47Ud8tK0M5T5uuoIivsBKWArumNybrN+Df8HFaTmBYoWbW/u64Vwiq73YNLw==
X-Received: by 2002:a05:6a00:240e:b0:705:cade:1f40 with SMTP id d2e1a72fcca58-70aaad3a107mr3093796b3a.11.1719803518032;
        Sun, 30 Jun 2024 20:11:58 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:132b:a86a:a9d0:d7fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70802667c59sm5350179b3a.86.2024.06.30.20.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jun 2024 20:11:57 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: Chengming Zhou <chengming.zhou@linux.dev>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH] zsmalloc: rename class stat mutators
Date: Mon,  1 Jul 2024 12:11:37 +0900
Message-ID: <20240701031140.3756345-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A cosmetic change.

o Rename class_stat_inc() and class_stat_dec() to class_stat_add()
  and class_stat_sub() correspondingly. inc/dec are usually associated
  with +1/-1 modifications, while zsmlloc can modify stats by up
  to ->objs_per_zspage. Use add/sub (follow atomics naming).

o Rename zs_stat_get() to class_stat_read()
  get() is usually associated with ref-counting and is paired with put().
  zs_stat_get() simply reads class stat so rename to reflect it.
  (This also follows atomics naming).

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 mm/zsmalloc.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index c2f4e62ffb46..5d6581ab7c07 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -512,19 +512,19 @@ static int get_size_class_index(int size)
 	return min_t(int, ZS_SIZE_CLASSES - 1, idx);
 }
 
-static inline void class_stat_inc(struct size_class *class,
-				int type, unsigned long cnt)
+static inline void class_stat_add(struct size_class *class, int type,
+				  unsigned long cnt)
 {
 	class->stats.objs[type] += cnt;
 }
 
-static inline void class_stat_dec(struct size_class *class,
-				int type, unsigned long cnt)
+static inline void class_stat_sub(struct size_class *class, int type,
+				  unsigned long cnt)
 {
 	class->stats.objs[type] -= cnt;
 }
 
-static inline unsigned long zs_stat_get(struct size_class *class, int type)
+static inline unsigned long class_stat_read(struct size_class *class, int type)
 {
 	return class->stats.objs[type];
 }
@@ -576,12 +576,12 @@ static int zs_stats_size_show(struct seq_file *s, void *v)
 
 		seq_printf(s, " %5u %5u ", i, class->size);
 		for (fg = ZS_INUSE_RATIO_10; fg < NR_FULLNESS_GROUPS; fg++) {
-			inuse_totals[fg] += zs_stat_get(class, fg);
-			seq_printf(s, "%9lu ", zs_stat_get(class, fg));
+			inuse_totals[fg] += class_stat_read(class, fg);
+			seq_printf(s, "%9lu ", class_stat_read(class, fg));
 		}
 
-		obj_allocated = zs_stat_get(class, ZS_OBJS_ALLOCATED);
-		obj_used = zs_stat_get(class, ZS_OBJS_INUSE);
+		obj_allocated = class_stat_read(class, ZS_OBJS_ALLOCATED);
+		obj_used = class_stat_read(class, ZS_OBJS_INUSE);
 		freeable = zs_can_compact(class);
 		spin_unlock(&class->lock);
 
@@ -686,7 +686,7 @@ static void insert_zspage(struct size_class *class,
 				struct zspage *zspage,
 				int fullness)
 {
-	class_stat_inc(class, fullness, 1);
+	class_stat_add(class, fullness, 1);
 	list_add(&zspage->list, &class->fullness_list[fullness]);
 	zspage->fullness = fullness;
 }
@@ -702,7 +702,7 @@ static void remove_zspage(struct size_class *class, struct zspage *zspage)
 	VM_BUG_ON(list_empty(&class->fullness_list[fullness]));
 
 	list_del_init(&zspage->list);
-	class_stat_dec(class, fullness, 1);
+	class_stat_sub(class, fullness, 1);
 }
 
 /*
@@ -858,7 +858,7 @@ static void __free_zspage(struct zs_pool *pool, struct size_class *class,
 
 	cache_free_zspage(pool, zspage);
 
-	class_stat_dec(class, ZS_OBJS_ALLOCATED, class->objs_per_zspage);
+	class_stat_sub(class, ZS_OBJS_ALLOCATED, class->objs_per_zspage);
 	atomic_long_sub(class->pages_per_zspage, &pool->pages_allocated);
 }
 
@@ -1374,7 +1374,7 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
 		obj_malloc(pool, zspage, handle);
 		/* Now move the zspage to another fullness group, if required */
 		fix_fullness_group(class, zspage);
-		class_stat_inc(class, ZS_OBJS_INUSE, 1);
+		class_stat_add(class, ZS_OBJS_INUSE, 1);
 
 		goto out;
 	}
@@ -1392,8 +1392,8 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
 	newfg = get_fullness_group(class, zspage);
 	insert_zspage(class, zspage, newfg);
 	atomic_long_add(class->pages_per_zspage, &pool->pages_allocated);
-	class_stat_inc(class, ZS_OBJS_ALLOCATED, class->objs_per_zspage);
-	class_stat_inc(class, ZS_OBJS_INUSE, 1);
+	class_stat_add(class, ZS_OBJS_ALLOCATED, class->objs_per_zspage);
+	class_stat_add(class, ZS_OBJS_INUSE, 1);
 
 	/* We completely set up zspage so mark them as movable */
 	SetZsPageMovable(pool, zspage);
@@ -1454,7 +1454,7 @@ void zs_free(struct zs_pool *pool, unsigned long handle)
 	spin_lock(&class->lock);
 	read_unlock(&pool->migrate_lock);
 
-	class_stat_dec(class, ZS_OBJS_INUSE, 1);
+	class_stat_sub(class, ZS_OBJS_INUSE, 1);
 	obj_free(class->size, obj);
 
 	fullness = fix_fullness_group(class, zspage);
@@ -1880,7 +1880,7 @@ static void async_free_zspage(struct work_struct *work)
 
 		class = zspage_class(pool, zspage);
 		spin_lock(&class->lock);
-		class_stat_dec(class, ZS_INUSE_RATIO_0, 1);
+		class_stat_sub(class, ZS_INUSE_RATIO_0, 1);
 		__free_zspage(pool, class, zspage);
 		spin_unlock(&class->lock);
 	}
@@ -1923,8 +1923,8 @@ static inline void zs_flush_migration(struct zs_pool *pool) { }
 static unsigned long zs_can_compact(struct size_class *class)
 {
 	unsigned long obj_wasted;
-	unsigned long obj_allocated = zs_stat_get(class, ZS_OBJS_ALLOCATED);
-	unsigned long obj_used = zs_stat_get(class, ZS_OBJS_INUSE);
+	unsigned long obj_allocated = class_stat_read(class, ZS_OBJS_ALLOCATED);
+	unsigned long obj_used = class_stat_read(class, ZS_OBJS_INUSE);
 
 	if (obj_allocated <= obj_used)
 		return 0;
-- 
2.45.2.803.g4e1b14247a-goog


