Return-Path: <linux-kernel+bounces-211893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B34EF9058BD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 18:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5741B22589
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7347F1862B9;
	Wed, 12 Jun 2024 16:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cA0a0hqq"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4F71850A1
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 16:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718208964; cv=none; b=oxb3r620hS57kGZw0OJUCaEKEuLWDDooTPhxzGX7/iKoLbr8Iqoyy3j+GmFYMPUvwwhJiZ9tDCJNo2S3a6pVY0BHby07cRwBpYOBmRrj2Xx0c8dWXEUDyN2r6IOYBU0hIQtoOL2M7qxs7ZKpt/Z2RVYsTUAGgVf/KLGzFNHnqQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718208964; c=relaxed/simple;
	bh=t1W8fZJc08OWTn9drn5Isz85PBMXQQtI8H3pG9X8loI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KzANdQHg/ZNgLi3hTKYZGbOtRyJE3SCMxcjp1Uh+u+kx6lFpBUeEWt6WzzLga4UtG6p60ybj+EKGA4cGuXTTSfQsnx60inHTTNBWUWwFz0fo1som4dsQPJDxahS7lY3n1a7eORUSKqQkY50lxNU9rk5WqFGB7meEBiK8IVVnobk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cA0a0hqq; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52c9034860dso57056e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 09:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718208961; x=1718813761; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WOyBASUhg7ig8GH/FzL2HhKWigPyyxASUZk5LUtWyQI=;
        b=cA0a0hqqQBqziyFhUdbmqfTPYuPkIFqLuQYx85XFBHFKWcB5FBCwkVWuZSxHEtEXWS
         SJbAyF4HNk/RUImASgAGbGdx0iiwBlEWdo35RN8xvywf6Zf3V821UE7OJMfV8OzjKPj1
         VOS2A0m7gh6CK8qJMyzXHyncMejGVkNeqD1Ti25bTZ9C/bhpEMSWXQ6+b1o+KBkD1uN7
         fAxxctriCyu4Kp7AXgNJ4AOHcjGGGsrFXEZ8iJXo/XXfNfONs7AWQdt5FDCZOtdv5ySB
         nHsm3NOgDENdNvC+2bn1Ph9J1towOeU4wrARW3ZQrO38wIzUq/deAcxYdQbFwlI3UplY
         L6RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718208961; x=1718813761;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WOyBASUhg7ig8GH/FzL2HhKWigPyyxASUZk5LUtWyQI=;
        b=VZ3Qu/lTvNVpZodPz2bZYfgwOMq8w4q/nexyLNNIpxDUDV0K8qq//fh8V76O3DITS7
         d6/SPGa8Wupx6xkdUzzTUoDje3xh1c8JR9BNjDefOzR0Wdt2mii0sEzL4n4LVMIgk1pI
         eOTzzcP3n4WfbAzjOltt/eR+7zUc+Ka9AJw72/BE2vlPmvgYus8nTUAdPizZMAgnm4Yc
         qzQB8+uavpvSPIGTtPULNkvpMR1L+25FDXr+BZWlm4k9FNQmXK6zclKGr1bgiwQUN9Jb
         NrFRTp4YKzOlm5+TiJDOd8l8jtsVBoZxsQenA3kc7piB3xedUeIJUHKgsBqAL+GV3iKJ
         RDqA==
X-Forwarded-Encrypted: i=1; AJvYcCXmtU/NKROvC7REDbQH6IFpipQZY9S+rW0o7NsQncZkoSmkXd5eUdbs0xW3MlynyimQX+Dz/jmj+21y1+hgIYY4vB+jjawxU1AA0MrN
X-Gm-Message-State: AOJu0YyviYbZWPQ+DUrg7lXyKVSx0Pk3IcCviWzpn75FXZJzQhXRJu4N
	95wr8QyMOSgiRS4/2tx8hB9gNgXxape9d5SfoKXXhzuIz8JM8fOxJqcCOfr9PTc=
X-Google-Smtp-Source: AGHT+IEWRBqWsxwgvrJQWye7VveA5xb94vJGDj2onicCiggy/FGFATNeH2oWusyHU6RLe7TqvK/r5w==
X-Received: by 2002:a05:6512:31c7:b0:52c:8342:6699 with SMTP id 2adb3069b0e04-52c9a403655mr2243960e87.55.1718208961478;
        Wed, 12 Jun 2024 09:16:01 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6efd6cfb74sm624815866b.20.2024.06.12.09.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 09:16:00 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 12 Jun 2024 18:15:27 +0200
