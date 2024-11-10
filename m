Return-Path: <linux-kernel+bounces-403357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4005A9C348C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 21:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0F8F1F21206
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 20:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871FE13C9C7;
	Sun, 10 Nov 2024 20:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Oat0ZXEz"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2073.outbound.protection.outlook.com [40.107.95.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0508818E1F
	for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 20:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731269867; cv=fail; b=nE9cKa/LscgsLIUxr1a2DikzjZyvpDKvhh1p8SCBGwilCqI0Hr+59tLa8jK+T+U90K0TqQ0Tslm6tqD+rV4bLWRTGhjgvFMhbMTgNOb3RAk67R0jhK+TxnmGJdyaG3bmsKwlTWLz/d10LWJZoq1mnATLHKQTg2Ke82TReFm7afA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731269867; c=relaxed/simple;
	bh=vDZxM985RbBeeLVTvd1FWpoGrHUHPjwUR3OEX4bfgRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XGRwXiKq1v+8KSV2+Duf32qMh5JccqIPJP7Vxwog6QLpadaEdS/7xPLCcAl4V2vy77aUT2lMe2rTqg08DAGj7a1HXc2mBY/RxI2FTukrTuZ1pMv0r9Gau85FEUUbfmyTFRkOPUsKyeU98tQEeEI+OC8upCExVZb3tXMOnq69dyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Oat0ZXEz; arc=fail smtp.client-ip=40.107.95.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SCStxqpteHqfOvuPfgq6grJ+POrCxIYxPcm0QzM8p3EaMOLKAy2MMSADWlBYUDkOIIIFBCtrE2QY1N1O5Z7mfXVlz8LU/I4gND1ALk0vp9ePpIvWiNdsJyCDSlgQzLa40EOU4qUKlj5lllF8oCECytqNKky0m76ZHrDjOZd1ICM57W26qjaKJPoXQeY7rSNGYhGjte4qz4hrQu0IO8VezJTqm/pFwqNyH1BCP1syrmBWXv82Aug+fEREAb4DjL2tzlJAzW0kf/Z1skhKV5UmSBWyXS4VSoD+qdXiIBys7YopvY9KkPM0T2VasTUBnkIr3ZCM8mS0U2AUe5hcbFCP9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WGWXmcad+68xg7PtP5aSWWTrXjlVBLHkSAjJt4FLjH0=;
 b=uNHh+yFwpgDKcwoffKyV2vgVVK74zQNOtBzm5p5s8RkknzSDduIFlaqDa6jWxvgDW60tis7Z4sE3R/TPWiq9cy5SSsmuE/9/YzS3IMS2phb2UTadtC6v81fO+OzJE8GfdmfvW3GW+NIADCO96KGd+jsO56XSEiGXHhoCgb/uuKAhJpWNaKSqSiuyxOOfO7vrHea2XNIdlBqpcQiSImb5QP6rSuMuFTpOLjn2uuKy4Qb2eoKzncmdHQLo8ZfIQUj9KxUIuwZtXFCq39BkQ/CzOQrhvSk+Kxp9BVtqXiy44t4nsYyYWBD0SzYWWkbO8SFjU7B9wClx8VP2wqhzj9cPyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGWXmcad+68xg7PtP5aSWWTrXjlVBLHkSAjJt4FLjH0=;
 b=Oat0ZXEzTskFokd2btOG84Bos+56bPPjBupuiTAn/4S5g5Vvmiu0E7F7x7tvdqxDvlWsNqMWmTgBT21Qd6dGRv8x7q7N0qzj0gYu4MBK6sjchHyRi53fcLXzIqMmLApVsh+3vNNsBMYkId3YvGB+EjAxLUSNKSldyLwFXxP0dD4Kf6X/Ffhr9hHEJ2X441BWR2qASK7eHRt7Dl6NajQUrJuDeJyudk36BkriCb30K0gHLixYSrxIfrdWXQPBQwU1zLdfka8ibKSB7GV9YgVJfn3PoTFTWlHM55h0C3/z64lxrFDnzSn/oFW75rv0L+2B/3IvaFNyxkbhDjiBDiBcuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by IA1PR12MB6556.namprd12.prod.outlook.com (2603:10b6:208:3a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Sun, 10 Nov
 2024 20:17:42 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8137.027; Sun, 10 Nov 2024
 20:17:42 +0000
Date: Sun, 10 Nov 2024 21:17:36 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: void@manifault.com, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	sched-ext@meta.com, multics69@gmail.com, me@mostlynerdless.de,
	ggherdovich@suse.com, dschatzberg@meta.com, yougmark94@gmail.com
Subject: Re: [PATCHSET sched_ext/for-6.13] sched_ext: Rename dispatch and
 consume kfuncs
Message-ID: <ZzEU4JaN3k89SVKA@gpd3>
References: <20241110200308.103681-1-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241110200308.103681-1-tj@kernel.org>
X-ClientProxiedBy: MI0P293CA0013.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::18) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|IA1PR12MB6556:EE_
X-MS-Office365-Filtering-Correlation-Id: 2faf882e-0113-4371-374f-08dd01c4bb2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/h7l4IW+mpgQ3G2kEuRO7q/4eSyLg1VbV+/cUVElNNmVFMc+2rzFeXP5JIB7?=
 =?us-ascii?Q?pD2Hm16KpnP8bXQrCwRyCAXvs6jTNo3H+r4fEeHR3R9g38eHo0vh/0Z3ZM0I?=
 =?us-ascii?Q?fJMJoPyELrtuXqfznxBxUG3ESUuLa0ZkyjfFdypbLuzuXK3hnmjPATjbS4G0?=
 =?us-ascii?Q?XvGp0MKvcynFDHxgGJWd4Lfp9NVmMPXa7HLcsEvR0gbZGWOjS3gftb/aHHX/?=
 =?us-ascii?Q?4WJZk85jCKTJ1hH8zv04n1ETS6lL4G448fWe2xjxadeadq6Au12PlwpHaOiH?=
 =?us-ascii?Q?sEbMzO2w8CX5SySQuT2+ez7K78g3wJkHxgLb4bk1WBQue5uhr33r3oOGH9m5?=
 =?us-ascii?Q?bbgre16knvBhljgdF4mIR4hhEZD+PcpeqrhcpyUsHUkAp9tsVrwRavEQW3pj?=
 =?us-ascii?Q?pviCUsSv0Mc/wDgoc1y9lw6qIMmJFjDcYJyANwCngTGQ7qxe9M279D/0kTif?=
 =?us-ascii?Q?m47Fcc8qghJCcaNg6HdcUMTwGSRx2KUXo43oSNZ/Wp6kx19RJv6/E4DbiM25?=
 =?us-ascii?Q?nbBgFjOyE2dz1bwrXvz08zu6piQk+CmD15sUpJgeBC2dLd/O5R2WtEjY5u/P?=
 =?us-ascii?Q?jR3v6tL2SkKM0bLrJaQIznjBmJgcHTvYmkxigwmy+bcDfkUif6veH8JYMO5I?=
 =?us-ascii?Q?zGvaqB+uzKU6bucVMx8HdZHXrE89nwKjzwGsQCzpvrXHNR28R6wSqgd3fOhl?=
 =?us-ascii?Q?LDoWbEfPc96UEb1pWGbcDlyRe476A3S8fkH1OOawy/NjAUY1ikJs6mC+mCkk?=
 =?us-ascii?Q?95aO1ck5r+FOg30xVJNdRu3hb/bNGL+yM6geIO+rGfOo6aQQM4jAVGMwqRKw?=
 =?us-ascii?Q?KzEIt08s06LOA9ozhdfVD+OIsshkvIh6jhO1qMyk2QQ8SozlLIrdMefgwFV9?=
 =?us-ascii?Q?xGRm8cttuvejgejatlSFKHwAu1pKWs+Vbap+mcd3zWN1GbdjB07yvUdHXuf+?=
 =?us-ascii?Q?bdnWnE1ZwQFWDY3rEqgL+CfrgtfZIwE2sqT6EbeTH8rHCL+9wrkkycvxjRfR?=
 =?us-ascii?Q?yE+VrgggVFmUYklHIoYdwrtsi24cOZ8HMQff3p5Ww/N58am0yHZ2CqwGdqt9?=
 =?us-ascii?Q?jnfz1Eo/Z2K7z3ZCrYBotXJQitgmN7b5F+emp7ILrCa3f61Fo+BqYFJZH0Rl?=
 =?us-ascii?Q?0MxH6gj59HkxsPOQ+BU4W4ZsFNqtbVN2QdEXeu7ko1+Mh40DKgoES6Mj/QJY?=
 =?us-ascii?Q?wfn6ACBQJuOFWg0cZTnOo7xkh4TH32kJLFwv6cl39bSEhI19Ls+MuuRGufat?=
 =?us-ascii?Q?fAXqJo6Nw+niCTOjVOD5ginHkpVbihBHDOU7Pgz1J9j3YY5T/2Jp0wDW8FhD?=
 =?us-ascii?Q?r9qArxoQ2NKgcuCmjiyF/6Cf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EfHFPaYFLL3UrvWOR55PsupZi/UAO5laO1lNPAltSY1m9wU8ZcQh6hW6170o?=
 =?us-ascii?Q?uhCPM9DSYtCHoUf9k7SjmL7NAK3xsZKr9E7rZnjtqoOlhVCXm/WftL2aB6vV?=
 =?us-ascii?Q?fw65FtLH4qEMAr4lhmsOR9F3bgyiDQryw8q9919z6a0dnD2+6J7hWVW1C6Eo?=
 =?us-ascii?Q?XpqKtIir9HmvlhneHXDwn71yJayH6Ty0uKnvjVLzp4dD8Zs9yquqZDx9vPlZ?=
 =?us-ascii?Q?y3C9UYM8dxJQMqCcQO4a3F1ILM4arq588w8YmPNqVhhV3O1ZrzGkebwE+34V?=
 =?us-ascii?Q?h10bLzP5a1rARL8BZtB6SYy4+8sPSei13COn73Zj5mImQ0sbpaPidFDK/qO2?=
 =?us-ascii?Q?4RgHcYTKM3EZc2OAsPG9PV17Pq6AyiCN8joe2PHEv5tSNDeXnO3vwoha9QwI?=
 =?us-ascii?Q?llGWWPRQSO64qKcWcLQa1K4Kia5X9RbFJ/dJD62muNSEVPkvXwWkTodmhCxC?=
 =?us-ascii?Q?0PpAdpJh+zcAVvcV5zDNFB0KlOKVMj2wb+wIH1vuCE13bXF9RZ/qyRwUFyqQ?=
 =?us-ascii?Q?gMhyHhdWnRL7KvN8hCe82Z0AVKXCnZehJ2PzD1j7DXEv4sHuLdTjM8kLfGmQ?=
 =?us-ascii?Q?5+gxvw+wJfZg2u7ZSfXVhnKpfX4k3kkHhhl3ae9eDvMp6YSe4TQNEUiaaB36?=
 =?us-ascii?Q?EMXOysu/vW3vP1GvOr4eW9kCU343S+5LPWDootiDBL8jt8GQn3BEJqzWvl5c?=
 =?us-ascii?Q?p4ZBoC1G8GD78xT20k/CDjaWRPea7w+7NSdXtc33NtRdO3bB2AWQCTxKFUcD?=
 =?us-ascii?Q?BhZ8CD9p3JO0eo/wAUJU2TXdJYQWwlLc2hbvjT4lNdvt7LOJRA3vT8E+WXUK?=
 =?us-ascii?Q?ZLi7t6TrbKAHsCRDRyh6PtdXYfej/0bsQ4cm4OkR/BKWfKvL+yLDf/ojwk6Y?=
 =?us-ascii?Q?0f4iWs2MBlTffgYNi0A2njUvPr2aE/+NaxLGJOOL54SJcAhDzx6O53OUJv9r?=
 =?us-ascii?Q?qbvYJAtMI0SCu9+Yjqw6e9lr+zAn5EMF9jYOqzzr4KmbLLAUmQL7OjTjcS/U?=
 =?us-ascii?Q?zBLWuGT8AZxgxbOqUeyYTWgoCvAJA4mxOBRTEWJ+mJbkmosupWITiQOfvIX5?=
 =?us-ascii?Q?LoOjvTiEklQwEtMEqQROi6WHmUhOt6R2rG1oxwjNvrQOqTbQ0PP6e3lGVxJL?=
 =?us-ascii?Q?5rs6hBf/P63J938znoVAo7J0xKnEvLv0g5TGWb/8So5qJ69C3G7G5RkDALa7?=
 =?us-ascii?Q?s2CFWzX7eh0H9hch+qOVsaZBRRLJI+IjwN26KA4OhfE5cvVhJDGEhDS8sHse?=
 =?us-ascii?Q?Mmv/YfGeNS1vnjsnsYPLCoWsCf8PBvYli9gV/dVZzkp+EBy8iGfwbwXU/oqo?=
 =?us-ascii?Q?w47aiF8aTrADJaegjjT0nvOfFYGijg8xIys93iS8FCqYrC3W/OvMmaKWYDn4?=
 =?us-ascii?Q?vf6vkTU8n9TLGWUNdj/oLi7u0S4Rq5kkOQ0W74XQn2YzFehuiCsTYQbPqnXr?=
 =?us-ascii?Q?RGQbouM1dG5igT8n6vS2WSYc6lI4BZkqje2vPmgD62dkNXxJ9lgWIuEo7ALL?=
 =?us-ascii?Q?c0Bnu5x0DZI7dbf6etFFOpR7VxeQLjWC3kosSutrenpztAyZKTRmFHspE+qn?=
 =?us-ascii?Q?aL+cnfE3NWwRzhEziVryp71d3i76zBFNOSN4H2rq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2faf882e-0113-4371-374f-08dd01c4bb2a
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2024 20:17:42.2980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KScaH8+EBehr7BtD6WUvKz/bCeRKC0Z2Shi9Rg+9m+mWN1PmcJQwDhZXeknY1okB7j5f8FChHTxMRIcwEb4D8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6556

