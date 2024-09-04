Return-Path: <linux-kernel+bounces-315061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C83196BD64
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50643B248E7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 12:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C066D1DA103;
	Wed,  4 Sep 2024 12:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="toputa6n"
Received: from pv50p00im-ztdg10022001.me.com (pv50p00im-ztdg10022001.me.com [17.58.6.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91D11DA0F5
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 12:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725454649; cv=none; b=dzemU1wY8PGZSMIVXp7MPDHsCeMjJCuVccSiq9Maqy84L1K6Dhfk3D6fYZIxDaDiJ27UkxZnvprSbT02kp5j1w4vJEl1692KrcqTMgrH/kymGs9M0zrD966tgubSUnuWNRhJBeHu5v5I7JIx4o0i+aAfkQ6b1a458g+c2Apv4/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725454649; c=relaxed/simple;
	bh=ZEg2jAnsQ/Fo5b8FKY3/N90ULjhnrmM1sqPGIRzc6P4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c6rTde2rNxEAlsxbw8/JJpUm3X7mf+lqbRHIL8/7tlxBBD77tdEEaDexupKAvNJX6gAzCIvZpNrSTNMlWohELad5Cy5OlJq2bbqrIkCy3mfDa6zeMaQamaR75QnCMis2Ujkxz8Ky/tWlRfGN9wXTbqzuNhihTU0hkTkzBYZ6qkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=toputa6n; arc=none smtp.client-ip=17.58.6.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1725454647;
	bh=rX8dwEmhgju52/+PCj7lxlcgxu0hlSH5RuwIYsL1waE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=toputa6nimElw1oFag56SBL4AKV76uu+IZeWVYufs2lIwvjYT2T0iiqy8n4Lmp/vz
	 SC6FcYsd3aYiRFaOnRJT/oX7WanC+H2o+xQouLqcjoD1yKSpF6qjFyjMQgrINmG5iF
	 ASe+/006zQ93tQrm2jllKCBBUT6B+DjHV1bJ139Zp9a7tR6uFAi+nVKGSXCHSYhSuO
	 TfkTpt+mUmGHSOHc8UQcNXwQRxZDDie1SmE/rMtj1rQD8JC8zFWueclssW7MXB1QXI
	 wPJOIVxDbZvD55+h9loHBD/SQOqaicSW1hzxMk+VNaeKIcX2msgS/nBccdC/SjjyCi
	 0rTkqPcfdBTkQ==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10022001.me.com (Postfix) with ESMTPSA id 8D84B3E1BCE;
	Wed,  4 Sep 2024 12:57:21 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Wed, 04 Sep 2024 20:56:42 +0800
Subject: [PATCH 1/3] driver core: Mark impossible return values of
 bus_type's match() with unlikely()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240904-bus_match_unlikely-v1-1-122318285261@quicinc.com>
References: <20240904-bus_match_unlikely-v1-0-122318285261@quicinc.com>
In-Reply-To: <20240904-bus_match_unlikely-v1-0-122318285261@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-ORIG-GUID: bpzyUHiC-Subvd0QIw1TE-LCkq-8udJp
X-Proofpoint-GUID: bpzyUHiC-Subvd0QIw1TE-LCkq-8udJp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_10,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 mlxlogscore=999
 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0 mlxscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2409040098
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

Bus_type's match() should return bool type compatible integer 0 or 1
ideally since its main operations are lookup and comparison normally
actually, this rule is followed by ALL bus_types but @amba_bustype within
current v6.10 kernel tree, for @amba_bustype, ONLY extra -EPROBE_DEFER
may be returned, so mark those impossible or rare return values with
unlikely() to help readers understand device and driver binding logic.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/base/dd.c          | 16 ++++++++++++----
 include/linux/device/bus.h |  9 ++++-----
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 9b745ba54de1..288e19c9854b 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -928,7 +928,11 @@ static int __device_attach_driver(struct device_driver *drv, void *_data)
 	if (ret == 0) {
 		/* no match */
 		return 0;
-	} else if (ret == -EPROBE_DEFER) {
+	} else if (unlikely(ret == -EPROBE_DEFER)) {
+		/*
+		 * Only match() of @amba_bustype may return this error
+		 * in current v6.10 tree, so also give unlikely() here.
+		 */
 		dev_dbg(dev, "Device match requests probe deferral\n");
 		dev->can_match = true;
 		driver_deferred_probe_add(dev);
@@ -937,7 +941,7 @@ static int __device_attach_driver(struct device_driver *drv, void *_data)
 		 * to match or bind with other drivers on the bus.
 		 */
 		return ret;
-	} else if (ret < 0) {
+	} else if (unlikely(ret < 0)) {
 		dev_dbg(dev, "Bus failed to match device: %d\n", ret);
 		return ret;
 	} /* ret > 0 means positive match */
@@ -1172,7 +1176,11 @@ static int __driver_attach(struct device *dev, void *data)
 	if (ret == 0) {
 		/* no match */
 		return 0;
-	} else if (ret == -EPROBE_DEFER) {
+	} else if (unlikely(ret == -EPROBE_DEFER)) {
+		/*
+		 * Only match() of @amba_bustype may return this error
+		 * in current v6.10 tree, so also give unlikely() here.
+		 */
 		dev_dbg(dev, "Device match requests probe deferral\n");
 		dev->can_match = true;
 		driver_deferred_probe_add(dev);
@@ -1181,7 +1189,7 @@ static int __driver_attach(struct device *dev, void *data)
 		 * another device on the bus.
 		 */
 		return 0;
-	} else if (ret < 0) {
+	} else if (unlikely(ret < 0)) {
 		dev_dbg(dev, "Bus failed to match device: %d\n", ret);
 		/*
 		 * Driver could not match with device, but may match with
diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
index 807831d6bf0f..1766b555da11 100644
--- a/include/linux/device/bus.h
+++ b/include/linux/device/bus.h
@@ -29,12 +29,11 @@ struct fwnode_handle;
  * @bus_groups:	Default attributes of the bus.
  * @dev_groups:	Default attributes of the devices on the bus.
  * @drv_groups: Default attributes of the device drivers on the bus.
- * @match:	Called, perhaps multiple times, whenever a new device or driver
- *		is added for this bus. It should return a positive value if the
+ * @match:	Called, perhaps multiple times, whenever a new device or
+ *		driver is added for this bus. It should return one if the
  *		given device can be handled by the given driver and zero
- *		otherwise. It may also return error code if determining that
- *		the driver supports the device is not possible. In case of
- *		-EPROBE_DEFER it will queue the device for deferred probing.
+ *		otherwise. It may also return -EPROBE_DEFER to queue the
+ *		device for deferred probing.
  * @uevent:	Called when a device is added, removed, or a few other things
  *		that generate uevents to add the environment variables.
  * @probe:	Called when a new device or driver add to this bus, and callback

-- 
2.34.1


