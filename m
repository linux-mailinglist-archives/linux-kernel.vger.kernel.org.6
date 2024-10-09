Return-Path: <linux-kernel+bounces-356299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F595995F34
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 07:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F35371F24382
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 05:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4788917C22B;
	Wed,  9 Oct 2024 05:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BzPZNA0V"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AF11714C0
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 05:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728452757; cv=none; b=o8u95oTUuRnQStT2clBxPF5ZzVU00PsfNYC5Awvc5XBkzOp+yMCZKw3FH1YuCNyLLinj6TRdt+u4uJTY7IZBwhr1Ut9zqBwXB8yp9T/xhUatdeQZGssjcAkG0NhV5zPg+KBsuHKCjHlfwgL7nAhibAwMGXFsLXkSfzi0znSyy+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728452757; c=relaxed/simple;
	bh=7HdoGuIpVxIApwBZjbGWPc3lYhLTnwpC2A1CyC1PnpE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fHTZZt917JReVrjp/cci1KjdnWgGX8P/dUQoG0KZRlRo8Zi9Ml3GP8wFYEIKAFkz9HfCzOkRp4B7fqME/U8pd6E4Q8O+iDTT/LthH1oHEfk7LOodqEsTOImhkbNqMTqwan2DCGx0GloEQ4DSAgV5qqtHDT+6p6ZOyNki1suqqMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--guanyulin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BzPZNA0V; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--guanyulin.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e23ee3110fso118831637b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 22:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728452755; x=1729057555; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LS06mvVrFt6iBWJCEDFo5gcybGkFQKBBqdvmqbXJwpc=;
        b=BzPZNA0VSMSLROIZersAJ6lOS0zfvteDQlm7dHe61hMXzPNDuioZzddwHF4qN09vjK
         9/vhuVBvV9soN1oeJb4db3dVDBBoXxijx/JE4kk+Ialrm4VCu7w3XxtSXC7IqKN9LGZF
         9l+/quvg3u9iJ+TX/fZZpo4NvoFmRJgMn112mNkcg4B0RoqwaeH5tZpPpjeuTwDrPp6p
         CWbIa2DN0b3sDhbeNF8qJr/ygiemqRUaynMtSthiN3EAAnMC5iRZ/WxKOxBjc3Ajt9SN
         1QIv8xYXXptCV6KgjIZ7RAhSSOC304G8WhlWhdFqqcUeaHbxHuV9musv06J/TPAjr/g8
         dAZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728452755; x=1729057555;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LS06mvVrFt6iBWJCEDFo5gcybGkFQKBBqdvmqbXJwpc=;
        b=afNR0OOhvBSnjRUH8L7Jeop2Q0igmxxsvKCYiqtJvzR3oAxlMSorfcW69dauRXAH0C
         CDEOF5n7gu9FNr9rqasTgdtzRLDCnYFnBLirMmU9ra13EC/qO4W/RJ2v1yQxx9dqLXRM
         d0/BXWkKzQdF5GByUCPSApHRrc+1UHQlIFfB9tuLi7VhRWe2SI/WF7o1Qv5W5IpTEiuM
         zxr656L5Q8VgJcAYcWaDmjfbiFVmbk6GyBF7yif5a0gMi7wy6qJ5D+Z/3JB0N9bkOQHz
         8ut81XyJwV/2RtsDj56qMf6eriW8oVnn8KPI5Jrfc5lDPL+FZnCF71a9bxc6t+20lN2a
         GJng==
X-Forwarded-Encrypted: i=1; AJvYcCVVdnlE1QqWT5WTcQqFryivqQb3BP7gj1WtVRFcJUGL5vhhhvxgmOZVWelJmitxh/O+kHXl2/hiuuql1fg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD3x48rDxAhPI01KM6luRtQER7XdSy85Ezyiax2bqlYInTk7BY
	kZKEM+aBDop8EvVhbK7bHsOGAJeSO5U9EcqDC0ZKza33QVhThJsvlodQJME9PTqg3ZXkXrM43F3
	OiP//ddtJ8Y3/7A==
X-Google-Smtp-Source: AGHT+IFmkWe5tDIFIeZ1czp1l1p3rAeg8htxrsKU7F9YBCSNh/yAgAeAVRTulxMkSVrE0E5lAU+yh0O4nmn/cTg=
X-Received: from guanyulin.c.googlers.com ([fda3:e722:ac3:cc00:131:cd17:ac11:19c7])
 (user=guanyulin job=sendgmr) by 2002:a05:690c:2a82:b0:6a9:3d52:79e9 with SMTP
 id 00721157ae682-6e322150753mr186647b3.4.1728452754886; Tue, 08 Oct 2024
 22:45:54 -0700 (PDT)
