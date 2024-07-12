Return-Path: <linux-kernel+bounces-250191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CD592F507
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 07:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BE122818EF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 05:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B220A13B580;
	Fri, 12 Jul 2024 05:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D2CdFJ1I"
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACB413A402
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 05:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720761592; cv=none; b=hjCdvkG681QnenXO1LxHzYeqlxYpdQU2GC2ZACfacYDVKg8Z8aDq8hkegsLGsq8gsq5NVjhAmNg8a4pNvDJ81zk7JakXHdztyPJsTopdhwIM1dKdaJD5CYZuDL+EJFHHTUBG9mhSghA9t6qWsBJxS5EcHsJBghOlMtkucopxriU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720761592; c=relaxed/simple;
	bh=pBJX240A8EepnVHuaJxutQ6J47IN9DHh/OOBZLl3Zrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dxHBz3U/jrMnZN+94YNMKQv23Yd+X1oARNjrXy8SLLyWIejUw+yagh7H1FwALrZUJ2Kf5RMniv8IYtk+vfWbG6gu1DU6UeP0seLSbgvIe6TCAe0b+LqeX2m5o7neIJEjLHdmkRfjuF1tKjScHzRmybmbR4N6xQ1OfwMbYYGrq+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=D2CdFJ1I; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-70b09c2ade6so1355966b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 22:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720761591; x=1721366391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ySNQ8hknVs1Pz2Cxbz+MxOZEuy5IgamkxaSOVrUSiXw=;
        b=D2CdFJ1IIgL8mdzxC6kTs62mRa9XLbuhb7Lx6h1fIFHYefLlNjgOwK9m+6FaqWJiPj
         rAGC1lTMuRLSAMXV7+NF1SUv1hkF/Jdi73oKLTlbDIOnQTqBl86nciJuePTYMY9gK6cV
         qEjns2ZfWEqfsDV/fuqY5YAl3Pr79RuHKXoOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720761591; x=1721366391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ySNQ8hknVs1Pz2Cxbz+MxOZEuy5IgamkxaSOVrUSiXw=;
        b=OCTDRX5hWJd7TDO3J3VYjUtBLpvji90bYgyXWmzL2WujB7tOGWr4VfpqcyC/c4P030
         JSyRjRmtXMXG0w5LK5ps+tZEoPei9P1RSCA6M9de1lpi8VUluu80AgLrXZRhKPDJtEXK
         YPDYjwG/uK70tt6d0OkcPilWydMs/ZUKFUDuhUlMcQ0FE44Jgcax1tBNGd8E2drYHKAd
         dmurC7OMcSzGfxggJFTuejMmuwtS+2GwS0ulyn73hioe1K3kIcnPHC93L1Xbm5crMkQP
         szRiAyKkIO0Rp1fapZ32VrrOcm4kNzmxORbLoD734MztTe4xbxoqar4JxCqw0OYbZbTB
         aiJw==
X-Gm-Message-State: AOJu0YxrDJEu+W7NlBDelWjm7EEufhM6MX8Z+vlk/6yzfQntosH6Cncs
	lEEB2UaiJHSkXmPuK+Up1Jd5EjGj8hERhKx4OmaOLr6sNlBNBcWS4sDqsz1g/A==
X-Google-Smtp-Source: AGHT+IGvSlUfQaZyvlFesabkCeeN/gUj6ePCb9wgZ5Zfoa8PweA3oTtj/Rhf/zk6587E+DBF3A8rPw==
X-Received: by 2002:a05:6a00:1797:b0:706:759a:70bf with SMTP id d2e1a72fcca58-70b435686b8mr13804295b3a.13.1720761590676;
        Thu, 11 Jul 2024 22:19:50 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:15f3:5252:ec56:52ae])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b43967851sm6553436b3a.109.2024.07.11.22.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 22:19:50 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v6 21/23] zram: add dictionary support to lz4hc
Date: Fri, 12 Jul 2024 14:18:32 +0900
Message-ID: <20240712051850.484318-22-senozhatsky@chromium.org>
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

Support pre-trained dictionary param. Just like lz4,
lz4hc doesn't mandate specific format of the dictionary
and zstd --train can be used to train a dictionary for
lz4, according to [1].

TEST
====

*** lz4hc
/sys/block/zram0/mm_stat
1750638592 608954620 621031424        0 621031424        1        0    34288    34288

*** lz4hc dict=/home/ss/lz4-dict-amd64
/sys/block/zram0/mm_stat
1750671360 505068582 514994176        0 514994176        1        0    34278    34278

