Return-Path: <linux-kernel+bounces-273540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF80946A61
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 17:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0BEA1F216FF
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 15:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32C71509A0;
	Sat,  3 Aug 2024 15:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dlcxuo07"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399864964E
	for <linux-kernel@vger.kernel.org>; Sat,  3 Aug 2024 15:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722699186; cv=fail; b=DFgYUOSmGxai+6j8AtFkSXgLHv2n8Qth0bh9OUjgalKreOGOpfxVv+wq2zo45bt59tQDTnol/DswXCBxE6riTrNK02/IU3LGSIv1gE93wQLFUVXtNFJb1Q/oEWNa49nZ4s/Uk5dh7ulWAGtHu6fqZ4TfGKLPAY+OdDWqTyS50Zs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722699186; c=relaxed/simple;
	bh=skz4U2v7DIBwWXwQIGTC0Z0oAtvYKBlQXjCVSG6ko80=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p8rN/+zHoLqbfAIjhInQKw355gXliGpadaB8RCUr82uVMqAdaRGfCrPpY+vkNR8zv3SI3tGWxPUXRF2NWQfsNmOeBJUfCGRcaI/y0Ai3WJaabODoO/bfWEJsnV/au54hEy1oaeev0YMbwv/5pNKohYuTLDTWe5nAthJgZT+0ftw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dlcxuo07; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722699185; x=1754235185;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=skz4U2v7DIBwWXwQIGTC0Z0oAtvYKBlQXjCVSG6ko80=;
  b=Dlcxuo07K5yBMVsPwx5s8z5wTXSwOwcVoukvrAupM10tkKEqYqFwCxLy
   byeTNuuAhtxgwKqhQBA/FGu8xbwiEE2NDTGpYzGMKlLFGZy7TyfIoPQSn
   EhvfWeP0rR1TEOJHAYCxS0MFggTZFbfp6VRsOjM1kcawqgRe70wGE8/WB
   Jmp6JpiEmISglp4ud5ohySo7xVhVg4P3kW4fgR8m9lE+Yx4N+sFmC1S5B
   NPZVsPNb24Zhx39tEldQgoSC2O3rD7LReplc2DBwBAKh3S7Gkr9aJQXgj
   SdPFub7GetXJL4fqlak8wkuUaJUwJZhtDGTjnsX7Ybc5BoxuXcwA0mP1y
   g==;
X-CSE-ConnectionGUID: U3H7AAT5T3moE0xSZbQJ1g==
X-CSE-MsgGUID: 8LEO5q4nRF2Pu0/Xz5IVcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11153"; a="20842813"
X-IronPort-AV: E=Sophos;i="6.09,260,1716274800"; 
   d="scan'208";a="20842813"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2024 08:33:04 -0700
X-CSE-ConnectionGUID: JT8wqW4XQeSWHtyu7b/tvg==
X-CSE-MsgGUID: YSWaF7fxTxSm3k5oBo9AJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,260,1716274800"; 
   d="scan'208";a="59867968"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Aug 2024 08:33:03 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 3 Aug 2024 08:33:02 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 3 Aug 2024 08:33:02 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 3 Aug 2024 08:33:02 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 3 Aug 2024 08:33:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Auhk8CLl47FCyroB96qUhKK6jMmGsflpCltVspQE/36TpKiBsapiPM5muOmziJ1kkNnwaJe2Qz3PCeWG4iH2UfCVRcPz3k/erIr3htnd/ADKKZ5A7UuuSLX66jlloZ3/vBve1oGfa13pSXUSnnhc4GRyj44tfcARsgJu4KdjN3EcLiJaQ7kN5Nf1AAr6AXA0xCb2i66okpAnVV2zH2+2n5mMo0FpTIgVx6cWSoDY0DY1XtvXl+fcFLLJ1Qsu24SBuwCmrj9Er/He5fu2t7KIT93rjiUf2njo7U32yTY9y6BvbqEhKiTUu1JwhduE8FeBm2KmAmpdv5KhwturnmhmBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JzzijXkiPfDZdlVDTdMLa2s0k9zXI5C2oPwlYQdMK1A=;
 b=WWpREa2uzhHrA4MYs29LxYFm1gcDEFL2OeYeVn80NgLcJCwyrdLzr9gMjsLqsoFsNOxw97/H+d++7MkhVMuyhtwzwpZU+kUBAy9KNLgi20ZgkYlOi4Ig8/eRFQYuoEDV+dNAJ4V9jbPXxEyfW83k82+XxVHjO2XJdi//rTZ2r/tHz66cKeJtutVL6fmODw6LTuGvVAmYkMvCV2CYsSe3mAE8v96HW9cxpF6/22BFkFPEpCOwESFtXakA8PMGJyOv9p12E6GY/RrnQxLfiCDLdOvEqpJ7attU3BpJUhRtU//Tik01v6V8BvUZjFuI15SzuhEvTzPh3PJ3Cf8d8HIdbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 IA0PR11MB7211.namprd11.prod.outlook.com (2603:10b6:208:43f::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.25; Sat, 3 Aug 2024 15:33:00 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%4]) with mapi id 15.20.7828.024; Sat, 3 Aug 2024
 15:32:59 +0000
