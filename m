Return-Path: <linux-kernel+bounces-426320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 397189DF1AE
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 16:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD28FB21859
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 15:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8381A01B3;
	Sat, 30 Nov 2024 15:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GhajxtHH"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192AF146A68
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 15:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732980282; cv=fail; b=i7LCGLCmdEkvAoHh1pV9P2uvL190vyWkTmLY7qC2Tfd36jPXTv1GCm0fvCPbnz5kEkcQyocDhONaQvtB4GznMD3ILUNfgZAg7k2wZMHjgi+039GIKzM4veZ6Z1Y2ZP3yABrlv4d2N/JYuwWbbtz8BrcH7zeSlHoVk3etxHWHv28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732980282; c=relaxed/simple;
	bh=5j7kisjXoLyDfa/whph9bprIOsLWjlivvb1p+7UXI2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gau3dqQcIjOXNJKfUjLy1Nv5MbVLL/OKa4CerpmYZv2QwikXPgbCs32YokuV/Aiz7Afpoo+ivk5ehlopB22/7lS7KXf5/taJCLNYbaKBwnkh2gwL3H+nWSJsY/d/DOnwpoavB8Y+BOgObbba3iyhpAUcCmTM2zWmvNeX8bU8Ct8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GhajxtHH; arc=fail smtp.client-ip=40.107.93.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O0G4ai/gAlfBe8JmSeTShHdnyMy1ZHZC6lLFSykmsbOKniFjc+sCKz/ixfVeZvAmyVeDgALotezEUTVMP9pqsPwAHW58tW0My/Celk/LYYZi5JaY6wGAH8MnIye42IQJkjE65/BzoSfdPTrkrUf3sLLSIdsbMo6Wklp8hcw2624iqHAwLqDlVB0mjZlUHyz69JvWrCK3jHvZsDcHVVy4D1QVHqx4rWEqT2cNC3iDz25XlHkdhpCMeeo13Or19IYHJtU88yVEKPX2Vw32Dt3J0emsnCi+HrhenpJ5H4yvUYL1ExN9jx3BNI5IW3xAUy95fTrv7xAEY21LLFlU846Ihw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NBla3q1XYp2xslZZv7MrrsigrbyZSpYe0UFauQxje+0=;
 b=Rp6yqP5OfeA55jGRo+HuN8pOTUdu+m+bbnJg2M8dqMRCDcUZJyexpSWQa3HOL5GD5kNcGgpvrM1kVcg1gElBXuWsx2H1nzJMZxdXEtvrU/w0wH1G8UzwleYK10pfJT7iZds511lIZR2aDVN9TMWQNvMAFSOKAZR6JrrsyFZPQeqjYveFXBjU1Jho7f2WuTO7BwVaJF50blGljCP3qVSJvC+9hyFfB4TgrP7FRe+vFxHHHHoqW/3ElYHoY0pgtzRQGUyk5qFufs0tZqPu9ywA3YX/wGaz8sWwxEbJgJSpwiCP3Jhb35XcpvYeD4HbkbzQTGPn3Nl5OeNaMSdOYaCHZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NBla3q1XYp2xslZZv7MrrsigrbyZSpYe0UFauQxje+0=;
 b=GhajxtHHsX4IVY3VK5fzPOZmYIl6nXDjZSer0KP4Q41yylvAGVvLnRY3P/8fMbb+v7X3jrhozsdQYXWBCeUM6OSmYsct5AEzQmvC+jayGnXES5Smf4pdMYh+Voh87rcfIs5YuPYtDaYwWWA0aq78i6RpLH6TBtWiZy4abKLjoclGMR2E1jbmBlLT80azLkpThe75CG67QM8Nvn8LS0TB5vQqUgo0toAvthRh+RyJRDGXatH30kenYO4c5VCHja5/fxGAhimU/u9ym3T6USpEs8kxX4fTyV461WbB8pQp44kClGUyMryJa5QmFSq+KbrRwKcn7+UmGZCFHmMbX/aMgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by SJ0PR12MB6734.namprd12.prod.outlook.com (2603:10b6:a03:478::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Sat, 30 Nov
 2024 15:24:35 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8207.014; Sat, 30 Nov 2024
 15:24:35 +0000
Date: Sat, 30 Nov 2024 16:24:32 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] sched_ext: Introduce per-NUMA idle cpumasks
Message-ID: <Z0suMHchW-KyIGyy@gpd3>
References: <20241129181230.69213-1-arighi@nvidia.com>
 <20241129181230.69213-3-arighi@nvidia.com>
 <Z0oYTbacS0lnO-jS@yury-ThinkPad>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0oYTbacS0lnO-jS@yury-ThinkPad>
