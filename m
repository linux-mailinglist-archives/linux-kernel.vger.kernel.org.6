Return-Path: <linux-kernel+bounces-327135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 697E497712C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 21:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 309252886DC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 19:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31ECC1C3F36;
	Thu, 12 Sep 2024 19:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lXCmtF3Q"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF271C2DBC
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 19:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726168168; cv=fail; b=Y5KskVWdwMtNY1Uax9sQeJbOGcKmPQaJeUXL6UTjX+LXEeaVYMsJvUv41rTytJMZLXb9gmBWgz5F32RK2DUqHdQFHwpqXqw/KCPhiyXm+NyDiucbkUONd9Sx9DbtEhzWzn8ugS+QH11coWPsQblcgWrGyFW6RE/fp2xMcSxJG+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726168168; c=relaxed/simple;
	bh=9P3b3DTnw3IoN76wb9Ycc8bwBXf1cQMbHdYcD6s/89o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qMMhRp25cTk/l/+Cz6jF9YF/RlzR/9kFqR+5Q2E9apdrfkJCXZNviwJQmthVFm/+yhW/4V06FzySRhviyQYh0pGdA5O1TtNsuih4KiJ85My7rxhODDwtqGttYu4o4kNQQtMMkI9TPOiFVamS7gEtsFghz6enZWgk379lkbNGZdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lXCmtF3Q; arc=fail smtp.client-ip=40.107.94.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O8vhJZlXBbxkA9s/gphuU6gWaiv22bDup5lRNBGPIhp46p1K7miEAHmwBOq5PkYn1LgzGrW+GqsdRWyDfhnTF8BqLALQUeb4Tljga0UweVTprCQ93aAYUxuxGSSKfhtMR/Ia9YWtr8QuOaoi26AbFK68IMQbfFoFIU0EdO1HxIX1wQOPG2iKFecaBd+goXYr4ZZFMWacUYtFc1Y+xaQVxLPAZU/cjgdhrJ/w97eA8SJnoq23DsHnhNqqinoaetcPHyLIRg3UttP+JcXM7W3oC3/38FIkmmNFy26HEj9FRv/7A1QC7T46KP5xS8uqf8yHl6b3OkiWaGcMuCJDjIT2HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vOnhZl306dgbotDr4A7yJU2nnfN1BN/++T4obRIKwQE=;
 b=ao/WY0lvYZpK/rtyMjYZ9O2cUFLpp85Boemv0ZtMmc71EPHX4ViOvB0i2V1H1Yb/8NDHJ5OTyu3mY1LU1yh3zYZUyjFYvKR6C8ia2ZAKxkAANyRtDsTVCDo9UbiBal0j3kg/0USC7ppkFkBiJg22u96GL3I3ApfAw9OlRpKJGrCZpEBG+SeES8jaVdVDHOzsN24/bUhRWkOTlxQk4VtX6lfNNfGNKjww/5+SPs114mmUMULkI7aNzV67SYFR/e6RHEtZYcjk+ZXaZG8IfTuBWvpy3k6mWnXPk2w5kOh/ZaP6EwrHE2jWG/1Su0Bx59B+PE0OMu6IgqfB23E6WPYGlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vOnhZl306dgbotDr4A7yJU2nnfN1BN/++T4obRIKwQE=;
 b=lXCmtF3Q8w0GN3km2tdpromYgVbKXl3bpOHP+RsewfSNkRGUu9zO1VSPOehwNRWCv4pdqR9/+WJ0aprdw7fhUjbDyTqkyTZ8IDsvpNlLq9WE19JGOBUBywa6kQheQeVsV4JJnESIaMJWyqhO6w4vrHZqrwQj1nc9oN99wv1TCbw=
Received: from BY3PR10CA0011.namprd10.prod.outlook.com (2603:10b6:a03:255::16)
 by IA1PR12MB7661.namprd12.prod.outlook.com (2603:10b6:208:426::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Thu, 12 Sep
 2024 19:09:21 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:255:cafe::fd) by BY3PR10CA0011.outlook.office365.com
 (2603:10b6:a03:255::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25 via Frontend
 Transport; Thu, 12 Sep 2024 19:09:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 12 Sep 2024 19:09:21 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Sep
 2024 14:09:18 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 20/34] x86/bugs: Determine relevant vulnerabilities based on attack vector controls.
