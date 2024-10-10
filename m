Return-Path: <linux-kernel+bounces-359526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0772998CA8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 18:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CEDC1C226F3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 16:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637F41CBE80;
	Thu, 10 Oct 2024 16:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i5qm1kua"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211856FE16;
	Thu, 10 Oct 2024 16:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728576169; cv=fail; b=buKV36m790I7UQDn4Miq3KoQ2R7PdI8HVncgfZbXFGOpKExBrl3cKO6bnCzAoVrS4DwDXfwzympbrjdpaCrFDAxJEBR8IUOaOtkoBzT4Ji6ssKIIaKfq9ne3NuHevvYjKuyOyiGaK1Mv9h+gGibJmEPY/1fK4V0wrOiQ3471ENc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728576169; c=relaxed/simple;
	bh=l6OMm9L5CNt94DYmKmRJ+hecvPDb6KWX8B9ZW5OIN2E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FAeKE5SI7Eg356Xbzmtp3Vn/lUESkbQZOyVlASaIfdloK8nDZaZN8crlxW1/dug5HxqtAkGzvWwR7QgjFdTgHaeWy+0MHWOx9ng5GpeYguMK3kZvv+R2EbzHYC2tWYr65Fm5ko6SkEUPUOuBtEl1sKSIirHNWmwTWo0Sgjohcr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i5qm1kua; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728576169; x=1760112169;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=l6OMm9L5CNt94DYmKmRJ+hecvPDb6KWX8B9ZW5OIN2E=;
  b=i5qm1kuabvED87BPT9BrwJbI+LWFEExwfGwkEwmnIcm94hbma8EmTl81
   XIfkWQY5f55Uup0YsHbcKhaz73GjWhq+Oo5zMUincfIRuBfHOvPpgLTqC
   np/AIe/HYop24elcywV39qNFP8wrqMf5h3KJcJOEwnv6UwOD+Xdd5LhY3
   tfsy4T72iTbtGdw+GQHlsAqsQTK/SPTFYEEzPg2x64PMvsjK66+GBQZXp
   rPnitI9Y6oUOoPTQHpSV+bcXu7LBS85Ke0CEZ28AGlQ4DukG9kblKz7Kx
   NRhc04bqIAnd16TbKw+NeRLTp++LUWQDijnL6U3v3I/4V8q190iRFWBzj
   g==;
X-CSE-ConnectionGUID: oey+Ud1kRT2V+L6DMU85Yg==
X-CSE-MsgGUID: AjkzFJF1R2K/aLSDI5HGKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="27841676"
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="27841676"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 09:02:48 -0700
X-CSE-ConnectionGUID: aIzGQpf8TPGboE4LM7jd5Q==
X-CSE-MsgGUID: N4nHGmjKQ7CIehN9vPaXcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="107362860"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Oct 2024 09:02:47 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 10 Oct 2024 09:02:47 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 10 Oct 2024 09:02:46 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 10 Oct 2024 09:02:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hxo7H3ZwoMV1RNrxNSS5YdpIPeOm2aNvgNW5JzkTgX2okvD/+qV7xu9GaYFy9F5TsW+za+SW4p4wdC2aKGszv66jbQdD6l2vGkB+nau4+Xl7G34Emv0WJaJ6frX3iwyQ66MMwkLA3HNuEFj13mOB0k4aJ/bKYkhoVnM2N4ekPNgJ1C81VGsA8C314UeEEgOH8URmiqVXPI3DX1D/Zc/9LzMbxJl65OX6O4iO9RYwqIwNxWKke+y8nwMsAIe4SchugHPJEhwfjo//BW9YIlNDPgeQH0Z1omr30NYV9scRLnhdO5714ipcsQyDTRIAQFc6XRo9csw7ZqNj+QlYndNFNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l6OMm9L5CNt94DYmKmRJ+hecvPDb6KWX8B9ZW5OIN2E=;
 b=nypGskazWovyK7LDS0Ge/ZZe8EIZSHxK3QWgErbCOulH2s1X4HAlGpt603z97QEbhDGR/HupoToYnVcGKSxghH4JnMW8XkNdNdWK/QlWdwWDgKIpTuWFkcx4IfKx865a6m3ZT+AD67p1Yckxob+hFuPsdv5uQvhch3iL0F4hLEuhsIE0BWWgGJJ2LAB7CBMw6hbA0bgAmVc9++xS6/Xp92+M6WgNmbMLn/kMLuKcfrCVQDcIsvrqHKcLSWmwsO2syVYDXz4sqpMdK/6GOjpOr+5qnZqJNRlE1rvVE4Vf6uH+GtnZD0DWcb55HySIzbiqI+A2uQWxWXg80yR0RKC3iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DS7PR11MB8782.namprd11.prod.outlook.com (2603:10b6:8:253::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Thu, 10 Oct
 2024 16:02:44 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%4]) with mapi id 15.20.8048.013; Thu, 10 Oct 2024
 16:02:44 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "babu.moger@amd.com" <babu.moger@amd.com>
