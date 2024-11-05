Return-Path: <linux-kernel+bounces-397217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E909BD7F7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 23:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2226B22D82
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 22:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1060217F20;
	Tue,  5 Nov 2024 21:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CZLekxS4"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A23217F36
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 21:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730843745; cv=fail; b=h/Sf/TLOUwaRhIeb7CwGdLlw7Sf0iUVDL2VZHx04GQ3wycK7itwWx4BYr5YJ1sF7Pv1Y9W2BdUJo+Z/9trdAsx5TIQbUpfCrpg/lrZqw9tAAAxwHcc1UJWjEbIkNQm8LunhS8F/pup/6rFaHjgV2gP2QoChSIdbd2sXK3lnXZIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730843745; c=relaxed/simple;
	bh=aHic+0ebocb5nKMBe4no0Z5auBYt1+Nq0iPWYARR5uM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u9p1zmnmlbBFofGQcR6DEminD3wOG4zFqNQR1gyO5mdjjwfb+pXGWdOzZdBP+N/5vs4XqeXyGN8iPUCGtihNxucZTjy+Yi4JYqFAX1SOqgta45xrmZPaabBaHuMJMxKHZg9LmJN9ULa2/GB0h+SEZftG5FoIPR3PgJLS0yjrNvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CZLekxS4; arc=fail smtp.client-ip=40.107.244.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GMm4l+rzzaf68AwFuiwGYcsW/No4/D0QifgeiGFjrl7h7zRcu05stZzlDF0dDG+I/YHtyHli6S8Mx8tMbuAdsJKK8sSqi2QSOU7O1SVPE7DD7LDRXiA8zNc1qyyUrCE1DPgnlWeeMnL3gTqBzfmXkZCm+TMx4Lsk/k8Wwc5alg9b//o9eyPNRaY7GbBkL5bT5mHbw1CzI+SLPCXSJsaBhZqs+TLWM2p/2snAtlPJRLw+SD2ygcGOjhF8nzjhr8gsOMb8ah5ENPYhNYofD8BpqZBIf9ovhXAIf5s6qDAdiqZlXdgU7Vuv4pbDHa0YWqg4PeVr8dTq3XgxLrJVLmWZnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YHXsNRr5+gH1jWNSTXgEA2iLm5V0QNIWoKsASQihu/E=;
 b=VXPiD1xmv3UM7fKryRj7nfuUewjkZQF/4WWdY7KMnlf6bye7jYAKeBD0wtlWsm8pbV+jFxRv6EayJmg7FYCWx2s2crzOrqy7dpI4QjFxqM95SjIXZJR7kckaUJduLevE4EwHqayAQHrzHOW6TqYKmTVSjk712mKmkxaiMwU2T38SpY2OhAKUrNDulV6Y5w1DpC8zjNNWx9v4h4vpO5STCrekw9+NLI/v/sRD4i36gGjdB34MWNzzO/Z6ohkfA96vA5AMvCoCFyVe8fLOSiIJBbdfY35eS/vCB++SEDg8RYhQORG38NUtoUuMuB/TIhtO1tAPRJeBOCE8hvwkRAozMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHXsNRr5+gH1jWNSTXgEA2iLm5V0QNIWoKsASQihu/E=;
 b=CZLekxS4ndzRA3pgeblEmIc/60AzVO1DqmlBguldIaK8TwdZ0QYBp9n888xeKCBNx+h7Q4M1ARG2Y5Rc9XbXCzZ/tVarcgY1bxY5zlFqAH9FGnPdh/ElUZLBwmffuhHA2Pgggmnpe8EIAyMl+aS7QHafgO1VmiNbYf4xFHxvgFA=
