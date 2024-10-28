Return-Path: <linux-kernel+bounces-385694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 592889B3A7F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 20:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA77B1F22BE7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 19:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5DE149E00;
	Mon, 28 Oct 2024 19:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cGXpC+cM"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F241DE88D
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 19:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730143990; cv=fail; b=eOS1DjeqcgJth8z+9uB0vahcL6VLlNGILYx14k+LTe9nQgWDZWfNaj2pCe06s6R7rX+/ca3R4Z9KtpdMT70LbV8e0RQ3RTqy6Rqh3Xz5uL1G5kjRuV7Q11ZFwcC/2BTTyIvKmlFEzwnzHwKUvVRqJuWszYS5veG3BtDaFInQfSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730143990; c=relaxed/simple;
	bh=/wi+nbbqYlaZ/OQ3j/1WfXdzFhA77zsyjQmkr9V+fjc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qcZ4lL1wbyQUUJhS06dgI4tyJFfPubw+sF6KnyQQ9pVqlPIrL86pFUWZqX8Nz21Jug9QJL2nIsc6Gd2IJ987sukl05hPQL9RUqxw8tzWQ2hnM6xWjFFVUW40TrsqfdcfcLGPl1tXPIQIgnulC/cMUbFhL0x93kE4nuV8R2gEu7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cGXpC+cM; arc=fail smtp.client-ip=40.107.243.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sytf+SSq9bxJabx7Uz6DzJ1c84/hy4RdAUQvbBjIyCXXRwcztGmYEjlc5M93PUb7l0ShokycL7YTtmlFm23KmHH7JGS2Za47e6pQ9WwKhfAmVW33FEXg4Zk3vgtlTl7F+Y2tXr/iB4Uypa1rWCU6mwdXy9ItblVlx2NUmhunx9ms0UtHsisfJnLrz1qIyf6ZrxOUag3DXKBg9PyiW1H8zVWvc/RylE7bbbzAQU18HJ4xsgAociqcSVarRnLGYaWr9wW162iJRmLTNX0hoWE55Lgkl6iNFOwj1R8vTygHaDiRXIlKXafGZVJdBXS2Pmi8ABgQP2bgTlzOj9oFX8Sprw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ZDxl0P/kBpOWQqvNHWulBhoZ+Tr+vwWq3pu1UrG5/Q=;
 b=EDRskptgIcowQP6Ft4ill0y6RWSzFg03RhWUVaBEwvyUjgyeR38BdaeQWveY/Gohu9ZkoExt3zEyEvviFY4u3A6NMu1lKRRJWFN37uPWbd2yjwU5Jg8ap5AsUTD/WMzXBj1coiNWapIZSxCmrrW0gAaj1RUBNCMKFFlD6tBY3QRi0s/JxxXWBuwEEGorFIY6kyu7rPfPWk+89pqpKo6MLpNx2ZvkgiUEQVrDAbaInHCERdCR3u9rshePVABp/r5T2ih6gbNVlJtrNXru4JKfat5JoLz4eqvQtbuhB0IuY1NxY7qPW0qXVKPHYADpuS2Klpis7UA0DAqYeHqJR0mjzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ZDxl0P/kBpOWQqvNHWulBhoZ+Tr+vwWq3pu1UrG5/Q=;
 b=cGXpC+cMl3oDkiPU2DcAI+E5PqvoCOqWAQOq4PdtaKoy3FsbNEvoJuWnar84vNFZpr1CNsw4AnYfIXRKA6hP1ig+kxYw92Qg4l1aLzn/7l2XhI9Ge6FfP+8zzcFjlPodmXDzMPBHj8KEX8Jpghu73z8lxrRSQW6bvXDMgCM4HG0=