CC: "corbet@lwn.net" <corbet@lwn.net>, "Yu, Fenghua" <fenghua.yu@intel.com>,
	"Chatre, Reinette" <reinette.chatre@intel.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "rdunlap@infradead.org"
	<rdunlap@infradead.org>, "tj@kernel.org" <tj@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>, "yanjiewtw@gmail.com"
	<yanjiewtw@gmail.com>, "kim.phillips@amd.com" <kim.phillips@amd.com>,
	"lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>, "seanjc@google.com"
	<seanjc@google.com>, "jmattson@google.com" <jmattson@google.com>,
	"leitao@debian.org" <leitao@debian.org>, "jpoimboe@kernel.org"
	<jpoimboe@kernel.org>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>, "Joseph,
 Jithu" <jithu.joseph@intel.com>, "Huang, Kai" <kai.huang@intel.com>,
	"kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
	"daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "sandipan.das@amd.com"
	<sandipan.das@amd.com>, "ilpo.jarvinen@linux.intel.com"
	<ilpo.jarvinen@linux.intel.com>, "peternewman@google.com"
	<peternewman@google.com>, "Wieczor-Retman, Maciej"
	<maciej.wieczor-retman@intel.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Eranian, Stephane" <eranian@google.com>,
	"james.morse@arm.com" <james.morse@arm.com>
Subject: RE: [PATCH v8 07/25] x86/resctrl: Introduce the interface to display
 monitor mode
Thread-Topic: [PATCH v8 07/25] x86/resctrl: Introduce the interface to display
 monitor mode
Thread-Index: AQHbGyRlovSriR6pykSdEbFsw5Xe4bKAFJqAgAAHzoCAAAhh8A==
Date: Thu, 10 Oct 2024 16:02:44 +0000
Message-ID: <SJ1PR11MB6083701FAFFF775035F8DE91FC782@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <cover.1728495588.git.babu.moger@amd.com>
 <dc8ffd9074123320ceeecdc8e0b36d1ac0780e02.1728495588.git.babu.moger@amd.com>
 <ZwcG2e90vXHlIVan@agluck-desk3.sc.intel.com>
 <4da658fa-3cea-4388-86f4-d4b0fb5f0903@amd.com>
 <SJ1PR11MB6083410D8FF053823F0BF884FC782@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <71c79023-d39c-43e7-abc7-057864508edc@amd.com>
