Return-Path: <linux-kernel+bounces-565205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F47A66330
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 00:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1847017F40D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 23:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27670206F3A;
	Mon, 17 Mar 2025 23:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e/1inH7R"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D58206F13
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 23:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742255631; cv=fail; b=RkhKt/PNIfB1KT5KqoEzO1qqdz153y4WZ/KO5SOgfENdNaqABuHnbyJUafT2B3nyu8K5eHYqRdmNxLFfsraMgw9pcSOVh/ptc4MnzZ8oPZT0NsDWA4VskstBFKccDuxATGcGpw2QiB2Kd6oPoxZIM+yd8x8lrFpixBGuTXlLYso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742255631; c=relaxed/simple;
	bh=nyDWFltaujVul+WP2FQqmck5ZOLHGCosLwSMlWOdLTs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BGlNxH5FxE5yxbyQRSwkkhfDUcJ3RrfrP25qkorq+iTA3rZjiAnm81IQyBCKaLiF99oV72iH30bgehoyEk/Pvnbp0G3wpWN2nlxWmtznj/mfTIIZA0tdd8sZFbu79+AuQgM4JBZ3P286O7MfKylf5FYDGlpk6EdoFi2ncZIv3kw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e/1inH7R; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742255629; x=1773791629;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nyDWFltaujVul+WP2FQqmck5ZOLHGCosLwSMlWOdLTs=;
  b=e/1inH7RC9KUkkeho/tqH5USeW/tHemB66J1fI6OYOHBZk/D1zSoV1Pq
   Do/nQr9WvYbxe6Tyvn+MkJT9ooM1I9VLXOxC6Pg6h0c3M0sQ017oZJZXK
   nqgTLYox8IrwlMrstQiPVGf8DaWWTKh0zkkMy5VaA+P3YlW8oxdrn8wHa
   eu18Zhy+eqNu0fX1taidaHYVnlY6EvNnXjIReGnnGrsFtQBUEdj4sB1Ln
   LIcOsw9Ga1VqWoqH2xbtbBfcoRAA4J8tzEHnp0JQV2cunQEvvDmIdT5ex
   qFq0NQsCPc3IP9aBbS7tIxKbFB+8wzjsIReT7cg+hYjo7MwTkQkKSsYQi
   A==;
X-CSE-ConnectionGUID: ReY8lOK5TtCEHQa7uUY1eg==
X-CSE-MsgGUID: vrwA/DQsTkiZxtcplsHD9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="42621246"
X-IronPort-AV: E=Sophos;i="6.14,255,1736841600"; 
   d="scan'208";a="42621246"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 16:53:48 -0700
X-CSE-ConnectionGUID: hDIm6l1fSqyS6kGf3pX12Q==
X-CSE-MsgGUID: RE8paY1mSpW6PL+rlpQI7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,255,1736841600"; 
   d="scan'208";a="127114938"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Mar 2025 16:53:47 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 17 Mar 2025 16:53:47 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 17 Mar 2025 16:53:47 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 17 Mar 2025 16:53:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dHBfT6Lqzy4KzSQMmTLfvZWN5eyl6k6e57nhkba2VdAQ3oOuihOeGQrg9NKMs7xNyT2qVL8EqCRhLMHDaQNXWlk5SkeE8X5k2NTKsMkGIJrqDTf6NRgP7l8IqnZ0R+1/9Zc3c+14CfXtFj44LyCE8l7u+ar+wIn3m9r/FdM6NYk1BUG4uBxOvJ4kBp1vTb3FaoTjCeW3U+xT+QXYswER7Rej+1tWB3ZibFVJvBEk3wHT/d9E8tk2fJuN0rRxkTMwp/4yqvQXR+qYWy5U2g6YYs3sEgMa5ZDnk2PapX1ve/Dst4KES2RNAHauXNYQjDAZTXXxWNnlcrDyzYgBnKwpOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nyDWFltaujVul+WP2FQqmck5ZOLHGCosLwSMlWOdLTs=;
 b=ct297Hsw9fvrqYpKHc9Pt2uo5NQzrAyXJ15FOSV05oSfWuqHWnOwnoi7lxHRFn130EPbqrL0ZPILN9EuodyujGFvRFywhsKR2zR9BwqWJrJ/OMCH9glc5sOo6p9VzSM3wCRsl9N5wG0vF68JEy3RKzQkxPuO4VaSAiW7VODfRtM79aauvR0IPPNl30oK7dDtp9LTuXsgO9o8YfptJzB9jgcx1BOo4ZPBoCCx9SYY4xafUK5anMQCjdpD2RfClC6JP6BKAT9jaIvGF/5jckFNMSLsqEiKnCZa/a6nEQ8Q3nfk3jGMVAmQWWbTvUJ7UjJxSsKPTw53Zyn6IMCAY65BHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by CO1PR11MB5139.namprd11.prod.outlook.com (2603:10b6:303:95::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 23:53:44 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%4]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 23:53:44 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "tglx@linutronix.de" <tglx@linutronix.de>, "peterz@infradead.org"
	<peterz@infradead.org>, "mingo@redhat.com" <mingo@redhat.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, "Huang, Kai" <kai.huang@intel.com>, "bp@alien8.de"
	<bp@alien8.de>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>
