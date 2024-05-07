Return-Path: <linux-kernel+bounces-171098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 599508BDFB8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 12:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E96C288040
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 10:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810E914E2EF;
	Tue,  7 May 2024 10:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rhvo6yVR"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CB614EC5F
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 10:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715077669; cv=none; b=EIeDayz62OwLY2gG9wZL0LF0JhwzjVuIijYLli6veswsyLaru6wVqN1y2GkH4nQ1dXIiHxSFjt6FZR8aFWUSbDrmTikYyWHMFarbnPz91lr9uI9qY2jSXVzLOIhY+hTvO/43VNJE+Lro2U4TKRf7REBw8YbiRcpOhIZDythWmS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715077669; c=relaxed/simple;
	bh=w+Fl9c8AtnA+l9Cg99+RBTFrfVWFNV6HnWmwPoSsPcg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iWV29Ia1Z3s5oDIQS5YZybcp6vvGIWtydyp92JjgYHzCJDVuaxgX4EHwOF2EtEINx1ZzWjS2uSwZ5IkmP/zSPS4Xwa2JIZBKTXG6PvLLpG6kIzaJGhHNwHScrZetFvfqNY92fCZc3ZIegxc0e5LFqN7wsbOK8F/D/j3Uz2NDM5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rhvo6yVR; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a59ece5e18bso134638766b.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 03:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715077666; x=1715682466; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=frwVb4bQCosSJuHrr/Xjlu4xhpYBhEr8JVc+TOrLf3o=;
        b=rhvo6yVRO3lA96Xm578YOIKIGFsiRZjzSmmF2qQEsuAEzPjraUFLt5kPKv9cZdCcIN
         v+Ul0ElZfzDW3BYB1M/b9XJPLON1+drigHfO1azQ2jhPfqUzTr5CVfLPBHRvoLdjTsd+
         uKsPQ9dhIu9fckWNtJtfDtruw5WKgxshAl3VVEKNOrQAGcqln94iKkAcu6mbJD5cr6Bf
         E4OeEfoTIWMTnckpaL1BlpTncYEXPNiqCZJfu7quYREu2b8CzkbYxdbl0bOSfausBVRU
         naqMKVtGyp8uKOCwV9Eh0c1w3Oh6PU/6ToAzHwIc5vDE+rWCel/ZZiiko+r2MJ0l/D97
         BITQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715077666; x=1715682466;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=frwVb4bQCosSJuHrr/Xjlu4xhpYBhEr8JVc+TOrLf3o=;
        b=akDzCsxnt0JfH41CaUiLiTQ1VCN9uYXKaHfbxSQggkabgTRyCBHKYSkAXHIivUzJqP
         D8WTBKVYeT6JOpr/C/slkvaZAyB3s6mzDDDTy9XOlWyEiAs7vOmNsOeduKO/ydWwjJym
         xROpZX0ilu8gomeNcNcNdUnw1MfCYixAQfyesocnmKZjRDo7RuWRl38grER8hVC/DVAP
         phiYSPDNhyBcx9euLIz1+ICQR6gjnCKcNhGVLYggUQOdLvYxwJ3McslQtHwH8K7vcODN
         cNpDJ8fu/bcmOvzDacyhy8zpo0LVnE11R89+OCAUnLYZJocYdGU+sXau8TJJB2Kff4EH
         2vxw==
X-Forwarded-Encrypted: i=1; AJvYcCX7NqOLchWWfBHwndhDfotsuWco+pe50fzbTUL911hitMm5rXMxMafU2+mST4tTQTU7UkUgANHDUkrD89HImsAkLPyf4ERREMsttKXR
X-Gm-Message-State: AOJu0YwQo3pBOrXB7FNwpIgWTkunhd9M/DI7PKTF0Jfw8sMS896ZiLCd
	HEXEPyyw5UqPDYu0KbClCUkNPUm7N3j2DMXnz6EpsjkuQj5kUlMsMOfdoqi2KYA=
X-Google-Smtp-Source: AGHT+IHboeLxH9ZlC99nEXUe5Xp5uK4F4Ftf7MB/od/D3dIouLXpgXrm5GbrxBLT3K4oEU8bz77mNw==
X-Received: by 2002:a17:906:c415:b0:a59:a977:a159 with SMTP id u21-20020a170906c41500b00a59a977a159mr7420468ejz.64.1715077666141;
        Tue, 07 May 2024 03:27:46 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id bo15-20020a170906d04f00b00a59b87dd0bbsm3370093ejb.161.2024.05.07.03.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 03:27:45 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 07 May 2024 12:27:31 +0200
