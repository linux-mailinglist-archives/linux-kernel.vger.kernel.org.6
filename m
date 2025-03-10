Return-Path: <linux-kernel+bounces-554700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD325A59B61
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89C187A75E0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B8A233703;
	Mon, 10 Mar 2025 16:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ickeOQbD"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1A423A9AC
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 16:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624868; cv=fail; b=qaBcUztm6eGczgHRdhMVL/GS8GPye0kGX8boIjQsA4voO0FzW3nT79F4RBXy3YEPfoX5ZBdNSitlANeiHAPQE1QkXWvkth4fZZMqnA0LOlfTSM3ns0XdXJ8TSQ5jtonoKFEtxDFf3aVlTUjrH2oz6hcum1oWkknNTi7ddlA0kfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624868; c=relaxed/simple;
	bh=CPO06WmSBK6APR24HpDUmH8dULZMFTUg2+Ty29upiWw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KbE/2igz4ZwPEjMoBgjFxT3uvmWpDmJ6ryTMKhmTvUPPFONrRWhOh/AvRQNT6EadhCnYXNbqpuulfxsi1JGRuQzBc0CAqnfhy85hQorTwP9i3UDDFDAQRyKCJePOd9kdgxP1l2lDOEsJ4JICbmQv/SYs4Ij76fFmuNBCxNntZaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ickeOQbD; arc=fail smtp.client-ip=40.107.237.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iuDKGjY1PafkHi6kE3BnqMS9X5HQkU1Sa2oIHM2JCpO4gNgq9i54xAGYYLfoGe7mUUKjoxEV9v9vDW7xXbHb1uw5fPjwWU5BMzj+HZdLuFwfgxAfWYU33kQ/Ib61qAFzzsMQtHncpRQihKv8Nj2Gel18DmcwtnRmMTD5oC6Bd10j/GMalNgfE5MyuCBlgDnXo3aEdYvNYjepGHHGUYD7Z9lYWlYvk8NChtwE7my576jBnlCa+CdGDuuw0FYwL2CUxZFr9QXqMm1ZmY9fm0jI0N2GSrTVVwhJdltK9K7xGG0Wj6R6XistyOUMQa054y5hFGJ6IH7rvE4Ma2r3xH3/vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NcAaSiSK+WGfT5FrH5HLRqDmTkOY96NjjoM9/6W3Omg=;
 b=VSyFYIUaFx+Hl7aGdqC4No5lwbFp4LX+2cIDr09TBuTTksnI0s8IyxfbD2jOCCKJhgfegTedb7nevo1rOt7dCffhBLL4SwDHxhkX2AGA/5vR+vWOfB1hv602aSGSudJMWYjK3qZes4iPh87/o46Pm+VV/se8oGd4R05qaKoZNjB9158kz3hUPL/N4jWOZ/8FpMpYGluDF5mjB1BausIjB+ooIGUFEA1XNFoICfU+x0tyZeW9NejLZlP7ShbibYs8KKnLSVYtLicxPsC04/epJDzV58Qx2oUbvJGT94PbmFpp+vsq+2omMlJ6cM/tytrkhpHJFu1+gz+sgAPZ7DqYkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NcAaSiSK+WGfT5FrH5HLRqDmTkOY96NjjoM9/6W3Omg=;
 b=ickeOQbDAFziM+OyAKXLcvWhngqm0mSd1UkIBK/7L8oYlHF8jLG5SHzdejXE16YGVtdJT5A1N6iLDha5ZJyEnugr6DWAjyjLprykoeTy3q65HqGdA+OKkxb8p7+Zmx3xTv4tSpUkF33T/JXKNLE/dxOj/lLYxXSoRZfylQezN54=
