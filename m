Return-Path: <linux-kernel+bounces-308495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 516F8965DC5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 12:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8EBD1F27979
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AAA017C234;
	Fri, 30 Aug 2024 10:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GmMlbKP1"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2A1137745
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 10:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725012057; cv=fail; b=Q8BK2gVHeVUMRlvEtlWNzXG+qpNR7XltRGzaltlbkPGs2h14oRizSAS5g9emawycFxF+a0Y/BHxqsVKcMI1CUUg/7j9mnopM+5LqR/OMsdrGwaGItiQzoCkSn5cQLmWMmu/6Ay2oVsUQwvZHY4FgDYsmPUzIxro3zsrUX5Q5rzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725012057; c=relaxed/simple;
	bh=NASMf+j84M18MFqTcd0ndfjBNRfsXHV30rqZemUsA4M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U2s92euWqSAcutQKQMyzYASJSBWd1tN0xesLW+sAh6HWhZpM77C3B8Z0y5U1e0Y/vhcRp4mpEi1p0IL8lRR0VtFNR55ec4DhTvuWDY/fg2+zTheuWbhe8w3JYhkfUaCxyGkv6FMhRIQ/+OHW+aDNOK3Pdj/rWU68JAbWPPfzsns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GmMlbKP1; arc=fail smtp.client-ip=40.107.223.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XnyicFmJxYlKt344di92k7zNtBjlpcqHFY8HlOvLmDBRJKpVHzUSRd22D8Jzd3pYHyOyBiBffBOxSKjJXRBlENT7SeIfpsWYmiYpkUKm54fXDtpxvOcx/JOS2edOyRG9Dzz+XI6xbb2v3fWLpPAsJ1hx7gNN8tRZrwIsbc3Rek1968aOtg9NH3zof/NSrfPx2GgCQq8Npe3S4e6HsOM+NelEEorNn7WTyzvkBzLeqabZ9leRtbXAy2laXQKpXAxy6KcMFGk8B8J9csT14cmPn0mR6s/ikDDRqQ2FtK7ZaWjPaw2MUni0JAuAKiFOdMoTgrnI6edELHRTeAxPqeeJoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nwUe1wiEEwHlNaTFwBb4VovhLwYRkELxDhtsU1Sdj8k=;
 b=kSy6ijAwTgsU4KtHskVmjAxuGH9612lZkRRju9yt6Rt/y5Q3donz4F2K5cgL0iu4YpHAtxc4i9EFzCU8NpHeivMVlq/Zi0GyuKdfRNP9DU4Nk6Ry0N6EAwFwUEEtojv0yfCwky4wOW5S6if4xtSgt+O3knjupJ7/APy1PUCu1BFiTirnisAYXlVFLSw2t38R/6AEpYFG8WK69l1hVE7uV+IqGEm5Vv/ANjogZtELQpNhP8BQ7dJOgcBNaUUWV9panM7y7DtBF1R6lWYpqN4pYQDJc7cKCyTDhsisyGoOWTSRz6XjZHXEjAgHNRseVwd06AOHf02weYNpugR2UYF0rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nwUe1wiEEwHlNaTFwBb4VovhLwYRkELxDhtsU1Sdj8k=;
 b=GmMlbKP13VBnTUSD6EQj0OjcSv/xTQ1x4d2icfirAiPvGhjTfw7o0gJ3yae7oaB14VLgxBsxf1um3nraYhiIXJpmfEyo/sVCdwJVxwFCXnQ9N2AkjrLks0dSDuEpPmBsjhJPJbXOTnz+zn3sVBH9KElm1/b1Lhd0A3iac7TeaNA=