Date: Thu, 12 Sep 2024 14:08:43 -0500
Message-ID: <20240912190857.235849-21-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|IA1PR12MB7661:EE_
X-MS-Office365-Filtering-Correlation-Id: df9c1a0e-7e9f-46dd-75d1-08dcd35e68bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rfscIIa6SM41fI/KAkNJOZegfYQBkpk8FxhVNQ/PGHGu6oiyKtkLxsKf6Zmm?=
 =?us-ascii?Q?fp/IBa0q0UaxvuVrvqVUkjHIq8swu1OBKiRuiK8pU7hdghONCYfQRiFoFk6F?=
 =?us-ascii?Q?0zyv9eN8tV0M2b2bMDmZ8Cbbs6WKYzGNoi3FNmTQvnOR/RgKaTY9dUWeNb7w?=
 =?us-ascii?Q?xaCVag7NWA4/qDBlw2a2KpB/AMgrjauHRNvrKl+WRLiApqOn0LjK1rmM/rVq?=
 =?us-ascii?Q?pe08htcFGMeCTLH7oWHaNgfqtDaOJXq/TCpwGKbPoJx/f1lRvrRfSqxT+wb2?=
 =?us-ascii?Q?WMpgfOEBPVdmduLnO+25AFJqHaGx7z6Kl8nJKGNHa3CNDoQ+3rUdTdP81fG3?=
 =?us-ascii?Q?sJNXyEoxLdhZxH1v6Gyz+qAH4xgvYoPPyQuIsxKOl3x7QF2Aipug6sU+jbdN?=
 =?us-ascii?Q?yS2KR5XzbPycaL3xtDLzZb/lAplJoMuuPIvBemL+sSfnAeYVYW1eJFEXK/Pl?=
 =?us-ascii?Q?wSfoC3fYmm5s+3Dcuw4Kuhmkhy9C7DhJt1xG2dYi20zIhRf7oqSzAd83vuTf?=
 =?us-ascii?Q?FOqGjnCbxeX3ki3xi7QFNPKEwQhPlZejoqTPoZeKthEnXTZ//TU0e6sSC9jz?=
 =?us-ascii?Q?qCY5/DbV/uRgawp8gAvMLdN9HcBUpSBVSCuVi52AEkvTqLtQyuGVdNkw9vrY?=
 =?us-ascii?Q?uS/nuuJZ5642P1qtTKFDYfnX16RFwMUKhy7cT+oHZ8SN1/PnCI1+SWVm9V1b?=
 =?us-ascii?Q?K7b57Pqn8lUQYBdA1K3fxg5nBqwDiQh18bOOP1/xYwRpYykXaJcf8/9GLeMM?=
 =?us-ascii?Q?XsMMBoV1eW/EDe/TBzWi59Z/Rsa2QIbigiQlAi36nhRGI9SPi+kvuK62UQt1?=
 =?us-ascii?Q?8bHQDjatj+mV4hYOVUKrg4L2RmD+LnLKgoRSeEu0wbgb6AmsdX6j0jv7lM/Z?=
 =?us-ascii?Q?+BNYmbvl4DUcsb6ZAJGHL9UD31wUf1GsbDCgdLIjUlYC9HGgDpTqVcbddV/Z?=
 =?us-ascii?Q?O9exaeOh2m51xKi1O6PscsxwmsKu5IbAgxrIT3CGO4YmZ4tJo+5Aw6pMegrA?=
 =?us-ascii?Q?uocAiLwODRHLceZUrk76kgV1yBo47mWfOhQFPonv0fj0gUDB1/A8IXA7Lxjf?=
 =?us-ascii?Q?/g1vto4iUBfhSF3bqwRRYwMqiI/Ykx3RJyhQ3JZ8pHDDAe1U5jf7nuQAihBP?=
 =?us-ascii?Q?4XoLVywqPl/Bwh7EuLl36YNDEDt83zcKaQO7rThbZz1cfNf6sKf871rQz4em?=
 =?us-ascii?Q?VLvSawak16rSe/oYimWLza3bp6hl2GRKJr3zo4g8W84sXZgcuo+i34wz7VEE?=
 =?us-ascii?Q?KjqEtxPtIlUpCKj3VboTSmdXxSlWXUh3qtxXe9Q1f+xpx2vikSp3X0ePwhq5?=
 =?us-ascii?Q?pC3vn5uQudeewVbKwKXcg3FKrr//WBHRs3KNZqveVq/+enH2d3f6FEFbVF9w?=
 =?us-ascii?Q?/OWJvGCAH4p24xny8FPPegTEdLo9fRi2IMtKgnwiqQxuUqUJsXGy+EptEFl2?=
 =?us-ascii?Q?FWgk53YGfy2T7e2N9A0yiND8ncm2MtWM?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 19:09:21.5929
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df9c1a0e-7e9f-46dd-75d1-08dcd35e68bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7661

