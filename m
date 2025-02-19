Return-Path: <linux-kernel+bounces-522628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D87A3CC9A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 23:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D83017AE8E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 22:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E404E25A62E;
	Wed, 19 Feb 2025 22:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jiK3jLCo"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1D523C368
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 22:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740005072; cv=fail; b=JMD0yCKurgggVsjG3UalSOF/gOVpJS+qTQTXYmr1/hwQM4Ci3gkTtmKlnK48pTOnw01l8k/rqvCvpH05+vB41SDxTAXDlXOLCD0PL1s8r5oGycPQsrZgLyKW9lgVaR+NeWyH28Sfu4l1CA293cbjXKAMWW6zV9yoVdCrEg3m1nk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740005072; c=relaxed/simple;
	bh=pQZT9fpxgZ9gzfEXOfzr0LpDHjmUejv1UDGFq8MA3MU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SxrIx90zBE/NIFcaguIecp2HAFB0ZfYS83vGGIPbgr/91Fqexs1ZNQ715FeAn6/li7rdDbfQL091V74JmFTy/M7aoRBJl2YsmCgguWE98fWmWWbZpiQA5PJQkUmHNV12CNxdbXbktaIkzJdGhh6xYltFy1CE5W2Q5zB7pgUAYCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jiK3jLCo; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740005070; x=1771541070;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pQZT9fpxgZ9gzfEXOfzr0LpDHjmUejv1UDGFq8MA3MU=;
  b=jiK3jLCoPUghy/6W7iK8ozdw6h/TKvEyA3J7l5mH9ZM7jm5M3m70f8l3
   DdUUTbZOz9Ft7XK+Ekmijlz1CwivaWhniBdgnh0qqLlRX/ZkvvALP+1ac
   FtIV0hO7j/JjI64fQW9bMvql1p2Q4ZjRCQhKE+6bMAaGrVR/DwBycKeCX
   jCtMoWEL8vcahITE0IWTM2zGLitAaOeWjz3Sosj3znSFeqxSeS3u1vBsw
   O1ixTiy2tnVH1OPGtb7BbMVOnciz5kQyQu0eQ21ZQ6EwkzCpwZmTZM8Kl
   CVg6VT9yDRWtgBtdv2YJK3+lknMrJ/a4oQWqzw+9q2hHWj+mC7rb68mrC
   A==;
