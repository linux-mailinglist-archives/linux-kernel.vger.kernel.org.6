Return-Path: <linux-kernel+bounces-374842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 418BA9A70ED
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 19:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6286D1C22A38
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 17:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE591EE006;
	Mon, 21 Oct 2024 17:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CG9g/+Rf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AAD1C460D;
	Mon, 21 Oct 2024 17:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729531222; cv=fail; b=rZZZz4xH5v0cIcL3fDSYXQO8AvsIiof8IPkjiAtZvUoj+YqedCBxnBAeE485ZMLDgWa5asnt4cNYYDQNIjpqXxG/Oth69zdPC1HEWPnM0QfPgy9OGYgFUBWwusup/jxNRYxprD/a8PCXNQ8j4R7W/uPzVgzmsF4JpZS/b8YMLA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729531222; c=relaxed/simple;
	bh=jq+ubX8EcH61aPiSC93abVsqnZprgLWymqs+QrjiI1U=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jcBo40IoWhmzEDwhn9PSbo6xvwSGO4kI1UTIfcAP6yu1mIEMlNS71DyldlRw++XeU+MZjlFssat1Rg38uPZMWibfmess2WVNgBSUqToqj4i84jnht3/sugDRnUdAVP27e74X7KaKuvgpBK/5FQ64FregvrTj7fouLc39nRq9C4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CG9g/+Rf; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729531220; x=1761067220;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jq+ubX8EcH61aPiSC93abVsqnZprgLWymqs+QrjiI1U=;
  b=CG9g/+RfdGFTb3HxCs65h/V3LJnM7xrqXEH+bHd6nNvCVFSuqBeW1ajb
   OqDwOTCPVAlNLp7npZ0U2z5hnful8tHZkyhHosdMdcnSouLj1R+DI8oIc
   HCVnXNf7Dx3xjOQVNAycgCecHaBvTufEq2w20UMLBIydRHexDeIy1T8J2
   Tu0onczHIsvBN66TwNTzDihY7XJM+nhsHZp0739qiWWNH7lxn/BHJJ4Wq
   0vm7aR6x3/YzBPhfyWiP0nXoJKQLRxpEBSBpOORve2a50vdGlAYtzlJlO
   5W2Ycuk02z0rcBSqUzlMXnKZ07cB2EheHHRvqB5TUjmh2S4Dyhfh0BIQc
   A==;
