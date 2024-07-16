Return-Path: <linux-kernel+bounces-254137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C96932F69
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 19:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E97D71C21F5F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 17:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C9F1A00EF;
	Tue, 16 Jul 2024 17:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BfKcfZ6F"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F66454BD4;
	Tue, 16 Jul 2024 17:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721152310; cv=fail; b=fdSwm+QeSKscDopwN6ohZbpoQWRRktJycqBDzmPscNU1QQxlMDf6WHiYa24EjA4rpQDquRu5sLtPaHvt+tMHv2XvK9z6EceJNlruQ90tNMv5evZ8rs4uHrSxiYrZu/QKe96wyL8LOwvWXC8ShGk3yPH+9M+txCjYQQ7X9JoEYDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721152310; c=relaxed/simple;
	bh=HdB1Vf4qKNEWaJDPNsh5zmhyrg5tPT3DZD3Id64G2OE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bDdVPmNdDS+aTvZOnI/lu50EKc6y5e9Ap5+NTnn5Z2x5SQ7aJXDQQbrvsRKfctS+29OZ+la9pLQZZSf5ALXTSj2kKcthq//3kudHowfBYsnkf8C7+yGrCMD04Pm2SoDLP581e+CWrJSYNueIvH2JUnMFW6v/o2Kss7lMS6oVmOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BfKcfZ6F; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721152308; x=1752688308;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HdB1Vf4qKNEWaJDPNsh5zmhyrg5tPT3DZD3Id64G2OE=;
  b=BfKcfZ6FIGQH6cgC2A2raAMBQ0iEdBVG1/mfhGncen2RVzsV394vAvde
   40sHmqGUWARQolct1xn9MbygG4QhTPAd4lfJBj9iKY1lS3PSxoUvjF+nY
   HVTJZKIy4Qk4aMA0NLWIKiPMo2j+t3WUMpxM5jou8zHcvSb/ROB+/9I5Y
   fH2cJkjy3wkcJ9pHvs3AKlq2AQboAnakNpIEGvro6acVzBPBDM0TdFyFi
   ETLvQaVrr10QGaXqJv2XWraID2V5fX16UKbNqEPWQBDOSQFTOf7NxcDjt
   ejv3nr935t5bswzMi5ZiRalZPpRmtcZ8Ea/06UnaSGHsoEohnlQkCsLqa
   A==;
X-CSE-ConnectionGUID: C+RbRj1zRLalgXVgChXHgw==
X-CSE-MsgGUID: vw48juCSTNuYu/z8heJ9Cw==
X-IronPort-AV: E=McAfee;i="6700,10204,11135"; a="36156153"
X-IronPort-AV: E=Sophos;i="6.09,212,1716274800"; 
   d="scan'208";a="36156153"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2024 10:51:46 -0700
X-CSE-ConnectionGUID: Z01ApYHpTKOkhhrMqzNHOg==
X-CSE-MsgGUID: WVDNcj+MTwWalIV4w3MQ1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,212,1716274800"; 
   d="scan'208";a="50024447"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Jul 2024 10:51:46 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 16 Jul 2024 10:51:45 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 16 Jul 2024 10:51:45 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 16 Jul 2024 10:51:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ypAIuKgBZUd2MrZTS3ECZXzRpmcjLE5UQqzht8RauTjI7jj+zZPUArID4PbkvZYEetUUDtKkqcQvmoGod49lkyeJWzlwRndm8K1fy9W7vDqLvIszQY8I4irfKKOxp43qTKc3r0aWWHtU3jaWt0MHj/Nbf0ggjIw6bzjN8eWL6cuPG6/+tuZdif5M2ypTrFB/LWDvAF3er+ifUtB/LXHGlfeL6mRGj1w+04SYpnnJ4ZuKRGSEkNHGDaEvyfDDIHQg7vC5BW8Bi+y3XS8dUUj7j3nnlqiuCD3YbWNGgw5h1bLYlzNcUE3SEwSbbTmzRDcDybjTKBKzoNcfma2DtCz2eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2Qty0hP9cwwqFHXXKOv9AjWJD7SzAwJkOTgFiVmDIE=;
 b=BDBObOIWg+UwzK5KnlLcFfP0vaW3eT8DRVSS6bwY2x9706Cm89TAnPpPpzSpxhUee1a1XaWYsBTtqwl1nWdqA3TDx2nzq2eyyq22cSjCFcxvSwj4ZUAZjY1JAfPNu5RmPRzDWV78jyjztlO9Rn1SlNBGTAC+LCRMZ3atxhjXA/7ZHStVXq1CvR2M0d+WtQJfDBHOysJSD4Hk8eEHQQensdvZz3e5qp2bU7lF99RFRLMEpbrwBikYMUBf6KcPVI9Ygxknf//aG++RLM/LBMGg+l4OWE/I8KzciGnTXvpyMme6RxPkFB8qAXhec7VvsPO7bHLS/397FNXUak624gCCyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 17:51:42 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 17:51:42 +0000
