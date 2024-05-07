Return-Path: <linux-kernel+bounces-171100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A16E88BDFBC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 12:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57D24288653
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 10:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D865152E0C;
	Tue,  7 May 2024 10:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bTqboszw"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EBE14F9DB
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 10:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715077672; cv=none; b=p4X5s1YJdVZv4dIMo77dVgy7xVC+wofNio7kfvl/LMTmwX8flgw9sddIdaYsaEOCm38q+dxcxVd5KmirIva8uWsZ1FCYGFPoR3WAVvZYYYwgoZRKKar60S0k/SVcm0yCNucVPgb6ShldnkUyf3kj48uDXLe9+ROeUkyUr3seIEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715077672; c=relaxed/simple;
	bh=ncE3FH0TY58sFGa9Rl6y2ExmL1TBCQDazEEcf1SbmOY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q+49bibiWDOafECDCSeAuKYTemy6Ol3SO5vqLP3rDjSo5rqicxjcAtRXfrpw2L1M27qHlKvV5N1v4uzw+SRf0Cj+J0KRoDwU8S2YccD5ese1VR3ZrqqNeDdVOl8D/vis76L+eVQfV+kOes8/nVUCyZ4s1zIK1pfgnJVov9JNKN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bTqboszw; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-572baf393ddso8985016a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 03:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715077669; x=1715682469; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4nKzFo7oe//9kG74WVhks4ZLuw4EcTS+WpLRtZjt0GY=;
        b=bTqboszwrQ4aUsNQ4cwbqXwqnXgXwUR9tNkxITgpR1n2X4hAiCOXDr8wPemJpKK48a
         TiVDbDcWTHE6Qb8FFYouZJzkTPgN9nB9D5bqhgfbx8rxS5Y30upEQNr5d9B08ckfde8N
         w/86sj4hDO6uQprJrCCGQtccFK9ckR3JBAHVWqE7KShnyUTvwcuJxasS95Nqm7Dnp6rP
         xUAx8Wy2/j/nOM7QbJaq26x3Fjtyde/RzxwsKcoEFK8jkQVWbio4b0ZgWBu5R4g2MgEY
         BbBn/JV9grFEdlbAfktwt7bu5JWYO+SNeU27n/SrtbcYmx2rNAc0b7Mn0k7vuOV0rIBM
         n09w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715077669; x=1715682469;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4nKzFo7oe//9kG74WVhks4ZLuw4EcTS+WpLRtZjt0GY=;
        b=a1jvtN16GPCu16QY2twzURmWH+kzEUf5etNPFyPxqmQtBws7/0I2TJ3SDtK95wfGEx
         GVuLRJ9whb98/ohIjnEj2rBvF8ty2l1rNyQn+kyhR+hZYVLroCUljeQw38fo0U2gDSHS
         VyiTk1OZFZTGmmweXGbTTZuLvHXr8XI6DjA8KPF2ASSXQnV3tHzJe0+5/8mpJFxWmNC3
         CgiSTF2xnzis8YxMaeWeWyCAd/1cZS6Yzkmmo5mfDoQCLQFoFxQRatUbgz4YBS1WW1s1
         zfXuzN0DJAmzVkEqN5Ij34yes2LgzKQY7gBrfc2rPEADAfMWjR9gtpOILVTxVGh7l6NQ
         Hh6w==
X-Forwarded-Encrypted: i=1; AJvYcCXv4ru/bOU6g0T7JrldOIPxoiTh8YdXlUAmfRWEqzX9ihHH+HRubOJgF1QGyT8M9vWBqysbRNXveHuwaKVhUarE6MRovzanp7TM8fXL
X-Gm-Message-State: AOJu0YyVFRVsXj8PIYfZmAaK7OwIfwVTbMNc5P1yxRTerIxmy9wsbeAj
	LqbWJd/rUssilUyRovpZQCLKmFIn/ySXSGfaiGT4lSFGh1qdKtsDufSmhqy69kQ=
X-Google-Smtp-Source: AGHT+IHxr+kpeiafMqoxHfKgf5yt6IB9ScYZU6jaD6rdvbS50GCRRhzNcEFrQXFWvrvB3EXyV7WKoA==
X-Received: by 2002:a17:906:71c9:b0:a55:aded:200d with SMTP id i9-20020a17090671c900b00a55aded200dmr1705986ejk.12.1715077668923;
        Tue, 07 May 2024 03:27:48 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id bo15-20020a170906d04f00b00a59b87dd0bbsm3370093ejb.161.2024.05.07.03.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 03:27:48 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 07 May 2024 12:27:33 +0200
