Return-Path: <linux-kernel+bounces-434003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 317049E600E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 22:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFB6718849F5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 21:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828B31C4616;
	Thu,  5 Dec 2024 21:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PTn16Sex"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D0E192D69
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 21:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733434012; cv=fail; b=GuVcj/tIK9w3U5LDPEOf8iUUWiKygAtmFe6fYzka+yxk7SIr1ofEiLBfXl9B+BkZmZopIqFMSb3wfctqmQRHlTszL0gYsu5F9D2mZ99JQ9v+bB7ONQ+6YQdVKlCzllPcSqkVict1Xz1Z64S8EK0oyDo3cdJG5NVMNNev6OKRCLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733434012; c=relaxed/simple;
	bh=nR6isXD2Xf5iPQJZfIFIZhi1bOQOSdiQ+YY0h/FnXDc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nx11RbrJH/XsGFvyP9KU2myrzDxLUpPjOWWS70PsuKX3GrLoe6a/cYg0z4hEZvGdQXVklE0dDcw9QIGkgmb6ZGIgRwNNTY+R8saZT0+MdDMHzwf+ctQfL0O0p6qv+tiTxQjRjufTluTHB9RY4+ibpNs1YldbG9JbjsKV6VPOF+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PTn16Sex; arc=fail smtp.client-ip=40.107.244.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZGoDuF6gExl/iZWtz82d+G2AqsnryjN/QEjykfGdv+jQhQFQIIIMHzkZhCN8zNFYX0PtFbZLEMfgeaP0yXUTC7rw1XNNkun52yk3nyvQibC9tkknLKDMZTyNYpXE8nqSHSOv+5S24iWIBsd2LWxUeRCSx+DndXSi2yeCc6kLltTU4HADCtnq5/jUbCdIR8b5e9BW+8/U0k8n30vBr+YAnGrSVR/5OcX7a7wM+Wzx2tJHN6yr/4dECSTaMj57kiOJ7Nmho2CAyh1RfKxdTuKESMll7FjCERDSDD6DyRyAhqKSKQ3CrFSu35Q5Vg6lEcWtX9JALIRqjX44dT3RVyLkTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=91uLot++0iiQ0zSEaanSlJtMnIzRKjPK3QviHsRcJbE=;
 b=rrYvdNTj5RNaW7rE3+75B+reX5WEzgtYi0i/7km03fFluoVUpr4tyiTnrT3/h0ZP7gKu39OF913n/DDVqeEIhEk1+ZuXHEpdNtNVq/kQ9i/x1gAlzuzy6L/aTY+whIOKbD3bawL5eZUgyG+Kf2R9bXUq68F8u840VEYky0r6xhanVbcsxKT16oJUoFwq+LhtSsBrM6tNgIio5dh5j+ku0VQ/bhNdhq3YVrf3S9SovvVhN79UJ/LZ2EsayPFq7+vk5/akVt1DfyAsFxvVSW85teVDkbtlfwvizCJpgP0M+ajIx5sG26TuDaqWmqo0SBmPyG6XqcaN2+ubvvBjOZJBEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91uLot++0iiQ0zSEaanSlJtMnIzRKjPK3QviHsRcJbE=;
 b=PTn16SexQS07beQZxNIK6PZjlkokMo6lFaOhk6zFL7RKa66tuTYXEpqgNPuJl1cXfdSe3zIBk3m6mAOlEWZMxv4PD5D/dzYuJ/JWFGPCj2a/4Sh9DSKfkGBKSZPCK4rFj2YsTMIYvEkbjoBaK0T3ICZSjAZwBfNU2IxWMdL6lBk6qJ3JhwVTBrqyniAH+1g9xMPgF13Purz5CBlFP9WGz4eDUCrpQGHwwAGwh8zx8/XtzWyE3DAxvdheqV5NHsweh51Sp/DDKUShuxzpChLDBmeQCKMfChHkinv7N8Bms/g1tDzGpYPSNjJ+6d4hHoUDK5y7j7ASY7MrqvONk3bNmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by SA1PR12MB8741.namprd12.prod.outlook.com (2603:10b6:806:378::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Thu, 5 Dec
 2024 21:26:43 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8207.017; Thu, 5 Dec 2024
 21:26:43 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCHSET v4 sched_ext/for-6.14] sched_ext: split global idle cpumask into per-NUMA cpumasks
