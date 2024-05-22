Return-Path: <linux-kernel+bounces-186078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F8D8CBFAA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 12:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B94128394E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 10:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C12D84A32;
	Wed, 22 May 2024 10:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jt0d8YIR"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D4382890
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 10:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716375067; cv=none; b=Tb02NgYMNW7YyQtaDoQeN+g5LLvO8IWXce8eZNw+7eIEb4llZW8rt7bkyErKH3ocx6kYJOywkPUqldVcwpRDWhEwC51R0E7orS7b1RdzOmXn6poEJIgTPeVjIFMqymQrsSZ19E1lM3nWnvOIobNPWQZZcQCifvbAT+QnXUbahTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716375067; c=relaxed/simple;
	bh=rVRKl0jVYPeqcqz91TQ881Equ4F+ZgpwdiZXFz89P0g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F35pyq1v2jY2MV64LGKsL5RemafPSRB0dovLx4k29J/uQiGlfplomA13CkTJ9dpGbH3PQ9StMVL5ZVDJ/L5agl2r5Wxq5RUS5xIs5xgtDHJ/NwIYMFjXEowVUibnPB7Wcshc1+kEuCcFBMe/cNTIm+oAWM8gMdzUNKv4S1T6cug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jt0d8YIR; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2e72b8931caso35065091fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 03:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716375063; x=1716979863; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IAmphMNQpXqW8eT1O41Bu5TdohycNUyawz5wYr1vHd8=;
        b=Jt0d8YIRnom2NpB7q0YHMMJKbXklgQdCgbEqOsOoSTwR2YxgkYDr0KJHiOPlUkM2h5
         WvZDh0/QgolGHG96cncqfJwnAWykHmNjsaw4ceL8JPT9Ust/70HbvKMHH8j4Rbx7th7d
         z4Ddgq29+tGTC+JEbo8GXD2+/k8OGLjvmpagHjZtyi9sHN97hXjoMLHdxGoV/WGa0Ohl
         gEwSluI+QK2ZtL9JNMPqk4vEld2BWgciB52ZeNie0BtKFz/W3AvQSyGaLuR88G14EYD+
         x1gDO9KG9e+ifDcaSrhG8Xb967GfsPWu0ADduCI3CCEImBDUq9bnpubWPzwO3AzYFM8a
         bRLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716375063; x=1716979863;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IAmphMNQpXqW8eT1O41Bu5TdohycNUyawz5wYr1vHd8=;
        b=bnQzePfHOwLDOQGRa7V4jkxFsHKTJu1DZXZ6wF3ILUO9A2Lg07vtNyFfV6nOyFfPz+
         cEbP+aPZT6mOc5b7U+usJcmxpOidNCke65TOq47Jp3iK3CAG46fPMpgFZ/hsaOqDeJg9
         1V4xdA8ElFrcB0T1Z1Y1r42VtejlfW7DCaHac6Krj/vbJsv6+RAx752T6zDO6se/q1dT
         9hXBl8BPWwcCAgxv9bHdSYacbEM/McFXKRxoyGwCQapNcrHTtlCkmcJ+1EA3i47Fbwrj
         wBBRebLRCON0lA5wuucRRAiDigffVO8zQ+ZyT1vqz+adL/jzFb8Po+WlnTtoKbY1ig6Q
         phxw==
X-Forwarded-Encrypted: i=1; AJvYcCWs0PqHnNo6oxED8M4pJCJPmr0RXYJ1/HXDcnamJvyHwIUsScrSjagkpZWpMbnx5/p+tJ165lobACk+BXJWdHTL+FBRnzbtKOIr8GOw
X-Gm-Message-State: AOJu0YyVqp/CYU22wz6p0DpkyHFJA7an59Nln4Vl7fIQeEHzCZ3U3Xbe
	F+T+Rtnc5neSwQPwEQSQCyyzgR3hgiRrTc5oZV+2RzUkiLCmKPfVMJ1UwFw8Y2Q=
X-Google-Smtp-Source: AGHT+IFvKJh7JOYXQJKM2qi5VIh0iYd/BGRN6yDP29LSOK7OX2zXaEKTsibdu8B9a2dC6ZHLhKrCjQ==
X-Received: by 2002:a19:6a09:0:b0:51d:5f0b:816f with SMTP id 2adb3069b0e04-526bf35c690mr832319e87.15.1716375063679;
        Wed, 22 May 2024 03:51:03 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52431778ec8sm1279126e87.194.2024.05.22.03.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 03:51:03 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 22 May 2024 13:50:59 +0300