Received: from DM6PR07CA0130.namprd07.prod.outlook.com (2603:10b6:5:330::22)
 by CH3PR12MB8307.namprd12.prod.outlook.com (2603:10b6:610:12f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Fri, 30 Aug
 2024 10:00:45 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:5:330:cafe::d3) by DM6PR07CA0130.outlook.office365.com
 (2603:10b6:5:330::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20 via Frontend
 Transport; Fri, 30 Aug 2024 10:00:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 30 Aug 2024 10:00:44 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 30 Aug
 2024 05:00:43 -0500
Received: from xsjwillw50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 30 Aug 2024 05:00:43 -0500
From: Ronak Jain <ronak.jain@amd.com>
To: <michal.simek@amd.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] firmware: xilinx: use u32 for reset ID in reset APIs
Date: Fri, 30 Aug 2024 03:00:42 -0700
Message-ID: <20240830100042.3163511-1-ronak.jain@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|CH3PR12MB8307:EE_
X-MS-Office365-Filtering-Correlation-Id: 76921770-72b7-4924-8781-08dcc8da9d81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GzLTArLdz9S3WICkg5cJ25K07I7RhSgc/CRHO4VnCKJm142YBeLQdkmAB2aV?=
 =?us-ascii?Q?3vuP9ifzKppZlpGoVrurvQ+MOGWyOfMrjm3nQhK8nWvUrv8RoKG1qQiErUwg?=
 =?us-ascii?Q?CfHGznUxveAl+Ac8ndm620hPWuDFWt7f6eZ2bkUkA8hocPaOBlsaVo+8Yzxr?=
 =?us-ascii?Q?jCAgHdviFzITIWlp30v/RiUHfSpDfA4PuNHg9Cb0Pzqw8pV+KDPN8xAS/lhW?=
 =?us-ascii?Q?0u7bAcdCzLZnncRDWELj299drVsxmud3LlIhjHVPPGyfHqjXGLXql0EJFw67?=
 =?us-ascii?Q?KXQuddyDGbdGZj1/1nIJHEB7qOI1eSwQidkXHmzvd9gLKLLjZIgn7Hmo5zhb?=
 =?us-ascii?Q?ovKUw3YomQpayKMyYyM7EbJdKRVHLut7naCEZ4ACzH15Cq+AHVvCD70LJ12E?=
 =?us-ascii?Q?vbIc4ZRpyrToZs9HK1TzKFWALTzOXZTCdpjV2jn5/LgPUNDy1O+WHGc6eJu/?=
 =?us-ascii?Q?gMckKN17sRmvaaoYwVFkAnY/+HVD9nKABd1M/zmQNI4OC5oxoZ+jpIH49FzB?=
 =?us-ascii?Q?GePtSjeK4vjnyD6mA4gNErWIdzfCa/Px3jw4aBJ2Zox1d3b4Ys2Q4cLwoT3D?=
 =?us-ascii?Q?HN/S04nAmZMrKw3sQg8qz/mTYwDEkis8lon04fWrMHTlQq+JMTh0ZSalEOJ6?=
 =?us-ascii?Q?RnRynxDibsaLAL68yexwojpFARTQPfLEoSbH8G9U1GYDyr8OPC2fi0K8PdcH?=
 =?us-ascii?Q?qeXLEKZ44+GEtvrri13ZjbighdwhR7nXNHfi4155pbXah/pb60f8YXouSd4z?=
 =?us-ascii?Q?GwrFf/tG0yPUFipJ2QIZaO+efcXBJNiwPazhoZdnvsiOMlxhsc8rdvE6v8TP?=
 =?us-ascii?Q?Ovq+ZSFj0AnhGkFnos1vOCspCcQNdAgsugujkgnhoB0adll9DWYG44z6FL9o?=
 =?us-ascii?Q?jeVBfjKUevI6AdDFM7mZ6rkUQS/o4wLP9m6hWL8WuQVD+YhgHZSyE0Gh7GIs?=
 =?us-ascii?Q?2INjVckQHNZvbOIAanzVai7EMkuq87OPqN7+7WSp7AwmGyq51bfa/97YzGet?=
 =?us-ascii?Q?UiVrFwRd6LmRvxbs3d58Sqy86kFenkG28SW9e/ZhnWoGIVfxoBwdHcBc4qAh?=
 =?us-ascii?Q?ZwQ7L55YunYOaNtpJcYb+Euim3IeVntsbQ5RaKh0W43Bgrooyv8M/jDpz64s?=
 =?us-ascii?Q?tNL3DnxChLKOSN/JRGGaERKdhMRZpVCjyxmZVKyOP0+S07BV0zPYDLjmeJ6w?=
 =?us-ascii?Q?ZSblqbX6vARCmTB1w42eDHRVfbZ4O2+gDdl5hKZ/SytPvXfkQLWJwfCfTUmQ?=
 =?us-ascii?Q?4XARI2XWA56uEfwW6wfO9xWo/8BfistOGw/2oZ6cyPBo3C5XcCxnpcGYLJ2Y?=
 =?us-ascii?Q?sp+oOVO5H3vYho4na+suaxcLSZ3HotOGyzGTapHO4sqqSu8wHCirH+NBlmxL?=
 =?us-ascii?Q?/DgwoXKus53JjqyPOMyijCcZksI/EG5R3p18Il1cikQD4DaQQ5CwV1cDt8wj?=
 =?us-ascii?Q?Y+i/5bk3hoZWFHfRq/w5nyhxKSka2QV9?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 10:00:44.7892
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76921770-72b7-4924-8781-08dcc8da9d81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8307

