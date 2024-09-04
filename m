Return-Path: <linux-kernel+bounces-311164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A33CD96858F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 13:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27FD81F2222C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44FD1D6DAB;
	Mon,  2 Sep 2024 10:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SBx/ypH7"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEFA1D6C7B
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 10:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725274666; cv=none; b=ujzjOx+aIUK9bYD5C6Ea5aQImRF//qLsWSNfq1U/XJI1AgFCipwjFNeeTQNIRCas2j7yqZBqLMFBnRNmkWMI6ziQ94JIHRg4zCVc7hv+V1AUauv6LKKF4ZNB+d9JwTAfTbRFmsvPMKt55MbL6a+kaULDoE13QP+kJdpwAEdNZJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725274666; c=relaxed/simple;
	bh=6wDmiA/1DNw14BiJHRLhtfn5Te6bsazC30KPNRXGg4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DMFBvlQ+kKYpVcEmS+6qm+W9rCcvehmQu02wXf+1JqJiosVLAOkrEM1rzPlAO7V/tOfwCQLZe80uGyUm0tkM4ksl6bIXmHB1PNWWb86nJ6rcA+RVmzpt8JmG4I0bjBqaJ4PECyFlNb/j1PmLn8SwkX7YOaGD12id1mYOwf1/jEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SBx/ypH7; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-70f6e65d605so1436997a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 03:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725274663; x=1725879463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wa9gt9P63HqtxVceMMegteqbOblgUbcJgE0EOgrEC+M=;
        b=SBx/ypH7EhZHGtaqvdZhTQZImnk4Iyq0XPolefXIH66I6FeV231z6pXmCI2loagULW
         p42t3A1DcfbPt+K5CXp5r0Dxe30G3+7B8+L8q1RYaINVHhTsJYccEiRVaMsB+K5/blo4
         50VbfZlQPyTfs33obGgzhsCEr/72b9eq7MCB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725274663; x=1725879463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wa9gt9P63HqtxVceMMegteqbOblgUbcJgE0EOgrEC+M=;
        b=xFpop0MDqFgoS5d8INIKAqvvuQbHj507QimLZJfS/CRBPNbqyqR2VT/cix4B0CtU0W
         /xXZWYAoMTLk+0cX9dez6aWWMo3y+MDXljcdAaZ2MjT90tGxGXHEcITnY4/p3Oe5xAJJ
         /xOrgF0f5GkZNMxBGF99K6pk8O6+9XKYT1UoASKIf8yNedTCLH82WdvsW+2+04TWX4T9
         Yy9PbWwomzYgtja/d5oU79rw5lugaICbC1sWc23iLV/9MDWA0NQ8FiJxoGabjLjSlUP2
         zj41Jk4LIG73FwVl3Ik2lg1dhwOEzDYjB3yQ7okg8VCIUmt7EhSF0jCyWpjsjTpA5nlM
         69zw==
X-Forwarded-Encrypted: i=1; AJvYcCVlmYm1AG8jy9Y9KcXt5bR6Gv/5Hh230a96uu4If5WydG+ToYUK5xiptvoeCkfSHTIq6GnQXRViwg6hD9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2W5Wyl+TQjKo4mq9ywt9YIV7V0kviK/7A5mouhAAMgoKmq9p/
	mzL8RCZDPqpDW1557NrW7I/DwuQwdiDVHZ5dksjs57axPAqpmvIbaR5EPWZrTg==
X-Google-Smtp-Source: AGHT+IEgJChzjtURHRzUBqV3J8lewoUgqu5Sor/qbfO4ihneuL9Tit6l4FjdCewmsL+VGCMlf5psVQ==
X-Received: by 2002:a05:6358:590a:b0:1ad:14ec:a002 with SMTP id e5c5f4694b2df-1b603cce8admr1723917755d.26.1725274663364;
        Mon, 02 Sep 2024 03:57:43 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:43a1:71e3:7464:e91b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55a51e9sm6633769b3a.78.2024.09.02.03.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 03:57:43 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv7 19/24] zram: move immutable comp params away from per-CPU context
Date: Mon,  2 Sep 2024 19:56:07 +0900
Message-ID: <20240902105656.1383858-20-senozhatsky@chromium.org>
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
index 96f07287e571..bb514403e305 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -129,7 +129,7 @@ int zcomp_compress(struct zcomp *comp, struct zcomp_strm *zstrm,
 	};
 	int ret;
 
-	ret = comp->ops->compress(&zstrm->ctx, &req);
+	ret = comp->ops->compress(comp->params, &zstrm->ctx, &req);
 	if (!ret)
 		*dst_len = req.dst_len;
 	return ret;
@@ -145,7 +145,7 @@ int zcomp_decompress(struct zcomp *comp, struct zcomp_strm *zstrm,
 		.dst_len = PAGE_SIZE,
 	};
 
-	return comp->ops->decompress(&zstrm->ctx, &req);
+	return comp->ops->decompress(comp->params, &zstrm->ctx, &req);
 }
 
 int zcomp_cpu_up_prepare(unsigned int cpu, struct hlist_node *node)
@@ -173,7 +173,7 @@ int zcomp_cpu_dead(unsigned int cpu, struct hlist_node *node)
 	return 0;
 }
 
-static int zcomp_init(struct zcomp *comp)
+static int zcomp_init(struct zcomp *comp, struct zcomp_params *params)
 {
 	int ret;
 
@@ -181,12 +181,19 @@ static int zcomp_init(struct zcomp *comp)
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
@@ -194,6 +201,7 @@ static int zcomp_init(struct zcomp *comp)
 void zcomp_destroy(struct zcomp *comp)
 {
 	cpuhp_state_remove_instance(CPUHP_ZCOMP_PREPARE, &comp->node);
+	comp->ops->release_params(comp->params);
 	free_percpu(comp->stream);
 	kfree(comp);
 }
@@ -215,14 +223,13 @@ struct zcomp *zcomp_create(const char *alg, struct zcomp_params *params)
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
2.46.0.469.g59c65b2a67-goog


