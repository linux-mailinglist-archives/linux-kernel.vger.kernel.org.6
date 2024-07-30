Return-Path: <linux-kernel+bounces-268137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C209420C4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 21:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4C09285F03
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 19:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD1B18CBE0;
	Tue, 30 Jul 2024 19:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mWRt791I"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F00C18CBF7
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 19:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722368432; cv=fail; b=ZvmDuafRgJ/eNcD/F53s5jre/DYCMfligKAQEb/UDFMnKrrs1AkpZ7Ih77h6Gzty1IUGnUVJKtoH6zqBIL4GTs4ueOZZKC+AvqgPPF75wV1FQ+ub2H8IaFjyw3J9phiTy8omJQKNJN+FnbCf1bYziNj/uf77tL1AKojMS433TLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722368432; c=relaxed/simple;
	bh=verHtiZf/iVNzl7U9hmkm2hjXL7PjOqURfJYRwP7070=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F27PAPXoGDO3OGy5xHGVf7htfaC77S+TitpxEwNQx/cjb5QZWJwriQ0CJKo3eqKzMuSJbYeU5RL/vjT7dKJUJbBO6RNppDbH2hkoSjJZhMJ5AzDnlV1XOc1g13nj67JUPeUyo0Ob932G2/TL/fX/aDkCdYQTQQ6F/5D3SBOkIFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mWRt791I; arc=fail smtp.client-ip=40.107.243.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x8wnO0w+dpenSaAWtjsmXStK+u5uMChyIIp0QllPk1+bRtUEF//12xScW4ivkpYPam1bYRfVXKzuxMSAkut3yWcsDYRyH6ZkJfr0jMKDro5Hh77hJHsvZspWzUEUoGGNDifHgHW4RJew4bQ3I3qPhzg4vkx1jw9HiS2OGSjLvZW+vo6tqNz94cdbLCo5nafbi/5nsHYtZbNCUh0Zx+FGXcRo9K/aebHCJeiuWsAiZ2R2ezXHKyWy9/K67FCx55n5G7t29QMHLWXtO4Qlg7eTwFXyOIUJL6YcU3xw7Kb83/SuQTA0PPDoaLdDzIp29ZkNrM491gjxJCUc0Az+WPSW+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uTpESBTdoperuSFMsX12OBru3MYfjl7IITR/8JLUiiQ=;
 b=tH0e1iV6Ax6ooL7oSIQAoFFYFB8LkrAaIdYgF4ejE0MNWnXZbpqbQx6bG7lO7p4nUw0OdWginAgBdf3nTLJ86/3/Gix67YTDrz22uO2OPbHd5mbEmYRcreanTfQ8jK0Yb0Jt2MAyV920syMuJHBIhBvEq5uLZCfvoGlYsqmr6aGR+l8kYb5/6zJI83FwOU3RU3I8L2IElLicl/t+OgM8HXGtzGMWmLJ8y2Txud7RSjbLcCRGcaZKqaHUnSBOapcq1iiVzxKyIBmoPMz4VZhZdnLHv1aPQyMtEMDFlRtbL3f57AO6f5iDMjJGv3XpRqwAsWIK4w5vlRzOL2QUG7tY+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uTpESBTdoperuSFMsX12OBru3MYfjl7IITR/8JLUiiQ=;
 b=mWRt791IvXL/Z12HUHmzjkTM53loi8un5EzLecbr1u+pzcu0vSdtQWnSXmqmIhguWp0shTq1MCGqSioKtaecqEhrrthgM58KebyC00/4+dZGZq5BK8GfNDV0Y6I36VzDuRbMNLD+1BwvVl+m7IhJh0EcyokZ4Gwq2YJIJvFO2q4=
Received: from MW4PR04CA0332.namprd04.prod.outlook.com (2603:10b6:303:8a::7)
 by DM6PR12MB4059.namprd12.prod.outlook.com (2603:10b6:5:215::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Tue, 30 Jul
 2024 19:40:27 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:303:8a:cafe::71) by MW4PR04CA0332.outlook.office365.com
 (2603:10b6:303:8a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Tue, 30 Jul 2024 19:40:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 19:40:26 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Jul
 2024 14:40:25 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v2 1/7] x86/sev: Prepare for using the RMPREAD instruction to access the RMP
