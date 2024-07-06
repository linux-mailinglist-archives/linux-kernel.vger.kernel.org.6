Return-Path: <linux-kernel+bounces-243055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 920B09290FD
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 07:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B63AE1C223EA
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 05:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2FF175AE;
	Sat,  6 Jul 2024 04:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZP1pqyMm"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AE817C7F
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 04:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720241855; cv=none; b=OaOYyibHJskgJA9pbUMzAXDIx2ToT9Yi3UD/wnXJIXYsnhN9PWvx9IVenWz7kgZu2cdz6yK1Gml5Syz0ZZdK/pUGBL1wQDVysRUBkO+I9srveRRhi1GHeDnG7gBfZWSHEqqZNL2qpWRhK0j57BcxZKgrxJIQHs7olIJV9Mkq++Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720241855; c=relaxed/simple;
	bh=k7w1+5N2rsBL54BaeAsGWfRszkguHX37S1FmVPkVOEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aEw6HHntKtxC1xdAWuH5D/BThFctonuObNEx5h+X2p5QGzcdszJPXc5S+VKdjHxO48dwri39OU0dbCXsne13Uh61TDuyQ/Qd7jB/OJaWseVoqjOA6gU7xdjmIXjXADtUaPJzvv+NwrXQXwXWz+NfiMHkbAvJ9llOLWNOzaLm564=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZP1pqyMm; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3d922948744so392488b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 21:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720241852; x=1720846652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T77OHceeCySQ70uxoXgvVB0usA+RwOLDNqt5l9mbVQI=;
        b=ZP1pqyMmfPt0aOh57tvw5XdBnDRgg+YEA+Kj/nvq4Glo5XGydrfogLkiCNkA8neRWW
         t6xF0lZ2uaEGR6bmB6MPcp0G1F9wjzkCMMTOonZjhKhOVojJhYeDKb4FgeJAKfEJYd8i
         2B5JxnrVdc5bGdm5TybQwXs9f4JAyU2Rtw5ho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720241852; x=1720846652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T77OHceeCySQ70uxoXgvVB0usA+RwOLDNqt5l9mbVQI=;
        b=SfIv6spXx1OBnOx5mQlnFHlhRaoO4ANwxv/4wDnH7fl60C+5XC9JJRDLTeh7FeOEi9
         B9fUBaJ0kHZq4/nwYc9yqMSe+1jChLHjO6WT36kRvOHzxZzdVsgVN9Hf/PO63U88Jt6a
         lMuoDSN3DXHG9MUSwcFr9+CAKLj1QhHWX3jtWKJCuSafd/uC/LiQDESylpTMXnKh4oNp
         lQS+MiHc45jO2tH6TpEoKjP2MpZuytItkJRUJf1ImP144ZwOpUGHHtwd/3XIbYB8g9sb
         +abOKR447wz3Z4zrwkdT+fVr6huyCGR+BkZekHUQQ94noxwZmNaVvBY1w2smu5UNyDKP
         yb9Q==
X-Gm-Message-State: AOJu0YxCFQ7Ai7NsBdBhi87tGo0nMOQYcY5tbzXfZrt73eME+9uC09Nx
	81WvlX1JOpT8eJYtXrlJK/0qBqXDVSwpQ+BxE4zTaXP6IurSfkrI0FTlZ97b7g==
X-Google-Smtp-Source: AGHT+IEul8IDa7fiVoOQdU5pljAo263SwTyiPRORDwxK2KwqisAbmnaMsbog+fqDlIeqTEKKnLqMUA==
X-Received: by 2002:a05:6808:1a2a:b0:3d5:6166:c047 with SMTP id 5614622812f47-3d914c652f5mr8715001b6e.26.1720241851900;
        Fri, 05 Jul 2024 21:57:31 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:88a7:e7d7:713d:ff09])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7623cd854b2sm2784104a12.38.2024.07.05.21.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 21:57:31 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv5 19/23] zram: move immutable comp params away from per-CPU context
Date: Sat,  6 Jul 2024 13:56:21 +0900
Message-ID: <20240706045641.631961-20-senozhatsky@chromium.org>
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

