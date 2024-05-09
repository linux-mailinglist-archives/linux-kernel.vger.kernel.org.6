Return-Path: <linux-kernel+bounces-174216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E588C0BBE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 08:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3D0C284873
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 06:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE13A637;
	Thu,  9 May 2024 06:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JpbWUyvA"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A69F13C801
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 06:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715237529; cv=none; b=tym/4s/PiodtH0YUmaj5jjVCS0Qz5vcMn3AknYjimn2cZOQltknULxullPRA3Lp7pXfUgvACh0Hc5n5zwYDA09m1PKZs0xWxeI+yCp20J46pA03wmrYYFZLXWiVzXInUmc3eVjuROoBnpduLJfZF0yiN/9M3FEYO3h+k1gO2Sek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715237529; c=relaxed/simple;
	bh=d+whTvaCUFBkWJxrgaqvE8kSJoAykKqRo1KOv90DlbU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ldb00JmWh7plEsF3CXBPEPXzrs2ryKLUdPkHAihKm5/bsakGR54txCi52lJABcwuYUpVBUwp05kq8tUbl5Eef8lzJ8HuqyJ9WaNjNjQUneX7/o0M1qmTQzTpfohTFoM3siO3AoLOYpswJFmt8odBbPQThJClCaxC2rhEyhnULoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JpbWUyvA; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-573137ba8d7so3043421a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 23:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715237526; x=1715842326; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0J7Cge03mHzKytqfe46M5SWmiJDYT6L/0iD5WUZ2XNk=;
        b=JpbWUyvAVP7zWnwVMZINWZu12kWmwNhM0vpNcctev5gTNV6RSj/eLQco4JbOD3Fl4r
         RNhBIRbgi4KEV6hQc8Dc5of8g5uFNovXn1iP/Pr77wIthXimK0GzpEBQTa8y+o+3vWdv
         papBOMW58zeVG0C3xBuqXqQ8BtayMc74IQHDPONvHrmIN4odfsjtZdawHTdrM2FrdTYB
         s3pZR6dv7eQ2SwVPO9MTCoI1adHcYRAl0YL8E92T59dMJu8vIuD0hrsY/MWmyFBbHIrJ
         D2qLFPTBxuo5rlTxGXF6S8YkVlP0VqHoALI/RKOhJmrW68JPHRkmnDHi5VJOsD7hgcMy
         wyWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715237526; x=1715842326;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0J7Cge03mHzKytqfe46M5SWmiJDYT6L/0iD5WUZ2XNk=;
        b=V2c85I/NMWs+x6dAZMt20xOS/eHJxTojb2CcK/QNLCQ3FYg4rR0mmwZsLICjAg5Lp7
         tQXR4JLLVMFv1uAwyMSzBWKYodY4lRSnkKGXI4bl3e6VLgR//L4ap+KpuoBasyiIl+6O
         6dP0IgTV2QqbEKsOzyKRJTWUmEeavRdlJPp/qxDMwgcZJrhtYUOxmrseLn06IbrkV9Xt
         j59nT9JCoDeHqXay90Fs7/yQnxvy/uNnvC11+fnB8SGWKqi0jXB7gcx6NuC4ssm2bKmT
         kVNW+Tb0/Z2uN8cdvq6ptUvbMfZmGRInyPqowCAU/0ufV6KPqdphqQAGQGhfdQ74i3fr
         93/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWFixaSuXWYjImHF8uyDTTzfFwOGHfoPOem0Vcl2pPZKyrcCswE7dfuNSoKqs0IQ1StQWkSCHMOhYkNeequ2WhaARLWljx1cowgkk3V
X-Gm-Message-State: AOJu0Yy56vEUb69jhiEz40M2tq0s76/2Sfcwm4+QeIXF8Z/WRgj02QYE
	ZbrmQSHasRby91PEDo/93E6dAnUdxdFJh/YUh1fTe4gkNNK5MyZ9ZjF+cJHjMHo=
X-Google-Smtp-Source: AGHT+IH4IKNh6xpMCbzmAZuvEhTaQU2/vdq+j0ULoUFdsjxmj+MDwNstEIfCxKnQbGOb9UNNxYbSYw==
X-Received: by 2002:a17:906:1d59:b0:a59:bf27:5f2e with SMTP id a640c23a62f3a-a5a11682723mr138739566b.20.1715237526603;
        Wed, 08 May 2024 23:52:06 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c81b4sm40730966b.113.2024.05.08.23.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 23:52:06 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 09 May 2024 08:51:53 +0200