Subject: [PATCH 14/23] ASoC: codecs: wcd937x: Drop unused state container
 fields
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240612-asoc-wcd9xxx-wide-cleanups-v1-14-0d15885b2a06@linaro.org>
References: <20240612-asoc-wcd9xxx-wide-cleanups-v1-0-0d15885b2a06@linaro.org>
In-Reply-To: <20240612-asoc-wcd9xxx-wide-cleanups-v1-0-0d15885b2a06@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1386;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=t1W8fZJc08OWTn9drn5Isz85PBMXQQtI8H3pG9X8loI=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmacmjKk/cSa0vLmOH1Wr4+Ic2SQUQHPw5w7m0r
 rW1nPqA7zaJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZmnJowAKCRDBN2bmhouD
 1+miD/9dW1UyFrklWvHwePml6lmZcpdQMxwTt9JA1H2+9BAq61olORcBTuj/boisiFPdwUwZ/Fj
 YnEhI4V9gRT0Jt5z1JInpiLwN0bx6Z1UVjgGLop5LRhQDwYXOUA8wnoz6iStmtWodULd7ntp2so
 bfQ/tvkf+LafQV98UPAasekyJY+dd9DJXVitrZCkwPAA2NKjye9TE6SosjPkPDI7sw2/KW/T6cm
 I0yHZRHQYpmQr+hfUlKqYevkd57hx5cQeTQJeZ3m48pK/7b8FQBv1cb8A9AHt+EZhLM8euSIrPa
 vWoFQoLqMJBLhC5YZbilAt7A3TAIF96h+kfJH0fWh/Pm2Isb/kgq5TfD2FRVf2ggJLcsHYtqVuM
 SYVPuzdpLeuI6wu2AZRQy6lVeUWaESOLllSncQ3eyRkI5FDiKFiHJmv5Ki5Rudzlm4aigLPrUY1
 MYIYjarXaerHU3eK+PC3n+0eTylWBdvUn7PC9DGftUIAXk2UM0lPnIvEWJigAzS9r/24Y84dHOT
 GPetz02oLUJrSIZpPlVliXi0wHvP0gEECtNEM5Vqxr1YlXbAT46J0cjV6zfWdYAWI7Ez0vVpOUP
 klB9PMMCteeGk8o7ylVAv2IPsxzstcwPFWfNWpkfK1ryiSkNtJZsBokx/q4KE0erop1p8v7wH4H
 3uwiRTC0df1ARYQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The driver does not use few 'struct wcd937x_priv' and 'struct
wcd937x_sdw_priv' members, so just drop them for smaller code.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/wcd937x.c | 4 ----
 sound/soc/codecs/wcd937x.h | 1 -
 2 files changed, 5 deletions(-)

diff --git a/sound/soc/codecs/wcd937x.c b/sound/soc/codecs/wcd937x.c
index 8b000ba9a469..96e2989f9722 100644
--- a/sound/soc/codecs/wcd937x.c
+++ b/sound/soc/codecs/wcd937x.c
@@ -103,7 +103,6 @@ struct wcd937x_priv {
 	u32 micb1_mv;
 	u32 micb2_mv;
 	u32 micb3_mv;
-	u32 micb4_mv; /* 9375 only */
 	int hphr_pdm_wd_int;
 	int hphl_pdm_wd_int;
 	int aux_pdm_wd_int;
@@ -113,9 +112,6 @@ struct wcd937x_priv {
 	struct gpio_desc *us_euro_gpio;
 	struct gpio_desc *reset_gpio;
 
-	int dmic_0_1_clk_cnt;
-	int dmic_2_3_clk_cnt;
-	int dmic_4_5_clk_cnt;
 	atomic_t rx_clk_cnt;
 	atomic_t ana_clk_count;
 };
diff --git a/sound/soc/codecs/wcd937x.h b/sound/soc/codecs/wcd937x.h
index 834a3e7713a3..f267c66ca959 100644
--- a/sound/soc/codecs/wcd937x.h
+++ b/sound/soc/codecs/wcd937x.h
@@ -508,7 +508,6 @@ struct wcd937x_sdw_priv {
 	const struct wcd937x_sdw_ch_info *ch_info;
 	bool port_enable[WCD937X_MAX_SWR_CH_IDS];
 	int active_ports;
-	int num_ports;
 	bool is_tx;
 	struct wcd937x_priv *wcd937x;
 	struct irq_domain *slave_irq;

-- 
2.43.0


