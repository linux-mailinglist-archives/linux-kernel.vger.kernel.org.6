Return-Path: <linux-kernel+bounces-427227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E519DFE5C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 11:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88807B23F4F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 10:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D59202F7B;
	Mon,  2 Dec 2024 10:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WtPEpeeL"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FC5201002
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 10:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733134032; cv=none; b=JFtj0WJcMmM6bKp8TgpPiMDw4m5PQEzFvtHy8ekQIg5bOghq0bJVyjP2dMpsroD61jTl+YyD4qeOoWfyiO6AqSG5KIg0sDOq5QuRcb9LKcbFenlCJR4DZ3oFQ1/jGBqvaAHmreChmJ6KUtIx2eSKmHTOW4X90YxkyHSGsVce6ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733134032; c=relaxed/simple;
	bh=hDpj7vY5jvimaiQwwIUKclDnHIm8+qEsXCeipWGCjes=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kVyEs3/5KAFWOV8Dys04fGg1XAsHos60eujObRJTW5/FnuMb34Cdtr2ruGVVj5voEgkmSF457Yzd0HIrtU/SlK7lXSPYYppFq6hLCzH8Df61xaTKzO0RV8IoBflL7azrf+b20SN9+HbbsDzpsBFRshzNA2g1LG+DdFFk+z2d/hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WtPEpeeL; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53de84e4005so4408533e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 02:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733134028; x=1733738828; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fHRYPd5A4NgreKRdZCJAPxaFkFBdQ1h5Bfa5TPxM+bk=;
        b=WtPEpeeL7oR2A/Fb6C5yemRrm7mqYzNfG++2g5xquUHGKqghrje6zuZ/tGsMmisjpU
         e+J79MMhhnaRnUwuAgQk55LCGDzHhDy7pRsg+Cu8LVi7X7o/UnsGixLutbpK0A+K4R+5
         hRgM94xlGwyZiKeEKSAXfvT3s7c42rPiGaHLujMZ6F6Az7bbGzERGfRZg5rz90Xh5yVE
         JR2pTUQWB+2Dp5jJr3ssNOO9L83Og4HeFYAU+5qJUFXVKUY0zY5qBzsBFi4RfXyomdZn
         PZp81fV2+VcGy0W3D9g6qrAC7edJ1vNOLxVW13x1jr44oIwF6M2PUG3eSPI/DvGZY+WW
         tqJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733134028; x=1733738828;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fHRYPd5A4NgreKRdZCJAPxaFkFBdQ1h5Bfa5TPxM+bk=;
        b=HwDAXlePzEYn8QQbXFWgIsbIyPdi4qZ5j5BGGtNp0moRV+bMmGI59szYWI8H6zI3vg
         0cJEwJDp4aM4HPF8dQyTUWn/O4P7/cwuAxcqc1gccJ64hCZJedRCRQIY9fgHZzabdhT0
         fksqIFT6E1FfmaEMNkDuTiesy37wi70kdM1WnF8P6myLqGKyMcd9tfALd0BWaPKGgQlC
         nSe/rRJbpTml7dVEzGxxZKJfskJ6VKs+v3uPW3zgvb097w6juxUnOhlzgFWbiCzx2wqa
         i2yXBpP7LGe5w0OL/K7Xmrm6C0XX/47XDlo3pHSX/HqLo1+KIdRuHL2KMJMu7AGTz0xv
         IAuA==
X-Forwarded-Encrypted: i=1; AJvYcCV80spP2oHh6Jv6KEwbjzcdOHT6oYe8MgtY2Uf0/4jC5pUX+Q7XCzwqjobLpJIqaTT2rVP0NGsFmZ3Mink=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtnyrbqIxDeRl90l2S1lGMj1sYuUOd1bycfb/FL6jF3+/qNVFH
	DCcZJOPkHAFQW+mIWkexPtJXS8aeU6F1gNQKfysgrnlbgve1WZPkl2iQkJvBbSI=
