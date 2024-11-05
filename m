Return-Path: <linux-kernel+bounces-397203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1992D9BD7E9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 22:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DD2F1F250E1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 21:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B124D217446;
	Tue,  5 Nov 2024 21:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0WvmwPxh"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0E22170C2
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 21:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730843738; cv=fail; b=Ai52yxM5L5O3msL6j5xaisoOfEEhI+n5kd+7SnSicRaacfIbZWpara1q1InLKvzXjb0vS0mR08rhfEsW4bXs4damA/OGjs8PoJHkcalGK7EQCwGhHELYvHYQVfUKKkWmyFisr6kZXyMyR0GA8qY5fOPw7eI6NcNDxXfvrZGRI5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730843738; c=relaxed/simple;
	bh=YoVd45v8SjqjlvQpXIhAIIH7vZBE42ymmmPpPyqgM9g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H6z2mXSGuUmmRR1X03QvKORqCP7H3OAO95v2I0ECW9gCfKenQYvSpUnIqrKoYkBx1+98SbE+2Tcqn7uPqTo6Jmw5qH4otiM8aJ4na0vg+vlrZ7e3Y/02Tj0bjEhWbnIg5lm7UbvTyrsNYPuAfv74fb35AOK5YzmLA+46EzRlSHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0WvmwPxh; arc=fail smtp.client-ip=40.107.243.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N2ko6qUen4quxBiBDiexZ1ximLitIHhpqV4yEqACPegOE21KLRHiG0/YXLr4Ens806/u8oPjvPnj/uU+tnYOauYGncp0/9aj+6qy5qc5BpEGEVKSKvQGAAzXfC+zAkTeQ0ASlVQTcOAHvRLj0/BGywHjsI7+m40JbvZEyk6MTE0pE+R0htX9gVVf4qB1WiLPuRQqnEz/83HpFB5HQQ4kP+klWcBxzcPcOH8dm8XZs7CbLFClTTSBmod3ip2U4zPCWBhCNW7H8MDESfu6osZj47o2mvHwGKbGvlSSlxQocCek7RNVjqHE3LfloaEy0Eu1ucbuyvE3h4tZ5fn0+Mwpfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aowTDZHijdaWRgdSnSefFPfXbWrX+gn+U44Uq6dZTeo=;
 b=cufdncv0+Ph9N2g50nCM0j/0Cls727PvrLWpjGDoz/lZluI7hT7TpsrRmBRxRq8Y3vDamHdoD8j+ZyR3Xd6JEUTQOePZoVac9hfFq/wJvmsj3+Crd7mXP06EOP/ikPZAsw8tdIxCZ3P63XGG4imS4QAgv17tU7Mg6mxaMh+mJF3GyBvtiXvLrPRQvn2MVzldKNnljgj+Y+fci7mHoaQ/IOZATDy81l+bSWX44kEpmBL5C7N3wn4xRyYrs2yK8A4g93byN1EHgQruYGX6ics44lmXGYbGDEGY/5qRJyTNIfjVY4oohaE1y4xQCP75L//1IRl0lMW3BY8R9uAhF5EJlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aowTDZHijdaWRgdSnSefFPfXbWrX+gn+U44Uq6dZTeo=;
 b=0WvmwPxhhXQixKdwockqIfuwyo+monjMz/vwbv5QAIUCsdKV8bKbvNZheIhGXOd7wtF73C35KR74o97+cNyqEY+X6GoO++rurPlx51gQ/iFIdPCjYm9kCLohyA383LHtv6zMECtn++Zr+NL7ObLXhETue/IMfzZh527u3dyoriA=
