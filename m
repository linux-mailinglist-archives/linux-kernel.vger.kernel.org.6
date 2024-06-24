Return-Path: <linux-kernel+bounces-227368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2511915019
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80E4C282190
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 14:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC9119B3D4;
	Mon, 24 Jun 2024 14:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="z25rBedR"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B6219AD87
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 14:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719239868; cv=fail; b=XYyAJftGHHrcsCcczJ+piJSfcQOO9kEJxxukeKOp86E53FayTtjT8zzSUMRfzyiTEb+32hxFlndvdKpBTY7WNX0Xb7hkObTQ4HKS17QSK+0rAlA5YsCB5jeW+cQgc7g3xhrqmUWoN3Ygwcga7d1vxgWkeI3XkVzOayQq0ztXPGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719239868; c=relaxed/simple;
	bh=V+ZuMv0bvSTJwqTQFpIgo98WsMkK/FdcOjfq9ZlMuWg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L7Bzpo4A19OpMH9SxnAxbrwfLpujG4S995vRknsmeuhLtYMuyGwQOELSh3rSBGD8bzdb9u3J9n8OYH912bskjwdb6+WUmMqyitIuDCOcuO9CJKD+iTUeEghyLRahcnMD6G272hYwsKVmDidzhOT6tdTM1KYY7pmBT4AU1yg5pig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=z25rBedR; arc=fail smtp.client-ip=40.107.223.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ceb+V8JEwoLouAbLvyXPvgIO2+ZQ4Y2bkpO3wl38Z8sfR0QGWxxJNEbcm9LPzjSZNYrrDxYrmD+92DkiMVc3H4tlD0gMAYVDPShXX1Esh7Q27oa3By4cLrpzWcIMmf2+jhrRGvZOdPBP7y/ii7+BCJfN6Wy0zpgusxAv2X1rl+wUDdufbW0DQP41mjqn1vy/YcN87n89VyReWZnWQbfn/ItYf5B/o9twTqN8SP2pLDygrBoqWjp00hJWICStcQrfSufphCxluamdAaFiuXCAvSsfkB9PmCqPZTRmNNWjCfeZyWX5ii2ioXTlDfNoiTc29Q73XjtaBD8OpRQVkIUzWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XTjwrWHsITYCSLXDs4NrmCghjQikra/cUm9w7Li3DXg=;
 b=j4NBBQ6AdqZVjBiyaxLgNvj4W0MUIA5obwg3CGjiWk1NsJgw+Wur5ADxYncaf1g9LrkrE2PzNhGb2JzoR0SmZncvnL2d3RC1jnCK2AsXmnaL5oZWhtIduH4ZNjMiqCC4KTsPnq/uG7V0e7N9DpOtVIJ+z4arPw5uPlld+Sn1kQW7grVZc9Y8sNQzFuk4oJVzdiNgGMdkZjjXASvdvjxlzlHENZbTgJMo1qE0WTg2Cd41OeWhiC73GtymaujQq3oNs7jK7lmj1S0liFegtOC5e4S5w6YZCAMI3sMx6jb8YFPGlHHbUfdEcGUKyBHKkUSQ1cJArhdFEKQWmKmFbi0ddw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTjwrWHsITYCSLXDs4NrmCghjQikra/cUm9w7Li3DXg=;
 b=z25rBedRtNc8/yHd1z/tNz9iTu703G/9CSogSlWdxicyJhnxh5tpUMUdGABc2KWnHxE938ty8EahTwekCYIbm7jet9IrIccKEkE7J5RwjCS5j6h0k5PWWNQN0PRnGCAIfpjmkBMTVHWF65z4XktAqNkgUruhTqdd7Ns7Yh3z1fU=
Received: from BL1PR13CA0448.namprd13.prod.outlook.com (2603:10b6:208:2c3::33)
 by CH2PR12MB4325.namprd12.prod.outlook.com (2603:10b6:610:a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Mon, 24 Jun
 2024 14:37:43 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:2c3:cafe::72) by BL1PR13CA0448.outlook.office365.com
 (2603:10b6:208:2c3::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.37 via Frontend
 Transport; Mon, 24 Jun 2024 14:37:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 24 Jun 2024 14:37:41 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 09:37:40 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH 2/7] x86/sev: Add support for the RMPREAD instruction
