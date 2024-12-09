Return-Path: <linux-kernel+bounces-438532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4734B9EA25D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 00:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24299283516
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 23:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56651A0BC0;
	Mon,  9 Dec 2024 23:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CXo5dLLJ"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0431A08B6
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 23:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733785393; cv=fail; b=Njf23kiU4rV9RD+a71WGGhikMaL/FK6fsF4h6EyJnlmtXusBk0kFyA4AvIN1AfLhlbY8RyHsi+IFmC9VFrAmox3VBs91sPVZXmCn+HFIg4RotKDqBx2hMK/EZ1S6Nj5vAwN0p1odRi/MGLb5bhX6XOthNmACF2LJBNyyOYw/00w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733785393; c=relaxed/simple;
	bh=/88HxKQywm5qjrCaflJTgev+5Q5ZGZE5mZixq2WZb/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Tc4NS+8UxtLVUvIuw7H952N9fRNO+n7ccyABIP1eYb/HxKb3yJaNIIhkDPopRT3H1FZf69G6mpA1ZH7kn46CVMaKkFEGioTX2SlXs6+E8L7s1D2X7pxOBjlcDOkfzkNBZCNiE4njYYL7Nhqy3vJ1mHB3X+HQA8yFX2MtARvVlRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CXo5dLLJ; arc=fail smtp.client-ip=40.107.236.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U/A6in9kv1XwgxShNuMxW4lryqFtaj6Rn8VrP+4sHF0eviDbcZI11TDWgaiFwLIm0EhVmrnoEaxLjUpl4gZxODpLGV9SFGO+PPG7VHQ3PZRG9TlSpvqMxTSyBybW2HytQIx+LPyFprer8lGV2Y7TzL9ivjDV9Pa5C2VnaXSdKzyiInaNx/7NXlR6mRBF7uPPhuEaOTOxdPvq8QUtA/539+GMpdJtP+pKyG0GzZ8KEqrxA9u5B+x0ledxlbIDA874mglmXkalfjgcyE1XVDojZHaSGU6uZRaNv6p41L/eP6XUppCBffnnv3gAEq+EHnRiqNhYWUEbAiJ+ONh7RKcs2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=stQCG2dzogENcGuXZI3J7+lNKDYaE4YtYhdByu3ZDfY=;
 b=humowKs5gbmZS0TUrm94f2QgfEtGRo8+Z6JTg5L3M0upwCXqm8Jcyzuyu12z2wa64uIjbWTfIGwGDk6IrZhLbAPWlm84oZ2f9ORmFDM0Rqn00RCk0BJ4Bnqz2oXbL4goH+UcQ4IBDWKHQpEdCsbxtGEfZuCAnUmjJFSMqG+avpAX1xfaMLvnb2Ox8AdRbBpo460r44gKacuQFg33JzoHQLbSROPKOWc0THq6DtXYl64w9Zvs2XfzrH+L20WbHE1kupcsDhgc14E+d1Ffj3LfiEBjte5nL9jXjYNliQ7Gg03RVOPT+0r1qZeDTvbUBnZvM/Bdn4PF0yBhFW78/LDMGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=stQCG2dzogENcGuXZI3J7+lNKDYaE4YtYhdByu3ZDfY=;
 b=CXo5dLLJkgfmWgKpwYm7XUFT3nPcQ2BeLWJPnmx1iOJV8Pac399G3qEvvDpyCzeK2QWBN7kR4/jg2TXFXjuEk8vi5oGMLcSNGP+i1Sxt0RGLE2RHNX5oU+btXQ3crsYVXxTghYBWWedrr+JRiD1gZbPQuFYDB2z+ggq9kN6GLrEV43Dv6GjvdGJBEZnVOn3061zleYAktTATmMPcdo5sJT1L6S4uvlJc6gCNdlmhRWNwRwO0GveclmZmvXffAYli5Z1sabuINLXcJdYv0e7GLUxPAAqKwvehWrWxL6feEGuK5FHXRl9ZblJO2YEin0YITJmrDLFrSEROdIFrROXPhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by DM6PR12MB4297.namprd12.prod.outlook.com (2603:10b6:5:211::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Mon, 9 Dec
 2024 23:03:08 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%3]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 23:03:08 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] sched_ext: Introduce NUMA aware idle cpu kfunc helpers
