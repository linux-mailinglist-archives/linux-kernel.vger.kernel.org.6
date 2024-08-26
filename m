Return-Path: <linux-kernel+bounces-302375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F1A95FD84
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 00:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34FB31F237AC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 22:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C959F19E7F7;
	Mon, 26 Aug 2024 22:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qv48RdQ/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E7419ADBE
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 22:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724712612; cv=fail; b=cRi+YGXo1Yka+hDkGQ6o1YcWQpQB5RLSlxZM/U42MksYvaw5F+yR1sxghO4cXtG/pime+0IYDJkr95molUXmJjaF8bbrhG2uBb0iiX2tMTM8iQGINXaCPTJ9ZWjlNgeSod3exgHVdeekqj91xRWHi+OW++mTPjjsw+2LxfRE/bA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724712612; c=relaxed/simple;
	bh=kZxto47oj+ZkyPuW+4A/R4yKVzxZig8Hz9d0WtL5iOg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FbU8jSDLt18yxDI9ICm1CUfs2BTXtaQr+e3LTnrgLx//TjL5GnOan2QmPT8mrZoCK+eMaqiaozIvAVBSB45GCo244MzCexUprqoqALmsPWiG9Z5DZjibAZU55ZXH2F7UbSnjAdgesgsnes7K1CCXTEMw45aFXGETBTcGrDcTIhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qv48RdQ/; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724712611; x=1756248611;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kZxto47oj+ZkyPuW+4A/R4yKVzxZig8Hz9d0WtL5iOg=;
  b=Qv48RdQ/+o3ZO5VuN9a7Vw4xH27dk81iba3avR90QCy71rZJO4llvzE5
   umAB6kXvN9x5p/iBVeMzcr1NRQL94eEYS3CTp2cEjcdC4BPhw8P+QVSmf
   f2bi5c0ymqvATl7uZQ8bQNch1rvFZJxzaxsaUvk3rfnoNTX0otZdBHRcY
   9dcruHWyGzPsJt3zotLG0hdMQyrMMH40uq0YgoacpJ+9M+Sd5H4uKz6id
   7lGodCftF1rBndxd+RIXyPQ23w6GoYG66tlXszQdsmdbIt/psJenMd8gQ
   1QgsNt3rbMKv0jtEe4NDFyxCo+CMjIDuSoYXFeW636jgduC+b4NfoCpNl
   Q==;
X-CSE-ConnectionGUID: rTHxeT3hS/SMtAbgHK0T5Q==
X-CSE-MsgGUID: eQWdbNScRTqcIWv+13g1cA==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="23343693"
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="23343693"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 15:50:10 -0700
X-CSE-ConnectionGUID: wQFPOMg4QtmCKuZAdDwfBg==
X-CSE-MsgGUID: ijeRINPHR2GK8T+sh+g8DA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="62706719"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Aug 2024 15:50:10 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 26 Aug 2024 15:50:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 26 Aug 2024 15:50:09 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 26 Aug 2024 15:50:09 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.43) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 26 Aug 2024 15:50:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n97SzGRWzIQKznu9/E3dUJlQCLx+kUx3t4JjbCBccWGKqmHyfeMIRnpScSzLllio4pSFc0AjUyulAo4OrmACJJC3i8m7P//fzjgX+nt9ROdN3D8x5mI5wTSK+6e2dzRLSrdyFWPL4d8AUB6a5lslUfgXwkPr9iC45nDocJc/xyXF+aOsneoZYeKNz8UBkLG4GTYLVItn3PQ++IuS/gG15XEMrdmeCPiT4WP8F04/c7ZaQgUrh3fpJOUw1k4+BDpWRCnTzAx9X3/mb+6rhUdZ4I0XkSst5HPi6sPraf908auEDFfblstVkLXtVYz5ftL5CIebGTRbdZhQMfbrvl1g1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kZxto47oj+ZkyPuW+4A/R4yKVzxZig8Hz9d0WtL5iOg=;
 b=J7m2+xySgV/0EsebNQztCFAyL4ty1uUfpSINgexZcLcR8N9j0fkHRteHj+4DMwLJhRv0kod9aP51BPWLcXkL2EC3UAl+d9dqt0STmSDcyIms259E7TQGKf725sYhkkVr7uue9QBAvki1GJD9KTe0os2vCuhJqfoATzSSGyY+hPWYRosYm+ORGvNObqZaG2qC7umY0lR6eSVOeO4VqfAn9kU4KZYlAY5nDwI7TNRHcyMbafUFzt39wEe+9pMqNnSVskrDBXs6DSZ09TKaKeXWcrDDe9XhHUA6PF7Xran9vf+M73s2tO8rNk3MWQEZWBI0Rlyrc1pI4+XOt4+aZxrHEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SJ2PR11MB8402.namprd11.prod.outlook.com (2603:10b6:a03:545::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Mon, 26 Aug
 2024 22:50:02 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%7]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 22:50:02 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "sagis@google.com" <sagis@google.com>
