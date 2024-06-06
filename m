Return-Path: <linux-kernel+bounces-203884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 254A18FE194
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68FCEB2708E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 08:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEDE13E3EE;
	Thu,  6 Jun 2024 08:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="t6paUQZ/"
Received: from jpms-ob02.noc.sony.co.jp (jpms-ob02.noc.sony.co.jp [211.125.140.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C5113E3E7
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 08:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.140.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717663810; cv=none; b=RmwWmRUvZ2OlASvyUmG0uynp8128eXSP1fA9sIWcEPLEciekCyKCYOK/KujeQxVrUso2q6ta8SGIGet3EljZ4GImnPWcQx48XCQnwjkvis+kzTswqFdmfkmJv7EBVVX2fF0E/egjLARLLsPY8hDkrZ78Qs8dA3VpDQ9nJKmveLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717663810; c=relaxed/simple;
	bh=JVZB6x+SODG8MuDAES9ShWZBRx4IP5Dzg24FRLyYQFI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rstYdf26oQbv7ZR0bMRRnEPq2WNld1ZJYoRoOXpFv9xEQEkwgpp/KVnIeP8BBVLjyLiD4dZ6ZfblKA6SfFDhI33MO8sNO8SoBdcF6js9BtjDMV0QzgUbsac/E1w3mbBSeXIUM66tTrK5aIJpFFy72wo05zVLVtcihK/K6wAZ7BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=t6paUQZ/; arc=none smtp.client-ip=211.125.140.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1717663807; x=1749199807;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fYlYZ47j26pnUCWre9m7xSqxIzLhvKrSkQ5G3+p3Xts=;
  b=t6paUQZ/Xu2mPvgPlTjjGu7lH0jf57fmulceuNa2qugeKdOYwmOsZvvC
   0JX2FZHIQBzrWN3geWsmPgMSUZe370QLnpwlkzoyZrJEr3PT6pa9MyK9U
   LQrfVB29H6cPMoygnYURf9xV7VtrivVs6Z8kKJAcSlHWKPKkGw8dC3DY3
   AgGvrB7XxVh/NNPPKadQYSHM0zhddd9A+P7xNzi7Stig8SKNFYU7P5K/W
   ov7Ba43PhSgEXHhK2WkfQbqOGuczmQ6wDz1W3fCMONh2MGv0mT1NgJUnE
   nxeuFmP+gvHRKvomkRRf6LguGYbIltLrmPYoPXKcxERHfsgKWu3wSDMyT
   g==;
Received: from unknown (HELO jpmta-ob1.noc.sony.co.jp) ([IPv6:2001:cf8:0:6e7::6])
  by jpms-ob02.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 17:50:05 +0900
X-IronPort-AV: E=Sophos;i="6.08,218,1712588400"; 
   d="scan'208";a="420660213"
Received: from unknown (HELO LXJ00013166) ([IPv6:2001:cf8:2:f100:2ef0:5dff:fe04:1f0f])
  by jpmta-ob1.noc.sony.co.jp with ESMTP; 06 Jun 2024 17:50:05 +0900
Date: Thu, 6 Jun 2024 08:50:03 +0000
From: Soumya Khasnis <soumya.khasnis@sony.com>
To: gregkh@linuxfoundation.org, rafael@kernel.org,
	linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
	festevam@denx.de, lee@kernel.org, benjamin.bara@skidata.com,
	dmitry.osipenko@collabora.com, ldmldm05@gmail.com,
	soumya.khasnis@sony.com, srinavasa.nagaraju@sony.com
Cc: soumya.khasnis@sony.com, srinavasa.nagaraju@sony.com,
	Madhusudan.Bobbili@sony.com, shingo.takeuchi@sony.com,
	keita.aihara@sony.com, masaya.takahashi@sony.com
Subject: [PATCH v3] driver core: Add timeout for device shutdown
Message-ID: <20240606085003.GA118950@sony.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)

The device shutdown callbacks invoked during shutdown/reboot
are prone to errors depending on the device state or mishandling
by one or more driver. In order to prevent a device hang in such
scenarios, we bail out after a timeout while dumping a meaningful
call trace of the shutdown callback to kernel logs, which blocks
the shutdown or reboot process.

Signed-off-by: Soumya Khasnis <soumya.khasnis@sony.com>
Signed-off-by: Srinavasa Nagaraju <Srinavasa.Nagaraju@sony.com>
---
Changes in v3:
  -fix review comments
  -updated commit message

 drivers/base/Kconfig | 18 ++++++++++++++++++
 drivers/base/base.h  |  8 ++++++++
 drivers/base/core.c  | 40 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 66 insertions(+)

diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index 2b8fd6bb7da0..342d3f87a404 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -243,3 +243,21 @@ config FW_DEVLINK_SYNC_STATE_TIMEOUT
 	  work on.
 
 endmenu
+
+config DEVICE_SHUTDOWN_TIMEOUT
+	bool "device shutdown timeout"
+	default y
+	help
+	   Enable timeout for device shutdown. In case of device shutdown is
+	   broken or device is not responding, system shutdown or restart may hang.
+	   This timeout handles such situation and triggers emergency_restart or
+	   machine_power_off. Also dumps call trace of shutdown process.
+
+
+config DEVICE_SHUTDOWN_TIMEOUT_SEC
+	int "device shutdown timeout in seconds"
+	range 10 60
+	default 10
+	depends on DEVICE_SHUTDOWN_TIMEOUT
+	help
+	  sets time for device shutdown timeout in seconds
diff --git a/drivers/base/base.h b/drivers/base/base.h
index 0738ccad08b2..97eea57a8868 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -243,3 +243,11 @@ static inline int devtmpfs_delete_node(struct device *dev) { return 0; }
 
 void software_node_notify(struct device *dev);
 void software_node_notify_remove(struct device *dev);
+
+#ifdef CONFIG_DEVICE_SHUTDOWN_TIMEOUT
+struct device_shutdown_timeout {
+	struct timer_list timer;
+	struct task_struct *task;
+};
+#define SHUTDOWN_TIMEOUT CONFIG_DEVICE_SHUTDOWN_TIMEOUT_SEC
+#endif
diff --git a/drivers/base/core.c b/drivers/base/core.c
index b93f3c5716ae..dab455054a80 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -35,6 +35,12 @@
 #include "base.h"
 #include "physical_location.h"
 #include "power/power.h"
+#include <linux/sched/debug.h>
+#include <linux/reboot.h>
+
+#ifdef CONFIG_DEVICE_SHUTDOWN_TIMEOUT
+struct device_shutdown_timeout devs_shutdown;
+#endif
 
 /* Device links support. */
 static LIST_HEAD(deferred_sync);
@@ -4799,6 +4805,38 @@ int device_change_owner(struct device *dev, kuid_t kuid, kgid_t kgid)
 }
 EXPORT_SYMBOL_GPL(device_change_owner);
 
