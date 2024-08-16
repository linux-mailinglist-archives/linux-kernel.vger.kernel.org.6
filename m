Return-Path: <linux-kernel+bounces-289549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85173954764
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 13:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D73D91F255D8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B4619DF85;
	Fri, 16 Aug 2024 11:03:21 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0417217BEB7;
	Fri, 16 Aug 2024 11:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723806200; cv=none; b=FnBPjpqhVmr2XBJKgN9n8LVQKpSZyl0K1ZeKUZqMzZp8AOAf1QPucxzP7J7Ml7+vX8P3ObnKHzDaA6c3A63OKfxQeiSZI4YHiG9Kg7a0z+5/8zBhoDofFTH0IPfZDFdiUgwbIG+3sHljrc7YPX2JcHRtx0VVuum6bOF4zz3rG/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723806200; c=relaxed/simple;
	bh=OYONcnYU7UDrPxNBX8KbcjBDOYIR/VYPVJGUKu8TsYk=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=lezcuIU4Qo3czD2Lvgj/Pvqyw7X33Z8O23AivgWTx2D3zjqPOhx/r8l9/ewbWoPudlV6/CaR/hukTqoL7ag9GJzgnsg5rpeSogE7HDp78YEGpooLwNGqHJVl1WaALkSHnU3HWLsWBEaSGbQjdcq3UkP68WGsUZMa8xIPMjazxow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4F061202CF9;
	Fri, 16 Aug 2024 13:03:17 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B84CF202D16;
	Fri, 16 Aug 2024 13:03:16 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id DC82D181D0FF;
	Fri, 16 Aug 2024 19:03:13 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: vkoul@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH v2 3/6] ASoC: fsl_easrc: define functions for memory to memory usage
Date: Fri, 16 Aug 2024 18:42:36 +0800
Message-Id: <1723804959-31921-4-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1723804959-31921-1-git-send-email-shengjiu.wang@nxp.com>
References: <1723804959-31921-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

ASRC can be used on memory to memory case, define several
functions for m2m usage and export them as function pointer.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_easrc.c | 226 ++++++++++++++++++++++++++++++++++++++
 sound/soc/fsl/fsl_easrc.h |   4 +
 2 files changed, 230 insertions(+)

diff --git a/sound/soc/fsl/fsl_easrc.c b/sound/soc/fsl/fsl_easrc.c
index 962f30912091..959a8e2dd716 100644
--- a/sound/soc/fsl/fsl_easrc.c
+++ b/sound/soc/fsl/fsl_easrc.c
@@ -1861,6 +1861,222 @@ static int fsl_easrc_get_fifo_addr(u8 dir, enum asrc_pair_index index)
 	return REG_EASRC_FIFO(dir, index);
 }
 