Date: Thu,  5 Dec 2024 22:00:22 +0100
Message-ID: <20241205212627.193016-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.47.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0049.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::22) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|SA1PR12MB8741:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b84ee02-1102-4804-abda-08dd157383d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?klmP70o6WqB+uXR7ET0D3vnOqidLnt/GRfH8KKF1ICXulCAUwiQBzavVKiqw?=
 =?us-ascii?Q?saNl/CpY1s21yaIC+aSazN5S4kTz4UceBVo5jL5F+puWWvYXZ61sCdWCv/sf?=
 =?us-ascii?Q?/gSEA6+CSIAB+V7zSX5+hc38zRlaTNZHYHv1ZEa6wi9ZnVR3lK4LjLv4hr1c?=
 =?us-ascii?Q?zx+HwxXWLbKqpiuggAFbibzMPwk1JJZwc2fV44wnBl9PZjeltYUGKO82RbnL?=
 =?us-ascii?Q?H3y/gwnkbLnHTyGg0LetvMgwExwuXz4pC0yDh4wA5Jg7LiNA/McUcy4zNMy4?=
 =?us-ascii?Q?+UxgMmNS9C3/Yzmzxg3v38/9HEEkLFoplj1iTDm0O8Zke46TwoVqq5wccPqt?=
 =?us-ascii?Q?9Aw8J5d/IkflZr+nBDANsSY9fofDfQucKXnDcEdU3Lb6jC0pSVUZWX+OshZ+?=
 =?us-ascii?Q?U3wFEZDlEPLzdknvhh9ufKVjBkAQs3Ad7Gr6CBC8FBWMQJoE5u00fGW0LjPu?=
 =?us-ascii?Q?t860vCLiO1iGp3ESt7Cu204d9Shy5NXU7oWHBEWdWDIwiwVoqW6Tkj/PQ+4s?=
 =?us-ascii?Q?QyiMv67QGmoyj92HKXyF82G7SsAImOW0UZ1zLLFplZ+O4VT6h6ufISKPF882?=
 =?us-ascii?Q?8bFVf6bxz8Qa7zYVB/UhZrifFFRuNA8YifxDPS64KEVBK5+cWnVgB0Sz7R6H?=
 =?us-ascii?Q?G5T55840IABWn0FfOTjggiQ3f2QXpIXmeFJLmvN10eBoNOEao22hel7UYsQh?=
 =?us-ascii?Q?Rjswk8drSFwFNQq3AcWCRgLcyVKlq82G70Xeh+6WAwK95DEp3sK0l3+weivV?=
 =?us-ascii?Q?1GQn4BbCHxhw+1J/oviwaRudbGMGzAvY2djCSCIr9uAIskPSQ2kxktsis+GQ?=
 =?us-ascii?Q?ts4rh4C3pGjQo89tCF/CmGyPCE0sakBXxn3nwC1N8JpSen/WPVa2934xPkvu?=
 =?us-ascii?Q?dnpf0vLYKTpaoLXYeu0PNH0j7LQt3IXsVr7UZQvE3LHIRc6CkWbXTJBn0HLI?=
 =?us-ascii?Q?QLNFKSIRl3/7T7rMRB8XyO1ort5dRZfszhtZl+M5dmBny3TBLwGFwWCGu1IR?=
 =?us-ascii?Q?J/9JxyC6Kt6OQ1wDhwaaStvhx8lQ5XbHG5RNhukSzXZLf8c90GEdh9JQ/5Co?=
 =?us-ascii?Q?hgX4+hmfwc02L4FpPw+7LdXRCBNmMU/4FR3aGjTVaWrzViZerwS09iuAhh8J?=
 =?us-ascii?Q?1NDWbIYAio8uhq2uodYZNaiGgTIkXyi4xdcRh4xSlcueueA8qqp/dFqEWVc/?=
 =?us-ascii?Q?Rve79fyislvZbeUuC6mCgw/NMd5Tt3zEmxQakk6qx7s7d5/d1COUnSmKrNKw?=
 =?us-ascii?Q?n2ZgSaMZhgv6ZfoX0OJRJu93Mr1AblzkDankBfjNKLzAAWqrtujIafVcWepR?=
 =?us-ascii?Q?hvT8IzawZqo8ByHUcMzp5Wy1RvXOeUIZYDzKdqAxN5EDEw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+2Qn5/9/FRLBZspW/bnITGUR0SBoxfZSCg/B7o1TFsQDgjsEuLlW8Wjm9MgF?=
 =?us-ascii?Q?HEI3089QjcAmgmyXRSjihOaekAOSN6jjgcfwdbbX2y1dlUqf6TAATvtEHUcm?=
 =?us-ascii?Q?2IQcvkBx58koaej21e9UbIQgVXQvi73hWMJasKZ2aBlb19yvWRQEsdz9jvks?=
 =?us-ascii?Q?NAgYM808bn6cuhHmVWfg2ApAFd1C4m0rg38cOigY6Xp5CI+gfkv/e1pMXxrX?=
 =?us-ascii?Q?g2S7yNDVshbQ050OYe98wqvdcsDaDx/YIXd/2tMD2f4PA3W690UxU54JMsbB?=
 =?us-ascii?Q?Lov50G1qDDgJc3FsgSxXNjtRQKJuxMJIBZckyHXW/R371PR7naQTlFYRc1bV?=
 =?us-ascii?Q?OFQnGrOtLDrIzHFfG/o4PZ79aAfxi8Cz4aOEAO7QBiJ/IseFm2IvtBssuiQD?=
 =?us-ascii?Q?kvtjBEjgzEFvQ2pJp3TMBxtS23o771mq5+CjgxxyJRC+buAXcrYh9Ig2M+2M?=
 =?us-ascii?Q?465h/DKWX1Pckkac+EpxFtS3SZkhMakH2XztboRNcN7NPquJXA5Xgkof+OFp?=
 =?us-ascii?Q?UNMV4xhVNON9Os7usLNiw9RxLUR+wzt0x+MvGhzAq9ZVWgPgJ+p+3TJ920+i?=
 =?us-ascii?Q?p9Kygi2fmGljyKWv4U+duxmys11Ehx8Q3M3tl3HXOsc8efPI9rg3A6V87ti5?=
 =?us-ascii?Q?gPmZq1ZAYXudar+rpjjiuc9rFTZ0g78HYSOx2Uxhgz+CveOy3evpcRkWkAv9?=
 =?us-ascii?Q?0YkEBK403RqzmR5kmoL6KXDWA28NL+bk53fEiw9XRQWtZShNapp8vjMITltH?=
 =?us-ascii?Q?i4O28z+4+uK+B12qBI2SZvwhAlRv1fWqsRXZeYr2Tbj1yASW9A/+x7MAbEm3?=
 =?us-ascii?Q?x+ooyjZEmVyuoZUXP/DGUS9t6A9O1avjO9us2GIbCPe+pUB4NcF2/guh1OMb?=
 =?us-ascii?Q?psLR2xf/4AMVMBPQZPV/JTxc7bbS4awanstwLVua/WKqMFX2kR4pwj0C0phO?=
 =?us-ascii?Q?JNir/5E3LdGK8A0WitLATljxc4aKAwPsFO2pkvW3gzdO2i9U7MS+Nf2LbYlG?=
 =?us-ascii?Q?HU8ZcrqATrxoUfuOr06u96UhRGQjgCgZwGzoaLxNAaQ5gBDXRe3Y8GBr/I2K?=
 =?us-ascii?Q?dbKRMR8M1DO6o8mNynuttA4VpV697hl8W8OpEsiW9WRsF/cDmfeSoj88wbMC?=
 =?us-ascii?Q?tWufou5vnCguACIBZu/apDJ3i5dF7E9Bn2HzsDKW6Y71JPlBqF664aaeB+oz?=
 =?us-ascii?Q?PRCQedZ+z+e/A5WISSgZCNt83eBzvO8H1fyVfgsuZIo2ixR8u+uUIZq9NcEF?=
 =?us-ascii?Q?HGNi9MwoRHc8A3SwURKamx/tFahWJch8bBqSCxf/IZJ2ja6ajTkZRK4Jx+0s?=
 =?us-ascii?Q?IEXgcMDyO7eKupVPTgxwppCticeU2WEwPKe4ZoREGhNE2Of2JnhTKpkJn0Uf?=
 =?us-ascii?Q?RJ4i0RX+LIrkppeNvkSdVeAz6Mf4E3kiV+8zC99nVltHDJiGpffxaohcPh4x?=
 =?us-ascii?Q?uQevJroJUD3rThe5BTP8tXKreDYmNEuyFZMC896AhAWm7LTwsC5cJy9yHus9?=
 =?us-ascii?Q?K31lBW5z43YADKVL1hp4T9wpU8xnKlnyxB8rlGw+mDsm5VHXuB4qxCufnutH?=
 =?us-ascii?Q?WPPe8vQNBw9tU7gL7LYpJdjLLF5mM+EolMvGXHLR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b84ee02-1102-4804-abda-08dd157383d3
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 21:26:43.5652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mh/ThSuB5aK24018cgR4U9UY7Cy9ZMi6TI6IlvsKz3GNemrq27L8AstmtcTxNiDKnu9Uo1HQ0VW0QzVOITln6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8741

