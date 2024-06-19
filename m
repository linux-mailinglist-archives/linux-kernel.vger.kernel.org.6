Return-Path: <linux-kernel+bounces-221001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5098890EA8C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 14:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5734D1C23ED2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 12:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3BA13EFE5;
	Wed, 19 Jun 2024 12:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QfKlsf0M"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0968F13E883
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 12:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718799106; cv=fail; b=BFkPONuOlMo3D5YzPzh/UIoFoiI6RoJOZH28hY5yl0E6QOAeKVn2PFPQ3fY7/vcHdsxYU9hMgTVBgLHRzQRJS8yEAvjrFMwxc3+k3Xm9Z1rjy774fOgrrRp/rp0jrNw0BFfTxumGInYnKZ5g+Pk7JWyUYd8NW87ZggU3Bqedwso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718799106; c=relaxed/simple;
	bh=XVFxJxdOUKzVvG2leP9EkLI83UB6aYvFIpVMsmvGmms=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CtJeffgRHl2Vl7CrWZdTpqcd7qi6c9eRjJLVdYRHh5F3IZChl+0qY7eCWjkCHHg4P+Ob52rYxaGc7CHdPVfFhFQdl++WsA+ohtoCzCU1doK8hO2Db/Hj1uIaLirxX6qltRjnpMNjv4LvMDohyGPg0B2IvAvohoTI95Ni9d4NltU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QfKlsf0M; arc=fail smtp.client-ip=40.107.223.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EoUXvYyqLC+xUgENLbNd13/niyLBs59+NdUrZn58Wa0TgMkz96iJmFJpyaVRKO/rWodMli5Liknvv+L2UrpxtAmsj/AubR2+IEu564FjbaK24p+4mwz/oEg6g4l2n4OkqS4UkcnBRh4vUDXPTA6SBRAf1AL/eFGcFRmkSVX288TphNspYf1Ac3YpHhUaBc6lSRLnPUFwYhZg1sjVKkY9lrZEoT6WNAIkFWZL7f3DYdMtQ7cMWXfnNUNn/LP1Gkj6JY/ODI04aMBeQwNHxLAgHRdALZ/0K8Jlv0UT9IzHZw4DJR9AxZfcYip79C9OkZRWnZUjL+pc+J8ZFASHs57DRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zga4jWUB/gLUZEr92vPrNDBgFVTCJJt+X7FX4Tp0rZw=;
 b=TTGXM0ayyiBdJHBLJ82W6GUxVU3GKjvjh89BgHHz6sEcwFu0xlj/aiEBlA2o+shvXY5kpOa8EQ8Ta9FvcRFxRKcih+ve9wsZ+lCsWl8ZvRob5GXAV626/QDPfeptm+zjNisAitZ2drcFpYWBkW56Ik4d+tF5kTAz0wGkFnjolOEnzLLdRppXFpgya6O3MX0SNsmEg7/a1Rc5YTccGzRJyhLJ1AgJr3XKZY7x+AKbQT8NSMhW2WF/UAzahrTfad/cp1Rt62LhuPOw7ID2bzf8jDclABg4yFJVNoHPDuyVdi1kAQy/b3k7EB8oWU5exefOlu9pmWU1w6NVCPMBpXJ3sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zga4jWUB/gLUZEr92vPrNDBgFVTCJJt+X7FX4Tp0rZw=;
 b=QfKlsf0MXh4gyQh7vwCMTs3DejCt7AoXVCoy+u+y6yJcbCRtznmouoG4VDzw8svcGHQwO1w0TR0S0mbqEopM1m2grCN3JEgHvzl2n7061iAiz2Z+pL6IkAU9AzYgMhp2wzANtjwEKTdmutZBfvOiCkosc7D5brdQINLBoMSJh4o=
