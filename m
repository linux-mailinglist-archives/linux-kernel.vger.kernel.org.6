Return-Path: <linux-kernel+bounces-225874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B85A3913696
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 00:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14D36B2537B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 22:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EC413048F;
	Sat, 22 Jun 2024 22:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zigctDxs"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75E112D755
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 22:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719093751; cv=none; b=fbUdqWvulLqc39IJDcK+fNFC8Rx2Sp6u+5TxcC8FvEi11o+X8j2HaYz5L1VJM4o/xab3wqUia2kS0c3zTMdHLdFywimc3rPQHa55+v75q8nYe0suvA4dzniLFqGIaIsrg0p56jNNrCdXa+AVhOlhh3vgHQn1f/+Ynmnlwa9l4zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719093751; c=relaxed/simple;
	bh=+t2U1RD/wb4G84+CRNoOtMFGJ3kapYkKIPOtVroW3X8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hMCApLAZhDJ5FbK4vhTPppvvGv3dfgIS4XERf8vGcJXElqvdz8UURsxvA8TwangkXAzY0vspY5U7wOJWhzrG4Ww2IhLK0hsKj2LnXxxTH3CHTQ0ga/HMWtbhkzvuoLJS0THKnShB5wwk6vfAVqU5xN5gTdOpT7Vn7SjVYDLWfxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zigctDxs; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ec52fbb50bso11500031fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 15:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719093748; x=1719698548; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PGHdc8YiA3WTHk5P8vKAyvQjRr5JX9fvWorT4SZVW8k=;
        b=zigctDxsFgeSbB5UVq2zYFm3pb9XYa6GeO8NIgjOqaBmDW/vyZD8Q6wE/nbZ+QgFGP
         pbi5PiEusWKY11mzE4ZLnkxethyB5idx4ppCJsUnnkGcNMFXufeqxA9JCCp+EPV9gVMH
         ZW0wlg84JG4wm+adgCqLOofo/3m1AVguyr7Xz6dcwh5BMIpIqWIitZqSUNUg9J/uf8DW
         DjJWfArULztuBJcz9RdnUyggOpfR3MGAqil1r6YUN9TddYQp4Az/JhOojzEeRWvOGNH9
         G4VOCpllbSpZfN/i7Q7pIoF8Qo9dB/GmwPpiwKMmFqD7feBDXWr0HETH8ztOom1gGj+u
         Bt0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719093748; x=1719698548;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PGHdc8YiA3WTHk5P8vKAyvQjRr5JX9fvWorT4SZVW8k=;
        b=KeHfau6auoWgWn+M5Vzp3qISNrrQ8FVEeW2VPC3aiTzJPl2ZIVxGfI6d/sd4hj8hPF
         lpN8CiAS3R7cN7CTzCBUnWmyTobQTxNgcHa7NXK6d32bavPW7ZNOnkWgmUigEXNwmV5r
         dhHEvOZOV4VBCjLOophYBe126Y8eeEMx6JsuDlnMVMkk9GighjBRthwL8GN/5wWsdIkL
         B3PYngLNf49PSSBEnM5rC6AS8aF34PzG0x2GI1J7DhAXNqpx0+N1HBGB5OL2ITvj9OEy
         LoGSapuuXMnU1LHPApHlfhurvMcHlW/Ildk2sh2HxLzt/0ChAQMknc4yunLLVcT/bVRm
         ox3g==
X-Forwarded-Encrypted: i=1; AJvYcCVqE4yNF4PpDS4kMzqHVzkGWbIaXjn1BBCSzKmAEg1z4vTG0PMV5a9Z2VLI9HurR0p19rjL7e7djI0+mUrHJCZVf5c+nNtO9vi+zYyC
X-Gm-Message-State: AOJu0Yz60sqzR4RxigEWCvg1sSihcBJcBWFbQxghe23Rjk5dLDJiIj6P
	prF6jaT/oIc1jASvm9SPJQlSq5boBLbYlXgu95xdAxvbPgcd0gx4wD3lQqHkTcI=
X-Google-Smtp-Source: AGHT+IFdNEvT/KXwtp6byJyVArrLJT0q2zVKjTyW+suLZeO+39QYIbtNWDX5qi9Reqa4HCGgijjkUg==
X-Received: by 2002:a2e:9596:0:b0:2ec:1dfc:45bf with SMTP id 38308e7fff4ca-2ec5b3d496emr4164051fa.42.1719093748156;
        Sat, 22 Jun 2024 15:02:28 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec55e56ea5sm2502051fa.112.2024.06.22.15.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 15:02:27 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 23 Jun 2024 01:02:26 +0300
