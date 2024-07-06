Return-Path: <linux-kernel+bounces-243047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BAF9290F5
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 07:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8593A1F231D5
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 04:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CFB56446;
	Sat,  6 Jul 2024 04:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e2oUMHOo"
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABA44F20C
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 04:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720241836; cv=none; b=rnp0lMFs03njBek5r86TaxGs4+pfdgh9/Cu6QvPX4HCk8zObDeMt7qV3m24ooLAxjUzQfeQmsyZUznLZittu2Z+I5oyQXDi6LExE7i5vkvE6XR80DuAA9Im5MFbj/uAofpRx7BTd+gxlpB2sWcdGOCQU53edQRlv8Y9XrAVIf/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720241836; c=relaxed/simple;
	bh=5q3+C4a5VJLqPs/DDUL4c1/IyPpqHMV7c98diLyzayA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tpH63liwkFaOj+zenS0SxGh/l8MZbcG/JeZbwf4rTKXsMRTj3E3t96O97cQl8nRTnWy+X+e5zn5ydBB4bDJ6hjph/gQxcaOxNlFADuUHXAsZnlU1GIbQycV858IxrY/z3/X6LvPSvSa2LUNS3iJxSgtz/Xv8AEn4DhcW0GNdvWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=e2oUMHOo; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7035b2947a4so605572a34.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 21:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720241834; x=1720846634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/iBBmeFFUspr72Atovyon3yPvyiS3OHh9p4aaALH7Fw=;
        b=e2oUMHOoI80WJrOpZepUa0ylb/I8R+lm3hC7xRJjmxhb3jMDAgz30tb5tFkF4C0XAJ
         aNuIcKYvilQ3pXdjjdo+WzwegCawHcZNHtRbTGHv+xOtCSu5MieSgr4bqg+HZ2Xj9H3i
         QBeyogygWKWb2cYv3EutcHD8EINyBJoEwY14I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720241834; x=1720846634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/iBBmeFFUspr72Atovyon3yPvyiS3OHh9p4aaALH7Fw=;
        b=J7r7y8I4V6mpZR9MB1X71OXKJzMdxLgT4rDGlbsP6dXMF1VByUbAePZsC3shkEj7AU
         ncl4zXPSJ5sn3+KQxcrA3LhKX5oq25KtcwiIMy6RtJ/uiOZPihXat/Oj4N3+/has6ggn
         Rxq60uR5ajIvV/ieBU1prBPsc+iTHB2Cln6fE4TbHNPKJios6UVTrleMfDZD0w/5z2YK
         bPd5UNzdtuOwmN9g+Pb4cmmc8fnIK9Gxm/1NBRtEcFNxLjHIklSSNsQfOvR1pu/p/qM5
         cTIQsBZnEW+/kZ3Afgk+biqB/lGytR2S3qId/NR618mw51xCvJgLrIXLEPaAWwrDF+ew
         7I8Q==
X-Gm-Message-State: AOJu0YzZC1WMQQQcChX02dPtXjx8VNPRzYZoJIem0pgUacuE1ukcZBls
	ZKSTKhcDOYCiGKrFQRANeSOft1Kr9PndWjs4p/PiY6AtuyWE/LRmNExw1fRuCA==
X-Google-Smtp-Source: AGHT+IFuenaK4XE/ksni2ZBOpv/6qEP4wUOlksTGQimi8Qo8ACEQmMPy6KwiTM9sOm3Q4yDTqMhCRA==
X-Received: by 2002:a05:6830:348e:b0:6f9:faf5:79b0 with SMTP id 46e09a7af769-7034a81e8bemr8069075a34.31.1720241834103;
        Fri, 05 Jul 2024 21:57:14 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:88a7:e7d7:713d:ff09])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7623cd854b2sm2784104a12.38.2024.07.05.21.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 21:57:13 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv5 11/23] zram: add 842 compression backend support
Date: Sat,  6 Jul 2024 13:56:13 +0900
Message-ID: <20240706045641.631961-12-senozhatsky@chromium.org>
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
index 000000000000..83802d6c0e7d
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
+struct zcomp_ops backend_842 = {
+	.compress	= compress_842,
+	.decompress	= decompress_842,
+	.create_ctx	= create_842,
+	.destroy_ctx	= destroy_842,
+	.name		= "842",
+};
diff --git a/drivers/block/zram/backend_842.h b/drivers/block/zram/backend_842.h
new file mode 100644
index 000000000000..898ac1410329
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
+extern struct zcomp_ops backend_842;
+
+#endif /* __BACKEND_842_H__ */
diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index 13c58e197d60..280dcc48fb5e 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -18,6 +18,7 @@
 #include "backend_lz4hc.h"
 #include "backend_zstd.h"
 #include "backend_deflate.h"
+#include "backend_842.h"
 
 static struct zcomp_ops *backends[] = {
 #if IS_ENABLED(CONFIG_ZRAM_BACKEND_LZO)
@@ -35,6 +36,9 @@ static struct zcomp_ops *backends[] = {
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
2.45.2.803.g4e1b14247a-goog