CC: "ashish.kalra@amd.com" <ashish.kalra@amd.com>, "Yamahata, Isaku"
	<isaku.yamahata@intel.com>, "seanjc@google.com" <seanjc@google.com>,
	"x86@kernel.org" <x86@kernel.org>, "sagis@google.com" <sagis@google.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "Chatre, Reinette"
	<reinette.chatre@intel.com>, "Williams, Dan J" <dan.j.williams@intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "dwmw@amazon.co.uk"
	<dwmw@amazon.co.uk>, "bhe@redhat.com" <bhe@redhat.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>
Subject: Re: [RFC PATCH 3/5] x86/kexec: Disable kexec/kdump on platforms with
 TDX partial write erratum
Thread-Topic: [RFC PATCH 3/5] x86/kexec: Disable kexec/kdump on platforms with
 TDX partial write erratum
Thread-Index: AQHbk0LJuXFYy0Gh0U6rXIUsBiIijrNwJfcAgAAZYwCAARH4AIAAV+KAgAAEGYCAABOhAIABQDMAgAONvYCAAXo5AA==
Date: Mon, 17 Mar 2025 23:53:44 +0000
Message-ID: <f48648722e0ffec5b78b0725c947df9db2f6718a.camel@intel.com>
References: <cover.1741778537.git.kai.huang@intel.com>
	 <408103f145360dfa04a41bc836ca2c724f29deb0.1741778537.git.kai.huang@intel.com>
	 <4ac689506269e907774806a484e15171b04ffc63.camel@intel.com>
	 <e1b3da33446178861ca34e61675f184b439101e2.camel@intel.com>
	 <5e736c6d7794b8642d020350e302ead0d6ca13ae.camel@intel.com>
	 <da02e1d5a489526770ec737eac41237226cdb5cd.camel@intel.com>
	 <e7b259b0a986f3cf1578b000f9113933ef80a324.camel@intel.com>
	 <1a6b44f3fb23d0a35bb3c24d755fb2ae6f74b1bb.camel@intel.com>
	 <a6b3a87eba30fdb79423306da538b9c8bb7b8634.camel@intel.com>
	 <912df0c6bd8f42d92ccc11d9fdda1e108576a5e5.camel@intel.com>
