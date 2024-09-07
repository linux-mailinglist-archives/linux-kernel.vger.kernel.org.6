Return-Path: <linux-kernel+bounces-319919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6B99703BA
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 20:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 551BEB2329D
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 18:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F91E166F2E;
	Sat,  7 Sep 2024 18:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XqcJIg4V"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1BC16130C
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 18:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725734904; cv=none; b=I0qqce2LUrrKXGVZIq2CZg1cW4kotZXZ4ArsErQTK1CxljWNqYzi8Wvm5VkVS+Yttga1wBs7FgLbyOf1S36r7hiUFlO1Luiu/j/zkADeif1todFYnU0u8oHvC8VIkmEZa5Ghu+me+Y81+hUEH2N8piR1IjmJFB0jxTavumu+FVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725734904; c=relaxed/simple;
	bh=4jg/7UcRjOk5Aa8PYPjFu4S06h+6mU5cJuLQp0/H3QE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mlFLYXCvEmbnyNpgMmBz4kRLSSL+w8ZsgDRbDCwm5xSXZcZj+xauAViQ9oeZ++3FCNkVG4DxkHe700ype311nuTiwoE0pUexmuHyw5p8p/CVHe0fl9uINVVxK7O115eds6vDDcEZHBhnZKU0JM9hZpP/iAGhJYT0Fd/e9ncZUDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XqcJIg4V; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f7529203ddso16748851fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Sep 2024 11:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725734901; x=1726339701; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ASoLCFAFth+L/RYaTTbW4gr5zkHU8LUy6gZz0L/32b0=;
        b=XqcJIg4Vv2R/LYWFmpWlPJpQ8Amphkwz2vbwTd9s4WV1QtnSpfmUPmo8xhX0hwYTTH
         3ftMbhLQPK5RYSg7ouQBMyrgw14JJvhNwJvLO4YPNaz4jaPhzyJEnKZKY52BxuxqFLup
         p6ILcQ30Lov0W8HHsMiU35WpVu5o4LBpQ3cabpg1vYQYYrPZcVEzPh+Gu7OpIcYUrzpq
         rPTCwi1l3Ll2fFdcD1hNBTD+gL1pBVwlOTWmUK+q41PXc+YQJoo3EQg8s/8AmgWfL3cL
         MWcyLmIywgDpKemgTL92Ns8S7k3iPHO32y9+eNHSjcxuwn1oqmXh+8y/a51C8tB/lv+D
         35Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725734901; x=1726339701;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ASoLCFAFth+L/RYaTTbW4gr5zkHU8LUy6gZz0L/32b0=;
        b=jm3lWAMHqOkYeAdw7i8BJJb+gczA+g1e6qQnFRPTLh7CQ+oC7oEub2LJQqRvZAkZ92
         P/xcvUmBBv0PwQSOk0AEsyuercXfbd/yaI0Df3d26nSKALXnUCwXWRo0ppxbkTk7Fn3+
         5kv1X3FnYQbR1+tuK2XToO0pRIg6sUFcYMKBPMepSl2l1B+AYcv1paNnDSyLnhaV/uRq
         lNqERBY3NzOcZ4hxcs0mNxYI7wUETqcil53x1s2ecEE1GCV7oMLkcIhEscr6kA21ULV/
         1+RG7VVoE1tLMrEMS/+jYOjvVUVcHbw9McqlfcIMDCT+DD227lIb75m1q84YlrD/IIdu
         O7qQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNOlEc5s/Wp43bWjhbNB/HCtZMSE+MJzO5K+oCyBjgV1RUeGETZ3YVbdiGD3kBtnrMDvDX52IllMaNwfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXO8s33Xntlc1LwovXcTPvEGQ8oex1jTrM+TjGKTSEEDc+NNTl
	Lww3jAX1jmDxeuXJ7W8rqsW4F7CVlimN+8lUl5HW2px6Il9fWEKEPOi5/EeM95XeNM2Ozhu3oVo
	I
