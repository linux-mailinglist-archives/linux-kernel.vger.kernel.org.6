Return-Path: <linux-kernel+bounces-346383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7470698C41E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 19:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3F281F25FB6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632BE1CBE9C;
	Tue,  1 Oct 2024 17:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SN/pExv0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCE01CBE97
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 17:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727802133; cv=fail; b=qeNP7329pw0XWKvtVzV5Gq1AjnrtFIp25HHYDEjKpASlu4Jf/mYLVxDgOmuFkwonAgD+5b3N2AuLFDzkm1cNAVQ5G3T9BSOS0TMKJSRrVxL15BpJwg/LNSTgugrSf8qSN0ZrralPNJKRLlLyKTxWjsM12iO4KqEPPGtV3Sbsi2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727802133; c=relaxed/simple;
	bh=WNUF38MLpOM3qyfovTNci5ahVBDUItJlBqzjSZKpmm0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r8qESSyLpAZ+JZu7mYXeulXqbEf6BhYcRJG/6z6MDvwjKzhu4PGOwwPzRtu8A3tmR4oBtTK96lJ7DNaxi2e7BhvrRRSDlhGcNsi0dhf9cbx7Y2xxJkLQlRPPl6xANaD76P2j4SAyQr/3MgIEk5xNwuMsch51rm5gGIlIG/GhYy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SN/pExv0; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727802131; x=1759338131;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WNUF38MLpOM3qyfovTNci5ahVBDUItJlBqzjSZKpmm0=;
  b=SN/pExv0yFUZuOHa6yVrwA7FOjKXYfNSy5hHIf1HIA9rg5DdQGHC+o9G
   ZO+RAi9NOoONNPA/UfxFDoTZTryrBKzXegSmWterLQVnGU4irUWiBleJQ
   9slZThGoA9Ez5w7n0nczDtGUMlJtX7f09l97PyiN/EbA8SgwL4wPCpNal
   ozC2narwM83vY1TwgUZHZhHln0m6sNqCKVaiuKNTHNVkh0XugxFaLfEwA
   NwtwjUqC6lRkBhynyNOt6nVVk3gWi48A2q9jsNVPsqHdAVxt+r3WLbk/h
   wwAuJoKKZ1aOLn8Fxn9cRtoFiGP5ipsfCksRYC5ZRH4dJUrWGzQ8/PtVM
   A==;
X-CSE-ConnectionGUID: bfVEefodSeKfjLB35nnHwg==
X-CSE-MsgGUID: 4fdFcX1ET3+sfNpmmX3gRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="30656842"
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="30656842"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 10:02:10 -0700
X-CSE-ConnectionGUID: 1f63ctGBRaW0v6d1/CN/vw==
X-CSE-MsgGUID: 1vukE6e4T3y65jUYEZifeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="78478343"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Oct 2024 10:02:09 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 1 Oct 2024 10:02:08 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 1 Oct 2024 10:02:07 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 1 Oct 2024 10:02:07 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 1 Oct 2024 10:02:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p179gGqf72VhVENshcGc8lAnKL+crLDw/18WnmeZN0gLkF6lTMbg7Mro62cl2RRMJrAXQ72n2vhO5yDDTyMsWyi9nRVtUBfln0fnu7VrgEqVJgkIDXiIjZ+zS7CWxoIWCSTJhDIAJwHwHiOojWlRuy77xu1iWZoaOOul8fbGrrF3zD0S6f0ESGSvTvY7ZI2aKwtsZGb+JZY3mLNiXItAamcV+XU6T57mEXBMDvEC9bFZ0Guu7WDsBEr0TRoLwWfnm1U6Jle7VXlvYte08zedV4qVJ9rWOwK/mC1ebCwHamQ8lvJ63bAQUJ7+lP0bQvzP8pJs5jTwD2VvdeWPdzo0lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WNUF38MLpOM3qyfovTNci5ahVBDUItJlBqzjSZKpmm0=;
 b=KwYKviv/pOUlyUgC4lDuKGPUlALgJzvE17A7jhqeuZhR4U5KSPayvtlbxH6DwBts56wyqv2bGOlJS7Iuy91JZEUDX2B8HBEqRhmm2dj1XqttPiiHsuKk8AksNpCuZkXJMyFrN/5QSrPpyF0ijZZ7D2keF4oCpxRVv+E9oPG48NMH60Whbbdb69FW2TssX2apwy+mi0n55QHoV5M0OUZcPXG80o50z0jRfSjhuq9j7WtpVHYGeqEoDcRMxmhyE32Fvzm0xPFGu3aYVAeBbyko8Gjf6kvI8mjv01lxWjowUOUgi4+tgxQhgMIoN0SVg8YA8+Mxhsf/mF/qSdEA4OFvSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by CY8PR11MB6817.namprd11.prod.outlook.com (2603:10b6:930:63::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 17:02:03 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 17:02:02 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Nhat Pham <nphamcs@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "yosryahmed@google.com" <yosryahmed@google.com>,
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "shakeel.butt@linux.dev"
	<shakeel.butt@linux.dev>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"Huang, Ying" <ying.huang@intel.com>, "21cnbao@gmail.com"
	<21cnbao@gmail.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"willy@infradead.org" <willy@infradead.org>, "Zou, Nanhai"
	<nanhai.zou@intel.com>, "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>,
	"Gopal, Vinodh" <vinodh.gopal@intel.com>, "Sridhar, Kanchana P"
	<kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v10 6/7] mm: zswap: Support large folios in zswap_store().
