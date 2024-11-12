Return-Path: <linux-kernel+bounces-405271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D669C4F5C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 08:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF373B232DF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 07:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB8920A5F1;
	Tue, 12 Nov 2024 07:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4Hg8sDdM"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E3320A5ED
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 07:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731396298; cv=fail; b=Kek9i54ekwKKcXVkROo0T4vlN+rnk/rUf5ljI5VMX0vILeZoMMi396ekvODYXarNSSsQSFjEMBhbxKjayqiAcJjEHQuOPPneyhZkaH+EsPDc7CHKujrhE2xpmeb9jdyTTd29V2e5j0tPyufouLH1F+d1Vtk+N2llAaI0iz0b79Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731396298; c=relaxed/simple;
	bh=61wx5bD1WMBHmjFqWkWvbUtYdcSaq4Go3beX5+oC9a8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g57+iI1D+jzJBK7EvXdjxrbyVNwZTYuuhAysRz+3+b1+QkKBV3VyfZWsF06isElgOYG98Dc8NWihAU0S9j1dsNK6YyCqzg6fh7mLBJkzGib2NU0Hx/QaGo9j3naw8jrFss1tDHDOXUbQle1Xd6KaG5Rf8HG0qROdhgc8wK0VThg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4Hg8sDdM; arc=fail smtp.client-ip=40.107.93.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L6apGc2er2D2jeTJkZjyVFaj7S+ZqLRA86YnBhnfHr1oyYaiYarIq6VI1leoFDbCRgfrmCR6ZlmYcCw8Ea2AS2cLAeRjM2tzYYH8i03fSzcn+BYRJppvGA+8nHN2gMepzME3umL/kFsaZ7V4UOcdAsqC0lgWeXnlOdNznUrpRd1Z3DlIUKumhCZjATrV0g+0Jr6I9iP/+qlCTqg/oNtwqWSGgpISzUfShS3jqASYWJWI69fZCwVNJugOp2xVlwTNeLw0JHf+8Yt5L3KJFc9A3cIABks3wT9n0sP2248JAwXZfwlnrG1Sykl+44/FOEQi7JweYCU5ZmrFmOoKbDQewQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+irpurVDl05ASJ31uAUcmgzGEZVQfWu9Zn9e4M5zE4s=;
 b=hSlfVGFKGQ5Fj3r/T+doJLa8WUhmtUG/Om0n6MsEYzW9UiASya2mIUEcbgxRsBsoyIH/xsW8TH/x/OKj1eSmvYmOSGhbRiNn3eBf40RxGvv0scdBsT9YBOqjPWqjvIbNex6Wbcm8LK+czljH+nQYlg3Ntv+GlJ/NUx2eeLdO0N3Ok9DIPCg4pvOahsDv9z1WrOPGo7254aflBuPBAxMvXe2V8HboTR5dbjmdagb4K2M1ysreOfzOtow3crLhiNoet2NPaaoHF+u0MgExNEGm/dvdeNpTD4eeTCPoOnAAFI9rvUFH1B1SYxtxILlnSkjyIQDDHpaNmoVTNsrJlmHW+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+irpurVDl05ASJ31uAUcmgzGEZVQfWu9Zn9e4M5zE4s=;
 b=4Hg8sDdMnxGACHwjm4B1zDRgqy90FWBCU0AJLtFk9U/qHUxpPJjUl+fY1xRGsXAhOxZQJ/koWQfNctwclEzoMuh/J7K6HryLv1LElPO4Z1muTVtZ0vGb3Lha/+j0JzADZYWP4Kk6QV6olZ2wpInZpFe8xM46uF43Ya6zKpjQRgk=
