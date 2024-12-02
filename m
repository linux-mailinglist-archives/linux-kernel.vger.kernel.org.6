Return-Path: <linux-kernel+bounces-428359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7AD9E0D53
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 21:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAFB8282811
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 20:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7541DEFF4;
	Mon,  2 Dec 2024 20:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="K+7iqLJk"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BBC1D9A6D
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 20:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733172681; cv=fail; b=F5r9lcXo8PQibZrsWnfRojwxYGQ9L2Idor8ks64g8uQDFkWFqa9LiXjz6gGLnjpGLEaFs2TtH/vf2VWybT/rBo3vY8Tdkaa0fFs3yQ2v7PNnEgQt2lxHX1Lvl70C0k0WFlW7EDk6B7vMlcnOUaMcR2Zs0XSLptbVanZBVlmDbcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733172681; c=relaxed/simple;
	bh=/FufNDcq7KiOSFBU6it/sgFVuim5GISwAQWFpNuEJys=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q9JW39nNNih8PcuLy3iC9rMw6sj+x5tnhVYmBFeLKWaGLjtYuWWKVzxWLVjskqwAIW7AGrwFj3eY+RLPgnacBr1rGb/pj6dxPnHNJZDBYTp/jJNGXZMqjMUBJ39SLSrOqEay050XF/AiumswlGegfFBMYBhQr+gNk4KZwnaDcUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=K+7iqLJk; arc=fail smtp.client-ip=40.107.94.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lzg07qnYpph5jbeOF9to6cPrWoToa9HQobXBrJO8wu8kX/RecD4cyPd4/if7fR4zhFhtQsvEITimimBtabJX445d1eDAs050I8ajrM6QL5+pINUeefJ5cGim9+upKVncjCMS51h/vg05pNjQsA2wIDqoh+srzSbMZ5Eq0BFqnI5YVsauvAVFUUxaqj9dssOOLy047rxfp/IAFW02FGM5RtMcEjQIhx9iik0v5eKZP5/6sr3N1RZNYhDKaWWBws7iTktkX+BklLz8d0M6bKwnU8tmH19Z9fI7XPadzhmHAO9FvWkNLyEqG6kXJqZtMr1g65XDekj2bV1tOsN1XND6oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TcFLDC422QBmwAMC+SB7L8vLVLVAB6fF3ocs/a4QVdg=;
 b=C211IoCALW50fXu9KBeVeIcc/4npdeAy1wJM1TB388NlQs2KiVk7XSKet/I9CDd11j7UZM/xNG387WwGHThZlF1oqju29Kz5upwoEKnz962wUukdFqR/Sp4iawpZ5/xIOsrjtcYzi2WBYT1rBxYPWLmpgUDvZkVVz32aQgZb7bOKrSNjbP17AMUQGkjmYX9joouchot1d5RvAs0eqR7CmLUk7SdGxfjXCv5wnpEUROQOOlXwsxSHmgXLRZwWqU+gz16fzS7VJFUJb+cy4DheBrKmhcK+Yncxay4cA1zUbdYYDngDj3hoxXMeC5MdSTr1Gs2XDeR031P/s489vIl5mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TcFLDC422QBmwAMC+SB7L8vLVLVAB6fF3ocs/a4QVdg=;
 b=K+7iqLJkKggrFiVvourZH141EkzYh/pAwf55XneGXxaQWF0jjyCNBVCokaTKIFv3a1eW5e+cG1bvyA0LYBq8QMF32jvYTz70mktiySPlE3QTDmwInCxxbvMQqhHkpm13kKMrLoRgdMSJrKRRHcVRK52MhvqMaOsZ5eGPrN16/eU=
