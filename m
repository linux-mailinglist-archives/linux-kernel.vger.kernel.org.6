Return-Path: <linux-kernel+bounces-286420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B375951ABD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79047B23C73
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6751E1B0111;
	Wed, 14 Aug 2024 12:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="vGPQYS+X"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC261AC427
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 12:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723638105; cv=none; b=macCbgb5mQ7Uk1N5+yFDsyVzJKFgwLykZt3ZFuGwQF4ollANBOHY/WHMVEsNQ5ilB9lmySylT4mKaywsC/QA6vfiPSF692ucLf+9DxIecRBc6QK2kMhEZMCvK38p8Dtlqhntmh5Hi9/M3XybmshxWCLfV0RJJmW73dsycnQGh3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723638105; c=relaxed/simple;
	bh=0bPzn3hETIOTnJ2/MPKPYCyuzyee1ybkGScDFxhDOtU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DJc7G8m/TCLFnwzor7nHtR/sFBAaQH2fAgpmuIDpMslxFPNbuB2Wggg/CujdMhC1Tp4Aa8Gyp7MnQTd9VqZhDILOV42OR73K3KMaXxj5zqgBrZeIi1ZPIJKsrPuZXHav0ctBgiRG0yiSNhBCzzVe3RNuptq6H6/Fyp7BlAkVo58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=vGPQYS+X; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52fc4388a64so9177289e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 05:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1723638100; x=1724242900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rhz8oK3vUQCTeEMfFLgxVPGzVrAvnjGUu+F3hij75O0=;
        b=vGPQYS+XhVPfc1b1zJtBFVp6FdN7GWpUnfHR5ApgOQao0soAmrJxd85kTKnKZff64S
         XrECFUS7plrRXhP4+H9+AMKO0HAwqfJD8OrcQUoUgVSwKTTEfY1oJhZiJCj+mwMcyaDV
         UK8XHllEx9svAIQWse+wtZxSTWT2BEOqJjvGX9XAIZTligq/I0fHDu+fu/og5xrJiXal
         WZVM6sv7qtCXnqQt2s0VXIc0BwHE+UMjOIc9zunTUJdvp7X7KbwhnFfRyYEjQA7amC83
         niCqP/Ybf1An1xeScajzHQ705LM5oT0Vzkx5mQRxBAxuTTCOZJYaQGTHrsirk1yhG51T
         vZbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723638100; x=1724242900;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rhz8oK3vUQCTeEMfFLgxVPGzVrAvnjGUu+F3hij75O0=;
        b=qhMzUSdUe1Tge4A27GO+it3MC5q/nddnLH3+bKL3NGV2A2OfUu8FcpAjgMaXjJPchR
         Y0yUDqGeuyuPRffaX4CjdTKUaMUntHYPmwfnbLJhhf9MWxhh9aS5AtnTyeOhiUA0yzd3
         zue3KgRceml5SMIoyeCnZyqt4+GSu01oKdkgz/TgqxBB5WNU/b8SkWJ7/d9meYBGviin
         9U0YIhh0Z95vUGqb9mzwZaJCrTyAfo5F85knvyJuwhKtwTxK2ajTTIAAh+l34jjrZDbG
         gxIUZdNL+VyRiILbk533MXLXnGETT8Hruwr6jdntveBtSvP5jlbJQqkpycYGQJ4ahx6v
         lIfQ==
X-Gm-Message-State: AOJu0Yyn553pSF0sT8PYks84WPqW0e0kpucfPUGpqJ65Wof73AZVPCsg
	RpN2bpCljwwBSooD2TUSxM3i1zOcr1izqCErowiVVa+cbCpAIucOQWXWRKC/qrI=
X-Google-Smtp-Source: AGHT+IG56lVsrCfZXaacs5hV2uXKUmCj6kSfOVwXxejKzARO9OHE+LgDHjuddhx+i5ImLh1TOdiTYA==
X-Received: by 2002:a05:6512:b86:b0:52e:9670:e40b with SMTP id 2adb3069b0e04-532edbae0e4mr1668869e87.39.1723638099431;
        Wed, 14 Aug 2024 05:21:39 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:9e78:fb96:21f1:335c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4cfeedc8sm12832509f8f.55.2024.08.14.05.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 05:21:39 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] mtd: rawnand: davinci: make platform_data private
Date: Wed, 14 Aug 2024 14:21:18 +0200
Message-ID: <20240814122120.13975-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

There are no longer any users of the platform data for davinci rawnand
in board files. We can remove the public pdata headers and move the
structures that are still used into the driver compilation unit while
removing the rest.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/mtd/nand/raw/davinci_nand.c           | 70 +++++++++++++--
 .../linux/platform_data/mtd-davinci-aemif.h   | 36 --------
 include/linux/platform_data/mtd-davinci.h     | 88 -------------------
 3 files changed, 65 insertions(+), 129 deletions(-)
 delete mode 100644 include/linux/platform_data/mtd-davinci-aemif.h
 delete mode 100644 include/linux/platform_data/mtd-davinci.h

