Return-Path: <linux-kernel+bounces-577551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86356A71E9A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 19:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4DD21899CCB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 18:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F16924EAAA;
	Wed, 26 Mar 2025 18:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h7bfrsqO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934FC1DD539
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 18:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743014655; cv=fail; b=T04/mA5iNbOOQjw/jW7ACGF5WhL9UCLO2nmvP12CGAoAOUxsr5PNve4EPoFw4ruVv9CK+VozjIGg+VwdWjs8D3YKgdNT15p5G0K86BnHsYPS7QyBYXleyXf+F1uTCl/Ti1wJT4ALcRSGDAGPoSWwsdte0KgfqZU+zid1odtzcck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743014655; c=relaxed/simple;
	bh=lNmkyXg520fm83RqAD4ydF4PzGXdHxSdD43q9DlYH1k=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tHHCnmnrQHGa2S+e8pRrcfBV1OFJmHmvqz2YHxbC8/tzkZSDHn4EQwKVtJ/PEuzJdvKjoJbqpRbc+c2wTkv3gXXSqMATBQrxJHnlWy7rmPxFCS0Gah9E/0w8iFk3aLevpF3ivjccyBs5hKMyCcyx8qdjmcjEzLHTkdcQamgjeIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h7bfrsqO; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743014654; x=1774550654;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lNmkyXg520fm83RqAD4ydF4PzGXdHxSdD43q9DlYH1k=;
  b=h7bfrsqO6OxFpLfHLZhuHDDQnghCSz5kHdsQSp8EJrXilRlvMep+4M3K
   Xd2IzPqRSTLtiv2NjANJAI8ob+h4EPIhvxSEleBcaolmuNGFNibrGopS7
   crA64UqXFRp4N1ZpEYXNEE2B6X4U9GHh0GkgnFmzw1jc6SlUVO/f+iso3
   0n7LlZBCfKjdJ8mzImnQKU7n+4WP5MqPAH0UqXRcMYBBnTg0TQxkkGbdB
   b0xnd8A9riWWmAGNugcjE/AUlz05mlqDOXHUWm9RY+arzfQszqV5I4GPy
   N+UMqnoVuBeUvhc89tCIT1JXUSSDjKBMYD5TjrM7Lt8zvoGLddS0uJTc5
   w==;
X-CSE-ConnectionGUID: J2VXn4qgQGum2vriMrRjJg==
X-CSE-MsgGUID: m2J7AAabQIq5b3WeJ3Ky/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="55689594"
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; 
   d="scan'208";a="55689594"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 11:44:13 -0700
X-CSE-ConnectionGUID: 8Z6cbgi0RAa7GH7CAkNUoA==
X-CSE-MsgGUID: MlpDD8xrRNGygHNf2JLHKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; 
   d="scan'208";a="125331036"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 11:44:12 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 26 Mar 2025 11:44:12 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 26 Mar 2025 11:44:12 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Mar 2025 11:44:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B5f46cxUC9k8sT1JdkUnk6ShJU4c0XgvLbXymBhTt1pZn8h8cnu1Dk623n6bTogXdi5PbknaCtFyPxZ+o1YGQYDdqlRdboeCcQR3EeHOKzAWcygjox86UxD4JnoDZ+qelVM68LNi6AVXUOtFtp/ay6Lbro7crnungp7l9aTDMwjp3CNHIDd72XRWds62ltMGAaY/ntOp5pONlFgOpZ9vD9P/E3Q0owNd8ADH9RtSsm38IC0y2Y5p82nRaa1nY7Mp9rM3PkiW6CzeUIqWtkFYFmcyKbo+XKQpfvHkpZ0qFPX96oy6LHU97p9WGPgBox6YOB2SwKsWNclHWtoRcXlNCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rDFOcORFiOrfdxYOWJRq5QXjxd0avhyZdL/naHs3D38=;
 b=ttt9OHoIZhUuC0l2mXc//2uMtT1wjVjeqyYkl40LYxWoAFnAtZkcFcggQMKO8nS699bJxYLJKXEQNGBjpgCpqkxhTjYdNg3rHeSiKUHRyou1JQJcYAz2E/bpxiwI4prB9CuV3MXRzIbfpeIQhiMmS+oZg8C/nkS3I4B+MmIPWflEA9Q5vxeqXfTVTXtZVVCLFBCrqmKAQVWWzls8LHEYCA5l7Sz/zEqgq3AD0z4APmvojjwSGx7H28aTbljtBKjc8a1ZYKbh95pXIBKuS76WYG3ehRAqU+XDTgFymM2QEa4kxlNvdZC4xw6Q4SzkkHDIDDgQgjdH2nd1+2tMn3Uciw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 DM6PR11MB4723.namprd11.prod.outlook.com (2603:10b6:5:2a0::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.43; Wed, 26 Mar 2025 18:43:42 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::b1ef:c95b:554d:19c9]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::b1ef:c95b:554d:19c9%6]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 18:43:42 +0000
