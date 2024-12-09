Return-Path: <linux-kernel+bounces-437247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8819E90D5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A09D71639B3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F33219E85;
	Mon,  9 Dec 2024 10:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Wxb6N9cu"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3D621764C
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 10:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733741220; cv=fail; b=eusJZTPxVph2rzZawRlYCUwz/qF4mQVwFdZYCI+RIc4OUHLoZcc6TghBOi2C+o12DpWMDOVYN7WBHb0xpItx6LoRN1iVGykaa4X7r48AKv8dAfYPIwNBoEyBp+3wnktBaxxRtMMwdxUl/k9wjYu54HBjCRxUgdOT2uy/cHNnM34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733741220; c=relaxed/simple;
	bh=/88HxKQywm5qjrCaflJTgev+5Q5ZGZE5mZixq2WZb/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rD7q8mMZMs5oLON89YD+3j9P0N7pyF5LnRtLlS5MnICPVnIUwN5yJHB6IBpV233v5YZ/qIHXNt8D/gGGl7KmQuqR/Mf+WhVdgP5sIMQG+UFF60jKso9+PMM7PkYZEDeD9+Ye/vSI0cPKqYzTHaGf0FdWrfLpN6mdLcqS2sCAJYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Wxb6N9cu; arc=fail smtp.client-ip=40.107.92.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QTutWtq24j0Zy2E7SO1/P2ueHF1ZxdWVViZtIR8UvmU9L5zCSbl2/qU3gBYxKipM3EWyq2WfDwW39OEYdj0BOXZrmDkFCjodY0/QX7m8FvmHUSXR5sSSFQhA2FM1AFMu1WMAyBsS1SSysOgQShBWDDlua+97nFFCxvduKuNh3Qq+NETKBm3VbFWMMflytJOgwnVc5xygL5y9WJ+GRYk+yEh4paRbZd/gFEwNdGsbLtrxmdi8wqgaP5NqLoMb0xpDgcj6P3AZdAPjiqrF/ovmh846wIZNBppHDFiEZYP07g4kurXl3jGhMUaCR5pwG07ZHiZuMHZQZRJ9MJJ/o2Bkww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=stQCG2dzogENcGuXZI3J7+lNKDYaE4YtYhdByu3ZDfY=;
 b=PxJNVB3Url+tI7xbPsjn39PQM80dOeOdBdWsLFHIKWFTX8DsQrnGyGfZxt4YO2xYiJI/FOmc725pjYe5KpGQW+OZAKd7gs9vfQsofFEv00AHU0iLBxgTujN71TL6bQElPyB+9BR0YirqFgN8pulcmRqj9sYhzXmDdGIFWM9OSbHri+MvJRlji55Bhh9HxpSULIsZYx37s7x4RLGPWjr5y55p2MFJOKiYVuyT5dG6dAvhTQ/6OLNrtgVZmg6zxQFElN+vKDFsqrOQm+UADlvp3QHc0K/cT/M6WCOuCuBrEtuMJbtCphX3QBMQStXfKQ4u9nFkRFaOCuxduxUgJOK02g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=stQCG2dzogENcGuXZI3J7+lNKDYaE4YtYhdByu3ZDfY=;
 b=Wxb6N9cuHtZr3Gz3G7cyh+BpKUP7I8C5rGkwDVo5RV02aQkooY1eBVDTdJwTxgxZkf0FIwhhEXCd0MHRo7jmEkCRnjLzTT5/DVX7nBnQrSkNg2x1nrLSqh9IaFlx8vCJ3D6s3Q0FC5WbOLG9HZaA0oCP1W/7kUStUK3I9itvNAnoaZY32a4BFTtVBQkc1kKKIHSi+Ddp0Giwia7oJOWwyUi2AZlS5NEsujmuqtj3wwrZC7POWvhuNM9+5rRvOXqN6a/jz8jdVaFeJO7lFZKZQuWA0vtGl9/XdQJtnpRLNBnjtIV2RODYiaUfrwvY8BhYDVd/bnEbmG1EI87ld0+vbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB6424.namprd12.prod.outlook.com (2603:10b6:8:be::16) by
 DS0PR12MB6462.namprd12.prod.outlook.com (2603:10b6:8:c6::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.19; Mon, 9 Dec 2024 10:46:55 +0000
Received: from DM4PR12MB6424.namprd12.prod.outlook.com
 ([fe80::8133:5fd9:ff45:d793]) by DM4PR12MB6424.namprd12.prod.outlook.com
 ([fe80::8133:5fd9:ff45:d793%7]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 10:46:55 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	Changwoo Min <changwoo@igalia.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] sched_ext: Introduce NUMA aware idle cpu kfunc helpers
Date: Mon,  9 Dec 2024 11:40:58 +0100
Message-ID: <20241209104632.718085-5-arighi@nvidia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241209104632.718085-1-arighi@nvidia.com>
References: <20241209104632.718085-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0205.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::14) To DM4PR12MB6424.namprd12.prod.outlook.com
 (2603:10b6:8:be::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6424:EE_|DS0PR12MB6462:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ec167a3-a95c-4895-d041-08dd183ecc52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fiB5KsJ/N5gNCuesTJziWbPV7fb1LnpwiSJtKdN7XP9DQtq+6bJEI7Tkx4Xk?=
 =?us-ascii?Q?dcGKcZyEyAXyMQOjCqLCPTJ7kEdDuSI9QSNpvv7fxdrKVvVy05sdtufu0+FD?=
 =?us-ascii?Q?qxP/8ki+uvKnPhqGw94ZGT7aBjgCz+i/S0taMiNu+bsVtpMCK4zvYGKRC+CX?=
 =?us-ascii?Q?sXm24ZQ9VwEKriJntk3FcLpZOUW46+y2DgHRh+NZRwoiOelwZv00q94PZ0nL?=
 =?us-ascii?Q?vHl44a6hcJCnzstxKVWf5vc0+p3Tvxk5tueTKLo8+VG4ZzX1Kz3WlLNyiCn2?=
 =?us-ascii?Q?HtK2shRZSAavMsQzJnpmMrGQWeAeBWFim6OkN2pyarwWEhr8kFbwKi+t7sZx?=
 =?us-ascii?Q?kzB/pQUYATMgbBJEECLf8M08Gbb99vK6uTRzD5ZmfQopkO2aGrKuAApjq56M?=
 =?us-ascii?Q?w41KGoAYL3b8qZoANgsNEOJeksWbNMVtTNkgaTHI2fwTJNARp5Q1ZqHdWDuV?=
 =?us-ascii?Q?vYSg0VQvrKm9w+c3d45k51w9kzf8O42A21uUFsMC+qo4OLGX4PPrg/JNuH/t?=
 =?us-ascii?Q?8tuRRNzi2wZpzPNEK6mfbV8d7Cxes9v9tLu2sKLYhXOecm8KTSGC6HWFW4Wg?=
 =?us-ascii?Q?n/d7c5fYPHdG7AmLWAjuY2QOt2gCz+136PkHyuI80l7Ngcxr6ddkb42vGCAN?=
 =?us-ascii?Q?6OGMEfkKrWJ+kh5ezDTns3e9yypHNbYKbvzw9Wp4X94Oi2Auy3VC8mUe/buI?=
 =?us-ascii?Q?Bs13YyQFp7pyPhE4Vd2jXEIn4mNX6xf4qzx/HBW+6oV3jJkDr+pA95xzdREe?=
 =?us-ascii?Q?VF3XeGy2tGN+4hQwARI6lv8syI0ryg8s3IcBw4KgE8AxGHtVIrJppT27L2Qt?=
 =?us-ascii?Q?kzhUDa9EMOETGFpywxGmMxm7NzI1Z/w11o7aC6js75oix0T5yL40q2+5dqYC?=
 =?us-ascii?Q?YMjE+jK/ByU65ieVdHlEZhahh4dizzOvE+QiXRVKqsnHPGBzk4oAdxYUt9Rn?=
 =?us-ascii?Q?jIsVmesM5yRizFe1Y04GMtmRK/9gkK0fzBEIKTOd5FdSn9FMQxTZfFE6Tf67?=
 =?us-ascii?Q?b9/13r/rVePEDFHVHLRs1aMd7B0nGu/GzUrJpRKeqEoesnQhDsNJNbJF5i4q?=
 =?us-ascii?Q?2v68f4vygbQ/6wexgqJjJvxmwPDLrGiW1S4w4LwomTBwe3h97w9bJWJlCZZd?=
 =?us-ascii?Q?a7t7xXrRZ62MZLxHkhCQPC7Ag1VXFZVbC06/lXOqFBF72eaw06ipLUNy8Vak?=
 =?us-ascii?Q?w8APq16e6cpI/FQZ6M6rq62btCVXuCv1wqbOqQ8BCDhQAHloajkK29Sv1mM4?=
 =?us-ascii?Q?SjGsMidHiV48BFveW9GKRtA+Fa7nT0pKu8r/M1rK2/eEj2+zBXcBa27K+vQd?=
 =?us-ascii?Q?4AeXuEEVjQ5pfFk8ohU0IZmPU8ACIgj7GuhR4edcRf093g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6424.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wbV7FReWrV028AHhE8vPtsTU0qcVkEafWpxfiZ378omaEriNM148pwkMeYgc?=
 =?us-ascii?Q?07a4rp/9H6TYljRdKKecMMpkb9pn7Hthj+T7ArM86xvxdfUX/lBhjrQdBjRg?=
 =?us-ascii?Q?KIXpD7US5f4rVl7jYLJSR6Yys7vg7yRgQXpfXrw14wA5QaBO32+nTvpsFMAB?=
 =?us-ascii?Q?YzzhShwvS64MAQA36wcDHlTDi0QIeqn/1Zm7eyaxym2HjwqZGcu0h7xi7gi3?=
 =?us-ascii?Q?fdRQhJKzpFfT7Fxmfn/Cycdv8Vk7R27kPPE4txHcWybjpjt/5gVZwHkWzBA9?=
 =?us-ascii?Q?91XqYzPYooiJUsbVYndD6eTRfylZJLF3k+lTauibOO4b3J6AyUh6YVf1S0w5?=
 =?us-ascii?Q?rQB/lN6mu/qL1sW+XClygco8rYWQ9LrzMIQ84x4PcG+HKCH/qPbPx1kEhHLO?=
 =?us-ascii?Q?fglb8//ecPelHsO/tA9DHEjBLV18Z/Nv264C2DE+v/9m6eL9ctA+bFL0OuTg?=
 =?us-ascii?Q?TiUV2fuDNYWN98aS46vsCPjyBVCmKIYHrT0p5nvhKlTSJTnlIJcgl6pDxnNi?=
 =?us-ascii?Q?sDQaI/l6SJOgdyYFoQQV/lD3OHU+t8vACFjuIuITLBnpF0jjWqfIaTkWdMCZ?=
 =?us-ascii?Q?bb4dTrUneEso1KC6iICmnhAfn+a0NUQla+V5j8pNi6v3PSvTNsnNTXed5VcF?=
 =?us-ascii?Q?SY8aNm4SNySkrkRc3+wtz1OSDnxhzGUZJ+RuwH+vDinjpTyC9vYB+enkodlT?=
 =?us-ascii?Q?ro/bB+7Vff9waq+tkNgyenfmKOXiN+OArnp7N/xqY/pNKRbb2lSasakXgoUs?=
 =?us-ascii?Q?IdbQH8UWQQ0KKZ0RxE0oU9T/NeP6iUcM614e1o+rgOvjC8n4xdG6blNBC+Ry?=
 =?us-ascii?Q?mY02mGIQ5eGrQnDFE6LnWyVTV/kej8LxiWeL6dVUnCGn49Ys1RidBR5ELB67?=
 =?us-ascii?Q?hfNMSJ8/6Mhag2R3P/D24o53O5RjjaNhf48HxwFQfDCBK9gDr0xQF+MEE7iM?=
 =?us-ascii?Q?7/BgmASVssO4dHxaqx9wZ7pMKLlz0W3pI/XLodMYHGC/9sSo+zSVY6c71/wF?=
 =?us-ascii?Q?b3cOwaoRsYh6IKyPW/ZPrI7hmUJGQeTItd70ePpXK6tTxey/M1pciFIpenfr?=
 =?us-ascii?Q?1Xlr6f+5WTjCn5KAs+A/xZfJkTlvq6oqEBIAoC8fcWc2ZLibGXPwx51gAVel?=
 =?us-ascii?Q?8NzSUSYnS5ZAgSB3NlYVqPucQw72DrW4L+SF312W+5KMh6C17JSi0w33KHvn?=
 =?us-ascii?Q?4aLhHpErA/vUdyxfreKi2PbdB7f7ql6iefwhgmSXmdulSWUGnk87ZwPneUGE?=
 =?us-ascii?Q?1Kca2jpeahEWkCEX4+hbZfPRLq1DXL+zCnbEDBkkqgh3fPO+I3B5aPzrDWPQ?=
 =?us-ascii?Q?3QzBPQkGAdG/OuUGrJOgB676EMlwFW5PNuHs21llphg//KKlbjId64L9jhem?=
 =?us-ascii?Q?kW8oC0RSXn8Ho7UPiVm8rWm6IDEUC5OFICZJVgsZtTpszf7UgtucSaw54L5Y?=
 =?us-ascii?Q?a/s1L7dbk+yS9XkHNGyN2rhQXUKI06RCv9F4WucVIZ7jePVI3zB39T9Ky/X/?=
 =?us-ascii?Q?EpJnCMiS6dhq1llqMr+aOyXKd+v3g7DrCOx0fp4blaVooqh6E0l+01dXC8Fn?=
 =?us-ascii?Q?9X9Jc8CVBI0NCkqAbM6DhDB1dMNf0DJgSVZvC++V?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ec167a3-a95c-4895-d041-08dd183ecc52
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6424.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 10:46:55.2907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mxzGvOxXHneVvYiyLJ2v3SmMYNASKbwshEIqI43TfkZOnVFOubCsdfbb01fmDk3SjEhWBz1BV6yHtwqRv65QFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6462

Add the following kfunc's to provide scx schedulers direct access to
per-node idle cpumasks information:

 const struct cpumask *scx_bpf_get_idle_cpumask_node(int node)
 const struct cpumask *scx_bpf_get_idle_smtmask_node(int node)
 s32 scx_bpf_pick_idle_cpu_node(int node,
                                const cpumask_t *cpus_allowed, u64 flags)
 int scx_bpf_cpu_to_node(s32 cpu)

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c                       | 96 +++++++++++++++++++++++-
 tools/sched_ext/include/scx/common.bpf.h |  4 +
 tools/sched_ext/include/scx/compat.bpf.h | 19 +++++
 3 files changed, 117 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index d0d57323bcfc..ea7cc481782c 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -433,6 +433,7 @@ struct sched_ext_ops {
 	 * - scx_bpf_select_cpu_dfl()
 	 * - scx_bpf_test_and_clear_cpu_idle()
 	 * - scx_bpf_pick_idle_cpu()
+	 * - scx_bpf_pick_idle_cpu_node()
 	 *
 	 * The user also must implement ops.select_cpu() as the default
 	 * implementation relies on scx_bpf_select_cpu_dfl().
@@ -955,6 +956,8 @@ static struct cpumask *get_idle_cpumask_node(int node)
 	if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node))
 		return idle_masks[0]->cpu;
 
