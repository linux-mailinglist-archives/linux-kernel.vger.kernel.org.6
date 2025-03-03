Return-Path: <linux-kernel+bounces-540984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53522A4B730
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 05:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8947A18879C4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 04:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E981AD3E1;
	Mon,  3 Mar 2025 04:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mVtRmKLH"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2056.outbound.protection.outlook.com [40.107.95.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4074C1BBBF7
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 04:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740977049; cv=fail; b=pxcZcmGfIuLCYQHwepeGvar62wxHvd6G1E2wy4fz75jeSsC/iaml2sCGvUdz4/5owHJWHFa0tatE5BfokaTdhUYuHimNdDN+4yLkb8lmK8WluCXMQ0e1sUfjvj1PgbQKmNQV52bFaXrRMLLraPNXIYa7CcogA3Ha8ETlj1Vf7kM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740977049; c=relaxed/simple;
	bh=qsMk7XPHsuQhkmSxyjsRm+3Zhfbxdtbt4D29KZOe2xA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fUBxtLNGHm26G0ERx6zmCijJeoBuLd3GlrVnqZaEp8wA0X5Q8CWbScXotd5eGzzVIPZiff1vfkZVeP9ONRz+MTC2RDh54JaWZVxUb1C98UrEDV6xbaWgFNYOhNZBBf0PoHiq96e3X333opqfzpwBRQay9pwmduyiuypxjccl3OU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mVtRmKLH; arc=fail smtp.client-ip=40.107.95.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NkD+u4EWKmKLYyE+e4bgpqJV5nuqKXpvI7kQQt7uy3aFQ8ZPHhiOwD2+CdnqSi4QKTK4NOHmwsxOecCDRSMC9PwiWuOL4bfEwCgQDCyp73qWObMl+RFgj18g6Ie5eLHS2ATjL+A2b3oLoKhsd6PpsoY64HuaQUeMPXurPYSbYJRHh+JPnvhFBv2Jf0SyKZySA1bHy7knVFM6W1M/xSyRITp1X7dEuzYmVrsGugEtmr/0jl3S72ZLBTNG/Xuli0XM6psqGF7Hu6uWQE34WH2GouqWXtssooa89vaTnyJZ3mrpWykEJnKSnRdUDf5CguVI2+Uj/76EO4IUEOcdVfFXYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZIm9DE6jOkf+vOKB/vMSGaIPOAb2WKcIuCsj2Q8/3s=;
 b=eJTsHhzFsxg3t14O8TQIg2cBxomHVH3PmBiRD+TinNosQziBuis2eAI00n3ssu0LiScsyATWPD+2+5maOXrdjuVC+x6DQhe3ISMGKV68M1Mb9PwUr2driExiKbNhPVZekSngS0CTfHuNi0dhqTMvH4WvcNVvv0CJXtqNl24Ja4yPHBQDmZ/dF3tO7jZljwPtirChwA0L7nnZlw1uHsLDTeV7KBFH4M2TFwIh2wSLG9KJh7eqYL6R8UkcFMzqfpAGXMPcSzcd2cJV/VrPAPNECn1IoBpT2xZXqB+fmubHXY4TlKEuWBNqz1acz7jt+ziJBy00x969SVq3yj0xaSxtZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arndb.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZIm9DE6jOkf+vOKB/vMSGaIPOAb2WKcIuCsj2Q8/3s=;
 b=mVtRmKLHEmTPl7hw2a/rYUMefar6cQa2M/SgZguCKHWB9T0Ov3dHu+ZmPMciq0ncFY1hW2ttH5vPLlGz8oMf5FGQvZEuS7xa/T2eHCpxCzdVd6DASG81nWwU3W7de3zVLXalSiKuhdRUr5AvygJ44h0vsgg7cdqEvNAYyX9BACg=
