Return-Path: <linux-kernel+bounces-320457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD4A970AA6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 01:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEEBF1F211A6
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 23:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9D917ADF8;
	Sun,  8 Sep 2024 23:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="uwXedOmV"
Received: from mr85p00im-zteg06023901.me.com (mr85p00im-zteg06023901.me.com [17.58.23.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8B317C208
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 23:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725838716; cv=none; b=sd2bEYP09aKaR4aVFVOyr7yR0hU6HT9poTDwVP+TD4DK2xYwhZe2ODG0ROhYPP9ZJbcYtllJ7ZGjl1iR7I2lm8HkYKa++ALqIMCWVnfc5XGM4dmsRY5MjjniY86Z1Cw474Yu0wqPPFTSDlte0ZiCj2eRLg90ttfE6ZRSY64B6b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725838716; c=relaxed/simple;
	bh=uWaOcfMMfJXcjYHMiEtC9LNnAQKvtt3bLCQ3Him1Y0Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u/fzHXXEZzJsSU/BnG59jTGGh7FFiLIBYCXuGlXLeG0Ri8oubxegi6sm5wvelraMqYjxbaVCrFarHptolyJmsULMXpmEaPOVTu4VxiDD12YwRffVmsGcJXHmAJDgTuewnDGzGOD4K76+AfzDCFcVkqzmk+3mwjTXC3bQqXzYlBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=uwXedOmV; arc=none smtp.client-ip=17.58.23.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1725838714;
	bh=BWYyyhPkQKgvt6XCeEIJeakBSGkMZ4g54p2RGBWbFCk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=uwXedOmVcG3kHhm3O2rS9SQ6DOxEyBq2F9rQxVqGEM/Ny86+2t5rOhSlybiodLJUl
	 aYWREgm+5SSpiT96UH0Qusep4FB7OZMedLM+iYITf17VlLeUxEILwNdYehdvD1dnTv
	 p+wSAAr68ietf8NC++40wRXBqUvCLKVQpVcK+VNLOJZxGxw4QfWRbX/v4+TTR7M0+y
	 UWVZML80Pl6tQIUMxyfOhxn3IhpgsKv5yfzw9JgG+LARFfWo08PRFP7rA8cWG7QOdG
	 27ntFmn591fyAGBysO1vqAeYWk0zvi7oRgJFnB638N3SdYIblx6h61xjU/EAeb6Dsr
	 ECInCbLFuA28g==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-zteg06023901.me.com (Postfix) with ESMTPSA id 6EE2E6E02B7;
	Sun,  8 Sep 2024 23:38:30 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Mon, 09 Sep 2024 07:37:34 +0800
Subject: [PATCH RFC 3/3] amba: bus: Move reading periphid operation from
 amba_match() to amba_probe()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240909-fix_amba-v1-3-4658eed26906@quicinc.com>
References: <20240909-fix_amba-v1-0-4658eed26906@quicinc.com>
In-Reply-To: <20240909-fix_amba-v1-0-4658eed26906@quicinc.com>
To: Russell King <linux@armlinux.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Saravana Kannan <saravanak@google.com>, 
 Isaac Manjarres <isaacmanjarres@google.com>, 
 Lu Baolu <baolu.lu@linux.intel.com>, Zijun Hu <zijun_hu@icloud.com>, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-GUID: yUpPkcwyxvcr_32AUNjTe1g1v9WeJe6s
X-Proofpoint-ORIG-GUID: yUpPkcwyxvcr_32AUNjTe1g1v9WeJe6s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-08_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 clxscore=1015 mlxlogscore=999 suspectscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2409080205
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

amba_match(), as bus_type @amba_bustype's match(), reads periphid from
hardware and may return -EPROBE_DEFER consequently, and it is the only
one that breaks below ideal rule in current kernel tree:

bus_type's match() should only return bool type compatible integer 0 or
1 ideally since its main operations are lookup and comparison normally.

fixed by moving reading periphid operation to amba_probe().

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/amba/bus.c       | 55 +++++++++++++++++++++++++++++-------------------
 include/linux/amba/bus.h |  1 -
 2 files changed, 33 insertions(+), 23 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 033d626aff46..8fe2e054b5ce 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -188,7 +188,7 @@ static int amba_read_periphid(struct amba_device *dev)
 	}
 
 	if (cid == AMBA_CID || cid == CORESIGHT_CID) {
-		dev->periphid = pid;
+		WRITE_ONCE(dev->periphid, pid);
 		dev->cid = cid;
 	}
 
@@ -246,24 +246,14 @@ static int amba_match(struct device *dev, const struct device_driver *drv)
 	struct amba_device *pcdev = to_amba_device(dev);
 	const struct amba_driver *pcdrv = to_amba_driver(drv);
 
-	mutex_lock(&pcdev->periphid_lock);
-	if (!pcdev->periphid) {
-		int ret = amba_read_periphid(pcdev);
-
-		/*
-		 * Returning any error other than -EPROBE_DEFER from bus match
-		 * can cause driver registration failure. So, if there's a
-		 * permanent failure in reading pid and cid, simply map it to
-		 * -EPROBE_DEFER.
-		 */
-		if (ret) {
-			mutex_unlock(&pcdev->periphid_lock);
-			return -EPROBE_DEFER;
-		}
-		dev_set_uevent_suppress(dev, false);
-		kobject_uevent(&dev->kobj, KOBJ_ADD);
-	}
-	mutex_unlock(&pcdev->periphid_lock);
+	/*
+	 * For an AMBA device without valid periphid, only read periphid
+	 * in amba_probe() for it when try to bind @amba_proxy_drv.
+	 * For @pcdev->periphid, Reading here has a little race with
+	 * writing in amba_probe().
+	 */
+	if (!READ_ONCE(pcdev->periphid))
+		return pcdrv == &amba_proxy_drv ? 1 : 0;
 
 	/* When driver_override is set, only bind to the matching driver */
 	if (pcdev->driver_override)
@@ -315,10 +305,24 @@ static int amba_probe(struct device *dev)
 {
 	struct amba_device *pcdev = to_amba_device(dev);
 	struct amba_driver *pcdrv = to_amba_driver(dev->driver);
-	const struct amba_id *id = amba_lookup(pcdrv->id_table, pcdev);
+	const struct amba_id *id;
 	int ret;
 
 	do {
+		if (!pcdev->periphid) {
+			ret = amba_read_periphid(pcdev);
+			if (ret) {
+				dev_err_probe(dev, ret, "failed to read periphid\n");
+			} else {
+				dev_set_uevent_suppress(dev, false);
+				kobject_uevent(&dev->kobj, KOBJ_ADD);
+			}
+
+			ret = -EPROBE_DEFER;
+			break;
+		}
+		id = amba_lookup(pcdrv->id_table, pcdev);
+
 		ret = of_amba_device_decode_irq(pcdev);
 		if (ret)
 			break;
@@ -389,10 +393,15 @@ static void amba_shutdown(struct device *dev)
 
 static int amba_dma_configure(struct device *dev)
 {
+	struct amba_device *pcdev = to_amba_device(dev);
 	struct amba_driver *drv = to_amba_driver(dev->driver);
 	enum dev_dma_attr attr;
 	int ret = 0;
 
+	/* To successfully go to amba_probe() to read periphid */
+	if (!pcdev->periphid)
+		return 0;
+
 	if (dev->of_node) {
 		ret = of_dma_configure(dev, dev->of_node, true);
 	} else if (has_acpi_companion(dev)) {
@@ -411,8 +420,12 @@ static int amba_dma_configure(struct device *dev)
 
 static void amba_dma_cleanup(struct device *dev)
 {
+	struct amba_device *pcdev = to_amba_device(dev);
 	struct amba_driver *drv = to_amba_driver(dev->driver);
 
+	if (!pcdev->periphid)
+		return;
+
 	if (!drv->driver_managed_dma)
 		iommu_device_unuse_default_domain(dev);
 }
@@ -535,7 +548,6 @@ static void amba_device_release(struct device *dev)
 	fwnode_handle_put(dev_fwnode(&d->dev));
 	if (d->res.parent)
 		release_resource(&d->res);
-	mutex_destroy(&d->periphid_lock);
 	kfree(d);
 }
 
@@ -593,7 +605,6 @@ static void amba_device_initialize(struct amba_device *dev, const char *name)
 	dev->dev.dma_mask = &dev->dev.coherent_dma_mask;
 	dev->dev.dma_parms = &dev->dma_parms;
 	dev->res.name = dev_name(&dev->dev);
-	mutex_init(&dev->periphid_lock);
 }
 
 /**
diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
index 958a55bcc708..4bb3467d9c3d 100644
--- a/include/linux/amba/bus.h
+++ b/include/linux/amba/bus.h
@@ -67,7 +67,6 @@ struct amba_device {
 	struct clk		*pclk;
 	struct device_dma_parameters dma_parms;
 	unsigned int		periphid;
-	struct mutex		periphid_lock;
 	unsigned int		cid;
 	struct amba_cs_uci_id	uci;
 	unsigned int		irq[AMBA_NR_IRQS];

-- 
2.34.1


