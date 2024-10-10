Return-Path: <linux-kernel+bounces-358281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 517EA997C8D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 07:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF4CC1F2222B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 05:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2644519F47A;
	Thu, 10 Oct 2024 05:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FBSsFZ9g"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E708F19DF53
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 05:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728538878; cv=none; b=n9FVMCMRmnX5F8qq1BRunbrKnAFH8b1ACwRzguP1X9P/eTO94kAq1yqv/EGhrk5S+FayFy1IdBaUb+tKD6iNiji7tKYUVEnjcD6B63c5p00iq3X9OT/OQ66Li7+IfXw4b8Km1TH98L2/FVEdCN7aSFQh/rFp1Uw0F8cjbTjKzTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728538878; c=relaxed/simple;
	bh=n4Yya5UPRWjsrwv/MuCHQ92gyPnyPl8+oSddQONc8CQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pgZo9boZ7rSZb0BfHKVhRx5VJXzNa3ioi+k5zhkv1Vv5zv6gPtTQXDQO4HqDmVDRLrow6011baPTWrmdbu/4jjWd3iZ9SMR6W3Erj2HZ8PP/OWddUW0D84JIKidvnGWGrLGD9GxgqL0kjZclGZUeE0iraZbk72CCHBUw8q5xPlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FBSsFZ9g; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42ee66c2c49so857455e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 22:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728538874; x=1729143674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BrjgwvWHN78rnkhk76+UTuuJL83ajLzHr+I9S6dugRc=;
        b=FBSsFZ9gZv9XtdeBEDvKsDcuFtEMP5gl9YsSMT5Qy2fXEiU1z/Pt6pqDPBOcDjT45j
         61NplynnmV51wLdFj3BTpuhVMeWVM99U8ChkbnRqD1YC6bfOTUdZOkI3rySTz3Krx2BT
         +R3hSqgOCYyXaq1Oqn051/MuFoHascA29pwdkkOBumNBwnsfbYWvG07/3DXIGZErpbLk
         SoMu+IhOQAFsd59k2/tdxVlHl54x81IVuzW25nBC9YnHJ1cVDzuweAWcCHTzxfHWKZZ6
         tP+4E2EWiwlnSQgpHcXVjcrEy3DVTGTyIlDoRoLi+LMAG0A84QiaPFg8yjhAVnTefSs2
         Vz5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728538874; x=1729143674;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BrjgwvWHN78rnkhk76+UTuuJL83ajLzHr+I9S6dugRc=;
        b=NrewVocz/rgwbwdJbtUOwxylvj3snWR+OnnLsSr+bh8QXfdddAceQ4E5HkCna+Gmun
         qJesp2hY26OW5H0Uluz9pMqc2BouD9tcbmXgWIA7krKBEcEUtxBAVt7pOi8hvjiBOUSD
         05QWildY0lxY6vIcPXZ03KjpnnNyvTqh3dbaOYwH4NM5agEAlQTZtZ7HAZLVQ+JhNDOq
         2Aqnh9X39mLxnT8c/8B+wNZ1Ys7Brdz3LveiY0jTOO5+H5RnNkp9j6BvTiKCknzIFCU+
         XtKHBP1T8c+uWHPtoi/OsSFyU12SKxMEDOovsHD7D+8Scx6HYPxhqiYGT9LQ55cT+lWu
         Uv2g==
X-Forwarded-Encrypted: i=1; AJvYcCX89P3MRyJRHSXuH2mT/bvrGpLu9owvOoJxO45J8O3YNl6zBO2pWDhXP/LlfArykpSJXf/c0zGZhBW/JCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEEdhLa9N0Dd2kBCFW9LhYc1tscN4u7EY64vENzpbVD7x9F36A
	akblbNWBqzjjcho9KCBB5503wi2q5A+eI6nWaXanAR33mtac1xug7cvGPzgcw20=