Date: Tue, 30 Jul 2024 14:40:01 -0500
Message-ID: <310650b1c5a7936f1ebb0c14579ed23f825c0be3.1722368407.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1722368407.git.thomas.lendacky@amd.com>
References: <cover.1722368407.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|DM6PR12MB4059:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ecba5e9-fe28-4be6-ea86-08dcb0cf7663
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1itjC2zcmmuur2M41JFzu6FFkgPbcFom7tyYDwWfcPNxObsACzeQIOJpeAWu?=
 =?us-ascii?Q?hKap/Ev/9WZWf3gcQc2dpI97UVbLk8ov8SYkOajTeKu8rtHcEUZVLVwiJPIm?=
 =?us-ascii?Q?+kOOgWd0eLz9T/il1J7NipZx5nbDthiYr3K5dqTDTDIwEpckqFM88n18DnDq?=
 =?us-ascii?Q?+7L1V/nyggcvttn4+L6MynOxkRaMPBONNASHsRWBAS/NnplCPMHgztxmqFkI?=
 =?us-ascii?Q?5YIkOqHyNwFVNjQqho03dwUeq+VLtgKgFa7rx3IbNy6xvA75oIPBOfIZNeEU?=
 =?us-ascii?Q?O46PPdkZD7fMySo7QxoMy98TvFiiNwA8rOXxraF6Bu4j2D+7aWTuBStbUNag?=
 =?us-ascii?Q?bAXhhS4Q7PvCtXJaMR2UJ3Ut7wcp436+nnBBcwosMQz/qruENVy6eh+JGfQ2?=
 =?us-ascii?Q?BL8Fdy0i7492xDwJ4y0mV2MlJ2vyf1loKWwkazO52olz8T7iOS3g0fWET2Gw?=
 =?us-ascii?Q?vIlSnwOAmIQnAtcQojoaCj+AxCKWJ8x7QYPXU6UxQi5O26Y2p/99Mhtzh+Si?=
 =?us-ascii?Q?Y87Fe6GL9jlou6kNomZz0hNSphPk9lTqCWqkwCX+Y8nR5PwW7C8jMmp/6YRe?=
 =?us-ascii?Q?TaF5Fk8dlB8byH6+Tl+ZwPijBUsoQ0hxG+x05Turb8K46Wmy8ZdX8vjPHGOu?=
 =?us-ascii?Q?GDZq7DZ0bLiG4a+raA9lLOv83hheWD3360PsU3uIBouhqJ3yuwiFFrjUHQRF?=
 =?us-ascii?Q?sC1xG1djDwyaKVJzr9f6K014oqc3gYVl0DMPq2xE4cXWPqxpR3PUJMQlpyX6?=
 =?us-ascii?Q?d+MTGLhZMVMdDdao4wtGh6CMuaQPGv1o+r4SFNeT97cVZE+DPoqPFJDpLNUN?=
 =?us-ascii?Q?RXP8xorUeFyHX2onNmrJwBKQilyuGmVaFv9RkHufQ+E2nRdy1D2nIPxxwaoy?=
 =?us-ascii?Q?gjMVWSztySZ7uKl1RrytmVco75BixExqNFt3HdNLZyIzhc7a1zPu6XN+akhZ?=
 =?us-ascii?Q?yiMVs4zf0GRG279dqQP2ZX7gp3uqzy6c52DsMgZAebQGe+iZv1VHF+pucIDo?=
 =?us-ascii?Q?76OmcC+REvXEOiX+PxnwPdkNaQCqtJSBYiGeX88750D/BxnNPjGpSEBMnkS9?=
 =?us-ascii?Q?pizlDYQ3SOlRH0eYga8XD0GCpX5ZvBRVi87WpcRJdBAP5BXok71P2WYY0tjT?=
 =?us-ascii?Q?W9+ItDMK9Xe8DlIQ3b7STv8B0eor2FnEKd8ZXeiyocnTvnuofw9DCpICWfsr?=
 =?us-ascii?Q?NHlXJLSXrPc0HThK1Sl1zpdC8A6E2CSQETrMdC3JwdwvMY+mVRuuQ0hft0Vx?=
 =?us-ascii?Q?GqyC9KtMpvslmt3hFzPQK/5NlURxXxg6De1WvOXzmdmXryvcpK1L4u4yhhsZ?=
 =?us-ascii?Q?uOSv6bJY3wlqrR8lFiaSi+IB9+cZzY5bopMnt3kPWnRJ4Ra5CeVzNQ6B3tvl?=
 =?us-ascii?Q?aFp1G9nr29tZIJ2EMfuPjM2bIk768lcEpW60sFI3dH4/tAGA4sva5IVuJ1wk?=
 =?us-ascii?Q?jdfl77MAHStx4GAIeM8IY745rV1Lq+LI?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 19:40:26.8402
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ecba5e9-fe28-4be6-ea86-08dcb0cf7663
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4059

