Return-Path: <linux-kernel+bounces-172834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EF78BF74A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 09:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9481A1C209DF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 07:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3812D3E494;
	Wed,  8 May 2024 07:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UTzrDjS1"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004D045957
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 07:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715154167; cv=none; b=IxOM8oxNyAyAqA2pJdSpjeElAjPBxjsyXrLtgpw6wQosEsgi4g+DQBb7vGNGHT2xpKzS2vN7isVObt7HEh2cniMMIVZqv3/utPAvbfZqm6YmTv8cRKxRnE1LEoinkjCNVbpCsT2H0NjAcgRHiKd6qJmV16PJrgx0Rx5VC0n4wrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715154167; c=relaxed/simple;
	bh=FN4STGuvFZWpAy2rRpFsI/oXrQt4bTeq5tFn+4e9nzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sBI5oaBx3L7VbAotFPtoDLvDeFPbiw0Lc+EfjwN5bQZ/FbK9JOAxf7NHGwg9wKrQV4wC2il0SP745olAT47D22mMLlGMi2N3+wZ+qheLkaRVF+QwITOtenwMsfxK5c/fIOl9nU5LOlNvQqx5x052sCfGcWGM8QttSwMeqi6ehw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UTzrDjS1; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2b6456f7e94so23732a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 00:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715154165; x=1715758965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R3nECJbuYUQmjPzVo2jmTce+DVuwgWkYW9TFfzYmbzE=;
        b=UTzrDjS1wFYkc3K8jYt9SascaEcQEHjJBmAY/tZ0VDY+W2+sOMxxpwzLZdg2wkhwb+
         Q75AOVYCRG8atiA+KrBDXQBqsInAIvr2CeCaS6v2GnWO0g00umbKcCqEOBZ7m3Cr4EYh
         8HqjkXC6wuGQxKCWsz1MMMxVKDlI6TqfkAFVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715154165; x=1715758965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R3nECJbuYUQmjPzVo2jmTce+DVuwgWkYW9TFfzYmbzE=;
        b=b/Ir20hcBfL5S8DLSJYaBBdZSuTvBjf6rw3HORDtkASQl8OfDnmh6VRCPaRY/QxD0G
         19wcY3S1YB1rOxWJFaElJbqpzaK0I0GaTnx0luJOtY+tGFeiXebZvT8xZA6CU2YAa8sE
         VLzDeCaiiVAXM9LWvSgwmWUq5X+Ffh5j3LkJoajnXVLc0PdjLhK75OS0zipeNpgKPSuS
         DgNFPLoy30Fyf+BuqhpkkaiBc2x0oLhnMrUeJJMZQF5eV/diU0Gt5hfN66u5MuScYtcz
         BG+2JSq0usSwMxWYIKHFN6PUhvsUKCIhNbA249C7yoI0m1vHEXX7qptkDwKx+GtuYHL+
         N6nA==
X-Gm-Message-State: AOJu0YxyX2SxYx12ASbDEdBXSS15p2B0N925er2kGZ9AeulPpV5tgy/g
	N3orZePtsCVOs2syGhTNnIfSBKv20/eNB5wPf7hOFEJcDWrlucFZuEr7a0G1BA==
X-Google-Smtp-Source: AGHT+IE0MlFlPwSWQJRjErFW2GMMS4LLdcDfJb8bL7Or5RyoCHAaclgPc25OI2HOCjFzRoaD8dOoHg==
X-Received: by 2002:a17:90a:1108:b0:2ab:8324:1b47 with SMTP id 98e67ed59e1d1-2b6119c8e82mr3128891a91.15.1715154165288;
        Wed, 08 May 2024 00:42:45 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:ad4d:5f6c:6699:2da4])
        by smtp.gmail.com with ESMTPSA id l5-20020a17090aec0500b002b328adaa40sm780011pjy.17.2024.05.08.00.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 00:42:44 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv3 04/19] zram: add lz4hc compression backend support
Date: Wed,  8 May 2024 16:41:57 +0900
Message-ID: <20240508074223.652784-5-senozhatsky@chromium.org>
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
 drivers/block/zram/Kconfig         | 11 +++++
 drivers/block/zram/Makefile        |  5 ++-
 drivers/block/zram/backend_lz4hc.c | 72 ++++++++++++++++++++++++++++++
 drivers/block/zram/backend_lz4hc.h | 10 +++++
 drivers/block/zram/zcomp.c         |  4 ++
 5 files changed, 100 insertions(+), 2 deletions(-)
 create mode 100644 drivers/block/zram/backend_lz4hc.c
 create mode 100644 drivers/block/zram/backend_lz4hc.h

diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
index f1e76fc8431a..0d890a8d2dc4 100644
--- a/drivers/block/zram/Kconfig
+++ b/drivers/block/zram/Kconfig
@@ -26,6 +26,12 @@ config ZRAM_BACKEND_LZ4
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
@@ -43,6 +49,10 @@ config ZRAM_DEF_COMP_LZ4
 	bool "lz4"
 	depends on ZRAM_BACKEND_LZ4
 
+config ZRAM_DEF_COMP_LZ4HC
+	bool "lz4hc"
+	depends on ZRAM_BACKEND_LZ4HC
+
 endchoice
 
 config ZRAM_DEF_COMP
@@ -50,6 +60,7 @@ config ZRAM_DEF_COMP
 	default "lzo-rle" if ZRAM_DEF_COMP_LZORLE
 	default "lzo" if ZRAM_DEF_COMP_LZO
 	default "lz4" if ZRAM_DEF_COMP_LZ4
+	default "lz4hc" if ZRAM_DEF_COMP_LZ4HC
 	default "unset-value"
 
 config ZRAM_WRITEBACK
diff --git a/drivers/block/zram/Makefile b/drivers/block/zram/Makefile
index 1be5d2657960..815b45471c7d 100644
--- a/drivers/block/zram/Makefile
+++ b/drivers/block/zram/Makefile
@@ -1,7 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-obj-$(CONFIG_ZRAM_BACKEND_LZO)	+= backend_lzorle.o backend_lzo.o
-obj-$(CONFIG_ZRAM_BACKEND_LZ4)	+= backend_lz4.o
+obj-$(CONFIG_ZRAM_BACKEND_LZO)		+= backend_lzorle.o backend_lzo.o
+obj-$(CONFIG_ZRAM_BACKEND_LZ4)		+= backend_lz4.o
+obj-$(CONFIG_ZRAM_BACKEND_LZ4HC)	+= backend_lz4hc.o
 
 zram-y	:=	zcomp.o zram_drv.o
 
diff --git a/drivers/block/zram/backend_lz4hc.c b/drivers/block/zram/backend_lz4hc.c
new file mode 100644
index 000000000000..1735a2598443
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
+	ctx->mem = vmalloc(LZ4HC_MEM_COMPRESS);
+	if (!ctx->mem) {
+		lz4hc_destroy(ctx);
+		return NULL;
+	}
+
+	/* @FIXME: using a hardcoded LZ4HC_DEFAULT_CLEVEL for now */
+	ctx->level = LZ4HC_DEFAULT_CLEVEL;
+	return ctx;
+}
+
+static int lz4hc_compress(void *ctx, const unsigned char *src,
+			  unsigned char *dst, size_t *dst_len)
+{
+	struct lz4hc_ctx *zctx = ctx;
+	int ret;
+
+	ret = LZ4_compress_HC(src, dst, PAGE_SIZE, *dst_len,
+			      zctx->level, zctx->mem);
+	if (!ret)
+		return -EINVAL;
+	*dst_len = ret;
+	return 0;
+}
+
+static int lz4hc_decompress(void *ctx, const unsigned char *src,
+			    size_t src_len, unsigned char *dst)
+{
+	int dst_len = PAGE_SIZE;
+	int ret;
+
+	ret = LZ4_decompress_safe(src, dst, src_len, dst_len);
+	if (ret < 0)
+		return -EINVAL;
+	return 0;
+}
+
+struct zcomp_backend backend_lz4hc = {
+	.compress	= lz4hc_compress,
+	.decompress	= lz4hc_decompress,
+	.create_ctx	= lz4hc_create,
+	.destroy_ctx	= lz4hc_destroy,
+	.name		= "lz4hc",
+};
diff --git a/drivers/block/zram/backend_lz4hc.h b/drivers/block/zram/backend_lz4hc.h
new file mode 100644
index 000000000000..29c428a850e2
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
+extern struct zcomp_backend backend_lz4hc;
+
+#endif /* __BACKEND_LZ4HC_H__ */
diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index 902bdaf7e299..f04f5844a23c 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -18,6 +18,7 @@
 #include "backend_lzo.h"
 #include "backend_lzorle.h"
 #include "backend_lz4.h"
+#include "backend_lz4hc.h"
 
 static struct zcomp_backend *backends[] = {
 #if IS_ENABLED(CONFIG_ZRAM_BACKEND_LZO)
@@ -26,6 +27,9 @@ static struct zcomp_backend *backends[] = {
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
2.45.0.rc1.225.g2a3ae87e7f-goog


