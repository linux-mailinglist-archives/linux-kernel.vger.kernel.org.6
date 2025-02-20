Return-Path: <linux-kernel+bounces-524226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E63A3E0D8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C97D3B48A7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25814212FB3;
	Thu, 20 Feb 2025 16:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DNWw/fR9"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E894420DD45
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 16:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740068969; cv=none; b=J355JcZijy3/EO6Og+0fmWYvXEptf94Ca1uRDX017fYsKEMod+i6ZSEMi+qIkr4ICsCH7IR5anbYkv3021HuvJ/6QM6yLMGoHMn1c5GEN/TSZ4pik3cdEChrz786Tz1kY6pqwwwXXl9mc/7gro8bkZNUKm0XHgeYsjwN9xvLRbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740068969; c=relaxed/simple;
	bh=Dr8Rk5o8L7NeOZgA3IT4ksHpO16HjBDqWkL7REEjaPg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b1nTjPgUgmNpJbfEs0fL1m3kFi8nQazYC3IZT2p9jpm5eqxzr8i2N+GSxl442jTdI4PGPAYWpPVQgpXQySOUidcKcwImGvFdYCSRVkU/sT+25vsYy5FqYy1oiqTqR6v/VgCkhmFdGYI/vGM7oZFa7WLDFrZVB/qTpa8QkO1DxjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DNWw/fR9; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-38f2b7ce2f3so916295f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 08:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740068965; x=1740673765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wWH0fM1NieugYkKcNBWP1cXDL8AX1zdkriiAZTiM3tI=;
        b=DNWw/fR9h7YMhL+7ngqVD5BHacs5CcUYj2W4UrzJHYdPugU8YEElWgIHNKVzmtNn41
         kTA9KLkP4LA7wRY1frSI1O3Q4qAwVvl4orM9fdjZG83hk0lQz64a9xG7MnklpHoXrhuD
         nnEbs6YmtMEYp8+GWYQCJAtAEjS/isHpvcCpxsKDHrnb7+gJV1g+o3yvPsM/GYna+Iuu
         DpMX+dj2QU+jvKDshaWTu9P51dhtbs8ijStVrH1ihcavm1VYKJG/sTV7zJEUyAzj35rh
         P8QOSQuRUkgeNYzgL7Nue0D6sT99oCRfI2rpWsmW3Zrrg/odAXTw58AF1d0u+XfRcd9T
         mFwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740068965; x=1740673765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wWH0fM1NieugYkKcNBWP1cXDL8AX1zdkriiAZTiM3tI=;
        b=lQKa0epfAVJpirCfuUIUH6pEvlkbx0dMgGNmXTDVVD+GADftMnhbimvuxolUpYnP1d
         9NlFtRXH3gGcGdtZcb4RrPB00HaNTzEbzUE0x51zGH7YoQc4CErSYfW7jN7xu7HdmGeb
         FOzUsPxsRLAI41gi7Lh1VbZz6onuhmgRBJZWZu7tX2GuM6wRS1nkDmfPMqllnN3dCXHl
         0/inbeo792p8eteyKIzTzF2wqZKb1W4Aujhw7alFPvA3gEQ5sN9+w6BT7lTEFNitN5uK
         haklB5ekvAHmSN8Sj2Oxo3xxHZHAD56pTpnCtnGG7ymttteRiBnWM7Bv4O0Zah/TsYcR
         Peag==
X-Forwarded-Encrypted: i=1; AJvYcCWbeNOQ1uNwLxuLdLe7HJgDdbaI0NfEvtlbDBiXTFeMWpcouf45rYHesnBbyYQjstBP14ILU/qbiu9CZ+M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8+ewI13q+RyA2r+XlUC+SJP1r6WtZ2MGiYpWFam2wYGllGrrN
	CRkkgB+OLK7A09ujLqvfuOhxhmNdm7A7NzBcXzgfP+C0hgLhiPYjv+MyXlYbhzk=
X-Gm-Gg: ASbGncunIN5BPzo1wUNfOvARN9Yz6cjwZVvAFPqUqYDwdtsk4layIBmdgy67ERJXoVM
	pqcHau2KORWmukT/pALipqig+f8FjaXY85MtjuM9xGL3Mv9Ncen49hPgRMznpTUtV1S5BsDkksF
	UumDb4u2xUMFAGBRcU1nrlH7N1VlpUnmgzAmzacKGvfq3DNEN45B1ohsQbCy9YmaPQuba++CxZd
	AvSG4qNNejl/wtH+cFIBAR8b04HkfzPvVdPNNPSmMuEF3YEiEZRPh9TjPoH6S7Vf31S/AHvVuC3
	0oAeOqnVhY36atvox8dULFYUZgtSRAYWdZ4XmtoD
