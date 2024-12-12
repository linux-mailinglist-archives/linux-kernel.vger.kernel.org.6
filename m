Return-Path: <linux-kernel+bounces-442442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC86C9EDCD1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 01:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90E22168A0E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 00:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF0C17CA0B;
	Thu, 12 Dec 2024 00:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cf0yDtv6"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804E81885BE
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 00:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733964481; cv=none; b=Uzslgl2NtNn4yo+12b+o+epdR20lZJfrk25IqEUXXLP837xlbKudTPVunK6BWx6dPiSdpw9cSHNCzvAdwpw3eupqyg139Y7PzgJ4TT/NwznKmdUk+U24ht8pvkSZqrZLt/6dKPQ7lG5L6j5IRzdz0jj0ZqtbdFDFwtoFYeOmGds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733964481; c=relaxed/simple;
	bh=QzuIeMsbqn06WI5qhPV1wr/oyc12cKZ+XBOtXN5CYbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oa7QQJ391tG/EDle3CLozGGEuygblzK/WSxzpmr814cdUNzgj21SnQj5/Le0QpNu/IZLzEt3M5k+rJr4lCPkJFN9Z26NBqUvt8DFG+Iy/jDp3oe9ygKcl3kX7IhrBUpLdYR1UCP2BNKXW4JksgoFSg6dQUxUhxA2ZtfhgtT3gHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Cf0yDtv6; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-385ddcfc97bso15669f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 16:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733964478; x=1734569278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8YUv9wXf1xeMulszUqTOEITp7UUlDCUgSWoOEuWnA1U=;
        b=Cf0yDtv61ODSF0SdIoYHtgfcMmCSDWWtc/iE3ul6sPR6qU4XVCOI3tDDXgvhgF6SQG
         n10ix4qfFx+qAvU4XHjm3zpvwLR9N/FqS1MsByQMCwwz4N1aKH6C81c66QDnQv9FKze/
         cjfo+YgZsKg3mzhObTqbx8tYbOwDFY/2kRS7mvQQvA+RpeEyHujBB8AOuM88t661GzAu
         JiUZwBW31X2g0Zfv7rZHUxRGz3QDWTPI51FZbn1uOM62LY+zWaFOKfRrr8wwtcLcTTIj
         jS6plzepqGM15KRz3j9Vl4F4oyslsOCBZji7jeqx2SGjL0pF1qGg39EDnkTzHXwlYqY2
         kPHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733964478; x=1734569278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8YUv9wXf1xeMulszUqTOEITp7UUlDCUgSWoOEuWnA1U=;
        b=YkYIWLyZFYyEDVyZ/uhDulQgKAIp5gkrMrGrDokkc0LjWhzXXPdqr0hTmIX8b3RVqV
         b/d7VLzg4uxaDVU/AzqqpZlzZx9iqB7kv1SPrREqExBbxyI6R7kAnssMbVsJrjHdAnNS
         SWqGKr09A09JCTeDpj5y/MbN/pl+tWMDzV9ZHAuEu3ki6z2fB40X0B6Qfw4D7Zc04jLK
         4X7R1gCLAnnCuLBt6FNt0n3bHvCDCKqZwoJ9gAudNP3ILOvuuiib9enMAc+CLUrYDQSx
         uSLgTL2vA5VOuMDwk8ne+lPSE2uVW3UVkisSALs2e2C2nyHeZpeXZCq/NHrNsQ05poxL
         IPsg==
X-Forwarded-Encrypted: i=1; AJvYcCWE2U8uRNn9FBbW5TxeTohxSHq3oMFWqbgsYfZAfFZq57R7l1wsbnxRoRO6dpwu++AN//kKxdjNbQZwkek=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrUgsgd5OBYYcGzqdCRxfWJXWoKy8xHi/VCGFhscraloUOKx0c
	p1n15gtSd1Zr4ZnmYQqL96pFJzSuw8H3BZjw+Ij6hKn5bsqmBMoz6drwGlVm5hc=
X-Gm-Gg: ASbGncvQjBAv5eTUvfGzLkR7qsyjZ9ps7KRhb5pJrp6SA5SGHKkraLYkz5HgceEeWY1
	T2U2iqgOCQY/LxOGWD9Yn1nyvJziejobf9mPYIiIBWwaZpy9DVz2+eTQC5JkIAO5HIRVezYZ4sI
	yAUW3GS523NDalFu+uWZSUmMALNHpiXR76erDI3GMOpiOquEAnBSUYxql9qJZwZ9T32k63tc4Tv
	h/D3posl2LUXbnyt6/WaZDkiCKEqwcVLLx9Dh3e83rT7ut/3SHhqrgXh37BuvwQEVAg2bZk
