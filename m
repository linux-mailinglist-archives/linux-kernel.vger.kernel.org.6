Return-Path: <linux-kernel+bounces-333984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9F297D103
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 07:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A6FF1F21DED
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 05:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED9928E0F;
	Fri, 20 Sep 2024 05:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="e0OonX4S"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8173C3BB22
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 05:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726811709; cv=fail; b=NnXabnyqr7k68p/4HL1Kwm/aioCzwFOemruWCkLETHbqHYwFkjTnuET1vaKQeN5QTGMOTQ0ts9kF8EAJsnaCuW9slyKxZ1S4HJlKUBC23n5mwfTbVeG+XsyeI1DXbK4S7LZTfhizM3/z59E5WMaj26TEcU5zdDrHvl/zJFly1p4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726811709; c=relaxed/simple;
	bh=vLNsl/e04tlJhD9vsr13TFZYoxmGdLfXA7U5pbFzvco=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pO4oX/JIBGWHSeVjmnZW2BDP1BJB+rhgALmKTp+E+RSSe9Y82Xc0UUAImghehxIHKKiQMjlmHBxdYdOipVIl0/Gnr2D1kdqPz1vTa47+Q3ymbBOQnXUYRfWRlVoGTV9TANwfMY+iQ4d26E0rlt+zidSHBIizjLjru4BfnFidQgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=e0OonX4S; arc=fail smtp.client-ip=40.107.223.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=djiJZe0taEkm3+5fxuefcHMXLl0NGlisHQiGgpfVc4cVOEevc35S3Unw91hn6i0flrfAF7mLknM/P8SOp8BsxaaPQlzBqOFUGW/pgdB+0/4727pd3gs0m+2FqBPfzSvnghTTY/zlTmDqFqWKW9TpMQgVIif61nmJHAHNoh4o7n5XXBY67RQoVMvKmm5p2HqgvjU5AF/G6H7eZ4aFu+ZwQUEfUjjvQ+LQOh7mfHRT0V388zgE2X8/IXeR3CaIApg5LazdkJt68tHZ1RAEBP0vuTJTU2KaW1ESi4Wf9bIg5gmGUEturfyX5IOq5dicmi3GSCQcISjLKVYCkxPJceakrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xAgyXhMKBMB0Ldlvmfh4PJLfFI9/g/lsXUau1Kt+rJM=;
 b=dXuxru7OWgpmmaKuw/7kAz7sqMzW37dYABdF4TPeCSGyqE5/ebaqVSQvBPhSaViaBSlYvql/51aCSLE4ulVqSixxlMgxlF3WUnyE2Hfq2HvWe738juXTE3UtY+TgwL2IxaX3fIjhlavlelKRxnlbRJrzScrv4bR9X5zjU2BSRWynwSB4JbX6D0Idl1Av+D9a2VFdLfOUdn9yJD0a3y5CFBRgo4Lvfaik2k2lrRy6Y7SESc2fmjON2oZVblcfxtJ5q3BB6W4+afI4Md/wCTjXms3D4+qqUI3ZlnbQv+cRSzW8Zn5q7MKWdVhjmKxR0FDh9qQFdmpKgCn+rk/7vNLuTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xAgyXhMKBMB0Ldlvmfh4PJLfFI9/g/lsXUau1Kt+rJM=;
 b=e0OonX4S6W+FmmlW1JQlkdYmDc/uhnRqNua/L+x4xRkMEszleJ/pEZth1WkDSCC0+s/h1Lh+Z8tYgzdV4qPP3d1H7Ge3cTmmDfupQH4HWGuZM6TjE4lwn0sI10FzxedN4mgKkUJ9+nOPXb6v6x4wis13lV+GFMpmrYw1BiMQ4/k=
