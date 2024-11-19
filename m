Return-Path: <linux-kernel+bounces-414784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFDF9D2D53
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 18:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 989221F24DF0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 17:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D671D799D;
	Tue, 19 Nov 2024 17:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ymCHFW/e"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179411D27A6
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 17:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732039013; cv=none; b=d35v4TxFjbohIqjkiwMEHy0BIfYqyeS8xwfSgU/xUjxF84iaYdMu5Dxuv3xZuC7azRV6OO/ctmeaScKlIkazHRoorfcYkFD2B/LAo9MhbOo+cTz6RYyS40Lpdi/n4uLOYg/ZC2oLmqljAsGSoOFBkcWrRnQ9fjNLN+QLJ4SD4vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732039013; c=relaxed/simple;
	bh=I07ngYL9Ra1f9h+CP4yA7pd1FaT3h7r+nDReMCfjPD8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hkX50qBa4stYl5jc3RMsWCYebvHanEcTH1RCWktqglnwvpKM63VITioDH0mGGb/wHt8OLejaQy+lnYwh7Yc5GFJTRaTwnV9OkodJB5FM5CH6d+H5zJeR7ozM+7qi/xGLWL1u157jPBombgrtSGpR4qSwRtQZ1mca/3XhMDGIVCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ymCHFW/e; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-432d866f70fso11157295e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 09:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732039007; x=1732643807; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TvcxrBjE8Ya+6nKD+reAX7BzLkcovY8zpP7D9Dufu8s=;
        b=ymCHFW/eUQ/j4J3sSdlSNgQFTOBfGjA0GUAV+0GMKKnnCLi8mEIRYJUB5+pY/4S9Kw
         pr/xESl459hb3VSFRQDgbENrGwfnXp3rzRk3J65cfH3qS07hPjZt7RkKkuPxorgyWuJG
         n5dMldqdLyWtyi6y0o6TSqo0uEM4mFZcHyn2zKImnCqMIwjt53DS5iuAH9aRobB57E7O
         AZeVjem+3ZFlD7iHXfVxurvbNTOxej0tMW7m4M1TepPocXvmS3BAObELNkrKe2IsK5zb
         bdOQAvYTGdnzsnxxV9pY8ftZqsY005FjXPdRgXZJYWhw/3jAj92YeeGgGdlCOzRVGYh7
         jAIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732039007; x=1732643807;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TvcxrBjE8Ya+6nKD+reAX7BzLkcovY8zpP7D9Dufu8s=;
        b=fout8gLbfvXtCYib+xcVS49xSVxUfjJQ+7aj0L9D5B6xYhsS2Qg8p9kNUEfJpEIl79
         bRVT12TLOQkqatnVIDGbrKmxGZB8R2sWyZ4AGtIz6/CsntNaQQEz18ax3XUJidf9qq84
         Afjs/zLDs2Kw4ceXgSFsuEL/TaCDENIpXMfUNx0G+bJw47ZsIyoYWBm8q+UASqABSkk1
         a+OS763dIVbuo2crBZQxi91fi18MUm0v13PTZstVUv013SN3sphZgdNvvgulwzv0hcp8
         V0M01G6VC+sxh4TAxU9/xzHzV+nFeBilGKG1YBmDlpc6Xaiyrz0IhFJPOtTfeSeLEJvd
         qA6g==
X-Forwarded-Encrypted: i=1; AJvYcCXzWFppXLJz+ZAzARgQl6sXI5k6aJ49H9Kj8bboA3n//qq/FdTpICRe4/YXh6gZ0TQr9cxDvgBPNPobbwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNGhwGJhctiT9VZAZSwShcNIms1x4t04C3oDxF4PbOMr6VU0bc
	6oGbRQQK93lu+XukuVHzUofnNb67SjJ9D6ZZfAg3ObRZyD4ShPvmBy/JTbsvu0w=
X-Google-Smtp-Source: AGHT+IGJ6SMbLsuvIbUQvyMjL/mTN4J7c8RlBSzGTWfBeFIThfOc4xtQI8YH+x4EjBiCjt9kcGEbSg==
X-Received: by 2002:a05:600c:3508:b0:42c:b750:1a1e with SMTP id 5b1f17b1804b1-432df67959dmr153185785e9.0.1732039007389;
        Tue, 19 Nov 2024 09:56:47 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da27fe68sm208302275e9.24.2024.11.19.09.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 09:56:47 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 19 Nov 2024 18:56:37 +0100
