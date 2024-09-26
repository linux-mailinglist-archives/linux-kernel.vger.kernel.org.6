Return-Path: <linux-kernel+bounces-340975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9CB9879B2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 21:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 406A5B25394
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 19:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DB117799F;
	Thu, 26 Sep 2024 19:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="haaIGnYi"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EBF522A
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 19:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727379647; cv=fail; b=jddC63l7umIypwrzCZeJw8YF3OPDQT/OJGNPsYM3H3UXIuV00eq3WfT47SYsXnSmFhGGFFepsuqeFcCdl5bWB3qzRZygTd1EwXvnQsKuXTbuPrqUVzOhOi6NsnvFyStwSyA9+fYyM2L10LX2ILtm3bWpxnIz93t7+8XieTPLOqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727379647; c=relaxed/simple;
	bh=8+IY8TZBHuF3fDkqSNri03Ec9cb66cuiWaF0DNjccHY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GQ8fLYfhVrl2OruPrpnZ/yelNyJ/RtT19R3aLNP9rBuGaVS9URCEjori3BgO1OuoeVlvB2g+zDz3YM3WsXBsP1PXj+6uenCRwrkVn+wG6bHczyTsq7fNqZrDkgMiOWi6hpeZxsUUmBAGZDdjS017ZlyWNI3+FsRGLQUpxTDHK24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=haaIGnYi; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727379646; x=1758915646;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8+IY8TZBHuF3fDkqSNri03Ec9cb66cuiWaF0DNjccHY=;
  b=haaIGnYi2KXY0RxJ73tc74c1WLwkdb3MkNZyBeoytTMJxneuG5ijRR2N
   ohD3CxX1boC306Zpanqh5Vf3zOf2kw9bWOJYckDj2fHvKxjOy8+L7ByNn
   iN8Oje0+cZk2AC1ENGEMNNZBdqm17oT1L2RQ4pfZBoVe+NTPvFGrL/WIY
   VNqAgEI+2pzdFrK4YEJA1I+Cbja0pbuoKa8xnCAI41RZlKUeccwqmz49b
   ltbQRe9IE4G27C3t7LX9E1In7Cg72WXAsWiAQpBajiTx1qYOE3xso8n71
   8OhGQee44XsFTCdUIjQy5tsiGvu9Sc/Gi9QzvNeIQcI4ksikzAkTq9Jnh
   g==;
X-CSE-ConnectionGUID: b7CzHsAVS3Gd/WpWZOD3Tg==
X-CSE-MsgGUID: 8bPP7C4WQS2bhIce6EMSEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="26377787"
X-IronPort-AV: E=Sophos;i="6.11,156,1725346800"; 
   d="scan'208";a="26377787"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 12:40:45 -0700
X-CSE-ConnectionGUID: +ycW0AaKRtutgcO3ReG/xg==
X-CSE-MsgGUID: KOyVAfxWRgeK9K+f/KI1oQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,156,1725346800"; 
   d="scan'208";a="77216237"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2024 12:40:45 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 12:40:44 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 12:40:43 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 26 Sep 2024 12:40:43 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 26 Sep 2024 12:40:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JnxKFI95PLHOMOXzlPQ07J8n0h39/mYFYutXKArRI4SWAjTylc7FJB7m3bR2vEFTml5zm0cYlqOj1VtW39tyOI+xijh4olCcThnnTl+U7K3QpGh5SHFEAsvPwMjkB+gYPTU9nGRdAysREqdQkhh6FXjkvn/GGdfaPn0mfyeFJekfZr5cN1nDwueXWWQ8pJD/ztTDl9XS3mYcWsj7ruKHQbOa/YZC41dH2PtrroZU7HkHJUbUrABrGkA/rjKdGoDhBYXSHaRGOzXBI0HsWZlfrrt2vHmGsgaPrAF/X18tBux1SqGB1ICB5dE7Akh92akOWweGWLVN3lthKCfQqhgMNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+IY8TZBHuF3fDkqSNri03Ec9cb66cuiWaF0DNjccHY=;
 b=czyt4PDSDWotecECykfA+7e7Xa2RJ8bmxEuM/ryQh0YD8sWWNmhzcVZMg45Lg/AMnKISXhTGgPL9WXBS0le6bLsrl5rhAC9TFHE8Ux5en/2cgvrrbf/qGB5F137wR3DniHIW2bDBUXfVmH3VdPWczfRhLmsC6g74p7SRIkOxFPn5ve7FWSz3F3wZNQTbWSJn2V+XQAuEKw89e2jthZHG8uH50Z9NAJ78tpF8QPPbkf7xulPvhJvIibvktsVSQrtge/F0kCa6QgtjswL/eaC/trAZCK12N9SjAnHnWV0PjqPJR7+h269OFePLlOU+vjw4FdW/9GI7/ExOzyLWVa7eKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by PH7PR11MB7515.namprd11.prod.outlook.com (2603:10b6:510:278::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Thu, 26 Sep
 2024 19:40:40 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 19:40:37 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Yosry Ahmed <yosryahmed@google.com>, Johannes Weiner <hannes@cmpxchg.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "nphamcs@gmail.com"
	<nphamcs@gmail.com>, "chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "shakeel.butt@linux.dev"
	<shakeel.butt@linux.dev>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"Huang, Ying" <ying.huang@intel.com>, "21cnbao@gmail.com"
	<21cnbao@gmail.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"Zou, Nanhai" <nanhai.zou@intel.com>, "Feghali, Wajdi K"
	<wajdi.k.feghali@intel.com>, "Gopal, Vinodh" <vinodh.gopal@intel.com>,
	"Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v7 6/8] mm: zswap: Support mTHP swapout in zswap_store().
Thread-Topic: [PATCH v7 6/8] mm: zswap: Support mTHP swapout in zswap_store().
Thread-Index: AQHbDh+C+ZYgIzdq4EuvViy0xt7aPLJnVm0AgAEuMgCAAFEmAIAADdcAgAAFSgCAAAmZgIAADtIAgAAWxLCAAFmCgIAAEe0AgAC+71CAABHrAIAAANsggAAWW4CAAAC0AIAADzTA
Date: Thu, 26 Sep 2024 19:40:37 +0000
Message-ID: <SJ0PR11MB5678773A3A8AD10EE584725EC96A2@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20240925192006.GB876370@cmpxchg.org>
 <CAJD7tkY-ayU3Ld+dKTLEEG3U72fGnCbiQgZursK+eGMXif_uzA@mail.gmail.com>
 <20240925201323.GA880690@cmpxchg.org>
 <CAJD7tkbCDe1Y__0vUKt9q0dz_sXM74fKGQo2Zgq9CJ8=FEjH3w@mail.gmail.com>
 <SJ0PR11MB5678EC9681960F39427EABFFC9692@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <SJ0PR11MB56781A134838ADDD04731AA3C96A2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkYtVR6fi1R2O+jAxVfj7BJ2EKWbXHke9fkv_m=mf5pkFQ@mail.gmail.com>
 <SJ0PR11MB56785027ED6FCF673A84CEE6C96A2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkaRjrPTdCCAA0zSVyAZ2sCKiJUC36J0fsajdtp1i_JZeg@mail.gmail.com>
 <SJ0PR11MB56781678BE55278052EB590CC96A2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <20240926184301.GA883850@cmpxchg.org>
 <CAJD7tkZTBLbx3-RUwUv8UpUt=-XiMd1mzUzC387dNTyreyFrJA@mail.gmail.com>
In-Reply-To: <CAJD7tkZTBLbx3-RUwUv8UpUt=-XiMd1mzUzC387dNTyreyFrJA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|PH7PR11MB7515:EE_
x-ms-office365-filtering-correlation-id: c6f11229-aab3-4a64-490e-08dcde63187b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YmJvdGZjL0pqTllqR2FyNmF3K3FmcWo4VWxEN2F5N0RXNFFGOUtjR0JtSkJT?=
 =?utf-8?B?c2s1SDh5WVhRK0U1Ry9oNmJrZVNleHlBdUFqQmtIOC9qbHByZklFaHdwdW9E?=
 =?utf-8?B?cTBuMEIzSjJtL1FxWHlsL25nVXFVSGU0WjA0Z2hXQ2hCQVcveFgyaEZWNkZR?=
 =?utf-8?B?WUVlV3M3eXNLVm5OTnVjb2hpY01Ga3VFRHNtU0Q0dlNhZUpmNlhWWXJyMXlF?=
 =?utf-8?B?c28yZGNVcmF4enZVZlROdlFqNi9xZTFCdFJUdzFIWkN4YXZ5TVMzbkpOdXQ4?=
 =?utf-8?B?bGo5R3AyK0EvYkJrek1jWkZZWmFJOFFidllWY2JtU1N1WDdEY1dJSUJIZnd5?=
 =?utf-8?B?dVNoWWZRY0VMNUdNZTRJamp6b29FZnowNTlST2JNL1MwdzRycUg2VDJCaGw5?=
 =?utf-8?B?Y0gwVTRnZUMrWkxLeWVzUTFSSlBnSDAwVFBBa2M1MnYreUw4ZHFQSXVwOEdw?=
 =?utf-8?B?WUtyYXduckNFR2Q5TW9tZk1UTmQrQklGbmw3eW1LSW5lWXBrQVdNSFcyb2Nt?=
 =?utf-8?B?QVRadkI1MmcrMGgxZzdGSDZ4ZW92MkIzalVvK21EREJ1K2tmTVBoZExSM05M?=
 =?utf-8?B?SGZvdDdIL0Z2ZTdBemZwUUdqUW11dzdBQzRiUlQ4NEp6Zm56UUl4ZmJrQ0xE?=
 =?utf-8?B?UGRFaWJGTE42RHpNOTRMVzBLZUxJNG9mYzdzbzVFdUs1UUhZNW80MHI0b0lU?=
 =?utf-8?B?Tk1DVTNlcThZQXI4MzU1b3QrL1Z0TnJuS0xoSVVLa29QUVJKZkxjaTJLZFBl?=
 =?utf-8?B?Z3diZm5BbzM3aU42a0IrTzVENUNWYmwrSzR3TzJqcVRlQmdLM2ZRNE9nR3ho?=
 =?utf-8?B?K2wvVWdzRDYrQXltSUV1bWVFMjhaVUhjM3FoZzU0QmdvUVpjYU5WOEZ3S3Vl?=
 =?utf-8?B?OWxac1VocUZ2MEVXajJ0K0hLeUhlWEw0T2RnSXJqZ2d4eW83ZVROL1hDdjFi?=
 =?utf-8?B?eEszQWRoYUR6eFl6U1doYVJBODRDZkhsMW1GTGc2bGtqQzdVQlkwbUVxZDFq?=
 =?utf-8?B?d1pzK2ViMC94aitsS1duUlVibHZxR2ZIZ3FzUXBwbXIrak1Wa1puU2JFQ2dJ?=
 =?utf-8?B?dzE4QVpMT09GcCtkZ1NhaUY4R2dKSVg3Zlorclh0aTJCR1VYcTg3dEEyOERw?=
 =?utf-8?B?UWhXSjh1ZFZYWHRzTXE0NEREK2lWRmxOcDlqeTczbUxvNStTMEVZZWUzcTVt?=
 =?utf-8?B?c3ptazJTQlVTSms0YVZzZGFLT1MrNkI2VWNiQmdBSVlhMDdjNlZiSWM5dUNv?=
 =?utf-8?B?aWpTTGp3ejVCODBwRWNFVlZocnppT1FmMGtYSGt1RTRPVlhYa0NGdjhBOWVs?=
 =?utf-8?B?YjhLWmMxaXdpTTBXMnFjbkhlU09ITTB0THFnWTVVMHlWTnhIcE11WEwzcnB4?=
 =?utf-8?B?cHEzNzYxbFpVTHBMVkhFdGVST1k2b1pST3ZUT3hFSzM2TEZoRktMUVBma1da?=
 =?utf-8?B?ckgyUUFzUlhmUDFWclp4N25PdEw1MzduOWFhS00rWmRRN0RaQ3QrVEJoTWZV?=
 =?utf-8?B?QzFHakIxMkdhTVdvU08xcGhOeFZkZ0RaU3ZXSklwdkNIczE4cUoreFQ2WmVs?=
 =?utf-8?B?QStka3dDdUh4c2tLbDl1Tjk2eGJaMmZJVm5ESjhGNk5ZVUpEc1dUQUM3ZG5a?=
 =?utf-8?B?V3dETWFaY283QW9QWWtISEJYZ1pwdkVZTnhwczRzZndaNGdIb2pDYXYyUU5Z?=
 =?utf-8?B?SGlzVW9ralhwWGRHd3pZaHRnN1dtVVJ3aGY5cGRvZmxnWktDWGJIcXhyelJT?=
 =?utf-8?B?M3BUNExxL2E4Wm9zYTZQeHJHTk5FbWgrTUtJLzRXaTYxNVJiQU9Vc1hocDE4?=
 =?utf-8?B?UENkVTdrNnE0M3hsRVpqM3BrOHNoVTNUam50Q1U1elBzNmd5SWduTmZFTTJl?=
 =?utf-8?B?c08vM3BiWi9La0F5eitST05PYTZjbUtJQ05kaG9qaTJNTmc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YkpNb1lhOXE1N1lLVjA4aHU3bjZwMFNpUTVPMFUwVld3WEw1M3o1dTFqcTdZ?=
 =?utf-8?B?VWtvaitKVCttaVNoeUs1TDdqWWlERHNkejFTTTY5K1ptSU85cjQ2UjNYQWZG?=
 =?utf-8?B?SXNQTWJhaVc3Kytsc0did3BTb2NWS2xPdVNRZDBieTM4WWduR3RRT0ZsMGRs?=
 =?utf-8?B?TjBzWElLcGNCNzR6QVoyUFlEbEJPRFA1bjBibHpGOUVHeHptSEpHbVZQWUk1?=
 =?utf-8?B?K01mUkViWlhnY0dSRnkwMk5HVlBGeC9RTkI0cFI1c1FRWEtFdTNKSTQxR1Vr?=
 =?utf-8?B?R095bzBmRGZiU1Z6ZXNZejVpVzgxeW80ZTJKVTcwRlZrdkJXMjJuN3RLNkhi?=
 =?utf-8?B?WE5VamhvNEl3NkJKbyttM213Z0d4aXc3ZzVsQ3BZVU91S3N5alNwRThEZnIy?=
 =?utf-8?B?cmtWTjUzb1VvN2FYbnc5SGZxWm5jWDExdU4zUDlJY0VvQ2pibEpxcEhZdDFM?=
 =?utf-8?B?NlhIVDBvY0g2Y25Kait6ZnFPS0Z2MHFZRDBtSmlaVGwwcitnRVc0N2Rrb2U2?=
 =?utf-8?B?VFR1S3JnNzZCU3JPWjhFR05ZZmFpZXNXVlREM05zWjM5bzFrMmhVRk9zRU56?=
 =?utf-8?B?Smw0Y0F2V2lBalIzZFhFeHM5ejdjcEpFcnRJMVZXbFBiek0zVXRQd1I5UXVD?=
 =?utf-8?B?dWJNQ0lXSnRyb0lBTFV4Y3BzUElpYXc3SHpsZGlVSDlHcHF1U3ZTN0RHVWM2?=
 =?utf-8?B?aFFkbkdQWHpLZk8vRjN3SjNLTHdZVC9uTXNjaUdmZU51cEZMd21YRnJlYkFM?=
 =?utf-8?B?aEVGRmpwUUkrODBTSFVVTGs1TFo2aktCT3BZQUkzS2xyWUJJNTZ2MTV0VjY2?=
 =?utf-8?B?dWFGUWNZSHUwSmVGdk1ibTQwMlV0OWYxUFE2RGtlSlpFejBKRnBNUmwxVFc4?=
 =?utf-8?B?MWNFNWhab3pQVUZDTVBaampXUXRlWStGbFV3ZkZxRjZRcGJiamJqNzE4M2tz?=
 =?utf-8?B?MUpHS0FlTHN6MkxRcnF2ZldqbG9GL3pHclRQZ0NQMkpCMEQ0Y2l4aWJETHpP?=
 =?utf-8?B?cXY5MExoZUxZZHpESjFQd1VDblFEL3Ara1lXTGJNcURYTFFzRlFONWhjMk5V?=
 =?utf-8?B?U2ZHamFaSzNYcU43MlcxU1B3NlByRjJiei9nYmRUaDNTRi9rMEl4Uy9JeXZi?=
 =?utf-8?B?MEx1VXJVSnkzdUtVdE9nVFBtSm5CZjNiTTgxc1FrazU2QkpSK3FWRDVySG0y?=
 =?utf-8?B?TkpnT0t4Smk3RW92YkJsTk1PWDlHVkxTS1VadXlQTE5pQ3RrdURJMVQ3SmNJ?=
 =?utf-8?B?UzluWU9IQWN3QUhuQUlCODFCWFhnRGs5VmhTNGN3QUcyeFBzVDliU3JwVTdy?=
 =?utf-8?B?ckhpbDlnZGZMMmhIMzZDOTdrbDdZWnhLRWlNbHFQWmdRZndzMHFrdUlWczU1?=
 =?utf-8?B?YW9sVWJzRnBPckZ2NXBWS3lJeWRDL0poYUhmczJOMGZodnErZ2JxTG1LL2FT?=
 =?utf-8?B?OG1ZdWx5QlpwMVZYQXRnQlp3UUlONWkySUlkYXNrK1F5YmE2Rld4eHNKejJF?=
 =?utf-8?B?b296LzZwNXl5cjlhLzFzeGdPbmFvRzFvWmU4V3NmeWtQeFlEekVaZmpzOEg2?=
 =?utf-8?B?SlQ0RzZ2bzE5c2xENGpLc1FoYTl5ZXd6NXBid0dTakt3REppaHRGelZVZWV3?=
 =?utf-8?B?UUVmM1dkUTZMdGNialVKMWZ0THdrM1QyWmFCWU91NmVudVFaY0hmZUVYdEJT?=
 =?utf-8?B?WjNhQXdUVFJWZmF3U082U1d3dWp0ZUZvVUgzNjI1TmdMTThhQitLU3pnd0tK?=
 =?utf-8?B?bitFL1VMSzgzRHhiMGt2b2srelRMVGY1ZjdoQzJhaXA0aFFkZlUrc201cGpQ?=
 =?utf-8?B?TkEzcUJXTmtobm5wVWFkRW1VTUVXUHpqdERFdnhZWjlRLytVSVY4Zit1cEQw?=
 =?utf-8?B?azdhMXpjQmtLTXRnK0tCamVXMks3K2U2NnUwNEIrVTRIbm9sMWFWcDZZWlVY?=
 =?utf-8?B?L2VjUHRRVjVFL1VXUlQ4MnBGbUVkYXFpSkhrT1pHRFBpNnB6eUk3Y3BBTTNO?=
 =?utf-8?B?Z2ErY3ZvUG9xV1Z3ZER3N0d2dXYvVU1pcCtDN3A1RDQ2QlFBVkdFcHFDZ3Va?=
 =?utf-8?B?UEJaQVc1a1gya1NXWWJjbjdXcmFEZUVlaHk0c2RuVTlWazgyZGx1RE53bFBy?=
 =?utf-8?B?NUxjWGNxd2hESjZaZTlidHZWUzFsa2NRV0lOSkFYUXY5ZWhXemxRa2t5NEcz?=
 =?utf-8?B?eGc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c6f11229-aab3-4a64-490e-08dcde63187b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2024 19:40:37.3509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yinRUk/N/m9lyo0lNfaVMbmcxODyOqE3Q5cFcVgpoFHbVdjV7kpKxOI+fRWgjoXSj4aiYWRQEuhrpN7NspQmVmo0tpnm09/lfQ6cfPIE9GI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7515
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBZb3NyeSBBaG1lZCA8eW9zcnlh
aG1lZEBnb29nbGUuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgU2VwdGVtYmVyIDI2LCAyMDI0IDEx
OjQ2IEFNDQo+IFRvOiBKb2hhbm5lcyBXZWluZXIgPGhhbm5lc0BjbXB4Y2hnLm9yZz4NCj4gQ2M6
IFNyaWRoYXIsIEthbmNoYW5hIFAgPGthbmNoYW5hLnAuc3JpZGhhckBpbnRlbC5jb20+OyBsaW51
eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtbW1Aa3ZhY2sub3JnOyBucGhhbWNz
QGdtYWlsLmNvbTsNCj4gY2hlbmdtaW5nLnpob3VAbGludXguZGV2OyB1c2FtYWFyaWY2NDJAZ21h
aWwuY29tOw0KPiBzaGFrZWVsLmJ1dHRAbGludXguZGV2OyByeWFuLnJvYmVydHNAYXJtLmNvbTsg
SHVhbmcsIFlpbmcNCj4gPHlpbmcuaHVhbmdAaW50ZWwuY29tPjsgMjFjbmJhb0BnbWFpbC5jb207
IGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc7DQo+IFpvdSwgTmFuaGFpIDxuYW5oYWkuem91QGlu
dGVsLmNvbT47IEZlZ2hhbGksIFdhamRpIEsNCj4gPHdhamRpLmsuZmVnaGFsaUBpbnRlbC5jb20+
OyBHb3BhbCwgVmlub2RoIDx2aW5vZGguZ29wYWxAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIHY3IDYvOF0gbW06IHpzd2FwOiBTdXBwb3J0IG1USFAgc3dhcG91dCBpbg0KPiB6c3dh
cF9zdG9yZSgpLg0KPiANCj4gT24gVGh1LCBTZXAgMjYsIDIwMjQgYXQgMTE6NDPigK9BTSBKb2hh
bm5lcyBXZWluZXIgPGhhbm5lc0BjbXB4Y2hnLm9yZz4NCj4gd3JvdGU6DQo+ID4NCj4gPiBPbiBU
aHUsIFNlcCAyNiwgMjAyNCBhdCAwNToyOTozMFBNICswMDAwLCBTcmlkaGFyLCBLYW5jaGFuYSBQ
IHdyb3RlOg0KPiA+ID4gPiA+IDMpIEtlZXAgdGhlIGFwcHJvYWNoIGluIHY3IHdoZXJlIG9ial9j
Z3JvdXBfZ2V0L3B1dCBpcyBsb2NhbGl6ZWQgdG8NCj4gPiA+ID4gPiAgICAgenN3YXBfc3RvcmVf
cGFnZSBmb3IgYm90aCBzdWNjZXNzIGFuZCBlcnJvciBjb25kaXRpb25zLCBhbmQgYW55DQo+ID4g
PiA+IHVud2luZGluZw0KPiA+ID4gPiA+ICAgICBzdGF0ZSBpbiB6c3dhcF9zdG9yZSB3aWxsIHRh
a2UgY2FyZSBvZiBkcm9wcGluZyByZWZlcmVuY2VzIG9idGFpbmVkDQo+IGZyb20NCj4gPiA+ID4g
PiAgICAgcHJpb3Igc3VjY2Vzc2Z1bCB3cml0ZXMgKGZyb20gdGhpcyBvciBwcmlvciBpbnZvY2F0
aW9ucyBvZg0KPiB6c3dhcF9zdG9yZSkuDQo+ID4gPiA+DQo+ID4gPiA+IEkgYW0gYWxzbyBmaW5l
IHdpdGggZG9pbmcgdGhhdCBhbmQgZG9pbmcgdGhlIHJlZmVyZW5jZSBiYXRjaGluZyBhcyBhDQo+
IGZvbGxvdyB1cC4NCj4gPiA+DQo+ID4gPiBJIHRoaW5rIHNvIHRvbyEgV2UgY291bGQgdHJ5IGFu
ZCBpbXByb3ZlIHVwb24gKDMpIHdpdGggcmVmZXJlbmNlIGJhdGNoaW5nDQo+ID4gPiBpbiBhIGZv
bGxvdy11cCBwYXRjaC4NCj4gPg0KPiA+IFllYWgsIEkgYWdyZWUuIFRoZSBwZXJjcHUtcmVmY291
bnRzIGFyZSBub3QgdGhhdCBleHBlbnNpdmUsIHdlIHNob3VsZA0KPiA+IGJlIGFibGUgdG8gbGl2
ZSB3aXRoIHBlci1wYWdlIG9wcyBmb3Igbm93Lg0KPiA+DQo+ID4gT25lIHRoaW5nIHlvdSAqY2Fu
KiBkbyBmcm9tIHRoZSBzdGFydCBpcyB0cnlnZXQgYSBwb29sIHJlZmVyZW5jZSBpbg0KPiA+IHpz
d2FwX3N0b3JlKCksIHRvIHByZXZlbnQgdGhlIHBvb2xzIHVudGltZWx5IGRlbWlzZSB3aGlsZSB5
b3Ugd29yayBvbg0KPiA+IGl0LCBhbmQgdGhlbiBpbiB6c3dhcF9zdG9yZV9wYWdlKCkgeW91IGNh
biBkbyBnZXRzIGluc3RlYWQgb2YgdHJ5Z2V0cy4NCj4gPg0KPiA+IFlvdSdkIGhhdmUgdG8gcmVu
YW1lIHpzd2FwX3Bvb2xfZ2V0KCkgdG8genN3YXBfcG9vbF90cnlnZXQoKSAod2hpY2ggaXMNCj4g
PiBwcm9iYWJseSBmb3IgdGhlIGJlc3QpIGFuZCBpbXBsZW1lbnQgdGhlIHRyaXZpYWwgbmV3IHpz
d2FwX3Bvb2xfZ2V0KCkuDQo+IA0KPiBZZWFoIEkgd2FzIGFjdHVhbGx5IHBsYW5uaW5nIHRvIHNl
bmQgYSBmb2xsb3ctdXAgcGF0Y2ggdG8gZG8gZXhhY3RseQ0KPiB0aGF0IHVudGlsIHdlIGZpZ3Vy
ZSBvdXQgcHJvcGVyIHBhdGNoaW5nIGZvciB0aGUgcmVmY291bnRzLiBFdmVuDQo+IGJldHRlciBp
ZiBLYW5jaGFuYSBpbmNvcnBvcmF0ZXMgaXQgaW4gdGhlIG5leHQgdmVyc2lvbiA6KQ0KDQpTdXJl
LCBZb3NyeSwgSSB3aWxsIGluY29ycG9yYXRlIGl0IGluIHRoZSBuZXh0IHZlcnNpb24hDQoNClRo
YW5rcyBhZ2FpbiwNCkthbmNoYW5hDQo=