Message-ID: <5e9d6516-abe7-405b-8db9-52c381559c58@intel.com>
Date: Tue, 16 Jul 2024 10:51:38 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/20] x86/resctrl: Add support to enable/disable AMD
 ABMC feature
To: <babu.moger@amd.com>, <corbet@lwn.net>, <fenghua.yu@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
	<yanjiewtw@gmail.com>, <kim.phillips@amd.com>, <lukas.bulwahn@gmail.com>,
	<seanjc@google.com>, <jmattson@google.com>, <leitao@debian.org>,
	<jpoimboe@kernel.org>, <rick.p.edgecombe@intel.com>,
	<kirill.shutemov@linux.intel.com>, <jithu.joseph@intel.com>,
	<kai.huang@intel.com>, <kan.liang@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<sandipan.das@amd.com>, <ilpo.jarvinen@linux.intel.com>,
	<peternewman@google.com>, <maciej.wieczor-retman@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<eranian@google.com>, <james.morse@arm.com>
References: <cover.1720043311.git.babu.moger@amd.com>
 <ed24fa5b599d6f0abe53a72613f7afd2dc9aeb1c.1720043311.git.babu.moger@amd.com>
 <ca8c5934-c531-4d5c-a765-8722e0eae5ba@intel.com>
 <706a061d-c9bf-48d5-834c-67ae1ba4729d@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <706a061d-c9bf-48d5-834c-67ae1ba4729d@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0050.namprd04.prod.outlook.com
 (2603:10b6:303:6a::25) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SN7PR11MB7540:EE_
