Return-Path: <linux-kernel+bounces-327144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C77977137
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 21:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64889B21AD3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 19:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A301C1C57AB;
	Thu, 12 Sep 2024 19:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fYyHoyRL"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF43B1C3F01
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 19:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726168171; cv=fail; b=LaATQ3rIy8bvb7E+HZcW05pydlcOZwX2lQNTZk/kmGu8lVdCPQbEccRbYHJkhanyjnkctWHVyUXlFRgikzOrFm5/uymJzzf6g1KTNSrwI/EPJ0+R7SVw0UzC8q0SOR4umCy1bf2ASL/7HegBfS+bkR9s70SPArDAjrjoymeYl04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726168171; c=relaxed/simple;
	bh=IjQZZGVu96pLs8HE1Ay8UWeFgpY/LxEA1pkYz89o9mQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WumIRdqHulWHMpinih/0qUO6U2bPjs+gTyG7tcatv9qIZ0Ie9juMiQKFfTW5N5OaT3Jd1bdb5SUpSxbVFasRnKa1/19cuEfRnaJ3Ny7m123nShvpcGFlFqduabfyyEhZ36y6GGFJTkBMgN/MmHG9E4Y0eEyOK7KqCYe0uMvzEuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fYyHoyRL; arc=fail smtp.client-ip=40.107.244.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sVZ49DpOt2x0xHKHz+v45AWa7He3vtyawSKmMomFXrLvQki+RGf7L0Pp0XYc+Jnekk4z5oXj0QUbGNPZMZTtq/5x8OyotHEGwspD/1/Ys7ZbWkP15C1KUzh2ZraCEy4hvmRsAuA0ucsJAt1iCfH94i/lTV/UOZiibZ5c/fXAMRb5GjfUNbICr7hmaCIs7tshkRHfBFLDY02UVJzV5W2X6fhrwI2derYIYHLwGUBj6oS6Ezq+OZcNKBp1TDPRGA0OE4bv10BTzkRu8+G9LNskGqb9Q2G2kL4aPgykphnZXCLQyl2svM/Xv2hmpYtHAonSxzPFwZwxyJoGG19HlMMkVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lz5n90Zegij7/mevfIr9Kgf287/sBKChnr6jQ6CbliM=;
 b=KTwDTjiQpg0IgOidAceeRU1wbQ1agl00jFWslMvt6H2EHEu2sQIsUjMEi2pxlWv8hUfU1aSdfEKK3Ch7zGI8wILJEfG2GPKjZaSrOQJAgP0p3AvycaDEoBIJRptpD2WKLGak4n6ejLfbVgM7nkcve5hWv0UcUSRbDshB680oVA3uPuUTKP9uY1uBEn6uzeHcsiag8oZc/E+ITXnuLL2nkU+Ns9IaTZqpdm73zr+MnP8Z6FzXdqXogXt0gKHQIFunrsmdJuDtGH7VhH78d/lcdm60KoFtLLV6cpZUAc3p+QXgOfqsomYbcwjU1O28wi0c7GeZoiV7vXgLN5yjMNIrBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lz5n90Zegij7/mevfIr9Kgf287/sBKChnr6jQ6CbliM=;
 b=fYyHoyRLKy7KxZKs77AXyshCUxcH3+ESRKSuFR27RTYC8LckzrhZvVGcery9gZ0zAib3ttdorYtf06xxZoh0Ty198XDRBFWIWU55jnFlfEA6HQ5cbX5V/dhAHtF9JK7IqCjP6f1aIi2vVd0Qa/q7P+tZWY4h4492JY4FzrGaE9c=
Received: from BY3PR10CA0011.namprd10.prod.outlook.com (2603:10b6:a03:255::16)
 by LV3PR12MB9260.namprd12.prod.outlook.com (2603:10b6:408:1b4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Thu, 12 Sep
 2024 19:09:25 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:255:cafe::7f) by BY3PR10CA0011.outlook.office365.com
 (2603:10b6:a03:255::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25 via Frontend
 Transport; Thu, 12 Sep 2024 19:09:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 12 Sep 2024 19:09:24 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Sep
 2024 14:09:21 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 28/34] x86/bugs: Add attack vector controls for retbleed