X-Google-Smtp-Source: AGHT+IHdOwtU9xb0WEouusC4CcaJUMhnzC1yLBW1Y1gMidwn7Gg10mbC9aK40VRIc2odT8xSgLfmSw==
X-Received: by 2002:a5d:4641:0:b0:38d:e304:7470 with SMTP id ffacd0b85a97d-38f33f44f3emr20248336f8f.25.1740068965221;
        Thu, 20 Feb 2025 08:29:25 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258f5fabsm20813753f8f.45.2025.02.20.08.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 08:29:23 -0800 (PST)
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
Subject: [PATCH v2 3/5] ASoC: q6apm-dai: make use of q6apm_get_hw_pointer
Date: Thu, 20 Feb 2025 16:28:45 +0000
Message-Id: <20250220162847.11994-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250220162847.11994-1-srinivas.kandagatla@linaro.org>
References: <20250220162847.11994-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

With the existing code, the buffer position is only reset in pointer
callback, which leaves the possiblity of it going over the size of
buffer size and reporting incorrect position to userspace.

Without this patch, its possible to see errors like:
snd-x1e80100 sound: invalid position: pcmC0D0p:0, pos = 12288, buffer size = 12288, period size = 1536
snd-x1e80100 sound: invalid position: pcmC0D0p:0, pos = 12288, buffer size = 12288, period size = 1536

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6apm-dai.c | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6apm-dai.c b/sound/soc/qcom/qdsp6/q6apm-dai.c
index eba51e88a297..7466fe0c661a 100644
--- a/sound/soc/qcom/qdsp6/q6apm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6apm-dai.c
@@ -64,7 +64,6 @@ struct q6apm_dai_rtd {
 	phys_addr_t phys;
 	unsigned int pcm_size;
 	unsigned int pcm_count;
-	unsigned int pos;       /* Buffer position */
 	unsigned int periods;
 	unsigned int bytes_sent;
 	unsigned int bytes_received;
@@ -124,23 +123,16 @@ static void event_handler(uint32_t opcode, uint32_t token, void *payload, void *
 {
 	struct q6apm_dai_rtd *prtd = priv;
 	struct snd_pcm_substream *substream = prtd->substream;
-	unsigned long flags;
 
 	switch (opcode) {
 	case APM_CLIENT_EVENT_CMD_EOS_DONE:
 		prtd->state = Q6APM_STREAM_STOPPED;
 		break;
 	case APM_CLIENT_EVENT_DATA_WRITE_DONE:
-		spin_lock_irqsave(&prtd->lock, flags);
-		prtd->pos += prtd->pcm_count;
-		spin_unlock_irqrestore(&prtd->lock, flags);
 		snd_pcm_period_elapsed(substream);
 
 		break;
 	case APM_CLIENT_EVENT_DATA_READ_DONE:
-		spin_lock_irqsave(&prtd->lock, flags);
-		prtd->pos += prtd->pcm_count;
-		spin_unlock_irqrestore(&prtd->lock, flags);
 		snd_pcm_period_elapsed(substream);
 		if (prtd->state == Q6APM_STREAM_RUNNING)
 			q6apm_read(prtd->graph);
@@ -247,7 +239,6 @@ static int q6apm_dai_prepare(struct snd_soc_component *component,
 	}
 
 	prtd->pcm_count = snd_pcm_lib_period_bytes(substream);
-	prtd->pos = 0;
 	/* rate and channels are sent to audio driver */
 	ret = q6apm_graph_media_format_shmem(prtd->graph, &cfg);
 	if (ret < 0) {
@@ -450,16 +441,12 @@ static snd_pcm_uframes_t q6apm_dai_pointer(struct snd_soc_component *component,
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct q6apm_dai_rtd *prtd = runtime->private_data;
 	snd_pcm_uframes_t ptr;
-	unsigned long flags;
 
-	spin_lock_irqsave(&prtd->lock, flags);
-	if (prtd->pos == prtd->pcm_size)
-		prtd->pos = 0;
-
-	ptr =  bytes_to_frames(runtime, prtd->pos);
-	spin_unlock_irqrestore(&prtd->lock, flags);
+	ptr = q6apm_get_hw_pointer(prtd->graph, substream->stream) * runtime->period_size;
+	if (ptr)
+		return ptr - 1;
 
-	return ptr;
+	return 0;
 }
 
 static int q6apm_dai_hw_params(struct snd_soc_component *component,
@@ -674,8 +661,6 @@ static int q6apm_dai_compr_set_params(struct snd_soc_component *component,
 	prtd->pcm_size = runtime->fragments * runtime->fragment_size;
 	prtd->bits_per_sample = 16;
 
-	prtd->pos = 0;
-
 	if (prtd->next_track != true) {
 		memcpy(&prtd->codec, codec, sizeof(*codec));
 
-- 
2.39.5


