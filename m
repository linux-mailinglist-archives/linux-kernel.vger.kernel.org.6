Return-Path: <linux-kernel+bounces-250176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF9D92F4F7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 07:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2024A2822B5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 05:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0367585934;
	Fri, 12 Jul 2024 05:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BgyAz7Go"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E686EB55
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 05:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720761563; cv=none; b=AGIxy4XnjPtGuGBbRaW4WvG/OotFo6ed4gEVXBsRJZ4HUslgaq0w8vTzlj7pdEyIV/nI8pJ0mQC6wXR6pLB/7QSHG+flTxgSuEmvjPth4DFQzSE7xYA6o81I9CPlHhdpNIjGSB1DvZqrZAkY2L1a/9/Kn4EmgSBMUIXrkNkuvco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720761563; c=relaxed/simple;
	bh=nuxOffzi+aQXSrLraJAVYpsnXY5nFZPNCqMwYC7MjsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VlaSoDv1MH+9EBEOROKqTscLWmCmA/EPYyHsoRmWULi+2UtYqA5W/WuDzxh6XhpqnSJYmv6Q3ZwmOUWyGuJ8EiXE9qXf897e/+uFKKtL3iQmmfkNGDSGoN4QB+A8mGeoAv1EygZR0xLA2ZXXvc6wzWxK3MKAtmFKEinn/cHxJlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BgyAz7Go; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70b0d0a7a56so1496275b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 22:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720761561; x=1721366361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ihCXkqK3oyAPMbJxDZQ4flZ6D4+8C4PO76kBiGiEGv0=;
        b=BgyAz7GotqQ+IGmgD87fZfj5jkpO3LUOkZSMSqjN8o4ZUEA4eSH7I+Po+nzQ3nzicq
         1Px6tEjZy66B9k0+5vfyVvyqKmdecHzryiXSlkVwmmKQD3r6647WpHvXZsVpjat8FbaR
         /6bPy2vk2HsIsx/lRp0FXaMeB/ZgCd9vOc0Ho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720761561; x=1721366361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ihCXkqK3oyAPMbJxDZQ4flZ6D4+8C4PO76kBiGiEGv0=;
        b=BJjEqbp8wCEDcuM/55LJa4WL3ZKFMyHXInsoet62G4gN8gLJXoSL7cCN/UudC6tfVs
         kA26kFn8tSOOEG7U78SfQbyN5AKhwJgWQry5g1cBDUJq80nz976QurLUhBKU5nQErlfn
         KDkSRZ79H7NSrWBI5Az4Vul76VkCsOT5MRn0mtAz1wsNveIMNJKc6eeY9aBaOHr6M3P1
         kokO5XjIlcVRAnfVQxjLOdD6rmhrk/TVn8cfjNron8Rs8GangsseCMhxdrw/m7yIbFkQ
         BZKxSSPTJ5abgE0249Str94U6E3g2NFJIMBsCb3vU70Me+XlN04xG0fPUJEbCYTF04qd
         2Z+Q==
X-Gm-Message-State: AOJu0YwQDJ+sV0aX3E+F0LjI592e+3ZmfejbXkowMW+5gKE6EIz9IkgI
	rb0U5YxJoIICW4Xvz550cGFvgIF2igaA2NV9LwbUXIJC4iM0lCbq0o/uKIONiA==
X-Google-Smtp-Source: AGHT+IE+U2MZZIB2Z+kFgNxjfY4JS8WaUJeGuDmWzGHw3n5P2X4BSnEBQlD5HOoI5qk7X/aTsErEQw==
X-Received: by 2002:a05:6a00:1395:b0:70a:f57c:fa1d with SMTP id d2e1a72fcca58-70b43623b6amr13483706b3a.29.1720761560909;
        Thu, 11 Jul 2024 22:19:20 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:15f3:5252:ec56:52ae])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b43967851sm6553436b3a.109.2024.07.11.22.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 22:19:20 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v6 07/23] zram: add lz4hc compression backend support
Date: Fri, 12 Jul 2024 14:18:18 +0900
Message-ID: <20240712051850.484318-8-senozhatsky@chromium.org>
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

Add s/w lz4hc compression support.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/Kconfig         | 11 +++++
 drivers/block/zram/Makefile        |  5 ++-
 drivers/block/zram/backend_lz4hc.c | 72 ++++++++++++++++++++++++++++++
 drivers/block/zram/backend_lz4hc.h | 10 +++++
 drivers/block/zram/zcomp.c         |  4 ++
 5 files changed, 100 insertions(+), 2 deletions(-)
 create mode 100644 drivers/block/zram/backend_lz4hc.c
 create mode 100644 drivers/block/zram/backend_lz4hc.h

diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
index 28288e9432d4..72751cb2b532 100644
--- a/drivers/block/zram/Kconfig
+++ b/drivers/block/zram/Kconfig
@@ -27,6 +27,12 @@ config ZRAM_BACKEND_LZ4
 	select LZ4_COMPRESS
 	select LZ4_DECOMPRESS
 
+config ZRAM_BACKEND_LZ4HC
+	bool "lz4hc compression support"
+	depends on ZRAM
+	select LZ4HC_COMPRESS
+	select LZ4_DECOMPRESS
+
 choice
 	prompt "Default zram compressor"
 	default ZRAM_DEF_COMP_LZORLE
@@ -44,6 +50,10 @@ config ZRAM_DEF_COMP_LZ4
 	bool "lz4"
 	depends on ZRAM_BACKEND_LZ4
 
