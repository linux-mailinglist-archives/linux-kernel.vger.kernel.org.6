Return-Path: <linux-kernel+bounces-437430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CC69E931D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 226011885F43
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE282221DB3;
	Mon,  9 Dec 2024 12:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ee0eaGBH"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BE82163B6
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 12:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733745645; cv=none; b=d3Rlzw2YjmE/X2MhH9VyTU3r+PDuJaPnaIW//0yc/ELrh1xRVcGJD9aMBSYkjtLaSzANGtHWrQSXzdvfWNCo3yUEsFjIi24SC/g/lyBQ16gTRVP/Cresmxso8++9ZTZKdn2maMNJxoqIaXnLpVTC0cHoeTyayaMwDvrELTM9Q1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733745645; c=relaxed/simple;
	bh=AfvDk3kCBindu1M/SPA1g+/8ocBf4bQNvfgLlw3/usE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qeMcB7/11kRr6QoUvCzrk1IqzeGGCGZslrzyyROUH/yqLn38h9OHW5Dl3vxa7gJiL5WLMRXpyCI5VMl+ELyM26KJiLGOmMXJ8vQbVAvKGg7csC4SsimTl6QvK08st2+tHcj9JLber6QOh4/59uGy0jxzd20HINURdo7GpwztQfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ee0eaGBH; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aa6954ec439so4417666b.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 04:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733745641; x=1734350441; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EglX5AVeuOK1iJau5AtpYy/rgxr+Cdktyzw1epur3aY=;
        b=Ee0eaGBHKL2LSQknTU0PLicajGKmvbA+96cV1pZ1oZUJ96ok9gik74+kUB444bCpBp
         JsuSjSHu10T/xFO64cttn4v8MdGbjzxZkRS2dvTgUSTGR4phH88cg6jl968wlO+R5EVR
         0YPJ8CvvgkSLEK68JJfNGt65QC9Xo2Dj5ZG+06VF2GDK1FCNENo/GxehBjuZLq0NaJv/
         /9CAtrIvVEgu5aLgp65OA3WJjSFCiiVljoCUYrpKhFJFqNAfZtsCuED5P27n4gjTHEPC
         LVtUjnR3mBsdjj9+RjjhxHvilCYPsELlDDSTCVoTcDhKYk231g7K+mJkpSxceWsAjlBH
         +Zdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733745641; x=1734350441;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EglX5AVeuOK1iJau5AtpYy/rgxr+Cdktyzw1epur3aY=;
        b=vXDKaS0tDc/BZWECDwm50LEIjGplO3ByMnUfzK5l/0ZjZiW4qvYlgHfzXgoAQ09qNn
         2lRkyWVBpPKLjreuj7JVURWX7kP2My5lFP1F0Ags/ZdpstSl/kMaaueImerz1OxCwOuS
         WSpwhFCb2gqvPAiES9VLsj7q885RpOx7y46GZRE/cWQ3hFVzxquzEBfYaVEg2Ne8xjsp
         z6EI12HGMT3HO07n+95d0iBCOXcZbGwHMiHDWpf9lXgf+VOo5jgxJtpu1HW4iqvvLQXm
         ba26TcqU3We2GlEbKSQNthPJjlPzPWnJX7gtKHTwgyu5aaFWxOd/wZjTbl9if63IeVuP
         OydQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcOXthA0I/TF9djvTerDedJoegtcmRmnOJJihz6QaruJM42Gv1Vjk2d2AZyqXuIue7BL8q368OB7UIR5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiqRha+jePILhh9vpTR+hSwfGeU7VzeF/z9nlPmKLMQOUjYDDe
	+hF3Cb8VV3pWrPP5HyeyUsfTxOXnORKU3oNkawWZfjbK6sOjss3hkufSpn7m4Ic=
X-Gm-Gg: ASbGncvSrBo93rzTdtLDGYhb20cu56c/EPaXjBhJSLG0nf4R+5CRbmzfkRQghRaj9Yc
	n+GxR+IPrj+y5zvxtRhKrCCZBKiybgs9iZR60qV+m+O8IcmAPDCA5ln2RZj3U8INPMFRc8sv3X1
	0QkIVSywaM4vDa727C+AjYm2afyoxqC2CnmeArdjVr7Okt1ebj3IIfBm/zS8HQzAQG1nDINekih
	yV0A02u2IbekjziLjs8LeMB0tZvQe4WJ744DurCNJEXi3jC6pG5YNtOe4yL4NIjPQ==
X-Google-Smtp-Source: AGHT+IFQz+sHrhTNPQ93WvH87tO0/6WQElPlihSk/tcyEOGbqPjda/XE16U0+c3VXKI1+eO+KbJDyg==
X-Received: by 2002:a17:907:3d94:b0:aa6:227b:d821 with SMTP id a640c23a62f3a-aa63a2d24aamr502007866b.11.1733745641516;
        Mon, 09 Dec 2024 04:00:41 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6260e33f7sm678589466b.183.2024.12.09.04.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 04:00:40 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 09 Dec 2024 13:00:28 +0100
Subject: [PATCH RESEND 1/3] ASoC: codecs: wcd937x: Simplify locking with
 guard()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-cleanup-h-guard-of-node-asoc-v1-1-397f6385e4a5@linaro.org>
