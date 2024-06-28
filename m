Return-Path: <linux-kernel+bounces-233220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD00991B477
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 03:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE3541C216B1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 01:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB8E1D54A;
	Fri, 28 Jun 2024 01:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gGnAZwGz"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5692AF9F5
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 01:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719536843; cv=none; b=es9Vf5TY7YfEkSFyAUgJLUT18pFt25R56inA++SRD4uZo+hIyVcvNTRgYAFiX/MLkhcsVcMVuHn9jiHOo9Y/fID3L1zxiz8VQYjSP54GN8cHuAZm0VDMpEyq//46T+WKW3wEdexTI9GlIGXYsLECR3ZXyRdnk2VrfhGa6wmgBoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719536843; c=relaxed/simple;
	bh=2fLNT1nXHgsFGK9SfQggEdsqimQIX4e/hXkHKmU5TxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M0eiYuJjfeDVTeJxhgoOE73AYQF8a+aEPQyQQ4V9wvte01fihS3Uq//8Lxj/5rNYXNaJI8VV7blhB5Ko/z09Ah+Je3dMFB9n2/sQKqzndNMEpOnPvTz+tmZsJ5sV+iPA23K1PUwC7ub8erx7iNxqLhx1khWBej4GEaqpjFeJlDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gGnAZwGz; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42562a984d3so445875e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 18:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719536840; x=1720141640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gJhqgpKH8xpri6xgGQ+p8sz4lqzbwizt046mSH+TQQE=;
        b=gGnAZwGzeCf9L+vAFtNpC6xQIzRdapCBXUSfbID2tHLXGsEalawoMfnZvfamAgb0FF
         HYuOjEa85cv2N21kkg0FBtxFdiVc3qbwJHnj2zZG+QP/Cq1ml0L89bEw77BHAehMUTVk
         MFRO2nzGUbs5l+b/UbEgIK50+D1mmjfUirLdOVzTyeEzWLKxwisc2bg9XF7YfH1j0U67
         WMcVN6yb/CDnDgqR/OuhXiATBZ2zWJJL+aaskB9XCJvfzJxBmg3daysWB5DJhiDNbvgN
         102gk80Hlp2mvAZxRs1rXwqCJtnWTeftoOeNM8Uw3qSu9nJP+trF3qiNVQa+kyo17Q91
         1u+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719536840; x=1720141640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gJhqgpKH8xpri6xgGQ+p8sz4lqzbwizt046mSH+TQQE=;
        b=tuuV/wMhRFbKNtcCFPYsDOZyLxGDVmbkCjuvY3gIS5j/IIIlRALc2XszzwFj1LPZ6F
         Yf2YgK6VxmrblUrwUugkwK06IY7s88BqSXvgq2FlnHOcegTENdgAP2nDI8xR8N+ljS5/
         CWoU/uGC85hzTrRsqikQLsHuT6fqbGYlXxEhQmFrWfmPlz9yjSatJwH+aCz4UJrO77LO
         N5/7e7RzD0/sv3ardIJmiUL3Pfm1rlwtyi7ijsLqYzV+KL+uNuRJ3VQiIV8EW7f9//0F
         WRzvcO2AHctll9/gGl63mMX2H+lkCnlK4R+842+EojT3lkz0NrONygbdYOX4wh/hqB99
         0akQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqg+60ZDMMmRzW+VJo7CxHv/BpgRPe6bRlnS4OOMcVb57hbwgLGPJ+1OmUAiz83uxhFT58lsKpXBaQEay0jBjOiPRe9Qwbyg8KB6Yr
X-Gm-Message-State: AOJu0YxSb1iycjNeSBeyRBEtmzYn9/OWCZdTAuM9DZihNV0+tjkM2VPe
	EEy3YTdxHiTblKBe1vqZb6DYSiHHJuYJNJ6UPQ8727OgUL1wr61+0eJdquQwu3I=
