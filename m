Return-Path: <linux-kernel+bounces-510567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC9BA31EF3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 07:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8635163F3C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 06:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4971FC7C3;
	Wed, 12 Feb 2025 06:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PK/u8fMg"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444FF1FBEAD
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 06:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739341934; cv=none; b=ph4gerq3n99Oo3YsoDlKKjwXXX/VFt/ja0QPHiCDudEdGBP5E7WVCaHwlom7zhQ3hzLa/rXeJdc1UUsWcnUlWc07k4XPCg0BPTSub20eQ3s4C6aNKwf7ezPtYSJIdBIpcjZ0zZ1ZUHT6grP2TE2zaYNLwx/yx/G+qGX7uZDoaQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739341934; c=relaxed/simple;
	bh=LXWedNzaVZq0ZGYHY+ApfAhWS39CM4qqZneLEOL6z5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QfJOWErEiZN8ZQ25bOoyDRAURBWUBVdcRPDoxOcI1UcgK42wt+m3CYC0mKQudSypF7F4z+YXmK1UVAp34+okHLgLz9u060JWPb7mRlL4DO0hFJIJQu19Pt2XTJinF358fO6PGQLE2q3x8K6IQGJwgDDzbaYpNV06L43RhF1dKT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PK/u8fMg; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21fa56e1583so45799565ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 22:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739341931; x=1739946731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j7H+x+6xpsdKzVL/D/QPxhemiaH/onPBYnSp5xsYcj0=;
        b=PK/u8fMgGr0T8fiARDmlelJ3AtYEVDH9oi0FE98cUMW2DZi6nne/rkm2j1i1DE+mFL
         OrswG6zHm0iHXW2rpADQG7mVbAl9Z2ulwMLGBS7UpJaKBoT2HCbqhZm1RTWkbNfd8D3J
         BZRyaYklO4WBpQccLTRTq9jsE1QZc5Gpic7Dw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739341931; x=1739946731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j7H+x+6xpsdKzVL/D/QPxhemiaH/onPBYnSp5xsYcj0=;
        b=C3+74owzcnM++MufizMFmPVbSR+WDe42vO75p4e/qHc6fqgwnZI1Z27winYMZRyI5C
         itjtKaeEcAAagC4TYB9Stox4ghqMTj1GC7OuASy3WcU97Uc5GpUucBxZ7J43smgO0YQ4
         wWip4GaawqXMt3L89XV0FU5WuW+V/HkSjGF+RD2qMwLVaGtTvUe+b7vpxhSXikcgZ+qP
         SvhUsP43Sg5ZQNwJSBq3NSe9ndPbPmAbn757PstK1stkitsQBiITjy3/Iap5ncBachFQ
         WF1RY3yaFULm1x+OkKsJmxRzeQxlKILf6W3+/gbu0+fBJjM/Xk30VSYIHjnwB7T+TkPu
         FPDA==
X-Forwarded-Encrypted: i=1; AJvYcCXKUIYfs0kp2dX5uRMnKPfII4OJIKKj+NPR9+1rO7025ntyB6rnVc17tPB3+sDZON0rLouXcvjImFmKt6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys/VdpKxmbexsWEQQCKc+q0nE4HSuaFXMHSQ2S046JZ07LOsej
	aMb17Clx6eCkneSVh+9f0xAIzFwMtf3pV/Q/W22ZD8QDuVxdQoSvkTRaAFusuA==
X-Gm-Gg: ASbGncuyzh3eDMmmd2UmIxlrJfQ4lEoojPW6KdKEiRxYBHKey/jSBc9P98BcBsWxm59
	L0bvN0lMh+yZUBDznvc4nT0rqfP80cSfTYIJfI3Nd7nW6Ym2uCQ4LCvxV+lI0J1zTJvAwO6Sfxl
	UTC8EBikd0S8paAe+0Bqn7n196o8tRuI4jA6CusO1y42WcxsnsluBbd3w5CtPshK/v2o3aShXxb
	9fXQ9atkgYzV6GWgb0+QfN5IVHqQV4EWMSS1xlAUnSiCZHFru00REjlMtmsjcAUuzY2BCCfGoCK
	Z6Izv1iad6Sdl0aR+w==
