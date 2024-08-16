Return-Path: <linux-kernel+bounces-290337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 886FF955268
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 23:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99E80B2396F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 21:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5294315D;
	Fri, 16 Aug 2024 21:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DAO8ETp7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E7077F10;
	Fri, 16 Aug 2024 21:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723843836; cv=fail; b=Sj5pOQwx5lielxr199fl/KIvDFiX9Y1SscQ/fEQnxVnEtI3pzwFBcMq7HNcCY1HYJIv3rWyD268uhYwyb+Q+5Mykz+u37WR5QmfB6QplwHRFBDRTF0ovziOWJP+f6oV1HJXMKJ+dMjg6YKkKtDf4A2GNCFZb+0W93gZfSayO610=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723843836; c=relaxed/simple;
	bh=NzGLNGfTvrEU50tAvWphQEP0cLg2lpA8DUxqN3vae18=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Qe7ESLkZnQO2yOPlXUBWJxnl2DbufvRVO88y/bmyu40TtWAqJjB18WstsSKf6qfAq0blhz6dWhb0yH60PF+X87cSIr7SLEVRfFXn9Vb5UCsiQXnz10sR1FAaO2daN8UfrijoNWbmUD4EHU///L7501ZcLKGSDzvNtstSgHCq3hI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DAO8ETp7; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723843835; x=1755379835;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NzGLNGfTvrEU50tAvWphQEP0cLg2lpA8DUxqN3vae18=;
  b=DAO8ETp7fIfoexRhyc/epMZ3S+h/dvtIO+X8KXuCAWNYOc1KDJBG5OgJ
   EtIytTRxRN+9ofh2XlWar3HuSo8uayDpt1juQhhVFSf/u9RAZDrsXslI8
   M/q3fP3hAcGGotLfLeydMvfuyHP/sSpIe0vSFShePhMCDr3CoWpVdj6OE
   mC0qIBrmEP1p72SaiUdHmLy/DefpA/gp+jbi0gdnNcFVxMguLxddCyFFU
   jslDg2z3xMNnLRH26SxOrhoduAwU0hiUpQnfKTr46bYvsdOJ/hVJ5fhYM
   OoE3PXU5lCVOTL1M8ySEFAVBR7eqgpQ5FQQQDXzYutTC37DJbs8FkNDZ7
   g==;
X-CSE-ConnectionGUID: TWmL0LJ7Tp+LbolaiJwzEQ==
X-CSE-MsgGUID: ioSkfVIiQ9OWSoLCSOqYKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="26020812"
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="26020812"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 14:30:34 -0700
X-CSE-ConnectionGUID: EOd1pVNbRouqxfx8CXy+Tg==
X-CSE-MsgGUID: Wb3PTU/0RGOlFSOykUa2GA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="64454443"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Aug 2024 14:30:33 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 16 Aug 2024 14:30:33 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 16 Aug 2024 14:30:32 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 16 Aug 2024 14:30:32 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 16 Aug 2024 14:30:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QC7M7aio3idxdRJ3eQjvw9SPkMqxsb9JcdGWITfeYPpf6SmLc2Ld8417Ib6PRQWTvQ8e2V4zBWPrxFkMN/o2JEgMdtehmE4Aae/5+Q1mXTR6ZADuyP494CtzoCvINd5z+4s2HCzg3AcKuxqmIKkDMA2aYQCnuMoVXhhWU5fqew2GHoWUtiHX8lWk4NfyjS3VyRJDkP6FINhQo05mprwvNcNTvDKCN04MfnXdakI96tai5As4+qUxFLY14sCEByNklEnRaGC/5EiZWXLFqu72115gS4otd7KWyiI/1/5iuRDZMTA4MNFn1eEJeT9Ssi3NYcolhXB+V12NYWUBgvdiUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DXa4TeRxJ8hew2/Sik3UhsIgbwWvhEEILMGUwmb22+g=;
 b=kGilaAErgnzpiYibMLD0HEB5MX9UBYHVzgb1VDnSX0DjFSAaGurpDbipe/YFGCWSaZX4F2kKX5/1Fbk2/wCSG0hCWRmB0L/3hq6Ay5VNZebKo5KNxwUCSNddQhV2l/ZWQ+6q7HaE8YuYb4cqxTCQfxXtwyN3zj7vg+1D/ngAwWcRERTDIzOjE8m7ThWmXFZEVOzT6d8W5uplUoHPZfJVnxA6BnNupx9p+C1R213TIuQjTJJo+1dZc5ARug7j/pUb04m+y+nR00RN27NZs/UlkH7VLKD+OvZxNRIAgq6dAUA1aAGxoc25izjQ6dPEPNpsszM2XcM2DUNKQdrCB4WJAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB7802.namprd11.prod.outlook.com (2603:10b6:8:de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 21:30:24 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 21:30:24 +0000
Message-ID: <daa0fdd5-bc86-45a5-a684-a88816f3cfe1@intel.com>
Date: Fri, 16 Aug 2024 14:30:20 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 04/22] x86/resctrl: Detect Assignable Bandwidth
 Monitoring feature details
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
 <851bfbee0fd53631acae8d209796d52ce8051e68.1722981659.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <851bfbee0fd53631acae8d209796d52ce8051e68.1722981659.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0009.namprd02.prod.outlook.com
 (2603:10b6:303:16d::20) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB7802:EE_