= Overview =

As discussed during the sched_ext office hours, using a global cpumask
to keep track of the idle CPUs can be inefficient and it may not scale
really well on large NUMA systems.

Therefore, split the idle cpumask into multiple per-NUMA node cpumasks
to improve scalability and performance on such large systems.

Scalability issues seem to be more noticeable on Intel Sapphire Rapids
dual-socket architectures.

= Test =

Hardware:
 - System: DGX B200
    - CPUs: 224 SMT threads (112 physical cores)
    - Processor: INTEL(R) XEON(R) PLATINUM 8570
    - 2 NUMA nodes

Scheduler:
 - scx_simple [1] (so that we can focus at the built-in idle selection
   policy and not at the scheduling policy itself)

Test:
 - Run a parallel kernel build `make -j $(nproc)` and measure the average
   elapsed time over 10 runs:

          avg time | stdev
          ---------+------
 before:   52.431s | 2.895
  after:   50.342s | 2.895

= Conclusion =

Splitting the global cpumask into multiple per-NUMA cpumasks helped to
achieve a speedup of approximately +4% with this particular architecture
and test case.

I've repeated the same test on a DGX-1 (40 physical cores, Intel Xeon
E5-2698 v4 @ 2.20GHz, 2 NUMA nodes) and I didn't observe any measurable
difference.

