Return-Path: <linux-kernel+bounces-227367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2738915018
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57242281CA7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 14:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557B619ADA1;
	Mon, 24 Jun 2024 14:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2vwvUVPm"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743F219AD9C
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 14:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719239860; cv=fail; b=AgjSuWq+S2NF6IX8T6C2XJzVCz4dQySoRuimCg4Pzbgtw52fH1lYWRWBe1TaLCnfbUZQQXr74KOJBPu9nXr9+oyOTwbgucUCqfTaoDyCwgi60K/rIbhin9HEvcRTn3VLnCHzF+WGpk/nO8qxmaEqbpkjg76e1A83erRKaOamg3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719239860; c=relaxed/simple;
	bh=verHtiZf/iVNzl7U9hmkm2hjXL7PjOqURfJYRwP7070=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E1tBqAktRTNkgjwpbp7dKxoGIfjdoAq3amg9hUFKzqnl4rYpegm89TMo1tnCqISjwuIC1VjnfbJhUbHDZRzYOpSPH5Lh/tongxwfQ+r5YrryNjLpz5deVbMq81EOIc8y5qP+QFedKB/VEc0E0hB5Y/9+5OdqliQS9UEbpwkj75A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2vwvUVPm; arc=fail smtp.client-ip=40.107.223.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O16cyvhI5j/7Br7hjIilV+Pfo4PkMygM5ApwAoSaRlqNunNNV+IAIQeBSFj+2n26ZiVXRD9cVhFg6/JQ8DXC2c0a7bRjmHI1rTU1qbu5+K+kZJggcSYyHQjx34C59DNHRy7hLlG+ZKqRyDo13nZAZxhH1zcwjBvz2A9x6gYQ1mHwpsm17YBWStyYCPq8464ICMvhMXOy/AyBBZ473p5TViidXna4gzto80Ya05WR7NzzHxe2kUTmzA96YG+YfQPuU0WZpIxR1WpmRA3H3XF5coOPyYhSt8BxZOVqaozZzcDZ39KXcCxJb79r5dJI5SwP+aap38hRBnu/oY8++1+FtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uTpESBTdoperuSFMsX12OBru3MYfjl7IITR/8JLUiiQ=;
 b=SwFyHlKu7Y+hiIs7Sn5/Aw0S7NkNOeNhSguFsYR+I2xa5PkaBY7sHsetHHmS349fpFrs7TrjBakmEAK/B36fUmsE0Img747hlqWtsajEEeCatQSJMiJ5H8V6PMWD0wNImvHKfPvRQj8PA6q7bihoAO55ODIa7Xc4UmGQKltvY0aaUx07NMmKSFg5m3WEwVRwbEzhWyLzk42tqqvCOSRcZ7ri+i6forcaOU0Ldzw2bNRswxxwBu+zi+8Z3mwRI/yOBJ9CQxbG2Q6W1z00ZMHKt/6j5XHxCcpT1JJ+oNSNcpwG1q9QDE4Bzlh+rNxeCsCAbgAKZGJssT7V4wsluKVL6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uTpESBTdoperuSFMsX12OBru3MYfjl7IITR/8JLUiiQ=;
 b=2vwvUVPmgWUv+XITpUMOiCa4O7d8iNsH+u7CPIrhAettNODkPPQKuoGpMZihL72XS5aIJF+IQQCUO/azkb+CYp2B8ZSJyoJpPekZl+RF9Xz3Mfk8bupgGdHoHRKVp2Da6GF2HK/idB5S19uKFEZiIIrTa31N+v4OVrYom1Q3lzg=
Received: from BLAPR03CA0114.namprd03.prod.outlook.com (2603:10b6:208:32a::29)
 by PH8PR12MB7025.namprd12.prod.outlook.com (2603:10b6:510:1bc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Mon, 24 Jun
 2024 14:37:34 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:208:32a:cafe::a6) by BLAPR03CA0114.outlook.office365.com
 (2603:10b6:208:32a::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Mon, 24 Jun 2024 14:37:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 24 Jun 2024 14:37:34 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 09:37:33 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH 1/7] x86/sev: Prepare for using the RMPREAD instruction to access the RMP
