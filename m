Return-Path: <linux-kernel+bounces-222275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A62EF90FF21
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 10:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DDAF1F22C86
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 08:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CFF1A4F02;
	Thu, 20 Jun 2024 08:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="a97esiVn"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB0719D094;
	Thu, 20 Jun 2024 08:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718873000; cv=none; b=OZjv6S9kHqJovAxVO1WhJ72UmcUIfDwiYeoQ2vA5kkfKcpGfTj58uVd4IN1Mo3c+4VKeMJAP/3LhmL32aiJC5HBxsUzLPFeOXWT8N4tkC3/fhleXJ6V1ylNUM1FqXeSBe3X4E2V6fCqBRuXzgjPPtfi6WjIRKq/Iz+80P1AUtdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718873000; c=relaxed/simple;
	bh=g06udzdr3FQ3GGjFDr6DB3X29brZkwlgc30sknmNjdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TjxllRPr/oHxOnzCKonWwsbzs+ecJJ4YuZGen8v0l1wgEBHLTC/K1GdVjOuJoyx9y/MRpTdTOjf57t+N2umWNq6fIAYQAU+Edfb3B0xZVhhayNam/6ZJQjHGB8T+BPRoi+Peu5/8e23qaJbjX72XN3tjwkvKKRXgjg2HnglfKCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=a97esiVn; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id E8D0920005;
	Thu, 20 Jun 2024 08:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718872996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/jcw3B7br9mMf7ih+RGvbztJQGfoFsNFtd4Dmae4m5o=;
	b=a97esiVnJn41eMUraY8MB3Zy2tdFjuOc1bB72Im5wsV7wGp00opmdS75RCaZBrcqwnIYBo
	CbExXz+Zmlrrhg8vhuMJGJYFSIAMM4jOP7IJc9opSTfpOo3ouxRuigsFbZICp/rV/iTbc7
	XDLhPEN9H05uYDZD+5fR1JYISMPCUHD7PBTGx3ATXXuQ7q5rWkdA4jDUMaEswD+IdlEXXN
	IYPMadbr9RX4TDh3vxDWzpAQ1WAPAJMycwZMrIXr/DP5WlYDVVKduYe9asrAadK3KzJMX3
	7RIwBS3G86/V3qG1f0VDh4g1lwgkkZ3Yk9vsbgzuFpaO9Vb8e9wjeVvG+Sc00w==
From: Herve Codina <herve.codina@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Qiang Zhao <qiang.zhao@nxp.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 05/10] ASoC: fsl: fsl_qmc_audio: Introduce qmc_audio_pcm_{read,write}_submit()
Date: Thu, 20 Jun 2024 10:42:52 +0200
Message-ID: <20240620084300.397853-6-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240620084300.397853-1-herve.codina@bootlin.com>
References: <20240620084300.397853-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Submitting data to QMC channels is done in several places: transfer
completions and DAI start. The operation done is simple and consist in
one function call.

With the future introduction of support for non-interleaved mode,
submitting data will be more complex.

To avoid copy/paste of code in several places, introduce
qmc_audio_pcm_{read,write}_submit() whose goal is to handle this
data submission.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 sound/soc/fsl/fsl_qmc_audio.c | 93 +++++++++++++++++------------------
 1 file changed, 45 insertions(+), 48 deletions(-)

diff --git a/sound/soc/fsl/fsl_qmc_audio.c b/sound/soc/fsl/fsl_qmc_audio.c
index b07770257bad..36145f1ddbf1 100644
--- a/sound/soc/fsl/fsl_qmc_audio.c
+++ b/sound/soc/fsl/fsl_qmc_audio.c
@@ -90,11 +90,29 @@ static int qmc_audio_pcm_hw_params(struct snd_soc_component *component,
 	return 0;
 }
 
