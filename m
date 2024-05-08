Return-Path: <linux-kernel+bounces-172848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8363E8BF774
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 09:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A46781C20D77
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 07:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7A87E0F0;
	Wed,  8 May 2024 07:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LapmttX9"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD187C081
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 07:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715154198; cv=none; b=joWKqFsuMyTkPpsmF1BZUqoQShh4g1CEFfaEk2e0d8tn5FSm1QTER0AbBqALXmk4YCYXiuuZnjWbX2NWM9/752RR77kXbPKsF4WK8C5tjORuAu08UvZq4s5eF1C6zWJQ32wIEzIprBemYPW0o0IVarxNlqfCaGFkp4k4fewbZRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715154198; c=relaxed/simple;
	bh=d3vFRBqQt4rMVioo0/wvp6HT9RZQh4Y89EivFcAwXXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dR6nsu9wntVkiqUw9d/yzzoO2Dct7GB7k6GXynhGEa7avo7fwJpvreQSODEVwY1MKUVB2dZGBygQToGkjU70sXleV/rAYMHp7edvUkTRh3QAusIr6LIbNyW0yhAUHYzVCPP4+Ai2ZBxxLImLz5DkcEczJ9R+PDv4mt5ira8QefU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LapmttX9; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5cdbc4334edso2031099a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 00:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715154195; x=1715758995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UawFcLvcVVuz6l7D9w7wTxKhqDne11bGdAUI9Tc6zcg=;
        b=LapmttX97atai9mkktgyd6PWh7UO+n9kNoZYrhy0fxaJrd7FxhHgl1dOximLiR6pwB
         i84YOGMhpOu01Wpcsecw2DX6M/AuTPr4ntXdfw3xo14H5zAFXlT5GG2ziisTnQLnQMPv
         Pca7Zk8nBkr4UlD5QDWBzRdSvyJXZ9iHp6Mdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715154195; x=1715758995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UawFcLvcVVuz6l7D9w7wTxKhqDne11bGdAUI9Tc6zcg=;
        b=LXYA+Xucau8pv2JRJTANmxbhSF/uvq/F4LnOsWHGjkMrz4Z3aKcieZRLoNvrDoxRYu
         xSBkuIjMEY/A40b9/Y9+Er9njW93/bMjYPmg4GSLd7tNWFxnAQjN0ARUqLwV/zY5mdCi
         rn6Rz7aOSvnkgG3q+ni1L85HRbOYsGIGiOp4hVOVIOldC5krxn8M4GyzwX59p5oHXwHa
         VjLJ3OUdBgaSsKBriouC0d5SG95JwEGk0P5sh8utzH2siMr1s2aqdRI6YKh7Vy/hRc2E
         6FTbHcMiwKpFVyKU+vrgRjpX1V/bKMWPCdrN5mn61Oy2+KC5vK1ssSlYVvHpjIX81r9f
         /fXg==
X-Gm-Message-State: AOJu0Yy8mTXGPNN3PJ57qUQI+Ktqdf0drgWMAJQ+LdsnfU4QtQr7ip+E
	1nVtG/H69vAwUgkwrSdQKCK5J9/CfVBnPjp63UOp1IvkupMxagbnip91jVi/4A==
X-Google-Smtp-Source: AGHT+IGkpZlHcB9WqUD6yMyxsDlX1n4CcJPrejHi03UqRulpJXLYN7DEIDkfCY04As9LHb5/AWDHEw==
X-Received: by 2002:a17:90a:6584:b0:2b3:c011:d28c with SMTP id 98e67ed59e1d1-2b616ae482bmr1652869a91.48.1715154195476;
        Wed, 08 May 2024 00:43:15 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:ad4d:5f6c:6699:2da4])
        by smtp.gmail.com with ESMTPSA id l5-20020a17090aec0500b002b328adaa40sm780011pjy.17.2024.05.08.00.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 00:43:15 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv3 16/19] zram: share dictionaries between per-CPU contexts
