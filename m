Return-Path: <linux-kernel+bounces-239432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FD5925FD0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 14:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFCAB287FBB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4468B178375;
	Wed,  3 Jul 2024 12:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mi4q4QbP"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FCB174EFF
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 12:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720008676; cv=none; b=GDb+mWMMUnKExfUfBqsVcFn3r13k9l6+d0Us+P9PCSlcSgLn/t1rC6rIODi2PqNEwqEmW1uh8PINXhXp3PsW9Q9UDGZa/QWO0YsW+ggTOvxDDWpnUfEBm4UCduS1LeT/q25NFrP1dKLRloIgK4j/5Tl1pl+1KZRJm/CPzLiUn/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720008676; c=relaxed/simple;
	bh=hcQM/u4gdKEirg5JUeG8TyWsInxszV0wEWN+duol+CY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dq0UKw9CnguBdatIgb6NKmROj/aK4NMtE7QVvf2pDGfI52uOsEpEiuGnFr5aWCUA7NwMI1UZ3OqzYtQD+4wI/mYxH1xMHaOHiKeLY/tQ75xJP7pdGkcr1i4f939v5G090kK8uf+yaz1AjmNodFxNcZ1T+FceHAbBKh151CLHQn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mi4q4QbP; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4256aee6d4fso32522385e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 05:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720008673; x=1720613473; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TvfHWDLawXK7UTQtN1jPqjdOr/fZ9HhxS6j/T8wlgb0=;
        b=mi4q4QbPZgLrl8yfIBksIq5MO+QZwUrk+2v5qqn5LVO8nBQ0Pa6g670jnh5cTJH8w6
         XUUJAUwL7vlkD9ZlPZUL6bJGemaViI40UuUVO88EBUcE4Fmu8ZVPR7BSbZGEWCI0Hm4N
         hzcTYntyCzveoUY7PXRESxmcZQQ3PlYe0KcIqAeaRLUJfLTJEsS3SXV+R1V2vjw3vYNr
         I9vcZ5FMxUgvftYRDSe1yX2/m05+0RdOr+ttBimaxb8U7xdD2xfgw2rC+Ck8TCUAbQeV
         2Mxv6kcJFlMXrz9mmSTYXhMmQr/f7ffASivOVpeNwIpV+YEUBgmbNweeoyuqM8pyWaOr
         3Xlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720008673; x=1720613473;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TvfHWDLawXK7UTQtN1jPqjdOr/fZ9HhxS6j/T8wlgb0=;
        b=wB936kInil7I+rkRizUHpuitgoG3iH9mX4inV8Gc+LJpOvPYQEM/YeRBDhWKnSwBsF
         qHHGoJ7YeOxFUYOOGRWcKKqNJ+0tDpBurYsGvD0Jn0jhH3NLvn5t+DLEBYzWIsjestZS
         SYr4eb6SAkMP1iEuOMT6KHPrOhF7U47pXrE4TMEAOB0Zt74+MAkmY9lR9QKjxh+GQUMg
         5an+0enyWQ+5+U6GdbWl7GIGtsjw1LLP0lWUfojguzrn6PP+OviZBeGa/C5GC+7AfnMv
         YseNTlP14xoKpMGyxOBcfo+UKy8+D/LZBSySLfCpWU95EOBGwIFREfeE4wq079J+840V
         ymQw==
X-Forwarded-Encrypted: i=1; AJvYcCVowzylG/xhcCNC9kg9C4aa4jeBIq92iqAjiWnb7bdSayA+VUj8NgjCIhfrpHJ59+wECJgfdN/+0dtcUAJpYZ00tH+jAL4eJT5MOIDO
X-Gm-Message-State: AOJu0YzLM4olxRBa++dUixWLcuUOtL42l16LHuoJdQP/nw73r8KG89F2
	mMsrR4o41Zl7ASSU5gg/hqo1kdr973+3jul3NLqwjV7pddEnjUiS0Yt+HRAY3lc=
X-Google-Smtp-Source: AGHT+IH/sDmBGQHkKlo6P8bbLVjWf52TOStaaHtlhq8jk1kOVYcLwRGZwRzl7cnPOdgKGkCKo6+RoQ==
X-Received: by 2002:adf:e24e:0:b0:366:ecc4:aa6e with SMTP id ffacd0b85a97d-3677569e9e7mr7912505f8f.4.1720008673463;
        Wed, 03 Jul 2024 05:11:13 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a10307bsm15716222f8f.94.2024.07.03.05.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 05:11:13 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 03 Jul 2024 14:10:57 +0200
