Return-Path: <linux-kernel+bounces-513878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC53A34FCE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 21:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 334987A3650
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 20:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0243266B7D;
	Thu, 13 Feb 2025 20:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G4zS6oXf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAA5266B4D
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 20:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739479528; cv=none; b=ld4El0vK26Px/ycEYZqXA9Fa1eMEYFYAjvp+i7cF2EahBDjUN0vV/hNB0k440A8sWNQZVHaG0vHjOYs/1L4fCiUQOQx4hipvkCBEMbEmpXE0MwhmnSYzeegKUmbaO4KueV+sk/zy6hQ34BzoSbpjLqeOxNTUixaxa4SEkyQJcsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739479528; c=relaxed/simple;
	bh=iBSIyXxZLfc5CYXFt2SiF2Ct8SUZjH8mOx/XQMf06tk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jF5LT/WXjgMZkiAukrAC55PowQQX3vdKW3FAM0z3HPAvKmLM1zXaPDEG7GQFfEhld1QmlM6LFo/pyA/VRGfLPHcW8miZUmxrtaDRCRl0UDmLqM1DWoZDrrkRFspvjCCoHGVLVmfU+h8dwRiKXuWmHghMcelX9K68V1M3wWC7dK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G4zS6oXf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739479525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2pmFFYidqfZYQBAFHWefHjYF+aQ5awZIuX3W0GYqmBQ=;
	b=G4zS6oXfT7+eyVxd/EUcdaXYwQwkjqBDzJmeYmsDZWbDDjsnhgcNDiIV3b+1numemIi0J3
	jWSC6RMj4ai4eCK+vXgSDoIOJgE+NKahECSIPkDaGbPM2znkRgvvi0def0wAfkxtw6zC8R
	rcw+zVKOrYQtpfIIt7V6dW/XVrdwLr8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-549-74VN121BOCml6pREQiEG3w-1; Thu,
 13 Feb 2025 15:45:19 -0500
X-MC-Unique: 74VN121BOCml6pREQiEG3w-1
X-Mimecast-MFC-AGG-ID: 74VN121BOCml6pREQiEG3w
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8FB701801A0D;
	Thu, 13 Feb 2025 20:45:17 +0000 (UTC)
Received: from asrivats-na.rmtustx.csb (unknown [10.2.16.199])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4A22E19373D9;
	Thu, 13 Feb 2025 20:45:14 +0000 (UTC)
From: Anusha Srivatsa <asrivats@redhat.com>
Date: Thu, 13 Feb 2025 15:44:26 -0500
Subject: [PATCH 09/20] drm/panel/jdi-lpm102a188a: Move to using
 mipi_dsi_*_multi() variants
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250213-mipi_cocci_multi-v1-9-67d94ff319cc@redhat.com>
References: <20250213-mipi_cocci_multi-v1-0-67d94ff319cc@redhat.com>
In-Reply-To: <20250213-mipi_cocci_multi-v1-0-67d94ff319cc@redhat.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Joel Selvaraj <jo@jsfamily.in>, Ondrej Jirman <megi@xff.cz>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Jianhua Lu <lujianhua000@gmail.com>, Robert Chiras <robert.chiras@nxp.com>, 
 Artur Weber <aweber.kernel@gmail.com>, Jonathan Corbet <corbet@lwn.net>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Anusha Srivatsa <asrivats@redhat.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739479476; l=9233;
 i=asrivats@redhat.com; s=20250122; h=from:subject:message-id;
 bh=iBSIyXxZLfc5CYXFt2SiF2Ct8SUZjH8mOx/XQMf06tk=;
 b=ximdAIpedlDkjt26NJDGyfLAlXPAyIjyx+994APP4rcsIt2cKLwUAz4tRegWMYbbWwvKoTPFO
 nyFfbWdzJYJBFE+++OHLEQa2aLg23B846c2VJRU6Fn2MMV85fxsuKCY
X-Developer-Key: i=asrivats@redhat.com; a=ed25519;
 pk=brnIHkBsUZEhyW6Zyn0U92AeIZ1psws/q8VFbIkf1AU=
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Stop using deprecated API.
Used Coccinelle to make the change.

