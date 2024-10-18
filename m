Return-Path: <linux-kernel+bounces-370867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFBD9A330F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 04:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D650AB22FB6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 02:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C1915CD74;
	Fri, 18 Oct 2024 02:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tl4AXo94"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D9313D531
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 02:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729220100; cv=none; b=R6VEOR+UYrdvHqonNHDqQ2t+QWj5Vf+UM+I3pbw5hlUFzZgGJMWjqJ+JhL5Tg3ZlUuQhByClLyO3+kbfEMw5WncjUIK2OcvzJwo690+Y68uoU1575HbaEKtdUQMYUd6EXYFNfs9u9TuG/lYXf1J95L0qFMbzProZvEB0nKiEAqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729220100; c=relaxed/simple;
	bh=VYOcc9RVqAC3xOcalVCeGB8TpM4JFvOp4HfDK7tCROM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KCB/ZdrpARY+/B7cyDpOcDDbEROpjU/fJVTAwIr+AHaF87EM12P4e2Rw3TAfVBzdeTiEk35IkINm2PwtpFIDRBObY+dGPosKupeGFKwCVZhc4H9BIyWwV9deKiAQIuyhr0GvLJeSVv8MweF3AVpFif1Nn+SY20vjBbGY/QRKAwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tl4AXo94; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37d5038c653so1060878f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 19:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729220096; x=1729824896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IzDTogGhhkM8ckQfZ1srs6eHShvXoQY5Qk/joVtqUSk=;
        b=tl4AXo94JawXI4aZnlXIhYb/pp0FePYhsNY0KmihyfqQnkyoF2ULEze4OolmkPtN37
         rnEKWKuWOTMnj6XBvY9vg2xxmFKWsijfIFYoEGvxdoEDf9mAZKoXTjTRFB5hlQqdEqi+
         W8GwTADwHWF9tdkwxB+zA7skmV7Bapb9TlpMoQdoX+SWYEElDMXkbhsKlJzQ4IuDb6zb
         iZy0jKwWouvxEsfOeN+j2zMw0i67c0S/8UCQii/2y4aoyDRLVj1KxfCZan609u2uYSdg
         hmsLQPxKTmfnh7G3Io+dGWyf0EjBO3sY90evfQlSQVUFKcMEK3JdZ3J54M3wW2IRy20G
         wJNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729220096; x=1729824896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IzDTogGhhkM8ckQfZ1srs6eHShvXoQY5Qk/joVtqUSk=;
        b=LqOGMQys7Rzwq9s5cQqRzRpWjF/Rd/fkVZ/Ml+wbjzdcTJFsIK7ttBiDYC/6C/bxef
         6z2NKytGnzHip1YL2jQ4th0qgjThtsr+6tkH78ZErhSYBng47IdZ6veZ2T+JsTM/aJAn
         lT12uGxvquxXb+OKZ6LErnW6+M1VUBFIApJQ3kqrWGvbtj4BjeAm5V/YTyXQrsyA2ouY
         S5fgtEsGoDcpeWhfbKWdE1pNE8hnSn6VA4Bz1IrdKspw2IvyslVUH0mJfOxvbC0SYbW7
         unubbCp3y/lM5W7F+jvbhmNNgRzHnuiorjSQ5ai+UT18+f0k2u4y136h+eqA5MqXjGHB
         +fag==
X-Forwarded-Encrypted: i=1; AJvYcCUuni2z7iNmQfVP8cifJj08BQT+xXeHaje2bKO4rcOnstlOFBi6Mtq4hQXrjsYHUzlV9S2iBZG958ZySoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlRvNy2E1d8fukdhHq2r/wTBqdXYiYcQJft+zXn0zH4T9TwWZr
	900wSPu38wsXp5Yw3BjH77LlxRmNRpY1afuKEuWBk5ohTzXK0tl+6hNFoKJIsxI=
X-Google-Smtp-Source: AGHT+IG3QrTDKAJwACMKKsazABlgr9tE3nlrIDdOrBRAbB1H3cVIrDGUpkSiHJ434J6s8XNZtjKUuA==
X-Received: by 2002:a5d:61c3:0:b0:37d:524e:9431 with SMTP id ffacd0b85a97d-37eab73368emr496858f8f.57.1729220095916;
        Thu, 17 Oct 2024 19:54:55 -0700 (PDT)
Received: from localhost.localdomain ([2.125.184.148])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ecf0ed599sm596135f8f.69.2024.10.17.19.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 19:54:55 -0700 (PDT)
From: Alexey Klimov <alexey.klimov@linaro.org>
To: linux-sound@vger.kernel.org,
	srinivas.kandagatla@linaro.org,
	broonie@kernel.org
Cc: lgirdwood@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andersson@kernel.org,
	konradybcio@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	dmitry.baryshkov@linaro.org,
	krzysztof.kozlowski@linaro.org,
	caleb.connolly@linaro.org,
	linux-kernel@vger.kernel.org,
	a39.skl@gmail.com
Subject: [PATCH v3 1/5] ASoC: qcom: sm8250: add handling of secondary MI2S clock
Date: Fri, 18 Oct 2024 03:54:47 +0100
Message-ID: <20241018025452.1362293-2-alexey.klimov@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241018025452.1362293-1-alexey.klimov@linaro.org>
References: <20241018025452.1362293-1-alexey.klimov@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add handling of clock related to secondary MI2S_RX in
sm8250_snd_startup().

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
 sound/soc/qcom/sm8250.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/qcom/sm8250.c b/sound/soc/qcom/sm8250.c
index 91e9bba192c0..45e0c33fc3f3 100644
--- a/sound/soc/qcom/sm8250.c
+++ b/sound/soc/qcom/sm8250.c
@@ -63,6 +63,14 @@ static int sm8250_snd_startup(struct snd_pcm_substream *substream)
 		snd_soc_dai_set_fmt(cpu_dai, fmt);
 		snd_soc_dai_set_fmt(codec_dai, codec_dai_fmt);
 		break;
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
-- 
2.45.2


