Return-Path: <linux-kernel+bounces-390939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F539B804C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 17:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89D0AB22014
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C84C1BBBF8;
	Thu, 31 Oct 2024 16:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=aruba.it header.i=@aruba.it header.b="Qx+RlTjx"
Received: from smtpcmd15176.aruba.it (smtpcmd15176.aruba.it [62.149.156.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9162A1974F4
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 16:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730392704; cv=none; b=APxLKVjIW2K51SXuxvhphULgugORHVeLhlMo4rywwEEjKq23j0xxmGpQXdvxzFK/XretHO5N516BDrCNrCkYg9RMBGkf8St/or0EElSR6T7Y1kXhBpu1nchhsTBrIvu8h6KJWychWJMweY+pyPJ6D5TfcYWAyF0re6L7s60mk0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730392704; c=relaxed/simple;
	bh=5IQJhOIfU2KprQEe0yBeY1XeFR4R80mFeIeQJwMngZI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NRcYPd0rzvPVDFiJMgaD64HXVl+GHu3N551F8f9ovowo4wekyMbLWgfybk365BfX1mXbnCOFt1A3lHMrWPIppYsS7KScsgJt7qbNSJSG9ecaeP2LQjvmnkMeTgylNZkcIWnSRjTIDO1B83ZRPZE/oOZMI0vpyxYaGZY11J88a68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=temperror (0-bit key) header.d=aruba.it header.i=@aruba.it header.b=Qx+RlTjx; arc=none smtp.client-ip=62.149.156.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Received: from polimar.everex.local ([79.0.204.227])
	by Aruba Outgoing Smtp  with ESMTPSA
	id 6Y8atb5dFqJRS6Y8dtNuHf; Thu, 31 Oct 2024 17:35:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1730392512; bh=5IQJhOIfU2KprQEe0yBeY1XeFR4R80mFeIeQJwMngZI=;
	h=From:To:Subject:Date:MIME-Version;
	b=Qx+RlTjxmlHSQWs5u7S0Ia577Z48+ZVb3Bv3A+wuwz1acA78LUJpqIqyO5Qt1lGPL
	 2ore0wUdBinWbvO5bCWNqC38mswKsDtN0pRnJmzmpKJQmpdZ530RXZm38zv11oPIsu
	 /G8UaRZl27P3V74rUPeFDFjDfCDKrL8WzCfBj+ccEOBPn6YVY7sNxU6UtOif04u3cI
	 m7+QNR4PEMwgr0zYI7JDuf4fbhAQEqjMaebN84K0Us/DWmBlfuNk09v/6gE7Cv/00J
	 o4d6WBmtBVkolKI5WcXV+k4l1jed6ldH2lYcdGfrr7WedWLdXPqpDmuVEJzP4uRZFf
	 3AxZESP30fVfQ==
From: Rodolfo Giometti <giometti@enneenne.com>
To: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Greg KH <greg@kroah.com>,
	corbet@lwn.net,
	Hall Christopher S <christopher.s.hall@intel.com>,
	Mohan Subramanian <subramanian.mohan@intel.com>,
	tglx@linutronix.de,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Dong Eddie <eddie.dong@intel.com>,
	N Pandith <pandith.n@intel.com>,
	T R Thejesh Reddy <thejesh.reddy.t.r@intel.com>,
	Zage David <david.zage@intel.com>,
	Chinnadurai Srinivasan <srinivasan.chinnadurai@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Rodolfo Giometti <giometti@enneenne.com>
Subject: [V2 2/4] drivers pps/generators: add dummy PPS generator
Date: Thu, 31 Oct 2024 17:35:06 +0100
Message-Id: <20241031163508.259522-3-giometti@enneenne.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241031163508.259522-1-giometti@enneenne.com>
References: <20241031163508.259522-1-giometti@enneenne.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfC4xJUzpyCeO512MKewBUXNC4nAmGrgTaZrYRB09ByD5SuetG3jKHT7f5+pLMj3x/nDQx7PZ0NY7Kh6FUgquTM9fs7rlt107VMFkASeI8bDdaPuVagbg
 s0CZ/4bJTUgvzoajhk4OOsSPNcjk/X0Pj4udoZ1NXVVBqdW+suT6YjOI9qmJYZDZ4Jgk18DKXOIfYHaWjPITDdNDYgL6MLKPuLcuFLsY6fZJQkAF6lVSuyAp
 crDj6HfPLJO+YNzhokInuNKmoNBpeKTgV+6V3h8ErcugLoTCLKxceqEEnaDssY6/2Tw5nFYGb0DdDct5JMH+ILgmo3QiIMvKCJ6gpR1gsA3FRehLK5+vzSdn
 Q6p697yL76leu9kKsMpZ+UmdFJVLFpBsEAiri+mZTiw4y91p8yAEy8MggacEerUONWK3I+ODfN1vWlg0QZ6uEoc34/ZOVOHY/VtJGjBmrY68+grEyaMleQxw
 zvYEJM3GHEKDdTpYcJdGYWnRmCjsxkRPACFx0vh87UUKFpIUaLFeHvE+3vS3jxLsB3r1/l7VfhpxIsUA3ar8rCjLl68cpwZU4Cef0Njt2zUxRU2RWEKxOePO
 HZyU6oMvz+nqGyftZZQbL8woxAP7LlKgtw/0JS+yA54Ucnc+VVnBcO7XY15uqUB0TZOf4wkJf7xjtKkPvDEevwBE4HEWEXSDiXTJJXSWNtKriaxMPHF5yF5T
 zigl0OuO8O1mHUXLSuO50dlTWEARQLXe

This dummy PPS generator can be used for debugging and documentation
purposes.

Signed-off-by: Rodolfo Giometti <giometti@enneenne.com>
---
 drivers/pps/generators/Kconfig         |  9 +++
 drivers/pps/generators/Makefile        |  1 +
 drivers/pps/generators/pps_gen-dummy.c | 96 ++++++++++++++++++++++++++
 3 files changed, 106 insertions(+)
 create mode 100644 drivers/pps/generators/pps_gen-dummy.c

diff --git a/drivers/pps/generators/Kconfig b/drivers/pps/generators/Kconfig
index 5edbfdb8bd92..51c05b090d94 100644
--- a/drivers/pps/generators/Kconfig
+++ b/drivers/pps/generators/Kconfig
@@ -14,6 +14,15 @@ menuconfig PPS_GENERATOR
 
 if PPS_GENERATOR
 
+config PPS_GENERATOR_DUMMY
+        tristate "Dummy PPS generator (Testing generator, use for debug)"
+        help
+          If you say yes here you get support for a PPS debugging generator
+          (which generates no PPS signal at all).
+
+          This driver can also be built as a module.  If so, the module
+          will be called pps_gen-dummy.
+
 config PPS_GENERATOR_PARPORT
 	tristate "Parallel port PPS signal generator"
 	depends on PARPORT && BROKEN
diff --git a/drivers/pps/generators/Makefile b/drivers/pps/generators/Makefile
index 034a78edfa26..dc1aa5a4688b 100644
--- a/drivers/pps/generators/Makefile
+++ b/drivers/pps/generators/Makefile
@@ -6,6 +6,7 @@
 pps_gen_core-y			:= pps_gen.o sysfs.o
 obj-$(CONFIG_PPS_GENERATOR)	:= pps_gen_core.o
 
+obj-$(CONFIG_PPS_GENERATOR_DUMMY)   += pps_gen-dummy.o
 obj-$(CONFIG_PPS_GENERATOR_PARPORT) += pps_gen_parport.o
 
 ccflags-$(CONFIG_PPS_DEBUG) := -DDEBUG
diff --git a/drivers/pps/generators/pps_gen-dummy.c b/drivers/pps/generators/pps_gen-dummy.c
new file mode 100644
index 000000000000..b284c200cbe5
--- /dev/null
+++ b/drivers/pps/generators/pps_gen-dummy.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * PPS dummy generator
+ *
+ * Copyright (C) 2024 Rodolfo Giometti <giometti@enneenne.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/time.h>
+#include <linux/timer.h>
+#include <linux/random.h>
+#include <linux/pps_gen_kernel.h>
+
+static struct pps_gen_device *pps_gen;
+static struct timer_list ktimer;
+
+static unsigned int get_random_delay(void)
+{
+	unsigned int delay = get_random_u8() & 0x0f;
+
+	return (delay + 1) * HZ;
+}
+
+/*
+ * The kernel timer
+ */
+
+static void pps_gen_ktimer_event(struct timer_list *unused)
+{
+	pps_gen_event(pps_gen, PPS_GEN_EVENT_MISSEDPULSE, NULL);
+}
+
+/*
+ * PPS Generator methods
+ */
+
+static int pps_gen_dummy_get_time(struct pps_gen_device *pps_gen,
+					struct timespec64 *time)
+{
+	struct system_time_snapshot snap;
+
+	ktime_get_snapshot(&snap);
+	*time = ktime_to_timespec64(snap.real);
+
+	return 0;
+}
+
+static int pps_gen_dummy_enable(struct pps_gen_device *pps_gen, bool enable)
+{
+	if (enable)
+		mod_timer(&ktimer, jiffies + get_random_delay());
+	else
+		del_timer_sync(&ktimer);
+
+	return 0;
+}
+
+/*
+ * The PPS info struct
+ */
+
+static struct pps_gen_source_info pps_gen_dummy_info = {
+	.use_system_clock	= true,
+	.get_time		= pps_gen_dummy_get_time,
+	.enable			= pps_gen_dummy_enable,
+};
+
+/*
+ * Module staff
+ */
+
+static void __exit pps_gen_dummy_exit(void)
+{
+	del_timer_sync(&ktimer);
+	pps_gen_unregister_source(pps_gen);
+}
+
+static int __init pps_gen_dummy_init(void)
+{
+	pps_gen = pps_gen_register_source(&pps_gen_dummy_info);
+	if (IS_ERR(pps_gen))
+		return PTR_ERR(pps_gen);
+
+	timer_setup(&ktimer, pps_gen_ktimer_event, 0);
+
+	return 0;
+}
+
+module_init(pps_gen_dummy_init);
+module_exit(pps_gen_dummy_exit);
+
+MODULE_AUTHOR("Rodolfo Giometti <giometti@enneenne.com>");
+MODULE_DESCRIPTION("LinuxPPS dummy generator");
+MODULE_LICENSE("GPL");
-- 
2.34.1


