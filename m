Return-Path: <linux-kernel+bounces-233247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB85791B4C9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 03:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 589671F22A8E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 01:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE6F14A84;
	Fri, 28 Jun 2024 01:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="affTk2i3"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C8918C31
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 01:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719539531; cv=none; b=XR/i/WoVRSEzZyQxTra2OE+RTHqKtKKZIDCivfZps8v6JDBOzzL8djyBYvaFXBhIApPEQaOaDwZqCdIaajx2GaDNHw9089fdrrySZYuTHKSyqvjtCEj8lOUZ9brvaadxI1gM1H+XAn0BazrkJugL9XLogscrunwGX7kYG8hJ5vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719539531; c=relaxed/simple;
	bh=C7mvTYLKP5rULxzvk+Q/UI/35lIUUm/C/Ad04ubtNZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YNYjWaDq+FmcCY3aKqKpbah0+7yOErSNeHWNkQyer/zkbWdMpLbdOB6NyQVjXbaimlzcy901laoeJgPkUtv+LdLfcbKVymmJ1mWMyRPmBnuKQlRdYtQwsikNp8JONO8JxENwWy5GnHijaqc3sqQUvQcag2ZjvfAxMhYfgj6J4a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=affTk2i3; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-707f9c3bd02so131712b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 18:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1719539529; x=1720144329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/Y2Wdd7VeB8iNHqPvhHv3M3aV5Mu8Y1ATzVFTOMbY10=;
        b=affTk2i3soc82yt0NKXX8CK97clvM4aMjiNPEHtUlvH/3Ckppo9/QIXP/fHQu87Lih
         nvY5PuCye7NufAk5mp7NcHWdBEczxHyhW5h3IuCX0+/vBqT7rYHi20RQLB2yhCRwNstr
         TljBkeBcAY7qvtdTTIz9HCj+hcoF+qKtEA/4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719539529; x=1720144329;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Y2Wdd7VeB8iNHqPvhHv3M3aV5Mu8Y1ATzVFTOMbY10=;
        b=bzKY0BWnQrvhgLg11Dbve8BvJKhYqIxZJVfHqiyUCY7HfxCODkCUsq0kGM6n9H8RfE
         hfGZfhJ0oez2fJXp1elaSXvt13xkUCfgbD14Bci2c3J+FeMPVFGJaVB/hIsZ/YU0cPV1
         heTTlDRKUH/F7w7xV8SzDz+idzmqcinGp2qlC10oR8Dmjn6MD0cSR6pmGV9v8cNbWL8X
         k6vBg1L0SJyOhKzLrcBMK9Fv/b9zu0RdDNLI/JuZcbg890fyW0i5Ig77q4ngZFD3EOyI
         hxA9ib0lCWpmBaVi/pomJDRQYLB3NHNR6i1XFLWjX5V0K2c0wXJTHKKE3YtVl5aynHPA
         ei4w==
X-Forwarded-Encrypted: i=1; AJvYcCUq2kvtQHEvI5AjOHFLR0BeWiNVn/VTKr3j70yV+N0pnclT+y0ni3kiO+aY7Aq66eukFqGNyhox3eTu989SreSiSDY6XeobExFpNyDG
X-Gm-Message-State: AOJu0YyNZ7PG9RYM2Cmc1EmiviGnEOnotsnDyAQWkcKmYr5wjejCvuT4
	aSZ1FNOebdqRfp5QfLCqr1dcqSFCjT42Qn1F5C/iS097CmdyUHxCp9dTUkW4EA==
X-Google-Smtp-Source: AGHT+IFkQ+P3o8JhNlfXXJ3DTmdGuu1dXdBmx+jdWfrWXF8acBg2QGOM6vQP9wmCgvxhVl5eDn+lBw==
X-Received: by 2002:a05:6a00:99e:b0:705:9b04:71b with SMTP id d2e1a72fcca58-7067471bf13mr19564882b3a.31.1719539528941;
        Thu, 27 Jun 2024 18:52:08 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:c19a:b9a8:4bd1:72c0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-708045aac85sm393354b3a.174.2024.06.27.18.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 18:52:08 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: Chengming Zhou <chengming.zhou@linux.dev>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH] zsmalloc: rename class stat mutators
Date: Fri, 28 Jun 2024 10:42:52 +0900
Message-ID: <20240628015154.3230389-1-senozhatsky@chromium.org>
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
 mm/zsmalloc.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index fec1a39e5bbe..17a8304504cc 100644
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
 
@@ -1375,7 +1375,7 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
 		/* Now move the zspage to another fullness group, if required */
 		fix_fullness_group(class, zspage);
 		record_obj(handle, obj);
-		class_stat_inc(class, ZS_OBJS_INUSE, 1);
+		class_stat_add(class, ZS_OBJS_INUSE, 1);
 
 		goto out;
 	}
@@ -1394,8 +1394,8 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
 	insert_zspage(class, zspage, newfg);
 	record_obj(handle, obj);
 	atomic_long_add(class->pages_per_zspage, &pool->pages_allocated);
-	class_stat_inc(class, ZS_OBJS_ALLOCATED, class->objs_per_zspage);
-	class_stat_inc(class, ZS_OBJS_INUSE, 1);
+	class_stat_add(class, ZS_OBJS_ALLOCATED, class->objs_per_zspage);
+	class_stat_add(class, ZS_OBJS_INUSE, 1);
 
 	/* We completely set up zspage so mark them as movable */
 	SetZsPageMovable(pool, zspage);
@@ -1456,7 +1456,7 @@ void zs_free(struct zs_pool *pool, unsigned long handle)
 	spin_lock(&class->lock);
 	read_unlock(&pool->migrate_lock);
 
-	class_stat_dec(class, ZS_OBJS_INUSE, 1);
+	class_stat_sub(class, ZS_OBJS_INUSE, 1);
 	obj_free(class->size, obj);
 
 	fullness = fix_fullness_group(class, zspage);
@@ -1925,8 +1925,8 @@ static inline void zs_flush_migration(struct zs_pool *pool) { }
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


