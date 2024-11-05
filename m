Return-Path: <linux-kernel+bounces-397212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8449BD7F1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 22:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D6681F260DC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 21:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30635218304;
	Tue,  5 Nov 2024 21:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wzEjK9kR"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D784F217662
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 21:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730843742; cv=fail; b=Ih5qzO2nfKZwUQGLsP9OrdIG6Gi9d4kUst8Cth0gKq0VbHE1BVhu+XTByAgmmbO9PwV8HCoyg9GKy74vn+XqcRZOaXyNPFI/kF2gxtBFyGx8b5rAaFSkQxk28Fd/G4mOGPw/aPknPBuT0wHYoJHZAzWR9Zn/Y5PFTDJ+gHIzTf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730843742; c=relaxed/simple;
	bh=ZSbUaSxOnSkX10OU8szPqmY9Q90CrrZ6diGNAYNl4Ws=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kBYatz8pOv2dEy0vDBER2C6w7jEfStC4FaF+/ExtwQYmxOZPdKbDE4EZU1jRWpMgLRl7e4bvkPapdbVrHLwsNo/nLaa6hr9Qlzd9gPv7Y5iEzT0ujVPsYATyi3E8OrWQbrVxsXdSaB5oudZllxI1re3tY0vroHQUBoGmYAzba9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wzEjK9kR; arc=fail smtp.client-ip=40.107.244.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vRX1rM8gQ+GsGUNpC5S9TxgyanomiV54b8ppeiFdWYdIldIlxTROv0t/xm0fz6J+LSQrgCDv3wny7UkpGq+3BzwsySed3goPeM58YOKsl9OP+dKnfhoyPgwf2BaHR9QOJpPuIYGatwd7QtLK1u7xBTY2J943IWIJsvr9fKb9nCVg2c8Ly/BeIq22R9dWiI3F0YZKlP+zrq4pJCFcYaJLIsOh2WRt7Nmphfo5VrbOrmetsl1tI21w7pLmrd8QEWyYKx8ew1pwoEkdOGTZOPEcn0Ty1tQrXG/lF/T+kNXORdkpENRV1JBgtfZEy3r7mxSDBBzxhYAh87A2FwHkuFFoPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DrXWqA6H2z7ZT/JrW7XIB97O/e9mwduMFdJMrnKiifA=;
 b=IhZzPlERxJauhPryNhrk40W20UUF81O/j/BMYQ039nQ3OHK35KnElilo1SE0EPj0M4SSPczMMbzNnkS/Md+wLUdXqiZer8cZmFv36bOk0a9huGBwsnXftGKurcFssIIVfJy3hsSUCw9n/KHRkHvgQgwG2HT5+FcuSG5xVy1pw5gSZaWrp1LvA3wXrt+/tK7Cqh7KPDjLa+n9TMx/BmCSGfXKju4m1NxGf702Nqp6m4tK0yJjRCdE4mZQsm+/NS62h4sYMVTQHM/2WZXf5nfvxyM7PL/0c40jvqqwV27IS1Me0fm3H4MDiK5qtsSTGiBKe8XnITzciGXIlhgFo6XaBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DrXWqA6H2z7ZT/JrW7XIB97O/e9mwduMFdJMrnKiifA=;
 b=wzEjK9kR/LPS9SOE8c+2kN6nzYM/x2+WpO6uBeJ+A/oLYbcrZmBCwC0V2gd8rtDMgShgzsxQzUJhsW7MsKUl6Wb2f80lKOfL/KhLvkuhEk15GyTNajmkX09ncdmAYfrAJ4IwUyRoQ3mIlRRgJV/7a16E5RGsfXybacfueBNAEyA=
