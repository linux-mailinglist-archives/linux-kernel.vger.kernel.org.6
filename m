Return-Path: <linux-kernel+bounces-375966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E0D9A9DF5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 11:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 322CE28426F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 09:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0515D1957FC;
	Tue, 22 Oct 2024 09:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="KjwYwEjV"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9858922083;
	Tue, 22 Oct 2024 09:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588165; cv=none; b=ms9CBk7BKbMyDuGfp2BnU8zRIh4fWsCGNMmIBUeUDH/c8ETg8O/r/F2bCi/VsZBpfFCj1dQE/dTHOMf1LiVxnnZDGtJgc0z5I6o8WitKCqbXAJ6w1LZVSwNYIrVFoyGbJRBEaIgG/P/FXpnPbx/w8Q4dy7pIp93UbPyBNZh3cU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588165; c=relaxed/simple;
	bh=fG7n/rClPSyVCFZ9BkdrIS04RymnXShn9QUy9/w9ib0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=nR+aJqiINwPNwUM4/htkOroOSVQ5C/dazWGpxx0kHPT8ShyxL5o2uRU1N8JoQi3TGFL38EQinpOZiD6+UQHuAOcBttnO5fIhzkIAg09KfopPl7nd4OHX8draL86DrKOQ98fMN9MmO0LwF0u0kxwNKxNl7/AaftI36DIoOHMD2qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=KjwYwEjV; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=/zKgrV2wVhIQZ7vubU
	9nP6A/zQIVoNr8bUD3sblRl1U=; b=KjwYwEjV3D5ogLDDw6aCnyAa3P7/4rqkzN
	AS9tMbzxsz2o/lXBL0/cj/DgmG8qFJXNjS9WldHOxmOSxDrjiu+5NlNFlmcCa/PZ
	AuAjgoLsXPtSzBReogdSOzWj5KEE3jztbvoOFzzej2+r1hj3AeAFtvbXHz3vSxTN
	RI1RdHmlY=
Received: from localhost.localdomain (unknown [111.48.58.10])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgC3Zp2zaxdnQgSMAA--.40749S2;
	Tue, 22 Oct 2024 17:09:08 +0800 (CST)
From: huanglei814 <huanglei814@163.com>
To: gregkh@linuxfoundation.org,
	mathias.nyman@intel.com
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	huanglei <huanglei@kylinos.cn>
Subject: [PATCH v3] usb: core: adds support for PM control of specific USB dev skip suspend.
Date: Tue, 22 Oct 2024 17:09:05 +0800
Message-Id: <20241022090905.9806-1-huanglei814@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:PSgvCgC3Zp2zaxdnQgSMAA--.40749S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXF1DJFy5JFW3tr1kKFyrCrg_yoWrJFW5pF
	4qyFWFkrsxGr1Iq34aya18uF1rWanYkayjk3sakw1Ygw17Ja95Gr1jyFy5Xwnxur9xAFyU
	tFsrG3yUCrW7GFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U9a9fUUUUU=
X-CM-SenderInfo: xkxd0wxohlmiqu6rljoofrz/1tbi7g6A9mcXZAG6bQAAsU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: huanglei <huanglei@kylinos.cn>

All USB devices are brought into suspend power state after system suspend.
It is desirable for some specific manufacturers buses to keep their devices
in normal state even after system suspend.

v2: Change to bool type for skip_suspend.
v3: Rebase and update commit message.

Signed-off-by: huanglei <huanglei@kylinos.cn>
---
 drivers/usb/core/Kconfig     | 11 +++++++++++
 drivers/usb/core/driver.c    | 14 ++++++++++++++
 drivers/usb/host/xhci-plat.c |  7 +++++++
 include/linux/usb.h          |  9 +++++++++
 4 files changed, 41 insertions(+)

diff --git a/drivers/usb/core/Kconfig b/drivers/usb/core/Kconfig
index 58e3ca7e4793..69778aa7b913 100644
--- a/drivers/usb/core/Kconfig
+++ b/drivers/usb/core/Kconfig
@@ -143,3 +143,14 @@ config USB_DEFAULT_AUTHORIZATION_MODE
 	  ACPI selecting value 2 is analogous to selecting value 0.
 
 	  If unsure, keep the default value.
+
+config USB_SKIP_SUSPEND
+	bool "Vendor USB support skip suspend"
+	depends on USB
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
index 672d8fc2abdb..3074c89ed921 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -487,6 +487,15 @@ struct usb_bus {
 	struct mon_bus *mon_bus;	/* non-null when associated */
 	int monitored;			/* non-zero when monitored */
 #endif
+
+#ifdef CONFIG_USB_SKIP_SUSPEND
+	bool skip_suspend;		/* All USB devices are brought into suspend
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


