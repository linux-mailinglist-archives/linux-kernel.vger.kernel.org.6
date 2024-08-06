Return-Path: <linux-kernel+bounces-276990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6829B949ACD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 00:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB708B25245
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 22:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F7516BE0B;
	Tue,  6 Aug 2024 22:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yXrc59Kg"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA37175D2C;
	Tue,  6 Aug 2024 22:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722981736; cv=fail; b=HsAjLeqL8nj0Ji7xNXCpBSHSA1vsTUiOY16S2tvu7kFOSWA5kQ0/6iH26hKHjmWHAkk53U8/80h6CHHYSzxw3Rt2jrUlQXmVlO17uxJTO96ekcKe9/s13I4nyrsGR8CxEeKi/tUaPVf3JAfvHo7P563kc8vVLgcUYrhGa9Nr7oc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722981736; c=relaxed/simple;
	bh=nDmdUzKUuusuNc6o7R+mkJ+mniw9TfneVM5/6ki2k0I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aZkDdsky7rxLJfIBMRwFK+3kaU41XzSVL1fKRtjDOSxiJXZNznaXCSWhGYskX1epqtM4vHNsxC8Iy+69Ft7WXpthBD010Gj9CNPVmVkxYGlzZ4/EKm+gnEiXu4r0KYhrs+0qrTEvAPiEuKWeBZgiEhrfwxXsW36tWVzFijFNysc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yXrc59Kg; arc=fail smtp.client-ip=40.107.220.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IpxvBvAzjl5dtJ7VBmbK1YXzPtIp6999fAElflg/ynER/r1Gt1w0kN4ejRJ18+aSrF1DXsnjK+Py+8mrWO/q8Bys+9WkIgmNQ3aeWnBxiY1jDwsjaDbmULban2iuxtM0Mt/xUyrv79WSYf3V8cddG+8sINA/17+Q+ToOxcsYs8/BCE09gwvBM8afgd0l58E3VLmZp/aoVk36rv8qPg9z/bLPWbxzXQdXQK+b8iJTNio9FGYqn3BzJO9jH70uS4nq5CoPrBSUapIXKS7WU+73nv84aFUG9IBru5Bx46BjVxNbOFF/Hnn+LV3UF1jv6ITmAHKeAu7eRc0xg4i4TWzMNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jKPizM1MsoU/qK2iulFWHtPUuY1SjFxmMvCh07dt8k4=;
 b=FWGx1PLo56H370AeZWBBi/KdEXygtzEoAmjNLqQE/4IMyMqhdA4hHHSy4+R2OJ+cxKjsmDP3wi3ouKsHGnJRz6s7kVY6JRgn0NhqmEJnuT5EiQ/Jq+eTjmQIQ7OxPk7SMjdhoYXvTa1ljglAvnk3qTKbd9ULrkQqpzpscesor5O/zMgHTUKWWg3X/XbuyUUhVV9F3JFDejYaO1Sbs+7KvOpVy6cItdVzocj85fxzV8W3k3yX+d3GrVEqpPLZZ4MrgOcNYgwU7xpUfAwZ6kR2Qye6GsIloWulqEaMTB5OuVD/bwBBT1/tU/C2prbNyLcneAxc3Q5+g6sErATuGRCZrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jKPizM1MsoU/qK2iulFWHtPUuY1SjFxmMvCh07dt8k4=;
 b=yXrc59Kg69I4VSD9/hfzwvf1/8JlCmp8weG2rCVsKCvE3lDN2wXy61Pk2B1mp9dTOcQVCA+K12SqW1yEp+bEVYjPd1hMDjdnhQGmxuXHBF3jNezYn9mgfpLe8xvzCQJm6HSEXsMY9pWH2pmsS74FYlmNzu2HS4b1kQCzy0Ec8j8=