X-Gm-Gg: ASbGnctIS8wmVMt4D7CIS84/H+c3QqGJa4Lma41hZU070ezOjty6QZ/GlYr7ufWsatv
	1lpl0hbaxU5rRFFibEl/Z2QXJbgS9ady2UmCn+KFaci/N8tBO1w8L1JyeXb/uwIFMrHoEW9OIBr
	1/iILp6kF//IUbVUdsKav4ABT78tRoArcYyZeTkvL6DEIShwPrLaIk4DbLC9mHPU2QQWDxVGtKH
	w76iYOZgS+qZblP0irRuBOh1YBx93qJAwxqMoGi4IbQDvxd64Nf7gtngQ==
X-Google-Smtp-Source: AGHT+IGFQ+tjS81xvDFCKlpDg7emgbUGZasiElTcowgmlaHXlpKkPeHfN+l6U0RcX0Ld8NISce3YVg==
X-Received: by 2002:a05:6512:b97:b0:53d:e8ed:2172 with SMTP id 2adb3069b0e04-53df00d71cfmr10971553e87.14.1733134028463;
        Mon, 02 Dec 2024 02:07:08 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df646f191sm1418314e87.136.2024.12.02.02.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 02:07:07 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 02 Dec 2024 12:06:43 +0200
Subject: [PATCH v2 13/14] drm/msm/dp: drop struct msm_dp_panel_in
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-fd-dp-audio-fixup-v2-13-d9187ea96dad@linaro.org>
References: <20241202-fd-dp-audio-fixup-v2-0-d9187ea96dad@linaro.org>
In-Reply-To: <20241202-fd-dp-audio-fixup-v2-0-d9187ea96dad@linaro.org>
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
 bh=hDpj7vY5jvimaiQwwIUKclDnHIm8+qEsXCeipWGCjes=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnTYauBZKl5PS9wkKoW5I8AIY3aHaHU+G9eAu+W
 LM9zxVyQ4iJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ02GrgAKCRCLPIo+Aiko
 1bQAB/4r8Xx7b3LO9yJdmYhEu3ZSMxV4udShpzlyquTlR2vuGRZ5CTPvU+xdQk5ct3kltbDKu/+
 2TmaBmGoqi0VrY25UN2hEmswOtlee1YBEobixLUfiA+64jAW4nd4i+Lje5xb9bYSFKD0Ev14FrM
 xevfNYGI7cfizQJLkXWPS08yBiZVFCwLfmRpBgEGH5r4iFJOBinDOzxO25FPe/a06YirWC8vPWk
 epnRzKXHU667G3MbKzmU/Wpa6es5ggieU4JHv0LHQJI6r8kQRLcHthmF6MnjnWKXMLkxb21OHds
 KauNIYCeU85JsYPuWYaZwiMVy+6TPgpbNgEI8EJ/l5rIt2LI
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
index 25869e2ac93aba0bffeddae9f95917d81870d8cb..49bbcde8cf60ac1b297310a50191135d79b092fb 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.c
+++ b/drivers/gpu/drm/msm/dp/dp_panel.c
@@ -659,25 +659,26 @@ static int msm_dp_panel_parse_dt(struct msm_dp_panel *msm_dp_panel)
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
index f305b1151118b53762368905b70d951a366ba1a8..a4719a3bbbddd18304227a006e82a5ce9ad7bbf3 100644
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
@@ -94,6 +87,7 @@ static inline bool is_lane_count_valid(u32 lane_count)
 		lane_count == 4);
 }
 
-struct msm_dp_panel *msm_dp_panel_get(struct msm_dp_panel_in *in);
+struct msm_dp_panel *msm_dp_panel_get(struct device *dev, struct drm_dp_aux *aux,
+			      struct msm_dp_link *link, struct msm_dp_catalog *catalog);
 void msm_dp_panel_put(struct msm_dp_panel *msm_dp_panel);
 #endif /* _DP_PANEL_H_ */

-- 
2.39.5


