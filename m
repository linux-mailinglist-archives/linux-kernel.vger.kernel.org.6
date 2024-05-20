Return-Path: <linux-kernel+bounces-183830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEE38C9EAC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 16:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6E57285B50
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 14:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010FB136E32;
	Mon, 20 May 2024 14:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ntxMP1pq"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B831369AD
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 14:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716214815; cv=none; b=B/MLKFi3XNlzScI49hm33Bi8OiB4HnTMdab9BItjn8VZR/8kChKtMul3XhOCKRgum/cl1FZscOzKMPwh9BXBLjxvnYbxA9ClQaEulbQwzADp9FBjoMXe5svMLz0sXnraEwZ3nobeNxVUDYUVkG4fKNqeYxDuS0l/aNzg5JgFwcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716214815; c=relaxed/simple;
	bh=Ch9FJ4z3MUpybsvY/Xbh0HnZsJCcfkozAQNezxUTkUI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kj8OmH15PAKhsM+f2FMjTUsYX369gqrgz9sbmgHZK39MaBiyY0BJtW2aliYvT2gaZ1f+GTyqyQPk30MyqC9zzOTWe3Au1CpPg/LQIGdD+cqCRzw3xA8Xfpdk9OpOjyJNLTQ2RS0QM79LXn07vjV5V4cUVCabJJo7/PX9F0jWjB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ntxMP1pq; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4202c0d316cso12995695e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 07:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716214812; x=1716819612; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wEUon1YHmseguu1+S9mQf/195zEF4D9sn4frgRTloEU=;
        b=ntxMP1pque28O74J+xsANoWQqyAFmfIAs7I75H85kdsdVyYf5Ki/C+2W3y8Nyr+8pL
         Zx3oYBSNICTK4pfieCc7cO0uuOaz8IwJywX8NUhdAd2p31n+f4pYb9p3awsFk8q+Yqnb
         Xvy6Tl8O1oDkkJhRTZEdvIVyqVIDG8qLvTR5RYdtdGN7EjAxZ2CALgg21VWjQzGLwCBz
         87FlDodXseGjVTfKydWbZe9v17iAlYyMo3tLXZbeC9QoyJS9C6unb5VtDDxB9ueiicKi
         FlrKmzKTNoS7rQjp1PEeAKBIC8CrgPpxmDLKFI8TNvVUHeQ+KGoq+MZ4OoFo31oE4Vzc
         gYoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716214812; x=1716819612;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wEUon1YHmseguu1+S9mQf/195zEF4D9sn4frgRTloEU=;
        b=Cyb3Zf5+mYII5a1T0BH48wEYB15JIUJGoKSur5ueC9c8HRN/cJ0FRsePTNsEkk4kL5
         Vs9xsYtY5a5wusk1vz/29lhXakb/9q4jJejli/e+Els48S5nSWmNRv/oOJbWneZjg3Z5
         TwfnZ2z9dooPnuhiimqLbew06qMy8wR/zD+ImGfU6/M7ezokzh/33SGEQw2Mbf9etwwu
         K+PEYdGIQZNmOsKRt7b9ACEsSB40r8meEkx5z4LbxTGcoDboWA4F6I7zea8rjj0TgVnH
         yEzR1+Qa5c+wo/TD6xfHfXb/5qaO/X83beAxbWFdz6WQMA3URePESKaIuFh9Jg21sEn6
         g/ag==
X-Forwarded-Encrypted: i=1; AJvYcCVADhD5w3b4CLWipd9W+hLF3SBnTMeFpHAmGFrEcSmvEdEmTx3a6ySBz+3ZZ87UaTISzJ7BwghmT10RHsm4bUMNPEZVWove07sexTTY
X-Gm-Message-State: AOJu0YwUqyevJbjHuXu7L7m7kS+Qh1abhbYU/7TwJOezj7T8T1+0MFxH
	0/NBcVM8gEuWh967Kt6LZ/JRgeZLdoEoHmvftOOmiDQN2MmnmWZuZNQp+K1TrBQ=
