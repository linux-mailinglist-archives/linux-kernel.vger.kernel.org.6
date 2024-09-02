Return-Path: <linux-kernel+bounces-311168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1CD5968596
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 13:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F1CCB23CD4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8C61DAC64;
	Mon,  2 Sep 2024 10:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QYw+kCS/"
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE211D6DD4
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 10:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725274672; cv=none; b=PBmbKpz/bHuv+5X5Wy3qs5OSL4LNTtmPPa5qG2R8RodddfKU6ZVdj7VOitqo9Grx7O2N56Pn1uUkO+5OI5ZOKjyjdmodSJLBs+FNtTrAaBV4NMNQFoy5OYyzLTe+OC9dHQ1kPDJdy9SV5ai0U6tILXHiUa/jorUuuO+cpKT3ycc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725274672; c=relaxed/simple;
	bh=LxK7yxVOuU/Mf7+dft522QNvM0qcckmP8rj7nOwAApM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=osObUw71EjJpM8cD9aCLl3dIpDXa23R5zP9inlATYyZra8uHRR/Lcn7K2751KII/sWuFusSMn/WdMdxZH3GxX6+O+H2dsNP2aKFM+90DoyzGvDSSu1LDOS9FzD7XP3DNDYXwxKIf8EYUMvOAiEfBWyTM3D/DGoWWYmF/yBBHEgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QYw+kCS/; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-7cda0453766so1297775a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 03:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725274670; x=1725879470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cbR1gFo0yq5XvwmrFtnpkMRAOk31bpE/Kw6nP8TwsWk=;
        b=QYw+kCS/twM1soIvTM8zf+jEQuFYosUPLpI2tUwHtZ8arinyPZ1Z3LbJbHJwtyoE6d
         G2cZqU6ZolMTLfrB9fDhas5LHobhwJ5yIq/xdllMyAPrrtdTkIOU0XOmw+Royn4Z6MuT
         aDGhVCjGmbonkk0nUxw23GxoCWszqQ73B/Oa8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725274670; x=1725879470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cbR1gFo0yq5XvwmrFtnpkMRAOk31bpE/Kw6nP8TwsWk=;
        b=U1OOjhg9YWFBW0ATC6vNFyT7b/LIsKpDYusIfnzZjAa42QyKVsdZ7Zd3UDTIiRu8TM
         4TPlG5WBwmwulA1eCHpTypQ7XUibfwgguBB6doL6aGAix4xPn2jZoE66eU+fEMMPXUxJ
         UChAHEWuGCRDnUfgLFskr04bh2fWZmTFZS9fwRr0Z5vmeV4f2I63yTMKi2ymr5FJI28z
         sGLSKaUi2Yt/8uXpuRQxUXOlEXEQHX3QuNjZT81ELySimC/45N/GN5JYAbdrjsDeO4re
         aV78Eo0eq8Nba7LCOkr47vPs/3aQswlMjPwyI82lsIS59+dG5Ipak9SIkYhiFUt95b77
         XEzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlVuMUZ8SyIRCEqg4VMftdkHcAryMeDiGdLmyxMQyJNPIqzyHBdewugdgC2ti4ZyeeD8c4LE/38kAcXMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEOMyY6rqQ7A0t2B47sRBg2NJsYrDs234/WMLItLOOsBqbtPuX
	Iit0rK0NibghmBmo1XZ6s51x0AqoyiVb+XZ4jnooak0xqkcwLdDrKapDkhXu5WEyMol03D0oV3v
	eWbXn
X-Google-Smtp-Source: AGHT+IFwfHrqJ2bHzNS/FwApFbvO9Bo6qKdoRwnyVi41LA71Z2a0ug42iBISEEf2FYdsuSJN+d+54A==
X-Received: by 2002:a05:6a21:151a:b0:1c6:ae03:6882 with SMTP id adf61e73a8af0-1cce10038ebmr14285361637.9.1725274669771;
        Mon, 02 Sep 2024 03:57:49 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:43a1:71e3:7464:e91b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55a51e9sm6633769b3a.78.2024.09.02.03.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 03:57:49 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv7 22/24] zram: add dictionary support to zstd backend
Date: Mon,  2 Sep 2024 19:56:10 +0900
Message-ID: <20240902105656.1383858-23-senozhatsky@chromium.org>
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

This adds support for pre-trained zstd dictionaries [1]
Dictionary is setup in params once (per-comp) and loaded
to Cctx and Dctx by reference, so we don't allocate extra
memory.

TEST
====

*** zstd
/sys/block/zram0/mm_stat
1750654976 504565092 514203648        0 514203648        1        0    34204    34204

*** zstd dict=/etc/zstd-dict-amd64
/sys/block/zram0/mm_stat
1750638592 465851259 475373568        0 475373568        1        0    34185    34185

*** zstd level=8 dict=/etc/zstd-dict-amd64
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
2.46.0.469.g59c65b2a67-goog


