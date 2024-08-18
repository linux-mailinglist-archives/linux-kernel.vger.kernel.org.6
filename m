Return-Path: <linux-kernel+bounces-291015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8568F955C3E
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 12:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D03A281DD0
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 10:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F61145B25;
	Sun, 18 Aug 2024 10:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="oNPK3y9K"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CA449652
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 10:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723977829; cv=none; b=DUWod7t1hb/AjPIw+o67H5V1as8n5T5Djr/UTAyWZP6jYzSZoadcI2xv6/1W/Jba0UW+YUrCf15UGDuS20I6qYhHKK8giG9FiEzf7e/5eSVehjX8XNEy4DUhc5OgoRndJHV0a1SgHTwKdCvcYIICAGkiItc0hopsHTjMdvFlHc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723977829; c=relaxed/simple;
	bh=8OwIe+Om8PJ/rkkIDNqTcxOw4A34J4vOTXzTD8uyJD8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C27Q/xEvDmMgg8MQM6no4QHxy5MrZTAtgbmIBqKvfZ6yO+WCht1T/aoCIOfifuv5fYuF7eVjOxXb2pGFRlbWiTZhCRmEA8jXLOh62FPuC+sQCCDynFuHhbGlQLa7I9j/KhyrCiJBswIHEawB1kXtWo5r3KRw2ZnbC1Xeek8UtTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=oNPK3y9K; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1723977821;
	bh=8OwIe+Om8PJ/rkkIDNqTcxOw4A34J4vOTXzTD8uyJD8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oNPK3y9KB0tVRgWv7dpEZrbSixZh0XGTbRjOOD+4vpffIP8ZLeZLshQTjGS9W13rO
	 bP4LCpMtxds5+Xrt3dUMkNUx6qujeMEE+QhmpVnM1Vtb0P4fLhBSgzyMR9NRmUoLg5
	 FCNaRcPpJHUqqGoXRbdcDJ9hJOTieHX9bE/e+0U0=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 18 Aug 2024 12:43:32 +0200
Subject: [PATCH 08/12] drm/amdgpu: Switch amdgpu_connector to struct
 drm_edid
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240818-amdgpu-drm_edid-v1-8-aea66c1f7cf4@weissschuh.net>
References: <20240818-amdgpu-drm_edid-v1-0-aea66c1f7cf4@weissschuh.net>
In-Reply-To: <20240818-amdgpu-drm_edid-v1-0-aea66c1f7cf4@weissschuh.net>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, jinzh <jinzh@github.amd.com>, 
 Aric Cyr <Aric.Cyr@amd.com>, Alan Liu <HaoPing.Liu@amd.com>, 
 Tony Cheng <Tony.Cheng@amd.com>, 
 Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Harry Wentland <Harry.Wentland@amd.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723977820; l=11816;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=8OwIe+Om8PJ/rkkIDNqTcxOw4A34J4vOTXzTD8uyJD8=;
 b=0Zk8WvCbJZ7DRz5Olf7xiaL2ZhTfRI4okKsiaumYhHpWKPjK4EV8Wyv+JPPc8LHlSuIfWAzYy
 TfI2BsB6l9CBeFIKxU/9MBk8Ana4yhe7XLsiqXQTRYvcZOl2nTt2QF+
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

"struct drm_edid" is the safe and recommended alternative to "struct edid".

Rename the member to make sure that no usage sites are missed,
as "struct drm_edid" has some restrictions, for example it can not be
used with kfree().

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c | 56 +++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h       |  3 +-
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c         |  4 +-
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c         |  4 +-
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c          |  4 +-
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c          |  4 +-
 6 files changed, 38 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
index 344e0a9ee08a..75eac808b9e3 100644
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
@@ -277,32 +277,34 @@ static void amdgpu_connector_get_edid(struct drm_connector *connector)
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
+			drm_edid_connector_update(connector, amdgpu_connector->drm_edid);
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
@@ -310,12 +312,12 @@ static int amdgpu_connector_ddc_get_modes(struct drm_connector *connector)
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
 
@@ -731,7 +733,7 @@ amdgpu_connector_lvds_detect(struct drm_connector *connector, bool force)
 
 	/* check for edid as well */
 	amdgpu_connector_get_edid(connector);
-	if (amdgpu_connector->edid)
+	if (amdgpu_connector->drm_edid)
 		ret = connector_status_connected;
 	/* check acpi lid status ??? */
 
@@ -881,13 +883,13 @@ amdgpu_connector_vga_detect(struct drm_connector *connector, bool force)
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
@@ -1062,14 +1064,14 @@ amdgpu_connector_dvi_detect(struct drm_connector *connector, bool force)
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
index 5e3faefc5510..e584997c7777 100644
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
index 742adbc460c9..3ad9e58979ab 100644
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
index 8d46ebadfa46..5df1d69a2759 100644
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
index f08dc6a3886f..dbdb060a578c 100644
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
index a6a3adf2ae13..f6b8deab9b49 100644
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
2.46.0


