Return-Path: <linux-kernel+bounces-430806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E3C9E35CD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7459163DCE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 08:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC8B196434;
	Wed,  4 Dec 2024 08:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pt1V5H1+"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2061.outbound.protection.outlook.com [40.107.100.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6485F18C03B
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 08:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733302029; cv=fail; b=A9q0Kyy/REbJPtyIKJdBomSTQLAA8tHRRGt+qHnyivF2oYhrHkoSW0H7eUzr2ysG/IBRqKXaajxvl85An/fRfVS6eZWnvaJsZ10fQQXB3bg1h3V/H749ktOw/MxVGIbtiEgK+7ZN19QQVMJpKxxen/V1BRuOTVzbgDVvM6+Ofjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733302029; c=relaxed/simple;
	bh=yDGkziWpNOFQY5YmF0BXHH3VEpHXS/+uEVx7nhdQlyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LWNezhHC7+FZoSv79kioIGIqLlUw5oIcEnoYsQkeqHCOsqfFZJS3PA3UUVTrMpeMoHnLpVKNVdJT4ApUi0ufrpDBMN8TNLQeb2o+LJB2ij3eUn9gS6gQREf14wOL+o+6gdt4rcsrdfhfr2FNhkB3ZbGBrZvclEJMeSi+h65kv8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pt1V5H1+; arc=fail smtp.client-ip=40.107.100.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KKqHEWhg1XldssuHtVBZoaCkDg26XnOKrZCCq3sXejNcVsRDOxz5lQgk4nKVz5WtlfestYTT1MXL6oFAz6rKyYa5+8LbMZ+tJR7fkrzH90wzOyHUOz5Mx6CAq5fxCS02MbKhGBBrxNp2hYTZtBQMcpVfptAHx5h2c6H5BuImqIZ+pya5F71tVvWXNuP2qy4yPcrfTzbiyoOQCmSZtyhXhJ2ksykOWPulq+Nmn7WSsG84RrNJjrkgzm5T6coQMBjfjzxWbEmfRwllq6pvZJcdWonj0Nqv8FT2mtXuVFjolqBxGkF8wsomCfh4YDqgV1MJgW1tbfm1a+ZwLtOsrhb8iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ff8eIj6Jq3qFxilrO/ove+LUGn6eM28Q4g6tMVux0TE=;
 b=oROVrzSLF9wtz+wE6SjiYCOOX1kX5Qn/RRvqQMjCsvzPeYw8L9cunbVPPXaz71KUn16jCyweaDmCgOTiUWqLm2zs2TjUbY8C043csfbIeHi+RqPF/UaUPpuuuVbNXMFdbW5ZIRrk75FzlISVMu7kF4chTCxon3QDhIggZbC1TiX8HpAGv+76lIpefsf3s8S8ZHo6AozTfISvO9evwblbvuB2qv3pCHDblAWdINXNbrazxmwECl7mGJYEsU6q9CLpNc+fybs/rXKEx5ruxpgiiPA8X/tYAza+oxaIT1VugsU2HEVmzg/V6XjUOfCsvP4GbOTadtWd3u45EHus2zGkUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ff8eIj6Jq3qFxilrO/ove+LUGn6eM28Q4g6tMVux0TE=;
 b=pt1V5H1+8Sl4J03MSk+fKXWVpGDaHnVEIP5yEkdrZrNDm+lqWuwfGtVFxPssEFl+TLP3NKPGdUYqWXhNDOTRAdkL3ntkVgoPvRImWxMBeNkGtHG6PzRHco4PozMWIvWpUI3myf0Apy/ATgYfXmjj02UzHjh2ecJoAGp24z+MoG7PaP6NlPI0rg2FRVAi081goDDuMDBdk0/RGw42P++/T2DRhKtYDtZHHrBjD+OSbNzji28dOZJpZSCW3CnS3ubwoNIZwoNkspAWJBYcMmix+uearcUFsfxzpauk67UBcYzvhM0b/9Ta7U+kgvp9j0Z/HPljkFcKPjZyD6uvTjW4Bw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by CH3PR12MB9431.namprd12.prod.outlook.com (2603:10b6:610:1c1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Wed, 4 Dec
 2024 08:47:04 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8207.017; Wed, 4 Dec 2024
 08:47:04 +0000
Date: Wed, 4 Dec 2024 09:47:00 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] sched_ext: Introduce per-NUMA idle cpumasks
Message-ID: <Z1AXBHsCuX_6SOra@gpd3>
References: <20241203154917.123419-1-arighi@nvidia.com>
 <20241203154917.123419-3-arighi@nvidia.com>
 <Z0-cf7gUzV8jIWIX@slm.duckdns.org>
 <Z0-kovS-Ba9CaP9J@yury-ThinkPad>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0-kovS-Ba9CaP9J@yury-ThinkPad>
