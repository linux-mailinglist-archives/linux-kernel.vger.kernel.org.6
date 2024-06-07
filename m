Return-Path: <linux-kernel+bounces-206127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 756D09004A0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 15:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC77D1F220D0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4C5193099;
	Fri,  7 Jun 2024 13:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hHATsWRF"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC60919415E
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 13:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717766591; cv=none; b=D6qXEhY1cJ+RObRMroSpuxtyKJa+sOcK/yISg6QT8lCtizwvJ8e/RHpWyeYH+UgJ86nDkQ+kjzzQZi/P+Z+qhPWtM9p+l/g1v9uSDXimd6j48F41TFmBH3nlmt+OCR1A6tWV+AtVRzDPJAeXbjWxjiPMdakfMV2g2bGhYOFKvh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717766591; c=relaxed/simple;
	bh=ATNJtCzOXDVp1OKwxiEV9jk7WYH4jasM/bHZPYZfo4g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZMCor1ipgYZaimk+LOwUTA3a3hhuy2uymjk5fvRd7+mjOsCex/f1vL4hn9zYjkF9EtHevvbrL5UFwTGh74yc0x0BvY/DxNi0Gy6kPFwaGXCIRgjtfMH0YUs0SXiBdial53QFCQwnPWS3MozpOR/YOdswYAMYdLT+bfX0Rn3vF6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hHATsWRF; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52bc27cfb14so422993e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 06:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717766588; x=1718371388; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d6C2WBjw85TMMZ9GIIugc3NhLWza5ZaClpp5YdwIj3Y=;
        b=hHATsWRFSRG1upYvCZCLPrw1eVr2DYqrdUD7NKg9l6alDT0tf78GSgj/UjqjYvXwG6
         BJPpV4xTTOnAvc0HA6KOEqoq+ymN1fIh2lKEagRcYEo14URkgxig2yGMKb5AhWmiaEAD
         ixnsPkYHma4uakQw+RyU3eJ3qd/azSbb4a9sGwfkQyqIV7E/S/PSBeV8FKxL6Ucni+s+
         jIORkDdyqmH8V1oqjA9hA6lkOeBIIcpUA7fDBQPvWi74JRMdYyO4VrqJENRcGKweLdwc
         y6rSMyhvfyS8CetBg6+GYnsBzvyfvn65yvssl146JEsiRN8+cMIzbEThn//HXX+rvlpv
         icqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717766588; x=1718371388;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d6C2WBjw85TMMZ9GIIugc3NhLWza5ZaClpp5YdwIj3Y=;
        b=hOQUOQkeblkMfqju/+2Wvn3UYwqrUKlCJj6MkbY3Q3ZAeUCWTB5+gUUd/v/pfnnimA
         djeASsCvvEf9YAqTZq+UTkdx0KhE3xDBrUUagCakN0lDIRr0gaC/stKMVgEPYZoKgrba
         tTwbmcmD/c0Gvt1NS5pvG2FDvKPcOQJu8sHECR4c/4tgyJgygxtcHLv6ysQJUxy2NF/k
         yTtd5r7wfIt0KN0pGLIeOS7tiEMCS3jj1UJUHTnQzN4vtc2RD+4xInkApakBNYBhyblA
         fyqJQp3CAJJCjdwOb2X0NohFqPswxII1h43PNIH+Ed5g+NdAzNiOtwPa1oVGCqTNCquL
         Vlqw==
X-Forwarded-Encrypted: i=1; AJvYcCVEUtf/XEZZfNCvGmksh8QLcBJINFsyJlFXwVpMFPcp8tEGI4jzAuvxwsdZNsY2geSKdahFx36tnvAgcqXLa86SzIvc48crC/Gen/i5
X-Gm-Message-State: AOJu0YzU+PKdUieeMdi0IXKA784lvBrbsoYkxR/FyB8D3yuCmz8FrTyD
	XgJsEUu+18GyVHpWl8OSPb0WK0XYrONozfIngO//5sp2mIopc8eTIyPqqM6Lnow=
