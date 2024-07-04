Return-Path: <linux-kernel+bounces-240933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA739274C6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 13:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B626F286131
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 11:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9021AC43D;
	Thu,  4 Jul 2024 11:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nzlhUEMX"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFCC1AC43C;
	Thu,  4 Jul 2024 11:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720091840; cv=fail; b=SrT6iVGASET7FEr985OPL0sB3/Va2Cs3w1i9a5m3SH6nTE1jDtiJBOJplWClaebNnWG2WdLnVz0TlhpyMC6eAsyJemakafD+B0EuYIN231md1+ikLiGx0/5vovJgflXORXgg5D5STkgzrgIXdCXgLp0AdC5sAsiiStHNTW0R/B0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720091840; c=relaxed/simple;
	bh=1dAh54IzUIdSBJGJbNLPAweOI1nE318yCjG0VrrRRY4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kQKJucZE3ssK/+/doGmW67z2jVAoUdSUbtpcxrkxYw8n5HnA6h1YzoGoVo95wm0PEBmZ2Lgb1AcwFYsZEh/c/IDbmDmJx8XhyV3pwUz33LatiDw9WyMYRSbkXEjXOtkLdh8V4qdRKOa/8wFDXdLJ+Q+Tjx6ERL2bdY7e58cySRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nzlhUEMX; arc=fail smtp.client-ip=40.107.236.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SRgbPQ5b490yn0Se9PTY/6B4PWi2vqe4sGYQOv2Zr2Z73O2FY/3ppZ/06ZKfI1Y+qEoHGdKsBpyk+wWsP98xilYiimh72fXz6VehwuCVf8ItCjyqaex27QM/YWtxpMXL0wWfTIWLf6yUiMvJ00vpHbhnxZn8Q+lU4klxYmwVt7BhSbe/79EGZpojRuMRsfOi24dO7Lo0fA/jHob24C3S1BIFF+/MF4LnuSMWGA1gPV2m/7R2udGrpK/oBrz5w0l5ZD3IgANBL3gJTON8zAiTh4Hzce4BWygwac3RhxYv95P2W6cxDTZl6ZMZlKl3AeXDOssIgdXKa6FOQnwCnixb8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nWY4oDbqJEOkSRkZ4oDk0Yt5e9HlZisov1XHVWIXKMM=;
 b=e7Hv6wZQwrVABNA7hbt39iVGoMRPYp8+TM6rOXoQH9Tj+Aum3mwwjY9XgLpMYFrluXuTJhKuKX5pum+wkFZe7IB4La7p4mOTwEiDPyMXTNM57OQHxy5vSwPa6UgcGkc2ReNt2502SfkBWwy1y60hjvurKTDlC1HaRb5YRSgWSaO1Y3FgGHmER7ocHEuX8o8/muYylWzp56OpeQp0sPnRH1qfEGqIX492VIxHSLQpyMV6whYr3qHoD8X9yfHEqJnqup6mXntzl59OFiBAy/iccueRhL26huHuSn3YzOW6tfaMW0mxT+JYxoK0lDNp1szDMCZMyZwQrQ30YVy2s24lqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nWY4oDbqJEOkSRkZ4oDk0Yt5e9HlZisov1XHVWIXKMM=;
 b=nzlhUEMXTlSt6834LeRHJRZBzNq8BG9qIAjj9LNui9u8Oy5vlBvu0suauA2f8JL060XVfpM8kVXSDU7LZ9hkkTqXqcBvFIXpZsLaDLPKJbQxLr7vDQoogNwoVjv2Gb9GCMPaez1SFlXQcB+Rx9xnJiisZvsswB0frqnpT2x9cdA=
