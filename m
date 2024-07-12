Return-Path: <linux-kernel+bounces-251190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E75889301E9
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 00:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C685283B13
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 22:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D48A200CD;
	Fri, 12 Jul 2024 22:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ur6MYyOp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0204A4D9F4;
	Fri, 12 Jul 2024 22:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720821843; cv=fail; b=obrSXHPSzBzdggmVlmbgmlmDefelMz3Z7Z5blEhkqoWL/P8AWHx04f1wNNr7Rm6nV8VDKHJzepUkOP0hk0/kKqWWlvLfuMFimG43sVhcnxUwNgGscbQmDxibMuY293LWw91U4p+ivXePIsKhDe9LI9rvjH5WKqziI3Y4Rgoh95c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720821843; c=relaxed/simple;
	bh=UUCTG4ZSUGYSlwUCuZ4aJeZPl9wKItXqHTlXQFMipXE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aKqeKhhTWEAdHLJ/Q941jDBfVv/SICWukY3vLnJkKLKVRsfCSuh6tYLYPrFaUO1Bn/0AxLYx9rhJmc6SyZXVZGsXp9vsmixBKdNDmSs6NU3R4MbflY6vsiyZckko4Fxvb3r7TENy2lT4mm4i/UyGLAGzhOjwLyHq5MWEJgaqZgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ur6MYyOp; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720821841; x=1752357841;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UUCTG4ZSUGYSlwUCuZ4aJeZPl9wKItXqHTlXQFMipXE=;
  b=Ur6MYyOpQB05xVmAtVup9MTx84rOsVBo3lLzUf2N1GhMv1PDbohWJX75
   3JMeqp5SIhuPyRifFcSsR+8E7F1EielY9kQ9MfvDjNCduFU7OfSAuJAkl
   /WKildWxdbombPmaoOKkcGFXcGt6qMMpcKEnz/ukugvTxvQ7xqtBo3tYo
   RckkYzioop4thvKHOgDK7Aiqd88ILZ6rcVSXdrDxFH3+mIyd4n6ZBjymN
   texlw0eY56XMNeC/2ZMPIH/ziXWEUh+0t4y2lESCrEMNkb6sKbjgOJBqv
   aBkhmxpx5liT4eyjZbNkC+PsVOyg0wGfdqIdtRLxGtkaQez1WpsazL/0W
   g==;
X-CSE-ConnectionGUID: +Cd49mPMQwOd4XJUPDBsqw==
X-CSE-MsgGUID: vg19TzyeTEW5t+Vhc7XPIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11131"; a="35822816"
X-IronPort-AV: E=Sophos;i="6.09,204,1716274800"; 
   d="scan'208";a="35822816"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 15:04:00 -0700
