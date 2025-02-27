Return-Path: <linux-kernel+bounces-535446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62082A472F0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 03:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60C1E3A5F52
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 02:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632821CAA67;
	Thu, 27 Feb 2025 02:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W9wANFDo"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF641C07E6
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 02:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740623125; cv=none; b=WyKCh79Thn+MAxRWckhyIK1jtQX2xsuhw66ifstZ7HJqTrzqxmibJLYleYfBVId1TBIGAfqdGb539BDtEiUvrdFI1AeK8NbKGEdjYh7uA6hOfO1RI4D8+TeuNC3ujuQbE7QC6nrfmDqTUn2VClo8FVAxX5wrPb26LudnYOXAtOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740623125; c=relaxed/simple;
	bh=27+bBwIzCM8lHu2v6Fir13MzMlLQU6chggcqKIoU0MI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oq1ZFqX9GjKmVcYqY+5WGDr9WFcIuPKshzmvW1MDXur/m5Yu5alKMcKDTOd2O4dKNQxd+9leQw306V3OYt4ApVLOhBl6IhTDATpSx1U9RfFuJLDD4ZkIH1cJwylhdNZKJAaKRZ/h9AVmm6BAGpaYud22aK3jL0KlZczjlG6joGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W9wANFDo; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30a303a656aso5140791fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 18:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740623121; x=1741227921; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xjMPSn3p+kKVaFgGwZAw2jpHs3L/eAAFrrWZof4s+cw=;
        b=W9wANFDoaAwcnML1oAliVynhMeEWmCo41zXTMNTecu9P2e9v31tLc7AfAiHB8tHBUP
         MWPmzmjYCsRDeYVodgTIQPBIPE8kruKC14Mi1rLRYMNP7/qr4Tnr3D0KTD1OamTS4koT
         p10y3jwxzIXuP1wIFijRxg22qPnEmdeZMMkg8NvsSkzB0BYC1Hvbq5VSdsh/EP1JInpN
         WtjUID2/WohR+S9Bve70nslxRI/LGYufvLWdZq/HS+UAY/mMSSBEkI1W/tjW/zBReJ3N
         1oeYHETKZDINwXpKpZ3at8tCoeArHHR3fNi4lm6YQEn3ZyrBy7LBtB39y8jAnjCHXjSU
         1fgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740623121; x=1741227921;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xjMPSn3p+kKVaFgGwZAw2jpHs3L/eAAFrrWZof4s+cw=;
        b=PVQuxPzpjg3GnFHDxSDwS6VK5olUOTlVqJxTWk3K3Z1doNkw9nwOfH4WiqqMm5gGSk
         IcJblmk/DI5IblS8LpMj2Do8aJM4VTgd9SURCD26FUVAsdtVm6dwOf80ZPvwEj4OcuVb
         MActA7+etT1Yiq3d62ZHBj5ibWqp8O53ubCNsSqQF6yVzlzzi0nnbVKrIVVQF/DmzCb9
         mJ7acC36i/Bb/Th/NSqMNt33gSj/32DurqQzzJEpitkRUIFxdWTFXRgepEEu1Ux5PZR3
         exeOsnv3DVi3T2ugmGY1Nfha2LLfT51/MkemigznY/ONmmv/9plzizJQjPxUglP0OFnm
         4dzA==
X-Forwarded-Encrypted: i=1; AJvYcCXqnaQMafLAlx4RIxAlBdxorNOLttb1E9+V3HIAKr4zi80dhxfHH7VOn00wrb4F140q7CM+ZMIQ+0wYfHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYFVHgPisWfYfV4u5ysunDChQSMKAkxMzUnr0l3+C3RI9McY17
	iXmokYj6xA4MJe++7G3QhUpLozl5bCDAxrDof283M48FuHFHBqnWJOrQGYZUZoI=
X-Gm-Gg: ASbGncvUSID2LjgcB1JfzdHhXu9AScfs4eE2Ju85SZS6v3Kk6+zgnHTF7zDLgGifEBl
	YoarBdVfLb5m3LHgBl9KJeoVTMvUi0BmXX+uJvlgvx6F1U92Hb5ifFH7zrr1yFS2LZC+vtG0Svp
	svHtvCDuWp1LoyKGZF1oYoyAKvUu8mwrIwvkbh0XHKs4A6qL28nNK5MgJHNJIA467/YhranVgCr
	A9ZBMO8lBiphlROvq4fsmNkkcQgcv+kJ2yk+7kssLXxmmc+2K3ugoG3BpwTmLXSKgTdi9HzEFav
	Eyml63STAuVGNEVGnT1+LRW7ebwPveWDsA==
X-Google-Smtp-Source: AGHT+IH77YDGb3SZATx2bSqI54qqDb0dQOMQtl3AYNP1lYyp8xUbecwSvBjawn7myFKJmWOKcAzSAA==
X-Received: by 2002:a05:6512:3c9c:b0:545:c23:9a9f with SMTP id 2adb3069b0e04-5483926338bmr11394006e87.44.1740623121569;
        Wed, 26 Feb 2025 18:25:21 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549441742a0sm48067e87.5.2025.02.26.18.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 18:25:20 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 27 Feb 2025 04:25:11 +0200
Subject: [PATCH v3 3/7] drm/msm/mdp4: register the LVDS PLL as a clock
 provider
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-fd-mdp4-lvds-v3-3-c983788987ae@linaro.org>
References: <20250227-fd-mdp4-lvds-v3-0-c983788987ae@linaro.org>
In-Reply-To: <20250227-fd-mdp4-lvds-v3-0-c983788987ae@linaro.org>
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
 linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3368;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=27+bBwIzCM8lHu2v6Fir13MzMlLQU6chggcqKIoU0MI=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnv80Gt/5nSvJtT/vlFx8Una3vhVbTV9fge9Jhj
 jIZmIOXNPCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ7/NBgAKCRCLPIo+Aiko
 1Zw0B/0X9T9NpQIFhPxEgci4pkI3GQTWUb6qpGsk+NLJ+A1v4NgpUypKdVr6srLGtwcdZp9i23h
 SfSAwiTWE/idrluzIasJ4sQsQ9f47F5gCpWRexmttiwyxpVcqLDGLcRYAsf3cQ/EgRAX0zV5cvO
 Kgy5Vk21qsHpeb8IAuDgsMg4Zb+DZUhYt1Eo+Pl2rOGmXdG28FirbFGS30IwPlvlRiCHaMjZwpu
 4VBIGuT0UUjf+YG2UL7uIKH56gpgkMQC07+VlNui77Q07EOWZ+bQOX1o5TMu0qctVaLs6M5DcpS
 zWMcqMFEDrW91UvPDrvkDkmXXnsV/QgCWDnIsVV/BSEJP6Gy
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The LVDS/LCDC controller uses pixel clock coming from the multimedia
controller (mmcc) rather than using the PLL directly. Stop using LVDS
PLL directly and register it as a clock provider. Use lcdc_clk as a
pixel clock for the LCDC.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
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


