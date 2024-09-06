Return-Path: <linux-kernel+bounces-318068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DAF096E7F4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 05:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9B301C2336F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 03:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB573B1A2;
	Fri,  6 Sep 2024 03:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="cZ0fxCZm"
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5764D18E0E;
	Fri,  6 Sep 2024 03:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725591815; cv=none; b=eS+IYwYgf7JCoS7TJAJHeMAKZUxKWAlYVzqqtd+4j8GD1CxNkKJWLpVvKUAx8YrMPhOW6GSzDwYsCUnIim8Q/YAV8QYD3fLja3uL52hX5lghgCux/ZWbSxiUnn0B27KwwXt4lr58opsyEdxfnczFMZ9DtVxL3ShlF9PbVJ0K+Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725591815; c=relaxed/simple;
	bh=pY5ZeyCMUSMIPlXrBWEPXCGN8z8YDj1hmA9FiJoT+yM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jwRzwhd14wEI0VyPESquZhnmW6YLnyLzkoKbDIAJTYHToA75jO26lLpMuR0SxaI2Dohtia1S5iWSTLKwR36N0u6TO99QWQxLVKTfZ5LhDT6xBhqYKVACLIuIZkid8TCi996pJnm1bEFqjS86dC9dPuheD7jRrFNVb+Nu/XULnT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=cZ0fxCZm; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from localhost.localdomain (unknown [10.101.196.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id C7FD83F8D0;
	Fri,  6 Sep 2024 03:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1725591802;
	bh=b3HaiPJkHmkZb7OFUj3DBAtoNHQP33N6Bt1SRGcN4VA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=cZ0fxCZmHeX8NP40Y2Si76I8WDhsAxy2cVIHOMqZx3q8Xf5WJSAkIl4xn8tdsaqbq
	 p7V9oqD/gnp+X82LvVw6P0OveHIFVHR1rKETOPEYj3lotxGDOCuQhYz4meIBXBUsDD
	 FOZIgQz8R7GyfADjN8GBVDl86sZ7z6thAgUzDpN7StEgSzWcgEAksamMRoSLoQKCp3
	 jVQgcunSNM1mMREtpGMHuUYmOZFSZrrXY+wTY22kx7X7Hy0lsLxTm7ZAQCpoNR4WiI
	 CfSxqlraGVFWfJELaqEFb1VkhlKcQlrhiOtRHb2z/HunaGgFr1/v3P2Dkhmh5wrYuP
	 9bLxaPUtveyuQ==
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	gregkh@linuxfoundation.org,
	jorge.lopez2@hp.com
Cc: acelan.kao@canonical.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH v2] platform/x86/hp: Avoid spurious wakeup on HP ProOne 440
Date: Fri,  6 Sep 2024 11:03:00 +0800
Message-ID: <20240906030300.442110-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The HP ProOne 440 has a power saving design that when the display is
off, it also cuts the USB touchscreen device's power off.

This can cause system early wakeup because cutting the power off the
touchscreen device creates a disconnect event and prevent the system
from suspending:
[  445.814574] hub 2-0:1.0: hub_suspend
[  445.814652] usb usb2: bus suspend, wakeup 0
[  445.824629] xhci_hcd 0000:00:14.0: Port change event, 1-11, id 11, portsc: 0x202a0
[  445.824639] xhci_hcd 0000:00:14.0: resume root hub
[  445.824651] xhci_hcd 0000:00:14.0: handle_port_status: starting usb1 port polling.
[  445.844039] xhci_hcd 0000:00:14.0: PM: pci_pm_suspend(): hcd_pci_suspend+0x0/0x20 returns -16
[  445.844058] xhci_hcd 0000:00:14.0: PM: dpm_run_callback(): pci_pm_suspend+0x0/0x1c0 returns -16
[  445.844072] xhci_hcd 0000:00:14.0: PM: failed to suspend async: error -16
[  446.276101] PM: Some devices failed to suspend, or early wake event detected

So add a quirk to make sure the following is happening:
1. Let the i915 driver suspend first, to ensure the display is off so
   system also cuts the USB touchscreen's power.
2. Wait a while to let the USB disconnect event fire and get handled.
3. Since the disconnect event already happened, the xhci's suspend
   routine won't be interrupted anymore.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v2:
 - Remove the part that searching for the touchscreen device.
 - Wording.

 drivers/platform/x86/hp/hp-wmi.c | 59 +++++++++++++++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index 876e0a97cee1..7c239d8d02fd 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -30,6 +30,8 @@
 #include <linux/rfkill.h>
 #include <linux/string.h>
 #include <linux/dmi.h>
+#include <linux/delay.h>
+#include <linux/pci.h>
 
 MODULE_AUTHOR("Matthew Garrett <mjg59@srcf.ucam.org>");
 MODULE_DESCRIPTION("HP laptop WMI driver");
@@ -1708,6 +1710,14 @@ static void __exit hp_wmi_bios_remove(struct platform_device *device)
 		platform_profile_remove();
 }
 
+static int hp_wmi_suspend_handler(struct device *device)
+{
+	/* Let the xhci have time to handle disconnect event */
+	msleep(200);
+
+	return 0;
+}
+
 static int hp_wmi_resume_handler(struct device *device)
 {
 	/*
@@ -1745,7 +1755,7 @@ static int hp_wmi_resume_handler(struct device *device)
 	return 0;
 }
 
-static const struct dev_pm_ops hp_wmi_pm_ops = {
+static struct dev_pm_ops hp_wmi_pm_ops = {
 	.resume  = hp_wmi_resume_handler,
 	.restore  = hp_wmi_resume_handler,
 };
@@ -1871,6 +1881,51 @@ static int hp_wmi_hwmon_init(void)
 	return 0;
 }
 
+static int lg_usb_touchscreen_quirk(const struct dmi_system_id *id)
+{
+	struct pci_dev *vga, *xhci;
+	struct device_link *vga_link, *xhci_link;
+
+	vga = pci_get_class(PCI_CLASS_DISPLAY_VGA << 8, NULL);
+
+	xhci = pci_get_class(PCI_CLASS_SERIAL_USB_XHCI, NULL);
+
+	if (vga && xhci) {
+		xhci_link = device_link_add(&hp_wmi_platform_dev->dev, &xhci->dev,
+				      DL_FLAG_STATELESS);
+		if (xhci_link)
+			dev_info(&hp_wmi_platform_dev->dev, "Suspend before %s\n",
+				 pci_name(xhci));
+		else
+			return 1;
+
+		vga_link = device_link_add(&vga->dev, &hp_wmi_platform_dev->dev,
+					   DL_FLAG_STATELESS);
+		if (vga_link)
+			dev_info(&hp_wmi_platform_dev->dev, "Suspend after %s\n",
+				 pci_name(vga));
+		else {
+			device_link_del(xhci_link);
+			return 1;
+		}
+	}
+
+	hp_wmi_pm_ops.suspend = hp_wmi_suspend_handler;
+
+	return 1;
+}
+
+static const struct dmi_system_id hp_wmi_quirk_table[] = {
+	{
+		.callback = lg_usb_touchscreen_quirk,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP ProOne 440 23.8 inch G9 All-in-One Desktop PC"),
+		},
+	},
+	{}
+};
+
 static int __init hp_wmi_init(void)
 {
 	int event_capable = wmi_has_guid(HPWMI_EVENT_GUID);
@@ -1909,6 +1964,8 @@ static int __init hp_wmi_init(void)
 			goto err_unregister_device;
 	}
 
+	dmi_check_system(hp_wmi_quirk_table);
+
 	return 0;
 
 err_unregister_device:
-- 
2.43.0