Subject: [PATCH v3 2/4] ASoC: qcom: q6apm-lpass-dais: Implement proper
 channel mapping
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240509-asoc-x1e80100-4-channel-mapping-v3-2-6f874552d7b2@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2494;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=d+whTvaCUFBkWJxrgaqvE8kSJoAykKqRo1KOv90DlbU=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmPHKObjbPYBWnxiwlH8jsOSlJbKFmyvJBSfmlT
 eN8kByPWESJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZjxyjgAKCRDBN2bmhouD
 18JbD/9TSwfYyfYQp7SbyFFtB/5vWzBB/5ob3Y49B4bnnmlY5PltbLl93/4+Yo1P7bJxbIEldpF
 w8rMSBJ3btQPJh/NCLQ3Q0+smAbIGO6JXLsSc5FqeZOz+wWRCkw4DCWOkSvDsNnFBsYM+JKe8e0
 FDwkrk/jt42QYhs9hq+Hga75z9QhSPDU7q/6at15xDiHzWTfNik8p3omeqXPPmJPe2YADmunJnV
 +h1LszPO9ae3mYoMXWTNVS48xHMAXZt0uDZcVXGTjB9R0Qk7/pBM6vSBufclDHu6VHBVGvAxe5O
 oSGbc+LyG1d+cqETUS8wmQMwcATzOF8VV061XMZ3nzA3x9HzvRg/+Mc+0SnlVmHbps+RqfHfGEh
 csSEq3Mu7t7Q+udgVovepeUAdgNRar7Lkz/AGPEsZ8DGtwJJedYTlLqtBqJrf/UYL+SYVHJfNAl
 KFOMFaUdDXtPmKaelga4R7Xb6xYbBdJWL4MNtw9LTbAyejDa6lJfHPt7Pz5FxV/YQYwIdDdoa0Q
 LD7BLTTFSHNZFsBoi/h1Bon/WIDdjRqYJfjds+7DT9fGqvO1ifHLM2Q57Vqu7fyUfgCcXMwjt2F
 1xPzwJbvAOGt+AiopgDaCB3s8DyqvXTUH1r1zed9B8bpSRrvlCNBzC/beCkYB0Q+mA0py9InfEZ
 jtI6YUTw1yQnUiw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The set_channel_map() implementation in q6apm-lpass-dais driver was
copying older pre-Audioreach code from q6afe-dai driver, but not really
using it.  The code sets active channel mask based on passed channel
mapping, but Audioreach code does not use that mask ever.  Audioreach
module configuration does have on the other hand proper channel mapping
field, which should supersed that active channel mask.

Drop the unused active channel mask and implement proper mapping of
channels in q6apm-lpass-dais driver.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Entirely replaced - now channel mapping is implemented in
   q6apm-lpass-dais.
---
 sound/soc/qcom/qdsp6/audioreach.h       |  1 -
 sound/soc/qcom/qdsp6/q6apm-lpass-dais.c | 10 +++++-----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/audioreach.h b/sound/soc/qcom/qdsp6/audioreach.h
index 2c82917b7162..eb9306280988 100644
--- a/sound/soc/qcom/qdsp6/audioreach.h
+++ b/sound/soc/qcom/qdsp6/audioreach.h
@@ -755,7 +755,6 @@ struct audioreach_module_config {
 
 	u16	data_format;
 	u16	num_channels;
-	u16	active_channels_mask;
 	u16	dp_idx;
 	u32	channel_allocation;
 	u32	sd_line_mask;
diff --git a/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c b/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
index 6bfbb52345e1..a4ad1d0e6abd 100644
--- a/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
+++ b/sound/soc/qcom/qdsp6/q6apm-lpass-dais.c
@@ -33,7 +33,7 @@ static int q6dma_set_channel_map(struct snd_soc_dai *dai,
 
 	struct q6apm_lpass_dai_data *dai_data = dev_get_drvdata(dai->dev);
 	struct audioreach_module_config *cfg = &dai_data->module_config[dai->id];
-	int ch_mask;
+	int i;
 
 	switch (dai->id) {
 	case WSA_CODEC_DMA_TX_0:
@@ -58,7 +58,8 @@ static int q6dma_set_channel_map(struct snd_soc_dai *dai,
 				tx_num);
 			return -EINVAL;
 		}
-		ch_mask = *tx_ch_mask;
+		for (i = 0; i < tx_num; i++)
+			cfg->channel_map[i] = tx_ch_mask[i];
 
 		break;
 	case WSA_CODEC_DMA_RX_0:
@@ -81,7 +82,8 @@ static int q6dma_set_channel_map(struct snd_soc_dai *dai,
 				rx_num);
 			return -EINVAL;
 		}
-		ch_mask = *rx_ch_mask;
+		for (i = 0; i < rx_num; i++)
+			cfg->channel_map[i] = rx_ch_mask[i];
 
 		break;
 	default:
@@ -90,8 +92,6 @@ static int q6dma_set_channel_map(struct snd_soc_dai *dai,
 		return -EINVAL;
 	}
 
-	cfg->active_channels_mask = ch_mask;
-
 	return 0;
 }
 

-- 
2.43.0


