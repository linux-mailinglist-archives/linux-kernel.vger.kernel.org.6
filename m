Return-Path: <linux-kernel+bounces-556592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC35A5CC0E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36077189EB16
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 17:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67982620DD;
	Tue, 11 Mar 2025 17:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="ZMgeXicw"
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83B4255E20;
	Tue, 11 Mar 2025 17:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741713852; cv=none; b=GZfjZewF0xyW9VrdDlkI7LFQOMsN1xep39Jo7zjjtpFIIhu4a3gZS4VL3r1HBIHtDpqwQoUC8Qwe2MLauqYl6XHqNLjnZ/mp1HtUiEZOcH+pfm9QyyBxgrQsk5DGDH05bvqHzSJPTy0PT9IebZLYEjJkB3IZi12Gdg+KyeD0/fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741713852; c=relaxed/simple;
	bh=hlT7HF0xUH4Un28BekTVrlgK/meTVY4JBVvQES5tx2E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XHftDmGvV1radME8b+VAvnEtFIUiVaNSWRWafIqo0TDtiyW/voCgnAXJjTcWp7prpwgBXQDUNSV6H3aidl+0haY3Y2a5C+HMRImRhkax/dlt7hTwErEXkVGV/KqRtbBEJN8FE7rUqySlqKuYGm55Gsd4ll/FOuHOOq/Kat6axkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=ZMgeXicw; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from wse-pc.fritz.box (pd9e59f4f.dip0.t-ipconnect.de [217.229.159.79])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPA id 350A52FC0187;
	Tue, 11 Mar 2025 18:24:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1741713845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YElZBhC56Gcos1BYu0pWkQ/xWhJtQOSgzRHBccxSMGE=;
	b=ZMgeXicwO7XIJUpgXvLbvxXCbZJUz2rKL2gTMNhcYPtJlNPHvutUZweLy9mN6ofLGg+IgV
	lHOPEjoOcZHFux0ZmgQ71MAn02B542AvDHgpFYPkO5N/QjS21i7mhK+czAn4APy/f+MHqh
	uTDOiatxs536bBKe7ovvFozZEN0P6AQ=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
From: Werner Sembach <wse@tuxedocomputers.com>
To: hdegoede@redhat.com,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Werner Sembach <wse@tuxedocomputers.com>
Cc: linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH v3] Input: atkbd - Fix TUXEDO NB02 notebook keyboards touchpad toggle key
Date: Tue, 11 Mar 2025 18:23:50 +0100
Message-ID: <20250311172402.1095506-1-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TUXEDO NB02 notebook keyboards touchpad toggle key sends the PS/2
scancode sequence:
0xe0, 0x5b, // Super down
0x1d,       // Control down
0x76,       // KEY_ZENKAKUHANKAKU down
0xf6,       // KEY_ZENKAKUHANKAKU up
0x9d,       // Control up
0xe0, 0xdb  // Super up

This driver listens to the Control + Super + Hangaku/Zenkaku key sequence
to suppresses the Hangaku/Zenkaku keypress and sends a F21 keypress
afterwards to conform with established userspace defaults. Note that the
Hangaku/Zenkaku scancode used here is usually unused, with real
Hangaku/Zenkaku keys using the tilde scancode.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
---
 MAINTAINERS                                 |   6 ++
 drivers/platform/x86/Kconfig                |   2 +
 drivers/platform/x86/Makefile               |   3 +
 drivers/platform/x86/tuxedo/Kbuild          |   6 ++
 drivers/platform/x86/tuxedo/Kconfig         |   6 ++
 drivers/platform/x86/tuxedo/nb02/Kbuild     |   7 ++
 drivers/platform/x86/tuxedo/nb02/Kconfig    |  15 +++
 drivers/platform/x86/tuxedo/nb02/platform.c | 107 ++++++++++++++++++++
 8 files changed, 152 insertions(+)
 create mode 100644 drivers/platform/x86/tuxedo/Kbuild
 create mode 100644 drivers/platform/x86/tuxedo/Kconfig
 create mode 100644 drivers/platform/x86/tuxedo/nb02/Kbuild
 create mode 100644 drivers/platform/x86/tuxedo/nb02/Kconfig
 create mode 100644 drivers/platform/x86/tuxedo/nb02/platform.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 8e0736dc2ee0e..7139c32e96dc7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24190,6 +24190,12 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git turbostat
 F:	tools/power/x86/turbostat/
 F:	tools/testing/selftests/turbostat/
 
+TUXEDO DRIVERS
+M:	Werner Sembach <wse@tuxedocomputers.com>
+L:	platform-driver-x86@vger.kernel.org
+S:	Supported
+F:	drivers/platform/x86/tuxedo/
+
 TW5864 VIDEO4LINUX DRIVER
 M:	Bluecherry Maintainers <maintainers@bluecherrydvr.com>
 M:	Andrey Utkin <andrey.utkin@corp.bluecherry.net>
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 0258dd879d64b..9b78a1255c08e 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1199,3 +1199,5 @@ config P2SB
 	  The main purpose of this library is to unhide P2SB device in case
 	  firmware kept it hidden on some platforms in order to access devices
 	  behind it.
+
+source "drivers/platform/x86/tuxedo/Kconfig"
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index e1b1429470674..1562dcd7ad9a5 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -153,3 +153,6 @@ obj-$(CONFIG_WINMATE_FM07_KEYS)		+= winmate-fm07-keys.o
 
 # SEL
 obj-$(CONFIG_SEL3350_PLATFORM)		+= sel3350-platform.o
