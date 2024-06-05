Return-Path: <linux-kernel+bounces-202810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4978FD175
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 17:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95FFC285646
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 15:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DF14C619;
	Wed,  5 Jun 2024 15:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2JTuK3j1"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2066.outbound.protection.outlook.com [40.107.101.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E606E3FB9F
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 15:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717600761; cv=fail; b=nw5uvKVxtQPsaAMf0ikvCUIokxJRU1JzxSzvgp0LSYBvRFJMfqaaCv1i5ZLTwaRCX/IuA6h46EbisRIBlYOzOldVtdmmoxLhILbq/+hh7XkTYamPNQYDw1WyO1oMwqxy1ivvSwtF+HjtwcQ6kkdLXp7JiwB5dgdTMd7nWBd9OT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717600761; c=relaxed/simple;
	bh=IavZdyRsGZrMrbowDBZRv1TxGG6Bz6Lt7A/t6mgnRj0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KKQJlodx89gq/BrbN7Q//MlQzuxgdivLYP/OLvrCFaJLBrTknwjA/LdTVvmly2K7IWKZohnkjuUeHFVWqigMscHmDN93v2v7/KZjF1AKRd3KgJYjvvo2dBy2YSwI1HRrOXp89hTyvWaSvEb1/rmNJz2epzTunU9eEHQVCxK8OBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2JTuK3j1; arc=fail smtp.client-ip=40.107.101.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cXPmMb9BO6eouaKyfakSrV8J1Vu7SiPYisqsc8YDz79PVqX/w+DwlKZ2JwUo3oPm/CB0usEWTjzGPr4EABEXb3t5BBpnzRs3zP0oU0YAlgWF3lJi39TOy3yOv+YZOTEWS72d0+Ag8Fv8wGaseyMfrNvAEYraMCqWJdTQ+dobOBT7kF26Frk/WEXe9MU/iVI6v9fsloQpLL6wgAFJcV+0vvz2yxs0hSlsO8M68jMw+DGrT4Yf6isDttJHZy0rE4qxlAVMI4bBK1rkiim9SQaQg0m4amh56JcnowEm36x003v2eoNzBo5WatLylXMkhTUnZ9Hb9OJwpeInpJZu5J4cHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97CFRtmVneyhtbBwUcNnRcQCwWEYI0vvcRSrjMKjYnU=;
 b=RL3I11aNUIGxICi9by/BaBJ2RRKgqK1kvc2pxTBBNefIq6wj1UI75wAALCN+aDhd0u60pr5f4LA4DTrM276awQSfToNh2uiaiRJbtzi+hoLOe9Xc8cVN84NYUG/JqM3egIjpKZs/zGiciqC80hhd5rZmqcLY/4ZWtmRTiuaicRlIyROBJgRU2b2xasMbG2/+asYBtaUduEhX5uppiR0A+HSOTXLZOp5vHcBOk1UYVHKAVgRoIx/WdEu6y1WiXZRxZ58jRSe/aHfUsGJ2R0E9i4vtpUfD1xCr6vv6Uo9CVyOdW71Qa4E1O79N//0i3yiuw3FzK63vVVB8gUTwbt8nqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97CFRtmVneyhtbBwUcNnRcQCwWEYI0vvcRSrjMKjYnU=;
 b=2JTuK3j1eYjgwGUBLSZ8dxf81huqo1ddvGQb6cIJluZ6hCtQukDQwR9gHAuedeXaAr2E3MZhVsI9YXN5axYlP+XYqkoVNjz8FKNKXs0hwPKV1nDXUj8lEQ+f2/KU/mcn7hZoAUcXS8z4OtJox7uNTOV/y6iu6NHUfFCnscv4Dwo=
