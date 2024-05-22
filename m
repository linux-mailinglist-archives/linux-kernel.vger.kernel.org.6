Return-Path: <linux-kernel+bounces-186084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DDD8CBFB6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 12:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBFEA1C21BC9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 10:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B52885289;
	Wed, 22 May 2024 10:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tm8MlPwx"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B236684E0C
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 10:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716375072; cv=none; b=jiMIJ9XkySr+tNKD1j1uulFeUhB1UrZbPbnH32I06ZDlRGHS3hUOztyv9RMNTaG4lQzNHn5XIsTm1tiSzuKGGxuo7ySgvtj26BrIF84S8aOwIYelAjuEQ79Cl88ZMHJYVgdvMT59x132D33mqXAE5w7SkzHmSSpdBV7x8Q9uSu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716375072; c=relaxed/simple;
	bh=/wrNOYlvXzRdTeplf6TZbVC8so7rhZlXjnI2QI/al7o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rq/KynuPFx3jxXvQzsTsJhWHoRqds3ynXPmBLZohYKka3zhVTDpziE/WHbb9jfe4hMzXFT2UEAlJlOyysqEiDR/v6WNet/R9YMGD98YFtclqOxOOYnor22/7K3+gh9ypwi0K/JM6C+3B9J/fwXCLeRbHOeiwfIfoEs7QprYRg3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Tm8MlPwx; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51f45104ef0so6200940e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 03:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716375069; x=1716979869; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j/4fTIJgTEUbDdUM7ulateH0ttYK2JMK4XIQQRpRwck=;
        b=Tm8MlPwxK1nypOUAwjlRF+fzLS6TkOxfc0zK4sjJ8zqu0yR35mfz/AdQ/j/DSK6p5k
         XnNTvUzYu5JdBFLWhQSsxZOKzSpSULk/Dpuj60BgTnOXEhnHvv1NUTE63wIxygCVNKac
         qW0cIQw54KLEnQKwTJPBO8f0pmRb5vGdwoxe04uSo/tC6GMZOzZiUeGBD44G+SWAfR0/
         A6pBlhCskhJML7SUB4YrYmaJgI3NNmTvnqWgoSEJBTmwPG12QnVAsRGWzNcrRKfSDffJ
         30jkjgMOayXP03JwUsm5luHPCREXfeASLCkIdEtjGm11G9PQUy7wMNUXhpuJXKkHSatc
         LVsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716375069; x=1716979869;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j/4fTIJgTEUbDdUM7ulateH0ttYK2JMK4XIQQRpRwck=;
        b=akOodTCBNWZOSu87qAdqJaBUrls+sZbbV692J9C33C27RCYFg963R871ipW9FH1M2R
         5Oe6Vkey7d1vrz/SLkSMqVdremJpQQnoJhTESUpiJKQwmi30WX7g4THndAdIvdJqtc/V
         FV+nJkKzZDpsqloeRdhLzxJcT9nEjE4xvKEDzzBQ/mthfHT7pdh5jkv4zeAu3zzEHC0q
         PeQ2eKmxN0ppgdxW/hwh6sNgl0NXLhDhMd0kwuvFzvN7t1sHoIqaMpCMVAl5b12WEypI
         oTRCnJkP4eua2h+IbGsaCq/mfN7uReMvYsbKGCaHII1+PhN9b20fjYM2oJpwXf1hV+gg
         V4Fw==
X-Forwarded-Encrypted: i=1; AJvYcCU3yDR0sI+hLGdGZqdgx5trl84/8bNpIq7PvMocOYZTkQGeysz9Y0zC3u8Ol2zwv8fBeH7McT80VMnBsJpUNABGaIZhXwI5L8Gt60TA
X-Gm-Message-State: AOJu0YyT69kNUeivd3oCNuRlirK8OPmdVcsikq9b5wG60Tg/uVOBkmB8
	BF1brUBd4bS3qQykxeK53fcgEKqqRy/UB74BW9D8hmiFQKrqu5mM1pFPIJjDKcU=
