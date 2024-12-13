Return-Path: <linux-kernel+bounces-445637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7E89F18CA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 23:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E581188EE78
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 22:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9688B1F5419;
	Fri, 13 Dec 2024 22:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o+cRg6E5"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24981F4E3C
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 22:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734128126; cv=none; b=rSZRvaFk4Obcr0doghpR/85X1wLG2o1aTDRGnvrgIMLhnwpFUxcwY05wV82xA4QjmkFlDHXIJoI0bhHdBk05CkqHQjRgKTbCN1Osj/TnTdzLKWzDQwDQWpSwDqjISslcdh03bw8eu8CUNBLvfiqBykUVtBpD1I7cjmf2oPSHnmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734128126; c=relaxed/simple;
	bh=BFuUocNIEbtRzhVZ/XojtvV6XKk3tsBz1i2H2YTpADM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bJ1fOR7ky0iV9fjk79JH5biZKQ/TjliIlUbb13CGF2Y7tghGNNir/QgfXX83VS9XGS5RrJ+W+V+R8+g3hASfXyE6ilCBlpwC5ujM/HzImtMFmdpfrC4/m1eznDiBwuOv7z8Ef1/UN+oAu6tXRgebrUC+agZ+XK4aW/I1brInQ9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o+cRg6E5; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3022598e213so19696021fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 14:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734128121; x=1734732921; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LWAb5CV0jv+JeM1abCgj1WxWEYDqtB7g5abP/D2+O2A=;
        b=o+cRg6E5i+uMr4MGYeLAdq63/J7BjqOwPyEma1BGi8nYLIeOZQL8krO2Lk/uggLeJB
         S+WilnHRMMESI7trPjhdAdwSYAmoBb5VwLQureo49XlcF08lcYbUxThPj5ufYQ/Om+cl
         K8M2xVXMc71bjMa+j2iukbjJTBu/RLzLkKaQ2AOW7md7CBAhCJvXpMVxRJWUvHM7lCL+
         msy1B5iv9gW382zVOMmsA69UCkgK8yRz2URVx10g4tZHfiQ+GGS/2flZPp3gLSzt0uDl
         SeOsYc4Aecn91q+K/z8s8hUkGDiF1+WQ9myhtDB9/aRq0jww8xIJH9INm5gQZaz//MAd
         v6zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734128121; x=1734732921;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LWAb5CV0jv+JeM1abCgj1WxWEYDqtB7g5abP/D2+O2A=;
        b=EqBX9BrOp005qWPbYuhP8KexMQz+N+sMvSkvP6w69DHzrxnIwoDITHJ0mY83rDaj+2
         5HplPXIyoxHjCcGKM7zKrBM/rPIpmDSexmWIFNz0Mu8hkls4WL66imi57soMwXnLPZr2
         oSVMNFHJfxvVlBGGc6IZz3edWdGNEwW+pPSCktPePmJ15UBtM4K+MlWBtCiuiJRkmpvC
         b/rpyssNKyJa63FngAvVs648dtRB6R8R+tLs52QpVMZD3wXWgJRlNDJBinpwQI+u5roC
         ntwRb0OrCADIL83i7BiMVrf9449k+blBkandfR8IHX607AMkYp109YII7RLkAoNu7hTi
         sIRw==
X-Forwarded-Encrypted: i=1; AJvYcCWnzSdfcGik8GiFDKq0lf3MluOr1xpY+XZkNSNOPxRoNcd4nfPEMoanCZFA08MUJ+MW0ziTB8NcLSeZRaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YydCCrrLgvHoO60PQiQKnPtg2OJbys9RvzvO5IQoJV2iOCdd5jW
	vP5nUD26Z8Av2F/HLwmZWSOAvTBdlCmQRqkbDHksCOTE7z/c2+StY4ThEZBZBZg=
X-Gm-Gg: ASbGncsgytJkJx4hcWwCOnC/XMWx7YN3fV9JLSKeNaNJ6gvb5M5pQEPuEJRi9qSUGvE
	yTGZuC9Z6a6pKs1EqTgbO2EnMLv0XEU57VXRofc6V8Jr9NFraczwLyZDbtk1yZFWUrZmH7CjNGL
	ePr7/6Y55ACQoO+34ZADiPAn37kxpFLRECQ58KHEOBQS47dCJSdaYo68RKPvOfTnH7Mthi6GDxw
	Ak19SesDnqZJxK3zLdIR66DCLDmd84/AYT6AqaGIqgDngXhBnX+AGtUm8L1AG9F
X-Google-Smtp-Source: AGHT+IEaltvlL9BmWjUCLGOd1irXG5VV6ywGML1m8M91rmJooAS+TEY69anZYsFc5A4aIEgx+CnFcA==
X-Received: by 2002:a05:651c:b29:b0:302:1e65:f2a1 with SMTP id 38308e7fff4ca-302544489ecmr13306491fa.12.1734128120711;
        Fri, 13 Dec 2024 14:15:20 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-303441e0f43sm413451fa.125.2024.12.13.14.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 14:15:19 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 14 Dec 2024 00:14:35 +0200