X-Google-Smtp-Source: AGHT+IHUzosNwd66I4RPORx0mY0lfWq2SbcRlTyOnRdHejfyAQSpGq3RH0YaVFVvxZm+LAFlfuAFTw==
X-Received: by 2002:a7b:c4ca:0:b0:41a:56b7:eb37 with SMTP id 5b1f17b1804b1-420e1a03c81mr44876145e9.20.1716214812422;
        Mon, 20 May 2024 07:20:12 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccee962esm421612625e9.31.2024.05.20.07.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 07:20:11 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 20 May 2024 16:19:58 +0200
Subject: [PATCH v4 3/4] ASoC: qcom: qdsp6: Set channel mapping instead of
 fixed defaults
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240520-asoc-x1e80100-4-channel-mapping-v4-3-f657159b4aad@linaro.org>
References: <20240520-asoc-x1e80100-4-channel-mapping-v4-0-f657159b4aad@linaro.org>
In-Reply-To: <20240520-asoc-x1e80100-4-channel-mapping-v4-0-f657159b4aad@linaro.org>
To: James Schulman <james.schulman@cirrus.com>, 
 David Rhodes <david.rhodes@cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.cirrus.com, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7882;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=Ch9FJ4z3MUpybsvY/Xbh0HnZsJCcfkozAQNezxUTkUI=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmS1wUf2oripGEvBkcrPo42DDTF9UP8Q8weHDwp
 Qvz0LOFaRGJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZktcFAAKCRDBN2bmhouD
 1xpSD/9Zuq3qb30zicly4zWVmFpAI+VDd0ETscZGKmFhV0HeX0jtMeFcxGIb/m1GE1xyxZIx5LI
 4ZBUjh1qixISNeFZdy1Dhur6dGwzICYyGZU3YnGAmkk9LvyWmfD3AzrqQ/lyEKHgfGkJi/sSDsh
 GzmhToq6z947LBa8dHC04Lm9VmLsz15T98wo+2RjcR5MTYaaxpa+y4hLnh6WqVvfJ+7G3Aism7E
 zOgCQDMyGkuS+Ts1BRaJOFO832gsd+S94x0VAHUteF3winIJuBCmCMvS72bOKPawL/mvzEiKEyV
 xXhsg7RPeXFtmozFCUl38k3GW9pCIs6t5e19gVEahG5EHnvCX224DhCd/WEwbIQjRXubrZz9+Xb
 ocPnWcVS5ApSJ4uXklZMuejjuZPmg/g1FAVo2536hUh9s67qUt+v9KsVHf5CtAQqo6KT81prbta
 wRvnNyPkswVT0PZDkxn+7KhQdybvUzoR3QpqlAa7Eo3sBNz0z3SEt86bsuJ7BQz6UYYUbIvympA
 xwejd+pgF+7YHGsGETtSHY+fjQFDCRwW+LTb/OQs9uGWvlVj7szBFA4+8/C6sXIRmiTupZpqWSt
 VPfMxUmjmycigLciRFhsI4L3pPB38JgiDarlsehkr9scRAGGQ8qxLd5kom3OkRigtTMiDDuCOXs
 vb0RbI4wn844gLw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

When constructing packets to DSP, the Audioreach code uses 'struct
audioreach_module_config' to configure parameters like number of
channels, bitrate, sample rate etc, but uses defaults for the channel
mapping.

Rework this code to copy the channel mapping from 'struct
audioreach_module_config', instead of using the default.  This requires
all callers to fill that structure: add missing initialization of
channel mapping.

Entire patch makes code more logical and easier to follow:
1. q6apm-dai and q6apm-lpass-dais code which allocates 'struct
   audioreach_module_config' initializes it fully, so fills both
   the number of channels and the channel mapping.
2. Audioreach code, which uses 'struct audioreach_module_config' when
   constructing packets, copies entire contents of passed config, not
   only pieces of it.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v4:
1. Rename audioreach_set_channel_mapping -> audioreach_set_default_channel_mapping

Changes in v2:
1. Extend commit msg, rationale.
2. Rework to new approach, but most of the code stays.
3. Export audioreach_set_channel_mapping() (needed by Q6APM DAIS and
   LPASS DAIS)
4. Correct channel mapping also in audioreach_mfc_set_media_format(),
   because MFC DAI is now part of backend.
