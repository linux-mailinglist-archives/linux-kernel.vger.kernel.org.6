Return-Path: <linux-kernel+bounces-226017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9C491391C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 10:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD3ED1F21C4B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 08:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B27A7F47B;
	Sun, 23 Jun 2024 08:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="T49NgJZI"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BE65A10B
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 08:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719133164; cv=none; b=iv9C0mogQmaNXbqESn4kljgf3qsxgkqe+W0qHhPJWhtWaPKijNoucnD974eXIklrMd80Z1a9BEGnkvmEsF7ERljsebzSlzhjTpknvl/TmKj5/xbFTS+iGAkb0JBitEHn48bA6TdS+JCYNYSZpKmq9fNiKDQljRc3N7XJUnebqAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719133164; c=relaxed/simple;
	bh=rczzmpjjlHlCtAKyfdbQlMnDUcEam5QWSyl/gkZmeUI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SLPeJhixoAg+Q76rQw3K2532oxcixbHnOmwQ6VqsD0Hr+9Dsr6SJnhhRKlmj4bjJpjdzIxd7MsdldwGrmHDXdwxV7he/uJU3N4RJWIQTU7Gm/66JWXNKp8DbMzvsiVqpxjYysigE7eO5n0l0R1bDeqkDBaTgGW836WAi6FkGdGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=T49NgJZI; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1719132689;
	bh=rczzmpjjlHlCtAKyfdbQlMnDUcEam5QWSyl/gkZmeUI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=T49NgJZIev0c63fiplfhzGkAuWQ/paHKXJ9+oa1374Ic3GcSGWJf5myt32dEIH1qi
	 3I/tomzIA9tRVYXA27wN9cxEZb+ye1RpFrC6JixWbFOOf0XIEaIE6+rSkbQ/x9dB2f
	 BrUeKV4j2V9HgBpogKmho4NFjOqmPiJ9jCdr2/vc=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 23 Jun 2024 10:51:29 +0200
Subject: [PATCH v2 3/3] drm/amd/display: Add support backlight quirks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240623-amdgpu-min-backlight-quirk-v2-3-cecf7f49da9b@weissschuh.net>
References: <20240623-amdgpu-min-backlight-quirk-v2-0-cecf7f49da9b@weissschuh.net>
In-Reply-To: <20240623-amdgpu-min-backlight-quirk-v2-0-cecf7f49da9b@weissschuh.net>
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 Matt Hartley <matt.hartley@gmail.com>, Kieran Levin <ktl@framework.net>, 
 Hans de Goede <hdegoede@redhat.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Dustin Howett <dustin@howett.net>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719132688; l=2788;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=rczzmpjjlHlCtAKyfdbQlMnDUcEam5QWSyl/gkZmeUI=;
 b=91+X03/aUODL2GDH3ZqzK48/y08D6dI+XwyYt1sZeGqua4CMOayPkJrOzc+4B24uRR0caZ7vY
 ikjqi1dxeVRA9O1UNQHhVY4kjP/r2qXpoz/32Jsw8BJnXBbylFYY6tY
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Not all platforms provide correct PWM backlight capabilities through ATIF.
Use the generic drm backlight quirk infrastructure to override the
capabilities where necessary.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/gpu/drm/amd/amdgpu/Kconfig                |  1 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 28 +++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/amdgpu/Kconfig
index 692fa7cf8fd2..4fe0e8e74bb9 100644
--- a/drivers/gpu/drm/amd/amdgpu/Kconfig
+++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
@@ -25,6 +25,7 @@ config DRM_AMDGPU
 	select DRM_BUDDY
 	select DRM_SUBALLOC_HELPER
 	select DRM_EXEC
+	select DRM_PANEL_BACKLIGHT_QUIRKS
 	# amdgpu depends on ACPI_VIDEO when ACPI is enabled, for select to work
 	# ACPI_VIDEO's dependencies must also be selected.
 	select INPUT if ACPI
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 60404385d4d0..2d8a6d875170 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -93,6 +93,7 @@
 #include <drm/drm_fourcc.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_eld.h>
+#include <drm/drm_utils.h>
 #include <drm/drm_vblank.h>
 #include <drm/drm_audio_component.h>
 #include <drm/drm_gem_atomic_helper.h>
@@ -3329,6 +3330,31 @@ static struct drm_mode_config_helper_funcs amdgpu_dm_mode_config_helperfuncs = {
 	.atomic_commit_setup = drm_dp_mst_atomic_setup_commit,
 };
 
+static void amdgpu_dm_apply_backlight_quirks(struct amdgpu_dm_connector *aconnector,
+					     struct amdgpu_dm_backlight_caps *caps)
+{
+	const struct drm_panel_backlight_quirk *quirk;
+	const struct drm_edid *edid;
+
+	edid = drm_edid_alloc(aconnector->edid, EDID_LENGTH * (aconnector->edid->extensions + 1));
+	if (!edid)
+		return;
+
+	quirk = drm_get_panel_backlight_quirk(edid);
+
+	drm_edid_free(edid);
+
+	if (!quirk)
+		return;
+
+	if (quirk->overrides.pwm_min_brightness &&
+	    caps->min_input_signal != quirk->pwm_min_brightness) {
+		drm_info(aconnector->base.dev,
+			 "Quirk: backlight min_input_signal=%d\n", quirk->pwm_min_brightness);
+		caps->min_input_signal = quirk->pwm_min_brightness;
+	}
+}
+
 static void update_connector_ext_caps(struct amdgpu_dm_connector *aconnector)
 {
 	struct amdgpu_dm_backlight_caps *caps;
@@ -3369,6 +3395,8 @@ static void update_connector_ext_caps(struct amdgpu_dm_connector *aconnector)
 		caps->aux_min_input_signal = 0;
 		caps->aux_max_input_signal = 512;
 	}
+
+	amdgpu_dm_apply_backlight_quirks(aconnector, caps);
 }
 
 void amdgpu_dm_update_connector_after_detect(

-- 
2.45.2


