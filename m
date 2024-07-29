Return-Path: <linux-kernel+bounces-265017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A795293EB49
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 04:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DB31280E69
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 02:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCD778C68;
	Mon, 29 Jul 2024 02:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JeAc9GLw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177F11B86D6
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 02:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722220133; cv=fail; b=pQDIyxM/0bZONumUvTVeIxY/XkgvijEGPKV10lA7CQiqicimg0ajU/b8Zg6sC7O7/Fy1kd0i3WVbmtX5WaZsRZsOcvyVATZzzjY4z6TNLrUF9I9gREkVxFV6w7auz0QI2pkjK1JvXmo4o3wQ3VPIvGh/sv+GkYqIS7Y5fTryBPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722220133; c=relaxed/simple;
	bh=a3iI8U6y/cYp1ue5D9wTl43ZEDl6oDpA0X1Rw+RxXvI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=skebkLUxoY5Dgtr5b6SCms7hnhZIKPAmbnaDq3hZSWV5mNeweZvYY0mxZdP+42FV7fvCwQ66cpFX+zxxHemylZbP83+g0mwTOXfSYtNUsVxUIsBMI1pDpt8GaCcSFDAZMCH20TcwgDdaGmRnGvuAKHWbQUJLsEwFkjPEBMlKSow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JeAc9GLw; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722220131; x=1753756131;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=a3iI8U6y/cYp1ue5D9wTl43ZEDl6oDpA0X1Rw+RxXvI=;
  b=JeAc9GLwnsxgNiq5338WgLf+yAICQiPuSYK69jXM/4mv5GOqNQboPh8f
   U+b8ICGW460v5HPu3xEjJZoj+1JMGs+eEsS41sgnOAyWk2Qed+CkrUQcQ
   eqobD5fuhrhMvHtEE2oCLiFv1u/hn3IoSBY1FWha3ZdsiMkxzmyltlUxt
   rLQ6vT5wE4NXByfE6ZsH399uIasCHnt9CUoNy/G610TNOnqVE0Qb7poOV
   BtDPRhrE5/k5Gig/bEqzyExiqXVGPQ7MzMJ51bwm3895mnpo6Q7KgDOfg
   eVpSL8mBxCTVukb+rHkioTXG6WHh/dPdM4wM48+YadCQXfruFFNKH7JgV
   w==;
X-CSE-ConnectionGUID: /LLr9SKtTi2l2UD0hh9+SQ==
X-CSE-MsgGUID: 0gb1a88NRiSMja91Xm10lA==
X-IronPort-AV: E=McAfee;i="6700,10204,11147"; a="19548377"
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="19548377"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2024 19:28:50 -0700
X-CSE-ConnectionGUID: JyXbkOOcQhORD39omZ8ACA==
X-CSE-MsgGUID: IzqiCsOeSsav0E/Z0XDY6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="77063547"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Jul 2024 19:28:50 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 28 Jul 2024 19:28:49 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 28 Jul 2024 19:28:49 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 28 Jul 2024 19:28:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zb9N2lUrdClPEbz27nSLcGI4ERHOs3kKIvZ0+7K7GGSLjabLfWo+Tbd5kgRxFXYYc6H37r5N0Q6q5ek9lMRtf/2JhH7dI/pI48DE9kt19eRYESAsVX8MT3WfuoSLW7sXPYr96/9CPFpKzs5eh8AXdM/ufkZCjRFcRlcIG14cPOqpsTWTDwbQy7ThPL3CpMJgow+QjvlOPjshFqOKH50rkWKFlTvJXdVHXhIOV4Wv2hF9G6dkSjlpH/8RNVMkzdojV3WDpLyCIKS8bmqIVpzm6cj4KxGGshEX6QhCiuGiJPoLs07UYHTr/3kl12PbNuFZKdn18vFh/hJYPtgBgpvX5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8lT7d5stwEDJzxY22xdD7b5ITJXASm7vNduaB4HGzeM=;
 b=ceKzhygz5zCkx8tE53fKqxD8DWV/DgbOtrjwuv8TI6c1uZ/lw/3nEi0CrXvS0AyGjh+L+aPBb9FOXiEo+DwEI6l9GDdlaqGM2r1nSPZ4xFyNbv+wZ4G5VDpeFtp+55mkHdm94iAVktb/1CAoeUlAQty2inBx8CE1i558ES5KlRhCWPJnh8BVCsH7wMzaX8m6RGPEB4UU8W78NrYeHhTOt7ka89ua841/zsRI01D+8n/OItiuTzKffMqMDpmGGESluhiL5Bje1mI581HM4UgD2eYQLyyffjV8dEHkOB//6gX+WWuE2deDFvCxpAXxBTH0X+QZ7N5d+zcobOf7IdVyIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 SJ2PR11MB7574.namprd11.prod.outlook.com (2603:10b6:a03:4ca::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 02:28:41 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%4]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 02:28:41 +0000
