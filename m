Return-Path: <linux-kernel+bounces-437083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1309E8EE7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40AA118845D6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2096C215F69;
	Mon,  9 Dec 2024 09:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lNc4igGj"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86081374EA
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 09:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733737248; cv=fail; b=Sl9p61NGM9kg5zF+R2S+9ZH8CvbMrHYwE6P8vwAXD+1xkCun9Od1h+frTmribMPWOYGlDiZ79PWDAPWJyCcJS7n2yytQVIrO/qnDsJROPjHqfFiHpPJFj+MWK0ABV6RWIMR73xbkjQJTv4Kblt560X/FnSwU4iOZbfCCxu5JswY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733737248; c=relaxed/simple;
	bh=la0k3T0QGAg7nK8DNDpOi5fJvlgcVsPCGY3p2DsL+cA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cephQhKGRPARzHPBeGKPAcbFBFS5SNBNc3kwd3X94/TgXxLFjYwLP9r6q4e/aA7pLtFhJsrAn9roZ2OlcFV9wVYi/eDlSNJRZW6UWWRicidmlSf8lhgVXmVRq7jiIuqtilW/bv+gbD9oAEDG5fuCrJRiiNToWjl8q2yT4u6nhOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lNc4igGj; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M1zG83qJsiQKZBA/wjl7SLDD7fxvK1vBvH1dCdmxmdcZMmZjEiLcAILYZX3iiKzm0s+VtkDxlRa2/MXofWjIJadltYr+31S5oXv52yNQm4WusbiglK7Fbdr4OEJsRFJJ2Ln9Dr9r0ncGrLDGkW95OT4GODakGHmvF1Ur+rleODw0yX59JnRyIgpbwq2KGDDhx4o2/O1k7d2npbJgvL5njs5ZicKPD3lYdAu7hEiO47ocTy/0r6ntSoaGTOEKexkczFP6L9SjsaiYDPEPZsZG4+BrgGqhFtmGWMgadl+sf3aUKcxOg/P17pqlU2OqVeG1gLFbILCETe+mH1Tuy+JbiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yutPFxKks3lZ1Y85l2j66iLjARovXd93Kw0ViqAaf9A=;
 b=Q8dv+4LjNeqD146uDVfmL5Gi0LGJz2/QY70iRKfcfrAT4TCFDm7eTnWdx4hZhGstjhu/XXhs6A80c/Eh6faO+tj+7kDQwYO54Z++i6DC1Am8W2Of5JFryl/ui4VDhYMzVZW/AUu3J3tHY5oV9O0FmYfs9lA6FUi0/fittQg3TgPufjicTPwEznMsE7GNIkHE6O3HYv+na+caJBtZwtrsO3ONtSFE/82DwDnYZk3NVz6PfVtMzO9eUZV538NZmmK1PILnZAWZThOq0TTiMbk8QXYBlJiWe56sZuiGebxUtlas3Uk6IUGMH0uhbOT2teCJlFEjtEZdHR2wdy7RO/ASGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yutPFxKks3lZ1Y85l2j66iLjARovXd93Kw0ViqAaf9A=;
 b=lNc4igGj2ZhTdsLMseGb9FitmyJw4l6qfyDeJxeyXZe5kpFwIVh18gRB3o7gRHSlppW20t/hCHuoPKB784RaZzt+F0EL44nT0tySaBQZg6T+jFufVwBqElpT8ybQZRBwbZO+aNuAG3G1kfhcidMnnE03NnqdQiHCx8WgKW6B6OKfJbbiDIQxF/pXpzOVFkPD/ZxRPNwot9X37y0utZsYDh64e1FYhnoH3B7AXAH1u3sFQF9s40TVVIPux3uHvxYF19m/+C0T7RG7HbG0V4NIYTgKKdVUWabQK6aM27Ibar7aB3O/kc5nMXxPn+qIhwpkwWxKWFR2I9c7dwCgCP50wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB6424.namprd12.prod.outlook.com (2603:10b6:8:be::16) by
 DS7PR12MB6190.namprd12.prod.outlook.com (2603:10b6:8:99::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.11; Mon, 9 Dec 2024 09:40:42 +0000
Received: from DM4PR12MB6424.namprd12.prod.outlook.com
 ([fe80::8133:5fd9:ff45:d793]) by DM4PR12MB6424.namprd12.prod.outlook.com
 ([fe80::8133:5fd9:ff45:d793%7]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 09:40:41 +0000
Date: Mon, 9 Dec 2024 10:40:33 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Changwoo Min <multics69@gmail.com>
Cc: tj@kernel.org, void@manifault.com, mingo@redhat.com,
	peterz@infradead.org, changwoo@igalia.com, kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/6] sched_ext: Implement scx_rq_clock_update/stale()
Message-ID: <Z1a7EfETQi3FSLJG@gpd3>
References: <20241209061531.257531-1-changwoo@igalia.com>
 <20241209061531.257531-3-changwoo@igalia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209061531.257531-3-changwoo@igalia.com>
X-ClientProxiedBy: FR2P281CA0116.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::9) To DM4PR12MB6424.namprd12.prod.outlook.com
 (2603:10b6:8:be::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6424:EE_|DS7PR12MB6190:EE_
X-MS-Office365-Filtering-Correlation-Id: a5356a8b-c396-48c4-5b41-08dd18358b77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0WaQPAV+69uCIPfX1MUOQYwxRFT0n7mVWco8R9mvWdmyCM57TsNiZ8ZYE12n?=
 =?us-ascii?Q?SIG4+KBKREyD9rjZNrENtPNzRrdgussL8tngTbMTP3Kem5/3dvCfDnQoijH6?=
 =?us-ascii?Q?bHJICU27TD+EdPzualgpqH+CN779KHNRyzwM6HYOKGEhlBls+wphDjQgV7L4?=
 =?us-ascii?Q?boOr3mxefa1l2bsVNpcTzfc9hZMp9bFfHp76GvxLc6eth8H3TgmEgxLQKdP7?=
 =?us-ascii?Q?aZErRsXtuCkL+GXfKvxKXITOhHF8v/sw7VvK4ofE4Jij9QugYya8QUdHmF0B?=
 =?us-ascii?Q?tJnKR2P3DqThG2cWiYBvIezos5AMRtdjaM2EwWKJobmDAFW3wJY1lG/bydHb?=
 =?us-ascii?Q?TlkrY0cwnGWlWbOCk48yLuwKfhZ44nGtyissspvH35Qd9OZ8RnEuaEgR7IFf?=
 =?us-ascii?Q?qP22M9iF/Lko7KWjLHLaaRDXa4APVQTGgt7QnxKNCv+WftHaVlMBy55A/PFY?=
 =?us-ascii?Q?GCetyHpBbgjCQsig3d3LuZ03yLrmCawMS/lLK3azxICH+JHNoXurHro8/EyJ?=
 =?us-ascii?Q?cGr0Y6EaVeZcvwk0jmqW2JGdHBiK5UgIsXtvTI3ccWSzl+Oibzr0TH7lNMI5?=
 =?us-ascii?Q?jypmYoVLVrlggUWsBE4UXHsuZQbxHG3BygJqcNo4PZO0mT5EEws1QfpOz6aY?=
 =?us-ascii?Q?EH96pkQA8WOdNXzV7qn0Su+JTiCDXhT204hT4gO+lyi/Uk6tvE5Hc3RyR/Vn?=
 =?us-ascii?Q?Oj4S3DZ78mC9cDv12+77oeqf0fTAgEjE5nfY9eI7sW++mHAawKcJi+Hq4oIk?=
 =?us-ascii?Q?mxXst5C9/ZW3IIxm1zhGXyhlTW5nssDVUSsirjGKTuOigesexEjcIhrhoyo6?=
 =?us-ascii?Q?atcEIUvhZhra72fV0IDyrh8NPr52MWx4bg60F+ofPm6EnnNucCGKjLXporWD?=
 =?us-ascii?Q?Vc/j8Ct8rnunfLUPzMJVycrrzX83G/oULlItv8WfWgMus5NP7siOnzP6D47A?=
 =?us-ascii?Q?ZG3PLSBI9WhUMbfIMfZbU09OXRpopGJiRb/EMAU2gGoIvwELv7M+Kpes6V8X?=
 =?us-ascii?Q?BIDCXz+V29Qcv/q3s/hAxIPl0Sdz6USJImsVziyQwWvDZNaAIbHKILZR9CKE?=
 =?us-ascii?Q?FqfcI8/PjHAu6HATHOQ7dM3wNOyL0X9Ns6UV5IGkKrdcCi9vWqW/aHmVHjj1?=
 =?us-ascii?Q?1SzD8pl65G6jCcrh+eGQJ1T8UVx1rVYxWcoYcqZzdQf2QPII8uKqRDmmtdst?=
 =?us-ascii?Q?UJOYmlS5f6ZghTyFYdPK5JtlbwBiuEaYoPvJjJ340TjJq8DHQa22T8wjyB3O?=
 =?us-ascii?Q?E9sTM1w+7zrfutYRf24jXoJ4wbMfHsCVAuIMMuJerhPCCT02bnnofRz0f5rQ?=
 =?us-ascii?Q?D+WdvhHIndSTgjDs8s3j2yd0fbU9WD2n9QXqsjtRYoUpVg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6424.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q2T/PA4CrVxhiRDoJfpzQEDmAOfhXLLRkXAWHqaBqkDUZ1e59yAQwLpftVMf?=
 =?us-ascii?Q?sZ+0U/Xhk9fZAmcG4ROgzcnIeY6a3F9Us7HirEN5mAQqDnkbQ/P8D1WigRI+?=
 =?us-ascii?Q?gEe3ccFBYW6ZTyiJyP9ySXIHSh0e7U5OPmVoC8FfyN82qJ+JK/HCxXGqk+rs?=
 =?us-ascii?Q?FpyyLk79EWrYjv/ygjc1iB75BkuHNf7CMVa/wz5d+tlGKI2dLe+PG0koULXm?=
 =?us-ascii?Q?5PNLjdAL/0YnvAZE7G2McfYsCkgb2dT6cS65yCljij5Cw117Sej/dxnx4fdg?=
 =?us-ascii?Q?sAHUudz0SVMrsjdV/zTdfjeAtaAlYKJh2I7BTFIs6sMqXHIFCq/IU16qZQgm?=
 =?us-ascii?Q?clpVjhOdg8TJcRR6tukMl/UmR/hORS/1Pxgvq8HZmBxlp9mekQm8Qy6sXOJs?=
 =?us-ascii?Q?tXNU/xUMnMoYV0+IGGt3OHI+003sIePCndbx38NfJs4lciXmiNpjawv9df9Z?=
 =?us-ascii?Q?dSHjEN6HfFNGFA/iGcldAZN+qHWWJVEjEDe+X/0AuSCwP+obcylpE7QDrDA0?=
 =?us-ascii?Q?a0iTpmOHiDcfu+lwLqZJ+dLk9jQvvt2n5ukyB8THDQV2/YyfdDAXEtGGkruK?=
 =?us-ascii?Q?BvXFc+FDKzZc4K4aUlaWnsRISEncTLmsmMOpnj0tlgRxSLI4Irhx4aY/ezqb?=
 =?us-ascii?Q?Gamid9ZX1JGYBbq8VgwG7LwfS10SUJzrW+VFTYQ9p8S8nITvJugemBGkMSqi?=
 =?us-ascii?Q?oA7MGxqEkUZil8x2UUR9php6/fmeGxbfY/dOJZw0Iry6jdtynkIa7u91WFLA?=
 =?us-ascii?Q?qxPZn5l5GgGO2LpP/rZ0PBM5IK+5f6nyFduHbMhtUJdv9Q72PAjgif8bhw66?=
 =?us-ascii?Q?orknpf+q0ITMkHlodhrVAdgVZWE4njQEZj06XKizVsJUGovDLNZZgrVeYNO6?=
 =?us-ascii?Q?96cIvZC9h+RCHQxIRk7BScUuBMQ97lm0ELzzwLf53ZbbxAtWLOMg7GigKh4q?=
 =?us-ascii?Q?akFHEak9hYT/WD7sj5gN2HJtf1yoyOFrFX3H3mlXnxmKu5j0hy1y7OAxW2bG?=
 =?us-ascii?Q?5QYGeXf2n25G/bdVZNcE0B9tNLVLu8qjPGs9cmTu2H0eIlweUJvYjbVpi3J6?=
 =?us-ascii?Q?98uowmnqY0BEaeqbqFYGOoGL2244X4OAni+j6WY1QinNe7F2TNy7oro6M09c?=
 =?us-ascii?Q?z0D6g5Wu48S8RJARJFEnY8PJ0vgE6vxChN/zjSnxO9Ap/SEdbBO8/1TXtajE?=
 =?us-ascii?Q?5pbgRJQaPWnEkBiAujIe3ohREaATrMg3PZRmt6hRXVXFVr4kuq5dMGOvK8aP?=
 =?us-ascii?Q?wiVi9K5qSgObqPWq4LnjmcFOwAvWByF7qLZPiwceb/eSXtEIktImG06SwxHj?=
 =?us-ascii?Q?z3AzvQ93omM+0t2z17bxuDFi1skGHnRc9Xpa6IQJJIP1zMKR9MamqGbv+zMe?=
 =?us-ascii?Q?gnqTpuUNF0HhWyf29qaT9fahOY1uCZlzP+T213bKwDkhgDQPd35s0nLc2H46?=
 =?us-ascii?Q?6Eu2zfbvk0godwkFCmEQX2ra3k/VV7u1leHkHNk8iriOQduP3yKw17kUTcY5?=
 =?us-ascii?Q?7pkIqC5hzj+gyJE6/fd8HSPXuyFa6KWJ1bzdMg0oPnaa+6Q/mBl3b6zuuRQ+?=
 =?us-ascii?Q?xoV4sSVjiKzMkY+WhyKgIkCkXTc3Yz6WASR1zW7s?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5356a8b-c396-48c4-5b41-08dd18358b77
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6424.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 09:40:41.1776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vN6fHObIEPZrlGuxRR0Z31XnVbc1UGmUaY0NCdnYDksOl85ZS2573UdUlVvbxRXHmlZBTvnFMlZCu8DnwJuvcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6190

On Mon, Dec 09, 2024 at 03:15:27PM +0900, Changwoo Min wrote:
> scx_rq_clock_update() and scx_rq_clock_stale() manage the status of an
> rq clock when sched_ext is enabled. scx_rq_clock_update() keeps the rq
> clock in memory and its status valid. scx_rq_clock_stale() invalidates
> the current rq clock not to use the cached rq clock.
> 
> Signed-off-by: Changwoo Min <changwoo@igalia.com>
> ---
>  kernel/sched/sched.h | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 440ecedf871b..7e71d8685fcc 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -754,6 +754,7 @@ enum scx_rq_flags {
>  	SCX_RQ_BAL_PENDING	= 1 << 2, /* balance hasn't run yet */
>  	SCX_RQ_BAL_KEEP		= 1 << 3, /* balance decided to keep current */
>  	SCX_RQ_BYPASSING	= 1 << 4,
> +	SCX_RQ_CLK_VALID	= 1 << 5, /* RQ clock is fresh and valid */
>  
>  	SCX_RQ_IN_WAKEUP	= 1 << 16,
>  	SCX_RQ_IN_BALANCE	= 1 << 17,
> @@ -766,9 +767,11 @@ struct scx_rq {
>  	unsigned long		ops_qseq;
>  	u64			extra_enq_flags;	/* see move_task_to_local_dsq() */
>  	u32			nr_running;
> -	u32			flags;
>  	u32			cpuperf_target;		/* [0, SCHED_CAPACITY_SCALE] */
>  	bool			cpu_released;
> +	u32			flags;
> +	u64			clock;			/* current per-rq clock -- see scx_bpf_now_ns() */
> +	u64			prev_clock;		/* previous per-rq clock -- see scx_bpf_now_ns() */

Since we're reordering this struct, we may want to move cpu_released all
the way to the bottom to get rid of the 3-bytes hole (and still have
flags, clock and prev_clock in the same cacheline).

>  	cpumask_var_t		cpus_to_kick;
>  	cpumask_var_t		cpus_to_kick_if_idle;
>  	cpumask_var_t		cpus_to_preempt;
> @@ -1725,9 +1728,28 @@ DECLARE_STATIC_KEY_FALSE(__scx_switched_all);	/* all fair class tasks on SCX */
>  
>  #define scx_enabled()		static_branch_unlikely(&__scx_ops_enabled)
>  #define scx_switched_all()	static_branch_unlikely(&__scx_switched_all)
> +
> +static inline void scx_rq_clock_update(struct rq *rq, u64 clock)
> +{
> +	if (scx_enabled()) {
> +		rq->scx.prev_clock = rq->scx.clock;
> +		rq->scx.clock = clock;
> +		rq->scx.flags |= SCX_RQ_CLK_VALID;
> +	}
> +}

Nit, this is just personal preference (feel free to ignore it):

	if (!scx_enabled())
		return;
	rq->scx.prev_clock = rq->scx.clock;
	rq->scx.clock = clock;
	rq->scx.flags |= SCX_RQ_CLK_VALID;

> +
> +static inline void scx_rq_clock_stale(struct rq *rq)
> +{
> +	if (scx_enabled())
> +		rq->scx.flags &= ~SCX_RQ_CLK_VALID;
> +}

I'm wondering if we need to invalidate the clock on all rqs when we call
scx_ops_enable() to prevent getting stale information from a previous
scx scheduler.

Probably it's not an issue, since scx_ops_disable_workfn() should make
sure that all tasks are going through rq_unpin_lock() before unloading
the current scheduler, maybe it could be helpful to add comment about
this scenario in scx_bpf_now_ns() (PATCH 4/6)?

> +
>  #else /* !CONFIG_SCHED_CLASS_EXT */
>  #define scx_enabled()		false
>  #define scx_switched_all()	false
> +
> +static inline void scx_rq_clock_update(struct rq *rq, u64 clock) {}
> +static inline void scx_rq_clock_stale(struct rq *rq) {}
>  #endif /* !CONFIG_SCHED_CLASS_EXT */
>  
>  /*
> -- 
> 2.47.1
> 

Thanks,
-Andrea

