Return-Path: <linux-kernel+bounces-336038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4215A97EE5F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 17:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6FCEB213ED
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 15:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195D5194C8B;
	Mon, 23 Sep 2024 15:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mH/EX358"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2068F6E
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 15:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727106091; cv=fail; b=rB8/4JPX9AY6/FFLpT27Gd8c8oR7zsYSptNaOKoM1SFM6EU11eyNK2xXayayaxnpmkhiBEt6WSLoCntr5Wn8t6xcC9B3y8f/UnCJQrAqz3WDCJU+6am0oHn9AenuY7A8jCXbH5ArUb3RuhpdsqTexGC6j4+KPF+Hdn8qt9by6z4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727106091; c=relaxed/simple;
	bh=QA4c2Yp69EeOVO4nyfN1XwQ9nob7qx8yfuhYPk/nTqY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aQWkOlNFptt4ghyMVKnUD2pwes8Z0IraZ31A0mIhJjajvwdQdx0X89tl9M96aEX9i5aBl6yzvXuqf1wp8pFwdRxl2YbxSYCE38OJ7xLG4HaUtvbBZrS3eD46kX2bAw9Sm8ItSCFrByWlun85B20uB4MSyv+2bknroX0Ok10SwOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mH/EX358; arc=fail smtp.client-ip=40.107.223.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jQWi0+xCOFeJvhRltvLQgvKUn9LDkxYNxCGf1/gNTdFzFudCJ3My5eBd05aD6Fn0EU3nHLsctuiAZGOD8RBrj2V4MXUB6q9EO++wNMuPDPNllHC/F2VLTz+H4qKrb1mzUuB+ttKX9KUGW7Z88E+gWX7H37+p+n55ctzMUrlCBng3nUYMRVmFMGTA93vvlDi5hrkKQiBwnxaxtE6KRxmmg6OsiFGPjzFvzuLNPkIGXM4A5j6kEDnDkoU/ZrqAoy9l9DYhOgcD7LpbwXO33xYuyqUaqdEFMyJS8qU3saOgtpuQyL41MOFxG2K2Cogs0DHcMYZGVWAWE4huPk4IhFYpwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=61V+rlcBmERr8EiloyqF+Hr4Szipy1d5/lq74s7nRbs=;
 b=JKDoWCVqpkagY2KR0eQ3Rda2V1Q0hkTAbYkx9pOec5/Sxg3Q9SgJ8VG/r/VnrNq7M5sPwaSh97xbzt5zJZvb3TBDDhdJfR4yH2hkRfqt9alFD9F7AT8VWLFcGX1iL2S8f7lXqjfkWQe2qSAHLf2L1YNDJNzygI3xYklSfBr+eILcLEoEiCIw4UHL0v3QpBJic33LQKpIY5AIWfjZbWg9DOsZC1qz3hamJZuHOmlmxJZ1qAQeQc2R/wMBuBK9mSVwOOyWMWgWIq7ck+rHdToxD9n3don4katRxtsc1BVnebqO5pKtecA/wRvFQKoW85x6dDOsU1w+EtBpIbyogEGLKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61V+rlcBmERr8EiloyqF+Hr4Szipy1d5/lq74s7nRbs=;
 b=mH/EX358aRhiGUy67755yMHD5HJMz0A9cSwzgoAq3UasC5xpB+qy2dYjMpn8vcQeQ5l2tLQ/YBr+eqoLn8JhXK+tmCubStZT81AD9j6toOgLOma9pjcUyuf/C/LiYAqWeuVUy8elYFSs6ZfT11xYaFOVoc2EYo8thJ6BXQI6iW0=
