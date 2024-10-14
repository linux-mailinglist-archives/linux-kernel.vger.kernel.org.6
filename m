Return-Path: <linux-kernel+bounces-363811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 339D999C758
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 12:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B5FD1C22484
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 10:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7401946C2;
	Mon, 14 Oct 2024 10:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Mr8Ee5t8"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784BE176AD0
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 10:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728902635; cv=none; b=G76s/qMWKkx3QrMWPSfugDCqAv5VIdqvihqXCS/HtDfr/yy1OuKKH5Od71ridJVabgWkTU6MPJzPECtLLYVbgp0o2feTpsjTp093Hp+flgqg3SJZC+uUNI0Hpc+VDXMIK9/GdLwye5alp9RFgwKQ7/pOBf+JWOt6LD8/M0UFznw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728902635; c=relaxed/simple;
	bh=hwfFAv99fL9/EdRWkxzKoLnbjOJZ8rfi5Y81CvaYfYE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i7CZuzVOKD0bYsP6TLdj7uZ/qmZAc7IXXUaHhGoBNdyikoCTW22On9h6ZaoqMwLoktGo+VYBIX+FRORMAbePcRQBjpp666isI8KB8TnFiphsBZmcU6y4xtOeuirO7lH6FaLcnrZQWhol7NJwJt6RbtqJKhVbF1ugHKjCjp4CdII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=Mr8Ee5t8; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1728902630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OJI6FD5j4PqYdR+2XIK8jcifYw4g5S3Dr/YL2YwHxD4=;
	b=Mr8Ee5t8sx6kRSTgiFM3BtvBUTDxC51GCurWp9W93+pKAq6KG8nzlm6mPhUa5OrV1rCtG6
	dpk2BMbXgu0JcWi2nyAl5QiZQABzH1qYoMtSHGsBz31dPHf64j8UjJwYzNAMm6E6ERkkpF
	nlEd+WWCv5ts0rz3umF1Mwxx666/PYHMW6hKSpBTJq5ALfmAOA+cVJkIFTpp8hY2vI1uG2
	X2yeNohSwe59Qltilf2REvwAogWNnjWa9abaw5D22K6AsHmvuiwGmzw/oMVlvJidsHyMwe
	PCyRibFpVeFlIJLUGPEIUNJtveg0eD28vF2sDCGyhoIm7YJPuZUIlCuK6gBRFQ==
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Diederik de Haas <didi.debian@cknow.org>
Subject: [PATCH 3/3] regulator: rk808: Restrict DVS GPIOs to the RK808 variant only
Date: Mon, 14 Oct 2024 12:43:41 +0200
Message-Id: <9a415c59699e76fc7b88a2552520a4ca2538f44e.1728902488.git.dsimic@manjaro.org>
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

The rk808-regulator driver supports multiple PMIC variants from the Rockckip
RK80x and RK81x series, but the DVS GPIOs are supported on the RK808 variant
only, according to the DT bindings [1][2][3][4][5][6] and the datasheets for
the supported PMIC variants. [7][8][9][10][11][12]

Thus, change the probe path so the "dvs-gpios" property is checked for and
its value possibly used only when the handled PMIC variant is RK808.  There's
no point in doing that on the other PMIC variants, because they don't support
the DVS GPIOs, and it goes against the DT bindings to allow a possible out-
of-place "dvs-gpios" property to actually be handled in the driver.

This eliminates the following messages, emitted when the "dvs-gpios" property
isn't found in the DT, from the kernel log on boards that actually don't use
the RK808 variant, which may have provided a source of confusion:

  rk808-regulator rk808-regulator.2.auto: there is no dvs0 gpio
  rk808-regulator rk808-regulator.2.auto: there is no dvs1 gpio

Furthermore, demote these kernel messages to debug messages, because they are
useful during the board bringup phase only.  Emitting them afterwards, on the
boards that use the RK808 variant, but actually don't use the DVS0/1 GPIOs,
clutters the kernel log a bit, while they provide no value and may actually
cause false impression that some PMIC-related issues are present.

[1] Documentation/devicetree/bindings/mfd/rockchip,rk805.yaml
[2] Documentation/devicetree/bindings/mfd/rockchip,rk806.yaml
[3] Documentation/devicetree/bindings/mfd/rockchip,rk808.yaml
[4] Documentation/devicetree/bindings/mfd/rockchip,rk816.yaml
[5] Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml
[6] Documentation/devicetree/bindings/mfd/rockchip,rk818.yaml
[7] https://rockchip.fr/RK805%20datasheet%20V1.2.pdf
[8] https://wmsc.lcsc.com/wmsc/upload/file/pdf/v2/lcsc/2401261533_Rockchip-RK806-1_C5156483.pdf
[9] https://rockchip.fr/RK808%20datasheet%20V1.4.pdf
[10] https://rockchip.fr/RK816%20datasheet%20V1.3.pdf
[11] https://rockchip.fr/RK817%20datasheet%20V1.01.pdf
[12] https://rockchip.fr/RK818%20datasheet%20V1.0.pdf

Fixes: 11375293530b ("regulator: rk808: Add regulator driver for RK818")
Reported-by: Diederik de Haas <didi.debian@cknow.org>
Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 drivers/regulator/rk808-regulator.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/regulator/rk808-regulator.c b/drivers/regulator/rk808-regulator.c
index f241bb538e27..76f9a426450d 100644
--- a/drivers/regulator/rk808-regulator.c
+++ b/drivers/regulator/rk808-regulator.c
@@ -1849,7 +1849,7 @@ static int rk808_regulator_dt_parse_pdata(struct device *dev, struct regmap *map
 		}
 
 		if (!pdata->dvs_gpio[i]) {
-			dev_info(dev, "there is no dvs%d gpio\n", i);
+			dev_dbg(dev, "there is no dvs%d gpio\n", i);
 			continue;
 		}
 
@@ -1884,22 +1884,21 @@ static int rk808_regulator_probe(struct platform_device *pdev)
 	if (!pdata)
 		return -ENOMEM;
 
-	ret = rk808_regulator_dt_parse_pdata(&pdev->dev, regmap, pdata);
-	if (ret < 0)
-		return ret;
-
-	platform_set_drvdata(pdev, pdata);
-
 	switch (rk808->variant) {
 	case RK805_ID:
 		regulators = rk805_reg;
 		nregulators = RK805_NUM_REGULATORS;
 		break;
 	case RK806_ID:
 		regulators = rk806_reg;
 		nregulators = ARRAY_SIZE(rk806_reg);
 		break;
 	case RK808_ID:
+		/* DVS0/1 GPIOs are supported on the RK808 only */
+		ret = rk808_regulator_dt_parse_pdata(&pdev->dev, regmap, pdata);
+		if (ret < 0)
+			return ret;
+
 		regulators = rk808_reg;
 		nregulators = RK808_NUM_REGULATORS;
 		break;
@@ -1924,6 +1923,8 @@ static int rk808_regulator_probe(struct platform_device *pdev)
 				     "unsupported RK8xx ID %lu\n", rk808->variant);
 	}
 
+	platform_set_drvdata(pdev, pdata);
+
 	config.dev = &pdev->dev;
 	config.driver_data = pdata;
 	config.regmap = regmap;

