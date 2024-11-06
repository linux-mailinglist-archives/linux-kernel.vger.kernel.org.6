Return-Path: <linux-kernel+bounces-397353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1EF9BDAE6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 02:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC6551C218E4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 01:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE5B15F3F9;
	Wed,  6 Nov 2024 01:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="senhowbA"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2047.outbound.protection.outlook.com [40.107.212.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3151B815
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 01:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730855290; cv=fail; b=sCH5iiN7aZLbZVzNUO1G5CxNcdRwr7Tg8I3ZVyhjNFtK7JVHhHKR/Msc+b2WryIxxCPICbU7xnUGzogA9n7NcE0rkGNhSZqnHKuP7GsYvUHkvLmDRmfl/uz9upLz/70nVbCLJ5rI2BJibP1oQMoHGn1sxZ1RGyoraELsremZXuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730855290; c=relaxed/simple;
	bh=3NKE2nypTz4D6Tlu0EG8JLapapewohMu0C4WYtb39gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ovsgnylwo1rcAdlmNDgejwqjD6q3Hq+ksjNciR7ECOIYYyEB5CBWTMgnaD570FptEhCBnXTXRbNs48q8jLSrddrZx3TjRD78YwM7w0gYXziSlKLeLZ3kJw1k4p+64Bg7QaEuW01Ff19+ls7JXQifDUkr3gzmdvBhiQFr9Q6WOn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=senhowbA; arc=fail smtp.client-ip=40.107.212.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u6eMF7td/oT+z7qQE8i0mB8JFtPuvPgLPi6yEPLVdLZ14UMyO9b3kLmb0JhyCRme2ML4dNRKEWE0LQMLpq/LLf5K6V4X5XKskL6t2/HWu++o5Bgbjwq5O3vIZPwm2Ry12qDy2K4KSKGTLOvwlaEJro3IZbKI3GgVI2dO9tJ2vaAEJDk8QMaDFP5yRKLD8E0oA0LNWRiey6CMCz7hmxmsdH8F2scf5Yd1juXCES+xUasnj5tziXyjWmPo6085dVDbPCSwfqslJvL5oQgug8kTcJItLJaFN/4YH2yjAp0wh+mCd2BSXJRHWtMlT4+35XUF0Je13LeV4fTKfBjhYrOJsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ryigjuAHsI7YV3UB6LTLCvjaybZ8dqDvh/5/ieU+Rlc=;
 b=daddWZu4xUuGbvvxTNYzq2CzQQDerIJKtaPGDFr0QG/ngLK1NDYhqmAry9QL3kc0HS8Sb/4nTRMS02XGS0h45bqsYxlRAYmitqsRLFN+GG2aKq8S4ZxZdmaJ0/LLV2i8ItikCZ+hzlMSBMP/8i0nEurU9+1Y9swAX7I7PgwjILxAg0sVs6QWgfJ8YIawK+sNhzL5AT3m/w1rx1Jg7JHlw/pYMzdczJfeMKwzmNQSTT69zAye3qDpd94bokBbix4nqS2C79zeKt++96ZgbZg/LohwscVMfLbP0ki7N3fHD65uXSvBLZlaevNvLin0hOOUsZhZrue35Qzx1Se4wuY+RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryigjuAHsI7YV3UB6LTLCvjaybZ8dqDvh/5/ieU+Rlc=;
 b=senhowbA0ifJOUB/7shAZi4evKe78FxOtJEpURyzVJGT1lTNU+QDd/6hCkBsQgY1mh8IE/Ie+XIDpffwMBqnUzvvzGTnfI+qgvpCxffWYZkcsoOcZACuGmNlJsMEKKjrN+0TVdStbYJTqFiZVvpWZA/YGauJsyccb63esuqIAUQsie2RfXHIVfSmgqJCpuuS6NZo+63rgJrg1uBJd1r7H7mWjcT1b1ZZpybLsxOoeIbFp+VeTb1GaMJpP9UnWaz9UwU5Kl/gYcm7vStfaOX2gul3uERKlWJz+3pR0YmlFwWz4aZgnnIVSK3YAZDXmj+yIOowx/momK33r27UxEfG8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by PH8PR12MB7232.namprd12.prod.outlook.com (2603:10b6:510:224::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29; Wed, 6 Nov
 2024 01:08:05 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%5]) with mapi id 15.20.8114.028; Wed, 6 Nov 2024
 01:08:04 +0000
