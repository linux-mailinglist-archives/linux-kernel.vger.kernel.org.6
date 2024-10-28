Return-Path: <linux-kernel+bounces-385612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 518899B3962
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 19:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1AF51F22B20
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 18:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003361DF983;
	Mon, 28 Oct 2024 18:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e3JFclJi"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4073A3A268
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 18:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730141089; cv=fail; b=Wh/apXqLs4ZRcwndtovTwWn87PFNL/MISUzICbyNfJDMH4x6B0Cl6DjkgzHKJoV77WRLVmZRG2Z+ruGRnI9ZtQEoX16xXf5mcn0sUtoM6osx/ncvNfxDPw+AYeEWXjQnLnBZYOIfJmF0B/ExXUvg2na5uRldcWtpunCdCH4wmmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730141089; c=relaxed/simple;
	bh=vxLd4Zd7sUp5zQjA1gQ02qHtFt5fd4TfuhqC1j8iKMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=na6QsjwNPogxAR8mIA9nTQAwDCWdcWgxg/kJLIaw9ME/DLJOIFxsj8DE/GaTHJtjHH8oON2nHLoCLx1I/BBNAAY4thj26ZIFAM3Dl068UvDSc0WpwI0p0jLk4NEnpHbAj9b0ix2+F1xq9HAbHV9I67MiLWUwqPS9nPxZDlWLH68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e3JFclJi; arc=fail smtp.client-ip=40.107.243.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TbpGzgiQpl3VlBgP9Uidrv0lI8pKMB8cdRFpWjnGaijkMB2MT9xeHKSj5sTMHRVdrXjpezvT2u6JO/fgUEUNShQILkj2QtZ6EJd6BGJ1ho84UGj5+pZpJKgbtAiblhc6HF74oLmGcP4zBQomg+UcYWDynOv+wdKWWchPpyL0w5ELdxNqyOqr/A3/FB7pfhwmjetsBNj/YS9GBzZfWtOzdQMbQxQ/0Km1QLYHy9UBzyBkz0dmKTpu34WD8rzmElavdjXFuVtAwTWRGQRfCkc0gKU1QQczlPZCchh5+uIZcUopZTHOcOIXTPMsdFDJka81kYTMVa3AUvZOYXL6KelFnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zA4hbC1omhhIoIpMn/OTxpb6/iRW5DCGgUI26XYCJqk=;
 b=h9FwQqyEx+eEbSgqjV9GDjhvVYMNIFpcdYYgYf1iUVx6PuiP9Tg2uF1xS7LvW30LaEZZpQGs6lhmVByzqIeF9mRzljzX21rXlj7067XU9wRa3mAqBn4w9PJCbrNaxhThf/nk/moP+NEkRKVdxNIJT+qXvnDPRKorJ+wjuVcqPKGyV/+snA+tI6B3rS4Ikhuuuz1W5oUPGMKD0DqDU/gA1ZsTdEg8B8oxPAUQ8KUJ57dMe3BaoiF1aK8UaXCEfP0ulXt5aRAWoAKkPR4kVHlx+7cB5O7QOYLdgk0yB1MSORAiuiQDM1K5ZJOqWppy7cyh74Dknyjp8lfnWWA5gciSLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zA4hbC1omhhIoIpMn/OTxpb6/iRW5DCGgUI26XYCJqk=;
 b=e3JFclJiJpNbSBzKF1wVPlWxf9r+DAtygqV7/oPzI/ePlYrVSh517bu0umePup+2fC3iBnPqWS3P/ffZBx2U/AdJToDcSwxm+tQNDOpi0qtRTqN89MVFi0dIKcg7jQPULSeekBOEUCwRN+C8WP4q7H5u8ivl6tXnQRd/KfLdujmsF0SQ0erf+D0PParrlZ6pMVJdw1RdUgid+bFweQueDyR6JQBHDRGwXcNjic1TOYzuLNHbcby9V2t4xtpRQ0xNZJQ1Hk5GKe335DWnABSbwVsv4BsNfv+Gya/p0Tx+s6LysGSbiapNw1H/HXQqiMlKLSjfxo2F6ERjKUGzB+8Mcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by IA0PR12MB8647.namprd12.prod.outlook.com (2603:10b6:208:480::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Mon, 28 Oct
 2024 18:44:43 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 18:44:43 +0000
Date: Mon, 28 Oct 2024 19:44:32 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] sched_ext: Introduce NUMA awareness to the default
 idle selection policy
