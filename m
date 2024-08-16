Return-Path: <linux-kernel+bounces-290398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A10955353
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 00:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 495852852B4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 22:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E7B145FF8;
	Fri, 16 Aug 2024 22:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gjjt2kpv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B148CBA33;
	Fri, 16 Aug 2024 22:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723847605; cv=fail; b=dPrMolP/z20BmY1pG1qhAGsEw3W6iRK/YKJtIjtFb+/18pZBpHMuJxlKoXDNxXIvG/8utAFbOYcfsC2YgEj02VE8H1iPmTB1Lr1rpZlqUTbpr88Z6w085wZWxSwV8doSUda2A4oMlC8QEFJGe+7RD7/Og12aBvEHAOzSNpiPoyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723847605; c=relaxed/simple;
	bh=Hogo3MrnEWS1LAgrjD+3yU4wiupehXZnx8Gs9zMseic=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e8PeYumxRV0j5H+tJVtQPkrqJYaTX3PVMbpHEbyzy1bWGRg1LrJHZFyZdsqEP/aE2CiT3UY79/6uYxqfqG38DoeQDKeYSTRmQOCZXCu4kilrdgQEHI5YYLJZoeMz/ND3o8KNKOdpsh1qFeG7qg1iCbOxqZCQXSK0e+tpK1K3QyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gjjt2kpv; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723847604; x=1755383604;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Hogo3MrnEWS1LAgrjD+3yU4wiupehXZnx8Gs9zMseic=;
  b=gjjt2kpvfuPgFBd6KUyiCyiZlnfE/YA0tGbZkC4H1UJSmg2YdPlgQLBn
   q/tCgRV+DWUqZm+vnI6PdxNLI+9NFHIfvjkeSmJ2SmS8SQTfbz0NFQD5S
   zZ0cmSKmQYzq4wogU5k0dL1+cTSwiCAvb51Nk7LwtWCdW3BhI166Gewl+
   z+AyEguRSVsSNFh5gyfb+ALXt3wWcr7fm+AiGw6UDLJJzIXhvfNMr73QG
   ZnDhPCBAR0WKzxwZDFTghswGQOdYsDOYe1MZyMvzmB1IAw/BUpnU7sj0J
   R6ix9GfVnSeXV8Sw3AhDGDWwjizQ10O0ZoySct8U0g5yiDJt9JLGQiyej
   w==;
X-CSE-ConnectionGUID: BLXEDdqRRZqbCXvXusR0GQ==
X-CSE-MsgGUID: zvq8AwZ+T4aDgIs97Ml8Yg==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="22329295"
X-IronPort-AV: E=Sophos;i="6.10,153,1719903600"; 
   d="scan'208";a="22329295"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 15:33:23 -0700
X-CSE-ConnectionGUID: M7jn5PgKQSqy1NjUMwfUPQ==
X-CSE-MsgGUID: aDm5psScS0agojHlyzBP3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,153,1719903600"; 
   d="scan'208";a="59771015"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Aug 2024 15:33:22 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 16 Aug 2024 15:33:22 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 16 Aug 2024 15:33:21 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 16 Aug 2024 15:33:21 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 16 Aug 2024 15:33:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V0nFy5EHslW9BytTaJcQziqMZirxP1OzpPc6A5/HrzPzHVEu4AgbUqQG2A5fwKTtcsI6o5sR2iEPfweXMTo5aPdwBYzrbo55xYbSAMMXhz4GO4wT/39s1+IihoIyBQvgCxylOUFhdw6qkk+1bSKTybygQ/TWWsXbTHa4t8wcGtiqOZ1I+f05CXiUYX6i8Eop25xNVzKVL5974kD+9DCOXdp5noDAAnvq5I9dEQhzA6aiNSNqiZx7oQLPtq/V4xNTVDJLFc+liJ+c7qnXzOrrUW81f+i9ElqVwEQ0ASdj+Binz7c1KoczgMEonYd1dG2O7QJ8ZMmipEPbRJe3G0qszg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C4Mz7zO382z1YsBW5WGS/fqehABKMdPoy6s8llhJHCs=;
 b=TsdsarvsT6A7tV5nNE21Npe7sM0Bu/j/ACecJkkguAyVXxGSUET/4+XTvr8LFhgJxCRwyDmYRHimK3NA1/9/xczySYdt/ebhVpPVRY3S2tUmsnc1feaF5TbJmwlE7iHeWsEpR7NsnhJzBdhAOdsf9xCsk8liNM1Fv+7oXeugFk26fZOSB5zmhNOPsA7ZK6ve9wXSrVrzvrSSKPq493XAzvPF9m8mAGekOovYg9Fc1iaLCMWuP1aSlximA/i3uc17l7UO6xNapLiZJb0Dt9fTfNBpAY8LsSdVg0KvBcfmjmaY5kjMCxacwsuZhZCD5y+3pannapX47JqBYBwK8kNzsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB7397.namprd11.prod.outlook.com (2603:10b6:8:103::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.17; Fri, 16 Aug
 2024 22:33:19 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 22:33:18 +0000
Message-ID: <ab979768-a98b-417b-b319-6f14da88b857@intel.com>
Date: Fri, 16 Aug 2024 15:33:15 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 20/22] x86/resctrl: Enable AMD ABMC feature by default
 when supported
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <fenghua.yu@intel.com>,
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
References: <cover.1722981659.git.babu.moger@amd.com>
 <1061a60166f2fdb508aaf2dd9163b2bab3705063.1722981659.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <1061a60166f2fdb508aaf2dd9163b2bab3705063.1722981659.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0096.namprd03.prod.outlook.com
 (2603:10b6:303:b7::11) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB7397:EE_