X-Google-Smtp-Source: AGHT+IHUCKO97Y5eJOp7MZjYCpuQE1noO8w19BMp7fZbGoZnZna/4yKtjoyrieL3UxUSco//uNuYhg==
X-Received: by 2002:a05:6512:5c6:b0:52b:9530:f0b9 with SMTP id 2adb3069b0e04-52bb9fd8c7fmr1765707e87.67.1717766588037;
        Fri, 07 Jun 2024 06:23:08 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52bc27640easm80944e87.104.2024.06.07.06.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 06:23:07 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 07 Jun 2024 16:23:01 +0300
Subject: [PATCH v5 4/9] drm/msm/hdmi: switch to atomic bridge callbacks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-bridge-hdmi-connector-v5-4-ab384e6021af@linaro.org>
References: <20240607-bridge-hdmi-connector-v5-0-ab384e6021af@linaro.org>
In-Reply-To: <20240607-bridge-hdmi-connector-v5-0-ab384e6021af@linaro.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2170;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=ATNJtCzOXDVp1OKwxiEV9jk7WYH4jasM/bHZPYZfo4g=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmYwm2pVFRim5aY30nLbQ1ioxf5cLI53C8wh4y+
 oW0k/2ldPeJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZmMJtgAKCRCLPIo+Aiko
 1dWPB/9U75hLW4yxzPnUtMrXjokMKyYjy5944uLa49im7YSrXOjsCQQzVETe9Qy1CjP6GnpqfSQ
 7d+++cJ+KeMq/6OUvhVf5RpyRdmKYXupEr4ZxhV5C78apq9Q7VsE6ZP2KRGbfgH0FWNvh/Vue+C
 1R8NKGXYgzHf3nJOtcQE4hvPUVt3s442NTxITBVQZoFUTGFLb6jTmc26Wi1iSdiDdUJbm5ClINP
 +Sp9/hRNbujhAZC+pfdh964CWKBGq07T8y8eCYrYsLmUrGD2GwPKjdwjNNM0xZmi1vj9DJTK+Qe
 lhEpo904/WdltMnPfxeiZwxzu/rMwO/8IxfX3ywVrS+vjzgZ
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Change MSM HDMI bridge to use atomic_* callbacks in preparation to
enablign the HDMI connector support.

Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
index 4a5b5112227f..d839c71091dc 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
@@ -126,7 +126,8 @@ static void msm_hdmi_config_avi_infoframe(struct hdmi *hdmi)
 	hdmi_write(hdmi, REG_HDMI_INFOFRAME_CTRL1, val);
 }
 
-static void msm_hdmi_bridge_pre_enable(struct drm_bridge *bridge)
+static void msm_hdmi_bridge_atomic_pre_enable(struct drm_bridge *bridge,
+					      struct drm_bridge_state *old_bridge_state)
 {
 	struct hdmi_bridge *hdmi_bridge = to_hdmi_bridge(bridge);
 	struct hdmi *hdmi = hdmi_bridge->hdmi;
@@ -152,7 +153,8 @@ static void msm_hdmi_bridge_pre_enable(struct drm_bridge *bridge)
 		msm_hdmi_hdcp_on(hdmi->hdcp_ctrl);
 }
 
-static void msm_hdmi_bridge_post_disable(struct drm_bridge *bridge)
+static void msm_hdmi_bridge_atomic_post_disable(struct drm_bridge *bridge,
+						struct drm_bridge_state *old_bridge_state)
 {
 	struct hdmi_bridge *hdmi_bridge = to_hdmi_bridge(bridge);
 	struct hdmi *hdmi = hdmi_bridge->hdmi;
@@ -299,8 +301,11 @@ static enum drm_mode_status msm_hdmi_bridge_mode_valid(struct drm_bridge *bridge
 }
 
 static const struct drm_bridge_funcs msm_hdmi_bridge_funcs = {
-	.pre_enable = msm_hdmi_bridge_pre_enable,
-	.post_disable = msm_hdmi_bridge_post_disable,
+	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
+	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_pre_enable = msm_hdmi_bridge_atomic_pre_enable,
+	.atomic_post_disable = msm_hdmi_bridge_atomic_post_disable,
 	.mode_set = msm_hdmi_bridge_mode_set,
 	.mode_valid = msm_hdmi_bridge_mode_valid,
 	.edid_read = msm_hdmi_bridge_edid_read,

-- 
2.39.2