+config ZRAM_DEF_COMP_LZ4HC
+	bool "lz4hc"
+	depends on ZRAM_BACKEND_LZ4HC
+
 endchoice
 
 config ZRAM_DEF_COMP
@@ -51,6 +61,7 @@ config ZRAM_DEF_COMP
 	default "lzo-rle" if ZRAM_DEF_COMP_LZORLE
 	default "lzo" if ZRAM_DEF_COMP_LZO
 	default "lz4" if ZRAM_DEF_COMP_LZ4
+	default "lz4hc" if ZRAM_DEF_COMP_LZ4HC
 	default "unset-value"
 
 config ZRAM_WRITEBACK
diff --git a/drivers/block/zram/Makefile b/drivers/block/zram/Makefile
index 567f4434aee8..727c9d68e3e3 100644
--- a/drivers/block/zram/Makefile
+++ b/drivers/block/zram/Makefile
@@ -2,7 +2,8 @@
 
 zram-y	:=	zcomp.o zram_drv.o
 
-zram-$(CONFIG_ZRAM_BACKEND_LZO)	+= backend_lzorle.o backend_lzo.o
-zram-$(CONFIG_ZRAM_BACKEND_LZ4)	+= backend_lz4.o
+zram-$(CONFIG_ZRAM_BACKEND_LZO)		+= backend_lzorle.o backend_lzo.o
+zram-$(CONFIG_ZRAM_BACKEND_LZ4)		+= backend_lz4.o
+zram-$(CONFIG_ZRAM_BACKEND_LZ4HC)	+= backend_lz4hc.o
 
 obj-$(CONFIG_ZRAM)	+=	zram.o
diff --git a/drivers/block/zram/backend_lz4hc.c b/drivers/block/zram/backend_lz4hc.c
new file mode 100644
index 000000000000..536f7a0073c4
--- /dev/null
+++ b/drivers/block/zram/backend_lz4hc.c
@@ -0,0 +1,72 @@
+#include <linux/kernel.h>
+#include <linux/lz4.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+
+#include "backend_lz4hc.h"
+
+struct lz4hc_ctx {
+	void *mem;
+	s32 level;
+};
+
+static void lz4hc_destroy(void *ctx)
+{
+	struct lz4hc_ctx *zctx = ctx;
+
+	vfree(zctx->mem);
+	kfree(zctx);
+}
+
+static void *lz4hc_create(void)
+{
+	struct lz4hc_ctx *ctx;
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return NULL;
+
+	/* @FIXME: using a hardcoded LZ4HC_DEFAULT_CLEVEL for now */
+	ctx->level = LZ4HC_DEFAULT_CLEVEL;
+	ctx->mem = vmalloc(LZ4HC_MEM_COMPRESS);
+	if (!ctx->mem)
+		goto error;
+
+	return ctx;
+error:
+	lz4hc_destroy(ctx);
+	return NULL;
+}
+
+static int lz4hc_compress(void *ctx, const unsigned char *src, size_t src_len,
+			  unsigned char *dst, size_t *dst_len)
+{
+	struct lz4hc_ctx *zctx = ctx;
+	int ret;
+
+	ret = LZ4_compress_HC(src, dst, src_len, *dst_len,
+			      zctx->level, zctx->mem);
+	if (!ret)
+		return -EINVAL;
+	*dst_len = ret;
+	return 0;
+}
+
+static int lz4hc_decompress(void *ctx, const unsigned char *src,
+			    size_t src_len, unsigned char *dst, size_t dst_len)
+{
+	int ret;
+
+	ret = LZ4_decompress_safe(src, dst, src_len, dst_len);
+	if (ret < 0)
+		return -EINVAL;
+	return 0;
+}
+
+const struct zcomp_ops backend_lz4hc = {
+	.compress	= lz4hc_compress,
+	.decompress	= lz4hc_decompress,
+	.create_ctx	= lz4hc_create,
+	.destroy_ctx	= lz4hc_destroy,
+	.name		= "lz4hc",
+};
diff --git a/drivers/block/zram/backend_lz4hc.h b/drivers/block/zram/backend_lz4hc.h
new file mode 100644
index 000000000000..6de03551ed4d
--- /dev/null
+++ b/drivers/block/zram/backend_lz4hc.h
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#ifndef __BACKEND_LZ4HC_H__
+#define __BACKEND_LZ4HC_H__
+
+#include "zcomp.h"
+
+extern const struct zcomp_ops backend_lz4hc;
+
+#endif /* __BACKEND_LZ4HC_H__ */
diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index 080cf1d001f0..305d56278365 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -15,6 +15,7 @@
 #include "backend_lzo.h"
 #include "backend_lzorle.h"
 #include "backend_lz4.h"
+#include "backend_lz4hc.h"
 
 static const struct zcomp_ops *backends[] = {
 #if IS_ENABLED(CONFIG_ZRAM_BACKEND_LZO)
@@ -23,6 +24,9 @@ static const struct zcomp_ops *backends[] = {
 #endif
 #if IS_ENABLED(CONFIG_ZRAM_BACKEND_LZ4)
 	&backend_lz4,
+#endif
+#if IS_ENABLED(CONFIG_ZRAM_BACKEND_LZ4HC)
+	&backend_lz4hc,
 #endif
 	NULL
 };
-- 
2.45.2.993.g49e7a77208-goog


