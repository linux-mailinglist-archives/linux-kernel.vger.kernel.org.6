Return-Path: <linux-kernel+bounces-327149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7CE97713B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 21:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F2121C2222C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 19:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3DB1C6F50;
	Thu, 12 Sep 2024 19:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="erxsbkol"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C710C1C4608
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 19:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726168173; cv=fail; b=MhR11E83kgpEqww4syA9pf03LttakTra0spwozgE84gGNTFGyvR7AjJVZB3nLUlcwyMeU4iLnD50BTMiP4fLsElMMoHUCn9jR8EHVoeAGFZ3Q4xSbAbXTNqwJ5SdVzm9YTDdFLXiLhj7LaJhnrOBUUd8dGDboh0UO5rlyaJqjro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726168173; c=relaxed/simple;
	bh=cBv0J6LBlDXlGa2fDVgtKnFVrjSIu0zyCrBsj0gnB6s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HI+hlvLjqPx6sFjWmb+To0eug6pGfRxYgijhT3EMviMl4dTZ7A/0xJ97J7kIPCmYcnVEtKWoS5eDpUTjpzeXSvZEfDOVRchYohow2hEXDazPi5xJ2Jf30cv6vmSfgfPLwHpyFSqs6GrErWRF604pn7Gncxp/PvA56E9F/Rlyt8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=erxsbkol; arc=fail smtp.client-ip=40.107.93.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p3b1YrH8MC6/sBR8lBmtyIRrZfgzPmmBYm5uDM/FSlghEtWGBYEPflGJnMheVQAPxuy1ZNbZjSjAhbDCeH26dkjWkn+V5kFxQZCIWjMJv0sNRVpuiaD/evEzoC/EzSwB1uts/+Ee1SCykFb7YZ6nw1ixQ0eBkHebUdaJDx/7/afuIWJ8xFk4mkoID8/8eFVcbA4WS8hZNgLxY0FGo+jkGGtMk2zkfhPB/oX91eiz03TpdL1M1CEx6xDV+bR4Cp6P7Zsbx4OwbMGch6fnIpTywm/A5D/UddBXoUBbioG3XW8xyNR3/1mUzuqY7IeznqPao4uS+VW8mMhapfHY/4psXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qwmf/98M1378DFoNqnQuN+ihIvtqlgRKY+AdNWqtR4o=;
 b=KATSXKSm35Z05LcwMeb7JR2JICvJ6ZK9Y6B3B6dhvhQ9RcZ99LDo+xXqJCq6/woLOZa6JfHAErRLIqF1/o47m1kh8bdZ8HOTZ6/WtGVp3gkvMbsAtVlzvF69SZnnrkWXb/4RKQLJR/r2/7A+I9+n+6RX8/1XCP9/dMP/3jFmf+AePOuZU484LVeZsgvLduBfd0Pq0HC/Oxg8tWU2MDiwHBaH0w0zS5Hcx2B6T/sNgLG909Hcj6J2MRkiN76LRuBPdAI6uqAw7gpjtBwY/AAFHXSt9NgAsc4N7X4rXDcPmoovtdkZrzRdFx4md5PCtVv33vLcnotgKYMkFkJbo37ULQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwmf/98M1378DFoNqnQuN+ihIvtqlgRKY+AdNWqtR4o=;
 b=erxsbkolpIr/hP1TxBeksQJOTm7Y41Rwe87yXSp1rzTEiKhOek2suEdB1WCqyQlDWDUikUeFokoTKrrQG5BeTqjGhCx6xptC0L1Semc6M6GKG7JvyHje/obNh7tgzKAmMS8Ed7IDcEx/rCGycR7UPFTiYeN5PT4aPhw9H+6wtHQ=
