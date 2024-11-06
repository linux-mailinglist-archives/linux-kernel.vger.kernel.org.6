Return-Path: <linux-kernel+bounces-397828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 747BB9BE11D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 09:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9798C1C23361
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 08:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB631D514B;
	Wed,  6 Nov 2024 08:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Or3QXsTW"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59331D79A4
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 08:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730882140; cv=none; b=Z3XrD8gJcMMwkN+h+rxB1vsl/0/0VtcyT9AVybsQHOxVvvJNg+DriSxgh6u0SpEoS9kzczqvB+CY3XtucdsHNi4x61px7dDVNDZpvPdwA5L3LjtQQz5rfUKn0oWVWmFHeSwrPUJaidTQz0l0w8E+ktZ9IW2go14ujNUYqcC0K1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730882140; c=relaxed/simple;
	bh=JqrI/y417lO2lfXhgkqQF0tA66aDyMukgTr/nW0zek4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dihxBI/3X13LK85PjNZK2JMs6zFO4wbjWgEUbGBXLdL+wbiKy+se/uAVd5e9JYJUCwIpwRrIznftOZRsuYfPEmc633I7OfqnmDoEqmszhA15rpKEPQiXxI2M27EDcOmUN2XhcXFJWkUMIkZ+ZYga4EDFtyLTl6Ga3Y4m6uD87G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--guanyulin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Or3QXsTW; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--guanyulin.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e35a643200so115692047b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 00:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730882137; x=1731486937; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=moU1umJAlwIcW6CJtpZmFEP7kB4MQYjSX3i6CUT0ojI=;
        b=Or3QXsTWeRKEM28x30Ctib6SHqH5QUGcRtVogjyNcMArO9bL+6exmgRTxkCBF835xB
         2Xy3yw08Ims3gG8Bx2TVsvmCuefF/LR9fVmHFsJnnzPq6cAyrOvuCUATcP8ktjjq0vfD
         TbjpDLAfoM/arp6S60/xSXaIJ0y5sULW3RYX3ZKd7WhlzUL4GHUblr91yClv3eRC8p3U
         +XhOJh93O1VxhrFeLZFzsnq+xw7khjMyR6K06oEDlfl5yPUNiG6OcbEbusercgGhhhOp
         SvsBAgbQhED4vBVPPB035CySi1fApOPx1Szdg8NnSR16f9aNG53nAsREo54zQAYH6vxP
         PstA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730882137; x=1731486937;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=moU1umJAlwIcW6CJtpZmFEP7kB4MQYjSX3i6CUT0ojI=;
        b=htzk6a8kFf+MsWp/0bp7kdBayYzX9bQll3isyjRgNmb+iTFZbIgudjmapo2GG9tLka
         cwHTgU5LcGN2kwAvAFWCat0tmJcNN9PHYwQ1nl5jFrKs76GBKzkhD48hjw7oStKlSKae
         mknDOkwvZJeUhxIcLdBKpmtqgK8Kvc2czGXg/qK92kwK+W4XsKf55GKf5Zc8OQoZ3WF+
         o4pU4RJWtIOcZE+Fbz5afj9M9d4LdQ1+BhIk5rXGgKJbYgCZfQfXxHJDlIn3uT1Dg46V
         xGpzTcYuRYBFxfuj6DN+4GzjX7zNdTZJZKoKkysloYVFl6g3BYIEvaQRWr44kH3ZHa75
         INlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXb4Z+5F/tEKe7troLsSwoui9wgXlFTqlumvoKjgt+VkuQYIZA2BcIOtrgPXeTPyY9o90J2f6Ec7+JUmKM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyu66+eu37KbnMp1nQtZnQnt3pHzVCRqmx9TDo4aGMJVLqX65S
	KAAQVVuzKNd7QTYbSGjPM0YVg2zn0M1Xcc83Ro17LWAJE4sXela+aSITt545yoe8aQjQhlCk+cT
	r/Y1H9ML16WFN2Q==
