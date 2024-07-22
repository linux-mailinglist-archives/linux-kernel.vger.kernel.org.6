Return-Path: <linux-kernel+bounces-258757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A83D938C69
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 11:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E91B91F22D56
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F2616F900;
	Mon, 22 Jul 2024 09:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="TPgGPE93"
Received: from smtpout149.security-mail.net (smtpout149.security-mail.net [85.31.212.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71CF16EC17
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 09:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.31.212.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721641438; cv=none; b=aw7q0vb4hGsLfOEgFeU43spsRiI+faLZg0NGwdRsujmWGLaKK39BmF1gtGHHVJfEH1XV6veAUpnSE7HjIGa48UHi6lEy6FRYMBI1gLAwdcMLb8+dc+2U7SREORuzuGqv9su5MyQHI/3NTutQqOnKifPvORrFZyU904sqWXIb79k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721641438; c=relaxed/simple;
	bh=JOk3YGDP57h8sheVze5lvJ8wPFvJCP6dakAjbTJPqGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MVoNEnNXShMp077GIISIEm98n4Rx6aK28LcdatxHtu+04rUFUUWuCRM9WKQ8OqjmvfcdBARJUGet0/Zx27TplgJa8MSTL4ZTrX5gbLP9dt25k6zfvLqESt0rp1HLk2IRyQYeiz8ZscMlX87Fv3IVkb7K7CcBXuyDcRtbiLVXCCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=TPgGPE93; arc=none smtp.client-ip=85.31.212.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx409.security-mail.net [127.0.0.1])
	by fx409.security-mail.net (Postfix) with ESMTP id 8B08E3498AB
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 11:43:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1721641433;
	bh=JOk3YGDP57h8sheVze5lvJ8wPFvJCP6dakAjbTJPqGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TPgGPE93gX6+OZhIkGruFxnj8uIiwHOpasr5x6WGdS+45shMMl5CIYcAkMJUHcwSb
	 uGCKWpAsSiU1OlWZFuOTEKBOYYzbooOJJIXHmTPfB8gQO4Z1SE9DjJbLbtG9Mkx6yj
	 XnIkQFxBA1nAHDOTZioBh9RaIRUECVclTx7NiGtk=
Received: from fx409 (fx409.security-mail.net [127.0.0.1]) by
 fx409.security-mail.net (Postfix) with ESMTP id 4DB2E34978B; Mon, 22 Jul
 2024 11:43:53 +0200 (CEST)
Received: from srvsmtp.lin.mbt.kalray.eu (unknown [217.181.231.53]) by
 fx409.security-mail.net (Postfix) with ESMTPS id A51BA349658; Mon, 22 Jul
 2024 11:43:52 +0200 (CEST)
Received: from junon.lan.kalrayinc.com (unknown [192.168.37.161]) by
 srvsmtp.lin.mbt.kalray.eu (Postfix) with ESMTPS id 705FA40317; Mon, 22 Jul
 2024 11:43:52 +0200 (CEST)
X-Secumail-id: <2c9b.669e29d8.a2756.0>
From: ysionneau@kalrayinc.com
To: linux-kernel@vger.kernel.org
Cc: Jonathan Borne <jborne@kalrayinc.com>, Julian Vetter
 <jvetter@kalrayinc.com>, Yann Sionneau <ysionneau@kalrayinc.com>, Clement
 Leger <clement@clement-leger.fr>, Louis Morhet <lmorhet@kalrayinc.com>,
 Marius Gligor <mgligor@kalrayinc.com>, Jules Maselbas <jmaselbas@zdiv.net>,
 bpf@vger.kernel.org
Subject: [RFC PATCH v3 34/37] kvx: Add power controller driver
Date: Mon, 22 Jul 2024 11:41:45 +0200
Message-ID: <20240722094226.21602-35-ysionneau@kalrayinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240722094226.21602-1-ysionneau@kalrayinc.com>
References: <20240722094226.21602-1-ysionneau@kalrayinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

From: Yann Sionneau <ysionneau@kalrayinc.com>

The Power Controller (pwr-ctrl) controls cores reset and wake-up
procedure.

Co-developed-by: Clement Leger <clement@clement-leger.fr>
Signed-off-by: Clement Leger <clement@clement-leger.fr>
Co-developed-by: Julian Vetter <jvetter@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
Co-developed-by: Louis Morhet <lmorhet@kalrayinc.com>
Signed-off-by: Louis Morhet <lmorhet@kalrayinc.com>
Co-developed-by: Marius Gligor <mgligor@kalrayinc.com>
Signed-off-by: Marius Gligor <mgligor@kalrayinc.com>
Signed-off-by: Jules Maselbas <jmaselbas@zdiv.net>
Signed-off-by: Yann Sionneau <ysionneau@kalrayinc.com>
---

Notes:
V1 -> V2: new patch
V2 -> V3:
- Moved driver from arch/kvx/platform to drivers/soc/kvx/
  see discussions there:
  - https://lore.kernel.org/bpf/Y8qlOpYgDefMPqWH@zx2c4.com/T/#m722d8f7c7501615251e4f97705198f5485865ce2
- indent
- add missing static qualifier
- driver now registers a cpu_method/smp_op via CPU_METHOD_OF_DECLARE
  like arm and sh, it puts a struct into a __cpu_method_of_table ELF section.
  the smp_ops is used by smpboot.c if its name matches the DT 'cpus' node
  enable-method property.
---
 arch/kvx/include/asm/pwr_ctrl.h     | 57 ++++++++++++++++++++
 drivers/soc/Kconfig                 |  1 +
 drivers/soc/Makefile                |  1 +
 drivers/soc/kvx/Kconfig             | 10 ++++
 drivers/soc/kvx/Makefile            |  2 +
 drivers/soc/kvx/coolidge_pwr_ctrl.c | 84 +++++++++++++++++++++++++++++
 6 files changed, 155 insertions(+)
 create mode 100644 arch/kvx/include/asm/pwr_ctrl.h
 create mode 100644 drivers/soc/kvx/Kconfig
 create mode 100644 drivers/soc/kvx/Makefile
 create mode 100644 drivers/soc/kvx/coolidge_pwr_ctrl.c

diff --git a/arch/kvx/include/asm/pwr_ctrl.h b/arch/kvx/include/asm/pwr_ctrl.h
new file mode 100644
index 0000000000000..715eddd45a88c
--- /dev/null
+++ b/arch/kvx/include/asm/pwr_ctrl.h
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2024 Kalray Inc.
+ * Author(s): Clement Leger
+ *            Marius Gligor
+ *            Julian Vetter
+ *            Yann Sionneau
+ */
+
+#ifndef _ASM_KVX_PWR_CTRL_H
+#define _ASM_KVX_PWR_CTRL_H
+
+#ifndef __ASSEMBLY__
+
+static int kvx_pwr_ctrl_probe(void);
+
+int kvx_pwr_ctrl_cpu_poweron(unsigned int cpu);
+
+#endif
+
+#define PWR_CTRL_ADDR                           0xA40000
+
+/* Power controller vector register definitions */
+#define KVX_PWR_CTRL_VEC_OFFSET                 0x1000
+#define KVX_PWR_CTRL_VEC_WUP_SET_OFFSET         0x10
+#define KVX_PWR_CTRL_VEC_WUP_CLEAR_OFFSET       0x20
+
+/* Power controller PE reset PC register definitions */
+#define KVX_PWR_CTRL_RESET_PC_OFFSET            0x2000
+
+/* Power controller global register definitions */
+#define KVX_PWR_CTRL_GLOBAL_OFFSET              0x4040
+
+#define KVX_PWR_CTRL_GLOBAL_SET_OFFSET          0x10
+#define KVX_PWR_CTRL_GLOBAL_CLEAR_OFFSET        0x20
+#define KVX_PWR_CTRL_GLOBAL_SET_PE_EN_SHIFT     0x1
+
+#define PWR_CTRL_WUP_SET_OFFSET  \
+		(KVX_PWR_CTRL_VEC_OFFSET + \
+		 KVX_PWR_CTRL_VEC_WUP_SET_OFFSET)
+
+#define PWR_CTRL_WUP_CLEAR_OFFSET  \
+		(KVX_PWR_CTRL_VEC_OFFSET + \
+		 KVX_PWR_CTRL_VEC_WUP_CLEAR_OFFSET)
+
+#define PWR_CTRL_GLOBAL_CONFIG_SET_OFFSET \
+		(KVX_PWR_CTRL_GLOBAL_OFFSET + \
+		 KVX_PWR_CTRL_GLOBAL_SET_OFFSET)
+
+#define PWR_CTRL_GLOBAL_CONFIG_CLEAR_OFFSET \
+		(KVX_PWR_CTRL_GLOBAL_OFFSET + \
+		 KVX_PWR_CTRL_GLOBAL_CLEAR_OFFSET)
+
+#define PWR_CTRL_GLOBAL_CONFIG_PE_EN \
+	(1 << KVX_PWR_CTRL_GLOBAL_SET_PE_EN_SHIFT)
+
+#endif /* _ASM_KVX_PWR_CTRL_H */
diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index 5d924e946507b..f28078620da14 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -12,6 +12,7 @@ source "drivers/soc/fujitsu/Kconfig"
 source "drivers/soc/hisilicon/Kconfig"
 source "drivers/soc/imx/Kconfig"
 source "drivers/soc/ixp4xx/Kconfig"
+source "drivers/soc/kvx/Kconfig"
 source "drivers/soc/litex/Kconfig"
 source "drivers/soc/loongson/Kconfig"
 source "drivers/soc/mediatek/Kconfig"
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index fb2bd31387d07..240e148eaaff8 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_ARCH_GEMINI)	+= gemini/
 obj-y				+= hisilicon/
 obj-y				+= imx/
 obj-y				+= ixp4xx/
