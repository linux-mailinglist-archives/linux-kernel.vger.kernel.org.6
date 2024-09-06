Return-Path: <linux-kernel+bounces-318160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7327596E949
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 07:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A00E91C23755
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 05:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DAE7E574;
	Fri,  6 Sep 2024 05:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="vfj3DiGe"
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D661BC23;
	Fri,  6 Sep 2024 05:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725600677; cv=none; b=f+r92QwV2/VI/fsyJEQiarDMWz6Ipw9pqNikOQjqHXwj1Fk8zuXPHKWMiFzslOHZg97QHve0IVyM43mLAmwI/Prtq6CRO84EJUoGXBDdFgdrycKSOauIizqgidU9tUnBQFShebN00XvdA4z1VekuO+yTWXSnJ0xruqDzXzDzuBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725600677; c=relaxed/simple;
	bh=h09P8HLKfyRwc0dRd+XCdETIOzYIh+xJX+5H6gLZg7g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K4oo5JFI9H2beDH0qOTW3xDDIYpUubnvcg/oA668Isiwo8H18FAFikFk3Vnd2mTZkFHNwgaIeMEE+R2bcak3vCEA9AjA1fheJ+umrLiRiFQ8pYWDY/sbsExg610VWmgv3dngd0r24veA1p5kBVDrd3S/CBhnHRzmdLJQvOEfrDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=vfj3DiGe; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from localhost.localdomain (unknown [10.101.196.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id C10DE3FE84;
	Fri,  6 Sep 2024 05:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1725600664;
	bh=9a0OMGDGZrWicasMjCZX0lZ5DMyf3q0ANOrm+ZbpmDg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=vfj3DiGeWTj3yAlBpOvmvEc7q0tTOZuyNlMulqIJnEjE/oFs4V+Jrj4rVdFKL8INL
	 q+nQtnhh6isJ9GHJxAk23dd4WYXttlfp1OUTJavA+znS7iG9xobvtlyQQvD7ptaw7+
	 4wBNcs9IuEGvGdOXWbc+sgUhlvdPiVtUmiHjmH1Yjf9MJhrtHDcgPgERqpdBpIlqlP
	 QODevfKZqw1Hujlep7FLj194TRT74pBUcyD27VCZl5CE7fdyxSnpgcIh7FmVuT633s
	 d6KK8kWOj6tk3vL78pUOh22BPZBQV6yruYtwVc5kHbadfjUFotrNHi5nQwU31S4Vi7
	 bVbH/GQLk//Jg==
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
Subject: [PATCH v3] platform/x86/hp: Avoid spurious wakeup on HP ProOne 440
Date: Fri,  6 Sep 2024 13:30:47 +0800
Message-ID: <20240906053047.459036-1-kai.heng.feng@canonical.com>
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
v3:
 - Use dev_dbg() instead of dev_info().

v2:
 - Remove the part that searching for the touchscreen device.
 - Wording.

 drivers/platform/x86/hp/hp-wmi.c | 59 +++++++++++++++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index 876e0a97cee1..92cb02b50dfc 100644
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
+			dev_dbg(&hp_wmi_platform_dev->dev, "Suspend before %s\n",
+				 pci_name(xhci));
+		else
+			return 1;
+
+		vga_link = device_link_add(&vga->dev, &hp_wmi_platform_dev->dev,
+					   DL_FLAG_STATELESS);
+		if (vga_link)
+			dev_dbg(&hp_wmi_platform_dev->dev, "Suspend after %s\n",
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


