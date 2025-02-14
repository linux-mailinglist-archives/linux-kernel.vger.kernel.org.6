Return-Path: <linux-kernel+bounces-514349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7600A355E2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 05:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58D0C3AC241
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 04:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC9116DC12;
	Fri, 14 Feb 2025 04:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LGhHhtXM"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30883189F5C
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 04:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739508752; cv=none; b=EFMbVPnWbnjim/jxnU37a0Oz9+xq7cgpMQkjuGL748TZDID7fZ84kiRbqE1z4Nz8nTz6OIn5NPg2GXyl7qWZYEPzlTjVl6wzNel9/2WJrs2M1ZsQAh/kgyBbWT33iw8z/JW1KKkRQ80vccoX1IY8qy/8T6H/e6Lk4HfO5I8rWYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739508752; c=relaxed/simple;
	bh=cTSQlUOAophX88GzGIXzoLy3Kd/dLmUyKJ8dAbZqZ1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ECQXy0gIzoL+LbWHDbGOdOKH9wE+v3aBIVC78uqlfrfwv5F/+FpClEYyM5G2ZcfbEB+EfidiZLXYVHrRXrh8J0GTtqxGNpUyx0iEr5PX1tMk/OqaY9lW3Smm6PJB4r0IDtO5c1bSq/ROOSpMx4R0uJm2LhsCUebLIBSxdFt/7HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LGhHhtXM; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21f48ebaadfso33032225ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 20:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739508750; x=1740113550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F9dA9jZ1k0KVleOPZIXSXpGbAAlfZaWcl2QUySckvQY=;
        b=LGhHhtXMivP4d30hhHPNx0u25y7iJjDr0GP/twjBk49s0h6jqnYh+6IpkIYZSRu8Li
         ioReIZtM1TDFfWxWFK1XeSBVF71FeavQ2DkeE6oclOO31ny6fE/paIds2q8PNflmoL31
         dbLjsJsE6ur/K3tR820c5d/KvkPOnh5jC7Zm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739508750; x=1740113550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F9dA9jZ1k0KVleOPZIXSXpGbAAlfZaWcl2QUySckvQY=;
        b=wIzo5vgXdsoy52yzDkoEnYhlfMDhqWhfvnb8ffNXPsQOAElSKWGzp7SCqr37nJ+PS1
         5nyk83a38hGg+ROcODQyUvGtMAIA315EljALRmjuTezmBBnhkeOCjfqXTySboQ6mYlty
         SZwh+6XQGaqTwIlbAnocMBbiEQltz8/nOrLF//b2ngGVn3KPHia5CM2WjvkwujpMTekp
         1/c97xHuF9bIN3nIkIHUmnPKAmpe2OAqazULyA1d9ID/JkpFnuG09yTZKFfhnryvDSGl
         uUlTva+qJRi3M9QkxwZYDdwYtzxgvg6n+dGMu3AlyDt4Sd5PMv7fT9DgLa8l69KKuh6O
         oomw==
X-Forwarded-Encrypted: i=1; AJvYcCWt1NmsDQsKl90U1CHCro7ec/Lwy+IaYZYhmcH0Sz2Fo02zGaELeaPVjtjg+IZFs6zU6u+wFA5A6Wmb/EI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzrKDqUPEoRN7+hbAGMCKvqUAs0GGMs3GkGgVCROUmLUv4F9HE
	icOTM+b/cp8Msp9JAjCMMUz6ClkAcSOn9bxf2j+ZDfl5fHVjxUniBWEf6UJnlQ==
X-Gm-Gg: ASbGnctn3QAf0u7K2gB8YWeA1mIr3DQiJZnkHykYWarhySahvjJpsY2FvsvW4MXg6C8
	m1upunRBrYCXIglIFFu4lMRNZdjIhUAfy7JJAD/kxGum/e5BWWisFkgyrvuzoMiD6tcfAeK7GUy
	cC2wZXAp+ngYjz8MvG7gCdlOL4Qv/ObgSBwkhLFVf+JXvEFtlZ6FMWOH4GMyQ4TxYNTx+gfywf7
	X6F0Ffe7k/Clqc8mE/QiFkXe55O1s4FPnDDL7E5vU/qgSqgeB8WEwV0yL2w6uRaHDUB/gY31MlV
	B4xg5lWs+SLu8a2QcA==
X-Google-Smtp-Source: AGHT+IHeCccqw7BKz3Nps1nE3WUkuQd67prY/a7knQl57N4aYVrwMvzOwtITAs71quYBmeF0jfumUw==
X-Received: by 2002:a05:6a21:898a:b0:1ee:5d05:a197 with SMTP id adf61e73a8af0-1ee5d05a2b1mr13268542637.35.1739508750392;
        Thu, 13 Feb 2025 20:52:30 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:942d:9291:22aa:8126])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73242761c13sm2252705b3a.136.2025.02.13.20.52.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 20:52:30 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>,
	Hillf Danton <hdanton@sina.com>,
	Kairui Song <ryncsn@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v6 02/17] zram: permit preemption with active compression stream
