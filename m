Return-Path: <linux-kernel+bounces-378696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E37D9AD42A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 20:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 585DBB22DBD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 18:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845DB1E2306;
	Wed, 23 Oct 2024 18:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4ZCwXpy2"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26641D0946
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 18:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729708950; cv=fail; b=ROTGMgMyg60tp9HQNsYwEFkgE7sRrJCm1mHSzUbMccHGyrMLkylBh0RZ6ykAkNQv7W88i5NocvY6h9nwLax3Rh0Te7AXNV/Kg0SA3tjVJaBrY0XsKpE5IuCAjzb9xB/EvV46XHfERnEZgjn3KPDvrVeIGi3cG41VAXvjZA0uDP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729708950; c=relaxed/simple;
	bh=q4EG6OC9M0nXd9ln1FC0pONv7eW4Mp2m5VK8Pj0eWCU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gr6JvzJ+BkjWtlVkedJXZkVF+yxkPDGWxJA18jHrp0WxijPoWfh4XPJtiGw4nQTWk8XJoSllldM770eDwhqI+rYG94EIe4au1kNv8OBxfPTh3wSeuCQplTTbxSBjVoOVKq2n3R4ufjk2imaAv7rSyzlcN4n+q4e6lGtDiSuh/n8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4ZCwXpy2; arc=fail smtp.client-ip=40.107.223.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qLoq2aYnn1nmCb+gpqFmrXsA3mVIRB1pPjimSH81W01LpE85FmTYWNDS+vq6STFVY4fDE578xX1rAL46eyL+nQEuoT2YpAoAphzlRaEaw8ZJkP8ShxruGp9Q6om4ladeWyGTVrn1mnlT6kBtSJuT4tSLLvtCr98nqGUoWvG5vflrAdl7KVJrSCxnOQcDbtddyatGkVQlj+IK8M+/93TxfdqIKHuYo42aols/bSnGm1MzfFrk73V4UlPvSufto71HUnLZVPMDg8f16Kepi0wtGh6KT/LjPLKzHP4rUfE3BSoImaNVI0BjgvA0IKB3uSRDv2HDmCuZp3Gz3szd64Prug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qN4SI+znRN9Ayc03qvcVTJS2dp1keRN0IPq8CQigL8k=;
 b=es6MWrSmBy1zdjBb7JU0PIwdk9x/qweUCztetEJh1X/gEFIW14nRTzT2Dzg/TrPpDcHc7lJbYLl4tSDM2tOmQ3+Pm/tXgPyLniir4p+0NsItytCw/vSRdmMOnMpC5+riVjz3SEyHJoTwu8T+xHy6qtspsIGz7pumK9Mnq7lF24JwwbUeAewL+zr1QrYPBkMF4fqvk/p5+Io1MhHXMmtwQ5Bxpmp8x69sd5VD46IkOqpBJ5ZIo2aE7I3pBD5Q7fxUs2KFWB3va8TbMdCAAOi2hS9t6BTQfEHtEeZUfVeIinhcBsoOPdJqqzspSjkQccMG23ly8PjHoPvqasgDX5JENA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qN4SI+znRN9Ayc03qvcVTJS2dp1keRN0IPq8CQigL8k=;
 b=4ZCwXpy2H3pW7Oyx4igdqEOQ/UMbUmb5LWJwHeKficmr8aycz3ERuTm9PuHrrrPl1dqSa52NUoZ9/Hov1iiIFuF/s4yK/mD1WFICYaHdPTx17nnkKnp52qOiunmD5H7AlqtIWaFC0IbT3CfXbI0M/x+3DXflPIgtsDV1SATpXAI=
