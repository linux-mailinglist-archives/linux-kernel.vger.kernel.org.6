Return-Path: <linux-kernel+bounces-226014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6786191391A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 10:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1CE1B21186
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 08:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F40C745E2;
	Sun, 23 Jun 2024 08:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="gmudr6v2"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB3B5A4D5
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 08:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719133163; cv=none; b=cMVgFbwWJCAWkxr91R9h3ZRRJFy7CEbAQ4xX6zzAAPPphmZhzpXlldxc+5p4tlyLLAOdNGJQBfVAuWna2qy3SIYx6tWd2TwqWWgyPbG6P4ehKEQwSMJ106u75KrXsWjRjUU3ZfyBMm2rolSXOqF640fdstuqGOjkKVF8Nglxy/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719133163; c=relaxed/simple;
	bh=U89xBvF/tNccWlyocvy/F0+d2O1P/5jRg3TgAdYjLq0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NRC6MXFXUEQVIUNDrALCy3OU46smq6tcnSr0N8FjY8AgI5i+OA/e1G921U4MW4Oahob1CVRlrvuz0/Nfk8iLGiilh7wWjsdTLDC+ELqC3dTcBTSiWZoTrf/5Pyp+pEYPd6L1tTzwJW7vptrav5Ct6fHx66LS0TjkhsW+ct7vpcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=gmudr6v2; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1719132689;
	bh=U89xBvF/tNccWlyocvy/F0+d2O1P/5jRg3TgAdYjLq0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gmudr6v2hsgdWWkFdCfOtDLeVaNc09pZB6JmCf2Myzz2r9Bhlst/R7OeG/c8ZIw+L
	 wnqFLw82rbsDtqUvuN5YC2RsFcnsmEpa317SXaI5WHxK8H2CQzxJl3lTqYIHVgWiDz
	 /QdMfWp5Sfg6AB+VtbWBoHjgu5i+wxW0Lrw17giw=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 23 Jun 2024 10:51:27 +0200
Subject: [PATCH v2 1/3] drm: Add panel backlight quirks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240623-amdgpu-min-backlight-quirk-v2-1-cecf7f49da9b@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719132688; l=4963;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=U89xBvF/tNccWlyocvy/F0+d2O1P/5jRg3TgAdYjLq0=;
 b=j7PdKVU7XA1ADyOGT5eCUR1fny6sQZ0P4ss8CBhBMGm/8qslhxBEOU5lMnzocNkCS3whjtSvz
 S8mOs42IvHqCAPzKOg63gsrr1V+WBvyH9XdWm379XlQDGOHIz1ifMGv
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Panels using a PWM-controlled backlight source without an do not have a
standard way to communicate their valid PWM ranges.
On x86 the ranges are read from ACPI through driver-specific tables.
The built-in ranges are not necessarily correct, or may grow stale if an
older device can be retrofitted with newer panels.

Add a quirk infrastructure with which the valid backlight ranges can be
maintained as part of the kernel.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 Documentation/gpu/drm-kms-helpers.rst        |  3 ++
 drivers/gpu/drm/Kconfig                      |  4 ++
 drivers/gpu/drm/Makefile                     |  1 +
 drivers/gpu/drm/drm_panel_backlight_quirks.c | 67 ++++++++++++++++++++++++++++
 include/drm/drm_utils.h                      | 11 +++++
 5 files changed, 86 insertions(+)

diff --git a/Documentation/gpu/drm-kms-helpers.rst b/Documentation/gpu/drm-kms-helpers.rst
index 59cfe8a7a8ba..1998a2675210 100644
--- a/Documentation/gpu/drm-kms-helpers.rst
+++ b/Documentation/gpu/drm-kms-helpers.rst
@@ -224,6 +224,9 @@ Panel Helper Reference
 .. kernel-doc:: drivers/gpu/drm/drm_panel_orientation_quirks.c
    :export:
 
+.. kernel-doc:: drivers/gpu/drm/drm_panel_backlight_quirks.c
+   :export:
+
 Panel Self Refresh Helper Reference
 ===================================
 
diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 959b19a04101..50ccb43315bf 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -443,6 +443,10 @@ config DRM_EXPORT_FOR_TESTS
 config DRM_PANEL_ORIENTATION_QUIRKS
 	tristate
 
+# Separate option as not all DRM drivers use it
+config DRM_PANEL_BACKLIGHT_QUIRKS
+	tristate
+
 config DRM_LIB_RANDOM
 	bool
 	default n
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index f9ca4f8fa6c5..6669913b907e 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -92,6 +92,7 @@ drm-$(CONFIG_DRM_PANIC) += drm_panic.o
 obj-$(CONFIG_DRM)	+= drm.o
 
 obj-$(CONFIG_DRM_PANEL_ORIENTATION_QUIRKS) += drm_panel_orientation_quirks.o
+obj-$(CONFIG_DRM_PANEL_BACKLIGHT_QUIRKS) += drm_panel_backlight_quirks.o
 
 #
 # Memory-management helpers
diff --git a/drivers/gpu/drm/drm_panel_backlight_quirks.c b/drivers/gpu/drm/drm_panel_backlight_quirks.c
new file mode 100644
index 000000000000..a89b5fd1940e
--- /dev/null
+++ b/drivers/gpu/drm/drm_panel_backlight_quirks.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/array_size.h>
+#include <linux/dmi.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <drm/drm_connector.h>
+#include <drm/drm_utils.h>
+
+struct drm_panel_backlight_entry {
+	struct {
+		enum dmi_field field;
+		const char * const value;
+	} dmi_match;
+	struct drm_edid_ident ident;
+	struct drm_panel_backlight_quirk quirk;
+};
+
+static const struct drm_panel_backlight_entry drm_panel_backlight_entries[] = {
+};
+
+static bool drm_panel_backlight_entry_matches(const struct drm_panel_backlight_entry *entry,
+					      const struct drm_edid *edid)
+{
+	if (!dmi_match(entry->dmi_match.field, entry->dmi_match.value))
+		return false;
+
+	if (!drm_edid_match(edid, &entry->ident))
+		return false;
+
+	return true;
+}
+
+/**
+ * drm_get_panel_panel_quirk - Check for panel backlight quirks
+ * @edid: EDID of the panel to check
+ *
+ * This function checks for platform specific (e.g. DMI based) quirks
+ * providing info on backlight control for systems where this cannot be
+ * probed from the hard-/firm-ware.
+ *
+ * Returns:
+ * A struct drm_panel_backlight_quirk if a quirk is found or NULL otherwise.
+ */
+const struct drm_panel_backlight_quirk *drm_get_panel_backlight_quirk(const struct drm_edid *edid)
+{
+	const struct drm_panel_backlight_entry *entry;
+	size_t i;
+
+	if (!IS_ENABLED(CONFIG_DMI))
+		return NULL;
+
+	if (!edid)
+		return NULL;
+
+	for (i = 0; i < ARRAY_SIZE(drm_panel_backlight_entries); i++) {
+		entry = &drm_panel_backlight_entries[i];
+
+		if (drm_panel_backlight_entry_matches(entry, edid))
+			return &entry->quirk;
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL(drm_get_panel_backlight_quirk);
+
+MODULE_LICENSE("GPL");
diff --git a/include/drm/drm_utils.h b/include/drm/drm_utils.h
index 70775748d243..37cc6de1a01a 100644
--- a/include/drm/drm_utils.h
+++ b/include/drm/drm_utils.h
@@ -11,9 +11,20 @@
 #define __DRM_UTILS_H__
 
 #include <linux/types.h>
+#include <drm/drm_edid.h>
+
+struct drm_panel_backlight_quirk {
+	struct {
+		bool pwm_min_brightness:1;
+	} overrides;
+
+	u8 pwm_min_brightness; /* min_brightness/255 of max */
+};
 
 int drm_get_panel_orientation_quirk(int width, int height);
 
+const struct drm_panel_backlight_quirk *drm_get_panel_backlight_quirk(const struct drm_edid *edid);
+
 signed long drm_timeout_abs_to_jiffies(int64_t timeout_nsec);
 
 #endif

-- 
2.45.2