X-MS-Office365-Filtering-Correlation-Id: 75fb2588-72ac-415a-f86a-08dcbe3aa383
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dlVnSnlBTEZNUnZOd3FZWFBEczA0N3ErVkNXY0YyalhKdU8vejhTUFd5TUNq?=
 =?utf-8?B?bHhUc2piSmJ4TVBhbXBXeTF6UlNpbENxTnlVc1NKcGhTYjZOb0FVY3pGekZx?=
 =?utf-8?B?TlZtNURwRVUveDFnRFR3Z2diWXFvWjIvenEzVGJFbGN4cnRnSXF0U29IeUdE?=
 =?utf-8?B?RWJvMzdJVHpmMWtQSGRRcXhaL2UzVmJWekJ4T3h2bnhGdHRCei9mVTYrUVdz?=
 =?utf-8?B?OVNUS0Vmb0E3c0orQ1dad0E2VGhSL1ZMWVN3eEtiMmt4MWRiRmJLd2Q1Z1pZ?=
 =?utf-8?B?V3pUbW1xSWRCVjhRT25CVXBBNStwRUJ3anlKc1lNcjNPWVo1M1BsaWhRR1VL?=
 =?utf-8?B?VndSODBoUTE1RVJBaXcyc3pZaS9qTGx3MUZvN2NtZTN0ZDFNWmhXUHg4ZG9V?=
 =?utf-8?B?T2ZIQThXYWxkNUlzblhqQ28vQWxESlI0d1NUVkhDdnFwZ1ZoNkpITnR5UDlJ?=
 =?utf-8?B?ZXNnOGV0elpmOUFYYXZDOSs1cERrZW0rVjJ2T3JheG5memhCQ1V0NWw0blRM?=
 =?utf-8?B?aFN4OXJaNGcyQzEzRDlNVU1CVkF6UmhLS0hkVVJLbzB5UG1ISEpDdTFNRm56?=
 =?utf-8?B?TWwza1lwU2pLNDgzc1BXaTlYK2RTbmZqOFc5RnRLZkxkNndPck9IeUZXcm1a?=
 =?utf-8?B?S2dmVmVSWlBqbkVXNTRXU09VbTVDRjNKNEFYVS84cndlKzBqbzdieWNwckx3?=
 =?utf-8?B?N3QyOThLYWhESjJOVk5oWTBIWDNtbXN0SUpoczVLcVFXZUVvSEp2YUtWUHc3?=
 =?utf-8?B?T2lReE51dTBpd3pEVllMN1BHR0ExWGxsNDEzRThjYU5nVG1GUzBxVEwxWW94?=
 =?utf-8?B?S0d6ODhmeHpWMFV1Nnp0UWVYRVlFR0dkL2dHUnBEcGhqdWkvcjFuTE1OZElE?=
 =?utf-8?B?eGhFTXBrV2NYaXJjM3R5K2Npc3dyRnJSMndhMWtBbFdBYkJJZTRadXg4eTlD?=
 =?utf-8?B?YnJUejNISXIvUnR1bHU1d2QycGhKWnVxM2lCZUhwN0xLUzdrQmZDUkdoM2hS?=
 =?utf-8?B?NjBQTmo4M1VPV0FKTXhQK3J6eU1wN0xGL2dtd1pnMW9tU3RBY1VPdURmbFB5?=
 =?utf-8?B?T2ViNlNEQUg0Z1FTRXZySUlhQitjeThpZ0pJZlZhUDQ4eHA5aE55ZUtrWUZP?=
 =?utf-8?B?SGhCdWY3ZWlrbUhLN21MVFg3a2oyZmZxTEtsNVF6Rk1MajRSRnFQSGxxdEpK?=
 =?utf-8?B?TTVtMEQ5Z1lWUnc3Q3ZqSTdVamx6bG1xZklERlVMSi8zNm5qQ2x3SUVSWWYz?=
 =?utf-8?B?WUhsZjFWWkQxT04xSDhuWHdtTWNoMWE2WEpvVllWWTR1OHBaY3ZOWEtVRkd3?=
 =?utf-8?B?MU4zNmhZNTZoMjJWanJ1b04yRnRqeTZyVUpLcWlBZXQ5cmRmNHRnVlRaMnI4?=
 =?utf-8?B?Nk5Eb1ExYTUxR3RZblVPT3dqbHhJT2FFRm5PckFzdUtvc0JZOGx6YkZadll4?=
 =?utf-8?B?SHdFay9qN2FLaTRHYkQ1Y0J2Wk16RlRmSjdjR3RPR2VvRERaMTdiZTlyYitO?=
 =?utf-8?B?T2kvRDl2aWpUUE9TMHdLMGlpSHdPZU5WcHFIQnJodGYwNm9PQm5CYVNoczZm?=
 =?utf-8?B?U2ErWW5mcVBydkl2UEZYVStwSVoxaUFxbW8zTUl3VmpMMTduSWlUbVlUZzU0?=
 =?utf-8?B?RDdFenpadmJ5SVU4SEgrcGRoWFVMK2IvcDBVZlFNR0t2a1lVWnRjdmF1bkla?=
 =?utf-8?B?Qlg3dmdMb2c0Y3ltRk00aU40ekRINWZzd1VJRy80eGlkbHNlWTJIdTBVVHJk?=
 =?utf-8?B?WnZ4NEpIQk5mRHVkUnZHblJscE5pdWRGVENrejdrUjJOMUdjdUVNMkFQTkVj?=
 =?utf-8?Q?kGSKAt2MWoDwia7yI1JKo3uBMRIgCujXMvFSw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnZWQ05KN3oybHVnUVVzMzBGUTl3dm1wdjJRa2xHeHZ5bXdWNWsxL0FIV0Vq?=
 =?utf-8?B?R01DT0crMVBINjFRSjN6V0xodUhzQ3RKYk5Mem1GSStXR0FTS2R6TWt0YW5I?=
 =?utf-8?B?ZFpSYWFuWTRvNUdYM3lzWnRGOEVZRHEwY1dUbXFpUVZhdk9aWUxlaTdMS29a?=
 =?utf-8?B?NGl1VzFETHpheFJmVDBaYStET3l5aTVnUm4rRDlXeVFUY0NKdW1hZ3B1ZkJZ?=
 =?utf-8?B?MTlUQVFtL1NzUjE5WW1yVHVMN0tQZFZYVE91c2ZUTjBHWnlib21ER0w4OGNZ?=
 =?utf-8?B?enhJamw0cGFZSHpabE5kNzA1N2NuZlNVWWFDMWtkdmI4bEdnNCtKWlViMDRs?=
 =?utf-8?B?L1NoN1kzczJNQU5ibGxXalMrK3JQdG01M2UvSFc2SCtIaTRVN2xBaEJXQW15?=
 =?utf-8?B?d2N4VzkxaVE0c1JlaFpQYVIzM2QveHRnK3lCcE41L0dXVUJBMXVQYlRhcHow?=
 =?utf-8?B?Skl3ajBoNXlGNzVvcW45ZkhOMmZkSGpCaFJxZTZpd0VHcDBXazlDaFhzVXZQ?=
 =?utf-8?B?M0Y3UmtaMG8wc3FZL3o4MlVFK1RQWGtBS3ZxMit2Vi9IaTFkSkg4Q2QyY2FL?=
 =?utf-8?B?dDJneHkvT05XeHNoNnBpRjZNNlIvNlVlZHlxcER2V3dzRDN1dldTUlQyTDRp?=
 =?utf-8?B?czU3ZENDaVkxQjV0K08rOVFtUThxMXBsOXdMZHA4QU1oVTJ3S3N5RzZxV2lQ?=
 =?utf-8?B?cHA5MkQxUGhFazRLOGxINVgzQ1UwYThzd0RXZnB5UkVPRjJSVGJDdWNMUkU3?=
 =?utf-8?B?L0lZS0hNay9CQ05XK1kzUzZ4djRKd2hFYUV4VWwyWmRaczZMNGZYZ0R0R2Fj?=
 =?utf-8?B?YzF5VWVWMHhTRWJveVFIcklxTmdPd1cxZ2FnY1NxN1pBaFBwK3VOdTMwMUNG?=
 =?utf-8?B?MGxvRFBJVXZqODEwa00xN044MzVPcEVsZ2ZFbGRXMmlxekMxalpFcjBjWk8z?=
 =?utf-8?B?bWxOYlpDb2dVWHVIajZKYTh3aUtOQklMYjZDdmYyR3VoYUIvNVlueDFtbnA3?=
 =?utf-8?B?eDVSZ2lQaVoxNzcwbzZMSjhQZDg3SHVaV003UFZGR1dIcEltM2p0aCtzbHBr?=
 =?utf-8?B?eCtzaVFLbmM4RHY3YklVWXVwWDZ0eDJkbGdqUnZoNkpNck0zR3V4Mmp2UWF5?=
 =?utf-8?B?S05Cb1ZaWWhKRUlVT1g5bHpaZmZEd3FtYy9VZnBVTXp0NE5jT3RHZTFoYWVG?=
 =?utf-8?B?dktnWFFHOStOdEFXaDhmbHFUTWZIemorUnRzdHRsamg5bnBBZFJRVEFqUWM5?=
 =?utf-8?B?NFBOTWdHYW9aMXlEM1JOTWIzNGVSb1NWVG1SaTRFM0VKTFRCaXdjRUk5LzUy?=
 =?utf-8?B?a3RxY3N2WWlrN3V3WGVpd2tQM0V3cTJoaG1wOTM0MHZkVlhSWnNxUmFiaGQz?=
 =?utf-8?B?SG9HTjltSVQwZUJqeG1uTmowTGhETElGTjFjQVAxT2N2OHBBbTBVUEhhcmo5?=
 =?utf-8?B?aW9PWjZrVlowV1VFS1Aya05yYUdiRlorTmFXaUkybWlxTXVGNERFRXNWbkJJ?=
 =?utf-8?B?dlBvQ1VUWXhrWmxlRnBrUFV5YTJ4eEF3cEduZm9Tc2tqT2NxTEN4V3FVeTM2?=
 =?utf-8?B?SFRrNjVtNmVPU2RuZjViTXBOMzZOSE1Tc29BYldCNUJERXZNMUF1Mjhac0NI?=
 =?utf-8?B?emN3bHFsRUtlRHM5Y1FMOENvRjZKNEFCR0s0NmlZNWlhRU5sRVlpQmEyc1Bj?=
 =?utf-8?B?dnR0ZnA4cmRxRVZEQ0RDS0oyemJQOUNiWmwzcE5LY0ZYVlVEcG5STEhrV3hh?=
 =?utf-8?B?R3JNL2s5cVpXakovSTFqV3NkeG9scjV4WE9LL2pFSGpNRGsydldodFFVcDZJ?=
 =?utf-8?B?ZkV6QXlJbnRuaU52L3g4ZG8zNE1xZWJZY1BwUDJ4V0FraGZ0WG9GZHp4TE5q?=
 =?utf-8?B?bVd5WXE2RkJMalB2dW5razh1OFltZ1BFNzJKTVFlUnZWNEJIUzhrd1ROSTlY?=
 =?utf-8?B?clB2SjUrUThyREs3QjdDZXRSODVSZEpxMjlnREVpdlFCVlFvOTF0Und4WFFQ?=
 =?utf-8?B?VWY1Rk5vSkd5T1JvUU9sVGhHZ1hFcFl5RTZHZG05dU9ZQTNWUG5lTExPNGs0?=
 =?utf-8?B?TkJ3cStnZE1oemFTclhpWkV3NklNVkxkekVPa2x0QnRNdUZYOXpUVXZTZ1N0?=
 =?utf-8?B?bEkxNXlkZW9MV0cvYTRya21TcG9HRzZXcmNwazNWeDlGTVFoVGtxRFIzQW1s?=
 =?utf-8?B?UVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 75fb2588-72ac-415a-f86a-08dcbe3aa383
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 21:30:24.1481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BGW5UQ9FMZLzP6/QUQJVEK0JzM+SU/LxQBhI6hLslpn/iyKH1GSOi7VYrRfQNzAl0GMf4iw5GV1ytrWIDhdGh02LujevyQPPJvhO8W2Wze0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7802
X-OriginatorOrg: intel.com