References: <20241209-cleanup-h-guard-of-node-asoc-v1-0-397f6385e4a5@linaro.org>
In-Reply-To: <20241209-cleanup-h-guard-of-node-asoc-v1-0-397f6385e4a5@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2424;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=AfvDk3kCBindu1M/SPA1g+/8ocBf4bQNvfgLlw3/usE=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnVtvkzZBmR2PooyNA+BCY/u9Ie6qgnsWOoxo8u
 nYzUrYVz2KJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ1bb5AAKCRDBN2bmhouD
 1/jKD/9auacR6d7c3PeOsT6ExgOSLR4E+xafo5iH+maYepzSK5CNhhvW3w7W9V++wZGcsc21l1z
 wS7cYpCttuCmJQ8WDsax4eAqMbWdeAiOCFDZzYT+Rgp/Us0MF6NvNKSU2hY8tUY65lQstuQ3/gc
 NxU0Q45edcfd0I4uLUA53ZRWJli3Ri38KL3ObIrGZJqDShx5HAjM/MuCaEsrygz8Hfo9lyVhkmZ
 igte+tL41Bl7obatzr+jT0ThA5rAvW83m416HxWb+piBcHdt3MSN6pJKX7sMdSWhv9IkqIoK9ms
 w4mQ20MTawpUtAoN5ShFqzwXHfb/Qvfo/RYMowybn7Yd3fFZCxSTz2xAYOEfEomOl0sH1QDPxDl
 8xIc+AJc/+10C50ddXjOIv7jcUsI/Rl/UoLPYIha+9LJ0zl99VD0MEZFionnUqLLZ+zKFnMTDKV
 CunkAkdAa+5xgFXSr12fmWqHVp+3huwnLOOEljxC9z3CuCxKBXS4C00XxLFs5VI6JWSCooVtJyM
 yFw/FvUsokT2B84vtmNZto2gGY5afBAdkTNfKAm1LEGy6FORBKiTr3Ovbl/HPoZx/GECNdoAeXh
 v6GTQjBvR/6viVRSroKgL50NfCeJKLX5bxXAubJc7A65VQN+C/+HBYffLY+GL+578hX8MxACRyw
 4hCy4RLMEUaaz7A==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Simplify error handling with guard(mutex), which allows to drop local
'ret' variable and to directly return instead of jumping.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/wcd937x.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/wcd937x.c b/sound/soc/codecs/wcd937x.c
index c9d5e67bf66e4e8e21a76cfd563c75bac6555513..7d8f995d2daff50708e361fa446b52898c0faa81 100644
--- a/sound/soc/codecs/wcd937x.c
+++ b/sound/soc/codecs/wcd937x.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 // Copyright (c) 2023-2024 Qualcomm Innovation Center, Inc. All rights reserved.
 
+#include <linux/cleanup.h>
 #include <linux/component.h>
 #include <linux/delay.h>
 #include <linux/device.h>
@@ -1445,7 +1446,7 @@ static int wcd937x_mbhc_micb_adjust_voltage(struct snd_soc_component *component,
 					    int req_volt, int micb_num)
 {
 	struct wcd937x_priv *wcd937x = snd_soc_component_get_drvdata(component);
-	int cur_vout_ctl, req_vout_ctl, micb_reg, micb_en, ret = 0;
+	int cur_vout_ctl, req_vout_ctl, micb_reg, micb_en;
 
 	switch (micb_num) {
 	case MIC_BIAS_1:
@@ -1460,7 +1461,9 @@ static int wcd937x_mbhc_micb_adjust_voltage(struct snd_soc_component *component,
 	default:
 		return -EINVAL;
 	}
-	mutex_lock(&wcd937x->micb_lock);
+
+	guard(mutex)(&wcd937x->micb_lock);
+
 	/*
 	 * If requested micbias voltage is same as current micbias
 	 * voltage, then just return. Otherwise, adjust voltage as
@@ -1475,15 +1478,11 @@ static int wcd937x_mbhc_micb_adjust_voltage(struct snd_soc_component *component,
 						    WCD937X_MICB_VOUT_MASK);
 
 	req_vout_ctl = wcd937x_get_micb_vout_ctl_val(req_volt);
-	if (req_vout_ctl < 0) {
-		ret = -EINVAL;
-		goto exit;
-	}
+	if (req_vout_ctl < 0)
+		return -EINVAL;
 
-	if (cur_vout_ctl == req_vout_ctl) {
-		ret = 0;
-		goto exit;
-	}
+	if (cur_vout_ctl == req_vout_ctl)
+		return 0;
 
 	if (micb_en == WCD937X_MICB_ENABLE)
 		snd_soc_component_write_field(component, micb_reg,
@@ -1504,9 +1503,8 @@ static int wcd937x_mbhc_micb_adjust_voltage(struct snd_soc_component *component,
 		 */
 		usleep_range(2000, 2100);
 	}
-exit:
-	mutex_unlock(&wcd937x->micb_lock);
-	return ret;
+
+	return 0;
 }
 
 static int wcd937x_mbhc_micb_ctrl_threshold_mic(struct snd_soc_component *component,

-- 
2.43.0


