Return-Path: <linux-kernel+bounces-537184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC229A488F9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 20:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8098188DBDF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D85826F468;
	Thu, 27 Feb 2025 19:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="BueZ8L2M"
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB4826E950;
	Thu, 27 Feb 2025 19:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740684363; cv=none; b=uxw3naryDejr3P6Vyxu2qIR/YGyW8fY3IdH+PABp4LsE2XMPSl1eLMqkGncEStOIaahq871LaaE4eV0x5/45Mh6iMzLt7xprFwBebgnxQOght8jLgIniUWWZXKcSq9A2FTR4mo/qHUJyshsa56s/0m5YPzsYhgBMjstIMsGsGVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740684363; c=relaxed/simple;
	bh=fgjmZ3DA77cJYq0sn+fRYx8WPAP8yypL8eP7eolv34o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aeqZO1nc6/xcVV6JU0C34iK9GJryORZ+Dv6qYUmxCfIvZMUp0aad2G/hNxFB4OV0UOub8ENUB1bF0yybd3K7z2OImIF6K1J+4iOS4gk7NjcSo097wGkBccs2f7ieN12cpS5GLm+UPrf6i6AHy2QNQCxsTmg0h3YqMhqP+x0yf9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=BueZ8L2M; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51RFjKPu005358;
	Thu, 27 Feb 2025 11:25:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=+
	HqytoyZlIAKh3kfduNHmj2AMH9IiJuRAqZBJXKMvjc=; b=BueZ8L2MA3a5t6JeQ
	My72uvpWa/88+K0Ad9CNUp69bsuA1/CFYRdzb4knxGoAOr6zlmiCziSPP0wR0cPf
	2umQhCToYZMrJNAulRGSIZKqDO9BnK4ZTCmVIfmZ0tDG+8TNyzeSS8PfKEvGY7Kn
	h69iKhXSzRaqUu4Pjk201ogUiRpMJSwBqT3fLXEil/lI6nSBCctlaQNbc5Yj2DKK
	3Ven2enfs9B/VngDTvj0wFWgNuueaArTupJBX3WGcwNlio3cZCHgAS1PdzMfKkfs
	B0NzjsY+euyON8zWoCbpSroXoQTQdfBV3YZaSpF59DAVcejxwqkTFl8DG+S8wBvv
	PUTyA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 452tyjrhbm-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 11:25:39 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 27 Feb 2025 11:25:38 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 27 Feb 2025 11:25:38 -0800
Received: from wd-ubuntu-24-04.marvell.com (wd-ubuntu-24-04.marvell.com [10.111.132.113])
	by maili.marvell.com (Postfix) with ESMTP id 5B0F53F707D;
	Thu, 27 Feb 2025 11:25:38 -0800 (PST)
From: Wilson Ding <dingwei@marvell.com>
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC: <andrew@lunn.ch>, <gregory.clement@bootlin.com>,
        <sebastian.hesselbarth@gmail.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <p.zabel@pengutronix.de>,
        <salee@marvell.com>, <gakula@marvell.com>,
        Wilson Ding <dingwei@marvell.com>
Subject: [PATCH v3 2/3] reset: Add support for Armada8K reset controller
Date: Thu, 27 Feb 2025 11:25:35 -0800
Message-ID: <20250227192536.2426490-3-dingwei@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227192536.2426490-1-dingwei@marvell.com>
References: <20250227192536.2426490-1-dingwei@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: YBzRlG9k6QrEIuhHyOm14XtK_IaCnYW0
X-Authority-Analysis: v=2.4 cv=UIYnHDfy c=1 sm=1 tr=0 ts=67c0bc33 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=T2h4t0Lz3GQA:10 a=M5GUcnROAAAA:8 a=uP1ucDPQAAAA:8 a=TCups3AGXvnK9ebHqNkA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=9a9ggB8z3XFZH39hjkD6:22
X-Proofpoint-GUID: YBzRlG9k6QrEIuhHyOm14XtK_IaCnYW0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_07,2025-02-27_01,2024-11-22_01

Armada8K has one register for unit soft-reset configuration within the
system controller register area. This patch created a new driver based
on the simple-reset driver to support the reset controller of a SYSCON
device.

