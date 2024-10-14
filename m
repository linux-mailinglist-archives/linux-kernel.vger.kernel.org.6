Return-Path: <linux-kernel+bounces-363596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 014EE99C47E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 249F81C22C46
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8160616130B;
	Mon, 14 Oct 2024 08:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J1qAmHHC"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF1E155C98
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 08:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728896338; cv=none; b=mpbuUZowx1yMZ9aFuDBUSvc+6mvoLWTMq/2g+cSAw7kDdMeOJ6pM9sASlPOD1ApbIwF0YivMSAnFfevLZW+SDoP65vYe95Xsm09hc41YW3DtQlnodIBePY3moayqQpmxG5WwOHYE0j9A3bgLbCFvxxXLaXmuRfXJ1Untee6lBWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728896338; c=relaxed/simple;
	bh=gwBxetmHAUs6dpF8OWOjFANRyC9Za3R8kPrSPs0nUDc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F3wGOXrYdS0jTdFxGatpuowSUEoc1vpYFp86jIEUAqKSkXNy6SjHtVjSudKGeSJAe6NO4JK54/NvG3xjMMO/gM8KLX7up8VmAk1RByedYUXX/s47PYx1l7eu9+MSpf00k6OC5opKziQpcpgoJ1Ym4y9wrmydIBAHcA/uK6mzlf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--guanyulin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J1qAmHHC; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--guanyulin.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e2605ce4276so6970532276.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 01:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728896336; x=1729501136; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6y7M/9jWGeDkCGLYRuLSMJUH16Au0fuqCfkifg79sVM=;
        b=J1qAmHHCiJFaH4fnfBwsmBmxMg9/7ininbnEjPznkTu1oJQ+abrO+D0Y6ellY3OqcL
         VWZggXSrzH6aULJxqzommvsH5q9s0KXsloO194I/QQSTqMzuqYRyMjLdFqWlKjj84fLQ
         Bs6PRPr3IOWdZajnh7eqcOoc1PtU2yXWA7DDeoQo5/9VpfBDfpHlV42Z3Sq9wU4Jk9gn
         N5nLxu1uifURZ6IKKBiEfGnFCDXKVzE6xmTOABAJQbyshF76VG3g1nNXUzSekqaAv2C6
         0VPHzTmwHnF5uRL4WPkckyTfgcrc1y8KY+Yg+75iS6lKnI2RJlfCylk1kAHmFpU9zWOF
         8Kfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728896336; x=1729501136;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6y7M/9jWGeDkCGLYRuLSMJUH16Au0fuqCfkifg79sVM=;
        b=jc+HLUMupzQnifrlZpQuDEj3wT4fR7G5A5prfPZiNeVmwCw4s1CJU0BpbOMla0dRqA
         wlkb5IxzjbaOxVxIXFvrr2s78z69fh5ri4+5E6B57jt7XLSKq0sUT33Ki5fyChnw2QZU
         gF3eaN+Yrqy6Gbtu6MLd7Ak9POUQYThcuvmYi3wMj6rUDNk67933yFaxcOm5/Wm/1MEH
         e+uLYaqHDd4ywscILstFnxznUxrBTEXJfcTYcavBSup1PoGsRZ1CFiDHfghj7plN/iYX
         qV6mNljpHPZeIztwSd1Kk0ga59PwMvz7IqHhFsv9Y9vKyEHwUeaGJhwxYpgFVN821ITl
         Ekgw==
X-Forwarded-Encrypted: i=1; AJvYcCX/7N7IjDcTLlA+0tq5cr8YYNweRZ417P3KgXy4z0qDbACiqs7vV3pUsI4qtmWAhFHkCH6Eu7mEO5JGoPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPBhYbnypTLrOvhI7tvu0++F4TMAxRNzRL/E1XkkmnKP/616dD
	YUR73FL4ut9kTmLaPL2y/B11qZ43j7Avnt0Ahz+WovM71xY7guTGtTKGBzS8eJ67YtE4fZOitNb
	IRvTiAbR9B+HbdQ==
X-Google-Smtp-Source: AGHT+IGuAVHy2wuJJSYKKNO9RPkGqP4RolspviXlmTe441Amv5yytcCNW+/6FnAEGZYrCIN0X9y14RK49kCdPM4=
X-Received: from guanyulin.c.googlers.com ([fda3:e722:ac3:cc00:131:cd17:ac11:19c7])
 (user=guanyulin job=sendgmr) by 2002:a25:8702:0:b0:e29:1864:5215 with SMTP id
 3f1490d57ef6-e2919dbd114mr7115276.1.1728896336194; Mon, 14 Oct 2024 01:58:56
 -0700 (PDT)
