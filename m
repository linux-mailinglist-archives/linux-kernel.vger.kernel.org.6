Return-Path: <linux-kernel+bounces-250190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BC992F506
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 07:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51015282F27
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 05:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807BA13A863;
	Fri, 12 Jul 2024 05:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UxgODw9/"
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDD9139CFF
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 05:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720761590; cv=none; b=EuLmQ07xwbMEKA4gULk4pDSBA9p/OEyU+90Agl2wJtubu9frnAgcHOvmqx2vbg7dTOrrIL0wMnUGWXiQ65W/MAY+6h/3QlSDR0k+kLq50a+LmCybN2n32pwYB6nwrN+d4xwvYwrwGongstoIf5uKLAyjODRSEL2hXl6v2LuF2dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720761590; c=relaxed/simple;
	bh=oesL6yJLdEEPjF01GXBOvmDJXeLAWaEls3+QSgro1+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qL2ysEd2uxxlcd69gHg3TvfRN25fBhiTpN6OuZUA5WhQb7FudPEV2cUVjOT5tu7HStHu4LJ0nJR0iWPtDmoWLeFWKJ522EsQigST3aTgRfmqR4TIMVkxrfPfVFydSRet9WGcTrejG0GsyxDoQbshVjPMcXog67Zv8sfpTEOVKEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UxgODw9/; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-70b48dfd6a2so1377604b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 22:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720761588; x=1721366388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cOqz1UKJGC0cJBgyrAcesFmmSKbjK8nnap7UfC7PRiA=;
        b=UxgODw9/VFAjvoBBW1NfS4+sCRWEUW9aC3ZP99aQ+7YeM2EhmyiVx6npjj5oxQAbhv
         p/It6HQa7zL2ZnPjcF/1mjlnlxVF+SS6D3/YzJy7rVrXzNvv1PavmPYRZK1hUwGUuhZ+
         4PXTA0Ll5enL9ZPDxKMUnnsHeiOM0I0pfwKGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720761588; x=1721366388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cOqz1UKJGC0cJBgyrAcesFmmSKbjK8nnap7UfC7PRiA=;
        b=W7+54VIgrpKv3LSxt7ZZ5hmsYz+LmBeMjZa9gRUZMp0TbRUBFg6Wj/SKHXDlODRhoD
         C2ddyUVvKdbzbWPtXnpiijpvF19PBjY85WtY8C+gt2LBc3WVcVrHnCstQIhMQEKWlRSo
         rdxficfKVOIEUEoHssRW73FWNTbp5gSMQikOSZWwp3kWP4ZvS3zWAKcYEE5fXvWI7T7t
         VYPM+y93XQ9F9W2xoS5cUvVsyonIfMmzY5KY6L8gvNkWGSIfRmO4dAsvIUEBd8ia+lEo
         lKvIlR1m+HBsVOqBiPC5EPg/bUu3yfT7tqytUWmcbZAOIPp87jW8zPvG1UBGKjAwojw9
         NrMA==
X-Gm-Message-State: AOJu0YzGvbh9nFP9Wrt8paZiJVzvkwPvgbEWQGRSkJsScmu/6OZHsblO
	RsGx7jT8WZwhjZLZvv5+I5JGuarffq7pZPKnrx+kgIvaszX5VQ8j61ABDly8UA==
X-Google-Smtp-Source: AGHT+IFa5LtLb2Dhp8gMYPqeShtFnfkHNf23sEgbIqItEYFBbEjK3KI6KijIZLh/RvVwiE2kVelOJQ==
X-Received: by 2002:a05:6a00:a13:b0:70b:1811:3efa with SMTP id d2e1a72fcca58-70b435ef897mr12775668b3a.22.1720761588552;
        Thu, 11 Jul 2024 22:19:48 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:15f3:5252:ec56:52ae])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b43967851sm6553436b3a.109.2024.07.11.22.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 22:19:48 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v6 20/23] zram: add dictionary support to lz4
