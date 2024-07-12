Return-Path: <linux-kernel+bounces-250180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F29E892F4FB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 07:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 832621F21834
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 05:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE38C1311B4;
	Fri, 12 Jul 2024 05:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E8IdklIZ"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72FF130A4D
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 05:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720761572; cv=none; b=uR2JC0IM8wItJ8HSD9t1cmzSF85Aw22mjcmuUzkGjKLBG9zF83d5E9w4EaLEghNf+wX5EzQjDFcD2Bq8Dg5A7yIQZ9IO1HTQayLcVKMmTrTTxBDekwgZiqpUUNUobTq/+xokO852juHaJSXQINXdEEqn5KBaEb9YwM0F7gkdxzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720761572; c=relaxed/simple;
	bh=Fivx6VMuk2vjhcGib7Tcx14jPun6dKIEhFaCBDHvtpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qxbUNxc2CfrLZHx5u4p8t1cRWs9Bfjbs2t9ny/7mv+GxXojIll67CPnSiAQvrZJOYLWhcyLCNsKjaFxXSSVTDCsf3OvuKMxmbqQmypBPg/m3s17j0O446BLIZYshSd2YGG6w4RoYaV/kd/BqhB25h0pOnMUWyz4h4fJ630aW1gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=E8IdklIZ; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70af0684c2bso1284662b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 22:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720761570; x=1721366370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b9CbhV5g6i0tQmXsKmS9hqUZt4I9LJTh9jd520bTuUo=;
        b=E8IdklIZrvE8UKxMBZD28Y5s2ra5vulWpqGrzRR5cb0d/B82gZzTsNTrWSEFoYYcmv
         I6+krBQSHDPw6djhIlV9hodR69LLlYYGP03bwWaqiOaCpDcx01na0LbXRtD6qZqHiEbC
         k9iRZuWMkUijp6BESd/rjToXbqhIDHIxrB4Lg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720761570; x=1721366370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b9CbhV5g6i0tQmXsKmS9hqUZt4I9LJTh9jd520bTuUo=;
        b=wonZhGXYW/OrKAwsn9d1vo2RS9xTrKtPo7iPk7nKufbOEibotgS9bGLaowLJsFaeGK
         8pqj3Y17iWhxDQ7kUu6XXKcOVnAGBQzbeBbjLz6ROzWTnvuiSbK2brSg4I6qx6ErpaNd
         AJJu87rKWxZ4/xCeqeTuP/i53vB/6w/UeUOzs2Z6WKHxfo23tKuN5pYXT1kSZyW3W4/z
         /igicnJjN2DY4pX2fS2IZchyF9iQ0m9dCyqGMN5Lx28u52iykX4mQyi85B/AWdF5/szk
         p04p2bzp33J57shLZLpApLADFKCBNUNlPLsLUCzG6oU3ovNpk+WNnF/1x3u122GyPJmm
         KJbQ==
X-Gm-Message-State: AOJu0YzKFyInDDapVQfbHOfJMz+JVAlkgEvn7Q2qmACQa+CRAohnfdlW
	XZ35ZpvNLBNGgsnRq1yCILMuHBN65mzOXrpG2l2GarPa+TYH1VHdyN9JbbtEoA==
X-Google-Smtp-Source: AGHT+IHP1kUmuKsOrqG9NV434DVislfhlL16TSkV8gCZPCrHd+XbPFpUGGmvpC8iGOnSSxJUpRP/Gw==
X-Received: by 2002:a05:6a00:1387:b0:706:3329:5533 with SMTP id d2e1a72fcca58-70b43650a2dmr11919341b3a.24.1720761569793;
        Thu, 11 Jul 2024 22:19:29 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:15f3:5252:ec56:52ae])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b43967851sm6553436b3a.109.2024.07.11.22.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 22:19:29 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v6 11/23] zram: add 842 compression backend support
Date: Fri, 12 Jul 2024 14:18:22 +0900
Message-ID: <20240712051850.484318-12-senozhatsky@chromium.org>
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

Add s/w 842 compression support.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/Kconfig       | 11 ++++++
 drivers/block/zram/Makefile      |  1 +
 drivers/block/zram/backend_842.c | 68 ++++++++++++++++++++++++++++++++
 drivers/block/zram/backend_842.h | 10 +++++
 drivers/block/zram/zcomp.c       |  4 ++
 5 files changed, 94 insertions(+)
 create mode 100644 drivers/block/zram/backend_842.c
 create mode 100644 drivers/block/zram/backend_842.h

diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
index bc3a1d0455b1..ddc19853ea96 100644
--- a/drivers/block/zram/Kconfig
+++ b/drivers/block/zram/Kconfig
@@ -45,6 +45,12 @@ config ZRAM_BACKEND_DEFLATE
 	select ZLIB_DEFLATE
 	select ZLIB_INFLATE
 
