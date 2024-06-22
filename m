Return-Path: <linux-kernel+bounces-225867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 253CC913688
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 00:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 896F7B248BE
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 22:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D812084FAF;
	Sat, 22 Jun 2024 22:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LwBuFPm7"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265E57E116
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 22:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719093745; cv=none; b=FG1nYxqOXRQ+ibbe0qaj9k5kQgeXl9LuKEAG7SVE/HajyPdPPESl9TnHK1TUfgFkUa9zV2Et/hpVysWcbSrmWrrsUi47LTON2yvVEfR0pK6rEnQDOqvc50nPHc02OE6HexJbD0VE9kNbgZPJ9g+aZxUhYvk1B+O6Ykld6OxJ9rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719093745; c=relaxed/simple;
	bh=qMMhEiJGtMf2g7v1irJOBZTZd4gqQt3vmkW+yduYJ5w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VH6y7TgCWysi9gWk3ezFoJ0gUh+bwblyYDvhm7VF4Cm4yzDtAz57is+pH4A9Pns02E6lME+DXcL0PytIIRPMvf1TOTlv2Ujr3/aMmf0xpCX1+TjPWvWLX81G+PtaZw4dUfmPK0bdEGyozJiIIKTZVYQ6eF2JagKeAWRsDk092ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LwBuFPm7; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2eabd22d3f4so38420721fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 15:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719093742; x=1719698542; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IStmo6xiSWG0asaFWCQdK/NUgiLLAmlGd9tuwPv/Qx0=;
        b=LwBuFPm7in1YOgzE7NSqr4qP4GMq6tEsopol0AM2qZt6EWqUSwVm+lqdirSN3wG1eh
         tLBnztZFPjOlZLkb/ZqN6fzEr73izNZJWEvjaRDd/A0bfSqMjDXNFRLG+aMFmWFj35ev
         ykAQ5kfQ40FPpZz41qpu3QbbYfoQGnoZNd+USrHR4a7VVtCn6BOCPRxowhcRrNz/I0tw
         mCtyf6H+Mipt/Xtg+vC8FcH+PuY5v+X2cTcsjwc0+xJJAc3sEX42CtZ1jx362dvQyUna
         kOIxn5seVaz7HbhfLAn4E10ENoIBJXax9uZoiwKSV7Ck6css1w9+gsBTT431C0UtdpLX
         nUzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719093742; x=1719698542;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IStmo6xiSWG0asaFWCQdK/NUgiLLAmlGd9tuwPv/Qx0=;
        b=bPDtrANc9OZNERkS0aMhGf10SPw1rYTSDscIqyP6uZHCfhuiNTqcgAFFhqIFMh0orr
         Q9CQpZZ6yh2Bm0G7UhpXWC0bEfdoY+EZ3Uht4zSW2me6mDUsEvjK3WDWxbHgirZNJzqg
         lTcHf8ucAaeA5fV8GSdGfzmJwiCIWY8fqzWjsXb7RKP8yxZk3AzoJiSGg5ZHAr2yhUOC
         a67w5B/l/OR3RmlgpWKpuiB/lAFyYjmEl4rhXUTKjRBJX4uUVZ+fKYwjLpb8v1F8T6Ip
         Ee+eVaXhDvYz781XZLwWZdcgmN4GtPyg5sBgMDntcAquKDGzl8cVjxETwVyIrhLKK4ns
         9KiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkR1Hoa41I5ZV2KoOd//z7o5UBZ6hy88qgAJIluFjxrerJPSLiVVgn0DeuPnPyQUVjmoKwOuJvbPI0M1ewbjxT4Is2i5SVwZ0K6MZQ
X-Gm-Message-State: AOJu0YzTeH6VE4zWyE7keMtFMzuOTpWCi71DkxeX2AaXsGZ6sBry74c/
	2IMMDPx9eCWxHOH2W8XQE5VdIBJzy6+/n0RCR1RAPB6Xf2I9tol/C2XOMNL9BCI=