Received: from BN9PR03CA0928.namprd03.prod.outlook.com (2603:10b6:408:107::33)
 by IA1PR12MB6115.namprd12.prod.outlook.com (2603:10b6:208:3e9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 07:24:51 +0000
Received: from BL6PEPF00022575.namprd02.prod.outlook.com
 (2603:10b6:408:107:cafe::cb) by BN9PR03CA0928.outlook.office365.com
 (2603:10b6:408:107::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16 via Frontend
 Transport; Tue, 12 Nov 2024 07:24:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022575.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 12 Nov 2024 07:24:51 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Nov
 2024 01:24:47 -0600
From: Shivank Garg <shivankg@amd.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>
CC: <x86@kernel.org>, <linux-kernel@vger.kernel.org>, <shivankg@amd.com>
Subject: [PATCH] x86/cpu: Remove redundant CONFIG_NUMA guard around numa_add_cpu()
Date: Tue, 12 Nov 2024 07:23:47 +0000
Message-ID: <20241112072346.428623-1-shivankg@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022575:EE_|IA1PR12MB6115:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a9df382-7448-4868-820c-08dd02eb18a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BpnKI9bgQlxuyD+T9V3tB1hTnThRxBrKV+0B7ba9xR9b1CfC/zh7Q4/m2MWB?=
 =?us-ascii?Q?STmJSmk7QVkEaXJGIrDkmvbeRuC4nloRpVUaP8G4E5tuki1USZ8SKnJaLm23?=
 =?us-ascii?Q?9KKT8v5gvTaz2RcxuVbF1wlx1xpdEOaWUrCTRIYP4/S7BC982oTPHPjZGTQR?=
 =?us-ascii?Q?VPMHGDhfayPd3ni2F/a1t4+GVRh3ZrywDv3wtNGUPoPGU+kqaFybYumrQOvW?=
 =?us-ascii?Q?8dqBSBkxLXxJ5VhM1GDuN6RFGRHAm+wUG9zUeSl1ZJR1J4nn5CxKl03x/1D+?=
 =?us-ascii?Q?iGaS5pYcHzLrXTGLmFBgsIN5dmjP+rPG2VdsFDPd8qYPG+js70gN3v1mWdKV?=
 =?us-ascii?Q?TwV0B6LNpgS3/2R4Vt844IXnhNc8ZpZgobLRLnRsuLp9ZHcL1CZOXlRdg6pc?=
 =?us-ascii?Q?+fdh4DDVyDubLZJyLQt3njIcfRNFPCHaIpSmE9wn5ySNd2YByO9I9w7pep2l?=
 =?us-ascii?Q?uQwjVoXucJ8cE3VbloLw7SnZ+n/qbIiCjuSybxPQZED57NgQLxqlaX6PryB1?=
 =?us-ascii?Q?xQT5VVNkgEj0Wp69wSoTO4QdEHl/oumlnr4W98nApDqynMhNLSUeR9OwuZXm?=
 =?us-ascii?Q?I2InFqu4Paj1Q1FDgla+gcN+xD6VmwUw51KCVE7yZZRwz85p5rvHREIlpnXN?=
 =?us-ascii?Q?rpFNEHKIQFdzDX13n5cXxbTU08km/lEQanTn4Ef7ZktMyfhpWNQuk4e8mBq2?=
 =?us-ascii?Q?nsa65EsvXc0TpXYLAuVI1Y0FhJt/Y2txqEiIWWRoDDUjpAxBQIaDpZwjNoJV?=
 =?us-ascii?Q?q7C5bP/T86I8MwsTG081t4p8dfh9NeZyMa93o70KY6pSwcrjsy0p3tsvWFhJ?=
 =?us-ascii?Q?1Clzih7MMTlPHilNwVxzOSD71n4EU7GNxzqUsmBfc4peDyVoass34Z3LNEAE?=
 =?us-ascii?Q?au0p7bYgpsaIslVYJ7nkZEaIxB17INchN68OvZhFP29ehdBjq6pc3YbdhHtk?=
 =?us-ascii?Q?d+uU9NkwZLCdLf+DTuVmu2A280ByyNf/kCVLE1j+4kBgsCkAYPWQ27nkMqT0?=
 =?us-ascii?Q?MyOLt+l6JHg+ClKFNtkbFiRRu/fsvd0DVl9YUUP+WdyTG+6gZyxC429Rw5r2?=
 =?us-ascii?Q?6Tnezycl+iVgdA0Aqwls1XPPS6oPT/Xa0+K9Tty6zJaTEod/r823jlLsIm9D?=
 =?us-ascii?Q?koEhdZg32jBuHJkoo1jMGOwNE8RI70/bfa6i5+3rXfyL5aLPmmV3OSpFJBV+?=
 =?us-ascii?Q?aJKrc9PByJgnDSfreZRjcHan4jQ/0YrOv8+Alk7lBCQug7mKbItg7W7cTSAF?=
 =?us-ascii?Q?Vww/tp9nlqzJ8PuOYswSgxZxLM3/TLgV9d71Npa40nMEsrVWKf7JVsPHysob?=
 =?us-ascii?Q?TKqVICdd7iVSomm7hEWU/AAmMMY0fcH91UTQDvnoSOnVBB3nMaboDqpDINcZ?=
 =?us-ascii?Q?e+1Imo383VGYnMuQ8IZdsY+GhALBGzKd49ahDmxX9rdOtbnnrg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 07:24:51.0029
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a9df382-7448-4868-820c-08dd02eb18a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022575.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6115

Remove unnecessary CONFIG_NUMA ifdef around numa_add_cpu() since the
function is already properly handled in numa.h for both NUMA and
non-NUMA configurations. For !CONFIG_NUMA builds, numa_add_cpu() is
defined as an empty function.

Simplify the code without any functionality change.

Testing: Make CONFIG_NUMA=n build

Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 arch/x86/kernel/cpu/common.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index a5f221ea5688..e5b128fc8184 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1906,9 +1906,7 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 	/* Init Machine Check Exception if available. */
 	mcheck_cpu_init(c);
 
-#ifdef CONFIG_NUMA
 	numa_add_cpu(smp_processor_id());
-#endif
 }
 
 /*
-- 
2.34.1