X-Google-Smtp-Source: AGHT+IHT9NJuhuG4AamvpeXk9LoAYFX1Rx0Iy7N0kMWiubohIUwXALW2N+6wWLpExdHwsDiK/BRP1g==
X-Received: by 2002:a05:651c:19a3:b0:2f7:586d:e5e7 with SMTP id 38308e7fff4ca-2f7586de6f4mr12201981fa.5.1725734899905;
        Sat, 07 Sep 2024 11:48:19 -0700 (PDT)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f75c0b1af3sm2271861fa.129.2024.09.07.11.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2024 11:48:19 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 07 Sep 2024 21:48:12 +0300
Subject: [PATCH 1/7] iommu/arm-smmu-qcom: apply num_context_bank fixes for
 SDM630 / SDM660
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240907-sdm660-wifi-v1-1-e316055142f8@linaro.org>
References: <20240907-sdm660-wifi-v1-0-e316055142f8@linaro.org>
In-Reply-To: <20240907-sdm660-wifi-v1-0-e316055142f8@linaro.org>
To: Rob Clark <robdclark@gmail.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1917;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=4jg/7UcRjOk5Aa8PYPjFu4S06h+6mU5cJuLQp0/H3QE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBm3J/xHjCopDQPiYASMPf01hRA68yz6IxH2T4eL
 eC6cfgV0lyJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZtyf8QAKCRCLPIo+Aiko
 1Q9uB/0ag1ZGlUF+StHNMO5RSRr8jbA8TML029hF2MBiqykw2lDs8s8+suyKE9WYe4KswcqvVgN
 4bLu2KGe0WcbuoHG/wD/0SUKHISGgj5Anq4r23QlfVb2bxp4eyH5lJGlFpX19EANfZl3+VaMWyY
 9heRsRGZ3eCyB+Lbo0qZGCWzU7Stf3ugs2tVW/KpgpE+RU64fzV2B+hAZRoqrH/SSzcvZ0qR1tL
 NzKtpFdruw/1UcKNwMKoQJV9xo58sMiOz6W2+uJB9Md+VVFGfmCFmjQ1uK0VdwVnpwVVxQgT9Jo
 vCdHx4iMWcz8ZKPEMLUY7mTi4Uw0ad36gbt2aAtXUl6jX6xT
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The Qualcomm SDM630 / SDM660 platform requires the same kind of
workaround as MSM8998: some IOMMUs have context banks reserved by
firmware / TZ, touching those banks resets the board.

Apply the num_context_bank workaround to those two SMMU devices in order
to allow them to be used by Linux.

Fixes: b812834b5329 ("iommu: arm-smmu-qcom: Add sdm630/msm8998 compatibles for qcom quirks")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 087fb4f6f4d3..13a3e3585c89 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -288,6 +288,12 @@ static int qcom_smmu_cfg_probe(struct arm_smmu_device *smmu)
 	 */
 	if (of_device_is_compatible(smmu->dev->of_node, "qcom,msm8998-smmu-v2") && smmu->num_context_banks == 13)
 		smmu->num_context_banks = 12;
+	else if (of_device_is_compatible(smmu->dev->of_node, "qcom,sdm630-smmu-v2")) {
+		if (smmu->num_context_banks == 21) /* SDM630 / SDM660 A2NOC SMMU */
+			smmu->num_context_banks = 7;
+		else if (smmu->num_context_banks == 14) /* SDM630 / SDM660 LPASS SMMU */
+			smmu->num_context_banks = 13;
+	}
 
 	/*
 	 * Some platforms support more than the Arm SMMU architected maximum of
@@ -350,6 +356,11 @@ static int qcom_adreno_smmuv2_cfg_probe(struct arm_smmu_device *smmu)
 	/* Support for 16K pages is advertised on some SoCs, but it doesn't seem to work */
 	smmu->features &= ~ARM_SMMU_FEAT_FMT_AARCH64_16K;
 
+	/* TZ protects several last context banks, hide them from Linux */
+	if (of_device_is_compatible(smmu->dev->of_node, "qcom,sdm630-smmu-v2") &&
+	    smmu->num_context_banks == 5)
+		smmu->num_context_banks = 2;
+
 	return 0;
 }
 

-- 
2.39.2


