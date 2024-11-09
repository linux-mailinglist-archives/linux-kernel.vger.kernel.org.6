Return-Path: <linux-kernel+bounces-402821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 814F59C2D21
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 13:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A05011C20D88
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 12:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1731940B9;
	Sat,  9 Nov 2024 12:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U9optEex"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAD61991AD
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 12:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731155733; cv=none; b=oTwrXlxuGai4gFD4NE1Z9XEsFU90fWCsOyOCX9ZbWdh/mec9Mtw0LLu1a+qkXqDceZUqiekeqSYDvvWRD2iyncO0Icc64HgzhhGVn+pfxE8/g51pBR7DufuP+spEd3xu8N006+fPCQV5E/KuNSYqG5DMn2lLI8u2YZNyjSuiee8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731155733; c=relaxed/simple;
	bh=UjNMLqX51SwfyB+kbUbjnJt95fAbmRoKvLYOPQ8ek9c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KesbrLRh7mbpP6nrYpqIwdMP8s0ZpFsyxldQ4ZRzIex4/+uITntKZ3YWkmlc+jloWNG6z/VC4U9K5Hfu2oy1mV80dNzUuucDlXq6LV7yE/zx3bGXF2CTUV+AJ2ucTZF5esbkd8VsbOfUOhH5SjQFKyQfxQnSGkGzbqPJ/IwcHv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U9optEex; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539fe76e802so3518196e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Nov 2024 04:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731155730; x=1731760530; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n9wxCYXwjuFpbEm8J6hnlc7LqgHEUz/bPD6SI90IVR0=;
        b=U9optEex069dww5YwPiTMdM5MbM/X6ZGhlmOC5xheJbVVxnHAWo/08M71oxxwQ+kiJ
         p9+jbrNb8Onv9fyga5MNL8zobupPudUdjfGmgEP3BK/CfURvtNGYQ12EoRsfFMFv0yHb
         9mGGWzlz6RPH5nnjtr4ePiQaqrO1MWDDTcJ9FJTRxfwasKXLpPDXC/CtQ26H/kwUSlUZ
         lD0pKSKlVr4qsM5VE6hEUO9FJ2hrE1GQPPx2FgaWq9NQjSwIiK4HD5pT3fWOoVqY//ba
         tfEhAEmbaCGrY41QgRyn5lkNOJHDKAZCKMPGNnot3KtIT+wKxrKXQSmkJd4TydQ7OzOg
         b4dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731155730; x=1731760530;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n9wxCYXwjuFpbEm8J6hnlc7LqgHEUz/bPD6SI90IVR0=;
        b=DZSjfwfjZjhz85UBQB5b64fMs5HMwpojjfbAH6A0FQdbgoWlha9ihfMPt/9zQG7Do9
         0A2fgUc38ufogP2i+03eIs30WL9bpSUm4eXVcqbG9gIfGpnqVN0Qqn17PuuAAUXgO4Yj
         HAAwABIncNXp3ZN+9Z5LaKzyRvXGuZ17bunT6Hj41Wa9TJPaQ1WQigKPRUMGzb7jOf92
         /lSmJWYSSE2rqylkzPyQf4cNli7Zx7D41YOLUSKSuCKiaeTt0wiyNWqBbihTOkdb14XR
         zEYEHfKM6K5Y9kfTvtlUFTRzi8XGY1UiBY5WQAhdJhRcQ2VUXdWmiBic1Paw8xV49zlo
         BQoA==
X-Forwarded-Encrypted: i=1; AJvYcCWhlYJPbmBpEnUXKnniFV7yOLSyRHUyGeEVOQ2R0tSS2WMPnFmi4A4hkotu4hp5EYBCjcfyUMi/Iq4xowg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/9Lj6eVeMYQA+zAyP6qq5bTc4MJdKO5Yf+baTi3bFKD/97B9n
	eXZDWoePweaNOLwwonDDyCAZ+/xBjcCUHBZsGBcJ9J1qFzxX99xIUMeN8szs8pk=
