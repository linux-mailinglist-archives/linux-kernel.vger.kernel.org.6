Return-Path: <linux-kernel+bounces-363595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9BE99C47C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 452272880BC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A612815CD6E;
	Mon, 14 Oct 2024 08:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OsSupcw4"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F6C15C136
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 08:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728896335; cv=none; b=d0M3NeR5Zg2W6cZ34jm0rrqdsuwDWVDQtU4lSvyXHbC5MCdrbSAF87QrMnq++2GHFKbvdzRpvXCa7cbxMPizbiDTW9djG1hrE8nYdaRva9G9hjd0hzH0vmjhuI8Y2ZvJhRyrLC3OySeLscsHHcPTK9sspOHNp68oJGH1osGkaag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728896335; c=relaxed/simple;
	bh=00RezD4fZXgbmVjvyaGx9y1/uF7V89ZgLGz+dUck3vw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jrimcCN64NfLvordMy4D1IaciCmwaP+udHBHSKSJhgcOfwwp0Xxc7m7WCgBD6aR9RrL8Kbc1EbprBFPE4vDfABSU+679jAXtvFH7B6N5lW7PjWhlPUaYtVRdRW+vJXKmZkVAIKa3pwWy9h/8pcZ16tlFovJhY9Sfiu7O6m3ge1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--guanyulin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OsSupcw4; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--guanyulin.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e2928d9e615so3293204276.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 01:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728896332; x=1729501132; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bMcgk3CcUjXi+uoOfgcbw4Mfb3bioMSfzYjoaeWoO/o=;
        b=OsSupcw4QO1wrI9/nUWcLEfElCcNNbi4J2TT9DdsOs4qcUjGlrtkTfiPAiLvuOKulh
         1s4i7XEsj5VdNj1azSBeBtSUtmavCPbEcCV7BwqNrM9ekFzpAkppl+m/2JszoOHVwpUs
         A33OAoeEQoZDNJoUT485bdVvWA84xyXSV0EedMS5FhII0SgJVDKShvmzbvUhmN2xMxSZ
         LPoNA/CZXzvVAF+xKYtzadpdSXW6DhdD+6JBxYCx2TJtxRJOqicKHUSC2hxWrlV5P6MY
         VfWkkYpDEqEHPEgyMJuIES1X8G37zhmBVuTMOKRYIEvB0WdrVv3f943eeUwg5VE38qM4
         47Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728896332; x=1729501132;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bMcgk3CcUjXi+uoOfgcbw4Mfb3bioMSfzYjoaeWoO/o=;
        b=MRfFHwA8j58cvUi6RqDV2DDiPjl+Lx60Sf9Q1xLyGJ/PjrRfLE0TKQrZ6VzsCIUIPJ
         0UEhpfdPhRjSumLTtZm+VOv+/M/7Xaw/YX72Cr7rg5R/kcm0goflgNbaKSW9pXowEo0W
         IKgSgN/9ynRByE4U8UlONolOziLtP0MfzL4jLJf9YK4D8ksHxqsLtXYBqoPNOtqhORCV
         artgEbtyhCDjjCALc8krDddnR+PV4FEihnZrmjQPpf+f/XgT0HGEA89MAIQQ31G7wFn6
         L89aYHQydIqoowU62TK9JGoEriZTu80EQcwwEFXESg/3NUxeqfnO9bzhk6SaUVDsMAMb
         ETow==
X-Forwarded-Encrypted: i=1; AJvYcCVdimZWxu33o7C0kuC0yZWrbxg8yH3+qckGwhId4/3IM2Ke+a7SviQ9UhB0QR7yL/5oN7KaBQANW+rvAq8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzve6HoRIzWC5/IDgANU5s8kgg+O9enVTDXohE0zb4VdP97T3ET
	0gU+4q650lLEcgscOLl0/Hnu+fJV3kcVZntgfD9sf0AoBcsghGrILbE/jB7A7d/tF+/FuZPzllf
	gVnosy+3Ljv6I3g==
X-Google-Smtp-Source: AGHT+IEQKdL9Plag6ZA1vhHt8ZLUYQhQJYeN3Urx8uogAw0TWmuM/he1UtGVOy7Ebzmw1h4YomDg2lD5HqH2srQ=
X-Received: from guanyulin.c.googlers.com ([fda3:e722:ac3:cc00:131:cd17:ac11:19c7])
 (user=guanyulin job=sendgmr) by 2002:a25:26c6:0:b0:e0b:f69b:da30 with SMTP id
 3f1490d57ef6-e2919fe7a11mr54743276.9.1728896331800; Mon, 14 Oct 2024 01:58:51
 -0700 (PDT)
Date: Mon, 14 Oct 2024 08:50:28 +0000
In-Reply-To: <20241014085816.1401364-1-guanyulin@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241014085816.1401364-1-guanyulin@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241014085816.1401364-5-guanyulin@google.com>
Subject: [PATCH v5 4/5] xhci: sideband: add api to trace sideband usage
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
index d04cf0af57ae..87dd66056324 100644
--- a/drivers/usb/host/xhci-sideband.c
+++ b/drivers/usb/host/xhci-sideband.c
@@ -334,6 +334,80 @@ xhci_sideband_interrupter_id(struct xhci_sideband *sb)
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
+	struct usb_hcd *hcd;
+	struct usb_device *udev;
+
+	if (!sb || !sb->xhci)
+		return -ENODEV;
+
+	hcd = xhci_to_hcd(sb->xhci);
+	refcount_inc(&hcd->sb_usage_count);
+
+	udev = sb->vdev->udev;
+	usb_sideband_get(udev);
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
+	struct usb_hcd *hcd;
+	struct usb_device *udev;
+
+	if (!sb || !sb->xhci)
+		return -ENODEV;
+
+	hcd = xhci_to_hcd(sb->xhci);
+	refcount_dec(&hcd->sb_usage_count);
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
+	return !!refcount_read(&hcd->sb_usage_count);
+}
+EXPORT_SYMBOL_GPL(xhci_sideband_check);
+
 /**
  * xhci_sideband_register - register a sideband for a usb device
  * @udev: usb device to be accessed via sideband
diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
index ac95e7c89df5..d4f5e57b0c00 100644
--- a/include/linux/usb/hcd.h
+++ b/include/linux/usb/hcd.h
@@ -84,6 +84,10 @@ struct usb_hcd {
 	struct urb		*status_urb;	/* the current status urb */
 #ifdef CONFIG_PM
 	struct work_struct	wakeup_work;	/* for remote wakeup */
+#ifdef CONFIG_USB_XHCI_SIDEBAND
+	/* Number of active sideband accessing the host controller. */
+	refcount_t		sb_usage_count;
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
2.47.0.rc1.288.g06298d1525-goog


