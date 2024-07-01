Return-Path: <linux-kernel+bounces-236499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C832091E306
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E24A286551
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208F116C6AB;
	Mon,  1 Jul 2024 14:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PCwfLXBl"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A5716C6AC
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 14:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719845853; cv=fail; b=XvJwMZbj+b4/ym9LNzFYlsgisB2PI5KdxEkCI1ag30GdFeLowQbc8r6WdE4O7lttf8HnqlUtKlX9uc/lJ1WYnWz2AKzbmbalNU7KVnXjUY9nSzy3Qh1tmJVSXLuiAKZvZ68R91nzbJPncfUUgWRyorHFBWE7mzyKxkDbHVkUE7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719845853; c=relaxed/simple;
	bh=ii0YHt++P01LvMJ82tfHiGMEomSULpwNYLmT80H+CQA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EDYyQRqXH7a6Rf0Cqbr5Unxr/LM9R0+i/IZtcB4vbD6xaEJKpvDvcUSh4KWoM/b5iyjFbygckx66+6h3FiHTGQg/PYdYlAfRgPps9seXf1t6ZHuuHHItfvY9fG/fqsC0LVyFMbXVp1knXePBulXyTsUGAysIh7zzxDZZfC3Euqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PCwfLXBl; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719845852; x=1751381852;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=ii0YHt++P01LvMJ82tfHiGMEomSULpwNYLmT80H+CQA=;
  b=PCwfLXBlUMXU37vWWIVyjEvT1PwKWsNsoaG9IIsUcrqmkVxQUIQhFD6t
   +Ye3vaneKyzIXjmgPrU5CS3CO0xPpnCdJNGmGretVPYMDs1kGbryRc51g
   Z8MgXw4yAr0bTeT81rV1qAk/cH1MKSbSc5jpzw4RwgPDLsorw/rv4HgOr
   oWAMa+3N/wzovyf918XDmZW1gLIbCUm9/MU8LglZ2aSooHwPNgSV3PpJ3
   KRWn42pFLwQQ56kANuQugSdQ/arNz1gTYuma+759mCc7pdATv+EEQevJw
   4OESoBJaIePCoFfrrZ7CzJ4GTBuWItTzuHz+sUPV7jCrCmKBtDAJZ5O3O
   A==;
X-CSE-ConnectionGUID: FVvPxkmoTYG0uwQHtYbFyQ==
X-CSE-MsgGUID: N9llxUG9SpmLBWUVeKEoBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="20792177"
X-IronPort-AV: E=Sophos;i="6.09,176,1716274800"; 
   d="scan'208";a="20792177"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 07:57:31 -0700
X-CSE-ConnectionGUID: x7NyW2MER1OoGAzHl3klRQ==
X-CSE-MsgGUID: g+BkBu7VQ2KWC2TeocR/jQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,176,1716274800"; 
   d="scan'208";a="45449730"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Jul 2024 07:57:30 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 1 Jul 2024 07:57:29 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 1 Jul 2024 07:57:29 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 1 Jul 2024 07:57:29 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 1 Jul 2024 07:57:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A/umB3xcSo2wvlViDx2EegG62AEgBKcPCPsKPgcCZk4+tC9dfsNQfNmi3mh1goht6UX9vowtopA0vssfDh0974xy0b3jpoBJ+YhWQQIsrIxxqZUCqD/7qk+oGsbHNSEQvlBdv3EMPNS+GB3+DFeWsN5aLMAYOGoR/w3ezcqgE24OxWG+J2McZoQ4fDB4svr8DZtT3K2TW9yjHm8u2uids2326Ia4W8+KdRM+T6nr8HV3yLZO+uwSy5tDB8nP45RRgOg0ngMP6b3BHDmK/qiwb+ajSREJdCKblS3pPGdEb+qAgXn+AQMYwrfB1ygbqfvhFJji/793BaYzc8sHnfdf6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gaU2BGqcV+pkmLsJ5m/5GzPCcSUc3L1swSxk6ZJvG/Y=;
 b=VpQs3qMzBeFMNSaSOUf2EgflQeMzUR1Ml0C4k3RUzrp+bVH1/kxopGzyqbO1sK0TblK6nmVXz33n3VJkxaO5W4uAeIX8NfgIWtnqRrVRSn2gI1zYH4wclGMNy+n8Uux2u3mEsDnOC7WYRAZZjVVdaUqaorZFft2CaIoXAzhgpuQSydNq5qi3lLR4wnRIYVyj0Dm91or3CZ7gvFRJFet9v7wlfMfBtxE1aCgaB6UcZ7lqPsQUIOL29APPx4oaXKEelFQgOfTWrCVPGKGuUVfBFH/UVFCTdgiYRudUHBYF/TG7Z27jexOv7vz5dZrehP2jmJyUsF4RH5PzNMUl+NhNwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 PH0PR11MB5032.namprd11.prod.outlook.com (2603:10b6:510:3a::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7719.32; Mon, 1 Jul 2024 14:57:24 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%7]) with mapi id 15.20.7719.028; Mon, 1 Jul 2024
 14:57:24 +0000