In-Reply-To: <71c79023-d39c-43e7-abc7-057864508edc@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DS7PR11MB8782:EE_
x-ms-office365-filtering-correlation-id: 843e6d23-0ac7-4533-abdc-08dce944fa00
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SnpkeXdOa3VxNVFwVHZJOEpuaDF1c2QvNTRCVENpY3M3dEhPSklYeDljdENv?=
 =?utf-8?B?TkVJcE41Y0M5Rm85eXVTWU1yYjZNV2VRNGpVbkFraXFueTgwQkhLejhvcWxv?=
 =?utf-8?B?MGRqQ1hncGJwc0o1MzdBQnJ0MU5PV25OcUhKVmpVWnpJQ2YwZGRROXJqWXhp?=
 =?utf-8?B?STJtK1BiUk5LUFBFejhUbDNFQ0FSL3g5UGMyTTNleUh2bzJpOXV1cW14b0JG?=
 =?utf-8?B?bHE5YUY0VkNOWXU1TlByT1gwN3hhL2tlV0pSUXNrRFJDVHVtdXlZWjh6WlZq?=
 =?utf-8?B?bHdBOWljSHk0UzNNOHJpVkt6cDZWM1BJUlFld2Z4eTExdUZtYlJxS3pySnJB?=
 =?utf-8?B?bjVRM3dGZ01odTVFZmk2Y1NnaHd0T2JNMDZOT0JsbXordTVtMk5qMDV4NGUz?=
 =?utf-8?B?K0w0MG9iQnhieWxweHhxYmRmSkt5Uzl6dmxtaVBaa2daUnF6eFhaemtZZUJM?=
 =?utf-8?B?QkxtdWNiTmk1d3pxdnJHSGI1YnJTOWQ3NlVrS1ZydjhUcFZ0Yi9xa3p3MkJX?=
 =?utf-8?B?bWZUZ0dOL0xLMDhmckxXbnhOQVRndjdzVUxCL2J2VHpFbDZka1FxNzRUK0Z0?=
 =?utf-8?B?TFlHU3U5Z0NZb2RzWGF0V1l6WXhJNVhhUDY4b2twaGJnTnFNZkF1cFdBQ01t?=
 =?utf-8?B?ZEx6OFRycks0a20vVHh0ck8rcXk5L2dsYVR2S2VZRDlpNW85WWRPMVJBdFZh?=
 =?utf-8?B?cWhzVzBRTEo5UDVLRnZLR3d1RVhObzlEQW1QRTQwcmxwWEF2YmdaR1djbGFL?=
 =?utf-8?B?OS91QlpiUnRtU2NqRHpaU1BKdVB4c2JZVXpRMnR3WUVFOVRJOFhFdWF0SkZk?=
 =?utf-8?B?eEpnRVd1RUdvVzFlOTVnNnlUNExFdENTNjFmQy9ROGtVWUc2T2VhZmxxOXZz?=
 =?utf-8?B?WFJQdVp3RUNZazJ2YmFQc1FqM3VMVS9HV0htczdFWGRvaGxtRUc0eTdWL2pY?=
 =?utf-8?B?WVVzUDlnYmhvakdUU29kbHN3WlRpOE1JZW5VOU9DSjB1U2lCbHRidlpaRTlY?=
 =?utf-8?B?YWRwQ3JjVjRKR2ZuUlV6R0JWUVNnRG5SZ2N6eTFUd1FxQ3I2QVpxaElMRlZU?=
 =?utf-8?B?QVV3NHhuSENXcWlDT0NIeUF5SjlNbDJwckJ3TlVINTFUaXN6L2RXcFVDcGJZ?=
 =?utf-8?B?cHdqTHNYYnlkdTk2ZTMvRzl2M01KUlZFNWlkMVRzL3NzUGtNSlRuelJ0Rm5h?=
 =?utf-8?B?TmFPeGhBZFBvSGdxODRmdHh3eERHeFRTNWlva25PdSs3bEl3NVZiNHdrbTIx?=
 =?utf-8?B?M3BxamFNZnA3U0EvV3U4Z1REQ0Q3RFdsTUlxYlA2Q2lUUTVKZUJueHVQNE8r?=
 =?utf-8?B?b0E1eXp3UXB3UDVQYlpudU90WTM1SzF3cUJScURpVFpDTEpTZm1SVkFONkhT?=
 =?utf-8?B?Ri9sYmt4ZTZCN0tHdTErN21aRTAyWGRFQWp3WEtiSFRxN2RPZWVUaWxHVGNB?=
 =?utf-8?B?YzNOWDdHcnBvODVKZmhXVTU0UlhOcHRGclRlNWlxa0lzcm5OUlg5dDJxZ3dR?=
 =?utf-8?B?aXRoeDdRc0xSbHJ0WjBKTzdFYnEybUZsVGJTK1dvQlhCMHo5YUdkaXVsU0RY?=
 =?utf-8?B?YkNiaVZaS0c5MTlaWFltS0Y3ejF2ZzltZDI3WmRtSGtVbitXRkJYb1dMYTBV?=
 =?utf-8?B?K0dTVEJEcVEwMXNmZjlkVFRNTkdteExDa2s2K2lTRzdaL1pOR2lZbjFIQmtH?=
 =?utf-8?B?bUtRTzZlRytLZnV2RmhwVlVJYjRyTjVEcjN2RnhVekdoZ3llb1BuMk5NQlVo?=
 =?utf-8?B?MllqL2VuaG5jMFFVQnpaMWxMU2wwSWdKVzN6akxxeFZRcm83M3JMU2UwNFRG?=
 =?utf-8?B?aE1FdkVXelpUQ2xwb2lidz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWFCTFZRUjVKSGZuSWpCNG9XQnljekdxT3liM1ozenBKT3Mrb3FEazJPTncr?=
 =?utf-8?B?OGk3eHNMcnNGZ1I2NlZNamVIM0ZKVHQ4Wi9EZmpWWWpEY3lpSmM5cktYR2JN?=
 =?utf-8?B?ek5xZitBdXpJQ0FFYnVYYS8wNEVkQ1lyVHBDdDlNcEw4QUxsbk1XeGY2Vnlu?=
 =?utf-8?B?QzRtRG4yYXRHVzgxRThBeWpaMnJnNXVQM2FwNU1zaGFqaHBHSHFXZHQxNkls?=
 =?utf-8?B?bWZMSFA3bGtDMklDd0MvZmJBd1gyVWRWdzRtOTRYc2EvcXZzUzE3N0hxNWda?=
 =?utf-8?B?bUNiakVsVjFSRFlBdzRaZmFsWVJ0aTJKQUU2N0xUUkYvb3BoS2RxdUxZZGpk?=
 =?utf-8?B?NDA3ZVZyVEQ1NGpaNkxibCs0ak5tYUJ3TlZUNG1mWHRTZGJMVEErUFlzUldV?=
 =?utf-8?B?SUZXS2trdm94T0hKdHNlMStnek9QTGN2QjM0aWVwNXRrcGd0ZzZVR1ErZExV?=
 =?utf-8?B?YlhtWWNSdWtTdnUvVlBPTTVmWHlyTTBJWWZpN1FaejVPbFRQdCtoQ2ZVYXJW?=
 =?utf-8?B?QTVWRnplaXNYdlpYWmZLUUtwYm1zV1B4MitVNjg4K0JpS2luRXRXcTZkSm9C?=
 =?utf-8?B?TXNFVkxQcXBHS0ppbjlIZTVvTE9FSHBTd2lseTFZakdKQjRCTXRZc0RUVmFP?=
 =?utf-8?B?MzYvSGdBNmw4QVNrRTRyRkRRMUxxMDB3WjV6dUlycUt5RVBBTTRheFBXNmdw?=
 =?utf-8?B?bFRDOTJPQkRFTXpQZTJIZWtzaHlwZEdhNGR0MHNlYWhVV3hUbHh1WnM0SmNI?=
 =?utf-8?B?bzBWUk9WWUgyazdTckY5UnlPV1JoOWpFZVluYWhqT2hWNUxKTU9WaFBoRExn?=
 =?utf-8?B?bE5DTFJkcEtxd3NxWE52U2FubXZtcXN3ZGVOOFhNeVlLYWRmam5WVUM3QUpY?=
 =?utf-8?B?OEZBRnhEcm96R0pXTzd1WTRJeHFWZW9rWVAxSGFQVjh3ZTF3Zzc0bFNXZVZy?=
 =?utf-8?B?d1ZwaTc0ZFFEMG1ZUTNzSmIwcFp3L250ZDIyVFZJam1LVG4yUzN3U0REdSsz?=
 =?utf-8?B?c3R4SnBJeUQzdzA2OVkzWk1ZVWtYKzhUT0w0ZzJSQlFiUXhGbGxkZHAybC8z?=
 =?utf-8?B?NmZJZUJ0MUlVN1Q2dEZhNkpXckpXbEdtZ2ZwdW5kVzhwTmdpZWw2bWZpQVY3?=
 =?utf-8?B?eGF6YjdpVHBRUFZvQXI5NnF3c204NzJuckNOWkdxUkFvbmVJY08rZjlRUzF4?=
 =?utf-8?B?azZtcnVEQTFCem1HN056QUxUbmRCcS9uTVdxQkI4bUR5THpXTWwwUmo5Zi9H?=
 =?utf-8?B?ckROWmtEN2tOY3VMcXBtZkhoSDQ1QmJsblRTWlVNMWZWMmdubnhGdUF1QWpr?=
 =?utf-8?B?UTEwVFpoRlRTSkR1U0gzZTFGSEdDKzlZNkkxeWZVbUozODNBVVRKYWp5aEkr?=
 =?utf-8?B?SEdKSGtHSUVIMXRDaXZ2ZDkwb3RRRDdVSGVLUG9BNDFWYW5xb0dERmdMamRn?=
 =?utf-8?B?ejdZaHo1ZXdqbTUzdHJqTjFULzd5bWVVbEF0UEpZL0duNWNNeERGL01EcW1l?=
 =?utf-8?B?ZS9hR2wzMGR0NlBCd21iKzBVV0FwaE9WcGdFL08wc1p5SWsra0xlYmVIM2Rr?=
 =?utf-8?B?d2U5cHBhUFFwVHZCdHRETnVjclI3TTlVem5aTFVQTG1rdFR2dFJCKzhzSGE4?=
 =?utf-8?B?bEpLbk9iQUduM0c4aTJjQnJOemxkTm9BWEhmZUZwVmQ4aURrODdJYTFGT1o5?=
 =?utf-8?B?REhwYVcvRmw2NVJOdi9OWmpVVXpGTjVlTEhlaU05VEhOME95cGFaK0loL2ln?=
 =?utf-8?B?bFJaV0ovbU44bzJWYm0yVHN3ay9ucEp6aVFVVXFOKzRhZytMMjdwMGdkN1lh?=
 =?utf-8?B?ZEJ0V0FPaEpTdDR3d1BVL3JaMVEvTmYvenVMNGl1b0xTT2ZSSVRJeGs0SUdp?=
 =?utf-8?B?aW5NTXYzSjhmVE5EdUVnRmpMZ05HZ2xZSmpuT1ByVmtxcGd4dTNZSjJ4M1ZJ?=
 =?utf-8?B?RXlBTy9SR2xGaDIyZkwyTU5hSU82d215MGllOWlMSHhrMkRDU3R0SjA5SmJI?=
 =?utf-8?B?cnlxMmlHMkh2RDB4VFpLYm14aldvZEloZFNrcFRqY0xLdkl6NmNwdGpkdE56?=
 =?utf-8?B?aTd6bmtNUmlxd2Zjc1NPcG15dzVSS1VDM0JHQzVCd090QThMZGtpd1BPUThU?=
 =?utf-8?Q?P2YhISStmw7EH+WGoO1pCH/sg?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 843e6d23-0ac7-4533-abdc-08dce944fa00
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2024 16:02:44.0798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CLiHx7HOjX8ogboOno7kZHvuLo8UwE3bMLIDhY16meeuT0aqIF+AoUK65I4Qq6ialJE565NQQgYP3bxApQBl0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB8782
X-OriginatorOrg: intel.com

