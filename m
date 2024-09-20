Return-Path: <linux-kernel+bounces-333928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2BE97CFEE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 04:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36A221F24E21
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 02:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36754C148;
	Fri, 20 Sep 2024 02:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d2R6MLM0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63F9BA34
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 02:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726800208; cv=fail; b=gtw1uGayBUlAPOh2iiy9K4JwosIvebBI1exuY66c7aigGdLVJTJu5DGB0vxQBF3wh1ZEK3o/MgmZZraw3IEXTXempQG1hv2u4XlegZwc33j4jQkZl407SKmdmcaOi2rSkOx3lY0Fl+3zhGNM14rtD/zNE2xwCjAVeYNlJ8dB7k4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726800208; c=relaxed/simple;
	bh=EsZeiqQbACDHuOqQGpFP9JvhGaClYmeFUOHsJkjqqAQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h0bXOXn7f8gblXbbG+MoBtZL09mFsSSFJOtWhYDwCPl97CwdIABEr/I7xMoMXyLN1w5XLeoWVaIGZe36e+/73aP97ULlrOQ0lrOlrkDejosUUNItqXJSo8irY4AfdInvF7Cj3mLuSvhu9qHo9nWq/D8aJPOHCz/1qzfTN8kyMNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d2R6MLM0; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726800207; x=1758336207;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EsZeiqQbACDHuOqQGpFP9JvhGaClYmeFUOHsJkjqqAQ=;
  b=d2R6MLM06pZSZ5rw8M+sBRNCB0Z850TQydWRc/4ZnGjLx+3pi0s7arN5
   o3fNn9kOesDJr1rlhDr8U793g/5aQlrjSokprwmS0WiSNSW9onc66A5+t
   a7pmKOxabZPmmB9U43RS1pfvSbii3A1v2PQvXNIMt22T/2A0qnNVVHHh2
   pr7UDDo9N6oBp/vQe8t3WRsGsSAObHGEgScYSUuSvJGTS/hm9kgWlOcyA
   Mq264QEkn3QtsWJ2hBjd1bXJ7/9smq1BkAJqbsdD/me0KMsRsTdDKSnTX
   6J6Rpo3F3ktYBO+grwSSaiOHdkI9GRzWSdSUtwRDOe9/0mebqnxbNM5Re
   w==;
X-CSE-ConnectionGUID: z19YHdDdS0SK8n2vqFxDTw==
X-CSE-MsgGUID: qD8uTyVETVSd9lojwDpLHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="25667513"
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; 
   d="scan'208";a="25667513"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 19:43:24 -0700