X-ClientProxiedBy: FR4P281CA0103.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::19) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|CH3PR12MB9431:EE_
X-MS-Office365-Filtering-Correlation-Id: f45e0215-c612-45cd-34b6-08dd14403a03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AVkNnR8L8w948Ejwp3dob6xW/DSNt1Hd3aSyIvH0/vG2khTtS6flvw8AhQA2?=
 =?us-ascii?Q?b65zsgbVTXfZMlmQ5U/aeIMROpsmZY3NfWARgq/9kfgT7ZJN/hus5qYbMHU0?=
 =?us-ascii?Q?4lFE+wxRdmkbC86+azRsE8MyDJWAzbyPHe2Ko6ZrCdJZ9h3snwFFeTKGMeVn?=
 =?us-ascii?Q?FbXf6X3LwBvH8NKqh6HBMzGv7DMg3VDKQ5Mei4yBKyT5ue+Rzi+pSMGCh5vx?=
 =?us-ascii?Q?cfsPzmaHSYkNolftqd/Hc6RA9Wrt9q25bIEKRLFVtFcB/nM7vlXToYF/31vk?=
 =?us-ascii?Q?PagaWrf1MiIlhCgnE2dcCSc4TLeeeu1Sx4BlBzG6/mn0pHDjp/LqyKxIR2h4?=
 =?us-ascii?Q?kJf8yeDFhSaLG7OYCNvMWtqWxxiFzWIzlGq8kqqPzIDh/khr4aVIJXrEcB9Y?=
 =?us-ascii?Q?XhOW+XRlmpyxu6QKgPzbwnvmRyG6DASI/mAHbyrnwWd3uOJjFpXY//KCndot?=
 =?us-ascii?Q?ChGIgqP01LNQHVnoNLQfKfgikT6tivHq1XqUk+JHJPmeez3vP4fioGIJLNQ9?=
 =?us-ascii?Q?l0wuRm2K6Y7l11FnfjQvm3LUUz2MilGI5qOtauLGYywrQi7wOo+7DAKB/wUv?=
 =?us-ascii?Q?P6a3JThxZD+2B/hYEPwtODWlsMLn4sXghfX3uq263R5yBPCqHh5lQd6pUL6n?=
 =?us-ascii?Q?ONMY2a+5SIpJbw6oKdtn3DXsAmWbvtqiiRSoYKWta7/srqbi4TZfFEW/obr2?=
 =?us-ascii?Q?C3/oZtu6PkilvrTlruqkvPY+U212ztPOtVr4lIt+f+vO6f6CBqaAEidE1Rlf?=
 =?us-ascii?Q?10VigVE0VLdteDXRrPUrkV2xGfUR240JBrAnJbhcm4yjn2wq4y9xMoyR7zyG?=
 =?us-ascii?Q?FktWetzfFKeU0Xr5hwllFJlvX3fsfXGBx+iu/2YnJRCZDw0BlvCsVUPCGkEW?=
 =?us-ascii?Q?dJQHF6M6WbyC7g2Z+xnrs1HxFmBZG/Dp95bOXRrNqdDs/K1kRgbtGNPRBCIu?=
 =?us-ascii?Q?X5kk+edcCc6ZxfPsey6mt7sYeL34iArIyFyQbsJPGOsS67v/J0cCcJtG83qN?=
 =?us-ascii?Q?bCPpYXrCpugKHCZL5uGFsc3q4yY1hnr243/fTi+08otzzHRZXIb09N33sP0I?=
 =?us-ascii?Q?dFNpSD3XUfJV+e0osFrEJUU+QzwILKpg3Dd9NCEhiaKkRGx+6yebiJF5jhPQ?=
 =?us-ascii?Q?CtOZe9sf0akecHBbtKTNJolJX1LAq/+0mx4ML2TZWPPfYN0yAXtSJE2TRzQW?=
 =?us-ascii?Q?oRtEc9yY8UGgMly8UtHH737J/GAxHUU5bObEqgpUXliI2DsRV8jht6ggyHZv?=
 =?us-ascii?Q?/MuC/Ec2/wWZKSrxA7OqcXqzl8NF8xY7mQYlmK/ZDOHFNVhOXWvup2gr2Q1g?=
 =?us-ascii?Q?bVhM95JqC5VDLAiXArWYAlzkxAKbEr0c9XdXjAS3hmZXAA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U4yaHrNHUZF1LyOW1IX4o+0a7B+rsDElaAiOfiWQ1jvBrknUHVAnuvRYs6nC?=
 =?us-ascii?Q?g+zxjykV1Xxq5De+ltCfjON3sISLHEMaqC7MRUvPJRdKuNidewekC4n8084G?=
 =?us-ascii?Q?Q2/PZfNPCduyvE3/RMC12a6Oi0sjMKkQjIZFT0Vo8cP+p5KVfYxYsdBRgnFI?=
 =?us-ascii?Q?WqgtHHSkNc6hMNtYWDZqlwcMupIx/XcwP3Vhhtwvtnf8WHC30x0mBXoQ5yrQ?=
 =?us-ascii?Q?VBuXH4rQpQuoQRre+8i1AgIh/XNT1LF3egb6oU12AB69e4lWzpCbK4XSdZ1C?=
 =?us-ascii?Q?quY1gI5ZeUvyjQ5KN8uLcdMXQ2x8iKfHyHf5ho/kRlRRQxRS6FJAeAboaT58?=
 =?us-ascii?Q?vI5t/HtlJIztYG76e6GScILN/EMllai2Ylt3Jjjx4mGq2KzcKBjlEIqKGaHg?=
 =?us-ascii?Q?WviU7427CpAgAEP5w7PQF9WQH/sTR6u3RPVitlDXAEkpb6JJrZVHT4MOp8Pz?=
 =?us-ascii?Q?kRMLVnzXn8HAos4LMc7n7IixD87TJDqxLqNXzzpsgpHqTnsKiqGSWfWukqIU?=
 =?us-ascii?Q?bshwj2Ue2TqwNXWjUT19VPGZEmg10KcVrXkeRNOMvQlZZ2lfrHQCujfwrlSz?=
 =?us-ascii?Q?1eRPa7ELCmFuKbPaRAcnd2ErHRsCaOD66xhmAPjMoJ7OmUS0SGVTuSfQlDfi?=
 =?us-ascii?Q?oliBKZTWZ54UHwWozi3SEmfObSGhmW3SMt59zRLwy1llRpCWJZKUI1BiyXR+?=
 =?us-ascii?Q?Smg5ZgFcmLzlO82qJtRipPmSvlBQ5z9/wQ4Ex5zCrEAZprWvFTFEMkNRzD74?=
 =?us-ascii?Q?q+ouXOFkaon9cusqNXUTPT+VSTtmlvuOn8Ke15TsJGpvck/iYkRxsEx588Re?=
 =?us-ascii?Q?J43Efw3HXc2Vm3wof/fteaYJuoyXIm0uaR0snucpfzvJ7iuWHChgURdaumvI?=
 =?us-ascii?Q?kMJ2PR2MzOX0yShqyJp4zNZTYm05fgAAcLQ9kLBC0lfTU5d6kQddr5VdBeBx?=
 =?us-ascii?Q?mmZcweyv5mR7pWNf6+sr2p8kcLr8hzr527ON8iwl6DMlohKiXbFKuEHd02eO?=
 =?us-ascii?Q?8kJN428dWCLIY2X5+wtksECE5J2ObfezAn2lSwu9SVwIZT/tniIsjV0qHcBZ?=
 =?us-ascii?Q?TdeNwB0Z/5So5pP8lNNazd+nHo7lrAxvMZPqIgPv9rnYamPmYaesUDqyUg9Z?=
 =?us-ascii?Q?PBqgY8/7V++DwuLu1wr33YQ+RL3mWcjWurBAhSWresvImdAVu6SFuTwO0w8+?=
 =?us-ascii?Q?KTWsZi9YzbwWui7Lgp6f2DpsJuEl45QL2UKZPJZCY+WOAfS3bAUeP7P0fiP6?=
 =?us-ascii?Q?YRD2pM6XHDJB6mSPsLk+hQJBPPnjQcn2s82xvZlEUbTqFFZD+a6yBDl35RjF?=
 =?us-ascii?Q?Qd9KIIfrAY7FoWmcl4xikD7N+wII2BPqnBsBNfl0WgFAkIaqblEkLiTTQjUQ?=
 =?us-ascii?Q?Pi8y5SbvRVA0mhhJnjScko3GoyUnxQ21Nk5TZOZd3t5/rvHz8PKTA4+i3UKx?=
 =?us-ascii?Q?G6/B/roqmSgDn+bdrFxlYHiz7SL6VgsLy+Advgeou5eMZbtDobOEt/lvltqJ?=
 =?us-ascii?Q?MxXFjxykhMkAxK7nId/Qfo5RKSRxaBCZoFnce+pFQkOJzs6/+q9kYbMj681z?=
 =?us-ascii?Q?adnNFQciFtBrNfWnW5nyeFqB4qW1wmKfuBi9CxZI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f45e0215-c612-45cd-34b6-08dd14403a03
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 08:47:04.1074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dpk2iezAdRtYBCTWNrtGmnL6vAGQSbYLZd9ZTzZhc9J+4dDDIjTz5YCnoFpUr20EZ6iiooIDDfQS8+j0VSx7kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9431

