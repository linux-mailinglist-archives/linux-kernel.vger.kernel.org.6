Return-Path: <linux-kernel+bounces-442032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD059ED72B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 21:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE58428369F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 20:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793E31D8E10;
	Wed, 11 Dec 2024 20:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gMXNwD1Z"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2083.outbound.protection.outlook.com [40.107.96.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0345120B812
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 20:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733948469; cv=fail; b=bmTmUCRTrQQ2ETstpqBXgPc52g/ghGK5IW7lDpSoeftjn87h/0SX8wBvCzP8rerg3adXJmUCs/JdghR4kJhVr+mEpadsT8Yqi3+lJneYMXrAZyn6qQsJsAEZB8hC9SO3JBscwFKJ7vtDPXZCIziP91JZSaKAd9GYUKJgxix8Ueo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733948469; c=relaxed/simple;
	bh=EBE6/y0pKID+F7fJBX6LcEJZjdEfDx31NzESBsK4LuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o7DdZV+tY0w11n1yxoz9uvXOL/N39L2SChtPTNzdsfpc7kfOqz+sPhXjzpvjd0lBSjyBJMwwoZ4NvdU5ETZjigsJBwoCM4ULdovqfGQK61cKuZn5skKE2K3CmRd4akRbccCaqqFctndC8O/fj+7KdKTsQ+HM47UJ3Nh54j87PEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gMXNwD1Z; arc=fail smtp.client-ip=40.107.96.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OiJJyG1O9x+LxojeP0v5ooIwPXhyVLhYeJwCz9zsVDqxS/HB46ZdBohJumrJd0+BUgFqz1/jwny5jMldjbFbrG3l2UTV9sv1yce2u0RkEqadjVNZZCjH34il6f4fmanootNZXFLfjY/K84NeRTwUJ9k1imc6QGx8sayfZBk+lCWqaygPfqZMsAIUXBxOu6p0Fi04Q+pDgfN61c0xoc6EvgxEdnYWSP3gaLdxupYCx7yiPnR3DQ05YXtMAB/q7WQbbnhuSZxpLTMIZ21zO+PCiAWtnefuE+Jk/xaxMo71K737zGWaYRdWnnlb0sZiOU4ngY/7KYdC471Y/lYS6qTGwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9bubESZ0AB0IJmWz7a3d7w/3Qaf0W4yRmFwwV3FzyUw=;
 b=lCYiVEKhVki7tpT2UXAnhvIu1BTQCy46p/RMGIMlNbMZMryN7cEHX/fs82xwbjAnNgRUC12AHzvqfOasesEKkQ8PZTcSo28FT9OZsSvQ3WilyPdxLk/cFUpp3NCLw4V91xeG5f6W2xqsR16A1UkFqzWCUfznHwc2RIrexvMlPuj44fvjITwMz2v5gGo1CdWglwbufckDD8o9wO1qE5QOlCUsQwMZG2fRj2O7aoey2haUX+jHJBhiSwxvVxNNvWjboagBH+Xr807pJFR9IpQExRZD8SpuQjRlMVHzwckNIxhBw3MAgQXu4vg8u5suXohdBFUANCvzMS4wt0I8auviUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9bubESZ0AB0IJmWz7a3d7w/3Qaf0W4yRmFwwV3FzyUw=;
 b=gMXNwD1Zm0GbIE8j0aSM0TiozuaCmJrXaM6BxBg2kbs/S3JdiRVIBhnOPEt3ekwD4b82rRxOfVPeuG4kXOE2wir1DcmcFwiX4YMvtcWkjEHSh5yGKk1BQgVayTocxm9u146Q3IZFu9gLNH4Xhc5AhJtNC1o8HxExFuCqdxXgyg0BHCpIZNf2VKCPtrDN5PrkGdC3gQPm6lOoAFekogoge1+zgW2Rlau/ukPRFI6qsdlZUG6R5zE5K3/CTkHHmTtodwqsV3iSEK4r6ezjW4mNXocSLSKRz22NxQjMyyIzZFoH+2Osz53MMsmo91p2E+tFToHlCWPb4Mj41kzZEIqVRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by DS7PR12MB5767.namprd12.prod.outlook.com (2603:10b6:8:76::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.20; Wed, 11 Dec
 2024 20:21:01 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%3]) with mapi id 15.20.8230.016; Wed, 11 Dec 2024
 20:21:00 +0000