Subject: [PATCH v2 02/11] drm/msm: adreno: rename quirks that are features
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241119-topic-sm8x50-gpu-bw-vote-v2-2-4deb87be2498@linaro.org>
References: <20241119-topic-sm8x50-gpu-bw-vote-v2-0-4deb87be2498@linaro.org>
In-Reply-To: <20241119-topic-sm8x50-gpu-bw-vote-v2-0-4deb87be2498@linaro.org>
To: Akhil P Oommen <quic_akhilpo@quicinc.com>, 
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Connor Abbott <cwabbott0@gmail.com>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 devicetree@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10146;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=I07ngYL9Ra1f9h+CP4yA7pd1FaT3h7r+nDReMCfjPD8=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnPNFXvsfG19CuOcSshzsLLrl9P5JiCVdB6NQYWhe+
 leGk+k2JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZzzRVwAKCRB33NvayMhJ0aqAD/
 9BdW9LZzIoIYl35jeVi9cqCgNGXipLp/slLxcES64BRqOg55WgP8C+mC9AQY0K2p40Vh9Km2z9+QXA
 FonK8lkCmQXlP8i+4UWolxNN5NeQ0TXbzWqovX6t3o26ubGTzeciItmtaR99LfzgRTNVp6EmpUUFME
 BYXQRayCUWbyjQfpS62gs+vxwc0AdTaBe18Eh/rfbowEmWxH25J9Btc/LrVIubMwDHtqAz+REGSKui
 bQG7Gv4+Z2w7m8v35UYqWAqJ7bTl8tFTKYZvo0tGCW7lKu1CZji0ZrIAyzTBhrsZljUUzRpCaAqxCA
 tSGA3yTLPI8U2MdzektRPFBSEfQU/TlTwSNdFhxdNTAacs1HCHpXnSXATf38I2HsT4OR8f9zynEg/n
 PZqJ67Lv+iOnZx3ESzZ6ublhomHwSM3zL/Nua3WhLwh7S8jABMdjsAJueh7DuQu1ngJPkiqvBZPDUk
 aVwH27cPcNRTGmDdMefC5vJGwmcI39uedMVCyJ2TeO3ZA7tENg1xvJgn2anAM5rCSzQx2gKlMNGpnI
 gFqPqxsD5SzgmFhy397X7jvBeEGSTxdQqGrxyQDGa+YfhDY0OwsvX3dvvGIf8zaLTPPvYf3RgV1NfY
 rKhaYudkqE+JEI+cQm8DQ5SvLjRBeJWr7QeNLTowDyOSKUUOpJLrSGER9tew==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Half of the current "Quirks" are in fact features, so rename
the defines with FEAT instead of QUIRK.

They will be moved in a separate bitfield in a second time.

No functional changes.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c  | 62 +++++++++++++++---------------
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c      |  4 +-
 drivers/gpu/drm/msm/adreno/adreno_device.c |  2 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.h    |  7 ++--
 4 files changed, 38 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
