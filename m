Return-Path: <linux-kernel+bounces-286219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F1A95182F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F65EB21C0E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86DA61AE849;
	Wed, 14 Aug 2024 10:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mFlvJZU6"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26EC1AD9C6;
	Wed, 14 Aug 2024 10:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723629643; cv=fail; b=BfeZVBg5D6+H2bYpQilOQDw3/Y++Fm4rCRkFZFxLuYofbllMCGnzwDGQzfqk9ill3+01qK6Xk+1cTKROONsry2oLMH0F8ssv3vLKIIblysTRvjBJSEfwTSgkbTvTa4i2xZ64ravKLn5H3E/UYPYgExfDR8scwMFf+/qn3oFAQ3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723629643; c=relaxed/simple;
	bh=lPgZAE+fvvYMOt23+hxKtWRKTpGreYr/ZXPXp4mWja0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rzBressX4VpTHuHu9d7j6pwItSi0Vlj6XSu7l30lyoXfArLqTkofFQwl2cCx5SfmOC7QDzMCRjsZqEptXt3FPWlrnfLkoUx9Jkrxe6MlZe5UhOQwQSecE3bSJJ8p27vxz7mB0GLi/HsnclHZcUTOB7i7RnXSQo3D9E+7/z5zqQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mFlvJZU6; arc=fail smtp.client-ip=40.107.236.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vi+c9/WSriuFjGUNbMvV7pEWqGNlk79EovNL9i5/qRwtZeIdx8w+4VH5TzTiWXg4WvDATZcRRtNWAOZ7gku9Q/rE5fuUsdxVUuYwsxXZmpHXGibGyQ2NHFGmkxABTY+DcUzsdsNNVy6FtmyVRT9zEygTmK2smDzXAjQYWzAFZHx9R9g1h5MSDBKZa/OweMFJmhs2nkb/qU7PHf1f1QxoXUmj7E1QzUpAielPT074dV835PUTrOovIr+cb9PfO9+e9G++bSFlNo26rgt1TZMIUkgliI3y5W2zAeNMkMeyJ7H9QPqpj4VaLg559NhnSk25617tX1AvpslU8Kekb8RLJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+qJZ1YyFhIOF52WNIsLe9o33zou5yY8O4X38AKYe0Q=;
 b=xllDAqVv6O7YCcKYxa+d2hKrnuCuUVWMW9ZsK0nLBjUGnSZXUfvAByWp2qS9jJstssn/W62aOwpCTFFhSdse97/a0GnzvGLZZI2wkBjFwPVeLImXZvKi0mUNP2oTN5xehfNmv7UvBJRX/aGh+jTzTC0KibX05qTtqQkTWHGqVipgiEoPXTt/kL7WoH4jxBvrG4RTgC394kqs73r+P+08xjw3veiILbZ9ZwsuSxYENxurolOK8Uv+hD5MEiXcJLclEIAIGM4jyJnXq9YmQAqjwAxKa/KTOHrSe2poCAEcus4lyWKFsMKetran5+alFlQB8NdC981yTE4OfoJ+5oqCbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+qJZ1YyFhIOF52WNIsLe9o33zou5yY8O4X38AKYe0Q=;
 b=mFlvJZU6biX0pC0YtKotmpXa0nwj4JpCjAb0DqNLr/agYjZVgI0Dsy3LWqdY5MOQSPwvR5fP958SzyWMGBAGewTpuw4LfOnw7Behmyc1danUe9jd0TqjgxOMC3w+K+gljVB+9yuUk98qoc7qmRBav+yvRv6mM42hCvThzGXN2Jg=