Date: Mon, 1 Jul 2024 22:57:09 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Mike Galbraith <efault@gmx.de>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Tim Chen <tim.c.chen@intel.com>, Yujie Liu
	<yujie.liu@intel.com>, K Prateek Nayak <kprateek.nayak@amd.com>, "Gautham R .
 Shenoy" <gautham.shenoy@amd.com>, Chen Yu <yu.chen.surf@gmail.com>,
	<linux-kernel@vger.kernel.org>, Raghavendra K T <raghavendra.kt@amd.com>
Subject: Re: [PATCH 1/2] sched/fair: Record the average duration of a task
Message-ID: <ZoLDxQlTR7fxoXWs@chenyu5-mobl2>
References: <cover.1719295669.git.yu.c.chen@intel.com>
 <338ec61022d4b5242e4af6d156beac53f20eacf2.1719295669.git.yu.c.chen@intel.com>
 <d922f7bf3965f4eaef5028177b886e2e1861742d.camel@gmx.de>
 <ZoFY/n2S7rMp6ypn@chenyu5-mobl2>
 <db81ba7fba622e2a1b7186e66471cfb9ad8490fd.camel@gmx.de>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <db81ba7fba622e2a1b7186e66471cfb9ad8490fd.camel@gmx.de>
X-ClientProxiedBy: SG2PR04CA0187.apcprd04.prod.outlook.com
 (2603:1096:4:14::25) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|PH0PR11MB5032:EE_
