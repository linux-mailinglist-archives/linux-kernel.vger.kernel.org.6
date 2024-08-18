Return-Path: <linux-kernel+bounces-290963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C03B955BAC
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 08:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB1731F21506
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 06:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12FA16419;
	Sun, 18 Aug 2024 06:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="dmYadLjN"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6F0EEA5;
	Sun, 18 Aug 2024 06:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723964288; cv=none; b=orQUiFgkXSTXUJ3U11sY6eAgClEJ4kYL/q3uZV3skZl0TgJSeMl3YCaVb4EEcvt36kgD2LfqQjN6tq4C/9zyaAqC/ILqLVsV6EZFNI26rsm2QcW5ozxWOb7UWkqHwJR/94uvLU+QkWkqsQIRA9jaihQlTemwJukaXRWpxlS7Mpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723964288; c=relaxed/simple;
	bh=jNYtKHkIe5Sy9oTVmQTB9CI0MXFQZubjFEgpLZQtHnM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A3rFi8XFyKfoHAhpZGuWh/tgz4if5K2pxYjNxJ7iPEBfNL5jgNWwfaufgwHcVoQ/2gy2YRZx73E05TXMD4NmhQWRcgtKD8GPAIowLRxTZRzj8B5Z6bW99ZYFmfVuAOXuHAZnYrLfM3CApWSyMzs3iOLn87/mBVWPOkabfrGrkUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=dmYadLjN; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1723964282;
	bh=jNYtKHkIe5Sy9oTVmQTB9CI0MXFQZubjFEgpLZQtHnM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dmYadLjNnEacD4Bii+JeUkfTaV/h0VsGdvsYDFm0L/YuntImI2ohRBcAvgG9oNQdU
	 uuaix1k1C3qUPvyzeJ76zFtYO8x4NyA7ZUdVzgFA8MVWuOrhG4Wbk/TyeUetzU2Vfr
	 8Do1ieZjIMPZEQ8t/oJlZlVg95JNGWrVEyq1HeIw=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 18 Aug 2024 08:56:38 +0200
Subject: [PATCH v5 2/4] drm/amd/display: Add support for minimum backlight
 quirk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240818-amdgpu-min-backlight-quirk-v5-2-b6c0ead0c73d@weissschuh.net>
References: <20240818-amdgpu-min-backlight-quirk-v5-0-b6c0ead0c73d@weissschuh.net>
In-Reply-To: <20240818-amdgpu-min-backlight-quirk-v5-0-b6c0ead0c73d@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723964281; l=2442;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=jNYtKHkIe5Sy9oTVmQTB9CI0MXFQZubjFEgpLZQtHnM=;
 b=gM0wQC+BbIXSpZfLdxXPzzKqX+KQf2bwTWaY4TlXIDw3ABHC5MKSZbh0PhWavoqJu4VIuAEip
 nDCXivGrmcVDksjR8XX+RrrVIN97OeGwmnOtdF27g4qkbT/cGvHRJA6
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Not all platforms provide correct PWM backlight capabilities through ATIF.
Use the generic drm panel minimum backlight quirk infrastructure to
override the capabilities where necessary.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Tested-by: Dustin L. Howett <dustin@howett.net>
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