Date: Wed, 11 Dec 2024 21:20:56 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] sched_ext: Introduce NUMA aware idle cpu kfunc
 helpers
Message-ID: <Z1n0KLQcA-F2DVa8@gpd3>
References: <20241209104632.718085-1-arighi@nvidia.com>
 <20241209104632.718085-5-arighi@nvidia.com>
 <Z1nPPhe_83lBTna4@yury-ThinkPad>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1nPPhe_83lBTna4@yury-ThinkPad>
X-ClientProxiedBy: FR0P281CA0044.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::7) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|DS7PR12MB5767:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ca5c834-c778-4694-b070-08dd1a21544f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P9vBKVnj0R+BJ3uqa64NfWr3tWkvGuz/SACgzIN0+6U7pyw1LMbwrpXrwcBp?=
 =?us-ascii?Q?FDynSy47DHES1wcaJ8Umoo1ynSmim07p/4O6p9HHOuBnaYrn06n8IEgq12Rv?=
 =?us-ascii?Q?zzZRC/cwuCvR+m4/GOQoYPk3/lVabH5lMZu+gxeFp79fbrFhHJ3DAyEpvxOR?=
 =?us-ascii?Q?WkcVf8XkooVyBPaT+vpMQtTQleKorGHZOlMrTdrbefm/uPQKIXlAt5i3iRAN?=
 =?us-ascii?Q?8VYhO/0IHSoDXx6rvhocQvW6CnNWMayuzJxnwEVPZvifvJvg5/J6gjHkAwYa?=
 =?us-ascii?Q?RXWcQ8n/gd0py89AvTQlKMbCarj2sZyDmsM1NrjIDEDaY9OSQ3qWhZjm/blt?=
 =?us-ascii?Q?NQokUvYdts0R8USH2QA0Sg3mHfrH0Uz5RoJ9S46m7LJqjqoPmvEROYqcB8TL?=
 =?us-ascii?Q?++oPPnYpEoQvpM6IFS/kOEsGCJZsncwpPnWPmfIlQMgij6VlCwcUzYGApQuN?=
 =?us-ascii?Q?cWV81ni2XGENRTkVKgDBzftUWErRVTzv8+JrH/4U2okPvSR6poWmYl3lX41y?=
 =?us-ascii?Q?VkVki7agWGwLjw5rXuN062V84A8SdsFlI34X/V3pVg+dM7eaH6ke7QzEZbJ+?=
 =?us-ascii?Q?mPink3r0pNs9i7zsswRYZP0M20csfHmx93Q7aGPOoJAek0H4srbxPUMYINz8?=
 =?us-ascii?Q?EioxYAJ7o/St7MqN4kcgvciFdXU8bAsD2wQnznZvLnoBM9ZHYk85/nsmFrfB?=
 =?us-ascii?Q?Ru5yl89Nq7N9oI8QLOvMpcSkY+qFbdj2Z6j42QEf6U/y29n4OBTW18te1wnd?=
 =?us-ascii?Q?C07Frv4UGpPs9guhQGNI8iW4fRHCS2wN5xJjKbbs45XkdnINpSmBuOLHIuS3?=
 =?us-ascii?Q?h5GLltvdJy5qYhQVy6sBQsHOzC8Lp5lKPSy0Pj33VCsxhk8f37+8S6ptge2l?=
 =?us-ascii?Q?hkQa7eN24gP8gWiQkTeXuixrfVumo4GJte2AVeGDPAvKOQ3db/bkrr1SkB1h?=
 =?us-ascii?Q?fchorJL1GDcM5aDFJo96yWGLDSVzwKrtFGAylIDpn3Y/Vt+xC97rCfYfxth4?=
 =?us-ascii?Q?MV6k2CKAMNr41eFg1HfTCvvQjHaNIJZh2KVet/PJ8846BBm6WbVHfFMSAAvY?=
 =?us-ascii?Q?DzP+FgKGOZkFW79B9e2kEGo7/UQsu36o08Q5wXSZ46C1iN4zJz3V1CA5f6Jb?=
 =?us-ascii?Q?jhv9r8ZcpOV1me17QJzuWXfrmTvqbxJCLpsT9RrbUvjNKWg6ABteJLwGPSuj?=
 =?us-ascii?Q?8QOF0ofl2kARuWExqM/GjwiQRpSGOlxl5ed6ElvH4GRwT7q0jtB8ztWPwoB7?=
 =?us-ascii?Q?iSaKvieOENiPWDN7bUN/NcCHP0CbiN09WA54hsUK3Aq2WcL56YecKh8s81TB?=
 =?us-ascii?Q?DRR59zP+J1GB4oyj3ZazWoHv/fP4K/T7I+t3ckc4UUBetA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xGLIM4814MYAqbxoMoU2QkujUSZ1IY5E+ofQkOGeL7opfREAJelhH2UjlKaA?=
 =?us-ascii?Q?cPLLyzVTeIrLf/MaPJ8AUXiU2l6jGeDV/FBuSyLLhXcRlST1daKz4CkZfmVH?=
 =?us-ascii?Q?MsG/gItvQjNjE4A0tB5KwmQleN7s2q9ecMBw3mai1f02QMJKhjAOf3wdsh+h?=
 =?us-ascii?Q?383wh3Lj7wdALROKQ9KYe77DOu+Eyke9/sCO6+DgXE0pcUqfifZ3kWZcWy2s?=
 =?us-ascii?Q?mOiRkNc+PQM0/mvqtTEep0TK1t55VUL/7yRGopiVdpoW8QN+7YimRbX6kGMk?=
 =?us-ascii?Q?7pIzfkcDaCEjMyaG+qObi2fOmkRhntcB5AVKuHUjDJWsPZCeSC1Qs/X9zZ45?=
 =?us-ascii?Q?6efIsYczTXzQUtzv9+T0hDrWa372Qt73QZYX60258YvzGVBuyZSYsQCZdYNH?=
 =?us-ascii?Q?RuMPA3A0d9jLYt85ip3pNIE7Wj24Ws1WbqH95fYbbWyGr+vGCRIYzOFeladd?=
 =?us-ascii?Q?mFsjk+ZU4nGL3BccR9BR3vu8X7bgH0ryLUkyH5a2OIS/iu/a9vbJI0EhtZTr?=
 =?us-ascii?Q?6p1uTwCi0AO8dMvKeSA3RYQftiMuDwyO6g4JGXr5OmOtYTOgcmRjXHYta0od?=
 =?us-ascii?Q?Y+HEzBgIXr9vI1QaJ4yX8YdhkL1ax9RoAQhPzASnZG08nahWc0Ul7l8IEKIB?=
 =?us-ascii?Q?pw0Y6uU6scYBsnZqMGqKlApNf0kUn3OD5v3cVdZwKmo/X97fQfVam3dKN6P3?=
 =?us-ascii?Q?Dxx27nL/PHLAx3rpuFkqXk0tLDa3g2VrCj6v9blRHRPJJ2QPYTJx6hOj1AWT?=
 =?us-ascii?Q?GOgDwUViCqcvtLIn2cSr+HKe63IFQX/tRxfqAeqaIUo8yBMWVhEbKzU3FqOw?=
 =?us-ascii?Q?l40QyFsu1ociXkXpclO09/SifP7uBqRB/megxUUVvOGznZRNnHqvJWmBgpyG?=
 =?us-ascii?Q?DUh5+NHws+tcR+m8D1Xh94MexfKzR6oehS0fzbKlqmP9cZyRIhptuTqDdazV?=
 =?us-ascii?Q?vSgRFTSZbtMRN1G5evDmLvx6aS8xIQ9HYIwnURjq9IhKnk2jYv6WJbBrb3j2?=
 =?us-ascii?Q?78r++CZlWcKc/fuHLqJEzueaPoRlScJFLCy5tgDDwWLcs74HocH1ZSBbtnel?=
 =?us-ascii?Q?92KIgFWQqLayYVXg7IPQut7wLvxg9nEEF03JXOqoI2ie4BqHmRRpqxMUfSzh?=
 =?us-ascii?Q?cwvlBThbelXpGShDG+1HTmiqPcMO0/y2TJdBlhrFnpfPDrgNOmTG6jRgpapt?=
 =?us-ascii?Q?t6FjoQPYFUmuhSbFtSrQ7eeG48cWEDKwKnI14Y5fPP0kRU14GIsVkKNrPtXJ?=
 =?us-ascii?Q?xmgOs52meuK9ehPMct4p2S/FsL3N2u3aqxINppTGhLMaV5IketfcbWyqJhBd?=
 =?us-ascii?Q?e5HGbQk8RFH+WsCaBPcBFO1+z4/JkAkTaosKPYbvT/ibG7Vc1iEUrkPCCuYE?=
 =?us-ascii?Q?RTPBFfYTc3vVu2wF5F3ksQAz7mlnC07pq+UlYYyu3+04VZnAdWe0B/72+VdU?=
 =?us-ascii?Q?ClecXYwkFy7BRWxxsJumSs/NETfA/oa9/XHD9at+n3wgUx9Yi4fwIimolfHM?=
 =?us-ascii?Q?tx1PfEbfx7uMmBlx1ijvXZJHCdmruekUVEiN0SoYB900wYSYjSmboBZAHBXz?=
 =?us-ascii?Q?h+UKqd8Z0FBNcPIeo0NsXQbUYel13Wq4iVCWd/Ki?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ca5c834-c778-4694-b070-08dd1a21544f
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 20:21:00.8820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zq5N0ILkaNgs3yAI5MGarnm/JPkdDuDYjP3ie3LwNVntHGdHJx/Y2Tq5maRMn39fOzs6ckFWVFEE6dEe5IWpNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5767