X-Google-Smtp-Source: AGHT+IELruHphQs1lHT+YJc17lZvFaGsZaIttRkKgj/276EsYqWN2Z5w0oVEWecTGdEVYJODT/Hf7Q==
X-Received: by 2002:ac2:4c10:0:b0:518:95b6:176f with SMTP id 2adb3069b0e04-526c068ea7cmr892773e87.50.1716375069078;
        Wed, 22 May 2024 03:51:09 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52431778ec8sm1279126e87.194.2024.05.22.03.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 03:51:08 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 22 May 2024 13:51:06 +0300
Subject: [PATCH v2 14/14] drm/msm/hdmi: wire in hpd_enable/hpd_disable
 bridge ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240522-fd-hdmi-hpd-v2-14-c30bdb7c5c7e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3864;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=/wrNOYlvXzRdTeplf6TZbVC8so7rhZlXjnI2QI/al7o=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmTc4RYwSU6lOZZB3KG7aLp6Cx2FiLEgfA/chDB
 bge3K0A5YmJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZk3OEQAKCRCLPIo+Aiko
 1Rb7CACP2WFe3WKMzifDnF7L4BKpX8QNHIRZOX8BsKiod/n3IIa0usUDK3kAMOi40/U6TyKOcF6
 gqRv0D03gJMhCARcSsXKbPIjk9mKtLJlLumJGkKiVPY0MQm9hcxsx3atkHilZU1+XycaOMjW+dL
 YiHeo+COVv47oNf0ETJY25YIWK6DjkFxuYeG7F2zeK1ahF5QrIl64FxN3M73Coj/yQjKdjJUM4t
 AP4boZhBwBi02kTxoxEr2BrrrJDYNMPuS79LPR07pI5yHvcALXo3VUzqIZLAa75+VXuG8xZ3dsQ
 Z3hQXnUujcst+Q52pd4hGrHQe+Qhhli6fsO0wgDUt4l1owTm
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The HDMI driver already has msm_hdmi_hpd_enable() and
msm_hdmi_hpd_disable() functions. Wire them into the
msm_hdmi_bridge_funcs, so that HPD  can be enabled and disabled
dynamically rather than always having HPD events generation enabled.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/hdmi/hdmi.c        |  9 ---------
 drivers/gpu/drm/msm/hdmi/hdmi.h        |  4 ++--
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c |  3 +++
 drivers/gpu/drm/msm/hdmi/hdmi_hpd.c    | 12 ++++++------
 4 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.c b/drivers/gpu/drm/msm/hdmi/hdmi.c
index 2890196857f8..06adcf4a6544 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi.c
@@ -202,12 +202,6 @@ int msm_hdmi_modeset_init(struct hdmi *hdmi,
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
@@ -377,9 +371,6 @@ static void msm_hdmi_unbind(struct device *dev, struct device *master,
 		if (priv->hdmi->audio_pdev)
 			platform_device_unregister(priv->hdmi->audio_pdev);
 
-		if (priv->hdmi->bridge)
-			msm_hdmi_hpd_disable(priv->hdmi);
-
 		msm_hdmi_destroy(priv->hdmi);
 		priv->hdmi = NULL;
 	}
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.h b/drivers/gpu/drm/msm/hdmi/hdmi.h
index 7f0ca5252018..c6519e6f7f2c 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi.h
+++ b/drivers/gpu/drm/msm/hdmi/hdmi.h
@@ -219,8 +219,8 @@ int msm_hdmi_bridge_init(struct hdmi *hdmi);
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
index 104107ed47d0..41722b2e6b44 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
@@ -300,6 +300,9 @@ static const struct drm_bridge_funcs msm_hdmi_bridge_funcs = {
 	.mode_valid = msm_hdmi_bridge_mode_valid,
 	.edid_read = msm_hdmi_bridge_edid_read,
 	.detect = msm_hdmi_bridge_detect,
+
+	.hpd_enable = msm_hdmi_hpd_enable,
+	.hpd_disable = msm_hdmi_hpd_disable,
 };
 
 static void
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


