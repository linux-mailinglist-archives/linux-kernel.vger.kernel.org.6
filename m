Return-Path: <linux-kernel+bounces-311156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68ACE968585
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 13:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28058288F49
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9A418452D;
	Mon,  2 Sep 2024 10:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YGYbjkCg"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991C61D54FA
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 10:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725274648; cv=none; b=pZQaMYjfwUHcLyGnFgUHenjwX0tPO+G9jd7W8O1J8gVZ+V3STHdQUDDfaJBFvQyoMAUb7ClDq7WUpvRhFeGjhhkA8bn3AcAzb/jTkYNtW3oONX1sSPzjr1ByaOxl6cR7Xn3jg86RWD2zXWHL3YvRWrra6Vs+NXpQpRzF9nBwPA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725274648; c=relaxed/simple;
	bh=DcIDIGTvrV2sGaSp3l4cLIo9oC4TVIH+5tu9pj4z4eU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dVLIyW/2c8clu1VCT12YD0BmYZSUf4khzbFQHbHTYRzrM2bAF9m74fIKC3glaO3c3CnGOH8thdF/u9ZgkiDcMXO6Xn1dWW137TqIxiieZOfmdjI81SINQTUYI/hTCsXB7lTausCM4iHHQWGe4m2Q4DBn53ZddmzIHBqAQ5gmpv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YGYbjkCg; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5dc93fa5639so2487598eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 03:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725274645; x=1725879445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IsasNKWMCfc0i969DWSee/nvVtCDDH3930dmqSc3da0=;
        b=YGYbjkCggj7coEwJWNl2JZaQQBmhMLmsP2eB7AJIytur/y4wHQEXUYPgxRiENJ8V72
         9zaJEX7xshO0tsJF7AbOBpJSoAIsGy1b/hxeSnZJjVhGBcsb+xw/ebaFXLvJYMlP5EJC
         pJuLOUxclDZJ/L6Rbp+2bEa0I09Poa6ztOP+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725274645; x=1725879445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IsasNKWMCfc0i969DWSee/nvVtCDDH3930dmqSc3da0=;
        b=FiwI/BMqH97Ldrg3x6xv0Fjyhx96YHdxncLsL+mXAkB3i0k+owWJGmlgLQdBCAsx8X
         EF79VamPTF9COg792yIyQfu+1keuTymHxxO3JEfVji9r9gZbdIpkm6eQoJZfeXSXYZJf
         Ufp23XomZyzLz9sm/2lKlTxRbpApgQKdoH8NRWFaXDnqCBBHlvjFpIMEzf2YiLjpKY7I
         9fxxf4LpbH+0l4EGoelzyMu1nCgcIID9DBvYE0dAtNUpSbFr1+afM9AjJy5XEQf3R9Mh
         1OMakTrTW8NlTqjw4Bkqf57MK2UHUovHoHXQ2/CDP8Ja+ep/fScwSrSdGxhu26TfqrJW
         EP0A==
X-Forwarded-Encrypted: i=1; AJvYcCVdoUo9k0AhV3AFXezMT0nWpOXQwjpXEZRkOGrorIJikAWKCFmWHztO9pH7Go7UhyvpQ6EOwKnnkthF9ts=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJcbPxqdfg+P4YlfI6YFLQm8ClbNxlXK1h5PcXO5fstMMEZ0l/
	zdjcJkPihNATRhgdzsXZ83TeP6EGk3fC57Xm1tTREmSA7uMti0SSTBSKMmn7rQ==
X-Google-Smtp-Source: AGHT+IGUGfPHU8GUEsPz7sLM0j5yQqFJ8DslmyX1UZJK4n2N1BoC4Assh8H+Giampv/RNDcavNMiYQ==
X-Received: by 2002:a05:6358:7e90:b0:1b5:c544:23a8 with SMTP id e5c5f4694b2df-1b7edb4ae07mr1035428055d.11.1725274645511;
        Mon, 02 Sep 2024 03:57:25 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:43a1:71e3:7464:e91b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55a51e9sm6633769b3a.78.2024.09.02.03.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 03:57:25 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv7 11/24] zram: add 842 compression backend support
Date: Mon,  2 Sep 2024 19:55:59 +0900
Message-ID: <20240902105656.1383858-12-senozhatsky@chromium.org>
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
index 000000000000..005f3fcb9024
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
+const struct zcomp_ops backend_842 = {
+	.compress	= compress_842,
+	.decompress	= decompress_842,
+	.create_ctx	= create_842,
+	.destroy_ctx	= destroy_842,
+	.name		= "842",
+};
diff --git a/drivers/block/zram/backend_842.h b/drivers/block/zram/backend_842.h
new file mode 100644
index 000000000000..4dc85c188799
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
+extern const struct zcomp_ops backend_842;
+
+#endif /* __BACKEND_842_H__ */
diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index d1396fe82b1d..94e1c9503267 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -18,6 +18,7 @@
 #include "backend_lz4hc.h"
 #include "backend_zstd.h"
 #include "backend_deflate.h"
+#include "backend_842.h"
 
 static const struct zcomp_ops *backends[] = {
 #if IS_ENABLED(CONFIG_ZRAM_BACKEND_LZO)
@@ -35,6 +36,9 @@ static const struct zcomp_ops *backends[] = {
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
2.46.0.469.g59c65b2a67-goog


