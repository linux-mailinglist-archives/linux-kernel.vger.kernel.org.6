Return-Path: <linux-kernel+bounces-364675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC0399D7C3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 21:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B9D0282A76
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 19:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A1E1CCED8;
	Mon, 14 Oct 2024 19:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DbRmVOis"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9652140E34;
	Mon, 14 Oct 2024 19:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728935523; cv=fail; b=fae99kMsNi1npRBNy83awgVhhRkS6DBpL/UuEB1eoYxrDcx3jLRlKHFI2nxKRDtaT/BqL36o4ehNA89Z9odhjmW4/JEiZvg5h6otmHT6Lt79iM5srXDFpDXF9hMU+b2LljXl08RlHeicssrWQwNDqEfKKhWG7ZotIV+OPVq9MLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728935523; c=relaxed/simple;
	bh=7kJa6x2a2mg7QLzVvsb7NQ6isUYtebgAxe9Dt+O6Yyo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ye8YxpOh+dWNNXarudTaSX/DMjaOHYRSDbtvtt/cm51Zd9SLEyZ0aLDg+1LJxns8o1qnlru0PAmlV9LpZgtArdkZpLfpNo8ElXklbw7QpAUpRud3ATLfumpmy2IU8mLKMS+ehLwFoqi3asOtL9TsmIeeaGa3J1gmuD3YW3kASUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DbRmVOis; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728935522; x=1760471522;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7kJa6x2a2mg7QLzVvsb7NQ6isUYtebgAxe9Dt+O6Yyo=;
  b=DbRmVOisM05vubUctxoyvHSanMTXcJlP9Q2X5+jZ6CzabVihDPrNVkuL
   Lne+OOcdAqPM6cOwg4D0C4djR9CAVjnZn+qkXf5BPaeyH1QI7i34rL7HH
   5p5wIm5ussNO9mUXi4cjcWkytbI3QzmjAH3k00nOCzspggYX/YTgap6fT
   ouluML6kh2NSNHBkMboUKv9WgvdK5dXot2f8Ija+gUhFhZfvWcegDYbk9
   Jh4SwSPcxIoofRCSECHS8kHTjLnkoU3bQA3Sln2rMRz49qSwVAmWD4J3u
   /V/ohR9xJj2CmL1/Dkk/FPyzmP0+P/jZ7YeypPN+wk8HO0WYZI2/wydRN
   g==;
X-CSE-ConnectionGUID: MW6EUP7XRMOKp+9TYiS9mg==
X-CSE-MsgGUID: bweZqUfMThu4AcACOk3ZgQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="27751398"
X-IronPort-AV: E=Sophos;i="6.11,203,1725346800"; 
   d="scan'208";a="27751398"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 12:52:01 -0700
X-CSE-ConnectionGUID: utfjc6mJT/ihFDEqGQk1Lw==
X-CSE-MsgGUID: B617CWZyR1yzzu+7Qk6RzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="82457754"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Oct 2024 12:52:01 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 14 Oct 2024 12:52:00 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 14 Oct 2024 12:52:00 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 14 Oct 2024 12:52:00 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Oct 2024 12:51:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tmdEx9a7rRN4/NUJjSHPNBJ10rQfdG/a73NcyLa2aFixcpatvqK/D66dUcNJZpZeObYt7KAVOkGXIjur0hZPq8jrOLvkc1NTd57IPkTyjMZFGw1c3iJ5heR5JRNuVF5lQ225YIcW9+HiQ9durFfYMtseFTu5zSagzelSWyxm7KA6D/Mim9/DLSO88JITueBFG/4Lv+YgJGWGEtWkwG2hughH8JH0+vH2qT01E1+VqeMKeopVj8Gk74lo8f1jobsq3WcgrP3X0+4cXNIPgLe42dDPfgoDafGWQD50/+TcrXE1XRCYiat7eTsMtDYXBVwmrHh4wXVPo4BPJOwY+JPzIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7kJa6x2a2mg7QLzVvsb7NQ6isUYtebgAxe9Dt+O6Yyo=;
 b=jhCqCU8atPwiIxzaWNMfg0wf1UNT1JFn3acjB4KTQrAAi37DlYgxeCGEpvDpt4IZCa9RnoyD49LcBzaY3pTg3aWC1x/vXaidxp4UBsIbDKz6IuNq1d9hGrT3QZVAlPLey1+YNKxNUiv22cDuLQddMqi05vQ5MkC838hGVkcNUTMtuTAPQEgPASflI77mORSoSSSRo8cJCT0iL89ylrHBj/9qSwg7OfACwir/6pEKh76yq8GZtrHrgMEV67k2Beu745/7nSmqm/MGhaYnI5D8v/yzXkx0GHSuY2PXI3t8tC1yq8Xb1ro4E+pdmzbgkhzxvBhCPEtUFS/jk86bmRhoEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by IA1PR11MB7853.namprd11.prod.outlook.com (2603:10b6:208:3f7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 19:51:49 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%4]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 19:51:49 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "babu.moger@amd.com" <babu.moger@amd.com>, "Chatre, Reinette"
	<reinette.chatre@intel.com>
