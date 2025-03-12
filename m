Return-Path: <linux-kernel+bounces-557211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D534BA5D523
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 05:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CDC3189C8A9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 04:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989FD1D618C;
	Wed, 12 Mar 2025 04:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mie4Mlzk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7A2259C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 04:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741754824; cv=fail; b=Cw6wlKjIEM8uR2MYB2gpxJBGsnPTa9VcgeE/dj4iJuKkdC7U9NLOVtZUe2jg3yhsLcbFpq2RDff5vGz/eP3u/u2U+kMkRTwkutIrSXCU6V+geK3q/AG4oeK3eyGtF2Qanb7bMRkqzYoHFFT6vj5ahHyn17DvkrgV6tsn7PltDEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741754824; c=relaxed/simple;
	bh=8Re+6K+0HbyXaQkiomFSP2ibkkcjqKcDIlw4lWEyFxM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o1/it+PafoAcSA3ndo19wX2OfYOWGJSiB4H25tBqLPyyVXJplbcQrMrb2ygXwolAibBt6Q3lvK38QDvC7VEpqfXEzsqaluwdWfngm+yovDmBEfKjQPU5l7v+5slpukb5G5U37mzZJa1T+tzR8YozWW3Tra/Teysr+tmn6Zkr/dM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mie4Mlzk; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741754823; x=1773290823;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8Re+6K+0HbyXaQkiomFSP2ibkkcjqKcDIlw4lWEyFxM=;
  b=mie4Mlzke1BUIkCrCTPSFXFW4jZfOnq8sLeIHd0Ty1iCFaKfCF25txRK
   LoiLMs2CSXdH2iGz89AdR4fBPO68YpgQs6A5IiUl+qncmqSxFffFdaSyU
   D4fp4eElnYpdZpiB/NzuyQEENWcYvmRyJoiupDbGXJ69mFgENjTMknT+I
   yoUd36XuMC3qZTMS4SnAImB8mlxsHoaWhudVM9hoHQ3QfOKihJ7byda+s
   0dTMjmHUcEJWcXnRV39/TjVoKj1md0F9zGL9r3L+yuUJI0Vtnp7kZ2fkt
   jWLbR4gdx/Fd5jqlC5ZhZMo0A7xqxmGKvyM9gIUT8Q/w9lLVOCRw632Vb
   g==;
X-CSE-ConnectionGUID: ie5VclIzQ2KxJh7cREXO1w==
X-CSE-MsgGUID: qs1NqGJOReuPNZ+DVRMKzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="41985194"
X-IronPort-AV: E=Sophos;i="6.14,240,1736841600"; 
   d="scan'208";a="41985194"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 21:47:01 -0700
X-CSE-ConnectionGUID: AadmQAY6TiuuzYFOyAwezg==
X-CSE-MsgGUID: hqM/ZLAaSaeudGhiaL+fAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,240,1736841600"; 
   d="scan'208";a="125711506"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 21:47:01 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 11 Mar 2025 21:47:00 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 11 Mar 2025 21:47:00 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 11 Mar 2025 21:47:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dls4Pf5AMclHIHePT8Ln8cqa0XAZSId28YUxx9WanjQrrteE10hWv7md8051FwamyGUhyDXHGda8rKAbA0Wx0o9raTdRZqCUmLdj99dEeFGDQT4J1XEkjuhFvvXCTiIhFLwBzAqYW4Gn0T0AIuz6cHEwW1iH81nwHL3Hd4bQtK9mTavfzN2iJud2ouZQQk3bRvY8wBWAss3fNY04kpKFBk06JKol3ZKVnWyIn6eVSHqDv2djtqhz4kJep4Mw4Jx22JFYDmc1hd4wEfS46vOezxyujhjpOySiDRijcs2LTTTx8L/FmhRp0wdwEENfKwH3YKmWLu5G7aFIXpR0MxSrLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRXYiEpNe2xAncnq3lFeuQHP4zDZUKUKVmwqSHyOveU=;
 b=jnoZ3ownq5wvENAtzWnJn4u5tvZBSG8j7Sk5no2PN5t9G7Vsp+1geEqRxr6pToE0afmUbAkJeZIvgCHiBaeXXj9BSDCd5cXPa7HMpm7b5m4zLmM+2BpehwxZIGK/iK9yW+iOdeXxGDY1gYI1lqDwUI0WrafD6dNo71f9Lugej27IB9m0hFiv2xE7fE+hM3GLuPDw7aUybXL6fotEQUxLrRdmtUSQxjHxtb+BvUPX4hKEOFMd+7r8mBoaP2vD6kWodUaDnkcRZQkh+whxelMO5a/CnqFSBZL4LWnpvsuWwERQWUlLckyOmx3qarcn6ZAI1POd4xgeVregpZZvItNgCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CYXPR11MB8755.namprd11.prod.outlook.com (2603:10b6:930:e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Wed, 12 Mar
 2025 04:46:56 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 04:46:56 +0000
Message-ID: <a7044a74-db3c-4fcc-ad83-e9776207e113@intel.com>
Date: Tue, 11 Mar 2025 21:46:53 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8:for-boris 08/30] x86/resctrl: Generate default_ctrl
 instead of sharing it
