Return-Path: <linux-kernel+bounces-250174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE77592F4F5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 07:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D20F51C21CA6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 05:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B7718638;
	Fri, 12 Jul 2024 05:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g0invbkq"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7CC7604D
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 05:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720761558; cv=none; b=INKhKuON1ZUOfX97YAzxYZPjojBA72VNlB+Q2ePvtl6km9Mn54AJSPTn+ZGBzL6P2TDkOqoD3DZZN7DhoUwwDv78UW7N1ppB2KuSs6cNZWa8Z+/SVaiyjBWD0daES9SgfO6KL3S+0oLPpzRXNoOaU+EzMnZQ6xhLHIkooS/fNk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720761558; c=relaxed/simple;
	bh=CHEdMiMhgYInwkfp3Q8EUoDNjUdbVZTVY8neSKYoHcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u9R+Y6wKvGUGhdesOwQ0j9lCqO6glS6C6f8zR/ZiXewEpAnLBjubC4ouL66q9bKzdyDuDGQAuKqxBTZ/zR/UAhFZh0Aw8vLfUApxS3lud7kASROMBzcZ4a3Bjdqj8enGYDAu4Z2lXAJcYduyIZ/jeA7wYxMlC5ECc/CxkxT2xqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=g0invbkq; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70b1808dee9so1273709b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 22:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720761556; x=1721366356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ht+3f0FtpNtS8JqL2/xQ8Ijm+o7mHtqwCkWXqPcnDZA=;
        b=g0invbkqhBhQdepPCNaYu+h9XtRnS35Pfu+mCn+PCIqkn7JZSuL9Ss8jFryqfKZ5fr
         srbKKlvbVZmK8QUIwCj+PpRle1568QaTCFDP0LIvz6+M7E411itB2BB+B1xc7NpCpDA+
         LfBdjOKG75h+N8ZSp28eK6AhZpRc5LSxF1dWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720761556; x=1721366356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ht+3f0FtpNtS8JqL2/xQ8Ijm+o7mHtqwCkWXqPcnDZA=;
        b=Rs+pBfe6IE+lhvKUbmgyPAoRMCIHPxViPPvG8AQeyNAebDuEy7IqNmagDJAxKFEiUe
         2Th8AvK4fSUMl8EeQib0+WawOoBNhTcLMYryKJ382ZeP0KTsiIn64poUEojI6M6Va3yB
         s3ReVvNXSve7cJ03Ur38PPm7ZWiEN6mmwml+RILNsNQUzpDrxYdcfWPu299B2kUICoqt
         0bkm/2KX420pPAY5Q9QNCwCYdAdNM5qKNCzhtrrTigRLcenYNMr1auE+xt7E9t7FUUfu
         /q0H2Z4C+c4LdDmWCWOVlZY2fkHIzhjUIIW+QCU3pI5zDAgeKP1y+VcNil6SkxnYRWba
         YGDQ==
X-Gm-Message-State: AOJu0YzvXmLvf7Sq+gqOtdqB1SlcSrfAqS9H3T0RvrChj2aTORHcJi18
	CRXr1zAdSUCB0xQMDHQoM/5obW2c8ljtwhYJD+TOofMLcwfGatvaWiYaWeNxUQ==
X-Google-Smtp-Source: AGHT+IFPxq3Ug+6gPgibAegfNfHZ6jTYh+2Ha++Ld63dB5qwMyEoq8pNQLcTBS0RFKlpop4EU3wxPQ==
X-Received: by 2002:a05:6a00:10d5:b0:705:9992:d8ad with SMTP id d2e1a72fcca58-70b4358d3c9mr11355015b3a.19.1720761549718;
        Thu, 11 Jul 2024 22:19:09 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:15f3:5252:ec56:52ae])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b43967851sm6553436b3a.109.2024.07.11.22.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 22:19:09 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v6 05/23] zram: add lzo and lzorle compression backends support
Date: Fri, 12 Jul 2024 14:18:16 +0900
Message-ID: <20240712051850.484318-6-senozhatsky@chromium.org>
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

Add s/w lzo/lzorle compression support.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/Kconfig          | 23 +++++++++++++++
 drivers/block/zram/Makefile         |  3 ++
 drivers/block/zram/backend_lzo.c    | 43 ++++++++++++++++++++++++++++
 drivers/block/zram/backend_lzo.h    | 10 +++++++
 drivers/block/zram/backend_lzorle.c | 44 +++++++++++++++++++++++++++++
 drivers/block/zram/backend_lzorle.h | 10 +++++++
 drivers/block/zram/zcomp.c          |  7 +++++
 7 files changed, 140 insertions(+)
 create mode 100644 drivers/block/zram/backend_lzo.c
 create mode 100644 drivers/block/zram/backend_lzo.h
 create mode 100644 drivers/block/zram/backend_lzorle.c
 create mode 100644 drivers/block/zram/backend_lzorle.h

diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
index ace5698db5f6..ce70b8ef3405 100644
--- a/drivers/block/zram/Kconfig
+++ b/drivers/block/zram/Kconfig
@@ -15,8 +15,31 @@ config ZRAM
 
 	  See Documentation/admin-guide/blockdev/zram.rst for more information.
 
+config ZRAM_BACKEND_LZO
+	bool "lzo and lzo-rle compression support"
+	depends on ZRAM
+	select LZO_COMPRESS
+	select LZO_DECOMPRESS
+
+choice
+	prompt "Default zram compressor"
+	default ZRAM_DEF_COMP_LZORLE
+	depends on ZRAM
+
+config ZRAM_DEF_COMP_LZORLE
+	bool "lzo-rle"
+	depends on ZRAM_BACKEND_LZO
+
+config ZRAM_DEF_COMP_LZO
+	bool "lzo"
+	depends on ZRAM_BACKEND_LZO
+
+endchoice
+
 config ZRAM_DEF_COMP
 	string
