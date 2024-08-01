Return-Path: <linux-kernel+bounces-270736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01256944496
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 08:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D747B22026
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 06:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DCD158219;
	Thu,  1 Aug 2024 06:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lJFRf5TK"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BF3157A55
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 06:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722494372; cv=fail; b=jvuO0ReA6JjfdbFDunaUkbmqZDn5M3L6bO1jxAmMJrbpAECxP8/j8AuLCabgjyY9CUl4wr78IBgM4NcNblmFrKeqj6RLit0Sbi8IGYW4HtMUfCTu8STUnfDt3EiFaEiVC3O108Z84Kzig87EMlyY6hAvgXqFoC46wGfcbCTpTaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722494372; c=relaxed/simple;
	bh=bSW2BgYxiwjJ6oZ7i7/3UwbO5g7Gap/5lbWqhowhiS8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FSx4iA5zDh3zZw6D15u19rMmJEcR/zY4/t/SOQXK47EbQAs8Zusciy3u27g9waukUr6wrOFEzPPEqKydpDb4/V3bZo95n5UvNdG++hfwBVMxamr/NxdBfjEplSeWW0aejzR0gBAV6jfxvVz4yq6P9L1PsG5h967dpVYQ+oUVbNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lJFRf5TK; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722494371; x=1754030371;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bSW2BgYxiwjJ6oZ7i7/3UwbO5g7Gap/5lbWqhowhiS8=;
  b=lJFRf5TKC9Sk0TZ/xtQJ4r4OlEtvEisqnHH7p54TUtp417hWqjvjjUZE
   nYTRPE57h/k5AZAuj/AarOk0mXJ/bbijO+DzRelb3gth/oOw/ipP9WsjI
   wPUT7Mjww3nGGFjOXj3xUGscxvKlHfz4WARV6oDXxwQHsfb64NOrNU99N
   bqV2qNEc8YGVXbCEoMYsFaZfYyRO7dA69+Z2+wxUs3kw/JWILyw8V23rV
   JMyAkr3CdIsEICEvcIncl0P3it1PBhx9XiWFD+BkX0Ft4R/tGxCMx8sBo
   REsN8FhAWXXq+tp+GeQIeKHFXl5zaQGWihlQ63LM6aZh9DdUuiyr0nqO5
   g==;
X-CSE-ConnectionGUID: zvuzzqeTR1WTNmPPMYwtdA==
X-CSE-MsgGUID: WOX4Bi1AT1639YRdabM0KQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="20007430"
X-IronPort-AV: E=Sophos;i="6.09,253,1716274800"; 
   d="scan'208";a="20007430"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 23:39:29 -0700
X-CSE-ConnectionGUID: VcfCnsxpSWekVMsDkpVFIQ==
X-CSE-MsgGUID: 6GKKecfaSmyRgucnhRlTsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,253,1716274800"; 
   d="scan'208";a="55167809"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Jul 2024 23:39:27 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 31 Jul 2024 23:39:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 31 Jul 2024 23:39:24 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 31 Jul 2024 23:39:24 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 31 Jul 2024 23:39:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qGygRG9bzhtkcLayIKZVXjGY3EN6lGOB0T2gN6sk6ZjxmYCa7MnrEVWT7RlC8r26WAvAznDoAim/1oidhVJ1yqgEpj7lA6HgounVBIA4hYHtv0+Cwlj/elYLGrR4IU5cv/UGzzMakcmu97Qn8HX4BM3wTd6OShq9dCAIXPV+32OPfw6pX20euHJv7k5N528jgfov/zGrb7yYUnUrMceFHb0GMbkEVDGhLEMXjjjuihpaIVxjrIGscITdvqPKnxgxT9wE+GlLusWaiH96eBcycB0B9uAu5gNrMExoXqCECJt5yeu0JlHiAWi94EGWAimH/R7QM7WzpESbgUUIK1/6lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fdGsbx65YS5UKuqXxtJc4vGCV/NHXQY4Rfhrk0lAZ08=;
 b=dGfMGYVAd+k02doQ/9gQBMVUbFNrdXC4JMgnl4TzaBX3Mm0K3Mg8/Zef6NDE5Jf0iKBrKTpz9LBQDpe+dCitWNv1rV2aRDaOSI+/sqO1wGr/7YF7ckySr4UySxU5URtemyzQqADY06KJ8SuCfcX38eRJh6ldTLjaGC+y5d+FnMHzM1uJSjrIikSE70pKqKgZKgUDRPtTe932D424Xb/ddSR60RFAH3vhPWUAClQXAtgPIqlyB5QzHZFOeXTbzFTfSRzFsoK+Fmc2DzSwN7SU8lhX+20N8D8guE7kGZEegzaih7OCmHp2DY9+vCZlsNxDzEiFTPBzVHregV2/UOz/xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by SN7PR11MB7538.namprd11.prod.outlook.com (2603:10b6:806:32b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Thu, 1 Aug
 2024 06:39:22 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::47aa:294c:21c9:a6b8]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::47aa:294c:21c9:a6b8%4]) with mapi id 15.20.7807.030; Thu, 1 Aug 2024
 06:39:22 +0000
