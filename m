Return-Path: <linux-kernel+bounces-175240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 087008C1CE7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 05:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BCEF1C2135E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 03:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D259148FE6;
	Fri, 10 May 2024 03:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jkzhqL1j"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C469D33CD1;
	Fri, 10 May 2024 03:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715311088; cv=fail; b=MbwXEm/GFZ20DhrQKUNITmOw6tFTVq/EycWvPuc4vzYfnjZbu0GYdg4MLs1wVj50MGm55z3RlyCjzC4IjMT4wY0/wrXcFTyT5pcZHFAngt2Vol1zamR9Rve4BVMI+boKK3qNKiZY9DSkX+TmmzlyMhdHnMg3pH92XApYgYt+WCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715311088; c=relaxed/simple;
	bh=PFz9OxVxdYaH0FJcslainkusmsgWT3oDxfuIlbA+eB4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rigQWzEQi17n7eJqu5G0Zby7s/bM+HvysythN7mznJjeP9OQ/Tm5GTICvXRm55rX0+kQLWqytJqqQKgtlti4rX9dq1j45ObdS5RifeIFuqGdn8uYYuywaHPxs66SzWIrc4bCXLExCdPPlUEyI+ophuc2chR+T3foBdkUkno+AEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jkzhqL1j; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715311087; x=1746847087;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PFz9OxVxdYaH0FJcslainkusmsgWT3oDxfuIlbA+eB4=;
  b=jkzhqL1jefQRzSHxG/r+Du3j1TUn8JXCUEB67oV9CZ9NfVuS0TnJFdgI
   aFEyow7khCEGpSRcOLA4daunGDL4CrMO6vt7M2CrvfMhUaExaTJFS1A4k
   ZDAtFY82Occk9shYh0Y4Gb2vCyUqhqcehrgPcD/o4wbkICBXmxF4tP+aa
   3zxuOxuXUXHDMSeyqGIsAt231S6GzChwrXjtOFx6bJtparPHWYTGM5wns
   oROrfRnUUDYS9OoR95L6Yr1HWZiGV/rMORiQBbWrPDohrjneaSGQF/HFu
   tX7UUBW8tx19ysN+Kl1AaUoXiTg79blY+RnFtkQl/pfIDTNmp0B1aLQGE
   Q==;
X-CSE-ConnectionGUID: G4sd217RTiGfkmZcxrKZfg==
X-CSE-MsgGUID: UCKar3onSr6KHcXutb76rw==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="11402026"
X-IronPort-AV: E=Sophos;i="6.08,149,1712646000"; 
   d="scan'208";a="11402026"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 20:18:07 -0700
X-CSE-ConnectionGUID: +U0doEKJQD+xQFd0VBLS0g==
X-CSE-MsgGUID: s3rowKUWT6q5zYTuB2WXXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,149,1712646000"; 
   d="scan'208";a="34123030"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 May 2024 20:18:07 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 9 May 2024 20:18:05 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 9 May 2024 20:18:05 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 9 May 2024 20:18:05 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 9 May 2024 20:18:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mQzJTuMfs1GXwH6QPe2ngaGB+JNQx4B//sUPg5JnTB/B9VKndBDPda/9kwrZwJ6U6jriyE8630VYKzD5cPjtVgVsg1CsrV3TxQgFoXXTcs2keNkvGXCtVKZw0Za7qNaG/PR12dwBjGpN9SisJ1+0sCMM8UImy5r7abmnVRwMjGCFebZavKL2a3KLXD24eJ4jhVpOMX3hvGJIBWET5xr65WC4/qMVBWKfTIzxmiEfA28mG7dBC3O/1SCQ16bUgzfhy8HDGe62CAHeO0C3mvtJ7tNf/NmO54HJ9Mr6dFnh2Gmwqp1AQ8hjhmKAdaI4WXDMV+K06JQU9WYyZaG2rAVZTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e1MKvT0RPpKwRrykzUQImmmXZ7WAKnHIVNnknQumuR8=;
 b=Hzl517h6LcjnA9BSF3sTeYjCUsASGkh7h9jvregNTAIomaeAD5haEpd13ymuabYpypQ11yrFw4U5A8wLtyD/aqocjZ+cXCSj1eMYS2PEc9D86LiuteiHnQD5roTUO2TiMjUJxraKIebBe/17fkW7kytP/COv362xnWuCWhDS7VGUVWZeyHdt9gP7QtpDVGenVpyyj4Ub2QqjShY7M5+UgKD/TdQC8y57NSJxSBuyQjc2EpPhFw+ZNpS2iF7zLSGHTDKGSGCGnGOwINPH4whl0SXfKnjTzIVsL4QzJXikrOwMAUeg4vxA/aI/dTRmJTch7b3Zu2dD2jH0D/JXmdLcgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MN2PR11MB4663.namprd11.prod.outlook.com (2603:10b6:208:26f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Fri, 10 May
 2024 03:18:03 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519%4]) with mapi id 15.20.7544.046; Fri, 10 May 2024
 03:18:03 +0000
