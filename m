Return-Path: <linux-kernel+bounces-248579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A27692DF3A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 06:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A2E628440B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 04:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6C14084E;
	Thu, 11 Jul 2024 04:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="paKKDXwm"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2BB15AE0
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 04:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720673818; cv=fail; b=lzKsFK/SIMC2bmE20OldzYHsBumQSYPl7ggO23V8t7q7kJRtIG61LtqE2U+AhOcJDg4rcnhS+D5JWwsa94y4b2sy1uvdD3Cp/kbNWrkQO1r8alTRH6eHemMHciGoQaPMi2V3giOszDavXbdKxnZ7O9QPWM/QKaU/A38ecpo61Cc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720673818; c=relaxed/simple;
	bh=YqSJrvcMhhg2YaJLpfXuuEe0j36+q3ZG/uvyOjXrO10=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IWbcE2AURBs563dmaCCKuKNEI5ouYhcXsen9E6UTZdcFdza3NTla6ymy4UKy44GdcnVUxZof6uh/tDIypPgMd6smHpKm5FG4sEtODgnQdz0IWYQmGMhu3mQtz6KQ2KYsT9Vvt7SaEBitSuPGP7pHoKxzkeecwmN1dsTNDdTAzCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=paKKDXwm; arc=fail smtp.client-ip=40.107.244.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XTtpPCoreXUw08M1CPjkBE8cCWK5sYHipg6iNHioY7odUqOrIMBX1bmvI4GwvLRMhJ+uqAInxapYz7jfhJBOxI9Vv4GJFAluqoARGkyKhPa4zarcb2nvPEXnXVRmV2G1bVW0LbPzwSB3Vutglgmr5zuXetqknKrsupR5ynOn7Vm9H4EQxtCFjtPrNPGEsuyASlQetKJ2lrkFWcamxtRtG61+VtleEBZXOssCG40OZFfDs0q9+fT8aypc4Ce9oI3KXN5OUQmSUY7LU4TFNv/wWgVdbH0ZMSZopVadHB2NhwMqZhrsNY4xC4vN7lkp+gj23h9fN8tpBWwUhENouJ5Ucw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t336mXAzUiPWeuqNKurtKMJCxfRLVWSGaqHKSNtVKlY=;
 b=XQH4Dw9mRpWO/CPOT8uAJbTAsMtjcEucgeQf4fAYVilkYXOCe8tblUFduWqT+PMpBfFl70g9FseM+TCpLgTqb6Gh8GRzWdIymtyPm1XKAwZK4XCWMz1ojLxqDUPRp7+lUeAW1JvPADcXVTPYxQPf2Jdkiumhip0t7szaWjUHtlKlb3QYPVRTxma72sdvbmnLkjAJW7607Nh3ETwGSYrmVdyd5TH1vfYxTNT3NvS913FWM7WzSCDH7mfoUxp8ku535X+WKEqrhPK0f+MoLNN77GYKQ1ikfSss3ZseVLWfc7RyqleZ5WccPfP+irM6cQWdB6j0F1TGYjyOeLRqLozNGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t336mXAzUiPWeuqNKurtKMJCxfRLVWSGaqHKSNtVKlY=;
 b=paKKDXwmPwfIEIF7WqlsKnW2SCzFtt6X8R4tO+4tUPfF4MrM4XzFf0B0cJCnqOuhWp3/BC54nl8FBxgE0tlcIzfmxZEN2o5vqx7RIRaymxouQA58MeO553vVV+grcRXZB/x+bNErn9nb0BXuSM01gyxSMgEzE1esaII1QmJ/pIw=
