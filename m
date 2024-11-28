Return-Path: <linux-kernel+bounces-424959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6ED9DBBC9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 18:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1864281C18
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 17:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1004E1C07EE;
	Thu, 28 Nov 2024 17:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dKSvrJhT"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275CC537F8
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 17:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732815072; cv=none; b=FOuiU6QS5XTawE5By19dglXF6U0LPAHvxpl/pa34sqJ2Ean3z/wD7yjAGgoJgc2iu8sgKXH2oXKBSLTk5pQa01Zg/Pz33zEIr+bgbpvIMECfY/MWd3NbTYDzVeA6JI/td089diMoXkhS5OyVGdtIbZJCCie8rbYfHhn+YA+JdAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732815072; c=relaxed/simple;
	bh=aLEeckbAOzstWQ8GqyUU0U1ON+1IQGvGuu+IScVtjTA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ekzd2u1dF5BqrlCH8ZNMmyKCsyfolgaBq6d0TAekoG0lAK+CU0L8099cB89kFxKZEYCnlK5IKgAr1dv+Cmks4RTOpjcWB2+FHsNfK26o0pbj8/POY+JzlpK5ePjt1HmNVQpPdy7trMIIwWPosCdTKCxQ3rQrhFmEDrMYtwcgL9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dKSvrJhT; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43494a20379so9549115e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 09:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732815066; x=1733419866; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+vhPQ5vvW/JkWuLOCWK7lUJrsyH8KFQdUBUxIro36iU=;
        b=dKSvrJhT/1Jb8zociwB3MwdsiEqg3EDcrP3CYbnYMHRxu35tezQ3hNFJCNfETgycIK
         PdpX5nqbB30RZT2pn31TadvlXd0gGhG1Y91fM31FDo1M7ERwrcVEnXMWWd6mCNsQfqCm
         utB4kaOnQUzlEntO6p3dwR/0IhPKHHtq5taecNUz2RDp/GsXpp/6/QQ4KEi8/4FUXfXo
         aLt2SQGLU48sFpk+37MuQizeu4doqTUoFbROHhN32KK1lgMv4yGfgTF6co6ECRRs1oRm
         uzdbbBgfpy8VIVMoutGujT/wYrwxBVr8LzJRlGtgOuFDITsXj0CKj4/09q90r/EcuYot
         Uiag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732815066; x=1733419866;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+vhPQ5vvW/JkWuLOCWK7lUJrsyH8KFQdUBUxIro36iU=;
        b=KijJLY0W5E4JXNFWss1NlUQZl+cM3kVdVxSuRskth3AP/9XoRnj9rKQMdR7VN8BrBE
         N58PevQryHbjToE8M1WHQV8wB9QuqBhO8pslbJlFzrQTLzqirfKnkZ9x1iTw3Ba3TwAD
         kBf761dI0SFiEgPjQs6OLim0o2Z4GKP8iRpMxZlLTRea1zQYknksUSpAAIIvQn7/eRAM
         lXeVDSZRZs0hWj+CgzWpsQ7bXHm67KLHTbHuauDuPWsewVLlxsQyqViWHsMHt4Cxq8t2
         +q1DsB7zFruIURSZGfQ1fwEB4AnfZmZ7sn47pg4okoh/HVQyuQofvHcbek+VeUOTCoCJ
         mLnw==
X-Forwarded-Encrypted: i=1; AJvYcCW2aKnrDWz3pLj576hsvjh8idb6UuzhnD2BdFuM8X148o9vwyocwn2y8vCVE8HCq+oMT5MK0/zB1L5+GRU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/0WZTSlZe5yvjMBEBiJ7b7o62WNzhxaSd2qk5YfHCNsoFBtWZ
	gAj2fJQ8l10Gz1FuMYg4WPHtTlOuqx+T4JOOu5WxZml4IG/qaeK7Bv6Mrt89wIBmTUI9+v+8YuQ
	X