Date: Fri, 14 Feb 2025 13:50:14 +0900
Message-ID: <20250214045208.1388854-3-senozhatsky@chromium.org>
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

Currently, per-CPU stream access is done from a non-preemptible
(atomic) section, which imposes the same atomicity requirements on
compression backends as entry spin-lock, and makes it impossible
to use algorithms that can schedule/wait/sleep during compression
and decompression.

Switch to preemptible per-CPU model, similar to the one used
in zswap.  Instead of a per-CPU local lock, each stream carries
a mutex which is locked throughout entire time zram uses it
for compression or decompression, so that cpu-dead event waits
for zram to stop using a particular per-CPU stream and release
it.

Suggested-by: Yosry Ahmed <yosry.ahmed@linux.dev>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zcomp.c    | 41 +++++++++++++++++++++++++----------
 drivers/block/zram/zcomp.h    |  6 ++---
 drivers/block/zram/zram_drv.c | 20 ++++++++---------
 3 files changed, 42 insertions(+), 25 deletions(-)

diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index bb514403e305..53e4c37441be 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -6,7 +6,7 @@
 #include <linux/slab.h>
 #include <linux/wait.h>
 #include <linux/sched.h>
-#include <linux/cpu.h>
+#include <linux/cpuhotplug.h>
 #include <linux/crypto.h>
 #include <linux/vmalloc.h>
 
@@ -109,13 +109,29 @@ ssize_t zcomp_available_show(const char *comp, char *buf)
 
 struct zcomp_strm *zcomp_stream_get(struct zcomp *comp)
 {
-	local_lock(&comp->stream->lock);
-	return this_cpu_ptr(comp->stream);
+	for (;;) {
+		struct zcomp_strm *zstrm = raw_cpu_ptr(comp->stream);
+
+		/*
+		 * Inspired by zswap
+		 *
+		 * stream is returned with ->mutex locked which prevents
+		 * cpu_dead() from releasing this stream under us, however
+		 * there is still a race window between raw_cpu_ptr() and
+		 * mutex_lock(), during which we could have been migrated
+		 * from a CPU that has already destroyed its stream.  If
+		 * so then unlock and re-try on the current CPU.
+		 */
+		mutex_lock(&zstrm->lock);
+		if (likely(zstrm->buffer))
+			return zstrm;
+		mutex_unlock(&zstrm->lock);
+	}
 }
 
