Return-Path: <linux-kernel+bounces-286217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 504C2951827
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D1EF284AE8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1AD81AD9F9;
	Wed, 14 Aug 2024 10:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="W3igQmYO"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7E01AD9D0;
	Wed, 14 Aug 2024 10:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723629636; cv=fail; b=HtlCIrbiEDkGYOKEV2hMGoKyfVMcn5GzuSErxO+yqfIiUscUUiFRhRvyxv7n+/KueMoPYcELCGnhAuYqx2r1cscr4x866FaL0Blu7nShaM5DAKIL44FFReJGpttuTNubFEvvLuDyWM0cAKorvs2Z6ZEbY8940hk1BbTvuNN9jNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723629636; c=relaxed/simple;
	bh=sGt9Qs4F1MJhqdQHyyzsE8tmK+KWohya7fEfI/KfLUE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tQpZxvelH1h30V+rf9Xwm7TnsauBnWf4IR0LZ0Qd/GgUO6nfdUfOunqIUyUTHyX/eOBBzh9eZwvWY9DJ/jXSZn34TjC/Dr05i+u4iAtUbZEplspNyuLuQw+udAYAQUjjK11uSpdIgJpKR9dhWAweIWxLneqKDqbmAaaUtnHVUS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=W3igQmYO; arc=fail smtp.client-ip=40.107.236.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GCf7xwSwe/Q+fnJHW6sWRFqNSpSaFTZmZMIKVSzHggtkfEVb32oX3nJO9zSQNswppCjtR0yaZgxSdTnravADjRwSrsH3GfsotV+aHs3vonsMgDq8/QcdovGCPYPosF3/jMeNypnJknuzJi3w5JPSkhxrZ1BBkXiWORNhYFBQNpRg9ysSXaZF4aqenJWC3LYZ/YUAnB2SRBX8FZBDZIuTnHIX3FjtR1tj938K4qjI1yqbol4qd5CWwtl+EPfjqxMuPmB7XnYq9J8NZ23wcoS9ivttMz9yaHkw2CZ2A6TxUWa5tQe+XgpBY0+cXVKjqLdp4z/KyWAT7qBLSqpn6uK5PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g+0CAJa4/f0IjI5cDCGnVtbvAVOV4aCme+9KYrsrpRc=;
 b=fYeeNiCor1bR/r6+90Xf/glmMWBHzJBHFQ+ARzN1kQrzZJlYGcUpgli0a+1KxEmM323x6ucaJ+cLdWhxSYmeGOn+PUiL/fTn7VcLCILtO8YgwhJFBQDXLG0xxUm5xdkDI7pOcFKNGmZOp5JDmTpTU7XqJMjMit8BHwxaVAPOEY2sTbRxwaBtntp/L68lEgbVhvT5CnXa82Qszx6Du8GB6CHa4joXoMNYRW0nfPsw+kebn/A+HK95k9c7deBSgZ9CJbfveL8/ZDUzlZLwB5fq3Snx+fv5alocvZCnj2ZoTRtbGfr4aVkVY5VKFNFQGN1i5Mt6XAftsS1i+zqwDmWC4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+0CAJa4/f0IjI5cDCGnVtbvAVOV4aCme+9KYrsrpRc=;
 b=W3igQmYOFTgZTTAmyow3To/MP3BeAvSWD2aFILrQWlXsiuAHEwIMycQ1jhnBurit9k8znX1P9nMQgM2AXsI5TsXgqUtZvsfp4iEAb3UC4V5+EMD8vwUR4mytxi6UMgbia4aC7gzqKA93Fh4lZfIC1EXuQe13SG9IzKnOrPl6AAs=
Received: from CH5PR05CA0020.namprd05.prod.outlook.com (2603:10b6:610:1f0::13)
 by SJ2PR12MB8034.namprd12.prod.outlook.com (2603:10b6:a03:4cb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Wed, 14 Aug
 2024 10:00:29 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:1f0:cafe::db) by CH5PR05CA0020.outlook.office365.com
 (2603:10b6:610:1f0::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.16 via Frontend
 Transport; Wed, 14 Aug 2024 10:00:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Wed, 14 Aug 2024 10:00:28 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 Aug
 2024 05:00:24 -0500
From: Akshay Gupta <akshay.gupta@amd.com>
To: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux@roeck-us.net>, <gregkh@linuxfoundation.org>, <arnd@arndb.de>,
	<naveenkrishna.chatradhi@amd.com>, Akshay Gupta <akshay.gupta@amd.com>
Subject: [PATCH v3 2/8] misc: amd-sbi: Use regmap subsystem
Date: Wed, 14 Aug 2024 09:59:47 +0000
Message-ID: <20240814095954.2359863-3-akshay.gupta@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240814095954.2359863-1-akshay.gupta@amd.com>
References: <20240814095954.2359863-1-akshay.gupta@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|SJ2PR12MB8034:EE_
X-MS-Office365-Filtering-Correlation-Id: e27dce89-33c3-41cf-c07f-08dcbc47ed17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	8CMrTg4zNkPdATdEf8ygMY0qY2aKbEDQqiDtAfl0A6Rkgp1/MhMrR/H7NtYLZo8Xpr6aFh4cXQZs3eUFgkJB8hQIgmm7RdglVIGGgk9LtLYtauD3FkQGtkpFrXFzLD8vQFwS2PvA60NvPqKqzvis7sfElnUKwWU1eOnbRW+05RHDVKQR0+z4t/DrYbYIRB/b0VcZdRs6s4SWFqZhPKTxeZdllNdL1wMdQLZe4Dhli8Hlb6tA2ctT6wC6chbY/LfursdRCRqeJtDZ8/LHyLlDY1tLj3/Mc/kcB9rALk7ZUowcXnffzWEYwv9FGUwnH5KTXLdysvr2SJ+rLv8KfCRMIYCTsm9OOBd8I+YFSielNBAlmrXzFNAQr8B5VXV8DZMPvT9WJwvgxLQ+oZJ2cjCivTQrCFPzzzId2oTTI8h3V+y00eT3Rzq1c6a8qvGVYgoOxXb1CNmqegxtM0K1FCuw1e9b7ApEmnYwDjHP/EcLrnbfhXU1q6Wnp8qTnIzk6yU0DOst2H1M7QXU6pzcmZQQkss1PsB4ujPcRGtWG8sMDWpNooG1uMduXGbRuIokrMQniRl1hOKNoJMH3h/mFAJB/PXNmi1+CFiP4Ru9FwlHEed14hwAsDNOyxYjr6RSBsArdkQWcHDEqF1BXmpzsZZ0dJpwu0Likk3piFYCsx2toFEP5UrSQ6CAVQO9M7ga51b7rjyBli4KrjomV+Hque5NMw5o8J1cnPhmk47QiFd+tRg6pzGU1TdJE5BwSpvUc7y0
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 10:00:28.5287
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e27dce89-33c3-41cf-c07f-08dcbc47ed17
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8034

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