CC: "corbet@lwn.net" <corbet@lwn.net>, "Yu, Fenghua" <fenghua.yu@intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "paulmck@kernel.org"
	<paulmck@kernel.org>, "rdunlap@infradead.org" <rdunlap@infradead.org>,
	"tj@kernel.org" <tj@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "yanjiewtw@gmail.com" <yanjiewtw@gmail.com>,
	"kim.phillips@amd.com" <kim.phillips@amd.com>, "lukas.bulwahn@gmail.com"
	<lukas.bulwahn@gmail.com>, "seanjc@google.com" <seanjc@google.com>,
	"jmattson@google.com" <jmattson@google.com>, "leitao@debian.org"
	<leitao@debian.org>, "jpoimboe@kernel.org" <jpoimboe@kernel.org>, "Edgecombe,
 Rick P" <rick.p.edgecombe@intel.com>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>, "Joseph, Jithu" <jithu.joseph@intel.com>,
	"Huang, Kai" <kai.huang@intel.com>, "kan.liang@linux.intel.com"
	<kan.liang@linux.intel.com>, "daniel.sneddon@linux.intel.com"
	<daniel.sneddon@linux.intel.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "sandipan.das@amd.com" <sandipan.das@amd.com>,
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
	"peternewman@google.com" <peternewman@google.com>, "Wieczor-Retman, Maciej"
	<maciej.wieczor-retman@intel.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Eranian, Stephane" <eranian@google.com>,
	"james.morse@arm.com" <james.morse@arm.com>
Subject: RE: [PATCH v8 08/25] x86/resctrl: Introduce interface to display
 number of monitoring counters
Thread-Topic: [PATCH v8 08/25] x86/resctrl: Introduce interface to display
 number of monitoring counters
Thread-Index: AQHbGybdEonESjxpIEK+MSvEee6fXLKAG/3ggAAYpoCAAACqQIAAGxsAgAADIiCAAB0cAIABl1/agARyzuGAAAmagIAABNZQgAAc2oCAAASSoA==
Date: Mon, 14 Oct 2024 19:51:48 +0000
Message-ID: <SJ1PR11MB6083583A24FA3B3B7C2DCD64FC442@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <ZwcIkf_oy2oKByNu@agluck-desk3.sc.intel.com>
 <8ceeb50a-70d7-4467-b7c1-4f62b1a1eec8@amd.com>
 <SJ1PR11MB608381B9DA3AE26749070BE8FC782@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <0fedcbd4-487c-4d55-8151-69dc34f41f1d@amd.com>
 <SJ1PR11MB6083FFA19F9387F21C058A09FC782@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <d1986f3f-9db7-4ac9-9fea-56878548ad61@amd.com>
 <SJ1PR11MB608382EB9F40FBDC19DF71C4FC782@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <1baa07f6-0ccc-4365-b7b8-09fe985963cd@amd.com>
 <Zwlj5TQxZphcuDSR@agluck-desk3.sc.intel.com>
 <8af0ce3a-1327-3ffc-ac5c-e495f9cdf5d0@amd.com>
 <ZwmadFbK--Qb8qWP@agluck-desk3.sc.intel.com>
 <ee7771e4-3768-456c-9990-fcd59b4f74af@intel.com>
 <0ee2e67d-c1dd-489e-beef-1f255c5629d6@amd.com>
 <SJ1PR11MB60833A1571413763DE36B538FC442@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <23b5a3d2-91ac-4467-9db0-3de483cfacf9@amd.com>
