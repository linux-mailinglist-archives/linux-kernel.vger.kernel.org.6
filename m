Return-Path: <linux-kernel+bounces-327125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 864D997711E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 21:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A8E0281FF5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 19:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599671C2308;
	Thu, 12 Sep 2024 19:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="d1Jo48lF"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2069.outbound.protection.outlook.com [40.107.102.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A574E1C1759
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 19:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726168162; cv=fail; b=eh2Oa3RhkPitYbu3uwwVqrXksdic5dUmL/YQg36RoW7mltBjFiP/tH6efhmiNGqpVrLqqbcF22PDbkfG3zWVCWLXrqa344VqU3pcMg0Vgqc0QSwXN0VIHwAAcV7BhAsCIUSrbjDL+S+yLyMkIf5QFyyUyk6DOpJ0BJuDTCZs7TI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726168162; c=relaxed/simple;
	bh=3qHcXfU4O6GtAXPFgTU1OGaEgEpMWSszIo4q4PkAWSo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fqr02pkjnHCEVu7lehycs1ULrT2plCz+n5hx3zyqvhT5pkDtyk46o9Q8eg2XL6ThAjzJbkMWpFCkB/yU/48R0NU/SEwa+izIxHxF/nLE+6E5Pu480pxp+j5Ik5g7oxDoFrQSUda8ZvJOCV1L5KNrUX458CW91HFK/0wXuG3ukJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=d1Jo48lF; arc=fail smtp.client-ip=40.107.102.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mnk+Fy3lcgfdBiBPbOv8VUwh8SXAATpoXdmw1XNxaNHwn6L8RnVjkgxEiGN8CwrsaNeZZexLdX1QVlDXYxnVjmavToEvj67yVfTEeJGGUfmmo4hNUjWQblBeSaB5C02XFWa3pE1GWBheJ2S9w+Ko9Uc8NCmslmUiB5tGQN/AmywVohrXMAvYxGM/n98THKl66VeXig7wCW82+tf8f+p0k+6whP7Tn+T5MRKYu2BxlnJBqXx1QGNPK/KukHJaacFc8JV/A18qprMEkD2rStLF2HnS5Yo3ka6EIpoouNBpLDEcy4lWwv+1UJLaFoGsSJbKDWT/w+U93My0i8ehD5JP5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cRbM6IL1ERmi4vT/TUklUu/jRAbmdfTUKA/9W0C/UMo=;
 b=B6el9EFIxmcyLAS8jCXJ7kaHY9TWW+lJ766AMu3o6PwzjGiMMq7P9zxojooeixmmcfOABOClYb/gzSe0DxYG4FmM+9WaYub1HM1FCyit66ABL+GINMQIoQArvUN+QIddXVkA5+rwAIjoJL0DXv2DQ5FXaVSN+FpNJ6g7a7FLeIbHy+qESCrW9LopNJ58r8mcGpezEnRAO/2o1bXMebpIj4KgwzuP+Qy8md51ucmafNNEWcuWj9oBPYwyPZkfDbleJ8YMePF+t46y5KPlsdpZD55iWIMh+UGmWMk9Bmb9t5tcRrIwSBRs87G4UzA5XNy5opDUuar64gh4QZ2JhpL/jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cRbM6IL1ERmi4vT/TUklUu/jRAbmdfTUKA/9W0C/UMo=;
 b=d1Jo48lF+ryMfBAf2kgIu3lnZrbzvwjJ9K2JJpbYamlvDIEucDTNNApZNLNQH/0mphllNzoA4D3VR63QkI5l3s42j/oLzazI8yAcPBOV+t5DVCSMehfA2DwW6SZzlsU8VoReX4LP5o0n9AyZys0Y7V6ymjumBncTviOpm9Bpgp8=
Received: from BY3PR10CA0030.namprd10.prod.outlook.com (2603:10b6:a03:255::35)
 by DM4PR12MB5868.namprd12.prod.outlook.com (2603:10b6:8:67::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Thu, 12 Sep
 2024 19:09:18 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:255:cafe::d0) by BY3PR10CA0030.outlook.office365.com
 (2603:10b6:a03:255::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25 via Frontend
 Transport; Thu, 12 Sep 2024 19:09:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 12 Sep 2024 19:09:17 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Sep
 2024 14:09:13 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 10/34] x86/bugs: Restructure spectre_v1 mitigation
Date: Thu, 12 Sep 2024 14:08:33 -0500
Message-ID: <20240912190857.235849-11-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|DM4PR12MB5868:EE_
X-MS-Office365-Filtering-Correlation-Id: fbdaa7e2-8d63-4cba-2ce9-08dcd35e666d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HqqO0NI+JKzDG9aA7Y53iDTyJyvVqMHjudSwa1ntwQi/EIKwXHGyojM7BCdy?=
 =?us-ascii?Q?1zUslIJt1F1FTOY7e9JjD5xESg/kfgWXFI+YJGWoMvO41Zv4jIg6NttBZC4d?=
 =?us-ascii?Q?AFbpwnf1P5pRMYmJEbpz3uy31E0uZeZb1b66Ok8GBhQL0LloE36DLIQPmpYW?=
 =?us-ascii?Q?T+GU96KP2HVUOpyeosYd0B6Bt4UyM2qcTOtEDUZMG8bPcIbT4U7CWo65MR3Z?=
 =?us-ascii?Q?eRADb+f7UsM1Uz6UnTm7hrC5CPjyUWNoaJ7oStbClOMjepy1UhMFK4WLDBFT?=
 =?us-ascii?Q?3RDBeCkCR4dUiuKxB5wD7j/IcCdi3Xa5HstzqHx9T4Qrh7/nIhz2OeWVQr4Z?=
 =?us-ascii?Q?2dHcbgLxayIU+uH7O0abNGSb+0ORN2xlEHeGUr8xxN6AhqacZ/0NltqHhM9H?=
 =?us-ascii?Q?0i6MXqYwyJXwR791GfK5VBrruwGv4hUJlUf1kz5GnJrvi9lFh8O3rXRXkdI2?=
 =?us-ascii?Q?FendnZ0mXpcGpCHHfyjbxJxlqQMiKGy3qvtnh0XpO6do07HNo1VJEdsFqGwz?=
 =?us-ascii?Q?bGTO5tiSCgXHyfqxk9tepPmxWYHdSA2zWMto/BDHQGyjZgNGP2q/7nWyZKeR?=
 =?us-ascii?Q?LA52eudfKJl0aUOujPSAU4C2BPFOuyOA+hPZgroaavmiqyHB/3hZitYCId2M?=
 =?us-ascii?Q?+5vRrYRRejdIvR/iPgShO4CA/KnVB93SYbEjPVzCdQwGesib7H31i7rvBFbl?=
 =?us-ascii?Q?g4BDRdqSxUgiNJfptgtrHntpGMUbzOO/ryvaiGgklJk75dtdizAzl+uWJWVO?=
 =?us-ascii?Q?oV/l866guKPvb9ErCnBxgKjFf+p9IiuSDeqGxiB2QaBV4b2s6yRrPDXULjAY?=
 =?us-ascii?Q?yCVf9lHOdIrvdbYesjYZ1RYJRwoUtnIWNPHh/K4gzznRuxUPijFmngeFpaZN?=
 =?us-ascii?Q?FpDOrcsT12BbyUbYEp/mxaINxOGvKijoRdNsFrdFWvs9a/ExdSgmdPliNumn?=
 =?us-ascii?Q?4MWHyEA47D+s5jEjWrMjwyh2/Hh6jsKm4Li1GZyWvaLEaA848HGuwSixsgcO?=
 =?us-ascii?Q?qJ0o7+GgUbiCk2RNVdvxIZcORotm17HR1Ia7dTtiRRsDLXycWcqDtAmEDLhj?=
 =?us-ascii?Q?IcmJKUcKYYtsDHP6j4L72aP3BSi/A3mpuzv5UQ/actXn/Z4zE0o771aNrJ1e?=
 =?us-ascii?Q?2h0MGGTTOC2rFhre7SAcj54Ts7+GZg+EmEfVdtfVgNqY3i22gjWN6PMX14O/?=
 =?us-ascii?Q?gxBwFqJkKOV0qCtdz/TX/OGD0hovJXcuhelvG58Kdg4V2YAKINLSVdmf1v3Z?=
 =?us-ascii?Q?+5Kumb+Gx/7jsiya3Z5sw6+jpGr6mfZtlxS0KqPLUDKiBAkiXboLahnxTPAj?=
 =?us-ascii?Q?3aihlX6EdwvCMnXHPFgJ7WM90mMahir5xBW7PPRLNW3vw3vg2LZni8oECBFV?=
 =?us-ascii?Q?SHdb6o65OciVcHGQmAp04uvIM0tFhFBDb9Y0hei+hQLXK4ebTsxKVL5ZZPme?=
 =?us-ascii?Q?ljJH1+2FQKzDQ4eMlJrPi9UnBI30KI8l?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 19:09:17.7022
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbdaa7e2-8d63-4cba-2ce9-08dcd35e666d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5868

Restructure spectre_v1 to use select/apply functions to create
consistent vulnerability handling.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 7fee5c3de135..ab49205ebb15 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -54,6 +54,7 @@
  */
 
 static void __init spectre_v1_select_mitigation(void);
+static void __init spectre_v1_apply_mitigation(void);
 static void __init spectre_v2_select_mitigation(void);
 static void __init retbleed_select_mitigation(void);
 static void __init spectre_v2_user_select_mitigation(void);
@@ -216,6 +217,7 @@ void __init cpu_select_mitigations(void)
 	mmio_update_mitigation();
 	rfds_update_mitigation();
 
+	spectre_v1_apply_mitigation();
 	mds_apply_mitigation();
 	taa_apply_mitigation();
 	mmio_apply_mitigation();
@@ -989,11 +991,12 @@ static bool smap_works_speculatively(void)
 
 static void __init spectre_v1_select_mitigation(void)
 {
-	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V1) || cpu_mitigations_off()) {
+	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V1) || cpu_mitigations_off())
 		spectre_v1_mitigation = SPECTRE_V1_MITIGATION_NONE;
-		return;
-	}
+}
 
+static void __init spectre_v1_apply_mitigation(void)
+{
 	if (spectre_v1_mitigation == SPECTRE_V1_MITIGATION_AUTO) {
 		/*
 		 * With Spectre v1, a user can speculatively control either
-- 
2.34.1


