Return-Path: <linux-kernel+bounces-426074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEAA9DEE7C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 02:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67F2516232A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 01:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA2A157A59;
	Sat, 30 Nov 2024 01:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oxHGPQ6C"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C00156225
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 01:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732931583; cv=none; b=rv2xVqqp6U8CNjHaCwhVUHyxij8pagm1ZmTN5vMwsAQzOKuujwuJ9aqbqLq7HtA/FY9Ds8ZbTmCK3El9ubgoU66cLrgP/eqnWAvV1kF57dTtOV5bI9ueRPm22WR49S46rInBjsIcmfjW1ApcGcE777g34NM1GWFyPloHmS4SZxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732931583; c=relaxed/simple;
	bh=tt33sNy4EHSANTDHQAExXai1314OqzFqkWnpPj2YPOw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QsVo8++E38NYNJAyjKkJ5ZoLMBCslyPrA+GFy8wCmv8lXXVvLxvAF6wJQBHz1/xAM3thypGVwZK7yXBbv3ItQA4x9FCJwBqAhcxJPZXRjS1pX+WwhmawlzGTSt4Ut9hB19u0j/jUxC5W7cNtqsSULm2XHuYfUrM7v5KAmQYasFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oxHGPQ6C; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53dd59a2bc1so2808234e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 17:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732931580; x=1733536380; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z1lXYCxrn128DpMjUx/X3ynnQZTeAwK/ttm0jSS1k6c=;
        b=oxHGPQ6Cf3ZCTo+HbkcK9xnlIT4gbtPLYJmtftZLCPrOUvULGA7E3cwqi1jZMmXo9T
         Mi8vrftHnB+CkuU6TuEhigQhQ6Nhop3oIhdnOMGLBqW4VE3vq7DdQ/dJnvROkIAByhZk
         hTDMAEujJvz7gpv5RGOLoZCdrRSKcT2yjmy8ZQzEhu8En4xEI5B1F1D0W/QANvuAom34
         LyIeXDMvcXuFwjfpnMQn57NcgFNzrmg7jfP268zYVZdZhNKfMpxS2AWYhunBMbGTEWaf
         PJYVde9qvobrY5y5yr5VzE+/o8jUpthzOEZWoXAwRiKHomIfpyWanX7ih/gQa3S3h9ac
         Oztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732931580; x=1733536380;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z1lXYCxrn128DpMjUx/X3ynnQZTeAwK/ttm0jSS1k6c=;
        b=CoA9OiSSZoR1lmtEgMM5DvAIoZ26LFghLYocuKK08ChVaIwdu4aJ45KvhMby0ImiUX
         ou3DlA+Lb4/LgAvZC7q9q7Sf+T9/ceGzed0+MJdhVvhSffv4LMPUWoA0FzPox0URre5c
         inboYe1p+Zb6mqc9IbMKY9l1KlpQCYzsUmKtkagF86HApsJHSeXCvXTSu8b7BJljmaWF
         PVaTgzRLU7HLalSf19HrjNCMI8jQn27lHzko3WkZS3vtSEglQFnuP2/GhDHn7l9n9tWs
         FXTrBJTVVO8R4LyTN+jGO88vK0DF7nN1iJJKy+LlDhP1awJBdtePboBaxF3wMaob2cqL
         TwqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdyRhuGPQO3d0RynuHbj55jxNgKqB12NmzlujdG/vFcbQXO7vvzlgXh8MjgV50wGBfbkubL3mkYH+0SEI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbzYRwQ4JRdan+w6Ore0UAkVirECFDiueZYuHrx2tjJ1+jkiWF
	qncf12/Oi3S4tl7cNc2cwrXVMlJ34+tyuIbBUu7xfniZiw9C+wp2oVaGQqfgrSc=
X-Gm-Gg: ASbGncsgDrQc/f+JXQyML5fLHSJoAh5C6qoNs35qU5PLAXmZJLEJU11od27G0byNKiC
	2RUxhzI/rAaQpjVsxlXQE9kT0ZrAy4w51MiYfd6R3pJKG8u/L2xr7YHJRSWkbJKhlkOyhZ1+6R+
	6HYd39f9F15gBsbqkECkUjj2rPlu/86Roju9n6qjYCbgpzMtvH2wJay/UP3f6BxnFvH2EywZGMf
	tS2CyZWldRgFjLjEr1NhFPuWunZCo11kjTHm2svXiWUaA0LyTJRvyaJZQ==
