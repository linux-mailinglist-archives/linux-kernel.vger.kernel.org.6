Return-Path: <linux-kernel+bounces-172849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B818BF776
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 09:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E304F1F2138C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 07:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0647E767;
	Wed,  8 May 2024 07:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BklmlNhU"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A767D419
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 07:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715154200; cv=none; b=hSux0uXzT3fG2xKTr9tbMa2rbsg13/fMXuhopJXAA2Zd1f81FgNoCKVBPc9lPoR4JQu2Nhs+RmuoUNF5Tv0jhm5mqf/UGijrULs9GfjMBWJjW65+4+7aeWKucz//S3Na1H7l3OynZclG9L7TZNk5/U1WIhjry4O7cXpSjrSZQBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715154200; c=relaxed/simple;
	bh=cIuDRIJ4nUfk74gqjSPgbW11lj17tju3W5di3bnGXlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k9S9zyuGajempKzeXXrqTMvCcsvZBqNFUMnjc+NgAwKrlMM2+eZLE5V04F1Oks1WldhfnkPvuZAdxXTsO8UvCJvXbg8uzNe2pvxDCtat4vhVi1Q92PxRufbsOUmCEuXcNIOIiHxwe0JM1v6ei5HkelmB/u/NszaHg7XsRgBEJp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BklmlNhU; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5dca1efad59so3173985a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 00:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715154198; x=1715758998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aM4w/1Tu/L1seDE9eZUHI5/Rr3RZ+Tacd81KpjjZOe8=;
        b=BklmlNhUbOHzYIwk5uFuRWHwsCkrhaPL1t9eZjF6jIR/z6721CLZJoIlT5yO3IQgJs
         FSmFsFRXWOmjqfCce2GaSJHPzwcCoh8FHGCXl/R17BdxwiFU1N9bhyeZ4JeZ/Kh5fG4J
         PiPJVvlEgtZfjebR+C/SGFJ0YS5zCnZdhsjm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715154198; x=1715758998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aM4w/1Tu/L1seDE9eZUHI5/Rr3RZ+Tacd81KpjjZOe8=;
        b=B0SczKMlbSTPaqyESKjQ7qYFe6TvUzIO/2aCZzN/66HAWesS+rjUI6jRnE2YiZ3eKn
         70Ku+FksEzgzDzlQ1luBWBMVMZTDOca+Ylidrb5aRupupQTEHuwV77S4/r8w6J5u+0mh
         8E8w0fdw/pTI7NAQmxDVlLqM5mp3D348ce/bNnirKpqPwFGl3QgonqFPiloYlguZwFER
         idM3Jx7pTzMHzX7bghOiMzx2TKb0IM8D4KNsmG4SRHlRjTcx+uGXNabhRNP/M16MmQoY
         k060KSDW30ZaWrCvn6gJC+0m+8/p8AEUpXxb8UvbeKko/9+gIJ7/Z2tzk8NNODbtAdGQ
         AUWw==
X-Gm-Message-State: AOJu0YyJWt/Vnyyzsn9AUDV5ILlm4ZtzWrq4xUCyv6hHIzI1X3kBayWn
	qpmkdVYpZQfxrF0MGoSfrs6V2Z6dyYlDy41BQoE3eXr1SzTTUy+ULW9NHY6hAw==
X-Google-Smtp-Source: AGHT+IHEfuikcLcEdzIHPVyHM4RdbcbRmnsyhBsB7pjK11xJlOMqxiCR+jIEf8xqbF0MBD0Ty2IxqA==
X-Received: by 2002:a17:90a:f008:b0:2b6:208b:ca8e with SMTP id 98e67ed59e1d1-2b6208bcdc3mr1083278a91.30.1715154198462;
        Wed, 08 May 2024 00:43:18 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:ad4d:5f6c:6699:2da4])
        by smtp.gmail.com with ESMTPSA id l5-20020a17090aec0500b002b328adaa40sm780011pjy.17.2024.05.08.00.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 00:43:18 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv3 17/19] zram: add dictionary support to lz4
Date: Wed,  8 May 2024 16:42:10 +0900
Message-ID: <20240508074223.652784-18-senozhatsky@chromium.org>
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

Support pre-trained dictionary param. lz4 doesn't
mandate specific format of the dictionary and even
zstd --train can be used to train a dictionary for
lz4, according to [1].

TEST
====

- default lz4

/sys/block/zram0/mm_stat
1750323200 664258735 676990976        0 676990976        2        0    34288    34288

- lz4 dict=/etc/dictionary

