Return-Path: <linux-kernel+bounces-354696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB26099412D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 10:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6315328366E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 08:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E5F1DFE37;
	Tue,  8 Oct 2024 07:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VSpt/gUS"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C809A1DE894
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 07:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728373730; cv=none; b=kcpUqsA7d4goSCKyRaIO+t9vfuE6V3ACuC7Va3zujPi7PWDSdUehYAxQVyn6P8wuaOU3x5qKhDimu34RIW5Kc5wrZVb5Y93zQePG/FTmK/7P3r0yD0FwiUH+zNgtyYo2/PT7ZoBE9BO7HIi3aoEbG+PEdJa2hLROYJu25RQ3eNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728373730; c=relaxed/simple;
	bh=3sTokONfWb8mUVLZczdE/QoXyeWn/xlJxOAF+f4qk80=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=P2CqDPxCudCuQK53DLUNldI5XqSNv22vl14uI74f1LnhE+BU+W3g55l9YXGkpF3J0QdybX+bCLEXktX62pyaGL8Inl0U9PX8Pdz7j9tr5kTtCDNlBtWYKYgPRgVbIRNux8RO1eTdiLCAAIxhZyd5RY2EqkGNUL7wKfzHBiX4dSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=VSpt/gUS; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42ca6ba750eso33132985e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 00:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728373725; x=1728978525; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L0GhXAeo0piAQdGhAtPqSFGupduVbCpRmFqdHRYbqxQ=;
        b=VSpt/gUSC6tAJ6TLwAuj21NjFmFi3hyPsgJikZ7+//LNgYOaouPP1/YaWFrNdWe3SD
         fHL3E+/PNiZJ6DJtiolylCX1OrGlnB5Oi/FoFwiZZNyHindmn4D8SeZNQUX1A9AjrzJh
         NPWtjQtbwR96T8wh7z1akiNPUajDDEMeqg2loLL8HBm5GBZvoFDjr+SLHh274wRxJgyc
         ngewPdi67oOdLBSt2WQkqKifr/tQS499SI5AHGYGo1gfBPL+iotHbZ+w0jeb6+b70rfv
         2oURKbaISjpoM2CcQ1DuRcQb7plLrr1GM95zigbnpha2sYn+jWNHQnjNYR4dP48DoPIj
         EejA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728373725; x=1728978525;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L0GhXAeo0piAQdGhAtPqSFGupduVbCpRmFqdHRYbqxQ=;
        b=XEIPTwsovSv5W8yEWXfxuibdFb6KEf73Uw3EkL2n/9FO6ZlJB60+NusSgg81gG7gw+
         23D9RF40px4saE7LLcrqfB2YkKdUmPbi6Mi6yWubfSxnDOAMB7rqy7Dcv/7j6UTaD9es
         +2yJMbdLbvQ/A8KS6i4SCw/8thx9ZkKvWrBd3/7iMNQ6eQAWxmmSTiPSsyhCnqCR/ODp
         nqZUQJn2LPiPqvpCKNRW+orVM5x8xAlimcmE7/HvNd63FSzroWPUdMQJtnThWwAv+Qt5
         rui8V1s4ktc996VGC1rxPSpGCE6iOOZNsIH5yY6bXY6yASkGNQDjIyA2GtpV2CNk9oBW
         4Qqg==
X-Forwarded-Encrypted: i=1; AJvYcCWsZmQzpBTgwRD/SBkXEeH3eifk+xv9SmqvbPrmlA1XZmICIDpowuhk0gywVIHWAnzD9P4DzgrGPm99/NI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmJEEVYpy7mHR7E6dVvvJKKZiCNKafl4hyIy60WhgMftg+RQUO
	LLt2MAHW4GTPQgGLu+Ibirab91sa17sXEeub9Lr1zd12Px0xf20X1BE4y/lumrc=
X-Google-Smtp-Source: AGHT+IHi0+ORDCyV5vkJi+PlJDdFKmgXiMW5ND6falmeeIdVKg0rgjsymhSWmT3meLpqvDkc2TtieA==
X-Received: by 2002:a05:600c:4f02:b0:42c:b68f:38fb with SMTP id 5b1f17b1804b1-42f94bd941cmr13112065e9.7.1728373725142;
        Tue, 08 Oct 2024 00:48:45 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:41f2:4244:ce34:c273])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4304efc0460sm11833055e9.1.2024.10.08.00.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 00:48:44 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Tue, 08 Oct 2024 09:48:29 +0200
