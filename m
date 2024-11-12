Return-Path: <linux-kernel+bounces-406531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A039C6334
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 22:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEEF1B800BE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 18:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3C1217909;
	Tue, 12 Nov 2024 18:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="DLcfL/Dm"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB415215024
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 18:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731436466; cv=none; b=Gz0iPHESpj+uKgFaB7fwocLTrH5ltovNDuuyCZxzRQFg/XrO/xnLRMKleAyxgFVazVpP3Jrax/iBSCAvzm0ayrrNPpEeOeIXqaeI7pu7HZ5Tq4REURCodxpa0ZadDS44vGndaGFi83jSCcvjzspnIZaZKl6sfY4jmI2Q6zzB/8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731436466; c=relaxed/simple;
	bh=vfFChF/mpp6Y+jDrgJ5oMCTjoYQYj2LykqmDiJ4JUdM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dVQzuiYU2jYJpEHw64SahmVy7pPjXSgYBfT9QgZRsjgsG6uAvkFRQOzZvGE5Q3oiVuX/RAvEjtueT+Dpr7tYSFuXosvuUb2O0iFKU3E1ZdqTnRAYJVKZj0YqzT2z6uLPV5nieO583CcclwuplT/SpHbwVEeZadZ2W4EruYfGiwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=DLcfL/Dm; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1731436455;
	bh=vfFChF/mpp6Y+jDrgJ5oMCTjoYQYj2LykqmDiJ4JUdM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DLcfL/Dm2Wdt/G0Rm1Orx9BPNsGUFNEpvhFSkvw4FkMXYYxSf+j4YOmR3WuNw0w0z
	 kL/1pxIFrqo+MWrqoifeCpOxLAtf6yRLGCKf8FLoY7VjAP5zLDudN/v8O4M51SoJpG
	 y2gLSSuWo8FlaWN0GBaGxWyyj3WYIa1OwqrPVAdk=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 12 Nov 2024 19:34:13 +0100
Subject: [PATCH v2 4/7] drm/amdgpu: Switch amdgpu_connector to struct
 drm_edid
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241112-amdgpu-drm_edid-v2-4-1399dc0f0469@weissschuh.net>
References: <20241112-amdgpu-drm_edid-v2-0-1399dc0f0469@weissschuh.net>
In-Reply-To: <20241112-amdgpu-drm_edid-v2-0-1399dc0f0469@weissschuh.net>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, 
 jinzh <jinzh@github.amd.com>, Aric Cyr <Aric.Cyr@amd.com>, 
 Alan Liu <HaoPing.Liu@amd.com>, Tony Cheng <Tony.Cheng@amd.com>, 
 Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Harry Wentland <Harry.Wentland@amd.com>, 
 Melissa Wen <mwen@igalia.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731436454; l=12081;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=vfFChF/mpp6Y+jDrgJ5oMCTjoYQYj2LykqmDiJ4JUdM=;
 b=dcV7EfOiqydNPq1zRiKd6HRHf2cgRV9aBENDSY/UjbpcVttE9spvVaSQmDOz59csrxyOGQq6g
 meeoVQVJENVBujWx0YHR6PFoPvECnPaXLmbTLJrLIhmmeZVl4/om0MD
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

"struct drm_edid" is the safe and recommended alternative to "struct edid".

Rename the member to make sure that no usage sites are missed,
as "struct drm_edid" has some restrictions, for example it can not be
used with kfree().

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c | 55 +++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h       |  3 +-
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c         |  4 +-
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c         |  4 +-
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c          |  4 +-
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c          |  4 +-
 6 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
index 344e0a9ee08a99a7e874e4ed31c28901b7ea25b0..436f9ae0959f650102ac0ea372195da5d22c7ec9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
@@ -246,10 +246,10 @@ amdgpu_connector_find_encoder(struct drm_connector *connector,
 	return NULL;
 }
 
-static struct edid *
+static const struct drm_edid *
 amdgpu_connector_get_hardcoded_edid(struct amdgpu_device *adev)
 {
-	return drm_edid_duplicate(drm_edid_raw(adev->mode_info.bios_hardcoded_edid));
+	return drm_edid_dup(adev->mode_info.bios_hardcoded_edid);
 }
 
 static void amdgpu_connector_get_edid(struct drm_connector *connector)