Subject: [PATCH v3 13/13] drm/msm/hdmi: wire in hpd_enable/hpd_disable
 bridge ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240623-fd-hdmi-hpd-v3-13-8645a64cbd63@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4028;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=+t2U1RD/wb4G84+CRNoOtMFGJ3kapYkKIPOtVroW3X8=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmd0nquPw6MxmqYJ+vfPQc/Atbn/P9DAqJmmFQt
 Yr+/Lkja2qJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZndJ6gAKCRCLPIo+Aiko
 1WRqB/0efKfu2G2+t6qny4TOcmCSPhfPu7OOFom+3b421qfQbFXUny/DZ0W1AA8kEu/gH1pBcKb
 /Gws4qXxf9719+rG6htWlLc6pDbh2X5GSLl+Gw2LdNgSGOlsBPgcb+rAULRVP0tinf9SC1kJFsF
 238GTjIRY666bROxfOHEnjuzpRj+zLo9Wfdk48mySvgxvQuN4qBUCwFWTLAQA/a5H3UqbbeyGp6
 04u6qOgMk1JiEGG1tlW8bE9zQ+KEku0p6WGCKqKEnt0ooO3l0WjtDshGualV6i2ay5P0U82l+Jp
 odceYaWBvcqku8OEIZPpnxkiwVAbXMF76xQQMvqutiryQ8Zo
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The HDMI driver already has msm_hdmi_hpd_enable() and
msm_hdmi_hpd_disable() functions. Wire them into the
msm_hdmi_bridge_funcs, so that HPD  can be enabled and disabled
dynamically rather than always having HPD events generation enabled.

Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/hdmi/hdmi.c        |  9 ---------
 drivers/gpu/drm/msm/hdmi/hdmi.h        |  4 ++--
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c |  4 ++++
 drivers/gpu/drm/msm/hdmi/hdmi_hpd.c    | 12 ++++++------
 4 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.c b/drivers/gpu/drm/msm/hdmi/hdmi.c
index 9f1de4c9ffdf..7621d17b57b8 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi.c
@@ -201,12 +201,6 @@ int msm_hdmi_modeset_init(struct hdmi *hdmi,
 		goto fail;
 	}
 
-	ret = msm_hdmi_hpd_enable(hdmi->bridge);
-	if (ret < 0) {
-		DRM_DEV_ERROR(&hdmi->pdev->dev, "failed to enable HPD: %d\n", ret);
-		goto fail;
-	}
-
 	return 0;
 
 fail:
@@ -352,9 +346,6 @@ static void msm_hdmi_unbind(struct device *dev, struct device *master,
 		if (priv->hdmi->audio_pdev)
 			platform_device_unregister(priv->hdmi->audio_pdev);
 
-		if (priv->hdmi->bridge)
-			msm_hdmi_hpd_disable(priv->hdmi);
-
 		msm_hdmi_destroy(priv->hdmi);
 		priv->hdmi = NULL;
 	}
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.h b/drivers/gpu/drm/msm/hdmi/hdmi.h
index 9961dae9e9b3..96f2a982c766 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi.h
+++ b/drivers/gpu/drm/msm/hdmi/hdmi.h
@@ -207,8 +207,8 @@ int msm_hdmi_bridge_init(struct hdmi *hdmi);
 void msm_hdmi_hpd_irq(struct drm_bridge *bridge);
 enum drm_connector_status msm_hdmi_bridge_detect(
 		struct drm_bridge *bridge);
-int msm_hdmi_hpd_enable(struct drm_bridge *bridge);
-void msm_hdmi_hpd_disable(struct hdmi *hdmi);
+void msm_hdmi_hpd_enable(struct drm_bridge *bridge);
+void msm_hdmi_hpd_disable(struct drm_bridge *bridge);
 
 /*
  * i2c adapter for ddc:
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
index 7bf1c3b379c1..0441d728afc8 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
@@ -465,6 +465,10 @@ static const struct drm_bridge_funcs msm_hdmi_bridge_funcs = {
 	.mode_valid = msm_hdmi_bridge_mode_valid,
 	.edid_read = msm_hdmi_bridge_edid_read,
 	.detect = msm_hdmi_bridge_detect,
+
+	.hpd_enable = msm_hdmi_hpd_enable,
+	.hpd_disable = msm_hdmi_hpd_disable,
+
 	.hdmi_clear_infoframe = msm_hdmi_bridge_clear_infoframe,
 	.hdmi_write_infoframe = msm_hdmi_bridge_write_infoframe,
 };
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_hpd.c b/drivers/gpu/drm/msm/hdmi/hdmi_hpd.c
index cb89e9e2c6ea..04d00b6f36fd 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_hpd.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_hpd.c
@@ -60,7 +60,7 @@ static void msm_hdmi_phy_reset(struct hdmi *hdmi)
 	}
 }
 
-int msm_hdmi_hpd_enable(struct drm_bridge *bridge)
+void msm_hdmi_hpd_enable(struct drm_bridge *bridge)
 {
 	struct hdmi_bridge *hdmi_bridge = to_hdmi_bridge(bridge);
 	struct hdmi *hdmi = hdmi_bridge->hdmi;
@@ -70,8 +70,8 @@ int msm_hdmi_hpd_enable(struct drm_bridge *bridge)
 	unsigned long flags;
 
 	ret = pm_runtime_resume_and_get(dev);
-	if (ret)
-		return ret;
+	if (WARN_ON(ret))
+		return;
 
 	mutex_lock(&hdmi->state_mutex);
 	msm_hdmi_set_mode(hdmi, false);
@@ -99,12 +99,12 @@ int msm_hdmi_hpd_enable(struct drm_bridge *bridge)
 	hdmi_write(hdmi, REG_HDMI_HPD_CTRL,
 			HDMI_HPD_CTRL_ENABLE | hpd_ctrl);
 	spin_unlock_irqrestore(&hdmi->reg_lock, flags);
-
-	return 0;
 }
 
-void msm_hdmi_hpd_disable(struct hdmi *hdmi)
+void msm_hdmi_hpd_disable(struct drm_bridge *bridge)
 {
+	struct hdmi_bridge *hdmi_bridge = to_hdmi_bridge(bridge);
+	struct hdmi *hdmi = hdmi_bridge->hdmi;
 	struct device *dev = &hdmi->pdev->dev;
 
 	/* Disable HPD interrupt */

-- 
2.39.2