Message-ID: <ea72062f-e529-4b46-801b-b230571a1c62@intel.com>
Date: Wed, 26 Mar 2025 11:43:40 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2a 4/6] x86/microcode/intel: Implement staging handler
To: Chao Gao <chao.gao@intel.com>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<colinmitchell@google.com>
References: <b01224ee-c935-4b08-a76f-5dc49341182d@intel.com>
 <20250321211909.13927-1-chang.seok.bae@intel.com>
 <Z+O8DK5NZJL43Nt6@intel.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <Z+O8DK5NZJL43Nt6@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0211.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::6) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|DM6PR11MB4723:EE_
X-MS-Office365-Filtering-Correlation-Id: 847771af-4a80-4f2c-fb83-08dd6c9621bc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V2FBaGF1Y2R6K3cxcHdFQWN1Tk1Gc2lNUlYyNDlSZmtlUHdLR3lEcGNjQ2xW?=
 =?utf-8?B?RUtMUEtqN0EvdXpVY0oyRU9WNHNyZnhnNFFrY0l0YVA2RUlUSW5BVHN4ZDBB?=
 =?utf-8?B?OUU4bUJ6YmZTMkh2eEJHZ2pSYlprRDJnN01ET1lzT3ZBbUpleVRoekJIYXpX?=
 =?utf-8?B?WFlBeXlBNG9Nc2hhMndvUWFxaVkrdzhiMjl3a3hBOWVIS08vMTEvMlJqTnR4?=
 =?utf-8?B?NXJNdHp4QTRaS0g2TXBMWHNGZTJjN0daOGNhSUo1VGRJbVMwK0J2TlIwdmpl?=
 =?utf-8?B?WDlWNEZKYVJvZHoxYm1PaXExVFRXdEZDN2VuUmVEMFo4TGxsY0Z5M0VyQXZy?=
 =?utf-8?B?YU9rNHg2a3ErS0E3RlVQOGxIZ0YwYVdnRXE2azZIZVR2WUQybXN3TldjUTJ2?=
 =?utf-8?B?WEZqRFdQRjV1amNNNGkxNkdYZWxVVWVvZjJRSmR6K1dSQjhHeU9ralFZQkt3?=
 =?utf-8?B?ZzdId2hnd2NPRkgxVnlJLzFHdFpST2pMMmpwRlpDRUZPb1FJSGpBL3hYbzls?=
 =?utf-8?B?dCtUQmJOYlYwdVRIUDI2Umo0SytxU0VVV0tyemk4Z0x2MHJzaGFZd1ZRQ1FZ?=
 =?utf-8?B?N2RjV2RtY2I1SVQrQ1RxUTBaRXl4aUl5aUdORjJqYkxpMVJLYmtpRE5NdGIy?=
 =?utf-8?B?NFVoaDlyaGRPYUlwZ0RZL2tSY0dZTjRqWG9Yd3d6a3RjakVUdENJL1hZNysz?=
 =?utf-8?B?OVNobmRQUEo1YzRLQllwaWdqZm1RUTFTTkxJaEthY29oZUdzZFNIMHplTVF5?=
 =?utf-8?B?VU93SXlzK0Z0OTdsSlMzSjhPQjBnY0VLM0pzSkpjQ0hpWWdURXNXVXZkTXor?=
 =?utf-8?B?bGRkM0poaHJCcm10anN6d2hDMEc4U2dFWFRVTnRVc2orMENIditLS0RucGlM?=
 =?utf-8?B?VXFteDlHbHpiaDJKemYra3QwaE1jMlZ1MkxPSStKcWhLNU50MVZ4aFFxcnh4?=
 =?utf-8?B?dlk5TmROdXlOd1NMdmNKZk56cVNDaTdqQ2laUVdtNDhjSExySGhpbTFzVDht?=
 =?utf-8?B?REEvOWxUVFFRMitBUThkMzQvUFJRY2JKNmN3QmNDWFU5SjBkNlplK3pCbVRK?=
 =?utf-8?B?OVErK2lTUjVUWmN0RU54UUV1SDJhNVNOUEc2cHN1UnRNQlpYa1BUQm05V2lQ?=
 =?utf-8?B?R2hvZHRWSk1tdCtZNTZXSWhuTFg0R0VDeFRrcEJSV2svcFlWM1ZobjgrUS85?=
 =?utf-8?B?aUxNY0FlNks1ODZtRndwQmswZmhtWDZlOHZpSXQ2d2g0TGxjRFRrSklMOXJW?=
 =?utf-8?B?cE16K1cvL29jc0ZUeXg3RzYyWUFDRG1wbndkK3R3SDZCZ290S0xhRWhuMGtJ?=
 =?utf-8?B?N1VyaHVBNTl0cFBJWUxMeVUvdmkwdXJTb0hHMlh0cEJDQ1UzRmxMb2pXSG41?=
 =?utf-8?B?c21MbDZ6TXE4UGxKN3M5UGZuY1FKMU9zOWRieExaWnNJRzhCQUcyekFMcHR5?=
 =?utf-8?B?VTdxUEhzd2QwUloxTGIyaHFNVG04dlM4aXVkczFZUUlFcW8zVEdlSTc5cTVw?=
 =?utf-8?B?ZDhCNzQxazhYeEgyR01sLzlxeUszcXM0WnhTRlJsamZxdXFCM0lZRDNEdHV5?=
 =?utf-8?B?a0puVnQxSnkraEdLYzlROWNmOHl4dXVWNVY4b0NlaG9wU1Rjb0NjQ1pqa2xi?=
 =?utf-8?B?YkpzQUt6b0ZkMDd6YUFlNlpMdVdMUmM0NzdGeURwa0xqSU5CdnM5OHA1TGVW?=
 =?utf-8?B?dXJGODNoREV0Z081OWpmeTZPRE5ueDFGSlZ6eGxlODU0cm1xbnBUZDlNNEVR?=
 =?utf-8?B?aUxVSUlHVFNIcWJuckt1d1JkcG42TURITlZmWVJxRWJQOXBOT3MzM3ZQM1U3?=
 =?utf-8?B?U1llQVlHUlBEOHpUOGYxVGdidHJhd1RWYTVtbTVreXNzcjFrTmZqeEdncXYz?=
 =?utf-8?Q?kxjys4hLg4v0X?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjZ6SVZDbG1CNFFKWTJ0V1k2VjVjbnVrd25xZ21ZV0diUWNackFxK24wTFNs?=
 =?utf-8?B?MTJzVncrcjJFRTJSc1lVUit6dDA3RW83UHJmQWhlYVcyc05LcXo3a1gxRUZL?=
 =?utf-8?B?VjJMZWlZSDk4ZlMyb2ZXQnp2eE1lNmRISDBIVDdydnk4L01sLzdWWHFOUnR5?=
 =?utf-8?B?OXhCR0lnMDhKcHRTVEl4Z1BzVE1aRURiMWJmcVpYdDhlMkVmc1ZEMFI0Z1pI?=
 =?utf-8?B?aXkvYkdKNDdvZ2E5SWdEZFVlM3F4R2lINkZQVUptT2UydnZpQWxKbmVzcmVT?=
 =?utf-8?B?LzZpVkxYTFBKQjk0SGZTbCtDYTZBeWowdVpnT2p4WlFERnJKZzZnNHZBQWpR?=
 =?utf-8?B?UnpQVVZmY3VRTnphR3V6ZFNkam5IMldYcHZOL0EzQXdldDlKRjQ2VmxJWUx6?=
 =?utf-8?B?d01Kek9XTzEvWnJVVjcvazE3MVVXL2paMk9uazM4UmdkZWJpS0MycXFXeDVR?=
 =?utf-8?B?M2FKVFpwd3p0MFpFSFE4VWdiOStRS1dxMzhJWFVLOHBuSE5BNHhVN1RLUDFS?=
 =?utf-8?B?dktmYUh5YUpPK0h2NjB1ajZ2V3lZMmtvRkd6NG1RSm1KeFAwaXFwN3UwdUJM?=
 =?utf-8?B?UE10b2d1TndMNXVXTnJmc090Z2VoNS9TYUFzZWhkc2p6QUJ0Tkx2Z0U1Y2Vj?=
 =?utf-8?B?WCt5UGNHZFRTNUNzUHhzdUxyR00vaHBkbGJIeXp5Q3FHVm0zUWtSM3ZjaEJu?=
 =?utf-8?B?OTl3aXZTQnpCQ0M4SFFJR3R0Um1KNXcyTklYZVh2Wm9WNHV1VkZsVkN5ODRI?=
 =?utf-8?B?NmpWYTVQVDBXVGs2WG9NTFNVajhJQXRxZElvc204TVN0OVZ0dXJsd2kxYnYy?=
 =?utf-8?B?UzhPWm9oQWZrdlZLeGFFZkh3YXlIdlNDdmU5QWVhcEQxbGpWNVdId1BLL2ht?=
 =?utf-8?B?eEo0c2NFamhwYlhMWkxuTzU1QjVBOHpGZGlmQjNLTmRseFEyb1lyN2hJNEdq?=
 =?utf-8?B?dmppeDl2RFZCL1ZjL1hSS0pvU0ZGRDI3RWdjZ1ljNEE3S1hvUzZFUlV0Witp?=
 =?utf-8?B?VWJBQ1doZkl6L2JZOXJxSjdnU0lXcGp0b1RQMkE1ajhMSlVkdE9DbTVIc01r?=
 =?utf-8?B?NVBhQmdRZUhWRjZlSWRhanpveWVTM1lyblA5cGs5T2RrUVphSzJaSmsrY2I5?=
 =?utf-8?B?cHpZSjhJOWhwQkoyYTFKNXdHQ3JZN1crakxLSWFvRDd2YVBmZVNFQ2FUSTVR?=
 =?utf-8?B?UHFJcHZzMlRRT0hDaWVxNVhienVrSWFySWhYeUFSOWNSL0FDbkdOOFZoT1V4?=
 =?utf-8?B?NlZhNjBOSVVCRTBXdUtoaEFRYWJFSEVUUHk4ZnVpbFNxN1pkbUFGaXZKSjFk?=
 =?utf-8?B?M28zYjFDRFJ6dFM5YmFVcmcvTllaRGZjT1AvYUpkd0JiNXhVZnFGODZHN3N1?=
 =?utf-8?B?UmpKNlFFZnFjSEJGbE5pRkhOZzFHMXFiQTM1ZSs0YytIbkV6TmZ0T2ZkdUFV?=
 =?utf-8?B?Z0xhRHo2WWNMbEVXRTJyRXZFWSt1NXczcm9IcVYrM0Z2ZFh3Y2JZQWRDVXVm?=
 =?utf-8?B?WGVGendoYTN3cXphdUNFWkJIWVZUc0hYalp1QTdOSDdMYUUzUm9CRnJhVmh1?=
 =?utf-8?B?bmRNNE9pd2RrRk5jQlBkejhXbHptSjlhUFdkcWNCZ0txUzdDQzFBQk5EV2xR?=
 =?utf-8?B?Mkg5YUlmL0o1b1hHZjlJUDNRS2JlWVhEaDVpYTRweHNnbDN1R0VzNzAwUFVm?=
 =?utf-8?B?ejJCTlI2cDkrNTZ2M0h4b1QrTHRrTkw2V0xNa1M4R001a1FvWFZXVXQ4T3R0?=
 =?utf-8?B?TjliSWhzbGwyRUZ3VFJmSlVwNWZ3Q0RmTWpjaTFCVTZaNnp5ekF3K0VDM1Fy?=
 =?utf-8?B?b3dCcmY4bFZjYkpsVmdhVmdCdTh1OWFlS3BReThIVHloWWltRXhKbnVpbXUw?=
 =?utf-8?B?eVRmSjR3ek81MnIveDdMZTBpQUx3dHljL2p3RVc5MlRTOWZlSDRQVGZOS2pG?=
 =?utf-8?B?TWV3OUphTVVtdWUxY29UbjgxRTlpcHlMak9JUFhsVzVZMzVwRTdzMzVhdDFl?=
 =?utf-8?B?cWF1WTlEeGplQlVJcHozajVJZmhMeXZiUGliRy9ib1dvRFc1Ty92WnZxSTJz?=
 =?utf-8?B?MGl4SUFWY1pvczFZcDVvYTVJaWxlUzYxYnBkYUo5aWNXUU9Xa1JoMlBZYmQr?=
 =?utf-8?B?K0VWUkNIbnZqVUlzNWp1ak1PdXpQSGdRYlo5bFJORHpGOWRoUENVdklOVFdo?=
 =?utf-8?B?dnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 847771af-4a80-4f2c-fb83-08dd6c9621bc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 18:43:42.5281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dszpCJ0NGs3aQs4vIEo2fO8Sux9YXbDGvbmgpO+PHcv4DD7Patd63KvmUsCvltshUbFgndnAH+pCw/KotZchmgeQm3Gr3j4Jz+We6k0/qyA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4723
X-OriginatorOrg: intel.com

On 3/26/2025 1:34 AM, Chao Gao wrote:
>> +
>> +	/* Reset tracking variables */
>> +	ss->offset = 0;
>> +	ss->bytes_sent = 0;
> 
> Nit: no need to reset them, as
> 
>> +	struct staging_state ss = {};
> 
> in do_stage() will zero the whole structure.

I initially wanted to explicitly highlight where these variables are 
reset, but you’re right — in practice, they can be removed.

> why send_data_chunk() and fetch_next_offset() return a boolean instead of
> an error or ucode_state?
> 
> Using the return value to indicate just success or failure, while relying
> on another variable to report detailed error/state, seems a bit clumsy to
> me.

The error state is interpreted at the call site, where the final result 
is returned to the caller.

At the end of each step, all the loop needs to decide is whether to 
continue or break, which naturally fits a boolean return. I don’t see a 
strong reason to change this approach.

Thanks,
Chang