Date: Wed,  8 May 2024 16:42:09 +0900
Message-ID: <20240508074223.652784-17-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
In-Reply-To: <20240508074223.652784-1-senozhatsky@chromium.org>
References: <20240508074223.652784-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

zstd's CDict and DDict are accessed read-only during compression
and decompression, so instead of allocation per-context dictionaries
we can create just one CDict and DDict in init_config() and make
per-CPU contexts use them. This saves quite a lot of memory: on my
system CDict requires 408128 bytes and DDict requires 27352 bytes.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/backend_zstd.c | 106 ++++++++++++++++++++----------
 1 file changed, 70 insertions(+), 36 deletions(-)

diff --git a/drivers/block/zram/backend_zstd.c b/drivers/block/zram/backend_zstd.c
index df59584b0337..99115b21c264 100644
--- a/drivers/block/zram/backend_zstd.c
+++ b/drivers/block/zram/backend_zstd.c
@@ -7,14 +7,18 @@
 
 #include "backend_zstd.h"
 
+struct zstd_ctx_data {
+	ZSTD_customMem ctx_mem;
+	ZSTD_CDict *cdict;
+	ZSTD_DDict *ddict;
+};
+
 struct zstd_ctx {
 	zstd_cctx *cctx;
 	zstd_dctx *dctx;
 	void *cctx_mem;
 	void *dctx_mem;
-	ZSTD_customMem ctx_mem;
-	ZSTD_CDict *cdict;
-	ZSTD_DDict *ddict;
+	struct zstd_ctx_data *ctx_data;
 	s32 level;
 };
 
@@ -38,32 +42,81 @@ static void zstd_ctx_free(void *opaque, void *address)
 
 static int zstd_init_config(struct zcomp_config *config)
 {
+	struct zstd_ctx_data *ctx_data = config->private;
+	ZSTD_compressionParameters params;
+
+	/* Already initialized */
+	if (ctx_data)
+		return 0;
+
 	if (config->level == ZCOMP_CONFIG_NO_LEVEL)
 		config->level = ZSTD_defaultCLevel();
 
+	if (config->dict_sz == 0)
+		return 0;
+
+	ctx_data = kzalloc(sizeof(*ctx_data), GFP_KERNEL);
+	if (!ctx_data)
+		return -ENOMEM;
+
+	ctx_data->ctx_mem.customAlloc = zstd_ctx_alloc;
+	ctx_data->ctx_mem.customFree = zstd_ctx_free;
+
+	params = ZSTD_getCParams(config->level, PAGE_SIZE, config->dict_sz);
+
+	ctx_data->cdict = ZSTD_createCDict_advanced(config->dict,
+						    config->dict_sz,
+						    ZSTD_dlm_byRef,
+						    ZSTD_dct_auto,
+						    params,
+						    ctx_data->ctx_mem);
+	if (!ctx_data->cdict)
+		goto error;
+
+	ctx_data->ddict = ZSTD_createDDict_advanced(config->dict,
+						    config->dict_sz,
+						    ZSTD_dlm_byRef,
+						    ZSTD_dct_auto,
+						    ctx_data->ctx_mem);
+	if (!ctx_data->ddict)
+		goto error;
+
+	config->private = ctx_data;
 	return 0;
+
+error:
+	ZSTD_freeCDict(ctx_data->cdict);
+	ZSTD_freeDDict(ctx_data->ddict);
+	kfree(ctx_data);
+	return -EINVAL;
 }
 
 static void zstd_release_config(struct zcomp_config *config)
 {
+	struct zstd_ctx_data *ctx_data = config->private;
+
+	if (!ctx_data)
+		return;
+
+	config->private = NULL;
+	ZSTD_freeCDict(ctx_data->cdict);
+	ZSTD_freeDDict(ctx_data->ddict);
+	kfree(ctx_data);
 }
 
 static void zstd_destroy(void *ctx)
 {
 	struct zstd_ctx *zctx = ctx;
 
+	/* Don't free zctx->ctx_data, it's done in release_config() */
 	if (zctx->cctx_mem)
 		vfree(zctx->cctx_mem);
 	else
 		ZSTD_freeCCtx(zctx->cctx);
-
 	if (zctx->dctx_mem)
 		vfree(zctx->dctx_mem);
 	else
 		ZSTD_freeDCtx(zctx->dctx);
-
-	ZSTD_freeCDict(zctx->cdict);
-	ZSTD_freeDDict(zctx->ddict);
 	kfree(zctx);
 }
 
