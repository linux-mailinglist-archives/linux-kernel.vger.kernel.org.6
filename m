Return-Path: <linux-kernel+bounces-251205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A844930210
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 00:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B63C91F22C33
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 22:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EFD5577E;
	Fri, 12 Jul 2024 22:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m/N0IDsj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD05A1BDC3;
	Fri, 12 Jul 2024 22:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720822665; cv=fail; b=f5GN0pzTS6I4m65aZs5VbppLnbjPUwUT19ZHN9l0jo8Sxc9ameCLhECbMlWFsc8/rYVW2RE4SSN8ALi/J6zZn9xAcs1XdLOHDdALS5WILDLnUuCCwBu6JgDeQ8XOUMXRGVH10sTc8lTONPhofZt3WjoCI3Pes8D0oeqIgMFv0M8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720822665; c=relaxed/simple;
	bh=vis8az7lEfExOOhrhCMp8d4w7vrT88Y6EjPeKvj8DQU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XXGOBIiLnPucMPCcpFoCqKvqlu5njZgOEJU1jYAnEEgfaNgOqTgBGnM7XP/evSArQJ+ZxlHU/CJfKOcyiR5XVYaP3YGP8IU/sV55SXrZxgSH3tmnlq0B3KBO4KAOzZr10FQ/uEtJUxoEMcKhNRyPv78BqiFY/mtFhhyQ0MKeGNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m/N0IDsj; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720822664; x=1752358664;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vis8az7lEfExOOhrhCMp8d4w7vrT88Y6EjPeKvj8DQU=;
  b=m/N0IDsjlNT+pUO01ehDpkqCxXjKcQrT7Lkx30AxHR8zXtz0dZrR5u4N
   ezv+Toe+HLfImOqC904Bku1EbtHhzGCSOWVtUQwppSIYGkzdWScOo+Nb8
   musSJaK3Am9xAgiFfVwthqlp3AILEg8SphbYtSe7QQ8TGmWyR+4ru/uT0
   tBFYvIdLejGSVf/HhMTSsegGqH39PBy0H65aaS2oWMYztOkgDJRG9aHff
   b1leTJEe5a6UXhBO8x9kyKgMsDEAoRonAr/H+xvlXumDkfaxO79ITMEQP
   NWmnZIB/5CfbadgeAOv44Rij1i9mN+V56aEhKhlqXiPlsfFAwxi5puN3N
   g==;
X-CSE-ConnectionGUID: Dt2RLUn5QWuk0S4uT+jpVg==
X-CSE-MsgGUID: Sm/H2uD5QsC0r4LT/UT/OQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11131"; a="18413724"
X-IronPort-AV: E=Sophos;i="6.09,204,1716274800"; 
   d="scan'208";a="18413724"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 15:17:43 -0700
X-CSE-ConnectionGUID: 3CNNU2f3THq9U09dUuNWdQ==
X-CSE-MsgGUID: Fdnhm3/ZSaKGtqgx6bFWPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,204,1716274800"; 
   d="scan'208";a="49033110"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Jul 2024 15:17:42 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 12 Jul 2024 15:17:42 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 12 Jul 2024 15:17:41 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 12 Jul 2024 15:17:41 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 12 Jul 2024 15:17:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XRj6ogcXfeXDbCkbNMycKBzoyujIgVgyZOxBHDFTcHWuvp7aLCNgtlRlyWQyizODfVT/a0/qLy4HLI1bGAFUfWoqgDJ8mui6TE5lw7WwaX9A/QDtUSgfmq5yTI3Xa6W60J4J1sxWt+2/M7kjXN5wPbxZWCrFApJ+OGMbHSq7CJ4ZEcrB0EbdPp4RnlGYOOcZws/5a/nBKXaMhqLL04RfRz+pqIYqXTmvAUCIXDAKTyvG+Yway9g2R5Yky+slikCBY5yAegy826gYC5iu9W/owbp4gkrxt7ThPhnqu8svtASUG1TnALGOsU9o9H5tnqqc7Sf8z97Ktp/nl4VIv5720g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=61xm54WbC2K6xWd8Z4McXrOsE4deXXSK9DLRbVOdL84=;
 b=wxAa5GCfaIpVgIi/p5LxOh7ozE1vrf/zPRPDRMGEtGK3pIbJQZ9OtLQzlHRdxu2McNa6sQfTFEwV4Bw86yDFhOuKsfe9u4ptr18MjWLjGgy05SdkJGyHBmZkAsQ87UEd8pF8romw/r9FVv06MvkB9j45dax5/0KQdii73sa8tgGrwkLsEkW6B/MKsxQFr2thpuBRS/TrGZyR3DHX2qKHcMCjDxXPWdBn1HTgz9HsusvPaHVaKbJ2fcHwn7DGhXjxqB+UbC9r07zumy8wwbcoONsrpNpNpRVN2PFb4R8Y8UwzOZw/EYAUmmF+4Y+S1neYcAxOb/oE5krUIsmyFdahQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA1PR11MB8448.namprd11.prod.outlook.com (2603:10b6:806:3a3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Fri, 12 Jul
 2024 22:17:38 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7741.033; Fri, 12 Jul 2024
 22:17:38 +0000
Message-ID: <d8e7ebe0-e3c4-461a-b544-555d5c4cdb5e@intel.com>
Date: Fri, 12 Jul 2024 15:17:34 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 20/20] x86/resctrl: Introduce interface to modify
 assignment states of the groups
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
 <49aa5321f6e81825a0e9e44cef06c243634e341a.1720043311.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <49aa5321f6e81825a0e9e44cef06c243634e341a.1720043311.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0011.namprd02.prod.outlook.com
 (2603:10b6:303:16d::28) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA1PR11MB8448:EE_
