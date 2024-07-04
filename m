Return-Path: <linux-kernel+bounces-240935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0329274CA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 13:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40074280ABE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 11:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8C91AC425;
	Thu,  4 Jul 2024 11:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ayasexkv"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BAF1ACE65;
	Thu,  4 Jul 2024 11:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720091845; cv=fail; b=SzcEw3hIwU15iGwA2F8NKiNKwq3Hy+NuNvXAjO8gwVDonylVun6YdL0zJ8K6y6zvcHs9p2oe7Tk4/BcdKbyGgMMON4HJ4oy2TQLPRc2uVFaMT7oxoLSvuAyfQT+TyfYWFZvWErCmvDoKs4qKr7qOpNkBYWYi8V8+zRtqYfBoJck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720091845; c=relaxed/simple;
	bh=699xueT8R6YOJSqiy6hg5ePggAfEhadMKpZvxSAdksk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iRenGYJuWvBgOwF/UbyJ3v0G/rahUYJToNcdhpb8JIw1n79u6986IFuJaK2cddaRHFvQfGETnAb7wNzHylRXCUScN0QASgEYT58Es8HRO1OM8EUGxZZ0Q3n6lmsbzwTPmhY+ImN22lsDdmbyiFVHzPOOgdM16sHaVDHSMu4QehU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ayasexkv; arc=fail smtp.client-ip=40.107.94.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BvWj/emJzk0hHLrTDR1SVwdUem6STo5+9SLcPgb1IEvnnwqjDy7PZByrhaytM6EHXKaf4E5lpbjmuTSpOJGxGuEv584mq25bbohJL8tw2ygFMSEyyEdaVEcCGJwvbU9eA6T7wd0S2FhrhXf0GE8zNNp9EgHW4saSDrFa9XLA+b82JuMCwGh6uEv2PvxsOqMYXX2PV8hk0ZzNHRqwfjOh3I2cTbv18YGtLynOcp+p7qtDJm37JHGZlXlQy1Va+exGXJs3f5FCCPh/jnMCHBqzC1mjcn+P6H9sA5/13ln91ViNUy5Sf5zwBGAvvXl6maIn4FwV81UQb3TxGp433qZX+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tCknv5RABI7C11RFlwDTtT7PxR1LQpcz44xkUG1SHEk=;
 b=ifuvgwnPYm9LDlutqbkGipLqOMAkv4daE4HRfhXcbFZFoGsJGTnVS+a/RMf9KeytdRPhpOqTgtpj/O4LfBYAeIdm+rqfPm1GP/T4YMywxvUuNXluGx1icwio+LSu10lT+sVLmKOvG3GywG2p6pSboxW8KpDRgtRmuyKBgHFWkojTb/+FLWKrT8j6WpmDFknUN0zGjQirCr9qLd8jsInSfBBl1+cWZpxjQ6UjnnJntECILF33dz+NV51WHXrM7JaOBFP9snJu1B7NQKqwYabS1fuVv5/S11imne9yhuwGdRXD53xEkgE8jNnxa+wSuekYFeU9P/bMKziqZg7dU0WRGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCknv5RABI7C11RFlwDTtT7PxR1LQpcz44xkUG1SHEk=;
 b=ayasexkvYc7a0CG0maygaSZZ3g2cm6tBCU2GqszLmSC9e69OJKQgQ8EFwnUvk1ydxuwpQq1/f0z5aSa35tx8HRd5x9gZ8OKvzv0NZhlqYISlAYgJiwaJLm3bgCQb5neuoBbw3uQrUK9zQpvpX6eKvw6ki942o9sMFnLJK+TErug=