Received: from BL1PR13CA0352.namprd13.prod.outlook.com (2603:10b6:208:2c6::27)
 by CYXPR12MB9340.namprd12.prod.outlook.com (2603:10b6:930:e4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Fri, 20 Sep
 2024 05:55:02 +0000
Received: from BN1PEPF00004686.namprd03.prod.outlook.com
 (2603:10b6:208:2c6:cafe::a8) by BL1PR13CA0352.outlook.office365.com
 (2603:10b6:208:2c6::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.8 via Frontend
 Transport; Fri, 20 Sep 2024 05:55:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN1PEPF00004686.mail.protection.outlook.com (10.167.243.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 20 Sep 2024 05:55:02 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Sep
 2024 00:55:01 -0500
Received: from xsjwillw50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 20 Sep 2024 00:55:01 -0500
From: Ronak Jain <ronak.jain@amd.com>
To: <michal.simek@amd.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] firmware: xilinx: add support for new SMC call format
Date: Thu, 19 Sep 2024 22:55:01 -0700
Message-ID: <20240920055501.2658642-1-ronak.jain@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: ronak.jain@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004686:EE_|CYXPR12MB9340:EE_
X-MS-Office365-Filtering-Correlation-Id: b818f501-8a86-483a-4b52-08dcd938c4c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dEqEwxAI3BOSnp7DlOvg7TaeoUCODGaPAjdDMInzykxnzWsYl7OwYr0sd4+a?=
 =?us-ascii?Q?/YgDM8DKBCI7hI79NQ9wP0fZhgXs1a02qPTwhzN3ZLqON0DfmAwOVg7IvXO7?=
 =?us-ascii?Q?JNz/WHzbC6BnAg1dbqQ1YCgXtAoX4y9/8jVkjqRszaHfi7T5bgwDrdCkfyHM?=
 =?us-ascii?Q?6BJDPV4PU9THJMJrUiTJg4rmx0YRqU24wYQ7o53IVyPuyEQjCYhF+/WLoi4l?=
 =?us-ascii?Q?hA5p4A5Wiy/XbrFC3iFsL+mXkXd+DRyUP7L5nJ+Sg4Xl7O2SJAt9mSDUE9OT?=
 =?us-ascii?Q?es4I9YFkjFJZhYqtpojW+GzQNci84knLq5E57ZRaD/tNxznYCLyJD1EuDLKQ?=
 =?us-ascii?Q?mKmHCgYhqtkARiKu1lTs+mCDqOvNpdCpEKyMqf+97NY6x7jYVfHb6BFVK+e/?=
 =?us-ascii?Q?pdm2uZq0UaEgUcgm4npbbQ5k5/FtgcdjQJuY/UxlraxkQGMEPtU2rHQD20pi?=
 =?us-ascii?Q?T0OG0LK9LeKNvBGoEgSfD85/QhdVBJiynssKHnUUioHod0p18B+F9o5MyEbY?=
 =?us-ascii?Q?P6AwIP6Z0+89Sn2NvAVW+da0aRLbdlE9cvRuVSKcMBNBr4MV0feuoHfLQgR1?=
 =?us-ascii?Q?Tw5zW+Cgm7Z4/M8Teeq0o+74YaFE45vrNexPriDC2d9+uHmwA0tNsn9QkmSk?=
 =?us-ascii?Q?lwt82VFCoCadAzd9mIBaLcJM2+iFxpGJGuYiLOgnCS+AE45UP+0NiQVTwsSd?=
 =?us-ascii?Q?eDcqQWE7NJggsW9sOmfStMSdnqWQJV5Ga8kN3FpsE2Einp+PfMgXc5A0FFDt?=
 =?us-ascii?Q?DCI4cbPFOmXKsKdfZo8MgsckVhSsMlhH01oQEvXjp23a1GLI6qtBEX/2wli3?=
 =?us-ascii?Q?v7OVsdTfV7Pa7zTFdbOfSG0aeQu2aGduAhyd2NrEqt0fnh4CBO10iJJxyOrR?=
 =?us-ascii?Q?iobM5/Asd6j9c5eW8iTRIIOoCLilRNybVWH5kqXYrNH4znIlggvi5bRRHFro?=
 =?us-ascii?Q?ggBMsdKjyVejf+T+NGUE4Z59bsbt9wu1y1dSHaHCNDbQ5N23WQks9hAUo7qE?=
 =?us-ascii?Q?/SJ+fGZOxPCNFKTzg+iaVieyJTUoedii7cAlzF2JwSb8m2Tozt7O4cGrkVVJ?=
 =?us-ascii?Q?38CcdPhG8uRFilj4JF64i93Ln/muj+OVAcJxQSbHOxGuKuGmU8UiWPb/xMA8?=
 =?us-ascii?Q?cM330Dqnj4my/mbEG/A1/BR4aEh9uouKRGF+f3yALvnOC7lgL12PND/X6Oyf?=
 =?us-ascii?Q?zRUWpb0LLuefnHtEYyMyTbcghgb5O02MNqb+5p2Fqx3yaanqrXZwQB5VMuHd?=
 =?us-ascii?Q?68zReTyCGZcsMXeYW+Oy1BHTX11K6qr0VjgwZwH0h72ApebKJXSNTm41Pq5t?=
 =?us-ascii?Q?wSVyPdARvl5djoev4V/Go8jX68Sxs+N6IHg+KObpHUmYOtVdsYbRWQV/nBl3?=
 =?us-ascii?Q?wmMbWHOsKj1Ek+G7i/sYp/xUpiCgM49Rdjlykb6KqtLN1u2MRERRRvG+hLbV?=
 =?us-ascii?Q?tTzk5f+b1Tk/NYbsqDIVrh66eZyh12wN?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 05:55:02.1934
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b818f501-8a86-483a-4b52-08dcd938c4c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004686.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9340

Added zynqmp_pm_invoke_fw_fn() to use new SMC format in which
lower 12 bits of SMC id are fixed and firmware header is moved to
subsequent SMC arguments. The new SMC format supports full request and
response buffers.

Added zynqmp_pm_get_sip_svc_version() to get SiP SVC version
number to check if TF-A is newer or older and use the SMC format
accordingly to handle backward compatibility.

Used new SMC format for PM_QUERY_DATA API as more response values are
required in it.

Signed-off-by: Ronak Jain <ronak.jain@amd.com>
Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 137 ++++++++++++++++++++++++++-
 include/linux/firmware/xlnx-zynqmp.h |  26 ++++-
 2 files changed, 157 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index c8be32d9c6af..5ab0dfb2b225 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -3,7 +3,7 @@
  * Xilinx Zynq MPSoC Firmware layer
  *
  *  Copyright (C) 2014-2022 Xilinx, Inc.
- *  Copyright (C) 2022 - 2023, Advanced Micro Devices, Inc.
+ *  Copyright (C) 2022 - 2024, Advanced Micro Devices, Inc.
  *
  *  Michal Simek <michal.simek@amd.com>
  *  Davorin Mista <davorin.mista@aggios.com>
@@ -46,6 +46,7 @@ static DEFINE_HASHTABLE(pm_api_features_map, PM_API_FEATURE_CHECK_MAX_ORDER);
 static u32 ioctl_features[FEATURE_PAYLOAD_SIZE];
 static u32 query_features[FEATURE_PAYLOAD_SIZE];
 
+static u32 sip_svc_version;
 static struct platform_device *em_dev;
 
 /**
@@ -151,6 +152,9 @@ static noinline int do_fw_call_smc(u32 *ret_payload, u32 num_args, ...)
 		ret_payload[1] = upper_32_bits(res.a0);
 		ret_payload[2] = lower_32_bits(res.a1);
 		ret_payload[3] = upper_32_bits(res.a1);
+		ret_payload[4] = lower_32_bits(res.a2);
+		ret_payload[5] = upper_32_bits(res.a2);
+		ret_payload[6] = lower_32_bits(res.a3);
 	}
 
 	return zynqmp_pm_ret_code((enum pm_ret_status)res.a0);
@@ -191,6 +195,9 @@ static noinline int do_fw_call_hvc(u32 *ret_payload, u32 num_args, ...)
 		ret_payload[1] = upper_32_bits(res.a0);
 		ret_payload[2] = lower_32_bits(res.a1);
 		ret_payload[3] = upper_32_bits(res.a1);
+		ret_payload[4] = lower_32_bits(res.a2);
+		ret_payload[5] = upper_32_bits(res.a2);
+		ret_payload[6] = lower_32_bits(res.a3);
 	}
 
 	return zynqmp_pm_ret_code((enum pm_ret_status)res.a0);
@@ -331,6 +338,70 @@ int zynqmp_pm_is_function_supported(const u32 api_id, const u32 id)
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_is_function_supported);
 
+/**
+ * zynqmp_pm_invoke_fw_fn() - Invoke the system-level platform management layer
+ *			caller function depending on the configuration
+ * @pm_api_id:		Requested PM-API call
+ * @ret_payload:	Returned value array
+ * @num_args:		Number of arguments to requested PM-API call
+ *
+ * Invoke platform management function for SMC or HVC call, depending on
+ * configuration.
+ * Following SMC Calling Convention (SMCCC) for SMC64:
+ * Pm Function Identifier,
+ * PM_SIP_SVC + PASS_THROUGH_FW_CMD_ID =
+ *	((SMC_TYPE_FAST << FUNCID_TYPE_SHIFT)
+ *	((SMC_64) << FUNCID_CC_SHIFT)
+ *	((SIP_START) << FUNCID_OEN_SHIFT)
+ *	(PASS_THROUGH_FW_CMD_ID))
+ *
+ * PM_SIP_SVC - Registered ZynqMP SIP Service Call.
+ * PASS_THROUGH_FW_CMD_ID - Fixed SiP SVC call ID for FW specific calls.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+int zynqmp_pm_invoke_fw_fn(u32 pm_api_id, u32 *ret_payload, u32 num_args, ...)
+{
+	/*
+	 * Added SIP service call Function Identifier
+	 * Make sure to stay in x0 register
+	 */
+	u64 smc_arg[SMC_ARG_CNT_64];
+	int ret, i;
+	va_list arg_list;
+	u32 args[SMC_ARG_CNT_32] = {0};
+	u32 module_id;
+
+	if (num_args > SMC_ARG_CNT_32)
+		return -EINVAL;
+
+	va_start(arg_list, num_args);
+
+	/* Check if feature is supported or not */
+	ret = zynqmp_pm_feature(pm_api_id);
+	if (ret < 0)
+		return ret;
+
+	for (i = 0; i < num_args; i++)
+		args[i] = va_arg(arg_list, u32);
+
+	va_end(arg_list);
+
+	module_id = FIELD_GET(PLM_MODULE_ID_MASK, pm_api_id);
+
+	if (module_id == 0)
+		module_id = XPM_MODULE_ID;
+
+	smc_arg[0] = PM_SIP_SVC | PASS_THROUGH_FW_CMD_ID;
+	smc_arg[1] = ((u64)args[0] << 32U) | FIELD_PREP(PLM_MODULE_ID_MASK, module_id) |
+		      (pm_api_id & API_ID_MASK);
+	for (i = 1; i < (SMC_ARG_CNT_64 - 1); i++)
+		smc_arg[i + 1] = ((u64)args[(i * 2)] << 32U) | args[(i * 2) - 1];
+
+	return do_fw_call(ret_payload, 8, smc_arg[0], smc_arg[1], smc_arg[2], smc_arg[3],
+			  smc_arg[4], smc_arg[5], smc_arg[6], smc_arg[7]);
+}
+
 /**
  * zynqmp_pm_invoke_fn() - Invoke the system-level platform management layer
  *			   caller function depending on the configuration
@@ -488,6 +559,35 @@ int zynqmp_pm_get_family_info(u32 *family, u32 *subfamily)
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_get_family_info);
 
+/**
+ * zynqmp_pm_get_sip_svc_version() - Get SiP service call version
+ * @version:	Returned version value
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_get_sip_svc_version(u32 *version)
+{
+	struct arm_smccc_res res;
+	u64 args[SMC_ARG_CNT_64] = {0};
+
+	if (!version)
+		return -EINVAL;
+
+	/* Check if SiP SVC version already verified */
+	if (sip_svc_version > 0) {
+		*version = sip_svc_version;
+		return 0;
+	}
+
+	args[0] = GET_SIP_SVC_VERSION;
+
+	arm_smccc_smc(args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7], &res);
+
+	*version = ((lower_32_bits(res.a0) << 16U) | lower_32_bits(res.a1));
+
+	return zynqmp_pm_ret_code(XST_PM_SUCCESS);
+}
+
 /**
  * zynqmp_pm_get_trustzone_version() - Get secure trustzone firmware version
  * @version:	Returned version value
@@ -552,10 +652,34 @@ static int get_set_conduit_method(struct device_node *np)
  */
 int zynqmp_pm_query_data(struct zynqmp_pm_query_data qdata, u32 *out)
 {
-	int ret;
+	int ret, i = 0;
+	u32 ret_payload[PAYLOAD_ARG_CNT] = {0};
+
+	if (sip_svc_version >= SIP_SVC_PASSTHROUGH_VERSION) {
+		ret = zynqmp_pm_invoke_fw_fn(PM_QUERY_DATA, ret_payload, 4,
+					     qdata.qid, qdata.arg1,
+					     qdata.arg2, qdata.arg3);
+		/* To support backward compatibility */
+		if (!ret && !ret_payload[0]) {
+			/*
+			 * TF-A passes return status on 0th index but
+			 * api to get clock name reads data from 0th
+			 * index so pass data at 0th index instead of
+			 * return status
+			 */
+			if (qdata.qid == PM_QID_CLOCK_GET_NAME ||
+			    qdata.qid == PM_QID_PINCTRL_GET_FUNCTION_NAME)
+				i = 1;
+
+			for (; i < PAYLOAD_ARG_CNT; i++, out++)
+				*out = ret_payload[i];
 
-	ret = zynqmp_pm_invoke_fn(PM_QUERY_DATA, out, 4, qdata.qid, qdata.arg1, qdata.arg2,
-				  qdata.arg3);
+			return ret;
+		}
+	}
+
+	ret = zynqmp_pm_invoke_fn(PM_QUERY_DATA, out, 4, qdata.qid,
+				  qdata.arg1, qdata.arg2, qdata.arg3);
 
 	/*
 	 * For clock name query, all bytes in SMC response are clock name
@@ -1887,6 +2011,11 @@ static int zynqmp_firmware_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	/* Get SiP SVC version number */
+	ret = zynqmp_pm_get_sip_svc_version(&sip_svc_version);
+	if (ret)
+		return ret;
+
 	ret = do_feature_check_call(PM_FEATURE_CHECK);
 	if (ret >= 0 && ((ret & FIRMWARE_VERSION_MASK) >= PM_API_VERSION_1))
 		feature_check_enabled = true;
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 5b938fc2adad..76d85ad82ec0 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -3,7 +3,7 @@
  * Xilinx Zynq MPSoC Firmware layer
  *
  *  Copyright (C) 2014-2021 Xilinx
- *  Copyright (C) 2022 - 2023, Advanced Micro Devices, Inc.
+ *  Copyright (C) 2022 - 2024, Advanced Micro Devices, Inc.
  *
  *  Michal Simek <michal.simek@amd.com>
  *  Davorin Mista <davorin.mista@aggios.com>
@@ -32,6 +32,19 @@
 /* SMC SIP service Call Function Identifier Prefix */
 #define PM_SIP_SVC			0xC2000000
 
+/* SMC function ID to get SiP SVC version */
+#define GET_SIP_SVC_VERSION	(0x8200ff03U)
+
+/* SiP Service Calls version numbers */
+#define SIP_SVC_VERSION_MAJOR		(0U)
+#define SIP_SVC_VERSION_MINOR		(2U)
+
+#define SIP_SVC_PASSTHROUGH_VERSION	((SIP_SVC_VERSION_MAJOR << 16) | \
+					 SIP_SVC_VERSION_MINOR)
+
+/* Fixed ID for FW specific APIs */
+#define PASS_THROUGH_FW_CMD_ID	GENMASK(11, 0)
+
 /* PM API versions */
 #define PM_API_VERSION_1	1
 #define PM_API_VERSION_2	2