Received: from MW4P222CA0004.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::9)
 by LV8PR12MB9134.namprd12.prod.outlook.com (2603:10b6:408:180::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.19; Thu, 12 Sep
 2024 19:09:26 +0000
Received: from SJ1PEPF00002313.namprd03.prod.outlook.com
 (2603:10b6:303:114:cafe::3c) by MW4P222CA0004.outlook.office365.com
 (2603:10b6:303:114::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25 via Frontend
 Transport; Thu, 12 Sep 2024 19:09:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002313.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 12 Sep 2024 19:09:26 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Sep
 2024 14:09:23 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 31/34] x86/bugs: Add attack vector controls for spectre_v2
Date: Thu, 12 Sep 2024 14:08:54 -0500
Message-ID: <20240912190857.235849-32-david.kaplan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240912190857.235849-1-david.kaplan@amd.com>
References: <20240912190857.235849-1-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002313:EE_|LV8PR12MB9134:EE_
X-MS-Office365-Filtering-Correlation-Id: 233b530c-7cc2-49a3-1064-08dcd35e6b91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3bA65fB53JD9FaCv43E/LuZLbjB7l4bCeyrANRZ39KEe8luUMlTmoimgBLJc?=
 =?us-ascii?Q?1/QrhdniTdz9J4sDxdns+yuDku52wE3CEPEEaXKdlCrLGXHvw78UwmctOzCi?=
 =?us-ascii?Q?FnMyIoGX05HyUUMI3kVtFaU0PmuJ76mIWVuDEuzyLIQi/3ulYH2q3nEWwZz4?=
 =?us-ascii?Q?GcgEJJ/Nf1fp5oEn2TEUuyfHQi99PRNa7YbMAjMicgoa+sQGYIwD4Sb8wbxg?=
 =?us-ascii?Q?zm8twd/sZVTrMTP0EZRzI/aHe8DRSYpigMThQzAE93zh6l0ki5tmmSeit6aj?=
 =?us-ascii?Q?QsfipOAws88KW5vYcFicSFFg0tXTKfu1T/qI+3JFiEFDbtGw6NlESxIEcZaa?=
 =?us-ascii?Q?3xk80Pbix2AkAAFfufsXMALFmOyEY8RtgLec00BDXCqmThBxmMOCcs193I4c?=
 =?us-ascii?Q?TtCyApEilw9CNI7s4a6/PpGBN7x7NRZTKNpdNA5TGQxF70g2qRP2AaF/1b1s?=
 =?us-ascii?Q?rzfjaT4M7FzZQuIxJ5q7w5+RaCyNOzHSSk8n73ra5TxWdBRLMYl04yawS6Nn?=
 =?us-ascii?Q?3c3FRqgNT5dC0Hofg+GDS2d1lfHZFB2Kjfbi+bNBAWfb3Yx981/4pXDm5ldY?=
 =?us-ascii?Q?hIys1pgtAaQV7YfygBW+PSL220k9HIzEcXwgNDZNnJ5XHz5/EKafKYRjUiYq?=
 =?us-ascii?Q?tTwlsGkHiKfj0SWG66tuMQ2sLG8r3m6dBfGnBtxd+xdfLfudoa8GXUDdUn87?=
 =?us-ascii?Q?PzMXZDe3zez6XvRWpFIeP1GnI29zduiRUkjqNytNZNUrkD/GfVgvwZkHTLWM?=
 =?us-ascii?Q?bYCRUrGE8a1ZvSi4E0eAQ3dqXL1/3dN28WZIkGeyvn6uoUnlX0E8t7niV8KQ?=
 =?us-ascii?Q?fsLFL/lhE34UEJPt8HdVsszozG0iETCcczgBEbPVaFYERuaxiAWVhdtRPkP3?=
 =?us-ascii?Q?ZtIOQx6DW4T9DUvBRLTYH2acADpTXLsQzReZ0XbuvF2uOd7dm3/ut61MBqMu?=
 =?us-ascii?Q?3TfI9ggJzCGKcW4ByRS+wHf9IvTG4H5LuUPu8i2ujWzPeBAB3JZ3DoG7Xo9f?=
 =?us-ascii?Q?2/DYUCvdZTIwLrPRPnxDdTMrIxUVPwEkzHDBbpg5hNAgMJQkEmkjAYX+MvRs?=
 =?us-ascii?Q?yVWEt8S7uwxhjq9uNtA/fZaDAe2V9Yf+XItpEK6vjXbDc9lshhIIdSPcqBc7?=
 =?us-ascii?Q?NUCnJLo65OsXVh7eIX+hhNf5WR4wJW72GV690Usx1m0/3rLjQtMC7SoeX7Vv?=
 =?us-ascii?Q?4R1xAVLHXgs/BTx9pe47CyoVaku4vVMty/OgB44xWNfA+Fcg5Oni5ZgW7CEq?=
 =?us-ascii?Q?KeTl/Kx8VlVm4/dVruUzmGK3/9W2aSQADsEW/qQiJzU5iWnNj1Kg/bo51SNH?=
 =?us-ascii?Q?6bKtyJ/yBFC8a3EnDXy1ttQcuTq1e10QuNCFTu8KMeTRqT+6xakKM8rkKTNw?=
 =?us-ascii?Q?LSOAor2M0QT7sP0b1nXSu0ZC2eEOnSZY8T6a+uZJgiyi2/0s8sCzRkXJ0pAi?=
 =?us-ascii?Q?kYhMFLpwlKjmYKStVY1uz72Ms2p4OvtY?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 19:09:26.3260
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 233b530c-7cc2-49a3-1064-08dcd35e6b91
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002313.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9134

Use attack vector controls to determine if spectre_v2 mitigation is
required.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index cc26f5680523..9c920e2b4f33 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1957,13 +1957,15 @@ static void __init spectre_v2_select_mitigation(void)
 	case SPECTRE_V2_CMD_NONE:
 		return;
 
-	case SPECTRE_V2_CMD_FORCE:
 	case SPECTRE_V2_CMD_AUTO:
+		if (!should_mitigate_vuln(SPECTRE_V2))
+			break;
+		fallthrough;
+	case SPECTRE_V2_CMD_FORCE:
 		if (boot_cpu_has(X86_FEATURE_IBRS_ENHANCED)) {
 			mode = SPECTRE_V2_EIBRS;
 			break;
 		}
-
 		mode = spectre_v2_select_retpoline();
 		break;
 
-- 
2.34.1


