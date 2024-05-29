Return-Path: <linux-kernel+bounces-193756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D688D321E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 10:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDCDAB28B1E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B8C15CD66;
	Wed, 29 May 2024 08:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="zLb6CzVN"
Received: from jpms-ob01.noc.sony.co.jp (jpms-ob01.noc.sony.co.jp [211.125.140.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370D24DA08
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 08:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.140.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716971554; cv=none; b=Zma3BFC+jTB2RMhon1f3KiRddLWNRJccv8oEHI5mSvSb2JDThoAgfkpD4fMB2woZPgfoSDvJ+UGJHCDwIHJCKN0r7+rLfUTD6nzHXyrg7EeY2rjE5zmD3MjBIcZTvgqWx3D9ZlRPj0C+kRYZxh2R7/B7hhy/dQqa7RdJXGFgCMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716971554; c=relaxed/simple;
	bh=KqkqMm+91wYOeZTvCbVYyirrfOGlhLhMNaEStz+8LBs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TQEQyOLlt/e3qGjJPQA47P/5WdSzIAwUcQ2L6PEeF70s/2f0yLqeAWPuvfw3npmPdha2Lm2sFgP0RTMIYZE0wxrbE+hhKqjfW+kKE4MfKBwtPo1AYsZwHMynnNOpgNXrY2Kg6J/WsSQLvjIWtC6wOr74qPDHeE739hWVEtPOZIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=zLb6CzVN; arc=none smtp.client-ip=211.125.140.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1716971552; x=1748507552;
  h=date:from:to:cc:subject:message-id:reply-to:mime-version;
  bh=HVA1zeIRxUQKNTk6fHoyQMZWXuIH5enpzbqpIdOvEwo=;
  b=zLb6CzVNNy9jDgqUkSD39/QNt+XLBIFErF9Yjr86WmmV1mMlN1O/Tl1D
   BA53GR0s5FN3MNEb//ouitGLXUQcwyw+N+h4+XUB5aL+ntdpjmwYZsYOu
   /4VYxYREMBSU/T37MfQvfrsK9Fj9DbhMS0taxZMLM68mscuScUXlwbgD9
   usKRtq6s11+8FrcHIHX8OTQoi0PL0+QprIpja4wg3OOZKOPxxNFerBbWd
   e040REUfwp8sNukTuHaaZSJ+gucQN2gauhpUkxEGOYrQojzPKKAgsHC+R
   qJnL9TytNW8NW92ae8TAZw901i2HpbgUGGmBkWQqivG+eCDQZqs2UUvyG
   Q==;
Received: from unknown (HELO jpmta-ob1.noc.sony.co.jp) ([IPv6:2001:cf8:0:6e7::6])
  by jpms-ob01.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 17:32:25 +0900
X-IronPort-AV: E=Sophos;i="6.08,197,1712588400"; 
   d="scan'208";a="417552078"
Received: from unknown (HELO LXJ00013166) ([IPv6:2001:cf8:2:f100:2ef0:5dff:fe04:1f0f])
  by jpmta-ob1.noc.sony.co.jp with ESMTP; 29 May 2024 17:32:24 +0900
Date: Wed, 29 May 2024 08:32:24 +0000
From: Soumya Khasnis <soumya.khasnis@sony.com>
To: gregkh@linuxfoundation.org, rafael@kernel.org,
	linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
	festevam@denx.de, lee@kernel.org, benjamin.bara@skidata.com,
	dmitry.osipenko@collabora.com, ldmldm05@gmail.com,
	soumya.khasnis@sony.com, srinavasa.nagaraju@sony.com
Cc: soumya.khasnis@sony.com, srinavasa.nagaraju@sony.com,
	Madhusudan.Bobbili@sony.com, shingo.takeuchi@sony.com,
	keita.aihara@sony.com, masaya.takahashi@sony.com
Subject: [PATCH] reboot: Add timeout for device shutdown
Message-ID: <20240529083224.GA71473@sony.com>
Reply-To: soumya.khasnis@sony.com
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
call trace of the shutdown callback which blocks the shutdown or
reboot process.

Change-Id: Ibfc63ca8f8aa45866cbe6b90401d438d95eca742
Signed-off-by: Soumya Khasnis <soumya.khasnis@sony.com>
Signed-off-by: Srinavasa Nagaraju <Srinavasa.Nagaraju@sony.com>
---
 drivers/base/Kconfig | 15 +++++++++++++++
 kernel/reboot.c      | 46 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index 2b8fd6bb7da0..d06e379b6281 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -243,3 +243,18 @@ config FW_DEVLINK_SYNC_STATE_TIMEOUT
 	  work on.
 
 endmenu
+
+config DEVICE_SHUTDOWN_TIMEOUT
+	bool "device shutdown timeout"
+	default n
+	help
+	   Enable timeout for device shutdown. Helps in case device shutdown
+	   is hung during shoutdonw and reboot.
+
+
+config DEVICE_SHUTDOWN_TIMEOUT_SEC
+	int "device shutdown timeout in seconds"
+	default 5
+	depends on DEVICE_SHUTDOWN_TIMEOUT
+	help
+	  sets time for device shutdown timeout in seconds
diff --git a/kernel/reboot.c b/kernel/reboot.c
index 22c16e2564cc..8460bd24563b 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -18,7 +18,7 @@
 #include <linux/syscalls.h>
 #include <linux/syscore_ops.h>
 #include <linux/uaccess.h>
-
+#include <linux/sched/debug.h>
 /*
  * this indicates whether you can reboot with ctrl-alt-del: the default is yes
  */
@@ -48,6 +48,14 @@ int reboot_cpu;
 enum reboot_type reboot_type = BOOT_ACPI;
 int reboot_force;
 
+#ifdef CONFIG_DEVICE_SHUTDOWN_TIMEOUT
+struct device_shutdown_timeout {
+	struct timer_list timer;
+	struct task_struct *task;
+} devs_shutdown;
+#define SHUTDOWN_TIMEOUT CONFIG_DEVICE_SHUTDOWN_TIMEOUT_SEC
+#endif
+
 struct sys_off_handler {
 	struct notifier_block nb;
 	int (*sys_off_cb)(struct sys_off_data *data);
@@ -88,12 +96,46 @@ void emergency_restart(void)
 }
 EXPORT_SYMBOL_GPL(emergency_restart);
 
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
 void kernel_restart_prepare(char *cmd)
 {
 	blocking_notifier_call_chain(&reboot_notifier_list, SYS_RESTART, cmd);
 	system_state = SYSTEM_RESTART;
 	usermodehelper_disable();
+	device_shutdown_timer_set();
 	device_shutdown();
+	device_shutdown_timer_clr();
 }
 
 /**
@@ -293,7 +335,9 @@ static void kernel_shutdown_prepare(enum system_states state)
 		(state == SYSTEM_HALT) ? SYS_HALT : SYS_POWER_OFF, NULL);
 	system_state = state;
 	usermodehelper_disable();
+	device_shutdown_timer_set();
 	device_shutdown();
+	device_shutdown_timer_clr();
 }
 /**
  *	kernel_halt - halt the system
-- 
2.40.0


