Return-Path: <linux-kernel+bounces-245665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F80392B5C4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 12:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F354CB23124
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 10:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDE8158DB7;
	Tue,  9 Jul 2024 10:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="br9NbIhb"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B922C15749B
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 10:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720521960; cv=none; b=UOrj1Cnp4NqX/B1Qns+mrckjD9Az46XmQDjesg4ITapqOEBteOmqHgj1E8V2tOO+TnhISjFYyR/DJSLqjMutliK1xLLqf1kPlq8F1e+Nhfe+ABhUXevjLjS7gmeN2OoFPr+U9MG26xy8y0qm2t+IY7L1uAxKBVbzLtLCgGm2StQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720521960; c=relaxed/simple;
	bh=ZSzgpQ49WT7GffGNsAbL1pXn75NnMBX03jO7rZdfrlQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eGQdCQbYo1o/rWyiZsmHiQC60DdBr8NOJyr0sKkFvoEi8Wh2mGWWPyvvIbEqcm45lvqxg8LIIuKkW2Qof4txh+dVv7jwYmmgSR0MADZxrrQnR8rBRlOiIGTKtlxmYSrHhCEKnq1AeXQwozCGsTxaZxIpAHqDO2heRaaX9yikxnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=br9NbIhb; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a77dc08db60so425853866b.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 03:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720521957; x=1721126757; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+25nY/rYNm7YLajBTpZeCUf/L8baTplxhtXdEO1SETc=;
        b=br9NbIhbbNWT9Ql9ElwpSET5dJiysmyA/lARlYUo5/H3odh++Z2XCB6bzp2SMIi7Ab
         shadztK1tsBFReedT33Z3+J4ghyKfvgvSAQx5tJVxsqhqopMs2UahqPZCitI5XXo3jFY
         SeMLGgs24DCJsBctg1iAfkj10RJoYHeb34RN/yemW40tSoJ0hMrOLeDL6vEDPe5LOYW8
         7hI+2aVRaEp2QA+CMrobYDqNCUTul7AYrTRYbOqKB8DXNfBbfyYcj71SK0fn1OdbeU7l
         9cAv56GJ6PxHHG37G/od1WRZODbQPdbx2/TF0Qa8OUgLNj8RvE52tYpT+MbnRJb5K+Jl
         tftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720521957; x=1721126757;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+25nY/rYNm7YLajBTpZeCUf/L8baTplxhtXdEO1SETc=;
        b=UdLvDaj4RO1G5MWyr1UZASVuGlDJaaZIK0WVMnsH3BQu/vZYC8hsAdZo2FXV/E2V/8
         2pQzl8//q39+Frqpf3F5cSa/mjq29S7mS4BEUPrMqOFPjpOwMGAXzZvzHzMCclYTWRo3
         snqu0Ia5e1HWAGvb2Dm91zUgVrA9NgA8ojpwRLb2f2d7cUu0jEF7Lrnapj2ioMe6jrta
         tUtmtl7KFJXdXgTPtJqcilQ+EYhR5J3wT6xn1BLP7GS00t2ps8fv+T7TSzJWbZ+vplJ8
         VyiNq1zNiTbl1RwaklT4B8yBOGpBfb2gd/bar6xnCElEqdVJL6g6wIGyNK8A7Hczwmln
         hI0A==
X-Forwarded-Encrypted: i=1; AJvYcCWlV2QAGQJUk1X19TWYd8Km/kMSt3O7M31iDo4AZ9wrksfzgta4+UXQ9stG9FdGjPSjQuG51KFA60mGymg5Nr+yZ1ApzvBsKKKFDCzq
X-Gm-Message-State: AOJu0YyJUUJ31Q7Hqhr9qxQsVIwEnun1wuaKIch9BR0t1R3XkfOY9Ph6
	pgpgZfSRWJvVhK9zyIdCtf6PPG8vA3PfX43ylVttoIY7kneU/hg8CahPlc26cek=
X-Google-Smtp-Source: AGHT+IG5FoktpVWK5QM17btN/ecwjh50i59Wtdzqowaj+yV2WoSrncfLxmfmu2om6K3T1xTR5sEtYQ==
X-Received: by 2002:a17:906:d9d1:b0:a77:ec9f:d9c1 with SMTP id a640c23a62f3a-a780b89d4bemr184412766b.70.1720521956898;
        Tue, 09 Jul 2024 03:45:56 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a7ff038sm66295466b.115.2024.07.09.03.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 03:45:56 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 09 Jul 2024 12:45:32 +0200
