Return-Path: <linux-kernel+bounces-236148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2242F91DE0B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 13:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A26E41F20FCF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 11:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD32152534;
	Mon,  1 Jul 2024 11:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Qn7BuU8l"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4349614B970;
	Mon,  1 Jul 2024 11:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719833524; cv=none; b=AS6R5JmVsusGbaFRfM6THY+kq+oI9BG9iFvfIAvZbK7paXXjeiLOIub2RoZheZFE6TjA/mcI62JF9BzMC9duKeYwJuhfeHGILhuye5alwlo/JYTkcIBvl99tNWdDGPaQM4jHloKLejJMADNIYFURmOS6AZmwKcTrrugwF7EDXSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719833524; c=relaxed/simple;
	bh=qIFtrk4+jNTGagJEvJP5YHoAWF+6D2TUEBk4+yKW9OU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KIkF8hFRg38pQZ9d0ZTa4eADgWuEe7tFxV+aryik2c3ucNsFo4ww6qgtwZALD15D0jMT8EgVUjHp1zt7AA+Z0C/tYhTJicgiszIfjI5fgb71D1Ql5nApAPqu1atDEHuhrBM4mIKiYNIqoWt7uOAfqESXfuH58pfqkKrWUNsMP/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Qn7BuU8l; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id D103624000C;
	Mon,  1 Jul 2024 11:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719833515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qz56XJSUWFIXioYtOWzibVEtfgyCjJ8wlnP/M2Ai9vM=;
	b=Qn7BuU8l4SABc26cXeY5fXzvX2JTxMN+hjuYbmlIbf/hJmf8HHCixsYahNv4qs8XCW/pS3
	53S40kUKmjlqpFimDWiAoLHlL+agIhJwTb4t1K95F4fBk3psHH/NlmPC+NR2MPWDm3j+ss
	njv/7N3MJNClabHkBe1NuYnKMix8hkCaAgZL1jfMkAw8g8Jnu+E0SnpatGeW3Fc53YPHZK
	+83BSiZJxLC5oTwoKxkcpeAiW41vz34NJ3QpsjQyicnyUah1B7ELrLunAkOgbq40BNAELQ
	QmGlmFYhHckomdhk/A9nUwU6w5Sk8mbTyPUJ2Yn5N8vebjN+k/BF9JWP6aV50g==
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
Subject: [PATCH v2 03/10] ASoC: fsl: fsl_qmc_audio: Split channel buffer and PCM pointer handling
Date: Mon,  1 Jul 2024 13:30:30 +0200
Message-ID: <20240701113038.55144-4-herve.codina@bootlin.com>
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

The driver mixes some internal values for channel DMA buffer handling
and PCM pointer handling. In the currently supported interleaved mode,
this mix does not lead to any issues but in order to prepare the
support for the non-interleaved mode, having them clearly separated will
ease the support and avoid additional computation to convert values used
in channel DMA buffer management in values usable for PCM pointer.

Use a specific set of variable for PCM pointer handling and an other set
for channel DMA buffer.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 sound/soc/fsl/fsl_qmc_audio.c | 84 +++++++++++++++++++----------------
 1 file changed, 46 insertions(+), 38 deletions(-)

