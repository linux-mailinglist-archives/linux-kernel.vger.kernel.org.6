Return-Path: <linux-kernel+bounces-225873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D03FB913695
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 00:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32A76B251EB
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 22:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC02512FB15;
	Sat, 22 Jun 2024 22:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TkU4oKLV"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8C712C528
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 22:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719093750; cv=none; b=SnLF8vTLGCh4W44ohiebXLxLeglQkq3aEMQ851l7gL0wq3J/N44I/na5OHQN2i1Hv4aYoF/y6SBoQJnw5sVYGOEuAcD6Oyp2vWmGVaI7X0eGR0VQspcK8eW76wnHrJX3Vi6aV9mRaA7bhrTGFduduSBhoIqyMT5Mi0M9XEVXBGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719093750; c=relaxed/simple;
	bh=IKMVsya9o4vBvDRk/2sR0JSKyG59n+7WHe8B9IcbVug=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Uhy0f082e0OsM2pIChYveNWPmalC5J078CeBUavcyI2RE0gejiq2v2OsygXHAwqgqqma2OxLAOePoF1S85Yy9mWaSSlJq6Lr3kkPsMBoLW1TTaP37MvmQd50+8GyLTQOWCkIr+LrVKDC6W+ZTj5LS59LgpNsdz7lCwrRORQtTNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TkU4oKLV; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ec50d4e46aso15444741fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 15:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719093747; x=1719698547; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=slg0qL1615VPI0XhTFhgJhcThug3uChho064CYgmjts=;
        b=TkU4oKLVAX6aOth+I9PJRJNmteKbKltasBFVSNMLK1aLnUGnuJwSU7qxwv+J+ivRRv
         pZgBz6/zOg9d35hV7+p2hbJEITW7j1wlh17MPGGwR3atPp1trNkh6ADhh/4Lrj79GAiy
         MKUuscF4is9T9R0ZITCzsW5GoqKK0IgZJIj1mT2C4By+0Ul5nyOnovJjNdDPq8eBfhII
         GLLgolaxTi1jZYktTllvpuGmNxbk0bCRKdDSeJfXNXPtMW+YGoeiVG7Tghs0M/pZStKo
         POqc9hJxZS5ybRvgOm9Pe1AQgA05hUcoCh5XJGT+QFywVaMR4Gvu30HEBgwgDCMI9x2i
         W4pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719093747; x=1719698547;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=slg0qL1615VPI0XhTFhgJhcThug3uChho064CYgmjts=;
        b=smvi8WbtDMJLOUqsPK+4Tt3kmdWR3pQT9RZNrh4mpHA65Pn/o66WyOCTrbAHN50uGr
         kETQPYGBv78EcKk8EJ7gV+nXOiCf5bVU0DuVIQSRfGYyDsda7PciSHmVxA6GMnb+FtWO
         sabPxr0CAcp/Fzcuau3z9SRrS21Q9tCWiF1zZIMBhqAOw7dBdAXpB3waFErTxtEpqjQJ
         qrGzJK7M8koGPqxpqxqpjx11rphpqXdkUTWGxXSO9YMYOpa4VmBOj9jqfXc/69fPpgXL
         zIy+53/+G+vGNZ01UdtB4L5aCZyrmIGDwSuA5OSPPaN/h1bASCLyB3b3qyJ+kgq79xtV
         +y+w==
X-Forwarded-Encrypted: i=1; AJvYcCW6XgTUqN5Zijhph+drJ90HWpP0h95TjZFtQZZ/LP97w4MFy7GCONxkXl0spO2Dw8di/lI5ctrTUAnD/QZIN06XqUjXPs7vjAgKGxs+
X-Gm-Message-State: AOJu0YznQr2aQYXqU5A968TD10s4Su9nJPVG8QLj2MPVUGgTTk0aaZvm
	hXfnCxaBhd7ZdUFQjjvF2jQq4bb3YlQpbZmZo0XXpRV5RBCfOOfkRSAp+QxouOG/hJrHiUyMidL
	UcLY=
X-Google-Smtp-Source: AGHT+IGlPIj5UFpVQffFP/O71H4/VkTdmWVZVeEYyLy33LbFBbp/GGAmyVjfwBO4mNKfN+aZKytF1w==
X-Received: by 2002:a2e:9dd2:0:b0:2ec:1810:e50a with SMTP id 38308e7fff4ca-2ec579c7736mr10820961fa.32.1719093746800;
        Sat, 22 Jun 2024 15:02:26 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec55e56ea5sm2502051fa.112.2024.06.22.15.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 15:02:26 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 23 Jun 2024 01:02:24 +0300