Thread-Topic: [PATCH v10 6/7] mm: zswap: Support large folios in
 zswap_store().
Thread-Index: AQHbE8NS/mzK7ddAdUGteugGSqw7kLJyHouAgAABDYA=
Date: Tue, 1 Oct 2024 17:02:02 +0000
Message-ID: <SJ0PR11MB5678E4B835A15BEE8DEDD053C9772@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20241001053222.6944-1-kanchana.p.sridhar@intel.com>
 <20241001053222.6944-7-kanchana.p.sridhar@intel.com>
 <CAKEwX=MKzX6qE42nQVVrr+Y=ZtHLjJ9w5mQ+k+oiFhfjcacWVA@mail.gmail.com>
In-Reply-To: <CAKEwX=MKzX6qE42nQVVrr+Y=ZtHLjJ9w5mQ+k+oiFhfjcacWVA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|CY8PR11MB6817:EE_
x-ms-office365-filtering-correlation-id: df9a4606-e3b7-47e0-630c-08dce23ac583
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?K0s5UW43N2lIK3BtOEo1bkllTTN2bWsrL2x6bURyaHRreEk0bEVjNmxhV3ZH?=
 =?utf-8?B?aml0aGl0SEdMWndkSWF0TXZiTkw0NWV0RDMzaG44dkxPOW9ORkN5NHlMUEdy?=
 =?utf-8?B?M1pMb3AySVowNytpWlJCS2VVVldBbjBZYm9aM3VrVmw3djZTRGZrY3JrdTdL?=
 =?utf-8?B?RWE1S2hENEw5azFYU3o4OG9JTlVwSGQ3ZXVqS3QxRXE3dzhUenFwMi9SOU1k?=
 =?utf-8?B?K2ZscVFhdTRrSXI1WGwwQm1DUUlJRXFyVUZtV3FqSk4rREVLZGNhUHZVaG9J?=
 =?utf-8?B?T2VZOE5uWk5QZDdtb0k3d1B4SHRIUnJkdk5ra2kyaDV4ejdGOUt0d3k4VTV3?=
 =?utf-8?B?RldHZWlPeUQyYVFIMVpmNHUyaDdtb3pNeURsVmIxTUEzZk82RzVlNHQ0K0Iz?=
 =?utf-8?B?L2dYNnZlU0lleVlCdXl3OG5wWWhEMjQ1UTA2MVExWEd6NkRsZGlFYTJxdnp1?=
 =?utf-8?B?Vjh4OEhkenVidVVFNGttbUdZWVg4NVQvU3M4Zm10T1BxRlNrc3R6Vjk4NlVQ?=
 =?utf-8?B?T3FWUnB2Ri9zNVlpV2tjZTRINERUZ1FZWGljMjlHN1pkSHVWWXdNUU9SUlp4?=
 =?utf-8?B?OEtuSWtlL1pNRWZ3cndBZzI0T2JQa284TE0xalA5ZkJ6ckRaUG1SYzk1Qmwx?=
 =?utf-8?B?WVpUYng3QXlweXNoQVd4SHhyRFNpRGRYMHRDMnpFUE9ydUo5OUJwVDgwazNp?=
 =?utf-8?B?d3ZUNksrUVRUUWJrTVczcjllWndjR2lKelY3aGdEODQ1MkdaZlhCWFBySW1t?=
 =?utf-8?B?d0ZyWG04K0VOZFR6Qnd4amF4ekQvRzRHZHUwekN3MnV1OFgxOGxSNWlHbzFi?=
 =?utf-8?B?SU44L2lRcHBFOEIzdSt3WkR3ejZPaEpRVGZYSTRYM04vOXlaajdiUjB0Q25v?=
 =?utf-8?B?V3dPZ3AzRzZNS3hPV2hSUFlOTVI0czJnSXYxZ3JNWEdjNEhZbUc2T0UvdFpQ?=
 =?utf-8?B?eFFXR2NyMWMvbFdOZEFraElFaDY1V2JFK0QxOHVtbWVtcHcwTmNOYXBZSFdG?=
 =?utf-8?B?VWx4NzArLzlwdWozbm5wOHlMWVJxZXBHeExub1VhUmZWK3FYTFJvZ2Nscmgr?=
 =?utf-8?B?WG54NkxCNXQrc2I4VTZoK21UQUl4RzdEVmJtNnRhSU9ReVlaRlBLMnJUd0VM?=
 =?utf-8?B?OXFMdmEwckU4QjRkVDlmRklnZ2RnNnF5ZVduRWVNN081VDRxWCt1aVRmZ1Y1?=
 =?utf-8?B?NmJOTDZhMjBaL0dnajkxQW5pUko0UG4vcDU1Ukd1Yyt5NnRybGpQUEp1TW5Y?=
 =?utf-8?B?aEQvYUVPMDZ1bWRZR1ovd3UxUFVQZXAzVm5JYzJLS0gxaStVZWQ0MzVIaGQr?=
 =?utf-8?B?NGVpL2RqcVBBcWp5aWExUklGaHhKbXl3N1FTTG1IYjZaV0VZTjhRL09FeHFn?=
 =?utf-8?B?dXIveEJjcDN1aFNwQUs2RFd5ODduWmduMTNoWTNvb05tVGVrdUZPWGp2SkZh?=
 =?utf-8?B?SFBWc0hTbmt2OUFlcWsyanlscytjYVh6Z3p2dDdodmhPSGRqNWxTZWw2VVJa?=
 =?utf-8?B?aWh4Nkh5TTk2TW1yeEZOU0dFUjRjN1FPYjc5MTcrcTlHQzl2UVl4dlRoRjgr?=
 =?utf-8?B?N0d6UHJnZUtjUm9JK05CUkxjQWhkQ0FpSVhCL2JTNnFPb05mdkZ3cWVESTJD?=
 =?utf-8?B?SFNhSjVnQWkwdVBndmZnMVRXQmMxM1Z4U250Z2hlNlhwcHlLL0dBVzZCa3NS?=
 =?utf-8?B?K0xqdFdhU0MyMXJkTC8yUG45Q0J5a1M2Wk5lODhzbUpQRmNkNjRscHlZb2hQ?=
 =?utf-8?B?VHNRK0N3V1hPbzJmWGQzb3FMamVsTm5QcVlhRkppT3hWZnM0RnJWR0xNa3Bj?=
 =?utf-8?Q?wgImB4n2V9S8sEwZpiO7+rmF/l/bJWwdSpJiA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZkR0NGx4MkdTSUo5Qmc1blovaHBEaUROU2pWWEJ3KzVlKzY1eVJ6MjFHVE1Y?=
 =?utf-8?B?dUpZa3FuU1BQUWV6a1JCd2FXbjlJdVNJTnJ3dVJBZjAzWTZtRm1aclkyNXNT?=
 =?utf-8?B?NnNnSWtXbFJjdExnZUNUVjdTczR3K1RwWjV3VnRwK2lZZ240OHdSYWtmQjVu?=
 =?utf-8?B?Q0hOVUxBQ0R5YjB0OHlsLytvcElqUXJJbHd5V3pDTmxpdWtwelR4dWx5YmNS?=
 =?utf-8?B?NFZEdUFqbUNqbW9mMzhuUi95QVFQVVd2WGNRR2dwUWVxblRFUit6Ymtla1lD?=
 =?utf-8?B?VjAxWEJscFRTOWRVTEE5bXY2a0JpSXF0b3U3Q1pLNFp0b2czVDE4SEtJc2Nm?=
 =?utf-8?B?eVE4Ly83eituWGQzSzQ4TjEyY2ZoQ01zamR4dXZXODRROXFRQ1NNUFpCSGpZ?=
 =?utf-8?B?Vy83OUgzbGZHQjlwbERRdW0wd09mL3NMbzBwYzdzSFp2WFJUU1lxNDRycEpU?=
 =?utf-8?B?MmJEUFBYNU9uUGp2QzBVMkVZSVhQVGdDcHNBQUF5MWw1N1JXQUt6NVBJVlAr?=
 =?utf-8?B?bE5pZjJjOHh2ZU5qNXBZeUNqekc0RTUyclFOeW5NQWNsNHdnU3R2VGhnNFJT?=
 =?utf-8?B?aDZzSEt1TnRpU0d0UEpUUmI4SUI3eDNVL0NHejB1Y0gvOW11MlNEd0NzcEpa?=
 =?utf-8?B?VWdCMUxVRG9VeHZwMXdtU0hjVSt0ekZLS3BCc3lPc2FXV2NpWWlSRGFuV2tI?=
 =?utf-8?B?dEVpcHFjQTBoNFBya2NrMHMzVkRWcVNCeExKT283cWVRRGRHY2J3M2N1cDFF?=
 =?utf-8?B?Wit3aTZMa1RHSmhtd2xjOVdydG1FSkpRcHZLa0Z1WHY0Mjd0YUI4eC9BU3E0?=
 =?utf-8?B?V25MdHNKZStCK1lhMHhjWnhzZDZWS0N0c1A5L21JdUhwa0wwampocXUxY2cy?=
 =?utf-8?B?N1NNL3JVMVVHeTdrNkt1bjdIUXR6V292bGFIVXc4ays5TWFHL0VIZlZUOGVn?=
 =?utf-8?B?OHZlSkpjKytieE90RDIzRGRZeDdXL3dmMzAxVlVTc2ZSdEVZT3hnRysxM0xY?=
 =?utf-8?B?S2RSeTZvUTRZVmdEV3p0dVdSTThrTFBJQ2tXUmpaVjNWUzh1TzRXTnpjekps?=
 =?utf-8?B?cW5iSG5ERnJWL3VrZld0K2NCY2R1b1F1UmNyY2ZGalcyRmtNbzNSSVl0WWFO?=
 =?utf-8?B?QTcvS1Y4eVRqeGo5M1R6WjZmampkaDI4cDNpWStvOXJ2d2JoTE1PenAxNVh4?=
 =?utf-8?B?bkE0Q0xMYURXbEV6S1l3bkFiMU1seUxxSDlabWdiaThJYnhCSk1UWjBYaTZF?=
 =?utf-8?B?Vk9jWEk4UUVybU5SYkdjcTlaRWpMNVZ3bjhkRHFkUUVUMCs0alBIV01aZStv?=
 =?utf-8?B?bmE0VHg1VE1CWlM5cEdBdHNBUmJxTVhBZXJEL3V5bkRhZjg0eVc5Z0NxV2Fx?=
 =?utf-8?B?RUYvbWhYRi9ycmlxNzRLM2J1K2lTdHRTa0kxUk0rd0Y4N0UvdkYyS2RmSDJw?=
 =?utf-8?B?a3paYjVNOHhnUFRjdXhwdmhBbmRzTytiQUNGMlFMbXdEb3creXFSc0pOMUs1?=
 =?utf-8?B?MjRmMTl4eDhsQTY1bzRFNXByQWFkSnFJd3d6SzgvOWRZdkR6ajJvUGk0dnhM?=
 =?utf-8?B?WnFreEwrYkExaUpmN0hkb3JlV1Btd2JhMVZJdHJ6aUEwS2hoUEQ5clBpV1c1?=
 =?utf-8?B?azFRL2xyY3hsVStzVlVoREROMmhRRnYwTGQ5SWwrc2RBeG41VHVsSXdIQkpC?=
 =?utf-8?B?NFByb0lMQTROUGxFazVvdC9MODA0M0F3R3VjWjN5dThaMVRCeFA0VklPTXYz?=
 =?utf-8?B?RzNXTkM2NStTeG81R1ROdlZyeGxGcWVTSjlaZXV5Q083VWdMNGcxM0dNWjlK?=
 =?utf-8?B?dGhqcmhQcE04VWYwSVFjSk93WGlDTU5CVXdVYndMcXZ3SnRNMHpXdTBIV2cy?=
 =?utf-8?B?MXBSdGIxUDRyWGhEZjhqaHdqTVhHMGI1bWhQd0NGbWdXakVIQlJnaTdIZ2dH?=
 =?utf-8?B?ZUY1UG9rVjIxellnYStXem85eEc2ME85ZzArRVlocXlEWkpwbFhpVWtmQzVh?=
 =?utf-8?B?aXdtc0lMcHZGWmNKL1dGL2tvcTNicE9TWmkwUW1QTnhvdHg1STcrTGMzZWg5?=
 =?utf-8?B?eGtnaktud2ViOHFMVlQzTmpHQWIrUk9PMmpFd0VjNEtOWVpoRTJjWVdiZU44?=
 =?utf-8?B?Nks0NWNTeENHNTYzNTkvSUZDbEY5Q0hGcDc4SFBlZFdwYUNNOFJITzFVN25E?=
 =?utf-8?B?dUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5678.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df9a4606-e3b7-47e0-630c-08dce23ac583
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2024 17:02:02.9170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zIT4vm9NJg6YqIWQ132fs0qiAlxnLgxrWYEovQTqLxOiomZ3pPkSC7RPyhg4cpaAmz6p715AD0UPqMdpFj5M75wQh2zWCU4/diO8O3qnq/I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6817
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOaGF0IFBoYW0gPG5waGFtY3NA
Z21haWwuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBPY3RvYmVyIDEsIDIwMjQgOTo1OCBBTQ0KPiBU
bzogU3JpZGhhciwgS2FuY2hhbmEgUCA8a2FuY2hhbmEucC5zcmlkaGFyQGludGVsLmNvbT4NCj4g
Q2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LW1tQGt2YWNrLm9yZzsNCj4g
aGFubmVzQGNtcHhjaGcub3JnOyB5b3NyeWFobWVkQGdvb2dsZS5jb207DQo+IGNoZW5nbWluZy56
aG91QGxpbnV4LmRldjsgdXNhbWFhcmlmNjQyQGdtYWlsLmNvbTsNCj4gc2hha2VlbC5idXR0QGxp
bnV4LmRldjsgcnlhbi5yb2JlcnRzQGFybS5jb207IEh1YW5nLCBZaW5nDQo+IDx5aW5nLmh1YW5n
QGludGVsLmNvbT47IDIxY25iYW9AZ21haWwuY29tOyBha3BtQGxpbnV4LWZvdW5kYXRpb24ub3Jn
Ow0KPiB3aWxseUBpbmZyYWRlYWQub3JnOyBab3UsIE5hbmhhaSA8bmFuaGFpLnpvdUBpbnRlbC5j
b20+OyBGZWdoYWxpLCBXYWpkaSBLDQo+IDx3YWpkaS5rLmZlZ2hhbGlAaW50ZWwuY29tPjsgR29w
YWwsIFZpbm9kaCA8dmlub2RoLmdvcGFsQGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRD
SCB2MTAgNi83XSBtbTogenN3YXA6IFN1cHBvcnQgbGFyZ2UgZm9saW9zIGluDQo+IHpzd2FwX3N0
b3JlKCkuDQo+IA0KPiBPbiBNb24sIFNlcCAzMCwgMjAyNCBhdCAxMDozN+KAr1BNIEthbmNoYW5h
IFAgU3JpZGhhcg0KPiA8a2FuY2hhbmEucC5zcmlkaGFyQGludGVsLmNvbT4gd3JvdGU6DQo+ID4N
Cj4gPiB6c3dhcF9zdG9yZSgpIHdpbGwgc3RvcmUgbGFyZ2UgZm9saW9zIGJ5IGNvbXByZXNzaW5n
IHRoZW0gcGFnZSBieSBwYWdlLg0KPiA+DQo+ID4gVGhpcyBwYXRjaCBwcm92aWRlcyBhIHNlcXVl
bnRpYWwgaW1wbGVtZW50YXRpb24gb2Ygc3RvcmluZyBhIGxhcmdlIGZvbGlvDQo+ID4gaW4genN3
YXBfc3RvcmUoKSBieSBpdGVyYXRpbmcgdGhyb3VnaCBlYWNoIHBhZ2UgaW4gdGhlIGZvbGlvIHRv
IGNvbXByZXNzDQo+ID4gYW5kIHN0b3JlIGl0IGluIHRoZSB6c3dhcCB6cG9vbC4NCj4gPg0KPiA+
IHpzd2FwX3N0b3JlKCkgY2FsbHMgdGhlIG5ld2x5IGFkZGVkIHpzd2FwX3N0b3JlX3BhZ2UoKSBm
dW5jdGlvbiBmb3IgZWFjaA0KPiA+IHBhZ2UgaW4gdGhlIGZvbGlvLiB6c3dhcF9zdG9yZV9wYWdl
KCkgaGFuZGxlcyBjb21wcmVzc2luZyBhbmQgc3RvcmluZyBlYWNoDQo+ID4gcGFnZS4NCj4gPg0K
PiA+IFdlIGNoZWNrIHRoZSBnbG9iYWwgYW5kIHBlci1jZ3JvdXAgbGltaXRzIG9uY2UgYXQgdGhl
IGJlZ2lubmluZyBvZg0KPiA+IHpzd2FwX3N0b3JlKCksIGFuZCBvbmx5IGNoZWNrIHRoYXQgdGhl
IGxpbWl0IGlzIG5vdCByZWFjaGVkIHlldC4gVGhpcyBpcw0KPiA+IHJhY3kgYW5kIGluYWNjdXJh
dGUsIGJ1dCBpdCBzaG91bGQgYmUgc3VmZmljaWVudCBmb3Igbm93LiBXZSBhbHNvIG9idGFpbg0K
PiA+IGluaXRpYWwgcmVmZXJlbmNlcyB0byB0aGUgcmVsZXZhbnQgb2JqY2cgYW5kIHBvb2wgdG8g
Z3VhcmFudGVlIHRoYXQNCj4gPiBzdWJzZXF1ZW50IHJlZmVyZW5jZXMgY2FuIGJlIGFjcXVpcmVk
IGJ5IHpzd2FwX3N0b3JlX3BhZ2UoKS4gQSBuZXcNCj4gZnVuY3Rpb24NCj4gPiB6c3dhcF9wb29s
X2dldCgpIGlzIGFkZGVkIHRvIGZhY2lsaXRhdGUgdGhpcy4NCj4gPg0KPiA+IElmIHRoZXNlIG9u
ZS10aW1lIGNoZWNrcyBwYXNzLCB3ZSBjb21wcmVzcyB0aGUgcGFnZXMgb2YgdGhlIGZvbGlvLCB3
aGlsZQ0KPiA+IG1haW50YWluaW5nIGEgcnVubmluZyBjb3VudCBvZiBjb21wcmVzc2VkIGJ5dGVz
IGZvciBhbGwgdGhlIGZvbGlvJ3MgcGFnZXMuDQo+ID4gSWYgYWxsIHBhZ2VzIGFyZSBzdWNjZXNz
ZnVsbHkgY29tcHJlc3NlZCBhbmQgc3RvcmVkLCB3ZSBkbyB0aGUgY2dyb3VwDQo+ID4genN3YXAg
Y2hhcmdpbmcgd2l0aCB0aGUgdG90YWwgY29tcHJlc3NlZCBieXRlcywgYW5kIGJhdGNoIHVwZGF0
ZSB0aGUNCj4gPiB6c3dhcF9zdG9yZWRfcGFnZXMgYXRvbWljL3pzd3BvdXQgZXZlbnQgc3RhdHMg
d2l0aCBmb2xpb19ucl9wYWdlcygpDQo+IG9uY2UsDQo+ID4gYmVmb3JlIHJldHVybmluZyBmcm9t
IHpzd2FwX3N0b3JlKCkuDQo+ID4NCj4gPiBJZiBhbiBlcnJvciBpcyBlbmNvdW50ZXJlZCBkdXJp
bmcgdGhlIHN0b3JlIG9mIGFueSBwYWdlIGluIHRoZSBmb2xpbywNCj4gPiBhbGwgcGFnZXMgaW4g
dGhhdCBmb2xpbyBjdXJyZW50bHkgc3RvcmVkIGluIHpzd2FwIHdpbGwgYmUgaW52YWxpZGF0ZWQu
DQo+ID4gVGh1cywgYSBmb2xpbyBpcyBlaXRoZXIgZW50aXJlbHkgc3RvcmVkIGluIHpzd2FwLCBv
ciBlbnRpcmVseSBub3Qgc3RvcmVkDQo+ID4gaW4genN3YXAuDQo+ID4NCj4gPiBUaGUgbW9zdCBp
bXBvcnRhbnQgdmFsdWUgcHJvdmlkZWQgYnkgdGhpcyBwYXRjaCBpcyBpdCBlbmFibGVzIHN3YXBw
aW5nIG91dA0KPiA+IGxhcmdlIGZvbGlvcyB0byB6c3dhcCB3aXRob3V0IHNwbGl0dGluZyB0aGVt
LiBGdXJ0aGVybW9yZSwgaXQgYmF0Y2hlcyBzb21lDQo+ID4gb3BlcmF0aW9ucyB3aGlsZSBkb2lu
ZyBzbyAoY2dyb3VwIGNoYXJnaW5nLCBzdGF0cyB1cGRhdGVzKS4NCj4gPg0KPiA+IFRoaXMgcGF0
Y2ggYWxzbyBmb3JtcyB0aGUgYmFzaXMgZm9yIGJ1aWxkaW5nIGNvbXByZXNzIGJhdGNoaW5nIG9m
IHBhZ2VzIGluDQo+ID4gYSBsYXJnZSBmb2xpbyBpbiB6c3dhcF9zdG9yZSgpIGJ5IGNvbXByZXNz
aW5nIHVwIHRvIHNheSwgOCBwYWdlcyBvZiB0aGUNCj4gPiBmb2xpbyBpbiBwYXJhbGxlbCBpbiBo
YXJkd2FyZSB1c2luZyB0aGUgSW50ZWwgSW4tTWVtb3J5IEFuYWx5dGljcw0KPiA+IEFjY2VsZXJh
dG9yIChJbnRlbCBJQUEpLg0KPiA+DQo+ID4gVGhpcyBjaGFuZ2UgcmV1c2VzIGFuZCBhZGFwdHMg
dGhlIGZ1bmN0aW9uYWxpdHkgaW4gUnlhbiBSb2JlcnRzJyBSRkMNCj4gPiBwYXRjaCBbMV06DQo+
ID4NCj4gPiAgICJbUkZDLHYxXSBtbTogenN3YXA6IFN0b3JlIGxhcmdlIGZvbGlvcyB3aXRob3V0
IHNwbGl0dGluZyINCj4gPg0KPiA+ICAgWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4
LW1tLzIwMjMxMDE5MTEwNTQzLjMyODQ2NTQtMS0NCj4gcnlhbi5yb2JlcnRzQGFybS5jb20vVC8j
dQ0KPiA+DQo+ID4gQ28tZGV2ZWxvcGVkLWJ5OiBSeWFuIFJvYmVydHMNCj4gPiBTaWduZWQtb2Zm
LWJ5Og0KPiA+IFNpZ25lZC1vZmYtYnk6IEthbmNoYW5hIFAgU3JpZGhhciA8a2FuY2hhbmEucC5z
cmlkaGFyQGludGVsLmNvbT4NCj4gDQo+IFJldmlld2VkLWJ5OiBOaGF0IFBoYW0gPG5waGFtY3NA
Z21haWwuY29tPg0KDQpUaGFua3MgTmhhdCENCg0K

