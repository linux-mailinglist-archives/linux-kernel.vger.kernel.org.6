Return-Path: <linux-kernel+bounces-438750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DD59EA517
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 03:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE19C16311F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 02:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CBD14A60F;
	Tue, 10 Dec 2024 02:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dvMSaH/v"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B7E1946DA
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 02:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733797610; cv=fail; b=XNdQP0LrES95hkus4zhjHBLulPM1CtfpO132ZCuqvL2dRWLois8V0XwVAuXmMLxHD31M7t37iWUHz9v8sEX4s5By4sBwgfzvuHliJzYjktzRIfgj6dKkRe/gTXpyTEuL6Ux87H90HhMLGTNTbN/FIYeYJYz6OBWZn96DXoHK25k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733797610; c=relaxed/simple;
	bh=EEN7TVmeY03NiNok8pTQFewcu9fl8B556Zu8UQOWLPM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bMEqz2rti4i6v/hHxgQ5E06GLqdaslgMrPacqLOzzw0SdsPXgHIUm4KtIFV37og5sFurYdhg8+/ahp758X535/hnG/GxzZkHQc2YS1wJli2rZpLeHtkA9eQuLerE8JPabFsknx/yMA4sJnZYoWl5zc2X9t5Hs1pot8/MIthtgOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dvMSaH/v; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733797608; x=1765333608;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=EEN7TVmeY03NiNok8pTQFewcu9fl8B556Zu8UQOWLPM=;
  b=dvMSaH/vDPX2DJVbbUXYN75OKfMlJzlMY/ptpp9eUkLKnsyX3fGRwMXV
   5sTGDRYgD7dD5D9HnN4pIwfDTp4/Yj9rouhq5lU7JCfQ0YM5wvcS+g6m5
   oeQccwtHNW0Vgux24FpPjDWycL6hiPXBrFuX/IBvVOWM4B7fsuXBUs0Tq
   omjYgBHkcUIaVDtUzQfYiERmQCJHg6AgntwmMBCyb7YabgoRMZJFwrZ7+
   OfwvKXcSzCyfiJ2f4abRXO/ONMbIfi35noTT9E3GN3Ept3ZNDxRN/e7/C
   06WvVeQ7XOQNUMCAsF1drvClh5EGOgONYumnEIJEjhdKd5eVivZA48JHt
   w==;
X-CSE-ConnectionGUID: NOZLkKuKTsGR5wXBlOS+OQ==
X-CSE-MsgGUID: Zq8kMFnZRaS6Fv5Ia7SM8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="44726162"
X-IronPort-AV: E=Sophos;i="6.12,221,1728975600"; 
   d="scan'208";a="44726162"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 18:26:47 -0800
X-CSE-ConnectionGUID: fyiAg9CzRhmE/hPTsrgJFA==
X-CSE-MsgGUID: FJs02b3TRRe86dOT2b3wyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,221,1728975600"; 
   d="scan'208";a="100211732"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Dec 2024 18:26:48 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Dec 2024 18:26:46 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Dec 2024 18:26:46 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 9 Dec 2024 18:26:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oNL/2gRboLsoqTfnZ9uWXGhNJVu7PusCDHITaB2vtHI3kgcXEyTcOAqKb8fyD+Fe7KRulcxWijWofxZsIQxYEtPGBcnS8FiNYHaMK+Lx4KXLfEZdvoa1SdDTEpAz1h+q5XGGsnK/LfCCXYQb4qa6tz7493r7d9i7xmr02nDuja7/O71TX3vVBBVPAb3P59LlGoaHu35uOm9lMp96PY/Y5fS0DzFgIxPrVATDYO9dBxoFo6ds8u48mcKWpSgCs6PpX+A9OE0pLGtfI0dgs9yqvcjG7BKICpDmoCFfpMhS6OFPp5iCnEWC1m62CgOGy2Ump6qgCv+qqGx0x9Ztf47c/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EEN7TVmeY03NiNok8pTQFewcu9fl8B556Zu8UQOWLPM=;
 b=uGGLAeSnqMbBzlOqLkIyxoV429eujbyuVCWTeHSRyVIxSXt3yNR/0WDtKAa/8/fuy6ZnbkqRBQTqvl5C5Sr0VJG6+lSiZGbBGPgxRNH8kpTXcpPfNDHvrmsyJloVzQWB5j3gxc/BWnrbPPTQ5+aAPTQxt0N6c3LUPFQlxvBSeratozwkRyxdMUSY8/U8ZoArqXnBiBJjEPRTh4K4pdiZZKFHeZWZXJCOD4ttkyR5/8iejvr94iq8eg3GDOkPgJG82JLN++Kr8TjO1EqE6wdWXX7vwI15gCXA4cDJao0+LxE2gEumIFmguc42QN9fIHVpDY73iBdMfnB2FtIhqlIfww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DS0PR11MB7383.namprd11.prod.outlook.com (2603:10b6:8:133::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 02:26:44 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%4]) with mapi id 15.20.8207.017; Tue, 10 Dec 2024
 02:26:44 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "Hansen, Dave" <dave.hansen@intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "bp@alien8.de" <bp@alien8.de>, "peterz@infradead.org"
	<peterz@infradead.org>, "hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "Williams, Dan J"
	<dan.j.williams@intel.com>
