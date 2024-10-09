Return-Path: <linux-kernel+bounces-356298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A16CF995F32
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 07:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C447E1C21F6A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 05:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDF716B3B7;
	Wed,  9 Oct 2024 05:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gWUUntEe"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E721714BF
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 05:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728452749; cv=none; b=bcFNDbinFA+LoAYvtf7Piifon9uEVHUF40hhzOpmH8wOk4AzjDshXS3IhAr3IB+Cb34b5l4Fzd+ZL52HUAkhoAK0aPgqoF6QswfyfdxHn6p8LaeEXMjuF0br+k7vWPOELciWB9D+iSNqjtYkvNCSrR9ZqKCvQBgtfpKUD6tZF1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728452749; c=relaxed/simple;
	bh=5srtWWWJT0CCdGyZ/SlfbmwGzrK8IAuxzHoQXQJMwaQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HuTQWcUQSzrbG5F+li6btmfXUvamQvrg6kVc9/FAGSafAj+wgWsIDgGIkT+KbP6QUvDmmLy4K5urWdNH53YZAcCz9UVJ8ZdBM/E4OR7+3N56pgUN/2bSwhfxvAmiueTPC41lK0p83inDEjirDu1K437nbOmWxN301i2BnU0I1t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--guanyulin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gWUUntEe; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--guanyulin.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6d9e31e66eeso117399587b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 22:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728452746; x=1729057546; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cnffki0NgArvI4HH0Kmw+XKiVaqViNFMJBPYhH1tQ6o=;
        b=gWUUntEeHDxzVfvhzYDWXpKIIy+6pIXWEjaHz0qQxQJNq/rrXzIRxNvsBugAmsVXQO
         LPXCt6q1S9ZQYpQ2+SHYbAJTrMQjT+yzbdK/8IuWtDw0KXuvhctRSNbXwLRUEhwmUK4J
         PIPG7las6Y335RVdueYQFWDQKvTfM1KtWkEBSGjkrYMerzFUAc6El9eLKgadUZg1Rvg7
         80ndV/85lRqi8/oykEd/eKl7l5UdjGgZXxAdVNLJxV287ZKphLs83CO4i2pF95WsiWhS
         WR6seBZf/U25reG8WpXqzOkNjCpgPuwSw6QW9NyU5ZXIkYI7HWyva5WIzBdPV4qNQZJ7
         avPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728452746; x=1729057546;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cnffki0NgArvI4HH0Kmw+XKiVaqViNFMJBPYhH1tQ6o=;
        b=nSCoZguWfd9syPNoG8QOece4bAtdQ0ZVS8ioQCowQLcd/pCcIhzWHrgJ5Rwx7o9g6/
         PSoDw0dPLza1y5KWNryqg6xLpxtmOXHYnecWg1ILx+BG0pNxs0crZNSIKpW3aAPVgz6h
         VjoXMOxkZgVbSv/vV5wxoONuppErYpy6eQEoUqjBHC8PhOgrM8LNtuCctvnEYkIBh3FI
         dwtUA0Rat12ZOSFIWkweWWF1FLPRvHuXikG9yVOVD7aRIwOumH2BXPmMxXlNJDoceqqI
         z126MaZ9BTJexNHxfyp1/oj6/bwOOy5eJYokjLzHJE4/3cx5BhG0llrXoyWR1A2A9xfU
         RGMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVN6HPPHD9mPThgabjIN4GgsHTEJFbCahalnQEoVVJJ0QFVC156WFjdmMezKhlaaKR3py4tIz/uEZgn7g0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4SW2ufjDlX7h2kv9C3YVPrUZa/MUeHywE+yByu3sCZNFhW6Qd
	3EF5AqD5rpUokRKPrFJefKGeuA3p603stARR38d77/XLeoEuV3dcZBCBh2YIvLHA0sbtoJTESMT
	nfyjrkC+yktGOHw==
X-Google-Smtp-Source: AGHT+IFd8anC3e6ZW3A3zIZlr7M2ZlQpEH6kwWvuRjPpLB53MAHkqwJRYm40MrjnnE4YGQBluOFK3HFoGU9Hpfg=
X-Received: from guanyulin.c.googlers.com ([fda3:e722:ac3:cc00:131:cd17:ac11:19c7])
 (user=guanyulin job=sendgmr) by 2002:a05:690c:4190:b0:69b:c01:82a5 with SMTP
 id 00721157ae682-6e3224f4220mr78017b3.7.1728452746125; Tue, 08 Oct 2024
 22:45:46 -0700 (PDT)
