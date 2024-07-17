Return-Path: <linux-kernel+bounces-254867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C01C9338AC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 10:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F8C41C229B8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 08:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1255345BEF;
	Wed, 17 Jul 2024 08:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="U/Jg0djq"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D63C25624;
	Wed, 17 Jul 2024 08:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721203868; cv=fail; b=aTvrpSiY6WPg9EMrCXGAZTsZvPBfg8hyA80VyaLdCxNDBmoP1tYNPyHHw3QFGQxibuR8tcsNctSojCdhWq4Dl+kiiU+15FZEyY/E0GUPH0/0Z9ISvBM+0MOSQCjcSg4dLHvzQAk+9fpHHPEaoK/zmF1Xnq/6Jdi6+8NV5ZCo1do=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721203868; c=relaxed/simple;
	bh=YWAPkUykjagh1DXqXPopSQhT4tP32QGbETuHcuJ3AdU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JM7cuD7clyBKvaNs8l5w8FhTbUqi/pc+uev2gr7kEXwKKsolWpD/C9p3XFS7Hm7YFWFXmGMky7PMRloBMBybh1iorTw+zfgKi6hPQY5QlVJP/19+MHgcvHg9qp0JRFENXniOONaMKFSqigm36AoG5aHim6jMQQu4Lt+TCwLughY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=U/Jg0djq; arc=fail smtp.client-ip=40.107.237.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kEDxFm5VYuSVvW77juT1a1sj4MmM1FxGtmJGaxOijG+0Ot459NyMQBGmV8UH3RGRNuB1wLL67efBQkB0KEgW+/Bo6YgMuqoa4I0EXm2iMgGuQnjEGF1l4d2N15lNIlvHxr8tuDSviV6ml68sSCZO3fVNW+sElVbsUBY1sgLEFMbOnE6vEfTvyi32mEl8NRE9DF5WrmHhe2XwCQPcUPxfDuUHQJSaBv3Yc2scQp7tug5TaOgk5nHbRYwg5rQ9z8U8YjGSyg3lLtfSNjLHWc1yDA8BMB9k5f3idDhw9Xt5MypphrDCgyhVAlyIZYOktU9o1IRvl6Z5C9SRfyve1xqsgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=piDOeZ0zlUoJ5vFQY5A8oy6w77pFMiORvykgLOCEQjw=;
 b=MKVBWCWXAfiwCtTvb9ree5lPHXP2tZxi6wGXbK9q1XprEoK3S6uyzwhmQd8KAnJlHXHjPme1JNU/FrQhdeJZT5PTTlJ9m/2IkQfSaRNx5O2asWVDTYVI6Q32QZI7oyt3V162UUWCNqxIMtwFZyXf14pa9Tw/wrP4JrzZ3UZzQYKRJiQCieunXhRzu3xJEpabxN+SMX2ixXcPz3YxKQ9DL3Q/NQyN5tyObpf/7PfP4/Rgx3rMFSZjOO49n9FNWGoFTARuRFrdxNAtWPIASwA0GT4pzQKrF8IAtFZB9aRL4PxJVWxrYZDOn8U/fLF8mVPdam4elWf3Hz8xUAuZhYXnkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=piDOeZ0zlUoJ5vFQY5A8oy6w77pFMiORvykgLOCEQjw=;
 b=U/Jg0djqv+f8/4T1VZRzcDwiy5Wg7z5PVZAQOs9RZIL+7xToZuPbIN7dzI4vJz4eMoJ7kiGg/cPLg3QPvXoHB4WbxpxosQ1jYFyeByM2wQYg6/5NQr7Vi3YX5zS5BLB2Ae2ijRxZAn4Htoro9LHvV/s85ZY1CzfmuiSmEQ+MQsI=
