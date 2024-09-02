Return-Path: <linux-kernel+bounces-311163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6201696858E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 13:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 805771C209DE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DF61D6C7C;
	Mon,  2 Sep 2024 10:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gubkTGDY"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453D01D6C6C
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 10:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725274663; cv=none; b=NJiz29/ljS0OQb2PT7fMFrg3QsXFlX2m3lRwlEXlC5Zw9OZH3VeSXKSxLlSjA0DGUMUzRr1Pf24Xo0rh4bwMWL5O7k4ic/W+GwYEQa4N52WUeU2gqro6eDpp8uTVVSGG2FAQPA3uMNuVGN043N5HalZX6Gdsdet5Md5Gs3mR1Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725274663; c=relaxed/simple;
	bh=8dLzG8l91BXy2CyCVGP/Ke8mbVG2osCScAc58lvsqJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jCwj/2/O5kFwvZHyP8qWEE+6bIwzL5/CsaF2AiWLYbrswsQ91gIpxq8lyLOf8Bv1leYDOfII7MB7iFNdMKQnWqXRRTS2T2+DYQokpMsBltBQ8nXum1QsPB8XcwpkvV02Ir8oPzctjKW3s86JUZQXzjEztsrr29LDK69+HnHr2to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gubkTGDY; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71423273c62so3088715b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 03:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725274661; x=1725879461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X1fh9EznfrieeGu0htuITkaSxE7ubtlH6gRGWJ9AXsU=;
        b=gubkTGDYd05xV9mB8Xb7HnzOw1bv0sIbbD0edMx2rn9t/rlnYF20KpVMUnz1m81JaJ
         2u3r7z05i5Nj5KFQE1mJmRc0wOYFBq5EJKTIGZeoLfBkFVWGkDZGRXQ6n8Xzmy9n98V8
         d7RiGFZHbrR/SMhuW7H7nGylWNYxUJarzzaBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725274661; x=1725879461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X1fh9EznfrieeGu0htuITkaSxE7ubtlH6gRGWJ9AXsU=;
        b=uiy7b9RWdTdyraVktu4W8b98ejqM3amV83NtNjqH3upWTn9DlFmK1Bo3OlmvBwqlWF
         oF6wLP1FqCgDpXVYqbKJMX/kFMyKatocHw7q6xZKlyZJ5fKBkXNA0WMDAxWYl8YG5DIG
         C6XLBvqYsKRv7UYkULqbQxJ7xsKzmGwXQAsYHQq65s/jwbnsgL6/lS2F4cxet+cxou00
         2v/Pdm4Dmn/30JoOL5HZovRASH6dvmvEGn4tkyshM9YlrqC0Tq2adV2Mi/qIYo2e9lLN
         IqkViZQTfSqPgquWH8ra+C6mAj6/1lhD7KIHDblxKxIU2MktK4Yq3wgZx7WKRS7fNRxk
         SW/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWIXPsKP451IGtvt6gwJaN2x0yB9uKIjPT0N1s9RPXyQ22EyC8Up0s/y6MJeONVL5DeEE9fhtctMw9LEKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCXCVpPBTPZ8jZCvB3jYpGKjOJRK8Pm78UrbJJ24L0W1dGtosV
	jNlDaAi3UMLnt3uhxyIow/8jQZVGtbj77gYPig5jdGeM8698LSyFgUPx8E0foQ==
X-Google-Smtp-Source: AGHT+IGSLMIQRt+Nbfc8RzpnjsYei99YOh5o/2046mFKlQ6DNRDdW8RhS7kKuYGtCuDXjnx7b0UDGQ==
X-Received: by 2002:a05:6a00:2316:b0:70d:2ac8:c838 with SMTP id d2e1a72fcca58-7173fa0ac34mr5592892b3a.4.1725274660468;
        Mon, 02 Sep 2024 03:57:40 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:43a1:71e3:7464:e91b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55a51e9sm6633769b3a.78.2024.09.02.03.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 03:57:39 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv7 18/24] zram: introduce zcomp_ctx structure
Date: Mon,  2 Sep 2024 19:56:06 +0900
Message-ID: <20240902105656.1383858-19-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240902105656.1383858-1-senozhatsky@chromium.org>
References: <20240902105656.1383858-1-senozhatsky@chromium.org>
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
index 20ad7b6fe62f..96f07287e571 100644
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
@@ -127,7 +129,7 @@ int zcomp_compress(struct zcomp *comp, struct zcomp_strm *zstrm,
 	};
 	int ret;
 
-	ret = comp->ops->compress(zstrm->ctx, &req);
+	ret = comp->ops->compress(&zstrm->ctx, &req);
 	if (!ret)
 		*dst_len = req.dst_len;
 	return ret;
@@ -143,7 +145,7 @@ int zcomp_decompress(struct zcomp *comp, struct zcomp_strm *zstrm,
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
2.46.0.469.g59c65b2a67-goog


