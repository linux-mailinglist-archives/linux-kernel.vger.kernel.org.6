Return-Path: <linux-kernel+bounces-449306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E33A9F4D04
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 15:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8872516B549
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 14:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F201F6662;
	Tue, 17 Dec 2024 13:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="mHwWExZ3"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79F61F541B;
	Tue, 17 Dec 2024 13:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734443990; cv=none; b=JWJKwZjEZwrQy3DYKAQKDNKOIAiy48kIUSqQZ4ANbVdSmjEaOk17ToJMS3i26cWN/zF5pTogkQznRDCEo3IZxwmNXTEp9dBCdLeeqvgN0yKTJUY5rbw7RrvV/22vbVhghA6cXS00+XOLVI8hGOBuLak/60zrguF4X3ePxYmyS1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734443990; c=relaxed/simple;
	bh=GhcA4cRISVLOeV8t08fsgk7/pc/F5Sm0U2GjuV7xcm8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RETuJUC8pcJk3oL0QDipTAltywvQD11IquwWZyMKWs6CxGQEK41TZH+RmDUXLgB/b76pEmQlmTUkEzMsICyZ5QbcLBnQtlo7hAvh9ukeODNZe0kx8Nkcah581cDtwa+th+C1RlBlDpRKpjntsN//csHncF2/n+sBZVSmu9dpUG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=mHwWExZ3; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BH47Fb1011049;
	Tue, 17 Dec 2024 07:59:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=7Dpy0/lkrDeQMuj1f4YvFSdFyhHez9lpvhEjyhn7Gtc=; b=
	mHwWExZ3iZFhcF3S6li0YGeZkznk2EaZ1H4DkOFCl+ruIU3UqxZRS/wYmCZR8sz7
	s1H//TMnaYQiuyae4TVLG9lYWt7Nvaod2p68Y82mzgQj6+TqLMXX8RbMq0K5hqEs
	pglHcD03iZWLD0kBzwZ+phUeV49DWw6qKgxTznqryss69lH+vwIU6x25qIxG2zOB
	AdsvWR++CBdsv+i78eQWKGOWYffbRBoXRP/Mg2NpsUG/6bY77+Q6athR3Pgx1dIV
	td6XB7WeSLejiuEUNQ+kmofXU+qj5iTocNTze+GTzsYxNGOrFKxuRz6Ktg5KiycC
	gK/6cec68GWQClvbh/gPHA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 43h7akbb0q-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 07:59:24 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.13; Tue, 17 Dec
 2024 13:59:22 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.13 via Frontend Transport; Tue, 17 Dec 2024 13:59:22 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id D9D35822545;
	Tue, 17 Dec 2024 13:59:21 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>, <vkoul@kernel.org>, <oder_chiou@realtek.com>
CC: <jack.yu@realtek.com>, <shumingf@realtek.com>, <lgirdwood@gmail.com>,
        <peter.ujfalusi@linux.intel.com>, <yung-chuan.liao@linux.intel.com>,
        <sanyog.r.kale@intel.com>, <pierre-louis.bossart@linux.dev>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH 3/5] regmap: sdw-mbq: Add support for further MBQ register sizes
Date: Tue, 17 Dec 2024 13:59:19 +0000
Message-ID: <20241217135921.3572496-4-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241217135921.3572496-1-ckeepax@opensource.cirrus.com>
References: <20241217135921.3572496-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: -bPeTxZ8CWKmmWi_lwIJN4eXZAsXGYD-
X-Proofpoint-ORIG-GUID: -bPeTxZ8CWKmmWi_lwIJN4eXZAsXGYD-
X-Proofpoint-Spam-Reason: safe

SoundWire MBQ register maps typically contain a variety of register
sizes, which doesn't map ideally to the regmap abstraction which
expects register maps to have a consistent size. Currently the MBQ
register map only allows 16-bit registers to be defined, however
this leads to complex CODEC driver implementations with an 8-bit
register map and a 16-bit MBQ, every control will then have a custom
get and put handler that allows them to access different register
maps. Further more 32-bit MBQ quantities are not currently supported.

Add support for additional MBQ sizes and to avoid the complexity
of multiple register maps treat the val_size as a maximum size for
the register map. Within the regmap use an ancillary callback to
determine how many bytes to actually read/write to the hardware for
a specific register. In the case that no callback is defined the
behaviour defaults back to the existing behaviour of a fixed size
register map.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/base/regmap/regmap-sdw-mbq.c | 114 ++++++++++++++++++++++-----
 include/linux/regmap.h               |  47 ++++++++++-
 2 files changed, 139 insertions(+), 22 deletions(-)

diff --git a/drivers/base/regmap/regmap-sdw-mbq.c b/drivers/base/regmap/regmap-sdw-mbq.c
index c99eada83780..1bd2773b11a4 100644
--- a/drivers/base/regmap/regmap-sdw-mbq.c
+++ b/drivers/base/regmap/regmap-sdw-mbq.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright(c) 2020 Intel Corporation.
 
+#include <linux/bits.h>
 #include <linux/device.h>
 #include <linux/errno.h>
 #include <linux/module.h>