5. Do not adjust dynamic DAIs (drop audioreach_dai_load()).
---
 sound/soc/qcom/qdsp6/audioreach.c       | 30 +++++++-----------------------
 sound/soc/qcom/qdsp6/audioreach.h       |  1 +
 sound/soc/qcom/qdsp6/q6apm-dai.c        |  3 +++
 sound/soc/qcom/qdsp6/q6apm-lpass-dais.c |  5 ++++-
 4 files changed, 15 insertions(+), 24 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/audioreach.c b/sound/soc/qcom/qdsp6/audioreach.c
index 5291deac0a0b..4ebaaf736fb9 100644
--- a/sound/soc/qcom/qdsp6/audioreach.c
+++ b/sound/soc/qcom/qdsp6/audioreach.c
@@ -267,7 +267,7 @@ void *audioreach_alloc_apm_cmd_pkt(int pkt_size, uint32_t opcode, uint32_t token
 }
 EXPORT_SYMBOL_GPL(audioreach_alloc_apm_cmd_pkt);
 
-static void audioreach_set_channel_mapping(u8 *ch_map, int num_channels)
+void audioreach_set_default_channel_mapping(u8 *ch_map, int num_channels)
 {
 	if (num_channels == 1) {
 		ch_map[0] =  PCM_CHANNEL_FL;
@@ -281,6 +281,7 @@ static void audioreach_set_channel_mapping(u8 *ch_map, int num_channels)
 		ch_map[3] =  PCM_CHANNEL_RS;
 	}
 }
+EXPORT_SYMBOL_GPL(audioreach_set_default_channel_mapping);
 
 static void apm_populate_container_config(struct apm_container_obj *cfg,
 					  struct audioreach_container *cont)