Date: Wed, 6 Nov 2024 02:08:00 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-6.13] sched_ext: Do not enable LLC/NUMA
 optimizations when domains overlap
Message-ID: <ZyrBcDvFVtSFPhvG@gpd3>
References: <20241031073401.13034-1-arighi@nvidia.com>
 <Zyqq9fnsOg56aO7S@slm.duckdns.org>
 <Zyq4VFpbaKXERdDh@gpd3>
 <Zyq5cX9fLE-3wZSx@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zyq5cX9fLE-3wZSx@slm.duckdns.org>
X-ClientProxiedBy: MI2P293CA0007.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::7) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|PH8PR12MB7232:EE_
X-MS-Office365-Filtering-Correlation-Id: 35c92e90-cdc6-4a5b-04f7-08dcfdff7796
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RT0h9TinAttnajm3srplCrD6iY5JzCatUboa+tGLLNUXddHp0VgCC77Crcs2?=
 =?us-ascii?Q?ZEvmhEEv0zlO+lM9MgcxDuVOn5UV7fmrDf36KgwHeXpNaXa2BBPC4v5WEbR3?=
 =?us-ascii?Q?dxxlFbHYL5M6rgIYZcsJ0Y+AzEIQlB2FHiFgtacVWPfOzsELPNX0/JU22JDn?=
 =?us-ascii?Q?oHoQVw6I93iu3xG6WJ/OkSAZ8HrTgdHnW/M4fXmK3/v2w3uwHWt30m9/KBq5?=
 =?us-ascii?Q?Po0oT81hW9e5vG3u4b3VsrPT/9W/uSiwGMd24SI3LuYXkys0RVrWZ8pXcyfw?=
 =?us-ascii?Q?PQc/U05T3CIhHhhYGS/T+eH4pVmKDlCXiLbcCcgOIa1jraKWEm9h5Lywjp4p?=
 =?us-ascii?Q?kU4fi2IjLDHPWdl5xfIxQrUjcpplEgfKvBtSJ2IheP4FYBT301rRTnG2iR7g?=
 =?us-ascii?Q?qi0/kfYScSc1x6X+ybM7plpA0FXe3M3eNffhO9LWwXbs8sx/vYTOumuVpLBJ?=
 =?us-ascii?Q?vRojLCF8FyIMY0aJ6xI9yPkq30I38U8a1iGMglrURHXLPmIrKrgLVvPglCfB?=
 =?us-ascii?Q?04vOJaL25cqmB45EuGB4MN+nRbhdbjgSTbmx4/u5ERQbkJa2avTP7d2dDB36?=
 =?us-ascii?Q?Ce170mcrPR8mW6vW+l8onFlMtZLc//PV0UN1FPXiMe7XQIpkwtnLwTeQETWY?=
 =?us-ascii?Q?fFHs9fEVsdr3TDUA0j85P5lALX7PxyGKY6RSs2IWJiecnGQo5XrNfP3UNZbj?=
 =?us-ascii?Q?jguHSea+QYND6NaojWgjm6cgozCROWPMhVdf3BAHXOH8ygaKoE2xVmRKUeVk?=
 =?us-ascii?Q?8kQM6leH2O9+5W3tJNrvzKHtRvOLWIuoIUlRBSisfWlRGgl9VXxFiO1SC02X?=
 =?us-ascii?Q?vSeLIxj7sA8jwujG7ANNAzI4mr5oZdfjQgOV5guGbyVapXoMUAGX8N7wMRgB?=
 =?us-ascii?Q?T0nZdaSThPJHmKdaNMtIvWyB0fagHpVxP1PXapSj7vwXurP+1Eh/9HomDXQM?=
 =?us-ascii?Q?oEbqiq58CQuFu5/sGlRQtE/g5iIMbZuXI7fpvXq2DvnmZ85DsASuZB2KEY3C?=
 =?us-ascii?Q?/JoYnfs62rbQTCj/j8piwMa15ARhBovqgUwqCdHzNJ2Cts6zIFZ6IgJXjAzK?=
 =?us-ascii?Q?TZoKehgoTKVOf9K85wLzZyN2FNjPoZYHPqpp79FvW+biFl7oLoGfTXvQwwAF?=
 =?us-ascii?Q?M69Vs65BhG1zkPJ67aOBLxnPD+Dridc8Afy7w94/f9ywr2NYoR+NJ512ueY2?=
 =?us-ascii?Q?6gWokBmyqGdmzMOOrX5g71XRnyiB3dtMt0G8X+glcAoph7aed1AIV+dNoA3w?=
 =?us-ascii?Q?O5LYRJOJyOw+a9+enPPJtvZatUOHdXSje6Wg09GH5WM9ooETVrxdgh5mzTgy?=
 =?us-ascii?Q?g0G65TAYdBPxK4NXToCdgJxZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JfE25luIGXtT7V0UoAveE+MD8FtdGCgJRWszVKwAF2Ww/64LTFlsZUBVStd8?=
 =?us-ascii?Q?zQVmydoPVDEhqFZVDkQlmO5KfDIQJxREopL2gAnEp/ORtgytXKQhjMr0eooa?=
 =?us-ascii?Q?d5prPVSyQhPL00utybRZeQPvKDcAgbRtYGhJJHYQSeEiA+Sdl7Hd8hUsTg+U?=
 =?us-ascii?Q?eHLWM89vUpJeoAfEVg83HtIhIWNTdWgs0x85UlswFDGRWAbqxGEAENNF9UzL?=
 =?us-ascii?Q?v1Pj1vYClmwk7/OzyaQDlZSAn0KEOUKMdgGH5n/7oEeRwoy4cg6xzmGuv+N6?=
 =?us-ascii?Q?YkN+a8BFB7bOOzJ63uP3yjWZzWG5w7G7HLg1iFaDYN10auxso1nl4ymWyABl?=
 =?us-ascii?Q?ooUeoguGc6JYOEFk/I5yYbrjHtAQ81IhnbBX07Fcn4oNHob20+Mz0BGgcHou?=
 =?us-ascii?Q?j46VY6CM892FPnl/aoGypwaAugqbNNFGABuWj8/JY+2snw57SOcZvpKfRQjk?=
 =?us-ascii?Q?p+8qfnIXUwkQiSEpUBOE5Nao819BCbIouTQ0nKKVah/NOQiJBsrfdrwJeQnY?=
 =?us-ascii?Q?H+Xu5RqxioUe0698EuEwAttJKDqmbkrHmdeTTnHIvMwvCcXJdpbT5cmXk78I?=
 =?us-ascii?Q?debC2t34m0NY82ROkISxlDyXdusGvw5L4Wwkdrb41sbg9pQdjXJQxA75oQBk?=
 =?us-ascii?Q?fZ9iJAg6DtCHI8ifqL8dU9RHUaVPlSx5ck0DOoM1byicSbisIww2F9CL4OEc?=
 =?us-ascii?Q?udunvHDrKBlMJx0BMF0r6kkww7fvDhHLjE3cYJlpSVGBfZzWWcgWMk9R/RbX?=
 =?us-ascii?Q?MVc/Gi0i7U8hmVJ5V/hWsuTa7E6s8QQiZalWP9j24Sne1hih8+By7x+4VR95?=
 =?us-ascii?Q?RlWFA4+/G9vEVZ1lCyJjzTsReW4DvaxH/2EIsV1unk1rDjnIYqy3kz4CHOx7?=
 =?us-ascii?Q?SpRL9Mluh3X10tzwaKtxtGBbuj22eqgz3T+7KCv1dwu1X6BtHa3ZzgfX43yj?=
 =?us-ascii?Q?gdR1d1u7rPkRSzRtlj4jlyft8lrnnjG+61IcZHcPLfUETXVUgZBiYJz5cY0H?=
 =?us-ascii?Q?7hjltXAeh0SSpEaW+Q4Nzi7MZMgIg64i2WdCWaenMH8rpEyRC0VUROBQ0Y/l?=
 =?us-ascii?Q?PCuhHAZLPvwMsm9mMho2Iekw+CcMCz/Yktd8yDS0g0oAC0pRoBxe6XCYCCmO?=
 =?us-ascii?Q?rAQwFRggAd1bffIiWgY4gia6gK90+AQS1RH+hXMkNEudSrioRw3JXJB5LpoO?=
 =?us-ascii?Q?K/SmfPFZOEqBUHpbYUhFCyW1ON39qmZTwPQm2xJufYLcyyZbbuA9M4t5DeeF?=
 =?us-ascii?Q?MssKlHdr/lXTzSRr6zG/tn4k0ep4MQOBa06rrJ0jy3Z7djzTjAzKeCMg/0IL?=
 =?us-ascii?Q?C24vvCcXXoCNkrJZp/h/6ytLPvyECFJcwGSAxOYqc4TjWK5Cnwd1m5fZfTW5?=
 =?us-ascii?Q?M8X0pAEWGESMNRuDJwEuOsMa6nGMCD4WRZkR3CrSVdBdiS2sw1scUNKndH7x?=
 =?us-ascii?Q?opMvIdgyIufkJlq4bAtpioLavHydStiFm8SHhW0Lqg0K2gaSXy6sZjs3Pnts?=
 =?us-ascii?Q?FhB1Mv6qYanMVruzwdZ+Ry6oBvi+sa+mXF7sDMkumzCsWeJVH5UBKkj6ZeS6?=
 =?us-ascii?Q?68ytcKjAFFClhRXATEToxhS1Z8PAUm0hMWCQFiH+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35c92e90-cdc6-4a5b-04f7-08dcfdff7796
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 01:08:04.6936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RfEAeDiVNXwz2oW8jlMLT32V7EJjPt9hAFHojhPmIjBpzeBSyCQSWgeLhI/fc2kUA6r2mnVoeDfnBOVmron2gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7232

