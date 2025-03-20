Return-Path: <linux-kernel+bounces-569949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF23A6A9FF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 16:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD1661798DB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB42A1E5B79;
	Thu, 20 Mar 2025 15:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kXJYkkZE"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577A335970
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 15:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742484846; cv=fail; b=S7lodKN/ImgjT7gdUpaoPQZPAcNaaRMAcjb7gqtgtsPumgZM22xJGMyxCltoLMc8twPBRG06x3M3uR0yqcCP0EKySMHba8gQnyvcLeXVbxx0jrtClJZbMPWZKUQxOSybleNHZhrQ7k0NaRTo4uScfVbf7dHrbdZq+UuV7mSURFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742484846; c=relaxed/simple;
	bh=cJKirPO5IRqadz+0nc4HIoCmPHJmVRcuUOYWcSXFydk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Mt4OCOyIcJQac/KzngE2akS8O8B9q/zXRMWpLNr7UeK077Abba61xf2hmqeyus34X97TitElpjxKjYOpimzWx5+zD741avrg4JpQlJu0qPwtKtfYrpqthKDLh+gVWS6/uBUTJRYKKOH7OPpNLnnrSiDzyp6Z+waWcWIwTAzXkxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kXJYkkZE; arc=fail smtp.client-ip=40.107.223.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BZ6GWvQhFOpNpYzTsrRGd3rO+qeMyuNAIELj6ZvwHnPyTjCYa4U+0LjUEdSnZCm5fL8UQBYnBpamuuEQXUhk78IFIA/F7xeW/z19FmsJeMJSJfknr87Up3th2qpzGEw03BHg0YWq5Vlx+winF0rFeQNDZejnHoU28TTQtm/sqSAf+orUHfVW10cPl41JZPpTTMJsn+2hjyhgBklMTZTm2VtWcPTxCGPoyjJ2P4tPqbEtCX6kvEJqDMrY4VeUvuL99NdgS0Liu8rwXw/c82jgFLk2fJx6h4TROtwlw0g3WlBpjOtbCBnsUPQQowyFNIbSrpWIFx/G1OnxkVxPDNwmdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HtLfzvUZdWo+f03jrOQZuJDR5/ll+3RuTQg1QAS3EDM=;
 b=Iqkh4t70b4yUGKuhZzmTSdevFBWzCaQF/REhW5OHu62c1ZaxvVywUrv1xwG+WkkpGvF7BLHd7ccH5Xi81/bPd+HmisPijhUjsm2Ryfj33GVBC9+pSWJZV5NHXAYM/W2ndswDM49qOSwUYKHpFIfb/slXRvBlx708+damIFKNjNSgiC4lbIAIkLXwU6b3dxBQz6EW4LnP4eDvnROyMcfeSCmI/eGUG188WeukKljuFyig0WzWdoDTZ7Kh3OTMtYGE1qGCuUmG+NbaBTv/AOWRnXbI82EuWqwc8dqu4ez5sbFJzCVUin+Gk7dBKQbJzgmR8Hfewdsc2PaE0sq9iVqHfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HtLfzvUZdWo+f03jrOQZuJDR5/ll+3RuTQg1QAS3EDM=;
 b=kXJYkkZEI/SaLcyD8J8AT6is9q5mDNLHJqE06t7pErnomC16HqfkgpWlRsEFJ+QUVk+wzvqzb5dKCjgJLDPhSmFFXT95rsL/OBk+OX9kPhctgUm8Mn5jdhdBbyqnL7EkpfiEGTq8iL4vL6gH/6fJPFEQOHJNKbZdEqTd3I5/1PIQofEkaWfFmA3ybxWnhAX3QNqcXST62a6DhFrn6KBEboEGCusuf7EYzLeeml6mC45UprbmmhUxyz/omrY061zwCJkuzWQFIUj/7J6LTQv9MDCRJcB5bBZYCLJNUCxE/4GxIs1syPe+SN1Ei0PkCqtY9L/uqQJokyTjKvX4x2BwLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by CH2PR12MB4088.namprd12.prod.outlook.com (2603:10b6:610:a5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Thu, 20 Mar
 2025 15:34:02 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 15:34:02 +0000
Date: Thu, 20 Mar 2025 16:33:51 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET v5 sched_ext/for-6.15] sched_ext: Enhance built-in
 idle selection with allowed CPUs
