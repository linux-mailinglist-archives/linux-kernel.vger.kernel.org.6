Return-Path: <linux-kernel+bounces-577663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72963A71FFD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 21:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FBAD3B8A5E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 20:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91857254843;
	Wed, 26 Mar 2025 20:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qFOTz4Gy"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE51185955
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 20:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743020477; cv=fail; b=iGb/ZuZ+k+r4ojkWPrrbSGavpHfGzHPuM+1g3uv5q6EksnijZUoiKhv0Ai60bHTUS7i1vX+U5kvBKrN9BIG3TnUDlFh25fvZQNv/s61JZM5oAtM/MX8W7w6RtWcQ/auMF3oqYbPXqOdNmIBfyHwMqkgYhADE8NCXt5IOlUpzNRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743020477; c=relaxed/simple;
	bh=bxaEiyvYlg14zVHYNxzCzB/vj3xCupuuNTGkzkVJpV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CXqdG0MXlywSsIKx3x7wyE/eQheeG3Kzo1PRAZ7fNpSlzT/Oyoe/q6eqlQEqQUK+17BkATjYPns+Ijw3bthH3a1FmMXoAWPV1LcNUtnMidnN7L5F3QGak1ZP00TvPCMiU+b8vMSQnr8UCvEziXFiDzdBALXW+qwAMgA99o/GaN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qFOTz4Gy; arc=fail smtp.client-ip=40.107.237.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dxO3AGYtzi/V707cgMSPU0d2WP734SgWT1/GBgvsnixet6h4I4iSHv+8yZgjXdbGtB3/o4GTSIFtX7fFluqxFQQPV7qGB056pn6ok0ueO/D/Njf1BCK0hFd2wFCnGnppl4Y9mYxVmD30fY+Mo6pfkbDD1LM7PuzgDZ+QX1ZZZEUKQ0syFwFi/eXYL9kN3nN25CwMNhNzhv3qJfkUyznhv7Ly86Cvp7WozZtAgghHnB9RgWyJG7Kq970025fWWeIDxDeGvGO8I175TlcSy3yvUwYb+MaxA2Ud3/1GyKw4JggGUAuR8f2O5gIRJMi9VQjrufHubG8Cn4+dBoelDZe7+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I8WJzwiGlC4WxOht7djXhrX64AA0Ci92oH4XgGKCkVA=;
 b=Q9dIIjc4r2a0LyC463GvvkDejfNcZkslyRJxySujMU2aXw/WdlMUDYX1rbRYrkIQXnL2/k5FIEvq6iYKkKefmR5BNlPjUDr8xs80R+uU93ovLDQU1WPx0h/+EIfcSOGdNcT6mVPlt+1KX9HuOo2qF19ltcDRb3OBUKiuZ3RNr7Ztw4WAXnyJhk5BOEjTL2locR8VyppJCQcRwfvZtHuZ9Um2TC2ddG4cVIiZ5ft55X5G4hMqJyjS9DbzHol1576v4ZQMVkheUNaOOtM8ZR4ix/SBvPUvbIWlG/TkDk77+614A47yERYz3wQTZnJiQSP2D8KtW8DPN1tnljWVCj4QSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I8WJzwiGlC4WxOht7djXhrX64AA0Ci92oH4XgGKCkVA=;
 b=qFOTz4GyU0qeVT8wxf/VLxTezCCXqOVKtE/7SUJMuf0aXcmwyS4sI//eSpAQm85mBWI65b/j0+mThbfMdGZsPOBUASYEv13poDSq7DzsEAnJRIYTVGV0pXycuzgFINGRr4yRag++r5ukyv3M2OvL6RZ1O6wtT01FWcK1SX/4PvccNlCxuVWIBLhwdom9sUwZCPn/OhGfxOuIdV0IDRpgG418bsk1bdELRBUisdJBT6lUA/hHGVeZMMc673rYNYsNuX6oL8u2CP6PbKMKYDRj8fXlOs+BYYt5FVTwKrJQlm8qJ13uzTbuLrPvwQ4QOOKbteELX2pOdALMYuawTa81Jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by PH7PR12MB6612.namprd12.prod.outlook.com (2603:10b6:510:210::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 20:21:12 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8534.040; Wed, 26 Mar 2025
 20:21:12 +0000
Date: Wed, 26 Mar 2025 21:21:04 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-6.15-fixes] sched_ext: Remove a meaningless
 conditional goto in scx_select_cpu_dfl()