On Wed, Dec 11, 2024 at 09:43:26AM -0800, Yury Norov wrote:
> On Mon, Dec 09, 2024 at 11:40:58AM +0100, Andrea Righi wrote:
> > Add the following kfunc's to provide scx schedulers direct access to
> > per-node idle cpumasks information:
> > 
> >  const struct cpumask *scx_bpf_get_idle_cpumask_node(int node)
> >  const struct cpumask *scx_bpf_get_idle_smtmask_node(int node)
> >  s32 scx_bpf_pick_idle_cpu_node(int node,
> >                                 const cpumask_t *cpus_allowed, u64 flags)
> >  int scx_bpf_cpu_to_node(s32 cpu)
> > 
> > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> > ---
> >  kernel/sched/ext.c                       | 96 +++++++++++++++++++++++-
> >  tools/sched_ext/include/scx/common.bpf.h |  4 +
> >  tools/sched_ext/include/scx/compat.bpf.h | 19 +++++
> >  3 files changed, 117 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> > index d0d57323bcfc..ea7cc481782c 100644
> > --- a/kernel/sched/ext.c
> > +++ b/kernel/sched/ext.c
> > @@ -433,6 +433,7 @@ struct sched_ext_ops {
> >  	 * - scx_bpf_select_cpu_dfl()
> >  	 * - scx_bpf_test_and_clear_cpu_idle()
> >  	 * - scx_bpf_pick_idle_cpu()
> > +	 * - scx_bpf_pick_idle_cpu_node()
> >  	 *
> >  	 * The user also must implement ops.select_cpu() as the default
> >  	 * implementation relies on scx_bpf_select_cpu_dfl().
> > @@ -955,6 +956,8 @@ static struct cpumask *get_idle_cpumask_node(int node)
> >  	if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node))
> >  		return idle_masks[0]->cpu;
> >  
> > +	if (node < 0 || node >= num_possible_nodes())
> > +		return NULL;
> 
> 1. This sanity should go before the check above.
> 2. In-kernel users don't need to do sanity checks. BPF users should,
>    but for them you need to move it in BPF wrapper.
> 3. -1 is a valid parameter, means NUMA_NO_NODE. 

