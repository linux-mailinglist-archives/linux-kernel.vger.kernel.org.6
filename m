Return-Path: <linux-kernel+bounces-327420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A49D9775B4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 01:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57A851C24261
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 23:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF94F1C3F03;
	Thu, 12 Sep 2024 23:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="R3rELtJJ"
Received: from mr85p00im-ztdg06021701.me.com (mr85p00im-ztdg06021701.me.com [17.58.23.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6397192D61
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 23:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726184730; cv=none; b=QCz/XaVu7cRm8zxYmxkcdyUyPcCsV0bCRyT1C+W4ANhStMMh9MFUnP0KI2ChOn6I8vwyXuTMcpqFUftQzrpmg2qeQ4J7oE9mMk+kke0BIZbl3HHpdHNLd5PNGVnb8gLLjX8w5A8tP96+UTNGZa8vMd/do6fGzsJrUItLKgUoyO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726184730; c=relaxed/simple;
	bh=FL72VzZm1QNC4bDsVSvIwR7iwa2FxHI8m9WiIsoTqYM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NE4L/5y96TrAwWMqNNBAAgLNKBPTEQgJXR44hJc6KvsNlAHQg3hwIFhZbg95ftYDWMi56B0tjfBNRviVnHrNIIVg0kC+rUxIQkxIiiH9Jxn/NW/yoBenrM8ftJkGeCjwUN/dUrDP2xA0+TX2RhKCjPDqYODRGQT9/msZDyAS/AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=R3rELtJJ; arc=none smtp.client-ip=17.58.23.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1726184728;
	bh=OWYrCl91sGsazZIoWodu7Wr+r0nEaOLDk990QhU1S18=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=R3rELtJJFdVjz12yxfFyAMUhLtMjHGexM4tBM9ZRK+xPSJNfbEJsjphsPqO69KBfP
	 Eg8C5XBowEH/PM/zCIZQ8wxQZYIUZm+db1yA1OX4PYUfz+AoIbASiLh4Kq7j2Y/Wov
	 gwTbVlVLEgf0T/TmO+sQWrNjRDPTkcHUaTSTCraGjfEdZvGkGi3iUKabutgmu6m789
	 hkRfPoxHCRhOSaJelFarKgkBojITwQ4bl6y7xSjJ4rbqmoLDFfeJBSMHBg+uGe/ZyQ
	 75yGPV+gfQLCfl/gdcamQogD92zeOrDgIQbS+T32YJPAQLfXYAyPjqJr3HFvGzQYji
	 8LNDuUyqfivyw==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06021701.me.com (Postfix) with ESMTPSA id 7A4EA2633439;
	Thu, 12 Sep 2024 23:45:26 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Fri, 13 Sep 2024 07:45:10 +0800
Subject: [PATCH v2 1/2] driver core: bus: Fix drivers_probe_store() giving
 user wrong scanning result
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240913-bus_match_unlikely-v2-1-5c0c3bfda2f6@quicinc.com>
References: <20240913-bus_match_unlikely-v2-0-5c0c3bfda2f6@quicinc.com>
In-Reply-To: <20240913-bus_match_unlikely-v2-0-5c0c3bfda2f6@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-GUID: -VXpWc3Lma8v_L7olFHHRYVJmxr4oFCr
X-Proofpoint-ORIG-GUID: -VXpWc3Lma8v_L7olFHHRYVJmxr4oFCr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-12_10,2024-09-12_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 clxscore=1015 adultscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2409120171
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

drivers_probe_store(), as store() of bus attribute drivers_probe, may give
user wrong scanning result as explained below when user scans drivers for
a single device synchronously via the attribute:

- It wrongly collapses bus_rescan_devices_helper()'s various error
  return values as -EINVAL, that is not expected since user may want
  precise scanning result.

- It wrongly regards bus_rescan_devices_helper()'s return value 0 as
  success since the following failed cases also return 0:

  (1) the device is dead.
  (2) bus has no driver which match() the device.
  (3) bus fails to probe() the device with all its drivers.

Fixed by giving user precise scanning result or right prompt via
static bus_rescan_single_device() implemented for scanning drivers
for a single device.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/base/bus.c | 42 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 657c93c38b0d..4b5958c5ee7d 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -40,6 +40,24 @@ static struct kset *bus_kset;
 	struct driver_attribute driver_attr_##_name =		\
 		__ATTR_IGNORE_LOCKDEP(_name, _mode, _show, _store)
 
+/*
+ *  Bus rescans drivers for a single device, and derives from
+ *  bus_rescan_devices_helper(), but returns scanning result
+ *  as precise as possible.
+ */
+static int __must_check bus_rescan_single_device(struct device *dev)
+{
+	int ret;
+
+	if (dev->parent && dev->bus->need_parent_lock)
+		device_lock(dev->parent);
+	ret = device_attach(dev);
+	if (dev->parent && dev->bus->need_parent_lock)
+		device_unlock(dev->parent);
+
+	return ret;
+}
+
 static int __must_check bus_rescan_devices_helper(struct device *dev,
 						void *data);
 
@@ -310,13 +328,33 @@ static ssize_t drivers_probe_store(const struct bus_type *bus,
 				   const char *buf, size_t count)
 {
 	struct device *dev;
-	int err = -EINVAL;
+	int err;
+	int res;
 
 	dev = bus_find_device_by_name(bus, NULL, buf);
 	if (!dev)
 		return -ENODEV;
-	if (bus_rescan_devices_helper(dev, NULL) == 0)
+
+	res = bus_rescan_single_device(dev);
+	if (res < 0) {
+		/*
+		 * Give user known -EAGAIN in case of internal
+		 * -EPROBE_DEFER, and propagate error code upwards
+		 * as precise as possible.
+		 */
+		err = res == -EPROBE_DEFER ? -EAGAIN : res;
+	} else if (res > 0) {
 		err = count;
+	} else {
+		/*
+		 * Which error code to return for such synchronous
+		 * probing result ?
+		 */
+		dev_err(dev, "device '%s' fails to attach a driver\n",
+			dev_name(dev));
+		err = count;
+	}
+
 	put_device(dev);
 	return err;
 }

-- 
2.34.1