Subject: [PATCH 2/4] ASoC: qcom: q6dsp: Implement proper channel mapping in
 Audioreach
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240507-asoc-x1e80100-4-channel-mapping-v1-2-b12c13e0a55d@linaro.org>
References: <20240507-asoc-x1e80100-4-channel-mapping-v1-0-b12c13e0a55d@linaro.org>
In-Reply-To: <20240507-asoc-x1e80100-4-channel-mapping-v1-0-b12c13e0a55d@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5679;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=w+Fl9c8AtnA+l9Cg99+RBTFrfVWFNV6HnWmwPoSsPcg=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmOgIaKvmANyZKclREQrsCajh6i81LFK/Hyjt3l
 OEPizCxqTqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZjoCGgAKCRDBN2bmhouD
 1+sMD/90/buBkgY9ho+CVgCsV9DM/H02icdUsmdJiwuG/OCPvTtxuhMqj6GJC4AehbBP7hNPPT2
 cNGSXyo/Hhuni/1SQBMTENd7dDpm1/HlcQZohfB3KguU8gd3fmYk5/lEjJrJzf4KNz7FJSQhW+4
 48sjo3c23reJCJLpnwgf0a4s9Lu/Hx0Y8n4j3M7+KW5lLP6l2NeawGsxMqA1BQhhbimlVrselDM
 35i3dM6uufruxzq+SsEKofs62e583ev9SGUVLoNJgp0LndyW4x/vk5zjJvGA/UGPXC4twme5uhL
 9pG0queC+Uw0xrdjt1Ldug2NDgKj1JjWI2FcDY2IKBHeHBghbDgHpwokHlvg/KXD+SVvBKuCk/o
 65cWEWJe8EDmVoI3d4wq/owSVc7ZQWdsOBLo6+XYEXBOvE1MO1pWVRu56qzb/whCJotGZbkyTFo
 vWtfG02mIC9TUSAtGE9YYKiyQEFsDE5pXrLWDQNvL9HqFwDdSGUgSc0BLjkg/YhAkNRh4LQO2UT
 3SAfnjqlp1HoR2fToqzcSVSp5JZ3gIsOInJKDyZOVe93dKCp5BUBIXEm2t0vHe6CUm0T2C6wXHl
 5WWxmxR4IAj8wvE9r/HF+W4K6L5lK8i4R9levS2CQMMAHvR1Ag4KdwPKq55OPRyWOl1JHge6ltC
 7LNJn2vkCcQwugg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Instead of relying on default channel mapping in all Audioreach
platforms, implement set_channel_map() callback to allow sound cards
customize the mapping depending on needs.

The channel mapping is set on frontend DAIs coming from the topology,
not DTS, thus need to add DAI ops in topology dai_load() callback.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/qcom/qdsp6/audioreach.c |  2 +-
 sound/soc/qcom/qdsp6/audioreach.h |  1 +
 sound/soc/qcom/qdsp6/q6apm.c      | 28 +++++++++++++++++++++++++++-
 sound/soc/qcom/qdsp6/q6apm.h      |  8 ++++++++
 sound/soc/qcom/qdsp6/topology.c   | 12 ++++++++++++
 5 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/audioreach.c b/sound/soc/qcom/qdsp6/audioreach.c
