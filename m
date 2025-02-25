Return-Path: <linux-kernel+bounces-531445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F852A44097
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AAA81889E77
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64732269820;
	Tue, 25 Feb 2025 13:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="VGU3EYRg"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFDB2561A9;
	Tue, 25 Feb 2025 13:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740489538; cv=none; b=bLdQoSA0w8iM2xFzeGAjTzKqZO48SEjRQjtllNWgfwofYzLGEwj8W/2zUcqr/ERhxh1dZxfE9XvZQLZHpKJPREe+nTPQ7Dy77+vThsXI4G/AUTBdTl/XGHPub/CaRMR9j9/Yiq2ky9pM9WlItLwMJNrrnkAvt+rGJkIkkOeDnOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740489538; c=relaxed/simple;
	bh=fdBvNhREZN5nF9AR1x9Pch+HJrsU70j9oAPqBctY5qI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kMYy/d3CtA7IV1oK50ia60jw8xjoWcJ8Dks7D3zQmz5lz39Vfev3P+7ghAHiU6bj/IZ5bhxIllnxRqIywCTX56n1Nc99/yU4zaFUENZm7xOppl8/xmHK5roYwdu/3EenukcDDGzS63rOvPr8fIrASusd/co4nPH/+r2oVHpW7u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=VGU3EYRg; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P4j5jH001538;
	Tue, 25 Feb 2025 07:18:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=wygukAiqXM4+rddOjRv6vu5n6X61vNNkO20X5O1WW6Q=; b=
	VGU3EYRgCuie7sB8+aTrhUZK/lDPEX/JKZhcZKfXC13L4rQXpc1O8zBA5pLvq2Vi
	sYd0alI4YlL4dnlPslIH0kIdibSBp+1xWS22wqpeZKIE/T/1DIidVm8/ltWVIAxD
	pODFSiYpb0ac3eifD0GPbsixp+WDjj5nkLK1mxHpVyOhcvIPDdVLDBUWjGgg3eYR
	hVPRohbcGgfKOtFtw1d1GKKB8u59S3+GpoFIQE5ydNTcnKtQPx3zd6R9fHDOpc5D
	wn7K3mV7cg2cu+UINKuc0d5o026wf4l+r/C2O3FeutGvhGdvgO9WKHMJlq0vozHJ
	01eSaVrAPiAzfwvRjn1FCw==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 44ycv5ptdu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 07:18:45 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 25 Feb
 2025 13:18:43 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Tue, 25 Feb 2025 13:18:43 +0000
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 5586B820270;
	Tue, 25 Feb 2025 13:18:43 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>, <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH 2/2] ASoC: cs35l56: Prevent races when soft-resetting using SPI control
Date: Tue, 25 Feb 2025 13:18:43 +0000
Message-ID: <20250225131843.113752-3-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250225131843.113752-1-rf@opensource.cirrus.com>
References: <20250225131843.113752-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=HoqMG1TS c=1 sm=1 tr=0 ts=67bdc335 cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=T2h4t0Lz3GQA:10 a=w1d2syhTAAAA:8 a=Uxh4JZ-cWek-ruiFpz8A:9 a=YXXWInSmI4Sqt1AkVdoW:22
X-Proofpoint-GUID: SL6OBwysPnUPndgofp_ODHORAKzubKKF
X-Proofpoint-ORIG-GUID: SL6OBwysPnUPndgofp_ODHORAKzubKKF
X-Proofpoint-Spam-Reason: safe

When SPI is used for control, the driver must hold the SPI bus lock
while issuing the sequence of writes to perform a soft reset.

From the time the driver writes the SYSTEM_RESET command until the
driver does a write to terminate the reset, there must not be any
activity on the SPI bus lines. If there is any SPI activity during the
soft-reset, another soft-reset will be triggered. The state of the SPI
chip select is irrelevant.

A repeated soft-reset does not in itself cause any problems, and it is
not an infinite loop. The problem is a race between these resets and
the driver polling for boot completion. There is a time window between
soft resets where the driver could read HALO_STATE as 2 (fully booted)
while the chip is actually soft-resetting. Although this window is
small, it is long enough that it is possible to hit it in normal
operation.

To prevent this race and ensure the chip really is fully booted, the
driver calls spi_bus_lock() to prevent other activity while resetting.
It then issues the SYSTEM_RESET mailbox command. After allowing
sufficient time for reset to take effect, the driver issues a PING
mailbox command, which will force completion of the full soft-reset
sequence. The SPI bus lock can then be released. The mailbox is
checked for any boot or wakeup response from the firmware, before the
value in HALO_STATE will be trusted.

This does not affect SoundWire or I2C control.

Fixes: 8a731fd37f8b ("ASoC: cs35l56: Move utility functions to shared file")
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 include/sound/cs35l56.h           | 31 ++++++++++++
 sound/pci/hda/cs35l56_hda_spi.c   |  3 ++
 sound/soc/codecs/cs35l56-shared.c | 80 +++++++++++++++++++++++++++++++
 sound/soc/codecs/cs35l56-spi.c    |  3 ++
 4 files changed, 117 insertions(+)