X-CSE-ConnectionGUID: S2R5malDQI2pSZMIxPxi3g==
X-CSE-MsgGUID: CLltEbJVTw61hYc466iBsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,204,1716274800"; 
   d="scan'208";a="53403316"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Jul 2024 15:03:59 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 12 Jul 2024 15:03:58 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 12 Jul 2024 15:03:58 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 12 Jul 2024 15:03:58 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 12 Jul 2024 15:03:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n5VXSqgcadVv7QGk6lbloS+PYzNS1v1C085ewf3kHCQnnOeTODXOsCfvD5bWIox+FPM1VfGinRzgOxE9HEmMcrJV1ERUwdMf6sgBMhoYq0R7vZeoDVlIO7V98qwhSEDeBa3Nh3/S+9Mcmkx8aEqI4ft/p2bIvGdybxcORu5HK2DqbdxjwJswKpbdRjfimKo+SheffaX7a/lC1b/FA7rWOCG/QQn+qqkaDYUwpReT6737UHCIZCs5V7Z/IG56y1lWXT2ZPvp4gHh07w+OHvUv+CsJzI6u1R0cd8icboLzHW02hPFg+x5ezXPpSftnGxOjQb5xmi4LFIKrzCyfmjmpTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dBQRjrTjgYbaX/E4rZoPvlwdf1lNxxqteWTl3cEGwuQ=;
 b=MsQOpaPAGLWeTVLi3M8gpiDO7wgg3DvVc7YBJU/kcetYKODBOSTJlw5KoM2IbCe0pQ2U13JJj4pv5LIUUdxwaDhn8mQ5+KA4odre3yjTqXg28pUwlFKaMu1QXAvTKmAoX4UJSgwrLhNtd6URibTKG6wBiWjzjSxSM/0gMTDN4d4UX6XYD/NmYdxSjBCCcpAF2WIcE/qC10FZTKaLRPPZ8QTzO3gPy9tTednRKzXNTwG1JjQ9TJuyWuLeVTXrqcJyB1EQcMGxJYRgYaKwBhyv5y2pQG4NWjYvcZ+TL5pJSGX4LiB33BkbDwnNaMqADrdgjUr8cH4FVuOYBoHdKcAIUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ2PR11MB7599.namprd11.prod.outlook.com (2603:10b6:a03:4c6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Fri, 12 Jul
 2024 22:03:47 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7741.033; Fri, 12 Jul 2024
 22:03:46 +0000
Message-ID: <e04b721a-b5cb-4089-a3ad-125a6247e5b8@intel.com>
Date: Fri, 12 Jul 2024 15:03:42 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/20] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
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
References: <cover.1720043311.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <cover.1720043311.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0026.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::31) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ2PR11MB7599:EE_
X-MS-Office365-Filtering-Correlation-Id: 3be56379-ae48-4b1b-d671-08dca2be80b1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b0hidklMbjM1QXZFZ05zd2R3c1Vyc1dDbTdnTVkwekNlZjdlS3BKZzR6VnN0?=
 =?utf-8?B?U1JUYXN3elBzMkFZQm1PRVFnKy9oVUdOUExGTVNhajV4REpWWEwxclBONnVY?=
 =?utf-8?B?TXd3Tmw3ajNYNEM0eFRybTNwcG9uUFlyN1dwSUpnb1pvMHV0TnNlMmRmTVpW?=
 =?utf-8?B?WlA5QzZYVUdQMzhpdXVNYzVsY0xlMFNEbU8yNm8reG5qUXBNSDlHTkVXTHR3?=
 =?utf-8?B?UDlsVFowQzNyVU1sYzI1Nld1ZWh3YkhDY3E3QkZWSG5uSGo0SlpZeGFrZVpB?=
 =?utf-8?B?NHg1akFVcGRXZGl3YjF6Q24vQ0VhbU1Uck1kckVUZjM1cG9HT3pmQ1pwYmVM?=
 =?utf-8?B?OStNcEZnUWt1Z2xDbWN6VStEak9abWZ1OXpEUWx4VnMxLzI3VndKczVSc21P?=
 =?utf-8?B?eDJ2bGJxdzJuRU1ndGRYcTIrZ09ZaUJ6L1hTcnhiV0JIRk1qckZuT1JsNWNn?=
 =?utf-8?B?ZzMxS0dmMEdzT2FZVU0rcmcrSE9SNldtUnRHWlN2U28rYVdTY3RGcFdXcW5X?=
 =?utf-8?B?bXZUNWZJVVFQNDhxUFhwaTdBR0VBS2hvSU5uZWxRNCtnUnJUYWF5Ymh0dFlH?=
 =?utf-8?B?SHp0V25vYkZxUDkrV29ReGd4WFdreTNDUlhMc3BHYmhXRTN2aGE0MWFURFZa?=
 =?utf-8?B?WFdqek1JL2tMTUxPMHIvNUszN1RxVlFITFJUM1pCbUJ0Unlwa3JJZUNCQVpR?=
 =?utf-8?B?YzRnQ1VGNFJiZ3ZyM2s2ZmdRR2Q0R1BTMzlzT2dOdHNjQUIzdmRWUGpkNkdU?=
 =?utf-8?B?WmlndzZpNUpnQk9Dd2ZkOUo4NDVhT1RVQTBJK3RBcmdaMjBiNkViNlhPMnlw?=
 =?utf-8?B?bkRZMTJnTVZHb1cvMEo1cGM5MVZPS2R4VEdubU1CVyt0QXZPeEM5M0VmS0la?=
 =?utf-8?B?Yk9pbmc1S09yMkMxN2lYRS9ZeVNQYkt5Y2x2ZG5jVnVZS1VxUVVsaDJ1Z3ov?=
 =?utf-8?B?UmtIY3AxaUlSUEhNVkdYNThrMFQya0F3OTd1eVMvVEg3cFJVeWdmMUJmWElI?=
 =?utf-8?B?NGFGdnlkRVY5OU9QY1Q2Z0J1Q1ZNUXd4WDJSTm1vVmo4eFg0N1JCdjNneDYr?=
 =?utf-8?B?WkZDcm1tK2h2ZktELzlLczdPeDZVVCtTTVBBUFpUU1kzOVFrOVpIVlBoKzk4?=
 =?utf-8?B?WlUzdnU2QzB2ckZ5V204TUw2SlY4YmU3bS9RNy9ZRVZJbnRjTUZ6eVN5Qmdi?=
 =?utf-8?B?WTFOQXVyRGlTSE5VMFBzQ3UzMWU5L3JCanVQd015dEQwV0FaS2hUYkE0VjJy?=
 =?utf-8?B?MzFEWEZrQVdvMi9PWWpvN3VJWW9DREJ1RXJ2WUJjQ2wxWDZNWGdDaVB0cy90?=
 =?utf-8?B?bkNSY2Z4M3JzMm9mL3FRQVhJTjBTemdtT0cweHBGOUlYeFEzQkNVTzZOOHY5?=
 =?utf-8?B?WExrMkZsa25xSXI3Yngycm9CVDM0cUxLWHZEZFo2UXk5aStUaVBndU5rTDRn?=
 =?utf-8?B?R0p4ZjB1cUNreVorUUpFOHRiNGFzL1o1ME5SNUNCWnJ1aVNpRGFSMnhLQ3J4?=
 =?utf-8?B?Nk9ZOWF3S09LTUlEWlpZOGUwQndXU0Z1NDh4SWpreWx6LzQzT2JpRFVOL3BP?=
 =?utf-8?B?QWxWVGR0VzB0SHdkSFlVQUFselpDSWxhbnFPMUs5Q1JGb1BCWlg5T2RWYnJq?=
 =?utf-8?B?L05lM0lFMHVOT1NkMnl3cTBWOVFsakNKNWRzeEkrZS8xZXFtZU14SHZ5a3Fi?=
 =?utf-8?B?K1BBeGI3ZVFaRVBTTy9CRS9kU0o4OFNKZlNvVm9vVm9ldHpXT01lQWJqSWdN?=
 =?utf-8?Q?Lu+sVCKiLhlDs31TuQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZCszRXp0Vko0MjYxOGhqQzladGkxdHFJWWVRM2Z4Z0ZtVThyVHlobENFNGY4?=
 =?utf-8?B?UU5SNFRYdHkxOEZ2WHU5U2tTWVpaSUpDOXNZQWtsdFRDUDVPR29uNk5NQnUv?=
 =?utf-8?B?YUV2Qjh6aE5CWWJRaWQ0aDN4MUN6YVVXeTgrdTQxaXZ6RnFwZzBzaGJzOC9X?=
 =?utf-8?B?K1oxQ0FtKy9tMDR5NXl3RHpnVWJuU1Uwbk5lcjFOWkVPQjd2ZmkvTGlBTWVN?=
 =?utf-8?B?UDRpL2lUYXRZZThBTkRMK0hvTXNsMmV2L1pkR2x1WnRWeHcvYTRLL2ZpZGgr?=
 =?utf-8?B?TkIwMC83OU45b3ZPR1dTa0U0Qit0U1RwOUhHOUxpTzNFSXd6TWdxSVIrWjAz?=
 =?utf-8?B?dC9pejFiWFFlU1UweDBVUXYyeEhJZS9XVE9Ia1RNa1pPeTk0aWl3Q0V3Z21W?=
 =?utf-8?B?aG9ZSHBZT1JkQU9qNkY0cXVRQitVb080cTBwQkwwV2kzK05MSEpXYVRoK1A0?=
 =?utf-8?B?MXN5eUIyZ0FzRVNidDhmakxNUmtGbUZJd0txYUZYeEl0bEtNcGg0bWhxNDVR?=
 =?utf-8?B?Q1J5MHp6TkpRZGRldDY5ZkhXR1BpRjlDOFNiVHFuTFdJNk42YkMzQXBqdllO?=
 =?utf-8?B?WmNFc3laMEp1M1Yrb1Q0VE9KRCtWOERVQ056WUl1YjVmcVNxTUd5bm02SlVt?=
 =?utf-8?B?T1JIVy9EUDNsTDBaZkNyRDJURFpkektBK0dzK1d5RGdrSFV0WU5ESWpXWTBN?=
 =?utf-8?B?VEdDMXlvS3FTNythc09GV1NwVWwySmNJOXJqQzBCdmtTUWxOemprdnR3RmMw?=
 =?utf-8?B?a1BTRXd5dFZISVpwVW1WNnRzWXBmM2U0MU5wVHdFZzQ3TndzVTEycHNUSUEx?=
 =?utf-8?B?MTl2UVowbUZ4ZzF1b1IxOTBvZjJrSDVNRHlFQWF0Z1hXNHpIK0lkdjh1ZWpa?=
 =?utf-8?B?T0p0cWdGWE5LVlVORmxHYzRyT0svZUdBY2RpYWpqd09WWS9zSEVUb0t0elJu?=
 =?utf-8?B?TDBzcm5xYk9uSXlzYUN1Mit2RW9UREUvRExCdFBjV0V3dzdsTmZKTFVDMFdo?=
 =?utf-8?B?T0JkTFgvQzVIbXBmMG9SU0NVVEdoVHRVQ0xsbndyN3JGWWhZUFpoUG9XR0ha?=
 =?utf-8?B?SFpwSlB6dnZtNDNKdXVtVlJiTWlacEMyNk1FMjIzM0MyNzVScitoWTJ3cUcv?=
 =?utf-8?B?cFNIWFRuSkJXQ1lUQjhURDE4bkwyVU5PemhLWDZudkcxK1lTZ1Q1dnEySXhj?=
 =?utf-8?B?MDhubW1kZGFqcTMvR2l5YkdmM0lkeUk0NGV3Z2pkenJrQi90Q3VTTUdHOGh5?=
 =?utf-8?B?QmN3ZEd6ZW51MVFyU291MCt3ZHZSc05Ga1ByVkRKaWpCMkZZM0duanV5M0ha?=
 =?utf-8?B?dFR5S2RwNVJkSGs0WWxwMk14bjlBNEtESGxrbjVkbUxsdDRjRGJDczBOUzY4?=
 =?utf-8?B?OFIzcnZ6eTJZZHJzVkJPRFQ4OGdXSFJjalYybVlXMlV2bG0wU3ZINzFRTUJT?=
 =?utf-8?B?UFoxNXFweGNGRlk5dzhkdVZNMmEzZG0xK3A2VGpGditIVUQ3Rys2ZVlhZ3Nx?=
 =?utf-8?B?UzVMNDh4K3JmTjdYM3VPTFhTejViNlBkYlFHcDJDSE02MFAxaW5iT3JrL2tE?=
 =?utf-8?B?d0VHWUxDYVluRyt1eXdkVzF4K2FOdkpvVGhMbzMxUXdSczR1eWlRQVdNNUht?=
 =?utf-8?B?UjRQYTJOUTMvYlo0bFBEUWNrUTF5NHhHUG4zQ3dOMVhNWUJoL2hjOXBqeWtK?=
 =?utf-8?B?UWxFN01LK3FKMnFPT3doTkNCVmJ0S1VjV0RGV2Z5UjBLWm16V0RrbmNzS1hQ?=
 =?utf-8?B?cnpuYzgrNWtzUjlpbmV5ekNCNEN0NVBMbUwxdS81SHRORm4zaStJNFZzVHY3?=
 =?utf-8?B?Q0dnckROK1d5OGFkM0s2QVg1WVk0RjQyVWV4OUREek9ReXBRMDNMRS91MkE1?=
 =?utf-8?B?SHlidlc4c2JCckZxVXNyTEhHa2dyK1MzdDFkWTNuN1NNWHNxY05DZlo0TmJT?=
 =?utf-8?B?aW1nVld0ZmpuZkQwVHJqd3NDVFAvRlFDUHpvVEFJSUVMcWkybXE2QmlBY1JH?=
 =?utf-8?B?QnhDZHltUVRiZUhVTHdLcmpWWEJ5UXNxY3hXa3cvcjBzOEtqOEI3Rjl2cG9Z?=
 =?utf-8?B?eVRaTVZSMzlSRzUxbks3UTRreFRsQVVNZzlJRnZNRTVGM2tOSDZJaG9SM21Y?=
 =?utf-8?B?VHdBbGwyRm5uT0lQaUhjZTQvVlh3ME5BcXplL09NY2EzaEVYRXNqd0ZEclBY?=
 =?utf-8?B?Z3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3be56379-ae48-4b1b-d671-08dca2be80b1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 22:03:46.8078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qpdQILXc8IQdcljSik5qkAlLGCGH1HYOnGWr/j3gBfoTgScCZS1p8vtcSChnpVUSDwu3/Tr2pKi98LuNEZhhldIIm2H2a4gLVy4JW4WwJr8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7599
