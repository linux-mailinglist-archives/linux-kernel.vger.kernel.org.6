Return-Path: <linux-kernel+bounces-334784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C74997DC18
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 10:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B198F282708
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 08:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A5214F9F8;
	Sat, 21 Sep 2024 08:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ARn3heeN"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D162F14293
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 08:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726906517; cv=fail; b=osX1/aOBe8Y30mly9AJ/KsQUInp/F64z36k6dd/uomDaP2YRrog+9jP/qJrVN7vkcLhFofYwBMC0/WPsKagrof6m7tcZ4NtSmiYs0ElKsafd+foZoWYmiKQA0YvC+9uHo7+kt/0I9T90L37XPYVH3x2a+oYFW7IyOuuEw86jfuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726906517; c=relaxed/simple;
	bh=4M3Lt9EsTky63UBwAlK/TYBDpAsDeTYk/vU9/2ANsGE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=NiLgFwbuMfAew531IobmvKcYhyKW2pCc+PHf4GRnUl/SYp3ptXQBB27GnKN2ktcaFgcL+dC+1oCi04p/5lT0o89Dj9bv3nlq6We6ybJ0Cc+PxnFuv9t3yoRISIinpj1pJweUmp/1jL1IJ1oPIJAqOhkD8Tb58NYCYqw77J790lU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ARn3heeN; arc=fail smtp.client-ip=40.107.237.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X+UxsLdHScMEMS/LJsda3+5mSkYlApRV7O3Y9MP1AjJFZo0jJZ0JSUqtIGk786P77ZuFKJdY9uzKzIGpcennrCS9o93xp7123D10AN3gcpyFysNldW4cq5NbgysQBjb8WSu1M+cOVY/WoO6TbhVc1vcoY+mfRO7Mw4DCXNpT5q9jW5DL5lT7gx0fU5FPPagVJ3r3gAC9yxp5P2fRLgfYguBOY7UuzJyFkNDkEx0fN8Pi324rlk+4QEYhW+uvHmqEbaRZiFn8IX/LY9tAAv9dDxraO9QwtmvCBhAU1bu9N8zYZKOZrRHet7xDkokZZp48CLqcQZtAKlci3WwFkEtChg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CFm6qNHqopUsUpm1NhBab+Mj4g+F25KVgHXNRlz44fQ=;
 b=I6NcuatRbH1zCA61cwYiYhlMCOnp+DGWtMTRrk+noInRwIrM9llsm3HTWL0qw8xOP0OwmYgtvCpKZhW3bSUSdDZtVMAmUSJ1lJYuykOMbZJy842TM+yyn4TMO+x/NiscOJGg5DBVBXMoiYEI7JUPbUjTz4Li3UNQhmmttuE7G0cfFWRdjzMoLSyssE2gfITD0/6zwaCTmzTwStsKPSzga8X4nURTFZblirH06mwbclsI44Bl9W8IRsiQPRXZerDqQ5VfccM5EigntAzn/UAzwBYN4GMXDUTz+Bg9tPWniMx6o2EQCGggP2bSjeOCuc6a6vZON9eHcUaR78kAuG97Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFm6qNHqopUsUpm1NhBab+Mj4g+F25KVgHXNRlz44fQ=;
 b=ARn3heeNKSrZLtUC3htoPDipdEW649q+KgrxJwFjhCeVxfWhQpbXQf0e2BRVSerMSZcf0q9uvlvwRk1TNyPSB533jicF2OJjiAU8M4aL6UfWPq7OOXcILyMNjmtVPfeebJYQShpHgh6r6LEuk/eqljMsEMQYm1u4xVPk+MTMxtlB21G9macCktKkZtvSb4loRwopwjqSB9OPCkBXB5LU4MJvncyvEPlE5Rd8rQ3I+INR4YO4QwgZkLfKzXFjtL7+iIkEM/r3sUnjNmIV10r+jBvJZO3uLqgjlK8A9DoNjLWFtUa5t4Nenoq9nabgFkr9e2g8PjkjGCmpcnbKFKOUmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7261.namprd12.prod.outlook.com (2603:10b6:303:229::22)
 by SJ2PR12MB8133.namprd12.prod.outlook.com (2603:10b6:a03:4af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Sat, 21 Sep
 2024 08:15:12 +0000
Received: from MW4PR12MB7261.namprd12.prod.outlook.com
 ([fe80::d231:4655:2e3d:af1b]) by MW4PR12MB7261.namprd12.prod.outlook.com
 ([fe80::d231:4655:2e3d:af1b%4]) with mapi id 15.20.7982.022; Sat, 21 Sep 2024
 08:15:11 +0000
From: Bruno Faccini <bfaccini@nvidia.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	akpm@linux-foundation.org,
	rppt@kernel.org,
	ziy@nvidia.com,
	ttabi@nvidia.com,
	jhubbard@nvidia.com,
	Bruno Faccini <bfaccini@nvidia.com>
Subject: [PATCH] mm/fake-numa: per-phys node fake size
Date: Sat, 21 Sep 2024 01:13:49 -0700
Message-Id: <20240921081348.10016-1-bfaccini@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW3PR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:303:2b::29) To MW4PR12MB7261.namprd12.prod.outlook.com
 (2603:10b6:303:229::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7261:EE_|SJ2PR12MB8133:EE_
X-MS-Office365-Filtering-Correlation-Id: 205c3f63-f799-4892-927c-08dcda158382
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cUgW2OZFaVZDqYxtPTlWVLgkJy8yVcB4BcY5S6dHxnvpWYCnAU+rTdVNf1DF?=
 =?us-ascii?Q?NAjUU0m6cjbdcHukv8ueYaoh0nBksZJdfYAGGGstE+Kud9kNpVfF7tJPsNQ5?=
 =?us-ascii?Q?pX5iEO2SobBVDXR99DY62yMCQCyuiwOPmoWsd9fokb9WL4UJKBGCSLz829hq?=
 =?us-ascii?Q?TwGQv5ExrvN2HgBsfm+ANFC19psPGkkuxV2T7Z3xYvxlCzdNMiCcrUp+drd3?=
 =?us-ascii?Q?tiWVlSBzowDJ0fX95DWk8wxpFqeQ0A79dhG7lJdKufr3tadO6+cv4285gXwI?=
 =?us-ascii?Q?ao43wF5Meaup6RQKaYkVOnyxoYYtmQTypQvDvwRmOJjht6l04xscVI+A3c6U?=
 =?us-ascii?Q?2Wt8y2lQViXWVCDV/QrNfuurRyPI9fUXabkwPO9dirvyT+ScO2bxftu3aMy8?=
 =?us-ascii?Q?H9FcJXjrYJt5bMDbY8cYJf/rKHI63eR9vWWmSJ+TSdp/rqqex046Rx4+6DmF?=
 =?us-ascii?Q?XlTD0beYF18Zqlqu8lPESmzCbSFEvcmE+7Dt2Q3ZZ7NQv0CmAHkZO0WsoSYy?=
 =?us-ascii?Q?2if6KuIU6btGIEjoPsTS7ymWqte/VCYmSfomaDRKvsV9ri0e8Tnl2b8h7FuM?=
 =?us-ascii?Q?b7Ql4T06giIA1FwY2UiYfzSO3d8zkHoUoPQU594Z4Cm2OeaXtC8qf8YkV/eR?=
 =?us-ascii?Q?Q+YbMGH0yrVZtiCoLQaLNfU4v8MPPt1SpnAAGEtyPseowslkNQ5N8q2EwIOb?=
 =?us-ascii?Q?o+AVQ0CGKxvjudEQSA+jd/6JjqR6L5caM4T7sqPY37FizOpM5Z8uh2N3aB8U?=
 =?us-ascii?Q?iKVYntV+Nd5DbV+gXPwXQa0YH8xlR6xpTYKzCWt4VPQ1NAXqKFnj2KJFI1Q4?=
 =?us-ascii?Q?cHNXA9QntT8gxhoNS361bXyJs7BmYaxvCQPpEa9A8MOgeI/kEbue+mF2wT1Y?=
 =?us-ascii?Q?ox48csCsf1+BL0pAKa8S9cUWqfd37Xi29CTncrDBGaq/j6QJifPEfHXhrNFW?=
 =?us-ascii?Q?9IQlioDkAty10La6h66bRPnH37qcG50s0YjfXAXBBAL97vQ59ACp3Gk6BwHo?=
 =?us-ascii?Q?P3USr7sfsGHZgQ28dzOX+IA5nsKwUWZJoZei5Va7lUfX9a2gprjLnEEr9sqT?=
 =?us-ascii?Q?iMICHA1sTfK3ApFc0YzDgMzF3cGWnlJ49Dllhz0VoTdjNDt+C/x1uLvFKuCE?=
 =?us-ascii?Q?7X1yZ1NRdJm/cWhgZxR670CxgrAHzAdsDhaZS7v9I888+wIED1Nqvr03m0kV?=
 =?us-ascii?Q?cCfGZ2Ql8tTig1zvcY1lRpaO/IkHi7fpnr5ySDHqFLsKNLUGM0BhJ82D+Mep?=
 =?us-ascii?Q?zoiLd0rlhLuwIupUJPAeNhqYkvIpNUbyrp7NF/XhnQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7261.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PfsLtrYjPAMTFFsReSHLszO0L4Cb5CIEqlmnzKwej+kd0s7KOeeMztKExJ1h?=
 =?us-ascii?Q?jpHTVw8N3pe4DjLTdRBG/R1OKKuNO0K5nBzszpZCyQkz/eBTL8jcAmD/0QWE?=
 =?us-ascii?Q?eRmO8/VbQbXOPhU0/T+SCkqF36ubynNcDfCNh4YTpOpgdR5oXqMXU3Nrs53W?=
 =?us-ascii?Q?sXjmyT8inNdCirtfVSpq+M6k57692KSr8egDWHHQrbknObv/Y8kH/tAlyPNl?=
 =?us-ascii?Q?/yiIaFuTG9s0fovwyskxgRErWSf6AFpzBvU13ilo2XbSqboa6CUN4tNdfnh+?=
 =?us-ascii?Q?BE86D2rgya0JKd+GNCvPBY73kh6SWxvyIoe5YLXwSp09iWujWyuhc3ySRk+m?=
 =?us-ascii?Q?RVed+mF6MkNQvwIMXNRX23gjl92sOlr/tUNeq5jD0Tkfvc3u77pzJAq4Kv/t?=
 =?us-ascii?Q?Y1WWge1gMgVxJgoeJtGleZyI0nJpQUEsgIObsnapifGmBYZV1IL87Q5UiRTH?=
 =?us-ascii?Q?0EmrgcAl0M7ntLIyu5SJCzWBelJT/1+kwJZzKiWt4dma3k4wLxNvkABW/4Q2?=
 =?us-ascii?Q?DeJie8R1agO6emKaBVgtg5Au4tX8M3Rt+wfDX34frumkXG2nur9cKe5QPtTq?=
 =?us-ascii?Q?zG9KumeaXt7LWNbJCB7WWjSb952O955+8y5K5ibgR0vVRViSq8eaxQSDkhAr?=
 =?us-ascii?Q?DP1mCLh+W9zCdiC4Qc+GhJxkPluDSY3r1T0DiBy1nL4kl/qDpl9cNo94EURQ?=
 =?us-ascii?Q?Lgrl2sJ/obil48+2EpXNs1RilWlVK0RzqTthW6aTz6WRX2jOoEj+kAQ/OjC7?=
 =?us-ascii?Q?5Cn12smAdQH/V0uS8lh/sa0KHRFBkfDAURHXXCbKCu4LV8pZr61CyyiLGwnF?=
 =?us-ascii?Q?lJQbjP3/nmrKDxWXMtlWGXgTbq8AliEVJNcI+Hm++YKKoG+1uvNh+TEW2vY+?=
 =?us-ascii?Q?XgQdGsnhl9UVlLlaIUgzHhNY5bmFS0d/AQt0W0Tr35OEA6VxBOpFytDRSqAW?=
 =?us-ascii?Q?mAUWSoL1HyOmgQyjDjrpGRqj3EYKOMj4ERcGV1MrUn5rQaPybtCr/D1DKEiQ?=
 =?us-ascii?Q?kmJemDIWkW9u80zTelhibZk6cfdhtJFFLY1v+Q4dg97I7eIN3ztwRo/6fuMy?=
 =?us-ascii?Q?ti47r8KnBigMreRoWWzl1Pnq7etnIikZhzaQzcR7COHPMgjKz+ZbCrazD3Gk?=
 =?us-ascii?Q?iCglH5KUCHO78dy/L3qq7sGs579mtqiNnHvCocvlDukLxOtMg/HqZmmgmoD2?=
 =?us-ascii?Q?uMh6Ls9fug68omXjVlE7lvUmwLINaFlVOCMuhSOMk5yrQN9rHEr1++RLFn13?=
 =?us-ascii?Q?Wmds/liVhpBorOQq16o9uzJ0TfbZyMFWxC3Q0z+oIpuNjeqtXwwh4Rh/J6lR?=
 =?us-ascii?Q?4ydXai36s35Jc4cDHR9g2vCg7BPrMq5CykM//6ta/vv0j3tzsaBCSEpa6r6Z?=
 =?us-ascii?Q?WmtGhlSAYbCIMGeLT5WvKu3uxLtFJHis9ECGhWeJBJEparzUz39wAoEhYRFN?=
 =?us-ascii?Q?D2M8KeYMsKQ2V3rCgnHxDTirzhifDT0EP9kvmE2yxIDQoiCJWWnO5J9eyeix?=
 =?us-ascii?Q?DMwrq9m45AKQPx8o3pll6cJOWfsIZ+D+VLT5scYXJ46xZ8a/BpbROZo0ZTfJ?=
 =?us-ascii?Q?+O0JneaHxFu90r1i2CuV24IwLMUSKML08bjt+a1C?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 205c3f63-f799-4892-927c-08dcda158382
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7261.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2024 08:15:11.6511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eA+q6RV1sDy3oGRk9KK34Bx1XuEYCbgsD0ELLZvokBR6+xdghWf+PYP4IQSlhbbQ518HSgl11ZFWSd2fjBt0+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8133

Determine fake numa node size on a per-phys node basis to
handle cases where there are big differences of reserved
memory size inside physical nodes, this will allow to get
the expected number of nodes evenly interleaved.

Consider a system with 2 physical Numa nodes where almost
all reserved memory sits into a single node, computing the
fake-numa nodes (fake=N) size as the ratio of all
available/non-reserved memory can cause the inability to
create N/2 fake-numa nodes in the physical node.

Signed-off-by: Bruno Faccini <bfaccini@nvidia.com>
---
 mm/numa_emulation.c | 66 ++++++++++++++++++++++++++-------------------
 1 file changed, 39 insertions(+), 27 deletions(-)

diff --git a/mm/numa_emulation.c b/mm/numa_emulation.c
index 031fb9961bf7..0c72c85cfc10 100644
--- a/mm/numa_emulation.c
+++ b/mm/numa_emulation.c
@@ -77,20 +77,19 @@ static int __init emu_setup_memblk(struct numa_meminfo *ei,
 }
 
 /*
- * Sets up nr_nodes fake nodes interleaved over physical nodes ranging from addr
- * to max_addr.
+ * Sets up nr_nodes fake nodes interleaved over all physical nodes
  *
  * Returns zero on success or negative on error.
  */
 static int __init split_nodes_interleave(struct numa_meminfo *ei,
 					 struct numa_meminfo *pi,
-					 u64 addr, u64 max_addr, int nr_nodes)
+					 int nr_nodes)
 {
 	nodemask_t physnode_mask = numa_nodes_parsed;
-	u64 size;
-	int big;
-	int nid = 0;
-	int i, ret;
+	int nid = 0, physnodes_with_mem = 0;
+	int i, ret, phys_blk;
+	static u64 sizes[MAX_NUMNODES] __initdata;
+	static int bigs[MAX_NUMNODES] __initdata;
 
 	if (nr_nodes <= 0)
 		return -1;
@@ -100,25 +99,41 @@ static int __init split_nodes_interleave(struct numa_meminfo *ei,
 		nr_nodes = MAX_NUMNODES;
 	}
 
-	/*
-	 * Calculate target node size.  x86_32 freaks on __udivdi3() so do
-	 * the division in ulong number of pages and convert back.
-	 */
-	size = max_addr - addr - mem_hole_size(addr, max_addr);
-	size = PFN_PHYS((unsigned long)(size >> PAGE_SHIFT) / nr_nodes);
+	/* count physical nodes with memory */
+	for_each_node_mask(i, physnode_mask) {
+		phys_blk = emu_find_memblk_by_nid(i, pi);
+		if (phys_blk < 0)
+			continue;
+		physnodes_with_mem++;
+	}
 
 	/*
-	 * Calculate the number of big nodes that can be allocated as a result
-	 * of consolidating the remainder.
+	 * Calculate target fake nodes sizes for each physical node with memory.
+	 * x86_32 freaks on __udivdi3() so do the division in ulong number of
+	 * pages and convert back.
 	 */
-	big = ((size & ~FAKE_NODE_MIN_HASH_MASK) * nr_nodes) /
-		FAKE_NODE_MIN_SIZE;
+	for_each_node_mask(i, physnode_mask) {
+		phys_blk = emu_find_memblk_by_nid(i, pi);
+		if (phys_blk < 0)
+			continue;
 
-	size &= FAKE_NODE_MIN_HASH_MASK;
-	if (!size) {
-		pr_err("Not enough memory for each node.  "
-			"NUMA emulation disabled.\n");
-		return -1;
+		sizes[i] = pi->blk[phys_blk].end - pi->blk[phys_blk].start -
+			   mem_hole_size(pi->blk[phys_blk].start, pi->blk[phys_blk].end);
+		sizes[i] = PFN_PHYS((unsigned long)(sizes[i] >> PAGE_SHIFT) /
+			   nr_nodes * physnodes_with_mem);
+
+		/*
+		 * Calculate the number of big nodes that can be allocated as a result
+		 * of consolidating the remainder.
+		 */
+		bigs[i] = ((sizes[i] & ~FAKE_NODE_MIN_HASH_MASK) * nr_nodes) / physnodes_with_mem /
+			  FAKE_NODE_MIN_SIZE;
+		sizes[i] &= FAKE_NODE_MIN_HASH_MASK;
+		if (!sizes[i]) {
+			pr_err("Not enough memory for each node inside physical numa node %d. NUMA emulation disabled.\n",
+			       i);
+			return -1;
+		}
 	}
 
 	/*
@@ -138,16 +150,16 @@ static int __init split_nodes_interleave(struct numa_meminfo *ei,
 			}
 			start = pi->blk[phys_blk].start;
 			limit = pi->blk[phys_blk].end;
-			end = start + size;
+			end = start + sizes[i];
 
-			if (nid < big)
+			if (nid < bigs[i])
 				end += FAKE_NODE_MIN_SIZE;
 
 			/*
 			 * Continue to add memory to this fake node if its
 			 * non-reserved memory is less than the per-node size.
 			 */
-			while (end - start - mem_hole_size(start, end) < size) {
+			while (end - start - mem_hole_size(start, end) < sizes[i]) {
 				end += FAKE_NODE_MIN_SIZE;
 				if (end > limit) {
 					end = limit;
@@ -169,7 +181,7 @@ static int __init split_nodes_interleave(struct numa_meminfo *ei,
 			 * next node, this one must extend to the end of the
 			 * physical node.
 			 */
-			if (limit - end - mem_hole_size(end, limit) < size)
+			if (limit - end - mem_hole_size(end, limit) < sizes[i])
 				end = limit;
 
 			ret = emu_setup_memblk(ei, pi, nid++ % nr_nodes,
@@ -432,7 +444,7 @@ void __init numa_emulation(struct numa_meminfo *numa_meminfo, int numa_dist_cnt)
 		unsigned long n;
 
 		n = simple_strtoul(emu_cmdline, &emu_cmdline, 0);
-		ret = split_nodes_interleave(&ei, &pi, 0, max_addr, n);
+		ret = split_nodes_interleave(&ei, &pi, n);
 	}
 	if (*emu_cmdline == ':')
 		emu_cmdline++;
-- 
2.34.1