diff --git a/include/sound/cs35l56.h b/include/sound/cs35l56.h
index 3dc7a1551ac3..5d653a3491d0 100644
--- a/include/sound/cs35l56.h
+++ b/include/sound/cs35l56.h
@@ -12,6 +12,7 @@
 #include <linux/firmware/cirrus/cs_dsp.h>
 #include <linux/regulator/consumer.h>
 #include <linux/regmap.h>
+#include <linux/spi/spi.h>
 #include <sound/cs-amp-lib.h>
 
 #define CS35L56_DEVID					0x0000000
@@ -61,6 +62,7 @@
 #define CS35L56_IRQ1_MASK_8				0x000E0AC
 #define CS35L56_IRQ1_MASK_18				0x000E0D4
 #define CS35L56_IRQ1_MASK_20				0x000E0DC
+#define CS35L56_DSP_MBOX_1_RAW				0x0011000
 #define CS35L56_DSP_VIRTUAL1_MBOX_1			0x0011020
 #define CS35L56_DSP_VIRTUAL1_MBOX_2			0x0011024
 #define CS35L56_DSP_VIRTUAL1_MBOX_3			0x0011028
@@ -224,6 +226,7 @@
 #define CS35L56_HALO_STATE_SHUTDOWN			1
 #define CS35L56_HALO_STATE_BOOT_DONE			2
 
+#define CS35L56_MBOX_CMD_PING				0x0A000000
 #define CS35L56_MBOX_CMD_AUDIO_PLAY			0x0B000001
 #define CS35L56_MBOX_CMD_AUDIO_PAUSE			0x0B000002
 #define CS35L56_MBOX_CMD_AUDIO_REINIT			0x0B000003
@@ -254,6 +257,16 @@
 #define CS35L56_NUM_BULK_SUPPLIES			3
 #define CS35L56_NUM_DSP_REGIONS				5
 
+/* Additional margin for SYSTEM_RESET to control port ready on SPI */
+#define CS35L56_SPI_RESET_TO_PORT_READY_US (CS35L56_CONTROL_PORT_READY_US + 2500)
+
+struct cs35l56_spi_payload {
+	__be32	addr;
+	__be16	pad;
+	__be32	value;
+} __packed;
+static_assert(sizeof(struct cs35l56_spi_payload) == 10);
+
 struct cs35l56_base {
 	struct device *dev;
 	struct regmap *regmap;
@@ -269,6 +282,7 @@ struct cs35l56_base {
 	s8 cal_index;
 	struct cirrus_amp_cal_data cal_data;
 	struct gpio_desc *reset_gpio;
+	struct cs35l56_spi_payload *spi_payload_buf;
 };
 
 static inline bool cs35l56_is_otp_register(unsigned int reg)
@@ -276,6 +290,23 @@ static inline bool cs35l56_is_otp_register(unsigned int reg)
 	return (reg >> 16) == 3;
 }
 
+static inline int cs35l56_init_config_for_spi(struct cs35l56_base *cs35l56,
+					      struct spi_device *spi)
+{
+	cs35l56->spi_payload_buf = devm_kzalloc(&spi->dev,
+						sizeof(*cs35l56->spi_payload_buf),
+						GFP_KERNEL | GFP_DMA);
+	if (!cs35l56->spi_payload_buf)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static inline bool cs35l56_is_spi(struct cs35l56_base *cs35l56)
+{
+	return IS_ENABLED(CONFIG_SPI_MASTER) && !!cs35l56->spi_payload_buf;
+}
+
 extern const struct regmap_config cs35l56_regmap_i2c;
 extern const struct regmap_config cs35l56_regmap_spi;
 extern const struct regmap_config cs35l56_regmap_sdw;
diff --git a/sound/pci/hda/cs35l56_hda_spi.c b/sound/pci/hda/cs35l56_hda_spi.c
index d4ee5bb7c486..903578466905 100644
--- a/sound/pci/hda/cs35l56_hda_spi.c
+++ b/sound/pci/hda/cs35l56_hda_spi.c
@@ -22,6 +22,9 @@ static int cs35l56_hda_spi_probe(struct spi_device *spi)
 		return -ENOMEM;
 
 	cs35l56->base.dev = &spi->dev;
+	ret = cs35l56_init_config_for_spi(&cs35l56->base, spi);
+	if (ret)
+		return ret;
 
 #ifdef CS35L56_WAKE_HOLD_TIME_US
 	cs35l56->base.can_hibernate = true;
diff --git a/sound/soc/codecs/cs35l56-shared.c b/sound/soc/codecs/cs35l56-shared.c
index e0ed4fc11155..e28bfefa72f3 100644
--- a/sound/soc/codecs/cs35l56-shared.c
+++ b/sound/soc/codecs/cs35l56-shared.c
@@ -10,6 +10,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
 #include <linux/types.h>
 #include <sound/cs-amp-lib.h>
 
@@ -303,6 +304,79 @@ void cs35l56_wait_min_reset_pulse(void)
 }
 EXPORT_SYMBOL_NS_GPL(cs35l56_wait_min_reset_pulse, "SND_SOC_CS35L56_SHARED");
 
