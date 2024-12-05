Return-Path: <linux-kernel+bounces-434004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD4F9E600F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 22:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5FDA28480D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 21:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9241CCEEC;
	Thu,  5 Dec 2024 21:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fmNx0YF3"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B628C1C174E
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 21:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733434014; cv=fail; b=ahfVKUY2yTSZrRnxsAof7zg6iOTRSeyNtmCCBH59kjTDuCAPCEsYwEwCg+rZoojK59rmdq00MI23zcLkcdPn+66irilkRJjO6oT5y2VoiawSM4klBbwTy6EqhwRVrIoVsT7fyournOtSN238TDziFhOwKU55fgC2xhGVfNWw5Wg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733434014; c=relaxed/simple;
	bh=fsq/esDAytcjFGHI+cRiDOVGp29YyD23DXEkuguka1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PYAgaJCPkKFoWAhC4QEAIc1v7ayxkcagKHMfw8W5a+vBwZC4ViX42UoKhYQADkfWjsfw7HK/D+hgAdNCO31rj7a1OlgYYIpboI6hkFCBlLkX8HuLerm8U3Yj4ygkXzNCxayLbp7GsY16TjpJ9u+0alC6bvNbB0NC6C5Pl/Kyo38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fmNx0YF3; arc=fail smtp.client-ip=40.107.244.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T5noUTFK5FIdJXSwRM/FkYLOFmmHoSGVSTHpzVXZaZdCmEmv7yyeENzbQF6wcPTtAJ0SLgGbDDE4R1TwsciY4wruehbJb2U8R9kkf07MAnDdTteeptQj61G6gM+9mkliCGUq+QCWKlCFp63YC7MtXNbXPpM+IrIWLUmcoBaa8rCdFpdAqA3wYYN0OPzTKpe86VjgMqEgscqdqhUAXupn1S6mNduC0TyM+38gj+qUSI0v4Ixgyd290VSLStmFpB46fy3ahFjFVgD+yjoWjjvhSxRGnrC0jk+KvMoDnMtzo1zcrbgTHJe36c5gKD/iG4o6+jqpB+2sEVzCug7NuIyftQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A3jYN5xHkuW7iz/2SYFhn752YjKjcE3bcHMRAlCJ+S0=;
 b=RmbmrIMiAT0vHClXUHz1utX14ZmGHh3hB4PFMLWy5W/e1QqrnErLPBo3akjMZu3Zlk8EjZcxYv61UirsiNJI8/P9i0H3w1wDUGDy2vhGL7xAfbIIVUSeHDsl3cyYepkDnHkjudDPWtFVssGpxecIB/6SsYDbtH9uVOIltIVwgJR/NerfI6OE7x2lWjk1Pg6r6ej72SqcLjwuJdkncrZA8m9eufdm+lpO97XVNJqVqNMok1B7dDMa652JY9hT5YmKMAGPh3BCx6LS+LUj5253kR8eOVyVYe8uAb3B7sQkakBI8W/o1dphvXoaKuuc33JYQSdI4WJpgAv80MWYO6cKyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3jYN5xHkuW7iz/2SYFhn752YjKjcE3bcHMRAlCJ+S0=;
 b=fmNx0YF3F/SaJCXfTg4w+Qj+SssvtoG0zKEhPqPYdCAMrsCXvxwCo7CkweiFjwPm8WLhnXvhX2i5LrH7r8+wcptco4nqTI4sEgRx30jOQV2A8Z7FUTRwt9y6qxGa3qxY3jmlzTrHlnzXqmKoRVodTKLqXI3agkyFG7EaEtoBlwPU6nNDcZcQnGn8SU3+0jJxjWDonbUqLhFbxFxURj6nBddB5a4zleh+3hfYLjzRmBj6UmbEf/uDpz+FSYYcayNNzpdjZOVH2TEQc4vUhzjGnhYzqjNHDrVCiji4lWhqcmaSp1HVZRvLm/uRoCej0llIzZGhTeiA15LcNBbikmD7tQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by SA1PR12MB8741.namprd12.prod.outlook.com (2603:10b6:806:378::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Thu, 5 Dec
 2024 21:26:47 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8207.017; Thu, 5 Dec 2024
 21:26:47 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] sched_ext: Introduce per-NUMA idle cpumasks