X-MS-Office365-Filtering-Correlation-Id: 32f2e848-fe77-495d-45df-08dc99de1df9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?s811rSL4s3cG15bwfBfvzG68nRkBwDJdWlslVOE+TjOvsexgvcwCVsMM6r?=
 =?iso-8859-1?Q?MEQIF1YLP5yt6YAkPM6JXRfwmka0Hl1N1D429HoYr+HQVOaVtAgGeTHbDt?=
 =?iso-8859-1?Q?1BVyOak9GXV9C8HsLGu6V/ck8Ba00fyiHxmyP8wEmQBYJfbkmHZjwnm7Sk?=
 =?iso-8859-1?Q?CQ4Md91c6Sf5/rLzFC9y839d68TS9QvWVuhtv8L4vUks/MTDj9IAXF022z?=
 =?iso-8859-1?Q?1IJYl/hB4AYNS2znftFXIlcPGNAMcbYoWGzn5owvm63Wh7lmm+B5pJ3pvY?=
 =?iso-8859-1?Q?CA/GD36c8+rlu+QdtV0vphH2vodqqJszJ/A9+qn628mPBJPSx1O5iBXrFJ?=
 =?iso-8859-1?Q?sZCQ8gANhx58Q5NqjduhvmUoICpNH06YX/xMaruTqPEhaZQRvUi6FYGWnV?=
 =?iso-8859-1?Q?mLPKWNMwQNhjeRl2Ziv/dRRV2Wg6nq1hQ345Pdp6+vkEg8WuqcWxA/chT2?=
 =?iso-8859-1?Q?KGxBp7U/8q+zBgoiuq+6/kwvPo2nCpXP7GzbJtMPLfXQuxbnUTQMTEs5CZ?=
 =?iso-8859-1?Q?FWBvhZhZdekqXL1VXB5qkNsZoDGmna1sc10guGrbze0/OOpBjf42oIZvjz?=
 =?iso-8859-1?Q?q3k6ZcyAxclialAt+IszFt5VC6oonfTLjAxNaBB9H5w2km7iyUfJ57rIBh?=
 =?iso-8859-1?Q?Y8ji5TaDnbgTZcyiGz9ZrAdtWCMJzvdcZveKja5rt2NCJ1KZzXQLAVDUzZ?=
 =?iso-8859-1?Q?c41sy9+ULvn+rS55fsHhtMQDjAOWrh9jeQu1d6pJ7g/uLC19+6PHWDoSOV?=
 =?iso-8859-1?Q?FOqRCfOeYrFp5KiBgwTSQGrVRe52TrGQsPETt3Yfa5uuUs4GEsAqWU0ZlL?=
 =?iso-8859-1?Q?JUy9rfE4gwuf6k/F6FqnPnImzyn4x2zJAPsRfip77jvfUBfqg+o1Badm3p?=
 =?iso-8859-1?Q?+DsGqaz3E2BzcorDBWnfSls/bhJ5Qpbs8Q6JWIGfGC/975OtNpObQBbp4i?=
 =?iso-8859-1?Q?0UgO8Bc3zLsmLMRAEL3lhwP37TDUJwuwPIPiXDbN6fT3ObWpTvlv00APFh?=
 =?iso-8859-1?Q?J/1Sa0E2XWtTLMkHG7yg095zTuo/AxkJs+5dcOxFQNSB3Ia+VD4rfRdlAF?=
 =?iso-8859-1?Q?BiZbdkiM4lLlzgJ7aX+Wy9bc55EhPgKEonmNh/qDaeRSzgLyzLhCI95Fhu?=
 =?iso-8859-1?Q?pafaA1nQjXxCPgXdG7sjgqj7vqQ0YT0r8qlbdyLitPUn7CHgIT2YkQdegO?=
 =?iso-8859-1?Q?tn+nqs3kucCHpGcgbQ+reJXLXenmD1RAN7fKEPTUgU4w9gzaLmGmKZUVb9?=
 =?iso-8859-1?Q?2NUgxrZo/fQ7YOkmZ13SrpU4hVMrrR8mSaV40f2YBh5MrrhfNo0BTk+4qf?=
 =?iso-8859-1?Q?D9gR/gfNk30NgXcrDC3zYP7QXtvXiaJY4Sbu01ECUj9C6HQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?UoKFsHohcUpFxijc6GqY7LHykan/Ru3ySKsDO6H2jRXXJ5Cn17Nhgjo7ns?=
 =?iso-8859-1?Q?PN6llwAyIBF9ToBK9xvH1e6PHYaicPBjj0gEUFlwEkYGAq9WOIx25sY7PS?=
 =?iso-8859-1?Q?ttxOONuIoF0qmq//8/FEcIMFXfp+OpjgyOxYNmoaplZCmZf/GYNW7u8QW+?=
 =?iso-8859-1?Q?t9GgpgGsEllcMMDJ/m8bdC+oQnDlWDeAwZW+39zxw1JpQNGU3Ynscveg0P?=
 =?iso-8859-1?Q?7MUO+VSh+r+zNgwAY9jrC75KrV0hdiIeDXhCJ9upiuvXF/NhPCSKHEECbb?=
 =?iso-8859-1?Q?bEGkMUyxXnpryxyvawFmZmv4CWqsAvbYMMEslOKflSNP/cA6+WObWnhlln?=
 =?iso-8859-1?Q?mO78nnfQJI98HVivg/I/4CaSX25HIH/NPZm2E+7qMKnOkLfRTltyGM+UIg?=
 =?iso-8859-1?Q?tWkqovG7dUw22/veFA1bzGeoTA/A1Cp9/8aMKasa580lfziJnev8hl05Ny?=
 =?iso-8859-1?Q?Fw7+WMVMUhxPxibW0Z2lWcVHNKibrZUZThmNMnJQYb/iakoqWZJ6xarYr9?=
 =?iso-8859-1?Q?9uqRrST5/jJwH14KTZqxuoLuCB/gOogJPSGYW9b4py71v/A5w86Rbe7HqY?=
 =?iso-8859-1?Q?hM1aE9oIug8g6HnSHdZvppQVF3BWLx8TWoWmC/LuIOlJU2t0YBWVMybByD?=
 =?iso-8859-1?Q?liijI5tvDyDHLkIjr4oc5VkxnAfBxOTwUOVQUrABu+uECT6U/wuyLcM5HP?=
 =?iso-8859-1?Q?dvcy2inCuxkVvdVv88H+7PUDV1pkimoq39CJwPAGxo3JFYEGmB0Aowcpo2?=
 =?iso-8859-1?Q?pl1exSAWutamtwoOdpkiWGlCFm6AnB9vcvmPudWFCOhGuAZIO85n72c8Xh?=
 =?iso-8859-1?Q?j3C+vAuK/m3F2zTjFllJpn7PYfntHqRU7UAHp/UtGqTclnfLst0gbqgkDJ?=
 =?iso-8859-1?Q?+Ag15MAC5iXSxjxzkBsOmjCahUoIe2AknuTN4SpJKXL51Wedi6dewgMN1x?=
 =?iso-8859-1?Q?OiHtZjrPh7bQZOzPwcidp8wkZZenYUPAcQwbgvjDZIqC0wsI5GuHuh3eLV?=
 =?iso-8859-1?Q?IJcFK2Z/IROkNcDszM0SuIPmSrZPftPxktRiNj2HIKqq+Po1jJkHU0NbRc?=
 =?iso-8859-1?Q?aB389yFb6UvzypBP26qARetpyfXEFJ3cJes4P2CYdY94ChM/2GP/01V7n/?=
 =?iso-8859-1?Q?1f9yoASGofezTsgS++nAcf+CpAEaQBjKlNFz03YMa+rIr4kCOv+dbapcTm?=
 =?iso-8859-1?Q?xhQeNnpy5JVXI4DTN25VLu4YR/iNQGyYImxOa362Janl1PnyrK+b/DftZD?=
 =?iso-8859-1?Q?Tq/4O71ZvM1KgY05+RaZfvmwU46pBUfs51scXVuqrjL+fprHMBS159jQsX?=
 =?iso-8859-1?Q?l+vqFEBEeffpycI3B0Lm3yJNeLYj0wIy8LFAeZhOmM92GFkOiV/qNbPvjn?=
 =?iso-8859-1?Q?8YfGGphlpXKRj/VJW4pTvClaWk6RzAJTMZXbnSJ9ptNXZfoW0wv1wBcaKJ?=
 =?iso-8859-1?Q?fJFIk4Q8ydP0fS6hlhyc6i7NyYLwb69EPptGIMerBYMCMUxFDD372vyztb?=
 =?iso-8859-1?Q?XnK+EroYsLeLNHbJULQvc06X3jQvda8YtdmeM1myyEPPfom3rgATCWOQHZ?=
 =?iso-8859-1?Q?q9kEH89ZUsVVRy8ncw0MtKD5/stobYQIRhU8iRBLswOOgDq8Iu2zW/UPJD?=
 =?iso-8859-1?Q?Zv29Hnyv5B9iUcqlMOe8b5eFxBWce4xedk?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 32f2e848-fe77-495d-45df-08dc99de1df9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 14:57:24.5756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pyfr2pkEzC/HPViYS23kGEAkhNjymD3hadgMGpPA1d+xXj7AlkY7TWqVlPk3msu9i2dVKz7fqkmxXhheVK3eRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5032
