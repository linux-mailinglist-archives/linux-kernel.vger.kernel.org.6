Return-Path: <linux-kernel+bounces-172899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF3A8BF84A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 10:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCEAAB24818
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 08:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04713D96D;
	Wed,  8 May 2024 08:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SyctnA4x"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5619D52F6D
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 08:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715156208; cv=none; b=G3eC5pDwlU2rNFuDLiN42SwV26PZTKqo/yoIzrx/T1C5I6P4KvBX+24L551Bd+StERgWTwD+XCQSHtJyNTyAZ0JtWdKAEse4xWIIEic/qWoB2UG9sbnBZewLDiHiOe7IGwOGuVArHLORqk0RRj+wdnnG+JFjP/w/ol9Or1w7TK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715156208; c=relaxed/simple;
	bh=RVNDo+PUPNeV1sa0OC/s/rwZqNAdhw3yPx+40/ruZ0I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=siGzYdTsC9muuvrfAMMSoUpZ7Vd0FPF63WDrkTJeFpGepC0mRuOyJPHBVHoALGzRtWDpN01sjGdKxKh5kZentFLC5GPH8Q0ttihcCTmKvNSNtgHdgyLY37pnhdeKInH3amY5mX5kMT+Nhrra4gJMPyUuSI6co5S9u+W2GahbkVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SyctnA4x; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a59ece5e18bso439657066b.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 01:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715156204; x=1715761004; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sm/iyvA/oRf8IDDwCG6199y51shfGYvzaBKbXuvmT5Q=;
        b=SyctnA4xYaVsB2PPGVfs+voYP5cw3cQhuWXRyCUAs6+naaiTT1v4+V0CCIJeatEQh6
         mJqOzkukGLxu0IcYF9JxVjNSooAsuvfHC/PWaZPpAyuPjHcE0sdBvSVcRMA24wAa1x6G
         Ih7++DwW++DPUqlHr0rU/w9Uyo7st10AywkFAJWYTtW5tzFeOFbpio6enpG8FpAeKck9
         nNbiN00ErA08hpn3oDnK/pAqgwVOtmIKTxFzqgkVD8j+3YuXyp9bpY1EywrTn22aOpBq
         dk0zoUEG+7rNLIUy622kKBTBLpAqPp1WuRPCRfpE37Vad3Gtsn1c/t8fJMDOoHkkl5ON
         Oq1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715156204; x=1715761004;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sm/iyvA/oRf8IDDwCG6199y51shfGYvzaBKbXuvmT5Q=;
        b=gY34t2p7rAzGF0Bj7+dBPXsBHWOOdPRnkFToN9CWG2nkJ1aZvotWWyjtRyy+auUBOz
         kJ1KoL2Qj5HW8wB7j2/fE2ERMnfPSn+Np0NTuZcnB1PDtgnEfjUF9ceD94mZmzOcyJ4q
         pawgTUOJB+Qoxdmok1lc0ix/Xurhu3ZQr3XoGKPRAJmOB6WM+hDPbPvs8/NTs5q/Dr6a
         UPuJsELuUE9EN1rB3AH7e6y5JzCbWscw5qmDcMWuQgCEpC1iMzrOzNLi7MwRhcqFrU7F
         X0YVcLD/4gSrWssK43mfHjHfoWrzgQn1eg8A513fSe7egGhD+R90GNGF4pQqi1rNCqTN
         NkOw==
X-Forwarded-Encrypted: i=1; AJvYcCWmGUvdZ/e4goTuWbXwdgDkfmNEUnWTCaqoLZNiv7v/1k7hdAmNoT3N4FBMQLBrpc/mW6kR4rx+lEL2hZxhHxlNnmxONgJII2ebe7QJ
X-Gm-Message-State: AOJu0YxWTI+kX0jBXXo895vA9ju5N0aMOwQx0TvdeRcHF4G4axKs3DkT
	/lZNxbiuq86u2xiKv2gxWSL60X2lsmxr68W7+DKkc/UrDqLLEGNYYzosE8B5oVs=
X-Google-Smtp-Source: AGHT+IEcO03sXS25ca8HNMd80x92ztrXnHCfFufNC3oFOema6hx6ZWP/GUScP9uFCp2eEtc5nFXxgw==
X-Received: by 2002:a17:906:c2d9:b0:a59:c23d:85ce with SMTP id a640c23a62f3a-a59fb9c6b24mr143408066b.51.1715156204516;
        Wed, 08 May 2024 01:16:44 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id va28-20020a17090711dc00b00a59b87dd0d7sm4564734ejb.147.2024.05.08.01.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 01:16:44 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 08 May 2024 10:16:30 +0200
