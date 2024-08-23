Return-Path: <linux-kernel+bounces-299337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0227495D323
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 18:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B225A28A3CD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 16:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC2918BC3A;
	Fri, 23 Aug 2024 16:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gLjtB4L1"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14371898F3
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 16:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724430102; cv=none; b=Z3Oc4b4OgmTozcAGNPVe3o3ni0uml7GwD9+sPezzlU8I9gIKcWV8AvdNgE6DMhxzlLeNbUWFatN2ab+rhfwvefGr9cVFc5eLAAH15xS4O5gQMhISPJu4oQJy24grgW8c3WXe7QdSh+zHUQjR1VLKdPI7wdXBkJ79vpihfF0yxFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724430102; c=relaxed/simple;
	bh=YMK3zEWCRlOermMUoSe3gCcOKQ0OSZIF1hdfiLQ3/3s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=goGgObuHF7HrlBhW3Nnhuzi9+db5HBNiKC3yVMYrBCdiKIcgX/LTQky0HGphMbf1EAVQRk0rN+Ix8am9j5xScjDxcCpWrMtgx+SsDMlvbPyggVQ9zUPrjcrha5OWyrBA+NY4BD16W3jxTurBv4kc9BmtHE4sVQXfNWDxKf7wd44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gLjtB4L1; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4281da2cdaeso3687005e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 09:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724430099; x=1725034899; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xE4AEtOVapV6PoQb9xXwqRdy3tgXiMSO7wO5xbXDvBk=;
        b=gLjtB4L1f3OUa+jer1S1Ad0TO4S1Y3Adr930FN7zmmyoF/ggE0VHZX+lGO8OMzYNPP
         fiwxFJoTh/NJeD8UtDwoX5x4wZzaxEyWOoWRszNMCeu5vqmXixpAy4aCW/qVwYa9NvLQ
         N7XyR9n9HaMZg77DG89OMW+v6IFhJtA26VX2egVEWKJxGhwvS5VDjGd3TtZohMtK9OhX
         UYO0F+8xDn/Ty9WGVEYRWO3YS8xQXVO0GR+ZO7PnXtmfnZh3yYLIur57Lgb3RoyXPJjs
         2lYGH0EQt7w0JGaR5vFOzMY/5B82pQbN3DZ92VlrBOXUfeKlLZY1Y+blxnH/fFfxZCG5
         Y5fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724430099; x=1725034899;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xE4AEtOVapV6PoQb9xXwqRdy3tgXiMSO7wO5xbXDvBk=;
        b=Io0wo66Ci6DCKn8AIfmUTJSfFryzw8zNiF79nkIzZV1KptQdrBySXnjC9LlE1PIH5d
         RI6HaGUBlZPKRGSeia6ZHHQVnXlX7mMft8SxpmIlmMbn36lhX8HjBgr+NFAOqxOoHQT/
         XoLQ6unExJXphMw4p8gCVYoN2L79AXTLfbi4VuNSE59TvIFLhPZ7fWpUt34yF8MewuQi
         MBRKUNINDQDFxNKmotQNCxdOr43065AqVZhq8GrBo7iIZKGahp5rVsaxUmvuMO18qh/O
         90JksKPhqkokPfhUrArQAYo155xVNq2COKP8SLP9QEkiT/RPcxjgK7N9ZBlcwFdzV+A4
         3C2w==
X-Forwarded-Encrypted: i=1; AJvYcCVF9yGnk1L9T0lFootlAkM8RaJLYtvJgIn/kvc4s8e1JxRGT+V65n6w/nntmI3pHV8otGB4y/M8a2THr7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTbNX8+AFpICzUTwmbWuGgcrimQTHIJgsvjzVg2Ig6op3j2G0n
	cKxFPMJYG6QCzPkfQGG88UKcJUR6RLbPRnL1ZRvg+7xF67cR8cmBWUYW/beNT1A=
X-Google-Smtp-Source: AGHT+IGFWpXyotIsRADtAGF2Vnlr5VPVsHgGrfTXQwvdzGD3AL/M2ou5aTc2LpMdPeruY+7Thjpqdw==
X-Received: by 2002:a05:600c:4445:b0:425:7ac6:96f9 with SMTP id 5b1f17b1804b1-42acc8a55f3mr15708725e9.0.1724430099295;
        Fri, 23 Aug 2024 09:21:39 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37308160586sm4499312f8f.58.2024.08.23.09.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 09:21:38 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 23 Aug 2024 18:21:31 +0200
