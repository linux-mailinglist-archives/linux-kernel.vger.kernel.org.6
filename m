Return-Path: <linux-kernel+bounces-327154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE0C977140
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 21:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17F681F21F5F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 19:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBFE1CB502;
	Thu, 12 Sep 2024 19:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tdMpiHU/"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2067.outbound.protection.outlook.com [40.107.100.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486FA1C7B70
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 19:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726168177; cv=fail; b=IDhRxaEHAPSEA1S/hxhI1ife3J7yr+13p9jMx5Gu8btDsCDgMkUXPVLLYUojAo9rrYQk5zky5bNGaKGZShsqz0MFP0zsgriqrAFe8tgkc/EG9Sw7VJrkbVz1FMMAg142YcmzNmzlsW1U9y7obT/NJr4yJb/VglqSAWlDaGZfcbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726168177; c=relaxed/simple;
	bh=nBLyLMszeF6oaximPra2L6F4/1S7hz7BbROYstgSolo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TmP5T2IsfO2ZtjzAsuezjJivhzUklgkEjL6c4bfqNqE66qtuafO80+MPDU/QjbfByDaWoGg8HXaxH2f5/nSWs+i8Cb/P0ltv5tSeQspMkJsQdIzJ9tg6H+Sld0dIM4V20cGpymG4/JaoRy9tnsx7AUEySMHhGo4/O5/9Wo7aDCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tdMpiHU/; arc=fail smtp.client-ip=40.107.100.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xzN84gaEvsik+KdjbnyOob9a+5zKXOyiQTn9ePgGmvYmeAxS1URh79rDtkoA82Qwsc2bUX5XuV1vgxDL+6121DRdDAPGRqESMxQLpJKMUuRcLXo779qkQZE4EFp9WW+vmOk235ldf39xfpXMajKxuK7imNmEXj3tN6r6Ev7GG9XeXPFAkSMgSEX3+dPUZQTWgVW2WvyeLIogNoMz2hCkceEBBrFgoeFPtaH7UaF7uwvJjh34VoDhl+OdoxCV5P0N4prj8BScUyg05soI5EmoGBkl5LD7AkfU5mrEcBILc/G+J+YtBHl3oPryXi6Er7rdJoPWIRHWbMVd+pexUJ6vnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HT3W/kAuvrnzodJapepS7CFdjaIwZ1K+qTC5wABm5UU=;
 b=YaBVNyIh8VDDnEQnDry9VuscVQeMHU7tJdkKOmHZ13pxUvYQ8I+bB/HTRI1rRT5d31QcjPfBlGRQomt5EiuJWUCfehxW0Yb5DmS51lGZC/ZuMY5a1rrwxFRUunSZsvKWXrqgl9bKRcb/8rO1U7X+RlHqtBzWjq8OYh/y8frfR4Qj51S5u6iJgQuv0R8VKcJiG6WE3QiZqO8WT35EpEKfd8RZBqKfqoXPisH5z+AefxELi+3jkgxc53dKjfldDdCSG96ikYB8il5hGQRLKe3znaTYH5l6g1VbIJPPUT1+0RQl//Ws3NlOwa2PwmTmKR/DkqWW4DZXx0PfroM2P/ysVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HT3W/kAuvrnzodJapepS7CFdjaIwZ1K+qTC5wABm5UU=;
 b=tdMpiHU/Qh5LNvX6RxRHhkZ+wTWzyBaZKIvVHdBpw8H5tXv2j75I8nmwrazWjp8qL8aZjgI0gJiHFaoGR4BDjn0dJ4OSn2219QzMOM1fRGBSu3PSLnigJFZvXNY2smcQYCUIag7noyINRiO67OlM1HOKx2kcjBJIX8w/DTnoqDw=
Received: from BY3PR10CA0021.namprd10.prod.outlook.com (2603:10b6:a03:255::26)
 by IA1PR12MB6113.namprd12.prod.outlook.com (2603:10b6:208:3eb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Thu, 12 Sep
 2024 19:09:30 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:255:cafe::38) by BY3PR10CA0021.outlook.office365.com
 (2603:10b6:a03:255::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25 via Frontend
 Transport; Thu, 12 Sep 2024 19:09:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 12 Sep 2024 19:09:29 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Sep
 2024 14:09:24 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 33/34] x86/bugs: Add attack vector controls for srso
