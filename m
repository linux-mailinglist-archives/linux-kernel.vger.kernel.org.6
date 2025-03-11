Return-Path: <linux-kernel+bounces-556804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32662A5CEDE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 20:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FBE5179C0B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADEF267720;
	Tue, 11 Mar 2025 19:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZCbOQ/0c"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198E52676F3
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 19:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741719781; cv=none; b=YXwWfUwX6wcdMw1vct3QyYxT2+qRKNg/8qVOQGOPU3ZMbV0ehMcN3mVehDcgecdJYFfT8aYv1c5BuBUHaOOZsp7rdMrULpUf1XQN9ffKF7dQwODzcpuHISRmbeQW6KtQasr7twvVxjHtGgpgc38+Q10QYJ7UXWvGKRhBDOkKYHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741719781; c=relaxed/simple;
	bh=D3FenUxWyYVnDqLP+XrRLYrtBXpjG5wjbY7SM7/k5O0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LrkQm/cd45Y85gXfXN8og9wC1nPBg0WDFZB+K1CZMqwcGY9X6TbPF2YzCB+uBEQL7Gyiuh4upaZCtOcJCwXb0gIzPZUZ2Vy58QTxjG5m781vNKjj6blGjYvCrziZGgKRMqp8ZgpTrjctQokwU8B9fYvXig2eguiCnJ38RGASowM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZCbOQ/0c; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43ce5cd91e5so3685235e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 12:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741719776; x=1742324576; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5aelgrZ1q59pQWPIsmZ64L6r7W99t+2sK1i/gngzuHw=;
        b=ZCbOQ/0cEu1rIuAFQocAGWCo+hlZIJEspGXMVm8QYm9+V+dUWnLeklQ6MiL0OnVZw5
         84VPrhlFUBVUkG6vCPQHHOTH+xbipLsG7OyaFXU88dTLLGYreFhp0NO7KyO7jlqi6ySn
         V5eSS+QXK+iuTmhe7yHEpuDLA85aRQRWCRLlUpi5GuBcoNYFJOHpGj19OE35z8BhAWhu
         2bvv6lQsf94knynd/+da2loWF/13/B21PWpZ/YddXRJJjndIWZcll8ROAaQl/xU/WOeK
         7qEC/qt4PYXpth7NEVnrfBqjwHgWg6p19DR0APtXTsR+ogYX39kNE2Zovzc0PDrDKFF4
         xqhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741719776; x=1742324576;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5aelgrZ1q59pQWPIsmZ64L6r7W99t+2sK1i/gngzuHw=;
        b=Pmo2hvU8RrUUOWuYouW4ahzh96mKAWKrcnQRis49MnH2wJZSnIxHu+Z27dvGKaQ3fi
         VWH1FZEcfVVdupzCAlGWoIRuCfkMeV+DPnQhkh9Vk/ytWoF+wg1ZmiXRYumDk/f9rVnV
         wEUfYLvdOp3tG1Mvv4if1wVH0vwR/aj7I3bJPh5HzySf7ju4vW73InZ56wcpo6+vO41r
         7ABirgANJAefb6rydofSjzLMOsLVKmQktyTLnP/pkvC8s87f+44DsvitxAP2bTt6a1ku
         uZgT7bHHwafiItVpUVm4k3r5bhCHl+M7s/nGyj4AVgSH4zLy+viPbckfXZ2/boGN+ZHn
         ZDnA==
X-Forwarded-Encrypted: i=1; AJvYcCUJK35EM7mpcMshcpDPfCyVPbsyrl+jv1sNDO1J/xbGJ86R1zajlN9Xb8tgp5tVTkSSnee2foWoA5/FVp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCoZ9BRNbv9Gm3A/4R+s9ACo3vA5y9hrm3nkhSbdGmjO2fBSvY
	9koqnrbXEvalMxEnLkmhUoz9AIbu8lYK3zBg1Pe5YQpPDwUVvSRgpduQ/CPW688=
