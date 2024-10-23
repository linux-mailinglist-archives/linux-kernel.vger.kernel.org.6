Return-Path: <linux-kernel+bounces-377603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03AAC9AC129
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 10:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 862DD1F217F0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 08:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34278158845;
	Wed, 23 Oct 2024 08:12:42 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4271C2BD;
	Wed, 23 Oct 2024 08:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729671161; cv=none; b=q6elvAbk4WmwvmrknjZuPlhViubYHK9YKNDG30s3hQBhT/1YYO+9ydN5qj7SjOSHKfiU51nMSNujnosZYAhQhsAHfMHeSiAmyL9JmfxIB7F0ICnjLNwEP+PuYpROJ2NxElXbnr19jzUm+sYaLxNqCQvksanJGe6uZ+gGg39qUQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729671161; c=relaxed/simple;
	bh=Ov3tGUEtS22P6qXPo42rF4eR4kaaLgxJ5X5EIsh9g/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OSSWnJnKKyZHoF6rk57vqnwx/JN37llZAYZOTUundcbztJylnVxazPFec/SwAUtpEkIvipUcVYHxCgD2gL6+IQEfplrUGT5M61+QMnXB5hCY61FKRANl3TqL7QzXi+PsTqd4ZLHaQIn6IdWIDr9zMh+A+kwyvV+OF6/7WfHCke0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 8c90631e911611efa216b1d71e6e1362-20241023
X-CID-CACHE: Type:Local,Time:202410231524+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:3c29d85a-8015-4ade-ab91-b0dddc7d3215,IP:0,U
	RL:0,TC:0,Content:-25,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-50
X-CID-META: VersionHash:82c5f88,CLOUDID:6cf6a58cf1939cde1e9cd929ab6835ca,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:1,IP:nil,URL:0,
	File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:N
	O,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 8c90631e911611efa216b1d71e6e1362-20241023
Received: from node4.com.cn [(10.44.16.170)] by mailgw.kylinos.cn
	(envelope-from <lijiayi@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1346884670; Wed, 23 Oct 2024 16:12:30 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id 212F216002082;
	Wed, 23 Oct 2024 16:12:30 +0800 (CST)
X-ns-mid: postfix-6718AFED-9678747262
Received: from kylin-pc.. (unknown [172.25.130.133])
	by node4.com.cn (NSMail) with ESMTPA id 6FEC316002082;
	Wed, 23 Oct 2024 08:12:28 +0000 (UTC)
From: Jiayi Li <lijiayi@kylinos.cn>
To: gregkh@linuxfoundation.org,
	stern@rowland.harvard.edu,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: lijiayi@kylinos.cn
Subject: [PATCH v1] usb: core: use sysfs_emit() instead of sprintf()
Date: Wed, 23 Oct 2024 16:12:08 +0800
Message-ID: <20241023081208.2425876-1-lijiayi@kylinos.cn>
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
 drivers/usb/core/endpoint.c        | 10 +++++-----
 drivers/usb/core/ledtrig-usbport.c |  2 +-
 drivers/usb/core/port.c            | 10 +++++-----
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/core/endpoint.c b/drivers/usb/core/endpoint.c
index 4b38b87a1343..1baf88a093eb 100644
--- a/drivers/usb/core/endpoint.c
+++ b/drivers/usb/core/endpoint.c
@@ -39,7 +39,7 @@ static ssize_t field##_show(struct device *dev,			\
 			       char *buf)			\
 {								\
 	struct ep_device *ep =3D to_ep_device(dev);		\
-	return sprintf(buf, format_string, ep->desc->field);	\
+	return sysfs_emit(buf, format_string, ep->desc->field);	\
 }								\
 static DEVICE_ATTR_RO(field)
=20
@@ -52,7 +52,7 @@ static ssize_t wMaxPacketSize_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
 	struct ep_device *ep =3D to_ep_device(dev);
-	return sprintf(buf, "%04x\n", usb_endpoint_maxp(ep->desc));
+	return sysfs_emit(buf, "%04x\n", usb_endpoint_maxp(ep->desc));
 }
 static DEVICE_ATTR_RO(wMaxPacketSize);
=20
@@ -76,7 +76,7 @@ static ssize_t type_show(struct device *dev, struct dev=
ice_attribute *attr,
 		type =3D "Interrupt";
 		break;
 	}
-	return sprintf(buf, "%s\n", type);
+	return sysfs_emit(buf, "%s\n", type);
 }
 static DEVICE_ATTR_RO(type);
=20
@@ -95,7 +95,7 @@ static ssize_t interval_show(struct device *dev, struct=
 device_attribute *attr,
 		interval /=3D 1000;
 	}
=20
-	return sprintf(buf, "%d%cs\n", interval, unit);
+	return sysfs_emit(buf, "%d%cs\n", interval, unit);
 }
 static DEVICE_ATTR_RO(interval);
=20
@@ -111,7 +111,7 @@ static ssize_t direction_show(struct device *dev, str=
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
index 85c999f71ad7..3d36f72ce38b 100644
--- a/drivers/usb/core/ledtrig-usbport.c
+++ b/drivers/usb/core/ledtrig-usbport.c
@@ -87,7 +87,7 @@ static ssize_t usbport_trig_port_show(struct device *de=
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
index e7da2fca11a4..a9f035f59f22 100644
--- a/drivers/usb/core/port.c
+++ b/drivers/usb/core/port.c
@@ -166,7 +166,7 @@ static ssize_t location_show(struct device *dev,
 {
 	struct usb_port *port_dev =3D to_usb_port(dev);
=20
-	return sprintf(buf, "0x%08x\n", port_dev->location);
+	return sysfs_emit(buf, "0x%08x\n", port_dev->location);
 }
 static DEVICE_ATTR_RO(location);
=20
@@ -191,7 +191,7 @@ static ssize_t connect_type_show(struct device *dev,
 		break;
 	}
=20
-	return sprintf(buf, "%s\n", result);
+	return sysfs_emit(buf, "%s\n", result);
 }
 static DEVICE_ATTR_RO(connect_type);
=20
@@ -210,7 +210,7 @@ static ssize_t over_current_count_show(struct device =
*dev,
 {
 	struct usb_port *port_dev =3D to_usb_port(dev);
=20
-	return sprintf(buf, "%u\n", port_dev->over_current_count);
+	return sysfs_emit(buf, "%u\n", port_dev->over_current_count);
 }
 static DEVICE_ATTR_RO(over_current_count);
=20
@@ -219,7 +219,7 @@ static ssize_t quirks_show(struct device *dev,
 {
 	struct usb_port *port_dev =3D to_usb_port(dev);
=20
-	return sprintf(buf, "%08x\n", port_dev->quirks);
+	return sysfs_emit(buf, "%08x\n", port_dev->quirks);
 }
=20
 static ssize_t quirks_store(struct device *dev, struct device_attribute =
*attr,
@@ -254,7 +254,7 @@ static ssize_t usb3_lpm_permit_show(struct device *de=
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


