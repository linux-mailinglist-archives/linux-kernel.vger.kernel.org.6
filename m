Return-Path: <linux-kernel+bounces-188077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4858CDCE4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 00:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 194D91C22BA3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 22:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA407823B0;
	Thu, 23 May 2024 22:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NxkIkcXM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BB1101E2
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 22:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716503707; cv=fail; b=ZyVI6CM5JJf3C6Ma2XmgR9M25pZl7snFhE0yL0unCTkipAfcaOLGlPyQi4V58BpQnWOYlyIOnCnRfC7SK7kKPDxfVFf7SqcIK1ipcHOYx0/cCbtMbCKDi9R32z2CbxNmXtSSYBO3eYJ88JSdXsOfA8Q7diurcKfkvJff+/D9POU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716503707; c=relaxed/simple;
	bh=hxMUP87055P47pUKRTeIxwJ/vt0FDuN30Jn1oiXCK8k=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iNZ345WGKJScGS49gJb1zLjVfhYIOq047mG2253bUNMhPJZ+hXT5wVvDkdJfdNOF+gp+Wiy7UjJva9BBC5G2HoqxpCoKW76WwvVL6BnxjiWWyq58C/bkuPrSkUkQgTMMpRNr44lKkbzVLcBXN8JNMLpnIKnnSLUGkC6anukQ87I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NxkIkcXM; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716503706; x=1748039706;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hxMUP87055P47pUKRTeIxwJ/vt0FDuN30Jn1oiXCK8k=;
  b=NxkIkcXMkvHNTFrOWaZFqpRmoUxMDbOyLeD1e1qZgbVa1shPDtJbSAtc
   +Kp/g2FIKw9eCbL0dXOVweRYKofwpOEXquRGj+XtA8HmzwAIGxfy3iFMq
   YjPjW2Q/5QQ2UhnMnqFL6141qpBVjGJzBkf5+z08tWU/Y55IFy20WgkxY
   4AI+kUGnUdYuKajmXokDpJqQadBcPx22Sj6YEh7IdYyw/9rVv9hh+e6YK
   tiQgW1LdJUFule4kZWBu0FCLPjp9lnWgbVuS+Y5XNILA/vfPyFsvPebDj
   VEdqqSQGsIG3qh6UATVSRWXs6jDRWYPjQm3kUoFp5Envq3y+xDDjGCdUI
   g==;
X-CSE-ConnectionGUID: 01UoxOfBTBWZReloTnqLGQ==
X-CSE-MsgGUID: KVq5V0M6Teyzr6jdNA9v2Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="13038340"
X-IronPort-AV: E=Sophos;i="6.08,183,1712646000"; 
   d="scan'208";a="13038340"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 15:35:05 -0700
X-CSE-ConnectionGUID: 5QT5udH3Qa69byas0anqIA==
X-CSE-MsgGUID: aWhAF0BbTSC/aAWA7jo3gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,183,1712646000"; 
   d="scan'208";a="57061748"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 May 2024 15:35:05 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 23 May 2024 15:35:04 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 23 May 2024 15:35:04 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 23 May 2024 15:35:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NzFauv/pIvsjKnedzp77VOtEY7VXEhYoTMeB1qIdZ6OWmkb955kjhG044cfSij13s1WHRAN7qDlbQ89cyVGrkQ9ZHN5j5cpKhYrUY6uMYe+rEhDuCIiJiMQPevXWfJ7hO1YoKYQLtsO35tpjFxn0GISAvlpGFRNhr2uxALS3bljXAcIkj7joYNeyxcYNQSFlLHYSGqmAV4nrJAxEudRnegRaFehQ8N8cRcSp3+sotOobdFmpiwVx/s6Dk7wX6PqulKwVdLBD/FWx3vuoyJZvS08eCH2g/PqNHCj8/aJehf/OkHY5RinwskGCH80Od1yuAPINihBbS/XV5ts6qnn6EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0g+Ybw3ZrLnpzYFcWHn79UDf+BmRCx1ieB2bQUbL74=;
 b=IZDlZVSAPOkhDLAa3+pkD2m8HYYCO0OrI5oDjka6zli9blIOXbT667zJlp9WgYKDpE54kvkjmcRuGq98ijIzsrfSEPAEcdCVUUAHmZjZkKseiCWB5JIZbEmINZ3S723v8DkmNpETwZwpzt3vTBxou2coUsnCaL4wV4GsYTm+Yfiu1UzcLW6KPLkx1LmrFMPffYSbcn02W9L6zGbIR5iQ6HpJz76wU7KU+H/j+lapLOf9ZMbdqZ9p1RTFp1kga9MMLuL4ZkIYgKb7wv51SXN/NP7gkkmvcwxy4HjYTfBn+giwOPCIQdixNebxi9YX1Jrji98VXJqLZ1sRGTGQlYdJDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CO1PR11MB5170.namprd11.prod.outlook.com (2603:10b6:303:91::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Thu, 23 May
 2024 22:35:01 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%4]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 22:35:00 +0000