+config ZRAM_BACKEND_842
+	bool "842 compression support"
+	depends on ZRAM
+	select 842_COMPRESS
+	select 842_DECOMPRESS
+
 choice
 	prompt "Default zram compressor"
 	default ZRAM_DEF_COMP_LZORLE
@@ -74,6 +80,10 @@ config ZRAM_DEF_COMP_DEFLATE
 	bool "deflate"
 	depends on ZRAM_BACKEND_DEFLATE
 
+config ZRAM_DEF_COMP_842
+	bool "842"
+	depends on ZRAM_BACKEND_842
+
 endchoice
 
 config ZRAM_DEF_COMP
@@ -84,6 +94,7 @@ config ZRAM_DEF_COMP
 	default "lz4hc" if ZRAM_DEF_COMP_LZ4HC
 	default "zstd" if ZRAM_DEF_COMP_ZSTD
 	default "deflate" if ZRAM_DEF_COMP_DEFLATE
+	default "842" if ZRAM_DEF_COMP_842
 	default "unset-value"
 
 config ZRAM_WRITEBACK
diff --git a/drivers/block/zram/Makefile b/drivers/block/zram/Makefile
index 266430548437..0fdefd576691 100644
--- a/drivers/block/zram/Makefile
+++ b/drivers/block/zram/Makefile
@@ -7,5 +7,6 @@ zram-$(CONFIG_ZRAM_BACKEND_LZ4)		+= backend_lz4.o
 zram-$(CONFIG_ZRAM_BACKEND_LZ4HC)	+= backend_lz4hc.o
 zram-$(CONFIG_ZRAM_BACKEND_ZSTD)	+= backend_zstd.o
 zram-$(CONFIG_ZRAM_BACKEND_DEFLATE)	+= backend_deflate.o
+zram-$(CONFIG_ZRAM_BACKEND_842)		+= backend_842.o
 
 obj-$(CONFIG_ZRAM)	+=	zram.o
diff --git a/drivers/block/zram/backend_842.c b/drivers/block/zram/backend_842.c
new file mode 100644
index 000000000000..005f3fcb9024
--- /dev/null
+++ b/drivers/block/zram/backend_842.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/sw842.h>
+#include <linux/vmalloc.h>
+
+#include "backend_842.h"
+
+struct sw842_ctx {
+	void *mem;
+};
+
+static void destroy_842(void *ctx)
+{
+	struct sw842_ctx *zctx = ctx;
+
+	kfree(zctx->mem);
+	kfree(zctx);
+}
+
+static void *create_842(void)
+{
+	struct sw842_ctx *ctx;
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return NULL;
+
+	ctx->mem = kmalloc(SW842_MEM_COMPRESS, GFP_KERNEL);
+	if (!ctx->mem)
+		goto error;
+
+	return ctx;
+
+error:
+	destroy_842(ctx);
+	return NULL;
+}
+
+static int compress_842(void *ctx, const unsigned char *src, size_t src_len,
+			unsigned char *dst, size_t *dst_len)
+{
+	struct sw842_ctx *zctx = ctx;
+	unsigned int dlen = *dst_len;
+	int ret;
+
+	ret = sw842_compress(src, src_len, dst, &dlen, zctx->mem);
+	if (ret == 0)
+		*dst_len = dlen;
+	return ret;
+}
+
+static int decompress_842(void *ctx, const unsigned char *src, size_t src_len,
+			  unsigned char *dst, size_t dst_len)
+{
+	unsigned int dlen = dst_len;
+
+	return sw842_decompress(src, src_len, dst, &dlen);
+}
+
+const struct zcomp_ops backend_842 = {
+	.compress	= compress_842,
+	.decompress	= decompress_842,
+	.create_ctx	= create_842,
+	.destroy_ctx	= destroy_842,
+	.name		= "842",
+};
diff --git a/drivers/block/zram/backend_842.h b/drivers/block/zram/backend_842.h
new file mode 100644
index 000000000000..4dc85c188799
--- /dev/null
+++ b/drivers/block/zram/backend_842.h
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#ifndef __BACKEND_842_H__
+#define __BACKEND_842_H__
+
+#include "zcomp.h"
+
+extern const struct zcomp_ops backend_842;
+
+#endif /* __BACKEND_842_H__ */
diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index 4d212ef972ea..48ac7a3e8906 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -18,6 +18,7 @@
 #include "backend_lz4hc.h"
 #include "backend_zstd.h"
 #include "backend_deflate.h"
+#include "backend_842.h"
 
 static const struct zcomp_ops *backends[] = {
 #if IS_ENABLED(CONFIG_ZRAM_BACKEND_LZO)
@@ -35,6 +36,9 @@ static const struct zcomp_ops *backends[] = {
 #endif
 #if IS_ENABLED(CONFIG_ZRAM_BACKEND_DEFLATE)
 	&backend_deflate,
+#endif
+#if IS_ENABLED(CONFIG_ZRAM_BACKEND_842)
+	&backend_842,
 #endif
 	NULL
 };
-- 
2.45.2.993.g49e7a77208-goog


