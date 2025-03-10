Return-Path: <linux-kernel+bounces-554702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4B6A59B60
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DAAB1882DA0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B1C23E23D;
	Mon, 10 Mar 2025 16:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VlMwuOdf"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED0E23AE9B
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 16:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624870; cv=fail; b=kMBpNbZqbQG8LatSz4+IWaTwXflzurD3oTJtrKWWUBr8kuILXlgjuXNXaPH9ELYIKWCzFoYeV4weiawfQgbIz/YT57S/gUl1Cg6P8/a4rVXmzb3Ps4AsMDnM3GmmByzt5MzQNUfnBroKVio7+TGWkIk8M42juaU/c6kMegsXmhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624870; c=relaxed/simple;
	bh=XGJuGAFjRITU3GteQNQGL2pM8FEvuZk0P12VvtLcaDk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b9Cyi9LUPX3fkTwl+/I8c70p0gJKJeMBiyMumvgxBAGjDeH1bsOdy4QpUCfCt2E1c909MwTNhLfwqHnZNx9QHbkJapj1jQMo96JR5fLn/fNflCC67o9Kc/qR/K+GAWawzQTUV2HUyBLnBmOMIa7ipRFMruXQg4SiEQ0JS4G2psA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VlMwuOdf; arc=fail smtp.client-ip=40.107.220.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eLDkciqtB7+i/LksIpX3kO7hPEhXD1aFeNSWkTPJof6iBFM9rc33W40LhHqx2gVWwXsCEwvfUFQbJamoVqUvT/t9+EJ3gGzr2PNugycYZNI45KzO7L+EH3dJ7pA6q5ydXDgC3ka8bfrn7m94BtImgyNOSvZSe5kbaOOneYihGkDVmYTHjXf9/e5pitj5dCAsz9ZhvzcVNO9dvDLe+ZVPnTFUWnxt0U0cHVGtb2pkhhNLSsxH5Sukjr64kr3OiHHoop+uv4Ayh1Hi/FHHrPsk9y4PU3AKPFk9QapYgZofs8j2QgUZbZiOI7TJ8BQO3Z0LCK0NwNjHQsLIU57GBm7YrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n0q/1eg3SQHwWTGatvktZp9WwAHimgc5CKLQThA0p9s=;
 b=df3Xa7xakPFS+1lLYvSFhj/WDoSo01B+2Ruf91wG4sMI8/QuuZmh2WRF6OajLiUr7fJR0d6O95N3xtuzAkDg8enLBBx/Gh5LpHOGFH1b0aBwqjn5uwAO/Ccobv/lmVnFxWpmfrn1Xcvx6h+uVdALffMfKprXb8f1gUIy9T/PpF44zGyP71ScefytZIErf5r5xsLDkNzl0JcAZv2cKUu8Xz1jMQ+RoohuBOFd2tji891zRjuJC3Mz/9bInQR4doQl+vNPTUCjfEfeLqSd1n42S/mswweGHgGRKDHRaKHJfKju44MRunhQSnVM3CQZh1LfC9qzpxi6ERu8ImEbOMhp1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n0q/1eg3SQHwWTGatvktZp9WwAHimgc5CKLQThA0p9s=;
 b=VlMwuOdf1S0n6rbAughUeDjdn3ikbmJMpC1mNAKYMNBATismrujecKAJeTFcRkCDgLwUMyeaZKZo77ARIeSDs43Z5pctQbzeKk1rCrbszhi5Va9cXdYo8Dv1B6AxaYtWSGpJsqmCsojxT35Pwa2MgHpPRfm8aMBYxQEZ0tJwMko=
