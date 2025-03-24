Return-Path: <linux-kernel+bounces-573884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7639A6DD9E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 16:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70FE93B56BF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93047261394;
	Mon, 24 Mar 2025 14:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Xw9PjaLs"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2047.outbound.protection.outlook.com [40.107.95.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CE8261573;
	Mon, 24 Mar 2025 14:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742828336; cv=fail; b=aODWlC5UYNCk6QI5xDhbLzAX8G89Q++eFO9MUaeKGwq5jb34YVJfvxUvGq6flniNnSDf9z2mQrW+kBNwqd2LPMrO5rlVqCHtCum6hkGt6GHLFrhmE9KVNnWbW708IfjOaoymPjCigSAi+ggePfudDFZMWKgFQ6jyXhDggIjI5UU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742828336; c=relaxed/simple;
	bh=fh+uhEeUGrjJhdvGkAo65eRfKeCy3t5xL7Tvx1TUDk0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KJ5Bpwk5bkMIUt1DfqJwt1ZHJKtKA0Si8UbeHAsH+Rtx5B3cIEIBX70RgrpUOXY/AtwnFcvI8fA8AnvhnBmIao5DDw/ypTaNXXs+YO0TdiYctsV4l9kk1iwMvv3O9+lMO15ysh0cZoTFJypiCiNukUJ0/r8CZ2FQb8xZRme8BKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Xw9PjaLs; arc=fail smtp.client-ip=40.107.95.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O/rjYMNCpLW3DBeJvF9eD7dBrkL5QjjnJh8nNrKPDNj5RAkvWgrn5DIQ7QEIxN6iD/vEYxQEkFnWGpCqjMcpe7z8Do1yb8hoCULp3L7ZUBRQFRjG6P8OcugNqfKuWgwZUCkyBuCTK0nZ4xgq8H567h5Rp9U6X+DiSn83HwJum8K9UIrJBgRSr3v/NLbYdXSwDK6CqMZM0YRfDOXd+pCcp+1HtI3JW9VdQiHpEsqkLlL6WBFy+FRt+llwuDOW0qkPTtU0BWiIYX3gb0rxS/IIdFwnOaNbWAlbbjIrLMIVScTyE4lVtmupJGm+XecrovkOUOkqK2s5dN8T/4FMuwUrcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fWpAIKJib9evUvF3ZT1qq4ZIooQ7/lcpgzwS9JjO6ec=;
 b=N9o0dyXoFRosF4bP2kzBWAEdualZvXgZWqGzp899s8aDg1y2ixXs9LWRY0F6fb2Nb6eNYBnvmJMaTTYnUJlUZ0rBlU/oQ8V3j0nMz+g+g9MYyh7OjBpTdkeeo+BPKGU41OQiIOZMFCFJs2JlnfiAO0t1SjEY+EGEco2pu+WJZU2bJtBLarxLh850oJaGSDsyLlNoqiNNkFAe8Okv4Tnt4hei6HyeMNfEzrfIPnQkPNsLrIFIZcdlSRNtw1QQ9gbUkugIukbixgAjWmo5UFSF1QyVZJbx6x4i2F2USxg422OomDSkE1DZpLyEvBVyz+p7qEm98X3kIP3Ylxq8JXpeJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fWpAIKJib9evUvF3ZT1qq4ZIooQ7/lcpgzwS9JjO6ec=;
 b=Xw9PjaLsPA9aYPwzTU2GsQNGXTVV8enFGo1qLA0p5kZRbNrr6+7s49C1fhTc15VLod8cIUONZJ7/2RW4J5X4wU1NPblPm+fR5qyHJFCTl8NGDGTOsGq1dloWQC4hfdCGNoc/IStadJdjdabDgScrjMyrVqiqDqeZMwhn+ZerhGI=
