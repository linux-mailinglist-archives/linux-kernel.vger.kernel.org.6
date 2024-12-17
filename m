Return-Path: <linux-kernel+bounces-449313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CB59F4D12
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 15:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05233188BA6B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 14:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3A01F5408;
	Tue, 17 Dec 2024 14:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="DDEbfjPB"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7795C1DA612;
	Tue, 17 Dec 2024 14:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734444280; cv=none; b=MqePwAvFRxfruzM5CgOfiqq90dSlTJcFAO6KnBqL0U7nTUSkWCUUhkSSaLLVegXAL1tjMtEAlmEeLmx3okr5+a+VHpply3+G6A/oJNU3QxtdEmYKiY+k1CTFar9aIAmiuxOIAgWPG3MGWwlbIEU9y7Kv6vQff3DdFk8mzIZRfFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734444280; c=relaxed/simple;
	bh=5ozuiVQRs09PfEHw64LGV+mtN4bByDc0ZXdOVCKN50M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C2mcaiRcV6rLv/YcXfz7pYgv7MZg+WdwWcMNyjfAFfSABszB6xaD+w4NGR8PrAG3oSN4//dhg4JEH1gCCufBZYVH1A76P58B4R2i+4cSXZpfYP2Xmtg9jQ/NcmS70oMpFSvkgX3or7UR0Wvsc2NgdJmeG8MeL1g2tmdFD/hE92I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=DDEbfjPB; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BH47Faw011049;
	Tue, 17 Dec 2024 07:59:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=2yRzMMdteGhqtHBDSV/LdH5f6fNg5wswEz4bMyRDcT8=; b=
	DDEbfjPB5Tr7qOxXbHqBJrcaDbR09aP2RS6ykgtirqSylk3pZ7IUM4bu97y8gurL
	5xJ9aC+geb+6Hl0PHGebUyGRzXDn1MUBVyNG0ww5Oo6XHNFtT/4maX1AikQKLDUu
	TdlZhMAwnKQyMmCs2VkE0QXwhklUs+beUkGpcQVhfKZYM2Wtl3l0YSZGjkGfAlfW
	Q9Ba0LjzhnEYC0SMjiilHOv9AE4yAPxn2rXs4DbvkmLGBN4W8AcSmV6n/YqQVJr2
	fRcuuuxPdgIlz7O7P8xxjHh2J37LyxD2rhAcXhfnaCKy2IjxXn5ASbsJoShWj3sv
	aKs0nzU/Zap0jaXNkHoSBg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 43h7akbb0q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 07:59:23 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.13; Tue, 17 Dec
 2024 13:59:22 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.13 via Frontend Transport; Tue, 17 Dec 2024 13:59:22 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id DE02C822546;
	Tue, 17 Dec 2024 13:59:21 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>, <vkoul@kernel.org>, <oder_chiou@realtek.com>
CC: <jack.yu@realtek.com>, <shumingf@realtek.com>, <lgirdwood@gmail.com>,
        <peter.ujfalusi@linux.intel.com>, <yung-chuan.liao@linux.intel.com>,
        <sanyog.r.kale@intel.com>, <pierre-louis.bossart@linux.dev>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH 4/5] regmap: sdw-mbq: Add support for SDCA deferred controls
Date: Tue, 17 Dec 2024 13:59:20 +0000
Message-ID: <20241217135921.3572496-5-ckeepax@opensource.cirrus.com>
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
X-Proofpoint-GUID: m5Vg7-MBLTeMog7Es68S7sV3zELx9I-H
X-Proofpoint-ORIG-GUID: m5Vg7-MBLTeMog7Es68S7sV3zELx9I-H
X-Proofpoint-Spam-Reason: safe

The SDCA specification allows for controls to be deferred. In the case
of a deferred control the device will return COMMAND_IGNORED to the
8-bit operation that would cause the value to commit. Which is the
final 8-bits on a write, or the first 8-bits on a read. In the case of
receiving a defer, the regmap will poll the SDCA function busy bit,
after which the transaction will be retried, returning an error if the
function busy does not clear within a chip specific timeout. Since
this is common SDCA functionality which is the 99% use-case for MBQs
it makes sense to incorporate this functionality into the register
map. If no MBQ configuration is specified, the behaviour will default
to the existing behaviour.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/base/regmap/regmap-sdw-mbq.c | 129 ++++++++++++++++++++++++---
 include/linux/regmap.h               |  15 ++++
 2 files changed, 130 insertions(+), 14 deletions(-)

