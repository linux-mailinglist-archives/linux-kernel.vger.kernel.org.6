Return-Path: <linux-kernel+bounces-243058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8AA929100
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 07:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31FDC2834E5
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 05:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E2613AD2F;
	Sat,  6 Jul 2024 04:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ItpGktnp"
Received: from mail-il1-f194.google.com (mail-il1-f194.google.com [209.85.166.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F3113A40F
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 04:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720241860; cv=none; b=Y3fUpPf8vncywpieKRQT1k0YBEaZrH0Z8RrzUoFZqcYvZm44E+YIk3BvOFuA6Hbq9kXgUF/kjSu3tgdmZyWnAPEEl5TdZPkgXXNkEoCc8cspMpzp3i4mkPu08c2h6Mo7uXKx8+wpyjAflGQQ8YQAlME0BCuJqNrA26GOAnJVioQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720241860; c=relaxed/simple;
	bh=iMNYeVm8sBFa5w57DrFIFjE9IDO3RbM2EovdTMz13oI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k91prhzzsrYITX3yTMmt7CTpxMNodKah8VaCwTrtWGh1PYbZ41EKfG31wBX4WCWGy8J76FkKYpENJ84YAdHrunvJFQj4qF5onTXVleYl85w4iA9NG1RryBCbQR8n+2swTxllmbCROUnGAKV8PKlgAHVW9jfFjQGsogdwK6xcJls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ItpGktnp; arc=none smtp.client-ip=209.85.166.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-il1-f194.google.com with SMTP id e9e14a558f8ab-376208fbe7bso8807395ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 21:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720241858; x=1720846658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wqv6OJ5QyUalkFrgMWzieb+OEsEN7EcQXglqct7c7eE=;
        b=ItpGktnpuFXdYE40Oo/IzsxQpUpdFvlrn5kyLF/5x7BWPVvyDIimrazuY0kLOo1zwl
         tGfzP6BI0RtbEBDLpda1XHIwJJJfuuxlKNHwWC/r0nkfJv05Zo2FaqBhuxEM08k2R0ZU
         7oqyok01OZpZLk9P0ugQTP5nVBbFmBHQsxcjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720241858; x=1720846658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wqv6OJ5QyUalkFrgMWzieb+OEsEN7EcQXglqct7c7eE=;
        b=nt5Nx0wwUC7FnwgXVV/ezIVx/AkpzXmniuXAZISEEuTd21zwgtSDTP4Xtkvy8DyW5Q
         eBjeJ73hsheLBUsbhp630cNYmRZ2N1Yx1NjdVhJDnj/uLcE1q2oeoPfNMTcD2GuzvvA5
         Cp8Xfrf0QDHKHv5PM6XOhGQVaPb43pn0UbMLNI0B9J/DDf28comi7rgnNdyc6lAU9p6j
         QAwCDC+gmuGePAgkLETkIfbXxODBmGqIzQuekuzOf9g9HzXpfDyo+o5HefHjH4WWPhYZ
         0w+ywXzprugAOFGQ2k4Xdv94CsMZjmn8XrmKV4bLmSD9e2tktaADQaWUvDnGbEopAQqX
         caZg==
X-Gm-Message-State: AOJu0Yy7SyVcR+utgy6NcbfE02fMTYnQsKr220MZDTbJzl6zWtIJwGKE
	DJYV+H7FE8JZqubkfb+uJH8752pzipaUxt9HP25JEbvX/9xgL4UrcG3Doe+XmQ==
X-Google-Smtp-Source: AGHT+IFK1hIw7iP6V4TYzdEvb9ZtKXA8UgulI5UO36N9k7wXGTdWwg1qJY80+sFT5VIHJebPK3k0fA==
X-Received: by 2002:a05:6e02:2141:b0:375:b52f:334e with SMTP id e9e14a558f8ab-3839b099870mr89881395ab.22.1720241858270;
        Fri, 05 Jul 2024 21:57:38 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:88a7:e7d7:713d:ff09])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7623cd854b2sm2784104a12.38.2024.07.05.21.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 21:57:38 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv5 22/23] zram: add dictionary support to zstd backend
Date: Sat,  6 Jul 2024 13:56:24 +0900
Message-ID: <20240706045641.631961-23-senozhatsky@chromium.org>
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
index 3c8ba3232881..5a6940136cef 100644
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
2.45.2.803.g4e1b14247a-goog