CC: "Hansen, Dave" <dave.hansen@intel.com>, "luto@kernel.org"
	<luto@kernel.org>, "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org"
	<x86@kernel.org>, "peterz@infradead.org" <peterz@infradead.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"seanjc@google.com" <seanjc@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 0/5] TDX host: kexec() support
Thread-Topic: [PATCH v5 0/5] TDX host: kexec() support
Thread-Index: AQHa7wyZqBebJJ2IWU+gCxNnCo4bK7IvHYkAgAAPJwCAAANdAIAABGSAgAXcvICAASF2AIADyc4AgAA6BIA=
Date: Mon, 26 Aug 2024 22:50:02 +0000
Message-ID: <26846c6de542b04c2fbee7b8b575b4df6196bac5.camel@intel.com>
References: <cover.1723723470.git.kai.huang@intel.com>
	 <20240819212156.166703-1-sagis@google.com>
	 <29fba60b-b024-417c-86e2-d76a23aa4d6c@intel.com>
	 <CAAhR5DEEsFNqdxbd62tGh9Cj7ZQMQs6fEjAKs6djkZzgZALOfw@mail.gmail.com>
	 <f4b60d0e-bec7-45d0-bbdf-fb04362c863a@intel.com>
	 <CAAhR5DFrOaXDbndFOSWAfdu-79buSR2ki_AU=z68FcHmn9o4Ow@mail.gmail.com>
	 <47dbc3b5dd6bd7cc3fa94ffe770e22419daf1d01.camel@intel.com>
	 <CAAhR5DGKNG=RiRyLj1r=xsueUBpyPXOhbhxg72UQTZRXcyyuzw@mail.gmail.com>