Received: from CH2PR18CA0058.namprd18.prod.outlook.com (2603:10b6:610:55::38)
 by SA1PR12MB5660.namprd12.prod.outlook.com (2603:10b6:806:238::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Wed, 14 Aug
 2024 10:00:34 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:55:cafe::70) by CH2PR18CA0058.outlook.office365.com
 (2603:10b6:610:55::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.23 via Frontend
 Transport; Wed, 14 Aug 2024 10:00:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Wed, 14 Aug 2024 10:00:34 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 Aug
 2024 05:00:31 -0500
From: Akshay Gupta <akshay.gupta@amd.com>
To: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux@roeck-us.net>, <gregkh@linuxfoundation.org>, <arnd@arndb.de>,
	<naveenkrishna.chatradhi@amd.com>, Akshay Gupta <akshay.gupta@amd.com>
Subject: [PATCH v3 4/8] misc: amd-sbi: Add support for mailbox error codes
Date: Wed, 14 Aug 2024 09:59:49 +0000
Message-ID: <20240814095954.2359863-5-akshay.gupta@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|SA1PR12MB5660:EE_
X-MS-Office365-Filtering-Correlation-Id: e695af81-3d27-43cf-6bd3-08dcbc47f05f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2JS24ONkwTs5tiyv2ej6VfziGiA80VhLcQOkCemf8+B6cMNLl9909uHW2LyB?=
 =?us-ascii?Q?Hg39j3cgDAlqo9huONhdsi3rrrzhXSFQE0Ih/Xk+y5C4/3obgYczIlfP3NEd?=
 =?us-ascii?Q?0c7Q/cMOJCxsPFiyEb8VTfqw6cj+JGZuqiGNJGRt9M7Zxc6JslAMw49BrSoh?=
 =?us-ascii?Q?Byevpscnd6b2iSG0qaRsL/ZC1S1cA6oaXSHFcdkXYIBhS+f/iW4fGRmp/7pc?=
 =?us-ascii?Q?+WwIs5agvq5BlES8pr/IKBC4ZryGlTC9whtWBpoOMYpYq1FmKry50hFGW/OF?=
 =?us-ascii?Q?sgkW6Zh4GYN6A73clOnqYQcETeyPhxqm06jEul3/baMjhHBryldJHhg/8yyv?=
 =?us-ascii?Q?4AKOB0cg2PjKgPj52VZbm8lYgjnK1ldUzKTuE68NMQdfRS7X1N1/IIV2zZxO?=
 =?us-ascii?Q?rGpANtbjlNVjDOY8H/LUwcKl2jWhioVYXEYXJrNJM11htroWeMQFrjPUqos4?=
 =?us-ascii?Q?VHu2S+cL2u4Mc6qwIpvu/TkaXhgpoKxNxY/0oYpmoKV8xSIeqF5JImCP1zYx?=
 =?us-ascii?Q?KXfisJjm5X7GCU2zBUUCieh3BSq17raXlJj4SzH7VMCQqDpu0tvUK/eoIbpv?=
 =?us-ascii?Q?Aw6N3nZovngVOnmLKxxkH6PbuiST9fO4BLIsa8oDFtDS5NlTq2vtqLQzqpxK?=
 =?us-ascii?Q?9Aft4w9/FLEI/yP06DFmD5e07DNCCMhJoW4LUL1R8KioBjIHfOp0bPZTQkVj?=
 =?us-ascii?Q?tgLlkXlg3HkA+apLGHkmjd7pSBODasR2GbY9iivTVJnUTLVIZyimd4y2pXm7?=
 =?us-ascii?Q?YRbnRrg3CwAN+P8gZYBeNFTwS6ZaG0vIbmxHS+I4T4yZSBbCVDLXxE6Cqu51?=
 =?us-ascii?Q?rhkJlz59S7S5TQUu3fcFKQrNH6yv5IughYYp+YwsRiMQzXNC7TwSFgueOTz3?=
 =?us-ascii?Q?aC5Hzqv86fDaZm62/ezrkmElIQBWMep7qaPszMvFv5cMnYK7DEaSFf1UzCrU?=
 =?us-ascii?Q?CG5Gc35zIARtVWjHQEjneOhtAopaIWua66jbL5NTOe95zPbZ8AtTntp7DeD0?=
 =?us-ascii?Q?i24jkzqlRmdBrmvx4pJT1Q94aFNdUpxHZuJUMU279pECoW7n7Grel7Kowa+U?=
 =?us-ascii?Q?pKU9k/4HArLYO2838lAZ0kGem+J4CHZsWQofe5CzLbl8MVhN5lveAW0yksy1?=
 =?us-ascii?Q?UQW/2OyxJ8vpliAJRglaeGXnSvC98Q7x9T3Xrxob3HW0BfLbh5Fo/aRjmoy0?=
 =?us-ascii?Q?ATpJjSoz34ma/7SMoN56CGQpNPX897M/ypypoQSebQye8HIlyxmFf4po3MfD?=
 =?us-ascii?Q?+aQbnskVKwdvAiDRhLllB9AdmUMA11E0kMHI7DBBP0FTIhbhtaV656T4oekw?=
 =?us-ascii?Q?o2ndWmljQnaYylV89T45pG3OgJJFqQdwkt4CQq8oWOYFBJzjIlmRlzzItFeJ?=
 =?us-ascii?Q?M+xcyXmWG56fIWY9HqXZRZH3sa3kY52wCXbASVAGd91TVN1S5JClN83UiSk9?=
 =?us-ascii?Q?8koiv79yMYfzyV87tOYKfi0yDS3s9XZN?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 10:00:34.0471
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e695af81-3d27-43cf-6bd3-08dcbc47f05f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5660

APML mailbox protocol returns additional error codes written by
SMU firmware in the out-bound register 0x37. These errors include,
invalid core, message not supported over platform and
others. This additional error codes can be used to provide more
details to userspace.

Signed-off-by: Akshay Gupta <akshay.gupta@amd.com>
Reviewed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
---
Changes since v1:
- bifurcated from previous patch 5

 drivers/misc/amd-sbi/rmi-core.c | 12 +++++++++++-
 include/uapi/misc/amd-apml.h    |  4 ++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/amd-sbi/rmi-core.c b/drivers/misc/amd-sbi/rmi-core.c
index 2a59a3501f34..a6364337dc5e 100644
--- a/drivers/misc/amd-sbi/rmi-core.c
+++ b/drivers/misc/amd-sbi/rmi-core.c
@@ -27,13 +27,15 @@
 int rmi_mailbox_xfer(struct sbrmi_data *data,
 		     struct apml_message *msg)
 {
-	unsigned int bytes;
+	unsigned int bytes, ec;
 	int i, ret, retry = 10;
 	int sw_status;
 	u8 byte;
 
 	mutex_lock(&data->lock);
 
+	msg->fw_ret_code = 0;
+
 	/* Indicate firmware a command is to be serviced */
 	ret = regmap_write(data->regmap, SBRMI_INBNDMSG7, START_CMD);
 	if (ret < 0)
@@ -85,6 +87,9 @@ int rmi_mailbox_xfer(struct sbrmi_data *data,
 		goto exit_unlock;
 	}
 
+	ret = regmap_read(data->regmap, SBRMI_OUTBNDMSG7, &ec);
+	if (ret || ec)
+		goto exit_clear_alert;
 	/*
 	 * For a read operation, the initiator (BMC) reads the firmware
 	 * response Command Data Out[31:0] from SBRMI::OutBndMsg_inst[4:1]
@@ -100,12 +105,17 @@ int rmi_mailbox_xfer(struct sbrmi_data *data,
 		}
 	}
 
+exit_clear_alert:
 	/*
 	 * BMC must write 1'b1 to SBRMI::Status[SwAlertSts] to clear the
 	 * ALERT to initiator
 	 */
 	ret = regmap_write(data->regmap, SBRMI_STATUS,
 			   sw_status | SW_ALERT_MASK);
+	if (ec) {
+		ret = -EPROTOTYPE;
+		msg->fw_ret_code = ec;
+	}
 exit_unlock:
 	mutex_unlock(&data->lock);
 	return ret;
diff --git a/include/uapi/misc/amd-apml.h b/include/uapi/misc/amd-apml.h
index ae597942e172..b2d711d422cb 100644
--- a/include/uapi/misc/amd-apml.h
+++ b/include/uapi/misc/amd-apml.h
@@ -38,6 +38,10 @@ struct apml_message {
 		__u32 mb_in[2];
 		__u8 reg_in[8];
 	} data_in;
+	/*
+	 * Error code is returned in case of soft mailbox
+	 */
+	__u32 fw_ret_code;
 } __attribute__((packed));
 
 /* ioctl command for mailbox msgs using generic _IOWR */
-- 
2.44.0


