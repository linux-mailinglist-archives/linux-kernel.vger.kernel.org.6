Return-Path: <linux-kernel+bounces-172838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3F58BF753
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 09:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6E731F216A2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 07:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF78B54755;
	Wed,  8 May 2024 07:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J8FA69Bd"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85628537E0
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 07:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715154176; cv=none; b=g+KvqV30tYD7BkCYZNMp2gzP7GH9UGJbgi7E+E+XCIoXrP1j665SKDteP2Cgh7nvVj1zt68Z9q2yRPvm7KJGyk1+XFzBifJwQOxH7PWTyidqDo7CYA7crRCxkUPOdy11pT7ynOoXX8Kn+BYvD8/NmrWzOZ5oOm3c8m/feGr+xTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715154176; c=relaxed/simple;
	bh=kNJbXxfK8zdnskpjgM5oyiiq8zq2KQp2aiK9qKIm8Jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XmrtBAWS69OGbtQCME9nD1sQXEFgblVi6idOymYKXEqQeE144LvDtJR5ny9lOwhyh2/7LAgp/l77BF8vaIXjO6bRXpP5fN0j6o9QqvRcfFQwJ9gnlom7C0MDE6+wFajhYepTaaqDzOQ8xUbFs1ncWTNFfvFMWdLXFcfItNeaLQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=J8FA69Bd; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5d4d15ec7c5so3584261a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 00:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715154175; x=1715758975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EEH83ikFWbHDBUUzWu4h4KsSObV7EItvgFziqF5bCxw=;
        b=J8FA69BdgXXskEd/BPlAMrf0g4gpVDyflcFnylken9drYDmKP/Lpg8LyNkznHjNa/J
         3FPXUW5hhYlykq+ss8QBM1KlofuOYNBKPBy4dLMbC6PYd0jxZ6Ax4OLL52M1wix4GOL5
         MVx3xO9szVkQbqYEex3HIbJeRWMrZn/XZLnlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715154175; x=1715758975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EEH83ikFWbHDBUUzWu4h4KsSObV7EItvgFziqF5bCxw=;
        b=OZUtp5bT+W2wV0DNG+Tc09MHBX05PrsZ3JdUfd/OokEzraHkMOh1RW0t6nZowERHgj
         9nrU0nz5GX7kZZrvXWgi5Lz4KP8bW3OxIIN63iX4TqawgP9AKVvi5vgB081Wb+GwbucX
         POPVLp0z7aZoQpnNL4v54D0mBlCrMyxa46k92fNUmajmGhqBndE4y/P5F4v7P3GpIJfm
         zwJwD1rWsfQDkjLS3uwPN333Ltd4Lz2F2wjLVq2i/M8JWLVJIDgE6Sq/q8HSAczzpphN
         fFkWOHAJZLzw+LGlXGKittzfaD3u8MWAQH+4vD3Zg+LCpA4VJ/j+VHB84SPEwooCy5Zw
         +fIg==
X-Gm-Message-State: AOJu0Yyow89IQFZqZdoM46gb9ngYJ/XDCwKysnraJTGR+lmxagD3uwk+
	XaXP4DfNWiErng+1oE5X29X1jfersrmTTlU2gR88SxMgR4R/X6OKI6Y30Z+xyg==
X-Google-Smtp-Source: AGHT+IHwE3BmeY633h6z9OdUt2KUPSJ3mKVAE+dA7ACYa7t2C5hLuIWOLWXLTi0oYaqXZgvkqtD7rA==
X-Received: by 2002:a17:90a:ab12:b0:2b2:9855:2836 with SMTP id 98e67ed59e1d1-2b616be1f64mr2190414a91.34.1715154174910;
        Wed, 08 May 2024 00:42:54 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:ad4d:5f6c:6699:2da4])
        by smtp.gmail.com with ESMTPSA id l5-20020a17090aec0500b002b328adaa40sm780011pjy.17.2024.05.08.00.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 00:42:54 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv3 08/19] zram: add 842 compression backend support