Received: from BN0PR04CA0057.namprd04.prod.outlook.com (2603:10b6:408:e8::32)
 by PH8PR12MB7229.namprd12.prod.outlook.com (2603:10b6:510:227::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 19:33:02 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:408:e8:cafe::fb) by BN0PR04CA0057.outlook.office365.com
 (2603:10b6:408:e8::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.26 via Frontend
 Transport; Mon, 28 Oct 2024 19:33:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Mon, 28 Oct 2024 19:33:01 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Oct
 2024 14:33:00 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Subject: [PATCH v5 1/8] x86/sev: Prepare for using the RMPREAD instruction to access the RMP
Date: Mon, 28 Oct 2024 14:32:36 -0500
Message-ID: <7f46e8c09b16490a2bb1df05a8a38926b7e333ab.1730143962.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1730143962.git.thomas.lendacky@amd.com>
References: <cover.1730143962.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|PH8PR12MB7229:EE_
X-MS-Office365-Filtering-Correlation-Id: 35f384c9-b95d-425c-191b-08dcf787560f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FyDxnAbt5A2ga5rAFAZh6kHDnCfTdmgegKQuxKA2zvaQh6J1+RuanKumo70o?=
 =?us-ascii?Q?X+nJBOThKzil/OwClajIrUquOjURerXNQlVI7HD/lcjJL0bKDvzJqmq3TvrH?=
 =?us-ascii?Q?4FGUFUKUy2QU2zwOfMIm/jtawDiccvJuesrhLJPqOHbjI1xwcz3mekMVimQf?=
 =?us-ascii?Q?piBVxhGeedo1zfAruiFpLdlkwP2EQnCuyEVS0xdlqauXRVGenw7/7sCuB/3t?=
 =?us-ascii?Q?WFCxXBlurTPQ/lmH1NZtK5wLlz+BPHkPaXG0vZckvS3KBDRQiBRJE6mj7slC?=
 =?us-ascii?Q?ZDuzzGVZMaHyUKlVZInUiHy4H46Ezc4UfdIEhHrtOIqYMk1DVv1Le33Xb0Rs?=
 =?us-ascii?Q?egaXKXkBc8e6nekajYSiiyLVt/A4qAiQUTZGAUqLDd6lEWZfvnXdk3Bgr/Ic?=
 =?us-ascii?Q?Kv2zuEiVzQhZdxddGtJnur+9TGz/Y6WXcBFQYYGUkZPt7DymzsqaY/cIUt5O?=
 =?us-ascii?Q?aAFZBdiHPHRqp+pESHtjShuwLM/z2dk9jQD51A72eZtfBCCve8CC1FS9G3To?=
 =?us-ascii?Q?WPiIymFh9qOfCGT5KwbHWZL8yeNnZRibFZLgmhwV/d0ksQcmY503VWLMOyTy?=
 =?us-ascii?Q?EaQDvmXsfUp2bneasGDUDVGcyPqEPmbnlk/oEsDCKMLboXx6Ixh36p2Po9GT?=
 =?us-ascii?Q?8Y1C1tHz138GU07P3VwinxGoEtKFUsOyAcf1U8X2DrOnbJhRdNcu65N4+TAF?=
 =?us-ascii?Q?bxYfUnyHfnHyKEh5YjXCpIocuL/a/0aZx8qpq1kUEY3vd7y+XvTp+q7aITOp?=
 =?us-ascii?Q?/MyEBwWUf1eQBxwY93wpjs97UXZ2BFKF+8T1spIEFbfZhVhGA3qYxwIBwsmm?=
 =?us-ascii?Q?Ja/KpYNVG2hRpQIqROd45AtIQygT2wIupwvHLUDj0YJV+U9D3Ajb3PhWeLKc?=
 =?us-ascii?Q?O5mMQp+VISL0fSlaNvUIl9depUzveGRn7UhMqB1sJEENN7gCm7aoGjTbOp4V?=
 =?us-ascii?Q?uRGXTEUfPi+tZ/NaSze76hDiyPVbDbNNY3DOKXmqdG9pHhfhakusTNGQdvX0?=
 =?us-ascii?Q?8EgoFz2QeaVgp1ycGswmSxBvJencR/bB4uA7loueVWAa44m16JXMgc7eKewL?=
 =?us-ascii?Q?o6V8BmvKO4a27AJa5Ktub42N5FYa3ybGp4p3bAs1cWf6dDodbQgI5cjmiyDk?=
 =?us-ascii?Q?87vhPjUcrwCTP2/hSfT6QIshui68RduEFQjrflRybYGT8ZPYcYbuQrg1wA+8?=
 =?us-ascii?Q?CTOThfYi7kIX4ruMk7vPTUOvxyDE95XPFm0h7kA/r05pRdCo9L+WEXGkXZHn?=
 =?us-ascii?Q?GYSof2RyvrXpjRaRR5K+0eHkIDbrPPz8E/6iBXeoxSQ5EjQRQbMjaOlZWgZn?=
 =?us-ascii?Q?5QLpLWb0XdZMdNUeJpTpAqghRwJ4M8tl/gA2Loo+nuj6+7KkiDHuHw9HyQkH?=
 =?us-ascii?Q?XHrFKl65vtirp820US9TX/Gmr6/NYYK6iPRWpR0SZJAjpmqXfQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 19:33:01.4993
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35f384c9-b95d-425c-191b-08dcf787560f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7229

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
Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
---
 arch/x86/virt/svm/sev.c | 144 ++++++++++++++++++++++++++++------------
 1 file changed, 100 insertions(+), 44 deletions(-)

diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index 9a6a943d8e41..b705c726e913 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -31,10 +31,29 @@
 #include <asm/iommu.h>
 
 /*
- * The RMP entry format is not architectural. The format is defined in PPR
- * Family 19h Model 01h, Rev B1 processor.
+ * The RMP entry information as returned by the RMPREAD instruction.
  */
 struct rmpentry {
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
+/*
+ * The raw RMP entry format is not architectural. The format is defined in PPR
+ * Family 19h Model 01h, Rev B1 processor. This format represents the actual
+ * entry in the RMP table memory. The bitfield definitions are used for machines
+ * without the RMPREAD instruction (Zen3 and Zen4), otherwise the "hi" and "lo"
+ * fields are only used for dumping the raw data.
+ */
+struct rmpentry_raw {
 	union {
 		struct {
 			u64 assigned	: 1,
@@ -62,7 +81,7 @@ struct rmpentry {
 #define PFN_PMD_MASK	GENMASK_ULL(63, PMD_SHIFT - PAGE_SHIFT)
 
 static u64 probed_rmp_base, probed_rmp_size;
-static struct rmpentry *rmptable __ro_after_init;
+static struct rmpentry_raw *rmptable __ro_after_init;
 static u64 rmptable_max_pfn __ro_after_init;
 
 static LIST_HEAD(snp_leaked_pages_list);
@@ -249,8 +268,8 @@ static int __init snp_rmptable_init(void)
 	rmptable_start += RMPTABLE_CPU_BOOKKEEPING_SZ;
 	rmptable_size = probed_rmp_size - RMPTABLE_CPU_BOOKKEEPING_SZ;
 
-	rmptable = (struct rmpentry *)rmptable_start;
-	rmptable_max_pfn = rmptable_size / sizeof(struct rmpentry) - 1;
+	rmptable = (struct rmpentry_raw *)rmptable_start;
+	rmptable_max_pfn = rmptable_size / sizeof(struct rmpentry_raw) - 1;
 
 	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "x86/rmptable_init:online", __snp_enable, NULL);
 
@@ -272,48 +291,77 @@ static int __init snp_rmptable_init(void)
  */
 device_initcall(snp_rmptable_init);
 
-static struct rmpentry *get_rmpentry(u64 pfn)
+static struct rmpentry_raw *get_raw_rmpentry(u64 pfn)
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
+static int get_rmpentry(u64 pfn, struct rmpentry *e)
+{
+	struct rmpentry_raw *e_raw;
+
+	e_raw = get_raw_rmpentry(pfn);
+	if (IS_ERR(e_raw))
+		return PTR_ERR(e_raw);
+
+	/*
+	 * Map the raw RMP table entry onto the RMPREAD output format.
+	 * The 2MB region status indicator (hpage_region_status field) is not
+	 * calculated, since the overhead could be significant and the field
+	 * is not used.
+	 */
+	memset(e, 0, sizeof(*e));
+	e->gpa       = e_raw->gpa << PAGE_SHIFT;
+	e->asid      = e_raw->asid;
+	e->assigned  = e_raw->assigned;
+	e->pagesize  = e_raw->pagesize;
+	e->immutable = e_raw->immutable;
+
+	return 0;
+}
+
+static int __snp_lookup_rmpentry(u64 pfn, struct rmpentry *e, int *level)
+{
+	struct rmpentry e_large;
+	int ret;
+
+	if (!cc_platform_has(CC_ATTR_HOST_SEV_SNP))
+		return -ENODEV;
+
+	ret = get_rmpentry(pfn, e);
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
+	ret = get_rmpentry(pfn & PFN_PMD_MASK, &e_large);
+	if (ret)
+		return ret;
 
-	*level = RMP_TO_PG_LEVEL(large_entry->pagesize);
+	*level = RMP_TO_PG_LEVEL(e_large.pagesize);
 
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
@@ -326,20 +374,28 @@ EXPORT_SYMBOL_GPL(snp_lookup_rmpentry);
  */
 static void dump_rmpentry(u64 pfn)
 {
+	struct rmpentry e;
+	struct rmpentry_raw *e_raw;
 	u64 pfn_i, pfn_end;
-	struct rmpentry *e;
-	int level;
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
+		e_raw = get_raw_rmpentry(pfn);
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
 
@@ -358,16 +414,16 @@ static void dump_rmpentry(u64 pfn)
 		pfn, pfn_i, pfn_end);
 
 	while (pfn_i < pfn_end) {
-		e = __snp_lookup_rmpentry(pfn_i, &level);
-		if (IS_ERR(e)) {
-			pr_err("Error %ld reading RMP entry for PFN 0x%llx\n",
-			       PTR_ERR(e), pfn_i);
+		e_raw = get_raw_rmpentry(pfn_i);
+		if (IS_ERR(e_raw)) {
+			pr_err("Error %ld reading RMP contents for PFN 0x%llx\n",
+			       PTR_ERR(e_raw), pfn_i);
 			pfn_i++;
 			continue;
 		}
 
-		if (e->lo || e->hi)
-			pr_info("PFN: 0x%llx, [0x%016llx - 0x%016llx]\n", pfn_i, e->lo, e->hi);
+		if (e_raw->lo || e_raw->hi)
+			pr_info("PFN: 0x%llx, [0x%016llx - 0x%016llx]\n", pfn_i, e_raw->lo, e_raw->hi);
 		pfn_i++;
 	}
 }
-- 
2.46.2


