Return-Path: <linux-kernel+bounces-437242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B414E9E90CC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78AD41881172
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C8B217F29;
	Mon,  9 Dec 2024 10:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EmqFJ+Gi"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A9F217716
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 10:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733741208; cv=fail; b=F3gecpz5sKSww8jrArL8HutJZ86sgqOasmvC3DwzDvdYzyiQBz6/YcSRPXdOHlcoFwdyNT0KbWwRW2H5AGte4UW9BJW07Nf6ozCXwhmYiKYaTN+UAjqToZrZjBiPYSGxAEDMFCzMklNVlp9D/QPCOfuDsWRUApWGmW9ZobBsD5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733741208; c=relaxed/simple;
	bh=fsq/esDAytcjFGHI+cRiDOVGp29YyD23DXEkuguka1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=teAm4y9n+zUJ6J3Eku6/62Ys4x8FvQT/bzRm48aFxRVBm7WuXeSvTwlLSN0l4UbXzfbBmMB7QIqO+zuz1sQ08+nXTr7NPcBSwcQVR7d0ZDz3+4cVn41VNA/3+AaMREnZsjQF9OaDK1yt5sUhkJd08KmRL3BGK5l3nZkhD6n1C7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EmqFJ+Gi; arc=fail smtp.client-ip=40.107.92.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gikJR4SGw1aUBGf2Dswx+c1ByBivOLoCZ6MV5MDDFI26rsC28m6+XK8zzWBaORsd5gLZOdEVcEPcXZpPcEGk+n3aJwr73NumW1Wd5itiPUztsln/TvcLdNE1nvO5ddncp26Fgkxn2v8GEuwL9TnrkZO1Qdlc04Dq77g3VSIRq2Af23oBSbfSdFuwhf/Lf88LKaL1Uk5wpaL1kZqpaSRxh0WOLvEOnjp/sIyG0FCdsdVSx2dElb1Ne0iqYbJ2KQGFGt9iXk98wT5FH3Bg7NiX/s626taqG59HOvoR++amXHOHrm0netDqZN2g9cOezacQN4RqV0CGccANRL5t+YftOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A3jYN5xHkuW7iz/2SYFhn752YjKjcE3bcHMRAlCJ+S0=;
 b=gGCntxPH4KnrDJu0FdU0GK55L4Hxt9SAoNztirwKfdD5dsVN9mqnsR8AUmD3kaaH6csG17iIuSsjVMOgaOHkx/FLNwJpc8jtwO+9b75pZ1yuS9Wcv+IUcL9Jd9VX9d8v5skow57cYorzronM1DJkvl634sxYnX9FEgfUQiSS+TOdlDR2NRbjvepIazEWIwO5drdxEoc2y4LK4NM088/vnC/c3tz3V/rYtFlJMcAE2cO+H02HTeSeeDTNOcc/DoSJy60yJVN53BAoh10QIQytQP9Hf+ZvL5C5++9j/c6YguTyBXk+NkmU0H10G0pN67APMJPNbpvreL64dokbARYBCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3jYN5xHkuW7iz/2SYFhn752YjKjcE3bcHMRAlCJ+S0=;
 b=EmqFJ+Gikqmte52UeC96Ix4atZqApgOnMLhIpidziAH0WRUqEbPvR0/4sIjBnt6b1BffDQLEUwO2cQldo9KZXOkdqZv/7L3cmJ4W3u8kTA/gJCjkFNTzQCKT6oe17sMek/iDSuiaGDUp6minkHY9xCLOOXkF2yaeYB6GRNo3E09Tgg6R7Aaa01lkFzeNCx+hhk02lE+LPmlsCSJVT4qVdG+le4dAUtlO0+xxiox5Ke9d8qyhyGLXVMKCiPRN+8zA58nNg18a7xj1dZn62gWsueP1v2/KUEZmRE4iXQNlCO5k+C9gFZFgUmCVOMb5kZACgWZ0+D089fJCmx/i+vPb4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB6424.namprd12.prod.outlook.com (2603:10b6:8:be::16) by
 DS0PR12MB6462.namprd12.prod.outlook.com (2603:10b6:8:c6::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.19; Mon, 9 Dec 2024 10:46:43 +0000
Received: from DM4PR12MB6424.namprd12.prod.outlook.com
 ([fe80::8133:5fd9:ff45:d793]) by DM4PR12MB6424.namprd12.prod.outlook.com
 ([fe80::8133:5fd9:ff45:d793%7]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 10:46:43 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	Changwoo Min <changwoo@igalia.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] sched_ext: Introduce per-NUMA idle cpumasks
Date: Mon,  9 Dec 2024 11:40:55 +0100
Message-ID: <20241209104632.718085-2-arighi@nvidia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241209104632.718085-1-arighi@nvidia.com>
References: <20241209104632.718085-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FRYP281CA0014.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::24)
 To DM4PR12MB6424.namprd12.prod.outlook.com (2603:10b6:8:be::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6424:EE_|DS0PR12MB6462:EE_
X-MS-Office365-Filtering-Correlation-Id: 10d311d7-37dc-4975-eeb0-08dd183ec4ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QsgRE8xKeA4Is3dhDLNZAqkbGI1IHCsVWsxDx7zy3yPJavJNOELy+4fIhBxB?=
 =?us-ascii?Q?CRRTsMnA0gosJGHWNUHVjD3POVdGSFSneKedgYKbRGXm5juqgDTdzsh6wjCP?=
 =?us-ascii?Q?nn9ufv5BOIWCMQRZlwFiC32fVFiQViyvL3suNeI2jRL2Q9iflM3l9L79ITyW?=
 =?us-ascii?Q?NascDA5FwujxTLa6oV7pNPrF+/tLOZoA6Jhyq93hOwzx26LbtCtP8c/QNWrp?=
 =?us-ascii?Q?UgC99BkwcpJhA+R/nGnyilXfglpbw0+vKJ83vqdGwb5u5pJp0mFsbJMr22cN?=
 =?us-ascii?Q?CVxRC0/3MSLljiul11E2uBL5nxah8XazHqclLEsIW0GJ7gPUA23jfXdsu4ZO?=
 =?us-ascii?Q?KiewkChC6we4QJt08DxbflSrMvYBQY2P07nzFkCZO2W9a4KoHOfEHEin3lQv?=
 =?us-ascii?Q?I8n1ekc+A8JngLRTtf/nXF88cehWj9KI6M/JXCyqxI9oBKx1O1w5HTeYQFm4?=
 =?us-ascii?Q?Mh0iCQXwl475eIvGDll917ezZz2X/VOJ4MtsXpwGBMkswV+8UvdDstJRWQ54?=
 =?us-ascii?Q?QK61Q63KjwVtd9/Rt0V3dh9eA4KmG9RRS4FTPMncU1HgS6lcZIilhfJGCPnr?=
 =?us-ascii?Q?dm3fvzlVYe1gHlooerjNf2Ffouhfa7+DfyNE1Npi/0ECJOtMA5niu3byJYZu?=
 =?us-ascii?Q?NF2Ak5qgfhv7Fy3F2uqEfEUqNvmUkTZat0zU7xCp4Uyk5XBuwswGtr0JOTI2?=
 =?us-ascii?Q?PSzbDucH4duodkttCvsO8+oz1Wj6ri95hQ0W2dUU/lDObCLUkVLRFsgbQgwE?=
 =?us-ascii?Q?xE3TX++IDOIwZ03AwBuHoq471vPkUOqVAXzB1xa6b4DxiIpZFj6ol1Pi1zYm?=
 =?us-ascii?Q?uFV93kqslWNq4UxLh6Y8TJg3JQ9u/qKyn6BpdXzFE58DMtudwYmA/PS7mwtE?=
 =?us-ascii?Q?ck232OvO0bxaYj+Ne7+ssJOq34BpCaSpAxq+PrDXqok3oYkYYswKZWYQab1P?=
 =?us-ascii?Q?LdHH1k0k0EpAkS6iLGwImNoCAG+LcRNNo0Y8BRGPVEbutHSoMG9YHn/PoLQK?=
 =?us-ascii?Q?iRR50uEK24ktkCc94UvQYia0Q9CQmIWdEeCSh8MWyWcj+FyMz+oEUkxXIr/A?=
 =?us-ascii?Q?z6WW1XhAhwM1MNEg/ruusVpej+GGKNTZqT2hITu/JFTlQVlN+AVx5TXZAbAD?=
 =?us-ascii?Q?pVaAHkThn0hO2P873C2fW5CqA+Y+98mslINzFjsU4QTYf10fJvNJJYZktPb2?=
 =?us-ascii?Q?3V5PC/aZCLPRPI6JI9dSldwZv7AhzPw2YT3p6zW/U52Yb848XIADIOhLkYQs?=
 =?us-ascii?Q?91ssyuWPOJxAKABFkmq3wkFYgWKR4JHFvhyKfs9a4kxSHVqsr5Ucdx+YdCwq?=
 =?us-ascii?Q?zmHuSROZQ50Emjho11OY4Z9aH2oPo39m2lleAEeErsQirA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6424.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XaDQTK0UjWaVrUGY0c/DqLxz0XIYjgRZdzUfiDavAwIa16EF51fZjJ9rmS1d?=
 =?us-ascii?Q?oXyUB/WJVh85rcCBlNo1D8gFq0G/MYgogwq0SGzyjV7ugiRn5elZlaxqpoYO?=
 =?us-ascii?Q?0YJA7P05AWqK6GX13Q5zAvGU7ZBvb/r1exvaGY+NHiy9xNPg8tmGGiB/L2eH?=
 =?us-ascii?Q?1Qj69khVK0QAMCCSqDmONs0cwF7T9DAoJu1Hto9SEU6/7BhoMIHJSyivebr+?=
 =?us-ascii?Q?J+r5Vm8utNAqZtZgVaUV3cgmZgXhPCy8C5mx8/auUKtwjB/ItTi36kIYwnxG?=
 =?us-ascii?Q?lX6RJg6NL4qcmrbCa/DcZp5x/FEdEtObrxgb7nd/E3AUNbe1IdrzRgsMYihW?=
 =?us-ascii?Q?MHM6dx7wPh8V2U9Ue+s4kdx/xPVsouceVKjMqf/An3HiCceUfOlU2eGiFnbj?=
 =?us-ascii?Q?RWFjpwTfdkVEV4M2HrXokCpXRnByeQTiPDbXP65xHX/1+HN/Y+ay+XTVO1Rm?=
 =?us-ascii?Q?5vxyZJr5qTZPgvepQkVFq4Qw4SDtvCfM/5hB1JkTBQSWUcQsJqHEm5n+AgOO?=
 =?us-ascii?Q?q0WX6/WWiAbU/UNGTegeKa3CN6TBOgwuQtuZN/qlnrE5cifzbO38G5BUK9dX?=
 =?us-ascii?Q?oY4WFduHtPfEXHiDFF86KTmDrQIxdDrT4AfVCbpxsw+AQ6orJ3Plk2faqBH6?=
 =?us-ascii?Q?NF3CnewF7O/+YA4Kbex+vG1vQYTEHJ+50yQgSg2/jAUth6DQLUogt/ZKmGto?=
 =?us-ascii?Q?0OP93b2BG+7yxA20qgL2aZKn8Bmt4c/yRb7uS0UigU/LUQSWyoLdeHl4pwtb?=
 =?us-ascii?Q?95m7YJRbnpwQ94MLVhlJe1tCR82QtQ0tYGdzdUicQJHxQuDOC/ocSQ8C9D+D?=
 =?us-ascii?Q?OetDl0+U5vJNI5WZ4UD3XSdVO9gmEl3D4yEjMM8AWw9C8a0tiMQV4WQHIcT9?=
 =?us-ascii?Q?lfKm6Ow6mYiaJ9r1jij8x/s/xceL84NEL91tSLsARxRetdcT8BpWq6swrhaq?=
 =?us-ascii?Q?pWTlgzXlGwe4FlCZx6BAqb2xm5RPCz+wbdicg+QwC0ZX4cO15djmPeCj3pjE?=
 =?us-ascii?Q?0ASSZ0WoiUvd/hVGpyqVVV5/qJCJ5wUVisiNgIUXA7FPzdEVF9rl8i+ZOSaE?=
 =?us-ascii?Q?Ea7/k1mo/MFwmFVgHZRu75HuyYT2rMYufMck8BcZzZrrY0fF7Tjz9LkiNH2f?=
 =?us-ascii?Q?cQgPJdI5ZrqLo+yGkdqT2S2/JsozXzSPH2/aGP3CLXGQ8zKJLZce8Gnx3/NS?=
 =?us-ascii?Q?XmeVxBzj/YdMvQZTN9KojNNs397dqWA3NQl0yRaeYq0RudjSreQVDNhe95OM?=
 =?us-ascii?Q?HghIR0sDDwu4hn2D0nsFfWJi8wpUPku2yHQZ4qCGd2DCYK6S/Bw6m7aKpBzG?=
 =?us-ascii?Q?0cfM6j2suOdByVWmi10fbxXL1kxjWjfmhz5OrE0snhlqe4MWhnhShI80nbGe?=
 =?us-ascii?Q?/OQFhNPqOBIP7O9UjWraMYKT5d1EdVEU8dhWqReKvVWO6cxMB6KJ4WYw7G5U?=
 =?us-ascii?Q?/Szxg7SkuuYwc36KufftTzjlMN9znFLqxmMCznmIq1uLmIM2pBKepSd8BP/Y?=
 =?us-ascii?Q?k14Zx8lPc+dgAqtvbht02AkFnuy/lJc4PDWePtzLJ+2wVVC0GTuhCoTwVty3?=
 =?us-ascii?Q?EpgpuoXwweyCSHP/usi8nmzfRtyZ02wO0mHl4RXg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10d311d7-37dc-4975-eeb0-08dd183ec4ff
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6424.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 10:46:43.0812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vN+yFEVsNV+7pxPuz/Zwjy1V8hniYNbxJicnIfSZYKFLQQkIFRde046lxo6LLbCwDBcCqJ20bDiJ6zClBitfqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6462

Using a single global idle mask can lead to inefficiencies and a lot of
stress on the cache coherency protocol on large systems with multiple
NUMA nodes, since all the CPUs can create a really intense read/write
activity on the single global cpumask.

Therefore, split the global cpumask into multiple per-NUMA node cpumasks
to improve scalability and performance on large systems.

The concept is that each cpumask will track only the idle CPUs within
its corresponding NUMA node, treating CPUs in other NUMA nodes as busy.
In this way concurrent access to the idle cpumask will be restricted
within each NUMA node.

NOTE: the scx_bpf_get_idle_cpu/smtmask() kfunc's, that are supposed to
return a single cpumask for all the CPUs, have been changed to report
only the cpumask of the current NUMA node (using the current CPU).

This is breaking the old behavior, but it will be addressed in the next
commits, introducing a new flag to switch between the old single global
flat idle cpumask or the multiple per-node cpumasks.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 221 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 166 insertions(+), 55 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 71342f3719c1..7e7f2869826f 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -933,8 +933,60 @@ static struct delayed_work scx_watchdog_work;
 static struct {
 	cpumask_var_t cpu;
 	cpumask_var_t smt;
-} idle_masks CL_ALIGNED_IF_ONSTACK;
+} **idle_masks CL_ALIGNED_IF_ONSTACK;
 