Refactors the reset handling mechanisms by replacing the reset ID's
enum type with a u32. This update improves flexibility, allowing the
reset ID to accommodate a broader range of values, including those
that may not fit into predefined enum values.

The use of u32 for reset ID enhances extensibility, especially for
hardware platforms or features where more granular control of reset
operations is required. By shifting to a general integer type, this
change reduces constraints and simplifies integration with other
system components that rely on non-enum-based reset IDs.

Signed-off-by: Ronak Jain <ronak.jain@amd.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 4 ++--
 include/linux/firmware/xlnx-zynqmp.h | 9 ++++-----
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index add8acf66a9c..c8be32d9c6af 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -920,7 +920,7 @@ int zynqmp_pm_set_boot_health_status(u32 value)
  *
  * Return: Returns status, either success or error+reason
  */
-int zynqmp_pm_reset_assert(const enum zynqmp_pm_reset reset,
+int zynqmp_pm_reset_assert(const u32 reset,
 			   const enum zynqmp_pm_reset_action assert_flag)
 {
 	return zynqmp_pm_invoke_fn(PM_RESET_ASSERT, NULL, 2, reset, assert_flag);
@@ -934,7 +934,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_reset_assert);
  *
  * Return: Returns status, either success or error+reason
  */
-int zynqmp_pm_reset_get_status(const enum zynqmp_pm_reset reset, u32 *status)
+int zynqmp_pm_reset_get_status(const u32 reset, u32 *status)
 {
 	u32 ret_payload[PAYLOAD_ARG_CNT];
 	int ret;
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 563382cf16f2..5b938fc2adad 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -557,9 +557,9 @@ int zynqmp_pm_get_pll_frac_data(u32 clk_id, u32 *data);
 int zynqmp_pm_set_sd_tapdelay(u32 node_id, u32 type, u32 value);
 int zynqmp_pm_sd_dll_reset(u32 node_id, u32 type);
 int zynqmp_pm_ospi_mux_select(u32 dev_id, u32 select);
-int zynqmp_pm_reset_assert(const enum zynqmp_pm_reset reset,
+int zynqmp_pm_reset_assert(const u32 reset,
 			   const enum zynqmp_pm_reset_action assert_flag);
-int zynqmp_pm_reset_get_status(const enum zynqmp_pm_reset reset, u32 *status);
+int zynqmp_pm_reset_get_status(const u32 reset, u32 *status);
 unsigned int zynqmp_pm_bootmode_read(u32 *ps_mode);
 int zynqmp_pm_bootmode_write(u32 ps_mode);
 int zynqmp_pm_init_finalize(void);
@@ -702,14 +702,13 @@ static inline int zynqmp_pm_ospi_mux_select(u32 dev_id, u32 select)
 	return -ENODEV;
 }
 
-static inline int zynqmp_pm_reset_assert(const enum zynqmp_pm_reset reset,
+static inline int zynqmp_pm_reset_assert(const u32 reset,
 					 const enum zynqmp_pm_reset_action assert_flag)
 {
 	return -ENODEV;
 }
 
-static inline int zynqmp_pm_reset_get_status(const enum zynqmp_pm_reset reset,
-					     u32 *status)
+static inline int zynqmp_pm_reset_get_status(const u32 reset, u32 *status)
 {
 	return -ENODEV;
 }
-- 
2.25.1