In-Reply-To: <23b5a3d2-91ac-4467-9db0-3de483cfacf9@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|IA1PR11MB7853:EE_
x-ms-office365-filtering-correlation-id: 470155b3-9979-4f34-5e46-08dcec89a435
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?K2dqU2N4aHkyQ0NBT212YUJZaTJId0t1Rlo2OHR0WFZHNlNsWndUUTUyVE5Q?=
 =?utf-8?B?YUJSUE5MN2RVenZCMWxLNDRoZG5UZ1JSZzdHZzVJT2l3Vk5RUkFoTGNYbjVx?=
 =?utf-8?B?V2RGYXhNNTJyOXBhc1hRT1FhRW4wUEhGVUFUOUdLaEVPL3J3dFBwL1JDZ2pu?=
 =?utf-8?B?T3RaTGlwREthYy81K0ZPSVNIYkROOW04MW1waHhMTkRsTGdka09FUkhnaTBp?=
 =?utf-8?B?dW96Vks5c3BRL0V6VU1qR1J4S25vTkJRV01KMnhacUFkemU4UHJWUUVJanlI?=
 =?utf-8?B?ancycDRTYzJiaXpxNlgzV0h1K3cxTWlIQ21pemtvQkpqcThvS294RDg1RytI?=
 =?utf-8?B?d1ZTTWdMTmppZWI1Um43QXl0TVQ5cDhINVhRUERTSU9ucnRGWDh5TUlBSnov?=
 =?utf-8?B?dXo1VlJPVkJibjJFYW5SNkozdUpBYWg5TUxFaDJyZkJtZ3VZM1BNeWJjeDNp?=
 =?utf-8?B?TlpGTGtFejlPOXloeTQ1TG9qcVZRbWpRWlYwcEQwNG0wTkF1bEZPckUybytr?=
 =?utf-8?B?eEk2L2NBbjdUMlAvZ3ZnSEk3MElKVThWVnh5a3VJRWF5VThlQVhnOVdienhK?=
 =?utf-8?B?NC9zdzZKeHgwdzNHSVlweitub3I3cGdmSW1HbGQzVFdSQks1elE4UjdQMSsx?=
 =?utf-8?B?ZStPREw2VXR2dE9UdTM1ZjFjRFJMUzkzMy80WDZZUnZiZitpQkF6dUxMY1N6?=
 =?utf-8?B?VlhDVHFtRnA5bVZHazlpRzdJditkbXdwMVNpRW1mMVByMjdFbXFPZ2p5TDVk?=
 =?utf-8?B?TmxaZ2RVRS9qYm5RNkJWTmR0cGIvdGxobHJXaXFqUmgxSnNYRlBiTERxQjZI?=
 =?utf-8?B?eUhDenI0Q253VmE2dmR3RU45WkI2S0FtZkJiRmZXL0Z0T21MRW9nMU5IYzQy?=
 =?utf-8?B?aWtSVkw5UVZlTnp6V2lFK3R1eFVqWFZsOGZocmhpS3BOc2xwUHNHclUxcm40?=
 =?utf-8?B?UU1TR01zVk54cWhON2dnUU9jTUJjc3lOZkpmRVcxRFBoY3pwVkFoVXUxRnQw?=
 =?utf-8?B?VmkzU25VUFd5am1zTVN5UmU4YklkY2Y0bDNLV09aUkFNelZBVTRpUnp2djhp?=
 =?utf-8?B?M1Y2WCtXWnlRM2x2UVZLNUJIMGcwdUt0OWdMVWxrNGNYb3Y4WnpNVUJTSklJ?=
 =?utf-8?B?TG9NdG02WFI4em1Lc3dPeFNLTVhlVGl5b3k2K0kxM3RLcGIyak9ob0RUb25J?=
 =?utf-8?B?Sm9vQmt6QjdaN0I4eHI4T04vVDdkSzhYTEo1UllvT29YNzRYY2kvS0xCdmh0?=
 =?utf-8?B?ekpPS0FGMzdwMWpaMm9pcm1ocFhtRFpmaWs5Z05CUTBqSHpNYWQ2am05bVNl?=
 =?utf-8?B?Q2lxbktnZ0NkWjF0aDBDYmx6WWo0dm1HSHYzYVhVQWJEWjhlcG9NRjN4c0kr?=
 =?utf-8?B?OWhRL25yZzhJUTd2QWNTVDNTTXgvZDhyYUNQa3BDc2FNN3dMTHZwV2U3Qzhw?=
 =?utf-8?B?UGN5WFdUQllLU0tBVkpkdllZUEtWNk1aV0RhWDI5SWFyNmZPNDl4VDBaUUNz?=
 =?utf-8?B?ZWE0WGJQdEF2NzBvUi9Vcy9WVU8wcWF5MWs5Wm5Fb3paZjVkbGhxYUQzaG1x?=
 =?utf-8?B?dm8wWVJhWVFhLzc0NDIzRUFKMHBPeFZ4ZVZ0UlNvVUpsdjk3cEpyeFk5anhD?=
 =?utf-8?B?VHBrMU9OZVU0Vk1hMjQzcm5wd3hSeVlPRWp2R0xFckdRVmhNVVdXektJd0xy?=
 =?utf-8?B?MzU2clhJaUZKcytWNlJVQ1pVVS9XbmlYMnRTbzNrdzkxa3diMHhCVFVjdjFq?=
 =?utf-8?B?ZUNudTNuZUs5b0MrSmNFZ3lFTW1VYUF5SWErSGtnZExvMzBwNE1YK3ZrQnUx?=
 =?utf-8?B?ZjF3eFRUbHE5UmtTSitNZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0pDMGlnUTJ2Vm1IVmVvOWFtWFQ3VENXZFd6aWV2UVZ3YVBDVFNsaXIyV3Nk?=
 =?utf-8?B?VmwraUVoSTJQN3NsTVoxY0R1WDVjV0VJL2JhYmxwZXl5STdBRUJqQnZIcG9r?=
 =?utf-8?B?dDRMUVB1WFlpeit4aUNWYUdWRDdmQmJYMDYzUFo2TndSZFRDM1dyNU1GajEw?=
 =?utf-8?B?dStWNnRDMGN0czc3ZXdQOUF5cTVKUHdkRHNWNVorZjhNNlpHQWF2NnFFZW9Q?=
 =?utf-8?B?OEJ5ZnFsZEJHaXdPamJLdUU3ZlV6blovNGtBMCtQYnlvTUsydWpadEI3NUJQ?=
 =?utf-8?B?QUtzYkd4VnlrdDFRcHhHUlVBMHBBU1NQRy9RQlZwZ3NkdzN2b1lId3h2VWZw?=
 =?utf-8?B?S1BvUm4vZW14NHF0R0ZWckNwUi9TUHBlQUUvK0E5TUpCR1V1QmRBQmMwc3NO?=
 =?utf-8?B?QWFmUHB1WERlbDFnZGt4eE1WTHNsd1pJdks4U2tJQVo0SjhHSllpWThUNFhq?=
 =?utf-8?B?VjZRSjNLaUJWdFd1Mmkzck5hZFJvMzR4Rkt4NUhxZ1ROMTJoTE5vbGs1S01k?=
 =?utf-8?B?NmJvTEJqbVJBZkJjaCtsVmg5aVB5SUZVT05WZVRQeWRlU2Y5UktQdzFyd0Yy?=
 =?utf-8?B?UzE1M1JqdXRDTnFQY0wxZ3c2TlFsYThlc2FXcisrM2p1ODc4aDJLcGpJSlRX?=
 =?utf-8?B?NlhnZ3BkSC9hSWNkUFlrSGwwM2hmSmV5WWczT1hMeXA0NG8rbW1rSWFSRW40?=
 =?utf-8?B?MFVVeDNyRlJVdWN5MGthQkhHaFlnV0pXSEM5RWpLMWVWNFdKS1pBT3pCRXcx?=
 =?utf-8?B?a1UvTE9sM2xra2JabkJMYWkxOWNVa3hRSE1IN3c3R3lPUUJZbm9lRXJCY3FD?=
 =?utf-8?B?UFJoM1FQdHVtVWZrU3dnS2JRclZyWi9nMHlabktTWXJ3OWtCYytGQm1tMFgv?=
 =?utf-8?B?K0FpWUlQOXp4WkhmRkJwUnlwMXpnWGU1OTF1eGpTNzNJOW8xVTN2NStzUG96?=
 =?utf-8?B?akFVOStXeCsxNGl0akQ3VWFGdmExcGJlSnZnSlBJcGNKMVFJVnVZMDNSV0dk?=
 =?utf-8?B?cVE3OUFtUjduRnJ3QW5ZRWFTU3NJM2lMbjJIVDNobjF6NFlTTzIrMTc3NW5Z?=
 =?utf-8?B?M1BCQlYrN3B2clhhTG9IbnZwSlUrYmY0ZlcwajRvV284NWRLMk5jOG94OGh0?=
 =?utf-8?B?Y3UxRXVPQ3ZySE5CVFBDTDRYZlF6M2xvNkJWOUM0ZE1QYkdpcFJvelBjcVJG?=
 =?utf-8?B?QWN6aml6L2RmWVV3TkZUNHZWWEFJeWxsWnJ4QkdhYXQxUUwvT3BUQ09UWXIy?=
 =?utf-8?B?eHNsYjBTL2VOSXVIOTk5alNxR2tHVENsV3pyazRMSWJWUVA5VkFsRHBNbWtQ?=
 =?utf-8?B?cWxsQnFyWldJVkU5Ym93YjVBUk1qWlJLNmxMWno2TWo2b1dhZXVyUjVsZk43?=
 =?utf-8?B?K2crQjNBQW1jZkdNbWJEbkJSc1ZmV0tFbi94RDg5ZnhxNjluMHpmeXVHTmg0?=
 =?utf-8?B?Sk1WSFpWUmRxc0ppcEk3UkZtMWZKSG9ldXNpbkZ4RlRwUFJvT2trV2VxNXdP?=
 =?utf-8?B?b2wwalZPMDh4NjgrNjBhUzNZaTBFMEE3QmdHUGFtVWMxVUYwa1NYSGkwOUZz?=
 =?utf-8?B?Z1RtTWdhdzN5WUhhbjc0dDF5d1JYVkVUcEViWWtnLzdocDJHWXlFTkVqMGxV?=
 =?utf-8?B?RnkwaGVwQkNPejdTZUVkMFFlc0pqRjIyZ2tkcHJqdDlyTmZ4RWNvc1dqekk2?=
 =?utf-8?B?YVp2SUx3WFNUaXN2STBsVjZlRGhRS29FUVZpRGtzbkhCdGRrV0x1Y3phYmZa?=
 =?utf-8?B?YVZqSWh0UnQ0MFM2VTRiSHdCVGF2UFpaekpUNFFEbExtbmZlQjE5RUw4Rkor?=
 =?utf-8?B?d3N0U2UwNW4ySE40MytKaE1OeEdMRnJyeU1MU0V4TjR2NXpVYWNWbWlVSE5W?=
 =?utf-8?B?TGw4a2Z2MW9jTkJiTmhSY2lDYnZ5NnRLa2J0eEtCT1FYSUc2UzJDS2x6UkZa?=
 =?utf-8?B?QzB5RlVYUTNkTStrQjRmTU4xQlhxME1GUFg5S2swNHVzUnhuWi9Mbzl6NVdC?=
 =?utf-8?B?M0xPcnQyVFkyNzZKLys5ZEo0NDE2RVMyNXhFdlROTHdqRE5GaEFyeHgrZ2ht?=
 =?utf-8?B?Q05yWkxZbXZFMHN5VmhIUEhjZGJZQVNPVW9Kd0xXQ0toTnZsdzlQR3JhdWNv?=
 =?utf-8?Q?tahlNFZFVJIfWvXTLrYEapMRI?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 470155b3-9979-4f34-5e46-08dcec89a435
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2024 19:51:48.9127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vnItgNlmCYfoLIDRyEIBE4kzF2jpgBaZh77dGqALG1InzD/7ImxaRjLknRVau+lKvST1ek3P1TSIvzcOEgiPRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7853
X-OriginatorOrg: intel.com

