Return-Path: <linux-kernel+bounces-543933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E16A3A4DB93
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CED5E177360
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F09520101B;
	Tue,  4 Mar 2025 10:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pNba2wxU"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A741FF7D9
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 10:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741085880; cv=none; b=ZaqYjF2IQhrQQWOofuh+uj1S1timir9IiBTXofw9lW8rBdYtmbVTx9J8HgQ51sIqkf7RsQQMYTv5TDO23D9GcXEoyxQxrDsiEwQU28UB4N3MP081weLAhUOVjXJ2vc4cDhCeFbOnV703VDfRtMdTEEnwsdDcV5et+2TxZmD5eYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741085880; c=relaxed/simple;
	bh=2cyClla8P6nWRItjw60GOMchhN9i8E2qxWYIAydEh1U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mV2J/tlegpaGEVfvw1L+8+iro2THxoxFa2ctzXBf2b5gRCZXD5pjp1hfufFlAUDZ1uiTdJ8L0Ab7Lp+y3z1+W1r12+DZyqvfcgA0b/ukvTkb0XNMjoUz73YDTbXX9DCqjzRWRri7LEx+2TwpCJ/prGbkJ/7DbydGQf/FHtfwLys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pNba2wxU; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e51e3274f1so5749462a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 02:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741085874; x=1741690674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ey071ua+N+9tAjiihktgShgQiT43owN1w7pBcfUu5o=;
        b=pNba2wxU7i/nwvVqF1bqfLHzLYB5/OFSy++gxwjWYwP4KoGYRXQiOSImu9g9M770UF
         y7OPqZiimIM+R/g2R5zgbGztGH6CJaLjQGvvl5t/gSfBDbOpCbJ+DF2HB3GfC1qHooX+
         L42uZDGihrjcpMu4Ov6MjOEZlrjwymQu6EPjVPsYtsjUoVkcAX2YiAZ3cqc2VbD7pnFD
         zmerkZOCzA5V+oHnWKrlGvlJGaFT8EBrbhXDu2ZxMPY5KSOm2Bu0DMLaExfym/cgi1Qv
         7637g3XWm3HEME4qE5DYiYMmrgvI7VTxwxVyYWyeY6It08vKV7niARKCFCRB+TsZlr3W
         x/tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741085874; x=1741690674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ey071ua+N+9tAjiihktgShgQiT43owN1w7pBcfUu5o=;
        b=k4MNuG8Kj89xPmp77oZVsTNWDL7mSbI01oPDcobDoZJZn5D3URjFOmeUT50NPOOkqi
         dP17L2bVqvygOIbr88nH66QZxUPQJ3NzVulcw2W6yaGEmJzo0i368GTEyDVKcI9XVi5X
         4Av5shSewxirTD1Lwx5BHSJFB47X1mr2T/2nnL7JuE7avDYJI9UKw9hcepVjrFQpkqPI
         yXtWPUVcJWyZK4zcxMjvY3hm6NFjvt+AjKPgxT5WX3cfkQKZ9AXi0GLi88beGPC7qoW9
         saF1yInAGTzegJe2f+M18BI59uP45bvZv3Sq7hAxtkeSZp4FU2ej+79Jv0xKsAzdvH0m
         K8VQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwVUO+PoxEW4LjjhJJu8msoh9FxSahJtXCiizDlMLe3sTrsvIt+xGciEVUjQ60rF1LbaNS1u9PrrqbxxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgBAensj7YCzOaX0KzLLwb7hEqzVLHCoy2PHhjZFKc2JrT3NRc
	tSl9sfNsoXPz5SiGJTYKhBuuon3r5JXXkq7CQpaJT5SMh9pjozwnjPvYRRxR66c=
X-Gm-Gg: ASbGnctVJC8MpKI3rNPBY4xodPRDNy5Wn/XSppbtLiJ0nHb88DJB54FwKUJXamAEzFd
	+SKtChjnpcLeB3Q6E00avNI29rr74m//Ebguipjns7UYLYxDj3+OMxKTS9vghO5WqCAHh6Gd0eC
	lLuteYKVr3FLbbVVW6QCodCUks3qqrS0Cn06LwdVQFqgFwdmb/zTFuP9e4yPhveOF5ewG20SSwW
	3Ah2y/yoj5uYY4yGWwaKp8Lo+WNDTIT1Tmgdnh3XCveJL0K6Zojp0htzMaIPJiepwaNl1CExaD7
	5QybkupqbSS6IEGwYHgkqY8YyBhsOYmdpzJMyB3SUnlZyJGWJIe0I5NQUfW0xrFIt1yPDw==
X-Google-Smtp-Source: AGHT+IEl5dQ7SUi+h+pAoAiqxB4IHkrcoHFGA18aKW1ukykTVB77J+DM70kzsLvNIP2qQEyNm/KbYA==
X-Received: by 2002:a05:6402:378a:b0:5e5:bb0:5d8b with SMTP id 4fb4d7f45d1cf-5e50bb0608emr14240833a12.10.1741085874589;
        Tue, 04 Mar 2025 02:57:54 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c43a5acdsm8002966a12.77.2025.03.04.02.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 02:57:53 -0800 (PST)
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
Subject: [PATCH v3 3/6] ASoC: q6apm-dai: make use of q6apm_get_hw_pointer
Date: Tue,  4 Mar 2025 10:57:20 +0000
Message-Id: <20250304105723.10579-4-srinivas.kandagatla@linaro.org>
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

With the existing code, the buffer position is only reset in pointer
callback, which leaves the possiblity of it going over the size of
buffer size and reporting incorrect position to userspace.

Without this patch, its possible to see errors like:
snd-x1e80100 sound: invalid position: pcmC0D0p:0, pos = 12288, buffer size = 12288, period size = 1536
snd-x1e80100 sound: invalid position: pcmC0D0p:0, pos = 12288, buffer size = 12288, period size = 1536

Fixes: 9b4fe0f1cd79 ("ASoC: qdsp6: audioreach: add q6apm-dai support")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
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
2.39.5


