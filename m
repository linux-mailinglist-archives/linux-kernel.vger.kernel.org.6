Return-Path: <linux-kernel+bounces-236142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9EF91DDFC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 13:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE9A41C225E2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 11:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB75914BF90;
	Mon,  1 Jul 2024 11:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eu/vYyAI"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86EB145B09;
	Mon,  1 Jul 2024 11:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719833521; cv=none; b=a528jvwPhfIjALPUxWLkg6/PLO6fUJYzf/yQ4d+DY9yt1VgkxsdZkL8REoCOKe0K5542CKLTWIR1Na2llcnm/pZV2hH3Gy6UQ373FWVSWFs8YV/b7CNfwxzcZ65UL2HrWtR/XtnN8PASKFaF+RUogBYGvmUPbg/V63odEmgjg0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719833521; c=relaxed/simple;
	bh=AxIKPqTO+wF+1yoEnfWDUj8D8R3BzcUWs0scf2kg4mU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b8BeykjTywKA9/Z9t/DX7MNcapF+z6JGeNJ+zXr1Zxay27soSm6A+rWlUjJNv1t+/WEZhqCfnUMpi5R34gTQuBuh4+zjEzif7xGx+jOeNIH+ysVg+uD/0ufQaLo7Qhj4e5PHjfmcUUN8goeF55O1ekPedY+xDlzftzv6jrxX5y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eu/vYyAI; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 7D21124000E;
	Mon,  1 Jul 2024 11:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719833517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EFI+0E0euoS+1MCJ9IhOD3qEiKcvASTCp8dMcDFqcOg=;
	b=eu/vYyAIhSyp0MjAJ9CkOyycqPE4aKe+kZlJsGs/gJ8AikcYDe5G+tBh3h3T2c6jtrj5B4
	/podCnym9i5XJF8szSMFTlXRdXc12SrJzaZ2wBh8ZEnKh3DfrLCbxXl1wOq/dYzRVufR4Y
	zR+xYcvz0NbmXb+EiPeL0ztJo/UpRPzMtJy7V5LRTfxy2avf8XHtMYW2xcE/7008XPQQDb
	LYlgqfNhEyjxBf70HDlgNA9fKCY8GynEokn6gKEWGdOBBEWWteYdApxITW7XO85RKnLkiz
	VAb+Aahu9A2eXtQPrVnaKu4SdgydbVgDP8rs9FWPUfjL8uGlbX0hikmWeW2lsA==
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
Subject: [PATCH v2 04/10] ASoC: fsl: fsl_qmc_audio: Identify the QMC channel involved in completion routines
Date: Mon,  1 Jul 2024 13:30:31 +0200
Message-ID: <20240701113038.55144-5-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240701113038.55144-1-herve.codina@bootlin.com>
References: <20240701113038.55144-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

The current QMC audio driver uses only one QMC channel per DAI. The
context used by QMC channel transfer (read and write) completion
routines does not contains any QMC channel and the only one available
per DAI is used to schedule the next transfer.
This works pretty well with only one QMC channel per DAI.

The future support for non-inlerleave mode will use several QMC channel
per DAI. In that case, QMC channel transfer completion routines need to
identify the QMC channel related to the completion.

In order to fill this lack, even if identifying the current QMC channel
among several QMC channels is not needed for the current code, add one
indirection level and introduce the qmc_dai_chan data structrure.
This structure contains the QMC channel involved in the completion and
refererences to the runtime context (capture and playback) used by the
DAI.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 sound/soc/fsl/fsl_qmc_audio.c | 72 +++++++++++++++++++++++------------
 1 file changed, 47 insertions(+), 25 deletions(-)

