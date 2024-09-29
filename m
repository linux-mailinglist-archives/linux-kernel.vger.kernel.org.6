Return-Path: <linux-kernel+bounces-343185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AD198978D
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 23:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE6FE1F215C1
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 21:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B09155E53;
	Sun, 29 Sep 2024 21:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZIGkAeYy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA7E1F94D
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 21:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727643902; cv=fail; b=cIaZ3fVBjGzG9SXdn5yVZ0WECpPvf2OUYsdNGOjiE+TqgDOESBydmKj/hk3eeTGKzHwi8cgirfv2GjIv+pmi+ZvdR4235AQ9KNM5NNNeSojbQYgViIQ4CQ1JtcPqvvRCXWTMIAOGi0cLPy/MjtWOJuqBHS/jjPtF7qiNfnB0ngo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727643902; c=relaxed/simple;
	bh=uqdRFWjfVxPGy/a3bZIIWyOq1qAmKvG3iQ4hWDYJW0A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V2MXLnkX1qDwQWZdRbwMc1cl3uViwmKtK/piOWzHxxqiqiu1dranw7X2GwfcurWgeK5t9GnlQamWvV3MobyNkO4uw6mWYmNHeB29FxDmDSbXWwvCuTT+nJMF23AP50eCefzZfzyFRVB5RElBwYiS7dRpvka+zAnlGCq6MpkMatY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZIGkAeYy; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727643901; x=1759179901;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uqdRFWjfVxPGy/a3bZIIWyOq1qAmKvG3iQ4hWDYJW0A=;
  b=ZIGkAeYyzkOtKb5lnkmT8S8RCat2BVfhMwl8qZ9XzkmDmrY0n5JADzTP
   aPAIKa5oYR36uYEgYJZRRfXrKNdzNpezL1+DniiuLKUE5kXD9qOdri9Q0
   ALK9+bkfevacT4f78wR+41mtXIlpLpqRcphzUQFJcEZY369gtNscbSjAW
   QbCu28nkh86p+YFpsfy0ZkiBonZmLWe7dyYoq5u/SuXOYi6gmk5bil8Tr
   9ZcQSXBX9FtRlXjty/mqW5eSI+z4GKkE1nHMPbwrBuZCOArI908PaI+iB
   JFbk3n8x8eSVfpd0TYUslrxMhUjvZ8UB5h7QV2JjAwuu9wPM/CYUBDvTR
   g==;
X-CSE-ConnectionGUID: hVVdAuwAToC0EDHSLK8u4A==
X-CSE-MsgGUID: ugX96OPKRLmSAMYtfwUzSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="26231249"
X-IronPort-AV: E=Sophos;i="6.11,164,1725346800"; 
   d="scan'208";a="26231249"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2024 14:05:00 -0700