Received: from PH7P220CA0145.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::9)
 by MN2PR12MB4160.namprd12.prod.outlook.com (2603:10b6:208:19a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.12; Tue, 6 Aug
 2024 22:02:12 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:510:327:cafe::f5) by PH7P220CA0145.outlook.office365.com
 (2603:10b6:510:327::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.28 via Frontend
 Transport; Tue, 6 Aug 2024 22:02:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 6 Aug 2024 22:02:11 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 Aug
 2024 17:02:06 -0500
From: Babu Moger <babu.moger@amd.com>
To: <corbet@lwn.net>, <fenghua.yu@intel.com>, <reinette.chatre@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
	<yanjiewtw@gmail.com>, <babu.moger@amd.com>, <kim.phillips@amd.com>,
	<lukas.bulwahn@gmail.com>, <seanjc@google.com>, <jmattson@google.com>,
	<leitao@debian.org>, <jpoimboe@kernel.org>, <rick.p.edgecombe@intel.com>,
	<kirill.shutemov@linux.intel.com>, <jithu.joseph@intel.com>,
	<kai.huang@intel.com>, <kan.liang@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<sandipan.das@amd.com>, <ilpo.jarvinen@linux.intel.com>,
	<peternewman@google.com>, <maciej.wieczor-retman@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<eranian@google.com>, <james.morse@arm.com>
Subject: [PATCH v6 08/22] x86/resctrl: Introduce interface to display number of monitoring counters
Date: Tue, 6 Aug 2024 17:00:45 -0500
Message-ID: <da3c2f99c07987d59d9df1db0a0a85ec323cd67f.1722981659.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1722981659.git.babu.moger@amd.com>
References: <cover.1722981659.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|MN2PR12MB4160:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a71f9fe-1069-464b-e497-08dcb6636c9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dPq8CBEA59TPR6637bf2eY0GRnkNcsdrMyg640E2fZM5YvxLijhxskGD1inM?=
 =?us-ascii?Q?zZyxthHPOJVx2vowd4gZDemh58343XqtjrgbfE4+5CyiOh0F6TpOyTRnPrxS?=
 =?us-ascii?Q?bFP7W1YK+gIfjso8wcYGe/Z+7wixawkN7FsLDOkmf61oPrPkK7Zt1XaTGNyo?=
 =?us-ascii?Q?FvjVK0hdF8qX3+g/K0tG3DGZah0CtyJibYUIbjkmT0X2D9c1QARseNyIJJEH?=
 =?us-ascii?Q?jehQD9rlLehrkOi0sY/y8Izpna4m282IPINO7AEAJt+fP5olqV8UNlC5lLoW?=
 =?us-ascii?Q?GdkW8g0hqC+4f0bCKGcizh5kUWlqcaMfEXvxsPKqnVZ436ieWd2RYCxhK9xs?=
 =?us-ascii?Q?awuF3yJr+13+bZ4ua6zWQYwTA2qOeG0laq7jQ9ysgM1MHTHsLEdYPCDiT5wf?=
 =?us-ascii?Q?V7jBSpR0DCoVDd6jP5obEzOwlYKQu/3bT+CDmvNzx/GKXtFe3YTWJj6YzG4P?=
 =?us-ascii?Q?VLspDcLAfO+1USwwKx+4FOP5fEDvGP+1HxdaA28HDagMtYX9XN0O0gdlvMug?=
 =?us-ascii?Q?am2UZN/CEzxRbFYr6hOKKBZfuxEmUndUDA3dnrXuY54E46BYLst+j+3QrP6o?=
 =?us-ascii?Q?QORy6R3dRq4YtPN4y1YUTsJv0VhM10oMhARe9bW1ROBGFpxiajSktKn3nsfa?=
 =?us-ascii?Q?BdlH2a+eR28oLlzq+9KR/bYwEKaI++dk9k+ZH4N41//dGwfLiTnSF6qJBmMD?=
 =?us-ascii?Q?ElvkqnoKwFWyb9EWCmtspAWWd3bbgIvwiPlCVUcR12+iDMRaQgBZtxdFfHQi?=
 =?us-ascii?Q?tc2wMMHkHqgABxEzR6YEvOodSkX6EuhXliw3FZaADLQLmj+GwCN20VQpezPl?=
 =?us-ascii?Q?xVZ8l8kb57Eq43Lbji4/F5x689a5VA4EeSxexhzX4+5q+KgfFZZqplybCx2y?=
 =?us-ascii?Q?b3hrOu67Vu5PVANO6BLz0MOJQyDwmKJ7QIKQ3SK3THAwykdLd49Wju7yhfiI?=
 =?us-ascii?Q?N51BgQlvJjJaT4EKNIxkPCFKxTofT5Ji+D+9neahoVJmnnjR49b9ZNqWSKPo?=
 =?us-ascii?Q?kxSTsuz+0F55qN0/46KvXJJhWc6HjoSzr3efm7MlbjTOq2tYnw0q6ZDjlTia?=
 =?us-ascii?Q?+obIVqdAk5dc27mgiuBWVz9OICMtzOSSp2Ka8AijAU0gZfPQc2UmQHheTErE?=
 =?us-ascii?Q?hWraLb9DDlkJIeJT+5HMuNRLMDCqRRM7CsVDWeBBAMe99MUi5rDNMwgZGue7?=
 =?us-ascii?Q?rJx4YhQx3YQ/S6ZWEInDvIUdw54GXrxFwyoKjGw4xVz5pr1FQ4BLyDoA6wnc?=
 =?us-ascii?Q?hvK1Jqp9QZXH93Wdv3d21zv6jmXiVnARkSnedFu4o9UbHkVkQ9zsJIOLIjOJ?=
 =?us-ascii?Q?gBh9+VxhDo3Az8ZeFq1DIjWDJ7W/2Soe5uu24KMQ6SZ4IS0m1s3LeUd0au6d?=
 =?us-ascii?Q?7gxUX8TzKxYfwTZ5eJVsGdOw2q+hFKklgEgbFHfSmh3zaAMZsLzPzGuV8w3a?=
 =?us-ascii?Q?mVd5WEVT82zOGbashZ8hB3SJWvZ3mvWV?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 22:02:11.9200
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a71f9fe-1069-464b-e497-08dcb6636c9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4160

The ABMC feature provides an option to the user to assign a hardware
counter to an RMID and monitor the bandwidth as long as the counter is
assigned. Number of assignments depend on number of monitoring counters
available.

Provide the interface to display the number of monitoring counters
supported.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v6: No changes.

v5: Changed the display name from num_cntrs to num_mbm_cntrs.
    Updated the commit message.
    Moved the patch after mbm_mode is introduced.

v4: Changed the counter name to num_cntrs. And few text changes.

v3: Changed the field name to mbm_assign_cntrs.

v2: Changed the field name to mbm_assignable_counters from abmc_counte
---
 Documentation/arch/x86/resctrl.rst     |  3 +++
 arch/x86/kernel/cpu/resctrl/monitor.c  |  2 ++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 16 ++++++++++++++++
 3 files changed, 21 insertions(+)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index d4ec605b200a..fe9f10766c4f 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -291,6 +291,9 @@ with the following files:
 		as long as there are enough RMID counters available to support number
 		of monitoring groups.
 
+"num_mbm_cntrs":
+	The number of monitoring counters available for assignment.
+
 "max_threshold_occupancy":
 		Read/write file provides the largest value (in
 		bytes) at which a previously used LLC_occupancy
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 5e8706ab6361..83329cefebf7 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -1242,6 +1242,8 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 			r->mon.num_mbm_cntrs = (ebx & 0xFFFF) + 1;
 			if (WARN_ON(r->mon.num_mbm_cntrs > 64))
 				r->mon.num_mbm_cntrs = 64;
+
+			resctrl_file_fflags_init("num_mbm_cntrs", RFTYPE_MON_INFO);
 		}
 	}
 
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index d8f85b20ab8f..ab4fab3b7cf1 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -865,6 +865,16 @@ static int rdtgroup_mbm_mode_show(struct kernfs_open_file *of,
 	return 0;
 }
 
+static int rdtgroup_num_mbm_cntrs_show(struct kernfs_open_file *of,
+				       struct seq_file *s, void *v)
+{
+	struct rdt_resource *r = of->kn->parent->priv;
+
+	seq_printf(s, "%d\n", r->mon.num_mbm_cntrs);
+
+	return 0;
+}
+
 #ifdef CONFIG_PROC_CPU_RESCTRL
 
 /*
@@ -1936,6 +1946,12 @@ static struct rftype res_common_files[] = {
 		.seq_show	= rdtgroup_cpus_show,
 		.fflags		= RFTYPE_BASE,
 	},
+	{
+		.name		= "num_mbm_cntrs",
+		.mode		= 0444,
+		.kf_ops		= &rdtgroup_kf_single_ops,
+		.seq_show	= rdtgroup_num_mbm_cntrs_show,
+	},
 	{
 		.name		= "cpus_list",
 		.mode		= 0644,
-- 
2.34.1