Received: from BL1PR13CA0113.namprd13.prod.outlook.com (2603:10b6:208:2b9::28)
 by IA1PR12MB7685.namprd12.prod.outlook.com (2603:10b6:208:423::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.40; Thu, 11 Jul
 2024 04:56:54 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:208:2b9:cafe::b) by BL1PR13CA0113.outlook.office365.com
 (2603:10b6:208:2b9::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20 via Frontend
 Transport; Thu, 11 Jul 2024 04:56:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Thu, 11 Jul 2024 04:56:53 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 23:56:52 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 23:56:52 -0500
Received: from xsjwillw50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 10 Jul 2024 23:56:52 -0500
From: Ronak Jain <ronak.jain@amd.com>
To: <michal.simek@amd.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] firmware: xilinx: Add missing debug firmware interfaces
Date: Wed, 10 Jul 2024 21:56:51 -0700
Message-ID: <20240711045651.3309975-1-ronak.jain@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: ronak.jain@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|IA1PR12MB7685:EE_
X-MS-Office365-Filtering-Correlation-Id: 555ed781-9c80-4510-0933-08dca165e1c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kWBj4IVKo6Lvh7szQ11PtG42k2WzxAB75g1N1GIiP/fQfCm5zFEKB1ARJrra?=
 =?us-ascii?Q?T5bTecubwNWKqxXBVSY+x/UGPLB/HpubEc0dY+ObMpzxDhft2koh4N3YQ59c?=
 =?us-ascii?Q?GUxArt78fhzK2TZxC2aMYlU+/Ymlaqj/3J7TIdQPBn8YcBC284XVgMm/EaRN?=
 =?us-ascii?Q?bUTxrvzx9UVx+xFYy2VxsLy77QydLdMu3cQ9ZmjZTW5fcuI47k7nxOIVhTWz?=
 =?us-ascii?Q?MKmF2fafJ8fNnpWgBD0L0brK1m2+CWBFJbryqQMiFHK70CB46I681sqFt+Vx?=
 =?us-ascii?Q?sVrtbuAAxptRbrFEEnbxr5Vl3WUZZzlPRzJpiqENPTh4Vyw6a5jeHbqxLG2S?=
 =?us-ascii?Q?DfyUtPDlvrfsyHHAWvlKBs3mZ6Iz54FB5QiRYtTUOJ0WxpHpNxWTTkK4BmNC?=
 =?us-ascii?Q?T8eZQ1Hatm9TQ3JtwlV4YT0lWPUqghgZbJMCktofRl3FAABh7OIyKFop8mar?=
 =?us-ascii?Q?69AI17uhqHbIP8wzBQJUv55SJU+XNRQ8zjhcBu5bxiaBVnybnqfw50nYjCUk?=
 =?us-ascii?Q?wnbOKfQ6ZchzYpguTjefR7PoCfwpWnB55KHtETaW8gZzKrIjdLyij+9CH91i?=
 =?us-ascii?Q?2zXIlMYjTkV94KjY2Ab0xS9v7kYTrgnNsZ/oXMILQgj9jrnE0SZMHP84UpVx?=
 =?us-ascii?Q?vXMbC13RZc7rMZD2gCKz9DzQX8SSx2PJwgjuCU1AhladMxsanGgOg2xptQx5?=
 =?us-ascii?Q?4TNqU4PjSzNekD+SlIEKTE2CMyhVdP11OzVdxocLKTlniukWfX/mF2jHdWc3?=
 =?us-ascii?Q?F7EVF+YSnFT1ZSzMcIWqetttHnsRkeaVV8bpSJdA0n+WLXbzZQdbA6QNoXEK?=
 =?us-ascii?Q?JgoyhNpUuE9kacpUJKO/QP+eyfVCbPhI8u1/Y7MbUkGEcrALXDckH4fvu+4b?=
 =?us-ascii?Q?N0mIj736A7NZeZRUsbOATbG9kS0Mr7OIsxsXzB3tgs896UKHMlEX1D+dp7/+?=
 =?us-ascii?Q?RkNePnIQh6a4cHhRUT9XLxEz+PhrqfeK8Hch9/nrbsxlgprRNLtceytsv7dl?=
 =?us-ascii?Q?RopO9ov+h1HSPOoMwRkL2ST/fZSIrpU7kKBm7NCHOXAr2vqNGdT+cXfDy66a?=
 =?us-ascii?Q?NbrNqPov80K64XHZsI/Zloa7J75rcAOOQjGRRgBhoKEMrAFnPtHqkc32AqXW?=
 =?us-ascii?Q?OGMsmYzq/OB3IXs7x16ctRaWQDA0E64+UjRkO2LiuPYhI5zda7xDHNZ2RKCD?=
 =?us-ascii?Q?r9PqhyEz/1ePf4biauobvW20L3i4jzkT1p2XstnrJj+NYcW/NbdIUtAc/GyR?=
 =?us-ascii?Q?xyIgCAXCW0P/hlbgZGFvN4otgT/gxe386+B6JyaWNHc/MYMlhRsVLog352sv?=
 =?us-ascii?Q?impzNH6iYwiXRf/0EKqHLVYlbP6MYMDmZNZtitQZ4REnHtyJy1y06txClvQj?=
 =?us-ascii?Q?sok0CXH2yweCeQI0AXvP2AjeggemOhkbYUpigWkkRwQAQ3sXbw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 04:56:53.0960
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 555ed781-9c80-4510-0933-08dca165e1c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7685