Message-ID: <Z9w1X_GDIYV1CmIs@gpd3>
References: <20250320073927.216147-1-arighi@nvidia.com>
 <778d935f-ef77-4bac-aeff-1bafa91b825e@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <778d935f-ef77-4bac-aeff-1bafa91b825e@nvidia.com>
X-ClientProxiedBy: FR0P281CA0257.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::20) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|CH2PR12MB4088:EE_
X-MS-Office365-Filtering-Correlation-Id: 78c8dbf3-3be9-4e35-4f33-08dd67c4a422
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yISEfXul0w7Ng4aB/vSZasNGBRgQ05RuMGBVqmtU45YEU/PR8uCGQn39N4LO?=
 =?us-ascii?Q?C+F8BZjLwUhvJx9EztkL5p8N2LMP9t1bCBKBwG/WHXpwMgalpXEIECL1hz+h?=
 =?us-ascii?Q?1ncp5McL2CJMYpg7ZNdqpCWnWoiKDK2zSAl13QdSosbZTE/JsuWAh7hpZPQy?=
 =?us-ascii?Q?5fxCtj/rFE1aWb/h4c72zro2ybTUJiiRohzPBYQgmXmmyvkfibE7aLAr5LNP?=
 =?us-ascii?Q?vFGzSuID6Pwmkw4iErzyFbyhAteK5Pkmx/qm8TTPLZAYMY8V+wR/cJO4ADxU?=
 =?us-ascii?Q?Ed+qhffh4BV9Eyz+uxN1Qtsy3MqaHah+TJ/yywmCIPTEBDLe73eN4sQ5daAL?=
 =?us-ascii?Q?7xaZ3zW9eQcowQqKVj11Qa0VVuyoAhazgorjBSjxXY9QaEMhW3vB5ATZj27s?=
 =?us-ascii?Q?oSheHOV4nuxsZebXbzBzaA86Z2DKtMpwC34Y32QUx7EDWI7xhWQ/xqKyZBt0?=
 =?us-ascii?Q?La6I+4vMN5RwX4wveDjuVZObPaJMcPNTtwiraY4nU6cWFtjsV3RkenTXiUNu?=
 =?us-ascii?Q?cMIHWGHZbFKgwpA6ezD1ejMlTtsZequjBZcSuUSdI0wIMlMb7XOwZWml+6nf?=
 =?us-ascii?Q?oXx5Rvd2L5uDom0fjCEnLe6AnRC1zVRHu4esxcAOcrOPKnigJetogougc58e?=
 =?us-ascii?Q?1xYhnsC2ne55nBdkTDu3yZG59Nt7/HH0924SoksLN8WVaqSt8fel408ub3aH?=
 =?us-ascii?Q?JvkbXX/JOBFfxeTPbq1D9qspCU6/WDkD1Ulw+tjdiru59l0AOk5lzfIM08vn?=
 =?us-ascii?Q?VRM7H/wwAWPbakcXakX7NTGzzKl0qx9s39DhOjXikM9QmKmxroXuCBe5JVuL?=
 =?us-ascii?Q?rbNvWvcwY/I9+CdD9KMh5bqg44/jmututDzLb3ICKgVMaCO1eOyzU8NxN/ho?=
 =?us-ascii?Q?8klAw8wRmaQ1KH5Xte5NYl42XMB3q1jWPnE49NISej71J/E/o2PkeOI6iVL0?=
 =?us-ascii?Q?tlaXAOKGLx/AYESQkHmlr+uuIiGEpTc3rOaV8fg6I4Hq7rugilQHM7FxmP9b?=
 =?us-ascii?Q?T3yxtR5pCBY+LIu6C7ah92RROTVLzBVJ9ZpAvTHUqJmOHt8teiSsK+UPiPVm?=
 =?us-ascii?Q?tFXcSIAppZVp3QnfpPoq1SjYs8jncMGtt7POHyc4G3RDVLri9sFCD8JgNtNt?=
 =?us-ascii?Q?b+Er4RqntUho05GLUvLOHZigyDGPpl8z000HTKyH5ztT/s5YDqwYbTOGItEP?=
 =?us-ascii?Q?Uvi4o+TQCH1T/HttFSOz8/mucndHW4wK0pjbmd0RPdXoGxMXKM3m+UKr6S5t?=
 =?us-ascii?Q?oGcrfmbxsCfexHBKmN/IM6b8RRHFLfLrK9ccOLJuz8QmBu27xGRYU0CijfQO?=
 =?us-ascii?Q?nuHoxAFKnYzJ3VYS1T2Ig/4X5Qa/kDwYB/x9kWPQj9ml1PV5IcpXYvRjutXv?=
 =?us-ascii?Q?Dg3FDxiaTFY2O901yZMf12AhlfU3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8QoUc8MLBNKLdPkhVW8AGq79vbZ35C7SLSr3h+sDITrQ66PxmjS9yEKFJnMq?=
 =?us-ascii?Q?TJIj+70gXNTZX7xliL/1TJhrPm4v+x2hYVpWos8FnUAkXqQ+IF3kXGUpCs9M?=
 =?us-ascii?Q?rDLqXmse7y8+n3rOcg2Y6KIX8Gzn/s/GUDMyESCa2Ar2ixn06wqSagy45VSA?=
 =?us-ascii?Q?sX6uo36bWv/KtBt/NORds5E6dT7/o4+6ImVqF4A1PbA9918oHIffal4MFDek?=
 =?us-ascii?Q?pa8DmMr8q1tes59E12vFqN1R6vQ5Ul+sR0khhaNlTgJLfGKK0eOikJ3hdBzq?=
 =?us-ascii?Q?npdyI77sKuxVpRoPO2prxLk4C0PljtmZ8kfAUUFLmEfftp6PRTC/Ji9OpzP3?=
 =?us-ascii?Q?xjzqba3DTsk3ciQI9BN1RXWcMr6X/x+aDPEApIfP76nuNFVjlyE6ftPwVsNJ?=
 =?us-ascii?Q?JgyutXCG9A8LP+OZk00e+KTYQtwGSDgQABH5/ZAQQnKM46gsz6pHallYJ/D2?=
 =?us-ascii?Q?hcgsg8s3bg6T1a1oMj0UPCLCpayecyYv/WG+RHPPQrvdW58Wk9UbpwyCieSW?=
 =?us-ascii?Q?mYVYm66fnTR4t7vvBdVYt/gS47QIJmUs8BXMJDxjFDFQSpethB2ipMUQBWaw?=
 =?us-ascii?Q?RDoXARrRA1L4LbcrfKsHPQAdwvYmLmTat2amagBMa1Mn74Id4d+/1bqy7ZkV?=
 =?us-ascii?Q?HBbfL5eX/Y1fonNxzgObW+CJ5kendvBjCw4c5B/f05PcXWVr6R4XpZ4JGqKX?=
 =?us-ascii?Q?kcIJi6iY7R81BvAlGE4vbbxH8lOE1GbYTNopOJIBr8V6NW5iRE9MLmTk2AQe?=
 =?us-ascii?Q?5yRZ3FOmySR2qz/n24Zn9tG6tvUKbfhL1kp/9h+knDALtvcD77gItTmGI16v?=
 =?us-ascii?Q?RGnYxBoHj96sBL6Ymchj3aeC2D4ZPSvajfUleHgHHvge9oUhfKIULh+5uPKf?=
 =?us-ascii?Q?DLE8k9E5RP/QHGOeatMuDps87Hd8xgy3KMLeN47svQli2+tosrNtF3OBQEat?=
 =?us-ascii?Q?e/qkEFBeVohdEqmsuxm1ntS4S4/iaerUhELYyOPPoLJx6twLq2/2syaBmrZa?=
 =?us-ascii?Q?H8OdYf+uJDtMor5Oqwh80nHi+qvHZ10X/5KTIDVdrK5kpcjwmpuyHq5hOXDd?=
 =?us-ascii?Q?JrK7OzqyUby2z7SMA8s0P1EP7YN3lnU/PrQLj6MMzd/mNHDK+79ljtJPQgXu?=
 =?us-ascii?Q?CnubkczQ0GkH990LxJlAyojQT0MjD5zjcckj2XGLyJ63dToD4V7pnu3I9ob0?=
 =?us-ascii?Q?3VLyUq4o9/U2gbr/XYLl4bt6x5vwcEl0JLHnKZAgVvU1gOzF+wN3dpV1IDDt?=
 =?us-ascii?Q?YOuj+HjxsuCc8mECF5rxsGe9ttJn7ZI8fKdZ2rVkGyrYfdonPp1hZTchqnBa?=
 =?us-ascii?Q?ybkGA4K/jfr28m8fiik9pJm12gFw0HefWlI9zmoqBNfLUQme3lKodvPVVWZy?=
 =?us-ascii?Q?EHRoFUDkuxsk01qE6pHgpIaOLhBFo/CBZ6XjAE5JvGp4ML9rx/jxpoOz2CRh?=
 =?us-ascii?Q?K2AnjlAPj0vsdSRMXa0jPXAo9L1YVZ13j66rgPwX5RE8Zfb1QsMv77736d6L?=
 =?us-ascii?Q?EY1n/mPZXiClfycT0IWxBqxtGelsJ7jN2fMLkrUGnqiAdAZ0pvjsEVJIVWFV?=
 =?us-ascii?Q?hjrzBcqhflv1jvTML1ZgpWiPeW18o0sZfvNCYlqm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78c8dbf3-3be9-4e35-4f33-08dd67c4a422
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 15:34:02.2728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ye4UMYrAIoFnX0IaGkQtutObJUTtOKCIr9HH8T6LgEWv18qTNOmeTTxAgsggSUKvg0Hdv4epIW6x2zts9iIGaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4088