Date: Mon, 29 Jul 2024 10:28:29 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Qais Yousef <qyousef@layalina.io>
CC: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Hongyan Xia
	<hongyan.xia2@arm.com>, Lukasz Luba <lukasz.luba@arm.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] sched/pelt: Use rq_clock_task() for hw_pressure
Message-ID: <Zqb+TeV1AaQSFMp8@chenyu5-mobl2>
References: <20240725150820.376623-1-yu.c.chen@intel.com>
 <20240728201028.oylcxv3rwuihqugq@airbuntu>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240728201028.oylcxv3rwuihqugq@airbuntu>
X-ClientProxiedBy: SI2PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:4:195::11) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|SJ2PR11MB7574:EE_
X-MS-Office365-Filtering-Correlation-Id: 7018b2c0-59be-41b5-97ac-08dcaf762968
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Es39t3fGkUpgDf+7peCc+jxobNeo3VuGLXOss83gKfcF9+F83ugfxU9u22Zh?=
 =?us-ascii?Q?Af22Z4KMcn0JE1CtbrPBDzUOfDDgxSyXkGrjHwQSnz1Nwl0OULJLHhbUePMK?=
 =?us-ascii?Q?S4lpXgbe6X8nOQwZugtBWgWrs61uPHC/rBneCmPk7V7BA1Phyb20PDuOYR5l?=
 =?us-ascii?Q?vJNs3QFufkGVMN+d7VIv5zAg+e2i9nzm8kQTw67M+NC/elL2FezgnbOs2ZZY?=
 =?us-ascii?Q?fFNJdo+sSi9z1+9FVxkIHhRRaDVrz/B29tPIu7vn0nAheaXhUUYX5ynIrGr/?=
 =?us-ascii?Q?96hzDJN8ZNzC7N4uJCFFrYB7NyOkLTVsggMSIJIReFPfKucdswj7srx6T26Y?=
 =?us-ascii?Q?QJmumkX8yD4KjtI9CuOJELbHyRJc8FxFnbLMws5uM7WaAaCh0LxFDDC73GIj?=
 =?us-ascii?Q?jgKW1sD1vYk9v8AGnb0e81F48rBFrAWvmWd4vTCLmalLMNV636pzYr7MqwOM?=
 =?us-ascii?Q?fyV9hprtimDIrAFcyP14PlUTwp1JnUlGULPXkFEGTQzPmyRwfXJ/BJZwb7SZ?=
 =?us-ascii?Q?m6UyaMbOQ7+XIAVj5Yt4FE8D3RaTMgZKSJNsA2e//TVM0muMHkdq2LJRqDjN?=
 =?us-ascii?Q?6ryOUWwCcRMzZhS+BDHsvYpyfevYa/GSC7q67iw8Ck6kX/qQt3jP0LwkaLx0?=
 =?us-ascii?Q?EFBbZAmOCc9JexLfoUzwQmMmMQwzfxKhmDQoohuVy1cCQ+f4hEqiPmwi8iKt?=
 =?us-ascii?Q?mCjvZp54SRHXpTvNFMLO6et/cYk9Ntbyykge0fmeqiwcDfLzcHWCgD2qNquq?=
 =?us-ascii?Q?DrdFevY/CdLc7teK4w+OFPH2YjrrlRWMgsV0yvkhRWGKxTahWoPxMebqpZS2?=
 =?us-ascii?Q?h667M3Nz6i0wpJbYXuJg/dagx6MhvaekO4iY+PR7lcZ/SprtZOAEhIh2UXCq?=
 =?us-ascii?Q?Qk/I9CtY4oa/fKIIQztICqLhyasaM4LBtm6Rt6UEQJ50TqIKUFS16BEK5gox?=
 =?us-ascii?Q?H+JC0mJeyZ7TPs4rRGOqIOpy3tyto45BtFAxgu/GXkh6n5QBeJ7+STbMGw8E?=
 =?us-ascii?Q?5yjZz0gZR1kdp8/U6aW7uFp8uneDMaRhf8AUHnfxuiScBukOZcVZrACU52V8?=
 =?us-ascii?Q?ABMkc7qkk9rkuXgJHao9FVjbdQbditRXpkT1nvMxI8aLKjTL5nWML2Tl81Iw?=
 =?us-ascii?Q?KxA18wCFqpwTYBaDZzTD5RPWQ/6MEJ71pq+KnuqWLnA8LO+sdqWJVSh1+1lk?=
 =?us-ascii?Q?+ksZ6TkVFmBCw26k42DftzcZEpFN+3oKR+JU/BOEUYqmjjjIx4/rtI8aquAn?=
 =?us-ascii?Q?48gZ0kehQcni94gIYgHNuL5A3+aq+ojI3V8FE7mIql3O9SjdHF032zMctLdD?=
 =?us-ascii?Q?GZ6OXO7IjVf73CnM2+f26zVvlf2L3kZuVLiYDVGnc5F0WQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Cs7IO2T8DOvOU92xZW20S4h1gS9YWl1z0oHoUJVgzmZtcCqrF4VUCdt99TQD?=
 =?us-ascii?Q?7jSMarZAjX/GH33Ethr256A4YTNlt1h8ysaYN1a6G1Di2QnWsH+1HISIAQYt?=
 =?us-ascii?Q?6aB+t6cvr9JPOnOAsk7Jo8DcD1J/0BMo+vD/qQUkQQ7tarBXkZfDro8R/POU?=
 =?us-ascii?Q?hQbG5dnoIEkwdN2KzkBRE587dK6Kc/n/P42LORx9sQSxDkIvE+6crzOodCZe?=
 =?us-ascii?Q?vZYhG3HeI2IuTUqrS/8qWA+H1M6vgwmwwjrNrpPKQmJU3a/BEno4Kd/Ze1IP?=
 =?us-ascii?Q?dEOFj3Xoxwp8eVE1hkLDHpTDdC6WMed6/wCUWXc4lDLLbcC+tLNG0SkFUZJd?=
 =?us-ascii?Q?noKL7jQvjLWhbNFnn6BT/3HRCoydirnA2TB1OrgjTVnwA2FDyajIw1jfV113?=
 =?us-ascii?Q?adplMpaV+yEOI0z2oB7WdsFfCDqRAv3GvJ9+4RzJgBRYko6YKtKgXj7kAnEj?=
 =?us-ascii?Q?8QPl+tOc8yA0Ob81alz5XMwp01/wFfUp8ysjbgZ/4C7ZwoJiPcqdHwJBg8Zj?=
 =?us-ascii?Q?PgqChmY4bzElizJPas1oNKq8OEyrcaXwH+WO5mt2KBzLZhkzqY931+jATfjB?=
 =?us-ascii?Q?OspNtsn1MqVGJzi7ZlgQcgJZMsdHpVAmYxlxsoT9J3Sm1PRSJZ5cKmIu96hc?=
 =?us-ascii?Q?peSHjkLETjnLuOZkJDd5d8u5is/R71Z5YTyFZ25NllFoFd2qrcVViLMGLfad?=
 =?us-ascii?Q?AkXHO1QMjJ0A8LyA+FrJN9YPaIjZ2CY7wqbtDdp8Fu/e8CY4FN/JuRypTchY?=
 =?us-ascii?Q?wd5Xi85Q3CYiwLuDtOg3zsGLCunqoo5m7mEa5NFLvE4G4Vrt0juyBsfnHK3D?=
 =?us-ascii?Q?Ls6k0FNOmlD8Ndzh8O21pe8B62xsILmLSNU3g0xhQUynjwJpcshWyxZKw1mE?=
 =?us-ascii?Q?sRm+gtQJXGpA9J779Xahnlkd+n+E7w+uq+qzwdF6saEFOd1FW85m6gF+l6hS?=
 =?us-ascii?Q?ShQINwVHi4PcjFoyg9ABlgPX7Q+/TbdLck3k5sxwDvlaP7CW8gUkTo6v5kuh?=
 =?us-ascii?Q?wT/iGMfmbzjrX0PJj+3iQpfoLPZvPPq2QX4P1xmGEY/tUwmxo+lMqZtKzrNI?=
 =?us-ascii?Q?fcL9thZxu23s0OGqceUbNgXfvnDH7StqAwY2C3/6ocGnxBenvNqMjH9iiYmm?=
 =?us-ascii?Q?9CqRytLMztu9iYl4yez6ZX5DPj4u/z1bt2TqzMYE4zDOy8CQ1IfvHaSph/P0?=
 =?us-ascii?Q?2Xmht2AoLPqKowf/s+clwK+IAMznQH/mrxG7C0ZiS65vW5pLkz3L0YgbgDnH?=
 =?us-ascii?Q?YK7Pukca6hLlszQks5yNKr6eEFdQkrdrPZIU3hirXffOAqoK6hgDE4jMy44b?=
 =?us-ascii?Q?Q87KqK32eMh1D2yIO8Mv/kSi/BZ09zd0IB7Yap0GlfuetcTAxiP746crGxz5?=
 =?us-ascii?Q?Lh400PGRVAuUmwRfja/A8K7boDrWpR+A81y5dUUEShmqeQ4xoevvW1EWuqOL?=
 =?us-ascii?Q?6Opeu8ARY+nNVEWiW8rofkNHhQExb9vgfmTTCvTklFulXwCaa9tsI7/Th5tS?=
 =?us-ascii?Q?JCLPwkpgNFUnQ9je/o+5QleSOotX/0Ix2Jtzm6ysZLa0tjV9vKHdXsD4KjOA?=
 =?us-ascii?Q?pRDrEw1C1E2/K3bLdrIrWFk1/LGwn9NmBOTsrUcr?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7018b2c0-59be-41b5-97ac-08dcaf762968
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 02:28:41.6551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CslDiVh7uOEE7GHuXwt4qpAuVUOygg1utOAF9ID+dFBLbCrOhylDFHLBRo0DXbD0N06qwtmEFPfS82HrKMjq4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7574
X-OriginatorOrg: intel.com

