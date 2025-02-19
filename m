Return-Path: <linux-kernel+bounces-522680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDBEA3CD39
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 00:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 018643B6C57
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 23:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECC1257457;
	Wed, 19 Feb 2025 23:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A12QfT/5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CE21DE3AE
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 23:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740006951; cv=fail; b=gpbOvJBolJlWbhmjTWjODrY8TZWi/KpvzYkGuUOR/trDHc6ye2gNKnSiMwNcylgw4glaePucxFisxhT8yUCdJ7N6lLfxRougqj2ws9ybJUOONQDqo/jWn/mjkE8sTdzS3koecBVUEsUhgkxtLqMgC9q45OcsJbi0HFVaP92By0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740006951; c=relaxed/simple;
	bh=/3LPX0PA6MJkoqgdbI+gTOZud09yywOgdoF8m8RkVns=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QLWXE0pOXEiUgXAEA9h1gXPWw8m0H/mu+StGQpJQkdqr4JOgPHsndmpf+FmhEHht5oj1eVQ7it/oupOCywJepqUDu0Q1A7HwD2ckuwLTXnC//S5hcDeqz3ULvBzgx2BuQuXbhn3NeQSumBimKQFGkIvJ3s2oUK6Gvm6K/s1ceDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A12QfT/5; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740006949; x=1771542949;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/3LPX0PA6MJkoqgdbI+gTOZud09yywOgdoF8m8RkVns=;
  b=A12QfT/5g0FTFhptnCFPTqs1ahUAPI7Wyr9gBEyhFq0xr3t29NH0LamZ
   SzxaRzHBogpQL6mq+CLHAxmP6eO/e3IwfX4Lh9HpPftzItDnuaxsieymH
   jO5WaAdulVjfVlSfYsMHmQCc6tBvRY1dnY1EVZTpuHLVJN7XcSEHEiZcq
   wg4nrZmaiq1jXrNBgvhicmLvJkPZXibezSQDHYKLFlxfxT87H4HALHIQp
   jp7/uHl+WiCNvlKfwgH5hNBpSKRN2hQ+FHqOuu90AAFx2x3rVYO6em9bf
   09xe10sj64dwe6I3PO4FInU4QYarIEY3L+yYwEKmerGIabprSKheHSQBU
   w==;
X-CSE-ConnectionGUID: bssfUX2GT+qozNekyCus7g==
X-CSE-MsgGUID: yY/0K0cVTbq2xaBV3+a6bA==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="66123822"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="66123822"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 15:15:48 -0800
X-CSE-ConnectionGUID: n8rlim9ySNWQEcu4E1+RUg==
X-CSE-MsgGUID: vd8+ZN63TVSVLGkJvsvyxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="115341171"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Feb 2025 15:15:47 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 19 Feb 2025 15:15:47 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 19 Feb 2025 15:15:47 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 15:15:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uum1Ti0EXgJ/g3J8CvoWhI9Wwk+qArds6IUOVIzp+YhzqIhLVyrPwOOWkuk7koiyUR3YC8NyCTARs6mChNEtYdSfJpSMBE46qKTLmmD6syK0GXRxU2iw27ZcOey0Sqzyh5h/XGr/8S0Uc3GcmHazvzPt9hKpu1H+v0eWXC+o0IYtPszdRexFPdGxenmi3KBa7YorSD52iREdUht5DLVXQsOKAl0pubJ+BP/BvL6h/V3R+ATtzywBdtTM4BfXdQkeBpKhpm5JjS4Wk/2rj7x6VlpsDzn8rYeabIIKdj4oVZI8Z/5zm82nN6HnlaVjGhBvyEr9vX+akXTLORNlQQ9b1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A/wF3c/11hNivkNopYykx6fw23MBDwciF6Rx5pW2gUI=;
 b=fEDPZhqhnDO7UFx1N/hK23vN+A3qO+9Rs3Gg7Sq/Z7HnketYS7ubI+QKu2iE+QnuDUU0xW/f//c0OdU9Ooicgc9l8Bo2uyKJRQLq16pTu7t788Z6B2EDFSZmPoyymxCda5F+KuxfBvsEBykbE9JAsx9O01VumIaYnDyEpcvJsBO40oTUi6coYGhp6Frz1X8XeYPydNTj+GtIeGlIYizC7LHWDj6+3vi9CKytVgfxUtBb57D50xYP8reBVf6z/+XKtaSyDe0f0o6RKOsA9D4vVLApLyU70aaGN2T5XcvXTb/xq16zefnVp1JAH0de5fjeYoA/IiOq+Xj6/7yP3UIvYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA1PR11MB8857.namprd11.prod.outlook.com (2603:10b6:806:46b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 23:15:43 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8466.013; Wed, 19 Feb 2025
 23:15:42 +0000