Message-ID: <cc57bb62-be80-4c97-a8f8-5cd0548c3c11@intel.com>
Date: Fri, 24 May 2024 10:34:52 +1200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/kvm/tdx: Save %rbp in TDX_MODULE_CALL
To: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>, "Hansen,
 Dave" <dave.hansen@intel.com>
CC: "bp@alien8.de" <bp@alien8.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
References: <20240517121450.20420-1-jgross@suse.com>
 <ohvjbokpaxagc26kxmlrujab7cw3bekgi5ln7dt46cbsaxcqqh@crvqeohfazmf>
 <f63e1217-3dbe-458d-8c14-7880811d30ba@suse.com>
 <2a2guben2ysyeb43rzg6zelzpa57o24ufai3mi6ocewwvgu63l@c7dle47q7hzw>
 <03d27b6a-be96-44d7-b4ea-aa00ccab4cc5@suse.com>
 <fc0e8ab7-86d4-4428-be31-82e1ece6dd21@intel.com>
 <c0067319-2653-4cbd-8fee-1ccf21b1e646@suse.com>
 <6df4fb48-9947-46ec-af5a-66fa06d6a83b@intel.com>
 <86ca805d-7ed7-47dd-8228-5e19fbade53f@suse.com>
 <f7edef9c-5eb5-4664-a193-3bb063674742@intel.com>
 <f02d9ebb-a2b3-4cb3-871b-34324d374d01@suse.com>
 <4b3adb59-50ea-419e-ad02-e19e8ca20dee@intel.com>
 <c7319c0614c9a644fa1f9b349bf654834b615543.camel@intel.com>
 <e2d844ad-182a-4fc0-a06a-d609c9cbef74@suse.com>
 <2e07ebc774bf176ebfab40e6ba8bc14ae6a94e0c.camel@intel.com>
 <a9bbb31e6660343e95d3351febc6e3b9661a7944.camel@intel.com>
 <c188878d-ff67-45da-a963-e643bfb927a8@suse.com>
Content-Language: en-US
From: "Huang, Kai" <kai.huang@intel.com>
In-Reply-To: <c188878d-ff67-45da-a963-e643bfb927a8@suse.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR21CA0027.namprd21.prod.outlook.com
 (2603:10b6:a03:114::37) To BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|CO1PR11MB5170:EE_