Subject: [PATCH v5 4/5] drm/msm/adreno: Redo the speedbin assignment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240709-topic-smem_speedbin-v5-4-e2146be0c96f@linaro.org>
References: <20240709-topic-smem_speedbin-v5-0-e2146be0c96f@linaro.org>
In-Reply-To: <20240709-topic-smem_speedbin-v5-0-e2146be0c96f@linaro.org>
To: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720521930; l=7871;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=ZSzgpQ49WT7GffGNsAbL1pXn75NnMBX03jO7rZdfrlQ=;
 b=NDdA24B5tdof5NaIKHu2eEqkNTFs05sN8KmxuwUU4w3M0iDVaZvuPQaCX9QUrvaMXzWhZfbMo
 0Fi5mtGdvHRD+RHdXNtusFL9vK44fnT9giovlszJqlvGOEca3vV5/C5
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

There is no need to reinvent the wheel for simple read-match-set logic.

Make speedbin discovery and assignment generation independent.

This implicitly removes the bogus 0x80 / BIT(7) speed bin on A5xx,
which has no representation in hardware whatshowever.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c   | 34 --------------------
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c   | 56 ---------------------------------
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 51 ++++++++++++++++++++++++++----
 drivers/gpu/drm/msm/adreno/adreno_gpu.h |  3 --
 4 files changed, 45 insertions(+), 99 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
index c0b5373e90d7..d62b12efac57 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
@@ -1709,38 +1709,6 @@ static const struct adreno_gpu_funcs funcs = {
 	.get_timestamp = a5xx_get_timestamp,
 };
 
