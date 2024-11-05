Return-Path: <linux-kernel+bounces-397218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 102569BD7F8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 23:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C38722817F5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 22:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95341218950;
	Tue,  5 Nov 2024 21:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2Bj/LYuy"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316A7218306
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 21:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730843746; cv=fail; b=OSNyMB2F5H8PRMy/rLxoqsZbjNzZ60QVFXAWUYMWa2xVPI2ZXqvNbhcqGBOiPsPWK3Jxpe0ADnZ2R6BU3L7/6OJd+TAW4L6emGzkFFNAgBM76Tn+2BMRksPBrsWcno44W+LXLNSkMWRQzi4wjj6CdjcaUdpuIU1NQVg8gGAjkhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730843746; c=relaxed/simple;
	bh=clemMNI2k0o/ANXvZwlyyJZ97s/G/TJv7plry+0lka8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gwla6++974JBN5afrCtm01WZgYS/x4XLKr9J/tTWwKJEa1YK8i6mStGyWR3ykIVbejUbdaxiYlyGlelcfZtD8qT3wbztrWhGrqYqRmGpzYMdn4TdTHX/VX05PuEKkmnNKZxFVEfhl0dbiHL33kcZObIp8aYRsaXKE+HAuUqy7q0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2Bj/LYuy; arc=fail smtp.client-ip=40.107.220.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f0WJAhv3006jvuPf0mKpWNzbOA0crmlYp9qgwshtKxhH5v5XvByyOCDZv3eu04Dd8JhB3CY8iCSqB/5VAV9kVmxay5KznHZQu1r2aehvvJlpU788SQdNiqgCKgRHt8yUmsMQB7cFSHN8jJwMQkR3A14/m20/909JPG1k5sLhmgWbMW28UhOSprhptmxJZVMB6oQDjkycJ9JE7CBfuoJhY4VpJgHJjWbY8GMA9sSLRGRb6HdxjnrWz3U2KkwdqUP/GJyzdiTgXLjMjXnrW57uXnIF7kkctAVJA02Ug0tJn5fE11URVb+EK/9KhWy9JXH20SzX/vxC60ioSMrq+wvaFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vaBw6OqtTZeBk4h41ABfBRYCK2Y3iPYND1kM9WLFCeg=;
 b=ssK7hUsDtLtxWOE1KkO3dWscw//x6NlhOEwz4nVFsA3ek/qqVbHzwOFEGgpfCIZbFnw4lk9lNQ3JbQhpyxeCGqiK8SOS9XcGYCXqKoNGt6eg40ArI75ConW0RA/NWDnhjGKRnpc6hylrKCYqWjyF9WIfr9h7EzoTkuXsGe6xVu9VmWWgl2ZgsWe2C0WkVrc0urFEu+w7mq8sYZL06WIDRFF1HWx8SPafo6qsTr3MgMVzEdmniroaWRyqMIj2Hx6RJCORPiBrPIZ+aph9tfFGQQTvV2E1cqxjD2LsWX+k2U40qNepogZ5tToCvz0qxRkGUM+3wNtspUQ3xAWNcKg3RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vaBw6OqtTZeBk4h41ABfBRYCK2Y3iPYND1kM9WLFCeg=;
 b=2Bj/LYuy7yHglgc7OZ7JE7PE6o2iPAJoN3FOoUM4QPP3qe13SXfwmA5y1TBTgG/ps5U2OI7upadRhpO7KPm0MuPXLHWZm7ZmnH2bL2ORo4dtfpNnb8DUJDedUJPteA1Sug81sDkbSRdH/Va6v2RM3joR9jtVOKY4Fao6cP+NLYk=
