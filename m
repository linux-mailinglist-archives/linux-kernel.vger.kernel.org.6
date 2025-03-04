Return-Path: <linux-kernel+bounces-543929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71546A4DB8F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39B377A8288
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050C01FF5FB;
	Tue,  4 Mar 2025 10:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uy/lLvWZ"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4451FE472
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 10:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741085875; cv=none; b=SGD58qB6qGHBq2OeEVEX/9tIcKqZq5K+8KW380XDb8h/PvAH0ZRrgxed+jVd2W/0EaI0wc6Wd/GTZd6ehDwFbq5YTkJlRMJzXzSIDkxV4VuulUAIfE7tq/7Zp/E3UFb1plFGeyrpkt8AMSHyjg6HssHPkAxA/6Uu5psmrkFkDJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741085875; c=relaxed/simple;
	bh=a8wBb5Pu3Xn+ai4AGmTn/n+jSwHVc64nuzgsrIqk6KU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rimuduWfHMzhFxbY+8Io3s5/hk4WuNP0ImeqFeYW02ot/whvjnMkz73FsGZC8MQ9vgxuCNKWL177jkZe4zoyR9RDHyJcH8pvVd0d8Cw5ieeszw9/5RQKq8ctLcVk/p06BqeoXCudqH6zTaQh9rm/4YY0U1n90G78CDmv9oFiJW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uy/lLvWZ; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e53b3fa7daso3716530a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 02:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741085872; x=1741690672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i0rt3fuU/Pf0rTgHYvdRPIfkUIcPPHNUBjw5GiQRLAs=;
        b=uy/lLvWZvtHfrQojVjj6SGU9ht9lfSFUHl06//CTzn9UZAGG3trTM+gYW66nD+pJhL
         C5xvfIM6DDHBA2KjO4iZrx6IwDKhdbm4u5slo+VeXQhZ766ixAH8YDUA/uCTjM4ZfyUL
         QXhNTG8JQXq+kmzNVi8oSRdshOe4EraWYNjd59ZhHAtpkdo+1j+V70dqClR69oLjR5Gk
         HC3+JCF+mlHiZT0ISG7HCftanfbObb8KLqRRA3Gu4sk2/9rR/vlvT/JGPfIjZqoKXM2x
         K8AAxUNO0cnJ+Z4du7+RlYvKVRvRzfLB46GUqS4JsWIkWzqEBPSTVMx/q2+JXfgl5MqY
         zpFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741085872; x=1741690672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i0rt3fuU/Pf0rTgHYvdRPIfkUIcPPHNUBjw5GiQRLAs=;
        b=ckDa6PmKxDkV0wfaNsC+u9A9+z4UWY2l3wHl7RKCSOQrJLV7hA7YFziLX/MnNINY1e
         XC4QC1VBosxDwhUSItrBwMLiAokFSCgMspOCKZqvcmIxh8Grx7EQd5mMw+hAo9oXzLMH
         e4+Zs5lnq9lQgS/q3EHP0KfdKlX7ZsBIwt+enUcUT0DZZMxEvo7t4CzzJTvesy9hBZQM
         hsxeL75xbw+ruNf1vEFpclukIlH1qYApk0dt2Rnwn4bIqoIEVAGwC55144fW08OoCJ7N
         cioM7xwaDYgycempqbiZr0+LKCS12fRtf8s7YQdad5iHH7eXBUsKNH/ySgEu0WUm+u8n
         BqsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUw67oMnLyMMTDEYUr4qyys55jg7SVTEMdeAry02cg1CrEJDS9RSFxTPnvQe5Yd/qDr7347eMFz5/7tMw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YySwSE0nGPP6u5NQ75pfYap9gmNYL8wrksfLL5KXmMpwsfApJu7
	bay0q28naxi9KMIkAitYshsz7F4ETvCgyfQz+LfU+3JzzDP5F+xdrCm+y00C8tY=
X-Gm-Gg: ASbGnctAozbPjgLkIBEQxYgwcGAKkg+BLa2/RRClGunyTti+poVrOsu77IJVfPN5jpd
	8h1ZAfr+JKUNOsNl7Ol5nrrLcNTfjmcUVIqj1zFOIMDg9tzga38IPyx577K7KR/kLIi2hsen5Np
	c01pIKbbSzaNayKDGANOEEeTdn5xoLPtXx4UyHLBhq6gvSBpLUHmYgyy6Ir6oXE0pe/MIK0iGWz
	9Jiq9HjmyCiNIU7bJfI967wb6VOm+GNqBGZdTwSNCjLL5aPN/FJqkxLyk/dQBPnF/LLYltUZxkp
	+PK2eA7HYE+tk5Lv+bzB4kjSWwvPivreofwPqcGHKby/LltGe5jgI0wQ9razfjnnBOskXA==