Date: Wed,  8 May 2024 16:42:01 +0900
Message-ID: <20240508074223.652784-9-senozhatsky@chromium.org>
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
 drivers/block/zram/Kconfig       | 11 ++++++
 drivers/block/zram/Makefile      |  1 +
 drivers/block/zram/backend_842.c | 68 ++++++++++++++++++++++++++++++++
 drivers/block/zram/backend_842.h | 10 +++++
 drivers/block/zram/zcomp.c       |  4 ++
 5 files changed, 94 insertions(+)
 create mode 100644 drivers/block/zram/backend_842.c
 create mode 100644 drivers/block/zram/backend_842.h

diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
index 9dedd2edfb28..1e0e7e5910b8 100644
--- a/drivers/block/zram/Kconfig
+++ b/drivers/block/zram/Kconfig
@@ -44,6 +44,12 @@ config ZRAM_BACKEND_DEFLATE
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
@@ -73,6 +79,10 @@ config ZRAM_DEF_COMP_DEFLATE
 	bool "deflate"
 	depends on ZRAM_BACKEND_DEFLATE
 
+config ZRAM_DEF_COMP_842
+	bool "842"
+	depends on ZRAM_BACKEND_842
+
 endchoice
 
 config ZRAM_DEF_COMP
@@ -83,6 +93,7 @@ config ZRAM_DEF_COMP
 	default "lz4hc" if ZRAM_DEF_COMP_LZ4HC
 	default "zstd" if ZRAM_DEF_COMP_ZSTD
 	default "deflate" if ZRAM_DEF_COMP_DEFLATE
+	default "842" if ZRAM_DEF_COMP_842
 	default "unset-value"
 
 config ZRAM_WRITEBACK
diff --git a/drivers/block/zram/Makefile b/drivers/block/zram/Makefile
index 91c07595d8b4..029827a6ddac 100644
--- a/drivers/block/zram/Makefile
+++ b/drivers/block/zram/Makefile
@@ -5,6 +5,7 @@ obj-$(CONFIG_ZRAM_BACKEND_LZ4)			+= backend_lz4.o
 obj-$(CONFIG_ZRAM_BACKEND_LZ4HC)		+= backend_lz4hc.o
 obj-$(CONFIG_ZRAM_BACKEND_ZSTD)			+= backend_zstd.o
 obj-$(CONFIG_ZRAM_BACKEND_DEFLATE)		+= backend_deflate.o
+obj-$(CONFIG_ZRAM_BACKEND_842)			+= backend_842.o
 
 zram-y	:=	zcomp.o zram_drv.o
 
diff --git a/drivers/block/zram/backend_842.c b/drivers/block/zram/backend_842.c
new file mode 100644
index 000000000000..8ea7a230b890
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
+static int compress_842(void *ctx, const unsigned char *src,
+			unsigned char *dst, size_t *dst_len)
+{
+	struct sw842_ctx *zctx = ctx;
+	unsigned int dlen = *dst_len;
+	int ret;
+
+	ret = sw842_compress(src, PAGE_SIZE, dst, &dlen, zctx->mem);
+	if (ret == 0)
+		*dst_len = dlen;
+	return ret;
+}
+
+static int decompress_842(void *ctx, const unsigned char *src, size_t src_len,
+			  unsigned char *dst)
+{
+	unsigned int dlen = PAGE_SIZE;
+
+	return sw842_decompress(src, src_len, dst, &dlen);
+}
+
+struct zcomp_backend backend_842 = {
+	.compress	= compress_842,
+	.decompress	= decompress_842,
+	.create_ctx	= create_842,
+	.destroy_ctx	= destroy_842,
+	.name		= "842",
+};
diff --git a/drivers/block/zram/backend_842.h b/drivers/block/zram/backend_842.h
new file mode 100644
index 000000000000..c03a2396d7b2
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
+extern struct zcomp_backend backend_842;
+
+#endif /* __BACKEND_842_H__ */
diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index 9fc5477a6259..2a38126f4da3 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -21,6 +21,7 @@
 #include "backend_lz4hc.h"
 #include "backend_zstd.h"
 #include "backend_deflate.h"
+#include "backend_842.h"
 
 static struct zcomp_backend *backends[] = {
 #if IS_ENABLED(CONFIG_ZRAM_BACKEND_LZO)
@@ -38,6 +39,9 @@ static struct zcomp_backend *backends[] = {
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
2.45.0.rc1.225.g2a3ae87e7f-goog