Subject: [PATCH 4/4] ASoC: qcom: x1e80100: Correct channel mapping
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240507-asoc-x1e80100-4-channel-mapping-v1-4-b12c13e0a55d@linaro.org>
References: <20240507-asoc-x1e80100-4-channel-mapping-v1-0-b12c13e0a55d@linaro.org>
In-Reply-To: <20240507-asoc-x1e80100-4-channel-mapping-v1-0-b12c13e0a55d@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3113;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=ncE3FH0TY58sFGa9Rl6y2ExmL1TBCQDazEEcf1SbmOY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmOgIcJ8C4pKpQ2s1uPew1mzWN5b8egwDGkdXHd
 q6kDAPoZn6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZjoCHAAKCRDBN2bmhouD
 14RHD/97iqUCmd+/m5xbNrWdeCNRTnpiBM/7B858xCTJ9NZ21Z+511GhAjTfglasiURr7dVtlEY
 DX2TAk/WsCkE+LiRRLwpSa61DvhwbUPUPzS8ACCMsuP9ol0hFdJeGBrqLiLFfcpxG2fNxJDEE7k
 aMyuiQOveIQGqtl25oREsxDO/tSzrYnrkKsv9w4y1D1qTTnttcJ1kj2S21B1J5i/s4+urXfFWNH
 vEEWa8+HQO0lZ3gG0AmsF/KyIf3S4bMr9BnIOjfVCAdOM0AZ+V0r06+JwtWLM7IQtttq5j1yRgR
 hcq5iN8bKo4uiQ+YZEozR9/7hlxkxrxMaFUMG+QR3PqAfDuB4Ra+uKY253yukq/UFjA2SN2J7jH
 Nuq1ZqtsVmeHP5WpAUAtsWvEudUHSn5EBM9lfmJ5v4NtMTkbAkorOB4c2EBWR5T6spWKef9zNPF
 mugo2RADZpNz7rloQpQkgktnSGHCAO9DnIyd/jk1iZgEeCXS/ymruAZ8Ave7zDhQbRvHho3xgDg
 rDy/wf/ztDUnYstNhQEgeaKoFQiRej8HVlUVKyWoCbL6p/kpbhr05aaxS/sNImzgAZKVF/za7Tk
 xA5dKkU8x0uhU75l34zhUh3uj8ePWn6GPltw30TgCTuzTE+qAswufzAzGNAayAeB9VuclLAtYNx
 UQ6b4+9KKmjCqnQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

X1E80100 CRD board comes with four speakers arranged as left front+back
and then right front+back.  Using default channel mapping causes front
right speaker to play left back stream.

Adjust the channel maps for frontend DAIs to fix stereo and four-channel
playback.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/qcom/x1e80100.c | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/x1e80100.c b/sound/soc/qcom/x1e80100.c
index c3c8bf7ffb5b..e90c68815b5c 100644
--- a/sound/soc/qcom/x1e80100.c
+++ b/sound/soc/qcom/x1e80100.c
@@ -12,6 +12,7 @@
 
 #include "common.h"
 #include "qdsp6/q6afe.h"
+#include "qdsp6/q6dsp-common.h"
 #include "sdw.h"
 
 struct x1e80100_snd_data {
@@ -74,7 +75,7 @@ static int x1e80100_snd_hw_params(struct snd_pcm_substream *substream,
 	return qcom_snd_sdw_hw_params(substream, params, &data->sruntime[cpu_dai->id]);
 }
 
-static int x1e80100_snd_prepare(struct snd_pcm_substream *substream)
+static int x1e80100_snd_be_prepare(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
@@ -96,12 +97,34 @@ static int x1e80100_snd_hw_free(struct snd_pcm_substream *substream)
 				    &data->stream_prepared[cpu_dai->id]);
 }
 
+static int x1e80100_snd_fe_prepare(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
+	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		const unsigned int rx_slot[4] = { PCM_CHANNEL_FL,
+						  PCM_CHANNEL_LB,
+						  PCM_CHANNEL_FR,
+						  PCM_CHANNEL_RB };
+
+		snd_soc_dai_set_channel_map(cpu_dai, 0, NULL, ARRAY_SIZE(rx_slot),
+					    rx_slot);
+	}
+
+	return 0;
+}
+
 static const struct snd_soc_ops x1e80100_be_ops = {
 	.startup = qcom_snd_sdw_startup,
 	.shutdown = x1e80100_snd_shutdown,
 	.hw_params = x1e80100_snd_hw_params,
 	.hw_free = x1e80100_snd_hw_free,
-	.prepare = x1e80100_snd_prepare,
+	.prepare = x1e80100_snd_be_prepare,
+};
+
+static const struct snd_soc_ops x1e80100_fe_ops = {
+	.prepare = x1e80100_snd_fe_prepare,
 };
 
 static void x1e80100_add_be_ops(struct snd_soc_card *card)
@@ -118,6 +141,15 @@ static void x1e80100_add_be_ops(struct snd_soc_card *card)
 	}
 }
 
+static int x1e80100_add_dai_link(struct snd_soc_card *card, struct snd_soc_dai_link *link)
+{
+	/* Add ops for Frontend DAIs coming from Topology */
+	if (link->dynamic && !link->no_pcm && !link->ops)
+		link->ops = &x1e80100_fe_ops;
+
+	return 0;
+}
+
 static int x1e80100_platform_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card;
@@ -135,6 +167,7 @@ static int x1e80100_platform_probe(struct platform_device *pdev)
 
 	card->owner = THIS_MODULE;
 	card->dev = dev;
+	card->add_dai_link = x1e80100_add_dai_link;
 	dev_set_drvdata(dev, card);
 	snd_soc_card_set_drvdata(card, data);
 

-- 
2.43.0