X-MS-Office365-Filtering-Correlation-Id: feffcdfc-3a46-49d4-b6e9-08dca2c07042
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c3hqdHM2ZitSWTdhMWZSeU5WTVpLT3EyWTBuNlJCeDhOaEtrY2pzTWJ2bm8z?=
 =?utf-8?B?UElaajB6SFFpb2IxZi9PR3ZzejJtdWtyRXVvbUtpQUQvMVRhYjFoSlpwa0hY?=
 =?utf-8?B?VUluUjNrVHprME1PcjNib1I5b2xBTWZudXVOcC90alpSaG5wekVyb1UzVjlx?=
 =?utf-8?B?Qk1SOWlZWmdkb0VmMlgrNnVDS1hUUjFMWG5Ja0lXUEFMRTNlbGRaRG5MSFNT?=
 =?utf-8?B?WlI3K0pRWlkzVkJHa3BzL1hJcmFRY0ZSaHhodWxJd1FQWnI2aWJKUDZ4eVdw?=
 =?utf-8?B?WGFMT091ei9Zc3R6eXl3a3RGbHlEaStzZmY1ZlVRTUtwdmtWVVhpR2wrdXBW?=
 =?utf-8?B?b2Eyb1RpdXZSTmlpdHZFMkdkRTNZSzhCVktrU2Fxd2pad3ZUdm1PUHlpaDZm?=
 =?utf-8?B?ZUQ1N3ZKeVErK2pINVpJc3V2V25nQ3ZHUm5YNDYxSGRKdFMzUklneHJwS1pE?=
 =?utf-8?B?Y0RMZVBPZkFtVTQ0SFl4UXhXZlBzd003VFBvR09XeUVBd2hkNTM0dzhMV1FH?=
 =?utf-8?B?YzhZdG9MR2hhNTNucG0yUXp1SWhPMDB2cWNDN1ZwclhGTi8ydFVRck43ZHRO?=
 =?utf-8?B?RUJhZ0s2Qjc5Tno1cmc3WnAxeWY4citCdGIrMy9ybHRXbkdtTkFrODBBTzAr?=
 =?utf-8?B?ZzFkTnpCeERLNzFnWFJINHZud0swZnFMd0dlZXNaVkVJT2dJQlU2VVBPelYv?=
 =?utf-8?B?azg5VDljMXlyLy9hNXZleTNsaC81am1INEt0VFZaN0pJSUwvckJVQTkwMDd4?=
 =?utf-8?B?bTdSbnNqMktFb2VnL2lrWWxtc2xscHVLRVdNbXRxS3JpamZFWW1wU0IwazJy?=
 =?utf-8?B?RXFBU1F6WFRVUXZjV01rdnVPUHRzZDhRbjVGbkd5b1FjbEJEY1BMRVdBK3FT?=
 =?utf-8?B?d1VKNm1mZnV1bWpvbEJ1UTFuYWI0SG55TEZzc0hJTEx1S1EwcVFvdE9QNGZ1?=
 =?utf-8?B?UlhMQ0REQTlKSUw5VnZURllCbFo2TTVRaUZUWTg0bXMxNWVxd0E5TTNqS1FY?=
 =?utf-8?B?cVBYR090QjVOeWRLakpxaUVSV1N4SnhoazNmL2ZDRi96ZDBrcDM1NjZNMXA1?=
 =?utf-8?B?TFRkOTJDdEFLQTZqaFllSjFjRWtmQVc4T2dBS1VhM1l0QjJNbmFkNDg1ZERT?=
 =?utf-8?B?L2FBVHhYWC8zSVVRWWdIN1lYc0RtZCtFT2F3R2NGVXdRd0s5enM3cnNMWUpn?=
 =?utf-8?B?N2N3eS9SczNUN1BFNys1S250Q1BXVDNuRnFxMEl1UDVydjlIN0c5QzJ1TjQx?=
 =?utf-8?B?QkR6Sk1qZ2kydjRYMnkxWDh0NXY2NnErekZyTUFwRUR6QVlDVmRQc0U5dnRQ?=
 =?utf-8?B?Z0Vqd05VOEVheUl2ak5kT2MvZ1E2bncwQXBIMmJVWWNQYlpWS1ROU3QxS0Va?=
 =?utf-8?B?L0xFZ2dFaHNZTlhXRVg1c3g4elJGL2ozZGIxcTZqTy9Lc3dSeFpFNzlEMGNz?=
 =?utf-8?B?QmR1OEozdDNOZU50ZVlWL2Z2UlRIWFk5VC9JZVh2d1lLK2l0Z1RkREJKNWFi?=
 =?utf-8?B?VldZc1FCVHMrZDJnTE5HMkNNalh5c081a3IwOXhmemdSaUg1TkFrS2tqMlhR?=
 =?utf-8?B?YXpTYVlWNlBCaExUM1lrZVdLNjI4QzdVV0w2eXpXZGRZclpmTjlCTXZqTmps?=
 =?utf-8?B?QUxMd3d4Zms1bkZaYlFKOW8yNDEvNVk0VDFpRTNzZTFtZ3VvTE1lejZDcGJ3?=
 =?utf-8?B?a3h2V3IxNGpmaE9wTXlTVklBaStpY21GaGN3eWxkV21xMTdkbXZMNmFkZkdG?=
 =?utf-8?Q?jHJWlBkPKiFebB7vCY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0tJWmJmTG1OMHE0OHJvZjFYejAyL3duZ25BSUpUc2haWHhwZmFFdE5WN3lv?=
 =?utf-8?B?a2tnUUpvdWg1aU1hcXAxS0FBRXBzMDN5VDloditYKzFieWEwYnE0Q25TV2Jl?=
 =?utf-8?B?dHJRZ2ZMREh6dGs5NEd6NkxXTTdnK0RwdDJxRE5raGk2Vm82WW5uRlc2am1Q?=
 =?utf-8?B?NU1FTzNlRjhoQ3BRbUVRM2RXTUdSRUwrOSt1a0VTWURmOGViM05HRm54Q2hC?=
 =?utf-8?B?K2gwdVk4SlljaVQ4TFkzRlJFL0puUlNWekx3dWxIMFdXQWR0SWdSK3pZeXF5?=
 =?utf-8?B?d0dQMFRWRWV4b2Z3Sm5CZWFuNHVlM1MwUm9yYitVbTJFVFFibSttaE5zSzZR?=
 =?utf-8?B?VmpJME5qR0l4MFk0UFJ3RGlpcnpGZyt3TFFDNXhDNE90Ym9JWDlWWWNUQjJG?=
 =?utf-8?B?VkFzZnpmaE9DYi9weC9ZUGpCRW94L2ZkdkNWcytIVmdZK0VhMkczVit5a3pX?=
 =?utf-8?B?aTFFRTFoTWxIMnFJcjF0RU53Njl5L05VV3BCZG5zNi91N3kzKzVlU0c2N3R6?=
 =?utf-8?B?VFozVWZPRVNJTVlxL002K1N6RDE3bGtOcWRsc3FFSWk0ZWtsc0ZvRGR5cnNQ?=
 =?utf-8?B?b204NHpEUTN5RFpONmtXTVhHdFg4d2cxMUxZQlExc0FGVGw3dWYwbXJYVmtZ?=
 =?utf-8?B?WEtqdVdFcmNBSlJUZ29oSzBuMnRrRFlNWDFlWnA3MUpuZUxBbkJyZjZ2cnB5?=
 =?utf-8?B?bTI5VSt2YlhydXNHWitBQ1hockFRSlVETEJEV255VEI1WjlWUUpJeVlyUGkx?=
 =?utf-8?B?dUQ5MUFUcnVzZnEyQmlwR0M2L0NyN01HcU1lK1pXMmdtT0F1cXFzVDBvLzdB?=
 =?utf-8?B?MWdxb3hNcmJhd3NHTlNqMGxxVTNzRkYzYnYwRzlzUTE2Z3hGWFA3ZUFaSFA5?=
 =?utf-8?B?YU5kUmtzLy9WSVZ4NTkvR2xVRC9lRjlBR0FxOGpBNk4vb2VIVVhLTWRzNFly?=
 =?utf-8?B?bVhkRUNpQnJEUkhSK3NhQnE1N2xLS1Q1WVZIbDlLZHRyVW1hR2VuR0xET0N3?=
 =?utf-8?B?QjhDc3BFWE9BYjhaV25ncFBtVTdzQWpDd3ArWXJzU3JsOFg5UlVaY3h1dWdm?=
 =?utf-8?B?V2lwQURLdXVTRXlhSlVlVFdwMHVXYzZXZ011OUd3NGJvYjZXUmdIRFdGbzJS?=
 =?utf-8?B?MW9wNkNhZnhrdkd3VHR5TExVTkh5a0ViQWdFR20zZTJhL2dQMVZnbU9xaTZu?=
 =?utf-8?B?azlKVTZCS0o0THFnRGpEamsyN3JlNCtWOG1ieHRVTFIza094a25DZDZvNldN?=
 =?utf-8?B?emhvWFY5UytTN0lCMzdsMnhmNGxiTU1JNXlYMnF3dzFxWTVjT2V2NlFkRHVS?=
 =?utf-8?B?ekVhbk1DMUdNSXVDRTh5ck1LOUY3WTlzWE9nakI4QkZLeHY5bkZ0YmpmcEVL?=
 =?utf-8?B?bGs3eTU3bm5WdllwQzVSZERaTjJ1Wjh5VnJSRTNmanNnQjl1cmdkVUh3ZnJa?=
 =?utf-8?B?WnkwZ1IxOWY0RmsxcFN5WVNNM0QwbHEvUUtURzRGOUxPdFdOQitkQVVKT0RN?=
 =?utf-8?B?dGE0Ui9PTGFieGxPbysyY0ZFLzhtem16S3Ivb2l2NFlYaHNwOURwK092ckpF?=
 =?utf-8?B?dTdzWFVZS0N0Uk96MzdHaWx2dmdqcnBCandESzQvWExmazY5WGMzVXNxcktz?=
 =?utf-8?B?bnB4Z1pSZ1JPejQ5amRzN2JKb1lBQy85ZlJCMFBWWTdUU092Q1dFdkdFUTM0?=
 =?utf-8?B?R3JraWUzRjgrSUE0NDd6VitPUnp6c20vU2xqVFJ5eExIUXNScHhYcmNScVc4?=
 =?utf-8?B?b2M2bUN2YjZldi9xU3MyUFAvZFc1Uk9KLzR0QzNJOHhzRHdqS0tRZldQNXJQ?=
 =?utf-8?B?ci8xWE9lMTlkVTh6MHhEai9mLzlSYll5bnoyenBEK0dIb1UzYlgwWjlYUUxh?=
 =?utf-8?B?WHozM2RvTEduUkhJNWZHMEovWG05WDdHVm5aQWp2VXdCOUw0Z21xaGcwOSs5?=
 =?utf-8?B?RjZNVWs0TEVZK29XRDNhdFg4VVJnQjZaMGdwUGFzVC9za1dLYkdHSENIY2Nj?=
 =?utf-8?B?eURaMWhnK2xTajdRZU9HMnFoZWQ0bEdmT2o2SE5QR3luR0UwL1I3d1V0U3Ro?=
 =?utf-8?B?TDJSODAxYU1PWFlkbGJlK3FaMWprc250eGJLQkY1M0FPWHhYYlhNTnVRWUdm?=
 =?utf-8?B?bUVrS05Qa0RGcCs0amExSTJzZnRUUzJ0cjZHY0hHZElCSTNDc1hIQk9JYVZM?=
 =?utf-8?B?Qnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: feffcdfc-3a46-49d4-b6e9-08dca2c07042
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 22:17:38.2093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y/aSxdAE8NDjjJpnPU5pajTF4UVSpfhaedheCcjhNt6ENHYisd+n2HAmENnhUeGlnrv+338C+Gf6q52J6S9m+PnpcxuL+hESVnGuOqqfG2A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8448
X-OriginatorOrg: intel.com

Hi Babu,

On 7/3/24 2:48 PM, Babu Moger wrote:
> Introduce the interface to enable events in ABMC mode.

As mentioned in cover letter, please take care with terms. This
interface does not "enable events" - note that events can be
"enabled" even in legacy mode. This is the interface to
assign counters.

> 
> Events can be enabled or disabled by writing to file
> /sys/fs/resctrl/info/L3_MON/mbm_control
> 
> Format is similar to the list format with addition of op-code for the
> assignment operation.
>   "<CTRL_MON group>/<MON group>/<op-code><flags>"

Missing a "domain_id".

> 
> Format for specific type of groups:
> 
>   * Default CTRL_MON group:
>           "//<domain_id><op-code><flags>"
> 
>   * Non-default CTRL_MON group:
>           "<CTRL_MON group>//<domain_id><op-code><flags>"
> 
>   * Child MON group of default CTRL_MON group:
>           "/<MON group>/<domain_id><op-code><flags>"
> 
>   * Child MON group of non-default CTRL_MON group:
>           "<CTRL_MON group>/<MON group>/<domain_id><op-code><flags>"
> 
> Op-code can be one of the following:
> 
>   = Update the assignment to match the flags
>   + enable a new state
>   - disable a new state

(note comment in cover letter about consistent terms)

