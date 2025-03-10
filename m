Return-Path: <linux-kernel+bounces-554707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D1CA59B65
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1D491886585
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230A223371E;
	Mon, 10 Mar 2025 16:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iW64zXEI"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E71723F382
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 16:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624876; cv=fail; b=qdSKUNK7eQX5iInfAqjt4bZV8le7Vgbv+G7jAv7YBWAjmd1Ii0O0/0NDOU05ihDdUopKlyNtCSDtqBCM3V3VFFsTxL6p6iwrxxDDtiCCHh+mJojYwd6Yy8fqMOifr00LMBG4oD40sZRRDAkK+ndo5GI8Aw2E4ADmTCoC+w/8qTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624876; c=relaxed/simple;
	bh=VYm/31KGRzWEFMFMXBB59H+INP86Zaugot//cPwsUjc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z2+lysjt0szAm3RHIFlXw6q+Non7PBgp1yyokNoKqTfCcHNTplTuf7W0qLg254ZMH66NrZnpaaLhH6C+SA3iWbpYEHrLW5i1cCkkVyvJi/a3qIzk21ycEG6vks2fn34Hoc5H1lU/cr4ZEGmbPPgxEOCL24RryUV61vD1LAgGhOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iW64zXEI; arc=fail smtp.client-ip=40.107.220.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WXxLv9xkDPdaTL7CSYJmV7Bz3uPAmQfqqDCuj3J94SicTMnJfSDETyEOzhijkQuqJiUzwmFBvacbZLfIBnvKYZiMPLHlq/G3wd/AmWF5gWXc08T92di1P/kiWKhfqsjcumjotVvyCOuVqnzhdAZVt/vruFlSHmZA0Mv79piQlpHRV/65x25BMpytUCSbBA8hTZ/bBpX6/u52Le0N013xQc2V0VEDo1lDVKilNKCK/74u36w9c+Njq7YFoC7GZyYMTRiNbAFiqhTIVgOarnD79ADF2JpbekBH10kjOqPfLNgmbW3YbrPd8FhriNyQYcE4VwiKVn1v3OwaU/dFygTG1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rJ/d+xJb7Ru0OuQA6GUGp5RE/VljBz/gX8q3eM4WqTw=;
 b=NSkknv6fSHAbR4nk9phjxV4Knyv8uzrWwdZ+w5ZC2IkYZnYTlxCC+Y1zLsVH/4iKmsL+bUHjhhdl82WSPqGgMpBGxPaTby+5GjegqWG4kX/CKEyI+pzCmsYnUlv+htIz6Wy72/3ILCqw7ECAzVNoseBFZpv6+8feoPxl+All+pBfcwTb70/fTLTAVeR2EEiyl3EFVR8bxbXqi8jUJJWbLXK5ssKEuqY07qn+KglrKRP7F2vxcNfn626hmVT90Jo9ZoO+Zc3xnh562tAW5i6Xk7mJKxEeCturPv9qFx56//9de731ggFq9ggOwhDvlJGc2R5wEH6GKculS9PmlldOzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJ/d+xJb7Ru0OuQA6GUGp5RE/VljBz/gX8q3eM4WqTw=;
 b=iW64zXEIF8UuO/OHR7aEKooimKLU9TDhb47UG8AC5iYuJPV6qCNVc4jvNi58xPESH5e/A709u1mQKnw2D0pcO+73Hguo6HxcPJnRAklHruvxYofkx/Ompjr7vBAhxlMd1IruAPayc9MHUEpoXfAyjSXlVTsSfYwzdDXASMvRKXo=