Date: Fri, 12 Jul 2024 14:18:31 +0900
Message-ID: <20240712051850.484318-21-senozhatsky@chromium.org>
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

Support pre-trained dictionary param. lz4 doesn't
mandate specific format of the dictionary and even
zstd --train can be used to train a dictionary for
lz4, according to [1].

TEST
====
*** lz4
/sys/block/zram0/mm_stat
1750654976 664188565 676864000        0 676864000        1        0    34288    34288

*** lz4 dict=/home/ss/lz4-dict-amd64
/sys/block/zram0/mm_stat
1750638592 619891141 632053760        0 632053760        1        0    34278    34278

*** lz4 level=5 dict=/home/ss/lz4-dict-amd64
/sys/block/zram0/mm_stat
1750638592 727174243 740810752        0 740810752        1        0    34437    34437

[1] https://github.com/lz4/lz4/issues/557

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/backend_lz4.c | 74 +++++++++++++++++++++++++++++---
 1 file changed, 67 insertions(+), 7 deletions(-)

diff --git a/drivers/block/zram/backend_lz4.c b/drivers/block/zram/backend_lz4.c
index cf3c029bd5ad..847f3334eb38 100644
--- a/drivers/block/zram/backend_lz4.c
+++ b/drivers/block/zram/backend_lz4.c
@@ -5,6 +5,13 @@
 
 #include "backend_lz4.h"
 
+struct lz4_ctx {
+	void *mem;
+
+	LZ4_streamDecode_t *dstrm;
+	LZ4_stream_t *cstrm;
+};
+
 static void lz4_release_params(struct zcomp_params *params)
 {
 }
@@ -19,25 +26,66 @@ static int lz4_setup_params(struct zcomp_params *params)
 
 static void lz4_destroy(struct zcomp_ctx *ctx)
 {
-	vfree(ctx->context);
+	struct lz4_ctx *zctx = ctx->context;
+
+	if (!zctx)
+		return;
+
+	vfree(zctx->mem);
+	kfree(zctx->dstrm);
+	kfree(zctx->cstrm);
+	kfree(zctx);
 }
 
 static int lz4_create(struct zcomp_params *params, struct zcomp_ctx *ctx)
 {
-	ctx->context = vmalloc(LZ4_MEM_COMPRESS);
-	if (!ctx->context)
+	struct lz4_ctx *zctx;
+
+	zctx = kzalloc(sizeof(*zctx), GFP_KERNEL);
+	if (!zctx)
 		return -ENOMEM;
 
+	ctx->context = zctx;
+	if (params->dict_sz == 0) {
+		zctx->mem = vmalloc(LZ4_MEM_COMPRESS);
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
+	lz4_destroy(ctx);
+	return -ENOMEM;
 }
 
 static int lz4_compress(struct zcomp_params *params, struct zcomp_ctx *ctx,
 			struct zcomp_req *req)
 {
+	struct lz4_ctx *zctx = ctx->context;
 	int ret;
 
-	ret = LZ4_compress_fast(req->src, req->dst, req->src_len,
-				req->dst_len, params->level, ctx->context);
+	if (!zctx->cstrm) {
+		ret = LZ4_compress_fast(req->src, req->dst, req->src_len,
+					req->dst_len, params->level,
+					zctx->mem);
+	} else {
+		/* Cstrm needs to be reset */
+		ret = LZ4_loadDict(zctx->cstrm, params->dict, params->dict_sz);
+		if (ret != params->dict_sz)
+			return -EINVAL;
+		ret = LZ4_compress_fast_continue(zctx->cstrm, req->src,
+						 req->dst, req->src_len,
+						 req->dst_len, params->level);
+	}
 	if (!ret)
 		return -EINVAL;
 	req->dst_len = ret;
@@ -47,10 +95,22 @@ static int lz4_compress(struct zcomp_params *params, struct zcomp_ctx *ctx,
 static int lz4_decompress(struct zcomp_params *params, struct zcomp_ctx *ctx,
 			  struct zcomp_req *req)
 {
+	struct lz4_ctx *zctx = ctx->context;
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