+static struct cpumask *get_idle_cpumask_node(int node)
+{
+	return idle_masks[node]->cpu;
+}
+
+static struct cpumask *get_idle_smtmask_node(int node)
+{
+	return idle_masks[node]->smt;
+}
+
+static struct cpumask *get_curr_idle_cpumask(void)
+{
+	int node = cpu_to_node(smp_processor_id());
+
+	return get_idle_cpumask_node(node);
+}
+
+static struct cpumask *get_curr_idle_smtmask(void)
+{
+	int node = cpu_to_node(smp_processor_id());
+
+	if (sched_smt_active())
+		return get_idle_smtmask_node(node);
+	else
+		return get_idle_cpumask_node(node);
+}
+
+static void idle_masks_init(void)
+{
+	int node;
+
+	idle_masks = kcalloc(num_possible_nodes(), sizeof(*idle_masks), GFP_KERNEL);
+	BUG_ON(!idle_masks);
+
+	for_each_node_state(node, N_POSSIBLE) {
+		idle_masks[node] = kzalloc_node(sizeof(**idle_masks), GFP_KERNEL, node);
+		BUG_ON(!idle_masks[node]);
+
+		BUG_ON(!alloc_cpumask_var_node(&idle_masks[node]->cpu, GFP_KERNEL, node));
+		BUG_ON(!alloc_cpumask_var_node(&idle_masks[node]->smt, GFP_KERNEL, node));
+	}
+}
+#else	/* !CONFIG_SMP */
+static struct cpumask *get_curr_idle_cpumask(void)
+{
+	return cpu_none_mask;
+}
+
+static struct cpumask *get_curr_idle_smtmask(void)
+{
+	return cpu_none_mask;
+}
 #endif	/* CONFIG_SMP */
 
 /* for %SCX_KICK_WAIT */
