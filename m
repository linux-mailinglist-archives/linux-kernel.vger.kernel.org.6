Return-Path: <linux-kernel+bounces-333985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8238E97D104
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 07:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A74611C210D1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 05:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331FB2B2D7;
	Fri, 20 Sep 2024 05:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FDmfhAe0"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1453D1F95E
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 05:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726811753; cv=fail; b=f7f+u5U8z9AbbHACxE9pNjbrCN0EFXrI5AYT44HERCXoNOhaVhASalDoAJd6DXIdciT9+rcP1bVeI8qmaaMOGh9ivqLka5DAonM4PS0NMffJn2k9i5hb6jgf52pSbq56aan8rqWq/mmT+ArreLR3M6SfUXAN52DS1uxdC36gU30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726811753; c=relaxed/simple;
	bh=WB7SJlFTb+SsQ0HANb8vV+lMY8Rg8Lx+2/AfIPHil0M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SvBaM4MYc2NatxEM4HbJN32liAyTmvf8CD7pHITdG+JKlCl7eY/sKBYLlSEcqAIEnU8yh/rS8WLUTZPPJGYdRZFWMMGrDT2Jh6KCnXnX0Ne9uTFDnmk4VYcX/DYvt53FjxPubbcgkWUHIeXA4vAww6rqL0tl1PIkks0zGZqSbdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FDmfhAe0; arc=fail smtp.client-ip=40.107.220.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yoTdf313aSjUXH+kSXp3/yaj5f2h4U8f3MT6pUUnmf9zJUKO5UMC+wXd+DqaiDL+PvZZ9uc7HBPpy1iWF5LEtbGTuVPN7HpLkd8gRHVqc1ByMHK/TeRzpuNi6Hx212K9ll7QEQ0b6UQokTCCcqJsg48PbcyWdgPANvY7JVObHPJQWr5QIMk3dT6zVPDDrviRUDJCkDJeyR0KbMlCjn2QWLOdXhhQVLqdb6qcVm1SE/gX5wEiC+jh+UQ3kXYqxRcuJzr6/p5Z3RvdeEUSR5s3WW5qUJEnFzbJ6b+/TmgJ3XvIJ8d6SoGxWFjl4qBI/acFEOC3XVs+HVEy/Sjp8gBf3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47XTNsDyl8+kL+jRjufp4akVyGY1gJk5zH5TCF53W9A=;
 b=B1TMgEw1U44B670g+7eYc8ZXkGSyN6W0RKhpJOsn2qUUGBZGNIrOH6a3AqFsxj9YGxxUnWPjddIg3+d57VKiFemGKCisfCod9z+EeDiD26SQVBrxGVQbvHD2ORtVSne7QpHILw3Th7L+UaAXks76WPF5d0Z7rVmsGOWQPnxvor6wI94ZV+2nMQFxc3EnZK9ZE7GwwOz8m/Pb/XQVxgj7LA8a5AeNGcNO3cuZjl4wAnXKfVHBt4/YjDmLdOqehHr4P6ZOIqfXY8duDpT6s0r7NpKXpo5j663JnfOGUiTZGvzBBZCAOV86wQA7zjJIr94Kq4Sn4j9MU71lVucQQ/NlaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47XTNsDyl8+kL+jRjufp4akVyGY1gJk5zH5TCF53W9A=;
 b=FDmfhAe086g5/i4UX/Smi6Mcx/T2nYGGBl1QxvOI3ui305LtAyv3foa9RqlyclhUUE3R5bsOGDzYm+vi36lZpBArgaPNl0c7sT7lY6iXER1R5+5L+WwOoZ7EkT9HKm/oikqYhCiTET84FAmTMiUF7XGJJJPvVg9sVMTBzlO/AVI=