diff --git a/drivers/base/regmap/regmap-sdw-mbq.c b/drivers/base/regmap/regmap-sdw-mbq.c
index 1bd2773b11a4..4cf565f9205b 100644
--- a/drivers/base/regmap/regmap-sdw-mbq.c
+++ b/drivers/base/regmap/regmap-sdw-mbq.c
@@ -2,12 +2,15 @@
 // Copyright(c) 2020 Intel Corporation.
 
 #include <linux/bits.h>
+#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/errno.h>
+#include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
 #include <linux/soundwire/sdw.h>
 #include <linux/soundwire/sdw_registers.h>
+#include <sound/sdca_function.h>
 #include "internal.h"
 
 struct regmap_mbq_context {
@@ -16,6 +19,7 @@ struct regmap_mbq_context {
 	struct regmap_sdw_mbq_cfg cfg;
 
 	int val_size;
+	bool (*readable_reg)(struct device *dev, unsigned int reg);
 };
 
 static int regmap_sdw_mbq_size(struct regmap_mbq_context *ctx, unsigned int reg)
@@ -31,18 +35,48 @@ static int regmap_sdw_mbq_size(struct regmap_mbq_context *ctx, unsigned int reg)
 	return size;
 }
 
-static int regmap_sdw_mbq_write(void *context, unsigned int reg, unsigned int val)
+static bool regmap_sdw_mbq_deferrable(struct regmap_mbq_context *ctx, unsigned int reg)
+{
+	if (ctx->cfg.deferrable)
+		return ctx->cfg.deferrable(ctx->dev, reg);
+
+	return false;
+}
+
+static int regmap_sdw_mbq_poll_busy(struct sdw_slave *slave, unsigned int reg,
+				    struct regmap_mbq_context *ctx)
+{
+	struct device *dev = &slave->dev;
+	int val, ret;
+
+	dev_dbg(dev, "Deferring transaction for 0x%x\n", reg);
+
+	reg = SDW_SDCA_CTL(SDW_SDCA_CTL_FUNC(reg), 0,
+			   SDCA_CTL_ENTITY_0_FUNCTION_STATUS, 0);
+
+	if (ctx->readable_reg(dev, reg)) {
+		ret = read_poll_timeout(sdw_read_no_pm, val,
+					val < 0 || !(val & SDCA_CTL_ENTITY_0_FUNCTION_BUSY),
+					ctx->cfg.timeout_us, ctx->cfg.retry_us,
+					false, slave, reg);
+		if (val < 0)
+			return val;
+		if (ret)
+			dev_err(dev, "Function busy timed out 0x%x: %d\n", reg, val);
+	} else {
+		fsleep(ctx->cfg.timeout_us);
+	}
+
+	return ret;
+}
+
+static int regmap_sdw_mbq_write_impl(struct sdw_slave *slave,
+				     unsigned int reg, unsigned int val,
+				     int mbq_size, bool deferrable)
 {
-	struct regmap_mbq_context *ctx = context;
-	struct device *dev = ctx->dev;
-	struct sdw_slave *slave = dev_to_sdw_dev(dev);
-	int mbq_size = regmap_sdw_mbq_size(ctx, reg);
 	int shift = mbq_size * BITS_PER_BYTE;
 	int ret;
 
-	if (mbq_size < 0)
-		return mbq_size;
-
 	while (--mbq_size > 0) {
 		shift -= BITS_PER_BYTE;
 
@@ -52,24 +86,58 @@ static int regmap_sdw_mbq_write(void *context, unsigned int reg, unsigned int va
 			return ret;
 	}
 
-	return sdw_write_no_pm(slave, reg, val & 0xff);
+	ret = sdw_write_no_pm(slave, reg, val & 0xff);
+	if (deferrable && ret == -ENODATA)
+		return -EAGAIN;
+
+	return ret;
 }
 
-static int regmap_sdw_mbq_read(void *context, unsigned int reg, unsigned int *val)
+static int regmap_sdw_mbq_write(void *context, unsigned int reg, unsigned int val)
 {
 	struct regmap_mbq_context *ctx = context;
 	struct device *dev = ctx->dev;
 	struct sdw_slave *slave = dev_to_sdw_dev(dev);
+	bool deferrable = regmap_sdw_mbq_deferrable(ctx, reg);
 	int mbq_size = regmap_sdw_mbq_size(ctx, reg);
-	int shift = BITS_PER_BYTE;
-	int read;
+	int ret;
 
 	if (mbq_size < 0)
 		return mbq_size;
 
+	/*
+	 * Technically the spec does allow a device to set itself to busy for
+	 * internal reasons, but since it doesn't provide any information on
+	 * how to handle timeouts in that case, for now the code will only
+	 * process a single wait/timeout on function busy and a single retry
+	 * of the transaction.
+	 */
+	ret = regmap_sdw_mbq_write_impl(slave, reg, val, mbq_size, deferrable);
+	if (ret == -EAGAIN) {
+		ret = regmap_sdw_mbq_poll_busy(slave, reg, ctx);
+		if (ret)
+			return ret;
+
+		ret = regmap_sdw_mbq_write_impl(slave, reg, val, mbq_size, false);
+	}
+
+	return ret;
+}
+
+static int regmap_sdw_mbq_read_impl(struct sdw_slave *slave,
+				    unsigned int reg, unsigned int *val,
+				    int mbq_size, bool deferrable)
+{
+	int shift = BITS_PER_BYTE;
+	int read;
+
 	read = sdw_read_no_pm(slave, reg);
-	if (read < 0)
+	if (read < 0) {
+		if (deferrable && read == -ENODATA)
+			return -EAGAIN;
+
 		return read;
+	}
 
 	*val = read;
 
@@ -85,6 +153,37 @@ static int regmap_sdw_mbq_read(void *context, unsigned int reg, unsigned int *va
 	return 0;
 }
 
+static int regmap_sdw_mbq_read(void *context, unsigned int reg, unsigned int *val)
+{
+	struct regmap_mbq_context *ctx = context;
+	struct device *dev = ctx->dev;
+	struct sdw_slave *slave = dev_to_sdw_dev(dev);
+	bool deferrable = regmap_sdw_mbq_deferrable(ctx, reg);
+	int mbq_size = regmap_sdw_mbq_size(ctx, reg);
+	int ret;
+
+	if (mbq_size < 0)
+		return mbq_size;
+
+	/*
+	 * Technically the spec does allow a device to set itself to busy for
+	 * internal reasons, but since it doesn't provide any information on
+	 * how to handle timeouts in that case, for now the code will only
+	 * process a single wait/timeout on function busy and a single retry
+	 * of the transaction.
+	 */
+	ret = regmap_sdw_mbq_read_impl(slave, reg, val, mbq_size, deferrable);
+	if (ret == -EAGAIN) {
+		ret = regmap_sdw_mbq_poll_busy(slave, reg, ctx);
+		if (ret)
+			return ret;
+
+		ret = regmap_sdw_mbq_read_impl(slave, reg, val, mbq_size, false);
+	}
+
+	return ret;
+}
+
 static const struct regmap_bus regmap_sdw_mbq = {
 	.reg_read = regmap_sdw_mbq_read,
 	.reg_write = regmap_sdw_mbq_write,
@@ -119,11 +218,13 @@ regmap_sdw_mbq_gen_context(struct device *dev,
 		return ERR_PTR(-ENOMEM);
 
 	ctx->dev = dev;
-	ctx->val_size = config->val_bits / BITS_PER_BYTE;
 
 	if (mbq_config)
 		ctx->cfg = *mbq_config;
 
+	ctx->val_size = config->val_bits / BITS_PER_BYTE;
+	ctx->readable_reg = config->readable_reg;
+
 	return ctx;
 }
 
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index dd96a22f5657..198067d3cf10 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -510,11 +510,26 @@ struct regmap_range_cfg {
  * struct regmap_sdw_mbq_cfg - Configuration for Multi-Byte Quantities
  *
  * @mbq_size: Callback returning the actual size of the given register.
+ * @deferrable: Callback returning true if the hardware can defer
+ *              transactions to the given register. Deferral should
+ *              only be used by SDCA parts and typically which controls
+ *              are deferrable will be specified in either as a hard
+ *              coded list or from the DisCo tables in the platform
+ *              firmware.
+ *
+ * @timeout_us: The time in microseconds after which waiting for a deferred
+ *              transaction should time out.
+ * @retry_us: The time in microseconds between polls of the function busy
+ *            status whilst waiting for an opportunity to retry a deferred
+ *            transaction.
  *
  * Provides additional configuration required for SoundWire MBQ register maps.
  */
 struct regmap_sdw_mbq_cfg {
 	int (*mbq_size)(struct device *dev, unsigned int reg);
+	bool (*deferrable)(struct device *dev, unsigned int reg);
+	unsigned long timeout_us;
+	unsigned long retry_us;
 };
 
 struct regmap_async;
-- 
2.39.5