Date: Wed,  9 Oct 2024 05:42:59 +0000
In-Reply-To: <20241009054429.3970438-1-guanyulin@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241009054429.3970438-1-guanyulin@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241009054429.3970438-6-guanyulin@google.com>
Subject: [PATCH v4 5/5] usb: host: enable sideband transfer during system sleep
From: Guan-Yu Lin <guanyulin@google.com>
To: Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org, 
	mathias.nyman@intel.com, stern@rowland.harvard.edu, elder@kernel.org, 
	oneukum@suse.com, yajun.deng@linux.dev, dianders@chromium.org, 
	kekrby@gmail.com, perex@perex.cz, tiwai@suse.com, tj@kernel.org, 
	stanley_chang@realtek.com, andreyknvl@gmail.com, 
	christophe.jaillet@wanadoo.fr, quic_jjohnson@quicinc.com, 
	ricardo@marliere.net, grundler@chromium.org, niko.mauno@vaisala.com
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
index c1ba5ed15214..83726bf88fb6 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -1583,6 +1583,11 @@ int usb_suspend(struct device *dev, pm_message_t msg)
 	struct usb_device	*udev = to_usb_device(dev);
 	int r;
 
+	if (msg.event == PM_EVENT_SUSPEND && usb_sideband_check(udev)) {
+		dev_info(dev, "device active, skip %s", __func__);
+		return 0;
+	}
+
 	unbind_no_pm_drivers_interfaces(udev);
 
 	/* From now on we are sure all drivers support suspend/resume
@@ -1619,6 +1624,11 @@ int usb_resume(struct device *dev, pm_message_t msg)
 	struct usb_device	*udev = to_usb_device(dev);
 	int			status;
 
+	if (msg.event == PM_EVENT_RESUME && usb_sideband_check(udev)) {
+		dev_info(dev, "device active, skip %s", __func__);
+		return 0;
+	}
+
 	/* For all calls, take the device back to full power and
 	 * tell the PM core in case it was autosuspended previously.
 	 * Unbind the interfaces that will need rebinding later,
diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 1ff7d901fede..a41f1fa425bd 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -2593,6 +2593,7 @@ struct usb_hcd *__usb_create_hcd(const struct hc_driver *driver,
 	timer_setup(&hcd->rh_timer, rh_timer_func, 0);
 #ifdef CONFIG_PM
 	INIT_WORK(&hcd->wakeup_work, hcd_resume_work);
+	atomic_set(&hcd->sb_usage_count, 0);
 #endif
 
 	INIT_WORK(&hcd->died_work, hcd_died_work);
diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
index 0b4685aad2d5..69fbbc6f865f 100644
--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -671,6 +671,7 @@ struct usb_device *usb_alloc_dev(struct usb_device *parent,
 	dev->state = USB_STATE_ATTACHED;
 	dev->lpm_disable_count = 1;
 	atomic_set(&dev->urbnum, 0);
+	atomic_set(&dev->sb_usage_count, 0);
 
 	INIT_LIST_HEAD(&dev->ep0.urb_list);
 	dev->ep0.desc.bLength = USB_DT_ENDPOINT_SIZE;
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 2fdafbcbe44c..d1ad817ff564 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -2550,8 +2550,15 @@ static int dwc3_runtime_idle(struct device *dev)
 static int dwc3_suspend(struct device *dev)
 {
 	struct dwc3	*dwc = dev_get_drvdata(dev);
+	struct platform_device *xhci = dwc->xhci;
 	int		ret;
 
+	if (xhci && xhci_sideband_check(xhci->dev.driver_data)) {
+		dev_info(dev, "device active, skip %s", __func__);
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
+		dev_info(dev, "device active, skip %s", __func__);
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
index 6e49ef1908eb..b730320df70d 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -456,6 +456,11 @@ static int xhci_plat_suspend_common(struct device *dev, struct pm_message pmsg)
 	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
 	int ret;
 
+	if (pmsg.event == PM_EVENT_SUSPEND && xhci_sideband_check(hcd)) {
+		dev_info(dev, "device active, skip %s", __func__);
+		return 0;
+	}
+
 	if (pm_runtime_suspended(dev))
 		pm_runtime_resume(dev);
 
@@ -499,6 +504,11 @@ static int xhci_plat_resume_common(struct device *dev, struct pm_message pmsg)
 	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
 	int ret;
 
+	if (pmsg.event == PM_EVENT_RESUME && xhci_sideband_check(hcd)) {
+		dev_info(dev, "device active, skip %s", __func__);
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
2.47.0.rc0.187.ge670bccf7e-goog


