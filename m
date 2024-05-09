Return-Path: <linux-kernel+bounces-174217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 929D08C0BBF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 08:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C7C81F24CAD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 06:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC668149C62;
	Thu,  9 May 2024 06:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eJBxMasF"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA01B13CA84
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 06:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715237531; cv=none; b=Xs8zcJ476YhIlsB622CUZPimSIN7MBpp4yLlRdfNrCtr9ZS5Rmy4huuMVASzxh1MX1k7GiZ9sT3+a20GQ4EEVEOIW75PT9T/KPjjt2vIm8TophBQNwZ7HkJQLAKuAJJsOt5jO8IPIzM79etCC7x2j+d9ObuWMIRzsU71TFNlLDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715237531; c=relaxed/simple;
	bh=cMddYFvxag2xiuk6mbkfydpMJeegTn2R9D7VIBWz/p4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lsc96+q0p1QxYxkGNWVNXK2auBg/awbgpuKDoJScra4SMSw7AWiAMlVps7ZrScIn1nNtkB8RBPMmwCUSsyvlbLOoRS3nE/IhTC0ol2hsyMBz6KNhsCbi9GRwwf6mZcjt+7QkJPCEAR1IRZpeNRhL3R+wc42XWmnF/HF2QmIhziE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eJBxMasF; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a59a0168c75so130358966b.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 23:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715237528; x=1715842328; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0d/mfFuQBbC2bnLXnrpmIq7nUGA3L1YuLtXQ7YCcvk8=;
        b=eJBxMasFNt0lMdy/ws8UCdUQBh+Do9lZ5xYZROqJU9nLfyX6r9iDaseuAoP+RS80dX
         wVKmS/rZFXjReq/CfqYvLOxYhF5OZru/y2GF3nZ5HL5XChTz8meX78DZWpUF73VFnnuB
         0QK57JkIh3ZIN8x0pYdbfn6ksMFg76UhxTBg1l8oBl38vpv3LN/Yo3Jg9Tz1hlTfHx9i
         lBi3rC+ZEbhWJx87XKreZhgLvG7RCIqY2wn6zzKmKgmQr0da+K3h7UBYQRxZXdvFuHU4
         hEL2y8Tvk4LVkxEBer1Tx9cRnrnMrJQAzpfH7NVyGEgVZ56N+yD+sy7v3AURxmoDssXO
         G6iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715237528; x=1715842328;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0d/mfFuQBbC2bnLXnrpmIq7nUGA3L1YuLtXQ7YCcvk8=;
        b=BsCZD0k6GlVtbM6XuvTlk262/IgStVSuVhR7cRToLnCGZq0K7KsOVcvOdWqiQOl7j9
         OXQjRkuwadHmZDG3XiRQAV/LYqGP7ZreT9wNyBvTbwJJkZtrIEVi/vgw99iv3Ww429v7
         NtzmVFXJHUsmXBzxWhxIXvDBXDQU+28r66NsYqObQc5R/no060xHyf/ylJQ5DbpoO5nr
         so/FIuY6DVGhny1GOAQTTMqhD419Kidlg3X+uikgYbp3FALt7ZgxYi6FZTxFfNTeI0gL
         qIscuR/nq7JgslFGZrIOUTABv/8oUJBtdUoHRxQPa5SRzTDyGDeuynhkX2Tqg46NCrKR
         pXvg==
X-Forwarded-Encrypted: i=1; AJvYcCVdEYmy02JJ1RwdQXu6nhuP3GvqdzwxQ+Csft+aLW1mrNUYGK7v3iavBzS82vY4EnCO+FOJVdC90s8SoQMppqJjUKchFqzAOOKiivUE
X-Gm-Message-State: AOJu0YxfpMqCak2xlIwAZZ02iP5CkOLTEqpV4AAJFqikSpqSO5xtIJYp
	ELwnQ4XrRBD1kBWY4GvQ8s8Ihh0/1FIQSTpJONHEih1FCRzRkiIkktdTDbNN3ww=
X-Google-Smtp-Source: AGHT+IHXWDmpTWjm83JM1Odz9WtKk/fSMMbxTvoQu4rXZ9dPeaGdZ/Vou9HkQboCWiCEvYPkSVx/Gg==
X-Received: by 2002:a17:906:6897:b0:a59:9c58:763a with SMTP id a640c23a62f3a-a59fb96c049mr262943866b.46.1715237528220;
        Wed, 08 May 2024 23:52:08 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c81b4sm40730966b.113.2024.05.08.23.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 23:52:07 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 09 May 2024 08:51:54 +0200
