Return-Path: <linux-kernel+bounces-442570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 731F49EDE6F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 05:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B4D4168137
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 04:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC05B14B088;
	Thu, 12 Dec 2024 04:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="YFPjjG7Y"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012025.outbound.protection.outlook.com [52.101.66.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDE913B288;
	Thu, 12 Dec 2024 04:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733977493; cv=fail; b=c5hdFpzVnDnHCHqbJwMKkKHh9QdStCOPNz9wfqgQhB744m/SukoFbvArxtzbNIU4J813bPKkxuRrk4Ck9C74Yk4yRNdUpb5sE7lhK/R9L9QmB7iQJXnSVYLEGxHETn6t7qC435KX9ltq+cYawWtSF9e8TGJxJYsZ1zxg+99EiE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733977493; c=relaxed/simple;
	bh=6bZ0xfaQR5HjSEimn/1+unBJH77gEqWisNPRLKI+/p8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gfGRQrcRkHaimrymndEtgQSjSR5YWXrb3tXLsBNjdPfomCQtBAsTX9P9RlzyHG76u5ejOgi35zvSuyxU/8+9Yt8IEAiYVX7A/xfOxvBkn5sPhMUMBaD7GQ7i2tdNvkA3FLWupbIip670RxvWvJJl5b+uScdhhZ6Pq0EbpdhD0PU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=YFPjjG7Y; arc=fail smtp.client-ip=52.101.66.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BWOR1KqNRdEzNfCZZgwA9ut1cZtW69SQyiGzMsFOmn74qYdhrn4SSywEXCvXgV0qVZ9Vgv/ReqVL5qoG/QmpqueifEmJGi8twWZUdk+bOTyVhYcLadZSwD1CiTIEQAcMtAbl0XjcnsGiHGJgZ3QoQwi7DZMAZFgLm64vAlimhhJQmkeJI+pxGI4Ow9ECk2um3Npb01kUMD9FVgcQVOWBK8jTW56DTks3dMBnw9MlM9FsogCd3shomVP/d0Uf+UL9dSWLv+Nc7L0C2BBnMA0pjcRZU9488dwJYigAMr/I/K3U4OFsLX5Kp2P+mWwCi2vpaTKwgL3Ln0vHJj8R4icyag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dOxr7gfwR+KMxPW2rBbh3TaSnAo/P92B2vbxKYlPoXY=;
 b=E1ZvXtlXna+MulilslGyuuINJ6ekoauRZ3MD8rZaf2xc0JlrUFJZ9gNrlGNHLqpDBayZXE7DngKjaPrIUlNTleq/SF/Bf66tjT/VUmO1yrADJ0+qOVS/90Ano+JsN5F5DjbAvpJVNPrYnEQ6SHJDX5OCykwUWVHleB8kCqev1codvPw8p4bHjCnNnTe6eSiiO+iP3UjtSHWSlZPk2knKBc8okI5PnbvuFS90qWoiSX0pidkhr0TYCKsrV17MVbBRvoyh3USX8TYJ/krT/LQxmY4Wm8BGsF1aazck7OV903jE40OPshAW9UFamICsT+HBneQVnJEDLxwhoYAdBNzZdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dOxr7gfwR+KMxPW2rBbh3TaSnAo/P92B2vbxKYlPoXY=;
 b=YFPjjG7YkeLoQ/TxtWgbiNan320rurQQdl2kQsuiTlnF0DtnWLeaKNixgqr9b2sicaWPlckLzMU6omqVa1HmOnj5BONK1Cnr8N8eJ4Ip12dIRI8tSSyDQ+MgNtRap86ZhZBxqgIpvJSviWH26XpbIrYpqS/6hezxuj/V3MwvB2U=
Received: from DUZPR01CA0179.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::10) by PAVPR02MB9475.eurprd02.prod.outlook.com
 (2603:10a6:102:304::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Thu, 12 Dec
 2024 04:24:45 +0000
Received: from DB1PEPF000509EF.eurprd03.prod.outlook.com
 (2603:10a6:10:4b3:cafe::ab) by DUZPR01CA0179.outlook.office365.com
 (2603:10a6:10:4b3::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via Frontend Transport; Thu,
 12 Dec 2024 04:24:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509EF.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 04:24:44 +0000
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Dec
 2024 05:24:43 +0100
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 12 Dec 2024 05:24:43 +0100
Received: from lnxchenhuiz2.sh.cn.axis.com (lnxchenhuiz2.sh.cn.axis.com [192.168.77.59])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 9DCCC286;
	Thu, 12 Dec 2024 05:24:40 +0100 (CET)
From: Hermes Zhang <Hermes.Zhang@axis.com>
To: <jdelvare@suse.com>, <linux@roeck-us.net>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <kernel@axis.com>, Hermes Zhang <Hermes.Zhang@axis.com>,
	<linux-kernel@vger.kernel.org>, <linux-hwmon@vger.kernel.org>
Subject: [PATCH 2/2] hwmon: Add support for D3-323-AA Pyroelectric IR sensor
Date: Thu, 12 Dec 2024 12:24:10 +0800
Message-ID: <20241212042412.702044-3-Hermes.Zhang@axis.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241212042412.702044-1-Hermes.Zhang@axis.com>
References: <20241212042412.702044-1-Hermes.Zhang@axis.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509EF:EE_|PAVPR02MB9475:EE_
X-MS-Office365-Filtering-Correlation-Id: 28c34957-7d8f-4e13-ecb1-08dd1a64e820
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H65xYT3D7ZR685AqtrkOhq1i71/Pw3y/OvRbZzuJ1Gj2AqPE9CJY7h7BBjLe?=
 =?us-ascii?Q?LBx7Hn/cU6p3Sf550HI/xqDwh5zM5Q6e4zQ5xQHon2oK3EwhITwJdFZaYI9e?=
 =?us-ascii?Q?F018RseqaHTPnRpce2ET8OqiUB8JgKjCIgSXVWzFasLlsgrd7oqiCkn0P1Ct?=
 =?us-ascii?Q?CCsfK4w8kwzrHPAzwk+uD2fsOubdAoypw8UTp9TnIenYcfUHW8s/Z0RPScPn?=
 =?us-ascii?Q?e08TEzHUUqmXyyCIH0A1LhLYOAXQSId614nOmERrs734tmxG1w3OGOcLuDCT?=
 =?us-ascii?Q?HLPzdPq5AX3Ktm5LZnV8isNL1IGp1cUAMSvLZty7uWwbjehbob/xLaZ9/XGB?=
 =?us-ascii?Q?ri1dDtix5EvvJdRcq2jjhfSjOOh/EsRPCZ1dRWmQgeNjQk/Oz3hgkrhEhMxq?=
 =?us-ascii?Q?vNZwY0nPwGMIRYkPlHLWQ3Cf9hN668V/ldB9WoKGfOMFLkBc9xwf2PYbbcIn?=
 =?us-ascii?Q?1ko2SE6rIyzxuYh6tuS+BBcQQ1SJQEW3eyLGO8pR+H58YlDX+X1qiWRDjpor?=
 =?us-ascii?Q?IzKzN4phKXqcIW9J8nYoHBZ7tW79eVuDZJaEgZHMHLunXw+fvVef31t5pGiD?=
 =?us-ascii?Q?h+rAlnNLl8zJ4fBOGYmFd3bDNzLakXXV6YxozeIRD89WUyv6uxAnKjwOwSPL?=
 =?us-ascii?Q?jpWe/yqKZSbkDELFPS3RZNofscaaXT06rPuclGg8Ds/VISY/uEHcRT1gZSqF?=
 =?us-ascii?Q?RLCQF8Wy9SxLjppc9gnMO60F0HjTfntOBr8QYgIsFP1NDx2+vttVKcJ6h70h?=
 =?us-ascii?Q?zcYo6Zv+mdbd74V+S5OYXzxue6lp9C5Tax1NjJU37H9SucjQWWIc5kFAkYto?=
 =?us-ascii?Q?KcL2LRWL/OEreVym2dEnkbxpB8XDScAfOFds9FzvVIuJUbTsUrbDhDdNK9t/?=
 =?us-ascii?Q?TAMHuRdyuSx7GRzCkU7DjwgV0+HZBR6Cl3NyFpn9QxLfyWHG+WaM9Sbyyw31?=
 =?us-ascii?Q?ym1ngd//00H9QEEoHSH7dZbau8nb14EYX0w62Txzt5vHiuKHu28RjwUDHPgY?=
 =?us-ascii?Q?Qk+8CutWDX1dWQsY7PCWd2AM9jbvZv8MloByG/l+ZxD3LjUl7qQU3gUvYemQ?=
 =?us-ascii?Q?qdxsYDW4YhiRAvxq0fKWvCmryi5ZHmOgXT+IJMg9vS8JzmHPpJpt9G0Ac64+?=
 =?us-ascii?Q?m30xCm/wI/tAkb2O0Ylvg/JSmKRTaf3rNAF8OnvNnuqFpjCg0UmZukNynKaS?=
 =?us-ascii?Q?CjIAa+C/xL4AxzR1kqqS8mzFq7GfS5dXCZFyTU25niXUXyZLy0xsNk9ptpQJ?=
 =?us-ascii?Q?Rbz+sV2a5SvjYYoD53K4LVD7ArG6DuEVMycaZYSC8EY6+atOt+B175PXJVsF?=
 =?us-ascii?Q?qRWN3WiH6f/U/1DxzP3rWNbCk4vjqfEVEDAwB3W1RZKV3MfACJclQWFZsCcp?=
 =?us-ascii?Q?6bPFbjQRPaztkB3Qv3jmxvZSrL0t6ubcSot6miy1ICsDTYe3dkevVQ1r8Gjg?=
 =?us-ascii?Q?Y94D2bQrM7uwfH9w0uG7GRh3ks/TGzXl?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 04:24:44.9377
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28c34957-7d8f-4e13-ecb1-08dd1a64e820
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509EF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR02MB9475

Add support for Nicera D3-323-AA Pyroelectric IR sensor. The sensor
support to config the threshold/filter_type/filter_step and return the
detect result in sysfs attribute.

Signed-off-by: Hermes Zhang <Hermes.Zhang@axis.com>
---
 drivers/hwmon/Kconfig     |  11 +
 drivers/hwmon/Makefile    |   1 +
 drivers/hwmon/d3-323-aa.c | 493 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 505 insertions(+)
 create mode 100644 drivers/hwmon/d3-323-aa.c

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index dd376602f3f1..25dbfc85d7ab 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -507,6 +507,17 @@ config SENSORS_CROS_EC
 	  This driver can also be built as a module. If so, the module
 	  will be called cros_ec_hwmon.
 
+config SENSORS_D3323AA
+	tristate "Nicera Pyroelectric IR sensors"
+	depends on GPIOLIB && OF
+	select BITREVERSE
+	help
+	  This driver provide support for Nicera D3-323-AA Pyroelectric IR
+	  sensor.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called d3-323-aa.
+
 config SENSORS_DRIVETEMP
 	tristate "Hard disk drives with temperature sensors"
 	depends on SCSI && ATA
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index b827b92f2a78..25b2f55c18ce 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -64,6 +64,7 @@ obj-$(CONFIG_SENSORS_CORETEMP)	+= coretemp.o
 obj-$(CONFIG_SENSORS_CORSAIR_CPRO) += corsair-cpro.o
 obj-$(CONFIG_SENSORS_CORSAIR_PSU) += corsair-psu.o
 obj-$(CONFIG_SENSORS_CROS_EC)	+= cros_ec_hwmon.o
+obj-$(CONFIG_SENSORS_D3323AA)	+= d3-323-aa.o
 obj-$(CONFIG_SENSORS_DA9052_ADC)+= da9052-hwmon.o
 obj-$(CONFIG_SENSORS_DA9055)+= da9055-hwmon.o
 obj-$(CONFIG_SENSORS_DELL_SMM)	+= dell-smm-hwmon.o
diff --git a/drivers/hwmon/d3-323-aa.c b/drivers/hwmon/d3-323-aa.c
new file mode 100644
index 000000000000..d4089e89e678
--- /dev/null
+++ b/drivers/hwmon/d3-323-aa.c
@@ -0,0 +1,493 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * d3-322-aa.c - support for the D3-323-AA Pyroelectric Passive Infrared Sensor
+ *
+ */
+
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/sched.h>
+#include <linux/delay.h>
+#include <linux/jiffies.h>
+#include <linux/atomic.h>
+#include <linux/gpio/consumer.h>
+#include <linux/of.h>
+
+#define DELAY_MS 10
+
+/*
+ *        0  ...  8     9  ...  16    17    18  19    20  21  22    23    24 ...  46   47 48 49 50 51
+ * -------------------------------------------------------------------------------------------------------
+ * F37   F38 ... F46   F47 ... F54   F55   F56 F57   F58 F59 F60   F64   F65 ... F87   Input End Pattern
+ *     |      0      |  threshold  |  0  |  FSTEP  |    FILSEL   |  0  |      0      |  0  1  1  0  1    |
+ *
+ * NOTE: F37 is not used
+ */
+#define THRESHOLD_OFFSET 9
+#define THRESHOLD_LEN 8
+#define FSTEP_OFFSET 18
+#define FSTEP_LEN 2
+#define FILSEL_OFFSET 20
+#define FILSEL_LEN 3
+#define INPUT_END_PATTERN_OFFSET 47
+#define INPUT_END_PATTERN_LEN 5
+
+#define REG_SETTING_SIZE 52
+
+#define DEFAULT_THRESHOLD 0x1C
+/* Input End Pattern: 01101 -> 10110 */
+#define INPUT_END_PATTERN 0x16
+
+#define SET_REGISTER_SEQ_CNT 104 /* (47 + 5) * 2 */
+#define READ_REGISTER_SEQ_CNT 116 /* (47 + 1 + 10) * 2 */
+
+static atomic_t clk_irq_count = ATOMIC_INIT(0);
+
+enum filter_step {
+	STEP_THREE = 0,
+	STEP_ONE = 1,
+	STEP_TWO = 3,
+};
+
+enum filter_type {
+	TYPE_B = 0,
+	TYPE_C = 1,
+	TYPE_D = 2,
+	TYPE_DIRECT = 3,
+	TYPE_A = 7,
+};
+
+enum d3323aa_state {
+	IDLE,
+	POWER_ON,
+	SETUP_WRITE,
+	SETUP_READ,
+	WAIT_FOR_STABLE,
+	RUNNING,
+};
+
+struct d3323aa_data {
+	struct device *dev;
+	struct gpio_desc *clk;
+	struct gpio_desc *si;
+	struct gpio_desc *reset;
+	u8 threshold; /* 0 ~ 255 */
+	enum filter_step step;
+	enum filter_type type;
+	struct delayed_work setup_work;
+	struct work_struct state_worker;
+	struct hrtimer timer;
+	/* Save the clk seq number */
+	int seq;
+	bool error;
+	enum d3323aa_state state;
+	bool detector;
+	/* index of the bitmap */
+	int idx;
+	DECLARE_BITMAP(register_bitmap, REG_SETTING_SIZE);
+};
+
+static ssize_t pir_filter_type_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	struct d3323aa_data *data = dev_get_drvdata(dev);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
+
+	switch (val) {
+	case TYPE_A:
+	case TYPE_B:
+	case TYPE_C:
+	case TYPE_D:
+	case TYPE_DIRECT:
+		data->type = val;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	cancel_delayed_work_sync(&data->setup_work);
+	schedule_delayed_work(&data->setup_work, msecs_to_jiffies(DELAY_MS));
+
+	return count;
+}
+
+static ssize_t pir_filter_step_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	struct d3323aa_data *data = dev_get_drvdata(dev);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
+
+	switch (val) {
+	case STEP_ONE:
+	case STEP_TWO:
+	case STEP_THREE:
+		data->type = val;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	cancel_delayed_work_sync(&data->setup_work);
+	schedule_delayed_work(&data->setup_work, msecs_to_jiffies(DELAY_MS));
+
+	return count;
+}
+
+static ssize_t pir_threshold_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	struct d3323aa_data *data = dev_get_drvdata(dev);
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
+
+	if (val > 255)
+		return -EINVAL;
+
+	data->threshold = val;
+
+	cancel_delayed_work_sync(&data->setup_work);
+	schedule_delayed_work(&data->setup_work, msecs_to_jiffies(DELAY_MS));
+
+	return count;
+}
+
+static ssize_t pir_detector_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct d3323aa_data *data = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%d\n", data->detector);
+}
+
+static DEVICE_ATTR_WO(pir_threshold);
+static DEVICE_ATTR_WO(pir_filter_step);
+static DEVICE_ATTR_WO(pir_filter_type);
+static DEVICE_ATTR_RO(pir_detector);
+
+static struct attribute *d3323aa_attrs[] = {
+	&dev_attr_pir_threshold.attr,
+	&dev_attr_pir_filter_step.attr,
+	&dev_attr_pir_filter_type.attr,
+	&dev_attr_pir_detector.attr,
+	NULL,
+};
+
+ATTRIBUTE_GROUPS(d3323aa);
+
+static void set_field(unsigned long *bmp, int start, int value, int size)
+{
+	int i;
+	int mask = 1;
+
+	for (i = 0; i < size; i++) {
+		assign_bit(start + i, bmp, value & mask);
+		mask <<= 1;
+	}
+}
+
+static void build_register_data(struct d3323aa_data *data)
+{
+	unsigned long *bmap = data->register_bitmap;
+
+	bitmap_zero(bmap, REG_SETTING_SIZE);
+
+	set_field(bmap, THRESHOLD_OFFSET, data->threshold, THRESHOLD_LEN);
+
+	set_field(bmap, FSTEP_OFFSET, data->step, FSTEP_LEN);
+
+	set_field(bmap, FILSEL_OFFSET, data->type, FILSEL_LEN);
+
+	set_field(bmap, INPUT_END_PATTERN_OFFSET, INPUT_END_PATTERN,
+		  INPUT_END_PATTERN_LEN);
+}
+
+static irqreturn_t irq_handler(int irq, void *dev)
+{
+	struct d3323aa_data *data = dev;
+	int count;
+
+	if (data->state == POWER_ON) {
+		int v = gpiod_get_value(data->clk);
+
+		if (v == 1)
+			return IRQ_HANDLED;
+
+		count = atomic_inc_return(&clk_irq_count);
+
+		/* This register setting and verification must be done during the
+		 * configurable period and the starting point of the period is second
+		 * falling edge of VOUT/CLK and DO/SI after turning on
+		 */
+		if (count == 2)
+			schedule_work(&data->state_worker);
+	} else {
+		int v = gpiod_get_value(data->clk);
+
+		data->detector = v ? true : false;
+	}
+
+	return IRQ_HANDLED;
+}
+
+static void d3323aa_reset(struct d3323aa_data *data)
+{
+	gpiod_set_value(data->reset, 1);
+
+	/* The supply voltage should be less than 0.5V for 30msec,
+	 * add 10ms more for VDD discharge
+	 */
+	msleep(40);
+}
+
+static void d3323aa_poweron(struct d3323aa_data *data)
+{
+	int ret;
+
+	atomic_set(&clk_irq_count, 0);
+
+	gpiod_direction_input(data->clk);
+	gpiod_direction_input(data->si);
+
+	if (data->state == RUNNING || data->state == POWER_ON)
+		free_irq(gpiod_to_irq(data->clk), data);
+
+	ret = devm_request_irq(data->dev, gpiod_to_irq(data->clk), irq_handler,
+			       IRQF_TRIGGER_FALLING, "d3323aa_poweron_irq",
+			       data);
+	if (ret) {
+		pr_err("Failed to request IRQ\n");
+		return;
+	}
+
+	data->state = POWER_ON;
+	data->detector = false;
+
+	gpiod_set_value(data->reset, 0);
+}
+
+static void state_worker_func(struct work_struct *work)
+{
+	struct d3323aa_data *data =
+		container_of(work, struct d3323aa_data, state_worker);
+
+	switch (data->state) {
+	case POWER_ON:
+		free_irq(gpiod_to_irq(data->clk), data);
+
+		gpiod_direction_output(data->clk, 0);
+		gpiod_direction_output(data->si, 0);
+
+		data->state = SETUP_WRITE;
+
+		data->seq = 0;
+		/* clk for register setting is 1kHz */
+		hrtimer_start(&data->timer, ktime_set(0, 500 * 1000),
+			      HRTIMER_MODE_REL_HARD);
+		break;
+	case SETUP_WRITE:
+		/* si pin will receive the register setting */
+		gpiod_direction_input(data->si);
+		data->seq = 0;
+		data->idx = -1; /* idx will be reset when dummy bit received */
+		data->error = false;
+		data->state = SETUP_READ;
+
+		/* 9.5ms * 2 */
+		hrtimer_start(&data->timer, ktime_set(0, ms_to_ktime(20)),
+			      HRTIMER_MODE_REL_HARD);
+		break;
+	case SETUP_READ:
+		/* clk pin will receive the pir detect signal */
+		gpiod_direction_input(data->clk);
+		data->state = WAIT_FOR_STABLE;
+
+		/* The stability time(Max. 30 sec) is required for stability of signal
+		 * output after turning on of VDD and after register setting.
+		 */
+		hrtimer_start(&data->timer, ktime_set(30, 0),
+			      HRTIMER_MODE_REL_HARD);
+		break;
+	case WAIT_FOR_STABLE:
+		int ret;
+
+		data->state = RUNNING;
+		ret = devm_request_irq(
+			data->dev, gpiod_to_irq(data->clk), irq_handler,
+			IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+			"d3323aa_detect_irq", data);
+
+		break;
+	default:
+		break;
+	}
+}
+
+static void setup_func(struct work_struct *work)
+{
+	struct d3323aa_data *data =
+		container_of(work, struct d3323aa_data, setup_work.work);
+
+	build_register_data(data);
+
+	d3323aa_reset(data);
+
+	d3323aa_poweron(data);
+}
+
+static enum hrtimer_restart hrtimer_handler(struct hrtimer *hrtimer)
+{
+	struct d3323aa_data *data =
+		container_of(hrtimer, struct d3323aa_data, timer);
+
+	switch (data->state) {
+	case SETUP_WRITE:
+
+		if (data->seq % 2 == 0)
+			gpiod_set_value(data->clk, 0);
+		else
+			gpiod_set_value(data->clk, 1);
+
+		gpiod_set_value(data->si,
+				test_bit(data->seq / 2, data->register_bitmap));
+
+		if (data->seq++ == SET_REGISTER_SEQ_CNT) {
+			schedule_work(&data->state_worker);
+			return HRTIMER_NORESTART;
+		}
+		break;
+	case SETUP_READ:
+		if (data->seq % 2 == 0) {
+			gpiod_set_value(data->clk, 0);
+		} else {
+			gpiod_set_value(data->clk, 1);
+
+			if (data->idx < 0) {
+				/* Reset the idx when dummy bit received */
+				if (gpiod_get_value(data->si) == 1)
+					data->idx = 0;
+			} else if (data->idx < REG_SETTING_SIZE) {
+				if (gpiod_get_value(data->si) !=
+				    test_bit(data->idx++,
+					     data->register_bitmap))
+					data->error = true;
+			}
+		}
+
+		if (data->seq++ == READ_REGISTER_SEQ_CNT) {
+			schedule_work(&data->state_worker);
+			return HRTIMER_NORESTART;
+		}
+		break;
+	case WAIT_FOR_STABLE:
+		schedule_work(&data->state_worker);
+		return HRTIMER_NORESTART;
+	default:
+		break;
+	}
+
+	hrtimer_forward_now(hrtimer, ktime_set(0, 500 * 1000));
+
+	return HRTIMER_RESTART;
+}
+
+static int d3323aa_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct d3323aa_data *data;
+	struct device *hwmon_dev;
+	int ret;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->dev = dev;
+	platform_set_drvdata(pdev, data);
+
+	data->state = IDLE;
+	INIT_WORK(&data->state_worker, state_worker_func);
+	INIT_DELAYED_WORK(&data->setup_work, setup_func);
+	hrtimer_init(&data->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
+	data->timer.function = hrtimer_handler;
+
+	/* Set default register settings */
+	data->threshold = DEFAULT_THRESHOLD;
+	data->step = STEP_TWO;
+	data->type = TYPE_B;
+
+	/* Try requesting the GPIOs */
+	data->reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(data->reset)) {
+		ret = PTR_ERR(data->reset);
+		dev_err(dev, "Reset line GPIO request failed\n");
+		goto err_release_reg;
+	}
+
+	data->clk = devm_gpiod_get(dev, "clk", GPIOD_OUT_LOW);
+	if (IS_ERR(data->clk)) {
+		ret = PTR_ERR(data->clk);
+		dev_err(dev, "CLK line GPIO request failed\n");
+		goto err_release_reg;
+	}
+
+	data->si = devm_gpiod_get(dev, "si", GPIOD_OUT_LOW);
+	if (IS_ERR(data->si)) {
+		ret = PTR_ERR(data->si);
+		dev_err(dev, "SI line GPIO request failed\n");
+		goto err_release_reg;
+	}
+
+	build_register_data(data);
+
+	d3323aa_reset(data);
+
+	d3323aa_poweron(data);
+
+	hwmon_dev = devm_hwmon_device_register_with_groups(
+		dev, pdev->name, data, d3323aa_groups);
+
+	return PTR_ERR_OR_ZERO(hwmon_dev);
+
+err_release_reg:
+	return ret;
+}
+
+static const struct of_device_id d3323aa_dt_match[] = {
+	{ .compatible = "nicera,d3-323-aa" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, d3323aa_dt_match);
+
+static struct platform_driver d3323aa_driver = {
+	.driver = {
+		.name = "d3-323-aa",
+		.of_match_table = of_match_ptr(d3323aa_dt_match),
+	},
+	.probe = d3323aa_probe,
+};
+module_platform_driver(d3323aa_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Nicera D3-323-AA Pyroelectric Infrared sensor driver");
-- 
2.45.2


