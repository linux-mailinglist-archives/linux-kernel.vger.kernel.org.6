Return-Path: <linux-kernel+bounces-382135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A30D29B09EA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 18:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E83002815B1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 16:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3ABD1885B7;
	Fri, 25 Oct 2024 16:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ko4keCOT"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEF0187FFE
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 16:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729873554; cv=fail; b=VYtR/0klOAFUo0mSOxrfgd+NxVXimS+IHsryEyN/lRHzBVAtGpMEfOXFgxUAHCXUzuWARKnSmG9uhlbO2l+PQTl6qS6TG/4Zy2mWpi586BLbwr6x+57dg4NvYqxXCTQPnyUPf7CvJ1oV3AYhhUd7mOXVVjI3HMQvBnGEqv+omuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729873554; c=relaxed/simple;
	bh=cZQbkEfwRhE9zZ1MdXuT4RPku5KfowIeodz89iPK2pk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Bz0Iq/HOx+bF22yVMFdnApbmj+TKHH03VgH7Zb8Q4WGUyrWRKXR8v7yKVynEK0f5eKlWb2qBqqRRxj7XxgX0vM5lyOkSwlfAWqlV5sUIDsj37wDQMR5Z1eiHMoDUW9+cT4brP4B2X66MaLWGPE6gbTRP8WQm7OwJYRBoY97oA7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ko4keCOT; arc=fail smtp.client-ip=40.107.220.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cjXmF6j0N7vn0mmle7XoXThZ3Iwn7m7+z2gWYLgJaEPMsDlrbuR8HF6IQjTWAKIi125NE9TBHuorlTzG00AOyJ6S4JRRYWm7RUBVttlUW5UdZWaxgrHMP+Sr01C73yriRKAJvGwJ4PhbblbJZwg+tAT3pQBlMO4jVMZP+N8YBlTw4OUTfLbcN78UCKR4zeFlFwS5FNOjWtUi6Z3IkECDDgsYkUWXqRJPR8gKUkqXisPOPTD2Ls927oosFNRYw8GcSF2rRVgNbf5IMk6TGOmamaC3qvLXul52EF4MuDilnlNumLKx/UOC5OVcUGahm05YYZhccyYaSNMt9eB7F+fELw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SFHUG+08MjalxtcrHtJ2+8k7AzGYJTqzWo+ftFPCMEE=;
 b=aF4Qp9BEbfb8CLnSYz5wqdiSUTbNcfVe+nBbVBCjbW9ccPtsGDYKpTMPe34LViKoT++1Cz/hoVyOTNEjl8t1Ag2GBdGtq2C3erSUIHTMz7uP7Fj6Y+bLjA08bFb9uzStHrQA4/cv1A1PkOoYtgbddTsex7PrpdiE6cgjMhYlYa3BTlhkp7rgZmD65GGl5UJZ0pmMZvXQmBmDCJ8cXOlXRf4UynZZLWnC2ZuKYzgIrC3R1bq8cRTBIMmEK9cCsCyEXILj+lRkyVOi8INbk+XLXAf0hscFxsZuNDXQ6gFG1LszdnNdksrc3fhXEGV2gcEgEDHM/waAqoghxaL/lsJ7sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SFHUG+08MjalxtcrHtJ2+8k7AzGYJTqzWo+ftFPCMEE=;
 b=Ko4keCOTKsDsub11ARgfF/XdfKtBBW6/Ok8z9vAJF3dbwgSJnA2cZGi913c8Hj3JddgWAPI/R0hib6929QXZ+GXYGK4UDwR2bJCbTuLgplY//g/COOhGFJy7NF2nQ0kC3f4v2bM+A+zFrnEmLlIDSW3wOjbTyujMAnbDgM3dNERA5mdfnD8jauC4QvOn1AYFBke0+2n7S8ONbXfznOfhk/rvRdkecHlLSkp6ncDsBwpvOIVBPINoCGCN/Gv8/nvJ6dVGHMqwDiGLPZlJMF+jcdMeoOfIMuK1Wf8S0PTw/FreLTrNyfykaj8hcspXl9KQiofFaZmuJDEgsGzVHtWyMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by CY8PR12MB7633.namprd12.prod.outlook.com (2603:10b6:930:9c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 16:25:43 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8069.027; Fri, 25 Oct 2024
 16:25:43 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2] sched_ext: Introduce NUMA awareness to the default idle selection policy
