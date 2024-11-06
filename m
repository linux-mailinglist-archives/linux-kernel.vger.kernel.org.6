Return-Path: <linux-kernel+bounces-397827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 372E19BE11B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 09:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 596E31C23349
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 08:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FDE1D619F;
	Wed,  6 Nov 2024 08:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oDuXFTYG"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31F81D79A4
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 08:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730882133; cv=none; b=utSiFSPHlsj1MqvkUnSGXHl4zoes4nJYH/GSLZ3mk2iYUcDfIYvWqLXWdgPLV1spDxrhLX35UK4NAr0YfyCx4yOgTOAKfbj7m/7ghbGVGKaSbrP9IJMknLKyV1EvgOgFAyg6bLl/LJMBe4spfR9ADyRGmr/M76DUT8IS5zL2+UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730882133; c=relaxed/simple;
	bh=B6p4p3RaVHzkY9djoERKZSs65zORZnN9q0i4fI+uKAA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I99SIXMOP8rWnqYoTxYzVFMImbtc203Z7Xqde7Om4dXuI6mlBEe6eFBu+hEGKfkDwER1VyQOgZWtuGsbtym1OdlB7Qo3wR1c2n/avVPK5pIBA7zaZlC+515eLXAZxUyW60XPPyvxN8VYNbWtONlc31vrFsi3e/vPwRSZU+XfT5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--guanyulin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oDuXFTYG; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--guanyulin.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e6101877abso120088797b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 00:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730882131; x=1731486931; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wPOkMkTQsSQ3txDdSeNseAkMjkPXkTfXXf/33SK4kew=;
        b=oDuXFTYGZyCJw1OCBSztC9i5RQu1+d0RQ43jFN8umn3ReOhbBHCf+AGCby7pir59Tp
         C5kvMcY6frGDQ5xCTgCRd/0SFpI21Oaqzw5o3BvGI1tCG2b91w+Ygi+MC4PLwxG/ECln
         k/CMkdzlNxoH8bNKhRzdtRLDQxJl+HH1nM588gVBzXdDDgrMPbZugzqWmTTsRGrY6q/o
         NxeH49PE9tfBbAxaGYMPEu9JGD+SP3K78dekW0QuSBNftGC16JeuNxOWrEziZ/vyw9PG
         ggsyDq8zStCzZiuwONdbI24sSkrseDfgQb5mMDNDleUzKp0a1/R7SINEExug9H67y6Oy
         32yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730882131; x=1731486931;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wPOkMkTQsSQ3txDdSeNseAkMjkPXkTfXXf/33SK4kew=;
        b=l7MGpW++9jGDAX3MY9dr3I/QYelngyNfZL2B0+ZXML9ngB0qaRRB2joklW0iW1Nvk4
         Yy1OwhLw3ihMaHRCiIC8zDgqPeZwQdZ8Lu1xvNfnZn1J5TiBv3WwtAOC66RcVwByLnfC
         mabYWnq1xFfZjmbmsGJq/eaxlR9ZP98cieYhTLtScZ6wjDsdG7UjyifDUvqUx7qG4jnw
         PI//69xDldomA9z1UqQB9uNX85kokiZ/Zw8FW99BDIc0QeKDU98qF2Ro6ujCwQduqIHW
         QNoo/I9s3op5zbT3+aQ2nLQnfr6wTNbzyCSjUU32SgxgHIW5mcLfLjHdUWNmY67wnMVS
         9UMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMUWf6YRvAhs4kirX9ohZ+rgiEu8h6nkyVx3fBKMiZkYR3cOMQOFlh7zS5IvworVVlavBG4LaB4kpfb+E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/Mz9qR3vvBz6tm60d6zhPgMKJhB+zFPMdLJ/vn50qBHZFtMMT
	sBDiZrnU/yS//OtQ1yM1uLrEutO7QRHSPq7MSKbcxDSzDWhng9pirl/p0WC+RbHSgdZZDX1gUdc
	5KJAEnhIckDSmiQ==
X-Google-Smtp-Source: AGHT+IHtr34MzS7WRAqT8AwaCjq3Bo2uic8Vg2HO0cH4FvuSZP7/upGi0yDH3DAk9HejDb7UKRdpuU69EuEYaUU=
X-Received: from guanyulin.c.googlers.com ([fda3:e722:ac3:cc00:131:cd17:ac11:19c7])
 (user=guanyulin job=sendgmr) by 2002:a05:690c:6482:b0:6c1:298e:5a7 with SMTP
 id 00721157ae682-6ea64bed332mr3616927b3.5.1730882130762; Wed, 06 Nov 2024
 00:35:30 -0800 (PST)
Date: Wed,  6 Nov 2024 08:32:57 +0000
In-Reply-To: <20241106083501.408074-1-guanyulin@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241106083501.408074-1-guanyulin@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241106083501.408074-4-guanyulin@google.com>
Subject: [PATCH v6 3/5] usb: add apis for sideband usage tracking
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

Introduce sb_usage_count and corresponding apis to track sideband usage
on each USB device. A sideband refers to the co-processor that accesses
the usb_device via shared control on the same USB host controller. To
optimize power usage, it's essential to monitor whether ther sideband is
actively using the USB device. This information is vital when
determining if a USB device can be safely suspended during system power
state transitions.

Signed-off-by: Guan-Yu Lin <guanyulin@google.com>
---
 drivers/usb/core/driver.c | 77 +++++++++++++++++++++++++++++++++++++++
 drivers/usb/core/usb.c    |  4 ++
 include/linux/usb.h       | 20 ++++++++++
 3 files changed, 101 insertions(+)

diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index 0c3f12daac79..e53cb4c267b3 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -2041,6 +2041,83 @@ int usb_disable_usb2_hardware_lpm(struct usb_device *udev)
 
 #endif /* CONFIG_PM */
 
+#ifdef CONFIG_USB_XHCI_SIDEBAND
+
+/**
+ * usb_sideband_get - increment the sb_usage_count of a USB device
+ * @udev: the USB device to increment its sb_usage_count
+ *
+ * Incrementing the sb_usage_count of a usb_device indicates that a sideband is
+ * currently using the device; that is, another entity is actively handling USB
+ * transfers. This information allows the USB driver to adjust its power
+ * management policy based on sideband activity.
+ *
+ * The caller must hold @udev's device lock.
+ *
+ * Return: 0 on success. A negative error code otherwise.
+ */
+int usb_sideband_get(struct usb_device *udev)
+{
+	if (udev->state == USB_STATE_NOTATTACHED ||
+			udev->state == USB_STATE_SUSPENDED)
+		return -EAGAIN;
+
+	refcount_inc(&udev->sb_usage_count);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(usb_sideband_get);
+
+/**
+ * usb_sideband_put - drop the sb_usage_count of a USB device
+ * @udev: the USB device to drop its sb_usage_count
+ *
+ * The inverse operation of usb_sideband_get, which drops the sb_usage_count of
+ * a USB device. This information allows the USB driver to adjust its power
+ * management policy based on sideband activity.
+ *
+ * The caller must hold @udev's device lock.
+ *
+ * Return: 0 on success. A negative error code otherwise.
+ */
+int usb_sideband_put(struct usb_device *udev)
+{
+	if (udev->state == USB_STATE_NOTATTACHED ||
+			udev->state == USB_STATE_SUSPENDED)
+		return -EAGAIN;
+
+	refcount_dec(&udev->sb_usage_count);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(usb_sideband_put);
+
+/**
+ * usb_sideband_check - check sideband activities on a USB device
+ * @udev: the USB device to check its sideband activity.
+ *
+ * Check if there are any sideband activity on the USB device right now. This
+ * information could be used for power management or other forms or resource
+ * management.
+ *
+ * Returns true on any active sideband existence, false otherwise
+ */
+bool usb_sideband_check(struct usb_device *udev)
+{
+	struct usb_device *child;
+	int port1;
+
+	usb_hub_for_each_child(udev, port1, child) {
+		if (usb_sideband_check(child))
+			return true;
+	}
+
+	return !!refcount_read(&udev->sb_usage_count);
+}
+EXPORT_SYMBOL_GPL(usb_sideband_check);
+
+#endif /* CONFIG_USB_XHCI_SIDEBAND */
+
 const struct bus_type usb_bus_type = {
 	.name =		"usb",
 	.match =	usb_device_match,
diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
index 0b4685aad2d5..00bb00d15875 100644
--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -672,6 +672,10 @@ struct usb_device *usb_alloc_dev(struct usb_device *parent,
 	dev->lpm_disable_count = 1;
 	atomic_set(&dev->urbnum, 0);
 
+#ifdef CONFIG_USB_XHCI_SIDEBAND
+	refcount_set(&dev->sb_usage_count, 0);
+#endif
+
 	INIT_LIST_HEAD(&dev->ep0.urb_list);
 	dev->ep0.desc.bLength = USB_DT_ENDPOINT_SIZE;
 	dev->ep0.desc.bDescriptorType = USB_DT_ENDPOINT;
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 672d8fc2abdb..c5586532cd12 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -645,6 +645,7 @@ struct usb3_lpm_parameters {
  *	parent->hub_delay + wHubDelay + tTPTransmissionDelay (40ns)
  *	Will be used as wValue for SetIsochDelay requests.
  * @use_generic_driver: ask driver core to reprobe using the generic driver.
+ * @sb_usage_count: number of active sideband accessing this usb device.
  *
  * Notes:
  * Usbcore drivers should not set usbdev->state directly.  Instead use
@@ -731,6 +732,10 @@ struct usb_device {
 
 	u16 hub_delay;
 	unsigned use_generic_driver:1;
+
+#ifdef CONFIG_USB_XHCI_SIDEBAND
+	refcount_t sb_usage_count;
+#endif
 };
 
 #define to_usb_device(__dev)	container_of_const(__dev, struct usb_device, dev)
@@ -837,6 +842,21 @@ static inline void usb_mark_last_busy(struct usb_device *udev)
 { }
 #endif
 
+#ifdef CONFIG_USB_XHCI_SIDEBAND
+extern int usb_sideband_get(struct usb_device *udev);
+extern int usb_sideband_put(struct usb_device *udev);
+extern bool usb_sideband_check(struct usb_device *udev);
+
+#else
+
+static inline int usb_sideband_get(struct usb_device *udev)
+{ return 0; }
+static inline int usb_sideband_put(struct usb_device *udev)
+{ return 0; }
+static inline bool usb_sideband_check(struct usb_device *udev)
+{ return false; }
+#endif
+
 extern int usb_disable_lpm(struct usb_device *udev);
 extern void usb_enable_lpm(struct usb_device *udev);
 /* Same as above, but these functions lock/unlock the bandwidth_mutex. */
-- 
2.47.0.199.ga7371fff76-goog