Subject: [PATCH v2 07/14] drm/msm/hdmi: switch to
 pm_runtime_resume_and_get()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240522-fd-hdmi-hpd-v2-7-c30bdb7c5c7e@linaro.org>
References: <20240522-fd-hdmi-hpd-v2-0-c30bdb7c5c7e@linaro.org>
In-Reply-To: <20240522-fd-hdmi-hpd-v2-0-c30bdb7c5c7e@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2613;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=rVRKl0jVYPeqcqz91TQ881Equ4F+ZgpwdiZXFz89P0g=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmTc4QmHQVBTWzpD8Jbi0KRzPokGAEgSr3P4vPX
 6mb04s1+KiJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZk3OEAAKCRCLPIo+Aiko
 1fSQCACsc4K3scUWB77PU9aHBfrcHuUnWfl6JI/ujLNtLgxLO3Gc1GO2QfCPmY0NwhqA29kIB18
 vJ21o26KCmZINsMjIV/y7yFwUEX+oa4+2d39ZLu/s1YkR1wasrTckdY0sPYebJxxkNc9JAjaO0p
 ofgIEbCuajfb1AJFLf+ygf9ALiPRqLlVVM3rWvN/sxeHKiahb+TE4NbHaUzdTCas5RCFj5rDVQj
 QQz2mdlVfmrp82eJwicfGToeL6X2DSvkTQ1UtsBCEt/a0Bo5uUd42ND5xfcWVrxZSEwox3LzVDh
 W9TTH9jpEtbTPnHu8fjEp4MQknreKmXwj8w06V01FkXAesNB
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The pm_runtime_get_sync() function is a bad choise for runtime power
management. Switch HDMI driver to pm_runtime_resume_and_get() and add
proper error handling, while we are at it.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c |  2 +-
 drivers/gpu/drm/msm/hdmi/hdmi_hpd.c    | 12 ++++++++++--
 drivers/gpu/drm/msm/hdmi/hdmi_phy.c    |  6 +++++-
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
index fb99328107dd..d1b35328b6e8 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
@@ -19,7 +19,7 @@ static void msm_hdmi_power_on(struct drm_bridge *bridge)
 	const struct hdmi_platform_config *config = hdmi->config;
 	int ret;
 
-	pm_runtime_get_sync(&hdmi->pdev->dev);
+	pm_runtime_resume_and_get(&hdmi->pdev->dev);
 
 	ret = regulator_bulk_enable(config->pwr_reg_cnt, hdmi->pwr_regs);
 	if (ret)
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_hpd.c b/drivers/gpu/drm/msm/hdmi/hdmi_hpd.c
index 36266aa626dc..fc21ad3b01dc 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_hpd.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_hpd.c
@@ -85,7 +85,12 @@ int msm_hdmi_hpd_enable(struct drm_bridge *bridge)
 	if (hdmi->hpd_gpiod)
 		gpiod_set_value_cansleep(hdmi->hpd_gpiod, 1);
 
-	pm_runtime_get_sync(dev);
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret) {
+		DRM_DEV_ERROR(dev, "runtime resume failed: %d\n", ret);
+		goto fail;
+	}
+
 	ret = clk_bulk_prepare_enable(config->hpd_clk_cnt, hdmi->hpd_clks);
 	if (ret)
 		goto fail;
@@ -178,7 +183,10 @@ static enum drm_connector_status detect_reg(struct hdmi *hdmi)
 	uint32_t hpd_int_status = 0;
 	int ret;
 
-	pm_runtime_get_sync(&hdmi->pdev->dev);
+	ret = pm_runtime_resume_and_get(&hdmi->pdev->dev);
+	if (ret)
+		goto out;
+
 	ret = clk_bulk_prepare_enable(config->hpd_clk_cnt, hdmi->hpd_clks);
 	if (ret)
 		goto out;
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_phy.c b/drivers/gpu/drm/msm/hdmi/hdmi_phy.c
index 88a3423b7f24..d5acae752300 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_phy.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_phy.c
@@ -58,7 +58,11 @@ int msm_hdmi_phy_resource_enable(struct hdmi_phy *phy)
 	struct device *dev = &phy->pdev->dev;
 	int i, ret = 0;
 
-	pm_runtime_get_sync(dev);
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret) {
+		DRM_DEV_ERROR(dev, "runtime resume failed: %d\n", ret);
+		return ret;
+	}
 
 	ret = regulator_bulk_enable(cfg->num_regs, phy->regs);
 	if (ret) {

-- 
2.39.2


