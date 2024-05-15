Return-Path: <linux-kernel+bounces-179558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E52A68C616C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 09:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 143061C2177A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 07:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2D65B5B6;
	Wed, 15 May 2024 07:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m4Rm2UYo"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC3259B68
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 07:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715757436; cv=none; b=bkhHF3SbZ2k8wMR+CziE2LefdJuoExl6cpAk4I1Y1iPmt0xf+ie4g5eMIB+/L+aF8a3beh5TFSr1Y/fFn4VhpAs4J8CTGnDsffiQHVm+xqe481TfxSkOIodTJbikvy1rNcFYZD9mVaxQ7Ab6rlalgqPNMEY1iTM6MrimcWLIk/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715757436; c=relaxed/simple;
	bh=KCnNcRrdNNXPCLyOiCquIu29kMdtXA8DR2xEEGBW8rU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Py2cWa2B59pw29e4bNSTFMDMA4EwmqxCbpp2aSw2qu+QX3KVBWs742d524Qtx9gWXnp6vwQoeQRIGhJ9YEPbdRmUaZUPdrErvep04TfQrx3Lq8brRSYEz9Mc2IVc2FYwkVbVS89pdctXuWGoXJUnXgUvyhZh+KuodA2GLoeyDxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=m4Rm2UYo; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-602801ea164so4516786a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 00:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715757434; x=1716362234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y95jRkO+GQnVvfMlitMFd5UTtBybaGLJy7YbFRNgOjw=;
        b=m4Rm2UYo6OPV4yeac4SynDYQZwAT0/5Vvw0IAJLs0ajQf8rKDf5L5wbOpXKnfpTYN1
         n9OvV2v+Z8+JO0LkoxZD6q07sMR2TziMr3pNvPJWJQdbmFp2Cz3GT9KcB1eiWq/dHYO/
         NidIxRqBxDXe0h+jRSM/KrblHlVZjza1ae+rU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715757434; x=1716362234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y95jRkO+GQnVvfMlitMFd5UTtBybaGLJy7YbFRNgOjw=;
        b=mcaORn/UYdM1lEEdrDZwiXKAKknT13qOIuT/LX9HGkBYRK22a5g4Awc54EFxySK+uC
         hpDIUlEVg64Em7b5KoUWlMs8ya03Pq4vm7CDfHdgHjgDxEshcesy5mgb50A5w1DIHRv4
         qtYdawirOdMfuND8e7gYWe5YwebDGXK/OTWiTMYqP4YVnsqNZrelAEwIe7d1R4k6WUWc
         tBbLC7xs1VE6QWl5AdatnOUmmsYH4DG/J9Qqn0BLIvVhfZ3OJzMWvsetEfesAD+30H+n
         /cUzE5ncCo52cSEWfM2NyA3OZzqNFolRpPxYxVt1j1BqE9ylZIHvDX8qiGvwdJQyXOzF
         8Zvw==
X-Gm-Message-State: AOJu0YwlSYN22pflzn0+wPtaAp5P2+ojnVfd5AOGT4ax/vs1/DTeB72r
	u4o8hYAnAPXHApW7WqcgwzEIplLWoXzx8A6WDGTIkav6b8vbulAljiOk3qJyiF6uJkHAd8dlZ0k
	=
X-Google-Smtp-Source: AGHT+IFLzF62if52qJ1KBXdicGFtIwJvmc9KJjo8zwyiW54iJHmUAuxAjnUDL7j7CHzBCzunheLUcg==
X-Received: by 2002:a05:6a20:3d84:b0:1a9:84f6:dcb6 with SMTP id adf61e73a8af0-1afde1d91dfmr15784036637.57.1715757434238;
        Wed, 15 May 2024 00:17:14 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:111d:a618:3172:cd5b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c136d53sm110941605ad.254.2024.05.15.00.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 00:17:13 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv4 07/21] zram: add zlib compression backend support
Date: Wed, 15 May 2024 16:12:44 +0900
Message-ID: <20240515071645.1788128-8-senozhatsky@chromium.org>
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