X-CSE-ConnectionGUID: VGgMwG2fQ8CoAiyx1x5G1w==
X-CSE-MsgGUID: rZVslRGRQf2gAInKxfp5Bg==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="63241718"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="63241718"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 14:44:29 -0800
X-CSE-ConnectionGUID: 0Ub7UQaZTSSMjYkdutMIRA==
X-CSE-MsgGUID: d5izay+xQh6qcfLOIYABBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="119793635"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 14:15:14 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Feb 2025 14:15:09 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 14:15:09 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 14:15:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QcSV2hJUIfD7+gnrt3iLoohXZA3/TeJYPMBGOKGG2QUZxAaKnR3uLU/c5uBnwPe7qKx3gPIDaxAqIGkqkUWPZ/SrJKxR5PSYSM/wEu+DmZXKBFK0O5WTK541VWuuZavhVWQK94Oc5O0/5wY9cWk+gFUKrP6lrlcHxK0dAMJ0nnD/Sq05QzSjogAJAMCj2SP2zndBDHKwqeR8UEwwQYS0QMyOt7l7StEkv8muBvz7tVdfwlBJeEcl6J/wCq2vtyhgnkH1KI58OTjzoVi/dIv4fMZpi93HAFbZcYVJodoq65kEY7E0JLqUJMT9zbAu78/yM9cQL//1Wmd7zTTh9YnyYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jp/l9ZoACMk9L7akklinR5QuYcp5HI2q61i7Xs05agk=;
 b=gN/DVQMzBy9EWbrR3XNLIe70zPmi3RpmtuPigHHiN1BnmUtHREyibLeMVFodFacNaVfWsyNyCybUY1YhbqXBFEJqwkiBSu4MfFCcsvo6yyOh9kVJ46eyYLsb/qUejcywmgxHCH6nW/7TXflleISCc2kSRGE+JHj0wW9MxcfduMl6jyWncfMphV/5p0akWWCo0BENeg6u0gJVs4kHFT+ERqwwvQBCxpOIEvBY59klKiw5L2Ka9VSjBMWnia8HetprPR2o1MuwkoipVYDXe2RTGFM4ga6mWtV538spomQbClGUlzyyRchhgCoXvpB5LCs/1Ab5KHIXippJurHKKifWlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7566.namprd11.prod.outlook.com (2603:10b6:806:34d::7)
 by SJ0PR11MB5024.namprd11.prod.outlook.com (2603:10b6:a03:2dd::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 22:14:33 +0000
Received: from SN7PR11MB7566.namprd11.prod.outlook.com
 ([fe80::2b7:f80e:ff6b:9a15]) by SN7PR11MB7566.namprd11.prod.outlook.com
 ([fe80::2b7:f80e:ff6b:9a15%6]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 22:14:32 +0000
Message-ID: <b487ae9b-99b5-40b6-a6c5-a90ab62baa5e@intel.com>
Date: Wed, 19 Feb 2025 14:14:29 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/42] x86/resctrl: Add max_bw to struct resctrl_membw
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
 <20250207181823.6378-8-james.morse@arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20250207181823.6378-8-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0022.namprd02.prod.outlook.com
 (2603:10b6:303:16d::15) To SN7PR11MB7566.namprd11.prod.outlook.com
 (2603:10b6:806:34d::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7566:EE_|SJ0PR11MB5024:EE_
X-MS-Office365-Filtering-Correlation-Id: cb83c8e1-d40f-4f6a-1284-08dd5132c94a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WENUb1lqaGNjSEcwa3NYOVhNOWxrM1huanhUZmp6cmxlMnFXWlNtY0ZnZmsv?=
 =?utf-8?B?VXlaUVArek9UY2I1WkZ2Zm5aMDc4ZUxzeFc0VVN3aXoxV0kxYkZKNzRsd3lF?=
 =?utf-8?B?cDFQSUVvNFlmSXZsVEQ3V3JCUXMvckJOQlFaQ0Q5TjZvZ2Q4U1dWdEFYZENI?=
 =?utf-8?B?cTc0UDNwT3J1Z3I3clpHMG1OYThDd1dFQ2UxbXIrMExPRHozRjNyYVhZbUVC?=
 =?utf-8?B?aVRZTC9DWTZjUGFKL29kUGZwZVpjaVUrQmlMMkpQOThRMHFwRnNKRkR3UkVB?=
 =?utf-8?B?QXRvZlI1TXZFUGZiOFlhMXJua3hNNG5LV1VQOFlMUDlEVS9RNmRXTmZSSVQz?=
 =?utf-8?B?dk9MY2R1Sk9sT1UxQkFZODJjd3d6Wk00b3EwUnZFZVhqV0tVbnQ5LzRWVzZu?=
 =?utf-8?B?Z1d1QklPeTRNa1Foc0xUNHV3eGxzVWJvaEVheG5hYkxnbVB0RGNISXhZWU1V?=
 =?utf-8?B?R3pzOFZxRmQ1TmdCbndxRTJoTGVBUUdSbHVkbVNnL0lzVmF1cGhvYzN6MHlL?=
 =?utf-8?B?aXBlWFhxMnVVK2doeUxsQ2ZWRHdSbFM4UDNPUmRHOUlkRGwreW85SDY1bUpK?=
 =?utf-8?B?SzhOM1ZwTlBhbnNCS2ZDQVZBTDZpdGoxZCszWDVYSy9WZEtKSmxXZVpsc1VN?=
 =?utf-8?B?V3pvMlNrbjJadkdVaHdrclROdWNwUk1pUzZoTnFVVnNRNTJITnMydFVKN2Jm?=
 =?utf-8?B?R2s0UEFteEZSek5hcnJ5OXdoNC84K2FvVkpGR3lFT0tveFo2czlxYzJGNHly?=
 =?utf-8?B?ZHFFL01RMmxkNFd5OFVpSm1QU0Zsa3plQkc0REk4dzdJbXNKOXBncnZYdTBV?=
 =?utf-8?B?SHc5MGxTdU9xU1ZsSDViakRFZ2wwV3pXMDNQNVVsdjRwNjZ2ZjN2SFBkYzU2?=
 =?utf-8?B?Y3hUWnU1cmZhSFBkOFQ5NUdlYUNJcmF3RCtoL2E2cnU0djd6SU0wMmZXcTg1?=
 =?utf-8?B?VzJhczBMQ0s3K2FlTC82Ykp1eFNNLy9kQkRvSlNqekFYYXd1Ykg1TnlEdzZo?=
 =?utf-8?B?dlFLL0I0OXRIMGkzNjdnaVlWd09vbUMrUGxuNGRIc3BBR2hQbTluTzIyTGp5?=
 =?utf-8?B?MHFFekx5bGEreUJvdXQrSk1YbzAxdFVja0NwUVdoaENLMDRoMk52OHV2NHQ3?=
 =?utf-8?B?V1hhVThKaDBDMlhqNTQvUWc5eVIrUFVhSHFNaXIrK2kxenFHK1RaRWMvRDYv?=
 =?utf-8?B?ci82SXpiQkJ5RmlYaDlkc09uRHZRY1JhYjgyczZuSjliVlBGbnZJYWRKaUNh?=
 =?utf-8?B?L254ZVlKQml4eXk4ZDJpMGFJeUhpWW9sbDhaNEVRVk1XVEJob3NmSVl2R2l5?=
 =?utf-8?B?Rk5vNEszZmVXbWZYNXU5STlEZWJwTU1IcW1NTThQSjJoaWNvRUlTOCtSc2Vz?=
 =?utf-8?B?UzkrMG9UMU8yWlNwaGNxcWRDZGtEWHB6S2pCaEFKdlNKdlpKU0hrUHJ2dUJL?=
 =?utf-8?B?aHptWVp4RUhQcy9jaUhvQ2w3MUg4QVRhU3hwN1E2aXp2Qmx2SkpGNlB3Qnov?=
 =?utf-8?B?UFowTmp2bjlFUHIrOWgwcm50WlJzbWhVc0xlYVlNczkvaCtYYzFDUUFxR3N4?=
 =?utf-8?B?N05pd0hFdGZ4MVZkekhPdnU2czV5OHRhLzdvcDU5a3BERDQ3TitzZDNsWGZi?=
 =?utf-8?B?VEkzRjM0b00yZ04vOVBTK05jNVI3alFzcmxoSHZsVyt6UDl0NW1ON2h4bll4?=
 =?utf-8?B?YThOQUZiR0ZYY0JheTFtVmZNeFJSL1JVU1pQZEJldTk1dW56OHFDRzZYeXhN?=
 =?utf-8?B?MVQrZDlZTUpLVFdJMlViSFZzcER2QUZZVmM4b1h0ZXEyblREUnZ4RTB6ZGYz?=
 =?utf-8?B?ZWFmeWJVVTlrQ1loT2NQaTZ2dUNqT0d0OFRleWhHcGV6U2VJYm1GbHJwSktr?=
 =?utf-8?Q?N3bWgjyJTect6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7566.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWJGTE8rRnc5R0xMenphN1ZvZStWbk5hVE5xQ2dVK2xETWlTclFVY25uVmU2?=
 =?utf-8?B?SkRtVXVKQUZoZEV0R1pkYjVkVFQzTkphemVreEs3VG51REtEME9IK2haVGRj?=
 =?utf-8?B?ZEQ0bkpScGhhK21sK1R5TlpDYjhBT0hCZmNCanRHekJ3SHhITzZnMDcydmNS?=
 =?utf-8?B?SFFSM2xqSHZxcWgzK3d6Z0FwVnVoRDFVL3huZWR0SlIrbVNjd0hKd2E2NnBG?=
 =?utf-8?B?dUZ1b3VJc0V4NnRBbmYxaHVhSE1oZ2RvY2x6Mm85RzJ2bXFOTFN0NU9mMWd5?=
 =?utf-8?B?dUZ2UE5zVDNPQWZ6cXhINWtMdTcybFF5VVFwS3Z4SzZ1eVVrWHI2MDRHUGF3?=
 =?utf-8?B?NGV0cDhXSXl3VU5PNjczYnFJQ2FsREdKKzE3Y3A3WERPd0x3QjR0T0haaDZY?=
 =?utf-8?B?bEpOSDVFdi9vaUlGWmZiOXZVU0tkQmZYSFh0UFZiSmQ4L1MzaVlTU1ZRMWd4?=
 =?utf-8?B?emJVTWE2ZlR0OUMvUW1nOEFXYUg0dkcxRTErUks2dlVnVnR1WDNuZ0hkWGpJ?=
 =?utf-8?B?NllRNlE2bVVqUlNlZmtTT2RoOXdrU3J6Q3U2THVnbmxZVmwrVmNlZ3VCVnA0?=
 =?utf-8?B?cXBiRmZrc0I2TUNuZGg5U0ZXZnVVa3BCWi9sNWx0MzBpWmdpM0NuSmQrcnha?=
 =?utf-8?B?VG9rZjdnSk1YR0ZCRi8xYVZyM29UejdKeGpHS1I5SklydG5HY1NtUFVKSHZ4?=
 =?utf-8?B?RGI2UXFJZ3JaM3Iyd0FUcVZ4N0hpUXRoR052OEl6VzE2WUgwLzhRWUJiU1Nq?=
 =?utf-8?B?cjVFU3paR3lKQ1lnbVhKTVBXdktCSERPaDdwQWYzeTV1RGdMcW1WWkc5Z2dU?=
 =?utf-8?B?dXJWZis2YzlHRVNJMWhldzBTZFhMUXNOa0pERzN3bnJNZTNLR3cvV2NHS1Vv?=
 =?utf-8?B?TS9uWFNHUDN1bEQxMnBveFo4c3BlcmRxZXMzT2tFdU9kMzNlOU9LWHMvMkRH?=
 =?utf-8?B?S3IveGhITURPSkRlMlJiWlNDc2FRUXF6Znl0Vnk4TENXaGpJT1NacVYzRXNO?=
 =?utf-8?B?ZjFFV0kydjEvSEFaQVdKYkczN1ZyVVpHK3ZrOVZBbHhGZThuTG8vTVB4ZXR5?=
 =?utf-8?B?TFdKSjZCV1BRRkx0V2RRbmFtUFhnTGI0eU1tVTIyOEloWmk4cE5NS0VvSXNa?=
 =?utf-8?B?K0doZ1o5a05wbm1nRndiMVB0YWY1NE9TY0VaSVowZkV1ODNNeXJQcFMwOVMr?=
 =?utf-8?B?bzU3TDhRblNJOUJ2dENkQWFKaXNOY05PaldXRG1PRi83dFhqRm1CZXhtWXp3?=
 =?utf-8?B?QUlOdURhaHN5STlyT0czeU9RVkEydkhnSkc5ZFloOFdFS0MzM0dLdTJaWjVa?=
 =?utf-8?B?WHJEZjBYVkNUTEloN2dCUTl6UjRkUGVCRWU4ZDJtL0VNd1V2dDlPTDRYeE40?=
 =?utf-8?B?RzhZZGtLY01JVERUaUlKeWhESEoyWFl4V0xZbDlHNjBzZEJBdzFzRU5MVjA0?=
 =?utf-8?B?RWc1LzlMdFNhRTM4RWhCenZuTlZuODk2M1hBNWU3UEpsNlRDMXdGWXlIZVNs?=
 =?utf-8?B?bjE5WERvOHM3Yk5nd0tPOTFaZjNES1BjYUd0QnZkZzlNT1llNnp0NGpOSDdw?=
 =?utf-8?B?eGxIc3BKNkZhQlQyaFJrZ0RTRlMwRTV3UHR4ekozZ2VXMzltMWtPQ1R4ejVQ?=
 =?utf-8?B?NWNlaE1PK0QyMzlkYmZGaitTbFZRWVM5R3ovZFNIendreWNQa3M1bXR2UitK?=
 =?utf-8?B?bTdIRmJ6YWpPSkNrNCs0TitDaXZRc1lFeCt0WllNbndBSmhJZzNRckhWT1Ew?=
 =?utf-8?B?amtGQTV4ZTk5RngxMTduc3V4eGZ1VitKTnAycy9lTW1RMy8zbEFLZEVacEtz?=
 =?utf-8?B?TjhwUlI5Q2xGZlpGT2RJbnoxcEFNVEVHQTVQK2FrazZLMDNGZGFvc3kzMFZq?=
 =?utf-8?B?Qm1FNDRxWUpKamhlY1NUVXkvWktlMy9pTW9Oa2NEdmdrR3RheUpGUVNzN2gv?=
 =?utf-8?B?TDg5RkRsSFJTQUI5ZHNIekg1ci9lTGhNZUdpM2IzNnBoMmExcExKcVRmcDVV?=
 =?utf-8?B?WGkzcDlVM0ViQ1Zvc05ZaWw3Mm94RE1GR0kzZ1M1cGhlVDEwYWlRdWpWb1Rs?=
 =?utf-8?B?cmFUcmNXeWRtUUYxRE12QUJ3NHlqcjdGcnhtQ3FkUERDTU1yUUFKSENSWFFl?=
 =?utf-8?B?b0UvQ1kreXZWc095M0pGd3ZnTm05NkhYNGVDSGd2OUpTQ3RUdHQydEdjYlJQ?=
 =?utf-8?B?eVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cb83c8e1-d40f-4f6a-1284-08dd5132c94a
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7566.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 22:14:32.4781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EQKjP2wMy3QPHWhGk6jsx/pHMBr5uNcqOMH8Mv/UVtCYA5ySviMsEAQkmTnCV5DDpsOX4iIJPuBkPwomattZMrjd6yVoaf0A4BNJMFzNxXw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5024
X-OriginatorOrg: intel.com

Hi James,

On 2/7/25 10:17 AM, James Morse wrote:
> __rdt_get_mem_config_amd() and __get_mem_config_intel() both use
> the default_ctrl property as a maximum value. This is because the
> MBA schema works differently between these platforms. Doing this
> complicates determining whether the default_ctrl property belongs
> to the arch code, or can be derived from the schema format.
> 
> Deriving the maximum or default value from the schema format would
> avoid the architecture code having to tell resctrl such obvious
> things as the maximum percentage is 100, and the maximum bitmap
> is all ones.
> 
> Maximum bandwidth is always going to vary per platform. Add
> max_bw as a special case. This is currently used for the maximum
> MBA percentage on Intel platforms, but can be removed from the
> architecture code if 'percentage' becomes a schema format resctrl
> supports directly.
> 
> This value isn't needed for other schema formats.
> 
> This will allow the default_ctrl to be generated from the schema
> properties when it is needed.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