Received: from CH0PR13CA0060.namprd13.prod.outlook.com (2603:10b6:610:b2::35)
 by PH7PR12MB7891.namprd12.prod.outlook.com (2603:10b6:510:27a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Mon, 3 Mar
 2025 04:43:55 +0000
Received: from CH2PEPF0000009B.namprd02.prod.outlook.com
 (2603:10b6:610:b2:cafe::1f) by CH0PR13CA0060.outlook.office365.com
 (2603:10b6:610:b2::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.18 via Frontend Transport; Mon,
 3 Mar 2025 04:43:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009B.mail.protection.outlook.com (10.167.244.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Mon, 3 Mar 2025 04:43:54 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 2 Mar
 2025 22:43:54 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 2 Mar
 2025 22:43:54 -0600
Received: from xsjdavidz01.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sun, 2 Mar 2025 22:43:53 -0600
From: Yidong Zhang <yidong.zhang@amd.com>
To: <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
	<linux-kernel@vger.kernel.org>
CC: Yidong Zhang <yidong.zhang@amd.com>, <lizhi.hou@amd.com>,
	<christophe.jaillet@wanadoo.fr>, DMG Karthik <Karthik.DMG@amd.com>, "Nishad
 Saraf" <nishads@amd.com>
Subject: [PATCH V0 1/3] drivers/misc/amd: Add new driver amd versal-pci
Date: Sun, 2 Mar 2025 20:43:10 -0800
Message-ID: <20250303044313.679012-2-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250303044313.679012-1-yidong.zhang@amd.com>
References: <20250303044313.679012-1-yidong.zhang@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009B:EE_|PH7PR12MB7891:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dce3c5b-afc5-4cb1-dc21-08dd5a0e00ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VdZRYvNyf0+1ISHOraQuJa15B6JuHSUpJOC1KEpXR2SfhxibTmLHIf0xswvz?=
 =?us-ascii?Q?ODRTWdo1HggczjpGS4//QcZFmKehg+EPRKo5yesbWbfIPrM/CuS6z+KfvZnM?=
 =?us-ascii?Q?4HedNVUKdHHq8WVxc5K5qh8uY2KGKF+ABShdazcl9Q+WnFDkj1rl1pAc8MW/?=
 =?us-ascii?Q?OQV0tGVKpnoWyCkAMe+EKBDMTF3LuwnbIHvq6HJcFi/6igP7FqFwPD9ltKK3?=
 =?us-ascii?Q?VMUzz1eeqlmjhWZUDOY4saISus7G9leGJ8Ik8rsr1Rj3eA9urGfxdGBZ+dll?=
 =?us-ascii?Q?Z0McjcFXu2JBAcy9MqAFcS0f+Xq+0mc/6CK7hh4YMqtMtX6OV4yIZiB6fHxI?=
 =?us-ascii?Q?piuqu1cKH5RGYkH+su/JZ4OudSoMmFhmsxwQ7dEf3fAhfjGh2f1FlI3P5IBj?=
 =?us-ascii?Q?4MSTF8rWRZSQxhfbjPB2acx4o6MGUNf64v6t/XMiHG9lWBbIZNenZINlXJS6?=
 =?us-ascii?Q?zsc3CrNosZ7X6p0YpWSS8FO3wlwd9c0WDl/LJKlFY/7sJ2DIuBt1jn7FkuD3?=
 =?us-ascii?Q?NHn2q7d/Q+R7Z0kzXrtKCcKsBa2di25qjA/bWHyeak5Jul9ALYwVe+xrZPP/?=
 =?us-ascii?Q?DsEJOq2NOatBPH36R4z60yOqoUNOZgxQMLzMA5HOSoi07iGEr+nbvOdp3uW9?=
 =?us-ascii?Q?UI6jecAkKGlJfOp80c9iDt5wwsovTSxSjAsck3QbmXiq70fQPrBfUxG0hh1m?=
 =?us-ascii?Q?X+/sCf+sZ98Ka8NhtjCQnDeidvtcesifv4159IDFuddOcbtUI6iUXiLVTj96?=
 =?us-ascii?Q?k5PEajB+x/jpEOjylf6uXzpzLfm6nVqA18pDzx+a7LlFqBpM+NIFCSI01s6E?=
 =?us-ascii?Q?ea2Dg72k6C7CiaPzqQfEX8plBkht3dDJP583uJ1sHtrs5qXuj7PA01CiVIzj?=
 =?us-ascii?Q?MLjexxhUimIIuO1RGnWeOCqorSNhQuxc8JoY1g3nOTxnv+BLQhMgEVBntdiW?=
 =?us-ascii?Q?IxAclxgsFsgyT93URekySGgOIe3UxZ/fa1OpTJYyyVCeDc/taPJl9DzBtC4R?=
 =?us-ascii?Q?dQKYd5kzMiGEpP4IdtwLR32y/kNB+YZUUaNJP08rY9yVZ7H7BBcqHMUT37p7?=
 =?us-ascii?Q?gLcz1l2bi4rrt1SmPsL5b4zSxdUq48BsVSY3AQh+Lrc7Ll7s0noNtkt8wV61?=
 =?us-ascii?Q?O1SJmsKE/a/OlVqKp9lPi1f4srsimvTEDc3BNwHCogPNMe0wOdd12lulUOp9?=
 =?us-ascii?Q?S4wXUVYLqRDQluC8fuIHk08LppsXfh6N425vp0OPgJp2BTKuIlIGWWLz8RSv?=
 =?us-ascii?Q?CDdsaymQBgQG7EhHjOtZNeG/Yb0+JU2+6C1B/gk1P6sJ/crhcIdVFpEstkG1?=
 =?us-ascii?Q?Xd8nhtBubbwyJWN3MPadWdSGJ7w4tfDL50BTanNfILIKpCXZORftOAGhV5ID?=
 =?us-ascii?Q?h4B6nblXRMiH4c7pZmY+KxjgNdK4rNlZ0Q5sqSBsN7oG/i4GiMG+PqrBWgpB?=
 =?us-ascii?Q?jj/LDl37P+Y=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 04:43:54.7458
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dce3c5b-afc5-4cb1-dc21-08dd5a0e00ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7891

AMD Versal based PCIe card, including V70 and RAVE, is designed for AI
inference efficiency and is tuned for video analytics and natural language
processing applications.

The driver architecture:

  +---------+----+  Remote   +-----+------+
  |         |PCIe|  Queue    | Embedded   |
  | Mgmt PF |Bar | <=======> |   SoC      |
  |         |    |           +------------+
  +---------+----+           | base FW    |
                             +-----+------+

This driver provides the following functionalities:

   - module and PCI device initialization
     the driver will initialize itself based on bar resources for a
     hardware queue based ring buffer between PCIe bar and RTOS services
     VMR [1] running on Embedded SoC hardware firmware for flashing
     firmware and checking card healthy status.

   - programming FW
     The base FW is downloaded onto the flash of the card.

[1] https://github.com/Xilinx/VMR.git

Co-developed-by: DMG Karthik <Karthik.DMG@amd.com>
Signed-off-by: DMG Karthik <Karthik.DMG@amd.com>
Co-developed-by: Nishad Saraf <nishads@amd.com>
Signed-off-by: Nishad Saraf <nishads@amd.com>
Signed-off-by: Yidong Zhang <yidong.zhang@amd.com>
---
 MAINTAINERS                        |   5 +
 drivers/misc/Kconfig               |   1 +
 drivers/misc/Makefile              |   1 +
 drivers/misc/amd/Kconfig           |  15 ++
 drivers/misc/amd/Makefile          |   5 +
 drivers/misc/amd/versal-pci-main.c | 272 +++++++++++++++++++++++++++++
 drivers/misc/amd/versal-pci.h      |  62 +++++++
 7 files changed, 361 insertions(+)
 create mode 100644 drivers/misc/amd/Kconfig
 create mode 100644 drivers/misc/amd/Makefile
 create mode 100644 drivers/misc/amd/versal-pci-main.c
 create mode 100644 drivers/misc/amd/versal-pci.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 8e0736dc2ee0..8d79e8b7e963 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1215,6 +1215,11 @@ L:	linux-spi@vger.kernel.org
 S:	Supported
 F:	drivers/spi/spi-amd.c
 
+AMD VERSAL PCI DRIVER
+M:	Yidong Zhang <yidong.zhang@amd.com>
+S:	Supported
+F:	drivers/misc/amd/
+
 AMD XDNA DRIVER
 M:	Min Ma <min.ma@amd.com>
 M:	Lizhi Hou <lizhi.hou@amd.com>
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 56bc72c7ce4a..d1616f0fb12f 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -649,4 +649,5 @@ source "drivers/misc/uacce/Kconfig"
 source "drivers/misc/pvpanic/Kconfig"
 source "drivers/misc/mchp_pci1xxxx/Kconfig"
 source "drivers/misc/keba/Kconfig"
+source "drivers/misc/amd/Kconfig"
 endmenu
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 545aad06d088..230a8d6bafaf 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -75,3 +75,4 @@ lan966x-pci-objs		:= lan966x_pci.o
 lan966x-pci-objs		+= lan966x_pci.dtbo.o
 obj-$(CONFIG_MCHP_LAN966X_PCI)	+= lan966x-pci.o
 obj-y				+= keba/
+obj-$(CONFIG_AMD_VERSAL_PCI)	+= amd/
diff --git a/drivers/misc/amd/Kconfig b/drivers/misc/amd/Kconfig
new file mode 100644
index 000000000000..8b1a9bd0d150
--- /dev/null
+++ b/drivers/misc/amd/Kconfig
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config AMD_VERSAL_PCI
+	tristate "AMD Versal PCIe Management Driver"
+	select FW_LOADER
+	select CONFIGFS_FS
+	depends on HAS_IOMEM
+	depends on PCI
+	default m
+	help
+	  AMD Versal PCIe Management Driver provides management services,
+	  including download firmware, program bitstream, and communicate with
+	  the User function.
+
+	  If "M" is selected, the driver module will be versal-pci
diff --git a/drivers/misc/amd/Makefile b/drivers/misc/amd/Makefile
new file mode 100644
index 000000000000..e3868cb39563
--- /dev/null
+++ b/drivers/misc/amd/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+obj-$(CONFIG_AMD_VERSAL_PCI)		+= versal-pci.o
+
+versal-pci-$(CONFIG_AMD_VERSAL_PCI)	:= versal-pci-main.o
diff --git a/drivers/misc/amd/versal-pci-main.c b/drivers/misc/amd/versal-pci-main.c
new file mode 100644
index 000000000000..1c61c88120b4
--- /dev/null
+++ b/drivers/misc/amd/versal-pci-main.c
@@ -0,0 +1,272 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for Versal PCIe device
+ *
+ * Copyright (C) 2025 Advanced Micro Devices, Inc. All rights reserved.
+ */
+
+#include <linux/pci.h>
+
+#include "versal-pci.h"
+
+#define DRV_NAME			"amd-versal-pci"
+
+#define PCI_DEVICE_ID_V70PQ2		0x50B0
+#define PCI_DEVICE_ID_RAVE		0x5700
+#define VERSAL_XCLBIN_MAGIC_ID		"xclbin2"
+
+static inline u32 versal_pci_devid(struct versal_pci_device *vdev)
+{
+	return ((pci_domain_nr(vdev->pdev->bus) << 16) |
+		PCI_DEVID(vdev->pdev->bus->number, vdev->pdev->devfn));
+}
+
+static int versal_pci_load_shell(struct versal_pci_device *vdev, char *fw_name)
+{
+	const struct firmware *fw;
+	struct axlf *xsabin;
+	int ret;
+
+	strim(fw_name);
+
+	ret = request_firmware(&fw, fw_name, &vdev->pdev->dev);
+	if (ret) {
+		vdev_warn(vdev, "request xsabin fw %s failed %d", fw_name, ret);
+		return ret;
+	}
+
+	xsabin = (struct axlf *)fw->data;
+	if (memcmp(xsabin->magic, VERSAL_XCLBIN_MAGIC_ID, sizeof(VERSAL_XCLBIN_MAGIC_ID))) {
+		vdev_err(vdev, "Invalid device firmware");
+		ret = -EINVAL;
+		goto release_firmware;
+	}
+
+	if (!fw->size ||
+	    fw->size != xsabin->header.length ||
+	    fw->size < sizeof(*xsabin) ||
+	    fw->size > SZ_1G) {
+		vdev_err(vdev, "Invalid device firmware size %zu", fw->size);
+		ret = -EINVAL;
+		goto release_firmware;
+	}
+
+	if (!uuid_equal(&vdev->intf_uuid, &xsabin->header.rom_uuid)) {
+		vdev_err(vdev, "base shell doesn't match uuid %pUb", &xsabin->header.uuid);
+		ret = -EINVAL;
+		goto release_firmware;
+	}
+
+	/* TODO upload fw to card */
+	if (ret) {
+		vdev_err(vdev, "failed to load xsabin %s : %d", fw_name, ret);
+		goto release_firmware;
+	}
+
+	vdev_info(vdev, "Downloaded xsabin %pUb of size %lld Bytes",
+		  &xsabin->header.uuid, xsabin->header.length);
+
+release_firmware:
+	release_firmware(fw);
+
+	return ret;
+}
+
+static inline struct versal_pci_device *item_to_vdev(struct config_item *item)
+{
+	return container_of(to_configfs_subsystem(to_config_group(item)),
+			    struct versal_pci_device, cfs_subsys);
+}
+
+static ssize_t versal_pci_cfs_config_store(struct config_item *item,
+					   const char *page, size_t count)
+{
+	struct versal_pci_device *vdev = item_to_vdev(item);
+	u32 config;
+	int ret;
+
+	ret = kstrtou32(page, 0, &config);
+	if (ret)
+		return -EINVAL;
+
+	if (config)
+		ret = versal_pci_load_shell(vdev, vdev->fw.name);
+
+	if (ret)
+		return -EFAULT;
+
+	return count;
+}
+CONFIGFS_ATTR_WO(versal_pci_cfs_, config);
+
+static ssize_t versal_pci_cfs_image_show(struct config_item *item, char *page)
+{
+	struct versal_pci_device *vdev = item_to_vdev(item);
+
+	vdev_info(vdev, "fw name: %s", vdev->fw.name);
+
+	return 0;
+}
+
+static ssize_t versal_pci_cfs_image_store(struct config_item *item,
+					  const char *page, size_t count)
+{
+	struct versal_pci_device *vdev = item_to_vdev(item);
+
+	count = snprintf(vdev->fw.name, sizeof(vdev->fw.name), "%s", page);
+
+	vdev_info(vdev, "fw name: %s", vdev->fw.name);
+	return count;
+}
+CONFIGFS_ATTR(versal_pci_cfs_, image);
+
+static struct configfs_attribute *versal_pci_cfs_attrs[] = {
+	&versal_pci_cfs_attr_config,
+	&versal_pci_cfs_attr_image,
+	NULL,
+};
+
+static const struct config_item_type versal_pci_cfs_table = {
+	.ct_owner = THIS_MODULE,
+	.ct_attrs = versal_pci_cfs_attrs,
+};
+
+static int versal_pci_cfs_init(struct versal_pci_device *vdev)
+{
+	struct configfs_subsystem *subsys = &vdev->cfs_subsys;
+
+	snprintf(subsys->su_group.cg_item.ci_namebuf,
+		 sizeof(subsys->su_group.cg_item.ci_namebuf),
+		 "%s%x", DRV_NAME, versal_pci_devid(vdev));
+
+	subsys->su_group.cg_item.ci_type = &versal_pci_cfs_table;
+
+	config_group_init(&subsys->su_group);
+	return configfs_register_subsystem(subsys);
+}
+
+static void versal_pci_fw_fini(struct versal_pci_device *vdev)
+{
+	uuid_copy(&vdev->intf_uuid, &uuid_null);
+}
+
+static void versal_pci_cfs_fini(struct configfs_subsystem *subsys)
+{
+	configfs_unregister_subsystem(subsys);
+}
+
+static void versal_pci_device_teardown(struct versal_pci_device *vdev)
+{
+	versal_pci_cfs_fini(&vdev->cfs_subsys);
+	versal_pci_fw_fini(vdev);
+}
+
+static void versal_pci_uuid_parse(struct versal_pci_device *vdev, uuid_t *uuid)
+{
+	char str[UUID_STRING_LEN];
+	u8 i, j;
+	int len = strlen(vdev->fw_id);
+
+	/* parse uuid into a valid uuid string format */
+	for (i = 0, j = 0; i < len && i < sizeof(str); i++) {
+		str[j++] = vdev->fw_id[i];
+		if (j == 8 || j == 13 || j == 18 || j == 23)
+			str[j++] = '-';
+	}
+
+	uuid_parse(str, uuid);
+	vdev_info(vdev, "Interface uuid %pU", uuid);
+}
+
+static int versal_pci_fw_init(struct versal_pci_device *vdev)
+{
+	/* TODO request compatible fw_id from card */
+
+	versal_pci_uuid_parse(vdev, &vdev->intf_uuid);
+
+	return 0;
+}
+
+static int versal_pci_device_setup(struct versal_pci_device *vdev)
+{
+	int ret;
+
+	ret = versal_pci_fw_init(vdev);
+	if (ret) {
+		vdev_err(vdev, "Failed to init fw, err %d", ret);
+		goto comm_chan_fini;
+	}
+
+	ret = versal_pci_cfs_init(vdev);
+	if (ret) {
+		vdev_err(vdev, "Failed to init configfs subsys, err %d", ret);
+		goto comm_chan_fini;
+	}
+
+	return 0;
+
+comm_chan_fini:
+
+	return ret;
+}
+
+static void versal_pci_remove(struct pci_dev *pdev)
+{
+	struct versal_pci_device *vdev = pci_get_drvdata(pdev);
+
+	versal_pci_device_teardown(vdev);
+}
+
+static int versal_pci_probe(struct pci_dev *pdev, const struct pci_device_id *pdev_id)
+{
+	struct versal_pci_device *vdev;
+	int ret;
+
+	vdev = devm_kzalloc(&pdev->dev, sizeof(*vdev), GFP_KERNEL);
+	if (!vdev)
+		return -ENOMEM;
+
+	pci_set_drvdata(pdev, vdev);
+	vdev->pdev = pdev;
+
+	ret = pcim_enable_device(pdev);
+	if (ret) {
+		vdev_err(vdev, "Failed to enable device %d", ret);
+		return ret;
+	}
+
+	vdev->io_regs = pcim_iomap_region(vdev->pdev, MGMT_BAR, DRV_NAME);
+	if (IS_ERR(vdev->io_regs)) {
+		vdev_err(vdev, "Failed to map RM shared memory BAR%d", MGMT_BAR);
+		return PTR_ERR(vdev->io_regs);
+	}
+
+	ret = versal_pci_device_setup(vdev);
+	if (ret) {
+		vdev_err(vdev, "Failed to setup Versal device %d", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct pci_device_id versal_pci_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_XILINX, PCI_DEVICE_ID_V70PQ2), },
+	{ PCI_DEVICE(PCI_VENDOR_ID_XILINX, PCI_DEVICE_ID_RAVE), },
+	{ 0 }
+};
+
+MODULE_DEVICE_TABLE(pci, versal_pci_ids);
+
+static struct pci_driver versal_pci_driver = {
+	.name = DRV_NAME,
+	.id_table = versal_pci_ids,
+	.probe = versal_pci_probe,
+	.remove = versal_pci_remove,
+};
+
+module_pci_driver(versal_pci_driver);
+
+MODULE_DESCRIPTION("AMD Versal PCIe Management Driver");
+MODULE_AUTHOR("XRT Team <runtimeca39d@amd.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/misc/amd/versal-pci.h b/drivers/misc/amd/versal-pci.h
new file mode 100644
index 000000000000..ca309aee87ad
--- /dev/null
+++ b/drivers/misc/amd/versal-pci.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Driver for Versal PCIe device
+ *
+ * Copyright (C) 2025 Advanced Micro Devices, Inc. All rights reserved.
+ */
+
+#ifndef __VERSAL_PCI_H
+#define __VERSAL_PCI_H
+
+#include <linux/configfs.h>
+#include <linux/firmware.h>
+
+#define MGMT_BAR		0
+
+#define vdev_info(vdev, fmt, args...)					\
+	dev_info(&(vdev)->pdev->dev, "%s: "fmt, __func__, ##args)
+
+#define vdev_warn(vdev, fmt, args...)					\
+	dev_warn(&(vdev)->pdev->dev, "%s: "fmt, __func__, ##args)
+
+#define vdev_err(vdev, fmt, args...)					\
+	dev_err(&(vdev)->pdev->dev, "%s: "fmt, __func__, ##args)
+
+#define vdev_dbg(vdev, fmt, args...)					\
+	dev_dbg(&(vdev)->pdev->dev, fmt, ##args)
+
+struct versal_pci_device;
+
+struct axlf_header {
+	__u64				length;
+	__u8				reserved1[24];
+	uuid_t				rom_uuid;
+	__u8				reserved2[64];
+	uuid_t				uuid;
+	__u8				reserved3[24];
+} __packed;
+
+struct axlf {
+	__u8				magic[8];
+	__u8				reserved[296];
+	struct axlf_header		header;
+} __packed;
+
+struct fw_info {
+	__u32				opcode;
+	char				name[128];
+};
+
+struct versal_pci_device {
+	struct pci_dev			*pdev;
+
+	struct fw_info			fw;
+
+	void __iomem			*io_regs;
+	uuid_t				intf_uuid;
+	__u8				fw_id[UUID_STRING_LEN + 1];
+
+	struct configfs_subsystem	cfs_subsys;
+};
+
+#endif	/* __VERSAL_PCI_H */
-- 
2.34.1