@@ -258,7 +258,7 @@ static void amdgpu_connector_get_edid(struct drm_connector *connector)
 	struct amdgpu_device *adev = drm_to_adev(dev);
 	struct amdgpu_connector *amdgpu_connector = to_amdgpu_connector(connector);
 
-	if (amdgpu_connector->edid)
+	if (amdgpu_connector->drm_edid)
 		return;
 
 	/* on hw with routers, select right port */
@@ -268,8 +268,8 @@ static void amdgpu_connector_get_edid(struct drm_connector *connector)
 	if ((amdgpu_connector_encoder_get_dp_bridge_encoder_id(connector) !=
 	     ENCODER_OBJECT_ID_NONE) &&
 	    amdgpu_connector->ddc_bus->has_aux) {
-		amdgpu_connector->edid = drm_get_edid(connector,
-						      &amdgpu_connector->ddc_bus->aux.ddc);
+		amdgpu_connector->drm_edid = drm_edid_read_ddc(
+				connector, &amdgpu_connector->ddc_bus->aux.ddc);
 	} else if ((connector->connector_type == DRM_MODE_CONNECTOR_DisplayPort) ||
 		   (connector->connector_type == DRM_MODE_CONNECTOR_eDP)) {
 		struct amdgpu_connector_atom_dig *dig = amdgpu_connector->con_priv;
@@ -277,32 +277,33 @@ static void amdgpu_connector_get_edid(struct drm_connector *connector)
 		if ((dig->dp_sink_type == CONNECTOR_OBJECT_ID_DISPLAYPORT ||
 		     dig->dp_sink_type == CONNECTOR_OBJECT_ID_eDP) &&
 		    amdgpu_connector->ddc_bus->has_aux)
-			amdgpu_connector->edid = drm_get_edid(connector,
-							      &amdgpu_connector->ddc_bus->aux.ddc);
+			amdgpu_connector->drm_edid = drm_edid_read_ddc(
+					connector, &amdgpu_connector->ddc_bus->aux.ddc);
 		else if (amdgpu_connector->ddc_bus)
-			amdgpu_connector->edid = drm_get_edid(connector,
-							      &amdgpu_connector->ddc_bus->adapter);
+			amdgpu_connector->drm_edid = drm_edid_read_ddc(
+					connector, &amdgpu_connector->ddc_bus->adapter);
 	} else if (amdgpu_connector->ddc_bus) {
-		amdgpu_connector->edid = drm_get_edid(connector,
-						      &amdgpu_connector->ddc_bus->adapter);
+		amdgpu_connector->drm_edid = drm_edid_read_ddc(
+				connector, &amdgpu_connector->ddc_bus->adapter);
 	}
 
-	if (!amdgpu_connector->edid) {
+	if (!amdgpu_connector->drm_edid) {
 		/* some laptops provide a hardcoded edid in rom for LCDs */
 		if (((connector->connector_type == DRM_MODE_CONNECTOR_LVDS) ||
 		     (connector->connector_type == DRM_MODE_CONNECTOR_eDP))) {
-			amdgpu_connector->edid = amdgpu_connector_get_hardcoded_edid(adev);
-			drm_connector_update_edid_property(connector, amdgpu_connector->edid);
+			amdgpu_connector->drm_edid = amdgpu_connector_get_hardcoded_edid(adev);
 		}
 	}
+
+	drm_edid_connector_update(connector, amdgpu_connector->drm_edid);
 }
 
 static void amdgpu_connector_free_edid(struct drm_connector *connector)
 {
 	struct amdgpu_connector *amdgpu_connector = to_amdgpu_connector(connector);
 
-	kfree(amdgpu_connector->edid);
-	amdgpu_connector->edid = NULL;
+	drm_edid_free(amdgpu_connector->drm_edid);
+	amdgpu_connector->drm_edid = NULL;
 }
 
 static int amdgpu_connector_ddc_get_modes(struct drm_connector *connector)
@@ -310,12 +311,12 @@ static int amdgpu_connector_ddc_get_modes(struct drm_connector *connector)
 	struct amdgpu_connector *amdgpu_connector = to_amdgpu_connector(connector);
 	int ret;
 