X-Gm-Gg: ASbGnct4+Il91VtSwjW+62mP1oi5x9yOkEbxTGpk0CO1MSy2RxZXFLDM1vzXMkrqVUS
	dfmILN95UcU9jnMhmTF5AqK4QIpp8NQkQu91xJeR77GqXxOCLlbsnQVsRk+a4mQSDjqlnSKLdlT
	yexsK6tzEhdd6Oh141xfnWP0fMN93zjKZGV3vJL89XbJzj3H+e1mqnrI+PqbiQRo+aaw2LIH0Pu
	kktXFMICgmZnYgcDLid5g5lYNMhVmm54um5FeRzaerKoC4qiRkCemk8T05rj0ghTB+kYMFRaV0v
	w30Lt4kWL1Q9CXfro98QnV10X8qB0qgIOc9cP1Bv6tssndfokD5H8h8f1gs=
X-Google-Smtp-Source: AGHT+IGXvTlWmwQ8r5cx6+4J7hPISrnhf4ueEsao2v3OZQ7rioj7hQdecQQWq8Cr0P+vQ58cc0mGuA==
X-Received: by 2002:a05:600c:1c9a:b0:439:9a40:aa27 with SMTP id 5b1f17b1804b1-43d01c229c8mr23696165e9.5.1741719776252;
        Tue, 11 Mar 2025 12:02:56 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.198.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ce70d13b4sm127681155e9.38.2025.03.11.12.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 12:02:55 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 11 Mar 2025 20:02:05 +0100
Subject: [PATCH v4 15/19] drm/msm/dpu: Add support for SM8750
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-b4-sm8750-display-v4-15-da6b3e959c76@linaro.org>
References: <20250311-b4-sm8750-display-v4-0-da6b3e959c76@linaro.org>
In-Reply-To: <20250311-b4-sm8750-display-v4-0-da6b3e959c76@linaro.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krishna Manikandan <quic_mkrishn@quicinc.com>, 
 Jonathan Marek <jonathan@marek.ca>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Dmitry Baryshkov <lumag@kernel.org>, Rob Clark <robdclark@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
 Rob Clark <robdclark@chromium.org>, Dmitry Baryshkov <lumag@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=18849;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=D3FenUxWyYVnDqLP+XrRLYrtBXpjG5wjbY7SM7/k5O0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBn0Iiy3qaeODKxOseNorw1fthFjNSl2K7Nz7h6v
 hbLgHCNFwmJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ9CIsgAKCRDBN2bmhouD
 18OrEACETLg44sZv0DLYOZ6uRZ+9BipK7yURZKuJA6I9C6QPp0bOSf5F1Qe5vXR2sNOUO6lMtYM
 13MoX2mnmEwylzdUvh3uDxLBiLI6w3MszAKwgdKw0Uy0bABy/k039F9eM+6KNviEe2ro0GL+Xkz
 phtOb3A5dxLwy3hfqnMY1vZ3kq9g5q39CtMBvpbP2+5caZ/sAMTcdEWPsQtfgKuMzMu18XgsH1M
 GJLlzFP6o9T+bSVWMsLscq79MuLNCdKzIMZxPZDcIeTTQjKpFNaIxIPsJnHqnPoH2VemofwYLtu
 jVxW3FKiPlr3N29Lj056cQmuuji/2YuiIhKo4Exd0GZmmOHYIpjLKwzsgLLVXeerrGdfnWXZADc
 ViIiz7a/ZPQSWAVy6TWtuyf5QDflLT6tXY1r/sqwuM0hmzv50idseRXi5N73AZURykpj4yy5BNy
 yQYf7641vM8Ela++n0X+0GnCjj+3LT2hlrvw6FerRalO8xpypwAMez55j/1n/4+rN5pmVEQ7pXE
 fb30oHK/nT4AHWsZxuvVEIf0sY94je1nJGfTKb2AR7qgnJFq0TDPP7xP6wp9vVIreM4SrtNGAua
 +WsyCtgzQqGrkPrcF4PvxL2s8jJgWnaHK9UMwA/JB/Mv1b54NsrMwIScR+rI+aOSkJfbez75xLI
 o/Uwa3rwGTAh8rA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Add DPU version v12.0 support for the Qualcomm SM8750 platform.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Changes in v2:
1. Add CDM
---
 .../drm/msm/disp/dpu1/catalog/dpu_12_0_sm8750.h    | 496 +++++++++++++++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |  29 ++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |   1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |   1 +
 4 files changed, 527 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_12_0_sm8750.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_12_0_sm8750.h
