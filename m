Return-Path: <linux-kernel+bounces-445641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D3D9F18D3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 23:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDB01188EF05
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 22:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8021F6684;
	Fri, 13 Dec 2024 22:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ml2yBJeC"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3491E1F63C6
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 22:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734128133; cv=none; b=XkFY8IVloV6zvFPubKaP8k/jPC4CGm8LBgCxodruor/RPPCK+vh8wayur+mI5Ls7dTio2lEKiRqUntTVA/zrSuaKAe2s0w/Y87/E8UIZQN2yRo4WpzTeWWhMkZ3oYShqEvVRtSBysOksNzg9uJuaE8qkHTAfUBJIRfjAdY+IIfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734128133; c=relaxed/simple;
	bh=9fqcGuW7RUjxl62c1UENs2blKOxQKmeP+sphSOK0D3E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HbrZOq+X+qy8eopcXnpGGxLu8vbI0gUGgfr6evfDvMcmoCaXCFEi37i4S3byGSrF/2ubdpd3BuFI80LvMZW4PZxHDivlGIofRMHZDzsW8+Ck3HX7C6ngpHLjv1Tcs54u3pfCye7zDsSTU+SyWF0bR8znJG995EWAMDSMV1/es0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ml2yBJeC; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3003c0c43c0so23519351fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 14:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734128129; x=1734732929; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sms4tMmU9NviiQ44hXwrWLxEDBnmh6FyfBa76RCBf2A=;
        b=Ml2yBJeCiE0CWBzcdTwSk+G19NZiJtgI+W6go8SEmajcSbkh2a09rPo6pe87Axt6Zo
         ZcNPkqW1nbnG9fm+npM8Hx8hDdmU1ZOFKtZiTpwmVbgif78DzOo7E3HXGX8tayV99OMT
         xAI157iWYbdQH3uQs5JqHrqdzSKndluyXDQMKHWQ2X/UVt5nFrROfWKHAty9ZoIw0tWi
         3shYuh2p+pZpjTeSpo5cfTFlY8yYjRn0+lQGmwr7R0DykP5MFy4gfTuSBPH4q/EshZ4X
         I3nWgezripzd5+GXHjJ/KY/Df6ZJ6GtuC+N4keEq6lYTOuSNIAtUdkk1XkHclmW19u2f
         Tk8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734128129; x=1734732929;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sms4tMmU9NviiQ44hXwrWLxEDBnmh6FyfBa76RCBf2A=;
        b=cxaghcuRdNH6QobbdYf/DUrKU+lfbP1ArGp8IGOXCHwhzKsUsINu+n1bD/9Vw4xgbZ
         1dm1ixtShu3rpAND0GedCzyhweTze607QybFppAIXUkT4pgweYBx3pTBnP1KPo3hF4iK
         sqKlNG7nifpbeUhJp797tXNrfJepDnkMge5qtDw3Gi2wKIWDq7cOq0GY7SBUiH+hoyFy
         sDQdrZ9Me8WnOA3xh7xbqHkHgrvDM/mnNqetcMFpKfiiB23JHFPgwtEAlMtFzxqqS+eT
         CvLacSJCwnqmIEeqxJNm6geEi4xDV565y6LVjw3AXmggLajSKF8oTlOAuFPqecvjA5S/
         VWpQ==
X-Forwarded-Encrypted: i=1; AJvYcCX28aJAVu88OebJl6Zqs3/eeZDB1p419qSDs46LR2/LEAJ/u4zhn7RxECxeDBBhAsQXup6soq+PjI6FcWI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym4UUrlhaDy8CcPD36r0qPEYFlfs4koVdtQfnQnnS9mrTDr+XD
	WlcuupJlplgLSbDTDAPkinS8t5+edx83gcIyyzZt+MYJxwwp6J25gYheA8E2cVY=
