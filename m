Return-Path: <linux-kernel+bounces-311150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D4C96857D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B21B51C22B78
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F03117E900;
	Mon,  2 Sep 2024 10:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RMg4LjPl"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E34F187FE6
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 10:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725274637; cv=none; b=THtHLiEvjvT9jRcm+jgM9/rA+hSHcg66BoI9PS1xiYT5xbANevP3TFkvJ/RlWSpi0+McbwkIQ2FUGjid0OwDwxgU0EIRHpxpkC8stSMT05W5do8C4EotB/HxHJIzAAnbaU7lKQ/lPmFKqOa353VmlpKpYNitnAM7TLPOKBmxi0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725274637; c=relaxed/simple;
	bh=HVKbbsUahhVeMekRHiUNv/o7+sqVz5XWRuKPpJIOVUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bdwu0Qe+7qhvYmosAYc/5G9PsIMb/D42JXFk/ccm/StwzGeKSYt3stfPbHvDpCtLoYjRIOnF+HP9yBdSxVMSFm16P3Ky/99vL+V9q++tXFB8XqopnVg/u41Sfwgqhuud+3L2pBUtOUvv0tPG18FS1gtvG59/ZWCt52Y8pcD6KXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RMg4LjPl; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7176645e440so108260b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 03:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725274636; x=1725879436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=umU5t5tUEGsQb+BawdLT2hqRrjwi3DIEVB/XFUHlN1U=;
        b=RMg4LjPl4rCdObJ0gVNvcpXXwRyN0VDEWqnSX8bv0QxOYTlbGdLSfYxunbeATArJSs
         6seOP9VN/hVdEDxxynH7qcirOzrGsbFuQiJA9PbLoxdRMfI8N46fNfkocUz8QhfggsPy
         ET4F38Qa1PuZWYRt6Y3iJ+fYFhccV2FmVWFj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725274636; x=1725879436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=umU5t5tUEGsQb+BawdLT2hqRrjwi3DIEVB/XFUHlN1U=;
        b=PA34XTXfauTjBaUWK/0/78XdAQoSm/YmFbD2SpRKucBocuX2PZzmzGzUO2x/WPAnSA
         YZxWPYb4IMJNZbrvr8Fz7t04X64kFDiZ7yBfQsJcBQnDLW29YkRAx54JvpIMalilmG6k
         Rk76gHXU4glq+B2g54b8xp2/Y5nq6OOwIBbl5MXKoaQKRx0ITyA9bOngtMvgtPLstyyg
         33ANVnWuylcmW1kjcyyItaqEKyVDtlnyaZQT6+piLJ3+los8YrahsoDOHMs7P2oDvE/L
         iLRZG/uXyey6Ue2kCyfsJCVoxhIOmSbm4+TBkuYU1tflb2B3b3wmUrJ/K5IYZ/j+b5Sv
         +AJw==
X-Forwarded-Encrypted: i=1; AJvYcCXikhETTZR29RqVKR8+Ne0PU48zAG/BjuodGTsYSda2xRONqjhljUPVtEkDzg3PM0E2ISCkE72bCFDAkLw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6Bj186aHtCNraeOpSHMFiZ5+VI/fR8XpoZz+ZEZOWC6hd496P
	erXKzJ3BZvnAyC1psVFeOKqNenYYdzJ/WSFAya4zrWUefzQ8NtAqsxlnMPF/AQ==
X-Google-Smtp-Source: AGHT+IF9p7J5BZDv8ll8pm5VjYD16tAS3siICKagFPpCHIlyW3VizX10tsflv0dnZZ6WrxJbxZ+ngQ==
X-Received: by 2002:a05:6a00:9160:b0:714:1a71:cb0a with SMTP id d2e1a72fcca58-715e101f8camr23121192b3a.10.1725274635675;
        Mon, 02 Sep 2024 03:57:15 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:43a1:71e3:7464:e91b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55a51e9sm6633769b3a.78.2024.09.02.03.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 03:57:15 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv7 06/24] zram: add lz4 compression backend support
Date: Mon,  2 Sep 2024 19:55:54 +0900
Message-ID: <20240902105656.1383858-7-senozhatsky@chromium.org>
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
index 5d329a887b12..f1e76fc8431a 100644
--- a/drivers/block/zram/Kconfig
+++ b/drivers/block/zram/Kconfig
@@ -20,6 +20,12 @@ config ZRAM_BACKEND_LZO
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
@@ -33,12 +39,17 @@ config ZRAM_DEF_COMP_LZO
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
index a49d3e355c23..5da64e8fc798 100644
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
2.46.0.469.g59c65b2a67-goog