Message-ID: <Zx_bkK8N8FmPiggg@gpd3>
References: <20241028113338.85525-1-arighi@nvidia.com>
 <Zx_T6-9Ash0YEH0Z@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zx_T6-9Ash0YEH0Z@slm.duckdns.org>
X-ClientProxiedBy: FR4P281CA0123.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::15) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|IA0PR12MB8647:EE_
X-MS-Office365-Filtering-Correlation-Id: 1852dab7-4834-4c3b-dc72-08dcf7809674
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WylOO/eNuEOSO8dIGVG2wOHPNaOa52RaxiwBN+qIOujdzdnjxPvjgzNiUwCv?=
 =?us-ascii?Q?hNMdZLMT/PWbXC21FXVOmAAeT97lekluvZN6j2MXMh5zv6Qj9MuHse3xCTte?=
 =?us-ascii?Q?GZgKbjXcBOzz2OOLezsm49HTSUcP6VoK1kRfprHZ5a9Kf0olSj5ZSIRjyksA?=
 =?us-ascii?Q?7Gf1E09P8h1JW2BcvLaRBiRErzBTZK+I8kNyfQ1AvHC+1H6o+zZy5vv0fWqr?=
 =?us-ascii?Q?ibD574s3nT2mF+mxW5N0pFwXDeCRri1gx+ME0aPPkW3flESRZNn5eoT7xxHl?=
 =?us-ascii?Q?jlsHPArR8GV/QVqrPZ6z1sWZ2WTeADX8n47KDMeq/98pMbACCda0LgJ6Bocr?=
 =?us-ascii?Q?7iyBBJ7axybtxD+CwpvJZhk/h7wA/vhImUvLLMewqjK3LQ7jfplVO+ySk+KX?=
 =?us-ascii?Q?vjOtplAwWuIXhVCc01ZBFtMhcOtzO/N+d+jsbC3kr4llYeNL9thbySAiLZyd?=
 =?us-ascii?Q?3cA6iArPkYv1Bk8o+FsL7n0377CFCrdFKaJx4auc8aB5AucW/mpQnzaNYR7q?=
 =?us-ascii?Q?5k8OFlWpWCSJhKdSpBMpH9s+uJ9Sk5L7hKx2oNJEpLWuSNGqV3aQukj7zDOZ?=
 =?us-ascii?Q?AL673dppWwocFJeSNm3EZn3hUr7I7lXwZxyW5yEoeU6reRy27RSVvCS4jgUG?=
 =?us-ascii?Q?oWMQrX5C+7shF2uNhk54wc7TAiiLmY7i8XDWlJeMmvjYIkzJji7Ir4FpCQD1?=
 =?us-ascii?Q?kbKHw7OYa/fyOxjhyXbeLGKD40t1cbdF0MYz+g2HWMr5ZMpPzPsOns/0RIQQ?=
 =?us-ascii?Q?qlFS7iJlqx2NpnB8tuWx8Rqsl0DzsqR79NSZei6sDn7EG/nBN98wD+y0YWLC?=
 =?us-ascii?Q?nlVgo0ErmCZb0UDj9KmgdT9P/hUw155fmCluVMqHf1p9dN5H7/LJXKMmnM95?=
 =?us-ascii?Q?P2mT4Z+xgAtKgA2rAeWvRVnJSDaRRdPbJlJYdRy8ZCTVMLRjCHd295PIu7Ab?=
 =?us-ascii?Q?YqdcLnnGSEsIwnmB07NcIodb17yjIG0/EDixnDGsOkxPc+n8csi0PvBAn9B7?=
 =?us-ascii?Q?gijFrccS4RsbBWHHqSFCHNT934jCcsPzXaMjdYheaBfHFkhRc2CBAiWtdXaz?=
 =?us-ascii?Q?YfYiN2OEcDuRgNXT017T3K+W0M8lIaY3bMUu9y/2OZfObBAfQUSd6opdTwCV?=
 =?us-ascii?Q?KrNWRk8Lrc8zRzOnGoP7pldbP16WxQeHL9W5VvEx3rG582bLsVAiM3194ANi?=
 =?us-ascii?Q?Ga6kh8OiLnSGk/KeE8sR+njHc3+7g2ZfyFNBNltVBpO2I1wtY+6ToqhlmKpb?=
 =?us-ascii?Q?2K90hkhb5rtL4NpZElGtqcC4Z+jZkDeMVp0CRR6U+ZhGFm6hLppOKeErcc4E?=
 =?us-ascii?Q?rQhi3JheLY9ZFN6wckyoPReF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qcxYRXFTnCu7AU6H5xYYDpj+FA50/utLtttrDB4A/yiBneis2GECzfc65q52?=
 =?us-ascii?Q?lAFAN5Q5fqFlhb7FCpBtXJ3X30rukQJoV8ebG3uQzbiNOCiXwinKODgZEKZC?=
 =?us-ascii?Q?65HIR8X8tMSx85lWBFxStAZhM5m6FSchGnIuBkuT6D7nRKYvqyHD2EvP331a?=
 =?us-ascii?Q?Au0Bl9yA6ngIInYgzopZOW4AWQDQKqzOlUTsLxZXbhcmBs5pmQTTsDjlPKs3?=
 =?us-ascii?Q?YhJCoGgH7zfweJpvNdaNg3KpEF+NkPopH1IvuxfuDkDbAOvb7DP/b3cxxGDl?=
 =?us-ascii?Q?sNvaZou4nCbkXhQDOfnW3owa1AIoGz5GNRP8f33O3lMHY8YhkNWV1dX5wm4r?=
 =?us-ascii?Q?vd+KNpUH7D4XsSq/PHcDqqOjEjAU+GsIEuYvIllHIZel5WkJf/8DqMiPJ0yS?=
 =?us-ascii?Q?Xhn9RixCHFpdApi60Cn3I7pOutSeacLERA8uoilaKVwlUn7AerDswVh+ihvD?=
 =?us-ascii?Q?jbWd8atfpKGZru4o+IDdKv4s5iStLDqknLpRiO0QM++onYEBQScIuOxX0VtU?=
 =?us-ascii?Q?qPdvel1Q9FPk1pXHyxvlMpJxpJIhWXy3aC2wvHO+yIucsMdW99VYdS1+3rir?=
 =?us-ascii?Q?ec6gMijdqRcsinUbtlAT1prYb+DXxqUnre1nCxBg4pI7nxhxgm6iWbaRB/JQ?=
 =?us-ascii?Q?zF3fKrrUxzwyoQJNADhxopBAs9iFfPg9tKM5cn0YEB/aylgdpUWYjA75yhLw?=
 =?us-ascii?Q?PPQwMp1d/9JdYE9VVJTbDl7Z2T1EJVS44Q5BPzuNFC4q/akM9i0YVxeQ2f7Q?=
 =?us-ascii?Q?ihWIjHl32Ab/9to2vwMCxy5KbHkB9voliuFX4FPhuk9y+D9YXc9DlANZTuHu?=
 =?us-ascii?Q?/ZbVoeAfs6iYhbS0DYX+wc+qZB5kKMq1sB7F5yOt5gtKQNDt0KPNENMYd/y3?=
 =?us-ascii?Q?y1tcmP3GJRDNmwJRVLRPpkwgtG3fHdqic4jbLDW9fOzjpU96/n7LAB9yuAmM?=
 =?us-ascii?Q?nIF7CJIUuQRYKF/4yAv92sa0xzRMWRukrTSPLlzPnqVOojLQIUi2ilgbN05I?=
 =?us-ascii?Q?WZ4+eKxf3UR7ZkW6vDJ2i4h4Bn1tw39VizaBMmbiC5wh9Kpwqob+O6f0PNMb?=
 =?us-ascii?Q?edeDNj57C9vRxmECtS7/5Hi22CkpgvBoe3SXx/ralAnKcBSSxWRmA3MYFY8e?=
 =?us-ascii?Q?AHtebOYH0Yiu20xCJ+IzoViPJ1uBdd5XsT8LwiIBJO66K4ThWD0T67PhkHRv?=
 =?us-ascii?Q?IMzbj+qNuQFP1m0VBVMVGemhnyqpeoYELPxndi/5oNp/UAP5ccc8BTXGMu+4?=
 =?us-ascii?Q?ylvNyELxMR5wy+DGJktTPo0KVotqkQGTK+82OxQYFK8RCD6KUiPmJR3AYM4t?=
 =?us-ascii?Q?biFjV23XXXaL5ahl5fhqDPI3FtMy3HeolmUnxaVbYVpv2VvPETouDfDAUz8e?=
 =?us-ascii?Q?+igGr32BD9KJ6I+LKIWva4589Ki3PG9aiX4keoQpOkEfLWzNPcjCcEPZL5cr?=
 =?us-ascii?Q?VVSK+NFAyuMv2MvbtPQ1mLI7QI88igKa3ZNDle3iRMW3oNo+4xUlv7aQMMfw?=
 =?us-ascii?Q?mLrqIEwpSicA3cWAPP6yvsCsXwLxcTaTu6FwW/zlPRWbj8nEPARxrgodVai0?=
 =?us-ascii?Q?/5rgJKDftvvb1oOl9h2bB5ogZ8ijKSLblppIR4WS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1852dab7-4834-4c3b-dc72-08dcf7809674
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 18:44:43.4717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z7w5dWhTc9ElEa6p1r4ZkDHmsaRVIAgoMNSW67wqKBhfjNPtrUAZrmpngWoLySs91fOPOontBskAMrPK9GgwoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8647

On Mon, Oct 28, 2024 at 08:11:55AM -1000, Tejun Heo wrote:
> External email: Use caution opening links or attachments
> 
> 
> Hello,
> 
> On Mon, Oct 28, 2024 at 12:33:38PM +0100, Andrea Righi wrote:
> ...
> > +static void update_selcpu_topology(void)
> >  {
> > +     bool enable_llc = false, enable_numa = false;
> > +     struct sched_domain *sd;
> > +     const struct cpumask *cpus;
> > +     s32 cpu = cpumask_first(cpu_possible_mask);
> 
> On x86, the first CPU is guaranteed to be online but there are archs that
> allow the first CPU to go down in which case the topo information might not
> be available. Use cpumask_first(cpu_online_mask) instead?

Ok, I agree, cpu_online_mask is probably more reliable.

> 
> ...
> > @@ -3383,6 +3479,10 @@ static void handle_hotplug(struct rq *rq, bool online)
> >
> >       atomic_long_inc(&scx_hotplug_seq);
> >
> > +     if ((SCX_HAS_OP(cpu_online) || SCX_HAS_OP(cpu_offline)) &&
> > +         static_branch_likely(&scx_builtin_idle_enabled))
> > +             update_selcpu_topology();
> 
> Hmm... this feels a bit too complicated. Just gate it with scx_enabled()?

Ok, update_selcpu_topology() is not that expensive, so we can probably
just check scx_enabled() here.

> 
> >       if (online && SCX_HAS_OP(cpu_online))
> >               SCX_CALL_OP(SCX_KF_UNLOCKED, cpu_online, cpu);
> >       else if (!online && SCX_HAS_OP(cpu_offline))
> > @@ -5202,6 +5302,10 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
> >                       static_branch_enable_cpuslocked(&scx_has_op[i]);
> >
> >       check_hotplug_seq(ops);
> > +#ifdef CONFIG_SMP
> > +     if (!ops->update_idle || (ops->flags & SCX_OPS_KEEP_BUILTIN_IDLE))
> > +             update_selcpu_topology();
> > +#endif
> 
> And always update here?

Ok.

Thanks,
-Andrea

