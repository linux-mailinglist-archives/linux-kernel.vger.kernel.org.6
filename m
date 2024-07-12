Return-Path: <linux-kernel+bounces-250182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D23392F4FD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 07:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFC241F221AF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 05:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB038135A46;
	Fri, 12 Jul 2024 05:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MtCUQDd7"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE6F132124
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 05:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720761576; cv=none; b=pueG+4CjbpNFAWu9D0lYheHZEm1JOhZjRdwaBdfxoL9kCwLPA7UlB5YP1mWMoEnTQ3EK1WdNC9x4dgcJQMPkhMxYstbTCAyHGQyz/NCHSV0Xpzxdzky6b8LHkEIlHGAfXqSM9IF9eizAqamnC9rmCc01EZO4nPVFSSHVVBn3qbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720761576; c=relaxed/simple;
	bh=Xv8EPg91mLUhONKGCZr7sxXoQy4HbqGbBF6KmbetfVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=igs+Et+8CY2OySGuWfHKG4hGBn6JRovb7mfd/K4C6eAHdk03A9zNGbilinULFaMLtaMF4Mk0j9LcslK1CINdd2s+fRT63Ab7NSnCq6DcL6tX0HozXf/4al5nELYZSx/qgUqaofO9w84F5yJY9dhfJGDqIhr9JjIGV76pnCp1N9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MtCUQDd7; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c9cc681ee4so832545b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 22:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720761574; x=1721366374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LDXfK8psyXJ9LKncZJ7w82uE+VH/goA9zo8xLW1jTSg=;
        b=MtCUQDd7NlfVgo0VF4Soi2b9b0cEI7taR7DTPhncre34Jy1ljicm5dotgJ1sinp0Q0
         vNWKtKxuIgA8RV8G59gG8yvbQq6ztQnKwuXoeLENy696yT62dv59SLBUu4qDRiOnsgY0
         rLII0vzhzslX2jkvVgYYg+CpaA02KuqjzeiQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720761574; x=1721366374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LDXfK8psyXJ9LKncZJ7w82uE+VH/goA9zo8xLW1jTSg=;
        b=Gap0rgYsHqWAJ31ZprnA5y9wj6gw2HduTIgPWBirOP7b/l4TFFriMpr8I8Vb2dujE7
         LZS2IOxCRu97T4WDXC5PhxgLYYPRwO6nTm+nQzealPpA4x0R7YPNcg6fO4XpGoRHcs4m
         Jw5jp3XdwKrRbepDGJ+f5GO8ie87cxXfPnrYH6AZ7NeYQ3rKUmM15zcEcwucM2j87Q68
         dhXK1hro59KzrFTVmzv8aQiVTNpyv5HBr2A4peJ8GJLUQqV8RrsWGIBCtsdx1QL771NJ
         MBbxn8Y13r9motd3VPN5nHbWNJRyhdfpHHPWgXRNyXjoAFN7ytjAYn+yH616t+2CZMCH
         6ehQ==
X-Gm-Message-State: AOJu0YzQEGBo7Xc++NDVbxNMwH/jnGZkVGOauEhdrIgvxcC2YQMcJvRV
	xNxZD7vx36ToM77K55wdxxB+5roKBpa6SsN5cH8IprSy2nICqSR+RPU1JouzsyU6coucYOPdqck
	ssq7W
X-Google-Smtp-Source: AGHT+IHETDTUY1T1KcyFxXc4l1LEEpXlCwG3oxxKFTye7it7Quq3iuzTSFV24aoxS7dgWEymih2rLw==
X-Received: by 2002:a05:6808:1241:b0:3d9:38ec:3d42 with SMTP id 5614622812f47-3d93c0a3acfmr12035218b6e.49.1720761574039;
        Thu, 11 Jul 2024 22:19:34 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:15f3:5252:ec56:52ae])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b43967851sm6553436b3a.109.2024.07.11.22.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 22:19:33 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v6 13/23] zram: introduce zcomp_params structure
Date: Fri, 12 Jul 2024 14:18:24 +0900
Message-ID: <20240712051850.484318-14-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
In-Reply-To: <20240712051850.484318-1-senozhatsky@chromium.org>
References: <20240712051850.484318-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We will store a per-algorithm parameters there (compression level,
dictionary, dictionary size, etc.).

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/backend_842.c     |  2 +-
 drivers/block/zram/backend_deflate.c |  9 ++++++---
 drivers/block/zram/backend_lz4.c     |  9 ++++++---
 drivers/block/zram/backend_lz4hc.c   |  9 ++++++---
 drivers/block/zram/backend_lzo.c     |  2 +-
 drivers/block/zram/backend_lzorle.c  |  2 +-
 drivers/block/zram/backend_zstd.c    | 18 +++++++++++-------
 drivers/block/zram/zcomp.c           |  5 +++--
 drivers/block/zram/zcomp.h           | 14 ++++++++++++--
 drivers/block/zram/zram_drv.c        | 20 +++++++++++++++++++-
 drivers/block/zram/zram_drv.h        |  1 +
 11 files changed, 67 insertions(+), 24 deletions(-)

diff --git a/drivers/block/zram/backend_842.c b/drivers/block/zram/backend_842.c
index 005f3fcb9024..e14dba30b0a2 100644
--- a/drivers/block/zram/backend_842.c
+++ b/drivers/block/zram/backend_842.c
@@ -19,7 +19,7 @@ static void destroy_842(void *ctx)
 	kfree(zctx);
 }
 
-static void *create_842(void)
+static void *create_842(struct zcomp_params *params)
 {
 	struct sw842_ctx *ctx;
 
diff --git a/drivers/block/zram/backend_deflate.c b/drivers/block/zram/backend_deflate.c
index acefb86701b9..ec662ce46897 100644
--- a/drivers/block/zram/backend_deflate.c
+++ b/drivers/block/zram/backend_deflate.c
@@ -32,7 +32,7 @@ static void deflate_destroy(void *ctx)
 	kfree(zctx);
 }
 
-static void *deflate_create(void)
+static void *deflate_create(struct zcomp_params *params)
 {
 	struct deflate_ctx *ctx;
 	size_t sz;
@@ -42,8 +42,11 @@ static void *deflate_create(void)
 	if (!ctx)
 		return NULL;
 
-	/* @FIXME: using a hardcoded Z_DEFAULT_COMPRESSION for now */
-	ctx->level = Z_DEFAULT_COMPRESSION;
+	if (params->level != ZCOMP_PARAM_NO_LEVEL)
+		ctx->level = params->level;
+	else
+		ctx->level = Z_DEFAULT_COMPRESSION;
+
 	sz = zlib_deflate_workspacesize(-DEFLATE_DEF_WINBITS, MAX_MEM_LEVEL);
 	ctx->cctx.workspace = vzalloc(sz);
 	if (!ctx->cctx.workspace)
diff --git a/drivers/block/zram/backend_lz4.c b/drivers/block/zram/backend_lz4.c
index c1d19fed5af2..ec57b5acbd39 100644
--- a/drivers/block/zram/backend_lz4.c
+++ b/drivers/block/zram/backend_lz4.c
@@ -18,7 +18,7 @@ static void lz4_destroy(void *ctx)
 	kfree(zctx);
 }
 
-static void *lz4_create(void)
+static void *lz4_create(struct zcomp_params *params)
 {
 	struct lz4_ctx *ctx;
 
@@ -26,8 +26,11 @@ static void *lz4_create(void)
 	if (!ctx)
 		return NULL;
 
-	/* @FIXME: using a hardcoded LZ4_ACCELERATION_DEFAULT for now */
-	ctx->level = LZ4_ACCELERATION_DEFAULT;
+	if (params->level != ZCOMP_PARAM_NO_LEVEL)
+		ctx->level = params->level;
+	else
+		ctx->level = LZ4_ACCELERATION_DEFAULT;
+
 	ctx->mem = vmalloc(LZ4_MEM_COMPRESS);
 	if (!ctx->mem)
 		goto error;
diff --git a/drivers/block/zram/backend_lz4hc.c b/drivers/block/zram/backend_lz4hc.c
index 536f7a0073c4..80733fead595 100644
--- a/drivers/block/zram/backend_lz4hc.c
+++ b/drivers/block/zram/backend_lz4hc.c
@@ -18,7 +18,7 @@ static void lz4hc_destroy(void *ctx)
 	kfree(zctx);
 }
 
-static void *lz4hc_create(void)
+static void *lz4hc_create(struct zcomp_params *params)
 {
 	struct lz4hc_ctx *ctx;
 
@@ -26,8 +26,11 @@ static void *lz4hc_create(void)
 	if (!ctx)
 		return NULL;
 
-	/* @FIXME: using a hardcoded LZ4HC_DEFAULT_CLEVEL for now */
-	ctx->level = LZ4HC_DEFAULT_CLEVEL;
+	if (params->level != ZCOMP_PARAM_NO_LEVEL)
+		ctx->level = params->level;
+	else
+		ctx->level = LZ4HC_DEFAULT_CLEVEL;
+
 	ctx->mem = vmalloc(LZ4HC_MEM_COMPRESS);
 	if (!ctx->mem)
 		goto error;
diff --git a/drivers/block/zram/backend_lzo.c b/drivers/block/zram/backend_lzo.c
index 4c9e611f6c03..8e4aabd04bf3 100644
--- a/drivers/block/zram/backend_lzo.c
+++ b/drivers/block/zram/backend_lzo.c
@@ -6,7 +6,7 @@
 
 #include "backend_lzo.h"
 
-static void *lzo_create(void)
+static void *lzo_create(struct zcomp_params *params)
 {
 	return kzalloc(LZO1X_MEM_COMPRESS, GFP_KERNEL);
 }
diff --git a/drivers/block/zram/backend_lzorle.c b/drivers/block/zram/backend_lzorle.c
index 19a9ce132046..cb01eb8b04f4 100644
--- a/drivers/block/zram/backend_lzorle.c
+++ b/drivers/block/zram/backend_lzorle.c
@@ -6,7 +6,7 @@
 
 #include "backend_lzorle.h"
 
-static void *lzorle_create(void)
+static void *lzorle_create(struct zcomp_params *params)
 {
 	return kzalloc(LZO1X_MEM_COMPRESS, GFP_KERNEL);
 }
diff --git a/drivers/block/zram/backend_zstd.c b/drivers/block/zram/backend_zstd.c
index 310d970078e2..c356c5e6e503 100644
--- a/drivers/block/zram/backend_zstd.c
+++ b/drivers/block/zram/backend_zstd.c
@@ -24,9 +24,9 @@ static void zstd_destroy(void *ctx)
 	kfree(zctx);
 }
 
