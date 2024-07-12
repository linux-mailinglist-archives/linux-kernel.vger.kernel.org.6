Return-Path: <linux-kernel+bounces-250192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A64B92F508
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 07:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 593631C21215
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 05:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1D013BAC6;
	Fri, 12 Jul 2024 05:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YnJ80XPn"
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com [209.85.210.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C4222EE8
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 05:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720761595; cv=none; b=Ek8ECQ45amtvk4TYJdaoLzwJ6QpIWodUociACO62belBPv0WZyjVDFvmnXAfOl+V6OdxnqGpNTWMmOmo/R6oPC0CS52Q6L0xPdfYHDNX9Rs9PrT/M9D3GY6y07Jqp4cbYOI/a2doe+5q0YX0f/6kRW+V2r7TP+NpFyiG64qxvpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720761595; c=relaxed/simple;
	bh=lIu2cKbtMq8P8bTKzOPWh7Yz083/sTfChl59J3BIqTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LpMgOvn42l0V9OvP2wfcSdnkypGiKmNcgQDv5oXT1lvRq1mb669pq9qzzZCLzUPEH1dAX95oIdxA49JQD4r01TKtdGLcXmg28O9pBbWSsq0v5VmUTk4hGKChwxAo933miSwp7txG9IGx6GPFupJqmCrqJBsI5GVGZAsTcwL1vYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YnJ80XPn; arc=none smtp.client-ip=209.85.210.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f67.google.com with SMTP id 46e09a7af769-70445f0d9b8so965841a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 22:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720761593; x=1721366393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JCGwMP05WyVBgIPwBZ6xnpAZJ1Zv7M7TqzCkslB368o=;
        b=YnJ80XPnQQmUdjTM565s8SrPknQUmhqvQ3+/xxr93szGe9+DJTYQG/AGkfMvmfBm2K
         2x1orgdDfvG7utv1lwGpGpunJRofCY8EpdUjjdFDpv06XeIh7HmExvAvsX83yJmu7SdT
         0Ey50IW7fk+K/K4M8Y1Xbx1m+aFbxLglf/zwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720761593; x=1721366393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JCGwMP05WyVBgIPwBZ6xnpAZJ1Zv7M7TqzCkslB368o=;
        b=Z7tBErZlwWLvRuaFE6L7NKVOFTjO19FPHGSh7qI9ee321qPnb9qGCtUaSw6zW/Y0u2
         g7ACSU7GPOYLN0BBm6C1jz2Y3O5pTajQuuV3NNSaAshNR5GGJf73NFZfUeNL6A0/jy5u
         bxDfEyI4p68XnVIVE0y/crjiXIKIf1nIco7OrgCiPhixGrv5FRhv9HKYLxgVNvMkxQmk
         bOjmVoCcuv8vimVgYqJxyMjWTS5mAb4yiv39fbobKb5YfgQbExdaaTBj8eDqnorffDKM
         2SV1cvz0azwar167oLR7IEKbS2aTn/Kdh2i4BMuMe9zuHGb63792qA7JImsKBC1PMd3x
         JgHQ==
X-Gm-Message-State: AOJu0Yy34thf2DIuiLYwgHu+qxt0V/zkU33hzJM5Oh2xBhEAYTcfFdvP
	01Cztr6Bq/n2rudIhUrsPsclIFO6sUg04QHJb55Nknmq3psXhzTEpjToGMKCYWmj01qHIckuU8S
	zybEeMiQ=
X-Google-Smtp-Source: AGHT+IEz96Kg+GObK/ZMafk0DpbDPCWjgQUXEH5idPdG/J6B6jpF/Pk9kEkxJnC3yTNMKLEluGjDjg==
X-Received: by 2002:a05:6830:e81:b0:703:64c6:305b with SMTP id 46e09a7af769-703759faebdmr11525118a34.2.1720761592805;
        Thu, 11 Jul 2024 22:19:52 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:15f3:5252:ec56:52ae])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b43967851sm6553436b3a.109.2024.07.11.22.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 22:19:52 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v6 22/23] zram: add dictionary support to zstd backend
Date: Fri, 12 Jul 2024 14:18:33 +0900
Message-ID: <20240712051850.484318-23-senozhatsky@chromium.org>
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

This adds support for pre-trained zstd dictionaries [1]
Dictionary is setup in params once (per-comp) and loaded
to Cctx and Dctx by reference, so we don't allocate extra
memory.