Received: from PH7P221CA0055.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::27)
 by DM6PR12MB4076.namprd12.prod.outlook.com (2603:10b6:5:213::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 14:58:52 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:510:33c:cafe::c0) by PH7P221CA0055.outlook.office365.com
 (2603:10b6:510:33c::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.40 via Frontend Transport; Mon,
 24 Mar 2025 14:58:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 24 Mar 2025 14:58:51 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Mar
 2025 09:58:47 -0500
From: Akshay Gupta <akshay.gupta@amd.com>
To: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux@roeck-us.net>, <gregkh@linuxfoundation.org>, <arnd@arndb.de>,
	<shyam-sundar.s-k@amd.com>, <gautham.shenoy@amd.com>,
	<mario.limonciello@amd.com>, <naveenkrishna.chatradhi@amd.com>,
	<anand.umarji@amd.com>, Akshay Gupta <akshay.gupta@amd.com>
Subject: [PATCH v6 04/11] misc: amd-sbi: Use regmap subsystem
Date: Mon, 24 Mar 2025 14:58:08 +0000
Message-ID: <20250324145815.1026314-5-akshay.gupta@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|DM6PR12MB4076:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cc1ea5c-227a-485e-66cc-08dd6ae463d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uOThUTTZcA9E3YPF7kcARgGhzGnV48cd4M4ZIci+CdmR9FbnGrQ1B61g4nMm?=
 =?us-ascii?Q?2R5q0SIN2KcEKDKg1YXoqZT50W/q51VjL2mpl/BRYyggQ4IE5fVYC7IDaWKy?=
 =?us-ascii?Q?BoZnywaivLhuDRR/HE683f3rAH65AE7EoIX0Oj59UGiaXCszIatycvAyOCsl?=
 =?us-ascii?Q?37wTAlHsQLCEht3wBOLhhUKJqFXG7W22WWCZRn4wTkA2gWFlrnlcCtoEEce3?=
 =?us-ascii?Q?b+h02zeSspG6jNLs2ln/pVQYHVqOkEwR7beslbmXea0eDqjF3gv30RNqTdjZ?=
 =?us-ascii?Q?ZPa0IJfi3qKQcEuq3NT2gHCsmNxfLO+fM9Br36F/8OnbIOcd77zi4Vyd/Pe0?=
 =?us-ascii?Q?rY8Sm8KnDwQYlfgfwfr/3Fk+lZrETyYOm35NtAhS55Ed51dXqlVvlSwHW6IC?=
 =?us-ascii?Q?HU1tbLziAFWB6bW5bJhgMyFMYzhp017n2Qg07VTvJfn2iveBXOTyO1rJsk8V?=
 =?us-ascii?Q?9xIo49N14x+NAi0WEtqrFxFzuNq7h4VE6UHmEi7KyjGzf/NnfwhYOigDMZnd?=
 =?us-ascii?Q?2Xtl6fdVD3EAuG2gJhZnPUxKwt6n6EOiLDwX8NDmVBwWutSbUrYNaRSDWvUH?=
 =?us-ascii?Q?xi58WEW8zvhXDzNvwzXsPcVj04yqITCdWCKVgTOsE+TkYah/QYzBjwqHEWwA?=
 =?us-ascii?Q?E2DPil5CI+yHinFSG1EsC3O2Ukn3HIMbmVqdn8DQLJV3OA0Bb5+bzGbbEWPC?=
 =?us-ascii?Q?ikKxVU2QWG9ye71MfFVJhMLrroOEIoxbL6bPG00/Ct1yxYFNJvcOZoV6H8tC?=
 =?us-ascii?Q?pc3UEToFWa+tfwcYPXJDDDfcXTNrsE+8kYMjHQPcSykVzoCkPW4ptK6mEM9U?=
 =?us-ascii?Q?tmZLKVtxNFQmVQa/NKSLGctgCyu0q1KGap8EfDcAB2kmWyd1p6ZjMsRVrjWs?=
 =?us-ascii?Q?xQmqnhMM6a9CG9+dcugGugAh3p5TrBtU1D4mEmf8CRXl0O7WVTkL9yxdMqDr?=
 =?us-ascii?Q?J/BbCi3yIjsqvl3S1aa9fWfG7aJ39Yb1M8Vckpd3/I+uZbEar8qfkmgDs+De?=
 =?us-ascii?Q?SC8nA1iqoNna8hhZFRe1xvqiPPbgeOI7N2igtFVJnJ7jQOzSyjWsk5dgcdgb?=
 =?us-ascii?Q?Mt7/0zFpfqOWgAU2wr0jAtPZ+y3PvO8lO0K6A9yyyYpcTQNK1gvmMavP6Nbi?=
 =?us-ascii?Q?OjK/nwPBFnNmFCLAux7TjtODT21ldquRMlt5I4Gx9UPE+dLTbbBxLJWydHEA?=
 =?us-ascii?Q?ZXe+6enn5xjb6145uZs/sNL+G5YeAjMqYAA4mAihmiAmEU85xueaFzxDQtnl?=
 =?us-ascii?Q?nPSg3tUacEmzOPUVG6WwseVNtyVQAfiq7QY6Hp/QAa35Zu5s84rnKRZZYPHs?=
 =?us-ascii?Q?xATTiOQ0aqNSFGNIKjX1WCnsQ6aNW6zy879anDH6m5MWUuWS8MxYFbwivY9Z?=
 =?us-ascii?Q?2aWuhiZ3wTjcZRIWCCgZKs2MjGJ6reCvj1qXvnJyokwiXc5W8kzLiksU00mM?=
 =?us-ascii?Q?BwzbTxpnQ+xrG5sycbHo1M+7TBYSJilVRD+1Mr5W+L8jpBodjpp6e7tuBt4j?=
 =?us-ascii?Q?0mgzmVPvOiDZSIc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 14:58:51.4439
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cc1ea5c-227a-485e-66cc-08dd6ae463d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4076

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


