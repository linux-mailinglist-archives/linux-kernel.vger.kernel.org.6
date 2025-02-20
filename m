Return-Path: <linux-kernel+bounces-524224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CE5A3E0CE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD79B189DE12
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78793202C36;
	Thu, 20 Feb 2025 16:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qNoIsMas"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67631FFC6C
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 16:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740068965; cv=none; b=fg/vJnqtLcfaBpOBQAUomFn/TiK4+uNa+a5LF4wZvRdwMfXYJJm4ZC4duAMI+TKeTtUMGeespzITDBY0O8ArzFqdRuprP6auKZbZvytZ2qvkRjRdBK0GBn+8BS45NcxaTwwdDaaL7s4w9+0+2xjgNGmi1SxkeohLeh9SwN01yrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740068965; c=relaxed/simple;
	bh=KxZTxc4fxRw7OMyGGA5HOYd9rCClNlteupN9ItslzT8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t62p+URaJMIWeqJFM0Mbo6fv3Gu517XjDCTErH1WP1KqpVzo6eVtC+IddaR6ACZ1JkmmJE++91u00WlqdF0p9y52jAguWqndjreujU+Gq502XF5jOluNiYuthVGo/VfyZi3CCnKOGxP6wa8Y0wFvRk9gi2+h/mkVqJ8e79TI4xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qNoIsMas; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-38f29a1a93bso973448f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 08:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740068962; x=1740673762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xe1FIG0EUV5vtEiip0bMJp8pcyFVOy9gW9Da1yY8B3U=;
        b=qNoIsMas+gv+WiFlcDibu9VvIfGI5+xGsSynwJ2esMJlNBuWtmvlH1VfpLsa65IePJ
         7H4RULnC4Kk4paev3IEV07W738cDLenZO3kAxAe0ls9hwnZ9jS3yf5rFvGFa8jYCpruR
         rRtmcuJ+71snKr2dvjDMhqj9W+Ifm+MC8wmPDAc1/YdaylvvKF/fGIWdSaoWXtV0uAHt
         Zbe1YL8yK5Q1nESMwEEuFsVibcwe8ufyuKBGQvwfOvmmz3U+CfbJYwEdS1f/CWfmqMQY
         7crhOIXdZtuiIMmXrU3vjiXN7m4Rxln/Lr32G5xW6UchnCXzhZ2fOPninufdycYZcWI9
         x+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740068962; x=1740673762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xe1FIG0EUV5vtEiip0bMJp8pcyFVOy9gW9Da1yY8B3U=;
        b=XqRoCvN6ZY8W/AGtmkCW/NtP91/sVme8Za7AqFFavWLNu9eVsxqyCVJvm6y7wC9RVU
         Ztfwy1o+9dwVpj5+mqgo4rNjolSWnvbZrV4iskCMDBycEbZCUBnNGI0mJtyFK0AYAjgW
         jkuWhIYfN8oyM0Wq7vcOHOPVOmD1NYeGGyAoDpiETJzVQ5FiNug3V42PVtFsaisVin6Y
         a3Yf9yZaELEEovqNkBb872+xix/8fhzTWopjQYar5EANwje9AjaOmHyL2a+qQC8h34hB
         zc6n86mjrHvzm7TLQm8crAW+1Vj5hjM1Gb0ACNOozpp4NmvoET3CF1eaLkAAXqutH9Ir
         O3oQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCJ9B2KiZyOFWGLQXhv5L+1JC8JJyfYa55SvZXubA/WhHxvgGOK1aDvwj9voT4HIzo17gP+T+3iUt4oNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU3/9McogLvW8DZ1Kw/EcGrWWAoy8PTlwX1AQYwMkRONwiUhdG
	EV65kua0bL07vORmABlgxT0N10cWiYLj+c0P6PbsN0KMqxiwB48PLhRe6DSJhLM=
