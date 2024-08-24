Return-Path: <linux-kernel+bounces-300154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD3895DFA5
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 20:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B710FB21865
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 18:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE2C7DA61;
	Sat, 24 Aug 2024 18:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="TB30hA5X"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDA8433CF;
	Sat, 24 Aug 2024 18:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724524479; cv=none; b=qj5olGBaTIjhpMzCFZTyUbQa+AvXMzIinmTDQ6hTWLS3EceGyBsnMXyFnQ3+0UIbn+dmS2SBenXTBEcTZiSR5EvdUNfOi91J8EUcw3Y53L0Wg5yyHXLSXNe7zQArfYpyhiA/By8XyKQaLunCDGFgK03OWl3QZwLNx0ocpxIBBFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724524479; c=relaxed/simple;
	bh=pXwPNuj1+2MaBbsgOKVjjIsLJ5HBVXKxLzYgXNTSWNY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pNnyYvZrxbNiG9sovKvr0tsQQxFtUi+/rNU3yFhY4mADmxeaJbDrIHsCeU1M8WwxXH0IZ+J68ZOgUolJI8qiuEzIny0k06i0o3z9Kl2SSdsV8wbqcdqBxLQLZCwgvX3/+Iv2deAtHp5TW9+RTabf+1WaFG9KV1Rka3NdVgrG1s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=TB30hA5X; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1724524474;
	bh=pXwPNuj1+2MaBbsgOKVjjIsLJ5HBVXKxLzYgXNTSWNY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TB30hA5XnEa7fyrihN7qLIn+P3NA0zkD1xPozEjokv3NczFvkhKQq0l2XRsojyQ9Y
	 8aAV106FaaH3e1hR6xC5fFVaM3RkpCpVakdlpj/KMg09Nu5ewBem4SLzNTSK6mlqwN
	 VuzHCR23sJJIjuqz22qtmBKwy/VPwa1fJX/G3WVw=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 24 Aug 2024 20:33:55 +0200
Subject: [PATCH v6 2/4] drm/amd/display: Add support for minimum backlight
 quirk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240824-amdgpu-min-backlight-quirk-v6-2-1ed776a17fb3@weissschuh.net>
References: <20240824-amdgpu-min-backlight-quirk-v6-0-1ed776a17fb3@weissschuh.net>
In-Reply-To: <20240824-amdgpu-min-backlight-quirk-v6-0-1ed776a17fb3@weissschuh.net>
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 Matt Hartley <matt.hartley@gmail.com>, Kieran Levin <ktl@framework.net>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Jani Nikula <jani.nikula@linux.intel.com>, Xinhui Pan <Xinhui.Pan@amd.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Dustin Howett <dustin@howett.net>, 
 linux-doc@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724524474; l=2773;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=pXwPNuj1+2MaBbsgOKVjjIsLJ5HBVXKxLzYgXNTSWNY=;
 b=wZPXulQQnUKt4eZU7D/anz1D3UzcnVTFMef69VP4gLOdo12ou4ie823nDuY8HBS7Tlox1yc6c
 wUKJPUFEpRFCXW+39oSRRtA6Mb5muAIVtwUuLEoM+tj+O97iDinyO9N
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Not all platforms provide the full range of PWM backlight capabilities
supported by the hardware through ATIF.
Use the generic drm panel minimum backlight quirk infrastructure to
override the capabilities where necessary.

Testing the backlight quirk together with the "panel_power_savings"
sysfs file has not shown any negative impact.
One quirk seems to be that 0% at panel_power_savings=0 seems to be
slightly darker than at panel_power_savings=4.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Tested-by: Dustin L. Howett <dustin@howett.net>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Kconfig                |  1 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/amdgpu/Kconfig
index 0051fb1b437f..655c10aef2e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/Kconfig
+++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
@@ -23,6 +23,7 @@ config DRM_AMDGPU
 	select DRM_BUDDY
 	select DRM_SUBALLOC_HELPER
 	select DRM_EXEC
+	select DRM_PANEL_BACKLIGHT_QUIRKS
 	# amdgpu depends on ACPI_VIDEO when ACPI is enabled, for select to work
 	# ACPI_VIDEO's dependencies must also be selected.
 	select INPUT if ACPI
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 983a977632ff..056960ea335c 100644
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
@@ -3333,6 +3334,8 @@ static void update_connector_ext_caps(struct amdgpu_dm_connector *aconnector)
 	struct drm_connector *conn_base;
 	struct amdgpu_device *adev;
 	struct drm_luminance_range_info *luminance_range;
+	const struct drm_edid *drm_edid;
+	int min_input_signal_override;
 
 	if (aconnector->bl_idx == -1 ||
 	    aconnector->dc_link->connector_signal != SIGNAL_TYPE_EDP)
@@ -3367,6 +3370,13 @@ static void update_connector_ext_caps(struct amdgpu_dm_connector *aconnector)
 		caps->aux_min_input_signal = 0;
 		caps->aux_max_input_signal = 512;
 	}
+
+	drm_edid = drm_edid_alloc(aconnector->edid,
+				  EDID_LENGTH * (aconnector->edid->extensions + 1));
+	min_input_signal_override = drm_get_panel_min_brightness_quirk(drm_edid);
+	drm_edid_free(drm_edid);
+	if (min_input_signal_override >= 0)
+		caps->min_input_signal = min_input_signal_override;
 }
 
 void amdgpu_dm_update_connector_after_detect(

-- 
2.46.0