X-MS-Office365-Filtering-Correlation-Id: a0bd8874-de8f-46a6-47cb-08dcbe436d59
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cDdicnR2Ly9GUVN0SVdpNHNqVlRZVkNaRzl0TU5mZnhpRW0vVEQ1UkhKZWNj?=
 =?utf-8?B?U1UrRWdvUjJsK0ZKSU5FcW93Q1VISWxrdUVHcTlPc2ExTTFoNWpXWEdhSzF1?=
 =?utf-8?B?YlhnalRIa2pxL3lPQnVoVnFqYU1VaG9PU1F1NnN0cFg4L3Q1SmRkYllidmll?=
 =?utf-8?B?U25CZW9vVm9oZkY0b1hSb3JxVDJKTmQwdklSRWZ6WHFuUE1mcHo4L1J4V0l5?=
 =?utf-8?B?RjdUOWhRTjIwZUkyU3UzZEhjQ0JzSGVNcHF2blBGVWFSR0c4Zk4zSTFnN3Y0?=
 =?utf-8?B?bi9xb0hYMFJ1czUyMUJYU0s1RjlBWllWQTVQSDRjeFZLaGxxRUc5clFuMlJi?=
 =?utf-8?B?RjVnU3dIdDFqS2YwbUtlQ0NlMGU2a2NXTnRqWFVaU2ZuL3NES2RqUWw4bmVr?=
 =?utf-8?B?Tk5MSXFVVXdZYTJvQnArRHZnWGRQU0dPMXhrMm1mK2xiQldFdmFSQk52bU85?=
 =?utf-8?B?V2IzbVJWcDAvRmhieUFFTHFSeEdyVFJpZzR4bWhxb1BqOSt2anZRcXB0d0o2?=
 =?utf-8?B?bFJtY0hXMkVRZHZuYTVrY1hsN0N4M3JERDFqR2QwU25Ka3ZGS2UrVDhJQTNF?=
 =?utf-8?B?V3lxWU85UVdGSXB0YXFCeWRJNTQ1cW02RlNWcE11Z3lMQWprdjVNdnM5Ulpu?=
 =?utf-8?B?NXV3cTk4NXdrMjdET1N4M01BWDFvc3p4WDYxbVdwall2SmgwRGEwai9DbGVJ?=
 =?utf-8?B?YVF6RU9heTQwWmZRc1BnYnduQXVnRGZIaW11QWoxS042TFdDOUhEUzF5Y1Vq?=
 =?utf-8?B?aFI5ZW15RHd3YnRqa0ovQS9Gc0lLVkl0d3dEa05TTm9Zei9WaWtueiswd2Ro?=
 =?utf-8?B?anB2ZTVVckZJb2hiQ2NJQ1NyTWFGeFhhSWk3UU1mQmw1QnVyeXcrSjgxSkFx?=
 =?utf-8?B?dk1lbFhLWm43Vm9MRFdadkxreXIrY2huNGNVNzczS1ZoZVRuWnorV2tMZG5o?=
 =?utf-8?B?b1pnWWE3YWUwbUczNEMvYXdhbG5lbVBpaDBaYU9peWZLbjdoR2tLUG44R00v?=
 =?utf-8?B?TmJ2V25FM2l1cGhianFsd2xiQ2I5aXJyblJKeDhZSlVlRW1uOEV2UGtyKzRp?=
 =?utf-8?B?LzZFTDlHeUhuQWdpT0w1K2s5K0J0N1VkK0doVnhXRkRJMTZZdjVZZElNL282?=
 =?utf-8?B?M3A1bldTaXorcUl6NDZYL3FUOHRWZ1pDSHc1aGQ2Y1g4N0NjOXZXWmFGVERZ?=
 =?utf-8?B?ZTUyRndNTEdDc1h4a1piNGY3a2dVb2QzRmtvRTNHcGlENHNhcUE0T3g0RFlB?=
 =?utf-8?B?cWVTY29FeExFWWoyQS9KRjkvdGtrV3Rmdy9FS29td1doUVE0cGlIQ0Q0b3pX?=
 =?utf-8?B?NWEwUTJ0Rkl2cit2NjY1SSs3dFhXWFg5aFpqVnJiWThxYjJGTVdSMDJMUFMy?=
 =?utf-8?B?UlNQOTdtallHMzI5QkdwSVhJOGV2VnNVRHlsNWl5ajdZZjlnaVhQYUxBZWJu?=
 =?utf-8?B?WHhIZE01U2xCT0JUY1E1R3ZQaTZkcGtOMWdudHBsejNDd1VNYzFNblhSdHhB?=
 =?utf-8?B?SVNJYnVsNDBaZTFkSmV3YU8yK2s4K1VrbGJEamVGMTJTQU1seHZ0ZkRTaWJP?=
 =?utf-8?B?SFpJZ2p4WXJtaDZIL1pzSlpRTituZXZqQjBoOEp5ZGdnbXNPUzczNnIxVTVW?=
 =?utf-8?B?cE9mZlVRWUdvejNqVW5hTmlqQ04zdkt5L25FcERiYXpsL3dGR3pnSVZESkow?=
 =?utf-8?B?dnBiV3RWMmEwVlJib1BqSkhVLy9YZXNsMVk2NERVVSs3c010MDBuUnJGSlpa?=
 =?utf-8?B?UlFQcnpvRlg0N3prLzhKRWJSeEdjMzBJU3B5Y3Zjc2ZWbUUwaXplZjJYMVNF?=
 =?utf-8?B?UU1jYklGUWtNaEtyejZEdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0g2VDNZSkNYejNuaXBMejdmdC9JaldqdDJMZUp3ZjRIYXlXS1NwTDZDWTdV?=
 =?utf-8?B?NkxzN2xNQkVZSFNrMDBidjdmaGRIYmgwbUZvVHVjcTJUazROemZwdStvSk16?=
 =?utf-8?B?a1Q1NHorRXR3TjB2TVVjWFFGNmUyeFBuN3JTMTllT2JTU2J1SmlwcXM1T1E2?=
 =?utf-8?B?WTRyT2xLVUpyTHhTOGFaZ2RML2U1cmh0N2hLb01KRzFUbXRxZ2FvZUZRMFJY?=
 =?utf-8?B?aHU2SEpnRmNYQTBqbUZadjJwMlBOTUdBTmx1QUM0TStjVW45R2JVcStrS2VP?=
 =?utf-8?B?dTQ0QzdxOUgzbXlVMXZHcUhQdTFrbEdlWGZZRGpXVnlWUDAwRVBYcHJ5OE14?=
 =?utf-8?B?Y0h6NWtRNE45dCt4YkxMVzI2WStsVlJEUk80V3BLdExva05acHo0OFFGU0Qx?=
 =?utf-8?B?RW0vTWx2dFZ4RDlORklWdzNQcnpBdGo3ellsMTdnOGMzNUtqTk9MZEd5U3du?=
 =?utf-8?B?QnZ5NytCWHRBNzZEcFFIUDB2bXhRZEo2RTFETjhMekYxVTM2Uk1KL0tWdlN0?=
 =?utf-8?B?cXhKbkNGMlNlMzJobnJxRExKeFpGRjV0UDNMMXRMcW5WRkxJVHFCLy82OFA0?=
 =?utf-8?B?STV5SXpHVndwVUJGN0NiTzNmV05hT0RaTUs4TjIydlUxUWNBQnh4QXpBcW02?=
 =?utf-8?B?dW13dWhsd2g0R1dkSjhrbFF3UDJabzZSQkNQN2ozMGVJUTlZZGdvQTdCa0s5?=
 =?utf-8?B?eXptOXZGMlJUeUNucTh1aitBY1FBNWdKSU00UHVwT0NIblNwKzJ5ZnVMeXkw?=
 =?utf-8?B?OFcrU3dVdjlvcS8rRGRCMVpXZHc0eit2WmFZSUVKTkVSNklCdkptOGdWZ1JX?=
 =?utf-8?B?eHJyU3QxTTluSW9BdjQwS0xjM0hvS09kTnBrQ01hUGcvb1dKRlBJaHM2MVVQ?=
 =?utf-8?B?MlRkNnluNlhxblhodGZQMXJ2d3JJZ2U4a0krNmFIbFNDQ0c4cm1BM1c4eHZm?=
 =?utf-8?B?WjcrYUlMeStQTkpaUURLeTZjOWgzMkFqOGZaVmp5ZGF3SDA1WjBUSjZOQUNT?=
 =?utf-8?B?bFFkWUx0OElma3lzYkU0MGVQTXBjTVRvU0RsT1c2VUZaUUdveEFHVk9BZ0tr?=
 =?utf-8?B?VE1JUExQbCtidTQ5dnVYZVppWDZ3Y0VsWk5PVzRxY2dwdEJUUVJITndMU3M1?=
 =?utf-8?B?UFJhRzI2VmhuRFRMR0V4VW5lSHltbWlSajhXdnBIcGY1ZGljZ1d3MnQ4a3Yx?=
 =?utf-8?B?b2NPZWdNTmYvTTlKcllCR1owakkvbEUzRnZqZUpWdjhTcHlIWWZsWU1RS2NQ?=
 =?utf-8?B?cnNPUC9XWlBpMGx3bmlxSk5aZjc2VTJNSHMzSXprbWpDa29WTElScmpIYlZ3?=
 =?utf-8?B?MlpqZWhJZXFIU0xsemM4NFQzaCtqYVVNV2FzMWUzR0x6bWZ2V0pzelhXSGpj?=
 =?utf-8?B?Z3IveUxseE1HNWJ4blQ0ZWJHS3gvYU8wM2RiVzBaNzFOcHJsMXVJYlVRSlF2?=
 =?utf-8?B?VWZaSnJtTmIvVkhxcXo2Nk9peGVveVFHNFhyQW1yUkw1dS91NGdwS3pMa1Bi?=
 =?utf-8?B?ZjQzQ2ozd3gwRFY3Rjg2V244UVJDTGRPbWZzWm5nVTMxVVVNWSthSFdBN2Jp?=
 =?utf-8?B?b2E5Ly8wMFllbnBjeFF3WUdpRmxHeGUrTWxkdzVOemt1NTlaaFptUEtJMUZY?=
 =?utf-8?B?Y0dRczh1Qk8vRGtxRFcxQmdsUDVkelB6SUkrcnRTVUNDK0h6OXZrU3ROYVdI?=
 =?utf-8?B?Z2hZL2JPVWsvRVp5Ry8wMi9ZZVlVTWROT2kxa0NHMU9ZYXRXeElVcWhVKy9s?=
 =?utf-8?B?U1dabzUvRWZvcjQ4OTJQcmF6cWRXd0ZrSDdibW5yRCt4SmtWZGhKcjR1amw5?=
 =?utf-8?B?SnNpS1ZKYjZYRzBBS1hwenBJRVdJd2NjaFY2RnYzUzBLMDlpNU9WNHNVNDc0?=
 =?utf-8?B?bHVseDFuRzFuR0ozQ05rZ3JTazJCSEN5dTU5TGZJdDUyQ1NNQ3QwbXVZS0Vw?=
 =?utf-8?B?SS9FbDVVTlIwRFJ6aDVRcDZpQThBdWFiMkc1UWVldWxQdEJDaGdITkNEZUw5?=
 =?utf-8?B?R29KY1FTR2Uzc3dMd295emNwcHRkMW11dlhOcEM5TmhtSW5ONjlhTS9WVjdL?=
 =?utf-8?B?UFBnbnd2b053M2NLWUlEcE5OcjNmTjRPdkN5aEZiY2dheWg2d0g1cktobTFX?=
 =?utf-8?B?SFp5aER4R2FtdDVuR29PWHVPeWVqRVNWeFc0YmFpWVU0RktlTExqOTNzREFr?=
 =?utf-8?B?V0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a0bd8874-de8f-46a6-47cb-08dcbe436d59
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 22:33:18.7511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7s3VQMWCkunARZfxZPovvkw0SkQAEA52z2Tt/8E+SQvws91xMCxdYAtDzQTLN2zC7JzIfgGGS02BPqcEZ/tIG6sQLPu/YDxT5mrumB4T0kU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7397
X-OriginatorOrg: intel.com