@@ -9,35 +10,77 @@
 #include <linux/soundwire/sdw_registers.h>
 #include "internal.h"
 
+struct regmap_mbq_context {
+	struct device *dev;
+
+	struct regmap_sdw_mbq_cfg cfg;
+
+	int val_size;
+};
+
+static int regmap_sdw_mbq_size(struct regmap_mbq_context *ctx, unsigned int reg)
+{
+	int size = ctx->val_size;
+
+	if (ctx->cfg.mbq_size) {
+		size = ctx->cfg.mbq_size(ctx->dev, reg);
+		if (!size || size > ctx->val_size)
+			return -EINVAL;
+	}
+
+	return size;
+}
+
 static int regmap_sdw_mbq_write(void *context, unsigned int reg, unsigned int val)
 {
-	struct device *dev = context;
+	struct regmap_mbq_context *ctx = context;
+	struct device *dev = ctx->dev;
 	struct sdw_slave *slave = dev_to_sdw_dev(dev);
+	int mbq_size = regmap_sdw_mbq_size(ctx, reg);
+	int shift = mbq_size * BITS_PER_BYTE;
 	int ret;
 
-	ret = sdw_write_no_pm(slave, SDW_SDCA_MBQ_CTL(reg), (val >> 8) & 0xff);
-	if (ret < 0)
-		return ret;
+	if (mbq_size < 0)
+		return mbq_size;
+
+	while (--mbq_size > 0) {
+		shift -= BITS_PER_BYTE;
+
+		ret = sdw_write_no_pm(slave, SDW_SDCA_MBQ_CTL(reg),
+				      (val >> shift) & 0xff);
+		if (ret < 0)
+			return ret;
+	}
 
 	return sdw_write_no_pm(slave, reg, val & 0xff);
 }
 
 static int regmap_sdw_mbq_read(void *context, unsigned int reg, unsigned int *val)
 {
-	struct device *dev = context;
+	struct regmap_mbq_context *ctx = context;
+	struct device *dev = ctx->dev;
 	struct sdw_slave *slave = dev_to_sdw_dev(dev);
-	int read0;
-	int read1;
+	int mbq_size = regmap_sdw_mbq_size(ctx, reg);
+	int shift = BITS_PER_BYTE;
+	int read;
 
-	read0 = sdw_read_no_pm(slave, reg);
-	if (read0 < 0)
-		return read0;
+	if (mbq_size < 0)
+		return mbq_size;
 
-	read1 = sdw_read_no_pm(slave, SDW_SDCA_MBQ_CTL(reg));
-	if (read1 < 0)
-		return read1;
+	read = sdw_read_no_pm(slave, reg);
+	if (read < 0)
+		return read;
 
-	*val = (read1 << 8) | read0;
+	*val = read;
+
+	while (--mbq_size > 0) {
+		read = sdw_read_no_pm(slave, SDW_SDCA_MBQ_CTL(reg));
+		if (read < 0)
+			return read;
+
+		*val |= read << shift;
+		shift += BITS_PER_BYTE;
+	}
 
 	return 0;
 }
