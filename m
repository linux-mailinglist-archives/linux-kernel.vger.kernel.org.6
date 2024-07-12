Return-Path: <linux-kernel+bounces-250179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA4492F4FA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 07:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 876EB282844
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 05:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5FC130A66;
	Fri, 12 Jul 2024 05:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Bvx5PT9p"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C85B1BC20
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 05:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720761570; cv=none; b=CQZ0cwgdnd8vXfpRsmRBypYj1074H8VA+/4XAdZk7skUsZzUd9tXqUJzlL4+CHjVgpSbTHdd26SlJCkUE0w/pl3HqDr3t/XPKVMKPTvut3fOh+pTy0AFFZgKx/mZ4GGg3Fgc0OcfIfaCoe392ckfZJ60k7xdPXTuAFuwnjrK3KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720761570; c=relaxed/simple;
	bh=/ynKcXho0I0Fo9asmir1w2xQV/PTACvP4Jzd/gFywIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dxBV12QlcTn8bpj5O7tbCQzs+Gx0vwy8ykRggZ89jn/8hJvyPU55YNf1WL7KsyDqxgPXNvzyP094whK6YoDi5bBKW7DIYJ82BFpMUjmAyO4Y++v5LzSBkBvdRGyE2czhPOqSDyzf9uyyj16e8X9eAWGUcvrqhhjtkgXyu7qV6FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Bvx5PT9p; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70b04cb28acso1340328b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 22:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720761568; x=1721366368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pt9HFXhm8jsjka0o6lJYYClx2NuPsy9T4M2HrSrOQU4=;
        b=Bvx5PT9pRZWLpN+3Wj1DEL/DcJeWw7JJafu4c2DzW5U+zOf43Te6U5l0Oi0lZI7y7P
         P2ZE79WjNOwavFYAYrYZj8cJLtbZUugQZao4fdcbFw14zZFyPFw7r/gwXZ6agUD9Iog3
         0qSUXyBObhTuYOCAD4P8hthK/Hl5AyyCw+g2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720761568; x=1721366368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pt9HFXhm8jsjka0o6lJYYClx2NuPsy9T4M2HrSrOQU4=;
        b=jZYFfuDPYkRh7Xa3Ws6W0auZpnFHB+WTbxidyxBZlN4evrxFs53gHI2UgQiIk5NBtX
         2ZIB15N5KRWTdhPdKPS70oz6c+P0DA/FTVH0EJjRvEp3WpqYfoKNRmhNWgeLTliOxZCT
         NonFzClJTpS6LqflylA0fV+ZCqXYJelRLl6zlRSUzOGXmHUENw1/rzpwQWzcSpoMxQP9
         GZHv49g1waI3q9VN9NSYQPtMBixTFibNGaF2ubM/RVkQxdLLWow3vFAiP68FV5hhWMpm
         YNSvGMfepsrt4abjYidwHgmD9JLP7wAHPeYRTcnZP5nA5361OR4KfMW11gADuXO/MdGZ
         8HAA==
X-Gm-Message-State: AOJu0Yw3vcNwGqcTsPEKvNxh08uJoTC9FL8YZ6aKFHL6d8ej8Tkcp8SG
	7pyPB2dFOWz2H5VKG7aVYB2gCRdNLUJCNNNekbeoGdTct9sbY1o8aAfDNNCeAg==
X-Google-Smtp-Source: AGHT+IGS9EzrXig1LahWWg72yNBNn7Mk/hVSjnDVM2VpDkGSqFZzd0mcPwrenDkDvEsxylAEJkewLQ==
X-Received: by 2002:a05:6a00:218a:b0:705:d6ad:2495 with SMTP id d2e1a72fcca58-70b6c928dfbmr3179789b3a.12.1720761567665;
        Thu, 11 Jul 2024 22:19:27 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:15f3:5252:ec56:52ae])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b43967851sm6553436b3a.109.2024.07.11.22.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 22:19:27 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v6 10/23] zram: add zlib compression backend support
Date: Fri, 12 Jul 2024 14:18:21 +0900
Message-ID: <20240712051850.484318-11-senozhatsky@chromium.org>
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

Add s/w zlib (inflate/deflate) compression.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/Kconfig           |  11 +++
 drivers/block/zram/Makefile          |   1 +
 drivers/block/zram/backend_deflate.c | 132 +++++++++++++++++++++++++++
 drivers/block/zram/backend_deflate.h |  10 ++
 drivers/block/zram/zcomp.c           |   4 +
 5 files changed, 158 insertions(+)
 create mode 100644 drivers/block/zram/backend_deflate.c
 create mode 100644 drivers/block/zram/backend_deflate.h

diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
index ee4fe2ee3413..bc3a1d0455b1 100644
--- a/drivers/block/zram/Kconfig
+++ b/drivers/block/zram/Kconfig
@@ -39,6 +39,12 @@ config ZRAM_BACKEND_ZSTD
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
@@ -64,6 +70,10 @@ config ZRAM_DEF_COMP_ZSTD
 	bool "zstd"
 	depends on ZRAM_BACKEND_ZSTD
 
+config ZRAM_DEF_COMP_DEFLATE
+	bool "deflate"
+	depends on ZRAM_BACKEND_DEFLATE
+
 endchoice
 
 config ZRAM_DEF_COMP
@@ -73,6 +83,7 @@ config ZRAM_DEF_COMP
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
index 000000000000..acefb86701b9
--- /dev/null
+++ b/drivers/block/zram/backend_deflate.c
@@ -0,0 +1,132 @@
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
+			    size_t src_len, unsigned char *dst,
+			    size_t *dst_len)
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
+	deflate->avail_in = src_len;
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
+			      size_t src_len, unsigned char *dst,
+			      size_t dst_len)
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
+	inflate->avail_out = dst_len;
+
+	ret = zlib_inflate(inflate, Z_SYNC_FLUSH);
+	if (ret != Z_STREAM_END)
+		return -EINVAL;
+
+	return 0;
+}
+
+const struct zcomp_ops backend_deflate = {
+	.compress	= deflate_compress,
+	.decompress	= deflate_decompress,
+	.create_ctx	= deflate_create,
+	.destroy_ctx	= deflate_destroy,
+	.name		= "deflate",
+};
diff --git a/drivers/block/zram/backend_deflate.h b/drivers/block/zram/backend_deflate.h
new file mode 100644
index 000000000000..a39ac12b114c
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
+extern const struct zcomp_ops backend_deflate;
+
+#endif /* __BACKEND_DEFLATE_H__ */
diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index b920462d7e56..4d212ef972ea 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -17,6 +17,7 @@
 #include "backend_lz4.h"
 #include "backend_lz4hc.h"
 #include "backend_zstd.h"
+#include "backend_deflate.h"
 
 static const struct zcomp_ops *backends[] = {
 #if IS_ENABLED(CONFIG_ZRAM_BACKEND_LZO)
@@ -31,6 +32,9 @@ static const struct zcomp_ops *backends[] = {
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
2.45.2.993.g49e7a77208-goog


