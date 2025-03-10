Return-Path: <linux-kernel+bounces-554711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5194EA59B6A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7CC01886F85
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A65242923;
	Mon, 10 Mar 2025 16:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3r1HOkhZ"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2052.outbound.protection.outlook.com [40.107.212.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B4923F39E
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 16:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624878; cv=fail; b=jqQd0QdwpYDsBe0I7QcS6gHwTNaRkU1SBuXvX3GWT0XLJUCO04JRKcYCHA9ql9k9+oqRU8LLzh2ykmkG4Ux3ZO7L9WpLArV2wiCX95fF5u3Lf+QgnUVBCznge5DY4mvqfTq7zW8W4Dxlt/Eh6W3x1ic9F2nCDDFOjIQLdC8pPGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624878; c=relaxed/simple;
	bh=1uyF3pxoJvpXwQnoVW5igKZWXr2+/z/em1EQ0Wzax5M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UfSjE3U/hUtrDZMonwx+/KwOEpJ6c+STNzQ5mfP3NWBTu4qBx80wHogHyytd+0H24ABGFeFQDAG1y0W9EhxDgAWbYcucMxQs/oNhZEgaBc0GmeR64qqO8x0jhplOay34DucoSUOPhxyoQoe0kTLtBCme7s7VCyrDZ9EGgGbjPRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3r1HOkhZ; arc=fail smtp.client-ip=40.107.212.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I2VUBCcMTii3VBHMStd0GGZuzcPnc/yMbPzt/hycOfBUzWp77HRYHse3tgaKsNMrwo2P3Ne7aFs039NS8ES5LZ+yB3tKmiu8oDPmp5joG5ihufkNSyZHiOUfjO1CEBG/MfIxbpwSFMDUoxoQaxVknwNcVKI/ckuv6B8/EmkR/LN3+L5kkskJAw6Kz88keMjm0m7ssN3u9xDR41kcy29YPbcbx3H6eoVP7RlwlpWZEZZEp61o74nj5w8G+veQ+BhC2fIgp4rMKfkh43Ea/lMli12uHTdZUY3k9kss6cy4KEjUA2NK2+Nbv6qchrgegwOdQy7Aj5nufnvXDrSmMqLkxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uDpDb0TUY3HHLeSA95XrW4AnveGLRWRTDJ/3yCE3quQ=;
 b=kl5TFuVRNUm1jkBiWO8GnObPf3FjD5grATeUm7HW8rQJ+ixZtIRY2ZHE6wUqmN56gzmPo407sxZF7nGH2QsgUO4tlIDb+XoaWV7b3i+wEgokFL85n7eZnVxyc1O7zIqMfokBBr+IJ4QrwsbyEMj49kISzm5Jl63d5lJZxK5cniNyQ3o8PG09FLvsV1HS6TeibuvjR87JEgGMjvBXdJmHq3DxRSpLmFg2F+WIbQzYXI0rCWYL9IEhBSpevihMhyDmBH60jEgR4SHOjlPaiSzVzmkQJlg2Fp2cmOm6sP/pVOIKL3ctXwoDRivMsqn2RJmiBnSfAzw0/VEtiWUagyRsxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDpDb0TUY3HHLeSA95XrW4AnveGLRWRTDJ/3yCE3quQ=;
 b=3r1HOkhZCm+XtoVrIve5OrBQdWyg8LaztlNC7LZStFHqT69ja+TQ/FDYzMt4O05rN6keq8nc1TZPoDSZu9tHP89X9TRoUX5cvnKNDnCQfQ4IDrrkYa7h+k82f6UrYVP1a1WWSogbDVOKuPvrZ/mGK3mNjNhX3zUo7xuhMX87yZU=
