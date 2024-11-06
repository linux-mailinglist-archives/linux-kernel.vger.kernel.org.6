Return-Path: <linux-kernel+bounces-397308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E2D9BDA4D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 01:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74ABA1C223DE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 00:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5FE1DFFD;
	Wed,  6 Nov 2024 00:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TdVxYAKe"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D69558BB
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 00:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730852959; cv=fail; b=RIRTtBnBe1muaOjtvALb1KYADh0pnkztYD10rXKOfMJT4xphfvYO4QbvdAERRgloeEqCDOuovIRk7AHbj3sv5yXXX7VHfMNWIpIyyh0vZ6RpWzSZAiQDXNAIw0AuTUROh5iRzfuYhUlWEs8RA92FsYJjpFdanvc7bQjsmD4hwCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730852959; c=relaxed/simple;
	bh=+Iyt40Mq1SceyiRJ5IP+89uvNdhzQIMyoVZ+52qZmHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CqqfQzesnED+6L9iNGiwLzEAGrEeHJs/vhFRpcTM2XaBbkFBGG9Ip9NlcXhFHmCNvDtfsVGtEkimiEXk+GkxkbXc2lRrvCk/9FkpwOZKCInrmDiJHSFubfWm6muphhCwmEilhkdqqlYy9IMeTwBfCLD9aw/aU0xdoy5qAfllBnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TdVxYAKe; arc=fail smtp.client-ip=40.107.237.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nCe1WZpUsdrO2XxUpF/DrBLDeZxw2UxKNmN5spf/5Oisye3me9BFyzLbRpr5o/+hEohJmzJrhKZCyVtJGFjqDix7GPgyimCMAMLt83ge7jD8wNY9MAUT1agg/+7qEhGJG3UOvj+pyc67/f5kQUneLROWT/khtOxVGoo91AsbkCRpDTY0ekf2DEG94blh9X4sXniKvR0LIvKc1DrBn6GQaTyj7kHuFEeg1zD3bp84qfgwWZb89dcn5BaMUksXdsq1oXvUe4f7+Gt5zIuHzNkKhqvGT9zPhZB4TIahipg+C28h8H9bPt9GBnjeKaLfm4DTL6NNntY2BT8u6IgTzO20Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nN8tX7Bhr4jFzLU5gutdk7CepnInDP1NuN3ylMNl6B8=;
 b=ARg3isbl+81FQLzCRLazThfChXEntE0jcDvKfPC8jts1Objd177Cxotf/9SlgrnLH7UZl130iWdOUUYXsE5ZCtfwtPO6I8CVSZTsDmZjl6ZMsGuEOgzvO/div4P2lQkbPg2DSKQGXBBWRClvxz+HtOCyAeP80WEFIcesb2BfU/lsKzmFdvffy0zaGwHBpw+aNuHuVs6qp3oiUvo/Y9hJ24eVr1YwZBwRb+p5edQOHUNVO630WN86adU4145UdD57Z9iWjAM+xpE52jkr0GETeO158YuckHeFP3NiBNgnT7uK21swnlI0fm98Jxxe0/HyQ/j63iWyU89n4IRYSs+y5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nN8tX7Bhr4jFzLU5gutdk7CepnInDP1NuN3ylMNl6B8=;
 b=TdVxYAKejYIjhjKxWGXLnZ2gXUxfhxk+kCUcBjanppmKN/TTjy8sG23+243k8YCs8INR9lgFUZNVJk8xCgM0eBIYRzkPgNUFhhMimr7CNeyRzWnWv789oAuoD6J6SGylbXfDAkXqet7VztUcw17OsHnrd7wx/r2PZxU3IkOOsesVCDFWRQRTf/xrwbOnhYYrdnPX6QcKJe2k7a6zi9qqvwyHbvB4/er6PDiKzwStwjSn4Aa4XoDB6CkW5zNZZ/vtulXs8GGdQaleobg4r5Rk5XnE1jOozQed3Et9lxfc+aN04FpsvksHf+ICGzSXRO680D85VoD1wa87u45EtBbubA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by SA1PR12MB6703.namprd12.prod.outlook.com (2603:10b6:806:253::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Wed, 6 Nov
 2024 00:29:12 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%5]) with mapi id 15.20.8114.028; Wed, 6 Nov 2024
 00:29:12 +0000
