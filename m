Return-Path: <linux-kernel+bounces-554694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D8DA59B58
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A01A188A951
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CB7239595;
	Mon, 10 Mar 2025 16:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qhzcPus+"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42A223956C
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 16:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624863; cv=fail; b=gXEGkk3m+S5SxS/vqwKIGDVHxoQr/4YhAOfDjrIWGLDnLUAhyopiK+hn8ns74xnlDnXQkMD8jyJxG6pb0znf2mSxUYZIzJQ2Bsfuhc2UxTw262Z1fojmMwR201BqUIT4VM9+w/hIB4hmTqObFlSuHq65zlDikFmHpQFz839W/D8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624863; c=relaxed/simple;
	bh=CpJAcmcSDLuLxdygDD+eANgttHhDglaTj8kshW8szvk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E3/OLfx7fh+VJsjeVHjxBK35fDZxSIOQa9JRKjLduY31DTv/vjxVJzGHRDxeR/N2iIcG+P3wOX+u2KmI7WCuL+ZSddB1BQNUUv7lVJIXuT9vZFKHC1+MUu85kzmxqwCs+Zs4NzolEmZTrsgklTb5DYTWO5JdKMoVf8BRdr65qrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qhzcPus+; arc=fail smtp.client-ip=40.107.220.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A8IM8i1FWYnOO91tC0MlsyDwR6Nn/mRTxZw3b7A4WRL9NXW0sMfBOrz3ISE/zcTxiRpBEqKQG6BGnN0iu5keNwGAmr+QhskUWZHMoTSPKthF4zSDCeb+lMlG8WA+idDmjGfi8Zh+ihx8Gu/ZmX551fMtSXxBKe+PoOmZtWbk3eYu1sakjPlB9l+Cm4ZjUGldf8TbrtXFsGZOk/jO28nzdO88Q52VHE5RBjxRE4jGpLCgITnrPLA+PypnbVHxe59z/bu4/EoHk+HQlMk+8VhxEhKe0jJ7/AP4nXmf9ZwLYTRR3ulK1yHqOTIs1F3Oxj0JWUTpzJvYt9gp7Zwyyg6keQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dLd6vudqNXngD79+iJXiJtcdVhs/ypYtZnm0zUKGVb0=;
 b=KuuHcVXNzLCXqjdeq0oErpSI2OMOr8N8zlfXtwI/QdWOPvcMIjsCbCUajSBx5wA2XT7GZH8lW0w1d3WjHLinB1ZgCwoxoOtGOnuwnqmfqW8GKtZuY5ThxAGcG2GtMF2n2w6IQ+1cnCUdZ36yk9PKVA4PSZucPXPaKjqJmL59R9LkGt5IBqvbZVoLa26zZMMMJUtYgM8e5XP+SX6g5veij3CC/n4BrkW86oGeJlg1TROzkUMGHPBOuRwMU26OD3f9PvmOCsOCfXiGaNAGG9rc6oK60+aJtlS66yasrs7kGC/MsN7DVK1X/IV/Idhoi4pL33kXrdkUFuwhW8SejeYiXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLd6vudqNXngD79+iJXiJtcdVhs/ypYtZnm0zUKGVb0=;
 b=qhzcPus+Ny4MoiVogzv6jCCruso1SpvDy66qfd+8g4CfhbW+Cn66soL20U6linxfCrYLaTDq3spYU4yGi5qcylbJI4H8e/+Z4SnHL6oIMQhKn07McvRjCi4YGC5g+ehqHbaQKM+G1UmGiiwHt9lvsW8ypRUq85TZnMqihL2TbAE=