> 
> Assignment flags can be one of the following:
>   t  MBM total event is enabled
>   l  MBM local event is enabled
>   tl Both total and local MBM events are enabled
>   _  None of the MBM events are enabled. Valid only with '=" opcode.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v5: Interface name changed from mbm_assign_control to mbm_control.
>      Fixed opcode and flags combination.
>      '=_" is valid.
>      "-_" amd "+_" is not valid.
>      Minor message update.
>      Renamed the function with prefix - rdtgroup_.
>      Corrected few documentation mistakes.
>      Rebase related changes after SNC support.
> 
> v4: Added domain specific assignments. Fixed the opcode parsing.
> 
> v3: New patch.
>      Addresses the feedback to provide the global assignment interface.
>      https://lore.kernel.org/lkml/c73f444b-83a1-4e9a-95d3-54c5165ee782@intel.com/
> ---
>   Documentation/arch/x86/resctrl.rst     |  81 +++++++-
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 250 ++++++++++++++++++++++++-
>   2 files changed, 329 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
> index 05fee779e109..5a621235eb2b 100644
> --- a/Documentation/arch/x86/resctrl.rst
> +++ b/Documentation/arch/x86/resctrl.rst
> @@ -331,7 +331,7 @@ with the following files:
>   	 t  MBM total event is enabled.
>   	 l  MBM local event is enabled.
>   	 tl Both total and local MBM events are enabled.
> -	 _  None of the MBM events are enabled.
> +	 _  None of the MBM events are enabled. Only works with opcode '=' for write.
>   
>   	Examples:
>   	::
> @@ -358,6 +358,85 @@ with the following files:
>   
>   	 /child_default_mon_grp/ - This is a child monitor group of default CTRL_MON group.
>   
> +	Assignment state can be updated by writing to the interface.
> +
> +	Format is similar to the list format with addition of op-code for the
> +	assignment operation.
> +
> +		"<CTRL_MON group>/<MON group>/<op-code><flags>"