X-ClientProxiedBy: MI1P293CA0005.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::12) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|SJ0PR12MB6734:EE_
X-MS-Office365-Filtering-Correlation-Id: 01e6ec30-5903-4e16-a2e6-08dd11531915
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kS7YEP0VM+jC3Wy0g/wpe2GfBuR0mqElGKhLu7yHHKbb69OGtr3abjRP6jOa?=
 =?us-ascii?Q?fq6MKIVNNO+2GYOfE6Ewpj+0xnBaaztEZQi+qzo+7az5yJ+HNTlbe77lAZky?=
 =?us-ascii?Q?S//S6EAiKn62D77isa2n3mlF41CuxT7wuJurc/rSqupEGxE/ALXSPc9wscao?=
 =?us-ascii?Q?p+tPGOStGfiN+ByZoXrRCqgsZRuREBztJeq4KLFOS7B7t3kF6fca1tW2DeuV?=
 =?us-ascii?Q?HYn1SrJ7yAcM9gsuaX7il9Ntsd5hetPhpQbPjLYRnxbG0FdsEPoZa2m1GNTA?=
 =?us-ascii?Q?QCD1LO6dZ+iKsw/+rLrh1YqUurPzvlcMCYFEmDqB3inH787QaWhU50Qn13J2?=
 =?us-ascii?Q?nnV+wpnVkycmRJIeWN3W+s2VKXj+mNHyNpfr9c9RAcG8eI/NKyCZzDW8iBsj?=
 =?us-ascii?Q?soiuttG2QuvVwnqbkoqOHIkNiFxkyJZO4glzEkoy3f9GYOnPehig6cSKanj/?=
 =?us-ascii?Q?SDc+re+rxyMqg0ns3XECct9IHbS4qyD5SdonHG7XIpxgaj2rh+gsAT4yGxzN?=
 =?us-ascii?Q?OswayWom7CGQh/BHf1JcBflKJbHjGs2T0aIpuBgOi1QFhMUM2wcRCc8U+M5B?=
 =?us-ascii?Q?DCMwjTXrJG8TJGJvvNS7oSniBXWzJJKI8y8m+Yb6gy9MYoEdyEHvZWbHswRL?=
 =?us-ascii?Q?09rsFokNmrIZf/KyfAfrn5fjuvFKCP18/hHtTvnqqZtdCG4lvYdoGWJqCray?=
 =?us-ascii?Q?gy7MN+nVAZvLXSeVbDPRlGIK88ikj1C5HcRUNS2+ZDBKikrIxLB0Ag1VIGcc?=
 =?us-ascii?Q?oeon47qhuIrUt3EoA+EjY2iFNeqsmlMY1JxdMMa553WPErLv9q11/kuCwnu0?=
 =?us-ascii?Q?VYQBVyAlQDPYd3Z2+5AgIbJt9INR+Q0J927Do40faT7FZX/3XpuFldZ0W6yw?=
 =?us-ascii?Q?5/1dqlX112Kibqi/DzuTQgnd2fWLp/IyeSrmVfwik0WOrVBz2RduxqyFSvmA?=
 =?us-ascii?Q?+ViE5Cf6Yjro0yWEkK8vGCHEKPN1WJrgeegBdrbcX1VzT7E04lRGE6jVR3sf?=
 =?us-ascii?Q?OXenHJzYZF1kRi0FZXLMzj7FqIXNWpWOj38UI7YgKipDjIGZBn+BqkTefCQQ?=
 =?us-ascii?Q?3d4Va6P7IHNO5uUCeNHuVgbuVRAZYfEFJG9VU+8zjXc2Jo+RxitCOGTmc9It?=
 =?us-ascii?Q?RSwiRGbl9iQgSdUKlyRodmuzSb0Z2Sy5S9q5c04HGuK6UjNbYh07XaHE8Hjr?=
 =?us-ascii?Q?SYFwsgho5d73808LTCeL4uCeE/tn9+OhlvvOPPQskLpA0y65CKzLv04k3mL5?=
 =?us-ascii?Q?L9RUMb8WbXORsYz+Ue3u/MFyQuVG62f/xfJR07Cvlp5o5q56d3wb1k0uZVig?=
 =?us-ascii?Q?xtzI1LZtUuS6aBFHVU1rf/pWt9IOG7r6CskGcEZSeDD7nA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TBXkwu+6m8+fzlZrPM5qP2WletMB1R35d0n/k0LQi/MzSC4KPY8pJcDPIAq4?=
 =?us-ascii?Q?7oirB9XOpv1f7RB8O6rTnNcHxYIP4VgRNpe2ddmu8MIWPHRfo6QzjrxEHYeY?=
 =?us-ascii?Q?l6yJT79eQfyakHECKcDOupbkrX5j8kmisChFuZt3gh/2bscM5SoRHQ1XGb8k?=
 =?us-ascii?Q?33yDjLxn8N5V+rt1XzaFNp4Wx0+C8qSFHd12K+RwkNLWCviS8ZTG4+LjTRLP?=
 =?us-ascii?Q?4UGiuoSGFm43/X5QaY9hvltT17xamVanblVqYessk9HODlncu7a3Yok0cYgr?=
 =?us-ascii?Q?EnGooNdaf+Pfa6DKq0Da4eVs1N24ipKbJotQLPrW8w7/e3PWxujr6jDD4ZDa?=
 =?us-ascii?Q?MvE7FVPVKjfWUeEs1XCA1v2cZpQerpF33Hj2D1b221bLRofoEJ+hqCmp6aG7?=
 =?us-ascii?Q?tWp/t5gpAiA9PM4YGBGo74TF7biA2y78gOAoPO9Yr3Rhlje/oENMcNj+RbvV?=
 =?us-ascii?Q?Wc2CWAZ/hK9hIbE8uKfIyCaPYbxDCUV77StWi1Xt5o8XlQwZKg9nmAyhuY4R?=
 =?us-ascii?Q?5QDKGanm0rCGRJlUOvNVU+Cg7flYo4xZrTV/H+PwsZtxAizq+ZYSVaBE2NVU?=
 =?us-ascii?Q?LrMGQSD9XV4fbnFe06GFONs+CYOUBVXaILQKrbyOEVhYqcqT9kw7UoFkHvSw?=
 =?us-ascii?Q?mxsittSk8ht8+HZRg7EQeVB/TfqMzzUjk8/S1MKH1HqFhmM8nZZHoN32y7Za?=
 =?us-ascii?Q?jKd1To8xWZ9WEmWEIGP+5dBNtH/qSLru5+WthYbEbW6x5srv771dL+A6aPoo?=
 =?us-ascii?Q?AVUtBuX1mN06K81tPFSmhCA413wTNZoc9cvSAJYM+rotwtv1lszjNWgMG19m?=
 =?us-ascii?Q?c9Rh9Aet+Z9RRFM3tdCwm931me40pN33bOtrhxXmbGSK5svoBvfAox4ZIM0t?=
 =?us-ascii?Q?LTIfwNcX1TNJwqPceQMHg3fFmY/KesoXzVGZQizqa1ROtrySuThC2DzViCHI?=
 =?us-ascii?Q?ni1CeGHkMiI74eec2X7k7COY6PwSDHXsTwJdIT473+8h9tHFeEGaym7l5rVa?=
 =?us-ascii?Q?TPAzhc8R7Knb7L/Q+jPTZL/7lqp6Df/gHLEhuTf0QUpPzsgUM0Pcn11GfvAz?=
 =?us-ascii?Q?bKRz2/0I7b7nhTogOOjwcosovH+d8T8PM0Y7uiGNvogi1OmePaozhCaGX0/Z?=
 =?us-ascii?Q?eyAPo6Y0GJvm6/ovWUpMKJyaRfOQhqZkaceunp1ZZ0kv0FJX3sGOrDmciv4e?=
 =?us-ascii?Q?Mt3gK4N9hc3QzL0X/EMxFTXpgZIlnIeEIRkS1P1nv3+cROVZrF22s/CJNYj1?=
 =?us-ascii?Q?DX9XwrSN3F402UozQhqKzXQ98WL/jT4vqSA+hNMk826Cjhiv5g6/XEOEEoQ8?=
 =?us-ascii?Q?FQMiJkYHtT8X4czglGzc7KmbTyQDt3B4OStFuGwF16FCKJ4aXGWWtgIecnIG?=
 =?us-ascii?Q?uWb2h0q2a4lt+6peqBKULkQ8++T782ni6XAy1YfeLRqlK9zxstpfwnp2mJ+8?=
 =?us-ascii?Q?RaEh2dAzaDT4dWjKwQlUOIyAEjZ3tQFe2oEGc5v2WDofmr6xHFPlYCThdGID?=
 =?us-ascii?Q?XgYAFB8sjJypja0o2iY52W9x2nTJocTfsp2+hwF7zMmJMVKMYHf4YR2o/GO7?=
 =?us-ascii?Q?AatAWV7mF70ucF3ZuY+ZcpN78IrKqqYWmxzXtpvn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01e6ec30-5903-4e16-a2e6-08dd11531915
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2024 15:24:35.8412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: glmFSs8r1vZO6QMmWKLfkdo7r3UXqx5d75o3ZzvoewGCjBOYWh9+78wgsX4O76sHEDDdDMvAoknogPeEYXkjCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6734