In general, on smaller systems, I haven't noticed any measurable
regressions or improvements with the same test (parallel kernel build)
and scheduler (scx_simple).

NOTE: splitting the global cpumask into multiple cpumasks may increase
the overhead of scx_bpf_pick_idle_cpu() or ops.select_cpu() (for
schedulers relying on the built-in CPU idle selection policy) in
presence of multiple NUMA nodes, particularly under high system load,
since we may have to access multiple cpumasks to find an idle CPU.

However, this increased overhead seems to be highly compensated by a
lower overhead when updating the idle state (__scx_update_idle()) and by
the fact that CPUs are more likely operating within their local idle
cpumask, reducing the stress on the cache coherency protocol.

= References =

[1] https://github.com/sched-ext/scx/blob/main/scheds/c/scx_simple.bpf.c

ChangeLog v3 -> v4:
 - introduce SCX_OPS_NODE_BUILTIN_IDLE to select multiple per-node
   cpumasks or single flat cpumask
 - introduce new kfuncs to access per-node idle cpumasks information
 - use for_each_numa_hop_mask() to traverse NUMA nodes in increasing
   distance
 - dropped nodemask helpers (not needed anymore)
 - rebase to sched_ext/for-6.14

ChangeLog v2 -> v3:
  - introduce for_each_online_node_wrap()
  - re-introduce cpumask_intersects() in test_and_clear_cpu_idle() (to
    reduce memory writes / cache coherence pressure)
  - get rid of the redundant scx_selcpu_topo_numa logic
  [test results are pretty much identical, so I haven't updated them from v2]

ChangeLog v1 -> v2:
  - renamed for_each_node_mask|state_from() -> for_each_node_mask|state_wrap()
  - misc cpumask optimizations (thanks to Yury)

Andrea Righi (4):
      sched_ext: Introduce per-NUMA idle cpumasks
      sched_ext: Get rid of the scx_selcpu_topo_numa logic
      sched_ext: Introduce SCX_OPS_NODE_BUILTIN_IDLE
      sched_ext: Introduce NUMA aware idle cpu kfunc helpers

 kernel/sched/ext.c                       | 427 +++++++++++++++++++++----------
 tools/sched_ext/include/scx/common.bpf.h |   3 +
 2 files changed, 301 insertions(+), 129 deletions(-)

