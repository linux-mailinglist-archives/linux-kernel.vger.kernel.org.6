Return-Path: <linux-kernel+bounces-541472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 472CAA4BD43
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 12:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5616E164A28
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 11:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB401F4633;
	Mon,  3 Mar 2025 10:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OadCObGA"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2065.outbound.protection.outlook.com [40.107.101.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376991F461F;
	Mon,  3 Mar 2025 10:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740999589; cv=fail; b=MeiZ7hluzx+G1SjoEuA/vQGiNWNhIEPDXhUJ34zo+X+A/TMGu0OU3eWRacD3wXWgT+dY5s+KPgP26MGqwlYEKOGFYUCb2IKqtNvz3pqi4uZPEKzQv1mK7/ugHkrxyOdkRP77g6IOmywTW7fjVjRt73NDDfpyvv/QkPTKWXZgJqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740999589; c=relaxed/simple;
	bh=/BgLzPf3NsR2HtXkQ/CIFgY5TOZuw7S8eG7lQnuR+Dg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VXkXLVBjUuasf0zDLO/YYi4ch0sDd0E7UUKQUuEEOc0LmP8bKOdp/4PTar9n+dN1E8rbM08hut8PNgjfyKdxDIQmjflMLYtdW9aKjNmTb+YUxTTK6lL2Hi+0w2Hjk45S1f0q03rkZKTEru613rUTZoV600eBM9SoHj2VU8DgzQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OadCObGA; arc=fail smtp.client-ip=40.107.101.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WDhLnt79nsd17lBoOIwZsmorJBZCjIocJITfg6LCqDRBK+LeiGNtE3iFcutQhTn2vSjNA2QJ6iRD3lbCVa+pTHdkXu/AAujhlZXR5kmMoKZ/eeWpCJaxOyWbM3QPDAgqLOlnrsgb1bT7DMrAE52Zo7TGltQBXTJAvzzZdZgjkKx3bZ6vDkCak4OX22x35x6gJlnljsQU6sV0ycOHm9ch7jS+X0e+GsiwynuOvxkoN4Yy3XULWOb6/WcNOyAYgHuwMGRonVF8Su+7gi+PEs7sYYdg5XdWU9V+ABYhwtNR+A/7N7TNCwo4GuTMh6eSFlG6FfjfKfOOy+BnKnDf3aYjrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rGV2tSPqZeCNDPcRLJTMB+34eX/08dEHILSjTXi8aP0=;
 b=mmLaz4SGAfY+IjDOhI+NH2VkvI/in9qk87PE0dKHCx5lIJDdRPJyzOcMUBI7iWU9GQ6oM6yEKJEl/+2F/8sJeedDw8tpa5Y1rzjYsO5g768dq3e0L7gv5m5fvupmXFz3TQnIaB6rJM1TydQnbfYvA88DIWZz6sWV0Kf4KOXkC7/wcVvPfnV+cdSBH29YdKSy7ttlgFjgPUbOlyL0uuBhePARuKLo9s5MbBlCXUoTsRE5uuLCxKHtSiv4h7KcGylLlK00CWH7t5NcL4kYRP1T2qaPJdzNaZmw8caeGZMo9ZcEnvTDKlIvnhz9S79JNdQRvW6rD86ITctnTtJMUCwJgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGV2tSPqZeCNDPcRLJTMB+34eX/08dEHILSjTXi8aP0=;
 b=OadCObGAAXShuJ6tNXixJYkYuRqCF5w9IELSQ0cw8WH1UVndHqNH37WHWYsHZnzFominH5eS/te7x0gLaQZvXhIaJudfux6INvFYkYwk8sUy6f8Hgq9HakH6771jgyboEEW626UbpMFFI/j38IjsoHL6lp/gG6FQuMOz7PsEslM=