X-Gm-Gg: ASbGncsdbN5VTlJUwF2n+la6UWluZ8ENiIs23aSQUZfnf14uxfP/r9ax7qINLKJCYAs
	07eCESaHAEYRNeudlhEHBcYGb6PoRPN52MKBQoZ2Wv4jIcvmYmAPhC9iY2E3TRwia/SC/+fTuQu
	t6NFltQQIYz1fx1KVtVERxgdrOOZdhVWxZFY3yc1pSCTYSf85WeC9znjWFyi7eSIu5QyZi8+TIy
	2l5HDlc00xUIVaWr7h91GoWy/8j+dpUHSzuvGOXWfQrZkRHE80Rgo89RlDiJcqz
X-Google-Smtp-Source: AGHT+IGy64r2d4BwPGWPUsFPOuC+QekB2FZvVFvv+nAYGDgwB8ne+RjEFxW/5fvDEMLff0SYAC5jYA==
X-Received: by 2002:a05:600c:4447:b0:434:a5bc:70fc with SMTP id 5b1f17b1804b1-434a9dc3c8emr76193385e9.8.1732815066393;
        Thu, 28 Nov 2024 09:31:06 -0800 (PST)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:b89d:29e9:7047:2d6f])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-434b0dc63f7sm27845545e9.23.2024.11.28.09.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 09:31:05 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Thu, 28 Nov 2024 18:30:42 +0100
Subject: [PATCH v2] clk: amlogic: axg-audio: revert reset implementation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241128-clk-audio-fix-rst-missing-v2-1-cf437d1a73da@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAMGoSGcC/42NTQ6CMBCFr0Jm7Zi2EqWuvIdh0T9gIlDSQSIh3
 N3KCVx+L+99bwMOiQLDvdgghYWY4phBnQpwnRnbgOQzgxKqlFLd0PUvNG9PERv6YOIZB2KmsUV
 hK3FVldeX0kLeTynkyuF+1pk74jmm9bha5C/9x7pIlKgb7YWxumpceFiz9mRTOLs4QL3v+xe+3
 Tq+xQAAAA==
X-Change-ID: 20241127-clk-audio-fix-rst-missing-0b80628d934b
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Arnd Bergmann <arnd@arndb.de>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6830; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=aLEeckbAOzstWQ8GqyUU0U1ON+1IQGvGuu+IScVtjTA=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBnSKjY9lg4Iso/jCF+n+X/G+qgZmozzC246Ji7j
 N/NN1afzIuJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCZ0io2AAKCRDm/A8cN/La
 hTEHEACAjx33XZCOL9voJIHp6Y+XOVDEiu7pZdppFk0QxnXtDHuCuuxqVxPShihgKbOuHmiCGl2
 K9s7KWxhU654c4CmjJzt/pDl6CfY5D8ysjwzI3Fbq6n8xvjpjL5QlXJhos4trCJr+xaBSVx970w
 ZKFYj8UWvkqq7cE3pQJPbsYckndk4ZEcplo6mTtnP5ePX/i/HusZsAPr9CTAUjY8Gt9oG3Nv5OE
 +RMp7Sh/HoccpH2svTDo9gXD15zWyL6jU4BhJcWdpMRrFZ8xyA+hZ2/yt1W34CHd8mB6VYsbcov
 y0bcvlZmgTIMZeqtER6GfwcZL4NlEwEnAeP4Ew+I07I2XRVCyv2catmuDjFqREZXkyE/H2CG5hH
 ybO+q/yqTAmRJmWNcSQmw9gMOdw9EeafxIK13nZBZ/JtmjgwnEGQgE71VdqDcQyyBSz0FIker6/
 9xmekeIlOFStPBc5ot1P8NrpT8nQz+DwyBwg1rVmL/tbxe6QeTosWqhUxZa3/JyeHWetCe1n0cz
 aZoY9bljfS3Emsj+fxew40Ru6LqCxAv8E01HUxQzgXE0MJFgDOU3u1ik7Vfhng7YkYeDP4QTS/c
 tgBbMV7lImQUEVlmG9CrjpsSVQaFRjl3LmReMhUdolJtBboYjIMEX/3J1HDgregJ1I4M8HHHAQo
 HLn79faeNBv+Ycw==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

The audio subsystem of axg based platform is not probing anymore.
This is due to the introduction of RESET_MESON_AUX and the config
not being enabled with the default arm64 defconfig.

