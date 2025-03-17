Return-Path: <linux-kernel+bounces-564782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA830A65A9F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1074B3BB6EE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D065A1598F4;
	Mon, 17 Mar 2025 17:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KbpRxStd"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E2019F424
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 17:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742232068; cv=fail; b=kNk4uczmJmJStxICMXu1atd8dc/G8FPocE2MTvmUqeY4yC7QgoCSwEXucmJ65sr9XST/uHSITV5X8qciFh11b9yz7u9qT2oG0IpZcSOR6dkmKX0LuFB1O7L2NvkNr8AvfCPcanw96KdpWFRkp9xn3qDAu7Mz3i6A62eezaGzxg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742232068; c=relaxed/simple;
	bh=zB24r5iT/lpQt7xgqTDgDaycte9FpG7X+0LTU9T4obo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SiMDIfRTeWvaCcscPr7HgW8mdDUYvlnUTqD+kGvW/TzpJnrxHnIhVzhTqOREGmWJxbY1IguzcOTKcP/JSu65KbXKPBDGqM7NpECBhPGB890emE+yk1aop8tybQXNnz4U6o3XzepRqgwGfoQ7FBI/ZK6Tie4DNSWS1aTkmb/N1/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KbpRxStd; arc=fail smtp.client-ip=40.107.93.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hoc1/cRaew/UXsxnuuO/PhvA3kOnhJPFhyb4tXRsc5Jr/sgjU/igt4/QW5inNjy4WtOxatLyzw/EbfecMIvOZs3/dKYyHBjCwuyEi8hwUISlmHfZtdGr/PITPgHlWG4NLB+HZ5qIDMqamFaBH9ri1+XvsRLahUUt3bMGMteB4LJAhqqn8AO+Ho6OnlALjMUN3GB/IfWASgp5CweCYx4X0l4yKbQ+0GBAA/TCS8mdw57A0qUBFAQ3059DWHa1bLM0Yv4CWJf5gwJ6PU0pnp9hL2/x96Hz54qaSLqGabKEkyx2N53pLwXSHDrE49YscNhArOYtT501QkeeWUSH4rpwsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Q/hxXR63pDGGCpCMZsVPXKM8yNcJftr/bfjab2FerU=;
 b=WPf+Wl6wv1ds41v/4MCLG2q+E6EBxTwMddMdmts0gp8hKV/gUmausC2aSLNXNkV49YLdd8t3k8yGcoX6EqFHoPZAWtnwPP7ZFGakwrf4akTTlKJdTFTco7n2a0Rpi0k0OO9XN5FkaUtA7xCIHL8zLiHld7SjXo+T7RF/KeuIobSyc4FF+vEmfdSrP68Wq+wDrpWaG57zi9sO9J600pfrgDV17gY8HwjTBd+cDenhb6THCDjssAcoxuKyya3FxQnP8XTaC83lm72aAmYBMCsGAS1RaEucVMQlfaZgu6O3xOKqDwR5KocogTFPvZ/ThsLUgWdsJxX4ZX9nLYNT8gEs4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Q/hxXR63pDGGCpCMZsVPXKM8yNcJftr/bfjab2FerU=;
 b=KbpRxStdKr9/26qoxfRF+Q/htzldHyvJHYm0tsYovqyDuvY6UT/gaP4CYNsDso/HyuyNlbhPyc2+9GySlz6p6m0gKosOtpO/LI6ZvcrHElUqiji8diEhjAUMV80JAxZ0V/EqdPLDgus7wVk5OwTb4FrUuhuyGm/s51X7pvV70VC8wXymPZSr8fh+vqUL9WtKxmPFEqFjvxeLDVy27uMWd8fOnyY1T9+ng9yCrDxD3UqVoIJP1MjvDmfhLUjZRFctr1ncm3r3MmCzZts/mTeFoDd1wpG6ZHo72iL6e5IYaQY++qhlhzBrcB/L7HzltVh5mIO9zF2MQZQT0z4wBW2USQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by PH7PR12MB6467.namprd12.prod.outlook.com (2603:10b6:510:1f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 17:21:03 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 17:21:03 +0000
Date: Mon, 17 Mar 2025 18:20:53 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
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
Message-ID: <Z9hZ9fgtGNd8DeEf@gpd3>
References: <20250317082803.3071809-1-joelagnelf@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317082803.3071809-1-joelagnelf@nvidia.com>
X-ClientProxiedBy: FR3P281CA0094.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::9) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|PH7PR12MB6467:EE_
X-MS-Office365-Filtering-Correlation-Id: 479d8d94-44cf-4c20-6e61-08dd657817d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?slffjZQasnd2AdMCg0DPyL/H91bdic565gP6SAHYxHZWcP6e6j66u4ooBj74?=
 =?us-ascii?Q?ThiqH+fP/wd2UhIEV4n1oyfylWX8+7ys4FTKUXRGeX1XOEO8W/KJAbZQ7C93?=
 =?us-ascii?Q?e5Fe5l0W0QXRiIqxDfxSGX5Ih6aH5VFcnLoBM9gS9CjcIau9Nji2SYjckqeA?=
 =?us-ascii?Q?OuGmjoTY1Udjw66glvtU74H2yg8Yi1l+s8zVG0xLoZP/O/MSSUvkpihyidE9?=
 =?us-ascii?Q?fxPGhX24utqUYxP7pAnHG6JQvipk+KsvVGXLxrr9k5AB0rKl1jJqpKDv92vr?=
 =?us-ascii?Q?4KvPD8+293KS0eGhf9GOLyCiuUOwhJf0tR3ILMQW01ew9AI/7q72yHACaghU?=
 =?us-ascii?Q?/OXKqEsbNSbvIs/NH9WH//n9tO3Yl6/qHOPFLIbxQeKtrqYQ9B4pxZk+6y2F?=
 =?us-ascii?Q?7yV+uel1xHWC6CD3lgbGMN7lyeR25nOKmLVwk55oWV/n1R/Dn1o9Pc5Zn168?=
 =?us-ascii?Q?jOxkfRADUf2MGyxa1Sj3lSwO3L/ya4tNtVW1QW/g8tcAIw1FDIZYNjSXzQdV?=
 =?us-ascii?Q?pVDl7LlJmD0y7HLixA1laPnMLUUBSnm1aaFY+x7uZ1ZZSg0AzWkjHuVMcbvF?=
 =?us-ascii?Q?fiNy0UnDmZTa7uf07NMczJqIyTxGymQHcpDXK9H/4QnWEUNHt4XSu/+9qCGo?=
 =?us-ascii?Q?saJ0sixM6FZBWhmIL//hevkOb/hORAki8tj5LPhVupfVc6DX4RkqHZhvdQea?=
 =?us-ascii?Q?6QRVIOKYgzIwI5sD0bG54kHLRkni/dpaBqGbuL6kLlmz1ikFxmFXLOQvtS0s?=
 =?us-ascii?Q?Kc0Zd/oPWMjYlEBaX8Hax3VewSLgKm2jT7sp4ryedEI9WhoZu2Sj8S2DnSkL?=
 =?us-ascii?Q?GTkWeEcUTTQE13iIUfzYGtb5c/chq9eVXbzohw1+hdln5DHRELs+3x6KitfT?=
 =?us-ascii?Q?oBk6b07DzRNpl2ZdzN3XDJCllCijZibEwuo9trriIETtS9NUpo3bK6ABlmvs?=
 =?us-ascii?Q?eUofkQws5n8ZB4I7qapmCHHi1ejc4K3od/zGbeum3uFjUxzIDecLtMiOe3E/?=
 =?us-ascii?Q?1Gb1Jzv7PXC5+mOqzn+6+ZA+fIHnJNsj+LL4TufYpXMJiYS3PDGWJEDMIjWu?=
 =?us-ascii?Q?UMdQVGLGTAtHImM7UVVbCWn/YO0HZWuqvZmRWlJxAO2uRuPe+2dS4k/JWOqJ?=
 =?us-ascii?Q?HzxcMPe0/PGrX89BlIGVgMkve1OasU6+py3Ttz52+SiL11zgGD+fsFc3vVyi?=
 =?us-ascii?Q?xBWEAevrWpfQk3key98vTlbB+VQ6ybMKgnAsvIpoRFn5RG5KP78pRkxEPgSS?=
 =?us-ascii?Q?uY6P/W46KU/oTAHvpGCW1+aqremqV5SDF9vFmburWLGwP6nhPSCB1vL0KM5f?=
 =?us-ascii?Q?Pe/E1mQ+0THtH+prplO+VndoOqlgD9f4t6kOVpHPo3MJ1WMgLhfKGTJfHgUO?=
 =?us-ascii?Q?sR6mY5j8UGm1TAJqhkNY8TnXrRfa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r8UWd2j65Gj1RsRnmpyHCyLeVoPAbEtj97DPWFLf6HhvJJm1TehIqIdPvUjp?=
 =?us-ascii?Q?GYWBKtsueZx1rRKfpYdZFed9RvjSs2oI40YFAUA0DJ7ihLNLO4mCfqBWglM8?=
 =?us-ascii?Q?8rCsJl6Y8dYNmy4zJ5pEay3vr2gMBxrsr0pNq+O2U5MiTtDHroPmW6dNcVtM?=
 =?us-ascii?Q?4CYBt4ho/b+V49Y4awHXE2hw7sEyvNcVV2Wwx8L/tN3VUQ9gDjeVsNSIzneC?=
 =?us-ascii?Q?rATzkoAe4Kpgxy7Ey5Aso4z5j60z7X9XUS/Anaw3QjA4AIPtd9Cw5RL9R2gr?=
 =?us-ascii?Q?J/6JvdjpwNzN3D+ToACo32I9XvND8BmjHbcVdAxgQQe4CccymRo0YEwZuZqN?=
 =?us-ascii?Q?EkKNbQHX3XEIWfZU4LqJgSVMi1FDdllGSa+ZsGG+NWJF/nW5q9APwtvpmLcd?=
 =?us-ascii?Q?qX81SNEPDql27KlhCsRJsQSQkG/Sh70Q/qB4rD8Iw6p6ig+oTM0WxQZ6dXv2?=
 =?us-ascii?Q?1hYRzHPvTgDWw1TMmUzKxmAwvl/7vyylnwg5w2FU/x7PY+ZLoHh7cw9CeD4w?=
 =?us-ascii?Q?TjDbM425FGHQj9BwXqEviTKXmD11sNtB0sBOYCFKs28SOezEmN0hMOruRp4D?=
 =?us-ascii?Q?ZkqHsCq+kfoS1iSABmH/MaAdG0vabHX2KiYg06boci0kh4Se0u2fYP9SHid+?=
 =?us-ascii?Q?nMG4//NjqPqr7qn9quGf1Fsia1WXBIJX3GaSOcTnyxC7rPEYx/+smuTBH16v?=
 =?us-ascii?Q?mPzThN/QhVGbAxpcsQ0Y4PjWOAiA6AhhfBZ3uEhdFa50J9zkf/yXczypcSIg?=
 =?us-ascii?Q?svfwN9xpJXb6hAdEQBntW6T7dfURoDm44cNkuc6Bkq9dj+99VDlu+AliCmW/?=
 =?us-ascii?Q?93y3J0KC9N2UqeTx22/heFo88LWh4VeKrlZcCgkyMBN9qKqToK1fa/OWRreE?=
 =?us-ascii?Q?T/ndsitJM6lfIS+MSWgfWfh8Xz8+zr/Qqflh52jacTmfI0pis07ty4p3KEAS?=
 =?us-ascii?Q?y/93JwB2Y7dY35fB1Zdv4ffFHwWplvUplUV6yeFsUX64tjyAscJLgz2vSwBm?=
 =?us-ascii?Q?PB7Fz33mlrx1uu7pKU8ecURn9/BFXzt/N3xwVwpRZBZNpjLMdccE87rbVmyY?=
 =?us-ascii?Q?VtDEjcvfrzQfTp+0y3xfObms9+YZKVmpT1LOsBeqct3HU+JfCUom18zwF//G?=
 =?us-ascii?Q?/ryz83pdgBwfSPcgXnBjsTHLX4dNaKPbfr3j7r4AawxMSgyCm3OZsLdGkm/p?=
 =?us-ascii?Q?FRY4BPmCxDI1+aokLQ/aMgcYEWnPzAtKzs0uhf+3LEcJHpBqLYUKNQXn87Il?=
 =?us-ascii?Q?OXdjjEPFm146Xsi1NNEwHIuAiI31BLnyPxJUgBc4Yf40vO+mFvxo6xQXyOue?=
 =?us-ascii?Q?/xxbD2RoeATcGFZ0BQxgMOHzp5y8oZSr984mu6LsXn9syPsAt3GewIEi4NqG?=
 =?us-ascii?Q?J8JU+jcQQAe6UIVK4ZZZGJfFqnTLxcuGLY8S9IJTkq75xK4H7sJFlb6p5h4v?=
 =?us-ascii?Q?hSw14v71VB4iB2FHbcV6vZGvCHZJrXPWudcVMszwSaCveANHu4GqpIbPdwZ1?=
 =?us-ascii?Q?b2HQo4Ad7PBnqtsDje30+SpICnCnBd13zPG+kQa8OV9PBeFjHDKr5hwsrgqS?=
 =?us-ascii?Q?WaUvOouMqtCfN7CGrT5ZD2BIyvTcimrulH926yQV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 479d8d94-44cf-4c20-6e61-08dd657817d9
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 17:21:03.0107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DNxtSn/HjV4Cp6pw4osDCos/t4/ZcVx/3jmYKswinLmTc+C18DKiRpOHjMUtjVTVugzhEEnPkdZG0gyomGQ+yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6467