Received: from SN6PR08CA0022.namprd08.prod.outlook.com (2603:10b6:805:66::35)
 by DS0PR12MB8200.namprd12.prod.outlook.com (2603:10b6:8:f5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Mon, 3 Mar
 2025 10:59:37 +0000
Received: from SN1PEPF00036F42.namprd05.prod.outlook.com
 (2603:10b6:805:66:cafe::62) by SN6PR08CA0022.outlook.office365.com
 (2603:10b6:805:66::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.29 via Frontend Transport; Mon,
 3 Mar 2025 10:59:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F42.mail.protection.outlook.com (10.167.248.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Mon, 3 Mar 2025 10:59:36 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Mar
 2025 04:59:33 -0600
From: Akshay Gupta <akshay.gupta@amd.com>
To: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux@roeck-us.net>, <gregkh@linuxfoundation.org>, <arnd@arndb.de>,
	<shyam-sundar.s-k@amd.com>, <gautham.shenoy@amd.com>,
	<mario.limonciello@amd.com>, <naveenkrishna.chatradhi@amd.com>, Akshay Gupta
	<akshay.gupta@amd.com>
Subject: [PATCH v5 03/11] misc: amd-sbi: Move hwmon device sensor as separate entity
Date: Mon, 3 Mar 2025 10:58:54 +0000
Message-ID: <20250303105902.215009-4-akshay.gupta@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250303105902.215009-1-akshay.gupta@amd.com>
References: <20250303105902.215009-1-akshay.gupta@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F42:EE_|DS0PR12MB8200:EE_
X-MS-Office365-Filtering-Correlation-Id: 8af9e1fb-c101-4b0e-b259-08dd5a427d1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OThM+7mF4HuChRuZMieFyVkoeYhTb6hkERvKhlJp1ZutBGyDqcM+JoeVUwiX?=
 =?us-ascii?Q?QRGu0c3c0OadQP9qtooQ+NDmUeL4Vr8zqp6EtLofAmoQjfdV538nSE83QZPf?=
 =?us-ascii?Q?NBw0JOLRUdih7gd5kmwqTAt6I7EOxiQoVmg6kMKZxS4cbhOOQBg8gbBQr9Ee?=
 =?us-ascii?Q?OraV13WHDFkzlQniYLKrmC6IpwYHHDWTE+p7MSMtIAddyTqi2vxtzJrPpTBB?=
 =?us-ascii?Q?YyWEDHhIqkHXalCGOb5fgm96WStpvByxjgEl9MwRToWYbcti6X/vQcpS5ujE?=
 =?us-ascii?Q?Y+w9Eg6RQC2x66MzjMhnGswuMHr/WkBk5OPNcAmzEaHzOQnoSvUB73IeuFEy?=
 =?us-ascii?Q?fhcLuVim7jf0ZVb0AEI2Eem+HfAtugrcqrQXJLZVlxzGmBxWGK++DKscZO5x?=
 =?us-ascii?Q?nErX/MgX5HDpWB24ym7mj9lEmUXhjDpGNELDh2Au364hPVWVNArn2hXiROu9?=
 =?us-ascii?Q?zi77lgGEWg9E7sgyxklgkPRt7PNftDn3GLnfAlRwb8dcAu3SImVY9K9ewiP4?=
 =?us-ascii?Q?lbwlzFU0zq9R2Dn4cgfbvm6hVI5SIKfhddNzeNnjXdFlPkuwtWNzmSVrkdfu?=
 =?us-ascii?Q?XxVl+BdcAubdzgCAhYfsyJ3EUVxIDtUdfbwdz1EUACs6VByXApJaqVI9kgqt?=
 =?us-ascii?Q?m28dI694VFUPSU7ZdG6Tn2ws4D++YIaSVSWXUPFZE5BmH4PprnR7uR1dHsCA?=
 =?us-ascii?Q?mWN5obNlJBVfnEiPjjc02caKlvo3H/gXaFRzoN0j6Ykd9m3BInc0KCeyU2MM?=
 =?us-ascii?Q?WlWipwW1RZNg/s599yjOQonwtOo/23HY0vnB3ec75Ix88bHRQOTxMHgw9s9E?=
 =?us-ascii?Q?GTfHgboDW1OvRpsaS+pdhi18XqgzfDcrmEmOP1yRGgHab68uKTGz26YuIfMu?=
 =?us-ascii?Q?C3lilqoisowUw80PSk0Vj0AZItSWUyCP/C0hytwGRbvpyGdvD/8qNGD21NQ3?=
 =?us-ascii?Q?2kJ9rH8EWO6Uq4ramfu42KiJv5Do4D642VsH+zIZSre/6Q05Erw9NUMqarPy?=
 =?us-ascii?Q?hsD6lF/c7hmPFh2vvLOO4ZkEXg70iN4LHfWKnt01Dp6anVdpzV1s9WsmuI7Y?=
 =?us-ascii?Q?f4DxhDipt686k1YIPDfGJr3rNQuMMFnhWLL7qOlzg9r9s1sMOZ08X+gA3P+/?=
 =?us-ascii?Q?LjMYqjOfSH/0q8cGqXmQSnqNb61TDR4qGe7roWA98gkIj+Ypt8EJmlcqLW1K?=
 =?us-ascii?Q?u7zRQDJk3x5el+50ljztkWY4YogwPbr2kBA8PrwlLRALgYax4vHmpeVe9qtl?=
 =?us-ascii?Q?fuOyF26AdosTnhgQhcV1TEgW/ySOn+mZb9mrPhCBC09mrYyYQ9E2IqBhqmKF?=
 =?us-ascii?Q?9pT1zsnVBh3KN6XZNtfQR2tdr1OdBpoeejxsMV6AHkIApLJb7qGbx6Iyqs8o?=
 =?us-ascii?Q?PoV6BAD+z/T1Zbulv6i0fx9qn9tq5ktkRclw35bE0b23m/sBxH2wPOgxd4hC?=
 =?us-ascii?Q?qZeEWQRtznfDlt0BKLCIoAwg/UbRS7cdkdQbtRcHbrxTTQicrLB7IlUZWL5X?=
 =?us-ascii?Q?vgPE/CHj33qZ4WI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 10:59:36.8915
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8af9e1fb-c101-4b0e-b259-08dd5a427d1c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F42.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8200

- Move hwmon device sensor to misc as only power is reported through
  hwmon sensor.

Reviewed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Signed-off-by: Akshay Gupta <akshay.gupta@amd.com>
---
Changes since v4:
New patch: Patch split from v4 patch 1/9
- Update Copyright year to 2025

 drivers/misc/amd-sbi/Makefile    |   2 +-
 drivers/misc/amd-sbi/rmi-core.h  |   1 +
 drivers/misc/amd-sbi/rmi-hwmon.c | 121 +++++++++++++++++++++++++++++++
 drivers/misc/amd-sbi/rmi-i2c.c   | 105 +--------------------------
 4 files changed, 125 insertions(+), 104 deletions(-)
 create mode 100644 drivers/misc/amd-sbi/rmi-hwmon.c

diff --git a/drivers/misc/amd-sbi/Makefile b/drivers/misc/amd-sbi/Makefile
index 7cd8e0a1aa5d..eac90a7635de 100644
--- a/drivers/misc/amd-sbi/Makefile
+++ b/drivers/misc/amd-sbi/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
-sbrmi-i2c-objs  		:= rmi-i2c.o rmi-core.o
+sbrmi-i2c-objs  		:= rmi-i2c.o rmi-core.o rmi-hwmon.o
 obj-$(CONFIG_AMD_SBRMI_I2C)	+= sbrmi-i2c.o
diff --git a/drivers/misc/amd-sbi/rmi-core.h b/drivers/misc/amd-sbi/rmi-core.h
index 8e30a43ec714..27165d3bb20f 100644
--- a/drivers/misc/amd-sbi/rmi-core.h
+++ b/drivers/misc/amd-sbi/rmi-core.h
@@ -60,4 +60,5 @@ struct sbrmi_mailbox_msg {
 };
 
 int rmi_mailbox_xfer(struct sbrmi_data *data, struct sbrmi_mailbox_msg *msg);
+int create_hwmon_sensor_device(struct device *dev, struct sbrmi_data *data);
 #endif /*_SBRMI_CORE_H_*/
diff --git a/drivers/misc/amd-sbi/rmi-hwmon.c b/drivers/misc/amd-sbi/rmi-hwmon.c
new file mode 100644
index 000000000000..720e800db1f0
--- /dev/null
+++ b/drivers/misc/amd-sbi/rmi-hwmon.c
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * rmi-hwmon.c - hwmon sensor support for side band RMI
+ *
+ * Copyright (C) 2025 Advanced Micro Devices, Inc.
+ */
+#include <linux/err.h>
+#include <linux/hwmon.h>
+#include "rmi-core.h"
+
+/* Do not allow setting negative power limit */
+#define SBRMI_PWR_MIN  0
+
+static int sbrmi_read(struct device *dev, enum hwmon_sensor_types type,
+		      u32 attr, int channel, long *val)
+{
+	struct sbrmi_data *data = dev_get_drvdata(dev);
+	struct sbrmi_mailbox_msg msg = { 0 };
+	int ret;
+
+	if (!data)
+		return -ENODEV;
+
+	if (type != hwmon_power)
+		return -EINVAL;
+
+	msg.read = true;
+	switch (attr) {
+	case hwmon_power_input:
+		msg.cmd = SBRMI_READ_PKG_PWR_CONSUMPTION;
+		ret = rmi_mailbox_xfer(data, &msg);
+		break;
+	case hwmon_power_cap:
+		msg.cmd = SBRMI_READ_PKG_PWR_LIMIT;
+		ret = rmi_mailbox_xfer(data, &msg);
+		break;
+	case hwmon_power_cap_max:
+		msg.data_out = data->pwr_limit_max;
+		ret = 0;
+		break;
+	default:
+		return -EINVAL;
+	}
+	if (ret < 0)
+		return ret;
+	/* hwmon power attributes are in microWatt */
+	*val = (long)msg.data_out * 1000;
+	return ret;
+}
+
+static int sbrmi_write(struct device *dev, enum hwmon_sensor_types type,
+		       u32 attr, int channel, long val)
+{
+	struct sbrmi_data *data = dev_get_drvdata(dev);
+	struct sbrmi_mailbox_msg msg = { 0 };
+
+	if (!data)
+		return -ENODEV;
+
+	if (type != hwmon_power && attr != hwmon_power_cap)
+		return -EINVAL;
+	/*
+	 * hwmon power attributes are in microWatt
+	 * mailbox read/write is in mWatt
+	 */
+	val /= 1000;
+
+	val = clamp_val(val, SBRMI_PWR_MIN, data->pwr_limit_max);
+
+	msg.cmd = SBRMI_WRITE_PKG_PWR_LIMIT;
+	msg.data_in = val;
+	msg.read = false;
+
+	return rmi_mailbox_xfer(data, &msg);
+}
+
+static umode_t sbrmi_is_visible(const void *data,
+				enum hwmon_sensor_types type,
+				u32 attr, int channel)
+{
+	switch (type) {
+	case hwmon_power:
+		switch (attr) {
+		case hwmon_power_input:
+		case hwmon_power_cap_max:
+			return 0444;
+		case hwmon_power_cap:
+			return 0644;
+		}
+		break;
+	default:
+		break;
+	}
+	return 0;
+}
+
+static const struct hwmon_channel_info * const sbrmi_info[] = {
+	HWMON_CHANNEL_INFO(power,
+			   HWMON_P_INPUT | HWMON_P_CAP | HWMON_P_CAP_MAX),
+	NULL
+};
+
+static const struct hwmon_ops sbrmi_hwmon_ops = {
+	.is_visible = sbrmi_is_visible,
+	.read = sbrmi_read,
+	.write = sbrmi_write,
+};
+
+static const struct hwmon_chip_info sbrmi_chip_info = {
+	.ops = &sbrmi_hwmon_ops,
+	.info = sbrmi_info,
+};
+
+int create_hwmon_sensor_device(struct device *dev, struct sbrmi_data *data)
+{
+	struct device *hwmon_dev;
+
+	hwmon_dev = devm_hwmon_device_register_with_info(dev, "sbrmi", data,
+							 &sbrmi_chip_info, NULL);
+	return PTR_ERR_OR_ZERO(hwmon_dev);
+}
diff --git a/drivers/misc/amd-sbi/rmi-i2c.c b/drivers/misc/amd-sbi/rmi-i2c.c
index 914338a24246..9ad4c8093399 100644
--- a/drivers/misc/amd-sbi/rmi-i2c.c
+++ b/drivers/misc/amd-sbi/rmi-i2c.c
@@ -8,7 +8,6 @@
 
 #include <linux/delay.h>
 #include <linux/err.h>
-#include <linux/hwmon.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
 #include <linux/module.h>
@@ -16,9 +15,6 @@
 #include <linux/of.h>
 #include "rmi-core.h"
 
-/* Do not allow setting negative power limit */
-#define SBRMI_PWR_MIN	0
-
 static int sbrmi_enable_alert(struct i2c_client *client)
 {
 	int ctrl;
@@ -40,100 +36,6 @@ static int sbrmi_enable_alert(struct i2c_client *client)
 	return 0;
 }
 
-static int sbrmi_read(struct device *dev, enum hwmon_sensor_types type,
-		      u32 attr, int channel, long *val)
-{
-	struct sbrmi_data *data = dev_get_drvdata(dev);
-	struct sbrmi_mailbox_msg msg = { 0 };
-	int ret;
-
-	if (type != hwmon_power)
-		return -EINVAL;
-
-	msg.read = true;
-	switch (attr) {
-	case hwmon_power_input:
-		msg.cmd = SBRMI_READ_PKG_PWR_CONSUMPTION;
-		ret = rmi_mailbox_xfer(data, &msg);
-		break;
-	case hwmon_power_cap:
-		msg.cmd = SBRMI_READ_PKG_PWR_LIMIT;
-		ret = rmi_mailbox_xfer(data, &msg);
-		break;
-	case hwmon_power_cap_max:
-		msg.data_out = data->pwr_limit_max;
-		ret = 0;
-		break;
-	default:
-		return -EINVAL;
-	}
-	if (ret < 0)
-		return ret;
-	/* hwmon power attributes are in microWatt */
-	*val = (long)msg.data_out * 1000;
-	return ret;
-}
-
-static int sbrmi_write(struct device *dev, enum hwmon_sensor_types type,
-		       u32 attr, int channel, long val)
-{
-	struct sbrmi_data *data = dev_get_drvdata(dev);
-	struct sbrmi_mailbox_msg msg = { 0 };
-
-	if (type != hwmon_power && attr != hwmon_power_cap)
-		return -EINVAL;
-	/*
-	 * hwmon power attributes are in microWatt
-	 * mailbox read/write is in mWatt
-	 */
-	val /= 1000;
-
-	val = clamp_val(val, SBRMI_PWR_MIN, data->pwr_limit_max);
-
-	msg.cmd = SBRMI_WRITE_PKG_PWR_LIMIT;
-	msg.data_in = val;
-	msg.read = false;
-
-	return rmi_mailbox_xfer(data, &msg);
-}
-
-static umode_t sbrmi_is_visible(const void *data,
-				enum hwmon_sensor_types type,
-				u32 attr, int channel)
-{
-	switch (type) {
-	case hwmon_power:
-		switch (attr) {
-		case hwmon_power_input:
-		case hwmon_power_cap_max:
-			return 0444;
-		case hwmon_power_cap:
-			return 0644;
-		}
-		break;
-	default:
-		break;
-	}
-	return 0;
-}
-
-static const struct hwmon_channel_info * const sbrmi_info[] = {
-	HWMON_CHANNEL_INFO(power,
-			   HWMON_P_INPUT | HWMON_P_CAP | HWMON_P_CAP_MAX),
-	NULL
-};
-
-static const struct hwmon_ops sbrmi_hwmon_ops = {
-	.is_visible = sbrmi_is_visible,
-	.read = sbrmi_read,
-	.write = sbrmi_write,
-};
-
-static const struct hwmon_chip_info sbrmi_chip_info = {
-	.ops = &sbrmi_hwmon_ops,
-	.info = sbrmi_info,
-};
-
 static int sbrmi_get_max_pwr_limit(struct sbrmi_data *data)
 {
 	struct sbrmi_mailbox_msg msg = { 0 };
@@ -152,7 +54,6 @@ static int sbrmi_get_max_pwr_limit(struct sbrmi_data *data)
 static int sbrmi_i2c_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
-	struct device *hwmon_dev;
 	struct sbrmi_data *data;
 	int ret;
 
@@ -173,10 +74,8 @@ static int sbrmi_i2c_probe(struct i2c_client *client)
 	if (ret < 0)
 		return ret;
 
-	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name, data,
-							 &sbrmi_chip_info, NULL);
-
-	return PTR_ERR_OR_ZERO(hwmon_dev);
+	dev_set_drvdata(dev, data);
+	return create_hwmon_sensor_device(dev, data);
 }
 
 static const struct i2c_device_id sbrmi_id[] = {
-- 
2.25.1