Received: from SA0PR11CA0119.namprd11.prod.outlook.com (2603:10b6:806:d1::34)
 by DM4PR12MB7527.namprd12.prod.outlook.com (2603:10b6:8:111::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 20:51:13 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:806:d1:cafe::2a) by SA0PR11CA0119.outlook.office365.com
 (2603:10b6:806:d1::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.17 via Frontend Transport; Mon,
 2 Dec 2024 20:51:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 20:51:13 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 14:51:12 -0600
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Subject: [PATCH v6 1/8] x86/sev: Prepare for using the RMPREAD instruction to access the RMP
Date: Mon, 2 Dec 2024 14:50:46 -0600
Message-ID: <da49d5af1eb7f9039f35f14a32ca091efb2dd818.1733172653.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1733172653.git.thomas.lendacky@amd.com>
References: <cover.1733172653.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|DM4PR12MB7527:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c9d0bfc-aa9d-456a-79af-08dd13130ede
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4LWCSeI5bHduxvGeXOozACncJgcZDYHg21q0vTPOuZvSbHKSQkMZa9ws9QGt?=
 =?us-ascii?Q?d1Jxwj+GnPVUvAB8rc0PrOqI40Ng0na7ra9Cln3sm0ai+S/64bvf2FhcAke2?=
 =?us-ascii?Q?RfkRwrHgGfeEB3ok8MCYQmo3cojB+ePpmQ1ic7D97Lq75WjE+bpCswUsEG3+?=
 =?us-ascii?Q?dINxhVnsfARs7d5WkSxmp70nlx9Vrlsg0paPnY42DZSW+FFCUp/FtiWUd1Gj?=
 =?us-ascii?Q?q51ZT+lbsc+ZF5317CEANRQXyyuYmboDYDR/kfQVuVwFIX4QZvgmHhDDYYGS?=
 =?us-ascii?Q?Zjq8kYIDzSYNq/3qb+DwOpQTDrH8jHO44ws6XhC3ClQmZyWyzikoACTKSC7D?=
 =?us-ascii?Q?0QSdt++IocnWrxEZrEtCMbLJYdu0ipyDr+AoviaBHrN9T9ntlh0IJJ6CCSkH?=
 =?us-ascii?Q?8r9YJEExymQKOd6Dud5c3snrcAppl8G5rztKqlxSHNUdSUnb1GwajXyyxkFN?=
 =?us-ascii?Q?xGsDNRb2zmrmXbIT4RQaThQ4C9aZBdA3wclbyWRvMN6rBTH6UMUBD27HQoEC?=
 =?us-ascii?Q?iB5jK+hMA+CH5TR8BLiWNy9LlbsEFIUaIa0I3XTDIS2gI8qqMBo7JhHTTFFH?=
 =?us-ascii?Q?AxWV27aurlL6wil30BBGkPjWT37iY531cUI32Djo+UnhzbL8YGUhxZSMP6eQ?=
 =?us-ascii?Q?i043HrycRebgOrVXtTcXFnX7zgNpElll8P0ajfqD1KyDza2JUHxSxXkQ53EV?=
 =?us-ascii?Q?kgsC3dDun+8m8JVVvFlnvuK+ib5zWua/TwkyRMIRjUHt0c1E4o+wCigNicET?=
 =?us-ascii?Q?NDJd+Y0kNvQm7j6O0ybhzZyNG3UXLI19LuTkZUxTICeho9hUX5+4++jQ63Yu?=
 =?us-ascii?Q?DvyG3B1isWkgY/zDNsq8CoJgQgWFWxTQNV/yQLsArpsoADTNZvQBvNOp2xuN?=
 =?us-ascii?Q?pnjmcPEfKZJBWgwzFiie8RZlUVEWD/HQCntNgvIfLl8cbLHWOItJrtNaLwYk?=
 =?us-ascii?Q?0TXub2QzEN7D5STvGcHtraHrq87oO8l8zdClU+uWkgzDhjD3y3joyfNnLz17?=
 =?us-ascii?Q?Up1bWbV/2SEE584LtV68xtRBrdn95ir0Xc7pka+gmrBqJkw8w4E4ol3QB9nq?=
 =?us-ascii?Q?FkvN715qfy+ziA/VYqH1S8y8c7fuifq2585xS9atQap1f10ZVNBv2trMvoDy?=
 =?us-ascii?Q?tgHTkq1/yvGfssFUmGVYrZ28jyhLyOoaLt4pPOonZfqo9ZMpMEausx6czELg?=
 =?us-ascii?Q?7MIiAtE/J1/+hfPyrFHqlZBZMNqNk/AC3rSbOrlW0Mukzjh2hgYpJ0AGgioy?=
 =?us-ascii?Q?UigtkEzAlaokChHxPmOqX7ztF+ZUvLHeku5susXuh9bSBB6TKPT0APMduVUn?=
 =?us-ascii?Q?hU1MG81wqcSYgQMxodWkoe3ZSV6EkMr3SHOlI9LV+tSbGTJjsiNbecXQj5Qz?=
 =?us-ascii?Q?1DosvF2B/fdFGCtW9DP8Ar8QnrX9PsrH8p62xVQpE3L0/17771hDYyHXQmhs?=
 =?us-ascii?Q?5VbIHVLoqLT4erf/2aUaMgphD01Gpa35?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 20:51:13.0464
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c9d0bfc-aa9d-456a-79af-08dd13130ede
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7527

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
index 9a6a943d8e41..cf64e9384ea0 100644
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


