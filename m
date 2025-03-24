Return-Path: <linux-kernel+bounces-573887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF83A6DDA5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 16:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BAA4170585
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DDE25F985;
	Mon, 24 Mar 2025 14:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DdJ8ELh/"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2060.outbound.protection.outlook.com [40.107.95.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E9225FA3C;
	Mon, 24 Mar 2025 14:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742828348; cv=fail; b=QtMFmnuBoJU3L5sMceBZGXXQclhdYOQOxXIzguFpZiq/QBbKPYrfWtw+pUM+KdnT9d8dllm07pacgUKgBfqGDlMQNA0a9nYh8JpmhwpQW7FOapeaCHEd9+Ig0VDwUHrhgdLLk7N8MOia81aUa93eZYpS0HO2xR1jzupvqKg+gKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742828348; c=relaxed/simple;
	bh=ncTnYuf7YPJhuXkN7dae5dAuje62daiu7QDsK40+Njg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hhedG9PkEUDJkriLhQavF1e3/jpBuhhk9W6XQKIYA9fZbXxvGL1oiTz7pr+9E1tjCBIjLvWfH0GqRBuRKBOC7XUefHGwkjj9kE8SKMrcKzc8hwesWDz6JkwzVBLMirmo6gEqsbLk26my7NdsBaWVdiGiwB9C0YVCrqQ8UxcCj7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DdJ8ELh/; arc=fail smtp.client-ip=40.107.95.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=usQacWPccV2oS4AVfDmTcFrum8F6/DHuU/k42dQ4Q5relAtFqa5WGYU3MRil7wyFks5sZvOjs6ims/lxBLzwJx19SN7xhxGXD8uYEjFChIAEWov1rCEocmM+bsfsHjK3vsc66Mi1sTvstLqMKPIo03KVAJpQ/wcwjR9c3v/GxsuknqcotlG+KASXOiZoaQSg9t4UuAmtRrFDaB3HxuhbQrde493HU1pmABa4AvcfIw34XLp8LoJSqs6+6IU3AN6kM3A8Zbe8Bm/aD6h/PW9jb50aPhbt2+Zd9KJC/L7jrYtLre2RkCLrMNvkppGf5GxSohRLiSc4VH4Gh5NomgX+wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kw6sLYROldUs+Y6ODO75vcH2mOI8yBEkZSc1IpAPdjk=;
 b=TqDg4K+EUcI+01vmTPYGQsc7lW7zOSyssZA74qgJYXueKBNqUB12uMmb04JVp0Wcu1s87Kn37fF/8L4kcrlGDxWMTHhLK9qcTKn6b8NZ373eg3pcH1EPL0SSyIfgSHrYnLab17lvhIe09oQWNs6nEyzwCFwab6g5ePeW6As8mpUPWaHpsXsV4B/lCuqPiBmWQ0GotbnpsUdOI8YKQPUCsO18DG3ZcyirgOLN4sheKnhV1F0hBT+BbMGGWG3YStfb+VUVWD0fwlAcgqsdOugZlhAGor/bY7U+SQvAT65G00ANRAyude46tVJxk4RpDN8opPMo9d6DYbrx1WX2XJFMLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kw6sLYROldUs+Y6ODO75vcH2mOI8yBEkZSc1IpAPdjk=;
 b=DdJ8ELh/r7PjtNDwZTHFt5fdoJHNe6JCfuAdlPSZw3ct7oqe2rkF5cruD0ExiTmxNtF2ehioTBKZ8S7iKSU5xhNeQpad9tPTKzefBxIajs0lLFUKsK9PgdHz7udQy02tiFEpr0NBZFk4se0kr2omV0C/rzgmcVsD0vzvpIHkUFM=
