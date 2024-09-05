Return-Path: <linux-kernel+bounces-316338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2AD296CE25
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 06:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9DB6B26563
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 04:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144E0170A0E;
	Thu,  5 Sep 2024 04:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="CXEntX1M"
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F361B149E16;
	Thu,  5 Sep 2024 04:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725510909; cv=none; b=XlvB/Fz/5yFA6Z1NEcKzxNGshGAg8l7pq+ip14DjiHav7F3w2b0NLEtrrE7m53JgX+Swd9e+NBlJ56H2zOwsY/RAauqls/0breF/MC0f5IFyKdjGAYox8ZWzWn5C42eT5xn3k2DelmegqfSDv60D3oAoDGEyL3nivzI/zeo6NHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725510909; c=relaxed/simple;
	bh=C2hGsloktDrW6qeedTlD98Vt+7uUUABL98LuaJmqbFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lGylF4SB1fWQdi5Y2BGKKU2YAhG97TWSofMdbi86VTHbkvheo7HGbBsZrN77led6bsq6ZOTuG5xMhDcJaER+4p0tTYrt0+NlssR4ejCanx4mH2/bgSDIU05xa1+0GCeFErv9B+pquX23M9v59pMd+q0Rkms53UfuvJn1KpuLVN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=CXEntX1M; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from localhost.localdomain (unknown [10.101.196.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 2789C40277;
	Thu,  5 Sep 2024 04:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1725510338;
	bh=FlrVU5ggFN3bVKP4cC7T9JINJbAIVK9NIuV92g/t9BE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=CXEntX1M5EVINkGgSEtLjkTshThQjHcWpcHyZozlFdFbHo3xjdi9kvDbvQgnioCHr
	 gd5JIPw5M0SNuie4kQOIt0foPc9npLvIRJkv9Ed8VU+P2U4WtZS8h5LWEO3Yb9C/tS
	 muntYj6cDGm0MaDgNtg34bLnU8mDU9JrpM0JbZTNiKxUghQ3eqJh2D1jsHawab+xZc
	 b6A/a/b7QE6Sv7OHCD9SOxGDP+V5CZxM3M+oQ18NUOQYVreccJ12JPIc9Dx5vZek/e
	 tlVUUjbqN5iOGRr+2aRPM82V78vvgScS2xuWC1AsnqKk1Wwy34uXJdM6GR5PIVenq0
	 my3YFtM9YcpYA==
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
Subject: [PATCH 2/2] platform/x86/hp: Avoid spurious wakeup on HP ProOne 440
Date: Thu,  5 Sep 2024 12:24:47 +0800
Message-ID: <20240905042447.418662-2-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240905042447.418662-1-kai.heng.feng@canonical.com>
References: <20240905042447.418662-1-kai.heng.feng@canonical.com>
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
2. If the touchscreen is present, wait a while to let the USB disconnect
   event fire.
3. Since the disconnect event already happened, the xhci's suspend
   routine won't be interrupted anymore.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/platform/x86/hp/hp-wmi.c | 104 ++++++++++++++++++++++++++++++-
 1 file changed, 103 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index 876e0a97cee1..80fc3ee4deaf 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -30,6 +30,9 @@
 #include <linux/rfkill.h>
 #include <linux/string.h>
 #include <linux/dmi.h>
+#include <linux/delay.h>
+#include <linux/pci.h>
+#include <linux/usb.h>
 
 MODULE_AUTHOR("Matthew Garrett <mjg59@srcf.ucam.org>");
 MODULE_DESCRIPTION("HP laptop WMI driver");
@@ -1708,6 +1711,52 @@ static void __exit hp_wmi_bios_remove(struct platform_device *device)
 		platform_profile_remove();
 }
 
+static int hp_wmi_suspend_handler(struct device *device)
+{
+	acpi_handle handle;
+	struct acpi_device *adev;
+	struct device *physdev;
+	struct usb_port *port_dev;
+	struct usb_device *udev;
+	acpi_status status;
+	bool found = false;
+
+	/* The USB touchscreen device always connects to HS11 */
+	status = acpi_get_handle(NULL, "\\_SB.PC00.XHCI.RHUB.HS11", &handle);
+	if (ACPI_FAILURE(status))
+		return 0;
+
+	adev = acpi_fetch_acpi_dev(handle);
+	if (!adev)
+		return 0;
+
+	physdev = get_device(acpi_get_first_physical_node(adev));
+	if (!physdev)
+		return 0;
+
+	port_dev = to_usb_port(physdev);
+	if (port_dev->state == USB_STATE_NOTATTACHED)
+		return 0;
+
+	udev = port_dev->child;
+
+	if (udev) {
+		usb_get_dev(udev);
+		if (le16_to_cpu(udev->descriptor.idVendor) == 0x1fd2 &&
+		    le16_to_cpu(udev->descriptor.idProduct) == 0x8102) {
+			dev_dbg(&hp_wmi_platform_dev->dev, "LG Melfas touchscreen found\n");
+			found = true;
+		}
+		usb_put_dev(udev);
+
+		/* Let the xhci have time to handle disconnect event */
+		if (found)
+			msleep(200);
+	}
+
+	return 0;
+}
+
 static int hp_wmi_resume_handler(struct device *device)
 {
 	/*
@@ -1745,7 +1794,7 @@ static int hp_wmi_resume_handler(struct device *device)
 	return 0;
 }
 
-static const struct dev_pm_ops hp_wmi_pm_ops = {
+static struct dev_pm_ops hp_wmi_pm_ops = {
 	.resume  = hp_wmi_resume_handler,
 	.restore  = hp_wmi_resume_handler,
 };
@@ -1871,6 +1920,57 @@ static int hp_wmi_hwmon_init(void)
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
+
+	/* During system bootup, the display and the USB touchscreen device can
+	 * be on and off several times, so the device may not be present during
+	 * hp-wmi's probe routine. Try to find the device in suspend routine
+	 * instead.
+	 */
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
@@ -1909,6 +2009,8 @@ static int __init hp_wmi_init(void)
 			goto err_unregister_device;
 	}
 
+	dmi_check_system(hp_wmi_quirk_table);
+
 	return 0;
 
 err_unregister_device:
-- 
2.43.0