Hi Babu,

On 8/6/24 3:00 PM, Babu Moger wrote:
> Enable ABMC by default when supported during the boot up.
> 
> Users will not see any difference in the behavior when resctrl is
> mounted. With automatic assignment everything will work as running
> in the legacy monitor mode.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v6 : Keeping the default enablement in arch init code for now.
>       This may need some discussion.
>       Renamed resctrl_arch_configure_abmc to resctrl_arch_mbm_cntr_assign_configure.
> 
> v5: New patch to enable ABMC by default.
> ---
>   arch/x86/kernel/cpu/resctrl/core.c     |  2 ++
>   arch/x86/kernel/cpu/resctrl/internal.h |  1 +
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 17 +++++++++++++++++
>   3 files changed, 20 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 6fb0cfdb5529..a7980f84c487 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -599,6 +599,7 @@ static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
>   		d = container_of(hdr, struct rdt_mon_domain, hdr);
>   
>   		cpumask_set_cpu(cpu, &d->hdr.cpu_mask);
> +		resctrl_arch_mbm_cntr_assign_configure();
>   		return;
>   	}
>   
> @@ -620,6 +621,7 @@ static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
>   	arch_mon_domain_online(r, d);
>   
>   	resctrl_mbm_evt_config_init(hw_dom);
> +	resctrl_arch_mbm_cntr_assign_configure();
>   
>   	if (arch_domain_mbm_alloc(r->mon.num_rmid, hw_dom)) {
>   		mon_domain_free(hw_dom);
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index cc832955b787..ba3012f8f940 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -685,6 +685,7 @@ int mbm_cntr_alloc(struct rdt_resource *r);
>   void mbm_cntr_free(u32 cntr_id);
>   void resctrl_mbm_evt_config_init(struct rdt_hw_mon_domain *hw_dom);
>   unsigned int mon_event_config_index_get(u32 evtid);
> +void resctrl_arch_mbm_cntr_assign_configure(void);
>   int resctrl_arch_assign_cntr(struct rdt_mon_domain *d, enum resctrl_event_id evtid,
>   			     u32 rmid, u32 cntr_id, u32 closid, bool assign);
>   int rdtgroup_assign_cntr(struct rdtgroup *rdtgrp, enum resctrl_event_id evtid);
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 66febff2a3d3..d15fd1bde5f4 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2756,6 +2756,23 @@ void resctrl_arch_mbm_cntr_assign_disable(void)
>   	}
>   }
>   
> +void resctrl_arch_mbm_cntr_assign_configure(void)
> +{
> +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> +	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
> +	bool enable = true;
> +
> +	mutex_lock(&rdtgroup_mutex);
> +
> +	if (r->mon.mbm_cntr_assignable) {
> +		if (!hw_res->mbm_cntr_assign_enabled)
> +			hw_res->mbm_cntr_assign_enabled = true;
> +		resctrl_abmc_set_one_amd(&enable);

Earlier changelogs mentioned that counters are reset when ABMC is enabled.
How does that behave here when one CPU comes online? Consider the scenario where
a system is booted without all CPUs online. ABMC is initially enabled on all online
CPUs with this flow ... user space could start using resctrl fs and create
monitor groups that start accumulating architectural state. If the remaining
CPUs come online at this point and this snippet enables ABMC, would it reset
all counters? Should the architectural state be cleared?

Also, it still does not look right that the architecture decides the policy.
Could this enabling be moved to resctrl_online_cpu() for resctrl fs to
request architecture to enable assignable counters if it is supported?

> +	}
> +
> +	mutex_unlock(&rdtgroup_mutex);
> +}
> +
>   /*
>    * We don't allow rdtgroup directories to be created anywhere
>    * except the root directory. Thus when looking for the rdtgroup

Reinette