X-Google-Smtp-Source: AGHT+IF1zZCeJZP0c56HDhB3dZvzfBBbMK+T1fbyelhZdZGvyXwekGQxsUf0KFWRtcl6qeCukozDbg==
X-Received: by 2002:a05:6512:3ba2:b0:53d:ab21:4e17 with SMTP id 2adb3069b0e04-53df010e3dcmr8347283e87.55.1732931580177;
        Fri, 29 Nov 2024 17:53:00 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df6443172sm636408e87.84.2024.11.29.17.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 17:52:58 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 30 Nov 2024 03:52:35 +0200
Subject: [PATCH v5 10/10] drm/sun4i: use
 drm_atomic_helper_connector_hdmi_check()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241130-hdmi-mode-valid-v5-10-742644ec3b1f@linaro.org>
References: <20241130-hdmi-mode-valid-v5-0-742644ec3b1f@linaro.org>
In-Reply-To: <20241130-hdmi-mode-valid-v5-0-742644ec3b1f@linaro.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2060;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=tt33sNy4EHSANTDHQAExXai1314OqzFqkWnpPj2YPOw=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnSm/hEd3SJUPYNRrY3fgh17VdYvds7f7Q168Zy
 EaL3JawgciJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ0pv4QAKCRCLPIo+Aiko
 1X26CACq+Vplt9h/bOf8vjWm6vdUiW7JOHiBTGnHe70WgxSHu/ZuvlCePWg1uh99nqgs2ima6WF
 a9lLDOxqI+EJiL4HXVW/9rMgRI9+kPpvRo4ZpFhSzWDzSDLhXw69MnpuoryWhAMHZUyDDqAaP6O
 eiqfS2m9WWGLc9eup/Hiiuc2DkZeZRIUpCxUytQsfiM08yjPmolqxG1B6UJFaoNBNQnoAiB6NKV
 6yENKHrcdPICm1HbAhl90zh1cQYxOeCxuPr/++Vj6Lb/96pS3lioxQ+HZxLy35xyxCP5nSvsOIB
 IF09MJu53IVZkYd6054wQHgHWjrTHeEygEM+tXSOP4m5zQ6Z
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Replace sun4i_hdmi_connector_atomic_check(), which performs just TMDS
char rate check, with drm_atomic_helper_connector_hdmi_check(), which
performs additional checks basing on the HDMI Connector's state.

Suggested-by: Maxime Ripard <mripard@kernel.org>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
index 54b72fe220afacc208b3fd48d5160031127ea14a..b05fd77870b00aac97d003f3fb9c2b98cb73abc0 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
@@ -187,24 +187,6 @@ sun4i_hdmi_connector_clock_valid(const struct drm_connector *connector,
 	return MODE_NOCLOCK;
 }
 
-static int sun4i_hdmi_connector_atomic_check(struct drm_connector *connector,
-					     struct drm_atomic_state *state)
-{
-	struct drm_connector_state *conn_state =
-		drm_atomic_get_new_connector_state(state, connector);
-	struct drm_crtc *crtc = conn_state->crtc;
-	struct drm_crtc_state *crtc_state = crtc->state;
-	struct drm_display_mode *mode = &crtc_state->adjusted_mode;
-	enum drm_mode_status status;
-
-	status = sun4i_hdmi_connector_clock_valid(connector, mode,
-						  conn_state->hdmi.tmds_char_rate);
-	if (status != MODE_OK)
-		return -EINVAL;
-
-	return 0;
-}
-
 static int sun4i_hdmi_get_modes(struct drm_connector *connector)
 {
 	struct sun4i_hdmi *hdmi = drm_connector_to_sun4i_hdmi(connector);
@@ -258,7 +240,7 @@ static const struct drm_connector_hdmi_funcs sun4i_hdmi_hdmi_connector_funcs = {
 };
 
 static const struct drm_connector_helper_funcs sun4i_hdmi_connector_helper_funcs = {
-	.atomic_check	= sun4i_hdmi_connector_atomic_check,
+	.atomic_check	= drm_atomic_helper_connector_hdmi_check,
 	.mode_valid	= drm_hdmi_connector_mode_valid,
 	.get_modes	= sun4i_hdmi_get_modes,
 };

-- 
2.39.5