Date: Fri, 25 Oct 2024 18:25:35 +0200
Message-ID: <20241025162535.88059-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.47.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0181.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::14) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|CY8PR12MB7633:EE_
X-MS-Office365-Filtering-Correlation-Id: 15717f86-cc71-40e4-ac76-08dcf511ac51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nLp1B83861K5+z2AE1NUaZTG1d0Wo06VxahqDApSB2RiTIkZN9y2bkFHU6VQ?=
 =?us-ascii?Q?WuKeOQYC3Kj9nTQDryGSZvNSzRRmCXqRRBY4ey3aMflGDTTRzKRJGCAjndUI?=
 =?us-ascii?Q?RWpG/Ny5KWBGZykog6M3c9k5NdDbK+xnLMjhpFcT6MjSZpGX5MLlFo6SchuR?=
 =?us-ascii?Q?J5+F2d3JD47Q0ywsc7v/VTlVgkJoi2wQ3nw1LYN4YwVlCbRf6uBFKtbqOGVF?=
 =?us-ascii?Q?1mUHdI85ww6Nd0SjXHdaM/jL73csE7BYpUedE8Cx9v3PGz5ni6Q7KyXH3l4C?=
 =?us-ascii?Q?RjQRmtm119DIcKiWUtaLwi+mtC7h9RXKCg8D/dGNG4C0faf8/jc3zySYjhXu?=
 =?us-ascii?Q?YucBqY37JZtBgO0QWANomqs1EZp2DyNlNKbO/2HjcUieLTexIlDdOhS5Otdq?=
 =?us-ascii?Q?q+5BSLyVJ9jQQ16vH3Yq0zZ+GWuJQWws9rWkGN5UnuN4X5SkgjRlS9FDetW7?=
 =?us-ascii?Q?C3PdwjD3FzT5wE+bB+9R6b+x1tpSMEdvac3D92T5Zy9zdLG2PDYi3mB610WT?=
 =?us-ascii?Q?Xh3VUAOt1Jm/gMC9uoeJsGelcgvuLc/DTK1u+nb5UbMh8QCtMSaao/dkfwsr?=
 =?us-ascii?Q?DnHznNaIobGWNYwCcdwi0z1OmNzcn45JvGDku2UYMZ5jAGYKKggubRXs0UJN?=
 =?us-ascii?Q?i+AutrRAEZZJKXpBsM/y4iPK+nVyYYWm3fWh/mAQsMed5qUiq6kyO4gs/kDh?=
 =?us-ascii?Q?X6WnpfmUb+om1XEu3OPNfnW43zuFycszWHERwaXg2uydJavGyoRvgwRebFYH?=
 =?us-ascii?Q?Xw8N4qeRPMvivez1ISkUSaaz51DruS2YlGNM0E55EoO0W5kF5L6WoYFrpB69?=
 =?us-ascii?Q?zdOC9zI5NmMUJnAYEwZKnpQTy9Or3jgV6ix2+oOBySEfuN2kJLw035BcTaka?=
 =?us-ascii?Q?Gncb3/gMuugny5JsPkGa0h9qEVj+AeGJjYcFxN3TQZOOO2o3xCtirYQb3vr/?=
 =?us-ascii?Q?XeoBCJYPFAHs6Vvi67KcWt57DnikDnp9jf7Yb7ooMLDCV0a1uMHtyb8nRWY0?=
 =?us-ascii?Q?C7yXEyB0Rt4lwbMiniHkc7D5KX2FUh6CxZKfy2GX7c7Os9FzWcAovtKKOFvN?=
 =?us-ascii?Q?CrTLUd0FUDT24gE0Bcyv0bvdRUVowM9rCDrFyxadhl5ZiUnGZRNGTvx2j5Rv?=
 =?us-ascii?Q?E2xDTBHM5QafWp6q+tpzycurU0HashvEfEt5RRPJ0/3I3pOuC53txY7gBtwQ?=
 =?us-ascii?Q?2y4BpKAcaefGG+Jtd3uBk136EbaSbr3KNavqoDfUUBLIv7O6MH+wU/oKfHUr?=
 =?us-ascii?Q?4wTps+123618ZP4UUEWi80chXapTTjuaMmkwdTdOPJLaOXzJt/qEEphgx3hk?=
 =?us-ascii?Q?wLKKindWcBOtVO23HT9lhfPU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u8jX5tO4+tb3nu2sQbHTYA7mPKLFXgeTNJPy2+/Oo2aga8WfvqaTC0MsYsCc?=
 =?us-ascii?Q?XVTgyX6RXAlNekbdkuDVuh8QHosMiCtLcoJtgpOtQJ2vOXg2p2KxnVdVtGxR?=
 =?us-ascii?Q?USVVM+x9kWTb8J9IIrLk6f70k39OB6f3Bf9Ywvex/d1aeKW2cuDxVfxCULc7?=
 =?us-ascii?Q?Xal9VLp/RcPWhjoR+4zu4cwhWVao44I8taambZt2HyjWxJIOhz963o+LQia2?=
 =?us-ascii?Q?i+npn2ZL9b1qQ/lDHST7kSiXuBCPztpoAIG5EvjViNJ8i0XsSGs9RDFSSuRk?=
 =?us-ascii?Q?9taCoQzpE4EXUjGt7sx/54CX74U+HQsJQ3oMSjj09mx5x2fe7BDPKy3VcOhe?=
 =?us-ascii?Q?9h8+ZpXFglb9XqWFTIKR9XHc+ankMPDS2JHjviqYuinW/LXjpFaYH822lb6q?=
 =?us-ascii?Q?UCMPiAQnPu1SQyx2TwIT/xY7wb64M52CsGtmoA5pB+nSIEKdLXH84g/y/oEc?=
 =?us-ascii?Q?1qETtgc0zuy6GOTZdrlYi/bF7ZD9nn01aptDbt+rrbyfkJudo83nK6LqSJId?=
 =?us-ascii?Q?2GPmNq9xWewpO4fgNim0oyVc/s4ZFqmTW+NwlwfuyvtG34meHY3YP7tqld/n?=
 =?us-ascii?Q?gTkTQlIaJbUi6M8fnQ8M9WgUOngZCxFZr/XaT0bYOXJUwInDKFUdma80cxhW?=
 =?us-ascii?Q?5MIOgIP7YhHQKylR/z5zY2cK0WhZ5OFU88OHzUSInnYcSB/Z34MUnoiZxQfO?=
 =?us-ascii?Q?lbcE+DN75HdUKvz6SQWUe+ULA9O4Qj5GJK33q5k3WEMTVbfh8f12MRuR/TsQ?=
 =?us-ascii?Q?kQsfKgzqbwmdVPkWvOd8uxbxc3UBbQWCRTyleelz3cREWR4WKOe9DheA4YJM?=
 =?us-ascii?Q?ZMoZYRCbFwAmvGjUzX0sUw9DuXYQPbXvWOojn6HjMSXkI/vk+e7fTmv7CWKo?=
 =?us-ascii?Q?wf+KTgkkTVf9NsH1cHOIQ5vvKqX3fJKP+BFT5ouRfFwVWXQ/tazJhIZw7C0g?=
 =?us-ascii?Q?XVYz3Ub+k/lei+O8x8PkjHGJiREmmnJyv4Uthsrz+wLjLqXmoAI76uYYldrh?=
 =?us-ascii?Q?wF3tG1FpJD3ncrxEXznYaMVJZ5ZAXpqrCGhiqAuUEFwFuDRm2pzB0hV41lll?=
 =?us-ascii?Q?N3clQmrW0A8FAAjSQ/hPqxJWxLnc1nAx6KkDmRFeI1PqAWgF4mDewlLTki5M?=
 =?us-ascii?Q?ryAXJAgD7yNZV4jExsVQlKR52qDefLCr3xUu8fqWp26+vc5yrzxA2Eydn/OD?=
 =?us-ascii?Q?wK4s+X3ucQbdyOT50W9mape7XdRulq5dBSWS1X3yCgiXQAhzTO9XtQbuABnK?=
 =?us-ascii?Q?rQMQBqCyVKVAlV+DX+mQSBeH3jpyX8J5YU2SrBZD/qC8zGJZwLtIEgPYy35K?=
 =?us-ascii?Q?l6UIP7vaA+osarGj3ZrRbomQLxOQdwhPkjfOm581CLtKA7Y177jcZmMjSDzn?=
 =?us-ascii?Q?iBb/1ZWoRykMsQtbpd6LV/VXcstbe8QMX/97AqzLaZ3/tR61zzq9a6s+Ei3y?=
 =?us-ascii?Q?5nL9qM1MCpu/ExNtBkPsJhOr3spuDUK93AqBhFQhi5zlC8ID4+nkDGE6qwV+?=
 =?us-ascii?Q?aoojPyca8jwHdIlnKaV5G6P/lzH7w20W886Ri5wD2u3Q8h0+rn4sF2fCUlEd?=
 =?us-ascii?Q?7JUxIAfLSZ3BKdOHFWlOrHBaaHUElfQdsRQKwCUU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15717f86-cc71-40e4-ac76-08dcf511ac51
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 16:25:43.6456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /biSrcLry9aCpGFIclhVfrNSjakOw1AX8Qqd9dlCWaTTPiO4QbrKY+vHSaH3dtoIGYf8K3wPEntZAOjA20POuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7633