To: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>, Babu Moger
	<Babu.Moger@amd.com>, <shameerali.kolothum.thodi@huawei.com>, "D Scott
 Phillips OS" <scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
	"Dave Martin" <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>, Shanker
 Donthineni <sdonthineni@nvidia.com>, <fenghuay@nvidia.com>, Shaopeng Tan
	<tan.shaopeng@jp.fujitsu.com>, Tony Luck <tony.luck@intel.com>
References: <20250311183715.16445-1-james.morse@arm.com>
 <20250311183715.16445-9-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20250311183715.16445-9-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0330.namprd04.prod.outlook.com
 (2603:10b6:303:82::35) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CYXPR11MB8755:EE_
X-MS-Office365-Filtering-Correlation-Id: d87eb62a-86d9-4a8f-7ec3-08dd6120eadb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WFFCd2xCMnQ4YVNNc3lkbVRoOUFQVkw0WDY2R2FPTzl1Z2NUOE5Td0V6QjFt?=
 =?utf-8?B?M0Y0QVdEUEpqOGxFcDhLOVZNQytpNHdITndVeFM0QUJZMHNseGJvZGVDdjNH?=
 =?utf-8?B?OGdnQk5DK2FjTWkzRThsczZ5L3ZYSFdNb2ZISVNoUEZPOURDYlJsaVlEaDA5?=
 =?utf-8?B?RFlLdGcraHpHbU1LcGVXb3NiNml2TUdhd2I2YnpFbDdYRUZVdTBxYjlCdStz?=
 =?utf-8?B?Q2hRclRLWEEyL3dyTVNqV0tvYjQzbEpTZ2NlTExKTUhJRFN1QWtSUW1KYURL?=
 =?utf-8?B?SFpYcTRueEdrZVZYdkpVbkVVYXRIWW1OZ2R6b0M1NFVZSTg4ZUd0cGQrODlz?=
 =?utf-8?B?TUZkYWhlQ1g0b0F4YVQrQjNXdWIzZStzK1MyYUtNbGh4eWJWbzlBSkZkejdD?=
 =?utf-8?B?V2U4VnkycnJEUzAyMndIRFBwWS9Ta0orbXZTNVlPZnlzOUZhWmJleEFhS0xZ?=
 =?utf-8?B?ZzNNVVBQV0grbHVpTUp0WDlhcE1TK1RVNVdZVEs3U0FTQWttK0praEl6a2VQ?=
 =?utf-8?B?Qy8rY1dvY0JOTHlmWWxBaytSTVo0V0x5bFJlczhJTHRJV3Ric0U0SUJTYndG?=
 =?utf-8?B?MVF2eXNXRHBhWFZINzZ0MjhRVzdxOWttMmFsOFg1eFNNR1N0UjVjZ3BCZzJ4?=
 =?utf-8?B?TnhDR1hJN21MN1Fyb21COWdzanNuWXNuc3ZRYkdQbktXTWkrdU9XaU12WXAz?=
 =?utf-8?B?eTJmeXZQWHl5WFIra0lKT3NWWG5sTFF6Q2Rrc01EQkhuc2xHS2htTmxLQ1ZY?=
 =?utf-8?B?alhiZ3hFUEUxdkpYNi84bEpjLzE4KzlpaXZFcGRRcTY0QWZPRkMyZzQzb2U4?=
 =?utf-8?B?djlhTk9uOHJCMDBrbWhjaWM3ZFl3NHpOOW9TV0tyUDVsRlk0aEFlWTNyQXdo?=
 =?utf-8?B?YWNSR2cyU2JRN3h0ODJQSkV0MCtxZGltL1N3MU1iV215N1FUMmxjUTJDSGpx?=
 =?utf-8?B?T3ptbHVVejdMbEE5blhjaTFjcnlyeUVKekZJVmhXNGx4dzZqTkEyMi8yRzd0?=
 =?utf-8?B?ak5NQm9UZzVJOE1uMWsyelBhRzVFeHFtQVkvZ1h5ckRlZUM2bCtoamVDWkxw?=
 =?utf-8?B?VjEzeGZyN1dKd0FtTWJsRjVpcitJcTZXYXJkTmxRRHZNYnFFd29kNzAwMThR?=
 =?utf-8?B?MDJhQUdZQXZqYktmL25QUkcyR3hra3hUTW5odHFnWWVHVlBud2hSWExTMVBy?=
 =?utf-8?B?YXV5eE1BOTN2ejgrQTFJRHorZmh1a3hWelF2aGs3d2dSYVZRTHc5VnNQSnly?=
 =?utf-8?B?UVZqZ2t5WVFmaVZIVEVHdEpBb1VyU00yM0w1U09KeW5vTWVMYjZueDRSVmlu?=
 =?utf-8?B?dWtMVDhwdDRMUEMwUmpqQng0SEs1cjRsZFZHeDdRRU14bkpxSC9WWm5CUm9J?=
 =?utf-8?B?S0NQVDkzS2VrYmFHUDhVaVJQY2ljUkpyUU0wNVMzbzRtR1ZuM1FrMWJPZ2My?=
 =?utf-8?B?YnY0c1I5QzltTUJ0RGR4ZSszU28yV0xLbkxYczdUWTkwVkhzVDZsd0pkQVRa?=
 =?utf-8?B?NG9MWUpmRWVMQ1BWcnRKRnVrN082UUl2cU1VLzNiWkpkWStrK1p0Q1puZjZq?=
 =?utf-8?B?dFUrQTBwZGZzZ2xNREVjcmdjanBpR25aUmlINVhYSEFCbS9tR0hTU0U5LzUx?=
 =?utf-8?B?T2drajcyYjdGNU9oQlNJNktEdldNREluOVpZbVRYVFBsWFgzQ3FBcUhlU1Rm?=
 =?utf-8?B?Z1dFdDB6R3pNNlp3N1VrVlIxcEp2YURXcGVwcE16Vng5ZSs4Ty9NS1krT1dp?=
 =?utf-8?B?MktYekR6S2lxSUR3L001d3dXTTR6U25UeHpkVkN1SU1ubUVKa3IzMU16OWhX?=
 =?utf-8?B?UWpxYkw3V1FqakNrUmFiT2pzeS9VZXNKakU5RnJFOHg0U3NtVGtiM3pSZ0V2?=
 =?utf-8?Q?YCZQ5vVuc07Ic?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U21WVTJQQ21ieWpnRnJXdHBFN3R6TE4zQUdnN0x6RElZSHFxbVZJZ3lvdE43?=
 =?utf-8?B?TjB3UERRbW9ZNFQ1NXk2Wm9OQUtSdmdEdkJ2MXhuVHZTTHZVMXlmM3k3T1FQ?=
 =?utf-8?B?RGtCZXg1c2Y4NkhLbVBQeU9SOWVIVXgzcWJlSnB0NkNJL3pNSnZEblZSWHN3?=
 =?utf-8?B?cUs4M1BIOXNNa1lEeElrcVVxMjArUkdtQzF5M0dGQ1N0TmxJTStrWUtrWU5h?=
 =?utf-8?B?SDBEa3ZmZ2lYN01BZW5FWnVIeERza3NkSlNoUHJGbE1uL0NZMXZUN1poV1Nq?=
 =?utf-8?B?cE9xckJrcG9qNzR2QzB0Q1N0dnhtWmQ4RW11ZXNnZ0dBTlUzV0F6cGtFUnVp?=
 =?utf-8?B?aVAwd0hJay9zTEExZ090MnZoLzBkbHVGazJIQkZBUmdQdmJ5dkszaE5YVFFQ?=
 =?utf-8?B?T0xTcHpWQUd0Nm82b0tqMHFXYzliT1lLT2JON2RMQzJOekJIL3R1MzBjL0tk?=
 =?utf-8?B?Wk1RUkQvRFRiTVkxNGpZbnJkOFRETmVHYW9mb2dnY3d0WG51dk5FdTJhci9r?=
 =?utf-8?B?MzQ4eC9RQzBieS9ZcWlrZ1N1VEVtTHRNZi9lakFVeEViZGFqaXdPZm5SZnJa?=
 =?utf-8?B?b0VLN0R0anE0Um5wTzkzWDFXbEVhRnVCZ1ZzTVJJQnZ0a2swMWZaSThzRnFJ?=
 =?utf-8?B?MDNzYWtTU1ZNQ1BMYW9idkw2Z055WU1UckVzR3gyMmZHN1RwUmRQaXljU2FJ?=
 =?utf-8?B?NFpab2dtSUs2a2xVZVpjdlZ5WkpmODllNDFFTUdORk9NSXBoem5sbTVleVlD?=
 =?utf-8?B?M1BFUm9lY0kyYkJYTUhYVzUvQUtuL1BQUDZNSm5tT0x3NVJvYVFiMGN1cFNP?=
 =?utf-8?B?R0Z0bkwxK01QdkNaZmlCYjVsYjZBYmg4Yi9wWFNaU216RlRxSFI4M3VMRzA1?=
 =?utf-8?B?NlA1LzBtUStLSHgrUkMxaHFucEFsaGFQVzR3KzhmeHgybUJVNTFqbjk2a3c4?=
 =?utf-8?B?MjdqQVQwUmx1ZE5uWVpPRkEyZ2VxMkVzbisvdGN1YXpSM0IwRXZTaXlIZzg5?=
 =?utf-8?B?TWZkY0ZGQ24vdnpHb2VTcXFPU3Qyd1dkSkRORzQvaXZqak84SGpoN2M5NGlo?=
 =?utf-8?B?Zml5dWRibDBrdGZIL1RjZnJTTWZGUWZVMEVySVk0ajc1cGNVaVFOUGhiS1Q3?=
 =?utf-8?B?OWFkYTNVTElhaXJiVWs0NHQzRFZlTkQzclpHRkQyWHVHMDNQNVRHRkJlQ3lm?=
 =?utf-8?B?ckpWVERUQTJVRHpwRkR1cUlHOVdSeG0xZngyUDREQm5TQWlpc1psWURMSWF3?=
 =?utf-8?B?N3ZYWTczVnREL3dsTTQrZzFYckFwUjh4ODgrQXNzVlhzQkpGclI2UG9iVXVz?=
 =?utf-8?B?ZXFUeDB6YVdGQjZNMFVuZ0tRT3lESWtVcjBoVGxQclBLcmJnbkNTNDZOVkhU?=
 =?utf-8?B?VzFzSEdWeDhkS081c2wzQWRCVGJaTjZPaWk0YzdvV1pHODZRRnlmamxwNkNh?=
 =?utf-8?B?SmdWU0NyeXZqSlVVMXZUdDVmTUI2SktFSXErMFRHTG96bG1UQ1pNT0RlZVRq?=
 =?utf-8?B?MDEyRUt3RzFEUWxnRmxDbU5XYXdreTNaZEx2aXRyVjR1S0N1RzRDekF4bzhW?=
 =?utf-8?B?dXFLOGJ5S2tkQ1ZhYnp6MktBVDVSSGJuRm9vdkQ1SHhmSW8vdkhSbDk0YXZ6?=
 =?utf-8?B?Zjc3cmt6cVdZSDhKVWZGZHlWQ3RCQmNTSGl5ZDhra052WkJMVzAyVkZ5YzVQ?=
 =?utf-8?B?RXRJaWVLWndzN3FmN003bVdVaGpHMDV5RkZQYTdOQy9KZ2VLUUMvT2g2dEE3?=
 =?utf-8?B?YnVEMENpZ3FyY201dDlVL1diOU5zNGlFOVNLZ0VBMUZsY3dOTUJvVyt5Z2dz?=
 =?utf-8?B?eFhsQVBiNjh0UnA4UnZwRytxYnVQTzFrdzlHODl1ai93TEFmUmtycGtQTEZS?=
 =?utf-8?B?RUZkNGI0cGhvU3NUYStqNGNNWTU2WW1kUVZKZWp2M2MvSGFyUzh2RlBHVGxn?=
 =?utf-8?B?bTZwOENpYzVmMDRKMk1hQ0kvaDM4NmdzU3IzY0xYTHlSRGJUVFlqZUtEc01C?=
 =?utf-8?B?SldiYjM3VzVGUE5ST21STWE4b2NzUHI2Myt2UHRDQUVDSjhQcUF6QzBFRzdq?=
 =?utf-8?B?dWJ4enNKUXNFZzBvRGZjMit2eUZZMFB2WWtPUnpTU1V3dFBpQmdvMUNNdlBS?=
 =?utf-8?B?Y0ZHT3VPVjl1bUxtOTJrMVlDK1REak8vSkNGei9PYWswS2U2bElYamJNeW9w?=
 =?utf-8?B?VHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d87eb62a-86d9-4a8f-7ec3-08dd6120eadb
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 04:46:56.5348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CIYztqmTnIgmgG9+Wvo/EyydKEs5B04I9A7JDQF57ISJPVKR9pc/x7ALpIkl9HiAYKt2DpzzHnBY5MYmVJc2uU868FJXaffcQ9HiW03ta1E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8755
X-OriginatorOrg: intel.com

Hi James,

On 3/11/25 11:36 AM, James Morse wrote:
> The struct rdt_resource default_ctrl is used by both the architecture
> code for resetting the hardware controls, and sometimes by the
> filesystem code as the default value for the schema, unless the
> bandwidth software controller is in use.
> 
> Having the default exposed by the architecture code causes unnecessary
> duplication for each architecture as the default value must be specified,
> but can be derived from other schema properties. Now that the
> maximum bandwidth is explicitly described, resctrl can derive the default
> value from the schema format and the other resource properties.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Tested-by: Amit Singh Tomar <amitsinght@marvell.com> # arm64
> Tested-by: Shanker Donthineni <sdonthineni@nvidia.com> # arm64
> Tested-by: Babu Moger <babu.moger@amd.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette


