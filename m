Return-Path: <linux-kernel+bounces-305943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 270499636B8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 02:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BA5BB2333E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 00:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2519F947A;
	Thu, 29 Aug 2024 00:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TcmT0giC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B096A93D
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 00:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724890506; cv=fail; b=Rx+f/OUDujywyPiD9bA9NgH11FNdkgAqfhwf4LV40GpPVBrnJbJhd02b5YWy7JGUbgIQ8TcO/2IksPJKpuK7F4ozc6HEYIcwZp8VWuny7/knX87dpllzODdMXRIGyC5LxKtib0M0Ib5iGWMCjXC07QBemhgHnwRu+y+oxBanrms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724890506; c=relaxed/simple;
	bh=ts2x5FShhgQlBCY6ocNQo/PGcg9kjDg89LfkFSj8T5w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i70ERR/ncJlNfIzZXwDgPbGSBhU1HIAJ975L3bluhM8qAPdmjgjbkxfEHJyT9IDL6XUPLWyGT0fpEP8aL6ZzPJMycJVtDrZzIonUzQ2JHS8Ah8PUO+dL43uUxY6j95VCdM5BmwyXuKy7s4kNVbR9vBky0ncosEXflisnFmfukUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TcmT0giC; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724890505; x=1756426505;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ts2x5FShhgQlBCY6ocNQo/PGcg9kjDg89LfkFSj8T5w=;
  b=TcmT0giCQ9m0Z8SzflJUy5SvLF74Fag5QljG88DKu/dwkCNhrHFBBNLS
   MZSkLqAZIOwgwhcyu2KpxMvEHBLahOOpZD0LyTjiF25w7FHVhCzEFAiYV
   7BfXZShkvruvtWdfMqiMZLRkyMwaAtTN0XSQOsxKMmxWmYgnQpZWfNmh/
   mY4pTnCpfEO8CNHEIW0RGIhxvRQ7zuE4LR/XJQucjq2eQ2G6nBvjlliI+
   ond7c+juSrfVmpg+ueuvsmsiHno2ItA6fyUgHuGvxCaJGFJYSc0bDiemS
   f/92kLXBfcHXsC2uXC3VFt8aBRAaUfcb+0T9TSqqtCnjGUdZrggXL9WF+
   w==;
X-CSE-ConnectionGUID: hA/GhGlAR12xhFqwyIHuMg==
X-CSE-MsgGUID: RTymzIWkQ4OYc7FLyxpvoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="34027730"
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="34027730"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 17:15:04 -0700
X-CSE-ConnectionGUID: AXo+K/EjST+niM/Zpwu7tQ==
X-CSE-MsgGUID: qLbbTBXgTU2YnkNWQ8i8+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="94211593"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Aug 2024 17:15:03 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 28 Aug 2024 17:15:03 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 28 Aug 2024 17:15:02 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 28 Aug 2024 17:15:02 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.43) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 28 Aug 2024 17:15:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j0OJpqgpndiZ5B3sts9Ap+osyW8jTCVk8KWYCHZtNxxvUGAXBqsToeEUEQ0DJ6P5vBG0wy8syRQuIeIizjmZTsLdQXy3NYZXsMQzYdSYwdSgYdWqXZH9WccLOw9+Ji7LUwVdPRyjNPnMksuJKR/UdqVFl/KbMcvwfdnjFLWB+4daPX4PT8Fbq/0kqVv4HeVnoNa+1cN6/zkLr23+5W9ESvY1BkW47JTkkWJL6wynU7iI3QA4WpwuHgcPYbCc6KivaWyjeZI+AO09+36d/xmXAoB/CD0JmN3FYw7bG+bfphhP3IIJ3jqVA1beanYrp1Rzl6ZCUd2uoQpvVvAcoJMZCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ts2x5FShhgQlBCY6ocNQo/PGcg9kjDg89LfkFSj8T5w=;
 b=YhrOC5WC5AwM7WNvHK/6wVfgzodkLvsrSsE9DuVzO9bcPULZAt1sdUyaIPWXx4sP1xZY1X4ULWSSh1RQv0m8/v9CO6tPgmnP9CGLIVZ7P2xoBcrbCo4aFsrNLNOa3EjzWA7sF9T8O2JtHqQYo/FlAPWg6XtTAPhVxxguOAGnHru2KipXqQ5ZTTR9i1N2wuestojq5jMO7NiW+yp5atwx7npHJ4zFC5BRLsQn+qrNoBOuytxUxW7EwgJXa7XHaEgRTy8eh5UKBFpCAcMAi5qVy/xLkeqqd9h7VHcTN7tR1GrYBWB6S4lQsZ7/vsPszCbIHgFf694ybuE8R7Ku5VFxUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by MW4PR11MB7054.namprd11.prod.outlook.com (2603:10b6:303:219::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Thu, 29 Aug
 2024 00:14:54 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%5]) with mapi id 15.20.7875.019; Thu, 29 Aug 2024
 00:14:54 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Yosry Ahmed <yosryahmed@google.com>
CC: Nhat Pham <nphamcs@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>, "ryan.roberts@arm.com"
	<ryan.roberts@arm.com>, "Huang, Ying" <ying.huang@intel.com>,
	"21cnbao@gmail.com" <21cnbao@gmail.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "Zou, Nanhai" <nanhai.zou@intel.com>, "Feghali,
 Wajdi K" <wajdi.k.feghali@intel.com>, "Gopal, Vinodh"
	<vinodh.gopal@intel.com>, "Sridhar, Kanchana P"
	<kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v4 0/4] mm: ZSWAP swap-out of mTHP folios
Thread-Topic: [PATCH v4 0/4] mm: ZSWAP swap-out of mTHP folios
Thread-Index: AQHa8d3OD+uOh/WK5kyI6A6kVnXGhrIxzReAgABJIZCAA+ChsIADqWIAgABIr/CAAV2VgIAALnjAgADdOKCAAAYagIAApBhggABUs4CAABndUA==
Date: Thu, 29 Aug 2024 00:14:54 +0000
Message-ID: <SJ0PR11MB5678831A9D00B05E901ED263C9962@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20240819021621.29125-1-kanchana.p.sridhar@intel.com>
 <CAKEwX=OO6frFa+S3xjtoabB2dY1Y5RN5qjMsVUsgKDK_QuOFzg@mail.gmail.com>
 <SJ0PR11MB5678288EE890E8CB882839CDC98E2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <SJ0PR11MB567801EE747E2810EF183C73C9892@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAKEwX=PYv4Cn_a7WSnbUyhwSBO61xoDPSexXxS0uwwxu5P6XLw@mail.gmail.com>
 <SJ0PR11MB5678E44062CADBE8BAB546F3C9942@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAKEwX=ORuJabxQSehU5E0QNG=Gx6QkyTCb1vek3AOcQuvF54Xg@mail.gmail.com>
 <DM8PR11MB5671D72CED6850CDBB62B95FC9942@DM8PR11MB5671.namprd11.prod.outlook.com>
 <SJ0PR11MB567807116A760D785F9822EBC9952@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkb0Lnq+mrFtpba80ck76BF2Hnc9Rn8OVs_7dqmE2Hww2w@mail.gmail.com>
 <SJ0PR11MB56788C517A01B83174591A45C9952@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkakML3vrZzG_tnxU9SuA3DFGiZY4pQDn4Yruv9y9vhVNg@mail.gmail.com>
