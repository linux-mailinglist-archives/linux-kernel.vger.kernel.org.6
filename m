Return-Path: <linux-kernel+bounces-426069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8442F9DEE77
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 02:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44C04282178
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 01:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DF013212A;
	Sat, 30 Nov 2024 01:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dV7xEaK/"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F8A70817
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 01:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732931571; cv=none; b=UatI3rH3mnRQfBjrMu56wihLKfMxBERlIY7HLZp/hpp8MGaI8vZgbzUhVdPnfvgKDocZob1oyhIMlpIBLbg4WZKkeGnq3i0fpjWTdyDY9oYF/QNlFrTJmdlRZl+onhFRARcG3hgh3H61uDe1x/TV0DkHJTUIvx6pwVeVwum+jdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732931571; c=relaxed/simple;
	bh=7WdeDK9PVMnPHS0xN6wrfKPJv4ESCzGwmvZnGPcMZ/4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WUUhla+9Mkang9fBKi+v08bLdBTM9yyREf7tIdWgIkSGCfS6kGbTszCUw+FIYQJkDVVC7jyceW3AX4BBEhEZxx29X9yyvpJhhMLJkWhkwW0zY5X25d8CdzbSMWTuVMJIx6gPe2lsReDecOHW0WZL9dnphSEi2/5eNLBqBrmjUo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dV7xEaK/; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53df1e0641fso2829828e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 17:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732931568; x=1733536368; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YdWiUnW6vTgN40+31xk3R74ZtFvE1HPhsssihDLePE8=;
        b=dV7xEaK//HSPS4Dzj6rC6BAPOC2IF4PAyFQzpu0Eypc4Nk9L9gnHUF+QJPWzYcnBGc
         iFEqC/fjPw+Fbf8lZZGAWcBmarAQZLrjkqXciS16chIRQtM8ew+wIxu7D4IL812nogvy
         A21IPg+DL95h9/yTIUuBYOeBmOqyS5jNkPJkRyfeZVD39MF6mn7AgwVTsYiwLs1QPBGJ
         DFkfzOktJukwLX91jglaJH4G9RaG1S9dTByFLVCPO2kUdUOCiuSfd02Bcpk7t9qFGXb+
         lWdMhEcUP+bRr4GroGdYdr1oQibCSfoqOQRd8qNYkka70BSg3y74qLgvzmyy9yXdZs1v
         BGJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732931568; x=1733536368;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YdWiUnW6vTgN40+31xk3R74ZtFvE1HPhsssihDLePE8=;
        b=BNh0o3f/bWXq4PEMm3cSHQG4WdejbsOzGWu0TQ/JAElKOKJif+fakoscCC6HpIE8+T
         N05gFsX4+qqFnRR4jNz1bLhfgyEYhOS8Pl2bzvCPf3rH10LLBJFApIXqLJHReUqea7NL
         78rCltN77ffmO/pms/pqPJcvpsgKjqw64btwyv0jnOspGMSTFFKrRIkZBujBdiUER+Ge
         OUpySg4aeQIU0BluaDb8LBsayXp7BZUSGIOU4h5TxpyUh18fB7g6rtbZAc0aLU6oM3v1
         vXmBIW4yGmdogWU150sbQly+/WxwwuN8g834OXlcodUG8ing0gw6bFtrhKetowV3tjAR
         e2tQ==
X-Forwarded-Encrypted: i=1; AJvYcCUO0V/dIa+31if5mjZc9ha/pI4XyPmRyEqpCxT53toiBM0fGqzZ6KElJ2O0sGxKzoDl0wjhVjwucLD+v9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyInIubacC8PJ67jWvYc1utK+wYjlrrZkbfjATAG06A1O1Rnmds
	Nu4hWNDxXg4ZtSROoNl6CyLifMbBmdGB9/S+Df8+vs9FEdS3sM4vS00k1N7aIZU=
