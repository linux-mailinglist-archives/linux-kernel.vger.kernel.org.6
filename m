Return-Path: <linux-kernel+bounces-243042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF3B9290F0
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 06:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45057282C75
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 04:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0DB2B9BC;
	Sat,  6 Jul 2024 04:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lw4CeCSq"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10CF2374C
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 04:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720241825; cv=none; b=E406ytteCYTPomcXRXUHtSQQirkirgfpnPsUgDtT5sNyY7QUd21Tb5wM+1DSWdob5u+E1/SXfpRF5HVxMyjU3w2w7dUNOQK7VfFaslpWup0/UtYLo786ZJOuqoBHn4Ip7VMrIsjLdDv7576YqIphmMr/A8skbk7BAwvUgEx+ugg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720241825; c=relaxed/simple;
	bh=bDNOAul3soezzN79Cz6I49QyuvBl/1Em9Z7hkMv1DD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n7YHtjgFOAs6pcg/Ud81sSOv94MoQ2tWZJEnKKsmUP7+/EIM+Y9glTkkZiHFiUmLhneCCxquBXCFPiq+yO1NFRAHM6PFz2nozpKTrrgZprEhqzh4qeDFzn55S7UNf2V4Y466WfD2/Yzcf/a8Vnkjrps9h4qGsF2wPJuZp8QPPfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lw4CeCSq; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70b04cb28baso1641683b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 21:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720241823; x=1720846623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4gYDtkSJqtpqqQGmjPwKrPrrHp6vWlNSd0sXatgXT8k=;
        b=lw4CeCSq/zaI6IffHD6+T2/eemut60UJuvIT06tCOZ2PpZ1GYcBKWvgU9FLmcgJHBN
         Pi+CSsS8vMAoStS8sFs0IY17meiqm5JJDLtscNxcDPFszP282XeIMMjj6Ik3fYlj44su
         i+zz7tpxl6AUT/a9M7IcsCCVYnTVf5m3fPIfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720241823; x=1720846623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4gYDtkSJqtpqqQGmjPwKrPrrHp6vWlNSd0sXatgXT8k=;
        b=CEDYkjkKccPL15O6vm5HDNnukTPUQ/ePHuVQ3FdfQobRzeCHTI2aFNnZPxkezMiiB8
         PZqt4Jza/VZL+bpJ3pYsThSlOppEMHmJY/minz6h9CC2U/iLOHE34JIND7473J2NiIDB
         jy0m9LmgnQO1A/ITCzGWiftQmXwAQ6ZNPg49Ks1ByhgkxdiTSRHF2Zm6oEn8APxZg+cM
         JDKYyYkQ/GxONlb29OiNH+/CSIOBwibbosppwa4EKKNrTm6K8fPlfN/ypB+AxCYeHRkQ
         GiEXIO4hNxwZ5QQdb6k3PXRCNgcsKwX3/FXSnhtMlnFookeW7mn8k849I3C+FcJLVEZi
         hjfg==
X-Gm-Message-State: AOJu0YzCaQRvgVoE5x1XxFo39VnZSISJN2qxEJqrwV5UHEEUbS9oLGv2
	xKnXRUjc6DrazlxTAU70UmEREF8Kv8uzXg7pG+GOZtbaj3U67L7L4kZiT+W5Kw==
X-Google-Smtp-Source: AGHT+IHS+p2eSSQmz71ZxQsVRU6NdvwVL9g5PlB8XoRw0H/ujsJy3dmryV17QmdiqiI/aLWjNvl9/A==
X-Received: by 2002:a05:6a00:2d8f:b0:706:6b0b:9573 with SMTP id d2e1a72fcca58-70b00a64b24mr7574762b3a.19.1720241823289;
        Fri, 05 Jul 2024 21:57:03 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:88a7:e7d7:713d:ff09])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7623cd854b2sm2784104a12.38.2024.07.05.21.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 21:57:02 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv5 06/23] zram: add lz4 compression backend support
Date: Sat,  6 Jul 2024 13:56:08 +0900
Message-ID: <20240706045641.631961-7-senozhatsky@chromium.org>
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
index 000000000000..4de389fb3463
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
+struct zcomp_ops backend_lz4 = {
+	.compress	= lz4_compress,
+	.decompress	= lz4_decompress,
+	.create_ctx	= lz4_create,
+	.destroy_ctx	= lz4_destroy,
+	.name		= "lz4",
+};
diff --git a/drivers/block/zram/backend_lz4.h b/drivers/block/zram/backend_lz4.h
new file mode 100644
index 000000000000..2e1df0a80887
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
+extern struct zcomp_ops backend_lz4;
+
+#endif /* __BACKEND_LZ4_H__ */
diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index fa074b8d167e..8c1a904e95b6 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -14,11 +14,15 @@
 
 #include "backend_lzo.h"
 #include "backend_lzorle.h"
+#include "backend_lz4.h"
 
 static struct zcomp_ops *backends[] = {
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
2.45.2.803.g4e1b14247a-goog