X-Google-Smtp-Source: AGHT+IGMcrbWh3FiBdofv+GjB6zrahVpaykf4I2KG2DTDJ+cpZ7YQE/hZsMQaI6xmqyVJXWZmAb75Q==
X-Received: by 2002:a05:6000:144b:b0:378:955f:d47d with SMTP id ffacd0b85a97d-37d3aa7927amr1902648f8f.11.1728538874120;
        Wed, 09 Oct 2024 22:41:14 -0700 (PDT)
Received: from krzk-bin.. ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b7ee0afsm522116f8f.102.2024.10.09.22.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 22:41:13 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	linux-sound@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Alexey Klimov <alexey.klimov@linaro.org>,
	Steev Klimaszewski <steev@kali.org>
Subject: [PATCH] ASoC: qcom: sc7280: Fix missing Soundwire runtime stream alloc
Date: Thu, 10 Oct 2024 07:41:09 +0200
Message-ID: <20241010054109.16938-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 15c7fab0e047 ("ASoC: qcom: Move Soundwire runtime stream alloc to
soundcards") moved the allocation of Soundwire stream runtime from the
Qualcomm Soundwire driver to each individual machine sound card driver,
except that it forgot to update SC7280 card.

Just like for other Qualcomm sound cards using Soundwire, the card
driver should allocate and release the runtime.  Otherwise sound
playback will result in a NULL pointer dereference or other effect of
uninitialized memory accesses (which was confirmed on SDM845 having
similar issue).

Cc: stable@vger.kernel.org
Cc: Alexey Klimov <alexey.klimov@linaro.org>
Cc: Steev Klimaszewski <steev@kali.org>
Fixes: 15c7fab0e047 ("ASoC: qcom: Move Soundwire runtime stream alloc to soundcards")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Not tested on hardware. The sc7280 sound card differs a bit from the
ones I am working on, thus please kindly test and confirm.  Without the
patch KASAN should show something similar to:
https://lore.kernel.org/linux-sound/20241009213922.999355-1-alexey.klimov@linaro.org/T/#u

The patch should fix it.
---
 sound/soc/qcom/sc7280.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/sound/soc/qcom/sc7280.c b/sound/soc/qcom/sc7280.c
index 207ac5da4dd4..230af8d7b205 100644
--- a/sound/soc/qcom/sc7280.c
+++ b/sound/soc/qcom/sc7280.c
@@ -23,6 +23,7 @@
 #include "common.h"
 #include "lpass.h"
 #include "qdsp6/q6afe.h"
+#include "sdw.h"
 
 #define DEFAULT_MCLK_RATE              19200000
 #define RT5682_PLL_FREQ (48000 * 512)
@@ -316,6 +317,7 @@ static void sc7280_snd_shutdown(struct snd_pcm_substream *substream)
 	struct snd_soc_card *card = rtd->card;
 	struct sc7280_snd_data *data = snd_soc_card_get_drvdata(card);
 	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
+	struct sdw_stream_runtime *sruntime = data->sruntime[cpu_dai->id];
 
 	switch (cpu_dai->id) {
 	case MI2S_PRIMARY:
@@ -333,6 +335,9 @@ static void sc7280_snd_shutdown(struct snd_pcm_substream *substream)
 	default:
 		break;
 	}
+
+	data->sruntime[cpu_dai->id] = NULL;
+	sdw_release_stream(sruntime);
 }
 
 static int sc7280_snd_startup(struct snd_pcm_substream *substream)
@@ -347,6 +352,8 @@ static int sc7280_snd_startup(struct snd_pcm_substream *substream)
 	switch (cpu_dai->id) {
 	case MI2S_PRIMARY:
 		ret = sc7280_rt5682_init(rtd);
+		if (ret)
+			return ret;
 		break;
 	case SECONDARY_MI2S_RX:
 		codec_dai_fmt |= SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_I2S;
@@ -360,7 +367,8 @@ static int sc7280_snd_startup(struct snd_pcm_substream *substream)
 	default:
 		break;
 	}
-	return ret;
+
+	return qcom_snd_sdw_startup(substream);
 }
 
 static const struct snd_soc_ops sc7280_ops = {
-- 
2.43.0