Subject: [PATCH v2] clk: amlogic: axg-audio: use the auxiliary reset driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241008-meson-clk-rst-aux-v2-1-682ab9151f4f@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAMzjBGcC/z3MTQ6CMBBA4auQrh0y5c+WlfcwLloYpAqtmYLBE
 O5u48Llt3hvF5HYURRttgumt4su+ITilIluNP5O4PpkUWBRSUQFM8XgoZuewHEBs25gpVQKNdV
 l34jUvZgGt/2e11vywGGGZWQy/xOepUZdaYl5qVVT1QgSHpZXT8vFms/kLFPehVkcxxdALdrwo
 wAAAA==
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=5861; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=3sTokONfWb8mUVLZczdE/QoXyeWn/xlJxOAF+f4qk80=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBnBOPbvk7E+qYQvsmYSjDEPjdmtXMmeOO+V7FmU
 s61xBYzSNSJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCZwTj2wAKCRDm/A8cN/La
 hVQED/9wJX4zBrZTc5UHIO0D6Z/J2p5y4QHaNRkFznexo9UQBszkDSqvfhk7CbBB7XPALmPt65H
 V9klvoiHvntmz+MuqgeetdQNwzbGaRLj7vj1umcn6ysHwgrlX9Z/EXpMG6U+At0XJh6nHpDevrZ
 BIu78CVR2yyy6XzHCfAWtYDaQbcPjNW5kyob6kvjUQLjCa71NAC3KX9SoDXbRwvzvEo2JGgqiQE
 /tKoc2T6hrBKMTCMrW+k5Eu57LdvefSGGjQaeJaIxd9dA/QXBr+Yg8dx0we+vZYRQmycY/ujpjS
 P4ybmmMF7qMGjI78eSZ1UuYT9WF+twM7QdgUsnlb5C5wjaoAstXCkirr6NBy5dV5hEj36+sYZeg
 W7iwSvtH47yPLe4bPHdyY7Kum7Hfpo5xQ8xA/5MICTP6w4RQYyZVYNpA6zvOIpp81748JIe3bFO
 lN6bMCgEJyPB0FcNs1UTjs5Q0e7lTZdfByE/pfx4ZeQIwqZFFOQNsTiqqQfiCczOO/6SGYipzFD
 A6SOd9PR1cpvMLJKcEVGsAk+EUybLKeXcydN6RooZiElyk3vkaWIvAyzPRPQchQ6sFObQM1iOOu
 qvybg0d4FDBksLTOnzpqvk5m4JDrCgPxay8YPmLBMRaj/Ruw2vMNDJ9slGDE8Lq1qwAQmmGyIRw
 vAv/PI8qC9eh5wA==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

Remove the implementation of the reset driver in axg audio
clock driver and migrate to the one provided by the reset framework
on the auxiliary bus

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
Change in v2:
* Rebase on the applied version of amlogic auxiliary reset driver
* Link to v1: https://lore.kernel.org/r/20240719094910.3986450-1-jbrunet@baylibre.com
---
 drivers/clk/meson/Kconfig     |   1 +
 drivers/clk/meson/axg-audio.c | 109 ++++--------------------------------------
 2 files changed, 10 insertions(+), 100 deletions(-)

diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
index 78f648c9c97d..7cb21fc223b0 100644
--- a/drivers/clk/meson/Kconfig
+++ b/drivers/clk/meson/Kconfig
@@ -106,6 +106,7 @@ config COMMON_CLK_AXG_AUDIO
 	select COMMON_CLK_MESON_SCLK_DIV
 	select COMMON_CLK_MESON_CLKC_UTILS
 	select REGMAP_MMIO
+	imply RESET_MESON_AUX
 	help
 	  Support for the audio clock controller on AmLogic A113D devices,
 	  aka axg, Say Y if you want audio subsystem to work.
diff --git a/drivers/clk/meson/axg-audio.c b/drivers/clk/meson/axg-audio.c
index beda86349389..7714bde5ffc0 100644
--- a/drivers/clk/meson/axg-audio.c
+++ b/drivers/clk/meson/axg-audio.c
@@ -15,6 +15,8 @@
 #include <linux/reset-controller.h>
 #include <linux/slab.h>
 
+#include <soc/amlogic/reset-meson-aux.h>
+
 #include "meson-clkc-utils.h"
 #include "axg-audio.h"
 #include "clk-regmap.h"
@@ -1678,84 +1680,6 @@ static struct clk_regmap *const sm1_clk_regmaps[] = {
 	&sm1_earcrx_dmac_clk,
 };
 
