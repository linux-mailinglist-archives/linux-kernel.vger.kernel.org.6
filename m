Return-Path: <linux-kernel+bounces-397222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 401909BD7FC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 23:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 884E7B22D7B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 22:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB612194BB;
	Tue,  5 Nov 2024 21:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tpChLkpX"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2043.outbound.protection.outlook.com [40.107.102.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8F02185A4
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 21:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730843748; cv=fail; b=NAx6NHq55UM50As3O6h8mhiQq8hrFNI0reJK4/AI09uSslGQZnSpS92kkfAmpYt11ae1BNaw9Xz0fH2dbUR6vJQ0ykpPWmzGrMwWNpp1/7rxsPbPhUyX2xNLne5mADzxzzHM4ukw6CYJRuoN3i4XmHZPcALEkE8RdE44P6amEvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730843748; c=relaxed/simple;
	bh=eQpO4LPpQroiaZK1xZdvivj4vrTqO7+ZnvRKsGCzyzA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dDO4xVyqAUNNEWqT6vPNKvJ1lyTGf4t9+GEqamBWiINXeSgVSQQ/e4mMkaFM6dOVgBl+hc7cIEPLYZ+SQSb5j8FpkR6Mmll9tjAQatwkRj2l5I1rJcusLjKPv+URbQ/SGN3YqUwnQVVAzNI5u7bB46khGW/r4uHLorSiG2Wyofk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tpChLkpX; arc=fail smtp.client-ip=40.107.102.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pzn/znt1VrKGJh8XPv5jsMf/4yloRK9cPWnGSORMPlCG8wOicW3GbeueLrG8T8yd0blU+MkP7Mk53pO3Z/NXpoIiX/5qNoJnOAFHRBmtXoSrBXz32Fh8XHS95H+gq7I1ZNoX/bbpeXlsabg+ES/yQfbn7TpDXah0Z+SqMEMJ5Hmd25o5SgGtAlMm4Ikk4vL+FspM4+KssrjZoGa7txQJdUlkmch+C/G6w8uazbbpqrDM+wOdY50zj/nwLrUg1hbbmgThVxegO7GhVqm2YXxiYEsDwm0uMuDLDKWvFjavKlOHHlbo/kFBQND2gqg9CkMo0BrOAc0oaFSggaRfZ5Jbog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9L6yMs4v7eOQIXmdopBNiiTmXnwANrLXWjFU/51inWs=;
 b=MEtD1pWKilaxvbgD2PGihXxj8Xejd+frg0QGrmuOetdUiAxG48fLbQ4yC6VF64XMyJDQIi/OT5QcsRXYDxjpMAtdIy+Oa1IM8OfR79SxKHy/KUgeZH0UsV3c1F4V+a8VCWBerwcUBtgcHA4Kv+t05hGVSYT8SRfTfyTLoStevV7OO7QGZBRXQjGieyBOBWCHl/GeYvKv+J1qGX0zYEX/D0gQui9I+uH5y6ljnFa0Nsc4AhA1xkp5dWF7uNz5iJzHyGRfhUOKdVaAkLvmgPGDzREpGZU6hdM/LfG3Lms4n+Vq7N2RBUNyh9O0UJGdNs0SZCDXbxCN0PG0hMN6fCnurQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9L6yMs4v7eOQIXmdopBNiiTmXnwANrLXWjFU/51inWs=;
 b=tpChLkpXxMyDmmCms8VARUbzbAtB5jGxZOQxEmibMMUjZAQ6idFpFgVwqgFjwgpUpKZvd/U0PtTPLcOunMDj6utWgMOEThVXWN2uZ8W9syUPwhd+n6DkYQg+6I18i8qeN+daLyOijh6qvFY4RXVpvPHIsOdmULr8Q3D6mYzDPu0=
