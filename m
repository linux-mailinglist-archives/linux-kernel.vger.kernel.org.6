Return-Path: <linux-kernel+bounces-256150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D7A9349DA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 10:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BA701C22F95
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 08:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C8C7BAF4;
	Thu, 18 Jul 2024 08:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Bn1Q1+n3"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA1E78C89;
	Thu, 18 Jul 2024 08:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721291144; cv=none; b=H9xazhqLUQ5D8FprEGMnGdlv7b9Vq7Tw3GZ4JvDHhw/6CMWJoc3mg1Cs+dToEOzKGeMS18P37I3wxxQqBQZvPhDhsoq0AMhM6dOAwe43GePSHrt6BVSMNQSc/C4G/GGlL7m/6uAfK1xSfilX4C+MYY0WgCyyeyWTNrym90LLSQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721291144; c=relaxed/simple;
	bh=gsCMyNCJn0oMPKaDDmmHARKMV4LsNOy2UpPcFy7z1+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XPX8cLhOIKnU//PpyLdlnTa0fahKekdG+QTIvsmgQ2n2s+B8eIQaxSOtiwmJcEjhJbmHdKOOHS6/nOtaTpwit8ENz4jIf1VZnz8dWPlbkiX2HbiCtCjkF/t+P0gHWMObAa8QHPiilH1o6dcK4jTMnwxf3V4Q2jZUtK0qGJHJWmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Bn1Q1+n3; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721291142;
	bh=gsCMyNCJn0oMPKaDDmmHARKMV4LsNOy2UpPcFy7z1+Q=;
	h=From:To:Cc:Subject:Date:From;
	b=Bn1Q1+n3935Q24tdB0qSaGoPihJ+Pw3KqLgeuYwoQn1b32OiRned5kV7aLOub5Dzy
	 OtCMW974w6slBoRNpjBbenWyeBhnT3gWhJ323FG5FMhSZxOR4File5sy8QzVXVb2Nn
	 4pMPSqnDA2wwmbwUZxtBejC/obffkzd5yhkg7r7OuXpu3n/C1WGvR8JLuWzed4fSti
	 wnVGBbjibn1Q8yjPH2LfoP4G9GpXvwnrOB+h/KKqEV9YPLszo9R9fgtFD6/a11Xf2P
	 m4a3JzhcBNAKZLL4EOh+6umsa5eQRnL4KG7Huy7mMcsXcF/W8Na9NPisazCVOh+SiY
	 swdO4INnTw96Q==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 632023782167;
	Thu, 18 Jul 2024 08:25:41 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: sboyd@kernel.org
Cc: matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	mturquette@baylibre.com,
	p.zabel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-clk@vger.kernel.org,
	kernel@collabora.com
Subject: [PATCH] clk: mediatek: reset: Remove unused mtk_register_reset_controller()
Date: Thu, 18 Jul 2024 10:25:28 +0200
Message-ID: <20240718082528.220750-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that all clock controllers have been migrated to the new
mtk_register_reset_controller_with_dev() function, the one taking
struct device node is now unused: remove it.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/reset.c | 59 ------------------------------------
 drivers/clk/mediatek/reset.h | 10 ------
 2 files changed, 69 deletions(-)

diff --git a/drivers/clk/mediatek/reset.c b/drivers/clk/mediatek/reset.c
index 290ceda84ce4..069f9e909cb0 100644
--- a/drivers/clk/mediatek/reset.c
+++ b/drivers/clk/mediatek/reset.c
@@ -110,65 +110,6 @@ static int reset_xlate(struct reset_controller_dev *rcdev,
 	return data->desc->rst_idx_map[reset_spec->args[0]];
 }
 
-int mtk_register_reset_controller(struct device_node *np,
-				  const struct mtk_clk_rst_desc *desc)
-{
-	struct regmap *regmap;
-	const struct reset_control_ops *rcops = NULL;
-	struct mtk_clk_rst_data *data;
-	int ret;
-
-	if (!desc) {
-		pr_err("mtk clock reset desc is NULL\n");
-		return -EINVAL;
-	}
-
-	switch (desc->version) {
-	case MTK_RST_SIMPLE:
-		rcops = &mtk_reset_ops;
-		break;
-	case MTK_RST_SET_CLR:
-		rcops = &mtk_reset_ops_set_clr;
-		break;
-	default:
-		pr_err("Unknown reset version %d\n", desc->version);
-		return -EINVAL;
-	}
-
-	regmap = device_node_to_regmap(np);
-	if (IS_ERR(regmap)) {
-		pr_err("Cannot find regmap for %pOF: %pe\n", np, regmap);
-		return -EINVAL;
-	}
-
-	data = kzalloc(sizeof(*data), GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
-
-	data->desc = desc;
-	data->regmap = regmap;
-	data->rcdev.owner = THIS_MODULE;
-	data->rcdev.ops = rcops;
-	data->rcdev.of_node = np;
-
-	if (data->desc->rst_idx_map_nr > 0) {
-		data->rcdev.of_reset_n_cells = 1;
-		data->rcdev.nr_resets = desc->rst_idx_map_nr;
-		data->rcdev.of_xlate = reset_xlate;
-	} else {
-		data->rcdev.nr_resets = desc->rst_bank_nr * RST_NR_PER_BANK;
-	}
-
-	ret = reset_controller_register(&data->rcdev);
-	if (ret) {
-		pr_err("could not register reset controller: %d\n", ret);
-		kfree(data);
-		return ret;
-	}
-
-	return 0;
-}
-
 int mtk_register_reset_controller_with_dev(struct device *dev,
 					   const struct mtk_clk_rst_desc *desc)
 {
diff --git a/drivers/clk/mediatek/reset.h b/drivers/clk/mediatek/reset.h
index 6a58a3d59165..562ffd290a22 100644
--- a/drivers/clk/mediatek/reset.h
+++ b/drivers/clk/mediatek/reset.h
@@ -59,16 +59,6 @@ struct mtk_clk_rst_data {
 	const struct mtk_clk_rst_desc *desc;
 };
 
-/**
- * mtk_register_reset_controller - Register MediaTek clock reset controller
- * @np: Pointer to device node.
- * @desc: Constant pointer to description of clock reset.
- *
- * Return: 0 on success and errorno otherwise.
- */
-int mtk_register_reset_controller(struct device_node *np,
-				  const struct mtk_clk_rst_desc *desc);
-
 /**
  * mtk_register_reset_controller - Register mediatek clock reset controller with device
  * @np: Pointer to device.
-- 
2.45.2