+static void qmc_audio_pcm_write_complete(void *context);
+
+static int qmc_audio_pcm_write_submit(struct qmc_dai_prtd *prtd)
+{
+	int ret;
+
+	ret = qmc_chan_write_submit(prtd->qmc_dai->chan.qmc_chan,
+				    prtd->ch_dma_addr_current, prtd->ch_dma_size,
+				    qmc_audio_pcm_write_complete,
+				    &prtd->qmc_dai->chan);
+	if (ret) {
+		dev_err(prtd->qmc_dai->dev, "write_submit failed %d\n",
+			ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 static void qmc_audio_pcm_write_complete(void *context)
 {
 	struct qmc_dai_chan *chan = context;
 	struct qmc_dai_prtd *prtd;
-	int ret;
 
 	prtd = chan->prtd_tx;
 
@@ -106,23 +124,33 @@ static void qmc_audio_pcm_write_complete(void *context)
 	if (prtd->ch_dma_addr_current >= prtd->ch_dma_addr_end)
 		prtd->ch_dma_addr_current = prtd->ch_dma_addr_start;
 
-	ret = qmc_chan_write_submit(prtd->qmc_dai->chan.qmc_chan,
-				    prtd->ch_dma_addr_current, prtd->ch_dma_size,
-				    qmc_audio_pcm_write_complete,
-				    &prtd->qmc_dai->chan);
+	qmc_audio_pcm_write_submit(prtd);
+
+	snd_pcm_period_elapsed(prtd->substream);
+}
+
+static void qmc_audio_pcm_read_complete(void *context, size_t length, unsigned int flags);
+
+static int qmc_audio_pcm_read_submit(struct qmc_dai_prtd *prtd)
+{
+	int ret;
+
+	ret = qmc_chan_read_submit(prtd->qmc_dai->chan.qmc_chan,
+				   prtd->ch_dma_addr_current, prtd->ch_dma_size,
+				   qmc_audio_pcm_read_complete,
+				   &prtd->qmc_dai->chan);
 	if (ret) {
-		dev_err(prtd->qmc_dai->dev, "write_submit failed %d\n",
+		dev_err(prtd->qmc_dai->dev, "read_submit failed %d\n",
 			ret);
 	}
 
-	snd_pcm_period_elapsed(prtd->substream);
+	return 0;
 }
 
 static void qmc_audio_pcm_read_complete(void *context, size_t length, unsigned int flags)
 {
 	struct qmc_dai_chan *chan = context;
 	struct qmc_dai_prtd *prtd;
-	int ret;
 
 	prtd = chan->prtd_rx;
 
@@ -139,14 +167,7 @@ static void qmc_audio_pcm_read_complete(void *context, size_t length, unsigned i
 	if (prtd->ch_dma_addr_current >= prtd->ch_dma_addr_end)
 		prtd->ch_dma_addr_current = prtd->ch_dma_addr_start;
 
-	ret = qmc_chan_read_submit(prtd->qmc_dai->chan.qmc_chan,
-				   prtd->ch_dma_addr_current, prtd->ch_dma_size,
-				   qmc_audio_pcm_read_complete,
-				   &prtd->qmc_dai->chan);
-	if (ret) {
-		dev_err(prtd->qmc_dai->dev, "read_submit failed %d\n",
-			ret);
-	}
+	qmc_audio_pcm_read_submit(prtd);
 
 	snd_pcm_period_elapsed(prtd->substream);
 }
@@ -168,15 +189,9 @@ static int qmc_audio_pcm_trigger(struct snd_soc_component *component,
 			prtd->qmc_dai->chan.prtd_tx = prtd;
 
 			/* Submit first chunk ... */
-			ret = qmc_chan_write_submit(prtd->qmc_dai->chan.qmc_chan,
-						    prtd->ch_dma_addr_current, prtd->ch_dma_size,
-						    qmc_audio_pcm_write_complete,
-						    &prtd->qmc_dai->chan);
-			if (ret) {
-				dev_err(component->dev, "write_submit failed %d\n",
-					ret);
+			ret = qmc_audio_pcm_write_submit(prtd);
+			if (ret)
 				return ret;
-			}
 
 			/* ... prepare next one ... */
 			prtd->ch_dma_addr_current += prtd->ch_dma_size;
@@ -184,28 +199,16 @@ static int qmc_audio_pcm_trigger(struct snd_soc_component *component,
 				prtd->ch_dma_addr_current = prtd->ch_dma_addr_start;
 
 			/* ... and send it */
-			ret = qmc_chan_write_submit(prtd->qmc_dai->chan.qmc_chan,
-						    prtd->ch_dma_addr_current, prtd->ch_dma_size,
-						    qmc_audio_pcm_write_complete,
-						    &prtd->qmc_dai->chan);
-			if (ret) {
-				dev_err(component->dev, "write_submit failed %d\n",
-					ret);
+			ret = qmc_audio_pcm_write_submit(prtd);
+			if (ret)
 				return ret;
-			}
 		} else {
 			prtd->qmc_dai->chan.prtd_rx = prtd;
 
 			/* Submit first chunk ... */
-			ret = qmc_chan_read_submit(prtd->qmc_dai->chan.qmc_chan,
-						   prtd->ch_dma_addr_current, prtd->ch_dma_size,
-						   qmc_audio_pcm_read_complete,
-						   &prtd->qmc_dai->chan);
-			if (ret) {
-				dev_err(component->dev, "read_submit failed %d\n",
-					ret);
+			ret = qmc_audio_pcm_read_submit(prtd);
+			if (ret)
 				return ret;
-			}
 
 			/* ... prepare next one ... */
 			prtd->ch_dma_addr_current += prtd->ch_dma_size;
@@ -213,15 +216,9 @@ static int qmc_audio_pcm_trigger(struct snd_soc_component *component,
 				prtd->ch_dma_addr_current = prtd->ch_dma_addr_start;
 
 			/* ... and send it */
-			ret = qmc_chan_read_submit(prtd->qmc_dai->chan.qmc_chan,
-						   prtd->ch_dma_addr_current, prtd->ch_dma_size,
-						   qmc_audio_pcm_read_complete,
-						   &prtd->qmc_dai->chan);
-			if (ret) {
-				dev_err(component->dev, "write_submit failed %d\n",
-					ret);
+			ret = qmc_audio_pcm_read_submit(prtd);
+			if (ret)
 				return ret;
-			}
 		}
 		break;
 
-- 
2.45.0


