Return-Path: <linux-kernel+bounces-290031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DECE954E9D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 18:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFF701C216A3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 16:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDA01BE87D;
	Fri, 16 Aug 2024 16:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GHj1HVVX"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D361BE87A;
	Fri, 16 Aug 2024 16:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723825020; cv=fail; b=FL39AJuEwFMP7d1Vqo3rp+bjR1b0wZLd3xehMgfVpTPisnWejQS28cFWFenuert1tD+BLYLmyOudWR1OXaAk6dBWcP42WW5zxU40J3TTomWJnL1ZhxqoxDxmpgFJkcBx1JQmPWbyfAdfMUrj/0R9oK9lToxciVdujfC2Isl3IrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723825020; c=relaxed/simple;
	bh=yDkoIq/tn5d0Vfz9aEHDOJSfupdrVEJUsXx0HZ/1dKI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gAxzbpbSeLW54cBx/yeTEe46sGgscZZTaAaRL04SF9iXUwrO65B9+u+EMy0RXWcRVYmWv6mgPP0KUSde+yW1dj06GiHGa4d4PmgbFUM56ikd69vmKMAEhgZdGUUU2gAnjHOO4SG5HR7KXmm9rFcva/AEGQwO2VCl0iR9vBjUT5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GHj1HVVX; arc=fail smtp.client-ip=40.107.223.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A0raIRa4zhcaSnF+H34FGrNV5m5kG0wy/l2q7FTnQVU7tMX/iFqg6TrMw+VLUFKECCLE1DFU8x07i/72iHEJ0KScKs58iDVY2xbVLm9GZhJuCxw3b4nf+SxYlj3On2LlVSCKT1OTq2EshlPcFzDIN3HR6R5xOVPgyxrHyhsLxUmz7lyp8KyQ7/p76kAh1Za8mgEcw/Tf3Rfb+m4qA7GpW6tD4fbzTtGYxpXnDYyNSh6zuz5G+eipv+yTPAaXsdzbdJlJv/FhbD2Nw5JCUTXtbtGE2qIcivexEpNRbLn9yjbmWy03PRvELq+E6cwTvfv/c6W+DIJr2I+XpH5tPe4EJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0fCW1yXtlZOlzAiz5mWxxXF5/3DMpjMjU1Gt/W92U7U=;
 b=ORoTRmLkhaLvZ1jLZQ49GE05wnycw5slvPDOGLmCErG1hmYQLZsV6JeRh41yrEhZaArbeS4rkbSBXQMhsKnpMy9v7+Ce0sPViGYdIfkulUuHkeVX9VaKnlOhcQInHRTO+pMGnUpLEKfLWyyOuUYOs/PPd8jbwIGywdabZdtPGQXpWST4axLgqmuJsSu51UEBRy4tPxL5ocZY9EzjNqGhyitLWBwnZLzo20+Fq9ULmuooAG8qnHEX2YmYK3VNvbO40E7/oM4JQEPu7tSCQrHeECIdVLIBAh1tWY2EfUV8ExAicdBbD8uwCdkoDmM3BOL4RT7p4+FUqzYx/+pasmqYAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0fCW1yXtlZOlzAiz5mWxxXF5/3DMpjMjU1Gt/W92U7U=;
 b=GHj1HVVXPIKtUjqVWVwgK43Rup1BRy4ZoUv0uF/ZRtCJMdWigJstvBkWg0762NAaAq+YMPkiF0OIeT+nhHr+GeUM3R2Of4Uefy/1L4e3JPDph8dGbu/OV4RNuF00aaegPcsloYx2lW+5GntufhOBxx7w32gJLuSkTVLn2MayrO4=
