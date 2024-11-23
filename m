Return-Path: <linux-kernel+bounces-419060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E489D6909
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 13:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 264CD281D73
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 12:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A9E17A583;
	Sat, 23 Nov 2024 12:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="AnAH/nfY"
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACFA175D39;
	Sat, 23 Nov 2024 12:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732365763; cv=none; b=a3TH3KMVQaes7Akk9T4GqERasFMhyy5Q2okHjb45xMvyQjlyBDeUKypKwVqK8lJoZClIGf6NMz//eQmn8NBtUwHZDCx4T19IqIIrYU3MGR0SPhCSSTZVetl29ppIr/0qIx7TY+7mY+H8R9Z36CqZkV61ym14vaEna3bkLfHbDRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732365763; c=relaxed/simple;
	bh=TdJ1DGOvqX8glbu/eIP2k87ZAcCaUPSgHUnFGwbWl0Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jcq59oshJC+9BGBkhZkmApahLhST9oCnGAtcIhYIOLEPdqK/WghawAkLbRwNn9Txdg2ZROPCLbb5Qg68MINg1O/PKNbbuW8MmwUG95VqWio6IyWRXbXLn+p+LaZdbtB6KS+ikW0Bgfz9DVx9AA4gKjlrM+7wx1bx3xgSFxOWMEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=AnAH/nfY; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id CA084A0302;
	Sat, 23 Nov 2024 13:42:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=iXVjUjIB+JQ/rT0gYbzy
	yBWwnjcyACAfAFesDJOLFyQ=; b=AnAH/nfYv0oGOy2GKCJhglKL+gvmbaZ6CEsv
	xXbVp3pzS0l6eT5ZcpUzxr6DXSdzPecTHpSWKxdTL2S+IT2GcCMT7veunLnjfmZy
	3W9ppeaimN5jF+qqMx1PtgTCVUZxW1mdYcrNH5GHfmOQFcKPHZ3U+aVmpvQNqnao
	TVA3evj/O0iVfQGmTb0a6tlZy5mM4/Qk+JPhgUjW311p0OhoHGQ1plg/3A3/k/pQ
	JSXK4NEkMhrfVhq0nLUdcxpKAdxjtTQnIPI/u+QX0TnW358o79XQzFgO6AeNKlax
	Zbpmzby3ZBOpTCfmFiB/+VfX6iX4ZsTVdJLOe+XVRp9/1TZzfUBNA+aOu/KmvelH
	/iVjQ1Z5NIcDU/8qBtVGgDGoj6jimS0Cb8m03sfbmoY5lN5Ozn79wFWxdnTG4uBv
	hI+siVIg/IiXIg17nSlL0EplDsCXvl3rG0nH3yW5M0J/PBpnWqAxdxMebsGitm3J
	qH7VnJ9upWDno0DBkK0dYhHeMNbZD0qFiZlYBZElYOzsfHbY9LrtP0PhfmBPlvAM
	dvngkQjdf77HBH8rhSZpN1P7u6aSeNRmzOF0Sqq4DE+KPttR+upOJG0aPcdmGFO+
	WTo+nP56t6wkaoAt5+N0VVSQmU53yzIyWhsqPchqip1tbzbykZ3o1rZTaTfXtrZr
	ELnY/Ic=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <linux-sound@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: Mesih Kilinc <mesihkilinc@gmail.com>,
	=?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, "Liam
 Girdwood" <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "Jaroslav
 Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Chen-Yu Tsai
	<wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland
	<samuel@sholland.org>
Subject: [PATCH v6 1/5] ASoC: sun4i-codec: Add DMA Max Burst field
Date: Sat, 23 Nov 2024 13:38:58 +0100
Message-ID: <20241123123900.2656837-2-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241123123900.2656837-1-csokas.bence@prolan.hu>
References: <20241123123900.2656837-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1732365757;VERSION=7980;MC=3036660156;ID=80951;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD9485560726B

From: Mesih Kilinc <mesihkilinc@gmail.com>

Allwinner suniv F1C100s has similar DMA engine to sun4i but it has
smaller max burst size compared to sun4i. Add a quirk field to
differantitate between them.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
[ csokas.bence: Rebased on current master ]
Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
---
 sound/soc/sunxi/sun4i-codec.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 933a0913237c..275f77f60830 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -265,6 +265,8 @@
 
 /* TODO H3 DAP (Digital Audio Processing) bits */
 