X-MS-Office365-Filtering-Correlation-Id: 68becf2f-b838-4f98-021c-08dca5bff374
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T0RxWGhlZExWRmV5ekxqSXJIS3ZjK01jdjg2NFR5eUtkdEFaTWwrNjAza2Vk?=
 =?utf-8?B?cVlzenN4djYxbDBnNVdiV2FZN3FaV283b3VmQ3pMakZPL3ZhckxkR2doWUsr?=
 =?utf-8?B?OC9KSndxNVgrVXZlUmMyRTVjUFZ0YW1GQU5UcE9qMnUzQkdWU1VEWXBJRWQ2?=
 =?utf-8?B?RzZSZURXTHFwZDJiem9tYUZzWXMrQ0RzbzVycXZ1NGkxVHRWSHlVY3VHK2pu?=
 =?utf-8?B?VW12ZzlvZzNJTmE4SnMvRDFzd3cxenV2WUVNcHNkVjdqMXExMk9HUUowK0pJ?=
 =?utf-8?B?Ym53empvTnhKd2JuZmJqcWQyQUNudUxQMitsTGZOU2wwWFZlTUFwOFJMdy93?=
 =?utf-8?B?VXZES1ZYU1MrUHY3blRpZXpuOFk1WjNmWkhDS0ovOWt1d0RDVG9samJtcHJ0?=
 =?utf-8?B?RytXTFVEeDM1OWI0ZkpscHhKL1BrRXh5dFJIM2FJdERlYm1sbCt6ckZsSzBn?=
 =?utf-8?B?aEhyMEkrSzJ4QlJSdTNsdHFMZmFPU2NOMUxWUHFoNVV3b2p5Y0srZ0FHS1ZI?=
 =?utf-8?B?emZwWTFTNXFrdVpGOEwzalJCL3FXS0ViT2hndTI4MG5tVWxLY3VpYjhNRmlq?=
 =?utf-8?B?cWdqY0J6L3UzY05GUjVwa2YrUlo2bE5Cc1lFaTdpU2RCd3RLMm9IWmlaU25O?=
 =?utf-8?B?MzdOeHhueTkwa3Z3TW1WRHQvZldhVWNQTFhva2NtODVuY003enBIZ25Kb0pS?=
 =?utf-8?B?aTFHZTNNbFNFUE5nQ1crb0VzNnJsSnhKaURjZjVEUnRlamZ4am12MmNZWHlJ?=
 =?utf-8?B?b0ovQUN5SUtrc0lHZ0FmRCtwbEhubWpTUHc3OTBpWmhBbWxGL3VTZnIvNk5B?=
 =?utf-8?B?c2ZPNVBMWE55K2xucEUrY2QyOHM2Vk1UdGpRTFNONjVtUVkvOG53R0taVm1p?=
 =?utf-8?B?Q3hMeVBDNmdrbGx6cWo3Y1hmOEQ1TE5jNTQxN0RIUEo4eFlCU01XdUFCVXEw?=
 =?utf-8?B?a09NNmhBaEt6aW9ISS9XVjRLU1RzTnYvakJmTmhiUGhENXlCamlORGlDN0lu?=
 =?utf-8?B?bEV0ZmJnZ3pOVjIrekNUVUc0N0VCM053MU1hNUtvL29FaDVrZW92OFMzVFdN?=
 =?utf-8?B?cjZVa1cxWGZuMm9adkVFWmZRa282SWkwcGFsdHoxWWk5aVVGWHFUZ2xZcUxv?=
 =?utf-8?B?YVpmdVgwcVJGNzVLVkxseG83UW5qWEI2NW1HWWV0aTlCdWk5RzIrbTZqbEJ1?=
 =?utf-8?B?Z2FCK2lGRUJkTVY1RE1PN3kvTmF2L1VYUFlrdGpUaVljNFhYSkk3R2dmS0Zz?=
 =?utf-8?B?MjJ5ZmpuWUNqRXo4dDl0cENmeEZxbCtiSjFuZXA1aFlXTmtZODNTOTY0d3Vv?=
 =?utf-8?B?QWF1YmpGM3NCVFM2MzhLWm9OZEQ5cUJNQ1pzN1J4dzVneFowNnpDVTdwbVB0?=
 =?utf-8?B?elh1dnd6amJPcXU5YnpTWDdxZDdsZDAwM0xYQnRMUStpMmRrVHUxVGh2VEov?=
 =?utf-8?B?V1FUQ3cvTHNMZ0hpaUUra24rbHZIUG9LaDQyckduZTdlcmxwWHE0SU16dXI4?=
 =?utf-8?B?dERxMFNGdE40dmtDKzJkVUhueUxRRTRRT1JLZW4rcXh4bXFHTVd1ZThUem5S?=
 =?utf-8?B?UC8wY0pZcFkzMjM1UE16STh2SDlEV2lNWnZhU04xWGtWaExBZTJwaVF6WkQ2?=
 =?utf-8?B?SWFCaGZvcmRFOEthaWFYU0llWXBlS25vSWZaS2pwTkZ2dHVjREFqM1dkR3Nw?=
 =?utf-8?B?eXorbjVVZml2bVZFMnpYazdINWJvMUFra2dCZDd1UjZpM1g0OGVSNmUrcTVK?=
 =?utf-8?Q?++b6/kR5rqbd4sBXJM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTBPUHZpdW9XeERxcTVuaUdFMU83OCs0SnVLU0NjVGVSZ00rL01SL2ZlME8w?=
 =?utf-8?B?LzBnc3dtQzZtcG9ZLzVkTkdLcmdoTjNaSGVNQ3RKT2lpbjZ2NEVoWHB1a2ll?=
 =?utf-8?B?eWFvMEQ0WjVPZC9nU3paOW4xVW5laWRhOVYvUkJNazBjdEdWeFRwbXU3cE53?=
 =?utf-8?B?UkRHbEhzaGtqV0toRUFvQ2RPdCtiWW1CTUV6SkRGcCsxdWNoUHBhc1B3YUFZ?=
 =?utf-8?B?VnhjMENGV2xPeHdta0FRb1MrVXBJZ2hQRzlwRnBiSTBOVTk1VnVwV0o4d0dY?=
 =?utf-8?B?bkhMc3puWm5kZGI1Z0pqZFJOYkRhYVpZL3Nob1VCYW9yVnJDQ1k5QldDSWJj?=
 =?utf-8?B?NnRRRFdhN0xoVDE5WXd4RjdTN1Qxa3RLY0YxWmlhK1dCcTVrakxNQmM0WGpr?=
 =?utf-8?B?UzFTWlRmZ0sveWdTNVVqSUdTNEhMYXI3dHdnSWNVYnRzSUlxOGkrR20wV2VJ?=
 =?utf-8?B?ODIvVmRkTEJxd2Nub0J5WG5rVW42eElmcVZhNTJkTTc5Qk9SNi9hd3dLRVRN?=
 =?utf-8?B?cXpPaHJ2Sy9XRGVCYWNWWXpIQ2djQ3prSUR3bFdGc2xab1UxYjQrUWlhVURN?=
 =?utf-8?B?YmxSRVoxMVhRNHVXTTVlZ0owY1VVTkpQQW51WWhsT1hNdmRsK09uVEprMmpT?=
 =?utf-8?B?VlZSZklYeXJPT2l2ZFVGRUlLN3JNMXRxOHZOT1NKbHVDSmFYRHR0dFJCeGtF?=
 =?utf-8?B?TUJGOEtYRHB5TlE0dDdqOS9xVkRSZ3Y0bzZ6eEphSjNoSmZOTXFXYndFYUsy?=
 =?utf-8?B?eVBEK0RTK0ZOb1NNRDlFdmlES2RlZ2YwRFVwSFF5NjJYUG4ybFhwaXpTRTVE?=
 =?utf-8?B?RDZaSktsVkR1NHpLcE8zcjNRLzU5WVNvMWNFVlZVc01UWDV1d3Q5Sk9mdHRp?=
 =?utf-8?B?NzZzTzh1UWtFb29HN1YyU3VQWW5MbTVOQWtmOEhSSW5uSW5hVnkzNkwvVW54?=
 =?utf-8?B?dmpQcjNhYXZXaWd2Z3JIdlVUWmozZkt0WkdwRnNEUGZDaGxUVmNja0pSa25z?=
 =?utf-8?B?ZnlSbjlZNC96OG1jL3NEbXFIbkpqM0lzMTNBNkxKOTNBYTZ1dW0vMStKeUFK?=
 =?utf-8?B?Q0lBbnpHS3FITXJOQ3hFUm96Z0lyaExBKy9xY3BqS1MveThnSUR1YWtRbEls?=
 =?utf-8?B?UXpjdEJzRG8vN2pOanZsSEhFVlg5WEhPQWptUkZXdWVLSlNHT2RLUW9ZYzc4?=
 =?utf-8?B?NHZURFN6UkUzWTJYMWRyY0czaWZ3OTNleTFJbnFxYzdHaGt0UWM3LzNrek9o?=
 =?utf-8?B?Rks0SDVYZGkxRUM4ajlCdk1hVHl5Vy9LZ1U5VGZNbnhJZDVDNVNjbzNiejF5?=
 =?utf-8?B?N3F5RWo2ZmRyS2FrNC9wZVpjQ3Q5dGZPRThtTGI0SFk4RHhrZlZraFdYNnRT?=
 =?utf-8?B?NEphRFp3M1JKUkNEbkg3SEcyN1d3RGVLVDFscWlkb253dzhOQ1ZPVi9tcUZs?=
 =?utf-8?B?SVpYNWdVbDNjcjh3THJjZW9pNldNeStYYUNWV1JjMWNGdHhiem9OcFNwSTh3?=
 =?utf-8?B?bisydTlTUVdNVmZvNm14dDhPM0ZoNVlHdmUrSmNGN3UxYSs3ZTNodGtKSVlo?=
 =?utf-8?B?WUF4azc0NWpMQkJRQW9ZQko0UDZlZExZWlUyK2NNTkgweWlUSVF3VTNqc21l?=
 =?utf-8?B?R1ZQODFBb1RJUXJoK1JEc0ZHUDFjcEdtUDlWdy9HYmpJbERpc0dJa3VJN2da?=
 =?utf-8?B?Y3oxYlRPbTZYZVdPSUJlU3VsMFhhakhPSFdQUjJNMHloMjQ4RFREbXVXSU5y?=
 =?utf-8?B?a1RtY2xWVTJDNlhGZEwwSVF0WExyY3d0blpRRVZVTi9HYjFoM0Z5ZkdYVzd5?=
 =?utf-8?B?MHYwbnU5bVoxZ1ZUZ3Z4ZDRGY1k4NjFNY1kwTDlGNWkxVXZ3WW82WFd2c1d3?=
 =?utf-8?B?N3c3SVE1bTgwdFkra2tvQnd4cEZ0OCtJa2VyMXlGb1QvaXlTSERHWmdIVjhs?=
 =?utf-8?B?em5BNWdtMy9NQmxORWRxa1k3eEpxeUJrWjgvOTQ5T1k2Tk8xU3M5WGpqd1hW?=
 =?utf-8?B?d011N2J0cTZtdmZUSXhqaHpvZFgvcTg3d2htZ3ZEM2JQUXB3NXQ4MkNJeFdl?=
 =?utf-8?B?TTV0RTQ0bXUrWk1mNlBRaGRvbXlYZjNLdGlRL1VXZE1JUWcxTXo0VXhydWlG?=
 =?utf-8?B?cjZEMnNXOER1Zlpkei9zelZnZlpZSXNvVWFvUytOVCtlb3BwYW9vQXA4a2FD?=
 =?utf-8?B?OGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 68becf2f-b838-4f98-021c-08dca5bff374
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 17:51:42.2845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MatbABFaIW6RhJQOc8L3UFQG+HAc6ZfDUboH5vlJ9s7vtPDT76MruDOjjUjGGdrX2dNEYqBIHeHxvYP1sjpYEigQ+8WJePn124058TL42bE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7540
X-OriginatorOrg: intel.com