X-CSE-ConnectionGUID: 0kMDWRnRQdKp+de40nfuMg==
X-CSE-MsgGUID: nvBeCT5LQZGGpbqzwJVCXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,164,1725346800"; 
   d="scan'208";a="77489080"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Sep 2024 14:05:00 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 29 Sep 2024 14:04:59 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 29 Sep 2024 14:04:59 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 29 Sep 2024 14:04:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uFMTwz9Xu17mr3QUjmbGeZW/9u92PDwbZwCtIZ3NYVNOfjPpUgXSv0JbnmO0wENpbBhXVlSPOgMl1SPL0aK38kYZM7DngnLt8kK4I+lCAQrrxrQrcSxNxnbMEKKuKsMx4JhrP9wqMWKeJH6OnM7HOP4digexSHF8VtVQ1vOHe8kBewl8QaCj1sd7GB3suNvVJQ2bfnWg/ZcPdQUwQzPgR8WOvX3BUvvMAyo9qEZP26G54oSm0HW05lJqiCXRnnmALwW0V8eqvoEMEOGD4CifvlMWnvCdu/9pMYaJPK7nx89Nw9aXUeun0QwJpYuk1YCk/hd2xoMAle3T04/7K+dyHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uqdRFWjfVxPGy/a3bZIIWyOq1qAmKvG3iQ4hWDYJW0A=;
 b=oMIDHZkXDSAhXwSz56Xua2oxqJilk4bZUB4A0043lo8STcJwiy4LwX10BkCiCLYCRtgWQm3f1PvDNPLItsGg7A0k4Wjfw1Jyv+pxMBRo5o/ilTJi47+EviN75zBADpyWeRjh6nvmigatFxmy1LdRm+0AWHnx577ayBTuEopb6bQ9TDyL/45jVDfTHpRoP3mVmJNYkPyiAfMh8nAFmQbO7WZt0upyCHlTvs9IEghECwcKObzlv5O6fzRItHX4+szoe674NzfAE7TgeNfDMsCMVC9dlM9hKZZeC7qPkjG0jGXH8UuRHSBsmUIpa+niatlYMjEcQowFf8ChNZHFttFqAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by SA1PR11MB6967.namprd11.prod.outlook.com (2603:10b6:806:2bb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.25; Sun, 29 Sep
 2024 21:04:57 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.8005.024; Sun, 29 Sep 2024
 21:04:57 +0000
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
	"Zou, Nanhai" <nanhai.zou@intel.com>, "Feghali, Wajdi K"
	<wajdi.k.feghali@intel.com>, "Gopal, Vinodh" <vinodh.gopal@intel.com>,
	"Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v8 3/8] mm: zswap: Rename zswap_pool_get() to
 zswap_pool_tryget().
Thread-Topic: [PATCH v8 3/8] mm: zswap: Rename zswap_pool_get() to
 zswap_pool_tryget().
Thread-Index: AQHbEUxt5l9qSZEa6Uizot/zI8AqFrJt2RgAgAFqqsA=
Date: Sun, 29 Sep 2024 21:04:57 +0000
Message-ID: <SJ0PR11MB5678B708831B5EEACA1E5A31C9752@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20240928021620.8369-1-kanchana.p.sridhar@intel.com>
 <20240928021620.8369-4-kanchana.p.sridhar@intel.com>
 <CAKEwX=Nyvrub+wL7Tn9pSJms=d3_U-8SVmcm0N5DJWfW-DBUeg@mail.gmail.com>
In-Reply-To: <CAKEwX=Nyvrub+wL7Tn9pSJms=d3_U-8SVmcm0N5DJWfW-DBUeg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|SA1PR11MB6967:EE_
x-ms-office365-filtering-correlation-id: 6bd5e00e-7638-425d-8786-08dce0ca5fe9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Uzhwd3pxaTUvcmpzRy9zWEs4V1lXTzhQTGxXdnVKTFh3bzQyQ0hMeXI0d2NW?=
 =?utf-8?B?dCtCVFFLUlYzOWovSThCZmhKc2xaNURnZDRXUFZkYnBnNUUwMTdjalZYZUhv?=
 =?utf-8?B?YVQ4cGxRZkRiOWYxcFNhWXU1VktGOFdKZ3pVQ3QveG9HWVRrcUwwNnRZL2FP?=
 =?utf-8?B?UkFCODlXK1NHNlBIMmJ0dS9yV3dzNFFTbjlJS1JiVTA5Y3A5dDVvN0o3emF4?=
 =?utf-8?B?dWZCVzFZeTB6dHJjZmFSUUNBb1VSNWI5RFprVjNjV28zRVZhbHlDQ05rTHRo?=
 =?utf-8?B?S3JlejhlSW0zS1dDc25IMklubWpUblZJRVZQRzVUZko4cndhcGprQ05tRnli?=
 =?utf-8?B?SE54dlI2cy9ZQ1VwWERCbE9MMWppUzVBZzdzdzQ3VGlRVjFHZ2xtVjlUZUR3?=
 =?utf-8?B?T0UxZW5sSmtONUFJMFpmYXFxU0ZmMkVDTnlPd1hjeTRjMTlPTWY2Y3JLaHA5?=
 =?utf-8?B?dzdaN0hZQ3dVQ1JQbHdnOU1nWDN6a0o1RlhvZzBjNkNYc0V3dy9IQkE0dy9T?=
 =?utf-8?B?bE5NazRKYXB6YStVVm9KVDc4K0pKVENDSkFHMFdJK1paLytaN0g5TXZjUUxR?=
 =?utf-8?B?QnEyMlQ0aFhPVzN3VGh6Zi9XWkQyb0NQdXZtbzRGSE53Zjl0Mmp6aHZyNm9u?=
 =?utf-8?B?Z2RFTHp1dnJaaGxrZTFhdmVZcDNvaEFONzB1SmFDU1N4RzhNWGtxcXlUSHY5?=
 =?utf-8?B?NCtJa2NLWVAzLytMQm9nbGR5NitjRWhhcjdHY2ZrWThrY0VTQTRJSzdFaVhW?=
 =?utf-8?B?Qzh6MGFwSW5XbDJGUFpvbStuSEZISmdtNkY4S0xTekJVOWtReFM0U1R2SmJJ?=
 =?utf-8?B?MWEvZEhqRGp0ZGFCNHBmV0JOSnBHdlVBQmZ5dkgvK1B5eEhXTUVvVHAwY1hX?=
 =?utf-8?B?WDBLeVNZdE9MdUl5SWFsVkc3b2FFUW9CTCtxZVlRcDhobkxiRGJHdmRlb3d4?=
 =?utf-8?B?OHFFYzE4dm9ZQnk1VGEzekl6N3hnSUlWeDE3V3VldWRSVmw5NHh4TTF6NlFQ?=
 =?utf-8?B?TisyT1hnYmNhU2Z0cnNORXdzY3pBcCtSN0xEaU5Xb25nTnJWMy8ySTJsVGdO?=
 =?utf-8?B?VTJ0cmpoZzNHSmk2c0gwU2ZRNDl2NzZjNnhNWGNlSVJyUnB4UHRCL3ByeVJE?=
 =?utf-8?B?SnprVGVtRlVzZDFEdThGQlRMdzlCbXExS25HSjVKcnRKdVJ2SW15Z3VjMHU1?=
 =?utf-8?B?RW55ZTMvM05xNjMvOWVwekxTWmcvTm1BRlFEV29uWkNQU0cwclhkdGxJVkw1?=
 =?utf-8?B?b1Ara2hKYnpyZEpvVHBqN0pTL1ZHa1I0NEtoeUpHclBLTi9yVkhwbHRZbHBX?=
 =?utf-8?B?bms4NStiaFFRcTIrR2U1dFRhMWk2b2FVeHVTeDgwYzlWSkJYV05PNWx5WnhU?=
 =?utf-8?B?anF0dnUrU0lVK21DRkdvSVlYNXJ2aGxuK2FUa2tJVGlxR2M3SjcxVTNoMjNh?=
 =?utf-8?B?cVdMQ3hkQitsbThvb0c5dmgvYkd4dmE0Zmxlcm9HN1JoeFBZd0VNRExMbEZs?=
 =?utf-8?B?RXQ2UTNsRDRjMXZ0bGdsMnBCU3V6aEgxdjlKZGFnUGFXRDFraHhqUlpHb2dP?=
 =?utf-8?B?YWxEbE1jTGkyME9zNkFqU3Q0T0o4Y0FuOEdSOGdvaVBhby9DWW16TU95NEhM?=
 =?utf-8?B?dURiT0NXZG9oMUhYdkQyRmw1RURocTdOVC9IQStrNDI4OWRMSGNIeVd2Qmth?=
 =?utf-8?B?UWxyc2VLc05lOEFVM0FMc2pxclJtT2c4bU5HZHNyY1NmeEQ2OU4vd1FEaFhW?=
 =?utf-8?B?Nm9zTU01anMzTjM3RmtGa3NVMCtGaU16N3ExbEhUa1dzT0s3bHBzZUllR2xJ?=
 =?utf-8?B?RFQ1bkxMbksxdlJkbHRudz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1pRWlBjREcvamM1UWdmVjRoS0lJZTZKblhINCtnUnRRT0FtbWtXMXJpWnpy?=
 =?utf-8?B?SUZwY2RhQnM2bEltZ09RMUpqNUF0aHZxall4RHhVdWhLNys2SUJZTlYyMVJi?=
 =?utf-8?B?K2JjbmZQSEc2dHZjbks3ZEtybU1CRUNlZWltd0VNOTFSTXFmLy9QbU04NW05?=
 =?utf-8?B?OXI3YzZNem9VR1l5N1hVVWg2Rlc1WGtWUTM4dmJhNE1iQXVDc0hGdFQ2MnE4?=
 =?utf-8?B?RmFGU3J3Mmt6YUtmTWZpaHRRc09JVDF3ZFdNL0JqU0FtZHZDRkQvS2xFTlNn?=
 =?utf-8?B?cnM5UU1DOW14WjVHS2NmRUlBdVZLS2UrbnljZmJHcVFxR1dnT0R6cjlFRi9I?=
 =?utf-8?B?Y2tEdm8zd2FaR2xweEwyMTZNQVVRdEVpT2lLOU9mTjJxM25WSVJJazVZMUk1?=
 =?utf-8?B?R3lUVk9FZzBiUTFhTk41cGVmTTBRZDV6d1ZMOUJ0UmoyYWRQanBEczFuWnZT?=
 =?utf-8?B?MzBZRTN2MjhVcFNDcmMveXBnbXQwRmp5b3A2T01BS1UyMHNxR0tyNERucTMx?=
 =?utf-8?B?R3VCMTY3VUZ5V2Jqc2hpeUJaVFU3WVVtcW5ReUM0R1VtVllQTGpVVnNxbk10?=
 =?utf-8?B?YVk3Ykx6U0VjLzhKTlBsZEFERjBQcG5yMjBzTzlNcS9aQjdyR3diUnIvTE1C?=
 =?utf-8?B?bVZUSDJGSTROeUdlSTM5MzlwTW1OeE5XT2VHalFTellobXFDenJ5MitIaE1z?=
 =?utf-8?B?bXBHNzBxRFg4REt1bXlpaEs0UTVua0UvaDB1V1J3eHoxOHlZQnFWS2tVWG15?=
 =?utf-8?B?YlFaQjhYYXpXZ0JPbGxJbk5mNkF4NkRLeHRjbk5Id0hsOTZMN3NEenlUNE8x?=
 =?utf-8?B?cDFzS1lOUzUvNkdYRzBITFJ4NzdYdDRWRHMzSWp2ek5wZm9hRTMyeTMwK0Y0?=
 =?utf-8?B?V1ptTXBJZFhGV3FtTnU0N2g1Sk05bzkya0F2WHBlWmNDZ3loa1QwWGd2c0hG?=
 =?utf-8?B?Kys4bWtpNlNWK0pEZFRWOWo4UmhMYzNpQUFmT3ptOTlzYjIrc1N0UGV6YktX?=
 =?utf-8?B?V3ptOFExNElNMnQvbkZGV3N0bjY4ei9yYmZyTWZlMjZOZVlXSDFLWDR5bDdy?=
 =?utf-8?B?cFJ5WDBBUmcwNlcrdXF0LzRmanZFd3BPUE1uSk5SYXZSSTlVSzNGdXExL0J4?=
 =?utf-8?B?b1RCaGJnY0lrcWRTMVR1UHZ0MGJGa2dua2hBQ2ZGbnlxQjJwd2Y3MlBLKzRm?=
 =?utf-8?B?Sk95SWlnMFd5SVZTak1RTU1xU3VjY1RIb0JtWksvNUNKcWswN2tBeU84VHUz?=
 =?utf-8?B?a3lBTVZOTFFpNDd5QUMxdk9oR3BOYk44R2VpWHhoWEF3aHlBZ3Z6MDlhak56?=
 =?utf-8?B?bTNESDRNRDZzNFVZMHpKbnlPV1l4VnpmMzlOWm1yUVAycVJwRDJRbmJkZ1Nz?=
 =?utf-8?B?S2hiUi9ybDJ1aEJtZUk1Sk8weE55TFZzVDlwb0hpSHhNdVpyTktLZ3JaOENm?=
 =?utf-8?B?aE0xRlR4QjJHSlZqd0FQZlA4enljRkdzd1JSQ2I3ckxZNi8wM29yWFpCbDZp?=
 =?utf-8?B?S09YcEJqSHg5ZWo4MzNGeXYrcyt3VjVjOUxWVWFBWHFtWjArRTFoZFhmN0Uy?=
 =?utf-8?B?aXl4c3ROZU9aVVkyT05BY1Y4cmpTcjJLa0JCT0ZoVXlXWmgvWXpaRUhpQjB5?=
 =?utf-8?B?blZkNEc4TVJHNE0zYkx3ZlRVRFZMK1dwaEdjeHBNc1RKUDFhM1UvbnA2WjRr?=
 =?utf-8?B?UVpOMklHWmgxaE1zUUsvb3E5RjJIS01KN3pIcEhwSEtQaUdBYkJjSFZ2ZHlZ?=
 =?utf-8?B?ci8xUDJMNzdoSDB0bHZUZm5FNE9xNjJ4Q2ZjNDVEZG4rcW04UHYyd1c2ZnFD?=
 =?utf-8?B?dWRKUXVDcitQelNlNHBWd013T3VtTGdMc0JVQUtYSHJBUWkwUy9BZkNZcEhC?=
 =?utf-8?B?VjcxWVFJVXBQUlViL1lwQ3RkNGMyaW50MUk2VkQ1dnFpRDJaWDdhZ2VRUDZR?=
 =?utf-8?B?bWZSc2lMc3JuNFVBNVhsOWRpZmtOZi84SzI3ejljVHlsK0JmVDhRTW5SMlVo?=
 =?utf-8?B?d1RwL2tPTzc5ei9YeWdCZG1ycGhJT0RNbzdKbGtYclY4RGJzWkE0Y2l5WnJr?=
 =?utf-8?B?dW5QNmErb0phVWMyYUVPQitxVGtpeCtpVVVtRUd4NFBaazFvd1BOa2V3ZUNI?=
 =?utf-8?B?NTVLZ25aS1d3T2FBcFRrRitLOUVqOHBndTlMRkg5U2M5dGgxU0YxMDVlbngr?=
 =?utf-8?B?emc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bd5e00e-7638-425d-8786-08dce0ca5fe9
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2024 21:04:57.6564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AIZexdqueXijw/byJAmCIU+8AhQK2PuIQ/WfMZvVm/AN01OdnwyJoa+QBhx4hWE5jwewe5a0sfVA33LK/TvlKIHPIM1oeaR/dKjNpfydmF0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6967
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOaGF0IFBoYW0gPG5waGFtY3NA
Z21haWwuY29tPg0KPiBTZW50OiBTYXR1cmRheSwgU2VwdGVtYmVyIDI4LCAyMDI0IDQ6MjcgUE0N
Cj4gVG86IFNyaWRoYXIsIEthbmNoYW5hIFAgPGthbmNoYW5hLnAuc3JpZGhhckBpbnRlbC5jb20+
DQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1tbUBrdmFjay5vcmc7
DQo+IGhhbm5lc0BjbXB4Y2hnLm9yZzsgeW9zcnlhaG1lZEBnb29nbGUuY29tOw0KPiBjaGVuZ21p
bmcuemhvdUBsaW51eC5kZXY7IHVzYW1hYXJpZjY0MkBnbWFpbC5jb207DQo+IHNoYWtlZWwuYnV0
dEBsaW51eC5kZXY7IHJ5YW4ucm9iZXJ0c0Bhcm0uY29tOyBIdWFuZywgWWluZw0KPiA8eWluZy5o
dWFuZ0BpbnRlbC5jb20+OyAyMWNuYmFvQGdtYWlsLmNvbTsgYWtwbUBsaW51eC1mb3VuZGF0aW9u
Lm9yZzsNCj4gWm91LCBOYW5oYWkgPG5hbmhhaS56b3VAaW50ZWwuY29tPjsgRmVnaGFsaSwgV2Fq
ZGkgSw0KPiA8d2FqZGkuay5mZWdoYWxpQGludGVsLmNvbT47IEdvcGFsLCBWaW5vZGggPHZpbm9k
aC5nb3BhbEBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjggMy84XSBtbTogenN3
YXA6IFJlbmFtZSB6c3dhcF9wb29sX2dldCgpIHRvDQo+IHpzd2FwX3Bvb2xfdHJ5Z2V0KCkuDQo+
IA0KPiBPbiBGcmksIFNlcCAyNywgMjAyNCBhdCA3OjE24oCvUE0gS2FuY2hhbmEgUCBTcmlkaGFy
DQo+IDxrYW5jaGFuYS5wLnNyaWRoYXJAaW50ZWwuY29tPiB3cm90ZToNCj4gPg0KPiA+IE1vZGlm
eSB0aGUgbmFtZSBvZiB0aGUgZXhpc3RpbmcgenN3YXBfcG9vbF9nZXQoKSB0byB6c3dhcF9wb29s
X3RyeWdldCgpDQo+ID4gdG8gYmUgcmVwcmVzZW50YXRpdmUgb2YgdGhlIGNhbGwgaXQgbWFrZXMg
dG8gcGVyY3B1X3JlZl90cnlnZXQoKS4NCj4gPiBBIHN1YnNlcXVlbnQgcGF0Y2ggd2lsbCBpbnRy
b2R1Y2UgYSBuZXcgenN3YXBfcG9vbF9nZXQoKSB0aGF0IGNhbGxzDQo+ID4gcGVyY3B1X3JlZl9n
ZXQoKS4NCj4gPg0KPiA+IFRoZSBpbnRlbnQgYmVoaW5kIHRoaXMgY2hhbmdlIGlzIGZvciBoaWdo
ZXIgbGV2ZWwgenN3YXAgQVBJIHN1Y2ggYXMNCj4gPiB6c3dhcF9zdG9yZSgpIHRvIGNhbGwgenN3
YXBfcG9vbF90cnlnZXQoKSB0byBjaGVjayB1cGZyb250IGlmIHRoZSBwb29sJ3MNCj4gPiByZWZj
b3VudCBpcyAiMCIgKHdoaWNoIG1lYW5zIGl0IGNvdWxkIGJlIGdldHRpbmcgZGVzdHJveWVkKSBh
bmQgdG8gaGFuZGxlDQo+ID4gdGhpcyBhcyBhbiBlcnJvciBjb25kaXRpb24uIHpzd2FwX3N0b3Jl
KCkgd291bGQgcHJvY2VlZCBvbmx5IGlmDQo+ID4genN3YXBfcG9vbF90cnlnZXQoKSByZXR1cm5z
IHN1Y2Nlc3MsIGFuZCBhbnkgYWRkaXRpb25hbCBwb29sIHJlZmNvdW50cyB0aGF0DQo+ID4gbmVl
ZCB0byBiZSBvYnRhaW5lZCBmb3IgY29tcHJlc3Npbmcgc3ViLXBhZ2VzIGluIGEgbGFyZ2UgZm9s
aW8gY291bGQgc2ltcGx5DQo+ID4gY2FsbCB6c3dhcF9wb29sX2dldCgpLg0KPiA+DQo+ID4gU2ln
bmVkLW9mZi1ieTogS2FuY2hhbmEgUCBTcmlkaGFyIDxrYW5jaGFuYS5wLnNyaWRoYXJAaW50ZWwu
Y29tPg0KPiANCj4gUmV2aWV3ZWQtYnk6IE5oYXQgUGhhbSA8bnBoYW1jc0BnbWFpbC5jb20+DQoN
ClRoYW5rcyBOaGF0ISANCg0KVGhhbmtzLA0KS2FuY2hhbmENCg==