diff --git a/sound/soc/fsl/fsl_qmc_audio.c b/sound/soc/fsl/fsl_qmc_audio.c
index 917a32389f3d..e8281e548746 100644
--- a/sound/soc/fsl/fsl_qmc_audio.c
+++ b/sound/soc/fsl/fsl_qmc_audio.c
@@ -35,11 +35,16 @@ struct qmc_audio {
 
 struct qmc_dai_prtd {
 	struct qmc_dai *qmc_dai;
-	dma_addr_t dma_buffer_start;
-	dma_addr_t period_ptr_submitted;
-	dma_addr_t period_ptr_ended;
-	dma_addr_t dma_buffer_end;
-	size_t period_size;
+
+	snd_pcm_uframes_t buffer_ended;
+	snd_pcm_uframes_t buffer_size;
+	snd_pcm_uframes_t period_size;
+
+	dma_addr_t ch_dma_addr_start;
+	dma_addr_t ch_dma_addr_current;
+	dma_addr_t ch_dma_addr_end;
+	size_t ch_dma_size;
+
 	struct snd_pcm_substream *substream;
 };
 
@@ -65,13 +70,17 @@ static int qmc_audio_pcm_hw_params(struct snd_soc_component *component,
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct qmc_dai_prtd *prtd = substream->runtime->private_data;
 
-	prtd->dma_buffer_start = runtime->dma_addr;
-	prtd->dma_buffer_end = runtime->dma_addr + params_buffer_bytes(params);
-	prtd->period_size = params_period_bytes(params);
-	prtd->period_ptr_submitted = prtd->dma_buffer_start;
-	prtd->period_ptr_ended = prtd->dma_buffer_start;
 	prtd->substream = substream;
 
+	prtd->buffer_ended = 0;
+	prtd->buffer_size = params_buffer_size(params);
+	prtd->period_size = params_period_size(params);
+
+	prtd->ch_dma_addr_start = runtime->dma_addr;
+	prtd->ch_dma_addr_end = runtime->dma_addr + params_buffer_bytes(params);
+	prtd->ch_dma_addr_current = prtd->ch_dma_addr_start;
+	prtd->ch_dma_size = params_period_bytes(params);
+
 	return 0;
 }
 
@@ -80,16 +89,16 @@ static void qmc_audio_pcm_write_complete(void *context)
 	struct qmc_dai_prtd *prtd = context;
 	int ret;
 
-	prtd->period_ptr_ended += prtd->period_size;
-	if (prtd->period_ptr_ended >= prtd->dma_buffer_end)
-		prtd->period_ptr_ended = prtd->dma_buffer_start;
+	prtd->buffer_ended += prtd->period_size;
+	if (prtd->buffer_ended >= prtd->buffer_size)
+		prtd->buffer_ended = 0;
 
-	prtd->period_ptr_submitted += prtd->period_size;
-	if (prtd->period_ptr_submitted >= prtd->dma_buffer_end)
-		prtd->period_ptr_submitted = prtd->dma_buffer_start;
+	prtd->ch_dma_addr_current += prtd->ch_dma_size;
+	if (prtd->ch_dma_addr_current >= prtd->ch_dma_addr_end)
+		prtd->ch_dma_addr_current = prtd->ch_dma_addr_start;
 
 	ret = qmc_chan_write_submit(prtd->qmc_dai->qmc_chan,
-				    prtd->period_ptr_submitted, prtd->period_size,
+				    prtd->ch_dma_addr_current, prtd->ch_dma_size,
 				    qmc_audio_pcm_write_complete, prtd);
 	if (ret) {
 		dev_err(prtd->qmc_dai->dev, "write_submit failed %d\n",
@@ -104,21 +113,21 @@ static void qmc_audio_pcm_read_complete(void *context, size_t length, unsigned i
 	struct qmc_dai_prtd *prtd = context;
 	int ret;
 
-	if (length != prtd->period_size) {
+	if (length != prtd->ch_dma_size) {
 		dev_err(prtd->qmc_dai->dev, "read complete length = %zu, exp %zu\n",
-			length, prtd->period_size);
+			length, prtd->ch_dma_size);
 	}
 
-	prtd->period_ptr_ended += prtd->period_size;
-	if (prtd->period_ptr_ended >= prtd->dma_buffer_end)
-		prtd->period_ptr_ended = prtd->dma_buffer_start;
+	prtd->buffer_ended += prtd->period_size;
+	if (prtd->buffer_ended >= prtd->buffer_size)
+		prtd->buffer_ended = 0;
 
-	prtd->period_ptr_submitted += prtd->period_size;
-	if (prtd->period_ptr_submitted >= prtd->dma_buffer_end)
-		prtd->period_ptr_submitted = prtd->dma_buffer_start;
+	prtd->ch_dma_addr_current += prtd->ch_dma_size;
+	if (prtd->ch_dma_addr_current >= prtd->ch_dma_addr_end)
+		prtd->ch_dma_addr_current = prtd->ch_dma_addr_start;
 
 	ret = qmc_chan_read_submit(prtd->qmc_dai->qmc_chan,
-				   prtd->period_ptr_submitted, prtd->period_size,
+				   prtd->ch_dma_addr_current, prtd->ch_dma_size,
 				   qmc_audio_pcm_read_complete, prtd);
 	if (ret) {
 		dev_err(prtd->qmc_dai->dev, "read_submit failed %d\n",
@@ -144,7 +153,7 @@ static int qmc_audio_pcm_trigger(struct snd_soc_component *component,
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 			/* Submit first chunk ... */
 			ret = qmc_chan_write_submit(prtd->qmc_dai->qmc_chan,
-						    prtd->period_ptr_submitted, prtd->period_size,
+						    prtd->ch_dma_addr_current, prtd->ch_dma_size,
 						    qmc_audio_pcm_write_complete, prtd);
 			if (ret) {
 				dev_err(component->dev, "write_submit failed %d\n",
@@ -153,13 +162,13 @@ static int qmc_audio_pcm_trigger(struct snd_soc_component *component,
 			}
 
 			/* ... prepare next one ... */
-			prtd->period_ptr_submitted += prtd->period_size;
-			if (prtd->period_ptr_submitted >= prtd->dma_buffer_end)
-				prtd->period_ptr_submitted = prtd->dma_buffer_start;
+			prtd->ch_dma_addr_current += prtd->ch_dma_size;
+			if (prtd->ch_dma_addr_current >= prtd->ch_dma_addr_end)
+				prtd->ch_dma_addr_current = prtd->ch_dma_addr_start;
 
 			/* ... and send it */
 			ret = qmc_chan_write_submit(prtd->qmc_dai->qmc_chan,
-						    prtd->period_ptr_submitted, prtd->period_size,
+						    prtd->ch_dma_addr_current, prtd->ch_dma_size,
 						    qmc_audio_pcm_write_complete, prtd);
 			if (ret) {
 				dev_err(component->dev, "write_submit failed %d\n",
@@ -169,7 +178,7 @@ static int qmc_audio_pcm_trigger(struct snd_soc_component *component,
 		} else {
 			/* Submit first chunk ... */
 			ret = qmc_chan_read_submit(prtd->qmc_dai->qmc_chan,
-						   prtd->period_ptr_submitted, prtd->period_size,
+						   prtd->ch_dma_addr_current, prtd->ch_dma_size,
 						   qmc_audio_pcm_read_complete, prtd);
 			if (ret) {
 				dev_err(component->dev, "read_submit failed %d\n",
@@ -178,13 +187,13 @@ static int qmc_audio_pcm_trigger(struct snd_soc_component *component,
 			}
 
 			/* ... prepare next one ... */
-			prtd->period_ptr_submitted += prtd->period_size;
-			if (prtd->period_ptr_submitted >= prtd->dma_buffer_end)
-				prtd->period_ptr_submitted = prtd->dma_buffer_start;
+			prtd->ch_dma_addr_current += prtd->ch_dma_size;
+			if (prtd->ch_dma_addr_current >= prtd->ch_dma_addr_end)
+				prtd->ch_dma_addr_current = prtd->ch_dma_addr_start;
 
 			/* ... and send it */
 			ret = qmc_chan_read_submit(prtd->qmc_dai->qmc_chan,
-						   prtd->period_ptr_submitted, prtd->period_size,
+						   prtd->ch_dma_addr_current, prtd->ch_dma_size,
 						   qmc_audio_pcm_read_complete, prtd);
 			if (ret) {
 				dev_err(component->dev, "write_submit failed %d\n",
@@ -215,8 +224,7 @@ static snd_pcm_uframes_t qmc_audio_pcm_pointer(struct snd_soc_component *compone
 {
 	struct qmc_dai_prtd *prtd = substream->runtime->private_data;
 
-	return bytes_to_frames(substream->runtime,
-			       prtd->period_ptr_ended - prtd->dma_buffer_start);
+	return prtd->buffer_ended;
 }
 
 static int qmc_audio_of_xlate_dai_name(struct snd_soc_component *component,
-- 
2.45.0