Immutable params never change once comp has been allocated
and setup, so we don't need to store multiple copies of
them in each per-CPU backend context.  Move those to
per-comp zcomp_params and pass it to backends callbacks
for requests execution.  Basically, this means parameters
sharing between different contexts.

Also introduce two new backends callbacks: setup_params()
and release_params().  First, we need to validate params
in a driver-specific way; second, driver may want to
allocate its specific representation of the params which
is needed to execute requests.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/backend_842.c     | 17 ++++++++--
 drivers/block/zram/backend_deflate.c | 29 +++++++++++-----
 drivers/block/zram/backend_lz4.c     | 51 +++++++++++-----------------
 drivers/block/zram/backend_lz4hc.c   | 51 +++++++++++-----------------
 drivers/block/zram/backend_lzo.c     | 17 ++++++++--
 drivers/block/zram/backend_lzorle.c  | 17 ++++++++--
 drivers/block/zram/backend_zstd.c    | 47 ++++++++++++++++++-------
 drivers/block/zram/zcomp.c           | 17 +++++++---
 drivers/block/zram/zcomp.h           | 20 ++++++++---
 9 files changed, 168 insertions(+), 98 deletions(-)

diff --git a/drivers/block/zram/backend_842.c b/drivers/block/zram/backend_842.c
index 8364837d300d..8722cdfff411 100644
--- a/drivers/block/zram/backend_842.c
+++ b/drivers/block/zram/backend_842.c
@@ -7,6 +7,15 @@
 
 #include "backend_842.h"
 
+static void release_params_842(struct zcomp_params *params)
+{
+}
+
+static int setup_params_842(struct zcomp_params *params)
+{
+	return 0;
+}
+
 static void destroy_842(struct zcomp_ctx *ctx)
 {
 	kfree(ctx->context);
@@ -20,7 +29,8 @@ static int create_842(struct zcomp_params *params, struct zcomp_ctx *ctx)
 	return 0;
 }
 
-static int compress_842(struct zcomp_ctx *ctx, struct zcomp_req *req)
+static int compress_842(struct zcomp_params *params, struct zcomp_ctx *ctx,
+			struct zcomp_req *req)
 {
 	unsigned int dlen = req->dst_len;
 	int ret;
@@ -32,7 +42,8 @@ static int compress_842(struct zcomp_ctx *ctx, struct zcomp_req *req)
 	return ret;
 }
 