@@ -3166,6 +3218,9 @@ bool scx_prio_less(const struct task_struct *a, const struct task_struct *b,
 
 static bool test_and_clear_cpu_idle(int cpu)
 {
+	int node = cpu_to_node(cpu);
+	struct cpumask *idle_cpu = get_idle_cpumask_node(node);
+
 #ifdef CONFIG_SCHED_SMT
 	/*
 	 * SMT mask should be cleared whether we can claim @cpu or not. The SMT
@@ -3174,29 +3229,34 @@ static bool test_and_clear_cpu_idle(int cpu)
 	 */
 	if (sched_smt_active()) {
 		const struct cpumask *smt = cpu_smt_mask(cpu);
+		struct cpumask *idle_smt = get_idle_smtmask_node(node);
 
 		/*
 		 * If offline, @cpu is not its own sibling and
 		 * scx_pick_idle_cpu() can get caught in an infinite loop as
-		 * @cpu is never cleared from idle_masks.smt. Ensure that @cpu
-		 * is eventually cleared.
+		 * @cpu is never cleared from the idle SMT mask. Ensure that
+		 * @cpu is eventually cleared.
+		 *
+		 * NOTE: Use cpumask_intersects() and cpumask_test_cpu() to
+		 * reduce memory writes, which may help alleviate cache
+		 * coherence pressure.
 		 */
-		if (cpumask_intersects(smt, idle_masks.smt))
-			cpumask_andnot(idle_masks.smt, idle_masks.smt, smt);
-		else if (cpumask_test_cpu(cpu, idle_masks.smt))
-			__cpumask_clear_cpu(cpu, idle_masks.smt);
+		if (cpumask_intersects(smt, idle_smt))
+			cpumask_andnot(idle_smt, idle_smt, smt);
+		else if (cpumask_test_cpu(cpu, idle_smt))
+			__cpumask_clear_cpu(cpu, idle_smt);
 	}
 #endif
-	return cpumask_test_and_clear_cpu(cpu, idle_masks.cpu);
+	return cpumask_test_and_clear_cpu(cpu, idle_cpu);
 }
 
-static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags)
+static s32 scx_pick_idle_cpu_from_node(int node, const struct cpumask *cpus_allowed, u64 flags)
 {
 	int cpu;
 
 retry:
 	if (sched_smt_active()) {
-		cpu = cpumask_any_and_distribute(idle_masks.smt, cpus_allowed);
+		cpu = cpumask_any_and_distribute(get_idle_smtmask_node(node), cpus_allowed);
 		if (cpu < nr_cpu_ids)
 			goto found;
 
@@ -3204,15 +3264,66 @@ static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags)
 			return -EBUSY;
 	}
 