In-Reply-To: <CAJD7tkakML3vrZzG_tnxU9SuA3DFGiZY4pQDn4Yruv9y9vhVNg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|MW4PR11MB7054:EE_
x-ms-office365-filtering-correlation-id: 4026a9b0-146c-47b5-73e9-08dcc7bf9bf4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?OE9LeUNaVXkzOU4zVlZyMktOZFFZUWxuMmRLSnd5WENmODBDQVpaSFkyNFc0?=
 =?utf-8?B?aGlQaVA1elo0WHhyNVpHZ0ZOVzJ3SGxGSnczcisvRmdJSzg1U0JHZHI2VXk1?=
 =?utf-8?B?RHNOMVN3b0U5c0pORllnWVRwbmtnNVpXQTJRU0F6cEhDdzhRZHV6Y3h5eHl5?=
 =?utf-8?B?VE1kOU96TEpFQlo1MEFDb0g1RHdrVGcxRWRESHAxampVbGRQTHhVOEVHY0Zw?=
 =?utf-8?B?OFozUUx2S3ZHVDZ3TnVYdVNEdnN4MGRuZDBDMEo4YTJHamhTajc4bkdBS0Yx?=
 =?utf-8?B?R2RMV0ZLaUxXbENDdTN3R3kvbVJaUUJSRVhHcW5PRllCUENaK1ZwRUFXak1Y?=
 =?utf-8?B?Y1QyNnh6OENyVGJmWk1qRFV2WGNIUWs4TGZMTmVJREphZE1CTE1xcE5ja054?=
 =?utf-8?B?azZ3NEtjRTBYSzNKVy9nWUZocGFnOEZ2S01rNlRWSTNzRXhXalBFQTF5ZXZl?=
 =?utf-8?B?NkJxRldmZFU4MUZJVjNXUDlvQThVOUJCUHdac0VSam1MdnhnTytVS3ExdVFJ?=
 =?utf-8?B?ZE5Bd0lCYjllVzdFTWQzTGg3ZHFSYkZtNEZ0RzcxZk56SmVnRk1GL2Rzckll?=
 =?utf-8?B?YjR2V09oZnExUjJER2dXMjU5QzhuL3ovYnNQU0tFZDNuUHNSV2dNempWTFNW?=
 =?utf-8?B?VERqUWRxVWY1Qy9INXo3dHF6elE0NWFqM0RFeGZiT3hnZXFqSnkrRzdRNnR1?=
 =?utf-8?B?R1orYktlZlRmVVR6YmpvVkcvczUvRmJaOGtmRnBQWGxLVlE0SnZ5N25jZ1BH?=
 =?utf-8?B?TVBzdDIvQndSVENwUXVIRXU1UlNwd01hU1ZaQ1dKd2doQ0NhYmhpQ1JQRDFB?=
 =?utf-8?B?dEVURE9VSFdmUS9Hbm5XR0l6RWNhWEF5MmhaSzhpTlBLT3A0WVZ4cnViU0tQ?=
 =?utf-8?B?R3R5cG84Tk9sNUtOSXdGc2xJbjY3RkJubnJIbWh1bmRLWk43VjVnUTBSREYv?=
 =?utf-8?B?ZDRhd0ZyeUVDK1h6RnYrc0pxSmFNdWM1NFE4cDhRR0dOS1YzTU03UlBvNzNC?=
 =?utf-8?B?RzJSbmNMbTdETXR0bUVNMlRiRktQV2szaURMSUVMUnJDVDdmQTZVOXYybVJp?=
 =?utf-8?B?SlBDNmt1Q29LMmcvN25YVkFqZWJ3ZllnUUFobDd6S3lsRWNsSEVINGFScWEx?=
 =?utf-8?B?cCtBU04rRFFCaHo5R2wwbW1yNHVlTHlwNDN3YlFnVWhwTVFDWll3RjdKdUhj?=
 =?utf-8?B?dytnYTFmQ2dkM1Mxbjc0WTVpNFlvU3pvSERtWTdrUDBzQTJUOFlVTWcxUW9L?=
 =?utf-8?B?ZWZJQUZxdjIva2k0RUVVbTlFTzZqcTJ4WG5vVDRrZkJ6cHFyaHlmcnVyYWpm?=
 =?utf-8?B?SThFbDEyckNNa280THJDOENjNDhuRzdGRWtUMkxYd3dQTVlua3RpOUI3QTd6?=
 =?utf-8?B?eEhYR1dxeUZ4VG5Hb3FEY1VQV3BpWUhrSlFkSHR5cUZlSWowdE1qek9KdnVm?=
 =?utf-8?B?QTdmVmlOSlE3QkJnb0YrNE0vemg3UFBzWlhvU1BFbUVZT0V0Qkw2YjU1aGNl?=
 =?utf-8?B?bERwbWhzM3QreExOdEN3Tm9LVnFKa1NiZnNlaFF3R0R2Q3dBM1FVUzdmSnhj?=
 =?utf-8?B?R1RxZTA0RWNOaWVuWXh0VXBRU2ZIYjJiSGxCcm1RYUNuenlNWUVNSHpGTVNQ?=
 =?utf-8?B?dGlRek5lRW0xRjROMkRVQ3pCSmovdHg3OERYOUg0b0dCdU5PYzBUbmwrUC8z?=
 =?utf-8?B?cm4wa1NHczRtbzJzcHVZR3lmM25ZU3NyRTFCVTl6eUsvRldPcmFCUm1LZWc5?=
 =?utf-8?B?SFNiMnU2T0YraHNtSjV5cC80K2gyb3ROa2RHUzRJQzRpajB2MnRGbmhiMEFP?=
 =?utf-8?B?RnVGVERhNDhHbmQwQm1ZZjZUOU1lVEZHWGJNZ1lFU05DaXNrUGJuQkRwL3hu?=
 =?utf-8?B?RUVHYkJrQ083K05wY1RxSzBYZUdKWkxmWEpkMS9tWnFPV0E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZVhPeDRmNERCUG5wYVFsTGhHMzR6WmRoTTdlc25hejFML3Z4bXIvZXY4TDRI?=
 =?utf-8?B?ditqbXBCUmN5a1k4VGdsUzRoK1NuNGI1dll5Ty9OZ2Q2ZEFWaGQxVUw1WDdp?=
 =?utf-8?B?Q2Q0VHd3eGZ6ejJRYy9LZjB1enYzK1lKNUwyL0hRSG5WUFVzVHpqWFNYTm93?=
 =?utf-8?B?STJCRGpEeHpOTCtPdnR0eCtHOEMvbnk3Y3NXQjJWNDNXdjVmZjVUQmJ0TFRi?=
 =?utf-8?B?L0tNTWR5bHdqNWNzbENqZU5hM21NRmhYMEVGUjMzbjRtY3VmUWFERzhUdDBo?=
 =?utf-8?B?RWQvNy9zNEJUQy9SNEZkeml5VzlEYjJoanFobDJDd0hGZ1VnNEZBcjRMZEZq?=
 =?utf-8?B?L1ZYMHBrZ08wbWVqSzB2aE45SC84eUN0SjVhdlR4SjRNOGhPZzJYTTF2Nzlr?=
 =?utf-8?B?SmVvMUlWR1pkazFQWEVpWFFIdHEwbkJXWm51NEE5ZlpVKzZpSHVPeVl3Z2Z2?=
 =?utf-8?B?SEIwUC9ZUThYd0Z3cE55ODY5NkF2Q2hLWUlMNTRueDZBb3E0QmphalJqOW1X?=
 =?utf-8?B?cnNXOERRZTBPNVYvQTFBSzFvaWdRa24vOXJpWmczSkNOcmJaQ2VQMjNlSHlM?=
 =?utf-8?B?U0dQcEs1eERKRWhHazFYMUVuY1A0Mi9PakU5bklCSFhzVHhWZkt0MGI3aVZy?=
 =?utf-8?B?K0RFTjdDWDBrMXhyeFhjUnQ1WGh6SmtiYzlQdTc4a09IaFVYQkgyUVhwdlNR?=
 =?utf-8?B?aU5OQy9rcHV5Vk1yU3ZXelV1MU9JSkFOYzMxTlAxV0J2ME0rQytOcDRPdHVO?=
 =?utf-8?B?OWNpRnU1RGxYYzhJOUIybFNjQ21VWUwxQk1lWnEwZWNaZ2tubmE2cFZTNzdI?=
 =?utf-8?B?SUhhQmJuK0FleFlRN1ErQ29pOEJ3Lyt1TncyaVhGdlJoQzVCdU96c2kvUGlC?=
 =?utf-8?B?Y3FmZWd6S0ZHemVuUEIwMzNDazI4VDA1cVFvV2lHT2xXcWZVdUtuSW9mZEd0?=
 =?utf-8?B?d3pXRHpKTnZTOTlnUnFLeHdWV25mKzUyRm5TNkdqNGg2TEI0ai8xbXU2aExy?=
 =?utf-8?B?SHJCbFdFYzBqSGR1Y1VBUUhYZ0k5b3dxUWhjaDArSnA0M1p1bEkvVmk3N2pq?=
 =?utf-8?B?Yzl0aUs1Y2Yra2NHQ09tU24ra056WStueXAwdGJnRTJyMWFZQXpWV0RETUFl?=
 =?utf-8?B?YzFwN1VWdzlJZGN0bXA0OWNwWFBsaFN4eVVXd1FGY0VNUDNSRGZWQnhLVkp0?=
 =?utf-8?B?VnJmalgyQ293SzdKK244NGNTYnBFcGVZUXFSUlN2RkJPbndTTW41R3lrK2VK?=
 =?utf-8?B?YjZIRlhsVlJmai81K3dDVkJNdnM4c3FHTGcvRmRjcURKWXNHZUVRQUMzZy90?=
 =?utf-8?B?SjVsVUZEeklGdDZXY3hmaERLL1IrV2g3MjBrSDlEaUxGUUY0bGx1SEFOamls?=
 =?utf-8?B?UXFNNWk5ZHlONm5HYTVyRXovdzYzV2V2QnhBS2JYVEtzY084VXZpRy9QSWcz?=
 =?utf-8?B?UzQ5NEhYbU81aUJRaEt5NUxTUWlUMC9IK2NFRjRJRXU2dDdTZDJROGxoTHJC?=
 =?utf-8?B?Zm00RVZaRU5CWGxQMTF1N1VHYmVuZjJEV2lmZ0w0K2hWL2g0UHR4ck0vZHQ3?=
 =?utf-8?B?Z0xNU2UrSTFDZ1d4aXVnbWF5UllzT28vOGFQck9tYnVXVkV3T3FXVkQ0RzM1?=
 =?utf-8?B?RzhLYXBuWlg3TlAzdXNSYXkzSFpZb2x5MWV6bDc0RDFGTkVoZ0tUSVg3S1My?=
 =?utf-8?B?WHRxUE9SWTFmdm1seDhVNWQ3YUhPbmdJMXQrVHVLSFg3QlZuOW5iZDh2QjBs?=
 =?utf-8?B?SnlGWUpuRTU1SC9uM2ZraDQzV05Xb05jYi9Lbm1nNUdmYkh5aDMzVGtNclNz?=
 =?utf-8?B?YWdSMU5LbkY1KzZMa1plUzU5Sjhyd2laV1prNDBWdlR1djNDaFNGRW1iUXQ3?=
 =?utf-8?B?dCtrbzFNaURwMWlsT2gxZUpQMkdwenpBNzltUWNOUTRoK0RSemVVUUoxR1dM?=
 =?utf-8?B?eXVUZkJ3RnBYS0NVOHhyb3Uxa2duN3pGdnNTK0V1VU04WG5nK0hpMzlHVXFw?=
 =?utf-8?B?NGIvNWdONHFqTVpNdWNXNXIzNGpMV05hdUNrZUxGNVhlV1VhRnR6a1VVZmRu?=
 =?utf-8?B?U0pWTFBJV0lpWlBaWjlFZE5lUnlXU1BLTWZqeno5bE9TYUhqQ2tLanZqdEc3?=
 =?utf-8?B?amZNTHJkdENEeWkxaEVxUVdXQ1JOYU93Z1RaQ3FuYlVFNTUxeUVOUDg2STZL?=
 =?utf-8?B?NHc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4026a9b0-146c-47b5-73e9-08dcc7bf9bf4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2024 00:14:54.8563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hqR1xsOWEk/17nqB6q1bBI5PIBRYDlC5KIH+awQ1MEd1J9bMiHmQfiH14eVgarMqL7czMIsfwmSJK/pt7tmPXOdOc8h/x4EG9MyiiAxgsho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7054