X-Google-Smtp-Source: AGHT+IE2oxoC1L64pceFAJjINpFW78bsl4/VjfI/l/jWFrb64hOpXvLnDRUmBAhXfrCjNcCe085GuQ==
X-Received: by 2002:a05:6402:848:b0:5dc:d10a:1be8 with SMTP id 4fb4d7f45d1cf-5e4d6b0e6c9mr19059467a12.19.1741085871828;
        Tue, 04 Mar 2025 02:57:51 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c43a5acdsm8002966a12.77.2025.03.04.02.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 02:57:50 -0800 (PST)
From: srinivas.kandagatla@linaro.org
To: broonie@kernel.org
Cc: perex@perex.cz,
	tiwai@suse.com,
	krzysztof.kozlowski@linaro.org,
	linux-sound@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dmitry.baryshkov@linaro.org,
	johan+linaro@kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 1/6] ASoC: q6apm-dai: schedule all available frames to avoid dsp under-runs
Date: Tue,  4 Mar 2025 10:57:18 +0000
Message-Id: <20250304105723.10579-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250304105723.10579-1-srinivas.kandagatla@linaro.org>
References: <20250304105723.10579-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

With the existing code, we are only setting up one period at a time, in a
ping-pong buffer style. This triggers lot of underruns in the dsp
leading to jitter noise during audio playback.

Fix this by scheduling all available periods, this will ensure that the dsp
has enough buffer feed and ultimatley fixing the underruns and audio
distortion.

Fixes: 9b4fe0f1cd79 ("ASoC: qdsp6: audioreach: add q6apm-dai support")
Reported-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6apm-dai.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6apm-dai.c b/sound/soc/qcom/qdsp6/q6apm-dai.c
index c9404b5934c7..9d8e8e37c6de 100644
--- a/sound/soc/qcom/qdsp6/q6apm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6apm-dai.c
@@ -70,6 +70,7 @@ struct q6apm_dai_rtd {
 	unsigned int bytes_received;
 	unsigned int copied_total;
 	uint16_t bits_per_sample;
+	snd_pcm_uframes_t queue_ptr;
 	bool next_track;
 	enum stream_state state;
 	struct q6apm_graph *graph;
@@ -134,8 +135,6 @@ static void event_handler(uint32_t opcode, uint32_t token, void *payload, void *
 		prtd->pos += prtd->pcm_count;
 		spin_unlock_irqrestore(&prtd->lock, flags);
 		snd_pcm_period_elapsed(substream);
-		if (prtd->state == Q6APM_STREAM_RUNNING)
-			q6apm_write_async(prtd->graph, prtd->pcm_count, 0, 0, 0);
 
 		break;
 	case APM_CLIENT_EVENT_DATA_READ_DONE:
@@ -294,6 +293,27 @@ static int q6apm_dai_prepare(struct snd_soc_component *component,
 	return 0;
 }
 
+static int q6apm_dai_ack(struct snd_soc_component *component, struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct q6apm_dai_rtd *prtd = runtime->private_data;
+	int i, ret = 0, avail_periods;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		avail_periods = (runtime->control->appl_ptr - prtd->queue_ptr)/runtime->period_size;
+		for (i = 0; i < avail_periods; i++) {
+			ret = q6apm_write_async(prtd->graph, prtd->pcm_count, 0, 0, NO_TIMESTAMP);
+			if (ret < 0) {
+				dev_err(component->dev, "Error queuing playback buffer %d\n", ret);
+				return ret;
+			}
+			prtd->queue_ptr += runtime->period_size;
+		}
+	}
+
+	return ret;
+}
+
 static int q6apm_dai_trigger(struct snd_soc_component *component,
 			     struct snd_pcm_substream *substream, int cmd)
 {
@@ -305,9 +325,6 @@ static int q6apm_dai_trigger(struct snd_soc_component *component,
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		 /* start writing buffers for playback only as we already queued capture buffers */
-		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-			ret = q6apm_write_async(prtd->graph, prtd->pcm_count, 0, 0, 0);
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 		/* TODO support be handled via SoftPause Module */
@@ -836,6 +853,7 @@ static const struct snd_soc_component_driver q6apm_fe_dai_component = {
 	.hw_params	= q6apm_dai_hw_params,
 	.pointer	= q6apm_dai_pointer,
 	.trigger	= q6apm_dai_trigger,
+	.ack		= q6apm_dai_ack,
 	.compress_ops	= &q6apm_dai_compress_ops,
 	.use_dai_pcm_id = true,
 };
-- 
2.39.5


