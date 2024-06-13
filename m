Return-Path: <linux-kernel+bounces-212829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2C29066EA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 10:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D0B91C21D02
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 08:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B0513E02C;
	Thu, 13 Jun 2024 08:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="xDAnThV9"
Received: from jpms-ob01.noc.sony.co.jp (jpms-ob01.noc.sony.co.jp [211.125.140.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC3A13D523
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 08:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.140.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718267550; cv=none; b=g8tdTE6pRlJUcP/WlnNT+xI0/j5NA+tRCJl+cKp69bdkhNsW76sTF+iUI0Yw1LjtXR3ouxjF8jqO1RnqwBrxt8+cKK6Ue2IZiUQKGF71kq85HapxflXa7ObYQIdM8dmUiL6eHQZJh3nOccyUFXo1FhWCVdmp59H7hFrBzKJwluU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718267550; c=relaxed/simple;
	bh=AZAnKfxnwBNW+uPyKhNRMTErIpxf+m6tfSh8UTj2W3k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RQm7VDbAnizX4NmztijWQmdC8wgVB8snW0TXYraqOtPdfo0kKmlLAPmejC4UVrfh6PeHjmy9EYR2VAh54ziYM+X4V5lzbLucdQ287uB5fc0fZIFWOOu+fDBRfbmeLqUUZN52+oF879ZA+GaDlmKVgjkCWV/lmIuuzst4tdLkmw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=xDAnThV9; arc=none smtp.client-ip=211.125.140.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1718267548; x=1749803548;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Tey/d6zZxGXZu3fgrGCAzgcj7YCYLHltajEMKvW5hvU=;
  b=xDAnThV9+ov2nOn0n9vVILzioI+L6ncfSUrcWb5sxZ40H0g+nw4aYg4a
   mDqasqiBHD2lbjOJhmMjcKZPRlUPjaX6jJACkaRmlOkfCtddytu7CuDzk
   cHBvqXqbz1pcejwyd8GCsDRABykyPZp9HFr5WA9PRziZYp+FMSd9bMdms
   0VLMbnjXpyijjEoZe/qgDoBIDJ5D4zxSyAgj4X3aDjuNZMp+wzIxV9IQp
   w0368wrFZ+Ouqs53FgRU7Jr0rDSaqtjFZ0Q1f+WWYzfK4Nk9hIMGj1lg3
   n83WyM64Hi0DYIqdD8KGPjfG7VFzGo9XCJmVNX+S0jPHMxHOCljAg8OFk
   A==;
Received: from unknown (HELO jpmta-ob1.noc.sony.co.jp) ([IPv6:2001:cf8:0:6e7::6])
  by jpms-ob01.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 17:32:27 +0900
X-IronPort-AV: E=Sophos;i="6.08,234,1712588400"; 
   d="scan'208";a="423392383"
Received: from unknown (HELO LXJ00013166) ([IPv6:2001:cf8:2:f100:2ef0:5dff:fe04:1f0f])
  by jpmta-ob1.noc.sony.co.jp with ESMTP; 13 Jun 2024 17:32:26 +0900
Date: Thu, 13 Jun 2024 08:32:26 +0000
From: Soumya Khasnis <soumya.khasnis@sony.com>
To: gregkh@linuxfoundation.org, rafael@kernel.org,
	linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
	festevam@denx.de, lee@kernel.org, benjamin.bara@skidata.com,
	dmitry.osipenko@collabora.com, ldmldm05@gmail.com,
	soumya.khasnis@sony.com, srinavasa.nagaraju@sony.com
Cc: soumya.khasnis@sony.com, srinavasa.nagaraju@sony.com,
	Madhusudan.Bobbili@sony.com, shingo.takeuchi@sony.com,
	keita.aihara@sony.com, masaya.takahashi@sony.com
Subject: [PATCH v5] driver core: Add timeout for device shutdown
Message-ID: <20240613083226.GA8191@sony.com>
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

Changes v5:
 1. removed "default n" for configuration.

 drivers/base/Kconfig | 16 ++++++++++++++++
 drivers/base/base.h  |  8 ++++++++
 drivers/base/core.c  | 40 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+)

diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index 2b8fd6bb7da0..5493d419bdd0 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -243,3 +243,19 @@ config FW_DEVLINK_SYNC_STATE_TIMEOUT
 	  work on.
 
 endmenu
+
+config DEVICE_SHUTDOWN_TIMEOUT
+	bool "device shutdown timeout"
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


