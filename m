Return-Path: <linux-kernel+bounces-442223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3179ED989
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 23:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A36702824FE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DBD1F0E46;
	Wed, 11 Dec 2024 22:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="K5XQ3o/f"
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35EB1A841F;
	Wed, 11 Dec 2024 22:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733955736; cv=none; b=MVg3ObkC97WEfXdaVxsABmiWXPOmbSGMi2DRnjcwLtZ65asYo8VqmGFVm3UpUTAU+CanUMw5gy2GpkWP6GuBXTpRaQibsIg1erfpuWqBE/lfVo3lwkgd0ejTefqr1L4IMsz98DhObjM8nnLVvNMCdSxB7xnSC8QGmnm1kQNAu5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733955736; c=relaxed/simple;
	bh=GWtWUSQZPiNLXSEnknV2wpkOsZJTI15wEinuB1XcrCk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W8dqV7CBZBDcfMJ3G3lIVIS4LOhIcVJ5jadhfFD606lchyBpHHlGEHtdoj8CT9cvNzCCJwFF9GAGt6VskrWZG9hAfGcaZ3YbAH2x7mhsJsKf488ru8DtqMX1Hx8HdCauLqdHmEKKwmMuyYuQ0WouwGcbYi8oB+f8aYt1Y7nM2Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=K5XQ3o/f; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 240E3A03B8;
	Wed, 11 Dec 2024 23:22:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=nz4TyTapXzMqxCqKapCIOkriVuwdNpBfQogyQAqNO5U=; b=
	K5XQ3o/flOfsIMGkB0/xwZWBo0yU57mh6R0LLA5a9Kps0ubENp2mRsdi0DKUl2Hv
	w75bGzwlvDSMj4dlKoQUKXmkujGO6ehbsVPsdnfzxh9q1xgftI3dShXSH0H+CZWt
	6Ext/LxKqOkxFhRHE2ZEIveAojinCCKqzuxzq5MmDrlNWR10cOJ3N/XAi0CVS+KS
	Gi+1JaLD37SzTDJC4jl8YHiB34hohS8g5sWsEi7CWHcs7wwVahBDu8ChVkcv00xm
	n06I/jVIUJ8Pd2douQcv0P/h0oVpGIgDB6A+rK2+y5hE7QxbgaS5/MuYSfdvnVpm
	gJleH+K30yGqKJ8oSYA1lhzmUYHCxw8A8wqMvLK3+9uLnajr3dYFndyQtUheJmXO
	Ztnl4pbF5HnxkC5A9dSsbZq9ReaBqoHHq8Q47W90heGN/9hU1dctTIHxZtNMz8CH
	JoElni/DlBxEbj2i1saW3UomxRjYePDrH7IDzH0WA5f5+wCX/BUiJAebht5juJia
	29nfIBUPU45KUvcBYuzjK7c+ensyzAdxPef+q9DZE9pxqwUOU9MK1vQ8vNucUOl4
	DYb2ayR7KDgPYyQZjtbPasiEI9PaCRglUuz7uPEo18/k3pJ9wgfe6wywAvP49no5
	1eSVKByaUcCBu7+p0inCp16dOhfP5g6I4adBbLBjXas=
From: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
To: <linux-sound@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>, "Liam
 Girdwood" <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "Jaroslav
 Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Chen-Yu Tsai
	<wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland
	<samuel@sholland.org>, Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH] ASoC: sun4i-codec: Use new devm clk and reset APIs
Date: Wed, 11 Dec 2024 23:22:05 +0100
Message-ID: <20241211222205.1915027-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1733955729;VERSION=7982;MC=3794370839;ID=394182;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D9485562726B

Clean up error handling by using the new devm_
clock and reset functions. This should make it
easier to add new code, as we can eliminate the
"goto ladder" in probe().

Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
---
 sound/soc/sunxi/sun4i-codec.c | 41 ++++++-----------------------------
 1 file changed, 7 insertions(+), 34 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 3d6156fefe75..b0ca293979d7 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -2273,7 +2273,7 @@ static int sun4i_codec_probe(struct platform_device *pdev)
 	}
 
 	/* Get the clocks from the DT */