-	cpu = cpumask_any_and_distribute(idle_masks.cpu, cpus_allowed);
-	if (cpu >= nr_cpu_ids)
-		return -EBUSY;
+	cpu = cpumask_any_and_distribute(get_idle_cpumask_node(node), cpus_allowed);
+	if (cpu < nr_cpu_ids)
+		goto found;
+
+	return -EBUSY;
 
 found:
 	if (test_and_clear_cpu_idle(cpu))
 		return cpu;
 	else
 		goto retry;
+
+}
+
+static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, s32 prev_cpu, u64 flags)
+{
+	const struct cpumask *node_mask;
+	s32 cpu;
+
+	/*
+	 * Only node 0 is used if per-node idle cpumasks are disabled.
+	 */
+	if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node))
+		return scx_pick_idle_cpu_from_node(0, cpus_allowed, flags);
+
+	/*
+	 * Traverse all nodes in order of increasing distance, starting from
+	 * prev_cpu's node.
+	 */
+	rcu_read_lock();
+	for_each_numa_hop_mask(node_mask, cpu_to_node(prev_cpu)) {
+		/*
+		 * scx_pick_idle_cpu_from_node() can be expensive and redundant
+		 * if none of the CPUs in the NUMA node can be used (according
+		 * to cpus_allowed).
+		 *
+		 * Therefore, check if the NUMA node is usable in advance to
+		 * save some CPU cycles.
+		 */
+		if (!cpumask_intersects(node_mask, cpus_allowed))
+			continue;
+
+		/*
+		 * It would be nice to have a "node" iterator, instead of the
+		 * cpumask, to get rid of the cpumask_first() to determine the
+		 * node.
+		 */
+		cpu = cpumask_first(node_mask);
+		if (cpu >= nr_cpu_ids)
+			continue;
+
+		cpu = scx_pick_idle_cpu_from_node(cpu_to_node(cpu), cpus_allowed, flags);
+		if (cpu >= 0)
+			goto out_unlock;
+	}
+	cpu = -EBUSY;
+
+out_unlock:
+	rcu_read_unlock();
+	return cpu;
 }
 
 /*
@@ -3420,6 +3531,7 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 {
 	const struct cpumask *llc_cpus = NULL;
 	const struct cpumask *numa_cpus = NULL;
+	int node = cpu_to_node(prev_cpu);
 	s32 cpu;
 
 	*found = false;
@@ -3477,9 +3589,9 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 		 * piled up on it even if there is an idle core elsewhere on
 		 * the system.
 		 */
