Return-Path: <linux-kernel+bounces-377687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 548159AC254
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 10:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F329282FA1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 08:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90EBC1684B0;
	Wed, 23 Oct 2024 08:54:53 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0879615C15A;
	Wed, 23 Oct 2024 08:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729673693; cv=none; b=hyAXqP9IgEMmyG4TEsbynfSdNVSU5F3C7dAIhWvXW6+47Oq4ks7TdR1vVhifxX1bn+uQCGOFTRUetkjyO8Eda9dln5448Jsp7T5ABUgYiwOfADkAEx5m1E5Jc8FPn1u8OqPOyLx5oLnyVrfOQ3EtTVFuduCAM3VpHiRpf/VpxlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729673693; c=relaxed/simple;
	bh=nwT+H26anUIegZJyg9+xo/0tGIY2YmnYHFGBiFvbbTg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hDJXT+G4auRBM0wi6vvWtInD0gVGzQfF9l1Oi9KnP++tH/ZMJ/eTCoItxRTsh8MMMTQAlhX4dTBu0k+n/6MrOeo96e1SzdBF9iIYgl3DUjCFLNiz5oUUSW0GjZN1aPMm7VRIaPEvh1PRmZAy72Zm0FZHeRP3MRu8ccKwqtKsPqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 71be10bc911c11efa216b1d71e6e1362-20241023
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:2ffbf81f-72b8-450b-a69c-af7ba03e689c,IP:0,U
	RL:0,TC:0,Content:-25,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-50
X-CID-META: VersionHash:82c5f88,CLOUDID:657e175c6be441a850cf72393bf194d2,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:1,IP:nil,URL:0,
	File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:N
	O,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 71be10bc911c11efa216b1d71e6e1362-20241023
Received: from node4.com.cn [(10.44.16.170)] by mailgw.kylinos.cn
	(envelope-from <lijiayi@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1144021719; Wed, 23 Oct 2024 16:54:42 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id 546061600209E;
	Wed, 23 Oct 2024 16:54:42 +0800 (CST)
X-ns-mid: postfix-6718B9D2-1726757667
Received: from kylin-pc.. (unknown [172.25.130.133])
	by node4.com.cn (NSMail) with ESMTPA id C4E231600209E;
	Wed, 23 Oct 2024 08:54:41 +0000 (UTC)
From: Jiayi Li <lijiayi@kylinos.cn>
To: gregkh@linuxfoundation.org,
	stern@rowland.harvard.edu,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: lijiayi@kylinos.cn
Subject: [PATCH v3] usb: core: use sysfs_emit() instead of sprintf()
Date: Wed, 23 Oct 2024 16:54:29 +0800
Message-ID: <20241023085429.2865488-1-lijiayi@kylinos.cn>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Follow the advice in Documentation/filesystems/sysfs.rst:
show() should only use sysfs_emit() or sysfs_emit_at() when formatting
the value to be returned to user space.

Signed-off-by: Jiayi Li <lijiayi@kylinos.cn>
---
V2 -> V3: Add description of changes from the previous version.
V1 -> V2: Add #include <linux/sysfs.h>
---
 drivers/usb/core/endpoint.c        | 11 ++++++-----
 drivers/usb/core/ledtrig-usbport.c |  3 ++-
 drivers/usb/core/port.c            | 11 ++++++-----
 3 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/core/endpoint.c b/drivers/usb/core/endpoint.c
index 4b38b87a1343..e48399401608 100644
--- a/drivers/usb/core/endpoint.c
+++ b/drivers/usb/core/endpoint.c
@@ -14,6 +14,7 @@
 #include <linux/kernel.h>
 #include <linux/spinlock.h>
 #include <linux/slab.h>
+#include <linux/sysfs.h>
 #include <linux/usb.h>
 #include "usb.h"
=20
@@ -39,7 +40,7 @@ static ssize_t field##_show(struct device *dev,			\
 			       char *buf)			\
 {								\
 	struct ep_device *ep =3D to_ep_device(dev);		\
-	return sprintf(buf, format_string, ep->desc->field);	\
+	return sysfs_emit(buf, format_string, ep->desc->field);	\
 }								\
 static DEVICE_ATTR_RO(field)
=20
@@ -52,7 +53,7 @@ static ssize_t wMaxPacketSize_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
 	struct ep_device *ep =3D to_ep_device(dev);
-	return sprintf(buf, "%04x\n", usb_endpoint_maxp(ep->desc));
+	return sysfs_emit(buf, "%04x\n", usb_endpoint_maxp(ep->desc));
 }
 static DEVICE_ATTR_RO(wMaxPacketSize);
=20
@@ -76,7 +77,7 @@ static ssize_t type_show(struct device *dev, struct dev=
ice_attribute *attr,
 		type =3D "Interrupt";
 		break;
 	}
-	return sprintf(buf, "%s\n", type);
+	return sysfs_emit(buf, "%s\n", type);
 }
 static DEVICE_ATTR_RO(type);
=20
@@ -95,7 +96,7 @@ static ssize_t interval_show(struct device *dev, struct=
 device_attribute *attr,
 		interval /=3D 1000;
 	}
=20
-	return sprintf(buf, "%d%cs\n", interval, unit);
+	return sysfs_emit(buf, "%d%cs\n", interval, unit);
 }
 static DEVICE_ATTR_RO(interval);
=20
@@ -111,7 +112,7 @@ static ssize_t direction_show(struct device *dev, str=
uct device_attribute *attr,
 		direction =3D "in";
 	else
 		direction =3D "out";
-	return sprintf(buf, "%s\n", direction);
+	return sysfs_emit(buf, "%s\n", direction);
 }
 static DEVICE_ATTR_RO(direction);
=20
diff --git a/drivers/usb/core/ledtrig-usbport.c b/drivers/usb/core/ledtri=
g-usbport.c
index 85c999f71ad7..5e3c515991f3 100644
--- a/drivers/usb/core/ledtrig-usbport.c
+++ b/drivers/usb/core/ledtrig-usbport.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/slab.h>
+#include <linux/sysfs.h>
 #include <linux/usb.h>
 #include <linux/usb/of.h>
=20
@@ -87,7 +88,7 @@ static ssize_t usbport_trig_port_show(struct device *de=
v,
 						      struct usbport_trig_port,
 						      attr);
=20
-	return sprintf(buf, "%d\n", port->observed) + 1;
+	return sysfs_emit(buf, "%d\n", port->observed) + 1;
 }
=20
 static ssize_t usbport_trig_port_store(struct device *dev,
diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
index e7da2fca11a4..45d7af00f8d1 100644
--- a/drivers/usb/core/port.c
+++ b/drivers/usb/core/port.c
@@ -9,6 +9,7 @@
=20
 #include <linux/kstrtox.h>
 #include <linux/slab.h>
+#include <linux/sysfs.h>
 #include <linux/pm_qos.h>
 #include <linux/component.h>
 #include <linux/usb/of.h>
@@ -166,7 +167,7 @@ static ssize_t location_show(struct device *dev,
 {
 	struct usb_port *port_dev =3D to_usb_port(dev);
=20
-	return sprintf(buf, "0x%08x\n", port_dev->location);
+	return sysfs_emit(buf, "0x%08x\n", port_dev->location);
 }
 static DEVICE_ATTR_RO(location);
=20
@@ -191,7 +192,7 @@ static ssize_t connect_type_show(struct device *dev,
 		break;
 	}
=20
-	return sprintf(buf, "%s\n", result);
+	return sysfs_emit(buf, "%s\n", result);
 }
 static DEVICE_ATTR_RO(connect_type);
=20
@@ -210,7 +211,7 @@ static ssize_t over_current_count_show(struct device =
*dev,
 {
 	struct usb_port *port_dev =3D to_usb_port(dev);
=20
-	return sprintf(buf, "%u\n", port_dev->over_current_count);
+	return sysfs_emit(buf, "%u\n", port_dev->over_current_count);
 }
 static DEVICE_ATTR_RO(over_current_count);
=20
@@ -219,7 +220,7 @@ static ssize_t quirks_show(struct device *dev,
 {
 	struct usb_port *port_dev =3D to_usb_port(dev);
=20
-	return sprintf(buf, "%08x\n", port_dev->quirks);
+	return sysfs_emit(buf, "%08x\n", port_dev->quirks);
 }
=20
 static ssize_t quirks_store(struct device *dev, struct device_attribute =
*attr,
@@ -254,7 +255,7 @@ static ssize_t usb3_lpm_permit_show(struct device *de=
v,
 			p =3D "0";
 	}
=20
-	return sprintf(buf, "%s\n", p);
+	return sysfs_emit(buf, "%s\n", p);
 }
=20
 static ssize_t usb3_lpm_permit_store(struct device *dev,
--=20
2.45.2