Message-ID: <439265d8-e71e-41db-8a46-55366fdd334e@intel.com>
Date: Thu, 1 Aug 2024 14:39:12 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [linus:master] [mm] c0bff412e6: stress-ng.clone.ops_per_sec -2.9%
 regression
To: David Hildenbrand <david@redhat.com>, kernel test robot
	<oliver.sang@intel.com>, Peter Xu <peterx@redhat.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Huacai Chen
	<chenhuacai@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, Matthew Wilcox
	<willy@infradead.org>, Nathan Chancellor <nathan@kernel.org>, Ryan Roberts
	<ryan.roberts@arm.com>, WANG Xuerui <kernel@xen0n.name>,
	<linux-mm@kvack.org>, <ying.huang@intel.com>, <feng.tang@intel.com>
References: <202407301049.5051dc19-oliver.sang@intel.com>
 <193e302c-4401-4756-a552-9f1e07ecedcf@redhat.com>
Content-Language: en-US
From: "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <193e302c-4401-4756-a552-9f1e07ecedcf@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::6) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|SN7PR11MB7538:EE_
X-MS-Office365-Filtering-Correlation-Id: aeb84101-ec11-49fb-7c98-08dcb1f4adaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SE9Dc1lGY0pnd05MZ1dTcjl2OTNOVGJicW9zMlFGd3Q2VlprVTNJQk5obHNI?=
 =?utf-8?B?aUhLS2VSS3l1emFKc2t6RVZwYVIwQzNsU3ErdkZDem5sQks0bWFha1MvdDFx?=
 =?utf-8?B?ODFBdzk3eDVVemNIYldHMDhsUHpuWTRIZHo2bnh0bFhXc1dBUjJTNWU1Zzlq?=
 =?utf-8?B?M3k2NEdva1VuTG5CeDNJcEpCeW5PalpaWTdLT1ZtSHVZSmcyZmtMaG95cXk5?=
 =?utf-8?B?QmJKdytkSUo0dVNhQ05mVGxxVFJwMGJ6T2YyRDgxYlFDekR6RHlFNkg0N3V0?=
 =?utf-8?B?R3o4SFBGOEFUNGhiWC9CLytacENPNjFYZ2hQb04wMnhrbmpyTVhRVmMwVHBW?=
 =?utf-8?B?MUVneTFKbDhuOVZXaFNTcDRXRVY4OGtLZDZTS3dHNDk2RDhQcjlBU0RnSk50?=
 =?utf-8?B?NEtpdENNRUhHZlNDR1p0WTA4U3NVekdpQ1JUZjgzclA5aitlMkNIcDk3cEIz?=
 =?utf-8?B?RVkwL05BQjlpTXhETEF5NmtYdVJvRFlWdW5OaFFJN2ZLRXc5bmg3anZPNnZt?=
 =?utf-8?B?Q3l0Q1QydVFlWFBGQkxDdDA0SFF2Z0pCU1VNNzhqNGZCNTVIUE9ESzZFc04r?=
 =?utf-8?B?dGh1S25rOXduTFNaTEd5bGcvRG44d1pFa2wrZlRobzNJMVdKVm9uenJGOFdY?=
 =?utf-8?B?WVEwajAxNkJqZjBnQklwWDRpOFl1RzFzejdiYnRhNEJPQzJHWG5FWTYyRmVn?=
 =?utf-8?B?d08rSU5SOEFoWXJPdzF0eDdlUE9oV3hHUkxZYXBGZmtTa2NtYTJaeGtycU1W?=
 =?utf-8?B?TXU4R242S2NZNUJqTk8rOEdKZzNscHB0RWtrdytKdWFJMVM4U1NxRXZPdzVX?=
 =?utf-8?B?UnVodlVHZklpa0lqQkZsa0xSeXgwa280cWJ0N1ZKSFhMTUt4MDBOc2YzR1pi?=
 =?utf-8?B?ekx0aDB4SXZUaHdoVGswOG5mTzhiOFFJRUNQenRWVWlkcFRlem9zTi95Nksv?=
 =?utf-8?B?alIrL2xUeEJqU3pZbzlFM1lHdmxwTE92OWt3NUtkOXluQ3F4YmVzbDAxWTFy?=
 =?utf-8?B?Sk82UFIwN1cvaXUzVjBWcmN2ZFhVdTl1eFc1SnN6QlNkYjFzcTM2TG9TSXgv?=
 =?utf-8?B?UHgySWhHQTZIbkZSVUh2RXZyY1h1VExVWEljc0xEZkJZcXJDWXllbGUzbnlV?=
 =?utf-8?B?SG94S1gxNGtUSGJzaDZqWVJLaHJyRFNqSTB6aWhteWttU016OVFDc0VrT01h?=
 =?utf-8?B?eks0am9UTmVuTmkwbkpRbDAxeXh3cktxUVMrckt4NDV1ZS9MbEs5NlJUQ2JL?=
 =?utf-8?B?V2gwN1Z1RStVT2x3VGhEcE5ONFdvaml6VGxnRUtRdWpHL3N0alk0WTJpTzRN?=
 =?utf-8?B?TmpMZFRNbWRDWkd1Uk03R1pGNXVtNU5kd2Z5dEdSWUdXOG9BVksxaUJ4MllS?=
 =?utf-8?B?NGVMaDliN2xsNnRGMkF6NTA0VEZqMVhyejNiU0FmWDVSWmlyMVgrMmY4UUla?=
 =?utf-8?B?bjROdVZQVXRHcVU1QzV5WFBheW1SYWNvVTdpVTR2Q0IzSzJxZ1dUcGhrcDdR?=
 =?utf-8?B?b0ZOMkFGQmNKVDcyY08yVDlnZkZZWEl0eFc3M01WRCtwSHRkUjZBcjdDcENQ?=
 =?utf-8?B?NmJ0UW9MSkw4WWo0b0N2a3ZRQXB2dEpRZWRmMzdmdTFMemYrSFViVktMdXVr?=
 =?utf-8?B?M0YrMWJqbXRlSmF1KzRzUmsva2t3ZS9kendmSDNxVVR4bTB6RHhqRkUzRm9r?=
 =?utf-8?B?dTdhOTBTUFU1elgzQkZUSlBnQ3hPdDBCTENUeFVmNXJTSy9CMXV0QnB1UzRO?=
 =?utf-8?Q?OyqlQi9x7/VnaVSvZU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHBtc3RYdVJDc0duZUNQL2JjMmd0S0xPY0QzNEVKb3k1bUJ6amNXcUpqd2wr?=
 =?utf-8?B?UE5DQlJqeDhMUmhBV054b2FCZmJwYnBBeE9KdldrYUxqT1NwN3A2eVlFaTBp?=
 =?utf-8?B?NUlqVlZNbkpiZWVWeGZ0bVJpSFpwZ3pvVE9OR2pIWVNlTVVMMTExaGxVbGRT?=
 =?utf-8?B?TkFoSVVXejlDL2F6TmUxbGdCSUo0c3kxcUlTUk4yV2dTSHlKRkQ5UERoWnhP?=
 =?utf-8?B?NXU2THNuQXhOTktRdSt4NnpHZ2dIeHo4MWVTOWVIREhNSGZpbGdMbEJxcUR2?=
 =?utf-8?B?R0I0aDRhNEZBZTg1RVRIM2RNZjhwUVlvaHVycEVpdXg3YVNCQ3RjZk8vemJi?=
 =?utf-8?B?WUNvOFhjY0tNYUtQOHFwckM0MXdkRHprem5DeVMrS0NYcmF1Q2xnZVJWVWps?=
 =?utf-8?B?RWdGSG56cnl4SDQ1S0t5aXFac0NSZ3diKzFTVmxiVHRmUkhUM0VsUnZzZVdz?=
 =?utf-8?B?T3BMUnozcHltN1FGeFZ1bmMvRFV4KzJEZk00WmFVdjJFZFJPeTBkbHBoUVBu?=
 =?utf-8?B?MzhCQmRXOHEyRWIrRlkyNlVZTjRPa3lxdHg4eFRVSFYxTHRORk9qVDEvNlVJ?=
 =?utf-8?B?bFEzSXRyTEdCY2cwVndKb0tPVnJLOWxBT3ZmTkNYdHZUbjZGZTFnS29XdU92?=
 =?utf-8?B?VVB1Z0FxSjYwaTkxeXo4NXVHdlpaMS9OSW5yY2F6bVQ2bmVESmVQaFEzdDJi?=
 =?utf-8?B?VjhtMFlIMm8xSkhXbTNGM3FZTVBEU21GYjZPSkpBeHZTbVlwM3JPQ3NvUENt?=
 =?utf-8?B?dUI2d08wYWQwTFRxelNlNy8vMkdFYmtYTlQ4Q21rVWx4MFE4T3hwU01ZbE05?=
 =?utf-8?B?ZWYyNmRJV2RnQnJVUHVnRnI3K05TSks1cHE4eGcyM2ZOV3doYUM3K21JMXFS?=
 =?utf-8?B?OVZCQWZYRy9wSWZZZzVZZ2FxZHF6S1o0U24rZnFxTTcvaWk4TXNEdVp1d3dC?=
 =?utf-8?B?emdlOEg4bHZSeDV5ZW0reXh4RXhsUm56ZkI5MjE5MmxjS3hITnVFWFREOWU5?=
 =?utf-8?B?ZTk5M1phM1RTcW5FZnZneDluVEl1MmJSU1N4MVl2WmtwbmRuakZvZEttQzUy?=
 =?utf-8?B?RTJWbjc5OWdoV3BmUGNPaTZzNHBhNmdLNUorMnNkekR0cVNUdG1paDNRTkZZ?=
 =?utf-8?B?cVEwald6Nkd1S1AyWVpHME4wcmNVQlMwWnllOElzOXhQczk2eFBOSTljMUp6?=
 =?utf-8?B?NG92a1BWQ2J0dlB0NWlLWkN2NUljUnRLZWV5Vlh0TmVSOUIvVjh2VFZuS0xP?=
 =?utf-8?B?cThxcEllTWJsQ3BMME9DVk1GeEZNVkNYNHpzYVdCTjhLY0loZW8vclJROS8w?=
 =?utf-8?B?emw1VXZ3cm15ejNZODF0NXNidjYyTWQ1RDhNektza1NUbmRJN1VuVkZEdWhR?=
 =?utf-8?B?M055U1ZCTXBjeHNtMS8xK3drbnpnWE0rRGhxeU82Mm1VOWhieFcwTkh5dThv?=
 =?utf-8?B?dnNBSG5SektaVnN2cG5GKzdlenorcFlRY0dCMllKdUhJek5CT3hHbWY5MWF0?=
 =?utf-8?B?YWdiSkxxYTE3eGw4VGNXbTFZZDNOczc2cDcvVDY1bFMxbzRwU2laaUpEOXRS?=
 =?utf-8?B?anpKOVZ6RkxpeVQrTlZtdmFpWHlVZkp2cHZHSTZMc1JaODFCWitJVVd5akht?=
 =?utf-8?B?ZTQ5Y3I2MlMxeGxZcWJsVXdmZmdaSWlhV2MrTHdIOTk0d2tuOTFWMFpHZ2ZW?=
 =?utf-8?B?V0VScnRjVmM4TjBCaXFSUjhUd1k1V05UZTgrNVJLZkNzcjhVWVpqY3ZSNFBs?=
 =?utf-8?B?SmRBWHVreTlxaGJlMEd2enV4c2JlSklNT0RkZ3ZyeFM1b0w3TjdtQVZ6NU1L?=
 =?utf-8?B?V1BlY3BHc25JeWhIcUt6QUhOcU04b3BrYnlRbkZlRytQaWZBWjJMVys3Vzdq?=
 =?utf-8?B?RmpJQkdvWlZRYXpkOGdJbGh3LzNyc3BMSHFHUzRDTzJjTWxoVm1tSDA0ZWpw?=
 =?utf-8?B?am0zaXNDTE5MQnNSaTgrUlUrYUJEVlhtNERKOXpTVXFuZjBieHFWaTZ5NGlT?=
 =?utf-8?B?cXJoN0FSNWZFV2w1L1creDU4RFhyaTR6T2xCS0F5dWtTZmo2VEJGZlRuQlRP?=
 =?utf-8?B?STBsMDdYSkNKQzV3T3RqakFVZWJaYS8vYUJLUWNPQ1F3Y1hMMnRqMFRwcDVp?=
 =?utf-8?Q?NdeAn0/sjQfXUcvNbNgdJ+5z4?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aeb84101-ec11-49fb-7c98-08dcb1f4adaf
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 06:39:22.6782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HAbA1PVXMquHZIEr7bsl7UbhW+Ft6QSJ0uoFTcdfkKiPKXw2c7H8lXs+XPZ6hpgakNd4d2EF3kq173CS3hb+0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7538
X-OriginatorOrg: intel.com