Received: from CH2PR20CA0013.namprd20.prod.outlook.com (2603:10b6:610:58::23)
 by SJ2PR12MB7799.namprd12.prod.outlook.com (2603:10b6:a03:4d3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Thu, 4 Jul
 2024 11:17:13 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:610:58:cafe::bd) by CH2PR20CA0013.outlook.office365.com
 (2603:10b6:610:58::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25 via Frontend
 Transport; Thu, 4 Jul 2024 11:17:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Thu, 4 Jul 2024 11:17:13 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 4 Jul
 2024 06:17:10 -0500
From: Akshay Gupta <akshay.gupta@amd.com>
To: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux@roeck-us.net>, <gregkh@linuxfoundation.org>, <arnd@arndb.de>
CC: <naveenkrishna.chatradhi@amd.com>, Akshay Gupta <akshay.gupta@amd.com>
Subject: [PATCH 3/6] misc: sbrmi: Use regmap subsystem
Date: Thu, 4 Jul 2024 11:16:21 +0000
Message-ID: <20240704111624.1583460-4-akshay.gupta@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|SJ2PR12MB7799:EE_
X-MS-Office365-Filtering-Correlation-Id: 580a1e1e-348f-42a0-8b68-08dc9c1adade
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TwRGKFruT3pHSig49b261tM7MU7z63mx+iUXx/CAPD04DKLNbPQAFR88C2jz?=
 =?us-ascii?Q?JikgOiCNKnHb4fVZXOJnupIotHr7uuP9LXgyyO2DXZT/m0KFJ4Rbd0cMqf1n?=
 =?us-ascii?Q?eMrmyMA/dhS9U+7PJxUXnmSpQO2ERq2yY/OWRkhTQHZX0Jg4pZaK8CZCWymS?=
 =?us-ascii?Q?hPXC1mGhewVi9GWTqguVeKwV+JE6qvXkI7vB0WB8emJG+G0706+DqiuHp11B?=
 =?us-ascii?Q?o7FYqAXjhDljXcrYbfsPLarA1AoOnVZ3R+6AhDp7W77Y/2gNIbFasXQGgNLK?=
 =?us-ascii?Q?ftCLtGI/bPcpt2KAyz7ttW+Z+D3Mycb9n3nz5R/QK5HsTDU0wMwwHBVOvUCB?=
 =?us-ascii?Q?da8HH0eaAxqqFhCl2Uq9ZZN+LSHyBUfvZGSvTWYGgXrNTr1hl3iLi5sPXO/t?=
 =?us-ascii?Q?zUDC5txByvjFUdbQO5HeJUYmXUwwPFzYv5BhkgLN1bayZzyjaoer0pAaNelF?=
 =?us-ascii?Q?wIpEv1KPBeHQHrE7zONHCZ34k+noZ180MPBFUHEMZurBDEIa9lRnvcQRMVMs?=
 =?us-ascii?Q?AJy0DXaZZHWMcDn6UGC9+kkrXViuuC/6VBGwG/m4bZOfboJOxukCd5W01pSM?=
 =?us-ascii?Q?2gL7sjbHtxuHlU2okJhCSLt9eDJn1SVMz0kXUKWXU7g2/Lqz9YePzmPqqPda?=
 =?us-ascii?Q?r6QNa5XLfTQkWNgef3Z+hdoviUKQ6vh58vZeAiBl+gHfSNXNRFbdd8sCYOIm?=
 =?us-ascii?Q?rlP80W+gbPZxPsR7BwnBX4KOpdq5o0ByYOuYkHqEm8D9Znj3JURvvKVjx6Fa?=
 =?us-ascii?Q?WI/N1urisQ9OzC+Lnox3MaIq5aluenfz91nxrbTwKPEa+C2SA2WAfqmj3ntU?=
 =?us-ascii?Q?Cbzpyg0nURj/6exj5BUdtgQ2653Nl2VDQBJBxlA6oGHnd9Brh9zSMqVKQVo1?=
 =?us-ascii?Q?1dId47yFcaN0ronkFQv/2N42L3LeDGbAVxA/PP8qEgi6MrT6qafCZJScUTsU?=
 =?us-ascii?Q?qqpO1BxpIVdZmRZVeUyGvjn/4MK55/cFNR0I/80n8M386JHnWonhf1gSs6cn?=
 =?us-ascii?Q?3oOLfh+rEBb9wAo2duhs9bqTU9SbX44F7YLtk0wwU8vOt93Szbm2uJRAKQpa?=
 =?us-ascii?Q?holAzA25kKDW59kBl6McDi2wvIk3GXjuWfecsXhwGfPL5vvzWtn+4krZKHYc?=
 =?us-ascii?Q?tCYr/fBJkvRrrBurABZ9yhhJNOhiDsWhhRbd/fQXVrBrECJf38Q/cHJsBKkO?=
 =?us-ascii?Q?jKRPg5wIOnkyMVESqXNtVvvOWp2KW+o/GrqFoLJAs3hAH25/nyO0HrMJpl8X?=
 =?us-ascii?Q?pkbcNzHGBl+6PJHBu0MwrYrnj8kf7Jjfey7ls8kwUcFUJ8AnjL3ILPkVVGKM?=
 =?us-ascii?Q?hzS24PZ+MLzNMiYI0EDBC9PzRRrTOI2NBT5LncKdF9FuAYe3FDeYFcl6Myy6?=
 =?us-ascii?Q?juh+6iN5sCzQjn3cX9yBhIHZR5RTdvtAtGTp/OpA1CXnlicguOILPPmXp7aM?=
 =?us-ascii?Q?BHucMaj0cZ1uM6zuFNJJBtd0oU2pbMfl?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 11:17:13.3930
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 580a1e1e-348f-42a0-8b68-08dc9c1adade
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7799

- regmap subsystem provides multiple benefits over direct smbus APIs
- The susbsytem can be helpful in following cases
  - Differnet types of bus (i2c/i3c)
  - Different Register address size (1byte/2byte)

Signed-off-by: Akshay Gupta <akshay.gupta@amd.com>
Reviewed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
---
 drivers/misc/amd-sb/sbrmi-core.c | 29 ++++++++++++-----------------
 drivers/misc/amd-sb/sbrmi-i2c.c  | 25 ++++++++++++++++---------
 include/misc/amd-sb.h            |  6 +++---
 3 files changed, 31 insertions(+), 29 deletions(-)

diff --git a/drivers/misc/amd-sb/sbrmi-core.c b/drivers/misc/amd-sb/sbrmi-core.c
index 5ca0a9ec8341..b2437a4044ac 100644
--- a/drivers/misc/amd-sb/sbrmi-core.c
+++ b/drivers/misc/amd-sb/sbrmi-core.c
@@ -9,6 +9,7 @@
 #include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/mutex.h>
+#include <linux/regmap.h>
 #include <misc/amd-sb.h>
 
 /* Mask for Status Register bit[1] */
@@ -44,6 +45,7 @@ enum sbrmi_reg {
 int rmi_mailbox_xfer(struct sbrmi_data *data,
 		     struct sbrmi_mailbox_msg *msg)
 {
+	unsigned int bytes;
 	int i, ret, retry = 10;
 	int sw_status;
 	u8 byte;
@@ -51,14 +53,12 @@ int rmi_mailbox_xfer(struct sbrmi_data *data,
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
 
@@ -69,8 +69,7 @@ int rmi_mailbox_xfer(struct sbrmi_data *data,
 	 */
 	for (i = 0; i < 4; i++) {
 		byte = (msg->data_in >> i * 8) & 0xff;
-		ret = i2c_smbus_write_byte_data(data->client,
-						SBRMI_INBNDMSG1 + i, byte);
+		ret = regmap_write(data->regmap, SBRMI_INBNDMSG1 + i, byte);
 		if (ret < 0)
 			goto exit_unlock;
 	}
@@ -79,8 +78,7 @@ int rmi_mailbox_xfer(struct sbrmi_data *data,
 	 * Write 0x01 to SBRMI::SoftwareInterrupt to notify firmware to
 	 * perform the requested read or write command
 	 */
-	ret = i2c_smbus_write_byte_data(data->client,
-					SBRMI_SW_INTERRUPT, TRIGGER_MAILBOX);
+	ret = regmap_write(data->regmap, SBRMI_SW_INTERRUPT, TRIGGER_MAILBOX);
 	if (ret < 0)
 		goto exit_unlock;
 
@@ -90,8 +88,7 @@ int rmi_mailbox_xfer(struct sbrmi_data *data,
 	 * of the requested command
 	 */
 	do {
-		sw_status = i2c_smbus_read_byte_data(data->client,
-						     SBRMI_STATUS);
+		ret = regmap_read(data->regmap, SBRMI_STATUS, &sw_status);
 		if (sw_status < 0) {
 			ret = sw_status;
 			goto exit_unlock;
@@ -102,8 +99,6 @@ int rmi_mailbox_xfer(struct sbrmi_data *data,
 	} while (retry--);
 
 	if (retry < 0) {
-		dev_err(&data->client->dev,
-			"Firmware fail to indicate command completion\n");
 		ret = -EIO;
 		goto exit_unlock;
 	}
@@ -115,11 +110,11 @@ int rmi_mailbox_xfer(struct sbrmi_data *data,
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
 
@@ -127,8 +122,8 @@ int rmi_mailbox_xfer(struct sbrmi_data *data,
 	 * BMC must write 1'b1 to SBRMI::Status[SwAlertSts] to clear the
 	 * ALERT to initiator
 	 */
-	ret = i2c_smbus_write_byte_data(data->client, SBRMI_STATUS,
-					sw_status | SW_ALERT_MASK);
+	ret = regmap_write(data->regmap, SBRMI_STATUS,
+			   sw_status | SW_ALERT_MASK);
 
 exit_unlock:
 	mutex_unlock(&data->lock);
diff --git a/drivers/misc/amd-sb/sbrmi-i2c.c b/drivers/misc/amd-sb/sbrmi-i2c.c
index b593bbdd78e0..539539c42754 100644
--- a/drivers/misc/amd-sb/sbrmi-i2c.c
+++ b/drivers/misc/amd-sb/sbrmi-i2c.c
@@ -13,26 +13,26 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
+#include <linux/regmap.h>
 #include <misc/amd-sb.h>
 
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
 
diff --git a/include/misc/amd-sb.h b/include/misc/amd-sb.h
index 79b76dd6068a..71abb3035f48 100644
--- a/include/misc/amd-sb.h
+++ b/include/misc/amd-sb.h
@@ -7,8 +7,8 @@
 #define _AMD_SB_H_
 
 #include <linux/mutex.h>
-#include <linux/i2c.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 /*
  * SB-RMI supports soft mailbox service request to MP1 (power management
  * firmware) through SBRMI inbound/outbound message registers.
@@ -23,11 +23,11 @@ enum sbrmi_msg_id {
 
 /* Each client has this additional data */
 struct sbrmi_data {
-	struct i2c_client *client;
+	struct regmap *regmap;
 	struct mutex lock;
 	struct platform_device *pdev;
 	u32 pwr_limit_max;
-};
+} __packed;
 
 struct sbrmi_mailbox_msg {
 	u8 cmd;
-- 
2.25.1