The function should_mitigate_vuln() defines which vulnerabilities should
be mitigated based on the selected attack vector controls.  The
selections here are based on the individual characteristics of each
vulnerability.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 75 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 334fd2c5251d..a50c7cf2975d 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -287,6 +287,81 @@ static void x86_amd_ssb_disable(void)
 		wrmsrl(MSR_AMD64_LS_CFG, msrval);
 }
 
+enum vulnerabilities {
+	SPECTRE_V1,
+	SPECTRE_V2,
+	RETBLEED,
+	SPECTRE_V2_USER,
+	L1TF,
+	MDS,
+	TAA,
+	MMIO,
+	RFDS,
+	SRBDS,
+	SRSO,
+	GDS,
+};
+
+/*
+ * Returns true if vulnerability should be mitigated based on the
+ * selected attack vector controls
+ *
+ * See Documentation/admin-guide/hw-vuln/attack_vector_controls.rst
+ */
+static bool __init should_mitigate_vuln(enum vulnerabilities vuln)
+{
+	switch (vuln) {
+	/*
+	 * The only spectre_v1 mitigations in the kernel are related to
+	 * SWAPGS protection on kernel entry.  Therefore, protection is
+	 * only required for the user->kernel attack vector.
+	 */
+	case SPECTRE_V1:
+		return cpu_mitigate_attack_vector(CPU_MITIGATE_USER_KERNEL);
+
+	/*
+	 * Both spectre_v2 and srso may allow user->kernel or
+	 * guest->host attacks through branch predictor manipulation.
+	 */
+	case SPECTRE_V2:
+	case SRSO:
+		return cpu_mitigate_attack_vector(CPU_MITIGATE_USER_KERNEL) ||
+			cpu_mitigate_attack_vector(CPU_MITIGATE_GUEST_HOST);
+
+	/*
+	 * spectre_v2_user refers to user->user or guest->guest branch
+	 * predictor attacks only.  Other indirect branch predictor attacks
+	 * are covered by the spectre_v2 vulnerability.
+	 */
+	case SPECTRE_V2_USER:
+		return cpu_mitigate_attack_vector(CPU_MITIGATE_USER_USER) ||
+			cpu_mitigate_attack_vector(CPU_MITIGATE_GUEST_GUEST);
+
+	/* L1TF is only possible as a guest->host attack */
+	case L1TF:
+		return cpu_mitigate_attack_vector(CPU_MITIGATE_GUEST_HOST);
+
+	/*
+	 * All the vulnerabilities below allow potentially leaking data
+	 * across address spaces.  Therefore, mitigation is required for
+	 * any of these 4 attack vectors.
+	 */
+	case MDS:
+	case TAA:
+	case MMIO:
+	case RFDS:
+	case SRBDS:
+	case GDS:
+		return cpu_mitigate_attack_vector(CPU_MITIGATE_USER_KERNEL) ||
+			cpu_mitigate_attack_vector(CPU_MITIGATE_GUEST_HOST) ||
+			cpu_mitigate_attack_vector(CPU_MITIGATE_USER_USER) ||
+			cpu_mitigate_attack_vector(CPU_MITIGATE_GUEST_GUEST);
+	default:
+		return false;
+	}
+}
+
+
 /* Default mitigation for MDS-affected CPUs */
 static enum mds_mitigations mds_mitigation __ro_after_init =
 	IS_ENABLED(CONFIG_MITIGATION_MDS) ? MDS_MITIGATION_AUTO : MDS_MITIGATION_OFF;
-- 
2.34.1


