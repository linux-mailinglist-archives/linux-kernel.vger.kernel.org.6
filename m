Return-Path: <linux-kernel+bounces-337812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33CD8984F4A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 02:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DF021F245F5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 00:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFF817FE;
	Wed, 25 Sep 2024 00:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XBvWAV/M"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CED360
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 00:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727222713; cv=fail; b=Qf3pC6AMjKKR9JXstJXUrnK/nxqRcVLdZpTu46d7ON2iNxOocQuWfWNdNKmwf9aRwl2TN2B01Gup9shHX8hASQy0L9BRatyf/w0DZ+bljoqZVC+AZfIZtqD63QDNodi3hb6yLHaI4KKhD4W3uJLfRgVUIk5NcHvG8nYzoGy12js=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727222713; c=relaxed/simple;
	bh=YIzsOhe/O0rvIgWqyQr/2fBrvJqGEapfmcLRLoSPBVU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Lhk5jPfOVkTQdK6rTqxUkfraou28Y54FFNuoP4kVTsd+9jZe2wL/kjdkTgf75T/sO9s61xlQbDLddeYQ1mBtLkO7TXgxB95M7EL9cUPLL4zFfl9jFzx9mxE7S9Gtc6pJILSm8d36iCaQt5XsNjcLhZkRQPbf5VbjFT22HDrvSqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XBvWAV/M; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727222712; x=1758758712;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YIzsOhe/O0rvIgWqyQr/2fBrvJqGEapfmcLRLoSPBVU=;
  b=XBvWAV/MM+82DDMmXoqQ2GBZDXvGkiihw/wAxyOit/F5aW6WU0nj0w+/
   2B+iLcSLsB5C3R87e1Tg6DGbJQnG5i8vspJ635E/bl1NkfsvA75a0u4x3
   sWvVI22TJyyD92ihbGyR4tVp7NqKlpqRE6N4u10I3bhnUwoh5Ch1LNuCs
   k/96vC6e3wmQ+YdEbKpAgSyh6LZ8EyKhKcd6tyxfhLlvHy0insl9tNO07
   lnWK0VW6aaQIHknrALC4OKvMLw1JWQK8g1brDv0lRqLrtJQowbDFDuvlL
   JFmKioyqKnN9acGa51NUC3VwDei+hgXd0ecl5pwKQxKhmltowhKbVh4mc
   w==;
X-CSE-ConnectionGUID: MUUOQoZzTg23wF+POIEE5Q==
X-CSE-MsgGUID: KjLJsg+jTwG+u7zbScSLkw==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="26067560"
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="26067560"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 17:05:11 -0700
X-CSE-ConnectionGUID: Ik1faMHESXWYtK9x9qaj/w==
X-CSE-MsgGUID: +w1yY2M7Tz2lMoaSUV/OjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="72045687"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Sep 2024 17:05:10 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 24 Sep 2024 17:05:10 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 24 Sep 2024 17:05:09 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 24 Sep 2024 17:05:09 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 24 Sep 2024 17:05:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tt6BYUcPQ8vXks1nzB/MT6gtar9n3VS+0SwaxCcYca65o0wDWqxfBYyrV0MjlYOga23OXqLj3R7ebvx6AZcm6ryn/R6cJgV7dY39POYebx05bBrCNTczrzIkxQnhyrxPLlRH4tt/P7UpGgGzGchtgC3yfJURdm6C+P/0UXY5jcC3SSLRNMJ+6L9jHf7k4Jm7LzEI/wo5+ZE4h4zGzGMbC/ctRktzU5BgwZJskg3BlTgmonU3ll/ijZAyOefwukAE1sXsGVuPS/VRaPDORwQFDQJj149T2dAjY4hqjtsFDCpx4QDA6eLmtg0J+fOniIuBRR9EBN5SqP3Jq8eXm62MYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YIzsOhe/O0rvIgWqyQr/2fBrvJqGEapfmcLRLoSPBVU=;
 b=RHdOj++CP7if/FTeLDIFrtrz4D8Obi4kSLTAe6w8mHm3H+0YJdVhpXOfHYE/LH68aknhYvg+WpcHWLCUI/fm6wnRgRQrRvDO3pOd6xa3Hq8dnotMj3MaYB0LBKceXkzu83nCKuxmjxIq2cTpUxmlGBD5+wYM5bJIcoRS58nZ0cbnEhZPUs/see4vvlYewZXm8cLK7tSnQSDjqTDOXuTOo1o/VU3RpKAK8xlL0e2eiASk4KZd7NhXDY5U/3pOh0ibJxQmAnS1zVX99jBV4yRlH0ifq6eahbLNaUnrFsv9J5si+0iNmZBlUinQVbzMIdIgTVYRCnL39VTREOBeQXvk/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by IA1PR11MB6348.namprd11.prod.outlook.com (2603:10b6:208:3af::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Wed, 25 Sep
 2024 00:05:06 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 00:05:06 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosryahmed@google.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "shakeel.butt@linux.dev"
	<shakeel.butt@linux.dev>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"Huang, Ying" <ying.huang@intel.com>, "21cnbao@gmail.com"
	<21cnbao@gmail.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"Zou, Nanhai" <nanhai.zou@intel.com>, "Feghali, Wajdi K"
	<wajdi.k.feghali@intel.com>, "Gopal, Vinodh" <vinodh.gopal@intel.com>,
	"joshua.hahnjy@gmail.com" <joshua.hahnjy@gmail.com>, "Sridhar, Kanchana P"
	<kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v7 6/8] mm: zswap: Support mTHP swapout in zswap_store().