On Tue, Nov 05, 2024 at 02:33:53PM -1000, Tejun Heo wrote:
> Hello,
> 
> On Wed, Nov 06, 2024 at 01:29:08AM +0100, Andrea Righi wrote:
> ...
> > Let's say we have 2 NUMA nodes, each with 2 sockets, and each socket
> > has its own L3 cache. In this case, numa_cpus will be larger than
> > llc_cpus, and enabling both NUMA and LLC optimizations would be
> > beneficial.
> >
> > On the other hand, if each NUMA node contains only 1 socket, numa_cpus
> > and llc_cpus will overlap completely, making it unnecessary to enable
> > both NUMA and LLC optimizations, so we can have just the LLC in this
> > case.
> >
> > Would something like this help clarifying the first test?
> 
> I was more thinking about the theoretical case where one socket has one LLC
> while a different socket has multiple LLCs. I don't think there are any
> systems which are actually like that but there's nothing in the code which
> prevents that (unlike a single CPU belonging to multiple domains), so it'd
> probably be worthwhile to explain why the abbreviated test is enough.

In theory a CPU can only belong to a single domain (otherwise other
stuff in topology.c are broken as well), but potentially we could have
something like:

 NUMA 1
  - CPU 1 (L3)
 NUMA 2
  - CPU 2 (L3)
  - CPU 3 (L3)