@rule_2@
expression dsi_var;
expression list es;
identifier jdi;
@@
struct mipi_dsi_device *dsi0 = pinfo->dsi[0];
struct mipi_dsi_device *dsi1 = pinfo->dsi[1];
+struct mipi_dsi_multi_context dsi_ctx0 = { .dsi = dsi0 };
+struct mipi_dsi_multi_context dsi_ctx1 = { .dsi = dsi1 };
<+...
-mipi_dsi_dual_dcs_write_seq(dsi0, dsi1, es);
+mipi_dsi_dual_dcs_write_seq(dsi_ctx0, dsi_ctx1, es);
...+>

@rule_2@
identifier func;
identifier r;
type t;
expression list es;
position p;
@@
t func(...) {
<+...
(
-mipi_dsi_dcs_write_seq(dsi_var,es);
+mipi_dsi_dcs_write_seq_multi(&dsi_ctx,es);
|
-r = mipi_dsi_dcs_exit_sleep_mode(jdi->link1)@p;
+mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx1);
|
-r = mipi_dsi_dcs_enter_sleep_mode(jdi->link1)@p;
+mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx1);
|
-r = mipi_dsi_dcs_set_display_off(jdi->link1)@p;
+mipi_dsi_dcs_set_display_off_multi(&dsi_ctx1);
|
.....//rest of the mipi APIs with _multi variant
)
<+...
-if(r < 0) {
-...
-}
...+>

Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
---
 drivers/gpu/drm/panel/panel-jdi-lpm102a188a.c | 141 ++++++++------------------
 1 file changed, 41 insertions(+), 100 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-jdi-lpm102a188a.c b/drivers/gpu/drm/panel/panel-jdi-lpm102a188a.c
index 5b5082efb282bcf705cf2d38dea24901e9803648..aa0490235eda32625443622cb622b9dc1c73b86a 100644
--- a/drivers/gpu/drm/panel/panel-jdi-lpm102a188a.c
+++ b/drivers/gpu/drm/panel/panel-jdi-lpm102a188a.c
@@ -81,25 +81,18 @@ static int jdi_panel_disable(struct drm_panel *panel)
 static int jdi_panel_unprepare(struct drm_panel *panel)
 {
 	struct jdi_panel *jdi = to_panel_jdi(panel);
-	int ret;
+	struct mipi_dsi_multi_context dsi_ctx1 = { .dsi = jdi->link1 };
+	struct mipi_dsi_multi_context dsi_ctx2 = { .dsi = jdi->link2 };
 
-	ret = mipi_dsi_dcs_set_display_off(jdi->link1);
-	if (ret < 0)
-		dev_err(panel->dev, "failed to set display off: %d\n", ret);
+	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx1);
 
-	ret = mipi_dsi_dcs_set_display_off(jdi->link2);
-	if (ret < 0)
-		dev_err(panel->dev, "failed to set display off: %d\n", ret);
+	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx2);
 
 	/* Specified by JDI @ 50ms, subject to change */
 	msleep(50);
 
-	ret = mipi_dsi_dcs_enter_sleep_mode(jdi->link1);
-	if (ret < 0)
-		dev_err(panel->dev, "failed to enter sleep mode: %d\n", ret);
-	ret = mipi_dsi_dcs_enter_sleep_mode(jdi->link2);
-	if (ret < 0)
-		dev_err(panel->dev, "failed to enter sleep mode: %d\n", ret);
+	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx1);
+	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx2);
 
 	/* Specified by JDI @ 150ms, subject to change */
 	msleep(150);
@@ -123,65 +116,51 @@ static int jdi_panel_unprepare(struct drm_panel *panel)
 	/* Specified by JDI @ 20ms, subject to change */
 	msleep(20);
 
