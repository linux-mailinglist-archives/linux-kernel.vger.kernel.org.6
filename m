Return-Path: <linux-kernel+bounces-239431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCA4926003
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 14:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BEEFB2CA0B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED81D176AAF;
	Wed,  3 Jul 2024 12:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yinf8q62"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7784C172798
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 12:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720008675; cv=none; b=S+zwrsfY9M3etnT243es/zmUxEpVff5Fh2wfEk+RMRjbYi//Slg6+lmaHfDahxw9/y2moGYGCGe6RX+a7FbktvM8aKUzl/Mnxjja+DhfDyFLtxArOoDHDDsW2hquSI5L5Ne4Ccm7c0CA6MLQA7hcU6IDBvMvw7eUi6OUxuZW28c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720008675; c=relaxed/simple;
	bh=zkBYXA5XhH4F6q1m9UDysUTPImTnL2Gru3YtQza5a+s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X1uJizG1o4U8eHQofFtIeBjiF1P6qm+xL0N5ARE1wWGD5X8Dmx6tn33Ivv4zexbZQN1+7kK9xdKQEdBip4yjZvuzrj+RU9HpLncJYd1ZWHBpG47na0MnD5Y9K19vQrIzembpDzY9RYEhQ//SYM1N4wIzOFnFs2wKoxhz53vPTMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yinf8q62; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-36703b0f914so404687f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 05:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720008671; x=1720613471; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7cLxowQxGXKyItHO9t5LQNge45csaHkg4VU8jx6Qm+I=;
        b=yinf8q62WNkfCKrJA8xgleqMQO7qSsl23P729JNkKfm3ERJdcoAKP8/eDe3qt/j98s
         Z7kqV9rqyGgAbEUxIG9338sx/rRtkS4THO1ffdHRN0wAyD/KAfLpGW9Y9y6Noui2BrLN
         U1vV/WDI+GnAkVdg9pJrFJQgARnMH3a4uvN97045rGM8WYaz3jbJX1S15l91bIauI817
         mnelTHbYU8AcO/mEwBZSq6iI7xYHnoTZ00sQEdalq5W/dJPOVa7H0H5QpTv/hcPLDPnU
         ATWv6BG1I0AEG4NPX91V+zQbzdqsHUiJZuaxQNu2xJ3BGoXUF2s/3HLZSMJRuS3XltVB
         7wuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720008671; x=1720613471;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7cLxowQxGXKyItHO9t5LQNge45csaHkg4VU8jx6Qm+I=;
        b=alblbETn1p9YDBpCp95Zs5TVb4qh1gzITVK89N1KHbbFmClj3FBc9sc5++zNaWIsTk
         6/28BFgLvbhUgWL01rOn73DX4vtzDdcpJjfc0IAIdOiC+MvuQgZfbNSwOMs/j6Ap/+Qk
         2fmUhSqmUv8xGKaOd8Ld2TNutQ0kBkj/0Ta7Psy7SxpLLyZwBoV27iuYs6ywDJ8qDMYm
         GA2s9pw4TsBe1eV6Bc3qTmokSCUik8PmKWJoZP4YgYI4/KOFN802YanPBoMsOOPfPN9U
         V1Dqlf3VodLBImVYZhV6N+XLMLX0+hPpO+39xuF8kS/OPfNc9nVyFkRBgnqVjP1sp62/
         3EcA==
X-Forwarded-Encrypted: i=1; AJvYcCUcfpZgMa/4MYEofLmpHrfiRmaQpTseOq4WzlNcIbH15Sq3i+v3vtvaKd55Yd71MQ/r+1Sd//cmTl5KEAs8sK4n4bG3pDkHX9kExL+3
X-Gm-Message-State: AOJu0YyOlkULE9rl9mylHSMdkwwCUjDz5/h4hkx9tPBxznynJ53j5b2D
	xa7rdA90DoOHUTSL2606j6JZKjgeN+5/Bi2kcm1yc2strW9PJFo5FeirHKWuVFY=
X-Google-Smtp-Source: AGHT+IFy7XIwYIBv75NcGjjGCl0VS2oKdh8CqLT1sJCeuF/ePWgLta3XoHjrEoA8051q0A7kko4l1Q==
X-Received: by 2002:adf:f652:0:b0:363:337a:3e0 with SMTP id ffacd0b85a97d-36794780b27mr1367398f8f.1.1720008670720;
        Wed, 03 Jul 2024 05:11:10 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a10307bsm15716222f8f.94.2024.07.03.05.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 05:11:10 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 03 Jul 2024 14:10:55 +0200