On Tue, Dec 03, 2024 at 04:38:58PM -0800, Yury Norov wrote:
> On Tue, Dec 03, 2024 at 02:04:15PM -1000, Tejun Heo wrote:
...
> > > +static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags)
> > > +{
> > > +   int start = cpu_to_node(smp_processor_id());
> > > +   int node, cpu;
> > > +
> > > +   for_each_node_state_wrap(node, N_ONLINE, start) {
> > > +           /*
> > > +            * scx_pick_idle_cpu_from_node() can be expensive and redundant
> > > +            * if none of the CPUs in the NUMA node can be used (according
> > > +            * to cpus_allowed).
> > > +            *
> > > +            * Therefore, check if the NUMA node is usable in advance to
> > > +            * save some CPU cycles.
> > > +            */
> > > +           if (!cpumask_intersects(cpumask_of_node(node), cpus_allowed))
> > > +                   continue;
> > > +           cpu = scx_pick_idle_cpu_from_node(node, cpus_allowed, flags);
> > > +           if (cpu >= 0)
> > > +                   return cpu;
> >
> > This is fine for now but it'd be ideal if the iteration is in inter-node
> > distance order so that each CPU radiates from local node to the furthest
> > ones.
> 
> cpumask_local_spread() does exactly that - traverses CPUs in NUMA-aware
> order. Or we can use for_each_numa_hop_mask() iterator, which does the
> same thing more efficiently.

Nice, for_each_numa_hop_mask() seems to be exactly what I need, there's
also a starting node, so with that we don't need to introduce
for_each_online_node_wrap() and the other new *_wrap() helpers.

Thanks,
-Andrea