Received: from BN9PR03CA0069.namprd03.prod.outlook.com (2603:10b6:408:fc::14)
 by PH7PR12MB6762.namprd12.prod.outlook.com (2603:10b6:510:1ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 16:40:58 +0000
Received: from BL6PEPF00022574.namprd02.prod.outlook.com
 (2603:10b6:408:fc:cafe::88) by BN9PR03CA0069.outlook.office365.com
 (2603:10b6:408:fc::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Mon,
 10 Mar 2025 16:40:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022574.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 16:40:57 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 11:40:54 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>, Brendan Jackman <jackmanb@google.com>,
	Derek Manwaring <derekmn@amazon.com>
Subject: [PATCH v4 20/36] x86/bugs: Determine relevant vulnerabilities based on attack vector controls.
Date: Mon, 10 Mar 2025 11:40:07 -0500
Message-ID: <20250310164023.779191-21-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022574:EE_|PH7PR12MB6762:EE_
X-MS-Office365-Filtering-Correlation-Id: 31aac815-b10b-4fb0-ac7b-08dd5ff25563
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JU6YiYDyiqOGFLTdzR468FkJnKMMNZaMKUkLfZyEJ42hyu0P5+wlRWUD0HIW?=
 =?us-ascii?Q?FScAJ7+QQg19kc77amSalJ29bdPK7MFGD9JiFZBNNM10juyPRb14bhCRDAhW?=
 =?us-ascii?Q?96uQvLwn/rIg3lhi7TKnp9Qox/Z7Pjda+lA+PjyEnPcmPAs45JfJgHPBELi/?=
 =?us-ascii?Q?tykmwnptgR513hbetAgk53Bg5k/kNlT45dwUa0y+DN3sXGIBdXRfFXziqJVE?=
 =?us-ascii?Q?jIJpHPW5UI0m8hRlsTzGWhKiap7yKIgBAEFHgtgRNt1jmcSrMFGKyt16KEFq?=
 =?us-ascii?Q?sVFyXoaZnbrDMLta4CZfspknEb4D1uHazCFNu0HyJz6BleoSV9hNBvE5zJvy?=
 =?us-ascii?Q?sZiJELCAa404kgsBXif8OEyIA6y92Ak9LxmQNrGOMxau/VfKO8WVvPFxbaAG?=
 =?us-ascii?Q?tr9AF9JOAvJ69j3SE7GA+fOFqTVv84QXGrUrv2kyJjsyfXQd5oAwbNnXo1lB?=
 =?us-ascii?Q?yI9IRczLdHzbm041h5lvHb/APErQHvIFUM7ZMbCkoN54IXfzUbgEO487fGJT?=
 =?us-ascii?Q?8n0GfjHjrKupH4lYxwc2OgDpp7tWuGgjKnRNivi4L2FM5weLqIvn/NWtFodH?=
 =?us-ascii?Q?TNS3iwnlniNLY1gLR44qLTOdY1IBfmwhS6tPtB30j1Ols/MerdVkO2OmXI+X?=
 =?us-ascii?Q?XYWi41l0kJrB7fphjm6DAlXN9LduFo+foow+R18gioeFWrXHxVBTeN6NlxD2?=
 =?us-ascii?Q?PY3oq6nm011k6NUK37zUaaqSFpTk09e/BN9mLwIBKYvvy7QNJiwy5UYNiOb6?=
 =?us-ascii?Q?OUZ3pGXrSqPdS1zldI+9TrMPRF5Ag6HAdSRIVb6gDLYGAIpZlzRydkdR8rJh?=
 =?us-ascii?Q?Nin7AijMjbzAJYiLFsCTOVVJpl2/Hor9EyFQW+UAf8vsWTDEldQDJwEUl9C2?=
 =?us-ascii?Q?03EWsIE8OQeaBb/J2izrCW1RA3py4vd0O1PSq58XGW9c0+YHZvq0t+4pYZsm?=
 =?us-ascii?Q?l0jycs4U2dqLL2clPW1geCwRTTzkOf3L1vhdgUe6hP9ZDG20r+DvSwUMkkbe?=
 =?us-ascii?Q?/eqI5Pwe5QDYkZH12/ts9yphtr4NYJLeFiMrGz1t23G7upN4q4AuiF/GabEg?=
 =?us-ascii?Q?H1u12KyoT/ph/08GBKz9hPSCUXwDBmWp7vUAKnrhwV+KNgksJCgedE0n2wb5?=
 =?us-ascii?Q?wRXao4qXv3kVjZPqgeQDOsRQsqH8ozaMupTAfpPFHnZUKCyj3xAw+8Zp28uZ?=
 =?us-ascii?Q?E9NoDH/rs+v2j6Jy595RJ1KU08sunVtkR+q7UPATyxlJxYEAC8TJGAr5+/eu?=
 =?us-ascii?Q?ZKmwtjR1O53vK6iqK+3xGSkZeZ3q944SlJfomj3cJOdUie3O/Z/1CvCBthYu?=
 =?us-ascii?Q?Pmw9KdnVHylrI1pOuMURX4yH2NYhxo6RGkFCrw3GmWzRXwVOE9A9nrJZpOPx?=
 =?us-ascii?Q?lrlj3M1IIxVECXTn6hF/1IQREL16zHrcLBvvQ7zaNW2jJ3ipo1I5Ap8ZhVnW?=
 =?us-ascii?Q?quFr8ZIyRtK02OM+eKY5RfAVuQFCl8A1UTPpiH8ZQ/salEPDKQZFrA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 16:40:57.5329
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31aac815-b10b-4fb0-ac7b-08dd5ff25563
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022574.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6762

The function should_mitigate_vuln() defines which vulnerabilities should
be mitigated based on the selected attack vector controls.  The
selections here are based on the individual characteristics of each
vulnerability.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 55 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index d48b0a941b2d..2323bfbcd694 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -300,6 +300,61 @@ static void x86_amd_ssb_disable(void)
 #undef pr_fmt
 #define pr_fmt(fmt)	"MDS: " fmt
 
+/*
+ * Returns true if vulnerability should be mitigated based on the
+ * selected attack vector controls.
+ *
+ * See Documentation/admin-guide/hw-vuln/attack_vector_controls.rst
+ */
+static bool __init should_mitigate_vuln(unsigned int bug)
+{
+	switch (bug) {
+	/*
+	 * The only runtime-selected spectre_v1 mitigations in the kernel are
+	 * related to SWAPGS protection on kernel entry.  Therefore, protection
+	 * is only required for the user->kernel attack vector.
+	 */
+	case X86_BUG_SPECTRE_V1:
+		return cpu_mitigate_attack_vector(CPU_MITIGATE_USER_KERNEL);
+
+	case X86_BUG_SPECTRE_V2:
+	case X86_BUG_RETBLEED:
+	case X86_BUG_SRSO:
+	case X86_BUG_L1TF:
+		return cpu_mitigate_attack_vector(CPU_MITIGATE_USER_KERNEL) ||
+		       cpu_mitigate_attack_vector(CPU_MITIGATE_GUEST_HOST);
+
+	case X86_BUG_SPECTRE_V2_USER:
+		return cpu_mitigate_attack_vector(CPU_MITIGATE_USER_USER) ||
+		       cpu_mitigate_attack_vector(CPU_MITIGATE_GUEST_GUEST);
+
+	/*
+	 * All the vulnerabilities below allow potentially leaking data
+	 * across address spaces.  Therefore, mitigation is required for
+	 * any of these 4 attack vectors.
+	 */
+	case X86_BUG_MDS:
+	case X86_BUG_TAA:
+	case X86_BUG_MMIO_STALE_DATA:
+	case X86_BUG_RFDS:
+	case X86_BUG_SRBDS:
+		return cpu_mitigate_attack_vector(CPU_MITIGATE_USER_KERNEL) ||
+		       cpu_mitigate_attack_vector(CPU_MITIGATE_GUEST_HOST) ||
+		       cpu_mitigate_attack_vector(CPU_MITIGATE_USER_USER) ||
+		       cpu_mitigate_attack_vector(CPU_MITIGATE_GUEST_GUEST);
+
+	case X86_BUG_GDS:
+		return cpu_mitigate_attack_vector(CPU_MITIGATE_USER_KERNEL) ||
+		       cpu_mitigate_attack_vector(CPU_MITIGATE_GUEST_HOST) ||
+		       cpu_mitigate_attack_vector(CPU_MITIGATE_USER_USER) ||
+		       cpu_mitigate_attack_vector(CPU_MITIGATE_GUEST_GUEST) ||
+		       (smt_mitigations != SMT_MITIGATIONS_OFF);
+	default:
+		WARN(1, "Unknown bug %x\n", bug);
+		return false;
+	}
+}
+
 /* Default mitigation for MDS-affected CPUs */
 static enum mds_mitigations mds_mitigation __ro_after_init =
 	IS_ENABLED(CONFIG_MITIGATION_MDS) ? MDS_MITIGATION_AUTO : MDS_MITIGATION_OFF;
-- 
2.34.1