PiA+IFdoYXQgYWR2YW50YWdlIGRvZXMgaXQgaGF2ZSBvdmVyIHNraXBwaW5nIHRoZSBwZXItZG9t
YWluIGxpc3QgYW5kDQo+ID4ganVzdCBwcm92aWRpbmcgYSBzaW5nbGUgdmFsdWUgZm9yIGFsbCBk
b21haW5zPyBZb3UgY2xlYXJseSBleHBlY3QgdGhpcw0KPiA+IHdpbGwgYmUgYSBjb21tb24gdXNl
ciByZXF1ZXN0IHNpbmNlIHlvdSBpbXBsZW1lbnRlZCB0aGUgIioiIG1lYW5zDQo+ID4gYXBwbHkg
dG8gYWxsIGRvbWFpbnMuDQo+ID4NCj4NCj4gV2Ugc3RhcnRlZCB3aXRoIGEgZ2xvYmFsIGFzc2ln
bm1lbnQgYnkgYXBwbHlpbmcgYXNzaWdubWVudCBhY3Jvc3MgYWxsIHRoZQ0KPiBkb21haW5zIGlu
aXRpYWxseS4NCj4NCj4gQnV0IHdlIHdhbnRlZCBnaXZlIGEgZ2VuZXJpYyBhcHByb2FjaCB3aGlj
aCBhbGxvd3MgYm90aCB0aGUgb3B0aW9ucyhkb21haW4NCj4gc3BlY2lmaWMgYXNzaWdubWVudCBh
bmQgZ2xvYmFsIGFzc2lnbm1lbnQgd2l0aCAnKiIpLiBJdCBpcyBhbHNvIG1hdGNoZXMNCj4gd2l0
aCBvdGhlciBtYW5hZ2VtZW50cyAoUk1JRC9DTE9TSUQgbWFuYWdlbWVudCkgd2UgYXJlIGRvaW5n
IGluIHJlc2N0cmwNCj4gcmlnaHQgbm93LiBBbHNvLCB0aGVyZSBpcyBhbiBleHRyYSBJUEkgZm9y
IGVhY2ggZG9tYWluIGlmIHVzZXIgaXMgb25seQ0KPiBpbnRlcmVzdGVkIGluIG9uIGRvbWFpbi4N
Cj4NCj4gU29tZSBvZiB0aGUgZGlzY3Vzc2lvbnMgYXJlIGhlcmUuDQo+IGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL2xrbWwvZjdkYWM5OTZkODdiNDE0NGU0Yzc4NjE3OGE3ZmQzZDIxOGVhZWJlOC4x
NzExNjc0NDEwLmdpdC5iYWJ1Lm1vZ2VyQGFtZC5jb20vI3INCg0KTXkgc3VtbWFyeSBvZiB0aGF0
Og0KDQpQZXRlcjogQ29tcGxleCwgZG9uJ3QgbmVlZCBwZXItZG9tYWluLg0KUmVpbmV0dGU6IE1h
eWJlIHNvbWUgYXJjaGl0ZWN0dXJlIG1pZ2h0IHdhbnQgcGVyLWRvbWFpbi4NCg0KU2luY2UgeW91
IHNlZW0gdG8gd2FudCB0byBrZWVwIHRoZSBmbGV4aWJpbGl0eSBmb3IgYSBwb3NzaWJsZSBmdXR1
cmUNCndoZXJlIHBlci1kb21haW4gaXMgbmVlZGVkLiBUaGUgImF2YWlsYWJsZV9tYm1fY250cnMi
IGZpbGUNCnN1Z2dlc3RlZCBpbiBhbm90aGVyIHRocmVhZCB3b3VsZCBuZWVkIHRvIGxpc3QgYXZh
aWxhYmxlIGNvdW50ZXJzDQpvbiBlYWNoIGRvbWFpbiB0byBhdm9pZCBBQkkgcHJvYmxlbXMgc2hv
dWxkIHRoYXQgZnV0dXJlIGFycml2ZS4NCg0KJCBjYXQgbnVtX21ibV9jb3VudGVycw0KMzINCg0K
JCBjYXQgYXZhaWxhYmxlX21ibV9jbnRycw0KMD0xMjsxPTkNCg0KQ3VycmVudCBpbXBsZW1lbnRh
dGlvbiB3b3VsZCBzaG93IHNhbWUgbnVtYmVyIGZvciBhbGwgZG9tYWlucy4NCg0KLVRvbnkNCg==