+	if (node < 0 || node >= num_possible_nodes())
+		return NULL;
 	return idle_masks[node]->cpu;
 }
 
@@ -963,6 +966,8 @@ static struct cpumask *get_idle_smtmask_node(int node)
 	if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node))
 		return idle_masks[0]->smt;
 
+	if (node < 0 || node >= num_possible_nodes())
+		return NULL;
 	return idle_masks[node]->smt;
 }
 
@@ -7469,6 +7474,16 @@ __bpf_kfunc u32 scx_bpf_nr_cpu_ids(void)
 	return nr_cpu_ids;
 }
 
+/**
+ * scx_bpf_cpu_to_node - Return the NUMA node the given @cpu belongs to
+ */
+__bpf_kfunc int scx_bpf_cpu_to_node(s32 cpu)
+{
+	if (cpu < 0 || cpu >= nr_cpu_ids)
+		return -EINVAL;
+	return cpu_to_node(cpu);
+}
+
 /**
  * scx_bpf_get_possible_cpumask - Get a referenced kptr to cpu_possible_mask
  */
@@ -7499,11 +7514,32 @@ __bpf_kfunc void scx_bpf_put_cpumask(const struct cpumask *cpumask)
 	 */
 }
 
+/**
+ * scx_bpf_get_idle_cpumask_node - Get a referenced kptr to the idle-tracking
+ * per-CPU cpumask of a target NUMA node.
+ *
+ * Returns an empty cpumask if idle tracking is not enabled, if @node is not
+ * valid, or running on a UP kernel.
+ */
+__bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask_node(int node)
+{
+	if (!static_branch_likely(&scx_builtin_idle_enabled)) {
+		scx_ops_error("built-in idle tracking is disabled");
+		return cpu_none_mask;
+	}
+	if (!static_branch_likely(&scx_builtin_idle_per_node)) {
+		scx_ops_error("per-node idle tracking is disabled");
+		return cpu_none_mask;
+	}
+
+	return get_idle_cpumask_node(node) ? : cpu_none_mask;
+}
 /**
  * scx_bpf_get_idle_cpumask - Get a referenced kptr to the idle-tracking
  * per-CPU cpumask of the current NUMA node.
  *
- * Returns NULL if idle tracking is not enabled, or running on a UP kernel.
+ * Returns an emtpy cpumask if idle tracking is not enabled, or running on a UP
+ * kernel.
  */
 __bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask(void)
 {
@@ -7515,12 +7551,35 @@ __bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask(void)
 	return get_curr_idle_cpumask();
 }
 
