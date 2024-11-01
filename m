Return-Path: <linux-kernel+bounces-391706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A37329B8A90
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 06:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F40F1F22EE2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 05:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122FB156C52;
	Fri,  1 Nov 2024 05:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jBnIAPX0"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C574155335
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 05:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730439134; cv=none; b=OGY21gC26KqYMLM/ObtC6M6Vr9bJE0l3MtpSz6Wt16uQwBFVvG/ZTk4q0YIN2Fm4wL4kTpdWS6vNjIid1M4l9gVwYjcTgJS4DQ3EYyrFpDQrvsCr1zSsdDFTT0gKSlYtUFLJ9kaRqy6Go7df6iZirnF90+Svj7aiH32JQrJ2QSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730439134; c=relaxed/simple;
	bh=7t6SY/A5qJfgXLXrqRp6mPVqti3WBAnSq+LngHcAwxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gnewa1Nl6J83EJRvC9dFmtufl2qZbtQDa4urpz5xxEAg/ZaBQKnDa8tYaXSkTYOwWjzMEp924QCNLv0n6CrAqHlqgLbL9cWPtwWroH3PafQoFpnio2d2lcYT8AntPB05RX6uhAes4vZZSYuBXCjn6TpKqUMm9w3bCV0kQZzHkAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jBnIAPX0; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4315eeb2601so17721385e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 22:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730439130; x=1731043930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0qZ+GHMqA1XdG2ZoQPqbFp+pFaFwbLJtnfQPgYvvEGs=;
        b=jBnIAPX0nwf4+J5NjJXxJlmJeGQ3TUhXGyA7YGSD1EcuDQu5x7HI6aBmsOggLeHe94
         cNYKXwaeaAD+B9y11dwB7LzT19RGhTDxcha4GB4vtH30bhMFSbYgZjQQ/xP2DSeOCN2V
         Gm/nB0P6gPbKmgv3qJPZA8FK2zT6GuZ51xFbJbCqyYpgqCbAnkq2352M+aPUzWiT8N2y
         VP4/sAElk3xqK6T/N6GD2q1pjJ3yVCnysin/PxHLjabKHi4eQnZbOnc9oXkYNPQcq4H9
         VbTTAoB01h0mK0unwTeXG0K7+9Ppj3RRydEjDO1FL3fIXP6nS8ca6HHrO8rYAowezkfU
         wsvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730439130; x=1731043930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0qZ+GHMqA1XdG2ZoQPqbFp+pFaFwbLJtnfQPgYvvEGs=;
        b=BfdtLlGs8ydGtmEPMmpjcYe2VGd0ts1WAzla9UhyHcJ6NAWeLTEvqSiMxOPukI45ep
         QIdCrHM8sAIUMa8gGjqVhJV5O15JCq5tJaieYDhY+IOiIuO1HKsEI6s412UIa8lcWLFN
         HAOU7c2A6hoUl8a7cVQDMAr7OZ808BjA3CROEIN1OVCiHMQStGAQaaAKXdUWzJi1v07o
         2Nt4MNhpYxu8n+Tj6f7FStX12axjjFXejIfXE3CqKbrFjIwtuwOPQXgBeAiSDzqlCYKr
         rPR2s9zf2fwi7dau6blMwU4j8ww8kVE4KI+QOr1r9O8rqs7R4I6J4anRONm4pHStHe+Y
         23Og==
X-Forwarded-Encrypted: i=1; AJvYcCU+M7kFA9IcI+PVPuylg+E4kGMPdwlfvSHEItf0UPM+IrgFllf61UCt4cRAgi5Gxh11g79hYn/1pCRoMVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsvBuMWOzKp4+KsMbM5U5w7c+Tb2OwujTWQyj5PUHbfsbg4YAi
	iUdlbEfmIeAIl6tLZ4ucmqGa/Vi/Stn546ptrUvod0knC1rMoFeMKM7yDYfDg0I=
X-Google-Smtp-Source: AGHT+IGf6ar6VexZK13JhCW0Tfya9l6kv+PZwdcvXJwTsfxhD1kd0t2KZRYLapS6J/eWQ4atw7TETw==
X-Received: by 2002:a05:600c:4e8a:b0:431:54f3:11ab with SMTP id 5b1f17b1804b1-43283296051mr20804705e9.33.1730439129894;
        Thu, 31 Oct 2024 22:32:09 -0700 (PDT)
Received: from localhost.localdomain ([2.222.231.247])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d6852fdsm46960505e9.34.2024.10.31.22.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 22:32:09 -0700 (PDT)
From: Alexey Klimov <alexey.klimov@linaro.org>
To: broonie@kernel.org,
	konradybcio@kernel.org,
	konrad.dybcio@oss.qualcomm.com,
	andersson@kernel.org,
	srinivas.kandagatla@linaro.org
Cc: tiwai@suse.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dmitry.baryshkov@linaro.org,
	linux-sound@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 10/10] ASoC: qcom: sm8250: force single channel via RX_1 output
Date: Fri,  1 Nov 2024 05:31:54 +0000
Message-ID: <20241101053154.497550-11-alexey.klimov@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241101053154.497550-1-alexey.klimov@linaro.org>
References: <20241101053154.497550-1-alexey.klimov@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In case of mono configurations we need to enforce single channel
output. This is required for audio playback on QRB4210 RB2 board.

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
 sound/soc/qcom/sm8250.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/qcom/sm8250.c b/sound/soc/qcom/sm8250.c
index 45e0c33fc3f3..7994488d7998 100644
--- a/sound/soc/qcom/sm8250.c
+++ b/sound/soc/qcom/sm8250.c
@@ -39,10 +39,20 @@ static int sm8250_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 					SNDRV_PCM_HW_PARAM_RATE);
 	struct snd_interval *channels = hw_param_interval(params,
 					SNDRV_PCM_HW_PARAM_CHANNELS);
+	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
 
 	rate->min = rate->max = 48000;
 	channels->min = channels->max = 2;
 
+	/* Maybe should be moved to driver data variant */
+	switch (cpu_dai->id) {
+	case RX_CODEC_DMA_RX_1:
+		channels->min = channels->max = 1;
+		break;
+	default:
+		break;
+	}
+
 	return 0;
 }
 
-- 
2.45.2