X-Google-Smtp-Source: AGHT+IGZw2H42wRxJ9RELBzDAP73A8ArscgXWtc/kskvhjttQIpurWMQBXx/wCa9YqSVGmJ+FU/ycA==
X-Received: by 2002:a2e:bb91:0:b0:2ec:5d83:32da with SMTP id 38308e7fff4ca-2ec5d833347mr723941fa.49.1719093742334;
        Sat, 22 Jun 2024 15:02:22 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec55e56ea5sm2502051fa.112.2024.06.22.15.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 15:02:21 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 23 Jun 2024 01:02:18 +0300
Subject: [PATCH v3 05/13] drm/msm/hdmi: switch to clk_bulk API
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240623-fd-hdmi-hpd-v3-5-8645a64cbd63@linaro.org>
References: <20240623-fd-hdmi-hpd-v3-0-8645a64cbd63@linaro.org>
In-Reply-To: <20240623-fd-hdmi-hpd-v3-0-8645a64cbd63@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Jessica Zhang <quic_jesszhan@quicinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4314;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=qMMhEiJGtMf2g7v1irJOBZTZd4gqQt3vmkW+yduYJ5w=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmd0noBQU1rT1FyJzLhckR2v0eX7J4AfLxZpRoy
 d67H5nPZKiJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZndJ6AAKCRCLPIo+Aiko
 1daxB/4iHvTDj3eKXXuQIHW9ezTQ5XvP0B+X2hJ8MSDqBPVuF1y3b3M6piEYFQyVphx44+S2XHM
 EuHs3LUkO5BU2Konqk2/BrVIZyEnRkHJk6y4e8jeMQ3WH8RIFf/IEGrjn7qGWmc1nA2BeNH+Bhe
 MKV4a258b5NCYtAvBqaUZjyS8PZKedfmpHbItgRdGorqa7YBH6HBBw4IZ/U2pAJac0rK2mKcDwT
 JO91ws3loQkpjWNFoF1NtKmSeISaos4OYIForCVkGtVB8oBpID9SMadU45F5KrdMuRTRlkWZIJc
 B2h05d1J89ERRbDb60mu/8yToRHCMfhHEc0kTy/1dN3XSJXY
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The last platform using legacy clock names for HDMI block (APQ8064)
switched to new clock names in 5.16. It's time to stop caring about old
DT, drop hand-coded helpers and switch to clk_bulk_* API.

Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/hdmi/hdmi.c     | 15 +++++---------
 drivers/gpu/drm/msm/hdmi/hdmi.h     |  2 +-
 drivers/gpu/drm/msm/hdmi/hdmi_hpd.c | 39 +++++++++++++------------------------
 3 files changed, 19 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.c b/drivers/gpu/drm/msm/hdmi/hdmi.c
index 9a39ad1847b9..34c1aac5feab 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi.c
@@ -444,17 +444,12 @@ static int msm_hdmi_dev_probe(struct platform_device *pdev)
 	if (!hdmi->hpd_clks)
 		return -ENOMEM;
 
-	for (i = 0; i < config->hpd_clk_cnt; i++) {
-		struct clk *clk;
+	for (i = 0; i < config->hpd_clk_cnt; i++)
+		hdmi->hpd_clks[i].id = config->hpd_clk_names[i];
 
-		clk = msm_clk_get(pdev, config->hpd_clk_names[i]);
-		if (IS_ERR(clk))
-			return dev_err_probe(dev, PTR_ERR(clk),
-					     "failed to get hpd clk: %s\n",
-					     config->hpd_clk_names[i]);
-
-		hdmi->hpd_clks[i] = clk;
-	}
+	ret = devm_clk_bulk_get(&pdev->dev, config->hpd_clk_cnt, hdmi->hpd_clks);
+	if (ret)
+		return ret;
 
 	hdmi->extp_clk = devm_clk_get_optional(&pdev->dev, "extp");
 	if (IS_ERR(hdmi->extp_clk))
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.h b/drivers/gpu/drm/msm/hdmi/hdmi.h
index 14472b2d6229..287e6d33fb85 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi.h
+++ b/drivers/gpu/drm/msm/hdmi/hdmi.h
@@ -50,7 +50,7 @@ struct hdmi {
 
 	struct regulator_bulk_data *hpd_regs;
 	struct regulator_bulk_data *pwr_regs;
-	struct clk **hpd_clks;
+	struct clk_bulk_data *hpd_clks;
 	struct clk *extp_clk;
 
 	struct gpio_desc *hpd_gpiod;
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_hpd.c b/drivers/gpu/drm/msm/hdmi/hdmi_hpd.c
index 7ae69b14e953..36266aa626dc 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_hpd.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_hpd.c
@@ -60,27 +60,6 @@ static void msm_hdmi_phy_reset(struct hdmi *hdmi)
 	}
 }
 
