Return-Path: <linux-kernel+bounces-179556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF688C6162
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 09:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDED41C21C8D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 07:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2715674B;
	Wed, 15 May 2024 07:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="So7SAHfS"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C495103D
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 07:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715757431; cv=none; b=CAzsdYsVFu81g8cmoeDf6tdIiq8pVvBEa4waIJXewm+oLdvij/JPBavjKQqFQ86YapuSHmvCn6Vu2JbuqFcT/qT4E3Crc9FGbu9VblTBewpS/h7nDVfUjkdtwFDw4mTw7SbJ5umSfhIeL2G88e5rzZk2fMUr+DjhUPrF4Am1iSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715757431; c=relaxed/simple;
	bh=qp4pzB90m9g55C+fAL/JlDtKkb1iY2MFD8dmhT5+bXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mSnscgW8jhdIt6pynR9GrCIfR7uMNQlTA14Oy45Fbd2bsy2W5pMNZAlWgvb3Umgy05Ugj8BhJOp6OUey24N75yos1ifFRZHGmGkYmE4XDpYYYi+5/f/ZBkdjzmMgC4gNrbRVLqSUer3gI4qhRSDxzRA91Q1jdq1i7AdkxBeMVCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=So7SAHfS; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1eb24e3a2d9so57048935ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 00:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715757429; x=1716362229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J/F4eHWC20T9jERmFYhVQI8aXCSk3r/5sAst+t3cPEA=;
        b=So7SAHfSG1tRJ+ZYNXTpChZVTSHS1gZDbC3+LlPMQowXPa+fKV+UZ135EB9+edEZgO
         CjNV2ZbhlxhReSr7BYkRM5wXAXbvTGV/VsWOyWctenZyWaBBQknbZFmQi1wo6He5vkTx
         vXOyJWOf+UU+GvLbFxaU6mfmr0BKCYtNO2GnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715757429; x=1716362229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J/F4eHWC20T9jERmFYhVQI8aXCSk3r/5sAst+t3cPEA=;
        b=rB5y8ww5J2Pc0EW82JLgMlfsVxFfp+4g7L5rm6b/p8QqAMInfTv4FCshBX3lW72+Fz
         /ZRAcdd/F43yAY1u3mSXHss37McBcTiuIczOJ+USrWXUPUUuiGLw/DKtHRsDeBd+Ytdt
         LWVp9+9FNecjQjCi6q5J5B0pcEr3MGGlNyhVFunZzXTyQT5y6GOSnaSSpsMN/QFak9wa
         EbHfVHBkuc0p6g33NN7adt9lXBIPoc1e7Pd0H3w8b3/g4A3BHE2k/7K/i/c9tQ2M2iJ5
         I7ZtwDPbb+l7VReYyn3HyKDvf4zoCc8cSuHct4hTvLcXl95dTu2bN4J46ZiE660ku+Zv
         /XBw==
X-Gm-Message-State: AOJu0YyfCXNZwgLnGejeM7SCWH1TbrKAls73WeNg9psgPEi8v3MDbPB3
	UO2zKA0pidDEUkToR3jmbYmi/6nECBeHTJEsfzhngykP9v7w3IlJP7uzO5qIvQ==
X-Google-Smtp-Source: AGHT+IFR8beUNV/civmOKa/JzrQT21TYGy2xDo+9rfsbtHXdFVJDdpYHoSOshN3+CoSvN5XhewZdRA==
X-Received: by 2002:a17:902:d64c:b0:1e3:e1d5:c680 with SMTP id d9443c01a7336-1ef4404e097mr174785415ad.63.1715757429001;
        Wed, 15 May 2024 00:17:09 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:111d:a618:3172:cd5b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c136d53sm110941605ad.254.2024.05.15.00.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 00:17:08 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv4 05/21] zram: add zstd compression backend support
Date: Wed, 15 May 2024 16:12:42 +0900
Message-ID: <20240515071645.1788128-6-senozhatsky@chromium.org>
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

Add s/w zstd compression.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/Kconfig        | 11 ++++
 drivers/block/zram/Makefile       |  1 +
 drivers/block/zram/backend_zstd.c | 97 +++++++++++++++++++++++++++++++
 drivers/block/zram/backend_zstd.h | 10 ++++
 drivers/block/zram/zcomp.c        |  4 ++
 5 files changed, 123 insertions(+)
 create mode 100644 drivers/block/zram/backend_zstd.c
 create mode 100644 drivers/block/zram/backend_zstd.h

diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
index 0d890a8d2dc4..71cd0d5d8f35 100644
--- a/drivers/block/zram/Kconfig
+++ b/drivers/block/zram/Kconfig
@@ -32,6 +32,12 @@ config ZRAM_BACKEND_LZ4HC
 	select LZ4HC_COMPRESS
 	select LZ4_DECOMPRESS
 
+config ZRAM_BACKEND_ZSTD
+	bool "zstd compression support"
+	depends on ZRAM
+	select ZSTD_COMPRESS
+	select ZSTD_DECOMPRESS
+
 choice
 	prompt "Default zram compressor"
 	default ZRAM_DEF_COMP_LZORLE
@@ -53,6 +59,10 @@ config ZRAM_DEF_COMP_LZ4HC
 	bool "lz4hc"
 	depends on ZRAM_BACKEND_LZ4HC
 
+config ZRAM_DEF_COMP_ZSTD
+	bool "zstd"
+	depends on ZRAM_BACKEND_ZSTD
+
 endchoice
 
 config ZRAM_DEF_COMP