+/* Get sample numbers in FIFO */
+static unsigned int fsl_easrc_get_output_fifo_size(struct fsl_asrc_pair *pair)
+{
+	struct fsl_asrc *asrc = pair->asrc;
+	enum asrc_pair_index index = pair->index;
+	u32 val;
+
+	regmap_read(asrc->regmap, REG_EASRC_SFS(index), &val);
+	val &= EASRC_SFS_NSGO_MASK;
+
+	return val >> EASRC_SFS_NSGO_SHIFT;
+}
+
+static int fsl_easrc_m2m_prepare(struct fsl_asrc_pair *pair)
+{
+	struct fsl_easrc_ctx_priv *ctx_priv = pair->private;
+	struct fsl_asrc *asrc = pair->asrc;
+	struct device *dev = &asrc->pdev->dev;
+	int ret;
+
+	ctx_priv->in_params.sample_rate = pair->rate[IN];
+	ctx_priv->in_params.sample_format = pair->sample_format[IN];
+	ctx_priv->out_params.sample_rate = pair->rate[OUT];
+	ctx_priv->out_params.sample_format = pair->sample_format[OUT];
+
+	ctx_priv->in_params.fifo_wtmk = FSL_EASRC_INPUTFIFO_WML;
+	ctx_priv->out_params.fifo_wtmk = FSL_EASRC_OUTPUTFIFO_WML;
+	/* Fill the right half of the re-sampler with zeros */
+	ctx_priv->rs_init_mode = 0x2;
+	/* Zero fill the right half of the prefilter */
+	ctx_priv->pf_init_mode = 0x2;
+
+	ret = fsl_easrc_set_ctx_format(pair,
+				       &ctx_priv->in_params.sample_format,
+				       &ctx_priv->out_params.sample_format);
+	if (ret) {
+		dev_err(dev, "failed to set context format: %d\n", ret);
+		return ret;
+	}
+
+	ret = fsl_easrc_config_context(asrc, pair->index);
+	if (ret) {
+		dev_err(dev, "failed to config context %d\n", ret);
+		return ret;
+	}
+
+	ctx_priv->in_params.iterations = 1;
+	ctx_priv->in_params.group_len = pair->channels;
+	ctx_priv->in_params.access_len = pair->channels;
+	ctx_priv->out_params.iterations = 1;
+	ctx_priv->out_params.group_len = pair->channels;
+	ctx_priv->out_params.access_len = pair->channels;
+
+	ret = fsl_easrc_set_ctx_organziation(pair);
+	if (ret) {
+		dev_err(dev, "failed to set fifo organization\n");
+		return ret;
+	}
+
+	/* The context start flag */
+	pair->first_convert = 1;
+	return 0;
+}
+
+static int fsl_easrc_m2m_start(struct fsl_asrc_pair *pair)
+{
+	/* start context once */
+	if (pair->first_convert) {
+		fsl_easrc_start_context(pair);
+		pair->first_convert = 0;
+	}
+
+	return 0;
+}
+
+static int fsl_easrc_m2m_stop(struct fsl_asrc_pair *pair)
+{
+	/* Stop pair/context */
+	if (!pair->first_convert) {
+		fsl_easrc_stop_context(pair);
+		pair->first_convert = 1;
+	}
+
+	return 0;
+}
+
+/* calculate capture data length according to output data length and sample rate */
+static int fsl_easrc_m2m_calc_out_len(struct fsl_asrc_pair *pair, int input_buffer_length)
+{
+	struct fsl_asrc *easrc = pair->asrc;
+	struct fsl_easrc_priv *easrc_priv = easrc->private;
+	struct fsl_easrc_ctx_priv *ctx_priv = pair->private;
+	unsigned int in_rate = ctx_priv->in_params.norm_rate;
+	unsigned int out_rate = ctx_priv->out_params.norm_rate;
+	unsigned int channels = pair->channels;
+	unsigned int in_samples, out_samples;
+	unsigned int in_width, out_width;
+	unsigned int out_length;
+	unsigned int frac_bits;
+	u64 val1, val2;
+
+	switch (easrc_priv->rs_num_taps) {
+	case EASRC_RS_32_TAPS:
+		/* integer bits = 5; */
+		frac_bits = 39;
+		break;
+	case EASRC_RS_64_TAPS:
+		/* integer bits = 6; */
+		frac_bits = 38;
+		break;
+	case EASRC_RS_128_TAPS:
+		/* integer bits = 7; */
+		frac_bits = 37;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	val1 = (u64)in_rate << frac_bits;
+	do_div(val1, out_rate);
+	val1 += (s64)ctx_priv->ratio_mod << (frac_bits - 31);
+
+	in_width = snd_pcm_format_physical_width(ctx_priv->in_params.sample_format) / 8;
+	out_width = snd_pcm_format_physical_width(ctx_priv->out_params.sample_format) / 8;
+
+	ctx_priv->in_filled_len += input_buffer_length;
+	if (ctx_priv->in_filled_len <= ctx_priv->in_filled_sample * in_width * channels) {
+		out_length = 0;
+	} else {
+		in_samples = ctx_priv->in_filled_len / (in_width * channels) -
+			     ctx_priv->in_filled_sample;
+
+		/* right shift 12 bit to make ratio in 32bit space */
+		val2 = (u64)in_samples << (frac_bits - 12);
+		val1 = val1 >> 12;
+		do_div(val2, val1);
+		out_samples = val2;
+
+		out_length = out_samples * out_width * channels;
+		ctx_priv->in_filled_len = ctx_priv->in_filled_sample * in_width * channels;
+	}
+
+	return out_length;
+}
+
+static int fsl_easrc_m2m_get_maxburst(u8 dir, struct fsl_asrc_pair *pair)
+{
+	struct fsl_easrc_ctx_priv *ctx_priv = pair->private;
+
+	if (dir == IN)
+		return ctx_priv->in_params.fifo_wtmk * pair->channels;
+	else
+		return ctx_priv->out_params.fifo_wtmk * pair->channels;
+}
+
+static int fsl_easrc_m2m_pair_suspend(struct fsl_asrc_pair *pair)
+{
+	fsl_easrc_stop_context(pair);
+
+	return 0;
+}
+
+static int fsl_easrc_m2m_pair_resume(struct fsl_asrc_pair *pair)
+{
+	struct fsl_easrc_ctx_priv *ctx_priv = pair->private;
+
+	pair->first_convert = 1;
+	ctx_priv->in_filled_len = 0;
+
+	return 0;
+}
+
+/* val is Q31 */
+static int fsl_easrc_m2m_set_ratio_mod(struct fsl_asrc_pair *pair, int val)
+{
+	struct fsl_easrc_ctx_priv *ctx_priv = pair->private;
+	struct fsl_asrc *easrc = pair->asrc;
+	struct fsl_easrc_priv *easrc_priv = easrc->private;
+	unsigned int frac_bits;
+
+	ctx_priv->ratio_mod += val;
+
+	switch (easrc_priv->rs_num_taps) {
+	case EASRC_RS_32_TAPS:
+		/* integer bits = 5; */
+		frac_bits = 39;
+		break;
+	case EASRC_RS_64_TAPS:
+		/* integer bits = 6; */
+		frac_bits = 38;
+		break;
+	case EASRC_RS_128_TAPS:
+		/* integer bits = 7; */
+		frac_bits = 37;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	val <<= (frac_bits - 31);
+	regmap_write(easrc->regmap, REG_EASRC_RUC(pair->index), EASRC_RSUC_RS_RM(val));
+
+	return 0;
+}
+
+static int fsl_easrc_m2m_get_cap(struct fsl_asrc_m2m_cap *cap)
+{
+	cap->fmt_in = FSL_EASRC_FORMATS;
+	cap->fmt_out = FSL_EASRC_FORMATS | SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_LE;
+	cap->rate_in = SNDRV_PCM_RATE_8000_768000;
+	cap->rate_out = SNDRV_PCM_RATE_8000_768000;
+	cap->chan_min = 1;
+	cap->chan_max = 32;
+	return 0;
+}
+
 static const struct of_device_id fsl_easrc_dt_ids[] = {
 	{ .compatible = "fsl,imx8mn-easrc",},
 	{}
@@ -1926,6 +2142,16 @@ static int fsl_easrc_probe(struct platform_device *pdev)
 	easrc->release_pair = fsl_easrc_release_context;
 	easrc->get_fifo_addr = fsl_easrc_get_fifo_addr;
 	easrc->pair_priv_size = sizeof(struct fsl_easrc_ctx_priv);
+	easrc->m2m_prepare = fsl_easrc_m2m_prepare;
+	easrc->m2m_start = fsl_easrc_m2m_start;
+	easrc->m2m_stop = fsl_easrc_m2m_stop;
+	easrc->get_output_fifo_size = fsl_easrc_get_output_fifo_size;
+	easrc->m2m_calc_out_len = fsl_easrc_m2m_calc_out_len;
+	easrc->m2m_get_maxburst = fsl_easrc_m2m_get_maxburst;
+	easrc->m2m_pair_suspend = fsl_easrc_m2m_pair_suspend;
+	easrc->m2m_pair_resume = fsl_easrc_m2m_pair_resume;
+	easrc->m2m_set_ratio_mod = fsl_easrc_m2m_set_ratio_mod;
+	easrc->m2m_get_cap = fsl_easrc_m2m_get_cap;
 
 	easrc_priv->rs_num_taps = EASRC_RS_32_TAPS;
 	easrc_priv->const_coeff = 0x3FF0000000000000;
diff --git a/sound/soc/fsl/fsl_easrc.h b/sound/soc/fsl/fsl_easrc.h
index 7c70dac52713..c9f770862662 100644
--- a/sound/soc/fsl/fsl_easrc.h
+++ b/sound/soc/fsl/fsl_easrc.h
@@ -601,6 +601,8 @@ struct fsl_easrc_slot {
  * @out_missed_sample: sample missed in output
  * @st1_addexp: exponent added for stage1
  * @st2_addexp: exponent added for stage2
+ * @ratio_mod: update ratio
+ * @in_filled_len: input filled length
  */
 struct fsl_easrc_ctx_priv {
 	struct fsl_easrc_io_params in_params;
@@ -618,6 +620,8 @@ struct fsl_easrc_ctx_priv {
 	int out_missed_sample;
 	int st1_addexp;
 	int st2_addexp;
+	int ratio_mod;
+	unsigned int in_filled_len;
 };
 
 /**
-- 
2.34.1


