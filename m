Return-Path: <linux-kernel+bounces-363810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB6099C757
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 12:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68142B25159
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 10:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF57518B49A;
	Mon, 14 Oct 2024 10:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="dOvYlM1i"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61111176AAD
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 10:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728902635; cv=none; b=A6oChM2M695f8kFFjyPMpClPOmFGWkSWclF4NJmthcAtEtN6xLuYg0YdP9CmrF3+8oZc/AcheuvCD95Y19Il5+qmww5G/R2JxUv9hXDgBVwBlsZCnIjtCCVdNb+Qok0caD/hyNSJDLfYEQ10JJ2Lu4P7dd5J26C613AMGu9UMAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728902635; c=relaxed/simple;
	bh=6GnEMjv9A1rOAsaEbhfshb92b7br+b3sHz5TFij7rIk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cPG8x6Htr1E6dOieoa8ch1wn1pVEE3GyeN9Nr+1T0GjSmX1zbO/JjL30PPgz0PDDCqbPsEaHXexjrikaCx1zo3YvHOuy2+okcXgqB/S0uRIhpsMt3TDUqGnjBNZnuUbP2g5zZzxSv+kmpSYkWgQ1hGtAMcpEVgGjVarVqxhIFQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=dOvYlM1i; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1728902629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5ZNAPlbASWAkNDdmTnghKvANDJ6bL58Kr9lbnrNo7dk=;
	b=dOvYlM1iWj/jRzuKuXPGVNVZ0ULQJeOK1G2ZF2LevpQIm8/+GUQsG24gWbUs+RBCl0uVA1
	5ggpUrY6Uqa9AU4k76TzkrUFegOLNz1/gzwr//G/gmflZ9DRkAODZJeFAQMltqdqEZX90o
	9xGnjrFFQkvrNbjKZ+uQ7fJe2dVDkv018I/16Ktr3CZ3XGNReR4U5T66wSSYJjosSoLwYh
	O0aHCfCS1TQpYte5bT8c9rz/NksjCblApv0pzdZ5OlXi2qPZg2y8NPzoYZxyqhV8wTDsHF
	/Ocn5KA2TqMy9YUJzhg9u8t/jr9onaFIaXYYip0vrtxoo1OySaOixI3rDLXvdQ==
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] regulator: rk808: Perform trivial code cleanups
Date: Mon, 14 Oct 2024 12:43:39 +0200
Message-Id: <ac44aefcc7b3adbd8dcc5654a5ef8c493ce21ea0.1728902488.git.dsimic@manjaro.org>
In-Reply-To: <cover.1728902488.git.dsimic@manjaro.org>
References: <cover.1728902488.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Perform a few trivial code cleanups, to improve the accuracy and wording of
a couple of comments and the module description, and to avoid line wrapping
in a few places by using the 100-column width a bit better.

No intended functional changes are introduced by these code cleanups.

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 drivers/regulator/rk808-regulator.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/regulator/rk808-regulator.c b/drivers/regulator/rk808-regulator.c
index 14b60abd6afc..e81dbb14a29e 100644
--- a/drivers/regulator/rk808-regulator.c
+++ b/drivers/regulator/rk808-regulator.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Regulator driver for Rockchip RK805/RK808/RK818
+ * Regulator driver for Rockchip RK80x and RK81x PMIC series
  *
  * Copyright (c) 2014, Fuzhou Rockchip Electronics Co., Ltd
  * Copyright (c) 2021 Rockchip Electronics Co., Ltd.
@@ -23,7 +23,7 @@
 #include <linux/regulator/of_regulator.h>
 #include <linux/gpio/consumer.h>
 
-/* Field Definitions */
+/* Field definitions */
 #define RK808_BUCK_VSEL_MASK	0x3f
 #define RK808_BUCK4_VSEL_MASK	0xf
 #define RK808_LDO_VSEL_MASK	0x1f
@@ -1829,36 +1829,33 @@ static const struct regulator_desc rk818_reg[] = {
 		RK818_DCDC_EN_REG, BIT(7)),
 };
 
-static int rk808_regulator_dt_parse_pdata(struct device *dev,
-				   struct regmap *map,
-				   struct rk808_regulator_data *pdata)
+static int rk808_regulator_dt_parse_pdata(struct device *dev, struct regmap *map,
+					  struct rk808_regulator_data *pdata)
 {
 	struct device_node *np;
 	int tmp, ret = 0, i;
 
 	np = of_get_child_by_name(dev->of_node, "regulators");
 	if (!np)
 		return -ENXIO;
 
 	for (i = 0; i < ARRAY_SIZE(pdata->dvs_gpio); i++) {
 		pdata->dvs_gpio[i] =
-			devm_gpiod_get_index_optional(dev, "dvs", i,
-						      GPIOD_OUT_LOW);
+			devm_gpiod_get_index_optional(dev, "dvs", i, GPIOD_OUT_LOW);
 		if (IS_ERR(pdata->dvs_gpio[i])) {
 			ret = PTR_ERR(pdata->dvs_gpio[i]);
 			dev_err(dev, "failed to get dvs%d gpio (%d)\n", i, ret);
 			goto dt_parse_end;
 		}
 
 		if (!pdata->dvs_gpio[i]) {
 			dev_info(dev, "there is no dvs%d gpio\n", i);
 			continue;
 		}
 
 		tmp = i ? RK808_DVS2_POL : RK808_DVS1_POL;
 		ret = regmap_update_bits(map, RK808_IO_POL_REG, tmp,
-				gpiod_is_active_low(pdata->dvs_gpio[i]) ?
-				0 : tmp);
+					 gpiod_is_active_low(pdata->dvs_gpio[i]) ? 0 : tmp);
 	}
 
 dt_parse_end:
@@ -1954,7 +1951,7 @@ static struct platform_driver rk808_regulator_driver = {
 
 module_platform_driver(rk808_regulator_driver);
 
-MODULE_DESCRIPTION("regulator driver for the RK805/RK808/RK818 series PMICs");
+MODULE_DESCRIPTION("Rockchip RK80x/RK81x PMIC series regulator driver");
 MODULE_AUTHOR("Tony xie <tony.xie@rock-chips.com>");
 MODULE_AUTHOR("Chris Zhong <zyw@rock-chips.com>");
 MODULE_AUTHOR("Zhang Qing <zhangqing@rock-chips.com>");

