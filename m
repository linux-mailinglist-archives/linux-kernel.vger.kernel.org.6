Return-Path: <linux-kernel+bounces-523525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D20A3D80A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ED2D176B5E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B651F4264;
	Thu, 20 Feb 2025 11:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RskiQ8dr"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB541F3FE2
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 11:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740050106; cv=none; b=osh6r1KqTuhXGu16Wz5ASigZmJy+fBwwWSmCcpFhDTRE4HV2/y3MrdZUXH2k0J4BirgzXaqMOpPAUVBJPa9fSUydbuLdKDMF1EjsCc/5HzcaKK8g1QrfLCGm9rdT7PwWW6bNmtKcyAn+Y8Ne52ovMIuFj/kZZScxvYZu3a8cBMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740050106; c=relaxed/simple;
	bh=nznA3A8GlMjZ03UpAd+EaFdRwVMW2jSUcP5sfO1ICTE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ENLGAz8QAeiTCkJ5MFvidGmZIKEyFeOJSGx5VFtB21Drc1ghSlAgRm5K2dkAce2yQXtz79yLT2U12GfCSXlWRekqxEdjoWr0q+UMiOC4uOL8N6MBDrLVJbNFxZn27GfHDsx1uhltuQMa7qyHByuNM3SGFncezhM8NkOrwnKZ7aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RskiQ8dr; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5452efeb87aso837969e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 03:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740050102; x=1740654902; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z8FeS/va+zHK5sGx9TRcjS6J+iyejHe2ih+fYa/2Q5k=;
        b=RskiQ8druaVN5Zmaf6bSU5vQysqosg8jXKAufIFYDvpLx/xPdzcW3QiuR6cKNQZqrL
         obP0UqMrACbhy0PXpnl0WDM3le0a5DVieNfgo9+svQsnQA2MRQWot3WPlHUDiwBhUiJc
         Cd+dxtilfbvYEFGrF9zEtAKQzH4jI5yAl6CipMoNfVPPp5ZMSDNgq5LD/gkr+tDgpspz
         blTlCq9yr/VyjP9n5B11u0pzVFVnmIueXWw5bvXpIhBuu6LtqNO1E5mHRdG9flPPFQ1f
         MKh79/BfA4phw+Zs3mUpHh0c40bAOPD/wBXaq0C5CLNehEOiOWR+OHT3p1NJCgxtdURN
         +qgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740050102; x=1740654902;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z8FeS/va+zHK5sGx9TRcjS6J+iyejHe2ih+fYa/2Q5k=;
        b=BZh/9pSg651SDVf+jU87Xx1wxy1isDzheojNvu8bYMzJvQGEpOpxrPaH3Mwk95Ln5E
         2kpGPFKvSEpY/7nuxyOJbs4uPjAhYxcVy0efOaNgdpF8NFdub2s5wgxUF+Xr25kgVQwo
         qteMKM8kD/0vLJyTrfK6pW+DeX/PmhtKbOWSg3pzYTu3hIVyS5Dds29TYR9jmZDCw/QD
         UkYQmZP80BzBvCaNq2UNTKeHxb6Dqa8DyXTeczsYof4xMLeYu/4/KqGGp/mC0fk4GArZ
         0/Ly4kZNKbYtpLfo8MIR9/VWbjhUhaPjvdX4jTvPhncnYINRx9k9cVh2tthJdMUucQkM
         DXfw==
X-Forwarded-Encrypted: i=1; AJvYcCWgexdAT7xbB1QqaF6sVoGf819K30ghtJUf6Td9e5Gego8IrkhP7hP9fEdVlvy0DKy0agNRVOnL5c/Viug=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjXuPQPOCMJlewJPiHLg63nvrO8J0CPn8HIXpM5avsUqi7cJK0
	HosWifgveTKeu9dn6bOm3FV2WhjcD/7sEyKz1PE78hlyNqF34J/3A4L+i76PJxY=
X-Gm-Gg: ASbGncvmCUIrKRl4Jn5Lw7SK4o5znWMqwbZMs3/bMlmVGpqNITLFOqBwrjNmWnUhFxq
	rVRwQUUG54ZWDoKZ+io1XKYAGTVS8qDYC7oMhoyYcMIhewQqiuRWHPfG2FAnWbo0hRJxaYV2ODH
	7jY1HY5wXDpTZTud9SOBHGfubhSG3i/l1Vd0ASjELJooDD+RnCQQyALm5+faMF+i7A8J6OBp+IA
	VRjsMKOVOuNBd4TpOwwQE9GRZP4To9ctZ4PZiOwO/7u+nYosdnhPNN90NnyqqVFapQrY84fZpVA
	4shzNGPQTgwoEhYzxmNseEI=
X-Google-Smtp-Source: AGHT+IFU9ElSwjjqQx8XjrVFfwUEEeETjZJP2gCbsJDlUGmgPawhSl7mzS0K/iqHALGezyTI0ARFpA==
X-Received: by 2002:a05:6512:3b06:b0:545:1bd:a0df with SMTP id 2adb3069b0e04-5462eef45cemr3252158e87.23.1740050102303;
        Thu, 20 Feb 2025 03:15:02 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-545297856c6sm2056164e87.142.2025.02.20.03.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 03:15:01 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 20 Feb 2025 13:14:45 +0200
Subject: [PATCH v2 3/7] drm/msm/mdp4: register the LVDS PLL as a clock
 provider
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-fd-mdp4-lvds-v2-3-15afe5578a31@linaro.org>
References: <20250220-fd-mdp4-lvds-v2-0-15afe5578a31@linaro.org>
In-Reply-To: <20250220-fd-mdp4-lvds-v2-0-15afe5578a31@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3307;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=nznA3A8GlMjZ03UpAd+EaFdRwVMW2jSUcP5sfO1ICTE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBntw6rRbr96yN51JnJO6N0m78cEm276ifFyrQ2E
 SShQlIaEjCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ7cOqwAKCRCLPIo+Aiko
 1QfDB/9LTU1jklbNgPinoHoSuaCNIbTox61Mp/VXVFwjcGnGIgku+sEd8/SG5lglE//EmBGWt6A
 g+GYO1DSoxgyIDBhioiPRbqPWZ8AmLX62snw6MX24URO9S2wZbECNtWPpvkIKXZwExfe4h8mQQA
 PokpkU5Y420PU0CHcE0rm8N91K0OU3Dz861Tta1thWxOxytytW8WWbxHDv/Yxf8pjAvGbw4brzd
 Urh6HMf9xwocvdRIcaEM8Nkb2VDVEtw94oFGAQ0oNyukOO5jFRs/BlCs1foGhvnJoKGvtsWs27O
 WlUpo1/27GKOfKGo+GWMovy3tyjklSjmA8aiZGvTklHcDUWv
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The LVDS/LCDC controller uses pixel clock coming from the multimedia
controller (mmcc) rather than using the PLL directly. Stop using LVDS
PLL directly and register it as a clock provider. Use lcdc_clk as a
pixel clock for the LCDC.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.h          |  2 +-
 drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c |  8 +++++++-
 drivers/gpu/drm/msm/disp/mdp4/mdp4_lvds_pll.c     | 22 +++++++---------------
 3 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.h b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.h
index 142ccb68b435263f91ba1ab27676e426d43e5d84..b8bdc3712c73b14f3547dce3439a895e3d10f193 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.h
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.h
@@ -207,6 +207,6 @@ static inline struct drm_encoder *mdp4_dsi_encoder_init(struct drm_device *dev)
 }
 #endif
 
-struct clk *mpd4_lvds_pll_init(struct drm_device *dev);
+int mpd4_lvds_pll_init(struct drm_device *dev);
 
 #endif /* __MDP4_KMS_H__ */
diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c
index 8bbc7fb881d599e7d309cc61bda83697fecd253a..db93795916cdaa87ac8e61d3b44c2dadac10fd9e 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c
@@ -381,7 +381,13 @@ struct drm_encoder *mdp4_lcdc_encoder_init(struct drm_device *dev,
 	drm_encoder_helper_add(encoder, &mdp4_lcdc_encoder_helper_funcs);
 
 	/* TODO: do we need different pll in other cases? */
-	mdp4_lcdc_encoder->lcdc_clk = mpd4_lvds_pll_init(dev);
+	ret = mpd4_lvds_pll_init(dev);
+	if (ret) {
+		DRM_DEV_ERROR(dev->dev, "failed to register LVDS PLL\n");
+		return ERR_PTR(ret);
+	}
+
+	mdp4_lcdc_encoder->lcdc_clk = devm_clk_get(dev->dev, "lcdc_clk");
 	if (IS_ERR(mdp4_lcdc_encoder->lcdc_clk)) {
 		DRM_DEV_ERROR(dev->dev, "failed to get lvds_clk\n");
 		return ERR_CAST(mdp4_lcdc_encoder->lcdc_clk);
diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_lvds_pll.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_lvds_pll.c
index ab8c0c187fb2cd05e26f5019244af15f1b2470c8..cbd154c72e44c848fa65fe01d848879b9f6735fb 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_lvds_pll.c
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_lvds_pll.c
@@ -133,29 +133,21 @@ static struct clk_init_data pll_init = {
 	.num_parents = ARRAY_SIZE(mpd4_lvds_pll_parents),
 };
 
-struct clk *mpd4_lvds_pll_init(struct drm_device *dev)
+int mpd4_lvds_pll_init(struct drm_device *dev)
 {
 	struct mdp4_lvds_pll *lvds_pll;
-	struct clk *clk;
 	int ret;
 
 	lvds_pll = devm_kzalloc(dev->dev, sizeof(*lvds_pll), GFP_KERNEL);
-	if (!lvds_pll) {
-		ret = -ENOMEM;
-		goto fail;
-	}
+	if (!lvds_pll)
+		return -ENOMEM;
 
 	lvds_pll->dev = dev;
 
 	lvds_pll->pll_hw.init = &pll_init;
-	clk = devm_clk_register(dev->dev, &lvds_pll->pll_hw);
-	if (IS_ERR(clk)) {
-		ret = PTR_ERR(clk);
-		goto fail;
-	}
+	ret = devm_clk_hw_register(dev->dev, &lvds_pll->pll_hw);
+	if (ret)
+		return ret;
 
-	return clk;
-
-fail:
-	return ERR_PTR(ret);
+	return devm_of_clk_add_hw_provider(dev->dev, of_clk_hw_simple_get, &lvds_pll->pll_hw);
 }

-- 
2.39.5


