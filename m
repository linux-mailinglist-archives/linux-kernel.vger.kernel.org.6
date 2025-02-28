Return-Path: <linux-kernel+bounces-537675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9D6A48EFD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 04:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7E173B7B05
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 03:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF97B19341F;
	Fri, 28 Feb 2025 03:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QG8UOfN4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79929188915
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 03:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740712266; cv=fail; b=Mw3inbvLOorpwlPCbASHqqRYP0lqbbqFVkWdT6B2GmOT0CIoYNgHfTgr6uy3ZdzMPv2uw/2dWYePFzOdxiebTPPFTeIoCFxztIA1gSw5K8sQG53/zmvLIna3sN7EK1AVMJVnyLVc5DGP4/Ztl51/RR/gvmsa63lWovb2DFMJ/N4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740712266; c=relaxed/simple;
	bh=kc0il8D8hKx5FVor+geWUKhNUHRWz8jVF38asWQ7zZw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Uh1BHSrK0sbALk+93E2U+DBsjQH8Cq9NRn6DC8zEQqIS0rRrnvq+qQ5/GHAzZMAWeIJ1H0qDUnOXpY0WR4uA5cdns/QPr1i0ycXmzP1ByRAWRh+ES4oLk9zydPKDDlCRoG9MZgaKp6c67Va10/Qmg2xYAL3UUsId9gGc76derFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QG8UOfN4; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740712264; x=1772248264;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kc0il8D8hKx5FVor+geWUKhNUHRWz8jVF38asWQ7zZw=;
  b=QG8UOfN4NkGR1vsmnmNlNaO+9b373dGcxFYdcDrWeCv07SW0zuwTpPbs
   jYPXc9mfvE9jsHs5RQCKomgLKaQv5sIVBu10/paHw2xZ5TT7nulFtlXUy
   cZ4QPVStAWOsFikhsfh2VQsVC5Oz80R5rIfjTua8+NUQQZVmPXco5sOy8
   30c/sNfphugM9NHeTqwzDDemeqeygwVPysWBp0zn8uyRdDdt8ypcqdIuU
   6uzJbV0exyCN6GY3ORhX0CDskZnizkCo3HerZsh5VGpF71890Ql2bL1zN
   0rccDrYqvhSRRF1dge1NEYTCLNWvjiYgDA4Ozad68w8DI9vTFZFai8cko
   A==;
X-CSE-ConnectionGUID: U1AxkWk2Q4WIon7v3Hsb4Q==
X-CSE-MsgGUID: i6ZzeBVXQ0GE6OI6oszXiw==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="40806117"
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; 
   d="scan'208";a="40806117"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 19:10:56 -0800
X-CSE-ConnectionGUID: q+B9s+0NT5Gx4oM4XakarA==
X-CSE-MsgGUID: e+M04XiURwmJxCn0QQ9+Hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; 
   d="scan'208";a="117244527"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Feb 2025 19:10:54 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 27 Feb 2025 19:10:53 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 27 Feb 2025 19:10:53 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Feb 2025 19:10:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BNf1sT02zeMbpZRwNIVJLzfR1gi4txpi28H/yF0BOLkPbSGF9aiDd+k+jKMHEXI1z/UyH0nNINAI1QJUROUlp6iIDofKtYDeoFWqlmwm1eXswGdJWbR91MplZFSzmH3lDKB4sG2Xw+gi2V1TytfAN7sVeR9iR7NEL7Pz5dE8lKdCGu5S7ntjvj4Uvlj6kRVhzPcx7I7R0IIlwBrPrVwK2vN6tyz4tbyltfOjpIQ6NsE/IyVO7Qk/ma2i6XsS6dH/YgKX5KSNFWQGl8Ii/21BTkObjMbn2vZx7MKoBO8W9olY6yfnESbhVf19rGlE88kMwPyTQbzba0Z6nafZkR4DNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6S2zTD+C7dSNrcXW6N5+84N9WLRy101mmCPMnWTcoXw=;
 b=sxbh2uzTjlWCKNfXEQF89XU4oKmCtFigWWgZyXSEbKMNNEIPGYaVqRG1TBmVA6stvnXJqUosOavJNCrsbk/kVa2Jt2ijt3F5hxntyK2Kz9bikvlKRS76bgkJBxfKWE0HBZs3LGvGXE5QkKd3oRJ362nGN4Rjlu3MXoAUWgyqkaaucz42JJN6SbMo5i8GZB/ccPPy3MCYm/ec09gBE5M/nKxVMk0UaT2wlHtGm6irvQXwuY1uSNzgkPOcRG4joWXrKCrW7I698D6KyXZK+qNqab1X4inoXZX8+qiBLQ7TkvHfyxxU9MmvSDa2W/S98/IVqMZX7kLrSet9G52kSGeVpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 PH8PR11MB8259.namprd11.prod.outlook.com (2603:10b6:510:1c2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 03:10:50 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::b1ef:c95b:554d:19c9]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::b1ef:c95b:554d:19c9%6]) with mapi id 15.20.8489.019; Fri, 28 Feb 2025
 03:10:50 +0000
