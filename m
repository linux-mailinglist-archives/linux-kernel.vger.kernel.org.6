Return-Path: <linux-kernel+bounces-397219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE1E9BD7F9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 23:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FFFB1C22B5E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 22:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEB7218D8A;
	Tue,  5 Nov 2024 21:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="C75ue97t"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6EF216441
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 21:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730843747; cv=fail; b=fdnvpqtSNLuT2V0fxOQGnIFpN33QXxdzqabE7yX2uuoQWS/7mlc4SZC5JrZTlQJNQ9E3NrhPzpss/J60S8cK0v9FTnonf03hQMiQ7xwmPdpwxIRPYEh/OFWxx6ifoss3uy9dUi90TPSuirit37r1gsYdK42IREegPLSrAw+KPBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730843747; c=relaxed/simple;
	bh=rAHHB21wHfsQWGcNUdSsyMNjkQug6Ox+QxtGohm8Vag=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cmv+aQheUreBia9xEjpDexvp/vaMFCLbnHsfCk7uaQ3ymv5ieMCEq3fXL8hhYVMGdyY+9NWYbACv6m8tzNsIRETGlYYhp/oG4SqIBRukwjtXyVnUAcMKvN+37oBWsyQ2BaddH/te/hnnr03ao603KVzyf0EVaY9OfP6dMVXI1qk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=C75ue97t; arc=fail smtp.client-ip=40.107.243.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gv4WJ65vwWjXeNgkiU8QVi0KLMBXzjfMvAIoqXpgyPtHrXXZqZiN7ams4XeFAqunwcTJAARgVrsRMfxGLFoNOen1gcgHPtcC6JLqkRCZ6zZz4tN2LxD7SqX6fk2QmkTlaOFJLIChzZFL4IEgo0K1oInHy9XgChRiUcM/P6N5H7qN0dFJboLEbTv7Z/SxvxYjkhPwEngqbjrQEGMLbZpp+woTH/YQfiAnI3l7+vqJH1HL7xrAFlrUnhCejXDTvOA+shA27/aR0fdmik2Huas2Hzx6qJSWKwMiIl3PFtYjrLwXvZrTWaBi4V7SPofQxMZg3PKF4XL6kGjydlQNMVCIsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AAPZBCbQxApwk6iKF96VWWlPWImw6XixaFSN5aCpUjo=;
 b=EzVPEZspTgTQk7N5WUy5VL5EMWqnrIcknH+l5bXGyoL7g+8sc957ZyRXmfFzctrklhKXwlw0O3AmleO+ErcyfeW9NkdT431dW8WYMd6Q+ydgdFQTXKP9Ps+DytGZ3mbBkWfeVMR+mzHnnas7VPBsL7CP4WjYY//Mhccgfi3Ca1/dzcKajnsK7iNanyFpBiMAS1akCMQYN0TvU9fd8UOXRQkN4sLRYjyKol52Lzz6BAllu2nj9WhshS/lISacDJRA/1irk2ZuH35VivLKdRB/oV5LfbqYNGLvCLL/e7qZHbLB7oJnnoB9eSCECYQ2rYnV9R8//0YxPuDLw+GeW703Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AAPZBCbQxApwk6iKF96VWWlPWImw6XixaFSN5aCpUjo=;
 b=C75ue97tf4u6EZUx5SXPmeBIkAbhk9w0Q08tiqr4bgpCX8xH8UFv/qaZIspAxc3JP8elOMwznHCok5rOn3FKpFZPetj1QBf5ePGhVoxXLCl6njeVsKUx0+8nQcqwYmwiV6Y/OMFLevC2/WktYx2+kcAo1oeimSGTYn7/oIqh76w=
