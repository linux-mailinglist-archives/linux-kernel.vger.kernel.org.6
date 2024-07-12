Return-Path: <linux-kernel+bounces-250183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B972692F4FE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 07:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 762E328133C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 05:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FDF13666F;
	Fri, 12 Jul 2024 05:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b5lGTDOg"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B8A134409
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 05:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720761578; cv=none; b=OO219VPBFiCiTH5ERmzfVRuhdyi3p3qaFrmtz6Jdkxk7AUG38EBKc0Bv9iKehZhRqeuzx5ELc6eMzuyNUsP9iS1nnxmC9IrZ3Qz5xm6bHDHJrx9KIvyfdnui7z0SeNHEUoT888NCc6GcW15LBN7+D7L9gXUY8JhmnW2mK7X4W+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720761578; c=relaxed/simple;
	bh=GATKpyXWE8hTvPDzPhCl+JMRpVE3IZhLa5/tLsowPmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TfGW/j/a41uh/eaL6+H3UTfovscCmZSV7etMbzbeDpVYmNgoa0mt9vKsS2svqw/prlvV0pv1GL0LTtf7kLIEgsGDPl2Gswbm2gJ0/Pe+mYRZK0wt4s95mhfyB6b0Xc8CybwVKqvgKTZWLGzkZC984oP0W+EE5DOKJR6vfa4bUFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=b5lGTDOg; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-25e0c0df558so767373fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 22:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720761576; x=1721366376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lkvMhO5tJBHwbauNuFvcStMN53VUkERyuHIOYpstgkw=;
        b=b5lGTDOgF6jUV/Ca7krXdoiOYiLmhpg/y4NI82TCEU84O1eqfGoLA6QEg5JNvoEIxA
         EgNbwPQvNun6OLsUU6rHKSR93Oo+78ZTtAMdYWk9PedSuv8HjU3Ic3QP4Mh+TQ+qQJnm
         rLBciWe1yWTRWkHgYbSl5TmIak+AIDL8TwFp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720761576; x=1721366376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lkvMhO5tJBHwbauNuFvcStMN53VUkERyuHIOYpstgkw=;
        b=cuck2/fw/ASJv4JIKOrZIMhxbQVHvh9CNmc0oB+TGRl2Nrv+m/YOXmNmqF5paUW4LT
         7B8UF5hQOaakJqRYkBznAwzhH4PlSJpzIMMckVeX4KjAM07iE04GvrEE4gYy0O3ZwXzD
         ExQBPP9iQVpvxTkCjyG8aUEVbvYBkRMcOkNxRtk7zKrsGA/IygDMM51FSvGh+Wu8KVKw
         pRMYpYglXX5PiqLD5vodihl/aOteDdWh8HlY1DmSSaIuUumka2RKtKAD8nt+6Tv2QJVX
         gDUFopBHKOIQkqq1/af1OqvAM9Lov0+v8+K1bDdz004awY/15gNYvpO1OANTXX8kpu7B
         l7sA==
X-Gm-Message-State: AOJu0YzDj2ke2WhxqZ3Ri0OxeRxaAO+Lb04iPgPaiCvDLbgl8XyUsdnW
	A08/89+An5m1isGLpbOpkD7N5Q/WPvokaTxXRRj7d/qqnRvgeXJDWDxn9wSLYw==
X-Google-Smtp-Source: AGHT+IFTTgm3AyRTARBBsl0DcUihLcIW7vRNEyk9m0iGo73r6yB5FIqA+GRyeXo1Z/O0RWe1vSGluA==
X-Received: by 2002:a05:6870:c1d3:b0:258:44b7:b842 with SMTP id 586e51a60fabf-25eae7b8802mr9626375fac.13.1720761576076;
        Thu, 11 Jul 2024 22:19:36 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:15f3:5252:ec56:52ae])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b43967851sm6553436b3a.109.2024.07.11.22.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 22:19:35 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v6 14/23] zram: recalculate zstd compression params once
Date: Fri, 12 Jul 2024 14:18:25 +0900
Message-ID: <20240712051850.484318-15-senozhatsky@chromium.org>
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

zstd compression params depends on level, but are constant
for a given instance of zstd compression backend.  Calculate
once (during ctx creation).

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/backend_zstd.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/block/zram/backend_zstd.c b/drivers/block/zram/backend_zstd.c
index c356c5e6e503..7c6798f0c912 100644
--- a/drivers/block/zram/backend_zstd.c
+++ b/drivers/block/zram/backend_zstd.c
@@ -10,6 +10,7 @@
 struct zstd_ctx {
 	zstd_cctx *cctx;
 	zstd_dctx *dctx;
+	zstd_parameters cprm;
 	void *cctx_mem;
 	void *dctx_mem;
 	s32 level;
@@ -40,6 +41,7 @@ static void *zstd_create(struct zcomp_params *params)
 		ctx->level = zstd_default_clevel();
 
 	prm = zstd_get_params(ctx->level, PAGE_SIZE);
+	ctx->cprm = zstd_get_params(ctx->level, PAGE_SIZE);
 	sz = zstd_cctx_workspace_bound(&prm.cParams);
 	ctx->cctx_mem = vzalloc(sz);
 	if (!ctx->cctx_mem)
@@ -69,11 +71,10 @@ static int zstd_compress(void *ctx, const unsigned char *src, size_t src_len,
 			 unsigned char *dst, size_t *dst_len)
 {
 	struct zstd_ctx *zctx = ctx;
-	const zstd_parameters prm = zstd_get_params(zctx->level, PAGE_SIZE);
 	size_t ret;
 
 	ret = zstd_compress_cctx(zctx->cctx, dst, *dst_len,
-				 src, src_len, &prm);
+				 src, src_len, &zctx->cprm);
 	if (zstd_is_error(ret))
 		return -EINVAL;
 	*dst_len = ret;
-- 
2.45.2.993.g49e7a77208-goog