TEST
====

*** zstd
/sys/block/zram0/mm_stat
1750654976 504565092 514203648        0 514203648        1        0    34204    34204

*** zstd dict=/home/ss/zstd-dict-amd64
/sys/block/zram0/mm_stat
1750638592 465851259 475373568        0 475373568        1        0    34185    34185

*** zstd level=8 dict=/home/ss/zstd-dict-amd64
/sys/block/zram0/mm_stat
1750642688 430765171 439955456        0 439955456        1        0    34185    34185

[1] https://github.com/facebook/zstd/blob/dev/programs/zstd.1.md#dictionary-builder

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/backend_zstd.c | 150 ++++++++++++++++++++++++------
 1 file changed, 124 insertions(+), 26 deletions(-)

diff --git a/drivers/block/zram/backend_zstd.c b/drivers/block/zram/backend_zstd.c
index 5b33daf4f645..1184c0036f44 100644
--- a/drivers/block/zram/backend_zstd.c
+++ b/drivers/block/zram/backend_zstd.c
@@ -15,29 +15,87 @@ struct zstd_ctx {
 };
 
 struct zstd_params {
+	zstd_custom_mem custom_mem;
+	zstd_cdict *cdict;
+	zstd_ddict *ddict;
 	zstd_parameters cprm;
 };
 
+/*
+ * For C/D dictionaries we need to provide zstd with zstd_custom_mem,
+ * which zstd uses internally to allocate/free memory when needed.
+ *
+ * This means that allocator.customAlloc() can be called from zcomp_compress()
+ * under local-lock (per-CPU compression stream), in which case we must use
+ * GFP_ATOMIC.
+ *
+ * Another complication here is that we can be configured as a swap device.
+ */
+static void *zstd_custom_alloc(void *opaque, size_t size)
+{
+	if (!preemptible())
+		return kvzalloc(size, GFP_ATOMIC);
+
+	return kvzalloc(size, __GFP_KSWAPD_RECLAIM | __GFP_NOWARN);
+}
+
+static void zstd_custom_free(void *opaque, void *address)
+{
+	kvfree(address);
+}
+
 static void zstd_release_params(struct zcomp_params *params)
 {
-	kfree(params->drv_data);
+	struct zstd_params *zp = params->drv_data;
+
+	params->drv_data = NULL;
+	if (!zp)
+		return;
+
+	zstd_free_cdict(zp->cdict);
+	zstd_free_ddict(zp->ddict);
+	kfree(zp);
 }
 
 static int zstd_setup_params(struct zcomp_params *params)
 {
+	zstd_compression_parameters prm;
 	struct zstd_params *zp;
 
 	zp = kzalloc(sizeof(*zp), GFP_KERNEL);
 	if (!zp)
 		return -ENOMEM;
 
+	params->drv_data = zp;
 	if (params->level == ZCOMP_PARAM_NO_LEVEL)
 		params->level = zstd_default_clevel();
 
 	zp->cprm = zstd_get_params(params->level, PAGE_SIZE);
-	params->drv_data = zp;
+
+	zp->custom_mem.customAlloc = zstd_custom_alloc;
+	zp->custom_mem.customFree = zstd_custom_free;
+
+	prm = zstd_get_cparams(params->level, PAGE_SIZE,
+			       params->dict_sz);
+
+	zp->cdict = zstd_create_cdict_byreference(params->dict,
+						  params->dict_sz,
+						  prm,
+						  zp->custom_mem);
+	if (!zp->cdict)
+		goto error;
+
+	zp->ddict = zstd_create_ddict_byreference(params->dict,
+						  params->dict_sz,
+						  zp->custom_mem);
+	if (!zp->ddict)
+		goto error;
 
 	return 0;
+
+error:
+	zstd_release_params(params);
+	return -EINVAL;
 }
 
 static void zstd_destroy(struct zcomp_ctx *ctx)
@@ -47,8 +105,23 @@ static void zstd_destroy(struct zcomp_ctx *ctx)
 	if (!zctx)
 		return;
 
-	vfree(zctx->cctx_mem);
-	vfree(zctx->dctx_mem);
+	/*
+	 * If ->cctx_mem and ->dctx_mem were allocated then we didn't use
+	 * C/D dictionary and ->cctx / ->dctx were "embedded" into these
+	 * buffers.
+	 *
+	 * If otherwise then we need to explicitly release ->cctx / ->dctx.
+	 */
+	if (zctx->cctx_mem)
+		vfree(zctx->cctx_mem);
+	else
+		zstd_free_cctx(zctx->cctx);
+
+	if (zctx->dctx_mem)
+		vfree(zctx->dctx_mem);
+	else
+		zstd_free_dctx(zctx->dctx);
+
 	kfree(zctx);
 }
 