-struct axg_audio_reset_data {
-	struct reset_controller_dev rstc;
-	struct regmap *map;
-	unsigned int offset;
-};
-
-static void axg_audio_reset_reg_and_bit(struct axg_audio_reset_data *rst,
-					unsigned long id,
-					unsigned int *reg,
-					unsigned int *bit)
-{
-	unsigned int stride = regmap_get_reg_stride(rst->map);
-
-	*reg = (id / (stride * BITS_PER_BYTE)) * stride;
-	*reg += rst->offset;
-	*bit = id % (stride * BITS_PER_BYTE);
-}
-
-static int axg_audio_reset_update(struct reset_controller_dev *rcdev,
-				unsigned long id, bool assert)
-{
-	struct axg_audio_reset_data *rst =
-		container_of(rcdev, struct axg_audio_reset_data, rstc);
-	unsigned int offset, bit;
-
-	axg_audio_reset_reg_and_bit(rst, id, &offset, &bit);
-
-	regmap_update_bits(rst->map, offset, BIT(bit),
-			assert ? BIT(bit) : 0);
-
-	return 0;
-}
-
-static int axg_audio_reset_status(struct reset_controller_dev *rcdev,
-				unsigned long id)
-{
-	struct axg_audio_reset_data *rst =
-		container_of(rcdev, struct axg_audio_reset_data, rstc);
-	unsigned int val, offset, bit;
-
-	axg_audio_reset_reg_and_bit(rst, id, &offset, &bit);
-
-	regmap_read(rst->map, offset, &val);
-
-	return !!(val & BIT(bit));
-}
-
-static int axg_audio_reset_assert(struct reset_controller_dev *rcdev,
-				unsigned long id)
-{
-	return axg_audio_reset_update(rcdev, id, true);
-}
-
-static int axg_audio_reset_deassert(struct reset_controller_dev *rcdev,
-				unsigned long id)
-{
-	return axg_audio_reset_update(rcdev, id, false);
-}
-
-static int axg_audio_reset_toggle(struct reset_controller_dev *rcdev,
-				unsigned long id)
-{
-	int ret;
-
-	ret = axg_audio_reset_assert(rcdev, id);
-	if (ret)
-		return ret;
-
-	return axg_audio_reset_deassert(rcdev, id);
-}
-
-static const struct reset_control_ops axg_audio_rstc_ops = {
-	.assert = axg_audio_reset_assert,
-	.deassert = axg_audio_reset_deassert,
-	.reset = axg_audio_reset_toggle,
-	.status = axg_audio_reset_status,
-};
-
 static struct regmap_config axg_audio_regmap_cfg = {
 	.reg_bits	= 32,
 	.val_bits	= 32,
@@ -1766,16 +1690,14 @@ struct audioclk_data {
 	struct clk_regmap *const *regmap_clks;
 	unsigned int regmap_clk_num;
 	struct meson_clk_hw_data hw_clks;
-	unsigned int reset_offset;
-	unsigned int reset_num;
 	unsigned int max_register;
+	const char *rst_drvname;
 };
 
 static int axg_audio_clkc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	const struct audioclk_data *data;
-	struct axg_audio_reset_data *rst;
 	struct regmap *map;
 	void __iomem *regs;
 	struct clk_hw *hw;
@@ -1834,22 +1756,11 @@ static int axg_audio_clkc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	/* Stop here if there is no reset */
-	if (!data->reset_num)
-		return 0;
-
-	rst = devm_kzalloc(dev, sizeof(*rst), GFP_KERNEL);
-	if (!rst)
-		return -ENOMEM;
-
-	rst->map = map;
-	rst->offset = data->reset_offset;
-	rst->rstc.nr_resets = data->reset_num;
-	rst->rstc.ops = &axg_audio_rstc_ops;
-	rst->rstc.of_node = dev->of_node;
-	rst->rstc.owner = THIS_MODULE;
+	/* Register auxiliary reset driver when applicable */
+	if (data->rst_drvname)
+		ret = devm_meson_rst_aux_register(dev, map, data->rst_drvname);
 
-	return devm_reset_controller_register(dev, &rst->rstc);
+	return ret;
 }
 
 static const struct audioclk_data axg_audioclk_data = {
@@ -1869,9 +1780,8 @@ static const struct audioclk_data g12a_audioclk_data = {
 		.hws = g12a_audio_hw_clks,
 		.num = ARRAY_SIZE(g12a_audio_hw_clks),
 	},
-	.reset_offset = AUDIO_SW_RESET,
-	.reset_num = 26,
 	.max_register = AUDIO_CLK_SPDIFOUT_B_CTRL,
+	.rst_drvname = "rst-g12a",
 };
 
 static const struct audioclk_data sm1_audioclk_data = {
@@ -1881,9 +1791,8 @@ static const struct audioclk_data sm1_audioclk_data = {
 		.hws = sm1_audio_hw_clks,
 		.num = ARRAY_SIZE(sm1_audio_hw_clks),
 	},
-	.reset_offset = AUDIO_SM1_SW_RESET0,
-	.reset_num = 39,
 	.max_register = AUDIO_EARCRX_DMAC_CLK_CTRL,
+	.rst_drvname = "rst-sm1",
 };
 
 static const struct of_device_id clkc_match_table[] = {

---
base-commit: 0e2d37252dd525b117bda4e4e0e6fac178ba569d
change-id: 20241008-meson-clk-rst-aux-b118809e53d6

Best regards,
-- 
Jerome


