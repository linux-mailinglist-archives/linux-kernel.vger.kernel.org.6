Return-Path: <linux-kernel+bounces-573883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C9DA6DD8C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 16:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5781188AB9F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4229261571;
	Mon, 24 Mar 2025 14:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lrtYIYFU"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2078.outbound.protection.outlook.com [40.107.102.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB487261563;
	Mon, 24 Mar 2025 14:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742828333; cv=fail; b=FMwBzcQzWSq0J7kP4yTTRJ0O173C+IJgHakbiwtf37JFXHGrLIe7AulbIVInwfMy4GC+/yNO72iosovUDyiob3MzG/BoY9rBIbQ5wLgdglz5dXic+5F0MayXRgwCThl2wLlQS+wKZL25Mvn5HWw3qNwBx7LO1TbIkkNb0LL0eGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742828333; c=relaxed/simple;
	bh=DaqAcxYiZenXcIR1xKBfeoQkKyzkFjc+sGtRJbAB254=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=itTHwo1j/LsVbOJxAKG9oJSTXyryboAulPUTmJdmB+xVzsuRHAYPETBXR7R8EJULtg1kTTAX9/4M9sgry/uvyiugGetHnbt6qQJKMilOgS0Y2UTkiJvui9sxpTbgWvdsdWijEj/wds90D2Jw11YjYZriP+kvTR1cnOtmbdBq3tQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lrtYIYFU; arc=fail smtp.client-ip=40.107.102.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q6zKMAfn+H/BD26VCMGGUa7R2zkz+k8z5d+w5oG4iF6COIZfED/4zulb17QhWpTn8Yulhpq2Po2YQt2eWE8z4f5EhuvvDtb7ahTywuCcwWhGQM1K+ZORi9H5ktOeG+Sh1w1LEJyn3V+4qSqnhnsqjRhE0SUTWU5YDY3+TXkhyo9fFMfdIkd/8ZRx9N358uPC45Vk/V9LvuEVN/hqoAwkc3vfwdkKq7U2I040aenk34ccF/8Xlkl9UMC1ky5dfKTHoCU/TCjA7RBRP3GVf/CjY9GmxQzxuQa6kh+8DxjrPLZbw6SuwHLc4lECK7LQ3/0IIrWxGP4k9P8JUbn//BzAeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zAp6sxq9NnsDe+Y79dByimbh0iQz+JXSK8YWUxZ3+Z0=;
 b=Bw99wx02JjlHtR16AZWrR1UFDpN+aKdKD4NjhWgkekzz/BQ4mmBVoZmp9IkPqhDj5PeTAiSgE4GqfkqO+g9OeZd97d6grunMf28iBEHdjhJ4ZbJ0ZKsz4cHapU4TXwBX3BMjT6hNAmU82bPwhxkkyKOD/3tjfFqSd4S0nPhFiKJQsoVjPdJj6i+u7PfWMUg6uwXocMUhBlEHenD2f5UVOVxe1yY63TWKk3bsGjWAxptQLg9vzDbsnqZofJ12Oh3JuP84c6r63GbGkwQLr2Yv3tmy5mK7tHZd7R3t5bstq7Qwt5L0DVH2IOFSZV8z3H+UO4ZnXSIzLf6KtDQ6kqFAbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAp6sxq9NnsDe+Y79dByimbh0iQz+JXSK8YWUxZ3+Z0=;
 b=lrtYIYFU623AkR/qN0viojJ+3Igw8DxMygmo6klzMjPAlOJPVjr22j6KR34naAiRGqDSUE1NMM7QjeZfHvgN6yviHNQmK+5LDjnfB3JwTLaUd3ghFWnABYd8zAXn6Qt4wLvCIx/6MWdQ0IcVyPh10a8E/XFF1MW+OVFC9/Af7xA=