-	return ret;
+	return 0;
 }
 
 static int jdi_setup_symmetrical_split(struct mipi_dsi_device *left,
 				       struct mipi_dsi_device *right,
 				       const struct drm_display_mode *mode)
 {
-	int err;
+	struct mipi_dsi_multi_context dsi_ctx_left = { .dsi = left };
+	struct mipi_dsi_multi_context dsi_ctx_right = { .dsi = right };
 
-	err = mipi_dsi_dcs_set_column_address(left, 0, mode->hdisplay / 2 - 1);
-	if (err < 0) {
-		dev_err(&left->dev, "failed to set column address: %d\n", err);
-		return err;
-	}
+	mipi_dsi_dcs_set_column_address_multi(&dsi_ctx_left, 0, mode->hdisplay / 2 - 1);
 
-	err = mipi_dsi_dcs_set_column_address(right, 0, mode->hdisplay / 2 - 1);
-	if (err < 0) {
-		dev_err(&right->dev, "failed to set column address: %d\n", err);
-		return err;
-	}
+	mipi_dsi_dcs_set_column_address_multi(&dsi_ctx_right, 0, mode->hdisplay / 2 - 1);
 
-	err = mipi_dsi_dcs_set_page_address(left, 0, mode->vdisplay - 1);
-	if (err < 0) {
-		dev_err(&left->dev, "failed to set page address: %d\n", err);
-		return err;
-	}
+	mipi_dsi_dcs_set_page_address_multi(&dsi_ctx_left, 0, mode->vdisplay - 1);
 
-	err = mipi_dsi_dcs_set_page_address(right, 0, mode->vdisplay - 1);
-	if (err < 0) {
-		dev_err(&right->dev, "failed to set page address: %d\n", err);
-		return err;
-	}
+	mipi_dsi_dcs_set_page_address_multi(&dsi_ctx_right, 0, mode->vdisplay - 1);
 
 	return 0;
 }
 
 static int jdi_write_dcdc_registers(struct jdi_panel *jdi)
 {
+	struct mipi_dsi_multi_context dsi_ctx1 = { .dsi = jdi->link1 };
+	struct mipi_dsi_multi_context dsi_ctx2 = { .dsi = jdi->link2 };
 	/* Clear the manufacturer command access protection */
-	mipi_dsi_generic_write_seq(jdi->link1, MCS_CMD_ACS_PROT,
-				   MCS_CMD_ACS_PROT_OFF);
-	mipi_dsi_generic_write_seq(jdi->link2, MCS_CMD_ACS_PROT,
-				   MCS_CMD_ACS_PROT_OFF);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx1, MCS_CMD_ACS_PROT,
+					 MCS_CMD_ACS_PROT_OFF);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx2, MCS_CMD_ACS_PROT,
+					 MCS_CMD_ACS_PROT_OFF);
 	/*
 	 * Change the VGH/VGL divide rations to move the noise generated by the
 	 * TCONN. This should hopefully avoid interaction with the backlight
 	 * controller.
 	 */
-	mipi_dsi_generic_write_seq(jdi->link1, MCS_PWR_CTRL_FUNC,
-				   MCS_PWR_CTRL_PARAM1_VGH_330_DIV |
-				   MCS_PWR_CTRL_PARAM1_DEFAULT,
-				   MCS_PWR_CTRL_PARAM2_VGL_410_DIV |
-				   MCS_PWR_CTRL_PARAM2_DEFAULT);
-
-	mipi_dsi_generic_write_seq(jdi->link2, MCS_PWR_CTRL_FUNC,
-				   MCS_PWR_CTRL_PARAM1_VGH_330_DIV |
-				   MCS_PWR_CTRL_PARAM1_DEFAULT,
-				   MCS_PWR_CTRL_PARAM2_VGL_410_DIV |
-				   MCS_PWR_CTRL_PARAM2_DEFAULT);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx1, MCS_PWR_CTRL_FUNC,
+					 MCS_PWR_CTRL_PARAM1_VGH_330_DIV |
+					 MCS_PWR_CTRL_PARAM1_DEFAULT,
+					 MCS_PWR_CTRL_PARAM2_VGL_410_DIV |
+					 MCS_PWR_CTRL_PARAM2_DEFAULT);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx2, MCS_PWR_CTRL_FUNC,
+					 MCS_PWR_CTRL_PARAM1_VGH_330_DIV |
+					 MCS_PWR_CTRL_PARAM1_DEFAULT,
+					 MCS_PWR_CTRL_PARAM2_VGL_410_DIV |
+					 MCS_PWR_CTRL_PARAM2_DEFAULT);
 
 	return 0;
 }
