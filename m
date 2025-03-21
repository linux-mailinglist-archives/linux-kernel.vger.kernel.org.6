Return-Path: <linux-kernel+bounces-572029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F96CA6C596
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 23:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 040FD188E4AD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 22:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A2E1F12E9;
	Fri, 21 Mar 2025 22:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FWzkn6LR"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB321C462D
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 22:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742594550; cv=fail; b=CRfdQ4HWAP9wmBSlpP/J3sfy+TpF9uZQPomgUure6eIi0OU5e68EIOjFyVl5CZzngXAkN8GQA3MUmHCVq6Sx0nHXfY6s5NpOaMfktGSQSUFeXHnHjPOBf97DpPoFT9FLP9XB/SRro0Vhv8UCSCAyAcdbCI5qG5O3X73nTzdi4nY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742594550; c=relaxed/simple;
	bh=tadB9uLeM2Rrrb5kTIgxVrQLBaVUu5uvCCWtbu89Nd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mIeRwky07qv/zqaYM+WO3q1RK7pHRksHlGdH6YBQeplRHcr5WbFpWoGZ10DM8relSDJMJod09mvIqDzy5Oo9JR58wXXeA2n9Vip1eHZ4/Ap0x8pSbNTdz7KB6/SViGH/Myd5SCbcJOrOTfROzOg0XRr3X3OMDZ/zhpia1ww3Om0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FWzkn6LR; arc=fail smtp.client-ip=40.107.93.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o5tpxDY+ZMos8wwc7oq8PXRKo42hxApifOHyHdiqKiP0ha0CIqdAOPbT7Rsq5q1lxtCNvCvA9MxMapp1yxWA0feh3OELpJinLkUOz7Qm+K5pG/CFKQZyX9eSJRH80ZO/yX0b2MdGhNTmgvWZwqV2dBC5RvTlYFE3tO+wbd3LZ83hPEt61y0a7L3peU7/j524URVN4ANdfm0FKE48PrugHrXbTrjQSdwmaJS1iBQA7+afvqFy6G4wVUFroY0h2hidrKBKVgPygBgU+SvYjf8zPLaIwOheQPnfH7nDabSd3ES+u0Gat9kwyK5eG2yXfqJXUdlOJnNUjLnD7J2bRpdrlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zIVmgA4j6ISUL8hlwI9k8BrnD0EDtZB3Po7RMlF8jJw=;
 b=HlEAfMf3vIbxd3zN0Vd+dooEMD/AUBAm1PGdi48/Eo6pExopQiVwsfXDz+ez7E90saiRraipSyqegm4m97O1rLSV3/EYg1OSOtSVQQ4KRHNR0gWu9DCBxoKXiwiN21Mga9nBB9GZ7DlUxKZkp8ARlOo4lxc+/yYz5Y3iyZ5L2AeonLG3xN4AwqpIctdKQD2JmcXOnqaHLPD4nA4C7ViLcc4prflCF/anonJR9SwCvTphh/0MTZskYnkxqmMUqjKGlPWxwWkXaXk56GKgXzgxBkRjd8jR2Ok/QuIzNfMCzFkjJB4BCjxAcpgnVh5aCFFJujiisqYlmwpnF9MEuYCW1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zIVmgA4j6ISUL8hlwI9k8BrnD0EDtZB3Po7RMlF8jJw=;
 b=FWzkn6LR6g5IGnSQfPvTSEc49a61/FGGgvRCwzi/vbWbkmCLcTvSOnFtNtoHYFB07Ci26Ml8KXBd//g/6eIKPBQ4jKrNbviPvrbzPIQvghhMdzjzdYOWOFSLMz2tGK4ePFqo03vAro1G5B/wdDKcS9jDI/iGbM6AjrsByPuWRp0LfxfylyX3krYtW4BIKCleAIen3NFDat1WJrO/6C12jAO3fORUUqQEf4ij9Vtly+/qdn8bQT3VI6xxAbBEP0Z9noxI87OSLNOuT4M2Fh7tmmdYc2mRrXbkEQ7wUFeOiygouMe4i9xu1O7arLQH6JuJjH+KAeoHtPITxCswnS0Gxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by MW4PR12MB6705.namprd12.prod.outlook.com (2603:10b6:303:1e3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 22:02:24 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 22:02:24 +0000