Ok, but what would you return with NUMA_NO_NODE, in theory we should return
a global system-wide cpumask, that doesn't exist with the per-node
cpumasks. Maybe just return cpu_none_mask? That's what I've done in the
next version, that seems safer than returning NULL.

> 
> >  	return idle_masks[node]->cpu;
> >  }
> >  
> > @@ -963,6 +966,8 @@ static struct cpumask *get_idle_smtmask_node(int node)
> >  	if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node))
> >  		return idle_masks[0]->smt;
> >  
> > +	if (node < 0 || node >= num_possible_nodes())
> > +		return NULL;
> >  	return idle_masks[node]->smt;
> >  }
> >  
> > @@ -7469,6 +7474,16 @@ __bpf_kfunc u32 scx_bpf_nr_cpu_ids(void)
> >  	return nr_cpu_ids;
> >  }
> >  
> > +/**
> > + * scx_bpf_cpu_to_node - Return the NUMA node the given @cpu belongs to
> > + */
> > +__bpf_kfunc int scx_bpf_cpu_to_node(s32 cpu)
> > +{
> > +	if (cpu < 0 || cpu >= nr_cpu_ids)
> > +		return -EINVAL;
> > +	return cpu_to_node(cpu);
> > +}
> 
> I believe this wrapper should be declared somewhere in
> kernel/sched/topology.c, and better be a separate patch.