Add missing PM EEMI APIs interface in debug firmware driver.

The debugfs firmware driver interface is intended for testing and
debugging the EEMI APIs only. This interface does not contain any
checking regarding improper usage, and the number, type and valid
ranges of the arguments. This interface must be used with a lot of
care. In fact, accessing this interface during normal PM operation
will very likely cause unexpected problems.

The debugfs interface shouldn't be used in the production system and
hence it is disabled by default in defconfig.

Signed-off-by: Ronak Jain <ronak.jain@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
References to the public documents who talks about the debugfs 
interface.
https://xilinx-wiki.atlassian.net/wiki/spaces/A/pages/18842232/Zynq+UltraScale+MPSoC+Power+Management+-+Linux+Kernel#ZynqUltraScale%EF%BC%8BMPSoCPowerManagement-LinuxKernel-Debugfs

https://docs.amd.com/r/en-US/ug1137-zynq-ultrascale-mpsoc-swdev/Debug-Interface
---
 drivers/firmware/xilinx/zynqmp-debug.c | 162 ++++++++++++++++++++++++-
 1 file changed, 161 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/xilinx/zynqmp-debug.c b/drivers/firmware/xilinx/zynqmp-debug.c
index 8528850af889..22853ae0efdf 100644
--- a/drivers/firmware/xilinx/zynqmp-debug.c
+++ b/drivers/firmware/xilinx/zynqmp-debug.c
@@ -31,12 +31,50 @@ static char debugfs_buf[PAGE_SIZE];
 
 #define PM_API(id)		 {id, #id, strlen(#id)}
 static struct pm_api_info pm_api_list[] = {
+	PM_API(PM_FORCE_POWERDOWN),
+	PM_API(PM_REQUEST_WAKEUP),
+	PM_API(PM_SYSTEM_SHUTDOWN),
+	PM_API(PM_REQUEST_NODE),
+	PM_API(PM_RELEASE_NODE),
+	PM_API(PM_SET_REQUIREMENT),
 	PM_API(PM_GET_API_VERSION),
+	PM_API(PM_REGISTER_NOTIFIER),
+	PM_API(PM_RESET_ASSERT),
+	PM_API(PM_RESET_GET_STATUS),
+	PM_API(PM_GET_CHIPID),
+	PM_API(PM_PINCTRL_SET_FUNCTION),
+	PM_API(PM_PINCTRL_CONFIG_PARAM_GET),
+	PM_API(PM_PINCTRL_CONFIG_PARAM_SET),
+	PM_API(PM_IOCTL),
+	PM_API(PM_CLOCK_ENABLE),
+	PM_API(PM_CLOCK_DISABLE),
+	PM_API(PM_CLOCK_GETSTATE),
+	PM_API(PM_CLOCK_SETDIVIDER),
+	PM_API(PM_CLOCK_GETDIVIDER),
+	PM_API(PM_CLOCK_SETPARENT),
+	PM_API(PM_CLOCK_GETPARENT),
 	PM_API(PM_QUERY_DATA),
 };
 
 static struct dentry *firmware_debugfs_root;
 