Subject: [PATCH v3 3/4] ASoC: qcom: qdsp6: Set channel mapping instead of
 fixed defaults
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240509-asoc-x1e80100-4-channel-mapping-v3-3-6f874552d7b2@linaro.org>
References: <20240509-asoc-x1e80100-4-channel-mapping-v3-0-6f874552d7b2@linaro.org>
In-Reply-To: <20240509-asoc-x1e80100-4-channel-mapping-v3-0-6f874552d7b2@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7708;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=cMddYFvxag2xiuk6mbkfydpMJeegTn2R9D7VIBWz/p4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmPHKPF6bT8wKWJJxouJVODPjfAHwFvrzY3BhSe
 hZIEEjtUbuJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZjxyjwAKCRDBN2bmhouD
 1zj9D/0UwhySIjfTYbj18Ah9NLjwLDetvEluojrv1dGJUSXOK9xDXczS1dkHEMOgSwp/OsMLgzW
 w+/1l3W48+oJt0ZWBlLUAm1o3oQpKSwkSDJFO+WdJ+a89neEl/cnbqs5MraGFIhWELQjT9ysZLT
 stNljlRm25gnbQsrTex9G65Ca764k/HPba7w1UZLPbPIEE5I3hN+k6sfBSCzWT29MrYBLj0B8eR
 Qmkm1YGypVC1vgJ0jVzGSIcTFvFO/Ws2J9/8+UMNhRzIM1eEGrHsegJDqDKalyiN0RYBexE0cQ1
 sPk7sOpGmmGJwJmT0rvRBEmmFocX+LuLzmE3nncyFP68DmMNFAQ+Tb7hxAljbCSh8AX5uKG0WTb
 TDiRIPzwS7a5q5s9CzHzzL3JVp7l/Na5Mb9sdHbBHg95sXN+K3YbctsWoMrWK+rk7v3kHp4C54b
 YlNL7/0VW+0MCkhqYSPuInSczUDnz0P33kFZWI8kTac2CkTtGxK553ypYgRW4ehrNoLiuzYSALo
 3C5MWcIBfSGLeuEequ3g0g9tJMCerK08yAIpX9HbgEgw2qVqwOe4iScuLdBvGLkgmeGAFQ7d6pD
 7vITFENcQRlAKEKzi0E4skwUzLqErcLlmiQyEVIpiJ/+IEMaEEEw6GL2DZ5WwM39KyPRncXO23v
 Y/JODKn9anmfZ3A==
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
 sound/soc/qcom/qdsp6/q6apm-dai.c        |  2 ++
 sound/soc/qcom/qdsp6/q6apm-lpass-dais.c |  5 ++++-
 4 files changed, 14 insertions(+), 24 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/audioreach.c b/sound/soc/qcom/qdsp6/audioreach.c
index 5291deac0a0b..750b8ba64211 100644
--- a/sound/soc/qcom/qdsp6/audioreach.c
+++ b/sound/soc/qcom/qdsp6/audioreach.c
@@ -267,7 +267,7 @@ void *audioreach_alloc_apm_cmd_pkt(int pkt_size, uint32_t opcode, uint32_t token
 }
 EXPORT_SYMBOL_GPL(audioreach_alloc_apm_cmd_pkt);
 
-static void audioreach_set_channel_mapping(u8 *ch_map, int num_channels)
+void audioreach_set_channel_mapping(u8 *ch_map, int num_channels)
 {
 	if (num_channels == 1) {
 		ch_map[0] =  PCM_CHANNEL_FL;
@@ -281,6 +281,7 @@ static void audioreach_set_channel_mapping(u8 *ch_map, int num_channels)
 		ch_map[3] =  PCM_CHANNEL_RS;
 	}
 }
+EXPORT_SYMBOL_GPL(audioreach_set_channel_mapping);
 
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
index eb9306280988..208b74e50445 100644
--- a/sound/soc/qcom/qdsp6/audioreach.h
+++ b/sound/soc/qcom/qdsp6/audioreach.h
@@ -766,6 +766,7 @@ struct audioreach_module_config {
 /* Packet Allocation routines */
 void *audioreach_alloc_apm_cmd_pkt(int pkt_size, uint32_t opcode, uint32_t
 				    token);
+void audioreach_set_channel_mapping(u8 *ch_map, int num_channels);
 void *audioreach_alloc_cmd_pkt(int payload_size, uint32_t opcode,
 			       uint32_t token, uint32_t src_port,
 			       uint32_t dest_port);
diff --git a/sound/soc/qcom/qdsp6/q6apm-dai.c b/sound/soc/qcom/qdsp6/q6apm-dai.c
index 00bbd291be5c..8ab55869e8a2 100644
--- a/sound/soc/qcom/qdsp6/q6apm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6apm-dai.c
@@ -243,6 +243,7 @@ static int q6apm_dai_prepare(struct snd_soc_component *component,
 	cfg.num_channels = runtime->channels;
 	cfg.bit_width = prtd->bits_per_sample;
 	cfg.fmt = SND_AUDIOCODEC_PCM;
+	audioreach_set_channel_mapping(cfg.channel_map, runtime->channels);
 
 	if (prtd->state) {
 		/* clear the previous setup if any  */
@@ -669,6 +670,7 @@ static int q6apm_dai_compr_set_params(struct snd_soc_component *component,
 		cfg.num_channels = 2;
 		cfg.bit_width = prtd->bits_per_sample;
 		cfg.fmt = codec->id;
+		audioreach_set_channel_mapping(cfg.channel_map, cfg.num_channels);
 		memcpy(&cfg.codec, codec, sizeof(*codec));
 
 		ret = q6apm_graph_media_format_shmem(prtd->graph, &cfg);
diff --git a/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c b/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
index a4ad1d0e6abd..8340e4fb78f4 100644
--- a/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
+++ b/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
@@ -106,6 +106,7 @@ static int q6hdmi_hw_params(struct snd_pcm_substream *substream,
 	cfg->bit_width = params_width(params);
 	cfg->sample_rate = params_rate(params);
 	cfg->num_channels = channels;
+	audioreach_set_channel_mapping(cfg->channel_map, channels);
 
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
+	audioreach_set_channel_mapping(cfg->channel_map, channels);
 
 	return 0;
 }

-- 
2.43.0