Hi Babu,

On 8/6/24 3:00 PM, Babu Moger wrote:
> ABMC feature details are reported via CPUID Fn8000_0020_EBX_x5.
> Bits Description
> 15:0 MAX_ABMC Maximum Supported Assignable Bandwidth
>       Monitoring Counter ID + 1
> 
> The feature details are documented in APM listed below [1].
> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
> Monitoring (ABMC).
> 
> Detect the feature and number of assignable counters supported.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v6: Commit message update.
>      Renamed abmc_capable to mbm_cntr_assignable.
> 
> v5: Name change num_cntrs to num_mbm_cntrs.
>      Moved abmc_capable to resctrl_mon.
> 
> v4: Removed resctrl_arch_has_abmc(). Added all the code inline. We dont
>      need to separate this as arch code.
> 
> v3: Removed changes related to mon_features.
>      Moved rdt_cpu_has to core.c and added new function resctrl_arch_has_abmc.
>      Also moved the fields mbm_assign_capable and mbm_assign_cntrs to
>      rdt_resource. (James)
> 
> v2: Changed the field name to mbm_assign_capable from abmc_capable.
> ---
>   arch/x86/kernel/cpu/resctrl/monitor.c | 12 ++++++++++++
>   include/linux/resctrl.h               |  4 ++++
>   2 files changed, 16 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 795fe91a8feb..88312b5f0069 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -1229,6 +1229,18 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
>   			mbm_local_event.configurable = true;
>   			mbm_config_rftype_init("mbm_local_bytes_config");
>   		}
> +
> +		if (rdt_cpu_has(X86_FEATURE_ABMC)) {
> +			r->mon.mbm_cntr_assignable = true;
> +			/*
> +			 * Query CPUID_Fn80000020_EBX_x05 for number of
> +			 * ABMC counters.
> +			 */

At this point this comment seems unnecessary. Not an issue, it can stay of you
prefer.

> +			cpuid_count(0x80000020, 5, &eax, &ebx, &ecx, &edx);
> +			r->mon.num_mbm_cntrs = (ebx & 0xFFFF) + 1;
> +			if (WARN_ON(r->mon.num_mbm_cntrs > 64))

Please document where this "64" limit comes from. This is potentially a problem
since the resctrl fs managed bitmap is hardcoded to be of size 64 but the arch code
sets how many counters are supported. Will comment more later on bitmap portions, but
to handle this I expect resctrl fs should at least sanity check the number of counters
before attempting to initialize its bitmap ... or better, as James suggests, make the
bitmap creation dynamic.

> +				r->mon.num_mbm_cntrs = 64;
> +		}
>   	}
>   
>   	l3_mon_evt_init(r);
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 1097559f4987..72c498deeb5e 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -185,10 +185,14 @@ enum resctrl_scope {
>   /**
>    * struct resctrl_mon - Monitoring related data
>    * @num_rmid:		Number of RMIDs available
> + * @num_mbm_cntrs:	Number of monitoring counters
> + * @mbm_cntr_assignable:Is system capable of supporting monitor assignment?
>    * @evt_list:		List of monitoring events
>    */
>   struct resctrl_mon {
>   	int			num_rmid;
> +	int			num_mbm_cntrs;
> +	bool			mbm_cntr_assignable;
>   	struct list_head	evt_list;
>   };
>   

Reinette

