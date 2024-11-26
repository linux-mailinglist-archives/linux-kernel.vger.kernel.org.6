Return-Path: <linux-kernel+bounces-422155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D55B99D9541
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 11:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E94516594F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 10:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B881CBEA4;
	Tue, 26 Nov 2024 10:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C0yF62Ud"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B391CB337
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 10:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732616002; cv=fail; b=FjMqs5mYm8EeuEVgyCyjx4Tp30SXjeOeM+IEgW0/k3ai0jajfNCW23cYKWfJilBGJf2ZG7Jdx/Ix1gA1eXbPtDm0anBLhXeggrfL0CSj/DEY8X09wBvjFmexdGijjAgbsfDQKewHs2lkoURac/MLpbTipqHt00/3OfYfoMZcPAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732616002; c=relaxed/simple;
	bh=vQEUiRwsQNONQs/qPEHVwylgnTZPbtT5TbGBlpwTOD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m/H5rZwHY25UKaCe7/cYkz59iscTlTtgKf19R0nGihOq1aO+4YNFuvB7U/Io9s2cPEWnB7XjKo7iBnjd7Fs/udLL30NIqutAYgyQrCmJmKivKG0wbzC/jtpxmcGfflqJTxXfbKfvZ31D4xBlC12lgICic6/4sxdakWCC8uvUewA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C0yF62Ud; arc=fail smtp.client-ip=40.107.94.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HX6oIdqsFxnD/tkx8tf+o58lauQy0PtEZY23HQvn0UELwHM1sF3m8ZyrUwdQe2NP2sZneMafwdt/3uIyHaVVzgENITdn6IoIowAdrQje87xFhh70hKZN+8Y8qDiojj6h9bEv51ORjpw9ZXHnYlMG/Nx6q8eN4TIknySlVmqmjRCTmH98pOqt6d4F87fLyzYR7YJNcBzfmfbt6dWx1EVbo5VQHgx2gj9uPgsZvl/mAh3OJEHFLqEmbmeh3/e7lUkbMjl1Py6udB+D06OvvwI5BD2rmuo78n0vdpQgbrVzgnna41c77GNvul3cRsHKo1iuaUee38UOobghr5AcW/V6Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GZhMGrRbacwTEkenw/YUhvJLeCkoGkQ7bzZaDYJNGwU=;
 b=j5eUAV1wJL1R9d31MxHVN5+Oi9ABSEKk/awhfWuI1MRKkXb/JY7mBvCI7V7+2GgXCthaG8CKdyd+OlldFgVCb9nv0JMbqJhlvBr2klnpHkCweicvUhnMcMkH2LwdldyalKXaLNZjnu95YuPtCHBlTBC3oEHiQ4qt2jWtx7BdHnE4Sh3/BHKmzkSNc9OeVFPUrEpD3pK2gUj13/Vo5JD+t3w27JrfjADmDpk5496+DFiLRjYi8UPU6yh7lrdSuK0+S3+S+TIX371oO+K30hmYxkB+umTfZviEUzIXbUVYumAsbQQ83eaQT55emsLs4jedHENHIz21s7SM8vxNwT81Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZhMGrRbacwTEkenw/YUhvJLeCkoGkQ7bzZaDYJNGwU=;
 b=C0yF62Ud2PmO7qs9kyVcMFKCCn1oNmUPoBG+0/KX/v2lLzvFJwGMPbvGXeNtMFXEccoQopPJ23eUrjUQJr1N3ECQvDfxPWz69rMyDh6f1aXRsn/XH+xccdira+PLVsomc63jKNpIvyYQ5qqEwaAZcLbX7XWgSI6+1Jxno4B3BBOiJo+Y8wdf2/4LcKJnxRRVHuf4iM7iIY0kVUYG0V42r42wtgR7LBD+zVvbbmQg+CfUK70Uvw22EI5JEcU/T5NWcsuft5Q29/1ktXwATLOYw6vq+aSMZ6ijNM6ROObeHwDI3qD24n8RAKA6fgEoWah9yR3lRiQCBYfX5DdOPREy8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by SN7PR12MB6888.namprd12.prod.outlook.com (2603:10b6:806:260::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Tue, 26 Nov
 2024 10:13:18 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 10:13:18 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] sched_ext: Introduce per-NUMA idle cpumasks
