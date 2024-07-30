Return-Path: <linux-kernel+bounces-267070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF1C940C08
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 10:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 342B31F26729
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 08:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860F7192B91;
	Tue, 30 Jul 2024 08:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VKY3BJfJ"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2066.outbound.protection.outlook.com [40.107.212.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDB6192B75
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 08:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722329029; cv=fail; b=TirLvJGFzXji77oiWPdik6c1v8lQzphPq7Z3M1lz/WdfE29SLSkGF3ljfv7KDrXM4RFnxu2LJn92FAQyveXRlzqv1MRbYRCv4X/TJTP7WfDxQZs5zo/G9rj9V6JsipAZwq2ey72vgPZRKNuoFyM4haJRAR0vvL9zHii1FWcWjF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722329029; c=relaxed/simple;
	bh=aDwiBwqmgEKAynneGpzJ+S7n4xFZcIFHIyfPJPcKpQA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sWh6lic2CcrH7sbIiOjl9qy4TJ3ZDwKGinWWzA7iFyJ2AcscKIZwaVuZYyC8rBvkZZQPV8qGLSrUtj3MGOWTeaDZTIBcFbfmBgrNAZv8gvkEOF2rHOJqQQdbrCWsTnlr5T6rFEmqfERkY0HKxIR3EWt0wBEYvU7Ma+e3KUw9Qz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VKY3BJfJ; arc=fail smtp.client-ip=40.107.212.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h0RRxTEfJYl5fAvv60ndWUTSCmZejAwJZ/yz7Hs72m9UYB5mp3meZMl9ovSvWewqyaqzzP7WK7ZMFSb7lbWMVbWl5lwy0kCxOi4g+l0d+3uVAvmliFfFlKBertoCmSuR5pwTK5PE9e7mXsBs0fbpZXds14F80olN8unA+O9aWgFGLeCtJW3MKrFQpMBzpIY6UAl34BKb6f6ypABPNl8AiJe48JcKuueIH3juT/YtDZyk8teRMDqmnhKpbm3dtT9ipWt8f364i7mwUY6RpDUkVijFr0RsyQhLbArDNYdO6NdpsWWItyPZtBb9SpskIyH7mshJ9y9vJx4rXDZDpPQBDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oYl0m9oE8MfxxMXv9D1fdn2frJNhn/3iIhlnIh5jj78=;
 b=bWMguABZc2S1wSgfDVJEAFWIAuLGjV9Q9H9AzW8S9T9YRLTxk0g+wjF433cAfB6uzUWkwQjcO+KgdcddHuAL8IWpYRaY/fiKY8K47oDfjyqGJ5nhpemwGSVKgJX9OpksLCU9PXSuKhxdH4zJoXejEUsbc3IhgnOWsV4uzhZxN01anbfHEOtOWFtX2QbmdI9D/jqHw4crhmaJxjz5sLrY6xZMJawwWIB/AdblkEX1bKqGimL43oF9OWYZ6MSRtVtPuYaE8pMAGiD6z/fqTrkxv7QK6av3CvbiCVa/osDg8HmaIHmGct1hJanyFOD1DtnWOZt+VSN9zbwr1SjyuEpqjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYl0m9oE8MfxxMXv9D1fdn2frJNhn/3iIhlnIh5jj78=;
 b=VKY3BJfJrVrae+anxNG3JMQZpKmDydowbLTF8u7GkhA6BTM1zRWqxNE0TzHVy4CxEmJGdfs207MBStf1qnaeWgGc7rczNh+YUQj0ne1rdg0mguv0J8NjyqhSbU4MiK+D1tQ84kASReHcqnEpXzlUj6QPgnJETXzy+c1m6VvYzg4=