@@ -51,6 +64,7 @@
 
 #define API_ID_MASK		GENMASK(7, 0)
 #define MODULE_ID_MASK		GENMASK(11, 8)
+#define PLM_MODULE_ID_MASK	GENMASK(15, 8)
 
 /* Firmware feature check version mask */
 #define FIRMWARE_VERSION_MASK		0xFFFFU
@@ -62,7 +76,13 @@
 #define GET_CALLBACK_DATA		0xa01
 
 /* Number of 32bits values in payload */
-#define PAYLOAD_ARG_CNT	4U
+#define PAYLOAD_ARG_CNT	7U
+
+/* Number of 64bits arguments for SMC call */
+#define SMC_ARG_CNT_64	8U
+
+/* Number of 32bits arguments for SMC call */
+#define SMC_ARG_CNT_32	13U
 
 /* Number of arguments for a callback */
 #define CB_ARG_CNT     4
@@ -130,6 +150,7 @@
 
 enum pm_module_id {
 	PM_MODULE_ID = 0x0,
+	XPM_MODULE_ID = 0x2,
 	XSEM_MODULE_ID = 0x3,
 	TF_A_MODULE_ID = 0xa,
 };
@@ -537,6 +558,7 @@ struct zynqmp_pm_query_data {
 };
 
 int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 *ret_payload, u32 num_args, ...);
+int zynqmp_pm_invoke_fw_fn(u32 pm_api_id, u32 *ret_payload, u32 num_args, ...);
 
 #if IS_REACHABLE(CONFIG_ZYNQMP_FIRMWARE)
 int zynqmp_pm_get_api_version(u32 *version);
-- 
2.25.1


