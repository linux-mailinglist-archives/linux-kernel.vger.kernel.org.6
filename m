Return-Path: <linux-kernel+bounces-272464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFB0945C64
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 12:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D664A1F219A1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 10:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B301DE85D;
	Fri,  2 Aug 2024 10:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="Tx7fPMaD"
Received: from pv50p00im-ztdg10021801.me.com (pv50p00im-ztdg10021801.me.com [17.58.6.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CE8613D
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 10:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722595702; cv=none; b=BgpyO96QoaOfI7tafK3VrWjdJaFDl79IFaYDaWsCplUMM5MkDyLFSuulTvDTDjhj6Z5V/sAwun6NgseArydSxrSg98NnAKUdWlTQkMYs1jDReDzl4hJEYFDn837HThHuhuxXM7i0ttTXCkklmlUi0ZAAdrtihDf5NKWZgxtLcto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722595702; c=relaxed/simple;
	bh=RU3zo3OIdaLh992r68ZDg7aJsVTbxvL4JMw39G5BPJs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=He2/RhGmBNFbqtc3VBJlYYjW0OrEHZD3Of4/OJYCC/lOMWp/NYJZioS2uKeRA9nvUiACK/6u3p2+vcpJuEjfaGYur5bhfTFvuD0S0d8rA+cMcBLnwek+Yl4XQxWsrtxhW4yqavyTlVkSKXj82l4MwszPKbE22Q6q/yyYKWbABPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=Tx7fPMaD; arc=none smtp.client-ip=17.58.6.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1722595700;
	bh=thK7aRTeDy7sKkPlgnlG8KXlAkbo2acHHaukRDrH5qc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=Tx7fPMaDcOSppMUm/wkEpzSZ2E2CE0xaTFXwMPVdnWqP3EPHjXl9bakmJQOOItLbl
	 A8g2HmqwAH0BX/bx6PzXmBm4dYMmSD2XoTMVjA9qx00NoYi7scy9AlV9jJ6BMTTxEF
	 UPZbVDn5FQ642zyULlh6/4+OtmjmHvZJCtBhdfkrz//xE9onWgrxaJO1bm7MnJH1jX
	 2ste021F8TQS3q7i4g8fyMrvjH7ZTYvZfEUjuCffLYfwMMhIEhO9TD2m9hueSDJeqP
	 oRVB2CCH3JVAl8iaRskXOT1xgO4fisNCKdP/8NPsm3AYZdTq7mp5KIQySCLqXLmucH
	 FtkVUQyu30N0w==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10021801.me.com (Postfix) with ESMTPSA id CB3D72010244;
	Fri,  2 Aug 2024 10:48:16 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Fri, 02 Aug 2024 18:47:32 +0800
Subject: [PATCH] drivers/base: Introduce device_match_t for device finding
 APIs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240802-dev_match_api-v1-1-51e16d3bf031@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAEO5rGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDCwND3ZTUsvjcxJLkjPjEgkxdE0PTRHNT07TktLQkJaCegqLUtMwKsHn
 RsbW1APafWWZfAAAA
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-GUID: 55i8m-Md2sCk6a8OWxBIXgU2SFq8CNwq
X-Proofpoint-ORIG-GUID: 55i8m-Md2sCk6a8OWxBIXgU2SFq8CNwq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-02_07,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 clxscore=1011 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=924
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408020073
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
index ffea0728b8b2..0de6a389d000 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -389,7 +389,7 @@ EXPORT_SYMBOL_GPL(bus_for_each_dev);
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
base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
change-id: 20240801-dev_match_api-415a755fcffb

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