Subject: [PATCH 3/3] ASoC: codecs: wcd939x: Simplify locking with guard()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240823-cleanup-h-guard-of-node-asoc-v1-3-2349bd7fb7f4@linaro.org>
References: <20240823-cleanup-h-guard-of-node-asoc-v1-0-2349bd7fb7f4@linaro.org>
In-Reply-To: <20240823-cleanup-h-guard-of-node-asoc-v1-0-2349bd7fb7f4@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2206;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=YMK3zEWCRlOermMUoSe3gCcOKQ0OSZIF1hdfiLQ3/3s=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmyLcMC3oV2jdwkepRh+MjsS/sJo02teK7A0I9+
 FPmS5kvoLqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZsi3DAAKCRDBN2bmhouD
 1xDgD/9h+NlLbLIyay5J6kOJi5zvny6MWxMj8Cly/6STHvdMPumrujp69rx0qNuuGIGJ8Tq0E3k
 +SsIsMKiY8MVTc0LZznq1PN6rRVdZL/cEYNGUXFqnhnsOiphoY7Qa6XFAO8jMVZHcWd0755F0WX
 G7B5gI4kCYd4AMBvfHKNybWwgQZdVkxw+YXo0F+mf1ThRk8aMIwFkVgTj5sKkpFphSBScn0euRL
 Yr4PhHfJP0iF2bAwKHwP0767rqe5xGXR/508PmGOtsKxp/VH/DZAOs31etB+nRns/mIRjdwQ/Jp
 y6W+x5hbeGXa1yZRGHGJnLVCGJvVyYs+i8o0k//9dLqUBaItS37JaVePZHW5ybcAiHr8YBIpBvl
 kzW6ACe2HKqN3QBPrrIgaLZDOf06YzunRQC7XmaaQUg569GGBtQeiUliqsrLmsLlP6iUanAXN51
 NAwCFbLLAAw2n8IgqnPXRQCBuy66e6jJwRFaW+A5UFtT46pNOOxtNAvyJaUG+js/X+dJMExOUXT
 EW9KesBY0CKrk3M5dsRje5drrMbGzKGeord0krGu/kebQ0LP6fss4uGRkLtgWNkBiATpQqsAT/l
 jVAwMvA9nHfzmrtZVl2iFJwwxwvEEDxld0u18nLUKgSoEOlgXeMySYFPrYZ0Z/sOD8tTeRKx63x
 dMmIU0+hq5pCulA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Simplify error handling with guard(mutex), which allows to drop local
'ret' variable and to directly return instead of jumping.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/wcd939x.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/wcd939x.c b/sound/soc/codecs/wcd939x.c
index 68fc591670dc..a77e4b8b3931 100644
--- a/sound/soc/codecs/wcd939x.c
+++ b/sound/soc/codecs/wcd939x.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2023, Linaro Limited
  */
 
+#include <linux/cleanup.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/platform_device.h>
@@ -1933,7 +1934,6 @@ static int wcd939x_mbhc_micb_adjust_voltage(struct snd_soc_component *component,
 	struct wcd939x_priv *wcd939x = snd_soc_component_get_drvdata(component);
 	unsigned int micb_reg, cur_vout_ctl, micb_en;
 	int req_vout_ctl;
-	int ret = 0;
 
 	switch (micb_num) {
 	case MIC_BIAS_1:
@@ -1951,7 +1951,8 @@ static int wcd939x_mbhc_micb_adjust_voltage(struct snd_soc_component *component,
 	default:
 		return -EINVAL;
 	}
-	mutex_lock(&wcd939x->micb_lock);
+
+	guard(mutex)(&wcd939x->micb_lock);
 
 	/*
 	 * If requested micbias voltage is same as current micbias
@@ -1967,15 +1968,11 @@ static int wcd939x_mbhc_micb_adjust_voltage(struct snd_soc_component *component,
 						    WCD939X_MICB_VOUT_CTL);
 
 	req_vout_ctl = wcd939x_get_micb_vout_ctl_val(req_volt);
-	if (req_vout_ctl < 0) {
-		ret = req_vout_ctl;
-		goto exit;
-	}
+	if (req_vout_ctl < 0)
+		return req_vout_ctl;
 
-	if (cur_vout_ctl == req_vout_ctl) {
-		ret = 0;
-		goto exit;
-	}
+	if (cur_vout_ctl == req_vout_ctl)
+		return 0;
 
 	dev_dbg(component->dev, "%s: micb_num: %d, cur_mv: %d, req_mv: %d, micb_en: %d\n",
 		__func__, micb_num, WCD_VOUT_CTL_TO_MICB(cur_vout_ctl),
@@ -2000,9 +1997,7 @@ static int wcd939x_mbhc_micb_adjust_voltage(struct snd_soc_component *component,
 		usleep_range(2000, 2100);
 	}
 
-exit:
-	mutex_unlock(&wcd939x->micb_lock);
-	return ret;
+	return 0;
 }
 
 static int wcd939x_mbhc_micb_ctrl_threshold_mic(struct snd_soc_component *component,

-- 
2.43.0


