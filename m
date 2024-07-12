Return-Path: <linux-kernel+bounces-250188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE9392F504
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 07:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 807371F21A46
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 05:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D022B139CF2;
	Fri, 12 Jul 2024 05:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c9RN/rnX"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5614D137902
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 05:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720761587; cv=none; b=MM7TAcnJXOc2hlQ7xHgBg3l2Nu2bJifdcXZ4EUkg6Wn3lvWbaEXBOe8lvH4dq2jQvT5Ncknxu2PjxIpuN5UYvSEiqfNfWqCnTBxdS0yZRpaFqryi7I73RmAaDYE5eW96pbqIuGeGUoBEP8y8vzEhAqSp7sFuQk1zx8gIP/FjzQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720761587; c=relaxed/simple;
	bh=tchSnYXJ6LN9WZ6ym+UCMan1DHyAMu7RAtI0AP8rJic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GnCHtpIZ3KVlX7zDo4AqNrFZzlYr8bYQfQ5iStb7jT97YXEJ3kZ0NzPNnTN//KGkVSqulf/4mJAkgDSCq7iVX62g3hJMf/PAcZfgHaenRuROBYtbW3IzVN40IH6pwFyrKtD3SJuFvouV47vATqe4hKOuEn2fyo9ymBepTsHq1IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=c9RN/rnX; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3d932f991f6so940308b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 22:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720761584; x=1721366384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PWvQDCdKd63WAe8Ad5X75caqQH0R/FhpcSO3XDqLiyY=;
        b=c9RN/rnX1jqPF7bmgK/c1Z/FvDAngFATkEQKMH1CZ0MuAsXH2nzIOk08y7xKVBI/mp
         9MgI/7A2AN7l0RvVPYC3ekPyLcsaSFp6YJPBKB9icQ28/yEOb7JhLrRAZZlvucYJQnLF
         1juxv87RPOCrK51OWO9mw2f7nwiRD1yKIKrfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720761584; x=1721366384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PWvQDCdKd63WAe8Ad5X75caqQH0R/FhpcSO3XDqLiyY=;
        b=TlSoQXlZYAv8xDUp4nN1chiIVGh68C+3hIV0S8jXZun/MnZyPASsP+zEsnGV/xxVV1
         3Uv5/n1g4Y96hESBtXIvE22PWVHs9I9TdpdBJBs0ZJ2phYueH95ltJA8Bc6TJZG4rz3l
         inSOBeBF1PPN1R3SV/9jW/HdE9AD22HPFRqYSb6y9+Ikzqb030TbmBilwaMvUKaNZSnM
         tunlJbE4gVql60thQXmUKLNC2yvq/IWDixnOXWGtA2rG3A9EvQxlYWUJcFyyETcp6Lj7
         lCPnm1y2tymNJElQ+C464+6hMw3XAwqqNLp4/2umYneozFXD4TLjjYr2IpJYEtbIkxKq
         Wl+Q==
X-Gm-Message-State: AOJu0YyYyEyYAWlmqAFuGQpdSLwrrsgX+nfgM0ox8hepLKPsdJx6VNLj
	YMqOwML3fcs9mRokofHhMhkFWErnuR53sOwawbU787K3sMOqYkdnZ/y2yCeHsg==
X-Google-Smtp-Source: AGHT+IHEQ9PC+OrP8VT7nrPp4W+7gyceTLpJ6t49NPnqgqPNU3epzdY5WNVbEEld2jSj9lyePmVZPA==
X-Received: by 2002:a05:6808:2d9:b0:3d9:de1e:c24c with SMTP id 5614622812f47-3d9de1ecd6cmr6116125b6e.3.1720761584331;
        Thu, 11 Jul 2024 22:19:44 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:15f3:5252:ec56:52ae])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b43967851sm6553436b3a.109.2024.07.11.22.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 22:19:44 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v6 18/23] zram: introduce zcomp_ctx structure
