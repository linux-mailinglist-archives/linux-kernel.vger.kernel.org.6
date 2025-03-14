Return-Path: <linux-kernel+bounces-561159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62146A60E2A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E32717A4E0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E8D1F3D3E;
	Fri, 14 Mar 2025 10:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DLTPeUBU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25511F30C3
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741946713; cv=fail; b=Viiq/B2vi5wM1zsZmI/m8pwwOvxOOUXVfApMoUA3eiOGb82mophbVjIkxD89fmsvMEQUinwMl7ctvADWQkUCRKP6sjHnn3/1G/24aKdyvdpSs0cRH1JyTLQAQcuEcJtxav53zkT0GnWXmzsaXBY3d/cYd90fhvaaohvIlM9rwbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741946713; c=relaxed/simple;
	bh=f3Ps0Mo5WzI3sTF9LcwAoa64hAoFQp/34eYI4FQyc+o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ro5ugBaRp3sCqNFUuGWhwRbXWpDmtopwDOwV6Gj2iKo5VXuw84M3x6RAFQBrfFw/tTouqeggb0AHkNRJdxgE6UAosigKBCNYoAiSnu2fA6QjI2dw0+oIVX8GFl7Upda13cFsoG5BhGGKCcpZSqFqgFngnD6EwfXaXwJJ1yyiUtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DLTPeUBU; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741946711; x=1773482711;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=f3Ps0Mo5WzI3sTF9LcwAoa64hAoFQp/34eYI4FQyc+o=;
  b=DLTPeUBUGS8AdPH2LZyaj+qR9QwOdQsGrGZTWlLdoumOU6mt8L9NNSyl
   z7AIECYTOUycvx38vDgC3r9lxII/89e5NXURdd4JLyDrbCDLJwitOBa+M
   LfhT/y81RwgGrXM5PhaxHt5qe7lh3zTpQjpLB8srXphvm5aJIWnznK6ln
   00T9TCoVjfUSHnWM8CYV3P+CjzQO3tSyBCzbu6lfUD/IMyHUIvNK5WTHQ
   veq7Tu1GUQNPiazGCW25q3gK6gMMv2rjV6iMRJh1kor4S+VykNya8WjWB
   xrdqiRPhbXa4H+kwMMdON4Hgn3vc9DNKqQOUaqQL1qjH7RkYlzGLB75Ff
   g==;
X-CSE-ConnectionGUID: n0jmg67jTb2/L7pfDQQtqQ==
X-CSE-MsgGUID: yaF2cUkhRFKXcXnKnr8ZiA==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="43302295"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="43302295"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 03:05:08 -0700
X-CSE-ConnectionGUID: Jx7ilVvwQ7+3sxsTeLLPOg==
X-CSE-MsgGUID: O8/8nv7sT4Opwt6iFYAMAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="122148406"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 03:05:08 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 14 Mar 2025 03:04:59 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 14 Mar 2025 03:04:59 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 14 Mar 2025 03:03:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SGPXibfRJd2q5e4oblRLzongANRAWvkNpWCXsbvdWCoS9kHd3QsEMHsuRHeBwlE2hwfz20drikE4hSg9p7m5QWQKm92c9NlS9jyCd1IsB4bnmXMZk3p4HomtVvPU4OI218qyiU9M5jsVceyUybsVuWyeWGlSxSLiydShpJDBSK+wwx0jlvu0xl1WsS3tMN2eYWb3lDXiGUVubijolYH+5S3D7RmR/Nh8UOAlwtcSoYxtTbkL1qk0yf7p7EkQtes+kOnmskZm1CzlhUVnQufv1mPgrbnZaywazABgRAlwPmA+A+FeQ4/6jA5mKqeNb+jtOMcXJF94rWX9bVtFzaUI1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f3Ps0Mo5WzI3sTF9LcwAoa64hAoFQp/34eYI4FQyc+o=;
 b=B3n9evhWwGvhY/KP/NvULXzawn4X1a/kypPmqmsaTxcAwlKgfJncqeuTIMHI5+RqmFtQi+dfCKO8dK9ej0QCf1s8HrClSRZu6iQv/MqFp2Fi1sliLGLzhrUWMK/wXn1bwutzxw8rzBLKZVqPWCC9R+ueRhhvNb1m2MIgiEA3FpImPC9kRnaavjM/vTGgOugQzcUHtQnoq7cI0yD0szB0fUBzVVGYBB+fMPjRjcI48s4a6xM60yuuVXgoBM53xbDsnIl9TXAj77nDxVQGJbiywUWEcyQ3nKE/vxnXgkGcZ50WJRAwcAL6X0M7ZibBviuxDRMJOSECVIA7z1dHwnHTrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SN7PR11MB7512.namprd11.prod.outlook.com (2603:10b6:806:345::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 10:03:13 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%6]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 10:03:13 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "tglx@linutronix.de" <tglx@linutronix.de>, "peterz@infradead.org"
	<peterz@infradead.org>, "mingo@redhat.com" <mingo@redhat.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"bp@alien8.de" <bp@alien8.de>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>
