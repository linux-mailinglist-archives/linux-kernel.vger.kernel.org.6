Return-Path: <linux-kernel+bounces-374362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2DC9A6902
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 14:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07BD81C211AA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892E11F584A;
	Mon, 21 Oct 2024 12:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Mga2vFLt"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8A81D3590;
	Mon, 21 Oct 2024 12:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729514891; cv=none; b=eRY18sVlMcQrh+ZVOMQv0SKpYvAluf3v76jjQ7WSDME9NIFWKuEtpIxhWt9k1BZ7Z5n0LMDbzrZ6EdoaQEQicgspHdYoUuM2Q6FecH0OB+mw30jSs+Fpgft0fwGkVp3LK8baxFVkyU3m7u2jCX4qY6WNjBMp0Ce7U0Le9pYDdSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729514891; c=relaxed/simple;
	bh=dcwsrDYAarJ2dsbZUYaldSwnwfwiSjhedCj7X3eiXZ8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=EBexAIdHJ3RIgzkYjbSwXTV+04ljeN1zDYrdRc1aAz5vxocYzQpiwomc7km46M+Kyxg/Dfpz4sCVAmh8pk4MTIwit54gXKzIyBDV8a2CuPp00e5bhj2MukTW23lnfZ+0GU9mzL4nWUIatG5QUes/q+pr4c9B8ol+mPEHfTydfSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Mga2vFLt; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=S29G+BHUzKxODCYlrD
	MsOh8+n3v/qlCoAc25CmxuWtQ=; b=Mga2vFLthllg7HCcKDY7YerdHB9bhmlEAH
	Z0imRJ12K13VdMNnba0vDHfMHVV2sr423BCffGy2cOG1OMFWsxcnDB8LnrLdYmTH
	6ULEknwh7s15xTpr+djLoWaSAsg9xi8Lao3lhvN/eSPCia/m1y3/O6YhUsCp9LLN
	MHRSmIVN4=
Received: from localhost.localdomain (unknown [111.48.58.10])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgD336x1TRZnmIsqAA--.12297S2;
	Mon, 21 Oct 2024 20:47:50 +0800 (CST)
From: huanglei814 <huanglei814@163.com>
To: gregkh@linuxfoundation.org,
	mathias.nyman@intel.com
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	huanglei <huanglei@kylinos.cn>
Subject: [PATCH] usb: core: adds support for PM control of specific USB dev skip suspend.
Date: Mon, 21 Oct 2024 20:47:41 +0800
Message-Id: <20241021124741.6014-1-huanglei814@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:PSgvCgD336x1TRZnmIsqAA--.12297S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuryxKw4DJrW5AF45ZrWDurg_yoWrJry5pF
	4qyFWYkrsxGr1Iv34aya1kuF1rWanYkayjk3sakw1Ygw17J395Gr10yFy5Xwnxur9xAFy7
	trsrG3yUCrW7GFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UBBTrUUUUU=
X-CM-SenderInfo: xkxd0wxohlmiqu6rljoofrz/1tbiLAJ-9mcV2zOcIgABsC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: huanglei <huanglei@kylinos.cn>

All USB devices are brought into suspend power state after system suspend.
It is desirable for some specific manufacturers buses to keep their devices
in normal state even after system suspend.

Signed-off-by: huanglei <huanglei@kylinos.cn>
---
 drivers/usb/core/Kconfig     | 12 ++++++++++++
 drivers/usb/core/driver.c    | 14 ++++++++++++++
 drivers/usb/host/xhci-plat.c |  7 +++++++
 include/linux/usb.h          |  9 +++++++++
 4 files changed, 42 insertions(+)

diff --git a/drivers/usb/core/Kconfig b/drivers/usb/core/Kconfig
index 58e3ca7e4793..fe178c90d167 100644
--- a/drivers/usb/core/Kconfig
+++ b/drivers/usb/core/Kconfig
@@ -143,3 +143,15 @@ config USB_DEFAULT_AUTHORIZATION_MODE
 	  ACPI selecting value 2 is analogous to selecting value 0.
 
 	  If unsure, keep the default value.
+
+config USB_SKIP_SUSPEND
+	bool "Vendor USB support skip suspend"
+	depends on USB
+	default n
+	help
+	  Select this the associate USB devices will skip suspend when pm control.
+
+	  This option adds support skip suspend for PM control of USB devices
+	  in specific manufacturers platforms.
+
+	  If unsure, keep the default value.
diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index 0c3f12daac79..05fe921f8297 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -1583,6 +1583,15 @@ int usb_suspend(struct device *dev, pm_message_t msg)
 	struct usb_device	*udev = to_usb_device(dev);
 	int r;
 
+#ifdef CONFIG_USB_SKIP_SUSPEND
+	if (udev->bus->skip_suspend && (msg.event == PM_EVENT_SUSPEND)) {
+		if (udev->state != USB_STATE_SUSPENDED)
+			dev_err(dev, "abort suspend\n");
+
+		return 0;
+	}
+#endif
+
 	unbind_no_pm_drivers_interfaces(udev);
 
 	/* From now on we are sure all drivers support suspend/resume
@@ -1619,6 +1628,11 @@ int usb_resume(struct device *dev, pm_message_t msg)
 	struct usb_device	*udev = to_usb_device(dev);
 	int			status;
 
+#ifdef CONFIG_USB_SKIP_SUSPEND
+	if (udev->bus->skip_suspend && (msg.event == PM_EVENT_RESUME))
+		return 0;
+#endif
+
 	/* For all calls, take the device back to full power and
 	 * tell the PM core in case it was autosuspended previously.
 	 * Unbind the interfaces that will need rebinding later,
diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index ecaa75718e59..8cbc666ab5c6 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -265,6 +265,13 @@ int xhci_plat_probe(struct platform_device *pdev, struct device *sysdev, const s
 		if (device_property_read_bool(tmpdev, "xhci-skip-phy-init-quirk"))
 			xhci->quirks |= XHCI_SKIP_PHY_INIT;
 
+#ifdef CONFIG_USB_SKIP_SUSPEND
+		if (device_property_read_bool(tmpdev, "usb-skip-suspend")) {
+			hcd_to_bus(hcd)->skip_suspend = true;
+			hcd_to_bus(xhci->shared_hcd)->skip_suspend = true;
+		}
+#endif
+
 		device_property_read_u32(tmpdev, "imod-interval-ns",
 					 &xhci->imod_interval);
 	}
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 672d8fc2abdb..5f88850fc42d 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -487,6 +487,15 @@ struct usb_bus {
 	struct mon_bus *mon_bus;	/* non-null when associated */
 	int monitored;			/* non-zero when monitored */
 #endif
+
+#ifdef CONFIG_USB_SKIP_SUSPEND
+	unsigned int skip_suspend;	/* All USB devices are brought into suspend
+					 * power state after system suspend. It is
+					 * desirable for some specific manufacturers
+					 * buses to keep their devices in normal
+					 * state even after system suspend.
+					 */
+#endif
 };
 
 struct usb_dev_state;
-- 
2.17.1