In-Reply-To: <CAAhR5DGKNG=RiRyLj1r=xsueUBpyPXOhbhxg72UQTZRXcyyuzw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.4 (3.52.4-1.fc40) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SJ2PR11MB8402:EE_
x-ms-office365-filtering-correlation-id: 8b3e67e8-81c7-40bb-fb45-08dcc6216baf
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?THpjRFNRVVlFbUN0TExobmxBU2FsKzFNaHVFYkxNVDltNHNTT0tTd0M2aDg1?=
 =?utf-8?B?aC9VcTVYa1U5bHBXS3hyZXNQQi9ycTVEN3B4WFFyWng1LzF1dG5FMlhFaGsy?=
 =?utf-8?B?ZEFNWHRlQXN3SjdLVlZZSlZ2cDJPS0VtNCtFTlUwVnRielA5STk0a01kdFNF?=
 =?utf-8?B?bUF1YUdCbkZyQVQ3N0tzaGhCMEdEaUpPWlVkK2JZYzJOUm4xWkhNb0pQR3Nn?=
 =?utf-8?B?ZHJZTTZYN1FCU1VuNVBLaWVvc3QxVFNxS3VXWVhPNzcyRmtlUnpRNG5vQmQ2?=
 =?utf-8?B?WFoweW90QkNDOFVvNjg3R1QwL0RFczljTU5DYVBmOWNuZkJINGpIaE5xVFh4?=
 =?utf-8?B?cVZKTFM2clJpMnM5YkdUVzVhUjhtcDdkUkFFRkNJQ0h4Z3BPYjMvUmgrL3Jo?=
 =?utf-8?B?VUFkUHRlb1JIZEFtSm9uT2NJN09GWGRydHhScEV3Yjl4OHVFczFROGJ5djds?=
 =?utf-8?B?VjExVXRaY0dDbVFDeUtZUm9lbDRXZldyeVZyblBNeWloTWVrN24ydWgyazN2?=
 =?utf-8?B?THBzbUlWNVA0c3grQm5NY25SQnhMWWF4K2F5ME56cHZGOUkrNE81aDY3bEgx?=
 =?utf-8?B?QjRnWVdIWFhPSjJ0UjVLckoydlZRc1BrNjN6clB5V2ZKWnMwTUttVXBpNnkw?=
 =?utf-8?B?aklJUnp3QUJtN2JjcXBhMEZHRUVHaFprMFNjaDk1TVh2dEJ3cG5JNVZJN3Ba?=
 =?utf-8?B?UDRnUFZ6dUdwaXZlVnlyZ3hnNGZ6Q3I0MFBZeHU2THhFd1pncUVuUDA3R3lx?=
 =?utf-8?B?QVdiMjZ6Y0Q4Z25ZaTV1VWc5OXdKeFNiRWIzTUJzeGJqZmNMd2M2eFpmNHNI?=
 =?utf-8?B?UEIwWElDZUM3czQ4a3BWekx3SDFMZ0FvU09qZU8rYjBuVU5JUWM0Y2krbzAy?=
 =?utf-8?B?TWUrZU5rWTlQL3Vjc0g1d01OUlVoNVNWcGxPNUViTmgrYzhKcUFUUkhFUStu?=
 =?utf-8?B?V2R1NEt5d3k4aXVSb2M5SHVxZ2ZLQW44QkoraWlLMUI2WDFPdEdHQ3VYQ0s3?=
 =?utf-8?B?RU5JRXpqOWR2VlVHaGszN0hSemxJTUhtQWxMbXk5L3hRazRkRWNUcEFhdmxo?=
 =?utf-8?B?aFZPYU1XR2FJT2xKWWlqclgvWi9MT3YxMjJVSmxCVVNucHdjdm9OdnZLaXZB?=
 =?utf-8?B?UzdSWldNN1h0cnhHY2hHbEwxOVZyUzlSZW9sK3ZsZ3dkcVByZk5HYkZOZTVI?=
 =?utf-8?B?MHl2d3J6b2tEVmJtdGdnYlZ3RVFoTGorMjZQU0lhNThEOG0zV2srNmhObmJY?=
 =?utf-8?B?NEw2S05jc2FSM1VwRVlyVVZvUUZEOWZ0UzVKMHc5ZXhzUVBzYVM1bUVTendW?=
 =?utf-8?B?clVCVEtNdjRuVEQ5TlVwWEhkblhiRkYvcDBZK3dNSHdqY2RBbnpQZUxpQ0pY?=
 =?utf-8?B?MmduaGZyZkdjTHZNdWhXVmc5d0ppakttc29lcXVUaFVXbThiOWtRNFB3eXJX?=
 =?utf-8?B?Z1lVanhQejhPeTdKR1BpMVRXdXdFY05rWFZDRWxWRXRBWXliYU1KYmxuaVZN?=
 =?utf-8?B?UThRY29rOEIrSXNZWjRXdUxkUUpWeHFTdG9XRlhOVE5kU0pGcHNlQnp0MndD?=
 =?utf-8?B?cDRCYnBrRERaZ0lYcS9BeXJXL2duZW91ak9LQVNiYm80NmlFSis3NEE5U3A0?=
 =?utf-8?B?U1dVaDNNZ3lqcWJhOUVqZUVJNEQwNkdwanZBeXllaE03djRwZUxTRTVPQ2Fz?=
 =?utf-8?B?V1VQckVJb09PNUJVc280RVdWS08yNzdVclNMUmIzeXVzKzFmL0p5Smc0L2hG?=
 =?utf-8?B?OUdKaGtKVEtTSEZzdWIzVkxYZ0VnbW5pcHVSU0RidVAzdmRvckZmZnBjcElo?=
 =?utf-8?B?Q2tvcmRWbFVzVXZ2alRkVEdhS1ZKelBUamFVbnI2SGJWNFhLeW9BemdQdjY0?=
 =?utf-8?B?UXdsa2NISXhmNEsydmlVMHhPTU9FTkhVRnZFMkl3MEVuUGc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXJWMmlObVJXOUpGWCswcDZEN0poRW5HRVNPaGlxUTNwZHRvY0JNejk4V21i?=
 =?utf-8?B?MG9palUvNlQvc1hEcnY4dU5PaXdCY0JrL1NFd0ZQb0pkVmR0aCtRby9uYnU2?=
 =?utf-8?B?d0orcWswM3ZuQ3JDY3pRaXBYWDJWNitxZnpjTDg3c0xEckZuWEFHTTUyN0ti?=
 =?utf-8?B?aldhOEY5eDVVV0ttbDNIM2pEUWhPYnhpQTZxOVVxRXBmSUdmd2dOTmZMcnNp?=
 =?utf-8?B?YTFxZ0c5SE1PL2VvZ3RUNTlRbko5WlZiemdJSnNzNTk3MkE0S2liRE0zVnYy?=
 =?utf-8?B?cUFHTW9xem9mc1ZMYXk5aGw1L1pNL0RUMGNrTTdZWWhkV0ROb082SUttVzlm?=
 =?utf-8?B?emNTbk5Rell2aW43Y0JlNDQxWkZXdnQzbGxVTE1qT2FqMXNyUkhrNmg0Rmpw?=
 =?utf-8?B?Z2Urb2VhcUprdlN4QWFRMm9NOS9NQ1ZxRkJ1ekFINEpNMGFPNEUxRnN3SmJs?=
 =?utf-8?B?Q0FKbFBCdGpkckQ1WllmS01iTTNMZlFKb2dSTWtHN0t1dmRjcEwwRXRFeFpJ?=
 =?utf-8?B?UUorR0ZNekg0S0tNaEc3ZmZNNmZvOWdTRXZGb2JhR0k4Q3dEdHRaOHR1UGNB?=
 =?utf-8?B?b1ZITnl4NlVYUDZxSUpuRk50ZGNOcXVFMUc0OXFHWE5TenZ6cGx3ZW9MMjRL?=
 =?utf-8?B?WE56djgzZTA1VFFnZEJaZVUwMkkyMEg1Rk5oMGI4dWVESk41Zkp2Rk1DK2FC?=
 =?utf-8?B?akhvbUdyWjlqM2dPUkdpVlZqMHZRbCtJSjg1SkpIbUFHYlVzVTl0NVVaVndH?=
 =?utf-8?B?STdxUEJaRGdWZjJUZGRwcU5rMUJoeEV6aG5PN0NoV3ViZzREK003UzRSQnVO?=
 =?utf-8?B?bWlYejRvODhLakErTWpTVGk1dFFXS29waElVb2VwVVQrNnIwbDN2dTBnY0t5?=
 =?utf-8?B?N0I1ZXVMRFRaUTg1N0ljQ1BZOGdYbkluaXZOdWMySnZlMTFnWm1oZG9LMzJm?=
 =?utf-8?B?RVlxTG9iZlEvbXpNK0c4dGRNUHlNaFFERStlOEl1bTFiei9KVTloL0JzQ0Js?=
 =?utf-8?B?bDM3cHV5SnhXS2xaQkpDeFlGc0VoQ0pyVkdwVVo2V25RemZWQlBOUXRwRnhK?=
 =?utf-8?B?d2p6b0dXV1lQTk5GaUZ6Qm5xdzd0Y2FpS28vT2Vvcm0xTE85ZmlzeVcvbmtv?=
 =?utf-8?B?bUowUThWbWt1OUd0b0hFZmVBd3lTUGtZR2hEdjJEY2NSUFVNbnlqeUd0N2VI?=
 =?utf-8?B?SGNQYVFEMFJUdTAwd3h4S04rdWF4U2xEempZMnJRb1kvT0JQa3hlM05UY0FJ?=
 =?utf-8?B?TklyWmxpcGxWR2dFbHZwSDZoQmZSQWluQ05DU2NUbWdzVm03SWlXYjBIQWVh?=
 =?utf-8?B?ZDJiUnAyUlBEaVE1a1F6NnYyazV0b1grZ3BqTmRuUmlUNXlLZTJGd0ZUYkJ1?=
 =?utf-8?B?cm5QdHJsNmNoOSs4YjZGblFlQjNvb0VPK0IrcGFxWTFJc1dNdW0zaDM2dVVS?=
 =?utf-8?B?NmUydmxwRmM0NHhBRDJoZ2pXVWo2bzZhWllZMFArVDdPd3l1UjBpdG50Ynhm?=
 =?utf-8?B?MmllMElxcVh6eVV6OG5kdGtGRCtSQzJxcmljbGplOVA5WG5zM1grbDFqbmZM?=
 =?utf-8?B?NG11U1NFN0ZmRlkzUU9yM2VwWjNEYU1tT2Y3YmVIUkF4aGZXcDdpRTdOU0pF?=
 =?utf-8?B?OHppS2p6TjFXOGM2R2c1QWpXZFduTXdtanFFS1FjOWdUR0ZKY0VkaVk3NjBy?=
 =?utf-8?B?OXoxRUNtSGJBanBnaVVuL0w1dHZhSmhCdS9RMDdLTDNzT0xyY2wyZURCQlJT?=
 =?utf-8?B?VGlVNmdTenJkR1VhYmoyNm1OQXZYcmtUY0Y2a0k4eE1yUFRVMEpMUlZ4OTRT?=
 =?utf-8?B?eUZBWVh3allpbmVmR0lOVzJ5K3A5OHUwVDZzY1dqUWdSaUZJMmkyRWJyU1A2?=
 =?utf-8?B?N1FqemNFKzJwbXNRc0tTckMrYmh2djlFUE1MYk5VNEZsM1BvZUhueHdIV0JD?=
 =?utf-8?B?aTVWOEw0bHhLWW5lRWx5UisxcUNkeFFNM1lkbXN2QmhzVzlmMThBaTFPcG5K?=
 =?utf-8?B?bUNGSm1leWJRUU1Xdm1GNDdOdlI5QzVCMGI0MHVRc042eG5oNUM0Y0xUNm40?=
 =?utf-8?B?R3ZzYWxQbSs2UkdxbmJQQUlKeHBUQmlybFNDNVlxbjdXZmhrTVhRUjZXWnJU?=
 =?utf-8?Q?uAQlEn6cA3v3fOZCZBCjS+e42?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3463EE3B02FFCF428CC4BFFC4A57016C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b3e67e8-81c7-40bb-fb45-08dcc6216baf
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2024 22:50:02.2534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BDf/Pu5AyXFR3ZVEfu4FLQuTd6WkQJk/k/glupxs169R9zKXJOXdnyBy/NdyPccHtEaG7TuKBA7ZofRHsRdbQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8402
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTA4LTI2IGF0IDE0OjIyIC0wNTAwLCBTYWdpIFNoYWhhciB3cm90ZToNCj4g
T24gU2F0LCBBdWcgMjQsIDIwMjQgYXQgNDozMeKAr0FNIEh1YW5nLCBLYWkgPGthaS5odWFuZ0Bp
bnRlbC5jb20+IHdyb3RlOg0KPiA+IA0KPiA+IE9uIEZyaSwgMjAyNC0wOC0yMyBhdCAxMToxNSAt
MDUwMCwgU2FnaSBTaGFoYXIgd3JvdGU6DQo+ID4gPiBPbiBNb24sIEF1ZyAxOSwgMjAyNCBhdCA1
OjQ04oCvUE0gSHVhbmcsIEthaSA8a2FpLmh1YW5nQGludGVsLmNvbT4gd3JvdGU6DQo+ID4gPiA+
IA0KPiA+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+IE9uIDIwLzA4LzIwMjQgMTA6MjggYW0sIFNh
Z2kgU2hhaGFyIHdyb3RlOg0KPiA+ID4gPiA+IE9uIE1vbiwgQXVnIDE5LCAyMDI0IGF0IDU6MTbi
gK9QTSBIdWFuZywgS2FpIDxrYWkuaHVhbmdAaW50ZWwuY29tPiB3cm90ZToNCj4gPiA+ID4gPiA+
IA0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IE9uIDIwLzA4LzIwMjQg
OToyMSBhbSwgU2FnaSBTaGFoYXIgd3JvdGU6DQo+ID4gPiA+ID4gPiA+ID4gQ3VycmVudGx5IGtl
eGVjKCkgc3VwcG9ydCBhbmQgVERYIGhvc3QgYXJlIG11dHVyYWxseSBleGNsdXNpdmUgaW4gdGhl
DQo+ID4gPiA+ID4gPiA+ID4gS2NvbmZpZy4gIFRoaXMgc2VyaWVzIGFkZHMgdGhlIFREWCBob3N0
IGtleGVjIHN1cHBvcnQgc28gdGhhdCB0aGV5IGNhbg0KPiA+ID4gPiA+ID4gPiA+IHdvcmsgdG9n
ZXRoZXIgYW5kIGNhbiBiZSBlbmFibGVkIGF0IHRoZSBzYW1lIHRpbWUgaW4gdGhlIEtjb25maWcu
DQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBJIHRyaWVkIHRlc3RpbmcgdGhlIGtleGVj
IGZ1bmN0aW9uYWxpdHkgYW5kIG5vdGljZWQgdGhhdCB0aGUgVERYIG1vZHVsZQ0KPiA+ID4gPiA+
ID4gPiBmYWlscyBpbml0aWFsaXphdGlvbiBvbiB0aGUgc2Vjb25kIGtlcm5lbCBzbyB5b3UgY2Fu
J3QgYWN0dWFsbHkga2V4ZWMNCj4gPiA+ID4gPiA+ID4gYmV0d2VlbiAyIGtlcm5lbHMgdGhhdCBl
bmFibGUgVERYLiBJcyB0aGF0IHRoZSBleHBlY3RlZCBiZWhhdmlvcj8gQXJlDQo+ID4gPiA+ID4g
PiA+IHRoZXJlIGZ1dHVyZSBwYXRjaGVzIHRvIGVuYWJsZSB0aGF0IGZ1bmN0aW9uYWxpdHk/DQo+
ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBUaGFua3MgZm9yIHRlc3Rp
bmchDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IFllcyB0aGlzIGlzIHRoZSBleHBlY3RlZCBi
ZWhhdmlvdXIuICBJZiB0aGUgZmlyc3Qga2VybmVsIGhhcyBlbmFibGVkDQo+ID4gPiA+ID4gPiBU
RFgsIHRoZW4gdGhlIHNlY29uZCBrZXJuZWwgd2lsbCBmYWlsIHRvIGluaXQgVERYLiAgVGhlIHJl
YXNvbiB0aGUgZmlyc3QNCj4gPiA+ID4gPiA+IFNFQU1DQUxMIHRvIGluaXRpYWxpemUgVERYIG1v
ZHVsZSBpbiB0aGUgc2Vjb25kIGtlcm5lbCB3aWxsIGZhaWwgZHVlIHRvDQo+ID4gPiA+ID4gPiBt
b2R1bGUgaGF2aW5nIGJlZW4gaW5pdGlhbGl6ZWQuDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+
IEhvd2V2ZXIgaWYgdGhlIGZpcnN0IGtlcm5lbCBoYXMgbm90IGVuYWJsZWQgVERYLCB0aGUgc2Vj
b25kIGtlcm5lbCBpcw0KPiA+ID4gPiA+ID4gYWJsZSB0byBlbmFibGUgaXQuDQo+ID4gPiA+ID4g
DQo+ID4gPiA+ID4gQXJlIHRoZXJlIGFueSBwbGFucyB0byBzdXBwb3J0IGJvdGgga2VybmVscyBi
ZWluZyBhYmxlIHRvIGVuYWJsZSBURFgNCj4gPiA+ID4gPiBpbiB0aGUgZnV0dXJlPyBFaXRoZXIg
YnkgY2hhbmdlcyB0byBLVk0gb3IgdGhlIFREWCBtb2R1bGU/DQo+ID4gPiA+IA0KPiA+ID4gPiBB
RkFJQ1Qgd2UgaGF2ZW4ndCByZWNlaXZlZCBzdWNoIHJlcXVpcmVtZW50IHNvIGZhci4gIExldCBt
ZSBkb3VibGUgY2hlY2sNCj4gPiA+ID4gaW50ZXJuYWxseSBhbmQgZ2V0IGJhY2sgaGVyZS4NCj4g
PiA+ID4gDQo+ID4gPiA+IEJ0dywgaWYgd2Ugd2FudCB0byBkbyB0aGlzIHB1cmVseSBmcm9tIHNv
ZnR3YXJlLCBjaGFuZ2luZyBLVk0gaXNuJ3QgdGhlDQo+ID4gPiA+IHJpZ2h0IHRoaW5nIHRvIGRv
LiAgV2UgbmVlZCB0byBzb21laG93IHBhc3Mga2V5IGRhdGEgc3RydWN0dXJlcyBtYW5hZ2luZw0K
PiA+ID4gPiBURFggbW9kdWxlIHRvIHRoZSBzZWNvbmQga2VybmVsLCBlLmcuLCBtb2R1bGUgc3Rh
dHVzLCBsb2NhdGlvbnMgb2YNCj4gPiA+ID4gUEFNVHMuICBBbmQgdGhlIHNlY29uZCBrZXJuZWwg
bmVlZHMgdG8gYmUgbW9kaWZpZWQgdG8gdW5kZXJzdGFuZCB0aG9zZSwNCj4gPiA+ID4gd2hpY2gg
bWVhbnMgc29tZSBvbGQgKHNlY29uZCkga2VybmVscyB3aXRoIFREWCBzdXBwb3J0IG1heSBub3Qg
YmUgYWJsZQ0KPiA+ID4gPiB0byBzdXBwb3J0IHRoaXMgZXZlbiBpZiB3ZSBhZGQgdGhpcyB0byB0
aGUga2VybmVsLg0KPiA+ID4gDQo+ID4gPiBXb3VsZCBpdCBiZSBwb3NzaWJsZSB0byB0ZWFyIGRv
d24gdGhlIHRkeCBtb2R1bGUgYW5kIHJlLWluaXRpYWxpemUgaXQNCj4gPiA+IG9uIHRoZSBuZXh0
IGtlcm5lbD8gSSBkb24ndCB0aGluayB0aGVyZSdzIGEgcmVxdWlyZW1lbnQgZm9yIHRoZSB0ZHgN
Cj4gPiA+IG1vZHVsZSBkYXRhIHN0cnVjdHVyZXMgdG8gcmVtYWluIGludGFjdCBkdXJpbmcga2V4
ZWMgYnV0IGl0IGNvdWxkIGJlDQo+ID4gPiB1c2VmdWwgaWYgdGR4IGNhbiBiZSBlbmFibGVkIG9u
IHRoZSBuZXcga2VybmVsLg0KPiA+IA0KPiA+IFdlIGRpc2N1c3NlZCB0aGlzIGludGVybmFsbHku
ICBUaGUgVERYIG1vZHVsZSBjYW5ub3QgYmUgcmUtaW5pdGlhbGl6ZWQgYWZ0ZXINCj4gPiB0b3Ju
IGRvd24uICBIb3dldmVyIHRoZSBuZXcga2VybmVsIGNhbiByZWxvYWQgdGhlIChzYW1lKSBURFgg
bW9kdWxlIGFuZCByZS0NCj4gPiBpbml0aWFsaXplIGl0ICh0aGUgUC1TRUFNTERSIHN1cHBvcnRz
IHJlbG9hZCBvciBydW50aW1lIHVwZGF0ZSBURFggbW9kdWxlKS4NCj4gPiANCj4gPiBIb3dldmVy
IG91ciBwcmltYXJ5IGZvY3VzIGlzIHRvIGVuYWJsZSBiYXNlbGluZSBURFggc3VwcG9ydCBpbiB1
cHN0cmVhbS4gIEZvcg0KPiA+IFREWCBob3N0IGtleGVjLCBhdCB0aGlzIHN0YWdlIHdlIGZvY3Vz
IG9uOiAxKSBlbmFibGUgYm90aCBURFggYW5kIEtleGVjIGluIHRoZQ0KPiA+IEtjb25maWc7IDIp
IGFsbG93IG5vcm1hbCBrZXhlYyBhbmQga2R1bXAgdG8gd29yayB3aGVuIFREWCBpcyBlbmFibGVk
LiAgTWFraW5nDQo+ID4gdGhlIHNlY29uZCBrZXJuZWwgYmUgYWJsZSB0byB1c2UgVERYIGlzIG5l
eHQtc3RlcCBwbGFuLg0KPiA+IA0KPiA+IE1heSBJIGFzayBpcyB0aGVyZSBhbnkgcmVhbCB1c2Ug
Y2FzZSB0aGF0IHJlcXVpcmVzIHRoZSBzZWNvbmQga2VybmVsIHRvIGJlDQo+ID4gYWJsZSB0byB1
c2UgVERYIGF0IHRoaXMgc3RhZ2U/DQo+IA0KPiBbQWdhaW4gaW4gcGxhaW50ZXh0XQ0KPiANCj4g
UmlnaHQgbm93IEkgZG9uJ3QgdGhpbmsgd2UgaGF2ZSBwcm9kdWN0aW9uIHJlcXVpcmVtZW50cyBm
b3Iga2V4ZWMgYXQNCj4gYWxsIGJlc2lkZXMga2R1bXAgc3VwcG9ydC4gS2V4ZWMgZnJvbSBURFgg
ZW5hYmxlZCBrZXJuZWwgdG8gYSBub24tVERYDQo+IGtlcm5lbCBkZWZpbml0ZWx5IGRvZXNuJ3Qg
aGF2ZSBhIHByb2R1Y3Rpb24gcmVxdWlyZW1lbnQuDQo+IA0KPiBJdCB3b3VsZCBiZSBuaWNlIHRv
IGJlIGFibGUgdG8ga2V4ZWMgdG8gYSBURFggZW5hYmxlZCBrZXJuZWwgdG8gc3BlZWQNCj4gdXAg
dGhlIGRldmVsb3BtZW50IGN5Y2xlIGluc3RlYWQgb2Ygd2FpdGluZyBmb3IgYSBmdWxsIHJlYm9v
dCBidXQNCj4gdGhhdCdzIG5vdCBhIGhpZ2ggcHJpb3JpdHkgYXQgdGhlIG1vbWVudC4NCg0KWWVh
aCBhZ3JlZWQuICBCdXQgdGhlbiBsZXQncyBkbyB0aGlzIGFzIGEgZnV0dXJlIHdvcmsgYWZ0ZXIg
YmFzZWxpbmUgVERYDQpzdXBwb3J0IGlzIGRvbmUuDQo=