Subject: [PATCH 01/11] ASoC: codecs: audio-iio-aux: Simplify
 audio_iio_aux_add_dapms() with cleanup.h
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240703-asoc-cleanup-h-v1-1-71219dfd0aef@linaro.org>
References: <20240703-asoc-cleanup-h-v1-0-71219dfd0aef@linaro.org>
In-Reply-To: <20240703-asoc-cleanup-h-v1-0-71219dfd0aef@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2812;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=zkBYXA5XhH4F6q1m9UDysUTPImTnL2Gru3YtQza5a+s=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmhT/SBRZL/pAdnmTHzMWcEt1sae0bOVf+MOlLi
 9Iouwdrzt+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZoU/0gAKCRDBN2bmhouD
 1++xD/4smEI7/Q/xqQ8kHg3Br1em0PyUgtV32GF4yvl2OjiJmfHfqwc4MC8tYzguMEV3m9v143t
 3is1DhFHdotHjyQMMJiMG+/b3egvgKx8MxxKLDTGJ3MbXRecLSlQAaMuSCGeuLk4bCEXAZtN2nZ
 59l6mosBbXKPDZGIBe3M+soiCM03Ydl01cJl8dSK5suDjwRpkMhb0+JXQjOl4yk2ZO0u8RmvM0j
 uTtxKpGljxGv78qEXDf1jblZH1uShAGNoK1Ox0ZKWxrhVpaG14Ytg1DC66Mpd7oomSWnyWBt1wU
 EshhBKabPnUlVVJObbJ1XFzGZURbnFu/lUXJgmBgaxhNczlYsv9/5T60tarIxLoFEClMrdN5NF4
 7an704jrG2hU0kQtKZznWsT3bxDivQfnUj/7hEgnVcadq4eChOBHgZKl886/hgKB4b7l25UUdxr
 7Zw7a1u0wlt1n9SPZTdlqdQwGj/1eL8hAkZkxLW54Dn6o59EUy415ArhoHSaawTLZFbER5UtXSs
 JrKvhfVNnjlmMmOGlnXUwCWRTfLqf9HBuynCCUJsjfA4B6sMDo0lV+P5grGPlQlghYxPgiaUAzU
 H96CRf99qS+tBY6o3K4/0HEsWzv1FLK3oz/6DmIkUKweb/sR9xpbL8JxcMRwZsi762H3cuL7vTE
 RVySwVK/E7N7Ziw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Allocate the memory with scoped/cleanup.h in audio_iio_aux_add_dapms()
to reduce error handling (less error paths) and make the code a bit
simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/audio-iio-aux.c | 36 +++++++++++-------------------------
 1 file changed, 11 insertions(+), 25 deletions(-)

diff --git a/sound/soc/codecs/audio-iio-aux.c b/sound/soc/codecs/audio-iio-aux.c
index 1e8e1effc2af..3969ee45f41e 100644
--- a/sound/soc/codecs/audio-iio-aux.c
+++ b/sound/soc/codecs/audio-iio-aux.c
@@ -6,6 +6,7 @@
 //
 // Author: Herve Codina <herve.codina@bootlin.com>
 
+#include <linux/cleanup.h>
 #include <linux/iio/consumer.h>
 #include <linux/minmax.h>
 #include <linux/mod_devicetable.h>
@@ -131,33 +132,27 @@ static int audio_iio_aux_add_dapms(struct snd_soc_component *component,
 				   struct audio_iio_aux_chan *chan)
 {
 	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
-	char *output_name;
-	char *input_name;
-	char *pga_name;
 	int ret;
 
-	input_name = kasprintf(GFP_KERNEL, "%s IN", chan->name);
+	/* Allocated names are not needed afterwards (duplicated in ASoC internals) */
+	char *input_name __free(kfree) = kasprintf(GFP_KERNEL, "%s IN", chan->name);
 	if (!input_name)
 		return -ENOMEM;
 
-	output_name = kasprintf(GFP_KERNEL, "%s OUT", chan->name);
-	if (!output_name) {
-		ret = -ENOMEM;
-		goto out_free_input_name;
-	}
+	char *output_name __free(kfree) = kasprintf(GFP_KERNEL, "%s OUT", chan->name);
+	if (!output_name)
+		return -ENOMEM;
 
-	pga_name = kasprintf(GFP_KERNEL, "%s PGA", chan->name);
-	if (!pga_name) {
-		ret = -ENOMEM;
-		goto out_free_output_name;
-	}
+	char *pga_name __free(kfree) = kasprintf(GFP_KERNEL, "%s PGA", chan->name);
+	if (!pga_name)
+		return -ENOMEM;
 
 	widgets[0] = SND_SOC_DAPM_INPUT(input_name);
 	widgets[1] = SND_SOC_DAPM_OUTPUT(output_name);
 	widgets[2] = SND_SOC_DAPM_PGA(pga_name, SND_SOC_NOPM, 0, 0, NULL, 0);
 	ret = snd_soc_dapm_new_controls(dapm, widgets, 3);
 	if (ret)
-		goto out_free_pga_name;
+		return ret;
 
 	routes[0].sink = pga_name;
 	routes[0].control = NULL;
@@ -165,17 +160,8 @@ static int audio_iio_aux_add_dapms(struct snd_soc_component *component,
 	routes[1].sink = output_name;
 	routes[1].control = NULL;
 	routes[1].source = pga_name;
-	ret = snd_soc_dapm_add_routes(dapm, routes, 2);
 
-	/* Allocated names are no more needed (duplicated in ASoC internals) */
-
-out_free_pga_name:
-	kfree(pga_name);
-out_free_output_name:
-	kfree(output_name);
-out_free_input_name:
-	kfree(input_name);
-	return ret;
+	return snd_soc_dapm_add_routes(dapm, routes, 2);
 }
 
 static int audio_iio_aux_component_probe(struct snd_soc_component *component)

-- 
2.43.0