Subject: [PATCH v2 4/4] ASoC: qcom: x1e80100: Correct channel mapping
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240508-asoc-x1e80100-4-channel-mapping-v2-4-ccef9a66a572@linaro.org>
References: <20240508-asoc-x1e80100-4-channel-mapping-v2-0-ccef9a66a572@linaro.org>
In-Reply-To: <20240508-asoc-x1e80100-4-channel-mapping-v2-0-ccef9a66a572@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1580;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=RVNDo+PUPNeV1sa0OC/s/rwZqNAdhw3yPx+40/ruZ0I=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmOzTkOvfRHwYugcz1kWoAcP3RrYYVLFgYomUkd
 wIXaQGCsqWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZjs05AAKCRDBN2bmhouD
 17MfD/9ppYgawBoat2rd8pJ2G9oUl2iFD/zoJ64d4jFm5+wgcwXzMQiTRfSf7oFG8U+a9tEP9Lz
 KIEJluX00tJicgT3dxM0fC1NxHgTQKdyRhCTgsyoYlIdMsM5ffGkaPXZpKUnbZLpvoKC5TS9l45
 XuZnc1CaiutElSV2WeOBZN055cBzSup7HUYMjrpjYw1ZjJodQmROFvIp6DC8ck09Eaivs1Faz4A
 pRgweZoMHmEmVlESPoHB574JtwtKaYnL3naL9Q9PxmReTPmIyHYXlQvao76rKgdsVaHcjuveRWM
 Se7RGCOp0csNhKv9bvu/U9+OUUUizlnwE1OktST9U9nZxrmM0kTURDj6kz7+84uVwf/dN3AUiq/
 akm0Zt99Wo5Jc3m2WwBRizlSMx7SIx6tM8tjNL6NDW296+M4Z4wlKD5o/Vm509RE5V/LSula/Qa
 G1OvZI53EqPpwlgGtESAYdfmmQl4pnz+mAIbhyevVgEjrpgLmVfUaPb6g9jc45jR8XBkkH+hs8A
 Pjg++CEL6W05MMiNzBediwzt5EYd8dvKeQB1Bj2P/Y3kfuPKUnW2tJ8b2bevnmE4DJwlHzyCVDT
 8sxPzgstpttuV5NNVaJjbbnJr1HFnS3lhLY61Y6JW/kmIRUoEj59SdrGb/tqhXXsz7lQPgYiRhl
 /HjRVehRnvlOnwg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

X1E80100 CRD board comes with four speakers arranged as left front+back
and then right front+back.  Using default channel mapping causes front
right speaker to play left back stream.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Rework significantly, because only backend DAIs is now affected.
---
 sound/soc/qcom/x1e80100.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/sound/soc/qcom/x1e80100.c b/sound/soc/qcom/x1e80100.c
index c3c8bf7ffb5b..27f34c0873ab 100644
--- a/sound/soc/qcom/x1e80100.c
+++ b/sound/soc/qcom/x1e80100.c
@@ -12,6 +12,7 @@
 
 #include "common.h"
 #include "qdsp6/q6afe.h"
+#include "qdsp6/q6dsp-common.h"
 #include "sdw.h"
 
 struct x1e80100_snd_data {
@@ -80,6 +81,23 @@ static int x1e80100_snd_prepare(struct snd_pcm_substream *substream)
 	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
 	struct x1e80100_snd_data *data = snd_soc_card_get_drvdata(rtd->card);
 	struct sdw_stream_runtime *sruntime = data->sruntime[cpu_dai->id];
+	const unsigned int rx_slot[4] = { PCM_CHANNEL_FL,
+					  PCM_CHANNEL_LB,
+					  PCM_CHANNEL_FR,
+					  PCM_CHANNEL_RB };
+	int ret;
+
+	switch (cpu_dai->id) {
+	case WSA_CODEC_DMA_RX_0:
+	case WSA_CODEC_DMA_RX_1:
+		ret = snd_soc_dai_set_channel_map(cpu_dai, 0, NULL,
+						  ARRAY_SIZE(rx_slot), rx_slot);
+		if (ret)
+			return ret;
+		break;
+	default:
+		break;
+	}
 
 	return qcom_snd_sdw_prepare(substream, sruntime,
 				    &data->stream_prepared[cpu_dai->id]);

-- 
2.43.0