Received: from BN9PR03CA0071.namprd03.prod.outlook.com (2603:10b6:408:fc::16)
 by MW5PR12MB5599.namprd12.prod.outlook.com (2603:10b6:303:194::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 16:40:59 +0000
Received: from BL6PEPF00022574.namprd02.prod.outlook.com
 (2603:10b6:408:fc:cafe::e5) by BN9PR03CA0071.outlook.office365.com
 (2603:10b6:408:fc::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.24 via Frontend Transport; Mon,
 10 Mar 2025 16:40:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022574.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 16:40:59 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 11:40:56 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>, Brendan Jackman <jackmanb@google.com>,
	Derek Manwaring <derekmn@amazon.com>
Subject: [PATCH v4 22/36] x86/bugs: Add attack vector controls for taa
Date: Mon, 10 Mar 2025 11:40:09 -0500
Message-ID: <20250310164023.779191-23-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022574:EE_|MW5PR12MB5599:EE_
X-MS-Office365-Filtering-Correlation-Id: 57e62f29-67ca-40c2-03c2-08dd5ff2565e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ASSQHHmqC6yqTaDbLc80YlTvkk3n4Mcl/tiG+Iyp5/sX+jmV0EqxPDdfo7u3?=
 =?us-ascii?Q?/0PJvXl+7dKerzhJzZtoS2aNp1yr5pHSXWduGGcnO2BiYW3rxhkMb3OSGtkJ?=
 =?us-ascii?Q?Lmjc/gI8z6LGBpzT9+h3nLTZplf7mxwhtBSFsjO/B5fQnNkDNWtp0b4q5f+F?=
 =?us-ascii?Q?2jEvUiidSBeHOIWI1beotNGVF1fRF10v/LFtufOAT9yMT1Y6J5OdtLZRxbMO?=
 =?us-ascii?Q?atTAGC+ysHy7KK97VMtt0tq2JlM96LIEs+tXU9D1mmAW/fmJSu3q7TAy/2XF?=
 =?us-ascii?Q?trFyIaviKkxK5R5os6d2lbIgnwH9JkZRCBhpD5TBaWgontwCQjVeEf1dLhYL?=
 =?us-ascii?Q?gaiFt4ZWXsbKqda9+lUw/+Qk95rP/XDwBHl5ukvIGj2qanpHEaBWaHbcE1Lq?=
 =?us-ascii?Q?Uwkf/AuymVZ+Y+xcjv7z8ti7pbvnO81Jj0O/WLYwsAphEpGFXpmXl4CAqPCP?=
 =?us-ascii?Q?qHbXTagVOtOnztw1HKnElOXmsyv7KROirqU0zfEhpVtkQz+LJruPbjwdfIoW?=
 =?us-ascii?Q?y8sNnHIVzuUO7eK5pPzhOyJZYxjkHFU5yMe+vtMbe6uSG7BAz5mT3Ci5IgeV?=
 =?us-ascii?Q?0/Gj06eTt6oGSH+jW5AWi2+/VmqkuPA+qEr7g0Lj/9nrRAdOxAspCnDknvKj?=
 =?us-ascii?Q?82O35Z+ZwavKobvqZRns9QTalgKg/XV5bJEmtKQwgocE9Qx1k6Tq4U9AOWkC?=
 =?us-ascii?Q?sGit7OvolRLj+9WUlOVWmp2Le33RLkExDO/e8QtrlV00IYSnh1ji3mojufBk?=
 =?us-ascii?Q?HN8bbh+ti2+nLWpaRyDuO8bBPiw1JixgBEZMS9NfzarWvHTqPxM2fHgEsZ4u?=
 =?us-ascii?Q?UtB2wmcMTeHjtxA2vyaqV9YkzNgnT9uK9ftJFqagcBRAXMf+Pl1T5QHRIgPM?=
 =?us-ascii?Q?de5ZhiuojtEsiI816chGwBqUsrkGUEuzfE6K+071CcZC8qwkiNfASpwJs691?=
 =?us-ascii?Q?FzK5CHQT/5LZ3ZUwcbX2ciHIJTvE4UQdntifyvF+0PvrPakYfPZlTSFvZHKO?=
 =?us-ascii?Q?8zjG8UeD7pMmsn3zCCS3NKqJEdHYL61i54qrtv9aV8Mkhgt3VdidG9T5Dnca?=
 =?us-ascii?Q?ALNA9skT9C6i2qTgafVCej3KZknx2/fBAwo1Cw2vzLFAsC16NyamI3A4hDn7?=
 =?us-ascii?Q?W2YHtlslYtG29SlHv9rHXj087AEJ86+X46taKeaExiBt+yIzF7GgUVvTnKoV?=
 =?us-ascii?Q?wJVjjIwEfTMKj8L5JTF4axa92FMDfDwlPvKG93oRrhtwakbUiOa9uEKxcfKL?=
 =?us-ascii?Q?JGvkGgu2812FamAiag9ClLS8Er7+Qs4PX0Beq/JQFJpwC7mMi6tuVgVKfVrY?=
 =?us-ascii?Q?jsNlxyQawuiThDhFWwn1w6gWsVG+74XHKEyhJVS3bYEJhudRduAdU5Yg/vZD?=
 =?us-ascii?Q?ecKtmXVvcbKt8St8L14PLBq9TKCSOM6wsQJtJRtB58UfzS3LXne3ptxMuU7y?=
 =?us-ascii?Q?VtWK33V8uF73qy8OwmTCERxdc0Tyr+5w3uevGITxMrOGVWS1cwUYZFaQLS5V?=
 =?us-ascii?Q?mTyLN7LiG1oHLZ4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 16:40:59.1735
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57e62f29-67ca-40c2-03c2-08dd5ff2565e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022574.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5599

Use attack vector controls to determine if taa mitigation is required.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 197ef9f2cbce..56d3bf343d1f 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -500,12 +500,13 @@ static void __init taa_select_mitigation(void)
 		return;
 	}
 
-	if (cpu_mitigations_off())
-		taa_mitigation = TAA_MITIGATION_OFF;
-
 	/* Microcode will be checked in taa_update_mitigation(). */
-	if (taa_mitigation == TAA_MITIGATION_AUTO)
-		taa_mitigation = TAA_MITIGATION_VERW;
+	if (taa_mitigation == TAA_MITIGATION_AUTO) {
+		if (should_mitigate_vuln(X86_BUG_TAA))
+			taa_mitigation = TAA_MITIGATION_VERW;
+		else
+			taa_mitigation = TAA_MITIGATION_OFF;
+	}
 
 	if (taa_mitigation != TAA_MITIGATION_OFF)
 		verw_mitigation_selected = true;
@@ -513,7 +514,7 @@ static void __init taa_select_mitigation(void)
 
 static void __init taa_update_mitigation(void)
 {
-	if (!taa_vulnerable() || cpu_mitigations_off())
+	if (!taa_vulnerable())
 		return;
 
 	if (verw_mitigation_selected)
@@ -554,7 +555,7 @@ static void __init taa_apply_mitigation(void)
 		 */
 		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
 
-		if (taa_nosmt || cpu_mitigations_auto_nosmt())
+		if (taa_nosmt || smt_mitigations == SMT_MITIGATIONS_ON)
 			cpu_smt_disable(false);
 	}
 }
-- 
2.34.1