Date: Fri, 12 Jul 2024 14:18:29 +0900
Message-ID: <20240712051850.484318-19-senozhatsky@chromium.org>
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

Keep run-time driver data (scratch buffers, etc.) in
zcomp_ctx structure.  This structure is allocated per-CPU
because drivers (backends) need to modify its content
during requests execution.

We will split mutable and immutable driver data, this is
a preparation path.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/backend_842.c     | 39 ++++++--------------
 drivers/block/zram/backend_deflate.c | 46 +++++++++++++-----------
 drivers/block/zram/backend_lz4.c     | 36 ++++++++++---------
 drivers/block/zram/backend_lz4hc.c   | 36 ++++++++++---------
 drivers/block/zram/backend_lzo.c     | 17 +++++----
 drivers/block/zram/backend_lzorle.c  | 17 +++++----
 drivers/block/zram/backend_zstd.c    | 54 +++++++++++++++-------------
 drivers/block/zram/zcomp.c           | 16 +++++----
 drivers/block/zram/zcomp.h           | 23 ++++++++----
 9 files changed, 149 insertions(+), 135 deletions(-)

diff --git a/drivers/block/zram/backend_842.c b/drivers/block/zram/backend_842.c
index 1597dc4d4f1c..2f1202322264 100644
--- a/drivers/block/zram/backend_842.c
+++ b/drivers/block/zram/backend_842.c
@@ -7,51 +7,32 @@
 
 #include "backend_842.h"
 
-struct sw842_ctx {
-	void *mem;
-};
-
-static void destroy_842(void *ctx)
+static void destroy_842(struct zcomp_ctx *ctx)
 {
-	struct sw842_ctx *zctx = ctx;
-
-	kfree(zctx->mem);
-	kfree(zctx);
+	kfree(ctx->context);
 }
 
-static void *create_842(struct zcomp_params *params)
+static int create_842(struct zcomp_params *params, struct zcomp_ctx *ctx)
 {
-	struct sw842_ctx *ctx;
-
-	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
-	if (!ctx)
-		return NULL;
-
-	ctx->mem = kmalloc(SW842_MEM_COMPRESS, GFP_KERNEL);
-	if (!ctx->mem)
-		goto error;
-
-	return ctx;
-
-error:
-	destroy_842(ctx);
-	return NULL;
+	ctx->context = kmalloc(SW842_MEM_COMPRESS, GFP_KERNEL);
+	if (!ctx->context)
+		return -ENOMEM;
+	return 0;
 }
 
-static int compress_842(void *ctx, struct zcomp_req *req)
+static int compress_842(struct zcomp_ctx *ctx, struct zcomp_req *req)
 {
-	struct sw842_ctx *zctx = ctx;
 	unsigned int dlen = req->dst_len;
 	int ret;
 
 	ret = sw842_compress(req->src, req->src_len, req->dst, &dlen,
-			     zctx->mem);
+			     ctx->context);
 	if (ret == 0)
 		req->dst_len = dlen;
 	return ret;
 }
 