Received: from BN9PR03CA0085.namprd03.prod.outlook.com (2603:10b6:408:fc::30)
 by PH7PR12MB7209.namprd12.prod.outlook.com (2603:10b6:510:204::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 16:41:09 +0000
Received: from BL6PEPF00022574.namprd02.prod.outlook.com
 (2603:10b6:408:fc:cafe::3b) by BN9PR03CA0085.outlook.office365.com
 (2603:10b6:408:fc::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Mon,
 10 Mar 2025 16:41:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022574.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 16:41:08 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 11:41:07 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>, Brendan Jackman <jackmanb@google.com>,
	Derek Manwaring <derekmn@amazon.com>
Subject: [PATCH v4 32/36] x86/bugs: Add attack vector controls for l1tf
Date: Mon, 10 Mar 2025 11:40:19 -0500
Message-ID: <20250310164023.779191-33-david.kaplan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250310164023.779191-1-david.kaplan@amd.com>
References: <20250310164023.779191-1-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022574:EE_|PH7PR12MB7209:EE_
X-MS-Office365-Filtering-Correlation-Id: b8ac744b-26d9-478d-377d-08dd5ff25c24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rJ7NPGW6uTsWYes48CaLeRcLZx6tqfhgoeyCo+rVwD5KrSTuiazRrwHcf88j?=
 =?us-ascii?Q?taqUCMAJSui0AxJWIQYaMLu/LtIVfQGerKjPM2T5/B8kS5M54dTx2sSFwc3d?=
 =?us-ascii?Q?Hw4rQ6ZKVoc0zPtzKIXXZRIjJ0pMQdeOM7/0rSyvxj8o1m7Uael42RAAu8KE?=
 =?us-ascii?Q?VCGmmIQBzbbSibMfAvPAL5fs4S1dkqEt7EtBIOvmLRU1IkfSFi9vjafger49?=
 =?us-ascii?Q?YKfW6edRGfeQA5lzdu2CrmDRxX5qIDoz5qA+pDYA492lqNKhvbT5u6TgfYmd?=
 =?us-ascii?Q?+73r5Vz8x3rLmsLPcrr3nG2TqdDE40ObLHXywAnj4D2AMMzpYc6xIgtcGvTN?=
 =?us-ascii?Q?/QqL3+cCYWbYC1zfb1L5STlDlc9o8lwp9IzpUHHoErO9LgyK/mK13Qet5u7Q?=
 =?us-ascii?Q?lGY0jDwIp82WhoLB8JQkSVE2Rt81mJhdroOB1XImdI8u2orCwh9CU6MjlsS9?=
 =?us-ascii?Q?QFYkDcmzdq2/7G0E1wbX2hbawCBf0DrGX5fU01HkdQ8dmrFOPXMeskjMC5z/?=
 =?us-ascii?Q?AmTjTpEqZpIu2DfcDGYkeg7gAKk19u/Q9YKa/EgRiCvFCEfNZxVuFXM38vuS?=
 =?us-ascii?Q?x8ziRO3xd+O2XOoBj7Uw2hmZ6rOKyZ19aMtasktgiptjjr2iYwEnV5eIcliz?=
 =?us-ascii?Q?GefEcLqS/d5eY44eXdg1idWSpvbFX/xQHlpRl6SXQzdgZh61ljmjDqBtnJQF?=
 =?us-ascii?Q?1yo5p9vmZYafalpfpdAQObvAmwsiuplU/aV3rSlrWS4rgWSqMl/SUMeKs2z9?=
 =?us-ascii?Q?2PWMX9PT7CbnGLnszV4NnZCAAD500HEHs+GN97bWX99G12XfRzPeHkZux5r/?=
 =?us-ascii?Q?nCGm8+gpa8SmfZNdw42LUd3AzV9E57/g2n6YGzqWyenzVPCfdSR0OSGgYjTt?=
 =?us-ascii?Q?WTPnnHwPJAB5gLDzxy6TWdKqP3ejSsVgFjrdBpYsFiPrGrJUigcnB/sGHd65?=
 =?us-ascii?Q?sfPO4iJ4rObLKUqGpUS4IMfWfpak2RDKizxpfgA2j5gKO/9lccDxTU4MADuX?=
 =?us-ascii?Q?MznsLWR+Ab7nWko+Ycf5FzgCxw0r+BcxZy60Bn7DkVuC9tW6qRjDK/MuMgnd?=
 =?us-ascii?Q?3jTd2vlUb7T8sq8a/7FPsg1t1RakGjsl1VItDWycAxAe7E6kDcYFzUXGzdv8?=
 =?us-ascii?Q?ohifLB4ifScEDsju6P0puP1YQmt4dCvW4MBvQdeMTNszerjxAHR/3E5KDemH?=
 =?us-ascii?Q?LNmbJ7JJm3BhkmP/klRguRRDccPHnxBXjYy7KYpbXQ45aTIiw1EjripC0kOe?=
 =?us-ascii?Q?jqKzDumHucieolJyeeAomNS5vXWKZP/Sn25bZG5tj/CXq7hEvd7qU/umoGmk?=
 =?us-ascii?Q?9nC99U/IqfC3N3WdSb8HDL9GSeiDcvOkJMJN02LC72NXAYf3OXp9l9T27S4+?=
 =?us-ascii?Q?ePFu754/6EmFt2fIXF7vsbm2dhtdJtETybh+X47aT6Q+WE6RmOMI1XGUuF8j?=
 =?us-ascii?Q?wjkpDknp9axs9xWmvP+34RcmqnvixYzP/3vZZttgZ7AYkj7S6XjSjqD0sjcL?=
 =?us-ascii?Q?3uCZwTMR0a43Fkw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 16:41:08.8611
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8ac744b-26d9-478d-377d-08dd5ff25c24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022574.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7209

Use attack vector controls to determine if l1tf mitigation is required.

Disable SMT if cross-thread attack vector option is selected.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index e35f7059f6fc..e38529f3022b 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2717,16 +2717,20 @@ static void override_cache_bits(struct cpuinfo_x86 *c)
 
 static void __init l1tf_select_mitigation(void)
 {
-	if (!boot_cpu_has_bug(X86_BUG_L1TF) || cpu_mitigations_off()) {
+	if (!boot_cpu_has_bug(X86_BUG_L1TF)) {
 		l1tf_mitigation = L1TF_MITIGATION_OFF;
 		return;
 	}
 
 	if (l1tf_mitigation == L1TF_MITIGATION_AUTO) {
-		if (cpu_mitigations_auto_nosmt())
-			l1tf_mitigation = L1TF_MITIGATION_FLUSH_NOSMT;
-		else
-			l1tf_mitigation = L1TF_MITIGATION_FLUSH;
+		if (!should_mitigate_vuln(X86_BUG_L1TF))
+			l1tf_mitigation = L1TF_MITIGATION_OFF;
+		else {
+			if (smt_mitigations == SMT_MITIGATIONS_ON)
+				l1tf_mitigation = L1TF_MITIGATION_FLUSH_NOSMT;
+			else
+				l1tf_mitigation = L1TF_MITIGATION_FLUSH;
+		}
 	}
 }
 
-- 
2.34.1