Date: Thu, 12 Sep 2024 14:08:56 -0500
Message-ID: <20240912190857.235849-34-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|IA1PR12MB6113:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b4849a6-411a-4931-da57-08dcd35e6dee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZbeIW1sGwp7W7KatUwod/onD4XZ+DIEkL73+Fk44IMW990EBxpwZX0Zl22NI?=
 =?us-ascii?Q?eTUNoJI1jriERsLFpBJmxu7YevTti51McWCatR0FoaoTN9D+BaMPF9hQw6aF?=
 =?us-ascii?Q?g9qXcjzbUV8DPXs728YZZGG68hSiMH5b/biZNNwauyhdUD0CkgwKB75SV7hB?=
 =?us-ascii?Q?dfxlNFEHIRsEBMz7YCy3dhaiDM1h4AZkwfvXOV0lbBtzN7c1TjMSRNEtijJ6?=
 =?us-ascii?Q?2z64BRYXcEeAFiLmN0zRQOUkZXupciwLQ+n+S5BqT5IhB6fkyL/bAMB4LE9L?=
 =?us-ascii?Q?v/kw0tIWh/j6YsVfaX1um85s++Uk6us56aVNmqTyzXqbpmMzZabNpX6S2uN1?=
 =?us-ascii?Q?tmcpxHFc2rroJXTdofM5XdPkmCWh/HdziN1AMa4V49E4gvKV7nm8UboiJf+n?=
 =?us-ascii?Q?eRcC8F0Y/2Uv2mLqWWCHZ9UWENJ+lRt1jFi6krfu14u41J2JPjRi968/S7I9?=
 =?us-ascii?Q?7z0FmxUnpQQFqUSfi36Eh//huIKMi58EDLD4G5M+rbXjqvXFU0gq4Q7FGGE7?=
 =?us-ascii?Q?CqMhwCt7W203P7FJCd68rcZaNgC9Pb4e/VxiA/JLx+a6ws66uXhqXPOclmrk?=
 =?us-ascii?Q?LwLsxA/j3PxXsOcCty1YZVZvxTufH6HqW7FsaXerWVjsrNIi2ffdNNIl2/Dm?=
 =?us-ascii?Q?00HcAdNGsVzZayn4NHoS2mkup7Xl2v3UyE2yP2eqB/F80xj7r3GHDwwLiFSu?=
 =?us-ascii?Q?OKYm8gjAy2NjGZCK5K2xUsXMsVZyiQ3ooPaHJl37mk3RQo2n6rfpDgk4bXzF?=
 =?us-ascii?Q?lJ2HLw0seRa56Pw4MlT/k1h8t2xWzz1VdK6GFv5Ze0KDBuY+RkxtZnWTg8Yk?=
 =?us-ascii?Q?vdT+QTNFfcGIub1OS2ZAfk80tB5XGgURKhAIEf/SvH8FEWDdf7S9asQZXiQV?=
 =?us-ascii?Q?ocqoflHtzWV/Cpb17ypSe/RgQ4eFdgk1T/r9HKR9addzBI5e6Bd6gGRnr9L6?=
 =?us-ascii?Q?0goaIMRQf5hhjAzwTgk+QKek4dEkRxr7rJwLBjb8fDEZpsjqjFVQnRDZgUjT?=
 =?us-ascii?Q?RMAgZ+tUT3cyHWhhGsaiG9fk7MX9iU9nmKKUZxd5iPpyPfDd3QHosO33W5KY?=
 =?us-ascii?Q?I0WtabMzWvAplVJuBT44W6jwj+NyD5DpZHdXMEXpYW0IvNQTTsXHF9AXfZcF?=
 =?us-ascii?Q?2w1rA0IENWtYdY+K9lhLvs75io4P8ySYXbXcS2O4+qvmdse7tljYVkhilcvN?=
 =?us-ascii?Q?x/PiTxHXBcVbyql/D2y8nJIWKDYBOCV7doaajxXHKf4nnuFbPEneqnv+ZRpd?=
 =?us-ascii?Q?heKWKSOUW4F1DDRFKrYzCLRACLwkvPMsN3nwoJu+4OV/B3Yh9mIjU0JQ58PA?=
 =?us-ascii?Q?719YlA6jIMjbq266Fzij0B5WsS+H8UnBmKmbQ1ZSQBwB5fBRDi7TKznRHFAh?=
 =?us-ascii?Q?CmI5iGcGfWD7nW6xwkx5EMaYVbgiOpHUevKU6xL++ADDvezKgz86s/lKQMVX?=
 =?us-ascii?Q?MwEWLYddtyvggKklxSyWuy7PcNHUMhbS?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 19:09:29.9993
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b4849a6-411a-4931-da57-08dcd35e6dee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6113

Use attack vector controls to determine if srso mitigation is required.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 3be3431c20c0..ddade7d6d539 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2842,8 +2842,14 @@ static void __init srso_select_mitigation(void)
 	}
 
 	/* Default mitigation */
-	if (srso_mitigation == SRSO_MITIGATION_AUTO)
-		srso_mitigation = SRSO_MITIGATION_SAFE_RET;
+	if (srso_mitigation == SRSO_MITIGATION_AUTO) {
+		if (should_mitigate_vuln(SRSO))
+			srso_mitigation = SRSO_MITIGATION_SAFE_RET;
+		else {
+			srso_mitigation = SRSO_MITIGATION_NONE;
+			return;
+		}
+	}
 
 	if (has_microcode) {
 		/*
-- 
2.34.1


