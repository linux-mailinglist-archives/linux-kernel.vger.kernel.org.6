Return-Path: <linux-kernel+bounces-428557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7C69E1095
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 02:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89E882815A2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 01:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513C41EA84;
	Tue,  3 Dec 2024 01:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RQroEdCv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEBD2500A2
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 01:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733187713; cv=fail; b=l8YimzjenqfhC85lN3Es3REM+OBsoKCk1JSr+v+Q412fvjVLN9xw7GWAod0qc06mDp8ZZBCyYwnatMthPMeWESpHWG+MSG1m+QsRd9UlT/fVwIP2hMRBKUSP0CXX2JQr2EuvgkcTrtVpU9icnsG2A4oBeaO5IjePMlKK9zv960Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733187713; c=relaxed/simple;
	bh=6r3mXldTADbxisP2q04rHJkImRdlgi/oOjaHZFaA3CE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ReDZzJKB8w9ujO99vsnpthhKOSBDxN47tTCB8W10FyEbip11r0G5h/yAjMSnyFjXPe8ZyWIxoIdKjkk3rNoooW2UK0XmR6tqqKa3h3DAugGfQQV5E1FDbDI8xy3YpHcMpgrZCnwTAtzqM+57u62PcGIYsFANsyW47xkK75EZk6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RQroEdCv; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733187710; x=1764723710;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6r3mXldTADbxisP2q04rHJkImRdlgi/oOjaHZFaA3CE=;
  b=RQroEdCvuLgGzIVFW9z0JhJT31aPTNN+AMlCUef3AbSjWBwMreSI0HBk
   zYKJzd9H28135bk+GnhHIORPnQHfP5lwsXbdp1kYtmikmRlbLzG6GnXZU
   Jx9HtOFl1BHWgBURUc5NfOa2NcOwogdN4XY3uSH3C5QhgW9FrHwEFPdty
   rLiLrVwIP3a5Tn43/iCBa7tUcJtYRTTpg4y/tQjsuTqW4vquvcm4DM7i1
   b5nm+z1xGp8Ogenir3jDQhzIwvHum/HUqjr6A27VpRWK/XRBSVpcwpC05
   WNlUyBDgRKk0oehz3adfH2Szsb/sfy7HgbgApps9BOnsqSjRxvQ2eVabf
   Q==;