+/**
+ * zynqmp_pm_ioctl - PM IOCTL for device control and configs
+ * @node:	Node ID of the device
+ * @ioctl:	ID of the requested IOCTL
+ * @arg1:	Argument 1 of requested IOCTL call
+ * @arg2:	Argument 2 of requested IOCTL call
+ * @arg3:	Argument 3 of requested IOCTL call
+ * @out:	Returned output value
+ *
+ * Return:	Returns status, either success or error+reason
+ */
+static int zynqmp_pm_ioctl(const u32 node, const u32 ioctl, const u32 arg1,
+			   const u32 arg2, const u32 arg3, u32 *out)
+{
+	return zynqmp_pm_invoke_fn(PM_IOCTL, out, 5, node, ioctl, arg1, arg2, arg3);
+}
+
 /**
  * zynqmp_pm_argument_value() - Extract argument value from a PM-API request
  * @arg:	Entered PM-API argument in string format
@@ -95,6 +133,128 @@ static int process_api_request(u32 pm_id, u64 *pm_api_arg, u32 *pm_api_ret)
 		sprintf(debugfs_buf, "PM-API Version = %d.%d\n",
 			pm_api_version >> 16, pm_api_version & 0xffff);
 		break;
+	case PM_FORCE_POWERDOWN:
+		ret = zynqmp_pm_force_pwrdwn(pm_api_arg[0],
+					     pm_api_arg[1] ? pm_api_arg[1] :
+					     ZYNQMP_PM_REQUEST_ACK_NO);
+		break;
+	case PM_REQUEST_WAKEUP:
+		ret = zynqmp_pm_request_wake(pm_api_arg[0],
+					     pm_api_arg[1], pm_api_arg[2],
+					     pm_api_arg[3] ? pm_api_arg[3] :
+					     ZYNQMP_PM_REQUEST_ACK_NO);
+		break;
+	case PM_SYSTEM_SHUTDOWN:
+		ret = zynqmp_pm_system_shutdown(pm_api_arg[0], pm_api_arg[1]);
+		break;
+	case PM_REQUEST_NODE:
+		ret = zynqmp_pm_request_node(pm_api_arg[0],
+					     pm_api_arg[1] ? pm_api_arg[1] :
+					     ZYNQMP_PM_CAPABILITY_ACCESS,
+					     pm_api_arg[2] ? pm_api_arg[2] : 0,
+					     pm_api_arg[3] ? pm_api_arg[3] :
+					     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
+		break;
+	case PM_RELEASE_NODE:
+		ret = zynqmp_pm_release_node(pm_api_arg[0]);
+		break;
+	case PM_SET_REQUIREMENT:
+		ret = zynqmp_pm_set_requirement(pm_api_arg[0],
+						pm_api_arg[1] ? pm_api_arg[1] :
+						ZYNQMP_PM_CAPABILITY_CONTEXT,
+						pm_api_arg[2] ?
+						pm_api_arg[2] : 0,
+						pm_api_arg[3] ? pm_api_arg[3] :
+						ZYNQMP_PM_REQUEST_ACK_BLOCKING);
+		break;
+	case PM_REGISTER_NOTIFIER:
+		ret = zynqmp_pm_register_notifier(pm_api_arg[0],
+						  pm_api_arg[1] ?
+						  pm_api_arg[1] : 0,
+						  pm_api_arg[2] ?
+						  pm_api_arg[2] : 0,
+						  pm_api_arg[3] ?
+						  pm_api_arg[3] : 0);
+		break;
+	case PM_RESET_ASSERT:
+		ret = zynqmp_pm_reset_assert(pm_api_arg[0], pm_api_arg[1]);
+		break;
+	case PM_RESET_GET_STATUS:
+		ret = zynqmp_pm_reset_get_status(pm_api_arg[0], &pm_api_ret[0]);
+		if (!ret)
+			sprintf(debugfs_buf, "Reset status: %u\n",
+				pm_api_ret[0]);
+		break;
+	case PM_GET_CHIPID:
+		ret = zynqmp_pm_get_chipid(&pm_api_ret[0], &pm_api_ret[1]);
+		if (!ret)
+			sprintf(debugfs_buf, "Idcode: %#x, Version:%#x\n",
+				pm_api_ret[0], pm_api_ret[1]);
+		break;
+	case PM_PINCTRL_SET_FUNCTION:
+		ret = zynqmp_pm_pinctrl_set_function(pm_api_arg[0],
+						     pm_api_arg[1]);
+		break;
+	case PM_PINCTRL_CONFIG_PARAM_GET:
+		ret = zynqmp_pm_pinctrl_get_config(pm_api_arg[0], pm_api_arg[1],
+						   &pm_api_ret[0]);
+		if (!ret)
+			sprintf(debugfs_buf,
+				"Pin: %llu, Param: %llu, Value: %u\n",
+				pm_api_arg[0], pm_api_arg[1],
+				pm_api_ret[0]);
+		break;
+	case PM_PINCTRL_CONFIG_PARAM_SET:
+		ret = zynqmp_pm_pinctrl_set_config(pm_api_arg[0],
+						   pm_api_arg[1],
+						   pm_api_arg[2]);
+		break;
+	case PM_IOCTL:
+		ret = zynqmp_pm_ioctl(pm_api_arg[0], pm_api_arg[1],
+				      pm_api_arg[2], pm_api_arg[3],
+				      pm_api_arg[4], &pm_api_ret[0]);
+		if (!ret && (pm_api_arg[1] == IOCTL_GET_RPU_OPER_MODE ||
+			     pm_api_arg[1] == IOCTL_GET_PLL_FRAC_MODE ||
+			     pm_api_arg[1] == IOCTL_GET_PLL_FRAC_DATA ||
+			     pm_api_arg[1] == IOCTL_READ_GGS ||
+			     pm_api_arg[1] == IOCTL_READ_PGGS ||
+			     pm_api_arg[1] == IOCTL_READ_REG))
+			sprintf(debugfs_buf, "IOCTL return value: %u\n",
+				pm_api_ret[1]);
+		if (!ret && pm_api_arg[1] == IOCTL_GET_QOS)
+			sprintf(debugfs_buf, "Default QoS: %u\nCurrent QoS: %u\n",
+				pm_api_ret[1], pm_api_ret[2]);
+		break;
+	case PM_CLOCK_ENABLE:
+		ret = zynqmp_pm_clock_enable(pm_api_arg[0]);
+		break;
+	case PM_CLOCK_DISABLE:
+		ret = zynqmp_pm_clock_disable(pm_api_arg[0]);
+		break;
+	case PM_CLOCK_GETSTATE:
+		ret = zynqmp_pm_clock_getstate(pm_api_arg[0], &pm_api_ret[0]);
+		if (!ret)
+			sprintf(debugfs_buf, "Clock state: %u\n",
+				pm_api_ret[0]);
+		break;
+	case PM_CLOCK_SETDIVIDER:
+		ret = zynqmp_pm_clock_setdivider(pm_api_arg[0], pm_api_arg[1]);
+		break;
+	case PM_CLOCK_GETDIVIDER:
+		ret = zynqmp_pm_clock_getdivider(pm_api_arg[0], &pm_api_ret[0]);
+		if (!ret)
+			sprintf(debugfs_buf, "Divider Value: %d\n",
+				pm_api_ret[0]);
+		break;
+	case PM_CLOCK_SETPARENT:
+		ret = zynqmp_pm_clock_setparent(pm_api_arg[0], pm_api_arg[1]);
+		break;
+	case PM_CLOCK_GETPARENT:
+		ret = zynqmp_pm_clock_getparent(pm_api_arg[0], &pm_api_ret[0]);
+		if (!ret)
+			sprintf(debugfs_buf,
+				"Clock parent Index: %u\n", pm_api_ret[0]);
+		break;
 	case PM_QUERY_DATA:
 		qdata.qid = pm_api_arg[0];
 		qdata.arg1 = pm_api_arg[1];
@@ -150,7 +310,7 @@ static ssize_t zynqmp_pm_debugfs_api_write(struct file *file,
 	char *kern_buff, *tmp_buff;
 	char *pm_api_req;
 	u32 pm_id = 0;
-	u64 pm_api_arg[4] = {0, 0, 0, 0};
+	u64 pm_api_arg[5] = {0, 0, 0, 0, 0};
 	/* Return values from PM APIs calls */
 	u32 pm_api_ret[4] = {0, 0, 0, 0};
 
-- 
2.25.1


