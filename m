Return-Path: <linux-kernel+bounces-406538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACEBB9C6088
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 19:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B33F285A78
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 18:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0326215024;
	Tue, 12 Nov 2024 18:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="VUP3FlB2"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2318B19F13C
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 18:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731436592; cv=none; b=MFZPtE0i3igVq3I5wS5yH657vwHnkmuHJVi1x7Pfl1LkMGotXY/dhWb1ayR56a8GEl94IvJPBRZ9nc9DU28MB4y8pzSq2lOFM0gVUO67g+dwEcVeTkEblURQs49SrZIP+wE39xiO85tUdqPk9LG8i+veQ2jVI/isUmg9STSC+so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731436592; c=relaxed/simple;
	bh=+55KiKJDO0XlLRpgGt/vQ9q4UhxzJcIzO9UWJpYd12M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FPAA6EWlVqsEd3Tf2z08/Fm393qLTzl5YDf+jYTuzQQPDSR5CSv5M3QZ/G9HXpUAXljTOSnTmbUs2YPNtUs/ArezLgLTtGErZMZ5nJP4vtowVy0BvL/yW9MppwY2cqWLotDQ/rnRjYZkDgd/LBD1HZkSIB+yoPdV0PduweMEnP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=VUP3FlB2; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1731436589;
	bh=+55KiKJDO0XlLRpgGt/vQ9q4UhxzJcIzO9UWJpYd12M=;
	h=From:Date:Subject:To:Cc:From;
	b=VUP3FlB2+Kc+yJhI/SOLhjnRbtwISSxMgEmZtBl8XdahhjkJfLo2nUIGmmQw4nI5t
	 YStZcNCjdmKS/xgTCfo1Pu16DoQqsDagZLoQeA0LZh4ycRHd7sJI9Wo4mchkdyb9oa
	 CX2RiPFqgpM16JA3kI9fNLgyanukaC9t3Hg5SAB8=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 12 Nov 2024 19:36:10 +0100
Subject: [PATCH v3] drm/radeon: Switch radeon_connector to struct drm_edid
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241112-radeon-drm_edid-v3-1-8c1d9cf92915@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIABmgM2cC/3XNQQ6CMBQE0KuYrq3h/4IUV97DGIPtx3Zh0Raqh
 nB3Cy40IS5nknkzsEDeUmC71cA8RRts61IQ6xVTpnYX4lanzDDDPJMgua81tY5rfz2RtppXTaZ
 IiS0hliytbp4a+5zFw/GTPd37BHff0tjQtf41v0aY2v8HETjw/Fw2WkMFAmn/IBtCUKY3G0cdm
 8CIPwjiEsGEFFIgFAVIAL1AxnF8Axa5BjINAQAA
X-Change-ID: 20240818-radeon-drm_edid-9f0cec36e227
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731436588; l=10962;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=+55KiKJDO0XlLRpgGt/vQ9q4UhxzJcIzO9UWJpYd12M=;
 b=jKt0rDrggKJ4oAIJCQEqkEOlc4RZo+XzccjJ0uhAVpaLubbjJNunQbuO8gl01L4xUOUeyMl4e
 osnfHZha4A/Ad2yYP7ig9x/PkGg92NF2d+Pkt7wc5VtVtabK556P3Mw
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

"struct drm_edid" is the safe and recommended alternative to "struct edid".

Rename the member to make sure that no usage sites are missed,
as "struct drm_edid" has some restrictions, for example it can not be
used with kfree().

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v3:
- Rebase onto drm-next
- Link to v2: https://lore.kernel.org/r/20240822-radeon-drm_edid-v2-1-58321551811d@weissschuh.net

Changes in v2:
- Simplify some logic as drm_edid_*()-APIs can handle NULL
- Correctly use drm_edid_read_switcheroo()
- Link to v1: https://lore.kernel.org/r/20240818-radeon-drm_edid-v1-1-4b7fdd19132e@weissschuh.net
---
This is only compile-tested.
---
 drivers/gpu/drm/radeon/radeon_audio.c      |  4 +--
 drivers/gpu/drm/radeon/radeon_combios.c    |  4 +--
 drivers/gpu/drm/radeon/radeon_connectors.c | 56 +++++++++++++-----------------
 drivers/gpu/drm/radeon/radeon_mode.h       |  5 ++-
 4 files changed, 31 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_audio.c b/drivers/gpu/drm/radeon/radeon_audio.c
index 47aa06a9a94221555a4828f41a57cbe03d637ee1..59d0e47c94d0d6195e83195e90a2ad1509734c2d 100644
--- a/drivers/gpu/drm/radeon/radeon_audio.c
+++ b/drivers/gpu/drm/radeon/radeon_audio.c
@@ -311,7 +311,7 @@ static void radeon_audio_write_sad_regs(struct drm_encoder *encoder)
 	if (!connector)
 		return;
 
-	sad_count = drm_edid_to_sad(radeon_connector->edid, &sads);
+	sad_count = drm_edid_to_sad(drm_edid_raw(radeon_connector->drm_edid), &sads);
 	if (sad_count < 0)
 		DRM_ERROR("Couldn't read SADs: %d\n", sad_count);
 	if (sad_count <= 0)
@@ -335,7 +335,7 @@ static void radeon_audio_write_speaker_allocation(struct drm_encoder *encoder)
 	if (!connector)
 		return;
 
-	sad_count = drm_edid_to_speaker_allocation(radeon_connector->edid, &sadb);
+	sad_count = drm_edid_to_speaker_allocation(drm_edid_raw(radeon_connector->drm_edid), &sadb);
 	if (sad_count < 0) {
 		DRM_DEBUG("Couldn't read Speaker Allocation Data Block: %d\n",
 			  sad_count);
diff --git a/drivers/gpu/drm/radeon/radeon_combios.c b/drivers/gpu/drm/radeon/radeon_combios.c
index df8d7f56b0289996fef8e049d7ce36295f37314d..f4947acd0419ce02052d9f9b9604bd80e494327a 100644
--- a/drivers/gpu/drm/radeon/radeon_combios.c
+++ b/drivers/gpu/drm/radeon/radeon_combios.c
@@ -390,10 +390,10 @@ bool radeon_combios_check_hardcoded_edid(struct radeon_device *rdev)
 }
 
 /* this is used for atom LCDs as well */
-struct edid *
+const struct drm_edid *
 radeon_bios_get_hardcoded_edid(struct radeon_device *rdev)
 {
-	return drm_edid_duplicate(drm_edid_raw(rdev->mode_info.bios_hardcoded_edid));
+	return drm_edid_dup(rdev->mode_info.bios_hardcoded_edid);
 }
 
 static struct radeon_i2c_bus_rec combios_setup_i2c_bus(struct radeon_device *rdev,
diff --git a/drivers/gpu/drm/radeon/radeon_connectors.c b/drivers/gpu/drm/radeon/radeon_connectors.c
index f9c73c55f04f76ed5c78e9169004f8a7dea6004e..203fea5b01463807396c19fc107489779f068aac 100644
--- a/drivers/gpu/drm/radeon/radeon_connectors.c
+++ b/drivers/gpu/drm/radeon/radeon_connectors.c
@@ -261,7 +261,7 @@ static void radeon_connector_get_edid(struct drm_connector *connector)
 	struct radeon_device *rdev = dev->dev_private;
 	struct radeon_connector *radeon_connector = to_radeon_connector(connector);
 
-	if (radeon_connector->edid)
+	if (radeon_connector->drm_edid)
 		return;
 
 	/* on hw with routers, select right port */
@@ -271,8 +271,8 @@ static void radeon_connector_get_edid(struct drm_connector *connector)
 	if ((radeon_connector_encoder_get_dp_bridge_encoder_id(connector) !=
 	     ENCODER_OBJECT_ID_NONE) &&
 	    radeon_connector->ddc_bus->has_aux) {
-		radeon_connector->edid = drm_get_edid(connector,
-						      &radeon_connector->ddc_bus->aux.ddc);
+		radeon_connector->drm_edid = drm_edid_read_ddc(connector,
+							       &radeon_connector->ddc_bus->aux.ddc);
 	} else if ((connector->connector_type == DRM_MODE_CONNECTOR_DisplayPort) ||
 		   (connector->connector_type == DRM_MODE_CONNECTOR_eDP)) {
 		struct radeon_connector_atom_dig *dig = radeon_connector->con_priv;
@@ -280,22 +280,22 @@ static void radeon_connector_get_edid(struct drm_connector *connector)
 		if ((dig->dp_sink_type == CONNECTOR_OBJECT_ID_DISPLAYPORT ||
 		     dig->dp_sink_type == CONNECTOR_OBJECT_ID_eDP) &&
 		    radeon_connector->ddc_bus->has_aux)
-			radeon_connector->edid = drm_get_edid(&radeon_connector->base,
-							      &radeon_connector->ddc_bus->aux.ddc);
+			radeon_connector->drm_edid = drm_edid_read_ddc(&radeon_connector->base,
+								       &radeon_connector->ddc_bus->aux.ddc);
 		else if (radeon_connector->ddc_bus)
-			radeon_connector->edid = drm_get_edid(&radeon_connector->base,
-							      &radeon_connector->ddc_bus->adapter);
+			radeon_connector->drm_edid = drm_edid_read_ddc(&radeon_connector->base,
+								       &radeon_connector->ddc_bus->adapter);
 	} else if (vga_switcheroo_handler_flags() & VGA_SWITCHEROO_CAN_SWITCH_DDC &&
 		   connector->connector_type == DRM_MODE_CONNECTOR_LVDS &&
 		   radeon_connector->ddc_bus) {
-		radeon_connector->edid = drm_get_edid_switcheroo(&radeon_connector->base,
-								 &radeon_connector->ddc_bus->adapter);
+		radeon_connector->drm_edid = drm_edid_read_switcheroo(&radeon_connector->base,
+								      &radeon_connector->ddc_bus->adapter);
 	} else if (radeon_connector->ddc_bus) {
-		radeon_connector->edid = drm_get_edid(&radeon_connector->base,
-						      &radeon_connector->ddc_bus->adapter);
+		radeon_connector->drm_edid = drm_edid_read_ddc(&radeon_connector->base,
+							       &radeon_connector->ddc_bus->adapter);
 	}
 
-	if (!radeon_connector->edid) {
+	if (!radeon_connector->drm_edid) {
 		/* don't fetch the edid from the vbios if ddc fails and runpm is
 		 * enabled so we report disconnected.
 		 */
@@ -306,34 +306,30 @@ static void radeon_connector_get_edid(struct drm_connector *connector)
 			/* some laptops provide a hardcoded edid in rom for LCDs */
 			if (((connector->connector_type == DRM_MODE_CONNECTOR_LVDS) ||
 			     (connector->connector_type == DRM_MODE_CONNECTOR_eDP)))
-				radeon_connector->edid = radeon_bios_get_hardcoded_edid(rdev);
+				radeon_connector->drm_edid = radeon_bios_get_hardcoded_edid(rdev);
 		} else {
 			/* some servers provide a hardcoded edid in rom for KVMs */
-			radeon_connector->edid = radeon_bios_get_hardcoded_edid(rdev);
+			radeon_connector->drm_edid = radeon_bios_get_hardcoded_edid(rdev);
 		}
 	}
+
+	drm_edid_connector_update(&radeon_connector->base, radeon_connector->drm_edid);
 }
 
 static void radeon_connector_free_edid(struct drm_connector *connector)
 {
 	struct radeon_connector *radeon_connector = to_radeon_connector(connector);
 
-	kfree(radeon_connector->edid);
-	radeon_connector->edid = NULL;
+	drm_edid_free(radeon_connector->drm_edid);
+	radeon_connector->drm_edid = NULL;
 }
 
 static int radeon_ddc_get_modes(struct drm_connector *connector)
 {
 	struct radeon_connector *radeon_connector = to_radeon_connector(connector);
-	int ret;
 
-	if (radeon_connector->edid) {
-		drm_connector_update_edid_property(connector, radeon_connector->edid);
-		ret = drm_add_edid_modes(connector, radeon_connector->edid);
-		return ret;
-	}
-	drm_connector_update_edid_property(connector, NULL);
-	return 0;
+	drm_edid_connector_update(connector, radeon_connector->drm_edid);
+	return drm_edid_connector_add_modes(connector);
 }
 
 static struct drm_encoder *radeon_best_single_encoder(struct drm_connector *connector)