X-OriginatorOrg: intel.com

Hi Mike,

On 2024-07-01 at 08:57:25 +0200, Mike Galbraith wrote:
> On Sun, 2024-06-30 at 21:09 +0800, Chen Yu wrote:
> > Hi Mike,
> >
> > Thanks for your time and giving the insights.
> >
> > On 2024-06-26 at 06:21:43 +0200, Mike Galbraith wrote:
> > > On Tue, 2024-06-25 at 15:22 +0800, Chen Yu wrote:
> > > >
> > > > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > > > index 0935f9d4bb7b..7399c4143528 100644
> > > > --- a/kernel/sched/core.c
> > > > +++ b/kernel/sched/core.c
> > > > @@ -4359,6 +4359,8 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
> > > >         p->migration_pending = NULL;
> > > >  #endif
> > > >         init_sched_mm_cid(p);
> > > > +       p->prev_sleep_sum_runtime = 0;
> > > > +       p->duration_avg = 0;
> > > >  }
> > >
> > > Beginning life biased toward stacking?
> > >
> >
> > OK, so I should change the short_task() to skip the 0 duration_avg, to avoid
> > task stacking in the beginning.
> 
> Or something, definitely.
>    
> > > >  DEFINE_STATIC_KEY_FALSE(sched_numa_balancing);
> > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > > index 41b58387023d..445877069fbf 100644
> > > > --- a/kernel/sched/fair.c
> > > > +++ b/kernel/sched/fair.c
> > > >
> > > > @@ -6905,6 +6914,9 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> > > >  
> > > >  dequeue_throttle:
> > > >         util_est_update(&rq->cfs, p, task_sleep);
> > > > +       if (task_sleep)
> > > > +               dur_avg_update(p);
> > > > +
> > > >         hrtick_update(rq);
> > > >  }
> > > >
> > >
> > > That qualifier looks a bit dangerous.  Microbench components tend to
> > > have only one behavior, but the real world goes through all kinds of
> > > nutty gyrations, intentional and otherwise.
> > >
> >
> > Understand. Unfortunately I don't have access to production environment
> > so I have to rely on microbenchmarks and a OLTP to check the result. I
> > get feedback from Abel that the former version of this patch brought
> > benefit to some short tasks like Redis in the production environment[1].
> > https://lore.kernel.org/lkml/36ba3b68-5b73-9db0-2247-061627b0d95a@bytedance.com/
> 
> Here's hoping you get a lot more.
>