@@ -75,9 +128,8 @@ static void *zstd_create(struct zcomp_config *config)
 	if (!ctx)
 		return NULL;
 
+	ctx->ctx_data = config->private;
 	ctx->level = config->level;
-	ctx->ctx_mem.customAlloc = zstd_ctx_alloc;
-	ctx->ctx_mem.customFree = zstd_ctx_free;
 
 	if (config->dict_sz == 0) {
 		zstd_parameters params;
@@ -102,35 +154,15 @@ static void *zstd_create(struct zcomp_config *config)
 		if (!ctx->dctx)
 			goto error;
 	} else {
-		ZSTD_compressionParameters params;
+		struct zstd_ctx_data *ctx_data = ctx->ctx_data;
 
-		ctx->cctx = ZSTD_createCCtx_advanced(ctx->ctx_mem);
+		ctx->cctx = ZSTD_createCCtx_advanced(ctx_data->ctx_mem);
 		if (!ctx->cctx)
 			goto error;
 
-		ctx->dctx = ZSTD_createDCtx_advanced(ctx->ctx_mem);
+		ctx->dctx = ZSTD_createDCtx_advanced(ctx_data->ctx_mem);
 		if (!ctx->dctx)
 			goto error;
-
-		params = ZSTD_getCParams(ctx->level, PAGE_SIZE,
-					 config->dict_sz);
-
-		ctx->cdict = ZSTD_createCDict_advanced(config->dict,
-						       config->dict_sz,
-						       ZSTD_dlm_byRef,
-						       ZSTD_dct_auto,
-						       params,
-						       ctx->ctx_mem);
-		if (!ctx->cdict)
-			goto error;
-
-		ctx->ddict = ZSTD_createDDict_advanced(config->dict,
-						       config->dict_sz,
-						       ZSTD_dlm_byRef,
-						       ZSTD_dct_auto,
-						       ctx->ctx_mem);
-		if (!ctx->ddict)
-			goto error;
 	}
 
 	return ctx;
@@ -144,15 +176,16 @@ static int zstd_compress(void *ctx, const unsigned char *src,
 			 unsigned char *dst, size_t *dst_len)
 {
 	struct zstd_ctx *zctx = ctx;
+	struct zstd_ctx_data *ctx_data = zctx->ctx_data;
 	const zstd_parameters params = zstd_get_params(zctx->level, PAGE_SIZE);
 	size_t ret;
 
-	if (!zctx->cdict)
+	if (!ctx_data)
 		ret = zstd_compress_cctx(zctx->cctx, dst, *dst_len,
 					 src, PAGE_SIZE, &params);
 	else
 		ret = ZSTD_compress_usingCDict(zctx->cctx, dst, *dst_len,
-					       src, PAGE_SIZE, zctx->cdict);
+					       src, PAGE_SIZE, ctx_data->cdict);
 	if (zstd_is_error(ret))
 		return -EINVAL;
 	*dst_len = ret;
@@ -163,14 +196,15 @@ static int zstd_decompress(void *ctx, const unsigned char *src, size_t src_len,
 			   unsigned char *dst)
 {
 	struct zstd_ctx *zctx = ctx;
+	struct zstd_ctx_data *ctx_data = zctx->ctx_data;
 	size_t ret;
 
-	if (!zctx->ddict)
+	if (!ctx_data)
 		ret = zstd_decompress_dctx(zctx->dctx, dst, PAGE_SIZE,
 					   src, src_len);
 	else
 		ret = ZSTD_decompress_usingDDict(zctx->dctx, dst, PAGE_SIZE,
-						 src, src_len, zctx->ddict);
+						 src, src_len, ctx_data->ddict);
 	if (zstd_is_error(ret))
 		return -EINVAL;
 	return 0;
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


