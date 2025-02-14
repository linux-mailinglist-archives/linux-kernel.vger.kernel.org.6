Return-Path: <linux-kernel+bounces-514475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59AE5A3577C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 07:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2226116B9F6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 06:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395EF207DE0;
	Fri, 14 Feb 2025 06:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="btWSNc3J"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56A0205508;
	Fri, 14 Feb 2025 06:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739516350; cv=none; b=JRj+s7mVG2PC8jMxDJlasf5sXSFfRo76ck2NVS7vJXwzm7DKweMFe2DyZCQ8+/0PumvSMweDGfo62aeOC72ZluxqKCGGcoqFci6b0w0RlXoiibB9LZ03/gBwVLuKmETmqpO8Wlrn9jZFgDCYMJLnKr9cAQCWWAmES7pUgTlFbmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739516350; c=relaxed/simple;
	bh=cxvd0n5tZ9Co4v1NtZpsi4m2lUMAvbxNNnIddUvsBpg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aiy3ehLUI3n64q28uwTtKpRsvDPQDgrIKbIbpm9k23YwHaPs22V6w+0XjC3kKO7IqIP/rB8sTkvxPPLoG6I+JAjkzMuqtq5cnFDWWdToZJV7KbomaVcpHcTWdHmZFTdgPwiNscl3Z0rQxsxMUQxn9C1xNd6/HShWfpbSSJfFr58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=btWSNc3J; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51E5nq5w012357;
	Thu, 13 Feb 2025 22:58:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=E
	bA/KVCwx7GPIYciWZdmeejj9QWfhZNBSRDFNiyQfP0=; b=btWSNc3Ja9kUweW47
	AmQul8Zoekd4oI15F8fGsjQOiOg/2ZuVVy+9NGg0tYblqrfqBaoeh+8q2cYJUaDH
	SN+1aH52hlwbI9eh9tD1PnAUJRSMSdtgjr0VlvGr8arQmyiLq5AFEcGU8oip6oKU
	JcsZjjv4dKwoGoCjRXw1JAWOG/qwjV/piIBMj5Mo8f620CdTOnAVIRtHBG3r5o9B
	vFdgVlM1Zubvuhc1tjGxtBf2YpVdBbnRKVAlVI0yB+uKlWPeodgh15aU1nHdRbhq
	WIXAn7tLTcKuJjMvUXkzO5NhczVZnnDhsfbuoDV/LkQBkHcBXsQhWE+/qmrpVm3e
	Hzs8A==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 44t01f03e2-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 22:58:51 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 13 Feb 2025 22:58:46 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 13 Feb 2025 22:58:46 -0800
Received: from wd-ubuntu-24-04.marvell.com (wd-ubuntu-24-04.marvell.com [10.111.132.113])
	by maili.marvell.com (Postfix) with ESMTP id 486413F7090;
	Thu, 13 Feb 2025 22:58:46 -0800 (PST)
From: Wilson Ding <dingwei@marvell.com>
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC: <andrew@lunn.ch>, <gregory.clement@bootlin.com>,
        <sebastian.hesselbarth@gmail.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <p.zabel@pengutronix.de>,
        <salee@marvell.com>, <gakula@marvell.com>,
        Wilson Ding <dingwei@marvell.com>
Subject: [PATCH 1/4] [PATCH 1/4] reset: simple: Add syscon device compatible
Date: Thu, 13 Feb 2025 22:58:30 -0800
Message-ID: <20250214065833.530276-3-dingwei@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250214065833.530276-1-dingwei@marvell.com>
References: <20250214065833.530276-1-dingwei@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: dGXSIC5ZYvieHwJXRZGvhisSkrUNVksF
X-Proofpoint-GUID: dGXSIC5ZYvieHwJXRZGvhisSkrUNVksF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_02,2025-02-13_01,2024-11-22_01

Introduce the new ops for updating reset line and getting status. Thus,
the reset controller can be accessed through either direct I/O or regmap
interfaces. It enables the support of the syscon devices with the simple
reset code. To adapt the DT binding of the syscon device, the number of
reset lines must be specified in device data.

Signed-off-by: Wilson Ding <dingwei@marvell.com>
---
 drivers/reset/reset-simple.c       | 117 +++++++++++++++++++++++------
 include/linux/reset/reset-simple.h |  11 +++
 2 files changed, 107 insertions(+), 21 deletions(-)

