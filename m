Return-Path: <linux-kernel+bounces-541003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E911EA4B758
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 06:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0880516C7AC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 05:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C7A1E3762;
	Mon,  3 Mar 2025 05:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="i82f0Zgd"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CC11DCB24;
	Mon,  3 Mar 2025 05:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740978082; cv=fail; b=fwtsrgfUnc3KrqzADuoGj/bFqLtJVOSARPw9Jgfv7GBiu/76H0UzDHrSbgFxGqpKbLVfYILtuH8+gHnNhTqwnp7lZ/8QabrCEgYX08Xup1bwwDLaMRmWQ2ny8KyrJMFkSvt6Hv5LXoAhvkpaBmgtfZxxyInH7JQRUzaVcfqONfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740978082; c=relaxed/simple;
	bh=xppFsYbm+bqlv4/n10zfTqLJGjZleNR5bXftyQZCR0c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c0bLNeNZmDukzcB6C4KxbeQ0meugRrIO/T/2BC1N7+L0BtavhD+MjCAhrCHcmrWnpJ1NTqdClR/UxF3nFOXdb6Vg4EFOV814nqSr9sDYnccqNqaR63iYy3fQw9dfr/Kcf/JJ+ZJnLxx5amMx2TaRs9siSEsTZ9N/x8CkhvGYaSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=i82f0Zgd; arc=fail smtp.client-ip=40.107.93.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E6ua7ydsp+z1tqOIWr05ULWDqHfTJF9SreyvvKSeZsMDu5jZ2gaalCN0pq8+SVsqu+Xp90Q030u1jZsRo6YjBIBLdDejwsP3d4CF4YDrhQuGizY5S46QsYS/1WGUQoxOEma0+RuJfTCyCtEBL/Hrw0YOa3T3Gso/8wJCB/oGw/yrVni2SNFFyyESOpUCTU3JHqLDL8oCG097QDD0gCYXBhOxSmlgIrObb47Px2fn1EBCx1w5XWkQWh4wFfiuHv6ikRNVB4s2FYThqZIpbUSxJIZFKutwUc/F+zY5j8qj2r2bEjRnluHB/Y3RB1OzMR2+PqZpEHmiLux9iGkuK9lNVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wHEpwM1SPWYlroH9WwqXgHsecPRDnFsbGxWS+V0Gd2c=;
 b=rwh1As4Ahl3zf1lOLNiuqZWSU72X+WzqRbQ5WI7XAU1a801Ow++m7ZBhR6nnb9JP+SlXcsmyIA2h+HdbOqAyuFHCz3PFe+fhtWA9s2EY2YEYa+4xqOvZt/H65lBButyL//eM6xl0DgdcM24JblxSKH5aVdKRbk9qcBrjegH9hkgWfummIc2avVIFAp0K/htXqpXROXDD2fwL0l/q4us13c1NTeJkWEfPEyM/Tbo92UHMtm2IcgqLb8SzVEB/ptgVEbzTpAE7IYRxiiwudps5xT/nZHNHJhFo8BkGpiQTxwRdJ3tm+q5gTRlm4c4lbbiDU2zqJ2ecrOSatWFUyKwtWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHEpwM1SPWYlroH9WwqXgHsecPRDnFsbGxWS+V0Gd2c=;
 b=i82f0ZgdRZdoS1e1MqRj3uUsTccuIQZq9bTRNb2qBloSGvwgiVCip4j7gL8qo3Pm4LGQKnbtQITGX/KkEKQFPjh0aE05t4FOtYAsrWnVODF6tv32tLWhuvobey3zlWccJDYvrUWLeogOG7ageuzbv4sPmOXxpalT348oGyU+9jM=
