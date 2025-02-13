Return-Path: <linux-kernel+bounces-512480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55447A339CA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 09:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDFA73A72A2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 08:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8180120AF72;
	Thu, 13 Feb 2025 08:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rzNDHWG0"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964D413B29B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 08:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739434731; cv=fail; b=Jpt2a2jaFEtEAG1cUwFmJfS1qLdI04wnBoHj9Bx3SIa6SBpSS6rI07fB+T0NUfu3M1VSKDiLALuunt+Sor7KGHLO8QBXj9STRpRRkcHa2n95/xcDUWXLBBzioQa2oPu2bOQV2554/tdvJHCq3EsSMlR6Nf3bmee2LrXFOJUfWQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739434731; c=relaxed/simple;
	bh=DX2o3xUCD6/8ikWwh22pGf7tMH4q0BdIMMPbzqRDWek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sLuZV2RXH5uh8b1mWGjjx7hKqJ/ym7dLGGBlTIxGtJLTwyYd5jQttR4FZY08mc7XRyOwWOlDcLHp3tXeUAo1m5lqxKARwZm5Wao+nQPKa3ea3GvIG6yPdozcDv6BSlV+vA5h++6NSOCCoKoYM3n0oWreJ3+XUFUINn3El/egvpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rzNDHWG0; arc=fail smtp.client-ip=40.107.93.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aMiLgSYDEn052NWA27twvp5C3P42I0xtCJ6JEG7NhP3XVcnJFF15j1cbGW3LpnI/7iW2rOzJJQ7Bjaxm0GyVKLM6TiS1TjPYzWg9T8GwB8ZznCELEygbdlxLEU4l01NyuJf5aJfdLuXG0jpV7fF+mAPFNadXYOi73zlMM+UCgv/q96GxowjOniFUQSN4HjjxzxH+cW3LoYM8YHc3DCmfsI2DSBw4W6Ejpyh/osn9XPndHhmCnQQg41Mi5PtBNr84Uh1cED/b3OAH/AdM3dV9lnXbd5/evQmNzpxFRXeysjd44e4DyYOUiY1f34Khxc9y6Dquc1rk8htEBW36WzddQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YWMuqrd3myja3FPjVGXGloFmuEA7AO9B5KTp/tAiVCA=;
 b=Aq5bo9nPt5V2FvnKk2/F2TXccNpGBOrzEXPuTHajEXFHZS6DeurPrawdXpP7n0b0QlZZ0lW4h/0j9v8XxtdiVP+qQ1n6EMAgPWtdmmrweo3+A3b4PtEbwcsseUg+jtkLBqhsgg0svILTMSx9CBxuyI5GaeBhSfWXM29p7bJGKyv4kby/cnb3xo8m8svVuimc0haEYO6Pt6a3hJv4gbL+DsA5oc+eD43Hrq3QOeJd7npP2IfUpSVZMBibZKct7VriD2DOhaQW27lFSquZohRXmUcWbjj3zdMq9bhIf33CjfDF1CZAGpXD5qMGtPv9MifjPyLc+z9mA4/KE6UyVsw6XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YWMuqrd3myja3FPjVGXGloFmuEA7AO9B5KTp/tAiVCA=;
 b=rzNDHWG0jrzPFNRQ/J3rLNUINlnqizI4UVsEbPUV2D6OVLSabYS01nDmRHgGtVhFsJfVntfUGhC+yqSl7GwxsHNSR3dEGV/b4t2rEHRInFTbnQtPy0yeesqlVc8YesU39rEoUVwEKuPzI7nXgEjYDKN4ogyw8trg299yhsNmmYjUfPv+aTCvxPSI9SboF/zSm4yGHXKijO7otjJBfPkRsCM2FwEoX8utDW7cVLTBZo/NthMtEL+PQXr0/nxTAPB/D0O0V55z0h0TZ0URFliQgIYu4JxDBYfYwt5Jf9wIpZoKNFYQcfe38VJLxC95lbLpcaSpsstGwPZvHgpi4sC5+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by SN7PR12MB8792.namprd12.prod.outlook.com (2603:10b6:806:341::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Thu, 13 Feb
 2025 08:18:46 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 08:18:45 +0000
Date: Thu, 13 Feb 2025 09:18:41 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Neel Natu <neelnatu@google.com>,
	Barret Rhoden <brho@google.com>, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, sched-ext@meta.com
Subject: Re: [PATCH sched_ext/for-6.15] sched_ext: Implement
 SCX_OPS_ALLOW_QUEUED_WAKEUP
Message-ID: <Z62q4Zuh7ry9tH3L@gpd3>
References: <Z60p755gE1aDiimC@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z60p755gE1aDiimC@slm.duckdns.org>
X-ClientProxiedBy: FR2P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::7) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|SN7PR12MB8792:EE_
X-MS-Office365-Filtering-Correlation-Id: ad66b248-3161-48bc-0d7e-08dd4c0708cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jFe6hPJoIPd58MHpTjqmvBEx3Xnyrxb8esqiLfRn8dmhbh6T75+fzLG6AY4S?=
 =?us-ascii?Q?9JT/dgMQ0F3POQeDWEx9gQofP5ZeGN91ErGONP15Mih0zAdP33bGGJEvY6cH?=
 =?us-ascii?Q?yhcsQpp/W5JjbH8rXIjgQHS5Ktk85VptLegIZCDxWy8zTjGtBXTUUJqk0TfS?=
 =?us-ascii?Q?zocWu1AaMNZHglIXvERZcm0RyFzmZNQgIQlJJpcDDh1NmIaKr9EqWVnB9Tcq?=
 =?us-ascii?Q?58r6h9Qga5TO4VQr1/6WxZiKwvZ9qzRgJB9sal2hldJ+KpZqQr3lWgLDzv5x?=
 =?us-ascii?Q?yZOXs9vJpVsv7shsgHH7hVBQ8ffH3Wtqdwhg1JhZtgR3AkNTjShmPOU7CmKU?=
 =?us-ascii?Q?Rcw+D/NuKF7NT6ECo8cetPZAXLmj0VxdrlVmd4+c7UmvnfOZdFRKSvJI9RtW?=
 =?us-ascii?Q?+M3CoU1rV5Im+T4ug71Vw/Qym/SbVp3s2TWUuDWtQq1NAZ6s0MUyicfWmBrj?=
 =?us-ascii?Q?TuRk6Va/pBbfRukUlktwIJNcDTMs57RP0QMgNspsFbc76Jdbh0pxFOQ6xpSN?=
 =?us-ascii?Q?Qda9IVyxm3HxjxUtOM1mZveJZIsVv+b5oBS4OfEIDNWs3B8Dj3zxqo153uEx?=
 =?us-ascii?Q?XQaxKS4hzRMu2wRAa842Z15e+EKDVtZkWesQmC2dxujDeCCfWYIE4jNZaUhL?=
 =?us-ascii?Q?JjkR7VxAhv4R4b+rXjWf4r8ih4r1xaZFaKHWjovYKVXbD4CsiVx+yhiL3jE9?=
 =?us-ascii?Q?Bx7ecX0ghK4lPg9RRKLfJ+YVi9w3ieHaslTCR63MsQI/m4WMliHJJMwDgMMm?=
 =?us-ascii?Q?hjw2vTJsWeo5CQPPLoJoVnuiusbdFcAMFkfExQ/1dydHZQZ/K1zO4mpznoy8?=
 =?us-ascii?Q?GUArUxigGCSz7kc61oZyNPQDr6365JxYCm4atvQECaDnI66kq5C8z+w8MPV+?=
 =?us-ascii?Q?jQviv7prGwAd+Z/T3yYYKrwOm2zM7EwuPiqafxkl+318GNkrCiOEyZH7RNr3?=
 =?us-ascii?Q?Fy9Rk0IYtCLZCLlFydDgkFOU47UT4H0imnHZUbfOtX4mzphK2aMUxk3waIzK?=
 =?us-ascii?Q?Rg68Jt9xyKz819KcYhW3Sh5qMHuLQxVgB50sfV5YFQpoawa3k53YvAbixhD0?=
 =?us-ascii?Q?HBWRdiBPlMZEd4avIBXiBm5PUKIlBEDiI/qLioetmJQCgsw6MgeUyIn9hTb9?=
 =?us-ascii?Q?RApCUyfOuCIHoe33ncsVFN7fVT83BwYZJD8h/D6qxAxy/ZHJiYPre30dqaY5?=
 =?us-ascii?Q?Uap3YVeN1ZgGrVaOqEBxRSf+kFOV8OLSU84AGweDmF/sLo7dwvQ0LYYzniHx?=
 =?us-ascii?Q?IH/Ii2dCwddIiXZrEnieHJ/B01ETM/YNABTqaLdFMIeAn1QZE5BVUP19ePxu?=
 =?us-ascii?Q?vImtnyEiBlNlngTmg1nYHKJJYe9caTVokNBgeuW4IUdV54Z8c3d6CdgNZrxm?=
 =?us-ascii?Q?7CnFo3EUQRjM3uxzMYuPWUH0FpvQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1cUYX4P3dWT5SWfYnsBJtXnMniGuWvEZMYKtPSRkdi6sZUl4MUx/451peser?=
 =?us-ascii?Q?5s0+8foQY9+ZFBG4wCD3BDeG2GuZsGpitVEIbxWZFWNZGmtj3YAxIYmNddKK?=
 =?us-ascii?Q?RHxgGsUhTEOoeRnEmGiivthmRBQ/f12vYQisvzGWUAdwnJFR9phJVL/n4Xvi?=
 =?us-ascii?Q?M3eo/83Yz+AnWlItG+DyN1cPHjn9FJghgMFjGbdPDvnHLunZ7OvMDDdTjw44?=
 =?us-ascii?Q?iW4cvx6Q7f1O9HvVDpRzP76ba3F4fVjKlV/SaFLsVzU2nxAAPl7y6y6pglRN?=
 =?us-ascii?Q?XsVwo0IW+rjeZL5PFhvaOuwGPFvOWPi3QBHr3FXnEvn+gL4NcHtfEQ+Tts6/?=
 =?us-ascii?Q?jHxl94PWNnajjacmjQCINtT1jVl4RfrvpTNueQdBMTfyopjuDSmO9GuqpN/x?=
 =?us-ascii?Q?4mivFcLwAkPVJ5kNFnimQABcXOBIcq9cG8gp2oZm6Ss4/CWqUtpy+Mxot5ZR?=
 =?us-ascii?Q?uK1Ud/5UEUuGUexeqJibE/CTiMTb4k8s/3wk5BhgVoBGXeAmTqAuPd77hLX+?=
 =?us-ascii?Q?xJ5eQvtvpwaR+xAvYfyw7hxLHq3cqwBea/MD4QLi7Z8tIB0NcALsrkrxfsK7?=
 =?us-ascii?Q?1RQw0RJFMjDIJsT3fiBBXot9bDENSkcFzEvkb524kxrp5ZIfdF2F/KK+2P9A?=
 =?us-ascii?Q?QYSQytpbus2gCntKWc01Wb020jArhhOnff0K7awK2f05USIyatZ1+rOW8RgZ?=
 =?us-ascii?Q?o+0emChlrWq4UBnOUgOZd7WyvDJQRM95RpYWNzBSxuKRfulKHJyeoeQFmhgN?=
 =?us-ascii?Q?DKrSt2CU3bvG77LE/867WQ8VIVUq6A0bQN8Tytp4ptKmsDmlKYFk8ASQX8Rp?=
 =?us-ascii?Q?C2sZ6CmqMvTd34AVMZxs+YKpJNcMhZOxMavlR51mTCvaPmNmBk5Oag0Yi4tg?=
 =?us-ascii?Q?z9lVqsvrHBkRl64GXU48ZEQTJ+cMUJIAOrZcwZrhFYGaJ6sb0KeOhV93aTmm?=
 =?us-ascii?Q?Y0yOPezEXnQQFXXqxre7pUoQgHLF4/uSrbA+4MUQVHIpljdGH41Ie+QveJmf?=
 =?us-ascii?Q?mOUPZA8BspLCVQSbNkrYlVIbqaypEU6r4TFl8tpkdzhzSrDcVDf3wtiZO2vb?=
 =?us-ascii?Q?5Ryvwnv0DdN46g/j92D/AFMNZU+glSIdJYiyfUuMmMaTm6b8UyDaflamq+dj?=
 =?us-ascii?Q?jURQo4+hCNAtDuEiY7dY9+usg+dZKzo2wonmLowPD0Awpo7WPV8vlgTfFxAL?=
 =?us-ascii?Q?wvsN4e4/+uX0nmI07RPQHUUmfpppXN8q0Wa+Jc5UzFIPFR8D5vnPKCEnyWXV?=
 =?us-ascii?Q?fXfmFG/LXwDeUNv0Qc+ddcL+7hXkPVMpUgo6egn3DexEciKhyD/UaBdOgGxR?=
 =?us-ascii?Q?NdDnQjUjUbmrHSyi8gS05YZ5xOBzHJi1ey0AYykcMZzc28+5eMpsscoAA+zM?=
 =?us-ascii?Q?vQpgCSFBG5vgLSbEDPGLCQ6pNwUP3icUyNCZUpufyAnX2nNWvTbUv+QjFl78?=
 =?us-ascii?Q?ysflSn1sVMc569wb+ioKyMGw3vSh3rHXQE6ojlXyl9wslG11xe7Sw5NwywtZ?=
 =?us-ascii?Q?+YYMt1e2C+SHg96G6llInKd6VCeTsaDvV3L66Vp1y/WjK9LoZLWFsR2a2n51?=
 =?us-ascii?Q?pONrxsF05hPEwoqrbPdUrJcSI5csit+7swbu3FDT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad66b248-3161-48bc-0d7e-08dd4c0708cf
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 08:18:45.4057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C88Q63+RRnRX/eFwLMS9fj0Q0hZ2YbgUIvslsvwb5581G7e5ePA61VuP1H40HwtlbVW3d/wrn3wZPoRR/WXfSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8792