X-CSE-ConnectionGUID: n+JdDHaIQ3mhJ6KSO1L69w==
X-CSE-MsgGUID: kY4g+n2PTvCngkbEYBGt9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="44767663"
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="44767663"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 17:01:10 -0800
X-CSE-ConnectionGUID: hCJpMQuzSh6ShMRbnhQa7A==
X-CSE-MsgGUID: f+Kj3sdBT2yEIPod66Nq5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="98357369"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Dec 2024 17:01:09 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 2 Dec 2024 17:01:08 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 2 Dec 2024 17:01:08 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.43) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 2 Dec 2024 17:01:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=va+bwVdM98/FXjtDKPAPUDKbVWmN4Kbpxkyigp54Gv7KfWkkkjHs41Eapzpc3pBlXco6vWS7hMOpFea5+OT1SqKhBkBpq3e2srz7w6/mJgjQFwTzlrUGEpG5zQ3IKP3daqSMsDVpYtFFmIvA6OSlbwrWaVkEUPBnA7yhViF5IkwmaE1PRRTvGJFrcR7fGFGlgiBeBBUsqULgx8njUgPGJGLLn4Pe0L0WGoA8rpCKARI+2w4ptQ0ayZP8DR8J0THgB8FXvJ0/LmYgRu9crIjqkBh6sgcCZo+QS7LMZbrEa3SNf/jicBnE2pBJhZfzTxzuwYQKhcW8RmpCHjJSrNy3Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6r3mXldTADbxisP2q04rHJkImRdlgi/oOjaHZFaA3CE=;
 b=ZsK11JHhb+ef2aE+k9yAP6/ZGHqL+QDv/ewDu3k2haZuKUAm7hF4pqcFfmIfo4/Ti0e6Bmd42+mqJ7xRy9WqBA4wi4mtW8dB8N1oxoTD++c5Ibs87IEW/OSFI4iZGryhqf6eF7weGXABdbLzhukBB+d2bFrwbyNVlZb47JylAGLF60oVuG1bcJvr4Ij4LZvrdzSCkqpAR9lhMVVZ2Fa7J3dB621+O7/5Xgvy9p0A07+bex9sFoLu6g4rqB8YnsOC43+IVTWttafb758bMYN0hALRtfQwQDT5dnNqbZL3NfkRVfeko7ddenj4B+zqFxqzLIP8R2v/BFNLewaxkn1CEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by SA0PR11MB4702.namprd11.prod.outlook.com (2603:10b6:806:92::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 01:01:05 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 01:01:05 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Yosry Ahmed <yosryahmed@google.com>, Chengming Zhou
	<chengming.zhou@linux.dev>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "nphamcs@gmail.com" <nphamcs@gmail.com>,
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "ryan.roberts@arm.com"
	<ryan.roberts@arm.com>, "21cnbao@gmail.com" <21cnbao@gmail.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "Feghali, Wajdi K"
	<wajdi.k.feghali@intel.com>, "Gopal, Vinodh" <vinodh.gopal@intel.com>,
	"Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v1 2/2] mm: zswap: zswap_store_pages() simplifications for
 batching.
Thread-Topic: [PATCH v1 2/2] mm: zswap: zswap_store_pages() simplifications
 for batching.
Thread-Index: AQHbQR8zjJv99UT6akiirMMuSrWTzbLMRDGAgAcbawCAAFSwsA==
Date: Tue, 3 Dec 2024 01:01:05 +0000
Message-ID: <SJ0PR11MB56781233ABFE772C5991AB01C9362@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20241127225324.6770-1-kanchana.p.sridhar@intel.com>
 <20241127225324.6770-3-kanchana.p.sridhar@intel.com>
 <c9a0f00b-3aeb-467a-8771-a4ebb57fbba0@linux.dev>
 <CAJD7tkbPSQguHegkzN65==GHuNN9_RPm1FonnF8Bi=BsQDhxng@mail.gmail.com>
In-Reply-To: <CAJD7tkbPSQguHegkzN65==GHuNN9_RPm1FonnF8Bi=BsQDhxng@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|SA0PR11MB4702:EE_
x-ms-office365-filtering-correlation-id: bcee3093-9dc5-42c6-4ba6-08dd1335f6fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VjNOemJXRkpMVi92UFRZQ1MxVkpKUThtcUF5SjhqR3pLOE1GR2NYQzljbkVW?=
 =?utf-8?B?ZHlnVDBGc0V0TWhMWjlESkdqUlMvOGl5MXVxN09oVm1PSDlxaDV0TnJxTHZN?=
 =?utf-8?B?TkgzN1Awd0I4dU1rMDlpZHRnWVZNVW5hai9CdFMzVGhIWUUwRDJONmpOUldJ?=
 =?utf-8?B?NW0xSDkwSnI4UTRIRDRMVG5rNFArVEhTL0JNSnV3VncxTGJDN04vbnhKV3c5?=
 =?utf-8?B?VW9ieGR1NDhoc2x6SWp5Ly9ZZ053R3NTYUNwY2ZTYkF5R25rdmhCcURJNzVG?=
 =?utf-8?B?dU5YZWpmd2pnTmNHSCs1VW9LZytPWjNaa3ZXenhCY0gvWFhMMDROb2NWTUdV?=
 =?utf-8?B?c3g0RURVbmI4a0xXUFFoRWlRenZwU29JdndvNHdteHgrL05yRWJFQzZFOFdY?=
 =?utf-8?B?QUFTYUxCNFVUNnZRSzJTczVBMXFmMDRONmlVMExUYnhEaU41ejdETlc1blhh?=
 =?utf-8?B?RXJ3TmNIZE1BMFB5S2toM3ZlbC96VU0xRW5yeEdaMDFRdzNCUC95ZnZrbDBZ?=
 =?utf-8?B?REc2VHVkempjMmxtd3craFV5YTJZTm9EWk9BcDUvc002UXhIMzg4bUpPTGY1?=
 =?utf-8?B?bGpmYnlhNUtLeHpoTmp6RXZUMjZLeWtXRHdPalkvWUYxN0lqOWRjSnpRZ1Bp?=
 =?utf-8?B?L3U4SkRoOVNKRTlCZ2tSWmNuR2JEczZVWXVhbjJ6TDZ5WVZ0N3U2WTZuVmgr?=
 =?utf-8?B?VGpDR0pkS3d4L3lZVXdTSWRnYUVLR1BBQU5uTTFCWnNsR0drbW0yMWpmT1RO?=
 =?utf-8?B?aEdqbzBKL1gzRm42SWRYUG94bEdVeHZkTEZhTDJWajI1bnE2STFLZGF3ekFn?=
 =?utf-8?B?ZWcxdmd6ZnlJd3F6UGhJaXZBQVZNT1FiOGhkYmJNSmJGdkgwSFhUNDRYSUV4?=
 =?utf-8?B?Tm0rdTZBck8vV0RlOEtJVVB5Y0l2aEJlYW95RHpiODZNTkdheFJyZjkzdGVH?=
 =?utf-8?B?a0EwbFZRREJzQkNtb3RxVkFuczh2Y2xRWHJwZ1RBZ3VrK2RYV1ZSRXBTbmlk?=
 =?utf-8?B?OHN5bzFaQ2NSVlpFWHBMNFVRU2xzckd6bkN1TkpPdklrL0xRK0xCT3UxcWJ2?=
 =?utf-8?B?QXZsOXJYUnVmUkgzaEtNdjZoZnZ2azdVMG5DOTdXcHd4VmFEOVVEdWdZSjVv?=
 =?utf-8?B?dGNhNzlJTUk2SFg3MDI5ZWk4Skd2clRUMFRwV1hVZDlpR3Z3NUdZNHNBUHUz?=
 =?utf-8?B?SHdseE9zMStpYVFDc3oxbmpZN05Qbmg4TGFjWnBJcHZVblpDMU4xVjcrVHh0?=
 =?utf-8?B?TUZvRkw0VEJQR2lFcG1WTWtmMUdUcW5PYW01a09oclpxcld3MEFuSncxanRG?=
 =?utf-8?B?M2swY2NTcm93YTJTSnNwOWNRbUU1akpVYVNWOGx6bFpnQkdDNWFsUEVwK0ZM?=
 =?utf-8?B?aGowNlN1QmRqaDRqZ21LT1gwQ3F0Z0syQVZNS1FZOWhURnM0MXhPcjZOaHRK?=
 =?utf-8?B?bGduamFxd25UOGI3TWptY0FjcHhRZFB6ZkQwMGhUWkFDN2ozc1dhZVV3SjdZ?=
 =?utf-8?B?djlzdHdHZTdYZjcyM1krTVJsZGFjcFpha0tsby9BSmVBaGhwSjlkd3JsVFhF?=
 =?utf-8?B?YVhRa3RBUlUxb0dwRHhnYkJXUjg5NnVNdURzSVdGYkdmNytlZERCUkdjYjNW?=
 =?utf-8?B?SmJnSVVOYWhleW9tS21idVdBOGV5ZDIySVRVa21UOFUxV2tpblUvbWtkTzJq?=
 =?utf-8?B?N2lZTG9IT1N3RlZCY0x5REJYS0FxUUQxbm5IQk5ZQlI5SXVucEdzTUFZT3dV?=
 =?utf-8?B?UEphUTkxTUcrN0NuRlVKL3ZhTC9PUlRuVlE1RVVzVzE2blBZUnVmeHVNZmU3?=
 =?utf-8?B?ZXJPOHVaQXFNb0VvMVpqdXc1VmtkK25sYXUwZUlUWGdFYzNLaUUrZkpPYm0w?=
 =?utf-8?B?QjdNdC9lS3Fpa0lwQU9aa1JEWVhidGh4YzVtWnQxZU0yZGc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VDh5dmc4c3Q3d2daek1YcFlJQ3prRDNLNmtEWFFzbmVhS1R2UWtmdy91bnhC?=
 =?utf-8?B?SjBKcFRUc2dyZmlZa1JZQTlYejcrZ3grcUVUaTg1dFhNdVJoZ0ZRVG1FN3Zk?=
 =?utf-8?B?VG9hays4elFuTlUrMHpkK0I4OTdPZUFuekV1U25YYnFqNmVHbmdJSGcvUi8r?=
 =?utf-8?B?YVRTRm9jbzlmZ1NNdXhNdnlFRUFHUUZycWRsanR1bitCN1c1TkxLaGJoK3FU?=
 =?utf-8?B?VHlkVzBWZDlTVnU5RHRZVno1ZzBjNWE0ekl1MkdldGdsTE9ZVzdkUFF0NnRI?=
 =?utf-8?B?anN0cU94UnJybFE2MitUMHpwc1pJZHAzSVNaSEsvbnR6ZDVId3RVaGE2M2ta?=
 =?utf-8?B?WEF2K1NmcHN5NEVNMWJ3bDVyeWthcjh4c29tcVlyZURhU1REUE5jZjZaWUVM?=
 =?utf-8?B?MWx0Rm9Rbi9XaHNHaGQ4OWlmajdSaXRYQUtnOHZBT1NrVU9NZmc5UnROSjRM?=
 =?utf-8?B?YndrTlcvMm5MVnJ2bjBrL0V6eXFxNU9VcXpxaFkwQ3h3VnArYVo4QjNJOTgr?=
 =?utf-8?B?djZoRnRxNnBEdWNRSnh1UWZWc2F3TFNhL1psSDl0ZnI0cTBxRlp2dGNZU1N1?=
 =?utf-8?B?K21aNE9vcU42UmRjazhDUHFtZTB4VjR1WisyOUo3UHE3WjRtaFAxbklJMEpj?=
 =?utf-8?B?cnc2aVFLT25rSU5qQk4wRnZZVnRERnJjZWtQS1N5clVWdTVqQWVaVU1uZ2tj?=
 =?utf-8?B?OW1ETkZEVkdZVUlXMkRQcThKaHplcmd3OFF2U2RXTG1jWDlETW9BZHlOc1Iv?=
 =?utf-8?B?Q013TUNjSk41akt5ZW04TmhJMlpUbjBLdkFNZ1AzUmNqcEF3NmRXWVB2VzVT?=
 =?utf-8?B?NGVuZFQ0TFFOdFhTekRMQUU3YlFjQTBlazQ4M0VaeTdobHRPUnkwc2NkalhG?=
 =?utf-8?B?bFV0a2hlREVsR1hIU1AwTktnbFBhMVJDcUJ1aDA0VmhrUTdMeU1HUnRRMGdD?=
 =?utf-8?B?eFk0RDFlOXludkNEbjJTQlh1eTBndlVWSWJIU0xjTUxqUlFCQXpHcmU4VFZF?=
 =?utf-8?B?cnU1V1VEOW92NjVSS09CTVJwaDRWNkJmK1drY1RWRkRiaG5aU203OWN1RFQ2?=
 =?utf-8?B?bENmbTVwa0NSWVdpQ3ltWU9qS2YxZUlaVUdtQzRENnpxZEIyZ1VISVRTcUNk?=
 =?utf-8?B?bDJiVVVCdUtRYXB0SVBrVXQxb09PSXMvRnNFdmNuZHo4T3dqSmZYSFFhRGhI?=
 =?utf-8?B?dFhGcE5BeWtVNXNwWldDU1pZZGQrdEI3SkVnUHVDTzh0cllydWJVcFZpMWtC?=
 =?utf-8?B?YXMraTdZeWFvaHVTRTFmUWJMNHRValRielFhem1QWHNUT3hWVnliRTdSWjd5?=
 =?utf-8?B?Vjg5V1NVNmMyNkNvc3QwblY5TkVYaEZOT2YrUXJWSVBFSVB4V09iblJndzZM?=
 =?utf-8?B?WXFMQ0ZzaElCbGxUZ1ZNNXBFYUxSMXdpNzhXRk8vWFJtZkN5RWVtSDhqUldE?=
 =?utf-8?B?VzJRUmdYcGg2eXhwaGdmR21wNEpRTUpFNWp2aVVLbjlCcDRGNVN0Q0ltb1lH?=
 =?utf-8?B?QTRkRkdHVmQxUlNZWGphUjFWS1lPQTFCN2ZGWjEvNlYyL3hFcUNnOVhXeVRh?=
 =?utf-8?B?R1R6MzUzVVJ5VFBlTVBKa004TXVuRGRicnNrNDExd1UvVW9Kenl6ZnUwT1Bk?=
 =?utf-8?B?WkM5QWx4bDUvZVl5ODVSZjdodTlFdEZneHJzei9sZFFtRDZyTmJjb3JmRVpx?=
 =?utf-8?B?cW1DbmtZUDJhb1cwM24yK0VlbVN2UTJPSlZDK1VkK1JzbXhRWGtoT0VpazBW?=
 =?utf-8?B?d0xMb3JtTlVSNHE4bG1Lejg0V09XcnkvUk1vV0FjS21ETmtOYnZ4ZExPTURj?=
 =?utf-8?B?bGo4WVl4L0kzeWp6b0Z4N1NqdzJid2N3M1MwRGFzMVloWFRXb0hJUURLZUlo?=
 =?utf-8?B?VUdXMGNiSzNLTGF0MFVmaDZXeGVJYXJNd0NacEtNdHpwMVFrQnppMzJZbmJ6?=
 =?utf-8?B?REMreVFWTzJQcjhPbkt1QS9vRFhXWkVqaHJOdkF6Q3JmMExWWktvcjRuaWdD?=
 =?utf-8?B?NzJCZmdlVWlwVW9pTk1UNUJCMzNOSklMQ2lHbU5xNHhqUTVkSHQwMzdYdXNj?=
 =?utf-8?B?Vk95ZVMza094US80bHY0Q2wrcGhVRUsrYU9nTU5wNTNlbnlTQ1JLKzFuM2JV?=
 =?utf-8?B?blN4S0FxL3FwR2VqT1NNOHhPbWRlOEZRZnhnYXFETXdaWHZLMCtSUGFlTzZj?=
 =?utf-8?B?V0s3Y3FMWnVsNmxRSGFzTWNHb2w1bGZuMXRLbkFPdUY1aHA3UXZ6MmZKQXB6?=
 =?utf-8?B?NW9Nb0FUcm5oSEFWL1M1TUp4M0ZRPT0=?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bcee3093-9dc5-42c6-4ba6-08dd1335f6fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2024 01:01:05.4120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: klNGWUTcMAtvazx2yVjRKGxHeWgHvsh+JbhDF4OGPvFob2LQ5kd8/7HD9cekzPD0aadRBn5jtP+5up/bsXMkv7/6vKuuGS1Nf+LP0EX+IF0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4702
X-OriginatorOrg: intel.com

SGkgQ2hlbmdtaW5nLCBZb3NyeSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBG
cm9tOiBZb3NyeSBBaG1lZCA8eW9zcnlhaG1lZEBnb29nbGUuY29tPg0KPiBTZW50OiBNb25kYXks
IERlY2VtYmVyIDIsIDIwMjQgMTE6MzMgQU0NCj4gVG86IENoZW5nbWluZyBaaG91IDxjaGVuZ21p
bmcuemhvdUBsaW51eC5kZXY+DQo+IENjOiBTcmlkaGFyLCBLYW5jaGFuYSBQIDxrYW5jaGFuYS5w
LnNyaWRoYXJAaW50ZWwuY29tPjsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxp
bnV4LW1tQGt2YWNrLm9yZzsgaGFubmVzQGNtcHhjaGcub3JnOw0KPiBucGhhbWNzQGdtYWlsLmNv
bTsgdXNhbWFhcmlmNjQyQGdtYWlsLmNvbTsgcnlhbi5yb2JlcnRzQGFybS5jb207DQo+IDIxY25i
YW9AZ21haWwuY29tOyBha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnOyBGZWdoYWxpLCBXYWpkaSBL
DQo+IDx3YWpkaS5rLmZlZ2hhbGlAaW50ZWwuY29tPjsgR29wYWwsIFZpbm9kaCA8dmlub2RoLmdv
cGFsQGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MSAyLzJdIG1tOiB6c3dhcDog
enN3YXBfc3RvcmVfcGFnZXMoKSBzaW1wbGlmaWNhdGlvbnMNCj4gZm9yIGJhdGNoaW5nLg0KPiAN
Cj4gT24gV2VkLCBOb3YgMjcsIDIwMjQgYXQgMTE6MDDigK9QTSBDaGVuZ21pbmcgWmhvdQ0KPiA8
Y2hlbmdtaW5nLnpob3VAbGludXguZGV2PiB3cm90ZToNCj4gPg0KPiA+IE9uIDIwMjQvMTEvMjgg
MDY6NTMsIEthbmNoYW5hIFAgU3JpZGhhciB3cm90ZToNCj4gPiA+IEluIG9yZGVyIHRvIHNldCB1
cCB6c3dhcF9zdG9yZV9wYWdlcygpIHRvIGVuYWJsZSBhIGNsZWFuIGJhdGNoaW5nDQo+ID4gPiBp
bXBsZW1lbnRhdGlvbiBpbiBbMV0sIHRoaXMgcGF0Y2ggaW1wbGVtZW50cyB0aGUgZm9sbG93aW5n
IGNoYW5nZXM6DQo+ID4gPg0KPiA+ID4gMSkgQWRkaXRpb24gb2YgenN3YXBfYWxsb2NfZW50cmll
cygpIHdoaWNoIHdpbGwgYWxsb2NhdGUgenN3YXAgZW50cmllcyBmb3INCj4gPiA+ICAgICBhbGwg
cGFnZXMgaW4gdGhlIHNwZWNpZmllZCByYW5nZSBmb3IgdGhlIGZvbGlvLCB1cGZyb250LiBJZiB0
aGlzIGZhaWxzLA0KPiA+ID4gICAgIHdlIHJldHVybiBhbiBlcnJvciBzdGF0dXMgdG8genN3YXBf
c3RvcmUoKS4NCj4gPiA+DQo+ID4gPiAyKSBBZGRpdGlvbiBvZiB6c3dhcF9jb21wcmVzc19wYWdl
cygpIHRoYXQgY2FsbHMgenN3YXBfY29tcHJlc3MoKSBmb3INCj4gZWFjaA0KPiA+ID4gICAgIHBh
Z2UsIGFuZCByZXR1cm5zIGZhbHNlIGlmIGFueSB6c3dhcF9jb21wcmVzcygpIGZhaWxzLCBzbw0K
PiA+ID4gICAgIHpzd2FwX3N0b3JlX3BhZ2UoKSBjYW4gY2xlYW51cCByZXNvdXJjZXMgYWxsb2Nh
dGVkIGFuZCByZXR1cm4gYW4NCj4gZXJyb3INCj4gPiA+ICAgICBzdGF0dXMgdG8genN3YXBfc3Rv
cmUoKS4NCj4gPiA+DQo+ID4gPiAzKSBBICJzdG9yZV9wYWdlc19mYWlsZWQiIGxhYmVsIHRoYXQg
aXMgYSBjYXRjaC1hbGwgZm9yIGFsbCBmYWlsdXJlIHBvaW50cw0KPiA+ID4gICAgIGluIHpzd2Fw
X3N0b3JlX3BhZ2VzKCkuIFRoaXMgZmFjaWxpdGF0ZXMgY2xlYW5lciBlcnJvciBoYW5kbGluZyB3
aXRoaW4NCj4gPiA+ICAgICB6c3dhcF9zdG9yZV9wYWdlcygpLCB3aGljaCB3aWxsIGJlY29tZSBp
bXBvcnRhbnQgZm9yIElBQSBjb21wcmVzcw0KPiA+ID4gICAgIGJhdGNoaW5nIGluIFsxXS4NCj4g
PiA+DQo+ID4gPiBbMV06IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51
eC1tbS9saXN0Lz9zZXJpZXM9OTExOTM1DQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogS2Fu
Y2hhbmEgUCBTcmlkaGFyIDxrYW5jaGFuYS5wLnNyaWRoYXJAaW50ZWwuY29tPg0KPiA+ID4gLS0t
DQo+ID4gPiAgIG1tL3pzd2FwLmMgfCA5MyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKy0tLS0NCj4gLS0tLS0tLS0tDQo+ID4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA3MSBp
bnNlcnRpb25zKCspLCAyMiBkZWxldGlvbnMoLSkNCj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEv
bW0venN3YXAuYyBiL21tL3pzd2FwLmMNCj4gPiA+IGluZGV4IGIwOWQxMDIzZTc3NS4uZGI4MGM2
NmUyMjA1IDEwMDY0NA0KPiA+ID4gLS0tIGEvbW0venN3YXAuYw0KPiA+ID4gKysrIGIvbW0venN3
YXAuYw0KPiA+ID4gQEAgLTE0MDksOSArMTQwOSw1NiBAQCBzdGF0aWMgdm9pZCBzaHJpbmtfd29y
a2VyKHN0cnVjdCB3b3JrX3N0cnVjdA0KPiAqdykNCj4gPiA+ICAgKiBtYWluIEFQSQ0KPiA+ID4g
ICAqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqLw0KPiA+ID4NCj4gPiA+ICtzdGF0
aWMgYm9vbCB6c3dhcF9jb21wcmVzc19wYWdlcyhzdHJ1Y3QgcGFnZSAqcGFnZXNbXSwNCj4gPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgenN3YXBfZW50cnkgKmVudHJp
ZXNbXSwNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1OCBucl9wYWdlcywN
Cj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgenN3YXBfcG9vbCAq
cG9vbCkNCj4gPiA+ICt7DQo+ID4gPiArICAgICB1OCBpOw0KPiA+ID4gKw0KPiA+ID4gKyAgICAg
Zm9yIChpID0gMDsgaSA8IG5yX3BhZ2VzOyArK2kpIHsNCj4gPiA+ICsgICAgICAgICAgICAgaWYg
KCF6c3dhcF9jb21wcmVzcyhwYWdlc1tpXSwgZW50cmllc1tpXSwgcG9vbCkpDQo+ID4gPiArICAg
ICAgICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiA+ID4gKyAgICAgfQ0KPiA+ID4gKw0K
PiA+ID4gKyAgICAgcmV0dXJuIHRydWU7DQo+ID4gPiArfQ0KPiA+DQo+ID4gSG93IGFib3V0IGlu
dHJvZHVjaW5nIGEgYHpzd2FwX2NvbXByZXNzX2ZvbGlvKClgIGludGVyZmFjZSB3aGljaA0KPiA+
IGNhbiBiZSB1c2VkIGJ5IGB6c3dhcF9zdG9yZSgpYD8NCj4gPiBgYGANCj4gPiB6c3dhcF9zdG9y
ZSgpDQo+ID4gICAgICAgICBucl9wYWdlcyA9IGZvbGlvX25yX3BhZ2VzKGZvbGlvKQ0KPiA+DQo+
ID4gICAgICAgICBlbnRyaWVzID0genN3YXBfYWxsb2NfZW50cmllcyhucl9wYWdlcykNCj4gPg0K
PiA+ICAgICAgICAgcmV0ID0genN3YXBfY29tcHJlc3NfZm9saW8oZm9saW8sIGVudHJpZXMsIHBv
b2wpDQo+ID4NCj4gPiAgICAgICAgIC8vIHN0b3JlIGVudHJpZXMgaW50byB4YXJyYXkgYW5kIExS
VSBsaXN0DQo+ID4gYGBgDQo+ID4NCj4gPiBBbmQgdGhpcyB2ZXJzaW9uIGB6c3dhcF9jb21wcmVz
c19mb2xpbygpYCBpcyB2ZXJ5IHNpbXBsZSBmb3Igbm93Og0KPiA+IGBgYA0KPiA+IHpzd2FwX2Nv
bXByZXNzX2ZvbGlvKCkNCj4gPiAgICAgICAgIG5yX3BhZ2VzID0gZm9saW9fbnJfcGFnZXMoZm9s
aW8pDQo+ID4NCj4gPiAgICAgICAgIGZvciAoaW5kZXggPSAwOyBpbmRleCA8IG5yX3BhZ2VzOyAr
K2luZGV4KSB7DQo+ID4gICAgICAgICAgICAgICAgIHN0cnVjdCBwYWdlICpwYWdlID0gZm9saW9f
cGFnZShmb2xpbywgaW5kZXgpOw0KPiA+DQo+ID4gICAgICAgICAgICAgICAgIGlmICghenN3YXBf
Y29tcHJlc3MocGFnZSwgJmVudHJpZXNbaW5kZXhdLCBwb29sKSkNCj4gPiAgICAgICAgICAgICAg
ICAgICAgICAgICByZXR1cm4gZmFsc2U7DQo+ID4gICAgICAgICB9DQo+ID4NCj4gPiAgICAgICAg
IHJldHVybiB0cnVlOw0KPiA+IGBgYA0KPiA+IFRoaXMgY2FuIGJlIGVhc2lseSBleHRlbmRlZCB0
byBzdXBwb3J0IHlvdXIgImJhdGNoZWQiIHZlcnNpb24uDQo+ID4NCj4gPiBUaGVuIHRoZSBvbGQg
YHpzd2FwX3N0b3JlX3BhZ2UoKWAgY291bGQgYmUgcmVtb3ZlZC4NCj4gPg0KPiA+IFRoZSBnb29k
IHBvaW50IGlzIHNpbXBsaWNpdHksIHRoYXQgd2UgZG9uJ3QgbmVlZCB0byBzbGljZSBmb2xpbw0K
PiA+IGludG8gbXVsdGlwbGUgYmF0Y2hlcywgdGhlbiByZXBlYXQgdGhlIGNvbW1vbiBvcGVyYXRp
b25zIGZvciBlYWNoDQo+ID4gYmF0Y2gsIGxpa2UgcHJlcGFyaW5nIGVudHJpZXMsIHN0b3Jpbmcg
aW50byB4YXJyYXkgYW5kIExSVSBsaXN0Li4uDQo+IA0KPiArMQ0KDQpUaGFua3MgZm9yIHRoZSBj
b2RlIHJldmlldyBjb21tZW50cy4gT25lIHF1ZXN0aW9uIHRob3VnaDogd291bGQNCml0IG1ha2Ug
c2Vuc2UgdG8gdHJhZGUtb2ZmIHRoZSBtZW1vcnkgZm9vdHByaW50IGNvc3Qgd2l0aCB0aGUgY29k
ZQ0Kc2ltcGxpZmljYXRpb24/IEZvciBpbnN0YW5jZSwgbGV0cyBzYXkgd2Ugd2FudCB0byBzdG9y
ZSBhIDY0ayBmb2xpby4NCldlIHdvdWxkIGFsbG9jYXRlIG1lbW9yeSBmb3IgMTYgenN3YXAgZW50
cmllcywgYW5kIGxldHMgc2F5IG9uZSBvZg0KdGhlIGNvbXByZXNzaW9ucyBmYWlscywgd2Ugd291
bGQgZGVhbGxvY2F0ZSBtZW1vcnkgZm9yIGFsbCAxNiB6c3dhcA0KZW50cmllcy4gQ291bGQgdGhp
cyBsZWFkIHRvIHpzd2FwX2VudHJ5IGttZW1fY2FjaGUgc3RhcnZhdGlvbiBhbmQNCnN1YnNlcXVl
bnQgenN3YXBfc3RvcmUoKSBmYWlsdXJlcyBpbiBtdWx0aXBsZSBwcm9jZXNzZXMgc2NlbmFyaW9z
Pw0KDQpJbiBvdGhlciB3b3JkcywgYWxsb2NhdGluZyBlbnRyaWVzIGluIHNtYWxsZXIgYmF0Y2hl
cyAtLSBtb3JlIHNwZWNpZmljYWxseSwNCm9ubHkgdGhlIGNvbXByZXNzIGJhdGNoc2l6ZSAtLSBz
ZWVtcyB0byBzdHJpa2UgYSBiYWxhbmNlIGluIHRlcm1zIG9mDQptZW1vcnkgZm9vdHByaW50LCB3
aGlsZSBtaXRpZ2F0aW5nIHRoZSBzdGFydmF0aW9uIGFzcGVjdCwgYW5kIHBvc3NpYmx5DQphbHNv
IGhlbHBpbmcgbGF0ZW5jeSAoYWxsb2NhdGluZyBhIGxhcmdlICMgb2YgenN3YXAgZW50cmllcyBh
bmQgcG90ZW50aWFsbHkNCmRlYWxsb2NhdGluZywgY291bGQgaW1wYWN0IGxhdGVuY3kpLg0KDQpJ
ZiB3ZSBhZ3JlZSB3aXRoIHRoZSBtZXJpdHMgb2YgcHJvY2Vzc2luZyBhIGxhcmdlIGZvbGlvIGlu
IHNtYWxsZXIgYmF0Y2hlczoNCnRoaXMgaW4gdHVybiByZXF1aXJlcyB3ZSBzdG9yZSB0aGUgc21h
bGxlciBiYXRjaGVzIG9mIGVudHJpZXMgaW4gdGhlDQp4YXJyYXkvTFJVIGJlZm9yZSBtb3Zpbmcg
dG8gdGhlIG5leHQgYmF0Y2guIFdoaWNoIG1lYW5zIGFsbCB0aGUNCnpzd2FwX3N0b3JlKCkgb3Bz
IG5lZWQgdG8gYmUgZG9uZSBmb3IgYSBiYXRjaCBiZWZvcmUgbW92aW5nIHRvIHRoZSBuZXh0DQpi
YXRjaC4NCg0KPiANCj4gQWxzbywgSSBkb24ndCBsaWtlIHRoZSBoZWxwZXJzIGhpZGluZyBzb21l
IG9mIHRoZSBsb29wcyBhbmQgbGVhdmluZw0KPiBvdGhlcnMsIGFzIEpvaGFubmVzIHNhaWQsIHBs
ZWFzZSBrZWVwIGFsbCB0aGUgaXRlcmF0aW9uIG92ZXIgcGFnZXMgYXQNCj4gdGhlIHNhbWUgZnVu
Y3Rpb24gbGV2ZWwgd2hlcmUgcG9zc2libGUgdG8gbWFrZSB0aGUgY29kZSBjbGVhci4NCg0KU3Vy
ZS4gSSBjYW4gZWl0aGVyIGlubGluZSBhbGwgdGhlIGxvb3BzIGludG8genN3YXBfc3RvcmVfcGFn
ZXMoKSwgb3IgY29udmVydA0KYWxsIGl0ZXJhdGlvbnMgaW50byBoZWxwZXJzIHdpdGggYSBjb25z
aXN0ZW50IHNpZ25hdHVyZToNCg0KenN3YXBfPHByb2NfbmFtZT4oYXJyYXllZF9zdHJ1Y3QsIG5y
X3BhZ2VzKTsNCg0KUGxlYXNlIGxldCBtZSBrbm93IHdoaWNoIHdvdWxkIHdvcmsgYmVzdC4gVGhh
bmtzIQ0KDQo+IA0KPiBUaGlzIHNob3VsZCBub3QgYmUgYSBzZXBhcmF0ZSBzZXJpZXMgdG9vLCB3
aGVuIEkgc2FpZCBkaXZpZGUgaW50bw0KPiBjaHVua3MgSSBtZWFudCBsZWF2ZSBvdXQgdGhlIG11
bHRpcGxlIGZvbGlvcyBiYXRjaGluZyBhbmQgZm9jdXMgb24NCj4gYmF0Y2hpbmcgcGFnZXMgaW4g
YSBzaW5nbGUgbGFyZ2UgZm9saW8sIG5vdCBicmVha2luZyBkb3duIHRoZSBzZXJpZXMNCj4gaW50
byBtdWx0aXBsZSBvbmVzLiBOb3QgYSBiaWcgZGVhbCB0aG8gOikNCg0KSSB1bmRlcnN0YW5kLiBJ
IGFtIHRyeWluZyB0byBkZS1jb3VwbGUgYW5kIGRldmVsb3AgaW4gcGFyYWxsZWwgdGhlDQpmb2xs
b3dpbmcsIHdoaWNoIEkgaW50ZW5kIHRvIGNvbnZlcmdlIGludG8gYSB2NSBvZiB0aGUgb3JpZ2lu
YWwgc2VyaWVzIFsxXToNCiAgYSkgVmVjdG9yaXphdGlvbiwgZm9sbG93ZWQgYnkgYmF0Y2hpbmcg
b2YgenN3YXBfc3RvcmUoKSBvZiBsYXJnZSBmb2xpb3MuDQogIGIpIGFjb21wIHJlcXVlc3QgY2hh
aW5pbmcgc3VnZ2VzdGlvbnMgZnJvbSBIZXJiZXJ0LCB3aGljaCBjb3VsZA0KICAgICAgIGNoYW5n
ZSB0aGUgZXhpc3RpbmcgdjQgaW1wbGVtZW50YXRpb24gb2YgdGhlDQogICAgICAgY3J5cHRvX2Fj
b21wX2JhdGNoX2NvbXByZXNzKCkgQVBJIHRoYXQgenN3YXAgd291bGQgbmVlZCB0bw0KICAgICAg
IGNhbGwgZm9yIElBQSBjb21wcmVzcyBiYXRjaGluZy4NCg0KWzFdOiBodHRwczovL3BhdGNod29y
ay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtbW0vbGlzdC8/c2VyaWVzPTkxMTkzNQ0KDQpUaGFu
a3MsDQpLYW5jaGFuYQ0KDQo+IA0KPiA+DQo+ID4gVGhhbmtzLg0K