Message-ID: <50d006e0-8488-4579-ab4e-701e1a8f410a@intel.com>
Date: Thu, 9 May 2024 20:18:00 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 03/17] x86/resctrl: Detect Assignable Bandwidth
 Monitoring feature details
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
References: <cover.1711674410.git.babu.moger@amd.com>
 <63134ddf18208bbd11bcec0ec75c33ef6e5635b2.1711674410.git.babu.moger@amd.com>
 <ac22b96d-c4bb-42d9-bac8-22b9e032b59e@intel.com>
 <80b33bc6-7b70-4853-92a0-718c2d8728d3@amd.com>
 <753844b6-b68d-4b05-89b0-3ac36e1c8564@intel.com>
 <be20ffe1-ef8c-41fa-b359-9ebfaa326ebc@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <be20ffe1-ef8c-41fa-b359-9ebfaa326ebc@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0130.namprd04.prod.outlook.com
 (2603:10b6:303:84::15) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MN2PR11MB4663:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a06c4dd-48a8-4918-4b97-08dc709fcd77
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|7416005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ME5pby9qUU9uNXFzdzlIV2lLQVUyQ2dOTXV0Z2hnU3ZCTmdjTkw2S3Q0NUVZ?=
 =?utf-8?B?Nk9haTdsblYzZzlTWVNPTC9yTXl5azZ6YThUNnJaOWl0YlZZOUhuMmQwQ3F1?=
 =?utf-8?B?RzF2d1ltdVovejZ2WmprM0dOVUFJN0pSM3ZMQ0ZCbGZZUHJVNFFpVklvMXVT?=
 =?utf-8?B?SG1iUjBjbllNcGZpMFZNMXhOeTJ3MThIYm1tOGN0K3c1SmcvNkJXQVFFMEd6?=
 =?utf-8?B?RWE1WTlDUzdjR1R6eExySktKNmZNc09WU2pPWk94bVdTZ0RFUjVUd3A3NTcv?=
 =?utf-8?B?NkZNb3JIakZVdzRsdFdaa0Z5WTlvYTJaNmhPN0ROLzVhOGd1N0lpWnhrcVM0?=
 =?utf-8?B?YXFSUlVTSm1BT2hVVE5nM2JqRVNnbHBNejVHRjAyM3JEcmtYanN0YU1iSVVF?=
 =?utf-8?B?YjliT2VydW5QMkVuR0hLKytSWlR0aXc4SENobEtUZTFxSHJYT1N1UWFuNjZU?=
 =?utf-8?B?aTFTS0QwWjYwWmx3THVCNlRRVXpOcTRoVFhuZ1RzbFp0TUlqMjZma2tiaFZr?=
 =?utf-8?B?Yy9JTkpxY281Rm52ekhnTTJyRWZCeXlCYkk5RWl3VmRINHR5bXIwb0xJRWIx?=
 =?utf-8?B?S05veW5RNkdReE0xTmVXZU1qZHhha0hrdDBkUUx3eTQwaVBNYnpVaDRSdGM3?=
 =?utf-8?B?WlIzZERQQkJzS01MbkYyWktoTkZaZzJGeG4rV2Y0YVBUTFQxK1drRGF2V0tH?=
 =?utf-8?B?WjIvemJHdS9rZCtQWUFNKzJhUllMZXliVDZDMUdHNzExRzhKRm5jUGVvVkdj?=
 =?utf-8?B?ZVF6MkZEcnVrN0d1Z01XM0JUWENGemgyTk0ybTVCV1Y2VStBYzJKdElCT040?=
 =?utf-8?B?NWxJRXAvZUU3MURBQVM2ZDZvelZOVjFseXdUQnAvT0g3b21qN3Q1TDdoRWV2?=
 =?utf-8?B?ekpaMjBqWnEyc1JHZ2RQL2FxWEdXRjJValkrQUY0a2lHWndSRUFtZGFPLzNv?=
 =?utf-8?B?K2VmUEc3VmNGeUtGSHBpVi9qS0l1aG83Mi9pMkg3T0ZXcnVTMlh3ajc3UDdv?=
 =?utf-8?B?b2NqMUo1NS9wT2R4WS9WSEpGQ0JSWG42QlpONmNreUNJU1VQcG9ZZlY0ZjJN?=
 =?utf-8?B?RnE4eXBOYllvYjhhYWZBMUs3WlpMVzFKS3RnaFpxM1NiQTdDTVE1WXRwNXdZ?=
 =?utf-8?B?THQyNDY1VmdSR2NEZFB6N1hVY1Z0NGEzK3dQN21xSXdpS2ZoMG5WZHVTMVlF?=
 =?utf-8?B?amI5ZDJ1SkFjZ2lBcFhhZGtLL1NPUVhhdEFmZzc1U21HcVQvL3RwS1ZLbEpB?=
 =?utf-8?B?MmhzRDJpY3dZYUgySWtZWnVUSnVnWUZtTEcrdStNcWFjdFhiM3lNZjVPNDBq?=
 =?utf-8?B?eitYSlhJMTdIam9xWDFUYVZBNzhRQTFtZ053WkdUWkRpdjZaQXJsbTBMTGdm?=
 =?utf-8?B?Z0NOeVdadXMvV1M5RVFncEdEL29CZC9PQldjR3BpT0hmSTZBVC9DV3RqMGw4?=
 =?utf-8?B?M2VFTGZDMmN6V2llN2xaelVYMHZpd3pYUFJQamxML1A1Yk5FcE9SWlpUc1NT?=
 =?utf-8?B?OTBQT0ZIeDBjNUM0V2c5Z0IweVpNd3pxN2xuWDh3bVB6dENJeGVZUEJzb1Fz?=
 =?utf-8?B?Rk5pRE9aODVZMzM2K3NYVXZDemlBNHkzVHZyVGdTaXZyOThXaHhGV25ZeUQ1?=
 =?utf-8?B?aHo4Z2I4RkM3L0dKOVowNXE2UEVXODB3RW9Qck0rMDBaSnI5NGVnSEJ2bHgw?=
 =?utf-8?B?Y1RQR1ordHZ5bTdMb3dsR2FYRXpDbVk2RWFWSDlTVlpmbm95VTQ2dVlRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUZyamRpZ29seU10UnkzUG1oMGRucnRNNFE3cmJqU1cybm1KYmFyTDZCeFpx?=
 =?utf-8?B?OExMSGlBVU51S0crVFBEVVVuaGpZSnEyWUhWbXlMMmxuaWZDRVQ5MnVLVVZN?=
 =?utf-8?B?S3d0VFRFdjZSSWYxeEFSaFpzTE42UzgwdDBtUWJrWmVXekcxMHVGL21jV0dW?=
 =?utf-8?B?ZVpCYytTaFJtNGN1YUhZNGlKUkswV01KRCtWVW9RUGpzUDY3OFNJMWhaV3I1?=
 =?utf-8?B?aGhlcFRacUt5ckdFTGFHazFqclJEcjd6d01TbHR3d3dWNnE5K0Y1QUFDbFZm?=
 =?utf-8?B?NWQ1SGdkZ3JpR28vMWdmS2o5K3l0QUFGOWlZSEJ2YllCSkIrcHY0R2Z0TE1k?=
 =?utf-8?B?SU5KVmlIVjlEakt0REdnYXBzK3BHVGtkRUlDSXNrVG94czZUSmkySHdWUGNx?=
 =?utf-8?B?dzhYSWg1emIwNFRCTHVpREdVQnNnL0svZGt0QndJRTFad2l4Ri84UkcyMHh3?=
 =?utf-8?B?bldpY0g1TzNjeEtXSEhLMGpHN01sVzFXejRBZmNBWGw5QVYwWXhieVoraXdo?=
 =?utf-8?B?OUhBSXNZS1Y0RzJJSzhEbGwyNVEzbHhHdUNoY2dvV3BJZXZvZWRMWVgySHha?=
 =?utf-8?B?NFBKcmN3bUZORGhtMGxCZnYxa29XMTlxRUlXZmRVNE0vRFZRZVBtNGNvcTdp?=
 =?utf-8?B?cnlTdG9MSW5QTkE2VExqbnBTenN3NStwRXc1Y2VJczlaVFNBVjBJSGFYRXJq?=
 =?utf-8?B?V0YrNC9IWDR2dGhEblRNZm1RMUMxZlJyVm1WNHI5R0RHZ24vL3ZtRE45a2NE?=
 =?utf-8?B?MU5oVXpCNUpmdmVHcVBTY1RJbEtLa29EUGpueFY1TEg2amFYTitXQ3dydENL?=
 =?utf-8?B?T0hiTndMZC9mYndUYUNQR3BhOFRVaEdYd1RIeHkzMFBnN1VQQzNuMVJPRUFj?=
 =?utf-8?B?ejUzR3hLTmFaRGpCb0NFZ2h0ZWpwSXBqTENVWjJrY2hhSnZydFdUdWZZdjVV?=
 =?utf-8?B?cXZiUXpuZUpSYzhtODRYV1pIbDNVYkE0L3hiUllQT2VRa0Vwb0NCSlUxMHpv?=
 =?utf-8?B?U0hmWlE2eStNRkFiMEM4bysraUxHVDFaZjZ6T3l5MHJRSlZQNmtMWEZGVVM5?=
 =?utf-8?B?SFVySlJFc0dsaXgwWW02KzFnT3ZWL081Wmtxa2pveHphcTY2NDFUMDJIL3RV?=
 =?utf-8?B?U05TUUNDWGIxUkhYZWtUYit1b2FjSjBycFNTamR2YU9rTU8yZk5mRmFQelJS?=
 =?utf-8?B?VnJFSFpST2NpdFFEU1JFRXJMQ09iQU1GcjBvS3B0RFBpUFlJN1FGT0p6WHhm?=
 =?utf-8?B?ZXJ5cHZwbTlCSDRMMncvYyt4OGx5UVd5blY2RzVTam8yeG9sQW5UeG5lVDNT?=
 =?utf-8?B?OXRxQXluN2VnNnp5ZEZlNzlpdThqc3VCbExydHZ4RUliSGhXM2c3Z1lSL2dH?=
 =?utf-8?B?L1ZpZGVIR2ZQSzRPMkZKajQ4c21palZjdnVzaXZlSHVwdEFFVmVFVTZvT3Ix?=
 =?utf-8?B?bzZsMDVxWlRzZVlDRU5jNHdYNkJvQzZvS0VZenEvR044TUljQjJFUld0K3E0?=
 =?utf-8?B?VjdnNGJvVWFJbUd5c0tQekwyV0grR3NGZmVJcFEraERROEV2MUdNaTBTYVdH?=
 =?utf-8?B?WHREOWZHQUg5RDFYZW1DRFVYczg4aXRtTWo4b1lIQ3BIVzZJU2lxc0NRNitL?=
 =?utf-8?B?dDJzUXdKK2hOK3dpZWtreWphalZ0N3V5ZXM5LzhGL0NvTldTMW9yR1JTZHdB?=
 =?utf-8?B?aXFabnl5NFJSK20waUFFUFYxV1NnaWQya0szalNTZzI5a2owbUFvVy9NUnFT?=
 =?utf-8?B?UlAyT21ERFRRbm5Dcjk3NVhTZE90NmFyaFY2aXY0cXM0UWNDaStJblBHdU1i?=
 =?utf-8?B?ZDluMEZSQUYzVU0xbkFyVGRDelN3aVdDTkhJcTYyYXZNYk1mbTgzUjFwVkxN?=
 =?utf-8?B?MUNFbDRPbEpYRTVlZGQ0YXdCRFFPOWdZcHo5SG1aVDNxcjdXMk9EMVdwRjlq?=
 =?utf-8?B?YmJoN3ptT011OU9Gb2U1UFZnZlR1T2g1dVJqK2FNTXMvNTJDdEFSTVZNQUd4?=
 =?utf-8?B?aU1XemltL3dLYzhtVmg5ZVFocjNuSE53M1UxY1VGUk5xS1lSRE1YREZUUzRw?=
 =?utf-8?B?TnlHdEhJcnNBNU1RdllTbDNKMkxzODhYSWlMTExkWnQ0Y1BrdDZTUHVKclVL?=
 =?utf-8?B?bFl1UFB4NmdaRGtCOC9nVm9lZk1sWU9uRmtrVXRhRWd4cTNqWFFCS0hqcnFM?=
 =?utf-8?B?SHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a06c4dd-48a8-4918-4b97-08dc709fcd77
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 03:18:03.0387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x31T/elYjMgcGe4Y6D1fRRktfCQpaPMiSiyBSc4PEWrJh0bHjEmVHny4wGoOh60Ca8GzDkxyfPzTEfmAGRqVKjNZNJm/Oj8EJF/l8TcTZmk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4663
X-OriginatorOrg: intel.com