CC: "nik.borisov@suse.com" <nik.borisov@suse.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>, "x86@kernel.org" <x86@kernel.org>, "Yamahata,
 Isaku" <isaku.yamahata@intel.com>
Subject: Re: [PATCH v8 8.2/9] x86/virt/tdx: Reduce TDMR's reserved areas by
 using CMRs to find memory holes
Thread-Topic: [PATCH v8 8.2/9] x86/virt/tdx: Reduce TDMR's reserved areas by
 using CMRs to find memory holes
Thread-Index: AQHbSgauk8tDTyGydk+95/xr5jtt27LehpMAgAA7QoA=
Date: Tue, 10 Dec 2024 02:26:44 +0000
Message-ID: <83df85a3b318e6578628692ce0d28b9cf736061e.camel@intel.com>
References: <23bb421e9bf5443a823e163fb2d899760d9f14a3.1731498635.git.kai.huang@intel.com>
	 <20241209065016.242359-1-kai.huang@intel.com>
	 <78a359f8-5a0c-463c-b886-ff4165b395d2@intel.com>
In-Reply-To: <78a359f8-5a0c-463c-b886-ff4165b395d2@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.2 (3.54.2-1.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DS0PR11MB7383:EE_
x-ms-office365-filtering-correlation-id: bad43ec6-375f-4d57-84e1-08dd18c216c3
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MW5yNFB3QTJpYTZKcTc5bTlORnhmNVV4VzdCc0NVdG9Zazh1clIveGtJK1c5?=
 =?utf-8?B?TUdkUTdQWXBpajV2M01SeFByclZZYm93UnFFbzRlQ3ZBZW81aDBYeU9jUEx3?=
 =?utf-8?B?WllMSGxDeFRkc1BKSS9NT2tuTXc1SGhOdXk5K1NlZ1FEeEVWSE5CNDJSYUpX?=
 =?utf-8?B?TG5NQmtVamQ5TUYvdkNiTlM2RTYySUtlU0ZyRUZCVjFkRjNPNkZ1TGJUQXQ0?=
 =?utf-8?B?akYxK1lLSkt6dXBYYm5Vd0RBSTFWVlY4aThsRGRvbjdKcTBNZTM1aXczRVVm?=
 =?utf-8?B?eFBvZjI1bVI3Mjg5d3ozdE1QNjlzWm5UZ2RaSEVXVHBqaDFFbzlZMytlWjBs?=
 =?utf-8?B?OG9SUHpsVy9aL1kydnBENnp6blUrUUFoNVUwME5ZVGE1NUtGN3dONWwrWmRn?=
 =?utf-8?B?V0xpcUh2RlZLWSsxQlpHUUNkSVBMWEZqcVZHTWQ2eU4wOWo1WC83bzNCa2E3?=
 =?utf-8?B?dmVjNkRlU0VCRzBQU2IxZkIxenVSdjJidHZDdGRyVks3NWs1L1dZZUZXT3hs?=
 =?utf-8?B?bGdaaWRUVDF5S01hUnFqM1RJZDJrVkY4TDEzL3RxTlM1M3N3VEhMNzI0VUhw?=
 =?utf-8?B?WjNVNHFsMXl1U2pJTTN2MzNPcWoxU20xZ1hLTmQ1UmZxUlJQTXA4ZEx1Rmhr?=
 =?utf-8?B?STNabGVESFdxMThmRDBESElxR3Y1bFRyemFRNGluZG5LeWRpZ1lYb2E4VXZu?=
 =?utf-8?B?czF2Z2xRVGhKZ2hrMHhDQkJ0RWNQOFZ0MWNnZ28vQ1pJci9Qd0dkMmY1Uzkw?=
 =?utf-8?B?cVZxbHlHanhRM1EyU2pvdzA2NmcvbUtqRFdPMkpsQUYrWXVZU1IzWm96bkZ1?=
 =?utf-8?B?emswa1RWdWw4blNxTlZYTlZqQlluTHRMVDU1OFdCR3RRUjFFYUF1MmZURTVs?=
 =?utf-8?B?S2l0MThtYXZDQlJLaHprVlE4dzcxeDUreDlGSTMzanh4dTVYaCs2blUvTUFx?=
 =?utf-8?B?SlJwaHZsd0U5Tm0zS2tRNnNrRTFZYk1Dc0tnamNpSHpZNUxSUGJ1YWpKSHdJ?=
 =?utf-8?B?bDZ5NjVSRlRFYXZ5Q0h0c0Nuci9nZlZTWUVuM05VeisxcFk0cDV4MWk2Z2Zz?=
 =?utf-8?B?MkNydG5ZRTA0S2FvZXBUTzFuejFkeCtkb3hWY2plbW5OTXpkN2hnbVA3bGw0?=
 =?utf-8?B?MG9IbmNyVW1DalNRY0VDd0hYNit1ZW90Q3o2NG0vbm9sc2dzZ0JaQkJ6U2hp?=
 =?utf-8?B?aW9hVm1ReEtKaWd5b2ltOVBGNGUzbFN5U1MvSXowT1hIQkRxTzYzSHFXT21Q?=
 =?utf-8?B?WWloUUowblBZeEd2SVNaWWFPeFNNVGVUd0FGZW1aSGN4L3B1Ty9qNDk3NHpn?=
 =?utf-8?B?R2F2bi9RS0RPc1VBVXhrQjlJTXF0MUVZOUE5NnVrY2duc1E5ekVaR2ZtekZm?=
 =?utf-8?B?ZFNGVG13TVNOUncrcHBBRkRIeHNlYksrU0dMYWJRTVdtdi92ZkMwUVZyMVlG?=
 =?utf-8?B?REw3STJFN21FLzFkeFhCdmxBVWVvOWNaUHpjRU9DZjFGdFM1dCtURy82Ukpl?=
 =?utf-8?B?dTBtaE9rRmdUY1hmNFZCRFord3U5dEx1eW10STNtdkpqYTh6azZLcWRIZ3g5?=
 =?utf-8?B?SjBlWFJEV1hDOHRTZlQ5UVpaS1RXN0NLOUhyUDg1TnVJemc5SzM1S29uL29R?=
 =?utf-8?B?RDhXckJscUZHNk1qZTNyekhsbTl1Z3Z4eGVkelRYb2VTaWE5MjY5Qk5YaDQ5?=
 =?utf-8?B?L3A0dzB5d0FUWHNBMGx1Rk9aVUx0d1JpQ3ZxZ3pJWGxMZ0hHR2t2MVZ0TWtS?=
 =?utf-8?B?VXg0aUV2OGlyWXZuR0RINkN0WUYxOU1xSmF6cWZDbTJ1Y3BGWkZCMmZxTjlO?=
 =?utf-8?B?eEVBSjhVWDFiR3ZqZ1k2RG1vNytaTDBWL3VDTFlqTkNtN1JFNWhpeHRnV2Ew?=
 =?utf-8?B?Snp5eDJvOU93KytRcEhQM0JNOUwzSjFGQ3oyZlU3U05CVFEzUmp1eEtKMDVF?=
 =?utf-8?Q?jqoPTu+/3Dk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bkNSdHBCdHM4cW12clgvUlpFUHI4ejhwZHFrRE1TQ01MdHZHR2JqOC9JekpR?=
 =?utf-8?B?ZHVmNTNCWERSc2Nlb2M4NW5HMVhXaU1CVmFkci93SUFqMEtJNlRDUHFwNnJO?=
 =?utf-8?B?UkVWdXlIc0RIM1pqRi9GclU5bTUrWTVhSkdUQzFwT0c2VnRVQ2hwMDc4Wk5r?=
 =?utf-8?B?amV1ZVRMYTZlSVVmeDRidHl5QzZQYjdrRUJ5bFUva3ZQNnFCN3B0c3RnTHZV?=
 =?utf-8?B?Z1kvZVZTbEhIaEJKWkNzNzBGSmZRdEpIS1Q2Y1kyb3NTUERHS1ZQdmNGcTZJ?=
 =?utf-8?B?elR6YkJjYTNFYlR1Yk1yaThtOEEzang1RTZqZkcvSmZpVUoxWERoN05HTVZx?=
 =?utf-8?B?ejF6a01IQXFnQ0g2SldDaDdicExiMDRiSFFEOTgvaFRZU3Q2WkFyc0ZZZmhn?=
 =?utf-8?B?QXFoM1hjQXhtYzZJNTdPN1k1NDlXTHcvSzI4RmN3RWhHYlFrdVJpdjRuQjJR?=
 =?utf-8?B?bmhheDhvbGE5QVI5VldEQnVIZHR2QzB0bWxPMkhJVlBnSmx5ZFhNREdnWDAw?=
 =?utf-8?B?Y2hLWnZROXd3bmo1OTB2NDZiUWw3MEdCWE9WbHFydFAvbTZsM29aZk1wWjJ0?=
 =?utf-8?B?L2Vhb3A0eWdVRFNTY2FVUkFtaktva1ppcDh4b3JmYUd2cTdoYzdPaG1hblNX?=
 =?utf-8?B?RXM2NUU4RFd5K1graVFpTlNvZDR3V1phM09GS1FvRFpFelI0VDNvTi8ydU5J?=
 =?utf-8?B?R2RJVCtGWUpvUGRDcVJtdWwxazN5Snlwdm9KenlublZ5blg1WXhyVlM3cWZD?=
 =?utf-8?B?N211SW9ONFpDMWNTdGxrbmxIOTZCUFVyQU41a1N2cjdJMFhmelZiZElObnNH?=
 =?utf-8?B?azdiMEFwVVFoZDJ3cWNqYTZjNWdrTnVXWTdJazR0cEhheENFbkx6aU1xUjRT?=
 =?utf-8?B?anpNcUE0QWE4QjJsZEI1OG5MRGhWV21kMFlKYlk2Zmt1SnB0ajUxUTYzNUxN?=
 =?utf-8?B?dFJ3K3JFdmJkaXIvcmdpN3BOZktHMXhWZ1ErN0NvcTQrZlY4YnVTQVkvaHlk?=
 =?utf-8?B?QWlyci9kMjR3cGE1WEh3NWU1S1BTTnJ3QVNYc2VwbEpNNS9jNElsRjFBVVBX?=
 =?utf-8?B?djJsUlZaZDFsOWkrMkhXcS9ScVcxN01LdFlPTVJZWlB4S2wyVndpOTlVdVYv?=
 =?utf-8?B?b3JVN0RiVlpLbjg1dXZJT2g1Ym1tN2FYU29IT0QwWlA5cFI1UDR3Uy9nMkZQ?=
 =?utf-8?B?VXpDTm5ub0lTMmV4TlZ3WU5tQWdNaHN5NzZrZWhUNUFSMzR0VmYrNExPUFk5?=
 =?utf-8?B?aDArVURiMnhsNmY5SmNlRmtoQi8ycVR1Q1BCdHVZZmh0Q2tnczRQUDVlYTBa?=
 =?utf-8?B?cjhRR1dMUlBOVHVzQUY5M0twWjdrU2wrVlpwLzZySXpTWW52T2prKytQekJ6?=
 =?utf-8?B?aFJ0UlgzekVFVDFHa0NIdy9zemloTWprc3F2TG9kSThJR3paY3NQMUtCNEtv?=
 =?utf-8?B?aThvL1kyK1p6SndGRGxMVU5jM09ZdjRZS3plU0lGSGxMU3hYcFFBN0twUEFU?=
 =?utf-8?B?SHF0L0g0R3VtcmJFSkRDbzZCM21kWXNxYkhuZllGdGN3UVFiSUpLSkNEanBk?=
 =?utf-8?B?ZjUzVEZzRW9RSnAwWEIyay8rNm9RV0gzVkVKb3BLdi9EWGYvRGpHYmRzV2U0?=
 =?utf-8?B?NGFMTUNDTXR3UjZKQTFEWWI1Z012cll2NnI2VnFsSFU5SExNclVuc1pUS2o1?=
 =?utf-8?B?T1NndithcFpTanRlVnlSYjIrZnZURm1rL0lZdStPNmRXUUpidUlRZ3p3eXJz?=
 =?utf-8?B?dkhJQ1BKQ29OOVhYM3phSWl0RTRBcDZiQWFZaGRqaUQ3QzI2SU5hMi9CR0gv?=
 =?utf-8?B?d09ZeU1PMEZma3lPUmpZcFAvenlyL01rRUhTd1ZwODB0bFNxTkVlQVRoMjcw?=
 =?utf-8?B?a0ZTdnRzdVRwMmdodWx4V3BCcS9PaEN0TytWeS9JVEhrVmh1Skk2NGxuNWsx?=
 =?utf-8?B?RlRTWFMveDIxbXZ3SFZvY2hDeG1xM0xtN2duajZyVmhJMzZiZGxsWFV3Mnpl?=
 =?utf-8?B?cVU1cmRyWk8yZXBrbUpzVWU2YTZwdzJSMGFiRmR0UXNPczJRTE9CZTNlQU5T?=
 =?utf-8?B?Z3VPUlJkMmYrY29oRlNDNDVMdWFvck56SjRNZSs4SnI4NWd6Yy9IM0o1MWRH?=
 =?utf-8?B?b2Jqd2lqbGFHV0pDTmlkS1JveDU4RlFGazJaZndhSWJXdnZ1V2xEa1RuN2JM?=
 =?utf-8?B?N2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1B920F8ED0126A43AEAA226E27FA2BDA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bad43ec6-375f-4d57-84e1-08dd18c216c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2024 02:26:44.0898
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /5OG4WTSVwq2/kdUzj5wUUC0sJLl03+1tepVsF9Wd+147zhk0gDa6O2xm5rf+2V/CdHsPkItEXOHnoWSEjSXHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7383
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTEyLTA5IGF0IDE0OjU0IC0wODAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
T24gMTIvOC8yNCAyMjo1MCwgS2FpIEh1YW5nIHdyb3RlOg0KPiA+IEEgVERYIG1vZHVsZSBpbml0
aWFsaXphdGlvbiBmYWlsdXJlIHdhcyByZXBvcnRlZCBvbiBhbiBFbWVyYWxkIFJhcGlkcw0KPiA+
IHBsYXRmb3JtIFsqXToNCj4gPiANCj4gPiAgIHZpcnQvdGR4OiBpbml0aWFsaXphdGlvbiBmYWls
ZWQ6IFRETVIgWzB4MCwgMHg4MDAwMDAwMCk6IHJlc2VydmVkIGFyZWFzIGV4aGF1c3RlZC4NCj4g
PiAgIHZpcnQvdGR4OiBtb2R1bGUgaW5pdGlhbGl6YXRpb24gZmFpbGVkICgtMjgpDQo+ID4gDQo+
ID4gVGhlIGtlcm5lbCBpbmZvcm1zIHRoZSBURFggbW9kdWxlIG9mICJURFgtdXNhYmxlIG1lbW9y
eSByZWdpb25zIiB2aWEgdGhlDQo+ID4gc3RydWN0dXJlICJURCBNZW1vcnkgUmVnaW9uIiAoVERN
UikuICBFYWNoIFRETVIgY29udGFpbnMgYSBsaW1pdGVkDQo+ID4gbnVtYmVyIG9mICJyZXNlcnZl
ZCBhcmVhcyIgdG8gaW5mb3JtIHRoZSBURFggbW9kdWxlIG9mIHRoZSByZWdpb25zIHRoYXQNCj4g
PiBjYW5ub3QgYmUgdXNlZCBieSBURFguDQo+ID4gDQo+ID4gVGhlIGtlcm5lbCBidWlsZHMgdGhl
IGxpc3Qgb2YgIlREWC11c2FibGUgbWVtb3J5IHJlZ2lvbnMiIGZyb20gbWVtYmxvY2sNCj4gPiAo
d2hpY2ggcmVmbGVjdHMgZTgyMCkgYW5kIG1hcmtzIGFsbCBtZW1vcnkgaG9sZXMgYXMgInJlc2Vy
dmVkIGFyZWFzIiBpbg0KPiA+IFRETVJzLiAgSXQgdHVybnMgb3V0IG9uIHNvbWUgbGFyZ2Ugc3lz
dGVtcyB0aGUgaG9sZXMgaW4gbWVtYmxvY2sgY2FuIGJlDQo+ID4gdG9vIGZpbmUtZ3JhaW5lZCBb
MV0gYW5kIGV4Y2VlZCB0aGUgbnVtYmVyIG9mIHJlc2VydmVkIGFyZWFzIHRoYXQgdGhlDQo+ID4g
bW9kdWxlIGNhbiB0cmFjayBwZXIgVERNUiwgcmVzdWx0aW5nIGluIHRoZSBmYWlsdXJlIG1lbnRp
b25lZCBhYm92ZS4NCj4gPiANCj4gPiBUaGUgVERYIG1vZHVsZSBhbHNvIHJlcG9ydHMgVERYLWNh
cGFibGUgbWVtb3J5IGFzICJDb252ZXJ0aWJsZSBNZW1vcnkNCj4gPiBSZWdpb25zIiAoQ01Scyku
ICBDTVJzIHRlbmQgdG8gYmUgY29hcnNlci1ncmFpbmVkIFsyXSB0aGFuIHRoZSBlODIwLg0KPiA+
IFVzZSBDTVJzIHRvIGZpbmQgbWVtb3J5IGhvbGVzIHdoZW4gcG9wdWxhdGluZyByZXNlcnZlZCBh
cmVhcyB0byByZWR1Y2UNCj4gPiB0aGVpciBjb25zdW1wdGlvbi4NCj4gPiANCj4gPiBOb3RlIHRo
ZSBrZXJuZWwgZG9lcyBub3QgcHJldmVudCBub24tQ01SIG1lbW9yeSBmcm9tIGJlaW5nIGFkZGVk
IHRvDQo+ID4gIlREWC11c2FibGUgbWVtb3J5IHJlZ2lvbnMiIGJ1dCBkZXBlbmRzIG9uIHRoZSBU
RFggbW9kdWxlIHRvIGNhdGNoIGluDQo+ID4gdGhlIFRESC5TWVMuQ09ORklHLiAgQWZ0ZXIgc3dp
dGNoaW5nIHRvIHVzaW5nIENNUnMgdG8gcG9wdWxhdGUgcmVzZXJ2ZWQNCj4gPiBhcmVhcyB0aGlz
IHdpbGwgbm8gbG9uZ2VyIHdvcmsuICBUbyBlbnN1cmUgbm8gbm9uLUNNUiBtZW1vcnkgaXMgaW5j
bHVkZWQNCj4gPiBpbiB0aGUgVERNUnMsIHZlcmlmeSB0aGF0IHRoZSBtZW1vcnkgcmVnaW9uIGlz
IHRydWx5IFREWCBjb252ZXJ0aWJsZQ0KPiA+IGJlZm9yZSBhZGRpbmcgaXQgYXMgYSBURFgtdXNh
YmxlIG1lbW9yeSByZWdpb24gYXQgZWFybHkgc3RhZ2UuDQo+IA0KPiBUaGFua3MgZm9yIHRyaW1t
aW5nIHRoZSBjaGFuZ2Vsb2cgZG93bi4gIEJ1dCB0aGlzIGNoYW5nZWxvZyBuZXZlcg0KPiBhY3R1
YWxseSBzYXlzIHdoYXQgdGhlIGZpeCBpcy4gSXQncyBhbHNvIHF1aXRlIGhlYXZ5IG9uIHRoZSAi
d2hhdCIgYW5kDQo+IHZlcnkgbGlnaHQgb24gdGhlICJ3aHkiLg0KPiANCj4gSSB0aGluayB0aGUg
IndoeSIgYm9pbHMgZG93biB0byB0aGUgZmFjdCB0aGF0IHRoZSBrZXJuZWwgaXMgdHJlYXRpbmcg
UkFNDQo+IC0tIGFzIGRlZmluZWQgYnkgdGhlIHBsYXRmb3JtIGFuZCBURFggbW9kdWxlIC0tIGFz
IG5vbi1SQU0uDQoNClllcy4NCg0KPiANCj4gPiAtCXJldCA9IHRkbXJzX3BvcHVsYXRlX3JzdmRf
YXJlYXNfYWxsKHRkbXJfbGlzdCwgdG1iX2xpc3QsDQo+ID4gKwkvKg0KPiA+ICsJICogT24gc29t
ZSBsYXJnZSBzeXN0ZW1zLCB0aGUgVERYIG1lbW9yeSBibG9ja3MgKHdoaWNoIHJlZmxlY3RzDQo+
ID4gKwkgKiBlODIwKSBpbiB0aGUgZmlyc3QgMUdCIGNhbiBiZSB0b28gZmluZS1ncmFpbmVkLiAg
VXNpbmcgdGhlbQ0KPiA+ICsJICogdG8gcG9wdWxhdGUgcmVzZXJ2ZWQgYXJlYXMgbWF5IHJlc3Vs
dCBpbiByZXNlcnZlZCBhcmVhcyBiZWluZw0KPiA+ICsJICogZXhoYXVzdGVkLiAgQ01ScyBhcmUg
Y29hcnNlci1ncmFpbmVkIHRoYW4gZTgyMC4gIFVzZSBDTVJzIHRvDQo+ID4gKwkgKiBwb3B1bGF0
ZSByZXNlcnZlZCBhcmVhcyB0byByZWR1Y2UgdGhlaXIgY29uc3VtcHRpb24uDQo+ID4gKwkgKi8N
Cj4gDQo+IEkgdGhpbmsgdGhlcmUgYXJlIHN0aWxsIHRvbyBtYW55IGRldGFpbHMgaGVyZSBmb3Ig
YSBjb21tZW50LiBUaGlzDQo+IGNvbW1lbnQgaXMgZGVzY3JpYmluZyAqaGlnaGx5KiBpbXBsZW1l
bnRhdGlvbiBhbmQgcGxhdGZvcm0tc3BlY2lmaWMNCj4gZGV0YWlscyBwYXJ0aWN1bGFyIHRvIHRo
aXMgYnVnIHlvdSBhcmUgZml4aW5nIHRvZGF5LiBUaGV5IHdpbGwgYmUNCj4gaXJyZWxldmFudCB0
byBhbnlvbmUgcmVhZGluZyB0aGlzIGNvZGUgdG9tb3Jyb3cuDQo+IA0KPiBTbyBpbiB0aGUgZW5k
LCBJIGJ1eSB0aGF0IHRoZSBDTVIncyBoYXZlIHNvbWV0aGluZyB0byBvZmZlciBoZXJlLiBCdXQg
SQ0KPiB0aGluayB0aGF0ICJ3aHkiIEkgbWVudGlvbmVkIGFib3ZlIGNhc3RzIGRvdWJ0IG9uIHdo
ZXRoZXINCj4gZm9yX2VhY2hfbWVtX3Bmbl9yYW5nZSgpIGlzIHRoZSByaWdodCBwcmltaXRpdmUg
b24gd2hpY2ggdG8gYnVpbGQgdGhlDQo+IFREWCBtZW1ibG9ja3MgaW4gdGhlIGZpcnN0IHBsYWNl
Lg0KDQpXZSBjYW4gY2hhbmdlIHRvIGp1c3QgdXNlIENNUnMgYXMgVERYIG1lbW9yeSBibG9ja3Ms
IGkuZS4sIGFsd2F5cyBjb3ZlciBhbGwgQ01Scw0KaW4gVERNUnMsIGJ1dCB0aGlzIHdpbGwgaGF2
ZSBtdWNoIHdpZGVyIGltcGFjdC4NCg0KVGhlIG1haW4gY29uY2VybiBpcyB0aGUgUEFNVCBhbGxv
Y2F0aW9uOiBQQU1UIGlzIGFsbG9jYXRlZCBmcm9tIHBhZ2UgYWxsb2NhdG9yLA0KYnV0IHRoZSBD
TVJzIC0tIHRoZSBSQU0gYXMgZGVmaW5lZCBieSB0aGUgcGxhdGZvcm0gYW5kIHRoZSBURFggbW9k
dWxlIC0gLSBjYW4NCmNvdmVyIG1vcmUsIGFuZCBzb21ldGltZXMgbXVjaCBtb3JlLCByZWdpb25z
IHRoYW4gdGhlIHJlZ2lvbnMgZW5kIHVwIHRvIHRoZSBwYWdlDQphbGxvY2F0b3IuDQoNCkUuZy4s
IHRvZGF5IHdlIGNhbiB1c2UgJ21lbW1hcD0nIHRvIHJlc2VydmUgcGFydCBvZiBtZW1vcnkgZm9y
IG90aGVyIHB1cnBvc2UuIA0KQW5kIGluIHRoZSBmdXR1cmUgQ01ScyBtYXkgY292ZXIgQ1hMIG1l
bW9yeSByZWdpb25zIHdoaWNoIGNvdWxkIGJlIG11Y2ggbGFyZ2VyDQpJSVVDLg0KDQpJZiB3ZSBj
aGFuZ2UgdG8gY292ZXIgQ01ScyBpbiBURE1Scywgd2UgY291bGQgZW5kIHVwIHdpdGggYSBtdWNo
IGxhcmdlciBURE1SDQpyYW5nZXMuICBJbiB0aGlzIGNhc2Ugd2UgbWF5IGVuZCB1cCB3aXRoIHdh
c3RpbmcgUEFNVHMgKGUuZy4sIGlmIHRoZSBhZG1pbiB3YW50cw0KdG8gdXNlIENYTCBmb3Igb3Ro
ZXIgbm9uLVREWCBwdXJwb3NlKSwgaW5jcmVhc2luZyB0aGUgZmFpbHVyZSByYXRlLCBvciBhDQpj
b21wbGV0ZSBmYWlsdXJlIG9mIFBBTVQgYWxsb2NhdGlvbi4NCg0KPiBJIHN1c3BlY3QgdGhlcmUn
cyBhIG11Y2ggc2ltcGxlciBzb2x1dGlvbiB0aGF0IHdpbGwgZW1lcmdlIHdoZW4NCj4gY29uc2lk
ZXJpbmcgYSBkZWVwZXIgZml4IGFzIG9wcG9zZWQgdG8gYWRkaW5nIENNUnMgYXMgYSBiYW5kLWFp
ZC4NCg0KSSBkb24ndCBoYXZlIGFuIGltbWVkaWF0ZSBzb2x1dGlvbiBvdGhlciB0aGFuIHVzaW5n
IENNUnMgdG8gZmlsbCB1cCByZXNlcnZlZA0KYXJlYXMuICBJIHdpbGwgdGhpbmsgbW9yZS4NCg0K
UGVyaGFwcyB3ZSBjYW4gdHJ5IHRvIHNwbGl0IHRoZSBURE1SIHRvIG1ha2UgaXQgY292ZXIgbGVz
cyByZXNlcnZlZCBhcmVhcy4gIEJ1dA0KdGhpcyB3b24ndCB3b3JrIHdoZW4gdGhlIFRETVIgaXMg
YWxyZWFkeSAxR0IuICBBbmQgdGhpcyB3aWxsIHJlc3VsdCBpbiBuZXcgY2FzZXMNCndoZXJlICJv
bmUgVERYIG1lbW9yeSBibG9jayBjYW4gZW5kIHVwIHRvIG11bHRpcGxlIFRETVJzIiBldGMuICBU
byBtZSBpdCdzIG92ZXItDQpjb21wbGljYXRlZCBhbmQgaXMgbm90IGFzIGdvb2QgYXMgdXNpbmcg
dGhlIENNUi4gIChUaGlzIGlzIGxpc3RlZCBhcyBhbg0KYWx0ZXJuYXRpdmUgaW4gdGhlIGluaXRp
YWwgY2hhbmdlbG9nIGJ1dCB3YXMgcmVtb3ZlZCB0byB0cmltIGRvd24gdGhlIGxvZykuDQoNCkJ0
dywgUmljayBpcyBjb25jZXJuaW5nIHdpdGggdGhlIG92ZXJhbGwgS1ZNIFREWCB1cHN0cmVhbSBi
ZWNhdXNlIHRoaXMgc2VyaWVzIGlzDQphIGRlcGVuZGVuY3kgdG8gdGhlIHJlc3QgS1ZNIFREWCBw
YXRjaGVzLiAgVGVjaG5pY2FsbHkgdGhpcyBidWdmaXggaXMgbm90DQpyZWxhdGVkIHRvIHRoZSBL
Vk0gVERYIHN1cHBvcnQuICBXZSBhcmUgZ29pbmcgdG8gbG9vayBhdCBkcm9wcGluZyB0aGUgQ01S
IHN0YWZmDQpmb3Igbm93ICh0aGUgY29kZSB3aGljaCByZWFkcyBDTVJzIGluIHBhdGNoIDMsIGFu
ZCBwYXRjaCA3LTgpLCBhcyB0aGUgVERYIEtWTQ0KcGF0Y2hlcyBjYW4gbGl2ZSB3aXRob3V0IGl0
IGZvciBpbml0aWFsIHN1cHBvcnQuDQoNCg0K

