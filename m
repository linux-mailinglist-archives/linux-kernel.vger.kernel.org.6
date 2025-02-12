Return-Path: <linux-kernel+bounces-510578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 616CCA31F09
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 07:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E65B16897E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 06:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9689C201116;
	Wed, 12 Feb 2025 06:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FINMY+Cx"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5094F20126A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 06:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739341979; cv=none; b=N0V4TjA8fMnidCEjRkjmgwXDeJuwkKSTX7ZyyKO/lchzNs9qsnW7mzdBgcmCRFTQ2Iz5e+OBD7KXduIEtAfdtwlQkAHsVxS0aNCHG3Md7fRklqL0jVrEXE7fX7KJXPEMo1+9sD5tITgqLis7ZB1AiOjBgl6e1gA/zoZthwchcl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739341979; c=relaxed/simple;
	bh=7dbXBWyL/2c9f+MJeW6Vq0IhAO1Sls7FTtrD05JhIpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DOi9zLVeWALdRfFxGEjcd3rR2ZoVDy/efEbBObNV+tIySJm4+bG7rlrvZHsF/5g+fWkxXpt5Etgh7+HI2v38hI0+XPvnejl7Xz8UNrIkkHYrpEBrWgreJS5e1y51FDC9h21QfmphgFML6PcigRuKPfTzdFfqOOUOi8pzcq4gnPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FINMY+Cx; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21f2339dcfdso8269055ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 22:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739341978; x=1739946778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Z728glTbJRUijcb8TCkc0Ox5AYTm//47KQTAd0HAqQ=;
        b=FINMY+CxaHhC2eRYPmlBr5i9rNcCKLzZQN+oIgXweFPGVWGyGbi9OIeVRpuNAC+2DM
         Zj6UB9T/riyn6RBgrwURyzSvDZtEqVaPh76XpEXLvmuKAa5tc8PmJc42rJzk08BIqmri
         epjmNQP3ANORzINwiDyYyipRyYbBit4+JVYEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739341978; x=1739946778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Z728glTbJRUijcb8TCkc0Ox5AYTm//47KQTAd0HAqQ=;
        b=GKUxoEKJIQ2QusO+yIjH/IIYK232WYKc80RDonIZKTbtDhO6b+ljpuxZKftzn0XKPH
         29S5d8vTovNBg9xxVst3RdusrBHEYsNUZWq68l8PCX9U+on0FrJRrWq5P9Zskkl8I7I1
         pJwNTujj1j4yPIcBuM6WBn5fa14+fDHnlWw/vMfTcfMMvWXtHshYcfy2q3vk2nR6TCbn
         5xeAnlIW1RccfuSMy+nPf3UI04mX0fv1oFozOCmpvr8d2cgTeIq8CMb9aFb/iue1IKa0
         tJrH6P7pXE0eJA8FPYOLbKp0iTpPS7AZ5Q3IWjpiS2KY/HQI0bY5PXdauXlFGHwtDS9Z
         CvBA==
X-Forwarded-Encrypted: i=1; AJvYcCVerjLWiKnMYrQwLBTVTrAQ+8FEVMA7B13jg+wZ70bLPiI6x8D+EfZ7pjwih5Ay5monJAXOnSHyj33JnNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4ZsMkoulr/HaBWxXacf0m5TNpAE3I5lIukfWJhdoEILp1iBeT
	2sfxBcupTynuuXgsoJRphvGIX/IQApJi0aLgw00yNwNmIQR1FbLDdC6nwGV9Yw==
X-Gm-Gg: ASbGncsqAxDrNtcNsOHQSpMZgoqw3y++QDAWyixqGbHL8A3wYWdYo7Rb2zfCHLFEQFi
	z+FvrMQyfg/nqY8kmFkm6lJQQmtbikjzxbq3vxJ6d2rpzlR4ileQv0d95QiNJr+sOtuZTRBEJT1
	ZImhhlWPWzq0MqjisLe1OZlH7U/VmhzcOgwrd2HnN2+ro1THUR7k7uAViIAqK7fmO/tOah4tgkQ
	3MRmH/YTLJjJF8BexDCXFa36Jgu0qp+jGuDQ+lg0vUH1OVGY9WfRpN2S3xhm86HRwVOALlGBFis
	arfvO7iXmVK91dBHlQ==