X-Gm-Gg: ASbGncsZqvxNhGVb4CkBk6sBcxWyMTK+7mLq6+wy3WdBOhUyfLcE3HLAuviATqjy9ar
	2BBr0t7DQNwaE87ZRlZF8L4M4GJ/1Qj9P8AmMpxURwhh6IztC1FjFqm8hRlzdQlkYBaP3WRJC/q
	aUffZbh0mGWVu7eCmBu9QLfQjE9L07SaA8lovQlQjxc1Ci9FqB2kUmxJoqv/LAlEdm28nGG32ZB
	Phqk8bd+xTvN989p3Sejkq5zePWhxKVgQhP7/0U0flJ3RUwtFxxyPYlnYJWps2VcL09wUQvSX1l
	mzc3WE2ZQ9Se6eroYsV82Mj+axLyrQX33rzuSzVk
X-Google-Smtp-Source: AGHT+IFeFUNS6+fpxgZcJiw03GQfFy8Cu2R2NlAoQdwczmUQmL/WjMlMRJlHB4Ht882oa1KtvLVMLA==
X-Received: by 2002:a05:6000:1866:b0:38d:d223:f8e6 with SMTP id ffacd0b85a97d-38f585ea6cfmr7098326f8f.0.1740068962219;
        Thu, 20 Feb 2025 08:29:22 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258f5fabsm20813753f8f.45.2025.02.20.08.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 08:29:21 -0800 (PST)
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
Subject: [PATCH v2 1/5] ASoC: q6apm-dai: schedule all available frames to avoid dsp under-runs
Date: Thu, 20 Feb 2025 16:28:43 +0000
Message-Id: <20250220162847.11994-2-srinivas.kandagatla@linaro.org>
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
 sound/soc/qcom/qdsp6/q6apm-dai.c | 33 +++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6apm-dai.c b/sound/soc/qcom/qdsp6/q6apm-dai.c
index c9404b5934c7..eba51e88a297 100644
--- a/sound/soc/qcom/qdsp6/q6apm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6apm-dai.c
@@ -70,6 +70,7 @@ struct q6apm_dai_rtd {
 	unsigned int bytes_received;
 	unsigned int copied_total;
 	uint16_t bits_per_sample;
+	unsigned int pb_tail;
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
@@ -294,6 +293,31 @@ static int q6apm_dai_prepare(struct snd_soc_component *component,
 	return 0;
 }
 
+static int q6apm_dai_ack(struct snd_soc_component *component,
+		struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct q6apm_dai_rtd *prtd = runtime->private_data;
+	unsigned int tail;
+	int i, ret = 0, avail_periods;
+
+	tail = runtime->control->appl_ptr/runtime->period_size;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		avail_periods = tail - prtd->pb_tail;
+		for (i = 0; i < avail_periods; i++) {
+			ret = q6apm_write_async(prtd->graph, prtd->pcm_count, 0, 0, 0);
+			if (ret < 0) {
+				dev_err(component->dev, "Error queuing playback buffer %d\n", ret);
+				return ret;
+			}
+			prtd->pb_tail++;
+		}
+	}
+
+	return ret;
+}
+
 static int q6apm_dai_trigger(struct snd_soc_component *component,
 			     struct snd_pcm_substream *substream, int cmd)
 {
@@ -305,13 +329,11 @@ static int q6apm_dai_trigger(struct snd_soc_component *component,
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		 /* start writing buffers for playback only as we already queued capture buffers */
-		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-			ret = q6apm_write_async(prtd->graph, prtd->pcm_count, 0, 0, 0);
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 		/* TODO support be handled via SoftPause Module */
 		prtd->state = Q6APM_STREAM_STOPPED;
+		prtd->pb_tail = 0;
 		break;
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
@@ -836,6 +858,7 @@ static const struct snd_soc_component_driver q6apm_fe_dai_component = {
 	.hw_params	= q6apm_dai_hw_params,
 	.pointer	= q6apm_dai_pointer,
 	.trigger	= q6apm_dai_trigger,
+	.ack		= q6apm_dai_ack,
 	.compress_ops	= &q6apm_dai_compress_ops,
 	.use_dai_pcm_id = true,
 };
-- 
2.39.5