Date: Thu, 12 Sep 2024 14:08:51 -0500
Message-ID: <20240912190857.235849-29-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|LV3PR12MB9260:EE_
X-MS-Office365-Filtering-Correlation-Id: f618ee63-b0f1-41b6-87b4-08dcd35e6ab3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K9YpoAFUThFh8pM72/0h1xjiFO0Zb5Q6dGyFZVcm8XVYSdyfrBFe6U6bLztW?=
 =?us-ascii?Q?TGmvgTjfTp4yITU+2Sz1NPLCEeCDxrLUHMi5VfR+3/akC7u3186/eHnZI1gs?=
 =?us-ascii?Q?gBihkQPj3RLXC8i9S0JfvPn935X3GDFIzvzVQm2eYGlJRzfUVgEO56P2DJCR?=
 =?us-ascii?Q?1BQOtM2EOqwP/n/4dUyo8NUxcWA63KtBQcBDZl8WCtCDHPRX4tk/CIfgcjCy?=
 =?us-ascii?Q?nIZcZMI9x8yfIJoZFpdOWBP2K+Gsadfn/O9+7pNmOaCrsEwyBSaBwyx9+kaZ?=
 =?us-ascii?Q?jALl0EQsRyyUhTFveO67t82o45eh74ERvPrCAGZzKwpWNHryM7z/2agY3Qhd?=
 =?us-ascii?Q?/5a84+sRdMr7MwhThUbPEEuZ3zHX5wZ27TofYlv4lq294qHsu0KEBa9eBHn8?=
 =?us-ascii?Q?CewyQxm94NZ9PZuuIt+Sp9zrRK1GOO7CRs4M9gALK/zMNxtknYL0F0knXDd1?=
 =?us-ascii?Q?BhbFsB9VD+TPHNo50k6DxUjz3qVms8fhPYRmW9j5gilkV6FoKdH1xQiWX/Fv?=
 =?us-ascii?Q?wauttpFi1Itvvl+Qgdy4614rijWRhuBFK4bP1+owETF9TB3WME44lPYDLx3a?=
 =?us-ascii?Q?VzFLTmFNjhL+NaxK6setRnSBQjVTx24cJ/rC0Z9uRST3bfynFqm8JizoI5mh?=
 =?us-ascii?Q?JCgnis4KeDNANk3sDzZB7TTdchmdUxNpBOV1hxAcazexTCt4n2zQVx+zqj0D?=
 =?us-ascii?Q?9M0zwsbsV1MjsbRWN0ZqNxtkPTeqsKqUEwwayAw26kknw0PptimX/as1MrmY?=
 =?us-ascii?Q?qGNou9AUs066dB8QO1JlyahTpNvLPOHZvemHRXbObO5sA1WghuqlIgDcg5aL?=
 =?us-ascii?Q?aO4zJVG+rD+GbieGdogW0UpvVJUmOp6jlSdpi8nhCUGUEQOc9yboC2WySLPw?=
 =?us-ascii?Q?gq01y0nPImfZ4NTnvL48RDIHJfiD62GGfVx1+7fGoaNbwyOiwyIvEp/MTAlM?=
 =?us-ascii?Q?XMruwzsKDuNPAmZVAiNiONiE/SsNlvdpEtgx3fDHt7FC3XS+IahItFQ9k371?=
 =?us-ascii?Q?XiBftLLufuKl+Lp3LY5OUG7tMhRYAZ6tRGnIc85s8bylBu3qLxFFPKrUF0/g?=
 =?us-ascii?Q?nn1OkpA04fF/JnnJfTlT+GuSl10uD1LPP8RFu09BAlaZ+RMZrH04BeQrrxWg?=
 =?us-ascii?Q?eXzNmZLp9zk4xF720jyjhMRQKpU8KbzEud/eiWjz/ZL1dpAU3S8oqaG8vBfj?=
 =?us-ascii?Q?IwVkVSlA14Yfrn6NuK5NZOQmqPqIn0xNeO4KPnj0QAqm5wUhVdNwLJLdUzdq?=
 =?us-ascii?Q?vJOEs4QZERiKo9lEJ8rZP0mSCE60ypqE6dnB/9DyOcI/68haq4RwfF/YmpY6?=
 =?us-ascii?Q?gIK6h5xQnnDTfnmGTFV4j00u6TWQFB87l255LSkg6NRzxRLfuwQRndBqxtWL?=
 =?us-ascii?Q?lq3RLgmFrNmRILOSghwVjXfcUmH0K8hXy5TinS3EpCN/jG030Tn7drm/8C8U?=
 =?us-ascii?Q?Eg4uzFLa/AGBXk7YjmbNzUMzCdqXWVEQ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 19:09:24.8742
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f618ee63-b0f1-41b6-87b4-08dcd35e6ab3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9260

Use attack vector controls to determine if retbleed mitigation is
required.

Disable SMT if cross-thread protection is desired and STIBP is not
available.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index d7e154031c93..2659feb33090 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1270,13 +1270,17 @@ static void __init retbleed_select_mitigation(void)
 	}
 
 	if (retbleed_mitigation == RETBLEED_MITIGATION_AUTO) {
-		if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
-		    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
-			if (IS_ENABLED(CONFIG_MITIGATION_UNRET_ENTRY))
-				retbleed_mitigation = RETBLEED_MITIGATION_UNRET;
-			else if (IS_ENABLED(CONFIG_MITIGATION_IBPB_ENTRY) &&
-				 boot_cpu_has(X86_FEATURE_IBPB))
-				retbleed_mitigation = RETBLEED_MITIGATION_IBPB;
+		if (should_mitigate_vuln(RETBLEED)) {
+			if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
+			    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
+				if (IS_ENABLED(CONFIG_MITIGATION_UNRET_ENTRY))
+					retbleed_mitigation = RETBLEED_MITIGATION_UNRET;
+				else if (IS_ENABLED(CONFIG_MITIGATION_IBPB_ENTRY) &&
+					 boot_cpu_has(X86_FEATURE_IBPB))
+					retbleed_mitigation = RETBLEED_MITIGATION_IBPB;
+			}
+		} else {
+			retbleed_mitigation = RETBLEED_MITIGATION_NONE;
 		}
 	}
 }
@@ -1354,7 +1358,8 @@ static void __init retbleed_apply_mitigation(void)
 	}
 
 	if (mitigate_smt && !boot_cpu_has(X86_FEATURE_STIBP) &&
-	    (retbleed_nosmt || cpu_mitigations_auto_nosmt()))
+	    (retbleed_nosmt || cpu_mitigations_auto_nosmt() ||
+	     cpu_mitigate_attack_vector(CPU_MITIGATE_CROSS_THREAD)))
 		cpu_smt_disable(false);
 
 }
-- 
2.34.1


