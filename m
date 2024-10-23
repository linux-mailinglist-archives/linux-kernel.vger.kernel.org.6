Return-Path: <linux-kernel+bounces-378699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 727199AD42E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 20:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA4A3B22762
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 18:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294131EF925;
	Wed, 23 Oct 2024 18:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="S54oBypS"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082001D0F77
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 18:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729708963; cv=fail; b=tb4x7Xr3nCHJzFQuRuy0PGXiSF3/SZeHFa+9O02sqxiYECELTEn2f1loe4a1SMtJI4CQXS7J45S5umBVBm+bl6rdwvqLY853yNw4E41041Np6YqEIg+IaC08HHUz6Qq3EyFc9ZsKIBG/kKp5i61GQg0N401sKRxQdFGnQGygFyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729708963; c=relaxed/simple;
	bh=bb9rJ7F43PPhz0OXS1d7ukdlXQbaqzOSiU2ojYSyxS4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uAk94OZuJ8xTcWx/Z/KSI5XxoY62RNG9Zy39yd2NnIMfVIBDVZkPC06GNI9sRBUZjYb+sOXKgpJy4ThCW82E7d/bz6xx6yZweTbMqiAKVp8S7t9i2C0wmO0WF4QHBw8k7rQlfJdYILiyi2NiCJsGJyhQ/rVUptzf73WdWobrtYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=S54oBypS; arc=fail smtp.client-ip=40.107.220.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yjVvMk6BYzun5AJBkCVsZ2lDJrI/zqYHZlvuDUhYmYsdm407IB+1LZtSZTJUk2m5Sd+pAdJdyWszZFsunUMCwZ3Cvg+G25dGOXZV3ujLIxLa3fqAS65rqD3n7hOsBsFN98R/ZEab8+f9+vJh6AL3hAkW8hsXCr1UEmE+cIEuuz19jU46kvf7cMr+aOfbr2ytAFrdNYAmg3A+ntDB+IpfDrH93O8dJYcJkLfDRqsFhYnHSmCyBNn7kobmD0VJXnt043Gw39Zs1QHUyNN4DFsUjAnHTYAtUzZ/BAczlWbq6mwm88y3AHPFAy+S50KJ/VflYHOWGTAnNU/61C5xenZvaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VDibw/rSBpCju7M84pnfYt8yGfr0Of7CCc0J6wYC/8M=;
 b=olqnW1BlQqHfBMgLL2stliwbIH1T5rMKacQphOZYOJNhQk2bXLXHo1eHR2S9ylWnO5Ng3kJjHvew1NK4FhJgNruhd2wly6NqQ2MK5T3IhhFuSvf9n0UDLUqV4HGkfo1mm/lejXZuoxij8FHnbkDnEW8/1IG3cAFCGAv3XrIZqkeK55Q+9CwpgbcXHZguf+FPuDf0VWjykHYKgxlvhE3Irukwal6fFjQUylHg5K2VB4qNxNsdwI8zN+zePVC3z88nmdMc7wC80vfDv0ZIKUO2Ce+XHsR4wn6llc2uTN2gO6cMZzXpBzgIhwXAvNfP2OTRjXG9Fh154KMSeB6o3526MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VDibw/rSBpCju7M84pnfYt8yGfr0Of7CCc0J6wYC/8M=;
 b=S54oBypSEcGIXBk1TOmtCIGycy2g51PDWBqJJFEPXvcuCxDYivJ4a9jkJlNvOlxFgrUb8mvz+1U+Qfn6UM2QpsV8PPbZ0QnK+cG1wlg8ze6VH03Wlixbr+cfyOlddGZiz7Qob5Uzx/nlT3mBoZXDfb8SwcubKhcazlN4n1PAtG0=