+#define SUN4I_DMA_MAX_BURST			(8)
+
 struct sun4i_codec {
 	struct device	*dev;
 	struct regmap	*regmap;
@@ -1761,6 +1763,7 @@ struct sun4i_codec_quirks {
 	unsigned int reg_adc_rxdata;	/* RX FIFO offset for DMA config */
 	bool has_reset;
 	bool playback_only;
+	u32 dma_max_burst;
 };
 
 static const struct sun4i_codec_quirks sun4i_codec_quirks = {
@@ -1771,6 +1774,7 @@ static const struct sun4i_codec_quirks sun4i_codec_quirks = {
 	.reg_dac_fifoc	= REG_FIELD(SUN4I_CODEC_DAC_FIFOC, 0, 31),
 	.reg_dac_txdata	= SUN4I_CODEC_DAC_TXDATA,
 	.reg_adc_rxdata	= SUN4I_CODEC_ADC_RXDATA,
+	.dma_max_burst	= SUN4I_DMA_MAX_BURST,
 };
 
 static const struct sun4i_codec_quirks sun6i_a31_codec_quirks = {
@@ -1782,6 +1786,7 @@ static const struct sun4i_codec_quirks sun6i_a31_codec_quirks = {
 	.reg_dac_txdata	= SUN4I_CODEC_DAC_TXDATA,
 	.reg_adc_rxdata	= SUN6I_CODEC_ADC_RXDATA,
 	.has_reset	= true,
+	.dma_max_burst	= SUN4I_DMA_MAX_BURST,
 };
 
 static const struct sun4i_codec_quirks sun7i_codec_quirks = {
@@ -1792,6 +1797,7 @@ static const struct sun4i_codec_quirks sun7i_codec_quirks = {
 	.reg_dac_fifoc	= REG_FIELD(SUN4I_CODEC_DAC_FIFOC, 0, 31),
 	.reg_dac_txdata	= SUN4I_CODEC_DAC_TXDATA,
 	.reg_adc_rxdata	= SUN4I_CODEC_ADC_RXDATA,
+	.dma_max_burst	= SUN4I_DMA_MAX_BURST,
 };
 
 static const struct sun4i_codec_quirks sun8i_a23_codec_quirks = {
@@ -1803,6 +1809,7 @@ static const struct sun4i_codec_quirks sun8i_a23_codec_quirks = {
 	.reg_dac_txdata	= SUN4I_CODEC_DAC_TXDATA,
 	.reg_adc_rxdata	= SUN6I_CODEC_ADC_RXDATA,
 	.has_reset	= true,
+	.dma_max_burst	= SUN4I_DMA_MAX_BURST,
 };
 
 static const struct sun4i_codec_quirks sun8i_h3_codec_quirks = {
@@ -1819,6 +1826,7 @@ static const struct sun4i_codec_quirks sun8i_h3_codec_quirks = {
 	.reg_dac_txdata	= SUN8I_H3_CODEC_DAC_TXDATA,
 	.reg_adc_rxdata	= SUN6I_CODEC_ADC_RXDATA,
 	.has_reset	= true,
+	.dma_max_burst	= SUN4I_DMA_MAX_BURST,
 };
 
 static const struct sun4i_codec_quirks sun8i_v3s_codec_quirks = {
@@ -1834,6 +1842,7 @@ static const struct sun4i_codec_quirks sun8i_v3s_codec_quirks = {
 	.reg_dac_txdata	= SUN8I_H3_CODEC_DAC_TXDATA,
 	.reg_adc_rxdata	= SUN6I_CODEC_ADC_RXDATA,
 	.has_reset	= true,
+	.dma_max_burst	= SUN4I_DMA_MAX_BURST,
 };
 
 static const struct sun4i_codec_quirks sun50i_h616_codec_quirks = {
@@ -1843,6 +1852,7 @@ static const struct sun4i_codec_quirks sun50i_h616_codec_quirks = {
 	.reg_dac_fifoc	= REG_FIELD(SUN50I_H616_CODEC_DAC_FIFOC, 0, 31),
 	.reg_dac_txdata	= SUN8I_H3_CODEC_DAC_TXDATA,
 	.has_reset	= true,
+	.dma_max_burst	= SUN4I_DMA_MAX_BURST,
 };
 
 static const struct of_device_id sun4i_codec_of_match[] = {
@@ -1979,14 +1989,14 @@ static int sun4i_codec_probe(struct platform_device *pdev)
 
 	/* DMA configuration for TX FIFO */
 	scodec->playback_dma_data.addr = res->start + quirks->reg_dac_txdata;
-	scodec->playback_dma_data.maxburst = 8;
+	scodec->playback_dma_data.maxburst = quirks->dma_max_burst;
 	scodec->playback_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
 
 	if (!quirks->playback_only) {
 		/* DMA configuration for RX FIFO */
 		scodec->capture_dma_data.addr = res->start +
 						quirks->reg_adc_rxdata;
-		scodec->capture_dma_data.maxburst = 8;
+		scodec->capture_dma_data.maxburst = quirks->dma_max_burst;
 		scodec->capture_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
 	}
 
-- 
2.34.1