Subject: [PATCH 19/35] drm/msm/dpu: get rid of DPU_PINGPONG_DITHER
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241214-dpu-drop-features-v1-19-988f0662cb7e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=37639;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=BFuUocNIEbtRzhVZ/XojtvV6XKk3tsBz1i2H2YTpADM=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnXLHGZOmaU9K1gL8S66cYf4+5J2YgbC2wNcKcs
 B1UhKSZbA+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ1yxxgAKCRCLPIo+Aiko
 1XZoB/9eNrJYm5QA5gXc9cwLTOgCTsbrK9JzXIbHsyX+kgeoDf18baH6nz6XdyZj0HOWA4emuK0
 UjWwIfdcA+mKDw2Ei/xU7Ye08X15Y/mxp1rYcHCYVafKq9bIf3p8QtzgxO2yFZNyggl7gaoF5ks
 jTa2SCQq3Q6KGqefOlPCwTdqotEH6Xnx+xkk4Pn8Qb3hPCmMohIqOKoEvxLFYKR8ZHdV7HtYEO/
 dAiEFrW9t2xi2hg1/hVXIG9w/Vsj1SG3yiNepEwm7UmmjwNOQyBwET+fcNGRSCSk2qhp3c9t2vp
 Z/Oa6zluaLLPyVvj1QnOYeT/VdG4SXL8JO/XUr0l8M/SGD1I
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Continue migration to the MDSS-revision based checks and replace
DPU_PINGPONG_DITHER feature bit with the core_major_ver >= 3 check.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_10_0_sm8650.h  | 10 ----------
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h  |  6 ++----
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_2_sdm660.h   |  6 ++----
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_3_sdm630.h   |  3 +--
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_4_0_sdm845.h   |  6 ++----
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h   |  6 ------
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h  |  6 ------
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_2_sm7150.h   |  4 ----
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_4_sm6125.h   |  2 --
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_0_sm8250.h   |  6 ------
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_2_sc7180.h   |  2 --
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_3_sm6115.h   |  1 -
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_4_sm6350.h   |  2 --
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_5_qcm2290.h  |  1 -
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_9_sm6375.h   |  1 -
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h   |  6 ------
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h   |  4 ----
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h |  6 ------
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_1_sm8450.h   |  8 --------
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_4_sa8775p.h  |  8 --------
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h   |  8 --------
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h |  8 --------
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c           |  9 ---------
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h           |  2 --
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c          |  2 +-
 25 files changed, 8 insertions(+), 115 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_10_0_sm8650.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_10_0_sm8650.h
