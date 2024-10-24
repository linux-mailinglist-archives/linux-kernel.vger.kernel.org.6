Return-Path: <linux-kernel+bounces-380423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F749AEE4A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 19:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78FDA2817B4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 17:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5FA1FC7ED;
	Thu, 24 Oct 2024 17:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D5Pz/GMx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15B31F941A;
	Thu, 24 Oct 2024 17:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729791464; cv=fail; b=gcTR1HuV8EIRqIB0mpxEScfgLQE5V9ro5nSFY6q04+sZb795BfgU3RBtwj1Pq2GZ57MfgF2DAWPS4WHSMc7QnLAD7tgiWUFOza9u19tXvHvcCaecK28l6pRhmLHmvZhTNTUA3TX8DFpspXQ5+512J/l6UpW79SbZYHszYUjUZfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729791464; c=relaxed/simple;
	bh=F2EQomFY2bl1pSR6YoFq6sngQHz3xtpYBOMkeDh83o8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fIkSfP25ufkSJhlRKGCeDEzv/K8zrm2JD2fNy4XrjuwZxOIESe5L0WaTgRsKwIqWiqSs8bX68gNW9aGqxMVty7ey4mlAHgJBPjs6+yrSRnrXA5S/JBUWf7MI+qsjuLdjYpnzQfXIbCI6hO1ABMBSUJJZY60rLAKjN7o5iEFmbzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D5Pz/GMx; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729791462; x=1761327462;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=F2EQomFY2bl1pSR6YoFq6sngQHz3xtpYBOMkeDh83o8=;
  b=D5Pz/GMxLr34OPZQUKokwhzsUYR7ljKyaIb36SuNlYNT00BjvrnP3l57
   PJq0tbMXLd8bb/KBUQu/vQLGtHZGRkRvlLo0XMxbNnwK5aRl7gVq5sJbI
   6ceo4o+xancwCM0ozbEqGDgu8eNcGdfNrKJju8ZmRJHtgBq/Sp11/ej3s
   GGbBTfm+OIW7BZz0rE6RKrzcdAW7tdfHoR4mnM4FHqkgzolg8Z3eTShNw
   SneyHkiUfqGfvusB5c3nW7gpAE3HH5J3ndKYYbIyH2jGNXIDAfX4zR4P7
   /FiClzk6WMNheMc1+ve9sz37ZdDnu1/PyTtTB0B8r8zJ5ZluY75QVOf4U
   A==;
X-CSE-ConnectionGUID: 19B6voZrT/CltpQnPtnpVg==
X-CSE-MsgGUID: cLCtWsweSaOFyxXd7fyx+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="17068606"
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="17068606"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 10:37:42 -0700
X-CSE-ConnectionGUID: NWkfmm9wSrK53Q7/UDlrtQ==
X-CSE-MsgGUID: PmcEsbOhTseyhDwfneHrMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="84631449"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Oct 2024 10:37:41 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 24 Oct 2024 10:37:40 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 24 Oct 2024 10:37:40 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 24 Oct 2024 10:37:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QzJTpn0nrC9w8A0OHjyz8sRj83K5dsjC1axgwmQm3uD2D3zF4sZ4HK/bysFgKHXMoBOEX7rWvUefrCFdckg8dmV3T7F6H71kyUm2XRxrqZ1JAc9C5JymQ0cuhg3qZh19gFDFfvYNdnHVwfsMIxim8txE2q7zyaCWkHjp9v/yWdfacJrZOCLg7AcQFL+VyUz3fZvLO4UogeoiUBdeKZmkyolnxhfILT6jhhxjbs3DUW+Zzh+iB1mU8ZT4GWzp+40ZuBrwnX2jeV1bqQQCh3HF+riVF9X3SZUffxvPFjjJj+zIBKczPhtP/hUVvdc8Sy7vhn/QSw0LhfNtnk6CgvCOuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F2EQomFY2bl1pSR6YoFq6sngQHz3xtpYBOMkeDh83o8=;
 b=yZ7pu5OEhc6r+55ynFyOsjRU2drxZWpvsmASmhVU1DmLJXHZg9rkR7vAt35i+SIegdwq5fGjogdCMnJM5y8rvFiK7eDm7yXNxH4QW9n+lygsVSou2B2pQTTqNGb3NzVWBseJOPtOOWmKJXev1dCQVAZIYslGhCvWIl9UWt7feUKTZdrQnHu5bdd2SK5DtgUsTxZDWxntxXX0w6ppTRCXZmcbGJ6KYc/RO0F9wryZiwymuMCK7My5dialqRYBgoCXVY9RHEHRb4kzoWIAABCwCxPNP2UTt9Nn/23d4K4wdMgl7OQoK1s3OUCJmzMN5Bm0Q7w947SUNFs6fFc6Co1qRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DM4PR11MB6429.namprd11.prod.outlook.com (2603:10b6:8:b5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Thu, 24 Oct
 2024 17:37:37 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%4]) with mapi id 15.20.8093.018; Thu, 24 Oct 2024
 17:37:37 +0000
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
Thread-Index: AQHbGybdEonESjxpIEK+MSvEee6fXLKAG/3ggAAYpoCAAACqQIAAGxsAgAADIiCAAB0cAIABl1/agARyzuGAAAmagIAABNZQgAAc2oCAAASSoIAAB/gAgA+Lh4CAAAFzsA==
Date: Thu, 24 Oct 2024 17:37:37 +0000
Message-ID: <SJ1PR11MB6083DC9EA6D323356E957A87FC4E2@SJ1PR11MB6083.namprd11.prod.outlook.com>
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
 <SJ1PR11MB6083583A24FA3B3B7C2DCD64FC442@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <799f514f-b06e-46d9-bfe7-dfd986aef166@intel.com>
 <3b7ca34a-764d-458e-b28c-113dc5419a4e@amd.com>
