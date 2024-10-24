Return-Path: <linux-kernel+bounces-379296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A379ADC9C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 08:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA47CB22CA8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 06:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113111ABEC2;
	Thu, 24 Oct 2024 06:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="Lw33F5ui"
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B7C18A931;
	Thu, 24 Oct 2024 06:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729752667; cv=none; b=uRUkW+48JPEn62xbciiP5dcfapKNVsDMRmsJTG9w+V1A64qliVyaTErFMKZxuYTsQ8Gkg0zgUdmVdYVvROHnHn55Y/GJZz7BCxdR27VXypPy3GGGzPw+0dj8mD1DVm/L26EvGPrMZoRmditdL5SIjSlYwcfLR51/K6Kp5e9wO2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729752667; c=relaxed/simple;
	bh=w3catqLpXtoFkw7ownnumftVCMa6Ti/UpNuxaLJovec=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o7VzVGs8PyoeAiE+byJAHhAbPeowtTI7q7EYUCFj+i2FvTWt/bNoXbT2x2Z5tSE/W5sCt8wQfqhCl2DFJORp842BjUrRFGFWSshFcgjwlYNM/9AuVBIKEh+AqBfZNYnLpPfz3Yae22mfewWsxII5jQIbEL2Hz3Is8RRDMVPrWZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=Lw33F5ui; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 6783BA0767;
	Thu, 24 Oct 2024 08:50:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=1DAimrnmPrGVcs+dO6bp
	OYED/+XihqEkuNp6uC83mhg=; b=Lw33F5uiObI/m7yT6LVT8p8F3FZ6F8RGZ09E
	5xkJqOWbrDxowYtLZzrsbExO5+YWnBArjGlD7gYpXardFTQ2hwKhsnevZKxOMowO
	fzjM7VuDfhihPDoAs1yvv5y6AQSvI3bz2oigM24Ibxn7nJnXQMufxDbDPQmbLGHx
	POGbpN2g41L21eeIDWrBqQheR/ilgHmosncQYKHJ5tmqRKc5e3wwpd5Pe08EtJUZ
	yugUnNhjJAqgkLT40dtoGfn4QX6mJrWjrt0AcMNVAi125zJkxnen1R7HRx88t2TI
	qzU9LXRgCWj07bbEwMn4pXBRL4Jf22Ufize872vbJZ79qvVlGJdsIdrq+KNDrtnv
	bois/NyMwpYf0UIxRot52nbkdw89BovTSk2On8tn3T+Bd9X5tgwvrj8H5+KPn1GI
	gMEGIM/ULrKr9Ya0gknApaxfMZyrpB6vRc3iVGk4Rz2MGVI+QNKiDh7N7IBzxP8G
	lW1IbIhGSc2qydr2kFdAQTqAQo2Pt7psYHCfKCvW3+E4v3hUO98KuXq90DEGKK4X
	Tr6N0TTnfBXhGYY4Jf3d12ysfHsGZnMmLrktBojdRgRuArYWilRXW0bOPPLYurfC
	7FpMjiW0oEkNWQkQm12ukK0H3re8jYx9pwnqjcs9EOwBo7liKdjm/zhgt+5zNPjV
	2Cnx4Gs=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <linux-sound@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: Mesih Kilinc <mesihkilinc@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, "Takashi
 Iwai" <tiwai@suse.com>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
	<jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>
Subject: [PATCH 06/10] ASoC: sun4i-codec: Add DMA Max Burst field
Date: Thu, 24 Oct 2024 08:49:27 +0200
Message-ID: <20241024064931.1144605-7-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <13ab5cec-25e5-4e82-b956-5c154641d7ab@prolan.hu>
References:
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1729752653;VERSION=7978;MC=1098937437;ID=135553;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD94855677065

From: Mesih Kilinc <mesihkilinc@gmail.com>

Allwinner suniv F1C100s has similar DMA engine to sun4i but it has
smaller max burst size compared to sun4i. Add a quirk field to
differantitate between them.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
---
 sound/soc/sunxi/sun4i-codec.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 330bc0c09f56..4953b5013c58 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -228,6 +228,8 @@
 
 /* TODO H3 DAP (Digital Audio Processing) bits */
 
