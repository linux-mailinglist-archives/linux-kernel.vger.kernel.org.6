Return-Path: <linux-kernel+bounces-254488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C5B9333C3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 23:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 575DD288EDB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2840813C80B;
	Tue, 16 Jul 2024 21:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j1ly/iS9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D62C1459E0;
	Tue, 16 Jul 2024 21:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721166246; cv=fail; b=V4/YckHn8dKDcVHJDX8vPgweu/YTJW3wy4C4+cembCm0JEZRzoGRavmpe4NRr7mMwGZOP5IOBl/lREwEDCRxzquhsrTjJRDgad9FBiE94yZ1vTxSTSQH+m4rT64BOVWexRUmoL5+3+CaoftiID+8ca4CMD1IZfOLpp9o1hH4lVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721166246; c=relaxed/simple;
	bh=iiTQBvlIUdC25JD+rPjDf0RjEeiIIyKbL8hsZLXeeyQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r+RxT0Ey7wAbBo+oi8fgA44hoqyXuAGbYa8n1anwJjr6u4EHWjxBi/iQwojTr08iHeP1M2VL7g6A2c6MCSHvstCnYLW3IbZGQDMAUvan1427ECnHc5rguCsVeeYl3Bl7GbewWzlwlm+vXDOCEN1CpIcOWPYJyNE0SLAA81mKKjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j1ly/iS9; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721166244; x=1752702244;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iiTQBvlIUdC25JD+rPjDf0RjEeiIIyKbL8hsZLXeeyQ=;
  b=j1ly/iS9iUGKS5DZG5lD41ZFLNBO8CuDPAeaVREF70C4itIdCqj00snu
   M7WS+XWzCHW1kvw1EcA7jTpZUrBncx4BaiWe9SZjEzznty6ipe8O9hVVf
   Hzh+0sdPGY2xvofZSUj3YQAw4ZibCp8YQhu8co2XgQA5nvtVLRvtbocOy
   ZF0kC9xf/FphUF2LhxWd1tmKBhWjwr369a75EMmp7GIdCACzCsj0X4Z6P
   sw4Noe6ybsKorU/d0/iltPbw2D5wBXI65cNL/kKV/jHCw1XzRk94LtzW3
   BKTPCV9kO0gP0jPma0Dw+YLVfymTbUpvnlpgke/xIEPNfeedwQ/NdZnGh
   w==;
X-CSE-ConnectionGUID: hLhbi25HRniu4qd3XhYXDQ==
X-CSE-MsgGUID: Wz88vpKMSt2il6D8pgFYuQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11135"; a="29244625"
X-IronPort-AV: E=Sophos;i="6.09,212,1716274800"; 
   d="scan'208";a="29244625"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2024 14:44:03 -0700