Received: from CH2PR07CA0046.namprd07.prod.outlook.com (2603:10b6:610:5b::20)
 by LV8PR12MB9336.namprd12.prod.outlook.com (2603:10b6:408:208::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.20; Wed, 5 Jun
 2024 15:19:16 +0000
Received: from CH1PEPF0000A346.namprd04.prod.outlook.com
 (2603:10b6:610:5b:cafe::cf) by CH2PR07CA0046.outlook.office365.com
 (2603:10b6:610:5b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31 via Frontend
 Transport; Wed, 5 Jun 2024 15:19:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A346.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Wed, 5 Jun 2024 15:19:16 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 5 Jun
 2024 10:19:14 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-coco@lists.linux.dev>, <svsm-devel@coconut-svsm.dev>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v5 01/13] x86/irqflags: Provide native versions of the local_irq_save()/restore()
Date: Wed, 5 Jun 2024 10:18:44 -0500
Message-ID: <c4c33c0d07200164a3dd8cfd6da0344f57732648.1717600736.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1717600736.git.thomas.lendacky@amd.com>
References: <cover.1717600736.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A346:EE_|LV8PR12MB9336:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d2fc1e3-934e-4fa1-e3e9-08dc8572dd55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|82310400017|36860700004|7416005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qj3/CI2mdRq/ILwJYwnHQVR632YRlgmYKysFDTxWoQz/HRt1bbmgyHwVj1td?=
 =?us-ascii?Q?LcNMVtDJyqX13SjkcBWwW1Dnnsy8VufnAMOYj3YdW5dTsbWGu4yU2BkNE40c?=
 =?us-ascii?Q?FMjNM9vkxbgOlJq4dzBf+itXXOwMVPRaRnwgEvv1xd5i9edjDi1bZ3JTwio5?=
 =?us-ascii?Q?DXt65Le+bPvixyHpENOiZUesTWGF+wYrlpbTEts4Njc2cEtbtMNWGjU7WIkP?=
 =?us-ascii?Q?xsVsxA/cFkCe4xj+Z6lAmr8EN5aVJ+eyOvkOB9jLzuUXSSf13PHpkZNa60Zd?=
 =?us-ascii?Q?d+MMoxfNAT3dA/Itga+l22ygbY1c4D1FsMUb3UqAc0TZydRK/giAfBMfnWlU?=
 =?us-ascii?Q?uBbi1zHceL2lTNjHqz1nwaoZPKidCbxAu7WCpXwrb4wTJaiIt+Cua9sGVAte?=
 =?us-ascii?Q?NoYWuVmRUgfBNTmC22vLkrvbOxrdv9YtRQTrbZKu8hR1FCOunx0LI38B3SQp?=
 =?us-ascii?Q?qXFSY1moDurWq85FZZ9Dyp3PkKA2iBRmmzAVL2uW31W3ExFrH1Vb9C9QR8rk?=
 =?us-ascii?Q?rp1xbCkXqe2f7URYn5dH4207qdofj0Dt62OpIrDGQOMJ/f/PfI6SV0AWzzbH?=
 =?us-ascii?Q?HmGOWDVo8YsP0PTVPmeF5zBb/Q6xPF4D8aCcwtzgyGxty0LwRYWH8ktlGDeb?=
 =?us-ascii?Q?buJ15YVbiqYCAHSJ6kyzmkIQGg1/nQd/5qNM8UYJn1GU/WIYGWjYUfC0mhoi?=
 =?us-ascii?Q?tGI6KYkIl8f4RRVwVYMEGZsji4lCKsHpwICPhOjt4p5FFbmbje3KWpPxZ0n0?=
 =?us-ascii?Q?O2lnqANW2QA5IgyWEJywnFRivzAdcA3jVQAlOZMs85K/A0CFKNbBzPtMyC2L?=
 =?us-ascii?Q?MxevQJV3GNTMs6meI5H1X2GKr8VGnp5/9dP9pp4vMk5UdsFJ6tMU17DRnim0?=
 =?us-ascii?Q?ovSjtWToa2m5JZH4ckL5b6G5WfdY2DQ45CUYYIkWp53Kx0hJQ9b6JoJAI+Pf?=
 =?us-ascii?Q?U8I9wc/i7kjc2kmxT98fui7UxMfcG+EI1EM6WYdwFc/UGh4U5tsglgci4jrQ?=
 =?us-ascii?Q?9QJT/k3eOI/FborqDgKy1FdYn/PDOas2ryx2BTvrWN3L33XOnOAPj0RYxPwU?=
 =?us-ascii?Q?DbtKdIZH+NY8VF/j24/ebLZjai4agub9qrpAit84QE5+xKgOSu11Az8WtH8q?=
 =?us-ascii?Q?cs/9W5vfDZw3EHftUMtq7VsgQidRbGod4Ymf6siqOncLtGEepuzNLDyWrvhn?=
 =?us-ascii?Q?Lf6dXIxOrRvH3y7pHxJhqKxf+6RxeSZrVVOuXH25jJ3qZ5+Mougm67jB8kvw?=
 =?us-ascii?Q?x+ZEGWVF1Ejq2/Qcq7G8Xdkva+o6ziPMYNe92vAP2uDrzTJUNl+mUw5J9U8y?=
 =?us-ascii?Q?kRXH7PfOHtbC3tDKqXqyXysR5XsWck4ivdZUBjTUtEdEbwRFvb00ow31nIdt?=
 =?us-ascii?Q?0LSENhIAn2DVzilbV6QjLwcm30XEE7+GraPxcnNfJW45ub/BTg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400017)(36860700004)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 15:19:16.5146
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d2fc1e3-934e-4fa1-e3e9-08dc8572dd55
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A346.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9336

Functions that need to disable IRQs, but are common to both early boot and
post-boot execution, are unable to deal with paravirt support associated
with local_irq_save() and local_irq_restore().

Create native versions of these for use in these situations.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/include/asm/irqflags.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index 8c5ae649d2df..cf7fc2b8e3ce 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -54,6 +54,26 @@ static __always_inline void native_halt(void)
 	asm volatile("hlt": : :"memory");
 }
 
+static __always_inline int native_irqs_disabled_flags(unsigned long flags)
+{
+	return !(flags & X86_EFLAGS_IF);
+}
+
+static __always_inline unsigned long native_local_irq_save(void)
+{
+	unsigned long flags = native_save_fl();
+
+	native_irq_disable();
+
+	return flags;
+}
+
+static __always_inline void native_local_irq_restore(unsigned long flags)
+{
+	if (!native_irqs_disabled_flags(flags))
+		native_irq_enable();
+}
+
 #endif
 
 #ifdef CONFIG_PARAVIRT_XXL
-- 
2.43.2