X-CSE-ConnectionGUID: Jf7JcozYRwmcf/MJs25WPQ==
X-CSE-MsgGUID: 4iviK7diQgavIqfvracVyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="39615618"
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="39615618"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 10:20:19 -0700
X-CSE-ConnectionGUID: x28FT2QtRUimih0I2M2SaA==
X-CSE-MsgGUID: 3CM3YhboSdKWZ4vjQ9l/XA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="79534335"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Oct 2024 10:20:19 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 21 Oct 2024 10:20:18 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 21 Oct 2024 10:20:18 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 21 Oct 2024 10:20:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VvkIw2+C6fAOLFQs/a5RiyzAu+4PIBVDV3PqZBrVOQvwRB4Zhqr4JRMt5SCE9YZ1OCakuGbnKo459QUbMdELEjnY+GM3jMw3I3uRJl1Ba1CghN4xlDJQsN/+EWg4CH1ngU40pKMrmm1O7yUnvodLDwz5K6rXCvDwwJhtn6RDtUfZDj7sMyf43/4lCtV5SdMDvalF4UOZnZD+6vwef5CRhzOBYouAJroXtuW8ZpYvr1q8AkQel9TamEX7sxpCQLOQMTkf6A5eoE1JysscH6t3O7WHbZ+XmzOOkBjkMXcCX+0rg4xCk6TaPlBaDg3i5cMIeirsULBqgHaN6UuMMCY+tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8P/Mlf4GyqsBG5+TMvBvKWSN9aK3YGTTwQSwIlPtCXM=;
 b=t2TGyholG+mgws8sYlRXs8meEqXKFIJZdvviAVulqGETUmRpjWjEAKomkRssVk0+fEdVI1su5bliwqMyKF9e+DL2+wJOHe1Ev81AYZujsgSBH3YsxDZrTFRZRYqN34jbXklUfjwDioVKECrH4/KdKmNiZLViLzjS4itgOREUEalHmKNqOIkNUh4GVTr07fE1M6znE/tO9Eqp2aghnGLFp4kVj40jiBRAiEBEIGtG9zueDUQQyqmbOT1KPqGmCJ+jpvgPRxVlr5tlydMqayzIc10Ca7j9ctXQitWZntxEmEdEeCQ70a9QSu8phelS5x5zlTXda5wiUQ8PfR8HNXjowQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA0PR11MB4765.namprd11.prod.outlook.com (2603:10b6:806:9b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 17:20:12 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8069.024; Mon, 21 Oct 2024
 17:20:12 +0000
Message-ID: <9f3ab90b-0f35-4dcc-9996-4d6e941cbf2e@intel.com>
Date: Mon, 21 Oct 2024 10:20:09 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 25/25] x86/resctrl: Introduce interface to modify
 assignment states of the groups
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
References: <cover.1728495588.git.babu.moger@amd.com>
 <c3c12e970a660c32088a447f9961826ec3a9fb24.1728495588.git.babu.moger@amd.com>
 <faf0b49e-b379-48d2-a14d-ad931bb46883@intel.com>
 <d5d7706c-0c12-46bf-9a4d-9bd80db2c83f@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <d5d7706c-0c12-46bf-9a4d-9bd80db2c83f@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0334.namprd03.prod.outlook.com
 (2603:10b6:303:dc::9) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA0PR11MB4765:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a037e46-1a1c-4679-aed5-08dcf1f49f39
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z01Fd2M5OEUzZVdhYkxpQmV1dHlnQWxUeHZrdmU2SzBiU0g5djFMNEJ5aHls?=
 =?utf-8?B?YXp1TitRRUJKd2ZQSG4xV2NrRDJwVXMxMVltR0Y0NEpTcFYwQjM2dFhncGpT?=
 =?utf-8?B?WDhKa2s2R2I3dHJDZzN3QmFscVF6dGZaTjRXQ2llV1ZENWlZOGttMjBxTzBI?=
 =?utf-8?B?Zy9jcFFSV0JlZDhFUjBiTG1jdmdJS2w0QkRIbjdIeVlnYmQwTXFsZHJDRGg1?=
 =?utf-8?B?STZPSGtQdFd3bGxsd2ZhTlYreHBGTTFsZS9PK3FSSGJMMmQ0c29qN0dZZk1y?=
 =?utf-8?B?bVY3eS9mVGlTNXp6UGhtZGFTamoxelFUazRvU0tLOXRBMTFhaVFQeEJrb3dE?=
 =?utf-8?B?QXlZWHJkdkcxUE01UmtIL3AvVmQxVmxoQjFBVlZVYzh2VHIvcWx6NWNTaWRX?=
 =?utf-8?B?ZzRaS21VRlM1eWNQRVo4L1RsT1Q3TUZHOUJYK3QrcmwxUXowcjNCWVFIMnky?=
 =?utf-8?B?a3VjWk1SMkc4QTd0ZGYyMTJBMXB4c1UzbCtoT1NxUitNLy92RU1RaUwrTCtJ?=
 =?utf-8?B?bzBGMFAvU3lZSGxPemIxVlREbnlxU3V1bWpXMGZDSnl0V3IvY2tRb1NJS3lE?=
 =?utf-8?B?dEp6T3dENXBKdEhLTVV4elR6dmJKVmRvdEs5VGswRnc0eVBHUFdDdUJzWU95?=
 =?utf-8?B?YXZXbG9RekExNVJ0SDc5ME9xNFMvS2FKYndiUUd3OElydEFKRlhIZTVkQWFw?=
 =?utf-8?B?U256VkxYeGdHcTJnLzhVSzdTVEpNT3dzcUlBVm4zQzNjdWtxbWRFSlRKenJ1?=
 =?utf-8?B?dldqek42cUlHenBvRVVIR2xxdzVIZHdYRWJJLzdrZmRPRGIreEVwekpRWU9B?=
 =?utf-8?B?SGVlUWxvWkVXUUhFZ210TDgwR2plRnhIb3ZnVHhCMGpNMmxaR0wyUGRJRkZC?=
 =?utf-8?B?cHVNRGxIMzZKOFJXOGJNMDY4ek1FMFdjOUVSRzNZeEw2VlJoVXpEQlppUVpF?=
 =?utf-8?B?Zmtsb05nM0NEeW9iTFdHRGFPVGNzbEZYN09rclBHR2JjaUdkclFLbVJXY21n?=
 =?utf-8?B?M2lYMER5Ni9wRVBiNjFBeWxWQ1k5bzdpSVlGU1k2aStTclpnbzJFcnZpSytr?=
 =?utf-8?B?cGhvSWZzbVBqT0JKNzFuYjJQSGZVVGNPNnA4ekIwMWZBSzBYaEE4Ynpud3k2?=
 =?utf-8?B?cjZRVWZURjBhRDkzS3ord1d1RVZiNVZScVI2YkNyZ3dtelB1c29EaXlRZjVW?=
 =?utf-8?B?Ky84QmdBVGxQL0Qxc2pGUkRQNGdPaXJ1OXhkYWhzemZGOXlNbi9xNE1KdEYx?=
 =?utf-8?B?NWZBVzFlSUdKZ3NmR2dZdWpaQXZEZUtDQk91dHFZbVc0UGJ0eTNBeWRua2R5?=
 =?utf-8?B?V25jNmhJT24vdC83Ymx2bHRxQ2s1YzlLdmNYSzR5Q3VjTHVRclpMeEM3ZW5t?=
 =?utf-8?B?NGtUS3YrVnREMXp1eStIbXo5M1lGVDJCQ3JQSXAweGQrQmRsUXZ2blFuNHFw?=
 =?utf-8?B?T1hyUFRqdUlhcTJKN0YzdFhMR3ZOalorL1c3WlRmVFNFWUwybTRwaXZoa1N1?=
 =?utf-8?B?dFNnWnpJUUVGNzFwYm5QV05pMEI3cnRKblgxYzJPOWxSV254dkw2Y2dHbmtI?=
 =?utf-8?B?VS9rM29uZ0JLYnBIellCcWMzdmYzTW5vc3k4Nktra0U2S1ZZQ2dWbTJNV1E0?=
 =?utf-8?B?elN3dzVxMHRMck1Kd2JUa3puUkxDU201azFQcGlpZ3NKOElsQkJJdUNOYlBp?=
 =?utf-8?B?SHUzZHFNazVlZzkwcFBJZ05SM2VlbkNJTEpVVEg1VHBQeUNiRGxtbkJoU3B3?=
 =?utf-8?Q?CZX7+VbJDiKwVHykbnDRESncFOVYdQUi/gdtZ2N?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1ZjSWZlakpNRmkvMkZHN0FRZWttZnd4WmpNajZLci9wdWNkR2srM1NGUlVs?=
 =?utf-8?B?ZjhpcVFSK0dVSkdVQkNlTXVSTXpJVFR0YVRSZXdaZzRiS3pKS0hGb3hDZWRY?=
 =?utf-8?B?WVExOWhCSlBjekFxRWlJVVAya3NyS3FtUGFJU1lZamYyODJUWjNnL1VrNHRz?=
 =?utf-8?B?TklzY25zQWFqTER1RkQ0cUtSRktlVWs5ZjBlZXlzOWVxNVVsOU0rSmRmc2tu?=
 =?utf-8?B?RnFMdVp5ZG00d0ZpaVJ5ZVI2VXdDOGk3Yzc1THJFYXVMT3NjNTVoYmxlbFdJ?=
 =?utf-8?B?RTViSGNhK2kwQ0xEYjhyaXRNdzgrQjhQei9VUmhXQzNLdTFVL1dVV0dEK01N?=
 =?utf-8?B?RkpWeDdOcVQ3c1dsdzZRK1h5UTEwYllMVUZ4VlBUUmZpcjVFb2RaSU5GNWtT?=
 =?utf-8?B?Mm9jSkdSTC84bStseHV6WnNjUFdwZ21GM0JLV0U0TzFsMnpDOFRmaVNFTUl2?=
 =?utf-8?B?dkFrVkgvNUozTnRvSXpFbWdFMjZqT3BUZkRRT3c5SHJVZDQyWUwzRzNNZVIr?=
 =?utf-8?B?M2tCa3ZZcnR5eFMrNXM3OTBVUSthazQ4czdwUGhkREhuMzVpZGZremVqUlo3?=
 =?utf-8?B?anU2Vkg3Q0J1STg1aDg3Nld5Wkl5NmpXUWRQTFNQamVoaG43cWI3anZrSWl4?=
 =?utf-8?B?blJTMDZRNmFhUGxTYytwVTFtbzlQdFNQN3M1Z1RpTWwrQ1VESXZOM0szMStY?=
 =?utf-8?B?VG00QkJzRUN3c3JEUmJDbnkrVVpyMnRESkNXYUpNUE5nN1VBam9vb00rTTFC?=
 =?utf-8?B?ekVVYThwYjVKVjlnbGRYT0VOV0VkUFQwVzhlVUMyeloyVU5VaTJaK2g5SDdU?=
 =?utf-8?B?NGJRaG9CWnBsc3VxdkVSSzkvQzhYWUV0cXQyZUZySVp5cUxwaVRyQ2NiU1ZM?=
 =?utf-8?B?Tmxyc1d4TnVuVHF4TUlJWWZFSytnNUsvVkI0RGlMT2oyL0NBeWVZTlNXSitZ?=
 =?utf-8?B?VW1yQ0dYc2ZZMi9tUWhHZVZDT3ZLUFZEYU9jL3Exa3Yzb3RVQ0tlS2Vwcll0?=
 =?utf-8?B?bmdmNXFKN0VBUFVvRWp6ajBveGNKVVNsYnJ2WE1KbTBJL01jTE05ZUY0NTdR?=
 =?utf-8?B?Zmw4WTF2bVFBeURJaVRuams3VzZsbVl6L1N3cE1NK0h6NXExSUFMRE4zcUtZ?=
 =?utf-8?B?NUJ1bGhnMytnN2V3M3dBeHhyMExtVlFoUUI5SFROZ2ZDdXlVcWhDNDFuWUQr?=
 =?utf-8?B?Q0hEaGhRYmNiNVlSS3pJaVJldUViZnJQOTdGUE1veWJPQTZFY0ZlZUZoNjhK?=
 =?utf-8?B?Q3o1STR3L1htdFdhSmNzMjhLT2dZaDc3WkVQdlErWWczNkFqenVqTzJDRmUr?=
 =?utf-8?B?WXJxQ1BIL1VzRjJPeU9ETUhuclRqaW9CWlRWa1RnRFNDR2xlWGV0ZTF5OTZ1?=
 =?utf-8?B?RlM3Si9UQzFYVGg5Z3FOTlM3K1FwOTVpa1ZIUFFneGNwRC9GMFdUbmhuZkFw?=
 =?utf-8?B?MWlmaDJkVEhZTE5rTjlpcmVTU2dwQmd4bCs4bENRcEhxTVhlOHRVTG55WkZX?=
 =?utf-8?B?bVNJTlVXYUc0dVZjU0U5YlVRZ0NzUXd2RUZBb01Sa3FyZklSeXlWWUY2VTJ6?=
 =?utf-8?B?Sjc3R1B3S2RMYUFNekZJanRnSXpBZWF3am8wUFlYaU1rcXRKbkUxY1BLektY?=
 =?utf-8?B?T0NNaDBnQmsyR2I4RUF0a2xTd3diQkVzTkN1bWZqeXVESGh2VkNPNXlIQ3cy?=
 =?utf-8?B?dkFKVW9KcHBla1F4dzVNRHA4UjBKT0pnaEp2Z0p0TWFtY2syR2d0S3pUcFRM?=
 =?utf-8?B?RDY3N2ZGWlNMblU3a3FkNlhudE92QzRQMGF1UG1mY0lJcW9XNGVpcW16WkFS?=
 =?utf-8?B?OFVWQVFIZy9tQ3RqZFpNMzZqVWt1ejJBU1FjNTRseHQ1bVdIS1lVTjZXSyta?=
 =?utf-8?B?VU4vRFZ3aFVST1c1KzNXaGo3TXNUS09CeFRETUxLMnFLc0prWHlmdERyMmEr?=
 =?utf-8?B?KzdZQUIrMk55d1VtYjFlM2xOQ3VORFNENXlqbTF2UXJ1enRDaUhEdXpQVEFC?=
 =?utf-8?B?RGw0Y3d5QzJVN21Bd2RLQ2poaVRjSzNZMzVwL1IwMi9nRjl4NC8wbzN4Yk9L?=
 =?utf-8?B?SkU0MG13RWlEVUZZRy9QRjIzenB0RU9nUmVnUHZsNzJhVlFTcFpRS0loS0lB?=
 =?utf-8?B?MjZpcWpDT3FEbzRxTE0zZlRLbFRhUTF2MEo0VVczcnFSUGxmTXh1bHlhY2NS?=
 =?utf-8?B?UFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a037e46-1a1c-4679-aed5-08dcf1f49f39
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 17:20:12.7123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e8MSfWfSRT9J3YtHluM4z2gTUL3sgJuEE1lxQe9ZmOdjtUo2O1NtMf6lBtqqaDDbq02Yv1O+dzU0hVikcFdiFkUVQAOurLEIy+ACrFhvj9k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4765
X-OriginatorOrg: intel.com