X-Gm-Gg: ASbGncuNCftowlw1UoELi15evuPrm3GJLMRL3nL06Oz/PfA4lDUAuqYM7geAP1jiEfu
	H+zTEC6r6rAE9y1CRlENtsPvNaRjWkBj5R2UrdCRTodK1bFIvpHdD10Roq9tHMD7XIO+LP5yIrm
	FfLapMXmIifyL5+FG8Bj4DLpYXDvlzV39L/Z53/SikJPdO4/1iPN1vkhgqpocmq78cxPMo8UIx3
	3hM78LzAqudqBJtrkbgnsdTQVMUldTtVUfM9OHGPd1letrPG5CyzaEMGn4iu4nD
X-Google-Smtp-Source: AGHT+IHRaReFo0mQuLr4zm6352tRbgTHkyjmq6+sLCaI9D847Aw+HWdORTznYnC5sjJm2IX/fYgVlg==
X-Received: by 2002:a05:651c:2221:b0:302:3021:9b29 with SMTP id 38308e7fff4ca-30254520703mr13079081fa.4.1734128129440;
        Fri, 13 Dec 2024 14:15:29 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-303441e0f43sm413451fa.125.2024.12.13.14.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 14:15:28 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 14 Dec 2024 00:14:39 +0200
Subject: [PATCH 23/35] drm/msm/dpu: get rid of DPU_MIXER_COMBINED_ALPHA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241214-dpu-drop-features-v1-23-988f0662cb7e@linaro.org>
References: <20241214-dpu-drop-features-v1-0-988f0662cb7e@linaro.org>
In-Reply-To: <20241214-dpu-drop-features-v1-0-988f0662cb7e@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Vinod Koul <vkoul@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4640;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=9fqcGuW7RUjxl62c1UENs2blKOxQKmeP+sphSOK0D3E=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ3rMxuO17OUS39PNY4tPrH8cNvfMwoTF+/mmsXitlxUK+
 FMqJpHdyWjMwsDIxSArpsjiU9AyNWZTctiHHVPrYQaxMoFMYeDiFICJnNVi/2ca3axw4tR3iQ9l
 E7jq609sMqtL4T15dlVjAWPkhfOODGVtexre8LJFzstbr5Yo+2DljsWSTMV10nsmW8TcifxR7bf
 UyvTU4klRDwpE1n7+Ex7784F5ntqjFssT27sOfysSDDp46O9hpte/Jr+23sTa1Xm6pUjoYKZs8N
 P09C9Xf2/9EBbVmKBsMbH/uutE5qqpjTI7fC/1Fqm0t1+awRbcdzTuUejr7mUpgoLBpWJ+TpPTX
 2h5p3Ft+i78aatkwtZABvU5wm2s4vvLOQObpIM3Bl379lh0RuGdCe4VGVyZy9nvHc+dnb2iqkVq
 oWJ5mUIZG+fmG0o9onYKqUe3+Am/9N76S0m4wWVX4s82AA==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Continue migration to the MDSS-revision based checks and replace
DPU_MIXER_COMBINED_ALPHA feature bit with the core_major_ver >= 4 check.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c | 4 ++--
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h | 2 --
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c      | 6 ++++--
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.h      | 3 ++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c         | 2 +-
 5 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
index 1cc305ebf74ebdf5100f75675126de252563d5cc..2107d0ed7f3606b3467796c298010651f6425b8d 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
@@ -90,10 +90,10 @@
 	(BIT(DPU_MIXER_SOURCESPLIT))
 
 #define MIXER_SDM845_MASK \
-	(BIT(DPU_MIXER_SOURCESPLIT) | BIT(DPU_DIM_LAYER) | BIT(DPU_MIXER_COMBINED_ALPHA))
+	(BIT(DPU_MIXER_SOURCESPLIT) | BIT(DPU_DIM_LAYER))
 
 #define MIXER_QCM2290_MASK \