X-Google-Smtp-Source: AGHT+IFQFnkuCf/v6ladehVoYM1WJRWgfBTSx9mlAsCcKpaQ0AKHa0ncYilNBiCFgL2E3rDcTyqyBpTqWkJJUvQ=
X-Received: from guanyulin.c.googlers.com ([fda3:e722:ac3:cc00:131:cd17:ac11:19c7])
 (user=guanyulin job=sendgmr) by 2002:a05:690c:6481:b0:6de:19f:34d7 with SMTP
 id 00721157ae682-6ea5231763cmr1418007b3.2.1730882136853; Wed, 06 Nov 2024
 00:35:36 -0800 (PST)
Date: Wed,  6 Nov 2024 08:32:58 +0000
In-Reply-To: <20241106083501.408074-1-guanyulin@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241106083501.408074-1-guanyulin@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241106083501.408074-5-guanyulin@google.com>
Subject: [PATCH v6 4/5] xhci: sideband: add api to trace sideband usage
From: Guan-Yu Lin <guanyulin@google.com>
To: gregkh@linuxfoundation.org, Thinh.Nguyen@synopsys.com, 
	mathias.nyman@intel.com, stern@rowland.harvard.edu, sumit.garg@linaro.org, 
	dianders@chromium.org, kekrby@gmail.com, oneukum@suse.com, 
	yajun.deng@linux.dev, niko.mauno@vaisala.com, christophe.jaillet@wanadoo.fr, 
	tj@kernel.org, stanley_chang@realtek.com, andreyknvl@gmail.com, 
	quic_jjohnson@quicinc.com, ricardo@marliere.net
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Guan-Yu Lin <guanyulin@google.com>
Content-Type: text/plain; charset="UTF-8"

The existing sideband driver only registers sidebands without tracking
their active usage. To address this, new apis are introduced to:
- mark sideband usage: record the sideband usage information in the USB
  host controller driver and USB device driver.
- query sideband status: provide a means for other drivers to fetch
  sideband activity information on a USB host controller.

Signed-off-by: Guan-Yu Lin <guanyulin@google.com>
---
 drivers/usb/core/hcd.c            |  4 ++
 drivers/usb/host/xhci-sideband.c  | 92 +++++++++++++++++++++++++++++++
 include/linux/usb/hcd.h           |  6 ++
 include/linux/usb/xhci-sideband.h |  5 ++
 4 files changed, 107 insertions(+)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 1ff7d901fede..6aca6c69bf74 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -2595,6 +2595,10 @@ struct usb_hcd *__usb_create_hcd(const struct hc_driver *driver,
 	INIT_WORK(&hcd->wakeup_work, hcd_resume_work);
 #endif
 
+#ifdef CONFIG_USB_XHCI_SIDEBAND
+	refcount_set(&hcd->sb_usage_count, 0);
+#endif
+
 	INIT_WORK(&hcd->died_work, hcd_died_work);
 
 	hcd->driver = driver;
diff --git a/drivers/usb/host/xhci-sideband.c b/drivers/usb/host/xhci-sideband.c
index d04cf0af57ae..bd0fc1564052 100644
--- a/drivers/usb/host/xhci-sideband.c
+++ b/drivers/usb/host/xhci-sideband.c
@@ -334,6 +334,98 @@ xhci_sideband_interrupter_id(struct xhci_sideband *sb)
 }
 EXPORT_SYMBOL_GPL(xhci_sideband_interrupter_id);
 