X-OriginatorOrg: intel.com

Hi Babu,

On 7/3/24 2:48 PM, Babu Moger wrote:
> # Linux Implementation
> 
> Linux resctrl subsystem provides the interface to count maximum of two
> memory bandwidth events per group, from a combination of available total
> and local events. Keeping the current interface, users can enable a maximum
> of 2 ABMC counters per group. User will also have the option to enable only
> one counter to the group. If the system runs out of assignable ABMC
> counters, kernel will display an error. Users need to disable an already
> enabled counter to make space for new assignments.

The implementation appears to be converging on an interface that can
be generic enough to be used by other features discussed along the way.
"Linux implementation" summary can thus add:

	Create a generic interface aimed to support user space assignment
	of scarce counters used for monitoring. First usage of interface
	is by ABMC with option to expand usage to "soft-RMID" and MPAM
	counters in future.


> # Examples
> 
> a. Check if ABMC support is available
> 	#mount -t resctrl resctrl /sys/fs/resctrl/
> 
> 	#cat /sys/fs/resctrl/info/L3_MON/mbm_mode
> 	[abmc]
> 	legacy
> 
> 	Linux kernel detected ABMC feature and it is enabled.

How about renaming "abmc" to "mbm_cntrs"? This will match the num_mbm_cntrs
info file and be the final step to make this generic so that another architecture
can more easily support assignining hardware counters without needing to call
the feature AMD's "abmc".