Received: from MW4P220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::25)
 by SA1PR12MB7319.namprd12.prod.outlook.com (2603:10b6:806:2b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Fri, 20 Sep
 2024 05:55:49 +0000
Received: from MWH0EPF000A6732.namprd04.prod.outlook.com
 (2603:10b6:303:115:cafe::c9) by MW4P220CA0020.outlook.office365.com
 (2603:10b6:303:115::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25 via Frontend
 Transport; Fri, 20 Sep 2024 05:55:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6732.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 20 Sep 2024 05:55:48 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Sep
 2024 00:55:47 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Sep
 2024 00:55:47 -0500
Received: from xsjwillw50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 20 Sep 2024 00:55:47 -0500
From: Ronak Jain <ronak.jain@amd.com>
To: <michal.simek@amd.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] firmware: xilinx: fix feature check logic for TF-A specific APIs
Date: Thu, 19 Sep 2024 22:55:46 -0700
Message-ID: <20240920055546.2658783-1-ronak.jain@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6732:EE_|SA1PR12MB7319:EE_
X-MS-Office365-Filtering-Correlation-Id: d172a2f3-e10a-42c1-4813-08dcd938e091
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QYRyqDe/Of0zlQx69JHl2NNKSU10AL833yI8EdGZoYNEKVPrTVISJUb4qsTU?=
 =?us-ascii?Q?CbbaMrzaIkQNums1i9wYfcfFy6b+IYB87UAiME/DCJYWRbyvndy9fly+Rdo4?=
 =?us-ascii?Q?vnxaMHUC87CORqPD6ALs187kqqJYpG4kV+mlE2QJQ37JuOAb52UMhVC1uvbl?=
 =?us-ascii?Q?bXcO8iEOrapkWXliBPnS18jGcmuxwZY5WpZeqDAdnT+y382aoX9PnjWJUG+h?=
 =?us-ascii?Q?mz3WhZztw3pfzNI79mHHD1+d1q4iOjjCEI9ypeLAzpXADSDODWDI27EQF3Od?=
 =?us-ascii?Q?B8XUAkXhSbHXMs+01s/rLZVNFwdk93ksY+wF0aNv1uoF7u8UXUVB+rvXXL9e?=
 =?us-ascii?Q?/KMq0+3VbT9mbl9fTeU+Tcg06UK7+m+LFNMmWW0zIpj1sUwC8Wpwofosxl48?=
 =?us-ascii?Q?+2zul5naUPnhs08G4JT9lKkWvxGj1oKxXhnnOOJE2YI9OvmJYFxKssZAVhAw?=
 =?us-ascii?Q?uNc7EoBKHvQpw0qQX2UOvnB1i2ksmp/lxncU2anO3imaQG+eese0U56SkDOG?=
 =?us-ascii?Q?wjT2oOOtNbpsoaumtn0z+R0ySc0V/MtwqM0g5caaEaVrhXXP5x7x0kgeJfJW?=
 =?us-ascii?Q?CFa9mQGeBMI9NonYjj/KXX72uXRaaMCgfKg+Ko0WjiqbWPYKFN+bzWplv/pm?=
 =?us-ascii?Q?NwXwgfG7kCt8j7B4Zdr5iEQrKKOQ/QsNaU65CLjEV9DuxnC8zJNXUlEljl/j?=
 =?us-ascii?Q?aOC1T1iJTcljuQyVa8KK1GQc4IL2e5PfNSKHvdim7P5HA0CitCqwwm2uwzke?=
 =?us-ascii?Q?nSxTLOxpIQp8PmGvwigPwX2Xt/rO1U/Ha8u2uym42+s08VE/uS8vo0oFwbR4?=
 =?us-ascii?Q?g81h7JfInmzKqu0RJoFokIfL33yCwc332plN7JoBXU4iOe6VyNt3lQzCwTga?=
 =?us-ascii?Q?/0e9oBJnhy+jQ4jfjZ98s+EPetFWHwpCjGck6dTKsnhqLSYoe9lJjpWsk1My?=
 =?us-ascii?Q?qc196cnnR1TFEBq1cXdCCU+nBulgum5g3ZfxmdN+jHYQVI3FdBmeLv323KBS?=
 =?us-ascii?Q?dxpfzF7dY0a7Ho0Ss0stmrPuqBoKuEKBBuRHDKZJc12Szip+VY/Gy2vGBjxF?=
 =?us-ascii?Q?jNKeXpvm8LriYpR0qd1Tp5Q+saacpiEc0ZUO70Qn3RNaLkPljXVOfMUuzLx4?=
 =?us-ascii?Q?PotSWmhA943rJdNvzCs20W0lTV7ceCvZ+xhJNyOwkrelL5UmF6kBLe/VSPxA?=
 =?us-ascii?Q?8Bed7vhz/4RhXbkW3xjxMKEAfVfLnw/FrSukckxKRsUX4WhZBimCa3ZCUNEL?=
 =?us-ascii?Q?VjdAd1SMissv/eRKtj7lblk9kZkGH1EToNmN7tccen9F1yzHgRNGKRovmhub?=
 =?us-ascii?Q?Bd91VqetT3UltLpDVbqlrVvN18a2YBy/DbHoBrh0/Tjw1IDif1MOiHFlV8Gw?=
 =?us-ascii?Q?eSgJglZHbc8j4QuDqzTM+auT2d0jAFHGrqvzHZiaEWJVd0POPQAHQrgnifQj?=
 =?us-ascii?Q?FIgOo+lXaztEQGQkzxDEnDiS3rxKvLeH?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 05:55:48.6906
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d172a2f3-e10a-42c1-4813-08dcd938e091
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6732.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7319

Currently, Linux is passing only API ID for feature of TF-A specific
APIs but for feature check of TF-A specific APIs, TF-A is checking
for Module ID + API ID as a result incorrect version is received for
all TF-A specific APIs. So, fix feature check logic to pass valid
arguments to get correct version.

Signed-off-by: Ronak Jain <ronak.jain@amd.com>
Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
---
 drivers/firmware/xilinx/zynqmp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 5ab0dfb2b225..0b2ad46c8bce 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -225,11 +225,14 @@ static int __do_feature_check_call(const u32 api_id, u32 *ret_payload)
 	 * Feature check of TF-A APIs is done in the TF-A layer and it expects for
 	 * MODULE_ID_MASK bits of SMC's arg[0] to be the same as PM_MODULE_ID.
 	 */
-	if (module_id == TF_A_MODULE_ID)
+	if (module_id == TF_A_MODULE_ID) {
 		module_id = PM_MODULE_ID;
+		smc_arg[1] = api_id;
+	} else {
+		smc_arg[1] = (api_id & API_ID_MASK);
+	}
 
 	smc_arg[0] = PM_SIP_SVC | FIELD_PREP(MODULE_ID_MASK, module_id) | feature_check_api_id;
-	smc_arg[1] = (api_id & API_ID_MASK);
 
 	ret = do_fw_call(ret_payload, 2, smc_arg[0], smc_arg[1]);
 	if (ret)
-- 
2.25.1