X-Google-Smtp-Source: AGHT+IHq2P1ROpgHywWa5M8Xpzdi4NwWEFRypribFsvZL+hUr50EoXZA3FxWT+dt8VM20Q3kk3TokQ==
X-Received: by 2002:a17:903:2f86:b0:216:2259:a4bd with SMTP id d9443c01a7336-220bbca3a98mr26603225ad.52.1739341931537;
        Tue, 11 Feb 2025 22:32:11 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:69f5:6852:451e:8142])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21f93c7e363sm48246805ad.94.2025.02.11.22.32.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 22:32:11 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>,
	Kairui Song <ryncsn@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v5 02/18] zram: permit preemption with active compression stream
Date: Wed, 12 Feb 2025 15:27:00 +0900
Message-ID: <20250212063153.179231-3-senozhatsky@chromium.org>
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
 drivers/block/zram/zcomp.c    | 36 +++++++++++++++++++++++++----------
 drivers/block/zram/zcomp.h    |  6 +++---
 drivers/block/zram/zram_drv.c | 20 +++++++++----------
 3 files changed, 39 insertions(+), 23 deletions(-)

diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index bb514403e305..e83dd9a80a81 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -7,6 +7,7 @@
 #include <linux/wait.h>
 #include <linux/sched.h>
 #include <linux/cpu.h>
+#include <linux/cpuhotplug.h>
 #include <linux/crypto.h>
 #include <linux/vmalloc.h>
 
@@ -54,6 +55,7 @@ static int zcomp_strm_init(struct zcomp *comp, struct zcomp_strm *zstrm)
 {
 	int ret;
 
+	mutex_init(&zstrm->lock);
 	ret = comp->ops->create_ctx(comp->params, &zstrm->ctx);
 	if (ret)
 		return ret;
@@ -109,13 +111,29 @@ ssize_t zcomp_available_show(const char *comp, char *buf)
 
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
+		 * to a CPU that has already destroyed its stream.  If so
+		 * then unlock and re-try on the current CPU.
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
@@ -151,12 +169,9 @@ int zcomp_decompress(struct zcomp *comp, struct zcomp_strm *zstrm,
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
@@ -166,10 +181,11 @@ int zcomp_cpu_up_prepare(unsigned int cpu, struct hlist_node *node)
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
index 3708436f1d1f..43f460a45e3e 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1608,7 +1608,7 @@ static int read_compressed_page(struct zram *zram, struct page *page, u32 index)
 	ret = zcomp_decompress(zram->comps[prio], zstrm, src, size, dst);
 	kunmap_local(dst);
 	zs_unmap_object(zram->mem_pool, handle);
-	zcomp_stream_put(zram->comps[prio]);
+	zcomp_stream_put(zstrm);
 
 	return ret;
 }
@@ -1769,14 +1769,14 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
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
 
@@ -1800,7 +1800,7 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 				   __GFP_HIGHMEM |
 				   __GFP_MOVABLE);
 	if (IS_ERR_VALUE(handle)) {
-		zcomp_stream_put(zram->comps[ZRAM_PRIMARY_COMP]);
+		zcomp_stream_put(zstrm);
 		atomic64_inc(&zram->stats.writestall);
 		handle = zs_malloc(zram->mem_pool, comp_len,
 				   GFP_NOIO | __GFP_HIGHMEM |
@@ -1812,7 +1812,7 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 	}
 
 	if (!zram_can_store_page(zram)) {
-		zcomp_stream_put(zram->comps[ZRAM_PRIMARY_COMP]);
+		zcomp_stream_put(zstrm);
 		zs_free(zram->mem_pool, handle);
 		return -ENOMEM;
 	}
@@ -1820,7 +1820,7 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 	dst = zs_map_object(zram->mem_pool, handle, ZS_MM_WO);
 
 	memcpy(dst, zstrm->buffer, comp_len);
-	zcomp_stream_put(zram->comps[ZRAM_PRIMARY_COMP]);
+	zcomp_stream_put(zstrm);
 	zs_unmap_object(zram->mem_pool, handle);
 
 	zram_slot_lock(zram, index);
@@ -1979,7 +1979,7 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
 		kunmap_local(src);
 
 		if (ret) {
-			zcomp_stream_put(zram->comps[prio]);
+			zcomp_stream_put(zstrm);
 			return ret;
 		}
 
@@ -1989,7 +1989,7 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
 		/* Continue until we make progress */
 		if (class_index_new >= class_index_old ||
 		    (threshold && comp_len_new >= threshold)) {
-			zcomp_stream_put(zram->comps[prio]);
+			zcomp_stream_put(zstrm);
 			continue;
 		}
 
@@ -2047,13 +2047,13 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
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
2.48.1.502.g6dc24dfdaf-goog


