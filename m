Return-Path: <linux-kernel+bounces-377277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA96B9ABC64
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 05:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6310B284998
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 03:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1ADB13698E;
	Wed, 23 Oct 2024 03:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="o6CCnoHG"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DD520323;
	Wed, 23 Oct 2024 03:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729655131; cv=none; b=QL4H4GUjJ6KQm5lgXI2vz3l/WnleuweE9ufj65ow/TL5QKLeEdJ8nboyloNn2a/LvYAvfxRzknr2w30OgZ9OUem7JYJDxENHSeGXCE2h+PEiPBC1gpwC4UQzHF+UQHx7Y4SuG9bCoqyrcf29m65ZBwzL/uoR/OP2/xmkSJRmjeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729655131; c=relaxed/simple;
	bh=ECzsDGr6vFEVPn6aqoqG+EAoMOQpMKvdM8XgMq02btM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ncmXduJGzE83BuoXAaFr/4JGatc/HlHZ0v33XpJFNKAcpneI9jr99I+UKopONTSGitztW4ED7uWSPM+D3diq9qEOUVyiz1tJiZ/7nkrQIcKawUBDlkZwbqmmzAlPVJJxYSHlcu7PLRBR4FxiGxDIQQzzDRJM1V/2UOVL/T8kMEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=o6CCnoHG; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=aUZrrWFwQHgv9+Ik6AodjN8Lu6pe2mDlXP06fCRQf8o=;
	b=o6CCnoHG25vWrQgWFAmadUJpTKaR+hVuw0THMpa9gKv7uEqqqIn/GX2SwXXYxj
	W3sLU5M2/U5RrP5iNW+JvZGQswgM2pO44+5kcQrHtpzRqHhlNDZnexPVMrBELJSa
	ntBd0S2kUqmOJsx6YUPeUFV5GJwwwxNd3/qFhkjhAKfcY=
Received: from localhost.localdomain (unknown [111.48.58.10])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wCn7zs6cRhnIERGCw--.47310S2;
	Wed, 23 Oct 2024 11:44:59 +0800 (CST)
From: huanglei814 <huanglei814@163.com>
To: gregkh@linuxfoundation.org,
	mathias.nyman@intel.com
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	huanglei <huanglei@kylinos.cn>
Subject: [PATCH v4] usb: core: adds support for PM control of specific USB dev skip suspend.
Date: Wed, 23 Oct 2024 11:44:57 +0800
Message-Id: <20241023034457.13241-1-huanglei814@163.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCn7zs6cRhnIERGCw--.47310S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuryfZr48XFyDJw4DZw1DJrb_yoW5CFy8pF
	4qyFW5Krs8Gr1I9wnFk3W8ZFn5Ww4Fkayjk3sakw1Ygw17J3s5Kw4ktF15uws3uryfAF17
	tF47K3y5CFW7WFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UPcTdUUUUU=
X-CM-SenderInfo: xkxd0wxohlmiqu6rljoofrz/1tbi7guB9mcYbWFoeAAAsx

From: huanglei <huanglei@kylinos.cn>

All USB devices are brought into suspend power state after system suspend.
It is desirable for some specific manufacturers buses to keep their devices
in normal state even after system suspend.

Signed-off-by: huanglei <huanglei@kylinos.cn>
---
v3->v4:
- Cancel SUSPENDED state judgment when enter suspend，because udev will not enter.
- Change "usb-skip-suspend" to "usb-never-suspend"
- Change dev_err to dev_info.
- Remove Kconfig option, it's redundant indeed.
- Update commit message style.
v2->v3:
- Rebase and update commit message.
v1->v2:
- Change to bool type for skip_suspend.
- Kconfig remove "default n", 'n' is the default.
---
 drivers/usb/core/driver.c    | 8 ++++++++
 drivers/usb/host/xhci-plat.c | 5 +++++
 include/linux/usb.h          | 7 +++++++
 3 files changed, 20 insertions(+)

diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index 0c3f12daac79..93137c7c34df 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -1583,6 +1583,11 @@ int usb_suspend(struct device *dev, pm_message_t msg)
 	struct usb_device	*udev = to_usb_device(dev);
 	int r;
 
+	if (udev->bus->skip_suspend && (msg.event == PM_EVENT_SUSPEND)) {
+		dev_info(dev, "abort suspend\n");
+		return 0;
+	}
+
 	unbind_no_pm_drivers_interfaces(udev);
 
 	/* From now on we are sure all drivers support suspend/resume
@@ -1619,6 +1624,9 @@ int usb_resume(struct device *dev, pm_message_t msg)
 	struct usb_device	*udev = to_usb_device(dev);
 	int			status;
 
+	if (udev->bus->skip_suspend && (msg.event == PM_EVENT_RESUME))
+		return 0;
+
 	/* For all calls, take the device back to full power and
 	 * tell the PM core in case it was autosuspended previously.
 	 * Unbind the interfaces that will need rebinding later,
diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index ecaa75718e59..35062aa19a32 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -265,6 +265,11 @@ int xhci_plat_probe(struct platform_device *pdev, struct device *sysdev, const s
 		if (device_property_read_bool(tmpdev, "xhci-skip-phy-init-quirk"))
 			xhci->quirks |= XHCI_SKIP_PHY_INIT;
 
+		if (device_property_read_bool(tmpdev, "usb-never-suspend")) {
+			hcd_to_bus(hcd)->skip_suspend = true;
+			hcd_to_bus(xhci->shared_hcd)->skip_suspend = true;
+		}
+
 		device_property_read_u32(tmpdev, "imod-interval-ns",
 					 &xhci->imod_interval);
 	}
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 672d8fc2abdb..c854d1f622ec 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -487,6 +487,13 @@ struct usb_bus {
 	struct mon_bus *mon_bus;	/* non-null when associated */
 	int monitored;			/* non-zero when monitored */
 #endif
+
+	bool skip_suspend;		/* All USB devices are brought into suspend
+					 * power state after system suspend. It is
+					 * desirable for some specific manufacturers
+					 * buses to keep their devices in normal
+					 * state even after system suspend.
+					 */
 };
 
 struct usb_dev_state;
-- 
2.17.1


