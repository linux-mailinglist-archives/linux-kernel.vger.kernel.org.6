Return-Path: <linux-kernel+bounces-179572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE93D8C618E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 09:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB1AC1C2085D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 07:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D82763FD;
	Wed, 15 May 2024 07:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Fdh7B8/Z"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D59676023
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 07:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715757467; cv=none; b=Jh/hZumLNL4qMZvaIK980AoYe6AobcgOogF5TPTujw6tTpzRxtZn0CmjmURht/DicVRQXn4k1LNJArSxgj0d4l+gWetOdzV5dD2+ItHlBvfyR+Zz8fK7qTqKasaUUGWhnKDKQcbWIWhEmqGmscCK9g9QHuxPCD7WreBoubyOqIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715757467; c=relaxed/simple;
	bh=qtvmUsQREyXmjeLbpuxebnWi3agfG2+3rkkIDgBbtXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fHJDfHM/EFBpy2AQwk26Qay7BeaQW5dVrHTot1Mt+tUJezHqfz8F1D2Aknr4nBvqs6Ii2xIIrjUyNnBlz6MngF7nhoHOFW2FIf2POF94M6c9aJUfSYkPnd9/5o2P4KPZ8Nl5SOvQU58vO2137nPOKR+lildL0UpNh3YSvt8DrvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Fdh7B8/Z; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f08442b7bcso14077165ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 00:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715757465; x=1716362265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHfG35o7+8/7OU1lSE40PRM3WsVXKsxMJUAQYr8zh6U=;
        b=Fdh7B8/ZhcGrI2v5MO0se01y9b5gbob6rKAnF1fJY7gwhE8c0SUAhpUFtyHzHOSq3Y
         0hugWD0WUKa+/NJByWV/RAad3bt4YtwXF3YVLhXA+F1sFpRKzVymT0gXY6Js+QCyGkkk
         ZOfnWzBX5WjLBwZVK+j9FzJzfuZvGYydJNZGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715757465; x=1716362265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fHfG35o7+8/7OU1lSE40PRM3WsVXKsxMJUAQYr8zh6U=;
        b=UZIKd0u/AWIT6cwMSgivx+WHfhVXKsNHXiNcUprQwRM6x/AkJPE6+qSKAYHIxHYtxi
         tb8qAtynwEN4OMjNAXNEX/nlYI++ZtW9wfLtkxuaHAWXPnjaXWUSYrlBYRZI6rJyH8aH
         ZD1GGXzbgVC+IkobsBlIF/ekLpMgk5OR+eIlLT1wAGmYhJlfOQTBbyEVW054YDOaDlDI
         kDDSxKyTV5Wk00I8UKdm1fHqUYMUipXNSag1q676z1suHnHjbUzlKMFKdzhJEkV9wtQo
         Y33P3vgiGvAUY2BxeysKoMfgSENUWwCE9YH84V7NtFV4z713UY8n46GJ7i5RzV/yLqhX
         vlpQ==
X-Gm-Message-State: AOJu0Yw90UaccmtDL92DP3OLYFHgu3GUlcxnZVEZNiUWrAK+03syOhIr
	2lmjc9zATq2nYM/rWRZelaUIoIpuyfk+Kok+Uyczis0rqchtk0a84jSI1ISBxg==
X-Google-Smtp-Source: AGHT+IFWdGVgCe1JBmXZ3hDnpc6dFO9Vvt71Vj0tCFKh+5tnuApc6QuAnmJpi2vhaAxChIPFAqL2cQ==
X-Received: by 2002:a17:902:8542:b0:1e2:be4b:dd9f with SMTP id d9443c01a7336-1ef43d29670mr140437795ad.15.1715757464806;
        Wed, 15 May 2024 00:17:44 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:111d:a618:3172:cd5b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c136d53sm110941605ad.254.2024.05.15.00.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 00:17:44 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv4 20/21] zram: add dictionary support to lz4hc
Date: Wed, 15 May 2024 16:12:57 +0900
Message-ID: <20240515071645.1788128-21-senozhatsky@chromium.org>
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
 drivers/block/zram/backend_lz4hc.c | 54 ++++++++++++++++++++++++++----
 1 file changed, 48 insertions(+), 6 deletions(-)

diff --git a/drivers/block/zram/backend_lz4hc.c b/drivers/block/zram/backend_lz4hc.c
index 428b393371d7..c928f94f30df 100644
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
@@ -39,9 +47,22 @@ static void *lz4hc_create(struct zcomp_config *config)
 		return NULL;
 
 	ctx->level = config->level;
-	ctx->mem = vmalloc(LZ4HC_MEM_COMPRESS);
-	if (!ctx->mem)
-		goto error;
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
+	}
 
 	return ctx;
 error:
@@ -55,8 +76,18 @@ static int lz4hc_compress(void *ctx, const unsigned char *src,
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
@@ -66,10 +97,21 @@ static int lz4hc_compress(void *ctx, const unsigned char *src,
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


