Return-Path: <linux-kernel+bounces-243056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 632FB9290FE
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 07:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 868C91C22380
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 05:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A10139D19;
	Sat,  6 Jul 2024 04:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ad/b2Z5E"
Received: from mail-io1-f67.google.com (mail-io1-f67.google.com [209.85.166.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7776137757
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 04:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720241856; cv=none; b=im9E0RB7KThOJ3xQxBkjkhAXhUjm6GlZeSPM7QZHdN9sdBI9RMOFRN3OeztMCtNpgmH0vAB/E+hFpxEKKVZSEG7DtxjpoIK/xU+k4tTY/JzkU+K6RJnZZqqpFfWUHarGvfptSiEv2zVKH/6+PWjqPQ42r8Y5Aq3dmkD5DtnaFXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720241856; c=relaxed/simple;
	bh=Jokkp4jRyqJcm0A1DYn+TcAVitWw78wyN6aHy2nyTtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SoaBQBpnyI90DFlzkQ6TiytLVBUqWRlAidVhSHlnQvdn25puneeB6q7LrMVqWwVqi3IZBPk6DZA/kGdrpUedDx37248+JtL5Od48b6nO0LlQIjSAgYOdkjkp9eVkz1d+eOpTtyUY7jMIbou+yzBiWOr9YENdl7UW1z14kGY4iYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ad/b2Z5E; arc=none smtp.client-ip=209.85.166.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f67.google.com with SMTP id ca18e2360f4ac-7f3cd64e71cso86725439f.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 21:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720241854; x=1720846654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9r+dUMO71IOpvidHYnn6tdfSiwaLYwJEZsT8F2XyCEk=;
        b=Ad/b2Z5EJSi6d0vC+P20ieWQtsXyQDYwdUtfjLBHUg39zTusEDd1/CbM1CoN1ymzyj
         tMWLuwhQnEjKEfbCVbDYCmHnR4/IBwKSTC8QQ0T6ifI1dm8T3Ojfg6kOn1aNLcT+WEY1
         WsefvHMaG8ZS4/vev1YAV+xescl7+VBtcKZC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720241854; x=1720846654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9r+dUMO71IOpvidHYnn6tdfSiwaLYwJEZsT8F2XyCEk=;
        b=RsHUwmdZJkt7gfB2sSWI3dcy+omDrLCB7XldX2bFRekSqy6ZiEctI0rQE12tCn0Ki0
         RGdpx+ZVip9YOdQ6y90Gml/XiqM+MuGJU2z4RziO4xhWL2o7wJniLAj5+egLv2Nx4ZUH
         dGSpxiaBYAsBAvNZDEj8o/dJgmo0HGVTr9wOg5nsgj3aXqsQSBVW+r19wP5ECKNbc7hs
         PV2cRca5lSNBZr4Lb3zUBbE7lgViJ+KCm6FcoQmNF2QKtDrG/xPRP+fCxwIBqMmsJbn7
         zzw/mM248+dROBeTZBH4Rj6EXVvGYrCOK/VcefEbRsLG6M6ecx15C10/83bHEpf4lzAC
         DQEA==
X-Gm-Message-State: AOJu0YyLJtmsL9v39cubrc7nGImLVOVpyg/0jcaNa3mxh1lEdYLFKL/b
	NSI3talhyUNedODL/FL7HgE59g6mexuv19Hrw0O2QOn5JNbboSWtd1pZ5DwZSmbL04ogUWCNHMH
	YUB+T
X-Google-Smtp-Source: AGHT+IFvt1J6zKE9cv1hMVsa+NwAIJfmzdjvtTHGru2vuD24msY4BiJiM6URUXbjaMDes+AnuyrQMQ==
X-Received: by 2002:a05:6e02:194b:b0:375:c296:bf90 with SMTP id e9e14a558f8ab-38398430c33mr88614215ab.7.1720241854004;
        Fri, 05 Jul 2024 21:57:34 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:88a7:e7d7:713d:ff09])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7623cd854b2sm2784104a12.38.2024.07.05.21.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 21:57:33 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv5 20/23] zram: add dictionary support to lz4
Date: Sat,  6 Jul 2024 13:56:22 +0900
Message-ID: <20240706045641.631961-21-senozhatsky@chromium.org>
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
index cdcf6e3c1826..f686157fb401 100644
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
2.45.2.803.g4e1b14247a-goog


