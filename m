Return-Path: <linux-kernel+bounces-316337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC62E96CE21
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 06:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D46A1C22071
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 04:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54740156F30;
	Thu,  5 Sep 2024 04:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="evF528ZE"
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3691152166;
	Thu,  5 Sep 2024 04:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725510906; cv=none; b=AC4jQcdIZyFuTeW6kFn3uTUUET12E8fo9sqHo6mWsp7ons5pikRj9umEj4KCApSBy5WZ6EPXG30b4GC1ZMSuuz4OzJ/qdz11/dMFn++Tl1WnrKPl+POsjfqrVIXCPXKU74Y/O5DM/nsI0YZaU4RD2S+AYmgz2tnbPSKCr/T9RWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725510906; c=relaxed/simple;
	bh=aXaVE+s/SnDKQ47vWdxiCRhxJM4RxuS7CvFpS24RYkE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G2y9S1KwsKfyO8mZiDu//EirbA/VFMWLq7RR1+V1C07dNErUsiQkfHr0QgumoF4LeeR5FZumnDBjR84ipSlIyYzHukZYL5lmE4vxZZfxrdcQ7USojK8ry4/cU5PGiR1nAZR+Irq1xEF//N9qFIQebKE1nYPiHVHKCJPdRxaqOQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=evF528ZE; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from localhost.localdomain (unknown [10.101.196.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 4FF773F383;
	Thu,  5 Sep 2024 04:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1725510331;
	bh=RRQ5XZs9l1MpHcXSCY9xoJFCag9Jqr471zYJz9s+Q1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=evF528ZEZiUSFHTTfBzH5lM0QATz6OdM1u/QyyREzjTYURSoBFyTsqkWeU5Eb0wuv
	 HiRf4sDl4SoXlkU+6GsRAqYdGIdkDFjyEtTtni0J2tVsHhRHT3DAoSJhqk6XNBb2d+
	 imQO85avByHdWFdAyJMnzc/Unk1l5VrJYVYn/vnTuxOVJlFz7pPwJdhl77CxJkgsoi
	 0WeVbFK8oSngAXJLYpsh1nvDTUZ+BzFuwqjUVvV/PNbwRuD2EV9Ge7XaXMHHmGjNyW
	 n0fbaTYY8Te0aRxfZyNjwteO+RYQEBINWhbotVIbHzIC3SOeMKnbFnmk47mNJ/tWWK
	 zbZxNLoo9A2qw==
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	gregkh@linuxfoundation.org,
	jorge.lopez2@hp.com
Cc: acelan.kao@canonical.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH 1/2] usb: linux/usb.h: Move USB port definition to usb.h
Date: Thu,  5 Sep 2024 12:24:46 +0800
Message-ID: <20240905042447.418662-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move struct usb_port to linux/usb.h so other subsystems can use it too.

The user will be introduced in next patch.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/usb/core/hub.h | 45 -------------------------------------
 drivers/usb/core/usb.h |  6 -----
 include/linux/usb.h    | 51 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+), 51 deletions(-)

diff --git a/drivers/usb/core/hub.h b/drivers/usb/core/hub.h
index e6ae73f8a95d..8b488c247a1e 100644
--- a/drivers/usb/core/hub.h
+++ b/drivers/usb/core/hub.h
@@ -77,51 +77,6 @@ struct usb_hub {
 	struct list_head        onboard_devs;
 };
 
-/**
- * struct usb port - kernel's representation of a usb port
- * @child: usb device attached to the port
- * @dev: generic device interface
- * @port_owner: port's owner
- * @peer: related usb2 and usb3 ports (share the same connector)
- * @connector: USB Type-C connector
- * @req: default pm qos request for hubs without port power control
- * @connect_type: port's connect type
- * @state: device state of the usb device attached to the port
- * @state_kn: kernfs_node of the sysfs attribute that accesses @state
- * @location: opaque representation of platform connector location
- * @status_lock: synchronize port_event() vs usb_port_{suspend|resume}
- * @portnum: port index num based one
- * @is_superspeed cache super-speed status
- * @usb3_lpm_u1_permit: whether USB3 U1 LPM is permitted.
- * @usb3_lpm_u2_permit: whether USB3 U2 LPM is permitted.
- * @early_stop: whether port initialization will be stopped earlier.
- * @ignore_event: whether events of the port are ignored.
- */
-struct usb_port {
-	struct usb_device *child;
-	struct device dev;
-	struct usb_dev_state *port_owner;
-	struct usb_port *peer;
-	struct typec_connector *connector;
-	struct dev_pm_qos_request *req;
-	enum usb_port_connect_type connect_type;
-	enum usb_device_state state;
-	struct kernfs_node *state_kn;
-	usb_port_location_t location;
-	struct mutex status_lock;
-	u32 over_current_count;
-	u8 portnum;
-	u32 quirks;
-	unsigned int early_stop:1;
-	unsigned int ignore_event:1;
-	unsigned int is_superspeed:1;
-	unsigned int usb3_lpm_u1_permit:1;
-	unsigned int usb3_lpm_u2_permit:1;
-};
-
-#define to_usb_port(_dev) \
-	container_of(_dev, struct usb_port, dev)
-
 extern int usb_hub_create_port_device(struct usb_hub *hub,
 		int port1);
 extern void usb_hub_remove_port_device(struct usb_hub *hub,
diff --git a/drivers/usb/core/usb.h b/drivers/usb/core/usb.h
index b8324ea05b20..3f45b6978660 100644
--- a/drivers/usb/core/usb.h
+++ b/drivers/usb/core/usb.h
@@ -192,12 +192,6 @@ extern const struct file_operations usbdev_file_operations;
 extern int usb_devio_init(void);
 extern void usb_devio_cleanup(void);
 
-/*
- * Firmware specific cookie identifying a port's location. '0' == no location
- * data available
- */
-typedef u32 usb_port_location_t;
-
 /* internal notify stuff */
 extern void usb_notify_add_device(struct usb_device *udev);
 extern void usb_notify_remove_device(struct usb_device *udev);
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 832997a9da0a..1a8f94cc2bc1 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -772,6 +772,57 @@ extern void usb_queue_reset_device(struct usb_interface *dev);
 
 extern struct device *usb_intf_get_dma_device(struct usb_interface *intf);
 
+/*
+ * Firmware specific cookie identifying a port's location. '0' == no location
+ * data available
+ */
+typedef u32 usb_port_location_t;
+
+/**
+ * struct usb port - kernel's representation of a usb port
+ * @child: usb device attached to the port
+ * @dev: generic device interface
+ * @port_owner: port's owner
+ * @peer: related usb2 and usb3 ports (share the same connector)
+ * @connector: USB Type-C connector
+ * @req: default pm qos request for hubs without port power control
+ * @connect_type: port's connect type
+ * @state: device state of the usb device attached to the port
+ * @state_kn: kernfs_node of the sysfs attribute that accesses @state
+ * @location: opaque representation of platform connector location
+ * @status_lock: synchronize port_event() vs usb_port_{suspend|resume}
+ * @portnum: port index num based one
+ * @is_superspeed cache super-speed status
+ * @usb3_lpm_u1_permit: whether USB3 U1 LPM is permitted.
+ * @usb3_lpm_u2_permit: whether USB3 U2 LPM is permitted.
+ * @early_stop: whether port initialization will be stopped earlier.
+ * @ignore_event: whether events of the port are ignored.
+ */
+struct usb_port {
+	struct usb_device *child;
+	struct device dev;
+	struct usb_dev_state *port_owner;
+	struct usb_port *peer;
+	struct typec_connector *connector;
+	struct dev_pm_qos_request *req;
+	enum usb_port_connect_type connect_type;
+	enum usb_device_state state;
+	struct kernfs_node *state_kn;
+	usb_port_location_t location;
+	struct mutex status_lock;
+	u32 over_current_count;
+	u8 portnum;
+	u32 quirks;
+	unsigned int early_stop:1;
+	unsigned int ignore_event:1;
+	unsigned int is_superspeed:1;
+	unsigned int usb3_lpm_u1_permit:1;
+	unsigned int usb3_lpm_u2_permit:1;
+};
+
+#define to_usb_port(_dev) \
+	container_of(_dev, struct usb_port, dev)
+
 #ifdef CONFIG_ACPI
 extern int usb_acpi_set_power_state(struct usb_device *hdev, int index,
 	bool enable);
-- 
2.43.0


