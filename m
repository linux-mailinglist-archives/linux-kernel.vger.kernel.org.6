Return-Path: <linux-kernel+bounces-381060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFC09AF9BE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 08:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E341028396C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 06:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D00819939D;
	Fri, 25 Oct 2024 06:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mQd4ebja"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2043.outbound.protection.outlook.com [40.107.212.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD41F18C346
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 06:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729837009; cv=fail; b=bACCcRKEUkh1N0LUO6CLNNvKgbk2gIwjNTfShbp/1/bQn/E2vbTaaVSbb8SE7Myh+UB+7dn3oNZkf0hOoZ7BVJAZGY8NFVVsUujEnv+ylU3po/p6r0N3VhgTUrylf/1/MseGRXwM2yPDJ8VLxCLLfq1rzT0D3tJJLbmD7SEbuh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729837009; c=relaxed/simple;
	bh=Wi2CoIShDYh/bnEAzDmw/PZosJ9q0jdCzxukd8h3Qw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=vFdcuBRcO0+o2Iaa4fv415k+tzBSO+Zo8khAdTpEjhPDV8OaaTkrKB6gMuU5pSs7X7aoxRwChWuSQkjQGaU5t3rAkU6OnBiC8E9Dtgk2SH7uMdIEexVmKjL7GomkpijJTWzULZfe68jRpqtjTfHzwYzgOw20Jm/9fHTUNtH/LB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mQd4ebja; arc=fail smtp.client-ip=40.107.212.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZDd8dZYw9UtCffVHYxhBISa2uqbrzHZjtgnXy0kFuVGPqf8CXKwPGt2XtK0oYsyGw4mA+NiT17+zkJkIfOsADSOX9MpJa//6vye4XHVGnLh9or2AMhUW5arsQl2ja83nRiaGk8A27C88ksvOqMFwDa/OH6d3Kr9OjPe1VlvhlBoWg3FQSffd56UISZ9QgVy8dkND+PfXYbBEqgvkkB4Nj6pxVqkmOJBUlUZY4MqrMR9hIYbmHVmvNWxPEKeGhe7xVbsGFTxwjFQPqIaUGakMcCAQBdUPYPdeSKZy1FrwI95/8FLmD/uYvOVKGoSxylqVmQAKg0J++uv0f87rn5ZhCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uVe5a8uquC/AYxRNF1kH6k3/RVQpaooqmQK0TMMen70=;
 b=knhszN0yqhjzUlm0pZAJdeKKX/wwPu2lVj2/AD1RAwmUhFt6rb7kg8gL5clODO4oTx7xhuZHKSYz5eyxNr8imXLmDr3H6JGoHPahkdReZr3CSE3mwS/avu3875acaztTCc+kPXTr/DJMm2dJk9kTyTJkH4WARQ/q7jt0feN3oM1pRxudVm8YI0sQySJU4mTWDEJd48dxZziBKfbxSIL3G4OYTLY3WgGF/5tWCZkFen2IxIF2DRQSPfcRRnlK1dMJOm/v9vgVDlHkNhenonUE2TUeXD7mpGRVuHkcUonQfJfgsl7zeexzXIr0f6dGRV4T+GIgFlMGXdJxNH2IbO6wLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uVe5a8uquC/AYxRNF1kH6k3/RVQpaooqmQK0TMMen70=;
 b=mQd4ebjahP/nGb6Q9Qpck5lbo8h8Fx7fCl9Dsc2CfH8SOOwc/5iJvO8JVFg9VmtEaI1YGASWUQADW5n4XOCc6A6tMiz8Ul06YnHsBvm4/RgNOyJQqXDysFzA1ADOgbJG2jeH/OYTsjCYwkZofA/3cimrGCXJKC7yoQboHwtzhdA6HPsZZ0kcIxiWD2356rsCSxOlqKRL4NGSxpDtpB5sWsEIth07SGc2+ASea21p1JqdCfx+MSKb6yIr4+76ZAQcfuwCavDaCN4NIOBCYr7MWSbIu0F6XMSwFzPumpVt4a2k84B4pZP9JKNhw/fCBuuNPt3yVLPyc1qIDdJjqV7onQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by SJ1PR12MB6219.namprd12.prod.outlook.com (2603:10b6:a03:456::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 06:16:44 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8069.027; Fri, 25 Oct 2024
 06:16:44 +0000
Date: Fri, 25 Oct 2024 08:16:39 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Introduce NUMA awareness to the default idle
 selection policy
Message-ID: <Zxs3x5EUMQCQkpJX@gpd3>
References: <20241024083615.64948-1-arighi@nvidia.com>
 <Zxqc7jI8USKFX9-p@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zxqc7jI8USKFX9-p@slm.duckdns.org>
X-ClientProxiedBy: ZR0P278CA0136.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::15) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|SJ1PR12MB6219:EE_
X-MS-Office365-Filtering-Correlation-Id: 37476913-68ed-4323-7bf5-08dcf4bc9918
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f70cpDZA3qWXBdj4Z48qbwq4DgpcDZu072n5ynDLpsONaOHgw7IuXwUyPQ4S?=
 =?us-ascii?Q?SIX3PWY98W5psmWn3azV7xFf65T2hOcdGyLOgq5gcL7luLqH1V9l6qLWS8Bx?=
 =?us-ascii?Q?PfOtrGu79VZOXfjkjHiKTplpByWth7LoThAK8bad5H6vpigIa66zUQqaVeXB?=
 =?us-ascii?Q?1WE18+3LVa6IoDm24Xdp+BMmLJ4PLqZi4Q59YsnT/Ci04PuYpIoBpbSMTT3u?=
 =?us-ascii?Q?qc8Mh0hidV3vmDXhWzqQSdGHe5gUHe8z/Se9ONnWhh8vfo2XXmx0VkXx3/Qm?=
 =?us-ascii?Q?va0I7rSzNrFsKzvrz6ZGQ0USzxKFOLUGxjDTQyS3t8UDSXurMLwNIZnQJ5Cj?=
 =?us-ascii?Q?7dy5aFLVwctAIIzuL0PzhVvBXpRiu5p/ahq88InEa1XGXigPXhoJ9Fq+ygjm?=
 =?us-ascii?Q?MKTv7RDyOClxXQW7TNTICf1ilgrqVnEMqA7OkbpoNfGzEc2EpuRoTo/6WvTn?=
 =?us-ascii?Q?u9EKmg9fbcGXN3c86jwhthWyrM4X/3FAVB5h2ttoYEjl/Zd6686jS+1IeCqH?=
 =?us-ascii?Q?2dWmRO1nSOZ/IyXJhVfdPYM/hR7FrXhQKshzpmUsnxDp2tv94jYQJOrrYjad?=
 =?us-ascii?Q?Q+8UZaHDl+i3zFiWMayXuqlkZ6boZK2myARKyo4Ra4LH3wZKnXVLK2Qx0HYI?=
 =?us-ascii?Q?eKdYTaEmBn//JYL0pQ+90HHuQyYxKgZ281FE8svOnjjmqahE8VMTwtZUoKsb?=
 =?us-ascii?Q?4VxCAJ9wXS/JIKIIDl4SClqDmg6PG7wvGSVuGHs484qPlYM5D1ue3DJc5d0H?=
 =?us-ascii?Q?12+NFYITvGDWkaU5RXrFyqb8dF/mCLPxcppMlAYuZISZDZGFuUZkpz6f407w?=
 =?us-ascii?Q?cixWKWB0xvt984GNHeQetA9peWZPbb9gpfuiLztxOhf8gXtZEp+0nPBXZxoi?=
 =?us-ascii?Q?OjpmS9km1im7o2rMZsoH9RQubPNae2Aa45Jo+lMOMkuLjzgTD5TgnohNZzVs?=
 =?us-ascii?Q?fCdS96HhODaoGD6ff4ZG6SsxdUEgdryHviaRT6HIrqfpF7eVhh7WBlLoTTEY?=
 =?us-ascii?Q?6d2dDvFvZv6RkoP3j5/fFbm0lQAsjvnUzSgVjbW0e9vrusbgN8Qnar6aeSVX?=
 =?us-ascii?Q?mFwx0fEfzO8GddE8KXwgg2AWgfYUYvDdT/Jck0Urs1++fLxRnDXRrgIvtPMl?=
 =?us-ascii?Q?+QftudoOrU5VBgZyXPn+8JMdhfqmDl19eOso8q6jNpuMvblwWLctcrPa5nk5?=
 =?us-ascii?Q?NqEwYCero63t/9lOHEESUabPE3cOI77zVqOnqHxKIH1nGWUukRLxBjR/1BM6?=
 =?us-ascii?Q?kzNf8hWyPLWcZyq5LIxlekplDimScBrNfQdc3/28OvstULbPMLveBdHvAdAB?=
 =?us-ascii?Q?Wd/N1knrOnNV8K5CvKOI538n?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WmtcLYa2wzdemGAC13o94irbGovnh5kF6fNghVU2HOIIHliUxJ/ftf/ZfoYp?=
 =?us-ascii?Q?gSB0ySw/Cn0cMoWavcRX0t33Wvm+MiHj7YMJvDKLW4jVsjomb3U5ihVcBdCC?=
 =?us-ascii?Q?LZRt1AILpRtpzcx70nnk0akrSVkVeYbB6lSF/0jVSexbT9QKbLyHQ13z6vTN?=
 =?us-ascii?Q?W1VJQG5F4R4qmjGzuQ+Ngzb/SSSjwUSJZERpRO7UHTMcWhvusU8LkTAvYcgv?=
 =?us-ascii?Q?AllawRLhIJ4F277Aq1mdMOW2hQMO8kR+EBKAofUL0hM/3n3/+TPazMXrGFAF?=
 =?us-ascii?Q?a69qDt/btKvPzyY54T1aaob4d7NL+4Tgq0AhvxI1aztegVIrJ9rguox8aLo5?=
 =?us-ascii?Q?q1c2P1mVNBej+EmA0/4l6FPj0rWWM3FVkk775sjz+OEo9k6gFWXE+dhb25Rt?=
 =?us-ascii?Q?uvQVeE1srpG/l/W4vn/Fedcu6dtxDbLzAKkFYN+z30HK3uWwQtL51NkOLnJK?=
 =?us-ascii?Q?r5GHo6voJjJrH5ir05rdoteO75ccomiz0eKTuPnuIolSMcvZ3ip9uqr0f8oU?=
 =?us-ascii?Q?ELNGVwtvGHIZHtYMHqn/5eRlLJHd6e6FAtUado2QdlGOjdf1JFAGbv3IDhqR?=
 =?us-ascii?Q?dWeFDjAt67IcPg1i2yn9WF6nOxiVILmZsxrng9nw+kmdhU/DC1LCiTfpwQ7l?=
 =?us-ascii?Q?2JllZc5W7ecL8+IG4r1sFpwFufyoHKhG00O03PMeOmDhMrvAqFt+VWIAuU9P?=
 =?us-ascii?Q?lXarVt2ptziliwCDQrS3boWedYCNGSwpVTiC30pt71FOQDWjXn5iwxCxnL+G?=
 =?us-ascii?Q?AYCb56KuKjSoG9NvkGXqbO/XHgYrVfkFNV70NtGRJolcaRRZtFqbV8PrK+xX?=
 =?us-ascii?Q?TrtHbDPf0hpgT3B9gqziYNUeq9LbHbzV1xQxYbgv9YoDdan8OJcua8y0/5Et?=
 =?us-ascii?Q?VUXbiBqRVXwLP6U8/T9Sgu4FZWcJPy7JyqvgKHxIhRhYZfOvu8VLgdYbPprX?=
 =?us-ascii?Q?8oVevBzoBjYb/DC5ExOXGBluKrc7URdPF2TinUcUGwNvwntb2p+arozXmUns?=
 =?us-ascii?Q?cgQ5/CGvPfntdh9X+ASjNy4L9pFuzVYj2MXWLMxbRaj1Qks7EoL7h33Nfr8+?=
 =?us-ascii?Q?lXfM0Aee1Jf9jdkZi0P8eRRz4M9adgBOBjLcUJolakHRq9LzNrekreD+WSg2?=
 =?us-ascii?Q?zkvHVZvHN7LKa/X5akKtBY+XuaDzRii3kYcKN8ZiRbopAoM17pIjFUUb30Ow?=
 =?us-ascii?Q?B32VoGhL2tBIyqS+5j3xJbTO5K+OzJYRP+eWNfs+1rjxIdfcNHdnfF8ROzX+?=
 =?us-ascii?Q?dwl1QfEOuvt3uM0/gUNl6K2wl/lf/OG5Iu7wgt0QpnR98XOd7H4LJP7pN3nd?=
 =?us-ascii?Q?G8UwS0DcrqqzppC4hYBq3PpOL4HldY9y37l8SHYcxcOljoZfTY3eTMbrsn+U?=
 =?us-ascii?Q?hBSWDcUOaQaHkqbHHdZF+eaAziGUrNIAReLKrCqCP4CUtp8sEa2pUSsTSsZW?=
 =?us-ascii?Q?IA6f5Zm9CUXPenjUG7TZqMS/P+XepSlr/mzkvVhmuPOTmasbQffqgLVhAKhs?=
 =?us-ascii?Q?UMwq7bMmRbY4uXDY7MoZFVEG1oq9snoPyCF1tJnvirXE2rRJOeO3WDYKN6KW?=
 =?us-ascii?Q?4ZdUlSRNoBpnbaKXz7Kv36I0TwoaC/WEZpygTKvv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37476913-68ed-4323-7bf5-08dcf4bc9918
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 06:16:44.2246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AAz4Q5KmF451ML67E5K2VaZ1qeTaP9wEBhHTEspuS1shDq8+0N8yWz1Hxm+JHRkhBdAEs5Xt94nJzVpbOkCIFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6219