@@ -869,7 +865,7 @@ radeon_lvds_detect(struct drm_connector *connector, bool force)
 
 	/* check for edid as well */
 	radeon_connector_get_edid(connector);
-	if (radeon_connector->edid)
+	if (radeon_connector->drm_edid)
 		ret = connector_status_connected;
 	/* check acpi lid status ??? */
 
@@ -1012,13 +1008,12 @@ radeon_vga_detect(struct drm_connector *connector, bool force)
 		radeon_connector_free_edid(connector);
 		radeon_connector_get_edid(connector);
 
-		if (!radeon_connector->edid) {
+		if (!radeon_connector->drm_edid) {
 			DRM_ERROR("%s: probed a monitor but no|invalid EDID\n",
 					connector->name);
 			ret = connector_status_connected;
 		} else {
-			radeon_connector->use_digital =
-				!!(radeon_connector->edid->input & DRM_EDID_INPUT_DIGITAL);
+			radeon_connector->use_digital = drm_edid_is_digital(radeon_connector->drm_edid);
 
 			/* some oems have boards with separate digital and analog connectors
 			 * with a shared ddc line (often vga + hdmi)
@@ -1270,7 +1265,7 @@ radeon_dvi_detect(struct drm_connector *connector, bool force)
 		radeon_connector_free_edid(connector);
 		radeon_connector_get_edid(connector);
 
-		if (!radeon_connector->edid) {
+		if (!radeon_connector->drm_edid) {
 			DRM_ERROR("%s: probed a monitor but no|invalid EDID\n",
 					connector->name);
 			/* rs690 seems to have a problem with connectors not existing and always
@@ -1286,8 +1281,7 @@ radeon_dvi_detect(struct drm_connector *connector, bool force)
 				broken_edid = true; /* defer use_digital to later */
 			}
 		} else {
-			radeon_connector->use_digital =
-				!!(radeon_connector->edid->input & DRM_EDID_INPUT_DIGITAL);
+			radeon_connector->use_digital = drm_edid_is_digital(radeon_connector->drm_edid);
 
 			/* some oems have boards with separate digital and analog connectors
 			 * with a shared ddc line (often vga + hdmi)
diff --git a/drivers/gpu/drm/radeon/radeon_mode.h b/drivers/gpu/drm/radeon/radeon_mode.h
index 4063d3801e819ba2726b63225e5f3f7d85eb760f..0ac57ff1b9185d8594029441258c8dfe37c724d6 100644
--- a/drivers/gpu/drm/radeon/radeon_mode.h
+++ b/drivers/gpu/drm/radeon/radeon_mode.h
@@ -41,7 +41,6 @@
 struct drm_fb_helper;
 struct drm_fb_helper_surface_size;
 
-struct edid;
 struct drm_edid;
 struct radeon_bo;
 struct radeon_device;
@@ -524,7 +523,7 @@ struct radeon_connector {
 	bool use_digital;
 	/* we need to mind the EDID between detect
 	   and get modes due to analog/digital/tvencoder */
-	struct edid *edid;
+	const struct drm_edid *drm_edid;
 	void *con_priv;
 	bool dac_load_detect;
 	bool detected_by_load; /* if the connection status was determined by load */
@@ -846,7 +845,7 @@ radeon_get_crtc_scanout_position(struct drm_crtc *crtc, bool in_vblank_irq,
 				 const struct drm_display_mode *mode);
 
 extern bool radeon_combios_check_hardcoded_edid(struct radeon_device *rdev);
-extern struct edid *
+extern const struct drm_edid *
 radeon_bios_get_hardcoded_edid(struct radeon_device *rdev);
 extern bool radeon_atom_get_clock_info(struct drm_device *dev);
 extern bool radeon_combios_get_clock_info(struct drm_device *dev);

---
base-commit: 377dda2cff59825079aee3906aa4904779747b0b
change-id: 20240818-radeon-drm_edid-9f0cec36e227

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