Received: from BL1PR13CA0387.namprd13.prod.outlook.com (2603:10b6:208:2c0::32)
 by DS7PR12MB5885.namprd12.prod.outlook.com (2603:10b6:8:78::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29; Tue, 5 Nov
 2024 21:55:41 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:208:2c0:cafe::bc) by BL1PR13CA0387.outlook.office365.com
 (2603:10b6:208:2c0::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.14 via Frontend
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
 15.20.8158.0 via Frontend Transport; Tue, 5 Nov 2024 21:55:40 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 15:55:36 -0600
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 30/35] x86/bugs: Add attack vector controls for spectre_v2_user
Date: Tue, 5 Nov 2024 15:54:50 -0600
Message-ID: <20241105215455.359471-31-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|DS7PR12MB5885:EE_
X-MS-Office365-Filtering-Correlation-Id: 93d1ba1f-1585-47d6-7e18-08dcfde49719
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g7pHRRZFFTGNNztMLMQbbTIFoQdfi0q2lCdbWd9rtjenYRFFKTBwCnqwO5KH?=
 =?us-ascii?Q?cV3Ce+1WNV4k9yFbrXF1ppg/2vjAxStl43FD1v15MgwUL2+l9huUeV1GuOdD?=
 =?us-ascii?Q?DqNnINgDKZyOZHvYN2LyXdW3FC9uJJGiwt9O95ty8H1WIc3GHbbOfGjhZ8FT?=
 =?us-ascii?Q?WdQHUm5BBDc909iGMrQh/tLx6tbo7o3q/nnVEQEixYsc4lXnlw6Yy0TaYu2Y?=
 =?us-ascii?Q?fI56nWNZs2WNQKQyGOdm68v+JsF1sdXzHxK0HQ8qS4gn0cxxo+CxHnaCyhl3?=
 =?us-ascii?Q?xTtqzFSMeYAw7IeebaZM15pVnMQYtW2aJtTbYjkQkwmUOSxNKylz4hky7MsU?=
 =?us-ascii?Q?y/GGvrHdLSIQGTFMaEbJzZBJFrXvsNM2HQj5YgAvBa0kmaZIUs9hz2tZILt7?=
 =?us-ascii?Q?leJmURdKkh7Bv0QsInnC1QW/miT5xlQKNAGRwwbaa0OSVUge1dD+SdnYVZQD?=
 =?us-ascii?Q?uZKch7YyjKReClIev1fznT3NCsLp8kIedo5KIjRGVU5Z3/Dqfpbqbx1aPhZM?=
 =?us-ascii?Q?pH6QCefEqRm8GWxsRaoSmq5wlCxedmD/eclDeoTDCFn3x54k0sz74M1WOQns?=
 =?us-ascii?Q?1Cx2VCP4DlZCp7873piKJXP8e+qo8Kc2G4n3GQz8PhgnKXurXZVdfmQ1lev4?=
 =?us-ascii?Q?KRaXFS3FZBvEK/pkIXtKdvtGTonJZIC8h4uNJK95AdOWX1lhvSRkrRBsiycv?=
 =?us-ascii?Q?ni3EszH/vY/LybXOfWO9nfmJCtlK0qZ6irM34HQxMHGuSTea/Qsgj7OB0JA/?=
 =?us-ascii?Q?IDEv9PCU0I3UOWVZRH//3xZRZDgDmRWhuy9jzP2iXjVwxDw2+J+8pJZ+4Nws?=
 =?us-ascii?Q?GCtpERGyFvP72GcMI8kTeyWH83czFJVriV9rsQV4Q9Hxe/3ZoY63kXtbFNjb?=
 =?us-ascii?Q?sccs7kRVVw2ShpyB7N33Sx7HqIlLh8Ww/soUUlFt9nEG7uZthyqFf5VMkA5/?=
 =?us-ascii?Q?tnjANbCBJxyeIvMFngskatVW2dNRfXha06hgzrztDSQVlXxXEfLnCw3Xk2Zd?=
 =?us-ascii?Q?mHopfwySiQLi7kfGFP29T8+PJ2tY8n4kBzHRgQZjRWW7ZY+zaWokf55JVADI?=
 =?us-ascii?Q?2zbM8Arl4lyc6nWPXaymGqYxHkEwvXwqnE9s9LdFbP/Nplb6ZezTM86FtTR0?=
 =?us-ascii?Q?9szjsghhAlN8pCNC5ZBxBi8QRqFJFQ0Nfq7JZcY5KCpy+piYa20xjQTPUShR?=
 =?us-ascii?Q?nC2iN9IxBqUoGK8cC+gHyq37Z7TCQOgfV49j+8KntuRDd0bw+uPmY21jykDp?=
 =?us-ascii?Q?BQT4PgE+vqFm59XPnw1V3Id7A5h6eqncSOi4TeE+5+RkjhLoj5u0mEucQ65h?=
 =?us-ascii?Q?7Zxz4+Jdk3DiboGvkyRSLWGqVfpgk0lKRb6KzCU5RC5QsCQ5qMa3hZko7WvY?=
 =?us-ascii?Q?D+6zq2mAcfS6/n9kWjG2htvN/13on7N9vqd3Uw7fL1a4SFKJYw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 21:55:40.8387
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93d1ba1f-1585-47d6-7e18-08dcfde49719
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5885

Use attack vector controls to determine if spectre_v2_user mitigation is
required.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 545151114947..6479c800e973 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1548,6 +1548,13 @@ spectre_v2_user_select_mitigation(void)
 		spectre_v2_user_stibp = SPECTRE_V2_USER_STRICT;
 		break;
 	case SPECTRE_V2_USER_CMD_AUTO:
+		if (should_mitigate_vuln(X86_BUG_SPECTRE_V2_USER)) {
+			spectre_v2_user_ibpb = SPECTRE_V2_USER_PRCTL;
+			spectre_v2_user_stibp = SPECTRE_V2_USER_PRCTL;
+		} else {
+			return;
+		}
+		break;
 	case SPECTRE_V2_USER_CMD_PRCTL:
 		spectre_v2_user_ibpb = SPECTRE_V2_USER_PRCTL;
 		spectre_v2_user_stibp = SPECTRE_V2_USER_PRCTL;
-- 
2.34.1