+/**
+ * scx_bpf_get_idle_smtmask_node - Get a referenced kptr to the idle-tracking,
+ * per-physical-core cpumask of a target NUMA node. Can be used to determine
+ * if an entire physical core is free.
+ *
+ * Returns an empty cpumask if idle tracking is not enabled, if @node is not
+ * valid, or running on a UP kernel.
+ */
+__bpf_kfunc const struct cpumask *scx_bpf_get_idle_smtmask_node(int node)
+{
+	if (!static_branch_likely(&scx_builtin_idle_enabled)) {
+		scx_ops_error("built-in idle tracking is disabled");
+		return cpu_none_mask;
+	}
+	if (!static_branch_likely(&scx_builtin_idle_per_node)) {
+		scx_ops_error("per-node idle tracking is disabled");
+		return cpu_none_mask;
+	}
+
+	return get_idle_smtmask_node(node) ? : cpu_none_mask;
+}
+
 /**
  * scx_bpf_get_idle_smtmask - Get a referenced kptr to the idle-tracking,
  * per-physical-core cpumask of the current NUMA node. Can be used to determine
  * if an entire physical core is free.
  *
- * Returns NULL if idle tracking is not enabled, or running on a UP kernel.
+ * Returns an empty cumask if idle tracking is not enabled, or running on a UP
+ * kernel.
  */
 __bpf_kfunc const struct cpumask *scx_bpf_get_idle_smtmask(void)
 {
@@ -7569,6 +7628,35 @@ __bpf_kfunc bool scx_bpf_test_and_clear_cpu_idle(s32 cpu)
 		return false;
 }
 