-	scodec->clk_apb = devm_clk_get(&pdev->dev, "apb");
+	scodec->clk_apb = devm_clk_get_enabled(&pdev->dev, "apb");
 	if (IS_ERR(scodec->clk_apb)) {
 		dev_err(&pdev->dev, "Failed to get the APB clock\n");
 		return PTR_ERR(scodec->clk_apb);
@@ -2286,8 +2286,7 @@ static int sun4i_codec_probe(struct platform_device *pdev)
 	}
 
 	if (quirks->has_reset) {
-		scodec->rst = devm_reset_control_get_exclusive(&pdev->dev,
-							       NULL);
+		scodec->rst = devm_reset_control_get_exclusive_deasserted(&pdev->dev, NULL);
 		if (IS_ERR(scodec->rst)) {
 			dev_err(&pdev->dev, "Failed to get reset control\n");
 			return PTR_ERR(scodec->rst);
@@ -2323,22 +2322,6 @@ static int sun4i_codec_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	/* Enable the bus clock */
-	if (clk_prepare_enable(scodec->clk_apb)) {
-		dev_err(&pdev->dev, "Failed to enable the APB clock\n");
-		return -EINVAL;
-	}
-
-	/* Deassert the reset control */
-	if (scodec->rst) {
-		ret = reset_control_deassert(scodec->rst);
-		if (ret) {
-			dev_err(&pdev->dev,
-				"Failed to deassert the reset control\n");
-			goto err_clk_disable;
-		}
-	}
-
 	/* DMA configuration for TX FIFO */
 	scodec->playback_dma_data.addr = res->start + quirks->reg_dac_txdata;
 	scodec->playback_dma_data.maxburst = quirks->dma_max_burst;
@@ -2356,7 +2339,7 @@ static int sun4i_codec_probe(struct platform_device *pdev)
 				     &sun4i_codec_dai, 1);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to register our codec\n");
-		goto err_assert_reset;
+		return ret;
 	}
 
 	ret = devm_snd_soc_register_component(&pdev->dev,
@@ -2364,20 +2347,20 @@ static int sun4i_codec_probe(struct platform_device *pdev)
 					      &dummy_cpu_dai, 1);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to register our DAI\n");
-		goto err_assert_reset;
+		return ret;
 	}
 
 	ret = devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to register against DMAEngine\n");
-		goto err_assert_reset;
+		return ret;
 	}
 
 	card = quirks->create_card(&pdev->dev);
 	if (IS_ERR(card)) {
 		ret = PTR_ERR(card);
 		dev_err(&pdev->dev, "Failed to create our card\n");
-		goto err_assert_reset;
+		return ret;
 	}
 
 	snd_soc_card_set_drvdata(card, scodec);
@@ -2385,17 +2368,10 @@ static int sun4i_codec_probe(struct platform_device *pdev)
 	ret = snd_soc_register_card(card);
 	if (ret) {
 		dev_err_probe(&pdev->dev, ret, "Failed to register our card\n");
-		goto err_assert_reset;
+		return ret;
 	}
 
 	return 0;
-
-err_assert_reset:
-	if (scodec->rst)
-		reset_control_assert(scodec->rst);
-err_clk_disable:
-	clk_disable_unprepare(scodec->clk_apb);
-	return ret;
 }
 
 static void sun4i_codec_remove(struct platform_device *pdev)
@@ -2404,9 +2380,6 @@ static void sun4i_codec_remove(struct platform_device *pdev)
 	struct sun4i_codec *scodec = snd_soc_card_get_drvdata(card);
 
 	snd_soc_unregister_card(card);
-	if (scodec->rst)
-		reset_control_assert(scodec->rst);
-	clk_disable_unprepare(scodec->clk_apb);
 }
 
 static struct platform_driver sun4i_codec_driver = {
-- 
2.34.1



