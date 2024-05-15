Return-Path: <linux-kernel+bounces-179567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F2A8C6181
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 09:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8843B281B88
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 07:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CF16A008;
	Wed, 15 May 2024 07:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Xdt8p9hv"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AE3481A7
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 07:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715757455; cv=none; b=txYigFw4n5GZYVZSTB/Z8zrMh6x90pgxiLaNgl1cA42dGvYiX5M+ZFNzbLL1aMA9cbpbZ9K1kiOr5QbIfHBEmBSwSoRzxWwX4+K29cdbuGSDSX/NC+xwmsbl18CruYeagIfzqWeNsQZVvNUExzfVCRAiM11PaF+K5UF+0tp3qN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715757455; c=relaxed/simple;
	bh=qPxpMzrLexeajXOvydJh+v3ubpdPbmLqWgxknedh2Uk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UGpXADOfB3rCuy0yX+UHN27XAHMOr8ze8d4ceVDr3GeRAL8W1+xk6pQzfZPpsWOyIbHacGMYNGHC+1IkzvjoBMeomQOnEWPfYpXb/t3s5yV7CkaEsaLGLGDliwNvhv0b9UfFZdAIEKwKvMEkVMGqhPzsoH0p9Sz/ULdLbtmLdB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Xdt8p9hv; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso4724081a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 00:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715757453; x=1716362253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e1Q92/50oEzsFAIXeAasi/lhjVaiDz6wVjSMUCSkV98=;
        b=Xdt8p9hvR9TFDNsREHSqFGtB4LrvWY6k3grut4Jh2mc67rjUSKE6UncsmCO6Lc5F/q
         7q8FhbvOcx+XLoPR+yglbhlOfFlycwo9lgVqS6Mmdfvvvw5icjO9/p1zNM5frFZNuulB
         QBXRdiJqUWmsdPOCwa8nlNr3UmFwQCV1tiXL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715757453; x=1716362253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e1Q92/50oEzsFAIXeAasi/lhjVaiDz6wVjSMUCSkV98=;
        b=M4Ifgkbehn0L1gJ4lRLybmMRua2CP+jwSuUIfRJxq1VR2cIFnsals+eGVRFHJwd1Bj
         OpvBp7eTDIfpMab+NdcKmu1cTzrom4z9ENdcjtuytUct5JdCmyaNA3lemtyhEjMFSDwl
         K3sFbCNH1Q3HFs1+aFQ15Yr88P7SC6BwHEZ+8GWd7OCO9sm0FUdAEFMH6wig8ttb0oZC
         8t+lElWJIqYWEs5ehtMMrycM+90t7NRiW2aZ74ofNZLLyO9GcqOPjf54Z8989yGs16fY
         WHcEWwW5A+IM5m6mGpf2daqJsW3D3K5WwH5xdM6EXJVa7HKXC1MbmAWXnCLOLtj0kPgU
         nJeg==
X-Gm-Message-State: AOJu0YzjS6MrBsHO9v+V8HNUlPwUdLeinMB/VS8sIZaWjZZ6KIQzWq1C
	90Z7FkfdvOkvZRfLo0ZiqdehOr+10gbXvmeOpjGVYubCcDhSR2pgVorY16mb+g==
X-Google-Smtp-Source: AGHT+IFoXN+G8OBVIyHl2dhkr+cK7yJTsa+IDe8Y4EgCK8SM3Nz6RhZgJrZp6Vf7WOYHuo5IjVDf2g==
X-Received: by 2002:a05:6a20:5504:b0:1a9:8152:5102 with SMTP id adf61e73a8af0-1afde0d54c9mr14256096637.24.1715757453236;
        Wed, 15 May 2024 00:17:33 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:111d:a618:3172:cd5b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c136d53sm110941605ad.254.2024.05.15.00.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 00:17:32 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv4 15/21] zram: add dictionary support to zstd backend
Date: Wed, 15 May 2024 16:12:52 +0900
Message-ID: <20240515071645.1788128-16-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
In-Reply-To: <20240515071645.1788128-1-senozhatsky@chromium.org>
References: <20240515071645.1788128-1-senozhatsky@chromium.org>
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

TEST
====

- default zstd

/sys/block/zram0/mm_stat
1750315008 504602831 514256896        0 514256896        1        0    34204    34204

- zstd level=7 dict=/etc/dictionary

/sys/block/zram0/mm_stat
1750310912 432540606 441712640        0 441712640        1        0    34187    34187

[1] https://github.com/facebook/zstd/blob/dev/programs/zstd.1.md#dictionary-builder

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/backend_zstd.c | 126 ++++++++++++++++++++++++------
 1 file changed, 101 insertions(+), 25 deletions(-)

diff --git a/drivers/block/zram/backend_zstd.c b/drivers/block/zram/backend_zstd.c
index d392d364ad2c..4be149370e0b 100644
--- a/drivers/block/zram/backend_zstd.c
+++ b/drivers/block/zram/backend_zstd.c
@@ -12,23 +12,52 @@ struct zstd_ctx {
 	zstd_dctx *dctx;
 	void *cctx_mem;
 	void *dctx_mem;
+	zstd_custom_mem ctx_mem;
+	zstd_cdict *cdict;
+	zstd_ddict *ddict;
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
+		zstd_free_cctx(zctx->cctx);
+
+	if (zctx->dctx_mem)
+		vfree(zctx->dctx_mem);
+	else
+		zstd_free_dctx(zctx->dctx);
+
+	zstd_free_cdict(zctx->cdict);
+	zstd_free_ddict(zctx->ddict);
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
 		ctx->level = zstd_default_clevel();
 
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
+		zstd_compression_parameters params;
+
+		ctx->cctx = zstd_create_cctx_advanced(ctx->ctx_mem);
+		if (!ctx->cctx)
+			goto error;
+
+		ctx->dctx = zstd_create_dctx_advanced(ctx->ctx_mem);
+		if (!ctx->dctx)
+			goto error;
+
+		params = zstd_get_cparams(ctx->level, PAGE_SIZE,
+					  config->dict_sz);
+
+		ctx->cdict = zstd_create_cdict_advanced(config->dict,
+							config->dict_sz,
+							ZSTD_dlm_byRef,
+							ZSTD_dct_auto,
+							params,
+							ctx->ctx_mem);
+		if (!ctx->cdict)
+			goto error;
+
+		ctx->ddict = zstd_create_ddict_advanced(config->dict,
+							config->dict_sz,
+							ZSTD_dlm_byRef,
+							ZSTD_dct_auto,
+							ctx->ctx_mem);
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
+		ret = zstd_compress_using_cdict(zctx->cctx, dst, *dst_len,
+						src, PAGE_SIZE, zctx->cdict);
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
+		ret = zstd_decompress_using_ddict(zctx->dctx, dst, PAGE_SIZE,
+						  src, src_len, zctx->ddict);
 	if (zstd_is_error(ret))
 		return -EINVAL;
 	return 0;
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


