Return-Path: <linux-kernel+bounces-401198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B88279C171D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 08:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76CFF2862E2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 07:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8A41DE899;
	Fri,  8 Nov 2024 07:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=aruba.it header.i=@aruba.it header.b="WaffGECr"
Received: from smtpcmd0756.aruba.it (smtpcmd0756.aruba.it [62.149.156.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06361D1735
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 07:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731051520; cv=none; b=PdWxBmM4jRKEQHDwgkO77q/pnNZm92gZtNHUdueiRb68iZvoTMp2H8q4K0K5Lv8CHduEySFG9FOrKBH2eY8Eva3HWvK6x/x3dELe579BEMi6N+Qa4UC/LKe0u8Dv4YG68wTYGEtm8wQs2no6bsL5mbyaEpHDFQmsnRaGHir0Wqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731051520; c=relaxed/simple;
	bh=pQYFTTHPv/l0SrEO6jpxHSYFgOBdIorOzOvP6SylBrw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ulS06KWra4Y4NGmGjFwmkY7VzGv/0Gmtt6mhDr+m9852VVVzq1bclK30lJIEfW5QV2QZmB3FWyrjciU8DEEvPnvzj1L+WGtv3b8NV7WaXBT1RgXNmWFpKz4LpDea24vMic0BSH3FpSiFS4/S1vEuk6wHrdwPEzeRweK6LAhUGBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=temperror (0-bit key) header.d=aruba.it header.i=@aruba.it header.b=WaffGECr; arc=none smtp.client-ip=62.149.156.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Received: from polimar.everex.local ([79.0.204.227])
	by Aruba Outgoing Smtp  with ESMTPSA
	id 9JSetHUHi6epj9JSitjpeG; Fri, 08 Nov 2024 08:31:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1731051080; bh=pQYFTTHPv/l0SrEO6jpxHSYFgOBdIorOzOvP6SylBrw=;
	h=From:To:Subject:Date:MIME-Version;
	b=WaffGECrfFtwt4TIBv+GqP51RJHcYWGCdF7PDARnRRZxEYj2hBosJOTbM9WDh8P1d
	 PsBQB5f3Ck50XBmS3JIy5OxF4BhN7AtzZIxeymLuqzZSFziVkiDk5LKNN/rYNrjYHv
	 XAsBpWwoL9At4hV/h4tnhA7TY98nnIDomCUlRT5PxekL2omiAzMeNiIpaXntrUYncC
	 9HKANOVMLHn8byfkxcB3UKqlnPBIipohXCRiDe/bLXxmKrMU6j6402tTUGnG2jpk1F
	 WqjzyiIriySkRYdgdSZa7CNSH15T3tukPutxNBurZI2JSUDenf68tayAMrPzOuCW/R
	 SyIcvWLCUW7VQ==
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
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Rodolfo Giometti <giometti@enneenne.com>
Subject: [V3 2/4] drivers pps/generators: add dummy PPS generator
Date: Fri,  8 Nov 2024 08:31:13 +0100
Message-Id: <20241108073115.759039-3-giometti@enneenne.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241108073115.759039-1-giometti@enneenne.com>
References: <20241108073115.759039-1-giometti@enneenne.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfByL/ulLdeMvtM5pRvsMn3uqQHLcEzSgHMHHx1ZPNoq3K1tx8qXTnz7zlvmaug499Umh7L+GGGTThclnIlsQpTGPAsNa6UpVcNKglabfe4ZN0rrvelRS
 FzdzP1a3dVjnjHE9OK+h8skrDWSgfXcWnZ0+L6W93YQxjd/U7+Dfa1rSw/nVMH3a40d0ggZ6NQmUx8V+N1MLnbu3RAnC5vqGeV2zTaW3KF11MQyJMa9tS+MD
 JAMNmyKE8ozZQir2yaZX/RIUVV6gX87jK+rfEyIyoWdnU+OJVBki2kUdXS/eBSZaMhldbrMCpMrpFQczF82G/bddamuWOtoTDnf5MEKdG8TmbBqyJ4I/WEs9
 A/sq5zUqsrm5z/69yJBZXnnopJL6ItshSzDj9Ru4CT3kBj3rKvSjDaPmk36GGNqcf2ZjInB/Q9B9ndYRroZydtDHARCP4OT4d/SdGMkXJBxkkweePMoNOKJR
 ID9K14Bl55fOpXydhMp0mLvqEEgSXUp+2dF+1HDdlGthg7/7gAppExL6y2mFg6p6eo2e9NsEk2Kp6kxKuIfNqqTB7twt8y1yqRVRsETy+/OCTvOYtB50iCs0
 QjgOrtCPpXqmDuYWa434ib4ZAiOvlxY7umQBn2OkJDw9TYE77IXsTYnHFa6pG7D9JuqL9U7c/l+Z8TlR2cgFcRCAsSBjb5jf+08kncvT4Zva2giQV10MCTu4
 rniCDRebhQF354X1bscNHb78ZbexATptWl2ljhYrJx5D+pOSy/mSjPN6AxbRMgDETnnBtU73aB0=

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
index b34e483eff21..cd94bf3bfaf2 100644
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