@@ -61,6 +71,7 @@ config ZRAM_DEF_COMP
 	default "lzo" if ZRAM_DEF_COMP_LZO
 	default "lz4" if ZRAM_DEF_COMP_LZ4
 	default "lz4hc" if ZRAM_DEF_COMP_LZ4HC
+	default "zstd" if ZRAM_DEF_COMP_ZSTD
 	default "unset-value"
 
 config ZRAM_WRITEBACK
diff --git a/drivers/block/zram/Makefile b/drivers/block/zram/Makefile
index 727c9d68e3e3..a2ca227e199c 100644
--- a/drivers/block/zram/Makefile
+++ b/drivers/block/zram/Makefile
@@ -5,5 +5,6 @@ zram-y	:=	zcomp.o zram_drv.o
 zram-$(CONFIG_ZRAM_BACKEND_LZO)		+= backend_lzorle.o backend_lzo.o
 zram-$(CONFIG_ZRAM_BACKEND_LZ4)		+= backend_lz4.o
 zram-$(CONFIG_ZRAM_BACKEND_LZ4HC)	+= backend_lz4hc.o
+zram-$(CONFIG_ZRAM_BACKEND_ZSTD)	+= backend_zstd.o
 
 obj-$(CONFIG_ZRAM)	+=	zram.o
diff --git a/drivers/block/zram/backend_zstd.c b/drivers/block/zram/backend_zstd.c
new file mode 100644
index 000000000000..bfe836844232
--- /dev/null
+++ b/drivers/block/zram/backend_zstd.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+#include <linux/zstd.h>
+
+#include "backend_zstd.h"
+
+struct zstd_ctx {
+	zstd_cctx *cctx;
+	zstd_dctx *dctx;
+	void *cctx_mem;
+	void *dctx_mem;
+	s32 level;
+};
+
+static void zstd_destroy(void *ctx)
+{
+	struct zstd_ctx *zctx = ctx;
+
+	vfree(zctx->cctx_mem);
+	vfree(zctx->dctx_mem);
+	kfree(zctx);
+}
+
+static void *zstd_create(void)
+{
+	zstd_parameters params;
+	struct zstd_ctx *ctx;
+	size_t sz;
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return NULL;
+
+	ctx->level = zstd_default_clevel();
+	params = zstd_get_params(ctx->level, 0);
+	sz = zstd_cctx_workspace_bound(&params.cParams);
+	ctx->cctx_mem = vzalloc(sz);
+	if (!ctx->cctx_mem)
+		goto error;
+
+	ctx->cctx = zstd_init_cctx(ctx->cctx_mem, sz);
+	if (!ctx->cctx)
+		goto error;
+
+	sz = zstd_dctx_workspace_bound();
+	ctx->dctx_mem = vzalloc(sz);
+	if (!ctx->dctx_mem)
+		goto error;
+
+	ctx->dctx = zstd_init_dctx(ctx->dctx_mem, sz);
+	if (!ctx->dctx)
+		goto error;
+
+	return ctx;
+
+error:
+	zstd_destroy(ctx);
+	return NULL;
+}
+
+static int zstd_compress(void *ctx, const unsigned char *src,
+			 unsigned char *dst, size_t *dst_len)
+{
+	struct zstd_ctx *zctx = ctx;
+	const zstd_parameters params = zstd_get_params(zctx->level, 0);
+	size_t ret;
+
+	ret = zstd_compress_cctx(zctx->cctx, dst, *dst_len,
+				 src, PAGE_SIZE, &params);
+	if (zstd_is_error(ret))
+		return -EINVAL;
+	*dst_len = ret;
+	return 0;
+}
+
+static int zstd_decompress(void *ctx, const unsigned char *src, size_t src_len,
+			   unsigned char *dst)
+{
+	struct zstd_ctx *zctx = ctx;
+	size_t ret;
+
+	ret = zstd_decompress_dctx(zctx->dctx, dst, PAGE_SIZE, src, src_len);
+	if (zstd_is_error(ret))
+		return -EINVAL;
+	return 0;
+}
+
+struct zcomp_backend backend_zstd = {
+	.compress	= zstd_compress,
+	.decompress	= zstd_decompress,
+	.create_ctx	= zstd_create,
+	.destroy_ctx	= zstd_destroy,
+	.name		= "zstd",
+};
diff --git a/drivers/block/zram/backend_zstd.h b/drivers/block/zram/backend_zstd.h
new file mode 100644
index 000000000000..75d2d2c02768
--- /dev/null
+++ b/drivers/block/zram/backend_zstd.h
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#ifndef __BACKEND_ZSTD_H__
+#define __BACKEND_ZSTD_H__
+
+#include "zcomp.h"
+
+extern struct zcomp_backend backend_zstd;
+
+#endif /* __BACKEND_ZSTD_H__ */
diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index f04f5844a23c..c16eb038f608 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -19,6 +19,7 @@
 #include "backend_lzorle.h"
 #include "backend_lz4.h"
 #include "backend_lz4hc.h"
+#include "backend_zstd.h"
 
 static struct zcomp_backend *backends[] = {
 #if IS_ENABLED(CONFIG_ZRAM_BACKEND_LZO)
@@ -30,6 +31,9 @@ static struct zcomp_backend *backends[] = {
 #endif
 #if IS_ENABLED(CONFIG_ZRAM_BACKEND_LZ4HC)
 	&backend_lz4hc,
+#endif
+#if IS_ENABLED(CONFIG_ZRAM_BACKEND_ZSTD)
+	&backend_zstd,
 #endif
 	NULL
 };
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


