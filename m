Return-Path: <linux-kernel+bounces-423130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB7C9DA33C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 08:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36465161451
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 07:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC14C1537B9;
	Wed, 27 Nov 2024 07:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NH6/Yei3"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A2E18E0E
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 07:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732693270; cv=fail; b=UMKCKg/6kEGlexyPS/jSJDF5UOZ+QPQeGuPdTlLpbW1Wy80mKvrCzZOVcPIqyI/3xOGuGBrRolwMv3XRleEN/HYmpQLkIGbyoLDK1F3B5me37I3uGele671iyu6HWMffEez59LnHM/IUhBa60jRKXi6KSn52otOc1PRnBNoTLtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732693270; c=relaxed/simple;
	bh=KgCZrHF9W35LJ9uV9Mgiiwf1xrBGDrpEK2R7zBqLFUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jPdqu9HhDkSH1Diwh4Vbs6R1xz/qcr1vvOJwS0JYX5tksshCLCvpvEMFNHk/z0lx6Xli53TvHB3bdzs9QyS7W0u25Md8rrygsHk9JA2lNZSxd4z538r/IL8VUJ/hdJBAIcAnPKejJGLB8y+enjolrLDYgm0FJKqpoLg0EgpbI4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NH6/Yei3; arc=fail smtp.client-ip=40.107.237.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VqTbFfXwd/aIHotgJ+/5Lv/Or6u+l2eSsESlqVQBb9g0OoqLJS9VUZbmuRFXfHekmPpkh171FxHCV8AKQwj9SEFlTE1axqpfERMr1ESz+4SvBGaGuFROpRHoaOKHQFR9y55Zd/9/9H/ByyloAoHQrHTLxg7lN6rGfef9U1xUlhEEv53liSDbX06WKt4Ekuh2LnLMVTHFCxyfBd7qJqRfBvrxidbDCJsAvLsurEgJunbjYWVimjvSoDeCSUre495pSvVaLxWMmwkFxaJCDVwbq5hdqjRA2GTy4GN5cy224Z/NI1vVpc8ZR0nu4/ZvNidlXQUrBqrX6xkwchGT1kTtCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2X2DWEljnPbjikQr1GWE9REVou4Z8e6Qrf9ABOxrIw8=;
 b=xfgvjhA6HPasiAVbFWLdIvPi6WqMO5zt4p6CtjkqbagyvVMwac9Mf7uGIWVWMtw+zPP9TrHX72/DP8rc5iZHURv6fFRc52YPo/umRKaYi5m1inMsfHQW22thVmpyRuR8kD+8KH0XzVqmftK+8SK7YjvwJ1iuKmK+qJs1qA8pMbJnajH7ACNr0eSoAgKSdajKPotfOsQn1DsPGj0TI7wJsdo54wFGD8pdrYlLMpSsjmPhUpd/U+3p5fy5+UzAktY8GEyi4slJCp0NJUghh8BQI4qNlS/7zG5ldNB4qfeWIVY8Vp97Riz1x+Ty/ebFUXnUstn+EWHXnITczhbf+5g5sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2X2DWEljnPbjikQr1GWE9REVou4Z8e6Qrf9ABOxrIw8=;
 b=NH6/Yei3zlHaMhT2nrP+zP3ur30PA+Ui2gQqfwT1dx9HpMM/HRrQ1nxUEzLwXtBjiPSIDOxma8iTMGw8/PtCCZjIhZ4ViPHYBX+sEBm1EqcWDFAT0aaRsCwBA9sUjzMY8lHxrfFP7m9tOKT+uZHBNCR5gAlM0BqkgS+5TVhvwrrp2Ovx1TbkmbA6BlVsKyjKTbsTAWu94HKFr2Jh+thGShUN7XZVZcYjg/+jsmjqBJL6S9pHHGRze5/uPaJXUFfTlUe3/teqjAbMPOhvYgTde5uC2NunopNdWFdevhBPLNsyWmiGAi4Vs7Q6FvmQQ9864GzKha6eRpkp93HiiPvUOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by MN0PR12MB5955.namprd12.prod.outlook.com (2603:10b6:208:37e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Wed, 27 Nov
 2024 07:41:05 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8182.019; Wed, 27 Nov 2024
 07:41:05 +0000
Date: Wed, 27 Nov 2024 08:41:01 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] sched_ext: Introduce per-NUMA idle cpumasks
Message-ID: <Z0bNDfGufRZLfAP6@gpd3>
References: <20241126101259.52077-1-arighi@nvidia.com>
 <20241126101259.52077-3-arighi@nvidia.com>
 <Z0aFZJZ85LUwapZE@yury-ThinkPad>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0aFZJZ85LUwapZE@yury-ThinkPad>
