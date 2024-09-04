Return-Path: <linux-kernel+bounces-315064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F86396BD6C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 821471C24D0C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 12:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE441DA30E;
	Wed,  4 Sep 2024 12:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="BJH1Gwvd"
Received: from pv50p00im-ztdg10022001.me.com (pv50p00im-ztdg10022001.me.com [17.58.6.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F911D9D99
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 12:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725454661; cv=none; b=pYfkxr/Kzdj2HvGs+NP0hsjh6PCxGsvZQ+eUzzbJBJHJ2GvYSUiQCG73FIBro4U+VyOq8yZRAPQMEVpl5OQFxsyiA/mcWZPWm2J50J3Oc7GGtJ3L9QAd3Di5tNRVgAgfMBVy4UDGALynAkT1hXjCXlr3J62fV6DVvL+ax6ApcRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725454661; c=relaxed/simple;
	bh=fzj/oclTmnCHB3hbiGEklL8+S9AfRLTq+SRiNp9ZtQI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J7J7QZbaa5X/VgeKSwYcqs28Yj5TMVuWP9uayJgLMMWGpbT3JhN5HRmcfHAI4+jhaVVosYXkOpvYOsJQlb3gNa+cKcUn9WMT1TjwvD8qm4l4gTFkFOrOJIqNmIgsHPKpgBqY9Utjl1kyzJrQJ1tDUHwCAQ30+VAlP+b5gxozyP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=BJH1Gwvd; arc=none smtp.client-ip=17.58.6.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1725454659;
	bh=idcU0ReTbtAFWE8j/+dTR9RAS+21qVyWNpl+uT4Ko4o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=BJH1Gwvd0VetAtEkyuSPfMfWvQD4c48kwYIku7uDj4paoJRSEVvUjG3n4YbUEmCAc
	 4I+OHCa64xGyxdwIX1Kt4XFmxRgwQ8SmSD2SCLr3GN2H1F10xpLrHhtDU0CKptRio9
	 nBN7FcZ1l0DqanZUZoK/Qgqqsqyr8LBp+ycIbgfV6mf9E/9I4ehkJbg3vA3mb9dAwv
	 y6kqlGZhIe9Y52FJ6CGFMPlJmCJMhmWCYcmuLXiUwaUCMejG9jiEAMYX/FbVRdvyI9
	 jyBk+Mq9wBVfjUjlM5Qrad+F0G+W87rTuQBgKUnrxw0zYiZHApI5oKy4LsxV2VqAhZ
	 q5qtqGSLX1+bg==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10022001.me.com (Postfix) with ESMTPSA id 6C7353E217F;
	Wed,  4 Sep 2024 12:57:33 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Wed, 04 Sep 2024 20:56:44 +0800
Subject: [PATCH 3/3] driver core: bus: Correct API bus_rescan_devices()
 behavior
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240904-bus_match_unlikely-v1-3-122318285261@quicinc.com>
References: <20240904-bus_match_unlikely-v1-0-122318285261@quicinc.com>
In-Reply-To: <20240904-bus_match_unlikely-v1-0-122318285261@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-ORIG-GUID: C6QhOV54FmcYX6wKBFioCQXDjr5uthgS
X-Proofpoint-GUID: C6QhOV54FmcYX6wKBFioCQXDjr5uthgS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_10,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 mlxlogscore=999
 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0 mlxscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2409040098
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

API bus_rescan_devices() should ideally scan drivers for a bus's devices
as many as possible, but it really stops scanning for remaining devices
even if a device encounters inconsequential errors such as -EPROBE_DEFER
and -ENODEV, fixed by ignoring such inconsequential errors during scanning.

By the way, Neither the API's return value nor device_reprobe()'s existing
logic are changed.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/base/bus.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 6b5ea82a44c1..31d9d5d08934 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -58,9 +58,6 @@ static int __must_check bus_rescan_single_device(struct device *dev)
 	return ret;
 }
 
-static int __must_check bus_rescan_devices_helper(struct device *dev,
-						void *data);
-
 /**
  * bus_to_subsys - Turn a struct bus_type into a struct subsys_private
  *
@@ -790,15 +787,18 @@ static int __must_check bus_rescan_devices_helper(struct device *dev,
 						  void *data)
 {
 	int ret = 0;
+	int *first_error = data;
 
-	if (!dev->driver) {
-		if (dev->parent && dev->bus->need_parent_lock)
-			device_lock(dev->parent);
-		ret = device_attach(dev);
-		if (dev->parent && dev->bus->need_parent_lock)
-			device_unlock(dev->parent);
-	}
-	return ret < 0 ? ret : 0;
+	ret = bus_rescan_single_device(dev);
+
+	if (ret >= 0)
+		return 0;
+	if (!*first_error)
+		*first_error = ret;
+	/* Ignore these errors to scan drivers for next device */
+	if (ret == -EPROBE_DEFER || ret == -ENODEV)
+		return 0;
+	return ret;
 }
 
 /**
@@ -811,7 +811,10 @@ static int __must_check bus_rescan_devices_helper(struct device *dev,
  */
 int bus_rescan_devices(const struct bus_type *bus)
 {
-	return bus_for_each_dev(bus, NULL, NULL, bus_rescan_devices_helper);
+	int err = 0;
+
+	bus_for_each_dev(bus, NULL, &err, bus_rescan_devices_helper);
+	return err;
 }
 EXPORT_SYMBOL_GPL(bus_rescan_devices);
 
@@ -826,9 +829,13 @@ EXPORT_SYMBOL_GPL(bus_rescan_devices);
  */
 int device_reprobe(struct device *dev)
 {
+	int ret;
+
 	if (dev->driver)
 		device_driver_detach(dev);
-	return bus_rescan_devices_helper(dev, NULL);
+
+	ret = bus_rescan_single_device(dev);
+	return ret < 0 ? ret : 0;
 }
 EXPORT_SYMBOL_GPL(device_reprobe);
 

-- 
2.34.1


