Return-Path: <linux-kernel+bounces-522928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3438A3D032
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 04:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6F73179DE9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 03:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CB21C5F26;
	Thu, 20 Feb 2025 03:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vGyW/K4f"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D639286291
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 03:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740023972; cv=none; b=X+PSEaV7iutcjfkUB3rlxdCez+/163k61hg6Et2jKYOwSqNBeI/UTsmCwY2WgeWAURa9Bkd+4a7Sovo+yv7xaLuutxUMQmLoR3HtWa72pXEQjFnIeCv/Do4ze31SPQEMKPJxnC8teXelsPNQ8k/a6F2mkbhQ6xXD8fjJGI+fyrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740023972; c=relaxed/simple;
	bh=CR+cW2pe/0YDUERdzuk05bH+pxYUGyqM9a7zB7Nk7So=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ulmU8vNtH/rlJlKwu/mxTjV0qFOKt2qNM5NIU6gopk1dZzd2X2CXE+pRxATBZEuFo64cAVTnf0dKy2oYKRjZdqYQKSO2Cb68gZY0Q4x2pAN+vE1o0W5X8eUXCUWo4BkvMN42+7nRl3I4nvJhXDMb7quK/J9swDoaf6d79W8n/8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vGyW/K4f; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5439a6179a7so582781e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 19:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740023968; x=1740628768; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l+8oUVrZ0gAKzCyuhlLRqWxp+1Id8wqmg/252Do9Ydw=;
        b=vGyW/K4fUdmkMwyKK4wrCYDj7oL8rQU2t6VueXllgRe7lmte6i6rEeMoZ5A19+VUkj
         Yphgh4cKToLyc2mKE1UFp8v9VCfMVgE3Py/zq0x4G9Ty4Kin+iuM5p/tt08/YXznUMFy
         G1uPrmTQB51sZSFNegS4CIr4hbJIw0ZnMGLrorQ7TKdOiqzgvx9BUR3ridb93oyxYwJC
         g2SdvGpUIF8FF2ysK+ASTqW7z0Il5m7Qtp1cvPnpMShcgBJ7worlAoxRamrKOkHyzHnm
         pBO6hFCQN/QXzYchuQWv3/HkceDSWDi94DwBQkdAU9toZtgaaQ9pB4V+x5ohn9nOMDiC
         +olg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740023968; x=1740628768;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l+8oUVrZ0gAKzCyuhlLRqWxp+1Id8wqmg/252Do9Ydw=;
        b=wFy8SccqQfuh3/bd/lIZhuGogaJ2rs1LH/JA/vvK9YVCRcOZnfVN63ql5Z6hkGfWjX
         y6FxmfOMHnT49W6VrNq9FWQNg4uoQR6vd+HOyAbmsMOS3BaFXI0Uy/qBS7OZfJo66vJE
         qG0+9nEax8XNXMWGtbyx/JeSa31iPMJ6wMFRQZiE2PSgxC8VBrmc/my3k3ZNDKouOeMt
         +9rGtKoFipqdk3r+H8Ll+TYOXJ45IR/APJFw9jnxLUZ1LmGAARbhO0W1sigaDyrAiIQu
         0HjxdXpvxVfcza1XfcXt+MBBn/x9MS99xdlQeFMPjcPi2T+yBnhukSXW33M2nTRSCM30
         fftg==
X-Forwarded-Encrypted: i=1; AJvYcCVpkzfxcMkdEgFi/zr4Nql510n+MnnPR1oAx8pxxq9oV8A6VTUT5wOK7MCl4p8M08ZnsmpIgszaAIgO/8k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9rX//QHzd7q2ns7FUMGQm6q/olvZopSB3HzJ/2aHXqiMpcTB+
	iZtEPsnIoKE3lbjDhXr+AR/bziZbVy4P3BLBcPpO/NW6GJ3zvygAT6rZAglafR4=
X-Gm-Gg: ASbGncvMv6IwAXhZJzBEipyUoJBvxs0kSnk09u0CzjBe1Rig9FMZcwRRgBrrpO0t8Zh
	79BAZstFDRNcJtDW7k6ER3UyO3fibaqwOMY3reeVmBRjHK5Lrk94eHhLTPcxruX0MHQ+A2NuIej
	CdjtisucxK1YmWMIuvj2nSc4Jr+S3WYRbNnnBvvpOzRqNT4ZsOC8MW6i6LZ+vgIAnmKaPR29VFL
	R9pICAhPqrXAN/F2fWQ+t+TW2LqT4OgMV6SDA1chK8+TOn3NKmw/4z/rZIfUhv6hEUOuyOHj5cr
	jV0ZDf55/5LMaoaE80omxSE=
