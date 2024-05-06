Return-Path: <linux-kernel+bounces-169459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA128BC8F7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 10:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 136E6280DF2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 08:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925F61448FF;
	Mon,  6 May 2024 07:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a22O3M7h"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5341448D2
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 07:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714982365; cv=none; b=SfoU3F4FMtkVhrSJAT36+AbDuC3DSw2UMNByriUqzRBXvwAJGJFywgYWiJ2J4o0HFPuDtZ9RIo16Sglqzaevr5t0DtrHl4OrqyAxlaLqZHEiZy8REiUzMLftyAAl+5fw+TZRkY23JJW9zdE/VauM4YXtZ7cW241xozel60rE/i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714982365; c=relaxed/simple;
	bh=d3vFRBqQt4rMVioo0/wvp6HT9RZQh4Y89EivFcAwXXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nsYJemnbEHedgG1hjllNzO+XL8tQfBZq+v/1ga4+4vt8Geh33VdN0hB8qMIGutx+6IBK5Cnx+tDyTWREKlzHaiTu1wLlz42z+gno0GgnSFaGPGzYod8sq3JmSlql5cNVvD57PgcoAArGjfdZnXXb1oXsO8sROHfMZ+ufoXFLSFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=a22O3M7h; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1ec41d82b8bso15057785ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 00:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714982363; x=1715587163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UawFcLvcVVuz6l7D9w7wTxKhqDne11bGdAUI9Tc6zcg=;
        b=a22O3M7hgUiDPYJIGXlyVHQidISMahs7I3evFaWbwdIjJcy83YHo79I1jgi8TvMC0H
         fhu4fSQuEG1DyBtwmsvUK8n3CD+OnBZYgtv1u8ALYxcyKazYycvEKfAZfi0FqYm9UgqN
         fXYvpenhLgVgQko/Ay9VJtmD0vIHr7E015k9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714982363; x=1715587163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UawFcLvcVVuz6l7D9w7wTxKhqDne11bGdAUI9Tc6zcg=;
        b=dC8gTdO+FsKv9sxbTt3nv3RVOhcTXvEY6RM0A3+TTHlkZ26DGdoJ7K4nEMYDIszfLr
         xqxZGjieSl4JtgkOjrDQfv46BvQucoCgV/TAGNJlJBKPkOgy3DrMBpJ1fF3Y0aaw2bQ7
         FuKc01CU/kH8FHJ+yFdD1+wES7+KVCCdVCGplMSn5Sdt6upGFDRgtUiumdjJq/pH5mKW
         rlEk3Gxu2XqjtqL5uuRQ/avO1Nq0RRQBHNdBBkDlAguScrQCRRJKQ0BPIL1oZrdUFC+a
         JowT+7ew10pWYwAIpFRvz2eXyAjmkEPwLPCmKxPt4E6/1bddPLnCn7CWQXbUAS/A3u7K
         7lMg==
X-Gm-Message-State: AOJu0YznkztwaD9chRcy2c8fIbST1xgfKO6A9Mu+qV4VpB369GKtywxT
	5wp+kafby7qjGROxe7a7Qu5rSzWoPgJXpIqqjvdBvGXZun/caxsegAtWfQst2XyBiQcC0dptuiU
	=
X-Google-Smtp-Source: AGHT+IHmZ+eYgC3Tq1EfdPkOv57BYc61jK6mkSfnt3zGgOMiuOEVcQPHHosKuKLxkmgHUlN/n5sCSQ==
X-Received: by 2002:a17:902:eb91:b0:1ee:2a58:cb7c with SMTP id q17-20020a170902eb9100b001ee2a58cb7cmr1021125plg.35.1714982363738;
        Mon, 06 May 2024 00:59:23 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:4e24:10c3:4b65:e126])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902f54600b001ec64b128dasm7633772plf.129.2024.05.06.00.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 00:59:23 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2 16/17] zram: share dictionaries between per-CPU contexts
Date: Mon,  6 May 2024 16:58:29 +0900
Message-ID: <20240506075834.302472-17-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
In-Reply-To: <20240506075834.302472-1-senozhatsky@chromium.org>
References: <20240506075834.302472-1-senozhatsky@chromium.org>
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


