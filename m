Return-Path: <linux-kernel+bounces-327142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 962A4977133
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 21:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62A1E289620
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 19:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D5B1C5787;
	Thu, 12 Sep 2024 19:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Lz5a8QRS"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D4D1C3317
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 19:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726168170; cv=fail; b=JWVixz8P92sJnRulKr4UPHUP5Omamm45/DdfHyU/PCrH95uTaGjWIXg297Rp7JpltosmKlFrDND1RwGB28bYv39d3nicwB5r7TeGr3apLqFm+NrbsxBc9Q5F8nomwUJ5tijkjrT2ACOalDxxNiv8AQY4FQnOv3zHtJOYfCMjBB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726168170; c=relaxed/simple;
	bh=c5c0lNTHWSYa7e9HM+oT8JLYg3CQexapjEVCtMbCfAE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F6+wOuwEbmx7JdiWAgaLd214M/Dw1jHWIg+/HhrbBHCE310VcumlV27O/caSFqO8XVs8sx26HDeBLV1NKINot+OZaaPOpz1W88+nBH6xkyLs6/v3lPexIHERvi2TgrGOPPonfZ814a0iBzNoKEVvZNqVzUIMP7ZrIybnTuu+fPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Lz5a8QRS; arc=fail smtp.client-ip=40.107.93.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RBNrHSlooufy6w4+Y9/eA5Bdbjdax7KydVLA+24T2vAK4nCa3mLr6z7TMc5IEWGojIMRDJRxhvC6PeptrcS3gAHxu2is9+K8kbwoimzNzEf7Yej/8cgmhAro2K2QWgdRp6RSfk9TH+zd5ESWIqyKBpqw289Pzw943oQVXJ9Vyyg/pp/O0LCwXe6Fm8DgLC9IA0XwbP/k05cz1M1xDTSZw24p663uokecVpyqsX2SFnSyOhD0ahqX3mVTzR+wfk/k/EN/jcBcNkHEUuVdeUFHGct+Omt+g2T0vY0uOiFaQVZcbXi+qFRzrsgUW9i3/g2tcQRzlABGEQndX46/b2gBsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eieUojx0+v8MOsEtWa25Y5ejIu2tfx+szJ+RUkC7UJA=;
 b=mTMjKoe2C7wXmconkJsEs8sQwGa8xBxHmFe75Um0qzhQ2HMXhrxsEtFzKIXU9AuIM/w30tudkWmemIUPjnDeLMdur6JwpKNPXynde5bacmoqxF9YymvoKgyHY6Hrerv8fH9g8ZiqVYakePTuMDukB56ORF4xClKf/jEELiG0Ebg/EGJNDzQYFkHHYsIJcmDhbqacRyz8usbUrE0z+FlBBdBQGzF8931Ll2Y0uSnJsDXKK1IHOAQzWF5uOn+RD6UVqsigQDIDNc/+FBWMVTFgzs9euunnZPiDlv8n+D+wErinmaPF6JEkXtsGltiLAjXtjsIqdI2CxzFsc9dq6YyQvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eieUojx0+v8MOsEtWa25Y5ejIu2tfx+szJ+RUkC7UJA=;
 b=Lz5a8QRSH+sXImYKZcntDJHfZVCms63Vj0b/aCYAPZHYu8q4hyJzs+dTOMpHFiDhnJE18buTjVfG6WbtOqnQk0d1DkQ+R0HnvyXbcjzzMN9xWA9RncpGo2kR4mex/ekUBAppH1gmKPTJyjnqXzhjrTFRVzK3HeTq3EMUHwkaz4U=
Received: from BY3PR10CA0029.namprd10.prod.outlook.com (2603:10b6:a03:255::34)
 by SJ2PR12MB8926.namprd12.prod.outlook.com (2603:10b6:a03:53b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.19; Thu, 12 Sep
 2024 19:09:23 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:255:cafe::d2) by BY3PR10CA0029.outlook.office365.com
 (2603:10b6:a03:255::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Thu, 12 Sep 2024 19:09:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 12 Sep 2024 19:09:23 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Sep
 2024 14:09:20 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 25/34] x86/bugs: Add attack vector controls for srbds