Received: from DS7PR03CA0232.namprd03.prod.outlook.com (2603:10b6:5:3ba::27)
 by SJ0PR12MB6903.namprd12.prod.outlook.com (2603:10b6:a03:485::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 17 Jul
 2024 08:11:03 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:5:3ba:cafe::54) by DS7PR03CA0232.outlook.office365.com
 (2603:10b6:5:3ba::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16 via Frontend
 Transport; Wed, 17 Jul 2024 08:11:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Wed, 17 Jul 2024 08:11:03 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 03:11:00 -0500
From: Akshay Gupta <akshay.gupta@amd.com>
To: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux@roeck-us.net>, <gregkh@linuxfoundation.org>, <arnd@arndb.de>,
	<naveenkrishna.chatradhi@amd.com>, Akshay Gupta <akshay.gupta@amd.com>
Subject: [PATCH v2 4/8] misc: amd-sbi: Add support for mailbox error codes
Date: Wed, 17 Jul 2024 08:10:23 +0000
Message-ID: <20240717081027.2079549-5-akshay.gupta@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|SJ0PR12MB6903:EE_
X-MS-Office365-Filtering-Correlation-Id: d5bfae46-7838-4643-c5ca-08dca6380058
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6sNHNluVcDwfpEVuQ76PoCGxZjvhBFvQ/moqXFExha6RYd5xN/1q33IVTVIk?=
 =?us-ascii?Q?5ur/BWjA9XfmianWE4LnhWvbS8XVXEKPr0kvhMRshgwzNuBNPNifcsKOCF/n?=
 =?us-ascii?Q?/liQxe57EDMmVXupxsysKhtbbg9FGgCHAIR5JaEZDUFQatKNAY6013gdw+VK?=
 =?us-ascii?Q?LDQjAOgCUZB9HX1d9GaMQ1xxKr6dSFcZaBHbC1ztFymlE10I1nAupPfSafWa?=
 =?us-ascii?Q?KkM50UFMjPk928OfD+ICj4Mw81iOrCY/nA/WndGKmkngsVMX6qRUnqfCMyKb?=
 =?us-ascii?Q?juYhrdeDEcaHKIt2rzhnpqLZ2rven8Eq56zPI8l9X2j6XOfE9WjUgsKLH7Th?=
 =?us-ascii?Q?fKZNTIOJ9VDOV5NzKAq5rmootI/T0LykHdqRFxvV5zXtAGpVLiZq79i05pGV?=
 =?us-ascii?Q?ZWgXoqkBptL0xPpQHx6ySGEL83p602IvSqyqd7XvttyZ3XhCLtd5Rku9zN2I?=
 =?us-ascii?Q?fy4Nd1ZJo76gnC5T6Sbt1vXMAzy77pSevA8C9jZYd/kT2TX0t6JyomgQ3oiU?=
 =?us-ascii?Q?a7K3QYsCrrl3mfhbZmJ/a9BK1GynlWqdUKZGRIxEFUoE20fRLTHB9s8wIY78?=
 =?us-ascii?Q?nOiDmbw4HR5+zXlKqHWhP1kpG2yg0Hv1N6i7N6LfY828qsRJZ2/2YArqYEMX?=
 =?us-ascii?Q?ZnamGqp2Cj9wLfUWsz1W359wm8YgL4P8mJ2qmQevOesXmow2Y93fXUykVD0C?=
 =?us-ascii?Q?zvyb97GrwspgZBnkxD4ElIINJ2CCpU+8FBIhOl8ERCcLp6/E+VJ7mFeNxHQT?=
 =?us-ascii?Q?1ysyA+ByauChP5l08O1ZVdNf4nL/0qvB7M5jt1W/cm+fQZJNCOzdk5nb7ei5?=
 =?us-ascii?Q?U/ycuWMOqTR3Iwpu0RlYOMpHd+J8e4o4DLYJPiITcLJYP4IJ6HIR3RiNBfTI?=
 =?us-ascii?Q?TOYGHNurDfHoe9wq2I0zv2Oa3Hk9NPrcWsv0I/kLo1S3CsVx4bshJVLJiiHL?=
 =?us-ascii?Q?rZgsxxkXEsc1fnbhsOCVHkI/Ni0jfoxWDIFce5XF5rBukpukomoqvovOudsj?=
 =?us-ascii?Q?kSMvVpCzXQ9XelkiEfQCZi+LJ3GrJi2exG3VpT/n/J8e+PyhKq3D6erPsklY?=
 =?us-ascii?Q?c+O95HJzEA426ypgoxAbt+iVPxQ5NHW+pf84TiyCXaf2Kxd85xyxUBE84H7o?=
 =?us-ascii?Q?FHcvvnmw/MMcj6/M0OrvCOp8kJnmHul6S+9NxREJPNdaDgl5qBH5+66EvWlt?=
 =?us-ascii?Q?K+cxDReRt7g/ycXDqy9mx/JPMKwFxpUOVo4TQcVKQyhC7HJ1TIkv0gddd9fV?=
 =?us-ascii?Q?PoY9cxjEkekishwIsQfEn1FM71f2O6MUlAmclLI/1iZzaUtYE9hsodbBra26?=
 =?us-ascii?Q?tMut32dkiHmLxds9KfArf9u8Yq7qv3bqNWoqnVhM/I4IcwHcK9ApDkoReoip?=
 =?us-ascii?Q?skKUJCCQLvfs17Wan+PL3brY0Fnae8v+qLCWeNFXdnPx1ADRVLU8zxr307V2?=
 =?us-ascii?Q?5cMZoBh8Mmm1zDv/pWdV4bQGXRCkUf+c?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 08:11:03.3027
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5bfae46-7838-4643-c5ca-08dca6380058
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6903

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
index e7778749940e..01c3a6c9c15c 100644
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
index 81e505eccac4..06e93a6a8f4b 100644
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