Date: Mon, 24 Jun 2024 09:37:05 -0500
Message-ID: <683bc0dbb294a5ffb743bbfb50e0a1de4664e8cd.1719239831.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1719239831.git.thomas.lendacky@amd.com>
References: <cover.1719239831.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|PH8PR12MB7025:EE_
X-MS-Office365-Filtering-Correlation-Id: b90bb275-eed1-4525-cd15-08dc945b2faf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|82310400023|1800799021|36860700010|376011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sfUtj1uJTnl2SA/rxVp/0jQ9wqH3yeKKtjoMCLGtd9CreAy85Km+SDCKjjeo?=
 =?us-ascii?Q?bSUv1gB9J7g3o3L02NRwYB6+mEnYJpRK7qk2kTImUbfuaoMsFgaoht53JURL?=
 =?us-ascii?Q?OVWFh7SZWyZVDor8aXR5Ix5OxSDxAix45gGJBsyP6w3HaWDDPGwCLsdLRxGm?=
 =?us-ascii?Q?huOHiWDV6oSOreZkgrGPrJ4LmxGnuM3xjJbkBXL7oz7CUIj+7e7yn4NhffLR?=
 =?us-ascii?Q?Iln4o4bCHAcIlSx84h6yYfAc3lCAQVnFjROJMDbaUIFmGSkivVPYycytW74A?=
 =?us-ascii?Q?vcAQnr9gXOp67l0TiJBeibqdHsLsY3VWfjWvN1mioQ5rHsjaYMaZMS9Vjpkb?=
 =?us-ascii?Q?d3GgYcaTML21DfQ4bxqRnilFa9NqMFivg4klSj4UwqDoo/dZXpEWY6GJ5a8k?=
 =?us-ascii?Q?lJ6JIIbcNuoTLKbKQuWNn7orRcsRpRCP2+el838d8jA0LPP6exGTjR90Zk4B?=
 =?us-ascii?Q?2yXMuLVuwUqduWs/OIGUw0Smq3KdLJie++qKBJWng4us9IxvfxWw/xCGZDQ0?=
 =?us-ascii?Q?sfGInrnb5Wp31U8/aEt47xsAWA05tGT6i0kmHpWtuTvt8pPOWaB9JDVJbN/U?=
 =?us-ascii?Q?Ag28psD9WgAV326rUL6pxZN1QTOQb7g4TNuraIQCxo5cwf85fCMQMn1b8tvX?=
 =?us-ascii?Q?eJ58/HzJMdv56wAOKwNx6eg72KFm2It62+AeIYtW3sp15AraJGuXm2rN5YGg?=
 =?us-ascii?Q?ovOVzbwgSjhUiMUqbRlZS5+Ca6MlwrL/vf3h45MfDd+iIST3rAD3jEsarC8d?=
 =?us-ascii?Q?aK20ggFgBtptRIf6pMHS9FjZlSl+aXQfoYApd6qHYjfC6UFlJt1NKWq51EjU?=
 =?us-ascii?Q?HLKxUnf1qZOtTSrIBARqtDY39OAooO+u/6KVu1ISwFjcAYbPj+wZ2qHlX/rf?=
 =?us-ascii?Q?bKO6iwbXE8+1Q/VHTBl1FqhSBvHyTa87m8IA0j2QkRpNiU6I4Kmp0Xi1ZY1+?=
 =?us-ascii?Q?Gvmm/DKznrkQ1XkPXlJI8rohldaBxxJCnR8IqrO+JlR8JuAnkwtErsmjOyPd?=
 =?us-ascii?Q?s34+u337J+Akmddnd5/pOthaqqQdWRbcIfEhLJOX2YbEkcUY+uMm88OQPo1a?=
 =?us-ascii?Q?UUdXkWOa85p5ca4XEHCYVWSGk90Nv+G7ooPFeWuYnaNn63CNohHt0QQy79Tn?=
 =?us-ascii?Q?Z/XK13HUhqFOb5+UkvKelvHaXJQ1sDruUEnTrFflUSme1yd0IwVTob7h9t7g?=
 =?us-ascii?Q?rDeBSRQQyUYmd2l+nMdyTgoliQTqa3dLILUIzeTFY3jRSTS8qLoB3EAuzA4p?=
 =?us-ascii?Q?9KzbLVD3A0leoyOGlY+RUPt2Sk4Jcw1HuJjzyVs+yZR777zREKyuvkh8CDVt?=
 =?us-ascii?Q?ewsPV9cZ4ICT5uUNgTi5EiMaqrDU6Roa/9BATKrgpna4E3GhvaDlAaAQ4tpR?=
 =?us-ascii?Q?Pfjh9dP3mLGGJYWPY/7Fg0ccZlmlosj52pxEwHPTwL5IZe0aPg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(82310400023)(1800799021)(36860700010)(376011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 14:37:34.2128
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b90bb275-eed1-4525-cd15-08dc945b2faf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7025

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