Expanding on this it may be possible to add a new "sw_mbm_cntrs" feature that
will be the "soft-RMID" feature while also reflecting the "mbm_cntrs" name
so that when user space enables that feature its properties can be found in
"num_mbm_cntrs".

The "abmc" kernel parameter remains but that does seem separate from this
resctrl fs feature since it is explicitly tied to X86_FEATURE_ABMC surely
making it architecture specific.

> 
> b. Check how many ABMC counters are available.
> 
> 	#cat /sys/fs/resctrl/info/L3_MON/num_cntrs
> 	32

This is now num_mbm_cntrs

> 
> c. Create few resctrl groups.
> 
> 	# mkdir /sys/fs/resctrl/mon_groups/child_default_mon_grp
> 	# mkdir /sys/fs/resctrl/non_default_ctrl_mon_grp
> 	# mkdir /sys/fs/resctrl/non_default_ctrl_mon_grp/mon_groups/child_non_default_mon_grp
> 
> 
> d. This series adds a new interface file /sys/fs/resctrl/info/L3_MON/mbm_control
>     to list and modify the group's monitoring states. File provides single place
>     to list monitoring states of all the resctrl groups. It makes it easier for
>     user space to learn about the counters are used without needing to traverse
>     all the groups thus reducing the number of filesystem calls.
> 
> 	The list follows the following format:
> 
> 	"<CTRL_MON group>/<MON group>/<domain_id>=<flags>"
> 
> 	Format for specific type of groups:
> 
> 	* Default CTRL_MON group:
> 	 "//<domain_id>=<flags>"
> 
>         * Non-default CTRL_MON group:
>                 "<CTRL_MON group>//<domain_id>=<flags>"
> 
>         * Child MON group of default CTRL_MON group:
>                 "/<MON group>/<domain_id>=<flags>"
> 
>         * Child MON group of non-default CTRL_MON group:
>                 "<CTRL_MON group>/<MON group>/<domain_id>=<flags>"
> 
>         Flags can be one of the following:
> 
>          t  MBM total event is enabled.
>          l  MBM local event is enabled.
>          tl Both total and local MBM events are enabled.
>          _  None of the MBM events are enabled