-		if (!cpumask_empty(idle_masks.cpu) &&
-		    !(current->flags & PF_EXITING) &&
-		    cpu_rq(cpu)->scx.local_dsq.nr == 0) {
+		if (!(current->flags & PF_EXITING) &&
+		    cpu_rq(cpu)->scx.local_dsq.nr == 0 &&
+		    !cpumask_empty(get_idle_cpumask_node(cpu_to_node(cpu)))) {
 			if (cpumask_test_cpu(cpu, p->cpus_ptr))
 				goto cpu_found;
 		}
@@ -3493,7 +3605,7 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 		/*
 		 * Keep using @prev_cpu if it's part of a fully idle core.
 		 */
-		if (cpumask_test_cpu(prev_cpu, idle_masks.smt) &&
+		if (cpumask_test_cpu(prev_cpu, get_idle_smtmask_node(node)) &&
 		    test_and_clear_cpu_idle(prev_cpu)) {
 			cpu = prev_cpu;
 			goto cpu_found;
@@ -3503,7 +3615,7 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 		 * Search for any fully idle core in the same LLC domain.
 		 */
 		if (llc_cpus) {
-			cpu = scx_pick_idle_cpu(llc_cpus, SCX_PICK_IDLE_CORE);
+			cpu = scx_pick_idle_cpu_from_node(node, llc_cpus, SCX_PICK_IDLE_CORE);
 			if (cpu >= 0)
 				goto cpu_found;
 		}
@@ -3512,7 +3624,7 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 		 * Search for any fully idle core in the same NUMA node.
 		 */
 		if (numa_cpus) {
-			cpu = scx_pick_idle_cpu(numa_cpus, SCX_PICK_IDLE_CORE);
+			cpu = scx_pick_idle_cpu_from_node(node, numa_cpus, SCX_PICK_IDLE_CORE);
 			if (cpu >= 0)
 				goto cpu_found;
 		}
@@ -3520,7 +3632,7 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 		/*
 		 * Search for any full idle core usable by the task.
 		 */
-		cpu = scx_pick_idle_cpu(p->cpus_ptr, SCX_PICK_IDLE_CORE);
+		cpu = scx_pick_idle_cpu(p->cpus_ptr, prev_cpu, SCX_PICK_IDLE_CORE);
 		if (cpu >= 0)
 			goto cpu_found;
 	}
@@ -3537,7 +3649,7 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 	 * Search for any idle CPU in the same LLC domain.
 	 */
 	if (llc_cpus) {
-		cpu = scx_pick_idle_cpu(llc_cpus, 0);
+		cpu = scx_pick_idle_cpu_from_node(node, llc_cpus, 0);
 		if (cpu >= 0)
 			goto cpu_found;
 	}
@@ -3546,7 +3658,7 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 	 * Search for any idle CPU in the same NUMA node.
 	 */
 	if (numa_cpus) {
-		cpu = scx_pick_idle_cpu(numa_cpus, 0);
+		cpu = scx_pick_idle_cpu_from_node(node, numa_cpus, 0);
 		if (cpu >= 0)
 			goto cpu_found;
 	}
@@ -3554,7 +3666,7 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 	/*
 	 * Search for any idle CPU usable by the task.
 	 */
-	cpu = scx_pick_idle_cpu(p->cpus_ptr, 0);
+	cpu = scx_pick_idle_cpu(p->cpus_ptr, prev_cpu, 0);
 	if (cpu >= 0)
 		goto cpu_found;
 
@@ -3636,17 +3748,27 @@ static void set_cpus_allowed_scx(struct task_struct *p,
 
 static void reset_idle_masks(void)
 {
+	int node;
+
 	/*
 	 * Consider all online cpus idle. Should converge to the actual state
 	 * quickly.
 	 */
-	cpumask_copy(idle_masks.cpu, cpu_online_mask);
-	cpumask_copy(idle_masks.smt, cpu_online_mask);
+	for_each_node_state(node, N_POSSIBLE) {
+		const struct cpumask *node_mask = cpumask_of_node(node);
+		struct cpumask *idle_cpu = get_idle_cpumask_node(node);
+		struct cpumask *idle_smt = get_idle_smtmask_node(node);
+
+		cpumask_and(idle_cpu, cpu_online_mask, node_mask);
+		cpumask_copy(idle_smt, idle_cpu);
+	}
 }
 
 void __scx_update_idle(struct rq *rq, bool idle)
 {
 	int cpu = cpu_of(rq);
+	int node = cpu_to_node(cpu);
+	struct cpumask *idle_cpu = get_idle_cpumask_node(node);
 
 	if (SCX_HAS_OP(update_idle) && !scx_rq_bypassing(rq)) {
 		SCX_CALL_OP(SCX_KF_REST, update_idle, cpu_of(rq), idle);
@@ -3654,27 +3776,25 @@ void __scx_update_idle(struct rq *rq, bool idle)
 			return;
 	}
 
-	if (idle)
-		cpumask_set_cpu(cpu, idle_masks.cpu);
-	else
-		cpumask_clear_cpu(cpu, idle_masks.cpu);
+	assign_cpu(cpu, idle_cpu, idle);
 
 #ifdef CONFIG_SCHED_SMT
 	if (sched_smt_active()) {
 		const struct cpumask *smt = cpu_smt_mask(cpu);
+		struct cpumask *idle_smt = get_idle_smtmask_node(node);
 
 		if (idle) {
 			/*
-			 * idle_masks.smt handling is racy but that's fine as
-			 * it's only for optimization and self-correcting.
+			 * idle_smt handling is racy but that's fine as it's
+			 * only for optimization and self-correcting.
 			 */
 			for_each_cpu(cpu, smt) {
-				if (!cpumask_test_cpu(cpu, idle_masks.cpu))
+				if (!cpumask_test_cpu(cpu, idle_cpu))
 					return;
 			}
-			cpumask_or(idle_masks.smt, idle_masks.smt, smt);
+			cpumask_or(idle_smt, idle_smt, smt);
 		} else {
-			cpumask_andnot(idle_masks.smt, idle_masks.smt, smt);
+			cpumask_andnot(idle_smt, idle_smt, smt);
 		}
 	}
 #endif
@@ -3722,7 +3842,10 @@ static void rq_offline_scx(struct rq *rq)
 #else	/* CONFIG_SMP */
 
 static bool test_and_clear_cpu_idle(int cpu) { return false; }
-static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags) { return -EBUSY; }
+static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, s32 prev_cpu, u64 flags)
+{
+	return -EBUSY;
+}
 static void reset_idle_masks(void) {}
 
 #endif	/* CONFIG_SMP */
@@ -6255,8 +6378,7 @@ void __init init_sched_ext_class(void)
 
 	BUG_ON(rhashtable_init(&dsq_hash, &dsq_hash_params));
 #ifdef CONFIG_SMP
-	BUG_ON(!alloc_cpumask_var(&idle_masks.cpu, GFP_KERNEL));
-	BUG_ON(!alloc_cpumask_var(&idle_masks.smt, GFP_KERNEL));
+	idle_masks_init();
 #endif
 	scx_kick_cpus_pnt_seqs =
 		__alloc_percpu(sizeof(scx_kick_cpus_pnt_seqs[0]) * nr_cpu_ids,
@@ -7402,7 +7524,7 @@ __bpf_kfunc void scx_bpf_put_cpumask(const struct cpumask *cpumask)
 
 /**
  * scx_bpf_get_idle_cpumask - Get a referenced kptr to the idle-tracking
- * per-CPU cpumask.
+ * per-CPU cpumask of the current NUMA node.
  *
  * Returns NULL if idle tracking is not enabled, or running on a UP kernel.
  */
@@ -7413,17 +7535,13 @@ __bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask(void)
 		return cpu_none_mask;
 	}
 
-#ifdef CONFIG_SMP
-	return idle_masks.cpu;
-#else
-	return cpu_none_mask;
-#endif
+	return get_curr_idle_cpumask();
 }
 
 /**
  * scx_bpf_get_idle_smtmask - Get a referenced kptr to the idle-tracking,
- * per-physical-core cpumask. Can be used to determine if an entire physical
- * core is free.
+ * per-physical-core cpumask of the current NUMA node. Can be used to determine
+ * if an entire physical core is free.
  *
  * Returns NULL if idle tracking is not enabled, or running on a UP kernel.
  */
@@ -7434,14 +7552,7 @@ __bpf_kfunc const struct cpumask *scx_bpf_get_idle_smtmask(void)
 		return cpu_none_mask;
 	}
 
-#ifdef CONFIG_SMP
-	if (sched_smt_active())
-		return idle_masks.smt;
-	else
-		return idle_masks.cpu;
-#else
-	return cpu_none_mask;
-#endif
+	return get_curr_idle_smtmask();
 }
 
 /**
@@ -7508,7 +7619,7 @@ __bpf_kfunc s32 scx_bpf_pick_idle_cpu(const struct cpumask *cpus_allowed,
 		return -EBUSY;
 	}
 
-	return scx_pick_idle_cpu(cpus_allowed, flags);
+	return scx_pick_idle_cpu(cpus_allowed, smp_processor_id(), flags);
 }
 
 /**
@@ -7531,7 +7642,7 @@ __bpf_kfunc s32 scx_bpf_pick_any_cpu(const struct cpumask *cpus_allowed,
 	s32 cpu;
 
 	if (static_branch_likely(&scx_builtin_idle_enabled)) {
-		cpu = scx_pick_idle_cpu(cpus_allowed, flags);
+		cpu = scx_pick_idle_cpu(cpus_allowed, smp_processor_id(), flags);
 		if (cpu >= 0)
 			return cpu;
 	}
-- 
2.47.1