Similarly to commit dfa4ed29b18c ("sched_ext: Introduce LLC awareness to
the default idle selection policy"), extend the built-in idle CPU
selection policy to also prioritize CPUs within the same NUMA node.

With this change applied, the built-in CPU idle selection policy follows
this logic:
 - always prioritize CPUs from fully idle SMT cores,
 - select the same CPU if possible,
 - select a CPU within the same LLC domain,
 - select a CPU within the same NUMA node.

Both NUMA and LLC awareness features are enabled only when the system
has multiple NUMA nodes or multiple LLC domains.

In the future, we may want to improve the NUMA node selection to account
the node distance from prev_cpu. Currently, the logic only tries to keep
tasks running on the same NUMA node. If all CPUs within a node are busy,
the next NUMA node is chosen randomly.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 118 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 101 insertions(+), 17 deletions(-)

ChangeLog v1 -> v2:
  - autodetect at boot whether NUMA and LLC capabilities should be used
    and use static_keys to control their activation
  - rely on cpumask_of_node/cpu_to_node() to determine the NUMA domain

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index d7ae816db6f2..af2ffafda296 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -869,6 +869,8 @@ static DEFINE_STATIC_KEY_FALSE(scx_ops_enq_last);
 static DEFINE_STATIC_KEY_FALSE(scx_ops_enq_exiting);
 static DEFINE_STATIC_KEY_FALSE(scx_ops_cpu_preempt);
 static DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_enabled);
+static DEFINE_STATIC_KEY_FALSE(scx_topology_llc);
+static DEFINE_STATIC_KEY_FALSE(scx_topology_numa);
 
 static struct static_key_false scx_has_op[SCX_OPI_END] =
 	{ [0 ... SCX_OPI_END-1] = STATIC_KEY_FALSE_INIT };
@@ -3124,31 +3126,68 @@ static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags)
 		goto retry;
 }
 
-#ifdef CONFIG_SCHED_MC
 /*
- * Return the cpumask of CPUs usable by task @p in the same LLC domain of @cpu,
- * or NULL if the LLC domain cannot be determined.
+ * Initialize topology-aware scheduling.
  */
-static const struct cpumask *llc_domain(const struct task_struct *p, s32 cpu)
+static void init_topology(void)
 {
-	struct sched_domain *sd = rcu_dereference(per_cpu(sd_llc, cpu));
-	const struct cpumask *llc_cpus = sd ? sched_domain_span(sd) : NULL;
+	const struct cpumask *cpus;
+	int nid;
+	s32 cpu;
+
+	/*
+	 * Detect if the system has multiple NUMA nodes distributed across the
+	 * available CPUs and, in that case, enable NUMA-aware scheduling in
+	 * the default CPU idle selection policy.
+	 */
+	for_each_node(nid) {
+		cpus = cpumask_of_node(nid);
+		if (cpumask_weight(cpus) < nr_cpu_ids) {
+			static_branch_enable(&scx_topology_numa);
+			pr_devel("sched_ext: NUMA scheduling enabled");
+			break;
+		}
+	}
 
 	/*
-	 * Return the LLC domain only if the task is allowed to run on all
-	 * CPUs.
+	 * Detect if the system has multiple LLC domains and enable cache-aware
+	 * scheduling in the default CPU idle selection policy.
 	 */
-	return p->nr_cpus_allowed == nr_cpu_ids ? llc_cpus : NULL;
-}
-#else /* CONFIG_SCHED_MC */
-static inline const struct cpumask *llc_domain(struct task_struct *p, s32 cpu)
-{
-	return NULL;
+	for_each_possible_cpu(cpu) {
+		struct sched_domain *sd = rcu_dereference(per_cpu(sd_llc, cpu));
+
+		if (!sd)
+			continue;
+		cpus = sched_domain_span(sd);
+		if (cpumask_weight(cpus) < nr_cpu_ids) {
+			static_branch_enable(&scx_topology_llc);
+			pr_devel("sched_ext: LLC scheduling enabled");
+			break;
+		}
+	}
 }