Date: Wed, 6 Nov 2024 01:29:08 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-6.13] sched_ext: Do not enable LLC/NUMA
 optimizations when domains overlap
Message-ID: <Zyq4VFpbaKXERdDh@gpd3>
References: <20241031073401.13034-1-arighi@nvidia.com>
 <Zyqq9fnsOg56aO7S@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zyqq9fnsOg56aO7S@slm.duckdns.org>
X-ClientProxiedBy: FR4P281CA0243.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::11) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|SA1PR12MB6703:EE_
X-MS-Office365-Filtering-Correlation-Id: a1feadcc-4bad-4ce7-928f-08dcfdfa0999
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/yu0yfawqbdvXaY96J4jJZExVFuUdqqXrcwauf0w0uz2pLzJrRZyfcwBLliq?=
 =?us-ascii?Q?lSPE73wue6AK7tyReh4o1QpqXnV9CCDe0ogIg9wLKvDV7MnT15b5UR4m10Re?=
 =?us-ascii?Q?Wc9VCyiUpRWbRn31+r1gljihuwfzOqVBjFnMnkyR9UWYQhy8+ahJPyqeBzcn?=
 =?us-ascii?Q?5mVKDUXvSQyBjIuOXXbweJaoZfTRKPhZWYRiw9XlXQVDmkhQxSnfZmnvfVN9?=
 =?us-ascii?Q?/H/itzJ/D/AKvwD2VV0FyJDAlWXKHsp2Mhj7zBlxzufZpLZdWuUnGEOot7JN?=
 =?us-ascii?Q?C07g86EOE65m0n+3pG+3+Gl0lwiDyeDgcTggHxTvGu82SjGVOIJeAcT45hya?=
 =?us-ascii?Q?aktXhDxDWlWWsswUKu6M6PgvlJNfz35RT8WsMxgKJn8sS1rcp2syJ/3k+OO7?=
 =?us-ascii?Q?jML4Nb9o/zMrtbtzFcBZfKGw1RGhPdYBXUlIXN2Wu5eBfoUkyMkJ4kDMsVTN?=
 =?us-ascii?Q?E0TgSPqXW2LQldPT0eO/oPYfvfa9UqU3TU93RjEYi62lYdyWjOERhMWPNfrK?=
 =?us-ascii?Q?9U47gnHeFSv6jE5NlPS+op9xQNJ5lmiS7u6qCtHPdC0ODHrRoIwHR35Tm1Ed?=
 =?us-ascii?Q?aHXZ1IOUCHMqEdCEHQRUPDBlWQY3VV8qSryXhbufMppT1zqqTmYSiqcBURne?=
 =?us-ascii?Q?ycb516ouforEaYVCrzrRtBfjvgxOVAfcWeIrPavUQJpc9wbhl//DA9z+9lQZ?=
 =?us-ascii?Q?v3D4/N84pvTRs1cRGH5SxT+jjhJMIJDR5uqceHuWijyfDs7Zauoox7HQNLNe?=
 =?us-ascii?Q?dUAApk6QhSOLFoj6L2gKgEXwHVuykVRwAXyt+4Bd4Eg3MAWE0kFA3HjDyYPC?=
 =?us-ascii?Q?t6fD8ZMLkMx9LSbRo+bURzI36+3CaiqurGZASQdftJYk+fUEiTzBSHSdm85D?=
 =?us-ascii?Q?k0uVZwTQY4sPrC2YmlPponxCxpJjf9V+50yaVXw2nFnyeBRI97OHc9UdYmz0?=
 =?us-ascii?Q?X5fVQVeHJ9aZ2NzQnHAcohue2D9inT8CQyfEU1fudd7vc1+dN64krekwqo3B?=
 =?us-ascii?Q?1pPWumBN8knpO4teCdisxXOzTXG6EjKG7tHO6cekUJ+jmeVF5viLSqbFjb7K?=
 =?us-ascii?Q?XO48EJTBMr03xqxuILBFIRvISQ29FerwmjEXFOB6/wHWvaFTyTIAuSZ5TTqF?=
 =?us-ascii?Q?19FGioZygo+E7mlAb92REGeQipxgXCaxMB7uQdd/L5HG9QNdVAGy0lZzF+3M?=
 =?us-ascii?Q?lL2aKs3wMRzDsZxZkBU8OVKS7W73F7MnBhdKaYGzXDJoQa7dg72IEHSNeB67?=
 =?us-ascii?Q?qJjmHvxF977Xw9wkDXjmWxU10sjKpUZvdOL0RphtGSeD1dM1t1C3jev+lBFj?=
 =?us-ascii?Q?0Ejl4QWMfvRDZaDN44mDVmUd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qY0U/hdK0UGywzkIQ2JuuP+3RpjIV+WzRNbfMXz2QAy7JNVc4eykuawmu/K7?=
 =?us-ascii?Q?+hRk75uxz6+v05Mw3H8bazcmjzXHcRZmiGRQCTpMa80iZ/3NqI2Gy/VMncJn?=
 =?us-ascii?Q?NbuPPl09qhvtZ6xD08/cWfpynZmp6hVLmh7Z/EYS6U4JJdFONuG1p246KbAo?=
 =?us-ascii?Q?59Tt0xhbXUAclsd7Hawc0ozUd811165ZxCOftYW1rJrhdcc6J3mAwoFmyBJw?=
 =?us-ascii?Q?z3A2MSJbdolth3sHj38B4iFLL3Y9L++9b3uGP0HitA6hJmewpqFblPnWx4O3?=
 =?us-ascii?Q?HdIVhC4t4+dSQMYSdsJm4lMFQSYR3GTBtWUaGNp1NuYqG2cNNHk2UV/Q+Jr4?=
 =?us-ascii?Q?2SvVU2qBkJBsoJqMTza/uEpA14yux2X4/rV66rZ8Az8AjKJmsramNWf09j5a?=
 =?us-ascii?Q?ZkOcIppH4ooEPmwvmVT2biEonBIphXtcELGNNTC6JqOp7GIdgCaLkquRrefn?=
 =?us-ascii?Q?L9DRQ+WOGxXz0WmvwJXShdpMQp8WcGc9DcFqkH0JfJgtb3RgEBLfDbX4oEzz?=
 =?us-ascii?Q?dkZ+cgJqzvdahYN23UM9ahRfyR2i4JTU2psYlXDh2eOPbtZk4CWdMejHetks?=
 =?us-ascii?Q?tg9v/3OiZJ1LHxOhX8Ib46HwY7WlRIPhmvuNYurItKhgLYDugb3X5krN92wP?=
 =?us-ascii?Q?6UV1NiZiu6qPSqAdniZNQOd5DHy1KO9Z5hBtb87dGql7ZrA4GvkwOWaGYpPd?=
 =?us-ascii?Q?Nb1fOzsn5LQ8BTfKjxziaZGSnPEInUA7DdX5SFNFlo4PdaxfK5Gbwv4YTuVG?=
 =?us-ascii?Q?f6XpOaIAVI0K8WV+tXHvSErcoWIQArz9S+4bNOtqcpn2spdlMkQudwgwZHmD?=
 =?us-ascii?Q?jeKurlrglUeJxfDXOTKTsJH1izyqM2Vmu56Gl0m/MSmCiCYDish/7LwtSKF1?=
 =?us-ascii?Q?jtg3DnqPV7rJJjoIQwcwgQ9iZx1yXzF3Lb7FK8kHAURPMLxFIQms9Sp+pubk?=
 =?us-ascii?Q?mPAb+EKX98q19zSXmMCSBHa+BbMsS93YzVYzhLBH1cBmds7eP2X0/khsoipp?=
 =?us-ascii?Q?P3RxpjQZ/yl0ddRqffkWlx+r5UUCNIICPtd09eUcvGXd61dJIkQ6x7OMcwuY?=
 =?us-ascii?Q?RpTE3S+wdD9jCYUxPMiuvGEL5ZWKy6k5qfZHRyyiOhLo1X1q6vlrVk5wwv7y?=
 =?us-ascii?Q?hKj1ZO3/jCcn2LBYkp7QrImbxJZna5QcAdx88HnKhQ94dFgR8m4SF6qH7fRT?=
 =?us-ascii?Q?y7NdW76cUUopt1foRl+cz/yL7Bg3o/ri1Lv2RON832BdcfgTqQA/VFrS8IPv?=
 =?us-ascii?Q?gVEQZLi/bUrD4BMUOlHKmK/zz73Zkb3F2J0D9GkLkddQAKgPGTcXi165lMck?=
 =?us-ascii?Q?RGEk5jynXr47lTLwEPADG4wyfEA31syeIk9h5gtJD5WEwHUfoPVNbVN21Z2d?=
 =?us-ascii?Q?nKJky9I+7JItE8WTnM/DIpiy2nKSYMrQph6HFaTuZWxubxjcLzRpGchDZhhQ?=
 =?us-ascii?Q?P2lch6jKGPhAamKDtViZGAL4Als9SLjXZyVWZ2yp5UQfNoMz7qcdYBUFrq/g?=
 =?us-ascii?Q?UHfi3CqclLOyoVui2SW3qttq43GHPvYkrH4FI89nqCWOOlgfHiTDfvqEnlYt?=
 =?us-ascii?Q?6Jash7EN4+SC1oD6QfkFC3uZDfY2oAE+TXXJ6Wg5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1feadcc-4bad-4ce7-928f-08dcfdfa0999
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 00:29:12.6746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A4f19D9mCeDnET/5ay17qu9nibpvLDw4KLtz1UslWn5OWdKLxL8dMf4z2m/RfmnB6TZ57VF+C+q/a6dwZZ4Giw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6703

