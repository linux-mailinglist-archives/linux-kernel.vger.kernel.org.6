Return-Path: <linux-kernel+bounces-565471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 979E0A66909
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 06:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEF443AE7C0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 05:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D78F1D5AB7;
	Tue, 18 Mar 2025 05:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iqXcXOjr"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB61C1A9B4D
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 05:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742274593; cv=fail; b=JtQrtoUTFj9500DVbb01ZnlZyq48KiqOtyTEfn3wlP/IQFfmPqENwcNxnoMkI6JCLqY1iVUoV68GJGgX8SaNvCBhnrC106WAO6CWPgJ9hZrf6tSUf5Au2AoD6HdkigZTgFd2XUg7KQPvZ2ZdU0N9XyDnwT8dEhDbCi4KwCGuLI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742274593; c=relaxed/simple;
	bh=Y8sFn4HRBJlCEKUD9by4CYuVm9MXmFhQZhE032bRYJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FCrqTZc/aq6i3ekER6AJgU8ma+3o6qPKGvutptSIJqeXJNo7FD5SaBYidQrWMCvGd3ks77piRGGg1WYFusVuHZYGN9WcEiFGjTaAQsElJNhoaN7t13PYNBbs7gh8WWpobuIw/1r7rAwVD0X0sWmH7X9A02Bay2T5Qx7xItrJm+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iqXcXOjr; arc=fail smtp.client-ip=40.107.94.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G1/gvAh1c+/0YtCGoNyOvpqbZYcvUKr9bXjyGfex/FLr11YeIiKsAURiUcUdkCY9mKsmUlRt8pf9stlztD28HKQGxe8jG1C66CHzaPcYNvZRTj7+ngo9gmbF7Zv5wdaNM54Axv5LcImFkDNgwjjN3eWNWrEHDdDUsLkj3+uSx6iCt1c8pcMVUSzKHI7g3R2rpdvV7nE6qRkZzT2pMA38EXnb6rhykaBKBV1YRxiqfIm3s8nzD2uVhpX302vGUTzOq4R4779fX/3xT2l015GmI8XOx/RGXwh08zGQRF55ckXHMzW5RA0bGcYQUQv0IDLQ79rqVqoYPknfyc08SA97sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gtHIbk5vNnQ18MYT1CuKR6zd6hPWNtM/12b6Kfd5t3w=;
 b=q7XNJ5U6TnQGw1zrbASi6G4D6NTNOQbYoGz41IN+5w7Kl+09AhEVYbrpXYcOnwsAwgtgHE5pMpyEFxbJXQ9E6bqItuL+AVJG3NTRfMJVmaYSjdO4SpIB9ZA869w6KpPJ40SixHGK+ADWipDwNDxi02GB3B4rCprOOcKZIY87O+rbxkXP79AepiIni7ESwVFtaNObzZ0ixBj3VCfVIVYU+QZHwpEbOJwrh/wEBIn94ACrciWSDGuVmSZF+ETLmoNgori8AOBYu0pM6Iy2xHcwrTma9w69Nz1IuaPKTmx3xA6EyUdnr4URBdil6F9fVlcz9p2e9CN0duWdRG7V4geGxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gtHIbk5vNnQ18MYT1CuKR6zd6hPWNtM/12b6Kfd5t3w=;
 b=iqXcXOjrKJJnxnWMya91xiDqNHkLTiY67ev/ld2xrbiWrIzGHbgjLeSA9pp56C/Z5EG4stSaM5PBm93bgNJOI8iBJpiKBV90XJsfnvZGsv9lLsOJSpzI1tRdVtU0+GPhxdGIw30KmyhTtBCCPhlrh9BwGlRCeWSGE0x5VyrJfH372UIAWhj1cPl2t9cN/4FLREK1ruw0sCsS7fBrdc0kI2oyjA00JfEe9/VXOr3NyfIud2D3cg30nl7QZ4iU4EQ3wey3ptgw4iAHXYvWtNSXwDEMnI/sHI1AlPYDWm7Exf4kAwds8Mieg7TmaFKYwLF2gBj0AcEX+hJA2FeuWwXTyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by SN7PR12MB7451.namprd12.prod.outlook.com (2603:10b6:806:29b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 05:09:48 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 05:09:48 +0000
Date: Tue, 18 Mar 2025 06:09:42 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH RFC] sched_ext: Choose prev_cpu if idle and cache affine
 without WF_SYNC