Received: from BN9PR03CA0089.namprd03.prod.outlook.com (2603:10b6:408:fc::34)
 by PH7PR12MB5710.namprd12.prod.outlook.com (2603:10b6:510:1e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 16:41:03 +0000
Received: from BL6PEPF00022574.namprd02.prod.outlook.com
 (2603:10b6:408:fc:cafe::72) by BN9PR03CA0089.outlook.office365.com
 (2603:10b6:408:fc::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Mon,
 10 Mar 2025 16:41:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022574.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 16:41:01 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 11:40:59 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>, Brendan Jackman <jackmanb@google.com>,
	Derek Manwaring <derekmn@amazon.com>
Subject: [PATCH v4 25/36] x86/bugs: Add attack vector controls for srbds
Date: Mon, 10 Mar 2025 11:40:12 -0500
Message-ID: <20250310164023.779191-26-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022574:EE_|PH7PR12MB5710:EE_
X-MS-Office365-Filtering-Correlation-Id: 33f5cea3-d120-4977-7c66-08dd5ff257db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vztZNgQpjTE0wqkhJzDw71lSvaf5T8H44hKmhlMpzB9vUE2uiziNVa0nJ7Zw?=
 =?us-ascii?Q?2oumRWG1nZAGPsie+m91phOQ9z4SoLrld5lNAzO3Y17tkNOgwLszI1DvxDmB?=
 =?us-ascii?Q?3JFLydbs6uXMi4nD2XO47BiiK5rEe0kEKpsBKE/YxhIs2aVx+xES/ZksJGcD?=
 =?us-ascii?Q?4agTEASyXy/GgUxE/3aX931INMca0B6tz62tMhXEYEBdDp/eLZI4NWrTuUeh?=
 =?us-ascii?Q?SYHY6RvU1mxXn/4M6HCJ0jXgYk6ZC1WAx5iUMunrj43P+teEZNtZVI54RKec?=
 =?us-ascii?Q?7eQcdj6I6GomerenE3HN1iiV0rT3qCrwqhGTxMdoExb1+y56ptNaCmwzZAQ/?=
 =?us-ascii?Q?gN0SAprq618nsza/Bd8saU2/7WEplHD3lrxwXCnmxBhNjUynHB0BlKfQjQrr?=
 =?us-ascii?Q?XkqfuP9Mp5h1a+CmLmYYj3IC3IsnAOBfjCSy42CnPKLOTvgjR2ks/J84HNe/?=
 =?us-ascii?Q?ne/fUdM0AUrRfyKwVbffKr/h4eIEFvBzrOb+szABj8DawX7n8Ue/FWeHXIXz?=
 =?us-ascii?Q?Hwq/kcpmrEcFpaTYo6qcMsyVXXhMSrYiiYMOuE8tlk6GMfpaO92cFsWHbtyY?=
 =?us-ascii?Q?f+CLpG7MwUzJLV8gzrlZQJ4Yf0Kc759YjaZkEG/tauEOLc21fxT1+c3Sm2tD?=
 =?us-ascii?Q?KhOIEnuH5/Tnolyj2aIbhz8A7KEbtb2evWjhm1c7lqOpqp+e1u5rS3lF0CJX?=
 =?us-ascii?Q?/fgTgBD+2xUFo6tsP8k96WGqn2Sek08WvqwTH0XTbUhdXoZtTavZhxfgtMFu?=
 =?us-ascii?Q?tpy6yVEbYUJRlMHacBWeR1qVwkR9A0+esq7m8ty0p4lwFVpQdiBf1L7EPDoc?=
 =?us-ascii?Q?SfY0+XBt89qbOGV+xj5ve68vwY218h13vX/QIVJ8w2xXjbRa8prtWFAXDoHB?=
 =?us-ascii?Q?dwwZMeZANyCjUlcnF3/VKBIgipUZ7AFh8+Qk3fzfZBpcT3+KXLVe39iIVbmx?=
 =?us-ascii?Q?FQy2PW3PFngDs75V0NdndLVdDKAIHcrJwRwTP1YdjFWalZUfI+DONrV54/6c?=
 =?us-ascii?Q?kLibS8cM3mQ6UMViVRXLhFsTDTnllb9HLMgkbu40CeAWI7z4WcaWK75/yWl2?=
 =?us-ascii?Q?/jCemagLuNeuGmOGznuKr106oMky4Dk2lLEIT32vtnGvnujEMuZYkNyDDihZ?=
 =?us-ascii?Q?Nx74QFeFQskbIXhsPInzuDr52irquA+KK2ZjVNpj34rU9Mby9WA2E6SVI0yN?=
 =?us-ascii?Q?x1BMEZFWg6pfyRPziNtyjwmJfkNvZOFc/EHkLORSsWG0BzipeSo4lxHQg8VW?=
 =?us-ascii?Q?v0pkVYyhD99R0OSygQ9nMTgDgbhf6qdkhNHhE+xczEp8MRqG2B8U7j+mpei3?=
 =?us-ascii?Q?69wCRVZnJ4bUgB/ihGlTQHqslKMAsa43lVSL7hjNmSoh5D76mQGZTxIwnW3j?=
 =?us-ascii?Q?jT9hsv2iW4R/N0+QqmfB698/Bhz4TkcFGVet3wXTa8+nCK32H8fJY4ynOHRu?=
 =?us-ascii?Q?GDUogVt8VAloOBmYvLjCT2EFWSM8wvM9VD0EYex8YeSlaE57gApWe+GOLcGO?=
 =?us-ascii?Q?EhqYhK5nEtsYM40=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 16:41:01.6736
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33f5cea3-d120-4977-7c66-08dd5ff257db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022574.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5710

Use attack vector controls to determine if srbds mitigation is required.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 32f850c80b86..148cac36a24b 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -834,13 +834,19 @@ void update_srbds_msr(void)
 
 static void __init srbds_select_mitigation(void)
 {
-	if (!boot_cpu_has_bug(X86_BUG_SRBDS) || cpu_mitigations_off()) {
+	if (!boot_cpu_has_bug(X86_BUG_SRBDS)) {
 		srbds_mitigation = SRBDS_MITIGATION_OFF;
 		return;
 	}
 
-	if (srbds_mitigation == SRBDS_MITIGATION_AUTO)
-		srbds_mitigation = SRBDS_MITIGATION_FULL;
+	if (srbds_mitigation == SRBDS_MITIGATION_AUTO) {
+		if (should_mitigate_vuln(X86_BUG_SRBDS))
+			srbds_mitigation = SRBDS_MITIGATION_FULL;
+		else {
+			srbds_mitigation = SRBDS_MITIGATION_OFF;
+			return;
+		}
+	}
 
 	/*
 	 * Check to see if this is one of the MDS_NO systems supporting TSX that
-- 
2.34.1