PiBUaGF0IGlzIGNvcnJlY3QuIFdlIHdpbGwgaGF2ZSB0byBjaGFuZ2UgdGhlIHRleHQuIEhvdyBh
Ym91dD8NCj4NCj4gImRlZmF1bHQiOg0KPiBCeSBkZWZhdWx0IHJlc2N0cmwgYXNzdW1lcyBlYWNo
IGNvbnRyb2wgYW5kIG1vbml0b3IgZ3JvdXAgaGFzIGEgaGFyZHdhcmUNCj4gY291bnRlci4gSGFy
ZHdhcmUgdGhhdCBkb2VzIG5vdCBzdXBwb3J0ICdtYm1fY250cl9hc3NpZ24nIG1vZGUgd2lsbCBz
dGlsbA0KPiBhbGxvdyB0byBjcmVhdGUgY29udHJvbCBvciBtb25pdG9yIGdyb3VwcyB1cCB0byBu
dW1fcm1pZHMgc3VwcG9ydGVkLiBJbg0KPiB0aGF0IGNhc2UgcmVhZGluZyB0aGUgbWJtX3RvdGFs
X2J5dGVzIGFuZCBtYm1fbG9jYWxfYnl0ZXMgbWF5IHJlcG9ydA0KPiAnVW5hdmFpbGFibGUnIGlm
IHRoZXJlIGlzIG5vIGNvdW50ZXIgYXNzb2NpYXRlZCB3aXRoIHRoYXQgZ3JvdXAuDQoNCkJhYnUs
DQoNCkxvb2tzIGdvb2QgdG8gbWUuDQoNClRoYW5rcw0KDQotVG9ueQ0K