X-Google-Smtp-Source: AGHT+IFR1Xxw2/2J7IszS20njZUSb8dM0NewRClc21MyDyNGIYBFhanjrEfVphFRJXFqUOvj8IX8Jw==
X-Received: by 2002:a19:5e56:0:b0:545:81b:1516 with SMTP id 2adb3069b0e04-546e4b2c993mr487354e87.15.1740023968414;
        Wed, 19 Feb 2025 19:59:28 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-545225f22ebsm2143909e87.16.2025.02.19.19.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 19:59:27 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v2 0/5] drm/msm/dpu: enable CDM for all supported platforms
Date: Thu, 20 Feb 2025 05:59:21 +0200
Message-Id: <20250220-dpu-add-cdm-v2-0-77f5f0df3d9a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJmotmcC/1XMyw6CMBCF4Vchs3YMHakiK9/DsOgVJlFKWiUa0
 ne3Ejcu/5Ocb4XkIrsEXbVCdAsnDlMJ2lVgRjUNDtmWBqqpESQk2vmJylo09o61lvpM7cF71UJ
 5zNF5fm3atS89cnqE+N7wRXzXn0PNn7MIrPGklPZGy5aa4+XGk4phH+IAfc75AzU+aNinAAAA
X-Change-ID: 20241215-dpu-add-cdm-0b5b9283ffa8
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2724;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=CR+cW2pe/0YDUERdzuk05bH+pxYUGyqM9a7zB7Nk7So=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBntqicJhCSgswxcqrbREVcRq9vfVTW6veEIobsT
 SxuNriiWGOJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ7aonAAKCRCLPIo+Aiko
 1RDTB/9js86og50XT9YheQJ8Sj3BKuy1rIPhU8Ix3yDbtYoXtnA4IdjPPKm6PPE5aZLpJa76N7p
 N46YW699wYfCK+uAO+df0Nf3Nosn9ZCvwT6XV2tnS2O+8vV11katQ7QlR+malmFoJDpqVTS4D4T
 w+JZFNzvdwqdfTPfq9CR5vXvRNQEuDVvUSvRrJs0O9zarj0wDtJ1thHTGYD55eIr30RyIdnjChD
 H4dPNCRvDrYPvNNo8W5T5n8U7Jx6VEPTncn4dMPmqoqLXJmrme8mquXO6wlD8V0JtDl0VO4SfFN
 /ldaS1YHqJZOisvP5J/UOX9HcKG+g7jJus4mzLqiZ6njzbme
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Enable CDM block on all the platforms where it is supposed to be
present. Notably, from the platforms being supported by the DPU driver
it is not enabled for SM6115 (DPU 6.3), QCM2290 (DPU 6.5) and SM6375
(DPU 6.9)

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Changes in v2:
- Split CDM addition to two patches: DPU 1.x - 4.x and 5.x+
- Corrected CDM size on DPU 1.x - 4.x (Abhinav)
- Link to v1: https://lore.kernel.org/r/20241224-dpu-add-cdm-v1-0-7aabfcb58246@linaro.org

---
Dmitry Baryshkov (5):
      drm/msm/dpu: rename CDM block definition
      drm/msm/dpu: enable CDM_0 for DPUs 5.x+
      drm/msm/dpu: enable CDM_0 for DPUs 1.x - 4.x
      drm/msm/dpu: enable CDM_0 for SC8280XP platform
      drm/msm/dpu: enable CDM_0 for X Elite platform

 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_10_0_sm8650.h  | 1 +
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_14_msm8937.h | 1 +
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_15_msm8917.h | 1 +
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_16_msm8953.h | 1 +
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_1_7_msm8996.h  | 1 +
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h  | 1 +
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_2_sdm660.h   | 1 +
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_3_sdm630.h   | 1 +
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_4_0_sdm845.h   | 1 +
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_4_1_sdm670.h   | 1 +
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h   | 1 +
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h  | 1 +
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_2_sm7150.h   | 1 +
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_3_sm6150.h   | 1 +
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_4_sm6125.h   | 1 +
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_0_sm8250.h   | 2 +-
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_2_sc7180.h   | 1 +
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_4_sm6350.h   | 1 +
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h   | 1 +
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h   | 2 +-
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h | 1 +
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_1_sm8450.h   | 1 +
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_4_sa8775p.h  | 2 +-
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h   | 1 +
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h | 1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c           | 9 ++++++++-
 26 files changed, 33 insertions(+), 4 deletions(-)
---
base-commit: 8936cec5cb6e27649b86fabf383d7ce4113bba49
change-id: 20241215-dpu-add-cdm-0b5b9283ffa8

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


