Return-Path: <linux-kernel+bounces-172837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D148BF751
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 09:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E51BC1F21BDD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 07:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B9D537F2;
	Wed,  8 May 2024 07:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R7xhMQs+"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C578537E3
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 07:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715154174; cv=none; b=FKUTElCHeElf7taR5TPNn6qEdb/jKiMkl/9KaYkMT+6kjxcSgueIcbTand1Xxw6KtsaoJ6AD1LcXVV/FeEci7YZ/ne0Zlwg5y8AAN8yU/Bav4+Z1g9QTVqhZnnnRN13KHrsZQtaIRf5O/DzgQ2AxQ6Zcs8pmnysd0e6f6diUEpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715154174; c=relaxed/simple;
	bh=QlfqxCVzGVqjuU78RUVl7laME8V3Egjqi1IedM7APCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YjyWlZtWKgU4iOwdO0lwKlMR4VhVPvQc80iat5TiSmarSRiVbJQeSvgaVpHkjUm3zUMZ8mubNdbOU+mURZCqeFupfQNzEiCEbLVVu0QEO/aqFUhVegBabR0Vyzh5DZg7G802oPvk5QfiKD0uI29k1E/7Qh/rL8PmpN9njdhzqXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=R7xhMQs+; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-620e30d8f37so3398954a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 00:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715154173; x=1715758973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=II/I/hgLmJhm0CjvuLYW2Y62FUnxRGP17kgZqYB2Ofs=;
        b=R7xhMQs+LZQ5W5ems3eTs1wSRGOew4R44hkK2dxllm5gn8QhYRC9mfK/0+NTrheGQE
         xMa7LIEhfRCGWQbtmy0hDxncvoqDOV7DZVAvPpjpfFUy1/7FQ8wnMdwPy0SpyrqbPM+P
         GIRC5cVZoTDesK2ydc8FZlVYMd3HgJ8I2YoCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715154173; x=1715758973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=II/I/hgLmJhm0CjvuLYW2Y62FUnxRGP17kgZqYB2Ofs=;
        b=OIW1W/yUTntEbsaZlx10hkbgaeiJGvkzKwE9k14xR6ZWn10crUTseRvCN+L39q6u5i
         NiVl/4Ur44quouQpoCiJZbJLNYzLNZ7GrTAJuU51yKpyVat+Kb/KgrrPaFAoFe0ceZ7z
         QBMybukECHekkgUd/adTEwSrBgL39FRUL8Qo1RiSqmyQrOTrClg/gxts+M2BQ9pvV28C
         YS/FeHZcqeO1TkVudZmNN+jlACLl4NxllTKjpcmdzvHoAAZqBK3+hfP+BNbDbo0vk6iz
         mjrall2k07ozav2eNr+z0kezjBBRtqilg8Fq2w9jamOXRQ3L3nRJEw/Zho5qmOePltBK
         n+OA==
X-Gm-Message-State: AOJu0YxjO6YhG9RQa9WzffPwDRQOkfWoofY5HEgyrSwAbo4xZ0GTxOjf
	1OSPJnJoTN8JF+aPIDlroCbSfSpc88ozk/ab2xcGH+/PZvM+iLxbAhLZfMMwvw==
X-Google-Smtp-Source: AGHT+IECICoA7hcDg23NAlDQOI1208s0oA/MgjMrcQhNGoK5Hsv4ExsAu/YczEHWlGdEBYIalK11CQ==
X-Received: by 2002:a17:90a:e011:b0:2ab:e345:4685 with SMTP id 98e67ed59e1d1-2b6165a5634mr1749435a91.17.1715154172664;
        Wed, 08 May 2024 00:42:52 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:ad4d:5f6c:6699:2da4])
        by smtp.gmail.com with ESMTPSA id l5-20020a17090aec0500b002b328adaa40sm780011pjy.17.2024.05.08.00.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 00:42:52 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv3 07/19] zram: add zlib compression backend support
Date: Wed,  8 May 2024 16:42:00 +0900
Message-ID: <20240508074223.652784-8-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
In-Reply-To: <20240508074223.652784-1-senozhatsky@chromium.org>
References: <20240508074223.652784-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/Kconfig           |  11 +++
 drivers/block/zram/Makefile          |   9 +-
 drivers/block/zram/backend_deflate.c | 130 +++++++++++++++++++++++++++
 drivers/block/zram/backend_deflate.h |  10 +++
 drivers/block/zram/zcomp.c           |   4 +
 5 files changed, 160 insertions(+), 4 deletions(-)
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
index 053fe35e346b..91c07595d8b4 100644
--- a/drivers/block/zram/Makefile
+++ b/drivers/block/zram/Makefile
@@ -1,9 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-obj-$(CONFIG_ZRAM_BACKEND_LZO)		+= backend_lzorle.o backend_lzo.o
-obj-$(CONFIG_ZRAM_BACKEND_LZ4)		+= backend_lz4.o
-obj-$(CONFIG_ZRAM_BACKEND_LZ4HC)	+= backend_lz4hc.o
-obj-$(CONFIG_ZRAM_BACKEND_ZSTD)		+= backend_zstd.o
+obj-$(CONFIG_ZRAM_BACKEND_LZO)			+= backend_lzorle.o backend_lzo.o
+obj-$(CONFIG_ZRAM_BACKEND_LZ4)			+= backend_lz4.o
+obj-$(CONFIG_ZRAM_BACKEND_LZ4HC)		+= backend_lz4hc.o
+obj-$(CONFIG_ZRAM_BACKEND_ZSTD)			+= backend_zstd.o
+obj-$(CONFIG_ZRAM_BACKEND_DEFLATE)		+= backend_deflate.o
 
 zram-y	:=	zcomp.o zram_drv.o
 
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