Message-ID: <d2203ae2-d0f8-4dc6-b6e1-3871f7a44c16@intel.com>
Date: Wed, 19 Feb 2025 15:15:40 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/42] x86/resctrl: Expose resctrl fs's init function
 to the rest of the kernel
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
 Donthineni <sdonthineni@nvidia.com>, Shaopeng Tan
	<tan.shaopeng@jp.fujitsu.com>, "Tony Luck" <tony.luck@intel.com>
References: <20250207181823.6378-1-james.morse@arm.com>
 <20250207181823.6378-12-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20250207181823.6378-12-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0177.namprd03.prod.outlook.com
 (2603:10b6:303:8d::32) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA1PR11MB8857:EE_
X-MS-Office365-Filtering-Correlation-Id: bb532a47-ce04-4e7a-3237-08dd513b54f6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ckFrd1IwS01TelVRekhtTzZVcVBsY0xRYzJRazFtZVRIWm0vdC9SSzBSV3Uv?=
 =?utf-8?B?eEhvVUZ2UTRlUGROeEJ0MlNoRWxyUXlPYmhCbHAxN2UvREdYekU1K2lxL05z?=
 =?utf-8?B?TU9JekZqYTFLNlJPTmN1Y3EwTnN2b2RldXpoeEtnYnVjTE1PYnozUHJ4Q0Iw?=
 =?utf-8?B?ZSt3aGFLVnVoOUUxeXFXd0d2TjlxZVU0MGVlcU53cGJCSmtha2U3KzVudHlo?=
 =?utf-8?B?T1IySFBPZkUxdm1GTmJLWFhxMk1abk5DeXFNSnZZS2RNTm91RXdCN0tNaFM0?=
 =?utf-8?B?Z2xObjZ6WFk4aUhMOGJvVXNtcVFDZk5id0VGY0M1MFNVa0lacC9PSXNCUS9X?=
 =?utf-8?B?bGs0bmJZVGVyRlpYTVAvTEhjcTJFVGxHTUtUSEx2SFMvcnphWFQ0U3AveFU2?=
 =?utf-8?B?T0E1cTB5TmNDNmVIWmEyN1F4NWMwYTVRb3pVSHFjdWVXenZBbEk3Z1BsZXZN?=
 =?utf-8?B?TUw3bENmamxMVjhkdkNselZ5R1M0SGlhUnc5QUNrT3hOckhmQkdBQUxHN25T?=
 =?utf-8?B?cEJqOHJQckxBYXhUMTNDMmJSZlc1dDFKZHMzdktFdm1mZkFtRmp2WEZLMUdx?=
 =?utf-8?B?Rmt3TGMvS2Rja3p5NnIzT1R4bmsrMFF6MS9pTWJjVUdaMWtIL1FxWXRYc3lo?=
 =?utf-8?B?N1pwaVBUcnNLeDdQNzZldVBFVUIxNmwxWEJiamZBQit3VWt4dUtVVEpWQmhN?=
 =?utf-8?B?ZTRjYVV5WVBnZitzbGtRRTc1M0UxK0lmRmJzOWtzWmdTMXcwdFZwMS8zUnZm?=
 =?utf-8?B?Ykc5UkpMVHkvTlQweWNscjFEUzhSKzhkVk5CbDMwQjRzdXlpMmtsdEtCQm4r?=
 =?utf-8?B?NUpGMnpMeFJaajQyOU5nNmNaU2IwK21tUVpqSEVpSndBQmJRMzBXc1FqV2p5?=
 =?utf-8?B?ZnVRcTA3ZzhhTHVuZk9XWDVQejM2aHQwcXMwSHlXQzllYWorUGZEOGpXdkQy?=
 =?utf-8?B?Qk9FMGtDT2tyc0owZU1xZU54b3pUbUZNM2pWV21hUXRldkN3R2V0RSs1TGtD?=
 =?utf-8?B?ZUxYeEdnMlpMbEtrc2ZKOWxQZU9HT0tiNTVEYlcrNFhmem9aV0s5VTdDZzc0?=
 =?utf-8?B?TjNSNzZRL0hzRkhiMTNoNDR2ZGtVWUtpRjVpb3NxRmx0aEhKMHdXNEJqUHNm?=
 =?utf-8?B?STZIaEw0QmpsVkxlbWpkUi9QK2dXY3A3QWlobkxDWi9EVTNxaVVac2hKN3lK?=
 =?utf-8?B?UnZSNjBhNk0vc2hrdmNkVTE0RS80R1NrRGRCTVJYbkpLbkNaOWI1SVVpeEtr?=
 =?utf-8?B?K1BWcXYyeStKK05TYjJqWk5iMStjT0djTWtQdCtTY2RJbVRlTFJYV1lwcXlN?=
 =?utf-8?B?eG12WW9UWUViN055UGZsMGRTY2dGdUtJSmNReTBDMDRZTmRmM24vZFdzdkwz?=
 =?utf-8?B?dXJpOVdIMURiVW9NYVlZd2JtcHY2ZDJZRU4xWWFhS3NqT21IOWUvaW1RUDZa?=
 =?utf-8?B?K3hsTmtLR2FpKzVnU2Rpa1FXWkt2RU9VdG41ZkdQMFRFMCtqVE41R2dRSkZv?=
 =?utf-8?B?UmJ3WVF4NXNraWEyUm5EMmt4cy9aSENhTi82ZlgwNlhvb1QrMVhzcUFNWnda?=
 =?utf-8?B?ZHhXM3laSzUrZjB3UkNLNmd6a3JNTTlETXNndWhVeW9WY2c1OXM0Nzlpb1dq?=
 =?utf-8?B?Y29JSG5aWTMvTThsd3psTFZjakxCWFk0MmF5MUh6cmw3WnlZQ2piVXhURjM2?=
 =?utf-8?B?V1ZTOEkxR2FJU1lMQnZEVDlIV3Q4RUplWi9tdUliT0JNakJlQ054YmxrS0xL?=
 =?utf-8?B?dmdnYjNjOFczd0YrM2JGRlE4a3Q0UEltam10RnR0OVlJandtS1hCVmJocjNa?=
 =?utf-8?B?RHlTdkRobStVamJGaHN3bWtPTERyRnU5SFc4RzZSTDd6TDZNVGttZitSVjkx?=
 =?utf-8?Q?BzeFCnYmG1UGv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkpnTDJGOEJWcVMxRkJNR21UTk9YS1BHSWxZUDEweFltejZHdkM3bWFvU1po?=
 =?utf-8?B?STVMa3pQQ2J0VEVrRDhaMlI0MGdZd3NKUlAwRVUyeG16blExM1JMUVNENkNy?=
 =?utf-8?B?MlJhbE8yb0VBb1FVNDRmbEc2QlVhUU8xSzFxcXh5QkpGQ1pyWmRkZk1Ra3Ba?=
 =?utf-8?B?SUNIWTFaMEZUcTRWcG9UKzFLdzk3V0Npcm5zNXFydDNCckdSZlBaRDVZcXpr?=
 =?utf-8?B?bi92NXlaNDRXRkQ0UmE1T0lJQ3Z4NDNEeEhObHhQWkpJMlJhWDNhMmJQZ0dM?=
 =?utf-8?B?UU9yMmNEOUJ4TmU0NVZYbUg0SWIyZ2t3QTJuUnpDRmxTQ3dFY2lNM0JPbW9C?=
 =?utf-8?B?ZDlOaFVXSmU3QU1DZ21GZDJRckdaSG9WY2gwOFhFNDVlRGttdTR4QkI3eml6?=
 =?utf-8?B?VXIxV0cvaHF3MG5xSlI3aXJrWXNidlRCKzd5RlU1WDB2ZlVjZ0pSWFNoK01r?=
 =?utf-8?B?U2JhcFEzRTBBUGVIMVc2UzFsTDdZR0pqWHFXZFdTcDhhdEx1MWRLMXNXMkdl?=
 =?utf-8?B?d0ErVUhva1p6UzQ2RVNwLzZkNXA1blp3NmlhQ0J3bTRoRWtsc0V2VzNXQS90?=
 =?utf-8?B?Y1ZTYmxnSWdacnpnbTBrbEFyNStnVTBPdGlqZnZhTjZCcGtjbytxcThnL1lG?=
 =?utf-8?B?N3piZlIrY0FDNHdoM0hmMEhwSGRQZUhQREtMSDNteWF1eUh0UkpXSm9EYXNZ?=
 =?utf-8?B?cHhMaVFrekFXSGh4RXozZE1nY1Y0UmlkbUkrSmNtc0pISnBRT3doSXEvS1JV?=
 =?utf-8?B?MGx5enZsZlU0WFFkU2ZaSG4vSnlFZ2tlR1p5ak9Da1JKNkR4VnlDYmpsaDZK?=
 =?utf-8?B?Zk5YazBhYUY5Skxid0FKVWkzRzBQRTRpdk45OUEwTy9sUTFNTlVvZWFTTXNz?=
 =?utf-8?B?eEFoVjJnUTRFc1YydStVbHgrdVlWRE5nemlNNmlrYlA1OFNjK0RWTjR5dUtt?=
 =?utf-8?B?dGlMbmdERWtQQURFd2VQRUUxU3BNamdzSUgwWDFFZ0lPa3hRdFJEVHAzZk9j?=
 =?utf-8?B?dExGYlQwb1JWUUl1Tm93YkVTVDRIbHJPUkVuSXBJS2pUTy94bWxDak53WS9E?=
 =?utf-8?B?d2dzaDFlZUJyTXBLa3Fhc0xLWngrenJrWXhNanlpQUE1MW5qTUZGZUZZZFUz?=
 =?utf-8?B?QjhtQ29YUFVUUFhxc2wzZk5yd2lqTUxoeW9pSHh1dDRXcXluanN2UWVnU01Y?=
 =?utf-8?B?bVBvZU9XQUtWYndvT0JXeVJhUEpNWkVQQUNjNU1vNWVmTnh6QmF2MEZuN09z?=
 =?utf-8?B?a0RUMjY0Y1dwc3piNzFyQU5MZk5xZTZiMjdTTVoxbEVjYzZ1Wmo2OEFWVHVO?=
 =?utf-8?B?bGJEcFQxWkVXSU1VYytCSTA4RDloTW81bWJNVm9hZEFQK0xZYVBad0M0djZC?=
 =?utf-8?B?czhhakZSbXhTYnh1cWw0Umo0MmNWOHM5VXFMbUJmUlRjL0YraEJlSHNQQXht?=
 =?utf-8?B?a1Z5Qm44VFc2cGNYekFJTGE4QjN4aEFpcVdZOUJvMGw0MDEzVk5ITWVLenlW?=
 =?utf-8?B?ZkRnemgrdEVpZGZFYktyc0o2di9HY2RvM2ZLTUFRNmpyQ3pUOXFRVGVWQlpU?=
 =?utf-8?B?ZVFla1dkK0RieDFmQVFwYmVkVzZVaUVUOHZvOWd3dklSTEMyb1VCQmZucW5m?=
 =?utf-8?B?MXFudEFISW1kR3VOYURWUG1GS0lHTzNMMmpmTnhudlByWWllaUlNdkdwMkJt?=
 =?utf-8?B?ekxaWW1GTUVRaGhOclN0RjZybzkvKzRKMGE0anFoN3VRZGhkUnhOMy9SN0hU?=
 =?utf-8?B?WmlEYTFReFY5M3M2QkErODYwdVJVT1dJMjBxakJwSllzcEJnMmM1YTNSNTZB?=
 =?utf-8?B?OTU5aSsxU2tPd0RvL2RZMkc2V1lwbko3dGo3VVhYd0g2QTB6Tjc5dHdjQVpp?=
 =?utf-8?B?a3JYL0dISkxSWVVERG9HNy9xb2ZKUDJRcVRPSXl0OE8yR0d6Tmd1bkNQYnFi?=
 =?utf-8?B?cHhpZ0Z1dlN2QllIanVVdHd3YWVjZm5pR1hoamJJN2tUaU5JbWl6QnU0Z1Ex?=
 =?utf-8?B?bndRZ2hpTGUzOGpuN2JscG9DNEN1MFQyMWFicHd2MTJNN2RhcUYvRll4d1l5?=
 =?utf-8?B?eVlPSmorMHRyMVEydDBhSVpDMmo0SDZCdjNkN2txQkxrYmgwbUNyTTY1Y0tR?=
 =?utf-8?B?V3JFWHpieC83YU1jMWQrVVBXa0lsbC8yQWtNSWdFVFE2SE5mbGIwUmk3Rjh1?=
 =?utf-8?B?cEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bb532a47-ce04-4e7a-3237-08dd513b54f6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 23:15:42.8128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C/j07/MbsEzc/j+BVD4bc6k0ZyWwsUPZ6NCCZ+bRA+CHvX8LtU4AJo1Sgk244LPXiU4GytoeW8DCJw5YEt3fEtV9iarJ4+RdUGDoWayL4Wk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8857
X-OriginatorOrg: intel.com

Hi James,

On 2/7/25 10:17 AM, James Morse wrote:
> rdtgroup_init() needs exposing to the rest of the kernel so that arch
> code can call it once it lives in core code. As this is one of the few
> functions exposed, rename it to have "resctrl" in the name. The same
> goes for the exit call.
> 
> Rename x86's arch code init functions for RDT to have an arch
> prefix to make it clear these are part of the architecture code.
> 
> Co-developed-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette


