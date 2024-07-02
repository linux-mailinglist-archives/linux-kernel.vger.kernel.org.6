Return-Path: <linux-kernel+bounces-238561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF59924C15
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 01:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25ED6B21E35
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 23:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE8915921B;
	Tue,  2 Jul 2024 23:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ADggSUeq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850CB1DA30B
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 23:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719962650; cv=fail; b=KgOIi8jY/s2SFpXvrMxpgIRYPA2E3sLhWHqB1pmi4PxMMm931Gxd3fXJ+8C2r2UvXRoRn+RgdubdCiJ0WYjhCeH+1Hkv9XGzq3RK7o9IOrNRves+JM7X9OaXQ0OZuvTcsUOE75901QyxhKRNpOsdsHWkXnSopjhTUqJQ32h7bV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719962650; c=relaxed/simple;
	bh=x1B5L7W4eEefLj1l4rqNTxrNjKYFUNEIynkd+nsL2Uk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DeDjFyPrbQMpROAX4d7bsXDbocdrwLtMLJp9drl7JgIo+B1PYDVRRvHTEoLhi37KPXrHL/AkztX018FvwzcSFjIPYhXSwV5+sOMKnJVGKhn2mBLaUWN4d+NUqtYihF0qmesr18+dHECFGfEqzOEAlf65KIHMOnhFV76/GqNPWho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ADggSUeq; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719962649; x=1751498649;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=x1B5L7W4eEefLj1l4rqNTxrNjKYFUNEIynkd+nsL2Uk=;
  b=ADggSUeqEvOj/fyyqb6ZXUcj6IUi2nFXsiLFpmBOAp63mp4cHixMrJe8
   TVq3jWG1lDUKc3nE8m32O+kgXEOruoyJWBOUFW8mcidiaMjoaDwnuvgHi
   Lgya8MEMwBajUDUwV8GEcGNOjjvGgWQyvf1ZS/z1K5B1FTzsH/lu5JU8U
   UiMwZzB724EZju0jycHOBTEnneCripm8P16EUfV4SqRvzY8MJjCDx+ytN
   boNFcODaYRbVqy635f1LyFbyzT1rIwJzLp/ZPBssQm1r26MnvmUnmzuTU
   va3iFF7MfdQ22kuUlL/mtA6UzD4+5VBBLHepBqFc+i0x3gy1JldUMQUQn
   g==;
X-CSE-ConnectionGUID: HVMe5gnWQuWR3COY0DlmWQ==
X-CSE-MsgGUID: SMK2Qs+lSWOjGlrFf9NEgQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="27768350"
X-IronPort-AV: E=Sophos;i="6.09,180,1716274800"; 
   d="scan'208";a="27768350"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 16:24:08 -0700
X-CSE-ConnectionGUID: xNggx64QTn6yHKqC1Dak3Q==
X-CSE-MsgGUID: Ro2W7m6aSHKa5O9qhCol7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,180,1716274800"; 
   d="scan'208";a="69236346"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Jul 2024 16:24:08 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 2 Jul 2024 16:24:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 2 Jul 2024 16:24:06 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 2 Jul 2024 16:24:06 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 2 Jul 2024 16:24:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NNkFpI7gbg4UWn8fgGCn/tmuSStVkBSaGfC4oqLnUVQbXlHwOmvZimPGWbnCfHB1o/eLZnLjRlJ+uNLbFx40KNqKpawSPzU+x4JY8BNRPX/osrWhHK2arBK7YKCkUAfPUIvASjYYqeeSFc5iPIpQoI096tPX9fGuxeUXTaEGwYIfNrFpX5wNklGvn5ipobUjAFn9vP5UOlm/KxY566VphvTslsIguRianzbG5VRMUPsoaU6ILHHfl6xF6qF4UE+ZIfPt4/g/RvGigcmMYBMG3tD2PxV+gaeLgE5ifcLUsiMVDWcrAfYIKspAV0KYqwT5kPFP5t9yccnDbOO7kbe+ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lDvDbP4bN6Uj5VYvopwkcbrA6iSydst67g17ndtONfc=;
 b=hAkzsQALkRul1IP5NoNvMfHNV2e84L+0Y1EfGxBlH1OEo0H3ANeg/tkl3T4lXky3n8l85UKmqeqWtxRq9uAUvQrhRagkEYyY8NZoFTY3TeaLKG+auKc26zSXPpj52E4DkuETo6+WgAHJUr9Ghrur7JU96L1xqiB3rOV7KZHKAjcNwqm6KtnhTHIkY87GD+/pwYjba6cReAqG4vlC3jSro3L8OEr5Rv3oDxHbEKStf63VfmfvUKXBgrBbYjozK/dyLhwy9MwedO4/lZWVgiIC8TCKa/MLVQmKiYfKT4M9IYYV6ZuOcaiD6Xak/kjdB4YkVhYLt2/fbF/8t0yJe6FbBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 LV8PR11MB8510.namprd11.prod.outlook.com (2603:10b6:408:1e8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Tue, 2 Jul
 2024 23:24:04 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::b1ef:c95b:554d:19c9]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::b1ef:c95b:554d:19c9%4]) with mapi id 15.20.7719.029; Tue, 2 Jul 2024
 23:24:04 +0000
