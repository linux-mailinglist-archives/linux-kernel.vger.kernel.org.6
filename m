Return-Path: <linux-kernel+bounces-445640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5839F18D0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 23:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1EE1188EF06
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 22:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4541F6661;
	Fri, 13 Dec 2024 22:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="esEiowIy"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23401F542C
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 22:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734128132; cv=none; b=hScqMxO6npURVSPKwCcTe8wNP6BBpBiitOp/hS5Vy8KeimC1kosHeCE+uFLawzMF67i9aCqdcQlCuZ0EN8rRs+jPDbL+RRW8XovZZ5L16FInnzZ0ql/JqlCVIwlY/XQu/U5qaEYx8sdzU7arfpk+FWqlf3fC/wkU0wfJrzoiZL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734128132; c=relaxed/simple;
	bh=oI4Xmovs4LivMfNkpbUHThe5kQZb5G9zfJ7jDno5uJE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u/G8UnLtEVrEAdlYhbAS/91aPRmB26TXIEc1qwDS99lmDepHTsksGhT4v+QOfLcQ5xVOIXvQDiU+5ixNlVEO9NhyemVFS0oJQQDN7g/YgP52N1BCg87G4iShFtTwMjCCoDngEURiYhw6GDFFgFpRzhT4sSYzXhVS197Pd6jV+CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=esEiowIy; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f7657f9f62so18342271fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 14:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734128128; x=1734732928; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=chVhsad0nyWoDCjTbYyZx4KJLlPYPuHtPpH/BD0TAQQ=;
        b=esEiowIynKzxYkJKrR+j/5o1Aek9NFGYgVUoRsU2sDD2rX8KpmSe0qEYO0wnjrbOKs
         BKqY1cGbyoCTLEFmlDxP4a3EZeG8vO6sAJ8cIaPPpQ2t5Lgsyp91IbUyzQaG31fDJd0m
         AQMdA9nuiOCBgUH5KcFkyQx4aAlC23aieDKBlJCpasoKyxofa/k2nGFmuvCwaOwMxYRD
         1yBHAXo0RyuZCGO2yTys8afwsdOLV99N5QJZjeZ9Q/WBq07O0U5UEgjHmEUE2nxhmVNC
         b5eoJZseABkNmcRsIHpOcZnJMrv+C2oP2Y93266fByK2QpmumEGZDzgcJazQngxOhd59
         ymmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734128128; x=1734732928;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=chVhsad0nyWoDCjTbYyZx4KJLlPYPuHtPpH/BD0TAQQ=;
        b=XIzvADg4YzettvZRCQVPiTRWiLniyMgiNa0WUO8Ak2/OToYKcyHZ4ptVqT8eTrkrKv
         bpie7k91nqLFdB+zFu8n+xr81+47bQp4ZW8ib8VBm4SIpRmPCZpoCeHf8/eo9CpHPMVG
         VzwSQMMCxICcLjX8oxzi3tmL8OBUK/F5Dgw0CwDkvqUNazKYEPol0RxXmxbHkFP0Zlch
         RvKl2UiZFP8kxLR4oNSleFj02qLbjIbN2MoCiL8vgef45VxiGxO39P/+ZiDMGiQvC8Uq
         f9zvSkGTSh0vwe7+kRRgI/B6/WdnEx9jupuNi8BaofbLjwHRl2EXXBx1AI0PVBZeKV/j
         GnQw==
X-Forwarded-Encrypted: i=1; AJvYcCUhcYCSdbM1sIc1ALbletKkznQwLZbtrg1RVVor3UpIym4sGVQrgWmCyH3laRH5itLk6C6d4y9MJHCKEek=@vger.kernel.org
X-Gm-Message-State: AOJu0YwED0W+xTJwP58N/S1bPgkrbERt3wpFr+6deHFaAGvECR15OsqH
	GV4Q2chVm21kxC2Q9Yd/XTWwdPi1S7Y3Nr8RgRItWR9tKj4t4COIHATiSbKNOV0=
