Return-Path: <linux-kernel+bounces-376166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 261B49AA107
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 13:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 558E11C2256D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 11:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEB619CC00;
	Tue, 22 Oct 2024 11:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="g5Lk2zvE"
Received: from pv50p00im-zteg10011501.me.com (pv50p00im-zteg10011501.me.com [17.58.6.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BD119C578
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 11:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729595949; cv=none; b=lUtDZxh2t/kE1LGsHOygFwBIH2Py/a1DrgqtkCJnTKmwnj0rPh6YEuDrArzSvFz/J/5eNZwQP32BbPpRfSblfgZjAmhcar6kGr13HAAx+70PQ0XFvSndTe+Xk6Z2aqNrw/ohqKfoL/kASIuu7CKH387p9xYuAATykUQRYtbCrBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729595949; c=relaxed/simple;
	bh=Cqe+kWq47m2XsK3kmFGisV1NfYVWgyAGcB4tUNsqNEU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gn0Eb2aYDxU4SoI9An8irhXpi5YxWg8SlmguziLHyCauaP7j6Q25LYvOGoIvvsoFWc1epbihOPAUYSo3PjFW7pZdBhSdtWVVcpY/T99d7qEqTgOhqZH/O2Tay8W+MY69v23r5h4CTDVb8HDd/9E0DWxY8dm2OTn1TOK9UnO4mJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=g5Lk2zvE; arc=none smtp.client-ip=17.58.6.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1729595947;
	bh=J79Eu2I+ROINsSW9OWNNnHUMAZ6QbBJ6uVzFELs/tK8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=g5Lk2zvENh5Dz/D6Re01Lrv3BJYPn6JEy0JgwVI0V0USmoi+kAxHwPlurJTAYLN3N
	 ZbLo6nm9PS4K89aw5GWskPHOxiQOJoW5KVVr7a+OxQH0v3U3WWq4HalcCAZomamqio
	 uUTgLlOee6P8k8e89hzVbYyo3RKFC0krBmv8bP468KiLcT9Om90PjQaEaKV81RBOyd
	 u1KwuHIDAQFyjjGy+C8IIdmUC6nIJt9WNBRofuUvZCmN35HuFwnSlb39NlKD5kqR3y
	 cfv8KZgroUVNGYQrybZux5sXj4TrjrGB83aCWW1GzoqvditaUTNwhu72+plCSkqb0U
	 N0p/3q6poigGw==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10011501.me.com (Postfix) with ESMTPSA id 9D35B4A02E5;
	Tue, 22 Oct 2024 11:19:04 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Tue, 22 Oct 2024 19:18:02 +0800
Subject: [PATCH RESEND v2 2/2] driver core: bus: Correct API
 bus_rescan_devices() behavior
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241022-bus_match_unlikely-v2-2-1a6f8e6839a0@quicinc.com>
References: <20241022-bus_match_unlikely-v2-0-1a6f8e6839a0@quicinc.com>
In-Reply-To: <20241022-bus_match_unlikely-v2-0-1a6f8e6839a0@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-GUID: eqkGbaSvdI4MPDpxY8YmhaJvjnMIKfZf
X-Proofpoint-ORIG-GUID: eqkGbaSvdI4MPDpxY8YmhaJvjnMIKfZf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-22_10,2024-10-22_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0 clxscore=1015
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2410220073
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