-	if (amdgpu_connector->edid) {
-		drm_connector_update_edid_property(connector, amdgpu_connector->edid);
-		ret = drm_add_edid_modes(connector, amdgpu_connector->edid);
+	if (amdgpu_connector->drm_edid) {
+		drm_edid_connector_update(connector, amdgpu_connector->drm_edid);
+		ret = drm_edid_connector_add_modes(connector);
 		return ret;
 	}
-	drm_connector_update_edid_property(connector, NULL);
+	drm_edid_connector_update(connector, NULL);
 	return 0;
 }
 
@@ -731,7 +732,7 @@ amdgpu_connector_lvds_detect(struct drm_connector *connector, bool force)
 
 	/* check for edid as well */
 	amdgpu_connector_get_edid(connector);
-	if (amdgpu_connector->edid)
+	if (amdgpu_connector->drm_edid)
 		ret = connector_status_connected;
 	/* check acpi lid status ??? */
 
@@ -881,13 +882,13 @@ amdgpu_connector_vga_detect(struct drm_connector *connector, bool force)
 		amdgpu_connector_free_edid(connector);
 		amdgpu_connector_get_edid(connector);
 
-		if (!amdgpu_connector->edid) {
+		if (!amdgpu_connector->drm_edid) {
 			DRM_ERROR("%s: probed a monitor but no|invalid EDID\n",
 					connector->name);
 			ret = connector_status_connected;
 		} else {
-			amdgpu_connector->use_digital =
-				!!(amdgpu_connector->edid->input & DRM_EDID_INPUT_DIGITAL);
+			amdgpu_connector->use_digital = drm_edid_is_digital(
+					amdgpu_connector->drm_edid);
 
 			/* some oems have boards with separate digital and analog connectors
 			 * with a shared ddc line (often vga + hdmi)
@@ -1062,14 +1063,14 @@ amdgpu_connector_dvi_detect(struct drm_connector *connector, bool force)
 		amdgpu_connector_free_edid(connector);
 		amdgpu_connector_get_edid(connector);
 
-		if (!amdgpu_connector->edid) {
+		if (!amdgpu_connector->drm_edid) {
 			DRM_ERROR("%s: probed a monitor but no|invalid EDID\n",
 					connector->name);
 			ret = connector_status_connected;
 			broken_edid = true; /* defer use_digital to later */
 		} else {
-			amdgpu_connector->use_digital =
-				!!(amdgpu_connector->edid->input & DRM_EDID_INPUT_DIGITAL);
+			amdgpu_connector->use_digital = drm_edid_is_digital(
+					amdgpu_connector->drm_edid);
 
 			/* some oems have boards with separate digital and analog connectors
 			 * with a shared ddc line (often vga + hdmi)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
index 5e3faefc5510914e8865147b9788e7093517eeb7..e584997c77776c1128f2aa431c9aec7477daf48a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
@@ -50,7 +50,6 @@ struct amdgpu_device;
 struct amdgpu_encoder;
 struct amdgpu_router;
 struct amdgpu_hpd;
-struct edid;
 struct drm_edid;
 
 #define to_amdgpu_crtc(x) container_of(x, struct amdgpu_crtc, base)
@@ -623,7 +622,7 @@ struct amdgpu_connector {
 	bool use_digital;
 	/* we need to mind the EDID between detect
 	   and get modes due to analog/digital/tvencoder */
-	struct edid *edid;
+	const struct drm_edid *drm_edid;
 	void *con_priv;
 	bool dac_load_detect;
 	bool detected_by_load; /* if the connection status was determined by load */
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
index 5098c50d54c85a147cc582ab42840c3868edf8b5..8c3e1c0d86cf273a5e4b7f30088368d61d8d5881 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
@@ -1299,7 +1299,7 @@ static void dce_v10_0_audio_write_speaker_allocation(struct drm_encoder *encoder
 		return;
 	}
 
-	sad_count = drm_edid_to_speaker_allocation(amdgpu_connector->edid, &sadb);
+	sad_count = drm_edid_to_speaker_allocation(drm_edid_raw(amdgpu_connector->drm_edid), &sadb);
 	if (sad_count < 0) {
 		DRM_ERROR("Couldn't read Speaker Allocation Data Block: %d\n", sad_count);
 		sad_count = 0;
@@ -1369,7 +1369,7 @@ static void dce_v10_0_audio_write_sad_regs(struct drm_encoder *encoder)
 		return;
 	}
 
-	sad_count = drm_edid_to_sad(amdgpu_connector->edid, &sads);
+	sad_count = drm_edid_to_sad(drm_edid_raw(amdgpu_connector->drm_edid), &sads);
 	if (sad_count < 0)
 		DRM_ERROR("Couldn't read SADs: %d\n", sad_count);
 	if (sad_count <= 0)
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
index c5680ff4ab9fd8f2127c55f83e6d1562b3430e5d..a3b6436d08b0ef4274adfed16b0cde4f3971e3b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
@@ -1331,7 +1331,7 @@ static void dce_v11_0_audio_write_speaker_allocation(struct drm_encoder *encoder
 		return;
 	}
 
-	sad_count = drm_edid_to_speaker_allocation(amdgpu_connector->edid, &sadb);
+	sad_count = drm_edid_to_speaker_allocation(drm_edid_raw(amdgpu_connector->drm_edid), &sadb);
 	if (sad_count < 0) {
 		DRM_ERROR("Couldn't read Speaker Allocation Data Block: %d\n", sad_count);
 		sad_count = 0;
@@ -1401,7 +1401,7 @@ static void dce_v11_0_audio_write_sad_regs(struct drm_encoder *encoder)
 		return;
 	}
 
-	sad_count = drm_edid_to_sad(amdgpu_connector->edid, &sads);
+	sad_count = drm_edid_to_sad(drm_edid_raw(amdgpu_connector->drm_edid), &sads);
 	if (sad_count < 0)
 		DRM_ERROR("Couldn't read SADs: %d\n", sad_count);
 	if (sad_count <= 0)
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index eb7de9122d99f7208e3ca5b1c86ecd10766be5b1..482879b7e4464de0b7f2c9eaa1c16370dc7e28d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -1217,7 +1217,7 @@ static void dce_v6_0_audio_write_speaker_allocation(struct drm_encoder *encoder)
 		return;
 	}
 
-	sad_count = drm_edid_to_speaker_allocation(amdgpu_connector->edid, &sadb);
+	sad_count = drm_edid_to_speaker_allocation(drm_edid_raw(amdgpu_connector->drm_edid), &sadb);
 	if (sad_count < 0) {
 		DRM_ERROR("Couldn't read Speaker Allocation Data Block: %d\n", sad_count);
 		sad_count = 0;
@@ -1292,7 +1292,7 @@ static void dce_v6_0_audio_write_sad_regs(struct drm_encoder *encoder)
 		return;
 	}
 
-	sad_count = drm_edid_to_sad(amdgpu_connector->edid, &sads);
+	sad_count = drm_edid_to_sad(drm_edid_raw(amdgpu_connector->drm_edid), &sads);
 	if (sad_count < 0)
 		DRM_ERROR("Couldn't read SADs: %d\n", sad_count);
 	if (sad_count <= 0)
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
index 04b79ff87f756c75dba16fa34ef115bea74cf805..9ec004101a115e70f4dff9e40b4f67c898153f42 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
@@ -1272,7 +1272,7 @@ static void dce_v8_0_audio_write_speaker_allocation(struct drm_encoder *encoder)
 		return;
 	}
 
-	sad_count = drm_edid_to_speaker_allocation(amdgpu_connector->edid, &sadb);
+	sad_count = drm_edid_to_speaker_allocation(drm_edid_raw(amdgpu_connector->drm_edid), &sadb);
 	if (sad_count < 0) {
 		DRM_ERROR("Couldn't read Speaker Allocation Data Block: %d\n", sad_count);
 		sad_count = 0;
@@ -1340,7 +1340,7 @@ static void dce_v8_0_audio_write_sad_regs(struct drm_encoder *encoder)
 		return;
 	}
 
-	sad_count = drm_edid_to_sad(amdgpu_connector->edid, &sads);
+	sad_count = drm_edid_to_sad(drm_edid_raw(amdgpu_connector->drm_edid), &sads);
 	if (sad_count < 0)
 		DRM_ERROR("Couldn't read SADs: %d\n", sad_count);
 	if (sad_count <= 0)

-- 
2.47.0


