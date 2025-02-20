Return-Path: <linux-kernel+bounces-522929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B175DA3D038
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 04:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 853623B82E6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 03:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27A01D6199;
	Thu, 20 Feb 2025 03:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EClrv0cJ"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F9B1C6FF0
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 03:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740023974; cv=none; b=f2cuc86pBwKAh6dgB2iJpmEgNjoBT4ZdSNsEL85bIFOBoN+hJY2hSeBRyiJ11A9gwqdK1fuh4vdSD1c5yAZHIHTyCO8918UnojxQOS1+8aBz+DIqzVrutb4IND9sJc9ZIMVjM1iN1/+WZM60HHXCsi0g4wMyNV8T6Bhv3gYytgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740023974; c=relaxed/simple;
	bh=GNObJ2Uc82KNceelQcBkAhl4MJssNBmn9OFMj9GdoG8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bmlS2xFvdbAttZNlIV4pMGnIiliZlUPVzhFt0JMilTB1TE5wBKM1QVzTeq8JanEGpSk3chY6xdz+RfcyrDHVSGnefX40qbsNZtNZLu6mF/RmRmvNuLSmyfBt3JgsOP9CrCGSNDnRCGLek34NT5vfN6dNLw8JdC+FvjvLqPnmG3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EClrv0cJ; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-54298ec925bso917903e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 19:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740023970; x=1740628770; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1buqoTyS8LTS0FvAWXv9OjwwCEAG9Q8Buw04m6my9bk=;
        b=EClrv0cJTxj3hUIJHTBO+aLkZrUQeoLqsPuNC8lbnw7yvUXuKbe4LRIxNnSg/Mf1Aw
         P1HADAF09+X4S62kK0672giXBZYQwtVJgvFpSbzRulYv0SIYBZcN5EF1vTEGV5KL35HL
         +xUcr846Bw/voSdT4ESwaOl1tu86ORUff5DtZXTX1Pc21Cwp1+5C6oh6Rmnps3COphWd
         pHzdbW3vGe0Zo1kiNUxZnnWmjSimorkWzR5oppDecO09d3q/1lACBybOO4+zEF/vn6pn
         ojLnNMM74L7CyysJOSIIIR6xeEjbkyods79WQz2uJZQtLSlA38DjpUE7IuhjBo51mYFD
         99Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740023970; x=1740628770;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1buqoTyS8LTS0FvAWXv9OjwwCEAG9Q8Buw04m6my9bk=;
        b=TuyZHyxigDOk5PPPP3My2Jd5dgNFLosG1tFty0yZr4hpLlxHYQFdJ1hobqA42Z+1gq
         HvyjVJbT3NP9SzhK7VDUBe8Na6g1zUSqfvgd7pDgL2yOLVnkByhfl2xhQibLdR1l+y8E
         MQ59w5quY6hnZ0JtWh9pHXl3oA2hcrGrwF+TL57Np7mMjhu6yRv+pWihi7WFYALTPBFn
         rG0AkGGba6me0uD4NAU7ayIuEOTsVZSBO3O7QmJO8eBFyZ1xOzsUptxezmwJZzygWEPb
         I5XDLD5SGlygn/OoOy8RtY9Qweo7Jq4JGU2A776QoUqwGXtT7tKvy862XldRS8GcmtRC
         b/hg==
X-Forwarded-Encrypted: i=1; AJvYcCWi5H7Y4vC6EUPh/rn0qBwFaM7T+rOkKe98moz/kllGBcFQSUlk/7p1icRXQhTtXwooDyYahuplLDeMg1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPy8sQr1dQDzJgxCrFk1ecP5hLtwxurcO12ELv0/Y8Sg33Owsd
	ujU/6ry7+x7riIOmxMkPARAHKV0eG32O2GUc54IybhJYljGAfkT/NxsC/8cjpcw=
X-Gm-Gg: ASbGncvWWTMGe/B2eQ9zE6Pz0mkuP3Rf+VSpzKRk0QaFw69BtK+efE+FvThi7HnpRTE
	qVjxoJIYpTjFpr28ffCHFaCFHNbVAd0QJuxYn2goRezskj8VOgTvJVWwmCDx4zk2gm8ebi/BZFk
	tSWSqXkJQdtTUFUWpT66YaGGqGBJBNcDmbv+V1gIZQuU+E/LUUkG8vmfDXwBj7NzN4BvR6otSi+
	HKgDPpMHAEavsQTXfYqpe0lVPrWH1gN/GafboBCu7X07x+csHyuzxUWHhK3OpjRXC6P0DMNC9yh
	CC6DEle6cKdcRzIjm239dIY=
X-Google-Smtp-Source: AGHT+IFB5cN6OcdOISTIDzwCna44ZkJ5LDxYOgyNDXJJOJ+6bYILIa/mm9Rz5mRGFEMeDIU6b5l6uA==
X-Received: by 2002:a05:6512:2356:b0:545:27dc:64ca with SMTP id 2adb3069b0e04-5462ef19818mr2697703e87.33.1740023969994;
        Wed, 19 Feb 2025 19:59:29 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-545225f22ebsm2143909e87.16.2025.02.19.19.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 19:59:29 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 20 Feb 2025 05:59:22 +0200
