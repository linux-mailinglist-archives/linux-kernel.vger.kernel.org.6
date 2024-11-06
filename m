Return-Path: <linux-kernel+bounces-397296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3BD9BDA1A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 01:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEFE4B22516
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 00:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E3812B94;
	Wed,  6 Nov 2024 00:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EII2TLl9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40538BA3F
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 00:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730852017; cv=fail; b=TfCG0k+X8fwuS/8UtY/aS5eNITn9fR+tED/JPhjKlKpukGtxQIb3kaJrbbMyjqKGy5g/50quGazNuAcihDAv35AKt76gWrC5+s6UvUBAV37qSK0pEYBwqXSlOj4GDc5hO/4RwLdgg9MOACcRuVLRnd46BlfS/FOeTFYCc4yYY7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730852017; c=relaxed/simple;
	bh=qMaFblwsp8RVINokTBasYtI2f/tcD5r/Iai9EDiMZIw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p3b2KAENJk//baTcj9VwL90W/DPfjWbP1GpoybNMs0pNsQJOUbknLBbZWNGqDGBzqaOCD2Uy13hQ4gRcQ1jlLxWhbd+R9hiPRa2cCTyc+2tW8xM1ohn9zE7mnyBcupZysIY0D0jIdCfrz0Pqjo1s/VObUPJtnfucyeKlSdCx1v8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EII2TLl9; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730852015; x=1762388015;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qMaFblwsp8RVINokTBasYtI2f/tcD5r/Iai9EDiMZIw=;
  b=EII2TLl96xUVTCCOAsPjVIN0rM9Psgx1Olzx+mqD/lG2ZVdV1jUykuSI
   vh/d0m6TDsqWkrqsDDG2jFIVuMlh86L86IDJ7/KSYY6ZT/khL/wVXq8lv
   BJvkXaQCkO/ZWURccZtvz8AJe8Z8HFQ6LwZiE1YV6IFur9yYkV8PUB3f9
   9iQqQC7Kj9vT0Rn2r7UPrSFsZdqEWu1QVgofpGIzC7BcRon4GcZ3pvQqQ
   r1crMEgrpUfHe9rATJz+CBG8anC8qdIFqGrxgpxQHyPUbaOBxo23+RqqU
   nVJ1oLPtonTlgiUfy455sq1zerIt4GzXmI2hWa1QyVytuLFqtUAeX9yjK
   w==;
X-CSE-ConnectionGUID: LWjMrf6JTL2zWw7U1RdYeA==
X-CSE-MsgGUID: wN4MbwLASk2fCWnFv8pxXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11247"; a="48137188"
X-IronPort-AV: E=Sophos;i="6.11,261,1725346800"; 
   d="scan'208";a="48137188"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 16:13:34 -0800
X-CSE-ConnectionGUID: wGuoxHpZSuyflRViLeRxlg==
X-CSE-MsgGUID: tuxeY0miRUGniK4IZzXC6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,261,1725346800"; 
   d="scan'208";a="88187054"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Nov 2024 16:13:34 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 5 Nov 2024 16:13:33 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 5 Nov 2024 16:13:33 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 5 Nov 2024 16:13:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yTiz5GFsLALn8yitCU0YxxhJwt5bS6btru98F/rgmQseUZhvnHuUbrq0lwwAUczc9yxY6ClDRwxO/axvdUY6YPBKAVcHMtB0fvzSAYneCpX/ObLadKOqimF+zkx01K/+/YfOu1/w3vyQ5y1piTqZm/NJVudoXNnO343FQVzeFHBFcZ28SxVZsEL4oKVJyMqmXHsNIUxHMJwtHvpL9g8/Pf7ChxomoesEyL5m+NvpArOlrr5yyRgqTBffEiWewVA/ebFlnFveDL5iZiZPzNWT/ssS5EgiU86+V3Va+3nCyBLchz+4gHdQmMNODOlwHsM98VQrTpQjxN6RlGEjo0mUQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ne2cVJ9j9m5aW8YHDPQjxWJtj6R4ubErVohwLYU8s6U=;
 b=NKnIh1Nz4zibcHEjGjeUnNMGrD40yWFEWA+NN7HYEM14dy0nR0uBgFTm13DWctrLEeDsAQVVzVgCwUjhEwmhe8jg7wVDkvv00pqMMRBJGv9Etcv1bEQQBcc8E7abLcJzgwxkXIQVSrOoEH0Cy0TfA5+8/2U5QT7Uq8rr6NAVL4+ceEtR2ef0cy5Iw30Tpjmmo966x0ah4JMlGeBB9bsKNpB5s88funVZF6Iciow3VjqPLzUa6e/I7COTddyHUPZ0xtmgKaOfq4l8YhsgRDWJu2W/nM997sGlXvx/Hzemkr51kba3AMljp60KE5AxVzfESoXmAkd3zyb0QPwtoNhwCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA3PR11MB7979.namprd11.prod.outlook.com (2603:10b6:806:2f9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Wed, 6 Nov
 2024 00:13:29 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8114.028; Wed, 6 Nov 2024
 00:13:29 +0000
Message-ID: <5ec7a1c1-43b1-4c18-9ba5-5cf4c42ba3f1@intel.com>
Date: Tue, 5 Nov 2024 16:13:27 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] x86/resctrl: Don't workqueue local event counter
 reads