The language needs to be changed here (and in the many copied places) to
be specific about what setting the flag accomplishes. For example, in
"legacy" mode user space can be expected to find all events enabled, no?
Needing a new feature to set a flag to accomplish something that is
possible in legacy mode can thus cause confusion.

If I understand the implementation reading "mbm_control" will fail
if system is ABMC capable but it is disabled. Why can "mbm_control" not
always be displayed to user space? For example, what if "mbm_control" is
always available to user space and it can provide specific information to
user space. For example:
	t  MBM total event is enabled but may not always be counted.
	T  MBM total event is enabled and being counted.

On AMD systems resource groups will have "t" associated with monitor
groups when ABMC disabled, "T" when ABMC enabled and a counter assigned.
On Intel systems monitor groups will always have "T".

For "soft-RMID" the flag could possible continue to be "T"?

I am trying to find ways to communicate to user space consistently
and clearly and any insights will be appreciated. We really do not want
to add this interface and then find that it just causes confusion.

It is not quite obvious to me when the new files should be visible and
what they should present to the user. "mbm_mode" is now always visible.
Should "num_mbm_cntrs" not also always be visible? Right now "num_mbm_cntrs"
appears to be only associated to ABMC, should it not also, for example,
be the file that "soft-RMID" may use to share how many counters are
available? Its contents will thus be dynamic based on which "MBM mode" is
active, begging the question, what should it contain when "legacy" mode is
enabled, should "num_mbm_cntrs" perhaps show "0" to user space when
"legacy" mode is active?


> 
> 	Examples:
> 
> 	# cat /sys/fs/resctrl/info/L3_MON/mbm_control
> 	non_default_ctrl_mon_grp//0=tl;1=tl;
> 	non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
> 	//0=tl;1=tl;
> 	/child_default_mon_grp/0=tl;1=tl;
> 	
> 	There are four groups and all the groups have local and total
> 	event enabled on domain 0 and 1.

"local and total event" is vague, can it be made specific with, for example,
"local and total MBM events"

> 
> 	=tl means both total and local events are enabled.

Same here (and all copied places in this series)

> 
> 	"//" - This is a default CTRL_MON group
> 
> 	"non_default_ctrl_mon_grp//" - This is non-default CTRL_MON group
> 
> 	"/child_default_mon_grp/"  - This is Child MON group of the defult group

Same typos as in previous version of cover letter.

> 
> 	"non_default_ctrl_mon_grp/child_non_default_mon_grp/" - This is child
> 	MON group of the non-default group
> 
> e. Update the group assignment states using the interface file /sys/fs/resctrl/info/L3_MON/mbm_control.
> 
> 	The write format is similar to the above list format with addition of
> 	op-code for the assignment operation.
> 	
> 	* Default CTRL_MON group:
> 	        "//<domain_id><op-code><flags>"
> 	
> 	* Non-default CTRL_MON group:
> 	        "<CTRL_MON group>//<domain_id><op-code><flags>"
> 	
> 	* Child MON group of default CTRL_MON group:
> 	        "/<MON group>/<domain_id><op-code><flags>"
> 	
> 	* Child MON group of non-default CTRL_MON group:
> 	        "<CTRL_MON group>/<MON group>/<domain_id><op-code><flags>"
> 	
> 	Op-code can be one of the following:
> 	
> 	= Update the assignment to match the flag.
> 	+ Assign a new state.
> 	- Unassign a new state.

Please be consistent with terminology. Above switches between "flag"
and "state" while it then continues below using "event". Also,
"Unassign a _new_ state" is unexpected, it should probably be an
_existing_ (not "new") state/flag/event?

