Return-Path: <linux-kernel+bounces-311162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4668A96858D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 13:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5DF91F2129E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BB018455C;
	Mon,  2 Sep 2024 10:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GlypeYvG"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73781D67B3
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 10:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725274660; cv=none; b=b5TBs7aS4KVnsi51Ww0lrT061s+VYmkqiDSUesn8MCd4zNeBXYI/mFZF47EpNTUjwNWd7gFlxqj8KKdxzC4UKB4fbfTs6zFQJH9xyM/sPzhxxgI0wBz2WMqDAZhBIs2qA8Z6DE3euxUmBcBdZnf5FoX9zXZwII0wXCmqWPhbF0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725274660; c=relaxed/simple;
	bh=AMLuxwGrYJLl+K2wHrLBN5zBzUO8j4CgRKZqp7moKLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=teL1c5nLhj+CbUOp6Xl+L12iARseJUzuKwgD8YeOOqHe8qh5yaES2O+CX0NNXrMAolz9GFlRU14fOd98edz+9t59EaxVvlps+kl2vPe+m7YpVNupI3lv3bmIIvitK7dWxRNH3+rtnI+w3qEA/mQH7XraekWfydphaGuXac7opA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GlypeYvG; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-70f5cd2fa39so2827025a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 03:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725274658; x=1725879458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MWkPMrLpdFdhk1/nVs/HoG4G7wjyRFcEFptGzfIH6eA=;
        b=GlypeYvGULSpBfHWCz0b14FbPc3pM71ngzAGO1BE+x+G0YsYHbDGga/M34fmeuaqtP
         hcsUvp5ghIZPFzAlRp8x2ToXYmHn2iPRyK/RVqMNZIWxqWEq+QtGIarRSifmjTGsnzHC
         wHZVOCHow6nhOCtpc14NYf2/L0Q4PckHMt4Is=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725274658; x=1725879458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MWkPMrLpdFdhk1/nVs/HoG4G7wjyRFcEFptGzfIH6eA=;
        b=Ju5WFsymgjamjImKtEh1Ip0r8ja/eD80Ouj/7TTTCGpO7lBeG9LoeJ2cs7arfJoUV+
         4dVt6S9XJQf6FOgO+8X/c2EZogKE0O8yirTKcEBBZlLX88VM4rWmqQJuIRBTVzksJLac
         q77NMmTpd2GzP65UStje1v+KlmUf8Au+keHQj688N+dewekOA5lfl0Wuraa35fWQUxt4
         suCftobV8MX9OoPKVJ7NFcT6uANiv1swFlRuGS3V5tYaDrVPsA2duQhnG2619xA02txg
         sn9U/19USJuHTbi+V/vzeyMPwD1sKiamcv0TzUokagplueTvpj3mkoBuMW3DXuFduLa6
         ldDA==
X-Forwarded-Encrypted: i=1; AJvYcCX4fqOoRIxJVwA5Lnd1einDSHMSWkgtWsYkYF68pWzKwnac6O9pw7+A7vpEBxr/WAZnShtU4X7bI8tf+FE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx2IKz8w2+K046EIaGfanGtESM5E2aum+fuhEjdOpaUpNg+3b/
	PAtPL1X3VvWLoPL8UP+eiRgLZdTL0YZvGWxD2GHTYpC6FTPckMHe28cxBczziA==
X-Google-Smtp-Source: AGHT+IGS+S1Bs7kfMXcdhbjXm7m4yabXVFSAb7CIJyC87qlYSFyQdEBwSdCpJKuyjaYqI3uKygJBDw==
X-Received: by 2002:a05:6358:93a5:b0:1b5:a157:27c9 with SMTP id e5c5f4694b2df-1b7ef691d23mr962033755d.15.1725274657960;
        Mon, 02 Sep 2024 03:57:37 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:43a1:71e3:7464:e91b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55a51e9sm6633769b3a.78.2024.09.02.03.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 03:57:37 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv7 17/24] zram: introduce zcomp_req structure
