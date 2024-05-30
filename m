Return-Path: <linux-kernel+bounces-194774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD2B8D41D3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 01:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4286D1C21711
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 23:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA503201253;
	Wed, 29 May 2024 23:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pnJSBKhY"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163FE200103
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 23:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717024354; cv=none; b=d1LMwo9wI5nQXQKSPHizWSyCoRBKvifcou9eIh2js3Whito7RJYvFlZNijcvWXe2lOI0XjyE7XItCbtIFLy4aGLb2yUTqZbnIf5/HRCrdONX3c2I3OpV/H5fyb5RF8Kbep5ECnB4RRYkTv+Kp/BqHf+KQIG/aUtBOAtt3j5g6GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717024354; c=relaxed/simple;
	bh=BLTMrmfRiYz+a4tS74ezbT2hZO40I+AiAHfNW/m4HPQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oSBxI2zsl+risxS3v300BBpNhnGy/Awh7W7F90/82s68EqDwcuxCQXuOc+Ayyl3ZSyjJwoQMmVvl9NQHTV4UmaiyybpiktVqdSpBKSwNrl63uXzHxJVAvY6Rqw7ZXm/IGj25bodufNaSskUPHeRnvoqO2t0gMG3CD+J2bDUECAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pnJSBKhY; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52ae38957e8so329020e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 16:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717024351; x=1717629151; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oSCLgDYohNznRCwnS8tfo5EB4gMkp+kuVZWS1xIx1Q0=;
        b=pnJSBKhYwhFbKyOVnBrXQqdZMUQYmIed5XFAo21xMH5EduBR+xaB5R4pBqOuQf65mK
         7RlxEn1Tb/RMDKVkHfPqnROL7IDxya7sIZubsp0A8REFmMt8Fhk70znaKdMuLUep+6HI
         JVS1/h40Tf5P8sp/6GF+L2YO280nKWYDkrDKJHA2EMsWNlMQjgEl/4WPoesppaTs/Mcp
         ZIGMQKN7lC426ZanOkKPGkuTCa+hGd83Egty8X7weUTBYbEkOdHcJMEEVXMFaOdlWcxl
         cstKtPTzVwec9j+GCCbk5CiuWdpJccJGYUh7HdYLWS4Q3rYs1qa1Q+pbz3KYjjlHHu5C
         LPBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717024351; x=1717629151;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oSCLgDYohNznRCwnS8tfo5EB4gMkp+kuVZWS1xIx1Q0=;
        b=YLJbTNvbiGv8OYkVB1ATFncpC6kbPcLgNLPKgdODyjdE8uPcOyjKfc1uVhlGI7sLhv
         peDg113Z885FhDfopERt2zvGXyj4L74eG5ziK+o2GtOlVbg74SZK28GunHVFyEC+OoAl
         tB2QWzyFUWPEXGnRt88ov07Ia8de7eybxzg3f9p3v2CHePR8yGmVRpYcFBGofmhkmV4U
         L/lar6J6+CSW+IydxTWUmBwCTLnWrsq4N4SL/ai3+cXv2Web1WAz/1jWLSFdQ/SRBTht
         wp5rjVPKvre4fXR4MHl/5VcrhG6aGVjjMoOt4uU+XPReBjjBpzDZbxRcq2BOmcJd1W7v
         Kt3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVMI2P66wSUsQjsiwN945d4QXR78XHQCA118Djl1JjfdIcVQAM87SB0O+4d9zNfBTzMdh5MgaBLVX2/unI14SiQWtQc9lTAIHdGUMqA
X-Gm-Message-State: AOJu0Yw4dDZ7INw11LeaXYrV20NB/H4Vdbk1lpx3ILOsS02p2qysWSOE
	+GDpRMl18lKiVT73wYjmnsjtUFH5UZtt8G+knOTXxkRFQ7a0Df5lznU+kDjxnqw=
X-Google-Smtp-Source: AGHT+IED00Nm5mAxm/FX23Rm3CEi3WI/fVSCS88PVojYjAKG46K22pFDih1lMhk2JtVr9IDeDcpXHA==
X-Received: by 2002:ac2:5e8b:0:b0:52b:401e:1b5e with SMTP id 2adb3069b0e04-52b7d4225c8mr266833e87.17.1717024351237;
        Wed, 29 May 2024 16:12:31 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-529acea1ea8sm1015998e87.276.2024.05.29.16.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 16:12:30 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 30 May 2024 02:12:27 +0300
Subject: [PATCH v3 4/7] drm/msm/hdmi: switch to atomic bridge callbacks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240530-bridge-hdmi-connector-v3-4-a1d184d68fe3@linaro.org>
References: <20240530-bridge-hdmi-connector-v3-0-a1d184d68fe3@linaro.org>
In-Reply-To: <20240530-bridge-hdmi-connector-v3-0-a1d184d68fe3@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2124;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=BLTMrmfRiYz+a4tS74ezbT2hZO40I+AiAHfNW/m4HPQ=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmV7Zb04aIt+1q301e04xSTt7Fn8NIuv7kWJOC2
 sA8qKwVOM6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZle2WwAKCRCLPIo+Aiko
 1cvQB/40zDY86KHpQQKKgrgHeU5s5ns13/oPw5qGupVySmwib3re/YXYqywaLQxoUxnWd/WUAiO
 5GAdLHL3m5ZynKBrIA+uYZDbeeTniF25BwWkOhkPV6Wcd/BdqBPKrP9dSclXgKs5Ea6uhzmiYL1
 sAY9pc65Ujne7ZlQ7fIkPeDLBDIf4CYxA6SFrQoPsrCyGrcX7sm/VTqChTU7mkO4qWIyfXfa/81
 4NyHjYl45+QPKaHssFr4t/3/WSsBj2g0ywnhSjR1WpKhETArPiX5VKI24ZEn8/7HcAdSMIgDafI
 38bQLf4xRGrpn3X73H6nsi9qtgm42DKC9vORHts4TvGS6F5q
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Change MSM HDMI bridge to use atomic_* callbacks in preparation to
enablign the HDMI connector support.

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