Thread-Topic: [PATCH v7 6/8] mm: zswap: Support mTHP swapout in zswap_store().
Thread-Index: AQHbDh+C+ZYgIzdq4EuvViy0xt7aPLJnVm0AgAAUT4CAAA0SAIAAGg6AgAAL4YA=
Date: Wed, 25 Sep 2024 00:05:06 +0000
Message-ID: <SJ0PR11MB567838F5DC6E61EBA42DE79FC9692@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20240924011709.7037-1-kanchana.p.sridhar@intel.com>
 <20240924011709.7037-7-kanchana.p.sridhar@intel.com>
 <CAJD7tkbd=H+=wx0gnu8sh44hOmx7BE3G3oSxi7zt+o3HKJthkA@mail.gmail.com>
 <CAKEwX=O4PJmLRLog3NGzy+r6+1XTXs_r9Nxs73CJeFeN0pcr+Q@mail.gmail.com>
 <CAJD7tkYCXexrP_2xjXqFDpJALCgi84aA7wGOo=6mfuUSpMO-ng@mail.gmail.com>
 <CAKEwX=OsL10kywer+FkhBSQ3FK_-bkrQLqErZy-hGMWsRjmZrg@mail.gmail.com>
In-Reply-To: <CAKEwX=OsL10kywer+FkhBSQ3FK_-bkrQLqErZy-hGMWsRjmZrg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|IA1PR11MB6348:EE_
x-ms-office365-filtering-correlation-id: cc6ef9df-a74a-49bd-22fa-08dcdcf5b683
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?K1FkTWhURVNjTENzME9ad0xWUStKR1BuWnBWejd2R3c4ZDBnWnN1SDgrZDFw?=
 =?utf-8?B?ZXA5clZmQkJvd2FSTkppL2Z6cVZsYnZEZUZZSUFUcjJob2x1UDFzR2QwS0hF?=
 =?utf-8?B?M29TL0wvam50MWFpVkkxRkxjVHREYWV1dEIyK1JEemY0Zi8xZC9RSFlvYkh4?=
 =?utf-8?B?Mi9GeVNYSUpaSllNb1J0SzVtNnk2SFdDOCtwSVdZejlQWlQ3YkRia2U3QllV?=
 =?utf-8?B?K2xDRnh0SEZCejJqL2NDVTE0VmdqYm95eWFJTFFyb2V4bm9MVlIzSzBLR1N3?=
 =?utf-8?B?c3YrQk16aER2L2IyNmFTM2ZuZFlHVCs5SE9mQ2hKYVVoNGxOTFJROU9lbG5G?=
 =?utf-8?B?akNMWlZSdG9WektodHJLT2d5akVlKzBaVE45SFF5ODdvb0dld25sWmZoSnky?=
 =?utf-8?B?UnNXb0F5OVJRWjd1OGNLanBMSTFhNG1ZOUNZWXEranB2ZklOUkNtRkg1YmZ1?=
 =?utf-8?B?ZTA0N2xIS2ljQjl4bU00L04xejczQTF5bmdTVFd1UldPcks5aWYvSkpYRVZC?=
 =?utf-8?B?clhvbW04MzRDOWc2Y0NKbWVlL0luZzJRQ0NKcENCcndPajVEWlh1c3d0N2pF?=
 =?utf-8?B?L2hNek13aVBqWXJXOW1SQ3g0dVFjalJpSVUrRXdvbTdqdVRoWTdrU1pSSXVw?=
 =?utf-8?B?OU5jdHRVOHNFbHFLbmZYRitYVlI2U0kzL0RtamFSZGc2SXB4NjE5b2MycFho?=
 =?utf-8?B?MEpvTmh1ZlV5aEhTbzgrK2h2TkdJWW9RcjAxOGhENkJvWnBhejhRR0g4ZDJr?=
 =?utf-8?B?OGlnMU5JbnZjc21qb1pBRzNuMVByYWd0cEpIR0tiVFlNZm42V0wvVGZuVHZW?=
 =?utf-8?B?VXIvUHRVbmVKYlZWS3M4aHNzY1ZKZ0Y1aURwdG55UktIYUJCL29kR2gvaHhr?=
 =?utf-8?B?VTYvSFQ5VTBlMkN3RTdGcnc5UlVCZFNYNWlpS0R4VmlJWGxiTDZjdENEWTZa?=
 =?utf-8?B?VTcxTndiYTIzZ3JWdzVjZjR4ek1NNEt3VFN3ME5pSkZMQ1RoeTBuejhKK0pl?=
 =?utf-8?B?MldwblZiV1laQmphRWFRZmVNRks2SnhPZGdvK3M0MmhqZnkyQTJHRjBhR1Fx?=
 =?utf-8?B?QnM0VWFsMHhhMGhFQWNNU044dmc2UVNxUkZ0TWZsaVpYODBPUzYwU2FUNE5T?=
 =?utf-8?B?eGxlRVZLQ0E4NjNZMmZ2cmNsZVY5VXRtQjhrSWwwWXJKVFVOYlk2K3dpWjNC?=
 =?utf-8?B?ck5xc1hFMUFpYytUaDhScmFWcldlTHd5NWh5YlI5U094bTRjLzUyUU5SN1F3?=
 =?utf-8?B?WUk4L3RVbTE0WlVMc3pmbGU2RFdhYmpobFJRVG1nQnljMjU0eFlqK205V3Ix?=
 =?utf-8?B?Sm1qZmwvMXBwOGJuSnF4WVI3c0RPVnRDc2F5SEdvT2ltSHEyV1BsS0FPZlk2?=
 =?utf-8?B?WWhBa3pCZ05rZTBRQW5pbnExelFoTTlwY3FXK2dMeUxkUHFwU1BUbDRSSHRK?=
 =?utf-8?B?a05xLzA0S1dJM3pleDJhc0tCdTVHUk9jakpvUE8vQjdGY3VOdnNXUFJGL21P?=
 =?utf-8?B?b0p4cWRtZTdXUFhWbDdqclN6dUZlYTlocFBXd1A3TGd5N0ZyYjk0eHZIcXJD?=
 =?utf-8?B?WlFQNHVscHpIUUdGK3lEQ0VnSVJQSVUvZjhUUTBidnpMa3F6b1NhV3k0TUg0?=
 =?utf-8?B?dkdDN2NaQWwySHFrMm1WMXVRbzVtMDZ5aGh0elM0V3VJREpzOWlMcldxWUtD?=
 =?utf-8?B?Q3BXbG5Bczd6Z1Bob0ZEemdMV1Y2U0NWcGRzSk56OGNXY2s2d0NoTVptNTBD?=
 =?utf-8?B?Rkl4cFBhUnR4a2o0SzNBSkNmeE8yUVVESVZ6VEFHQUxMOGF5enRaaElRTklZ?=
 =?utf-8?B?NUJObFBDcXJ6c3Q1bGJUVW8rMDEzcUNDWEFrWXlpdkMvTjYySU8zK0FienZW?=
 =?utf-8?B?bkl2dTBGakpqYmdGNHZRVzZXNlowUHZZQ2lIRzMwQ1Y2c2c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d3E4b2JHSUl2b3VMSCtCanhqdXJYWUh1YXYzVGxBcHdpNGVBSlRvQkVBRVZI?=
 =?utf-8?B?cDkrZnRLU0lzVVpHa0xKU0ozYW5ZS21icGNOWWhUcStUOFRvSEpzcW0rQ0I0?=
 =?utf-8?B?S3R6NStQYnJIRlQ4MjMxSTUwYzZGOWZHV05tckdETGdwb3BaMzJoTjlRMGVq?=
 =?utf-8?B?QjRobjdab1doNisvRmV2ekdXU1hxR2hEWGY4bGRmOEtjb0hoTGhzTHZXcWhC?=
 =?utf-8?B?dWhGUFlzYXBvN0VnSEcxVDBXK0VDN2ZyYnNsSWVHeWd5QisydjI2azliZVFU?=
 =?utf-8?B?TDFJZytnYjlVLzhSemU1WG5ndmlJS0lVWFhPQmxLMjlwdVQ2RWVkTkpBeXd3?=
 =?utf-8?B?dGJxOTE5SUx4YUFxYklmMlZ2V1AvOVVKOGZSSXVZM1QvUUxRM012QVF6Q0E0?=
 =?utf-8?B?dEs3bDF0NFljaCtudjNXbkc0ME9jUWdMQkVZekNoWHFzUjdKZnRIb3dRalkv?=
 =?utf-8?B?UGFrS2IxajhHMW5QaTd5MHBldUViQlZsN3REekVlYzZNTW15dDVSbWgzckQx?=
 =?utf-8?B?cVFyWU5GcHRHYUQ0c0FwVDFlVXFnbU9EZ3k4dGlTZmQzQTB1cnU2c0wxNDR3?=
 =?utf-8?B?S0dqbmhkbm9veHIrQ0dlL0Q5QVFjdk15bWM0T0VvdTJOdkRoZlBpaEpWV0Ni?=
 =?utf-8?B?OFY1TWlvLzNSTTllcWNad05SS3RMR29ycEUxOUZDTUlkL2lLeExHcTEvYTdB?=
 =?utf-8?B?cG42YWVvcENpTW1SbCs3dXRiVC9OQTdvT0NicU1kMjRIUUF4b1VSZzhSSlM4?=
 =?utf-8?B?Ym8zekFkQXVVOHNUMVpPY0t0ZUFCcExLRytSVGRQRmtZN3VGc1NNcTJicjR5?=
 =?utf-8?B?N3U1dXJPVEliQmxYTXVycWlkZjBBdS83OUF1OHhtcnA2TXJTQnpuRlBqenkz?=
 =?utf-8?B?N0VJSDNBKzVOMEoyalI0ZHNMSmhDTXhtVm1vMDdTaUxIRUVUZ3EvaUZaVkdO?=
 =?utf-8?B?bkVwOWp6SklVUi9vZVB1N1Fvb3FjREJ4U3BIR1JDWlJEaVZQVXJmR2pLSWx3?=
 =?utf-8?B?a3N3SFUvOWxad2p1TjVRbG83L09RMzEwSTRNT1NzYVIxZXlLTjhLYU9TRTdI?=
 =?utf-8?B?enJzMW5UWWtta1ZUZU03bnM0c3NnVnBYb3U4QjdHS1pJTUJEL1pVVUFzeUFX?=
 =?utf-8?B?L3VwWXloOE8rSnBPc2tLVG9LdytMN1VXQ2gyVXFSV3ZSdjltT09tdnAyM2hB?=
 =?utf-8?B?VVo4TkpCRXo2YzFGeU1zTUxuY3l2b0VHQzFGT2JnTnJUblFCL2pEL3pib09z?=
 =?utf-8?B?aUNRRUxlalVKVDQxTjdGNWxQVzU1b1BQSzBJRWlsYXVKdnBEcS8zRExMeHBp?=
 =?utf-8?B?eFd3c2pWQmY4SUZBZEE2SGZEKzlmWUVUUDJOSDhJek9FWUp0OGdZV2wxNWEz?=
 =?utf-8?B?a2I1ZXNEOC9nQzE1bW15eUZmUXBYQjNmWi8yRVlTYXl1NHFwQ0VSdE4xbm4x?=
 =?utf-8?B?dUdxSGZSbHVVWlRsamxVOUhidFZGMWMzNVFwR2M2bWJtOHBySmpJWnpsZnQ2?=
 =?utf-8?B?eWpwWGRHem9iYytVcWFjNXhqY1BNUzhDcXBDUmd0WVJ2YXRyZHI4ZjhmalpP?=
 =?utf-8?B?aFV6RkplaG5SQWRLWHBSYktyY2lCbEhtbU5qaW16NS9yNWNQd3RyOEtHbEQ3?=
 =?utf-8?B?aEV5aXV1TFJXaWVNenN0c05TYURTUmtGbW42UWoyZTQ4czVuVXhMY29pSU5B?=
 =?utf-8?B?a08xMVpKRlBOcjlXNnRWc3pjbzk5RGxpTTRFYlNrbnRaWVYyTEFGTnNrQkx2?=
 =?utf-8?B?bVBpc1dyNmkwaFNEOGlxSFNja2VkZWRTVUxGdklJbERMZzN0NlNROHIwalpV?=
 =?utf-8?B?V1JQVWFvYzFDdFJCK0FOamtEQzEwZWJMWmQ4N3NwWWYxL1MrR0hTenV3dno0?=
 =?utf-8?B?ejkxMnlxYVhOM1BmL3h5U3lseGcvcUZoLy9VUGt6NlVYbm9LNnk4RFl1VkNk?=
 =?utf-8?B?ZWo2dFdDSXJnemdXRStwUjdiU2phODBMNTlDM2Fyclh1cHRxWFdxUkp4Nkxp?=
 =?utf-8?B?TmNxMTFHTHp4Smc0OGluOFExYTdkVnpuUTZaYXh2NGtDSTVuYm82OGZHZTho?=
 =?utf-8?B?VGlJQ2hrR2NMOVJUeUF5Y0QzUTMzWFdTdWtlTncwellvc0lEL09iL3JyQXhN?=
 =?utf-8?B?UGVhakNzK09mN1hPcEFQbkZSYzcvRDNjbkE1T1ZYNVFqNmxnNGovN1ByVWlF?=
 =?utf-8?B?dmc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cc6ef9df-a74a-49bd-22fa-08dcdcf5b683
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2024 00:05:06.6562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gwzmbMz9cc0kFRm+PDnS+GYWqCog0LwFz/CSzXji+yqL7nZhbtFnnUPKFRBxM0qHR1KMuUCBXiJvA11/c99qVir/UcVjbpoHScf+Bm9zhi0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6348
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOaGF0IFBoYW0gPG5waGFtY3NA
Z21haWwuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBTZXB0ZW1iZXIgMjQsIDIwMjQgNDoxMSBQTQ0K
PiBUbzogWW9zcnkgQWhtZWQgPHlvc3J5YWhtZWRAZ29vZ2xlLmNvbT4NCj4gQ2M6IFNyaWRoYXIs
IEthbmNoYW5hIFAgPGthbmNoYW5hLnAuc3JpZGhhckBpbnRlbC5jb20+OyBsaW51eC0NCj4ga2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtbW1Aa3ZhY2sub3JnOyBoYW5uZXNAY21weGNoZy5v
cmc7DQo+IGNoZW5nbWluZy56aG91QGxpbnV4LmRldjsgdXNhbWFhcmlmNjQyQGdtYWlsLmNvbTsN
Cj4gc2hha2VlbC5idXR0QGxpbnV4LmRldjsgcnlhbi5yb2JlcnRzQGFybS5jb207IEh1YW5nLCBZ
aW5nDQo+IDx5aW5nLmh1YW5nQGludGVsLmNvbT47IDIxY25iYW9AZ21haWwuY29tOyBha3BtQGxp
bnV4LWZvdW5kYXRpb24ub3JnOw0KPiBab3UsIE5hbmhhaSA8bmFuaGFpLnpvdUBpbnRlbC5jb20+
OyBGZWdoYWxpLCBXYWpkaSBLDQo+IDx3YWpkaS5rLmZlZ2hhbGlAaW50ZWwuY29tPjsgR29wYWws
IFZpbm9kaCA8dmlub2RoLmdvcGFsQGludGVsLmNvbT47DQo+IGpvc2h1YS5oYWhuanlAZ21haWwu
Y29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjcgNi84XSBtbTogenN3YXA6IFN1cHBvcnQgbVRI
UCBzd2Fwb3V0IGluDQo+IHpzd2FwX3N0b3JlKCkuDQo+IA0KPiBPbiBUdWUsIFNlcCAyNCwgMjAy
NCBhdCAyOjM44oCvUE0gWW9zcnkgQWhtZWQgPHlvc3J5YWhtZWRAZ29vZ2xlLmNvbT4NCj4gd3Jv
dGU6DQo+ID4NCj4gPg0KPiA+IFdlIGNhbiBhbHNvIGRvIHdoYXQgd2UgZGlzY3Vzc2VkIGJlZm9y
ZSBhYm91dCBkb3VibGUgY2hhcmdpbmcuIFRoZQ0KPiA+IHBhZ2VzIHRoYXQgYXJlIGJlaW5nIHJl
Y2xhaW1lZCBhcmUgYWxyZWFkeSBjaGFyZ2VkLCBzbyB0ZWNobmljYWxseSB3ZQ0KPiA+IGRvbid0
IG5lZWQgdG8gY2hhcmdlIHRoZW0gYWdhaW4uIFdlIGNhbiB1bmNoYXJnZSB0aGUgZGlmZmVyZW5j
ZQ0KPiA+IGJldHdlZW4gY29tcHJlc3NlZCBhbmQgdW5jb21wcmVzc2VkIHNpemVzIGFmdGVyIGNv
bXByZXNzaW9uIGFuZCBjYWxsDQo+ID4gaXQgYSBkYXkuIFRoaXMgZml4ZXMgdGhlIGxpbWl0IGNo
ZWNraW5nIGFuZCB0aGUgZG91YmxlIGNoYXJnaW5nIGluIG9uZQ0KPiA+IGdvLg0KPiA+IEkgYW0g
YSBsaXR0bGUgYml0IG5lcnZvdXMgdGhvdWdoIGFib3V0IHpzd2FwIHVuY2hhcmluZyB0aGUgcGFn
ZXMgZnJvbQ0KPiA+IHVuZGVyIHJlY2xhaW0sIHRoZXJlIGFyZSBsaWtlbHkgZnVydGhlciBhY2Nl
c3NlcyBvZiB0aGUgcGFnZSBtZW1jZw0KPiA+IGFmdGVyIHpzd2FwLiBNYXliZSB3ZSBjYW4gcGx1
bWIgdGhlIGluZm8gYmFjayB0byByZWNsYWltIG9yIHNldCBhIGZsYWcNCj4gPiBvbiB0aGUgcGFn
ZSB0byBhdm9pZCB1bmNoYXJnaW5nIGl0IHdoZW4gaXQncyBmcmVlZC4NCj4gDQo+IEhtbSB0aGlz
IGlzIGp1c3QgZm9yIG1lbW9yeSB1c2FnZSBjaGFyZ2luZywgbm8/IFRoZSBwcm9ibGVtIGhlcmUg
aXMNCj4gdGhlIHpzd2FwIHVzYWdlICh6c3dhcC5jdXJyZW50KSwgYW5kIGl0cyByZWxhdGlvbiB0
byB0aGUgbGltaXQuDQo+IA0KPiBPbmUgdGhpbmcgd2UgY2FuIGRvIGlzIGNoZWNrIHRoZSB6c3dh
cCB1c2FnZSBhZ2FpbnN0IHRoZSBsaW1pdCBmb3INCj4gZXZlcnkgc3VicGFnZSwgYnV0IHRoYXQn
cyBsaWtlbHkgZXhwZW5zaXZlLi4uPw0KDQpUaGlzIGlzIHRoZSBhcHByb2FjaCBjdXJyZW50bHkg
aW1wbGVtZW50ZWQgaW4gdjcuDQpEYXRhIGdhdGhlcmVkIGRvZXNu4oCZdCBpbmRpY2F0ZSBhIHBl
cmZvcm1hbmNlIGlzc3VlIHdpdGggdGhpcw0Kc3BlY2lmaWMgd29ya2xvYWQgaW4gdGhlIHR3byBz
Y2VuYXJpb3MgdmFsaWRhdGVkLCBuYW1lbHksDQp6c3dhcC00SyB2cy4genN3YXAtbVRIUCBhbmQg
U1NELW1USFAgdnMuIHpzd2FwLW1USFAgKHdlIG9ubHkNCnNlZSBwZXJmb3JtYW5jZSBnYWlucyB3
aXRoIGV4cGxhaW5hYmxlIHN5cyB0aW1lIGluY3JlYXNlKS4NCg0KT2YgY291cnNlLCB0aGUgZXhp
c3RpbmcgaW1wbGVtZW50YXRpb24gY291bGQgYmUgYSBiYXNlbGluZSBmb3INCnZhbGlkYXRpbmcg
cGVyZm9ybWFuY2Ugb2Ygb3RoZXIgYXBwcm9hY2hlcywgZS5nLiwgY2hlY2tpbmcgenN3YXAgdXNh
Z2UNCnBlciBtVEhQLiBIb3dldmVyLCB0aGVzZSBvdGhlciBhcHByb2FjaGVzIHdvdWxkIGFsc28g
bmVlZCB0byBiZQ0KZXZhbHVhdGVkIGZvciBtb3JlIGdsb2JhbCBtdWx0aS1pbnN0YW5jZSBpbXBs
aWNhdGlvbnMgYXMgZmFyIGFzIGFsbA0KcHJvY2Vzc2VzIGJlaW5nIGFibGUgdG8gbWFrZSBwcm9n
cmVzcy4gDQoNCj4gDQo+IFdpdGggdGhlIG5ldyBhdG9taWMgY291bnRlcnMgSm9zaHVhIGlzIHdv
cmtpbmcgb24sIHdlIGNhbg0KPiBjaGVjay1hbmQtY2hhcmdlIGF0IHRoZSBzYW1lIHRpbWUsIGFm
dGVyIHdlIGhhdmUgY29tcHJlc3NlZCB0aGUgd2hvbGUNCj4gbGFyZ2UgZm9saW8sIGxpa2UgdGhp
czoNCj4gDQo+IGZvciAobWVtY2cgPSBvcmlnaW5hbF9tZW1jZzsgIW1lbV9jZ3JvdXBfaXNfcm9v
dChtZW1jZyk7DQo+ICAgICAgbWVtY2cgPSBwYXJlbnRfbWVtX2Nncm91cChtZW1jZykpOw0KPiAg
ICAgIG9sZF91c2FnZSA9IGF0b21pY19yZWFkKCZtZW1jZy0+enN3YXApOw0KPiANCj4gICAgICBk
byB7DQo+ICAgICAgICAgbmV3X3VzYWdlID0gb2xkX3VzYWdlICsgc2l6ZTsNCj4gICAgICAgICBp
ZiAobmV3X3VzYWdlID4gbGltaXQpIHsNCj4gICAgICAgICAgICAvKiB1bmRvIGNoYXJnaW5nIG9m
IGRlc2NlbmRhbnRzLCB0aGVuIHJldHVybiBmYWxzZSAqLw0KPiAgICAgICAgIH0NCj4gICAgICAg
fSB3aGlsZSAoIWF0b21pY190cnlfY21weGNoZygmbWVtY2ctPnpzd2FwLCBvbGRfdXNhZ2UsIG5l
d191c2FnZSkpDQo+IH0NCj4gDQo+IEJ1dCBJIGRvbid0IGtub3cgd2hhdCB3ZSBjYW4gZG8gaW4g
dGhlIGN1cnJlbnQgZGVzaWduLiBJIGdhdmUgaXQgc29tZQ0KPiBtb3JlIHRob3VnaHQsIGFuZCBl
dmVuIGlmIHdlIG9ubHkgY2hlY2sgYWZ0ZXIgd2Uga25vdyB0aGUgc2l6ZSwgd2UgY2FuDQo+IHN0
aWxsIHBvdGVudGlhbGx5IG92ZXJzaG9vdCB0aGUgbGltaXQgOigNCg0KSSBhZ3JlZS4gTW9yZW92
ZXIsIHRoZXNlIGNoZWNrcyBiYXNlZCBvbiBlc3RpbWF0ZWQgcmF0aW8gb3IgY29tcHJlc3NlZCBz
aXplDQpjb3VsZCBhbHNvIGFkZCBvdmVyaGVhZCBpbiB0aGUgbm9ybWFsIGNhc2Ugd2hlcmUgd2Ug
YXJlIG5vdCBuZWFyIHRoZSB1c2FnZQ0KbGltaXRzLg0KDQo=

