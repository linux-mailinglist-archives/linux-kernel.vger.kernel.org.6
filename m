Return-Path: <linux-kernel+bounces-311166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4491F968592
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 13:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65C3F1C21D44
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D231D6DD9;
	Mon,  2 Sep 2024 10:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E9Xl7NIO"
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAB71D6DB6
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 10:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725274670; cv=none; b=YDfH9fwZrfKkJ4hKSc5+2TsX5qZdeb44VEN33S0pRRJcCnN73xqWO7cpI19w7ZegRE7rSplDSnHAVPUYhLiLWASMUbYRxsdWPvsAwd8cnp33nV87OUu94OyJAp27N6j4+9pHPoRTXARBzq8U15rgaJtZyphNwxWJTRcjXKmP0GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725274670; c=relaxed/simple;
	bh=5U0E18nkV4Yhlpww2UvI6j2fl9z+rbeoT5KvCZOo/oo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kXCOQfEHV/wxZvJzdR4SIN/iL2M64+EM/D0Q8T5NRH+jAiQCvRSwd4yvsn0GE9gSL61LsYbgmvxSjaRUqgLwU4omZgoSsoVWt+AcaD37JwttV/p67Zl4+Q+GOrshNy6p7I/AAj6VAoyOmOigbrbNjR88g6ppwcKRzl2Me9Hvrd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=E9Xl7NIO; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-71431524f33so3278007b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 03:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725274668; x=1725879468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=arugtM5mAIC8413+HPBKV/ihvuKi7FYGcgiYWwmxOOE=;
        b=E9Xl7NIOdK6dWQ1mHGbdyhDsMBpliquscjZu/rGByNIb/8/jfRtFgn3n9CSs9xVWDl
         39pf8/YfhyAhe+5vRVhrQTY2AWAum/q6sHoZ4rbuG/zbidhJp5hbq8RuznBict+5qF7x
         lQUgUEEHAwzW2zWR1o1EiGsquQwiRoNSK2mU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725274668; x=1725879468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=arugtM5mAIC8413+HPBKV/ihvuKi7FYGcgiYWwmxOOE=;
        b=MOpLI3neCYP4GvwpS7yV5yet3d5gnyLxNRcAIAK30mU4Hz5oDOqlEM+An8MvdP0VBp
         eZZ6XXereszunjVdWya+irXsybny09PDXiBMcxf96gi90+rMbuTgQXHmvOX1T2vxAn8E
         s/nK9QAxgF7R+g2bnIYqmRdRu38v2sfsDDEC1pKDfAPSbVQrHlBfYH44ftwBu2YtbXNl
         G9O+U5SWcPX9yGbkRY+rI7ClNE55Iw48EAuoity2AqAjKzD2yQUhv9gXy9GtLo/+BnPX
         fUQB13JQfA+kOzyIdM2dbX2JmBh/bm/1FFbcxSwW2Pr7i9okyUt17P2f8KuOiA6iA1WD
         Rhkg==
X-Forwarded-Encrypted: i=1; AJvYcCVeUGBvIVAafLL3sXvXoHyzaLrM7XlwSUPesljOWi5+3F83Vrp4p/js62cQLtegLe5jdFDBIZcg2Dss5As=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq94xjz+u1eMUpaNvCzDtSnbAqe3gGxpbUOTO2mR9UEdGPXLc7
	qhiAZDITIvqsOZc2u5xUviX8ao9NWYUjIBUW3JNhuqS//eS7YWLSumxQ2ZK0/g==
X-Google-Smtp-Source: AGHT+IHkSIr+ID5DA893Zb06oXTXbnZ6kIEcmCL3EbIXlV8jTq88r2L2CholVmK2hiWFrNIiQM9rlA==
X-Received: by 2002:a05:6a21:670f:b0:1cc:d61a:1e37 with SMTP id adf61e73a8af0-1cecf758703mr9448638637.33.1725274667733;
        Mon, 02 Sep 2024 03:57:47 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:43a1:71e3:7464:e91b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55a51e9sm6633769b3a.78.2024.09.02.03.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 03:57:47 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv7 21/24] zram: add dictionary support to lz4hc
Date: Mon,  2 Sep 2024 19:56:09 +0900
Message-ID: <20240902105656.1383858-22-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240902105656.1383858-1-senozhatsky@chromium.org>
References: <20240902105656.1383858-1-senozhatsky@chromium.org>
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

*** lz4hc dict=/etc/lz4-dict-amd64
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
2.46.0.469.g59c65b2a67-goog


