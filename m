Return-Path: <linux-kernel+bounces-169446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B32418BC8C7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 09:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C36228240C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 07:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958541422C1;
	Mon,  6 May 2024 07:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NDAumOY3"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F65C1420B3
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 07:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714982334; cv=none; b=A3b0s8X9yTFdG/n988YcvWg6zjzxvlwUTaTehxJQf6+cUmc56yzwyTu/IeHvF9dFg6fTu27kK3XODammWnxFAS9fbFfALzpWezx4O9r/j27naxCkz/uPWtBGTtmMwGCOBYWIhc6B1kej17QEazVcdGOLuuej02eyrAFP/96d3t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714982334; c=relaxed/simple;
	bh=DHL8kqd+RNQDM+Stwrc0IUTkOPk9/Cbf5eFqQlFrF4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HeY4kVoP3jL9Gs0bzgSDaUr4+5cMbt/PDhj03d48K6AXbXk6a7Gbc3s2eH9NXEWKwTABiskmS8fpmvTYyUx9x0gPOGsJ3XYbZvDhckP7w/PJWo2DZQAAVm93YhF1DcdBbg30jfkqKnSyATWJSKbJYXXvFRzC3ZhnARtsRbIlUh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NDAumOY3; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e50a04c317so5667945ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 00:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714982332; x=1715587132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sjjXoB1vjVFge1iRvQDKKfu041t9IBLi05g+C6qi2oA=;
        b=NDAumOY3qZxJybc8pZ5s2t/ZA+b1RU5Ed4oCuTCxaiwEerlRJ/c/QHxxy5EllLQb/g
         +dCK9aGgYaKwj948XMxYWs75RVHL5XpEmLYDHYbZIbXIr7SgmUUig8eD+q+EfUqtKv4m
         4uDMYt7AHEAdnotry4HzZrV2HG6exIhKF5SDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714982332; x=1715587132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sjjXoB1vjVFge1iRvQDKKfu041t9IBLi05g+C6qi2oA=;
        b=fWL6GwoY7WzGuLWRDMnyYA/E45uJ3twEWCm9N8XCYQKZ5GmMaTCbPLh1dpQehyPTvt
         UG4VsBqmCcshrHTyI2rPAoCPqlPSLSBPcJobrVLIQmVGuYMs4sDrz1H8Vgs7RJhv1+Vd
         BE1jlYaiuSDa208tp9b45caObNpkWfTPjgd16+z13vmjguVQjZSiWz1/lZ3LDNcefE4Y
         iHY05fE60z7dckya628kQVbdrJQ/hvwACq1NEjNALNT4WUyPorQYFVZ2Xdbn/W8PRvAr
         PSYXXxEbxCEIIFQFCRsA/i3QIpNoY8E5CE2li1QWR1Wn2fqthkpHk0GM4f6pgrZT0alW
         oYyA==
X-Gm-Message-State: AOJu0YyFM+tsXPrWh/xEssYCktEXct8xUrm0i9jXu5FjDwQ9fC+GohsM
	qbxLWMpO3zJGSvOVlGP/BHKN4fiCe2SMDZDlKLGjDuOsSDVsi8sSti/a1/q+Qw==
X-Google-Smtp-Source: AGHT+IFWV+X5WTs3i4V83BUitVus7BW/4D3casQEhHM7fCsP3ic5Ug3u6WiAUmdFhaCHi+CDp3mW3g==
X-Received: by 2002:a17:903:18d:b0:1dd:c288:899f with SMTP id z13-20020a170903018d00b001ddc288899fmr11773369plg.18.1714982331935;
        Mon, 06 May 2024 00:58:51 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:4e24:10c3:4b65:e126])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902f54600b001ec64b128dasm7633772plf.129.2024.05.06.00.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 00:58:51 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2 03/17] zram: add lz4 compression backend support
Date: Mon,  6 May 2024 16:58:16 +0900
Message-ID: <20240506075834.302472-4-senozhatsky@chromium.org>
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
 drivers/block/zram/Kconfig       | 11 ++++++++
 drivers/block/zram/Makefile      |  1 +
 drivers/block/zram/backend_lz4.c | 47 ++++++++++++++++++++++++++++++++
 drivers/block/zram/backend_lz4.h | 10 +++++++
 drivers/block/zram/zcomp.c       |  4 +++
 5 files changed, 73 insertions(+)
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
index 2dcbc9b75d91..1be5d2657960 100644
--- a/drivers/block/zram/Makefile
+++ b/drivers/block/zram/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 obj-$(CONFIG_ZRAM_BACKEND_LZO)	+= backend_lzorle.o backend_lzo.o
+obj-$(CONFIG_ZRAM_BACKEND_LZ4)	+= backend_lz4.o
 
 zram-y	:=	zcomp.o zram_drv.o
 
diff --git a/drivers/block/zram/backend_lz4.c b/drivers/block/zram/backend_lz4.c
new file mode 100644
index 000000000000..697592dbabe2
--- /dev/null
+++ b/drivers/block/zram/backend_lz4.c
@@ -0,0 +1,47 @@
+#include <linux/kernel.h>
+#include <linux/lz4.h>
+#include <linux/vmalloc.h>
+
+#include "backend_lz4.h"
+
+static void *lz4_create(void)
+{
+	return vmalloc(LZ4_MEM_COMPRESS);
+}
+
+static void lz4_destroy(void *ctx)
+{
+	vfree(ctx);
+}
+
+static int lz4_compress(void *ctx, const unsigned char *src,
+			unsigned char *dst, size_t *dst_len)
+{
+	int ret;
+
+	ret = LZ4_compress_default(src, dst, PAGE_SIZE, *dst_len, ctx);
+	if (!ret)
+		return -EINVAL;
+	*dst_len = ret;
+	return 0;
+}
+
+static int lz4_decompress(void *ctx, const unsigned char *src,
+			  size_t src_len, unsigned char *dst)
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
+struct zcomp_backend backend_lz4 = {
+	.compress	= lz4_compress,
+	.decompress	= lz4_decompress,
+	.create_ctx	= lz4_create,
+	.destroy_ctx	= lz4_destroy,
+	.name		= "lz4",
+};
diff --git a/drivers/block/zram/backend_lz4.h b/drivers/block/zram/backend_lz4.h
new file mode 100644
index 000000000000..a5fb5564835c
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
+extern struct zcomp_backend backend_lz4;
+
+#endif /* __BACKEND_LZ4_H__ */
diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index 58fb3ac91f4b..902bdaf7e299 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -17,11 +17,15 @@
 
 #include "backend_lzo.h"
 #include "backend_lzorle.h"
+#include "backend_lz4.h"
 
 static struct zcomp_backend *backends[] = {
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
2.45.0.rc1.225.g2a3ae87e7f-goog