new file mode 100644
index 0000000000000000000000000000000000000000..1f883b9f8b8b29e3a8c2fe254b78594a413dc2a1
--- /dev/null
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_12_0_sm8750.h
@@ -0,0 +1,496 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2025 Linaro Limited
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2015-2018, 2020 The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DPU_12_0_SM8750_H
+#define _DPU_12_0_SM8750_H
+
+static const struct dpu_caps sm8750_dpu_caps = {
+	.max_mixer_width = DEFAULT_DPU_OUTPUT_LINE_WIDTH,
+	.max_mixer_blendstages = 0xb,
+	.has_src_split = true,
+	.has_dim_layer = true,
+	.has_idle_pc = true,
+	.has_3d_merge = true,
+	.max_linewidth = 8192,
+	.pixel_ram_size = DEFAULT_PIXEL_RAM_SIZE,
+};
+
+static const struct dpu_mdp_cfg sm8750_mdp = {
+	.name = "top_0",
+	.base = 0, .len = 0x494,
+	.clk_ctrls = {
+		[DPU_CLK_CTRL_REG_DMA] = { .reg_off = 0x2bc, .bit_off = 20 },
+	},
+};
+
+static const struct dpu_ctl_cfg sm8750_ctl[] = {
+	{
+		.name = "ctl_0", .id = CTL_0,
+		.base = 0x15000, .len = 0x1000,
+		.has_split_display = 1,
+		.intr_start = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 9),
+	}, {
+		.name = "ctl_1", .id = CTL_1,
+		.base = 0x16000, .len = 0x1000,
+		.has_split_display = 1,
+		.intr_start = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 10),
+	}, {
+		.name = "ctl_2", .id = CTL_2,
+		.base = 0x17000, .len = 0x1000,
+		.intr_start = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 11),
+	}, {
+		.name = "ctl_3", .id = CTL_3,
+		.base = 0x18000, .len = 0x1000,
+		.intr_start = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 12),
+	}, {
+		.name = "ctl_4", .id = CTL_4,
+		.base = 0x19000, .len = 0x1000,
+		.intr_start = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 13),
+	}, {
+		.name = "ctl_5", .id = CTL_5,
+		.base = 0x1a000, .len = 0x1000,
+		.intr_start = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 23),
+	},
+};
+
+static const struct dpu_sspp_cfg sm8750_sspp[] = {
+	{
+		.name = "sspp_0", .id = SSPP_VIG0,
+		.base = 0x4000, .len = 0x344,
+		.features = VIG_SDM845_MASK_SDMA,
+		.sblk = &dpu_vig_sblk_qseed3_3_4,
+		.xin_id = 0,
+		.type = SSPP_TYPE_VIG,
+	}, {
+		.name = "sspp_1", .id = SSPP_VIG1,
+		.base = 0x6000, .len = 0x344,
+		.features = VIG_SDM845_MASK_SDMA,
+		.sblk = &dpu_vig_sblk_qseed3_3_4,
+		.xin_id = 4,
+		.type = SSPP_TYPE_VIG,
+	}, {
+		.name = "sspp_2", .id = SSPP_VIG2,
+		.base = 0x8000, .len = 0x344,
+		.features = VIG_SDM845_MASK_SDMA,
+		.sblk = &dpu_vig_sblk_qseed3_3_4,
+		.xin_id = 8,
+		.type = SSPP_TYPE_VIG,
+	}, {
+		.name = "sspp_3", .id = SSPP_VIG3,
+		.base = 0xa000, .len = 0x344,
+		.features = VIG_SDM845_MASK_SDMA,
+		.sblk = &dpu_vig_sblk_qseed3_3_4,
+		.xin_id = 12,
+		.type = SSPP_TYPE_VIG,
+	}, {
+		.name = "sspp_8", .id = SSPP_DMA0,
+		.base = 0x24000, .len = 0x344,
+		.features = DMA_SDM845_MASK_SDMA,
+		.sblk = &dpu_dma_sblk,
+		.xin_id = 1,
+		.type = SSPP_TYPE_DMA,
+	}, {
+		.name = "sspp_9", .id = SSPP_DMA1,
+		.base = 0x26000, .len = 0x344,
+		.features = DMA_SDM845_MASK_SDMA,
+		.sblk = &dpu_dma_sblk,
+		.xin_id = 5,
+		.type = SSPP_TYPE_DMA,
+	}, {
+		.name = "sspp_10", .id = SSPP_DMA2,
+		.base = 0x28000, .len = 0x344,
+		.features = DMA_SDM845_MASK_SDMA,
+		.sblk = &dpu_dma_sblk,
+		.xin_id = 9,
+		.type = SSPP_TYPE_DMA,
+	}, {
+		.name = "sspp_11", .id = SSPP_DMA3,
+		.base = 0x2a000, .len = 0x344,
+		.features = DMA_SDM845_MASK_SDMA,
+		.sblk = &dpu_dma_sblk,
+		.xin_id = 13,
+		.type = SSPP_TYPE_DMA,
+	}, {
+		.name = "sspp_12", .id = SSPP_DMA4,
+		.base = 0x2c000, .len = 0x344,
+		.features = DMA_CURSOR_SDM845_MASK_SDMA,
+		.sblk = &dpu_dma_sblk,
+		.xin_id = 14,
+		.type = SSPP_TYPE_DMA,
+	}, {
+		.name = "sspp_13", .id = SSPP_DMA5,
+		.base = 0x2e000, .len = 0x344,
+		.features = DMA_CURSOR_SDM845_MASK_SDMA,
+		.sblk = &dpu_dma_sblk,
+		.xin_id = 15,
+		.type = SSPP_TYPE_DMA,
+	},
+};
+
+static const struct dpu_lm_cfg sm8750_lm[] = {
+	{
+		.name = "lm_0", .id = LM_0,
+		.base = 0x44000, .len = 0x400,
+		.sourcesplit = 1,
+		.sblk = &sm8750_lm_sblk,
+		.lm_pair = LM_1,
+		.pingpong = PINGPONG_0,
+		.dspp = DSPP_0,
+	}, {
+		.name = "lm_1", .id = LM_1,
+		.base = 0x45000, .len = 0x400,
+		.sourcesplit = 1,
+		.sblk = &sm8750_lm_sblk,
+		.lm_pair = LM_0,
+		.pingpong = PINGPONG_1,
+		.dspp = DSPP_1,
+	}, {
+		.name = "lm_2", .id = LM_2,
+		.base = 0x46000, .len = 0x400,
+		.sourcesplit = 1,
+		.sblk = &sm8750_lm_sblk,
+		.lm_pair = LM_3,
+		.pingpong = PINGPONG_2,
+		.dspp = DSPP_2,
+	}, {
+		.name = "lm_3", .id = LM_3,
+		.base = 0x47000, .len = 0x400,
+		.sourcesplit = 1,
+		.sblk = &sm8750_lm_sblk,
+		.lm_pair = LM_2,
+		.pingpong = PINGPONG_3,
+		.dspp = DSPP_3,
+	}, {
+		.name = "lm_4", .id = LM_4,
+		.base = 0x48000, .len = 0x400,
+		.sourcesplit = 1,
+		.sblk = &sm8750_lm_sblk,
+		.lm_pair = LM_5,
+		.pingpong = PINGPONG_4,
+	}, {
+		.name = "lm_5", .id = LM_5,
+		.base = 0x49000, .len = 0x400,
+		.sourcesplit = 1,
+		.sblk = &sm8750_lm_sblk,
+		.lm_pair = LM_4,
+		.pingpong = PINGPONG_5,
+	}, {
+		.name = "lm_6", .id = LM_6,
+		.base = 0x4a000, .len = 0x400,
+		.sourcesplit = 1,
+		.sblk = &sm8750_lm_sblk,
+		.lm_pair = LM_7,
+		.pingpong = PINGPONG_6,
+	}, {
+		.name = "lm_7", .id = LM_7,
+		.base = 0x4b000, .len = 0x400,
+		.sourcesplit = 1,
+		.sblk = &sm8750_lm_sblk,
+		.lm_pair = LM_6,
+		.pingpong = PINGPONG_7,
+	},
+};
+
+static const struct dpu_dspp_cfg sm8750_dspp[] = {
+	{
+		.name = "dspp_0", .id = DSPP_0,
+		.base = 0x54000, .len = 0x1800,
+		.sblk = &sm8750_dspp_sblk,
+	}, {
+		.name = "dspp_1", .id = DSPP_1,
+		.base = 0x56000, .len = 0x1800,
+		.sblk = &sm8750_dspp_sblk,
+	}, {
+		.name = "dspp_2", .id = DSPP_2,
+		.base = 0x58000, .len = 0x1800,
+		.sblk = &sm8750_dspp_sblk,
+	}, {
+		.name = "dspp_3", .id = DSPP_3,
+		.base = 0x5a000, .len = 0x1800,
+		.sblk = &sm8750_dspp_sblk,
+	},
+};
+
+static const struct dpu_pingpong_cfg sm8750_pp[] = {
+	{
+		.name = "pingpong_0", .id = PINGPONG_0,
+		.base = 0x69000, .len = 0,
+		.sblk = &sc7280_pp_sblk,
+		.merge_3d = MERGE_3D_0,
+		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 8),
+	}, {
+		.name = "pingpong_1", .id = PINGPONG_1,
+		.base = 0x6a000, .len = 0,
+		.sblk = &sc7280_pp_sblk,
+		.merge_3d = MERGE_3D_0,
+		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 9),
+	}, {
+		.name = "pingpong_2", .id = PINGPONG_2,
+		.base = 0x6b000, .len = 0,
+		.sblk = &sc7280_pp_sblk,
+		.merge_3d = MERGE_3D_1,
+		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 10),
+	}, {
+		.name = "pingpong_3", .id = PINGPONG_3,
+		.base = 0x6c000, .len = 0,
+		.sblk = &sc7280_pp_sblk,
+		.merge_3d = MERGE_3D_1,
+		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 11),
+	}, {
+		.name = "pingpong_4", .id = PINGPONG_4,
+		.base = 0x6d000, .len = 0,
+		.sblk = &sc7280_pp_sblk,
+		.merge_3d = MERGE_3D_2,
+		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 30),
+	}, {
+		.name = "pingpong_5", .id = PINGPONG_5,
+		.base = 0x6e000, .len = 0,
+		.sblk = &sc7280_pp_sblk,
+		.merge_3d = MERGE_3D_2,
+		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 31),
+	}, {
+		.name = "pingpong_6", .id = PINGPONG_6,
+		.base = 0x6f000, .len = 0,
+		.sblk = &sc7280_pp_sblk,
+		.merge_3d = MERGE_3D_3,
+		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 20),
+	}, {
+		.name = "pingpong_7", .id = PINGPONG_7,
+		.base = 0x70000, .len = 0,
+		.sblk = &sc7280_pp_sblk,
+		.merge_3d = MERGE_3D_3,
+		.intr_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 21),
+	}, {
+		.name = "pingpong_cwb_0", .id = PINGPONG_CWB_0,
+		.base = 0x66000, .len = 0,
+		.sblk = &sc7280_pp_sblk,
+		.merge_3d = MERGE_3D_4,
+	}, {
+		.name = "pingpong_cwb_1", .id = PINGPONG_CWB_1,
+		.base = 0x66400, .len = 0,
+		.sblk = &sc7280_pp_sblk,
+		.merge_3d = MERGE_3D_4,
+	}, {
+		.name = "pingpong_cwb_2", .id = PINGPONG_CWB_2,
+		.base = 0x7e000, .len = 0,
+		.sblk = &sc7280_pp_sblk,
+		.merge_3d = MERGE_3D_5,
+	}, {
+		.name = "pingpong_cwb_3", .id = PINGPONG_CWB_3,
+		.base = 0x7e400, .len = 0,
+		.sblk = &sc7280_pp_sblk,
+		.merge_3d = MERGE_3D_5,
+	},
+};
+
+static const struct dpu_merge_3d_cfg sm8750_merge_3d[] = {
+	{
+		.name = "merge_3d_0", .id = MERGE_3D_0,
+		.base = 0x4e000, .len = 0x1c,
+	}, {
+		.name = "merge_3d_1", .id = MERGE_3D_1,
+		.base = 0x4f000, .len = 0x1c,
+	}, {
+		.name = "merge_3d_2", .id = MERGE_3D_2,
+		.base = 0x50000, .len = 0x1c,
+	}, {
+		.name = "merge_3d_3", .id = MERGE_3D_3,
+		.base = 0x51000, .len = 0x1c,
+	}, {
+		.name = "merge_3d_4", .id = MERGE_3D_4,
+		.base = 0x66700, .len = 0x1c,
+	}, {
+		.name = "merge_3d_5", .id = MERGE_3D_5,
+		.base = 0x7e700, .len = 0x1c,
+	},
+};
+
+/*
+ * NOTE: Each display compression engine (DCE) contains dual hard
+ * slice DSC encoders so both share same base address but with
+ * its own different sub block address.
+ */
+static const struct dpu_dsc_cfg sm8750_dsc[] = {
+	{
+		.name = "dce_0_0", .id = DSC_0,
+		.base = 0x80000, .len = 0x8,
+		.have_native_42x = 1,
+		.sblk = &sm8750_dsc_sblk_0,
+	}, {
+		.name = "dce_0_1", .id = DSC_1,
+		.base = 0x80000, .len = 0x8,
+		.have_native_42x = 1,
+		.sblk = &sm8750_dsc_sblk_1,
+	}, {
+		.name = "dce_1_0", .id = DSC_2,
+		.base = 0x81000, .len = 0x8,
+		.have_native_42x = 1,
+		.sblk = &sm8750_dsc_sblk_0,
+	}, {
+		.name = "dce_1_1", .id = DSC_3,
+		.base = 0x81000, .len = 0x8,
+		.have_native_42x = 1,
+		.sblk = &sm8750_dsc_sblk_1,
+	}, {
+		.name = "dce_2_0", .id = DSC_4,
+		.base = 0x82000, .len = 0x8,
+		.have_native_42x = 1,
+		.sblk = &sm8750_dsc_sblk_0,
+	}, {
+		.name = "dce_2_1", .id = DSC_5,
+		.base = 0x82000, .len = 0x8,
+		.have_native_42x = 1,
+		.sblk = &sm8750_dsc_sblk_1,
+	}, {
+		.name = "dce_3_0", .id = DSC_6,
+		.base = 0x83000, .len = 0x8,
+		.have_native_42x = 1,
+		.sblk = &sm8750_dsc_sblk_0,
+	}, {
+		.name = "dce_3_1", .id = DSC_7,
+		.base = 0x83000, .len = 0x8,
+		.have_native_42x = 1,
+		.sblk = &sm8750_dsc_sblk_1,
+	},
+};
+
+static const struct dpu_wb_cfg sm8750_wb[] = {
+	{
+		.name = "wb_2", .id = WB_2,
+		.base = 0x65000, .len = 0x2c8,
+		.features = WB_SDM845_MASK,
+		.format_list = wb2_formats_rgb_yuv,
+		.num_formats = ARRAY_SIZE(wb2_formats_rgb_yuv),
+		.xin_id = 6,
+		.vbif_idx = VBIF_RT,
+		.maxlinewidth = 4096,
+		.intr_wb_done = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 4),
+	},
+};
+
+static const struct dpu_cwb_cfg sm8750_cwb[] = {
+	{
+		.name = "cwb_0", .id = CWB_0,
+		.base = 0x66200, .len = 0x20,
+	},
+	{
+		.name = "cwb_1", .id = CWB_1,
+		.base = 0x66600, .len = 0x20,
+	},
+	{
+		.name = "cwb_2", .id = CWB_2,
+		.base = 0x7e200, .len = 0x20,
+	},
+	{
+		.name = "cwb_3", .id = CWB_3,
+		.base = 0x7e600, .len = 0x20,
+	},
+};
+
+static const struct dpu_intf_cfg sm8750_intf[] = {
+	{
+		.name = "intf_0", .id = INTF_0,
+		.base = 0x34000, .len = 0x4bc,
+		.type = INTF_DP,
+		.controller_id = MSM_DP_CONTROLLER_0,
+		.prog_fetch_lines_worst_case = 24,
+		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 24),
+		.intr_vsync = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 25),
+	}, {
+		.name = "intf_1", .id = INTF_1,
+		.base = 0x35000, .len = 0x4bc,
+		.type = INTF_DSI,
+		.controller_id = MSM_DSI_CONTROLLER_0,
+		.prog_fetch_lines_worst_case = 24,
+		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 26),
+		.intr_vsync = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 27),
+		.intr_tear_rd_ptr = DPU_IRQ_IDX(MDP_INTF1_TEAR_INTR, 2),
+	}, {
+		.name = "intf_2", .id = INTF_2,
+		.base = 0x36000, .len = 0x4bc,
+		.type = INTF_DSI,
+		.controller_id = MSM_DSI_CONTROLLER_1,
+		.prog_fetch_lines_worst_case = 24,
+		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 28),
+		.intr_vsync = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 29),
+		.intr_tear_rd_ptr = DPU_IRQ_IDX(MDP_INTF2_TEAR_INTR, 2),
+	}, {
+		.name = "intf_3", .id = INTF_3,
+		.base = 0x37000, .len = 0x4bc,
+		.type = INTF_DP,
+		.controller_id = MSM_DP_CONTROLLER_1,
+		.prog_fetch_lines_worst_case = 24,
+		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 30),
+		.intr_vsync = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 31),
+	},
+};
+
+static const struct dpu_perf_cfg sm8750_perf_data = {
+	.max_bw_low = 18900000,
+	.max_bw_high = 28500000,
+	.min_core_ib = 2500000,
+	.min_llcc_ib = 0,
+	.min_dram_ib = 800000,
+	.min_prefill_lines = 35,
+	.danger_lut_tbl = {0x3ffff, 0x3ffff, 0x0},
+	.safe_lut_tbl = {0xfe00, 0xfe00, 0xffff},
+	.qos_lut_tbl = {
+		{.nentry = ARRAY_SIZE(sc7180_qos_linear),
+		.entries = sc7180_qos_linear
+		},
+		{.nentry = ARRAY_SIZE(sc7180_qos_macrotile),
+		.entries = sc7180_qos_macrotile
+		},
+		{.nentry = ARRAY_SIZE(sc7180_qos_nrt),
+		.entries = sc7180_qos_nrt
+		},
+		/* TODO: macrotile-qseed is different from macrotile */
+	},
+	.cdp_cfg = {
+		{.rd_enable = 1, .wr_enable = 1},
+		{.rd_enable = 1, .wr_enable = 0}
+	},
+	.clk_inefficiency_factor = 105,
+	.bw_inefficiency_factor = 120,
+};
+
+static const struct dpu_mdss_version sm8750_mdss_ver = {
+	.core_major_ver = 12,
+	.core_minor_ver = 0,
+};
+
+const struct dpu_mdss_cfg dpu_sm8750_cfg = {
+	.mdss_ver = &sm8750_mdss_ver,
+	.caps = &sm8750_dpu_caps,
+	.mdp = &sm8750_mdp,
+	.cdm = &dpu_cdm_5_x,
+	.ctl_count = ARRAY_SIZE(sm8750_ctl),
+	.ctl = sm8750_ctl,
+	.sspp_count = ARRAY_SIZE(sm8750_sspp),
+	.sspp = sm8750_sspp,
+	.mixer_count = ARRAY_SIZE(sm8750_lm),
+	.mixer = sm8750_lm,
+	.dspp_count = ARRAY_SIZE(sm8750_dspp),
+	.dspp = sm8750_dspp,
+	.pingpong_count = ARRAY_SIZE(sm8750_pp),
+	.pingpong = sm8750_pp,
+	.dsc_count = ARRAY_SIZE(sm8750_dsc),
+	.dsc = sm8750_dsc,
+	.merge_3d_count = ARRAY_SIZE(sm8750_merge_3d),
+	.merge_3d = sm8750_merge_3d,
+	.wb_count = ARRAY_SIZE(sm8750_wb),
+	.wb = sm8750_wb,
+	.cwb_count = ARRAY_SIZE(sm8750_cwb),
+	.cwb = sm8650_cwb,
+	.intf_count = ARRAY_SIZE(sm8750_intf),
+	.intf = sm8750_intf,
+	.vbif_count = ARRAY_SIZE(sm8650_vbif),
+	.vbif = sm8650_vbif,
+	.perf = &sm8750_perf_data,
+};
+
+#endif
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
index a310a5234e99ea4886e82ac2100c4099e6a1841e..1ccef3cdc5227ab785bd805b44cec132b2881e46 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
@@ -323,6 +323,9 @@ static const struct dpu_sspp_sub_blks dpu_vig_sblk_qseed3_3_2 =
 static const struct dpu_sspp_sub_blks dpu_vig_sblk_qseed3_3_3 =
 				_VIG_SBLK(SSPP_SCALER_VER(3, 3));
 
