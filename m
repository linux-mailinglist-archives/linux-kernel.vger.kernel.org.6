Return-Path: <linux-kernel+bounces-262097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2732E93C0B6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 13:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CDA01F21BCE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 11:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CD1199EB1;
	Thu, 25 Jul 2024 11:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KLIVjdvU"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6132E1993A3
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 11:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721906643; cv=none; b=cpfQPzx2SH2weZXS368/vIGtSiLe/aDq/gepTYNhohE2QnTsi+jsoZkqhQnbJCTNjDIs13tdjUMIHdc95ZSJNS7NCfnUkseiIQdHmuflpvznap1eNfGxUX+02kpyS0Mms9dbcSOjrTSr92bLvn9WEle2AZOJDjvasP7ZxENYt4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721906643; c=relaxed/simple;
	bh=wCaY3kZbkwPEwo1WVvpupNrkPaJVQt2eCab1H4lT8xs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HgpmRjgITscS5f8SwV9ID7GWj2L6wS29Gt2pj+hfkQJrXGKFRwY5Y5WUR19Vlkme/xy3PwdF9xIfDNHYMF4QAw1A+isFRLprInC+x6GBFj5pYWc8NxwMvX6cPy/rgh263zBLxwuz+cyPhSLzRfZP05LCogsoc1BcKKfvnp04WTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KLIVjdvU; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-428035c0bb2so4787705e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 04:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721906640; x=1722511440; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xv4gNohsSEkyCVH7/4Ky3TaKWmsSwASlKN9kZ+B7LDs=;
        b=KLIVjdvUsmoG/FObLzxC5Hxcya+Q1olKP40UvNPNQwIQNNIyP3tcaS9BxQF7/+MdC/
         PLS/y+JVSFF1lagxu+e8wE7dSrPSaygi2Bg4sm1s/+m4ktbqgNnOlLy3iGvSUnbGrGbQ
         1Z38vYhauq5lbDgp/+W76BB2Xslw25RV7buNuFSnxBfANoePXgcX1FF9ZOFKklvdCOSL
         AlxFCJYYZ6z8XAMrpy7PAzw3jfrvXY51IHLGyjollCtNfVFUwZI6NaaP47swcXsC1DMk
         WM+Owcx1jgxIf18G6DZDHUUD1lsMtt3uLW+vd+7Uf2aLpHAozH1KfJ/1m5Bp0uAwJ40T
         SEGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721906640; x=1722511440;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xv4gNohsSEkyCVH7/4Ky3TaKWmsSwASlKN9kZ+B7LDs=;
        b=eDjJiZKWNIJbzZXFo8c1Ba8F8j5mfsGd6dwQh9lcW2XObBX4Men0iM/kzroQoTwHWu
         20FGoJxx43Xr4A5e9ydGn+GMXZCGpeWVpVak/Gunu7x5haGF2QoVYnQpN1lApPCTBru8
         mV61+qs78GnQrLNwN3BVADCDeTbeauJh5A4DntQEAi5QvZdyOoB/SL7k6WsXdRaPoDK2
         ZoqX2vZpfyZp8oxFoDGpNU4W756Xh4GvTDcYmABFhjodpeHnnHNmM7/i5zX/AsGSVoD+
         JX0d2eEamtjYrsMKPQoGgDXkCVIk1UPrO650UjKIAcyxlgcyGvmUyuu1SzKGJzpFfpKn
         Gk0w==
X-Forwarded-Encrypted: i=1; AJvYcCV2XfvVuebYAv7Z3s/elmSZoAMR3iVZUg+q6Symskliq9pRtwT65GczrfVt9Bw6hwoWw1h4GyknvldnyI2phEatc41MGEErTYfNiWg7
X-Gm-Message-State: AOJu0YyU7qSVkT3qeo2IJVx3f7eB3CAiCbwnG9LCCkUKnP3VMX1EG0fG
	E7aLtus9UmEPkH8s7LYzEgGvdg8rTbklvucKkqKzdXfCvHK8t5JfJRKTulfWt0U=
X-Google-Smtp-Source: AGHT+IGm/CIUyj3+IUxZZKmv3H0osV1MgXdLb9MIQ274YozSOERMoI7OrS7UBo8OSd0d2d84LnemvA==
X-Received: by 2002:a05:6000:104b:b0:368:3ac6:1fff with SMTP id ffacd0b85a97d-36b31b4e832mr1771595f8f.20.1721906639826;
        Thu, 25 Jul 2024 04:23:59 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367e072asm1823607f8f.42.2024.07.25.04.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 04:23:59 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 25 Jul 2024 13:23:46 +0200
