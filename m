Return-Path: <linux-kernel+bounces-243044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 881319290F2
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 06:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 085BD1F21771
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 04:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32E74501F;
	Sat,  6 Jul 2024 04:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PMwXS606"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C2F3EA98
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 04:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720241829; cv=none; b=uzz/iANgWwCSdaIYNt5XYINaJgtJ4HY2FqhGtG18qTdte/xh4/d82UiciPpa9o79JthSICDduGTML9FfpysuECgroWALqYosFG+UB/KRkkj3qBk0lFOnsAePyZH7ty6iExmS1ehzfwPo9jS1XMMnoRgL/UjFRGbBc084Cn/Kk0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720241829; c=relaxed/simple;
	bh=lNZrqpWs9a1laLkmBuQCpzIWBGvQuyFh349lB2CY5kQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QgZhaVyNaqg9EaKy5yUIlJplXo4heK1znDXn8aBGEWBJ8+gaoZJdIdFIN4rqvLgDY1d9uZFKSiHDbgxOXmlAsNe1Bvi0sqzSCPQc9hbEvoiBF9YK125BFBKGGPIBYo6F+Rs4BOk6ke1D06kW2ZAGQlZa6PRuKppkD7Hpgw0WeG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PMwXS606; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-375858224adso8700525ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 21:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720241827; x=1720846627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oY1U945XmfjcoVZRgtPNuwuX08Cf3l1MfFMAfTHouwY=;
        b=PMwXS606reM6Rt/ynZE0hhY8qzJBoyPkFUtBVoaZ87TvLyJLWwtztbWiheVlyiK2tA
         hPln7hgNU3EDsTprSFir1+UzIZNvpDISS08wdVjyw6MGiBJ8WTbUjNcsc4MYecOL28fw
         fxmS7N8pI6Iuhutgb/luyxscbNfVWTN/Yxl7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720241827; x=1720846627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oY1U945XmfjcoVZRgtPNuwuX08Cf3l1MfFMAfTHouwY=;
        b=jCW8v3XIcdjuyWMelSRGbgxxhlvovCGSSHnbUOicYLbeO6v3N1nEmCn/WpEl8V/2fw
         blq/Q11m5J/qRZfPuxf+xvWJhE6ARkcwPZ7VEzl/e9cb3W3yftHh90yOdBhMzZ6i8PE6
         U7HSZ1R0SFCGbfWlfpjs1ei4IYF6lHFi7E8m970pwxiMfo6xE872umPPa/ft8xWu6S3G
         P02Se43mOFHiq4JjxJQGDQae3L7kzdY/GXF3Opc57CkDCrTfkp6Iwu2r2diT9LzIPctW
         2NWdNIQQGGnZNaqRq+ru8iJJbTxG/+ENey9cJE0R3YBe8q0hyGgn6VXyxmJ6+f8qSYoI
         vpCg==
X-Gm-Message-State: AOJu0YzJ5OO31kChEZExUa20K3i67I7OvV8luwNVSjaUvzQ44B8xHjZU
	yiHxCalTXGlyxRXxoUMF4SHCUf9GH6r8h3znQwgqaWiezBwzHq2JH/aNhW2BBg==
X-Google-Smtp-Source: AGHT+IHOLntQbLpzJVWd3q9AXAh1vP3fsqc4dy9tljuo5ob0zaPpKLsPV0l4ec2SZdb3ZZs7QpDpTA==
X-Received: by 2002:a05:6e02:1a02:b0:376:410b:ae76 with SMTP id e9e14a558f8ab-38398af7a16mr75585405ab.11.1720241827564;
        Fri, 05 Jul 2024 21:57:07 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:88a7:e7d7:713d:ff09])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7623cd854b2sm2784104a12.38.2024.07.05.21.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 21:57:07 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv5 08/23] zram: add zstd compression backend support
Date: Sat,  6 Jul 2024 13:56:10 +0900
Message-ID: <20240706045641.631961-9-senozhatsky@chromium.org>
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
index 72751cb2b532..ee4fe2ee3413 100644
--- a/drivers/block/zram/Kconfig
+++ b/drivers/block/zram/Kconfig
@@ -33,6 +33,12 @@ config ZRAM_BACKEND_LZ4HC
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
@@ -54,6 +60,10 @@ config ZRAM_DEF_COMP_LZ4HC
 	bool "lz4hc"
 	depends on ZRAM_BACKEND_LZ4HC
 
+config ZRAM_DEF_COMP_ZSTD
+	bool "zstd"
+	depends on ZRAM_BACKEND_ZSTD
+
 endchoice
 
 config ZRAM_DEF_COMP
@@ -62,6 +72,7 @@ config ZRAM_DEF_COMP
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
index 000000000000..d0d01df2261f
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
+static int zstd_compress(void *ctx, const unsigned char *src, size_t src_len,
+			 unsigned char *dst, size_t *dst_len)
+{
+	struct zstd_ctx *zctx = ctx;
+	const zstd_parameters params = zstd_get_params(zctx->level, 0);
+	size_t ret;
+
+	ret = zstd_compress_cctx(zctx->cctx, dst, *dst_len,
+				 src, src_len, &params);
+	if (zstd_is_error(ret))
+		return -EINVAL;
+	*dst_len = ret;
+	return 0;
+}
+
+static int zstd_decompress(void *ctx, const unsigned char *src, size_t src_len,
+			   unsigned char *dst, size_t dst_len)
+{
+	struct zstd_ctx *zctx = ctx;
+	size_t ret;
+
+	ret = zstd_decompress_dctx(zctx->dctx, dst, dst_len, src, src_len);
+	if (zstd_is_error(ret))
+		return -EINVAL;
+	return 0;
+}
+
+struct zcomp_ops backend_zstd = {
+	.compress	= zstd_compress,
+	.decompress	= zstd_decompress,
+	.create_ctx	= zstd_create,
+	.destroy_ctx	= zstd_destroy,
+	.name		= "zstd",
+};
diff --git a/drivers/block/zram/backend_zstd.h b/drivers/block/zram/backend_zstd.h
new file mode 100644
index 000000000000..300b9fe635a1
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
+extern struct zcomp_ops backend_zstd;
+
+#endif /* __BACKEND_ZSTD_H__ */
diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index 1423b177dc30..c2441023356f 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -16,6 +16,7 @@
 #include "backend_lzorle.h"
 #include "backend_lz4.h"
 #include "backend_lz4hc.h"
+#include "backend_zstd.h"
 
 static struct zcomp_ops *backends[] = {
 #if IS_ENABLED(CONFIG_ZRAM_BACKEND_LZO)
@@ -27,6 +28,9 @@ static struct zcomp_ops *backends[] = {
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
2.45.2.803.g4e1b14247a-goog