Add s/w zlib (inflate/deflate) compression.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/Kconfig           |  11 +++
 drivers/block/zram/Makefile          |   1 +
 drivers/block/zram/backend_deflate.c | 130 +++++++++++++++++++++++++++
 drivers/block/zram/backend_deflate.h |  10 +++
 drivers/block/zram/zcomp.c           |   4 +
 5 files changed, 156 insertions(+)
 create mode 100644 drivers/block/zram/backend_deflate.c
 create mode 100644 drivers/block/zram/backend_deflate.h

diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
index 71cd0d5d8f35..9dedd2edfb28 100644
--- a/drivers/block/zram/Kconfig
+++ b/drivers/block/zram/Kconfig
@@ -38,6 +38,12 @@ config ZRAM_BACKEND_ZSTD
 	select ZSTD_COMPRESS
 	select ZSTD_DECOMPRESS
 
+config ZRAM_BACKEND_DEFLATE
+	bool "deflate compression support"
+	depends on ZRAM
+	select ZLIB_DEFLATE
+	select ZLIB_INFLATE
+
 choice
 	prompt "Default zram compressor"
 	default ZRAM_DEF_COMP_LZORLE
@@ -63,6 +69,10 @@ config ZRAM_DEF_COMP_ZSTD
 	bool "zstd"
 	depends on ZRAM_BACKEND_ZSTD
 
+config ZRAM_DEF_COMP_DEFLATE
+	bool "deflate"
+	depends on ZRAM_BACKEND_DEFLATE
+
 endchoice
 
 config ZRAM_DEF_COMP
@@ -72,6 +82,7 @@ config ZRAM_DEF_COMP
 	default "lz4" if ZRAM_DEF_COMP_LZ4
 	default "lz4hc" if ZRAM_DEF_COMP_LZ4HC
 	default "zstd" if ZRAM_DEF_COMP_ZSTD
+	default "deflate" if ZRAM_DEF_COMP_DEFLATE
 	default "unset-value"
 
 config ZRAM_WRITEBACK
diff --git a/drivers/block/zram/Makefile b/drivers/block/zram/Makefile
index a2ca227e199c..266430548437 100644
--- a/drivers/block/zram/Makefile
+++ b/drivers/block/zram/Makefile
@@ -6,5 +6,6 @@ zram-$(CONFIG_ZRAM_BACKEND_LZO)		+= backend_lzorle.o backend_lzo.o
 zram-$(CONFIG_ZRAM_BACKEND_LZ4)		+= backend_lz4.o
 zram-$(CONFIG_ZRAM_BACKEND_LZ4HC)	+= backend_lz4hc.o
 zram-$(CONFIG_ZRAM_BACKEND_ZSTD)	+= backend_zstd.o
+zram-$(CONFIG_ZRAM_BACKEND_DEFLATE)	+= backend_deflate.o
 
 obj-$(CONFIG_ZRAM)	+=	zram.o