Hi Tejun,

On Sun, Nov 10, 2024 at 10:02:50AM -1000, Tejun Heo wrote:
> Hello,
> 
> [v1] -> v2: Comment and documentation updates.
> 
> In sched_ext API, a repeatedly reported pain point is the overuse of the
> verb "dispatch" and confusion around "consume":
> 
> - ops.dispatch()
> - scx_bpf_dispatch[_vtime]()
> - scx_bpf_consume()
> - scx_bpf_dispatch[_vtime]_from_dsq*()
> 
> This overloading of the term is historical. Originally, there were only
> built-in DSQs and moving a task into a DSQ always dispatched it for
> execution. Using the verb "dispatch" for the kfuncs to move tasks into these
> DSQs made sense.
> 
> Later, user DSQs were added and scx_bpf_dispatch[_vtime]() updated to be
> able to insert tasks into any DSQ. The only allowed DSQ to DSQ transfer was
> from a non-local DSQ to a local DSQ and this operation was named "consume".
> This was already confusing as a task could be dispatched to a user DSQ from
> ops.enqueue() and then the DSQ would have to be consumed in ops.dispatch().
> Later addition of scx_bpf_dispatch_from_dsq*() made the confusion even worse
> as "dispatch" in this context meant moving a task to an arbitrary DSQ from a
> user DSQ.
> 
> Clean up the API with the following renames:
> 
> 1. scx_bpf_dispatch[_vtime]()           -> scx_bpf_dsq_insert[_vtime]()
> 2. scx_bpf_consume()                    -> scx_bpf_dsq_move_to_local()
> 3. scx_bpf_dispatch[_vtime]_from_dsq*() -> scx_bpf_dsq_move[_vtime]*()
> 
> This patchset is on top of sched_ext/for-6.13 72b85bf6a7f6 ("sched_ext:
> scx_bpf_dispatch_from_dsq_set_*() are allowed from unlocked context") and
> contains the following patches:
> 
>  0001-sched_ext-Rename-scx_bpf_dispatch-_vtime-to-scx_bpf_.patch
>  0002-sched_ext-Rename-scx_bpf_consume-to-scx_bpf_dsq_move.patch
>  0003-sched_ext-Rename-scx_bpf_dispatch-_vtime-_from_dsq-s.patch
> 
> and is always available in the following git branch:
> 
>  git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-api-rename-dispatch-v2
> 
> diffstat follows. Thanks.

Looks good to me, thanks!

Acked-by: Andrea Righi <arighi@nvidia.com>

-Andrea