To: "Luck, Tony" <tony.luck@intel.com>, Peter Newman <peternewman@google.com>,
	"Yu, Fenghua" <fenghua.yu@intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, "Babu
 Moger" <babu.moger@amd.com>, James Morse <james.morse@arm.com>, "Martin
 Kletzander" <nert.pinx@gmail.com>, Shaopeng Tan <tan.shaopeng@fujitsu.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Eranian,
 Stephane" <eranian@google.com>
References: <20241031142553.3963058-1-peternewman@google.com>
 <20241031142553.3963058-2-peternewman@google.com>
 <b3a52af9-e298-7baa-19b3-8931d03731d1@intel.com>
 <CALPaoCgc13hS64mSWvn6zYQWwVKzcyF8xueWsaP62ZZJiv+nog@mail.gmail.com>
 <4e2f31bf-1035-40a6-b16d-081d6e45ead8@intel.com>
 <SJ1PR11MB6083D1B48E48BBE797ACF21FFC522@SJ1PR11MB6083.namprd11.prod.outlook.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <SJ1PR11MB6083D1B48E48BBE797ACF21FFC522@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0245.namprd04.prod.outlook.com
 (2603:10b6:303:88::10) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA3PR11MB7979:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e737d20-05c4-4ca1-5865-08dcfdf7d7a7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T3pQOXExOGJaeUdSRGFBRmhMMStRdUgxNXNwTnpvUlVSVlV0cHo5M1NjWlds?=
 =?utf-8?B?WktmclFsUWpMMUNNcjhTRWNoSDdZeEFkQ1I0OVR2eEl2UmwwT0J2TVExcGJY?=
 =?utf-8?B?bFlqMFlTWXZ1WW1Gck5lOTR3MU15Q1BIZDkxQnlsZmI5dGhSVnQyVU1RbEVl?=
 =?utf-8?B?cFBrUFQrSHlQOWVUVFdicXhUQkpIWnVIcEJRZEZ0dVQyN3Z1L0JaUitTVTJ2?=
 =?utf-8?B?Nkx2NFhRbnRIeVN1YmhoY3h2RmFtMENRZUpqQnp2Nk1NeFVnejZLVVNIREw5?=
 =?utf-8?B?Q3NhcjBTbmFSOTNPTWhVZkczV0JGRWdmZkZyM1VWc1JuZGprclA3NWVZamlv?=
 =?utf-8?B?QnpwenZRenRMWXh5SkVHbnZ2Q3ZxUUJzT3RyVWVYMGV6YSt4SWxMc3N2cnBt?=
 =?utf-8?B?R0xZVmUrcGRsSnFBZUQ5N05UWm9PK3dqLzlaSmJBekRjaHRQVEJZK1FPU1Rt?=
 =?utf-8?B?MnBVLzEyYmhZNWhPQWJ1OXBnRVZaM1hrL0dJb3R5VVN2V1k4SUwxV1NLME5n?=
 =?utf-8?B?SlFnd0J4akFlQmpNOVRhZ0s2RkdNeW85VDdhcWN5VXFEWjVQUkNGbklJbk9C?=
 =?utf-8?B?cDdOZGlhS1lpSTFFanNCamFpTE40WTA3Yk1MNHk3eFRFTmM5YXBsdVoxbXdK?=
 =?utf-8?B?dnhaY1lnMmZSbFVVd2duTEwzT0JqRUgzS29qaGxPcDNLVzRhSWJyR3JDaDMr?=
 =?utf-8?B?VWx3cTR5ZHlPWm1maSt4WUZ5UXdGT2EzZGkrRmFLWXRGdUY4RCt1U2pmZ2Zo?=
 =?utf-8?B?dDJ6cm5GU1YwUk1JM0FSenNjZXFPUTRjV253NGtGMzNLU2J0Qi8zTDJMdG14?=
 =?utf-8?B?ZGVKTE12NlVoL3B4eDlldmdkOXZ4UkNuT2lrZHpmVnpYYm5pMVJoemJlY095?=
 =?utf-8?B?aHJ2RTNtSjNpTzhtY2REM1g3dDhjVlJ0YnhYOXpHZnhlTnczWWVmSDk1S085?=
 =?utf-8?B?V3JQQmwrNDMzQlBRSU41d1VsT1F1V0RaVzJmOUY4S3JCTDJpYlhoQWFuMVpk?=
 =?utf-8?B?a2p1aUhUQlorYVl2V2dCNWdZQ25OZ0Jma3B1V1ExU3lIaXp3T09aZmxFMHpO?=
 =?utf-8?B?bTZkOHpUNWN0VVNOSUtpK1Z1aHQvN2Q3Yy9hQWVWeGZ1MDV6Vm5qVjhlWGJW?=
 =?utf-8?B?anZSUEhUMXV1SlJBcytCOW53OENreU9UbmpmcUl2V0liL0J4QS9yZUF1UWN0?=
 =?utf-8?B?QzIyQVBQczVHUHpJZmNxaXhidmtuZXRaU1Bya1Q5MUN2VVVnblhDZ1QzKzBk?=
 =?utf-8?B?TThKTGVsSEw2cktaV3Z6WE5jR0FxT3FHNUY4SnlPalRoNGUzbWZETTlmNkdv?=
 =?utf-8?B?V2w3Y3RudjY5K2xxLzFaK3FoMnRPSFBSaEtMcWlzY294QTVZMFowZk11cWRJ?=
 =?utf-8?B?Z2YwNkdmK09DSXA2eURzbTUzVENtcTZtUkUzZjN4UmU2OEg5M0hoV1ZvN3h3?=
 =?utf-8?B?Nlc2aitTMnB0Q0hxM3U2OHVobHdFM2R5NWw2d2p1MzRJUjNZN0xxRzZ3YW5o?=
 =?utf-8?B?N1BQTklENjlvaWY5UmpUV3h1cElaSVJzNStFSm42ZDNaZVhzR09SbU5sYTNT?=
 =?utf-8?B?NUNCbEcxUmpNcll1SjdOQzljRnkveFFIdnRqRlpISnRnV1RtcEhKYWFtSDJD?=
 =?utf-8?B?cnpGRjR2NVgrTC9nd2RRVDRtbTc5dVRIYkVidDMvOFE0dURvYnc4NE1pOUpK?=
 =?utf-8?B?QlByOHVZSUhRY2IyZlp5QUNNbmdIL0dLNzNpQW56UGxjME1IZ1ZsOS9BOXFV?=
 =?utf-8?Q?cg6LwXJiVgi57yL+ecgbLRuc3uHiLXzL9CrdgvU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFc4QVZJQTBlVjludWI4bkN3WityY1FjbmFkQys5aEt6OTB1ZkRYbEZEanZy?=
 =?utf-8?B?UkVicHJ6dDI1TjhyK2UyTUVERFFZOUVnaGNDaUM5WXdMekZoMHJNQ05lZEFh?=
 =?utf-8?B?ZWQvNkY1QVAreFpKV2k1R1JxSkhYWGZwNENLMjdnM1JzbUlrNzhxQUY4a0dU?=
 =?utf-8?B?aWlVS1ZhUy8vYjJiQUhhV0hXbTVVaXZITVh3Sm5SMUo3UlNzUmNyc0tkNjRy?=
 =?utf-8?B?OG1qM21nbnYvQ0ZVNVVIZE8xa0F2ZEdjMUMvRGJiT0tMMHFkQjh2TFJOMktB?=
 =?utf-8?B?eHQ0SkFuYlFkRzFQc1orSHFHTTNDejlkdnVkL0w2VjhETzd3dGgrZnk1ZVl1?=
 =?utf-8?B?K1F2cDFkdUtGNGtWUnhheEFNS2Z5azVrS1JqNTVpTWN2ZnNqWEtRb0hlQllq?=
 =?utf-8?B?MS9jZ21zTW9LcVJubjFwdnI1OVZ1YWpWSFpTU3J2WDZoZ2JGYlY1dDlDNEhT?=
 =?utf-8?B?S1FvMU5SSEUxbWdYKzJZNXh1K01EUUNDVEpwelltTENMcDVsZ05PUlNQOVQx?=
 =?utf-8?B?K0VIcERPUFNkWk11aHUxSFBVbCtKRjMrMTNHRkJ2UHpub1NmZ3VpMTArMy9n?=
 =?utf-8?B?d0lmMjlrOFArN0FXU2lrQ1ZlcG1majE2S3NlUGtrRExrTFlzK3FEVHZzb3pR?=
 =?utf-8?B?a1ZMRndPdVc1QmFmc1dLeTE3UC8zOXlyZ2dLWk9OeW5JV1Z4L0JZWmZCUHRr?=
 =?utf-8?B?QjBkeGtNT1FDS1NqWXNxS09aNUNxcFlaS3Q5NWVhWUhqRDY5dUFtN2xOL0lG?=
 =?utf-8?B?L1FtNDAzLzFlZWFQWTJWdlBSd1JUVXhmT3FoK0N2aytwQW11R3ljdExZWDhq?=
 =?utf-8?B?RzlvUW9tTjVjUFRMYTE0dFoxbTlPRXRlUERHUzBtVlA5ZVRVZnU3ZUtqSmxH?=
 =?utf-8?B?bG5uc3FHSm53MDYydVRrSDNReW5kTzRyS1ZjSWpDdzFLY0VlcHhqUm1QQjY1?=
 =?utf-8?B?OCtFck0yMTI3Ui93ZUxwTTVYQ0gwUDVPdTFpUXF4TUM4VFZaeUZiU1lPY3Fk?=
 =?utf-8?B?Y2doTGx2SnhWYnpmVE50M0RDaU1SbnF6K0c0Z2RETXZrZ09OQVR0R21oVEto?=
 =?utf-8?B?UzRCazFuUlhtditGckdXeDN4eHBteWN6WHovd01vL3JJWDNXTVl1TlJ0L25N?=
 =?utf-8?B?dTUxNnFIai80WFJ0bnh2aXF1dU9NRkNraStVOTZMNGpOZnVITXFYTi9vN1Bq?=
 =?utf-8?B?YzZNYTRYTjhET1Z2bXpPOEsyRWpFVHhPVHkycEUrYUdDa3pBUlAxWEg4TkZa?=
 =?utf-8?B?eTY4bXZ5L3FLSUlVdnNCa2d0NzU4Z1dZODBsOFVURDVHVkR6Uys0Qk9aNWIx?=
 =?utf-8?B?blh3Q2lQclA5am52clk4KytQVXNtdUYzcjh1eFZGMzUvTUZOMWFYYUU1Mk84?=
 =?utf-8?B?TFVWVFl4TURHaGt4K1BlUlh1UFB0YmVILzNHdGtNQnI4RU9lV1VLZ2Q3WTFU?=
 =?utf-8?B?bTUwelU0OXBDS3Y2Y21MVkE5NVhVUE9vMWQ1elFuNldMbVpGVkRnMDF4VlhI?=
 =?utf-8?B?eVVKa1NDbkZnZ3FzUkhJUStJZHZleGl2a3hsZTRoNmhNUThLR3gwenIvTXh2?=
 =?utf-8?B?UHdlbW1LVlVwVER2YitHS1lrQTBaV0RrRjZIaVJFeFdTY3lTYkQrLzdteHhp?=
 =?utf-8?B?cnNTMHpwYi9XNmlYa01hWndHVUl6dnFDaG5QODBxRXlZSmRNaHh4cmFTWkhR?=
 =?utf-8?B?eklFUWw4Y1c0VjRZOVdqYlQ4QzFMaXlzRTNkY2lITVZXSzN2Zm51SmtVTUpB?=
 =?utf-8?B?cXlDMEsxYmdzeFkxeUxJU0FON1pzcGIzV2NielplUW5nTTg1aWtKZTBlZnhi?=
 =?utf-8?B?SWxBOFQ3RmNmM1I4bE1TMWlmSHVseVQvRmRGZmZYV09YV0FCSnQ4bytVdVBn?=
 =?utf-8?B?SVhuSytCaC9kYnErWGFldExQcHRweTl1Nnd4MUk4RkdpSFNjS0ord0FZZU1h?=
 =?utf-8?B?cUxxTnRDenljekltMDlKZ3grOXlZSFphTFVCalVDM0wwbjZGbUpkQUdXWEdW?=
 =?utf-8?B?dDlSUmY1S3hxQjlKUmU1Z3Y2TTVDMXcyaGl4aTdLa3FPNlN3N0JTQUFja0xT?=
 =?utf-8?B?MDJ6bGxnUjBjeCtXNGsxRDdHTU94Y0phZmxqT200VU1MMm9tZHBtOS9SK3ZE?=
 =?utf-8?B?QlFZY25HZm5rTDhEaC9iRlFJNFFmaEcyOVgyRjlQUHAxd0Z6R3RLbHJ1YUVn?=
 =?utf-8?B?UEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e737d20-05c4-4ca1-5865-08dcfdf7d7a7
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 00:13:29.7996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H0DOJSAz7jHuKKoUEr+817m8AUs72J85sBeeLoisByTSfFZ+P+RppMVRZJ0WWDc6/+p64GJQEN0SzG0tIivBbyS/W1IOnM4uB4CLfyDGkao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7979
X-OriginatorOrg: intel.com