We recently received a simulated benchmark for Meta. I'll conduct some tests
to see the results.
 
> > So consider 1 and 2, I'm thinking of moving the calculating of task duration from
> > dequeue_task_fair() to wait_woken(). The reason to update the task's duration in
> > wait_woken() rather than dequeue_task_fair() is that, the former is aware of the
> > scenario that the task is waiting for the real resource, rather than blocking
> > on a random sleeping lock. And the wait_woken() is widely used by the driver to
> > indicate that task is waiting for the resource. For example, the netperf calltrace:
> >
> >     schedule_timeout+222
> >     wait_woken+84
> >     sk_wait_data+378
> >     tcp_recvmsg_locked+507
> >     tcp_recvmsg+115
> >     inet_recvmsg+90
> >     sock_recvmsg+150
> >
> > In the future, if there is requirement other scenario could also invoke the newly
> > introduced update_cur_duration() when needed. For example, the pipe_read() could
> > use it if the task is going to sleep due to the empty pipe buffer. I change the
> > code as below, may I have your suggestion on this?
> 
> I don't have any suggestions that will help plug the holes, heck, I
> squabbled in this arena quite a bit some years ago, and did not win.
> Frankly I don't think the scheduler has the information necessary to do
> so, it'll always be a case of this will likely do less harm than good,
> but will certainly leave at least an occasional mark.
>