Date: Mon, 24 Jun 2024 09:37:06 -0500
Message-ID: <a145840c0fc566e41743c447a1f334e56f214892.1719239831.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1719239831.git.thomas.lendacky@amd.com>
References: <cover.1719239831.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|CH2PR12MB4325:EE_
X-MS-Office365-Filtering-Correlation-Id: 22717ede-350f-4ede-eb13-08dc945b33d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|82310400023|36860700010|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fwuQi6qKFOo+e4BrAD3gl8Ete1xceB5k1t5fiUmprdJndFDfsW9/LRXd6CXZ?=
 =?us-ascii?Q?IAy4pePJx+4a7cLgOT3nacxMx31bBUc6zLn+OW9U0TyDMN7xdc5w66mAq0+u?=
 =?us-ascii?Q?wK0LVikVdp0BXQ/QJH0mBaCzv7HPS9grPn5fGptr9eoLwstLS0ZE9lthohmI?=
 =?us-ascii?Q?WQIvISKlVh2NMC+X67hRJYPMq5w1D3AI17wjmSAgrteuZYYQTUJ8+3bkOkSV?=
 =?us-ascii?Q?uVXRT6mwlUoTJwzQm7OyLtXeVQk82nUFa1PsCkkuUGwYobyMBtmZA8P5N9ve?=
 =?us-ascii?Q?JE42XdZx+Ixh9nr0i+/GPGNYs+7UovKr/KVd7Sbg7PsNRLqz9UyflAOMx7i6?=
 =?us-ascii?Q?lwvkbEvbwQxkdvB7bL5At6UiMWc4vZG8Yys6B2gOZzRsYCAZA+jsbd9QwFiy?=
 =?us-ascii?Q?npUqiH42/Q/o7RBvdFR2LTrrrrZtCwQufHmwjPr9zhxfOUsOGyXiWskaX78h?=
 =?us-ascii?Q?tqrAWF2IYxF7tpymyojwuQ3m2cfYFyxyksZ+YUp48MjIp0T1rKYGeZxanbAw?=
 =?us-ascii?Q?/IKutkgNTg8RxrCrHmDZS51hxTmSYHcu1BEXwjsfS+jzn8I5fs8UxXXx5x2w?=
 =?us-ascii?Q?3cS1l3yyhhx3P7rgcEkQDlDilJnFqSIQNuGI1xEkUsiYTPnLYi2RQUbC02c5?=
 =?us-ascii?Q?YNkBtXhb8y7qKYbbGmXn5jYjZYrfVm2p8xwRHDRv4gJqiYKrIokr7V463gSb?=
 =?us-ascii?Q?dy80htaNR3YeyW1ojozSblMJHPHkpk1rpiAxJF4CYF1BEc3uxOwhkTC83a+g?=
 =?us-ascii?Q?ikyBAMSVHTjVCJuGTs5i909YfAWuSIYhi4FbMhl7BZCw6NEvAepQnMFj780h?=
 =?us-ascii?Q?bPrISQ6o0G9oDn7KFXc9CLiakhrcUTmTaEtN0AfSeRBjFibOrEkCgP4Q1n1H?=
 =?us-ascii?Q?lL8olM9pfk57OWP8JRhLfPqgCutBvpZp9tqXMEY9BbhUrIkQ+dTWpiDh1f4C?=
 =?us-ascii?Q?RhCd51sIq65/lvFR2MaGi7bTPfMG0qs4xhzLagUpGYEbaphHEuxff3Ye5OWS?=
 =?us-ascii?Q?hrG9IH8h7M4ngz+qzzAhSgARpyqynASvFO2pPQPEpfYjHao7As34EwjChwcX?=
 =?us-ascii?Q?h5eDUwjXNHY3NDcTo+4VpvOwFsgqpVbTgnYsnQ2ivBsqV5bvupjgCU8SMC/P?=
 =?us-ascii?Q?aNUduOEJyLamrJtHXOtOpTX77UtwunHk1GRaUlT4VI4q6YXqu6Ud1ZWsTcpC?=
 =?us-ascii?Q?aE9mvzGDmJhu4N52pMOwcWlnDZUBs0fcyp6E/9+yS62PMh1amLJN9L2UJRqm?=
 =?us-ascii?Q?ZKOlfdqrOvqmcdu/tWR4boy/NWZ3WLsr386Ll9iU95yLFQh0fFTCJr+ndfaX?=
 =?us-ascii?Q?1vNMrMww0ZIwuGhihM581JjkVXREwpxhrNjr9E/y8KdcCYrRVkwH+khw6HBM?=
 =?us-ascii?Q?Jw/myslKyXt/zIoegW56CAYAZE7tOduoLYquBAj/064T9v7xNg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(376011)(82310400023)(36860700010)(1800799021);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 14:37:41.1931
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22717ede-350f-4ede-eb13-08dc945b33d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4325

The RMPREAD instruction returns an architecture defined format of an
RMP table entry. This is the preferred method for examining RMP entries.

The instruction is advertised in CPUID 0x8000001f_EAX[21]. Use this
instruction when available.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/include/asm/cpufeatures.h |  1 +
 arch/x86/virt/svm/sev.c            | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 6007462e03d6..627bd9b3f1ba 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -446,6 +446,7 @@
 #define X86_FEATURE_V_TSC_AUX		(19*32+ 9) /* Virtual TSC_AUX */
 #define X86_FEATURE_SME_COHERENT	(19*32+10) /* AMD hardware-enforced cache coherency */
 #define X86_FEATURE_DEBUG_SWAP		(19*32+14) /* "debug_swap" AMD SEV-ES full debug state swap support */
+#define X86_FEATURE_RMPREAD		(19*32+21) /* RMPREAD instruction */
 #define X86_FEATURE_SVSM		(19*32+28) /* SVSM present */
 
 /* AMD-defined Extended Feature 2 EAX, CPUID level 0x80000021 (EAX), word 20 */
diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index 103a2dd6e81d..73d4f422829a 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -301,6 +301,17 @@ static int get_rmpentry(u64 pfn, struct rmpentry *entry)
 {
 	struct rmpentry_raw *e;
 
+	if (cpu_feature_enabled(X86_FEATURE_RMPREAD)) {
+		int ret;
+
+		asm volatile(".byte 0xf2, 0x0f, 0x01, 0xfd"
+			     : "=a" (ret)
+			     : "a" (pfn << PAGE_SHIFT), "c" (entry)
+			     : "memory", "cc");
+
+		return ret;
+	}
+
 	e = __get_rmpentry(pfn);
 	if (IS_ERR(e))
 		return PTR_ERR(e);
-- 
2.43.2