Received: from BYAPR08CA0053.namprd08.prod.outlook.com (2603:10b6:a03:117::30)
 by CY8PR12MB7171.namprd12.prod.outlook.com (2603:10b6:930:5c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 15:41:27 +0000
Received: from SJ1PEPF00002326.namprd03.prod.outlook.com
 (2603:10b6:a03:117:cafe::ad) by BYAPR08CA0053.outlook.office365.com
 (2603:10b6:a03:117::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.25 via Frontend
 Transport; Mon, 23 Sep 2024 15:41:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002326.mail.protection.outlook.com (10.167.242.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 23 Sep 2024 15:41:26 +0000
Received: from jallen-jump-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Sep
 2024 10:41:25 -0500
From: John Allen <john.allen@amd.com>
To: <bp@alien8.de>, <x86@kernel.org>
CC: <linux-kernel@vger.kernel.org>, John Allen <john.allen@amd.com>
Subject: [PATCH] x86/CPU/AMD: Only apply Zenbleed fix for Zen2 during late microcode load
Date: Mon, 23 Sep 2024 15:41:12 +0000
Message-ID: <20240923154112.26985-1-john.allen@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002326:EE_|CY8PR12MB7171:EE_
X-MS-Office365-Filtering-Correlation-Id: 1deee28c-9b61-4a5d-89c3-08dcdbe62f9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eLLdNWi/F72RsqO90iyc0Vgiytrz+/3u5E70w7q2w8V86Qvb8yXq2B33obeN?=
 =?us-ascii?Q?tUF3XiSODB5IxjLuhOe584QpN894LagXNGlpKmyrWhoIdNSt7+p5IwYt+lFT?=
 =?us-ascii?Q?FOG16Q6dN49dgGAMCHvvLU70stu4TbS0RsnGpaqnmeHeHMr17TBzUUnyua/6?=
 =?us-ascii?Q?241n9F3NmSquz/hXbIDqEucSbII/R/F5xZTKpRCSmbGTCwBEFoWBgkZfMXEu?=
 =?us-ascii?Q?WJF4KUZBWk2h56NyhtocGJHlXnNLbFXypA7nFZb9zrJNuRjI8hMt5+36Nviy?=
 =?us-ascii?Q?F0lDap4nujcC0HLYBzGcajPax6ArSNjqLvdEFrUgsjkVMSZA9oHTz1hvCRWC?=
 =?us-ascii?Q?KeJEg1s7fgR+0h55B1jROgVB3Z6R+cLBc2OqYs8CQBG2P9YrA0e460Y8a1We?=
 =?us-ascii?Q?aX/zMW5IZto16hGG2gS+hdbehr29Bn+arwQOBWxOfI0Q5Y14j2lYU+WkRIMg?=
 =?us-ascii?Q?+7ePaMMDgoTL3c3bw3R7C2p8XPNOdbhygd2mac3hUCOcQ/CbyWVxmfnuJuUy?=
 =?us-ascii?Q?ZfNwtdv47XyrbXLZy86YDOWqsObedtFlDHpVInXZILZtLjBZ/S0ehWpNkE7C?=
 =?us-ascii?Q?QhXZ4pcxO1wOPMOQ5nGMCRMgkX4sJU5CVYiX2+5L1r2tU43z/dqNufMlz9Ec?=
 =?us-ascii?Q?d/Lce2hcSrea3G12LCo5hZ6PERaC8KYWr2VwM4Nl0eMGwBLNOU93h/Vp+CTb?=
 =?us-ascii?Q?FSb5ByWqb5plqYPPTVjaV7DG2GZFtJABJGUuGnWxLI1kfnW+SpyTgneI/p5t?=
 =?us-ascii?Q?aAqDjTyM9Yiyw3hQ7OmjXrGqmF4AsT3Bd1cXgStXHEKiQia6aFjQ7DmeQrmo?=
 =?us-ascii?Q?p1+JJnxQKuH3t3y14odNdIWwNSSLQCklXZMZ+2aORDISVWZa+rO6nrhQxIAk?=
 =?us-ascii?Q?X57UFosx/W2vcfeBzJX/E8ljHXak4tmwb8/AwBTMnTYU5BlyfxqwJJkvpGqu?=
 =?us-ascii?Q?K9IQE+/nGwtp2VdYEQNuXFd0Ri1uj2enJxuWjuurmsJZSvx2kNqUmq3LkUsL?=
 =?us-ascii?Q?btBnKyMKwqqEFSvN2x9Qp1O1mGeDnxLaq37XuukHLrvdMv27R6p3vxdp9K/1?=
 =?us-ascii?Q?xjgNTR9cHjvk4vTSKnTiXU04EA2IVere/Ut7ENfsfYi6Sse+29SKlS3fkKED?=
 =?us-ascii?Q?X0rIr/H5tOnz1U6g9NcjbwXAYvy8ayIu/npNDAYTOELxrkqdDLHpSwJHzgL+?=
 =?us-ascii?Q?i7Jri2z0OIzspAHoVhGdoov1jdrQI1uVhK7Nwwe7aL9ObEBhGDRcNQts1gFf?=
 =?us-ascii?Q?mKrv213AuNSwVarwFmE+N3dvuZf3lorLjS2v31IISPjzqUicNcYRfgu7XLD0?=
 =?us-ascii?Q?eSVgtzmxk+zONQugGvB7Z4pY4gaL3Q76Aw5PjDHvC8DcQKI2+tDSvnnls2is?=
 =?us-ascii?Q?MF1Xb9BLkjTkXu2L00f/dw8RfZKHWcBPNhb2d1toK3tae5S+OR2GCiQODAj/?=
 =?us-ascii?Q?e/v+Dy3P9l53tzgKRuRM+/vpbmzqBNh3?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 15:41:26.6307
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1deee28c-9b61-4a5d-89c3-08dcdbe62f9f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002326.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7171

A problem was introduced with f69759b ("x86/CPU/AMD: Move Zenbleed check to
the Zen2 init function") where a bit in the DE_CFG MSR is getting set after
a microcode late load.

The problem is that the microcode late load path calls into
amd_check_microcode and subsequently zen2_zenbleed_check. Since the patch
removes the cpu_has_amd_erratum check from zen2_zenbleed_check, this will
cause all non-Zen2 cpus to go through the function and set the bit in the
DE_CFG MSR.

Call into the zenbleed fix path on Zen2 cpus only.

Fixes: f69759be251d ("x86/CPU/AMD: Move Zenbleed check to the Zen2 init function")
Signed-off-by: John Allen <john.allen@amd.com>
---
 arch/x86/kernel/cpu/amd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 015971adadfc..368344e1394b 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1202,5 +1202,6 @@ void amd_check_microcode(void)
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
 		return;
 
-	on_each_cpu(zenbleed_check_cpu, NULL, 1);
+	if (boot_cpu_has(X86_FEATURE_ZEN2))
+		on_each_cpu(zenbleed_check_cpu, NULL, 1);
 }
-- 
2.34.1