X-Gm-Gg: ASbGnctLVew5f6Uukae8nXPkzs74Pf22S0QwFomsxP6AxOvjfizG+pZIZnhc02jfA7o
	Doql33nO9XXGyxn63wHTL0Up6huZDB3pOlREdwVTDviqyP97byrEGmh0q79QIxBML3zfC1ccONJ
	KzRf9aWrD+qzoD0uF7ssxdOUmksCsro5CtjiS9qa+ReGAyPsl+irST9SWPBQGR48tJHIa/2EdHr
	SJWR+w9uariMDce4ex0ewuoQohxr2iVRmi+wmiCytwnvy69AEcpkSjqYw==
X-Google-Smtp-Source: AGHT+IHetZrvEByn4fAHRWKEq7LSlZrnAwfYhcjJyaHf3aEdtAmIagniVhOW57dJZppA3z77RAF6Dg==
X-Received: by 2002:a05:6512:1247:b0:53d:e5c0:b9b6 with SMTP id 2adb3069b0e04-53df0106d34mr8877433e87.44.1732931568173;
        Fri, 29 Nov 2024 17:52:48 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df6443172sm636408e87.84.2024.11.29.17.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 17:52:46 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 30 Nov 2024 03:52:30 +0200
Subject: [PATCH v5 05/10] drm/sun4i: use drm_hdmi_connector_mode_valid()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241130-hdmi-mode-valid-v5-5-742644ec3b1f@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1574;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=7WdeDK9PVMnPHS0xN6wrfKPJv4ESCzGwmvZnGPcMZ/4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnSm/gM3s8fwgp7qQxHuLKIwkRxeHDxfAODq0bs
 8MwPp9YbZKJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ0pv4AAKCRCLPIo+Aiko
 1bIIB/4p8mwZtQM6b7rWJ6f/3RrJdOFSVD/lB0+qokriHsrz+a1eIjtwS5cFImZWoTfABbjChFG
 9bL3aHhp153Z6qRmB0jjz74wbZ0tim+a8QACdm70DR0qaxs4/HmpfPx399A0ZxyT24MreEgH6GT
 SIq6n5AETnEoWTkEcfkowDDKtLWggZQ1t8C9j1FkKDqPZx7h+bRIoX+PGcwIDcVLd5cC4hNGvGo
 am6B8uZXEeOE6xZdG45hkGyPog/MQ3pw19KTMqs9BjjoRcYkufrdv1X+Zy1tA6GGE1tfQ+iEDoF
 COYRba5H+tZGXE0G2E/PFi//GWn2JG40uSHj31ythluMJMYH
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Use new drm_hdmi_connector_mode_valid() helper instead of a
module-specific copy.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
index b3649449de3026784ae2f3466906403a0b6e3b47..54b72fe220afacc208b3fd48d5160031127ea14a 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
@@ -205,16 +205,6 @@ static int sun4i_hdmi_connector_atomic_check(struct drm_connector *connector,
 	return 0;
 }
 
-static enum drm_mode_status
-sun4i_hdmi_connector_mode_valid(struct drm_connector *connector,
-				struct drm_display_mode *mode)
-{
-	unsigned long long rate = drm_hdmi_compute_mode_clock(mode, 8,
-							      HDMI_COLORSPACE_RGB);
-
-	return sun4i_hdmi_connector_clock_valid(connector, mode, rate);
-}
-
 static int sun4i_hdmi_get_modes(struct drm_connector *connector)
 {
 	struct sun4i_hdmi *hdmi = drm_connector_to_sun4i_hdmi(connector);
@@ -269,7 +259,7 @@ static const struct drm_connector_hdmi_funcs sun4i_hdmi_hdmi_connector_funcs = {
 
 static const struct drm_connector_helper_funcs sun4i_hdmi_connector_helper_funcs = {
 	.atomic_check	= sun4i_hdmi_connector_atomic_check,
-	.mode_valid	= sun4i_hdmi_connector_mode_valid,
+	.mode_valid	= drm_hdmi_connector_mode_valid,
 	.get_modes	= sun4i_hdmi_get_modes,
 };
 

-- 
2.39.5