Message-ID: <afde4955-bf9e-49ac-9ba4-ea8413d65e14@intel.com>
Date: Tue, 2 Jul 2024 16:24:01 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] arch/x86/microcode/intel: Remove unnecessary cache
 writeback and invalidation
To: <linux-kernel@vger.kernel.org>
CC: <x86@kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <tony.luck@intel.com>,
	<ashok.raj@intel.com>, Yan Hua Wu <yanhua1.wu@intel.com>, William Xie
	<william.xie@intel.com>
References: <20240701212012.21499-1-chang.seok.bae@intel.com>
 <20240701212012.21499-2-chang.seok.bae@intel.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20240701212012.21499-2-chang.seok.bae@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0206.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::31) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|LV8PR11MB8510:EE_
X-MS-Office365-Filtering-Correlation-Id: ab797a1c-77b9-4fdb-d6f0-08dc9aee0fcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q2dFZkg5NklZWFFwSStTdTFlRGt6K0tEVnZlaXVkTWhzOTB5bllnZUhyUkpF?=
 =?utf-8?B?VjJYWVdxS0pCWVVJSWt1UXVlSnRHVnVVOFJZMmV5dno1Ym9ZQVkvZWdPdzYw?=
 =?utf-8?B?MkIrWlZGSTNNVmF6SlU1YjdCTUhvVHFsWVJZdktzNnk3Q04wTXMwT0FYZzZ1?=
 =?utf-8?B?SWp5UmJNOFo1V3VUTnZEUUYxNUFYSENNL1d3aEwvbFNaZGRYSFBPWE5icGpF?=
 =?utf-8?B?QnlBUmxNNGNaUEZoNUd2YStCTWdoRXhkVld3UzkxQVVpUCtwU0NGdnBjekFa?=
 =?utf-8?B?T1lYVnNKVzFhZnNPY3dLeFZQOW9XNUNocSs2dUxzUy9kK3pYVm9XSWNCbGR1?=
 =?utf-8?B?MFBveC9TVFB3cnNEVkY3RmdwRnJicmtSbFNVRmJpdEpzZTYrT0dMeTh0K0lS?=
 =?utf-8?B?UkZwRDZqK0l0b29iNXYzMElkSms4WFg0NXJ1VG80dS9oYlJkTTFHN1pncXZ0?=
 =?utf-8?B?aDZxclY1ZEVSTEpKSHJQVjdhR20xaFI4SUYwYklyTTR2bUZqV3hPRExZUFVz?=
 =?utf-8?B?SktWdS9hTzBybWFQeE42NSthaW9wMzFJRC9OMzA2U2w2cVMxQnlJc2VYbzc4?=
 =?utf-8?B?eG9aWkw0RXBmN0tHQU9vZW5oaEs3clNBYkM5SUsxU2cxMjJCa2dtbVVBV3p2?=
 =?utf-8?B?bEd0bVJiSmJUY1FqWUJ0MFBUblVCelNJZmViZ1lHc0czMUhaZWxpR1g1SVJL?=
 =?utf-8?B?emRlYjM4d3NlZWx3V0NvTUZleTk5V1hSRTJVeHg0UC9ZRGwwQWc5ZHJ2aUk1?=
 =?utf-8?B?N2tQZE9PeFdGRHFqcGt3U1pvZStRVm12SmRheU9Lb0tKdHJPdGFRYU4rZnZa?=
 =?utf-8?B?UFdTanEzTDFSUzZRSWRRNFJwZFdoZ3dlUE1zT1dKNjRXc0ZNQ1N5d0xrYUhM?=
 =?utf-8?B?eDlRVmhxZjErMWRYVG5oRDhxazArcVBMRWdBZ3IxOEhKVXovR0ZEYUxUN0pn?=
 =?utf-8?B?Y1NHV3ZhYVdKYms3bkpiU0R0czJnNllTR25VY0ZORjBSK05UWkxBRjczNVA4?=
 =?utf-8?B?dC9lOVBtRWNkTkgycHgraWl4VFJFdjRPaFNaekd1Y3V1SHBPb1IxWSsvOHk5?=
 =?utf-8?B?TktLRXl6Q0IvNWxuSU1VVTRjR0tlWXFvVTQvVTY1SmhjdXM1T0RoSnFpR3p4?=
 =?utf-8?B?dndCUGFtYnFyRkZRTGJDeFNTRmpMR1NabzdQMU0zOUhUczdaWXJDZ1FISkht?=
 =?utf-8?B?eHh0VFVwSUh2SHB2RC8vZVl3Y2MrSmpzYks2clYrV0lyOTZUQjAxQTBWa3BV?=
 =?utf-8?B?c0k1dnEzY2dTM0VQSE50Y3k5NVhSQjJpYmhraysyUDZGK1JFNEJPams4TUMr?=
 =?utf-8?B?LzVXTXVyaG05VzBnS0VaYmpsWjJLdTE4MVNkT3JFdzFsMy9HSGtZc25rYW5I?=
 =?utf-8?B?ZE82ZmZMeEQ4TitueGN6Z2doNG1hSmhjVzRpcm1yV1RHTmQzQVhvbXR1TEhl?=
 =?utf-8?B?QmN5MW5Bc09FVXF1Y0xReVd0aWxFNU5uZ3BUYVpSZEpIelNBTWhMbzl4clVW?=
 =?utf-8?B?QVpia1Z1d2Y3LzBRQVV2MUxzUG55NWppWXpaTHQyZUlZUnc0RC8xbytzVlU5?=
 =?utf-8?B?ZGVRRTIrU0Zmd1F4TGh3Zjc0Vk1ZbHdjSEdOckFHVkx6UUJoMzErVEFQaHA3?=
 =?utf-8?B?MGxIOEFRZFZBY3dDVnExNWsxaFRSV0tuSkZEbzZ3Q0tlRWpXQW9aRGpXQlJV?=
 =?utf-8?B?Qk1pc1NuUDJZZyt3ZkRhbkJidUpSTkZmREI1L0xpeDdVa3FZbkdqK00vQ1Fy?=
 =?utf-8?B?eE5BTFZiL2FhdFdGd1VQaE54STh2aGg4alFnWlpBYVZhSDdSazd2YTV4aGVV?=
 =?utf-8?B?SFVtYWdKSFBRaldsWVI2Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFVIaEtWei8rNHFQVkYycGtwSVZqME9ZcVIzVXphZFFiWVpkMmlycXZ4UzlU?=
 =?utf-8?B?QW1WTVQ1OWVDUjByeFpZR3FYQ0d0WTRCSTZtdHVEVDFSaGNzYTkwQ0RBN2py?=
 =?utf-8?B?QndTS1FTQTEwUUkzUXFQOUVrRTZqcGZENkwybDg0czF2R3pqZmt3MWpSMXJN?=
 =?utf-8?B?bW9GSmZHemVpM2Zlb2lTY1c5eUV5THJJRmIwbVVnVUhaVnIvVFFJd2lheGRm?=
 =?utf-8?B?WElFeGpCWGMrRFV4RGRKSVhIcmxkZDRra3RXYkhmUVE3bHpjY2lXcXFFNnM2?=
 =?utf-8?B?NmhxaVFrMllLUXM1aGZkWmJKcGdtWmtjeTg3b3NKbTRNSisyYkpSVzhZZlhP?=
 =?utf-8?B?eDhna0o2SHIyeTJEdThDbldvOTcydjlyM3ZMbFlBTFo5VEkvQVZuOTFoYTN4?=
 =?utf-8?B?YVBXN292UDhhUVN3MDMvZDBTdGh3SzlDZk01dGlMSE41dzA3d1lBcWp6MHZ2?=
 =?utf-8?B?dGlZSG93cmNRbzFQcXNQM1I3amNHV3BxcXVmZlV2UjNOYWVlQ2RKVkxPNnlT?=
 =?utf-8?B?dVdJMTlKb0xCWmFGVWxxWFRNQWc4eDl0UW1lZGZzWTZUcDlaV3ZuVzhoeUFu?=
 =?utf-8?B?NVUzd3ZqMjRBRHJpNEJOQzFGR2FIaWNRT05TNjVUbW44cTcwT3pnYnBZRGRa?=
 =?utf-8?B?M2lOYTM1eDluZ242MFVKOVltTHVxU05hdlloZ3pJREVScWtGZFVhWXNGQW9C?=
 =?utf-8?B?SzFYWUk5bmhHVjNoeUliSXRFcHAxU2hZVlV5ZGJCc1FhRlJlb2dlZDRadGlW?=
 =?utf-8?B?Znl1a1M1S2dSK0VacjhmeVc0Qk11YVYwbGtOVzI4Nk1qbG5seTc0TU5DZEpr?=
 =?utf-8?B?ZDl1aUVmbS80Qysvek0wWGs1VW92WWFySTFFYUJGVWZnT042OUM0dEQ1V0NF?=
 =?utf-8?B?czJEdys0MWwydUswWi9kWmw4T2kzRGRDaGVhSWFuanc5VHQrWTkyK24xR1Ja?=
 =?utf-8?B?TktLYU5BdGdFcGpCRmhVRG1iUHdxdUIybFNaU0VRNzlCQ1pkc3NJQWs4Z3Fq?=
 =?utf-8?B?VGNaT2JmeE1zOTRKVXJIYkFvaGUvWkRPMHl3TXlyVkpTWDJoSjB5d2hsZlB5?=
 =?utf-8?B?OEpsRVJOSU5pM29GYm9uYzRYejdGWXR5bU91RHpHUGlPV3dhNlRqY05pZjJv?=
 =?utf-8?B?RHp6djNFRWVWYnlXVStBQit6U285RkhxZ3JNYXd5T2N4akFuMG9sV3NTa3hj?=
 =?utf-8?B?Y3o3bVg1TUw3UjhkamgwNFJZN2syS3VXbzBjTlhyMW41YmN3RUM4ODdzcXV6?=
 =?utf-8?B?amhpUkp1UE1kaFBOUHRmemxYK1ZJNTE1YWY1N1pEaGw2c3N6YUV2Y2JyTjdV?=
 =?utf-8?B?ZHdlWlA1dGk5OFgwSEJlUTUrUW9CaGZtcTl5cTU1QnlTK0xPd3FLYUhWUDZn?=
 =?utf-8?B?SFhHRnhhYlozSzROOFNmc1VqN0M5WXZhTHNwNklGN0ZkSzc2OE05a2FxMnVL?=
 =?utf-8?B?M00zQjkvb2lVaFFMTEFKQjVZbEYwL2g4N0liUlljQU0wblJYOG56aGMvZ0FX?=
 =?utf-8?B?Qk9ReEcyYzVDaUVnSlRJN0lHWFg4NlpDdU10OThNcEh6RjhaWmpVWWUvQUpj?=
 =?utf-8?B?RzhaSWhHSlVSdDV2YnhtUmcwSEUwSUt4eWgrZWQ3Z1NWa0xGODAyTlpYZnBx?=
 =?utf-8?B?OEdETUd3ZUtGeUcxOGg0UXdOREhSMFdJemNzZVI2N01TNmgzTURlZlJqRDlF?=
 =?utf-8?B?Ni81OUwrcGRkRTlkaEJLNE5TNTFqVnhPU21vZkgrOS8zNG1JbXZDYXhyb1Rk?=
 =?utf-8?B?NWZrTCt5SmdGRnU0ZWJOeEphM1FkNHhpY0FxRVlmalFrMk9veFhpdVplL1NG?=
 =?utf-8?B?R3kxR1daUUdiYzlPeG1VSDRGMEJsdWRoSmkvTVVqT2d4dzBIZEJWQWptZmlZ?=
 =?utf-8?B?R2VCZVU1TkZ3aW5vb2ZRVWpSbEd4QkJsT3VFMDU5WnowTmRzTGxmZjJicCtz?=
 =?utf-8?B?VTZPZEF2SWcrRXpxM0VZZENvYU5lUFdnYXRLUzNKY2NPMU1zb25LVXJuMEJ1?=
 =?utf-8?B?TkJyUHZjL0hIdGgzdGluZHh1YUp1KzNMYzBHejk2VmxQMGI0Wjl6YWFNeTNL?=
 =?utf-8?B?bm1zRGpsaHQ5UVA2bnhYZThRNE5IN3NPd3g3RVkvQUdJQ0VudVBRNE5YdlVu?=
 =?utf-8?B?dkNWdUlqSklJdndpZFJ2UkZQMENkTmVpV002MzcrMjF6TVpkVmZMR256RjlP?=
 =?utf-8?B?T2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ab797a1c-77b9-4fdb-d6f0-08dc9aee0fcd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 23:24:04.0186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: twqwSe1XPtprZgt5hl1/lrMoOwKYahSYeov8Kmi/PlNullPcQlDoTJa8gYDyKyDH2+CboMIS39j0+MtD0jUlRjdfSKLwjVVubHCY8+5TU5U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8510
X-OriginatorOrg: intel.com

Sorry, I just noticed a silly typo in the subject. The prefix should be 
'x86/microcode/intel:'.

Thanks,
Chang

