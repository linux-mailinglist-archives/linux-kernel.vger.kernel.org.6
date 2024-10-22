Return-Path: <linux-kernel+bounces-375812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EC59A9B21
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 09:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0B711F2215D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 07:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86BA14EC5B;
	Tue, 22 Oct 2024 07:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="j7c337sa"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC721A269;
	Tue, 22 Oct 2024 07:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729582425; cv=none; b=RxYNXEo6KCi04qCr29PwWWsIdrlSbBhluA2fEGu/3E5nbJ8JWg7cabl6xqx7G3rHGJobRUjeVaPDaZqIQN92u+jzaUfrlb2z7m53MiI/Id91McQAYtFftE4NkDcto7J7mcXzwuL/0wsWnKueEPUP5xrmZ0kVEyntXU39AUl1Iws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729582425; c=relaxed/simple;
	bh=Q6XUxR3l4CTdj7wM8TsZkViUkMnpBxA00YX4Ayj+3mw=;
	h=From:To:Cc:Subject:Date:Message-Id; b=DDRPD5mGOwBeJunGs8nnkfvhlwlU33XRWoYBmByEV1hYDA3v9KqAsauh7MWdKcRo3G+S+PFkcaiNroM5FZVDPS4vF8BmB9nbGfYRfdufCOKYnM+5hJqs6G+Ep0cCYHe8KBRxfqjuz3eHaz7wDOHsXrPuh33b5JL7TY6N751jy+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=j7c337sa; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=rp3TEHWhcoB7Ymo/TJ
	glmynBnJb6QWn0ZIrwb4T3v+8=; b=j7c337saX2DbkpqzuLueThiKLx1WE4jsKb
	n+HvJigs5DHgHV6FIT2XiSL8Ec5jXMJz5t0bgYibxY8GBiDK6NoCzR9PWG2beTwn
	9+4EC7QtS1BkCrBfde73eJUaoA89/A6eA+aw0jXKxnHHyZZjY57GVNUAYNKfgSAX
	5bIQmSWCc=
Received: from localhost.localdomain (unknown [111.48.58.10])
	by gzsmtp3 (Coremail) with SMTP id sigvCgDnarZIVRdnVxPcBA--.35035S2;
	Tue, 22 Oct 2024 15:33:28 +0800 (CST)
From: huanglei814 <huanglei814@163.com>
To: gregkh@linuxfoundation.org,
	mathias.nyman@intel.com
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	huanglei <huanglei@kylinos.cn>
Subject: [PATCH v2] usb: core: adds support for PM control of specific USB dev skip suspend.
Date: Tue, 22 Oct 2024 15:33:22 +0800
Message-Id: <20241022073322.6150-1-huanglei814@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:sigvCgDnarZIVRdnVxPcBA--.35035S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuryxKw4DJryUAr45CrWruFg_yoWrJr1xpF
	4qyFWYkrsxGr1Iq34aya18uF1rWanYkayjk3sakw1Ygw17J395Gr1jyFy5Xwnxur9xAFyU
	tFsrG3yUCrW7GFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UvsjnUUUUU=
X-CM-SenderInfo: xkxd0wxohlmiqu6rljoofrz/1tbixwiA9mcXTTLP1AAAst
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


