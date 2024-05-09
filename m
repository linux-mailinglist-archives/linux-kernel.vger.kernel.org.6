Return-Path: <linux-kernel+bounces-174218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBBA8C0BC0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 08:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAC90B21DE0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 06:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0123149DE9;
	Thu,  9 May 2024 06:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M8EhKIKS"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AF914830B
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 06:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715237533; cv=none; b=Cq+aaTgHxGxSd5WlzF5Fgx1mZIK/1fVWar0sDAxlNHeJQQWIsLQuo3duh/lWF3nv6P5vVZ1vAV3qIUubxCi+TiKVKQwpCmjRvLPWfagCiVxUCY9aJ4Ud/3bpicBY4ULVuW+oqKEIxOgsXM8KCCWGcvkv3auBKHPGP1eld223sb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715237533; c=relaxed/simple;
	bh=RVNDo+PUPNeV1sa0OC/s/rwZqNAdhw3yPx+40/ruZ0I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BC1CTYPJQjfPccYs1IhyIgUwFeKDuoD6M4SWentfxw/xBFVO8n6grGLTau0xjdci0z0uuetDeDFc9lSTntqsWhwogQZIm/DFpoVpd3Uv79691M+ZB04Ca/oBwZpLC9cKFJMb4BszCGkZu35NAABA1yg3cMFXuJd/d7DacV1V0X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M8EhKIKS; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a59a8f0d941so116291766b.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 23:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715237529; x=1715842329; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sm/iyvA/oRf8IDDwCG6199y51shfGYvzaBKbXuvmT5Q=;
        b=M8EhKIKSHZFQb100NC89UU1xw9FdpDBlMCukprNMrRbzbXtEByFxNkJ1sSnXu6Or6z
         0MvRc4NxuaI5tgJbIZ4756JER0Z9+tVLuPWXfpADci9WWGT2ScP8/STtj3w37bZt9Tr6
         Y0V24JZ9x2wPux4Wbu2AlzHW59bsiEzShaZqoWgzeUtIGRRzmsw1RR6qenr1UwEp7I8u
         BXxwbHEJdWJeKsvUw368YHNoO+rpN7p62ibpDdSKPN5vhz/Ox7UBDHwF0PJILdpeBU0o
         iXPaFwApZZbRwILuzolcrxzhQFSmiw2cSgd74aRptkPtodbNKQBh5njKMO4E4dpW7H9p
         mELg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715237529; x=1715842329;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sm/iyvA/oRf8IDDwCG6199y51shfGYvzaBKbXuvmT5Q=;
        b=fv2p1DKpVCJyZHERwX35Rfzgj9lbTMHF5t0fTHFDKO5lxINflk1aixowc5nh2j2tHA
         JcMD2QTqvLwf7TSJThvkA/1zGiXf7rYnhs0bcR5arXrrCiS3rw4k6U3izaC4mTXkrdWc
         YB3e5L5si3oT6mDKblyE4Cy3uKa/fcPGPepQd9p73X6qzbDbDaECto3SFTV/48vQUDYB
         0qSzVkcHfVBDR0LXSeiR4Otr4YinhXG7xrrAtXfCzidoCN6jESeJ6tOMkKbut4hX5Dzm
         mMAOy4PNFu53/wSzfMeCFrof/HW5V5lB1oVsfCANdB6W1g9CKenFIkUuJ830NT+ATB1a
         Vf+g==
X-Forwarded-Encrypted: i=1; AJvYcCU+vkheL//rdYRVRPDOp35lsGGdBE3wBQsRd3EeSoLEN7YIFr+iX+K39agmEluJouRTTc0mx/uRFrPcbPdktxsWEhgBqFmHWeVQcOEg
X-Gm-Message-State: AOJu0YyxAT3HOb72rP2MZqPOangnf+70xjhDU0y4Mj8xD5g9DNg2xbFS
	bxpUl2Ve2GSC68RZJJe5V0TCZnEP0SFh7yHI7D3ppQf9DHxNq1ZXAPt/donNKzE=
X-Google-Smtp-Source: AGHT+IEMC0ilJJg70QPm8lCy30IW4I4keeEdeUIMfIvXhDrQwwAW7AyVSUXqZdNZWj/o+Uu0TeE/GQ==
X-Received: by 2002:a17:906:4f90:b0:a55:9dec:355f with SMTP id a640c23a62f3a-a59fb9f33ebmr248070566b.70.1715237529734;
        Wed, 08 May 2024 23:52:09 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c81b4sm40730966b.113.2024.05.08.23.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 23:52:09 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 09 May 2024 08:51:55 +0200
Subject: [PATCH v3 4/4] ASoC: qcom: x1e80100: Correct channel mapping
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240509-asoc-x1e80100-4-channel-mapping-v3-4-6f874552d7b2@linaro.org>
References: <20240509-asoc-x1e80100-4-channel-mapping-v3-0-6f874552d7b2@linaro.org>
In-Reply-To: <20240509-asoc-x1e80100-4-channel-mapping-v3-0-6f874552d7b2@linaro.org>
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
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmPHKQ6q9dlK6QeYXKuhYX2fKXvqRW/b0nGYjRh
 2E7JweWLsOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZjxykAAKCRDBN2bmhouD
 1ykRD/9phzYxpFTOlOqgN9zWlD7Rfrfe3bxuQU5kFU+icEpDFo8F2hCsSFLI6uQ4Z2cf41uaO/8
 g+xLf4Xze1eJsiPrInQunZIDKmC4SmmNTgLUYEr8fz9Y4ZVy598pMWb7OwcaIJgz0bF2x8YlvJ6
 l0uTy0KvJsjOgob1sCevdxjc+fOIrsMhCJj6HkwiZqKqkG97A+/hywM1gUietOPg7RoLBIxTpBv
 Dcgthuky0Tx2XwVYvJVnvpJkGfxsZeNFe4vsd5+i4ssCusVsceNk5MnyuKRs0qLvG5t9MB+61Vr
 x9h3Sq22Zh0wzNINkwmeAWFgxUp4YoFi2IeppBIMeGNAC9PulfGEXkA7KtNBA7YrWm+9dEbpZNA
 H0H69uHC2QLIVM35t9oW2CBABgYrBA9HIfHMPR6lse8TYEtE0tQLQd6JS6EqOYNPYqxcgcUIEQL
 qgtWHgYcVkAwbSQS9aJRA8A729jSf6ilIVP9e9K0LumKdC8lrf1Ivt1q4UmK24EAZLspjfKazFM
 EUJWFcCP7h3y/S3Q3jHZmOHv68J6EEN6v5ZjLBvGA/yEaOIRMKPr6y8Q7zpLsJzIhpcC8IFNhUa
 uHVltcm89oAAtDJ8TCAWRvRSBfp7qNuORz2hIsR60MQ5tf4Z6A7/1uDaLsNKw35Gz/p0BBty/Dz
 NFTTxIY5KEnSu1g==
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