On Tue, Nov 05, 2024 at 01:32:05PM -1000, Tejun Heo wrote:
> Hello, Andrea.
> 
> Sorry about the delay.
> 
> On Thu, Oct 31, 2024 at 08:34:01AM +0100, Andrea Righi wrote:
> > @@ -3154,16 +3154,29 @@ static void update_selcpu_topology(void)
> >       rcu_read_lock();
> >       sd = rcu_dereference(per_cpu(sd_llc, cpu));
> >       if (sd) {
> > -             cpus = sched_domain_span(sd);
> > -             if (cpumask_weight(cpus) < num_possible_cpus())
> > +             llc_cpus = sched_domain_span(sd);
> > +             if (cpumask_weight(llc_cpus) < num_possible_cpus())
> 
> Not from this patch but should the weight be compared against
> num_online_cpus()? Sched domains don't include offline CPUs, right?

That's right, sched domain is definitely updated when a CPU goes offine
(I've just verified), so we should check for num_online_cpus() here.
Thanks for noticing it!

> 
> ...
> > +     /*
> > +      * If the NUMA domain perfectly overlaps with the LLC domain, enable
> > +      * LLC optimization only, as checking for an idle CPU in the same
> > +      * domain twice is redundant.
> > +      */
> > +     if (enable_numa && enable_llc && cpumask_equal(numa_cpus, llc_cpus))
> > +             enable_numa = false;
> > +     /*
> > +      * If all the online CPUs are in the same LLC domain, there is no
> > +      * reason to enable LLC optimization.
> > +      */
> > +     if (enable_llc && cpumask_equal(llc_cpus, cpu_online_mask))
> > +             enable_llc = false;
> 
> The second test looks like it should always be correct. I'm not sure the
> first one is. It probably is good enough but would at least be worthwhile to
> explain why that is?

Let's say we have 2 NUMA nodes, each with 2 sockets, and each socket
has its own L3 cache. In this case, numa_cpus will be larger than
llc_cpus, and enabling both NUMA and LLC optimizations would be
beneficial.

On the other hand, if each NUMA node contains only 1 socket, numa_cpus
and llc_cpus will overlap completely, making it unnecessary to enable
both NUMA and LLC optimizations, so we can have just the LLC in this
case.

Would something like this help clarifying the first test?

Thanks,
-Andrea


