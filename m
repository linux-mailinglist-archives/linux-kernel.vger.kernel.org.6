Return-Path: <linux-kernel+bounces-169457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 440468BC8ED
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 10:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67B291C21457
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 08:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2386E14430B;
	Mon,  6 May 2024 07:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K2Lgl7ZY"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA87143C65
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 07:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714982361; cv=none; b=oI590dtsb40/1zrLWoX3mvHLvCYHkDQxPMimvoBZol6uLygUbhOmYK6stiGTPouP8Qyy3MalQ6RRwA9o4cc4bQXvy6Bj359gaoKmjQrSw9qPUlfrzYF7YsZZSzssAwF8L3cjcHmVIpgakjB9W0SfXm0SellDstgmjKw+S4Kub3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714982361; c=relaxed/simple;
	bh=09Ka/tk/DAZP8tzeuC9sVbqY92/WnQ147E6Hm/AJ2rM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e9t0p+rxlnLjcr30aXRZcsLt/LdTU1Azv5IdFfQPvQSs5D17GMYm7564HvmR0Y1v7YMqc+XlWNl7zjVsAwQBOR2dchQCzMVTo7MBSgTH4Wxd/pJOqQE9PnlXN5L4xbnU7ws4CPCNtoXvla+y3R+IYgeUZ54ZEPp+QIp0WkSq4Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=K2Lgl7ZY; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6f447976de7so1056398b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 00:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714982359; x=1715587159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=670BJqB3qXgoYBmu7ZZ2F7xy6czndExLjXYSSS9otVc=;
        b=K2Lgl7ZYYtDjnluEJHFLSJ6UBxSfbOLFbckpF+REUbxISR5F0e8gF7ddRxBD9L13s+
         jJqAa2WW22YbYVkIrxBg5A0xoYdhSnOM78bdaNoAP4SqTqVxq4DepS3yOOJ9pqagZEdC
         RZ/9oycRECn0oc9obL3Djpcm4oMV6TCZiwNpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714982359; x=1715587159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=670BJqB3qXgoYBmu7ZZ2F7xy6czndExLjXYSSS9otVc=;
        b=VeTVHa93bS8gh3R6xxHvbyNijN0MexZhuvN1lUnZ4slorWhdkF780mUtwFcSoX9mri
         nyX1HsNlrkdC7hqbBdWJi0BtmkX0x5BLVcnRdrOPJZ0QQ/eErR/ktAMPF/SXO6MkQf3a
         ZMnpzeaFM8ASD8psoa3ZmjJLMTlN7KTQcNPffW9bxWwDsmlvlP/4vJp8luGcE9EmgZoU
         CG40lIcr+XTN+1WISYP8wHnYdc11W6nPp+PTKXcR5RvHggSvjGGHFWtJUNFPy0VhO8HX
         NQCt/SfriwZezNUK20sUDtwrdS56l6ZIV89elmh1FbrkeW5q8MQ/jJuErZFpg4gDAuo0
         SoFw==
X-Gm-Message-State: AOJu0Yzw+Mz4cz8dA+ci4WR6znYrAL5H4lobbxCPORMn6YNs4Vl5F1lP
	zSRPsKr8xqURatG8uEZpryepycO5cKl5OJOFW60iVHB8PYJP7ktcBqHmi/Yf5A==
X-Google-Smtp-Source: AGHT+IFqCS/72gy51F3U0CaV8OqKEWsZufjlSXQ1lFbeGQE7NGOdqaTAIrBnsi3YpuEUHmqREUCqnA==
X-Received: by 2002:a05:6a20:8410:b0:1ae:3f11:328e with SMTP id c16-20020a056a20841000b001ae3f11328emr9298805pzd.20.1714982359296;
        Mon, 06 May 2024 00:59:19 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:4e24:10c3:4b65:e126])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902f54600b001ec64b128dasm7633772plf.129.2024.05.06.00.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 00:59:18 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2 14/17] zram: add dictionary support to zstd backend
Date: Mon,  6 May 2024 16:58:27 +0900
Message-ID: <20240506075834.302472-15-senozhatsky@chromium.org>
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

This adds support for pre-trained zstd dictionaries [1]
Dictionary is loaded once (per-config) and then loaded to Cctx
and Dctx by reference, so we don't allocate extra memory.

Regarding GFP_ATOMIC in Cctx customAlloc(), we probably would
want to do something about it. Either make sure that we always
(somehow) fully setup all Cctx contexts from non-atomic context
before we attempt to use them, come up with some sort of custom
allocator or stop calling zcomp_compress() from atomic context.

[1] https://github.com/facebook/zstd/blob/dev/programs/zstd.1.md#dictionary-builder

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/backend_zstd.c | 126 ++++++++++++++++++++++++------
 1 file changed, 101 insertions(+), 25 deletions(-)

diff --git a/drivers/block/zram/backend_zstd.c b/drivers/block/zram/backend_zstd.c
index b2fb94902bef..006d0f40617d 100644
--- a/drivers/block/zram/backend_zstd.c
+++ b/drivers/block/zram/backend_zstd.c
@@ -12,23 +12,52 @@ struct zstd_ctx {
 	zstd_dctx *dctx;
 	void *cctx_mem;
 	void *dctx_mem;
+	ZSTD_customMem ctx_mem;
+	ZSTD_CDict *cdict;
+	ZSTD_DDict *ddict;
 	s32 level;
 };
 
