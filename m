Return-Path: <linux-kernel+bounces-384844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3DB9B2F34
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 12:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BDCA282A80
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 11:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23AA1D88DD;
	Mon, 28 Oct 2024 11:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ol0mUU0o"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFD71D79A6
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 11:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730116167; cv=none; b=A/q0HMde74aIRdl6Y1pNHSD0qj5F2KvR9axmMczDdbqv7J8PWIMPhEwP6WwRHf8qC1226YJ5gnXscoh15Ia4rJt/5NJ8mdvejzwfjiu0bchJ7kStrBN7ynAEiTxzWayOEFxiLZFGi8fWsVQiovX2Rp566r1xbuVuzZ8ynzlPAc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730116167; c=relaxed/simple;
	bh=dFghqADYMbSL+guev7kK1X/DtcuvYC+qJqgVPidJ+3I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tIexUooOMAmSDRETBaTRIH01OYfeJkBqUVz8MtF09idk5N4ynSvCHqIEyHnWvpI6catO7QQefAzdkQfBpBPHaHMBlJ5+WFmqm8iBiMRdloSdce7VWOOIItlSGpkmsMDt/ZKqPRYW6k6C+OVAEU6bXgn8Z8a3thVacvPbfdY8h4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ol0mUU0o; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539e63c8678so4148368e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 04:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730116163; x=1730720963; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VqmvUC9mUBY81VNYk4RmO3UDZ88zAWNWEvKa6xvfBdA=;
        b=ol0mUU0o4k2Jbf0s3PKgi7YMj15HtJ96HiOtsh+1+gX+zxNmBm1FxtuPT6pXeCTEj3
         Gk+ECIpa3agNtoHzQuZ9/V/yiiEmEXR7jRwfyU/RZor48FSe9VEsQeWbPKY/NCkBtF8P
         1BM0KV947p/8MflfnH2FpKl23OwuMH+6zGRiUvmTjgeqZoecodf7t8F/RQLIxo+OpM5V
         ZXq8wxWHzJyjc2lokO6JRlsA4GbIMQCUC6qSuNS8bJCOmMbSasPB911sJveqUfnaiMod
         vM4uEXDH+YqPxOqNkXhqLDpt5xKFQrFHEfvVHew6UGtQX72wJZ2unOgXN6KYqUmpwOwB
         RD8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730116163; x=1730720963;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VqmvUC9mUBY81VNYk4RmO3UDZ88zAWNWEvKa6xvfBdA=;
        b=sitdTvz3Ijvsv+Omc9pyO0Q6stLc7KiWqoadhVcGeau0G3T4QEbBzwQMB2ZDD/DdLH
         PuGdGyquqDqQ0uo7jiRkkt/tc1JI79idoue+IR2JuEP2C7K39NqWTyv5kwOGEN7mU/qe
         rILu/wtXzuLrRJy6ViVqEQKDCh3PTMORWlerLDwI0OAAwgnwKaQ9cMBJ7O6iPqGp1PRy
         zgoqirR2rhApcvOPFZbZEiQ+1+J7/QfT0BkKDZOeSFEsN6/caWaY/z2XUHsLuh/IHyMh
         X8hOOgQbcj/Hxfk6GtPvLwgLVupN7DcXgDDqugpWIec5B1W7yKN6JikLXw2G5da7V9Rv
         M2pw==
X-Forwarded-Encrypted: i=1; AJvYcCWz15hqliVXlW8vXiLdOYtkL9JEpFDZtp/Xs4lLy6ueV/bRUOf0jXPaAshCCMz1W4/j7JwBkxrex/+FeQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOwavRKJCNBuW7zzGV0PTYB7LEGydudt5ho+Q50tM1zXVOt71w
	U92H2xZI00fg+vEZFG5azJ/ePDnnedY7hgAXDmhMNdcTIbQJ9xNhWyY5hTg9TQMeMi3rdYs4fB2
	+
X-Google-Smtp-Source: AGHT+IFCBFQVwMmMDF/1rXBfglFe8gtvZb2+qpDl4CdOJk48ndJWKJGzOzxpV5lLnpQrnF8u7NjzQg==
X-Received: by 2002:a05:6512:33cf:b0:52c:df6f:a66 with SMTP id 2adb3069b0e04-53b34b39628mr2359421e87.58.1730116163397;
        Mon, 28 Oct 2024 04:49:23 -0700 (PDT)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e10a5c6sm1042385e87.19.2024.10.28.04.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 04:49:23 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 28 Oct 2024 13:49:16 +0200
Subject: [PATCH 3/3] drm/msm/dp: tidy up platform data names
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241028-msm-dp-rename-v1-3-a2564e9457b0@linaro.org>
References: <20241028-msm-dp-rename-v1-0-a2564e9457b0@linaro.org>
In-Reply-To: <20241028-msm-dp-rename-v1-0-a2564e9457b0@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4825;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=dFghqADYMbSL+guev7kK1X/DtcuvYC+qJqgVPidJ+3I=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnH3o9hSNwX8nlxeM1HjSFvP+l6UmtoczeT12jJ
 6FQLwOy2U+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZx96PQAKCRCLPIo+Aiko
 1QM4B/sFhh+X0mTw7UUzLwrmpaCbAKOovwQlT2iXbBC25RFr2J2HdUS4qFB5bH3dlirFzXetMdl
 Q/Ax97WUoS8BnwAxlsnPIOZOHMyg3bHs8xRSSKwDt+Cha9xBTXaal6s1xUKGEbvtP28UVF9ybp/
 XAbgxBLtE45NUK0ZEqD5zdbcrsiKWt7i0FVpZwuBalqp5MXmd/2qkWwFxrDcOIctz4LFQTZ6Bhj
 esWjhy/xLLYxzuFk9YY7VoYfFlpf3EYs97SCB6xe+JkQMNw40ZQcQ4rwIqm/qStRiBDuOERjz2u
 7CffZgeS2ZYMq0a0EAm7RhmJdNkpr8CNMliNlWZ/juJkJKc7
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Follow the established symbol name pattern and rename platform data
structures.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 38 ++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 5cc349f672c0..aba925aab7ad 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -118,7 +118,7 @@ struct msm_dp_desc {
 	bool wide_bus_supported;
 };
 
-static const struct msm_dp_desc sa8775p_dp_descs[] = {
+static const struct msm_dp_desc msm_dp_desc_sa8775p[] = {
 	{ .io_start = 0x0af54000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true },
 	{ .io_start = 0x0af5c000, .id = MSM_DP_CONTROLLER_1, .wide_bus_supported = true },
 	{ .io_start = 0x22154000, .id = MSM_DP_CONTROLLER_2, .wide_bus_supported = true },
@@ -126,25 +126,25 @@ static const struct msm_dp_desc sa8775p_dp_descs[] = {
 	{}
 };
 
-static const struct msm_dp_desc sc7180_dp_descs[] = {
+static const struct msm_dp_desc msm_dp_desc_sc7180[] = {
 	{ .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true },
 	{}
 };
 
-static const struct msm_dp_desc sc7280_dp_descs[] = {
+static const struct msm_dp_desc msm_dp_desc_sc7280[] = {
 	{ .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true },
 	{ .io_start = 0x0aea0000, .id = MSM_DP_CONTROLLER_1, .wide_bus_supported = true },
 	{}
 };
 
-static const struct msm_dp_desc sc8180x_dp_descs[] = {
+static const struct msm_dp_desc msm_dp_desc_sc8180x[] = {
 	{ .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true },
 	{ .io_start = 0x0ae98000, .id = MSM_DP_CONTROLLER_1, .wide_bus_supported = true },
 	{ .io_start = 0x0ae9a000, .id = MSM_DP_CONTROLLER_2, .wide_bus_supported = true },
 	{}
 };
 
-static const struct msm_dp_desc sc8280xp_dp_descs[] = {
+static const struct msm_dp_desc msm_dp_desc_sc8280xp[] = {
 	{ .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true },
 	{ .io_start = 0x0ae98000, .id = MSM_DP_CONTROLLER_1, .wide_bus_supported = true },
 	{ .io_start = 0x0ae9a000, .id = MSM_DP_CONTROLLER_2, .wide_bus_supported = true },
@@ -156,12 +156,12 @@ static const struct msm_dp_desc sc8280xp_dp_descs[] = {
 	{}
 };
 
-static const struct msm_dp_desc sm8650_dp_descs[] = {
+static const struct msm_dp_desc msm_dp_desc_sm8650[] = {
 	{ .io_start = 0x0af54000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true },
 	{}
 };
 
-static const struct msm_dp_desc x1e80100_dp_descs[] = {
+static const struct msm_dp_desc msm_dp_desc_x1e80100[] = {
 	{ .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true },
 	{ .io_start = 0x0ae98000, .id = MSM_DP_CONTROLLER_1, .wide_bus_supported = true },
 	{ .io_start = 0x0ae9a000, .id = MSM_DP_CONTROLLER_2, .wide_bus_supported = true },
@@ -170,18 +170,18 @@ static const struct msm_dp_desc x1e80100_dp_descs[] = {
 };
 
 static const struct of_device_id msm_dp_dt_match[] = {
-	{ .compatible = "qcom,sa8775p-dp", .data = &sa8775p_dp_descs },
-	{ .compatible = "qcom,sc7180-dp", .data = &sc7180_dp_descs },
-	{ .compatible = "qcom,sc7280-dp", .data = &sc7280_dp_descs },
-	{ .compatible = "qcom,sc7280-edp", .data = &sc7280_dp_descs },
-	{ .compatible = "qcom,sc8180x-dp", .data = &sc8180x_dp_descs },
-	{ .compatible = "qcom,sc8180x-edp", .data = &sc8180x_dp_descs },
-	{ .compatible = "qcom,sc8280xp-dp", .data = &sc8280xp_dp_descs },
-	{ .compatible = "qcom,sc8280xp-edp", .data = &sc8280xp_dp_descs },
-	{ .compatible = "qcom,sdm845-dp", .data = &sc7180_dp_descs },
-	{ .compatible = "qcom,sm8350-dp", .data = &sc7180_dp_descs },
-	{ .compatible = "qcom,sm8650-dp", .data = &sm8650_dp_descs },
-	{ .compatible = "qcom,x1e80100-dp", .data = &x1e80100_dp_descs },
+	{ .compatible = "qcom,sa8775p-dp", .data = &msm_dp_desc_sa8775p },
+	{ .compatible = "qcom,sc7180-dp", .data = &msm_dp_desc_sc7180 },
+	{ .compatible = "qcom,sc7280-dp", .data = &msm_dp_desc_sc7280 },
+	{ .compatible = "qcom,sc7280-edp", .data = &msm_dp_desc_sc7280 },
+	{ .compatible = "qcom,sc8180x-dp", .data = &msm_dp_desc_sc8180x },
+	{ .compatible = "qcom,sc8180x-edp", .data = &msm_dp_desc_sc8180x },
+	{ .compatible = "qcom,sc8280xp-dp", .data = &msm_dp_desc_sc8280xp },
+	{ .compatible = "qcom,sc8280xp-edp", .data = &msm_dp_desc_sc8280xp },
+	{ .compatible = "qcom,sdm845-dp", .data = &msm_dp_desc_sc7180 },
+	{ .compatible = "qcom,sm8350-dp", .data = &msm_dp_desc_sc7180 },
+	{ .compatible = "qcom,sm8650-dp", .data = &msm_dp_desc_sm8650 },
+	{ .compatible = "qcom,x1e80100-dp", .data = &msm_dp_desc_x1e80100 },
 	{}
 };
 

-- 
2.39.5