The RMPREAD instruction returns an architecture defined format of an
RMP entry. This is the preferred method for examining RMP entries.

In preparation for using the RMPREAD instruction, convert the existing
code that directly accesses the RMP to map the raw RMP information into
the architecture defined format.

RMPREAD output returns a status bit for the 2MB region status. If the
input page address is 2MB aligned and any other pages within the 2MB
region are assigned, then 2MB region status will be set to 1. Otherwise,
the 2MB region status will be set to 0. For systems that do not support
RMPREAD, calculating this value would require looping over all of the RMP
table entries within that range until one is found with the assigned bit
set. Since this bit is not defined in the current format, and so not used
today, do not incur the overhead associated with calculating it.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/virt/svm/sev.c | 141 ++++++++++++++++++++++++++++------------
 1 file changed, 98 insertions(+), 43 deletions(-)

diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index 0ce17766c0e5..103a2dd6e81d 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -30,11 +30,27 @@
 #include <asm/cmdline.h>
 #include <asm/iommu.h>
 
+/*
+ * The RMP entry format as returned by the RMPREAD instruction.
+ */
+struct rmpentry {
+	u64 gpa;
+	u8  assigned		:1,
+	    rsvd1		:7;
+	u8  pagesize		:1,
+	    hpage_region_status	:1,
+	    rsvd2		:6;
+	u8  immutable		:1,
+	    rsvd3		:7;
+	u8  rsvd4;
+	u32 asid;
+} __packed;
+
 /*
  * The RMP entry format is not architectural. The format is defined in PPR
  * Family 19h Model 01h, Rev B1 processor.
  */
