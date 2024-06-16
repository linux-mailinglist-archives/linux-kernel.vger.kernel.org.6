Return-Path: <linux-kernel+bounces-216212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 168C7909CBC
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 11:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3B681C20A6C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 09:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF84181BBC;
	Sun, 16 Jun 2024 09:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="adVOb+r7"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE7C16D9AA
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 09:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718529178; cv=none; b=V2VHIm9ZrX8QINwklCFYUkbCunxbAu6mrcchjFxALGzfgpAbCUVQW87Qb8C/tnHxt4MdQTQ8d0L3L9bOmPF91GJ8O66zhT8Ypfb2HOdqdb4ZWC89a7qAlQ4fDdOBdxaodGr59Mqeh+dHbtWEGXvUSzE5lZAMb/JuxSRmPYAISFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718529178; c=relaxed/simple;
	bh=soXT6ejv1Jmdiecl/JaLHs9qbKzLrDGNxWPNnQa5keg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=k99zyv1myl1PEwsD9IQJ9mZN+x38/JOZLxeCDmflD5Pejlz3PQm5MmnwOg2cxx/SOY44JOzxdFcMmD+H/nmnjCemtity/vzG6UPtCKZ2eiJq8ZcbtP4dfDC8bKd5zf0wkUT7z61/dyB9lifGpRhOp8MD3/1GUCqWsaXJTiqsj4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=adVOb+r7; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1718529169;
	bh=soXT6ejv1Jmdiecl/JaLHs9qbKzLrDGNxWPNnQa5keg=;
	h=From:Date:Subject:To:Cc:From;
	b=adVOb+r7x6NPCff5svEjqTEheRJqsecwvwA1P+hQcGKHMXwzlK8cs6s+tr+/Zfv+p
	 yDpBX/2InSLlHIdcpKaLp5KWd+JgqjNb8p3VUf/guEGS3UKAxRy2Y9jDsvVXlYlbKA
	 VS3fQz915nGIjDUrRgP9jijeBskv3aHF+uTVkMHc=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 16 Jun 2024 11:12:03 +0200
Subject: [PATCH] drm/amdgpu: convert bios_hardcoded_edid to drm_edid
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240616-amdgpu-edid-bios-v1-1-2874f212b365@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAGKsbmYC/x3MMQqAMAxA0atIZgNNKx28ijhEGzWDVVoUQXp3i
 +Mb/n8hS1LJ0DcvJLk16xErqG1g3jiughqqwRrbGU8eeQ/reaEEDTjpkZEdMZOfjLMENTuTLPr
 8y2Es5QMoxhPDYgAAAA==
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718529166; l=7172;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=soXT6ejv1Jmdiecl/JaLHs9qbKzLrDGNxWPNnQa5keg=;
 b=nVYgkUeKEtbsZrsJiINgk727iI4cpBu7q/mFHtx8PvPoOMQyKR9ogrLzw9sk+E7/kAjYhWFzp
 1pY1jyMyVolDBSDTK5zm1ya9AzehJtuyZLwdt0cuFIVdFyGoK+NY1ek
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
While this patch introduces a new user for drm_edid_raw(),
if amdgpu proper gets migrated to 'struct drm_edid', that usage will go
away.

This is only compile-tested.

I have some more patches for the rest of amdgpu,
to move to 'struct drm_edid'.
This patch is a test-balloon for the general idea.

The same can also be done for drm/radeon.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c |  6 +-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h       |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/atombios_encoders.c | 21 +++++++--------------
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c         |  2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c         |  2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c          |  2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c          |  2 +-
 8 files changed, 15 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
index 9caba10315a8..f1b11b27cce0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
@@ -265,11 +265,7 @@ struct edid *amdgpu_connector_edid(struct drm_connector *connector)
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
index 1fe21a70ddd0..928ac3f1e2ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
@@ -51,6 +51,7 @@ struct amdgpu_encoder;
 struct amdgpu_router;
 struct amdgpu_hpd;
 struct edid;
+struct drm_edid;
 
 #define to_amdgpu_crtc(x) container_of(x, struct amdgpu_crtc, base)
 #define to_amdgpu_connector(x) container_of(x, struct amdgpu_connector, base)
