Return-Path: <linux-kernel+bounces-428869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 797109E1467
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 08:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E52D16446F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 07:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942F9190664;
	Tue,  3 Dec 2024 07:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="doxd0t2U"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1619018FDAE
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 07:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733211531; cv=fail; b=mdW0knHbWIixA3CV5+kX7uZD2qgeKFGUdTtMhbsqZB4zKRZKQ99T2czpIQSA4fnIj5TANBKwOKf+Cdgj6REBv4qUQEmECfwvvHZqDXYozBkiIq1J/z5lgCq+Tv4PCwLmCP+RX0OAkox5MQVs3mVjE+PRQr0QiihyCeN8/K17PYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733211531; c=relaxed/simple;
	bh=PWAJ5EDq2RIP0Quu8UuD+riA5CUVboiFjAoj+r3XNuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LNSTU4ToEVEvppP37cCDzFqUPq7AREdVBZ7gyGZ4kW7j/ul6l3Ng8qpszoMAUPEmLRO5id8OZK9RjCr5TyNI2UqDl2hFD/npfTk1GgZvBBJ43JWnAC9BpBUUy+SWXaJWNWh8amZPgfrcDPwgOmAdy69nPi5DGAEYQYLi3+M20g0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=doxd0t2U; arc=fail smtp.client-ip=40.107.92.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QzJxzLhGFuqCBrE1/vHRpnBqGNBE7f8h/b4gjh2dILc1AGjaeL868AZNAs6xbf5ZjACmRMqhysIiHh1yDzugHEweWBzZtQkmz0dv+LHW4r5CO0DyBRVi9/kbQWvwavJpUfAbXdCS+UaqZtEdHLgAWbsldsKMF2nsflRHS9ZuV2llAyXejlQZ+NN5/Wp3RdOkw+UUHEGUwnqFr7c4szd7hMlSWqyfTw8lB6YG3At23Fmv+DXu7TcYKy3/h/aOa5H+wpL/Qo66uJt2OPmQnO1yEcU463lbsiSkxMN3L45BAJ0yXXlsrWyH6+iu1IoNrUhDL7k1ShTA8TuI8qrW/8/pag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rAXrbEbKDaiXcmoo3EUbzhqwma/w1SD1DgcNhth1P+M=;
 b=eWucntuM16w+zaDbuAZQh0g1FANphjul80F4+HVSRpvaJEr1hWoaUd7DODzOj9rNEkSOGNoepcSr6gNaUpA8S/5XOTVESKAU7VCCJWSQFnCyc4fOqU2K+f0W0J5kBxpoXuoj59L8DWsTC7mMj0/ogudEc31ii8fp42M/0ybuO8UlBFekbX0eBHtyz1C2buwkJKjJgGjw1etxDGG26KYq3DMmTbvGtvAIBqzKr+lQPQBhlntNDPIFnfYulYjaoLAChkiuOdkEg8R2Xykr/gFOFpFXSunNL9BWE0BcrxCkACYKTvUBJfZGz4krp9bo82jfQkRZm7Jj+GilJImlm40Wug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rAXrbEbKDaiXcmoo3EUbzhqwma/w1SD1DgcNhth1P+M=;
 b=doxd0t2UDOPUabg+cvxgbWrP0GHX4YAw3/5jKHfENBLkt+RaDhP/EykNqIZOL6+A1z6pR3D9vBpR8a+USsnpqqALj1yT5ey8inIVWCFLH8gpdIc1+9bFzO/K1nK+8z88oAq8NxW/QJFa+PEVt5c00fRHbe3HhzaezDCYladpCoQHdr8UAJWHxZxCphKinPXltP2B8grDG3Nc9x8dTAWJ0oIwiD1OLv1XMkri3fDxlNa59pC9XUXzQ/W8VH0WrbER4XieddUpc/M+lEXBXt5RLx1ZPNS3TZ6/jYl8ofrxXIzPCmEEQ1cbVaERFXSMlZmmP+OO5DWrTEkUJlAW+RTkpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by DM3PR12MB9392.namprd12.prod.outlook.com (2603:10b6:0:44::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.18; Tue, 3 Dec 2024 07:38:46 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 07:38:46 +0000
Date: Tue, 3 Dec 2024 08:38:41 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] sched_ext: Introduce per-NUMA idle cpumasks
Message-ID: <Z061gVVaFwRwd-U0@gpd3>
References: <20241129181230.69213-1-arighi@nvidia.com>
 <20241129181230.69213-3-arighi@nvidia.com>
 <Z0oYTbacS0lnO-jS@yury-ThinkPad>
 <Z0suMHchW-KyIGyy@gpd3>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0suMHchW-KyIGyy@gpd3>