Received: from BN9P220CA0027.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::32)
 by SA1PR12MB7176.namprd12.prod.outlook.com (2603:10b6:806:2bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Tue, 30 Jul
 2024 08:43:43 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:408:13e:cafe::34) by BN9P220CA0027.outlook.office365.com
 (2603:10b6:408:13e::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Tue, 30 Jul 2024 08:43:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 08:43:43 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Jul
 2024 03:43:42 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Jul
 2024 03:43:42 -0500
Received: from xsjwillw50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 30 Jul 2024 03:43:42 -0500
From: Ronak Jain <ronak.jain@amd.com>
To: <michal.simek@amd.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] firmware: xilinx: Add missing debug firmware interfaces
Date: Tue, 30 Jul 2024 01:43:42 -0700
Message-ID: <20240730084342.1683231-1-ronak.jain@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|SA1PR12MB7176:EE_
X-MS-Office365-Filtering-Correlation-Id: 65fb606e-1571-44f6-cc6f-08dcb073b7f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7fZHlXj0qUZnVSaEd5GUcrhOa7kJ81nQSDcuG9XLFk1XNfLXnvbQqb2CoPO2?=
 =?us-ascii?Q?4SYzEA2iJzy2h0VEuZql450RJE9gP8/Ap1nvV66rHqoRWAFwET6QatXKWwbf?=
 =?us-ascii?Q?1RENzUT2MP9MjHs7e0chbwo2mNYyQXjRti8nPm2q/KLwld5Y4uCLh+weosgH?=
 =?us-ascii?Q?+1LFRgl2KjA8tn5HmFE6sJyLlPCB+j9bE/wCpFt0Uc6bDH0UbCbHQ62dlff9?=
 =?us-ascii?Q?aozmZHX9YmvIphte14WKUNoIKelXCNw3yLLmwKhIp6xn9j9SGBt3npqSGBcF?=
 =?us-ascii?Q?a5oO4PPfsuUI4NBp39zD2Yz1W41YMUPduwdIRV0CykRK5V4NDP4xBhr/RK3O?=
 =?us-ascii?Q?1ahAWXQMKluIMLWa3gTAYytNOb7Hnyg5dm/SNo9pilz/uhpYJqq15h5jEew4?=
 =?us-ascii?Q?gax34CEc2ZMPrderHecrkTaThyJCbi2ZsKFxjWjDDrqKVsivZz6wuBB3DQGY?=
 =?us-ascii?Q?iXa3Zk6AGxQ8dB3HUT/ff9mMO3Y/xzPQXFntgM5JjzHZBke1a0iDeIjSJ1f0?=
 =?us-ascii?Q?0orfeVnwFJVgLVcSes4WPDxwTApnVhu/7IvUzH5027mRoFUI2KpA1zszQHUg?=
 =?us-ascii?Q?sgh85a2SNYvO96CcMZtit/mgpmqZRK84qZ5UsbbMLRp0h9jGn1nO+by6Ww2G?=
 =?us-ascii?Q?7XL8n+205YXbHfXqlxtHQIi33rZsU/b7I8UBLgXn5YPnkELe1POBKZBh7xbX?=
 =?us-ascii?Q?JzWa7w6tGqAs7LzijmgjwFzeZdFweE/3LQ+SuYyk07Qq+NqCIG8Vz309+OPa?=
 =?us-ascii?Q?2AsIxfXJpR66Ob2Z103/h1V1CnaN5NomASvBFysrzuc2ZeiKW3RVn7DOd0dc?=
 =?us-ascii?Q?MQbQrJYK0Hn1aE/A6CmqKE5TgPhTGmOaaomRx2OAh3JnUjSIuD5tTO8D5tYt?=
 =?us-ascii?Q?o16o+JPnzxuJ6DOAb0vgs5E1fZeyY5flvWdybWsaXfetSx+7kloHkmHh4tQa?=
 =?us-ascii?Q?SURlHBTIw2N7Q48+WAwvINoy5dbHfx1nucxrOGqnhxGv1NRBDw6pGeFmU8br?=
 =?us-ascii?Q?0pXiFbmsWp55B1BPeIQaPYbrZNHjD3CrlUX4lXwEDurUz+B3XY9twT7a3RII?=
 =?us-ascii?Q?MwuzK0uHAiq9Riwq84zF+uYhD171048ZaWk/0mgnKSdiN8BIB+zb4OfHXrGS?=
 =?us-ascii?Q?+b6mTy0zCH+15aJAllsh/ppH2ZjkCI62mmoODCslirfRLQTfqBf8U7rt19pZ?=
 =?us-ascii?Q?/UqaOnD4fDv1+dcGwSBeW0r5bEnULnIwZD3r503+LxQEUrMWSUINJKvgMgVW?=
 =?us-ascii?Q?7zf+278yIroVUcig1rPYjCtbEtji9+vMAp7H+lKU9Z7jdZq/FdHHylCbMRF7?=
 =?us-ascii?Q?5y+9TE8a8EwSCpRcS+uuzi5O151ePd0N5IbxBgY8FlrB9Zj0Lh/EOFF3rT9Z?=
 =?us-ascii?Q?9S1LLhzvF6HI81ltCk0TB+ex84EbRjA05apnqxe/fe4+s5hzEQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 08:43:43.3315
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65fb606e-1571-44f6-cc6f-08dcb073b7f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7176

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
Changes in v2:
- Address the compilation error

References to the public documents who talks about the debugfs 
interface.
https://xilinx-wiki.atlassian.net/wiki/spaces/A/pages/18842232/Zynq+UltraScale+MPSoC+Power+Management+-+Linux+Kernel#ZynqUltraScale%EF%BC%8BMPSoCPowerManagement-LinuxKernel-Debugfs

https://docs.amd.com/r/en-US/ug1137-zynq-ultrascale-mpsoc-swdev/Debug-Interface
---
 drivers/firmware/xilinx/zynqmp-debug.c | 162 ++++++++++++++++++++++++-
 include/linux/firmware/xlnx-zynqmp.h   |   4 +
 2 files changed, 165 insertions(+), 1 deletion(-)

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
 
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index d7d07afc0532..563382cf16f2 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -218,9 +218,13 @@ enum pm_ioctl_id {
 	/* Runtime feature configuration */
 	IOCTL_SET_FEATURE_CONFIG = 26,
 	IOCTL_GET_FEATURE_CONFIG = 27,
+	/* IOCTL for Secure Read/Write Interface */
+	IOCTL_READ_REG = 28,
 	/* Dynamic SD/GEM configuration */
 	IOCTL_SET_SD_CONFIG = 30,
 	IOCTL_SET_GEM_CONFIG = 31,
+	/* IOCTL to get default/current QoS */
+	IOCTL_GET_QOS = 34,
 };
 
 enum pm_query_id {
-- 
2.25.1