X-Google-Smtp-Source: AGHT+IGJvDlNsdYx4DutxMjQy1pOyYpJ0oJ3EbMe3FkPnkQ/U4TLzzGqGgOOv0KPDA2qNTcXJbpfuQ==
X-Received: by 2002:a5d:6f1e:0:b0:385:ea11:dd92 with SMTP id ffacd0b85a97d-3878768e6a0mr1224692f8f.15.1733964477946;
        Wed, 11 Dec 2024 16:47:57 -0800 (PST)
Received: from localhost.localdomain ([2.222.231.247])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-387824a4ef4sm2459660f8f.39.2024.12.11.16.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 16:47:56 -0800 (PST)
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
Subject: [PATCH v2 14/14] ASoC: qcom: sm8250: force single channel via RX_1 output for qrb4210
Date: Thu, 12 Dec 2024 00:47:27 +0000
Message-ID: <20241212004727.2903846-15-alexey.klimov@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241212004727.2903846-1-alexey.klimov@linaro.org>
References: <20241212004727.2903846-1-alexey.klimov@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In case of mono configurations we need to enforce single channel
output. This is required for audio playback on QRB4210 RB2 board
since it has only one WSA8815 amplifier.
Implement data variant for qrb4210-rb2-sndcard with
sm8250_qrb4210_fixup_params() that does that.

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
 sound/soc/qcom/sm8250.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/sound/soc/qcom/sm8250.c b/sound/soc/qcom/sm8250.c
index 45e0c33fc3f3..b54acaee8dd1 100644
--- a/sound/soc/qcom/sm8250.c
+++ b/sound/soc/qcom/sm8250.c
@@ -23,8 +23,23 @@ struct sm8250_snd_data {
 	struct sdw_stream_runtime *sruntime[AFE_PORT_MAX];
 	struct snd_soc_jack jack;
 	bool jack_setup;
+	void (*sndcard_fixup_params)(struct snd_interval *channels,
+				     struct snd_soc_dai *cpu_dai);
 };
 
+static void sm8250_qrb4210_fixup_params(struct snd_interval *channels,
+					struct snd_soc_dai *cpu_dai)
+{
+	/* QRB410 RB2 board has only one WSA8815 amplifier */
+	switch (cpu_dai->id) {
+	case RX_CODEC_DMA_RX_1:
+		channels->min = channels->max = 1;
+		break;
+	default:
+		break;
+	}
+}
+
 static int sm8250_snd_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct sm8250_snd_data *data = snd_soc_card_get_drvdata(rtd->card);
@@ -35,14 +50,19 @@ static int sm8250_snd_init(struct snd_soc_pcm_runtime *rtd)
 static int sm8250_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 				     struct snd_pcm_hw_params *params)
 {
+	struct sm8250_snd_data *data = snd_soc_card_get_drvdata(rtd->card);
 	struct snd_interval *rate = hw_param_interval(params,
 					SNDRV_PCM_HW_PARAM_RATE);
 	struct snd_interval *channels = hw_param_interval(params,
 					SNDRV_PCM_HW_PARAM_CHANNELS);
+	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
 
 	rate->min = rate->max = 48000;
 	channels->min = channels->max = 2;
 
+	if (data->sndcard_fixup_params)
+		data->sndcard_fixup_params(channels, cpu_dai);
+
 	return 0;
 }
 
@@ -168,6 +188,7 @@ static int sm8250_platform_probe(struct platform_device *pdev)
 	if (!data)
 		return -ENOMEM;
 
+	data->sndcard_fixup_params = device_get_match_data(&pdev->dev);
 	card->dev = dev;
 	dev_set_drvdata(dev, card);
 	snd_soc_card_set_drvdata(card, data);
@@ -181,9 +202,10 @@ static int sm8250_platform_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id snd_sm8250_dt_match[] = {
-	{.compatible = "qcom,sm8250-sndcard"},
-	{.compatible = "qcom,qrb4210-rb2-sndcard"},
-	{.compatible = "qcom,qrb5165-rb5-sndcard"},
+	{.compatible = "qcom,sm8250-sndcard", .data = NULL },
+	{.compatible = "qcom,qrb4210-rb2-sndcard",
+	 .data = sm8250_qrb4210_fixup_params },
+	{.compatible = "qcom,qrb5165-rb5-sndcard", .data = NULL },
 	{}
 };
 
-- 
2.45.2