Date: Tue, 26 Nov 2024 10:56:40 +0100
Message-ID: <20241126101259.52077-3-arighi@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241126101259.52077-1-arighi@nvidia.com>
References: <20241126101259.52077-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0211.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::7) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|SN7PR12MB6888:EE_
X-MS-Office365-Filtering-Correlation-Id: 9eb45abb-5611-4688-2edb-08dd0e02f2b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?44eKW24fMGaNYLL4Nw3ko8jVGapOevSFvD8mgO/pitWPuuTISgoxfISmWQRe?=
 =?us-ascii?Q?NK61TJslx3AR2ct0NJ5mpFsPLjVL7r2en8OyD+fpfn7SnYqP4FG9DOFCDTDN?=
 =?us-ascii?Q?LEhyId7LAa3XTgFz7NlJ5qNcj6XsmlTwvgrn6myZST7yF3WzHN2B4bXAJv5o?=
 =?us-ascii?Q?6w8xvZvs/4/FtZbN7tmB5waRF2gRwPXxgNWX4xL0Cpm19S2VX3znY099hGXw?=
 =?us-ascii?Q?rGKAiIR/4QOjbhK/Mo6TxJi+wNgo5FrN1u+2r1B4JftZpBqkrSeoR8mLtmr5?=
 =?us-ascii?Q?19SLvPJahfoDq0j97TfnWpv+6bNpKgfEf++5MwQKxAJRG7HEr7SYlbZSxYcZ?=
 =?us-ascii?Q?c8dU838Wi2OVx3Yt+KsNAwSsqxwp/lw3wImFLMSWUvPhyLg7Ndl5SB83IQcf?=
 =?us-ascii?Q?Ab5GT6jmGOONamCKR5AKm6+3cO/+1tjdEBiBDa0OFMd1lv9wgrUGNs/RjhJk?=
 =?us-ascii?Q?aHy8DMlIpLlfIiUvIFIfwLODvjq2lt7fKWMu9FsWAjzXeOr20qKjMI/QTaBB?=
 =?us-ascii?Q?Y6l1Hly3S1jMCEg27UaVjaYEPFYCl617+zJBwGjsl9+pXl1Yiyi/k3B2LU7g?=
 =?us-ascii?Q?YBquSUuCQkiMpQ7dzfoCKPnKcicBMOJO6lJeBYRCIE0YrPEhMrLOYIDxp0mU?=
 =?us-ascii?Q?Z5X4WlYr6asOYNFxKCAni9R/aFIhyy264d6WvYWSHeCawptsaReEhb9MnCOR?=
 =?us-ascii?Q?b+UI2zPhqeJWcTo7l4KBW5usYE8LUhFAUm5bWVCRrnHnnMO1+xxhAe6d9x7O?=
 =?us-ascii?Q?DVqwfoCLulGTaA6Y/vkPVOrp5FWPrVzwo5yq+r+E8YalmXWGToS1YiEVEifn?=
 =?us-ascii?Q?UaVxW0PcI1J/JHwecY9+yAhjoksPKFVO6MjpmUQpVVigCR6D2xfPMrlBcrTa?=
 =?us-ascii?Q?tmwStUDN58QBG2mfYCllIcjEJ+g2Evbo/9MxB3AA/uUuSrtXyeldAMpCjyla?=
 =?us-ascii?Q?e0DhpBJNbsAvNceuv7dmObaqIqCOKfzKSxw7eewORDNB4LnjFPaOe1XfiHmB?=
 =?us-ascii?Q?mjo5V9tvJu2tUtyy4Gvv79xCUSjFRHGitxJITt/gyKsAcGll5ZPmRJxss7P6?=
 =?us-ascii?Q?DEMCA0yEbBDlwZCaCJPkvlXUyIDniLpUUVS0WGRazzizU9AQJQvBHZ+jqmo4?=
 =?us-ascii?Q?R/2joOljUq5k+xIell/fGDAvQp2K7lD4HtYPGCSycmtTcH2KqAGjtgXkyIk3?=
 =?us-ascii?Q?GUS/Av/Bdih1wQPxmnHvIqnh8YJFziRRlJWB/aj8JFX5szap03+FRGuyv4iu?=
 =?us-ascii?Q?wgRjhCqBoLk4qgick+KQPQTCtfLxmdXhYmoXYuh/tX87vPPTENdJG8NsF+4h?=
 =?us-ascii?Q?ISk8eUWwhqc4z8YS52yz+PthzOVNXNJVI7hY1CWNCM0OAA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t1lf43+CNG8uEcBr28RMSpg8KXa1is2zbyAKF7Hl1sxkTLA0jJ4HHbF9k+iD?=
 =?us-ascii?Q?puULOQ27d66vfSRKyVl87zn/8Ab4zm2nGdyyxoCvlD0qjNJD2z3umjMdos3+?=
 =?us-ascii?Q?N1IPEAJ97Jrpx11LdRgM3P2Z5hcByTTudKMkG+gdbwlaTyc85PZc2TaG50MR?=
 =?us-ascii?Q?2qOB9Ju0phQULk1yyt5lV8fSVR5hTYtnOlYb6gHsYp428GGclKKiGES6fG9/?=
 =?us-ascii?Q?ziwvB3BktuQyzC/QiWi/FJxv4JhQVLUoB8O4JiPAIDGTg5OdLgeSHKFQO0xD?=
 =?us-ascii?Q?HQTq3tWZTkErhGsRIpWj0GW2kr51elL0vzmYAuSuISV/vOUN63XnQRG1+WnW?=
 =?us-ascii?Q?vCbEsaYsium1vroy2FEZlJfGfGu7cuLV99EB+5NKE8w1Bf9j3wfZn9cYNR3H?=
 =?us-ascii?Q?Pl/+seZq2hLMYGaj3wAHuKxeEFF+YK5gnKemAey8TaRwR/67keFAv8+oBMv/?=
 =?us-ascii?Q?kbAx681MkZLG9B6MOR9GXYEDpKG06dDaYU2qc08BVosCThGkYkcPswAbVD8P?=
 =?us-ascii?Q?NC3z9ipdgKQtV6hsY8B+V/EuO3LCfZ11LSsbHEoxWBXXF3VtKJej8Mg5CylM?=
 =?us-ascii?Q?1BilzFKLU3GtIY75KJEtHcO0tXRxRzAYtywZ1lGSviwEZU98gIYN18JpIZfq?=
 =?us-ascii?Q?YzXbdVQp2qpB58E+Bgvd0x7y8nGrguBAz0aU121w61syoE8NP/EqAvNPL2sV?=
 =?us-ascii?Q?vcrDtchBKc4ifIaIKLVGfgtcVhDtALZ26Tl695DPjq5ByUGldC2vHqCOjh+v?=
 =?us-ascii?Q?XU1ad4C/nfJcTtY8HYDwzN9dQriM9qsSYpT7CAERHTdtBwnm6tUkJ3AucvCb?=
 =?us-ascii?Q?KQpCCIO6k3mD4zLv4WRr5ZXCnBYwFzVunW5y+TgsZEEtiFd20eLwdst5lnTz?=
 =?us-ascii?Q?XQsVwbHS9FaLzMMiU7qmfgHaSBgFoit30nXjJOBN2hRf40OqYgMiicxNuHc0?=
 =?us-ascii?Q?CnyLlCbmavFUL9GGSfRPGYAUX8Y93Ki9/DWdLNM6MwuzNaZK8utD/a1P8BDU?=
 =?us-ascii?Q?pOlDE8w8R4DUZ68D3cqqAC0XFeXuZ0T4NEqV/FCTyZOvBHoUG7H/3xGU5vB1?=
 =?us-ascii?Q?a4AZ/xQAgmTMKy1ennhowlpG/PTAk3mEDUfFvCTkJWlAyIz3yO1j37mBPxtv?=
 =?us-ascii?Q?Iv+6xmcHr1j451yRizLrjA7GBBBEKFxLIFXPcgmxjaj54NmXXCyZP4ev0ms7?=
 =?us-ascii?Q?nyDWLB3scy/WTILPugFrY2YCbEtPeNQXEjc3YsR5tmUZWSWKTyP+DSw1SeOC?=
 =?us-ascii?Q?YXD+sRXtYWNj/bTK3L6CP/N9Fh+lzh/DeM02UKbSQHuehvB3ZT+GLwDrhsST?=
 =?us-ascii?Q?N7ohS4QG5WPYJkMEcRrpi8896hm9ilc0yfpYwKNP4khpR69Zd/0jqwrOqVGO?=
 =?us-ascii?Q?+gZ9EOgvmA2/YaU7J7bPNW1YC6xdq9HFK2/YNjzQqpVuYBFXDM4PEAgIi0h9?=
 =?us-ascii?Q?X/YGR2G9Clzboe29bXIEKKG/IQAeGaFWj3kyly+E9OmHOMTT9l+apLP4unA8?=
 =?us-ascii?Q?l/fYAamR8I+ceTyzu6k3XYb06cfcu2NJAbhOSiDDC33A6NK3y1I+SiaFXlKk?=
 =?us-ascii?Q?lcJBm2eO2KLSi5jhQBZFgci4wQGFtcoZYIwMTxec?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eb45abb-5611-4688-2edb-08dd0e02f2b9
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 10:13:18.3505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bWW9lRG06sSHmxhKUyWnoG+5L6IGLNm4GcrL0Jx+OPI9X8WBQ7p/wJ2GcXztNQbazTSJ7uF76oopiCPjpoPrfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6888

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