+	default "lzo-rle" if ZRAM_DEF_COMP_LZORLE
+	default "lzo" if ZRAM_DEF_COMP_LZO
 	default "unset-value"
 
 config ZRAM_WRITEBACK
diff --git a/drivers/block/zram/Makefile b/drivers/block/zram/Makefile
index de9e457907b1..2a3db3368af9 100644
--- a/drivers/block/zram/Makefile
+++ b/drivers/block/zram/Makefile
@@ -1,4 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
+
 zram-y	:=	zcomp.o zram_drv.o
 
+zram-$(CONFIG_ZRAM_BACKEND_LZO)	+= backend_lzorle.o backend_lzo.o
+
 obj-$(CONFIG_ZRAM)	+=	zram.o
diff --git a/drivers/block/zram/backend_lzo.c b/drivers/block/zram/backend_lzo.c
new file mode 100644
index 000000000000..4c9e611f6c03
--- /dev/null
+++ b/drivers/block/zram/backend_lzo.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/lzo.h>
+
+#include "backend_lzo.h"
+
+static void *lzo_create(void)
+{
+	return kzalloc(LZO1X_MEM_COMPRESS, GFP_KERNEL);
+}
+
+static void lzo_destroy(void *ctx)
+{
+	kfree(ctx);
+}
+
+static int lzo_compress(void *ctx, const unsigned char *src, size_t src_len,
+			unsigned char *dst, size_t *dst_len)
+{
+	int ret;
+
+	ret = lzo1x_1_compress(src, src_len, dst, dst_len, ctx);
+	return ret == LZO_E_OK ? 0 : ret;
+}
+
+static int lzo_decompress(void *ctx, const unsigned char *src, size_t src_len,
+			  unsigned char *dst, size_t dst_len)
+{
+	int ret;
+
+	ret = lzo1x_decompress_safe(src, src_len, dst, &dst_len);
+	return ret == LZO_E_OK ? 0 : ret;
+}
+
+const struct zcomp_ops backend_lzo = {
+	.compress	= lzo_compress,
+	.decompress	= lzo_decompress,
+	.create_ctx	= lzo_create,
+	.destroy_ctx	= lzo_destroy,
+	.name		= "lzo",
+};
diff --git a/drivers/block/zram/backend_lzo.h b/drivers/block/zram/backend_lzo.h
new file mode 100644
index 000000000000..93d54749e63c
--- /dev/null
+++ b/drivers/block/zram/backend_lzo.h
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#ifndef __BACKEND_LZO_H__
+#define __BACKEND_LZO_H__
+
+#include "zcomp.h"
+
+extern const struct zcomp_ops backend_lzo;
+
+#endif /* __BACKEND_LZO_H__ */
diff --git a/drivers/block/zram/backend_lzorle.c b/drivers/block/zram/backend_lzorle.c
new file mode 100644
index 000000000000..19a9ce132046
--- /dev/null
+++ b/drivers/block/zram/backend_lzorle.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/lzo.h>
+
+#include "backend_lzorle.h"
+
+static void *lzorle_create(void)
+{
+	return kzalloc(LZO1X_MEM_COMPRESS, GFP_KERNEL);
+}
+
+static void lzorle_destroy(void *ctx)
+{
+	kfree(ctx);
+}
+
+static int lzorle_compress(void *ctx, const unsigned char *src, size_t src_len,
+			   unsigned char *dst, size_t *dst_len)
+{
+	int ret;
+
+	ret = lzorle1x_1_compress(src, src_len, dst, dst_len, ctx);
+	return ret == LZO_E_OK ? 0 : ret;
+}
+
+static int lzorle_decompress(void *ctx, const unsigned char *src,
+			     size_t src_len, unsigned char *dst,
+			     size_t dst_len)
+{
+	int ret;
+
+	ret = lzo1x_decompress_safe(src, src_len, dst, &dst_len);
+	return ret == LZO_E_OK ? 0 : ret;
+}
+
+const struct zcomp_ops backend_lzorle = {
+	.compress	= lzorle_compress,
+	.decompress	= lzorle_decompress,
+	.create_ctx	= lzorle_create,
+	.destroy_ctx	= lzorle_destroy,
+	.name		= "lzo-rle",
+};
diff --git a/drivers/block/zram/backend_lzorle.h b/drivers/block/zram/backend_lzorle.h
new file mode 100644
index 000000000000..6ecb163b09f1
--- /dev/null
+++ b/drivers/block/zram/backend_lzorle.h
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#ifndef __BACKEND_LZORLE_H__
+#define __BACKEND_LZORLE_H__
+
+#include "zcomp.h"
+
+extern const struct zcomp_ops backend_lzorle;
+
+#endif /* __BACKEND_LZORLE_H__ */
diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index 2f75f18fc1ca..e358319c59dc 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -12,7 +12,14 @@
 
 #include "zcomp.h"
 
+#include "backend_lzo.h"
+#include "backend_lzorle.h"
+
 static const struct zcomp_ops *backends[] = {
+#if IS_ENABLED(CONFIG_ZRAM_BACKEND_LZO)
+	&backend_lzorle,
+	&backend_lzo,
+#endif
 	NULL
 };
 
-- 
2.45.2.993.g49e7a77208-goog


