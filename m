Return-Path: <linux-kernel+bounces-533372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B99AA4593D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 10:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B33116AA19
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 09:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA77226D06;
	Wed, 26 Feb 2025 08:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zO3hiiWq"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD40226CEE
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 08:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740560377; cv=none; b=EvGCHj3Crtlw68zCdiGP5tjGYCs/jmWeweNGIR4PxzDFt0SDxxd+121rxJ9gHJnjXuKbBKfRIAdtBW/ghfPcbshX3KhfltyrZXKLUCp32B7SddMvdM31L2JWk94X5G073Wi3tWbbLC1GWFBHVRLzNF3s+AuI1sWz1cX1dTctxlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740560377; c=relaxed/simple;
	bh=m2TAoFMN3euF4DkEUBd426Xr5dS2tnI3Q7ZEQxtygnM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PvG0KX2vDOtQ3ATBxcv5Xw5j1l6/1IhKocwKM51QztD+47YHrhHafKPbr3czwH89Gsww3QdmdLtt2AHI9FvWgveXb/aA5GGEp1xKkOFjBKEE61c3XUW9HO1oUqd4kOj53nm8/85pe+x03LGTr2WHrAd8pbTkSoDg0dlPqHvVnss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zO3hiiWq; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30613802a04so69699591fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 00:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740560373; x=1741165173; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a0zF5icXRhGBS22oaTFCfeFkUWLVA/EPLQBHYWMqBLg=;
        b=zO3hiiWqUTD7uD0jiBOzzzS/J1dq1ujkwuylbWtmRa6CRFORDO36W2Q28p3ll17VnU
         gIwePAGgnA+EiA4UxQdv9MaDHWAmwC0BRKrNW423R8CBdlqPCDShZiTxTILzmwae2eVV
         KVsUexzCZv7RpVAZX2RtQKb5yh3bKpQA5SDC6lCdKMsTNJ9z9ZMkwzKbcBgzMZjwmwu1
         LCgtuskGMZmfziiBVUO+Vx0o7i6Azh48jPfUiiiKbhilDtOjP51ZwjyntKfwdnfcEwWG
         ENVEHU1JwtIbNMYpQxfXpLCum5VscrPL9TPHt8sQYCWdM6YcARWH5HYrJufYdah14u7+
         oDgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740560373; x=1741165173;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a0zF5icXRhGBS22oaTFCfeFkUWLVA/EPLQBHYWMqBLg=;
        b=sMLipDk3ZfjnGrDrP8d6rIuTg0uAh3ri1VyMBnkSrJwKeXorXrRkZ9r0AG11VFK7/i
         bIczvKHVf0yXN3qVwri7LW0HX4WWIK9MwDL0FzMBCH4bq629fZvTeT5D2Kdj3zhPbsAx
         wIyCyCJGvxwBRnKFFaKtslZuL2L+V1mY+QI2P0Mhc5D9CukQp5ldIlNUp4qUj2MwY/OS
         BliFAzJbF66ef+RTn2nx9I+xn31SbugPmDbRBffDLgvZ/Dt31Xo1Orl73khIsA6/mfee
         njQx5iSZIJIS+lvYzetnZ3Sqht+FxNe4ddMiyOS2P8SJmCxQeIo30fEdHepv067y/1m/
         32Dg==
X-Forwarded-Encrypted: i=1; AJvYcCU7O47tZr7WOUXP7uUTWP1Ol9MJBfRh2loM6DI+d2jQVSCy3vBROqfUQo9yqkW+J8Ixwrtkbx/+wIbnO1c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3BK27s3MufH2XkeTE1HwGSfEf+WGmuU+kV7yNpOjJ3wFpHeeB
	rpzjn2PiWlH1Amvk9vQkU9m4Pvg39cCU/E4PCXdgyuOmv3s1ZfMZfkKf65sxLEuJe2wTu690Q/2
	WOSc=
X-Gm-Gg: ASbGncsXwoLbwsq+3GdVybZVlAp4hutXPdgU22IYdzZPSkHcvbFioTgkiiLYlgvkviv
	PWfwfCaZ4z5P9hFEkTMravEERCGPOyvUsHdZAQpPzWIsqK8l3yMaM1ECUyFVTONsKKNR2B5mMyq
	zuMhLoagh4JCduSob2RAYxDfODGJQU3emE2FFgoINayLIC9zO8Fqc8muCdypi54GJIZfvpopbmz
	66/4PW3F1jJxo2bR2nw5FFVk2xLV5Y+7bgvPUyIdzuTzS+WSxMNobAm6k//Qk+vzhAp6hHY53at
	ilylENrBZf5RGF0kcynOLbxV+rMd4l5sRw==
X-Google-Smtp-Source: AGHT+IHD8l95g4vI1vyQEz00LSL+SoA+aEIpEPr9+UtIPsacpfC1JVUKJm5+nMQSBt4UshFzPla3jA==
X-Received: by 2002:a2e:96d0:0:b0:309:22ae:a6b3 with SMTP id 38308e7fff4ca-30a5b1a091amr89275911fa.18.1740560373370;
        Wed, 26 Feb 2025 00:59:33 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a819e0c49sm4556641fa.10.2025.02.26.00.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 00:59:32 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 26 Feb 2025 10:59:25 +0200
