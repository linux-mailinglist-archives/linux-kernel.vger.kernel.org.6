Return-Path: <linux-kernel+bounces-207718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A08901ACA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 08:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 552C61F244C0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 06:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A8C125DE;
	Mon, 10 Jun 2024 05:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="pFrbfGyn"
Received: from jpms-ob02.noc.sony.co.jp (jpms-ob02.noc.sony.co.jp [211.125.140.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4E811CA1
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 05:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.140.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717999134; cv=none; b=cQfUvTDFcbK+DmHmNTa7y1s3c+x0ftzmyptp5KYwSOCZF0xW/VA5ho5SMdrcKx3wL7yN84Q/foq7Si995/uLEkQaTIAo1LJEFaLbmeuWbwCLiUb1yIWrerExwv4Da+w7k02gdbr7oABNSNomxpgxeT1e72BJWqfmyDSSgwsGhLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717999134; c=relaxed/simple;
	bh=GwVRwQnTgj8O3BfAUuOTkz53sI9npHPP1TUmHJiHJn0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Y0rBGzgJ5ayp8cwMlJ/TCyTYS+YKa6GmghO650r7O5s2EoSfwq2gm9L5Ic29i9yOmZ13DGcJaEtQoQp4b1GqtJhhCRhTrLYAmZ9WyPDwk4FhoJF9bjIsdYJZnbpIgb81zZphl6/YbWv8+gKHzYFuVqkrPsx2RE759V9iO3sGVgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=pFrbfGyn; arc=none smtp.client-ip=211.125.140.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1717999132; x=1749535132;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=R/qMMiBD2FGKPB/hpQevwSC/BczQwYKl0ZhjeM3jIxU=;
  b=pFrbfGynS9/T7163x9G1Q5cglMhZrxelCI0iiXgEsfJ01mfIeCJYzJE0
   D9SDv+KD9j53D+k+stZrBf0B5kyBN5zsbTRgRnsFu5NqzeXLpCYBISmnk
   mp6io0+OHsprMwbgv8L/ceYFnXs2Yhzs7A54Te05EuhZ7gRwVkmWb2phL
   fKn7+XOh3UAHo/eVhurFucjcTkYHpW+HUi+0FK79DzXJlx6/xbfx71Ad7
   3wZMQ5XfRscYBcfw5bwaRkXklD9ivZkLSmv8M0Qtcj+M1gZEjSJTVGxS0
   q/12hTY5Vcpcaqol8aWuHk8wepFfLt8+665tb1pYduUS0uiQ1n/zKkT/D
   A==;
Received: from unknown (HELO jpmta-ob1.noc.sony.co.jp) ([IPv6:2001:cf8:0:6e7::6])
  by jpms-ob02.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 14:58:44 +0900
X-IronPort-AV: E=Sophos;i="6.08,226,1712588400"; 
   d="scan'208";a="422061174"
Received: from unknown (HELO LXJ00013166) ([IPv6:2001:cf8:2:f100:2ef0:5dff:fe04:1f0f])
  by jpmta-ob1.noc.sony.co.jp with ESMTP; 10 Jun 2024 14:58:44 +0900
Date: Mon, 10 Jun 2024 05:58:44 +0000
From: Soumya Khasnis <soumya.khasnis@sony.com>
To: gregkh@linuxfoundation.org, rafael@kernel.org,
	linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
	festevam@denx.de, lee@kernel.org, benjamin.bara@skidata.com,
	dmitry.osipenko@collabora.com, ldmldm05@gmail.com,
	soumya.khasnis@sony.com, srinavasa.nagaraju@sony.com
Cc: soumya.khasnis@sony.com, srinavasa.nagaraju@sony.com,
	Madhusudan.Bobbili@sony.com, shingo.takeuchi@sony.com,
	keita.aihara@sony.com, masaya.takahashi@sony.com
Subject: [PATCH v4] driver core: Add timeout for device shutdown
Message-ID: <20240610055844.GA68891@sony.com>
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
Changes v3:
  - fix review comments
 1. added help text  
 2. set configuration by default "y"
 3. added range for timeout value(DEVICE_SHUTDOWN_TIMEOUT_SEC)
 4. moved #define's to base.h file
 5. moved timeout functionality to device_shutdown() driver/base/core.c from reboot.c
  - updated commit message 
 1. added information of where call trace is logged.
 2. changed patch subject from "reboot:" to "driver core:"

Changes v4:
 1. set configuration by default "n"
 2. removed range for timeout value(DEVICE_SHUTDOWN_TIMEOUT_SEC)

 drivers/base/Kconfig | 17 +++++++++++++++++
 drivers/base/base.h  |  8 ++++++++
 drivers/base/core.c  | 40 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 65 insertions(+)

diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index 2b8fd6bb7da0..4e1d1efb4937 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -243,3 +243,20 @@ config FW_DEVLINK_SYNC_STATE_TIMEOUT
 	  work on.
 
 endmenu
+
+config DEVICE_SHUTDOWN_TIMEOUT
+	bool "device shutdown timeout"
+	default n
+	help
+	   Enable timeout for device shutdown. In case of device shutdown is
+	   broken or device is not responding, system shutdown or restart may hang.
+	   This timeout handles such situation and triggers emergency_restart or
+	   machine_power_off. Also dumps call trace of shutdown process.
+
+
+config DEVICE_SHUTDOWN_TIMEOUT_SEC
+	int "device shutdown timeout in seconds"
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