X-CSE-ConnectionGUID: EYujh76WQn2HFKcpGVVyQg==
X-CSE-MsgGUID: KIz3wAQGR1eS4DVw2shEpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,212,1716274800"; 
   d="scan'208";a="50067509"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Jul 2024 14:44:03 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 16 Jul 2024 14:44:02 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 16 Jul 2024 14:44:02 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 16 Jul 2024 14:44:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DTpaK/T1/TGx7aciBrv6s0Yg6wZvUvooHzgGWGT7BSWnDHAhlMWW7is9MJWPw40BBWt+B/fkGbQqcxcUtZfzbNsdup3hS72oGzmMflnrJUhYKc1aspDj6ngZrq1iBtBgCKwk7gBYA9nzmpk6uS424Z0BocNKbQmLTf8Hu2DHr6WYWs9518zRCcRWZ6NT6TZNGGXyy60avYzUTCXFQFDsdcPEal/JVOy9uKrQGB/+9mFUbUZTbqr08M4gAiZ7LzEUx6wpDldIVbEI2wYDPAT/tarZzZMp1vaBbaGVGzlEbSsQNyStT9Ucl9nEf0lhq0jdTgk8bKPmkyDYFGYzLATb3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xEAOim2HUrCQGH6d6sPj4cVSRKgOva9u3h+YIpWyhLw=;
 b=lHuGMJivvKIV844ItBQOIK2RcWAlnsn8+dUEvnB62sImQoRqVrBRURsLQrAnGySVXBjo8YRErDlzvU0actCcsDJisKUpM/UxPMo5/fvRPd4avXNeTCqKb4UzBIZkzYJGJGSO9nOocCNz00oqYWVqIrIDNuHwiW+LVULWzWEq2aC5SdHZ62e6nUEUQq84VgJJt0YNFJag/N5rF+Ngcj4kEJbRoZYY8qcX3awFCH2tzWavylrGJT5l1H/mAvEeTaVqNKCiSd7IY6wLSe90gs05yoqjtdnoGOFvYKKtAMY6NyV895hQGpxiWHTDJVOmeC+BNWFCeT7Dh2FCkgXNYQJs0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB8249.namprd11.prod.outlook.com (2603:10b6:510:1a7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.27; Tue, 16 Jul
 2024 21:44:00 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 21:44:00 +0000
Message-ID: <cb908d7f-db6a-4b04-8867-bf36fb2dd45f@intel.com>
Date: Tue, 16 Jul 2024 14:43:57 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/resctrl: Use seq_putc() in two functions
To: Markus Elfring <Markus.Elfring@web.de>, <x86@kernel.org>,
	<kernel-janitors@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, "Dave
 Hansen" <dave.hansen@linux.intel.com>, Fenghua Yu <fenghua.yu@intel.com>, "H.
 Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner
	<tglx@linutronix.de>
CC: LKML <linux-kernel@vger.kernel.org>
References: <d4be0dc8-f6db-4bf1-bb6d-ccff161dfde9@web.de>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <d4be0dc8-f6db-4bf1-bb6d-ccff161dfde9@web.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0098.namprd04.prod.outlook.com
 (2603:10b6:303:83::13) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB8249:EE_
X-MS-Office365-Filtering-Correlation-Id: af45d531-6f6f-4720-be9b-08dca5e06734
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QVk1dkwzdDZZMUpZSE5zeXJNUkllbG9Yc05ucHJQQ3FOa2cwNW1xbWdaNk93?=
 =?utf-8?B?TFJOQUh6aE8yNEZBOERTT1ZqR3U3b2ZBd2ViZUxKK1EzK2kwb2VOSkFhRDln?=
 =?utf-8?B?UjdjNTY4K2hYa2xKYU5seG1peUlwbWFFS2R6WENWUUhnZCtpK0xZamxYSGRN?=
 =?utf-8?B?TW5TeklIMk5yOElLcWw2QmtoQnVaODEzZERSZzdISVlwaUJFR3R5ZlpyVlM1?=
 =?utf-8?B?bTd6NjFuTzR0WU1DWWR2OW9ndDE2MlVRcjVjSXVaSXpHdUtjOFcrVXFSaTRh?=
 =?utf-8?B?VGtqUFFDclV5UUJncEtsNzBiY2x5M1RBR1VVMEhYVEk3VmlHSnUxZmw5TjZV?=
 =?utf-8?B?RWRDR09FbTBxc24xb1dmQmg1N1YwK1Z6TU0rdnVlZHNoYUNaNjBVODVhSE5Y?=
 =?utf-8?B?TUVJOUladmhOSm5ucm1FV3gxL0M0S0YvRk9PQ0xSRkJWNmRBd05teHVHR1NE?=
 =?utf-8?B?akJLTW14WEM1UDdPbE5WN1JJK3lLOFNFSlp6VnF2S0twTlBDd2dlSVYwQUlL?=
 =?utf-8?B?UlBLV1NBMVVsbnR5TTVSc1FkNmZWSjg0TSswNE84OWh6NzVKYktPZk5UR2Rj?=
 =?utf-8?B?dlFlMnlHSnRXeTdtU0ZScVZWY1pmTTFRSndMUFF4NFBCSDIyTThyM05FNFdr?=
 =?utf-8?B?TU1IQXlPbHA4cGZXenAyNHJEL0tqeWJHcyt3WTFIR0xEZk1GanQyY0FUNm8y?=
 =?utf-8?B?T1dqS3BOaDFUaGZsWlFNVmExTUpkb2VHeC9rbUYxb0Z5UGIrU2NxOXVBRlFm?=
 =?utf-8?B?Zm1Bc2xYcGxZRDZ3ODB0VWxhRXo5enhKV3cvY1UzTGhzRDNicmZjT2o1Y1ZD?=
 =?utf-8?B?UnhzNFREbkRnYjBZZXpCRGg2MXY2cWN3YTcvUGJFTkVXZVJVMXhPckxKWHB0?=
 =?utf-8?B?NXJ5TkJnR1pYZ1ZRL1VyQkdSZmt1bHdEclBESndmY2M5b29kVTlwRDhjc2xS?=
 =?utf-8?B?MGZuNThhcnY0OUNLY0tORytRVWJ4b1VKRlBrbGJJSVowdWk0NUc1R2U4TVFq?=
 =?utf-8?B?emtGcWw1V20wemFlcVFEYVBFdWNycUdqd2d5RHh1RjdkTTVWZ1NGRHBRYTdP?=
 =?utf-8?B?bEtBN2owODkxbFJTZGl6NWxkdjh3SGlCbTJEVzc1ejBUZUVsRnVnQ2dBWmZO?=
 =?utf-8?B?c3RFMDJHelB6TkVpeGJpNjl3RzhhczJHY3VHZ0Rzb2ZIajMySHNtWU9GY1VG?=
 =?utf-8?B?OGhwNFpORjU0WGhsd2RTRXArV1VzM2pGbEY1dnVLblFhanpmVlFjeStFNU05?=
 =?utf-8?B?V0M4S3NKWmw3ZHJ4OHBBQ3NwTEtoYUt0bWdpMmsrTTlHcVZLNTVTM1VnQlcy?=
 =?utf-8?B?a3lwMExXMVFaZjQ2Z2dzdlQxSk9BNjlZQ0xNbXppWGFaeFZ5MXZ2aFhTTjR0?=
 =?utf-8?B?MzhoTGZ0a3FYQlJQMDNjbXRCck9jS1VPdTg1QXhYVzVlV1JhUSswMTJEall3?=
 =?utf-8?B?c3QwOWx5ZzRqZ0pya3NUQ0xtZDlvYThQa3NLY1NKbG4yM0MrRmRTYmsrV21O?=
 =?utf-8?B?V0w5Y1JMT1FQbkQ3OTFid3VmektHeHhpbnZvUVlRSFhuVm5UMFJnZGNqSE8x?=
 =?utf-8?B?Y1RCakRyZlRnTlhuVGdac2w5dVZCUE5zVWN3Q1JYOVdqRmZCN0dRU2lJc3la?=
 =?utf-8?B?ZUFXMWllcy84N0cxTlo0RFF3VlI1em1VRWNLa1dsdTg2L1VwUkZGMGUvYlRM?=
 =?utf-8?B?dC8xR3lUSVJpaHMzV2g4SUFPWmxLQ3BFcEpXaHhkZithSzN5OXZraFdjdmlG?=
 =?utf-8?Q?FFueiUnTnTKqfNbqQY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEVWVExMbEp4OXBLbDN5VkJENU5QSDZpQ0dJNElrMkxDTWYxUFYyTVRVRTdl?=
 =?utf-8?B?cWhsVTBZWlo0QUFUam52MFk3akZ2SmwyL1N2TDJYTDk5K1E1MmxOR0NQdTc1?=
 =?utf-8?B?TnVKdDJOdkV2V3lmTlhsVFYvQlJ3QmkzNDluRDlpV3BhOS9QSmRERi9SRk5t?=
 =?utf-8?B?NEVraGtVT0lkZ0kwVlNWUWowbmxBRVowS3dRVXlpeHU3b1FPZm80RlMvR3hI?=
 =?utf-8?B?cjlMd1gwV2RxOU55b21MSFhEa0FBVVZuMVFsb003V1FCdFdObDh2V2JDN0RL?=
 =?utf-8?B?QlpSYzVGT1E2OEgzL3BNWlNhOFo1bXpNdFdHLzFCYUk2RnB2RzdDcEloelJT?=
 =?utf-8?B?NEgzR1Jrbnh5dDJUS0sxUmJKenFkOTJBNHprWml6VTlEWXRkN1RyNU8xNlpU?=
 =?utf-8?B?RStVUDJySTBuL1BJbUk1R0dPSTA3MFdXQ2Z2VGlzWHFKZjJuOWFPU2F3S0hY?=
 =?utf-8?B?R1didUZsSjRmTHVTNWFPNFRsTFU0K3VvSXNpTXdYS1A0OGl1alQxUy9IN1VI?=
 =?utf-8?B?QmZwUHdUQkNSdlFqdE5EemFYUDVDa1FuZHorRmNtb05YeXVRMnlJeDN4cDAv?=
 =?utf-8?B?N0FNb2NTYXlmU0lLTXZIZUtqM2hiU1JRQ1lwcitNOGFQUGZUMlE1NUkrMmlR?=
 =?utf-8?B?RUJ1elhqNHBqbFlNWWxmYy9pZVFwbG5KR3JUUEdxNXpORVV4dUcxb3MzMDh0?=
 =?utf-8?B?Z202MlVkOFhzN1Rra0tNdW1IVXBlSDFTQzVMUkNjcDhHN2hnOFdLcUVQMkJ6?=
 =?utf-8?B?V3BsaTdRL25MRG1zT0tSdkQvUy9EamFnUXROZisxRGFaU0hJK0QycWZoa3pJ?=
 =?utf-8?B?bG9XZVFDb3pxaEdjbGtHTkdFejM2aW5mSlhPWnl4a3g1dkJzY3U3VFA1Qmt5?=
 =?utf-8?B?QnhhTzFFclRiYVR3TzMzem1QZkFhYU1XTE1pWEZUUlJoaWcvMmxseEFwTE1D?=
 =?utf-8?B?TlhvM1FjcStocEQ4bWtEcW1OVWdGSFpBTkorZm56M09OeGpCR2J4RlBWNmM0?=
 =?utf-8?B?M0dybVRsWFNjek55ako4dVMwZ21FQm9tRWNQWE54S25iWDVaa2M0bGhQTlBk?=
 =?utf-8?B?Rk9lNkZZNzloSjkzN3VFZVkrTnFwbTU2KzNCeUNVaUZBOGZ6VG44R0E2YmdY?=
 =?utf-8?B?QWV6S0ZJNm5jUXhmT0FqQ0dYY2htNksrNmV3Wm1CWnBwQ0xWeEVXY21qTU1l?=
 =?utf-8?B?K3VWTzBNR0NZYzJVV3E0VkhtcnNFcVNLcUs2S01sMmJvanpYN1pSZUVWWWlX?=
 =?utf-8?B?Rkx2QW1SK0MzZUhkVFJOREZLcGRmSVdHUEZzYkpVd1UwMk5ySDBTUzNFRHg3?=
 =?utf-8?B?alVyZk5tSGtPZTlIOVFOOUlxc3ErSlc4elBtQ3lzWGdqeU8yTm1SL281eDZJ?=
 =?utf-8?B?bUlab2haSGJmMys5WnIwK0VsZkp6UWRRVlNBUjNCdUZoNmNoLzJiSWV4Z05x?=
 =?utf-8?B?M1N2VFhvVi9McURseUdLbkd0QlBHbnBUVmhTTlVkTUhOM1NRNEZyQkorVVVh?=
 =?utf-8?B?R0p4NEwxOXd0UUtWWVNwZ2JXVkQyNVdEVnNFRHlwUWhmdlVNV05ZOWVEN01u?=
 =?utf-8?B?alZIVWc5QjZrQTR3NlZyTUluck5lVTY0WTFSNzlZRWFvWVhiVVU3T1o0emE4?=
 =?utf-8?B?UWVWWnlGdENHV0NuOE9vb2Z2VWxiR0tGTXRxakwwOVdJZzJ6QXZVc29RTHRE?=
 =?utf-8?B?ZGZ3SW9LQkt6UkxubDlUU0hHYjVhcStLS0FmYjRidW55NnJnWU5WbnVqQ0F2?=
 =?utf-8?B?bHNVYUd2SU9JSDVibER0WktQV0hGMG5JWTBSU00vdnJJa09OaDhBUFhuKzJa?=
 =?utf-8?B?TEU3czc0Q3F4S29lNG1tK1pFMU41d0h2bGlyaWlLOGZXR0ZSQnNqN2lFWXcv?=
 =?utf-8?B?Ly9OdHdnTlI4b3U5dmFOYUVwcG9SM3MzMW81MFZkQWl0MjFXdWV2MDRSM05r?=
 =?utf-8?B?clF1cFBUYUUvSVlFZzhBOGRPemFtQ3RKMCtmY2syVkJWa2VtZVp0S3ROcXhn?=
 =?utf-8?B?Zm9GQWFHc1pJWjhmcnRsUVoxbFl3OFJCVHYxTEluTUVDMi9PaW9BYkdkem5r?=
 =?utf-8?B?SW9aT2J0bi9vYlg2dkJDUVRnUDZaaURCMVIxUW1vTDYxZTJrYTRmdUxSUHRQ?=
 =?utf-8?B?aUJMSC9DNnRJRTRLV25CVXBrTDNhWDBQanpHdktDLzh3K29VVm1qTmIwZ2wz?=
 =?utf-8?B?RFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: af45d531-6f6f-4720-be9b-08dca5e06734
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 21:44:00.3837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5R3SxwXK4mjp2gLC0pgEtPRnFa5O2AL3y7G0EhIPy+/oxRbMq5AmCiBsk/CFjZyLSBSS8HPTXknF0dhM+riC93cxV6vDDezPmzg/C3N0qtQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8249
X-OriginatorOrg: intel.com

Hi Markus,

On 7/13/24 2:00 AM, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 13 Jul 2024 10:43:14 +0200
> 
> Single characters should be put into a sequence.
> Thus use the corresponding function “seq_putc”.
> 
> This issue was transformed by using the Coccinelle software.

Could you please point me to how you accomplished this? I tried
on the latest upstream as well as the latest resctrl staged
changes in tip's x86/cache but the needed coccinelle scripts do
not seem to be available. I tried by running the commands below. It appeared
to run many coccinelle scripts but there was not one related to this change.
Is this a new coccinelle script outside of the kernel or still
on its way upstream?

make C=2 CHECK=scripts/coccicheck MODE=report arch/x86/kernel/cpu/resctrl/rdtgroup.o
make C=2 CHECK=scripts/coccicheck MODE=report arch/x86/kernel/cpu/resctrl/ctrlmondata.o

> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>   arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 4 ++--
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 4 ++--
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index 50fa1fe9a073..dce68f19c29d 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -452,7 +452,7 @@ static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int clo
>   	seq_printf(s, "%*s:", max_name_width, schema->name);
>   	list_for_each_entry(dom, &r->ctrl_domains, hdr.list) {
>   		if (sep)
> -			seq_puts(s, ";");
> +			seq_putc(s, ';');
> 
>   		if (is_mba_sc(r))
>   			ctrl_val = dom->mbps_val[closid];
> @@ -464,7 +464,7 @@ static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int clo
>   			   ctrl_val);
>   		sep = true;
>   	}
> -	seq_puts(s, "\n");
> +	seq_putc(s, '\n');
>   }
> 
>   int rdtgroup_schemata_show(struct kernfs_open_file *of,
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index d7163b764c62..d4e216073e7a 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1605,7 +1605,7 @@ static int mbm_config_show(struct seq_file *s, struct rdt_resource *r, u32 evtid
> 
>   	list_for_each_entry(dom, &r->mon_domains, hdr.list) {
>   		if (sep)
> -			seq_puts(s, ";");
> +			seq_putc(s, ';');
> 
>   		memset(&mon_info, 0, sizeof(struct mon_config_info));
>   		mon_info.evtid = evtid;
> @@ -1614,7 +1614,7 @@ static int mbm_config_show(struct seq_file *s, struct rdt_resource *r, u32 evtid
>   		seq_printf(s, "%d=0x%02x", dom->hdr.id, mon_info.mon_config);
>   		sep = true;
>   	}
> -	seq_puts(s, "\n");
> +	seq_putc(s, '\n');
> 
>   	mutex_unlock(&rdtgroup_mutex);
>   	cpus_read_unlock();
> --
> 2.45.2
> 


Could you please highlight the benefit of this change? Looking at seq_puts() implementation, thanks
to [1], it seems to me these seq_puts() calls will result in seq_putc() anyway?

Reinette

[1] https://lore.kernel.org/all/a8589bffe4830dafcb9111e22acf06603fea7132.1713781332.git.christophe.jaillet@wanadoo.fr/