Date: Wed,  9 Oct 2024 05:42:58 +0000
In-Reply-To: <20241009054429.3970438-1-guanyulin@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241009054429.3970438-1-guanyulin@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241009054429.3970438-5-guanyulin@google.com>
Subject: [PATCH v4 4/5] xhci: sideband: add api to trace sideband usage
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

The existing sideband driver only registers sidebands without tracking
their active usage. To address this, new apis are introduced to:
- mark sideband usage: record the sideband usage information in the USB
  host controller driver and USB device driver.
- query sideband status: provide a means for other drivers to fetch
  sideband activity information on a USB host controller.

Signed-off-by: Guan-Yu Lin <guanyulin@google.com>
---
 drivers/usb/host/xhci-sideband.c  | 74 +++++++++++++++++++++++++++++++
 include/linux/usb/hcd.h           |  4 ++
 include/linux/usb/xhci-sideband.h |  5 +++
 3 files changed, 83 insertions(+)

diff --git a/drivers/usb/host/xhci-sideband.c b/drivers/usb/host/xhci-sideband.c
index d04cf0af57ae..29501e5d020f 100644
--- a/drivers/usb/host/xhci-sideband.c
+++ b/drivers/usb/host/xhci-sideband.c
@@ -334,6 +334,80 @@ xhci_sideband_interrupter_id(struct xhci_sideband *sb)
 }
 EXPORT_SYMBOL_GPL(xhci_sideband_interrupter_id);
 
+/**
+ * xhci_sideband_get - notify related drivers there's a new active sideband
+ * @sb: sideband instance for this usb device
+ *
+ * An active sideband indicates that another entity is currently using the host
+ * controller. Notify the host controller and related usb devices by increasing
+ * their sb_usage_count. This allows the corresponding drivers to dynamically
+ * adjust power management actions based on current sideband activity.
+ *
+ * Returns 0 on success, negative error otherwise
+ */
+int xhci_sideband_get(struct xhci_sideband *sb)
+{
+	struct usb_hcd *hcd;
+	struct usb_device *udev;
+
+	if (!sb || !sb->xhci)
+		return -ENODEV;
+
+	hcd = xhci_to_hcd(sb->xhci);
+	atomic_inc(&hcd->sb_usage_count);
+
+	udev = sb->vdev->udev;
+	usb_sideband_get(udev);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(xhci_sideband_get);
+
+/**
+ * xhci_sideband_put - notify related drivers there's a sideband deactivated
+ * @sb: sideband instance for this usb device
+ *
+ * The inverse operation of xhci_sideband_get, which notifies the host
+ * controller and related usb devices by decreasing their sb_usage_count. This
+ * allows the corresponding drivers to dynamically adjust power management
+ * actions based on current sideband activity.
+ *
+ * Returns 0 on success, negative error otherwise
+ */
+int xhci_sideband_put(struct xhci_sideband *sb)
+{
+	struct usb_hcd *hcd;
+	struct usb_device *udev;
+
+	if (!sb || !sb->xhci)
+		return -ENODEV;
+
+	hcd = xhci_to_hcd(sb->xhci);
+	atomic_dec(&hcd->sb_usage_count);
+
+	udev = sb->vdev->udev;
+	usb_sideband_put(udev);
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
+	return !!atomic_read(&hcd->sb_usage_count);
+}
+EXPORT_SYMBOL_GPL(xhci_sideband_check);
+
 /**
  * xhci_sideband_register - register a sideband for a usb device
  * @udev: usb device to be accessed via sideband
diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
index ac95e7c89df5..8b8106b9a31e 100644
--- a/include/linux/usb/hcd.h
+++ b/include/linux/usb/hcd.h
@@ -84,6 +84,10 @@ struct usb_hcd {
 	struct urb		*status_urb;	/* the current status urb */
 #ifdef CONFIG_PM
 	struct work_struct	wakeup_work;	/* for remote wakeup */
+#ifdef CONFIG_USB_XHCI_SIDEBAND
+	/* Number of active sideband accessing the host controller. */
+	atomic_t		sb_usage_count;
+#endif
 #endif
 	struct work_struct	died_work;	/* for when the device dies */
 
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
2.47.0.rc0.187.ge670bccf7e-goog