-static int decompress_842(void *ctx, struct zcomp_req *req)
+static int decompress_842(struct zcomp_ctx *ctx, struct zcomp_req *req)
 {
 	unsigned int dlen = req->dst_len;
 
diff --git a/drivers/block/zram/backend_deflate.c b/drivers/block/zram/backend_deflate.c
index 117852d45aa4..eae4ee35c1df 100644
--- a/drivers/block/zram/backend_deflate.c
+++ b/drivers/block/zram/backend_deflate.c
@@ -17,9 +17,12 @@ struct deflate_ctx {
 	s32 level;
 };
 
-static void deflate_destroy(void *ctx)
+static void deflate_destroy(struct zcomp_ctx *ctx)
 {
-	struct deflate_ctx *zctx = ctx;
+	struct deflate_ctx *zctx = ctx->context;
+
+	if (!zctx)
+		return;
 
 	if (zctx->cctx.workspace) {
 		zlib_deflateEnd(&zctx->cctx);
@@ -32,51 +35,52 @@ static void deflate_destroy(void *ctx)
 	kfree(zctx);
 }
 
-static void *deflate_create(struct zcomp_params *params)
+static int deflate_create(struct zcomp_params *params, struct zcomp_ctx *ctx)
 {
-	struct deflate_ctx *ctx;
+	struct deflate_ctx *zctx;
 	size_t sz;
 	int ret;
 
-	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
-	if (!ctx)
-		return NULL;
+	zctx = kzalloc(sizeof(*zctx), GFP_KERNEL);
+	if (!zctx)
+		return -ENOMEM;
 
+	ctx->context = zctx;
 	if (params->level != ZCOMP_PARAM_NO_LEVEL)
-		ctx->level = params->level;
+		zctx->level = params->level;
 	else
-		ctx->level = Z_DEFAULT_COMPRESSION;
+		zctx->level = Z_DEFAULT_COMPRESSION;
 
 	sz = zlib_deflate_workspacesize(-DEFLATE_DEF_WINBITS, MAX_MEM_LEVEL);
-	ctx->cctx.workspace = vzalloc(sz);
-	if (!ctx->cctx.workspace)
+	zctx->cctx.workspace = vzalloc(sz);
+	if (!zctx->cctx.workspace)
 		goto error;
 
-	ret = zlib_deflateInit2(&ctx->cctx, ctx->level, Z_DEFLATED,
+	ret = zlib_deflateInit2(&zctx->cctx, zctx->level, Z_DEFLATED,
 				-DEFLATE_DEF_WINBITS, DEFLATE_DEF_MEMLEVEL,
 				Z_DEFAULT_STRATEGY);
 	if (ret != Z_OK)
 		goto error;
 
 	sz = zlib_inflate_workspacesize();
-	ctx->dctx.workspace = vzalloc(sz);
-	if (!ctx->dctx.workspace)
+	zctx->dctx.workspace = vzalloc(sz);
+	if (!zctx->dctx.workspace)
 		goto error;
 
-	ret = zlib_inflateInit2(&ctx->dctx, -DEFLATE_DEF_WINBITS);
+	ret = zlib_inflateInit2(&zctx->dctx, -DEFLATE_DEF_WINBITS);
 	if (ret != Z_OK)
 		goto error;
 
-	return ctx;
+	return 0;
 
 error:
 	deflate_destroy(ctx);
-	return NULL;
+	return -EINVAL;
 }
 
-static int deflate_compress(void *ctx, struct zcomp_req *req)
+static int deflate_compress(struct zcomp_ctx *ctx, struct zcomp_req *req)
 {
-	struct deflate_ctx *zctx = ctx;
+	struct deflate_ctx *zctx = ctx->context;
 	struct z_stream_s *deflate;
 	int ret;
 
@@ -98,9 +102,9 @@ static int deflate_compress(void *ctx, struct zcomp_req *req)
 	return 0;
 }
 
-static int deflate_decompress(void *ctx, struct zcomp_req *req)
+static int deflate_decompress(struct zcomp_ctx *ctx, struct zcomp_req *req)
 {
-	struct deflate_ctx *zctx = ctx;
+	struct deflate_ctx *zctx = ctx->context;
 	struct z_stream_s *inflate;
 	int ret;
 
diff --git a/drivers/block/zram/backend_lz4.c b/drivers/block/zram/backend_lz4.c
index cc4ae4097870..e2d951e62746 100644
--- a/drivers/block/zram/backend_lz4.c
+++ b/drivers/block/zram/backend_lz4.c
@@ -10,40 +10,44 @@ struct lz4_ctx {
 	s32 level;
 };
 
-static void lz4_destroy(void *ctx)
+static void lz4_destroy(struct zcomp_ctx *ctx)
 {
-	struct lz4_ctx *zctx = ctx;
+	struct lz4_ctx *zctx = ctx->context;
+
+	if (!zctx)
+		return;
 
 	vfree(zctx->mem);
 	kfree(zctx);
 }
 
-static void *lz4_create(struct zcomp_params *params)
+static int lz4_create(struct zcomp_params *params, struct zcomp_ctx *ctx)
 {
-	struct lz4_ctx *ctx;
+	struct lz4_ctx *zctx;
 
-	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
-	if (!ctx)
-		return NULL;
+	zctx = kzalloc(sizeof(*zctx), GFP_KERNEL);
+	if (!zctx)
+		return -ENOMEM;
 
+	ctx->context = zctx;
 	if (params->level != ZCOMP_PARAM_NO_LEVEL)
-		ctx->level = params->level;
+		zctx->level = params->level;
 	else
-		ctx->level = LZ4_ACCELERATION_DEFAULT;
+		zctx->level = LZ4_ACCELERATION_DEFAULT;
 
-	ctx->mem = vmalloc(LZ4_MEM_COMPRESS);
-	if (!ctx->mem)
+	zctx->mem = vmalloc(LZ4_MEM_COMPRESS);
+	if (!zctx->mem)
 		goto error;
 
-	return ctx;
+	return 0;
 error:
 	lz4_destroy(ctx);
-	return NULL;
+	return -EINVAL;
 }
 
-static int lz4_compress(void *ctx, struct zcomp_req *req)
+static int lz4_compress(struct zcomp_ctx *ctx, struct zcomp_req *req)
 {
-	struct lz4_ctx *zctx = ctx;
+	struct lz4_ctx *zctx = ctx->context;
 	int ret;
 
 	ret = LZ4_compress_fast(req->src, req->dst, req->src_len,
@@ -54,7 +58,7 @@ static int lz4_compress(void *ctx, struct zcomp_req *req)
 	return 0;
 }
 
-static int lz4_decompress(void *ctx, struct zcomp_req *req)
+static int lz4_decompress(struct zcomp_ctx *ctx, struct zcomp_req *req)
 {
 	int ret;
 
diff --git a/drivers/block/zram/backend_lz4hc.c b/drivers/block/zram/backend_lz4hc.c
index 610dadc09751..6da71ec5fc05 100644
--- a/drivers/block/zram/backend_lz4hc.c
+++ b/drivers/block/zram/backend_lz4hc.c
@@ -10,40 +10,44 @@ struct lz4hc_ctx {
 	s32 level;
 };
 
-static void lz4hc_destroy(void *ctx)
+static void lz4hc_destroy(struct zcomp_ctx *ctx)
 {
-	struct lz4hc_ctx *zctx = ctx;
+	struct lz4hc_ctx *zctx = ctx->context;
+
+	if (!zctx)
+		return;
 
 	vfree(zctx->mem);
 	kfree(zctx);
 }
 
-static void *lz4hc_create(struct zcomp_params *params)
+static int lz4hc_create(struct zcomp_params *params, struct zcomp_ctx *ctx)
 {
-	struct lz4hc_ctx *ctx;
+	struct lz4hc_ctx *zctx;
 
-	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
-	if (!ctx)
-		return NULL;
+	zctx = kzalloc(sizeof(*zctx), GFP_KERNEL);
+	if (!zctx)
+		return -ENOMEM;
 
+	ctx->context = zctx;
 	if (params->level != ZCOMP_PARAM_NO_LEVEL)
-		ctx->level = params->level;
+		zctx->level = params->level;
 	else
-		ctx->level = LZ4HC_DEFAULT_CLEVEL;
+		zctx->level = LZ4HC_DEFAULT_CLEVEL;
 
-	ctx->mem = vmalloc(LZ4HC_MEM_COMPRESS);
-	if (!ctx->mem)
+	zctx->mem = vmalloc(LZ4HC_MEM_COMPRESS);
+	if (!zctx->mem)
 		goto error;
 
-	return ctx;
+	return 0;
 error:
 	lz4hc_destroy(ctx);
-	return NULL;
+	return -EINVAL;
 }
 
-static int lz4hc_compress(void *ctx, struct zcomp_req *req)
+static int lz4hc_compress(struct zcomp_ctx *ctx, struct zcomp_req *req)
 {
-	struct lz4hc_ctx *zctx = ctx;
+	struct lz4hc_ctx *zctx = ctx->context;
 	int ret;
 
 	ret = LZ4_compress_HC(req->src, req->dst, req->src_len, req->dst_len,
@@ -54,7 +58,7 @@ static int lz4hc_compress(void *ctx, struct zcomp_req *req)
 	return 0;
 }
 
-static int lz4hc_decompress(void *ctx, struct zcomp_req *req)
+static int lz4hc_decompress(struct zcomp_ctx *ctx, struct zcomp_req *req)
 {
 	int ret;
 
diff --git a/drivers/block/zram/backend_lzo.c b/drivers/block/zram/backend_lzo.c
index 88f1aa5683f3..81fbad286092 100644
--- a/drivers/block/zram/backend_lzo.c
+++ b/drivers/block/zram/backend_lzo.c
@@ -6,26 +6,29 @@
 
 #include "backend_lzo.h"
 
-static void *lzo_create(struct zcomp_params *params)
+static int lzo_create(struct zcomp_params *params, struct zcomp_ctx *ctx)
 {
-	return kzalloc(LZO1X_MEM_COMPRESS, GFP_KERNEL);
+	ctx->context = kzalloc(LZO1X_MEM_COMPRESS, GFP_KERNEL);
+	if (!ctx->context)
+		return -ENOMEM;
+	return 0;
 }
 
-static void lzo_destroy(void *ctx)
+static void lzo_destroy(struct zcomp_ctx *ctx)
 {
-	kfree(ctx);
+	kfree(ctx->context);
 }
 
-static int lzo_compress(void *ctx, struct zcomp_req *req)
+static int lzo_compress(struct zcomp_ctx *ctx, struct zcomp_req *req)
 {
 	int ret;
 
 	ret = lzo1x_1_compress(req->src, req->src_len, req->dst,
-			       &req->dst_len, ctx);
+			       &req->dst_len, ctx->context);
 	return ret == LZO_E_OK ? 0 : ret;
 }
 
-static int lzo_decompress(void *ctx, struct zcomp_req *req)
+static int lzo_decompress(struct zcomp_ctx *ctx, struct zcomp_req *req)
 {
 	int ret;
 
diff --git a/drivers/block/zram/backend_lzorle.c b/drivers/block/zram/backend_lzorle.c
index f05820929a74..99c9da8f116e 100644
--- a/drivers/block/zram/backend_lzorle.c
+++ b/drivers/block/zram/backend_lzorle.c
@@ -6,26 +6,29 @@
 
 #include "backend_lzorle.h"
 
-static void *lzorle_create(struct zcomp_params *params)
+static int lzorle_create(struct zcomp_params *params, struct zcomp_ctx *ctx)
 {
-	return kzalloc(LZO1X_MEM_COMPRESS, GFP_KERNEL);
+	ctx->context = kzalloc(LZO1X_MEM_COMPRESS, GFP_KERNEL);
+	if (!ctx->context)
+		return -ENOMEM;
+	return 0;
 }
 
-static void lzorle_destroy(void *ctx)
+static void lzorle_destroy(struct zcomp_ctx *ctx)
 {
-	kfree(ctx);
+	kfree(ctx->context);
 }
 
-static int lzorle_compress(void *ctx, struct zcomp_req *req)
+static int lzorle_compress(struct zcomp_ctx *ctx, struct zcomp_req *req)
 {
 	int ret;
 
 	ret = lzorle1x_1_compress(req->src, req->src_len, req->dst,
-				  &req->dst_len, ctx);
+				  &req->dst_len, ctx->context);
 	return ret == LZO_E_OK ? 0 : ret;
 }
 
-static int lzorle_decompress(void *ctx, struct zcomp_req *req)
+static int lzorle_decompress(struct zcomp_ctx *ctx, struct zcomp_req *req)
 {
 	int ret;
 
diff --git a/drivers/block/zram/backend_zstd.c b/drivers/block/zram/backend_zstd.c
index 19eba65f44c9..9f000dedf1ad 100644
--- a/drivers/block/zram/backend_zstd.c
+++ b/drivers/block/zram/backend_zstd.c
@@ -16,60 +16,64 @@ struct zstd_ctx {
 	s32 level;
 };
 
-static void zstd_destroy(void *ctx)
+static void zstd_destroy(struct zcomp_ctx *ctx)
 {
-	struct zstd_ctx *zctx = ctx;
+	struct zstd_ctx *zctx = ctx->context;
+
+	if (!zctx)
+		return;
 
 	vfree(zctx->cctx_mem);
 	vfree(zctx->dctx_mem);
 	kfree(zctx);
 }
 
-static void *zstd_create(struct zcomp_params *params)
+static int zstd_create(struct zcomp_params *params, struct zcomp_ctx *ctx)
 {
+	struct zstd_ctx *zctx;
 	zstd_parameters prm;
-	struct zstd_ctx *ctx;
 	size_t sz;
 
-	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
-	if (!ctx)
-		return NULL;
+	zctx = kzalloc(sizeof(*zctx), GFP_KERNEL);
+	if (!zctx)
+		return -ENOMEM;
 
+	ctx->context = zctx;
 	if (params->level != ZCOMP_PARAM_NO_LEVEL)
-		ctx->level = params->level;
+		zctx->level = params->level;
 	else
-		ctx->level = zstd_default_clevel();
+		zctx->level = zstd_default_clevel();
 
-	prm = zstd_get_params(ctx->level, PAGE_SIZE);
-	ctx->cprm = zstd_get_params(ctx->level, PAGE_SIZE);
+	prm = zstd_get_params(zctx->level, PAGE_SIZE);
+	zctx->cprm = zstd_get_params(zctx->level, PAGE_SIZE);
 	sz = zstd_cctx_workspace_bound(&prm.cParams);
-	ctx->cctx_mem = vzalloc(sz);
-	if (!ctx->cctx_mem)
+	zctx->cctx_mem = vzalloc(sz);
+	if (!zctx->cctx_mem)
 		goto error;
 
-	ctx->cctx = zstd_init_cctx(ctx->cctx_mem, sz);
-	if (!ctx->cctx)
+	zctx->cctx = zstd_init_cctx(zctx->cctx_mem, sz);
+	if (!zctx->cctx)
 		goto error;
 
 	sz = zstd_dctx_workspace_bound();
-	ctx->dctx_mem = vzalloc(sz);
-	if (!ctx->dctx_mem)
+	zctx->dctx_mem = vzalloc(sz);
+	if (!zctx->dctx_mem)
 		goto error;
 
-	ctx->dctx = zstd_init_dctx(ctx->dctx_mem, sz);
-	if (!ctx->dctx)
+	zctx->dctx = zstd_init_dctx(zctx->dctx_mem, sz);
+	if (!zctx->dctx)
 		goto error;
 
-	return ctx;
+	return 0;
 
 error:
 	zstd_destroy(ctx);
-	return NULL;
+	return -EINVAL;
 }
 
-static int zstd_compress(void *ctx, struct zcomp_req *req)
+static int zstd_compress(struct zcomp_ctx *ctx, struct zcomp_req *req)
 {
-	struct zstd_ctx *zctx = ctx;
+	struct zstd_ctx *zctx = ctx->context;
 	size_t ret;
 
 	ret = zstd_compress_cctx(zctx->cctx, req->dst, req->dst_len,
@@ -80,9 +84,9 @@ static int zstd_compress(void *ctx, struct zcomp_req *req)
 	return 0;
 }
 
-static int zstd_decompress(void *ctx, struct zcomp_req *req)
+static int zstd_decompress(struct zcomp_ctx *ctx, struct zcomp_req *req)
 {
-	struct zstd_ctx *zctx = ctx;
+	struct zstd_ctx *zctx = ctx->context;
 	size_t ret;
 
 	ret = zstd_decompress_dctx(zctx->dctx, req->dst, req->dst_len,
diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index 5048087390ea..877ae6c6ae9d 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -45,23 +45,25 @@ static const struct zcomp_ops *backends[] = {
 
 static void zcomp_strm_free(struct zcomp *comp, struct zcomp_strm *zstrm)
 {
-	if (zstrm->ctx)
-		comp->ops->destroy_ctx(zstrm->ctx);
+	comp->ops->destroy_ctx(&zstrm->ctx);
 	vfree(zstrm->buffer);
-	zstrm->ctx = NULL;
 	zstrm->buffer = NULL;
 }
 
 static int zcomp_strm_init(struct zcomp *comp, struct zcomp_strm *zstrm)
 {
-	zstrm->ctx = comp->ops->create_ctx(comp->params);
+	int ret;
+
+	ret = comp->ops->create_ctx(comp->params, &zstrm->ctx);
+	if (ret)
+		return ret;
 
 	/*
 	 * allocate 2 pages. 1 for compressed data, plus 1 extra for the
 	 * case when compressed size is larger than the original one
 	 */
 	zstrm->buffer = vzalloc(2 * PAGE_SIZE);
-	if (!zstrm->ctx || !zstrm->buffer) {
+	if (!zstrm->buffer) {
 		zcomp_strm_free(comp, zstrm);
 		return -ENOMEM;
 	}
@@ -126,7 +128,7 @@ int zcomp_compress(struct zcomp *comp, struct zcomp_strm *zstrm,
 	};
 	int ret;
 
-	ret = comp->ops->compress(zstrm->ctx, &req);
+	ret = comp->ops->compress(&zstrm->ctx, &req);
 	if (!ret)
 		*dst_len = req.dst_len;
 	return ret;
@@ -142,7 +144,7 @@ int zcomp_decompress(struct zcomp *comp, struct zcomp_strm *zstrm,
 		.dst_len = PAGE_SIZE,
 	};
 
-	return comp->ops->decompress(zstrm->ctx, &req);
+	return comp->ops->decompress(&zstrm->ctx, &req);
 }
 
 int zcomp_cpu_up_prepare(unsigned int cpu, struct hlist_node *node)
diff --git a/drivers/block/zram/zcomp.h b/drivers/block/zram/zcomp.h
index bbc48094f826..1d8920c2d449 100644
--- a/drivers/block/zram/zcomp.h
+++ b/drivers/block/zram/zcomp.h
@@ -13,12 +13,20 @@ struct zcomp_params {
 	s32 level;
 };
 
+/*
+ * Run-time driver context - scratch buffers, etc. It is modified during
+ * request execution (compression/decompression), cannot be shared, so
+ * it's in per-CPU area.
+ */
+struct zcomp_ctx {
+	void *context;
+};
+
 struct zcomp_strm {
-	/* The members ->buffer and ->tfm are protected by ->lock. */
 	local_lock_t lock;
-	/* compression/decompression buffer */
+	/* compression buffer */
 	void *buffer;
-	void *ctx;
+	struct zcomp_ctx ctx;
 };
 
 struct zcomp_req {
@@ -30,11 +38,12 @@ struct zcomp_req {
 };
 
 struct zcomp_ops {
-	int (*compress)(void *ctx, struct zcomp_req *req);
-	int (*decompress)(void *ctx, struct zcomp_req *req);
+	int (*compress)(struct zcomp_ctx *ctx, struct zcomp_req *req);
+	int (*decompress)(struct zcomp_ctx *ctx, struct zcomp_req *req);
 
-	void *(*create_ctx)(struct zcomp_params *params);
-	void (*destroy_ctx)(void *ctx);
+	int (*create_ctx)(struct zcomp_params *params,
+			  struct zcomp_ctx *ctx);
+	void (*destroy_ctx)(struct zcomp_ctx *ctx);
 
 	const char *name;
 };
-- 
2.45.2.993.g49e7a77208-goog


