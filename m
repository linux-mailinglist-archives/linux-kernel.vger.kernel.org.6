Return-Path: <linux-kernel+bounces-306034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBE2963844
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 04:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2C8B1C221C7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 02:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566CB4503A;
	Thu, 29 Aug 2024 02:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZdhAOHIn"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B55743ADE
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 02:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724899096; cv=fail; b=P65kY7ESyEKYBjQ7T5BahVwArPWon8oCJYiNYu38e9+kqFbwyDxkKtg0DSKlvJctEhRAH2tcS1621eS98hgD3JoP5sSMos1AXHfcHg95ESWBX7n/l/d/L7VM3kHonU8xBZwPSWNm3hmSYlJT+uV0VJ193wLWYkums9P1rvPQK4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724899096; c=relaxed/simple;
	bh=t9Nhxf/yMtFr/5O4bWxYGs3aIm/YAjqYRiS06WYKS5Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oWwDHM4kH0HrvE6+092Vejd5qi2BTD74baSfuiUfc34kgbf/w/avd95aHqr+rXvQnZ9zHpf9K/hYIp0ZxcNxAhoSLkpk9ojfm9NQXWALdgxGhi2rk5vj6PE/luG5m/W0tWrk1XwCkagslIUdQwA6mewogi0CJejdKtMjIguayI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZdhAOHIn; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724899094; x=1756435094;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=t9Nhxf/yMtFr/5O4bWxYGs3aIm/YAjqYRiS06WYKS5Y=;
  b=ZdhAOHInpycV8LI5DiD0xTGCnGRzTHodRnbwA9X0hWc/yZd5R4V7sQMm
   7Q6xg8Ef2ghfK4QgF8hbmqKp6T/71mmTvZ+rnLCGzqwO84Pp01qm437Y/
   Pdk1kvfSIaR4IhL1tVG4P8pOF8Yp9edrOL1yrXzDjmfFYApmm+iQMtbpM
   8odd7d1kPRu6mSrMDMrhG1Je7cSNcppNkNS0DXO8PkRBDT8DnlqKs847N
   S5h3soBdVoHpozo7fDofxBnup00sybWCVyw2r8pGhu4ppHfLA/N/y/iyx
   RqXL8dAh04LINHeBTsSllx990/U1QcGodckPJrK/ZcSVHhixJwE+vxzew
   g==;
X-CSE-ConnectionGUID: 2fQeFgw1RCK9KErqOCiINg==
X-CSE-MsgGUID: cMTHuXRtRBujZqnx/eQ7WQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="34037199"
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="34037199"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 19:38:13 -0700
X-CSE-ConnectionGUID: c0ZlVmoeQAC7UoX1JWQw0A==
X-CSE-MsgGUID: dC5r87sNTkubHI3kBB3L+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="67573907"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Aug 2024 19:38:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 28 Aug 2024 19:38:12 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 28 Aug 2024 19:38:12 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 28 Aug 2024 19:38:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AlFvzpWzSqhvJdQVwJvuOn0VqSMno2k5RJZ1zzhb/fe0OTdjWWtVT07wHwJhwVlTMrYNK7L8W2s4/MrOdMmD6Kkrx2WslV1QIYzIwh1j58IS4dIqcyMR87bHJYUoyV7CfeHwQo3vj5JCSJw2TSAJQHun6V7mRNKMdtK8R69/2uGSeOBEdovuDAhlsF+2dema8JGF8RiHQXRccWJ2O07P7tHZrGjmKiMuPwcPR3wvCWvuj1iCi9kzPMvAkxtKtne7T92JNF0efbGU8Ot7weEYEvyL9UGEbw5TsePjFKV9CxSCI1w2dp2TG4CMH0ETGXiRL6pkFHHMyY6QdKAyNh+7FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t9Nhxf/yMtFr/5O4bWxYGs3aIm/YAjqYRiS06WYKS5Y=;
 b=JDyEJI6UhMhaNSkOI/37In6D0w9e1Ptc+ioxhRg1aubownQhonfK06UtLJNNDUz/hzcD6H/12e5FYTBjqXAX+wZ3XnoPdboW8XX5c4j1BSq9LeabCVF+nDdLQ71aU4TNCCltX5Epqfk5HdxE95wixwlhe9sQTN4q+vw3OFUiai1HkMJTswRRXBbXPeGxhneuCpdLPkrWyBCK1ZNMbxZkdVptDSkgWZVczCpu4/dZlVxNA8dA6AOxPvfh6QR9OFiu6WIqv3xKiFt0hmkx8gGyj5rUwu3LzEqxgUp/5Y0oLC9OFsKbnNpUMsg7hrgKTTlJK7ydr7W+gigXiY/SY5GLYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by PH0PR11MB7421.namprd11.prod.outlook.com (2603:10b6:510:281::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Thu, 29 Aug
 2024 02:38:04 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%5]) with mapi id 15.20.7875.019; Thu, 29 Aug 2024
 02:38:04 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Barry Song <21cnbao@gmail.com>