Subject: [PATCH v2 1/5] drm/msm/dpu: rename CDM block definition
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-dpu-add-cdm-v2-1-77f5f0df3d9a@linaro.org>
References: <20250220-dpu-add-cdm-v2-0-77f5f0df3d9a@linaro.org>
In-Reply-To: <20250220-dpu-add-cdm-v2-0-77f5f0df3d9a@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3239;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=GNObJ2Uc82KNceelQcBkAhl4MJssNBmn9OFMj9GdoG8=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBntqidUq2n2lRLNlCrtDv6lB+4ZMDtYRBGU5i2e
 K1aGLmhE3eJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ7aonQAKCRCLPIo+Aiko
 1aAmB/9iC8sBodCCNsTdZwNmP+kdaeSGLaeeWPtf1IbiV7bMBzo5Pvz9DhNORb05OCZ5TyAf/WD
 ipEi11Wgp1+lZqs6F08BuwWfjNPutNErNaW1qHqPu5SxrBlDAzX/HXCfoagXqBq/TiJ9dkEJBKs
 z4zbozXCPJ5A20YQiHWXWV6BWeoYnK+CzNmrvck9HyTA0wzcX9wc/JKwUJn9PTqeHy7LlqniEoS
 XWzAqhEKZlH8GCn2MaYrm5MbrccNj9eN21HXm39zLPMwV641WGoQD+0tUHUz3y4VSdzA0gdLfx3
 SGrfSGlASywMQKW4H75Znr0/8g44MCwYVit+wlP7/P0keeRX
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The CDM block is not limited to SC7280, but it is common to all
platforms since DPU 5.x. Rename it from sc7280_cdm to
dpu_cdm_5_x.

Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_0_sm8250.h  | 2 +-
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h  | 2 +-
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_4_sa8775p.h | 2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c          | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_0_sm8250.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_0_sm8250.h
index e8916ae826a6daf30eb08de53521dae89c07636c..47e01c3c242f9a2ecb201b04be5effd7ff0d04b1 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_0_sm8250.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_0_sm8250.h
@@ -386,7 +386,7 @@ const struct dpu_mdss_cfg dpu_sm8250_cfg = {
 	.mdss_ver = &sm8250_mdss_ver,
 	.caps = &sm8250_dpu_caps,
 	.mdp = &sm8250_mdp,
-	.cdm = &sc7280_cdm,
+	.cdm = &dpu_cdm_5_x,
 	.ctl_count = ARRAY_SIZE(sm8250_ctl),
 	.ctl = sm8250_ctl,
 	.sspp_count = ARRAY_SIZE(sm8250_sspp),
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h
index 2f153e0b5c6a9e319657b99aa0954d9b190fe724..e9625c48c5677ef221b8fc80e7f9df8957b847e2 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h
@@ -248,7 +248,7 @@ const struct dpu_mdss_cfg dpu_sc7280_cfg = {
 	.mdss_ver = &sc7280_mdss_ver,
 	.caps = &sc7280_dpu_caps,
 	.mdp = &sc7280_mdp,
-	.cdm = &sc7280_cdm,
+	.cdm = &dpu_cdm_5_x,
 	.ctl_count = ARRAY_SIZE(sc7280_ctl),
 	.ctl = sc7280_ctl,
 	.sspp_count = ARRAY_SIZE(sc7280_sspp),
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_4_sa8775p.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_4_sa8775p.h
index 76ec72a323781363d37b62fec752ea1232bbd75b..4d96ce71746f2595427649d0fdb73dae0c18be60 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_4_sa8775p.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_4_sa8775p.h
@@ -458,7 +458,7 @@ const struct dpu_mdss_cfg dpu_sa8775p_cfg = {
 	.mdss_ver = &sa8775p_mdss_ver,
 	.caps = &sa8775p_dpu_caps,
 	.mdp = &sa8775p_mdp,
-	.cdm = &sc7280_cdm,
+	.cdm = &dpu_cdm_5_x,
 	.ctl_count = ARRAY_SIZE(sa8775p_ctl),
 	.ctl = sa8775p_ctl,
 	.sspp_count = ARRAY_SIZE(sa8775p_sspp),
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
index 0b342c043875f3329a9f71c5e751b2244f9f5ef7..ec7f42a334fc688bec468df490c81a89dd3d396d 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
@@ -507,7 +507,7 @@ static const struct dpu_dsc_sub_blks dsc_sblk_1 = {
 /*************************************************************
  * CDM block config
  *************************************************************/
-static const struct dpu_cdm_cfg sc7280_cdm = {
+static const struct dpu_cdm_cfg dpu_cdm_5_x = {
 	.name = "cdm_0",
 	.id = CDM_0,
 	.len = 0x228,

-- 
2.39.5


