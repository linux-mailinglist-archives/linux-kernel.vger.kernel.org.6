Return-Path: <linux-kernel+bounces-237718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 150E2923D1B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 14:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 475861C22B48
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 12:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC43615B10F;
	Tue,  2 Jul 2024 12:02:36 +0000 (UTC)
Received: from cmccmta1.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD6D1C686;
	Tue,  2 Jul 2024 12:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719921756; cv=none; b=EZL8vrohQGvXWU8CnL8iWt7ddsPblEhYzh/D2fBwfHI+kBlk5vtutMSnxYcesr9emijksDnVahRx/kNnRRt5C630lIoU1YEGXGpU2rgZFrsHDIRRj1/OBqNxXJ0CTbup++Juo/0O7LDm1CpGxKbzPAo82tkkonR+ypayvt3//G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719921756; c=relaxed/simple;
	bh=fOBTd6vK4Wl3rRRMzFrMhBEU+PiOZ3K1qzb18PIshVI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=spmhaDu9FDj8zAYKhbNI///ykNmIqkJHPgDTtYRA5IyiAPe7Qpqx9/o5SCE0SPp6tKVxwP9T+OIIL3Vgs+9/5a9qUtQZITxJsDDJCuqDCpHZ5hY0rUPDZlQlyHDMW62Xh0MLVcYo3Hrq0CEK/0VJQOIVpTOPEHZQXiSIj9EQNxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee46683ec48ad9-bb3c7;
	Tue, 02 Jul 2024 20:02:20 +0800 (CST)
X-RM-TRANSID:2ee46683ec48ad9-bb3c7
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.99])
	by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea6683ec4be50-965e6;
	Tue, 02 Jul 2024 20:02:20 +0800 (CST)
X-RM-TRANSID:2eea6683ec4be50-965e6
From: Liu Jing <liujing@cmss.chinamobile.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	kuninori.morimoto.gx@renesas.com,
	bartosz.golaszewski@linaro.org,
	linus.walleij@linaro.org
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	liujing@cmss.chinamobile.com
Subject: [PATCH] ASoC: mediatek: mt2701-cs42448: Optimize redundant code in mt2701_cs42448_machine_probe
Date: Tue,  2 Jul 2024 12:36:56 +0800
Message-Id: <20240702043656.11278-1-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Utilize the defined parameter 'dev' to make the code cleaner.

Signed-off-by: Liu Jing <liujing@cmss.chinamobile.com>
---
 sound/soc/mediatek/mt2701/mt2701-cs42448.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/mediatek/mt2701/mt2701-cs42448.c b/sound/soc/mediatek/mt2701/mt2701-cs42448.c
index 1262e8a1bc9a..4974b0536b7b 100644
--- a/sound/soc/mediatek/mt2701/mt2701-cs42448.c
+++ b/sound/soc/mediatek/mt2701/mt2701-cs42448.c
@@ -329,10 +329,10 @@ static int mt2701_cs42448_machine_probe(struct platform_device *pdev)
 	int ret;
 	int i;
 	struct device_node *platform_node, *codec_node, *codec_node_bt_mrg;
+	struct device *dev = &pdev->dev;
 	struct mt2701_cs42448_private *priv =
-		devm_kzalloc(&pdev->dev, sizeof(struct mt2701_cs42448_private),
+		devm_kzalloc(dev, sizeof(struct mt2701_cs42448_private),
 			     GFP_KERNEL);
-	struct device *dev = &pdev->dev;
 	struct snd_soc_dai_link *dai_link;
 
 	if (!priv)
@@ -341,7 +341,7 @@ static int mt2701_cs42448_machine_probe(struct platform_device *pdev)
 	platform_node = of_parse_phandle(pdev->dev.of_node,
 					 "mediatek,platform", 0);
 	if (!platform_node) {
-		dev_err(&pdev->dev, "Property 'platform' missing or invalid\n");
+		dev_err(dev, "Property 'platform' missing or invalid\n");
 		return -EINVAL;
 	}
 	for_each_card_prelinks(card, i, dai_link) {
@@ -355,7 +355,7 @@ static int mt2701_cs42448_machine_probe(struct platform_device *pdev)
 	codec_node = of_parse_phandle(pdev->dev.of_node,
 				      "mediatek,audio-codec", 0);
 	if (!codec_node) {
-		dev_err(&pdev->dev,
+		dev_err(dev,
 			"Property 'audio-codec' missing or invalid\n");
 		return -EINVAL;
 	}
@@ -368,7 +368,7 @@ static int mt2701_cs42448_machine_probe(struct platform_device *pdev)
 	codec_node_bt_mrg = of_parse_phandle(pdev->dev.of_node,
 					     "mediatek,audio-codec-bt-mrg", 0);
 	if (!codec_node_bt_mrg) {
-		dev_err(&pdev->dev,
+		dev_err(dev,
 			"Property 'audio-codec-bt-mrg' missing or invalid\n");
 		return -EINVAL;
 	}
@@ -377,7 +377,7 @@ static int mt2701_cs42448_machine_probe(struct platform_device *pdev)
 
 	ret = snd_soc_of_parse_audio_routing(card, "audio-routing");
 	if (ret) {
-		dev_err(&pdev->dev, "failed to parse audio-routing: %d\n", ret);
+		dev_err(dev, "failed to parse audio-routing: %d\n", ret);
 		return ret;
 	}
 
@@ -395,10 +395,10 @@ static int mt2701_cs42448_machine_probe(struct platform_device *pdev)
 
 	snd_soc_card_set_drvdata(card, priv);
 
-	ret = devm_snd_soc_register_card(&pdev->dev, card);
+	ret = devm_snd_soc_register_card(dev, card);
 
 	if (ret)
-		dev_err(&pdev->dev, "%s snd_soc_register_card fail %d\n",
+		dev_err(dev, "%s snd_soc_register_card fail %d\n",
 			__func__, ret);
 	return ret;
 }
-- 
2.33.0