CC: "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>, "dyoung@redhat.com"
	<dyoung@redhat.com>, "seanjc@google.com" <seanjc@google.com>,
	"x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "sagis@google.com" <sagis@google.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "Chatre, Reinette"
	<reinette.chatre@intel.com>, "bhe@redhat.com" <bhe@redhat.com>, "Williams,
 Dan J" <dan.j.williams@intel.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "ashish.kalra@amd.com"
	<ashish.kalra@amd.com>, "Yamahata, Isaku" <isaku.yamahata@intel.com>
Subject: Re: [RFC PATCH 1/5] x86/kexec: Do unconditional WBINVD for bare-metal
 in stop_this_cpu()
Thread-Topic: [RFC PATCH 1/5] x86/kexec: Do unconditional WBINVD for
 bare-metal in stop_this_cpu()
Thread-Index: AQHbk0Lbd/o5JJJNyk6v5kYhZVWKCrNxaCuAgAEB5AA=
Date: Fri, 14 Mar 2025 10:03:13 +0000
Message-ID: <37b8fef5a0a77bbd2452be486d4cc4f463cebacb.camel@intel.com>
References: <cover.1741778537.git.kai.huang@intel.com>
		 <e9ee3c7ffc3ba6feb97247faa40789684e39ffd0.1741778537.git.kai.huang@intel.com>
	 <e0d9a3d599025c92fce5e159e8acc1af32844912.camel@intel.com>