-static int decompress_842(struct zcomp_ctx *ctx, struct zcomp_req *req)
+static int decompress_842(struct zcomp_params *params, struct zcomp_ctx *ctx,
+			  struct zcomp_req *req)
 {
 	unsigned int dlen = req->dst_len;
 
@@ -44,5 +55,7 @@ struct zcomp_ops backend_842 = {
 	.decompress	= decompress_842,
 	.create_ctx	= create_842,
 	.destroy_ctx	= destroy_842,
+	.setup_params	= setup_params_842,
+	.release_params	= release_params_842,
 	.name		= "842",
 };
diff --git a/drivers/block/zram/backend_deflate.c b/drivers/block/zram/backend_deflate.c
index 63a29c26d64c..7882b6fe0d7c 100644
--- a/drivers/block/zram/backend_deflate.c
+++ b/drivers/block/zram/backend_deflate.c
@@ -14,9 +14,20 @@
 struct deflate_ctx {
 	struct z_stream_s cctx;
 	struct z_stream_s dctx;
-	s32 level;
 };
 
+static void deflate_release_params(struct zcomp_params *params)
+{
+}
+
+static int deflate_setup_params(struct zcomp_params *params)
+{
+	if (params->level == ZCOMP_PARAM_NO_LEVEL)
+		params->level = Z_DEFAULT_COMPRESSION;
+
+	return 0;
+}
+
 static void deflate_destroy(struct zcomp_ctx *ctx)
 {
 	struct deflate_ctx *zctx = ctx->context;
@@ -46,17 +57,12 @@ static int deflate_create(struct zcomp_params *params, struct zcomp_ctx *ctx)
 		return -ENOMEM;
 
 	ctx->context = zctx;
-	if (params->level != ZCOMP_PARAM_NO_LEVEL)
-		zctx->level = params->level;
-	else
-		zctx->level = Z_DEFAULT_COMPRESSION;
-
 	sz = zlib_deflate_workspacesize(-DEFLATE_DEF_WINBITS, MAX_MEM_LEVEL);
 	zctx->cctx.workspace = vzalloc(sz);
 	if (!zctx->cctx.workspace)
 		goto error;
 
-	ret = zlib_deflateInit2(&zctx->cctx, zctx->level, Z_DEFLATED,
+	ret = zlib_deflateInit2(&zctx->cctx, params->level, Z_DEFLATED,
 				-DEFLATE_DEF_WINBITS, DEFLATE_DEF_MEMLEVEL,
 				Z_DEFAULT_STRATEGY);
 	if (ret != Z_OK)
@@ -78,7 +84,8 @@ static int deflate_create(struct zcomp_params *params, struct zcomp_ctx *ctx)
 	return -EINVAL;
 }
 
-static int deflate_compress(struct zcomp_ctx *ctx, struct zcomp_req *req)
+static int deflate_compress(struct zcomp_params *params, struct zcomp_ctx *ctx,
+			    struct zcomp_req *req)
 {
 	struct deflate_ctx *zctx = ctx->context;
 	struct z_stream_s *deflate;
@@ -102,7 +109,9 @@ static int deflate_compress(struct zcomp_ctx *ctx, struct zcomp_req *req)
 	return 0;
 }
 
-static int deflate_decompress(struct zcomp_ctx *ctx, struct zcomp_req *req)
+static int deflate_decompress(struct zcomp_params *params,
+			      struct zcomp_ctx *ctx,
+			      struct zcomp_req *req)
 {
 	struct deflate_ctx *zctx = ctx->context;
 	struct z_stream_s *inflate;
@@ -131,5 +140,7 @@ struct zcomp_ops backend_deflate = {
 	.decompress	= deflate_decompress,
 	.create_ctx	= deflate_create,
 	.destroy_ctx	= deflate_destroy,
+	.setup_params	= deflate_setup_params,
+	.release_params	= deflate_release_params,
 	.name		= "deflate",
 };
diff --git a/drivers/block/zram/backend_lz4.c b/drivers/block/zram/backend_lz4.c
index 1ff6b1a6b5ae..cdcf6e3c1826 100644
--- a/drivers/block/zram/backend_lz4.c
+++ b/drivers/block/zram/backend_lz4.c
@@ -5,60 +5,47 @@
 
 #include "backend_lz4.h"
 
-struct lz4_ctx {
-	void *mem;
-	s32 level;
-};
+static void lz4_release_params(struct zcomp_params *params)
+{
+}
 
-static void lz4_destroy(struct zcomp_ctx *ctx)
+static int lz4_setup_params(struct zcomp_params *params)
 {
-	struct lz4_ctx *zctx = ctx->context;
+	if (params->level == ZCOMP_PARAM_NO_LEVEL)
+		params->level = LZ4_ACCELERATION_DEFAULT;
 
-	if (!zctx)
-		return;
+	return 0;
+}
 
-	vfree(zctx->mem);
-	kfree(zctx);
+static void lz4_destroy(struct zcomp_ctx *ctx)
+{
+	vfree(ctx->context);
 }
 
 static int lz4_create(struct zcomp_params *params, struct zcomp_ctx *ctx)
 {
-	struct lz4_ctx *zctx;
-
-	zctx = kzalloc(sizeof(*zctx), GFP_KERNEL);
-	if (!zctx)
+	ctx->context = vmalloc(LZ4_MEM_COMPRESS);
+	if (!ctx->context)
 		return -ENOMEM;
 
-	ctx->context = zctx;
-	if (params->level != ZCOMP_PARAM_NO_LEVEL)
-		zctx->level = params->level;
-	else
-		zctx->level = LZ4_ACCELERATION_DEFAULT;
-
-	zctx->mem = vmalloc(LZ4_MEM_COMPRESS);
-	if (!zctx->mem)
-		goto error;
-
 	return 0;
-error:
-	lz4_destroy(ctx);
-	return -EINVAL;
 }
 
-static int lz4_compress(struct zcomp_ctx *ctx, struct zcomp_req *req)
+static int lz4_compress(struct zcomp_params *params, struct zcomp_ctx *ctx,
+			struct zcomp_req *req)
 {
-	struct lz4_ctx *zctx = ctx->context;
 	int ret;
 
 	ret = LZ4_compress_fast(req->src, req->dst, req->src_len,
-				req->dst_len, zctx->level, zctx->mem);
+				req->dst_len, params->level, ctx->context);
 	if (!ret)
 		return -EINVAL;
 	req->dst_len = ret;
 	return 0;
 }
 
-static int lz4_decompress(struct zcomp_ctx *ctx, struct zcomp_req *req)
+static int lz4_decompress(struct zcomp_params *params, struct zcomp_ctx *ctx,
+			  struct zcomp_req *req)
 {
 	int ret;
 
@@ -74,5 +61,7 @@ struct zcomp_ops backend_lz4 = {
 	.decompress	= lz4_decompress,
 	.create_ctx	= lz4_create,
 	.destroy_ctx	= lz4_destroy,
+	.setup_params	= lz4_setup_params,
+	.release_params	= lz4_release_params,
 	.name		= "lz4",
 };
diff --git a/drivers/block/zram/backend_lz4hc.c b/drivers/block/zram/backend_lz4hc.c
index 0daab12836de..e7dc0e03f13c 100644
--- a/drivers/block/zram/backend_lz4hc.c
+++ b/drivers/block/zram/backend_lz4hc.c
@@ -5,60 +5,47 @@
 
 #include "backend_lz4hc.h"
 
-struct lz4hc_ctx {
-	void *mem;
-	s32 level;
-};
+static void lz4hc_release_params(struct zcomp_params *params)
+{
+}
 
-static void lz4hc_destroy(struct zcomp_ctx *ctx)
+static int lz4hc_setup_params(struct zcomp_params *params)
 {
-	struct lz4hc_ctx *zctx = ctx->context;
+	if (params->level == ZCOMP_PARAM_NO_LEVEL)
+		params->level = LZ4HC_DEFAULT_CLEVEL;
 
-	if (!zctx)
-		return;
+	return 0;
+}
 
-	vfree(zctx->mem);
-	kfree(zctx);
+static void lz4hc_destroy(struct zcomp_ctx *ctx)
+{
+	vfree(ctx->context);
 }
 
 static int lz4hc_create(struct zcomp_params *params, struct zcomp_ctx *ctx)
 {
-	struct lz4hc_ctx *zctx;
-
-	zctx = kzalloc(sizeof(*zctx), GFP_KERNEL);
-	if (!zctx)
+	ctx->context = vmalloc(LZ4HC_MEM_COMPRESS);
+	if (!ctx->context)
 		return -ENOMEM;
 
-	ctx->context = zctx;
-	if (params->level != ZCOMP_PARAM_NO_LEVEL)
-		zctx->level = params->level;
-	else
-		zctx->level = LZ4HC_DEFAULT_CLEVEL;
-
-	zctx->mem = vmalloc(LZ4HC_MEM_COMPRESS);
-	if (!zctx->mem)
-		goto error;
-
 	return 0;
-error:
-	lz4hc_destroy(ctx);
-	return -EINVAL;
 }
 
-static int lz4hc_compress(struct zcomp_ctx *ctx, struct zcomp_req *req)
+static int lz4hc_compress(struct zcomp_params *params, struct zcomp_ctx *ctx,
+			  struct zcomp_req *req)
 {
-	struct lz4hc_ctx *zctx = ctx->context;
 	int ret;
 
 	ret = LZ4_compress_HC(req->src, req->dst, req->src_len, req->dst_len,
-			      zctx->level, zctx->mem);
+			      params->level, ctx->context);
 	if (!ret)
 		return -EINVAL;
 	req->dst_len = ret;
 	return 0;
 }
 
-static int lz4hc_decompress(struct zcomp_ctx *ctx, struct zcomp_req *req)
+static int lz4hc_decompress(struct zcomp_params *params, struct zcomp_ctx *ctx,
+			    struct zcomp_req *req)
 {
 	int ret;
 
@@ -74,5 +61,7 @@ struct zcomp_ops backend_lz4hc = {
 	.decompress	= lz4hc_decompress,
 	.create_ctx	= lz4hc_create,
 	.destroy_ctx	= lz4hc_destroy,
+	.setup_params	= lz4hc_setup_params,
+	.release_params	= lz4hc_release_params,
 	.name		= "lz4hc",
 };
diff --git a/drivers/block/zram/backend_lzo.c b/drivers/block/zram/backend_lzo.c
index 699e8ef147a8..76a2e47c4665 100644
--- a/drivers/block/zram/backend_lzo.c
+++ b/drivers/block/zram/backend_lzo.c
@@ -6,6 +6,15 @@
 
 #include "backend_lzo.h"
 
+static void lzo_release_params(struct zcomp_params *params)
+{
+}
+
+static int lzo_setup_params(struct zcomp_params *params)
+{
+	return 0;
+}
+
 static int lzo_create(struct zcomp_params *params, struct zcomp_ctx *ctx)
 {
 	ctx->context = kzalloc(LZO1X_MEM_COMPRESS, GFP_KERNEL);
@@ -19,7 +28,8 @@ static void lzo_destroy(struct zcomp_ctx *ctx)
 	kfree(ctx->context);
 }
 
-static int lzo_compress(struct zcomp_ctx *ctx, struct zcomp_req *req)
+static int lzo_compress(struct zcomp_params *params, struct zcomp_ctx *ctx,
+			struct zcomp_req *req)
 {
 	int ret;
 
@@ -28,7 +38,8 @@ static int lzo_compress(struct zcomp_ctx *ctx, struct zcomp_req *req)
 	return ret == LZO_E_OK ? 0 : ret;
 }
 
-static int lzo_decompress(struct zcomp_ctx *ctx, struct zcomp_req *req)
+static int lzo_decompress(struct zcomp_params *params, struct zcomp_ctx *ctx,
+			  struct zcomp_req *req)
 {
 	int ret;
 
@@ -42,5 +53,7 @@ struct zcomp_ops backend_lzo = {
 	.decompress	= lzo_decompress,
 	.create_ctx	= lzo_create,
 	.destroy_ctx	= lzo_destroy,
+	.setup_params	= lzo_setup_params,
+	.release_params	= lzo_release_params,
 	.name		= "lzo",
 };
diff --git a/drivers/block/zram/backend_lzorle.c b/drivers/block/zram/backend_lzorle.c
index 48e4d4dc8437..b1cfab65cb8e 100644
--- a/drivers/block/zram/backend_lzorle.c
+++ b/drivers/block/zram/backend_lzorle.c
@@ -6,6 +6,15 @@
 
 #include "backend_lzorle.h"
 
+static void lzorle_release_params(struct zcomp_params *params)
+{
+}
+
+static int lzorle_setup_params(struct zcomp_params *params)
+{
+	return 0;
+}
+
 static int lzorle_create(struct zcomp_params *params, struct zcomp_ctx *ctx)
 {
 	ctx->context = kzalloc(LZO1X_MEM_COMPRESS, GFP_KERNEL);
@@ -19,7 +28,8 @@ static void lzorle_destroy(struct zcomp_ctx *ctx)
 	kfree(ctx->context);
 }
 
-static int lzorle_compress(struct zcomp_ctx *ctx, struct zcomp_req *req)
+static int lzorle_compress(struct zcomp_params *params, struct zcomp_ctx *ctx,
+			   struct zcomp_req *req)
 {
 	int ret;
 
@@ -28,7 +38,8 @@ static int lzorle_compress(struct zcomp_ctx *ctx, struct zcomp_req *req)
 	return ret == LZO_E_OK ? 0 : ret;
 }
 
-static int lzorle_decompress(struct zcomp_ctx *ctx, struct zcomp_req *req)
+static int lzorle_decompress(struct zcomp_params *params, struct zcomp_ctx *ctx,
+			     struct zcomp_req *req)
 {
 	int ret;
 
@@ -42,5 +53,7 @@ struct zcomp_ops backend_lzorle = {
 	.decompress	= lzorle_decompress,
 	.create_ctx	= lzorle_create,
 	.destroy_ctx	= lzorle_destroy,
+	.setup_params	= lzorle_setup_params,
+	.release_params	= lzorle_release_params,
 	.name		= "lzo-rle",
 };
diff --git a/drivers/block/zram/backend_zstd.c b/drivers/block/zram/backend_zstd.c
index 1cc3a4a1f265..3c8ba3232881 100644
--- a/drivers/block/zram/backend_zstd.c
+++ b/drivers/block/zram/backend_zstd.c
@@ -10,12 +10,36 @@
 struct zstd_ctx {
 	zstd_cctx *cctx;
 	zstd_dctx *dctx;
-	zstd_parameters cprm;
 	void *cctx_mem;
 	void *dctx_mem;
-	s32 level;
 };
 
+struct zstd_params {
+	zstd_parameters cprm;
+};
+
+static void zstd_release_params(struct zcomp_params *params)
+{
+	kfree(params->drv_data);
+}
+
+static int zstd_setup_params(struct zcomp_params *params)
+{
+	struct zstd_params *zp;
+
+	zp = kzalloc(sizeof(*zp), GFP_KERNEL);
+	if (!zp)
+		return -ENOMEM;
+
+	if (params->level == ZCOMP_PARAM_NO_LEVEL)
+		params->level = zstd_default_clevel();
+
+	zp->cprm = zstd_get_params(params->level, PAGE_SIZE);
+	params->drv_data = zp;
+
+	return 0;
+}
+
 static void zstd_destroy(struct zcomp_ctx *ctx)
 {
 	struct zstd_ctx *zctx = ctx->context;
@@ -39,13 +63,7 @@ static int zstd_create(struct zcomp_params *params, struct zcomp_ctx *ctx)
 		return -ENOMEM;
 
 	ctx->context = zctx;
-	if (params->level != ZCOMP_PARAM_NO_LEVEL)
-		zctx->level = params->level;
-	else
-		zctx->level = zstd_default_clevel();
-
-	prm = zstd_get_params(zctx->level, PAGE_SIZE);
-	zctx->cprm = zstd_get_params(zctx->level, PAGE_SIZE);
+	prm = zstd_get_params(params->level, PAGE_SIZE);
 	sz = zstd_cctx_workspace_bound(&prm.cParams);
 	zctx->cctx_mem = vzalloc(sz);
 	if (!zctx->cctx_mem)
@@ -71,20 +89,23 @@ static int zstd_create(struct zcomp_params *params, struct zcomp_ctx *ctx)
 	return -EINVAL;
 }
 
-static int zstd_compress(struct zcomp_ctx *ctx, struct zcomp_req *req)
+static int zstd_compress(struct zcomp_params *params, struct zcomp_ctx *ctx,
+			 struct zcomp_req *req)
 {
+	struct zstd_params *zp = params->drv_data;
 	struct zstd_ctx *zctx = ctx->context;
 	size_t ret;
 
 	ret = zstd_compress_cctx(zctx->cctx, req->dst, req->dst_len,
-				 req->src, req->src_len, &zctx->cprm);
+				 req->src, req->src_len, &zp->cprm);
 	if (zstd_is_error(ret))
 		return -EINVAL;
 	req->dst_len = ret;
 	return 0;
 }
 
-static int zstd_decompress(struct zcomp_ctx *ctx, struct zcomp_req *req)
+static int zstd_decompress(struct zcomp_params *params, struct zcomp_ctx *ctx,
+			   struct zcomp_req *req)
 {
 	struct zstd_ctx *zctx = ctx->context;
 	size_t ret;
@@ -101,5 +122,7 @@ struct zcomp_ops backend_zstd = {
 	.decompress	= zstd_decompress,
 	.create_ctx	= zstd_create,
 	.destroy_ctx	= zstd_destroy,
+	.setup_params	= zstd_setup_params,
+	.release_params	= zstd_release_params,
 	.name		= "zstd",
 };
diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index 1964e6195b4b..a508e692999f 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -128,7 +128,7 @@ int zcomp_compress(struct zcomp *comp, struct zcomp_strm *zstrm,
 	};
 	int ret;
 
-	ret = comp->ops->compress(&zstrm->ctx, &req);
+	ret = comp->ops->compress(comp->params, &zstrm->ctx, &req);
 	if (!ret)
 		*dst_len = req.dst_len;
 	return ret;
@@ -144,7 +144,7 @@ int zcomp_decompress(struct zcomp *comp, struct zcomp_strm *zstrm,
 		.dst_len = PAGE_SIZE,
 	};
 
-	return comp->ops->decompress(&zstrm->ctx, &req);
+	return comp->ops->decompress(comp->params, &zstrm->ctx, &req);
 }
 
 int zcomp_cpu_up_prepare(unsigned int cpu, struct hlist_node *node)
@@ -172,7 +172,7 @@ int zcomp_cpu_dead(unsigned int cpu, struct hlist_node *node)
 	return 0;
 }
 
-static int zcomp_init(struct zcomp *comp)
+static int zcomp_init(struct zcomp *comp, struct zcomp_params *params)
 {
 	int ret;
 
@@ -180,12 +180,19 @@ static int zcomp_init(struct zcomp *comp)
 	if (!comp->stream)
 		return -ENOMEM;
 
+	comp->params = params;
+	ret = comp->ops->setup_params(comp->params);
+	if (ret)
+		goto cleanup;
+
 	ret = cpuhp_state_add_instance(CPUHP_ZCOMP_PREPARE, &comp->node);
 	if (ret < 0)
 		goto cleanup;
+
 	return 0;
 
 cleanup:
+	comp->ops->release_params(comp->params);
 	free_percpu(comp->stream);
 	return ret;
 }
@@ -193,6 +200,7 @@ static int zcomp_init(struct zcomp *comp)
 void zcomp_destroy(struct zcomp *comp)
 {
 	cpuhp_state_remove_instance(CPUHP_ZCOMP_PREPARE, &comp->node);
+	comp->ops->release_params(comp->params);
 	free_percpu(comp->stream);
 	kfree(comp);
 }
@@ -214,14 +222,13 @@ struct zcomp *zcomp_create(const char *alg, struct zcomp_params *params)
 	if (!comp)
 		return ERR_PTR(-ENOMEM);
 
-	comp->params = params;
 	comp->ops = lookup_backend_ops(alg);
 	if (!comp->ops) {
 		kfree(comp);
 		return ERR_PTR(-EINVAL);
 	}
 
-	error = zcomp_init(comp);
+	error = zcomp_init(comp, params);
 	if (error) {
 		kfree(comp);
 		return ERR_PTR(error);
diff --git a/drivers/block/zram/zcomp.h b/drivers/block/zram/zcomp.h
index ebab7dbca68d..6cb081e5b23e 100644
--- a/drivers/block/zram/zcomp.h
+++ b/drivers/block/zram/zcomp.h
@@ -7,10 +7,18 @@
 
 #define ZCOMP_PARAM_NO_LEVEL	INT_MIN
 
+/*
+ * Immutable driver (backend) parameters. The driver may attach private
+ * data to it (e.g. driver representation of the dictionary, etc.).
+ *
+ * This data is kept per-comp and is shared among execution contexts.
+ */
 struct zcomp_params {
 	void *dict;
 	size_t dict_sz;
 	s32 level;
+
+	void *drv_data;
 };
 
 /*
@@ -38,13 +46,17 @@ struct zcomp_req {
 };
 
 struct zcomp_ops {
-	int (*compress)(struct zcomp_ctx *ctx, struct zcomp_req *req);
-	int (*decompress)(struct zcomp_ctx *ctx, struct zcomp_req *req);
+	int (*compress)(struct zcomp_params *params, struct zcomp_ctx *ctx,
+			struct zcomp_req *req);
+	int (*decompress)(struct zcomp_params *params, struct zcomp_ctx *ctx,
+			  struct zcomp_req *req);
 
-	int (*create_ctx)(struct zcomp_params *params,
-			  struct zcomp_ctx *ctx);
+	int (*create_ctx)(struct zcomp_params *params, struct zcomp_ctx *ctx);
 	void (*destroy_ctx)(struct zcomp_ctx *ctx);
 
+	int (*setup_params)(struct zcomp_params *params);
+	void (*release_params)(struct zcomp_params *params);
+
 	const char *name;
 };
 
-- 
2.45.2.803.g4e1b14247a-goog


