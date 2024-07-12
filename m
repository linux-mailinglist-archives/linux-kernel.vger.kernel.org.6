Return-Path: <linux-kernel+bounces-250175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF4592F4F6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 07:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C8811F226D5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 05:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDF578C80;
	Fri, 12 Jul 2024 05:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WWXdtG24"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FFE18654
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 05:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720761561; cv=none; b=NS3GwqmrgpOX44frNN+1Q1EYXW7Bevsoefb14Wt8105pl+HU7DtjCZ0ea9zD9EVKua8zTTELl0ErxOmdar4+JYzfdd+cvYF1mXzWC5mhKt9NvOiMXxRAaiD6CfaIe9Z0npyv2KBQuyaTj18mJG9/daU7pLZclYwagPqDZbp9LGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720761561; c=relaxed/simple;
	bh=u2NVoXdSGQP3WhlQPbRooV94Y2i5OvDj2bZiUJ5WI8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mJJyROEzIxze0ChydEN+P6B7pyj3fv1cnfm60MV2yRrfUYotzFFNVJmY57XvBjQKlAjLqqUXy7zO5NhUzxDe9z37nGml2adwTjdyVoRxyy+MEs4NLnF0hzjGrasG+QqvPcz6fBIJO4OMmaO5X5YMY+R+j7LAZI4SxrTqt44kzGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WWXdtG24; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-703ba2477bdso778042a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 22:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720761558; x=1721366358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v89ezEM1/0FTv8HuuQypBz5T+BXw4z2POdCqGFQackQ=;
        b=WWXdtG24EAeoqFC8Lu/Mctc79Id852wTqvf3eI9TkFrqxLQCeGk0oFIzloWXC9zz9I
         N9zWbmMX1FZ9PB+BU4p4fHLCy3nDR5+i7rrh8iVuwCHpiTVmK1v744Mys5Brq1TED/Mg
         C9FdeWBd3heTpvMFsrZXjI8clSqulZ3mW+shk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720761558; x=1721366358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v89ezEM1/0FTv8HuuQypBz5T+BXw4z2POdCqGFQackQ=;
        b=GG8wnmvPDqbZTSG8LjiziZczK8Ie6MMIxVz9gchHZXNHnXgu3r06vYuR7COmmTst95
         tMqF5U8GXpo0HGzIrem3m1OegIFhBMVhbwgnMGH+GUo9CpyaM+uwO1QW9QcNWBQke2wn
         4HfYdp8/dvSvhzNu05kKlQhR7xEi2sBkbWAyxBMG7LlI4oM0VnwYMJ7eR1xynuqUOxQ0
         6KDVPB4WXI+Hc9+3uuImLtWWO2kBriWawUBG1+IhHor5mZIuC7cW64dC/w0gns7gmccN
         NVrL+dWOaYDmcx69Nhz8BblaSdq0RNYV7slc3tCNq2vhTv/tsTaCVrXuF/SoNSpEzvV9
         5xLg==
X-Gm-Message-State: AOJu0Yyc7d6ZqWyiC4xQmoaSmeZ8o2erXqC4geJmirWNF0ePPDVvucs+
	WOmU7Mdk2+SA5QCxNYAKbo02O82rWSOsufQPbMldlVtVpKYz4zVNNiS8xfSr2oqNf3M4y81HRCf
	FeH1c
X-Google-Smtp-Source: AGHT+IE4KygjsvNfaffSipLnMl8tKev5nB7dKvv95cdYYWzs/vyKBHcrc8THYxuaxwOCTi7ULMmgKg==
X-Received: by 2002:a05:6830:1e47:b0:703:5db8:805 with SMTP id 46e09a7af769-703759faf93mr12786584a34.4.1720761558504;
        Thu, 11 Jul 2024 22:19:18 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:15f3:5252:ec56:52ae])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b43967851sm6553436b3a.109.2024.07.11.22.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 22:19:18 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v6 06/23] zram: add lz4 compression backend support
Date: Fri, 12 Jul 2024 14:18:17 +0900
Message-ID: <20240712051850.484318-7-senozhatsky@chromium.org>
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

Add s/w lz4 compression support.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/Kconfig       | 11 +++++
 drivers/block/zram/Makefile      |  1 +
 drivers/block/zram/backend_lz4.c | 72 ++++++++++++++++++++++++++++++++
 drivers/block/zram/backend_lz4.h | 10 +++++
 drivers/block/zram/zcomp.c       |  4 ++
 5 files changed, 98 insertions(+)
 create mode 100644 drivers/block/zram/backend_lz4.c
 create mode 100644 drivers/block/zram/backend_lz4.h

diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
index ce70b8ef3405..28288e9432d4 100644
--- a/drivers/block/zram/Kconfig
+++ b/drivers/block/zram/Kconfig
@@ -21,6 +21,12 @@ config ZRAM_BACKEND_LZO
 	select LZO_COMPRESS
 	select LZO_DECOMPRESS
 
