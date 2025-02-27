Return-Path: <linux-kernel+bounces-535563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDBFA4748D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 05:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECFCA188C5D7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 04:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C5F1E8355;
	Thu, 27 Feb 2025 04:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T9gt1wP+"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0209E1EB5F0
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 04:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740631004; cv=none; b=u7CQcRAJleWrNb8NZbPbWNIV0JM9Danf5QKrW0A5RkvOkTXa+PWfOLgTnNKVbivdvgOBhlYXdJbF9nWMpYDVC0iYi6quNd87DJDMyzgtIzZBz2LnhM4VxEZHeyejbMqh7FebVfhBTzow1d6adSFAJ28rm3xCcsH0w9b+IQ1rsgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740631004; c=relaxed/simple;
	bh=oM2weTCG6aXFCSbtyL8s8eEDcdB0ofZTgnmGMVi6B3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VQ7VtjI8XvjCuKpWTkGOx9hH7b/eTM3rPpumDoilhWPl1ndjcdnJRWR2KkxT5fRxz6kPusuUXdEu5gFcgmjZLaVqRnJY1kQPPV933BRDVpH5wfXa3a+TYPHfJGhSCEJG5NHjgxe8JGYeqwHyPt78ELHA7lWSVn5YvKAHGYmthMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=T9gt1wP+; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-220c8f38febso8025085ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 20:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740631002; x=1741235802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k3g8UcvdgyQ3xyw+tSoX3H8q6cI5L8QKqPIepd+Unng=;
        b=T9gt1wP+k7PWMzr8J9mXzx+0JTgHOsIKcFOZ1fbfOrFam3q1nBUZ+TI5DH1gjg1Qjn
         ohZyGAkVnH8g0y7EmDDExY08jv92Jp4LEBkotskqKGqJKetuaH/8tNsTUQXx1kw1i1pS
         n9dYMDJov5w1llBDSyTHJORKXDJkA76SRuXQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740631002; x=1741235802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k3g8UcvdgyQ3xyw+tSoX3H8q6cI5L8QKqPIepd+Unng=;
        b=bzXy/g/kCkC3UeKhVGxXiQqgsPPvT4+jt/Fx++MhqMe2iJBZk473Pghyp9EoVRFuCW
         cbzphfoaUxLhI53SrQeeHcC4Auf/C4e7q6GBvfzgF05cdB0bPrY2WagB4Gv9gJdh+tU/
         T5yedNGA1yXoH2Ojpg8EPodhq17FxhHJihfF08AheuM833Rt5wHHdescN7TtLBglOK/1
         QiOY5G735vgJCwPQuonCzTdnK1YV8rS8ReDPs1A6jt9u5YPcdmtwPIdm+uGp6oguvl0y
         eRIuOXHxcZrrovQVFWdeLutjD0rm4gCXOyxc8Oe17RUrTCCAjQ8zOiaaPp5BXImNO9iJ
         wTXA==
X-Forwarded-Encrypted: i=1; AJvYcCWvIRzOsDVJPdsIRu1cBwZdncQNc0BWSNiEXr0hQgkaokMJZFsIfEKRPJ80fYNT/8j7XVsy8q1VGTCB2VY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKJgwBjiPMREWRMvr6Y+qgA4JzHFcPHQLV7muLQdKJcBE7WYTQ
	6JGkkAIjUo1RVn+xMC25aA7wo5wE39p5o/hUUe2nSRxG3YXeMllULdam6mT/8g==
X-Gm-Gg: ASbGncuR16BnEEsOLEyCLScQBw7z+tVNEv8eqGEEx7K7P5v1BOO409fDdRzJA8uEjlo
	pNQ4t5gexill+toSH4sGseIgC1hxBqLOCZOMfQHmIN0eJp1E2woKSfNRReorYzJS/csfzs/NQan
	xsrhW6kILy7ObsUN25H6r9mcvA/Hc1tCfcBwltnYls4+gytMm/4/BigR581jc8xETwTjm8quLFe
	SAlfv6BlsaC9kJABvg0E95fFPk6ZOwuZ7LSO90uqYFMxE+t3uQMbaU4m2Y93lnPu5N8ThAMLZ5f
	fVRp1Jp1UrJ8VQvUZKyTZMij6mg6
X-Google-Smtp-Source: AGHT+IFKqiVpX1vg0EKtsAPxxL19rWKpvI+zaBubIUtbgTf7uq8NxOqv9BQnr4f0Yj2mw3OI5Ik1WQ==
X-Received: by 2002:a05:6a00:23c1:b0:730:4598:ddb5 with SMTP id d2e1a72fcca58-73426c8d300mr33904409b3a.2.1740631002104;
        Wed, 26 Feb 2025 20:36:42 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:a9c0:1bc1:74e3:3e31])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7349fe4cc2asm515402b3a.52.2025.02.26.20.36.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 20:36:41 -0800 (PST)
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
Subject: [PATCH v9 02/19] zram: permit preemption with active compression stream
Date: Thu, 27 Feb 2025 13:35:20 +0900
Message-ID: <20250227043618.88380-3-senozhatsky@chromium.org>
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
Reviewed-by: Yosry Ahmed <yosry.ahmed@linux.dev>
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
index ddf03f6cbeed..545e64ee6234 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1607,7 +1607,7 @@ static int read_compressed_page(struct zram *zram, struct page *page, u32 index)
 	ret = zcomp_decompress(zram->comps[prio], zstrm, src, size, dst);
 	kunmap_local(dst);
 	zs_unmap_object(zram->mem_pool, handle);
-	zcomp_stream_put(zram->comps[prio]);
+	zcomp_stream_put(zstrm);
 
 	return ret;
 }
@@ -1768,14 +1768,14 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
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
 
@@ -1799,7 +1799,7 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 				   __GFP_HIGHMEM |
 				   __GFP_MOVABLE);
 	if (IS_ERR_VALUE(handle)) {
-		zcomp_stream_put(zram->comps[ZRAM_PRIMARY_COMP]);
+		zcomp_stream_put(zstrm);
 		atomic64_inc(&zram->stats.writestall);
 		handle = zs_malloc(zram->mem_pool, comp_len,
 				   GFP_NOIO | __GFP_HIGHMEM |
@@ -1811,7 +1811,7 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 	}
 
 	if (!zram_can_store_page(zram)) {
-		zcomp_stream_put(zram->comps[ZRAM_PRIMARY_COMP]);
+		zcomp_stream_put(zstrm);
 		zs_free(zram->mem_pool, handle);
 		return -ENOMEM;
 	}
@@ -1819,7 +1819,7 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 	dst = zs_map_object(zram->mem_pool, handle, ZS_MM_WO);
 
 	memcpy(dst, zstrm->buffer, comp_len);
-	zcomp_stream_put(zram->comps[ZRAM_PRIMARY_COMP]);
+	zcomp_stream_put(zstrm);
 	zs_unmap_object(zram->mem_pool, handle);
 
 	zram_slot_lock(zram, index);
@@ -1978,7 +1978,7 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
 		kunmap_local(src);
 
 		if (ret) {
-			zcomp_stream_put(zram->comps[prio]);
+			zcomp_stream_put(zstrm);
 			return ret;
 		}
 
@@ -1988,7 +1988,7 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
 		/* Continue until we make progress */
 		if (class_index_new >= class_index_old ||
 		    (threshold && comp_len_new >= threshold)) {
-			zcomp_stream_put(zram->comps[prio]);
+			zcomp_stream_put(zstrm);
 			continue;
 		}
 
@@ -2046,13 +2046,13 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
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
2.48.1.658.g4767266eb4-goog


