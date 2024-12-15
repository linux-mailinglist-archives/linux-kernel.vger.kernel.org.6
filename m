Return-Path: <linux-kernel+bounces-445646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A2E9F18E1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 23:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F31E188BC65
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 22:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7131B219D;
	Fri, 13 Dec 2024 22:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ye4fYTwC"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254A41F7555
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 22:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734128143; cv=none; b=FJfhGvjCoZCjun/5wgLanU/KlndYJs32y7bmgyv6TiTEMDUAeK4FPCKX1KdeKIXyYC0Y0DMReAYTR16OVYRfdLCXsnZbtrmTdiSyi1G80aTx8BCtrbqrlKzmgVSbwLXlif2kVCLNDvM9jNS148iDZgMw71Rsm8RCoJ9+r1AW+mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734128143; c=relaxed/simple;
	bh=HDBIFP7lmEfohLRdZta0STJnvjaOfr4EoK+lXYqD0Wg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rQYYX2HIJgHYul/b2fcDJ+TAF/iiYRRBXgeH/7JiuXWsQwgYPUEbG9/9AmYB+VxtTdt+CJE0EtcA6Dteh1g6tWq10Mu+w3l8TEnmLmjQ4JDFA8we+YEfZJoe5pR/HL10HGNryWQ8H/K5uipX41rKn1xxjktoF4zCYTa0G9y3Yqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ye4fYTwC; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3022c6155edso21095421fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 14:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734128140; x=1734732940; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iLTQAtyScYm9lTcEQEHyFIdSvtVlHP7Xvdj3O1ACY4U=;
        b=ye4fYTwC8wWumOBuuvz5nkmNJTLWfxiADsw1paPf2F9JH5HDiUt2T9mI4+ASuOqhsr
         8h1zRa9/+6IavbIt+gPybgQzMX7NqWXocTF0zceONz4/JH+Yf1FxtYF2rKJwiMlMtUGJ
         QQiKTpbOiy9buEjeQSH4jbFp3omrEeZ8voMIJ5GtjOSyxEmq096b5VoOG7ALix8brDFG
         J3qUBFnbuZawE4gylqN69qk+UbkhlLz19b4LzV+UosTkuINZjsnKkjs7xzgtKUNzlzoZ
         G4kEp+1gf4RlHqDq15z93wfPhoui7lpCA91ztPD0xgs6Ag+GCK4MGiQQjX+oyFsaJ/cE
         DTUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734128140; x=1734732940;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iLTQAtyScYm9lTcEQEHyFIdSvtVlHP7Xvdj3O1ACY4U=;
        b=GME2VNR/Tuu0c2rxEYPZIeafPbwqIOIM80OTx70g7eDb6RgS/wMjl8733DiTUuRuY7
         NHF6bL7ns9K8b5Dp+zNJEvNx+KYm/UPZ2DU8vDI/2SIt7nelREXGslGB71XVc6pAbxlV
         U0SeYE8mFfsXLqplThUhiCh8puvRiiySY7yOp91edAoKbYPqFe7LzS94Kdy7EQMiFauI
         N9BWcNgphr0uhaIlJZ/q49eWGG/DitwmuIBtyDv0LPJ7sFP/jbWb74JvklzOiHS7o53q
         mHzdiq9+bYNE7PrzWAY92PDDx3mcrIEtM3/R3DQQQejep0519EvElTli46j/vRL7Frgy
         QWTA==
X-Forwarded-Encrypted: i=1; AJvYcCURSqdDLnpDHxQZFVVFsoFEKNwSFvxo7yfZ7gqinAzPH2X3ajAJbUZcblcgzf4ozojR9FQiNrbeBI6glj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnsSbkOp/RZXRljBZdHlEqnyT8v8IMBriPeEdGic/l872hUtwY
	+4+BJerLEA2/W+7/arYM49X4A9B0/k5/D9TBagNJBSAb4kpVFVrZ4uWjxa2GCJM=
X-Gm-Gg: ASbGncskpGwXmPOX0nPMHsNgyuw9WXNwnb7f5gE1JaSMI0PVcuKIsshLAQRjE06yocH
	dU93vSLLUtl5ShiBuWFAgZB88Eh4XRtNj5Z3I95ZlDT837Cv1G7lFM29bRQN4zFdTdqOxuBbITx
	VkSBa9JqBCYmlofazFmByqMMxvp36FnnguehremTbWF/noDKv0N+70qFIvW9lUkmgiT7PTC6gcr
	LGpqN9rqHTFVSN0gT3A1+l0lAHOq/PKEYLbMsEd289elz12HynBSB2UGKbqkQLM
X-Google-Smtp-Source: AGHT+IFcdnbaRwnw06KHXDrNDHefSXSslwZ6gIr92B7I01M2tDG8CS5kzToAHIMwe2uXJZg+G96CWg==
X-Received: by 2002:a05:651c:b0a:b0:300:324e:3504 with SMTP id 38308e7fff4ca-302544b10famr14181241fa.27.1734128140349;
        Fri, 13 Dec 2024 14:15:40 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-303441e0f43sm413451fa.125.2024.12.13.14.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 14:15:39 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 14 Dec 2024 00:14:44 +0200