X-Google-Smtp-Source: AGHT+IH9novtJAP2nahMJtf23e6d5DXnQj2BtTSpA3K6387kmaUUk7tqOB+00czVkoYIJ9iJRKWKIQ==
X-Received: by 2002:a17:90b:2b45:b0:2fa:1c09:3cee with SMTP id 98e67ed59e1d1-2faa0913acemr9497572a91.9.1739341977607;
        Tue, 11 Feb 2025 22:32:57 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:69f5:6852:451e:8142])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fbf98cffddsm658335a91.21.2025.02.11.22.32.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 22:32:57 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>,
	Kairui Song <ryncsn@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v5 11/18] zsmalloc: factor out size-class locking helpers
Date: Wed, 12 Feb 2025 15:27:09 +0900
Message-ID: <20250212063153.179231-12-senozhatsky@chromium.org>
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

Move open-coded size-class locking to dedicated helpers.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Reviewed-by: Yosry Ahmed <yosry.ahmed@linux.dev>
---
 mm/zsmalloc.c | 47 ++++++++++++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 19 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 47c638df47c5..c82c24b8e6a4 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -253,6 +253,16 @@ static bool pool_lock_is_contended(struct zs_pool *pool)
 	return rwlock_is_contended(&pool->lock);
 }
 
+static void size_class_lock(struct size_class *class)
+{
+	spin_lock(&class->lock);
+}
+
+static void size_class_unlock(struct size_class *class)
+{
+	spin_unlock(&class->lock);
+}
+
 static inline void zpdesc_set_first(struct zpdesc *zpdesc)
 {
 	SetPagePrivate(zpdesc_page(zpdesc));
@@ -613,8 +623,7 @@ static int zs_stats_size_show(struct seq_file *s, void *v)
 		if (class->index != i)
 			continue;
 
-		spin_lock(&class->lock);
-
+		size_class_lock(class);
 		seq_printf(s, " %5u %5u ", i, class->size);
 		for (fg = ZS_INUSE_RATIO_10; fg < NR_FULLNESS_GROUPS; fg++) {
 			inuse_totals[fg] += class_stat_read(class, fg);
@@ -624,7 +633,7 @@ static int zs_stats_size_show(struct seq_file *s, void *v)
 		obj_allocated = class_stat_read(class, ZS_OBJS_ALLOCATED);
 		obj_used = class_stat_read(class, ZS_OBJS_INUSE);
 		freeable = zs_can_compact(class);
-		spin_unlock(&class->lock);
+		size_class_unlock(class);
 
 		objs_per_zspage = class->objs_per_zspage;
 		pages_used = obj_allocated / objs_per_zspage *
@@ -1399,7 +1408,7 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
 	class = pool->size_class[get_size_class_index(size)];
 
 	/* class->lock effectively protects the zpage migration */
-	spin_lock(&class->lock);
+	size_class_lock(class);
 	zspage = find_get_zspage(class);
 	if (likely(zspage)) {
 		obj_malloc(pool, zspage, handle);
@@ -1410,7 +1419,7 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
 		goto out;
 	}
 
-	spin_unlock(&class->lock);
+	size_class_unlock(class);
 
 	zspage = alloc_zspage(pool, class, gfp);
 	if (!zspage) {
@@ -1418,7 +1427,7 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
 		return (unsigned long)ERR_PTR(-ENOMEM);
 	}
 
-	spin_lock(&class->lock);
+	size_class_lock(class);
 	obj_malloc(pool, zspage, handle);
 	newfg = get_fullness_group(class, zspage);
 	insert_zspage(class, zspage, newfg);
@@ -1429,7 +1438,7 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
 	/* We completely set up zspage so mark them as movable */
 	SetZsPageMovable(pool, zspage);
 out:
-	spin_unlock(&class->lock);
+	size_class_unlock(class);
 
 	return handle;
 }
@@ -1483,7 +1492,7 @@ void zs_free(struct zs_pool *pool, unsigned long handle)
 	obj_to_zpdesc(obj, &f_zpdesc);
 	zspage = get_zspage(f_zpdesc);
 	class = zspage_class(pool, zspage);
-	spin_lock(&class->lock);
+	size_class_lock(class);
 	pool_read_unlock(pool);
 
 	class_stat_sub(class, ZS_OBJS_INUSE, 1);
@@ -1493,7 +1502,7 @@ void zs_free(struct zs_pool *pool, unsigned long handle)
 	if (fullness == ZS_INUSE_RATIO_0)
 		free_zspage(pool, class, zspage);
 
-	spin_unlock(&class->lock);
+	size_class_unlock(class);
 	cache_free_handle(pool, handle);
 }
 EXPORT_SYMBOL_GPL(zs_free);