On Fri, Nov 29, 2024 at 11:38:53AM -0800, Yury Norov wrote:
...
> >  static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags)
> >  {
> > -     int cpu;
> > +     int start = cpu_to_node(smp_processor_id());
> > +     int node, cpu;
> >
> >  retry:
> >       if (sched_smt_active()) {
> > -             cpu = cpumask_any_and_distribute(idle_masks.smt, cpus_allowed);
> > -             if (cpu < nr_cpu_ids)
> > -                     goto found;
> > +             for_each_node_state_wrap(node, N_ONLINE, start) {
> > +                     if (!cpumask_intersects(idle_masks[node]->smt, cpus_allowed))
> > +                             continue;
> > +                     cpu = cpumask_any_and_distribute(idle_masks[node]->smt, cpus_allowed);
> > +                     if (cpu < nr_cpu_ids)
> > +                             goto found;
> > +             }
> 
> Here the same consideration is applicable as for v1:
> if idle_masks[node]->smt and cpus_allowed are disjoint, the
> cpumask_any_and_distribute() will return >= nr_cpu_ids, and we'll go to
> the next iteration. No need to call cpumask_intersects().

For some reason, removing cpumask_intersects() here seems to introduce a
slight performance drop.

My initial assumption was that the performance drop occurs because
cpus_allowed often doesn't intersect with idle_masks[node]->smt (since
cpus_allowed usually doesn't span multiple NUMA nodes), so running
cpumask_any_and_distribute() on N cpumasks (worst case) is slower than
first checking for an intersection.

However, I will rerun the test to ensure that the regression is
consistent and not just a measurement error.

-Andrea

