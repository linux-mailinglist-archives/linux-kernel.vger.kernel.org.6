Return-Path: <linux-kernel+bounces-172850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A9B8BF77B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 09:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECDD5284FD0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 07:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4AA83FBB1;
	Wed,  8 May 2024 07:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZVQ50cfY"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D522A7EEF3
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 07:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715154203; cv=none; b=qCGRaOyuvJCkhL136fJozTQyFRu8RY65UHJthLE5HJ+eqRLk0oXMn23/noun1HTCobb3x5pxSSdh7JlwMBaTsap1b+SSIvceZebtVxQw0M1phI637tbBYrY8bp4nHBuLIqY/zD+8EhbqCCvJEJ2+1IgiDJ/7ECS3v1RrB5Nmvjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715154203; c=relaxed/simple;
	bh=OdhpOTFPCVgN2eccjlEO6kqeLVB903rqR/qnsmX6Lno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LyEoOuCs8yVzX7CRi+k2u6KpFbX8UeFleFN2Wi1xFmhyzlHPNh9Vs8GlzaAu0xipIrXUPA6RBcnmIyF/Hoaw09bc6Radd+OW/gpoYVQ5N2yYtiMAZOgLaslmhvDmTVbdaEQ17TUWdgI8xTbXrr/tfv7t89O+gQaSGxPstGeiIFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZVQ50cfY; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5e152c757a5so2449144a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 00:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715154201; x=1715759001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9QxTKxxqM9CCOnK78l26rfPlNmUT2j4/F00viIdsP1A=;
        b=ZVQ50cfYfOoOS1C06wSLvbD8nXRkfN6+5b/J3wznnKRRPcaFs9JMLJJ1IiG3pFMh/1
         8r+wMHNvYF+MyeuElNBzYEdXoRezPpTw1c03b6CCVRolr6JE/1W1/SM8BdcNublhB6h4
         +KvkFUo1mMINPGHBzqa3UHIoqHSC/4dUP7NEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715154201; x=1715759001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9QxTKxxqM9CCOnK78l26rfPlNmUT2j4/F00viIdsP1A=;
        b=w6gp/+GPCSgOmMZ5UkxTurQfjv82w7Pux9vzRDksYlW8AEmYBvurqCIb0VI68J4nk2
         6Ll3YbnEKrf+zi/i+yf2dsN/qVysMc6AKvau7Zus7jXaCK3TcTauUroQzAMmUU8G0GfT
         OBr6OxNCXcTxLxmFE7jJBKhTHfI8ctQBlMDUrk1q62XQyGSFT0vJol71P+qgK0LDZi2+
         hNv13Can+dUIgsuBtuiCHTLZSp0SJrmHGhhtJN9xtzQ1oAzSvdCO6XyGrNqKdcZyM9ps
         u32tGpEsIb0ledrUPZ0qbEcc6oZjUcoJzgk2/Y238BiZ0vP83Z2x/b1Hky9Sg3cByBlm
         uVGg==
X-Gm-Message-State: AOJu0YxDKp7wf7p07lsTLpclgrO/KIfi+JsaJxTzM8K2raHWtsIFC2WU
	DJr1OrNO06JNWzW+/nsSV/D6fWs5ZKPKSgvTqnnI3umPIpjDblTzi49aq1k/0g==
X-Google-Smtp-Source: AGHT+IEzdJrzSXLzatIiUMsCPntn78tgD8O/GIVzTJ0AlqSOg942tNgKxWsOC7FgEZxsD9MYoNfjYQ==
X-Received: by 2002:a17:90a:f014:b0:2ae:6e16:da91 with SMTP id 98e67ed59e1d1-2b6165c1513mr1825272a91.29.1715154201328;
        Wed, 08 May 2024 00:43:21 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:ad4d:5f6c:6699:2da4])
        by smtp.gmail.com with ESMTPSA id l5-20020a17090aec0500b002b328adaa40sm780011pjy.17.2024.05.08.00.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 00:43:21 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv3 18/19] zram: add dictionary support to lz4hc