+obj-$(CONFIG_KVX)		+= kvx/
 obj-$(CONFIG_SOC_XWAY)		+= lantiq/
 obj-$(CONFIG_LITEX_SOC_CONTROLLER) += litex/
 obj-y				+= loongson/
diff --git a/drivers/soc/kvx/Kconfig b/drivers/soc/kvx/Kconfig
new file mode 100644
index 0000000000000..96d05efe4bfb5
--- /dev/null
+++ b/drivers/soc/kvx/Kconfig
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0
+
+config COOLIDGE_POWER_CONTROLLER
+	bool "Coolidge power controller"
+	default n
+	depends on KVX
+	help
+	  The Kalray Coolidge Power Controller is used to manage the power
+	  state of secondary CPU cores. Currently only powering up is
+	  supported.
diff --git a/drivers/soc/kvx/Makefile b/drivers/soc/kvx/Makefile
new file mode 100644
index 0000000000000..c7b0b3e99eabc
--- /dev/null
+++ b/drivers/soc/kvx/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_COOLIDGE_POWER_CONTROLLER)	+= coolidge_pwr_ctrl.o
diff --git a/drivers/soc/kvx/coolidge_pwr_ctrl.c b/drivers/soc/kvx/coolidge_pwr_ctrl.c
new file mode 100644
index 0000000000000..67af3e446d0e7
--- /dev/null
+++ b/drivers/soc/kvx/coolidge_pwr_ctrl.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2017-2024 Kalray Inc.
+ * Author(s): Clement Leger
+ *            Yann Sionneau
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/slab.h>
+#include <linux/smp.h>
+#include <linux/types.h>
+
+#include <asm/pwr_ctrl.h>
+#include <asm/symbols.h>
+
+struct kvx_pwr_ctrl {
+	void __iomem *regs;
+};
+
+static struct kvx_pwr_ctrl kvx_pwr_controller;
+
+static bool pwr_ctrl_not_initialized = true;
+
+/**
+ * kvx_pwr_ctrl_cpu_poweron() - Wakeup a cpu
+ * @cpu: cpu to wakeup
+ */
+int __init kvx_pwr_ctrl_cpu_poweron(unsigned int cpu)
+{
+	int ret = 0;
+
+	if (pwr_ctrl_not_initialized) {
+		pr_err("KVX power controller not initialized!\n");
+		return -ENODEV;
+	}
+
+	/* Set PE boot address */
+	writeq((unsigned long long)kvx_start,
+			kvx_pwr_controller.regs + KVX_PWR_CTRL_RESET_PC_OFFSET);
+	/* Wake up processor ! */
+	writeq(1ULL << cpu,
+	       kvx_pwr_controller.regs + PWR_CTRL_WUP_SET_OFFSET);
+	/* Then clear wakeup to allow processor to sleep */
+	writeq(1ULL << cpu,
+	       kvx_pwr_controller.regs + PWR_CTRL_WUP_CLEAR_OFFSET);
+
+	return ret;
+}
+
+static const struct smp_operations coolidge_smp_ops __initconst = {
+	.smp_boot_secondary = kvx_pwr_ctrl_cpu_poweron,
+};
+
+static int __init kvx_pwr_ctrl_probe(void)
+{
+	struct device_node *ctrl;
+
+	ctrl = of_find_compatible_node(NULL, NULL, "kalray,coolidge-pwr-ctrl");
+	if (!ctrl) {
+		pr_err("Failed to get power controller node\n");
+		return -EINVAL;
+	}
+
+	kvx_pwr_controller.regs = of_iomap(ctrl, 0);
+	if (!kvx_pwr_controller.regs) {
+		pr_err("Failed ioremap\n");
+		return -EINVAL;
+	}
+
+	pwr_ctrl_not_initialized = false;
+	pr_info("KVX power controller probed\n");
+
+	return 0;
+}
+
+CPU_METHOD_OF_DECLARE(coolidge_pwr_ctrl, "kalray,coolidge-pwr-ctrl",
+		      &coolidge_smp_ops);
+
+early_initcall(kvx_pwr_ctrl_probe);
-- 
2.45.2






