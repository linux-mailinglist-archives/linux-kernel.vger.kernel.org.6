Return-Path: <linux-kernel+bounces-540874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F3CA4B609
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 03:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 935AA3AF7C7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 02:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95E7158D8B;
	Mon,  3 Mar 2025 02:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ln8MM9VO"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F3918A6C4
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 02:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740968687; cv=none; b=g6GXZVo3HkUAQ6uxoi3X65qyeFb3g9YiIV234cc5TKCNIi5tnLSky3iyH9iCBi396I3IXrYxaDRpXebgwiX1XGY2sH72j18AtV+qjkgbJk8s6g6AjUTEbZz0JosOScnBAdhWIVf5VFWu4o+Yn38nbTsEXhBuRpdVurzmaYB4USM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740968687; c=relaxed/simple;
	bh=vsGOSwouO8U4URKs20bupIG27NGRE2VX5d3kClMGF88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tDyd5qPBbgK7vyIEy+lGtIpulI0DjUweg4SUq4fC3A1sapsoHN8+1Gu4wn8BvYzhRvDPG4vB+Z39vMYpADoroEbpkjdnMGbahT7IsC3rjzUQJQW8KrO7JY45orwgqtO/L1D3ThvipyonmUxMZihzraPyKALb0g63rkvrrR7Mvl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ln8MM9VO; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2235189adaeso58833455ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 18:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740968685; x=1741573485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jDqZrH9W9+qGmX1OXU2Vyl3xsabTv9L/+SLAveE4fcw=;
        b=Ln8MM9VO0B43F3BMxnTUKkBTRBu8UXscN14HqzUPFNPUfMCmLpL8K08LKO7cvt84mZ
         glDoTK3S1BoCjIRU9mRaCyOwMggbsfnNK4K8oYHCDzD6sYWG6mUOciqMP2GTtyb98wHF
         0uNP654qRi8tiJzMlfr1Nc0OChArLuCvyhSPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740968685; x=1741573485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jDqZrH9W9+qGmX1OXU2Vyl3xsabTv9L/+SLAveE4fcw=;
        b=A1mnIqxFRfsMHLUmQdOl92xzU6cOnxW3B20b2m9XUos/QrCRHIT3XJhkwoTAYT/FY/
         5OqbuSR0pX1Sj4XOG14mi6ih0KFxamW1tj7cGCdQ+Yn5aSXJ53A6RmqnSwiL1GuPHwY9
         Cv2rFKz1hq6UGznLjrUxsEwfhYorLuJzTWmrndvuq0h1agPkXRZFVldyuF+6yNsWpyas
         WcT+B5LA6BZXSQeDD0RTvU06+T5cZOk7TSMDTOrDIkHXosGK4gMFPvLnSPtNll2BVR2E
         EQF6Tj3RNlJU7sh24tKP6V8oCG/cgjB1g4Srf1/NJhXNLY8LH/XOhzdJZgn9urFK4VGU
         CLwA==
X-Forwarded-Encrypted: i=1; AJvYcCXrrC+NJZHN8kxpCVqhgm3LsJDPJRd5GlRUToicrUWvY6BaY9JtrVBEc1LE3oDXv7WkrbhIm1vgMjny9Nw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPpXlrtC+yXgYXSqf6u3uiUUwH3NpRterpsS5JwKaMo/jtYV9R
	YLTDa86jhs8tYv/JJgHHMEjubRrgmSoPpbI6bbeLJMjQ372rGpdKKxx0A8IutA==
X-Gm-Gg: ASbGnctzd4sXZA9YES4hGhhFiCBEY5zUzgpfeVC/WEDrpjvbFl+73IJVYeov1ewgJyQ
	OWfyKT82EDUwkgh7kYDrffnpeiVhJZTS+fLuslU9LcHiG9eSIouCJV6EhV+0g+ynWdaXiRVJ7nN
	n9RSe+BpPDdehc3nazi67BDuFoXu9X+32qM0tsJ3xcLJ+Dc0ZRl3+X1xWq6JuFyMZw49ocCkqc9
	UEkIW36gmtwqvKmpg8WoapV1n7EcI8Qt9qZw83/GGi2P9H0jqvcwrPSONxlD7yhXKjvAKB9IqV3
	jKFTmFMUKHt61h98oe3UI/ryi4RJTMJHLTE0FJUPNxFTA/k=
X-Google-Smtp-Source: AGHT+IGEtduyJTi51HPkBHttjdqcJfHiW6RA1OErSt85BYtPP72gIAiy5XzU4m9bzS3f4VCOBOOEpw==
X-Received: by 2002:a17:903:2986:b0:21f:6546:9adc with SMTP id d9443c01a7336-2234a38cd53mr253511975ad.13.1740968685435;
        Sun, 02 Mar 2025 18:24:45 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:1513:4f61:a4d3:b418])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-223501d5247sm66569735ad.26.2025.03.02.18.24.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Mar 2025 18:24:45 -0800 (PST)
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
Subject: [PATCH v10 02/19] zram: permit preemption with active compression stream
Date: Mon,  3 Mar 2025 11:03:11 +0900
Message-ID: <20250303022425.285971-3-senozhatsky@chromium.org>
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
Reviewed-by: Yosry Ahmed <yosry.ahmed@linux.dev>
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
index 70599d41b828..dd669d48ae6f 100644
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
2.48.1.711.g2feabab25a-goog