X-MS-Office365-Filtering-Correlation-Id: 019cf5c4-3635-469c-963f-08dc7b7894d8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007|7416005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TGxsZUFOUEluelRTcTgrNDR5NjkxT09oK25KQlY5UC8wM3pLKytVL0theXR4?=
 =?utf-8?B?SWR0S0h5MUNCcmYyUytTcUhDa0pMUVFpbkRVb1VkODhSN08wT1o1VUpXYlpR?=
 =?utf-8?B?TTRyTnlFbXN2ajQ2S2dpQnpiR083aUlrbjR5Z3p0SWR6V3pLUzcraC9FQUox?=
 =?utf-8?B?VHJHYWduYTUzVHVia2x6QUM2dGxWOHJIMlBwMm9qQm1XUndabGc5b0RBNXdz?=
 =?utf-8?B?K011TW1JSDV6L0RkeXZQQjNnVC8vMEFyOStCWTB6ZEdHZ3R3Tk5wMDVaRlJQ?=
 =?utf-8?B?cXNKTFdWQ3RKTzZ4c2VyY1IxeUwvd1Z5eVRsZi9GQk5zSGduZVAwM1RjOG5i?=
 =?utf-8?B?Z3hEOFZQQ21WdW5wVkdKeXV4ZEhHQ0NLS2RzNGp6NFVxVm9FV2xrd2lBZWdF?=
 =?utf-8?B?RXgzcHdvWnFRZmp4S2U3UXUzZ0lwVlV6dVBJclBnUXB4YlVBMWlORW0xQytT?=
 =?utf-8?B?TDBOelJnaFduSnoreFJNcTltK0tjcnpJOVl5a0h5a3hiR2x3R2NiT2hPYlJL?=
 =?utf-8?B?TlNEWXJBcXZIckE0K25mTEV3ZFZhTTVWUjNnZ245VUtSbitHK3lQanJESk50?=
 =?utf-8?B?aTk1SWhsWWpFKzJnK2d1aUtaVElZR000VzE1aXFGVmhyNWE3TlkvZmZRTmV0?=
 =?utf-8?B?bGF2YWozZ25laGN4NU1yaTk1eXpEbDZFdXhXeTFsVURRSFRlMlE5ZldjK2Z2?=
 =?utf-8?B?MGl5YWp3L04zN1MvV0ZVRzhXcnBSWjJRMEUwd29IOGhOd2J4c3pacHVhME1B?=
 =?utf-8?B?QmNoY09tMWxBV0Zjb2ZDZXNxK1N1TXdkMFdwVFdmMFBYM1BRT2dVb2h3Q2d6?=
 =?utf-8?B?b1VPVk5zMWU2eUp4d3h6aTd6RzQ4N1dhN1pIN0ZjbXdsb3IvV29tSEtkT0pn?=
 =?utf-8?B?ajJwV3F2Qm4xZklDNnJHRzZwaHNKVGxxWkJleTFrb0E4azJRblNrRUg4Ylkz?=
 =?utf-8?B?NkVoa2UxTnNGYVRsa0RSbExVWmx1Tm5DVHVJRzBobDU0L3BGNjV4clBwSkVx?=
 =?utf-8?B?MzJUajVaNVhyejFTeFZ3V09yQlBRVU11N2RnWUhZSitnYmpZZnhTelRjRk1X?=
 =?utf-8?B?MDVOTk5LLy9PRkpLTWw2YmVDblpzMTFmVWs2ZzFOUVAxZmw5eWpLayt3WXZM?=
 =?utf-8?B?cnNDaWN3MnhXRGdRRmxTVndvOFVFSkd5UHRSMHZ4U1F2VFVuRDBwZ3dkZ3Zn?=
 =?utf-8?B?SDlsdnlvSUdUUWpXaHlMQW1NZzF3Ym4yYXcrMG9kSDBRbWZHVEs3TENZTHY4?=
 =?utf-8?B?Z0kzcnV2cndzeGNvdCtHZnNJbkRDK2NXNDFVaE9yOEdxbGkxMTVRNTlHdkI4?=
 =?utf-8?B?YUcvN2l1d3o1aXZEQWxrQWxzb1RGbHFaWHViVDd0Z1cxeHdQTHpCMWFucFFH?=
 =?utf-8?B?cDlYanZNYm9UYjYybEFnKzUzNldiWnpjQ0xKcDU4VVVmbGIwRkRQSUp2aTdI?=
 =?utf-8?B?RzFKczNzRFQ5cnBnV05DWG1INXo0aWo4U1JCdHhBc0Vic2JKSHdDekY0VnE3?=
 =?utf-8?B?Si85R2xLaUM1OG8yWkpSZzFTTlg4N3N4WGVmTDFJT2JNUlgwVnRMdkVvdUdT?=
 =?utf-8?B?dDhiMm5iMWVFK0c4K2JpQWZBdEFHR2RZV0QxQzZvQmFRNjZ1RjlBSi9DaDIv?=
 =?utf-8?Q?+GZyLqflMvcofAV68jKw16N2rjXkNgDrzAqw/JJmVeo0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2JvWjJnejRIY2pNenJkN0U3QXBwZ3lzdGNqeE9HcFZMZ2R0Si9uNE9jNmNp?=
 =?utf-8?B?c2paYTkwSHhTOEtNdHZ0b29xMGJ6VklaYzNRVCtKV1A5aVJGb3YyRTBSZDlW?=
 =?utf-8?B?Z3grVHBmODI1UnFPWlpHKzA0cEVIU3I0Ym5DcVhNNkQwcUdyWTFmK2t5S2Jr?=
 =?utf-8?B?OEVqUkRrakxJa3BiT0h6WGQzb1Z0ZXVXYnkvcHc1Ky9MSVExNzFYWXhmenkz?=
 =?utf-8?B?Um8wYUg4L0JzSWdETWFhc3lDTVVXaHRQMlJSWEYxc1NDUHhENXEveHlPR3Y3?=
 =?utf-8?B?dUplcUhWSUR0TmpCQWx3anRlaVRRbzBSemJadmt5K0xrR3dCUlZnczVlbi9N?=
 =?utf-8?B?UFNvSCtqcmlsTExaV1d1NnRoZUNLYlVkYUhGdUJYZXZKZlIyQVJBQXNRcnVR?=
 =?utf-8?B?cXcwOThKRHI4ZGM1Q0Y3Ny9DeFBWWElHQm11Zy9JQk1KR20yMWZpODI2NTZK?=
 =?utf-8?B?a3YrMVB0Uy9SSEd2U1U4WnRuU0VVNUNCS21Ub3IxYUlVZ1JxWUgvN29FdmY3?=
 =?utf-8?B?aURqMTV0NzRZdDRGaWdURENRejhTbDZkL0p5Skh4MzhSZFNVR0t0UFJnMWtO?=
 =?utf-8?B?TjRhSThNRmlsQ2NySmN2dWlleHVSZ0FHcnptL2J4VGR1OVh5QUhYbTFWTFNY?=
 =?utf-8?B?SFpUVzdRUUM5ME1PM0xjdUgxdlMyK1NoeDBwVFRrR2RrcXpjNS9EaTNlSVVO?=
 =?utf-8?B?S0ZKNlNaNHA2UURFbitQYmFKWUpQVjdkRjJvK0ZKTXZEN1paUXV2MDZ3V2Yv?=
 =?utf-8?B?NjlVVENRZk5BOVRGbzV4bXVGejJQa3RMT2hkeHhPREVIcG1aOUxCdVpOZlVu?=
 =?utf-8?B?bXA2YkFpbDhPdkN3K3FPeTdrZ2VuWGhyMTJUS2xFeWZNUmVqUzcrY1F0WFRt?=
 =?utf-8?B?anladC94U2NCSGlVWnVkMm9HZE14Qms0REZaOXhPYlFvR1VxbnVacUxQMThv?=
 =?utf-8?B?ckdUZlREM2d2bCtaRDRsc1hXZkdmSENuRE1hY3FpekdMamdReko5bnorZ0V4?=
 =?utf-8?B?T213VUw4YmxSNEFHbDRsTVMvcHo0UURobUF0N3RhNW91Q2t0aDI1dmxZZWlY?=
 =?utf-8?B?TTVUTDl0NXI3WUdHWDdHeG02cTc3bnluamZzN2hlWkFzUTRWNEFRL3l1dlpu?=
 =?utf-8?B?QVF0RXJlenU2Tml0NDdsRXV1SENrU0lMQlpOclNVMnArcndHWWMxMXhqREov?=
 =?utf-8?B?aEFmRDJrd014MHNpc0hIK1VaMXBsU2QrMzVzMG84WEQxV1pZQTkxYnJHNDc3?=
 =?utf-8?B?emFuNEFjTFFnNmFsTHNJZWVUSkNXN08wMS8vL2hvUm1MeWwwZnRPOUFueE0w?=
 =?utf-8?B?cndab2RMWFN0MStrWGp5S3ZleTFJdEpscFRSL3p5clUxZWZYNFZOSzh2c2lW?=
 =?utf-8?B?ZUQ5Q0poUFJRY1ozRzVlVlVKUE84V2huOHRhaURpUTRiSzE0blRDR3JQaUxU?=
 =?utf-8?B?YzJHWnBPeDV4b0VhQ21HV2VwTnBvVk5hZzg1SDVFMnBXK3FIV1NnRmJkVjMr?=
 =?utf-8?B?dEdOZDlVeWpsQTFZRWxybjVvQlJ4dTJVREFnTnk5bEh1bnhPYkdySGIxYmtj?=
 =?utf-8?B?QWR6K1lCTzkxeHRrWGVaUElwT2Z1a1QxcW5sT2dnQmE4NVhNc3ovVndJRVBD?=
 =?utf-8?B?cm52Qk5qcHBvdDVkT051SldUUEpMaFpMUEhiSURxUkxPTDR1bDZxNTVaTHZt?=
 =?utf-8?B?MDl2T2s5bVdiUkpETzY3cGRmMFdnUmxqWThvWEdVRld5dm9LTFdqcDBHTVM0?=
 =?utf-8?B?TWRyTWJXTE5IRXVjZ3YvTnhEejJ3MkFMZDk5NVI3NnRDV2RhNkJsZml6a0NZ?=
 =?utf-8?B?NDM1QUhHYWFEaGx0MDdSc1UvcGpXNys2bFBLMlc3ZXdpWHVqRXFEcWpERjdw?=
 =?utf-8?B?OE0xNHhIR3l3Sll4WWZESlBHZDRWMzJxcGRRYnc0RWNzRGE4ZFUwYk8wMlR0?=
 =?utf-8?B?TjIwSHlETmQ2TWpzd3ZSYlpWYTJuSTNTS2tibG9MSGpFUDF6TFZMMVE3SGtU?=
 =?utf-8?B?R3o2K1RLQnZ2ZkpQdXRPL0xTZ0pvNmxDblVCN1ZRSXI3MExiREY5aDZnTTB3?=
 =?utf-8?B?WE9TUHhkcWloTytySXAxQ2M1a3k2NlowSUZRTjVzUm5qSmg2NDZSbUNSaHVh?=
 =?utf-8?Q?f/FNfLSpM67VshsVhL+TsBoyU?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 019cf5c4-3635-469c-963f-08dc7b7894d8
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 22:35:00.5057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 95+01u8EuuOHUap+htsFjU/Ww23OcRyfxAFBugo8j8vu7REXL4Pp5F8jUq1f56V0UFs/uI2ICKyRtVUSdWEWWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5170
X-OriginatorOrg: intel.com