Date: Fri, 21 Mar 2025 23:02:12 +0100
From: Andrea Righi <arighi@nvidia.com>
To: changwoo <changwoo@igalia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] sched_ext: idle: Explicitly pass allowed cpumask to
 scx_select_cpu_dfl()
Message-ID: <Z93h5B4xdzRHpjGQ@gpd3>
References: <20250320073927.216147-1-arighi@nvidia.com>
 <20250320073927.216147-3-arighi@nvidia.com>
 <5c932b64-82f6-4374-b48f-e3983013b759@igalia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c932b64-82f6-4374-b48f-e3983013b759@igalia.com>
X-ClientProxiedBy: ZR0P278CA0088.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::21) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|MW4PR12MB6705:EE_
X-MS-Office365-Filtering-Correlation-Id: 56876a3a-cc89-4967-ff90-08dd68c40f9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y1/O8aatxmljIHxHZ6tyup4MLk0L+L+sy0PYX01TCstyl7tIBtfqQWtUV11l?=
 =?us-ascii?Q?3gG9AXkIlya0Ik7bcDrVpI+TmtQmAlx8qQQS7kRS3LW5QSKq0ytGyTF4vhhC?=
 =?us-ascii?Q?AbBzDIN+Fc+QiJywSfsmDixm0xBZIThT+5XtYCp5lJcYT8rUARePfR2WJDrR?=
 =?us-ascii?Q?ZW7zn8cpJou4eGR9Y8uaI9W9WTXCLqNMbl3wWgp7XZtEktdS03YFvnmZEZ3D?=
 =?us-ascii?Q?FgO1se3y0Yo0Hg06AR1jBV/awtd3SxaLr+hGjZ9VgzBjFCK76zipMEjAc+z3?=
 =?us-ascii?Q?caSh+/vMMMTT1R+MRYNjL4dSMX6RemB2xiRIL5ZkA7V4qTlvxhPTQebBSgkc?=
 =?us-ascii?Q?FA9sWKtJj2HnSewTDGckSTcD6uZ+N6Qt037i1Gvj1ovNR4EsZjSoEV1jDd2F?=
 =?us-ascii?Q?trmpn0sDnwoHQupOtvtz6MeLKBk/c1pr6fBP/Kp8krmC62wBCIHzczQ3C1nN?=
 =?us-ascii?Q?yxWFRADYfKNgJiO/kQD4y8PY2VAj8bzgyluPUV7t8uOU3ihyUwKYEnaF1ATP?=
 =?us-ascii?Q?nSnCEPd5s5DuzVL5LFuEJkaOEhsDBDkFdzwAQFdtop5dyLT7sd2L/QC3d3XT?=
 =?us-ascii?Q?brOmZ3Hdgl2VCScaZPtgF0e8/8WYkMxC5u7zG4aWOWyNwv6gnpLH25Mn3Qgp?=
 =?us-ascii?Q?p8yp3rnHBE4e8i+GWr+z44n3W0jpU3YEpNOEd6maCpR3+HYdWg7587skGIUl?=
 =?us-ascii?Q?yWt2XkXnh4iqUu4BoBtpenp1snPBYEv4TSeg9I8RHsiasqHTRfKhI514lpRA?=
 =?us-ascii?Q?nQHxJi4XYJIJ4YVo3iQFFATbTDT7RXc0DHstC9D4viZk0xPcpGdlwUlSP87n?=
 =?us-ascii?Q?Y0Vyiefz6VPgEkZamqQ88/DrNRBGktaT74vFMwvk/9HJkc3Bb37JUQZEX7zf?=
 =?us-ascii?Q?Snf9pLLL4sCDtt9anPddPNFXzzRbENoWy5rcDWnixq/cVlpeq1GqasPdcsLh?=
 =?us-ascii?Q?HteZbmgsPWkoh2/Emz8B97NQlkohyNOTzJZKpl797y8uVNr/va0S+/2ZvPqh?=
 =?us-ascii?Q?CUBC84hqBko5bGQUbGWQOkOCDspB/8JhNQxmOPjaGe/gmbWWVnV8Br4zNkVQ?=
 =?us-ascii?Q?0K55kIuJAl8FLlQ/KjE5r7kj2JkXfswEqLgy9u83/0zliQUKUjOm1SmpagWh?=
 =?us-ascii?Q?F9TCOqse5hqD6tEnFcMviADEJeU0esZd80OjU7H6dw8f4fZRpuc60fgzTJHy?=
 =?us-ascii?Q?x1kTcVaIHBjZI3FiUB6GhlPH+VlW1R775ClrgwHW4OQup5ctNdQS+vxoa1lP?=
 =?us-ascii?Q?ym0ntZh0WKhQQbTpPfqV/v4AKmn8noVC2+biClW02rT0p2Bsya43h+N71+j/?=
 =?us-ascii?Q?Vjm15q8zmKjdaE2H0tLjRSv87ds2L6jPYUbOFkhL/WNt56jHF0MVBne+gZ6V?=
 =?us-ascii?Q?doNSM8LlOtkZQhdqlskpIxvBElEb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V28wEAnTvpu04eKV0n2w8nEgo3XHBnUTqdYj6zkRUW1dhB7bOkhW0ldpFNU4?=
 =?us-ascii?Q?cS6MtA4sDm4kNJEEeBzFzJpQE5Onr2Qkb6mvGSSJpxx/UgaBRiUAdfm6C1ls?=
 =?us-ascii?Q?92PEV40sEKIxWzESxSo4lgOh9VdpyTkQPeP6b44YqW07dL/Wszau28UJcjP0?=
 =?us-ascii?Q?dQAB6MqrpN/bu4U/qUYjfKibRlnLEiHyJT+fEmN3bEJn6cDwnOQjfBtUlXiH?=
 =?us-ascii?Q?IEoH0MBTw0yE4kQYJTcoT6SBZdRyWJxhHMBfquLSeqMBNdkht+2G2xPPPAal?=
 =?us-ascii?Q?TQlhtYKp291Kv+z0+RwoJXvuXr1S72PFLVkgQ+whn9g0ibHUsTY9hLrcntCi?=
 =?us-ascii?Q?08/JJwibJ3/FdqUG7vXbos3JnzMIrIY9m+W7rQ+bNuT001kh8RxPttcYC4MD?=
 =?us-ascii?Q?rW7uCDFpNZd3AdchKMxpPluPfvxVjvKWWXz8MqIQqhV+y6l1cjxDJWrEOkRw?=
 =?us-ascii?Q?5GEMOdQO6MqxPmstLbI3Ha5ptxsVj41nXSljmI1U6CKVPON66IHSAVRViZU7?=
 =?us-ascii?Q?7rz3h7DZhPLNr/vYfZNKum1r4pyMVDUNtMe3L9lmJZF+4w/CU/f48Mvo5Unp?=
 =?us-ascii?Q?BGGYK/qzz+Hr4aLNCNu3nPjKN7YkDV6D1bLcpfFSxbeogiXqVPyJdXbSVisk?=
 =?us-ascii?Q?ZutV8ogD9IXMh+FFDTvbcWQ8wCLp8unYvdReIx0JLsEnDhgIpFNVQQ+lrcPP?=
 =?us-ascii?Q?3RDJotqHo76x9W6mpcfWFeBARUQLp8aNc7G+iBcbAih5517vHKt0S8LRTL7M?=
 =?us-ascii?Q?unS9RaFbztNUwCrEBFPbFLiF6spLG818U2c3Jw5rSjsPPYE8xlQ50FLZAuUx?=
 =?us-ascii?Q?Errjem0b0alZPsyYMBJx/LVkIVhVe66iwltDEuHChp9831pMqwe3bhOKqMCy?=
 =?us-ascii?Q?+F50QP1iqKgjlEseq0Irb1EUyC36kCyE7WoIS+c4nBU8QxQ4NomIyOs7GItw?=
 =?us-ascii?Q?IAwLXn/62F4/AB7LYeUJX/QmlNr83z+QTZM+1E+C4juoeBQfj4hhc8+vPryR?=
 =?us-ascii?Q?H//1N50HREfnklCzLWyo4dha5jvhsF+HmpkqWpNA/gal25WPPmm0cXjs+Ye8?=
 =?us-ascii?Q?OOsdPGDHyycEzcBTtnr95eGLQ/CdenjrtjlnLGJFssLFvSrGnuir2BFnmCAl?=
 =?us-ascii?Q?AZAY8gSKEzd7/Mu1O2QbBf7TYz2AiR7dt3jJvuiHHqJ/J5y4RnX34eKxNLyt?=
 =?us-ascii?Q?zdQRl36znyq+pn9uoPRhJqFsocsZRK9zz+0JEi7WXVOuqE2bb/NUkGAhd/5S?=
 =?us-ascii?Q?rxD3ojPfagik6zVQevdvzqzU/aFV38uu2eQb6Vb/Y3539EDvZs+MCrRPCkhx?=
 =?us-ascii?Q?fHP9vbMXAem/m7kDkTbXgNZEh0pKnL4W4L5FvDfSN2lDA+bK6fsu3QMN3Zgz?=
 =?us-ascii?Q?3zH1ncE4vrbZ042PO91/RHr7LdbJMyuPBlpwgpCS80VO+uSun8icQEFZxp0b?=
 =?us-ascii?Q?Qo2SExCLSvQ9zkgfCNgW4rJ5YtS4U7G9ixK1+EXlCNP9Htl4DINh31rPR+XR?=
 =?us-ascii?Q?0pjK2tqio6VI2l4Hj6v3yFZXrCtT/W6uxjcSahNz/JyuL7iRp00U4TOpVDU6?=
 =?us-ascii?Q?kPDQJ9AG/2Copx7CteBAgcwtV78RKM6/bE7plQA1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56876a3a-cc89-4967-ff90-08dd68c40f9c
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 22:02:24.4108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tHhXMB6JETRRK8tpOU1nCuEKYSI0iQPbinFLmYVMTCGxyZEwKc/IyLjgAz5n9UpwyssfeVWJV4BpZbt/v5AdJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6705

