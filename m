Return-Path: <linux-kernel+bounces-318853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A7996F427
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 14:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5196B210B8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 12:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A4F1CC8B5;
	Fri,  6 Sep 2024 12:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jNExSRcy"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F5913AA38;
	Fri,  6 Sep 2024 12:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725625226; cv=none; b=jJ6L+CrfTbUifePyevlqHN+jjO0aZwHts+JYDDpihlKNgi8fjfRrtGMIQeQde/o3aEg+8YgOL7Q6mmTu4JpVivmKCCPmPgF5LDvXxIqCCT5mZo8MhJnnDnoxz2gE2CczEu9otqWVo8UBruTVA7Y+a2fuhHpWY2S40FjKD2EX52w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725625226; c=relaxed/simple;
	bh=Y8S3sIUeUo+i76VJqD3Gk9saCrU/jNFW7+ZyZebjSrU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KJtK3q6mXvDuDxZFtfIwFSgkBMA8rd6tL7+c4tt44U6Gc090GiX8cptf05cpDIKA8bxiQQUoPtSD5cvtKLm4Y6cMVZsZNpoxrXkNx1DCUWG1aMbJbbHFi4qmOp+hwmZxFeUpiEG0OMZIp+Qgpr6VC0rDputIM2noKToZJtDeYk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jNExSRcy; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C0DBFC000B;
	Fri,  6 Sep 2024 12:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725625221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MtAkF99VG/OSc6QNgU0cRrGhkO1sSV69WMhxrgTuZIA=;
	b=jNExSRcyFcWBI1DsCEiYSceE1JAcAaEyvsNSpGlZ+CnUdyeO4hPy0kqSD5KcNtxR+JrCtz
	8pdSSbU2pzy54M70QEe2d+7T6Smnal/7UPkIqpBtxNpfJERTATWh1aG69wFnmQhAx4UfjG
	Er9rBqCgLzxzafnxqTRCMcHzlPr1ETQyCIOE0JJWnEIE/PZsQi+qyZoa27jCXb9vRdAf4r
	5FzBKLWClHEfzNSGyioGkjp3o9h3LfFdSDiY9OTCwi/1t5b6+1C4m5a6qtNtVLG5SJh8fi
	veazp6wgkPV4QmuqgAKOsZBuBKtOK5mM3eQonNdeurMvUW+amm8WbLVBPP7Zqw==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Fri, 06 Sep 2024 14:20:58 +0200
Subject: [PATCH] ASoC: tlv320aic31xx: Add support for loading filter
 coefficients
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240906-tlv320-filter-v1-1-6955f53ff435@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAKnz2mYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDCwMz3ZKcMmMjA920zJyS1CJdQwvL1JQUMzMTS7NkJaCegqLUtMwKsHn
 RsbW1ANhLRdpfAAAA
To: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, 
 Baojun Xu <baojun.xu@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Romain Gantois <romain.gantois@bootlin.com>
X-Mailer: b4 0.14.1
X-GND-Sasl: romain.gantois@bootlin.com

The TLV320DAC3100 Audio DAC has 25 built-in digital audio processing blocks
(PRBs). Each of these PRBs has a static filter structure with programmable
coefficients. Once a PRB is selected for use by the DAC, its filter
coefficients can be configured via a dedicated set of registers.

Define a new optional firmware which can be loaded by the TLV320DAC driver.
This firmware describes a full set of filter coefficients for all blocks
used by the various PRBs.

The firmware's binary format is heavily inspired by the one used in the
peb2466 driver. It includes a version marker to allow for potential
evolutions of the format.

Note that adaptive filtering is not supported i.e. filter coefficients are
loaded once before power-on and then cannot be changed while the DAC is
powered. This is why only page A coefficients are modified. Page B
coefficients are only used for adaptive filtering.

Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 sound/soc/codecs/tlv320aic31xx.c | 100 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index 2f94cfda0e33..7e624c4b77b6 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -12,6 +12,7 @@
  * and mono/stereo Class-D speaker driver.
  */
 
+#include <asm/unaligned.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/init.h>
@@ -22,6 +23,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/regulator/consumer.h>
 #include <linux/acpi.h>
+#include <linux/firmware.h>
 #include <linux/of.h>
 #include <linux/slab.h>
 #include <sound/core.h>