Hi Babu,

On 10/21/24 10:04 AM, Moger, Babu wrote:
> On 10/15/24 22:43, Reinette Chatre wrote:
>> On 10/9/24 10:39 AM, Babu Moger wrote:


>>> +static int rdtgroup_process_flags(struct rdt_resource *r,
>>> +				  enum rdt_group_type rtype,
>>> +				  char *p_grp, char *c_grp, char *tok)
>>> +{
>>> +	int op, mon_state, assign_state, unassign_state;
>>> +	char *dom_str, *id_str, *op_str;
>>> +	struct rdt_mon_domain *d;
>>> +	struct rdtgroup *rdtgrp;
>>> +	unsigned long dom_id;
>>> +	int ret, found = 0;
>>> +
>>> +	rdtgrp = rdtgroup_find_grp_by_name(rtype, p_grp, c_grp);
>>> +
>>> +	if (!rdtgrp) {
>>> +		rdt_last_cmd_puts("Not a valid resctrl group\n");
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +next:
>>> +	if (!tok || tok[0] == '\0')
>>> +		return 0;
>>> +
>>> +	/* Start processing the strings for each domain */
>>> +	dom_str = strim(strsep(&tok, ";"));
>>> +
>>> +	op_str = strpbrk(dom_str, "=+-");
>>> +
>>> +	if (op_str) {
>>> +		op = *op_str;
>>> +	} else {
>>> +		rdt_last_cmd_puts("Missing operation =, +, - character\n");
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	id_str = strsep(&dom_str, "=+-");
>>> +
>>> +	/* Check for domain id '*' which means all domains */
>>> +	if (id_str && *id_str == '*') {
>>> +		d = NULL;
>>> +		goto check_state;
>>> +	} else if (!id_str || kstrtoul(id_str, 10, &dom_id)) {
>>> +		rdt_last_cmd_puts("Missing domain id\n");
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	/* Verify if the dom_id is valid */
>>> +	list_for_each_entry(d, &r->mon_domains, hdr.list) {
>>> +		if (d->hdr.id == dom_id) {
>>> +			found = 1;
>>> +			break;
>>> +		}
>>> +	}
>>> +
>>> +	if (!found) {
>>> +		rdt_last_cmd_printf("Invalid domain id %ld\n", dom_id);
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +check_state:
>>> +	mon_state = rdtgroup_str_to_mon_state(dom_str);
>>> +
>>> +	if (mon_state == ASSIGN_INVALID) {
>>> +		rdt_last_cmd_puts("Invalid assign flag\n");
>>> +		goto out_fail;
>>> +	}
>>> +
>>> +	assign_state = 0;
>>> +	unassign_state = 0;
>>> +
>>> +	switch (op) {
>>> +	case '+':
>>> +		if (mon_state == ASSIGN_NONE) {
>>> +			rdt_last_cmd_puts("Invalid assign opcode\n");
>>> +			goto out_fail;
>>> +		}
>>> +		assign_state = mon_state;
>>> +		break;
>>> +	case '-':
>>> +		if (mon_state == ASSIGN_NONE) {
>>> +			rdt_last_cmd_puts("Invalid assign opcode\n");
>>> +			goto out_fail;
>>> +		}
>>> +		unassign_state = mon_state;
>>> +		break;
>>> +	case '=':
>>> +		assign_state = mon_state;
>>> +		unassign_state = (ASSIGN_TOTAL | ASSIGN_LOCAL) & ~assign_state;
>>> +		break;
>>> +	default:
>>> +		break;
>>> +	}
>>> +
>>> +	if (unassign_state & ASSIGN_TOTAL) {
>>> +		ret = rdtgroup_unassign_cntr_event(r, rdtgrp, d, QOS_L3_MBM_TOTAL_EVENT_ID);
>>> +		if (ret)
>>> +			goto out_fail;
>>> +	}
>>> +
>>> +	if (unassign_state & ASSIGN_LOCAL) {
>>> +		ret = rdtgroup_unassign_cntr_event(r, rdtgrp, d, QOS_L3_MBM_LOCAL_EVENT_ID);
>>> +		if (ret)
>>> +			goto out_fail;
>>> +	}
>>> +
>>> +	if (assign_state & ASSIGN_TOTAL) {
>>> +		ret = rdtgroup_assign_cntr_event(r, rdtgrp, d, QOS_L3_MBM_TOTAL_EVENT_ID);
>>> +		if (ret)
>>> +			goto out_fail;
>>> +	}
>>> +
>>> +	if (assign_state & ASSIGN_LOCAL) {
>>> +		ret = rdtgroup_assign_cntr_event(r, rdtgrp, d, QOS_L3_MBM_LOCAL_EVENT_ID);
>>> +		if (ret)
>>> +			goto out_fail;
>>> +	}
>>> +
>>> +	goto next;
>>> +
>>> +out_fail:
>>
>> Is it possible to print a message to the command status to give some details about which
>> request failed? I am wondering about a scenario where a user changes multiple domains of
>> multiple groups, since the operation does not undo changes, it will fail without information
>> to user space about which setting triggered the failure and which settings succeeded.
>> This is similar to what is done when user attempts to move several tasks ... the error will
>> indicate which task triggered failure so that user space knows what completed successfully.
> 
> Will add something like this on failure.
> 
> rdt_last_cmd_printf("Total event assign failed on domain %d\n", dom_id);

The user may provide changes for several groups in a single write.
Could the CTRL_MON and MON group names also be printed? It is not clear
to me if it will be easier to print the flags the user provides or verbose text
that the flags translate to, that is "t" vs "Total event".

>>> +
>>> +	return -EINVAL;
>>> +}
>>> +
>>> +static ssize_t rdtgroup_mbm_assign_control_write(struct kernfs_open_file *of,
>>> +						 char *buf, size_t nbytes, loff_t off)
>>> +{
>>> +	struct rdt_resource *r = of->kn->parent->priv;
>>> +	char *token, *cmon_grp, *mon_grp;
>>> +	enum rdt_group_type rtype;
>>> +	int ret;
>>> +
>>> +	/* Valid input requires a trailing newline */
>>> +	if (nbytes == 0 || buf[nbytes - 1] != '\n')
>>> +		return -EINVAL;
>>> +
>>> +	buf[nbytes - 1] = '\0';
>>> +
>>> +	cpus_read_lock();
>>> +	mutex_lock(&rdtgroup_mutex);
>>> +
>>> +	if (!resctrl_arch_mbm_cntr_assign_enabled(r)) {
>>> +		rdt_last_cmd_puts("mbm_cntr_assign mode is not enabled\n");
>>
>> Writing to last_cmd_status_buf here ...
> 
> Sure.
> 
>>
>>> +		mutex_unlock(&rdtgroup_mutex);
>>> +		cpus_read_unlock();
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	rdt_last_cmd_clear();
>>
>> ... but initializing buffer here. 
>> Sidenote: This was an issue before. If you receive comments about
>> items in patches, please do check if those comments apply to other patches also.
> 
> Missed it.
> 
>>
>>> +
>>> +	while ((token = strsep(&buf, "\n")) != NULL) {
>>> +		if (strstr(token, "/")) {

What is the purpose of this strstr() call?

>>> +			/*
>>> +			 * The write command follows the following format:
>>> +			 * “<CTRL_MON group>/<MON group>/<domain_id><opcode><flags>”
>>> +			 * Extract the CTRL_MON group.
>>> +			 */
>>> +			cmon_grp = strsep(&token, "/");
>>> +
>>> +			/*
>>> +			 * Extract the MON_GROUP.
>>> +			 * strsep returns empty string for contiguous delimiters.
>>> +			 * Empty mon_grp here means it is a RDTCTRL_GROUP.
>>> +			 */
>>> +			mon_grp = strsep(&token, "/");
>>> +
>>> +			if (*mon_grp == '\0')
>>> +				rtype = RDTCTRL_GROUP;
>>> +			else
>>> +				rtype = RDTMON_GROUP;
>>> +
>>> +			ret = rdtgroup_process_flags(r, rtype, cmon_grp, mon_grp, token);
>>> +			if (ret)
>>> +				break;
>>> +		}
>>> +	}
>>> +
>>> +	mutex_unlock(&rdtgroup_mutex);
>>> +	cpus_read_unlock();
>>> +
>>> +	return ret ?: nbytes;
>>> +}
>>> +
>>>  #ifdef CONFIG_PROC_CPU_RESCTRL
>>>  
>>>  /*
>>> @@ -2328,9 +2558,10 @@ static struct rftype res_common_files[] = {
>>>  	},
>>>  	{
>>>  		.name		= "mbm_assign_control",
>>> -		.mode		= 0444,
>>> +		.mode		= 0644,
>>>  		.kf_ops		= &rdtgroup_kf_single_ops,
>>>  		.seq_show	= rdtgroup_mbm_assign_control_show,
>>> +		.write		= rdtgroup_mbm_assign_control_write,
>>>  	},
>>>  	{
>>>  		.name		= "cpus_list",
>>
>> On a high level this looks ok but this code needs to be more robust. This will parse
>> data from user space that may include all kinds of input ... think malicious user or
>> a buggy script. I am not able to test this code but I tried to work through what will
>> happen under some wrong input and found some issues. For example, if user space provides
>> input like '//\n' then rdtgroup_process_flags() will be called with token == NULL. This will
>> result in rdtgroup_process_flags() returning "success", but fortunately do nothing, for
>> this invalid input. A more severe example is with input like '//0=\n', from what I can tell
>> this will result in rdtgroup_str_to_mon_state() called with dom_str==NULL that will treat
>> this as ASSIGN_NONE and proceed as if user provided '//0=_'.
>> This was just some scenarios with basic input that could be typos, no real stress tests.
>> I stopped here though since I believe it is already clear this needs to be more robust.
>> Please do test this interface by exercising it with invalid input and corner cases.
> 
> Agree.
> 
> But, tested the cases you mentioned above. It seems to handle as expected.
> 
> # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> //0=tl;1=tl;2=tl;3=tl;4=tl;5=tl;6=tl;7=tl;8=tl;9=tl;10=tl;11=tl;
> 
> #echo '//\n' > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> bash: echo: write error: Invalid argument
> 
> # cat /sys/fs/resctrl/info/last_cmd_status
> Missing operation =, +, - character
> 
> 
> #echo '//0=\n' > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> bash: echo: write error: Invalid argument
> 
> #cat /sys/fs/resctrl/info/last_cmd_status
> Invalid assign flag
> 
> #echo '/0=\n' > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> bash: echo: write error: Invalid argument
> # cat /sys/fs/resctrl/info/last_cmd_status
> Not a valid resctrl group
> 
> 
> The assign state did not change.
> #cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> //0=tl;1=tl;2=tl;3=tl;4=tl;5=tl;6=tl;7=tl;8=tl;9=tl;10=tl;11=tl;
> 
> Sure. will test some more combinations to be sure.

hmmm ... these are not quite the examples I shared since from what I can
tell it adds a second \n that impacts the processing of string.

Could you please try:
# echo '//' > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
and 
# echo '//0=' > /sys/fs/resctrl/info/L3_MON/mbm_assign_control

Reinette