In-Reply-To: <3b7ca34a-764d-458e-b28c-113dc5419a4e@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DM4PR11MB6429:EE_
x-ms-office365-filtering-correlation-id: d3069b3a-5415-4b27-c039-08dcf4528d73
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MGREelRMRWlkVlVDTU04WnNyUTliL3lRVHRZRVkxYWJIVEM2NFlDMUdkREtl?=
 =?utf-8?B?ekpJVDdENlF4Tmk3ZkxVWVlXMVZCM29nWFBiN2ZsRzZ4emJVN0g2K1prRGRk?=
 =?utf-8?B?VFYvMUJGTmhIek1TYndiamhGVUtmTHRseVQwRmlCYjBRL1pTMFk1Z2xUY3ZV?=
 =?utf-8?B?NWgvbzhtclpZd2hKWlRhR29xcUZmUXRQaUx3NWtEajExNkRrMGQ2cnVUSHdM?=
 =?utf-8?B?U1FpUkxHUVJ0S1NFSWhTN3gxaEtJV3NGOFBUbGhRSTAyQ0hxeEUzQ05EdC8r?=
 =?utf-8?B?ZFlaaHJwc2pITFRJQlR0VW5TUzArVVAxRldmVUNDTC9RMW9RblR4SXFjc29h?=
 =?utf-8?B?aFN2dWdEeWtPSDBtYVFEUlQwR2FVY1hGS0pLUnVJVVNmRmhWVFBkUVFhczIz?=
 =?utf-8?B?dlhpOGhDam1OVTBvbUh6L0tRTjhLRE53RGMzNW5FQmhYeU9FSWdtSEJCVXlO?=
 =?utf-8?B?cHFSUmhxNTdjVW8rT3FFM2lRVjJwZ21lUHFsWnYxekVFUGpyTUFlR1NQbG1C?=
 =?utf-8?B?YzBGelNQK21UbnkyOXJaQXNGclo2bnJTKzNVdEpYYlN4N0YwTW1vS0Y2eWd1?=
 =?utf-8?B?d2VHekFVRTFrVVhwY2p0aHNXNWF1bDg4K0M2UlgydUZUOVFaa2U2SllzN0Vz?=
 =?utf-8?B?NDFWN0JVYUY1bHU5SXk2QzNKK2p5MVk5blZ0VEZQTlltSllqemdDRmc1MXhy?=
 =?utf-8?B?OGQveTdpb2hYM0RuNlQxM1pRem5nRHpDSXpTcFFYOWhtRFFYUkxPemRJQ2xE?=
 =?utf-8?B?cW9BWUJhcll1TStEY0NONHhWNXBOd3RUTFVLZ2Eyem5ueU9OZG9lTjB1eFMv?=
 =?utf-8?B?QmpCNWxxZkROYjRQRm1UQldraW1nRm5peS92WUtlMUpZNU5oOWFpekdMSWdS?=
 =?utf-8?B?djRZYk9UcHU3M2liaW1CT2U5M3g0QjJQRVFTazJ1V0xHbUxNSUxubXFkb21m?=
 =?utf-8?B?OExieW05M3FDdlFVakpWVmFscmtscDNwZjZvY0VmSHc0NG4wYjdNMkM5WnNM?=
 =?utf-8?B?ajBWWW9oNjNQT09EaVM0MjhaVnVmVkYyQVFQZlh4T25NYStOcUFVSzhHaVJB?=
 =?utf-8?B?NXh4NExXQlI2K0ZUbnY1akNEcTZTbktrN3QxUVo5bU1NWVQ4K21oOGJQVVM3?=
 =?utf-8?B?RkQ2WHVPZ3NHSzlQMWFUa2hJY2ZVZDdyRytzZks2ZVB2ZHRKNkxLSGFDT3NR?=
 =?utf-8?B?bjdQTzh1WHRKa05mdFptUmFLcXFUcTFTQytyRjRUMWtUaG55U2FlNThtcjNF?=
 =?utf-8?B?SHNXS1pxSjNJMk1ra28xYlhSd1dDbnk1cSsrU09jYWxOcGhDQkx6MU1KVlNV?=
 =?utf-8?B?dnJOSEsyLzRSRDhuUUFEdkpZN1lna3lwNGhnSzRpMjVrRnJ1UDJHVEttckIx?=
 =?utf-8?B?MFhjRnRYQnhoYm41TVZmd05hVnkxeTAwWTJFa0hxZGlJNTR3ZW53M1g2NG8v?=
 =?utf-8?B?dU5LU2M3TU1yUzVSUEJNd25Rd1Y3bmlrMjczRWxTNis2aGdhdTVTU3R1Smsy?=
 =?utf-8?B?TFZjL1VBRVZnT096dzhYZGlJc2tLY0J4Ty8wMzRXRi9nalQyQUp1aGEzUDFP?=
 =?utf-8?B?VVJsYUZnYnNuQ0sxRWxLYVRyT09tU21KTmVKdk5OT1N3ZG9lY01kUGhMQW9J?=
 =?utf-8?B?YWZNcmxiWm1MbUZYcE92bFZ3emRGcWNPWkxVSVRNQkdJRnV1R2w3Rm1jbVlN?=
 =?utf-8?B?cGFpdW5tU0x6SXp6SWNsT3laeG1IbTJNT2NyMUprNzBpbWZWbjlkOVhVajVO?=
 =?utf-8?B?b1IzQnFCelN3YUpFWVNmSWhDM2UwTkJyYWpyZmNtdk9LYzNpUjFmdGI0bUhq?=
 =?utf-8?Q?SGF6XsGHJI0veVi0M2RYUYtlIaottseKeFxUs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGN0enFjSzNNWUU2NW56eVZVODBMVzRPL3pZVkY4YnNLdENuTGNJSEtyaVQr?=
 =?utf-8?B?TEx1emxhaE1MOE1ieGF6Q2I0RjdhY2w5aVA2WnEzc3AvOEtlOXBwSE01UWll?=
 =?utf-8?B?b3d5ZTlkOTV6TVBVK2YxUE1Zb1lrdHZlamJHSUxuNjNUelFIRGliQys0dEdu?=
 =?utf-8?B?K2pFZm9EYkhpbGlIMll3UC9UOUFaeCs2Tks0YXhRVDZjYklabEhSMDdsVzZP?=
 =?utf-8?B?RHdPa1AzbUY1U2NROUQxRUY0V1Uzc0RXUFEyK3daYUZpNmZTZUtVenR0MnJX?=
 =?utf-8?B?bkl2eDZ4YTB3eFJpdTUrS0g0WUExOVIvUWtmYXVUcy9LZ0syK2NBU0V6VnUx?=
 =?utf-8?B?dG5vc3dCTkQzcmdIVWFFSmg2TzJuN21YbDNmdDMyRzlDVTBUMnNrdlJ0YXhm?=
 =?utf-8?B?YTlTbURZTkxOTUg2Vk1uZHV3SXJxRkxJWTZYKzVTcGJ5T0xoQnJLVS9kTlJw?=
 =?utf-8?B?RjZ4ckZzdW5Hd2ZLQ25mK0RQZThrenpnRHlMaWVGL1NRcFZzMGdKQnM4M1E0?=
 =?utf-8?B?Y2RmZ2duNXFaZTRTelZBL05sMDRQZlVmNU9VTkhtZ1JlSWI5WS9IRmtSTXdG?=
 =?utf-8?B?NUMweVNndXNrWnJBWDhJYzBxTkxNazlSMjRwZjdrRUN2dUVxNk9tVVpSYXI4?=
 =?utf-8?B?R1I3cUMxaFBKMlNJY3JNWTM3STRqUnYyY1dvMStpeCt4ZXBHcVl6Qm1MQ0FJ?=
 =?utf-8?B?WHVCU09SMUZYMlY0T293M1lUc2RvUDZDYXpNdHZldll0T3RZcldLOTR1RVVU?=
 =?utf-8?B?aG56dkEzUVYrMXZ6dlpVRTFhL1ZrZGRxM2RFcW12L2lUL01veDJaZGdKYzhk?=
 =?utf-8?B?MWRSTTBtd0ordUFaNDNhNkZkcnBBNlM4TW1VK2JueHhqYXAzb1lWNzExbjhW?=
 =?utf-8?B?TnF3Um9vQWpzeTJROEY0bGwyNktHZXFHMERPQVYxZHkva3FLQ2x0cGoyOUo1?=
 =?utf-8?B?WWgwWXJTaUlzT3dic3ppL0xPTlNtSVFMZ1pPY2VqcTF5MFdNWVhReFlCK3J0?=
 =?utf-8?B?bGRhVEhyZEpUQ1BjSW1wOWJjRy9BcFlxRjVZSldGRlFLMnVTQ2JJdmFSWHBq?=
 =?utf-8?B?V0djcFNQRUxqejBtQzZtcS96cW5BTWFnd0tBMi8rTUxkNVExTGVRbDVSVThU?=
 =?utf-8?B?dk9UNHpwYjVaY0VOSS9xeVBNUmFEanB5SzFRS2ZERTlNMmQ3M2Y1UENrRnQz?=
 =?utf-8?B?ZzBNQlRaUXpUM3VJVk0xYUxtd1k1d0xEQ053aDJoWTBXaHBLSXo4bE5yZzh0?=
 =?utf-8?B?dVVCbnVUaEpMcnhRMHFKQUdKcWdCZ2lSUm0wVmIrM2I4WWJGREpjZ3NuU2tt?=
 =?utf-8?B?SUJIQ0ZsNEdNdUdWVG1BWnVMWjB0UTZhUG5hQjl4WHBEZVQwdzlVeVVxc2Y2?=
 =?utf-8?B?OFFjbWg5aURld3VHOHNyWlVoYUJUb0NJOFl0b3VzdFRvQ0R5Vm1NVFQ5a0FN?=
 =?utf-8?B?eFdWOStSTmZ5SFZtZG9hN1dLL0xqamhMR092bjZhODA4R0p3aVBrUGxEemt1?=
 =?utf-8?B?SGNZVWU1NnlEd2dkNmI0T1Btb0dtbnZLK0NWOHhXSytTN2g1SXdIc0JQc0NG?=
 =?utf-8?B?bHl2MzYyQlRaQkVDRi9FamdqWlJxd1h1bHZUa044d21xUUI3L1hONUF6MjVl?=
 =?utf-8?B?ZDJNa1l0RnorK1V2MW5XMVdCK2RCSmJ2WXlWQTBPd0U1MTZ0L1VSVTR4aHpG?=
 =?utf-8?B?VERQSnFKOVZsa25tb3NQMEcvYjQ5ZXpNY2dKTlN6UGVzUk1sWVo3YjBaSjcv?=
 =?utf-8?B?ZEE3eVlrdWlPL1Zuem1QdGFiZkprbnArTkxtUUttMG5tcTF6RUEva1pDSlkx?=
 =?utf-8?B?Y0RRK2F2MUh6SjVQR0RDa3NaSk1OaWtIN204cVQzNXNNYzlFMmdvWTAzQ3Z1?=
 =?utf-8?B?bkovZWRiZURLRVdMOWlaUUl6L2xKUEZhdUJnZXM3eFFuUXpMNWRRWGxwV3ls?=
 =?utf-8?B?ZVoxTHZ2d1Zha0xEZXFBU1hDL1p6am44UDdDMVY3QWgwbnA0VUlvQUs2VTR5?=
 =?utf-8?B?VkFqWDQ2cWFlcWxtYUNPZVIxN29RcUxJa2lCckcwL242NFBGK2FnK3ZVOXFk?=
 =?utf-8?B?RUFPNzBIeXVhSkRjUjdlRVNMckcvOUUrTGlsVmVQQ1dYc2IxYzBHMytoSFhO?=
 =?utf-8?Q?gPTaNh0ws+4i5MSsM0euFfQRp?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d3069b3a-5415-4b27-c039-08dcf4528d73
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2024 17:37:37.7369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xzZ+fFqpGnNo4WAy7tlEsYI5bOTib9ogF7FkYJPfIJ7pX+0FWmJg+T8KEna4c9fiiuSFvELtzx6zY/dONdEjfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6429
X-OriginatorOrg: intel.com