Message-ID: <Z9kAFnrTvqH_AzEj@gpd3>
References: <20250317082803.3071809-1-joelagnelf@nvidia.com>
 <Z9hW_3cPN8u7VURV@slm.duckdns.org>
 <Z9hcUSp6P72wT5ig@gpd3>
 <d9bbbf0c-64ad-4304-aca9-ea48febba402@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9bbbf0c-64ad-4304-aca9-ea48febba402@nvidia.com>
X-ClientProxiedBy: WA0P291CA0015.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::20) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|SN7PR12MB7451:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d715fc2-3837-4ce3-61c2-08dd65db1ade
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e7HqTKk/mh7qrvYmb0X2FbKy3S28aePOv05v7stk4S66ka0kOo5eIrgN6seh?=
 =?us-ascii?Q?E3SbnvOsT1fmtn+BeDWgD4mhXjgTacpgALkSSqx6d+qAtc6l1wLIiYEDW7hj?=
 =?us-ascii?Q?eZ16xYPBafhHWTWmbOBbn5eKjzcmBvJtPrQSWzfkI9vu1F5xIqxYvE4D564W?=
 =?us-ascii?Q?/SYx6eDTFvwbYCft4eK7uR6q3ZDct5/bwWmEHU+MAAi7SvCZDkNQjfNDgkAB?=
 =?us-ascii?Q?UyrE4VpEodaZZhfrzmL0ce8PhHR3emyBPtiY7ISoYDGdmHMdNasyPlrTz2R6?=
 =?us-ascii?Q?7JaCCReyj05zU9vts9i2vfZ8t4mVn82zfjuqX2QYjbicIp8Ic93zGGnBSUtV?=
 =?us-ascii?Q?UzIsKeuooFCHTaomNyt99HucXWZhxZenzszRl38ni7DWWELHfT9RkKxS+FZ0?=
 =?us-ascii?Q?9GjlzcYTNlvz9O25f0PYrve06uqavLWme3mvjd0RHrttKdY8zsU4cuQsJGTy?=
 =?us-ascii?Q?sMjR2F0DyjrtZK56dIv5u1GJYMCDwTQTEImRYu7rTW1T+qtpCvVZtIYJVgji?=
 =?us-ascii?Q?EuwR2GjPfF8auBp40AHU9ixs9GaJEU7geD1XfpbcaQu6xwLugVLmfo22w07/?=
 =?us-ascii?Q?sGzmyZWHES4TIJWbFELEDqycE+HgdMVZW/nJoxcgZGvO5bobKwxnL1nVDftd?=
 =?us-ascii?Q?uH+N7DeVhiZLGLx21wJF+fJz6mE8GpOFfFFgrCSFli5l2ASxKvSd3OGalmPV?=
 =?us-ascii?Q?XIBQaSMx4lPWKmOot5p4hhzRhyKkwEZDTJSbJe0aIG08/Nuv/WiwGRaRAggi?=
 =?us-ascii?Q?Bi1zEly4lxQzVLc1QNdO0jCYRjL49sSynLSbyVx1vvrXSir16QcGjro3//m9?=
 =?us-ascii?Q?qFw9WL2mn00PTf2TmphctxDgtrznpi6nkr4moiFteOp+d89Kz5ltZkeOKegH?=
 =?us-ascii?Q?6eAQVGV23z8J/m3SGSIBfpm+ZF5RyFVqTJJQjvaqxkPf6kZxiytTS9/NMI5F?=
 =?us-ascii?Q?WT53yYWNocELDe9gGd4JPUJul4i6n1jBTPeAYpG9q/KGq8Ec89q2DgJoQQmy?=
 =?us-ascii?Q?8LRx20cp3xp22vB7Kua/Uz3uzuxOjAxMfgQQIEoQefL68uBmTdiivYgLWxCK?=
 =?us-ascii?Q?OlalIGrA97zRxPmNa+CX4ih4ynXv+Z9B/DOo0BBFdcB+vpB9Dg2toGMpu2KH?=
 =?us-ascii?Q?fj0oyV3bRgcxSMkvt5O2LAHfIFsxcTAbAZr1AdPuLxePcmyjZ/5Ever0eigk?=
 =?us-ascii?Q?KeAAr+AXacuyIduKGosxuK8uxj4Lq9IMcjOMJyPUJLxqILmZ6xSlX+xd8ct6?=
 =?us-ascii?Q?BPIkcuwxaK1mv5enNrFek6L+mrUTKDHSazWQRAAUg5Icj1DiIXTkBzNrZBir?=
 =?us-ascii?Q?y9wjPahRgueXu1PL5FUeu9fp/HZzfgoYnApgxTDoB8dCOV901E1QvSirAOvQ?=
 =?us-ascii?Q?k9ldJaXpm0B92Zf3etYOcre0kTFA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?29eiYgnqEPlZoOBzYTOTYfB94d4hg7+Y37bMMLoKwKHfH+nqNIjlhN+d/MnQ?=
 =?us-ascii?Q?jm0pGgTWdqoGBXLueQo2NmFSnZI2XG3/Dkqswm0MIvEfJ6DdsltgQeDu/4tU?=
 =?us-ascii?Q?D3c/pGk4lWtudkO4M6cb2UPk6bo2Xx4xwIVXgSVsFWUMnsPOvqOZesIMr5IX?=
 =?us-ascii?Q?t7o/9sq5nsuEb9S26+0o8LJOUCm114rKFXXCd28glLEZgpbymgTsPL4p5ahq?=
 =?us-ascii?Q?IHCpGOa2sQN838LggZth6ndGemYftjDVbW8vrI7bRtixokRx9n9nz/CqyLww?=
 =?us-ascii?Q?IwoZDt8FXQUIeZ/HRK3hR/1YyoLDUKxLugeCCx3q52oOcxTFkfmX5UFmf7mf?=
 =?us-ascii?Q?if52OizArfvDOlj7L9/5oxEy5RSJwJA5khPoTY2A3iRDpzZOoTmhy8IP01jk?=
 =?us-ascii?Q?bfyOQFQAbPm17XJp7QA0xQdFGMKb0WfmqpQ357/GzAkE77uB6+M2Y0Qk5vQC?=
 =?us-ascii?Q?fxpVl8HMBNh0MrJMUUFwDovp63YxWJzQOwcerApLKTjdHIvOHG6sgeNBSFc5?=
 =?us-ascii?Q?ukg/bqajXL5UziAoBZCcbIKNzjM1VvfXL1AexaGYMsbrUTVVHTZMgbL4mrIP?=
 =?us-ascii?Q?y1NrCJN3BJ0Gdyo19l5/IInofF/lNqZiS9v7En5Wrz1L5d2fe66qjvCoC87C?=
 =?us-ascii?Q?uD6Ky1bAGCt6XszYeamQh6uYT17iDTDzgWEgkEMK8eAHR4ApFBuFSZasa9/E?=
 =?us-ascii?Q?OMJFzdjkz/AecV3bXdCdjp1HS7RJt/bDdY7RhEoBDKtD++GdbDZDfr7wnoKn?=
 =?us-ascii?Q?1H5Bw3IMNrVsqDaKCrHmuaZTKMoW+X4wssHdjoJwK/dFKwEXoh3EC5/IDv6o?=
 =?us-ascii?Q?4qp+TE18UdiT5fQlw50Dy+IFv/TPPHqA/Rt5A6qG5DrM8AmLYWH6aajdtCRk?=
 =?us-ascii?Q?tjsfwwAmXzWU/q6EhYisAE2ilfv6v1LPuvw6vu5v1jfnSfIq9hu/2DqeDYcn?=
 =?us-ascii?Q?tFmGgayd2QXJC7QESMUK9BqKZZqEaS4tlC9CSMb0uqEUta0ShCcAT1gUZj84?=
 =?us-ascii?Q?dHzXHCI+3iiA1ddfzMBKrVanHPwH0t6LVdcmndXL4cg7/UZbqcNuq3wlUMIF?=
 =?us-ascii?Q?83Ewqi6kFAjZZ2tdviU/coKT5ezlW/fcqkGpf9SyRBIL93Y/1mc5a9hPTZS2?=
 =?us-ascii?Q?c0YsO1V37SLASj61bDpGWAAakkHknAyLQkzQwhxVhEI74qpq+qW3K2F3GjwV?=
 =?us-ascii?Q?OhG+rAGdtZUd4jsndyN+4BEm3F7Ey9vmqpL+ucCMkq6OXP2HaFi+oTba/Tvd?=
 =?us-ascii?Q?g7TOiYYGOrNWGaYyO/tKfnNMzYoJuqvvwKHe+82EsvfJ5O6fHcxVIT7UAbav?=
 =?us-ascii?Q?LA5Xgd3bbo15N3vv1JbT+Hq3WCoetbT6ZIZ01OAlG6h+F295eP+XuZY7xJOJ?=
 =?us-ascii?Q?qGsrPaWwZCFwczU/SMGSXXVCvtx+rYyXoRG8FayWD7oJDJnNDzVQPKvMH7UX?=
 =?us-ascii?Q?2AsclGlw5FlK0d/o/1LiZwBzzNYMuaen/pxPvB4fEXaj4VHLuDMa9HSICMQt?=
 =?us-ascii?Q?0gSCE5T3CtK6/JuoaieidQupgaJDD9beCEFYArXUB+4MCCAtiIacSeGSc5Xh?=
 =?us-ascii?Q?6JiCpWRb3NuacKvKj8dLWjmHmWtCgXtR3fvIAnZI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d715fc2-3837-4ce3-61c2-08dd65db1ade
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 05:09:48.2621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cII7KnD0DsEvS+Ns4DTMjwDiHwvFhmBblgUWu3LWN5CRwfoUY/gYhFW1xHRa+9SuuCshks9/QLr5YBSXmJmwUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7451