/sys/block/zram0/mm_stat
1750310912 620608254 632852480        0 632852480        1        0    34288    34288

[1] https://github.com/lz4/lz4/issues/557

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/backend_lz4.c | 77 +++++++++++++++++++++++++++++---
 1 file changed, 71 insertions(+), 6 deletions(-)

diff --git a/drivers/block/zram/backend_lz4.c b/drivers/block/zram/backend_lz4.c
index 560fcf139301..2c3b64058adf 100644
--- a/drivers/block/zram/backend_lz4.c
+++ b/drivers/block/zram/backend_lz4.c
@@ -1,9 +1,20 @@
 #include <linux/kernel.h>
 #include <linux/lz4.h>
+#include <linux/slab.h>
 #include <linux/vmalloc.h>
 
 #include "backend_lz4.h"
 
+struct lz4_ctx {
+	void *mem;
+	LZ4_streamDecode_t *dstrm;
+	LZ4_stream_t *cstrm;
+
+	/* Shared between C/D streams */
+	void *dict;
+	size_t dict_sz;
+};
+
 static int lz4_init_config(struct zcomp_config *config)
 {
 	return 0;
@@ -13,22 +24,65 @@ static void lz4_release_config(struct zcomp_config *config)
 {
 }
 
-static void *lz4_create(struct zcomp_config *config)
+static void lz4_destroy(void *ctx)
 {
-	return vmalloc(LZ4_MEM_COMPRESS);
+	struct lz4_ctx *zctx = ctx;
+
+	kfree(zctx->dstrm);
+	kfree(zctx->cstrm);
+	vfree(zctx->mem);
+	kfree(zctx);
 }
 
-static void lz4_destroy(void *ctx)
+static void *lz4_create(struct zcomp_config *config)
 {
-	vfree(ctx);
+	struct lz4_ctx *ctx;
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return NULL;
+
+	if (!config->dict) {
+		ctx->mem = vmalloc(LZ4_MEM_COMPRESS);
+		if (!ctx->mem)
+			goto error;
+	} else {
+		ctx->dstrm = kzalloc(sizeof(*ctx->dstrm), GFP_KERNEL);
+		if (!ctx->dstrm)
+			goto error;
+
+		ctx->cstrm = kzalloc(sizeof(*ctx->cstrm), GFP_KERNEL);
+		if (!ctx->cstrm)
+			goto error;
+
+		ctx->dict = config->dict;
+		ctx->dict_sz = config->dict_sz;
+	}
+
+	return ctx;
+error:
+	lz4_destroy(ctx);
+	return NULL;
 }
 
 static int lz4_compress(void *ctx, const unsigned char *src,
 			unsigned char *dst, size_t *dst_len)
 {
+	struct lz4_ctx *zctx = ctx;
 	int ret;
 
-	ret = LZ4_compress_default(src, dst, PAGE_SIZE, *dst_len, ctx);
+	if (!zctx->cstrm) {
+		ret = LZ4_compress_default(src, dst, PAGE_SIZE, *dst_len,
+					   zctx->mem);
+	} else {
+		/* Cstrm needs to be reset */
+		ret = LZ4_loadDict(zctx->cstrm, zctx->dict, zctx->dict_sz);
+		if (ret != zctx->dict_sz)
+			return -EINVAL;
+		ret = LZ4_compress_fast_continue(zctx->cstrm, src, dst,
+						 PAGE_SIZE, *dst_len,
+						 LZ4_ACCELERATION_DEFAULT);
+	}
 	if (!ret)
 		return -EINVAL;
 	*dst_len = ret;
@@ -38,10 +92,21 @@ static int lz4_compress(void *ctx, const unsigned char *src,
 static int lz4_decompress(void *ctx, const unsigned char *src,
 			  size_t src_len, unsigned char *dst)
 {
+	struct lz4_ctx *zctx = ctx;
 	int dst_len = PAGE_SIZE;
 	int ret;
 
-	ret = LZ4_decompress_safe(src, dst, src_len, dst_len);
+	if (!zctx->dstrm) {
+		ret = LZ4_decompress_safe(src, dst, src_len, dst_len);
+	} else {
+		/* Dstrm needs to be reset */
+		ret = LZ4_setStreamDecode(zctx->dstrm, zctx->dict,
+					  zctx->dict_sz);
+		if (!ret)
+			return -EINVAL;
+		ret = LZ4_decompress_safe_continue(zctx->dstrm, src, dst,
+						   src_len, dst_len);
+	}
 	if (ret < 0)
 		return -EINVAL;
 	return 0;
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