Subject: [PATCH v3 11/13] drm/msm/hdmi: drop hpd-gpios support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240623-fd-hdmi-hpd-v3-11-8645a64cbd63@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4367;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=IKMVsya9o4vBvDRk/2sR0JSKyG59n+7WHe8B9IcbVug=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmd0npCD6Z1JlEKMd5Xt6fWP/5+MYZxbs0Pns8Z
 tA3YnXppWKJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZndJ6QAKCRCLPIo+Aiko
 1TrtB/4ntzjJ9mo6sr4ZpNbnT+nE7xDo1MbRSkh0RHfGqJk18duXSZbmag5HLSZQfjFdnZNmULO
 TR0lTwPMsirdvHzUlwHY0sSl6Bz0jbVoInwVNzhQ86mo23bgr67ncHJuugx7VYbQmZZ0/nz44OY
 +CL98Yb4ipuv82HksLGHqe01zIk/wvKjFLKuZylljbZPCpv71Nx8IxMArk1cIPqB4oe28YgDoX5
 KdVCRO482mNPGqvuWNDNPFfgVxGbrgrcWwwGV3XqfaWxO7O2V/2WHpsUcfObIf3viYEDqDiK0YM
 8xRuiYfmRxEmUZvertIk8Yz9uUtb+z2qeh+4HbanVSlW+7LB
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Supporting simultaneous check of native HPD and the external GPIO proved
to be less stable than just native HPD. Drop the hpd-gpios support,
leaving just the native HPD support. In case the native HPD doesn't work
the user is urged to switch to specifying the HPD property to the
hdmi-connector device.

Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/hdmi/hdmi.c     | 14 +++-------
 drivers/gpu/drm/msm/hdmi/hdmi.h     |  2 --
 drivers/gpu/drm/msm/hdmi/hdmi_hpd.c | 53 +++----------------------------------
 3 files changed, 7 insertions(+), 62 deletions(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.c b/drivers/gpu/drm/msm/hdmi/hdmi.c
index 5ba9a23ef122..97faa7d26cc9 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi.c
@@ -443,17 +443,9 @@ static int msm_hdmi_dev_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(hdmi->extp_clk),
 				     "failed to get extp clock\n");
 
-	hdmi->hpd_gpiod = devm_gpiod_get_optional(&pdev->dev, "hpd", GPIOD_IN);
-	/* This will catch e.g. -EPROBE_DEFER */
-	if (IS_ERR(hdmi->hpd_gpiod))
-		return dev_err_probe(dev, PTR_ERR(hdmi->hpd_gpiod),
-				     "failed to get hpd gpio\n");
-
-	if (!hdmi->hpd_gpiod)
-		DBG("failed to get HPD gpio");
-
-	if (hdmi->hpd_gpiod)
-		gpiod_set_consumer_name(hdmi->hpd_gpiod, "HDMI_HPD");
+	if (of_find_property(dev->of_node, "hpd-gpios", NULL) ||
+	    of_find_property(dev->of_node, "hpd-gpio", NULL))
+		dev_warn(dev, "hpd-gpios is not supported anymore, please migrate to the hdmi-connector\n");
 
 	ret = msm_hdmi_get_phy(hdmi);
 	if (ret) {
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.h b/drivers/gpu/drm/msm/hdmi/hdmi.h
index 1c2e46d38792..6faf4397ed58 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi.h
+++ b/drivers/gpu/drm/msm/hdmi/hdmi.h
@@ -52,8 +52,6 @@ struct hdmi {
 	struct clk_bulk_data *pwr_clks;
 	struct clk *extp_clk;
 
-	struct gpio_desc *hpd_gpiod;
-
 	struct hdmi_phy *phy;
 	struct device *phy_dev;
 
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_hpd.c b/drivers/gpu/drm/msm/hdmi/hdmi_hpd.c
index 32e447267e3b..d3353c6148ed 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_hpd.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_hpd.c
@@ -69,9 +69,6 @@ int msm_hdmi_hpd_enable(struct drm_bridge *bridge)
 	int ret;
 	unsigned long flags;
 
-	if (hdmi->hpd_gpiod)
-		gpiod_set_value_cansleep(hdmi->hpd_gpiod, 1);
-
 	ret = pm_runtime_resume_and_get(dev);
 	if (ret)
 		return ret;
@@ -144,8 +141,11 @@ void msm_hdmi_hpd_irq(struct drm_bridge *bridge)
 	}
 }
 
-static enum drm_connector_status detect_reg(struct hdmi *hdmi)
+enum drm_connector_status msm_hdmi_bridge_detect(
+		struct drm_bridge *bridge)
 {
+	struct hdmi_bridge *hdmi_bridge = to_hdmi_bridge(bridge);
+	struct hdmi *hdmi = hdmi_bridge->hdmi;
 	uint32_t hpd_int_status = 0;
 	int ret;
 
@@ -161,48 +161,3 @@ static enum drm_connector_status detect_reg(struct hdmi *hdmi)
 	return (hpd_int_status & HDMI_HPD_INT_STATUS_CABLE_DETECTED) ?
 			connector_status_connected : connector_status_disconnected;
 }
-
-#define HPD_GPIO_INDEX	2
-static enum drm_connector_status detect_gpio(struct hdmi *hdmi)
-{
-	return gpiod_get_value(hdmi->hpd_gpiod) ?
-			connector_status_connected :
-			connector_status_disconnected;
-}
-
-enum drm_connector_status msm_hdmi_bridge_detect(
-		struct drm_bridge *bridge)
-{
-	struct hdmi_bridge *hdmi_bridge = to_hdmi_bridge(bridge);
-	struct hdmi *hdmi = hdmi_bridge->hdmi;
-	enum drm_connector_status stat_gpio, stat_reg;
-	int retry = 20;
-
-	/*
-	 * some platforms may not have hpd gpio. Rely only on the status
-	 * provided by REG_HDMI_HPD_INT_STATUS in this case.
-	 */
-	if (!hdmi->hpd_gpiod)
-		return detect_reg(hdmi);
-
-	do {
-		stat_gpio = detect_gpio(hdmi);
-		stat_reg  = detect_reg(hdmi);
-
-		if (stat_gpio == stat_reg)
-			break;
-
-		mdelay(10);
-	} while (--retry);
-
-	/* the status we get from reading gpio seems to be more reliable,
-	 * so trust that one the most if we didn't manage to get hdmi and
-	 * gpio status to agree:
-	 */
-	if (stat_gpio != stat_reg) {
-		DBG("HDMI_HPD_INT_STATUS tells us: %d", stat_reg);
-		DBG("hpd gpio tells us: %d", stat_gpio);
-	}
-
-	return stat_gpio;
-}

-- 
2.39.2