X-ClientProxiedBy: ZR0P278CA0190.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:44::17) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|MN0PR12MB5955:EE_
X-MS-Office365-Filtering-Correlation-Id: fe7daf77-a0ad-450c-482d-08dd0eb6d968
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vBtSCFRPeRPtkPHiqFAGobOTOt1QlAiXuUU9VXr6fUAX96qbPLEOwV35wfGp?=
 =?us-ascii?Q?Hcwx1/A5R4/MHcZieEGLqpWJwav87/15IAY3Mx1r+2wz3zzFgUZtRWqas7j7?=
 =?us-ascii?Q?4MUhpf4OaeScXoNug+PnS/j7G/tz8mId0JrLT57S4HU4kzoSjQ4Qd9oudIJY?=
 =?us-ascii?Q?1g4jH0dupAavUEVp19CfeMC/WFOnTEiB9F1lk8zA09rYOcxy3SNcF4DFJ0zk?=
 =?us-ascii?Q?wIdQD0QgOBP0q6RJhoRnPlzpOtpntNqqIM2D4APZlTC852uvl0zuIYX8Jk3w?=
 =?us-ascii?Q?WNO4rZNlZ8How0h6Z3Sx/+bLaZYmQZrudzClNYlaIgNQKPiwC/s6V/UWG4ZZ?=
 =?us-ascii?Q?Kl63GTrYymsHfFupfVsKWPdyaf8Ubr8Y3Zm0xeCyi+Uw/fwqUXaTGkwc3+I4?=
 =?us-ascii?Q?IYtXO/sWYc8TJFthTX3L+e55fxDbLRuoZrgFviYyfAtiyd+RNTdgH/X1MUrK?=
 =?us-ascii?Q?mSuFZUKBCxv2zLtJVHU0iHDhPZICj26lz83Lu5ZX5r37sedNQK6TW8k/IyoK?=
 =?us-ascii?Q?AZLRPSZ6G/g6oWcfXPkCkdkKzJNzkBzJkuq6sLNgxx4Onlj7cezSNSaXDILH?=
 =?us-ascii?Q?7SHqucPkmxgRzIpBlqCiT3zqQ+A7zSK1T8u30K7sHwoxc9nuYiVPI1X2cWB/?=
 =?us-ascii?Q?/0OkFo76Dcip5ZVBvESUTGDraXid24zT1FHwKXeTo8WCPMLd61azsTpVyhkl?=
 =?us-ascii?Q?mquiUT2u0+pWppRNL12ISScid+e9BPYzELqE/1icSdyp7cBK43cIxSi5ebx/?=
 =?us-ascii?Q?mEiw7R//8j2RQ2Mc7rfgIGlLjMqNwbVSbDsSq1XbYD4eeePryZbOrMACp3gU?=
 =?us-ascii?Q?8cTaZz8ZXogDVlnxRn5Gy89JhmLzRMojET1VSTenCaWsSFPp7nQ4RI+J2wV7?=
 =?us-ascii?Q?ybPYgUjzT/4uAkZrQvj8UpA+xbA2CXUI7h5sJTGVesISmYafSM/QkX9J+zNy?=
 =?us-ascii?Q?sLY3gTxhrPfcszthBz43PTzp+GzWzNKLgFkGuytJbabawxRCtsKZAAJ28DH3?=
 =?us-ascii?Q?njUeQv0ayr4N6KpbMbTUh8UOXoq2xJCZXJGOP2x3yhN1ZOB/dtEbaYxR0mut?=
 =?us-ascii?Q?YYHjWRvLiP9R0KFZEMYQIwEKmkY6rMABukiK9zALc3pl1D90oK3qyvHoFYSy?=
 =?us-ascii?Q?UwVQUQ44rNPONSAs80fgEIdouMI56Fta9XxkpfeWcdTsu9k1KRbiWZpnVVSf?=
 =?us-ascii?Q?+VopbpR98/4uVadPdimhRIA95d7cqTXY3SabTDiAPuWYvZre6XwGQ/NLEXl4?=
 =?us-ascii?Q?T7BbYt0AGOug7ly85q9YP2DUBQE0a8Msx1hqNgsENC0ttJhISI9WMNVDcOpM?=
 =?us-ascii?Q?QuW++Rwp4MMchlHM4snGkmSmHct+XJf5Mn7bLjVPl9Z/eQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kUXLIahrdWGdcA/mko39Nyfvs3Vl/5cP9HzIkUdEdxnKG7iRuT67+PKoXbK3?=
 =?us-ascii?Q?5OhE7w58BvZIlHV71A/+kGf0gjqtM3hRaN1pZaAGR8X7uK/bRsagbYDt+SzA?=
 =?us-ascii?Q?FM9rq8Nr+FAD2fz4qWenpUlvcc19xN4OvHnbyP9FDYBW7Ilz9mqgSlHvH7Tu?=
 =?us-ascii?Q?o/xPBzOcQiTOluOBofEmcYyf8mn/ITBDd86MUg5daaPiHCoqrxPm/YW/IBya?=
 =?us-ascii?Q?wR+fwcoua3gLA99PAwukFpIzZxgnjQeaoqpcQxZHT4NF2phn617ibttdQGJG?=
 =?us-ascii?Q?Q042UccGF/sy+9TBQgySn8EXZISsd1EDIP9sB8LR1LHV7L6h0gdvM7CsqPoq?=
 =?us-ascii?Q?OEzU1480ZLrzWsSn4tKANyn/P4EWI2aYRU/shdiKYUt0QLG5ZLVHXUv+HtGs?=
 =?us-ascii?Q?1f/+g4jW8D7sQwqeSl2iJOS3nkZc6cg3qA5x0t1GjBfI8G1ZUICgy6Qman8W?=
 =?us-ascii?Q?1SWO16aUP5mzDUYl6fNMvi6A4jWsefAiRJhIRn+HIYKzB2JXFvUr/DKGlYcI?=
 =?us-ascii?Q?Qrm1d5nrxznrbNxInF+nz9S1uZmoRglU6HXvOGelB3DGTarIIe25dCpHZHsT?=
 =?us-ascii?Q?VOSOb9aTw5W1bTsJCvEGzqwG+WU36OWxJhrKBzkmY2TKH/+LK3I2i11TMXGf?=
 =?us-ascii?Q?rqy4tCUQXQ/gjxntq2RAqX294Pm1ImPKBz/1MOmpltc+SHdIy8qwjk5zrlKB?=
 =?us-ascii?Q?lXqDesYAY21Uxr6NED+me2Pne+vOxT+wKmL8CrjXoWB+V4poMbQOL+PCuqQQ?=
 =?us-ascii?Q?fNOzQlimp9P5QJnRnQJ1GuOtcyoGPZpgTQEtPKQrVWJP7yQBqqF/zJ1apKQd?=
 =?us-ascii?Q?nKZ9DH/z4OsG+TUGedIbYHEI20QiLyeDca+JkQ6xnjiPk0nn22TsW4BUbji0?=
 =?us-ascii?Q?wsFl/TCCdPF8TDZUYFRVQ/4//KT2A3tYlWhwsKcyXYT+sgG6PjFFtaMECCvt?=
 =?us-ascii?Q?xHedf/mcxOhuYXjzhm3Ci8fSDkuXVV2NQyReahKYX4qacBeAsxE4U8RzLpGN?=
 =?us-ascii?Q?098V2EWtyUI/CWoA2BfpqJFVY+/A6uOjo/l98ddYvmrCB2qIZ1SetZ5PF6gO?=
 =?us-ascii?Q?N9Qxt3zHgiXEFsx/+CDwVNtuEKIvzrKGCQf1qUrEMFSq6Vbl6lsTVN3GEUEP?=
 =?us-ascii?Q?nryFHujb0ApfxiOOBixai2dayXMheQqhdPl4qJR7aUFKZTSRap306JYBNq7k?=
 =?us-ascii?Q?xUCsubVBNh6eGQ1sN0oTt5LQhwxVxdJdmOoBrGvMy6gq4Lbe0HHhmZUdzybZ?=
 =?us-ascii?Q?xR8rLYV98f61+YEUnGtZCrGo4879uIlHWftmu9CKY4MmHDtIIf9Esgt7l6HB?=
 =?us-ascii?Q?ZvQyZy7RxKOrh3M4WUBPC6pO0SIrlKFKxOepmu0OQzRrux2oEDm2V+JzS0sY?=
 =?us-ascii?Q?rI0h9lfoQG+48/KjPaPOqOkpSxCxP7shQBxuoTjT+rFX8k06CAy5B7PNTgKp?=
 =?us-ascii?Q?4DjJpVTWrCVpshjg2O61wl9TKUrrAxN2JnzpfrFx4BmCDv17yvfzk+EM/Dcy?=
 =?us-ascii?Q?hDIP4CLMHrZ5UYk/mTK1nWs70bKULPPJrR689bEHdIzQpSixssD/VfSFk2D5?=
 =?us-ascii?Q?nZtoVjgl7Vyq0o+OF4wRuDnHIzh8utp1Io+LRvW+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe7daf77-a0ad-450c-482d-08dd0eb6d968
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 07:41:05.2854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9EkN1amca4E0NusZf97yW97DuVvQt7kEidV5Oc1eI8hCECTTXCnj4GeZnBuuprrSk+QxXkWURrZZkWRJM4kHEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5955

