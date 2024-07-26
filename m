Return-Path: <linux-kernel+bounces-263331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB53F93D463
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 15:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A0F21F258AE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 13:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA14317C23B;
	Fri, 26 Jul 2024 13:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="H3am/10L"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B49117C20A
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 13:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722001260; cv=none; b=OeCt1SPmqFQeSK1Y3yD58g3pXVkhoI9y/zvZm4kg6xGDstk2uWtBLrf5J+jDD7wXU2xzJLZxUBRqsoEdiv9KZd9yadxI2F1wA5wR5mvJkY/p87T9EJoDRGTGCwfP1K+oI3hBwIMqVUriGnCAQ4hfWd7/ZLq/CA3DIx6hMup926o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722001260; c=relaxed/simple;
	bh=yCh3j7AzpbYaYw1lIg+cXANVOhzeBASAYzoBFFZRBMY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e2cnpIe6XTBNKkyidnZyB72jS4ZfpoDpHTcocVVkflDb4wNO+RpMv86gUIVFRpGvIdIxzVNV4orky8cn1CfkLNcdmoP7ahElXN4ju8/JoORqEobY4ZnCE0J4ZNTsPAVmXrpvsIwP1W8kQKld8uO4JnNYOV5gpN/XQuZaGkB56dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=H3am/10L; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1722001252;
	bh=yCh3j7AzpbYaYw1lIg+cXANVOhzeBASAYzoBFFZRBMY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=H3am/10LeRliHMcGqvZ9VX5j2w4kiu/rMdnEhq6Iwv4xjA1XNFJcIPu+U57IZrmeL
	 BmpI+4b4JjTxhorEmFdzyJ9c59bOtshrUJEb0iL7SgfkX85kZ9/auNV7BTixPpZixF
	 kV6BJwypz8Pbn6ZtnbFeORV6Ta7d4yEBNLHkgacs=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Fri, 26 Jul 2024 15:40:15 +0200
Subject: [PATCH v2 1/2] drm/amdgpu: convert bios_hardcoded_edid to drm_edid
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240726-amdgpu-edid-bios-v2-1-8a0326654253@weissschuh.net>
References: <20240726-amdgpu-edid-bios-v2-0-8a0326654253@weissschuh.net>
In-Reply-To: <20240726-amdgpu-edid-bios-v2-0-8a0326654253@weissschuh.net>
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Xinhui Pan <Xinhui.Pan@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722001252; l=6641;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=yCh3j7AzpbYaYw1lIg+cXANVOhzeBASAYzoBFFZRBMY=;
 b=RF6nfFT/E1KPCS4w1LS0C+2C2kK/ejep/KoSDc6u7EQvZVzcNiJQIbjgWJZDGtXDLVg6QEt5r
 Q++PuQX+/RrABVkhu0AUYYeYJS5av2igYxt7+NN39gLTZKqO4Sq2FNe
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Instead of manually passing around 'struct edid *' and its size,
use 'struct drm_edid', which encapsulates a validated combination of
both.

As the drm_edid_ can handle NULL gracefully, the explicit checks can be
dropped.

Also save a few characters by transforming '&array[0]' to the equivalent
'array' and using 'max_t(int, ...)' instead of manual casts.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c |  6 +-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h       |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/atombios_encoders.c | 17 ++++++-----------
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c         |  2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c         |  2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c          |  2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c          |  2 +-
 8 files changed, 14 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
