Return-Path: <linux-kernel+bounces-169451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 728FC8BC8D4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 10:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 295C9282356
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 08:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E35C1411E2;
	Mon,  6 May 2024 07:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XkbjsdWa"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434371428FD
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 07:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714982346; cv=none; b=hIBb6LGZPrXlL55eEjuLzVUHVmIFI9eN0n/SF8vLG8XxAgbsYKVRJlLo5ZvK7FONokx0L2JlzVdUHkhb0mEjuXybIsQmXOS7XoWKEMjNBQ5fJMuXHfw5z+rbklM6ktuvflsOSdSDRuw4lpQ7BZ89BDLucGmMFxfqHJhSRM/vgdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714982346; c=relaxed/simple;
	bh=kNJbXxfK8zdnskpjgM5oyiiq8zq2KQp2aiK9qKIm8Jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HIcl5Heumx5DYuy2kcFhiJn5kXwqr368ef5wnr/e6tADmnadDXgefedaEwGK3e9CBr2ansHpwVXeTXdZuQbMCS4YkFsaWNQ79dUZcG+Ouf8/mc9oAi+Ng77bRZihW2FkCqkXDliK4x3AQkDukiAeLwLNHm1evrkLGJvPMlsmk6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XkbjsdWa; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1ecddf96313so13319155ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 00:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714982344; x=1715587144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EEH83ikFWbHDBUUzWu4h4KsSObV7EItvgFziqF5bCxw=;
        b=XkbjsdWaI5kxkxIsPYMcVSotFcCqJRHDQuhAsAM1zhvrp6SiZxgh41SgUFPjD+8fOb
         lbWN4drWqJTZLsUt7PX62p51vTsDJqO5JjVZwCGTNQjKTwbXPyitoNSVcrIxgjx141vW
         ywzSZayTzvkYpIlAyWCDUxYuObsxDMPx9RXb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714982344; x=1715587144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EEH83ikFWbHDBUUzWu4h4KsSObV7EItvgFziqF5bCxw=;
        b=nWi3zLTntua08Noqm20rITzNcrm1i5ICvGkbOQZkiErgO6g/M3SxrzR7gFFlhAc3sF
         5mUZSo7qkvZL+d/bknhGMQO909RAoslRx+os7Ywr2O+MPgMYlM9aFs1LWNduqz8rwYEf
         G1Yjy4TMuwsite4hX6g2JnZdnwqTXf1TWMiNI5ZTT9KJWnkQlVGGKoshwEDYTe5auodJ
         VBRsf6BfYsUlJxPHvjGOKjIRBVT7Sj4E6lNd/MwndClJK/DBktfQR1OHgb5ll3/Cbmw5
         mxXS4lqPZDfU72SEqnaUPd9eXH9OlgQpL+x33+mfSl3kixomTvclKJxgDi8A/wqJyM2D
         OUrg==
X-Gm-Message-State: AOJu0Yyzk3qzQnS2JyAl72edn/geoSDnliq9KgW8L0tD5qm+3JIWB72N
	aakHM7U2vQpSJV0Lodt3A8+tguvoh7tzZAZ+e1XFwZIuBikB92eAHswH/4vEUg==
X-Google-Smtp-Source: AGHT+IFvtTM7Cp4XRi4ugjU8maUmX0Y1BJMBzeXwG4uz5NGaWtdCrHH1ePjQEmZ/XZrKEMZrCdrJng==
X-Received: by 2002:a17:902:d2cd:b0:1e3:e1d5:c680 with SMTP id n13-20020a170902d2cd00b001e3e1d5c680mr13775583plc.63.1714982344547;
        Mon, 06 May 2024 00:59:04 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:4e24:10c3:4b65:e126])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902f54600b001ec64b128dasm7633772plf.129.2024.05.06.00.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 00:59:04 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2 08/17] zram: add 842 compression backend support
Date: Mon,  6 May 2024 16:58:21 +0900
Message-ID: <20240506075834.302472-9-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
In-Reply-To: <20240506075834.302472-1-senozhatsky@chromium.org>
References: <20240506075834.302472-1-senozhatsky@chromium.org>
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