Hi Babu,

On 5/9/2024 3:34 PM, Moger, Babu wrote:
> Hi Reinette,
> 
> On 5/7/24 15:27, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 5/6/2024 12:09 PM, Moger, Babu wrote:
>>> On 5/3/24 18:26, Reinette Chatre wrote:
>>>> On 3/28/2024 6:06 PM, Babu Moger wrote:
>>
>> ...
>>
>>>>> + * @mbm_assign_cntrs:	Maximum number of assignable counters
>>>>>   */
>>>>>  struct rdt_resource {
>>>>>  	int			rid;
>>>>> @@ -188,6 +198,8 @@ struct rdt_resource {
>>>>>  	struct list_head	evt_list;
>>>>>  	unsigned long		fflags;
>>>>>  	bool			cdp_capable;
>>>>> +	bool			mbm_assign_capable;
>>>>> +	u32                     mbm_assign_cntrs;
>>>>>  };
>>>>
>>>> Please check tabs vs spaces (in this whole series please).
>>>
>>> Sure. Will do.
>>>
>>>>
>>>> I'm thinking that a new "MBM specific" struct within
>>>> struct rdt_resource will be helpful to clearly separate the MBM related
>>>> data. This will be similar to struct resctrl_cache for 
>>>> cache allocation and struct resctrl_membw for memory bandwidth
>>>> allocation.
>>>
>>> Did you mean to move all the fields for monitoring to move to new struct?
>>>
>>> Struct resctrl_mbm {
>>>           int                     num_rmid;
>>>           bool                    mbm_assign_capable;
>>>           u32                     mbm_assign_cntrs;
>>> }:
>>>
>>
>> Indeed, so not actually MBM specific but monitoring specific as you state (with
>> appropriate naming?). This is purely to help organize data within struct rdt_resource
>> and (similar to struct resctrl_cache and struct resctrl_membw) not a new
>> structure expected to be passed around. I think evt_list can also be a member.
> 
> How about this?
> 
> Lets keep assign_capable in main structure(like we have mon_capable) and
> move rest of them into new structure.
> 
> Struct resctrl_mon {
>            int                     num_rmid;
> 	   struct list_head        evt_list;
>            u32                     num_assign_cntrs;
> }:

This looks like a good start. It certainly supports ABMC. I do not yet
have a clear understanding about how this will support MPAM and soft-RMID/ABMC
since the current implementation has an implicit scope of one counter per event per
monitor group. It thus seem reasonable to have a new generic name of "cntrs".

Reinette