On Thu, Oct 24, 2024 at 09:15:58AM -1000, Tejun Heo wrote:
...
> > @@ -3156,7 +3210,8 @@ static inline const struct cpumask *llc_domain(struct task_struct *p, s32 cpu)
> >  static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
> >                             u64 wake_flags, bool *found)
> >  {
> > -     const struct cpumask *llc_cpus = llc_domain(p, prev_cpu);
> > +     const struct cpumask *llc_cpus = scx_domain(p, prev_cpu, SCX_DOM_LLC);
> > +     const struct cpumask *numa_cpus = scx_domain(p, prev_cpu, SCX_DOM_NUMA);
> 
> This feels like a lot of code which can just be:
> 
>         const struct cpumask *llc_cpus = NULL, *numa_cpus = NULL;
> 
> #ifdef CONFIG_SCHED_MC
>         llc_cpus = rcu_dereference(per_cpu(sd_llc, cpu));
>         numa_cpus = rcu_dereference(per_cpu(sd_numa, cpu));
> #endif
> 

Yeah, I can definitely simplify this part and get rid of some
boilerplate.

> >       s32 cpu;
> >
> >       *found = false;
> > @@ -3226,6 +3281,15 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
> >                               goto cpu_found;
> >               }
> >
> > +             /*
> > +              * Search for any fully idle core in the same NUMA node.
> > +              */
> > +             if (numa_cpus) {
> > +                     cpu = scx_pick_idle_cpu(numa_cpus, SCX_PICK_IDLE_CORE);
> > +                     if (cpu >= 0)
> > +                             goto cpu_found;
> > +             }
> 
> I'm not convinced about the argument that always doing extra pick is
> beneficial. Sure, the overhead is minimal but isn't it also trivial to avoid
> by just testing llc_cpus == numa_cpus (they resolve to the same cpumasks on
> non-NUMA machines, right)? Taking a step further, the topology information
> is really static and can be determined during boot. Wouldn't it make more
> sense to just skip the unnecessary steps depending on topology? I'm not sure
> the difference would be measurable but if you care we can make them
> static_keys too.

Right, on non-NUMA machines llc_cpus and numa_cpus both resolve to the
same CPUs. Also, on systems with a single shared LLC, llc_cpus and
numa_cpus resolve to all CPUs, so in this case we can skip both steps.

Maybe using static_keys is the best, in this way we're sure that we
won't add any overhead in non-NUMA / single-LLC systems compared to the
previous scx_select_cpu_dfl() implementation.

I'll do some tests and send a v2.

Thanks for looking at this!
-Andrea