diff --git a/drivers/reset/reset-simple.c b/drivers/reset/reset-simple.c
index 276067839830..e4e777d40a79 100644
--- a/drivers/reset/reset-simple.c
+++ b/drivers/reset/reset-simple.c
@@ -15,8 +15,10 @@
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/mfd/syscon.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 #include <linux/reset-controller.h>
 #include <linux/reset/reset-simple.h>
 #include <linux/spinlock.h>
@@ -27,10 +29,9 @@ to_reset_simple_data(struct reset_controller_dev *rcdev)
 	return container_of(rcdev, struct reset_simple_data, rcdev);
 }
 
-static int reset_simple_update(struct reset_controller_dev *rcdev,
+static int reset_simple_update_mmio(struct reset_simple_data *data,
 			       unsigned long id, bool assert)
 {
-	struct reset_simple_data *data = to_reset_simple_data(rcdev);
 	int reg_width = sizeof(u32);
 	int bank = id / (reg_width * BITS_PER_BYTE);
 	int offset = id % (reg_width * BITS_PER_BYTE);
@@ -51,16 +52,40 @@ static int reset_simple_update(struct reset_controller_dev *rcdev,
 	return 0;
 }
 
+static int reset_simple_update_regmap(struct reset_simple_data *data,
+				      unsigned long id, bool assert)
+{
+	int reg_width = sizeof(u32);
+	int bank = id / (reg_width * BITS_PER_BYTE);
+	int offset = id % (reg_width * BITS_PER_BYTE);
+	u32 mask, val;
+
+	mask = BIT(offset);
+
+	if (assert ^ data->active_low)
+		val = mask;
+	else
+		val = 0;
+
+	return regmap_write_bits(data->regmap,
+				 data->reg_offset + (bank * reg_width),
+				 mask, val);
+}
+
 static int reset_simple_assert(struct reset_controller_dev *rcdev,
 			       unsigned long id)
 {
-	return reset_simple_update(rcdev, id, true);
+	struct reset_simple_data *data = to_reset_simple_data(rcdev);
+
+	return data->ops.update(data, id, true);
 }
 
 static int reset_simple_deassert(struct reset_controller_dev *rcdev,
 				 unsigned long id)
 {
-	return reset_simple_update(rcdev, id, false);
+	struct reset_simple_data *data = to_reset_simple_data(rcdev);
+
+	return data->ops.update(data, id, false);
 }
 
 static int reset_simple_reset(struct reset_controller_dev *rcdev,
@@ -81,10 +106,9 @@ static int reset_simple_reset(struct reset_controller_dev *rcdev,
 	return reset_simple_deassert(rcdev, id);
 }
 
-static int reset_simple_status(struct reset_controller_dev *rcdev,
-			       unsigned long id)
+static int reset_simple_status_mmio(struct reset_simple_data *data,
+			     unsigned long id)
 {
-	struct reset_simple_data *data = to_reset_simple_data(rcdev);
 	int reg_width = sizeof(u32);
 	int bank = id / (reg_width * BITS_PER_BYTE);
 	int offset = id % (reg_width * BITS_PER_BYTE);
@@ -95,6 +119,31 @@ static int reset_simple_status(struct reset_controller_dev *rcdev,
 	return !(reg & BIT(offset)) ^ !data->status_active_low;
 }
 
+static int reset_simple_status_regmap(struct reset_simple_data *data,
+				    unsigned long id)
+{
+	int reg_width = sizeof(u32);
+	int bank = id / (reg_width * BITS_PER_BYTE);
+	int offset = id % (reg_width * BITS_PER_BYTE);
+	u32 reg;
+	int ret;
+
+	ret = regmap_read(data->regmap, data->reg_offset + (bank * reg_width),
+			  &reg);
+	if (ret)
+		return ret;
+
+	return !(reg & BIT(offset)) ^ !data->status_active_low;
+}
+
+static int reset_simple_status(struct reset_controller_dev *rcdev,
+			       unsigned long id)
+{
+	struct reset_simple_data *data = to_reset_simple_data(rcdev);
+
+	return data->ops.status(data, id);
+}
+
 const struct reset_control_ops reset_simple_ops = {
 	.assert		= reset_simple_assert,
 	.deassert	= reset_simple_deassert,
@@ -118,6 +167,7 @@ struct reset_simple_devdata {
 	u32 nr_resets;
 	bool active_low;
 	bool status_active_low;
+	bool syscon_dev;
 };
 
 #define SOCFPGA_NR_BANKS	8
@@ -171,26 +221,51 @@ static int reset_simple_probe(struct platform_device *pdev)
 	if (!data)
 		return -ENOMEM;
 
-	membase = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
-	if (IS_ERR(membase))
-		return PTR_ERR(membase);
+	if (devdata && devdata->syscon_dev) {
+		data->regmap = syscon_node_to_regmap(pdev->dev.parent->of_node);
+		if (IS_ERR(data->regmap))
+			return PTR_ERR(data->regmap);
 
-	spin_lock_init(&data->lock);
-	data->membase = membase;
-	data->rcdev.owner = THIS_MODULE;
-	data->rcdev.nr_resets = resource_size(res) * BITS_PER_BYTE;
-	data->rcdev.ops = &reset_simple_ops;
-	data->rcdev.of_node = dev->of_node;
+		if (device_property_read_u32(&pdev->dev, "offset",
+					     &data->reg_offset))
+			data->reg_offset = devdata->reg_offset;
 
-	if (devdata) {
-		reg_offset = devdata->reg_offset;
-		if (devdata->nr_resets)
-			data->rcdev.nr_resets = devdata->nr_resets;
+		if (devdata->nr_resets == 0) {
+			dev_err(dev, "no reset line\n");
+			return -EINVAL;
+		}
+
+		data->rcdev.nr_resets = devdata->nr_resets;
 		data->active_low = devdata->active_low;
 		data->status_active_low = devdata->status_active_low;
+
+		data->ops.update = reset_simple_update_regmap;
+		data->ops.status = reset_simple_status_regmap;
+	} else {
+		membase = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+		if (IS_ERR(membase))
+			return PTR_ERR(membase);
+		data->membase = membase;
+		data->rcdev.nr_resets = resource_size(res) * BITS_PER_BYTE;
+
+		if (devdata) {
+			reg_offset = devdata->reg_offset;
+			if (devdata->nr_resets)
+				data->rcdev.nr_resets = devdata->nr_resets;
+			data->active_low = devdata->active_low;
+			data->status_active_low = devdata->status_active_low;
+		}
+
+		data->membase += reg_offset;
+
+		data->ops.update = reset_simple_update_mmio;
+		data->ops.status = reset_simple_status_mmio;
 	}
 
-	data->membase += reg_offset;
+	spin_lock_init(&data->lock);
+	data->rcdev.owner = THIS_MODULE;
+	data->rcdev.ops = &reset_simple_ops;
+	data->rcdev.of_node = dev->of_node;
 
 	return devm_reset_controller_register(dev, &data->rcdev);
 }
diff --git a/include/linux/reset/reset-simple.h b/include/linux/reset/reset-simple.h
index c3e44f45b0f7..cbcf9e364dd4 100644
--- a/include/linux/reset/reset-simple.h
+++ b/include/linux/reset/reset-simple.h
@@ -13,9 +13,17 @@
 #define __RESET_SIMPLE_H__
 
 #include <linux/io.h>
+#include <linux/regmap.h>
 #include <linux/reset-controller.h>
 #include <linux/spinlock.h>
 
+struct reset_simple_data;
+
+struct reset_simple_line_ops {
+	int (*update)(struct reset_simple_data *data, unsigned long id, bool assert);
+	int (*status)(struct reset_simple_data *data, unsigned long id);
+};
+
 /**
  * struct reset_simple_data - driver data for simple reset controllers
  * @lock: spinlock to protect registers during read-modify-write cycles
@@ -37,6 +45,9 @@
 struct reset_simple_data {
 	spinlock_t			lock;
 	void __iomem			*membase;
+	struct regmap			*regmap;
+	u32				reg_offset;
+	struct reset_simple_line_ops	ops;
 	struct reset_controller_dev	rcdev;
 	bool				active_low;
 	bool				status_active_low;
-- 
2.43.0