Signed-off-by: Wilson Ding <dingwei@marvell.com>
---
 drivers/reset/Kconfig               |  12 ++
 drivers/reset/Makefile              |   1 +
 drivers/reset/reset-simple-syscon.c | 188 ++++++++++++++++++++++++++++
 include/linux/reset/reset-simple.h  |   3 +
 4 files changed, 204 insertions(+)
 create mode 100644 drivers/reset/reset-simple-syscon.c

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 5b3abb6db248..e98b22195317 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -248,6 +248,18 @@ config RESET_SIMPLE
 	   - SiFive FU740 SoCs
 	   - Sophgo SoCs
 
+config RESET_SIMPLE_SYSCON
+	bool "Simple SYSCON Reset Controller Driver" if COMPILE_TEST || EXPERT
+	depends on HAS_IOMEM
+	select MFD_SYSCON
+	help
+	  This enables a simple reset controller driver for reset lines that
+	  that can be asserted and deasserted by toggling bits in a contiguous,
+	  exclusive register space.
+
+	  Currently this driver supports:
+	   - Marvell Armada8K SoCs
+
 config RESET_SOCFPGA
 	bool "SoCFPGA Reset Driver" if COMPILE_TEST && (!ARM || !ARCH_INTEL_SOCFPGA)
 	default ARM && ARCH_INTEL_SOCFPGA
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 677c4d1e2632..c43642fe4d9b 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_RESET_RASPBERRYPI) += reset-raspberrypi.o
 obj-$(CONFIG_RESET_RZG2L_USBPHY_CTRL) += reset-rzg2l-usbphy-ctrl.o
 obj-$(CONFIG_RESET_SCMI) += reset-scmi.o
 obj-$(CONFIG_RESET_SIMPLE) += reset-simple.o
+obj-$(CONFIG_RESET_SIMPLE_SYSCON) += reset-simple-syscon.o
 obj-$(CONFIG_RESET_SOCFPGA) += reset-socfpga.o
 obj-$(CONFIG_RESET_SUNPLUS) += reset-sunplus.o
 obj-$(CONFIG_RESET_SUNXI) += reset-sunxi.o
