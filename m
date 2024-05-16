Return-Path: <linux-kernel+bounces-180938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 526D28C752C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 13:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D07ED1F22396
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 11:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBC71459EC;
	Thu, 16 May 2024 11:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="n5swDIUc"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C93143896
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 11:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715858704; cv=fail; b=GnR860VyHpN7I/6KpRAjgudCjyh4A/6zNJ/q7OIsY3jZE6DKhOFZYNGC3VwdFTlZ15t8N0Qad/DSrujbugGffTBG4z3EdyAXERp/pdOFd7eOIeFHz0EhKyF1e1960mReEeVqsSb1llZoZw/zCECLSdcCQZdPHt4dN0tjQT55ibM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715858704; c=relaxed/simple;
	bh=mK+DRjZoLhjYjpSE3nFwV6JR/F39peg4avsjBJX13xY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AwtYrxoDnTLnMnL9mGKMlvUjIjkQg5PKwJcEf34f5zW5NWh9jjJJDgfNIHyM8Cx/i38B7zQ/bZyF7HKbfCyvUlKhSjQ9cFWdkiXxwWEELX6Jlpc23PBFt473KqQfeGrFph6/6YzNAsd+idp6hWZbNLTl1VBQAv3aJTKH2Wh79X4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=n5swDIUc; arc=fail smtp.client-ip=40.107.92.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OtDvouiraIU42ip1N2jLV2Dq2x21vdqh+vF6RitiZPg5K9qxBuhlXmWrVEBjLXl/jU5Gh/8AWVVFIrHTASX3maA8q5adrXqnUF+I5G+XDOse/UFUv5locdXalDoB5w4BA1hdtc6mvZxAjIMLpXgwDFi2RbIKAcE8C2GTOKWTtNkF8XoREmCqIEmLDBcTBRnOUD3GitGqcp6vNVr2hHNTTIdQWsYKvVHIOt3BDxI84n0ZdJtRGgPzETPMLoF/+9RaAgxwMp+pB4oYPWJfNopR6kL5SNGJklTap8tscdcuLHINoWYneLT72XOH1sOh+Ix1wjg59owQ0YdnfKU+/LonZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sWhYMdm8lOQiPflkUhg0HOmWZiWhzRPD21nupTrWFfc=;
 b=nbJ1Dt7Im5iLUQDIXEVbi/ikofoIllGfOOnmNP7laCU4mnBxks94smwIEAZvliN8AKOyGYbH9UokB5ntxDX58zxlF1zOCU9fzj+MhWcONKaKXMEHVIDSg4xv73sr8+vEebQ3fGTvUSR9Rwmannl2Hgi4oRBy4pDLi1M221XxYkhNVv87LZSseCZ9A7Tu5SUsCY4ROmVL1gEzKLFnVw3h7M5uwdXZinYnkC5kTvvn5o+Y35BDHOhsnBxpIYRK0tLSghBPu8yOOeNgreLgj97Y6NR2ezjUxXo6zYEHs7d3JrY+oOQP/dph40PjhbKyTvQFT+7QMpIyyTbqt5XQQ0Ou4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sWhYMdm8lOQiPflkUhg0HOmWZiWhzRPD21nupTrWFfc=;
 b=n5swDIUcKSmOd46TS0Bwv0y94XVPSkqlRpoEwqinS8ge5zMEl/ORd61V8e8C07hx0z9haJGKiAaZNAW9h6K/7O6fk6LaDGd9Xf/yQsPq8Pafa4nLxVFio1kikX0yImUDk4ZZVW8DdDvtlL4bRlevVZXnRuJNGKeDeoLpC9KqNRA=