index a9e149f28a0141646ad5d5264031dfa22e0588fb..080d1fb70a9af67b0616316885cf366aabbd848d 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_10_0_sm8650.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_10_0_sm8650.h
@@ -204,67 +204,57 @@ static const struct dpu_pingpong_cfg sm8650_pp[] = {
 	{
 		.name = "pingpong_0", .id = PINGPONG_0,
 		.base = 0x69000, .len = 0,
-		.features = BIT(DPU_PINGPONG_DITHER),
 		.sblk = &sc7280_pp_sblk,
 		.merge_3d = MERGE_3D_0,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 8),
 	}, {
 		.name = "pingpong_1", .id = PINGPONG_1,
 		.base = 0x6a000, .len = 0,
-		.features = BIT(DPU_PINGPONG_DITHER),
 		.sblk = &sc7280_pp_sblk,
 		.merge_3d = MERGE_3D_0,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 9),
 	}, {
 		.name = "pingpong_2", .id = PINGPONG_2,
 		.base = 0x6b000, .len = 0,
-		.features = BIT(DPU_PINGPONG_DITHER),
 		.sblk = &sc7280_pp_sblk,
 		.merge_3d = MERGE_3D_1,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 10),
 	}, {
 		.name = "pingpong_3", .id = PINGPONG_3,
 		.base = 0x6c000, .len = 0,
-		.features = BIT(DPU_PINGPONG_DITHER),
 		.sblk = &sc7280_pp_sblk,
 		.merge_3d = MERGE_3D_1,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 11),
 	}, {
 		.name = "pingpong_4", .id = PINGPONG_4,
 		.base = 0x6d000, .len = 0,
-		.features = BIT(DPU_PINGPONG_DITHER),
 		.sblk = &sc7280_pp_sblk,
 		.merge_3d = MERGE_3D_2,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 30),
 	}, {
 		.name = "pingpong_5", .id = PINGPONG_5,
 		.base = 0x6e000, .len = 0,
-		.features = BIT(DPU_PINGPONG_DITHER),
 		.sblk = &sc7280_pp_sblk,
 		.merge_3d = MERGE_3D_2,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 31),
 	}, {
 		.name = "pingpong_6", .id = PINGPONG_6,
 		.base = 0x66000, .len = 0,
-		.features = BIT(DPU_PINGPONG_DITHER),
 		.sblk = &sc7280_pp_sblk,
 		.merge_3d = MERGE_3D_3,
 	}, {
 		.name = "pingpong_7", .id = PINGPONG_7,
 		.base = 0x66400, .len = 0,
-		.features = BIT(DPU_PINGPONG_DITHER),
 		.sblk = &sc7280_pp_sblk,
 		.merge_3d = MERGE_3D_3,
 	}, {
 		.name = "pingpong_8", .id = PINGPONG_8,
 		.base = 0x7e000, .len = 0,
-		.features = BIT(DPU_PINGPONG_DITHER),
 		.sblk = &sc7280_pp_sblk,
 		.merge_3d = MERGE_3D_4,
 	}, {
 		.name = "pingpong_9", .id = PINGPONG_9,
 		.base = 0x7e400, .len = 0,
-		.features = BIT(DPU_PINGPONG_DITHER),
 		.sblk = &sc7280_pp_sblk,
 		.merge_3d = MERGE_3D_4,
 	},
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h
index 94983781fbf957811dd5f4f7ee2f08ad4a06572a..2c37c609eb950787eb570e61c3f68e00c46e9d18 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h
@@ -170,28 +170,26 @@ static const struct dpu_pingpong_cfg msm8998_pp[] = {
 	{
 		.name = "pingpong_0", .id = PINGPONG_0,
 		.base = 0x70000, .len = 0xd4,
-		.features = PINGPONG_SDM845_TE2_MASK,
+		.features = BIT(DPU_PINGPONG_TE2),
 		.sblk = &sdm845_pp_sblk_te,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 8),
 		.intr_rdptr = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 12),
 	}, {
 		.name = "pingpong_1", .id = PINGPONG_1,
 		.base = 0x70800, .len = 0xd4,
-		.features = PINGPONG_SDM845_TE2_MASK,
+		.features = BIT(DPU_PINGPONG_TE2),
 		.sblk = &sdm845_pp_sblk_te,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 9),
 		.intr_rdptr = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 13),
 	}, {
 		.name = "pingpong_2", .id = PINGPONG_2,
 		.base = 0x71000, .len = 0xd4,
-		.features = PINGPONG_SDM845_MASK,
 		.sblk = &sdm845_pp_sblk,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 10),
 		.intr_rdptr = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 14),
 	}, {
 		.name = "pingpong_3", .id = PINGPONG_3,
 		.base = 0x71800, .len = 0xd4,
-		.features = PINGPONG_SDM845_MASK,
 		.sblk = &sdm845_pp_sblk,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 11),
 		.intr_rdptr = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 15),
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_2_sdm660.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_2_sdm660.h
index d9e9ba364832e253ca9d0d01e3e19e0f6ee11fa0..77d14bc4b9ce39c67c65891b825b240c937e2e42 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_2_sdm660.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_2_sdm660.h
@@ -141,28 +141,26 @@ static const struct dpu_pingpong_cfg sdm660_pp[] = {
 	{
 		.name = "pingpong_0", .id = PINGPONG_0,
 		.base = 0x70000, .len = 0xd4,
-		.features = PINGPONG_SDM845_TE2_MASK,
+		.features = BIT(DPU_PINGPONG_TE2),
 		.sblk = &sdm845_pp_sblk_te,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 8),
 		.intr_rdptr = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 12),
 	}, {
 		.name = "pingpong_1", .id = PINGPONG_1,
 		.base = 0x70800, .len = 0xd4,
-		.features = PINGPONG_SDM845_TE2_MASK,
+		.features = BIT(DPU_PINGPONG_TE2),
 		.sblk = &sdm845_pp_sblk_te,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 9),
 		.intr_rdptr = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 13),
 	}, {
 		.name = "pingpong_2", .id = PINGPONG_2,
 		.base = 0x71000, .len = 0xd4,
-		.features = PINGPONG_SDM845_MASK,
 		.sblk = &sdm845_pp_sblk,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 10),
 		.intr_rdptr = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 14),
 	}, {
 		.name = "pingpong_3", .id = PINGPONG_3,
 		.base = 0x71800, .len = 0xd4,
-		.features = PINGPONG_SDM845_MASK,
 		.sblk = &sdm845_pp_sblk,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 11),
 		.intr_rdptr = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 15),
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_3_sdm630.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_3_sdm630.h
index e7e7c7b95c34b2b5f91e33020a2e182eca9ba607..c134b5b39828bc5c8eadd21c3b03b0503520d478 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_3_sdm630.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_3_sdm630.h
@@ -115,14 +115,13 @@ static const struct dpu_pingpong_cfg sdm630_pp[] = {
 	{
 		.name = "pingpong_0", .id = PINGPONG_0,
 		.base = 0x70000, .len = 0xd4,
-		.features = PINGPONG_SDM845_TE2_MASK,
+		.features = BIT(DPU_PINGPONG_TE2),
 		.sblk = &sdm845_pp_sblk_te,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 8),
 		.intr_rdptr = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 12),
 	}, {
 		.name = "pingpong_2", .id = PINGPONG_2,
 		.base = 0x71000, .len = 0xd4,
-		.features = PINGPONG_SDM845_MASK,
 		.sblk = &sdm845_pp_sblk,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 10),
 		.intr_rdptr = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 14),
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_4_0_sdm845.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_4_0_sdm845.h
index f67990f87cbd4245ad019799614067d59befb920..ca41b9bc8fb4660cc30ca2f037cdadc10d985d1b 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_4_0_sdm845.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_4_0_sdm845.h
@@ -190,28 +190,26 @@ static const struct dpu_pingpong_cfg sdm845_pp[] = {
 	{
 		.name = "pingpong_0", .id = PINGPONG_0,
 		.base = 0x70000, .len = 0xd4,
-		.features = PINGPONG_SDM845_TE2_MASK,
+		.features = BIT(DPU_PINGPONG_TE2),
 		.sblk = &sdm845_pp_sblk_te,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 8),
 		.intr_rdptr = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 12),
 	}, {
 		.name = "pingpong_1", .id = PINGPONG_1,
 		.base = 0x70800, .len = 0xd4,
-		.features = PINGPONG_SDM845_TE2_MASK,
+		.features = BIT(DPU_PINGPONG_TE2),
 		.sblk = &sdm845_pp_sblk_te,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 9),
 		.intr_rdptr = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 13),
 	}, {
 		.name = "pingpong_2", .id = PINGPONG_2,
 		.base = 0x71000, .len = 0xd4,
-		.features = PINGPONG_SDM845_MASK,
 		.sblk = &sdm845_pp_sblk,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 10),
 		.intr_rdptr = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 14),
 	}, {
 		.name = "pingpong_3", .id = PINGPONG_3,
 		.base = 0x71800, .len = 0xd4,
-		.features = PINGPONG_SDM845_MASK,
 		.sblk = &sdm845_pp_sblk,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 11),
 		.intr_rdptr = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 15),
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h
index 03fce530db11eccebb96aa53311418c229caf45d..246f42727c842e7f6a718af5afa4afaf52b5a6a6 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h
@@ -208,42 +208,36 @@ static const struct dpu_pingpong_cfg sm8150_pp[] = {
 	{
 		.name = "pingpong_0", .id = PINGPONG_0,
 		.base = 0x70000, .len = 0xd4,
-		.features = PINGPONG_SM8150_MASK,
 		.sblk = &sdm845_pp_sblk,
 		.merge_3d = MERGE_3D_0,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 8),
 	}, {
 		.name = "pingpong_1", .id = PINGPONG_1,
 		.base = 0x70800, .len = 0xd4,
-		.features = PINGPONG_SM8150_MASK,
 		.sblk = &sdm845_pp_sblk,
 		.merge_3d = MERGE_3D_0,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 9),
 	}, {
 		.name = "pingpong_2", .id = PINGPONG_2,
 		.base = 0x71000, .len = 0xd4,
-		.features = PINGPONG_SM8150_MASK,
 		.sblk = &sdm845_pp_sblk,
 		.merge_3d = MERGE_3D_1,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 10),
 	}, {
 		.name = "pingpong_3", .id = PINGPONG_3,
 		.base = 0x71800, .len = 0xd4,
-		.features = PINGPONG_SM8150_MASK,
 		.sblk = &sdm845_pp_sblk,
 		.merge_3d = MERGE_3D_1,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 11),
 	}, {
 		.name = "pingpong_4", .id = PINGPONG_4,
 		.base = 0x72000, .len = 0xd4,
-		.features = PINGPONG_SM8150_MASK,
 		.sblk = &sdm845_pp_sblk,
 		.merge_3d = MERGE_3D_2,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 30),
 	}, {
 		.name = "pingpong_5", .id = PINGPONG_5,
 		.base = 0x72800, .len = 0xd4,
-		.features = PINGPONG_SM8150_MASK,
 		.sblk = &sdm845_pp_sblk,
 		.merge_3d = MERGE_3D_2,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 31),
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h
index bd906b832a0a83d7212048aaddbff66e43e9824b..8ab534493607339673a037c02445eaf567de0a81 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h
@@ -207,42 +207,36 @@ static const struct dpu_pingpong_cfg sc8180x_pp[] = {
 	{
 		.name = "pingpong_0", .id = PINGPONG_0,
 		.base = 0x70000, .len = 0xd4,
-		.features = PINGPONG_SM8150_MASK,
 		.sblk = &sdm845_pp_sblk,
 		.merge_3d = MERGE_3D_0,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 8),
 	}, {
 		.name = "pingpong_1", .id = PINGPONG_1,
 		.base = 0x70800, .len = 0xd4,
-		.features = PINGPONG_SM8150_MASK,
 		.sblk = &sdm845_pp_sblk,
 		.merge_3d = MERGE_3D_0,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 9),
 	}, {
 		.name = "pingpong_2", .id = PINGPONG_2,
 		.base = 0x71000, .len = 0xd4,
-		.features = PINGPONG_SM8150_MASK,
 		.sblk = &sdm845_pp_sblk,
 		.merge_3d = MERGE_3D_1,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 10),
 	}, {
 		.name = "pingpong_3", .id = PINGPONG_3,
 		.base = 0x71800, .len = 0xd4,
-		.features = PINGPONG_SM8150_MASK,
 		.sblk = &sdm845_pp_sblk,
 		.merge_3d = MERGE_3D_1,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 11),
 	}, {
 		.name = "pingpong_4", .id = PINGPONG_4,
 		.base = 0x72000, .len = 0xd4,
-		.features = PINGPONG_SM8150_MASK,
 		.sblk = &sdm845_pp_sblk,
 		.merge_3d = MERGE_3D_2,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 30),
 	}, {
 		.name = "pingpong_5", .id = PINGPONG_5,
 		.base = 0x72800, .len = 0xd4,
-		.features = PINGPONG_SM8150_MASK,
 		.sblk = &sdm845_pp_sblk,
 		.merge_3d = MERGE_3D_2,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 31),
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_2_sm7150.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_2_sm7150.h
index 399d6a4da3def08bae816d593d42e705b4922d59..a8d4837691fadcc34dbd6cd0d2c2f2fd6d19cb19 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_2_sm7150.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_2_sm7150.h
@@ -158,28 +158,24 @@ static const struct dpu_pingpong_cfg sm7150_pp[] = {
 	{
 		.name = "pingpong_0", .id = PINGPONG_0,
 		.base = 0x70000, .len = 0xd4,
-		.features = PINGPONG_SM8150_MASK,
 		.sblk = &sdm845_pp_sblk,
 		.merge_3d = MERGE_3D_0,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 8),
 	}, {
 		.name = "pingpong_1", .id = PINGPONG_1,
 		.base = 0x70800, .len = 0xd4,
-		.features = PINGPONG_SM8150_MASK,
 		.sblk = &sdm845_pp_sblk,
 		.merge_3d = MERGE_3D_0,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 9),
 	}, {
 		.name = "pingpong_2", .id = PINGPONG_2,
 		.base = 0x71000, .len = 0xd4,
-		.features = PINGPONG_SM8150_MASK,
 		.sblk = &sdm845_pp_sblk,
 		.merge_3d = MERGE_3D_1,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 10),
 	}, {
 		.name = "pingpong_3", .id = PINGPONG_3,
 		.base = 0x71800, .len = 0xd4,
-		.features = PINGPONG_SM8150_MASK,
 		.sblk = &sdm845_pp_sblk,
 		.merge_3d = MERGE_3D_1,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 11),
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_4_sm6125.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_4_sm6125.h
index f7855c425555d25da29cebbec72eb0172b421327..63fdaad2f38aa8157098351fc051b64a6167e45a 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_4_sm6125.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_4_sm6125.h
@@ -119,14 +119,12 @@ static const struct dpu_pingpong_cfg sm6125_pp[] = {
 	{
 		.name = "pingpong_0", .id = PINGPONG_0,
 		.base = 0x70000, .len = 0xd4,
-		.features = PINGPONG_SM8150_MASK,
 		.merge_3d = 0,
 		.sblk = &sdm845_pp_sblk,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 8),
 	}, {
 		.name = "pingpong_1", .id = PINGPONG_1,
 		.base = 0x70800, .len = 0xd4,
-		.features = PINGPONG_SM8150_MASK,
 		.merge_3d = 0,
 		.sblk = &sdm845_pp_sblk,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 9),
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_0_sm8250.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_0_sm8250.h
index 20f58f9d371efbc01ed2fc8f62d38d05b85a5c04..1f542c3fba6a8c3ddb5eafa6536a9206cd5a61ce 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_0_sm8250.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_0_sm8250.h
@@ -206,42 +206,36 @@ static const struct dpu_pingpong_cfg sm8250_pp[] = {
 	{
 		.name = "pingpong_0", .id = PINGPONG_0,
 		.base = 0x70000, .len = 0xd4,
-		.features = PINGPONG_SM8150_MASK,
 		.sblk = &sdm845_pp_sblk,
 		.merge_3d = MERGE_3D_0,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 8),
 	}, {
 		.name = "pingpong_1", .id = PINGPONG_1,
 		.base = 0x70800, .len = 0xd4,
-		.features = PINGPONG_SM8150_MASK,
 		.sblk = &sdm845_pp_sblk,
 		.merge_3d = MERGE_3D_0,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 9),
 	}, {
 		.name = "pingpong_2", .id = PINGPONG_2,
 		.base = 0x71000, .len = 0xd4,
-		.features = PINGPONG_SM8150_MASK,
 		.sblk = &sdm845_pp_sblk,
 		.merge_3d = MERGE_3D_1,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 10),
 	}, {
 		.name = "pingpong_3", .id = PINGPONG_3,
 		.base = 0x71800, .len = 0xd4,
-		.features = PINGPONG_SM8150_MASK,
 		.sblk = &sdm845_pp_sblk,
 		.merge_3d = MERGE_3D_1,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 11),
 	}, {
 		.name = "pingpong_4", .id = PINGPONG_4,
 		.base = 0x72000, .len = 0xd4,
-		.features = PINGPONG_SM8150_MASK,
 		.sblk = &sdm845_pp_sblk,
 		.merge_3d = MERGE_3D_2,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 30),
 	}, {
 		.name = "pingpong_5", .id = PINGPONG_5,
 		.base = 0x72800, .len = 0xd4,
-		.features = PINGPONG_SM8150_MASK,
 		.sblk = &sdm845_pp_sblk,
 		.merge_3d = MERGE_3D_2,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 31),
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_2_sc7180.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_2_sc7180.h
index 96c1ac91715a69c731555d9da4d4842a7a07c1ca..a72fdd76cca55ffba0e9b07e58d927a779275c09 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_2_sc7180.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_2_sc7180.h
@@ -111,14 +111,12 @@ static const struct dpu_pingpong_cfg sc7180_pp[] = {
 	{
 		.name = "pingpong_0", .id = PINGPONG_0,
 		.base = 0x70000, .len = 0xd4,
-		.features = PINGPONG_SM8150_MASK,
 		.sblk = &sdm845_pp_sblk,
 		.merge_3d = 0,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 8),
 	}, {
 		.name = "pingpong_1", .id = PINGPONG_1,
 		.base = 0x70800, .len = 0xd4,
-		.features = PINGPONG_SM8150_MASK,
 		.sblk = &sdm845_pp_sblk,
 		.merge_3d = 0,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 9),
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_3_sm6115.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_3_sm6115.h
index 0178ce52e84f355919241435f58c390234c16162..842505ab5c4a6555e0a3223804065e68a5a4e680 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_3_sm6115.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_3_sm6115.h
@@ -76,7 +76,6 @@ static const struct dpu_pingpong_cfg sm6115_pp[] = {
 	{
 		.name = "pingpong_0", .id = PINGPONG_0,
 		.base = 0x70000, .len = 0xd4,
-		.features = PINGPONG_SM8150_MASK,
 		.sblk = &sdm845_pp_sblk,
 		.merge_3d = 0,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 8),
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_4_sm6350.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_4_sm6350.h
index ac0386eaac8636b5e524a7b41cab0e02f8bf9ffa..0e4d78470d27f3c5aed8171278ffe5d9d4126174 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_4_sm6350.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_4_sm6350.h
@@ -119,14 +119,12 @@ static struct dpu_pingpong_cfg sm6350_pp[] = {
 	{
 		.name = "pingpong_0", .id = PINGPONG_0,
 		.base = 0x70000, .len = 0xd4,
-		.features = PINGPONG_SM8150_MASK,
 		.sblk = &sdm845_pp_sblk,
 		.merge_3d = 0,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 8),
 	}, {
 		.name = "pingpong_1", .id = PINGPONG_1,
 		.base = 0x70800, .len = 0xd4,
-		.features = PINGPONG_SM8150_MASK,
 		.sblk = &sdm845_pp_sblk,
 		.merge_3d = 0,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 9),
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_5_qcm2290.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_5_qcm2290.h
index 0b1740de2bff94f1818ab41c6bc713f16796c4a4..7087c3c2e728c51f070b67ab0f8039f74eb7da6c 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_5_qcm2290.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_5_qcm2290.h
@@ -76,7 +76,6 @@ static const struct dpu_pingpong_cfg qcm2290_pp[] = {
 	{
 		.name = "pingpong_0", .id = PINGPONG_0,
 		.base = 0x70000, .len = 0xd4,
-		.features = PINGPONG_SM8150_MASK,
 		.sblk = &sdm845_pp_sblk,
 		.merge_3d = 0,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 8),
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_9_sm6375.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_9_sm6375.h
index 19800f207bff3077c7ac57ad736eea533674ae20..a2fdbe39e4415c1da1da0517db2284f368bfa07b 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_9_sm6375.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_9_sm6375.h
@@ -78,7 +78,6 @@ static const struct dpu_pingpong_cfg sm6375_pp[] = {
 	{
 		.name = "pingpong_0", .id = PINGPONG_0,
 		.base = 0x70000, .len = 0xd4,
-		.features = PINGPONG_SM8150_MASK,
 		.sblk = &sdm845_pp_sblk,
 		.merge_3d = 0,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 8),
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h
index bf69eb5678a2d8228aff816ed8a1a91c329bf00b..afef232e2703118ab56f472557f78d53ae523553 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h
@@ -206,42 +206,36 @@ static const struct dpu_pingpong_cfg sm8350_pp[] = {
 	{
 		.name = "pingpong_0", .id = PINGPONG_0,
 		.base = 0x69000, .len = 0,
-		.features = BIT(DPU_PINGPONG_DITHER),
 		.sblk = &sc7280_pp_sblk,
 		.merge_3d = MERGE_3D_0,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 8),
 	}, {
 		.name = "pingpong_1", .id = PINGPONG_1,
 		.base = 0x6a000, .len = 0,
-		.features = BIT(DPU_PINGPONG_DITHER),
 		.sblk = &sc7280_pp_sblk,
 		.merge_3d = MERGE_3D_0,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 9),
 	}, {
 		.name = "pingpong_2", .id = PINGPONG_2,
 		.base = 0x6b000, .len = 0,
-		.features = BIT(DPU_PINGPONG_DITHER),
 		.sblk = &sc7280_pp_sblk,
 		.merge_3d = MERGE_3D_1,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 10),
 	}, {
 		.name = "pingpong_3", .id = PINGPONG_3,
 		.base = 0x6c000, .len = 0,
-		.features = BIT(DPU_PINGPONG_DITHER),
 		.sblk = &sc7280_pp_sblk,
 		.merge_3d = MERGE_3D_1,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 11),
 	}, {
 		.name = "pingpong_4", .id = PINGPONG_4,
 		.base = 0x6d000, .len = 0,
-		.features = BIT(DPU_PINGPONG_DITHER),
 		.sblk = &sc7280_pp_sblk,
 		.merge_3d = MERGE_3D_2,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 30),
 	}, {
 		.name = "pingpong_5", .id = PINGPONG_5,
 		.base = 0x6e000, .len = 0,
-		.features = BIT(DPU_PINGPONG_DITHER),
 		.sblk = &sc7280_pp_sblk,
 		.merge_3d = MERGE_3D_2,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 31),
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h
index 5f51e1d21d8420e13c2e7e6b6042839611697eb7..cb804516fa970c84bd91f41487d8a3223297f16e 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h
@@ -121,28 +121,24 @@ static const struct dpu_pingpong_cfg sc7280_pp[] = {
 	{
 		.name = "pingpong_0", .id = PINGPONG_0,
 		.base = 0x69000, .len = 0,
-		.features = BIT(DPU_PINGPONG_DITHER),
 		.sblk = &sc7280_pp_sblk,
 		.merge_3d = 0,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 8),
 	}, {
 		.name = "pingpong_1", .id = PINGPONG_1,
 		.base = 0x6a000, .len = 0,
-		.features = BIT(DPU_PINGPONG_DITHER),
 		.sblk = &sc7280_pp_sblk,
 		.merge_3d = 0,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 9),
 	}, {
 		.name = "pingpong_2", .id = PINGPONG_2,
 		.base = 0x6b000, .len = 0,
-		.features = BIT(DPU_PINGPONG_DITHER),
 		.sblk = &sc7280_pp_sblk,
 		.merge_3d = 0,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 10),
 	}, {
 		.name = "pingpong_3", .id = PINGPONG_3,
 		.base = 0x6c000, .len = 0,
-		.features = BIT(DPU_PINGPONG_DITHER),
 		.sblk = &sc7280_pp_sblk,
 		.merge_3d = 0,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 11),
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h
index 2099696c2886da0fe3a428b44ee0cd3a93be0785..7dda3cef9db2fff9f870d1767ac76f13fb8c9758 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h
@@ -208,42 +208,36 @@ static const struct dpu_pingpong_cfg sc8280xp_pp[] = {
 	{
 		.name = "pingpong_0", .id = PINGPONG_0,
 		.base = 0x69000, .len = 0,
-		.features = BIT(DPU_PINGPONG_DITHER),
 		.sblk = &sc7280_pp_sblk,
 		.merge_3d = MERGE_3D_0,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 8),
 	}, {
 		.name = "pingpong_1", .id = PINGPONG_1,
 		.base = 0x6a000, .len = 0,
-		.features = BIT(DPU_PINGPONG_DITHER),
 		.sblk = &sc7280_pp_sblk,
 		.merge_3d = MERGE_3D_0,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 9),
 	}, {
 		.name = "pingpong_2", .id = PINGPONG_2,
 		.base = 0x6b000, .len = 0,
-		.features = BIT(DPU_PINGPONG_DITHER),
 		.sblk = &sc7280_pp_sblk,
 		.merge_3d = MERGE_3D_1,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 10),
 	}, {
 		.name = "pingpong_3", .id = PINGPONG_3,
 		.base = 0x6c000, .len = 0,
-		.features = BIT(DPU_PINGPONG_DITHER),
 		.sblk = &sc7280_pp_sblk,
 		.merge_3d = MERGE_3D_1,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 11),
 	}, {
 		.name = "pingpong_4", .id = PINGPONG_4,
 		.base = 0x6d000, .len = 0,
-		.features = BIT(DPU_PINGPONG_DITHER),
 		.sblk = &sc7280_pp_sblk,
 		.merge_3d = MERGE_3D_2,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 30),
 	}, {
 		.name = "pingpong_5", .id = PINGPONG_5,
 		.base = 0x6e000, .len = 0,
-		.features = BIT(DPU_PINGPONG_DITHER),
 		.sblk = &sc7280_pp_sblk,
 		.merge_3d = MERGE_3D_2,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 31),
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_1_sm8450.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_1_sm8450.h
index 7b100f559ff307017b877824c7fe1e2254c92c06..a13207b556cd9d00c40d87b7e8c7247dcde54d63 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_1_sm8450.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_1_sm8450.h
@@ -209,55 +209,47 @@ static const struct dpu_pingpong_cfg sm8450_pp[] = {
 	{
 		.name = "pingpong_0", .id = PINGPONG_0,
 		.base = 0x69000, .len = 0,
-		.features = BIT(DPU_PINGPONG_DITHER),
 		.sblk = &sc7280_pp_sblk,
 		.merge_3d = MERGE_3D_0,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 8),
 	}, {
 		.name = "pingpong_1", .id = PINGPONG_1,
 		.base = 0x6a000, .len = 0,
-		.features = BIT(DPU_PINGPONG_DITHER),
 		.sblk = &sc7280_pp_sblk,
 		.merge_3d = MERGE_3D_0,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 9),
 	}, {
 		.name = "pingpong_2", .id = PINGPONG_2,
 		.base = 0x6b000, .len = 0,
-		.features = BIT(DPU_PINGPONG_DITHER),
 		.sblk = &sc7280_pp_sblk,
 		.merge_3d = MERGE_3D_1,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 10),
 	}, {
 		.name = "pingpong_3", .id = PINGPONG_3,
 		.base = 0x6c000, .len = 0,
-		.features = BIT(DPU_PINGPONG_DITHER),
 		.sblk = &sc7280_pp_sblk,
 		.merge_3d = MERGE_3D_1,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 11),
 	}, {
 		.name = "pingpong_4", .id = PINGPONG_4,
 		.base = 0x6d000, .len = 0,
-		.features = BIT(DPU_PINGPONG_DITHER),
 		.sblk = &sc7280_pp_sblk,
 		.merge_3d = MERGE_3D_2,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 30),
 	}, {
 		.name = "pingpong_5", .id = PINGPONG_5,
 		.base = 0x6e000, .len = 0,
-		.features = BIT(DPU_PINGPONG_DITHER),
 		.sblk = &sc7280_pp_sblk,
 		.merge_3d = MERGE_3D_2,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 31),
 	}, {
 		.name = "pingpong_6", .id = PINGPONG_6,
 		.base = 0x65800, .len = 0,
-		.features = BIT(DPU_PINGPONG_DITHER),
 		.sblk = &sc7280_pp_sblk,
 		.merge_3d = MERGE_3D_3,
 	}, {
 		.name = "pingpong_7", .id = PINGPONG_7,
 		.base = 0x65c00, .len = 0,
-		.features = BIT(DPU_PINGPONG_DITHER),
 		.sblk = &sc7280_pp_sblk,
 		.merge_3d = MERGE_3D_3,
 	},
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_4_sa8775p.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_4_sa8775p.h
index f9f77da8630c2c48f7519bf774633ad9b3635736..6baa0592f91ead9d789d6cde189abcc572460d20 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_4_sa8775p.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_4_sa8775p.h
@@ -208,55 +208,47 @@ static const struct dpu_pingpong_cfg sa8775p_pp[] = {
 	{
 		.name = "pingpong_0", .id = PINGPONG_0,
 		.base = 0x69000, .len = 0,
-		.features = BIT(DPU_PINGPONG_DITHER),
 		.sblk = &sc7280_pp_sblk,
 		.merge_3d = MERGE_3D_0,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 8),
 	}, {
 		.name = "pingpong_1", .id = PINGPONG_1,
 		.base = 0x6a000, .len = 0,
-		.features = BIT(DPU_PINGPONG_DITHER),
 		.sblk = &sc7280_pp_sblk,
 		.merge_3d = MERGE_3D_0,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 9),
 	}, {
 		.name = "pingpong_2", .id = PINGPONG_2,
 		.base = 0x6b000, .len = 0,
-		.features = BIT(DPU_PINGPONG_DITHER),
 		.sblk = &sc7280_pp_sblk,
 		.merge_3d = MERGE_3D_1,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 10),
 	}, {
 		.name = "pingpong_3", .id = PINGPONG_3,
 		.base = 0x6c000, .len = 0,
-		.features = BIT(DPU_PINGPONG_DITHER),
 		.sblk = &sc7280_pp_sblk,
 		.merge_3d = MERGE_3D_1,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 11),
 	}, {
 		.name = "pingpong_4", .id = PINGPONG_4,
 		.base = 0x6d000, .len = 0,
-		.features = BIT(DPU_PINGPONG_DITHER),
 		.sblk = &sc7280_pp_sblk,
 		.merge_3d = MERGE_3D_2,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 30),
 	}, {
 		.name = "pingpong_5", .id = PINGPONG_5,
 		.base = 0x6e000, .len = 0,
-		.features = BIT(DPU_PINGPONG_DITHER),
 		.sblk = &sc7280_pp_sblk,
 		.merge_3d = MERGE_3D_2,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 31),
 	}, {
 		.name = "pingpong_6", .id = PINGPONG_6,
 		.base = 0x65800, .len = 0,
-		.features = BIT(DPU_PINGPONG_DITHER),
 		.sblk = &sc7280_pp_sblk,
 		.merge_3d = MERGE_3D_3,
 	}, {
 		.name = "pingpong_7", .id = PINGPONG_7,
 		.base = 0x65c00, .len = 0,
-		.features = BIT(DPU_PINGPONG_DITHER),
 		.sblk = &sc7280_pp_sblk,
 		.merge_3d = MERGE_3D_3,
 	},
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h
index 94a163f93f9508acf7156581a47e8601685ce4ef..be17b04c2a15f04cde4bf5afc122d279aa04231c 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h
@@ -203,55 +203,47 @@ static const struct dpu_pingpong_cfg sm8550_pp[] = {
 	{
 		.name = "pingpong_0", .id = PINGPONG_0,
 		.base = 0x69000, .len = 0,
-		.features = BIT(DPU_PINGPONG_DITHER),
 		.sblk = &sc7280_pp_sblk,
 		.merge_3d = MERGE_3D_0,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 8),
 	}, {
 		.name = "pingpong_1", .id = PINGPONG_1,
 		.base = 0x6a000, .len = 0,
-		.features = BIT(DPU_PINGPONG_DITHER),
 		.sblk = &sc7280_pp_sblk,
 		.merge_3d = MERGE_3D_0,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 9),
 	}, {
 		.name = "pingpong_2", .id = PINGPONG_2,
 		.base = 0x6b000, .len = 0,
-		.features = BIT(DPU_PINGPONG_DITHER),
 		.sblk = &sc7280_pp_sblk,
 		.merge_3d = MERGE_3D_1,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 10),
 	}, {
 		.name = "pingpong_3", .id = PINGPONG_3,
 		.base = 0x6c000, .len = 0,
-		.features = BIT(DPU_PINGPONG_DITHER),
 		.sblk = &sc7280_pp_sblk,
 		.merge_3d = MERGE_3D_1,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 11),
 	}, {
 		.name = "pingpong_4", .id = PINGPONG_4,
 		.base = 0x6d000, .len = 0,
-		.features = BIT(DPU_PINGPONG_DITHER),
 		.sblk = &sc7280_pp_sblk,
 		.merge_3d = MERGE_3D_2,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 30),
 	}, {
 		.name = "pingpong_5", .id = PINGPONG_5,
 		.base = 0x6e000, .len = 0,
-		.features = BIT(DPU_PINGPONG_DITHER),
 		.sblk = &sc7280_pp_sblk,
 		.merge_3d = MERGE_3D_2,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 31),
 	}, {
 		.name = "pingpong_6", .id = PINGPONG_6,
 		.base = 0x66000, .len = 0,
-		.features = BIT(DPU_PINGPONG_DITHER),
 		.sblk = &sc7280_pp_sblk,
 		.merge_3d = MERGE_3D_3,
 	}, {
 		.name = "pingpong_7", .id = PINGPONG_7,
 		.base = 0x66400, .len = 0,
-		.features = BIT(DPU_PINGPONG_DITHER),
 		.sblk = &sc7280_pp_sblk,
 		.merge_3d = MERGE_3D_3,
 	},
diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h
index 6060732dfbeee77eb3a7842ca79045926e616e05..ba30615b6187328d99b1f299994ca737c9f92e7e 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h
@@ -203,55 +203,47 @@ static const struct dpu_pingpong_cfg x1e80100_pp[] = {
 	{
 		.name = "pingpong_0", .id = PINGPONG_0,
 		.base = 0x69000, .len = 0,
-		.features = BIT(DPU_PINGPONG_DITHER),
 		.sblk = &sc7280_pp_sblk,
 		.merge_3d = MERGE_3D_0,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 8),
 	}, {
 		.name = "pingpong_1", .id = PINGPONG_1,
 		.base = 0x6a000, .len = 0,
-		.features = BIT(DPU_PINGPONG_DITHER),
 		.sblk = &sc7280_pp_sblk,
 		.merge_3d = MERGE_3D_0,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 9),
 	}, {
 		.name = "pingpong_2", .id = PINGPONG_2,
 		.base = 0x6b000, .len = 0,
-		.features = BIT(DPU_PINGPONG_DITHER),
 		.sblk = &sc7280_pp_sblk,
 		.merge_3d = MERGE_3D_1,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 10),
 	}, {
 		.name = "pingpong_3", .id = PINGPONG_3,
 		.base = 0x6c000, .len = 0,
-		.features = BIT(DPU_PINGPONG_DITHER),
 		.sblk = &sc7280_pp_sblk,
 		.merge_3d = MERGE_3D_1,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 11),
 	}, {
 		.name = "pingpong_4", .id = PINGPONG_4,
 		.base = 0x6d000, .len = 0,
-		.features = BIT(DPU_PINGPONG_DITHER),
 		.sblk = &sc7280_pp_sblk,
 		.merge_3d = MERGE_3D_2,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 30),
 	}, {
 		.name = "pingpong_5", .id = PINGPONG_5,
 		.base = 0x6e000, .len = 0,
-		.features = BIT(DPU_PINGPONG_DITHER),
 		.sblk = &sc7280_pp_sblk,
 		.merge_3d = MERGE_3D_2,
 		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 31),
 	}, {
 		.name = "pingpong_6", .id = PINGPONG_6,
 		.base = 0x66000, .len = 0,
-		.features = BIT(DPU_PINGPONG_DITHER),
 		.sblk = &sc7280_pp_sblk,
 		.merge_3d = MERGE_3D_3,
 	}, {
 		.name = "pingpong_7", .id = PINGPONG_7,
 		.base = 0x66400, .len = 0,
-		.features = BIT(DPU_PINGPONG_DITHER),
 		.sblk = &sc7280_pp_sblk,
 		.merge_3d = MERGE_3D_3,
 	},
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
index 3f9e0045d8d6268304a2d85ebf8d86db373a3028..1cc305ebf74ebdf5100f75675126de252563d5cc 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
@@ -95,15 +95,6 @@
 #define MIXER_QCM2290_MASK \
 	(BIT(DPU_DIM_LAYER) | BIT(DPU_MIXER_COMBINED_ALPHA))
 
