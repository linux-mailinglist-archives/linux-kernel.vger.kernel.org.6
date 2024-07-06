Return-Path: <linux-kernel+bounces-243057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DAD9290FF
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 07:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 080661F2324F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 05:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8229E13AA20;
	Sat,  6 Jul 2024 04:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Fa6ifR0I"
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com [209.85.210.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CA1139588
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 04:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720241858; cv=none; b=LIIQ8WNtqmRv6apyYarB2LlVWyw49NI6pU9/BMY4SHUBqP9Dl4xR70pKomx9VbwazdpS/7JqwXgSH5kASxleHQcB9IfM3vhS3qtU06AESy6cIJ6z3i2AH2vrg2QyeNJF+UYcFc3y0UwSGiz+F/l8tsbzHSpMRsfhpk2qJKb4WeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720241858; c=relaxed/simple;
	bh=4BOysAvN6WEsLsyWGj0lrllBLLuR9mEBlKcakWkisvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j1EfxjbPA53evx7OkEtPZkQOtUm/przZpcRAfkG+AZkTJwoBabUz4ZN8t5Nfiey2WEd88bEEzDoTf+I3Mj7qjT7FymDnBm5JToLN2jwJW2RBlkD7G8ospH4CZVibEqxaGlygyPZvHtBzk1oTNtpGCP3IOYiz7kG2pX4jWZpjLYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Fa6ifR0I; arc=none smtp.client-ip=209.85.210.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f66.google.com with SMTP id 46e09a7af769-700d3ffc28cso1264730a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 21:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720241856; x=1720846656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lk7lKUfZ2c6LEEWLJ3rTOiTZsxNUbw3palG8LlVINX8=;
        b=Fa6ifR0I9iJi2UWNzFX7ynjoF+O9x7DPD0VpFUzUg26C2G42cyfVLboELMwsAC0BOx
         DRB1UT3noTyuuUjsF3YtXHAXtUhgFMIF1qyMiUObn7Yz8DiAzNkTlwDIYLY8/YjAjR4+
         keOmW38gG7YmniF7bXPBEttRrRAovaomHbFO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720241856; x=1720846656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lk7lKUfZ2c6LEEWLJ3rTOiTZsxNUbw3palG8LlVINX8=;
        b=qZeOvurzegUrVkcfqbe5+GAywdEs454tRZHKaKVrfHMJxG3x8SGoYk17QfsV8lq0R/
         PIycTjos+1OXK8Qm9SCucMuxgTbl/B6E53Sn0x/zjy6xlx79+dBD72mAnQE6XbsRrwEM
         Bt6C7012ck8dveokgyjq4l0GCl2bTiPj2YU3ZAUQna0/P6lb3OETYJ7Kw7AJErJfut7j
         fFc5JjNchlM6v+MadfS9McnMCjmBivQuB+X4HTK/jEBtx/FUwsXmN9ok2AVjPDyJDgK7
         B9X6ZDSCIHBNzEMGvcEr1VoLgiH7mxld7R712Ag+3gU5fjZdhgNMUIqRx/+tJaOuKfgm
         LeTg==
X-Gm-Message-State: AOJu0Yw9CPi+ejXno8edMkx6htlegUlHCLaTt6OGBD/hHeECtL8gzRmq
	lZwUN9ItYMhMjfxWMfatZ7kka0RVNsSEZ7Viu+T/f7LviBBGTPOMkBv54XUHLw==
X-Google-Smtp-Source: AGHT+IHtqKwu9Pjse0iVZGpzEQvqhzmbr8A2UO3GcStS4aRBVH9m8gCkyKaL+gfJv/1sILfQc0EiCQ==
X-Received: by 2002:a05:6358:89e:b0:1aa:b887:2386 with SMTP id e5c5f4694b2df-1aab88723e8mr99364555d.10.1720241856134;
        Fri, 05 Jul 2024 21:57:36 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:88a7:e7d7:713d:ff09])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7623cd854b2sm2784104a12.38.2024.07.05.21.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 21:57:35 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv5 21/23] zram: add dictionary support to lz4hc
Date: Sat,  6 Jul 2024 13:56:23 +0900
Message-ID: <20240706045641.631961-22-senozhatsky@chromium.org>
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
index e7dc0e03f13c..79ff2c968f6b 100644
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
2.45.2.803.g4e1b14247a-goog