Received: from PH8PR20CA0007.namprd20.prod.outlook.com (2603:10b6:510:23c::9)
 by PH7PR12MB7284.namprd12.prod.outlook.com (2603:10b6:510:20b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Wed, 19 Jun
 2024 12:11:42 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:510:23c:cafe::9c) by PH8PR20CA0007.outlook.office365.com
 (2603:10b6:510:23c::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.32 via Frontend
 Transport; Wed, 19 Jun 2024 12:11:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 19 Jun 2024 12:11:41 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Jun
 2024 07:11:39 -0500
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>, <quic_jjohnson@quicinc.com>
CC: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Subject: [PATCH] microblaze: Export xmb_manager functions
Date: Wed, 19 Jun 2024 14:11:32 +0200
Message-ID: <e322dbbbde0feef83f44304ea13249d365d1dc5f.1718799090.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1629; i=michal.simek@amd.com; h=from:subject:message-id; bh=XVFxJxdOUKzVvG2leP9EkLI83UB6aYvFIpVMsmvGmms=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhrSiU195np02dXrh7MSbXNApqKgQK5+Qm8O043zr+lUKB 59NOfa4I5aFQZCJQVZMkUXa5sqZvZUzpghfPCwHM4eVCWQIAxenAExkky7DgglcR/doNJ0KUpvq w5/bX3/v1qWPbxlmszpeXX6w8kFik/DZJ0t2se99xN7mBAA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|PH7PR12MB7284:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a963567-b8d4-4d99-ccca-08dc9058fabc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|1800799021|82310400023|36860700010;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7SnYZsV1CINHJT6b1EEHutdhXXa+jXVD3WWj9GRp9aimp2fu62kf8ezsXh5R?=
 =?us-ascii?Q?Fi3lRiBEG/A2zbhgvavAOgny8qHesyEhJ1GEDeiQYTwFAQ/9S+0OMPlNeaXB?=
 =?us-ascii?Q?samxFGXWkCBlugvNOFyCl16Bih3LfPM5xbyNfMoPhB00h7GFBNsnoBik04zt?=
 =?us-ascii?Q?w6IEJtYGBWb+6DqUVovoE/NzVmbEfjOMfDU/g7y0kX41upb3P0unlsZMrIbU?=
 =?us-ascii?Q?DDc1I5PFP5e5BgIl1SWjEAcEeVetlZGS3lk+HVmTND0QoabNE5g/5gPC2rSA?=
 =?us-ascii?Q?4qf6sqv++wOV6tpfUQc28xL0T463M4zZ7w6QTvB0g4qUooaZuIctEjdjvF/Y?=
 =?us-ascii?Q?+Euo3j/+fDLyKayTykLcAwJF3XZtTa1c3q04hT/BBKPg6B0f+Ywjnn96byeu?=
 =?us-ascii?Q?enGpVN4CPdCbjBVeJVVhkU59ewjsXpAWzS3Hh/LLH6uGak8SmEPxNCiIEiDq?=
 =?us-ascii?Q?QvxHw/cIkPj3t2Svr1VSy/u2tL05zy9FJWX6rRkV3zLu4lPkjSs0R/tpmVlH?=
 =?us-ascii?Q?GZKeS6isL8jtJC76Wdu7Akj8T3B8Ed5/SAnPQwxz0c051i4ZzWpcqBDopmo3?=
 =?us-ascii?Q?bIqVabVwqpsALUqx9Hj5+9ugB2avj5CfdBBmn1TEaB3lXFJGPSNCecGLdiRb?=
 =?us-ascii?Q?m0w+U4COOrrCZ3rcm4kN4rjFEiFMLA6pcZCGJE5yfkcqS5ieOWJd4a/RCB3R?=
 =?us-ascii?Q?EC4khZTWh31D6qG21hCq0wMcbRTT6a0w7YpwtBQgCgeFNZRYT5BiJoZRveNV?=
 =?us-ascii?Q?YkTw0+tSyGx4piPXTtWjikKlz3oSuZtLeoMaseRRjKtxaBHW/tiadjUkg8r+?=
 =?us-ascii?Q?RJZQp2T6V7XlX8Vt+MZ51ypnIOSt99/XEixs2Dzh2YrsUfJlsVFbiaoky6DJ?=
 =?us-ascii?Q?DlZXNRq2fUJIzZcpnWCmqYn2PRKZrxmNoXS3OkO5gVmGmJyfYy8fkRdtQg8Z?=
 =?us-ascii?Q?aXXbsWRGC0/Pt4UHSLTKtYFveushqAy23uV0hS90Y2Xp1ithjN6VAGm/Gz0q?=
 =?us-ascii?Q?HHyjfM2vv2I9R56rAZ00nqDjPtfPwwvfr1psQXtnGfKG88CAQBb2g1bZiZRo?=
 =?us-ascii?Q?Duu1b2ui9LxsPkS3Bx5JAS5vAKDFb73Fa8nmQcAQRJRLn4Q1oiqO5uhnuEQt?=
 =?us-ascii?Q?ymwKA6Gq4JAVq1jhjoOXXGvzEfKQK9RumBUzViNjDCCYBC17/VGIqcalVZ8F?=
 =?us-ascii?Q?wxbhUrj010/k0skADnOZ1vxQE2Y7anPOgaV0n3LasQB2+X+8RILcL2cIPEDb?=
 =?us-ascii?Q?piEqoXLjJ2gqaXikwlNaKK5dqsDoJd2KWnJh1FUfJulqXBYpjNGxxpnVbMvK?=
 =?us-ascii?Q?7km00jB9/LGH1ppId3YcjaZwVlCslECWelTe0griWxdKBzEayNaCiFEkEaYd?=
 =?us-ascii?Q?BFHxGD/TWoEAN8cd4EW61QdUs3fNc+J4nZN4hNQdApexjUSFPg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(376011)(1800799021)(82310400023)(36860700010);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 12:11:41.6716
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a963567-b8d4-4d99-ccca-08dc9058fabc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7284

When TMR_MANAGER is enabled as module there is a need to export functions
which are present in architecture code.

It has been found by running:
make W=1 C=1 allmodconfig
sed -i -e 's/WERROR=y/WERROR=n/g' .config
make C=1 W=1

which errors out like this:
ERROR: modpost: "xmb_manager_register" [drivers/misc/xilinx_tmr_manager.ko] undefined!
ERROR: modpost: "xmb_inject_err" [drivers/misc/xilinx_tmr_inject.ko] undefined!

Fixes: a5e3aaa654c1 ("microblaze: Add xmb_manager_register function")
Reported-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/microblaze/kernel/microblaze_ksyms.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/microblaze/kernel/microblaze_ksyms.c b/arch/microblaze/kernel/microblaze_ksyms.c
index c892e173ec99..a8553f54152b 100644
--- a/arch/microblaze/kernel/microblaze_ksyms.c
+++ b/arch/microblaze/kernel/microblaze_ksyms.c
@@ -16,6 +16,7 @@
 #include <asm/page.h>
 #include <linux/ftrace.h>
 #include <linux/uaccess.h>
+#include <asm/xilinx_mb_manager.h>
 
 #ifdef CONFIG_FUNCTION_TRACER
 extern void _mcount(void);
@@ -46,3 +47,12 @@ extern void __udivsi3(void);
 EXPORT_SYMBOL(__udivsi3);
 extern void __umodsi3(void);
 EXPORT_SYMBOL(__umodsi3);
+
+#ifdef CONFIG_MB_MANAGER
+extern void xmb_manager_register(uintptr_t phys_baseaddr, u32 cr_val,
+				 void (*callback)(void *data),
+				 void *priv, void (*reset_callback)(void *data));
+EXPORT_SYMBOL(xmb_manager_register);
+extern asmlinkage void xmb_inject_err(void);
+EXPORT_SYMBOL(xmb_inject_err);
+#endif
-- 
2.43.0