Received: from BN9PR03CA0076.namprd03.prod.outlook.com (2603:10b6:408:fc::21)
 by PH7PR12MB6395.namprd12.prod.outlook.com (2603:10b6:510:1fd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 16:41:08 +0000
Received: from BL6PEPF00022574.namprd02.prod.outlook.com
 (2603:10b6:408:fc:cafe::c4) by BN9PR03CA0076.outlook.office365.com
 (2603:10b6:408:fc::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Mon,
 10 Mar 2025 16:41:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022574.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 16:41:08 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 11:41:06 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>, Brendan Jackman <jackmanb@google.com>,
	Derek Manwaring <derekmn@amazon.com>
Subject: [PATCH v4 31/36] x86/bugs: Add attack vector controls for spectre_v2
Date: Mon, 10 Mar 2025 11:40:18 -0500
Message-ID: <20250310164023.779191-32-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022574:EE_|PH7PR12MB6395:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f8d56a4-9264-4388-1319-08dd5ff25bdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oKuZ7gVUZjlo47z/uAwEy+bUVhLQmW5/5cB+57DR9CMeQAlLK25Hsnpl4mAe?=
 =?us-ascii?Q?l40+hyGulCbQ1+LKjE1wt7JWsSdl5Br0r8CAQrrwS25a7Ftvm4hUHwjmsrye?=
 =?us-ascii?Q?9XaMa7/EBoGX87jTVD3ktcc/lQzZLK1VjclIDxpizYiwpxKPEDpUrscsf29A?=
 =?us-ascii?Q?sQ5y6whvk/81cAzqak7U8u1+IkmX6njGhr0SJ9z6obtGI91uoh0wrZYX0HEp?=
 =?us-ascii?Q?jAsj5TrVtZJnii0Z2sj7FjT/5e3bDYJ1mezlotX8+QGvLkNsmI9XeTYf9k61?=
 =?us-ascii?Q?1pp3KYYpAkMlUGMkHqKwjDOyCELoeYtUe7rD1kyLyGM3tW0Oh8fKpu96xSsT?=
 =?us-ascii?Q?0wen9D+pt3Yq3R8VPcMekJ4NL5/GhJh0rxYns4ps7AT7K/fRqjB8eH70nxF2?=
 =?us-ascii?Q?ZBVE0jepleq5RVWuy7nnu5AvuoVnwRHqwVijEHC7hQB5NVrg+gdzVOXlOE5G?=
 =?us-ascii?Q?kHRc72FOxTllUKdmfk5uBFS5iIsNNTpYjga5FE4hfGCIvZn+tCZvQkYQH9PH?=
 =?us-ascii?Q?0IicSbyWjv6xI3rgDvoRufkDJeEcOTLRskiM9ODJn+eyE7PtpnfHL/Pio+vj?=
 =?us-ascii?Q?zWfLyb1uI7AWlIQ2/xWIwjVrSbWjBx4jvyG9G5f5N026UOTWN1W4H/47T7vu?=
 =?us-ascii?Q?8YBrejiVbe5fWM0XeJMGG0bHw/u7Gq1+skyVXy/p1a8+kajSWdqeXVLV3XoZ?=
 =?us-ascii?Q?uDnLHBAmWmCCjufXJGb9OBDt+KwV6ZrK9wD+HqmaWXAWv7JEE3ucnScwuW9V?=
 =?us-ascii?Q?Ra0au97xIOXaLWqNKoORQg8StPstOzwJS6SKWAtN24TFE5d+TSoTmcIUvrsv?=
 =?us-ascii?Q?k7yf9IY0XWt4v4jdEOBzL1mxefI+8jKOlKuAcNg7M5wB9qbRObuxwBohMjBt?=
 =?us-ascii?Q?UE2nzRXjkmVRZpWPxh4CGMRvEIfO7XBdfi34P6UTMi+HYzj4yXWB8kAQw5DY?=
 =?us-ascii?Q?KASjfTSK/XFZ6JPOLnSsxeO5NrBU2SsEtysO7AkhLS+rwf6tf8fjHOMqj/93?=
 =?us-ascii?Q?W6vW7KbWkoGXdqjtHz0Vy10tTj8WtFxmWf8rI98jjXgXbkhQ+kWW5SN8LZDw?=
 =?us-ascii?Q?bm/Tg7hwreIuHcwAB5Ub51TTRyLDm+oLgAPnEKdh8gt/6uya6afDuYYSk/lH?=
 =?us-ascii?Q?VlLighwofpHScZWO59gE+H+9ZOekbemHnX73WZt3h2sJQ1pKQq9CgDG0etQV?=
 =?us-ascii?Q?pUupzm0/NwAJMtTI1F29RKE3ZNXRMXFPCX70XnC1NnvKNhbMu//I7b2diVza?=
 =?us-ascii?Q?L/TVxL8gdzA84CvDyMpuo2zXNz0qu2F+/kuJnqPaZcgiW6Utc3idAAn/1pRH?=
 =?us-ascii?Q?titbOgC3nSmXEbrdBXvdmp6FzWEvIF78coXUXmie3QSdyDQI0LWVzqZFhLi6?=
 =?us-ascii?Q?71Bn3BVTVE+C4+Fyte5rGLgcb49j2rocf9gEpSpHbeqprUCl/3WsEZNyf/kn?=
 =?us-ascii?Q?bP8jdpdUry23bKgBL+IG/siJ+ybIArSH0ISEj03W7XpDm0hHPT+CgJluIbFF?=
 =?us-ascii?Q?0THzj9536eJ/mFA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 16:41:08.4080
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f8d56a4-9264-4388-1319-08dd5ff25bdf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022574.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6395

Use attack vector controls to determine if spectre_v2 mitigation is
required.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 4912367f2334..e35f7059f6fc 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1715,8 +1715,7 @@ static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
 	int ret, i;
 
 	cmd = IS_ENABLED(CONFIG_MITIGATION_SPECTRE_V2) ?  SPECTRE_V2_CMD_AUTO : SPECTRE_V2_CMD_NONE;
-	if (cmdline_find_option_bool(boot_command_line, "nospectre_v2") ||
-	    cpu_mitigations_off())
+	if (cmdline_find_option_bool(boot_command_line, "nospectre_v2"))
 		return SPECTRE_V2_CMD_NONE;
 
 	ret = cmdline_find_option(boot_command_line, "spectre_v2", arg, sizeof(arg));
@@ -1985,8 +1984,11 @@ static void __init spectre_v2_select_mitigation(void)
 	case SPECTRE_V2_CMD_NONE:
 		return;
 
-	case SPECTRE_V2_CMD_FORCE:
 	case SPECTRE_V2_CMD_AUTO:
+		if (!should_mitigate_vuln(X86_BUG_SPECTRE_V2))
+			break;
+		fallthrough;
+	case SPECTRE_V2_CMD_FORCE:
 		if (boot_cpu_has(X86_FEATURE_IBRS_ENHANCED)) {
 			mode = SPECTRE_V2_EIBRS;
 			break;
@@ -2041,7 +2043,7 @@ static void __init spectre_v2_update_mitigation(void)
 		}
 	}
 
-	if (boot_cpu_has_bug(X86_BUG_SPECTRE_V2) && !cpu_mitigations_off())
+	if (boot_cpu_has_bug(X86_BUG_SPECTRE_V2))
 		pr_info("%s\n", spectre_v2_strings[spectre_v2_enabled]);
 }
 
-- 
2.34.1