@@ -1638,6 +1640,98 @@ static const struct i2c_device_id aic31xx_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, aic31xx_i2c_id);
 
+static int tlv320dac3100_fw_load(struct aic31xx_priv *aic31xx,
+				 const u8 *data, size_t size)
+{
+	int ret, reg;
+	u16 val16;
+
+	/*
+	 * Coefficients firmware binary structure. Multi-byte values are big-endian.
+	 *
+	 * @0, 16bits: Magic (0xB30C)
+	 * @2, 16bits: Version (0x0100 for version 1.0)
+	 * @4, 8bits: DAC Processing Block Selection
+	 * @5, 62 16-bit values: Page 8 buffer A DAC programmable filter coefficients
+	 * @129, 12 16-bit values: Page 9 Buffer A DAC programmable filter coefficients
+	 *
+	 * Filter coefficients are interpreted as two's complement values
+	 * ranging from -32 768 to 32 767. For more details on filter coefficients,
+	 * please refer to the TLV320DAC3100 datasheet, tables 6-120 and 6-123.
+	 */
+
+	if (size != 153) {
+		dev_err(aic31xx->dev, "firmware size is %zu, expected 153 bytes\n", size);
+		return -EINVAL;
+	}
+
+	/* Check magic */
+	val16 = get_unaligned_be16(data);
+	if (val16 != 0xb30c) {
+		dev_err(aic31xx->dev, "fw magic is 0x%04x expected 0xb30c\n", val16);
+		return -EINVAL;
+	}
+	data += 2;
+
+	/* Check version */
+	val16 = get_unaligned_be16(data);
+	if (val16 != 0x0100) {
+		dev_err(aic31xx->dev, "invalid firmware version 0x%04x! expected 1", val16);
+		return -EINVAL;
+	}
+	data += 2;
+
+	ret = regmap_write(aic31xx->regmap, AIC31XX_DACPRB, *data);
+	if (ret) {
+		dev_err(aic31xx->dev, "failed to write PRB index: err %d\n", ret);
+		return ret;
+	}
+	data += 1;
+
+	/* Page 8 Buffer A coefficients */
+	for (reg = 2; reg < 126; reg++) {
+		ret = regmap_write(aic31xx->regmap, AIC31XX_REG(8, reg), *data);
+		if (ret) {
+			dev_err(aic31xx->dev,
+				"failed to write page 8 filter coefficient %d: err %d\n", reg, ret);
+			return ret;
+		}
+		data++;
+	}
+
+	/* Page 9 Buffer A coefficients */
+	for (reg = 2; reg < 26; reg++) {
+		ret = regmap_write(aic31xx->regmap, AIC31XX_REG(9, reg), *data);
+		if (ret) {
+			dev_err(aic31xx->dev,
+				"failed to write page 9 filter coefficient %d: err %d\n", reg, ret);
+			return ret;
+		}
+		data++;
+	}
+
+	dev_info(aic31xx->dev, "done loading DAC filter coefficients\n");
+
+	return ret;
+}
+
+static int tlv320dac3100_load_coeffs(struct aic31xx_priv *aic31xx,
+				     const char *fw_name)
+{
+	const struct firmware *fw;
+	int ret;
+
+	ret = request_firmware(&fw, fw_name, aic31xx->dev);
+	if (ret)
+		return ret;
+
+	ret = tlv320dac3100_fw_load(aic31xx, fw->data, fw->size);
+
+	release_firmware(fw);
+
+	return ret;
+}
+
 static int aic31xx_i2c_probe(struct i2c_client *i2c)
 {
 	struct aic31xx_priv *aic31xx;
@@ -1727,6 +1821,12 @@ static int aic31xx_i2c_probe(struct i2c_client *i2c)
 		}
 	}
 
+	if (aic31xx->codec_type == DAC3100) {
+		ret = tlv320dac3100_load_coeffs(aic31xx, "tlv320dac3100-coeffs.bin");
+		if (ret)
+			dev_warn(aic31xx->dev, "Did not load any filter coefficients\n");
+	}
+
 	if (aic31xx->codec_type & DAC31XX_BIT)
 		return devm_snd_soc_register_component(&i2c->dev,
 				&soc_codec_driver_aic31xx,

---
base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
change-id: 20240806-tlv320-filter-189edd66496c

Best regards,
-- 
Romain Gantois <romain.gantois@bootlin.com>