X-Google-Smtp-Source: AGHT+IExWCGWwweJ3/2iRfeNRk4AonxFSRBohmS9iN1pZjqL1Hm83HHjYVjbPTXo/ZRFzwelKC8tdQ==
X-Received: by 2002:ac2:4c4f:0:b0:539:8a9a:4e63 with SMTP id 2adb3069b0e04-53d862fded1mr3117421e87.42.1731155729899;
        Sat, 09 Nov 2024 04:35:29 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53d826784dbsm922899e87.15.2024.11.09.04.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2024 04:35:28 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 09 Nov 2024 14:35:10 +0200
Subject: [PATCH v3 6/7] drm/bridge: dw-hdmi-qp: replace mode_valid with
 tmds_char_rate
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241109-hdmi-mode-valid-v3-6-5348c2368076@linaro.org>
References: <20241109-hdmi-mode-valid-v3-0-5348c2368076@linaro.org>
In-Reply-To: <20241109-hdmi-mode-valid-v3-0-5348c2368076@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2092;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=UjNMLqX51SwfyB+kbUbjnJt95fAbmRoKvLYOPQ8ek9c=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnL1b/mNQQcFqCkzuMTFi21MgL+ClfX6zdxYmOE
 WDmYH96sASJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZy9W/wAKCRCLPIo+Aiko
 1b1cB/4saVmbA16c6Z2bnXMNH/2b3oJllF/7OUdQvKCnntWfx23Ah8wjwzFSaoqoFc+jrad4IuM
 GUO4DHOvHv2lRiN/dW3NjaYzf/4Fs6FTemzc2Tetv9JJ6dc6DKLv0dHR+kawu93qS4TSwCbpduz
 bQJDOP0pZK/UbBjbJl2jUUGcMHS8CWn2EgZc0Y+aej2d1R87ogJebwR3Yik2NciCNDbX4INzayI
 AjmNHAq/LOOrLHcgLBbd15aEsGcw8q47AiX1jSh39Q7NHyX78ZfMpSIOQ68OnoI84bRbaz8Mx2S
 zjDUhci0ay3ohdizDU96iTYRPo+tGSq9Sxzlpty6qOenFpKs
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Replace .mode_valid() callback with .hdmi_tmds_char_rate_valid(). It is
more generic and is used in other mode validation paths. The rate
validation for .mode_valid() will be performed by the
drm_bridge_connector code.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
index 181c5164b23192f0b557624d73c6223032b90ec6..c686671e4850a1af75b82995185ffc3cbb22a447 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
@@ -442,16 +442,14 @@ dw_hdmi_qp_bridge_edid_read(struct drm_bridge *bridge,
 }
 
 static enum drm_mode_status
-dw_hdmi_qp_bridge_mode_valid(struct drm_bridge *bridge,
-			     const struct drm_display_info *info,
-			     const struct drm_display_mode *mode)
+dw_hdmi_qp_bridge_tmds_char_rate_valid(const struct drm_bridge *bridge,
+				       const struct drm_display_mode *mode,
+				       unsigned long long rate)
 {
 	struct dw_hdmi_qp *hdmi = bridge->driver_private;
-	unsigned long long rate;
 
-	rate = drm_hdmi_compute_mode_clock(mode, 8, HDMI_COLORSPACE_RGB);
 	if (rate > HDMI14_MAX_TMDSCLK) {
-		dev_dbg(hdmi->dev, "Unsupported mode clock: %d\n", mode->clock);
+		dev_dbg(hdmi->dev, "Unsupported TMDS char rate: %lld\n", rate);
 		return MODE_CLOCK_HIGH;
 	}
 
@@ -510,7 +508,7 @@ static const struct drm_bridge_funcs dw_hdmi_qp_bridge_funcs = {
 	.atomic_disable = dw_hdmi_qp_bridge_atomic_disable,
 	.detect = dw_hdmi_qp_bridge_detect,
 	.edid_read = dw_hdmi_qp_bridge_edid_read,
-	.mode_valid = dw_hdmi_qp_bridge_mode_valid,
+	.hdmi_tmds_char_rate_valid = dw_hdmi_qp_bridge_tmds_char_rate_valid,
 	.hdmi_clear_infoframe = dw_hdmi_qp_bridge_clear_infoframe,
 	.hdmi_write_infoframe = dw_hdmi_qp_bridge_write_infoframe,
 };

-- 
2.39.5