+#ifdef CONFIG_DEVICE_SHUTDOWN_TIMEOUT
+static void device_shutdown_timeout_handler(struct timer_list *t)
+{
+	pr_emerg("**** device shutdown timeout ****\n");
+	show_stack(devs_shutdown.task, NULL, KERN_EMERG);
+	if (system_state == SYSTEM_RESTART)
+		emergency_restart();
+	else
+		machine_power_off();
+}
+
+static void device_shutdown_timer_set(void)
+{
+	devs_shutdown.task = current;
+	timer_setup(&devs_shutdown.timer, device_shutdown_timeout_handler, 0);
+	devs_shutdown.timer.expires = jiffies + SHUTDOWN_TIMEOUT * HZ;
+	add_timer(&devs_shutdown.timer);
+}
+
+static void device_shutdown_timer_clr(void)
+{
+	del_timer(&devs_shutdown.timer);
+}
+#else
+static inline void device_shutdown_timer_set(void)
+{
+}
+static inline void device_shutdown_timer_clr(void)
+{
+}
+#endif
+
 /**
  * device_shutdown - call ->shutdown() on each device to shutdown.
  */
@@ -4810,6 +4848,7 @@ void device_shutdown(void)
 	device_block_probing();
 
 	cpufreq_suspend();
+	device_shutdown_timer_set();
 
 	spin_lock(&devices_kset->list_lock);
 	/*
@@ -4869,6 +4908,7 @@ void device_shutdown(void)
 		spin_lock(&devices_kset->list_lock);
 	}
 	spin_unlock(&devices_kset->list_lock);
+	device_shutdown_timer_clr();
 }
 
 /*
-- 
2.40.0