-#define PINGPONG_SDM845_MASK \
-	(BIT(DPU_PINGPONG_DITHER))
-
-#define PINGPONG_SDM845_TE2_MASK \
-	(PINGPONG_SDM845_MASK | BIT(DPU_PINGPONG_TE2))
-
-#define PINGPONG_SM8150_MASK \
-	(BIT(DPU_PINGPONG_DITHER))
-
 #define WB_SDM845_MASK (BIT(DPU_WB_LINE_MODE) | \
 			 BIT(DPU_WB_UBWC) | \
 			 BIT(DPU_WB_YUV_CONFIG) | \
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
index bef98e3471d4c8530e6a0fa35c8be207e080bd6c..5c389add6ac02deabb7759b5330bff0c1c39026e 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
@@ -118,14 +118,12 @@ enum {
  * @DPU_PINGPONG_TE2        Additional tear check block for split pipes
  * @DPU_PINGPONG_SPLIT      PP block supports split fifo
  * @DPU_PINGPONG_SLAVE      PP block is a suitable slave for split fifo
- * @DPU_PINGPONG_DITHER     Dither blocks
  * @DPU_PINGPONG_MAX
  */
 enum {
 	DPU_PINGPONG_TE2 = 0x1,
 	DPU_PINGPONG_SPLIT,
 	DPU_PINGPONG_SLAVE,
-	DPU_PINGPONG_DITHER,
 	DPU_PINGPONG_MAX
 };
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c
index 49e03ecee9e8b567a3f809b977deb83731006ac0..138071be56496da9fdcaff902f68ebb09a212e2e 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c
@@ -325,7 +325,7 @@ struct dpu_hw_pingpong *dpu_hw_pingpong_init(struct drm_device *dev,
 		c->ops.disable_dsc = dpu_hw_pp_dsc_disable;
 	}
 
-	if (test_bit(DPU_PINGPONG_DITHER, &cfg->features))
+	if (mdss_rev->core_major_ver >= 3)
 		c->ops.setup_dither = dpu_hw_pp_setup_dither;
 
 	return c;

-- 
2.39.5