In-Reply-To: <e0d9a3d599025c92fce5e159e8acc1af32844912.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.3 (3.54.3-1.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SN7PR11MB7512:EE_
x-ms-office365-filtering-correlation-id: 38694d1a-7c54-44dd-b6e3-08dd62df6ed1
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cTNhSFlmOHEySk5uaFFST3FFTC9Pc3ZKb2Y5ZXg0RXlyMklMaXVJY2JsNlFq?=
 =?utf-8?B?aUFlc2FWL1E3VW5mNmhFTnhWTnkwVGp0Ylpqcm9jMU1VM0FPMDQ0dEFiNy94?=
 =?utf-8?B?WGROamMza3RLOGR4ZDltWGtsZ0ZJT29WcjI3KzZOWkxSWWN5dHJ1THpmTzI4?=
 =?utf-8?B?Q3JaR0xKK2t2UFAwbEJZVlVja1FHaWZLNEU4dWhxcWdyN09zcmk1Y1ByU09R?=
 =?utf-8?B?VkJNSDBadjhndlppNStVRXpOWTYrYUtjYVl6RUZLUjNKYVhWb1RFajNpUnpO?=
 =?utf-8?B?eTRyT1g4ZUlFblhISkN2bXpSc0kzWElheU0wdEdvK3ZhOXJQZVVhZkVWUzJE?=
 =?utf-8?B?Rm1XOFBaVFZCUGNDdUtJVzUreHVEbTZraXZoTzhLeFJTSmhLMEhROXcrajJG?=
 =?utf-8?B?eWFzVjN1cy9OdTZiVWg5OTh5WnczV3RZa0NiVGpLMUhEU1l4MThtQldncFNq?=
 =?utf-8?B?NFp0eXhYOGp1amxTZlQyVDRHQ0dRc1V4NG1vdW92ZnZVY005eGRTQitmQTJv?=
 =?utf-8?B?NURkTGtLYjJ2TmxWakRBazZJYXorWE4xMWlFVEpVN0pvWENNeEQ0Qk9nb0tN?=
 =?utf-8?B?VnhqQzdkUjhPOENNRWlIMk45a3lPVC84UlNNYzJvUXMyMGN5a21GVlZ6Q3V5?=
 =?utf-8?B?N3pRblVwQjRSNlAyaXEvb2VBVWNEWEdxMU55dlJ5MlZiUENBNVlqWTFIME4y?=
 =?utf-8?B?U2EzTGdrbjNOdEdoYWJnUTBtdWRVd3V1eUFnenRZYlNzNWg2QTRFaXBGd0ZR?=
 =?utf-8?B?Z2Q3SS84cnY5YnJDMFhSblVUZ1VxQ3BWMWJrVktCZEpsdkJFMXc2dis1dFpQ?=
 =?utf-8?B?UHhtK1RMYzl5MDBRb010d0pXQnNIMldRVndlcmd3b2VyY1ZhWG5FT2ZYSzQw?=
 =?utf-8?B?Y1RzOUFYc3RyTENGc3Z1ajl0NlpJV3lwQ3R6Szk1REN2VFA2NkpFL0NoRjBi?=
 =?utf-8?B?bWxGTnk1YTUrSThOZDI0Z0cxMFBuWkpYaHYrL1dCbkVlQkRXakkyNlpackJQ?=
 =?utf-8?B?dkZIemdMOUp6a2VPZDBISEkwRGQwQ1V2Yk9EeGRGOUM4OUgzVTd4NW5BOFda?=
 =?utf-8?B?RzU3ZlFIRzBJVEFmSU8zQmZRTkpqT092ZlZ5b0VvYzM2UzRGcnpFekJHTmwx?=
 =?utf-8?B?ZlR1RUxKY01rNDJDSWE4WlBBMGc0eGhtOEtIV2JZSGtSQjczdTMxQUtaU1Nm?=
 =?utf-8?B?a2p0MFhqOFdNd01OV0h0ZjVmSjY3Z1VnL3pHNytvVW82UThMNmxkVnRIbXkz?=
 =?utf-8?B?RXpwZTVWdFpnamRoTER0bjBVZ1IvU0VGaTJiN3ZNWmxmL2RlV1VmWWdvUmpr?=
 =?utf-8?B?aVhyeFBwdWZlSlJndnFpUXI2M0h1WUlaSExVU1lPb3BIZFZsVHBZbjhNNTZR?=
 =?utf-8?B?Ky9nK1E4MVUzY2xraDJ0OGI4OEM2dm1TWVNiMlQ2RUNHcGNCSlNiczNJclNt?=
 =?utf-8?B?c3A1Ly9WcktSMENyWmhwcmhRUTk3dVRDM21aV2l1YWRUMWxzV20xR0tIL1dk?=
 =?utf-8?B?cWNCQkNyN2ltU0ZmK3hkOEVOMm5rTFQ3REpGSk9lbXAvbW5Vb3BUUmFxcjZk?=
 =?utf-8?B?VDVjUEhJNkp0Z2NOTG1DRFdIUDhUWlE5QVZ0N3JZMUgzVGNyMVVqc0JtSlZk?=
 =?utf-8?B?MFpDazRZeUNZamxOL3gyWi90bXVTZTFlb3I4empVdFB5OXB0cHdzNk1XNVlw?=
 =?utf-8?B?QzhWUVlZWVRMNTZQcjZTaG81aUUzQWtGTGZSMFlweCtmZENGanNDY21lQ0Rv?=
 =?utf-8?B?cVVCZDhmdmcyZkRLcXY1NFh2Q28rOE03Z2pLTzBNWTlOS1gwTVJVSEllZ1oy?=
 =?utf-8?B?MnorMnlLTjlFb3kvemJ6N2FkUGJXczNvTXUrT0VWVTY5bks4WUxPUkhxS0ll?=
 =?utf-8?B?aFk2RGVxdmw0akEvQnNSU1NZaE96NmJxdWF6SENWdE5VVnRQSE1mK1M2Ky9u?=
 =?utf-8?Q?F45FeasxnJGE0ZY8xH+Ck25iyJ+u0MW/?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFlDY2txUDhoWkJmRXFkT21CZ1Z2Szh4cjMvZTdTNmwwSHo5ODJXb09XZ3k5?=
 =?utf-8?B?NXlvLzdUV2ZBQlZSZ01iaTFiZjJhem41RzRFaVZ6WUorejJXQW9GSVBUUkph?=
 =?utf-8?B?R0l5c0ducmVJMUNzZEVxN0ZKcDRNQlJQWkN4cUhMbEMzWmlzcmtwNnUxclRx?=
 =?utf-8?B?K28vR0xReTBUS2hpOTJGV0FFdzU1VmtTd0puWk9jbUdhY1NSdzdCZjAzRW90?=
 =?utf-8?B?RERtamMvcm5HK0JmTzdZV2hQQVp3VUVEbW5nL1I3VEM4Vmp3SzYrR01EdnJV?=
 =?utf-8?B?L3JpVXRtK3ByQ0NhcE1NZDJkNmtHNHRock0zL3AzcXZsTXRzaS9zdHQzc3ly?=
 =?utf-8?B?SEdCcVc0anI5QzVzMzgrUVZFSDN3Nkh4cHh2YkFnMytVclFVbmZoT1NSNWxP?=
 =?utf-8?B?S3VJS1FGU0FqcUpoRWNaRVlkL0ZXbmN3a0hONHdUUW9sZENkeEE0ZjZDVUJo?=
 =?utf-8?B?aEROME5WZVltNHBqR0dlaWE0SVVTeEhlSHNoNXJCTzd6Ylo5WklTRTdnK2k5?=
 =?utf-8?B?WUR6bzk0YmlrNnBCd1JNTitiay9MQUdiSE9YWFZpSThSYVNvQStlMi9MK045?=
 =?utf-8?B?UG94Q3Z4dXR4R29MakREeTdRYzNLS1ROR3BWTkhQMCt4VnRlTE9zYVdCVU1Q?=
 =?utf-8?B?N2pRaEFxQmJxTlRJZTB1WUNHZkdmb042UkE0UjFyNVpRWnUwK3NsbWRXZ2tH?=
 =?utf-8?B?QmlPSmJRUndnTVl6Q0x1UlVGWUFHWXVjRjgzT0laMVVQZnVtMWNNcU1sNjZI?=
 =?utf-8?B?WEUrUVZvb0JCZ0hTMitIZytCd3pyQk1Qd09MQWJ6RTBxWUVYZm1wWDBXdWFr?=
 =?utf-8?B?VWFRK2hDUittWUIzL0xFRld0NkZzTDhMbCtZTVJ6dW5kZmxNaWU1dzZpQVJn?=
 =?utf-8?B?ZmM4WjNEb25WanRSVVZPc2xrenVoNm5ablMvN05wTURvSk5aUDhyelFZenBv?=
 =?utf-8?B?ZlAyWVB6dzIwb2JTTjh6QkxKK204Rzg1Uk1adjBEak9jaGJqN1gwNGRPTmNN?=
 =?utf-8?B?d2NYazZNYXJOSXNpVk8xRFJ4RTQzVUFQUVlYQUNoNVd6dnlDMTY4bHNrYmpQ?=
 =?utf-8?B?K1Z6Zml0RE91SkVBeVFIek8zU3dEQjRHTWhPQ2lycUlnaDR4R2xzU0xxZGtm?=
 =?utf-8?B?MjlTNkR1eE9KT2N3czhPYm50dCtnell1eVF3dE9hdTBVakxRei9DUzVCTDBo?=
 =?utf-8?B?K1cydHNzejlQTFZ6NlRyNk9aTUxOR0luQ1NqTGZybVU1dnJlUExGWWdRQ3dJ?=
 =?utf-8?B?NXVjVUdZU09tWXpGSXpUcXlGckFTYSs1VS9UV05VSldCR3MyR1dVUWI2SXgz?=
 =?utf-8?B?ZVJpQ0k1dGdPcm5RRGYzY1ZpMkR2VVNweW54eWdnODdWZ1lTWWcybjkwakg0?=
 =?utf-8?B?bHUyWktFeWRIQko2eDdUc3hSamtUUUJYRndyYXBxd1Y3blY0Y0d4QVdZUE0z?=
 =?utf-8?B?RHo2OGZvdmZyWDBNL2NNVDdtWCtDOHBYN2hYcG01aXNYZHA3Z2dwMCtoQm1H?=
 =?utf-8?B?emJ5bW96TUFlU1g2dFdXdytGRGxXZnF0ZUV5R0pHcVF3S2ZlekJDMFBGZkZj?=
 =?utf-8?B?eUhtbHhtekswUCtVQm1VV29hVWhML29CQnVMRzZwZG9YUjZWcGQrOHBpSVhY?=
 =?utf-8?B?VzJqcWJZbE5DcWgvYTY5aVEvd1pmM2UwbHgwUkhuZFlQcGgvNVlaQlJOTTlN?=
 =?utf-8?B?dVJraldneHM4blFaZnBuVXlpWjlkL0hwUHh6OXpyZWhQQUl5U0xDSisrVHBC?=
 =?utf-8?B?L2VGR3RzR0QrMUw4ZTMwNHlzSUdyVkRlcGFHQS9WTnBYMTJMTVJNbEh4c0tC?=
 =?utf-8?B?cUV4dWlvWjJXUUtvcWN3RElRMkJWNWpqZDVHVXZyenREZzVvOEdUQVJuTlZS?=
 =?utf-8?B?UjFJZkFHd1BaSGZoRWl5bExDWWxsUzBTTHVtOEUwOXlpSHYvZ2MvVDN2WkdI?=
 =?utf-8?B?QlhCM3VWdU1mRVFsME56Tmljdmc1dEY5SnQyNTNIb2ZQUklpRVQ4Q1NGUHVl?=
 =?utf-8?B?TFZCdHhMa2kwQUdYdWFvMXl4RVZqbjZnSXdqTlhwbHZJcWVhUUo5UGdOaHNF?=
 =?utf-8?B?bEt4UWt1d2JiZjBzOXlVR0huYmpYQ291UzM0VzdMOVd4c3Q0a3ZuQUFRV1l2?=
 =?utf-8?Q?7+QTniYCPacMCzP5u0R52IA8P?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <34E61BDDEF303343B2DBE1BD7128ED6D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38694d1a-7c54-44dd-b6e3-08dd62df6ed1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2025 10:03:13.2921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y2RKcz+8/W/FuKWem/sgoqK9sIfC2HADysKq/v7/S6RSaUzVMMI8IL8qW3fGWC0fIw/dxA1lcydLsb9YKXAiTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7512
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI1LTAzLTEzIGF0IDE4OjQwICswMDAwLCBFZGdlY29tYmUsIFJpY2sgUCB3cm90
ZToNCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL3Byb2Nlc3MuYyBiL2FyY2gveDg2
L2tlcm5lbC9wcm9jZXNzLmMNCj4gPiBpbmRleCA5Yzc1ZDcwMTAxMWYuLjg0NzVkOWQyZDhjNCAx
MDA2NDQNCj4gPiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvcHJvY2Vzcy5jDQo+ID4gKysrIGIvYXJj
aC94ODYva2VybmVsL3Byb2Nlc3MuYw0KPiA+IEBAIC04MTksMTggKzgxOSwxOSBAQCB2b2lkIF9f
bm9yZXR1cm4gc3RvcF90aGlzX2NwdSh2b2lkICpkdW1teSkNCj4gPiDCoMKgCW1jaGVja19jcHVf
Y2xlYXIoYyk7DQo+ID4gwqAgDQo+ID4gwqDCoAkvKg0KPiA+IC0JICogVXNlIHdiaW52ZCBvbiBw
cm9jZXNzb3JzIHRoYXQgc3VwcG9ydCBTTUUuIFRoaXMgcHJvdmlkZXMgc3VwcG9ydA0KPiA+IC0J
ICogZm9yIHBlcmZvcm1pbmcgYSBzdWNjZXNzZnVsIGtleGVjIHdoZW4gZ29pbmcgZnJvbSBTTUUg
aW5hY3RpdmUNCj4gPiAtCSAqIHRvIFNNRSBhY3RpdmUgKG9yIHZpY2UtdmVyc2EpLiBUaGUgY2Fj
aGUgbXVzdCBiZSBjbGVhcmVkIHNvIHRoYXQNCj4gPiAtCSAqIGlmIHRoZXJlIGFyZSBlbnRyaWVz
IHdpdGggdGhlIHNhbWUgcGh5c2ljYWwgYWRkcmVzcywgYm90aCB3aXRoIGFuZA0KPiA+IC0JICog
d2l0aG91dCB0aGUgZW5jcnlwdGlvbiBiaXQsIHRoZXkgZG9uJ3QgcmFjZSBlYWNoIG90aGVyIHdo
ZW4gZmx1c2hlZA0KPiA+IC0JICogYW5kIHBvdGVudGlhbGx5IGVuZCB1cCB3aXRoIHRoZSB3cm9u
ZyBlbnRyeSBiZWluZyBjb21taXR0ZWQgdG8NCj4gPiAtCSAqIG1lbW9yeS4NCj4gPiArCSAqIFVz
ZSB3YmludmQgdG8gc3VwcG9ydCBrZXhlYyBmb3IgYm90aCBTTUUgKGZyb20gaW5hY3RpdmUgdG8g
YWN0aXZlDQo+ID4gKwkgKiBvciB2aWNlLXZlcnNhKSBhbmQgVERYLsKgIFRoZSBjYWNoZSBtdXN0
IGJlIGNsZWFyZWQgc28gdGhhdCBpZiB0aGVyZQ0KPiA+ICsJICogYXJlIGVudHJpZXMgd2l0aCB0
aGUgc2FtZSBwaHlzaWNhbCBhZGRyZXNzLCBib3RoIHdpdGggYW5kIHdpdGhvdXQNCj4gPiArCSAq
IHRoZSBlbmNyeXB0aW9uIGJpdChzKSwgdGhleSBkb24ndCByYWNlIGVhY2ggb3RoZXIgd2hlbiBm
bHVzaGVkIGFuZA0KPiA+ICsJICogcG90ZW50aWFsbHkgZW5kIHVwIHdpdGggdGhlIHdyb25nIGVu
dHJ5IGJlaW5nIGNvbW1pdHRlZCB0byBtZW1vcnkuDQo+ID4gwqDCoAkgKg0KPiA+IC0JICogVGVz
dCB0aGUgQ1BVSUQgYml0IGRpcmVjdGx5IGJlY2F1c2UgdGhlIG1hY2hpbmUgbWlnaHQndmUgY2xl
YXJlZA0KPiA+IC0JICogWDg2X0ZFQVRVUkVfU01FIGR1ZSB0byBjbWRsaW5lIG9wdGlvbnMuDQo+
ID4gKwkgKiBzdG9wX3RoaXNfY3B1KCkgaXNuJ3QgYSBmYXN0IHBhdGgsIGp1c3QgZG8gdW5jb25k
aXRpb25hbCBXQklOVkQgZm9yDQo+ID4gKwkgKiBiYXJlLW1ldGFsIHRvIGNvdmVyIGJvdGggU01F
IGFuZCBURFguwqAgRG8gbm90IGRvIFdCSU5WRCBpbiBhIGd1ZXN0DQo+ID4gKwkgKiBzaW5jZSBw
ZXJmb3JtaW5nIG9uZSB3aWxsIHJlc3VsdCBpbiBhbiBleGNlcHRpb24gKCNWRSBvciAjVkMpIGZv
cg0KPiA+ICsJICogVERYIG9yIFNFVi1FUy9TRVYtU05QIGd1ZXN0cyB3aGljaCB0aGUgZ3Vlc3Qg
bWF5IG5vdCBiZSBhYmxlIHRvDQo+ID4gKwkgKiBoYW5kbGUgKGUuZy4sIFREWCBndWVzdCBwYW5p
Y3MgaWYgaXQgc2VlcyAjVkUpLg0KPiA+IMKgwqAJICovDQo+ID4gLQlpZiAoYy0+ZXh0ZW5kZWRf
Y3B1aWRfbGV2ZWwgPj0gMHg4MDAwMDAxZiAmJiAoY3B1aWRfZWF4KDB4ODAwMDAwMWYpICYgQklU
KDApKSkNCj4gPiArCWlmICghYm9vdF9jcHVfaGFzKFg4Nl9GRUFUVVJFX0hZUEVSVklTT1IpKQ0K
PiA+IMKgwqAJCXdiaW52ZCgpOw0KPiANCj4gSSBzZWUgdGhhdCB0aGlzIGFscmVhZHkgaGFzIFRv
bSdzIFJCLCBidXQgSSdtIG5vdCBzdXJlIGhvdyB0aGlzIHdvcmtzIGZvciBBTUQuDQo+IFRoZSBv
cmlnaW5hbCBTTUUgcGF0Y2ggdHJpZWQgdG8gYXZvaWQgd3JpdGluZyB0byBtZW1vcnkgYnkgcHV0
dGluZyB0aGUgd2JpbnZkDQo+IGltbWVkaWF0ZWx5IGJlZm9yZSB0aGUgaGFsdCwgYnV0IHRvZGF5
IGl0IGlzIGZ1cnRoZXIgYXdheS4gQmVsb3cgdGhpcyBodW5rIHRoZXJlDQo+IGFyZSBtb3JlIGlu
c3RydWN0aW9ucyB0aGF0IGNvdWxkIGRpcnR5IG1lbW9yeSBiZWZvcmUgdGhlIGhhbHQuIMKgT2ho
Li4uIGl0J3MgbmV3Lg0KPiA5IG1vbnRocyBhZ28gMjZiYTczNTNjYWFhICgieDg2L3NtcDogQWRk
IHNtcF9vcHMuc3RvcF90aGlzX2NwdSgpIGNhbGxiYWNrIikgYWRkcw0KPiBhIGZ1bmN0aW9uIGNh
bGwgdGhhdCB3b3VsZCB0b3VjaCB0aGUgc3RhY2suIEkgdGhpbmsgaXQncyB3cm9uZz8gQW5kIHBy
b2JhYmx5DQo+IGludHJvZHVjZWQgYWZ0ZXIgdGhpcyBwYXRjaCB3YXMgb3JpZ2luYWxseSB3cml0
dGVuLg0KDQooSSdsbCByZXBseSBvdGhlcnMgc2VwYXJhdGVseSBzaW5jZSB0b2RheSBJIGFtIGEg
bGl0dGxlIGJpdCBzaWNrLikNCg0KVGhhdCBjYWxsYmFjayBpcyBmb3IgVERYIGd1c2V0ICh3aGlj
aCBkb2Vzbid0IGludm9rZSBXQklOVkQgZHVyaW5nIGtleGVjKS4gIEl0DQpkb2Vzbid0IGltcGFj
dCBTTUUgaG9zdC4NCg0KSSBraW5kYSBhZ3JlZSBtYXliZSB0aGUgY29kZSBoZXJlIGNhbiBiZSBp
bXByb3ZlZCwgZS5nLiwgdGhlIGNvZGUgdG8gY2FsbA0Kc21wX29wcy5zdG9wX3RoaXNfY3B1KCkg
cGVyaGFwcyBzaG91bGQgYmUgY2FsbGVkIGJlZm9yZSB0aGUgV0JJTlZELg0KDQo+IA0KPiBUaGVu
IHRoZSBjcHVpZF9lYXgoKSBjb3VsZCBiZSBub24taW5saW5lZCwgYnV0IHByb2JhYmx5IG5vdC4g
QnV0IHRoZQ0KPiBib290X2NwdV9oYXMoKSBhZGRlZCBpbiB0aGlzIHBhdGNoIGNvdWxkIGNhbGwg
b3V0IHRvIGthc2FuIGFuZCBkaXJ0eSB0aGUgc3RhY2suDQoNCkNvdWxkIHlvdSBlbGFib3JhdGUg
dGhpcyBzaW5jZSBJIGRvbid0IHNlZSBob3cga2FzYW4gaXMgaW52b2x2ZWQ/DQoNCj4gDQo+IFNv
IEkgdGhpbmsgdGhlIGV4aXN0aW5nIFNNRSBjYXNlIG1pZ2h0IGJlIHRoZW9yZXRpY2FsbHkgaW5j
b3JyZWN0LCBhbmQgaWYgc28NCj4gdGhpcyBtYWtlcyB0aGluZ3MgdmVyeSBzbGlnaHRseSB3b3Jz
ZS4NCg0KQXMgZXhwbGFpbmVkIGFib3ZlIHRoZSBmdW5jdGlvbiBjYWxsIGlzIGVtcHR5IGZvciBT
TUUgaG9zdC4NCg0K