-	(BIT(DPU_DIM_LAYER) | BIT(DPU_MIXER_COMBINED_ALPHA))
+	(BIT(DPU_DIM_LAYER))
 
 #define WB_SDM845_MASK (BIT(DPU_WB_LINE_MODE) | \
 			 BIT(DPU_WB_UBWC) | \
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
index c9d8caa2733ba701fe05c9b350b4a1468a573d9f..8b94ed395392a4ee43030e92d0b58baeb4d47dec 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
@@ -85,7 +85,6 @@ enum {
  * @DPU_MIXER_SOURCESPLIT     Layer mixer supports source-split configuration
  * @DPU_MIXER_GC              Gamma correction block
  * @DPU_DIM_LAYER             Layer mixer supports dim layer
- * @DPU_MIXER_COMBINED_ALPHA  Layer mixer has combined alpha register
  * @DPU_MIXER_MAX             maximum value
  */
 enum {
@@ -93,7 +92,6 @@ enum {
 	DPU_MIXER_SOURCESPLIT,
 	DPU_MIXER_GC,
 	DPU_DIM_LAYER,
-	DPU_MIXER_COMBINED_ALPHA,
 	DPU_MIXER_MAX
 };
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c
index 4f57cfca89bd3962e7e512952809db0300cb9baf..3bfb61cb83672dca4236bdbbbfb1e442223576d2 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c
@@ -150,10 +150,12 @@ static void dpu_hw_lm_setup_color3(struct dpu_hw_mixer *ctx,
  * @dev:  Corresponding device for devres management
  * @cfg:  mixer catalog entry for which driver object is required
  * @addr: mapped register io address of MDP
+ * @mdss_ver: DPU core's major and minor versions
  */
 struct dpu_hw_mixer *dpu_hw_lm_init(struct drm_device *dev,
 				    const struct dpu_lm_cfg *cfg,
-				    void __iomem *addr)
+				    void __iomem *addr,
+				    const struct dpu_mdss_version *mdss_ver)
 {
 	struct dpu_hw_mixer *c;
 
@@ -173,7 +175,7 @@ struct dpu_hw_mixer *dpu_hw_lm_init(struct drm_device *dev,
 	c->idx = cfg->id;
 	c->cap = cfg;
 	c->ops.setup_mixer_out = dpu_hw_lm_setup_out;
-	if (test_bit(DPU_MIXER_COMBINED_ALPHA, &c->cap->features))
+	if (mdss_ver->core_major_ver >= 4)
 		c->ops.setup_blend_config = dpu_hw_lm_setup_blend_config_combined_alpha;
 	else
 		c->ops.setup_blend_config = dpu_hw_lm_setup_blend_config;
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.h
index 6f60fa9b3cd78160699a97dc7a86a5ec0b599281..fff1156add683fec8ce6785e7fe1d769d0de3fe0 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.h
@@ -95,6 +95,7 @@ static inline struct dpu_hw_mixer *to_dpu_hw_mixer(struct dpu_hw_blk *hw)
 
 struct dpu_hw_mixer *dpu_hw_lm_init(struct drm_device *dev,
 				    const struct dpu_lm_cfg *cfg,
-				    void __iomem *addr);
+				    void __iomem *addr,
+				    const struct dpu_mdss_version *mdss_ver);
 
 #endif /*_DPU_HW_LM_H */
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
index c73596ddc7edfd8065c980d203632a0707d6fede..9dd240458ca707139ad68debd7f8162b3bf5ffc1 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
@@ -65,7 +65,7 @@ int dpu_rm_init(struct drm_device *dev,
 		struct dpu_hw_mixer *hw;
 		const struct dpu_lm_cfg *lm = &cat->mixer[i];
 
-		hw = dpu_hw_lm_init(dev, lm, mmio);
+		hw = dpu_hw_lm_init(dev, lm, mmio, cat->mdss_ver);
 		if (IS_ERR(hw)) {
 			rc = PTR_ERR(hw);
 			DPU_ERROR("failed lm object creation: err %d\n", rc);

-- 
2.39.5