X-CSE-ConnectionGUID: KsvgLFrOS82z3HtDhLC0YQ==
X-CSE-MsgGUID: MLo+pF8QQNa5+1zd5yVToQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; 
   d="scan'208";a="69730612"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Sep 2024 19:43:22 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 19:43:22 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 19 Sep 2024 19:43:22 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Sep 2024 19:43:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VzghpYTDjsSZrrn4uLPqFr8q1Er0eh14TdpZqbbn3xHKhiaNlNa70kK4+cDn6MapqD0peKMTIGwXHmtO7hImuf5VEzfZ8+9MJ+Wrr5Dr5C6u2rFUV0mG/p7Z+C66FZI6LnChXrvb19fEttFFiMurx6XGEo9vIFNmwDW5kVkHT1vCrJP4ghGnnujmnsEgLFHYHrmBGgHSebuwbyzj6W8Hh4nPDw4tBoBF07Q2ZT2HUsVgvv0ck2irF/YgXDj2l4zkYwYb+uOVrzuZwLcRvfCglUuD4w0YXog4THrO3jPPs+gpw1yleBq3XVl05IZwfpqCvAhyivHH2MBvoB3q//wDfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EsZeiqQbACDHuOqQGpFP9JvhGaClYmeFUOHsJkjqqAQ=;
 b=Kh8jum7h5Q6LKKxN3K+uJ/k4hpjHt5jD0XzEEyZ7nA6pTRYxZAJsFxlcSfSH2UEo+/O5W0/VWmPERPFyZ88TrqlDMUWM9TLbspdKrnx82TEazSUuT6qfEjBjA1MFQ/zQ0f52s1fOYaRfJZyaivvHUDlUa9KsCNQmd/IztP4RQSde/brNsGNTYHPnl+uyLa3flF/uVYXF/7BxwOH6XsNR0SE34YWZGpT265dtoqeJTa7Bh5gJ0hlsVcrdLBu50Rx3oi/SxF6S/lY72lU8d5KQQQlb9mza1DAvG/CXa7xhu3XPJPhpdcIrwNQwBZT4gcKscIf9I7J2w5aFMf6Rr+ndiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by DS7PR11MB5965.namprd11.prod.outlook.com (2603:10b6:8:70::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Fri, 20 Sep
 2024 02:43:19 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.7982.018; Fri, 20 Sep 2024
 02:43:19 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Chengming Zhou <chengming.zhou@linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>, "yosryahmed@google.com"
	<yosryahmed@google.com>, "nphamcs@gmail.com" <nphamcs@gmail.com>,
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "ryan.roberts@arm.com"
	<ryan.roberts@arm.com>, "Huang, Ying" <ying.huang@intel.com>,
	"21cnbao@gmail.com" <21cnbao@gmail.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "Sridhar, Kanchana P"
	<kanchana.p.sridhar@intel.com>
CC: "Zou, Nanhai" <nanhai.zou@intel.com>, "Feghali, Wajdi K"
	<wajdi.k.feghali@intel.com>, "Gopal, Vinodh" <vinodh.gopal@intel.com>
Subject: RE: [PATCH v6 2/3] mm: zswap: zswap_store() extended to handle mTHP
 folios.
Thread-Topic: [PATCH v6 2/3] mm: zswap: zswap_store() extended to handle mTHP
 folios.
Thread-Index: AQHa+lo9Qlgs2c514UiQAzp2na76F7JEZFCAgBu0VDA=
Date: Fri, 20 Sep 2024 02:43:19 +0000
Message-ID: <SJ0PR11MB567839EB686F82031FECCEB5C96C2@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20240829212705.6714-1-kanchana.p.sridhar@intel.com>
 <20240829212705.6714-3-kanchana.p.sridhar@intel.com>
 <07e2365b-48d2-48e8-9ed3-81a2baf377fc@linux.dev>
In-Reply-To: <07e2365b-48d2-48e8-9ed3-81a2baf377fc@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|DS7PR11MB5965:EE_
x-ms-office365-filtering-correlation-id: 8d4282dd-f462-4664-505a-08dcd91dfc95
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?WVp3dm9rakNYejlJTjZRUkJzWXN0Y0t5UDk0cXBkMGV1WCtuUjFxN3pzWjl2?=
 =?utf-8?B?OEJOMFBJWkhja0U5WVZIVUJINGNyc2p6TDlHdFVqUThQRGRxOEhUd1d6OXp5?=
 =?utf-8?B?Q0d2b1hBQnkvajVoVTl3MU1XVy9RQ2FHQ0NxdlJ5MjlEV1N6YUwzbkpEYk5R?=
 =?utf-8?B?cHZBbmV1cEZ3dUg1TmhWNnlSM1VoOVdmenVOK0ZaV2NDQUJMdnNGSXd6aEJs?=
 =?utf-8?B?TkN3SnlqM1UyUFF5UWljTGp1aml3TzUwU0FyQTRvK3RXNDhPNGo0UlZ5RTh1?=
 =?utf-8?B?UVpWN2xvQ25KWlJnVnN0VGtDU0Z5Y0dpZkRCMHM3bjdWSVJ2dUFGME13ajly?=
 =?utf-8?B?VG5ydjYvSUVid21hWk9tUHl3VVFyOEoyNm9xSCtTamUybkJZRU5FQ3pxVEE2?=
 =?utf-8?B?ciszN0FHMVJ5Y05OUUpCZllLV1M4Vkpta3VOZlhSamJvNVVrT2srRGdEZ3h1?=
 =?utf-8?B?NUlHSUtwR3J5eHhNREM1T3ZOUnRoeTN4MTJORm82aXorY2gxT3NJUWhabno5?=
 =?utf-8?B?T3htU0VWOVhQM3hMUHFlOThLWm5kVDl4aEJsWFJVVW5GdjlrcUR2Y09ESEU4?=
 =?utf-8?B?YWtNN3IwamdDYloxSEtPTWpPRDZZUjI5ZVVLM3ZLWmZ4cEpzVjZnOUF4MUVV?=
 =?utf-8?B?VlR1bmRuNFZLVlhIam1lRjlsMmwzUytqU1kzOXNRTWRoaHdCbjEzUnlOWExR?=
 =?utf-8?B?RjJGMUNoMXlXQ0ZTbUtoWjgraUhya29HWkNCVXRWUUFIUStmM0xTQlY5TGc4?=
 =?utf-8?B?YVh4cytXVUlDdXgvV2dWaGdmMTNvendIRVpwdk96QzdLT3JkaHJlZTd4NENt?=
 =?utf-8?B?VUpXWmFvTlE3SVVOaldROTFpWGFEWGVkUDZ0VmVxL2pKaHVMV0lqUXRKVE5B?=
 =?utf-8?B?VVBCcUdaZGtieTJnelNaS1hORmNQMzY5ZHYzcUV1bFZYNzNzY2p4T0M4OVRJ?=
 =?utf-8?B?Y0NubWJnak9vTlJQd1VhZkMvQXdaVnp5ZXNNOTVMbTdrZms5TnhLNDNIbFlC?=
 =?utf-8?B?aDQwK0tyQWpXNUtBNGdsMnR6K1dlNkIwZ09LUkVTbmhJK1JJeG5ZZVgzKzRu?=
 =?utf-8?B?WjVxZFdjK05vR3l3ZTVMeGFhcEZkTjdObm8zaEJqdnZQSVBGTElZUVE5ZmNv?=
 =?utf-8?B?UkE0WFNweVo1ZG1FTVdJVm42S09hWW1vVm51REplV1J4K3hPbVkrZ2FybkFL?=
 =?utf-8?B?aDdTY0Vad3IvTEJocFlaaEx4cTdIM3NzUnJBVGd2Qk5BUkRPak5ucm9LOVlU?=
 =?utf-8?B?Z3ZTM2RLN0FOMWFVTTVRaVFuVlZGZjh2TTMwWVNKTWlEVTdLNnBvSHdlYXc0?=
 =?utf-8?B?dXJ0SFZHYTBXanZ1eXAzREhNMkc4N0VqOXcxMy9FS0d2dXJOVlQ4cjVhY1RB?=
 =?utf-8?B?dmpnK0lVSzRweFBXMGFHYWdnSzBnQkUwd1NVemVDdTgrcEs3dmFDZXlSbysv?=
 =?utf-8?B?UG9OdXdtdW5GZHE5K0p6RWs5M3pEUzVZUnQvM0lJZzlyY0srVlhkR3dWVThR?=
 =?utf-8?B?bHhEMEVRTnk0MHhqVUlsN1BlM21nT2JacTlBbXkxRmlGc2ZvODN4RW9xcUJQ?=
 =?utf-8?B?RnFOQmlvTjdPY1lRUUJTZmNRbVduWDhPMkc3UUlFMDEyMHRlQ0NtQ1Y0TVg0?=
 =?utf-8?B?SUUzZFRlMG5YYS9iWlRVejd1c3BJUnhLeVNLK05GSldqdjIyc0xXK08yai9n?=
 =?utf-8?B?QU01bU1GVVJ6c1dOTjRlWkw0VVpma0JrdG5jOU1RMlZ2ejJzNFBCVjVVeWgv?=
 =?utf-8?B?b2hrR1RMemlFcVh6Sk1EL05RZFYzNFF3Vk9XQ2hLSWM1YlluZlJ2Vm4vWVRq?=
 =?utf-8?B?d3NKNFk4b0IwNTRKTGdGNlQydHdYa0ZXNU1Fc0EwVkx5N2Q5MENnZ1dwam05?=
 =?utf-8?Q?MKBfrd4lz9u5X?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eXY0YWZEWVd1Q2xHMkROMXRTdjJ2NXZvL3JuSDV4blBYTWRJS0FwdXBkTTVZ?=
 =?utf-8?B?ejNKbTBYWGgwSDc5M29DTFpibFRqU1dzbU52dS9yaFF2WXdLNFlEcElMM1hp?=
 =?utf-8?B?WWZ4cE90N2lyRU8vaWUrMXoxRkJtSk5jcWtuNmR3MTJPWC96YkFwbTFRMWsz?=
 =?utf-8?B?YVYyUmUyWUl1VDZPUHlJR2RPenMzTm1ZRXAzWUJKWXZFQWx1UFY1dDFZOTZR?=
 =?utf-8?B?MnpXa1ZuUGczZXE0ZWRSWkNUZi83S1ZYVE4xaGtGZW1TYURZVnAvSEVSYjRi?=
 =?utf-8?B?T1RVOGhhN0xScmhTUWNySFMyRHNBY28zc3RMcmV4R0xUU0FEV1dHakc0cWZR?=
 =?utf-8?B?ZkNnTStyMDdYdEdoc2w4QUNuMmljSkFGNCtOdUFKVGQ0Tk94S0F4ektFYzFh?=
 =?utf-8?B?dGl1ZlFNSzB0QmE3QnJPaXRTL0UvRWJWakNHRjl3cW9yQTlGbFlBa3hlTjJw?=
 =?utf-8?B?WjFXekRBMGVIdDNTZTRkMWRJOTV6WDJXRFUyeFRjZTB6S0RTQ2g0bG9jT2Ev?=
 =?utf-8?B?bVlvVHBsNnd5TE1MdkxZVDJTSXMwRE0vemVGSFdqaVNudjFDZmxVaXU3citz?=
 =?utf-8?B?MHpsYXU1YkRNVGpQL3gzQ2xTZ2tidFdmZjVrc0Rpa2pjcUxEdG5XOVovUCtt?=
 =?utf-8?B?L21GcmFMdC9YMmNOSVpJbGxuQThZVUZHdytBajN5dHhTcEpjMGdRaG90WHBW?=
 =?utf-8?B?T3czYTRZZ3NMMVdzR0ZjU095RWVHRzlFUENyblhMRUtVelA3ZU1nek0yd0tl?=
 =?utf-8?B?bGxBRjkxRVd2VWlIY3kxV1p0RWJBYU52cXoyRHVyMEs0cmFPTnk1UlY0b3Vn?=
 =?utf-8?B?ZlNWQnZEdGVXN2hNcG80dkhCTDF4b0xQTXBsNEpWR3pRY3JYbzVNRGh0WEgz?=
 =?utf-8?B?Q0g1b1VIMFAwZHhJL00zRVR3MVc0KzlRUktMaHdwam1mWXJBaVI1VkFPRXZG?=
 =?utf-8?B?U0ljamRteXdzZEVCcEZGWU1yMGF6UEhFMHo3KzVhbWRnakpHS1BMRWdHQUwz?=
 =?utf-8?B?QzlvYVRvR2xtdDMyVnN4VHloa2h3WlNCWmNKOFdhdUI1YlVnSktYaituY1dV?=
 =?utf-8?B?RjByNlc5dmJpaUd0Wi84L0pwMXc4eFBkcUwxaUFPZUZONEJPckNWKzNsZjdE?=
 =?utf-8?B?MGM2aXl1U1JhNEZ4OXZ3VzRhUU9EdGdiMEJUcStJeFRjNTlPM1lSVTN5MFFj?=
 =?utf-8?B?b0Nzdnp3OHNKQ2hmbGF0S1hGTmFBM1RodGM4R3J3Sk5YNEJEOFY4eU8yUEFT?=
 =?utf-8?B?Qkh4cE16VHJmVllKd3BYVTFHUmVTSkxWQTdjMU9NWHk4Qlg0YUNTR25uZ1FG?=
 =?utf-8?B?bytObGtrSTlyaEV4bXh3T2VNeEhVY2ZtYlFsdXNXVFVNU2REdWpwNi93M3Fl?=
 =?utf-8?B?Zi9zcTh6UHR1NnY5b2ZwTU1nTVMzcFZBVU9LMkJQM1J0Z1B0VVVRakxaRXc5?=
 =?utf-8?B?MFVNRWYwL3RXVmNBTzhMYjY5MUFDTFc1RlRxZkc3bkVwT0toamtpQTE4aWtU?=
 =?utf-8?B?MllqeHBtbG1DT2FrSTRIRC8veXBualVSNkpPeDBGTjBZR0JnSGpvS3F5N1U3?=
 =?utf-8?B?VlRpVDA1TTlCN21vZkxtS01qR0ZpYVlvMHJZVFA2VEZFb00wSmpLS2tQTlBS?=
 =?utf-8?B?VGhrbFRKTzN3SC9lNndhUmxMTkE2dkFpMmZnRDROSHFKNVo3dXFab2RTOTdj?=
 =?utf-8?B?QUFlc0F2Z3RVdktwcjRhdnluQlpyR2VEQ3hoejQvVUI4VkRJTWE5MUNtM09q?=
 =?utf-8?B?SDZjZmFBOVlyNHI4SC9WY2RSbkt4bTNTR1VCLzMxZFR5dTBHcnJvUUhKQkYr?=
 =?utf-8?B?UE5hRHUvUFA3TVFmeHlWcWxxTDR2MWQveVpWMG12VWg2aGZYYXR0R01EODY1?=
 =?utf-8?B?Q2FLUFcrN05zUHBpQzNxQ0hTVlRWKzJqUzFnTTJjWVpUMXdPMjRvdWJhOE9L?=
 =?utf-8?B?RnM4RjErQzFLd3RxT1llWGZmazN6ejZFYTFOSGEvaG42S1FjUFcyb1c4UCt0?=
 =?utf-8?B?MXdtNTNYVzF6Z21jeThsWnhSQmZ3ZU40ZWJvdFN6ck1pdEpaMGpVUDZ6L2FM?=
 =?utf-8?B?U05JRVB2Qm5yRUEyT21jbzdzTHhGUnFmNW5EQkllRXRaQW5OTk9ZcVpsa3ZX?=
 =?utf-8?B?dG5OQmFUOFZOTnpCQURvSGZnTXAwZzhFOTVSaXEzVWNKNnZHVVZwcWVHYmVE?=
 =?utf-8?B?N0E9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d4282dd-f462-4664-505a-08dcd91dfc95
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2024 02:43:19.4483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yzm71Lvw6rf4jsdm3CefLWZU5dS2mqT7e9DGD7zWOS2bZf3I5tHHUBKaow73jRXJAbKxUPG0cezDGp2D678+0CpxhmLWAw8J2ULeotVLrP8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5965
X-OriginatorOrg: intel.com

SGkgQ2hlbmdtaW5nLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IENo
ZW5nbWluZyBaaG91IDxjaGVuZ21pbmcuemhvdUBsaW51eC5kZXY+DQo+IFNlbnQ6IE1vbmRheSwg
U2VwdGVtYmVyIDIsIDIwMjQgNDozOCBBTQ0KPiBUbzogU3JpZGhhciwgS2FuY2hhbmEgUCA8a2Fu
Y2hhbmEucC5zcmlkaGFyQGludGVsLmNvbT47IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC1tbUBrdmFjay5vcmc7IGhhbm5lc0BjbXB4Y2hnLm9yZzsNCj4geW9zcnlhaG1l
ZEBnb29nbGUuY29tOyBucGhhbWNzQGdtYWlsLmNvbTsgdXNhbWFhcmlmNjQyQGdtYWlsLmNvbTsN
Cj4gcnlhbi5yb2JlcnRzQGFybS5jb207IEh1YW5nLCBZaW5nIDx5aW5nLmh1YW5nQGludGVsLmNv
bT47DQo+IDIxY25iYW9AZ21haWwuY29tOyBha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnDQo+IENj
OiBab3UsIE5hbmhhaSA8bmFuaGFpLnpvdUBpbnRlbC5jb20+OyBGZWdoYWxpLCBXYWpkaSBLDQo+
IDx3YWpkaS5rLmZlZ2hhbGlAaW50ZWwuY29tPjsgR29wYWwsIFZpbm9kaCA8dmlub2RoLmdvcGFs
QGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NiAyLzNdIG1tOiB6c3dhcDogenN3
YXBfc3RvcmUoKSBleHRlbmRlZCB0byBoYW5kbGUNCj4gbVRIUCBmb2xpb3MuDQo+IA0KPiBPbiAy
MDI0LzgvMzAgMDU6MjcsIEthbmNoYW5hIFAgU3JpZGhhciB3cm90ZToNCj4gPiB6c3dhcF9zdG9y
ZSgpIHdpbGwgbm93IHByb2Nlc3MgYW5kIHN0b3JlIG1USFAgYW5kIFBNRC1zaXplIFRIUCBmb2xp
b3MuDQo+ID4NCj4gPiBBIG5ldyBjb25maWcgdmFyaWFibGUgQ09ORklHX1pTV0FQX1NUT1JFX1RI
UF9ERUZBVUxUX09OIChvZmYgYnkNCj4gZGVmYXVsdCkNCj4gPiB3aWxsIGVuYWJsZS9kaXNhYmxl
IHpzd2FwIHN0b3Jpbmcgb2YgKG0pVEhQLg0KPiA+DQo+ID4gVGhpcyBjaGFuZ2UgcmV1c2VzIGFu
ZCBhZGFwdHMgdGhlIGZ1bmN0aW9uYWxpdHkgaW4gUnlhbiBSb2JlcnRzJyBSRkMNCj4gPiBwYXRj
aCBbMV06DQo+ID4NCj4gPiAgICAiW1JGQyx2MV0gbW06IHpzd2FwOiBTdG9yZSBsYXJnZSBmb2xp
b3Mgd2l0aG91dCBzcGxpdHRpbmciDQo+ID4NCj4gPiAgICBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvbGludXgtbW0vMjAyMzEwMTkxMTA1NDMuMzI4NDY1NC0xLQ0KPiByeWFuLnJvYmVydHNA
YXJtLmNvbS9ULyN1DQo+ID4NCj4gPiBUaGlzIHBhdGNoIHByb3ZpZGVzIGEgc2VxdWVudGlhbCBp
bXBsZW1lbnRhdGlvbiBvZiBzdG9yaW5nIGFuIG1USFAgaW4NCj4gPiB6c3dhcF9zdG9yZSgpIGJ5
IGl0ZXJhdGluZyB0aHJvdWdoIGVhY2ggcGFnZSBpbiB0aGUgZm9saW8gdG8gY29tcHJlc3MNCj4g
PiBhbmQgc3RvcmUgaXQgaW4gdGhlIHpzd2FwIHpwb29sLg0KPiA+DQo+ID4gVG93YXJkcyB0aGlz
IGdvYWwsIHpzd2FwX2NvbXByZXNzKCkgaXMgbW9kaWZpZWQgdG8gdGFrZSBhIHBhZ2UgaW5zdGVh
ZA0KPiA+IG9mIGEgZm9saW8gYXMgaW5wdXQuDQo+ID4NCj4gPiBFYWNoIHBhZ2UncyBzd2FwIG9m
ZnNldCBpcyBzdG9yZWQgYXMgYSBzZXBhcmF0ZSB6c3dhcCBlbnRyeS4NCj4gPg0KPiA+IElmIGFu
IGVycm9yIGlzIGVuY291bnRlcmVkIGR1cmluZyB0aGUgc3RvcmUgb2YgYW55IHBhZ2UgaW4gdGhl
IG1USFAsDQo+ID4gYWxsIHByZXZpb3VzIHBhZ2VzL2VudHJpZXMgc3RvcmVkIHdpbGwgYmUgaW52
YWxpZGF0ZWQuIFRodXMsIGFuIG1USFANCj4gPiBpcyBlaXRoZXIgZW50aXJlbHkgc3RvcmVkIGlu
IFpTV0FQLCBvciBlbnRpcmVseSBub3Qgc3RvcmVkIGluIFpTV0FQLg0KPiA+DQo+ID4gVGhpcyBm
b3JtcyB0aGUgYmFzaXMgZm9yIGJ1aWxkaW5nIGJhdGNoaW5nIG9mIHBhZ2VzIGR1cmluZyB6c3dh
cCBzdG9yZQ0KPiA+IG9mIGxhcmdlIGZvbGlvcywgYnkgY29tcHJlc3NpbmcgYmF0Y2hlcyBvZiB1
cCB0byBzYXksIDggcGFnZXMgaW4gYW4NCj4gPiBtVEhQIGluIHBhcmFsbGVsIGluIGhhcmR3YXJl
LCB3aXRoIHRoZSBJbnRlbCBJbi1NZW1vcnkgQW5hbHl0aWNzDQo+ID4gQWNjZWxlcmF0b3IgKElu
dGVsIElBQSkuDQo+ID4NCj4gPiBBbHNvLCBhZGRyZXNzZWQgc29tZSBvZiB0aGUgUkZDIGNvbW1l
bnRzIGZyb20gdGhlIGRpc2N1c3Npb24gaW4gWzFdLg0KPiA+DQo+ID4gTWFkZSBhIG1pbm9yIGVk
aXQgaW4gdGhlIGNvbW1lbnRzIGZvciAic3RydWN0IHpzd2FwX2VudHJ5IiB0byBkZWxldGUNCj4g
PiB0aGUgY29tbWVudHMgcmVsYXRlZCB0byAidmFsdWUiIHNpbmNlIHNhbWUtZmlsbGVkIHBhZ2Ug
aGFuZGxpbmcgaGFzDQo+ID4gYmVlbiByZW1vdmVkIGZyb20genN3YXAuDQo+ID4NCj4gPiBDby1k
ZXZlbG9wZWQtYnk6IFJ5YW4gUm9iZXJ0cw0KPiA+IFNpZ25lZC1vZmYtYnk6DQo+ID4gU2lnbmVk
LW9mZi1ieTogS2FuY2hhbmEgUCBTcmlkaGFyIDxrYW5jaGFuYS5wLnNyaWRoYXJAaW50ZWwuY29t
Pg0KPiANCj4gVGhlIGNvZGUgbG9va3Mgb2ssIGJ1dCBJIGFsc28gZmluZCB0aGlzIHBhdGNoIGlz
IGEgbGl0dGxlIGhhcmQgdG8NCj4gcmV2aWV3LCBtYXliZSBpdCdzIGJldHRlciB0byBzcGxpdCBp
dCBpbnRvIHNtYWxsIHBhdGNoZXMgYXMgWW9zcnkgc3VnZ2VzdGVkLg0KDQpEZWZpbml0ZWx5LCB3
aWxsIGRvIHNvIGFuZCBzdWJtaXQgYSB2Ny4NCg0KVGhhbmtzLA0KS2FuY2hhbmENCg0KPiANCj4g
VGhhbmtzIQ0KPiANCj4gWy4uLl0NCj4gPiArDQo+ID4gKy8qDQo+ID4gKyAqIE1vZGlmaWVkIHRv
IHN0b3JlIG1USFAgZm9saW9zLiBFYWNoIHBhZ2UgaW4gdGhlIG1USFAgd2lsbCBiZQ0KPiBjb21w
cmVzc2VkDQo+ID4gKyAqIGFuZCBzdG9yZWQgc2VxdWVudGlhbGx5Lg0KPiA+ICsgKi8NCj4gPiAr
Ym9vbCB6c3dhcF9zdG9yZShzdHJ1Y3QgZm9saW8gKmZvbGlvKQ0KPiA+ICt7DQo+ID4gKwlsb25n
IG5yX3BhZ2VzID0gZm9saW9fbnJfcGFnZXMoZm9saW8pOw0KPiA+ICsJc3dwX2VudHJ5X3Qgc3dw
ID0gZm9saW8tPnN3YXA7DQo+ID4gKwlwZ29mZl90IG9mZnNldCA9IHN3cF9vZmZzZXQoc3dwKTsN
Cj4gPiArCXN0cnVjdCB4YXJyYXkgKnRyZWUgPSBzd2FwX3pzd2FwX3RyZWUoc3dwKTsNCj4gPiAr
CXN0cnVjdCBvYmpfY2dyb3VwICpvYmpjZyA9IE5VTEw7DQo+ID4gKwlzdHJ1Y3QgbWVtX2Nncm91
cCAqbWVtY2cgPSBOVUxMOw0KPiA+ICsJc3RydWN0IHpzd2FwX3Bvb2wgKnBvb2w7DQo+ID4gKwli
b29sIHJldCA9IGZhbHNlOw0KPiA+ICsJbG9uZyBpbmRleDsNCj4gPiArDQo+ID4gKwlWTV9XQVJO
X09OX09OQ0UoIWZvbGlvX3Rlc3RfbG9ja2VkKGZvbGlvKSk7DQo+ID4gKwlWTV9XQVJOX09OX09O
Q0UoIWZvbGlvX3Rlc3Rfc3dhcGNhY2hlKGZvbGlvKSk7DQo+ID4gKw0KPiA+ICsJLyogU3Rvcmlu
ZyBsYXJnZSBmb2xpb3MgaXNuJ3QgZW5hYmxlZCAqLw0KPiA+ICsJaWYgKCF6c3dhcF9tdGhwX2Vu
YWJsZWQgJiYgZm9saW9fdGVzdF9sYXJnZShmb2xpbykpDQo+ID4gKwkJcmV0dXJuIGZhbHNlOw0K
PiA+ICsNCj4gPiArCWlmICghenN3YXBfZW5hYmxlZCkNCj4gPiArCQlnb3RvIHJlamVjdDsNCj4g
PiArDQo+ID4gICAJLyoNCj4gPiAtCSAqIElmIHRoZSB6c3dhcCBzdG9yZSBmYWlscyBvciB6c3dh
cCBpcyBkaXNhYmxlZCwgd2UgbXVzdCBpbnZhbGlkYXRlIHRoZQ0KPiA+IC0JICogcG9zc2libHkg
c3RhbGUgZW50cnkgd2hpY2ggd2FzIHByZXZpb3VzbHkgc3RvcmVkIGF0IHRoaXMgb2Zmc2V0Lg0K
PiA+IC0JICogT3RoZXJ3aXNlLCB3cml0ZWJhY2sgY291bGQgb3ZlcndyaXRlIHRoZSBuZXcgZGF0
YSBpbiB0aGUgc3dhcGZpbGUuDQo+ID4gKwkgKiBDaGVjayBjZ3JvdXAgbGltaXRzOg0KPiA+ICsJ
ICoNCj4gPiArCSAqIFRoZSBjZ3JvdXAgenN3YXAgbGltaXQgY2hlY2sgaXMgZG9uZSBvbmNlIGF0
IHRoZSBiZWdpbm5pbmcgb2YgYW4NCj4gPiArCSAqIG1USFAgc3RvcmUsIGFuZCBub3Qgd2l0aGlu
IHpzd2FwX3N0b3JlX3BhZ2UoKSBmb3IgZWFjaCBwYWdlDQo+ID4gKwkgKiBpbiB0aGUgbVRIUC4g
V2UgZG8gaG93ZXZlciBjaGVjayB0aGUgenN3YXAgcG9vbCBsaW1pdHMgYXQgdGhlDQo+ID4gKwkg
KiBzdGFydCBvZiB6c3dhcF9zdG9yZV9wYWdlKCkuIFdoYXQgdGhpcyBtZWFucyBpcywgdGhlIGNn
cm91cA0KPiA+ICsJICogY291bGQgZ28gb3ZlciB0aGUgbGltaXRzIGJ5IGF0IG1vc3QgKEhQQUdF
X1BNRF9OUiAtIDEpIHBhZ2VzLg0KPiA+ICsJICogSG93ZXZlciwgdGhlIHBlci1zdG9yZS1wYWdl
IHpzd2FwIHBvb2wgbGltaXRzIGNoZWNrIHNob3VsZA0KPiA+ICsJICogaG9wZWZ1bGx5IHRyaWdn
ZXIgdGhlIGNncm91cCBhd2FyZSBhbmQgenN3YXAgTFJVIGF3YXJlIGdsb2JhbA0KPiA+ICsJICog
cmVjbGFpbSBpbXBsZW1lbnRlZCBpbiB0aGUgc2hyaW5rZXIuIElmIHRoaXMgYXNzdW1wdGlvbiBo
b2xkcywNCj4gPiArCSAqIHRoZSBjZ3JvdXAgZXhjZWVkaW5nIHRoZSB6c3dhcCBsaW1pdHMgY291
bGQgcG90ZW50aWFsbHkgYmUNCj4gPiArCSAqIHJlc29sdmVkIGJlZm9yZSB0aGUgbmV4dCB6c3dh
cF9zdG9yZSwgYW5kIGlmIGl0IGlzIG5vdCwgdGhlIG5leHQNCj4gPiArCSAqIHpzd2FwX3N0b3Jl
IHdvdWxkIGZhaWwgdGhlIGNncm91cCB6c3dhcCBsaW1pdCBjaGVjayBhdCB0aGUgc3RhcnQuDQo+
ID4gICAJICovDQo+ID4gLQllbnRyeSA9IHhhX2VyYXNlKHRyZWUsIG9mZnNldCk7DQo+ID4gLQlp
ZiAoZW50cnkpDQo+ID4gLQkJenN3YXBfZW50cnlfZnJlZShlbnRyeSk7DQo+ID4gLQlyZXR1cm4g
ZmFsc2U7DQo+ID4gKwlvYmpjZyA9IGdldF9vYmpfY2dyb3VwX2Zyb21fZm9saW8oZm9saW8pOw0K
PiA+ICsJaWYgKG9iamNnICYmICFvYmpfY2dyb3VwX21heV96c3dhcChvYmpjZykpIHsNCj4gPiAr
CQltZW1jZyA9IGdldF9tZW1fY2dyb3VwX2Zyb21fb2JqY2cob2JqY2cpOw0KPiA+ICsJCWlmIChz
aHJpbmtfbWVtY2cobWVtY2cpKSB7DQo+ID4gKwkJCW1lbV9jZ3JvdXBfcHV0KG1lbWNnKTsNCj4g
PiArCQkJZ290byBwdXRfb2JqY2c7DQo+ID4gKwkJfQ0KPiA+ICsJCW1lbV9jZ3JvdXBfcHV0KG1l
bWNnKTsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlpZiAoenN3YXBfY2hlY2tfbGltaXRzKCkpDQo+
ID4gKwkJZ290byBwdXRfb2JqY2c7DQo+ID4gKw0KPiA+ICsJcG9vbCA9IHpzd2FwX3Bvb2xfY3Vy
cmVudF9nZXQoKTsNCj4gPiArCWlmICghcG9vbCkNCj4gPiArCQlnb3RvIHB1dF9vYmpjZzsNCj4g
PiArDQo+ID4gKwlpZiAob2JqY2cpIHsNCj4gPiArCQltZW1jZyA9IGdldF9tZW1fY2dyb3VwX2Zy
b21fb2JqY2cob2JqY2cpOw0KPiA+ICsJCWlmIChtZW1jZ19saXN0X2xydV9hbGxvYyhtZW1jZywg
Jnpzd2FwX2xpc3RfbHJ1LA0KPiBHRlBfS0VSTkVMKSkgew0KPiA+ICsJCQltZW1fY2dyb3VwX3B1
dChtZW1jZyk7DQo+ID4gKwkJCWdvdG8gcHV0X3Bvb2w7DQo+ID4gKwkJfQ0KPiA+ICsJCW1lbV9j
Z3JvdXBfcHV0KG1lbWNnKTsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwkvKg0KPiA+ICsJICogU3Rv
cmUgZWFjaCBwYWdlIG9mIHRoZSBmb2xpbyBhcyBhIHNlcGFyYXRlIGVudHJ5LiBJZiB3ZSBmYWls
IHRvIHN0b3JlDQo+ID4gKwkgKiBhIHBhZ2UsIHVud2luZCBieSByZW1vdmluZyBhbGwgdGhlIHBy
ZXZpb3VzIHBhZ2VzIHdlIHN0b3JlZC4NCj4gPiArCSAqLw0KPiA+ICsJZm9yIChpbmRleCA9IDA7
IGluZGV4IDwgbnJfcGFnZXM7ICsraW5kZXgpIHsNCj4gPiArCQlpZiAoIXpzd2FwX3N0b3JlX3Bh
Z2UoZm9saW8sIGluZGV4LCBvYmpjZywgcG9vbCkpDQo+ID4gKwkJCWdvdG8gcHV0X3Bvb2w7DQo+
ID4gKwl9DQo+ID4gKw0KPiA+ICsJcmV0ID0gdHJ1ZTsNCj4gPiArDQo+ID4gK3B1dF9wb29sOg0K
PiA+ICsJenN3YXBfcG9vbF9wdXQocG9vbCk7DQo+ID4gK3B1dF9vYmpjZzoNCj4gPiArCW9ial9j
Z3JvdXBfcHV0KG9iamNnKTsNCj4gPiArCWlmICh6c3dhcF9wb29sX3JlYWNoZWRfZnVsbCkNCj4g
PiArCQlxdWV1ZV93b3JrKHNocmlua193cSwgJnpzd2FwX3Nocmlua193b3JrKTsNCj4gPiArcmVq
ZWN0Og0KPiA+ICsJLyoNCj4gPiArCSAqIElmIHRoZSB6c3dhcCBzdG9yZSBmYWlscyBvciB6c3dh
cCBpcyBkaXNhYmxlZCwgd2UgbXVzdCBpbnZhbGlkYXRlDQo+ID4gKwkgKiB0aGUgcG9zc2libHkg
c3RhbGUgZW50cmllcyB3aGljaCB3ZXJlIHByZXZpb3VzbHkgc3RvcmVkIGF0IHRoZQ0KPiA+ICsJ
ICogb2Zmc2V0cyBjb3JyZXNwb25kaW5nIHRvIGVhY2ggcGFnZSBvZiB0aGUgZm9saW8uIE90aGVy
d2lzZSwNCj4gPiArCSAqIHdyaXRlYmFjayBjb3VsZCBvdmVyd3JpdGUgdGhlIG5ldyBkYXRhIGlu
IHRoZSBzd2FwZmlsZS4NCj4gPiArCSAqLw0KPiA+ICsJaWYgKCFyZXQpDQo+ID4gKwkJenN3YXBf
ZGVsZXRlX3N0b3JlZF9vZmZzZXRzKHRyZWUsIG9mZnNldCwgbnJfcGFnZXMpOw0KPiA+ICsNCj4g
PiArCXJldHVybiByZXQ7DQo+ID4gICB9DQo+ID4NCj4gPiAgIGJvb2wgenN3YXBfbG9hZChzdHJ1
Y3QgZm9saW8gKmZvbGlvKQ0K