Subject: [PATCH v8 2/7] drm/msm/hdmi: program HDMI timings during
 atomic_pre_enable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-bridge-hdmi-connector-v8-2-340af24b35cc@linaro.org>
References: <20250226-bridge-hdmi-connector-v8-0-340af24b35cc@linaro.org>
In-Reply-To: <20250226-bridge-hdmi-connector-v8-0-340af24b35cc@linaro.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Simona Vetter <simona@ffwll.ch>, Simona Vetter <simona.vetter@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3113;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=m2TAoFMN3euF4DkEUBd426Xr5dS2tnI3Q7ZEQxtygnM=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnvtfsOMZUZw+aUfLC3KFwKH0V9adcdPsnFq/AF
 fHNBmGlMgKJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ77X7AAKCRCLPIo+Aiko
 1QaeCACEYYfh387FH+3M3cQHalQXk1AtFjbNI6xiNZkRNKKopeEywYblNV5zpUeCbgo0mARh2Mf
 hI68MqC8xQYbyIbvHvDpdUG3IQUxTgsdFOsUuYTxyw//MR3HqEvHlAe3RrOaIWboglM1kI2xemN
 akRMDiF+u4GzVp8FuwJcrZxPREePgMkEBOUCF9vjzqlqoi1svME1LLCUOQkq2XSnYXskH/eAzSD
 K+1MBc65J+fYPhW8cRWvNOhsty9KRBCngYpXpaHwggnC0XRbtUV2Nlix/IKOrnp/m7ywA3gf4Rm
 Kg58VWf8Vl0rggm5UUNuQ2kAGLUWXUT5OAKtZ3NYlMO5pfsA
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The mode_set callback is deprecated, it doesn't get the
drm_bridge_state, just mode-related argumetns. Also Abhinav pointed out
that HDMI timings should be programmed before setting up HDMI PHY and
PLL. Rework the code to program HDMI timings at the start of
atomic_pre_enable().

Reviewed-by: Maxime Ripard <mripard@kernel.org>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
index d839c71091dcdc3b020fcbba8d698d58ee7fc749..bd94b3a70f0e5e457a88f089b491103a8c09567b 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
@@ -126,15 +126,29 @@ static void msm_hdmi_config_avi_infoframe(struct hdmi *hdmi)
 	hdmi_write(hdmi, REG_HDMI_INFOFRAME_CTRL1, val);
 }
 
+static void msm_hdmi_set_timings(struct hdmi *hdmi,
+				 const struct drm_display_mode *mode);
+
 static void msm_hdmi_bridge_atomic_pre_enable(struct drm_bridge *bridge,
 					      struct drm_bridge_state *old_bridge_state)
 {
+	struct drm_atomic_state *state = old_bridge_state->base.state;
 	struct hdmi_bridge *hdmi_bridge = to_hdmi_bridge(bridge);
 	struct hdmi *hdmi = hdmi_bridge->hdmi;
 	struct hdmi_phy *phy = hdmi->phy;
+	struct drm_encoder *encoder = bridge->encoder;
+	struct drm_connector *connector;
+	struct drm_connector_state *conn_state;
+	struct drm_crtc_state *crtc_state;
 
 	DBG("power up");
 
+	connector = drm_atomic_get_new_connector_for_encoder(state, encoder);
+	conn_state = drm_atomic_get_new_connector_state(state, connector);
+	crtc_state = drm_atomic_get_new_crtc_state(state, conn_state->crtc);
+
+	msm_hdmi_set_timings(hdmi, &crtc_state->adjusted_mode);
+
 	if (!hdmi->power_on) {
 		msm_hdmi_phy_resource_enable(phy);
 		msm_hdmi_power_on(bridge);
@@ -177,17 +191,12 @@ static void msm_hdmi_bridge_atomic_post_disable(struct drm_bridge *bridge,
 	}
 }
 
-static void msm_hdmi_bridge_mode_set(struct drm_bridge *bridge,
-		 const struct drm_display_mode *mode,
-		 const struct drm_display_mode *adjusted_mode)
+static void msm_hdmi_set_timings(struct hdmi *hdmi,
+				 const struct drm_display_mode *mode)
 {
-	struct hdmi_bridge *hdmi_bridge = to_hdmi_bridge(bridge);
-	struct hdmi *hdmi = hdmi_bridge->hdmi;
 	int hstart, hend, vstart, vend;
 	uint32_t frame_ctrl;
 
-	mode = adjusted_mode;
-
 	hdmi->pixclock = mode->clock * 1000;
 
 	hstart = mode->htotal - mode->hsync_start;
@@ -306,7 +315,6 @@ static const struct drm_bridge_funcs msm_hdmi_bridge_funcs = {
 	.atomic_reset = drm_atomic_helper_bridge_reset,
 	.atomic_pre_enable = msm_hdmi_bridge_atomic_pre_enable,
 	.atomic_post_disable = msm_hdmi_bridge_atomic_post_disable,
-	.mode_set = msm_hdmi_bridge_mode_set,
 	.mode_valid = msm_hdmi_bridge_mode_valid,
 	.edid_read = msm_hdmi_bridge_edid_read,
 	.detect = msm_hdmi_bridge_detect,

-- 
2.39.5