Date: Thu,  5 Dec 2024 22:00:23 +0100
Message-ID: <20241205212627.193016-2-arighi@nvidia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241205212627.193016-1-arighi@nvidia.com>
References: <20241205212627.193016-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0072.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::9) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|SA1PR12MB8741:EE_
X-MS-Office365-Filtering-Correlation-Id: 56cc2d4a-11f7-46bb-5e8c-08dd1573860a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3RfI/eEl02KG+rxRgPnH9IzARxxyRx/DHHyJpytG4SDSi+nJX+va/l/QOMo/?=
 =?us-ascii?Q?+bj9cZTE/mukYqFd/5M8jZm1Qnz8BlbHsQiwT22tbJ/MFK64Y33Y9tqreia7?=
 =?us-ascii?Q?J2QyWC8S94JZCuSZs8wTfwe4Fk7DoAGT84AT+ZHBChMIS6GT2tKf/bhfYDwU?=
 =?us-ascii?Q?1CzAv8K5mE2uxmf/VH+wJTOvHcBaCDaUj6APT/Ahwhcal9bZ2ZIhi0BIn9M9?=
 =?us-ascii?Q?weEJrF5ma8wEeSr46GWBJkDWLWXOLneiHMn1Yk0vhL6Cm7pUW5h52c4kmVKo?=
 =?us-ascii?Q?6BRj9AazJfpoQ+/SpoDV1kOiBAbMp4b9hoKun1MXVSY3B2lwoajm6Fxod5sc?=
 =?us-ascii?Q?ZsZOzFOk9uie9BdeWfF47tPxdeRNkldo/EkRRmUB3ZcS+Lus4XHeylSrJUEu?=
 =?us-ascii?Q?aKdbQWBcPBHVc/+HuiHxCrMqD4FFnm3kYQafh1MHMEihCfr7PIzfFAtnQ4Yx?=
 =?us-ascii?Q?+miYKGAvROu2yFl3D9hkizfJlyQWbR9IKc27wPdukcyHmTTdhfyKCRCbgQHt?=
 =?us-ascii?Q?Rk310tlLdbeeU258vDlXlwSqxI/ITOKl+i4W8JD5s6mDhJe9kMcM7SZGDsTV?=
 =?us-ascii?Q?Xz2s/i3316AVFp7ZggLfKJWCRNRnOSaKXnZoUnVSz/7PbV/Gd+5lmYYi/pMw?=
 =?us-ascii?Q?CHeXqp2J5loZkfJc+1xL5FsZ41dIabl78PLyNy8r8OU5pOov/zVuCdmVs5u2?=
 =?us-ascii?Q?YoeIDs5pityQZ/fq26crbRshlco1tk9Q7+rOYTWGyUWPe4Rv18C8U24AdyW9?=
 =?us-ascii?Q?lU8OTB5J+CAxQ17jcFwCMIsFnGQJVYa5tJmVPtLITY8DTN55RNwnnDwEskSG?=
 =?us-ascii?Q?dVazIFEcW2XWQ+0zxycUsq61Q9ejwYpcUmJpnfDuCfLqgpXQd8SYY+JGvPT/?=
 =?us-ascii?Q?RFdakaliguV+60BNKYFWiIGJRoJ6rGdcfRQ4G03CFwQ/rO9GpnGWGgLhbTNZ?=
 =?us-ascii?Q?ceYffaUdb7p20Y/WE2FLk9YxkUGnfl5ODt1k2DhAf/VDM8jTZiaIvx81zEYQ?=
 =?us-ascii?Q?DQmKA08nxBfhj52Cgx4Kq8Kcw5MqHJcDL9EZUvI93oLlR9prvdoEjdu9igjO?=
 =?us-ascii?Q?Qkeb8gYrts2VMT78oIIhhFIqva6QZLOx51rTqiFes3lfjninTLl/bCsopiFn?=
 =?us-ascii?Q?AWQqjc1fbPkV/p+Cc1KLC4Aya3z0j7ZGuymelmGI9EvEvMbEWSO5twSFn1Z7?=
 =?us-ascii?Q?Au5xcR/twnG80KLSZs2jBI1eeuT6W/VTaOMnae5HvCJeKrVSmiQ1UZlYIuMb?=
 =?us-ascii?Q?pTRnICrWA/WgiAiXzQh55o9s891Rq6Sdng39t1PhYW0h2S+kglgHevNMuHYJ?=
 =?us-ascii?Q?qeYjcRYz9BG20JPfRY4g/3PhbH1SnipCfVXl4TCJZB147w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2LKv5ix8Kie3osTJ/bSSuxrWZJOklB7r19Hi9EslDNHyYD/etVGWre1VnsYv?=
 =?us-ascii?Q?aeVg2pJQBW08T5j4PvYg0crrOylxdb+KgpMsO87cbrIT9zzuWXQOWbpsk540?=
 =?us-ascii?Q?sbQ+wtByTiK0+1K3tMKHyBRxEslga9d7THWIAsd9JD2Cnw9tO1z9lb0RTHMs?=
 =?us-ascii?Q?EGEQCPpZBjNesik28PHyRvOJFKIhfZp39saaCz2CoGheSA3MYFEB7Ta6ERS9?=
 =?us-ascii?Q?9wYv7swdB83NQXlwh3Db1gEVmyr6zGUREWonJu92sWkYLM01pI1xPfry4Xaf?=
 =?us-ascii?Q?Dy0TgehQC1OM4Z7sKTIcc1/xIJeE06SdVfRavrl0PRNWP5kEH2DvlflageQH?=
 =?us-ascii?Q?4Vh0Y7Bx/C6q5rJtPSzeHRB90flOHYuAzJc8e0+2Uel9gOoP3sGwv9cujflt?=
 =?us-ascii?Q?5LsIymLEsYhj93ALxflotkMDy9wvahYzDo0Rqik+rP3XUub5OlxWntfgA7bX?=
 =?us-ascii?Q?c0K+qX8Z4R7ufnluybLxW0pOX4odSptyuWn73kOljoK+sFN3hVI4rH5xds95?=
 =?us-ascii?Q?rngvy4stMboyH4Vp/SOGYk7XKQLxBobAzuiwuMc/24IFZ89isRRFGovgZ+yd?=
 =?us-ascii?Q?0j3nWApgSKaISkz1MZwvQu+IVPTt+/zOLquEFMucYyuHU95f/dgDIBr+aror?=
 =?us-ascii?Q?vLuOPI/jZAsEGkgdVcYSmehwGxww8PCe+u+9JjpZNTme6tZotcPJm/o097+y?=
 =?us-ascii?Q?rgzyD623E5tPNo08BCnk99JGOVuLHp5Ydcy/YSz/LkmXCu6HV9wawWS7xCDe?=
 =?us-ascii?Q?fitxGShPTx/nYKLHAczN69D/tUD1/QvMCiNP75y5HIDjj/FudMTHe+bw50tQ?=
 =?us-ascii?Q?hQ+xwoUbR7CuufNMXFhBTc62+ly+WecJvq/T1QYJE4VowzlIYVzsITRT86my?=
 =?us-ascii?Q?FvxQ5f03mM1EioBZNIFmi6vZxgDIaVEJefQtCSA/MMs0JWs1CH4+ap3yk1vr?=
 =?us-ascii?Q?LNe0zN/R+lUTWXri6QzNcI0GvOVHpTp4N3RDPkI5lmR2MMbRDLrYAhCOXe2u?=
 =?us-ascii?Q?gBC2sJOFUWLD2PcV2c+5PooR7cdFBsd2me4XadmRTSVmw5fXkUiDFGpx/U4C?=
 =?us-ascii?Q?TGkCGm7vEzOgJ/B7aJInHTaePuh1XXfwCmm5vVjdST3WLlzIdNynOy2nWowh?=
 =?us-ascii?Q?AMtpbrFUU/kM8YRKDolFWiX4aehinhLfnDaCuJuybM+9JCDGCf7cDAOX7OjE?=
 =?us-ascii?Q?CS7psIDmOMKT+v/xyesHa8g1mq/jQkBpGSVkexDB3uRf6CfN68iQhHn+ic10?=
 =?us-ascii?Q?UVigf9G93DEYwo9ssyy37s7daft0RSJQOx2d6AU4Fz/maCQYsFMgyThIug/v?=
 =?us-ascii?Q?cwoZlgBfKIVWgmPttSJxSC9STxyCR/KHDxaCFXeBeukMz5MdpoVtmRWznRPP?=
 =?us-ascii?Q?7mjpQnkeKCt4pmiLd4zSAi7lm+Cspflar9aaCqu+Ucou0qePCPaQufBk88H6?=
 =?us-ascii?Q?nQa1K/mVVgggDB8zncM0iYebR2E08R3GqmXZvjCulsFcRNm4HeKkoVZkqewH?=
 =?us-ascii?Q?qhBuaXWY+m98ViDkDBblTLJ8Oy67PBTP1yIZkSEmi7uaeHnyo07kE9DIRBty?=
 =?us-ascii?Q?S1kbwXmaiLiV28mg1QHztrYLWQRqocYYRwC69Ic6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56cc2d4a-11f7-46bb-5e8c-08dd1573860a
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 21:26:47.3073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ceZKzqeNdz7Dv0dgA4IheXLOFtp1kiysucA8Ty6mVynXN7G+HWj+mY5l7JeTt0s3PyjCQhJVZapkSKBZfBuOAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8741

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