index c655f0213723..8175678d8843 100644
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
diff --git a/sound/soc/qcom/qdsp6/audioreach.h b/sound/soc/qcom/qdsp6/audioreach.h
index 2c82917b7162..cef9a9015dcc 100644
--- a/sound/soc/qcom/qdsp6/audioreach.h
+++ b/sound/soc/qcom/qdsp6/audioreach.h
@@ -767,6 +767,7 @@ struct audioreach_module_config {
 /* Packet Allocation routines */
 void *audioreach_alloc_apm_cmd_pkt(int pkt_size, uint32_t opcode, uint32_t
 				    token);
+void audioreach_set_channel_mapping(u8 *ch_map, int num_channels);
 void *audioreach_alloc_cmd_pkt(int payload_size, uint32_t opcode,
 			       uint32_t token, uint32_t src_port,
 			       uint32_t dest_port);
diff --git a/sound/soc/qcom/qdsp6/q6apm.c b/sound/soc/qcom/qdsp6/q6apm.c
index 2a2a5bd98110..c29a2dd36992 100644
--- a/sound/soc/qcom/qdsp6/q6apm.c
+++ b/sound/soc/qcom/qdsp6/q6apm.c
@@ -13,6 +13,7 @@
 #include <linux/soc/qcom/apr.h>
 #include <linux/wait.h>
 #include <sound/soc.h>
+#include <sound/soc-dai.h>
 #include <sound/soc-dapm.h>
 #include <sound/pcm.h>
 #include "audioreach.h"
@@ -29,6 +30,29 @@ struct apm_graph_mgmt_cmd {
 
 static struct q6apm *g_apm;
 
+static int q6apm_dai_set_channel_map(struct snd_soc_dai *dai,
+				     unsigned int tx_num,
+				     const unsigned int *tx_ch_mask,
+				     unsigned int rx_num,
+				     const unsigned int *rx_ch_mask)
+{
+	struct q6apm *apm = dev_get_drvdata(dai->dev);
+	int i;
+
+	if (dai->id >= ARRAY_SIZE(apm->dai_config))
+		return -EINVAL;
+
+	apm->dai_config[dai->id].num_channels = rx_num;
+	for (i = 0; i < rx_num; i++)
+		apm->dai_config[dai->id].channel_map[i] = rx_ch_mask[i];
+
+	return 0;
+}
+
+const struct snd_soc_dai_ops q6apm_dai_ops = {
+	.set_channel_map	= q6apm_dai_set_channel_map,
+};
+
 int q6apm_send_cmd_sync(struct q6apm *apm, struct gpr_pkt *pkt, uint32_t rsp_opcode)
 {
 	gpr_device_t *gdev = apm->gdev;
@@ -722,7 +746,7 @@ static int apm_probe(gpr_device_t *gdev)
 {
 	struct device *dev = &gdev->dev;
 	struct q6apm *apm;
-	int ret;
+	int ret, i;
 
 	apm = devm_kzalloc(dev, sizeof(*apm), GFP_KERNEL);
 	if (!apm)
@@ -733,6 +757,8 @@ static int apm_probe(gpr_device_t *gdev)
 	mutex_init(&apm->lock);
 	apm->dev = dev;
 	apm->gdev = gdev;
+	for (i = 0; i < ARRAY_SIZE(apm->dai_config); i++)
+		audioreach_set_channel_mapping(apm->dai_config[i].channel_map, 4);
 	init_waitqueue_head(&apm->wait);
 
 	INIT_LIST_HEAD(&apm->widget_list);
diff --git a/sound/soc/qcom/qdsp6/q6apm.h b/sound/soc/qcom/qdsp6/q6apm.h
index c248c8d2b1ab..0e2e7b6cd6c1 100644
--- a/sound/soc/qcom/qdsp6/q6apm.h
+++ b/sound/soc/qcom/qdsp6/q6apm.h
@@ -47,6 +47,11 @@
 #define APM_LAST_BUFFER_FLAG			BIT(30)
 #define NO_TIMESTAMP				0xFF00
 
+struct q6apm_dai_config {
+	unsigned int num_channels;
+	u8 channel_map[AR_PCM_MAX_NUM_CHANNEL];
+};
+
 struct q6apm {
 	struct device *dev;
 	gpr_port_t *port;
@@ -65,6 +70,7 @@ struct q6apm {
 	struct idr sub_graphs_idr;
 	struct idr containers_idr;
 	struct idr modules_idr;
+	struct q6apm_dai_config dai_config[4];
 };
 
 struct audio_buffer {
@@ -108,6 +114,8 @@ struct q6apm_graph {
 	struct audioreach_graph_info *info;
 };
 
+extern const struct snd_soc_dai_ops q6apm_dai_ops;
+
 /* Graph Operations */
 struct q6apm_graph *q6apm_graph_open(struct device *dev, q6apm_cb cb,
 				     void *priv, int graph_id);
diff --git a/sound/soc/qcom/qdsp6/topology.c b/sound/soc/qcom/qdsp6/topology.c
index 70572c83e101..9708d200568d 100644
--- a/sound/soc/qcom/qdsp6/topology.c
+++ b/sound/soc/qcom/qdsp6/topology.c
@@ -1034,6 +1034,17 @@ static int audioreach_tplg_complete(struct snd_soc_component *component)
 	return 0;
 }
 
+static int audioreach_dai_load(struct snd_soc_component *cmp, int index,
+			       struct snd_soc_dai_driver *dai_drv,
+			       struct snd_soc_tplg_pcm *pcm,
+			       struct snd_soc_dai *dai)
+{
+	if (pcm)
+		dai_drv->ops = &q6apm_dai_ops;
+
+	return 0;
+}
+
 /* DAI link - used for any driver specific init */
 static int audioreach_link_load(struct snd_soc_component *component, int index,
 				struct snd_soc_dai_link *link,
@@ -1251,6 +1262,7 @@ static struct snd_soc_tplg_ops audioreach_tplg_ops  = {
 	.widget_unload = audioreach_widget_unload,
 
 	.complete = audioreach_tplg_complete,
+	.dai_load = audioreach_dai_load,
 	.link_load = audioreach_link_load,
 
 	.dapm_route_load	= audioreach_route_load,

-- 
2.43.0