On Fri, Mar 21, 2025 at 07:15:37PM +0900, changwoo wrote:
> Hi Andrea,
> 
> On 3/20/25 16:36, Andrea Righi wrote:
> > Modify scx_select_cpu_dfl() to take the allowed cpumask as an explicit
> > argument, instead of implicitly using @p->cpus_ptr.
> > 
> > This prepares for future changes where arbitrary cpumasks may be passed
> > to the built-in idle CPU selection policy.
> > 
> > This is a pure refactoring with no functional changes.
> > 
> > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> > ---
> >   kernel/sched/ext.c      |  2 +-
> >   kernel/sched/ext_idle.c | 45 ++++++++++++++++++++++++++---------------
> >   kernel/sched/ext_idle.h |  3 ++-
> >   3 files changed, 32 insertions(+), 18 deletions(-)
> > 
> > diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> > index 06561d6717c9a..f42352e8d889e 100644
> > --- a/kernel/sched/ext.c
> > +++ b/kernel/sched/ext.c
> > @@ -3395,7 +3395,7 @@ static int select_task_rq_scx(struct task_struct *p, int prev_cpu, int wake_flag
> >   	} else {
> >   		s32 cpu;
> >   
> > -		cpu = scx_select_cpu_dfl(p, prev_cpu, wake_flags, 0);
> > +		cpu = scx_select_cpu_dfl(p, prev_cpu, wake_flags, p->cpus_ptr, 0);
> >   		if (cpu >= 0) {
> >   			p->scx.slice = SCX_SLICE_DFL;
> >   			p->scx.ddsp_dsq_id = SCX_DSQ_LOCAL;
> > diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
> > index e1e020c27c07c..a90d85bce1ccb 100644
> > --- a/kernel/sched/ext_idle.c
> > +++ b/kernel/sched/ext_idle.c
> > @@ -397,11 +397,19 @@ void scx_idle_update_selcpu_topology(struct sched_ext_ops *ops)
> >   		static_branch_disable_cpuslocked(&scx_selcpu_topo_numa);
> >   }
> >   
> > +static inline bool task_allowed_all_cpus(const struct task_struct *p)
> > +{
> > +	return p->nr_cpus_allowed >= num_possible_cpus();
> > +}
> 
> This function will be renamed to task_affinity_all() in patch #3.
> Can we use the same name from the beginning?
> That will make the commits easier to read.

Right, I'll clean up also this patch in the next version, thanks!

-Andrea

