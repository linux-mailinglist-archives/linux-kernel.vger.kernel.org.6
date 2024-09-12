Return-Path: <linux-kernel+bounces-327150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE3097713C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 21:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D61921F22B8D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 19:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EAB1C6F64;
	Thu, 12 Sep 2024 19:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cSC2g4b9"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0941C0DED
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 19:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726168173; cv=fail; b=G8HOO4aR9RPXgZOxIwa0BCfT6lvCzS61ykI3R4SDTOJ7568pBJHG+EPUWORf/lojv1KQd171OsgUJslo93kl/VEo+UvCeSt/VpsBo25wIup6HKjXTxnxaF8VuyUUD87dCvVodWd2BMaZHBmc3lbszGsrNu4ItyjQP/wEQvDf5pM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726168173; c=relaxed/simple;
	bh=8Az520S19A4hnO4BaOXyrPybz98ayUg0vdbw32FNBa0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ebjkjetrQ1RTg56ihv7f75Dh++r4B/zIY4soc/rOmY14f7ScT4WOyjszUN7XdMlSs/6R/VtZ+khIAzQQG+SIvNgfkJ+J07IJ5DviHPKT8tK9ht98gEau4VjEunmpla1MsdPLL2Qo7hsgqh81F+8Clp8PUfrGAOmQlcw8A+MwKbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cSC2g4b9; arc=fail smtp.client-ip=40.107.223.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E5pQJWJvq1glOt6gks726LlzG2NPdIZH63TJKV0vj/UZ6FN4zsvXQE8354f6oaghq+7E9uxH8HJnpcQk1mOXe0gi3CNGek8ua/EfU9OjUbPhimoH/Zm6iHz8fYtel1T6qldp0+6wSxSl/5IIvcytBYyokPPPiD3lEZ5u48H6RXDW8rYiZMJTO4HkQ9zPUArBaEhBuDi3lNGHOr09Ob52sPBJIiTYZxIQW3qTfJhm90+shiH0lZsD4aOmFI5MMBABaQEeWdq+Utf4uGgMN1m9dyrU4l3SpHrx+nIPWkgyBp9AxzurexnmsdlYt9VzX+uLeMLLz2BBcA35ABhSU0FkWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jDupyZidfjkXdIRc+EP/nbJNKW52wfM0oa2nVgVrio8=;
 b=swnknLQ2GRl9jtkurRnghwyzosW/8owDOS5MABfEhY1C9pimzDjVIgT9lTnGd0RzC6cqLFVvEY1FvKjaNJnmZvuu8104axn71vMFFP/sy85wKHMlqtBFjrTPEwxAfuN2bdS4juiWThbYGCWGFqlqGGpv1E+WRSEbWuztTBX7TU8TjaBka6eNZkS76tLv1uL0P3VuxVVHJpefIBLJ8rp97Y1zdXf3tF/YeFuynAd9HLFj+dNT4SQDIckHjzcseumIVpY0bNXqZCD3ZguQGXHNHGUqmXxLz5kvkrRV1nQ5ez9F2hlwklsHwSroIfuV684B1HROZG5r/YDt0v1QzFZ93Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jDupyZidfjkXdIRc+EP/nbJNKW52wfM0oa2nVgVrio8=;
 b=cSC2g4b9EaAyfof6T/p5t9zHeQBNI3C1Yk+hH7owzYbh1CQE0wA9Ld2TQpKIbB2z0gCWjZD+NZ2m3tCHirObanQejSejJLHRTzQp+oFU3K0kf6JJ1YiFKehyM7tkZPthIduj+abhiTN8ZNmz+fwXIrisHDHHh80DR4bUx1DVvUE=
Received: from MW4P222CA0011.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::16)
 by DS0PR12MB8043.namprd12.prod.outlook.com (2603:10b6:8:14d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Thu, 12 Sep
 2024 19:09:27 +0000
Received: from SJ1PEPF00002313.namprd03.prod.outlook.com
 (2603:10b6:303:114:cafe::ad) by MW4P222CA0011.outlook.office365.com
 (2603:10b6:303:114::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Thu, 12 Sep 2024 19:09:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002313.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 12 Sep 2024 19:09:27 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Sep
 2024 14:09:23 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 32/34] x86/bugs: Add attack vector controls for l1tf
Date: Thu, 12 Sep 2024 14:08:55 -0500
Message-ID: <20240912190857.235849-33-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002313:EE_|DS0PR12MB8043:EE_
X-MS-Office365-Filtering-Correlation-Id: 855b208c-2cd6-46f4-8003-08dcd35e6c22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vMNjQWv5Lpq98gkPW3o940z1i86pFczyu/8pCyNJtTuWPPWlepiDf6oBQxJD?=
 =?us-ascii?Q?75FNtZgve8BTYcvWF44BYPy9BFAZwGgtPgm3+OJpYdaCBDz7Pz24QjFmWwQi?=
 =?us-ascii?Q?rKYkbkMehRDbHrQ6iRFUkazOqPFiT+1I0aOjp5VNXtI+tK4CDYVVAX3sZbS8?=
 =?us-ascii?Q?zI7jBPxYmqPGDHUzfIwn8IrAtbpAV1o2aoIWVFk+nWVpwmDUsLKIJDzEQw5S?=
 =?us-ascii?Q?TgqYUzZ/bFnRpx/TplLtFw5AWBz3mvPU8zq83YXSub/m0JPHz4+GnRP5hvUx?=
 =?us-ascii?Q?nnGVWmuaYn2IB4g0L7tOj8PnZDmuqA3KwPWdhkOejO3zN1P4xTWxS/DLfN40?=
 =?us-ascii?Q?uEgKBUOnKa9EItlp2ine1g41Lc9WL9805sciSKJu/Zhq2VkV6li3R5XIm6qZ?=
 =?us-ascii?Q?NHRb1iQwjVJgdZZsF+rYEHJ4BmdqCyRQ/IgilN4/Xk0NkNdT/IbGtK5IYEY6?=
 =?us-ascii?Q?aiLjKu3/0zlgR7HN41F3kIemDUUWdvVI6RCpBPxpZz3jVm7uJJlCKXTND7QS?=
 =?us-ascii?Q?ClKXTA851SoYkaNEN4z8qjVlIG5SYTfDVgOe1D39oKzkEyuDpnw5tyJ+uB0Y?=
 =?us-ascii?Q?bCpuWolwgj01mMiITZ7qt3kDZoezlE9fWIQRV00CaX9H8pq6ssiEbGok94BU?=
 =?us-ascii?Q?VH7hLKdrvaR/RDXbLUf88n/4/JBT+5qbeq1x1yLEGcUf7B+xO3w4jlmriDTq?=
 =?us-ascii?Q?sDCx+YPQJp3YV7Z+eKG+0bSilM844/kVF7cReLqIYlTbC+QalFvT8wV2M0hG?=
 =?us-ascii?Q?qDQ2sZmTTy81DRiKTL+VKXHQRnSe5PTJD7ZNUWQax5OQ84LvSTS70rPG0G14?=
 =?us-ascii?Q?eLZcFlzZMsrXGGugZdHztZRkw5pzMQFsyfGymnDUgScG+KbMWRwlIqCCwgrW?=
 =?us-ascii?Q?p3//D9tdW50VZ09I9Y1LBWQR+6MGoB5AXpvdVXA1kwvK2uNh4wpCggSHi4U+?=
 =?us-ascii?Q?MYIByzIpVBFrJufngJ+oadfBSEKA6tqlEbi+kjgCJsqE3yW2/a7TZVn6SHtr?=
 =?us-ascii?Q?XrbXXXl5hXkDejM6+zFZLOHaWAyQbWgBaBYobDfy5fGJ21VZ4TnXSTZ/mmyw?=
 =?us-ascii?Q?7ZdDkMvrxMAxNr1tZlsKWt3fPg5llI7Ys6z8jW+cEehk0WkAjFiHpu57PhPB?=
 =?us-ascii?Q?HMEwKwOZae7GCmBMiLF/TFhcOGwsqA3QCWBv8s6p2kpwTPhjVTywX4U5dmFh?=
 =?us-ascii?Q?uCp1wPKqtBWQ8JNc9iKjN5cWj2VHFU2rFChajZDu/4jX7oALQviKQZd93LTA?=
 =?us-ascii?Q?kopya3ecHpbL8gBFW913Uy3cahhjK4tFfGpoO81NhvdR+UbBrOtVrA1lMPlX?=
 =?us-ascii?Q?Wp6AJk8IWag6QY+NzFvMp3e0/X5d9iQktPTCcCZq1//U6C5gsIuza5KsdNiR?=
 =?us-ascii?Q?uRWPVpwCDXc1uV/i+DzFON38Am6ESeTPCn2EBwMi9rohLGzeuA6UHiegFc/F?=
 =?us-ascii?Q?3GWsXQt+hn6qtQxQjO5MURyk+oU2yRSt?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 19:09:27.2792
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 855b208c-2cd6-46f4-8003-08dcd35e6c22
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002313.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8043

Use attack vector controls to determine if l1tf mitigation is required.

Disable SMT if cross-thread attack vector option is selected.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 9c920e2b4f33..3be3431c20c0 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2700,10 +2700,15 @@ static void __init l1tf_select_mitigation(void)
 	}
 
 	if (l1tf_mitigation == L1TF_MITIGATION_AUTO) {
-		if (cpu_mitigations_auto_nosmt())
-			l1tf_mitigation = L1TF_MITIGATION_FLUSH_NOSMT;
-		else
-			l1tf_mitigation = L1TF_MITIGATION_FLUSH;
+		if (!should_mitigate_vuln(L1TF))
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