@@ -189,6 +168,8 @@ static int jdi_write_dcdc_registers(struct jdi_panel *jdi)
 static int jdi_panel_prepare(struct drm_panel *panel)
 {
 	struct jdi_panel *jdi = to_panel_jdi(panel);
+	struct mipi_dsi_multi_context dsi_ctx1 = { .dsi = jdi->link1 };
+	struct mipi_dsi_multi_context dsi_ctx2 = { .dsi = jdi->link2 };
 	int err;
 
 	/* Disable backlight to avoid showing random pixels
@@ -239,57 +220,25 @@ static int jdi_panel_prepare(struct drm_panel *panel)
 		goto poweroff;
 	}
 
-	err = mipi_dsi_dcs_set_tear_scanline(jdi->link1,
+	mipi_dsi_dcs_set_tear_scanline_multi(&dsi_ctx1,
 					     jdi->mode->vdisplay - 16);
-	if (err < 0) {
-		dev_err(panel->dev, "failed to set tear scanline: %d\n", err);
-		goto poweroff;
-	}
 
-	err = mipi_dsi_dcs_set_tear_scanline(jdi->link2,
+	mipi_dsi_dcs_set_tear_scanline_multi(&dsi_ctx2,
 					     jdi->mode->vdisplay - 16);
-	if (err < 0) {
-		dev_err(panel->dev, "failed to set tear scanline: %d\n", err);
-		goto poweroff;
-	}
 
-	err = mipi_dsi_dcs_set_tear_on(jdi->link1,
+	mipi_dsi_dcs_set_tear_on_multi(&dsi_ctx1,
 				       MIPI_DSI_DCS_TEAR_MODE_VBLANK);
-	if (err < 0) {
-		dev_err(panel->dev, "failed to set tear on: %d\n", err);
-		goto poweroff;
-	}
 
-	err = mipi_dsi_dcs_set_tear_on(jdi->link2,
+	mipi_dsi_dcs_set_tear_on_multi(&dsi_ctx2,
 				       MIPI_DSI_DCS_TEAR_MODE_VBLANK);
-	if (err < 0) {
-		dev_err(panel->dev, "failed to set tear on: %d\n", err);
-		goto poweroff;
-	}
 
-	err = mipi_dsi_dcs_set_pixel_format(jdi->link1, MIPI_DCS_PIXEL_FMT_24BIT);
-	if (err < 0) {
-		dev_err(panel->dev, "failed to set pixel format: %d\n", err);
-		goto poweroff;
-	}
+	mipi_dsi_dcs_set_pixel_format_multi(&dsi_ctx1, MIPI_DCS_PIXEL_FMT_24BIT);
 
-	err = mipi_dsi_dcs_set_pixel_format(jdi->link2, MIPI_DCS_PIXEL_FMT_24BIT);
-	if (err < 0) {
-		dev_err(panel->dev, "failed to set pixel format: %d\n", err);
-		goto poweroff;
-	}
+	mipi_dsi_dcs_set_pixel_format_multi(&dsi_ctx2, MIPI_DCS_PIXEL_FMT_24BIT);
 
-	err = mipi_dsi_dcs_exit_sleep_mode(jdi->link1);
-	if (err < 0) {
-		dev_err(panel->dev, "failed to exit sleep mode: %d\n", err);
-		goto poweroff;
-	}
+	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx1);
 
-	err = mipi_dsi_dcs_exit_sleep_mode(jdi->link2);
-	if (err < 0) {
-		dev_err(panel->dev, "failed to exit sleep mode: %d\n", err);
-		goto poweroff;
-	}
+	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx2);
 
 	err = jdi_write_dcdc_registers(jdi);
 	if (err < 0) {
@@ -302,17 +251,9 @@ static int jdi_panel_prepare(struct drm_panel *panel)
 	 */
 	msleep(150);
 
-	err = mipi_dsi_dcs_set_display_on(jdi->link1);
-	if (err < 0) {
-		dev_err(panel->dev, "failed to set display on: %d\n", err);
-		goto poweroff;
-	}
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx1);
 
-	err = mipi_dsi_dcs_set_display_on(jdi->link2);
-	if (err < 0) {
-		dev_err(panel->dev, "failed to set display on: %d\n", err);
-		goto poweroff;
-	}
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx2);
 
 	jdi->link1->mode_flags &= ~MIPI_DSI_MODE_LPM;
 	jdi->link2->mode_flags &= ~MIPI_DSI_MODE_LPM;

-- 
2.47.0