-static void *zstd_create(void)
+static void *zstd_create(struct zcomp_params *params)
 {
-	zstd_parameters params;
+	zstd_parameters prm;
 	struct zstd_ctx *ctx;
 	size_t sz;
 
@@ -34,9 +34,13 @@ static void *zstd_create(void)
 	if (!ctx)
 		return NULL;
 
-	ctx->level = zstd_default_clevel();
-	params = zstd_get_params(ctx->level, PAGE_SIZE);
-	sz = zstd_cctx_workspace_bound(&params.cParams);
+	if (params->level != ZCOMP_PARAM_NO_LEVEL)
+		ctx->level = params->level;
+	else
+		ctx->level = zstd_default_clevel();
+
+	prm = zstd_get_params(ctx->level, PAGE_SIZE);
+	sz = zstd_cctx_workspace_bound(&prm.cParams);
 	ctx->cctx_mem = vzalloc(sz);
 	if (!ctx->cctx_mem)
 		goto error;
@@ -65,11 +69,11 @@ static int zstd_compress(void *ctx, const unsigned char *src, size_t src_len,
 			 unsigned char *dst, size_t *dst_len)
 {
 	struct zstd_ctx *zctx = ctx;
-	const zstd_parameters params = zstd_get_params(zctx->level, PAGE_SIZE);
+	const zstd_parameters prm = zstd_get_params(zctx->level, PAGE_SIZE);
 	size_t ret;
 
 	ret = zstd_compress_cctx(zctx->cctx, dst, *dst_len,
-				 src, src_len, &params);
+				 src, src_len, &prm);
 	if (zstd_is_error(ret))
 		return -EINVAL;
 	*dst_len = ret;
diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index cb7afbd4d8fe..08c51f33b5d9 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -54,7 +54,7 @@ static void zcomp_strm_free(struct zcomp *comp, struct zcomp_strm *zstrm)
 
 static int zcomp_strm_init(struct zcomp *comp, struct zcomp_strm *zstrm)
 {
-	zstrm->ctx = comp->ops->create_ctx();
+	zstrm->ctx = comp->ops->create_ctx(comp->params);
 
 	/*
 	 * allocate 2 pages. 1 for compressed data, plus 1 extra for the
@@ -186,7 +186,7 @@ void zcomp_destroy(struct zcomp *comp)
 	kfree(comp);
 }
 
-struct zcomp *zcomp_create(const char *alg)
+struct zcomp *zcomp_create(const char *alg, struct zcomp_params *params)
 {
 	struct zcomp *comp;
 	int error;
@@ -203,6 +203,7 @@ struct zcomp *zcomp_create(const char *alg)
 	if (!comp)
 		return ERR_PTR(-ENOMEM);
 
+	comp->params = params;
 	comp->ops = lookup_backend_ops(alg);
 	if (!comp->ops) {
 		kfree(comp);
diff --git a/drivers/block/zram/zcomp.h b/drivers/block/zram/zcomp.h
index e5eb5ec4c645..217a750fa908 100644
--- a/drivers/block/zram/zcomp.h
+++ b/drivers/block/zram/zcomp.h
@@ -2,8 +2,17 @@
 
 #ifndef _ZCOMP_H_
 #define _ZCOMP_H_
+
 #include <linux/local_lock.h>
 
+#define ZCOMP_PARAM_NO_LEVEL	INT_MIN
+
+struct zcomp_params {
+	void *dict;
+	size_t dict_sz;
+	s32 level;
+};
+
 struct zcomp_strm {
 	/* The members ->buffer and ->tfm are protected by ->lock. */
 	local_lock_t lock;
@@ -19,7 +28,7 @@ struct zcomp_ops {
 	int (*decompress)(void *ctx, const unsigned char *src, size_t src_len,
 			  unsigned char *dst, size_t dst_len);
 
-	void *(*create_ctx)(void);
+	void *(*create_ctx)(struct zcomp_params *params);
 	void (*destroy_ctx)(void *ctx);
 
 	const char *name;
@@ -29,6 +38,7 @@ struct zcomp_ops {
 struct zcomp {
 	struct zcomp_strm __percpu *stream;
 	const struct zcomp_ops *ops;
+	struct zcomp_params *params;
 	struct hlist_node node;
 };
 
@@ -37,7 +47,7 @@ int zcomp_cpu_dead(unsigned int cpu, struct hlist_node *node);
 ssize_t zcomp_available_show(const char *comp, char *buf);
 bool zcomp_available_algorithm(const char *comp);
 
-struct zcomp *zcomp_create(const char *alg);
+struct zcomp *zcomp_create(const char *alg, struct zcomp_params *params);
 void zcomp_destroy(struct zcomp *comp);
 
 struct zcomp_strm *zcomp_stream_get(struct zcomp *comp);
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 93042da8ccdf..84757f0c8166 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1979,6 +1979,20 @@ static void zram_slot_free_notify(struct block_device *bdev,
 	zram_slot_unlock(zram, index);
 }
 
+static void zram_reset_comp_params(struct zram *zram)
+{
+	u32 prio;
+
+	for (prio = 0; prio < ZRAM_MAX_COMPS; prio++) {
+		struct zcomp_params *params = &zram->params[prio];
+
+		vfree(params->dict);
+		params->level = ZCOMP_PARAM_NO_LEVEL;
+		params->dict_sz = 0;
+		params->dict = NULL;
+	}
+}
+
 static void zram_destroy_comps(struct zram *zram)
 {
 	u32 prio;
@@ -1992,6 +2006,8 @@ static void zram_destroy_comps(struct zram *zram)
 		zcomp_destroy(comp);
 		zram->num_active_comps--;
 	}
+
+	zram_reset_comp_params(zram);
 }
 
 static void zram_reset_device(struct zram *zram)
@@ -2049,7 +2065,8 @@ static ssize_t disksize_store(struct device *dev,
 		if (!zram->comp_algs[prio])
 			continue;
 
-		comp = zcomp_create(zram->comp_algs[prio]);
+		comp = zcomp_create(zram->comp_algs[prio],
+				    &zram->params[prio]);
 		if (IS_ERR(comp)) {
 			pr_err("Cannot initialise %s compressing backend\n",
 			       zram->comp_algs[prio]);
@@ -2254,6 +2271,7 @@ static int zram_add(void)
 	if (ret)
 		goto out_cleanup_disk;
 
+	zram_reset_comp_params(zram);
 	comp_algorithm_set(zram, ZRAM_PRIMARY_COMP, default_compressor);
 
 	zram_debugfs_register(zram);
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 35e322144629..b976824ead67 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -107,6 +107,7 @@ struct zram {
 	struct zram_table_entry *table;
 	struct zs_pool *mem_pool;
 	struct zcomp *comps[ZRAM_MAX_COMPS];
+	struct zcomp_params params[ZRAM_MAX_COMPS];
 	struct gendisk *disk;
 	/* Prevent concurrent execution of device init */
 	struct rw_semaphore init_lock;
-- 
2.45.2.993.g49e7a77208-goog