@@ -63,28 +136,41 @@ static int zstd_create(struct zcomp_params *params, struct zcomp_ctx *ctx)
 		return -ENOMEM;
 
 	ctx->context = zctx;
-	prm = zstd_get_params(params->level, PAGE_SIZE);
-	sz = zstd_cctx_workspace_bound(&prm.cParams);
-	zctx->cctx_mem = vzalloc(sz);
-	if (!zctx->cctx_mem)
-		goto error;
-
-	zctx->cctx = zstd_init_cctx(zctx->cctx_mem, sz);
-	if (!zctx->cctx)
-		goto error;
-
-	sz = zstd_dctx_workspace_bound();
-	zctx->dctx_mem = vzalloc(sz);
-	if (!zctx->dctx_mem)
-		goto error;
-
-	zctx->dctx = zstd_init_dctx(zctx->dctx_mem, sz);
-	if (!zctx->dctx)
-		goto error;
+	if (params->dict_sz == 0) {
+		prm = zstd_get_params(params->level, PAGE_SIZE);
+		sz = zstd_cctx_workspace_bound(&prm.cParams);
+		zctx->cctx_mem = vzalloc(sz);
+		if (!zctx->cctx_mem)
+			goto error;
+
+		zctx->cctx = zstd_init_cctx(zctx->cctx_mem, sz);
+		if (!zctx->cctx)
+			goto error;
+
+		sz = zstd_dctx_workspace_bound();
+		zctx->dctx_mem = vzalloc(sz);
+		if (!zctx->dctx_mem)
+			goto error;
+
+		zctx->dctx = zstd_init_dctx(zctx->dctx_mem, sz);
+		if (!zctx->dctx)
+			goto error;
+	} else {
+		struct zstd_params *zp = params->drv_data;
+
+		zctx->cctx = zstd_create_cctx_advanced(zp->custom_mem);
+		if (!zctx->cctx)
+			goto error;
+
+		zctx->dctx = zstd_create_dctx_advanced(zp->custom_mem);
+		if (!zctx->dctx)
+			goto error;
+	}
 
 	return 0;
 
 error:
+	zstd_release_params(params);
 	zstd_destroy(ctx);
 	return -EINVAL;
 }
@@ -96,8 +182,14 @@ static int zstd_compress(struct zcomp_params *params, struct zcomp_ctx *ctx,
 	struct zstd_ctx *zctx = ctx->context;
 	size_t ret;
 
-	ret = zstd_compress_cctx(zctx->cctx, req->dst, req->dst_len,
-				 req->src, req->src_len, &zp->cprm);
+	if (params->dict_sz == 0)
+		ret = zstd_compress_cctx(zctx->cctx, req->dst, req->dst_len,
+					 req->src, req->src_len, &zp->cprm);
+	else
+		ret = zstd_compress_using_cdict(zctx->cctx, req->dst,
+						req->dst_len, req->src,
+						req->src_len,
+						zp->cdict);
 	if (zstd_is_error(ret))
 		return -EINVAL;
 	req->dst_len = ret;
@@ -107,11 +199,17 @@ static int zstd_compress(struct zcomp_params *params, struct zcomp_ctx *ctx,
 static int zstd_decompress(struct zcomp_params *params, struct zcomp_ctx *ctx,
 			   struct zcomp_req *req)
 {
+	struct zstd_params *zp = params->drv_data;
 	struct zstd_ctx *zctx = ctx->context;
 	size_t ret;
 
-	ret = zstd_decompress_dctx(zctx->dctx, req->dst, req->dst_len,
-				   req->src, req->src_len);
+	if (params->dict_sz == 0)
+		ret = zstd_decompress_dctx(zctx->dctx, req->dst, req->dst_len,
+					   req->src, req->src_len);
+	else
+		ret = zstd_decompress_using_ddict(zctx->dctx, req->dst,
+						  req->dst_len, req->src,
+						  req->src_len, zp->ddict);
 	if (zstd_is_error(ret))
 		return -EINVAL;
 	return 0;
-- 
2.45.2.993.g49e7a77208-goog


