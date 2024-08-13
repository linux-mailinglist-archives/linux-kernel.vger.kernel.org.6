Return-Path: <linux-kernel+bounces-284967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3BF95076B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 16:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 663971F25122
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 14:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8244219ADB9;
	Tue, 13 Aug 2024 14:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="Ef6y76zM"
Received: from mr85p00im-ztdg06021201.me.com (mr85p00im-ztdg06021201.me.com [17.58.23.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478703A8CE
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 14:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723558791; cv=none; b=Bk68dthG8PBdtysVr5TFp2RIVQ1fLIZLN+JN1VfOLJ/LfE9Eu+AREt+MuPyMsVQPVJRohrHaTYHukfyrhWPB4oqiY8cOSqjiwQmP8aO/xRgYSfiMavNXWpMswGSAY2a5wummQk6FlUT5ish+LLbMQY6Siktx4UCt2p5/VIQ74I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723558791; c=relaxed/simple;
	bh=A+ua8F4F1LM49wO3L9W31dYOy5cghNIXnn9CKb8GZVE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=i/xL2wHm66WRMJaOes4juOIscuVWB8BNqze8Ooe2nay4TQ+s5PVJVV+Zzt+p+CsE7isSy8PsPRR5gyX5RhtM6cCPesg6zkDmEwqo37AQtpMQP7sghfjqWHsUltB8XDNacZTxzjVYg0xpCSZfP7XHdjhrpHAFPoeJ8VjOxu7194g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=Ef6y76zM; arc=none smtp.client-ip=17.58.23.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1723558789;
	bh=E5j+0HuAGRC5Fef7pCdhcKQM5j/+nTag89XSbU4JCtw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=Ef6y76zMSXflww2ASeH2v3kBIyuJBMOHmDtuSfsxoxu/gySJnC/JBNmOKjgnOUaSe
	 8ECm/hZLfuHRE4nCqQ2BNV/SCku1htpNE726z++lpRHZLxP3iWcakci4uRU6goJw2N
	 Xdr7r1bGDQtxrSnibjoGaWJTnTuKLhwmbymXRJmd+F9tJAXjOhBKQvYgF5n8EptF6p
	 /tCj6cmJdrZybRDeNBOGyC8H/HHRuCdZLNcu0jbPJcaQwQSympppXWjrIY+bLu/aMh
	 rXoz+81laUWaoxMBamJRM5LDZ7xtGTquT3dSlRPag7Keq0Ja2iWRgEYgris7/kJEew
	 XzltAs3J9iSBA==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06021201.me.com (Postfix) with ESMTPSA id 4A04032032F;
	Tue, 13 Aug 2024 14:19:46 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Tue, 13 Aug 2024 22:19:32 +0800
Subject: [PATCH v3] drivers/base: Introduce device_match_t for device
 finding APIs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240813-dev_match_api-v3-1-6c6878a99b9f@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAHNru2YC/12OywrCMBBFf6VkbSSTNCqu/A+RkiYZO4s+TGpQS
 v/dtCBol+fCOdyJRR/IR3YuJhZ8okh9l0HtCmYb0909J5eZSSFLcRLAnU9Va0bbVGYgXoI2R63
 RItYsO0PwSK+1d71lbiiOfXiv+QTL+i3JTSkBB67Bw8GpGoWCy+NJljq7t33LllaSPz5snySZf
 eekRNRaGyX+/XmeP6hbbWPsAAAA
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-GUID: Ek0mwwUuj4HMmKTSi61fEvq7MsOy0yIJ
X-Proofpoint-ORIG-GUID: Ek0mwwUuj4HMmKTSi61fEvq7MsOy0yIJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-13_06,2024-08-13_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 clxscore=1015 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408130103
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

There are several drivers/base APIs for finding a specific device, and
they currently use the following good type for the @match parameter:
int (*match)(struct device *dev, const void *data)

Since these operations do not modify the caller-provided @*data, this
type is worthy of a dedicated typedef:
typedef int (*device_match_t)(struct device *dev, const void *data)

Advantages of using device_match_t:
 - Shorter API declarations and definitions
 - Prevent further APIs from using a bad type for @match

So introduce device_match_t and apply it to the existing
(bus|class|driver|auxiliary)_find_device() APIs.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
Changes in v3:
- Add new line after typedef
- Link to v2: https://lore.kernel.org/r/20240811-dev_match_api-v2-1-dd22ff555a30@quicinc.com

Changes in v2:
- Git rebase over the following commit:
  bfa54a793ba7 ("driver core: bus: Fix double free in driver API bus_register()")
- Link to v1: https://lore.kernel.org/r/20240802-dev_match_api-v1-1-51e16d3bf031@quicinc.com
---
 drivers/base/auxiliary.c      | 2 +-
 drivers/base/bus.c            | 2 +-
 drivers/base/class.c          | 3 +--
 drivers/base/driver.c         | 2 +-
 include/linux/auxiliary_bus.h | 2 +-
 include/linux/device/bus.h    | 6 ++++--
 include/linux/device/class.h  | 2 +-
 include/linux/device/driver.h | 2 +-
 8 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
index 54b92839e05c..7823888af4f6 100644
--- a/drivers/base/auxiliary.c
+++ b/drivers/base/auxiliary.c
@@ -352,7 +352,7 @@ EXPORT_SYMBOL_GPL(__auxiliary_device_add);
  */
 struct auxiliary_device *auxiliary_find_device(struct device *start,
 					       const void *data,
-					       int (*match)(struct device *dev, const void *data))
+					       device_match_t match)
 {
 	struct device *dev;
 
diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index abf090ace833..657c93c38b0d 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -391,7 +391,7 @@ EXPORT_SYMBOL_GPL(bus_for_each_dev);
  */
 struct device *bus_find_device(const struct bus_type *bus,
 			       struct device *start, const void *data,
-			       int (*match)(struct device *dev, const void *data))
+			       device_match_t match)
 {
 	struct subsys_private *sp = bus_to_subsys(bus);
 	struct klist_iter i;
diff --git a/drivers/base/class.c b/drivers/base/class.c
index 7b38fdf8e1d7..ae22fa992c04 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -433,8 +433,7 @@ EXPORT_SYMBOL_GPL(class_for_each_device);
  * code.  There's no locking restriction.
  */
 struct device *class_find_device(const struct class *class, const struct device *start,
-				 const void *data,
-				 int (*match)(struct device *, const void *))
+				 const void *data, device_match_t match)
 {
 	struct subsys_private *sp = class_to_subsys(class);
 	struct class_dev_iter iter;
diff --git a/drivers/base/driver.c b/drivers/base/driver.c
index 88c6fd1f1992..b4eb5b89c4ee 100644
--- a/drivers/base/driver.c
+++ b/drivers/base/driver.c
@@ -150,7 +150,7 @@ EXPORT_SYMBOL_GPL(driver_for_each_device);
  */
 struct device *driver_find_device(const struct device_driver *drv,
 				  struct device *start, const void *data,
-				  int (*match)(struct device *dev, const void *data))
+				  device_match_t match)
 {
 	struct klist_iter i;
 	struct device *dev;
diff --git a/include/linux/auxiliary_bus.h b/include/linux/auxiliary_bus.h
index 662b8ae54b6a..31762324bcc9 100644
--- a/include/linux/auxiliary_bus.h
+++ b/include/linux/auxiliary_bus.h
@@ -271,6 +271,6 @@ void auxiliary_driver_unregister(struct auxiliary_driver *auxdrv);
 
 struct auxiliary_device *auxiliary_find_device(struct device *start,
 					       const void *data,
-					       int (*match)(struct device *dev, const void *data));
+					       device_match_t match);
 
 #endif /* _AUXILIARY_BUS_H_ */
diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
index 807831d6bf0f..cdc4757217f9 100644
--- a/include/linux/device/bus.h
+++ b/include/linux/device/bus.h
@@ -126,6 +126,9 @@ struct bus_attribute {
 int __must_check bus_create_file(const struct bus_type *bus, struct bus_attribute *attr);
 void bus_remove_file(const struct bus_type *bus, struct bus_attribute *attr);
 
+/* Matching function type for drivers/base APIs to find a specific device */
+typedef int (*device_match_t)(struct device *dev, const void *data);
+
 /* Generic device matching functions that all busses can use to match with */
 int device_match_name(struct device *dev, const void *name);
 int device_match_of_node(struct device *dev, const void *np);
@@ -139,8 +142,7 @@ int device_match_any(struct device *dev, const void *unused);
 int bus_for_each_dev(const struct bus_type *bus, struct device *start, void *data,
 		     int (*fn)(struct device *dev, void *data));
 struct device *bus_find_device(const struct bus_type *bus, struct device *start,
-			       const void *data,
-			       int (*match)(struct device *dev, const void *data));
+			       const void *data, device_match_t match);
 /**
  * bus_find_device_by_name - device iterator for locating a particular device
  * of a specific name.
diff --git a/include/linux/device/class.h b/include/linux/device/class.h
index c576b49c55c2..518c9c83d64b 100644
--- a/include/linux/device/class.h
+++ b/include/linux/device/class.h
@@ -95,7 +95,7 @@ void class_dev_iter_exit(struct class_dev_iter *iter);
 int class_for_each_device(const struct class *class, const struct device *start, void *data,
 			  int (*fn)(struct device *dev, void *data));
 struct device *class_find_device(const struct class *class, const struct device *start,
-				 const void *data, int (*match)(struct device *, const void *));
+				 const void *data, device_match_t match);
 
 /**
  * class_find_device_by_name - device iterator for locating a particular device
diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
index 1fc8b68786de..5c04b8e3833b 100644
--- a/include/linux/device/driver.h
+++ b/include/linux/device/driver.h
@@ -157,7 +157,7 @@ int __must_check driver_for_each_device(struct device_driver *drv, struct device
 					void *data, int (*fn)(struct device *dev, void *));
 struct device *driver_find_device(const struct device_driver *drv,
 				  struct device *start, const void *data,
-				  int (*match)(struct device *dev, const void *data));
+				  device_match_t match);
 
 /**
  * driver_find_device_by_name - device iterator for locating a particular device

---
base-commit: bfa54a793ba77ef696755b66f3ac4ed00c7d1248
change-id: 20240801-dev_match_api-415a755fcffb

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