On Mon, Mar 17, 2025 at 11:11:08PM +0100, Joel Fernandes wrote:
> 
> 
> On 3/17/2025 6:30 PM, Andrea Righi wrote:
> > On Mon, Mar 17, 2025 at 07:08:15AM -1000, Tejun Heo wrote:
> >> Hello, Joel.
> >>
> >> On Mon, Mar 17, 2025 at 04:28:02AM -0400, Joel Fernandes wrote:
> >>> Consider that the previous CPU is cache affined to the waker's CPU and
> >>> is idle. Currently, scx's default select function only selects the
> >>> previous CPU in this case if WF_SYNC request is also made to wakeup on the
> >>> waker's CPU.
> >>>
> >>> This means, without WF_SYNC, the previous CPU being cache affined to the
> >>> waker and is idle is not considered. This seems extreme. WF_SYNC is not
> >>> normally passed to the wakeup path outside of some IPC drivers but it is
> >>> very possible that the task is cache hot on previous CPU and shares
> >>> cache with the waker CPU. Lets avoid too many migrations and select the
> >>> previous CPU in such cases.
> >> Hmm.. if !WF_SYNC:
> >>
> >> 1. If smt, if prev_cpu's core is idle, pick it. If not, try to pick an idle
> >>    core in widening scopes.
> >>
> >> 2. If no idle core is foudn, pick prev_cpu if idle. If not, search for an
> >>    idle CPU in widening scopes.
> >>
> >> So, it is considering prev_cpu, right? I think it's preferring idle core a
> >> bit too much - it probably doesn't make sense to cross the NUMA boundary if
> >> there is an idle CPU in this node, at least.
> >
> > Yeah, we should probably be a bit more conservative by default and avoid
> > jumping across nodes if there are still idle CPUs within the node.
> >
> 
> Agreed. So maybe we check for fully idle cores *within the node* first, before
> preferring idle SMTs *within the node* ? And then, as next step go looking at
> other nodes. Would that be a reasonable middle ground?
> 
> > With the new scx_bpf_select_cpu_and() API [1] it'll be easier to enforce
> > that while still using the built-in idle policy (since we can specify idle
> > flags), but that doesn't preclude adjusting the default policy anyway, if
> > it makes more sense.
> 
> Aren't you deprecating the usage of the default select function? If we are going
> to be adjusting its behavior like my patch is doing, then we should probably not
> also deprecate it.

I'm just extending the default select function to accept a cpumask and idle
SCX_PICK_IDLE_* flags, so that it's easier for BPF schedulers to change the
select behavior without reimplementing the whole thing.

The old scx_bpf_select_cpu_dfl() will be remapped to the new API for a
while for backward compatibility and the underlying selection logic remains
the same.

So, in this case for example, you could implement the "check full-idle then
partial-idle SMT CPUs within the node" logic as following:

/* Search for full-idle SMT first, then idle CPUs within prev_cpu's node */
cpu = scx_bpf_select_cpu_and(p, prev_cpu, wake_flags,
			     p->cpus_ptr, SCX_PICK_IDLE_IN_NODE)
if (cpu < 0) {
	/* Search for full-idle SMT first, then idle CPUs across all nodes */
	cpu = scx_bpf_select_cpu_and(p, prev_cpu, wake_flags, p->cpus_ptr, 0)
}

-Andrea