X-OriginatorOrg: intel.com

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFlvc3J5IEFobWVkIDx5b3Ny
eWFobWVkQGdvb2dsZS5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgQXVndXN0IDI4LCAyMDI0IDM6
MzQgUE0NCj4gVG86IFNyaWRoYXIsIEthbmNoYW5hIFAgPGthbmNoYW5hLnAuc3JpZGhhckBpbnRl
bC5jb20+DQo+IENjOiBOaGF0IFBoYW0gPG5waGFtY3NAZ21haWwuY29tPjsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IG1tQGt2YWNrLm9yZzsgaGFubmVzQGNtcHhjaGcu
b3JnOyByeWFuLnJvYmVydHNAYXJtLmNvbTsgSHVhbmcsIFlpbmcNCj4gPHlpbmcuaHVhbmdAaW50
ZWwuY29tPjsgMjFjbmJhb0BnbWFpbC5jb207IGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc7DQo+
IFpvdSwgTmFuaGFpIDxuYW5oYWkuem91QGludGVsLmNvbT47IEZlZ2hhbGksIFdhamRpIEsNCj4g
PHdhamRpLmsuZmVnaGFsaUBpbnRlbC5jb20+OyBHb3BhbCwgVmlub2RoIDx2aW5vZGguZ29wYWxA
aW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDAvNF0gbW06IFpTV0FQIHN3YXAt
b3V0IG9mIG1USFAgZm9saW9zDQo+IA0KPiBPbiBXZWQsIEF1ZyAyOCwgMjAyNCBhdCAxMTo1MOKA
r0FNIFNyaWRoYXIsIEthbmNoYW5hIFANCj4gPGthbmNoYW5hLnAuc3JpZGhhckBpbnRlbC5jb20+
IHdyb3RlOg0KPiA+DQo+ID4gSGkgWW9zcnksDQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBZb3NyeSBBaG1lZCA8eW9zcnlhaG1lZEBnb29nbGUuY29t
Pg0KPiA+ID4gU2VudDogV2VkbmVzZGF5LCBBdWd1c3QgMjgsIDIwMjQgMTI6NDQgQU0NCj4gPiA+
IFRvOiBTcmlkaGFyLCBLYW5jaGFuYSBQIDxrYW5jaGFuYS5wLnNyaWRoYXJAaW50ZWwuY29tPg0K
PiA+ID4gQ2M6IE5oYXQgUGhhbSA8bnBoYW1jc0BnbWFpbC5jb20+OyBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnOw0KPiBsaW51eC0NCj4gPiA+IG1tQGt2YWNrLm9yZzsgaGFubmVzQGNtcHhj
aGcub3JnOyByeWFuLnJvYmVydHNAYXJtLmNvbTsgSHVhbmcsDQo+IFlpbmcNCj4gPiA+IDx5aW5n
Lmh1YW5nQGludGVsLmNvbT47IDIxY25iYW9AZ21haWwuY29tOyBha3BtQGxpbnV4LQ0KPiBmb3Vu
ZGF0aW9uLm9yZzsNCj4gPiA+IFpvdSwgTmFuaGFpIDxuYW5oYWkuem91QGludGVsLmNvbT47IEZl
Z2hhbGksIFdhamRpIEsNCj4gPiA+IDx3YWpkaS5rLmZlZ2hhbGlAaW50ZWwuY29tPjsgR29wYWws
IFZpbm9kaCA8dmlub2RoLmdvcGFsQGludGVsLmNvbT4NCj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggdjQgMC80XSBtbTogWlNXQVAgc3dhcC1vdXQgb2YgbVRIUCBmb2xpb3MNCj4gPiA+DQo+ID4g
PiBbLi5dDQo+ID4gPiA+DQo+ID4gPiA+IFRoaXMgc2hvd3MgdGhhdCBpbiBhbGwgY2FzZXMsIHJl
Y2xhaW1faGlnaCgpIGlzIGNhbGxlZCBvbmx5IGZyb20gdGhlIHJldHVybg0KPiA+ID4gPiBwYXRo
IHRvIHVzZXIgbW9kZSBhZnRlciBoYW5kbGluZyBhIHBhZ2UtZmF1bHQuDQo+ID4gPg0KPiA+ID4g
SSBhbSBzb3JyeSBJIGhhdmVuJ3QgYmVlbiBrZWVwaW5nIHVwIHdpdGggdGhpcyB0aHJlYWQsIEkg
ZG9uJ3QgaGF2ZSBhDQo+ID4gPiBsb3Qgb2YgY2FwYWNpdHkgcmlnaHQgbm93Lg0KPiA+ID4NCj4g
PiA+IElmIG15IHVuZGVyc3RhbmRpbmcgaXMgY29ycmVjdCwgdGhlIHN1bW1hcnkgb2YgdGhlIHBy
b2JsZW0gd2UgYXJlDQo+ID4gPiBvYnNlcnZpbmcgaGVyZSBpcyB0aGF0IHdpdGggaGlnaCBjb25j
dXJyZW5jeSAoNzAgcHJvY2Vzc2VzKSwgd2UNCj4gPiA+IG9ic2VydmUgd29yc2Ugc3lzdGVtIHRp
bWUsIHdvcnNlIHRocm91Z2hwdXQsIGFuZCBoaWdoZXIgbWVtb3J5X2hpZ2gNCj4gPiA+IGV2ZW50
cyB3aXRoIHpzd2FwIHRoYW4gU1NEIHN3YXAuIFRoaXMgaXMgdHJ1ZSAod2l0aCB2YXJ5aW5nIGRl
Z3JlZXMpDQo+ID4gPiBmb3IgNEsgb3IgbVRIUCwgYW5kIHdpdGggb3Igd2l0aG91dCBjaGFyZ2lu
ZyB6c3dhcCBjb21wcmVzc2VkIG1lbW9yeS4NCj4gPiA+DQo+ID4gPiBEaWQgSSBnZXQgdGhhdCBy
aWdodD8NCj4gPg0KPiA+IFRoYW5rcyBmb3IgeW91ciByZXZpZXcgYW5kIGNvbW1lbnRzISBZZXMs
IHRoaXMgaXMgY29ycmVjdC4NCj4gPg0KPiA+ID4NCj4gPiA+IEkgc2F3IHlvdSBhbHNvIG1lbnRp
b25lZCB0aGF0IHJlY2xhaW0gbGF0ZW5jeSBpcyBkaXJlY3RseSBjb3JyZWxhdGVkDQo+ID4gPiB0
byBoaWdoZXIgbWVtb3J5X2hpZ2ggZXZlbnRzLg0KPiA+DQo+ID4gVGhhdCB3YXMgbXkgb2JzZXJ2
YXRpb24gYmFzZWQgb24gdGhlIHN3YXAtY29uc3RyYWluZWQgZXhwZXJpbWVudHMgd2l0aA0KPiA0
RyBTU0QuDQo+ID4gV2l0aCBhIGZhc3RlciBjb21wcmVzc29yLCB3ZSBhbGxvdyBhbGxvY2F0aW9u
cyB0byBwcm9jZWVkIHF1aWNrbHksIGFuZCBpZiB0aGUNCj4gcGFnZXMNCj4gPiBhcmUgbm90IGJl
aW5nIGZhdWx0ZWQgaW4sIHdlIG5lZWQgbW9yZSBzd2FwIHNsb3RzLiBUaGlzIGluY3JlYXNlcyB0
aGUNCj4gcHJvYmFiaWxpdHkgb2YNCj4gPiBydW5uaW5nIG91dCBvZiBzd2FwIHNsb3RzIHdpdGgg
dGhlIDRHIFNTRCBiYWNraW5nIGRldmljZSwgd2hpY2gsIGFzIHRoZSBkYXRhDQo+IGluIHY0DQo+
ID4gc2hvd3MsIGNhdXNlcyBtZW1jZ19zd2FwX2ZhaWwgZXZlbnRzLCB0aGF0IGRyaXZlIGZvbGlv
cyB0byBiZSByZXNpZGVudCBpbg0KPiBtZW1vcnkNCj4gPiAodHJpZ2dlcmluZyBtZW1jZ19oaWdo
IGJyZWFjaGVzIGFzIGFsbG9jYXRpb25zIHByb2NlZWQgZXZlbiB3aXRob3V0DQo+IHpzd2FwIGNn
cm91cA0KPiA+IGNoYXJnaW5nKS4NCj4gPg0KPiA+IFRoaW5ncyBjaGFuZ2Ugd2hlbiB0aGUgZXhw
ZXJpbWVudHMgYXJlIHJ1biBpbiBhIHNpdHVhdGlvbiB3aGVyZSB0aGVyZSBpcw0KPiBhYnVuZGFu
dA0KPiA+IHN3YXAgc3BhY2UgYW5kIHdoZW4gdGhlIGRlZmF1bHQgYmVoYXZpb3Igb2YgenN3YXAg
Y29tcHJlc3NlZCBkYXRhIGJlaW5nDQo+IGNoYXJnZWQNCj4gPiB0byB0aGUgY2dyb3VwIGlzIGVu
YWJsZWQsIGFzIGluIHRoZSBkYXRhIHdpdGggMTc2R2lCIFpSQU0gYXMgWlNXQVAncw0KPiBiYWNr
aW5nDQo+ID4gc3dhcGZpbGUgcG9zdGVkIGluIHY1LiBOb3csIHRoZSBjcml0aWNhbCBwYXRoIHRv
IHdvcmtsb2FkIHBlcmZvcm1hbmNlDQo+IGNoYW5nZXMgdG8NCj4gPiBjb25jdXJyZW50IHJlY2xh
aW1zIGluIHJlc3BvbnNlIHRvIG1lbWNnX2hpZ2ggZXZlbnRzIGR1ZSB0byBhbGxvY2F0aW9uDQo+
IGFuZCB6c3dhcA0KPiA+IHVzYWdlLiBXZSBzZWUgYSBsZXNzZXIgaW5jcmVhc2UgaW4gc3dhcG91
dCBhY3Rpdml0eSAoYXMgY29tcGFyZWQgdG8gdGhlDQo+IHN3YXAtY29uc3RyYWluZWQNCj4gPiBl
eHBlcmltZW50cyBpbiB2NCksIGFuZCBjb21wcmVzcyBsYXRlbmN5IHNlZW1zIHRvIGJlY29tZSB0
aGUgYm90dGxlbmVjay4NCj4gRWFjaA0KPiA+IGluZGl2aWR1YWwgcHJvY2VzcydzIHRocm91Z2hw
dXQvc3lzIHRpbWUgZGVncmFkZXMgbWFpbmx5IGFzIGEgZnVuY3Rpb24gb2YNCj4gY29tcHJlc3MN
Cj4gPiBsYXRlbmN5LiBBbnl3YXksIHRoZXNlIHdlcmUgc29tZSBvZiBteSBsZWFybmluZ3MgZnJv
bSB0aGVzZSBleHBlcmltZW50cy4NCj4gUGxlYXNlDQo+ID4gZG8gbGV0IG1lIGtub3cgaWYgdGhl
cmUgYXJlIG90aGVyIGluc2lnaHRzL2FuYWx5c2lzIEkgY291bGQgYmUgbWlzc2luZy4NCj4gPg0K
PiA+ID4NCj4gPiA+IElzIGl0IHBvc3NpYmxlIHRoYXQgd2l0aCBTU0Qgc3dhcCwgYmVjYXVzZSB3
ZSB3YWl0IGZvciBJTyBkdXJpbmcNCj4gPiA+IHJlY2xhaW0sIHRoaXMgZ2l2ZXMgYSBjaGFuY2Ug
Zm9yIG90aGVyIHByb2Nlc3NlcyB0byBhbGxvY2F0ZSBhbmQgZnJlZQ0KPiA+ID4gdGhlIG1lbW9y
eSB0aGV5IG5lZWQuIFdoaWxlIHdpdGggenN3YXAgYmVjYXVzZSBldmVyeXRoaW5nIGlzDQo+ID4g
PiBzeW5jaHJvbm91cywgYWxsIHByb2Nlc3NlcyBhcmUgdHJ5aW5nIHRvIGFsbG9jYXRlIHRoZWly
IG1lbW9yeSBhdCB0aGUNCj4gPiA+IHNhbWUgdGltZSByZXN1bHRpbmcgaW4gaGlnaGVyIHJlY2xh
aW0gcmF0ZXM/DQo+ID4gPg0KPiA+ID4gSU9XLCBtYXliZSB3aXRoIHpzd2FwIGFsbCB0aGUgcHJv
Y2Vzc2VzIHRyeSB0byBhbGxvY2F0ZSB0aGVpciBtZW1vcnkNCj4gPiA+IGF0IHRoZSBzYW1lIHRp
bWUsIHNvIHRoZSB0b3RhbCBhbW91bnQgb2YgbWVtb3J5IG5lZWRlZCBhdCBhbnkgZ2l2ZW4NCj4g
PiA+IGluc3RhbmNlIGlzIG11Y2ggaGlnaGVyIHRoYW4gbWVtb3J5LmhpZ2gsIHNvIHdlIGtlZXAg
cHJvZHVjaW5nDQo+ID4gPiBtZW1vcnlfaGlnaCBldmVudHMgYW5kIHJlY2xhaW1pbmcuIElmIDcw
IHByb2Nlc3NlcyBhbGwgcmVxdWlyZSAxRyBhdA0KPiA+ID4gdGhlIHNhbWUgdGltZSwgdGhlbiB3
ZSBuZWVkIDcwRyBvZiBtZW1vcnkgYXQgb25jZSwgd2Ugd2lsbCBrZWVwDQo+ID4gPiB0aHJhc2hp
bmcgcGFnZXMgaW4vb3V0IG9mIHpzd2FwLg0KPiA+ID4NCj4gPiA+IFdoaWxlIHdpdGggU1NEIHN3
YXAsIGR1ZSB0byB0aGUgd2FpdHMgaW1wb3NlZCBieSBJTywgdGhlIGFsbG9jYXRpb25zDQo+ID4g
PiBhcmUgbW9yZSBzcHJlYWQgb3V0IGFuZCBtb3JlIHNlcmlhbGl6ZWQsIGFuZCB0aGUgYW1vdW50
IG9mIG1lbW9yeQ0KPiA+ID4gbmVlZGVkIGF0IGFueSBnaXZlbiBpbnN0YW5jZSBpcyBsb3dlcjsg
cmVzdWx0aW5nIGluIGxlc3MgcmVjbGFpbQ0KPiA+ID4gYWN0aXZpdHkgYW5kIHVsdGltYXRlbHkg
ZmFzdGVyIG92ZXJhbGwgZXhlY3V0aW9uPw0KPiA+DQo+ID4gVGhpcyBpcyBhIHZlcnkgaW50ZXJl
c3RpbmcgaHlwb3RoZXNpcywgdGhhdCBpcyBhbG9uZyB0aGUgbGluZXMgb2YgdGhlDQo+ID4gInNs
b3dlciBjb21wcmVzc29yIiBlc3NlbnRpYWxseSBjYXVzaW5nIGFsbG9jYXRpb24gc3RhbGxzIChh
bmQgYnVmZmVyaW5nIHVzDQo+IGZyb20NCj4gPiB0aGUgc3dhcCBzbG90cyB1bmF2YWlsYWJpbGl0
eSBlZmZlY3QpIG9ic2VydmF0aW9uIEkgZ2F0aGVyZWQgZnJvbSB0aGUgNEcgU1NEDQo+ID4gZXhw
ZXJpbWVudHMuIEkgdGhpbmsgdGhpcyBpcyBhIHBvc3NpYmlsaXR5Lg0KPiA+DQo+ID4gPg0KPiA+
ID4gQ291bGQgeW91IHBsZWFzZSBkZXNjcmliZSB3aGF0IHRoZSBwcm9jZXNzZXMgYXJlIGRvaW5n
PyBBcmUgdGhleQ0KPiA+ID4gYWxsb2NhdGluZyBtZW1vcnkgYW5kIGhvbGRpbmcgb24gdG8gaXQs
IG9yIGltbWVkaWF0ZWx5IGZyZWVpbmcgaXQ/DQo+ID4NCj4gPiBJIGhhdmUgYmVlbiB1c2luZyB0
aGUgdm0tc2NhbGFiaWxpdHkgdXNlbWVtIHdvcmtsb2FkIGZvciB0aGVzZQ0KPiBleHBlcmltZW50
cy4NCj4gPiBUaGFua3MgWWluZyBmb3Igc3VnZ2VzdGluZyBJIHVzZSB0aGlzIHdvcmtsb2FkIQ0K
PiA+DQo+ID4gSSBhbSBydW5uaW5nIHVzZW1lbSB3aXRoIHRoZXNlIGNvbmZpZyBvcHRpb25zOiB1
c2VtZW0gLS1pbml0LXRpbWUgLXcgLU8gLQ0KPiBuIDcwIDFnLg0KPiA+IFRoaXMgZm9ya3MgNzAg
cHJvY2Vzc2VzLCBlYWNoIG9mIHdoaWNoIGRvZXMgdGhlIGZvbGxvd2luZzoNCj4gPg0KPiA+IDEp
IEFsbG9jYXRlcyAxRyBtbWFwIHZpcnR1YWwgbWVtb3J5IHdpdGggTUFQX0FOT05ZTU9VUywgcmVh
ZC93cml0ZQ0KPiBwZXJtaXNzaW9ucy4NCj4gPiAyKSBTdGVwcyB0aHJvdWdoIGFuZCBhY2Nlc3Nl
cyBlYWNoIDggYnl0ZXMgY2h1bmsgb2YgbWVtb3J5IGluIHRoZSBtbWFwLQ0KPiBlZCByZWdpb24s
IGFuZDoNCj4gPiAgICAgMi5hKSBXcml0ZXMgdGhlIGluZGV4IG9mIHRoYXQgY2h1bmsgdG8gdGhl
ICh1bnNpZ25lZCBsb25nICopIG1lbW9yeSBhdA0KPiB0aGF0IGluZGV4Lg0KPiA+IDMpIEdlbmVy
YXRlcyBzdGF0aXN0aWNzIG9uIHRocm91Z2hwdXQuDQo+ID4NCj4gPiBUaGVyZSBpcyBhbiAibXVu
bWFwKCkiIGFmdGVyIHN0ZXAgKDIuYSkgdGhhdCBJIGhhdmUgY29tbWVudGVkIG91dCBiZWNhdXNl
DQo+IEkgd2FudGVkIHRvDQo+ID4gc2VlIGhvdyBtdWNoIGNvbGQgbWVtb3J5IHJlc2lkZXMgaW4g
dGhlIHpzd2FwIHpwb29sIGFmdGVyIHRoZSB3b3JrbG9hZA0KPiBleGl0cy4gSW50ZXJlc3Rpbmds
eSwNCj4gPiB0aGlzIHdhcyAwIGZvciA2NEsgbVRIUCwgYnV0IG9mIHRoZSBvcmRlciBvZiBzZXZl
cmFsIGh1bmRyZWRzIG9mIE1CIGZvciAyTQ0KPiBUSFAuDQo+IA0KPiBEb2VzIHRoZSBwcm9jZXNz
IGV4aXQgaW1tZWRpYXRlbHkgYWZ0ZXIgc3RlcCAoMyk/IFRoZSBtZW1vcnkgd2lsbCBiZQ0KPiB1
bm1hcHBlZCBhbmQgZnJlZWQgb25jZSB0aGUgcHJvY2VzcyBleGl0cyBhbnl3YXksIHNvIHJlbW92
aW5nIGFuIHVubWFwDQo+IHRoYXQgaW1tZWRpYXRlbHkgcHJlY2VkZXMgdGhlIHByb2Nlc3MgZXhp
dGluZyBzaG91bGQgaGF2ZSBubyBlZmZlY3QuDQoNClllcywgeW91J3JlIHJpZ2h0Lg0KDQo+IA0K
PiBJIHdvbmRlciBob3cgdGhpcyBjaGFuZ2VzIGlmIHRoZSBwcm9jZXNzZXMgc2xlZXAgYW5kIGtl
ZXAgdGhlIG1lbW9yeQ0KPiBtYXBwZWQgZm9yIGEgd2hpbGUsIHRvIGZvcmNlIHRoZSBzaXR1YXRp
b24gd2hlcmUgYWxsIHRoZSBtZW1vcnkgaXMNCj4gbmVlZGVkIGF0IHRoZSBzYW1lIHRpbWUgb24g
U1NEIGFzIHdlbGwgYXMgenN3YXAuIFRoaXMgY291bGQgbWFrZSB0aGUNCj4gcGxheWluZyBmaWVs
ZCBtb3JlIGV2ZW4gYW5kIGZvcmNlIHRoZSBzYW1lIHRocmFzaGluZyB0byBoYXBwZW4gb24gU1NE
DQo+IGZvciBhIG1vcmUgZmFpciBjb21wYXJpc29uLg0KDQpHb29kIHBvaW50LiBJIGJlbGlldmUg
SSBzYXcgYW4gb3B0aW9uIGluIHVzZW1lbSB0aGF0IGNvdWxkIGZhY2lsaXRhdGUgdGhpcy4NCkkg
d2lsbCBpbnZlc3RpZ2F0ZS4NCg0KPiANCj4gSXQncyBub3QgYSBmaXgsIGlmIHZlcnkgZmFzdCBy
ZWNsYWltIHdpdGggenN3YXAgZW5kcyB1cCBjYXVzaW5nIG1vcmUNCj4gcHJvYmxlbXMgcGVyaGFw
cyB3ZSBuZWVkIHRvIHR3ZWFrIHRoZSB0aHJvdHRsaW5nIG9mIG1lbW9yeS5oaWdoIG9yDQo+IHNv
bWV0aGluZy4NCg0KU3VyZSwgdGhhdCBpcyBhIHBvc3NpYmlsaXR5LiBBbHRob3VnaCwgcHJvYWN0
aXZlIHJlY2xhaW0gbWlnaHQgbWl0aWdhdGUgdGhpcywNCmluIHdoaWNoIGNhc2UgdmVyeSBmYXN0
IHJlY2xhaW0gd2l0aCB6c3dhcCBtaWdodCBoZWxwLg0KDQpUaGFua3MsDQpLYW5jaGFuYQ0K