X-Google-Smtp-Source: AGHT+IHxICLv8rGCo59jeDyowuTcbYQXuR/fFVeImMfjYukUzMJrpYuiyKtWcPlrPunnuKXL3er48A==
X-Received: by 2002:a7b:c8cf:0:b0:425:63a9:f96e with SMTP id 5b1f17b1804b1-42563a9fadbmr30979815e9.36.1719536839842;
        Thu, 27 Jun 2024 18:07:19 -0700 (PDT)
Received: from fuerta.Home ([2a02:c7c:7213:c700:2cd1:b0e8:abb:540])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af3c27dsm13075805e9.7.2024.06.27.18.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 18:07:19 -0700 (PDT)
From: Alexey Klimov <alexey.klimov@linaro.org>
To: linux-sound@vger.kernel.org,
	srinivas.kandagatla@linaro.org,
	bgoswami@quicinc.com,
	lgirdwood@gmail.com,
	broonie@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andersson@kernel.org,
	konrad.dybcio@linaro.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-arm-msm@vger.kernel.org,
	alsa-devel@alsa-project.org,
	devicetree@vger.kernel.org,
	elder@linaro.org,
	dmitry.baryshkov@linaro.org,
	krzysztof.kozlowski@linaro.org,
	caleb.connolly@linaro.org,
	linux-kernel@vger.kernel.org,
	alexey.klimov@linaro.org
Subject: [PATCH 3/7] ASoC: qcom: sm8250: add handling of secondary MI2S clock
Date: Fri, 28 Jun 2024 02:07:11 +0100
Message-ID: <20240628010715.438471-4-alexey.klimov@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240628010715.438471-1-alexey.klimov@linaro.org>
References: <20240628010715.438471-1-alexey.klimov@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add handling of clock related to secondary MI2S_RX in
sm8250_snd_startup() and sm2450_snd_shutdown().

Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
 sound/soc/qcom/sm8250.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/sound/soc/qcom/sm8250.c b/sound/soc/qcom/sm8250.c
index 50e175fd521c..9864d803114d 100644
--- a/sound/soc/qcom/sm8250.c
+++ b/sound/soc/qcom/sm8250.c
@@ -55,6 +55,14 @@ static int sm8250_snd_startup(struct snd_pcm_substream *substream)
 	struct snd_soc_dai *codec_dai = snd_soc_rtd_to_codec(rtd, 0);
 
 	switch (cpu_dai->id) {
+	case SECONDARY_MI2S_RX:
+		codec_dai_fmt |= SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_I2S;
+		snd_soc_dai_set_sysclk(cpu_dai,
+			Q6AFE_LPASS_CLK_ID_SEC_MI2S_IBIT,
+			MI2S_BCLK_RATE, SNDRV_PCM_STREAM_PLAYBACK);
+		snd_soc_dai_set_fmt(cpu_dai, fmt);
+		snd_soc_dai_set_fmt(codec_dai, codec_dai_fmt);
+		break;
 	case TERTIARY_MI2S_RX:
 		codec_dai_fmt |= SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_I2S;
 		snd_soc_dai_set_sysclk(cpu_dai,
@@ -77,6 +85,16 @@ static void sm2450_snd_shutdown(struct snd_pcm_substream *substream)
 	struct sm8250_snd_data *data = snd_soc_card_get_drvdata(rtd->card);
 	struct sdw_stream_runtime *sruntime = data->sruntime[cpu_dai->id];
 
+	switch (cpu_dai->id) {
+	case SECONDARY_MI2S_RX:
+		snd_soc_dai_set_sysclk(cpu_dai,
+			Q6AFE_LPASS_CLK_ID_SEC_MI2S_IBIT,
+			0, SNDRV_PCM_STREAM_PLAYBACK);
+		break;
+	default:
+		break;
+	}
+
 	data->sruntime[cpu_dai->id] = NULL;
 	sdw_release_stream(sruntime);
 }
-- 
2.45.2