Received: from MN2PR15CA0051.namprd15.prod.outlook.com (2603:10b6:208:237::20)
 by DS7PR12MB6096.namprd12.prod.outlook.com (2603:10b6:8:9b::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.19; Tue, 5 Nov 2024 21:55:32 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:208:237:cafe::8f) by MN2PR15CA0051.outlook.office365.com
 (2603:10b6:208:237::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18 via Frontend
 Transport; Tue, 5 Nov 2024 21:55:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.0 via Frontend Transport; Tue, 5 Nov 2024 21:55:32 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 15:55:29 -0600
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 16/35] x86/bugs: Restructure ssb mitigation
Date: Tue, 5 Nov 2024 15:54:36 -0600
Message-ID: <20241105215455.359471-17-david.kaplan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105215455.359471-1-david.kaplan@amd.com>
References: <20241105215455.359471-1-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|DS7PR12MB6096:EE_
X-MS-Office365-Filtering-Correlation-Id: 22057b3b-7d70-4f5c-975e-08dcfde49249
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6D85KTzzayGY2sGNzhCpqcd28RBWL20P3OPdqJgqDa+szVe0SQHbSJH4jCfU?=
 =?us-ascii?Q?r0cQNG4piU0H0s4bPYhs/kPs+7yewpGKvTiASpL/L9Q6tEX/f98UNCm/vk7I?=
 =?us-ascii?Q?szrNBwHvhzv4oAD0DorpPKWLwrEUiYKReGmRmagWo3nKI6KKK8xuRI4/dR5g?=
 =?us-ascii?Q?vASxyHgsG9JGsjIPACXYK74j0voZ8P+HdGOHmgln3op9o3A8htMYd5pvloWH?=
 =?us-ascii?Q?55AqCoXf9LYMCFClfV9+ci8F909tIgz054/XuxjfEtfRtnVUW2qCPUa/Prwo?=
 =?us-ascii?Q?rJTC9VWr2wB8wkBtQhon2wNVWCYm0qeg1EUfRDjc1AlXASzPfCgZpjql9ykD?=
 =?us-ascii?Q?ARyen89Z1LzPKXE8CzPSnjpg76VohOXLGCMIDtbHLXyGz9eCgBicMbupTDjn?=
 =?us-ascii?Q?+ROdlV95ZWkEcqOsq/k0MCKIupca9fjKEe6tbMuFXdeJb9VcMB0zoqXylor9?=
 =?us-ascii?Q?JFHjnyUvJKQ9BX80h0oCeYJznF1fkgui4oCp3i8OGwV73HdBZZm9RB/FH2Ha?=
 =?us-ascii?Q?QTW5C9t1HGZW4fbss9q7ETExzoS39lTsVu1aOi+fb3/3FV5CClQAMXL+x2df?=
 =?us-ascii?Q?lhAEXCdNND3aWC7xlon17UW9ZTan2u5u7LfWNcbpQAnng72+VN2cVxrdg0pA?=
 =?us-ascii?Q?GUY2TWLGV5FpT/UFrIMfl4UhA/Z3lAMx5LcNsjWk11oRFKRzdVGFpk4uy+go?=
 =?us-ascii?Q?v6eIzrW3WcYM+q1xO1SL2bJH5lHR3ICVviCzfjNIZ/REQHvUJIQvhcFb+gQR?=
 =?us-ascii?Q?k3to35xds7WYngYNx77uSJRyyr315jIDF7Bz/ptg3qi3aptamtwko03ZHe0y?=
 =?us-ascii?Q?HypaiTWoxKUcOETcgMXJ18d/qbFO5AuLoiN0UyUl+IjNSFylGMn8YjaNlbIY?=
 =?us-ascii?Q?9BlW2cRgM+8GZ6NTc61stiZB58Po8rDcToF/6D0RxMqdMvuQ/NyPY9LZkZHw?=
 =?us-ascii?Q?XBt48dLWl6dO/E4xj4yqyGrukEbmCxtc+ZbzlP04QOMeACblM8AQMxsk8mHe?=
 =?us-ascii?Q?X2mxzMkYVcct77P2rWT9HSKJ9s92uwWUK8SL8qaRPMDHoixhuw9fYlnhIqsW?=
 =?us-ascii?Q?QffWS2/a9J/KdoLtoZ0WLqnDmNAmENwsHnR3dHDqpgvsljp83xVUzpzjwf3q?=
 =?us-ascii?Q?E4GSirr2cxozUZimrSR5gMEoOEvkLjN4BMqVkczplmdwCgXogNmXM4oG81Gv?=
 =?us-ascii?Q?clxnZBhtVNgzCyJ/umNw6b1DpH6UYXqmf1CDw4/rxMTh1bjwE0VeKvQaMr4b?=
 =?us-ascii?Q?6yt2q5hDFFIxTvCyD+W/0/8NVVuXHDqnBwa8H3yCiwoZjudA2GIIwHFT2BQN?=
 =?us-ascii?Q?xAkdN5sprBG1vTYXEmwlkIWQH00sEj+tcvvScp3KCaRsn/Sq+uoqHa1qGmWQ?=
 =?us-ascii?Q?lJaCiGwrmkJqt3bYmvkrgjU4pRWKPyCONFfkTTNuijwCjuqtWg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 21:55:32.7185
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22057b3b-7d70-4f5c-975e-08dcfde49249
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6096

Restructure ssb to use select/apply functions to create consistent
vulnerability handling.