+#define SUN4I_DMA_MAX_BURST			(8)
+
 struct sun4i_codec {
 	struct device	*dev;
 	struct regmap	*regmap;
@@ -1568,6 +1570,7 @@ struct sun4i_codec_quirks {
 	unsigned int reg_dac_txdata;	/* TX FIFO offset for DMA config */
 	unsigned int reg_adc_rxdata;	/* RX FIFO offset for DMA config */
 	bool has_reset;
+	u32 dma_max_burst;
 };
 
 static const struct sun4i_codec_quirks sun4i_codec_quirks = {
@@ -1577,6 +1580,7 @@ static const struct sun4i_codec_quirks sun4i_codec_quirks = {
 	.reg_adc_fifoc	= REG_FIELD(SUN4I_CODEC_ADC_FIFOC, 0, 31),
 	.reg_dac_txdata	= SUN4I_CODEC_DAC_TXDATA,
 	.reg_adc_rxdata	= SUN4I_CODEC_ADC_RXDATA,
+	.dma_max_burst	= SUN4I_DMA_MAX_BURST,
 };
 
 static const struct sun4i_codec_quirks sun6i_a31_codec_quirks = {
@@ -1587,6 +1591,7 @@ static const struct sun4i_codec_quirks sun6i_a31_codec_quirks = {
 	.reg_dac_txdata	= SUN4I_CODEC_DAC_TXDATA,
 	.reg_adc_rxdata	= SUN6I_CODEC_ADC_RXDATA,
 	.has_reset	= true,
+	.dma_max_burst	= SUN4I_DMA_MAX_BURST,
 };
 
 static const struct sun4i_codec_quirks sun7i_codec_quirks = {
@@ -1596,6 +1601,7 @@ static const struct sun4i_codec_quirks sun7i_codec_quirks = {
 	.reg_adc_fifoc	= REG_FIELD(SUN4I_CODEC_ADC_FIFOC, 0, 31),
 	.reg_dac_txdata	= SUN4I_CODEC_DAC_TXDATA,
 	.reg_adc_rxdata	= SUN4I_CODEC_ADC_RXDATA,
+	.dma_max_burst	= SUN4I_DMA_MAX_BURST,
 };
 
 static const struct sun4i_codec_quirks sun8i_a23_codec_quirks = {
@@ -1606,6 +1612,7 @@ static const struct sun4i_codec_quirks sun8i_a23_codec_quirks = {
 	.reg_dac_txdata	= SUN4I_CODEC_DAC_TXDATA,
 	.reg_adc_rxdata	= SUN6I_CODEC_ADC_RXDATA,
 	.has_reset	= true,
+	.dma_max_burst	= SUN4I_DMA_MAX_BURST,
 };
 
 static const struct sun4i_codec_quirks sun8i_h3_codec_quirks = {
@@ -1621,6 +1628,7 @@ static const struct sun4i_codec_quirks sun8i_h3_codec_quirks = {
 	.reg_dac_txdata	= SUN8I_H3_CODEC_DAC_TXDATA,
 	.reg_adc_rxdata	= SUN6I_CODEC_ADC_RXDATA,
 	.has_reset	= true,
+	.dma_max_burst	= SUN4I_DMA_MAX_BURST,
 };
 
 static const struct sun4i_codec_quirks sun8i_v3s_codec_quirks = {
@@ -1635,6 +1643,7 @@ static const struct sun4i_codec_quirks sun8i_v3s_codec_quirks = {
 	.reg_dac_txdata	= SUN8I_H3_CODEC_DAC_TXDATA,
 	.reg_adc_rxdata	= SUN6I_CODEC_ADC_RXDATA,
 	.has_reset	= true,
+	.dma_max_burst	= SUN4I_DMA_MAX_BURST,
 };
 
 static const struct of_device_id sun4i_codec_of_match[] = {
@@ -1757,12 +1766,12 @@ static int sun4i_codec_probe(struct platform_device *pdev)
 
 	/* DMA configuration for TX FIFO */
 	scodec->playback_dma_data.addr = res->start + quirks->reg_dac_txdata;
-	scodec->playback_dma_data.maxburst = 8;
+	scodec->playback_dma_data.maxburst = quirks->dma_max_burst;
 	scodec->playback_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
 
 	/* DMA configuration for RX FIFO */
 	scodec->capture_dma_data.addr = res->start + quirks->reg_adc_rxdata;
-	scodec->capture_dma_data.maxburst = 8;
+	scodec->capture_dma_data.maxburst = quirks->dma_max_burst;
 	scodec->capture_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
 
 	ret = devm_snd_soc_register_component(&pdev->dev, quirks->codec,
-- 
2.34.1



