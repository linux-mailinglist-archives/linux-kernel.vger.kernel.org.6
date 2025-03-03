Return-Path: <linux-kernel+bounces-542197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 708FCA4C6E0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 414B2188DB3D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B13B22CBC9;
	Mon,  3 Mar 2025 16:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="Wv/jTeQ2"
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895F2216E1D;
	Mon,  3 Mar 2025 16:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741018373; cv=none; b=pSG39s96q+8Bd2Sod2dzIfqO72ZMKDQQjVHhaT0gvPmgyYu/IhudgpghZcs6y2YZZEpnIbZRNhvxDzTtcQsoNINRF94uK8TL9ilsZsEdaAvkarlIMpCWfcoeLIUoLgsVkbsORwMYoB7cO/iOUCsdrQb1LvwGMtwvl8fgv3J0Gho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741018373; c=relaxed/simple;
	bh=pbqF2f2UIQsIKla+a3/nLS5xlPE9J1y4xQHDqt1qfI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oP01b4yyvS2dDwtFeGnDdXuGZ0xe7tmAfXOdZNLjfn+1kdwObdOC7WzjSQ24Ej3EM9ES4E01vZnTXtEjuM71vRdZxGsYRT3j+e3AcwyDPwGKqddLNq5qgUpTy7LnDS+ZjvNuJG9IJgWeGJZriZBAtNG0dbVoKutRseMl7rv2YtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=Wv/jTeQ2; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from wse-pc.fritz.box (pd9e59f4f.dip0.t-ipconnect.de [217.229.159.79])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPA id 7E57A2FC004D;
	Mon,  3 Mar 2025 17:12:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1741018362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y9IazxVQBv8VXMYvNIacO/f6sax3uCSAjYHoWhsZ9HA=;
	b=Wv/jTeQ22O7bHmSn6l6Zv8FPZgkRGH8IxbLFTN4nHlmtAIILugZCBocSH1tod9FtJ93JDr
	LvKQ01+2D3xUhhMzs3M2FLYpSyHPpfJkuExI6ELkH7+Q3sJFJOLICLWeHGWAVzS6o2I3No
	F3mSu7Xh+G9Qy5uLLOXo9RUZ7gT+Xaw=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
From: Werner Sembach <wse@tuxedocomputers.com>
To: Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Werner Sembach <wse@tuxedocomputers.com>
Cc: linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH 2/2] Input: atkbd - Fix TUXEDO NB02 notebook keyboards FN-keys
Date: Mon,  3 Mar 2025 17:11:58 +0100
Message-ID: <20250303161228.437604-2-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250303161228.437604-1-wse@tuxedocomputers.com>
References: <20250303161228.437604-1-wse@tuxedocomputers.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This small driver does 2 things:

It remaps the touchpad toggle key from Control + Super + Hangaku/Zenkaku to
F21 to conform with established userspace defaults. Note that the
Hangaku/Zenkaku scancode used here is usually unused, with real
Hangaku/Zenkaku keys using the tilde scancode.

It suppresses the reserved scancode produced by pressing the FN-key on its
own, which fixes a warning spamming the dmesg log otherwise.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
---
 MAINTAINERS                                 |  6 ++
 drivers/platform/x86/Kconfig                |  2 +
 drivers/platform/x86/Makefile               |  3 +
 drivers/platform/x86/tuxedo/Kbuild          |  6 ++
 drivers/platform/x86/tuxedo/Kconfig         |  6 ++
 drivers/platform/x86/tuxedo/nb02/Kbuild     |  7 ++
 drivers/platform/x86/tuxedo/nb02/Kconfig    | 15 ++++
 drivers/platform/x86/tuxedo/nb02/platform.c | 79 +++++++++++++++++++++
 8 files changed, 124 insertions(+)
 create mode 100644 drivers/platform/x86/tuxedo/Kbuild
 create mode 100644 drivers/platform/x86/tuxedo/Kconfig
 create mode 100644 drivers/platform/x86/tuxedo/nb02/Kbuild
 create mode 100644 drivers/platform/x86/tuxedo/nb02/Kconfig
 create mode 100644 drivers/platform/x86/tuxedo/nb02/platform.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 4ff26fa94895d..d3fbbcef813b0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24178,6 +24178,12 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git turbostat
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
index 0000000000000..848ab61164404
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
+	default m
+	help
+	  This driver implements miscellaneous things found on TUXEDO Notebooks
+	  with board vendor NB02. For the time being this is only remapping the
+	  touchpad toggle key to something supported by most Linux distros
+	  out-of-the-box and supressing an unsupported scancode from the FN-key.
+
+	  When compiled as a module it will be called tuxedo_nb02_platform.
diff --git a/drivers/platform/x86/tuxedo/nb02/platform.c b/drivers/platform/x86/tuxedo/nb02/platform.c
new file mode 100644
index 0000000000000..a6137c8b2d4aa
--- /dev/null
+++ b/drivers/platform/x86/tuxedo/nb02/platform.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2025 Werner Sembach wse@tuxedocomputers.com
+ */
+
+#include <linux/i8042.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/serio.h>
+
+static u8 tux_nb02_touchp_toggle_seq[] = {
+	0xe0, 0x5b, // Super down
+	0x1d,       // Control down
+	0x76,       // Zenkaku/Hankaku down
+	0xf6,       // Zenkaku/Hankaku up
+	0x9d,       // Control up
+	0xe0, 0xdb  // Super up
+};
+
+static bool tux_nb02_i8042_filter(unsigned char data,
+				  unsigned char str,
+				  struct serio *port,
+				  __always_unused void *context)
+{
+	static u8 seq_pos;
+
+	if (unlikely(str & I8042_STR_AUXDATA))
+		return false;
+
+	pr_info("%#04x\n", data);
+
+	// Replace touchpad toggle key sequence with a singular press of the
+	// F21-key.
+	if (unlikely(data == tux_nb02_touchp_toggle_seq[seq_pos])) {
+		++seq_pos;
+		if (seq_pos == ARRAY_SIZE(tux_nb02_touchp_toggle_seq)) {
+			seq_pos = 0;
+			serio_interrupt(port, 0x6c, 0); // F21 down
+			serio_interrupt(port, 0xec, 0); // F21 up
+		}
+		return true;
+	}
+
+	// Ignore bogus scancode produced by the FN-key. Reuse seq_pos as first
+	// byte of that is just the "extended"-byte.
+	if (unlikely(seq_pos == 1 && (data == 0x78 || data == 0xf8))) {
+		seq_pos = 0;
+		return true;
+	}
+
+	// Replay skipped sequence bytes if it did not finish and it was not a
+	// FN-key press.
+	if (unlikely(seq_pos)) {
+		for (u8 i; i < seq_pos; ++i)
+			serio_interrupt(port, tux_nb02_touchp_toggle_seq[i], 0);
+		seq_pos = 0;
+	}
+
+	return false;
+}
+
+static int __init tux_nb02_plat_init(void)
+{
+	return i8042_install_filter(tux_nb02_i8042_filter, NULL);
+}
+
+static void __exit tux_nb02_plat_exit(void)
+{
+	i8042_remove_filter(tux_nb02_i8042_filter);
+}
+
+module_init(tux_nb02_plat_init);
+module_exit(tux_nb02_plat_exit);
+
+MODULE_ALIAS("dmi:*:svnTUXEDO:*:rvnNB02:*");
+
+MODULE_DESCRIPTION("TUXEDO NB02 Platform");
+MODULE_AUTHOR("Werner Sembach <wse@tuxedocomputers.com>");
+MODULE_LICENSE("GPL");
-- 
2.43.0


