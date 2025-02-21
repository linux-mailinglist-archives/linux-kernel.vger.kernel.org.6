Return-Path: <linux-kernel+bounces-525489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 519EDA3F093
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE72C7AAAC4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68EC2045A6;
	Fri, 21 Feb 2025 09:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MJfpWWve"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA9F204683
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 09:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740130736; cv=none; b=q2kn7QDsLRKQg4WskEIspOksbUcekkbuSX9UwaAOba9bs9ohfTbYDhGc3lJ728XEAwdgI+YsiK+M6WFujZ7T20oe7r2C7Lb+fEnBkgHzYGxzBBvXgihh4EN6R7G1KfAr7n9BWKiEdx46GG+/AYZ8xK5EmjFU/SDIRZ8ZSV4ExEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740130736; c=relaxed/simple;
	bh=mL5i1Sa1wg6lxiB1S0NhoHqUEh/joJin7q7jPEtON9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s7ROVp/Jt+iPVgfZCQva5kNvsSmKo1uB7x4dfyPY+WkejxlyftR1rRNbf/Sevw9C2xQjjSEjm4PUCaT+Db5wS0halLm6wCiOLE19XJfTrRvCTH1tdh/+BtXpViCj5ni52Lm+rRfGV4X3NNcawUWvglhFax7kw7PyAbyjcyFhySU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MJfpWWve; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-220c2a87378so31242325ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 01:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740130733; x=1740735533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3J2F96AB7zgvGtDzJY4571zbkjr+U9L0eHeRaKN2Txw=;
        b=MJfpWWveGIOibjM+yHAEfAn9UW6130qjvE7mPXPEV2i9KwyLiSOZD4/6moqMhSqlWV
         hq05YKovidkdlra6iezBYO1NEKzdvsZCXrMYfUwBfRlLJK+uZdQlzn8dc+2YmzZfrWpa
         rB66u88h83FXqLektLeEFZmCQxd3hB7RGvxFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740130733; x=1740735533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3J2F96AB7zgvGtDzJY4571zbkjr+U9L0eHeRaKN2Txw=;
        b=o3Vdo2Fb32pMoPK/+PUBJPafWZt/X7zO0JQzB9x/3kOXmpIbJ8s51HjbIwdxvlKDsq
         btXIoS/zZQp/J6pxekxYOiLragtiiycnzeztbArzxfpYdIlwgGZSMty4JkbIy86JNS2+
         zq5SKFDLgvcJomz3SHx8wx8yQZnOh/7KeoWKVAwQATLPzxI7j2ArFBzDF9/bXa+qspdj
         c/BkO6wXUEOZdRbtHmlCe6Qo5NfIfeTnYimihhs1k5LaM4gfcDfcLeApSYWfr/IdN4WU
         6lSQQqvcWflWAf4p8TNIfCP6Ru5+uc3ufDOxGzMI4/3nSYGgWEnss4aoUzWwsrOQiIwc
         CmFw==
X-Forwarded-Encrypted: i=1; AJvYcCX+jcPuj29lGSgBzVV33dMtvZ+SrjPyVktnnrKrbhBq6nYKnmJe9jCpPANb79RiJ0caqCMNaiVc/K23SoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgkO5KnSWHQAxGDNIvXH1gL7jOzsWaRiVN5YwU3xmwQXp9lqs7
	CAJO572XDM38lFd2Nz4WYMc54Szmm0NqrhTs2ntchVSuRu73hQYNiF5ZtsdRhQ==
X-Gm-Gg: ASbGncskjc6RXdgd5wfI0HlHCV88H+ZGUrnI6HZW1lwceRG6vsb9eVlWtfByPi9+scg
	ojVms/C7jPKbhTrx9A9j+7X3fYDY2sR4ZIwDn/6wn8ONoPjGP5LpKZa99umOaWfuDc6Q7XZd3iX
	RzQa9v9RLBuaA92FIlcaOtlwovGstmS+aYn9DY7up1SMF7f9J2S8wZmw4XSY4VrcSHRtlWJUFMQ
	SFrej65UPKE0OM0hRED7JQpXt0iWKWt4qTwKAwheO76zXIB8e/cePQBZ8wOJN39ercoVaxHM2Ej
	iCaHISfaPiBolzTJjsZBEBW3D3Q=
X-Google-Smtp-Source: AGHT+IGOi6SPciorjNACJD3sIjQHlvMRrWmIILFhO0P0XVNPDa2JYcssns8HG8BXkS0LFd21ZLAyMA==
X-Received: by 2002:a05:6a21:3288:b0:1ee:e655:97ea with SMTP id adf61e73a8af0-1eef55b505cmr3612717637.41.1740130733499;
        Fri, 21 Feb 2025 01:38:53 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:f987:e1e:3dbb:2191])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73242546867sm15269312b3a.24.2025.02.21.01.38.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 01:38:53 -0800 (PST)
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
Subject: [PATCH v7 02/17] zram: permit preemption with active compression stream
Date: Fri, 21 Feb 2025 18:37:55 +0900
Message-ID: <20250221093832.1949691-3-senozhatsky@chromium.org>
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
index 31bce7c3ce8b..3fd1608bbe9e 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1613,7 +1613,7 @@ static int read_compressed_page(struct zram *zram, struct page *page, u32 index)
 	ret = zcomp_decompress(zram->comps[prio], zstrm, src, size, dst);
 	kunmap_local(dst);
 	zs_unmap_object(zram->mem_pool, handle);
-	zcomp_stream_put(zram->comps[prio]);
+	zcomp_stream_put(zstrm);
 
 	return ret;
 }
@@ -1774,14 +1774,14 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
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
 
@@ -1805,7 +1805,7 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 				   __GFP_HIGHMEM |
 				   __GFP_MOVABLE);
 	if (IS_ERR_VALUE(handle)) {
-		zcomp_stream_put(zram->comps[ZRAM_PRIMARY_COMP]);
+		zcomp_stream_put(zstrm);
 		atomic64_inc(&zram->stats.writestall);
 		handle = zs_malloc(zram->mem_pool, comp_len,
 				   GFP_NOIO | __GFP_HIGHMEM |
@@ -1817,7 +1817,7 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 	}
 
 	if (!zram_can_store_page(zram)) {
-		zcomp_stream_put(zram->comps[ZRAM_PRIMARY_COMP]);
+		zcomp_stream_put(zstrm);
 		zs_free(zram->mem_pool, handle);
 		return -ENOMEM;
 	}
@@ -1825,7 +1825,7 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 	dst = zs_map_object(zram->mem_pool, handle, ZS_MM_WO);
 
 	memcpy(dst, zstrm->buffer, comp_len);
-	zcomp_stream_put(zram->comps[ZRAM_PRIMARY_COMP]);
+	zcomp_stream_put(zstrm);
 	zs_unmap_object(zram->mem_pool, handle);
 
 	zram_slot_lock(zram, index);
@@ -1984,7 +1984,7 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
 		kunmap_local(src);
 
 		if (ret) {
-			zcomp_stream_put(zram->comps[prio]);
+			zcomp_stream_put(zstrm);
 			return ret;
 		}
 
@@ -1994,7 +1994,7 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
 		/* Continue until we make progress */
 		if (class_index_new >= class_index_old ||
 		    (threshold && comp_len_new >= threshold)) {
-			zcomp_stream_put(zram->comps[prio]);
+			zcomp_stream_put(zstrm);
 			continue;
 		}
 
@@ -2052,13 +2052,13 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
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