+config ZRAM_BACKEND_LZ4
+	bool "lz4 compression support"
+	depends on ZRAM
+	select LZ4_COMPRESS
+	select LZ4_DECOMPRESS
+
 choice
 	prompt "Default zram compressor"
 	default ZRAM_DEF_COMP_LZORLE
@@ -34,12 +40,17 @@ config ZRAM_DEF_COMP_LZO
 	bool "lzo"
 	depends on ZRAM_BACKEND_LZO
 
+config ZRAM_DEF_COMP_LZ4
+	bool "lz4"
+	depends on ZRAM_BACKEND_LZ4
+
 endchoice
 
 config ZRAM_DEF_COMP
 	string
 	default "lzo-rle" if ZRAM_DEF_COMP_LZORLE
 	default "lzo" if ZRAM_DEF_COMP_LZO
+	default "lz4" if ZRAM_DEF_COMP_LZ4
 	default "unset-value"
 
 config ZRAM_WRITEBACK
diff --git a/drivers/block/zram/Makefile b/drivers/block/zram/Makefile
index 2a3db3368af9..567f4434aee8 100644
--- a/drivers/block/zram/Makefile
+++ b/drivers/block/zram/Makefile
@@ -3,5 +3,6 @@
 zram-y	:=	zcomp.o zram_drv.o
 
 zram-$(CONFIG_ZRAM_BACKEND_LZO)	+= backend_lzorle.o backend_lzo.o
+zram-$(CONFIG_ZRAM_BACKEND_LZ4)	+= backend_lz4.o
 
 obj-$(CONFIG_ZRAM)	+=	zram.o
diff --git a/drivers/block/zram/backend_lz4.c b/drivers/block/zram/backend_lz4.c
new file mode 100644
index 000000000000..c1d19fed5af2
--- /dev/null
+++ b/drivers/block/zram/backend_lz4.c
@@ -0,0 +1,72 @@
+#include <linux/kernel.h>
+#include <linux/lz4.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+
+#include "backend_lz4.h"
+
+struct lz4_ctx {
+	void *mem;
+	s32 level;
+};
+
+static void lz4_destroy(void *ctx)
+{
+	struct lz4_ctx *zctx = ctx;
+
+	vfree(zctx->mem);
+	kfree(zctx);
+}
+
+static void *lz4_create(void)
+{
+	struct lz4_ctx *ctx;
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return NULL;
+
+	/* @FIXME: using a hardcoded LZ4_ACCELERATION_DEFAULT for now */
+	ctx->level = LZ4_ACCELERATION_DEFAULT;
+	ctx->mem = vmalloc(LZ4_MEM_COMPRESS);
+	if (!ctx->mem)
+		goto error;
+
+	return ctx;
+error:
+	lz4_destroy(ctx);
+	return NULL;
+}
+
+static int lz4_compress(void *ctx, const unsigned char *src, size_t src_len,
+			unsigned char *dst, size_t *dst_len)
+{
+	struct lz4_ctx *zctx = ctx;
+	int ret;
+
+	ret = LZ4_compress_fast(src, dst, src_len, *dst_len,
+				zctx->level, zctx->mem);
+	if (!ret)
+		return -EINVAL;
+	*dst_len = ret;
+	return 0;
+}
+
+static int lz4_decompress(void *ctx, const unsigned char *src,
+			  size_t src_len, unsigned char *dst, size_t dst_len)
+{
+	int ret;
+
+	ret = LZ4_decompress_safe(src, dst, src_len, dst_len);
+	if (ret < 0)
+		return -EINVAL;
+	return 0;
+}
+
+const struct zcomp_ops backend_lz4 = {
+	.compress	= lz4_compress,
+	.decompress	= lz4_decompress,
+	.create_ctx	= lz4_create,
+	.destroy_ctx	= lz4_destroy,
+	.name		= "lz4",
+};
diff --git a/drivers/block/zram/backend_lz4.h b/drivers/block/zram/backend_lz4.h
new file mode 100644
index 000000000000..c11fa602a703
--- /dev/null
+++ b/drivers/block/zram/backend_lz4.h
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#ifndef __BACKEND_LZ4_H__
+#define __BACKEND_LZ4_H__
+
+#include "zcomp.h"
+
+extern const struct zcomp_ops backend_lz4;
+
+#endif /* __BACKEND_LZ4_H__ */
diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index e358319c59dc..080cf1d001f0 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -14,11 +14,15 @@
 
 #include "backend_lzo.h"
 #include "backend_lzorle.h"
+#include "backend_lz4.h"
 
 static const struct zcomp_ops *backends[] = {
 #if IS_ENABLED(CONFIG_ZRAM_BACKEND_LZO)
 	&backend_lzorle,
 	&backend_lzo,
+#endif
+#if IS_ENABLED(CONFIG_ZRAM_BACKEND_LZ4)
+	&backend_lz4,
 #endif
 	NULL
 };
-- 
2.45.2.993.g49e7a77208-goog