Date: Mon, 14 Oct 2024 08:50:29 +0000
In-Reply-To: <20241014085816.1401364-1-guanyulin@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241014085816.1401364-1-guanyulin@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241014085816.1401364-6-guanyulin@google.com>
Subject: [PATCH v5 5/5] usb: host: enable sideband transfer during system sleep
From: Guan-Yu Lin <guanyulin@google.com>
To: Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org, 
	mathias.nyman@intel.com, stern@rowland.harvard.edu, yajun.deng@linux.dev, 
	sumit.garg@linaro.org, kekrby@gmail.com, oneukum@suse.com, 
	dianders@chromium.org, perex@perex.cz, tiwai@suse.com, niko.mauno@vaisala.com, 
	andreyknvl@gmail.com, christophe.jaillet@wanadoo.fr, tj@kernel.org, 
	stanley_chang@realtek.com, quic_jjohnson@quicinc.com, ricardo@marliere.net
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-sound@vger.kernel.org, badhri@google.com, albertccwang@google.com, 
	quic_wcheng@quicinc.com, pumahsu@google.com, 
	Guan-Yu Lin <guanyulin@google.com>
Content-Type: text/plain; charset="UTF-8"

Sharing a USB controller with another entity via xhci-sideband driver
creates power management complexities. To prevent the USB controller
from being inadvertently deactivated while in use by the other entity, a
usage-count based mechanism is implemented. This allows the system to
manage power effectively, ensuring the controller remains available
whenever needed.

Signed-off-by: Guan-Yu Lin <guanyulin@google.com>
---
 drivers/usb/core/driver.c         | 10 ++++++++++
 drivers/usb/core/hcd.c            |  1 +
 drivers/usb/core/usb.c            |  1 +
 drivers/usb/dwc3/core.c           | 13 +++++++++++++
 drivers/usb/dwc3/core.h           |  8 ++++++++
 drivers/usb/host/xhci-plat.c      | 10 ++++++++++
 drivers/usb/host/xhci-plat.h      |  7 +++++++
 sound/usb/qcom/qc_audio_offload.c |  3 +++
 8 files changed, 53 insertions(+)

diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index e713cf9b3dd2..eb85cbb1a2ff 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -1583,6 +1583,11 @@ int usb_suspend(struct device *dev, pm_message_t msg)
 	struct usb_device	*udev = to_usb_device(dev);
 	int r;
 
+	if (msg.event == PM_EVENT_SUSPEND && usb_sideband_check(udev)) {
+		dev_dbg(dev, "device accessed via sideband\n");
+		return 0;
+	}
+
 	unbind_no_pm_drivers_interfaces(udev);
 
 	/* From now on we are sure all drivers support suspend/resume
@@ -1619,6 +1624,11 @@ int usb_resume(struct device *dev, pm_message_t msg)
 	struct usb_device	*udev = to_usb_device(dev);
 	int			status;
 
+	if (msg.event == PM_EVENT_RESUME && usb_sideband_check(udev)) {
+		dev_dbg(dev, "device accessed via sideband\n");
+		return 0;
+	}
+
 	/* For all calls, take the device back to full power and
 	 * tell the PM core in case it was autosuspended previously.
 	 * Unbind the interfaces that will need rebinding later,
diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 1ff7d901fede..9876b3940281 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -2593,6 +2593,7 @@ struct usb_hcd *__usb_create_hcd(const struct hc_driver *driver,
 	timer_setup(&hcd->rh_timer, rh_timer_func, 0);
 #ifdef CONFIG_PM
 	INIT_WORK(&hcd->wakeup_work, hcd_resume_work);
+	refcount_set(&hcd->sb_usage_count, 0);
 #endif
 
 	INIT_WORK(&hcd->died_work, hcd_died_work);
diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
index 0b4685aad2d5..d315d066a56b 100644
--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -671,6 +671,7 @@ struct usb_device *usb_alloc_dev(struct usb_device *parent,
 	dev->state = USB_STATE_ATTACHED;
 	dev->lpm_disable_count = 1;
 	atomic_set(&dev->urbnum, 0);
+	refcount_set(&dev->sb_usage_count, 0);
 
 	INIT_LIST_HEAD(&dev->ep0.urb_list);
 	dev->ep0.desc.bLength = USB_DT_ENDPOINT_SIZE;
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 2fdafbcbe44c..18c743ce5ac5 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -2550,8 +2550,15 @@ static int dwc3_runtime_idle(struct device *dev)
 static int dwc3_suspend(struct device *dev)
 {
 	struct dwc3	*dwc = dev_get_drvdata(dev);
+	struct platform_device *xhci = dwc->xhci;
 	int		ret;
 
+	if (xhci && xhci_sideband_check(xhci->dev.driver_data)) {
+		dev_dbg(dev, "device accessed via sideband\n");
+		return 0;
+	}
+
+
 	ret = dwc3_suspend_common(dwc, PMSG_SUSPEND);
 	if (ret)
 		return ret;
@@ -2564,8 +2571,14 @@ static int dwc3_suspend(struct device *dev)
 static int dwc3_resume(struct device *dev)
 {
 	struct dwc3	*dwc = dev_get_drvdata(dev);
+	struct platform_device *xhci = dwc->xhci;
 	int		ret;
 
+	if (xhci && xhci_sideband_check(xhci->dev.driver_data)) {
+		dev_dbg(dev, "device accessed via sideband\n");
+		return 0;
+	}
+
 	pinctrl_pm_select_default_state(dev);
 
 	pm_runtime_disable(dev);
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 80047d0df179..e06d597ee3b0 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -26,6 +26,7 @@
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
 #include <linux/usb/otg.h>
+#include <linux/usb/hcd.h>
 #include <linux/usb/role.h>
 #include <linux/ulpi/interface.h>
 
@@ -1704,4 +1705,11 @@ static inline void dwc3_ulpi_exit(struct dwc3 *dwc)
 { }
 #endif
 
+#if IS_ENABLED(CONFIG_USB_XHCI_SIDEBAND)
+extern bool xhci_sideband_check(struct usb_hcd *hcd);
+#else
+static inline bool xhci_sideband_check(struct usb_hcd *hcd)
+{ return false; }
+#endif
+
 #endif /* __DRIVERS_USB_DWC3_CORE_H */
diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 6e49ef1908eb..5fdbdf0c7f1a 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -456,6 +456,11 @@ static int xhci_plat_suspend_common(struct device *dev, struct pm_message pmsg)
 	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
 	int ret;
 
+	if (pmsg.event == PM_EVENT_SUSPEND && xhci_sideband_check(hcd)) {
+		dev_dbg(dev, "device accessed via sideband\n");
+		return 0;
+	}
+
 	if (pm_runtime_suspended(dev))
 		pm_runtime_resume(dev);
 
@@ -499,6 +504,11 @@ static int xhci_plat_resume_common(struct device *dev, struct pm_message pmsg)
 	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
 	int ret;
 
+	if (pmsg.event == PM_EVENT_RESUME && xhci_sideband_check(hcd)) {
+		dev_dbg(dev, "device accessed via sideband\n");
+		return 0;
+	}
+
 	if (!device_may_wakeup(dev) && (xhci->quirks & XHCI_SUSPEND_RESUME_CLKS)) {
 		ret = clk_prepare_enable(xhci->clk);
 		if (ret)
diff --git a/drivers/usb/host/xhci-plat.h b/drivers/usb/host/xhci-plat.h
index 6475130eac4b..432a040c81e5 100644
--- a/drivers/usb/host/xhci-plat.h
+++ b/drivers/usb/host/xhci-plat.h
@@ -30,4 +30,11 @@ int xhci_plat_probe(struct platform_device *pdev, struct device *sysdev,
 void xhci_plat_remove(struct platform_device *dev);
 extern const struct dev_pm_ops xhci_plat_pm_ops;
 
+#if IS_ENABLED(CONFIG_USB_XHCI_SIDEBAND)
+extern bool xhci_sideband_check(struct usb_hcd *hcd);
+#else
+static inline bool xhci_sideband_check(struct usb_hcd *hcd)
+{ return false; }
+#endif
+
 #endif	/* _XHCI_PLAT_H */
diff --git a/sound/usb/qcom/qc_audio_offload.c b/sound/usb/qcom/qc_audio_offload.c
index 2dc651cd3d05..c82b5dbef2d7 100644
--- a/sound/usb/qcom/qc_audio_offload.c
+++ b/sound/usb/qcom/qc_audio_offload.c
@@ -1516,8 +1516,11 @@ static void handle_uaudio_stream_req(struct qmi_handle *handle,
 			mutex_lock(&chip->mutex);
 			subs->opened = 0;
 			mutex_unlock(&chip->mutex);
+		} else {
+			xhci_sideband_get(uadev[pcm_card_num].sb);
 		}
 	} else {
+		xhci_sideband_put(uadev[pcm_card_num].sb);
 		info = &uadev[pcm_card_num].info[info_idx];
 		if (info->data_ep_pipe) {
 			ep = usb_pipe_endpoint(uadev[pcm_card_num].udev,
-- 
2.47.0.rc1.288.g06298d1525-goog