Received: from BYAPR02CA0031.namprd02.prod.outlook.com (2603:10b6:a02:ee::44)
 by PH7PR12MB6978.namprd12.prod.outlook.com (2603:10b6:510:1b8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Thu, 16 May
 2024 11:24:57 +0000
Received: from SJ1PEPF00001CE0.namprd05.prod.outlook.com
 (2603:10b6:a02:ee:cafe::8d) by BYAPR02CA0031.outlook.office365.com
 (2603:10b6:a02:ee::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28 via Frontend
 Transport; Thu, 16 May 2024 11:24:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE0.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Thu, 16 May 2024 11:24:57 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 06:24:56 -0500
Received: from xsjpmteam52.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 16 May 2024 06:24:56 -0500
From: Ronak Jain <ronak.jain@amd.com>
To: <michal.simek@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH RESEND] firmware: xilinx: Move FIRMWARE_VERSION_MASK to xlnx-zynqmp.h
Date: Thu, 16 May 2024 04:24:55 -0700
Message-ID: <20240516112455.314898-1-ronak.jain@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: ronak.jain@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE0:EE_|PH7PR12MB6978:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f958394-6ec0-4af2-2b60-08dc759ad11a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EMrAFHmGBG9JQAU65CVi9yHr2A7upi66YxfNEKVnwlboPn6mqTBfAcbG6ePV?=
 =?us-ascii?Q?DCG4+Gu4k2aqH1XzwKR4CdupAa1zDssmd7l8q8/C201Zr1Qx0HhtBl2serZE?=
 =?us-ascii?Q?wqLb9Gl33U8Agt0UvFesAyvdbqBo5elRWtDrpDAmVb3Wja0EIjSOvTsEvEaR?=
 =?us-ascii?Q?mp0Mj96UJXS4XbRFe/DqYI5lihqE/UjSAA6JhYSJ6fQ5tKhYD+gY298M8Luc?=
 =?us-ascii?Q?cbaBiy2XiR9doducNXhxWz8XK2jG53pj/NfoECO3KDo7R6DnqN5Q03BDvqMs?=
 =?us-ascii?Q?Y+KC3Rvc42Ku638uv+yAEB2urf235e+y8a2E4es2d1tK51LEnX75rdb6zVOS?=
 =?us-ascii?Q?X/qE2JwdV4on4ntCSBL5eZnemxL60maUl+318eiabOy2oaK1wl0n4g4bEJiu?=
 =?us-ascii?Q?9z9upZ0880fuX//Njof7Dcn3EauHe74fpLUufaWMqV687qiG6sVg5CeIhZ3l?=
 =?us-ascii?Q?B18zye4N3pAF5ZHrKpPUqamRmtc77oFBgIlZ8Q+euXvRF6sXvrSBpIpY2WXy?=
 =?us-ascii?Q?67GSeixPbTz97seKtbVrxE0tbk3Hx8+BSomvyBZACudCWtXAjkd1COdkW4Jy?=
 =?us-ascii?Q?OqSQ7Uv5WX+U1/cpCD2NCtL4qFwhjU8o1sHR0ANfJ41Sh1sRoEMOVbv9P5NA?=
 =?us-ascii?Q?FAcfRpxQdF0gi9fI4SXt4C0AuJjwkJgrwfcJqSs+9rUoqgTKzJuq2z/49OHL?=
 =?us-ascii?Q?YCSYZDTIUwL1lyxbfneV3lMU30A+7B2e2Gol40X9XVs/leDkPi6xr1h1mBN8?=
 =?us-ascii?Q?VeFmnBZB1aryeSVIMZk2vKsUFckgc8NzZAr9AshhQWt81rKhmzsWHfelpmtr?=
 =?us-ascii?Q?fojR4N9oVbeTpV7H3SWfZ3mRknkfzpUPR+3CwHfsRK0w5duFxhKXnzJQEJat?=
 =?us-ascii?Q?8DYriX+Sb5egMLhLpEQ4WHA8FAxQmP6obKTvWul/Xv2RRHGDeVmSHYU7NvxH?=
 =?us-ascii?Q?15N4PcSQLhNJ3wf4PbciU8ATEOsm3IFXaGzUMqJk2+BW3r8xrNjOt2JOoOmG?=
 =?us-ascii?Q?0y5agepSrTCjithSdrRS6p1Qd+v0NzhcZwG/nfZfDLJhPxoYdl7e39D7JHxx?=
 =?us-ascii?Q?bx3/MsLdDMcX+HDEKoKBppQ45P4tIZSG/CNcge6DgGQuepBc9C/FDSETizS2?=
 =?us-ascii?Q?dyWWh9RBqjAEIU9SNIQaEoWoWmAB+F2RD7Yj0bCS4Vt0SyqDBZyGKkISI/gp?=
 =?us-ascii?Q?Nk7Dd+jSZzg8aaslsSA0Zl1BrXx3/+XyN64kgUGga+K3GG0PtA0BRfWoinoX?=
 =?us-ascii?Q?6TTwbFEXiZLOSXDYYkhtOTavDiqvRhXpDHmAm/2FY4WMgaG+WCFdrd9AkMkZ?=
 =?us-ascii?Q?w/29l5921y7/UQ9XkshxEdysHaN6O+25iOoHPct7jH1xG+pvoegx59KnoUDQ?=
 =?us-ascii?Q?RROjx5zhjP/wOrRJKJIF5WqsUrbc?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 11:24:57.2084
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f958394-6ec0-4af2-2b60-08dc759ad11a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6978

Move FIRMWARE_VERSION_MASK macro to xlnx-zynqmp.h so that other
drivers can use it for verifying the supported firmware version.

Signed-off-by: Ronak Jain <ronak.jain@amd.com>
Signed-off-by: Anand Ashok Dumbre <anand.ashok.dumbre@amd.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
 drivers/firmware/xilinx/zynqmp.c        | 3 ---
 drivers/soc/xilinx/xlnx_event_manager.c | 1 -
 include/linux/firmware/xlnx-zynqmp.h    | 3 +++
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 9bc45357e1a8..add8acf66a9c 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -41,9 +41,6 @@
 /* IOCTL/QUERY feature payload size */
 #define FEATURE_PAYLOAD_SIZE		2
 
-/* Firmware feature check version mask */
-#define FIRMWARE_VERSION_MASK		GENMASK(15, 0)
-
 static bool feature_check_enabled;
 static DEFINE_HASHTABLE(pm_api_features_map, PM_API_FEATURE_CHECK_MAX_ORDER);
 static u32 ioctl_features[FEATURE_PAYLOAD_SIZE];
diff --git a/drivers/soc/xilinx/xlnx_event_manager.c b/drivers/soc/xilinx/xlnx_event_manager.c
index 253299e4214d..9d89b5a40f97 100644
--- a/drivers/soc/xilinx/xlnx_event_manager.c
+++ b/drivers/soc/xilinx/xlnx_event_manager.c
@@ -35,7 +35,6 @@ static int event_manager_availability = -EACCES;
 
 #define MAX_BITS	(32U) /* Number of bits available for error mask */
 
-#define FIRMWARE_VERSION_MASK			(0xFFFFU)
 #define REGISTER_NOTIFIER_FIRMWARE_VERSION	(2U)
 
 static DEFINE_HASHTABLE(reg_driver_map, REGISTERED_DRIVER_MAX_ORDER);
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 1a069a56c961..d7d07afc0532 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -52,6 +52,9 @@
 #define API_ID_MASK		GENMASK(7, 0)
 #define MODULE_ID_MASK		GENMASK(11, 8)
 
+/* Firmware feature check version mask */
+#define FIRMWARE_VERSION_MASK		0xFFFFU
+
 /* ATF only commands */
 #define TF_A_PM_REGISTER_SGI		0xa04
 #define PM_GET_TRUSTZONE_VERSION	0xa03
-- 
2.25.1


