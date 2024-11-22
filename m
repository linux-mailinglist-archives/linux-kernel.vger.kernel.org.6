Return-Path: <linux-kernel+bounces-418001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D89E9D5BB3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 10:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A8E1B24AF6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 09:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E871DFE08;
	Fri, 22 Nov 2024 09:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xLO2cSv8"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091471DFDB3
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 09:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732266816; cv=none; b=bViq18Ckgy3vjiSKEBAjGE6s8C2mhX/rvz9lhFZPKn0Vq3+rq5JUWCwO78TwzgtWiJeMr03khdxYm7Cxl6Fpla3Ecf9abL33IoipScJqBqrqjZUvCAkKqKKyzBz3Vl6+s9rqgpAtGiiRjPkN44HCVU0h9c3JTLL70IrEA96shxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732266816; c=relaxed/simple;
	bh=UjNMLqX51SwfyB+kbUbjnJt95fAbmRoKvLYOPQ8ek9c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P5KO0zkKJcXbfgbsPY4RpNMUai1VBxW1AXSgAoTk4VHg4wuO7YSRRCy7JcKuP9SILeAV25uZRT0FLo13mJGDtfxSbP2c3izSGmAZ9/tiMdQ9Ra+6iSpG7b1sgPzHnJndgIG2ci+RIn8kz0Kd1WvyIYAHbXKOMWkOEg7d32Sg7GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xLO2cSv8; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53dd57589c8so322472e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 01:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732266812; x=1732871612; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n9wxCYXwjuFpbEm8J6hnlc7LqgHEUz/bPD6SI90IVR0=;
        b=xLO2cSv89KvvhooBkfbjyNQfv5kXfXWiip+K2cO1UEfx8kZqrJS30LTqghRbTgbxUY
         x4d74wm9hnuMHJ7FRXkNW3wA6O/TXQontzsooj7Iv1nz23Ss7JHmdRL8D8XxKs8ym47W
         9y7wHSV9HPTVMRVrOmSxJzpkrD2C0omhfFqVLVp2FsxoondHYfEq7zXNowVOYJzdxmjg
         icslnGHKC/YJrwoUxaiN6W8Pzp6BT1ZBGInr2z51iEXtoXoP2y61xLy2EcqriNI6eg7Z
         +auNXq8N4VFy1zGl6L3s0i5nIKnHE3IF/LJCai5nQlHg9vROGNugbyYlsdTzS87OpOmg
         WOvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732266812; x=1732871612;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n9wxCYXwjuFpbEm8J6hnlc7LqgHEUz/bPD6SI90IVR0=;
        b=Ah6me8vDR8kf7l87Bl86QOEcMs/McoYngPHfCqjtEBe2Bnzt5Z9kC1Hh+o0uL594Rh
         crxYFMGAPC1+LpgE11OXOWiB8pbZ0lmq1uhNxj2hW/lC8fBOvtbnor/576UAtm4ObfHW
         GUSR/JIZv1FEI2t8GzsPLxW4H9lor0odBxp9JRgmXHxIGewvO+pjyUyvzcR/9HTvH7Yf
         XOei1H31jzsXScnAhOeT7YuM+jXgK+/q886ksRFsm/p521XMMaXCaIlyvABiS905qqoM
         +ENmhutux2Y3ry38M2/+BPAXQPVtfLECKenZ2fE0/kbf+GAi0Mavyg3XWviHIdimvF17
         w5QQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVcE3JMkFiMenfUSXHUtr9lkdQ2ICU8PgWbQPRhFc/abHE1No33I0shO9tupRDhFleOqPJdVo8MEYr4Zc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKWEwhZgxsN32hF0Iu3j1I8h/jGIcvTsfb/8r4H+ydQ2USHpUS
	nNIGfa8zgAjNI48hlcLtNmcG7+9yAplCt+269LldI98VkcGe72vjKkGLDdmizUQvhWoT2CP3Cip
	X
X-Gm-Gg: ASbGnct3+TCUv1IgbuT+Dh1wn7V9KRp8uX0CwWgTnEP1n4e8FvpRnW7KT+h5crxA7u9
	7UuGcBwWqJUiJrLDAz4XvZt+D7Qx0Ol5ysJh+Hf9MjoJRrsDk/zQtTRIt0hg+2SJRAkvii/hpJZ
	Gd2H+mlCDyHwbFA0SPnPYDdeK6mePgkhidMo64c3V8NlKXaFyW8mhdZnGEtko/EBT2FLd4+RPuA
	7USSdj+rIOXHVvwQZaVofJDDfNQVqMK/x4rDYmi1UhNpGmsHB93xrBxdQ==
X-Google-Smtp-Source: AGHT+IGDeNFqG4MBKTEb+7vEM0EHIe+kSHIzZU4cqUcGBYdZXfjh6XYO9X/0YkMh3CxsrBHQKu0dXQ==
X-Received: by 2002:a05:6512:ea2:b0:53d:c9ae:a978 with SMTP id 2adb3069b0e04-53dd29c2410mr650169e87.4.1732266811943;
        Fri, 22 Nov 2024 01:13:31 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd2451386sm299530e87.77.2024.11.22.01.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 01:13:30 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 22 Nov 2024 11:13:05 +0200
Subject: [PATCH v4 09/10] drm/bridge: dw-hdmi-qp: replace mode_valid with
 tmds_char_rate
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-hdmi-mode-valid-v4-9-2fee4a83ab79@linaro.org>
References: <20241122-hdmi-mode-valid-v4-0-2fee4a83ab79@linaro.org>
In-Reply-To: <20241122-hdmi-mode-valid-v4-0-2fee4a83ab79@linaro.org>
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
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnQEsinpLwtf2P+iapQrUkEDkXySbQ1SEGNPG+E
 yMN1AXKzKeJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ0BLIgAKCRCLPIo+Aiko
 1UAWB/wNkyuzaaWNjb3TQ3pzTEcHC7B/Rpy9L6BOjIvOeuTqTWll9d3zLo9QEE1PDxJLav2S509
 /GcNdsoEza+Au8Yx2/cJRv0J8J0BcqhPP6v01atHSxQ/lQESAhnjtbezigKj5F6augKx4qn+hBU
 05oVtI6caS1lItX/bI51kj0LEdFXBhJhBE6wQ8+jdC/YQiN6kTW7lFsat02wgdaeNGebhcNB3x5
 S4eJMeHGa15XNxAzBSWFbFzktMTFpbMpPra4zPxZpisIFGPMIpdwOSUiRLCP8Z24s4vpMhROld2
 EsX+4FEudWGB4pshKsMVn0Zbj+v8pVuawOqXGg9LMIj+ZYLn
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


