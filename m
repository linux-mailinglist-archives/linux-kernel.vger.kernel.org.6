Return-Path: <linux-kernel+bounces-378027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA91D9ACA52
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 14:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25D1A1C20F71
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 12:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9241AC444;
	Wed, 23 Oct 2024 12:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DETkIdaO"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3ED1AB6C7
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 12:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729687320; cv=none; b=dZSTB34LXzUkJG+qA3UCi4XRfmYi/DoG/IWPsKFsl/c6fTKLMgBFt72Bn1kvD6Qrm3vBAYJ0PtueNaD7T0sf66OefE6uMmaJ275AeAwWAQBTCwfdjHErrQEiGZ7rqXqx0ysG/aM6AeMhtqzBkoJdIYaruA86DTo8YBptabn+tF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729687320; c=relaxed/simple;
	bh=r4xQBSHSzqBbjSO15B6LqQBSJLlq/rBG7/qkg8UtW2c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YQlLwcNXyrDGuinmOzgUPbTYjKN/LWIy3WVEUbfRd5Q//U/owZzocyLweszjl32Eet0oxaKKmgBmvJImc5uRAJs0sTZn2CYiBkhGYrbI94E0zBHaHZP9tetR0rR0jB+N3xGrIUmCPwQaARlrvcnYrZ28Wy8F+yTn4L3hVnwj4X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DETkIdaO; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4315dfa3e0bso8823265e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 05:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729687316; x=1730292116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OC1GUo6u6ogIaP+998OmJFrdwx6E7b3ebTutyLvUJYE=;
        b=DETkIdaOHdOPQEuktXy6mDkM4t6rPm96scJ0FnLLCYiqmZeuDG3qeGPhm8TPL5FVvk
         XjzMvN+DlHX0VxbvxAYojxbgPmurKPdI8G7xz2M7QtujsqsAWFz9DHsNzBlBB89Urt3r
         ueZMuVp3ouN9X9zPaxsfeMeNxpj1oWWuMzJQgiLbkW1ym841/1ncgwm+8Yy1xMAiE9wT
         hLF1EPgXbvdImxdjOzU7m6eKMUlVuLmphMFKlBr27Z9T3O6hFGgB37BmDF2tchFCtzJq
         qfsqtJYrtgRp5ti4r2K8LQyKyycfYoJG/T57FK02ONWL7jaKpNL/Bvh/NAdNZ6/b6Uw8
         RRZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729687316; x=1730292116;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OC1GUo6u6ogIaP+998OmJFrdwx6E7b3ebTutyLvUJYE=;
        b=pkB/q35ncJb/tblGYZpcDwM69koa2wNzwodTL1ynM35W9ATB3SIXG/ICjIQRgoqPOC
         fN9kkJltXQdEvFkx3PV+oInwXKcaRXzXSevYeM4dim3ZyUvuchBgB/El5PteWFBbbvDP
         uBzinfHmR9+ZXVA2g882tzUqMMLaRPS/z5bQuHOEWDR6x1sPkE0C1hVJpdl7T7R1lpAu
         FwDgro9k4wGcrUiAxK0/2hDIZ+2SSwIIilqx+TP/0GKUaimPBfBMVB5gaNXgJyphD6wX
         8vdr1Y9P4HGeZSBhTuuJdPeKzVTmX2NvskF44pR1dV4od9Ca3zSfvwZAI1e6uhX45uXF
         HaWw==
X-Forwarded-Encrypted: i=1; AJvYcCW8P9ivDyRrpUvEudjDQTo5SqU9d4TWx/nsBvOsax7dH++1egwvnsz+FEEYccBfUL7vC6ycsMkIyNIuC40=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx67IsM6kHGraDPxDBH+nbpD3ddQRnaldY1HCOUU8VZi+C4IT9O
	GTcbBMQuix//UpSJNTBqYh64tHahVqST3PpYizYJc9UGgn6IEp17ysag7qsXeD0=
X-Google-Smtp-Source: AGHT+IGOOLD010FpGoIXn//GRg/EMY8PWXk1Rdw1ltM3+wHFz9aINxy6HV8Thsw/0R78Sp9Fi09moA==
X-Received: by 2002:a05:600c:1d06:b0:42c:bfd6:9d2f with SMTP id 5b1f17b1804b1-43184133ef0mr9814505e9.1.1729687316420;
        Wed, 23 Oct 2024 05:41:56 -0700 (PDT)
Received: from krzk-bin.. ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186befc90sm15101675e9.26.2024.10.23.05.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 05:41:55 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	linux-arm-msm@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ASoC: qcom: x1e80100: Support boards with two speakers
Date: Wed, 23 Oct 2024 14:41:52 +0200
Message-ID: <20241023124152.130706-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some Qualcomm X1E laptops have only two speakers.  Regardless whether
this sound card driver is suitable for them (we could re-use one for
some older SoC), we should set reasonable channel map depending on the
number of channels, not always 4-speaker setup.

This change is necessary for bringing audio support on Lenovo Thinkpad
T14s with Qualcomm X1E78100 and only two speakers.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/qcom/x1e80100.c | 40 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/sound/soc/qcom/x1e80100.c b/sound/soc/qcom/x1e80100.c
index 898b5c26bf1e..8eb57fc12f0d 100644
--- a/sound/soc/qcom/x1e80100.c
+++ b/sound/soc/qcom/x1e80100.c
@@ -95,23 +95,53 @@ static int x1e80100_snd_hw_params(struct snd_pcm_substream *substream,
 	return qcom_snd_sdw_hw_params(substream, params, &data->sruntime[cpu_dai->id]);
 }
 
+static int x1e80100_snd_hw_map_channels(unsigned int *ch_map, int num)
+{
+	switch (num) {
+	case 1:
+		ch_map[0] = PCM_CHANNEL_FC;
+		break;
+	case 2:
+		ch_map[0] = PCM_CHANNEL_FL;
+		ch_map[1] = PCM_CHANNEL_FR;
+		break;
+	case 3:
+		ch_map[0] = PCM_CHANNEL_FL;
+		ch_map[1] = PCM_CHANNEL_FR;
+		ch_map[2] = PCM_CHANNEL_FC;
+		break;
+	case 4:
+		ch_map[0] = PCM_CHANNEL_FL;
+		ch_map[1] = PCM_CHANNEL_LB;
+		ch_map[2] = PCM_CHANNEL_FR;
+		ch_map[3] = PCM_CHANNEL_RB;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int x1e80100_snd_prepare(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
 	struct x1e80100_snd_data *data = snd_soc_card_get_drvdata(rtd->card);
 	struct sdw_stream_runtime *sruntime = data->sruntime[cpu_dai->id];
-	const unsigned int rx_slot[4] = { PCM_CHANNEL_FL,
-					  PCM_CHANNEL_LB,
-					  PCM_CHANNEL_FR,
-					  PCM_CHANNEL_RB };
+	unsigned int channels = substream->runtime->channels;
+	unsigned int rx_slot[4];
 	int ret;
 
 	switch (cpu_dai->id) {
 	case WSA_CODEC_DMA_RX_0:
 	case WSA_CODEC_DMA_RX_1:
+		ret = x1e80100_snd_hw_map_channels(rx_slot, channels);
+		if (ret)
+			return ret;
+
 		ret = snd_soc_dai_set_channel_map(cpu_dai, 0, NULL,
-						  ARRAY_SIZE(rx_slot), rx_slot);
+						  channels, rx_slot);
 		if (ret)
 			return ret;
 		break;
-- 
2.43.0


