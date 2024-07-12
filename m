Return-Path: <linux-kernel+bounces-250189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B2592F505
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 07:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96AB8281DC6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 05:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A3113A3F4;
	Fri, 12 Jul 2024 05:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oDorOCo2"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9156E1386DF
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 05:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720761589; cv=none; b=C1hturLKBsTaSLlTMqNpHb59pzYeb5chhFpGM0MGwVFeoAiZtdt7Gq59xklXoHJBRPcYKLQuOqygExuu6MB8tz01J0t1KJV5xMN+TVGZxAph+w+jmn5FdvkPTv8TxGE19ogXgp+N8/acfiJ8fTYDdNe9daco+klQgB1PbIP4tiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720761589; c=relaxed/simple;
	bh=csVsBdDsmePvz+KmBra6QJSTU8HQoyTERVghOcl7m+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PNXsdIojmzR+LEtGEt/COoxR5b/OblY7c+/TJQVaKcM3XBi7B6PGWPRqbq/rRxRrR2Qx/X+eef3VwFUt9rN1tr98ldK7VPcxjFE1ototDYYGrOwL3cVvFS3T5pEumNpN+2eFThnYXHnIktj+fk8TrMJlxhNxU63Spa8gwyR8fCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oDorOCo2; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3d9dbbaa731so910420b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 22:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720761586; x=1721366386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a9pv9z2MtsR34imvndck6Cotg/vfME6RwvWopqH+sJk=;
        b=oDorOCo2F0EVwyI+0yb/D03GEn1J1zBj/aEeiIEkz2xnqdFphW3/CrZQY/7LUsmMsw
         ogz4atLGchlelOlsdKrdMmcXo6wL/PkaIiKR2Gx1CgMI/2WD3WjbwoGye8No6KeYHe6m
         Je1il1YxXbPwQuyN1YUAcM4K4CkqWrPQ0dV6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720761586; x=1721366386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a9pv9z2MtsR34imvndck6Cotg/vfME6RwvWopqH+sJk=;
        b=pzPWg8wHlmL76FH+CszUQhqCsu4es/ngNSSU303TmE2FrqiiI+puUcd6oeAQv9V+wS
         SW4vpQgSyZBndECP4P1cUKdt5l5bpbEbFts1RLfPq+Cg2e2IV9jcKXb9YUseSQDFec/U
         6RTBT0oEW9nFaa1FZKjAbagWBuAxjaKvZ5vL6qHDUYJ3nOLUsSqfxogv6yB1CI4Y5qdo
         O1mQTBledL9426VKbkNzghqjGKqthMTTNgrNjXJDtdw7tIuU50cMHZ1/chUYy97V8LRU
         dDzfFsH6Aym/J5z6iIyBPjKLLtfOlsQ2+iqpFzfLLpJf4TbhtL2EYTGnMP4uqWhvz7Ar
         VlhA==
X-Gm-Message-State: AOJu0Ywsj5BAg6NkVMBph9g7S3TplTxBJblgWB+NEpaCvjxc4EcEcZQY
	6SJ7bsWIVymViDgvbrkTTl1DzenwAysRhzN1vPEYJ996WipBYyc8e2EtCRBVZw==
X-Google-Smtp-Source: AGHT+IG6QrcKXNLvDYdzeak+xwUSVhl96WxvE+7fmduNCRTKlxfRpaxiwBZIw2abDNWGc9SF5PM3Bg==
X-Received: by 2002:a05:6808:30aa:b0:3d9:245c:4226 with SMTP id 5614622812f47-3d93c082a4amr11601164b6e.37.1720761586447;
        Thu, 11 Jul 2024 22:19:46 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:15f3:5252:ec56:52ae])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b43967851sm6553436b3a.109.2024.07.11.22.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 22:19:46 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v6 19/23] zram: move immutable comp params away from per-CPU context
Date: Fri, 12 Jul 2024 14:18:30 +0900
Message-ID: <20240712051850.484318-20-senozhatsky@chromium.org>
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
index 2f1202322264..10d9d5c60f53 100644
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
 
@@ -44,5 +55,7 @@ const struct zcomp_ops backend_842 = {
 	.decompress	= decompress_842,
 	.create_ctx	= create_842,
 	.destroy_ctx	= destroy_842,
+	.setup_params	= setup_params_842,
+	.release_params	= release_params_842,
 	.name		= "842",
 };
diff --git a/drivers/block/zram/backend_deflate.c b/drivers/block/zram/backend_deflate.c
index eae4ee35c1df..0f7f252c12f4 100644
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
@@ -131,5 +140,7 @@ const struct zcomp_ops backend_deflate = {
 	.decompress	= deflate_decompress,
 	.create_ctx	= deflate_create,
 	.destroy_ctx	= deflate_destroy,
+	.setup_params	= deflate_setup_params,
+	.release_params	= deflate_release_params,
 	.name		= "deflate",
 };
diff --git a/drivers/block/zram/backend_lz4.c b/drivers/block/zram/backend_lz4.c
index e2d951e62746..cf3c029bd5ad 100644
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
 
@@ -74,5 +61,7 @@ const struct zcomp_ops backend_lz4 = {
 	.decompress	= lz4_decompress,
 	.create_ctx	= lz4_create,
 	.destroy_ctx	= lz4_destroy,
+	.setup_params	= lz4_setup_params,
+	.release_params	= lz4_release_params,
 	.name		= "lz4",
 };
diff --git a/drivers/block/zram/backend_lz4hc.c b/drivers/block/zram/backend_lz4hc.c
index 6da71ec5fc05..928a6ea78668 100644
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
 
@@ -74,5 +61,7 @@ const struct zcomp_ops backend_lz4hc = {
 	.decompress	= lz4hc_decompress,
 	.create_ctx	= lz4hc_create,
 	.destroy_ctx	= lz4hc_destroy,
+	.setup_params	= lz4hc_setup_params,
+	.release_params	= lz4hc_release_params,
 	.name		= "lz4hc",
 };
diff --git a/drivers/block/zram/backend_lzo.c b/drivers/block/zram/backend_lzo.c
index 81fbad286092..4c906beaae6b 100644
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
 
@@ -42,5 +53,7 @@ const struct zcomp_ops backend_lzo = {
 	.decompress	= lzo_decompress,
 	.create_ctx	= lzo_create,
 	.destroy_ctx	= lzo_destroy,
+	.setup_params	= lzo_setup_params,
+	.release_params	= lzo_release_params,
 	.name		= "lzo",
 };
diff --git a/drivers/block/zram/backend_lzorle.c b/drivers/block/zram/backend_lzorle.c
index 99c9da8f116e..10640c96cbfc 100644
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
 
@@ -42,5 +53,7 @@ const struct zcomp_ops backend_lzorle = {
 	.decompress	= lzorle_decompress,
 	.create_ctx	= lzorle_create,
 	.destroy_ctx	= lzorle_destroy,
+	.setup_params	= lzorle_setup_params,
+	.release_params	= lzorle_release_params,
 	.name		= "lzo-rle",
 };
diff --git a/drivers/block/zram/backend_zstd.c b/drivers/block/zram/backend_zstd.c
index 9f000dedf1ad..5b33daf4f645 100644
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
@@ -101,5 +122,7 @@ const struct zcomp_ops backend_zstd = {
 	.decompress	= zstd_decompress,
 	.create_ctx	= zstd_create,
 	.destroy_ctx	= zstd_destroy,
+	.setup_params	= zstd_setup_params,
+	.release_params	= zstd_release_params,
 	.name		= "zstd",
 };
diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index 877ae6c6ae9d..269b7155eb23 100644
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
index 1d8920c2d449..ad5762813842 100644
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
2.45.2.993.g49e7a77208-goog