diff --git a/drivers/mtd/nand/raw/davinci_nand.c b/drivers/mtd/nand/raw/davinci_nand.c
index 051deea768db..392678143a36 100644
--- a/drivers/mtd/nand/raw/davinci_nand.c
+++ b/drivers/mtd/nand/raw/davinci_nand.c
@@ -20,8 +20,71 @@
 #include <linux/slab.h>
 #include <linux/of.h>
 
-#include <linux/platform_data/mtd-davinci.h>
-#include <linux/platform_data/mtd-davinci-aemif.h>
+#define NRCSR_OFFSET		0x00
+#define NANDFCR_OFFSET		0x60
+#define NANDFSR_OFFSET		0x64
+#define NANDF1ECC_OFFSET	0x70
+
+/* 4-bit ECC syndrome registers */
+#define NAND_4BIT_ECC_LOAD_OFFSET	0xbc
+#define NAND_4BIT_ECC1_OFFSET		0xc0
+#define NAND_4BIT_ECC2_OFFSET		0xc4
+#define NAND_4BIT_ECC3_OFFSET		0xc8
+#define NAND_4BIT_ECC4_OFFSET		0xcc
+#define NAND_ERR_ADD1_OFFSET		0xd0
+#define NAND_ERR_ADD2_OFFSET		0xd4
+#define NAND_ERR_ERRVAL1_OFFSET		0xd8
+#define NAND_ERR_ERRVAL2_OFFSET		0xdc
+
+/* NOTE:  boards don't need to use these address bits
+ * for ALE/CLE unless they support booting from NAND.
+ * They're used unless platform data overrides them.
+ */
+#define	MASK_ALE		0x08
+#define	MASK_CLE		0x10
+
+struct davinci_nand_pdata {
+	uint32_t		mask_ale;
+	uint32_t		mask_cle;
+
+	/*
+	 * 0-indexed chip-select number of the asynchronous
+	 * interface to which the NAND device has been connected.
+	 *
+	 * So, if you have NAND connected to CS3 of DA850, you
+	 * will pass '1' here. Since the asynchronous interface
+	 * on DA850 starts from CS2.
+	 */
+	uint32_t		core_chipsel;
+
+	/* for packages using two chipselects */
+	uint32_t		mask_chipsel;
+
+	/* board's default static partition info */
+	struct mtd_partition	*parts;
+	unsigned int		nr_parts;
+
+	/* none  == NAND_ECC_ENGINE_TYPE_NONE (strongly *not* advised!!)
+	 * soft  == NAND_ECC_ENGINE_TYPE_SOFT
+	 * else  == NAND_ECC_ENGINE_TYPE_ON_HOST, according to ecc_bits
+	 *
+	 * All DaVinci-family chips support 1-bit hardware ECC.
+	 * Newer ones also support 4-bit ECC, but are awkward
+	 * using it with large page chips.
+	 */
+	enum nand_ecc_engine_type engine_type;
+	enum nand_ecc_placement ecc_placement;
+	u8			ecc_bits;
+
+	/* e.g. NAND_BUSWIDTH_16 */
+	unsigned int		options;
+	/* e.g. NAND_BBT_USE_FLASH */
+	unsigned int		bbt_options;
+
+	/* Main and mirror bbt descriptor overrides */
+	struct nand_bbt_descr	*bbt_td;
+	struct nand_bbt_descr	*bbt_md;
+};
 
 /*
  * This is a device driver for the NAND flash controller found on the
@@ -54,8 +117,6 @@ struct davinci_nand_info {
 	uint32_t		mask_cle;
 
 	uint32_t		core_chipsel;
-
-	struct davinci_aemif_timing	*timing;
 };
 
 static DEFINE_SPINLOCK(davinci_nand_lock);
@@ -775,7 +836,6 @@ static int nand_davinci_probe(struct platform_device *pdev)
 	info->chip.options	= pdata->options;
 	info->chip.bbt_td	= pdata->bbt_td;
 	info->chip.bbt_md	= pdata->bbt_md;
-	info->timing		= pdata->timing;
 
 	info->current_cs	= info->vaddr;
 	info->core_chipsel	= pdata->core_chipsel;
diff --git a/include/linux/platform_data/mtd-davinci-aemif.h b/include/linux/platform_data/mtd-davinci-aemif.h
deleted file mode 100644
index a49826214a39..000000000000
--- a/include/linux/platform_data/mtd-davinci-aemif.h
+++ /dev/null
@@ -1,36 +0,0 @@
-/*
- * TI DaVinci AEMIF support
- *
- * Copyright 2010 (C) Texas Instruments, Inc. https://www.ti.com/
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2. This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- */
-#ifndef _MACH_DAVINCI_AEMIF_H
-#define _MACH_DAVINCI_AEMIF_H
-
-#include <linux/platform_device.h>
-
-#define NRCSR_OFFSET		0x00
-#define AWCCR_OFFSET		0x04
-#define A1CR_OFFSET		0x10
-
-#define ACR_ASIZE_MASK		0x3
-#define ACR_EW_MASK		BIT(30)
-#define ACR_SS_MASK		BIT(31)
-
-/* All timings in nanoseconds */
-struct davinci_aemif_timing {
-	u8	wsetup;
-	u8	wstrobe;
-	u8	whold;
-
-	u8	rsetup;
-	u8	rstrobe;
-	u8	rhold;
-
-	u8	ta;
-};
-
-#endif
diff --git a/include/linux/platform_data/mtd-davinci.h b/include/linux/platform_data/mtd-davinci.h
deleted file mode 100644
index dd474dd44848..000000000000
--- a/include/linux/platform_data/mtd-davinci.h
+++ /dev/null
@@ -1,88 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * mach-davinci/nand.h
- *
- * Copyright © 2006 Texas Instruments.
- *
- * Ported to 2.6.23 Copyright © 2008 by
- *   Sander Huijsen <Shuijsen@optelecom-nkf.com>
- *   Troy Kisky <troy.kisky@boundarydevices.com>
- *   Dirk Behme <Dirk.Behme@gmail.com>
- *
- * --------------------------------------------------------------------------
- */
-
-#ifndef __ARCH_ARM_DAVINCI_NAND_H
-#define __ARCH_ARM_DAVINCI_NAND_H
-
-#include <linux/mtd/rawnand.h>
-
-#define NANDFCR_OFFSET		0x60
-#define NANDFSR_OFFSET		0x64
-#define NANDF1ECC_OFFSET	0x70
-
-/* 4-bit ECC syndrome registers */
-#define NAND_4BIT_ECC_LOAD_OFFSET	0xbc
-#define NAND_4BIT_ECC1_OFFSET		0xc0
-#define NAND_4BIT_ECC2_OFFSET		0xc4
-#define NAND_4BIT_ECC3_OFFSET		0xc8
-#define NAND_4BIT_ECC4_OFFSET		0xcc
-#define NAND_ERR_ADD1_OFFSET		0xd0
-#define NAND_ERR_ADD2_OFFSET		0xd4
-#define NAND_ERR_ERRVAL1_OFFSET		0xd8
-#define NAND_ERR_ERRVAL2_OFFSET		0xdc
-
-/* NOTE:  boards don't need to use these address bits
- * for ALE/CLE unless they support booting from NAND.
- * They're used unless platform data overrides them.
- */
-#define	MASK_ALE		0x08
-#define	MASK_CLE		0x10
-
-struct davinci_nand_pdata {		/* platform_data */
-	uint32_t		mask_ale;
-	uint32_t		mask_cle;
-
-	/*
-	 * 0-indexed chip-select number of the asynchronous
-	 * interface to which the NAND device has been connected.
-	 *
-	 * So, if you have NAND connected to CS3 of DA850, you
-	 * will pass '1' here. Since the asynchronous interface
-	 * on DA850 starts from CS2.
-	 */
-	uint32_t		core_chipsel;
-
-	/* for packages using two chipselects */
-	uint32_t		mask_chipsel;
-
-	/* board's default static partition info */
-	struct mtd_partition	*parts;
-	unsigned		nr_parts;
-
-	/* none  == NAND_ECC_ENGINE_TYPE_NONE (strongly *not* advised!!)
-	 * soft  == NAND_ECC_ENGINE_TYPE_SOFT
-	 * else  == NAND_ECC_ENGINE_TYPE_ON_HOST, according to ecc_bits
-	 *
-	 * All DaVinci-family chips support 1-bit hardware ECC.
-	 * Newer ones also support 4-bit ECC, but are awkward
-	 * using it with large page chips.
-	 */
-	enum nand_ecc_engine_type engine_type;
-	enum nand_ecc_placement ecc_placement;
-	u8			ecc_bits;
-
-	/* e.g. NAND_BUSWIDTH_16 */
-	unsigned		options;
-	/* e.g. NAND_BBT_USE_FLASH */
-	unsigned		bbt_options;
-
-	/* Main and mirror bbt descriptor overrides */
-	struct nand_bbt_descr	*bbt_td;
-	struct nand_bbt_descr	*bbt_md;
-
-	/* Access timings */
-	struct davinci_aemif_timing	*timing;
-};
-
-#endif	/* __ARCH_ARM_DAVINCI_NAND_H */
-- 
2.43.0