+/**
+ * xhci_sideband_get - inform related drivers there's a new active sideband
+ * @sb: sideband instance for this usb device
+ *
+ * An active sideband indicates that another entity is currently using the host
+ * controller. Inform the host controller and related usb devices by increasing
+ * their sb_usage_count. This allows the corresponding drivers to dynamically
+ * adjust power management actions based on current sideband activity.
+ *
+ * Returns 0 on success, negative error otherwise
+ */
+int xhci_sideband_get(struct xhci_sideband *sb)
+{
+	struct usb_device *udev;
+	struct usb_hcd *hcd;
+	int ret;
+
+	if (!sb || !sb->xhci)
+		return -ENODEV;
+
+	hcd = xhci_to_hcd(sb->xhci);
+	refcount_inc(&hcd->sb_usage_count);
+
+	udev = sb->vdev->udev;
+
+	device_lock(&udev->dev);
+	ret = usb_sideband_get(udev);
+	device_unlock(&udev->dev);
+
+	if (ret) {
+		refcount_dec(&hcd->sb_usage_count);
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(xhci_sideband_get);
+
+/**
+ * xhci_sideband_put - inform related drivers there's a sideband deactivated
+ * @sb: sideband instance for this usb device
+ *
+ * The inverse operation of xhci_sideband_get, which informs the host
+ * controller and related usb devices by decreasing their sb_usage_count. This
+ * allows the corresponding drivers to dynamically adjust power management
+ * actions based on current sideband activity.
+ *
+ * Returns 0 on success, negative error otherwise
+ */
+int xhci_sideband_put(struct xhci_sideband *sb)
+{
+	struct usb_device *udev;
+	struct usb_hcd *hcd;
+	int ret;
+
+	if (!sb || !sb->xhci)
+		return -ENODEV;
+
+	hcd = xhci_to_hcd(sb->xhci);
+	refcount_dec(&hcd->sb_usage_count);
+
+	udev = sb->vdev->udev;
+
+	device_lock(&udev->dev);
+	ret = usb_sideband_put(udev);
+	device_unlock(&udev->dev);
+
+	if (ret) {
+		refcount_inc(&hcd->sb_usage_count);
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(xhci_sideband_put);
+
+/**
+ * xhci_sideband_check - check sideband activities on the host controller
+ * @hcd: the host controller driver associated with the target host controller
+ *
+ * Allow other drivers, such as usb controller driver, to check if there are
+ * any sideband activity on the host controller right now. This information
+ * could be used for power management or other forms or resource management.
+ *
+ * Returns true on any active sideband existence, false otherwise
+ */
+bool xhci_sideband_check(struct usb_hcd *hcd)
+{
+	return !!refcount_read(&hcd->sb_usage_count);
+}
+EXPORT_SYMBOL_GPL(xhci_sideband_check);
+
 /**
  * xhci_sideband_register - register a sideband for a usb device
  * @udev: usb device to be accessed via sideband
diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
index ac95e7c89df5..9867c178d188 100644
--- a/include/linux/usb/hcd.h
+++ b/include/linux/usb/hcd.h
@@ -85,6 +85,12 @@ struct usb_hcd {
 #ifdef CONFIG_PM
 	struct work_struct	wakeup_work;	/* for remote wakeup */
 #endif
+
+#ifdef CONFIG_USB_XHCI_SIDEBAND
+	/* Number of active sideband accessing the host controller. */
+	refcount_t		sb_usage_count;
+#endif
+
 	struct work_struct	died_work;	/* for when the device dies */
 
 	/*
diff --git a/include/linux/usb/xhci-sideband.h b/include/linux/usb/xhci-sideband.h
index f0223c5535e0..4850fc826e00 100644
--- a/include/linux/usb/xhci-sideband.h
+++ b/include/linux/usb/xhci-sideband.h
@@ -12,6 +12,7 @@
 
 #include <linux/scatterlist.h>
 #include <linux/usb.h>
+#include <linux/usb/hcd.h>
 
 #define	EP_CTX_PER_DEV		31	/* FIXME defined twice, from xhci.h */
 
@@ -57,6 +58,10 @@ xhci_sideband_get_endpoint_buffer(struct xhci_sideband *sb,
 struct sg_table *
 xhci_sideband_get_event_buffer(struct xhci_sideband *sb);
 
+int xhci_sideband_get(struct xhci_sideband *sb);
+int xhci_sideband_put(struct xhci_sideband *sb);
+bool xhci_sideband_check(struct usb_hcd *hcd);
+
 int
 xhci_sideband_create_interrupter(struct xhci_sideband *sb, int num_seg,
 				 bool ip_autoclear, u32 imod_interval, int intr_num);
-- 
2.47.0.199.ga7371fff76-goog


