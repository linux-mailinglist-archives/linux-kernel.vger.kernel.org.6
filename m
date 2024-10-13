Return-Path: <linux-kernel+bounces-362930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE60099BB59
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 22:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0C0E1C20D34
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 20:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC9514EC71;
	Sun, 13 Oct 2024 20:07:56 +0000 (UTC)
Received: from lithops.sigma-star.at (mailout.nod.at [116.203.167.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A8614D2A0;
	Sun, 13 Oct 2024 20:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.167.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728850075; cv=none; b=YL/WPKg3VHDEPqMAmNcoC+yFaDIfy97OqUa6Go57InR5eZ1DhQlzgF1wl3Zph52darX0NI+tMG4nDgQfqSd6qP4Ubv2zcObcdR7btIXpEj30cDyyUwfAgSbWF7x5V2V6B9FIs8sl9fWSWgqDHybbcSxIY79UW0oDifIFO7P+To4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728850075; c=relaxed/simple;
	bh=90I2fuD9YWOIJcMHf8E8wy1P0jLpFA5kttYn4pIZUr4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TurqDgybMXQsfa6RmQxFGedN/U6BXlkWz7usDP6thwh8B6yXEEL0uEmYobTTPdSKLPW4R4x75ElTplOsaSRSjs0wu3AbI3edGFjdIooalJ76y0OnVKMYuwJQWL/Oef/+lR2APUSMOqxlgvCsfLCXDbfSZQeMPP8YfZarZL0vms0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=116.203.167.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 7E7422BFA56;
	Sun, 13 Oct 2024 22:07:44 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id aZe6T3Uwd3uL; Sun, 13 Oct 2024 22:07:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id EBEEF2BFA5A;
	Sun, 13 Oct 2024 22:07:43 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Zox0Bmbm1GV6; Sun, 13 Oct 2024 22:07:43 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id A9B382BFA56;
	Sun, 13 Oct 2024 22:07:43 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: devicetree@vger.kernel.org
Cc: robh@kernel.org,
	saravanak@google.com,
	linux-kernel@vger.kernel.org,
	upstream+devicetree@sigma-star.at,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH] [RFC] of: Add debug aid to find unused device tree properties
Date: Sun, 13 Oct 2024 22:07:30 +0200
Message-Id: <20241013200730.20542-1-richard@nod.at>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is a proof-of-concept patch that introduces a debug feature I find
particularly useful.  I frequently encounter situations where I'm
uncertain if my device tree configuration is correct or being utilized
by the kernel.  This is especially common when porting device trees
from vendor kernels, as some properties may have slightly different
names in the upstream kernel, or upstream drivers may not use certain
properties at all.

By writing 'y' to <debugfs>/of_mark_queried, every queried device tree
property will gain S_IWUSR in sysfs.  While abusing S_IWUSR is
admittedly a crude hack, it works for now.   I'm open to better ideas,
perhaps using an xattr?

That way, dtc can easily add an annotation to unused device trees when
reading from /proc/device-tree.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/of/Kconfig      |  9 +++++
 drivers/of/Makefile     |  1 +
 drivers/of/base.c       |  2 +
 drivers/of/debug.c      | 83 +++++++++++++++++++++++++++++++++++++++++
 drivers/of/of_private.h |  6 +++
 include/linux/of.h      |  3 ++
 6 files changed, 104 insertions(+)
 create mode 100644 drivers/of/debug.c

diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index 0e2d608c3e207..39079ab9f1dc9 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -90,6 +90,15 @@ config OF_IRQ
 	def_bool y
 	depends on !SPARC && IRQ_DOMAIN
=20
+config OF_DEBUG
+	bool "Device Tree debug features"
+	select DEBUG_FS
+	help
+	 This option enables device tree debug features.
+	 Currently only <debugfs>/of_mark_queried, writing 'y' to this file
+	 causes setting S_IWUSR on each device tree property in sysfs that
+	 was queried by a device driver.  This is useful to find dead propertie=
s.
+
 config OF_RESERVED_MEM
 	def_bool OF_EARLY_FLATTREE
=20
diff --git a/drivers/of/Makefile b/drivers/of/Makefile
index 379a0afcbdc0b..041502125e897 100644
--- a/drivers/of/Makefile
+++ b/drivers/of/Makefile
@@ -25,3 +25,4 @@ obj-$(CONFIG_OF_OVERLAY_KUNIT_TEST) +=3D overlay-test.o
 overlay-test-y :=3D overlay_test.o kunit_overlay_test.dtbo.o
=20
 obj-$(CONFIG_OF_UNITTEST) +=3D unittest-data/
+obj-$(CONFIG_OF_DEBUG) +=3D debug.o
diff --git a/drivers/of/base.c b/drivers/of/base.c
index 20603d3c9931b..00807da2187aa 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -202,6 +202,8 @@ static struct property *__of_find_property(const stru=
ct device_node *np,
 		if (of_prop_cmp(pp->name, name) =3D=3D 0) {
 			if (lenp)
 				*lenp =3D pp->length;
+			of_debug_mark_queried(pp);
+
 			break;
 		}
 	}
diff --git a/drivers/of/debug.c b/drivers/of/debug.c
new file mode 100644
index 0000000000000..ceb88062e9dec
--- /dev/null
+++ b/drivers/of/debug.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0+
+#include <linux/debugfs.h>
+#include <linux/kstrtox.h>
+#include <linux/of.h>
+
+#include "of_private.h"
+
+void of_debug_mark_queried(struct property *pp)
+{
+	pp->queried =3D true;
+}
+
+static int dtmq_update_node_sysfs(struct device_node *np)
+{
+	struct property *pp;
+	int ret =3D 0;
+
+	if (!IS_ENABLED(CONFIG_SYSFS) || !of_kset)
+		goto out;
+
+	for_each_property_of_node(np, pp) {
+		if (pp->queried) {
+			ret =3D sysfs_chmod_file(&np->kobj, &pp->attr.attr,
+					       pp->attr.attr.mode | S_IWUSR);
+			if (ret)
+				break;
+		}
+	}
+
+out:
+	return ret;
+}
+
+static int dtmq_update_sysfs(void)
+{
+	struct device_node *np;
+	int ret =3D 0;
+
+	mutex_lock(&of_mutex);
+	for_each_of_allnodes(np) {
+		ret =3D dtmq_update_node_sysfs(np);
+		if (ret)
+			break;
+	}
+	mutex_unlock(&of_mutex);
+
+	return ret;
+}
+
+static ssize_t dtmq_file_write(struct file *file, const char __user *use=
r_buf,
+			       size_t count, loff_t *ppos)
+{
+	bool do_it;
+	int ret;
+
+	ret =3D kstrtobool_from_user(user_buf, count, &do_it);
+	if (ret)
+		goto out;
+
+	if (do_it) {
+		ret =3D dtmq_update_sysfs();
+		if (!ret)
+			ret =3D count;
+	} else {
+		ret =3D -EINVAL;
+	}
+
+out:
+	return ret;
+}
+
+static const struct file_operations dtmq_fops =3D {
+	.write  =3D dtmq_file_write,
+	.open	=3D simple_open,
+	.owner  =3D THIS_MODULE,
+};
+
+static int __init of_debug_init(void)
+{
+	return PTR_ERR_OR_ZERO(debugfs_create_file("of_mark_queried", 0644, NUL=
L, NULL,
+			       &dtmq_fops));
+}
+late_initcall(of_debug_init);
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index 04aa2a91f851a..55a21ef292064 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -184,4 +184,10 @@ void fdt_init_reserved_mem(void);
=20
 bool of_fdt_device_is_available(const void *blob, unsigned long node);
=20
+#if defined(CONFIG_OF_DEBUG)
+void of_debug_mark_queried(struct property *pp);
+#else
+static inline void of_debug_mark_queried(struct property *pp) { }
+#endif
+
 #endif /* _LINUX_OF_PRIVATE_H */
diff --git a/include/linux/of.h b/include/linux/of.h
index 85b60ac9eec50..3b7afa252fca3 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -39,6 +39,9 @@ struct property {
 #if defined(CONFIG_OF_KOBJ)
 	struct bin_attribute attr;
 #endif
+#if defined(CONFIG_OF_DEBUG)
+	bool	queried;
+#endif
 };
=20
 #if defined(CONFIG_SPARC)
--=20
2.35.3