[Open issue]

The scx_bpf_get_idle_cpu/smtmask() kfunc's, that are supposed to return
a single cpumask for all the CPUs, have been changed to report only the
cpumask of the current NUMA node (using the current CPU); this breaks
the old behavior, so it can potentially introduce regressions in some
scx schedulers.

An alternative approach could be to construct a global cpumask
on-the-fly, but this could add significant overhead to ops.select_cpu()
for schedulers relying on these kfunc's. Additionally, it would be less
reliable than accessing the actual cpumasks, as the copy could quickly
become out of sync and not represent the actual idle state very well.

Probably a better way to solve this issue is to introduce new kfunc's to
explicitly select specific per-NUMA cpumask and modify the scx
schedulers to transition to this new API, for example:

  const struct cpumask *scx_bpf_get_idle_numa_cpumask(int node)
  const struct cpumask *scx_bpf_get_idle_numa_smtmask(int node)

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 110 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 78 insertions(+), 32 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 3c4a94e4258f..ea2fae2db10e 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -933,7 +933,37 @@ static struct delayed_work scx_watchdog_work;
 static struct {
 	cpumask_var_t cpu;
 	cpumask_var_t smt;
-} idle_masks CL_ALIGNED_IF_ONSTACK;
+} **idle_masks CL_ALIGNED_IF_ONSTACK;
+
+static struct cpumask *get_idle_cpumask(int cpu)
+{
+	int node = cpu_to_node(cpu);
+
+	return idle_masks[node]->cpu;
+}
+
+static struct cpumask *get_idle_smtmask(int cpu)
+{
+	int node = cpu_to_node(cpu);
+
+	return idle_masks[node]->smt;
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
 
 #endif	/* CONFIG_SMP */
 
@@ -3156,39 +3186,48 @@ static bool test_and_clear_cpu_idle(int cpu)
 	 */
 	if (sched_smt_active()) {
 		const struct cpumask *smt = cpu_smt_mask(cpu);
+		struct cpumask *idle_smt = get_idle_smtmask(cpu);
 
 		/*
 		 * If offline, @cpu is not its own sibling and
 		 * scx_pick_idle_cpu() can get caught in an infinite loop as
-		 * @cpu is never cleared from idle_masks.smt. Ensure that @cpu
-		 * is eventually cleared.
+		 * @cpu is never cleared from the idle SMT mask. Ensure that
+		 * @cpu is eventually cleared.
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
+	return cpumask_test_and_clear_cpu(cpu, get_idle_cpumask(cpu));
 }
 
 static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags)
 {
-	int cpu;
+	int start = cpu_to_node(smp_processor_id());
+	int node, cnt, cpu;
 
 retry:
 	if (sched_smt_active()) {
-		cpu = cpumask_any_and_distribute(idle_masks.smt, cpus_allowed);
-		if (cpu < nr_cpu_ids)
-			goto found;
+		for_each_node_state_from(node, N_ONLINE, start, cnt) {
+			cpu = cpumask_any_and_distribute(idle_masks[node]->smt,
+							 cpus_allowed);
+			if (cpu < nr_cpu_ids)
+				goto found;
+		}
 
 		if (flags & SCX_PICK_IDLE_CORE)
 			return -EBUSY;
 	}
 
-	cpu = cpumask_any_and_distribute(idle_masks.cpu, cpus_allowed);
-	if (cpu >= nr_cpu_ids)
-		return -EBUSY;
+	for_each_node_state_from(node, N_ONLINE, start, cnt) {
+		cpu = cpumask_any_and_distribute(idle_masks[node]->cpu,
+						 cpus_allowed);
+		if (cpu < nr_cpu_ids)
+			goto found;
+	}
+	return -EBUSY;
 
 found:
 	if (test_and_clear_cpu_idle(cpu))
@@ -3401,7 +3440,7 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 		 * piled up on it even if there is an idle core elsewhere on
 		 * the system.
 		 */
-		if (!cpumask_empty(idle_masks.cpu) &&
+		if (!cpumask_empty(get_idle_cpumask(cpu)) &&
 		    !(current->flags & PF_EXITING) &&
 		    cpu_rq(cpu)->scx.local_dsq.nr == 0) {
 			if (cpumask_test_cpu(cpu, p->cpus_ptr))
@@ -3417,7 +3456,7 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 		/*
 		 * Keep using @prev_cpu if it's part of a fully idle core.
 		 */
-		if (cpumask_test_cpu(prev_cpu, idle_masks.smt) &&
+		if (cpumask_test_cpu(prev_cpu, get_idle_smtmask(prev_cpu)) &&
 		    test_and_clear_cpu_idle(prev_cpu)) {
 			cpu = prev_cpu;
 			goto cpu_found;
@@ -3560,12 +3599,18 @@ static void set_cpus_allowed_scx(struct task_struct *p,
 
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
+
+		cpumask_and(idle_masks[node]->cpu, cpu_online_mask, node_mask);
+		cpumask_and(idle_masks[node]->smt, cpu_online_mask, node_mask);
+	}
 }
 
 void __scx_update_idle(struct rq *rq, bool idle)
@@ -3579,13 +3624,15 @@ void __scx_update_idle(struct rq *rq, bool idle)
 	}
 
 	if (idle)
-		cpumask_set_cpu(cpu, idle_masks.cpu);
+		cpumask_set_cpu(cpu, get_idle_cpumask(cpu));
 	else
-		cpumask_clear_cpu(cpu, idle_masks.cpu);
+		cpumask_clear_cpu(cpu, get_idle_cpumask(cpu));
 
 #ifdef CONFIG_SCHED_SMT
 	if (sched_smt_active()) {
 		const struct cpumask *smt = cpu_smt_mask(cpu);
+		struct cpumask *idle_cpu = get_idle_cpumask(cpu);
+		struct cpumask *idle_smt = get_idle_smtmask(cpu);
 
 		if (idle) {
 			/*
@@ -3593,12 +3640,12 @@ void __scx_update_idle(struct rq *rq, bool idle)
 			 * it's only for optimization and self-correcting.
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
@@ -6174,8 +6221,7 @@ void __init init_sched_ext_class(void)
 
 	BUG_ON(rhashtable_init(&dsq_hash, &dsq_hash_params));
 #ifdef CONFIG_SMP
-	BUG_ON(!alloc_cpumask_var(&idle_masks.cpu, GFP_KERNEL));
-	BUG_ON(!alloc_cpumask_var(&idle_masks.smt, GFP_KERNEL));
+	idle_masks_init();
 #endif
 	scx_kick_cpus_pnt_seqs =
 		__alloc_percpu(sizeof(scx_kick_cpus_pnt_seqs[0]) * nr_cpu_ids,
@@ -7321,7 +7367,7 @@ __bpf_kfunc void scx_bpf_put_cpumask(const struct cpumask *cpumask)
 
 /**
  * scx_bpf_get_idle_cpumask - Get a referenced kptr to the idle-tracking
- * per-CPU cpumask.
+ * per-CPU cpumask of the current NUMA node.
  *
  * Returns NULL if idle tracking is not enabled, or running on a UP kernel.
  */
@@ -7333,7 +7379,7 @@ __bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask(void)
 	}
 
 #ifdef CONFIG_SMP
-	return idle_masks.cpu;
+	return get_idle_cpumask(smp_processor_id());
 #else
 	return cpu_none_mask;
 #endif
@@ -7341,8 +7387,8 @@ __bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask(void)
 
 /**
  * scx_bpf_get_idle_smtmask - Get a referenced kptr to the idle-tracking,
- * per-physical-core cpumask. Can be used to determine if an entire physical
- * core is free.
+ * per-physical-core cpumask of the current NUMA node. Can be used to determine
+ * if an entire physical core is free.
  *
  * Returns NULL if idle tracking is not enabled, or running on a UP kernel.
  */
@@ -7355,9 +7401,9 @@ __bpf_kfunc const struct cpumask *scx_bpf_get_idle_smtmask(void)
 
 #ifdef CONFIG_SMP
 	if (sched_smt_active())
-		return idle_masks.smt;
+		return get_idle_smtmask(smp_processor_id());
 	else
-		return idle_masks.cpu;
+		return get_idle_cpumask(smp_processor_id());
 #else
 	return cpu_none_mask;
 #endif
-- 
2.47.0