+static const struct dpu_sspp_sub_blks dpu_vig_sblk_qseed3_3_4 =
+				_VIG_SBLK(SSPP_SCALER_VER(3, 4));
+
 static const struct dpu_sspp_sub_blks dpu_rgb_sblk = _RGB_SBLK();
 
 static const struct dpu_sspp_sub_blks dpu_dma_sblk = _DMA_SBLK();
@@ -357,6 +360,16 @@ static const struct dpu_lm_sub_blks sc7180_lm_sblk = {
 	},
 };
 
+static const struct dpu_lm_sub_blks sm8750_lm_sblk = {
+	.maxwidth = DEFAULT_DPU_OUTPUT_LINE_WIDTH,
+	.maxblendstages = 11, /* excluding base layer */
+	.blendstage_base = { /* offsets relative to mixer base */
+		/* 0x40 + n*0x30 */
+		0x40, 0x70, 0xa0, 0xd0, 0x100, 0x130, 0x160, 0x190, 0x1c0,
+		0x1f0, 0x220
+	},
+};
+
 static const struct dpu_lm_sub_blks qcm2290_lm_sblk = {
 	.maxwidth = DEFAULT_DPU_LINE_WIDTH,
 	.maxblendstages = 4, /* excluding base layer */
@@ -378,6 +391,11 @@ static const struct dpu_dspp_sub_blks sdm845_dspp_sblk = {
 		.len = 0x90, .version = 0x40000},
 };
 
