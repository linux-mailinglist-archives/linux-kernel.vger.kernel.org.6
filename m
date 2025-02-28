Return-Path: <linux-kernel+bounces-539001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A72DA49FB9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A4653BAC40
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870E71EF38C;
	Fri, 28 Feb 2025 17:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="X6rOPmif"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08021F0984;
	Fri, 28 Feb 2025 17:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740762177; cv=fail; b=DxVDnVzGan8NNSlCGgWKVcCJ7XGfNg8ikOOFx1S4sArs0HPoKaAVsbm2AaJkhE+p5JjJr4PFg00CmltgW/seg8yaZIXhdic7M8czXe/Urd1ILE7NUfF2StXXWigoxemX9DyWfUH77YFG6cfzJ3e39HlmE0j6CTM5V6UiA4V8a8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740762177; c=relaxed/simple;
	bh=NLvGxCB4lTIpmj8xRYtXEQvXcYJKJi311SKxwzjSdjs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Kk71zCNXt1kNl3O16kcK+Dfvd1KSH1SLNhDUZZN+QJfACNN2WuE6wYRNvIg0srb0n3DxVfZDNYHqIcrIkGs/IBKHxxm1ihjUgAR7bVdUkpl2YRklRCq3Z+kfZpNin4gqdGHVMbGsuCzi0kYVQY3aGNb44yCKEzFMj6jy8LRIwDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=X6rOPmif; arc=fail smtp.client-ip=40.107.243.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AnbNTsw3do5zmnpR2wrDvSg7LypVlIJC7n4Fr47np99emdc3YAk6Pf4KwRP0VS9zvTyYm8I7ffdOtFOmvgcTPYymMZljjl8pbyA/6P4FJacznTFfCmP+vRtOpKino0Ga0XiIvwH6YWoolobSyN/VAYJ+hU8aAFPqigrRu2te917xIN3x/rzEq0e3q6b5p0/AQmgNFM+ImB4FAXsjC6+8ejkP5ieJBuR5usvTh5Tw2eB9VQHSmsCTRCbG8TFvMdvgGjQ4OhuCuiOXtYT0fcVNpoW78M1dkrKjLB3oc8o/cTqt6r1Uo8tvEnauPR5QJ1MfAATtsqTYebM8vMaKuCbP4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7QEZx+aSqy0DWgRVcUJ46/s4znUqi4SASYmZFI9+iPc=;
 b=tQMyZPl7GUGmMUKHAqGcRO+o2xtXyd4OUykBXzIYJRPFG7qzHr+fil8AazEnwPMBkpAuy8nsK72CIxIHVVYLp4tP+5uUxkA2Kbxze+/E/OXQXl4dzQayd6f+nrqUjX0TLL66QjZS1FKpvnz9F59t8vpCvz9NJlbwJnKW+HeASS1q66Nnspje2l9CZ7DIVGfcptF7q+tUrYcct9roV76AJZsaLRG9Eyjqf5IrLA1xS+kjzlG9Xk+xblCSRNhJiNimuz7gDT9HMllodAUB0zE5voogsSjupujfd+WgFVdg/R5VgVzggQcFtXykB1K/I8jmylBghWMWMrVH1oqD84nlVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7QEZx+aSqy0DWgRVcUJ46/s4znUqi4SASYmZFI9+iPc=;
 b=X6rOPmifYE+A7ldq6lPpdnDnWaU3fX4lBN47z0csity15ra3dJEiXb8yo0lEkQ6wFiAalacUewbSKq8EkO2CHqFBrDFHnfw9T4nQ1l8nMkSOckGnQwnTze2j7r01VRLeRhHcRdhBixeZSyaVLmjvbNec1IvLakaCXAtrNMLeoYE=