Received: from SJ0PR03CA0388.namprd03.prod.outlook.com (2603:10b6:a03:3a1::33)
 by PH8PR12MB6913.namprd12.prod.outlook.com (2603:10b6:510:1ca::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 05:01:18 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::30) by SJ0PR03CA0388.outlook.office365.com
 (2603:10b6:a03:3a1::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.26 via Frontend Transport; Mon,
 3 Mar 2025 05:01:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Mon, 3 Mar 2025 05:01:17 +0000
Received: from maple-stxh-09.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 2 Mar
 2025 23:01:15 -0600
From: Pratap Nirujogi <pratap.nirujogi@amd.com>
To: <mlimonci@amd.com>, <krzk@kernel.org>, <hdegoede@redhat.com>,
	<ilpo.jarvinen@linux.intel.com>
CC: <platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<benjamin.chan@amd.com>, Pratap Nirujogi <pratap.nirujogi@amd.com>
Subject: [PATCH v1] platform/x86: amd: Add ISP platform info
Date: Mon, 3 Mar 2025 00:00:59 -0500
Message-ID: <20250303050102.2298520-1-pratap.nirujogi@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|PH8PR12MB6913:EE_
X-MS-Office365-Filtering-Correlation-Id: e9e04dc2-6c09-499e-a0f1-08dd5a106eab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zSf7jfjSmJfR6nsZOT/B9qdXgvsjxFpPvgagjoDnYIhzOePI8RqKCfxFWn2F?=
 =?us-ascii?Q?4kTym9dppooCezC0nR+BY94XGF5hx8NqMwBheHeHF1T1R66dqrxDUs/ZUGfK?=
 =?us-ascii?Q?y51WI8uDxD0YN9MKL1JgQL+8BkabpILTipngQwynsHR64VI0/pnCW97V0Tif?=
 =?us-ascii?Q?mFdKGYGA8eM0xCPWv4vLzd8iCvJoXbS2klOjpr8h7ik9KE1I40CKDIzLk7zz?=
 =?us-ascii?Q?fMNpzvWQ4zTzWyCnZggJ6jvT1J/wCrsC3gOjRiwg+AbqF4udG3zrnDoEmfp5?=
 =?us-ascii?Q?o90YdQKA9Eq5P6tZWamP4i704VvIqs6BhleZlMajuVpIhf9cfCz+wELKHNVv?=
 =?us-ascii?Q?pllqUexsFb7edyr7wimVnqI3qcFZgQubf2gF3rMdMW8rb/luwC7fBf9dGcwt?=
 =?us-ascii?Q?w43H9gbWBL4JFT2ulO5ge5IKaOPBdbdSZBHRkiRaVtMbeEpVVFOpALXVtinX?=
 =?us-ascii?Q?qYG/5TjF4iDQA851Vvn79cb9Qcw/+Ig8P3YfGk7ZPFRfbgXC1W6s4nPSO/Qf?=
 =?us-ascii?Q?uI9rlV9IOWJd7x9eG+ALa9x4IplFxTnTbzTvpwe5uiXMQQXo8K2Jcx9PP3CU?=
 =?us-ascii?Q?BqSKs5ArYQH8KBcUXSH/B6U4elJ8D3iaZfZ47zkx0lhTRZwzc1Mnh/fdt70q?=
 =?us-ascii?Q?0dpA0q01AneelVsznFXldcYiIs3b3ESRWCaLUmhESUOW3ExuxJRMnqHwqhoh?=
 =?us-ascii?Q?iPv8nQ3tjB0pZKCdWoSIARG4LO3ud03N8HES4LdWkL+yS51Jm0QxrEZySwq3?=
 =?us-ascii?Q?XkbecDki2HLIhprpJ7mrdRiCr7yHfV0plf/X71OfhHKnM7aRrSkVLNQIEqgN?=
 =?us-ascii?Q?JMQ2bl4xI2Fk3gdG6zF0qMbZGVhWIMSowXlOZD9+MXR/F1ihl0izvFlVqozx?=
 =?us-ascii?Q?xukCgIUKzldkNfvtDm9Yu5Ei78EVnMhU9wkCP4ICStcFy2kJ3cbIJp6JqOG3?=
 =?us-ascii?Q?NgQtMGqa8ybg+2L0Q64WU7Qy2AJFRy41S8TjvSAckHfbdBV66vnhpWy9Rwam?=
 =?us-ascii?Q?6UdQsL3HR1bD1Rzt43jf3rTGH9wCad3RfEvsX/rEnR0V7KGsMQ6UGjRdDWo9?=
 =?us-ascii?Q?4JSwW44+aMMmTDCdE4ql1WmKezP6yR5H/WkGC5jR/bMzFFadbZJwxEKDDo1g?=
 =?us-ascii?Q?r+EkBk7IgpYCuP3ZhBI3fNVru0tCiKT+JzmlAByH3LFaVgVEXAFU7y4qZuB+?=
 =?us-ascii?Q?G4hVClP952KbxJ5cQseJ2Nji590WTe13HA9YVeTXZuXTM1NdpUuCuk3Pcj3K?=
 =?us-ascii?Q?hfzKc0FQ/YWm9l4KrNnoc+wJb+hREULfgRq0YAUK4Hdq0RghLF8tEyEF+U/n?=
 =?us-ascii?Q?XB92zbaitk0Cel4wHbKp3VNPFDGZSXs4d9HlRw8NrUSiPJkPiiXBea0Rze+K?=
 =?us-ascii?Q?Ufp3S6xkWuQrppdHu2B8NuuKjN3FWyUqgd8aLlCFj+fj4cRBVdgYtajqLm1M?=
 =?us-ascii?Q?63FeUFFe4rSwDIufC7+gGo6ABHeeRPuyl/NKrcC1qXRds0g499AjRjcPoShw?=
 =?us-ascii?Q?jhO9VmF3rdBtA/A=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 05:01:17.7477
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9e04dc2-6c09-499e-a0f1-08dd5a106eab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6913

Add ov05c i2c boardinfo and GPIO pin info for AMD ISP platform.

Details of the resources added:

- Added i2c bus number for AMD ISP platform is 99.
- Added GPIO 85 to allow ISP driver to enable and disable ISP access.
- Added GPIO 0 to allow sensor driver to enable and disable sensor module.

Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
---
 drivers/platform/x86/amd/Kconfig   | 11 ++++++
 drivers/platform/x86/amd/Makefile  |  1 +
 drivers/platform/x86/amd/amd_isp.c | 63 ++++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+)
 create mode 100644 drivers/platform/x86/amd/amd_isp.c