Date: Thu, 12 Sep 2024 14:08:48 -0500
Message-ID: <20240912190857.235849-26-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|SJ2PR12MB8926:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ddb0345-65de-4181-1a69-08dcd35e69e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hdR6F95Dd1J55lDeOY+3QYerBI4SdHayLLv9MRaXrTkteYmDtFS1gE2we+/+?=
 =?us-ascii?Q?ORudYRxA1/OoGYGj83QzdI63pYge1bv6wLwCJPz1c0XBD78lKrikHvShNUIZ?=
 =?us-ascii?Q?xJhtrq9ZOPABmInZdT1BjdfczwOdqhfC6TL//YKpDH5qYqRzYzXKs3WGJ4qO?=
 =?us-ascii?Q?MmNAwm5pGuRpd6Bmi6DOkP96mQ40QqEUhkpc5iiUdYqEYlgjPLpVfINxdrcA?=
 =?us-ascii?Q?akZ09ILqGw9m5xpOue00+9EGLbs8oAUNHXDNw3W3EPcKqBdRQafjCv/CIh/F?=
 =?us-ascii?Q?TEs5t/Mql1VX0p1FVbbwuufcMS3p9O81ymYSmX3Zv2piq51N/RWcNgJbo+Sd?=
 =?us-ascii?Q?AGEdyEVg9G+daToxNJLZJEnNQBZL/UxeThQQL2YfaqRo23IT+QHvW4gn3A8z?=
 =?us-ascii?Q?A0Mp1h1cunHhlwY+sqjtRqyaGgliSCsqF2f+1ffJfFGRfJBB8jTejRocLN/g?=
 =?us-ascii?Q?W2kEXnrrOLgMdnaYA8bqJb4rNUIOqZXgJogsbZmg679S09JOqNHiiQSoIdAV?=
 =?us-ascii?Q?u2CHr2J4a7eYZG1fC0tDP19FTbK7ZafV6ncJvK+bM8q0Syu2Arsf83G0FVjL?=
 =?us-ascii?Q?fNQpbf53XK0uV3rvSnWRXRKejYmnFxW0mwOOtQZBCkNfXOB2+/hjyuMoQUWs?=
 =?us-ascii?Q?fv9kyIbx2raLd9yEnvzilyi3RHmaHmuMlqn6nri7Z9ebLPoAR7RKk65esyDO?=
 =?us-ascii?Q?ZRz6S+biCdU0E4E5nAKCZ/D9lhPBvUDtepd0gLP2U71B81EKZaeJMnAwWg6e?=
 =?us-ascii?Q?Eh+49SomNky35kDuCGJ7bSZKwq8qWpKcaN47uNJCX2CiGD2Apa+DQc0Mki5x?=
 =?us-ascii?Q?9O3GnuEUoWC5ixAhhVdaK1AGxkc2I/ADED3B6r3XAjykwMvQqqR4ti+uk6d/?=
 =?us-ascii?Q?07Z1iVHGfZtdf+K62JSeOQeM4b5mWzfdfPK304jZ9dWwF4ZCUKK+MjsfvunM?=
 =?us-ascii?Q?SrkjjYi2bIvJYkBPfBiamaqTUhIdPzPEi0OGeUcL3fCKFLE9whzmgeLNYfuu?=
 =?us-ascii?Q?gv1UEABpceOTDmXdp72grzhmOG6z20e8+Q3hew0uPAbFq0R3iwatC/4qp3K6?=
 =?us-ascii?Q?+0K/GpzTMY4esB8mTOt3tw//mlfBmjgaAm/aiZ4MfuHzdWERvXEfg1bYBgdo?=
 =?us-ascii?Q?pNAyqwSgwQr2NgLFyc85eAntChSIgJ89bI6wdnPOl9uZC1wtNkCAgog+cnMO?=
 =?us-ascii?Q?dfN4nWNyPP3Sy4NftoAhgjtafGxOHAMLpmHEvRy7yRDg7s7ZLRIeE2UDmJdD?=
 =?us-ascii?Q?k6rTsXCDFqxwJX7e23SFj3eLAE4uFamaX2EnDVs4/dBTQk1P9ntXuNmjxWhp?=
 =?us-ascii?Q?NxGi68VTBzS6DzIYFnVQXym4kUo1Qw39nMD+6oflGDQvKidbybfMCp/rq9T9?=
 =?us-ascii?Q?iRHDSiS0wKCWFVhEtRPSf3u8nNNJRW0fa2PzdxvwMjn/W6vt2HYAu4plZOg9?=
 =?us-ascii?Q?E16d6Ycg/UOal+wbi4mfAQhvNGD8DnW7?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 19:09:23.4835
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ddb0345-65de-4181-1a69-08dcd35e69e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8926

Use attack vector controls to determine if srbds mitigation is required.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 75ac56cd0e21..d86755218c72 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -840,8 +840,14 @@ static void __init srbds_select_mitigation(void)
 	if (!boot_cpu_has_bug(X86_BUG_SRBDS))
 		return;
 
-	if (srbds_mitigation == SRBDS_MITIGATION_AUTO)
-		srbds_mitigation = SRBDS_MITIGATION_FULL;
+	if (srbds_mitigation == SRBDS_MITIGATION_AUTO) {
+		if (should_mitigate_vuln(SRBDS))
+			srbds_mitigation = SRBDS_MITIGATION_FULL;
+		else {
+			srbds_mitigation = SRBDS_MITIGATION_OFF;
+			return;
+		}
+	}
 
 	/*
 	 * Check to see if this is one of the MDS_NO systems supporting TSX that
-- 
2.34.1