Received: from MN2PR15CA0060.namprd15.prod.outlook.com (2603:10b6:208:237::29)
 by DM4PR12MB6061.namprd12.prod.outlook.com (2603:10b6:8:b3::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.30; Tue, 5 Nov 2024 21:55:37 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:208:237:cafe::4a) by MN2PR15CA0060.outlook.office365.com
 (2603:10b6:208:237::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18 via Frontend
 Transport; Tue, 5 Nov 2024 21:55:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.0 via Frontend Transport; Tue, 5 Nov 2024 21:55:36 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 15:55:33 -0600
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 25/35] x86/bugs: Add attack vector controls for rfds
Date: Tue, 5 Nov 2024 15:54:45 -0600
Message-ID: <20241105215455.359471-26-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|DM4PR12MB6061:EE_
X-MS-Office365-Filtering-Correlation-Id: d9187aaa-9bdd-4667-2d2f-08dcfde494a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UlFaYf+Hi4Y3P7y1atyuheVAOPNyYfcixeeL1SVGVgKfFyeWPnlnRHOvB4VJ?=
 =?us-ascii?Q?vKIO+Rm+xkduywf3d08IPacoMWjIXf79ZQQS6jnyntuPf84LEnNtyC4lq5II?=
 =?us-ascii?Q?VlH00xJ1lwm3mlxxeCaTas7gDKOdmiw4UTNXcuUtS8RMM1w84SpHJnVxYP/T?=
 =?us-ascii?Q?fJqZ/9dXa1VFcI35etRca3YT77vYsVb9waqp/u8NTimqEjV7KDn648xPGXKI?=
 =?us-ascii?Q?WZwMF23hKLgeXo5eiEr1fiuXsPSmQlkms8Ufg/bzmMyJnbsHl5OmOE4PaJiW?=
 =?us-ascii?Q?yHKgBfac05qNdBveYHjW1qmfo5auELenaqkiWowGwQaiQDUYbB+XxOjkxmz1?=
 =?us-ascii?Q?b1ljgSPZ7hWsB1sGvMDxWk/PNuTWnwQxog/3gsy0Jg6hmlOOXq2O3b0o1qDV?=
 =?us-ascii?Q?4vBQqn2ByEbpG02KhBlaiXnhPokcnc/s+1D1SdeTNa2tgYDOQMV3aHu6K9ko?=
 =?us-ascii?Q?Oj3QgigG0/Po4I49C5RlFt/pUX3G/mXP4HzB+4PE0xgm8qsDOVTuKeXQaA4L?=
 =?us-ascii?Q?NWJ7+y6TS1kCD1k45kSOmGR9HhUTUQGBhcexYcPVmhjEJzgVmUkCCXwpeETo?=
 =?us-ascii?Q?Bu+nBI1xnDTpL2cc5sUEeIQW/oToS6CoBfqgmrhfIt9vD53agepGX/m+5ZqN?=
 =?us-ascii?Q?D+aYO/qbgvKJgyn0gkTrdON5ZvNVuFjBPUdhbSDyjlsWk+x3s7V+7dQiDj/H?=
 =?us-ascii?Q?l6W/ozNu0PghtX2TE7/y+HKrCkWAJAlp7Lp3oRQkZu2ncTSY0UdcFvhH1zX6?=
 =?us-ascii?Q?G+nAZT82DoYTHGIohSe/Gbac89SUUagNs+iy/1DbBuTIbIJ6tR32jAyTTh68?=
 =?us-ascii?Q?s6k8ZRtazJOcxEPDoL/sHMRZfECq+fU1MPPqOfAaJFeM3PaPGAI1Mh1kfQJ5?=
 =?us-ascii?Q?vpCLUPkM/JBny/vJs8Mpul+7yYO3sJgrE2dHxRuiKm0ZXRN8T7QvBacFYixD?=
 =?us-ascii?Q?4dccSrRNMRzLV9WQ4R2JxhHiZjHJSMiKp4e4y0I25WS8VqzE49qVefXK64ES?=
 =?us-ascii?Q?X4Y73naLl0CBjRH78Q1l4VsBphHeqcn+5G7W/oudVZUjqfKpU4+XyzBJhGYO?=
 =?us-ascii?Q?w8ff+3xoByT40ajGUkehaWiXMHzOdUPL/rUlBQ7iIjwZ457538lXMwdDKOBm?=
 =?us-ascii?Q?yz3UtFcu6RLrzf7wGq+iNPENaR9rWgwigPzbqAjlTL3A9vKWa3Ddh7DjAWFj?=
 =?us-ascii?Q?pTUqEwy4PKsYyv104WYpz0nx50jXp7P+2PVjGURCgDXdHSpT1TKyi2MSb76B?=
 =?us-ascii?Q?Ki61tG/AQ/MpG7LmCYKCVXj6uqcxxRjyIUqzt1mCGfoAIdYtMyMmvTcQNeyu?=
 =?us-ascii?Q?+YcBNibzUcDe0PCh6HkyPVUrupysQqgCKfBeNbY0wbtIRqIkzy/BZerXvfHz?=
 =?us-ascii?Q?tuOFXZGGiwpP5ltgp6imssvu56nt5ZNg3SKKTl2g/j/Z9ecz1w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 21:55:36.7497
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9187aaa-9bdd-4667-2d2f-08dcfde494a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6061

Use attack vector controls to determine if rfds mitigation is required.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index ab1a8ae31588..ecf7046673b9 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -718,8 +718,14 @@ static void __init rfds_select_mitigation(void)
 	if (rfds_mitigation == RFDS_MITIGATION_OFF)
 		return;
 
-	if (rfds_mitigation == RFDS_MITIGATION_AUTO)
-		rfds_mitigation = RFDS_MITIGATION_VERW;
+	if (rfds_mitigation == RFDS_MITIGATION_AUTO) {
+		if (should_mitigate_vuln(X86_BUG_RFDS))
+			rfds_mitigation = RFDS_MITIGATION_VERW;
+		else {
+			rfds_mitigation = RFDS_MITIGATION_OFF;
+			return;
+		}
+	}
 
 	if (!(x86_arch_cap_msr & ARCH_CAP_RFDS_CLEAR))
 		rfds_mitigation = RFDS_MITIGATION_UCODE_NEEDED;
-- 
2.34.1