X-Gm-Gg: ASbGnct0NTaUi6W4OizmPw8SLIiiVkfzwTMKa4nfj17rtoj2NYexFh8iofeeszy/+BS
	8pTTsYEZY228YHjSds/IEhcbbJYhdh5PfIurJmS/THgnwRh1tQTdXl1scMY1mzamwGvoC5ffIfA
	1Q7gJiFbo2bKEI++TLMmKDKqmZ55E3ZYHnln9/VF9alBn6+oRWL7ZNathXtQnFpi48Z8D2A5F8H
	DTGugJT+kWY0Hs4DcOT/Y8nEpZsj2CRNU2rV7WuXh4r7gY97Iok51tMnSbtF3Gr
X-Google-Smtp-Source: AGHT+IEPslOEXU1HExpx66RH9HFq1jjWfgiGfuKg/3qgcHoCTgG9FaEIZ5VSFqt2rANmbQbXPzVkxQ==
X-Received: by 2002:a05:6512:2342:b0:540:353a:df90 with SMTP id 2adb3069b0e04-540916d73eemr1400742e87.43.1734128127943;
        Fri, 13 Dec 2024 14:15:27 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-303441e0f43sm413451fa.125.2024.12.13.14.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 14:15:26 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 14 Dec 2024 00:14:38 +0200
Subject: [PATCH 22/35] drm/msm/dpu: get rid of DPU_MDP_AUDIO_SELECT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241214-dpu-drop-features-v1-22-988f0662cb7e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5292;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=oI4Xmovs4LivMfNkpbUHThe5kQZb5G9zfJ7jDno5uJE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnXLHHJ+i5CvqHnELCVIKy+3smmzEbJz8tTAX5j
 6L7XTPoCqmJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ1yxxwAKCRCLPIo+Aiko
 1WX1B/4uChS9rMYZOUUOZ0TcABKFH6w3S4l7MldTzoYy2PSOqHSlToi1ehzHpzQ8jsfKozoii3D
 P7oaBe8DyMMU7ODRy29SPKJqfMU0/dLTNzFNv0xMOSRj7rDeqw1HWd1wLaGGtOqYGFg4bgXmqJ0
 57469/48Kyogw7/AbSDwaZIJsTZQAvYZprudOdG8wbymPvpMxiSeNB7zdeHpYR2DHjVB6A4lvwU
 4Z0zSTKSw3wqMhmgHhDEtCY1dPxo5eF2jAIVpSxtff0yJkmmjYp4iFoB5ovrneRVufBNQJvx0El
 pkoPtWUJq5tukt0bE97bD7T7sEAhUTT4PTJ1b2AwxhkTeT57
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Continue migration to the MDSS-revision based checks and replace
DPU_MDP_AUDIO_SELECT feature bit with the core_major_ver == 8 ||
core_major_ver == 5 check.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_4_0_sdm845.h  | 1 -
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_4_1_sdm670.h  | 1 -
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h  | 1 -
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h | 1 -
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_2_sm7150.h  | 1 -
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h          | 1 -
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_top.c              | 3 ++-
 7 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_4_0_sdm845.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_4_0_sdm845.h
