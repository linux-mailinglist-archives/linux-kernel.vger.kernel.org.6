Return-Path: <linux-kernel+bounces-282082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C25794DF87
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 04:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18ED51C20B0B
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 02:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0058F48;
	Sun, 11 Aug 2024 02:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="FysaUJS0"
Received: from mr85p00im-ztdg06011801.me.com (mr85p00im-ztdg06011801.me.com [17.58.23.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816254C79
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 02:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723342537; cv=none; b=nPrN/nT9KhBOS/LqUb0G6LWIaAMtGMnrtOSVO3k2hopg5j15fR6kwzesSpfjr3EBQhE5+t+pFfhCGp9iqymdlmARZNR81xYbP+Joct4ZEsgwUCZ+O9BI8GO1jSB5Hgqsd5ewbXjForfGHmACUVBuynX5ydaAbhXwO8kKQnE5FY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723342537; c=relaxed/simple;
	bh=/sFCC6knJcMtyd+ULWXT81qIxi4jsAku/SX02VWevLU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XMVq8NgLLLf7Xoz/xbF6DP6LhJhLL2n5jVClzgv2DMFX0Z2ZZSm6f5zMjts32iuGvmJFe7FIWa7hwOVVdfJmtXrAa9OpkD9meC8s0o7umEcxINLWSvnmJbuTc/viOU1lUs2a2m7jO+0Z2qbKmo5YAcdU5j7I6VMI/B1CAf51eW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=FysaUJS0; arc=none smtp.client-ip=17.58.23.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1723342534;
	bh=JypY8h8GBMMSB96O4kYZJ4c91XlL92MNCkBYBQzmvu8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=FysaUJS0OaaU5hwUP9NR7ygRa4LvU1ChcwBU/wcaZi2gGsXQJK4l6xZe9z6nBtW3w
	 LHtYZd5WuWBCZCayYSUwH/B3g/lwrmMNR0Q+sKZOrpRl9pB3o4yOUmNGTQO1bjAru7
	 7xhx3bGPdnUs5aARs5inDlNSwmOL2L5prFv/+op/GJafc4NIRjStFNamnsUqWGQpcg
	 2Q28e7/bconGzt2DesTb09fJ3IGm8Igjj5GSdQiqp9dCghGcLhKkmMYL9GyQEvSdYO
	 HxwxhI1qKYwP8WTsGAkCchFGKBtwfj5P7FK05AbVopsKE2RIH8PYXQnkIH/8t0Yyh5
	 et6LWauq5Xnaw==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06011801.me.com (Postfix) with ESMTPSA id 6830B20B075D;
	Sun, 11 Aug 2024 02:15:31 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Sun, 11 Aug 2024 10:15:16 +0800
Subject: [PATCH v2] drivers/base: Introduce device_match_t for device
 finding APIs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240811-dev_match_api-v2-1-dd22ff555a30@quicinc.com>
X-B4-Tracking: v=1; b=H4sIALMeuGYC/13MywrCMBCF4VcpszaSSRsVV76HlJKmEzuL3pIal
 JJ3NxbcuPwPnG+DQJ4pwLXYwFPkwNOYQx0KsL0ZHyS4yw1KqkpeJIqOYjOY1faNmVlUqM1Za2e
 dayF/Zk+OX7t3r3P3HNbJv3c+4nf9SepPiihQaCQ8dWXrZIm35cmWR3u00wB1SukDikrqqawAA
 AA=
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-GUID: CvDFPFxSZ0d6Ncen3Kc2pz7HRXQeTEt6
X-Proofpoint-ORIG-GUID: CvDFPFxSZ0d6Ncen3Kc2pz7HRXQeTEt6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-11_01,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 clxscore=1015 malwarescore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408110016
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
 include/linux/device/bus.h    | 5 +++--
 include/linux/device/class.h  | 2 +-
 include/linux/device/driver.h | 2 +-
 8 files changed, 10 insertions(+), 10 deletions(-)

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
index 807831d6bf0f..970de5ee5562 100644
--- a/include/linux/device/bus.h
+++ b/include/linux/device/bus.h
@@ -126,6 +126,8 @@ struct bus_attribute {
 int __must_check bus_create_file(const struct bus_type *bus, struct bus_attribute *attr);
 void bus_remove_file(const struct bus_type *bus, struct bus_attribute *attr);
 
+/* Matching function type for drivers/base APIs to find a specific device */
+typedef int (*device_match_t)(struct device *dev, const void *data);
 /* Generic device matching functions that all busses can use to match with */
 int device_match_name(struct device *dev, const void *name);
 int device_match_of_node(struct device *dev, const void *np);
@@ -139,8 +141,7 @@ int device_match_any(struct device *dev, const void *unused);
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


