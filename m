Return-Path: <linux-kernel+bounces-254864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDDD9338A5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 10:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E999F1F22DC8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 08:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB963A1AC;
	Wed, 17 Jul 2024 08:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="V9t0I5Pk"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2045.outbound.protection.outlook.com [40.107.101.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C712E859;
	Wed, 17 Jul 2024 08:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721203860; cv=fail; b=UH3j7iDFzM2gfPs4hrCLXD3gTVV7ovw/700ym2Ywn3a/4DbTgm1IhfSbzJ2bsmgNuuNA0Q82/wuMGFLiEodzgYh7dLAUgoscsD3cmvJ9z+Dq5FLeL/YWZAjPaylzXjG0vn0ECWM4bD/kP3PTEq5VqTG2UUkUa5XnX6tDd5RD+I4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721203860; c=relaxed/simple;
	bh=sGt9Qs4F1MJhqdQHyyzsE8tmK+KWohya7fEfI/KfLUE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fPIEiHUOjN8Fqyyv6zS8PsPvnxOsawRQuWKg+WNOuOUXELJzAOIWIX5oge0XSkw9dHnCDcOI9Gy/YjkKBl24Ma5c3Gxv2D7yMws1ePmpblOpqIFB7uusv0ORDM4Jcw9Sf8MD1sC1HK7nlH5e0s86AEJ6coZiQ6FUyVcclMAKVVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=V9t0I5Pk; arc=fail smtp.client-ip=40.107.101.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=koiZMBiQybeT7N9wb+mb8pthzPV6AeChWGPht0hYJ/4qrtG6ES0WrGiX7ykZ3g4HeknidnEVz3uiBODWHxd13Rome0ai4Y/Paa00UNfLtY35RNVGesXE68v97ZO4MFGJh7wjqTOb7eX4+L31FYgoNbaLRdfm6mt5pr+k9KCb8etjXCHCe4yhhUAkfkTZ04/eLdX/1WEVjU/bY7sEXCrFVpaWkK+b0T5a+E3XxPyFLpA7Vynl1/F2KxlH+7qmFxl8tv4MJLSicsiSpXXb49ZjRxn1pqoL0eKqfbrNuhog5t0xSyqlL6ac6qhj6zL0b602u418qR2KMfN8+3V5MfArhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g+0CAJa4/f0IjI5cDCGnVtbvAVOV4aCme+9KYrsrpRc=;
 b=btE2hfZGd4nK1FMi4YPVNYVPQ6ey2fzkKvaTDVRFc6O/Io4tsf4PtK9JEmKTkkIzIUt0eKy/YW2BVtpmINKA+xZIbMMZRU9skSoAxl+Y1orC2Cxny9oUPPt2T6ikbJhpDnQfFN9Ptypzg0IGY9j+9ORXiO04F2GykIYsMNZS1NM06yvHqe8HmnRUtKdJhBtNcr92WwED177QZ8onXrqJPz+3OFSDbCJ8G//4KWRx8FMBK8gk5dcwaP4idFa5+mBAZVmqjeMUqtf998UMA2Rf7zdTAIjiee+qQRaOMyt7zrjHOKg9kvzk/kBBL1T54FEDrvdsrhgBQdL5/TXCey0mGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+0CAJa4/f0IjI5cDCGnVtbvAVOV4aCme+9KYrsrpRc=;
 b=V9t0I5PknjBcyYu2uMqI+6a23bxGDmTvjzhSD5td/RCJy8s/l5llX2Rep3oTwwQIce0C+kJhcLsd6mBvFsf4IDrXcdwldUCmlHVKS3FxYeAS5aYngzhFHoEjU0PfnGdzqK3bkyjXbiOlDJ/8HiyaLLgfc5G+ujWalXDDxE7gxPM=
Received: from DS7PR03CA0213.namprd03.prod.outlook.com (2603:10b6:5:3ba::8) by
 LV8PR12MB9231.namprd12.prod.outlook.com (2603:10b6:408:192::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 17 Jul
 2024 08:10:55 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:5:3ba:cafe::3d) by DS7PR03CA0213.outlook.office365.com
 (2603:10b6:5:3ba::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16 via Frontend
 Transport; Wed, 17 Jul 2024 08:10:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Wed, 17 Jul 2024 08:10:55 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 03:10:52 -0500
From: Akshay Gupta <akshay.gupta@amd.com>
To: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux@roeck-us.net>, <gregkh@linuxfoundation.org>, <arnd@arndb.de>,
	<naveenkrishna.chatradhi@amd.com>, Akshay Gupta <akshay.gupta@amd.com>
Subject: [PATCH v2 2/8] misc: amd-sbi: Use regmap subsystem
Date: Wed, 17 Jul 2024 08:10:21 +0000
Message-ID: <20240717081027.2079549-3-akshay.gupta@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240717081027.2079549-1-akshay.gupta@amd.com>
References: <20240717081027.2079549-1-akshay.gupta@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|LV8PR12MB9231:EE_
X-MS-Office365-Filtering-Correlation-Id: 91c10964-d678-433f-4b99-08dca637fbae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rw6/pM7gq94eOrK4U9vFb+gOTXJhoktGzAzHl1zK2G51pepnlNTVSewMIr1c?=
 =?us-ascii?Q?fk8Jlnh+zmNnHmYSNoDcwNmdPgakNOe80F+nnTX3UMahSPqCi/wrIOCIQtb+?=
 =?us-ascii?Q?L7nEJNyu3Wyz3Go8/VaemXJLYySfKEGiRuKJgE5GqGR9WORg2sgvelOvgovN?=
 =?us-ascii?Q?YQqQGHhBNABRWCGbBRjXm99ktRo95PQQghncrBMiV+z/UC1ANvb+pICRtAH3?=
 =?us-ascii?Q?MPg5Gt7aRQACSKZYvuZMBNH3zHEXJ023cQ+7Ei4XI202Yu9x8t6FwBvoVbRB?=
 =?us-ascii?Q?555YJhxwkkGThYOrr86SkVliVmPDtNl1abJllpjtyD90f1tFA84IwzNsKHs8?=
 =?us-ascii?Q?gFDbi04DakEb8I96ENGbI/Re4y71PnFSKZKvN82n9fM/+JqRn/eWlXnuTr4F?=
 =?us-ascii?Q?BPY4c+UwCdnnumScXFvdehVECIw8Jb6DRpvX1S24ovEUGiU1Uw23LUXNEnvT?=
 =?us-ascii?Q?ZJwao9ZKzxLVBXorLL2jXtmO5xEH3+dl1jgIInlUdtWqT8OKq1ABeCX4L0hZ?=
 =?us-ascii?Q?rghkRQsCP8Icg9kjEbGgAxfBX4lZ7Lb0zcttTRa92Tf5UkXkb+u7MJ8C/Nfc?=
 =?us-ascii?Q?Ph4z6txzmlNjbrxrttYoWJ7/RBMsKZQIB/L9Zb6R5IYBYNtveXlFe8n7cZo6?=
 =?us-ascii?Q?BF1aprC8aFUMVYId1Lf0YV5v4uz5El+SXdpwjuu6XxN8iyPUoTyk2jltsvdE?=
 =?us-ascii?Q?iaeSGSp/vvRXssTXMs43nMMh6pOyDTp9D/Yd2GPp1W83NHzKVen+EW+DtJAt?=
 =?us-ascii?Q?SJJ1rMd+N3JI/HuiA6hz0QjzXzZeoGSVOlqJ6BXyAB5Qm2w8eueUaFy+Z9v8?=
 =?us-ascii?Q?7eWyG6fwsmktzBR/G6toiNuDeBSP+kGQd2EJb5roIzK7tDyrjw/Zng5C3njN?=
 =?us-ascii?Q?JiBR5mm0NdFUcRNe9f/BMBtMUtBf/486oebu6yq8KcSRCG2Lp77OQhynhjlD?=
 =?us-ascii?Q?hK9f4fymd8zNeiV5IeKT+RFp6V3qRwfXYu5l9+T2c3T+iybBusFrn094BIYM?=
 =?us-ascii?Q?kLvQa371tt6Z5x5AmiZbsTltPtQ0u/TjyGzVfGqHU2Sl9Xezw+2IeT3RyjzG?=
 =?us-ascii?Q?W3P7qnfBWgx//W55Ky1/WpghokZKYaXg7I3gWcuyTb+qhKRg2yYa9GowGnK4?=
 =?us-ascii?Q?06w+dH0l5n9+ARrq9PThLC2DFsRGoqqWEjCOgdivAW7mI0rkYVwDZ1Qe/vdd?=
 =?us-ascii?Q?vlEEzennBbyOcEcb/aJWXz22BPlYu9pNbd9EzBEow7RcWFpbkwUxNQRZHk4M?=
 =?us-ascii?Q?M+PwlZfB8GzhIk2yW3nA8xIxbbdgMZnbEWFZ4GKied3hwFZK3p3q93HsBveO?=
 =?us-ascii?Q?ltMS3aoGH0TpCpsWywxJTr5dyhbEHwR7i065RjOXM0h31O54L5AIdOa9jA4l?=
 =?us-ascii?Q?pvzlbKm4r189Fj18QOJ8mhOXppyAcE1r6ZHgiHMibqTk6hZPuf1G/uoequTD?=
 =?us-ascii?Q?NeCaPdhIt+tcj0QJ5XdU/H412366Nzqf?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 08:10:55.4746
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91c10964-d678-433f-4b99-08dca637fbae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9231

- regmap subsystem provides multiple benefits over direct smbus APIs
- The susbsytem can be helpful in following cases
  - Differnet types of bus (i2c/i3c), we have plans to support i3c.
  - Different Register address size (1byte/2byte)

Signed-off-by: Akshay Gupta <akshay.gupta@amd.com>
Reviewed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
---
Changes since v1:
- Previously patch 3
- Remove "__packed" from data structure

 drivers/misc/amd-sbi/rmi-core.c | 29 ++++++++++++-----------------
 drivers/misc/amd-sbi/rmi-core.h |  3 ++-
 drivers/misc/amd-sbi/rmi-i2c.c  | 25 ++++++++++++++++---------
 3 files changed, 30 insertions(+), 27 deletions(-)

diff --git a/drivers/misc/amd-sbi/rmi-core.c b/drivers/misc/amd-sbi/rmi-core.c
index 5d93fb703fa0..5a0b7912cc4e 100644
--- a/drivers/misc/amd-sbi/rmi-core.c
+++ b/drivers/misc/amd-sbi/rmi-core.c
@@ -9,6 +9,7 @@
 #include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/mutex.h>
+#include <linux/regmap.h>
 #include "rmi-core.h"
 
 /* Mask for Status Register bit[1] */
@@ -23,6 +24,7 @@
 int rmi_mailbox_xfer(struct sbrmi_data *data,
 		     struct sbrmi_mailbox_msg *msg)
 {
+	unsigned int bytes;
 	int i, ret, retry = 10;
 	int sw_status;
 	u8 byte;
@@ -30,14 +32,12 @@ int rmi_mailbox_xfer(struct sbrmi_data *data,
 	mutex_lock(&data->lock);
 
 	/* Indicate firmware a command is to be serviced */
-	ret = i2c_smbus_write_byte_data(data->client,
-					SBRMI_INBNDMSG7, START_CMD);
+	ret = regmap_write(data->regmap, SBRMI_INBNDMSG7, START_CMD);
 	if (ret < 0)
 		goto exit_unlock;
 
 	/* Write the command to SBRMI::InBndMsg_inst0 */
-	ret = i2c_smbus_write_byte_data(data->client,
-					SBRMI_INBNDMSG0, msg->cmd);
+	ret = regmap_write(data->regmap, SBRMI_INBNDMSG0, msg->cmd);
 	if (ret < 0)
 		goto exit_unlock;
 
@@ -48,8 +48,7 @@ int rmi_mailbox_xfer(struct sbrmi_data *data,
 	 */
 	for (i = 0; i < 4; i++) {
 		byte = (msg->data_in >> i * 8) & 0xff;
-		ret = i2c_smbus_write_byte_data(data->client,
-						SBRMI_INBNDMSG1 + i, byte);
+		ret = regmap_write(data->regmap, SBRMI_INBNDMSG1 + i, byte);
 		if (ret < 0)
 			goto exit_unlock;
 	}
@@ -58,8 +57,7 @@ int rmi_mailbox_xfer(struct sbrmi_data *data,
 	 * Write 0x01 to SBRMI::SoftwareInterrupt to notify firmware to
 	 * perform the requested read or write command
 	 */
-	ret = i2c_smbus_write_byte_data(data->client,
-					SBRMI_SW_INTERRUPT, TRIGGER_MAILBOX);
+	ret = regmap_write(data->regmap, SBRMI_SW_INTERRUPT, TRIGGER_MAILBOX);
 	if (ret < 0)
 		goto exit_unlock;
 
@@ -69,8 +67,7 @@ int rmi_mailbox_xfer(struct sbrmi_data *data,
 	 * of the requested command
 	 */
 	do {
-		sw_status = i2c_smbus_read_byte_data(data->client,
-						     SBRMI_STATUS);
+		ret = regmap_read(data->regmap, SBRMI_STATUS, &sw_status);
 		if (sw_status < 0) {
 			ret = sw_status;
 			goto exit_unlock;
@@ -81,8 +78,6 @@ int rmi_mailbox_xfer(struct sbrmi_data *data,
 	} while (retry--);
 
 	if (retry < 0) {
-		dev_err(&data->client->dev,
-			"Firmware fail to indicate command completion\n");
 		ret = -EIO;
 		goto exit_unlock;
 	}
@@ -94,11 +89,11 @@ int rmi_mailbox_xfer(struct sbrmi_data *data,
 	 */
 	if (msg->read) {
 		for (i = 0; i < 4; i++) {
-			ret = i2c_smbus_read_byte_data(data->client,
-						       SBRMI_OUTBNDMSG1 + i);
+			ret = regmap_read(data->regmap,
+					  SBRMI_OUTBNDMSG1 + i, &bytes);
 			if (ret < 0)
 				goto exit_unlock;
-			msg->data_out |= ret << i * 8;
+			msg->data_out |= bytes << i * 8;
 		}
 	}
 
@@ -106,8 +101,8 @@ int rmi_mailbox_xfer(struct sbrmi_data *data,
 	 * BMC must write 1'b1 to SBRMI::Status[SwAlertSts] to clear the
 	 * ALERT to initiator
 	 */
-	ret = i2c_smbus_write_byte_data(data->client, SBRMI_STATUS,
-					sw_status | SW_ALERT_MASK);
+	ret = regmap_write(data->regmap, SBRMI_STATUS,
+			   sw_status | SW_ALERT_MASK);
 
 exit_unlock:
 	mutex_unlock(&data->lock);
diff --git a/drivers/misc/amd-sbi/rmi-core.h b/drivers/misc/amd-sbi/rmi-core.h
index 3d600e450e08..24a6957c8fa0 100644
--- a/drivers/misc/amd-sbi/rmi-core.h
+++ b/drivers/misc/amd-sbi/rmi-core.h
@@ -9,6 +9,7 @@
 #include <linux/mutex.h>
 #include <linux/i2c.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 
 /* SB-RMI registers */
 enum sbrmi_reg {
@@ -47,7 +48,7 @@ enum sbrmi_msg_id {
 
 /* Each client has this additional data */
 struct sbrmi_data {
-	struct i2c_client *client;
+	struct regmap *regmap;
 	struct mutex lock;
 	struct platform_device *pdev;
 	u32 pwr_limit_max;
diff --git a/drivers/misc/amd-sbi/rmi-i2c.c b/drivers/misc/amd-sbi/rmi-i2c.c
index ae968cf3c29c..c4207672d1e4 100644
--- a/drivers/misc/amd-sbi/rmi-i2c.c
+++ b/drivers/misc/amd-sbi/rmi-i2c.c
@@ -13,26 +13,26 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
+#include <linux/regmap.h>
 #include "rmi-core.h"
 
 #define SBRMI_CTRL	0x1
 
-static int sbrmi_enable_alert(struct i2c_client *client)
+static int sbrmi_enable_alert(struct sbrmi_data *data)
 {
-	int ctrl;
+	int ctrl, ret;
 
 	/*
 	 * Enable the SB-RMI Software alert status
 	 * by writing 0 to bit 4 of Control register(0x1)
 	 */
-	ctrl = i2c_smbus_read_byte_data(client, SBRMI_CTRL);
-	if (ctrl < 0)
-		return ctrl;
+	ret = regmap_read(data->regmap, SBRMI_CTRL, &ctrl);
+	if (ret < 0)
+		return ret;
 
 	if (ctrl & 0x10) {
 		ctrl &= ~0x10;
-		return i2c_smbus_write_byte_data(client,
-						 SBRMI_CTRL, ctrl);
+		return regmap_write(data->regmap, SBRMI_CTRL, ctrl);
 	}
 
 	return 0;
@@ -57,17 +57,24 @@ static int sbrmi_i2c_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
 	struct sbrmi_data *data;
+	struct regmap_config sbrmi_i2c_regmap_config = {
+		.reg_bits = 8,
+		.val_bits = 8,
+	};
 	int ret;
 
 	data = devm_kzalloc(dev, sizeof(struct sbrmi_data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-	data->client = client;
 	mutex_init(&data->lock);
 
+	data->regmap = devm_regmap_init_i2c(client, &sbrmi_i2c_regmap_config);
+	if (IS_ERR(data->regmap))
+		return PTR_ERR(data->regmap);
+
 	/* Enable alert for SB-RMI sequence */
-	ret = sbrmi_enable_alert(client);
+	ret = sbrmi_enable_alert(data);
 	if (ret < 0)
 		return ret;
 
-- 
2.44.0