+/*
+ * Cctx allocator.customAlloc() can be called from zcomp_compress() under
+ * local-lock (per-CPU compression stream), in which case we must use
+ * GFP_ATOMIC.
+ */
+static void *zstd_ctx_alloc(void *opaque, size_t size)
+{
+	if (!preemptible())
+		return kvzalloc(size, GFP_ATOMIC);
+
+	return kvzalloc(size, GFP_KERNEL);
+}
+
+static void zstd_ctx_free(void *opaque, void *address)
+{
+	kvfree(address);
+}
+
 static void zstd_destroy(void *ctx)
 {
 	struct zstd_ctx *zctx = ctx;
 
-	vfree(zctx->cctx_mem);
-	vfree(zctx->dctx_mem);
+	if (zctx->cctx_mem)
+		vfree(zctx->cctx_mem);
+	else
+		ZSTD_freeCCtx(zctx->cctx);
+
+	if (zctx->dctx_mem)
+		vfree(zctx->dctx_mem);
+	else
+		ZSTD_freeDCtx(zctx->dctx);
+
+	ZSTD_freeCDict(zctx->cdict);
+	ZSTD_freeDDict(zctx->ddict);
 	kfree(zctx);
 }
 
 static void *zstd_create(struct zcomp_config *config)
 {
-	zstd_parameters params;
 	struct zstd_ctx *ctx;
-	size_t sz;
 
 	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
@@ -39,24 +68,62 @@ static void *zstd_create(struct zcomp_config *config)
 	else
 		ctx->level = ZSTD_defaultCLevel();
 
-	params = zstd_get_params(ctx->level, PAGE_SIZE);
-	sz = zstd_cctx_workspace_bound(&params.cParams);
-	ctx->cctx_mem = vzalloc(sz);
-	if (!ctx->cctx_mem)
-		goto error;
-
-	ctx->cctx = zstd_init_cctx(ctx->cctx_mem, sz);
-	if (!ctx->cctx)
-		goto error;
-
-	sz = zstd_dctx_workspace_bound();
-	ctx->dctx_mem = vzalloc(sz);
-	if (!ctx->dctx_mem)
-		goto error;
-
-	ctx->dctx = zstd_init_dctx(ctx->dctx_mem, sz);
-	if (!ctx->dctx)
-		goto error;
+	ctx->ctx_mem.customAlloc = zstd_ctx_alloc;
+	ctx->ctx_mem.customFree = zstd_ctx_free;
+
+	if (config->dict_sz == 0) {
+		zstd_parameters params;
+		size_t sz;
+
+		params = zstd_get_params(ctx->level, PAGE_SIZE);
+		sz = zstd_cctx_workspace_bound(&params.cParams);
+		ctx->cctx_mem = vzalloc(sz);
+		if (!ctx->cctx_mem)
+			goto error;
+
+		ctx->cctx = zstd_init_cctx(ctx->cctx_mem, sz);
+		if (!ctx->cctx)
+			goto error;
+
+		sz = zstd_dctx_workspace_bound();
+		ctx->dctx_mem = vzalloc(sz);
+		if (!ctx->dctx_mem)
+			goto error;
+
+		ctx->dctx = zstd_init_dctx(ctx->dctx_mem, sz);
+		if (!ctx->dctx)
+			goto error;
+	} else {
+		ZSTD_compressionParameters params;
+
+		ctx->cctx = ZSTD_createCCtx_advanced(ctx->ctx_mem);
+		if (!ctx->cctx)
+			goto error;
+
+		ctx->dctx = ZSTD_createDCtx_advanced(ctx->ctx_mem);
+		if (!ctx->dctx)
+			goto error;
+
+		params = ZSTD_getCParams(ctx->level, PAGE_SIZE,
+					 config->dict_sz);
+
+		ctx->cdict = ZSTD_createCDict_advanced(config->dict,
+						       config->dict_sz,
+						       ZSTD_dlm_byRef,
+						       ZSTD_dct_auto,
+						       params,
+						       ctx->ctx_mem);
+		if (!ctx->cdict)
+			goto error;
+
+		ctx->ddict = ZSTD_createDDict_advanced(config->dict,
+						       config->dict_sz,
+						       ZSTD_dlm_byRef,
+						       ZSTD_dct_auto,
+						       ctx->ctx_mem);
+		if (!ctx->ddict)
+			goto error;
+	}
 
 	return ctx;
 
@@ -72,8 +139,12 @@ static int zstd_compress(void *ctx, const unsigned char *src,
 	const zstd_parameters params = zstd_get_params(zctx->level, PAGE_SIZE);
 	size_t ret;
 
-	ret = zstd_compress_cctx(zctx->cctx, dst, *dst_len,
-				 src, PAGE_SIZE, &params);
+	if (!zctx->cdict)
+		ret = zstd_compress_cctx(zctx->cctx, dst, *dst_len,
+					 src, PAGE_SIZE, &params);
+	else
+		ret = ZSTD_compress_usingCDict(zctx->cctx, dst, *dst_len,
+					       src, PAGE_SIZE, zctx->cdict);
 	if (zstd_is_error(ret))
 		return -EINVAL;
 	*dst_len = ret;
@@ -86,7 +157,12 @@ static int zstd_decompress(void *ctx, const unsigned char *src, size_t src_len,
 	struct zstd_ctx *zctx = ctx;
 	size_t ret;
 
-	ret = zstd_decompress_dctx(zctx->dctx, dst, PAGE_SIZE, src, src_len);
+	if (!zctx->ddict)
+		ret = zstd_decompress_dctx(zctx->dctx, dst, PAGE_SIZE,
+					   src, src_len);
+	else
+		ret = ZSTD_decompress_usingDDict(zctx->dctx, dst, PAGE_SIZE,
+						 src, src_len, zctx->ddict);
 	if (zstd_is_error(ret))
 		return -EINVAL;
 	return 0;
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