Received: from MW4PR03CA0341.namprd03.prod.outlook.com (2603:10b6:303:dc::16)
 by DM6PR12MB4354.namprd12.prod.outlook.com (2603:10b6:5:28f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Fri, 16 Aug
 2024 16:16:54 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:303:dc:cafe::1) by MW4PR03CA0341.outlook.office365.com
 (2603:10b6:303:dc::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19 via Frontend
 Transport; Fri, 16 Aug 2024 16:16:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Fri, 16 Aug 2024 16:16:54 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 16 Aug
 2024 11:16:52 -0500
From: Babu Moger <babu.moger@amd.com>
To: <corbet@lwn.net>, <reinette.chatre@intel.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>
CC: <fenghua.yu@intel.com>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<thuth@redhat.com>, <xiongwei.song@windriver.com>, <ardb@kernel.org>,
	<pawan.kumar.gupta@linux.intel.com>, <daniel.sneddon@linux.intel.com>,
	<sandipan.das@amd.com>, <kai.huang@intel.com>, <peterz@infradead.org>,
	<kan.liang@linux.intel.com>, <pbonzini@redhat.com>, <xin3.li@intel.com>,
	<babu.moger@amd.com>, <ebiggers@google.com>, <alexandre.chartre@oracle.com>,
	<perry.yuan@amd.com>, <tan.shaopeng@fujitsu.com>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <maciej.wieczor-retman@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>, <eranian@google.com>
Subject: [PATCH 3/7] x86/resctrl: Introduce sdciae_capable in rdt_resource
Date: Fri, 16 Aug 2024 11:16:20 -0500
Message-ID: <cf9e47bbd66dbbdb76f0124620fad2f1b06e977e.1723824984.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1723824984.git.babu.moger@amd.com>
References: <cover.1723824984.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|DM6PR12MB4354:EE_
X-MS-Office365-Filtering-Correlation-Id: cf14ab07-2874-4f35-48e0-08dcbe0ed831
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w20VCmwfhOcolW/xYF+MwzQh+dSTNGNemISg7E9QVyU3sOrtGzeXsnJXOhf2?=
 =?us-ascii?Q?3TRxknoX1gIbivMvK+PYLnXRxKtLJ6Bx17GxTZ4EJ+JAuDzQ/SOvK/K9A71y?=
 =?us-ascii?Q?zeWi2sj0FhuvEgItE6EDocs7btaUz+RIHjvjoI4prDiXDjHLokijTnkqhZ3m?=
 =?us-ascii?Q?gMoxUncSlJPYfYF1p7ybCD5/ObXEhqjLipRUZn1MXrKIyp9Q+4TZpaIOjfrk?=
 =?us-ascii?Q?nwLyyz+HRN0CgdIG0WvmI9VwwxXQ6NzXGjrAg5HyraXrl/cxSt661t2Mov4t?=
 =?us-ascii?Q?zlH++Dr33nGk0dyqTVfJr36oNs/YU3vw/t2eberZd9eary8d9v0njYgtEUeW?=
 =?us-ascii?Q?LeiHE3CZod4ki2NoPF3p/wn4exkM3bNz/FDq0VlO7IaUGQWb3WFYeCbIZ6zA?=
 =?us-ascii?Q?N5+yY9l5ow0Jb4j0t6E/MEbxz+itFcDTyKJD7DCUJKlAYqEQFgqznw0Ak+yh?=
 =?us-ascii?Q?/YHfiUZN6mTWfEzEQ1q0enQXSbbWgqaIx8DGlGus1rKi3YqQhDNjqM1hYTp0?=
 =?us-ascii?Q?0O62DDx4kSsk472fSq+8cW1+q5V064A/GkP8CIcxllb6nKA1JSHujg/t/u6s?=
 =?us-ascii?Q?uICQ4E7TFl+djnJQKsdPVI7MHIdn82izQn711tZdSg+T2fTToX8JnkNRNGuB?=
 =?us-ascii?Q?4lO13seXaCHE/DA18ifRGykEd8MFtiuow68zyEuvsyIeLZX6rH8Kv6FhZ4NC?=
 =?us-ascii?Q?egNoAuGiqmTZYGvlwMxVjzPVYsAIyEdclRy7ikX0RFxDv9xY1AwRzJAfuNRQ?=
 =?us-ascii?Q?ld4sTsM/QcpuHouppQGqulxfq2Fj6d5ks3KKFY0KgeRd51Dxu9Wyi/JVmZCM?=
 =?us-ascii?Q?VrggA0Qm4dGedE5YC3oBnPWA6YojPNgNUjrwaQ/tv8ySOYz1uI6F4eVnmkM+?=
 =?us-ascii?Q?22VXugVZDXUuA3jvIK0Hk6eQ9FpwrTVCtOCPayt3Yvjm/ZdEatXTp5tDpRfA?=
 =?us-ascii?Q?yLan/3j8ASTZBZl0l+cKk3s236ouPNRuIxYF1eiv38EX9YotCQNPusM+eUex?=
 =?us-ascii?Q?JMxXVntZgUXnZ0fQi3JTD3fufOZ6BvMUrEyuqSJvcZoFLyuVq9rS4ZaBpQsR?=
 =?us-ascii?Q?WBtVRb5Fz8JQhcBx3WUE7c4iaGMQQLQrVR+HtVhf6z3J+suPlv+6gofihJ5V?=
 =?us-ascii?Q?TDfsdJwot/zBRo4nBfcUqwPtkU4qVOIUMHX0XTUoK1l7l6y5oET2PywZTWm5?=
 =?us-ascii?Q?CtP0mNkSlRRUrxleJY7MoGj1dWNl20JYYh79tx43AZdYamL6Z5lZ5Sj/l/G8?=
 =?us-ascii?Q?4wWBKa0DrECsUvdscTWL7GVU3tdsNkLqHqCA6yc0UZi4juVBekahOlgcmhLd?=
 =?us-ascii?Q?UVxFymTRzjYQcmc7/UO9lwdTWRlXCu3cvO27OX0mfT0ufZyhDgj/pZ/z21vZ?=
 =?us-ascii?Q?SXxr8bnprHis5sT+KK4OOtdtj7bYlzU7uRzzzhpZzrIrNG3vc3B6g03e2nt6?=
 =?us-ascii?Q?rmc5QZFVQJs4ztJ9CitAZWU9AJryJ8Ye?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 16:16:54.3820
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf14ab07-2874-4f35-48e0-08dcbe0ed831
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4354

Detect SDCIAE`(L3 Smart Data Cache Injection Allocation Enforcement)
feature and initialize sdciae_capable.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/kernel/cpu/resctrl/core.c | 7 +++++++
 include/linux/resctrl.h            | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index c4dfc768ddf5..e4381e3feb75 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -296,6 +296,11 @@ static void rdt_get_cdp_config(int level)
 	rdt_resources_all[level].r_resctrl.cdp_capable = true;
 }
 
+static void rdt_get_sdciae_alloc_cfg(struct rdt_resource *r)
+{
+	r->sdciae_capable = true;
+}
+
 static void rdt_get_cdp_l3_config(void)
 {
 	rdt_get_cdp_config(RDT_RESOURCE_L3);
@@ -921,6 +926,8 @@ static __init bool get_rdt_alloc_resources(void)
 		rdt_get_cache_alloc_cfg(1, r);
 		if (rdt_cpu_has(X86_FEATURE_CDP_L3))
 			rdt_get_cdp_l3_config();
+		if (rdt_cpu_has(X86_FEATURE_SDCIAE))
+			rdt_get_sdciae_alloc_cfg(r);
 		ret = true;
 	}
 	if (rdt_cpu_has(X86_FEATURE_CAT_L2)) {
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index b0875b99e811..281ba4fb8972 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -202,6 +202,7 @@ enum resctrl_scope {
  * @evt_list:		List of monitoring events
  * @fflags:		flags to choose base and info files
  * @cdp_capable:	Is the CDP feature available on this resource
+ * @sdciae_capable:	Is SDCIAE feature available on this resource
  */
 struct rdt_resource {
 	int			rid;
@@ -224,6 +225,7 @@ struct rdt_resource {
 	struct list_head	evt_list;
 	unsigned long		fflags;
 	bool			cdp_capable;
+	bool			sdciae_capable;
 };
 
 /**
-- 
2.34.1