Received: from MN2PR15CA0063.namprd15.prod.outlook.com (2603:10b6:208:237::32)
 by CYXPR12MB9317.namprd12.prod.outlook.com (2603:10b6:930:e2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Tue, 5 Nov
 2024 21:55:41 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:208:237:cafe::8e) by MN2PR15CA0063.outlook.office365.com
 (2603:10b6:208:237::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18 via Frontend
 Transport; Tue, 5 Nov 2024 21:55:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.0 via Frontend Transport; Tue, 5 Nov 2024 21:55:40 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 15:55:35 -0600
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 29/35] x86/bugs: Add attack vector controls for retbleed
Date: Tue, 5 Nov 2024 15:54:49 -0600
Message-ID: <20241105215455.359471-30-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|CYXPR12MB9317:EE_
X-MS-Office365-Filtering-Correlation-Id: 2380880b-30ff-4684-3860-08dcfde4971a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iePNdIdYDWjxqJYUC7rj53x+BLcT7FgEiS3p1+mhGuAc3a+tuZopzz6ZTZVK?=
 =?us-ascii?Q?0gJd11DsL57GiX/cJXSh2tpWgc4hmGyCX4PPeTr1Y11dAG3QmSJZAGbTv/Gt?=
 =?us-ascii?Q?36aror7odS0BBOLukjjEgA/d/0gg0hS3NUzc00pAfzkYZZALGrjJfMw7FGH7?=
 =?us-ascii?Q?Y5jx3gwR3wvet/B712HXs+mF6Q18WQGZghBBFY3Zhe/p/29lBi1PYJcrvAVo?=
 =?us-ascii?Q?NPExbcqS777QBdbAjJOWFyND9SD0LS8pFLpgnJ2dtkEPjml0rwDXPXyGaA+q?=
 =?us-ascii?Q?unMdrtDn+f5g78j6uZrTy8KGyL1QBZHpkDg1LwEccGrbKKu86FkdIOfg0wnX?=
 =?us-ascii?Q?n/2LnVVNz8tl7voZcymGqOfR03nWS/0Xm3hI2RKWFituPER7ukULei9Mrpr7?=
 =?us-ascii?Q?hP0j0M1JQ/+vu7hOoqXWQpjJl4PKlbtDMdPNw8ObfHTVzCTmUPw45EjN8j/t?=
 =?us-ascii?Q?g+6lXit9eQ3qZbTQCRpOTTlkz5JUgZ2/pjJyIVLE5+kEHYf/aJ5eicgtvEdo?=
 =?us-ascii?Q?RZOApntMv2LmzJZh+nM2Jn4oyIonxMxhkTZP3WfG24EnqAgzaiKXIyToPR+l?=
 =?us-ascii?Q?hwy5Zmw8GrfqNkSP08ZQ9tmZrFMhnCfyAzNXCbzp0YP1lq3E4eEFZa5ectZ6?=
 =?us-ascii?Q?CSAWnjmp0UQPRFvT2lUhsjdiX5CmqukAri7jomxfpp/y2S8exYXGMKuzCH6y?=
 =?us-ascii?Q?ghORtfBaYxO03Yac/sdOwAlK9Ek6fbhoT2Hn//7OSZ5NIx9BczYd9Eln0nIA?=
 =?us-ascii?Q?EQ3NGjNe8dpstGsez33Oby5xBuUV4Hi6Y+RGCXzMs8xwq2XY/gamwGSiuvht?=
 =?us-ascii?Q?q96ybx39cQ66YsRXVRZV5913QfVa8OSkjgo0KMCxkbjzG4GVGa8VO848kYnB?=
 =?us-ascii?Q?90WvRx1/dI+HiIvtAp6pbCqT7nQJHsM1nOrSsGc7zYtTrEtSwrEoM0IOcOOj?=
 =?us-ascii?Q?UXiAzrJ+vh1txW0cmuUBeY4AnRyvfwZZItNokoYMkPSoPxoZcqTq781bqZgi?=
 =?us-ascii?Q?MTUK0dpKcJeYnpgRs2OF8LOBeir5YKF5l5d6/KavgUQSUsKOY/leF+CyGScW?=
 =?us-ascii?Q?fkc9SnYYwAzvf3GN56Vmjp4XT9qaV/2wxnZcc9S7IAMh/vrpoeAy2XfB2Tii?=
 =?us-ascii?Q?mN5LuR0gUbyPYcDQo+K8yRWIvnUg5PSjpk+EFUar0soUzCyAGGu6xf3Hj3pA?=
 =?us-ascii?Q?f0g0INX2IAk/lPofAjQyTaBRtUVwJAMQHNk7lk8Va5/3WEBqVqnpEwDckRqi?=
 =?us-ascii?Q?haLn2fJHc3UkXrcFmtTh2OLKKIax0mOio+x06ehd7PWxNXE/87mPIkmdWjAS?=
 =?us-ascii?Q?UPutQt7+6l1D5tD9snLdKxTMllOcjsDP/TJSsE6iybmEpH8FW9gSVa8tRKPh?=
 =?us-ascii?Q?fY1wv5huhLiORMY4MMmlpPeIziZvek2rsmKp4YfIQ89TYD1DLg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 21:55:40.8591
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2380880b-30ff-4684-3860-08dcfde4971a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9317

Use attack vector controls to determine if retbleed mitigation is
required.

Disable SMT if cross-thread protection is desired and STIBP is not
available.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index f63fa8a3b9ee..545151114947 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1267,13 +1267,17 @@ static void __init retbleed_select_mitigation(void)
 	}
 
 	if (retbleed_mitigation == RETBLEED_MITIGATION_AUTO) {
-		if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
-		    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
-			if (IS_ENABLED(CONFIG_MITIGATION_UNRET_ENTRY))
-				retbleed_mitigation = RETBLEED_MITIGATION_UNRET;
-			else if (IS_ENABLED(CONFIG_MITIGATION_IBPB_ENTRY) &&
-				 boot_cpu_has(X86_FEATURE_IBPB))
-				retbleed_mitigation = RETBLEED_MITIGATION_IBPB;
+		if (should_mitigate_vuln(X86_BUG_RETBLEED)) {
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
@@ -1372,7 +1376,8 @@ static void __init retbleed_apply_mitigation(void)
 	}
 
 	if (mitigate_smt && !boot_cpu_has(X86_FEATURE_STIBP) &&
-	    (retbleed_nosmt || cpu_mitigations_auto_nosmt()))
+	    (retbleed_nosmt || cpu_mitigations_auto_nosmt() ||
+	     cpu_mitigate_attack_vector(CPU_MITIGATE_CROSS_THREAD)))
 		cpu_smt_disable(false);
 
 }
-- 
2.34.1


