Return-Path: <linux-kernel+bounces-559649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AE4A5F726
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 15:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6729F19C275D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C21267B90;
	Thu, 13 Mar 2025 14:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="PVxGFlht"
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81802E3379;
	Thu, 13 Mar 2025 14:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741874438; cv=none; b=TOYnyYB81OIYa6PZ8s3r3xpmJdPpAwQnQJ0K0bNqwqS4VOgDAKCd1UZ4cBoklwAzYrkCjDxnx61gSAOLjKVj1sskS62KQAU2fyiOXXwU1jrQrw1I3r938RvcupxTX+itsWWfoQ/tCCapSQs4wqLo1TTwozczaxzPXmSfBUtlK+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741874438; c=relaxed/simple;
	bh=qlDdxQVPiN4FfSZtOodyeHeFyKktDhsIsXoROIRuojg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E4Eu7/vDB6TCiSgiIDD5UaIV3+1U6aJbi8PBT0YxYzDH3KPuxf0mPZNkpO7aU+doyQciJfPFLSl435R6FtO216Cz5YuOWOSOJLiPz55GdlhzV613aW24D0tBUfEYteWL0SFWIN174sD8MWGAMr1GKKSYaJYHHQWrbGhpMaVoj6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=PVxGFlht; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from wse-pc.fritz.box (p5b164989.dip0.t-ipconnect.de [91.22.73.137])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPA id 799FC2FC018C;
	Thu, 13 Mar 2025 15:00:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1741874432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Yysuw7xCmQaKFIpjurEZ28pwfZ7+hYBT3cxLVCQV+M=;
	b=PVxGFlht9nCZXgG1Zs0iFNE9UOKAv5tmfzRGln8Im69ZnvSTIgbIdMtBV1N0meYSATSHDK
	Q7dW1PGoTZK4psuvN8TokCT+5KUUcXZHa8xlCGuw1cjqb1/bdMoqWu/lKQ0gQByhsrHjh3
	re1o64FCc3MVytKqOmcWRudO1adodts=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
From: Werner Sembach <wse@tuxedocomputers.com>
To: ilpo.jarvinen@linux.intel.com,
	hdegoede@redhat.com,
	Werner Sembach <wse@tuxedocomputers.com>
Cc: linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH v4 1/1] Input: atkbd - Fix TUXEDO NB02 notebook keyboards touchpad toggle key
Date: Thu, 13 Mar 2025 14:31:48 +0100
Message-ID: <20250313140028.617291-2-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250313140028.617291-1-wse@tuxedocomputers.com>
References: <20250313140028.617291-1-wse@tuxedocomputers.com>
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
 drivers/platform/x86/tuxedo/Kbuild          |   8 ++
 drivers/platform/x86/tuxedo/Kconfig         |   8 ++
 drivers/platform/x86/tuxedo/nb02/Kbuild     |   9 ++
 drivers/platform/x86/tuxedo/nb02/Kconfig    |  17 ++++
 drivers/platform/x86/tuxedo/nb02/platform.c | 107 ++++++++++++++++++++
 8 files changed, 160 insertions(+)
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
index 0000000000000..1c79b80744d1b
--- /dev/null
+++ b/drivers/platform/x86/tuxedo/Kbuild
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2025 Werner Sembach wse@tuxedocomputers.com
+#
+# TUXEDO X86 Platform Specific Drivers
+#
+
+obj-y	+= nb02/
diff --git a/drivers/platform/x86/tuxedo/Kconfig b/drivers/platform/x86/tuxedo/Kconfig
new file mode 100644
index 0000000000000..13b484999e333
--- /dev/null
+++ b/drivers/platform/x86/tuxedo/Kconfig
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2025 Werner Sembach wse@tuxedocomputers.com
+#
+# TUXEDO X86 Platform Specific Drivers
+#
+
+source "drivers/platform/x86/tuxedo/nb02/Kconfig"
diff --git a/drivers/platform/x86/tuxedo/nb02/Kbuild b/drivers/platform/x86/tuxedo/nb02/Kbuild
new file mode 100644
index 0000000000000..f56629c8b9dd8
--- /dev/null
+++ b/drivers/platform/x86/tuxedo/nb02/Kbuild
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2025 Werner Sembach wse@tuxedocomputers.com
+#
+# TUXEDO X86 Platform Specific Drivers
+#
+
+tuxedo_nb02_platform-y			:= platform.o
+obj-$(CONFIG_TUXEDO_NB02_PLATFORM)	+= tuxedo_nb02_platform.o
diff --git a/drivers/platform/x86/tuxedo/nb02/Kconfig b/drivers/platform/x86/tuxedo/nb02/Kconfig
new file mode 100644
index 0000000000000..38cd60c9d4f03
--- /dev/null
+++ b/drivers/platform/x86/tuxedo/nb02/Kconfig
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2025 Werner Sembach wse@tuxedocomputers.com
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