Received: from SJ0PR13CA0047.namprd13.prod.outlook.com (2603:10b6:a03:2c2::22)
 by SA3PR12MB7805.namprd12.prod.outlook.com (2603:10b6:806:319::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 17:02:53 +0000
Received: from MWH0EPF000A6732.namprd04.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::56) by SJ0PR13CA0047.outlook.office365.com
 (2603:10b6:a03:2c2::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.9 via Frontend Transport; Fri,
 28 Feb 2025 17:02:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6732.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 17:02:52 +0000
Received: from maple-stxh-09.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 11:02:51 -0600
From: Pratap Nirujogi <pratap.nirujogi@amd.com>
To: <hdegoede@redhat.com>, <ilpo.jarvinen@linux.intel.com>
CC: <platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<benjamin.chan@amd.com>, Pratap Nirujogi <pratap.nirujogi@amd.com>
Subject: [PATCH] platform/x86: amd: Add ISP platform info
Date: Fri, 28 Feb 2025 12:02:36 -0500
Message-ID: <20250228170238.3484860-1-pratap.nirujogi@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6732:EE_|SA3PR12MB7805:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d6faf70-fd90-449a-72ed-08dd5819bd26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bgnCjE6Df0GmLRxPXGpfE99TgcLTz+HXjevUk8MUmmEcX4W5WwafgWPMJT4q?=
 =?us-ascii?Q?fysXGKwiYYD2jR6XoUc7eRIR4bl2T3aBcinyeOd0je6ZZItkR2TWUrs2yCp9?=
 =?us-ascii?Q?YUd18ORygiozAnhOcpXuZuiTEivx5jf8cLFfReLwjXh1YcRfodUcaEd7g5Ph?=
 =?us-ascii?Q?uGdXtgAWmOlNGlbLlYLMQJHks05T/LfNHWbNJuxSF+iPdCT45ck3BsxoY8gb?=
 =?us-ascii?Q?tEUc1NWfP8VZyD/Q9b8sZXr6WdTAIdEaxla5uysG0DkJbVxIaLaTQNr8c97f?=
 =?us-ascii?Q?M7DJmJh9aUvW9ZDQsukUVVXiOpBjQFUarvn/9lDkZ1sU2xN1SQmkARdaE6a4?=
 =?us-ascii?Q?0nTyy+mUBhRJLgeYvdo5+haVFdAD7ORQZA43fTlKAZKqK4CaZkO/FBCPVlg+?=
 =?us-ascii?Q?If6OM3kCyY3TNdfpIrQH3Yr9vFjqCZRNg0fM/1ma6qFoDHWLclPTBw6kGsjR?=
 =?us-ascii?Q?BMCPwOWekHM9rU8wzQg4zS0xrs3sg2I/ajJn7YC9+03RC1s0s7Z9qKsAMg50?=
 =?us-ascii?Q?8ckvO7+EFi9J9XyK5ZCD1L3/mYRJsk1L7Frn2Bs/ojOPMr2JxFW9aPOg3UzN?=
 =?us-ascii?Q?H+hUk4MhycyF1cezZVJAZT12+ZjTMoxTZdK0gXj/j9oIS3MQuMRaQ+wA/bnE?=
 =?us-ascii?Q?xnGErXMw/24JlmXYJLeQ+OGZh8No4YY1l5OLRkt+2rMAkD/Xv6STkjAvSaZl?=
 =?us-ascii?Q?mwWWcb9E1RvcduEpL392E4neJmwP0dTP4tHHDqL39GkcS0Jgk3fnHKLkfD7x?=
 =?us-ascii?Q?Ji80ptC6xzOja6UqVANg2Z98MtO6j4ST3c7DTnBQv+IbiEnLw3FdvgctX/fz?=
 =?us-ascii?Q?4DzSdBv2Cp4hvKGrzwxCyw5pvfYjMr30whfE/bS9oTTTt/KizXu0fStNjG2q?=
 =?us-ascii?Q?ZkRwHwplIeQERdXARNthcQnoNnNJbDVBNWk1QFeFbWE60kmzWJZX6Fs1voKW?=
 =?us-ascii?Q?bjqrK+KpzFQRtdSShbv1IvwEf/mb1+/hV/p+CoKmEl5TDNWqnXxz4oIRlIsY?=
 =?us-ascii?Q?tc4zgeVQDMARzC2/glHrWeDfWvb47Y7ogoDoJWsYLRO9f0PsbnG2l5rSArmd?=
 =?us-ascii?Q?NAMVlVkolKBZe70B7fjrSHQe0kNWcKDx6Q7Pj+pbWrLh9lhG161PddIMsp+I?=
 =?us-ascii?Q?WJ7/SmMojvF3deCH4mwbWtrJeDe2U+QmUwat1KcKBAlILAq5A/caC8RPc91E?=
 =?us-ascii?Q?gtbNiGmrrw+4NpikEk7cWcRJF3eOMDjEUHJKIaXQxwdq4tNGEi8mhKhTB0Fh?=
 =?us-ascii?Q?qdAQHv9WFmPmPElPBYyFN9SgrSdrUEyG+wej/TBc0yU7mVXuzgN7EoGy7+OR?=
 =?us-ascii?Q?23xuRHWdJhh09gPYs9qpP6+NhYra369fShvg0SKwhqAT609LoskKADxOscRg?=
 =?us-ascii?Q?shR70lf3ZcOOmLOlVlZuZUQBEoS69CIdeyHRUyZ6lBZ9bvQOTlCQy2eGxJ8E?=
 =?us-ascii?Q?tVjeeyOC+hi15P0eeHkW5Y8p/7UXcTRePuKt1+nLU9qMRZbBhj+sKSIm3drx?=
 =?us-ascii?Q?hWowsYMU50jquvY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 17:02:52.5756
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d6faf70-fd90-449a-72ed-08dd5819bd26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6732.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7805

Add ov05c i2c boardinfo and GPIO pin info for AMD ISP platform.

Details of the resources added:

- Added i2c bus number for AMD ISP platform is 99.
- Added GPIO 85 to allow ISP driver to enable and disable ISP access.
- Added GPIO 0 to allow sensor driver to enable and disable sensor module.

Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
---
 drivers/platform/x86/amd/Kconfig   | 11 +++++
 drivers/platform/x86/amd/Makefile  |  1 +
 drivers/platform/x86/amd/amd_isp.c | 72 ++++++++++++++++++++++++++++++
 3 files changed, 84 insertions(+)
 create mode 100644 drivers/platform/x86/amd/amd_isp.c

diff --git a/drivers/platform/x86/amd/Kconfig b/drivers/platform/x86/amd/Kconfig
index c3e086ea64fc..4b373edd750d 100644
--- a/drivers/platform/x86/amd/Kconfig
+++ b/drivers/platform/x86/amd/Kconfig
@@ -32,3 +32,14 @@ config AMD_WBRF
 
 	  This mechanism will only be activated on platforms that advertise a
 	  need for it.
+
+config AMD_ISP_PLATFORM
+	bool "AMD platform with ISP4 that supports Camera sensor device"
+	depends on I2C && X86_64 && AMD_ISP4
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
index 000000000000..751f209e9509
--- /dev/null
+++ b/drivers/platform/x86/amd/amd_isp.c
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2025 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#include <linux/init.h>
+#include <linux/i2c.h>
+#include <linux/kernel.h>
+#include <linux/gpio/machine.h>
+
+#define AMDISP_I2C_BUS		99
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
+arch_initcall(amd_isp_init);
+
+MODULE_AUTHOR("Benjamin Chan <benjamin.chan@amd.com>");
+MODULE_AUTHOR("Pratap Nirujogi <pratap.nirujogi@amd.com>");
+MODULE_DESCRIPTION("AMD ISP Platform parameters");
+MODULE_LICENSE("GPL and additional rights");
-- 
2.43.0


