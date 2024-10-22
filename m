Return-Path: <linux-kernel+bounces-376165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DF79AA106
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 13:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF2D3284CC0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 11:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E11519C55C;
	Tue, 22 Oct 2024 11:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="I5D2D3X1"
Received: from pv50p00im-zteg10011501.me.com (pv50p00im-zteg10011501.me.com [17.58.6.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F2019B5B4
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 11:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729595945; cv=none; b=EMmJujQkXQJVN48Oi7V9o5QBXLVLOIqw0hOraRBaXFhLJWKGT40JPxhcIP5XYnBw2UupTpTcmiZDN/0xEMt/T+aLgMmauxMk//23aBOAVXjGnQrEl7PWL4DBk6nURQXk8Q5wApe/KRbeXJ8JRmwDbrsgizGUXVIHCFvDuIANeWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729595945; c=relaxed/simple;
	bh=FL72VzZm1QNC4bDsVSvIwR7iwa2FxHI8m9WiIsoTqYM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nEsDjmIsZKRqQ1vTzLqKWOaWJ1HlLcSHYmiTorI8Ef+ytWpxfJ2EB+O2BqxIDaP3mu052GfebLELpbSAZhdCrK3rFx1csoAocdQl/u4L2ih8S9WCaqG6LnZVp+rP0IMybeXLH3aMgLyHMhCwjxzdeaFmZKZ+F2sMhnl7khN3128=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=I5D2D3X1; arc=none smtp.client-ip=17.58.6.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1729595944;
	bh=OWYrCl91sGsazZIoWodu7Wr+r0nEaOLDk990QhU1S18=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=I5D2D3X1t3Z/a95obTeujnjPdN3buyyt2MiZ+/rATstYZ4TyqpqI1PcKuwLdcpibd
	 HidLSpSaMSv9G8YsZXxhJTOFkC1koTiXr9wrnSknQR0hu71nxCaOY82iGwpm828muq
	 ZCaWtsa89+Fm/YK1S8+4O9f03pgLJTQ+jd2J3USNmHPoVva4Q0kNE7lgragQuqX9zn
	 BwZWPjHbg4UmsM8K9y94SC6IyG1HHFh74/TIKXE6969+wa9dvLfe8HFniT54Y9lg2M
	 NxnecgJ9+OMeCMqfEg+W/mOxSK7AmRRu0DO1ZMYNZ0xSM/WxCKhNIw49VtZH3xrtF4
	 qMWXemExllWGg==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10011501.me.com (Postfix) with ESMTPSA id 4C65E4A00E5;
	Tue, 22 Oct 2024 11:19:00 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Tue, 22 Oct 2024 19:18:01 +0800
Subject: [PATCH RESEND v2 1/2] driver core: bus: Fix drivers_probe_store()
 giving user wrong scanning result
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241022-bus_match_unlikely-v2-1-1a6f8e6839a0@quicinc.com>
References: <20241022-bus_match_unlikely-v2-0-1a6f8e6839a0@quicinc.com>
In-Reply-To: <20241022-bus_match_unlikely-v2-0-1a6f8e6839a0@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-GUID: gylqPoLsLRK2t8N6F7B_tBB-AhziqfRX
X-Proofpoint-ORIG-GUID: gylqPoLsLRK2t8N6F7B_tBB-AhziqfRX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-22_10,2024-10-22_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0 clxscore=1015
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2410220073
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