@@ -325,8 +326,7 @@ struct amdgpu_mode_info {
 	/* FMT dithering */
 	struct drm_property *dither_property;
 	/* hardcoded DFP edid from BIOS */
-	struct edid *bios_hardcoded_edid;
-	int bios_hardcoded_edid_size;
+	const struct drm_edid *bios_hardcoded_edid;
 
 	/* firmware flags */
 	u32 firmware_flags;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
index e30eecd02ae1..543275db8302 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -539,7 +539,7 @@ static int amdgpu_vkms_sw_fini(void *handle)
 
 	adev->mode_info.mode_config_initialized = false;
 
-	kfree(adev->mode_info.bios_hardcoded_edid);
+	drm_edid_free(adev->mode_info.bios_hardcoded_edid);
 	kfree(adev->amdgpu_vkms_output);
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
index 25feab188dfe..90383094ed1e 100644
--- a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
+++ b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
@@ -2064,20 +2064,13 @@ amdgpu_atombios_encoder_get_lcd_info(struct amdgpu_encoder *encoder)
 				case LCD_FAKE_EDID_PATCH_RECORD_TYPE:
 					fake_edid_record = (ATOM_FAKE_EDID_PATCH_RECORD *)record;
 					if (fake_edid_record->ucFakeEDIDLength) {
-						struct edid *edid;
-						int edid_size =
-							max((int)EDID_LENGTH, (int)fake_edid_record->ucFakeEDIDLength);
-						edid = kmalloc(edid_size, GFP_KERNEL);
-						if (edid) {
-							memcpy((u8 *)edid, (u8 *)&fake_edid_record->ucFakeEDIDString[0],
-							       fake_edid_record->ucFakeEDIDLength);
-
-							if (drm_edid_is_valid(edid)) {
-								adev->mode_info.bios_hardcoded_edid = edid;
-								adev->mode_info.bios_hardcoded_edid_size = edid_size;
-							} else
-								kfree(edid);
-						}
+						const struct drm_edid *edid;
+						edid = drm_edid_alloc(fake_edid_record->ucFakeEDIDString,
+								      max_t(int, EDID_LENGTH, fake_edid_record->ucFakeEDIDLength));
+						if (drm_edid_valid(edid))
+							adev->mode_info.bios_hardcoded_edid = edid;
+						else
+							drm_edid_free(edid);
 					}
 					record += fake_edid_record->ucFakeEDIDLength ?
 						  struct_size(fake_edid_record,
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
index b44fce44c066..11d648e688ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
@@ -2846,7 +2846,7 @@ static int dce_v10_0_sw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	kfree(adev->mode_info.bios_hardcoded_edid);
+	drm_edid_free(adev->mode_info.bios_hardcoded_edid);
 
 	drm_kms_helper_poll_fini(adev_to_drm(adev));
 
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
index 80b2e7f79acf..01536f523032 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
@@ -2973,7 +2973,7 @@ static int dce_v11_0_sw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	kfree(adev->mode_info.bios_hardcoded_edid);
+	drm_edid_free(adev->mode_info.bios_hardcoded_edid);
 
 	drm_kms_helper_poll_fini(adev_to_drm(adev));
 
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index db20012600f5..0e5b568a96fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -2745,7 +2745,7 @@ static int dce_v6_0_sw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	kfree(adev->mode_info.bios_hardcoded_edid);
+	drm_edid_free(adev->mode_info.bios_hardcoded_edid);
 
 	drm_kms_helper_poll_fini(adev_to_drm(adev));
 
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
index 5b56100ec902..895f050a3e62 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
@@ -2766,7 +2766,7 @@ static int dce_v8_0_sw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	kfree(adev->mode_info.bios_hardcoded_edid);
+	drm_edid_free(adev->mode_info.bios_hardcoded_edid);
 
 	drm_kms_helper_poll_fini(adev_to_drm(adev));
 

---
base-commit: a3e18a540541325a8c8848171f71e0d45ad30b2c
change-id: 20240616-amdgpu-edid-bios-a31aa16b0321

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