-#endif /* CONFIG_SCHED_MC */
 
 /*
- * Built-in cpu idle selection policy.
+ * Built-in CPU idle selection policy:
+ *
+ * 1. Prioritize full-idle cores:
+ *   - always prioritize CPUs from fully idle cores (both logical CPUs are
+ *     idle) to avoid interference caused by SMT.
+ *
+ * 2. Reuse the same CPU:
+ *   - prefer the last used CPU to take advantage of cached data (L1, L2) and
+ *     branch prediction optimizations.
+ *
+ * 3. Pick a CPU within the same LLC (Last-Level Cache):
+ *   - if the above conditions aren't met, pick a CPU that shares the same LLC
+ *     to maintain cache locality.
+ *
+ * 4. Pick a CPU within the same NUMA node, if enabled:
+ *   - choose a CPU from the same NUMA node to reduce memory access latency.
+ *
+ * Step 3 and 4 are performed only if the system has, respectively, multiple
+ * LLC domains / multiple NUMA nodes (see scx_topology_llc and
+ * scx_topology_numa).
  *
  * NOTE: tasks that can only run on 1 CPU are excluded by this logic, because
  * we never call ops.select_cpu() for them, see select_task_rq().
@@ -3156,7 +3195,8 @@ static inline const struct cpumask *llc_domain(struct task_struct *p, s32 cpu)
 static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 			      u64 wake_flags, bool *found)
 {
-	const struct cpumask *llc_cpus = llc_domain(p, prev_cpu);
+	const struct cpumask *llc_cpus = NULL;
+	const struct cpumask *numa_cpus = NULL;
 	s32 cpu;
 
 	*found = false;
@@ -3166,6 +3206,30 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 		return prev_cpu;
 	}
 
+	/*
+	 * Determine the scheduling domain only if the task is allowed to run
+	 * on all CPUs.
+	 *
+	 * This is done primarily for efficiency, as it avoids the overhead of
+	 * updating a cpumask every time we need to select an idle CPU (which
+	 * can be costly in large SMP systems), but it also aligns logically:
+	 * if a task's scheduling domain is restricted by user-space (through
+	 * CPU affinity), the task will simply use the flat scheduling domain
+	 * defined by user-space.
+	 */
+	if (p->nr_cpus_allowed == nr_cpu_ids) {
+		if (static_branch_unlikely(&scx_topology_numa))
+			numa_cpus = cpumask_of_node(cpu_to_node(prev_cpu));
+
+		if (static_branch_unlikely(&scx_topology_llc)) {
+			struct sched_domain *sd;
+
+			sd = rcu_dereference(per_cpu(sd_llc, prev_cpu));
+			if (sd)
+				llc_cpus = sched_domain_span(sd);
+		}
+	}
+
 	/*
 	 * If WAKE_SYNC, try to migrate the wakee to the waker's CPU.
 	 */
@@ -3226,6 +3290,15 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 				goto cpu_found;
 		}
 
+		/*
+		 * Search for any fully idle core in the same NUMA node.
+		 */
+		if (numa_cpus) {
+			cpu = scx_pick_idle_cpu(numa_cpus, SCX_PICK_IDLE_CORE);
+			if (cpu >= 0)
+				goto cpu_found;
+		}
+
 		/*
 		 * Search for any full idle core usable by the task.
 		 */
@@ -3251,6 +3324,15 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 			goto cpu_found;
 	}
 
+	/*
+	 * Search for any idle CPU in the same NUMA node.
+	 */
+	if (numa_cpus) {
+		cpu = scx_pick_idle_cpu(numa_cpus, 0);
+		if (cpu >= 0)
+			goto cpu_found;
+	}
+
 	/*
 	 * Search for any idle CPU usable by the task.
 	 */
@@ -7315,6 +7397,8 @@ static int __init scx_init(void)
 		return ret;
 	}
 
+	init_topology();
+
 	return 0;
 }
 __initcall(scx_init);
-- 
2.47.0


