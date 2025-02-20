Return-Path: <linux-kernel+bounces-523524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C87A3D807
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03B977A7A5A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C2E1F0E37;
	Thu, 20 Feb 2025 11:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iBKVl2Bt"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC651F3B91
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 11:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740050103; cv=none; b=pfesy+zv5fpUI+9nWqZYz6JMM3gP7WTrI1PsCRXws1Byj2HO/DjltPB/V/QWJZyysAGRa1dVsUWU8eNb2YmSVtRP9Ikq8nmA+huHOXjQhmlB35ac0q6DxrqC+tvlNFF/CG4yrYDHJY5GNs2DHtAHJ8xtC73ecObi9WN1fWgqaT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740050103; c=relaxed/simple;
	bh=Iuu/rih2gTkZKK6Ghs6dsVuCdf8xwLg/vMhkHtsubTw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d/S6dnU9W1ttljj/q1J/CY79a/pN1UlxlTTrl59yZcK1jcnfEfROuzktNW+MsYVSN74lf1A5ENMzJOJCKKpAzVbScPsAlU7dVOkb5ywnPG3TR1Z8NMQHlFpffeeHR4kuKyH41Z5wi/oYs0+F+HJapkOnrn+2KqT42GgLdiyZvno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iBKVl2Bt; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5462ea9691cso957833e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 03:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740050100; x=1740654900; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v2FT69grsgtQGwodtPuDBrmjAJehPRULckabnrzgeOM=;
        b=iBKVl2BtZMiXiv6oqXoZt1UyyEDPhbke6aT3kMtbhnoK5P0kQG4inAsIyTaEt8EOsV
         W0gvhZ/GET1RpJHWhaQY1/5LLYxbSmVTpdz2qH1z3XZmrpcVAUuQsBUCASfFYDjcV92l
         fyu9IR8N4qe4U4amrtRip+6F08s0IJvwmF7Ai9W7Tyyd873sLvyqVGVKyTOnOf01lQOy
         IZuiYj/Qs8X3217mTJsU+1rjxiYSXPZqO3oed86Mc/EyP0aZqQjhCjw0G1jl9q3NmLUD
         mhuR8nofnP55d2yGrvPzNaQPRPtx7R9aCWRl7BqvwucTJDcFJH4H/tE6s+nwTcx1OXSC
         4DYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740050100; x=1740654900;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v2FT69grsgtQGwodtPuDBrmjAJehPRULckabnrzgeOM=;
        b=bt8A2keWYIK4XhY8sHfPKkdrHacWC4M95vgncfpBIpgyXLs7POxv2PYy245zRQLlMD
         hcnXYyU92Hy+e/4FVVnfQY52ecKMiJO3VpxvitnK4G9OQYg0WxefQ24DlZyFHZnLynlb
         Ru71zXR6ERRjQ0RS/8xFz1lVVJjGfBgRYpAAva5ckDdElaSQDJ+IFn8L5yiGLhKsVRLn
         I3e5LD4lGZrYy6h0/u+jXf0TOpQfEHWWrsnZ8Fjp+lauuHo9/FOWPVH72CQmAKoocTpC
         HjKZuAeSUL9Rl798nYw9Ra99V6UT1C/fbuUTUwChHIxEE0W2Asy5gektSmT/uUGXaESU
         CJpg==
X-Forwarded-Encrypted: i=1; AJvYcCVhShrCl3OalHCJ3/n0uo69LAjFnqJQmnl2een9ZnhEq10l83Dtxg7L0acU1GPZKeOOijLVvz25vF3WUfs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsr8FFIRTUlLUz943JkldcI9J3ii/GAmYTY5IcSnovMW6iogvH
	Q8SIueEWp3rZ72OU0rEnQgafWHX0/U7TjkXzFX8RXqkrUwm8DeA66qQWq3YxJvQ=
X-Gm-Gg: ASbGncvlxJnbsym5Mi5ZqT34OY3VSVG+7je/ajlDW8x/YM8k7S7nbrI4IGPnJax7/wu
	udkx/SrP02ukaD9J/IHYq8iQpjrAtWdSEychWvyGuf/uRemBuFpGGtUn94aq7NVL8td6nXjMSi+
	vOtA+b+94eo4Vb3DRI94bHNVUa7+KNApl9riCT+tx1s8eI4e/GGdYAVSfh9uKvVmwujFwV4/DuM
	5NPp3X/jgwjQMKfl6GN/g6440KE5DP6pxEHTrCKn9IhYy/zbLSFQ/0mpds4KTZ475wds4OyjtOh
	q/WvzhJriRQH71jO4+CdHp0=
X-Google-Smtp-Source: AGHT+IEK5YepgQWPALUfLRJKi3C8erOz++2sLryCYJu3ofhHXWr7LbJxyrpPkJIZbnwDfcXCA7dAIw==
X-Received: by 2002:a05:6512:1189:b0:545:bda:f17 with SMTP id 2adb3069b0e04-5462ef201a0mr3010127e87.44.1740050099792;
        Thu, 20 Feb 2025 03:14:59 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-545297856c6sm2056164e87.142.2025.02.20.03.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 03:14:58 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 20 Feb 2025 13:14:44 +0200
Subject: [PATCH v2 2/7] drm/msm/mdp4: drop mpd4_lvds_pll_init stub
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-fd-mdp4-lvds-v2-2-15afe5578a31@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=922;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=Iuu/rih2gTkZKK6Ghs6dsVuCdf8xwLg/vMhkHtsubTw=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBntw6rBhceXrSdx0nb7uB53zSoFWDO1AkbXhVhq
 +gcl/EdOZuJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ7cOqwAKCRCLPIo+Aiko
 1YGzB/0Xno3UiIYTOdud4CEcJfrYiPKQ+eDCZMrq2/oZ3IKWU8zODmyCDhFLUcbZQ0C04pdG40O
 rYOSy2Jg8WQNkxq444ypAAVL3fV3LD466bkbnE84alabWsqUc95eCsbpatXcR1zt5C0SXGXZiZc
 Md04vbC4VX36PjRWVJigYfHQbbINZ7pG28jzX3Sk3GzjQ4frPc8PlEI7NBw+0T9gPcqfovjJp4a
 j+JLYqZ2LQFVh4CThB5jajAT1whTWnjZZNxaUgEld9idFUVCoLrRLazh8ADiIT3oMEBF9UbJt2J
 FY1lN1Ofmnmmuw+OeJcGqDv8RkS5ZlbAx+7roaozkAtlnVV3
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Drop the !COMMON_CLK stub for mpd4_lvds_pll_init(), the DRM_MSM driver
depends on COMMON_CLK.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.h b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.h
index 94b1ba92785fe55f8ead3bb8a7f998dc24a76f6a..142ccb68b435263f91ba1ab27676e426d43e5d84 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.h
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.h
@@ -207,13 +207,6 @@ static inline struct drm_encoder *mdp4_dsi_encoder_init(struct drm_device *dev)
 }
 #endif
 
-#ifdef CONFIG_COMMON_CLK
 struct clk *mpd4_lvds_pll_init(struct drm_device *dev);
-#else
-static inline struct clk *mpd4_lvds_pll_init(struct drm_device *dev)
-{
-	return ERR_PTR(-ENODEV);
-}
-#endif
 
 #endif /* __MDP4_KMS_H__ */

-- 
2.39.5