On Thu, Mar 20, 2025 at 03:05:37PM +0100, Joel Fernandes wrote:
> On 3/20/2025 8:36 AM, Andrea Righi wrote:
...
> > Example usage
> > =============
> > 
> > s32 BPF_STRUCT_OPS(foo_select_cpu, struct task_struct *p,
> > 		   s32 prev_cpu, u64 wake_flags)
> > {
> > 	const struct cpumask *cpus = task_allowed_cpus(p) ?: p->cpus_ptr;
> > 	s32 cpu;
> 
> Andrea, I'm curious why cannot this expression simply be moved into the default
> select implementation? And then for those that need a more custom mask, we can
> do the scx_bpf_select_cpu_and() as a second step.

Yeah, maybe the example could be improved a bit. Basically I'm doing
task_allowed_cpus(p) ?: p->cpus_ptr to highlight that you can't pass NULL
as the extra "and" cpumask (otherwise the verifier won't be happy).

Also, if you call the old scx_bpf_select_cpu_dfl(), the internal logic
already uses the same backend as scx_bpf_select_cpu_and() passing
p->cpus_ptr as @cpus_allowed.

> 
> Also I think I am missing, what is the motivation in the existing code to not do
> LLC/NUMA-only scans if the task is restrained? Thanks for clarifying.

You can use the "flags" argument to restrict the selection to the current
node, setting SCX_PICK_IDLE_IN_NODE.

We currently don't have a SCX_PICK_IDLE_IN_LLC flag (it'd be nice to
introduce it), so currently the only way to restrict the selection to the
current LLC is to use the additional "and" cpumask (@cpus_allowed), passing
the LLC span.

Thanks,
-Andrea

> 
> thanks,
> 
>  - Joel
> 
> 
> 
> > 
> > 	cpu = scx_bpf_select_cpu_and(p, prev_cpu, wake_flags, cpus, 0);
> > 	if (cpu >= 0) {
> > 		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, 0);
> > 		return cpu;
> > 	}
> > 
> > 	return prev_cpu;
> > }
> > 
> > Results
> > =======
> > 
> > Load distribution on a 4 sockets / 4 cores per socket system, simulated
> > using virtme-ng, running a modified version of scx_bpfland that uses the
> > new helper scx_bpf_select_cpu_and() and 0xff00 as allowed domain:
> > 
> >      $ vng --cpu 16,sockets=4,cores=4,threads=1
> >      ...
> >      $ stress-ng -c 16
> >      ...
> >      $ htop
> >      ...
> >        0[                         0.0%]   8[||||||||||||||||||||||||100.0%]
> >        1[                         0.0%]   9[||||||||||||||||||||||||100.0%]
> >        2[                         0.0%]  10[||||||||||||||||||||||||100.0%]
> >        3[                         0.0%]  11[||||||||||||||||||||||||100.0%]
> >        4[                         0.0%]  12[||||||||||||||||||||||||100.0%]
> >        5[                         0.0%]  13[||||||||||||||||||||||||100.0%]
> >        6[                         0.0%]  14[||||||||||||||||||||||||100.0%]
> >        7[                         0.0%]  15[||||||||||||||||||||||||100.0%]
> > 
> > With scx_bpf_select_cpu_dfl() tasks would be distributed evenly across all
> > the available CPUs.
> > 
> > ChangeLog v4 -> v5:
> >  - simplify the code to compute (and) task's temporary cpumasks
> > 
> > ChangeLog v3 -> v4:
> >  - keep p->nr_cpus_allowed optimizations (skip cpumask operations when the
> >    task can run on all CPUs)
> >  - allow to call scx_bpf_select_cpu_and() also from ops.enqueue() and
> >    modify the kselftest to cover this case as well
> >  - rebase to the latest sched_ext/for-6.15
> > 
> > ChangeLog v2 -> v3:
> >  - incrementally refactor scx_select_cpu_dfl() to accept idle flags and an
> >    arbitrary allowed cpumask
> >  - build scx_bpf_select_cpu_and() on top of the existing logic
> >  - re-arrange scx_select_cpu_dfl() prototype, aligning the first three
> >    arguments with select_task_rq()
> >  - do not use "domain" for the allowed cpumask to avoid potential ambiguity
> >    with sched_domain
> > 
> > ChangeLog v1 -> v2:
> >   - rename scx_bpf_select_cpu_pref() to scx_bpf_select_cpu_and() and always
> >     select idle CPUs strictly within the allowed domain
> >   - rename preferred CPUs -> allowed CPU
> >   - drop %SCX_PICK_IDLE_IN_PREF (not required anymore)
> >   - deprecate scx_bpf_select_cpu_dfl() in favor of scx_bpf_select_cpu_and()
> >     and provide all the required backward compatibility boilerplate
> > 
> > Andrea Righi (6):
> >       sched_ext: idle: Extend topology optimizations to all tasks
> >       sched_ext: idle: Explicitly pass allowed cpumask to scx_select_cpu_dfl()
> >       sched_ext: idle: Accept an arbitrary cpumask in scx_select_cpu_dfl()
> >       sched_ext: idle: Introduce scx_bpf_select_cpu_and()
> >       selftests/sched_ext: Add test for scx_bpf_select_cpu_and()
> >       sched_ext: idle: Deprecate scx_bpf_select_cpu_dfl()
> > 
> >  Documentation/scheduler/sched-ext.rst              |  11 +-
> >  kernel/sched/ext.c                                 |   6 +-
> >  kernel/sched/ext_idle.c                            | 196 ++++++++++++++++-----
> >  kernel/sched/ext_idle.h                            |   3 +-
> >  tools/sched_ext/include/scx/common.bpf.h           |   5 +-
> >  tools/sched_ext/include/scx/compat.bpf.h           |  37 ++++
> >  tools/sched_ext/scx_flatcg.bpf.c                   |  12 +-
> >  tools/sched_ext/scx_simple.bpf.c                   |   9 +-
> >  tools/testing/selftests/sched_ext/Makefile         |   1 +
> >  .../testing/selftests/sched_ext/allowed_cpus.bpf.c | 121 +++++++++++++
> >  tools/testing/selftests/sched_ext/allowed_cpus.c   |  57 ++++++
> >  .../selftests/sched_ext/enq_select_cpu_fails.bpf.c |  12 +-
> >  .../selftests/sched_ext/enq_select_cpu_fails.c     |   2 +-
> >  tools/testing/selftests/sched_ext/exit.bpf.c       |   6 +-
> >  .../sched_ext/select_cpu_dfl_nodispatch.bpf.c      |  13 +-
> >  .../sched_ext/select_cpu_dfl_nodispatch.c          |   2 +-
> >  16 files changed, 404 insertions(+), 89 deletions(-)
> >  create mode 100644 tools/testing/selftests/sched_ext/allowed_cpus.bpf.c
> >  create mode 100644 tools/testing/selftests/sched_ext/allowed_cpus.c
> 