Received: from BL1PR13CA0365.namprd13.prod.outlook.com (2603:10b6:208:2c0::10)
 by IA1PR12MB7590.namprd12.prod.outlook.com (2603:10b6:208:42a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 21:55:42 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:208:2c0:cafe::6f) by BL1PR13CA0365.outlook.office365.com
 (2603:10b6:208:2c0::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.17 via Frontend
 Transport; Tue, 5 Nov 2024 21:55:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.0 via Frontend Transport; Tue, 5 Nov 2024 21:55:42 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 15:55:37 -0600
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 33/35] x86/bugs: Add attack vector controls for l1tf
Date: Tue, 5 Nov 2024 15:54:53 -0600
Message-ID: <20241105215455.359471-34-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|IA1PR12MB7590:EE_
X-MS-Office365-Filtering-Correlation-Id: 52a9bee0-bb27-4fb4-879f-08dcfde49805
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GNTWASc5UY/+9OZjWOSwQPR9lz6L4bp2HbL6LQBvfTv/vL5UJ4TiIIn78pqj?=
 =?us-ascii?Q?u5w9jnDOrxiWt13/HkVzjFymWC8rD45FISTsNdF8EdZoOHIOqDugSIcUsnxD?=
 =?us-ascii?Q?m5v2zp1X5EkVNCSm4bxj/ADgNVqQ697JU7w3zUfCRzq2t+/slgxYppU/HF1u?=
 =?us-ascii?Q?rewYpqq7G0LknHNrbQU9g8W+tD0z8G8+XU7wxQR1wiRYpyas6w+/WUHHP74e?=
 =?us-ascii?Q?pYILbmqAtxMZrvy1uw4OnErANRWpu/f62kosTlG2NHe3pryZJ0jFPqL5wn9y?=
 =?us-ascii?Q?x2rD2/Pa9peqB+g9AwR00PQlNQr2G30/Tux7/o53Nk6FfvkqAvfTI0kvirof?=
 =?us-ascii?Q?4xA/+f2pRsJvEZcCp7VqJKrKLUByJebDpClO99hu88dSid6lrrq0hjqN0cgV?=
 =?us-ascii?Q?j0L5xENjhfe+VFmXxr5v3Ktf3eoT2zTi93c9lCe0HGaWl13v+qtgzbz6y9oG?=
 =?us-ascii?Q?HYu2XleLEWyrYOapWX/lk/qSmQCww0+aqWbEeu6vq025pZa2alZN0GaB482z?=
 =?us-ascii?Q?LPOFyw+GQThnLyf76dklAHYqO79h4zyemD2hBoEzOITashTTVRiFb1g+23sq?=
 =?us-ascii?Q?hEst6uKz+g/0AB9Xi5ty4nrvm+8YcO0WPdi5iee8EEiiZk4tTrRhIYNPzvXc?=
 =?us-ascii?Q?1FFxPuczzjqMvzGY9om+rkaF8AqE+Ma58MLIlaSnAuPb2hrPjLGMWRtymXVh?=
 =?us-ascii?Q?LfQWOJEABHHgXhxSzmSUsZhcjJ8AAz/1zRTX2Hp3XELsZW/mzmqCJw2uO0J8?=
 =?us-ascii?Q?jcyBmQcMC5kmI7FPwmwk9d4pzKgq6LrwexXj0X7gBnmw0bkqOuP6J11z/6Ca?=
 =?us-ascii?Q?r2qaIxIGWfBjs7lHfMThPWO7icpoGUoNxIOEcyI2vvSnylbtKMujdEdTX0QD?=
 =?us-ascii?Q?O44AwbiMrvboNqSHDT7OhWnnTr4GlKpSQJD3MygpyHgj1oLM427kfKp6fMRI?=
 =?us-ascii?Q?IZGJO6hkngCAiiY6mwz3uyxt/s90HHEAOxoSFs3Bcxw4L5coFYboHYm0wsvD?=
 =?us-ascii?Q?spnMFRX3i1YwhTM3RNdUIoKtfxviiaR0+khgihOelXM+KHFRn5MvnsWzzotD?=
 =?us-ascii?Q?PUnVbmvZVamvY65xCTN4AvUU9zKTlY63euIqLql2ZQYRziQx23knINljGt0x?=
 =?us-ascii?Q?5luCdVgTtejKTr7KZJh2bNHSSGS/4Mu8mLclvNg7FZpcpEVQlu1zqnE/h+7h?=
 =?us-ascii?Q?FB86Xg29cdm+BLxE8SqDVGRKrNzcqkX+V5olxVTt+I1kvPCwgY6eB5ZulDp2?=
 =?us-ascii?Q?3kRHMPieY0BDs92aTZRv+cQcApEkva2ZbSktqJ2Nuvx5RUd3jWVkamKzza0H?=
 =?us-ascii?Q?HiGDBcfuomR91npwvdgeC5z9fnZetFg0HSy9xDaLuv+2oUN0Orr9qupxhgUg?=
 =?us-ascii?Q?26mAMKWouoA7FfbgDR/nurFyoMQ5qOePPJeA+iWOdrMC6b0g/w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 21:55:42.3856
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52a9bee0-bb27-4fb4-879f-08dcfde49805
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7590

Use attack vector controls to determine if l1tf mitigation is required.

Disable SMT if cross-thread attack vector option is selected.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 4d71b4f969dc..81876a24c83c 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2725,10 +2725,15 @@ static void __init l1tf_select_mitigation(void)
 	}
 
 	if (l1tf_mitigation == L1TF_MITIGATION_AUTO) {
-		if (cpu_mitigations_auto_nosmt())
-			l1tf_mitigation = L1TF_MITIGATION_FLUSH_NOSMT;
-		else
-			l1tf_mitigation = L1TF_MITIGATION_FLUSH;
+		if (!should_mitigate_vuln(X86_BUG_L1TF))
+			l1tf_mitigation = L1TF_MITIGATION_OFF;
+		else {
+			if (cpu_mitigations_auto_nosmt() ||
+			    cpu_mitigate_attack_vector(CPU_MITIGATE_CROSS_THREAD))
+				l1tf_mitigation = L1TF_MITIGATION_FLUSH_NOSMT;
+			else
+				l1tf_mitigation = L1TF_MITIGATION_FLUSH;
+		}
 	}
 
 }
-- 
2.34.1


