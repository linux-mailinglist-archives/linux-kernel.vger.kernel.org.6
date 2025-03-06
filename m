Return-Path: <linux-kernel+bounces-548013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBA3A53ECC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 01:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DC2718929A4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 00:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038E7CA6B;
	Thu,  6 Mar 2025 00:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MmpHc2nB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1D8367
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 00:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741219329; cv=none; b=Sn10VrRp3FAwDK4Kog3YzpGtuawA1pcuYE+zzlUdIvyBGCa4myUVHEBkhV7CPaKcM0QarND02yjGIDRRStRu0a7cWtMYgjdk1fe5aHcIsHXNUzaiVdzXWBJ03+J6dvec2eVrWGjytSrhGhu0L7bg4U2xGb0CJA231MruayLqCfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741219329; c=relaxed/simple;
	bh=SI01v/GvXKsWkHCWbN4W6/RI+OOqT+u0JdAUIdO8NYQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=huSvy6C7a+0XKmJ5U/paAwBIYX+X7MwRLrZ/Hl9h7cuWVxqawq3ijCU4AdfSDzS8CisSY8EwUVlyH5pKoA5GD5psB35Jg1Tyrae0eknn5i/fhQC8YYnco0Y5D+sFbDDP+e03hr4cnjCfRc01adaeXo3uZ948fDujlThYxiU1GGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MmpHc2nB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741219325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jEKt+hBJR4uXO0c4V+S/A62H5N37CE5EDIIAzZxF7mQ=;
	b=MmpHc2nBXmVlnBU59T07BTgEOOVJfxZctXMRQglAiyI6jAuyJR9CkAMXmCb8oNCLrpS4fD
	sKgLqqHVQIAjqFnGIITsipm3T8nITD8jdVYnUg1aeLfGTb+Kooo4FlzjLOeoeUWseTnRI/
	7vhLO1tNVKRIHzgWk5eEcgyAow/NKqg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-wQY37EuaMxydvWyHApR1eg-1; Wed,
 05 Mar 2025 19:01:47 -0500
X-MC-Unique: wQY37EuaMxydvWyHApR1eg-1
X-Mimecast-MFC-AGG-ID: wQY37EuaMxydvWyHApR1eg_1741219306
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6F8F6180A8F8;
	Thu,  6 Mar 2025 00:01:45 +0000 (UTC)
Received: from asrivats-na.rmtustx.csb (unknown [10.2.16.107])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 99A6E1955DCE;
	Thu,  6 Mar 2025 00:01:42 +0000 (UTC)
From: Anusha Srivatsa <asrivats@redhat.com>
Date: Wed, 05 Mar 2025 19:01:41 -0500
Subject: [PATCH] drm/panel/synaptics-r63353: Use _multi variants
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-mipi-synaptic-1-v1-1-92017cd19ef6@redhat.com>
X-B4-Tracking: v=1; b=H4sIAOTlyGcC/x3MTQqAIBBA4avIrBvwd9NVooXoVLPIRCMK6e5Jy
 2/xXoNKhanCKBoUurjykTrUICBsPq2EHLtBS+2kkQ53zoz1ST6fHFCh19IaZ02IxkOvcqGF7/8
 4ze/7AYM7zthhAAAA
X-Change-ID: 20250305-mipi-synaptic-1-a2043543cd3a
To: Michael Trimarchi <michael@amarulasolutions.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Tejas Vipin <tejasvipin76@gmail.com>, Doug Anderson <dianders@chromium.org>, 
 Anusha Srivatsa <asrivats@redhat.com>, Maxime Ripard <mripard@kernel.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741219302; l=4982;
 i=asrivats@redhat.com; s=20250122; h=from:subject:message-id;
 bh=SI01v/GvXKsWkHCWbN4W6/RI+OOqT+u0JdAUIdO8NYQ=;
 b=bnb9Gz3wAJPi0ser8N+I+0FlLNl5cDMN3jw0NPXqOO3aKy0U5R6CHsiJpdIMUJ2CLI7Q9tbRC
 J2/4Jpv1NUjAJN7q3nvKDgIbL2nSuWf/YUky0qEHXbILbyRgC+gzO74
X-Developer-Key: i=asrivats@redhat.com; a=ed25519;
 pk=brnIHkBsUZEhyW6Zyn0U92AeIZ1psws/q8VFbIkf1AU=
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Move away from using deprecated API and use _multi
variants if available. Use mipi_dsi_msleep()
and mipi_dsi_usleep_range() instead of msleep()
and usleep_range() respectively.