Hi Tejun,

On Wed, Feb 12, 2025 at 01:08:31PM -1000, Tejun Heo wrote:
> A task wakeup can be either processed on the waker's CPU or bounced to the
> wakee's previous CPU using an IPI (ttwu_queue). Bouncing to the wakee's CPU
> avoids the waker's CPU locking and accessing the wakee's rq which can be
> expensive across cache and node boundaries.
> 
> When ttwu_queue path is taken, select_task_rq() and thus ops.select_cpu()
> are skipped. As this confused some BPF schedulers, there wasn't a good way
> for a BPF scheduler to tell whether idle CPU selection has been skipped,
> ops.enqueue() couldn't insert tasks into foreign local DSQs, and the
> performance difference on machines with simple toplogies were minimal,
> sched_ext disabled ttwu_queue.
> 
> However, this optimization makes noticeable difference on more complex
> topologies and a BPF scheduler now has an easy way tell whether
> ops.select_cpu() was skipped since 9b671793c7d9 ("sched_ext, scx_qmap: Add
> and use SCX_ENQ_CPU_SELECTED") and can insert tasks into foreign local DSQs
> since 5b26f7b920f7 ("sched_ext: Allow SCX_DSQ_LOCAL_ON for direct
> dispatches").
> 
> Implement SCX_OPS_ALLOW_QUEUED_WAKEUP which allows BPF schedulers to choose
> to enable ttwu_queue optimization.

I'm wondering whether it makes sense to introduce a new SCX_OPS flag for
this, considering that we already have the TTWU_QUEUE sched feature, that
determines this behavior.

Is this in perspective of a future scenario, when we may potentially have
multiple scx schedulers running at the same time and they may want to set a
different queued wakeup behavior?

Thanks,
-Andrea

> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-by: Neel Natu <neelnatu@google.com>
> Reported-by: Barret Rhoden <brho@google.com>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/sched/core.c |    9 ++-------
>  kernel/sched/ext.c  |   30 ++++++++++++++++++++++++------
>  kernel/sched/ext.h  |   10 ++++++++++
>  3 files changed, 36 insertions(+), 13 deletions(-)
> 
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3921,13 +3921,8 @@ bool cpus_share_resources(int this_cpu,
>  
>  static inline bool ttwu_queue_cond(struct task_struct *p, int cpu)
>  {
> -	/*
> -	 * The BPF scheduler may depend on select_task_rq() being invoked during
> -	 * wakeups. In addition, @p may end up executing on a different CPU
> -	 * regardless of what happens in the wakeup path making the ttwu_queue
> -	 * optimization less meaningful. Skip if on SCX.
> -	 */
> -	if (task_on_scx(p))
> +	/* See SCX_OPS_ALLOW_QUEUED_WAKEUP. */
> +	if (!scx_allow_ttwu_queue(p))
>  		return false;
>  
>  	/*
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -96,7 +96,7 @@ enum scx_ops_flags {
>  	/*
>  	 * Keep built-in idle tracking even if ops.update_idle() is implemented.
>  	 */
> -	SCX_OPS_KEEP_BUILTIN_IDLE = 1LLU << 0,
> +	SCX_OPS_KEEP_BUILTIN_IDLE	= 1LLU << 0,
>  
>  	/*
>  	 * By default, if there are no other task to run on the CPU, ext core
> @@ -104,7 +104,7 @@ enum scx_ops_flags {
>  	 * flag is specified, such tasks are passed to ops.enqueue() with
>  	 * %SCX_ENQ_LAST. See the comment above %SCX_ENQ_LAST for more info.
>  	 */
> -	SCX_OPS_ENQ_LAST	= 1LLU << 1,
> +	SCX_OPS_ENQ_LAST		= 1LLU << 1,
>  
>  	/*
>  	 * An exiting task may schedule after PF_EXITING is set. In such cases,
> @@ -117,13 +117,13 @@ enum scx_ops_flags {
>  	 * depend on pid lookups and wants to handle these tasks directly, the
>  	 * following flag can be used.
>  	 */
> -	SCX_OPS_ENQ_EXITING	= 1LLU << 2,
> +	SCX_OPS_ENQ_EXITING		= 1LLU << 2,
>  
>  	/*
>  	 * If set, only tasks with policy set to SCHED_EXT are attached to
>  	 * sched_ext. If clear, SCHED_NORMAL tasks are also included.
>  	 */
> -	SCX_OPS_SWITCH_PARTIAL	= 1LLU << 3,
> +	SCX_OPS_SWITCH_PARTIAL		= 1LLU << 3,
>  
>  	/*
>  	 * A migration disabled task can only execute on its current CPU. By
> @@ -136,7 +136,21 @@ enum scx_ops_flags {
>  	 * current CPU while p->nr_cpus_allowed keeps tracking p->user_cpus_ptr
>  	 * and thus may disagree with cpumask_weight(p->cpus_ptr).
>  	 */
> -	SCX_OPS_ENQ_MIGRATION_DISABLED = 1LLU << 4,
> +	SCX_OPS_ENQ_MIGRATION_DISABLED	= 1LLU << 4,
> +
> +	/*
> +	 * Queued wakeup (ttwu_queue) is an optimization during wakeups which
> +	 * bypasses ops.select_cpu() and invokes ops.enqueue() on the wakee's
> +	 * previous CPU via IPI (inter-processor interrupt) to reduce cacheline
> +	 * transfers. As the BPF scheduler may depend on ops.select_cpu() being
> +	 * invoked during wakeups, queued wakeup is disabled by default.
> +	 *
> +	 * If this ops flag is set, queued wakeup optimization is enabled and
> +	 * the BPF scheduler must be able to handle ops.enqueue() invoked on the
> +	 * wakee's CPU without preceding ops.select_cpu() even for tasks which
> +	 * may be executed on multiple CPUs.
> +	 */
> +	SCX_OPS_ALLOW_QUEUED_WAKEUP	= 1LLU << 5,
>  
>  	/*
>  	 * CPU cgroup support flags
> @@ -147,6 +161,7 @@ enum scx_ops_flags {
>  				  SCX_OPS_ENQ_LAST |
>  				  SCX_OPS_ENQ_EXITING |
>  				  SCX_OPS_ENQ_MIGRATION_DISABLED |
> +				  SCX_OPS_ALLOW_QUEUED_WAKEUP |
>  				  SCX_OPS_SWITCH_PARTIAL |
>  				  SCX_OPS_HAS_CGROUP_WEIGHT,
>  };
> @@ -897,6 +912,7 @@ DEFINE_STATIC_KEY_FALSE(__scx_switched_a
>  static struct sched_ext_ops scx_ops;
>  static bool scx_warned_zero_slice;
>  
> +DEFINE_STATIC_KEY_FALSE(scx_ops_allow_queued_wakeup);
>  static DEFINE_STATIC_KEY_FALSE(scx_ops_enq_last);
>  static DEFINE_STATIC_KEY_FALSE(scx_ops_enq_exiting);
>  static DEFINE_STATIC_KEY_FALSE(scx_ops_enq_migration_disabled);
> @@ -4717,6 +4733,7 @@ static void scx_ops_disable_workfn(struc
>  	static_branch_disable(&__scx_ops_enabled);
>  	for (i = SCX_OPI_BEGIN; i < SCX_OPI_END; i++)
>  		static_branch_disable(&scx_has_op[i]);
> +	static_branch_disable(&scx_ops_allow_queued_wakeup);
>  	static_branch_disable(&scx_ops_enq_last);
>  	static_branch_disable(&scx_ops_enq_exiting);
>  	static_branch_disable(&scx_ops_enq_migration_disabled);
> @@ -5348,9 +5365,10 @@ static int scx_ops_enable(struct sched_e
>  		if (((void (**)(void))ops)[i])
>  			static_branch_enable(&scx_has_op[i]);
>  
> +	if (ops->flags & SCX_OPS_ALLOW_QUEUED_WAKEUP)
> +		static_branch_enable(&scx_ops_allow_queued_wakeup);
>  	if (ops->flags & SCX_OPS_ENQ_LAST)
>  		static_branch_enable(&scx_ops_enq_last);
> -
>  	if (ops->flags & SCX_OPS_ENQ_EXITING)
>  		static_branch_enable(&scx_ops_enq_exiting);
>  	if (ops->flags & SCX_OPS_ENQ_MIGRATION_DISABLED)
> --- a/kernel/sched/ext.h
> +++ b/kernel/sched/ext.h
> @@ -8,6 +8,8 @@
>   */
>  #ifdef CONFIG_SCHED_CLASS_EXT
>  
> +DECLARE_STATIC_KEY_FALSE(scx_ops_allow_queued_wakeup);
> +
>  void scx_tick(struct rq *rq);
>  void init_scx_entity(struct sched_ext_entity *scx);
>  void scx_pre_fork(struct task_struct *p);
> @@ -34,6 +36,13 @@ static inline bool task_on_scx(const str
>  	return scx_enabled() && p->sched_class == &ext_sched_class;
>  }
>  
> +static inline bool scx_allow_ttwu_queue(const struct task_struct *p)
> +{
> +	return !scx_enabled() ||
> +		static_branch_likely(&scx_ops_allow_queued_wakeup) ||
> +		p->sched_class != &ext_sched_class;
> +}
> +
>  #ifdef CONFIG_SCHED_CORE
>  bool scx_prio_less(const struct task_struct *a, const struct task_struct *b,
>  		   bool in_fi);
> @@ -52,6 +61,7 @@ static inline void scx_rq_activate(struc
>  static inline void scx_rq_deactivate(struct rq *rq) {}
>  static inline int scx_check_setscheduler(struct task_struct *p, int policy) { return 0; }
>  static inline bool task_on_scx(const struct task_struct *p) { return false; }
> +static inline bool scx_allow_ttwu_queue(const struct task_struct *p) { return true; }
>  static inline void init_sched_ext_class(void) {}
>  
>  #endif	/* CONFIG_SCHED_CLASS_EXT */