index 439c6c502d3a1d5279881f2c9798a20cda8fb428..946308eb7a88c1604b152ff98cb27b1766a76718 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_4_0_sdm845.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_4_0_sdm845.h
@@ -23,7 +23,6 @@ static const struct dpu_caps sdm845_dpu_caps = {
 static const struct dpu_mdp_cfg sdm845_mdp = {
 	.name = "top_0",
 	.base = 0x0, .len = 0x45c,
-	.features = BIT(DPU_MDP_AUDIO_SELECT),
 	.clk_ctrls = {
 		[DPU_CLK_CTRL_VIG0] = { .reg_off = 0x2ac, .bit_off = 0 },
 		[DPU_CLK_CTRL_VIG1] = { .reg_off = 0x2b4, .bit_off = 0 },
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_4_1_sdm670.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_4_1_sdm670.h
index cbbdaebe357ec4a82a3c3d950aa13792a1fb2d6e..a5b6e6610a34d6f744a6662b877588fa2e6fde7f 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_4_1_sdm670.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_4_1_sdm670.h
@@ -11,7 +11,6 @@
 static const struct dpu_mdp_cfg sdm670_mdp = {
 	.name = "top_0",
 	.base = 0x0, .len = 0x45c,
-	.features = BIT(DPU_MDP_AUDIO_SELECT),
 	.clk_ctrls = {
 		[DPU_CLK_CTRL_VIG0] = { .reg_off = 0x2ac, .bit_off = 0 },
 		[DPU_CLK_CTRL_VIG1] = { .reg_off = 0x2b4, .bit_off = 0 },
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h
index 246f42727c842e7f6a718af5afa4afaf52b5a6a6..d5e608402082cfc3cde8d156acdc85ee366af685 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h
@@ -23,7 +23,6 @@ static const struct dpu_caps sm8150_dpu_caps = {
 static const struct dpu_mdp_cfg sm8150_mdp = {
 	.name = "top_0",
 	.base = 0x0, .len = 0x45c,
-	.features = BIT(DPU_MDP_AUDIO_SELECT),
 	.clk_ctrls = {
 		[DPU_CLK_CTRL_VIG0] = { .reg_off = 0x2ac, .bit_off = 0 },
 		[DPU_CLK_CTRL_VIG1] = { .reg_off = 0x2b4, .bit_off = 0 },
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h
index 8ab534493607339673a037c02445eaf567de0a81..e3ea28c653328cf926a18426d12f07821c413b30 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h
@@ -23,7 +23,6 @@ static const struct dpu_caps sc8180x_dpu_caps = {
 static const struct dpu_mdp_cfg sc8180x_mdp = {
 	.name = "top_0",
 	.base = 0x0, .len = 0x45c,
-	.features = BIT(DPU_MDP_AUDIO_SELECT),
 	.clk_ctrls = {
 		[DPU_CLK_CTRL_VIG0] = { .reg_off = 0x2ac, .bit_off = 0 },
 		[DPU_CLK_CTRL_VIG1] = { .reg_off = 0x2b4, .bit_off = 0 },
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_2_sm7150.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_2_sm7150.h
index a8d4837691fadcc34dbd6cd0d2c2f2fd6d19cb19..a30b8906091d3ae72f2f9cdfc558942cab0a713f 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_2_sm7150.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_2_sm7150.h
@@ -23,7 +23,6 @@ static const struct dpu_caps sm7150_dpu_caps = {
 static const struct dpu_mdp_cfg sm7150_mdp = {
 	.name = "top_0",
 	.base = 0x0, .len = 0x45c,
-	.features = BIT(DPU_MDP_AUDIO_SELECT),
 	.clk_ctrls = {
 		[DPU_CLK_CTRL_VIG0] = { .reg_off = 0x2ac, .bit_off = 0 },
 		[DPU_CLK_CTRL_VIG1] = { .reg_off = 0x2b4, .bit_off = 0 },
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
index 8d03b33dc707497e5756d8632f267e925aeeea3a..c9d8caa2733ba701fe05c9b350b4a1468a573d9f 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
@@ -38,7 +38,6 @@
 enum {
 	DPU_MDP_PANIC_PER_PIPE = 0x1,
 	DPU_MDP_10BIT_SUPPORT,
-	DPU_MDP_AUDIO_SELECT,
 	DPU_MDP_MAX
 };
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_top.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_top.c
index c49a67da86b0d46d12c32466981be7f00519974c..5c811f0142d5e2a012d7e9b3a918818f22ec11cf 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_top.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_top.c
@@ -280,7 +280,8 @@ static void _setup_mdp_ops(struct dpu_hw_mdp_ops *ops,
 	if (mdss_rev->core_major_ver >= 5)
 		ops->dp_phy_intf_sel = dpu_hw_dp_phy_intf_sel;
 
-	if (cap & BIT(DPU_MDP_AUDIO_SELECT))
+	if (mdss_rev->core_major_ver == 4 ||
+	    mdss_rev->core_major_ver == 5)
 		ops->intf_audio_select = dpu_hw_intf_audio_select;
 }
 

-- 
2.39.5