Hi David,

On 7/30/2024 4:11 PM, David Hildenbrand wrote:
> On 30.07.24 07:00, kernel test robot wrote:
>>
>>
>> Hello,
>>
>> kernel test robot noticed a -2.9% regression of 
>> stress-ng.clone.ops_per_sec on:
> 
> Is that test even using hugetlb? Anyhow, this pretty much sounds like 
> noise and can be ignored.
> 
It's not about hugetlb. It looks like related with the change:

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 888353c209c03..7577fe7debafc 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -1095,7 +1095,12 @@ PAGEFLAG(Isolated, isolated, PF_ANY);
  static __always_inline int PageAnonExclusive(const struct page *page)
  {
         VM_BUG_ON_PGFLAGS(!PageAnon(page), page);
-       VM_BUG_ON_PGFLAGS(PageHuge(page) && !PageHead(page), page);
+       /*
+        * HugeTLB stores this information on the head page; THP keeps 
it per
+        * page
+        */
+       if (PageHuge(page))
+               page = compound_head(page);
         return test_bit(PG_anon_exclusive, &PF_ANY(page, 1)->flags);


The PageAnonExclusive() function is changed. And the profiling data
showed it:

       0.00            +3.9        3.90 
perf-profile.calltrace.cycles-pp.folio_try_dup_anon_rmap_ptes.copy_present_ptes.copy_pte_range.copy_p4d_range.copy_page_range

According 
https://download.01.org/0day-ci/archive/20240730/202407301049.5051dc19-oliver.sang@intel.com/config-6.9.0-rc4-00197-gc0bff412e67b:
	# CONFIG_DEBUG_VM is not set
So maybe such code change could bring difference?

And yes. 2.9% regression can be in noise range. Thanks.


Regards
Yin, Fengwei