[1] https://github.com/lz4/lz4/issues/557

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/backend_lz4hc.c | 75 +++++++++++++++++++++++++++---
 1 file changed, 68 insertions(+), 7 deletions(-)

diff --git a/drivers/block/zram/backend_lz4hc.c b/drivers/block/zram/backend_lz4hc.c
index 928a6ea78668..5f37d5abcaeb 100644
--- a/drivers/block/zram/backend_lz4hc.c
+++ b/drivers/block/zram/backend_lz4hc.c
@@ -5,6 +5,13 @@
 
 #include "backend_lz4hc.h"
 
+struct lz4hc_ctx {
+	void *mem;
+
+	LZ4_streamDecode_t *dstrm;
+	LZ4_streamHC_t *cstrm;
+};
+
 static void lz4hc_release_params(struct zcomp_params *params)
 {
 }
@@ -19,25 +26,67 @@ static int lz4hc_setup_params(struct zcomp_params *params)
 
 static void lz4hc_destroy(struct zcomp_ctx *ctx)
 {
-	vfree(ctx->context);
+	struct lz4hc_ctx *zctx = ctx->context;
+
+	if (!zctx)
+		return;
+
+	kfree(zctx->dstrm);
+	kfree(zctx->cstrm);
+	vfree(zctx->mem);
+	kfree(zctx);
 }
 
 static int lz4hc_create(struct zcomp_params *params, struct zcomp_ctx *ctx)
 {
-	ctx->context = vmalloc(LZ4HC_MEM_COMPRESS);
-	if (!ctx->context)
+	struct lz4hc_ctx *zctx;
+
+	zctx = kzalloc(sizeof(*zctx), GFP_KERNEL);
+	if (!zctx)
 		return -ENOMEM;
 
+	ctx->context = zctx;
+	if (params->dict_sz == 0) {
+		zctx->mem = vmalloc(LZ4HC_MEM_COMPRESS);
+		if (!zctx->mem)
+			goto error;
+	} else {
+		zctx->dstrm = kzalloc(sizeof(*zctx->dstrm), GFP_KERNEL);
+		if (!zctx->dstrm)
+			goto error;
+
+		zctx->cstrm = kzalloc(sizeof(*zctx->cstrm), GFP_KERNEL);
+		if (!zctx->cstrm)
+			goto error;
+	}
+
 	return 0;
+
+error:
+	lz4hc_destroy(ctx);
+	return -EINVAL;
 }
 
 static int lz4hc_compress(struct zcomp_params *params, struct zcomp_ctx *ctx,
 			  struct zcomp_req *req)
 {
+	struct lz4hc_ctx *zctx = ctx->context;
 	int ret;
 
-	ret = LZ4_compress_HC(req->src, req->dst, req->src_len, req->dst_len,
-			      params->level, ctx->context);
+	if (!zctx->cstrm) {
+		ret = LZ4_compress_HC(req->src, req->dst, req->src_len,
+				      req->dst_len, params->level,
+				      zctx->mem);
+	} else {
+		/* Cstrm needs to be reset */
+		LZ4_resetStreamHC(zctx->cstrm, params->level);
+		ret = LZ4_loadDictHC(zctx->cstrm, params->dict,
+				     params->dict_sz);
+		if (ret != params->dict_sz)
+			return -EINVAL;
+		ret = LZ4_compress_HC_continue(zctx->cstrm, req->src, req->dst,
+					       req->src_len, req->dst_len);
+	}
 	if (!ret)
 		return -EINVAL;
 	req->dst_len = ret;
@@ -47,10 +96,22 @@ static int lz4hc_compress(struct zcomp_params *params, struct zcomp_ctx *ctx,
 static int lz4hc_decompress(struct zcomp_params *params, struct zcomp_ctx *ctx,
 			    struct zcomp_req *req)
 {
+	struct lz4hc_ctx *zctx = ctx->context;
 	int ret;
 
-	ret = LZ4_decompress_safe(req->src, req->dst, req->src_len,
-				  req->dst_len);
+	if (!zctx->dstrm) {
+		ret = LZ4_decompress_safe(req->src, req->dst, req->src_len,
+					  req->dst_len);
+	} else {
+		/* Dstrm needs to be reset */
+		ret = LZ4_setStreamDecode(zctx->dstrm, params->dict,
+					  params->dict_sz);
+		if (!ret)
+			return -EINVAL;
+		ret = LZ4_decompress_safe_continue(zctx->dstrm, req->src,
+						   req->dst, req->src_len,
+						   req->dst_len);
+	}
 	if (ret < 0)
 		return -EINVAL;
 	return 0;
-- 
2.45.2.993.g49e7a77208-goog