+
+# TUXEDO
+obj-y					+= tuxedo/
diff --git a/drivers/platform/x86/tuxedo/Kbuild b/drivers/platform/x86/tuxedo/Kbuild
new file mode 100644
index 0000000000000..e9c4243d438ba
--- /dev/null
+++ b/drivers/platform/x86/tuxedo/Kbuild
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# TUXEDO X86 Platform Specific Drivers
+#
+
+obj-y	+= nb02/
diff --git a/drivers/platform/x86/tuxedo/Kconfig b/drivers/platform/x86/tuxedo/Kconfig
new file mode 100644
index 0000000000000..e463f92135780
--- /dev/null
+++ b/drivers/platform/x86/tuxedo/Kconfig
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# TUXEDO X86 Platform Specific Drivers
+#
+
+source "drivers/platform/x86/tuxedo/nb02/Kconfig"
diff --git a/drivers/platform/x86/tuxedo/nb02/Kbuild b/drivers/platform/x86/tuxedo/nb02/Kbuild
new file mode 100644
index 0000000000000..8624a012cd683
--- /dev/null
+++ b/drivers/platform/x86/tuxedo/nb02/Kbuild
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# TUXEDO X86 Platform Specific Drivers
+#
+
+tuxedo_nb02_platform-y			:= platform.o
+obj-$(CONFIG_TUXEDO_NB02_PLATFORM)	+= tuxedo_nb02_platform.o
diff --git a/drivers/platform/x86/tuxedo/nb02/Kconfig b/drivers/platform/x86/tuxedo/nb02/Kconfig
new file mode 100644
index 0000000000000..bed56276b9b36
--- /dev/null
+++ b/drivers/platform/x86/tuxedo/nb02/Kconfig
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# TUXEDO X86 Platform Specific Drivers
+#
+
+menuconfig TUXEDO_NB02_PLATFORM
+	tristate "TUXEDO NB02 Platform Driver"
+	help
+	  This driver implements miscellaneous things found on TUXEDO Notebooks
+	  with board vendor NB02. For the time being this is only remapping the
+	  touchpad toggle key to something supported by most Linux distros
+	  out-of-the-box and suppressing an unsupported scancode from the
+	  FN-key.
+
+	  When compiled as a module it will be called tuxedo_nb02_platform.
diff --git a/drivers/platform/x86/tuxedo/nb02/platform.c b/drivers/platform/x86/tuxedo/nb02/platform.c
new file mode 100644
index 0000000000000..da67a91a4a129
--- /dev/null
+++ b/drivers/platform/x86/tuxedo/nb02/platform.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2025 Werner Sembach wse@tuxedocomputers.com
+ */
+
+#include <linux/cleanup.h>
+#include <linux/container_of.h>
+#include <linux/dmi.h>
+#include <linux/i8042.h>
+#include <linux/input.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/serio.h>
+
+struct input_dev *idev;
+
+static void tux_nb02_f21(struct work_struct *work __always_unused)
+{
+	input_report_key(idev, KEY_F21, 1);
+	input_report_key(idev, KEY_F21, 0);
+	input_sync(idev);
+}
+DECLARE_WORK(tux_nb02_f21_work, tux_nb02_f21);
+
+static const u8 tux_nb02_touchp_toggle_seq[] = {
+	0xe0, 0x5b, // Super down
+	0x1d,       // Control down
+	0x76,       // KEY_ZENKAKUHANKAKU down
+	0xf6,       // KEY_ZENKAKUHANKAKU up
+	0x9d,       // Control up
+	0xe0, 0xdb  // Super up
+};
+
+static bool tux_nb02_i8042_filter(unsigned char data,
+				  unsigned char str,
+				  struct serio *port __always_unused,
+				  void *context __always_unused)
+{
+	static u8 seq_pos;
+
+	if (unlikely(str & I8042_STR_AUXDATA))
+		return false;
+
+	if (unlikely(data == tux_nb02_touchp_toggle_seq[seq_pos])) {
+		++seq_pos;
+		if (unlikely(data == 0x76 || data == 0xf6)) {
+			return true;
+		} else if (unlikely(seq_pos == ARRAY_SIZE(tux_nb02_touchp_toggle_seq))) {
+			schedule_work(&tux_nb02_f21_work);
+			seq_pos = 0;
+		}
+		return false;
+	}
+
+	seq_pos = 0;
+	return false;
+}
+
+static const struct dmi_system_id tux_nb02_dmi_string_match[] __initconst = {
+	{
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
+			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "NB02"),
+		},
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(dmi, tux_nb02_dmi_string_match);
+
+static int __init tux_nb02_plat_init(void)
+{
+	int ret;
+
+	if (!dmi_check_system(tux_nb02_dmi_string_match))
+		return -ENODEV;
+
+	idev = input_allocate_device();
+	if (!idev)
+		return -ENOMEM;
+
+	idev->name = "TUXEDO NB02 Platform Keyboard";
+	set_bit(EV_KEY, idev->evbit);
+	set_bit(KEY_F21, idev->keybit);
+
+	ret = input_register_device(idev);
+	if (ret) {
+		input_free_device(idev);
+		return ret;
+	}
+
+	i8042_install_filter(tux_nb02_i8042_filter, NULL);
+
+	return 0;
+}
+
+static void __exit tux_nb02_plat_exit(void)
+{
+	i8042_remove_filter(tux_nb02_i8042_filter);
+	input_unregister_device(idev);
+}
+
+module_init(tux_nb02_plat_init);
+module_exit(tux_nb02_plat_exit);
+
+MODULE_DESCRIPTION("Keyboard fix for TUXEDO NB02 devices");
+MODULE_AUTHOR("Werner Sembach <wse@tuxedocomputers.com>");
+MODULE_LICENSE("GPL");
-- 
2.43.0