-void zcomp_stream_put(struct zcomp *comp)
+void zcomp_stream_put(struct zcomp_strm *zstrm)
 {
-	local_unlock(&comp->stream->lock);
+	mutex_unlock(&zstrm->lock);
 }
 
 int zcomp_compress(struct zcomp *comp, struct zcomp_strm *zstrm,
@@ -151,12 +167,9 @@ int zcomp_decompress(struct zcomp *comp, struct zcomp_strm *zstrm,
 int zcomp_cpu_up_prepare(unsigned int cpu, struct hlist_node *node)
 {
 	struct zcomp *comp = hlist_entry(node, struct zcomp, node);
-	struct zcomp_strm *zstrm;
+	struct zcomp_strm *zstrm = per_cpu_ptr(comp->stream, cpu);
 	int ret;
 
-	zstrm = per_cpu_ptr(comp->stream, cpu);
-	local_lock_init(&zstrm->lock);
-
 	ret = zcomp_strm_init(comp, zstrm);
 	if (ret)
 		pr_err("Can't allocate a compression stream\n");
@@ -166,16 +179,17 @@ int zcomp_cpu_up_prepare(unsigned int cpu, struct hlist_node *node)
 int zcomp_cpu_dead(unsigned int cpu, struct hlist_node *node)
 {
 	struct zcomp *comp = hlist_entry(node, struct zcomp, node);
-	struct zcomp_strm *zstrm;
+	struct zcomp_strm *zstrm = per_cpu_ptr(comp->stream, cpu);
 
-	zstrm = per_cpu_ptr(comp->stream, cpu);
+	mutex_lock(&zstrm->lock);
 	zcomp_strm_free(comp, zstrm);
+	mutex_unlock(&zstrm->lock);
 	return 0;
 }
 
 static int zcomp_init(struct zcomp *comp, struct zcomp_params *params)
 {
-	int ret;
+	int ret, cpu;
 
 	comp->stream = alloc_percpu(struct zcomp_strm);
 	if (!comp->stream)
@@ -186,6 +200,9 @@ static int zcomp_init(struct zcomp *comp, struct zcomp_params *params)
 	if (ret)
 		goto cleanup;
 
+	for_each_possible_cpu(cpu)
+		mutex_init(&per_cpu_ptr(comp->stream, cpu)->lock);
+
 	ret = cpuhp_state_add_instance(CPUHP_ZCOMP_PREPARE, &comp->node);
 	if (ret < 0)
 		goto cleanup;
diff --git a/drivers/block/zram/zcomp.h b/drivers/block/zram/zcomp.h
index ad5762813842..23b8236b9090 100644
--- a/drivers/block/zram/zcomp.h
+++ b/drivers/block/zram/zcomp.h
@@ -3,7 +3,7 @@
 #ifndef _ZCOMP_H_
 #define _ZCOMP_H_
 
-#include <linux/local_lock.h>
+#include <linux/mutex.h>
 
 #define ZCOMP_PARAM_NO_LEVEL	INT_MIN
 
@@ -31,7 +31,7 @@ struct zcomp_ctx {
 };
 
 struct zcomp_strm {
-	local_lock_t lock;
+	struct mutex lock;
 	/* compression buffer */
 	void *buffer;
 	struct zcomp_ctx ctx;
@@ -77,7 +77,7 @@ struct zcomp *zcomp_create(const char *alg, struct zcomp_params *params);
 void zcomp_destroy(struct zcomp *comp);
 
 struct zcomp_strm *zcomp_stream_get(struct zcomp *comp);
-void zcomp_stream_put(struct zcomp *comp);
+void zcomp_stream_put(struct zcomp_strm *zstrm);
 
 int zcomp_compress(struct zcomp *comp, struct zcomp_strm *zstrm,
 		   const void *src, unsigned int *dst_len);
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 65e16117f2db..ca439f3b1b9a 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1650,7 +1650,7 @@ static int read_compressed_page(struct zram *zram, struct page *page, u32 index)
 	ret = zcomp_decompress(zram->comps[prio], zstrm, src, size, dst);
 	kunmap_local(dst);
 	zs_unmap_object(zram->mem_pool, handle);
-	zcomp_stream_put(zram->comps[prio]);
+	zcomp_stream_put(zstrm);
 
 	return ret;
 }
@@ -1811,14 +1811,14 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 	kunmap_local(mem);
 
 	if (unlikely(ret)) {
-		zcomp_stream_put(zram->comps[ZRAM_PRIMARY_COMP]);
+		zcomp_stream_put(zstrm);
 		pr_err("Compression failed! err=%d\n", ret);
 		zs_free(zram->mem_pool, handle);
 		return ret;
 	}
 
 	if (comp_len >= huge_class_size) {
-		zcomp_stream_put(zram->comps[ZRAM_PRIMARY_COMP]);
+		zcomp_stream_put(zstrm);
 		return write_incompressible_page(zram, page, index);
 	}
 
@@ -1842,7 +1842,7 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 				   __GFP_HIGHMEM |
 				   __GFP_MOVABLE);
 	if (IS_ERR_VALUE(handle)) {
-		zcomp_stream_put(zram->comps[ZRAM_PRIMARY_COMP]);
+		zcomp_stream_put(zstrm);
 		atomic64_inc(&zram->stats.writestall);
 		handle = zs_malloc(zram->mem_pool, comp_len,
 				   GFP_NOIO | __GFP_HIGHMEM |
@@ -1854,7 +1854,7 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 	}
 
 	if (!zram_can_store_page(zram)) {
-		zcomp_stream_put(zram->comps[ZRAM_PRIMARY_COMP]);
+		zcomp_stream_put(zstrm);
 		zs_free(zram->mem_pool, handle);
 		return -ENOMEM;
 	}
@@ -1862,7 +1862,7 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 	dst = zs_map_object(zram->mem_pool, handle, ZS_MM_WO);
 
 	memcpy(dst, zstrm->buffer, comp_len);
-	zcomp_stream_put(zram->comps[ZRAM_PRIMARY_COMP]);
+	zcomp_stream_put(zstrm);
 	zs_unmap_object(zram->mem_pool, handle);
 
 	zram_slot_lock(zram, index);
@@ -2021,7 +2021,7 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
 		kunmap_local(src);
 
 		if (ret) {
-			zcomp_stream_put(zram->comps[prio]);
+			zcomp_stream_put(zstrm);
 			return ret;
 		}
 
@@ -2031,7 +2031,7 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
 		/* Continue until we make progress */
 		if (class_index_new >= class_index_old ||
 		    (threshold && comp_len_new >= threshold)) {
-			zcomp_stream_put(zram->comps[prio]);
+			zcomp_stream_put(zstrm);
 			continue;
 		}
 
@@ -2089,13 +2089,13 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
 			       __GFP_HIGHMEM |
 			       __GFP_MOVABLE);
 	if (IS_ERR_VALUE(handle_new)) {
-		zcomp_stream_put(zram->comps[prio]);
+		zcomp_stream_put(zstrm);
 		return PTR_ERR((void *)handle_new);
 	}
 
 	dst = zs_map_object(zram->mem_pool, handle_new, ZS_MM_WO);
 	memcpy(dst, zstrm->buffer, comp_len_new);
-	zcomp_stream_put(zram->comps[prio]);
+	zcomp_stream_put(zstrm);
 
 	zs_unmap_object(zram->mem_pool, handle_new);
 
-- 
2.48.1.601.g30ceb7b040-goog


