Return-Path: <linux-kernel+bounces-327421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5569775B5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 01:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D64A1C240E3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 23:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99DB1C3F39;
	Thu, 12 Sep 2024 23:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="cIhHpa6V"
Received: from mr85p00im-ztdg06021701.me.com (mr85p00im-ztdg06021701.me.com [17.58.23.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101DE1C3F16
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 23:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726184732; cv=none; b=oeZ1helw+EZbhictl85oyTSafQ2hJYKD4IuUymC186pdmfAfi9HK+RHQMnJuPxJe5kbNE0gln1GrRsUGi5tDNgile2Vf7OvSx23YFwx/czWo2gmt+w7YvCHBeNpGrUydMU4RFa5UPpevIgPkt6mYE9qBp0fqEgEvoQr456kjRn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726184732; c=relaxed/simple;
	bh=Cqe+kWq47m2XsK3kmFGisV1NfYVWgyAGcB4tUNsqNEU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tkxQ+Mm5rap1ryHy+T1mr7qWFEIa4A0BJcs8eBhAjuWTGmWMTKlf5pB1xxYBscJP4ArWuGebeI+hfkxrbWcMtqPti/ISxNIDYaZec01brCrCKjrueZz5K8IGVtYwyAg6fPyjiHwbsSUpo+x0+9TXB0t7Whcl5FdVIfS8PIcZjiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=cIhHpa6V; arc=none smtp.client-ip=17.58.23.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1726184730;
	bh=J79Eu2I+ROINsSW9OWNNnHUMAZ6QbBJ6uVzFELs/tK8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=cIhHpa6VKs7q45D+dZRXXkr2P/AexmMPuozUEK8gvb4PBYJFXG4weF4RCCHTi7icZ
	 eI8sRZ1sUJz5LlOi6eELEy2y8UpP366q7usVZNlh2gwjLeKVfl874Z9W2AAEvDOecE
	 vvxe37qIgzrqb/G4Cgi78+bMNDTt4c/oRhVfD/oGhIGea49t++Hoog5+HDMD0jWT+w
	 +ZmqGBqc+Mfds9XC+rxR3wJwgEx/l94hnJOVi7ZUJyIgXgVlFW555DBvCxGqRPDgtk
	 R+fsH3+0kBbivaEj30UgpwJXkLIz//M9pEfUKQo+fjMHzj9n+NKnb4ci8gKaHxln56
	 0/hPEjJShPh7Q==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06021701.me.com (Postfix) with ESMTPSA id CAC6426333D0;
	Thu, 12 Sep 2024 23:45:28 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Fri, 13 Sep 2024 07:45:11 +0800
Subject: [PATCH v2 2/2] driver core: bus: Correct API bus_rescan_devices()
 behavior
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240913-bus_match_unlikely-v2-2-5c0c3bfda2f6@quicinc.com>
References: <20240913-bus_match_unlikely-v2-0-5c0c3bfda2f6@quicinc.com>
In-Reply-To: <20240913-bus_match_unlikely-v2-0-5c0c3bfda2f6@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-GUID: TGewEJwZtIE7Y8iAUsjTOARvllsaqNgO
X-Proofpoint-ORIG-GUID: TGewEJwZtIE7Y8iAUsjTOARvllsaqNgO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-12_10,2024-09-12_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 clxscore=1015 adultscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2409120171
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

API bus_rescan_devices() should ideally scan drivers for a bus's
devices as many as possible, but it will really stop scanning for
remaining devices even if a device encounters inconsequential errors
such as -EPROBE_DEFER, -ENODEV and -EBUSY, fixed by ignoring such
inconsequential errors and continue to scan drivers for next device.

By the way, in order to eliminate risk:
 - the API's return value is not changed by recording the first
   error code during scanning which is returned.
 - API device_reprobe()'s existing logic is not changed as well.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/base/bus.c | 38 +++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 4b5958c5ee7d..fa68acd55bf8 100644
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
@@ -797,15 +794,23 @@ static int __must_check bus_rescan_devices_helper(struct device *dev,
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
+
+	if (!*first_error)
+		*first_error = ret;
+	/*
+	 * Ignore these inconsequential errors and continue to
+	 * scan drivers for next device.
+	 */
+	if (ret == -EPROBE_DEFER || ret == -ENODEV || ret == -EBUSY)
+		return 0;
+
+	return ret;
 }
 
 /**
@@ -818,7 +823,10 @@ static int __must_check bus_rescan_devices_helper(struct device *dev,
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
 
@@ -833,9 +841,13 @@ EXPORT_SYMBOL_GPL(bus_rescan_devices);
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