Maybe kernel/bpf/helpers.c? And name it bpf_cpu_to_node()?

> 
> > +
> >  /**
> >   * scx_bpf_get_possible_cpumask - Get a referenced kptr to cpu_possible_mask
> >   */
> > @@ -7499,11 +7514,32 @@ __bpf_kfunc void scx_bpf_put_cpumask(const struct cpumask *cpumask)
> >  	 */
> >  }
> >  
> > +/**
> > + * scx_bpf_get_idle_cpumask_node - Get a referenced kptr to the idle-tracking
> > + * per-CPU cpumask of a target NUMA node.
> > + *
> > + * Returns an empty cpumask if idle tracking is not enabled, if @node is not
> > + * valid, or running on a UP kernel.
> > + */
> > +__bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask_node(int node)
> > +{
> > +	if (!static_branch_likely(&scx_builtin_idle_enabled)) {
> > +		scx_ops_error("built-in idle tracking is disabled");
> > +		return cpu_none_mask;
> > +	}
> > +	if (!static_branch_likely(&scx_builtin_idle_per_node)) {
> > +		scx_ops_error("per-node idle tracking is disabled");
> > +		return cpu_none_mask;
> > +	}
> 
> Nub question: is it possible that scx_builtin_idle_per_node is enable,
> but scx_builtin_idle_enabled not? From my naive perspective, we can't
> enable per-node idle masks without enabling general idle masks. Or I
> mislead it?

In theory a BPF scheduler could set SCX_OPS_BUILTIN_IDLE_PER_NODE (without
SCX_OPS_KEEP_BUILTIN_IDLE) in .flags while implementing ops.update_idle().

In this way we would have scx_builtin_idle_enabled==false and
scx_builtin_idle_per_node==true, which doesn't make much sense, so we
should probably handle this case in validate_ops() and trigger an error.

Good catch!

> 
> > +
> > +	return get_idle_cpumask_node(node) ? : cpu_none_mask;
> > +}
> >  /**
> >   * scx_bpf_get_idle_cpumask - Get a referenced kptr to the idle-tracking
> >   * per-CPU cpumask of the current NUMA node.
> >   *
> > - * Returns NULL if idle tracking is not enabled, or running on a UP kernel.
> > + * Returns an emtpy cpumask if idle tracking is not enabled, or running on a UP
> > + * kernel.
> >   */
> >  __bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask(void)
> >  {
> > @@ -7515,12 +7551,35 @@ __bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask(void)
> >  	return get_curr_idle_cpumask();
> >  }
> >  
> > +/**
> > + * scx_bpf_get_idle_smtmask_node - Get a referenced kptr to the idle-tracking,
> > + * per-physical-core cpumask of a target NUMA node. Can be used to determine
> > + * if an entire physical core is free.
> > + *
> > + * Returns an empty cpumask if idle tracking is not enabled, if @node is not
> > + * valid, or running on a UP kernel.
> > + */
> > +__bpf_kfunc const struct cpumask *scx_bpf_get_idle_smtmask_node(int node)
> > +{
> > +	if (!static_branch_likely(&scx_builtin_idle_enabled)) {
> > +		scx_ops_error("built-in idle tracking is disabled");
> > +		return cpu_none_mask;
> > +	}
> > +	if (!static_branch_likely(&scx_builtin_idle_per_node)) {
> > +		scx_ops_error("per-node idle tracking is disabled");
> > +		return cpu_none_mask;
> > +	}
> 
> Can you add vertical spacing between blocks?

You mean a blank between the two blocks, right?

Anyway, ...

> 
> Also, because you use this construction more than once, I think it
> makes sense to make it a helper.

With a proper error check in validate_ops() we can just get rid of the
scx_builtin_idle_enabled block and simply check scx_builtin_idle_per_node.

> 
> > +
> > +	return get_idle_smtmask_node(node) ? : cpu_none_mask;
> > +}
> > +
> >  /**
> >   * scx_bpf_get_idle_smtmask - Get a referenced kptr to the idle-tracking,
> >   * per-physical-core cpumask of the current NUMA node. Can be used to determine
> >   * if an entire physical core is free.
> >   *
> > - * Returns NULL if idle tracking is not enabled, or running on a UP kernel.
> > + * Returns an empty cumask if idle tracking is not enabled, or running on a UP
> > + * kernel.
> >   */
> >  __bpf_kfunc const struct cpumask *scx_bpf_get_idle_smtmask(void)
> >  {
> > @@ -7569,6 +7628,35 @@ __bpf_kfunc bool scx_bpf_test_and_clear_cpu_idle(s32 cpu)
> >  		return false;
> >  }
> >  
> > +/**
> > + * scx_bpf_pick_idle_cpu_node - Pick and claim an idle cpu from a NUMA node
> > + * @node: target NUMA node
> > + * @cpus_allowed: Allowed cpumask
> > + * @flags: %SCX_PICK_IDLE_CPU_* flags
> > + *
> > + * Pick and claim an idle cpu in @cpus_allowed from the NUMA node @node.
> > + * Returns the picked idle cpu number on success. -%EBUSY if no matching cpu
> > + * was found.
> > + *
> > + * Unavailable if ops.update_idle() is implemented and
> > + * %SCX_OPS_KEEP_BUILTIN_IDLE is not set or if %SCX_OPS_KEEP_BUILTIN_IDLE is
> > + * not set.
> > + */
> > +__bpf_kfunc s32 scx_bpf_pick_idle_cpu_node(int node, const struct cpumask *cpus_allowed,
> > +				      u64 flags)
> > +{
> 
> Sanity checks here?

Indeed, thanks!

-Andrea