CC: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
	"chrisl@kernel.org" <chrisl@kernel.org>, "david@redhat.com"
	<david@redhat.com>, "hanchuanhua@oppo.com" <hanchuanhua@oppo.com>,
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>, "hch@infradead.org"
	<hch@infradead.org>, "hughd@google.com" <hughd@google.com>,
	"kaleshsingh@google.com" <kaleshsingh@google.com>, "kasong@tencent.com"
	<kasong@tencent.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"mhocko@suse.com" <mhocko@suse.com>, "minchan@kernel.org"
	<minchan@kernel.org>, "nphamcs@gmail.com" <nphamcs@gmail.com>,
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, "ryncsn@gmail.com"
	<ryncsn@gmail.com>, "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
	"shakeel.butt@linux.dev" <shakeel.butt@linux.dev>, "shy828301@gmail.com"
	<shy828301@gmail.com>, "surenb@google.com" <surenb@google.com>,
	"v-songbaohua@oppo.com" <v-songbaohua@oppo.com>, "willy@infradead.org"
	<willy@infradead.org>, "xiang@kernel.org" <xiang@kernel.org>, "Huang, Ying"
	<ying.huang@intel.com>, "yosryahmed@google.com" <yosryahmed@google.com>,
	"zhengtangquan@oppo.com" <zhengtangquan@oppo.com>, "Feghali, Wajdi K"
	<wajdi.k.feghali@intel.com>, "Gopal, Vinodh" <vinodh.gopal@intel.com>,
	"Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v7 2/2] mm: support large folios swap-in for sync io
 devices
Thread-Topic: [PATCH v7 2/2] mm: support large folios swap-in for sync io
 devices
Thread-Index: AQHa+a7+IWOqCEHZhk2PIqOfxlfL0LI9gegAgAAC3EA=
Date: Thu, 29 Aug 2024 02:38:04 +0000
Message-ID: <SJ0PR11MB5678FC506E95506EF883EB71C9962@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <CAGsJ_4wGK6pu+KNhYjpWgydp6DyjH5tE=9+mje3UyrXdFJOuNw@mail.gmail.com>
 <20240829010103.7705-1-kanchana.p.sridhar@intel.com>
 <CAGsJ_4xLCknyaWk1a5RZ9h77QkamBxKi6HbjVhCbXPS9rm0WZg@mail.gmail.com>