Remove __ssb_select_mitigation() and split the functionality between the
select/apply functions.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index ec5cc66513bd..a3bbb0831845 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -65,6 +65,7 @@ static void __init spectre_v2_user_select_mitigation(void);
 static void __init spectre_v2_user_update_mitigation(void);
 static void __init spectre_v2_user_apply_mitigation(void);
 static void __init ssb_select_mitigation(void);
+static void __init ssb_apply_mitigation(void);
 static void __init l1tf_select_mitigation(void);
 static void __init mds_select_mitigation(void);
 static void __init mds_update_mitigation(void);
@@ -223,6 +224,7 @@ void __init cpu_select_mitigations(void)
 	spectre_v2_apply_mitigation();
 	retbleed_apply_mitigation();
 	spectre_v2_user_apply_mitigation();
+	ssb_apply_mitigation();
 	mds_apply_mitigation();
 	taa_apply_mitigation();
 	mmio_apply_mitigation();
@@ -2214,19 +2216,18 @@ static enum ssb_mitigation_cmd __init ssb_parse_cmdline(void)
 	return cmd;
 }
 
-static enum ssb_mitigation __init __ssb_select_mitigation(void)
+static void ssb_select_mitigation(void)
 {
-	enum ssb_mitigation mode = SPEC_STORE_BYPASS_NONE;
 	enum ssb_mitigation_cmd cmd;
 
 	if (!boot_cpu_has(X86_FEATURE_SSBD))
-		return mode;
+		return;
 
 	cmd = ssb_parse_cmdline();
 	if (!boot_cpu_has_bug(X86_BUG_SPEC_STORE_BYPASS) &&
 	    (cmd == SPEC_STORE_BYPASS_CMD_NONE ||
 	     cmd == SPEC_STORE_BYPASS_CMD_AUTO))
-		return mode;
+		return;
 
 	switch (cmd) {
 	case SPEC_STORE_BYPASS_CMD_SECCOMP:
@@ -2235,28 +2236,34 @@ static enum ssb_mitigation __init __ssb_select_mitigation(void)
 		 * enabled.
 		 */
 		if (IS_ENABLED(CONFIG_SECCOMP))
-			mode = SPEC_STORE_BYPASS_SECCOMP;
+			ssb_mode = SPEC_STORE_BYPASS_SECCOMP;
 		else
-			mode = SPEC_STORE_BYPASS_PRCTL;
+			ssb_mode = SPEC_STORE_BYPASS_PRCTL;
 		break;
 	case SPEC_STORE_BYPASS_CMD_ON:
-		mode = SPEC_STORE_BYPASS_DISABLE;
+		ssb_mode = SPEC_STORE_BYPASS_DISABLE;
 		break;
 	case SPEC_STORE_BYPASS_CMD_AUTO:
 	case SPEC_STORE_BYPASS_CMD_PRCTL:
-		mode = SPEC_STORE_BYPASS_PRCTL;
+		ssb_mode = SPEC_STORE_BYPASS_PRCTL;
 		break;
 	case SPEC_STORE_BYPASS_CMD_NONE:
 		break;
 	}
 
+	if (boot_cpu_has_bug(X86_BUG_SPEC_STORE_BYPASS))
+		pr_info("%s\n", ssb_strings[ssb_mode]);
+}
+
+static void __init ssb_apply_mitigation(void)
+{
 	/*
 	 * We have three CPU feature flags that are in play here:
 	 *  - X86_BUG_SPEC_STORE_BYPASS - CPU is susceptible.
 	 *  - X86_FEATURE_SSBD - CPU is able to turn off speculative store bypass
 	 *  - X86_FEATURE_SPEC_STORE_BYPASS_DISABLE - engage the mitigation
 	 */
-	if (mode == SPEC_STORE_BYPASS_DISABLE) {
+	if (ssb_mode == SPEC_STORE_BYPASS_DISABLE) {
 		setup_force_cpu_cap(X86_FEATURE_SPEC_STORE_BYPASS_DISABLE);
 		/*
 		 * Intel uses the SPEC CTRL MSR Bit(2) for this, while AMD may
@@ -2271,15 +2278,6 @@ static enum ssb_mitigation __init __ssb_select_mitigation(void)
 		}
 	}
 
-	return mode;
-}
-
-static void ssb_select_mitigation(void)
-{
-	ssb_mode = __ssb_select_mitigation();
-
-	if (boot_cpu_has_bug(X86_BUG_SPEC_STORE_BYPASS))
-		pr_info("%s\n", ssb_strings[ssb_mode]);
 }
 
 #undef pr_fmt
-- 
2.34.1


