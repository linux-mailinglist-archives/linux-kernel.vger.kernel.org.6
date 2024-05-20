Return-Path: <linux-kernel+bounces-183831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 157828C9EAD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 16:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63553B20C18
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 14:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF103137746;
	Mon, 20 May 2024 14:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EsHX3Cxh"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55899136E0E
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 14:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716214817; cv=none; b=PHQjlyFFkK/x6BhwjIZ1jEMhTc+rJyJ0JmXhJh3Vq0h/CSZ+LkOuwZP3KePJAWuMqFtrGpv1hxHkImbxUUU7JUJhHrRQ/4gsmG6gCnnHqkNOpcWf7vgnAe9AbmER3ZHqEyZiguG+lAFcPON7PKZOIaDBBWagY+7woYGhEEJYzJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716214817; c=relaxed/simple;
	bh=RVNDo+PUPNeV1sa0OC/s/rwZqNAdhw3yPx+40/ruZ0I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tploeV29hunJeIj0g97BjZDqqVGVhQywR4BRaLU95lSv+gbANJLhrTCNeiff40nauuCesYrLOcCUCv1PVy30dnj/GPeNTEwCFz7Dq3X152CTt2r7z4E1fxyVsfy964sjrwZ0GvCg7HxLYb5VAVUqJr09nu4EUr5EKPYi6QjFp1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EsHX3Cxh; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4202dd90dcfso19038625e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 07:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716214814; x=1716819614; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sm/iyvA/oRf8IDDwCG6199y51shfGYvzaBKbXuvmT5Q=;
        b=EsHX3Cxhe++t2nkzT8qK5R6KEmp7KAf24jEZUzy5E8TUMrAr7A3cjnxTeBA/ZkRn/7
         qJ63r4H/u69p6h0hST2UZ+3oEtDqWDifIXes1LLQX+OvQBrH0YhvuOl+48VYaa4NwO0n
         lC54mhsZcOtEfq2h3LNBHLJGRcRHi2A2GgQwdO7EKiL6TggSOiCRIPr9xs/NdZnElr7R
         P0WoVOuqe6kcnwvVR2Xe6ZAujknMqTW34lKSUH/NhNTEcyu7DgP6XTrsHJhhjcKLORDt
         kAg6qKUn7ngexImvq+MFRqdVhaJFvdLeY+QXqU3g98VQwjYfCsHsItQhQDfRvdneaLD1
         D3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716214814; x=1716819614;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sm/iyvA/oRf8IDDwCG6199y51shfGYvzaBKbXuvmT5Q=;
        b=kgxBsvhD4oq+yxKHRRfbvTGFzhM/UREr2m6EoQvKtbIm5v7eCR8i2KTBMBBN+Rrfv5
         6h39ndgG2aA7A0yn2LmQ895x7eIOOuGjciXrL6xzCQCGvB4Q/Aqu077+E1ADcVp7yDDF
         t2S+X5uWAaC4sIX86/A0Zt5wYvX509gHE1vm/Q9HCfB+tSQgjwAsAtfkjoTkpagigsWS
         Lhr23mfpQwM1gnIljLlafIyfUYm0qyzkWbQ3/8IHt+lBXGfja+ZwKw+QMhlAFZxwT5rA
         IGSbsIHT8UEB+ftQk9PmHRM8Cu/iv3HTM35wySBXFNR/qf3gxJmmQf6nIKKVwxHREMmT
         yCzg==
X-Forwarded-Encrypted: i=1; AJvYcCWn9K2guP+44V6Ox4vZbrK47cvE8UkfAR/1xKELXExT7ylsTC5RtF4ERmoW8ztE304v7CE/urFn9Ei4+0RV8FChJKV3moWhUtQQX+mu
X-Gm-Message-State: AOJu0YwxsBPXdq6OwP/pEOfpAdguNzMCALznivAGmkUkJs0FRa9MRKxe
	T5cwqpr8OB+zMDqW8M0qb7Mi1km5vJLFQtDIJRCgG72DUdq5VSE0iByBpPJqDsw=
X-Google-Smtp-Source: AGHT+IGVRyJJ7aHIZMec1RRFI1lujPx2Dl5vOFi8D3htETVzjOwcHTweLhfI2iYBMlx8IuAnYEGitQ==
X-Received: by 2002:a05:600c:ac1:b0:416:3f85:d49 with SMTP id 5b1f17b1804b1-41feaa42cd6mr250592485e9.18.1716214813838;
        Mon, 20 May 2024 07:20:13 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccee962esm421612625e9.31.2024.05.20.07.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 07:20:13 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 20 May 2024 16:19:59 +0200
Subject: [PATCH v4 4/4] ASoC: qcom: x1e80100: Correct channel mapping
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240520-asoc-x1e80100-4-channel-mapping-v4-4-f657159b4aad@linaro.org>
References: <20240520-asoc-x1e80100-4-channel-mapping-v4-0-f657159b4aad@linaro.org>
In-Reply-To: <20240520-asoc-x1e80100-4-channel-mapping-v4-0-f657159b4aad@linaro.org>
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
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmS1wVxsw/p+VXN2eP9N2OLCdsAbVUC+7yjp30j
 BFHMQJTguOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZktcFQAKCRDBN2bmhouD
 11RZD/9MxHl6NYGke5RtglSMF7GhedR5atNcAnGjmHO7nesbXV3GMuToOk7k49VmQaxlg5ly6IH
 Oy/wFsxxZrSJzd4ce+sjQXd32sRXnGipksKiB0wvIhFvY3973MiUP7xxLaMu4WxouANJiRp5FFD
 YxkuzSLXrekOrO5foULPEM1L38vcjOqveybopaNm5+vJWgKFqD/EF7WfXWgEJpErXbmP2oCTO5d
 2rxWiiHdabrrpD4yuMIjmm2P/HivHBx2LUra4m4HkRB0Wp/TAL7vKvtmgCJcY5pTgwm5IRyOoEV
 qz3kkoAKC90nAnRYvPdMRrDyRmorQvy5dK25BbUCnU+HO3fZT6VvNXMnwqu6+cHOs9h9tqXwrpl
 Qj72RqmdHOTEeoSCMbkqrhL/5z2C70E1wT31yLDDF3w2GfcGeVcQIDrPs2B1DdEvobRYezY0LGX
 46Mtxhuz/FJZHQC/uNQcJezBniMAa6HS29M9eJRqtbyVetJhH3qFhRyCuS+GR1jDXXJbA+uXm92
 PLAJwp0uW43HJKhO1gu1gobTm1ciyxwb8KawtkuolAxewb2CZFFz3PqGie23cgyAsLLPZmPLRl/
 iyCSH587Do9m4PT0jtp1RoT3AI9Kni5RNKgPAOY1Rp12Kt0gi2gWleqA5NYxMC7B9fiUhaiun9T
 Lgf6MaPNLe76WRQ==
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