Missing domain_id

> +
> +	Format for each type of groups:
> +
> +        * Default CTRL_MON group:
> +                "//<domain_id><op-code><flags>"
> +
> +        * Non-default CTRL_MON group:
> +                "<CTRL_MON group>//<domain_id><op-code><flags>"
> +
> +        * Child MON group of default CTRL_MON group:
> +                "/<MON group>/<domain_id><op-code><flags>"
> +
> +        * Child MON group of non-default CTRL_MON group:
> +                "<CTRL_MON group>/<MON group>/<domain_id><op-code><flags>"
> +
> +	Op-code can be one of the following:
> +	::
> +
> +	 = Update the assignment to match the flags.
> +	 + Add a new state.
> +	 - delete a new state.
> +
> +	Examples:
> +	::
> +
> +	  Initial group status:
> +	  # cat /sys/fs/resctrl/info/L3_MON/mbm_control
> +	  non_default_ctrl_mon_grp//0=tl;1=tl;
> +	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
> +	  //0=tl;1=tl;
> +	  /child_default_mon_grp/0=tl;1=tl;
> +
> +	  To update the default group to enable only total event on domain 0:
> +	  # echo "//0=t" > /sys/fs/resctrl/info/L3_MON/mbm_control
> +
> +	  Assignment status after the update:
> +	  # cat /sys/fs/resctrl/info/L3_MON/mbm_control
> +	  non_default_ctrl_mon_grp//0=tl;1=tl;
> +	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
> +	  //0=t;1=tl;
> +	  /child_default_mon_grp/0=tl;1=tl;
> +
> +	  To update the MON group child_default_mon_grp to remove total event on domain 1:
> +	  # echo "/child_default_mon_grp/1-t" > /sys/fs/resctrl/info/L3_MON/mbm_control
> +
> +	  Assignment status after the update:
> +	  $ cat /sys/fs/resctrl/info/L3_MON/mbm_control
> +	  non_default_ctrl_mon_grp//0=tl;1=tl;
> +	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
> +	  //0=t;1=tl;
> +	  /child_default_mon_grp/0=tl;1=l;
> +
> +	  To update the MON group non_default_ctrl_mon_grp/child_non_default_mon_grp to
> +	  remove both local and total events on domain 1:
> +	  # echo "non_default_ctrl_mon_grp/child_non_default_mon_grp/1=_" >
> +			/sys/fs/resctrl/info/L3_MON/mbm_control
> +
> +	  Assignment status after the update:
> +	  non_default_ctrl_mon_grp//0=tl;1=tl;
> +	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=_;
> +	  //0=t;1=tl;
> +	  /child_default_mon_grp/0=tl;1=l;
> +
> +	  To update the default group to add a local event domain 0.
> +	  # echo "//0+l" > /sys/fs/resctrl/info/L3_MON/mbm_control
> +
> +	  Assignment status after the update:
> +	  # cat /sys/fs/resctrl/info/L3_MON/mbm_control
> +	  non_default_ctrl_mon_grp//0=tl;1=tl;
> +	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=_;
> +	  //0=tl;1=tl;
> +	  /child_default_mon_grp/0=tl;1=l;
> +
>   "max_threshold_occupancy":
>   		Read/write file provides the largest value (in
>   		bytes) at which a previously used LLC_occupancy
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 0de9f23d5389..84c0874d7872 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1068,6 +1068,253 @@ static int rdtgroup_mbm_control_show(struct kernfs_open_file *of,
>   	return 0;
>   }
>   
> +static int rdtgroup_str_to_mon_state(char *flag)
> +{
> +	int i, mon_state = 0;
> +
> +	for (i = 0; i < strlen(flag); i++) {
> +		switch (*(flag + i)) {
> +		case 't':
> +			mon_state |= ASSIGN_TOTAL;
> +			break;
> +		case 'l':
> +			mon_state |= ASSIGN_LOCAL;
> +			break;
> +		case '_':
> +			mon_state = ASSIGN_NONE;
> +			break;
> +		default:
> +			mon_state = ASSIGN_NONE;
> +			break;
> +		}
> +	}
> +

No. As I mentioned before this makes all this work for nothing
by preventing us from ever adding another flag. Please do not
have a default catchall that unassigns all flags.

> +	return mon_state;
> +}
> +
> +static struct rdtgroup *rdtgroup_find_grp(enum rdt_group_type rtype, char *p_grp, char *c_grp)
> +{
> +	struct rdtgroup *rdtg, *crg;
> +
> +	if (rtype == RDTCTRL_GROUP && *p_grp == '\0') {
> +		return &rdtgroup_default;
> +	} else if (rtype == RDTCTRL_GROUP) {
> +		list_for_each_entry(rdtg, &rdt_all_groups, rdtgroup_list)
> +			if (!strcmp(p_grp, rdtg->kn->name))
> +				return rdtg;
> +	} else if (rtype == RDTMON_GROUP) {
> +		list_for_each_entry(rdtg, &rdt_all_groups, rdtgroup_list) {
> +			if (!strcmp(p_grp, rdtg->kn->name)) {
> +				list_for_each_entry(crg, &rdtg->mon.crdtgrp_list,
> +						    mon.crdtgrp_list) {
> +					if (!strcmp(c_grp, crg->kn->name))
> +						return crg;
> +				}
> +			}
> +		}
> +	}
> +
> +	return NULL;
> +}
> +
> +static int rdtgroup_process_flags(enum rdt_group_type rtype, char *p_grp, char *c_grp, char *tok)
> +{
> +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> +	int op, mon_state, assign_state, unassign_state;
> +	char *dom_str, *id_str, *op_str;
> +	struct rdt_mon_domain *d;
> +	struct rdtgroup *rdtgrp;
> +	unsigned long dom_id;
> +	int ret, found = 0;
> +
> +	rdtgrp = rdtgroup_find_grp(rtype, p_grp, c_grp);
> +
> +	if (!rdtgrp) {
> +		rdt_last_cmd_puts("Not a valid resctrl group\n");
> +		return -EINVAL;
> +	}
> +
> +next:
> +	if (!tok || tok[0] == '\0')
> +		return 0;
> +
> +	/* Start processing the strings for each domain */
> +	dom_str = strim(strsep(&tok, ";"));
> +
> +	op_str = strpbrk(dom_str, "=+-");
> +
> +	if (op_str) {
> +		op = *op_str;
> +	} else {
> +		rdt_last_cmd_puts("Missing operation =, +, -, _ character\n");
> +		return -EINVAL;
> +	}
> +
> +	id_str = strsep(&dom_str, "=+-");
> +
> +	if (!id_str || kstrtoul(id_str, 10, &dom_id)) {
> +		rdt_last_cmd_puts("Missing domain id\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Verify if the dom_id is valid */
> +	list_for_each_entry(d, &r->mon_domains, hdr.list) {
> +		if (d->hdr.id == dom_id) {
> +			found = 1;
> +			break;
> +		}
> +	}
> +	if (!found) {
> +		rdt_last_cmd_printf("Invalid domain id %ld\n", dom_id);
> +		return -EINVAL;
> +	}
> +
> +	mon_state = rdtgroup_str_to_mon_state(dom_str);
> +
> +	assign_state = 0;
> +	unassign_state = 0;
> +
> +	switch (op) {
> +	case '+':
> +		if (mon_state == ASSIGN_NONE) {
> +			rdt_last_cmd_puts("Invalid assign opcode\n");
> +			goto out_fail;
> +		}
> +		assign_state = mon_state;
> +		break;
> +	case '-':
> +		if (mon_state == ASSIGN_NONE) {
> +			rdt_last_cmd_puts("Invalid assign opcode\n");
> +			goto out_fail;
> +		}
> +		unassign_state = mon_state;
> +		break;
> +	case '=':
> +		assign_state = mon_state;
> +		unassign_state = (ASSIGN_TOTAL | ASSIGN_LOCAL) & ~assign_state;
> +		break;
> +	default:
> +		break;
> +	}
> +

this flow is not clear to me ... I see how an existing counter is
configured but I do not see any counter being freed/allocated, where is that
done?

> +	if (assign_state & ASSIGN_TOTAL)
> +		ret = resctrl_arch_assign_cntr(d, QOS_L3_MBM_TOTAL_EVENT_ID,
> +					       rdtgrp->mon.rmid,
> +					       rdtgrp->mon.cntr_id[0],
> +					       rdtgrp->closid, 1);
> +	if (ret)
> +		goto out_fail;
> +
> +	if (assign_state & ASSIGN_LOCAL)
> +		ret = resctrl_arch_assign_cntr(d, QOS_L3_MBM_LOCAL_EVENT_ID,
> +					       rdtgrp->mon.rmid,
> +					       rdtgrp->mon.cntr_id[1],
> +					       rdtgrp->closid, 1);
> +
> +	if (ret)
> +		goto out_fail;
> +
> +	if (unassign_state & ASSIGN_TOTAL)
> +		ret = resctrl_arch_assign_cntr(d, QOS_L3_MBM_TOTAL_EVENT_ID,
> +					       rdtgrp->mon.rmid,
> +					       rdtgrp->mon.cntr_id[0],
> +					       rdtgrp->closid, 0);
> +
> +	if (ret)
> +		goto out_fail;
> +
> +	if (unassign_state & ASSIGN_LOCAL)
> +		ret = resctrl_arch_assign_cntr(d, QOS_L3_MBM_LOCAL_EVENT_ID,
> +					       rdtgrp->mon.rmid,
> +					       rdtgrp->mon.cntr_id[1],
> +					       rdtgrp->closid, 0);
> +	if (ret)
> +		goto out_fail;
> +
> +	goto next;
> +
> +out_fail:
> +
> +	return -EINVAL;
> +}
> +
> +static ssize_t rdtgroup_mbm_control_write(struct kernfs_open_file *of,
> +					  char *buf, size_t nbytes,
> +					  loff_t off)
> +{
> +	struct rdt_resource *r = of->kn->parent->priv;
> +	char *token, *cmon_grp, *mon_grp;
> +	struct rdt_hw_resource *hw_res;
> +	int ret;
> +
> +	hw_res = resctrl_to_arch_res(r);
> +	if (!hw_res->abmc_enabled)
> +		return -EINVAL;
> +
> +	/* Valid input requires a trailing newline */
> +	if (nbytes == 0 || buf[nbytes - 1] != '\n')
> +		return -EINVAL;
> +
> +	buf[nbytes - 1] = '\0';
> +	rdt_last_cmd_clear();

rdt_last_cmd_clear() should be called with mutex held

> +
> +	cpus_read_lock();
> +	mutex_lock(&rdtgroup_mutex);
> +
> +	while ((token = strsep(&buf, "\n")) != NULL) {
> +		if (strstr(token, "//")) {
> +			/*
> +			 * The CTRL_MON group processing:
> +			 * default CTRL_MON group: "//<flags>"
> +			 * non-default CTRL_MON group: "<CTRL_MON group>//flags"
> +			 * The CTRL_MON group will be empty string if it is a
> +			 * default group.
> +			 */
> +			cmon_grp = strsep(&token, "//");
> +
> +			/*
> +			 * strsep returns empty string for contiguous delimiters.
> +			 * Make sure check for two consicutive delimiters and

consicutive -> consecutive

> +			 * advance the token.
> +			 */
> +			mon_grp = strsep(&token, "//");
> +			if (*mon_grp != '\0') {
> +				rdt_last_cmd_printf("Invalid CTRL_MON group format %s\n", token);
> +				ret = -EINVAL;
> +				break;
> +			}
> +
> +			ret = rdtgroup_process_flags(RDTCTRL_GROUP, cmon_grp, mon_grp, token);
> +			if (ret)
> +				break;
> +		} else if (strstr(token, "/")) {
> +			/*
> +			 * MON group processing:
> +			 * MON_GROUP inside default CTRL_MON group: "/<MON group>/<flags>"
> +			 * MON_GROUP within CTRL_MON group: "<CTRL_MON group>/<MON group>/<flags>"
> +			 */
> +			cmon_grp = strsep(&token, "/");
> +
> +			/* Extract the MON_GROUP. It cannot be empty string */
> +			mon_grp = strsep(&token, "/");
> +			if (*mon_grp == '\0') {
> +				rdt_last_cmd_printf("Invalid MON_GROUP format %s\n", token);
> +				ret = -EINVAL;
> +				break;
> +			}
> +
> +			ret = rdtgroup_process_flags(RDTMON_GROUP, cmon_grp, mon_grp, token);
> +			if (ret)
> +				break;
> +		}

can these two blocks not be merged? strsep(&token, "//") and strsep(&token, "/") do the same
thing, no?

> +	}
> +
> +	mutex_unlock(&rdtgroup_mutex);
> +	cpus_read_unlock();
> +
> +	return ret ?: nbytes;
> +}
> +
>   #ifdef CONFIG_PROC_CPU_RESCTRL
>   
>   /*
> @@ -2282,9 +2529,10 @@ static struct rftype res_common_files[] = {
>   	},
>   	{
>   		.name		= "mbm_control",
> -		.mode		= 0444,
> +		.mode		= 0644,
>   		.kf_ops		= &rdtgroup_kf_single_ops,
>   		.seq_show	= rdtgroup_mbm_control_show,
> +		.write		= rdtgroup_mbm_control_write,
>   	},
>   	{
>   		.name		= "cpus_list",

Reinette