Received: from CH5P221CA0001.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::6)
 by PH7PR12MB6788.namprd12.prod.outlook.com (2603:10b6:510:1ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Thu, 4 Jul
 2024 11:17:20 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:610:1f2:cafe::c0) by CH5P221CA0001.outlook.office365.com
 (2603:10b6:610:1f2::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.30 via Frontend
 Transport; Thu, 4 Jul 2024 11:17:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Thu, 4 Jul 2024 11:17:19 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 4 Jul
 2024 06:17:16 -0500
From: Akshay Gupta <akshay.gupta@amd.com>
To: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux@roeck-us.net>, <gregkh@linuxfoundation.org>, <arnd@arndb.de>
CC: <naveenkrishna.chatradhi@amd.com>, Akshay Gupta <akshay.gupta@amd.com>
Subject: [PATCH 5/6] misc/hwmon: sbrmi: Add support for APML protocols
Date: Thu, 4 Jul 2024 11:16:23 +0000
Message-ID: <20240704111624.1583460-6-akshay.gupta@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240704111624.1583460-1-akshay.gupta@amd.com>
References: <20240704111624.1583460-1-akshay.gupta@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|PH7PR12MB6788:EE_
X-MS-Office365-Filtering-Correlation-Id: dd4955af-35cd-40d1-2949-08dc9c1adec0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BIXH/4nnUduUvyPqkOzR0+S8JS27hLMFzZd+H3M785sTN6TfxNxYAvjCcu7f?=
 =?us-ascii?Q?8n9nBzewkHfjUuDyHnjFCZzr1HFGZdKZVn85FTX5Ok6g/nzKclQOaOVxKMfM?=
 =?us-ascii?Q?3wIKhEmas/2JvKd0XYfSXACAsWCwS+ofGTo3kXg0/BXqUI00/A+D95QJIKlx?=
 =?us-ascii?Q?RmpxtvJa9mGuPZEiEgfWbCBN2JHngD1u7RDpXpvvDi31/GB3MWeCcqPtNKOl?=
 =?us-ascii?Q?bZagqAI5UToLwdYNkeI7r4fUAjwwsJkH69cK0QPe2CZlzAGzx8jKA9b5DIOl?=
 =?us-ascii?Q?OiNbfY1GAwOk8rakNMgkvOkRzdlGugc0D9TgKMQ7jHKelyecnmn4vD8DehyE?=
 =?us-ascii?Q?hDvJqO197qmv9Cvi/YyLI8QLfE2EV0TxUEtY61mp1s+8nbeSqMnvsKP2RSCV?=
 =?us-ascii?Q?tt8LfFBBYRbqPZ1wQg3HDnTSO9M7a3XBk7dHRiRCzQaBK3LKaiJVo0TFiccK?=
 =?us-ascii?Q?wMtd0BUhn/MP5Q3PLc4yxYDUJEwMdikt7I3Ph5FTvBxntQ3qQbacymV5N/Or?=
 =?us-ascii?Q?/JdsjKd0rr1DrUKc0Ano/zvE1VR2pYERWR57tP+cdSyAt18U2whvSmJ/wsRd?=
 =?us-ascii?Q?A6eUgf250dlKTZo261QmDQM1TrHk1T9r8SXhdw06id0QY7gpTtCaVdjo417g?=
 =?us-ascii?Q?SfE58WN+xlFQ5AJI5ZTJ90BXjWJwieiGKO1Seh1qMcUFUCSpSk1t6b5+7T89?=
 =?us-ascii?Q?QixXfc30BlfBCsn/rlV8E683bXcB+ULdkHwrUyoFWNk2M23E4l7E3qgPnoWU?=
 =?us-ascii?Q?6L1fnOoRbX4FM+E2TpqgPblJ/ffJ5tYPvOVfffNJcyqFASsbsEWrwdF87u5E?=
 =?us-ascii?Q?U8btFskLsTAfSRtkk3rCbkD2+Bewr7YV0NzZIdKbUqIomx0ZxGAfgUGUt0Cx?=
 =?us-ascii?Q?JFrSsRNYVoSk3b6pyhE52eJ2EFrQwIt8hlf9OF/hQlMjpK3BQhM9SP606SC+?=
 =?us-ascii?Q?sXQPl64CnLej/YZ5LQQ1i4TJZ5fxlelq4WAJPPo0Gn/XKOpaN06N/HAVO0qe?=
 =?us-ascii?Q?3xzgtvuGkkiZCcI8IYMpTvUR2Np/b1KjjaM4+vuKaCigk6SpZnvyQa205wZd?=
 =?us-ascii?Q?bV7WqTBV0PQNvNttC7sTSKpgtX/L9ES2t2uf4I3Lwt5xBIkba0s7fciR4/As?=
 =?us-ascii?Q?oH3btkKyq3KdiffgCs9PF3DtS6oQx4425CamhIwPd2FeqIOyoJF4PYY4s4Zu?=
 =?us-ascii?Q?KS6emC1dUS4yWtJOhdfMwnmpZuAPdtEDsLcLOxXpAvgzA7XRrh7Qy5Ske4NL?=
 =?us-ascii?Q?xmjlOp/8mjsEH2OxuQjy/QOeENMD6MSsdEDUFPAkCw8os+/DosvDXPOSLfr2?=
 =?us-ascii?Q?mX5QqnBiExDJrtrV86bTOMgkEK2B2ZFEq4cV3ZtzM4XUihDCw9LVfALaUGaC?=
 =?us-ascii?Q?+GzBlFDWikyY0/wf8mUJdD3bvlwzdVFWbCHf0xaikWccL099Yw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 11:17:19.8892
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd4955af-35cd-40d1-2949-08dc9c1adec0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6788

The present sbrmi module only support reporting power via hwmon.
However, AMD data center range of processors support various
system management functionality Out-of-band over
Advanced Platform Management Link (APML).

Register a miscdevice, which creates a device /dev/sbrmiX with an IOCTL
interface for the user space to invoke the following protocols.
  - Mailbox read/write (already defined in sbrmi_mailbox_xfer())
  - CPUID read
  - MCAMSR read

Open-sourced and widely used https://github.com/amd/esmi_oob_library
will continue to provide user-space programmable API.

Signed-off-by: Akshay Gupta <akshay.gupta@amd.com>
Reviewed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
---
 drivers/hwmon/sbrmi.c            |  22 +-
 drivers/misc/amd-sb/sbrmi-core.c | 462 +++++++++++++++++++++++++++----
 drivers/misc/amd-sb/sbrmi-core.h |  36 +++
 drivers/misc/amd-sb/sbrmi-i2c.c  |  39 ++-
 include/misc/amd-sb.h            |  30 +-
 include/uapi/linux/amd-apml.h    |  74 +++++
 6 files changed, 589 insertions(+), 74 deletions(-)
 create mode 100644 drivers/misc/amd-sb/sbrmi-core.h
 create mode 100644 include/uapi/linux/amd-apml.h

diff --git a/drivers/hwmon/sbrmi.c b/drivers/hwmon/sbrmi.c
index 90b8f94a43fa..564a5a2a418d 100644
--- a/drivers/hwmon/sbrmi.c
+++ b/drivers/hwmon/sbrmi.c
@@ -20,7 +20,7 @@ static int sbrmi_read(struct device *dev, enum hwmon_sensor_types type,
 		      u32 attr, int channel, long *val)
 {
 	struct sbrmi_data *data = dev_get_drvdata(dev);
-	struct sbrmi_mailbox_msg msg = { 0 };
+	struct apml_message msg = { 0 };
 	int ret;
 
 	if (!data)
@@ -29,7 +29,7 @@ static int sbrmi_read(struct device *dev, enum hwmon_sensor_types type,
 	if (type != hwmon_power)
 		return -EINVAL;
 
-	msg.read = true;
+	msg.data_in.reg_in[RD_FLAG_INDEX] = 1;
 	switch (attr) {
 	case hwmon_power_input:
 		msg.cmd = SBRMI_READ_PKG_PWR_CONSUMPTION;
@@ -40,16 +40,17 @@ static int sbrmi_read(struct device *dev, enum hwmon_sensor_types type,
 		ret = rmi_mailbox_xfer(data, &msg);
 		break;
 	case hwmon_power_cap_max:
-		msg.data_out = data->pwr_limit_max;
+		msg.data_out.mb_out[RD_WR_DATA_INDEX] = data->pwr_limit_max;
 		ret = 0;
 		break;
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
 	}
-	if (ret < 0)
-		return ret;
+
 	/* hwmon power attributes are in microWatt */
-	*val = (long)msg.data_out * 1000;
+	if (!ret)
+		*val = (long)msg.data_out.mb_out[RD_WR_DATA_INDEX] * 1000;
+
 	return ret;
 }
 
@@ -57,7 +58,7 @@ static int sbrmi_write(struct device *dev, enum hwmon_sensor_types type,
 		       u32 attr, int channel, long val)
 {
 	struct sbrmi_data *data = dev_get_drvdata(dev);
-	struct sbrmi_mailbox_msg msg = { 0 };
+	struct apml_message msg = { 0 };
 
 	if (!data)
 		return -ENODEV;
@@ -73,8 +74,8 @@ static int sbrmi_write(struct device *dev, enum hwmon_sensor_types type,
 	val = clamp_val(val, SBRMI_PWR_MIN, data->pwr_limit_max);
 
 	msg.cmd = SBRMI_WRITE_PKG_PWR_LIMIT;
-	msg.data_in = val;
-	msg.read = false;
+	msg.data_in.mb_in[RD_WR_DATA_INDEX] = val;
+	msg.data_in.reg_in[RD_FLAG_INDEX] = 0;
 
 	return rmi_mailbox_xfer(data, &msg);
 }
@@ -124,6 +125,7 @@ static int sbrmi_probe(struct platform_device *pdev)
 
 	if (!data)
 		return -ENODEV;
+
 	hwmon_dev = devm_hwmon_device_register_with_info(dev, "sbrmi", data,
 							 &sbrmi_chip_info, NULL);
 	return PTR_ERR_OR_ZERO(hwmon_dev);
diff --git a/drivers/misc/amd-sb/sbrmi-core.c b/drivers/misc/amd-sb/sbrmi-core.c
index e528b7314447..c180f58b92c3 100644
--- a/drivers/misc/amd-sb/sbrmi-core.c
+++ b/drivers/misc/amd-sb/sbrmi-core.c
@@ -7,40 +7,266 @@
  */
 #include <linux/delay.h>
 #include <linux/err.h>
+#include <linux/fs.h>
 #include <linux/i2c.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/regmap.h>
 #include <misc/amd-sb.h>
+#include "sbrmi-core.h"
 
 /* Mask for Status Register bit[1] */
 #define SW_ALERT_MASK	0x2
+/* Mask to check H/W Alert status bit */
+#define HW_ALERT_MASK	0x80
 
 /* Software Interrupt for triggering */
 #define START_CMD	0x80
 #define TRIGGER_MAILBOX	0x01
 
-/* SB-RMI registers */
-enum sbrmi_reg {
-	SBRMI_CTRL		= 0x01,
-	SBRMI_STATUS,
-	SBRMI_OUTBNDMSG0	= 0x30,
-	SBRMI_OUTBNDMSG1,
-	SBRMI_OUTBNDMSG2,
-	SBRMI_OUTBNDMSG3,
-	SBRMI_OUTBNDMSG4,
-	SBRMI_OUTBNDMSG5,
-	SBRMI_OUTBNDMSG6,
-	SBRMI_OUTBNDMSG7,
-	SBRMI_INBNDMSG0,
-	SBRMI_INBNDMSG1,
-	SBRMI_INBNDMSG2,
-	SBRMI_INBNDMSG3,
-	SBRMI_INBNDMSG4,
-	SBRMI_INBNDMSG5,
-	SBRMI_INBNDMSG6,
-	SBRMI_INBNDMSG7,
-	SBRMI_SW_INTERRUPT,
-};
+/* Default message lengths as per APML command protocol */
+/* MSR */
+#define MSR_RD_REG_LEN		0xa
+#define MSR_WR_REG_LEN		0x8
+#define MSR_RD_DATA_LEN		0x8
+#define MSR_WR_DATA_LEN		0x7
+/* CPUID */
+#define CPUID_RD_DATA_LEN	0x8
+#define CPUID_WR_DATA_LEN	0x8
+#define CPUID_RD_REG_LEN	0xa
+#define CPUID_WR_REG_LEN	0x9
+
+/* CPUID MSR Command Ids */
+#define CPUID_MCA_CMD	0x73
+#define RD_CPUID_CMD	0x91
+#define RD_MCA_CMD	0x86
+
+/* input for bulk write to CPUID and MSR protocol */
+struct cpu_msr_indata {
+	u8 wr_len;	/* const value */
+	u8 rd_len;	/* const value */
+	u8 proto_cmd;	/* const value */
+	u8 thread;	/* thread number */
+	union {
+		u8 reg_offset[4];	/* input value */
+		u32 value;
+	};
+	u8 ext; /* extended function */
+} __packed;
+
+/* output for bulk read from CPUID and MSR protocol */
+struct cpu_msr_outdata {
+	u8 num_bytes;	/* number of bytes return */
+	u8 status;	/* Protocol status code */
+	union {
+		u64 value;
+		u8 reg_data[8];
+	};
+} __packed;
+
+#define prepare_mca_msr_input_message(input, thread_id, data_in)	\
+	input.rd_len = MSR_RD_DATA_LEN,					\
+	input.wr_len = MSR_WR_DATA_LEN,					\
+	input.proto_cmd = RD_MCA_CMD,					\
+	input.thread = thread_id << 1,					\
+	input.value =  data_in
+
+#define prepare_cpuid_input_message(input, thread_id, func, ext_func)	\
+	input.rd_len = CPUID_RD_DATA_LEN,				\
+	input.wr_len = CPUID_WR_DATA_LEN,				\
+	input.proto_cmd = RD_CPUID_CMD,					\
+	input.thread = thread_id << 1,					\
+	input.value =  func,						\
+	input.ext =  ext_func
+
+static int sbrmi_get_rev(struct sbrmi_data *data)
+{
+	struct apml_message msg = { 0 };
+	int ret;
+
+	msg.data_in.reg_in[REG_OFF_INDEX] = SBRMI_REV;
+	msg.data_in.reg_in[RD_FLAG_INDEX] = 1;
+	ret = regmap_read(data->regmap,
+			  msg.data_in.reg_in[REG_OFF_INDEX],
+			  &msg.data_out.mb_out[RD_WR_DATA_INDEX]);
+	if (ret < 0)
+		return ret;
+
+	data->rev = msg.data_out.reg_out[RD_WR_DATA_INDEX];
+	return 0;
+}
+
+/*
+ * For Mailbox command software alert status bit is set by firmware
+ * to indicate command completion
+ * For RMI Rev 0x20, new h/w status bit is introduced. which is used
+ * by firmware to indicate completion of commands (0x71, 0x72, 0x73).
+ * wait for the status bit to be set by the firmware before
+ * reading the data out.
+ */
+static int sbrmi_wait_status(struct sbrmi_data *data,
+			     int *status, int mask)
+{
+	int ret, retry = 100;
+
+	do {
+		ret = regmap_read(data->regmap, SBRMI_STATUS, status);
+		if (ret < 0)
+			return ret;
+
+		if (*status & mask)
+			break;
+
+		/* Wait 1~2 second for firmware to return data out */
+		if (retry > 95)
+			usleep_range(50, 100);
+		else
+			usleep_range(10000, 20000);
+	} while (retry--);
+
+	if (retry < 0)
+		ret = -ETIMEDOUT;
+	return ret;
+}
+
+/* MCA MSR protocol */
+static int rmi_mca_msr_read(struct sbrmi_data *data,
+			    struct apml_message *msg)
+{
+	struct cpu_msr_outdata output = {0};
+	struct cpu_msr_indata input = {0};
+	int ret, val = 0;
+	int hw_status;
+	u16 thread;
+
+	/* cache the rev value to identify if protocol is supported or not */
+	if (!data->rev) {
+		ret = sbrmi_get_rev(data);
+		if (ret < 0)
+			return ret;
+	}
+	/* MCA MSR protocol for REV 0x10 is not supported*/
+	if (data->rev == 0x10)
+		return -EOPNOTSUPP;
+
+	thread = msg->data_in.reg_in[THREAD_LOW_INDEX] |
+		 msg->data_in.reg_in[THREAD_HI_INDEX] << 8;
+
+	/* Thread > 127, Thread128 CS register, 1'b1 needs to be set to 1 */
+	if (thread > 127) {
+		thread -= 128;
+		val = 1;
+	}
+	ret = regmap_write(data->regmap, SBRMI_THREAD128CS, val);
+	if (ret < 0)
+		goto exit_unlock;
+
+	prepare_mca_msr_input_message(input, thread,
+				      msg->data_in.mb_in[RD_WR_DATA_INDEX]);
+
+	ret = regmap_bulk_write(data->regmap, CPUID_MCA_CMD,
+				&input, MSR_WR_REG_LEN);
+	if (ret < 0)
+		goto exit_unlock;
+
+	ret = sbrmi_wait_status(data, &hw_status, HW_ALERT_MASK);
+	if (ret < 0)
+		goto exit_unlock;
+
+	ret = regmap_bulk_read(data->regmap, CPUID_MCA_CMD,
+			       &output, MSR_RD_REG_LEN);
+	if (ret < 0)
+		goto exit_unlock;
+
+	ret = regmap_write(data->regmap, SBRMI_STATUS,
+			   HW_ALERT_MASK);
+	if (ret < 0)
+		goto exit_unlock;
+
+	if (output.num_bytes != MSR_RD_REG_LEN - 1) {
+		ret = -EMSGSIZE;
+		goto exit_unlock;
+	}
+	if (output.status) {
+		ret = -EPROTOTYPE;
+		msg->fw_ret_code = output.status;
+		goto exit_unlock;
+	}
+	msg->data_out.cpu_msr_out = output.value;
+
+exit_unlock:
+	return ret;
+}
+
+/* Read CPUID function protocol */
+static int rmi_cpuid_read(struct sbrmi_data *data,
+			  struct apml_message *msg)
+{
+	struct cpu_msr_indata input = {0};
+	struct cpu_msr_outdata output = {0};
+	int val = 0;
+	int ret, hw_status;
+	u16 thread;
+
+	/* cache the rev value to identify if protocol is supported or not */
+	if (!data->rev) {
+		ret = sbrmi_get_rev(data);
+		if (ret < 0)
+			return ret;
+	}
+	/* CPUID protocol for REV 0x10 is not supported*/
+	if (data->rev == 0x10)
+		return -EOPNOTSUPP;
+
+	thread = msg->data_in.reg_in[THREAD_LOW_INDEX] |
+		 msg->data_in.reg_in[THREAD_HI_INDEX] << 8;
+
+	/* Thread > 127, Thread128 CS register, 1'b1 needs to be set to 1 */
+	if (thread > 127) {
+		thread -= 128;
+		val = 1;
+	}
+	ret = regmap_write(data->regmap, SBRMI_THREAD128CS, val);
+	if (ret < 0)
+		goto exit_unlock;
+
+	prepare_cpuid_input_message(input, thread,
+				    msg->data_in.mb_in[RD_WR_DATA_INDEX],
+				    msg->data_in.reg_in[EXT_FUNC_INDEX]);
+
+	ret = regmap_bulk_write(data->regmap, CPUID_MCA_CMD,
+				&input, CPUID_WR_REG_LEN);
+	if (ret < 0)
+		goto exit_unlock;
+
+	ret = sbrmi_wait_status(data, &hw_status, HW_ALERT_MASK);
+	if (ret < 0)
+		goto exit_unlock;
+
+	ret = regmap_bulk_read(data->regmap, CPUID_MCA_CMD,
+			       &output, CPUID_RD_REG_LEN);
+	if (ret < 0)
+		goto exit_unlock;
+
+	ret = regmap_write(data->regmap, SBRMI_STATUS,
+			   HW_ALERT_MASK);
+	if (ret < 0)
+		goto exit_unlock;
+
+	if (output.num_bytes != CPUID_RD_REG_LEN - 1) {
+		ret = -EMSGSIZE;
+		goto exit_unlock;
+	}
+	if (output.status) {
+		ret = -EPROTOTYPE;
+		msg->fw_ret_code = output.status;
+		goto exit_unlock;
+	}
+	msg->data_out.cpu_msr_out = output.value;
+exit_unlock:
+	return ret;
+}
 
 static int sbrmi_clear_status_alert(struct sbrmi_data *data)
 {
@@ -58,15 +284,15 @@ static int sbrmi_clear_status_alert(struct sbrmi_data *data)
 			    SW_ALERT_MASK);
 }
 
-int rmi_mailbox_xfer(struct sbrmi_data *data,
-		     struct sbrmi_mailbox_msg *msg)
+static int __rmi_mailbox_xfer(struct sbrmi_data *data,
+			      struct apml_message *msg)
 {
-	unsigned int bytes;
-	int i, ret, retry = 10;
+	unsigned int bytes, ec;
+	int i, ret;
 	int sw_status;
 	u8 byte;
 
-	mutex_lock(&data->lock);
+	msg->fw_ret_code = 0;
 
 	ret = sbrmi_clear_status_alert(data);
 	if (ret < 0)
@@ -87,8 +313,8 @@ int rmi_mailbox_xfer(struct sbrmi_data *data,
 	 * Command Data In[31:0] to SBRMI::InBndMsg_inst[4:1]
 	 * SBRMI_x3C(MSB):SBRMI_x39(LSB)
 	 */
-	for (i = 0; i < 4; i++) {
-		byte = (msg->data_in >> i * 8) & 0xff;
+	for (i = 0; i < MB_DATA_SIZE; i++) {
+		byte = msg->data_in.reg_in[i];
 		ret = regmap_write(data->regmap, SBRMI_INBNDMSG1 + i, byte);
 		if (ret < 0)
 			goto exit_unlock;
@@ -107,46 +333,182 @@ int rmi_mailbox_xfer(struct sbrmi_data *data,
 	 * an ALERT (if enabled) to initiator (BMC) to indicate completion
 	 * of the requested command
 	 */
-	do {
-		ret = regmap_read(data->regmap, SBRMI_STATUS, &sw_status);
-		if (sw_status < 0) {
-			ret = sw_status;
-			goto exit_unlock;
-		}
-		if (sw_status & SW_ALERT_MASK)
-			break;
-		usleep_range(50, 100);
-	} while (retry--);
-
-	if (retry < 0) {
-		ret = -EIO;
+	ret = sbrmi_wait_status(data, &sw_status, SW_ALERT_MASK);
+	if (ret < 0)
 		goto exit_unlock;
-	}
+
+	ret = regmap_read(data->regmap, SBRMI_OUTBNDMSG7, &ec);
+	if (ret || ec)
+		goto exit_clear_alert;
 
 	/*
 	 * For a read operation, the initiator (BMC) reads the firmware
 	 * response Command Data Out[31:0] from SBRMI::OutBndMsg_inst[4:1]
 	 * {SBRMI_x34(MSB):SBRMI_x31(LSB)}.
 	 */
-	if (msg->read) {
-		for (i = 0; i < 4; i++) {
+	if (msg->data_in.reg_in[RD_FLAG_INDEX]) {
+		for (i = 0; i < MB_DATA_SIZE; i++) {
 			ret = regmap_read(data->regmap,
 					  SBRMI_OUTBNDMSG1 + i, &bytes);
 			if (ret < 0)
-				goto exit_unlock;
-			msg->data_out |= bytes << i * 8;
+				break;
+			msg->data_out.reg_out[i] = bytes;
 		}
 	}
-
+exit_clear_alert:
 	/*
 	 * BMC must write 1'b1 to SBRMI::Status[SwAlertSts] to clear the
 	 * ALERT to initiator
 	 */
 	ret = regmap_write(data->regmap, SBRMI_STATUS,
-			   sw_status | SW_ALERT_MASK);
-
+			   SW_ALERT_MASK);
+	if (ec) {
+		ret = -EPROTOTYPE;
+		msg->fw_ret_code = ec;
+	}
 exit_unlock:
+	return ret;
+}
+
+static int rmi_xfer(struct sbrmi_data *data,
+		    struct apml_message *msg)
+{
+	int ret;
+
+	if (!data || !msg)
+		return -ENODEV;
+
+	/*
+	 * Only one I2C transaction can happen at
+	 * one time. Take lock across so no two protocol is
+	 * invoked at same time, modifying the register value.
+	 */
+	mutex_lock(&data->lock);
+	/* Verify device unbind/remove is not invoked */
+	if (atomic_read(&data->no_new_trans)) {
+		mutex_unlock(&data->lock);
+		return -EBUSY;
+	}
+
+	/*
+	 * Set the in_progress variable to true, to wait for
+	 * completion during unbind/remove of driver
+	 */
+	atomic_set(&data->in_progress, 1);
+
+	switch (msg->cmd) {
+	case 0 ... 0x999:
+		/* Mailbox protocol */
+		ret = __rmi_mailbox_xfer(data, msg);
+		break;
+	case APML_CPUID:
+		ret = rmi_cpuid_read(data, msg);
+		break;
+	case APML_MCA_MSR:
+		/* MCAMSR protocol */
+		ret = rmi_mca_msr_read(data, msg);
+		break;
+	case APML_REG:
+		/* REG R/W */
+		if (msg->data_in.reg_in[RD_FLAG_INDEX])
+			ret = regmap_read(data->regmap,
+					  msg->data_in.reg_in[REG_OFF_INDEX],
+					  &msg->data_out.mb_out[RD_WR_DATA_INDEX]);
+		else
+			ret = regmap_write(data->regmap,
+					   msg->data_in.reg_in[REG_OFF_INDEX],
+					   msg->data_in.reg_in[REG_VAL_INDEX]);
+		break;
+	default:
+		break;
+	}
+	/* Send complete only if device is unbinded/remove */
+	if (atomic_read(&data->no_new_trans))
+		complete(&data->misc_fops_done);
+
+	atomic_set(&data->in_progress, 0);
 	mutex_unlock(&data->lock);
+
 	return ret;
 }
+
+/*
+ * rmi_mailbox_xfer() function is used in hwmon/sbrmi.c
+ * To support backward compatibility for the hwmon driver
+ * will export the rmi_mailbox_xfer function and call the
+ * new function rmi_xfer from it.
+ */
+int rmi_mailbox_xfer(struct sbrmi_data *data,
+		     struct apml_message *msg)
+{
+	return rmi_xfer(data, msg);
+}
 EXPORT_SYMBOL(rmi_mailbox_xfer);
+
+static long sbrmi_ioctl(struct file *fp, unsigned int cmd, unsigned long arg)
+{
+	int __user *arguser = (int  __user *)arg;
+	struct apml_message msg = { 0 };
+	bool read = false;
+	int ret = -EFAULT;
+
+	struct sbrmi_data *data = container_of(fp->private_data, struct sbrmi_data,
+					       sbrmi_misc_dev);
+	if (!data)
+		return -ENODEV;
+
+	/*
+	 * If device remove/unbind is called do not allow new transaction
+	 */
+	if (atomic_read(&data->no_new_trans))
+		return -EBUSY;
+	/* Copy the structure from user */
+	if (copy_struct_from_user(&msg, sizeof(msg), arguser,
+				  sizeof(struct apml_message)))
+		return ret;
+
+	/* Is this a read/monitor/get request */
+	if (msg.data_in.reg_in[RD_FLAG_INDEX])
+		read = true;
+
+	ret = rmi_xfer(data, &msg);
+
+	/* Copy results back to user only for get/monitor commands and firmware failures */
+	if ((read && !ret) || ret == -EPROTOTYPE) {
+		if (copy_to_user(arguser, &msg, sizeof(struct apml_message)))
+			ret = -EFAULT;
+	}
+	return ret;
+}
+
+static const struct file_operations sbrmi_fops = {
+	.owner		= THIS_MODULE,
+	.unlocked_ioctl	= sbrmi_ioctl,
+	.compat_ioctl	= sbrmi_ioctl,
+};
+
+int create_misc_rmi_device(struct sbrmi_data *data,
+			   struct device *dev)
+{
+	int ret;
+
+	data->sbrmi_misc_dev.name	= devm_kasprintf(dev,
+							 GFP_KERNEL,
+							 "sbrmi-%x",
+							 data->dev_static_addr);
+	data->sbrmi_misc_dev.minor	= MISC_DYNAMIC_MINOR;
+	data->sbrmi_misc_dev.fops	= &sbrmi_fops;
+	data->sbrmi_misc_dev.parent	= dev;
+	data->sbrmi_misc_dev.nodename	= devm_kasprintf(dev,
+							 GFP_KERNEL,
+							 "sbrmi-%x",
+							 data->dev_static_addr);
+	data->sbrmi_misc_dev.mode	= 0600;
+
+	ret = misc_register(&data->sbrmi_misc_dev);
+	if (ret)
+		return ret;
+
+	dev_info(dev, "register %s device\n", data->sbrmi_misc_dev.name);
+	return ret;
+}
diff --git a/drivers/misc/amd-sb/sbrmi-core.h b/drivers/misc/amd-sb/sbrmi-core.h
new file mode 100644
index 000000000000..acab439cd728
--- /dev/null
+++ b/drivers/misc/amd-sb/sbrmi-core.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2021-2024 Advanced Micro Devices, Inc.
+ */
+
+#ifndef _SBRMI_CORE__H_
+#define _SBRMI_CORE__H_
+
+/* SB-RMI registers */
+enum sbrmi_reg {
+	SBRMI_REV		= 0x00,
+	SBRMI_CTRL,
+	SBRMI_STATUS,
+	SBRMI_OUTBNDMSG0	= 0x30,
+	SBRMI_OUTBNDMSG1,
+	SBRMI_OUTBNDMSG2,
+	SBRMI_OUTBNDMSG3,
+	SBRMI_OUTBNDMSG4,
+	SBRMI_OUTBNDMSG5,
+	SBRMI_OUTBNDMSG6,
+	SBRMI_OUTBNDMSG7,
+	SBRMI_INBNDMSG0,
+	SBRMI_INBNDMSG1,
+	SBRMI_INBNDMSG2,
+	SBRMI_INBNDMSG3,
+	SBRMI_INBNDMSG4,
+	SBRMI_INBNDMSG5,
+	SBRMI_INBNDMSG6,
+	SBRMI_INBNDMSG7,
+	SBRMI_SW_INTERRUPT,
+	SBRMI_THREAD128CS	= 0x4b,
+};
+
+int create_misc_rmi_device(struct sbrmi_data *data,
+			   struct device *dev);
+#endif /*_SBRMI_CORE__H_*/
diff --git a/drivers/misc/amd-sb/sbrmi-i2c.c b/drivers/misc/amd-sb/sbrmi-i2c.c
index 539539c42754..f0499b0ef5e3 100644
--- a/drivers/misc/amd-sb/sbrmi-i2c.c
+++ b/drivers/misc/amd-sb/sbrmi-i2c.c
@@ -15,8 +15,9 @@
 #include <linux/of.h>
 #include <linux/regmap.h>
 #include <misc/amd-sb.h>
+#include "sbrmi-core.h"
 
-#define SBRMI_CTRL	0x1
+#define MAX_WAIT_TIME_SEC	(3)
 
 static int sbrmi_enable_alert(struct sbrmi_data *data)
 {
@@ -40,15 +41,15 @@ static int sbrmi_enable_alert(struct sbrmi_data *data)
 
 static int sbrmi_get_max_pwr_limit(struct sbrmi_data *data)
 {
-	struct sbrmi_mailbox_msg msg = { 0 };
+	struct apml_message msg = { 0 };
 	int ret;
 
 	msg.cmd = SBRMI_READ_PKG_MAX_PWR_LIMIT;
-	msg.read = true;
+	msg.data_in.reg_in[RD_FLAG_INDEX] = 1;
 	ret = rmi_mailbox_xfer(data, &msg);
 	if (ret < 0)
 		return ret;
-	data->pwr_limit_max = msg.data_out;
+	data->pwr_limit_max = msg.data_out.mb_out[RD_WR_DATA_INDEX];
 
 	return ret;
 }
@@ -67,6 +68,8 @@ static int sbrmi_i2c_probe(struct i2c_client *client)
 	if (!data)
 		return -ENOMEM;
 
+	atomic_set(&data->in_progress, 0);
+	atomic_set(&data->no_new_trans, 0);
 	mutex_init(&data->lock);
 
 	data->regmap = devm_regmap_init_i2c(client, &sbrmi_i2c_regmap_config);
@@ -83,7 +86,10 @@ static int sbrmi_i2c_probe(struct i2c_client *client)
 	if (ret < 0)
 		return ret;
 
+	data->dev_static_addr = client->addr;
+	init_completion(&data->misc_fops_done);
 	dev_set_drvdata(dev, (void *)data);
+
 	data->pdev = platform_device_register_data(dev, "sbrmi-hwmon",
 						   PLATFORM_DEVID_NONE,
 						   data,
@@ -92,6 +98,11 @@ static int sbrmi_i2c_probe(struct i2c_client *client)
 		pr_err("unable to register platform device for sbrmi-hwmon\n");
 		return PTR_ERR(data->pdev);
 	}
+
+	ret = create_misc_rmi_device(data, dev);
+	if (ret)
+		platform_device_unregister(data->pdev);
+
 	return ret;
 }
 
@@ -102,6 +113,26 @@ static void sbrmi_i2c_remove(struct i2c_client *client)
 	if (!data)
 		return;
 	platform_device_unregister(data->pdev);
+	/*
+	 * Set the no_new_trans so no new transaction can
+	 * occur in sbrmi_ioctl
+	 */
+	atomic_set(&data->no_new_trans, 1);
+	/*
+	 * If any transaction is in progress wait for the
+	 * transaction to get complete
+	 * Max wait is 3 sec for any pending transaction to
+	 * complete.
+	 */
+	if (atomic_read(&data->in_progress))
+		wait_for_completion_timeout(&data->misc_fops_done,
+					    MAX_WAIT_TIME_SEC * HZ);
+	misc_deregister(&data->sbrmi_misc_dev);
+	/* Assign fops and parent of misc dev to NULL */
+	data->sbrmi_misc_dev.fops = NULL;
+	data->sbrmi_misc_dev.parent = NULL;
+	dev_info(&client->dev, "Removed sbrmi driver\n");
+	return;
 }
 
 static const struct i2c_device_id sbrmi_id[] = {
diff --git a/include/misc/amd-sb.h b/include/misc/amd-sb.h
index 71abb3035f48..30585cb0f480 100644
--- a/include/misc/amd-sb.h
+++ b/include/misc/amd-sb.h
@@ -6,9 +6,11 @@
 #ifndef _AMD_SB_H_
 #define _AMD_SB_H_
 
+#include <linux/miscdevice.h>
 #include <linux/mutex.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
+#include <uapi/linux/amd-apml.h>
 /*
  * SB-RMI supports soft mailbox service request to MP1 (power management
  * firmware) through SBRMI inbound/outbound message registers.
@@ -21,25 +23,33 @@ enum sbrmi_msg_id {
 	SBRMI_READ_PKG_MAX_PWR_LIMIT,
 };
 
-/* Each client has this additional data */
+/*
+ * Each client has this additional data
+ * in_progress: set during any transaction, mailbox/cpuid/mcamsr/readreg,
+ * to indicate a transaction is in progress.
+ * no_new_trans: set in rmmod/unbind path to indicate,
+ * not to accept new transactions
+ */
 struct sbrmi_data {
+	struct completion misc_fops_done;
+	struct miscdevice sbrmi_misc_dev;
 	struct regmap *regmap;
+	/* Mutex locking */
 	struct mutex lock;
 	struct platform_device *pdev;
+	atomic_t in_progress;
+	atomic_t no_new_trans;
 	u32 pwr_limit_max;
+	u8 dev_static_addr;
+	u8 rev;
 } __packed;
 
-struct sbrmi_mailbox_msg {
-	u8 cmd;
-	bool read;
-	u32 data_in;
-	u32 data_out;
-};
-
 #if IS_ENABLED(CONFIG_AMD_SBRMI_I2C)
-int rmi_mailbox_xfer(struct sbrmi_data *data, struct sbrmi_mailbox_msg *msg);
+int rmi_mailbox_xfer(struct sbrmi_data *data,
+		     struct apml_message *msg);
 #else
-int rmi_mailbox_xfer(struct sbrmi_data *data, struct sbrmi_mailbox_msg *msg)
+int rmi_mailbox_xfer(struct sbrmi_data *data,
+		     struct apml_message *msg)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/include/uapi/linux/amd-apml.h b/include/uapi/linux/amd-apml.h
new file mode 100644
index 000000000000..11d34ee83b87
--- /dev/null
+++ b/include/uapi/linux/amd-apml.h
@@ -0,0 +1,74 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright (C) 2021-2024 Advanced Micro Devices, Inc.
+ */
+#ifndef _AMD_APML_H_
+#define _AMD_APML_H_
+
+#include <linux/types.h>
+
+enum apml_protocol {
+	APML_CPUID	= 0x1000,
+	APML_MCA_MSR,
+	APML_REG,
+};
+
+/* These are byte indexes into data_in and data_out arrays */
+#define RD_WR_DATA_INDEX	0
+#define REG_OFF_INDEX		0
+#define REG_VAL_INDEX		4
+#define THREAD_LOW_INDEX	4
+#define THREAD_HI_INDEX		5
+#define EXT_FUNC_INDEX		6
+#define RD_FLAG_INDEX		7
+
+#define MB_DATA_SIZE		4
+
+struct apml_message {
+	/* message ids:
+	 * Mailbox Messages:	0x0 ... 0x999
+	 * APML_CPUID:		0x1000
+	 * APML_MCA_MSR:	0x1001
+	 * APML_REG:		0x1002
+	 */
+	__u32 cmd;
+
+	/*
+	 * 8 bit data for reg read,
+	 * 32 bit data in case of mailbox,
+	 * up to 64 bit in case of cpuid and mca msr
+	 */
+	union {
+		__u64 cpu_msr_out;
+		__u32 mb_out[2];
+		__u8 reg_out[8];
+	} data_out;
+
+	/*
+	 * [0]...[3] mailbox 32bit input
+	 *	     cpuid & mca msr,
+	 *	     rmi rd/wr: reg_offset
+	 * [4][5] cpuid & mca msr: thread
+	 * [4] rmi reg wr: value
+	 * [6] cpuid: ext function & read eax/ebx or ecx/edx
+	 *	[7:0] -> bits [7:4] -> ext function &
+	 *	bit [0] read eax/ebx or ecx/edx
+	 * [7] read/write functionality
+	 */
+	union {
+		__u64 cpu_msr_in;
+		__u32 mb_in[2];
+		__u8 reg_in[8];
+	} data_in;
+	/*
+	 * Status code is returned in case of CPUID/MCA access
+	 * Error code is returned in case of soft mailbox
+	 */
+	__u32 fw_ret_code;
+} __attribute__((packed));
+
+/* ioctl command for mailbox msgs using generic _IOWR */
+#define SBRMI_BASE_IOCTL_NR      0xF9
+#define SBRMI_IOCTL_CMD          _IOWR(SBRMI_BASE_IOCTL_NR, 0, struct apml_message)
+
+#endif /*_AMD_APML_H_*/
-- 
2.25.1