Subject: [PATCH 03/11] ASoC: codecs: wcd9335: Simplify with cleanup.h
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240703-asoc-cleanup-h-v1-3-71219dfd0aef@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2386;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=hcQM/u4gdKEirg5JUeG8TyWsInxszV0wEWN+duol+CY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmhT/TOLcCIz6vRLHZuKKP8eFZ3aNZ0lSBNsBPR
 gPoj0LQArmJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZoU/0wAKCRDBN2bmhouD
 15lDD/90zgr9CUgmwUMkXnQnamYu6m4EoSre0Pt416O1Wakpe2GuaQQXnXtSAFvkzmCN10TFJZS
 5mtDly3oBv29VLaL69b+0QdddwCyIaiHwr8ZHtoQyRQQbJ96V5mnVIzjvtdwcLji6ImP6o5nqw1
 7wXJnm8S6bE9dTMtmAIVqk7VZsp3HYcC57MFq8tHaNaCIszhbI3ac3d06FT+mEUjh/DK1zHBXrp
 YlAvQWzutJrs63xmHSN5017bL6GJ8WTFqfjN/1zVIZu5LjANy1Q6Pjy14KFkr3BMiAlVOCsI7/v
 UixaWOhI2XyG3sVrfnsI9OC2Tn5/90qd+qsG6yW9ajxs1BQLdfmH/sbF3dt+yH8nzH1uMDrIEuK
 9JaG3EaZj6+sMovJfP7FOkKSZQp2Nh4BGcw1OEuI1hzfOQAUdq4JQ/7aAGuWb5NZ5LK7Mel7Ixd
 FHdoYh5nEFncyG6eylOXFPv18YVRccUV0jLdRQR8qiTs/pdNlpdkMnER5LtZhphvqXfFOZJfiNW
 DxCSuGc/e7LCeRnXNj9bIxhaLPxD6IbRm+gny4Yvj6y3/yOVe21+yLfYFxGNvJlJ+4lQYThBc6g
 0ul+8ij1wZ4eAoA6XHNKr3O3LN6k7/KbGdnaduYaVQyTS5PESikZXMDj/ZbKqwSmli2SPa9+JwI
 QXVLp6ds12r0Jfg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Allocate the memory with scoped/cleanup.h to reduce error handling (less
error paths) and make the code a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/wcd9335.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
index 1a20131e2a60..373a31ddccb2 100644
--- a/sound/soc/codecs/wcd9335.c
+++ b/sound/soc/codecs/wcd9335.c
@@ -5,6 +5,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
+#include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/wait.h>
 #include <linux/bitops.h>
@@ -2714,25 +2715,23 @@ static int wcd9335_codec_enable_dec(struct snd_soc_dapm_widget *w,
 	struct snd_soc_component *comp = snd_soc_dapm_to_component(w->dapm);
 	unsigned int decimator;
 	char *dec_adc_mux_name = NULL;
-	char *widget_name = NULL;
-	char *wname;
+	char *widget_name;
 	int ret = 0, amic_n;
 	u16 tx_vol_ctl_reg, pwr_level_reg = 0, dec_cfg_reg, hpf_gate_reg;
 	u16 tx_gain_ctl_reg;
 	char *dec;
 	u8 hpf_coff_freq;
 
-	widget_name = kmemdup_nul(w->name, 15, GFP_KERNEL);
-	if (!widget_name)
+	char *wname __free(kfree) = kmemdup_nul(w->name, 15, GFP_KERNEL);
+	if (!wname)
 		return -ENOMEM;
 
-	wname = widget_name;
+	widget_name = wname;
 	dec_adc_mux_name = strsep(&widget_name, " ");
 	if (!dec_adc_mux_name) {
 		dev_err(comp->dev, "%s: Invalid decimator = %s\n",
 			__func__, w->name);
-		ret =  -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 	dec_adc_mux_name = widget_name;
 
@@ -2740,16 +2739,14 @@ static int wcd9335_codec_enable_dec(struct snd_soc_dapm_widget *w,
 	if (!dec) {
 		dev_err(comp->dev, "%s: decimator index not found\n",
 			__func__);
-		ret =  -EINVAL;
-		goto out;
+		return  -EINVAL;
 	}
 
 	ret = kstrtouint(dec, 10, &decimator);
 	if (ret < 0) {
 		dev_err(comp->dev, "%s: Invalid decimator = %s\n",
 			__func__, wname);
-		ret =  -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 
 	tx_vol_ctl_reg = WCD9335_CDC_TX0_TX_PATH_CTL + 16 * decimator;
@@ -2836,8 +2833,7 @@ static int wcd9335_codec_enable_dec(struct snd_soc_dapm_widget *w,
 		snd_soc_component_update_bits(comp, tx_vol_ctl_reg, 0x10, 0x00);
 		break;
 	}
-out:
-	kfree(wname);
+
 	return ret;
 }
 

-- 
2.43.0