Hi Babu,

On 7/16/24 8:13 AM, Moger, Babu wrote:
> On 7/12/24 17:05, Reinette Chatre wrote:
>> On 7/3/24 2:48 PM, Babu Moger wrote:
>>> Add the functionality to enable/disable AMD ABMC feature.
>>>
>>> AMD ABMC feature is enabled by setting enabled bit(0) in MSR
>>> L3_QOS_EXT_CFG.  When the state of ABMC is changed, the MSR needs
>>> to be updated on all the logical processors in the QOS Domain.
>>>
>>> Hardware counters will reset when ABMC state is changed. Reset the
>>> architectural state so that reading of hardware counter is not considered
>>> as an overflow in next update.
>>>
>>> The ABMC feature details are documented in APM listed below [1].
>>> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>>> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
>>> Monitoring (ABMC).
>>>
>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
>>> ---
>>> v5: Renamed resctrl_abmc_enable to resctrl_arch_abmc_enable.
>>>       Renamed resctrl_abmc_disable to resctrl_arch_abmc_disable.
>>>       Introduced resctrl_arch_get_abmc_enabled to get abmc state from
>>>       non-arch code.
>>>       Renamed resctrl_abmc_set_all to _resctrl_abmc_enable().
>>>       Modified commit log to make it clear about AMD ABMC feature.
>>>
>>> v3: No changes.
>>>
>>> v2: Few text changes in commit message.
>>> ---
>>>    arch/x86/include/asm/msr-index.h       |  1 +
>>>    arch/x86/kernel/cpu/resctrl/internal.h | 13 +++++
>>>    arch/x86/kernel/cpu/resctrl/rdtgroup.c | 66 ++++++++++++++++++++++++++
>>>    3 files changed, 80 insertions(+)
>>>
>>> diff --git a/arch/x86/include/asm/msr-index.h
>>> b/arch/x86/include/asm/msr-index.h
>>> index 01342963011e..263b2d9d00ed 100644
>>> --- a/arch/x86/include/asm/msr-index.h
>>> +++ b/arch/x86/include/asm/msr-index.h
>>> @@ -1174,6 +1174,7 @@
>>>    #define MSR_IA32_MBA_BW_BASE        0xc0000200
>>>    #define MSR_IA32_SMBA_BW_BASE        0xc0000280
>>>    #define MSR_IA32_EVT_CFG_BASE        0xc0000400
>>> +#define MSR_IA32_L3_QOS_EXT_CFG        0xc00003ff
>>>      /* MSR_IA32_VMX_MISC bits */
>>>    #define MSR_IA32_VMX_MISC_INTEL_PT                 (1ULL << 14)
>>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h
>>> b/arch/x86/kernel/cpu/resctrl/internal.h
>>> index 2bd207624eec..0ce9797f80fe 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>>> @@ -97,6 +97,9 @@ cpumask_any_housekeeping(const struct cpumask *mask,
>>> int exclude_cpu)
>>>        return cpu;
>>>    }
>>>    +/* Setting bit 0 in L3_QOS_EXT_CFG enables the ABMC feature */
>>
>> Please be consistent throughout series to have sentences end with period.
> 
> Sure.
> 
>>
>>> +#define ABMC_ENABLE            BIT(0)
>>> +
>>>    struct rdt_fs_context {
>>>        struct kernfs_fs_context    kfc;
>>>        bool                enable_cdpl2;
>>> @@ -477,6 +480,7 @@ struct rdt_parse_data {
>>>     * @mbm_cfg_mask:    Bandwidth sources that can be tracked when Bandwidth
>>>     *            Monitoring Event Configuration (BMEC) is supported.
>>>     * @cdp_enabled:    CDP state of this resource
>>> + * @abmc_enabled:    ABMC feature is enabled
>>>     *
>>>     * Members of this structure are either private to the architecture
>>>     * e.g. mbm_width, or accessed via helpers that provide abstraction. e.g.
>>> @@ -491,6 +495,7 @@ struct rdt_hw_resource {
>>>        unsigned int        mbm_width;
>>>        unsigned int        mbm_cfg_mask;
>>>        bool            cdp_enabled;
>>> +    bool            abmc_enabled;
>>>    };
>>
>> mbm_cntr_enabled? This is architecture specific code so there is more
>> flexibility
>> here, but it may make implementation easier to understand if consistent
>> naming is used
>> between fs and arch code.
> 
> How about "mbm_cntr_assign_enabled" or "cntr_assign_enabled" ?

My preference is to keep the term "mbm_cntr" to be consistent with the
other variables/struct members to help when reading the code.
"mbm_cntr_assign_enabled" does seem to be getting long though.
Are you planning to use it by assigning it to a local variable with shorter
name?

As a sidenote, I will be offline for large portions of the next few weeks
and thus unresponsive during this time. I'll be back to a regular
schedule on August 12th.

Reinette