If we inspect CPU 1 only we may incorrectly assume that numa_cpus ==
llc_cpus. To handle this properly we may have to inspect
all the CPUs, instead of just the first one.

Moreover, with qemu we can also simulate ugly topologies like 2 NUMA
nodes and 1 L3 cache that covers the 2 NUMA nodes:

arighi@gpd3~/s/linux (master)> vng --cpu 4 -m 4G --numa 2G,cpus=0-1 --numa 2G,cpus=2-3
...
arighi@virtme-ng~/s/linux (master)> lscpu -e
CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE
  0    0      0    0 0:0:0:0          yes
  1    0      0    1 1:1:1:0          yes
  2    1      0    2 2:2:2:0          yes
  3    1      0    3 3:3:3:0          yes
arighi@virtme-ng~/s/linux (master)> numactl -H
available: 2 nodes (0-1)
node 0 cpus: 0 1
node 0 size: 2014 MB
node 0 free: 1931 MB
node 1 cpus: 2 3
node 1 size: 1896 MB
node 1 free: 1847 MB
node distances:
node     0    1
   0:   10   20
   1:   20   10

I think this is only possible in a virtualized environment, in this case
LLC should be disabled and NUMA enabled. Maybe it's worth checking also
for the case where LLC > NUMA...

-Andrea