Hi Tony,

On 11/5/24 3:39 PM, Luck, Tony wrote:
>> I think this change already undoes the motivation for 09909e098113
>> ("x86/resctrl: Queue mon_event_read() instead of sending an IPI")? As you mention in
>> changelog the goal of that work was to enable resctrl_arch_rmid_read() to sleep.
>> This change will call resctrl_arch_rmid_read() with preemption disabled if
>> it happens to be called on CPU in monitoring domain. Would that not cause
>> MPAM monitor count reads from CPU in domain to be a bug?
>>
>> Could you please try out this patch with CONFIG_DEBUG_ATOMIC_SLEEP=y?
> 
> How is this all going to look after the split into fs/resctrl and arch/* ?

Unclear to me at this point. Peter exposed an issue with current implementation
and this needs to be fixed. Since this involves preparatory work that impacts
systems currently supported we could also consider reverting to original behavior
and go back to drawing board with the preparatory work.

> Is the file system code going to have implementation choices that prevent
> performance sensitive users like Peter from optimizing monitor event
> reads by binding the monitor process to a CPU in the right domain
> to avoid IPI?

Apologies for not clearly stating it but I do agree that there is an issue
that needs to be fixed.

My response was not intended to be interpreted as a NACK but instead an attempt
to engage in discussion by pointing out that the proposed fix may not be ideal.

I tried out my own suggestion and indeed when just trying to mount resctrl
on x86 with this patch applied results in:
	BUG: scheduling while atomic

I do not object to optimizing monitor event reads but the proposed fix
is not appropriate in its current form.

Reinette

 