index 0c560e84ad5a53bb4e8a49ba4e153ce9cf33f7ae..825c820def315968d508973c8ae40c7c7b646569 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
@@ -743,7 +743,7 @@ static const struct adreno_info a6xx_gpus[] = {
 		},
 		.gmem = SZ_512K,
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT,
+		.quirks = ADRENO_FEAT_HAS_CACHED_COHERENT,
 		.init = a6xx_gpu_init,
 		.zapfw = "a615_zap.mbn",
 		.a6xx = &(const struct a6xx_info) {
@@ -769,7 +769,7 @@ static const struct adreno_info a6xx_gpus[] = {
 		},
 		.gmem = SZ_512K,
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT,
+		.quirks = ADRENO_FEAT_HAS_CACHED_COHERENT,
 		.init = a6xx_gpu_init,
 		.a6xx = &(const struct a6xx_info) {
 			.protect = &a630_protect,
@@ -839,7 +839,7 @@ static const struct adreno_info a6xx_gpus[] = {
 		},
 		.gmem = SZ_512K,
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT,
+		.quirks = ADRENO_FEAT_HAS_CACHED_COHERENT,
 		.init = a6xx_gpu_init,
 		.zapfw = "a615_zap.mdt",
 		.a6xx = &(const struct a6xx_info) {
@@ -864,8 +864,8 @@ static const struct adreno_info a6xx_gpus[] = {
 		},
 		.gmem = SZ_512K,
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
-			  ADRENO_QUIRK_HAS_HW_APRIV,
+		.quirks = ADRENO_FEAT_HAS_CACHED_COHERENT |
+			  ADRENO_FEAT_HAS_HW_APRIV,
 		.init = a6xx_gpu_init,
 		.zapfw = "a620_zap.mbn",
 		.a6xx = &(const struct a6xx_info) {
@@ -892,7 +892,7 @@ static const struct adreno_info a6xx_gpus[] = {
 		},
 		.gmem = SZ_1M,
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT,
+		.quirks = ADRENO_FEAT_HAS_CACHED_COHERENT,
 		.init = a6xx_gpu_init,
 		.zapfw = "a630_zap.mdt",
 		.a6xx = &(const struct a6xx_info) {
@@ -911,7 +911,7 @@ static const struct adreno_info a6xx_gpus[] = {
 		},
 		.gmem = SZ_1M,
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT,
+		.quirks = ADRENO_FEAT_HAS_CACHED_COHERENT,
 		.init = a6xx_gpu_init,
 		.zapfw = "a640_zap.mdt",
 		.a6xx = &(const struct a6xx_info) {
@@ -934,8 +934,8 @@ static const struct adreno_info a6xx_gpus[] = {
 		},
 		.gmem = SZ_1M + SZ_128K,
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
-			ADRENO_QUIRK_HAS_HW_APRIV,
+		.quirks = ADRENO_FEAT_HAS_CACHED_COHERENT |
+			ADRENO_FEAT_HAS_HW_APRIV,
 		.init = a6xx_gpu_init,
 		.zapfw = "a650_zap.mdt",
 		.a6xx = &(const struct a6xx_info) {
@@ -961,8 +961,8 @@ static const struct adreno_info a6xx_gpus[] = {
 		},
 		.gmem = SZ_1M + SZ_512K,
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
-			ADRENO_QUIRK_HAS_HW_APRIV,
+		.quirks = ADRENO_FEAT_HAS_CACHED_COHERENT |
+			ADRENO_FEAT_HAS_HW_APRIV,
 		.init = a6xx_gpu_init,
 		.zapfw = "a660_zap.mdt",
 		.a6xx = &(const struct a6xx_info) {
@@ -981,8 +981,8 @@ static const struct adreno_info a6xx_gpus[] = {
 		},
 		.gmem = SZ_1M + SZ_512K,
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
-			ADRENO_QUIRK_HAS_HW_APRIV,
+		.quirks = ADRENO_FEAT_HAS_CACHED_COHERENT |
+			ADRENO_FEAT_HAS_HW_APRIV,
 		.init = a6xx_gpu_init,
 		.a6xx = &(const struct a6xx_info) {
 			.hwcg = a690_hwcg,
@@ -1000,8 +1000,8 @@ static const struct adreno_info a6xx_gpus[] = {
 		},
 		.gmem = SZ_512K,
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
-			ADRENO_QUIRK_HAS_HW_APRIV,
+		.quirks = ADRENO_FEAT_HAS_CACHED_COHERENT |
+			ADRENO_FEAT_HAS_HW_APRIV,
 		.init = a6xx_gpu_init,
 		.zapfw = "a660_zap.mbn",
 		.a6xx = &(const struct a6xx_info) {
@@ -1028,7 +1028,7 @@ static const struct adreno_info a6xx_gpus[] = {
 		},
 		.gmem = SZ_2M,
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT,
+		.quirks = ADRENO_FEAT_HAS_CACHED_COHERENT,
 		.init = a6xx_gpu_init,
 		.zapfw = "a640_zap.mdt",
 		.a6xx = &(const struct a6xx_info) {
@@ -1046,8 +1046,8 @@ static const struct adreno_info a6xx_gpus[] = {
 		},
 		.gmem = SZ_4M,
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
-			ADRENO_QUIRK_HAS_HW_APRIV,
+		.quirks = ADRENO_FEAT_HAS_CACHED_COHERENT |
+			ADRENO_FEAT_HAS_HW_APRIV,
 		.init = a6xx_gpu_init,
 		.zapfw = "a690_zap.mdt",
 		.a6xx = &(const struct a6xx_info) {
@@ -1331,7 +1331,7 @@ static const struct adreno_info a7xx_gpus[] = {
 		},
 		.gmem = SZ_128K,
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.quirks = ADRENO_QUIRK_HAS_HW_APRIV,
+		.quirks = ADRENO_FEAT_HAS_HW_APRIV,
 		.init = a6xx_gpu_init,
 		.zapfw = "a702_zap.mbn",
 		.a6xx = &(const struct a6xx_info) {
@@ -1355,9 +1355,9 @@ static const struct adreno_info a7xx_gpus[] = {
 		},
 		.gmem = SZ_2M,
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
-			  ADRENO_QUIRK_HAS_HW_APRIV |
-			  ADRENO_QUIRK_PREEMPTION,
+		.quirks = ADRENO_FEAT_HAS_CACHED_COHERENT |
+			  ADRENO_FEAT_HAS_HW_APRIV |
+			  ADRENO_FEAT_PREEMPTION,
 		.init = a6xx_gpu_init,
 		.zapfw = "a730_zap.mdt",
 		.a6xx = &(const struct a6xx_info) {
@@ -1377,9 +1377,9 @@ static const struct adreno_info a7xx_gpus[] = {
 		},
 		.gmem = 3 * SZ_1M,
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
-			  ADRENO_QUIRK_HAS_HW_APRIV |
-			  ADRENO_QUIRK_PREEMPTION,
+		.quirks = ADRENO_FEAT_HAS_CACHED_COHERENT |
+			  ADRENO_FEAT_HAS_HW_APRIV |
+			  ADRENO_FEAT_PREEMPTION,
 		.init = a6xx_gpu_init,
 		.zapfw = "a740_zap.mdt",
 		.a6xx = &(const struct a6xx_info) {
@@ -1400,9 +1400,9 @@ static const struct adreno_info a7xx_gpus[] = {
 		},
 		.gmem = 3 * SZ_1M,
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
-			  ADRENO_QUIRK_HAS_HW_APRIV |
-			  ADRENO_QUIRK_PREEMPTION,
+		.quirks = ADRENO_FEAT_HAS_CACHED_COHERENT |
+			  ADRENO_FEAT_HAS_HW_APRIV |
+			  ADRENO_FEAT_PREEMPTION,
 		.init = a6xx_gpu_init,
 		.a6xx = &(const struct a6xx_info) {
 			.hwcg = a740_hwcg,
@@ -1422,9 +1422,9 @@ static const struct adreno_info a7xx_gpus[] = {
 		},
 		.gmem = 3 * SZ_1M,
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
-			  ADRENO_QUIRK_HAS_HW_APRIV |
-			  ADRENO_QUIRK_PREEMPTION,
+		.quirks = ADRENO_FEAT_HAS_CACHED_COHERENT |
+			  ADRENO_FEAT_HAS_HW_APRIV |
+			  ADRENO_FEAT_PREEMPTION,
 		.init = a6xx_gpu_init,
 		.zapfw = "gen70900_zap.mbn",
 		.a6xx = &(const struct a6xx_info) {
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 019610341df1506c89f44e86b8d1deeb27d61857..2ebd3fac212576a1507e0b6afe2560cd0408dd89 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -2478,7 +2478,7 @@ struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
 	adreno_gpu->gmu_is_wrapper = of_device_is_compatible(node, "qcom,adreno-gmu-wrapper");
 
 	adreno_gpu->base.hw_apriv =
-		!!(config->info->quirks & ADRENO_QUIRK_HAS_HW_APRIV);
+		!!(config->info->quirks & ADRENO_FEAT_HAS_HW_APRIV);
 
 	/* gpu->info only gets assigned in adreno_gpu_init() */
 	is_a7xx = config->info->family == ADRENO_7XX_GEN1 ||
@@ -2495,7 +2495,7 @@ struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
 	}
 
 	if ((enable_preemption == 1) || (enable_preemption == -1 &&
-	    (config->info->quirks & ADRENO_QUIRK_PREEMPTION)))
+	    (config->info->quirks & ADRENO_FEAT_PREEMPTION)))
 		ret = adreno_gpu_init(dev, pdev, adreno_gpu, &funcs_a7xx, 4);
 	else if (is_a7xx)
 		ret = adreno_gpu_init(dev, pdev, adreno_gpu, &funcs_a7xx, 1);
diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 9ffe91920fbfb4841b28aabec9fbde94539fdd83..09d4569f77528c2a20cabc814668c4c930dd07f1 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -207,7 +207,7 @@ static int adreno_bind(struct device *dev, struct device *master, void *data)
 
 	priv->is_a2xx = info->family < ADRENO_3XX;
 	priv->has_cached_coherent =
-		!!(info->quirks & ADRENO_QUIRK_HAS_CACHED_COHERENT);
+		!!(info->quirks & ADRENO_FEAT_HAS_CACHED_COHERENT);
 
 	gpu = info->init(drm);
 	if (IS_ERR(gpu)) {
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index e71f420f8b3a8e6cfc52dd1c4d5a63ef3704a07f..8782c25e8a393ec7d9dc23ad450908d039bd08c5 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -54,9 +54,10 @@ enum adreno_family {
 #define ADRENO_QUIRK_TWO_PASS_USE_WFI		BIT(0)
 #define ADRENO_QUIRK_FAULT_DETECT_MASK		BIT(1)
 #define ADRENO_QUIRK_LMLOADKILL_DISABLE		BIT(2)
-#define ADRENO_QUIRK_HAS_HW_APRIV		BIT(3)
-#define ADRENO_QUIRK_HAS_CACHED_COHERENT	BIT(4)
-#define ADRENO_QUIRK_PREEMPTION			BIT(5)
+
+#define ADRENO_FEAT_HAS_HW_APRIV		BIT(3)
+#define ADRENO_FEAT_HAS_CACHED_COHERENT		BIT(4)
+#define ADRENO_FEAT_PREEMPTION			BIT(5)
 
 /* Helper for formating the chip_id in the way that userspace tools like
  * crashdec expect.

-- 
2.34.1


