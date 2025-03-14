Return-Path: <linux-kernel+bounces-561582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF04A613B7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3709189E443
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 14:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2BB20126C;
	Fri, 14 Mar 2025 14:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UlrVHwKQ"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0914320126A
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 14:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741962809; cv=none; b=j7jCaBXc3JLMUCddSqkYveic/NRB1DQluw8GhE6Nekd9FzgqmyASdpj8Fdetwuft1RRvktUxDoPq+GVz75A2Ym/hKdPldBBu7jFb674ZJ5Gg4x68UfdEcg13CbmRTJ+SfRFrWqELH/Ia7o6No4aS60BRpnFOkPl5Vu1efcxhF4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741962809; c=relaxed/simple;
	bh=rl1JUAbzuHruCH71rfySFM7KQHZ8STkXFPVIDYURSF0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X3uOdr1Cv43JsdPKcDIeGKjqFCBotK21C86PngOg+ABeA66WBVUVmRDh8tIKQN541bQMGVGOSWbg8xwS54gk3Nx3l4kEI0aGr9Pw7Z81UI9zAqewU+Q7qA1m7+V0RG712rImqPC817BGKx0VrvUkocaMeGL8yfyVQTqYhMTjJBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UlrVHwKQ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43d0618746bso15088215e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 07:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741962806; x=1742567606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m7r265E8NIQTLThxcAbd4dtQS3El8DVfLuvsTAa+XKw=;
        b=UlrVHwKQK+fpgNNXNiUJ2Z2aO/JsVlG23OaxaPfxm94E8CyXihZM2F+TbBxtZa0X09
         R6tsSxpjyLE8Q3esMWiYxR3Py9upeIh3ArYeTevgtAsEbSkG8qzW4nKT9PWwrHCoK4uP
         fMnaAHre291zLFYsN+bAF7kweBTOc5R5afPZIxAvRud+TNsFBseJfnj/kt11YZeMp2UY
         +AqAqU8wYeQpoe+NQORNsL1xnHhyR/pS0JH2NomLoeRYt+KHdbzZeDc+LbSuV5mCC3BF
         /3D9s1DwD35mkLGjQ3PesnaMoj9PqlVcS8tN4IlBTy3LPpACYeWRLdt1mvRMO6ZML9hw
         MggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741962806; x=1742567606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m7r265E8NIQTLThxcAbd4dtQS3El8DVfLuvsTAa+XKw=;
        b=Vrl0/xHV2GGR1R/XJ573NOM5UrGXvG2uHFyFO0Q51T/s0NJfgU20cBByTxs4i1i9//
         80yWKSgm2z51T+3wEuHahrnxmq5ffVuIsRdk1j9dNCeEDg7xNjfkkn6RqjjKBDZk7G3o
         rdZcCoO7QSmYkWzlD2EwG6Cnea3r9aeeicQXBB43N8PnPzrxrhHoQn+ELuoO1RrYxxZV
         XeBLJtytRiTBDInTDx9we/GiySzg+5/+PQ67XYVLi2JThsCKxFd+LK9oiW00Mfej/abt
         9/Sx2xO9MSvRD4hFup2R1aiOkyduA3Yrw8dw/JxxZXZpO9dZ9zPZhsNOs0v/YOwkuDou
         LfaA==
X-Forwarded-Encrypted: i=1; AJvYcCXJNP65+gVPZhVZFDFJHgIWQwuHMqF3XVHIY7jbq1D0zS6VdF2D0rPB+L7GM5CBHOxZa2ZyLlAPW54YwdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV4ZhfBVNmWOHGEj4+pB58+vcXtLoErT7lK7RjafO0Gq6sWq3J
	TFZsxpM7+r8ryMOQD/DbJIHNr0of53cXd90WaKnjxCYiDTCas6qVjQU50L0vLqE=
X-Gm-Gg: ASbGncv8WRvDqcnf0JmxI7iD3ed1h+qA0lbxCqjiyJO5TlhdDB6YY65bO9OoZd/XNOx
	KeRYLWaiVfQyQq4smH197j0MkjurbowpbXviKUZlDNCFAxbvfjj8kxeVQdWHbFqGlgIqlnGOGjv
	DSAB6FHbDnl4EYNlBTWOStCnEoNObXwfX0vMUTqKVfTwGkm64OX6dG62m7OO+oeH/J9nCC1JXxO
	1D5ngOtl6bqzfjNZjF+Kl4iA562yTcUp4n6GeVxN2kZCM5nRk+RbbH0BsOIQixfmsOMXUSJ/9V/
	ZeRg1+chGfAFtjGk6eJCX9Q3JsTU3n9BftAbS6Zh/9wzu+JL8/18MpGv85lx1mwcwFNzY6HxS/Z
	8GBMK
X-Google-Smtp-Source: AGHT+IHHvG7zpgRF/biasWJacaE8BgqYA/+Tzt9Ba1i6MJmKfz1aq1nD3PLvd4Da03+ceLCK/JoXgw==
X-Received: by 2002:a5d:5f84:0:b0:391:4095:49b7 with SMTP id ffacd0b85a97d-3971f12e65amr4834829f8f.25.1741962806395;
        Fri, 14 Mar 2025 07:33:26 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c82c2690sm5699168f8f.25.2025.03.14.07.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 07:33:25 -0700 (PDT)
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
Subject: [PATCH v4 3/5] ASoC: q6apm-dai: make use of q6apm_get_hw_pointer
Date: Fri, 14 Mar 2025 14:32:18 +0000
Message-Id: <20250314143220.6215-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250314143220.6215-1-srinivas.kandagatla@linaro.org>
References: <20250314143220.6215-1-srinivas.kandagatla@linaro.org>
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

Fixes: 9b4fe0f1cd79 ("ASoC: qdsp6: audioreach: add q6apm-dai support")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Tested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/qcom/qdsp6/q6apm-dai.c | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6apm-dai.c b/sound/soc/qcom/qdsp6/q6apm-dai.c
index 9d8e8e37c6de..90cb24947f31 100644
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
@@ -445,16 +436,12 @@ static snd_pcm_uframes_t q6apm_dai_pointer(struct snd_soc_component *component,
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
@@ -669,8 +656,6 @@ static int q6apm_dai_compr_set_params(struct snd_soc_component *component,
 	prtd->pcm_size = runtime->fragments * runtime->fragment_size;
 	prtd->bits_per_sample = 16;
 
-	prtd->pos = 0;
-
 	if (prtd->next_track != true) {
 		memcpy(&prtd->codec, codec, sizeof(*codec));
 
-- 
2.39.2