Subject: [PATCH 28/35] drm/msm/dpu: get rid of DPU_SSPP_QOS_8LVL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241214-dpu-drop-features-v1-28-988f0662cb7e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3942;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=HDBIFP7lmEfohLRdZta0STJnvjaOfr4EoK+lXYqD0Wg=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnXLHIlv4aya34bmsQu0LbX/0HpWJVj5ThCnma/
 1TdbRItCBGJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ1yxyAAKCRCLPIo+Aiko
 1WRaB/4pnAW3brf4JPJfhdjbTwLCg9DaJSGmKWFZkYDkffxlD1HiJSQXH5b2BIkFDBL8nUF6KgT
 Dr4RTirbZ5jSmPLS4qcoHObGuQoSRQF6vvfeyW/oO2QfyJ308+xeA3MD+cN6BJrfcJ517EqhNeq
 nuJGK4aKZEO/+FaFkiiz4vVUjEFuzB9EVmJJudSEvWeFe6yXtQ/xn6+DBnG7VhfbYbIj/9DP3dK
 xBtkybDfFsG5yeHjWVJ88FyBbuFDtR+7S89dlqsbFE706/Dgt6TxFRWR9RO/7a0qXuKitTF28Ad
 o+PRJkzERJQpUIQAkBm3DSzqxbVdr1zkx4RtttWQStAXjCYZ
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Continue migration to the MDSS-revision based checks and replace
DPU_SSPP_QOS_8LVL feature bit with the core_major_ver >= 4 check.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c | 6 +++---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h | 2 --
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c    | 5 ++++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h    | 2 ++
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
index c23afdbad7b08abed2740e374be5bd89de206bf1..77187b6f5caa8c69498502d7b7e9c06b8d01fcb6 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
@@ -35,12 +35,12 @@
 	(VIG_MASK | BIT(DPU_SSPP_SCALER_QSEED3_COMPATIBLE))
 
 #define VIG_SDM845_MASK \
-	(VIG_MASK | BIT(DPU_SSPP_QOS_8LVL) | BIT(DPU_SSPP_SCALER_QSEED3_COMPATIBLE))
+	(VIG_MASK | BIT(DPU_SSPP_SCALER_QSEED3_COMPATIBLE))
 
 #define VIG_SDM845_MASK_SDMA \
 	(VIG_SDM845_MASK | BIT(DPU_SSPP_SMART_DMA_V2))
 
-#define VIG_QCM2290_MASK (VIG_BASE_MASK | BIT(DPU_SSPP_QOS_8LVL))
+#define VIG_QCM2290_MASK (VIG_BASE_MASK)
 
 #define DMA_MSM8953_MASK \
 	(BIT(DPU_SSPP_QOS))
@@ -60,7 +60,7 @@
 	(VIG_SC7280_MASK | BIT(DPU_SSPP_SMART_DMA_V2))
 
 #define DMA_SDM845_MASK \
-	(BIT(DPU_SSPP_QOS) | BIT(DPU_SSPP_QOS_8LVL) |\
+	(BIT(DPU_SSPP_QOS) | \
 	BIT(DPU_SSPP_TS_PREFILL) | BIT(DPU_SSPP_TS_PREFILL_REC1) |\
 	BIT(DPU_SSPP_CDP) | BIT(DPU_SSPP_EXCL_RECT))
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
index 06d1a467921ad53828fc4613d09e4fd766d10339..e1039b731604ef49958ff158d36e0aef97258ca4 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
@@ -50,7 +50,6 @@ enum {
  * @DPU_SSPP_CSC_10BIT,      Support of 10-bit Color space conversion
  * @DPU_SSPP_CURSOR,         SSPP can be used as a cursor layer
  * @DPU_SSPP_QOS,            SSPP support QoS control, danger/safe/creq
- * @DPU_SSPP_QOS_8LVL,       SSPP support 8-level QoS control
  * @DPU_SSPP_EXCL_RECT,      SSPP supports exclusion rect
  * @DPU_SSPP_SMART_DMA_V1,   SmartDMA 1.0 support
  * @DPU_SSPP_SMART_DMA_V2,   SmartDMA 2.0 support
@@ -68,7 +67,6 @@ enum {
 	DPU_SSPP_CSC_10BIT,
 	DPU_SSPP_CURSOR,
 	DPU_SSPP_QOS,
-	DPU_SSPP_QOS_8LVL,
 	DPU_SSPP_EXCL_RECT,
 	DPU_SSPP_SMART_DMA_V1,
 	DPU_SSPP_SMART_DMA_V2,
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c
index 32c7c80845533d720683dbcde3978d98f4972cce..7dfd0e0a779535e1f6b003f48188bc90d29d6853 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c
@@ -543,7 +543,7 @@ static void dpu_hw_sspp_setup_qos_lut(struct dpu_hw_sspp *ctx,
 		return;
 
 	_dpu_hw_setup_qos_lut(&ctx->hw, SSPP_DANGER_LUT,
-			      test_bit(DPU_SSPP_QOS_8LVL, &ctx->cap->features),
+			      ctx->mdss_ver->core_major_ver >= 4,
 			      cfg);
 }
 
@@ -703,6 +703,9 @@ struct dpu_hw_sspp *dpu_hw_sspp_init(struct drm_device *dev,
 	hw_pipe->ubwc = mdss_data;
 	hw_pipe->idx = cfg->id;
 	hw_pipe->cap = cfg;
+
+	hw_pipe->mdss_ver = mdss_rev;
+
 	_setup_layer_ops(hw_pipe, hw_pipe->cap->features, mdss_rev);
 
 	return hw_pipe;
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h
index 56a0edf2a57c6dcef7cddf4a1bcd6f6df5ad60f6..ed90e78d178a497ae7e2dc12b09a37c8a3f79621 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h
@@ -314,6 +314,8 @@ struct dpu_hw_sspp {
 	enum dpu_sspp idx;
 	const struct dpu_sspp_cfg *cap;
 
+	const struct dpu_mdss_version *mdss_ver;
+
 	/* Ops */
 	struct dpu_hw_sspp_ops ops;
 };

-- 
2.39.5