+static const struct dpu_dspp_sub_blks sm8750_dspp_sblk = {
+	.pcc = {.name = "pcc", .base = 0x1700,
+		.len = 0x90, .version = 0x60000},
+};
+
 /*************************************************************
  * PINGPONG sub blocks config
  *************************************************************/
@@ -420,6 +438,16 @@ static const struct dpu_dsc_sub_blks dsc_sblk_1 = {
 	.ctl = {.name = "ctl", .base = 0xF80, .len = 0x10},
 };
 
+static const struct dpu_dsc_sub_blks sm8750_dsc_sblk_0 = {
+	.enc = {.name = "enc", .base = 0x100, .len = 0x100},
+	.ctl = {.name = "ctl", .base = 0xF00, .len = 0x24},
+};
+
+static const struct dpu_dsc_sub_blks sm8750_dsc_sblk_1 = {
+	.enc = {.name = "enc", .base = 0x200, .len = 0x100},
+	.ctl = {.name = "ctl", .base = 0xF80, .len = 0x24},
+};
+
 /*************************************************************
  * CDM block config
  *************************************************************/
@@ -710,3 +738,4 @@ static const struct dpu_qos_lut_entry sc7180_qos_nrt[] = {
 #include "catalog/dpu_9_2_x1e80100.h"
 
 #include "catalog/dpu_10_0_sm8650.h"
+#include "catalog/dpu_12_0_sm8750.h"
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
index f5ce35cd966459f0edf2dbdd2dbc2693779fac73..de124b722340e98dc78999af1e0ff50bd65a53c2 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
@@ -749,6 +749,7 @@ extern const struct dpu_mdss_cfg dpu_sm8450_cfg;
 extern const struct dpu_mdss_cfg dpu_sa8775p_cfg;
 extern const struct dpu_mdss_cfg dpu_sm8550_cfg;
 extern const struct dpu_mdss_cfg dpu_sm8650_cfg;
+extern const struct dpu_mdss_cfg dpu_sm8750_cfg;
 extern const struct dpu_mdss_cfg dpu_x1e80100_cfg;
 
 #endif /* _DPU_HW_CATALOG_H */
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index d44461e7e1641b25c5181bf7c0c9bbedffcc869d..18d2237b291fd7acd37da8f74ea924c4f4f3d542 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -1532,6 +1532,7 @@ static const struct of_device_id dpu_dt_match[] = {
 	{ .compatible = "qcom,sm8450-dpu", .data = &dpu_sm8450_cfg, },
 	{ .compatible = "qcom,sm8550-dpu", .data = &dpu_sm8550_cfg, },
 	{ .compatible = "qcom,sm8650-dpu", .data = &dpu_sm8650_cfg, },
+	{ .compatible = "qcom,sm8750-dpu", .data = &dpu_sm8750_cfg, },
 	{ .compatible = "qcom,x1e80100-dpu", .data = &dpu_x1e80100_cfg, },
 	{}
 };

-- 
2.43.0


