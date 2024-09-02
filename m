Return-Path: <linux-kernel+bounces-311165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA68968591
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 13:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67FD8B2464B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610231D6DB7;
	Mon,  2 Sep 2024 10:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Jw+TIj0I"
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CEA1D6DA8
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 10:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725274667; cv=none; b=pa/ZosRRIPds7qIP+QWhPPZ23UL8XasGnoMw/lrUmsh2IQ/E4vrGk+yIqOKAMEe6jEOZijc5IoidGqlQj2cfnaCcNI6x5nFRtW99Zca17mngEWhEiVkDqlAkPmURAc2gqvbuqWRor/RZoGkWUOw6l7n+KIVGT7M9nJtkRviwldc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725274667; c=relaxed/simple;
	bh=+Jy+8wr2DxVIihczOaNP9pGnWterRMIyCCr5QXgdYm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wo1cp8zYsIWflAAfodKchgjwpfeyCyYSnPvx9gixwDnINWuCw2TIbmCBYHhAJKZXDKxJ3i/WXeqkekYwGcDUm2GJKd7M57qb8IkhMDBjSLI96DmuGgx6YC1eZ2YrscVH++fRYrUltYMxmRDklMEwz3slEB/sjrjC1K7tlXtB4/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Jw+TIj0I; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-7176645e501so124665b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 03:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725274665; x=1725879465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oihThJTx7u5jJd0CAqfMRPhRFwU+I2vie2k3NMx4+Dg=;
        b=Jw+TIj0Id4Jk38sM/o7EGj0DzeTEM4kErFOqwJFKi4OvBkNek4nerleDbp/8D61kpc
         p9SNHXK9GoMnP5rNT966sJVFdUacXkzq5PH3mplP497/2WxD9tRwjQ53UiAG1FnOx7Pv
         8iMKvgjR7CfvnY/sJyKBhwCgdstWHzdL+CZ0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725274665; x=1725879465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oihThJTx7u5jJd0CAqfMRPhRFwU+I2vie2k3NMx4+Dg=;
        b=U5VgbrjaLIUC9LfNQ7CGiatO6ZN2tKEihlgznW6znJ7Uvl8kDDrm/cYFLGEQQ+nzIv
         cJFdJrLM4wGuoRiURMxZPTXYseM+JVr7fpIy4YoNdwBBtH7u2XLA+sTo/0XVtGEOn5be
         HVmWuUkjulnzm1hrg4/sBYYLnQOm5c6hVTC4d8pxTRBdsRTuiWpTNN9kH1a8gNmY89Ik
         u09lCeywlyEScHmalOnR+tD410aknEWd75VrGCTdehQPxzRU/53EFareLT64s7u4t3EY
         II6+5sUwsy/wUpXslzTx4SBzhrSRLTiSAoslnJxkVCOfYaF+7Ion4lVp6ha7Pz0HKtoR
         9LQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBGQZK/3aAxO+6Yo6iJc0VSrc+5iddhhSIsyRfhe+a5jwhThvHe/IZjYBVHPMoc12S6HAYnQCdNYAMk/M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8X8mJMdLxAocgLpZqQeDkdRhldQ6XmD2mrCP37Dx7ug94S5Fk
	SRnaKhJhr1IiZIBGes3BE2m6YEOVX76W6dx96oDraFmt2cc74VC9qa7J0HNUwQ4YGSByxlj9GSz
	tMcHf
X-Google-Smtp-Source: AGHT+IH3sHXReDQEa8RxtpqbZcZDB+/yVQA1cTTF2J3vmcFQjEhRGWaZDAjf6dGNFzi6A5L8Oa/pFQ==
X-Received: by 2002:a05:6a00:1786:b0:706:284f:6a68 with SMTP id d2e1a72fcca58-717449b1d09mr3399540b3a.23.1725274665565;
        Mon, 02 Sep 2024 03:57:45 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:43a1:71e3:7464:e91b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55a51e9sm6633769b3a.78.2024.09.02.03.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 03:57:45 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv7 20/24] zram: add dictionary support to lz4
Date: Mon,  2 Sep 2024 19:56:08 +0900
Message-ID: <20240902105656.1383858-21-senozhatsky@chromium.org>
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

Support pre-trained dictionary param. lz4 doesn't
mandate specific format of the dictionary and even
zstd --train can be used to train a dictionary for
lz4, according to [1].

TEST
====

*** lz4
/sys/block/zram0/mm_stat
1750654976 664188565 676864000        0 676864000        1        0    34288    34288

*** lz4 dict=/etc/lz4-dict-amd64
/sys/block/zram0/mm_stat
1750638592 619891141 632053760        0 632053760        1        0    34278    34278

*** lz4 level=5 dict=/etc/lz4-dict-amd64
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
2.46.0.469.g59c65b2a67-goog