Date: Mon,  2 Sep 2024 19:56:05 +0900
Message-ID: <20240902105656.1383858-18-senozhatsky@chromium.org>
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

Encapsulate compression/decompression data in zcomp_req
structure.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/backend_842.c     | 17 ++++++++---------
 drivers/block/zram/backend_deflate.c | 26 +++++++++++---------------
 drivers/block/zram/backend_lz4.c     | 15 +++++++--------
 drivers/block/zram/backend_lz4hc.c   | 13 ++++++-------
 drivers/block/zram/backend_lzo.c     | 12 ++++++------
 drivers/block/zram/backend_lzorle.c  | 13 ++++++-------
 drivers/block/zram/backend_zstd.c    | 15 +++++++--------
 drivers/block/zram/zcomp.c           | 23 ++++++++++++++++-------
 drivers/block/zram/zcomp.h           | 15 ++++++++++-----
 9 files changed, 77 insertions(+), 72 deletions(-)

diff --git a/drivers/block/zram/backend_842.c b/drivers/block/zram/backend_842.c
index e14dba30b0a2..1597dc4d4f1c 100644
--- a/drivers/block/zram/backend_842.c
+++ b/drivers/block/zram/backend_842.c
@@ -38,25 +38,24 @@ static void *create_842(struct zcomp_params *params)
 	return NULL;
 }
 
-static int compress_842(void *ctx, const unsigned char *src, size_t src_len,
-			unsigned char *dst, size_t *dst_len)
+static int compress_842(void *ctx, struct zcomp_req *req)
 {
 	struct sw842_ctx *zctx = ctx;
-	unsigned int dlen = *dst_len;
+	unsigned int dlen = req->dst_len;
 	int ret;
 
-	ret = sw842_compress(src, src_len, dst, &dlen, zctx->mem);
+	ret = sw842_compress(req->src, req->src_len, req->dst, &dlen,
+			     zctx->mem);
 	if (ret == 0)
-		*dst_len = dlen;
+		req->dst_len = dlen;
 	return ret;
 }
 
-static int decompress_842(void *ctx, const unsigned char *src, size_t src_len,
-			  unsigned char *dst, size_t dst_len)
+static int decompress_842(void *ctx, struct zcomp_req *req)
 {
-	unsigned int dlen = dst_len;
+	unsigned int dlen = req->dst_len;
 
-	return sw842_decompress(src, src_len, dst, &dlen);
+	return sw842_decompress(req->src, req->src_len, req->dst, &dlen);
 }
 
 const struct zcomp_ops backend_842 = {
diff --git a/drivers/block/zram/backend_deflate.c b/drivers/block/zram/backend_deflate.c
index ec662ce46897..117852d45aa4 100644
--- a/drivers/block/zram/backend_deflate.c
+++ b/drivers/block/zram/backend_deflate.c
@@ -74,9 +74,7 @@ static void *deflate_create(struct zcomp_params *params)
 	return NULL;
 }
 