index bd0fbdc5f55d..344e0a9ee08a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
@@ -249,11 +249,7 @@ amdgpu_connector_find_encoder(struct drm_connector *connector,
 static struct edid *
 amdgpu_connector_get_hardcoded_edid(struct amdgpu_device *adev)
 {
-	if (adev->mode_info.bios_hardcoded_edid) {
-		return kmemdup((unsigned char *)adev->mode_info.bios_hardcoded_edid,
-			       adev->mode_info.bios_hardcoded_edid_size, GFP_KERNEL);
-	}
-	return NULL;
+	return drm_edid_duplicate(drm_edid_raw(adev->mode_info.bios_hardcoded_edid));
 }
 
 static void amdgpu_connector_get_edid(struct drm_connector *connector)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
index d002b845d8ac..5e3faefc5510 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
@@ -51,6 +51,7 @@ struct amdgpu_encoder;
 struct amdgpu_router;
 struct amdgpu_hpd;
 struct edid;
+struct drm_edid;
 
 #define to_amdgpu_crtc(x) container_of(x, struct amdgpu_crtc, base)
 #define to_amdgpu_connector(x) container_of(x, struct amdgpu_connector, base)
@@ -326,8 +327,7 @@ struct amdgpu_mode_info {
 	/* FMT dithering */
 	struct drm_property *dither_property;
 	/* hardcoded DFP edid from BIOS */
-	struct edid *bios_hardcoded_edid;
-	int bios_hardcoded_edid_size;
+	const struct drm_edid *bios_hardcoded_edid;
 
 	/* firmware flags */
 	u32 firmware_flags;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
index 6415d0d039e1..e5f508d34ed8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -549,7 +549,7 @@ static int amdgpu_vkms_sw_fini(void *handle)
 
 	adev->mode_info.mode_config_initialized = false;
 
-	kfree(adev->mode_info.bios_hardcoded_edid);
+	drm_edid_free(adev->mode_info.bios_hardcoded_edid);
 	kfree(adev->amdgpu_vkms_output);
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
index ebf83fee43bb..8defca3705d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
+++ b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
@@ -2064,23 +2064,18 @@ amdgpu_atombios_encoder_get_lcd_info(struct amdgpu_encoder *encoder)
 				case LCD_FAKE_EDID_PATCH_RECORD_TYPE:
 					fake_edid_record = (ATOM_FAKE_EDID_PATCH_RECORD *)record;
 					if (fake_edid_record->ucFakeEDIDLength) {
-						struct edid *edid;
+						const struct drm_edid *edid;
 						int edid_size;
 
 						if (fake_edid_record->ucFakeEDIDLength == 128)
 							edid_size = fake_edid_record->ucFakeEDIDLength;
 						else
 							edid_size = fake_edid_record->ucFakeEDIDLength * 128;
-						edid = kmemdup(&fake_edid_record->ucFakeEDIDString[0],
-							       edid_size, GFP_KERNEL);
-						if (edid) {
-							if (drm_edid_is_valid(edid)) {
-								adev->mode_info.bios_hardcoded_edid = edid;
-								adev->mode_info.bios_hardcoded_edid_size = edid_size;
-							} else {
-								kfree(edid);
-							}
-						}
+						edid = drm_edid_alloc(fake_edid_record->ucFakeEDIDString, edid_size);
+						if (drm_edid_valid(edid))
+							adev->mode_info.bios_hardcoded_edid = edid;
+						else
+							drm_edid_free(edid);
 						record += struct_size(fake_edid_record,
 								      ucFakeEDIDString,
 								      edid_size);
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
index dddb5fe16f2c..742adbc460c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
@@ -2846,7 +2846,7 @@ static int dce_v10_0_sw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	kfree(adev->mode_info.bios_hardcoded_edid);
+	drm_edid_free(adev->mode_info.bios_hardcoded_edid);
 
 	drm_kms_helper_poll_fini(adev_to_drm(adev));
 
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
index 11780e4d7e9f..8d46ebadfa46 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
@@ -2973,7 +2973,7 @@ static int dce_v11_0_sw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	kfree(adev->mode_info.bios_hardcoded_edid);
+	drm_edid_free(adev->mode_info.bios_hardcoded_edid);
 
 	drm_kms_helper_poll_fini(adev_to_drm(adev));
 
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index 05c0df97f01d..f08dc6a3886f 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -2745,7 +2745,7 @@ static int dce_v6_0_sw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	kfree(adev->mode_info.bios_hardcoded_edid);
+	drm_edid_free(adev->mode_info.bios_hardcoded_edid);
 
 	drm_kms_helper_poll_fini(adev_to_drm(adev));
 
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
index dc73e301d937..a6a3adf2ae13 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
@@ -2766,7 +2766,7 @@ static int dce_v8_0_sw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	kfree(adev->mode_info.bios_hardcoded_edid);
+	drm_edid_free(adev->mode_info.bios_hardcoded_edid);
 
 	drm_kms_helper_poll_fini(adev_to_drm(adev));
 

-- 
2.45.2