Hi Joel,

On Mon, Mar 17, 2025 at 04:28:02AM -0400, Joel Fernandes wrote:
> Consider that the previous CPU is cache affined to the waker's CPU and
> is idle. Currently, scx's default select function only selects the
> previous CPU in this case if WF_SYNC request is also made to wakeup on the
> waker's CPU.
> 
> This means, without WF_SYNC, the previous CPU being cache affined to the
> waker and is idle is not considered. This seems extreme. WF_SYNC is not
> normally passed to the wakeup path outside of some IPC drivers but it is
> very possible that the task is cache hot on previous CPU and shares
> cache with the waker CPU. Lets avoid too many migrations and select the
> previous CPU in such cases.
> 
> This change is consistent with the fair scheduler's behavior as well. In
> select_idle_sibling(), the previous CPU is selected if it is cache
> affined with the target. This is done regardless of WF_SYNC and before
> any scanning of fully idle cores is done.
> 
> One difference still exists though between SCX and CFS in this regard, in CFS
> we first check if the target CPU is idle before checking if the previous CPU is
> idle. However that could be a matter of choice and in the future, that behavior
> could also be unified.
> 
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---
>  kernel/sched/ext.c | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 5a81d9a1e31f..3b1a489e2aaf 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -3479,7 +3479,7 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
>  {
>  	const struct cpumask *llc_cpus = NULL;
>  	const struct cpumask *numa_cpus = NULL;
> -	s32 cpu;
> +	s32 cpu = smp_processor_id();
>  
>  	*found = false;
>  
> @@ -3507,22 +3507,20 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
>  			llc_cpus = llc_span(prev_cpu);
>  	}
>  
> +	/*
> +	 * If the waker's CPU is cache affine and prev_cpu is idle, then avoid
> +	 * a migration.
> +	 */
> +	if (cpus_share_cache(cpu, prev_cpu) &&
> +		test_and_clear_cpu_idle(prev_cpu)) {
> +		cpu = prev_cpu;
> +		goto cpu_found;
> +	}
> +

One potential issue that I see is that when SMT is enabled, you may end up
using prev_cpu also when the other sibling is busy. Maybe we should check
if prev_cpu is set in the SMT idle cpumask.

Also, last time I tried a similar change I was regressing a lot of
benchmarks. Maybe we should repeat the tests and get some numbers.

>  	/*
>  	 * If WAKE_SYNC, try to migrate the wakee to the waker's CPU.
>  	 */
>  	if (wake_flags & SCX_WAKE_SYNC) {
> -		cpu = smp_processor_id();
> -
> -		/*
> -		 * If the waker's CPU is cache affine and prev_cpu is idle,
> -		 * then avoid a migration.
> -		 */
> -		if (cpus_share_cache(cpu, prev_cpu) &&
> -		    test_and_clear_cpu_idle(prev_cpu)) {
> -			cpu = prev_cpu;
> -			goto cpu_found;
> -		}
> -
>  		/*
>  		 * If the waker's local DSQ is empty, and the system is under
>  		 * utilized, try to wake up @p to the local DSQ of the waker.
> -- 
> 2.43.0
> 

Thanks,
-Andrea

