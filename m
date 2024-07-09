Return-Path: <linux-kernel+bounces-245705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A2892B6B6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 13:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E34A28538C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 11:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3B0158A08;
	Tue,  9 Jul 2024 11:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R9iS1Qj3"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AAB158875
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 11:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720523750; cv=none; b=oilEMaJc8GcNu4zjgzB/P+YT29AO4vzUV/Qdd+PzTIQENG/5JII6hHVR8K5X80oo9brol3AvHtBTtlU6gqwoIvoaZmpe4X9Pg+WPh70E/QdRVuNxyfGxNa4k38a8YdPRJw6L4po+jsGyYl6XCoeOlkKbW3m/MJQUCugIkYGbO74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720523750; c=relaxed/simple;
	bh=XIKVXG2FP4V3pnbSVcYW2sWKp3wew12zsDIFhsiuxm4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=U5TnCU5aYtI0RoUj92+nSOWdec/fY3cdYSV+BL1Vnz3AUm8nfRP/uD0KChdl/GmYVVF7LRqCh+4X5r30l+lKx1YUe2Udaoct4AFUeQ9Pky6VOTKFITQF4C3JJh00TboCEpvsuQcenNqOXfXsaAes/ZumWAqVBlOPVwdODrnByGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R9iS1Qj3; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a77c9d3e593so432771066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 04:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720523747; x=1721128547; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iTDIAYS1v3Pxz5bKo9e6sLviKWQ74Nbc4ACLHcw546c=;
        b=R9iS1Qj3E/FCnIErwEC5lO00yEKlcxvXMpWTaB3qlDC1Succ6O3Ongn87zYS/W7MYU
         NChzOBAOdL9eAvjuhjNxCtJdqxRzUzNJprzTQ1FAJfr6Viz91YUK9yuaFNWnBggBncmh
         NSyeH5ZTcxNkwqx4weYny9vmyU/mkoMjmGViu9lSxFpxOQeU/u+UG2eaZ9PxXgnCrwwm
         vO270q0r3aNmQdhp/2AIG9bTE/40nAtmC/Kgq345s1NIoaq0kemJrdI47+CvwGRePf6M
         Z7HQ1CeTs0EbCzSFS/ddgxn/YlSRHZy67a1eZBTB/SH4Oxr3DFSHuMjdv8qB7BVY6fj5
         H+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720523747; x=1721128547;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iTDIAYS1v3Pxz5bKo9e6sLviKWQ74Nbc4ACLHcw546c=;
        b=ez98nRywZq/tL8oBzWxZVui84vjinM0eHa+DADbtl08WtnDfRI03qB57D5BoEO9YdP
         eGXgTZGnCM1vEtiO5DVNoggNq3V4QMrgdFzLw5WvLpzF7regb9uyw+6h1eGbDWv9nDRX
         FL91ZzZAJDBbqWO1LSlZtj5RL1C8MFxMNbhvp5Qv0xpl6RHf0ytKLObTk1ubtiUky83C
         Qq2+o8J37qWoePt9UgRowZhl/ayjc8SVjEFfGsMzOMwdbGpBSFDQc9sPCy4oYd4+8s1a
         I4gVLevvivL+N1Nlu+oN/tVYL/hzkpvNL4lg9Ki65lx5PyF74zfxBKnIVGbwJIXIiWeX
         xdIg==
X-Forwarded-Encrypted: i=1; AJvYcCX4a8mAcDD3hKkgAYnO7upwWpt21KjOhwmihr7Yq/bZFLeVYmkTRm35vjypW6LfbYl/zpwqAZ3ovZST/Hh48k1s4YlOJR3hVph8aRmU
X-Gm-Message-State: AOJu0YwtF6TGm1E+yTO0SKBLKhlBm1XOGzBTczInseYTDWPnp99il2Sb
	TFaPsNwICdJcuvPQNyHHUr5U478AO+HV6UoVnLWO9MHWBl0KlQdcb7TWM94rM58=
X-Google-Smtp-Source: AGHT+IGp7EnF0TAVZ53RSFXeZuljBz7nakYWgnGbm0LiXhT2qOt1dQ9BYqAobTD4Vt/4QduRJSwTAw==
X-Received: by 2002:a17:907:9692:b0:a77:eb34:3b45 with SMTP id a640c23a62f3a-a780b6fe39cmr173001866b.36.1720523746920;
        Tue, 09 Jul 2024 04:15:46 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6e06dcsm69527166b.87.2024.07.09.04.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 04:15:46 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 09 Jul 2024 13:15:40 +0200
Subject: [PATCH] drm/msm/adreno: Assign msm_gpu->pdev earlier to avoid
 nullptrs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240709-topic-adreno_crash2-v1-1-9def36c3337d@linaro.org>
X-B4-Tracking: v=1; b=H4sIANsbjWYC/x3MQQqAIBBA0avErBNMgrKrRISNY81GY4wIpLsnL
 d/i/wKZhCnD1BQQujlzihVd2wAeLu6k2FeD0abXg7bqSiejcl4ophXF5cOoDm0IwdsNaYRankK
 Bn/86L+/7AYLBTV5lAAAA
To: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720523745; l=2106;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=XIKVXG2FP4V3pnbSVcYW2sWKp3wew12zsDIFhsiuxm4=;
 b=BJPl9NqE6dAMkeZJadvcNFtD34BG63QModN0kwcUfSZ8DfUDTiyzg7FeP6R0h+A0hXu4BVmHM
 ZmTc1qdvFWbBePAdEXeg5pbxfrQlBiauB4GANnGbOUW13+HrSV7x0hr
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

There are some cases, such as the one uncovered by Commit 46d4efcccc68
("drm/msm/a6xx: Avoid a nullptr dereference when speedbin setting fails")
where

msm_gpu_cleanup() : platform_set_drvdata(gpu->pdev, NULL);

is called on gpu->pdev == NULL, as the GPU device has not been fully
initialized yet.

Turns out that there's more than just the aforementioned path that
causes this to happen (e.g. the case when there's speedbin data in the
catalog, but opp-supported-hw is missing in DT).

Assigning msm_gpu->pdev earlier seems like the least painful solution
to this, therefore do so.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
There's no fixes tag on purpose, as there doesn't seem to be a good
single commit to blame.
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 1 +
 drivers/gpu/drm/msm/msm_gpu.c           | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 1c6626747b98..949d65437704 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -1083,6 +1083,7 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 	adreno_gpu->chip_id = config->chip_id;
 
 	gpu->allow_relocs = config->info->family < ADRENO_6XX_GEN1;
+	gpu->pdev = pdev;
 
 	/* Only handle the core clock when GMU is not in use (or is absent). */
 	if (adreno_has_gmu_wrapper(adreno_gpu) ||
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 3666b42b4ecd..a274b8466423 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -931,7 +931,6 @@ int msm_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 	if (IS_ERR(gpu->gpu_cx))
 		gpu->gpu_cx = NULL;
 
-	gpu->pdev = pdev;
 	platform_set_drvdata(pdev, &gpu->adreno_smmu);
 
 	msm_devfreq_init(gpu);

---
base-commit: 0b58e108042b0ed28a71cd7edf5175999955b233
change-id: 20240709-topic-adreno_crash2-1c9fffd9bce8

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