diff --git a/drivers/block/zram/backend_deflate.c b/drivers/block/zram/backend_deflate.c
new file mode 100644
index 000000000000..949d402ea3dd
--- /dev/null
+++ b/drivers/block/zram/backend_deflate.c
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+#include <linux/zlib.h>
+
+#include "backend_deflate.h"
+
+/* Use the same value as crypto API */
+#define DEFLATE_DEF_WINBITS		11
+#define DEFLATE_DEF_MEMLEVEL		MAX_MEM_LEVEL
+
+struct deflate_ctx {
+	struct z_stream_s cctx;
+	struct z_stream_s dctx;
+	s32 level;
+};
+
+static void deflate_destroy(void *ctx)
+{
+	struct deflate_ctx *zctx = ctx;
+
+	if (zctx->cctx.workspace) {
+		zlib_deflateEnd(&zctx->cctx);
+		vfree(zctx->cctx.workspace);
+	}
+	if (zctx->dctx.workspace) {
+		zlib_inflateEnd(&zctx->dctx);
+		vfree(zctx->dctx.workspace);
+	}
+	kfree(zctx);
+}
+
+static void *deflate_create(void)
+{
+	struct deflate_ctx *ctx;
+	size_t sz;
+	int ret;
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return NULL;
+
+	/* @FIXME: using a hardcoded Z_DEFAULT_COMPRESSION for now */
+	ctx->level = Z_DEFAULT_COMPRESSION;
+	sz = zlib_deflate_workspacesize(-DEFLATE_DEF_WINBITS, MAX_MEM_LEVEL);
+	ctx->cctx.workspace = vzalloc(sz);
+	if (!ctx->cctx.workspace)
+		goto error;
+
+	ret = zlib_deflateInit2(&ctx->cctx, ctx->level, Z_DEFLATED,
+				-DEFLATE_DEF_WINBITS, DEFLATE_DEF_MEMLEVEL,
+				Z_DEFAULT_STRATEGY);
+	if (ret != Z_OK)
+		goto error;
+
+	sz = zlib_inflate_workspacesize();
+	ctx->dctx.workspace = vzalloc(sz);
+	if (!ctx->dctx.workspace)
+		goto error;
+
+	ret = zlib_inflateInit2(&ctx->dctx, -DEFLATE_DEF_WINBITS);
+	if (ret != Z_OK)
+		goto error;
+
+	return ctx;
+
+error:
+	deflate_destroy(ctx);
+	return NULL;
+}
+
+static int deflate_compress(void *ctx, const unsigned char *src,
+			    unsigned char *dst, size_t *dst_len)
+{
+	struct deflate_ctx *zctx = ctx;
+	struct z_stream_s *deflate;
+	int ret;
+
+	deflate = &zctx->cctx;
+	ret = zlib_deflateReset(deflate);
+	if (ret != Z_OK)
+		return -EINVAL;
+
+	deflate->next_in = (u8 *)src;
+	deflate->avail_in = PAGE_SIZE;
+	deflate->next_out = (u8 *)dst;
+	deflate->avail_out = *dst_len;
+
+	ret = zlib_deflate(deflate, Z_FINISH);
+	if (ret != Z_STREAM_END)
+		return -EINVAL;
+
+	*dst_len = deflate->total_out;
+	return 0;
+}
+
+static int deflate_decompress(void *ctx, const unsigned char *src,
+			      size_t src_len, unsigned char *dst)
+{
+	struct deflate_ctx *zctx = ctx;
+	struct z_stream_s *inflate;
+	int ret;
+
+	inflate = &zctx->dctx;
+
+	ret = zlib_inflateReset(inflate);
+	if (ret != Z_OK)
+		return -EINVAL;
+
+	inflate->next_in = (u8 *)src;
+	inflate->avail_in = src_len;
+	inflate->next_out = (u8 *)dst;
+	inflate->avail_out = PAGE_SIZE;
+
+	ret = zlib_inflate(inflate, Z_SYNC_FLUSH);
+	if (ret != Z_STREAM_END)
+		return -EINVAL;
+
+	return 0;
+}
+
+struct zcomp_backend backend_deflate = {
+	.compress	= deflate_compress,
+	.decompress	= deflate_decompress,
+	.create_ctx	= deflate_create,
+	.destroy_ctx	= deflate_destroy,
+	.name		= "deflate",
+};
diff --git a/drivers/block/zram/backend_deflate.h b/drivers/block/zram/backend_deflate.h
new file mode 100644
index 000000000000..49cef8fc1e77
--- /dev/null
+++ b/drivers/block/zram/backend_deflate.h
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#ifndef __BACKEND_DEFLATE_H__
+#define __BACKEND_DEFLATE_H__
+
+#include "zcomp.h"
+
+extern struct zcomp_backend backend_deflate;
+
+#endif /* __BACKEND_DEFLATE_H__ */
diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index c16eb038f608..9fc5477a6259 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -20,6 +20,7 @@
 #include "backend_lz4.h"
 #include "backend_lz4hc.h"
 #include "backend_zstd.h"
+#include "backend_deflate.h"
 
 static struct zcomp_backend *backends[] = {
 #if IS_ENABLED(CONFIG_ZRAM_BACKEND_LZO)
@@ -34,6 +35,9 @@ static struct zcomp_backend *backends[] = {
 #endif
 #if IS_ENABLED(CONFIG_ZRAM_BACKEND_ZSTD)
 	&backend_zstd,
+#endif
+#if IS_ENABLED(CONFIG_ZRAM_BACKEND_DEFLATE)
+	&backend_deflate,
 #endif
 	NULL
 };
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


