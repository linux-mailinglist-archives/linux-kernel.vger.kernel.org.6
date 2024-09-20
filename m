Return-Path: <linux-kernel+bounces-333917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7349297CFD9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 04:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 048831F2502C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 02:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8466BB669;
	Fri, 20 Sep 2024 02:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CFE17xSs"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D548F6C
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 02:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726798652; cv=fail; b=Iv0f5OydByhX+uqklKOoGbhAfhKReFj0IDLaKoTgr2T8wcEeWPRosljNyAofIQHONN6s8eV/uSOTN2cps2aOrFspjcFTHTU+0B+1I5KyDRNYNO4HKwCZjad/1eM79MG/XN/OYHeCIOPBiYjYRkNTDHjis3rK0j5orSoztSOWEgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726798652; c=relaxed/simple;
	bh=oTKBH9+SjQLOGBsimHFnXH7obBimcKNJCdtg/f/bUdQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YbPfr/lc0HmRKNkaEnkWV2SHXY8dpXkh5xqEC0c2xYxkCrntmXimvbHHEZm1Q7IJFn4tqe3XZ+nRe7Ye0Q8vhb2lbkb5mc+hLqCvtiiZRTLlDdBfMxo9BlzfwtEzACBejd8ujqVa2k36tMwG0EXHFx+1JBzRkdo3EOE6ZQsOV58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CFE17xSs; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726798650; x=1758334650;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oTKBH9+SjQLOGBsimHFnXH7obBimcKNJCdtg/f/bUdQ=;
  b=CFE17xSsdnI6JR2E4CfsdSX9A+9DpSC33jkeAhy+R4N2nHaethXjvZuU
   3zraiYqV0tQOhPhxfQX+DmQVTRsI9+7d2ZXzB4FRBA9MqweAFP5ZLd+U4
   TKlSjFQLW9CIzwW2X4IKEzU1929L8k5rtbDy8YNGZ9F6K7f2MvME0vJOn
   9YhMvOCo7v7ZkL8T0RoA5s1vnaaewGu6FyNKusASu7w0cRft1jRfb6leO
   7WEeFyZcLxksl6yZspQ/mM6n3Sgnq2SmgAGLbesD8MQvuVdBxjno1uYhd
   39dXDm3PLqZLGJUrTeGDEIIHiQFNejYnmim03kthUNrgaYYIRbWyzm+cG
   g==;
X-CSE-ConnectionGUID: SwYLdm8GSya8lkJPJdWJyA==
X-CSE-MsgGUID: z/1K9nDDQ5Cm9YfSRsOh4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="29578180"
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; 
   d="scan'208";a="29578180"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 19:17:29 -0700
X-CSE-ConnectionGUID: leeEYErlQn6VMlMEFPj6/g==
X-CSE-MsgGUID: CSCxX3TsQcuwjKoceAeJeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; 
   d="scan'208";a="69725628"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Sep 2024 19:17:02 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 19:17:01 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 19 Sep 2024 19:17:01 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Sep 2024 19:17:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PTggpPlROBKzMHGE/olwWIhn/PFVHo/3u1Pr7RGufs7FtC1xKvxH7lg4SZAmbLLfqlKp3nsD9AhXqzTibLfQSP7GiEaQziO1zJ5eanBVWErDUqWsoacYeC0VjXGs27h9jD1k4ZNmmsFrWN2yewkg+RJn2xeC7sR8z02YmMQOPmUj/hyKkLjEKIcodELetKhNUOEgcXBjcmlaA8Xzse2c9dkDpzuojVVRhD9zpxsmVHUJ23GmGbaUUpBiBgUjQr29oYPu2H2ljqSNzjmHnnwVCxOvyZz3eQMNC9ZfRivHuHf0u68jTW0fHFC5QPKma/9cGUxUNh1ZVF94w+GVXM3YfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oTKBH9+SjQLOGBsimHFnXH7obBimcKNJCdtg/f/bUdQ=;
 b=NMEnL0sqVMmojQIrQELyPHDt5/LbT9NF7QnSJuCKFgHKiZYJPSW4pRPjCgAuGQCOuV2/i1HfHmlwu7BDjRhfRATMIGZBB0XbOYL1zFTe5lWTiMmBLRff3r/I9BruyiEnMiRJdKARbA5WWoPRS7fXU/5NxNMC2T6eIVQBAc9JhR9Y17RUt7WtzZe/DgRW4BSHKm7gPOpYwie3/1gmU6qKavzn2AzfzAVv8RAIjsNjQ5DDaLesXOv/YHc4EuBnsY0ZyIWd6XS7NYcOcQH/ASW1mpi5YMqyzLsbSrUyJY58RgpO5n0D1B72/gkW9NNZuwiMenhuyY2sRw/ROshMG1g0Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by DM4PR11MB8201.namprd11.prod.outlook.com (2603:10b6:8:18a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Fri, 20 Sep
 2024 02:16:53 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.7982.018; Fri, 20 Sep 2024
 02:16:53 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosryahmed@google.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "ryan.roberts@arm.com"
	<ryan.roberts@arm.com>, "Huang, Ying" <ying.huang@intel.com>,
	"21cnbao@gmail.com" <21cnbao@gmail.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "Zou, Nanhai" <nanhai.zou@intel.com>, "Feghali,
 Wajdi K" <wajdi.k.feghali@intel.com>, "Gopal, Vinodh"
	<vinodh.gopal@intel.com>, "Sridhar, Kanchana P"
	<kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v6 0/3] mm: ZSWAP swap-out of mTHP folios