-static void check_speed_bin(struct device *dev)
-{
-	struct nvmem_cell *cell;
-	u32 val;
-
-	/*
-	 * If the OPP table specifies a opp-supported-hw property then we have
-	 * to set something with dev_pm_opp_set_supported_hw() or the table
-	 * doesn't get populated so pick an arbitrary value that should
-	 * ensure the default frequencies are selected but not conflict with any
-	 * actual bins
-	 */
-	val = 0x80;
-
-	cell = nvmem_cell_get(dev, "speed_bin");
-
-	if (!IS_ERR(cell)) {
-		void *buf = nvmem_cell_read(cell, NULL);
-
-		if (!IS_ERR(buf)) {
-			u8 bin = *((u8 *) buf);
-
-			val = (1 << bin);
-			kfree(buf);
-		}
-
-		nvmem_cell_put(cell);
-	}
-
-	devm_pm_opp_set_supported_hw(dev, &val, 1);
-}
-
 struct msm_gpu *a5xx_gpu_init(struct drm_device *dev)
 {
 	struct msm_drm_private *priv = dev->dev_private;
@@ -1768,8 +1736,6 @@ struct msm_gpu *a5xx_gpu_init(struct drm_device *dev)
 
 	a5xx_gpu->lm_leakage = 0x4E001A;
 
-	check_speed_bin(&pdev->dev);
-
 	nr_rings = 4;
 
 	if (config->info->revn == 510)
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 0d8682c28ba4..849a14fe2319 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -2105,55 +2105,6 @@ static bool a6xx_progress(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
 	return progress;
 }
 
-static u32 fuse_to_supp_hw(const struct adreno_info *info, u32 fuse)
-{
-	if (!info->speedbins)
-		return UINT_MAX;
-
-	for (int i = 0; info->speedbins[i].fuse != SHRT_MAX; i++)
-		if (info->speedbins[i].fuse == fuse)
-			return BIT(info->speedbins[i].speedbin);
-
-	return UINT_MAX;
-}
-
-static int a6xx_set_supported_hw(struct adreno_gpu *adreno_gpu,
-				 struct device *dev,
-				 const struct adreno_info *info)
-{
-	u32 supp_hw;
-	u32 speedbin;
-	int ret;
-
-	ret = adreno_read_speedbin(adreno_gpu, dev, &speedbin);
-	/*
-	 * -ENOENT/EOPNOTSUPP means that the platform doesn't support speedbin
-	 * which is fine
-	 */
-	if (ret == -ENOENT || ret == -EOPNOTSUPP) {
-		return 0;
-	} else if (ret) {
-		dev_err_probe(dev, ret,
-			      "failed to read speed-bin. Some OPPs may not be supported by hardware\n");
-		return ret;
-	}
-
-	supp_hw = fuse_to_supp_hw(info, speedbin);
-
-	if (supp_hw == UINT_MAX) {
-		DRM_DEV_ERROR(dev,
-			"missing support for speed-bin: %u. Some OPPs may not be supported by hardware\n",
-			speedbin);
-		supp_hw = BIT(0); /* Default */
-	}
-
-	ret = devm_pm_opp_set_supported_hw(dev, &supp_hw, 1);
-	if (ret)
-		return ret;
-
-	return 0;
-}
-
 static const struct adreno_gpu_funcs funcs = {
 	.base = {
 		.get_param = adreno_get_param,
@@ -2285,13 +2236,6 @@ struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
 
 	a6xx_llc_slices_init(pdev, a6xx_gpu, is_a7xx);
 
-	ret = a6xx_set_supported_hw(adreno_gpu, &pdev->dev, config->info);
-	if (ret) {
-		a6xx_llc_slices_destroy(a6xx_gpu);
-		kfree(a6xx_gpu);
-		return ERR_PTR(ret);
-	}
-
 	if (is_a7xx)
 		ret = adreno_gpu_init(dev, pdev, adreno_gpu, &funcs_a7xx, 1);
 	else if (adreno_has_gmu_wrapper(adreno_gpu))
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index cf6652c4439d..6d0397a0554e 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -1064,8 +1064,8 @@ void adreno_gpu_ocmem_cleanup(struct adreno_ocmem *adreno_ocmem)
 			   adreno_ocmem->hdl);
 }
 
-int adreno_read_speedbin(struct adreno_gpu *adreno_gpu,
-			 struct device *dev, u32 *fuse)
+static int adreno_read_speedbin(struct adreno_gpu *adreno_gpu,
+				struct device *dev, u32 *fuse)
 {
 	int ret;
 
@@ -1100,6 +1100,46 @@ int adreno_read_speedbin(struct adreno_gpu *adreno_gpu,
 	return ret;
 }
 
+#define ADRENO_SPEEDBIN_FUSE_NODATA	0xFFFF /* Made-up large value, expected by mesa */
+static int adreno_set_speedbin(struct adreno_gpu *adreno_gpu, struct device *dev)
+{
+	const struct adreno_info *info = adreno_gpu->info;
+	u32 fuse = ADRENO_SPEEDBIN_FUSE_NODATA;
+	u32 supp_hw = UINT_MAX;
+	int ret;
+
+	/* No speedbins defined for this GPU SKU => allow all defined OPPs */
+	if (!info->speedbins) {
+		adreno_gpu->speedbin = ADRENO_SPEEDBIN_FUSE_NODATA;
+		return devm_pm_opp_set_supported_hw(dev, &supp_hw, 1);
+	}
+
+	/*
+	 * If a real error (not counting older devicetrees having no nvmem references)
+	 * occurs when trying to get the fuse value, bail out.
+	 */
+	ret = adreno_read_speedbin(adreno_gpu, dev, &fuse);
+	if (ret) {
+		return ret;
+	} else if (fuse == ADRENO_SPEEDBIN_FUSE_NODATA) {
+		/* The info struct has speedbin data, but the DT doesn't => allow all OPPs */
+		DRM_DEV_INFO(dev, "No GPU speed bin fuse, please update your device tree\n");
+		return devm_pm_opp_set_supported_hw(dev, &supp_hw, 1);
+	}
+
+	adreno_gpu->speedbin = fuse;
+
+	/* Traverse the known speedbins */
+	for (int i = 0; info->speedbins[i].fuse != SHRT_MAX; i++) {
+		if (info->speedbins[i].fuse == fuse) {
+			supp_hw = BIT(info->speedbins[i].speedbin);
+			return devm_pm_opp_set_supported_hw(dev, &supp_hw, 1);
+		}
+	}
+
+	return dev_err_probe(dev, -EINVAL, "Unknown speed bin fuse value: 0x%x\n", fuse);
+}
+
 int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 		struct adreno_gpu *adreno_gpu,
 		const struct adreno_gpu_funcs *funcs, int nr_rings)
@@ -1109,7 +1149,6 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 	struct msm_gpu_config adreno_gpu_config  = { 0 };
 	struct msm_gpu *gpu = &adreno_gpu->base;
 	const char *gpu_name;
-	u32 speedbin;
 	int ret;
 
 	adreno_gpu->funcs = funcs;
@@ -1136,9 +1175,9 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 			devm_pm_opp_set_clkname(dev, "core");
 	}
 
-	if (adreno_read_speedbin(adreno_gpu, dev, &speedbin) || !speedbin)
-		speedbin = 0xffff;
-	adreno_gpu->speedbin = speedbin;
+	ret = adreno_set_speedbin(adreno_gpu, dev);
+	if (ret)
+		return ret;
 
 	gpu_name = devm_kasprintf(dev, GFP_KERNEL, "%"ADRENO_CHIPID_FMT,
 			ADRENO_CHIPID_ARGS(config->chip_id));
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index 0d629343ebb4..eef450dc3732 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -559,9 +559,6 @@ int adreno_fault_handler(struct msm_gpu *gpu, unsigned long iova, int flags,
 			 struct adreno_smmu_fault_info *info, const char *block,
 			 u32 scratch[4]);
 
-int adreno_read_speedbin(struct adreno_gpu *adreno_gpu,
-			 struct device *dev, u32 *speedbin);
-
 /*
  * For a5xx and a6xx targets load the zap shader that is used to pull the GPU
  * out of secure mode

-- 
2.45.2