Date: Wed,  8 May 2024 16:42:11 +0900
Message-ID: <20240508074223.652784-19-senozhatsky@chromium.org>
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

Support pre-trained dictionary param. Just like lz4,
lz4hc doesn't mandate specific format of the dictionary
and zstd --train can be used to train a dictionary for
lz4, according to [1].

TEST
====

- default lz4hc

/sys/block/zram0/mm_stat
1750315008 609010918 621006848        0 621006848        2        0    34288    34288

- lz4hc dict=/etc/dictionary

/sys/block/zram0/mm_stat
1750319104 499629401 509485056        0 509485056        1        0    34288    34288

[1] https://github.com/lz4/lz4/issues/557

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/backend_lz4hc.c | 58 ++++++++++++++++++++++++++----
 1 file changed, 51 insertions(+), 7 deletions(-)

diff --git a/drivers/block/zram/backend_lz4hc.c b/drivers/block/zram/backend_lz4hc.c
index 431a44f0fcfd..c928f94f30df 100644
--- a/drivers/block/zram/backend_lz4hc.c
+++ b/drivers/block/zram/backend_lz4hc.c
@@ -8,6 +8,12 @@
 struct lz4hc_ctx {
 	void *mem;
 	s32 level;
+	LZ4_streamDecode_t *dstrm;
+	LZ4_streamHC_t *cstrm;
+
+	/* Shared between C/D streams */
+	void *dict;
+	size_t dict_sz;
 };
 
 static int lz4hc_init_config(struct zcomp_config *config)
@@ -26,6 +32,8 @@ static void lz4hc_destroy(void *ctx)
 {
 	struct lz4hc_ctx *zctx = ctx;
 
+	kfree(zctx->dstrm);
+	kfree(zctx->cstrm);
 	vfree(zctx->mem);
 	kfree(zctx);
 }
@@ -39,12 +47,27 @@ static void *lz4hc_create(struct zcomp_config *config)
 		return NULL;
 
 	ctx->level = config->level;
-	ctx->mem = vmalloc(LZ4HC_MEM_COMPRESS);
-	if (!ctx->mem) {
-		lz4hc_destroy(ctx);
-		return NULL;
+	if (!config->dict) {
+		ctx->mem = vmalloc(LZ4HC_MEM_COMPRESS);
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
 	}
+
 	return ctx;
+error:
+	lz4hc_destroy(ctx);
+	return NULL;
 }
 
 static int lz4hc_compress(void *ctx, const unsigned char *src,
@@ -53,8 +76,18 @@ static int lz4hc_compress(void *ctx, const unsigned char *src,
 	struct lz4hc_ctx *zctx = ctx;
 	int ret;
 
-	ret = LZ4_compress_HC(src, dst, PAGE_SIZE, *dst_len,
-			      zctx->level, zctx->mem);
+	if (!zctx->cstrm) {
+		ret = LZ4_compress_HC(src, dst, PAGE_SIZE, *dst_len,
+				      zctx->level, zctx->mem);
+	} else {
+		/* Cstrm needs to be reset */
+		LZ4_resetStreamHC(zctx->cstrm, zctx->level);
+		ret = LZ4_loadDictHC(zctx->cstrm, zctx->dict, zctx->dict_sz);
+		if (ret != zctx->dict_sz)
+			return -EINVAL;
+		ret = LZ4_compress_HC_continue(zctx->cstrm, src, dst,
+					       PAGE_SIZE, *dst_len);
+	}
 	if (!ret)
 		return -EINVAL;
 	*dst_len = ret;
@@ -64,10 +97,21 @@ static int lz4hc_compress(void *ctx, const unsigned char *src,
 static int lz4hc_decompress(void *ctx, const unsigned char *src,
 			    size_t src_len, unsigned char *dst)
 {
+	struct lz4hc_ctx *zctx = ctx;
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