In-Reply-To: <CAGsJ_4xLCknyaWk1a5RZ9h77QkamBxKi6HbjVhCbXPS9rm0WZg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|PH0PR11MB7421:EE_
x-ms-office365-filtering-correlation-id: 07203e82-f405-4179-fee8-08dcc7d39bd4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Yk9ZaDA4QXpQQkRQb1dRcFhacmlaRGpJY3AveDQ0UzlGUExRa04rV2syS3RW?=
 =?utf-8?B?aDJtbnluelNsczBQUXdEYjlBZVoyVzI2NFlCbnEyMjF4TlRtZHhBeHgxY2gz?=
 =?utf-8?B?Z3B4bEVtVUhINUhILzR5Qk0xOUROT2ZqN2srUnJJSndKU3ExRkRNRFdjMDZm?=
 =?utf-8?B?ZnlyK1RDYnovYUhNSjV6OW1XeUFlZzJCWTZxRkZtRmxHMGQ3ZTB3MGFhVkls?=
 =?utf-8?B?SmhUTDg2RGlpRHJ3cGQyWFZwNHV6MFJiTUdXNjFYcDQ2MXVHOWZySVdYSTdV?=
 =?utf-8?B?U2prS2lXUTZXRVM4MkU2WDdWb2Zsb2V2L2RIMGJFVXFaWGZhdng4cnhCZWV5?=
 =?utf-8?B?dXhxQTE1cThJbnBScjcwVm1ZYlNqdEhsTldhek9FNEl1OUJqNVpRUXJPTkgy?=
 =?utf-8?B?aWFzanIrVlEwLy9iRVZVb293WHByVlZ3OWxSYWt4S3cwbzNhc2VyWHJ6NjNh?=
 =?utf-8?B?T2sybkN1SkpFQjY1dXd0MTFWV2Y4aExIMTVEdXFtcmpyeks2dGRvWTlwT2pw?=
 =?utf-8?B?eWtwdkRneGRoeVdGZWUvdFhpQjdMRDZoWkJEMVp0b01RVzJQalZQL1VqN09p?=
 =?utf-8?B?NjFxWTFaNjZ0TGNrYkxWWHRSb1pZVTN1eXhvNDBVUHFjVWZyOWZ2OHNXNG5J?=
 =?utf-8?B?eC9tQVBnK3BJSXVtRGJZMTBlZ2lQUG9penRYcktERGJucnYwbTdqRWFVcWh6?=
 =?utf-8?B?SE01NmlFQnhOTmMxNGRha242a3Y5Umd1eWM5N0c2ejZEaGFIekd6TExUeExn?=
 =?utf-8?B?TWZUVkRLeW16U1BjbjBZMHZwUTRtWmxuM3R5OGVwSm1Qd0M2MGI3TXJ3UUNW?=
 =?utf-8?B?aTVLWTliSGltZkVSYXJXZlczbkZtQ3VUWUNDVEhrRzlXcjd5SzAxblgrTmZi?=
 =?utf-8?B?WGZPSkNUeFczZE5rRWswQng3Z2oyR1lubjh5Q2JPZjdkZVRBNi9oUzQvVkN3?=
 =?utf-8?B?bE1sQVh3Um4vNzlLOWtQdTJ2bnQwWnpBb3MyL3BvQ0RNcmtzMG1mYTZDcUs5?=
 =?utf-8?B?RjBzRi9qRHF0RHhTclNKeXgyZ21TOHR0RFVFRTVIV3V6R3cvZ2N5cUtXUGJ0?=
 =?utf-8?B?ZXNHa3c0dC96ZTFGa2cyRjdjbENTRHJIcG0rR29UQ1h1MmdtL1Jzck8xdis4?=
 =?utf-8?B?cEZseWV0SWloMUFqTkhoNEd5MkNISFU5MkQ1Znl0dWRLbHZEQXhCVDFtZS91?=
 =?utf-8?B?SW5iazFUdVQ1eFRYWWZoMlNuN2JPR1ZYbGVWN3lOZVRYdEJISDYrS2FCdWZj?=
 =?utf-8?B?dkJ5UXNmYnpCdlRlVFNGQU5jWFF3TUwxbVY2TUI3eDRhaDZlcjN1MlhsRTJL?=
 =?utf-8?B?WkM0MFdXUWFRSWpLMVVaY0x4UWUxVW51QnpkeDhkVXVDekVVb0wrNW8rOGV4?=
 =?utf-8?B?Vk1vT2lXU3MvTUJERXp6Z0pja24zYzBYSkgybFlsTmljUSswM3pWM0FmR1FY?=
 =?utf-8?B?MWFub3BFN1VjZ1NaU0dxOS9EeGwyMTVaMXpsMXhIcWF2cWdxbkVCcVI4S002?=
 =?utf-8?B?Y3BVSTZ2UDBwZHZYTU0zaXB3cnpvc0hTSHFhaXQxNy9oKzdLdkRFQ2VFc0Mr?=
 =?utf-8?B?MU11aEhRQ2JmZGN6WkhQbHFwUksvdU5YaGlxYzdYZkRtWHY0enNBNU9BZVly?=
 =?utf-8?B?elJqcm81dC93UUNYTlNueG5yUTlpc0haN29sRXdHUGV0WmZ1WVRFOXM4Wllt?=
 =?utf-8?B?SEx5dnl6UGRiSjNYV0dEdnozRXZNUlVrb1J1blVHQSswbVdsK04zckg0TnZW?=
 =?utf-8?B?Ym90c1FzdXZzbUJrMzJ1OVQyMWt0Qkl6S0hXaDZrOHlDeHdwR0kzTzlVdWZD?=
 =?utf-8?B?VGRaaVdkS2kzNnYxM0k1Zz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y3o3Snk5UDBiSFZkSEgzbnhIWW5jSDQ0aXI3ZFVWRGE1cDk3aTRwZnp0dnFQ?=
 =?utf-8?B?TldSSWdQZWkrWVJZMVgxQUp1WlRsVThpQzg5bndaUDJJT05neWJhMkVzNUcy?=
 =?utf-8?B?ZmhHZllvRmtYT1A2Zis2VXZTM3ZWNEFKQU5IcjI4Y2RCZjRQcDQ1ckZXaVh0?=
 =?utf-8?B?OXpaRk1ORmVCN0FwQ0VtWXJPY2piUVFxTmwxQURTeGVrZXpIczZLRFozbzM2?=
 =?utf-8?B?aGxHOXE3VkdtZmhSaTJPTXRrZU5ESlc4d0VrenJpYXQyRVRSY3hIRlFXMDFm?=
 =?utf-8?B?SWRGWUt3YXJpbnpUNG53RXNkSS9hTzZ3dHUzU0w2VkZQR2JLeDZJYW1rbDZm?=
 =?utf-8?B?Y0sybEVZdkV1WWtLeFBjeFMrYXVCN01vN0twRVdxZTFJREJKTmxSQzNWT2RX?=
 =?utf-8?B?RHhKV1N5ZzUxNXNyanBWUjk2c3I3R0NjY1BTbmpTcGY1cDhhb1UzVXVLeG4x?=
 =?utf-8?B?L2dkT0pmRUV3T04vUng2RFNNenIwTEF6VXhkVE92UC9COEVTbms4cFhLcmd6?=
 =?utf-8?B?LytUNE1YbTRzNTdqN3J2dG9jQ1hMbUoreEFYMkh1d0F1UGJrNWFRUWYyYmpY?=
 =?utf-8?B?NzJiVVRYTnN4QkZjdHNodTNtKzBFTU9xQmFKQXZMMjN5ajNIendVWEtuTG1Y?=
 =?utf-8?B?NVFRVFNLVks0YXJHM3d6R2R2NzF6endSeC92OXpEbUNmRVQxZ0R2MVhodlIx?=
 =?utf-8?B?Z3N0OXdzVk5HVy8rUnVQWWFHdzgyMWhXMFF0L3U5U2FROGN6T3ZLVzNTdUpq?=
 =?utf-8?B?MkQ5UnlQYkVWQU9vamd5ZjlnMFZCNGxYNnlkYmx2OUh5RmZXQnV5MEVVYnFL?=
 =?utf-8?B?T3JUdXFoeDZId043UWFrTE1Db21CWkVWOVprdFZrblBTUExJdldyYVhScFhR?=
 =?utf-8?B?TWcvRzJ4RVAzTU5IK0ZYelRPN3UvTG9TdElSWURmUlF1Qmp0VFNQeHJGUkhx?=
 =?utf-8?B?aWFIbS9wbWpRbE54OTBQby9SOUNqc0xncjhHbFRsWjBKRisxMkx3cWliYjlI?=
 =?utf-8?B?MVBVVEt3OGVma1BLa0VkdlRHVndkYkxQblROak5iTUNkaVF4WWRJVytFaHdK?=
 =?utf-8?B?Qm9YcStMSFRZMWpGcnFuYm95ZDBKMWZvaTRCejMvYlVTYm1ocUxMQzF4YXdz?=
 =?utf-8?B?alFLRUd2RGxYVWZ5dk40TWhVc0ZWMzhUUWVPTEVvenJ0WEF0bENmZmxDQWhZ?=
 =?utf-8?B?TnBiWXNzcE00SzZJUGhrcnF6dXhXYndpaTVraDlySWNEUys4Qm41RWxPSHlF?=
 =?utf-8?B?cGZ4dlVlYUY5Zy9sUjJ1Qks0M1gyUElWNWlsYk0zZEt5MUtSNEIxOUVoYW9O?=
 =?utf-8?B?dk92K3FKVUNXWWg5anpObzE0UnhSTXdZM05rdEpQVkNleWtFSXI5TCtWekUy?=
 =?utf-8?B?UncrQjNIa1VUU3E4Zm42MENTaWU2aHVpZmZ1TE9EYTBxa1AyOFcvdUdrQXdn?=
 =?utf-8?B?U0UxOUF5ZHpSSCt1OWZBTGxCTy9SdXV6c0txMDNXb3hwMDNJb2ExdzIvVktD?=
 =?utf-8?B?aTJkc09idldFZ29RcHJiaWtaNWRvazR6TG9TTzJtZk9PYWsvb0pPaG5xUzdy?=
 =?utf-8?B?bDFURUQvc2N1dDBjK2hib1dYVnEvK3k2NjN4cVNkc092akd3amV4Q2NYTXF5?=
 =?utf-8?B?cmVQTW5SamxxYXVnSFlDOTFQelFYZzhnTmhyQzREV1JVa0I1enVudlhMSE41?=
 =?utf-8?B?Tnh3dGdKQ0RCMWtlU0NKMm9xVFJFd29RTVhzMmpsZXNoZHE2SGVCVFJNdW1t?=
 =?utf-8?B?cE8zbjNPVnE2N2FPSmkwZDgwNlRtQkI5ZGdLZng1OUtEdUkyK21wRXFNS2Ru?=
 =?utf-8?B?T0dKSDIxN1ptY3BIREpWbzdyM01ES0tRY3d0YXJWUk1vM2svem1YRnJ2ajYz?=
 =?utf-8?B?TjZ2TVVhOUJJRHVLZ01qM1ZRNStTUHd3emF6QlZxMklnMGsrM3Jydmo3VEZD?=
 =?utf-8?B?ZngvMHRNdUthSmdzZUdXdlc2SG1kTGRtMlB4TEJtcjNaaUVFK1I4aTcvWElB?=
 =?utf-8?B?TXBjcTdUUEo3YVF3SzBVUEpFRk5qWFVVOXBVenBiK3NnTTJBQ2dYcXFWcU5z?=
 =?utf-8?B?U3BNcGxBVEJ6YlI2anRuSFI2cUs3SWJJMmpkTDgvVk1NSGpoQnFhbmU1MXZ2?=
 =?utf-8?B?TlNTZmRjdytFMlNuZnI2NVgzZk1WRTJlRDM3UUttbm1MbVZVOVF3eHNTRXhG?=
 =?utf-8?B?aHc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 07203e82-f405-4179-fee8-08dcc7d39bd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2024 02:38:04.6124
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x3WrTmDHd3QTjvQTBGCnftdJdMflhZOOo3fjxw4CENnd3+aW0jTkCanTPz1PF2TbfqHVv/fcO2GmTrJ+khmHaiV6Q+t07MCgzlK0cNI4wP0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7421
X-OriginatorOrg: intel.com

SGkgQmFycnksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmFycnkg
U29uZyA8MjFjbmJhb0BnbWFpbC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgQXVndXN0IDI4LCAy
MDI0IDc6MjUgUE0NCj4gVG86IFNyaWRoYXIsIEthbmNoYW5hIFAgPGthbmNoYW5hLnAuc3JpZGhh
ckBpbnRlbC5jb20+DQo+IENjOiBha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnOyBiYW9saW4ud2Fu
Z0BsaW51eC5hbGliYWJhLmNvbTsNCj4gY2hyaXNsQGtlcm5lbC5vcmc7IGRhdmlkQHJlZGhhdC5j
b207IGhhbmNodWFuaHVhQG9wcG8uY29tOw0KPiBoYW5uZXNAY21weGNoZy5vcmc7IGhjaEBpbmZy
YWRlYWQub3JnOyBodWdoZEBnb29nbGUuY29tOw0KPiBrYWxlc2hzaW5naEBnb29nbGUuY29tOyBr
YXNvbmdAdGVuY2VudC5jb207IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51
eC1tbUBrdmFjay5vcmc7IG1ob2Nrb0BzdXNlLmNvbTsNCj4gbWluY2hhbkBrZXJuZWwub3JnOyBu
cGhhbWNzQGdtYWlsLmNvbTsgcnlhbi5yb2JlcnRzQGFybS5jb207DQo+IHJ5bmNzbkBnbWFpbC5j
b207IHNlbm96aGF0c2t5QGNocm9taXVtLm9yZzsgc2hha2VlbC5idXR0QGxpbnV4LmRldjsNCj4g
c2h5ODI4MzAxQGdtYWlsLmNvbTsgc3VyZW5iQGdvb2dsZS5jb207IHYtc29uZ2Jhb2h1YUBvcHBv
LmNvbTsNCj4gd2lsbHlAaW5mcmFkZWFkLm9yZzsgeGlhbmdAa2VybmVsLm9yZzsgSHVhbmcsIFlp
bmcNCj4gPHlpbmcuaHVhbmdAaW50ZWwuY29tPjsgeW9zcnlhaG1lZEBnb29nbGUuY29tOw0KPiB6
aGVuZ3RhbmdxdWFuQG9wcG8uY29tOyBGZWdoYWxpLCBXYWpkaSBLIDx3YWpkaS5rLmZlZ2hhbGlA
aW50ZWwuY29tPjsNCj4gR29wYWwsIFZpbm9kaCA8dmlub2RoLmdvcGFsQGludGVsLmNvbT4NCj4g
U3ViamVjdDogUmU6IFtQQVRDSCB2NyAyLzJdIG1tOiBzdXBwb3J0IGxhcmdlIGZvbGlvcyBzd2Fw
LWluIGZvciBzeW5jIGlvDQo+IGRldmljZXMNCj4gDQo+IE9uIFRodSwgQXVnIDI5LCAyMDI0IGF0
IDE6MDHigK9QTSBLYW5jaGFuYSBQIFNyaWRoYXINCj4gPGthbmNoYW5hLnAuc3JpZGhhckBpbnRl
bC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gSGkgU2hha2VlbCwNCj4gPg0KPiA+IFdlIHN1Ym1pdHRl
ZCBhbiBSRkMgcGF0Y2hzZXQgWzFdIHdpdGggdGhlIEludGVsIEluLU1lbW9yeSBBbmFseXRpY3MN
Cj4gPiBBY2NlbGVyYXRvciAoSW50ZWwgSUFBKSBzb21ldGltZSBiYWNrLiBUaGlzIGludHJvZHVj
ZXMgYSBuZXcgJ2Nhbm5lZC1ieV9uJw0KPiA+IGNvbXByZXNzaW9uIGFsZ29yaXRobSBpbiB0aGUg
SUFBIGNyeXB0byBkcml2ZXIuDQo+ID4NCj4gPiBSZWxhdGl2ZSB0byBzb2Z0d2FyZSBjb21wcmVz
c29ycywgd2UgY291bGQgZ2V0IGEgMTBYIGltcHJvdmVtZW50IGluIHpyYW0NCj4gPiB3cml0ZSBs
YXRlbmN5IGFuZCA3WCBpbXByb3ZlbWVudCBpbiB6cmFtIHJlYWQgbGF0ZW5jeS4NCj4gPg0KPiA+
IFsxXQ0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvY292ZXIuMTcxNDU4MTc5Mi5naXQu
YW5kcmUuZ2xvdmVyQGxpbnV4LmludGVsLmNvDQo+IG0vDQo+IA0KPiBIaSBLYW5jaGFuYSwNCj4g
VGhhbmtzIGZvciBzaGFyaW5nLiBJIHVuZGVyc3RhbmQgeW914oCZbGwgbmVlZCB0aGlzIG1USFAg
c3dhcC1pbiBzZXJpZXMNCj4gdG8gbGV2ZXJhZ2UgeW91cg0KPiBJQUEgZm9yIHBhcmFsbGVsIGRl
Y29tcHJlc3Npb24sIHJpZ2h0PyBXaXRob3V0IG1USFAgc3dhcC1pbiwgeW91IHdvbid0DQo+IGdl
dCB0aGlzIDdYDQo+IGltcHJvdmVtZW50LCByaWdodD8NCg0KWWVzLCB0aGF0IGlzIGNvcnJlY3Qu
DQoNCj4gDQo+IFRoaXMgaXMgYW5vdGhlciBpbXBvcnRhbnQgdXNlIGNhc2UgZm9yIHRoZSBtVEhQ
IHN3YXAtaW4gc2VyaWVzLA0KPiBoaWdobGlnaHRpbmcgdGhlIHN0cm9uZw0KPiBuZWVkIHRvIHN0
YXJ0IHRoZSB3b3JrIGZyb20gdGhlIHN5bmMgSU8gZGV2aWNlLg0KDQpTdXJlLCB0aGlzIG1ha2Vz
IHNlbnNlIQ0KDQo+IA0KPiBJ4oCZbGwgdHJ5IHRvIGZpbmQgc29tZSB0aW1lIHRvIHJldmlldyB5
b3VyIHBhdGNoIGFuZCBleHBsb3JlIGhvdyB3ZSBjYW4NCj4gYmV0dGVyIHN1cHBvcnQgYm90aA0K
PiBzb2Z0d2FyZSBhbmQgaGFyZHdhcmUgaW1wcm92ZW1lbnRzIGluIHpzbWFsbG9jL3pyYW0gd2l0
aCBhIG1vcmUNCj4gY29tcGF0aWJsZSBhcHByb2FjaC4NCj4gQWxzbywgSSBoYXZlIGEgdGFsa1sx
XSBhdCBMUEMyMDI04oCUd291bGQgeW91IG1pbmQgaWYgSSBpbmNsdWRlIGENCj4gZGVzY3JpcHRp
b24gb2YgeW91ciB1c2UNCj4gY2FzZT8NCg0KU3VyZSwgdGhpcyBzb3VuZHMgZ29vZC4NCg0KVGhh
bmtzLA0KS2FuY2hhbmENCg0KPiANCj4gWzFdIGh0dHBzOi8vbHBjLmV2ZW50cy9ldmVudC8xOC9j
b250cmlidXRpb25zLzE3ODAvDQo+IA0KPiA+DQo+ID4gVGhhbmtzLA0KPiA+IEthbmNoYW5hDQo+
IA0KPiBUaGFua3MNCj4gQmFycnkNCg==