-static void enable_hpd_clocks(struct hdmi *hdmi, bool enable)
-{
-	const struct hdmi_platform_config *config = hdmi->config;
-	struct device *dev = &hdmi->pdev->dev;
-	int i, ret;
-
-	if (enable) {
-		for (i = 0; i < config->hpd_clk_cnt; i++) {
-			ret = clk_prepare_enable(hdmi->hpd_clks[i]);
-			if (ret) {
-				DRM_DEV_ERROR(dev,
-					"failed to enable hpd clk: %s (%d)\n",
-					config->hpd_clk_names[i], ret);
-			}
-		}
-	} else {
-		for (i = config->hpd_clk_cnt - 1; i >= 0; i--)
-			clk_disable_unprepare(hdmi->hpd_clks[i]);
-	}
-}
-
 int msm_hdmi_hpd_enable(struct drm_bridge *bridge)
 {
 	struct hdmi_bridge *hdmi_bridge = to_hdmi_bridge(bridge);
@@ -107,7 +86,9 @@ int msm_hdmi_hpd_enable(struct drm_bridge *bridge)
 		gpiod_set_value_cansleep(hdmi->hpd_gpiod, 1);
 
 	pm_runtime_get_sync(dev);
-	enable_hpd_clocks(hdmi, true);
+	ret = clk_bulk_prepare_enable(config->hpd_clk_cnt, hdmi->hpd_clks);
+	if (ret)
+		goto fail;
 
 	msm_hdmi_set_mode(hdmi, false);
 	msm_hdmi_phy_reset(hdmi);
@@ -149,7 +130,7 @@ void msm_hdmi_hpd_disable(struct hdmi *hdmi)
 
 	msm_hdmi_set_mode(hdmi, false);
 
-	enable_hpd_clocks(hdmi, false);
+	clk_bulk_disable_unprepare(config->hpd_clk_cnt, hdmi->hpd_clks);
 	pm_runtime_put(dev);
 
 	ret = pinctrl_pm_select_sleep_state(dev);
@@ -193,14 +174,20 @@ void msm_hdmi_hpd_irq(struct drm_bridge *bridge)
 
 static enum drm_connector_status detect_reg(struct hdmi *hdmi)
 {
-	uint32_t hpd_int_status;
+	const struct hdmi_platform_config *config = hdmi->config;
+	uint32_t hpd_int_status = 0;
+	int ret;
 
 	pm_runtime_get_sync(&hdmi->pdev->dev);
-	enable_hpd_clocks(hdmi, true);
+	ret = clk_bulk_prepare_enable(config->hpd_clk_cnt, hdmi->hpd_clks);
+	if (ret)
+		goto out;
 
 	hpd_int_status = hdmi_read(hdmi, REG_HDMI_HPD_INT_STATUS);
 
-	enable_hpd_clocks(hdmi, false);
+	clk_bulk_disable_unprepare(config->hpd_clk_cnt, hdmi->hpd_clks);
+
+out:
 	pm_runtime_put(&hdmi->pdev->dev);
 
 	return (hpd_int_status & HDMI_HPD_INT_STATUS_CABLE_DETECTED) ?

-- 
2.39.2