On 24/05/2024 12:43 am, Jürgen Groß wrote:
> On 23.05.24 14:26, Huang, Kai wrote:
>> On Thu, 2024-05-23 at 10:30 +0000, Huang, Kai wrote:
>>> On Thu, 2024-05-23 at 07:56 +0200, Jürgen Groß wrote:
>>>> On 20.05.24 13:54, Huang, Kai wrote:
>>>>> On Fri, 2024-05-17 at 09:48 -0700, Dave Hansen wrote:
>>>>>> On 5/17/24 08:58, Juergen Gross wrote:
>>>>>>> On 17.05.24 17:52, Dave Hansen wrote:
>>>>>> ..
>>>>>>>> Once we have the specific TDX module version, we can go ask the 
>>>>>>>> folks
>>>>>>>> who write it if there were any RBP clobbering bugs.
>>>>>>>
>>>>>>> Okay, how to get the TDX module version?
>>>>>>
>>>>>> You need something like this:
>>>>>>
>>>>>>> https://lore.kernel.org/all/20231012134136.1310650-1-yi.sun@intel.com/
>>>>>
>>>>> This one prints TDX version info in the TDX guest, but not host.
>>>>>
>>>>> The attached diff prints the TDX version (something like below) during
>>>>> module initialization, and should meet Juergen's needs for 
>>>>> temporary use:
>>>>>
>>>>> [  113.543538] virt/tdx: module verson: major 1, minor 5, internal 0
>>>>>
>>>>>>
>>>>>> .. and yeah, this needs to be upstream.
>>>>>>
>>>>>
>>>>>   From this thread I think it makes sense to add code to the TDX 
>>>>> host code
>>>>> to print the TDX version during module initialization.  I'll start 
>>>>> to work
>>>>> on this.
>>>>>
>>>>> One thing is from the spec TDX has "4 versions": major, minor, update,
>>>>> internal.  They are all 16-bit, and the overall version can be 
>>>>> written in:
>>>>>
>>>>>     <Major>.<Minor>.<Update>.<Internal>, e.g., 1.5.05.01
>>>>>
>>>>> (see TDX module 1.5 API spec, section 3.3.2 "TDX Module Version".)
>>>>>
>>>>> The attached diff only prints major, minor and internal, but leaves 
>>>>> the
>>>>> update out because I believe it is for module runtime update (yet to
>>>>> confirm).
>>>>>
>>>>> Given there are 4 versions, I think it makes sense to implement 
>>>>> reading
>>>>> them based on this patchset ...
>>>>>
>>>>> https://lore.kernel.org/kvm/6940c326-bfca-4c67-badf-ab5c086bf492@intel.com/T/
>>>>>
>>>>> ... which extends the global metadata reading code to support any
>>>>> arbitrary struct and all element sizes (although all 4 versions are 
>>>>> 16-
>>>>> bit)?
>>>>
>>>> With that I got:
>>>>
>>>> [   29.328484] virt/tdx: module verson: major 1, minor 5, internal 0
>>>>
>>>>
>>>
>>> Let me check TDX module guys on this and get back to you.
>>
>> Hi Jurgen,
>>
>> I was told the module starting with "1.5.06." has NO_RBP_MOD support.
>>
>> And I think I was wrong about the <update> part of the version, and we
>> need that to determine the third part of the module version.
>>
>> I was also told the 1.5.06 module hasn't been released to public yet, 
>> so I
>> guess your module doesn't support it.
>>
>> I did another patch (attached) to check NO_RBP_MOD and reject module
>> initialization if it is not supported, and print out module version:
>>
>> [  146.566641] virt/tdx: NO_RBP_MOD feature is not supported
>> [  146.572797] virt/tdx: module verson: 1.5.0.0
>> [  146.577731] virt/tdx: module initialization failed (-22)
>>
>> You can have another try to verify at your side, if that helps.
>>
> 
> [   29.362806] virt/tdx: 4071192 KB allocated for PAMT
> [   29.362828] virt/tdx: module verson: 1.5.1.0
> [   29.362830] virt/tdx: module initialized

Seems your module supports NO_RBP_MOD.

This feature is per-VM and also requires to be explicitly opt-in when 
creating the guest.  Could you check in your code whether the 
setup_tdparams() function has below code?

	td_params->exec_controls = TDX_CONTROL_FLAG_NO_RBP_MOD;