Received: from BL1PR13CA0385.namprd13.prod.outlook.com (2603:10b6:208:2c0::30)
 by SA1PR12MB7341.namprd12.prod.outlook.com (2603:10b6:806:2ba::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Tue, 5 Nov
 2024 21:55:40 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:208:2c0:cafe::94) by BL1PR13CA0385.outlook.office365.com
 (2603:10b6:208:2c0::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18 via Frontend
 Transport; Tue, 5 Nov 2024 21:55:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.0 via Frontend Transport; Tue, 5 Nov 2024 21:55:39 +0000
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
Subject: [PATCH v2 28/35] x86/bugs: Add attack vector controls for spectre_v1
Date: Tue, 5 Nov 2024 15:54:48 -0600
Message-ID: <20241105215455.359471-29-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|SA1PR12MB7341:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eefd04e-2b3d-4ead-213c-08dcfde4969b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sVYPGt6WGp6T5Rm2jyXbuNCG6sHjDgsCNlzaytts92a7UzOioZAE4Bn7aI8k?=
 =?us-ascii?Q?xADUeFa+2Kx7B7j+FvkuIQfFGiVU8wKQSirXdKitSBr8YDDPELa8Qv/KbyaN?=
 =?us-ascii?Q?mlSy5askmQ7sAh5cOxr58UceImNs6CElSHeQw4vgQWp++GlVTHSMd1de9efx?=
 =?us-ascii?Q?xxJAM7S91oa07aEyU+rEjAUjUDN5ZuBTof9BbaqHQbEn/kXyfoH56tyPYk3D?=
 =?us-ascii?Q?c5y5+bzrsh70ZYhndY8nckixaA2QQl7gqw6BKlGGiqIzyrMX7i7mEDMGdQjW?=
 =?us-ascii?Q?EcO4c157ev1O5m+KycY+7dF7NdI+fCal6TJr6dPcWAFoCvIXghycgshDTGLs?=
 =?us-ascii?Q?VS1e/1MeB7/juZ8uAVaMN+EcHn9yR0IH0Mv9C+vFLEAAUohcPkYRWyWRr8WP?=
 =?us-ascii?Q?2K459ldPiTLopHgkZ4oJNXXYO0PDuU6UK/NBOhTqJmrTsg1l4T3K0ozmsMMF?=
 =?us-ascii?Q?yRJgLphc0FvD9hfVxfIxmATrN7P2W84MwiLH4yZfqNifEoDlE5+UCa7IGoeQ?=
 =?us-ascii?Q?+zbnOJ3wl7D7JfbC4jjfEO29VUJIJwuS8OvxQdGqHbOrgiks/5oyFC7W9uLk?=
 =?us-ascii?Q?JyK8Qo0Xf8zti4QUVjHhQIKNIXHHa9T+aMSUyT11Ec6naSf/xily2A9utLbA?=
 =?us-ascii?Q?TI557SoJoIh/osghmXX6WBw8pRjucshT90ttrcaADpPL49ZiNIUBzeLr431e?=
 =?us-ascii?Q?SUO9ytiw/GbtaD27WmIG12SBXi0eLDYzm8NxEowuOnIO7ceeGFdKA2jJnNM1?=
 =?us-ascii?Q?LZ7jxVYrReJZcZipAK30ymcbsMw3gYrCqLNg1zp5dpQpOjlyp6fbY8W//efV?=
 =?us-ascii?Q?e/xO6ALlvO99pXjHgdPmwbTDb4efXABQOOcudWAB+EIBp8ribuzP+ZLpO7Mo?=
 =?us-ascii?Q?GrfMzYzKyxecIRyxzeN1KLB6KfcE5T+Hiw/o9o3NhbKOZhjAdDvUfdgSPOH8?=
 =?us-ascii?Q?p1yBSPyj321sqHefeNUewDAQgtV7D0nSsjVygMDEvn/36OYSU3g+U7kWsUPi?=
 =?us-ascii?Q?fCR318y2nJKhSfp8MQDX1u9NZ5aN+ivTQ5jGy3oTnhQ9ZTHSIpVlXsLcBv+9?=
 =?us-ascii?Q?sZuBykWWGGR+BuCiYj0iCh3vz7AlBIzusQwXHQ2TZilJhH0e0wKhmeaRa/70?=
 =?us-ascii?Q?UpTAZptwxzp76IjXOBG99CWCb3v67Ks84N5rs2BYwIlal8GAAGZFbtmu0DLF?=
 =?us-ascii?Q?WC42Lej3FPBotGOvaKLrq2j25987antJhW2FOHtQFSJr+uii9GSVYxlvZ7Pa?=
 =?us-ascii?Q?cbgAt78wx/2YubYfphadXmcN2ouqSNNTuNkFNiJVJzUoIYUyxSkznx6VEoHL?=
 =?us-ascii?Q?0op2w7xtbrYwK/uyzl5ITbmC1G3ofZhjHOqdeB8Z0mzPuktNycJoJKdzYE7o?=
 =?us-ascii?Q?/yv1xv7KXoyWbjeG6Ep2VjyhbJLGHUjXGzeabftPYfBmUZUcMg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 21:55:39.9793
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eefd04e-2b3d-4ead-213c-08dcfde4969b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7341

Use attack vector controls to determine if spectre_v1 mitigation is
required.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 8612be5445ba..f63fa8a3b9ee 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1108,6 +1108,9 @@ static void __init spectre_v1_select_mitigation(void)
 {
 	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V1) || cpu_mitigations_off())
 		spectre_v1_mitigation = SPECTRE_V1_MITIGATION_NONE;
+
+	if (!should_mitigate_vuln(X86_BUG_SPECTRE_V1))
+		spectre_v1_mitigation = SPECTRE_V1_MITIGATION_NONE;
 }
 
 static void __init spectre_v1_apply_mitigation(void)
-- 
2.34.1