@@ -51,8 +94,7 @@ static const struct regmap_bus regmap_sdw_mbq = {
 
 static int regmap_sdw_mbq_config_check(const struct regmap_config *config)
 {
-	/* MBQ-based controls are only 16-bits for now */
-	if (config->val_bits != 16)
+	if (config->val_bits > (sizeof(unsigned int) * BITS_PER_BYTE))
 		return -ENOTSUPP;
 
 	/* Registers are 32 bits wide */
@@ -65,35 +107,67 @@ static int regmap_sdw_mbq_config_check(const struct regmap_config *config)
 	return 0;
 }
 
+static struct regmap_mbq_context *
+regmap_sdw_mbq_gen_context(struct device *dev,
+			   const struct regmap_config *config,
+			   const struct regmap_sdw_mbq_cfg *mbq_config)
+{
+	struct regmap_mbq_context *ctx;
+
+	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return ERR_PTR(-ENOMEM);
+
+	ctx->dev = dev;
+	ctx->val_size = config->val_bits / BITS_PER_BYTE;
+
+	if (mbq_config)
+		ctx->cfg = *mbq_config;
+
+	return ctx;
+}
+
 struct regmap *__regmap_init_sdw_mbq(struct sdw_slave *sdw,
 				     const struct regmap_config *config,
+				     const struct regmap_sdw_mbq_cfg *mbq_config,
 				     struct lock_class_key *lock_key,
 				     const char *lock_name)
 {
+	struct regmap_mbq_context *ctx;
 	int ret;
 
 	ret = regmap_sdw_mbq_config_check(config);
 	if (ret)
 		return ERR_PTR(ret);
 
-	return __regmap_init(&sdw->dev, &regmap_sdw_mbq,
-			&sdw->dev, config, lock_key, lock_name);
+	ctx = regmap_sdw_mbq_gen_context(&sdw->dev, config, mbq_config);
+	if (IS_ERR(ctx))
+		return ERR_CAST(ctx);
+
+	return __regmap_init(&sdw->dev, &regmap_sdw_mbq, ctx,
+			     config, lock_key, lock_name);
 }
 EXPORT_SYMBOL_GPL(__regmap_init_sdw_mbq);
 
 struct regmap *__devm_regmap_init_sdw_mbq(struct sdw_slave *sdw,
 					  const struct regmap_config *config,
+					  const struct regmap_sdw_mbq_cfg *mbq_config,
 					  struct lock_class_key *lock_key,
 					  const char *lock_name)
 {
+	struct regmap_mbq_context *ctx;
 	int ret;
 
 	ret = regmap_sdw_mbq_config_check(config);
 	if (ret)
 		return ERR_PTR(ret);
 
-	return __devm_regmap_init(&sdw->dev, &regmap_sdw_mbq,
-			&sdw->dev, config, lock_key, lock_name);
+	ctx = regmap_sdw_mbq_gen_context(&sdw->dev, config, mbq_config);
+	if (IS_ERR(ctx))
+		return ERR_CAST(ctx);
+
+	return __devm_regmap_init(&sdw->dev, &regmap_sdw_mbq, ctx,
+				  config, lock_key, lock_name);
 }
 EXPORT_SYMBOL_GPL(__devm_regmap_init_sdw_mbq);
 
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index fd41baccbf3e..dd96a22f5657 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -506,6 +506,17 @@ struct regmap_range_cfg {
 	unsigned int window_len;
 };
 
+/**
+ * struct regmap_sdw_mbq_cfg - Configuration for Multi-Byte Quantities
+ *
+ * @mbq_size: Callback returning the actual size of the given register.
+ *
+ * Provides additional configuration required for SoundWire MBQ register maps.
+ */
+struct regmap_sdw_mbq_cfg {
+	int (*mbq_size)(struct device *dev, unsigned int reg);
+};
+
 struct regmap_async;
 
 typedef int (*regmap_hw_write)(void *context, const void *data,
@@ -652,6 +663,7 @@ struct regmap *__regmap_init_sdw(struct sdw_slave *sdw,
 				 const char *lock_name);
 struct regmap *__regmap_init_sdw_mbq(struct sdw_slave *sdw,
 				     const struct regmap_config *config,
+				     const struct regmap_sdw_mbq_cfg *mbq_config,
 				     struct lock_class_key *lock_key,
 				     const char *lock_name);
 struct regmap *__regmap_init_spi_avmm(struct spi_device *spi,
@@ -713,6 +725,7 @@ struct regmap *__devm_regmap_init_sdw(struct sdw_slave *sdw,
 				 const char *lock_name);
 struct regmap *__devm_regmap_init_sdw_mbq(struct sdw_slave *sdw,
 					  const struct regmap_config *config,
+					  const struct regmap_sdw_mbq_cfg *mbq_config,
 					  struct lock_class_key *lock_key,
 					  const char *lock_name);
 struct regmap *__devm_regmap_init_slimbus(struct slim_device *slimbus,
@@ -942,7 +955,22 @@ bool regmap_ac97_default_volatile(struct device *dev, unsigned int reg);
  */
 #define regmap_init_sdw_mbq(sdw, config)					\
 	__regmap_lockdep_wrapper(__regmap_init_sdw_mbq, #config,		\
-				sdw, config)
+				sdw, config, NULL)
+
+/**
+ * regmap_init_sdw_mbq_cfg() - Initialise MBQ SDW register map with config
+ *
+ * @sdw: Device that will be interacted with
+ * @config: Configuration for register map
+ * @mbq_config: Properties for the MBQ registers
+ *
+ * The return value will be an ERR_PTR() on error or a valid pointer
+ * to a struct regmap. The regmap will be automatically freed by the
+ * device management code.
+ */
+#define regmap_init_sdw_mbq_cfg(sdw, config, mbq_config)		\
+	__regmap_lockdep_wrapper(__regmap_init_sdw_mbq, #config,	\
+				sdw, config, mbq_config)
 
 /**
  * regmap_init_spi_avmm() - Initialize register map for Intel SPI Slave
@@ -1155,7 +1183,22 @@ bool regmap_ac97_default_volatile(struct device *dev, unsigned int reg);
  */
 #define devm_regmap_init_sdw_mbq(sdw, config)			\
 	__regmap_lockdep_wrapper(__devm_regmap_init_sdw_mbq, #config,   \
-				sdw, config)
+				sdw, config, NULL)
+
+/**
+ * devm_regmap_init_sdw_mbq_cfg() - Initialise managed MBQ SDW register map with config
+ *
+ * @sdw: Device that will be interacted with
+ * @config: Configuration for register map
+ * @mbq_config: Properties for the MBQ registers
+ *
+ * The return value will be an ERR_PTR() on error or a valid pointer
+ * to a struct regmap. The regmap will be automatically freed by the
+ * device management code.
+ */
+#define devm_regmap_init_sdw_mbq_cfg(sdw, config, mbq_config)	\
+	__regmap_lockdep_wrapper(__devm_regmap_init_sdw_mbq,	\
+				#config, sdw, config, mbq_config)
 
 /**
  * devm_regmap_init_slimbus() - Initialise managed register map
-- 
2.39.5