This brought another discussion around proper decoupling between
the clock and reset part. While this discussion gets sorted out,
revert back to the initial implementation.

This reverts
 * commit 681ed497d676 ("clk: amlogic: axg-audio: fix Kconfig dependency on RESET_MESON_AUX")
 * commit 664988eb47dd ("clk: amlogic: axg-audio: use the auxiliary reset driver")

Both are reverted with single change to avoid creating more compilation
problems.

Fixes: 681ed497d676 ("clk: amlogic: axg-audio: fix Kconfig dependency on RESET_MESON_AUX")
Cc: Arnd Bergmann <arnd@arndb.de>
Reported-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
Changes in v2:
- Drop symbol selection and revert to the previous implementation
- Link to v1: https://lore.kernel.org/r/20241127-clk-audio-fix-rst-missing-v1-1-9f9d0ab98fce@baylibre.com

Hello Stephen,
This fixes a problem introduced in this merge window.
Could you please take it directly ?

Thanks
---

---
 drivers/clk/meson/Kconfig     |   2 +-
 drivers/clk/meson/axg-audio.c | 109 ++++++++++++++++++++++++++++++++++++++----
 2 files changed, 101 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
index febb5d7348ff07c2da0cb5fd41d2ad2607e5bd5d..be2e3a5f83363b07cdcec2601acf15780ff24892 100644
--- a/drivers/clk/meson/Kconfig
+++ b/drivers/clk/meson/Kconfig
@@ -106,7 +106,7 @@ config COMMON_CLK_AXG_AUDIO
 	select COMMON_CLK_MESON_SCLK_DIV
 	select COMMON_CLK_MESON_CLKC_UTILS
 	select REGMAP_MMIO
-	depends on RESET_MESON_AUX
+	select RESET_CONTROLLER
 	help
 	  Support for the audio clock controller on AmLogic A113D devices,
 	  aka axg, Say Y if you want audio subsystem to work.
diff --git a/drivers/clk/meson/axg-audio.c b/drivers/clk/meson/axg-audio.c
index 7714bde5ffc038a7a36d267a7149bc9f4e820be2..beda86349389990065954300369e5daa360856c9 100644
--- a/drivers/clk/meson/axg-audio.c
+++ b/drivers/clk/meson/axg-audio.c
@@ -15,8 +15,6 @@
 #include <linux/reset-controller.h>
 #include <linux/slab.h>
 
-#include <soc/amlogic/reset-meson-aux.h>
-
 #include "meson-clkc-utils.h"
 #include "axg-audio.h"
 #include "clk-regmap.h"
@@ -1680,6 +1678,84 @@ static struct clk_regmap *const sm1_clk_regmaps[] = {
 	&sm1_earcrx_dmac_clk,
 };
 