Received: from PH0P220CA0025.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::18)
 by DS7PR12MB5720.namprd12.prod.outlook.com (2603:10b6:8:73::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Wed, 23 Oct
 2024 18:42:22 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:510:d3:cafe::16) by PH0P220CA0025.outlook.office365.com
 (2603:10b6:510:d3::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.19 via Frontend
 Transport; Wed, 23 Oct 2024 18:42:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 18:42:21 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 13:42:20 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Subject: [PATCH v4 1/8] x86/sev: Prepare for using the RMPREAD instruction to access the RMP
Date: Wed, 23 Oct 2024 13:41:55 -0500
Message-ID: <5e8bbb786f0579b615a5b32bddbf552e0b2c29c8.1729708922.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1729708922.git.thomas.lendacky@amd.com>
References: <cover.1729708922.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|DS7PR12MB5720:EE_
X-MS-Office365-Filtering-Correlation-Id: c47e8ca9-ce95-456f-e0e7-08dcf3926e31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HBMusg+3gUzOvUeBIZAxzqxRXt8bxXZY1sm2EtI8SApqLBNsAJKk3DoPFH0h?=
 =?us-ascii?Q?7HBWiscOiqZMPCIv+2XeJ0u3cPliYcWHwt8PYsqKWnnv2S+nsGFjoRFkCxiU?=
 =?us-ascii?Q?NSdPlO5wAeEyl6MlRXjDUJax7oISnwrAWYNZ2oS+43WlIAMDtvwer5lndvDn?=
 =?us-ascii?Q?IUo9qnVxwyYtlsst313vqsdFj4SpenXwhvBf0MTzvwPB0Up62i54h1/BOVr0?=
 =?us-ascii?Q?Qj70y+0GZNYLTRedJ2Nf4i+PQEBRb1WIP3m81xLi6DpbgvGtE6DoaFedOwAv?=
 =?us-ascii?Q?CHa3A6IPKimp/KX9SN2e829ohGJ7TO0sDhqjY3PIgXlBzXF953/VKs+NY2uk?=
 =?us-ascii?Q?5WYfJ1agzzKBn1UXo6dYIK2HGDXOJfEAXIgUWxEbDhs7g3tzI1sAw43YimfK?=
 =?us-ascii?Q?VqlDy5zXysVXSJaU1e+FL4/1ZqmEN2nHnmK79n+KutffwoxPZ8A/7+0qiAFP?=
 =?us-ascii?Q?cGHLsSMKftyu4b0S0tNzznFiObUDtGP6ZoS6CasBFAq6vR+m2sQKDYYIAg1H?=
 =?us-ascii?Q?2yYmcIZmOQ7xyqE5lz60CMED1ybuJKcvXCRBltbqN9vFwzneXS4wvIBxKa06?=
 =?us-ascii?Q?oCaKhtiXO6CEqMD3UtZ722H2JJPm+jK4yjyRyj37SUA3lJlkCt9FMM1sPEpJ?=
 =?us-ascii?Q?aRZ8CvEhtSb6HwPuqScSvnd2RS5k+5DF/McqrxJ1wHe97/GiDAekVUZ14YII?=
 =?us-ascii?Q?x0oqWHOilA7KmXCJn41QeOXSPNK6wyzrOcQ3Ggrl+tcskSiRVcfEP4hyrLGE?=
 =?us-ascii?Q?BN2PSoFfLlfuLl6Gb9ELdm31X/Q5eobcQhMIx6KvWFj6FQl1Bn/cCjWwJ2s3?=
 =?us-ascii?Q?4g1mj/V2Hao1tPSkWxZFvM9VvYcaLzcbriayDod2k6eGveqIQCI9P1xeqwgh?=
 =?us-ascii?Q?PdS8DUg9HoasxtXhsRDWt8fVlHWp/X2ZAmCge0R9yYyiNtNldDlxk+r50Wup?=
 =?us-ascii?Q?v5CP16aKWM3IG8xnf3FZS/xwCalWgKPOQ+593SC3e11U7hnLghAQSntGKTpC?=
 =?us-ascii?Q?q7TVfIc9TQlLYkxwFtwhtwjTiaRJUsza4zEa+kNmrNdVzcY3nc2Va4+Il7pU?=
 =?us-ascii?Q?rk5+xPoJO61Te+l3JKBkMgNCSLmgRD5vw0cW9mtG/Wju/UrxyhYUaoay0ZmZ?=
 =?us-ascii?Q?jspeJ/Q+IVoMt6u6pf/WfgGjPIUIbP2ltnlReEc3nIj18wMc8KEJF9TgTfwD?=
 =?us-ascii?Q?fHgh9NHntEs5YMNyGf9EDKjpRdNmhOg2UdtTXXi6cSug7OmpEltxUQFrSW/j?=
 =?us-ascii?Q?U+MASXn4Adbrovzins/idPNT2tfbom5/nm20vWM7c1EgoHfMoHxZe0dCVuKL?=
 =?us-ascii?Q?0F24JYCJmdWUXTGoGV9VrieDUCtNtHCRizsmDiPknwjZEZOw5CQDgx0cVmCe?=
 =?us-ascii?Q?0TzZlANEgZjLuKM1C/AFGJn4JQzQ2vlEIBKpz6cZSxutBHkWXQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 18:42:21.7586
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c47e8ca9-ce95-456f-e0e7-08dcf3926e31
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5720

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
 arch/x86/virt/svm/sev.c | 121 +++++++++++++++++++++++++++++-----------
 1 file changed, 87 insertions(+), 34 deletions(-)

diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index 0ce17766c0e5..4d095affdb4d 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -30,6 +30,22 @@
 #include <asm/cmdline.h>
 #include <asm/iommu.h>
 
+/*
+ * The RMP entry format as returned by the RMPREAD instruction.
+ */
+struct rmpread {
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
@@ -270,48 +286,77 @@ static int __init snp_rmptable_init(void)
  */
 device_initcall(snp_rmptable_init);
 
-static struct rmpentry *get_rmpentry(u64 pfn)
+static struct rmpentry *__get_rmpentry(u64 pfn)
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
+static int get_rmpentry(u64 pfn, struct rmpread *entry)
+{
+	struct rmpentry *e;
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
+static int __snp_lookup_rmpentry(u64 pfn, struct rmpread *entry, int *level)
+{
+	struct rmpread large_entry;
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
+	struct rmpread rmpread;
+	int ret;
 
-	e = __snp_lookup_rmpentry(pfn, level);
-	if (IS_ERR(e))
-		return PTR_ERR(e);
+	ret = __snp_lookup_rmpentry(pfn, &rmpread, level);
+	if (ret)
+		return ret;
 
-	*assigned = !!e->assigned;
+	*assigned = !!rmpread.assigned;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snp_lookup_rmpentry);
@@ -324,18 +369,26 @@ EXPORT_SYMBOL_GPL(snp_lookup_rmpentry);
  */
 static void dump_rmpentry(u64 pfn)
 {
-	u64 pfn_i, pfn_end;
+	struct rmpread rmpread;
 	struct rmpentry *e;
-	int level;
+	u64 pfn_i, pfn_end;
+	int level, ret;
 
-	e = __snp_lookup_rmpentry(pfn, &level);
-	if (IS_ERR(e)) {
-		pr_err("Failed to read RMP entry for PFN 0x%llx, error %ld\n",
-		       pfn, PTR_ERR(e));
+	ret = __snp_lookup_rmpentry(pfn, &rmpread, &level);
+	if (ret) {
+		pr_err("Failed to read RMP entry for PFN 0x%llx, error %d\n",
+		       pfn, ret);
 		return;
 	}
 
-	if (e->assigned) {
+	if (rmpread.assigned) {
+		e = __get_rmpentry(pfn);
+		if (IS_ERR(e)) {
+			pr_err("Failed to read RMP contents for PFN 0x%llx, error %ld\n",
+			       pfn, PTR_ERR(e));
+			return;
+		}
+
 		pr_info("PFN 0x%llx, RMP entry: [0x%016llx - 0x%016llx]\n",
 			pfn, e->lo, e->hi);
 		return;
@@ -356,9 +409,9 @@ static void dump_rmpentry(u64 pfn)
 		pfn, pfn_i, pfn_end);
 
 	while (pfn_i < pfn_end) {
-		e = __snp_lookup_rmpentry(pfn_i, &level);
+		e = __get_rmpentry(pfn_i);
 		if (IS_ERR(e)) {
-			pr_err("Error %ld reading RMP entry for PFN 0x%llx\n",
+			pr_err("Error %ld reading RMP contents for PFN 0x%llx\n",
 			       PTR_ERR(e), pfn_i);
 			pfn_i++;
 			continue;
-- 
2.46.2