Message-ID: <Z-RhsP84IcMyLodA@gpd3>
References: <Z-Rfm5MVdm5rDyYC@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-Rfm5MVdm5rDyYC@slm.duckdns.org>
X-ClientProxiedBy: MI1P293CA0013.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::15) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|PH7PR12MB6612:EE_
X-MS-Office365-Filtering-Correlation-Id: e1884447-deab-487c-a430-08dd6ca3c0a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rZOqYOMKPVhrJo472jWYRQLjP0b5TCpK89gWB+if65anuRmZwySU8KTVr3k9?=
 =?us-ascii?Q?AmhRdPr3vr5Q+HneGfL8JGD5nIMZru7Equ47KAIBMo5dU48IPaNb2RyKdjc/?=
 =?us-ascii?Q?a2gsO09QZabF4fJG3fnPAgqoC0AIPLt23pql0WegmMlFNN9TLLmlVX7KHWox?=
 =?us-ascii?Q?y6bLaE0pmbNSiJ0T6tdqMl+OjGyuM4aZrQ0uM+BGvAQiZIbKrybMPpv9Db2F?=
 =?us-ascii?Q?r34OrCll1VwrDwAEVSjwD+gE5Cd4rXpWmJ8Fcfp2wqOdqjQDnFXFTFr4GpET?=
 =?us-ascii?Q?+Z5BNYwjr3U8YWYuV+kcAQFSIwthDxlGx/5e5afDSB5NKCBKpEUh/F8CFYBJ?=
 =?us-ascii?Q?zZ3pbGsBRN4aLDSzPYnrXlm0ak+rbKAJCt248iihThykv77gfTNyczl5lI25?=
 =?us-ascii?Q?NDin3mBuhNbg0tmNoQ9Z2cnTwnnR0l9afkQ9XFuToWpUP6maeAG6Az3C25AV?=
 =?us-ascii?Q?lVsRLd+oYLIhw7J7glvsuypYEMGY6j38mG+WYbr8JCQizJCLbLG/Xa3KBvnH?=
 =?us-ascii?Q?wy1Teqkai+NQeyUM7MG46c2DrnrC2YUm2WwdTwoClVTWHlOK90fTkHpbmKDO?=
 =?us-ascii?Q?kHeAP2zz7zj/63S21BEORHjoaRCUi7RMwojZtXlo17vy3XMxzYuwY81jQnQ+?=
 =?us-ascii?Q?d3TP56FC34HCWVJb2xl9fehP1RC8PJIDZBdf7yNoyWbiFMAHSRL3d5OGrqHg?=
 =?us-ascii?Q?c+3ws1HRw4hN+VBsluBZrrvnOOySUr2k+4Tw1obskWy1wzHwsdewwY/Kp1C0?=
 =?us-ascii?Q?6SWMLn2w/1AltpgjgBw8mb0sVUc4jJEEp9mPZ+qe0dmzUrAPpSKajr03BnbD?=
 =?us-ascii?Q?wmeJfwmXJsF5JrP9q/1MWxk6Xp2vrOd1K+d9js/Nv24bazwaSiiKif/oLbLv?=
 =?us-ascii?Q?jxUHYoNB5XsQ3L26j48PDzezNIU87PcNc0t46zuTQW0p3enPchbqXOKPJIAi?=
 =?us-ascii?Q?NHlySzrUq0+SyCEw2PrB0gwJLl27i+vwndneLJgUhxD17/4VpSvmA9RJ6XZr?=
 =?us-ascii?Q?cbsWZqYmGMxhdpIyES7fBWGZ+0j5xIY0c6wByfoSjxteAKytUpw8CxFkMKli?=
 =?us-ascii?Q?G1aPCCJrsE+5yk7IcyP5vUQ++0ApdmUzGn2y56IVKJcSX+uEx3adqYHeOX+x?=
 =?us-ascii?Q?Rm2XsTGg/Jn9yonf1wT4hoku29q1xXHkJ7kitYbyh69cTmO1dhrjGYw9LcHW?=
 =?us-ascii?Q?IP6vcI9fG1lUVP2VLumEDzQXVArm3PZGKiohBGk/yeoqig7EoV+iebLF2Ois?=
 =?us-ascii?Q?CtiXezH/ZJgfkkYeRHQTf4LBGQjcu9T8yLNnT16eBUWzEl7Fosy8jwZI3gMG?=
 =?us-ascii?Q?qHSXob9LiqCo2vcDtLroenVjDKYlT1+Xd7xJQhOtfLMhLRTezqrm+3l+jKZv?=
 =?us-ascii?Q?oQlItsKy8oCFklv83mMlgpv7hdf3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o8otL137biS9RIhb66Fd3xrBGX+IDfAUbHCCKXezyZMCNcnKrirVJtn++9B3?=
 =?us-ascii?Q?KHiVwkYPV9NW0pfLGWGYq2VLOqh5SbqzK89eqbRYxQrbXo7ArDGMH5/yfpVr?=
 =?us-ascii?Q?njrq+1cJJvyx1/rR/MnRDMzoSIXADRqG+WZJPH1beSCgut97xyD2a6gSImjt?=
 =?us-ascii?Q?a03k7u3JYFaw3HAWgU0XfuhqJd4iuazXjq9iXy4ZlzBV4EjAExoYYx9kQwC2?=
 =?us-ascii?Q?tqSu8ddz5NWhms4pWgsr/dUg+AGAXG9l11Gc23M0bT03rzQ9ANP2ffNrqCh7?=
 =?us-ascii?Q?Kj99XrkZtyT10dO68x7NP3JCNMVGCXpxuigR/jly++3tLQrj2T0SehunWNdL?=
 =?us-ascii?Q?9K0yC/Df+Nfo2hRt7e2Vkaax3SoY4aLsb99jrPj1x/lP/vDQoDAwXwZ1LYo6?=
 =?us-ascii?Q?1QL7jAffyxKY3CQnjmerk7uC68PfabcMgVjnOR19dN2aWBjJZ0o/rFkWdumL?=
 =?us-ascii?Q?HYgveWr3H6NjyYWA0DR1ZnHTsc3AUyrOnxUgukQ/lo0Ml8JdSxxUxoEWEXKL?=
 =?us-ascii?Q?Z80LNVB+Ny1a/MuFS5gSeEGYCREoN/PEGeGRQdsqp43pkJtynPEoRatGJMrs?=
 =?us-ascii?Q?xha4xD96Fs+4R0ReLpxKku3VtTYkTdau+pARZgytqV4TqfPz8F5KtKtT3pvY?=
 =?us-ascii?Q?ICD6kmpHOASkBwTfZ2gqhDq5lbHfyb8Z/lhfwrcJRWgHE/JuG11gsBJD9ZAW?=
 =?us-ascii?Q?oyKgrYi3RatOd+6mUHn/OpkqwcI9fxGxB3Ew2/dzc4d8CoJ2arwnLwnzpS+f?=
 =?us-ascii?Q?eLC1otK9Xxywntldvu8grrIe+qsAGmWxmJs3jXXXDaRfIvKYNbQnU+Xp8e69?=
 =?us-ascii?Q?SrMgcZHIuna6sE2A5FakjsdmSq5WAbO7L/UoQxnT7XAmgYfNEzaFlh6HluK8?=
 =?us-ascii?Q?lKdWntzbaPR4FqFlpfy5rpX+ABd+nnsb1whPcrNtQl6AqrLznmJXC5dajh95?=
 =?us-ascii?Q?Png5j8aRv+t6Xhiv2+nIeEJQf3ZyK18DGTr/CDhNdB/UdaLSHg6lVauU/sln?=
 =?us-ascii?Q?OY0317rg5/RBPpu5ER094ThP0KSTHSGu6DC09U9jLEnDJskQROnwpX4WmSGf?=
 =?us-ascii?Q?XKRoB9+O0tBxfTKyBF1mUKvjWzJkyxYVVWX4uA9s+IJVsjwFckQLgxwcjQ5T?=
 =?us-ascii?Q?nh0RtiTIQTeHVRP4yIwy9omxmvUDF0AXMJUANxoGi88oqAaqmLi78kB8x/8Z?=
 =?us-ascii?Q?kN2Z9u+cMTzPRF+jWRPAI87XXyL+Gsxwfa9Dk2rA8X88FHkJg2hh/Iea+uUO?=
 =?us-ascii?Q?kvvua6HlBlfWFfObmUexBVhVDW65i6wH0mOynD9K2AW5DpyJKwClm472u+ro?=
 =?us-ascii?Q?uJ8P/DkRXuFk8IzE1ZZqBOOJAZIS9NdVJFQtXGcCoIqM6p5BbG3cbd76GamH?=
 =?us-ascii?Q?0LCLFagyCovRqFnsrGh5apkgOWOyu6ayiC79NrnVbOyV0TUfUeB7/Iv4HWJ+?=
 =?us-ascii?Q?PNarInRvvWkS+jQRfPW1pypkM0IayS0sYpOKjnLe6oE+n6FMlo6Zanmvv2NA?=
 =?us-ascii?Q?S2yb+jrHuJsQv+c+EfkeF8zLT2qLDZwTYyzOY1HLR4us89Bz6QUjgNUq6b+N?=
 =?us-ascii?Q?3tEj87h6gSfnPcvbKm/DiooVFpGtcc4aQz4sJeLr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1884447-deab-487c-a430-08dd6ca3c0a9
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 20:21:12.5315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e8ubYIouzNm8FLw0I1VtXnbfJmTVA782DtOy/LIjimx730QMPEpWXjnIHfzoGtgxDV2epS8RmOgN7xGe9t3qjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6612

On Wed, Mar 26, 2025 at 10:12:11AM -1000, Tejun Heo wrote:
> scx_select_cpu_dfl() has a meaningless conditional goto at the end. Remove
> it. No functional changes.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Andrea Righi <arighi@nvidia.com>

Looks good, thanks!

Acked-by: Andrea Righi <arighi@nvidia.com>

-Andrea

> ---
> Applied to sched_ext/for-6.15-fixes. Thanks.
> 
>  kernel/sched/ext_idle.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
> index 45061b584380..b5f451e616d4 100644
> --- a/kernel/sched/ext_idle.c
> +++ b/kernel/sched/ext_idle.c
> @@ -584,8 +584,6 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64
>  	 * increasing distance.
>  	 */
>  	cpu = scx_pick_idle_cpu(p->cpus_ptr, node, flags);
> -	if (cpu >= 0)
> -		goto out_unlock;
>  
>  out_unlock:
>  	rcu_read_unlock();
> -- 
> 2.48.1
> 