Thread-Topic: [PATCH v6 0/3] mm: ZSWAP swap-out of mTHP folios
Thread-Index: AQHa+lo8ysIDIejPvUy4b6yFKhIRqLI+1o8AgAAPzYCAISk8UA==
Date: Fri, 20 Sep 2024 02:16:53 +0000
Message-ID: <SJ0PR11MB567839F1CB09EBD24921AA20C96C2@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20240829212705.6714-1-kanchana.p.sridhar@intel.com>
 <CAJD7tkaqp_3YbK_qsq+v2=Q0r4xwTG9PbbPYjQdpTBu_Z7K5_A@mail.gmail.com>
 <CAKEwX=PXvLZ0GBgBbxSX5qvB-5dYuQ=5Z88UN3oGmNxFMnMtrg@mail.gmail.com>
In-Reply-To: <CAKEwX=PXvLZ0GBgBbxSX5qvB-5dYuQ=5Z88UN3oGmNxFMnMtrg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|DM4PR11MB8201:EE_
x-ms-office365-filtering-correlation-id: f8ff2796-f700-4ee9-9578-08dcd91a4b27
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MEFVNk1BNUNVd3F1dU9rNkRWUTlQdExucEpxa3Y5M001YTFwMjVtZjdFZEdi?=
 =?utf-8?B?VHlEeUpVbE9hVk5BUUpvdGZOVGpVZElNRmh3bmtDK0Y0MVBiTkl3ZHcxeFVN?=
 =?utf-8?B?d3MyTTR6ZWdLZkR1azdDY1Y3SGFXNlhkMFVlVjVxLzhLSkU5RGgzUkNFd0R5?=
 =?utf-8?B?cHByTkxJT2xyUStJSEFFWkNCNXg3QVh2L0dUaGJvUm5TUG5Ndi9lc0JIUjdC?=
 =?utf-8?B?UEdVVVBKUXV3U3hZQVd0TmxhWXU0UHpucFR3ekhkSkg5cDkwZmNNYlN0YjZ2?=
 =?utf-8?B?YXpXQlJqdklZVUhhenFSNVFWU1l1eDBuNDZjc3QwN3dydVM5K3ZNRmFjanhV?=
 =?utf-8?B?K3V2RG9ESnR6emJNbkxybXl4azE2Z0MxdjBXcGpRSzExdVlNL2lOZUJTLzZ0?=
 =?utf-8?B?RWtwZmRQdTUwWnFIUXluMUJYcWF3QnFBck9HV1ZWaDlhaER0eDdUZkpHczYv?=
 =?utf-8?B?LysrTlBpVVUrNm5wcWsvVTdMWElTc29BZExIdC9pRGZZR1c5TW5aOGtCQ3dC?=
 =?utf-8?B?TGIwV0RJdFZHOFFoQVhTbGl2ZVhUaDVibUpHcWF4MDVvUEJWUjBrYzErUnRa?=
 =?utf-8?B?UzhYVkxxRjNlMW8zWEZZem1Xb1JzT1VQQmc4a04zUStUYXJiamd1OEFFWS9N?=
 =?utf-8?B?NXpsRzhoSmZLMTZsandzSVd2V0R5RktVWnZZRUhEcjRaSEVpLzNtVnJVRHVE?=
 =?utf-8?B?dDhVV1pPdHhCZGRpaXZ4WnlhVE9jRzVDQWM4SVV6K1E2TDQrVjdRWko5SkJq?=
 =?utf-8?B?UGpiUGVNQUlNbkp1cVcrUUcrZnBwUDJPSGJvY010dzJla29hdlE0dlVLc2lV?=
 =?utf-8?B?NWVnZXNjNUQyWS80ejgrK3RpK2xVUEEycW1IS2dRVUFQRGg5MU1pb0xma3V0?=
 =?utf-8?B?V3BJMFNqUVBrdWppcFc2TGwwL1lUdWtyb0I4aTNjRUtBRlRxVTRGbVF4S0NN?=
 =?utf-8?B?QkJ1UEpjTWRmRFNQdmVjQVFsdys0OFZkNjNFMzVvM1NDKzB6MnNUT2EyY3g1?=
 =?utf-8?B?cTRoUFB4bWNWbGt2MVF4eENrNERKdXdLZzI1VXU3WVBhNzB2bHdZRGNlN2J3?=
 =?utf-8?B?MVltQXRWM1RqdUE3K0toSWFmMml5QmdEVXhRODgyQ0krMWFXYXZ1REFGTDJv?=
 =?utf-8?B?WjVpeXgyaGxJTEJuRUdUSmRsV3pQcEh6QlBZK0JoUml3TGNjNUJKRHkrUDNU?=
 =?utf-8?B?bFIyUUo3OWJhOGkrS2oyelBnYmRyS3hDTFk3VzY1d3hlbkpPTzZKNFZhYzhm?=
 =?utf-8?B?VWRYTEF5VkpRVURFS3Q4bFA2azlTeVAreFlMamN0NFZDc2VsR01Wc1lmaGkx?=
 =?utf-8?B?eC90TU1EU1N6dFRYQkdDeXZGWS90UThOeTlVaG8rSmttaHRzMGxRUWRDTmxs?=
 =?utf-8?B?VVRoVmtxVjJsSjNLR0FEVTFOSXhZL0IxYVJkRUl3cE1kSGdpQjNGbUVCY3Q2?=
 =?utf-8?B?cVZtOHI1YVN2RW1tVGtmcWFKbkE0MUNXNnZSME9LYk1ML3B2VUdmYTc5NkFv?=
 =?utf-8?B?OTR2bUVKR0RvRmQyYlhlc2ZDQmRtZkE4T1N4cEo1TnFUdWtxTmphbWxqb1Zi?=
 =?utf-8?B?Qy9HWElOTmpIM2R3d3lrMWJ2bGk2TUw1eTk3UW4weXpINlVKM2tNbjgvaVBz?=
 =?utf-8?B?QnB1Z0hRRE9uemlEZjRBSFhJUG9BR2piM3YrZGE5NjdxN2h1Kytidk13QWVG?=
 =?utf-8?B?VkN5bnppWnd6RXB1cTQwVmVrbTdLZWpsakxsdUVFTmhRZUZuNDUyV3RQc2lI?=
 =?utf-8?B?VFVxZ2FqUmMwZjc4eWdhNUowbkptUURhMWdmUi90M3Jyb1Jpd1VGempDYm9h?=
 =?utf-8?B?VzhqR0xmZXR5bTBXQkZGOTZ4Zkk3MnBrcEVFTEkwbmo0SDJLYzY5WU94Titq?=
 =?utf-8?B?NWFjR3BQZDlsRnd4RXRVa2NOMWJhL212aXU0djZGQWlxZ1E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?anJSN2RUZFJXcXgveC9xYmhieG9WbG5ZTUtkQ3ZCUFFITjFrK1RzS3lOYk9E?=
 =?utf-8?B?aGx5K1JNeEJucjhQOW5Fdm0rWVlUeHRXUUhpM0NVNDdkUGltR0w1b2k1UVVp?=
 =?utf-8?B?TmgyMm1pTmd0QVdTamM5NkNqbFZQSGtZZWYrNWZGMndJVUxmU2VPdTZMaHhk?=
 =?utf-8?B?Q0lGWkRjNk1DVWJlQTB6c0w2YjRFVEtZMk82V2lWdFptcVNGbXg0QUh5ckJx?=
 =?utf-8?B?ZnZ1K0MvbmppbzRCdVNGeEpoK0tXV1VWUThoY3BTZHBoQllTTkdINVZwQUhu?=
 =?utf-8?B?NjlDSGV2UU9OOFh4ZmsveW1IVW1EOXJjdzNTbGVXc2dDK2tCY2ZpYU1GS2N0?=
 =?utf-8?B?Ym9mOXJURGZEUmd0MlNmdE9HY0plWlBieGZJVHpLNzVIaWdFWnBTWW83cnYw?=
 =?utf-8?B?ZUpLOHJMdGVweTFuRGE4UWd5NkNFSWF4K1NlbXE5SG9rWHROMFA1bENjYjcx?=
 =?utf-8?B?OE10TWpJN0dVU1BRTVhkS2dRVGdFMGxhVmRRQ3pObFpQRlAzc0xVTHlnbWYy?=
 =?utf-8?B?d05TOHZtcHJZcGlmWWl6emoxL3ZIS0xZNTVzeFkyc1hsOTJ3SDlsQmhBTXdj?=
 =?utf-8?B?bURDTjV5YTl4RGNlLzZYRU4xald0VitWbWJTZzBFaGRBVnFkWWkrVVdjU3ZP?=
 =?utf-8?B?TmkvS2RyYm1RSVdRSEIrb1ZOQjBpaThTbkVvelNCeVQyUm9sZ3dVbzc4NnBh?=
 =?utf-8?B?aFpJaG9udUFNMjM0TS9MTHZTRFd0QkFQY21QOHJXYVpPU29YeVRScGI3cWJ3?=
 =?utf-8?B?MjRhRFg4OE5jZGtydjFZcm45ZjdlNVlYZmdtOEJvdlhSYWJONEtCZDlQS0Ni?=
 =?utf-8?B?VEo1RU1yVVpBbHdUYVVhakpkSm04Yk5LSU5SQmtyeWN4V1ZuWWhWTmpDRzJN?=
 =?utf-8?B?eWNxaUtBK1VzWTZCOVpBUUxNS2VQbXozSWFmcHh1b2ZDaFdMRFZ1RVQ1Q3JK?=
 =?utf-8?B?Tk0rZUVUUmcvRUdpeUFOc0p4OGJ1aEExRjUvcnF0T0o0NU1yVThpSmRTays3?=
 =?utf-8?B?OHlLendrU3pFUUJzRU9EdWF2RUprb25zTUF6WDkyTVRWRnNiWW96Z0ZnbnIr?=
 =?utf-8?B?ckF3bVVtbDd3MERlcmRwV1k3VUpabmo1RUF1dFZIMWhhUjJLL094ZVhJNG9Y?=
 =?utf-8?B?VUdzRTF6SWZaT1N6WTNTOE1sOC9aajVTSW1YdlpncGRTYUM5blh6RGthYVRn?=
 =?utf-8?B?bjJySzkxenpET3FIUGpFeFk4WkNnM1BGYzJqRHRWb2VScEhVemhiUWZsTjdx?=
 =?utf-8?B?NHFTQUJTUW1ndUhMNHRCZlJwZytNaEVpTDVXVmZrUFJDNTZTUnlVOGVhVWs4?=
 =?utf-8?B?bUpaTHhkRndTZFhDZUxabVNFSW14NG5obHNVR1dpSUJieElUdUNjZCtUMXA2?=
 =?utf-8?B?dHBQQks3YVYzajFDakx0cU5waEFvSTNLc2hUWUprOEFxMEFFVnpqL0ZYekRC?=
 =?utf-8?B?OUROMmRxMGpZcWhlRXBUTXBVWkFlam84Ymw0bU9lL1dMa3lxb0NtenVhZitk?=
 =?utf-8?B?QnBuM3dxbVVpQTJxSzZrTkc3Z1B2TWkyaFI0c1RLaFVGVG5RekZabFhLVWQy?=
 =?utf-8?B?eFFDTUtMQS94THFzK2VhRnZXdHB6T2hvSWlzcDU2UU93NWdQcFNqL3NjVFN6?=
 =?utf-8?B?OEd4U2NDU3ZIYit4N3JrSGFpU21kNEo5TzBKM2g3LzFTMVhBK3ZVdzI3N2VE?=
 =?utf-8?B?QVBqNFliZkUyRXhQUlVXaVJ6YWpQWFZSQXdWeUZxYURnS1I4d1FSTVVVY3RR?=
 =?utf-8?B?b21MMkx3ZzNKUkxtR1A4cGZ4NHdlNUhNbVdabjFEK0hXMXU4Y3ZSNXorZDZ5?=
 =?utf-8?B?ZEZIOUFVQngwWWNUNko4K0NaOHdSVmoyVFNXNXp4TFpqTG91OUROb1JxVkxR?=
 =?utf-8?B?dlBaS3NEK0hBdURNeklHZDFBdk5abUNkQWNkcnVDWUE2a2JaUUpVaUZxemJH?=
 =?utf-8?B?N2J0TnZPdjdFNjV1ZkFIeUM3ZSt5OXRKbzlRRjZBYkhGcTQ5SHFQUnlScVFX?=
 =?utf-8?B?a1RuUzNmeTVVUGNYRkdwSlJJeDBTTWVNcDVVNVg4b3hlQ2tKSmpJS1lnckpB?=
 =?utf-8?B?YmVvRDJ3RTlQQVZDd0xxTFpJSVkyNnF0QmhtR1JOUWtnWVZSNnlxaEgrREtS?=
 =?utf-8?B?elBOajB6eUlSYmF2Y21qUldpNmd1TFJJb2VrMmlIZzI0THcyd09tQWlQcmh6?=
 =?utf-8?B?TUE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f8ff2796-f700-4ee9-9578-08dcd91a4b27
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2024 02:16:53.2432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n5CyQUwlKQ3BZGPZLIPUR0oYUYfGRxQWVwDSLDq/I2AWFOlEpnvCooGqafzWZqO9+H59WpnHeVllzgHguQR2w63glWFZcxYdYQypu0spVdY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8201
X-OriginatorOrg: intel.com

SGkgTmhhdCwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOaGF0IFBo
YW0gPG5waGFtY3NAZ21haWwuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgQXVndXN0IDI5LCAyMDI0
IDQ6NDYgUE0NCj4gVG86IFlvc3J5IEFobWVkIDx5b3NyeWFobWVkQGdvb2dsZS5jb20+DQo+IENj
OiBTcmlkaGFyLCBLYW5jaGFuYSBQIDxrYW5jaGFuYS5wLnNyaWRoYXJAaW50ZWwuY29tPjsgbGlu
dXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LW1tQGt2YWNrLm9yZzsgaGFubmVz
QGNtcHhjaGcub3JnOw0KPiBjaGVuZ21pbmcuemhvdUBsaW51eC5kZXY7IHVzYW1hYXJpZjY0MkBn
bWFpbC5jb207DQo+IHJ5YW4ucm9iZXJ0c0Bhcm0uY29tOyBIdWFuZywgWWluZyA8eWluZy5odWFu
Z0BpbnRlbC5jb20+Ow0KPiAyMWNuYmFvQGdtYWlsLmNvbTsgYWtwbUBsaW51eC1mb3VuZGF0aW9u
Lm9yZzsgWm91LCBOYW5oYWkNCj4gPG5hbmhhaS56b3VAaW50ZWwuY29tPjsgRmVnaGFsaSwgV2Fq
ZGkgSyA8d2FqZGkuay5mZWdoYWxpQGludGVsLmNvbT47DQo+IEdvcGFsLCBWaW5vZGggPHZpbm9k
aC5nb3BhbEBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjYgMC8zXSBtbTogWlNX
QVAgc3dhcC1vdXQgb2YgbVRIUCBmb2xpb3MNCj4gDQo+IE9uIFRodSwgQXVnIDI5LCAyMDI0IGF0
IDM6NDnigK9QTSBZb3NyeSBBaG1lZCA8eW9zcnlhaG1lZEBnb29nbGUuY29tPg0KPiB3cm90ZToN
Cj4gPg0KPiA+IE9uIFRodSwgQXVnIDI5LCAyMDI0IGF0IDI6MjfigK9QTSBLYW5jaGFuYSBQIFNy
aWRoYXINCj4gPg0KPiA+IFdlIGFyZSBiYXNpY2FsbHkgY29tcGFyaW5nIHpyYW0gd2l0aCB6c3dh
cCBpbiB0aGlzIGNhc2UsIGFuZCBpdCdzIG5vdA0KPiA+IGZhaXIgYmVjYXVzZSwgYXMgeW91IG1l
bnRpb25lZCwgdGhlIHpzd2FwIGNvbXByZXNzZWQgZGF0YSBpcyBiZWluZw0KPiA+IGFjY291bnRl
ZCBmb3Igd2hpbGUgdGhlIHpyYW0gY29tcHJlc3NlZCBkYXRhIGlzbid0LiBJIGFtIG5vdCByZWFs
bHkNCj4gPiBzdXJlIGhvdyB2YWx1YWJsZSB0aGVzZSB0ZXN0IHJlc3VsdHMgYXJlLiBFdmVuIGlm
IHdlIHJlbW92ZSB0aGUgY2dyb3VwDQo+ID4gYWNjb3VudGluZyBmcm9tIHpzd2FwLCB3ZSB3b24n
dCBzZWUgYW4gaW1wcm92ZW1lbnQsIHdlIHNob3VsZCBleHBlY3QgYQ0KPiA+IHNpbWlsYXIgcGVy
Zm9ybWFuY2UgdG8genJhbS4NCj4gPg0KPiA+IEkgdGhpbmsgdGhlIHRlc3QgcmVzdWx0cyB0aGF0
IGFyZSByZWFsbHkgdmFsdWFibGUgYXJlIGNhc2UgMSwgd2hlcmUNCj4gPiB6c3dhcCB1c2VycyBh
cmUgY3VycmVudGx5IGRpc2FibGluZyBDT05GSUdfVEhQX1NXQVAsIGFuZCBnZXQgdG8gZW5hYmxl
DQo+ID4gaXQgYWZ0ZXIgdGhpcyBzZXJpZXMuDQo+IA0KPiBBaCwgdGhpcyBpcyBhIGdvb2QgcG9p
bnQuDQo+IA0KPiBJIHRoaW5rIHRoZSBwb2ludCBvZiBjb21wYXJpbmcgbVRIUCB6c3dhcCB2LnMg
bVRIUCAoU1NEKXN3YXAgaXMgbW9yZQ0KPiBvZiBhIHNhbml0eSBjaGVjay4gSU9XLCBpZiBtVEhQ
IHN3YXAgb3V0cGVyZm9ybXMgbVRIUCB6c3dhcCwgdGhlbg0KPiBzb21ldGhpbmcgaXMgd3Jvbmcg
KG90aGVyd2lzZSB3aHkgd291bGQgZW5hYmxlIHpzd2FwIC0gbWlnaHQgYXMgd2VsbA0KPiBqdXN0
IHVzZSBzd2FwLCBzaW5jZSBTU0Qgc3dhcCB3aXRoIG1USFAgPj4+IHpzd2FwIHdpdGggbVRIUCA+
Pj4genN3YXANCj4gd2l0aG91dCBtVEhQKS4NCj4gDQo+IFRoYXQgc2FpZCwgSSBkb24ndCB0aGlu
ayB0aGlzIGJlbmNobWFyayBjYW4gc2hvdyBpdCBhbnl3YXkuIFRoZSBhY2Nlc3MNCj4gcGF0dGVy
biBoZXJlIGlzIHN1Y2ggdGhhdCBhbGwgdGhlIGFsbG9jYXRlZCBtZW1vcmllcyBhcmUgcmVhbGx5
IGNvbGQsDQo+IHNvIHN3YXAgdG8gZGlzayAob3IgdG8genJhbSwgd2hpY2ggZG9lcyBub3QgYWNj
b3VudCBtZW1vcnkgdXNhZ2UNCj4gdG93YXJkcyBjZ3JvdXApIGlzIGJldHRlciBieSBkZWZpbml0
aW9uLi4uIEFuZCBLYW5jaGFuYSBkb2VzIG5vdCBzZWVtDQo+IHRvIGhhdmUgYWNjZXNzIHRvIHNl
dHVwIHdpdGggbGFyZ2VyIFNTRCBzd2FwZmlsZXM/IDopDQoNCkFzIGZvbGxvdyB1cCwgSSBjcmVh
dGVkIGEgc3dhcGZpbGUgb24gZGlzayB0byBpbmNyZWFzZSB0aGUgU1NEIHN3YXAgdG8gMTc5Ry4N
Cg0KIDY0S0IgbVRIUCAoY2dyb3VwIG1lbW9yeS5oaWdoIHNldCB0byA0MEcsIG5vIHN3YXAgbGlt
aXQpOg0KID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PQ0KIENPTkZJR19USFBfU1dBUD1ZDQogU2FwcGhpcmUgUmFwaWRzIHNlcnZlciB3aXRo
IDUwMyBHaUIgUkFNIGFuZCAxNzlHIFNTRCBzd2FwIGJhY2tpbmcgZGV2aWNlDQogZm9yIHpzd2Fw
Lg0KDQogdXNlbWVtIC0taW5pdC10aW1lIC13IC1PIC0tc2xlZXAgMCAtbiA3MCAxZzoNCg0KIC0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0NCiAgICAgICAgICAgICAgICAgICAgbW0tdW5zdGFibGUgOS0x
Ny0yMDI0ICAgICAgICAgICB6c3dhcC1tVEhQIHY2ICAgICBDaGFuZ2Ugd3J0DQogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBCYXNlbGluZSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBCYXNlbGluZQ0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgImJlZm9yZSIg
ICAgICAgICAgICAgICAgICJhZnRlciIgICAgICAoc2xlZXAgMCkNCiAtLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tDQogWlNXQVAgY29tcHJlc3NvciAgICAgICB6c3RkICAgICBkZWZsYXRlLSAgICAgICAg
enN0ZCAgICBkZWZsYXRlLSAgenN0ZCBkZWZsYXRlLQ0KICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBpYWEgICAgICAgICAgICAgICAgICAgICBpYWEgICAgICAgICAgICBpYWEN
CiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQogVGhyb3VnaHB1dCAoS0IvcykgICAgOTMsMjczICAg
ICAgIDg4LDQ5NiAgICAgMTQzLDExNyAgICAgMTM0LDEzMSAgICA1MyUgICAgIDUyJQ0KIHN5cyB0
aW1lIChzZWMpICAgICAgIDMxNi42OCAgICAgICAzNDkuMDAgICAgICA5MTcuODggICAgICA4Nzcu
NzQgIC0xOTAlICAgLTE1MiUNCiBtZW1jZ19oaWdoICAgICAgICAgICA3Myw4MzYgICAgICAgODMs
NTIyICAgICAxMjYsMTIwICAgICAxMzMsMDEzDQogbWVtY2dfc3dhcF9mYWlsICAgICAyNjEsMTM2
ICAgICAgMzI0LDUzMyAgICAgNDk0LDE5MSAgICAgNTc4LDgyNA0KIHBzd3BpbiAgICAgICAgICAg
ICAgICAgICAxNiAgICAgICAgICAgMTEgICAgICAgICAgIDAgICAgICAgICAgIDANCiBwc3dwb3V0
ICAgICAgICAgICAxLDI0MiwxODcgICAgMSwyNjMsNDkzICAgICAgICAgICAwICAgICAgICAgICAw
DQogenN3cGluICAgICAgICAgICAgICAgICAgNjk0ICAgICAgICAgIDY2OCAgICAgICAgIDcxMiAg
ICAgICAgIDcwMg0KIHpzd3BvdXQgICAgICAgICAgIDMsOTkxLDQwMyAgICA0LDkzMyw5MDEgICA5
LDI4OSwwOTIgIDEwLDQ2MSw5NDgNCiB0aHBfc3dwb3V0ICAgICAgICAgICAgICAgIDAgICAgICAg
ICAgICAwICAgICAgICAgICAwICAgICAgICAgICAwDQogdGhwX3N3cG91dF8gICAgICAgICAgICAg
ICAwICAgICAgICAgICAgMCAgICAgICAgICAgMCAgICAgICAgICAgMA0KICBmYWxsYmFjaw0KIHBn
bWFqZmF1bHQgICAgICAgICAgICAzLDQ4OCAgICAgICAgMywzNTMgICAgICAgMywzNzcgICAgICAg
Myw0OTkNCiBaU1dQT1VULTY0a0IgICAgICAgICAgICBuL2EgICAgICAgICAgbi9hICAgICAxMTAs
MDY3ICAgICAxMDMsOTU3DQogU1dQT1VULTY0a0IgICAgICAgICAgNzcsNjM3ICAgICAgIDc4LDk2
OCAgICAgICAgICAgMCAgICAgICAgICAgMA0KIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCg0KV2Ug
ZG8gc2VlIDUwJSB0aHJvdWdocHV0IGltcHJvdmVtZW50IHdpdGggbVRIUC16c3dhcCB3cnQgbVRI
UC1TU0QuDQpUaGUgc3lzIHRpbWUgaW5jcmVhc2UgY2FuIGJlIGF0dHJpYnV0ZWQgdG8gaGlnaGVy
IHN3YXBvdXQgYWN0aXZpdHkNCm9jY3VycmluZyB3aXRoIHpzd2FwLW1USFAuDQoNCkkgaG9wZSB0
aGlzIHF1YW50aWZpZXMgdGhlIGJlbmVmaXQgb2YgbVRIUC16c3dhcCB3cnQgbVRIUC1TU0QgaW4g
YQ0Kbm9uLXN3YXAtY29uc3RyYWluZWQgc2V0dXAuIFRoZSA0RyBTU0Qgc3dhcCBzZXR1cCBkYXRh
IEkgc2hhcmVkDQppbiBteSByZXNwb25zZSB0byBZb3NyeSBhbHNvIGluZGljYXRlcyBiZXR0ZXIg
dGhyb3VnaHB1dCB3aXRoIG1USFAtenN3YXANCmFzIGNvbXBhcmVkIHRvIG1USFAtU1NELg0KDQpQ
bGVhc2UgZG8gbGV0IG1lIGtub3cgaWYgeW91IGhhdmUgYW55IG90aGVyIHF1ZXN0aW9ucy9zdWdn
ZXN0aW9ucy4NCg0KVGhhbmtzLA0KS2FuY2hhbmENCg0KPiANCj4gPg0KPiA+IElmIHdlIHJlYWxs
eSB3YW50IHRvIGNvbXBhcmUgQ09ORklHX1RIUF9TV0FQIG9uIGJlZm9yZSBhbmQgYWZ0ZXIsIGl0
DQo+ID4gc2hvdWxkIGJlIHdpdGggU1NEIGJlY2F1c2UgdGhhdCdzIGEgbW9yZSBjb252ZW50aW9u
YWwgc2V0dXAuIEluIHRoaXMNCj4gPiBjYXNlIHRoZSB1c2VycyB0aGF0IGhhdmUgQ09ORklHX1RI
UF9TV0FQPXkgb25seSBleHBlcmllbmNlIHRoZQ0KPiA+IGJlbmVmaXRzIG9mIHpzd2FwIHdpdGgg
dGhpcyBzZXJpZXMuIFlvdSBtZW50aW9uZWQgZXhwZXJpbWVudGluZyB3aXRoDQo+ID4gdXNlbWVt
IHRvIGtlZXAgdGhlIG1lbW9yeSBhbGxvY2F0ZWQgbG9uZ2VyIHNvIHRoYXQgeW91J3JlIGFibGUg
dG8gaGF2ZQ0KPiA+IGEgZmFpciB0ZXN0IHdpdGggdGhlIHNtYWxsIFNTRCBzd2FwIHNldHVwLiBE
aWQgdGhhdCB3b3JrPw0KPiA+DQo+ID4gSSBhbSBob3BpbmcgTmhhdCBvciBKb2hhbm5lcyB3b3Vs
ZCBzaGVkIHNvbWUgbGlnaHQgb24gd2hldGhlciB0aGV5DQo+ID4gdXN1YWxseSBoYXZlIENPTkZJ
R19USFBfU1dBUCBlbmFibGVkIG9yIG5vdCB3aXRoIHpzd2FwLiBJIGFtIHRyeWluZyB0bw0KPiA+
IGZpZ3VyZSBvdXQgaWYgYW55IHJlYXNvbmFibGUgc2V0dXBzIGVuYWJsZSBDT05GSUdfVEhQX1NX
QVAgd2l0aCB6c3dhcC4NCj4gPiBPdGhlcndpc2UgdGhlIHRlc3RpbmcgcmVzdWx0cyBmcm9tIGNh
c2UgMSBzaG91bGQgYmUgc3VmZmljaWVudC4NCj4gPg0KPiA+ID4NCj4gPiA+IEluIG15IG9waW5p
b24sIGV2ZW4gdGhvdWdoIHRoZSB0ZXN0IHNldCB1cCBkb2VzIG5vdCBwcm92aWRlIGFuIGFjY3Vy
YXRlDQo+ID4gPiB3YXkgZm9yIGEgZGlyZWN0IGJlZm9yZS9hZnRlciBjb21wYXJpc29uIChiZWNh
dXNlIG9mIHpzd2FwIHVzYWdlIGJlaW5nDQo+ID4gPiBjb3VudGVkIGluIGNncm91cCwgaGVuY2Ug
dG93YXJkcyB0aGUgbWVtb3J5LmhpZ2gpLCBpdCBzdGlsbCBzZWVtcw0KPiA+ID4gcmVhc29uYWJs
ZSBmb3IgenN3YXBfc3RvcmUgdG8gc3VwcG9ydCAobSlUSFAsIHNvIHRoYXQgZnVydGhlcg0KPiBw
ZXJmb3JtYW5jZQ0KPiA+ID4gaW1wcm92ZW1lbnRzIGNhbiBiZSBpbXBsZW1lbnRlZC4NCj4gPg0K
PiA+IFRoaXMgaXMgb25seSByZWZlcnJpbmcgdG8gdGhlIHJlc3VsdHMgb2YgY2FzZSAyLCByaWdo
dD8NCj4gPg0KPiA+IEhvbmVzdGx5LCBJIHdvdWxkbid0IHdhbnQgdG8gbWVyZ2UgbVRIUCBzd2Fw
b3V0IHN1cHBvcnQgb24gaXRzIG93bg0KPiA+IGp1c3QgYmVjYXVzZSBpdCBlbmFibGVzIGZ1cnRo
ZXIgcGVyZm9ybWFuY2UgaW1wcm92ZW1lbnRzIHdpdGhvdXQNCj4gPiBoYXZpbmcgYWN0dWFsIHBh
dGNoZXMgZm9yIHRoZW0uIEJ1dCBJIGRvbid0IHRoaW5rIHRoaXMgY2FwdHVyZXMgdGhlDQo+ID4g
cmVzdWx0cyBhY2N1cmF0ZWx5IGFzIGl0IGRpc21pc3NlcyBjYXNlIDEgcmVzdWx0cyAod2hpY2gg
SSB0aGluayBhcmUNCj4gPiBtb3JlIHJlYXNvbmFibGUpLg0KPiA+DQo+ID4gVGhuYWtzDQo=