diff --git a/drivers/platform/x86/amd/Kconfig b/drivers/platform/x86/amd/Kconfig
index c3e086ea64fc..0341270d70a6 100644
--- a/drivers/platform/x86/amd/Kconfig
+++ b/drivers/platform/x86/amd/Kconfig
@@ -32,3 +32,14 @@ config AMD_WBRF
 
 	  This mechanism will only be activated on platforms that advertise a
 	  need for it.
+
+config AMD_ISP_PLATFORM
+	bool "AMD platform with ISP4 that supports Camera sensor device"
+	depends on I2C && X86_64 && PINCTRL_AMDISP && AMD_ISP4
+	help
+	  For AMD platform that support Image signal processor generation 4, it
+	  is necessary to add platform specific camera sensor module board info
+	  which includes the sensor driver device id and the i2c address.
+
+	  If you have a AMD platform that support ISP4 and with a sensor
+	  connected to it, say Y here
diff --git a/drivers/platform/x86/amd/Makefile b/drivers/platform/x86/amd/Makefile
index 56f62fc9c97b..0d89e2d4f7e6 100644
--- a/drivers/platform/x86/amd/Makefile
+++ b/drivers/platform/x86/amd/Makefile
@@ -10,3 +10,4 @@ obj-$(CONFIG_AMD_PMC)		+= pmc/
 obj-$(CONFIG_AMD_HSMP)		+= hsmp/
 obj-$(CONFIG_AMD_PMF)		+= pmf/
 obj-$(CONFIG_AMD_WBRF)		+= wbrf.o
+obj-$(CONFIG_AMD_ISP_PLATFORM)	+= amd_isp.o
diff --git a/drivers/platform/x86/amd/amd_isp.c b/drivers/platform/x86/amd/amd_isp.c
new file mode 100644
index 000000000000..cb0faab4b9c3
--- /dev/null
+++ b/drivers/platform/x86/amd/amd_isp.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * AMD x86 platform driver for AMD HW platforms using ISP4
+ *
+ * Copyright 2025 Advanced Micro Devices, Inc.
+ */
+
+#include <linux/acpi.h>
+#include <linux/gpio/machine.h>
+#include <linux/init.h>
+#include <linux/i2c.h>
+#include <linux/kernel.h>
+
+#define AMDISP_I2C_BUS		99
+
+#define AMDISP_ACPI_CAM_HID     "OMNI5C10"
+
+static struct gpiod_lookup_table isp_gpio_table = {
+	.dev_id = "amd_isp_capture",
+	.table = {
+		GPIO_LOOKUP("AMDI0030:00", 85, "enable_isp", GPIO_ACTIVE_HIGH),
+		{ }
+	},
+};
+
+static struct gpiod_lookup_table isp_sensor_gpio_table = {
+	.dev_id = "ov05c",
+	.table = {
+		GPIO_LOOKUP("amdisp-pinctrl", 0, "sensor0_enable", GPIO_ACTIVE_HIGH),
+		{ }
+	},
+};
+
+static struct i2c_board_info sensor_info = {
+	.dev_name = "ov05c",
+	I2C_BOARD_INFO("ov05c", 0x10),
+};
+
+static int __init amd_isp_init(void)
+{
+	int ret;
+
+	/* check for valid platform before configuring isp4 board resources */
+	if (!acpi_dev_found(AMDISP_ACPI_CAM_HID))
+		return -ENODEV;
+
+	gpiod_add_lookup_table(&isp_gpio_table);
+	gpiod_add_lookup_table(&isp_sensor_gpio_table);
+
+	ret = i2c_register_board_info(AMDISP_I2C_BUS, &sensor_info, 1);
+	if (ret)
+		pr_err("%s: cannot register i2c board devices:%s",
+		       __func__, sensor_info.dev_name);
+
+	return ret;
+}
+
+module_init(amd_isp_init);
+
+MODULE_AUTHOR("Benjamin Chan <benjamin.chan@amd.com>");
+MODULE_AUTHOR("Pratap Nirujogi <pratap.nirujogi@amd.com>");
+MODULE_DESCRIPTION("AMD ISP4 Platform parameters");
+MODULE_LICENSE("GPL v2");
-- 
2.43.0


