Return-Path: <linux-kernel+bounces-434286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 759529E6463
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 03:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00ABF18840A2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 02:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4B6140360;
	Fri,  6 Dec 2024 02:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EIyS08L7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899264C9A
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 02:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733453162; cv=fail; b=hqRZBH8H6u3NlYb4CFKhG7dojf1UVsZG4vyxrkuzrSQrQSM+tdz3RTG0qA592AdPOVbAi1wkU9jvjWH+cyGPyKiX0ridwNIQT5ydcatTsmFw3i4phN+fcIciXdKCRwNmbNcKpEr2bdnp1nYOSlPZqLOyGD5ZWiVkIKb/eQ9x+Ho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733453162; c=relaxed/simple;
	bh=yuxJGOJvDKNJTm9DyKJ9oCvQxsfswatWNYhl6o1QlSY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JAt3j0mFvKD+HF0r2e9c4P9/hfzhZZIg99ekqJLiCGUu0rMMNxPcAJd79F1YtYSQ5m1y+/bJEIZBsVKtdTaV5PvCrf1IvzQPbom/gSJPSIqIoXp6NpBFFtHhWd+ervoldGGRVGajbhevvr8glsiUDJOHxpRe/WK5SFSZxR4QbIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EIyS08L7; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733453160; x=1764989160;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=yuxJGOJvDKNJTm9DyKJ9oCvQxsfswatWNYhl6o1QlSY=;
  b=EIyS08L7qkAgBU76/vpxf6+d/OAyTO53mdbojvr6vXLPGi7QH5h/C/Yf
   Oye6e+4mViXvBx9v+nIwV35flc2yQ/eRWDdxdU7uyv6i8ki98V+D+iJJM
   YU5oi1mW+hySiC5vOqNoJHKyLLriNNtnzrenWV4umxMcGMeUDv81TsErl
   JFTL4li6HcyhUXY8zE3U9V5EUfNWt+4mJQ0CcnNgCbshpq9lYDP59AHcq
   lJeQw2FhhQF33jkAPaKeTLAQwXGMKUV4RUhbytTL/bNmMFM/qN8cm0119
   4frn59aX1i4rT/4FIFgrroK/micqtwywGlPXaXG7GRD79LYz6QqzXLy4W
   A==;
X-CSE-ConnectionGUID: +Fh6dazZSxOojD+bTR3bSA==
X-CSE-MsgGUID: gFAW4iLJSoCVshx+f1Nfwg==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="51331994"
X-IronPort-AV: E=Sophos;i="6.12,212,1728975600"; 
   d="scan'208";a="51331994"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 18:45:58 -0800
X-CSE-ConnectionGUID: diEn8j4SQkuH+Q/5Pnqmpg==
X-CSE-MsgGUID: xVPDAMaeQcC3pj3CRGT+3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,212,1728975600"; 
   d="scan'208";a="98725977"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2024 18:45:51 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 5 Dec 2024 18:45:49 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 5 Dec 2024 18:45:49 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 5 Dec 2024 18:45:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DJ0YylujhEmDWw9+EstK9zOQDZ3xgEUIJhZIHltB+ujxgZ+Aaph87KknVQ+Y8q/sVXMEn8UJHfejD4lx3mIs7+/4/ehUBQLxsSFjRB7QAeDW+7xEM4H3DKFTs75X8FIRXUu4KMN1U3ybDAArgc+nhuCbzi24buSM6kOMnLsDMb0GJljI6fLmXX9HKl86Rq6+NLbwqd1KJbaX92qg7xLydmAjn938kdMGYR1iWQ5ek70D7TFNRQkBgYb2j4COZPBkwqAICPElTEcjg+5FEDVPOIXskk8K80EZNXr2Lok3tBVj++lOEN3xn9mNDAH1dne31GRZPrs/ypE82QM2cyTFtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yuxJGOJvDKNJTm9DyKJ9oCvQxsfswatWNYhl6o1QlSY=;
 b=KO7XLn8Hw2Hknin0mR+Va65y6VNEx46A9zx9c+aWIiCn+xbhQJuPeHWeOA3qXu6cPLi4sWozlb6HaDspzWbfzB/EN5jDKrVL1EgiajmaSY84ytLOX07F4Oxj3jc5F2amusg1uIcNuRUiTbUn4gnUEXQGoqnXr/uhedT8haAa45uQD0rO/SnJnbjp87vCmmWRYsTVf/DTEKzh03mNPDZZjDLF46QLDC0Mgd1pPxN94pik5ddqSq7aQM03vd23C26iB5Wun7jgjy6WijqplqN0xF5uN8xGEgBom11E7yooAyJD8BBE9UorIiD+oqeGQMhd+YnyZTPYDvng58v/Jvyakw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CH0PR11MB8143.namprd11.prod.outlook.com (2603:10b6:610:193::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Fri, 6 Dec
 2024 02:45:46 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%4]) with mapi id 15.20.8207.017; Fri, 6 Dec 2024
 02:45:46 +0000
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
Subject: Re: [PATCH v8 8.1/9] x86/virt/tdx: Reduce TDMR's reserved areas by
 using CMRs to find memory holes