+struct axg_audio_reset_data {
+	struct reset_controller_dev rstc;
+	struct regmap *map;
+	unsigned int offset;
+};
+
+static void axg_audio_reset_reg_and_bit(struct axg_audio_reset_data *rst,
+					unsigned long id,
+					unsigned int *reg,
+					unsigned int *bit)
+{
+	unsigned int stride = regmap_get_reg_stride(rst->map);
+
+	*reg = (id / (stride * BITS_PER_BYTE)) * stride;
+	*reg += rst->offset;
+	*bit = id % (stride * BITS_PER_BYTE);
+}
+
+static int axg_audio_reset_update(struct reset_controller_dev *rcdev,
+				unsigned long id, bool assert)
+{
+	struct axg_audio_reset_data *rst =
+		container_of(rcdev, struct axg_audio_reset_data, rstc);
+	unsigned int offset, bit;
+
+	axg_audio_reset_reg_and_bit(rst, id, &offset, &bit);
+
+	regmap_update_bits(rst->map, offset, BIT(bit),
+			assert ? BIT(bit) : 0);
+
+	return 0;
+}
+
+static int axg_audio_reset_status(struct reset_controller_dev *rcdev,
+				unsigned long id)
+{
+	struct axg_audio_reset_data *rst =
+		container_of(rcdev, struct axg_audio_reset_data, rstc);
+	unsigned int val, offset, bit;
+
+	axg_audio_reset_reg_and_bit(rst, id, &offset, &bit);
+
+	regmap_read(rst->map, offset, &val);
+
+	return !!(val & BIT(bit));
+}
+
+static int axg_audio_reset_assert(struct reset_controller_dev *rcdev,
+				unsigned long id)
+{
+	return axg_audio_reset_update(rcdev, id, true);
+}
+
+static int axg_audio_reset_deassert(struct reset_controller_dev *rcdev,
+				unsigned long id)
+{
+	return axg_audio_reset_update(rcdev, id, false);
+}
+
+static int axg_audio_reset_toggle(struct reset_controller_dev *rcdev,
+				unsigned long id)
+{
+	int ret;
+
+	ret = axg_audio_reset_assert(rcdev, id);
+	if (ret)
+		return ret;
+
+	return axg_audio_reset_deassert(rcdev, id);
+}
+
+static const struct reset_control_ops axg_audio_rstc_ops = {
+	.assert = axg_audio_reset_assert,
+	.deassert = axg_audio_reset_deassert,
+	.reset = axg_audio_reset_toggle,
+	.status = axg_audio_reset_status,
+};
+
 static struct regmap_config axg_audio_regmap_cfg = {
 	.reg_bits	= 32,
 	.val_bits	= 32,
@@ -1690,14 +1766,16 @@ struct audioclk_data {
 	struct clk_regmap *const *regmap_clks;
 	unsigned int regmap_clk_num;
 	struct meson_clk_hw_data hw_clks;
+	unsigned int reset_offset;
+	unsigned int reset_num;
 	unsigned int max_register;
-	const char *rst_drvname;
 };
 
 static int axg_audio_clkc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	const struct audioclk_data *data;
+	struct axg_audio_reset_data *rst;
 	struct regmap *map;
 	void __iomem *regs;
 	struct clk_hw *hw;
@@ -1756,11 +1834,22 @@ static int axg_audio_clkc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	/* Register auxiliary reset driver when applicable */
-	if (data->rst_drvname)
-		ret = devm_meson_rst_aux_register(dev, map, data->rst_drvname);
+	/* Stop here if there is no reset */
+	if (!data->reset_num)
+		return 0;
+
+	rst = devm_kzalloc(dev, sizeof(*rst), GFP_KERNEL);
+	if (!rst)
+		return -ENOMEM;
+
+	rst->map = map;
+	rst->offset = data->reset_offset;
+	rst->rstc.nr_resets = data->reset_num;
+	rst->rstc.ops = &axg_audio_rstc_ops;
+	rst->rstc.of_node = dev->of_node;
+	rst->rstc.owner = THIS_MODULE;
 
-	return ret;
+	return devm_reset_controller_register(dev, &rst->rstc);
 }
 
 static const struct audioclk_data axg_audioclk_data = {
@@ -1780,8 +1869,9 @@ static const struct audioclk_data g12a_audioclk_data = {
 		.hws = g12a_audio_hw_clks,
 		.num = ARRAY_SIZE(g12a_audio_hw_clks),
 	},
+	.reset_offset = AUDIO_SW_RESET,
+	.reset_num = 26,
 	.max_register = AUDIO_CLK_SPDIFOUT_B_CTRL,
-	.rst_drvname = "rst-g12a",
 };
 
 static const struct audioclk_data sm1_audioclk_data = {
@@ -1791,8 +1881,9 @@ static const struct audioclk_data sm1_audioclk_data = {
 		.hws = sm1_audio_hw_clks,
 		.num = ARRAY_SIZE(sm1_audio_hw_clks),
 	},
+	.reset_offset = AUDIO_SM1_SW_RESET0,
+	.reset_num = 39,
 	.max_register = AUDIO_EARCRX_DMAC_CLK_CTRL,
-	.rst_drvname = "rst-sm1",
 };
 
 static const struct of_device_id clkc_match_table[] = {

---
base-commit: 6f3d2b5299b0a8bcb8a9405a8d3fceb24f79c4f0
change-id: 20241127-clk-audio-fix-rst-missing-0b80628d934b

Best regards,
-- 
Jerome