Used Coccinelle to find the multiple occurences.
SmPl patch:
@rule@
identifier dsi_var;
identifier r;
identifier func;
type t;
position p;
expression dsi_device;
expression list es;
@@
t func(...) {
...
struct mipi_dsi_device *dsi_var = dsi_device;
+struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi_var };
<+...
(
-mipi_dsi_dcs_write_seq(dsi_var,es)@p;
+mipi_dsi_dcs_write_seq_multi(&dsi_ctx,es);
|
-mipi_dsi_generic_write_seq(dsi_var,es)@p;
+mipi_dsi_generic_write_seq_multi(&dsi_ctx,es);
|
-mipi_dsi_generic_write(dsi_var,es)@p;
+mipi_dsi_generic_write_multi(&dsi_ctx,es);
|
-r = mipi_dsi_dcs_nop(dsi_var)@p;
+mipi_dsi_dcs_nop_multi(&dsi_ctx);
|
....rest of API
..
)
-if(r < 0) {
-...
-}
...+>

Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Tejas Vipin <tejasvipin76@gmail.com>
Cc: Doug Anderson <dianders@chromium.org>
Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
---
Previous attempt for this change was addressed in:[1]
The series did not handle returns properly and still
used msleep() and usleep_range() API.
It also collided with an Tejas's similar efforts.

Will be sending the patches per driver instead of
major haul of changes.

Following [2] for reference.

[1] -> https://patchwork.freedesktop.org/series/144824/
[2] -> https://lore.kernel.org/dri-devel/20250220045721.145905-1-tejasvipin76@gmail.com/#iZ31drivers:gpu:drm:panel:panel-sony-td4353-jdi.c
---
 drivers/gpu/drm/panel/panel-synaptics-r63353.c | 64 +++++++-------------------
 1 file changed, 17 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-synaptics-r63353.c b/drivers/gpu/drm/panel/panel-synaptics-r63353.c
index 17349825543fe6a117bbfd9cb92a564ce433d13a..9cb1fe985a6fde7a475746019e89bd1dcee898ff 100644
--- a/drivers/gpu/drm/panel/panel-synaptics-r63353.c
+++ b/drivers/gpu/drm/panel/panel-synaptics-r63353.c
@@ -106,53 +106,32 @@ static int r63353_panel_power_off(struct r63353_panel *rpanel)
 static int r63353_panel_activate(struct r63353_panel *rpanel)
 {
 	struct mipi_dsi_device *dsi = rpanel->dsi;
-	struct device *dev = &dsi->dev;
-	int i, ret;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
+	int i;
 
-	ret = mipi_dsi_dcs_soft_reset(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to do Software Reset (%d)\n", ret);
-		goto fail;
-	}
+	mipi_dsi_dcs_soft_reset_multi(&dsi_ctx);
 
-	usleep_range(15000, 17000);
+	mipi_dsi_usleep_range(&dsi_ctx, 15000, 17000);
 
-	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to enter sleep mode (%d)\n", ret);
-		goto fail;
-	}
+	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
 
 	for (i = 0; i < rpanel->pdata->init_length; i++) {
 		const struct r63353_instr *instr = &rpanel->pdata->init[i];
 
-		ret = mipi_dsi_dcs_write_buffer(dsi, instr->data, instr->len);
-		if (ret < 0)
-			goto fail;
+		mipi_dsi_dcs_write_buffer_multi(&dsi_ctx, instr->data,
+						instr->len);
 	}
 
-	msleep(120);
+	mipi_dsi_msleep(&dsi_ctx, 120);
 
-	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to exit sleep mode (%d)\n", ret);
-		goto fail;
-	}
+	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
 
-	usleep_range(5000, 10000);
+	mipi_dsi_usleep_range(&dsi_ctx, 5000, 10000);
 
-	ret = mipi_dsi_dcs_set_display_on(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to set display ON (%d)\n", ret);
-		goto fail;
-	}
-
-	return 0;
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
 
-fail:
-	gpiod_set_value(rpanel->reset_gpio, 0);
+	return dsi_ctx.accum_err;
 
-	return ret;
 }
 
 static int r63353_panel_prepare(struct drm_panel *panel)
@@ -181,24 +160,15 @@ static int r63353_panel_prepare(struct drm_panel *panel)
 static int r63353_panel_deactivate(struct r63353_panel *rpanel)
 {
 	struct mipi_dsi_device *dsi = rpanel->dsi;
-	struct device *dev = &dsi->dev;
-	int ret;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
 
-	ret = mipi_dsi_dcs_set_display_off(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to set display OFF (%d)\n", ret);
-		return ret;
-	}
+	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
 
-	usleep_range(5000, 10000);
+	mipi_dsi_usleep_range(&dsi_ctx, 5000, 10000);
 
-	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to enter sleep mode (%d)\n", ret);
-		return ret;
-	}
+	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
 
-	return 0;
+	return dsi_ctx.accum_err;
 }
 
 static int r63353_panel_unprepare(struct drm_panel *panel)

---
base-commit: ced7486468ac3b38d59a69fca5d97998499c936b
change-id: 20250305-mipi-synaptic-1-a2043543cd3a

Best regards,
-- 
Anusha Srivatsa <asrivats@redhat.com>