+/**
+ * scx_bpf_pick_idle_cpu_node - Pick and claim an idle cpu from a NUMA node
+ * @node: target NUMA node
+ * @cpus_allowed: Allowed cpumask
+ * @flags: %SCX_PICK_IDLE_CPU_* flags
+ *
+ * Pick and claim an idle cpu in @cpus_allowed from the NUMA node @node.
+ * Returns the picked idle cpu number on success. -%EBUSY if no matching cpu
+ * was found.
+ *
+ * Unavailable if ops.update_idle() is implemented and
+ * %SCX_OPS_KEEP_BUILTIN_IDLE is not set or if %SCX_OPS_KEEP_BUILTIN_IDLE is
+ * not set.
+ */
+__bpf_kfunc s32 scx_bpf_pick_idle_cpu_node(int node, const struct cpumask *cpus_allowed,
+				      u64 flags)
+{
+	if (!static_branch_likely(&scx_builtin_idle_enabled)) {
+		scx_ops_error("built-in idle tracking is disabled");
+		return -EBUSY;
+	}
+	if (!static_branch_likely(&scx_builtin_idle_per_node)) {
+		scx_ops_error("per-node idle tracking is disabled");
+		return -EBUSY;
+	}
+
+	return scx_pick_idle_cpu_from_node(node, cpus_allowed, flags);
+}
+
 /**
  * scx_bpf_pick_idle_cpu - Pick and claim an idle cpu
  * @cpus_allowed: Allowed cpumask
@@ -7705,14 +7793,18 @@ BTF_ID_FLAGS(func, scx_bpf_cpuperf_cap)
 BTF_ID_FLAGS(func, scx_bpf_cpuperf_cur)
 BTF_ID_FLAGS(func, scx_bpf_cpuperf_set)
 BTF_ID_FLAGS(func, scx_bpf_nr_cpu_ids)
+BTF_ID_FLAGS(func, scx_bpf_cpu_to_node)
 BTF_ID_FLAGS(func, scx_bpf_get_possible_cpumask, KF_ACQUIRE)
 BTF_ID_FLAGS(func, scx_bpf_get_online_cpumask, KF_ACQUIRE)
 BTF_ID_FLAGS(func, scx_bpf_put_cpumask, KF_RELEASE)
 BTF_ID_FLAGS(func, scx_bpf_get_idle_cpumask, KF_ACQUIRE)
+BTF_ID_FLAGS(func, scx_bpf_get_idle_cpumask_node, KF_ACQUIRE)
 BTF_ID_FLAGS(func, scx_bpf_get_idle_smtmask, KF_ACQUIRE)
+BTF_ID_FLAGS(func, scx_bpf_get_idle_smtmask_node, KF_ACQUIRE)
 BTF_ID_FLAGS(func, scx_bpf_put_idle_cpumask, KF_RELEASE)
 BTF_ID_FLAGS(func, scx_bpf_test_and_clear_cpu_idle)
 BTF_ID_FLAGS(func, scx_bpf_pick_idle_cpu, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_pick_idle_cpu_node, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_pick_any_cpu, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_task_running, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_task_cpu, KF_RCU)
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index 625f5b046776..9bbf6d5083b5 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -59,14 +59,18 @@ u32 scx_bpf_cpuperf_cap(s32 cpu) __ksym __weak;
 u32 scx_bpf_cpuperf_cur(s32 cpu) __ksym __weak;
 void scx_bpf_cpuperf_set(s32 cpu, u32 perf) __ksym __weak;
 u32 scx_bpf_nr_cpu_ids(void) __ksym __weak;
+int scx_bpf_cpu_to_node(s32 cpu) __ksym __weak;
 const struct cpumask *scx_bpf_get_possible_cpumask(void) __ksym __weak;
 const struct cpumask *scx_bpf_get_online_cpumask(void) __ksym __weak;
 void scx_bpf_put_cpumask(const struct cpumask *cpumask) __ksym __weak;
 const struct cpumask *scx_bpf_get_idle_cpumask(void) __ksym;
+const struct cpumask *scx_bpf_get_idle_cpumask_node(int node) __ksym __weak;
 const struct cpumask *scx_bpf_get_idle_smtmask(void) __ksym;
+const struct cpumask *scx_bpf_get_idle_smtmask_node(int node) __ksym __weak;
 void scx_bpf_put_idle_cpumask(const struct cpumask *cpumask) __ksym;
 bool scx_bpf_test_and_clear_cpu_idle(s32 cpu) __ksym;
 s32 scx_bpf_pick_idle_cpu(const cpumask_t *cpus_allowed, u64 flags) __ksym;
+s32 scx_bpf_pick_idle_cpu_node(int node, const cpumask_t *cpus_allowed, u64 flags) __ksym __weak;
 s32 scx_bpf_pick_any_cpu(const cpumask_t *cpus_allowed, u64 flags) __ksym;
 bool scx_bpf_task_running(const struct task_struct *p) __ksym;
 s32 scx_bpf_task_cpu(const struct task_struct *p) __ksym;
diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
index d56520100a26..587650490743 100644
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -125,6 +125,25 @@ bool scx_bpf_dispatch_vtime_from_dsq___compat(struct bpf_iter_scx_dsq *it__iter,
 	false;									\
 })
 
+#define __COMPAT_scx_bpf_cpu_to_node(cpu)                                       \
+	(bpf_ksym_exists(scx_bpf_cpu_to_node) ?                                 \
+	 scx_bpf_cpu_to_node(cpu) : 0)
+
+#define __COMPAT_scx_bpf_get_idle_cpumask_node(node)                            \
+	(bpf_ksym_exists(scx_bpf_get_idle_cpumask_node) ?                       \
+	 scx_bpf_get_idle_cpumask_node(node) :                                  \
+	 scx_bpf_get_idle_cpumask())                                            \
+
+#define __COMPAT_scx_bpf_get_idle_smtmask_node(node)                            \
+	(bpf_ksym_exists(scx_bpf_get_idle_smtmask_node) ?                       \
+	 scx_bpf_get_idle_smtmask_node(node) :                                  \
+	 scx_bpf_get_idle_smtmask())                                            \
+
+#define __COMPAT_scx_bpf_pick_idle_cpu_node(node, cpus_allowed, flags)          \
+	(bpf_ksym_exists(scx_bpf_pick_idle_cpu_node) ?                          \
+	 scx_bpf_pick_idle_cpu_node(node, cpus_allowed, flags) :                \
+	 scx_bpf_pick_idle_cpu(cpus_allowed, flags))
+
 /*
  * Define sched_ext_ops. This may be expanded to define multiple variants for
  * backward compatibility. See compat.h::SCX_OPS_LOAD/ATTACH().
-- 
2.47.1