In-Reply-To: <912df0c6bd8f42d92ccc11d9fdda1e108576a5e5.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|CO1PR11MB5139:EE_
x-ms-office365-filtering-correlation-id: dcb6fc30-6d9b-4472-4202-08dd65aef3ac
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?T1FPWXpnbCtSTlFpd0ZCWmY4ZUYzTXg5aDhYcnpSUEJJdnFWRnpKQkZPSG1Y?=
 =?utf-8?B?SnI2MXB5ZVNzZGRuWnNkbXVDTWlXYUVkbHVBT1Z2dDM0UlZmeUU2ZktaYXZP?=
 =?utf-8?B?cGZqTUpRSDNxN2lvYXB4bFNCckkvYXRsbUhvcmV5ME1rTEgzZVlaellmWHph?=
 =?utf-8?B?dVEvbEZ2S0dlZTFNVU9XYWtBUENsVG1yRlJpWCtreW5ITDJpemluczcrUFQ3?=
 =?utf-8?B?S3BKbXcza3RWZ2xNRW5NdmltNVhzcDJRM3JrUGMvaFBKelVWS2lhdlBvaXBi?=
 =?utf-8?B?L1BrK2piZmRiWmFzcUVKbGticmhGVjk3MDVSa2xZbCtja1dmeXJCUGN5WUM5?=
 =?utf-8?B?bG4rVGVSOHNoeDlEQldJVHk3dCtTV2dxSlFvV0JZQ2tpUzVONkdlekN5MGJU?=
 =?utf-8?B?VklzdGxMUlA1K0VsUXRETjNNcmhNbGFsNjZ6S0xyVXV6QmEyVEtMWVI1eUlt?=
 =?utf-8?B?MUF3c1o0Y0JrMGo5VE1qZ1BXak5FSHFvVU5ZQ2pHbGJvQ2JrcGx0b1BxRzM3?=
 =?utf-8?B?dE42a2JSSkVrTTdHbjE3Ym03ZUs3bEkzblVIRXpEb3l6dm9ubVdnbEhOTEli?=
 =?utf-8?B?SEhLbDhCaUk1QngyV0ltc1ordUZUWGJnOVdLQXRPZzhuU0dESm56aEVSYTdm?=
 =?utf-8?B?T0hublZMbm9jSFl4c2pidlYxeThmTmMvWTBVVEZYY3hyaFdhREhFcU9iNy9L?=
 =?utf-8?B?QkxwQ01GbXVEV3BiVGI5UDRyblpmMFJ3TXhBaTNOdXJOdDNpTk0rbkpmQjRE?=
 =?utf-8?B?RlNYQmxjbGY5YlpjUHVHakpEUUNEVnFCaGZGTGRFLzJLc2FOV2dDVXJsQUxQ?=
 =?utf-8?B?emJMWlAzay9tRHh1a0FCK3U2MVVaM2FlakpySFpqNWRrYVNyYVJqNGZJeHlY?=
 =?utf-8?B?dm15UWljTFl1ZE9PQmF0ZThPeitLRXRFTC9MSjhsRkFHWk50MUd0d3EybTVq?=
 =?utf-8?B?TitXcGN3TmdXcUYxcGtYU05WdlVDQlJRWDgrdnJWSXROQnorcW0vMnV0TFNP?=
 =?utf-8?B?Yk9Vck96S0VqaGNucG96UUppSGh5bFpTdTJvbWcrSDJZb096bU40bVd1cVNU?=
 =?utf-8?B?UVloUTBGbzMrYldaUXBVUDNlWEdsblN2UlV5TEN6dW9haE53aDlHTy9RNlpt?=
 =?utf-8?B?UDQ3VUVMcCs5MmxNaWZWSnRDdm9tcnhWaUhLM0dKaXE2blBMUlUyVkU4TGZX?=
 =?utf-8?B?SUhnYm5WV3Y1aHkzSEJ5Tk1NaWM2aXlpNHFxaTIvWmlPQ09QS3BkZGxpVGZE?=
 =?utf-8?B?T2JiVWgyT2NnYnJYQUpRT1lTQnplVWlHNzlZdUdHYnZ4dm9wOTZzTHNKeHNj?=
 =?utf-8?B?dVhSU3RudGpHaHN4Q3RGZ2hTaEx6NDM3bE9EMGQwZUVrSGlaQm01UmlwUWxW?=
 =?utf-8?B?Q2llczZ1ZUMxOFdNMDIrV1ZPU0RhZHlpK3hSL0xJVldpc2YvaWN1aGFJUXpG?=
 =?utf-8?B?Ni9HL002NFpFSmFMcjFjNlNidzdBa2ZTOExsMWlwVGlHZkNaQVVQTHBRVXZB?=
 =?utf-8?B?NzFZZk41UWpuRlprUjFWQUFBTVlTS3NZY2xxSWpzQVFOYTB5YzRhUDhscTIw?=
 =?utf-8?B?ZjJXMGI3dms4aTVCcnpQR0IrTHF1NnZOblBUZnNHZmZwVDI0VnlkMG1JUDM3?=
 =?utf-8?B?K2w1cGMxSEFJNm9WeGhGNzd6TFJVZ3RlOC9CWDYyMkhpUGphdWNpVzJBKzFx?=
 =?utf-8?B?Uk5hYW10dzNtUmVmbWQ2UFlEZVRhWG1JeXlvOVFyU2RZbmdOajJRQkdublRa?=
 =?utf-8?B?WDRVc0VISFBsQXhua0c1NGhWMWtBc0FnME1zbC9ROGtuUlFBNi9hWlZ3d1E5?=
 =?utf-8?B?MlNXbzIwV3dua2wyTFFyZ3pJTDVLbHFmNDV5UEkzMUhjamFJYkxuSHdwYkJI?=
 =?utf-8?B?QzdYZzAvanV6dVUrejFudkJ0SlA0VHE2ZW1zbjVZaUpQYVE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YSs3UytjejF1dnNBc09IQzU2N3NFM01nMHBoaEtWYi9WaHgxdlh0ZlpWdU1R?=
 =?utf-8?B?QjdqMWd1MWhjUnViVlllUStuS1dBOVRqTWtsenhGcXJVTFJlcmhwYnlGbXls?=
 =?utf-8?B?NEU5M3hXallmY09NY3ViRmJGZFFwWkZxaDJIb0VRdnlPUHNCbGdOZXpHZ1BB?=
 =?utf-8?B?cUFsV2laeGxYVVpPeW54WXR1NGgzV284NGoydHhIRVptbHBQV3hJTVlRT3dF?=
 =?utf-8?B?djZXSS80NHplZG5WaWk3MWhQZW1hMUsxL00wVUFzenBXeG5YZHpYT0ROcXl2?=
 =?utf-8?B?elBEeFl5WXdtQ09vSVhHYnBxSUFDWTI5R2cvc0s4ZVd3dkJOL2Y0SjBLWHNp?=
 =?utf-8?B?RWRhOE5LMzZySFRhK2NIR1JHeC8ycVVDOEp0R3poTmQyeFJJUDBNZGtILzh2?=
 =?utf-8?B?ODYybVBrcVZoUlI3cWtpRXY1OENxQXdsR2E0MSsreWs1TXpCWEU5ZVlFbWRl?=
 =?utf-8?B?Nk5PYm16UXZUODNEY2t6Q1c0SXZXMjFCZHNPM1FkcmpXVGNaM0ZucjNLWVhP?=
 =?utf-8?B?QU1DVSs0YlhXcjhteW9lYUNXVFJ0elBNY3YzVUN3MS9WbW00Ui9QeTBNQURS?=
 =?utf-8?B?SGlCRjBMaU1PL3psMEJlS0h2MW9veExNMThtekIyKyt3UzJkcmxQb2dXTVNM?=
 =?utf-8?B?bHppZUlDdGdwcWNDZ1QxUnIrTEkyZHBFNUVuWmlPaHdyQm0xT3kwQVYvVHdO?=
 =?utf-8?B?Rm45TTRCdXluM0YvNWRic1o0T2RYNEJJcDlXTGx3WEdUM3grcGsxMlgwQ0Ev?=
 =?utf-8?B?eG9ESEVXa1FPUk9yTE96dHJ3QThmSmZuZmgzYzZFWkc4WDd0akc2aW9YeXlx?=
 =?utf-8?B?SFdvemJ1amRaWUU2Wk9RYzlmZjJOR3dLdy8yYkJrZCtyMjc4bWlTYThOWDY4?=
 =?utf-8?B?V0RhZEdqVTUzd0p6QkN1emREN0NsZmFlUEpxalBDNnp3TXBrZHFMMDVpUVdB?=
 =?utf-8?B?T0hkbGJ3VU9zajJLbHVFbndybThocllMQ2FvWFNwZjIvampGL2VnYXlpSTJ5?=
 =?utf-8?B?bUM4SVpYZklrR0VIMFdsQzM0UFBEVXpTMmF6WlpSN25YelF5emd3NHdvQUVV?=
 =?utf-8?B?R3NNM0ltTVllUjVPWTVsYmlQcVdrdnNYVGhBWjJEMFEyc0xvMDZpanpLL2lC?=
 =?utf-8?B?aTJMY3ZIT2hnQXZ6OWk0SDNqY3d3dmVIa0thTVZLOFMrQkpxSFkwZ1VmL0dI?=
 =?utf-8?B?bHduYTBodzhzYVJqMjRaSGNhWlFpbHlUVXdKSndCKzlCdnk1NmZGMHNIVEJM?=
 =?utf-8?B?eVRGMElabW9SdWVuMmtTNDhKTyttYk9iSjc5NnkwZXhFOVA2TEpEUWt3a3Yx?=
 =?utf-8?B?cndHY1lLYXhES3MvNUp4UVlwZHpqOUI4dHZXbmZpOXJjbW5ObGd3TkdxWmZI?=
 =?utf-8?B?eUxyRE5EbVdEeEp2MmJHWUVQdFJiRnVRVUVlUnhoV1lhUFdpUXoyd0NaVmpr?=
 =?utf-8?B?N1IyRDBjUXpBZ2NncEExZnk3a0t0QzNNQmo3TTFsNllsUkJWYjJxZ1AySitV?=
 =?utf-8?B?eENhU1p0NVhVMW9EUTAvVUQ1UC8zdEJTMmNMaG5FdHlpekdGRDlZdUhCY0tE?=
 =?utf-8?B?SVZmMkdDVEl3anpidit3NGpzRUd1eFBBTXhoMHFqY0puL0pzdXlwcjFvblRn?=
 =?utf-8?B?M1dHVE1tWnZJeC9pZGlpR0c1d2d3YnNuT3dtaStvOVBqTmhpK1ZxRTVjcGE3?=
 =?utf-8?B?S1Q4OFFUcm5BWFg3aHlvWmp2WTY5aEtmeGQ4ZEFzS0lLYUZYdS9iSnhHaUVY?=
 =?utf-8?B?VUp6ZmNZeXJBWXJSSHgyZGxFZ3h2UEc1M0J1aW9EL2RWY0hPMDlJaVBkN1Jp?=
 =?utf-8?B?KzlwWllWZzNiNkJjdVo0MlIzNEZsYXhRWmpSRFE5cVZPUG82K1cyUWhBclhv?=
 =?utf-8?B?NzlZSnRDaFBxUlJtTG1aS1dYdTEzYVVGMTA1cXpRSE5hY0xqRFJORUYzZU0z?=
 =?utf-8?B?K29ES2ZxVTk1VHhqdHNKZC9LY3hDdmJoZUl5NGNqdTJPYjlrZzd0OUY2Ymtx?=
 =?utf-8?B?YnlrR3FxTk9ha3M3SnJWMG9HUWhZVngzVjdDYi8rUDExbzB6Z00wTTM1Slkw?=
 =?utf-8?B?cHAyakJHR1A4bi9iMGxLQVZyS1dIZnhtMjFjdHltYUNHVFE4SVVNeENOOENO?=
 =?utf-8?B?UTRxcXprYzlOL3lBVjRtdktrRHA1RThVVnVya292cVZrcjlNTVNPVFB4Zmwz?=
 =?utf-8?B?ckE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2874DD8727E21147A144DCD2BD29582D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcb6fc30-6d9b-4472-4202-08dd65aef3ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2025 23:53:44.3202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9+vsbVWTtPNyjBA9KoRr+nLBcfLBWl/KVVXeBtuXWUc7zdfFtQlP33mxJdvx91Xp+qm8RFVj/y/8Huep0cI7SE8ZPd9MTLdcr7NIQCmLrVk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5139
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI1LTAzLTE3IGF0IDAxOjE5ICswMDAwLCBIdWFuZywgS2FpIHdyb3RlOg0KPiBP
biBGcmksIDIwMjUtMDMtMTQgYXQgMTk6MDMgKzAwMDAsIEVkZ2Vjb21iZSwgUmljayBQIHdyb3Rl
Og0KPiA+IE9uIFRodSwgMjAyNS0wMy0xMyBhdCAyMzo1NyArMDAwMCwgSHVhbmcsIEthaSB3cm90
ZToNCj4gPiANCj4gPiANCj4gPiANCj4gPiBTbyBJIHRoaW5rIHRoZSBzaXR1YXRpb24gaXMgd2Ug
bmVlZCBhdCBvbmUga2VybmVsIHBhcmFtZXRlci4gV2UgYWxyZWFkeSBoYXZlIG9uZQ0KPiA+IGZv
ciBLVk0sIHdoaWNoIGNvbnRyb2xzIHRoZSBsYXRlIGluaXRpYWxpemF0aW9uIHBhcnRzIG9mIFRE
WCB0aGF0IHdlIGNhcmUgYWJvdXQNCj4gPiBoZXJlLiBTbyB3aGF0IGFib3V0IGp1c3QgdXNpbmcg
dGhlIGV4aXN0aW5nIG9uZT8gSSB0aGluayB3ZSBkb24ndCB3YW50IHR3by4NCj4gDQo+IExvZ2lj
YWxseSwgS1ZNIGlzIG9uZSB1c2VyIG9mIFREWC4gIEkgdGhpbmsgd2hldGhlciBLVk0gaGFzIGEg
cGFyYW1ldGVyIHNob3VsZA0KPiBub3QgaW1wYWN0IHdoZXRoZXIgd2Ugc2hvdWxkIGludHJvZHVj
ZSBvbmUga2VybmVsIHBhcmFtZXRlciBmb3IgVERYIGhvc3QgY29yZS0NCj4ga2VybmVsLg0KPiAN
Cj4gRGFuIGFsc28gbWFkZSBhIHBvaW50IHRoYXQgaW4gdGhlIGNvbnRleHQgb2YgVERYIENvbm5l
Y3QsIHRoZXJlJ3MgcmVxdWlyZW1lbnQgdG8NCj4gbWFrZSBTRUFNQ0FMTHMgZXZlbiBLVk0gaXMg
bm90IGdvaW5nIHRvIHJ1biBhbnkgVERYIGd1ZXN0Og0KPiANCj4gaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcva3ZtL2NvdmVyLjE3MzAxMjA4ODEuZ2l0LmthaS5odWFuZ0BpbnRlbC5jb20vVC8jbTY5
MjhmNTUxOWRlMjVkZWY5N2Q0N2ZjNmJiYjc3ZjVjM2U5NThmN2INCj4gDQo+IFNvIEkgYWdyZWUg
aWRlYWxseSB3ZSBkb24ndCB3YW50IHR3bywgYnV0IEkgdGhpbmsgaXQgaXMgYWxzbyBPSyBpZiB0
aGVyZSdzIGdvb2QNCj4gcmVhc29uIHRvIGRvIHNvLg0KDQpXaGF0IGlzIHRoZSBnb29kIHJlYXNv
biB0byBoYXZlIHR3byB0aG91Z2g/IERvIHdlIGp1c3Qgd2FudCBvbmUgaG9zdCBzaWRlIG9uZQ0K
YW5kIGxvc2UgdGhlIEtWTSBvbmU/IEl0IHNlZW1zIGFkZGluZyBrZXJuZWwgcGFyYW1ldGVycyB0
byBtYWtlIGNvZGUgcHJvYmxlbXMgZ28NCmF3YXkgaXMgdXN1YWxseSBmcm93bmVkIHVwb24uDQoN
Cj4gDQo+ID4gDQo+ID4gSWYgS1ZNIGhhcyBub3QgaW5pdGlhbGl6ZWQgVERYIChiYXNlZCBvbiBp
dHMgb3duIFREWCBwYXJhbWV0ZXIpLCB0aGVuIGtleGVjIGlzDQo+ID4gZmluZS7CoA0KPiA+IA0K
PiANCj4gRm9yIG5vdy4gIEluIHRoZSBmdXR1cmUgVERYIG1vZHVsZSBjb3VsZCBiZSBpbml0aWFs
aXplZCBieSBvdGhlciBrZXJuZWwNCj4gY29tcG9uZW50cy4NCj4gDQo+ID4gSXQgY291bGQgd29y
ayBieSBleHBvc2luZyBhbiBpbnRlcmZhY2UgZm9yIGZlYXR1cmVzIHRvIGJlIGV4Y2x1c2l2ZSB3
aXRoDQo+ID4gVERYLsKgU2luY2UgcmVhbCBURFggbW9kdWxlIGluaXRpYWxpemF0aW9uIGhhcHBl
bnMgbGF0ZSBhbnl3YXkuIEkgZG9uJ3Qga25vdyBpZg0KPiA+IGl0J3MgYmV0dGVyIHRoYW4gYSBr
ZXJuZWwgb25lLCBidXQgSSBkb24ndCBzZWUgYWRkaW5nIGEgc2Vjb25kIG9uZSBnb2luZyB3ZWxs
Lg0KPiA+IA0KPiA+IA0KPiA+IFZlcnksIHZlcnkgcm91Z2g6DQo+ID4gDQo+ID4gZGlmZiAtLWdp
dCBhL2FyY2gveDg2L2tlcm5lbC9tYWNoaW5lX2tleGVjXzY0LmMNCj4gPiBiL2FyY2gveDg2L2tl
cm5lbC9tYWNoaW5lX2tleGVjXzY0LmMNCj4gPiBpbmRleCBhNjhmNWEwYTlmMzcuLmJmZWE0ZTc4
YzU3NyAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvbWFjaGluZV9rZXhlY182NC5j
DQo+ID4gKysrIGIvYXJjaC94ODYva2VybmVsL21hY2hpbmVfa2V4ZWNfNjQuYw0KPiA+IEBAIC0z
MTUsNiArMzE1LDEyIEBAIGludCBtYWNoaW5lX2tleGVjX3ByZXBhcmUoc3RydWN0IGtpbWFnZSAq
aW1hZ2UpDQo+ID4gICAgICAgICByZXN1bHQgPSBpbml0X3BndGFibGUoaW1hZ2UsIF9fcGEoY29u
dHJvbF9wYWdlKSk7DQo+ID4gICAgICAgICBpZiAocmVzdWx0KQ0KPiA+ICAgICAgICAgICAgICAg
ICByZXR1cm4gcmVzdWx0Ow0KPiA+ICsNCj4gPiArICAgICAgIGlmICh0ZHhfZXhjbHVkZV9mZWF0
dXJlKCkpIHsNCj4gPiArICAgICAgICAgICAgICAgcHJfaW5mb19vbmNlKCJOb3QgYWxsb3dlZCBv
bmNlIFREWCBoYXMgYmVlbiB1c2VkLlxuIik7DQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiAt
RU9QTk9UU1VQUDsNCj4gPiArICAgICAgIH0NCj4gPiArDQo+ID4gICAgICAgICBrZXhlY192YV9j
b250cm9sX3BhZ2UgPSAodW5zaWduZWQgbG9uZyljb250cm9sX3BhZ2U7DQo+ID4gICAgICAgICBr
ZXhlY19wYV90YWJsZV9wYWdlID0gKHVuc2lnbmVkIGxvbmcpX19wYShpbWFnZS0+YXJjaC5wZ2Qp
Ow0KPiA+ICANCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvdmlydC92bXgvdGR4L3RkeC5jIGIv
YXJjaC94ODYvdmlydC92bXgvdGR4L3RkeC5jDQo+ID4gaW5kZXggZjVlMmE5MzdjMWU3Li45YjFm
NDJhMTA1OWMgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC94ODYvdmlydC92bXgvdGR4L3RkeC5jDQo+
ID4gKysrIGIvYXJjaC94ODYvdmlydC92bXgvdGR4L3RkeC5jDQo+ID4gQEAgLTEyMTUsNiArMTIx
NSwyMSBAQCBpbnQgdGR4X2VuYWJsZSh2b2lkKQ0KPiA+ICB9DQo+ID4gIEVYUE9SVF9TWU1CT0xf
R1BMKHRkeF9lbmFibGUpOw0KPiA+ICANCj4gPiArYm9vbCB0ZHhfZXhjbHVkZV9mZWF0dXJlKHZv
aWQpDQo+ID4gK3sNCj4gPiArICAgICAgIGJvb2wgcmV0ID0gZmFsc2U7DQo+ID4gKw0KPiA+ICsg
ICAgICAgbXV0ZXhfbG9jaygmdGR4X21vZHVsZV9sb2NrKTsNCj4gPiArICAgICAgIGlmICh0ZHhf
bW9kdWxlX3N0YXR1cyA9PSBURFhfTU9EVUxFX0lOSVRJQUxJWkVEKQ0KPiA+ICsgICAgICAgICAg
ICAgICByZXQgPSB0cnVlOw0KPiA+ICsgICAgICAgZWxzZQ0KPiA+ICsgICAgICAgICAgICAgICB0
ZHhfbW9kdWxlX3N0YXR1cyA9IFREWF9NT0RVTEVfRVhDTFVERUQ7DQo+ID4gKyAgICAgICBtdXRl
eF9sb2NrKCZ0ZHhfbW9kdWxlX2xvY2spOw0KPiA+ICsNCj4gPiArICAgICAgIHJldHVybiByZXQ7
DQo+ID4gK30NCj4gDQo+IEFzc3VtaW5nIHNldHRpbmcgbW9kdWxlIHN0YXR1cyB0byAiZXhjbHVk
ZWQiIG1lYW5zIHdlIGFyZSBub3QgYWJsZSB0byBpbml0aWFsaXplDQo+IFREWCBtb2R1bGUgZm9y
IGV2ZXIuDQoNCkkgd2FzIGdvaW5nIGZvciB0aGUgc2ltcGxlc3QgYXBwcm9hY2ggd2l0aG91dCBh
ZGRpbmcgYSBuZXcga2VybmVsIHBhcmFtZXRlci4gQnV0DQppbiBwcmFjdGljZSBmb3IgZGlzdHJv
cyBLVk0gd2lsbCBsb2FkIGF0IGJvb3QgYW5kIGl0IHNob3VsZCB3b3JrIHByZXR0eSBtdWNoIHRo
ZQ0Kc2FtZS4gSWYgdGhlcmUgaXMgdGhlIHRkeCBwYXJhbWV0ZXIga2V4ZWMgaXMgZGlzYWJsZWQs
IG90aGVyd2lzZSBpdCdzIGVuYWJsZWQuDQo+IA0KPiBUaGUgdGhpbmcgaXMgS2V4ZWMgaGFzIHR3
byBwaGFzZXM6IDEpIGxvYWRpbmcga2VybmVsIGltYWdlLCBhbmQgMikgYWN0dWFsbHkgZG8NCj4g
a2V4ZWMuICBZb3VyIGFwcHJvYWNoIGJhc2ljYWxseSBtYXJrcyBURFggdW51c2FibGUgZm9yIGV2
ZXIgd2hlbiBhIHVzZXIgdHJpZXMgdG8NCj4gbG9hZCBhIGt4ZWMga2VybmVsIGltYWdlLCBidXQg
dGhpcyBpcyBhIGxpdHRsZSBiaXQgbmFzdHkgYmVjYXVzZSBsb2FkaW5nIGtleGVjDQo+IGtlcm5l
bCBpbWFnZSBzdWNjZXNzZnVsbHkgZG9lc24ndCBtZWFuIHlvdSBoYXZlIHRvIGFjdHVhbGx5IGRv
IHRoZSBrZXhlYywgaS5lLiwNCj4geW91IGNhbiB1bmxvYWQgdGhlIGltYWdlIGFuZCBtb3ZlIG9u
Lg0KDQpUaGlzIGNvbXBhcmVkIHRvIHRkeF9ob3N0IHBhcmFtZXRlciBtZWFucyB0aGF0IHNvbWV0
aW1lcyB0aGUgdXNlciBtYXkgYmUgYWJsZSB0bw0KZGVjaWRlIGxhdGUgd2hldGhlciB0aGV5IHdh
bnQgVERYIG9yIGtleGVjLg0KDQo+IA0KPiBJIGFtIG5vdCBzYXlpbmcgdGhpcyBkb2Vzbid0IHdv
cmssIGJ1dCBJTUhPIGl0IGlzIG1vcmUgc3RyYWlnaHRmb3J3YXJkIHRvIGp1c3QNCj4gbGV0IHVz
ZXIgbWFrZSBkZWNpc2lvbiB2aWEga2VybmVsIHBhcmFtZXRlci4NCg0KU3RyYWlnaHRmb3J3YXJk
LCB5ZXMgYWdyZWUuIEl0J3MgZWFzaWVyIHRvIGRvY3VtZW50IGFuZCB0aGUgY29kZSB3b3VsZCBi
ZQ0Kc2ltcGxlci4NCg0KSSdtIG9rIHRyeWluZyB0aGUgdGR4X2hvc3QgbWV0aG9kLCBidXQgSSBk
byB0aGluayB3ZSBuZWVkIGEgYmV0dGVyIHJlYXNvbiBmb3INCmhhdmluZyB0d28gdGR4IGtlcm5l
bCBwYXJhbWV0ZXJzIHdoZW4gdGhlcmUgaXMgb25seSBvbmUgdXNlcnMgb2YgVERYIHRvZGF5DQoo
S1ZNKS4NCg==