-struct rmpentry {
+struct rmpentry_raw {
 	union {
 		struct {
 			u64 assigned	: 1,
@@ -62,7 +78,7 @@ struct rmpentry {
 #define PFN_PMD_MASK	GENMASK_ULL(63, PMD_SHIFT - PAGE_SHIFT)
 
 static u64 probed_rmp_base, probed_rmp_size;
-static struct rmpentry *rmptable __ro_after_init;
+static struct rmpentry_raw *rmptable __ro_after_init;
 static u64 rmptable_max_pfn __ro_after_init;
 
 static LIST_HEAD(snp_leaked_pages_list);
@@ -247,8 +263,8 @@ static int __init snp_rmptable_init(void)
 	rmptable_start += RMPTABLE_CPU_BOOKKEEPING_SZ;
 	rmptable_size = probed_rmp_size - RMPTABLE_CPU_BOOKKEEPING_SZ;
 
-	rmptable = (struct rmpentry *)rmptable_start;
-	rmptable_max_pfn = rmptable_size / sizeof(struct rmpentry) - 1;
+	rmptable = (struct rmpentry_raw *)rmptable_start;
+	rmptable_max_pfn = rmptable_size / sizeof(struct rmpentry_raw) - 1;
 
 	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "x86/rmptable_init:online", __snp_enable, NULL);
 
@@ -270,48 +286,77 @@ static int __init snp_rmptable_init(void)
  */
 device_initcall(snp_rmptable_init);
 
-static struct rmpentry *get_rmpentry(u64 pfn)
+static struct rmpentry_raw *__get_rmpentry(unsigned long pfn)
 {
-	if (WARN_ON_ONCE(pfn > rmptable_max_pfn))
-		return ERR_PTR(-EFAULT);
-
-	return &rmptable[pfn];
-}
-
-static struct rmpentry *__snp_lookup_rmpentry(u64 pfn, int *level)
-{
-	struct rmpentry *large_entry, *entry;
-
-	if (!cc_platform_has(CC_ATTR_HOST_SEV_SNP))
+	if (!rmptable)
 		return ERR_PTR(-ENODEV);
 
-	entry = get_rmpentry(pfn);
-	if (IS_ERR(entry))
-		return entry;
+	if (unlikely(pfn > rmptable_max_pfn))
+		return ERR_PTR(-EFAULT);
+
+	return rmptable + pfn;
+}
+
+static int get_rmpentry(u64 pfn, struct rmpentry *entry)
+{
+	struct rmpentry_raw *e;
+
+	e = __get_rmpentry(pfn);
+	if (IS_ERR(e))
+		return PTR_ERR(e);
+
+	/*
+	 * Map the RMP table entry onto the RMPREAD output format.
+	 * The 2MB region status indicator (hpage_region_status field) is not
+	 * calculated, since the overhead could be significant and the field
+	 * is not used.
+	 */
+	memset(entry, 0, sizeof(*entry));
+	entry->gpa       = e->gpa << PAGE_SHIFT;
+	entry->asid      = e->asid;
+	entry->assigned  = e->assigned;
+	entry->pagesize  = e->pagesize;
+	entry->immutable = e->immutable;
+
+	return 0;
+}
+
+static int __snp_lookup_rmpentry(u64 pfn, struct rmpentry *entry, int *level)
+{
+	struct rmpentry large_entry;
+	int ret;
+
+	if (!cc_platform_has(CC_ATTR_HOST_SEV_SNP))
+		return -ENODEV;
+
+	ret = get_rmpentry(pfn, entry);
+	if (ret)
+		return ret;
 
 	/*
 	 * Find the authoritative RMP entry for a PFN. This can be either a 4K
 	 * RMP entry or a special large RMP entry that is authoritative for a
 	 * whole 2M area.
 	 */
-	large_entry = get_rmpentry(pfn & PFN_PMD_MASK);
-	if (IS_ERR(large_entry))
-		return large_entry;
+	ret = get_rmpentry(pfn & PFN_PMD_MASK, &large_entry);
+	if (ret)
+		return ret;
 
-	*level = RMP_TO_PG_LEVEL(large_entry->pagesize);
+	*level = RMP_TO_PG_LEVEL(large_entry.pagesize);
 
-	return entry;
+	return 0;
 }
 
 int snp_lookup_rmpentry(u64 pfn, bool *assigned, int *level)
 {
-	struct rmpentry *e;
+	struct rmpentry e;
+	int ret;
 
-	e = __snp_lookup_rmpentry(pfn, level);
-	if (IS_ERR(e))
-		return PTR_ERR(e);
+	ret = __snp_lookup_rmpentry(pfn, &e, level);
+	if (ret)
+		return ret;
 
-	*assigned = !!e->assigned;
+	*assigned = !!e.assigned;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snp_lookup_rmpentry);
@@ -324,20 +369,28 @@ EXPORT_SYMBOL_GPL(snp_lookup_rmpentry);
  */
 static void dump_rmpentry(u64 pfn)
 {
+	struct rmpentry_raw *e_raw;
 	u64 pfn_i, pfn_end;
-	struct rmpentry *e;
-	int level;
+	struct rmpentry e;
+	int level, ret;
 
-	e = __snp_lookup_rmpentry(pfn, &level);
-	if (IS_ERR(e)) {
-		pr_err("Failed to read RMP entry for PFN 0x%llx, error %ld\n",
-		       pfn, PTR_ERR(e));
+	ret = __snp_lookup_rmpentry(pfn, &e, &level);
+	if (ret) {
+		pr_err("Failed to read RMP entry for PFN 0x%llx, error %d\n",
+		       pfn, ret);
 		return;
 	}
 
-	if (e->assigned) {
+	if (e.assigned) {
+		e_raw = __get_rmpentry(pfn);
+		if (IS_ERR(e_raw)) {
+			pr_err("Failed to read RMP contents for PFN 0x%llx, error %ld\n",
+			       pfn, PTR_ERR(e_raw));
+			return;
+		}
+
 		pr_info("PFN 0x%llx, RMP entry: [0x%016llx - 0x%016llx]\n",
-			pfn, e->lo, e->hi);
+			pfn, e_raw->lo, e_raw->hi);
 		return;
 	}
 
@@ -356,16 +409,18 @@ static void dump_rmpentry(u64 pfn)
 		pfn, pfn_i, pfn_end);
 
 	while (pfn_i < pfn_end) {
-		e = __snp_lookup_rmpentry(pfn_i, &level);
-		if (IS_ERR(e)) {
-			pr_err("Error %ld reading RMP entry for PFN 0x%llx\n",
-			       PTR_ERR(e), pfn_i);
+		e_raw = __get_rmpentry(pfn_i);
+		if (IS_ERR(e_raw)) {
+			pr_err("Error %ld reading RMP contents for PFN 0x%llx\n",
+			       PTR_ERR(e_raw), pfn_i);
 			pfn_i++;
 			continue;
 		}
 
-		if (e->lo || e->hi)
-			pr_info("PFN: 0x%llx, [0x%016llx - 0x%016llx]\n", pfn_i, e->lo, e->hi);
+		if (e_raw->lo || e_raw->hi)
+			pr_info("PFN: 0x%llx, [0x%016llx - 0x%016llx]\n",
+				pfn_i, e_raw->lo, e_raw->hi);
+
 		pfn_i++;
 	}
 }
-- 
2.43.2