I agree. Unlike bug fixing, this kind of change usually involves trade-offs.
The attempt is to not do harm for most cases, and bring benefit for some cases.

Regarding the necessary information, non-scheduler components might have
better knowledge than the scheduler:

1. If the hint comes from user space, it could be something like
   sched_attr::sync_wakeup.
   It indicates that the task prefers sync-wakeup and is tolerant of task
   stacking. However, I'm unsure how this could be accepted by the community
   if we want to change the user space interface. What is the criteria to
   accept such change? Would the requirement from different production
   environment be considered as the endorsement?

2. If the hint comes from other components in the kernel, it could be the
   driver or others. seccomp in the current kernel code, enforces waking the
   wakee on the current CPU via the WF_CURRENT_CPU flag. However, WF_CURRENT_CPU
   seems a bit aggressive for ordinary tasks. So, wait_woken() could be used when
   needed (by the network component, for example) to indicate a possible
   cache/resource sensitivity of the wakee, and together with the task duration,
   to decide if the wakee can be placed on the current CPU.
 
> Just take a look at the high speed ping-pong thing (not a benchmark,
> that's a box full of tape measures, rather silly, but..).  TCP_RR IS
> 1:1, has as short a duration as network stack plus scheduler can
> possibly make it, and is nearly synchronous to boot, two halves of a
> whole, the ONLY thing you can certainly safely stack..

I agree, this is a limited scenario. 

> but a shared L2 box still takes a wee hit when you do so.

According to a test conducted last month on a system with 500+ CPUs where 4 CPUs
share the same L2 cache, around 20% improvement was noticed (though not as much
as on the non-L2 shared platform). I haven't delved into the details yet, but my
understanding is that L1 cache-to-cache latency within the L2 domain might also
matter on large servers (which I need to investigate further).

> 1:N or M:N
> tasks can approach its wakeup frequency range, and there's nothing you can do
> about the very same cache to cache latency you're trying to duck, it
> just is what it is, and is considered perfectly fine as it is.  That's
> a bit of a red flag, but worse is the lack of knowledge wrt what tasks
> are actually up to at any given time.  We rashly presume that tasks
> waking one another implies a 1:1 relationship, we routinely call them
> buddies and generally get away with it.. but during any overlap they
> can be doing anything including N way data share, and regardless of
> what that is and section size, needless stacking flushes concurrency,
> injecting service latency in its place, cost unknown.
>

I believe this is a generic issue that the current scheduler faces, where
it attempts to predict the task's behavior based on its runtime. For instance,
task_hot() checks the task runtime to predict whether the task is cache-hot,
regardless of what the task does during its time slice. This is also the case
with WF_SYNC, which provides the scheduler with a hint to wake up on the current
CPU to potentially benefit from cache locality.

A thought occurred to me that one possible method to determine if the waker
and wakee share data could be to leverage the NUMA balance's numa_group data structure.
As numa balance periodically scans the task's VMA space and groups tasks accessing
the same physical page into one numa_group, we can infer that if the waker and wakee
are within the same numa_group, they are likely to share data, and it might be
appropriate to place the wakee on top of the waker.

CC Raghavendra here in case he has any insights.

> Intentional stacking can be jokingly equated to injecting just a wee
> bit of SMP kryptonite.. it'll be fine.. at least until it's not ;-)
>

I fully understand your concern, and this analogy is very interesting.
We will conduct additional tests and share the data/analysis later.

thanks,
Chenyu