Date: Sat, 3 Aug 2024 23:32:39 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Yury Norov <yury.norov@gmail.com>
CC: <linux-kernel@vger.kernel.org>, Christophe JAILLET
	<christophe.jaillet@wanadoo.fr>, Leonardo Bras <leobras@redhat.com>, "Ingo
 Molnar" <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
	<juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH 1/2] sched/topology: pre-compute topology_span_sane()
 loop params
Message-ID: <Zq5Nl5gBuT5Y8S8N@chenyu5-mobl2>
References: <20240802175750.1152788-1-yury.norov@gmail.com>
 <20240802175750.1152788-2-yury.norov@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240802175750.1152788-2-yury.norov@gmail.com>
X-ClientProxiedBy: SG2P153CA0042.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::11)
 To DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|IA0PR11MB7211:EE_
X-MS-Office365-Filtering-Correlation-Id: 5811f534-d8af-42f3-c1fd-08dcb3d18e3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FjB1Kgr7Pu2njoW49vZTZXo2/+Zt0tlPVXGtZUlez2I0VaMptU8mpdjPIBvC?=
 =?us-ascii?Q?aWQUzTshmVVew+3DaV1XpIbE2koI18xvROMczVUJPjs467MJKeV2YwNjcnbs?=
 =?us-ascii?Q?paLyLg0cNNOH0qgomCVSco8BGuohRZVZkx8rKzw6mU5t+jIig363vp3+DJMz?=
 =?us-ascii?Q?T5N5Y7LlbdTBkdxzob3huNw8QSBVwb9qm0FnY6qfm09mB0lPSWIIZ92hn+lu?=
 =?us-ascii?Q?tCFgJ7Rsfvsp+LB1goSxdkC9hs6pD2StNnuCNrdLYz0ygbL3SgRxHQ6MbJgE?=
 =?us-ascii?Q?GW9gtMFokr1GpTsyLuCS4ClqSt/Cnr/7XjVbatBtaFTAUjy7Mv2jj4Ez5PJD?=
 =?us-ascii?Q?7cpVsSGiM4nizaJA5ZVZZ9vna55254y32eFQK5oaci3Eu9oCNcjrfl1/FRYJ?=
 =?us-ascii?Q?NjCOPLIVl+HKdYVhy3DFQDcLzaSn345wicpKQ6D0eWIqZA3Rb0HufjlwrwiY?=
 =?us-ascii?Q?KV/mYYMy5qJ4j1oMkJvQNLXN3Fb1hXLHmWUXGx7RUKdGwdKcDt4xMBQ9rX3M?=
 =?us-ascii?Q?R7DTt3DZ/cSx9q4afr8gTqsCHl7cBoY0OF+urePuHlJ1xVSJC8SPALnh8dbL?=
 =?us-ascii?Q?wVqY/ld0GbD2TPIVZvCoLLUN3BlRCYSSKpF8IOaXc1Alb7Gj2aZoUuK5LW2A?=
 =?us-ascii?Q?CFtl/JB19UGrUUE8Sgev9/v1YRXbAz69hadzH+fbhXDXxSleuVt0B/35abq/?=
 =?us-ascii?Q?2Jh1IFXiwgNjUdWF2i3Z0EjorR6EcImIWlXItFy+KVRJwDR+l0aJqHFYmm+F?=
 =?us-ascii?Q?slA0QOVks7f3uH/J7HswE6B5FOk9SuW8bSeFPTu/Y46vd6BswGhFHpj9tQV+?=
 =?us-ascii?Q?LOQyApSqCnv0FOuUuKCs4Pbd8fHN0JH61vCCPOj/1pM1E3o9IdFbom7UXTdh?=
 =?us-ascii?Q?UWLQMoR7qYmSzcbI0s3OUAlmB5jocFkQsWDGc4+QBKoN7H8gRNccAsbOJpA3?=
 =?us-ascii?Q?svMTbaCYbRA185c7/YfHl4fR8wayzK+kzSiVmShdww90p3R476qTltNPNFvy?=
 =?us-ascii?Q?Be4oRovWnvd9LZLms2H6xhFLVrzASZyGp2Q4MxuSlb32t2pXuDHS3hWh2rWf?=
 =?us-ascii?Q?gYgYRn6rmY63hUKnIeaKepuiI8pmCymP1cD7JsnrZ2nyZgxBRAfSjPsX7BXX?=
 =?us-ascii?Q?rMqkv5r/cInv2V/Yr5qols8e8cLRVKI2p/P3KvK3Q34TPmq7+F4pc/or0Rxk?=
 =?us-ascii?Q?Gn0TNTPJw7w8f8CcH/wC2Kjf5Bgl0gbJwE/zjPVs9TN4bGenrojHB6Hn/4yX?=
 =?us-ascii?Q?uuAM7NvT+QcoGEDOTuqHAtNjRnrws+wOATYVEij7U7ZfqX9z3AWITRAKMraP?=
 =?us-ascii?Q?O1+lt9hHdLw7ZjS+a8SJVgOJ5re2T9PTwle4ArwloLvfbA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bHKQxD2NHjJdK5OLU1n/dKCTLrIOEWHtn4abBV+4PL1JoBNZTlTnqrGR5XL6?=
 =?us-ascii?Q?X+TsCEVJ20kL1yQEqde22A6TavAsC7/tV6M30SCD4XT27KfKTRjBurGW9g41?=
 =?us-ascii?Q?ofrSqyzm1Rxs13I/78oLxAu+QSMb0+P30uL3Z5dmdwHkcJE/scHfoyGCTFeN?=
 =?us-ascii?Q?CV5PoHs8zcw13BHDZBnWYajYqTWYlyOJvMAv8P46+c9TDTzmGTElJA9K4OmC?=
 =?us-ascii?Q?Z0H0TK/egmApDogCYRVwxXkdPqbT2b6tDuMmZRjO9yoFcjHueK56fG1JenkE?=
 =?us-ascii?Q?W5AuVd/3/0NxCWzyAwB+cuN0/itrFuTWi1lJllK1yd4Wu5z1SoGWcq+4HOPf?=
 =?us-ascii?Q?j+h8atkv1/iAO3QRnlR7gHgG2xDG3leaONO1linSpW1qFoKorvY0dL2O2lmJ?=
 =?us-ascii?Q?JivLapBD5yaznz48vXBY1RTCVzWAWSgXsEvubCqnnVxqWCkb17PXKEd7oWja?=
 =?us-ascii?Q?8DjKkQWliO1Qm/A5wvYbi4P8T8wgreeR83gCinyWxGYUyLaaJFPiM1hHZt9m?=
 =?us-ascii?Q?bQTQtviDJ1tB110wrJVMDq6OoAUVXra1s9igNSeuaBIBjq1jAMY1913o8YoU?=
 =?us-ascii?Q?z5ITmjsnFQYSx9TR23s+IkQYb7yoGkEJugwqlDw9w8qQDAxuHFSFQHivgXnE?=
 =?us-ascii?Q?VNv3Y8SMOsWWI31hYQ3MpAHJRUj4MN2rGEbOcLiPWFxtq7a1pnafF+mogy18?=
 =?us-ascii?Q?SQxBGebDIpftaSxTHou5eq0p3Y7244lGSWas5vcP0zBO0LPwG4Qr1uUo0Cm9?=
 =?us-ascii?Q?krMgu9gPCEhTi/6mrivUxKD9I1G8DXJRKOGa4nu5RIKC4T4oIxKtT5eB0h9b?=
 =?us-ascii?Q?+MFB8VINxj913CwoQXboZC6AMcRag26djHnDl4MD7JK3UQ3EnLcW5O26R3Hx?=
 =?us-ascii?Q?soACgn1bdZmxvaRXRZZ1fURZdfpBneJueLu/s/nQZHGPPdnaeKr8it7olc9V?=
 =?us-ascii?Q?rd5eLOEPap04SK9a4V6F3bhBniOJTwD4r8xUH0ufP0sTMhIUzQiefRsyNVxF?=
 =?us-ascii?Q?LpfdR0C20TxQtRFE7i8w10p1fNp3Y1j/ihWtwxmffiIZ+zHpfx2l3qIqw3Ad?=
 =?us-ascii?Q?OdDfdxcxcwBLpEgTzd+mE7aatJCmyLWGeqIW7VVJCwS3woEBj/qjqxnl98Jm?=
 =?us-ascii?Q?A6viGONQXkWziuedj2P20wpsF0D8QzikGiF0gB8O1ZjtCcBQpyA72v7dbUa6?=
 =?us-ascii?Q?u43T7xjIuzP3qe28YrWjTkAKeksR9kF8nNTLer3x5ggQxRhMQqU25+wQWA7U?=
 =?us-ascii?Q?Ozh1bSSr4DXEq0IoX+WCECVxAWyV4/V4Hz3m9gtY/rQYq92WSnkSmd/TjtzV?=
 =?us-ascii?Q?M9Yiq49ZxlzpUEUDMgI6fTBkptwT1ZftFcSxTm8a95SnC9nFeGnjhcjBLwbY?=
 =?us-ascii?Q?WXEkaMIpWQyL65WMYavAub1rPwb6nTvgW0arpdJ32xITqQNZDGq1l0BchWUQ?=
 =?us-ascii?Q?ggEra/iDdysYx4qNgopxiLRYSxKUrra427LN33lQMYlrhFTiLljrc380ezLC?=
 =?us-ascii?Q?UYfZnK1a8CaN1YIOQgxcu3GLlxcSb51VY+eyDXCU7ahtNwb/VUJptlFibGeO?=
 =?us-ascii?Q?bjY/Ogn2OeAWjGkVa/34KLWPIuWh5iagoJL2qUBX?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5811f534-d8af-42f3-c1fd-08dcb3d18e3c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2024 15:32:59.7587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EOCdqTKWjpvEO8kWGbD4vbIHUKqd4iP6VpiCYLluiPTkjl/elkVlbp36xjFInCzDIlsfywlhax/2UBJtwgXfDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7211
X-OriginatorOrg: intel.com

On 2024-08-02 at 10:57:42 -0700, Yury Norov wrote:
> tl->mask(cpu) is used unchanged in the loop, and tl->mask(i) in worst
> case may be calculated twice as parameters for cpumask_equal() and
> cpumask_intersects(). So, precalculate both.
> 
> Suggested-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Suggested-by: Leonardo Bras <leobras@redhat.com>
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  kernel/sched/topology.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 76504b776d03..754ad5fa3c99 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -2353,6 +2353,7 @@ static struct sched_domain *build_sched_domain(struct sched_domain_topology_leve
>  static bool topology_span_sane(struct sched_domain_topology_level *tl,
>  			      const struct cpumask *cpu_map, int cpu)
>  {
> +	const struct cpumask *mi, *mc = tl->mask(cpu);

Could it avoid the calculation by putting
mc = tl->mask(cpu) after the
if (tl->flags & SDTL_OVERLAP)?

Other than that,

Reviewed-by: Chen Yu <yu.c.chen@intel.com>

thanks,
Chenyu

