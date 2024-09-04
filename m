Return-Path: <linux-kernel+bounces-315062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A56FE96BD69
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7A6B1C24D22
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 12:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D838C1DA2E4;
	Wed,  4 Sep 2024 12:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="jQTP63Pp"
Received: from pv50p00im-ztdg10022001.me.com (pv50p00im-ztdg10022001.me.com [17.58.6.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138201DA10C
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 12:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725454655; cv=none; b=WkqcuqpApciXPJojFuNQPDOrqtlFR+FvOip8D9whEauB3sRtNJclx1dGAqB6RL2NdRQVJosYI05036+Eaam5OY/u6wRfa1mF3b1eX15MPuthBr83NzxP2/+XzojH/4MpDU0Fo2AzhyCfcY/tSNBXve2YQ5HNc/N1rO8TQQeXWwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725454655; c=relaxed/simple;
	bh=X0mSMn30a3AM9Vuk9D3MfNP4x92YRiSgqmkv64Gh6VU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JUWiww01FDuatlgxybvkl2wAFYZ/HaigG4Oqel/Dnmvhh25TKFlT9025iV0cTxK/aiXjvkOIAZ211Eao6edRqPDCVyjgyuyzTkJHfA4Z18OwFE+lvcUgJZliC4VcQwEaEJrbdxmX8ld/eGYExPtY2UYwSU2ADpLbPV6YXMh+Ty0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=jQTP63Pp; arc=none smtp.client-ip=17.58.6.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1725454653;
	bh=eUzdIGebnt7Wgvw4BOsrdf+21i++2ln1njvI6A+j+cM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=jQTP63PpYJajkbwhceGWbWdwEN3IKGl/vzCu5cEDp/tq8E9UHy6OluL0famQl4wil
	 viIqAIXDww3JtedOrfCKadO0W6eQqj9f4q7BmEFsN6Bn0g2CBxx1kyNlB13Z9KX6HY
	 PAWMca40bn0yhQw5wEX5N2bRiX4wmW/pgDYU5DqujLXlgyolfzLI5W9/c8cbOjur9D
	 w/obtbYDlk5ONGvuDPp2A7LmB5J/2xtvSZFdC5M8y+unbHGq47Eynpg5jPX1EHf2OL
	 ow/t54iAGgEIBe1oAQRVR6hq8+t9d7DjLjBa2Ea/z5KhImVfp5Ciam0KgpslfMyupJ
	 Y79KkFs9IT7uQ==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10022001.me.com (Postfix) with ESMTPSA id 29B183E215E;
	Wed,  4 Sep 2024 12:57:27 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Wed, 04 Sep 2024 20:56:43 +0800
Subject: [PATCH 2/3] driver core: bus: Give error prompt for storing bus
 attribute drivers_probe failure
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240904-bus_match_unlikely-v1-2-122318285261@quicinc.com>
References: <20240904-bus_match_unlikely-v1-0-122318285261@quicinc.com>
In-Reply-To: <20240904-bus_match_unlikely-v1-0-122318285261@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-ORIG-GUID: kjP1pUwr3kXEt5sgKnW6CaTL9I4SwQMA
X-Proofpoint-GUID: kjP1pUwr3kXEt5sgKnW6CaTL9I4SwQMA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_10,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 mlxlogscore=911
 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0 mlxscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2409040098
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

drivers_probe_store() regards bus_rescan_devices_helper()'s returned
value 0 as success when scan drivers for a single device user specify
that is wrong since the following 3 failed cases also return 0:

(1) the device is dead
(2) bus has no driver which match() the device
(3) bus fails to probe() the device with any its driver

Solved by giving error prompt via dev_err() for above failed cases.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/base/bus.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index abf090ace833..6b5ea82a44c1 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -40,6 +40,24 @@ static struct kset *bus_kset;
 	struct driver_attribute driver_attr_##_name =		\
 		__ATTR_IGNORE_LOCKDEP(_name, _mode, _show, _store)
 
+/*
+ *  Bus scans drivers for a single device, and derives from
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
 
@@ -311,12 +329,25 @@ static ssize_t drivers_probe_store(const struct bus_type *bus,
 {
 	struct device *dev;
 	int err = -EINVAL;
+	int res;
 
 	dev = bus_find_device_by_name(bus, NULL, buf);
 	if (!dev)
 		return -ENODEV;
-	if (bus_rescan_devices_helper(dev, NULL) == 0)
+
+	res = bus_rescan_single_device(dev);
+	if (res < 0) {
+		/* Propagate error code upwards as precise as possible */
+		err = res;
+	} else if (res > 0) {
 		err = count;
+	} else {
+		/* Which error code to return for this case ? */
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


