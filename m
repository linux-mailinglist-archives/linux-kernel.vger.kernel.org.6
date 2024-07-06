Return-Path: <linux-kernel+bounces-243053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6B09290FB
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 07:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A84A1F23321
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 05:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD43A17BD3;
	Sat,  6 Jul 2024 04:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WZEDpYpS"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C571D12B17C
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 04:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720241850; cv=none; b=t4Yk0FT6VnOyB2vkrBFGDyXoc9nR9pQG4KO6xkuJT8aYpqsI9LKPd+me3Wt7qfRVwldfAWreuascYtJMBb8Pups59pa6dT5LOXhHTjU0BEvEWoLiqB8YH21tmRftyO8h/xyjQE1SJ8+RSo74myPXUCMsDvVeKGNoNvg+BN9PoXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720241850; c=relaxed/simple;
	bh=HzeaU/l84JP69XEkeHwGz11Ln21m1tk3zMDEPKfzAt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VDdgM0o7y81EPirVbqVKjgbzKqoUveUkfYreuT8AThoMh0AwPCr0ywWgqaQEDfuvR9Ivao6k2VEOmbYPHwlLoEI+Pcck0YjI7G7Lz3aDFeW+ZYrki0CzflIPXTf0jaBBB2EHT00kAxuhUNt2UTg/Wf5DqfnnhBbeo2frjSTE6mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WZEDpYpS; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e035ecb35ffso2104150276.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 21:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720241848; x=1720846648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tH44H1TVzwAUobTzGL/ZANlz+pOfAMXef1PqW4dbSJQ=;
        b=WZEDpYpSY1F0lcAnlzCF7WlbLWnh3MlA1DdZOrWhtEfXfVrCWax3H9kWvqEtGQCsrS
         IBWmogAdcxVcHwtS/I8HOC9JIyes4rLCODaca7hXhvWSRS7ur32YQXiyL/SLeyc5g+PD
         t+Xe2XV8XvDxPnAxI160GjbYQA7FMiFuvafgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720241848; x=1720846648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tH44H1TVzwAUobTzGL/ZANlz+pOfAMXef1PqW4dbSJQ=;
        b=w+TlEI9hyElnNWcMpF2SdqvTvVRduIDdFQEsf72Ia0umBQPHNRnGUeWB3fmc6gGmgs
         YR9reE4pffRLoBfKjtptKxW29Mfhj1JO/zpHQfuYA+yyGsnB9Rvft1zQqfRC9PVyAeqo
         AqdQM21hWS38WgVC9i6JQtNhMXNYW15QTkHvedxUECdyqu7FjkST/UkU4Gt2CapmYovS
         nFtcLj5m2kpguKcf0ooNNACffqzv6XA0c+hsmOKzVCXUXvAJcLAFMlq/9mJ6d8RlRzZL
         mDLydsWOBsOo1LPpRy5i5feQFxlh9tG66gon4uxqiU1RWgeOu6Ec/0Q8bmvWM5ImtviS
         ByuA==
X-Gm-Message-State: AOJu0YyaHEUGwVFi/qk5OJcWa6S1xFUPsUENtvbsZ335bOAt5u//fzyO
	x+x5Y4DY6mJERXeKVh7zuU75xH0W7mcIJagNTabOTiqGWfNllne4JhEINPZ9uA==
X-Google-Smtp-Source: AGHT+IHAkGII32UrL24EsLKuvJnI3yDPAlt44SMYXQKHtOowtgYRy3I1lOMgE6pU+D5tGMvsZ5DR0Q==
X-Received: by 2002:a25:9246:0:b0:e03:ab72:fe71 with SMTP id 3f1490d57ef6-e03c1933997mr6310661276.10.1720241847684;
        Fri, 05 Jul 2024 21:57:27 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:88a7:e7d7:713d:ff09])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7623cd854b2sm2784104a12.38.2024.07.05.21.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 21:57:27 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv5 17/23] zram: introduce zcomp_req structure
Date: Sat,  6 Jul 2024 13:56:19 +0900
Message-ID: <20240706045641.631961-18-senozhatsky@chromium.org>
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
index 9193391626a9..1df0de5a9863 100644
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
 
 struct zcomp_ops backend_842 = {
diff --git a/drivers/block/zram/backend_deflate.c b/drivers/block/zram/backend_deflate.c
index 415ab55f8aeb..19bb61369eb0 100644
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
index 90801a7a8f75..cb623f16604e 100644
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
index 30de6ec511a5..a2314e4c7e9a 100644
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
index c903c15610f8..48d3f051c258 100644
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
index 3622625abfd9..4638431326c2 100644
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
index a9808abcf5f2..7e7e4af620fc 100644
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
index eacead28cc2b..defb04a25d52 100644
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
index 3639c36fb9a9..963c1e80830c 100644
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
2.45.2.803.g4e1b14247a-goog


