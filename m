Return-Path: <linux-kernel+bounces-541471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E03AAA4BD3C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 12:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D34E11896385
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 11:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75481F4623;
	Mon,  3 Mar 2025 10:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="W2RO2UxE"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2067.outbound.protection.outlook.com [40.107.100.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4501F417E;
	Mon,  3 Mar 2025 10:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740999586; cv=fail; b=WKbrmTozki3csfqpSHArYzlY8EkcfQgiVyl3nOk5PNa95uZ4vF6wfh23QlU6f2SWCw+mJD+loXxdHTUa9lNOzLuqCVKLA2UYQ7QVq71mFg2twDq56i9Ta+6ZOoc0OOPYTqm0oAnyOd7ml5bw1mwMBP8zwnJgEeXsJyv/pc+021Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740999586; c=relaxed/simple;
	bh=fh+uhEeUGrjJhdvGkAo65eRfKeCy3t5xL7Tvx1TUDk0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EwG/UAYJT4FEyEqF6jI+pzp3FsgS8RBhXK9TjKfeasNud2wWQotVXF7Ov9S6zn16wgL2M47Hzd4qvduL2ev4toFAKrDFnm3Egx9QPHLKaBPql2dcV8z/b1k29IpXJMiLB7VsuRjMcJ0uMS93zz0NX9L6CTvfLJQASmtks9ho2Ek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=W2RO2UxE; arc=fail smtp.client-ip=40.107.100.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MGlfqlEwYqpgyTBndCGj7kBWy8aftgPec8knUvaDJwEDcMhHcFY0jl9IYFLU4dLa34KpyQ2wPYcFAKH4YIkxRcYbmDkNRrjnDzmWQvorYe7Yvbfue/YKYLhRNRFS+i9mKE4pNTFGwefF8duigA0YlkN4qweO5XQCV4Gqk6ojGnNrN51hft8r5BqKryMtV0aS/wwEjdPgS5UZ2i8AWIAsAkQIFzg1HQPAzuHiQ+3outBixpCfisq7D4nApA+nvS8KHQf2V09XlEj142RvYYBOBnH3weKAd3dLXGI3TCaeP3ey3mwpviMiuCalzVBCvB77JkFtG6vRHYh/NnnsqSNtmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fWpAIKJib9evUvF3ZT1qq4ZIooQ7/lcpgzwS9JjO6ec=;
 b=cpvA2X056IuIxlBcJjMhV6gHR5l3C8VxCuLqNpsutFQNc3w5gE3KEcs+LeOYsD/MuYIuJMqYQlDsyWyz+bA7NgHt+hDQ+woISjb9ZxsMaEYDE/6QvdWlg0pDQlBvPaFpydQW8wqfr5GCzB761WYQnrvQVl65nIADQnWNetgSjWaIIY675PDhrMDbxxLW01h6+UR5KVMC5HeDgcXa7y4+W1OCIJCaP5yQEEpHQH2+gmfj7zJcdngNNChfvzFcNffiXEKqTZP7O037CDEwtOmxhfec6oJUGVoOkxymUmi07PvQwgO/ivi4MJoX8/7m8JM2XDDqDcU9hgdHMGrKcWBB1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fWpAIKJib9evUvF3ZT1qq4ZIooQ7/lcpgzwS9JjO6ec=;
 b=W2RO2UxErWOFKQTfDN3Y6Yw8KN6CE7XAZ4aKN/HgbCOQMtLp+0LIJBlr0Rlva3p+9yUbW9ZhSgaUVfzWqCQntuJVCdtb867f46URbaVBwf8LE8WKKvsu81TxkZgynM/vrXMC+EEEinJoOIVRtwZqlvyzcQiKPGFwsiP6MhtVjQQ=
Received: from SN6PR08CA0030.namprd08.prod.outlook.com (2603:10b6:805:66::43)
 by BL1PR12MB5708.namprd12.prod.outlook.com (2603:10b6:208:387::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 10:59:41 +0000
Received: from SN1PEPF00036F42.namprd05.prod.outlook.com
 (2603:10b6:805:66:cafe::60) by SN6PR08CA0030.outlook.office365.com
 (2603:10b6:805:66::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.28 via Frontend Transport; Mon,
 3 Mar 2025 10:59:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F42.mail.protection.outlook.com (10.167.248.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Mon, 3 Mar 2025 10:59:40 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Mar
 2025 04:59:37 -0600
From: Akshay Gupta <akshay.gupta@amd.com>
To: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux@roeck-us.net>, <gregkh@linuxfoundation.org>, <arnd@arndb.de>,
	<shyam-sundar.s-k@amd.com>, <gautham.shenoy@amd.com>,
	<mario.limonciello@amd.com>, <naveenkrishna.chatradhi@amd.com>, Akshay Gupta
	<akshay.gupta@amd.com>
Subject: [PATCH v5 04/11] misc: amd-sbi: Use regmap subsystem
Date: Mon, 3 Mar 2025 10:58:55 +0000
Message-ID: <20250303105902.215009-5-akshay.gupta@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F42:EE_|BL1PR12MB5708:EE_
X-MS-Office365-Filtering-Correlation-Id: 26c96758-24db-40c8-7113-08dd5a427f62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Lp4WH8NIdNKcfum3GLsyDEye7bTC9WHq28d5bf8FFuvsizOPRLJzNECAj135?=
 =?us-ascii?Q?9gqIaESuSda1ucEw15y+lx+u2m0zZcBbfnKDJEyiYQshYRhhAGob1tlrNYDh?=
 =?us-ascii?Q?cxeLSCnv+PJQFaZ+nX1QGXJJZFFH1e6D6r3U6NQ0KdAYz1WxBTKEZNPpYhS0?=
 =?us-ascii?Q?ehKRgMi8YTDlPxEOyqGO/fTF7FfNhEghdg4yE0vuhoxDh12VWDkvbASK5ick?=
 =?us-ascii?Q?0s0qQRn0ED4+wfmGfjoc7fN+lyKSQUj3GSfB48FHw0b8xK/hSIZTFM3YQ/hO?=
 =?us-ascii?Q?aufdCZjGRJ7zIXaVoP4+x1LKLWTP4cr1gX8IowF5mahOBRSKR+G8yMg0+KS8?=
 =?us-ascii?Q?W+YauKxPH/Do4JipjO0za3A0xWVS8HNWYGi5WnRz9DePo3NAbPmwfgyVIN+e?=
 =?us-ascii?Q?wDHthyxQGHYqUZyPx6KAjbUxPSqzSvStfmKeewy1rCmYUB8oboWP927HQB4f?=
 =?us-ascii?Q?P7a31WE8KxwqZL9MOXgb1nLJo5rsEYUgbIhZfzhepm7cKARkjBfK5UzycGPt?=
 =?us-ascii?Q?xrkezD74sOFaP9JVV4LT8YNYAU9qfwip/R+cbBuRPFvG+ga9tHJ0Fqrg76Fn?=
 =?us-ascii?Q?zA7M89EXfExpj5x9LYdS55TcguRWMdDznlfG9btcya9g92zGAO+O+5FGmSTf?=
 =?us-ascii?Q?0MmckQoBjJcjt6jfCPMv3PskjxCsvgQr0vGUFq3jJeIhr/hIvrdqqjEXmnoi?=
 =?us-ascii?Q?+0VZ6PQofTfSnDT6scv6iGUgVeXFxTgSet2wGNPoCP6mYkXOJNSJ+zzITIrs?=
 =?us-ascii?Q?Zrr1XG44Plr7NOPRzfzRXwnms3fDwaDSJcxAq+B5jMQr/sZzVasxcNpoL7K4?=
 =?us-ascii?Q?GvrmIiyrO8+4sUUMNeHD3nNB68gQRucfHk0el0B2Z+sTVwL06JFmqFQeqq6Z?=
 =?us-ascii?Q?+dAsMf1mCJV3RJ5OyM1b6fc0lPDdeARnAWIqJcZvoTNxQaQVVG0oyVjyAo/K?=
 =?us-ascii?Q?aTLYkAkw1FDrwOCbVYK+nSy3YcNVe1a1Ati00KvgqV1L/U1BDId2I+Bk+VQm?=
 =?us-ascii?Q?u7apeQOUCWCz2bUTyzIJUrOyTWWsWnTC1/oJgZenER63xR48Obm8B3vRg/hL?=
 =?us-ascii?Q?jknuoBLTPlN2ADqsIc243fyJIx2dIOSeFApXSJz6sEov6tc1ulOj+2qgWXYU?=
 =?us-ascii?Q?C0mP55Nc07xdYsmtP/S46S7QrCAYTuoVHhXatJEiVSJNrhLoNJ3EYVaqMp54?=
 =?us-ascii?Q?ZVrd6JKyMP1vbg7T/6yqv2jj0TMrQCjgxpO5YQZuGd6r1xRUMP0ntgEDfQCe?=
 =?us-ascii?Q?FOsA2fyPK5qnE8DCA4pb+d9sXe6C964bCmicOaCSAMrfuBxpG6NbZ2sZZ9nu?=
 =?us-ascii?Q?JghT9as1fTV2FLufPQyNnjr9/Ba2cDQr7DM0eDWSMg4r+vQjQmKXA5xYEyBy?=
 =?us-ascii?Q?17b4tATwVO+Ew7Xxagl0UHzcee530k1eGSIQqI76GhrEM5HCi0BdKQuis1se?=
 =?us-ascii?Q?aPKizfidC+kDbAYrVUZXMTyeaNAcNoa4COkPSrEVV5XfKxZyMXkD6abTZKcB?=
 =?us-ascii?Q?5rxlFeyjqWNhrzo=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 10:59:40.7040
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26c96758-24db-40c8-7113-08dd5a427f62
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F42.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5708

- regmap subsystem provides multiple benefits over direct smbus APIs
- subsystem adds another abstraction layer on top of struct i2c_client to
  make it easy to read or write registers.
- The subsystem can be helpful in following cases
  - Different types of bus (i2c/i3c), we have plans to support i3c.
  - Different Register address size (1byte/2byte)

Reviewed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Signed-off-by: Akshay Gupta <akshay.gupta@amd.com>
---
Changes since v4:
- Previously patch 2
Changes since v1:
- Previously patch 3
- Remove "__packed" from data structure

 drivers/misc/amd-sbi/rmi-core.c | 29 ++++++++++++-----------------
 drivers/misc/amd-sbi/rmi-core.h |  3 ++-
 drivers/misc/amd-sbi/rmi-i2c.c  | 25 ++++++++++++++++---------
 3 files changed, 30 insertions(+), 27 deletions(-)

diff --git a/drivers/misc/amd-sbi/rmi-core.c b/drivers/misc/amd-sbi/rmi-core.c
index 74456756270c..663ab9176d95 100644
--- a/drivers/misc/amd-sbi/rmi-core.c
+++ b/drivers/misc/amd-sbi/rmi-core.c
@@ -9,6 +9,7 @@
 #include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/mutex.h>
+#include <linux/regmap.h>
 #include "rmi-core.h"
 
 /* Mask for Status Register bit[1] */
@@ -21,6 +22,7 @@
 int rmi_mailbox_xfer(struct sbrmi_data *data,
 		     struct sbrmi_mailbox_msg *msg)
 {
+	unsigned int bytes;
 	int i, ret, retry = 10;
 	int sw_status;
 	u8 byte;
@@ -28,14 +30,12 @@ int rmi_mailbox_xfer(struct sbrmi_data *data,
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
 
@@ -46,8 +46,7 @@ int rmi_mailbox_xfer(struct sbrmi_data *data,
 	 */
 	for (i = 0; i < 4; i++) {
 		byte = (msg->data_in >> i * 8) & 0xff;
-		ret = i2c_smbus_write_byte_data(data->client,
-						SBRMI_INBNDMSG1 + i, byte);
+		ret = regmap_write(data->regmap, SBRMI_INBNDMSG1 + i, byte);
 		if (ret < 0)
 			goto exit_unlock;
 	}
@@ -56,8 +55,7 @@ int rmi_mailbox_xfer(struct sbrmi_data *data,
 	 * Write 0x01 to SBRMI::SoftwareInterrupt to notify firmware to
 	 * perform the requested read or write command
 	 */
-	ret = i2c_smbus_write_byte_data(data->client,
-					SBRMI_SW_INTERRUPT, TRIGGER_MAILBOX);
+	ret = regmap_write(data->regmap, SBRMI_SW_INTERRUPT, TRIGGER_MAILBOX);
 	if (ret < 0)
 		goto exit_unlock;
 
@@ -67,8 +65,7 @@ int rmi_mailbox_xfer(struct sbrmi_data *data,
 	 * of the requested command
 	 */
 	do {
-		sw_status = i2c_smbus_read_byte_data(data->client,
-						     SBRMI_STATUS);
+		ret = regmap_read(data->regmap, SBRMI_STATUS, &sw_status);
 		if (sw_status < 0) {
 			ret = sw_status;
 			goto exit_unlock;
@@ -79,8 +76,6 @@ int rmi_mailbox_xfer(struct sbrmi_data *data,
 	} while (retry--);
 
 	if (retry < 0) {
-		dev_err(&data->client->dev,
-			"Firmware fail to indicate command completion\n");
 		ret = -EIO;
 		goto exit_unlock;
 	}
@@ -92,11 +87,11 @@ int rmi_mailbox_xfer(struct sbrmi_data *data,
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
 
@@ -104,8 +99,8 @@ int rmi_mailbox_xfer(struct sbrmi_data *data,
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
index 27165d3bb20f..bbb6bb1cefde 100644
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
 	u32 pwr_limit_max;
 };
diff --git a/drivers/misc/amd-sbi/rmi-i2c.c b/drivers/misc/amd-sbi/rmi-i2c.c
index 9ad4c8093399..7a9801273a4c 100644
--- a/drivers/misc/amd-sbi/rmi-i2c.c
+++ b/drivers/misc/amd-sbi/rmi-i2c.c
@@ -13,24 +13,24 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
+#include <linux/regmap.h>
 #include "rmi-core.h"
 
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
@@ -55,17 +55,24 @@ static int sbrmi_i2c_probe(struct i2c_client *client)
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
2.25.1


