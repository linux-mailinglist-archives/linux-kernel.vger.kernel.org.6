Return-Path: <linux-kernel+bounces-243049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9905F9290F7
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 07:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC3061C228B9
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 05:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14A173459;
	Sat,  6 Jul 2024 04:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cFLMhCle"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E006A8CF
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 04:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720241840; cv=none; b=qYaxZ6aT/m+BgB+K1tyLmN4LPU1r2BSNoOzxQ3jlWm/EZDtjKtCgUKUCdQhT1aYzpz0MeUIbjQyfTA0wjjPUznqlgh0vC9AzqPeUIj+qfZcZr5WiL701eJmePMGLvhxa8jv6Cq6QFv6K7cr/3TkpyTWMB49XQbRe4a7UEyL4vwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720241840; c=relaxed/simple;
	bh=qPGhEszM28BJLoKcCSLWKB23lcWXg6Neo843Mmco+Os=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pOnEJlwn59e4yUDVrUnZYXPt24OMXAW8ktfCpZ1a09c5X7WjbUhSSFASWmeVe6+SWKKZ9ignsikr92yb9IsHvpUwHRV5VabJDpntVLaalcxCNwVLwh1J22E97ARf4aoFOnOaTGEWNDCbrUtvl/XR7GVqW99fM1tMMGfSTxoJN9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cFLMhCle; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-711b1512aeaso1601298a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 21:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720241838; x=1720846638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i8KId/ekURjvlg3m7DNVdUGG5jUGkcV1cBRZ5vD9Kng=;
        b=cFLMhCleC7tmZHFepgos8SCynrG2+bjTyxASrDW9pRexzrx4IrmL5Gj8tCrViuv/ov
         AVmHXP4nIITebhVGpBNs+rx7PGlsazB6XojqlwsUCu+nioZyLDYzNwpxk7RUYkYgip7S
         s3q3awX0texuPp/Ntmpv8nN5+WydcgphXVTNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720241838; x=1720846638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i8KId/ekURjvlg3m7DNVdUGG5jUGkcV1cBRZ5vD9Kng=;
        b=v7War90q1uOMyoidI+KZ20oPkFYkeBTS5OhLcltBbn4G7VYDJTsIUBKGN1hllwh53d
         9k+dPShxAl9dFwwpC8plMEG7YzdYo6yuphfl7lNqUw/mTdlDoe7dSmeZh6s69yaS6PT+
         I+G0itbLW5OUI4YsQIaiV9wG9C77PZgL0uYfglLAvxk0eoLOb/9OLUHN9pneUtZQYG7F
         khXilVDlXdfazRvpDZ6dwZUhPMZG8tNFwr+rg7q/dvaapl4OI5ko1KF9C67iD5mtiPPH
         OPTSGnqQkI+CXGsV6TDvUXULRJPnpoVSHV5xFb8Z9Kaa/PBAJ6oFIK9ARRH8p/ZC2dZ8
         qapA==
X-Gm-Message-State: AOJu0Yz5XUeR1P7yTt9urGDEE3Hmja42NwkbGk1A+cnAnZwxQRZg1Nrz
	t8ne+PaTyUBd/SCLE06HXKdXUlMNBNRaStC/sjjfymXE2hWbLhQ5SAFoYiQ6mw==
X-Google-Smtp-Source: AGHT+IHyASufqypx3vgwC2irdSmUwnqaCjV4vRKv0d9Qnf9PygUHQcAJFRSH+r3pnuyYjtihLEFIAg==
X-Received: by 2002:a05:6a20:7490:b0:1be:e53c:7fa2 with SMTP id adf61e73a8af0-1c0cc7422c8mr8040828637.25.1720241838489;
        Fri, 05 Jul 2024 21:57:18 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:88a7:e7d7:713d:ff09])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7623cd854b2sm2784104a12.38.2024.07.05.21.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 21:57:18 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv5 13/23] zram: introduce zcomp_params structure
Date: Sat,  6 Jul 2024 13:56:15 +0900
Message-ID: <20240706045641.631961-14-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
In-Reply-To: <20240706045641.631961-1-senozhatsky@chromium.org>
References: <20240706045641.631961-1-senozhatsky@chromium.org>
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
index 83802d6c0e7d..9193391626a9 100644
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
index 489694b0d5d9..415ab55f8aeb 100644
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
index 4de389fb3463..90801a7a8f75 100644
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
index 50e998c1e321..30de6ec511a5 100644
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
index 7eb0d2709a73..c903c15610f8 100644
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
index 68fcdccb2f53..3622625abfd9 100644
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
index e70e6dd2b4d6..2328a462b82c 100644
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
index 1888d4dd9245..eacead28cc2b 100644
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
index dde28a8d32d4..3639c36fb9a9 100644
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
 	struct zcomp_ops *ops;
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
2.45.2.803.g4e1b14247a-goog