Message-ID: <9381647d-de62-4c72-9b1c-930cbd9231d6@intel.com>
Date: Thu, 27 Feb 2025 19:10:48 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v1 02/11] x86/fpu/xstate: Introduce xstate order table
 and accessor macro
To: Ingo Molnar <mingo@kernel.org>, Andrew Cooper <andrew.cooper3@citrix.com>
CC: <bp@alien8.de>, <dave.hansen@intel.com>, <dave.hansen@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <mingo@redhat.com>, <tglx@linutronix.de>,
	<x86@kernel.org>
References: <Z8C-xa7WB1kWoxqx@gmail.com>
 <94083f1c-dab1-4b57-bd45-a4d4f8ac262e@citrix.com>
 <Z8DFusMiUYPZ3ffd@gmail.com>
 <ea20d47e-88b9-46ab-9893-26bcf262d8b0@citrix.com>
 <Z8DY7P6UJFyCg47Z@gmail.com> <Z8DZcj-jrTJIOat8@gmail.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <Z8DZcj-jrTJIOat8@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0069.namprd11.prod.outlook.com
 (2603:10b6:a03:80::46) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|PH8PR11MB8259:EE_
X-MS-Office365-Filtering-Correlation-Id: b641ac39-04d7-46e1-b0f3-08dd57a580e3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bUZZMlBJeFNpTXlKWUNteGgzOWdGcVZUdU1hM2FCaUxqUHZjVm1MQStMOGIv?=
 =?utf-8?B?OS8xRkFFcVd1bUZPallxRlIrOWErYXcwYjlVT01STjVKRWpBNEFFODFWYUUv?=
 =?utf-8?B?bGxkNzFhQ0JDSGI2ZEFuci8xQUZPRXpacko1T2JGRmNXaTgrTSs5Qlprb0sw?=
 =?utf-8?B?TDJaSDJ6dFpuRVZydVhNUkZhalNEWlZ1bTN1NFMwTWhuakpJcGc5S3dCZXhW?=
 =?utf-8?B?TElVelRNNTlVdmtyOUJJbWlYU1BRRE1EZ1dwL0svTTcvczFGcjdrYU45aGY4?=
 =?utf-8?B?SHFMR2wybGdRbzhaV3VKeW0rQUdaSFZWM2ppSFdBUllDMjNKRzhObThqZklp?=
 =?utf-8?B?cVhiaWFqMnFDR1BybUg2cHRoay8rWUhNMzRmNEpwczJMdVkyVk9zMjFpNUVX?=
 =?utf-8?B?SFliKy9UK3NqUHVPS3FJemVrcjRkSlJRQzFIWHB6aDg2cW5oUzluQkVGUHJC?=
 =?utf-8?B?eXFyRkhNRVVnR1M5NyswTDBVelIxNzdvRDFxUStPeHVxNE5qUE1NUytrOWZG?=
 =?utf-8?B?eHFTbjg3VkxJaGZQbXJDS1NYOWdEc05SV3ZoOXVXOGp3V3JOVVdsOVM2dkFE?=
 =?utf-8?B?Qnh4WjYyZS9EWVFtRlJDNDFPMFVtQUo3K3lCNGw1dGJ3QWxUVmtvSEdTb1pF?=
 =?utf-8?B?a3VHWWswdUdPZ2hCNEJXOEZHME4yYW5wU3VuWldyUHFid2l5TXU3bVhyUnNh?=
 =?utf-8?B?RkNpYTV2UVRmUTBMNUJFT1hhV3dHOURCNjNiM0taWGN5STNUcndvRE1aNHlO?=
 =?utf-8?B?UXZHQ3lTMVhxL2l4cFpZM1BqNy96NzI3aHlrUnd1Zlk0VHhnNXVRSlRPbURP?=
 =?utf-8?B?UHJDcG1wYnZGcVE4aVgvYlVTMk1uaDdGSVRMc1g3ZVpISXplcDgxZitOb1RV?=
 =?utf-8?B?QVBMSWI4bEdiQU9hVmczY1B4MDFEZndJRXNURWxsSzhqWDNYanFTU2F0aHJP?=
 =?utf-8?B?a2U4SFBzQkpUaWlBdWdjdlZNWi84dGhzTnlGYnE2NXMxMjFhOXNRS3NlMkpC?=
 =?utf-8?B?d0FNL2c3eWVoNmJQcFc0ckhWdDFDaVFzcXlvTklQbklja25pa0E5cDhRWGNv?=
 =?utf-8?B?ZERKZ2NOSWJsR01ydUNrV3F3djdDTzQ3ay9kWldMTk8ydkQwdHRpNnl2dEFx?=
 =?utf-8?B?MkpDVzNDU2xHNmVhRGdkLzR2WVFLclVyTlpHdHdTTzJQQlhKZS9CV3ZLNnE5?=
 =?utf-8?B?WUFXOHB2Q1I5WW42ZStwemwyUG1PNFVwUWV4YlhRcERsRHhiaDdGN2tkcjlv?=
 =?utf-8?B?cGRXS1lWendWMXdURm85S01KcDRqd2dFQnNTZ1hLdXNaY1FoN3BQdGx4SVZT?=
 =?utf-8?B?NS9CRkxoZTdwaVMyaWhneHM0S1Ardkc0NU4yUUZQc2VLZVZlZFk3bUVLdU54?=
 =?utf-8?B?bEN5NC9HRHEzTWMxWFBYZlBTa0crUWkxdzkrNmhaQk1uWjJZamwxby9qVkxP?=
 =?utf-8?B?MG5CU3VMQXVQS3E4Lzd3YUloQ2EvYmQ0VUZuKzVidjcrc1BQMDB4TUdWcERY?=
 =?utf-8?B?ZFoyS1NFZXpKR3JOcjhpQ2ZHS3NaYU16aFlnY2FOZ29vbm1GU3Y4T3dacG9l?=
 =?utf-8?B?aisvY1BJZDRlZHIzVjhkUTBrQXJqU1VaZWF4cWJNZVpiTm5WUFBRNUdDUkdK?=
 =?utf-8?B?WTVZTERzMWdxcUdiY3ljc1d1U0RZeEtLek81aWkwZnpRSHdCTTVGREVTWlU4?=
 =?utf-8?B?VDhoMElXeEpNZG1mVlFRS2M1TzZvZTJQT3FCam9Wa0V2ZDJzaHdmRWZpb1JM?=
 =?utf-8?B?eVNGSVpwMnJtRXR2MFVQTXU1c0V5RXhiTXRjTC9JV1d6M3gzcEtlRzF1emZo?=
 =?utf-8?B?cFVvN25aV2k2MzVrZFMrZmJySFdYRU0wcGVwT3g3RXpRMmQrOW01YmdHVDk2?=
 =?utf-8?Q?OMqOtGp04Fkr0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFkwazJEdEkwMXltZUJhZ0FheHpBS0M2TVVkNjdzbitKNmo5Rytac3Frejht?=
 =?utf-8?B?NkNxTGtWWExpRTRGOGgrTUF4ZEhUR3dkMExZYXRBTUY1TXduSzlvVzJDYjlp?=
 =?utf-8?B?eWlMRm05bm5OMGUvalZod2pVZGJwZlpBSVdER29FQWFCWjNxTEpHelhCbXhl?=
 =?utf-8?B?b05UbFVNSUlid0FYWGNxME55RDZmbS9aM2tCTVFNZHZLd01jOWppeFRkMElV?=
 =?utf-8?B?WU1QY29qT2RxL3FJVk5kQ2ZwUDArNFYwSmFheG9ReXo3dU9ybVpTdHVlTmk5?=
 =?utf-8?B?Z0kzeVFUNHVSYjlWWm9RK3I5MHRGWFc1UEZYVFd3eEoxdFU0d0JFakJlc0Z5?=
 =?utf-8?B?RXRKMDQ3emhLT0FUTkxlQ3p0SlJsMDlEZmgyTnh1Q3lSWmIwbkdiK1pFbjdk?=
 =?utf-8?B?ZnFxV0J4TjNwYy92Q1dVQldnS3ljaHpka2d5TFUzdG5xSzFMZ09seWpQdTBj?=
 =?utf-8?B?RjAvNWdyTHI1ZXZDOUxMNFcweHBKc3pQUzh0L1JpaVNXT3FaLzN4RlpVNElP?=
 =?utf-8?B?TlV3dG9YbzlYU0ZrMDNCbXNsaFEzNVJVT09Ec2NPUXZUTEo0MURzbWpGOHlH?=
 =?utf-8?B?MlNxcGtZQWJ6TWhyQ1NFbko4NjNZdytoeHVNZzVCeHhRSm1GRjREYllBb0Fa?=
 =?utf-8?B?N1NvTmRybFVScjI4UXVZRG1IdEFqWFVsWlRVWUIwQkVRL1pmbnlXaXpZdlZq?=
 =?utf-8?B?b3F0OFU3MVlOV1hRWDEyanVJVnd1MzhXcU9SalM1TElKN0p3SklvcTlvWndJ?=
 =?utf-8?B?Z1BZR0FHZHpoVzhLcXQrQkpNSlcxZWNNVHB1ZmEwbFRTaEwrQmJzQ0hYam1G?=
 =?utf-8?B?OUtGM1pmQnFhUUJ4T1FqbWhhM1BlblUvT01yZTl0bEE5Rm9GTFBlWnd0WUZE?=
 =?utf-8?B?TjIvbnNDc0tieWZGMnVkSCsrSUtGNlRoSi9KNjJ0SS9IZ0puQW9UL0JvdW5O?=
 =?utf-8?B?cGhHOFpEQWJsN3pZMk9aVVpNSlZvS1dGb0JrclRLdE1NT2hXTzdQby9wMjRY?=
 =?utf-8?B?MVZnNTZTTlZ1QUZJOFd1a2h5UHhvZ3p3T2Z0dUE1OWRGVDd1MzVHR1hFQ2E1?=
 =?utf-8?B?LzQwTXFoSHhxb0RwanEzK0kwL3c1MVVhWk40dG52OEpNLzhlMlR3eHh2YUNx?=
 =?utf-8?B?by9CMDNNYkgwM0YxYmdleUErOXZWdU1XNjRVSm1icjBicDVMbGMzbkorckM0?=
 =?utf-8?B?ajJaVnUxMVFVVmxYRk9jZjJKVXh5cEVjRktiTXROWFpPSHlNbmdEM0JtOXg3?=
 =?utf-8?B?QWhRc21wQmZQTWgzUU5qSEhaSWhITVVValNVUGNZNktoSDVMSDd6bmxrTFlz?=
 =?utf-8?B?T280cEVoN2YzbWFxQlp2Tzh6dU5NM296UklmdnhORmFlYnBnY0w4Z09Mdk9G?=
 =?utf-8?B?YktsblZZWmlzeFNHamJiOFNhQy9NeFFhcWN6Q0VMQUJWUEcvRHBPOTIxMkY5?=
 =?utf-8?B?eWhlUnViSk9lM2VCdWt4cGh6ZjJkTW1IMkR3VHBheklwTTVac2RNSDRQUis5?=
 =?utf-8?B?NDNZWlBEdXhvOFo5VW0vT1pvU1pnUktZMkgvL01Hay9ETWFrNVUyT2hpUk92?=
 =?utf-8?B?UHdyQmVDY2RYRk1XQTM3MXgrYVAyK1VyWVhHL2plMzh5T3ZOUXo0cXhPZzVu?=
 =?utf-8?B?SjNKWEliekx6Zy9OK0lKeGZ0QVJ6eFdrcmlMZlpLdVREaUpaUE1Xb1pWWTZ2?=
 =?utf-8?B?V1dEZXgvY3hRdlprTUNObGxUYnpiQ1dUYzZibnZVQVl5YUc1TEJTZUVmcktt?=
 =?utf-8?B?V3pXUU9KYVVLTFRYMXNkR3lqNWw3d251bGR2aE9nRk0yQ1U0WGdORjI1R29Y?=
 =?utf-8?B?enlyalgzejZQcXRnd01vU1ZlMXJVMHYrWFhtaUY5dEk2alM5MUlkRnpzQWxR?=
 =?utf-8?B?cnlnOWloK2lndzJCa0lsWGp1bzNNUDkwRnphMForRWhNS3FSNy9Pc1hTT2M2?=
 =?utf-8?B?NjhnMmxScWQrNnczUno1VW5rYXVIa094MU5zdEJpY3hnNXJmREtKcE9qR00v?=
 =?utf-8?B?ejNhWXRVVlhWYndHWnJqUXFrRkZwUXIwbS8ya3d1V05HV2ZkUFRaQk50L3ZM?=
 =?utf-8?B?R0dQdnhUdndkbDhiS2Y4dGlUMXprOVpHNnFhbU1HUWtOeExXUmg4d0J3M2VF?=
 =?utf-8?B?V3dDRVl4elFnZTVmZExSaVphaUd3eXlITHZlM2FNTmZaTFJKbDYveFp3YlNn?=
 =?utf-8?B?Vmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b641ac39-04d7-46e1-b0f3-08dd57a580e3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 03:10:50.2012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8IvKHbS//v2oRh8MKgPIkCfb3t6ueozgLkps4TPJGJ/4tJz6p/+Bzub6YHnIiOBX6gERLGMg+GMSg86pfZYfew3zRepNBrSMHymEEIiqlsQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8259
X-OriginatorOrg: intel.com

On 2/27/2025 1:30 PM, Ingo Molnar wrote:
> 
> * Ingo Molnar <mingo@kernel.org> wrote:
>>
>> I propose a new addition, an extension of functionality: if a new CPUID
>> bit indicates it, and a new MSR is written, XFEATURES bit 3 becomes
>> active again - and the MPX area is now used by AVX. Obviously only
>> AVX-aware host and guest kernels would enable AVX.
> 
> Erm, s/AVX/APX ...

Just thought of another aspect of this:

I'm curious about how core dumps should handle this. Initially, an 
xfeature mask was added to the software-reserved area [1] to indicate 
which xfeatures were present in the layout. More recently, a new note 
[2] was introduced to expose CPUID-reported size and offset information, 
helping tools like GDB. From an offline interpretation standpoint, I 
think these bits will become ambiguous without further extensions.

[1] commit 5b3efd500854 ("x86, ptrace: regset extensions to support xstate")
[2] commit ba386777a30b ("x86/elf: Add a new FPU buffer layout info to 
x86 core files")

Thanks,
Chang

