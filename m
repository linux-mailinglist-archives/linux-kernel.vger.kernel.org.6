Return-Path: <linux-kernel+bounces-442388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E391B9EDC23
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 00:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66EC328220B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 23:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0BB8203D7D;
	Wed, 11 Dec 2024 23:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TQV0vO0G"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2933203D6F
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 23:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733960543; cv=none; b=EYvkK/gNjZF2yJKWz32zBjQ0ElBD1DaCFLXhHnYMplqwaeaGyZN9Qp1I8eZeIO8P/E36GA4PHSRT0HyFOy5mGjHqXXQ62n6AeJXvlV2juskHXEt761nkQME7UASznEgtWyPnS1HbtkyczWWBpU2CuYWxJo0zDZuPOURqy0rQkgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733960543; c=relaxed/simple;
	bh=MMvFCqfALU6wJGnue5h/pJv8DRZdW1yevlezkUKG1JM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qER+mlk9ZijNuc9/P5wY/+oHyTLp0uW6KWERy89XcxBSA1/jgtoBolh0FxBrcYNbd9lfZgA2vc38CZ+cpclyStW8eCPwhq9gus+4ASx0GsIrOFBdfcAKle0KQcLZCxVrGC6uQWa/l8bc3LvvS/Usr3Axh3CB3Rf5Y2KH1HMYKW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TQV0vO0G; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53e3a227b82so15316e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 15:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733960540; x=1734565340; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qE7GDtRTStTKn7zTKbCKRrNoh4JnzGeSHWe+F3Oy/c4=;
        b=TQV0vO0GgXCHh0mDYr22WPDwb9A/RzJs2aAem9lPuMchrUr6IGMhhZkNMyXamzPDGL
         tgqNmU3OfyLjxZEwDJ5+eec6/yghKa7JgPZcUKXQYHXV9KFX4RzNLPCd9H0rGhiylHPb
         bzOcfPYSis5NDJGsu40t4hY8vOWNHJp2UcdXvcL0su63sQ5MeYZzHZJusaYAXm6YJAC1
         WXHmDFqFhIZbp3fFLsU1T6cm3yVE7jRXp/wvShsIS/TXEeEI7PKJiQSjK5sneBJyL/7b
         Hbap+hFfWf989+ecQLxEruGVFVQKpz3/K2XbXxvDF2wGiolrkm8PSNDM5z5ZEZN0xJHc
         JaHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733960540; x=1734565340;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qE7GDtRTStTKn7zTKbCKRrNoh4JnzGeSHWe+F3Oy/c4=;
        b=HUKbGOekMgovmgSco4Po06RXYCxfOKq3JkEMQxqa/XzJNRX+QrIw4cfYfpBFE7fY+3
         rsulRIobJM+b00LBegB/Jbe446sIfP1hdJ8uI0DVRHT6hbHRG6SkP0pY3EDvxv+Aqr9+
         yMmsF/gLF3G/USfm8LnR6joXCJUcAwN7jKxwXNK0mUEXiVNhO0tl2WIrs6kgdupssKj0
         F1ZpluC8daasaTVbTKzScIRNDqR5jYnir0vEKv4kiuQMu4APlo8/PxTVvTFTcYZYwRu6
         DZ/QJcexw5carYMycr5iaP+98+yHQdBGD9/ZJF6ku+fveT0caLyw4FTtSpfhJpmBwrE5
         prtA==
X-Forwarded-Encrypted: i=1; AJvYcCX1EoSQavZLebaVRJnnJEfZMM7SU3HX1stA0Ma3ro/Knr8c4hhjVWNIEcNHOhjYOH7TCxRGYAT4y3kFGK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXIblq6nI9bugwQxniCtThg9UQ9V1ggnyOgx7q0xxbysBrwFFf
	1/YymsI70zfz4efuh0RJthdh8poRU4jbn+J7LmvE11zquACgO/1HuAEY+IF6UF0=
X-Gm-Gg: ASbGncvosJLjP5kdSZUZJH7iJ0dteo4yMelvnlwIF5Kb4hsEwmJpPCLFtVPDg8lwgTC
	6Rm1VaJbCs4oTWPPY6RSeghKJ27AMrNi32Gy6CslBWyMHge06tAXefTJV8XcgylSVPfLSPJNoao
	XcbLYtjwDmhjwwqB+d6ecIznlgkbedZcUqja/2VM8bJif0ospslDaZ2jNVKOmN6ehqs63rk+LSi
	EGCTqR24XNf+wA4cpR/H+I6eX/05nXpRzTZSFv8LkzYMX40nbBhEaoPslHtwA==
X-Google-Smtp-Source: AGHT+IHV/gS244rNWMbZoF7ZJs+GMe2+NwsjTqUbRwLIukPaiz09y59qS8DRvo52E+Lvw8sNNYtzgw==
X-Received: by 2002:a05:6512:b23:b0:540:1d0a:57f5 with SMTP id 2adb3069b0e04-5402f00b8dfmr475551e87.22.1733960539965;
        Wed, 11 Dec 2024 15:42:19 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5401cc76909sm1222207e87.58.2024.12.11.15.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 15:42:18 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 12 Dec 2024 01:41:48 +0200
Subject: [PATCH v3 13/14] drm/msm/dp: drop struct msm_dp_panel_in
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-fd-dp-audio-fixup-v3-13-0b1c65e7dba3@linaro.org>
References: <20241212-fd-dp-audio-fixup-v3-0-0b1c65e7dba3@linaro.org>
In-Reply-To: <20241212-fd-dp-audio-fixup-v3-0-0b1c65e7dba3@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Paloma Arellano <quic_parellan@quicinc.com>
Cc: Douglas Anderson <dianders@chromium.org>, 
 Stephen Boyd <swboyd@chromium.org>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3830;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=MMvFCqfALU6wJGnue5h/pJv8DRZdW1yevlezkUKG1JM=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnWiM5JfTAka5yOe8WD4DIrb4G1HNDkAAKSav7k
 WeZp3UjeNaJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ1ojOQAKCRCLPIo+Aiko
 1YRMCACWvpBhLFtz3kgiXuXfdW5Vh8vyZyOPtkS+ev+stKCA26jNaowHDR7ccgmYyhCsV5k36Nh
 W5KSKNDGUa06xBZkdMoUuUi96CHTTJSgZC++C3O85o5TxznHG1E7ynlDkn5sPXan5I9JxOnwLcD
 KibsKIQz70ufHCaBFA80+OEZPrS1Sbs+j+N0LLVSPGOnibc1K+U3QOqS5YvytUwUmg0saa2zvlL
 USzFu3om+M5Vi9HLlj92q8RkKH4V9CEU+2yWSAYNa/SFgruzOkmFvx89uquBF/yslrl0C11Qvij
 VroT01XOwxDNY/xU4MUo31anFZFGe+PX1Auw4uJq4BmAq5Tf
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

All other submodules pass arguments directly. Drop struct
msm_dp_panel_in that is used to wrap dp_panel's submodule args and pass
all data to msm_dp_panel_get() directly.

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/dp/dp_display.c |  9 +--------
 drivers/gpu/drm/msm/dp/dp_panel.c   | 15 ++++++++-------
 drivers/gpu/drm/msm/dp/dp_panel.h   | 10 ++--------
 3 files changed, 11 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index cb02d5d5b404925707c737ed75e9e83fbec34f83..a2cdcdac042d63a59ff71aefcecb7f8b22f01167 100644
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