@@ -1827,7 +1836,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	/*
 	 * the class lock protects zpage alloc/free in the zspage.
 	 */
-	spin_lock(&class->lock);
+	size_class_lock(class);
 	/* the migrate_write_lock protects zpage access via zs_map_object */
 	migrate_write_lock(zspage);
 
@@ -1859,7 +1868,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	 * it's okay to release migration_lock.
 	 */
 	pool_write_unlock(pool);
-	spin_unlock(&class->lock);
+	size_class_unlock(class);
 	migrate_write_unlock(zspage);
 
 	zpdesc_get(newzpdesc);
@@ -1903,10 +1912,10 @@ static void async_free_zspage(struct work_struct *work)
 		if (class->index != i)
 			continue;
 
-		spin_lock(&class->lock);
+		size_class_lock(class);
 		list_splice_init(&class->fullness_list[ZS_INUSE_RATIO_0],
 				 &free_pages);
-		spin_unlock(&class->lock);
+		size_class_unlock(class);
 	}
 
 	list_for_each_entry_safe(zspage, tmp, &free_pages, list) {
@@ -1914,10 +1923,10 @@ static void async_free_zspage(struct work_struct *work)
 		lock_zspage(zspage);
 
 		class = zspage_class(pool, zspage);
-		spin_lock(&class->lock);
+		size_class_lock(class);
 		class_stat_sub(class, ZS_INUSE_RATIO_0, 1);
 		__free_zspage(pool, class, zspage);
-		spin_unlock(&class->lock);
+		size_class_unlock(class);
 	}
 };
 
@@ -1982,7 +1991,7 @@ static unsigned long __zs_compact(struct zs_pool *pool,
 	 * as well as zpage allocation/free
 	 */
 	pool_write_lock(pool);
-	spin_lock(&class->lock);
+	size_class_lock(class);
 	while (zs_can_compact(class)) {
 		int fg;
 
@@ -2012,11 +2021,11 @@ static unsigned long __zs_compact(struct zs_pool *pool,
 			putback_zspage(class, dst_zspage);
 			dst_zspage = NULL;
 
-			spin_unlock(&class->lock);
+			size_class_unlock(class);
 			pool_write_unlock(pool);
 			cond_resched();
 			pool_write_lock(pool);
-			spin_lock(&class->lock);
+			size_class_lock(class);
 		}
 	}
 
@@ -2026,7 +2035,7 @@ static unsigned long __zs_compact(struct zs_pool *pool,
 	if (dst_zspage)
 		putback_zspage(class, dst_zspage);
 
-	spin_unlock(&class->lock);
+	size_class_unlock(class);
 	pool_write_unlock(pool);
 
 	return pages_freed;
-- 
2.48.1.502.g6dc24dfdaf-goog