Received: from CY5P221CA0068.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:4::39) by
 DS7PR12MB5838.namprd12.prod.outlook.com (2603:10b6:8:79::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.20; Wed, 23 Oct 2024 18:42:37 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:930:4:cafe::86) by CY5P221CA0068.outlook.office365.com
 (2603:10b6:930:4::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16 via Frontend
 Transport; Wed, 23 Oct 2024 18:42:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 18:42:36 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 13:42:34 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Subject: [PATCH v4 3/8] x86/sev: Require the RMPREAD instruction after Zen4
Date: Wed, 23 Oct 2024 13:41:57 -0500
Message-ID: <54f2b69c783436339e2927091f93dedc3fee1d79.1729708922.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1729708922.git.thomas.lendacky@amd.com>
References: <cover.1729708922.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|DS7PR12MB5838:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c6e5c06-c679-4c1e-a4d4-08dcf392771e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Yl0+JvAcax/Gq0bpSDZurmbP8Ezt7F15ZVdQx2HjvlPo8XPGpUBdOr5ijM84?=
 =?us-ascii?Q?jzP7k7C9f1fVGMenAquobAkAFLR7xqflnO0CPURx1pEYJ8msBTMR7tYSVc6q?=
 =?us-ascii?Q?ud3BNH3uVIY1k6R46ekUSJnVImovGFxB7As/5zlMl/NeQkD4YKv/vztDwumJ?=
 =?us-ascii?Q?I1jrdd4eR1WQyJ/Rshnlth/ew3/mD7+LgYkl53lLHlEesMbN6mzE3W+E8K9/?=
 =?us-ascii?Q?plLvCmmKk0ikbRyNUHl9hRsO4K5OebDDtswNcqcTANT23K57cyBUinHcAz+I?=
 =?us-ascii?Q?mIsHaIa2dudvgzMKz7vRT5ILluGjxNpDHYecIZjNVfBSCAUvTrtAJbBsEnlB?=
 =?us-ascii?Q?clscfudkajvyCn3Mr9xsxf0LgD40GGDJbf3McBwj6ihDH1I6LF6Kc9vg/PP7?=
 =?us-ascii?Q?IQ0QT64M2WpYbryhPiHdEcN2Poy87BDGSYaGxyPWg6w1nHcnXRLufRi/OjVx?=
 =?us-ascii?Q?jJo6IORz5T8krjW5dPp0+12pePWdxLBLCF5pFx3Gvo4C/4e0UwnPJ1R0fWXK?=
 =?us-ascii?Q?kMieIYWdokGbaKzDeTfRPAMD4dnmwsvOwZ++IkXj3GQHO3t5xhW6xIrKeGrC?=
 =?us-ascii?Q?v6yOsgLJU9SCc9OGlxH1xRo0GohKzyJQxICjKM9+N0mtG1hxN9oLmZppkRgm?=
 =?us-ascii?Q?hrMgGHQ7ZftUYx1hJDeXEgat+91o0TnNTPgmkCnVxc0XumKzrZcPp/psUfjE?=
 =?us-ascii?Q?Tkaid5kLI1QISmT4GKd651pMUGTXCnSgPHkVJXzI8FESijCjLl5CvWD20zTr?=
 =?us-ascii?Q?j8cj8GV4jnAZPRSyYaSIkkg6tpUrPGVJCYVnIQSt/DXkfqvxLOYI8UZuibiv?=
 =?us-ascii?Q?W8dT2SQKraYtutLbgy/4OKuXXR7dE5F+JsWey7GuuyNWx66AV4Xu8RgI7NK0?=
 =?us-ascii?Q?uVtdUtSC2NpR90peYTNv+NmJaPuAhQbchigNbU5mzQfKcScGxtTlzM7Q0O8S?=
 =?us-ascii?Q?umU7VHPqvy1fB4RPCChpazCi52GCyPcSTGNVriXwvR7b8EghrhVUVZ8HDjJV?=
 =?us-ascii?Q?zOs3kOay0HmXpQAcy0yauC2FK5bEmOUVf2da4ngH+Zq0/trkd5HyAFfJn4ph?=
 =?us-ascii?Q?RE7TQaN1jmmHulW6IRxsNG0Ey60pwXpQowrrfWhzEk35Kr4+ElGCSyjd5x9x?=
 =?us-ascii?Q?uPBmMUog4eAqRIoX9pQoKa1opRBrxw5xC+eBqUr47pYguOg0EvGuXHFTkMaY?=
 =?us-ascii?Q?8CmdSe7UKV0j+ReW4M/kXXytVd2I4U9KuUjk7EG6oCopsxhKTAwbYjTVDaGE?=
 =?us-ascii?Q?3eTu4PXi2Y24GgG4CZ990xlXA7VDB2fOGGnfwCJfmArP4vCWjqrOSVGB/UZ4?=
 =?us-ascii?Q?pAkr8Zp8a/JYBWAOatNinSp3T+dz0wx8SpVeUlXCCdmpWq1z6TkDUn+54s+u?=
 =?us-ascii?Q?zFZK+0srvjfofzng5TLhNtY+0gN+WjbRoHRqpXhAY2nChkSlwA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 18:42:36.7164
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c6e5c06-c679-4c1e-a4d4-08dcf392771e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5838

Limit usage of the non-architectural RMP format to Zen3/Zen4 processors.
The RMPREAD instruction, with architectural defined output, is available
and should be used for RMP access beyond Zen4.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/kernel/cpu/amd.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index fab5caec0b72..547bcdf50f1b 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -355,10 +355,15 @@ static void bsp_determine_snp(struct cpuinfo_x86 *c)
 		/*
 		 * RMP table entry format is not architectural and is defined by the
 		 * per-processor PPR. Restrict SNP support on the known CPU models
-		 * for which the RMP table entry format is currently defined for.
+		 * for which the RMP table entry format is currently defined or for
+		 * processors which support the architecturally defined RMPREAD
+		 * instruction.
 		 */
 		if (!cpu_has(c, X86_FEATURE_HYPERVISOR) &&
-		    c->x86 >= 0x19 && snp_probe_rmptable_info()) {
+		    (cpu_feature_enabled(X86_FEATURE_ZEN3) ||
+		     cpu_feature_enabled(X86_FEATURE_ZEN4) ||
+		     cpu_feature_enabled(X86_FEATURE_RMPREAD)) &&
+		    snp_probe_rmptable_info()) {
 			cc_platform_set(CC_ATTR_HOST_SEV_SNP);
 		} else {
 			setup_clear_cpu_cap(X86_FEATURE_SEV_SNP);
-- 
2.46.2


