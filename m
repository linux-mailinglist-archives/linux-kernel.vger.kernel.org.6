Return-Path: <linux-kernel+bounces-322305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F22A97270B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 04:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4206D1C23097
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 02:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF78143894;
	Tue, 10 Sep 2024 02:11:19 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8491DFD1;
	Tue, 10 Sep 2024 02:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725934279; cv=none; b=SymcMclaiXAtIpAX9eQOD8lnO9MP4pyonHiAYi6Dukdq0jlVGpWRMbKLfY8/KQc4A5PwIxzqsFUCCOgzx/a4CmqhRQWSOFny4mtu7vY6OssStouRJj32J41SpX3DOhViimIMaB6nrgfLiPkalrhZQi4Pl3ZND5/RGJTsbQpZ/io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725934279; c=relaxed/simple;
	bh=HLUEmBVifcTmtey6LiRMmWSd/FuZ2yJTzExTaEtRCi0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GJlDaf7uEFa4l3095LVQQLoIMAw1kgCBD6LAJtFtkSqy8F41VLsMm/29jYS3eswhUbzGyS7iFL8icrTXy4SfDw5z+l97B69b3K8RSmfljwR6uALo04YLdBNGBbCQZtcyutOKnR8sFc+Z8720VTw8tNdJxHOMfm7hx66rzLI5Q38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee666dfaabe8bb-df17d;
	Tue, 10 Sep 2024 10:11:11 +0800 (CST)
X-RM-TRANSID:2ee666dfaabe8bb-df17d
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.97])
	by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee366dfaabb1f8-709f5;
	Tue, 10 Sep 2024 10:11:11 +0800 (CST)
X-RM-TRANSID:2ee366dfaabb1f8-709f5
From: Tang Bin <tangbin@cmss.chinamobile.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] ASoC: loongson: Add the correct judgement return
Date: Tue, 10 Sep 2024 10:11:04 +0800
Message-Id: <20240910021104.3400-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the function dev_err_probe can simplify code, but
the error return should not be deleted, that is
unreasonable, thus fix it.

Fixes: 3d2528d6c021 ("ASoC: loongson: Simplify with dev_err_probe()")
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 sound/soc/loongson/loongson_card.c    |  6 +++---
 sound/soc/loongson/loongson_i2s_pci.c | 10 +++++-----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/loongson/loongson_card.c b/sound/soc/loongson/loongson_card.c
index 6078cdf09..7379f24d3 100644
--- a/sound/soc/loongson/loongson_card.c
+++ b/sound/soc/loongson/loongson_card.c
@@ -184,16 +184,16 @@ static int loongson_asoc_card_probe(struct platform_device *pdev)
 
 	ret = device_property_read_string(dev, "model", &card->name);
 	if (ret)
-		dev_err_probe(dev, ret, "Error parsing card name\n");
+		return dev_err_probe(dev, ret, "Error parsing card name\n");
 
 	ret = device_property_read_u32(dev, "mclk-fs", &ls_priv->mclk_fs);
 	if (ret)
-		dev_err_probe(dev, ret, "Error parsing mclk-fs\n");
+		return dev_err_probe(dev, ret, "Error parsing mclk-fs\n");
 
 	ret = has_acpi_companion(dev) ? loongson_card_parse_acpi(ls_priv)
 				      : loongson_card_parse_of(ls_priv);
 	if (ret)
-		dev_err_probe(dev, ret, "Error parsing acpi/of properties\n");
+		return dev_err_probe(dev, ret, "Error parsing acpi/of properties\n");
 
 	return devm_snd_soc_register_card(dev, card);
 }
diff --git a/sound/soc/loongson/loongson_i2s_pci.c b/sound/soc/loongson/loongson_i2s_pci.c
index 3872b1d8f..d2d0e5d8c 100644
--- a/sound/soc/loongson/loongson_i2s_pci.c
+++ b/sound/soc/loongson/loongson_i2s_pci.c
@@ -102,7 +102,7 @@ static int loongson_i2s_pci_probe(struct pci_dev *pdev,
 	i2s->regmap = devm_regmap_init_mmio(dev, i2s->reg_base,
 					    &loongson_i2s_regmap_config);
 	if (IS_ERR(i2s->regmap))
-		dev_err_probe(dev, PTR_ERR(i2s->regmap), "regmap_init_mmio failed\n");
+		return dev_err_probe(dev, PTR_ERR(i2s->regmap), "regmap_init_mmio failed\n");
 
 	tx_data = &i2s->tx_dma_data;
 	rx_data = &i2s->rx_dma_data;
@@ -115,15 +115,15 @@ static int loongson_i2s_pci_probe(struct pci_dev *pdev,
 
 	tx_data->irq = fwnode_irq_get_byname(fwnode, "tx");
 	if (tx_data->irq < 0)
-		dev_err_probe(dev, tx_data->irq, "dma tx irq invalid\n");
+		return dev_err_probe(dev, tx_data->irq, "dma tx irq invalid\n");
 
 	rx_data->irq = fwnode_irq_get_byname(fwnode, "rx");
 	if (rx_data->irq < 0)
-		dev_err_probe(dev, rx_data->irq, "dma rx irq invalid\n");
+		return dev_err_probe(dev, rx_data->irq, "dma rx irq invalid\n");
 
 	ret = device_property_read_u32(dev, "clock-frequency", &i2s->clk_rate);
 	if (ret)
-		dev_err_probe(dev, ret, "clock-frequency property invalid\n");
+		return dev_err_probe(dev, ret, "clock-frequency property invalid\n");
 
 	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
 
@@ -135,7 +135,7 @@ static int loongson_i2s_pci_probe(struct pci_dev *pdev,
 	ret = devm_snd_soc_register_component(dev, &loongson_i2s_component,
 					      &loongson_i2s_dai, 1);
 	if (ret)
-		dev_err_probe(dev, ret, "register DAI failed\n");
+		return dev_err_probe(dev, ret, "register DAI failed\n");
 
 	return 0;
 }
-- 
2.33.0