-static int deflate_compress(void *ctx, const unsigned char *src,
-			    size_t src_len, unsigned char *dst,
-			    size_t *dst_len)
+static int deflate_compress(void *ctx, struct zcomp_req *req)
 {
 	struct deflate_ctx *zctx = ctx;
 	struct z_stream_s *deflate;
@@ -87,22 +85,20 @@ static int deflate_compress(void *ctx, const unsigned char *src,
 	if (ret != Z_OK)
 		return -EINVAL;
 
-	deflate->next_in = (u8 *)src;
-	deflate->avail_in = src_len;
-	deflate->next_out = (u8 *)dst;
-	deflate->avail_out = *dst_len;
+	deflate->next_in = (u8 *)req->src;
+	deflate->avail_in = req->src_len;
+	deflate->next_out = (u8 *)req->dst;
+	deflate->avail_out = req->dst_len;
 
 	ret = zlib_deflate(deflate, Z_FINISH);
 	if (ret != Z_STREAM_END)
 		return -EINVAL;
 
-	*dst_len = deflate->total_out;
+	req->dst_len = deflate->total_out;
 	return 0;
 }
 
-static int deflate_decompress(void *ctx, const unsigned char *src,
-			      size_t src_len, unsigned char *dst,
-			      size_t dst_len)
+static int deflate_decompress(void *ctx, struct zcomp_req *req)
 {
 	struct deflate_ctx *zctx = ctx;
 	struct z_stream_s *inflate;
@@ -114,10 +110,10 @@ static int deflate_decompress(void *ctx, const unsigned char *src,
 	if (ret != Z_OK)
 		return -EINVAL;
 
-	inflate->next_in = (u8 *)src;
-	inflate->avail_in = src_len;
-	inflate->next_out = (u8 *)dst;
-	inflate->avail_out = dst_len;
+	inflate->next_in = (u8 *)req->src;
+	inflate->avail_in = req->src_len;
+	inflate->next_out = (u8 *)req->dst;
+	inflate->avail_out = req->dst_len;
 
 	ret = zlib_inflate(inflate, Z_SYNC_FLUSH);
 	if (ret != Z_STREAM_END)
diff --git a/drivers/block/zram/backend_lz4.c b/drivers/block/zram/backend_lz4.c
index ec57b5acbd39..cc4ae4097870 100644
--- a/drivers/block/zram/backend_lz4.c
+++ b/drivers/block/zram/backend_lz4.c
@@ -41,26 +41,25 @@ static void *lz4_create(struct zcomp_params *params)
 	return NULL;
 }
 
-static int lz4_compress(void *ctx, const unsigned char *src, size_t src_len,
-			unsigned char *dst, size_t *dst_len)
+static int lz4_compress(void *ctx, struct zcomp_req *req)
 {
 	struct lz4_ctx *zctx = ctx;
 	int ret;
 
-	ret = LZ4_compress_fast(src, dst, src_len, *dst_len,
-				zctx->level, zctx->mem);
+	ret = LZ4_compress_fast(req->src, req->dst, req->src_len,
+				req->dst_len, zctx->level, zctx->mem);
 	if (!ret)
 		return -EINVAL;
-	*dst_len = ret;
+	req->dst_len = ret;
 	return 0;
 }
 
-static int lz4_decompress(void *ctx, const unsigned char *src,
-			  size_t src_len, unsigned char *dst, size_t dst_len)
+static int lz4_decompress(void *ctx, struct zcomp_req *req)
 {
 	int ret;
 
-	ret = LZ4_decompress_safe(src, dst, src_len, dst_len);
+	ret = LZ4_decompress_safe(req->src, req->dst, req->src_len,
+				  req->dst_len);
 	if (ret < 0)
 		return -EINVAL;
 	return 0;
diff --git a/drivers/block/zram/backend_lz4hc.c b/drivers/block/zram/backend_lz4hc.c
index 80733fead595..610dadc09751 100644
--- a/drivers/block/zram/backend_lz4hc.c
+++ b/drivers/block/zram/backend_lz4hc.c
@@ -41,26 +41,25 @@ static void *lz4hc_create(struct zcomp_params *params)
 	return NULL;
 }
 
-static int lz4hc_compress(void *ctx, const unsigned char *src, size_t src_len,
-			  unsigned char *dst, size_t *dst_len)
+static int lz4hc_compress(void *ctx, struct zcomp_req *req)
 {
 	struct lz4hc_ctx *zctx = ctx;
 	int ret;
 
-	ret = LZ4_compress_HC(src, dst, src_len, *dst_len,
+	ret = LZ4_compress_HC(req->src, req->dst, req->src_len, req->dst_len,
 			      zctx->level, zctx->mem);
 	if (!ret)
 		return -EINVAL;
-	*dst_len = ret;
+	req->dst_len = ret;
 	return 0;
 }
 
-static int lz4hc_decompress(void *ctx, const unsigned char *src,
-			    size_t src_len, unsigned char *dst, size_t dst_len)
+static int lz4hc_decompress(void *ctx, struct zcomp_req *req)
 {
 	int ret;
 
-	ret = LZ4_decompress_safe(src, dst, src_len, dst_len);
+	ret = LZ4_decompress_safe(req->src, req->dst, req->src_len,
+				  req->dst_len);
 	if (ret < 0)
 		return -EINVAL;
 	return 0;
diff --git a/drivers/block/zram/backend_lzo.c b/drivers/block/zram/backend_lzo.c
index 8e4aabd04bf3..88f1aa5683f3 100644
--- a/drivers/block/zram/backend_lzo.c
+++ b/drivers/block/zram/backend_lzo.c
@@ -16,21 +16,21 @@ static void lzo_destroy(void *ctx)
 	kfree(ctx);
 }
 
-static int lzo_compress(void *ctx, const unsigned char *src, size_t src_len,
-			unsigned char *dst, size_t *dst_len)
+static int lzo_compress(void *ctx, struct zcomp_req *req)
 {
 	int ret;
 
-	ret = lzo1x_1_compress(src, src_len, dst, dst_len, ctx);
+	ret = lzo1x_1_compress(req->src, req->src_len, req->dst,
+			       &req->dst_len, ctx);
 	return ret == LZO_E_OK ? 0 : ret;
 }
 
-static int lzo_decompress(void *ctx, const unsigned char *src, size_t src_len,
-			  unsigned char *dst, size_t dst_len)
+static int lzo_decompress(void *ctx, struct zcomp_req *req)
 {
 	int ret;
 
-	ret = lzo1x_decompress_safe(src, src_len, dst, &dst_len);
+	ret = lzo1x_decompress_safe(req->src, req->src_len,
+				    req->dst, &req->dst_len);
 	return ret == LZO_E_OK ? 0 : ret;
 }
 
diff --git a/drivers/block/zram/backend_lzorle.c b/drivers/block/zram/backend_lzorle.c
index cb01eb8b04f4..f05820929a74 100644
--- a/drivers/block/zram/backend_lzorle.c
+++ b/drivers/block/zram/backend_lzorle.c
@@ -16,22 +16,21 @@ static void lzorle_destroy(void *ctx)
 	kfree(ctx);
 }
 
-static int lzorle_compress(void *ctx, const unsigned char *src, size_t src_len,
-			   unsigned char *dst, size_t *dst_len)
+static int lzorle_compress(void *ctx, struct zcomp_req *req)
 {
 	int ret;
 
-	ret = lzorle1x_1_compress(src, src_len, dst, dst_len, ctx);
+	ret = lzorle1x_1_compress(req->src, req->src_len, req->dst,
+				  &req->dst_len, ctx);
 	return ret == LZO_E_OK ? 0 : ret;
 }
 
-static int lzorle_decompress(void *ctx, const unsigned char *src,
-			     size_t src_len, unsigned char *dst,
-			     size_t dst_len)
+static int lzorle_decompress(void *ctx, struct zcomp_req *req)
 {
 	int ret;
 
-	ret = lzo1x_decompress_safe(src, src_len, dst, &dst_len);
+	ret = lzo1x_decompress_safe(req->src, req->src_len,
+				    req->dst, &req->dst_len);
 	return ret == LZO_E_OK ? 0 : ret;
 }
 
diff --git a/drivers/block/zram/backend_zstd.c b/drivers/block/zram/backend_zstd.c
index 7c6798f0c912..19eba65f44c9 100644
--- a/drivers/block/zram/backend_zstd.c
+++ b/drivers/block/zram/backend_zstd.c
@@ -67,27 +67,26 @@ static void *zstd_create(struct zcomp_params *params)
 	return NULL;
 }
 
-static int zstd_compress(void *ctx, const unsigned char *src, size_t src_len,
-			 unsigned char *dst, size_t *dst_len)
+static int zstd_compress(void *ctx, struct zcomp_req *req)
 {
 	struct zstd_ctx *zctx = ctx;
 	size_t ret;
 
-	ret = zstd_compress_cctx(zctx->cctx, dst, *dst_len,
-				 src, src_len, &zctx->cprm);
+	ret = zstd_compress_cctx(zctx->cctx, req->dst, req->dst_len,
+				 req->src, req->src_len, &zctx->cprm);
 	if (zstd_is_error(ret))
 		return -EINVAL;
-	*dst_len = ret;
+	req->dst_len = ret;
 	return 0;
 }
 
-static int zstd_decompress(void *ctx, const unsigned char *src, size_t src_len,
-			   unsigned char *dst, size_t dst_len)
+static int zstd_decompress(void *ctx, struct zcomp_req *req)
 {
 	struct zstd_ctx *zctx = ctx;
 	size_t ret;
 
-	ret = zstd_decompress_dctx(zctx->dctx, dst, dst_len, src, src_len);
+	ret = zstd_decompress_dctx(zctx->dctx, req->dst, req->dst_len,
+				   req->src, req->src_len);
 	if (zstd_is_error(ret))
 		return -EINVAL;
 	return 0;
diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index 173ee2b79442..20ad7b6fe62f 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -119,22 +119,31 @@ void zcomp_stream_put(struct zcomp *comp)
 int zcomp_compress(struct zcomp *comp, struct zcomp_strm *zstrm,
 		   const void *src, unsigned int *dst_len)
 {
-	/* The dst buffer should always be 2 * PAGE_SIZE */
-	size_t dlen = 2 * PAGE_SIZE;
+	struct zcomp_req req = {
+		.src = src,
+		.dst = zstrm->buffer,
+		.src_len = PAGE_SIZE,
+		.dst_len = 2 * PAGE_SIZE,
+	};
 	int ret;
 
-	ret = comp->ops->compress(zstrm->ctx, src, PAGE_SIZE,
-				  zstrm->buffer, &dlen);
+	ret = comp->ops->compress(zstrm->ctx, &req);
 	if (!ret)
-		*dst_len = dlen;
+		*dst_len = req.dst_len;
 	return ret;
 }
 
 int zcomp_decompress(struct zcomp *comp, struct zcomp_strm *zstrm,
 		     const void *src, unsigned int src_len, void *dst)
 {
-	return comp->ops->decompress(zstrm->ctx, src, src_len,
-				     dst, PAGE_SIZE);
+	struct zcomp_req req = {
+		.src = src,
+		.dst = dst,
+		.src_len = src_len,
+		.dst_len = PAGE_SIZE,
+	};
+
+	return comp->ops->decompress(zstrm->ctx, &req);
 }
 
 int zcomp_cpu_up_prepare(unsigned int cpu, struct hlist_node *node)
diff --git a/drivers/block/zram/zcomp.h b/drivers/block/zram/zcomp.h
index 217a750fa908..bbc48094f826 100644
--- a/drivers/block/zram/zcomp.h
+++ b/drivers/block/zram/zcomp.h
@@ -21,12 +21,17 @@ struct zcomp_strm {
 	void *ctx;
 };
 
-struct zcomp_ops {
-	int (*compress)(void *ctx, const unsigned char *src, size_t src_len,
-			unsigned char *dst, size_t *dst_len);
+struct zcomp_req {
+	const unsigned char *src;
+	const size_t src_len;
+
+	unsigned char *dst;
+	size_t dst_len;
+};
 
-	int (*decompress)(void *ctx, const unsigned char *src, size_t src_len,
-			  unsigned char *dst, size_t dst_len);
+struct zcomp_ops {
+	int (*compress)(void *ctx, struct zcomp_req *req);
+	int (*decompress)(void *ctx, struct zcomp_req *req);
 
 	void *(*create_ctx)(struct zcomp_params *params);
 	void (*destroy_ctx)(void *ctx);
-- 
2.46.0.469.g59c65b2a67-goog