diff --git a/sound/soc/fsl/fsl_qmc_audio.c b/sound/soc/fsl/fsl_qmc_audio.c
index e8281e548746..b07770257bad 100644
--- a/sound/soc/fsl/fsl_qmc_audio.c
+++ b/sound/soc/fsl/fsl_qmc_audio.c
@@ -17,13 +17,19 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 
+struct qmc_dai_chan {
+	struct qmc_dai_prtd *prtd_tx;
+	struct qmc_dai_prtd *prtd_rx;
+	struct qmc_chan *qmc_chan;
+};
+
 struct qmc_dai {
 	char *name;
 	int id;
 	struct device *dev;
-	struct qmc_chan *qmc_chan;
 	unsigned int nb_tx_ts;
 	unsigned int nb_rx_ts;
+	struct qmc_dai_chan chan;
 };
 
 struct qmc_audio {
@@ -86,9 +92,12 @@ static int qmc_audio_pcm_hw_params(struct snd_soc_component *component,
 
 static void qmc_audio_pcm_write_complete(void *context)
 {
-	struct qmc_dai_prtd *prtd = context;
+	struct qmc_dai_chan *chan = context;
+	struct qmc_dai_prtd *prtd;
 	int ret;
 
+	prtd = chan->prtd_tx;
+
 	prtd->buffer_ended += prtd->period_size;
 	if (prtd->buffer_ended >= prtd->buffer_size)
 		prtd->buffer_ended = 0;
@@ -97,9 +106,10 @@ static void qmc_audio_pcm_write_complete(void *context)
 	if (prtd->ch_dma_addr_current >= prtd->ch_dma_addr_end)
 		prtd->ch_dma_addr_current = prtd->ch_dma_addr_start;
 
-	ret = qmc_chan_write_submit(prtd->qmc_dai->qmc_chan,
+	ret = qmc_chan_write_submit(prtd->qmc_dai->chan.qmc_chan,
 				    prtd->ch_dma_addr_current, prtd->ch_dma_size,
-				    qmc_audio_pcm_write_complete, prtd);
+				    qmc_audio_pcm_write_complete,
+				    &prtd->qmc_dai->chan);
 	if (ret) {
 		dev_err(prtd->qmc_dai->dev, "write_submit failed %d\n",
 			ret);
@@ -110,9 +120,12 @@ static void qmc_audio_pcm_write_complete(void *context)
 
 static void qmc_audio_pcm_read_complete(void *context, size_t length, unsigned int flags)
 {
-	struct qmc_dai_prtd *prtd = context;
+	struct qmc_dai_chan *chan = context;
+	struct qmc_dai_prtd *prtd;
 	int ret;
 
+	prtd = chan->prtd_rx;
+
 	if (length != prtd->ch_dma_size) {
 		dev_err(prtd->qmc_dai->dev, "read complete length = %zu, exp %zu\n",
 			length, prtd->ch_dma_size);
@@ -126,9 +139,10 @@ static void qmc_audio_pcm_read_complete(void *context, size_t length, unsigned i
 	if (prtd->ch_dma_addr_current >= prtd->ch_dma_addr_end)
 		prtd->ch_dma_addr_current = prtd->ch_dma_addr_start;
 
-	ret = qmc_chan_read_submit(prtd->qmc_dai->qmc_chan,
+	ret = qmc_chan_read_submit(prtd->qmc_dai->chan.qmc_chan,
 				   prtd->ch_dma_addr_current, prtd->ch_dma_size,
-				   qmc_audio_pcm_read_complete, prtd);
+				   qmc_audio_pcm_read_complete,
+				   &prtd->qmc_dai->chan);
 	if (ret) {
 		dev_err(prtd->qmc_dai->dev, "read_submit failed %d\n",
 			ret);
@@ -151,10 +165,13 @@ static int qmc_audio_pcm_trigger(struct snd_soc_component *component,
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+			prtd->qmc_dai->chan.prtd_tx = prtd;
+
 			/* Submit first chunk ... */
-			ret = qmc_chan_write_submit(prtd->qmc_dai->qmc_chan,
+			ret = qmc_chan_write_submit(prtd->qmc_dai->chan.qmc_chan,
 						    prtd->ch_dma_addr_current, prtd->ch_dma_size,
-						    qmc_audio_pcm_write_complete, prtd);
+						    qmc_audio_pcm_write_complete,
+						    &prtd->qmc_dai->chan);
 			if (ret) {
 				dev_err(component->dev, "write_submit failed %d\n",
 					ret);
@@ -167,19 +184,23 @@ static int qmc_audio_pcm_trigger(struct snd_soc_component *component,
 				prtd->ch_dma_addr_current = prtd->ch_dma_addr_start;
 
 			/* ... and send it */
-			ret = qmc_chan_write_submit(prtd->qmc_dai->qmc_chan,
+			ret = qmc_chan_write_submit(prtd->qmc_dai->chan.qmc_chan,
 						    prtd->ch_dma_addr_current, prtd->ch_dma_size,
-						    qmc_audio_pcm_write_complete, prtd);
+						    qmc_audio_pcm_write_complete,
+						    &prtd->qmc_dai->chan);
 			if (ret) {
 				dev_err(component->dev, "write_submit failed %d\n",
 					ret);
 				return ret;
 			}
 		} else {
+			prtd->qmc_dai->chan.prtd_rx = prtd;
+
 			/* Submit first chunk ... */
-			ret = qmc_chan_read_submit(prtd->qmc_dai->qmc_chan,
+			ret = qmc_chan_read_submit(prtd->qmc_dai->chan.qmc_chan,
 						   prtd->ch_dma_addr_current, prtd->ch_dma_size,
-						   qmc_audio_pcm_read_complete, prtd);
+						   qmc_audio_pcm_read_complete,
+						   &prtd->qmc_dai->chan);
 			if (ret) {
 				dev_err(component->dev, "read_submit failed %d\n",
 					ret);
@@ -192,9 +213,10 @@ static int qmc_audio_pcm_trigger(struct snd_soc_component *component,
 				prtd->ch_dma_addr_current = prtd->ch_dma_addr_start;
 
 			/* ... and send it */
-			ret = qmc_chan_read_submit(prtd->qmc_dai->qmc_chan,
+			ret = qmc_chan_read_submit(prtd->qmc_dai->chan.qmc_chan,
 						   prtd->ch_dma_addr_current, prtd->ch_dma_size,
-						   qmc_audio_pcm_read_complete, prtd);
+						   qmc_audio_pcm_read_complete,
+						   &prtd->qmc_dai->chan);
 			if (ret) {
 				dev_err(component->dev, "write_submit failed %d\n",
 					ret);
@@ -489,7 +511,7 @@ static int qmc_dai_hw_params(struct snd_pcm_substream *substream,
 	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
 		chan_param.mode = QMC_TRANSPARENT;
 		chan_param.transp.max_rx_buf_size = params_period_bytes(params);
-		ret = qmc_chan_set_param(qmc_dai->qmc_chan, &chan_param);
+		ret = qmc_chan_set_param(qmc_dai->chan.qmc_chan, &chan_param);
 		if (ret) {
 			dev_err(dai->dev, "set param failed %d\n",
 				ret);
@@ -520,23 +542,23 @@ static int qmc_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		ret = qmc_chan_start(qmc_dai->qmc_chan, direction);
+		ret = qmc_chan_start(qmc_dai->chan.qmc_chan, direction);
 		if (ret)
 			return ret;
 		break;
 
 	case SNDRV_PCM_TRIGGER_STOP:
-		ret = qmc_chan_stop(qmc_dai->qmc_chan, direction);
+		ret = qmc_chan_stop(qmc_dai->chan.qmc_chan, direction);
 		if (ret)
 			return ret;
-		ret = qmc_chan_reset(qmc_dai->qmc_chan, direction);
+		ret = qmc_chan_reset(qmc_dai->chan.qmc_chan, direction);
 		if (ret)
 			return ret;
 		break;
 
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		ret = qmc_chan_stop(qmc_dai->qmc_chan, direction);
+		ret = qmc_chan_stop(qmc_dai->chan.qmc_chan, direction);
 		if (ret)
 			return ret;
 		break;
@@ -613,10 +635,10 @@ static int qmc_audio_dai_parse(struct qmc_audio *qmc_audio, struct device_node *
 	if (!qmc_dai->name)
 		return -ENOMEM;
 
-	qmc_dai->qmc_chan = devm_qmc_chan_get_byphandle(qmc_audio->dev, np,
-							"fsl,qmc-chan");
-	if (IS_ERR(qmc_dai->qmc_chan)) {
-		ret = PTR_ERR(qmc_dai->qmc_chan);
+	qmc_dai->chan.qmc_chan = devm_qmc_chan_get_byphandle(qmc_audio->dev, np,
+							     "fsl,qmc-chan");
+	if (IS_ERR(qmc_dai->chan.qmc_chan)) {
+		ret = PTR_ERR(qmc_dai->chan.qmc_chan);
 		return dev_err_probe(qmc_audio->dev, ret,
 				     "dai %d get QMC channel failed\n", qmc_dai->id);
 	}
@@ -624,7 +646,7 @@ static int qmc_audio_dai_parse(struct qmc_audio *qmc_audio, struct device_node *
 	qmc_soc_dai_driver->id = qmc_dai->id;
 	qmc_soc_dai_driver->name = qmc_dai->name;
 
-	ret = qmc_chan_get_info(qmc_dai->qmc_chan, &info);
+	ret = qmc_chan_get_info(qmc_dai->chan.qmc_chan, &info);
 	if (ret) {
 		dev_err(qmc_audio->dev, "dai %d get QMC channel info failed %d\n",
 			qmc_dai->id, ret);
-- 
2.45.0


