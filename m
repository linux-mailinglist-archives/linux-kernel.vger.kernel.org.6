Return-Path: <linux-kernel+bounces-257187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0B4937669
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 12:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A8DD1F26C38
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 10:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E61823AF;
	Fri, 19 Jul 2024 10:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AWlt/1fv"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CF884A51
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 10:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721383435; cv=none; b=h8OjES3J3Js02lsjK6J92OdBj3/UB6uUoVxBelp7eHZy9DCPDMZJBWN2kbm2T6kPWe2u8bLaBjyxUIknjhhdYO9+sCWmC0++VkhzczwUF8c9sZrLD5+HkmBp+PGw7FN/3N9RZV/MXvw6oZrDO1WKIRckbBnRthqMAC/uM6ELKfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721383435; c=relaxed/simple;
	bh=O84FzyjB2Eyhi66LD4wz7IxJGuAWHj3uy6YrALAP+Mg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f2BLIPG8m1RwJbAqf+fSxFWrl65n1ELQq3+eyjjBQ8ThRtdG3c8LI8blB7MNbUSTcO0qlX33C14zHV7/vk4WMSi/PBxjNWGxY61gKWh12ayIU2e92qm6qFy3Zne1/gWNpo45/IeMwMXrY5n3lCTyxQNaXuMef9SbqMtCtAtleG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AWlt/1fv; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2eec7e431d9so27306151fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 03:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721383432; x=1721988232; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sJ7jGok25wqCohKFmjM2Uxuf4408Pvnq3D5lzo9Msgk=;
        b=AWlt/1fvOJO2rYApR9RiAzDeXGYj1nOhZjZ+zcRb+w7Aaixww+U6oGUJuitobZ/4L4
         bRwyCWC+OyHBj/zNAc1ZLj/NkQwtbcsZDVD8v/NvhnZNhwLArzb2ly8AkS+TWtsDhr4S
         DsNMVsyrAIV8WUCSgsLeGeJrqPS3cqHm5UBIK/rK21RkIgX3cF6vor5qUK37pyTQVUuB
         rItr3gsYpWFAi4pfUOVNWslBC68rAAgmVdO2mP7NXqPOT+ugOGPGs+Yqt+yZovckaJV2
         dtDipIeKc6Bt0f8ae0vkLxs0ndy27utA403tIZ2Sfvjx/8qPGq407hF8gfWmpqqjTC6N
         oSiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721383432; x=1721988232;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sJ7jGok25wqCohKFmjM2Uxuf4408Pvnq3D5lzo9Msgk=;
        b=gVGKl/puKm1H47M7B3ji1DfFN7kazcXvY5sSd0wCMR2E5D6qQrDlUTnkieVNsIzjqe
         P0yhMgnrlIcEmtlVCafztQI2hPJl9YfpNSA0VwEMFMWq0mS/RD47z3MC+FRgjFPO794v
         /pDZBqTpUhgy6nnvAPEs7Hq7gawNluy78le8iCXGhU4oO2Tl8d6bfgKTE4tEpclSi9wz
         1vwTmmNi2DmLjhYToQMQ9eglACgnBny6MKgdFSwk5iPJtbcS7B+N1eS87G408pwkhHPg
         zJcIQ98YJHKCkTfWagSbeWdH8HpkekWYbgZC+7PH03xx3BRdBpMbrJOaHkZvGe1p2Ibn
         kGBw==
X-Forwarded-Encrypted: i=1; AJvYcCVq+y7tCzrlAPVp8zJQIll2p1GeLITDu8T9pKM6Jm3mxkdBYsksECJxdDk7Rp+PyCGZikheH9j75v2yEpZ41fe9NxPiYqyNdr2M7Ezh
X-Gm-Message-State: AOJu0YyOFlzB/rTkuXn/g7L7W62V+V+cg+2HlXdwq3RZ1QB21bVf3ECD
	3dirCQVI1kgUr62tgqi3AebtfK8ibeNp5UsAo0gF3iD2oYc0DQvENSDARKMPobc=
X-Google-Smtp-Source: AGHT+IH8l/ppqpwuc0EDxTBACl80JK0PwE7h+5Db4+LmrW0cD8ffIzSXVpqM8mNVlc5/xi2veXyoUg==
X-Received: by 2002:a2e:998c:0:b0:2ec:1dfc:45bf with SMTP id 38308e7fff4ca-2ef05d4d44emr31816751fa.42.1721383431508;
        Fri, 19 Jul 2024 03:03:51 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a30aaa31e0sm919984a12.27.2024.07.19.03.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 03:03:51 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 19 Jul 2024 12:03:29 +0200