X-ClientProxiedBy: FR4P281CA0292.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::8) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|DM3PR12MB9392:EE_
X-MS-Office365-Filtering-Correlation-Id: c558febd-75a7-45b7-fc59-08dd136d84f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?23L3K/OH8/QJxAeB9U93+hS6YlAVrEMU0IdOXDhAQD25FbKdq74d5kJIR8TM?=
 =?us-ascii?Q?aq9uuis0XRGc0CYtnoYvrMPirE8HDXPocxQVkSrUDaG6dgFAIHFuH675o2tL?=
 =?us-ascii?Q?mdUHhGSWkFR2w+kjvOmFuii57CXnsNVEdhLbJtB36VTeqKodJSUzmuhpixR6?=
 =?us-ascii?Q?oSyuYCiEk4z7RJWkwq1PBRzAEaJXUD8hTu5Mkjpcb2zdQjqwrBx0HU3WTBgK?=
 =?us-ascii?Q?FfxKEZp0e73cHB5csNi/3dFAcjsXBrSKahxQCrANmNnHBaMTJ3urd45amPu6?=
 =?us-ascii?Q?zV5E0TdR5PIlN5Chi8kMZqPPfoXg3jBUehw+X1sdQI3uIeslO1vFQjRnqDKS?=
 =?us-ascii?Q?tPbxESvTlcgkYinGkKOvEaDDxv1n/JaB2BS57Q4ctCCRbC0MRS2XNQ1B70xx?=
 =?us-ascii?Q?HQaZ22QS255He2wKe6iixET4gySueDD5zK+fvdyny3CtD/HLriKPbkLoiCPH?=
 =?us-ascii?Q?QePgqveTSf/ph3UdX30/S80UehZ+h0yfvIsjLE1Vq5XhafcUOyH08Z/1m8Lg?=
 =?us-ascii?Q?fSJWuh3fzmFMf4M0QeuWayVUygwCW7T43jaiw8b9Yki6tU+VP2NucRYoL17l?=
 =?us-ascii?Q?V1o3AV2DJAMVjEFO+/GtkpAFDoEjNN6Z8nkJBQSgwzbGWciVgis+sLDXICNc?=
 =?us-ascii?Q?GT/7ba/LBSq3WFgVAidGi2S2e9TJih4puwU1Ibzb9bMdkzQh2gUSKUeZdsOo?=
 =?us-ascii?Q?ztGcJKuX/cwAA+nH4vCH36htYVIrSMgzf1li+K6B8WljcM0RSafl3AqcjsYy?=
 =?us-ascii?Q?hU3zEx5qqM+BKvUHCX8QCM/CoXBGbdS8xlrMXTckIF3lg1GanhMxJWcXMt1G?=
 =?us-ascii?Q?PLxeDXposDjk0ZKMi5rOaO3MHZA6sH5XSNhD/+Pg8MB5Du/AcLKndO9ybRP1?=
 =?us-ascii?Q?OJHBm9Lc8T0A3xU9g+gOKjV5rUauMjY4VrgFr7jv7qa0XygAOM+hbyvnYeUQ?=
 =?us-ascii?Q?1JbuC0ydsCDy660G7Tfr06Rl9qoMpt9NmyaLqdinLlfFXPM8ONWZI+vWmzb1?=
 =?us-ascii?Q?/uaYbnYhe+bshuFdIJAciuAmgfIPZEiPM+u2mOtVqDdDlrbvR0ELrcOBxKvW?=
 =?us-ascii?Q?p88H8dRbzVm40okP8gqHeykRQuPRoWS45PlBqBECFiU10rq6MwMoX/ZHFu7N?=
 =?us-ascii?Q?iZ+eLhnITnmaWsUENEuITCnK3892XcjFCtgPQeaz3Ge52/O7POjnSIaasGWo?=
 =?us-ascii?Q?Khoqb44DmQhX2zNsjTKKl9e1HGT58USVu+7kGKZu8/HO0td2ajTzRIbYp4BV?=
 =?us-ascii?Q?aKmatG3hxS2GkzcTqPCiOKCV38PUgSyL5ZCdWBevqTMUWxSZLmXmKHTldJJ9?=
 =?us-ascii?Q?fOICHSQr0oTHDM+TeufrhZb/iQ7X2iwGA7vJy8DUR6XhkQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GiCJB741vVNmtqf+o26v/fG5SJMpm1ZioGcXuqYWVtT+ljAJgpkJklcWA9+i?=
 =?us-ascii?Q?dA9SekJK0ayWf1o1NDTOz07ObITztRBXK0hnbGMepdvkeZ6ORjYnWjRRvw97?=
 =?us-ascii?Q?Adh2xUG7m1uuRUVANLDiqI16y76yeawnehmpIr1c8wwIQOc2hIT6Wc2K5vr9?=
 =?us-ascii?Q?b3okYEv9oZP+PXO4G9rVibdc65bLh3CJkB9/mJIskElT0R97PL96W3jiO3ot?=
 =?us-ascii?Q?fXboLuiYLPNbwhe+9oPyzQYdvZpbehy7B9ZVJMBkyVYL3IlSrV5xbzuBr4p9?=
 =?us-ascii?Q?o9iM9dK0plvE5eZBLRv3w1HvCij7ZkBB1rKvCFmP58eFsdwpF6x8uG6ZrB7j?=
 =?us-ascii?Q?9Dr+PqrPmZORpnqQb08B1Znfd4L9AnMVzqym/9hnacW0m6hyBOYv0AQLQCxj?=
 =?us-ascii?Q?SlqntnAI9gjSx+0IW4kSqvYTitY+WLO3BYJIG75b/iGmqY7/3ARRFt/Ea3va?=
 =?us-ascii?Q?axzJiBiVWrFkxtCbxlQI3bZdrAtkYKolTMRb4A3NiZ5fpSsdn7UkahDBgM9B?=
 =?us-ascii?Q?+ohF7shBKZkVd/GSL/Amla5+PFezM60UQHpPiYXkYJJImKNJ4wCZeIQrNMcG?=
 =?us-ascii?Q?1/rKFPc8DOeUOOkMSGXNpHCU+LJ4EK1ZqpzyPne5G4FVYLjluw0/ISdD+7dz?=
 =?us-ascii?Q?WZ3ngNTOZYNxTWsNFITBSeW806POZWi6/hSH3fnI2394kerNExAGwyl8QEnF?=
 =?us-ascii?Q?iWO+4Qtz2YsovvtT8q+td2uwNMJFn1p+D3k5o/C3u1S5aF+e9oBH0j2hubao?=
 =?us-ascii?Q?pI+IvUa5pquD237ldjFeIEE23KgoWMmMbzqZKNEOkGURTTJs/s7wmvUOZsew?=
 =?us-ascii?Q?k7YOxDRDK1c6W91CeAGNx42SHAUE0b+HqwN3JScZpsns7SBYLK6j3ZAtEF81?=
 =?us-ascii?Q?OSs1LjKQK8nxPHRHxWPerR/C9DXqJ520eHUKxRPxwlLxBOFSZdiVWjyOdhiq?=
 =?us-ascii?Q?xiB2PL62v1ZLDaAr+aQzM//9CPAcSQVxyKbiircm/1CYvfOfAvJ9YSBfVyy+?=
 =?us-ascii?Q?YncVARgetbXf3AU1gSLvKfrTrMJjdbwLBeJHCkkhSKkom4N9CHhHt4xon66c?=
 =?us-ascii?Q?m7ZL1/tkVO8RVRQ0eMz21TzLUflLLXPRfDEt364sXm3hvifSZmurpYMvsTbu?=
 =?us-ascii?Q?YuN26/BLBe8e2Sw4x43o4W4IPT2QB69Rk2S8O0TiRAmTzqqtkqDe5shUDs4P?=
 =?us-ascii?Q?S76J81i1F0WAIY9E5EYnzBmh5z5KnppBkjc4VhAVklEbQI/Qqrb5Fga6KfA5?=
 =?us-ascii?Q?RtW6MXulKj233xEfD3r76aH0wh/bcqRxI2Z9GB1C9ulsjb7y9EKNPuhnwlhq?=
 =?us-ascii?Q?zXRlhJ9Boex4nvCr7Ik+EUUxwybaOJIclNcbi08HoIbo/RDVGMcfzrfcJkkT?=
 =?us-ascii?Q?XG4VP8ammH5G248BTRJgZNuWU8BSgw173jAX8aB+fu50k926OQlPMTvfIMsy?=
 =?us-ascii?Q?UJ3blesVQd2VEm81wz0NNOHnK94rJ/8RNuyNO5kduJVZHVnJ8RRAIdq6AgWj?=
 =?us-ascii?Q?qzB3On37mCXIyzTfzQEfU3Jni1HMc8Len+gr4sOTKvLJRQac6ICbB6BetEIk?=
 =?us-ascii?Q?GDV+SFoKXhC1WyK2cfhMJcookzcmMClwnbpRqFpy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c558febd-75a7-45b7-fc59-08dd136d84f3
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 07:38:46.2008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nSFWQYpaLstaOfrkH6w5JgxMesfJgNWo5XZlZSwCa0hGgdA+DC7kduzIUgL5wr51edKjJP0eIgZa4VJer98dtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9392