PiA+PiBTaW5jZSB5b3Ugc2VlbSB0byB3YW50IHRvIGtlZXAgdGhlIGZsZXhpYmlsaXR5IGZvciBh
IHBvc3NpYmxlIGZ1dHVyZQ0KPiA+PiB3aGVyZSBwZXItZG9tYWluIGlzIG5lZWRlZC4gVGhlICJh
dmFpbGFibGVfbWJtX2NudHJzIiBmaWxlDQo+ID4+IHN1Z2dlc3RlZCBpbiBhbm90aGVyIHRocmVh
ZCB3b3VsZCBuZWVkIHRvIGxpc3QgYXZhaWxhYmxlIGNvdW50ZXJzDQo+ID4+IG9uIGVhY2ggZG9t
YWluIHRvIGF2b2lkIEFCSSBwcm9ibGVtcyBzaG91bGQgdGhhdCBmdXR1cmUgYXJyaXZlLg0KPiA+
Pg0KPiA+PiAkIGNhdCBudW1fbWJtX2NvdW50ZXJzDQo+ID4+IDMyDQo+ID4+DQo+ID4+ICQgY2F0
IGF2YWlsYWJsZV9tYm1fY250cnMNCj4gPj4gMD0xMjsxPTkNCj4gPg0KPiA+IEdvb2QgcG9pbnQu
DQo+ID4NCj4NCj4gV29ya2luZyBvbiB0aGlzIG5vdy4gV2FudGVkIHRvIGNvbmZpcm0gaWYgd2Ug
cmVhbGx5IG5lZWQgZG9tYWluIHNwZWNpZmljDQo+IGluZm9ybWF0aW9uPw0KPg0KPiBUbyBtZSwg
aXQgZG9lcyBub3Qgc2VlbSBuZWNlc3NhcnkgZm9yIHRoZSB1c2VyLiBVc2VyIGNhbm5vdCBtYWtl
IGFueQ0KPiBkZWNpc2lvbnMgYmFzZWQgb24gdGhpcyBpbmZvcm1hdGlvbi4NCj4NCj4gQWxsIHVz
ZXIgd2FudHMgdG8ga25vdyBpcyBpZiB0aGVyZSBhcmUgZ2xvYmFsIGNvdW50ZXJzIGF2YWlsYWJs
ZS4NCj4NCj4gJCBjYXQgbnVtX21ibV9jb3VudGVycw0KPiAzMg0KPg0KPiAkIGNhdCBhdmFpbGFi
bGVfbWJtX2NudHJzDQo+IDE1DQoNClRoaXMgYXBwcm9hY2ggcGFpbnRzIHJlc2N0cmwgaW50byBh
biBBQkkgY29ybmVyIHdoZXJlIGl0IGNhbid0IGxhdGVyDQp1cGRhdGUgcmVzY3RybCB0byB0cmFj
ayBjb3VudGVycyBwZXItZG9tYWluLiBNYXliZSB5b3UnbGwgbmV2ZXIgd2FudCB0byBkbyB0aGF0
LA0KYnV0IHNvbWUgb3RoZXIgYXJjaGl0ZWN0dXJlIG1pZ2h0IHdhbnQgdG8gaGF2ZSB0aGF0IGZs
ZXhpYmlsaXR5Lg0KDQotVG9ueQ0K