Subject: [PATCH 4/7] ASoC: codecs: wcd938x: Drop unused defines and enums
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240725-asoc-wsa88xx-port-arrays-v1-4-80a03f440c72@linaro.org>
References: <20240725-asoc-wsa88xx-port-arrays-v1-0-80a03f440c72@linaro.org>
In-Reply-To: <20240725-asoc-wsa88xx-port-arrays-v1-0-80a03f440c72@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1947;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=wCaY3kZbkwPEwo1WVvpupNrkPaJVQt2eCab1H4lT8xs=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmojXGE1G/y/P+dD388yi2q67mlhwNSH55Ia5ue
 J5SAo6TxlGJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZqI1xgAKCRDBN2bmhouD
 1+PMD/sFQvp0fm4/dgfL44ISNSNtPIJ7RtxpANkZKBEwpAWzGQSQkefWW9CsZA8BDIlWUUYhlZV
 yuDp+BuM0J2cRJuiIxoe+h4pVvk9ijZhZ/HUbJl8Zn96fIj4iBwTgKDAj1v9Gojlm715UiO09Ym
 79VxPoA3GGiUnqFApEknQU3e8IhPNT1ggN5Qtaa6BN3E3qlXDhhNzCek3rUyw7np4xZTKdXLI4P
 38TsivcJnOC3YyhSfTrxlz+XISWJUQMgcVkU3SgZ6+zGNIHvZmygrsWJdfnLZMhll0IvJRjjLFC
 9TtRqYeSTfudmgY8bIXPpD1+At+hnKzVqm+7xF6dTldfCiyxr8xXi7nKNeFqEPm1dTbM7uRugH9
 ewGgaUabGqqqMuw6OvuMPWrxS/r3AVHxrJJCfYZyFLT49oeEhMHIqQqnHT6iaimZ2BFFOSOCL7S
 dThi1bR5uh+J0V72HQKBDyznrkN01sUzgGCLIcEu+PxvBoE7laxHY0sB1anxQ8MbtL1YR49UgIc
 PYBDYsTvnJnVZV1aI+w+5OKqcHoHIALGrqdwJ7hAGtZEgCL4uMzjnoDZmHTzjKZx9HHvQU0aJCn
 12OD7k++dFbbnL+orZmmO20nLtyBxYreAA8WH5diGk2yG40iZTH2TT7MhaS9kCme+y4QB+OljfA
 +erd/NoxFy5UjOw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Drop defines and enums not used in the driver.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/wcd938x.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index 12b32d5dc580..aa92f1bfc921 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -29,7 +29,6 @@
 #define WCD938X_MAX_SUPPLY		(4)
 #define WCD938X_MBHC_MAX_BUTTONS	(8)
 #define TX_ADC_MAX			(4)
-#define WCD938X_TX_MAX_SWR_PORTS	(5)
 
 #define WCD938X_RATES_MASK (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |\
 			    SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_48000 |\
@@ -39,8 +38,6 @@
 				 SNDRV_PCM_RATE_176400)
 #define WCD938X_FORMATS_S16_S24_LE (SNDRV_PCM_FMTBIT_S16_LE | \
 				    SNDRV_PCM_FMTBIT_S24_LE)
-/* Convert from vout ctl to micbias voltage in mV */
-#define  WCD_VOUT_CTL_TO_MICB(v)	(1000 + v * 50)
 #define SWR_CLK_RATE_0P6MHZ		(600000)
 #define SWR_CLK_RATE_1P2MHZ		(1200000)
 #define SWR_CLK_RATE_2P4MHZ		(2400000)
@@ -48,8 +45,6 @@
 #define SWR_CLK_RATE_9P6MHZ		(9600000)
 #define SWR_CLK_RATE_11P2896MHZ		(1128960)
 
-#define WCD938X_DRV_NAME "wcd938x_codec"
-#define WCD938X_VERSION_1_0		(1)
 #define EAR_RX_PATH_AUX			(1)
 
 #define ADC_MODE_VAL_HIFI		0x01
@@ -72,7 +67,6 @@
 /* Z value compared in milliOhm */
 #define WCD938X_MBHC_IS_SECOND_RAMP_REQUIRED(z) ((z > 400000) || (z < 32000))
 #define WCD938X_MBHC_ZDET_CONST         (86 * 16384)
-#define WCD938X_MBHC_MOISTURE_RREF      R_24_KOHM
 #define WCD_MBHC_HS_V_MAX           1600
 
 #define WCD938X_EAR_PA_GAIN_TLV(xname, reg, shift, max, invert, tlv_array) \
@@ -89,18 +83,6 @@ enum {
 	WCD9385 = 5,
 };
 
-enum {
-	TX_HDR12 = 0,
-	TX_HDR34,
-	TX_HDR_MAX,
-};
-
-enum {
-	WCD_RX1,
-	WCD_RX2,
-	WCD_RX3
-};
-
 enum {
 	/* INTR_CTRL_INT_MASK_0 */
 	WCD938X_IRQ_MBHC_BUTTON_PRESS_DET = 0,

-- 
2.43.0