diff --git a/drivers/reset/reset-simple-syscon.c b/drivers/reset/reset-simple-syscon.c
new file mode 100644
index 000000000000..798467f29911
--- /dev/null
+++ b/drivers/reset/reset-simple-syscon.c
@@ -0,0 +1,188 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Simple SYSCON Reset Controller Driver
+ *
+ * Copyright (C) 2025 Marvell, Wilson Ding <dingwei@marvell.com>
+ *
+ * Based on Simple Reset Controller Driver
+ *
+ * Copyright (C) 2017 Pengutronix, Philipp Zabel <kernel@pengutronix.de>
+ * Copyright 2013 Maxime Ripard <maxime.ripard@free-electrons.com>
+ *
+ */
+
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/reset-controller.h>
+#include <linux/reset/reset-simple.h>
+#include <linux/spinlock.h>
+
+static inline struct reset_simple_data *
+to_reset_simple_data(struct reset_controller_dev *rcdev)
+{
+	return container_of(rcdev, struct reset_simple_data, rcdev);
+}
+
+static int reset_simple_syscon_update(struct reset_controller_dev *rcdev,
+				      unsigned long id, bool assert)
+{
+	struct reset_simple_data *data = to_reset_simple_data(rcdev);
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
+static int reset_simple_syscon_assert(struct reset_controller_dev *rcdev,
+				      unsigned long id)
+{
+	return reset_simple_syscon_update(rcdev, id, true);
+}
+
+static int reset_simple_syscon_deassert(struct reset_controller_dev *rcdev,
+					unsigned long id)
+{
+	return reset_simple_syscon_update(rcdev, id, false);
+}
+
+static int reset_simple_syscon_reset(struct reset_controller_dev *rcdev,
+				     unsigned long id)
+{
+	struct reset_simple_data *data = to_reset_simple_data(rcdev);
+	int ret;
+
+	if (!data->reset_us)
+		return -EINVAL;
+
+	ret = reset_simple_syscon_assert(rcdev, id);
+	if (ret)
+		return ret;
+
+	usleep_range(data->reset_us, data->reset_us * 2);
+
+	return reset_simple_syscon_deassert(rcdev, id);
+}
+
+static int reset_simple_syscon_status(struct reset_controller_dev *rcdev,
+				      unsigned long id)
+{
+	struct reset_simple_data *data = to_reset_simple_data(rcdev);
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
+const struct reset_control_ops reset_simple_syscon_ops = {
+	.assert		= reset_simple_syscon_assert,
+	.deassert	= reset_simple_syscon_deassert,
+	.reset		= reset_simple_syscon_reset,
+	.status		= reset_simple_syscon_status,
+};
+EXPORT_SYMBOL_GPL(reset_simple_syscon_ops);
+
+/**
+ * struct reset_simple_syscon_devdata - simple reset controller properties
+ * @reg_offset: offset between base address and first reset register.
+ * @nr_resets: number of resets. If not set, default to resource size in bits.
+ * @active_low: if true, bits are cleared to assert the reset. Otherwise, bits
+ *              are set to assert the reset.
+ * @status_active_low: if true, bits read back as cleared while the reset is
+ *                     asserted. Otherwise, bits read back as set while the
+ *                     reset is asserted.
+ */
+struct reset_simple_syscon_devdata {
+	u32 reg_offset;
+	u32 nr_resets;
+	bool active_low;
+	bool status_active_low;
+};
+
+static const
+struct reset_simple_syscon_devdata reset_simple_syscon_active_low = {
+	.active_low = true,
+	.status_active_low = true,
+};
+
+static const struct of_device_id reset_simple_syscon_dt_ids[] = {
+	{ .compatible = "marvell,armada8k-reset",
+		.data = &reset_simple_syscon_active_low },
+	{ /* sentinel */ },
+};
+
+static int reset_simple_syscon_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	const struct reset_simple_syscon_devdata *devdata;
+	struct reset_simple_data *data;
+	u32 reg[2];
+
+	devdata = of_device_get_match_data(dev);
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->regmap = syscon_node_to_regmap(pdev->dev.parent->of_node);
+	if (IS_ERR(data->regmap))
+		return PTR_ERR(data->regmap);
+
+	/*
+	 * If the "reg" property is available, retrieve the reg_offset
+	 * and calculate the nr_resets based on the register size.
+	 */
+	if (!device_property_read_u32_array(&pdev->dev, "reg", reg, 2)) {
+		data->reg_offset = reg[0];
+		data->rcdev.nr_resets = reg[1] * BITS_PER_BYTE;
+	}
+
+	spin_lock_init(&data->lock);
+	data->rcdev.owner = THIS_MODULE;
+	data->rcdev.ops = &reset_simple_syscon_ops;
+	data->rcdev.of_node = dev->of_node;
+
+	if (devdata) {
+		if (devdata->reg_offset)
+			data->reg_offset = devdata->reg_offset;
+		if (devdata->nr_resets)
+			data->rcdev.nr_resets = devdata->nr_resets;
+		data->active_low = devdata->active_low;
+		data->status_active_low = devdata->status_active_low;
+	}
+
+	return devm_reset_controller_register(dev, &data->rcdev);
+}
+
+static struct platform_driver reset_simple_syscon_driver = {
+	.probe	= reset_simple_syscon_probe,
+	.driver = {
+		.name		= "simple-reset-syscon",
+		.of_match_table	= reset_simple_syscon_dt_ids,
+	},
+};
+builtin_platform_driver(reset_simple_syscon_driver);
diff --git a/include/linux/reset/reset-simple.h b/include/linux/reset/reset-simple.h
index c3e44f45b0f7..9a8eebd5892f 100644
--- a/include/linux/reset/reset-simple.h
+++ b/include/linux/reset/reset-simple.h
@@ -13,6 +13,7 @@
 #define __RESET_SIMPLE_H__
 
 #include <linux/io.h>
+#include <linux/regmap.h>
 #include <linux/reset-controller.h>
 #include <linux/spinlock.h>
 
@@ -37,6 +38,8 @@
 struct reset_simple_data {
 	spinlock_t			lock;
 	void __iomem			*membase;
+	struct regmap			*regmap;
+	u32				reg_offset;
 	struct reset_controller_dev	rcdev;
 	bool				active_low;
 	bool				status_active_low;
-- 
2.43.0