+static const struct {
+	u32 addr;
+	u32 value;
+} cs35l56_spi_system_reset_stages[] = {
+	{ .addr = CS35L56_DSP_VIRTUAL1_MBOX_1, .value = CS35L56_MBOX_CMD_SYSTEM_RESET },
+	/* The next write is necessary to delimit the soft reset */
+	{ .addr = CS35L56_DSP_MBOX_1_RAW, .value = CS35L56_MBOX_CMD_PING },
+};
+
+static void cs35l56_spi_issue_bus_locked_reset(struct cs35l56_base *cs35l56_base,
+					       struct spi_device *spi)
+{
+	struct cs35l56_spi_payload *buf = cs35l56_base->spi_payload_buf;
+	struct spi_transfer t = {
+		.tx_buf		= buf,
+		.len		= sizeof(*buf),
+	};
+	struct spi_message m;
+	int i, ret;
+
+	for (i = 0; i < ARRAY_SIZE(cs35l56_spi_system_reset_stages); i++) {
+		buf->addr = cpu_to_be32(cs35l56_spi_system_reset_stages[i].addr);
+		buf->value = cpu_to_be32(cs35l56_spi_system_reset_stages[i].value);
+		spi_message_init_with_transfers(&m, &t, 1);
+		ret = spi_sync_locked(spi, &m);
+		if (ret)
+			dev_warn(cs35l56_base->dev, "spi_sync failed: %d\n", ret);
+
+		usleep_range(CS35L56_SPI_RESET_TO_PORT_READY_US,
+			     2 * CS35L56_SPI_RESET_TO_PORT_READY_US);
+	}
+}
+
+static void cs35l56_spi_system_reset(struct cs35l56_base *cs35l56_base)
+{
+	struct spi_device *spi = to_spi_device(cs35l56_base->dev);
+	unsigned int val;
+	int read_ret, ret;
+
+	/*
+	 * There must not be any other SPI bus activity while the amp is
+	 * soft-resetting.
+	 */
+	ret = spi_bus_lock(spi->controller);
+	if (ret) {
+		dev_warn(cs35l56_base->dev, "spi_bus_lock failed: %d\n", ret);
+		return;
+	}
+
+	cs35l56_spi_issue_bus_locked_reset(cs35l56_base, spi);
+	spi_bus_unlock(spi->controller);
+
+	/*
+	 * Check firmware boot by testing for a response in MBOX_2.
+	 * HALO_STATE cannot be trusted yet because the reset sequence
+	 * can leave it with stale state. But MBOX is reset.
+	 * The regmap must remain in cache-only until the chip has
+	 * booted, so use a bypassed read.
+	 */
+	ret = read_poll_timeout(regmap_read_bypassed, read_ret,
+				(val > 0) && (val < 0xffffffff),
+				CS35L56_HALO_STATE_POLL_US,
+				CS35L56_HALO_STATE_TIMEOUT_US,
+				false,
+				cs35l56_base->regmap,
+				CS35L56_DSP_VIRTUAL1_MBOX_2,
+				&val);
+	if (ret) {
+		dev_err(cs35l56_base->dev, "SPI reboot timed out(%d): MBOX2=%#x\n",
+			read_ret, val);
+	}
+}
+
 static const struct reg_sequence cs35l56_system_reset_seq[] = {
 	REG_SEQ0(CS35L56_DSP1_HALO_STATE, 0),
 	REG_SEQ0(CS35L56_DSP_VIRTUAL1_MBOX_1, CS35L56_MBOX_CMD_SYSTEM_RESET),
@@ -315,6 +389,12 @@ void cs35l56_system_reset(struct cs35l56_base *cs35l56_base, bool is_soundwire)
 	 * accesses other than the controlled system reset sequence below.
 	 */
 	regcache_cache_only(cs35l56_base->regmap, true);
+
+	if (cs35l56_is_spi(cs35l56_base)) {
+		cs35l56_spi_system_reset(cs35l56_base);
+		return;
+	}
+
 	regmap_multi_reg_write_bypassed(cs35l56_base->regmap,
 					cs35l56_system_reset_seq,
 					ARRAY_SIZE(cs35l56_system_reset_seq));
diff --git a/sound/soc/codecs/cs35l56-spi.c b/sound/soc/codecs/cs35l56-spi.c
index c101134e8532..ca6c03a8766d 100644
--- a/sound/soc/codecs/cs35l56-spi.c
+++ b/sound/soc/codecs/cs35l56-spi.c
@@ -33,6 +33,9 @@ static int cs35l56_spi_probe(struct spi_device *spi)
 
 	cs35l56->base.dev = &spi->dev;
 	cs35l56->base.can_hibernate = true;
+	ret = cs35l56_init_config_for_spi(&cs35l56->base, spi);
+	if (ret)
+		return ret;
 
 	ret = cs35l56_common_probe(cs35l56);
 	if (ret != 0)
-- 
2.39.5


