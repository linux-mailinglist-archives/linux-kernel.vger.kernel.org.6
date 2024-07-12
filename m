Return-Path: <linux-kernel+bounces-250187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EF492F503
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 07:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E0E91C2092E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 05:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499EB1386D7;
	Fri, 12 Jul 2024 05:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bPBqQS4Y"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440CC137901
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 05:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720761585; cv=none; b=CIcrgiQ/vP/t8vRJ0CXlub0D1VOgdDG70lTfMwJH3KGPyjlv9EK5EsApGWuBgSAm9PCciObIPN3OpfCPoGAzXKwa5al4XwWEj0TmAYga+c9ElFD1TCWwjgj9iK44JdzcsnHHbG+Jwpb52mbfRMtVcAlNkguEbWJzRWAozuIXrHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720761585; c=relaxed/simple;
	bh=l4/IxLpUw1QO7VMnaZsULGvU4FmgUSJC4An3ek2IBeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JPqZlqIZWpTPc5MDCcF1QpNfITbWPTfwmLuyHd6zF8AMpzaHWUv1Mjwe3Rj0lXFci4gEoqXSa6Y0vqR9D1ejKa9tma6hJOGQZr3KHYsNz9rerqCrwkV2XdQlwUN5E1E71J/+aI3mqEthUA7Xg7eedJAYmzL+3cAmfDi6NrmdkBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bPBqQS4Y; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-70362cb061aso867988a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 22:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720761582; x=1721366382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nAQgpqXzaJO10Nk1DwxHPOG0IMSJ77oGcu6vgn4Dxlg=;
        b=bPBqQS4YmvYylag0csPnwi7XFcyckdFd/sIz3YlyteNbmw8JeYzDgKVxhRSFtuN7GY
         O1yjc1CxzdKVmvQEUNcceibs4iOOe+27Zw0OjWWsmQW041WPS91dWU/MTkkKRZdWaJwj
         fHaTpBIeAP14ZIGG/muPih0BmSa0wAx7ln+fY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720761582; x=1721366382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nAQgpqXzaJO10Nk1DwxHPOG0IMSJ77oGcu6vgn4Dxlg=;
        b=f/6h4fJmL7r8GSIu3yVtNQF4KnlAOZEHXWRDhns6hUx5xqUZNESlhdCbzZRZl3UTzi
         EeVAXOfSaA6tT7oKVbpLnxA67TZlZMurvGRNdcC+sMfKMdxb96Wi4kXgSGJzWAaV1nlf
         w8mHyjLm4olLK03bniXGd7zxDcdfE56VI8jexk0jEKd6yeNQey3Mc8hpUJVnpe+WY3+1
         EIdW2FHeuZs7RDGtUuzUg50VOb7jRJpSCJ666hpa6AkGuJUDobx6TXRtoFJ5ZHtsrCei
         4vKue7NBk2CfwepqxRyztavdcnrl2RH+LI2Fn39Ly2aUG0wzO0MsURj2f2GR+KSkh9cy
         h8xQ==
X-Gm-Message-State: AOJu0YzlX+gi1qIoXdHTf1wJnVRPa4exc4J/3DZ0TeBlgYlsVb2/SL1C
	/UnEF7u5MT4/1iWJ8iMqDGav8jj7t4T5e7tXVROP1yaEWc+cRcHy1ayjgJ0G/g==
X-Google-Smtp-Source: AGHT+IEc1r5bDPc07EXzlyk5Hz9rD6FQc+sV+F5jHTRNKFjKRlFj/GuGeUcOdyV+3dlKjJ815V6O3A==
X-Received: by 2002:a05:6830:1088:b0:704:49c0:65f0 with SMTP id 46e09a7af769-70449c06716mr7182298a34.3.1720761582223;
        Thu, 11 Jul 2024 22:19:42 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:15f3:5252:ec56:52ae])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b43967851sm6553436b3a.109.2024.07.11.22.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 22:19:41 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v6 17/23] zram: introduce zcomp_req structure
Date: Fri, 12 Jul 2024 14:18:28 +0900
Message-ID: <20240712051850.484318-18-senozhatsky@chromium.org>
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
index 08c51f33b5d9..5048087390ea 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -118,22 +118,31 @@ void zcomp_stream_put(struct zcomp *comp)
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
2.45.2.993.g49e7a77208-goog