@@ -819,7 +820,7 @@ static int audioreach_mfc_set_media_format(struct q6apm_graph *graph,
 	uint32_t num_channels = cfg->num_channels;
 	int payload_size;
 	struct gpr_pkt *pkt;
-	int rc;
+	int rc, i;
 	void *p;
 
 	payload_size = APM_MFC_CFG_PSIZE(media_format, num_channels) +
@@ -842,18 +843,8 @@ static int audioreach_mfc_set_media_format(struct q6apm_graph *graph,
 	media_format->sample_rate = cfg->sample_rate;
 	media_format->bit_width = cfg->bit_width;
 	media_format->num_channels = cfg->num_channels;
-
-	if (num_channels == 1) {
-		media_format->channel_mapping[0] = PCM_CHANNEL_FL;
-	} else if (num_channels == 2) {
-		media_format->channel_mapping[0] = PCM_CHANNEL_FL;
-		media_format->channel_mapping[1] = PCM_CHANNEL_FR;
-	} else if (num_channels == 4) {
-		media_format->channel_mapping[0] = PCM_CHANNEL_FL;
-		media_format->channel_mapping[1] = PCM_CHANNEL_FR;
-		media_format->channel_mapping[2] = PCM_CHANNEL_LS;
-		media_format->channel_mapping[3] = PCM_CHANNEL_RS;
-	}
+	for (i = 0; i < num_channels; i++)
+		media_format->channel_mapping[i] = cfg->channel_map[i];
 
 	rc = q6apm_send_cmd_sync(graph->apm, pkt, 0);
 
@@ -883,9 +874,6 @@ static int audioreach_set_compr_media_format(struct media_format *media_fmt_hdr,
 		mp3_cfg->q_factor = mcfg->bit_width - 1;
 		mp3_cfg->endianness = PCM_LITTLE_ENDIAN;
 		mp3_cfg->num_channels = mcfg->num_channels;
-
-		audioreach_set_channel_mapping(mp3_cfg->channel_mapping,
-					       mcfg->num_channels);
 		break;
 	case SND_AUDIOCODEC_AAC:
 		media_fmt_hdr->data_format = DATA_FORMAT_RAW_COMPRESSED;
@@ -1104,9 +1092,7 @@ static int audioreach_pcm_set_media_format(struct q6apm_graph *graph,
 	media_cfg->num_channels = mcfg->num_channels;
 	media_cfg->q_factor = mcfg->bit_width - 1;
 	media_cfg->bits_per_sample = mcfg->bit_width;
-
-	audioreach_set_channel_mapping(media_cfg->channel_mapping,
-				       num_channels);
+	memcpy(media_cfg->channel_mapping, mcfg->channel_map, mcfg->num_channels);
 
 	rc = q6apm_send_cmd_sync(graph->apm, pkt, 0);
 
@@ -1163,9 +1149,7 @@ static int audioreach_shmem_set_media_format(struct q6apm_graph *graph,
 		cfg->q_factor = mcfg->bit_width - 1;
 		cfg->endianness = PCM_LITTLE_ENDIAN;
 		cfg->num_channels = mcfg->num_channels;
-
-		audioreach_set_channel_mapping(cfg->channel_mapping,
-					       num_channels);
+		memcpy(cfg->channel_mapping, mcfg->channel_map, mcfg->num_channels);
 	} else {
 		rc = audioreach_set_compr_media_format(header, p, mcfg);
 		if (rc) {
diff --git a/sound/soc/qcom/qdsp6/audioreach.h b/sound/soc/qcom/qdsp6/audioreach.h
index eb9306280988..61a69df4f50f 100644
--- a/sound/soc/qcom/qdsp6/audioreach.h
+++ b/sound/soc/qcom/qdsp6/audioreach.h
@@ -766,6 +766,7 @@ struct audioreach_module_config {
 /* Packet Allocation routines */
 void *audioreach_alloc_apm_cmd_pkt(int pkt_size, uint32_t opcode, uint32_t
 				    token);
+void audioreach_set_default_channel_mapping(u8 *ch_map, int num_channels);
 void *audioreach_alloc_cmd_pkt(int payload_size, uint32_t opcode,
 			       uint32_t token, uint32_t src_port,
 			       uint32_t dest_port);
diff --git a/sound/soc/qcom/qdsp6/q6apm-dai.c b/sound/soc/qcom/qdsp6/q6apm-dai.c
index 00bbd291be5c..3361c10d69a4 100644
--- a/sound/soc/qcom/qdsp6/q6apm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6apm-dai.c
@@ -243,6 +243,7 @@ static int q6apm_dai_prepare(struct snd_soc_component *component,
 	cfg.num_channels = runtime->channels;
 	cfg.bit_width = prtd->bits_per_sample;
 	cfg.fmt = SND_AUDIOCODEC_PCM;
+	audioreach_set_default_channel_mapping(cfg.channel_map, runtime->channels);
 
 	if (prtd->state) {
 		/* clear the previous setup if any  */
@@ -669,6 +670,8 @@ static int q6apm_dai_compr_set_params(struct snd_soc_component *component,
 		cfg.num_channels = 2;
 		cfg.bit_width = prtd->bits_per_sample;
 		cfg.fmt = codec->id;
+		audioreach_set_default_channel_mapping(cfg.channel_map,
+						       cfg.num_channels);
 		memcpy(&cfg.codec, codec, sizeof(*codec));
 
 		ret = q6apm_graph_media_format_shmem(prtd->graph, &cfg);
diff --git a/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c b/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
index a4ad1d0e6abd..ba28ec9dff86 100644
--- a/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
+++ b/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
@@ -106,6 +106,7 @@ static int q6hdmi_hw_params(struct snd_pcm_substream *substream,
 	cfg->bit_width = params_width(params);
 	cfg->sample_rate = params_rate(params);
 	cfg->num_channels = channels;
+	audioreach_set_default_channel_mapping(cfg->channel_map, channels);
 
 	switch (dai->id) {
 	case DISPLAY_PORT_RX_0:
@@ -130,10 +131,12 @@ static int q6dma_hw_params(struct snd_pcm_substream *substream,
 {
 	struct q6apm_lpass_dai_data *dai_data = dev_get_drvdata(dai->dev);
 	struct audioreach_module_config *cfg = &dai_data->module_config[dai->id];
+	int channels = hw_param_interval_c(params, SNDRV_PCM_HW_PARAM_CHANNELS)->max;
 
 	cfg->bit_width = params_width(params);
 	cfg->sample_rate = params_rate(params);
-	cfg->num_channels = hw_param_interval_c(params, SNDRV_PCM_HW_PARAM_CHANNELS)->max;
+	cfg->num_channels = channels;
+	audioreach_set_default_channel_mapping(cfg->channel_map, channels);
 
 	return 0;
 }

-- 
2.43.0