Received: from CY5PR19CA0018.namprd19.prod.outlook.com (2603:10b6:930:15::31)
 by MN0PR12MB6103.namprd12.prod.outlook.com (2603:10b6:208:3c9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 14:59:03 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:930:15:cafe::13) by CY5PR19CA0018.outlook.office365.com
 (2603:10b6:930:15::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Mon,
 24 Mar 2025 14:59:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 24 Mar 2025 14:59:02 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Mar
 2025 09:58:59 -0500
From: Akshay Gupta <akshay.gupta@amd.com>
To: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux@roeck-us.net>, <gregkh@linuxfoundation.org>, <arnd@arndb.de>,
	<shyam-sundar.s-k@amd.com>, <gautham.shenoy@amd.com>,
	<mario.limonciello@amd.com>, <naveenkrishna.chatradhi@amd.com>,
	<anand.umarji@amd.com>, Akshay Gupta <akshay.gupta@amd.com>
Subject: [PATCH v6 07/11] misc: amd-sbi: Add support for mailbox error codes
Date: Mon, 24 Mar 2025 14:58:11 +0000
Message-ID: <20250324145815.1026314-8-akshay.gupta@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|MN0PR12MB6103:EE_
X-MS-Office365-Filtering-Correlation-Id: 45980c92-c37c-4fd1-092b-08dd6ae46a8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZvlqrKpTJdhYxaNV/bO7AJEC0AblRWbsqijiRXnpgfunkrfJ5cN8GJf/E9MH?=
 =?us-ascii?Q?99pYAXsOhxD3GiV6f1h4mo99a7s3u0olh0sGfYXzjvV25O+FWa/ktd95osvj?=
 =?us-ascii?Q?CVMGD4h7Wei5tV9fFtorObaBdO+WsIO/4b4DO+7mD8eCGq0KFersJYJ+DmpL?=
 =?us-ascii?Q?6dEsdh5ZlaKCq3qxG0wfyktxz+4bPqiMtpPMTwalorUPC5CHxFCzhcnsYJO4?=
 =?us-ascii?Q?o/aYnuVXMHex3pGPCcDLI8JtHwL49rH9i0jW1gfzSBQhwHiefbdsiDzXK6i9?=
 =?us-ascii?Q?cwmpgFbARprZRuKiltAg0rcX9BsvK78HYLrruif8S80rnWVYvPpA98Gp/7Su?=
 =?us-ascii?Q?eA472e+debX9YDP/cCjg3EMWHTc3Y2gSdZZUThS5EqaDOP2iSFtZ9g1nOrKb?=
 =?us-ascii?Q?Lx/UNTLWT1xxMjrNvyk0B05Ztu75D3oyy5kkUb13H1LvxN8vyngUwUpNrl1b?=
 =?us-ascii?Q?JtpjGhouVNthfJrjKLhWSzbX1akJ9Ss0ZJphEZHnBcvMJO+A6YmMmKQ509EJ?=
 =?us-ascii?Q?f6+xeaq6tzwov45ZXc47jT+JD7CYoHw6s329hgNR9YcKjQK1sh8qLj3PMwIO?=
 =?us-ascii?Q?r2csSzQH20OEW6PPiTyIwVW+tgrRLBG9H/4w4G1pOaNNiYVtbdvAutbobC1/?=
 =?us-ascii?Q?4nFEiFvhAG9Q5DSU3iXLjRt6+MYnYAnv/DjsIknrMyBiTlEUblrPqSU8dT5d?=
 =?us-ascii?Q?uILgBJ8bMH5PSIaNBNMU+Otvoqyd4Y7Yjx6+Mb9v11wXdXi8FrRnLXxdK43B?=
 =?us-ascii?Q?j9uD0pyCZAwerB1eToVWIg96LNo5JIsTyF097mmxvd4zkC3yd6zgnODWMzQF?=
 =?us-ascii?Q?n7KNHP9E8f2AL9mI4zN/34+PWSUiWMZR8Xaim0ys/OLPjxwaiAraKqwJD20O?=
 =?us-ascii?Q?dGOaN8uI0KQJYgdu2VCmhYc5yvZUXYHUEFrA1SFNe/I/Mx1piRvrslEAUToY?=
 =?us-ascii?Q?WRWMRLHXb7QkQLiKnxBISOk2pTlUHYj3VazmS0zozeWh/ojx/XycHOCF72Mh?=
 =?us-ascii?Q?yvTGWQrBrIPmAeIJPX16gIHWaoesJO3LX2iJNAECguNVSJWP4tA8tNmTQjza?=
 =?us-ascii?Q?YUMRM8HqSZwWe3KyU5n9CH151jU+ewvvgtE2aQ+eM9QVO74IGTezBGGBnwQN?=
 =?us-ascii?Q?Btfsb357MqXxsWEkLqBBNBkGl243rgJzXNrzqUpdFO30xQxbvLcP+KbC9qC6?=
 =?us-ascii?Q?2xbaOXV2tMwcUVXAs20rx3YSSQv9SrhwzTXMK2R3nn7TTLPplcsIq4Z5ZNdr?=
 =?us-ascii?Q?vHSdFJ287+DMM2EnsOD4HWNt+lAP+BcUT0mzD9J5LYpG+TDnZRafsvTrfKXp?=
 =?us-ascii?Q?F5kkgAO4oSHkA22/XPf3AMkfF2eMDZ1kXmE0NfgfYObFDThEScBz2LSxkslI?=
 =?us-ascii?Q?tsZ9lfLiXlQ/3i6FqAGoXd7RKqSrD8JwsIhvfPaUt9Li2QHljoPK+9cqyx1S?=
 =?us-ascii?Q?oIbJh85HYWMzkHUpn328ec4PCwk4UibsosY+5t9Yl0vjCvx5tONYRIWzrSWS?=
 =?us-ascii?Q?xKpz4rQeDWokiI0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 14:59:02.7656
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45980c92-c37c-4fd1-092b-08dd6ae46a8b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6103

APML mailbox protocol returns additional error codes written by
SMU firmware in the out-bound register 0x37. These errors include,
invalid core, message not supported over platform and
others. This additional error codes can be used to provide more
details to user space.

Reviewed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Signed-off-by: Akshay Gupta <akshay.gupta@amd.com>
---
Changes since v5:
- Patch rebased

Changes since v4:
- Previously patch 5
- Fix Documentation warning

Changes since v3:
- update ioctl comment description
 
Changes since v1:
- bifurcated from previous patch 5

 drivers/misc/amd-sbi/rmi-core.c | 12 +++++++++++-
 include/uapi/misc/amd-apml.h    |  5 +++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/amd-sbi/rmi-core.c b/drivers/misc/amd-sbi/rmi-core.c
index eafdd2799034..332cb03e8326 100644
--- a/drivers/misc/amd-sbi/rmi-core.c
+++ b/drivers/misc/amd-sbi/rmi-core.c
@@ -25,13 +25,15 @@
 int rmi_mailbox_xfer(struct sbrmi_data *data,
 		     struct apml_message *msg)
 {
-	unsigned int bytes;
+	unsigned int bytes, ec;
 	int i, ret;
 	int sw_status;
 	u8 byte;
 
 	mutex_lock(&data->lock);
 
+	msg->fw_ret_code = 0;
+
 	/* Indicate firmware a command is to be serviced */
 	ret = regmap_write(data->regmap, SBRMI_INBNDMSG7, START_CMD);
 	if (ret < 0)
@@ -72,6 +74,9 @@ int rmi_mailbox_xfer(struct sbrmi_data *data,
 	if (ret)
 		goto exit_unlock;
 
+	ret = regmap_read(data->regmap, SBRMI_OUTBNDMSG7, &ec);
+	if (ret || ec)
+		goto exit_clear_alert;
 	/*
 	 * For a read operation, the initiator (BMC) reads the firmware
 	 * response Command Data Out[31:0] from SBRMI::OutBndMsg_inst[4:1]
@@ -87,12 +92,17 @@ int rmi_mailbox_xfer(struct sbrmi_data *data,
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
index 451cab135a08..d0c548e34150 100644
--- a/include/uapi/misc/amd-apml.h
+++ b/include/uapi/misc/amd-apml.h
@@ -36,6 +36,10 @@ struct apml_message {
 	 * Mailbox Messages:	0x0 ... 0x999
 	 */
 	__u32 cmd;
+	/*
+	 * Error code is returned in case of soft mailbox
+	 */
+	__u32 fw_ret_code;
 };
 
 /*
@@ -58,6 +62,7 @@ struct apml_message {
  * The APML RMI module checks whether the cmd is
  * - Mailbox message read/write(0x0~0x999)
  * - returning "-EFAULT" if none of the above
+ * "-EPROTOTYPE" error is returned to provide additional error details
  */
 #define SBRMI_IOCTL_CMD		_IOWR(SB_BASE_IOCTL_NR, 0, struct apml_message)
 
-- 
2.25.1