> 
> 	Flags can be one of the following:
> 
>          t  MBM total event.
>          l  MBM local event.
>          tl Both total and local MBM events.
>          _  None of the MBM events. Only works with '=' op-code.
> 	
> 	Initial group status:
> 	# cat /sys/fs/resctrl/info/L3_MON/mbm_control
> 	non_default_ctrl_mon_grp//0=tl;1=tl;
> 	non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
> 	//0=tl;1=tl;
> 	/child_default_mon_grp/0=tl;1=tl;
> 
> 	To update the default group to enable only total event on domain 0:
> 	# echo "//0=t" > /sys/fs/resctrl/info/L3_MON/mbm_control
> 
> 	Assignment status after the update:
> 	# cat /sys/fs/resctrl/info/L3_MON/mbm_control
> 	non_default_ctrl_mon_grp//0=tl;1=tl;
> 	non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
> 	//0=t;1=tl;
> 	/child_default_mon_grp/0=tl;1=tl;
> 
> 	To update the MON group child_default_mon_grp to remove total event on domain 1:
> 	# echo "/child_default_mon_grp/1-t" > /sys/fs/resctrl/info/L3_MON/mbm_control
> 
> 	Assignment status after the update:
> 	$ cat /sys/fs/resctrl/info/L3_MON/mbm_control
> 	non_default_ctrl_mon_grp//0=tl;1=tl;
> 	non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
> 	//0=t;1=tl;
> 	/child_default_mon_grp/0=tl;1=l;
> 
> 	To update the MON group non_default_ctrl_mon_grp/child_non_default_mon_grp to
> 	remove both local and total events on domain 1:
> 	# echo "non_default_ctrl_mon_grp/child_non_default_mon_grp/1=_" >
> 	       /sys/fs/resctrl/info/L3_MON/mbm_control
> 
> 	Assignment status after the update:
> 	non_default_ctrl_mon_grp//0=tl;1=tl;
> 	non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=_;
> 	//0=t;1=tl;
> 	/child_default_mon_grp/0=tl;1=l;
> 
> 	To update the default group to add a local event domain 0.
> 	# echo "//0+l" > /sys/fs/resctrl/info/L3_MON/mbm_control
> 
> 	Assignment status after the update:
> 	# cat /sys/fs/resctrl/info/L3_MON/mbm_control
> 	non_default_ctrl_mon_grp//0=tl;1=tl;
> 	non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=_;
> 	//0=tl;1=tl;
> 	/child_default_mon_grp/0=tl;1=l;
> 
> 
> f. Read the event mbm_total_bytes and mbm_local_bytes of the default group.
>     There is no change in reading the events with ABMC. If the event is unassigned
>     when reading, then the read will come back as "Unassigned".
> 	
> 	# cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
> 	779247936
> 	# cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
> 	765207488
> 	
> g. Users will have the option to go back to legacy mbm_mode if required.
>     This can be done using the following command. Note that switching the
>     mbm_mode will reset all the mbm counters of all resctrl groups.

mbm -> MBM (throughout)

> 
> 	# echo "legacy" > /sys/fs/resctrl/info/L3_MON/mbm_mode
> 	# cat /sys/fs/resctrl/info/L3_MON/mbm_mode
> 	abmc
> 	[legacy]
> 
> h. Check the bandwidth configuration for the group. Note that bandwidth
>     configuration has a domain scope. Total event defaults to 0x7F (to
>     count all the events) and local event defaults to 0x15 (to count all
>     the local numa events). The event bitmap decoding is available at
>     https://www.kernel.org/doc/Documentation/x86/resctrl.rst
>     in section "mbm_total_bytes_config", "mbm_local_bytes_config":
> 	
> 	#cat /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config
> 	0=0x7f;1=0x7f
> 	
> 	#cat /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config
> 	0=0x15;1=0x15
> 	
> j. Change the bandwidth source for domain 0 for the total event to count only reads.
>     Note that this change effects total events on the domain 0.
> 	
> 	#echo 0=0x33 > /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config
> 	#cat /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config
> 	0=0x33;1=0x7F
> 	
> k. Now read the total event again. The first read will come back with "Unavailable"
>     status. The subsequent read of mbm_total_bytes will display only the read events.
> 	
> 	#cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
> 	Unavailable
> 	#cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
> 	314101
> 	
> l. Unmount the resctrl
> 	
> 	#umount /sys/fs/resctrl/
> 

Reinette