Thread-Topic: [PATCH v8 8.1/9] x86/virt/tdx: Reduce TDMR's reserved areas by
 using CMRs to find memory holes
Thread-Index: AQHbRxLpcyNtIOXDR0KvQ+0YSsApfLLX87IAgACQCQA=
Date: Fri, 6 Dec 2024 02:45:46 +0000
Message-ID: <6df204490606e9c7323f2c0743416fab2d9e0f03.camel@intel.com>
References: <23bb421e9bf5443a823e163fb2d899760d9f14a3.1731498635.git.kai.huang@intel.com>
	 <20241205124005.92615-1-kai.huang@intel.com>
	 <0efe8492-e0da-4d97-8a6c-9cfe718f2d63@intel.com>
In-Reply-To: <0efe8492-e0da-4d97-8a6c-9cfe718f2d63@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.2 (3.54.2-1.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|CH0PR11MB8143:EE_
x-ms-office365-filtering-correlation-id: 12a2d932-7c21-4dff-351a-08dd15a01600
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dlQ0ci9seDV0QVB4dHpHcVlwSUl4bW1JSXhRY1poMTJXV1ZJdXF1ZVVoOEhV?=
 =?utf-8?B?RlNBMlkraDd5K3lQcThPNWlUOTc3SXRidmRwNllyVWk3RHU5T1FzL3pSRWtr?=
 =?utf-8?B?RkROV3RkdWhlZ1ByRWh0Y0Q0SlZIb20vTnlDMm1EVUpXTmRNMEpPRStqQ0xG?=
 =?utf-8?B?d2NJU2NVaGFJWG1RVDNUQWk0azhqYlFZMDVvcDMwbFNXenQyL3RudGRTUnNv?=
 =?utf-8?B?MEdKcHpOTUYvMHhlQzJScEdwYzM1ZGhDeFphK0o1NGxDMGVWVzJKN3YrWWxD?=
 =?utf-8?B?SjBHdnJVTVU5MFFobGhJWWNqbXFaNDRJb3JqUUtKb2RMOW1sa1lURXFwYXJx?=
 =?utf-8?B?bUZlOXhhbVdtY3JhSSs3ajRUV0RCbzZuS0xISzYxMWxCUE9DL1FRbXNnbzNK?=
 =?utf-8?B?elNqRWwvejhFRTVLTHJmSTRWYmlIc2tkTUNJZTNpM3llUVRnemQvdTgyaTFp?=
 =?utf-8?B?SVIxTGtDcEROVUwwb0h1emVqVXc3UkhFK1QxWVhNZnplTTRMYnJ3T29pcEFU?=
 =?utf-8?B?a1dzVC9lMUwwUVlXbHNLRGtIT2xBYkRDUGZCVVU4cWxnQVVuR0JBcG9zY0Ft?=
 =?utf-8?B?bzg2ZVJhY1ZwdkFWYnhWb0RrWm4yV1M5M29QSy9QRlpEZFNmK0RsSHZTak9i?=
 =?utf-8?B?czlNak9VT3RCZUw3dHg5K0VKd25DYUR4OS9PYkV3Rm1oK25BUG1IOTV3T2JO?=
 =?utf-8?B?L2l1WDJjM01xSVU4NW9MYzc5d1Vxdy9naTJBQW1OY3ZCRTdyRWhCUXBSd3hE?=
 =?utf-8?B?MnJycHREM1NPbkJiNTZ0UHdYc3BMQ1UyZlVUa0ZVcHI0S1gyQk5vS2hiNFJU?=
 =?utf-8?B?N0w2UGtxS3FuVjRHUVdWL2h4VUw2OWNzOVpBWEtZR1hUWkxkRmJCdm8zbEZF?=
 =?utf-8?B?WmQ3c1hZWDVUZXNFaFhwTFloRE1vaHkvWmEvUEZ5b21FOGRrcUVLelpkRmRk?=
 =?utf-8?B?RmZUWG1yNmYyWGtBVWZveEN1bURhc1lZbUZEVjlpekppeGM2Mm9YM3FDWGJC?=
 =?utf-8?B?TnhVSUhVOW9EYTdnZkxwVTBsRHRSZ3FyZlVyQ0dNbFVyR1l5dTJCMDN3d1hH?=
 =?utf-8?B?alFmcU1pdDVXcEE0ZzIxQytraTZicFlHS1JrNmJ4aVcwS0ladVd0WDlTTmFY?=
 =?utf-8?B?YmZiTysxdXdjTTlLdFB1NDMzNFo5U1Z5Wks3aEVuS1RqZDkwckYzM21jNWxK?=
 =?utf-8?B?aDNydktnajBEd2lvVUpDaWlVMFhuWXowc2tnekJxSEpyTGExY0hkZTJ6T1E1?=
 =?utf-8?B?eHl0QlRCRERTenZ3TEE1c21sbWpRZEc0WUpEdWpCdUhpTEdhL1lXckxTUVZV?=
 =?utf-8?B?NEg0aEphM0NpbjhmTlZGd2hlTEQ2WnpqT0l6UFFtRVdjNmRLTjl3UEdmQmZs?=
 =?utf-8?B?SzJYenc4TjE0MGd0MHM4YWo1QktONDE4YXpQQmtIT3ZMMHhySDRTUnFDYmxZ?=
 =?utf-8?B?Q2VaSmNiT1pEMms4NmJ4OWo2WG81QTdNMTVyQy9ZRXBrVyt1K0dnbnZNeDhD?=
 =?utf-8?B?bjRsRWwwKzJpeXFWNFhCRzRseHE2alJ0dDNXL1pXU3ZTWlB3ZjVrMGNvWkc4?=
 =?utf-8?B?ZjlSTDBtSnJFR2wvZTRoMXdMcFE0b09TSWs2VXYyUmdjTG84OG11dldvRGpt?=
 =?utf-8?B?TkFDN1htTFd0OU5ZaWtCWVN2L2RpQVlCd2R0SDNqdnRIckRISkc5Z01oL0E2?=
 =?utf-8?B?RS8ycHpjMXEyQWJ6aFgwV2J6dHVwK1UrRU5JU3RZYU5WdzNlK2h1VGhyNWt4?=
 =?utf-8?B?ckV3R1JXSVVLSlJSQmt0QnUra05MVWhZdVk4WXdJRTJjbWNJNW9Ddit6Mkpj?=
 =?utf-8?B?blB5VlNaak92dzh3Z1cyU2o3ZlR4ZnRWZmtrc3FpcUs0N3ZieE5OUFRoRCs1?=
 =?utf-8?B?RFhodjJjRFBKaElBSjhyczBaUnB3S0xDcmZSb3dPWWN0R0RMcGpBK2xqSVlU?=
 =?utf-8?Q?5QsmMNkYNZM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SXVGSE5IWHZOQ3RsR2tacmw4TTJxZ2tSdlQxditYTUxIVWp6N0U5MmYxMnZW?=
 =?utf-8?B?d1FRY2ZDV1luVWlwWU9Gc25nRUR3M1VFZGtYVVdma3IzOVpydlhRRC9sNWN3?=
 =?utf-8?B?a25jL24vMUt5WDdvOFhzdlJZQisvZ3ZBcHgyaFRBaXY0RS8rU2l5ZUZlMkRH?=
 =?utf-8?B?blkvczJMaEtza29MMjBsblRIdGgyZFpnNGM3N3B2K1JyRTVEUmpxRkdzamxC?=
 =?utf-8?B?NFNURjBpMHd4SWJhT3RVOTFjQWd5VFdHaTkwQkRCSGlrL1QxUUoyaTBVMmJO?=
 =?utf-8?B?dE5DbEV4QjQrTzVxdE5HTlFUMmhxck1yZmJlaVh2M04xQ09YY0toaVdkdThm?=
 =?utf-8?B?enRBSk5ZY1M4Y2VLcVBuQjdYVldBSXhqcVAvM2NyZDVFR0hXOWlkR0FESEcw?=
 =?utf-8?B?bXJ1UUpnTm9ZYUJ0Vmpzc0JGNUQ2TTRjbnp2YTV3NS81UlNuQ0JDOWFUUjV4?=
 =?utf-8?B?cnJkQ3JQaW9rT3VYS2E1MWFjQkxQUWE0Q2tGWHFpWCtGbitSZXkwZnUya0Jp?=
 =?utf-8?B?cTVWejJqdlY3aHZ4V0JWbmFBS2xZQllOTzI4ODB2NUVqRkJlWWRQVS9nbTlY?=
 =?utf-8?B?RGdReVc5RSs3VS9zeWpEUU0reVp0VjNRbFpzd2FWRldtalBubzloazljRFgw?=
 =?utf-8?B?cTBybUl3d1NOOXpRWW9CTE9nWTZvLzVoL1RkN2J3MnNZNEpnZ3N1TDJiMER2?=
 =?utf-8?B?Z1pZNUJoQVYveUZOMEh4M2hwUVFBVWp4OTdWYS9KSXhsMGNOSENjT2tpVnBO?=
 =?utf-8?B?UWNDWW1VVlZJOHBFc3NKM25tZkRRUDQwNXdkZ0JhTE53TFZyT2ppL0VKUG00?=
 =?utf-8?B?YmFJU3o2dHc5RmFBcGtGRlJXM0NXYk1KZEptVUE5azZadi9rV1FJVGVKS2pV?=
 =?utf-8?B?eDFvRUFNQTROd201Q2lXaFlXL0VwU3lTVTNmV3BYbi8zOUJrQjZ5a2RTNllL?=
 =?utf-8?B?RDlySnczbGFQaFdiZUpSWVF2WE1ZQzROaFlBc1pIb1VoMGxoWHlvdXNQeHhx?=
 =?utf-8?B?ek05dXlVZDRFVWliNGN6QU5DVVhDQ1E1cmZNZlhEVnFBUFMwYkFNNjBidE9z?=
 =?utf-8?B?bi9DSnJtL0NWQUtnUDlXUGxZdEVsbkJQV25Ca2VwRGFSTzRkc1dPZ3FJd2Mv?=
 =?utf-8?B?TWJlYkIvb2J5QVE1Sll0MVpZaGxXTEVKTWRCa210NklZb3czNTZ2TERxdFVa?=
 =?utf-8?B?YmZiTjRKT0s5T1oxWkRTZnZpTVlOanF0Z2Qxc3k5TXpWTnpyNzJZQk53eTZr?=
 =?utf-8?B?dDdiOVFLdlQ3a0MyOGp4ekJwVUJUUEI4V2dOUlg5UEtvdGk2aU44czY1RjZo?=
 =?utf-8?B?cTY5ckJUd2wxRnpLdDN0NVJRbDZ0dmg0Ukh3UDY1bEFmTEYyMW95NnZ1T3NF?=
 =?utf-8?B?bG5EZHNsUnFGc2dWZTVqVGRvOWlqM253SlRBWHZsNERCN1lyaStIWnNtblZk?=
 =?utf-8?B?TUpGaGJXMWZyaGF0T2tEYU0zVFN5Sk96eXQrTFlrSEUzK09BeXpQci9aUk1C?=
 =?utf-8?B?dm5YcXFOemZveEZQb3pzL2o1Z0xkbjVpbkJHS3dxaTJDUmpTelFwei9EeW93?=
 =?utf-8?B?blB0WndZbEV2UUt4U3dSbWFYOTYyNkJlT1lqY2pIQnYzQ3BYanJsam9oSk9x?=
 =?utf-8?B?MXVadW5OaEZZb2dCRlh2d2pOdzB6WTArM1paYWxwZUtrT0htRGZSdkwxdVE0?=
 =?utf-8?B?Nm9KTkluTm9UdEN3OGlGN0k2VGY5ZGp5S2F1ZXRFK2huMjdRMlNlZmNSOGI3?=
 =?utf-8?B?eFE4RkdMVWdKcFZVK3NzVFo4cDVaMnV3V0l4bDA0LzNwT3U3WllYRlBUNmhX?=
 =?utf-8?B?bDBBTStEWWd5UzJUNEJHWWhTeWlGc3d5elc5T2RxWEI2MkdkTWY0OTkvRTU2?=
 =?utf-8?B?RGJvZ2d4d2U5aDY0SFE1S2pya1V2Q21EcGkyTllWdFhnMlhRTTFOZER2MGFJ?=
 =?utf-8?B?Z0tURERoV2c5WmNqVlBwd1Y1eUtpa2hvTk0wLytUNStCQ2FHYThlNHBzVjNw?=
 =?utf-8?B?UFRaTmtiWVNTR0o4R095aVBtNDg0WnJQajhsRzJxOW1VTVhFaitjUVdzdmxR?=
 =?utf-8?B?dlg0aDE1M2ttRlhJdVMwNjh5MGJxdGZFMUs4bG84ZTVSeUtWVkdYa3gydHU2?=
 =?utf-8?Q?MjelHwvCtiXQWuCCT093WGLwv?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <54B98E7B677B6147BADC57A83DD939D1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12a2d932-7c21-4dff-351a-08dd15a01600
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2024 02:45:46.4285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DZ/8S7t6xDGwOqrSyimQcDqPGdzwVQ+79GSWriYH0IGQx+wTj+/7cPjwwxM5LGZfZpsvuUTk2MMf+CqG04iD7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8143
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI0LTEyLTA1IGF0IDEwOjEwIC0wODAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
T24gMTIvNS8yNCAwNDo0MCwgS2FpIEh1YW5nIHdyb3RlOg0KPiA+IEEgVERYIG1vZHVsZSBpbml0
aWFsaXphdGlvbiBmYWlsdXJlIHdhcyByZXBvcnRlZCBvbiBhIEVtZXJhbGQgUmFwaWRzDQo+ID4g
cGxhdGZvcm0gWypdOg0KPiA+IA0KPiA+ICAgdmlydC90ZHg6IGluaXRpYWxpemF0aW9uIGZhaWxl
ZDogVERNUiBbMHgwLCAweDgwMDAwMDAwKTogcmVzZXJ2ZWQgYXJlYXMgZXhoYXVzdGVkLg0KPiA+
ICAgdmlydC90ZHg6IG1vZHVsZSBpbml0aWFsaXphdGlvbiBmYWlsZWQgKC0yOCkNCj4gDQo+IFRo
ZXJlJ3MgYSAqTE9UKiBvZiBjaGFuZ2Vsb2cgaGVyZSwgYnV0IEknbSBub3Qgc3VyZSBob3cgbXVj
aCBvZiBpdCBpcw0KPiBhY3R1YWxseSByZWxldmFudCB0byB0aGUgcHJvYmxlbSBhdCBoYW5kLiBJ
IGFsc28gdGhpbmsgaXQncyB3cm9uZyB0byB0bw0KPiBwcmVzZW50IHRoZSBwcm9ibGVtIGFzIG9u
ZSBvZiBiZWluZyB0b28gZmluZS1ncmFpbmVkLg0KPiANCj4gQ291bGQgeW91IHBsZWFzZSByZXdv
cmsgdGhlIGNoYW5nZWxvZyBhbmQgdGhlIGNvbW1lbnRzIHRvIG1ha2UgdGhpcyBtb3JlDQo+IHN1
Y2NpbmN0Pw0KDQpUaGFua3MgZm9yIHRoZSBmZWVkYmFjay4gIFllYWggSSBhZ3JlZSB0aGV5IGNh
biBiZSBtb3JlIGNvbmNpc2UuICBJJ2xsIHVwZGF0ZQ0KYW5kIHNlbmQgb3V0IHRoZSB1cGRhdGVk
IHBhdGNoLg0K

