Return-Path: <linux-kernel+bounces-311152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7742C968580
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03EC51F23CCE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6661D460A;
	Mon,  2 Sep 2024 10:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JovDaDib"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964861D27A9
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 10:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725274640; cv=none; b=FvjLqaQrIPsn4C47Gm5p3c3VuIVmGLMOcL9n24fIW9oAYH8GV3/rqfQnvC5d3kiUgGdoPF6bYTGQKETcbVR+/ccYcO4MLSqUq+Fs/FTjzA+pJpE8AjxGPxq7FMV/Jtd2TIct7uJFPIjLtv1FvgLQs4jHNkc0p7vK6nZDL4atwiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725274640; c=relaxed/simple;
	bh=4YKpqE+2ih/uuhzC6ZcGyVoRvcjCC5J44XhaNaAOdbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iMOoDOriFGzWHH38obaaGImqR4LDYyBR6xrgnl7blXg+HtCkd7C0G99QhhgmN9IXRxRYRPxsI/7pCjfsNyDfWh00CYWVmamLxwdFx0BMB7GqTwaIVeNU3IK2CVsi/OJydcfp0I/PsYojblzR/b0wTQOScPtx/cikm1S/TAHpYr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JovDaDib; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3df08d53820so2260602b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 03:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725274638; x=1725879438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3VU44Jwz/VEJm+kmZG1z/WLYNiw8d/JQb3gDJ5Cfi0I=;
        b=JovDaDibgVdcXuFzGZ+VKjlOs06aBYTRs818uO/oafSD79u9YxNKyGixoh2l1B2XUr
         IFkIXF+LWJeaPmwRlAsVTCM+ya/pC2g2omdlNyDok5ONBMwSrIGXbS0dvVqGMESv17Wo
         vJ6HSoptKuh23Oo8flSJ57jU4CQmBPWSBjZuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725274638; x=1725879438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3VU44Jwz/VEJm+kmZG1z/WLYNiw8d/JQb3gDJ5Cfi0I=;
        b=AzRLFelDbxgdGOApMXKOCUT0mDo0RJ+FFCncSG4OFIpBj8aayX7ZPSsEdwP/GeQb2v
         UXjoMCdx+TOnvbMUiJF5H2IJOuQLsUvt6T/5U8n6MxBwuInvNOyCwgPQyummmVxNZb8R
         inWPiUYYOmhYBV1Wjymbo+csi8EfGZVhIUv/tB5fgiLe5DSv1SGDh30zeyGRYQgbATgY
         hMk9McEQOQPl5lVQSjpgE6HPM39jcLsSX67DF5ybQsv5Z0JwWpi38yH48llu/1OxcNFU
         bBABu4VeJv4XAkP9so2wZsFK20pErnGVwBT+8xHcivC4KGvJMni6ti30MRFIGw+5ea6+
         pi4g==
X-Forwarded-Encrypted: i=1; AJvYcCUcWxxpA44AKSTwwyDmS2E+b9dJS1X+LfQYqt+3HqQFQQGI+nXEzlqR9pQh3l74xxu+cFK0GVbbRHb1Bi4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwidGMJuAqUaQH4SjVe11ljYXe1OeV7ay7HE1BYExrSegQBUTSj
	4jOTrK2frIn7JcaQxnjPh4f/f5bCpaoGP1HYdgqbdkhy5zBBzVgHXBRAMcdfHgj1M/28nkEEUXc
	1hw==
X-Google-Smtp-Source: AGHT+IFDcmn5rB7xa4Aose9bj5eDc+Tog9OzkwDNZVIHfU73hBt54+XHugYKcEDMzeb1aMkFJ89UBA==
X-Received: by 2002:a05:6870:ac1e:b0:261:1046:66fc with SMTP id 586e51a60fabf-2779006e096mr16188905fac.4.1725274637759;
        Mon, 02 Sep 2024 03:57:17 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:43a1:71e3:7464:e91b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55a51e9sm6633769b3a.78.2024.09.02.03.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 03:57:17 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv7 07/24] zram: add lz4hc compression backend support
Date: Mon,  2 Sep 2024 19:55:55 +0900
Message-ID: <20240902105656.1383858-8-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240902105656.1383858-1-senozhatsky@chromium.org>
References: <20240902105656.1383858-1-senozhatsky@chromium.org>
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
index 5da64e8fc798..a06cdb9aa567 100644
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
2.46.0.469.g59c65b2a67-goog