Received: from PH8PR22CA0014.namprd22.prod.outlook.com (2603:10b6:510:2d1::29)
 by SA1PR12MB9245.namprd12.prod.outlook.com (2603:10b6:806:3a7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 14:58:48 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:510:2d1:cafe::47) by PH8PR22CA0014.outlook.office365.com
 (2603:10b6:510:2d1::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.36 via Frontend Transport; Mon,
 24 Mar 2025 14:58:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 24 Mar 2025 14:58:48 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Mar
 2025 09:58:44 -0500
From: Akshay Gupta <akshay.gupta@amd.com>
To: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux@roeck-us.net>, <gregkh@linuxfoundation.org>, <arnd@arndb.de>,
	<shyam-sundar.s-k@amd.com>, <gautham.shenoy@amd.com>,
	<mario.limonciello@amd.com>, <naveenkrishna.chatradhi@amd.com>,
	<anand.umarji@amd.com>, Akshay Gupta <akshay.gupta@amd.com>
Subject: [PATCH v6 03/11] misc: amd-sbi: Move hwmon device sensor as separate entity
Date: Mon, 24 Mar 2025 14:58:07 +0000
Message-ID: <20250324145815.1026314-4-akshay.gupta@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250324145815.1026314-1-akshay.gupta@amd.com>
References: <20250324145815.1026314-1-akshay.gupta@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|SA1PR12MB9245:EE_
X-MS-Office365-Filtering-Correlation-Id: 34bc6f72-c065-43a6-f708-08dd6ae461fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y94Tm00mS21XuTlSq+pKThJFu4BQW6dKXJvzYIB1mJPVat6cMfYR0TwUdfk5?=
 =?us-ascii?Q?o4t02Hx1ar/1kaBaE51IQ89SZWBIa7xlcaPQ2I8KRM1ZYY96GEaOlkaBsu/+?=
 =?us-ascii?Q?DVi/k0/gZepXvxQGVBlIy5urGvm4ZGTLAiJPooT5+w5EtADZw/9b1hG9nXm7?=
 =?us-ascii?Q?LP5lMFrtl44uYgy9APFu9hsBdYmCpinW8RgGHFzPtLs7GhDFytmt5O/EsoeN?=
 =?us-ascii?Q?+q8n2EIZchMcUTKI25DP3icJ/inJ1PR+QKCNwifsLhM56qNj5eiEaAQ1mYLC?=
 =?us-ascii?Q?UWfx1A4a+0JIFWJZIgMoQPEyhCObHP0+26+NVTPp8zf/DWfTGqFA5j4BRrbe?=
 =?us-ascii?Q?8f6wpCX3Q2fxKwRNOTRQKs9SzFjP8o8k/zlj2mPwQ4dMAx4UjTZX1r8gddP3?=
 =?us-ascii?Q?bEOb1tP5JnsLfpCjOP0o3w6D+p56dvKvgCG1+fuNXDND6HZtwvvWolKFMqlH?=
 =?us-ascii?Q?t/+xf9OkXpqZnVlsrY2cO5AWPPeihs8rq9x2rAKhKZLS271NJxueSymsC/at?=
 =?us-ascii?Q?gHKGRg1jAqLqEtgTF7Q4Ny3wp7eaMa2Kz6y+z+H8ulATXpXvRVxnNBEGiAp0?=
 =?us-ascii?Q?wPRk++uvN+qtRVKStSLvxauxX5sfIIsFvKNjR4E3qzjF/XcUX5tcSN7hYDUa?=
 =?us-ascii?Q?ga74SqKz6e/oG5CPrhLyPJEVGEDVBc+LKqbrrAyt2NLYWJdLw9B01MOIxP7z?=
 =?us-ascii?Q?pMYNVKQHkv5ddD2RhdbEHn/lyKgCYKrTzSFkWjtGtngMoNE0bTGss6+Q46jL?=
 =?us-ascii?Q?VjibD7cvLZ94qUmg8Nr8arvtguD0oJlZD+Bw0qVluIJF8XAzv+sIqMiRjPzk?=
 =?us-ascii?Q?HXmeLi8efiTufIShcm8gpuggziHPT0JmCfEL9C/lmAC1mrYNJ8jxjt8ZyK2h?=
 =?us-ascii?Q?YfpU42ZQhboVp2Qq2eDvV4zvMsco3izQjUqnU34fgR3GyehIvwLrSACwA6It?=
 =?us-ascii?Q?WO5T+P1gb9pb504fWBVxfLPoqH/hvfA1c6RG80Fc80iJq6OES1lhuuwDgY4h?=
 =?us-ascii?Q?T+/yaku4HIXLIBZ5MfiWgQabnii2JIvNeYk0jml1nd1qbUw5ypltY/nga5CV?=
 =?us-ascii?Q?h0Fz2Xf5ldGQSfOMG/IbD4eDA9qHxzOg1KGd402Ou9yC/4P8zSPXhzxwt4Rf?=
 =?us-ascii?Q?ULVete7O8D5a6YfcY8E7K06hDXtdg7FL6bYoJLLB6jjvUUSl4ualo5VORIUS?=
 =?us-ascii?Q?1FYF7NGZMCK/rUMM0ncBz/5qsHAiC/Fnbyp84kcp/Gaol5XgPa/xnbVxCW+F?=
 =?us-ascii?Q?LnzyoD7Mi8d4nsdBz5VpnXQXfC5KQfLSA2RbMoEJCmQd5nZTRmBKPYuWRFsP?=
 =?us-ascii?Q?OvEmZt0GDAGuTEAVh4MmLbw3nXjRCwMzQkMIKrnLziLOFS0aC3bF2EZBvM/0?=
 =?us-ascii?Q?ywyQVwT2RqJjdVMOClbvA3nynqA0xMlz8efM9SLjsNcVImdLerukF+sjNikc?=
 =?us-ascii?Q?movrVvUZNu3l9ADd7Qx02ASPj1O6SAN9U/AZ1l5sVCCNa0t6FF+d+RrAmte8?=
 =?us-ascii?Q?dBOTwVpBQUpDozI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 14:58:48.4193
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34bc6f72-c065-43a6-f708-08dd6ae461fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9245

- Move hwmon device sensor to misc as only power is reported through
  hwmon sensor.

Reviewed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Signed-off-by: Akshay Gupta <akshay.gupta@amd.com>
---
Changes since v5:
- Patch rebased

Changes since v4:
New patch: Patch split from v4 patch 1/9
- Update Copyright year to 2025

 drivers/misc/amd-sbi/Makefile    |   2 +-
 drivers/misc/amd-sbi/rmi-core.h  |   1 +
 drivers/misc/amd-sbi/rmi-hwmon.c | 123 +++++++++++++++++++++++++++++++
 drivers/misc/amd-sbi/rmi-i2c.c   | 107 +--------------------------
 4 files changed, 127 insertions(+), 106 deletions(-)
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
index 000000000000..68217f2afb89
--- /dev/null
+++ b/drivers/misc/amd-sbi/rmi-hwmon.c
@@ -0,0 +1,123 @@
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
+	if (IS_REACHABLE(CONFIG_HWMON)) {
+		struct device *hwmon_dev;
+		hwmon_dev = devm_hwmon_device_register_with_info(dev, "sbrmi", data,
+								 &sbrmi_chip_info, NULL);
+		return PTR_ERR_OR_ZERO(hwmon_dev);
+	}
+	return 0;
+}
diff --git a/drivers/misc/amd-sbi/rmi-i2c.c b/drivers/misc/amd-sbi/rmi-i2c.c
index 49049ce5bd02..9ad4c8093399 100644
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
 
@@ -173,12 +74,8 @@ static int sbrmi_i2c_probe(struct i2c_client *client)
 	if (ret < 0)
 		return ret;
 
-	if (IS_REACHABLE(CONFIG_HWMON)) {
-		hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name, data,
-								 &sbrmi_chip_info, NULL);
-		ret = PTR_ERR_OR_ZERO(hwmon_dev);
-	}
-	return ret;
+	dev_set_drvdata(dev, data);
+	return create_hwmon_sensor_device(dev, data);
 }
 
 static const struct i2c_device_id sbrmi_id[] = {
-- 
2.25.1