On Sat, Nov 30, 2024 at 04:24:36PM +0100, Andrea Righi wrote:
> On Fri, Nov 29, 2024 at 11:38:53AM -0800, Yury Norov wrote:
> ...
> > >  static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags)
> > >  {
> > > -     int cpu;
> > > +     int start = cpu_to_node(smp_processor_id());
> > > +     int node, cpu;
> > >
> > >  retry:
> > >       if (sched_smt_active()) {
> > > -             cpu = cpumask_any_and_distribute(idle_masks.smt, cpus_allowed);
> > > -             if (cpu < nr_cpu_ids)
> > > -                     goto found;
> > > +             for_each_node_state_wrap(node, N_ONLINE, start) {
> > > +                     if (!cpumask_intersects(idle_masks[node]->smt, cpus_allowed))
> > > +                             continue;
> > > +                     cpu = cpumask_any_and_distribute(idle_masks[node]->smt, cpus_allowed);
> > > +                     if (cpu < nr_cpu_ids)
> > > +                             goto found;
> > > +             }
> > 
> > Here the same consideration is applicable as for v1:
> > if idle_masks[node]->smt and cpus_allowed are disjoint, the
> > cpumask_any_and_distribute() will return >= nr_cpu_ids, and we'll go to
> > the next iteration. No need to call cpumask_intersects().
> 
> For some reason, removing cpumask_intersects() here seems to introduce a
> slight performance drop.
> 
> My initial assumption was that the performance drop occurs because
> cpus_allowed often doesn't intersect with idle_masks[node]->smt (since
> cpus_allowed usually doesn't span multiple NUMA nodes), so running
> cpumask_any_and_distribute() on N cpumasks (worst case) is slower than
> first checking for an intersection.
> 
> However, I will rerun the test to ensure that the regression is
> consistent and not just a measurement error.

I did more testing and the slight performance drop is not consistent,
therefore, I believe we can attribute it to measurement errors.

I'll send a v3 that removes cpumask_intersects() and includes some minor
code refactoring.

-Andrea

