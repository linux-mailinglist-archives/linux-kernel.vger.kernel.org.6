Return-Path: <linux-kernel+bounces-400847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D03DD9C132C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 01:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8B7D1C21498
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 00:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B876DDD2;
	Fri,  8 Nov 2024 00:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x3lKpOtM"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BD4CA64
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 00:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731025336; cv=none; b=NdbE1K9z/RM4sxGfrI2h2bSmrCHUzMKU32jxSU9ctLUlCPEwj9gzZKvmg4zRRueWGRbzeay5e10wGFIKRyycIoJ8oVY25D8uPgYetI2rXcV5DoqYR+zgBbp6E4fQn9yXSbAmvMgboX9XbAPScX5LlOHRVedM+LOugbfsSd8Da9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731025336; c=relaxed/simple;
	bh=+MBwJhJ+kWsOd4zG8stBduLkJa3ofaC7qfvHFVuut/U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c1prFODxkLl3U/IQgVkXFKA0jmYvR0J2MEWXjUbR+0jlEHPoRncp5bAYMjq5fpk95VEX0N+MLzKg+NdR0sQt9y/kNhGSWHdb9CNLib3KD9yayIIeIhkOoIUDY3Nf7u7INZKbN/GnIton+KDfYPflbfuMET/usLjewX6DOEPPzX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x3lKpOtM; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539f0f9ee49so1700750e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 16:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731025333; x=1731630133; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H3tHYib9bOsjsCSxYQbmNPxmjHFq56TfU4OCDc5PW2A=;
        b=x3lKpOtMquBlIE2d0717z+Ef4w6vKw7ci1Hlgpj1uLzXxKyjTWK0hicKSWQ43Yxa7k
         8luV9I2rRbxywkJ1LAujS+GWm6Z0gdFd2O9KCcPJPwzXR23iky1A+OSOS3w7VDXLIfpb
         uUkXIRwL4Ssn84TsAoq2I5BBCJfdyD8gEITXHuaM/xiyb/eluTxFeHzrcBILQPHyDLtE
         q61emIQwQJ0ADy5+a6hQUVHlqKI8StPq9lVjqDalDBCnkSueUy4pFIvc9SSBwthCayCo
         TN/mm9tHdX4BkO1u5xhL1hYGKRj1nkTlJ23GdoezaghdmRHtgVE52ExTp2R2ZEAVNxPR
         K8/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731025333; x=1731630133;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H3tHYib9bOsjsCSxYQbmNPxmjHFq56TfU4OCDc5PW2A=;
        b=c8hVcxSO1Kyy5CCeH9TzZMSCVRdSdWOI+gy3Hqv45L8yYBAO4e/rBn3xLWVt0iDejd
         bQ6SdOtkHn0nPHbtNtiiN5OGJgmR5QNsh3cRPDy0w0sW63qAO8d6OR2s6OHqAGx+ajwp
         /OfYwQehOpZkcRd9hCv2yy3rUeExDKv98uGb5vd6wFxwUIkP3PNfmoqk8QPyUHj9cngB
         Y3C3USU8VudmI4OkjOuaijV1b7vuaocC5JZrTMFMJOeBnlVE3d4gHkJ3C50UIE+7kP1j
         Ecj/Tg5HMsU4Bcto5/z7alfZvVPdC3k76DjH28CqO0Ny24Rx9JPm6o9Wb0jAI2ELYxVc
         n9lw==
X-Forwarded-Encrypted: i=1; AJvYcCUst7xvcFUlxNP/xaY2KgosNnxjGm1wnZ1EOQ26+gXmXmFxvY63tENRWNaODgiuc1FkQPfWnRb/+ZYjIvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcmVJL5tSCRG7Qm7aK2SkT0fzkipgxFaK3t0u+sUNTQI2Ftt3N
	OY+Nu7GYa8dZ+dD8KNvz9xMQX1N6qySrR4UuQygAerwsdiEb+c9Uc7Q1mVkOOKU=
X-Google-Smtp-Source: AGHT+IH7NpwR+EtpupNJY1T4XFQnZfGFyrAFdQKX3vDkAZgHm3HUYKz++E/GmQxGdczzNngFriYsnQ==
X-Received: by 2002:a05:651c:1589:b0:2fb:5bb8:7c24 with SMTP id 38308e7fff4ca-2ff20152825mr3776181fa.8.1731025332771;
        Thu, 07 Nov 2024 16:22:12 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ff17900a63sm4195191fa.47.2024.11.07.16.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 16:22:11 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 08 Nov 2024 02:21:44 +0200
Subject: [PATCH 13/14] drm/msm/dp: drop struct msm_dp_panel_in
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241108-fd-dp-audio-fixup-v1-13-40c8eeb60cf5@linaro.org>
References: <20241108-fd-dp-audio-fixup-v1-0-40c8eeb60cf5@linaro.org>
In-Reply-To: <20241108-fd-dp-audio-fixup-v1-0-40c8eeb60cf5@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Paloma Arellano <quic_parellan@quicinc.com>
Cc: Douglas Anderson <dianders@chromium.org>, 
 Stephen Boyd <swboyd@chromium.org>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3781;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=+MBwJhJ+kWsOd4zG8stBduLkJa3ofaC7qfvHFVuut/U=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnLVmQ9emA0NkGmbuBJO5bIw1pGCdfRbWpJGcGv
 U6PeakRvW2JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZy1ZkAAKCRCLPIo+Aiko
 1YmnB/49tkHi3iF28qy6bExEcNimP6jsHsacWo0NUj1XuyiFiP3oYDLQGvFLZu6s2PVL23RU5JE
 9JsdhEpt5pG7SZ6KjqSq7PmnFiVVxp36o1q3JISx2UBwZrYrASwGaxkOp0Hq/neGeAulv0kxuVw
 zAgk0d2PPqsxnPfELVHoUGbjIzYapnTA9JdRxtTAziRCJax6tem27cmRrL6X719xDSc+Lzx3R/1
 ixy49WLJ5DcCfUvEyfIvFeiyUnY5j7JugfHm/R4mHFOsRn3Pb277Ew+mUhvl7XEOxZa5WcsA+un
 4ltybwYS/VxOvjhtMxdGtM4/9ClixltO+HR2cIos04m2fnnk
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

All other submodules pass arguments directly. Drop struct
msm_dp_panel_in that is used to wrap dp_panel's submodule args and pass
all data to msm_dp_panel_get() directly.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/dp/dp_display.c |  9 +--------
 drivers/gpu/drm/msm/dp/dp_panel.c   | 15 ++++++++-------
 drivers/gpu/drm/msm/dp/dp_panel.h   | 10 ++--------
 3 files changed, 11 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 72a46e9e319486bc4ec1f5c842d733bd55ce0a67..8f8fa0cb8af67383ecfce026ee8840f70b82e6da 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -722,9 +722,6 @@ static int msm_dp_init_sub_modules(struct msm_dp_display_private *dp)
 {
 	int rc = 0;
 	struct device *dev = &dp->msm_dp_display.pdev->dev;
-	struct msm_dp_panel_in panel_in = {
-		.dev = dev,
-	};
 	struct phy *phy;
 
 	phy = devm_phy_get(dev, "dp");
@@ -765,11 +762,7 @@ static int msm_dp_init_sub_modules(struct msm_dp_display_private *dp)
 		goto error_link;
 	}
 
-	panel_in.aux = dp->aux;
-	panel_in.catalog = dp->catalog;
-	panel_in.link = dp->link;
-
-	dp->panel = msm_dp_panel_get(&panel_in);
+	dp->panel = msm_dp_panel_get(dev, dp->aux, dp->link, dp->catalog);
 	if (IS_ERR(dp->panel)) {
 		rc = PTR_ERR(dp->panel);
 		DRM_ERROR("failed to initialize panel, rc = %d\n", rc);
diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/dp_panel.c
index 58045d9a52e9a4d39362c3de623fa34acd5784ec..6e6dc3169e9c2f84273e599100602583550f521c 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.c
+++ b/drivers/gpu/drm/msm/dp/dp_panel.c
@@ -549,25 +549,26 @@ static int msm_dp_panel_parse_dt(struct msm_dp_panel *msm_dp_panel)
 	return 0;
 }
 
-struct msm_dp_panel *msm_dp_panel_get(struct msm_dp_panel_in *in)
+struct msm_dp_panel *msm_dp_panel_get(struct device *dev, struct drm_dp_aux *aux,
+			      struct msm_dp_link *link, struct msm_dp_catalog *catalog)
 {
 	struct msm_dp_panel_private *panel;
 	struct msm_dp_panel *msm_dp_panel;
 	int ret;
 
-	if (!in->dev || !in->catalog || !in->aux || !in->link) {
+	if (!dev || !catalog || !aux || !link) {
 		DRM_ERROR("invalid input\n");
 		return ERR_PTR(-EINVAL);
 	}
 
-	panel = devm_kzalloc(in->dev, sizeof(*panel), GFP_KERNEL);
+	panel = devm_kzalloc(dev, sizeof(*panel), GFP_KERNEL);
 	if (!panel)
 		return ERR_PTR(-ENOMEM);
 
-	panel->dev = in->dev;
-	panel->aux = in->aux;
-	panel->catalog = in->catalog;
-	panel->link = in->link;
+	panel->dev = dev;
+	panel->aux = aux;
+	panel->catalog = catalog;
+	panel->link = link;
 
 	msm_dp_panel = &panel->msm_dp_panel;
 	msm_dp_panel->max_bw_code = DP_LINK_BW_8_1;
diff --git a/drivers/gpu/drm/msm/dp/dp_panel.h b/drivers/gpu/drm/msm/dp/dp_panel.h
index 332ac79594e71157e2b087dc5268c50a87993d83..482ead77e7c01e6d611dbdce37f82a8dfbc4e3e4 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.h
+++ b/drivers/gpu/drm/msm/dp/dp_panel.h
@@ -21,13 +21,6 @@ struct msm_dp_display_mode {
 	bool out_fmt_is_yuv_420;
 };
 
-struct msm_dp_panel_in {
-	struct device *dev;
-	struct drm_dp_aux *aux;
-	struct msm_dp_link *link;
-	struct msm_dp_catalog *catalog;
-};
-
 struct msm_dp_panel_psr {
 	u8 version;
 	u8 capabilities;
@@ -93,6 +86,7 @@ static inline bool is_lane_count_valid(u32 lane_count)
 		lane_count == 4);
 }
 
-struct msm_dp_panel *msm_dp_panel_get(struct msm_dp_panel_in *in);
+struct msm_dp_panel *msm_dp_panel_get(struct device *dev, struct drm_dp_aux *aux,
+			      struct msm_dp_link *link, struct msm_dp_catalog *catalog);
 void msm_dp_panel_put(struct msm_dp_panel *msm_dp_panel);
 #endif /* _DP_PANEL_H_ */

-- 
2.39.5