Hi Qais,

thanks for taking a look,

On 2024-07-28 at 21:10:28 +0100, Qais Yousef wrote:
> On 07/25/24 23:08, Chen Yu wrote:
> > commit 97450eb90965 ("sched/pelt: Remove shift of thermal clock")
> > removed the decay_shift for hw_pressure. This commit uses the
> > sched_clock_task() in sched_tick() while it replaces the
> > sched_clock_task() with rq_clock_pelt() in __update_blocked_others().
> > This could bring inconsistence. One possible scenario I can think of
> > is in ___update_load_sum():
> > 
> > u64 delta = now - sa->last_update_time
> > 
> > 'now' could be calculated by rq_clock_pelt() from
> > __update_blocked_others(), and last_update_time was calculated by
> > rq_clock_task() previously from sched_tick(). Usually the former
> > chases after the latter, it cause a very large 'delta' and brings
> > unexpected behavior.
> > 
> > Fixes: 97450eb90965 ("sched/pelt: Remove shift of thermal clock")
> > Reviewed-by: Hongyan Xia <hongyan.xia2@arm.com>
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > ---
> > v1->v2:
> >   Added Hongyan's Reviewed-by tag.
> >   Removed the Reported-by/Closes tags because they are not related
> >   to this fix.(Hongyan Xia)
> > ---
> >  kernel/sched/fair.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 9057584ec06d..cfd4755954fd 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -9362,7 +9362,7 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
> >  
> >  	decayed = update_rt_rq_load_avg(now, rq, curr_class == &rt_sched_class) |
> >  		  update_dl_rq_load_avg(now, rq, curr_class == &dl_sched_class) |
> > -		  update_hw_load_avg(now, rq, hw_pressure) |
> > +		  update_hw_load_avg(rq_clock_task(rq), rq, hw_pressure) |
> 
> NIT:
> 
> Wouldn't it be better to remove 'now' and call rq_clock_task() inside
> update_hw_load_avg()? Adding a comment on why we should use this not clock_pelt
> would be helpful too. hw_pressure doesn't care about invariance.
>

OK, will do in the next version.
 
> ie:
> 
> update_hw_load_avg(rq, hw_pressure)
> {
> }
> 
> LGTM anyway. I think this is called most of the time from idle when clock_pelt
> is synced with clock_task. So the impact is low, I believe.
>

Yes, when the current task is found to be idle, clock_pelt is synced with
clock_task by update_rq_clock(). While a case is that, in the softirq load balance,
sched_balance_softirq()->sched_balance_update_blocked_averages()->__update_blocked_others()
->update_hw_load_avg() is not always called by the idle task, and clock_pelt has not been
synced with clock_task yet.

thanks,
Chenyu