On Tue, Nov 26, 2024 at 06:35:16PM -0800, Yury Norov wrote:
> On Tue, Nov 26, 2024 at 10:56:40AM +0100, Andrea Righi wrote:
> > Using a single global idle mask can lead to inefficiencies and a lot of
> > stress on the cache coherency protocol on large systems with multiple
> > NUMA nodes, since all the CPUs can create a really intense read/write
> > activity on the single global cpumask.
> >
> > Therefore, split the global cpumask into multiple per-NUMA node cpumasks
> > to improve scalability and performance on large systems.
> >
> > The concept is that each cpumask will track only the idle CPUs within
> > its corresponding NUMA node, treating CPUs in other NUMA nodes as busy.
> > In this way concurrent access to the idle cpumask will be restricted
> > within each NUMA node.
> 
> This all is definitely a complication of the code. Have you any numbers to
> justify it?

I'll include some numbers in v2. For now I just wanted to send the patch
out to start some discussion. :)

> 
> > [Open issue]
> >
> > The scx_bpf_get_idle_cpu/smtmask() kfunc's, that are supposed to return
> > a single cpumask for all the CPUs, have been changed to report only the
> > cpumask of the current NUMA node (using the current CPU); this breaks
> > the old behavior, so it can potentially introduce regressions in some
> > scx schedulers.
> >
> > An alternative approach could be to construct a global cpumask
> > on-the-fly, but this could add significant overhead to ops.select_cpu()
> > for schedulers relying on these kfunc's. Additionally, it would be less
> > reliable than accessing the actual cpumasks, as the copy could quickly
> > become out of sync and not represent the actual idle state very well.
> >
> > Probably a better way to solve this issue is to introduce new kfunc's to
> > explicitly select specific per-NUMA cpumask and modify the scx
> > schedulers to transition to this new API, for example:
> >
> >   const struct cpumask *scx_bpf_get_idle_numa_cpumask(int node)
> >   const struct cpumask *scx_bpf_get_idle_numa_smtmask(int node)
> >
> > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> > ---
...
> > @@ -3156,39 +3186,48 @@ static bool test_and_clear_cpu_idle(int cpu)
> >        */
> >       if (sched_smt_active()) {
> >               const struct cpumask *smt = cpu_smt_mask(cpu);
> > +             struct cpumask *idle_smt = get_idle_smtmask(cpu);
> >
> >               /*
> >                * If offline, @cpu is not its own sibling and
> >                * scx_pick_idle_cpu() can get caught in an infinite loop as
> > -              * @cpu is never cleared from idle_masks.smt. Ensure that @cpu
> > -              * is eventually cleared.
> > +              * @cpu is never cleared from the idle SMT mask. Ensure that
> > +              * @cpu is eventually cleared.
> >                */
> > -             if (cpumask_intersects(smt, idle_masks.smt))
> > -                     cpumask_andnot(idle_masks.smt, idle_masks.smt, smt);
> > -             else if (cpumask_test_cpu(cpu, idle_masks.smt))
> > -                     __cpumask_clear_cpu(cpu, idle_masks.smt);
> > +             if (cpumask_intersects(smt, idle_smt))
> > +                     cpumask_andnot(idle_smt, idle_smt, smt);
> 
> cpumask_andnot() is a no-op if masks don't intersect.
> cpumask_intersects() is O(N), and you can safely drop it and
> save some cycles.
> 
> > +             else if (cpumask_test_cpu(cpu, idle_smt))
> > +                     __cpumask_clear_cpu(cpu, idle_smt);
> 
> Same here. If the CPU is clear, __cpumask_clear_cpu() is a no-op.
> I feel like you can just clear all that CPUs unconditionally. In
> the worst case, you'll clear them twice, which is harmless. Or I
> misunderstand something?

Yeah, makes sense to me, it definitely seems more efficient to just
clear the CPU. Thanks for noticing it.

> 
> >       }
> >  #endif
> > -     return cpumask_test_and_clear_cpu(cpu, idle_masks.cpu);
> > +     return cpumask_test_and_clear_cpu(cpu, get_idle_cpumask(cpu));
> >  }
> >
> >  static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags)
> >  {
> > -     int cpu;
> > +     int start = cpu_to_node(smp_processor_id());
> > +     int node, cnt, cpu;
> >
> >  retry:
> >       if (sched_smt_active()) {
> > -             cpu = cpumask_any_and_distribute(idle_masks.smt, cpus_allowed);
> > -             if (cpu < nr_cpu_ids)
> > -                     goto found;
> > +             for_each_node_state_from(node, N_ONLINE, start, cnt) {
> > +                     cpu = cpumask_any_and_distribute(idle_masks[node]->smt,
> > +                                                      cpus_allowed);
> 
> Nit: no need to break the line here.

Ok.

> 
> > +                     if (cpu < nr_cpu_ids)
> > +                             goto found;
> > +             }
> >
> >               if (flags & SCX_PICK_IDLE_CORE)
> >                       return -EBUSY;
> >       }
> >
> > -     cpu = cpumask_any_and_distribute(idle_masks.cpu, cpus_allowed);
> > -     if (cpu >= nr_cpu_ids)
> > -             return -EBUSY;
> > +     for_each_node_state_from(node, N_ONLINE, start, cnt) {
> > +             cpu = cpumask_any_and_distribute(idle_masks[node]->cpu,
> > +                                              cpus_allowed);
> > +             if (cpu < nr_cpu_ids)
> > +                     goto found;
> > +     }
> > +     return -EBUSY;
> >
> >  found:
> >       if (test_and_clear_cpu_idle(cpu))
> > @@ -3401,7 +3440,7 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
> >                * piled up on it even if there is an idle core elsewhere on
> >                * the system.
> >                */
> > -             if (!cpumask_empty(idle_masks.cpu) &&
> > +             if (!cpumask_empty(get_idle_cpumask(cpu)) &&
> >                   !(current->flags & PF_EXITING) &&
> >                   cpu_rq(cpu)->scx.local_dsq.nr == 0) {
> >                       if (cpumask_test_cpu(cpu, p->cpus_ptr))
> 
> cpumask_empty() is O(N), and the other checks are O(1). If you reorder
> them such that cpumask_empty() would be the last check, you can
> increase probability that you will not check it at all.

Ok.

> 
> > @@ -3417,7 +3456,7 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
> >               /*
> >                * Keep using @prev_cpu if it's part of a fully idle core.
> >                */
> > -             if (cpumask_test_cpu(prev_cpu, idle_masks.smt) &&
> > +             if (cpumask_test_cpu(prev_cpu, get_idle_smtmask(prev_cpu)) &&
> >                   test_and_clear_cpu_idle(prev_cpu)) {
> >                       cpu = prev_cpu;
> >                       goto cpu_found;
> > @@ -3560,12 +3599,18 @@ static void set_cpus_allowed_scx(struct task_struct *p,
> >
> >  static void reset_idle_masks(void)
> >  {
> > +     int node;
> > +
> >       /*
> >        * Consider all online cpus idle. Should converge to the actual state
> >        * quickly.
> >        */
> > -     cpumask_copy(idle_masks.cpu, cpu_online_mask);
> > -     cpumask_copy(idle_masks.smt, cpu_online_mask);
> > +     for_each_node_state(node, N_POSSIBLE) {
> > +             const struct cpumask *node_mask = cpumask_of_node(node);
> > +
> > +             cpumask_and(idle_masks[node]->cpu, cpu_online_mask, node_mask);
> > +             cpumask_and(idle_masks[node]->smt, cpu_online_mask, node_mask);
> 
> cpumask_copy(idle_masks[node]->smt, idle_masks[node]->cpu)
> 

Ok.

> > +     }
> >  }
> >
> >  void __scx_update_idle(struct rq *rq, bool idle)
> > @@ -3579,13 +3624,15 @@ void __scx_update_idle(struct rq *rq, bool idle)
> >       }
> >
> >       if (idle)
> > -             cpumask_set_cpu(cpu, idle_masks.cpu);
> > +             cpumask_set_cpu(cpu, get_idle_cpumask(cpu));
> >       else
> > -             cpumask_clear_cpu(cpu, idle_masks.cpu);
> > +             cpumask_clear_cpu(cpu, get_idle_cpumask(cpu));
> 
> assign_cpu(cpu, get_idle_cpumask(cpu), idle)

Ok.

> 
> Thanks,
> Yury

Thanks for the review! Will include all these changes in v2.

-Andrea