Date: Mon,  9 Dec 2024 23:56:29 +0100
Message-ID: <20241209230242.775225-6-arighi@nvidia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241209230242.775225-1-arighi@nvidia.com>
References: <20241209230242.775225-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0183.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::11) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|DM6PR12MB4297:EE_
X-MS-Office365-Filtering-Correlation-Id: 658240e8-f0ac-455a-7e5a-08dd18a5a5be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1Nl1UvZ/3I7eDwicFpRX3y0D0tWBjqvryouWyNmTn+tW+HQ2RSKVOq4hVjWn?=
 =?us-ascii?Q?B3teXUIyNK9AsfSlKhfYJPbJ+cW7oc48dtTkS7LeeL9GMI+0IIGj0kMB5hK5?=
 =?us-ascii?Q?T9BPNsnphT99ZBxjrzlbTpyF7DZcFNdO2TnYh28VDdzgsG+5Vtz30lsC18mN?=
 =?us-ascii?Q?kHv6JrWQopy3FRhcEu9TFDxDS+SIKcgGecXX+koRBhWKadZlYnsDcU4nYDJY?=
 =?us-ascii?Q?yfOOnHd+6jQswAC4oJNhlwg7oxsJX0AYMXsDEA3FnT/vBsgWSHriSwE3inxd?=
 =?us-ascii?Q?atAk0WU67D7GhiGuW3eCILuGMGy5qhYeM2uO5DZwj0KeVZfKjv7ZP5thPK4E?=
 =?us-ascii?Q?Yn/k+qNJVpidNTXMdvfFit8ezdbraYKzruHyOmxo6SzCz1OqJ8QmeDlLfuyG?=
 =?us-ascii?Q?3r0CvXvSIk0/l8TuCa7M2rdAgHk1XYYUBlUGALmMFPU3pQQVZN/YtIWCd3Oz?=
 =?us-ascii?Q?9bxsfeRr7ev+ImJuZTPeY/FN6/X9ZPnLIXEZ0vQNS6Rte07Q3IgVRWfGP81Q?=
 =?us-ascii?Q?jgN7hoM/TpvoszL7ZUcjeXPrXVsZ/zXRzNL1e2nS7H1N2y8ZBpZcQUgHqNol?=
 =?us-ascii?Q?xb+pWOjXS7YbQhFTUh5YU+BnpwVOBoatDbs+Zlqb+cO5FXn0eY2S5lYKdYcq?=
 =?us-ascii?Q?0/QX83DEH0CKfyR7IzVDS9oQ1lKD9oXsxuL0BM4xztv1icw2I2vxHY61BBV2?=
 =?us-ascii?Q?AuSwqO2HFLUZP3OGO5MvWE8FAlhiibn4Kb7hGl7jNaOfBIwlv4ITR2roOcZR?=
 =?us-ascii?Q?SOvgqWjakKQLqOrRPokLc3E3fvOcHNKHCuxYmji2TRtkHAULnkyV8rW9x0kH?=
 =?us-ascii?Q?zdrvRkW58orQmAn7Xr9/7kpphUJbW9X23TQ3TZ87/c9PIcwo/WY0XoaU/nbk?=
 =?us-ascii?Q?QoYn31U5pbmRoH6BT9N/lDNSd2SjiDOmk3Gvbrt//L2sHZbwKho0Hftj8pyF?=
 =?us-ascii?Q?MBfi1MfONIkDs0uaj8HvPPuOjCg+B3XW+lKdDBK52NZYg2D4k/PMmHXmbVTI?=
 =?us-ascii?Q?lQJyBJrJgELRpybE+uwroJrcfT5nxQLFGfHsX+hrLcFhBhTprQH0ffn51/zl?=
 =?us-ascii?Q?iI6l4rKr0/2M9athm1ziX/e/BHN132CmolhrUWrH3XwXEZ06/LzYrjq5dQf7?=
 =?us-ascii?Q?xirF/cFe2iPSpnES0mjrg4NKThGRyRaKgNcEJm2WSCcaZktKj/nWX68dOgax?=
 =?us-ascii?Q?6QKyy91sKsG2pscLfUxYXI1cJLLtaCjzJSRe2yV9KzU8bXVqtcGi5Z8XBTeZ?=
 =?us-ascii?Q?u1Hybb60VMRP54bwLT02BDYMIWiOjLhY42f8znIZppM8LHGb1nXtxwYPzxFC?=
 =?us-ascii?Q?Bxnz9znog9xaHlxPzw61x3B3hbb97e/NAP/h+iaHtHYqEg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+0QAD8WfkX3mx3v0PriU3cDSsyxUFtP0YIzhf4nAxbAeR7FKnI8NKjNpVKNj?=
 =?us-ascii?Q?Uaksm1/WFM62Y2jof7A8F7myoFc0ez6RmOZxRAFKcjW449V0zxBxiAcPrCWC?=
 =?us-ascii?Q?1K1PbD7uQ4oDOMqPSaU+1kiFbmTrEGhL/8fRKAKkjnI0Ov5MApg8I3LH5dqh?=
 =?us-ascii?Q?TdnWb5uEOvny9iTYbwEEdxZkCUC5fcioBNeNXKABvOXdPnq6OOx3aGh3f1K5?=
 =?us-ascii?Q?fsGi0YNpnOcAHVfL4snAIi0sElCEfcypZQb5lJorHRQWNfvQgV/3Jyn7tnKw?=
 =?us-ascii?Q?S8YtVlMxe0IhvEiPI0h5h3FG5U/JXp4XWn+RUfnf3fhB/X6h9h8pBGz79yeh?=
 =?us-ascii?Q?7bTG1vxAGpnZlxyw+vI855sdlNDd/Ntpb/YhVEmoq5Iwtk9lnTJKYvj2npOx?=
 =?us-ascii?Q?57rCBtw8TqhS8RFreOEqQlbCbwz2ir4DVDfdSy86tN/IrcOxhv4klAblAciv?=
 =?us-ascii?Q?D6BYxHgD/aJau6psTNiQw1cEVfYlNAx+2DWOcFVGMM0XG0Jvwnx0Px2kLW4H?=
 =?us-ascii?Q?25gcuMuLJ8RHN0k7w3nUYrl2G+7t9CisV8WjL6s7HmkfJekXLh6CBzwQpqE0?=
 =?us-ascii?Q?fv2FyJ2ALf4BwJggia+WgbSRnfUZUnaNBiw9j6h43iLgI+UUZz20opxD81dR?=
 =?us-ascii?Q?GR7HCNYGO+h2eXjs8aw3zVccNywc2MI2hHT7ur26Dl/eDroxt1jysi0aqVQ4?=
 =?us-ascii?Q?yVGvvs+CmrQFiTOXf+t5q/kVhFlh65bsjCQ4PNLZhxVVdCAuZfZgT4kikmrW?=
 =?us-ascii?Q?zULozQp+bNGtvf3EpMDeVYvz4rXzMeJFUE2YZofw1E+FhC+2Xa5C3TZLsKax?=
 =?us-ascii?Q?gCipX/zkqsGLoI3D8Q30WXdT0lHUPJxk7xSY40R6mhb0/pwysMUl7QhfwRBO?=
 =?us-ascii?Q?4UbjSA7B2YNgHAYIwFYIwhxqfRBHkR21kwt3CvFwxgMV4GL1068qOFHfvyU8?=
 =?us-ascii?Q?b2PIIdKr6I2XkWUhQO+HBWE+9tmaFWK+dFyjqC1oJjwx1Afq7MjkhTUZyZl+?=
 =?us-ascii?Q?D0OT/LikLF7YzCmDZIgmv9Cc1IeEavlUwHpDXLP/UYhubeOmaJQs1NhCoZER?=
 =?us-ascii?Q?I69b3si8PxjiPONF/qYuR1AfkEAKQR6ARV3YGannkdUKryx139dbs74BKWhj?=
 =?us-ascii?Q?Lsq603xbACBW0ZdJKqE3a91h4aC4LaCCXv8Bu9OBpSz9Q4IcpNF2AuAdUK2b?=
 =?us-ascii?Q?m10i1i4Pa3kYwmZwiuO3GCKkxM6qipHsCzFEWIhUMsSnE1TcoWLycAG/74Nk?=
 =?us-ascii?Q?neo0XkLlo+ITumdtnCsiH93aRloCgXEX+15jjkQCMMeRw/pnE53NgfRv5mkc?=
 =?us-ascii?Q?/nupmAFTJNRw4PzPTB4GftLMgZBa41Wn1KzoOekWZfyqkYDcQa0jfhOL7YLP?=
 =?us-ascii?Q?ab0PogE797UwwOuGZYRdRddtYExeE6nSZTjDSxCVCUEPhBX6c6kB2AI2KxNT?=
 =?us-ascii?Q?wUsqlsbmSYfAQ8itu4DGRQ1xbOSzCJ9ZYUXwEa7fF1qEtipoTs3Qflzek5jN?=
 =?us-ascii?Q?SzTiXe9U5N9MpESNcsQSiSPMShsjiLaNVXr/4DlTtb7AKJmpTeeqYFaGihn5?=
 =?us-ascii?Q?HmsI0SzI7nOo5h9PU4xtrLzulZ5VGLo2eHPR+O2E?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 658240e8-f0ac-455a-7e5a-08dd18a5a5be
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 23:03:08.7121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0bLAjdFz8p2mpmQTNIr3lkJ8T84OyFzHtOMoA7eDX4iSkKU2RZT0FJ/JhA+57ZYVfUQh4y7puMbxglq/xB3n5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4297

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