Subject: [PATCH 4/5] drm/msm/a6xx: Set GMU CGC properties on a6xx too
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240719-topic-a621-v1-4-850ae5307cf4@linaro.org>
References: <20240719-topic-a621-v1-0-850ae5307cf4@linaro.org>
In-Reply-To: <20240719-topic-a621-v1-0-850ae5307cf4@linaro.org>
To: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721383413; l=2625;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=O84FzyjB2Eyhi66LD4wz7IxJGuAWHj3uy6YrALAP+Mg=;
 b=1ZwfQLvOrlfwRBd+kJWRxJFSJphLbrCDE9sDQrNr9Pk9pBIzAo4MOlf4BGjKxEgYSadu2S5x+
 iofpPsoNnDKDt7pGAdtbcK9zW/BCkGXokeSNHg9Vz7b2NjnoJqlClAz
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

This was apparently never done before.. Program the expected values.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c   | 18 ++++++++++--------
 drivers/gpu/drm/msm/adreno/adreno_gpu.h |  8 +++++++-
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 871452daa189..33a319f7d200 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -402,6 +402,7 @@ static void a6xx_set_hwcg(struct msm_gpu *gpu, bool state)
 	struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
 	const struct adreno_reglist *reg;
 	unsigned int i;
+	u32 cgc_delay, cgc_hyst;
 	u32 val, clock_cntl_on;
 
 	if (!(adreno_gpu->info->a6xx->hwcg || adreno_is_a7xx(adreno_gpu)))
@@ -416,14 +417,15 @@ static void a6xx_set_hwcg(struct msm_gpu *gpu, bool state)
 	else
 		clock_cntl_on = 0x8aa8aa82;
 
-	if (adreno_is_a7xx(adreno_gpu)) {
-		gmu_write(&a6xx_gpu->gmu, REG_A6XX_GPU_GMU_AO_GMU_CGC_MODE_CNTL,
-			  state ? adreno_gpu->info->a6xx->gmu_cgc_mode : 0);
-		gmu_write(&a6xx_gpu->gmu, REG_A6XX_GPU_GMU_AO_GMU_CGC_DELAY_CNTL,
-			  state ? 0x10111 : 0);
-		gmu_write(&a6xx_gpu->gmu, REG_A6XX_GPU_GMU_AO_GMU_CGC_HYST_CNTL,
-			  state ? 0x5555 : 0);
-	}
+	cgc_delay = adreno_is_a615_family(adreno_gpu) ? 0x111 : 0x10111;
+	cgc_hyst = adreno_is_a615_family(adreno_gpu) ? 0x555 : 0x5555;
+
+	gmu_write(&a6xx_gpu->gmu, REG_A6XX_GPU_GMU_AO_GMU_CGC_MODE_CNTL,
+			state ? adreno_gpu->info->a6xx->gmu_cgc_mode : 0);
+	gmu_write(&a6xx_gpu->gmu, REG_A6XX_GPU_GMU_AO_GMU_CGC_DELAY_CNTL,
+			state ? cgc_delay : 0);
+	gmu_write(&a6xx_gpu->gmu, REG_A6XX_GPU_GMU_AO_GMU_CGC_HYST_CNTL,
+			state ? cgc_hyst : 0);
 
 	if (!adreno_gpu->info->a6xx->hwcg) {
 		gpu_write(gpu, REG_A7XX_RBBM_CLOCK_CNTL_GLOBAL, 1);
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index 1ab523a163a0..26972b2cc896 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -433,7 +433,13 @@ static inline int adreno_is_a610_family(const struct adreno_gpu *gpu)
 	return adreno_is_a610(gpu) || adreno_is_a702(gpu);
 }
 
-/* check for a615, a616, a618, a619 or any a630 derivatives */
+/* TODO: 615/616 */
+static inline int adreno_is_a615_family(const struct adreno_gpu *gpu)
+{
+	return adreno_is_a618(gpu) ||
+	       adreno_is_a619(gpu);
+}
+
 static inline int adreno_is_a630_family(const struct adreno_gpu *gpu)
 {
 	if (WARN_ON_ONCE(!gpu->info))

-- 
2.45.2


