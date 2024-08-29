Return-Path: <linux-kernel+bounces-307557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43968964F0D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 21:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4C461F22F5A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 19:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1C91B9B45;
	Thu, 29 Aug 2024 19:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SDkqV97H"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A7A1AE046
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 19:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724960296; cv=fail; b=vCwVPk1N/FTlAczX4qEpsPpv5C+FO6N9AwRvz991wH0NnQTPR0qICAQbdGsBEEBCyycFN8AluWFTwhvdbUx/uigezKFSkA25LYZaM0JAyiR0pamrORqcUeOQXawAVoqtjNKJD++2nT6AWCR7ta/bSIKptBDt64WLzvrtCtQ6VLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724960296; c=relaxed/simple;
	bh=UZYWrkZUCWidrpZ+zjXjVPyvxwE4Q9rhpRH+jfzSZJQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=avXxwzrcv+Fzl0848FwrtI12XVo7+QSWuX/eGEJluSDPt5S5rMSUhQvs/HSTnBs5uEfK0YNwAaMzXPDarZL03ZiabxxGKFe1EHrEGLa17QF2PJmP11ZSvRAekh0a8R5rzT+z2u4F4wcVwe3t2b/nLYuorm06dPEGKkR6wAJg+HA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SDkqV97H; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724960294; x=1756496294;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UZYWrkZUCWidrpZ+zjXjVPyvxwE4Q9rhpRH+jfzSZJQ=;
  b=SDkqV97HYf1mEShGAylrpOP8MtwSmGaMmvxaV/AU0ByXtH7/gLo7/9VQ
   n8tJqHM1XtJc7wDL3ZAovDkt86z/szB4Xsxqy6h7/PfvDGPwJNlro4+2O
   Rd1Y1Qj00WAbZGisII7nXVxJN1wuS8huzzx0ZBEjJfI5em8zDUy7YKIAz
   UOLcwRtg3E0CDgXrq4NNZK9W/4QPR1BaVsyOO+G9sgENShrNo77/gSwOj
   KxQmR6iLYElrxLi1sg03atqiGQDa4ckwm589WHX16WRNZm8yVt90eEeE6
   LJCe445Na7b2+RPM3BDoBNBPeXnpejip85yXwYD0W0tUkExP7nObInPqO
   Q==;
X-CSE-ConnectionGUID: wWRYDDC/TASEOqM+dqvnJw==
X-CSE-MsgGUID: p9MbDS8XTJCPNXpYmTiAsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="23380973"
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="23380973"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 12:38:11 -0700
X-CSE-ConnectionGUID: daD4z65JSOyemrcRkuNOTg==
X-CSE-MsgGUID: f/FjfJOeRjWzyafUtc8nFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="63629243"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Aug 2024 12:38:09 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 29 Aug 2024 12:38:08 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 29 Aug 2024 12:38:08 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 29 Aug 2024 12:38:08 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 29 Aug 2024 12:38:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tfiGusL+s5nbG2lxrTj8Xu9NgWOfj5hveVY51nZg2nzHyxn6uLdadLbRQ4V5mBontkhXfkmxR//2WdE0d5evqmWPwK18L+Tg8AxCq3C3ebh16eiKQXZHwzQKaWO2BypqVImo44AibsYkOdCEBw+laZOq/NYIIpvcpUzx1ZHOm1AhprH5Xspw24T8SJzSBHRUleWqWnNS32Acp8HfDYcbA19+W6F5YMVqwNi8vJd3gbln6k35tnzpoRhiUvw2tlb6P3yEBTm1Nk8l0awZYZ180zfr6GGpz1XV/K3Hm1Rim7E4IM1kVsjtWj3PgmCiOrCN3tsXV/QOQ04mlVKnL13p2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UZYWrkZUCWidrpZ+zjXjVPyvxwE4Q9rhpRH+jfzSZJQ=;
 b=WI1N5gTIjfOfHpc5Eqdf9kSG5TYkrFm6cXXuRarroPvvEiI8eN4+DDOLA/cqXUDqU1AymN07tVYS/FAazy7zKZb4WlYXV7ahZBy6ZFWgPOGtuuoLDJEpi9GKIqro/s1/ghkwMbE1X7KRl/S8MvwLnqD7W07oF7dXTreguTXTSUHAET4gOa9PNHuCfwRGG7hPGpc0P04JVKsxiv+OS22qAJt+JNNQCC7VasdhQ62vc+uoRzrjmRahmUAYkOyF7zAmk0aUxmkiIuQVooiip10gWLjGUQ3+0PZIOtm7rugWwP6H5PQvwkOMeOtNTIjTQYfrVQ/pGgeZloE1KZ2yz1JSAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by DM4PR11MB6264.namprd11.prod.outlook.com (2603:10b6:8:a5::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.20; Thu, 29 Aug 2024 19:38:05 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%5]) with mapi id 15.20.7918.019; Thu, 29 Aug 2024
 19:38:05 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Nhat Pham <nphamcs@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "yosryahmed@google.com" <yosryahmed@google.com>,
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, "Huang, Ying"
	<ying.huang@intel.com>, "21cnbao@gmail.com" <21cnbao@gmail.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "Zou, Nanhai"
	<nanhai.zou@intel.com>, "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>,
	"Gopal, Vinodh" <vinodh.gopal@intel.com>, Usama Arif
	<usamaarif642@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>,
	"Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v5 0/3] mm: ZSWAP swap-out of mTHP folios
Thread-Topic: [PATCH v5 0/3] mm: ZSWAP swap-out of mTHP folios
Thread-Index: AQHa+S2hY1M67nGQo0+E71Bgb79m17I9MgEAgAAYkECAAS/JAIAAKHig
Date: Thu, 29 Aug 2024 19:38:05 +0000
Message-ID: <SJ0PR11MB5678AEDB9E47BB6267D5885CC9962@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20240828093516.30228-1-kanchana.p.sridhar@intel.com>
 <CAKEwX=Pqm3pjOO-ErOTGnNYKwMas4fdiN0bdUcrPHzfKf-Qryw@mail.gmail.com>
 <SJ0PR11MB5678412EE36C10CC0D69D036C9962@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAKEwX=P3L_uxWs6m9KL_Pqv_LpPpXH4E9gWMT95oi==ZNmqkWQ@mail.gmail.com>
In-Reply-To: <CAKEwX=P3L_uxWs6m9KL_Pqv_LpPpXH4E9gWMT95oi==ZNmqkWQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|DM4PR11MB6264:EE_
x-ms-office365-filtering-correlation-id: 17e0f6f7-b98f-4042-8385-08dcc8621a6e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aE14VkdMR0pLaTc5UGpvZnRWZDJhV2hySGo0dTlhdlVzL1RsRHkzK0s5aFNi?=
 =?utf-8?B?UTV2cnNORThvNGhiUUNpY1V4SkxpbThtLytmT0R6Tkh6a0daRXQ1MFh4U25R?=
 =?utf-8?B?MHA4MUViUUJHME5kTFVxSmYwdTBxdGpPcmhVN3lsYjdjN1I4UDZwdzRCUGcv?=
 =?utf-8?B?VGhGTFJhTnhwVzFRQ256T1Z6S2hrazBQMDEySUZzVzE0UFdLbHJUZ1ZhRzZt?=
 =?utf-8?B?b04vNnlkUW5SdG5vQ1IwTzFiemlqcVFOYzFaa3lTTVZzZmN0NWFUSGc3Qzlr?=
 =?utf-8?B?alR6b3Z5bWhhWnFkSURSMXJkWklPMUtFc1VWQnhMOXFTcklTUVdDeHhNdTJW?=
 =?utf-8?B?YVRTRWUzNmY0YkJaTU5hcDRkVlM2c1ltSkF1dzdqSElzYzMwajRncWRNWDhz?=
 =?utf-8?B?QU5QRW5udlp3NjhEa095R1NyMmMzZXhqVzVWVTd5RzN0eU41LzlQQ1Z0UzMw?=
 =?utf-8?B?d0plUnM3dGNMUWNlY0NYcFlkR1VIWnE1cm9PcWZvYklpVEVaVHdTN0xseVND?=
 =?utf-8?B?ZDJiR3pkOTFMZ0NFYzAzeWpEMUZMVGJ1ZzhWOWtLTk1BUUFDRmZWMXhjdmFK?=
 =?utf-8?B?YzlDUzUrRTFzYk92cVR6L0RNT1JiOUtvU3JhbU9HUU5uMnlCcjIwL2xmWjZR?=
 =?utf-8?B?ME1VZjAzb2JHVC96d1lYci96eXUzU0RSVW5Xb0NFbDVhYkM3SHA2ckRYd215?=
 =?utf-8?B?dTRnTmh6MGNMWUx2WEFWNU9vdlNBaFdmVG01RnBtcmc2UTh5bGlheWs3a0dJ?=
 =?utf-8?B?REZ1YlFLdmd1TFRkMlA4NEQycXRsb2xtdTVwdkZEOFJKZS9BTFpPMVZwSjNK?=
 =?utf-8?B?d0V6RkpMR2EyelpYODM5VXVpNnFxRW9aMUJkYTNaYjYwWWZqY0x5eGJPb1dz?=
 =?utf-8?B?OTR3ZUdOa0pCMkNBS1lDWGorVXZoU1U5VVRxaHd2RzRSVjdMTjNpaVNNZ21s?=
 =?utf-8?B?eW04RjBxS2pHWWFVaXBDblhUSmk5NWE5ejdYN2dTSVU0cHMxVUFrUmgwNGl5?=
 =?utf-8?B?dEExTG1IL1UvcVlLYWZiVk1QcU96cTl3QUtIUEU2bVM1em9DNmlmNnNOckc3?=
 =?utf-8?B?Uk16YjUvZjg5NVd6UEpuakFxR0F1MngyeS9ybFZ0Tlk2cHBlUU1Nek5DRldu?=
 =?utf-8?B?WTczV2l4OGloMkdUZkhuSlZRYXhLWWRpRVNlODhlQks1aFB2WUtJdVZGbHJm?=
 =?utf-8?B?NndyTDFXZzJpZXJYMkQxZUVJb1dmcXArZ1NCNVRla3RWVUdnWUV0SHo4d3hj?=
 =?utf-8?B?ZkFwTEJvR0hleWIyZnpyWXdJRmwxaUhYV0NsRWhFL2pZaXhmdHUzczVqNzhV?=
 =?utf-8?B?YUplWUZQVzBqVks4LzhrSzE5WWNTTUx1MGVFRkFaQVBQZjRsNUJpYXlnb1gz?=
 =?utf-8?B?bDFuMGc4QWtZWWMySHhGNTB2azNyaG9oNTVnSjZNR3ZoS0FrZHluYkxHWlBu?=
 =?utf-8?B?V2JWc0VHTm01V3A2Rk40S1k0Zk9CUk5PUGNSYklGVlRadnlPem1zMG5nbFU2?=
 =?utf-8?B?M2gxLzJZNFJkNXIvYXRoWU1HeW1jamxrVysyRmY5NnA2QWZXbXBmQVlaRGp2?=
 =?utf-8?B?YVA0WWpFdngwYnBKbjdEVTJnUEFNQVlQUG96WFZaVlU4WnorYnBrV2lQZkh1?=
 =?utf-8?B?UUc5MjhXRHIvUXU3L3V3Y2pwcTBzTkRQVkpvVEhEOTVMODUzTUV4aHpacDJV?=
 =?utf-8?B?RW9SUEN6T3NtRjh5clFndHF0cHJ6enhNNDNROWlUM252U0plR1FybEtqRkhF?=
 =?utf-8?B?WGhQZmtjUTAxWXVLU3JyZy9GREZqdmJ6RkVlSzFic3NPaTcySGdXdDZHMFBE?=
 =?utf-8?Q?ktMfjIiTYE41hnW/eaqmSq9abIXUOkBesxJRk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dDJhbHc5VHBjME1ZV3l0UGZ1aXVPdVhneHc4OWJpRXRxVXFseXdzM08xVUdl?=
 =?utf-8?B?eGQ3TkJvQ2FLV1B4Mm5zSnpQeGVlaCtxTFNPK0Rjb1Q4K2ZoZTNvSjZhelRP?=
 =?utf-8?B?dDNhL0lNQjRFb1NucFNMa3V5KzZmeXFXOTRXQXF3VnNuQ3pDYlI5blBoSGlX?=
 =?utf-8?B?d1E0NWRJUjRDWU55aXRsekZ1NW4rK2ZCdmNad2ZuL244QmhkM0RjSjZzT3Vo?=
 =?utf-8?B?cWw5R2pESXM2WHhvbll6eWNOdFVnbENTWXhGd2RsdkdoUzNicllEYlNZM0pP?=
 =?utf-8?B?MHQ2MTliajdldHhlNFAyUEF3ZEsxUld1QVpKbTEyTFlLb29DV0x5cVN4MTZQ?=
 =?utf-8?B?RmJxV2FTVFMzM09zNWtSczJlM1IzWkhoNnYwcE9oemRteUJvV2NwZTFPeGVn?=
 =?utf-8?B?YVhoamcwMDh1cC9CTjd5V2p4NFNIY29QbmFsTERPNVVNVENCOGRpTzZtaERM?=
 =?utf-8?B?eHR1bm9VaUJLcklkSTN5Vno0V3BUTU1RckVYeVkzc1JvMkhEb0k1ZDBFN3Zw?=
 =?utf-8?B?Y2dHbjQ1NEJEdVJ3VnVjdkEyWCtaaytielFRY3ZEdG1VczU5S3h4UkdkU1F3?=
 =?utf-8?B?ZWd4NVdKTFpjWmdPcW1jaU9HTFdrT0RUU3FNYjk5S3kvWFEyWGlhT1dCelk5?=
 =?utf-8?B?R1A2dzY3Y1pTVVJQVFM1b05tL29EOUROMkhFOGZkMEplVnNPcnd4aG83cHZr?=
 =?utf-8?B?YVZFVUdtdkpleHlnRlcyUk91WW9wYnFVMVVvS0hTOFpId3lFVG5FTm54SEVi?=
 =?utf-8?B?SmR1RkNCQkhieFNlMkQwOVhqakl0ZzhVeng3emdMNld2a24xaXpLdkF5MS9p?=
 =?utf-8?B?blZWTDdBWmxUZ05nRFVHR2FRblVOTFZZVXJPK1UyaVdUTGs1QmN0TjM4LzEw?=
 =?utf-8?B?Tng1ZWRsTWV4Wlc1Y21RWHlGY0twT0ZIZnducDdudHRKZFQ2dVZ0WW9BaW1y?=
 =?utf-8?B?dFVydXRkQnJzaFFKb3pOaDFVdXlhMVIybG82OThVUzliblNkbUgvUnkvUHNr?=
 =?utf-8?B?QUZDSytkSW05UkZ4WGY5NUV0TU1oZTRrMVQ5QzE0Ujk5Q1d5ODR5VUtQcWlQ?=
 =?utf-8?B?ZVpkcUVJc3VldGIwRkV3YXQ0OG9GVit0ZnhvcXpDTnBFanJyZUpEQU53T01z?=
 =?utf-8?B?QSt3QWxLUVFCMlpQKzdKSzVWQ2VHcHYwZm5PUGMvdENKcUsyQms5VlV2VExx?=
 =?utf-8?B?VmtZOHlBRXdkRTV2VEFUQnE4eTA0NkZ0TWNYbHdOQ3dPTERVbkxZQTZvcFg2?=
 =?utf-8?B?WUJBY1lWdHcxdStJbTNVR1lkMFdabkZneklwd2dNbGloNnNrWGZUQmR3YVI4?=
 =?utf-8?B?ZThOSUY5VDhmclVtSU9mTHl6eWlOU29oUnpiQXdEZzBLWEVmQ3BLM2t1dzgr?=
 =?utf-8?B?RjJUOWRHbCt4VzhDSXpJL1VhUVQrdVdqQkFzR294RHduakV0N0orall1RXpS?=
 =?utf-8?B?bjlUc29nNkNQRWM4SUp0RW1DQlRUaWFkRERXOTVhdzBVVlNSWk5VVzJwczZr?=
 =?utf-8?B?NjZUSXY1ZnJmZkpOcXJTTGozNTVYUys5UndNSHhhUzJhSFZBNWZkcW1Keit5?=
 =?utf-8?B?QU9ZZUJ5NWE5dXQ5cDJ4YXl0Qmd1azRlK1hqbGtabHJlVmxKR0RpS0JpaFFV?=
 =?utf-8?B?WDhYeGlkM2kxL1hHbW0vWkxDWG5POWQ4ZHpmems5eGNxNFEzSXJrOXlzVXBZ?=
 =?utf-8?B?QXJGdi93cUhPQndRLzNsQ0dTWHJYcDhpTFF4cSt4bHNVU0ZhZVplS1NKMlR2?=
 =?utf-8?B?NytubkdnQ3pVVUtTcDNLa1Mza0ptWmNydlVyK0c1ZGNmQlF6RkhyS1dlVHJ2?=
 =?utf-8?B?ekJMNHB4eWtFcE42RjhqQVkrd3ZHemY0aktTdERKa0oyTTBrRmdkVHB6OEVC?=
 =?utf-8?B?OFVpSzA3Y1JWbnQzdEJQcjA3ZVM1aUpIRjQ1VnlxSGM1OW01Wm42YU5qdzc4?=
 =?utf-8?B?QnNwZisvNlBjaXpONjd1aHFDWnNNUmZicEEydkZJUFM4WkJMRkJzVnhyK1I4?=
 =?utf-8?B?T1JoK2xJakZJUGhBdHFxdE4zckJtZEsvVVBoK0YzR2VtUEd4YUdoZTNGYlZr?=
 =?utf-8?B?Z2E4RTMrb0l4bDdIK2wrMVFjNHk1SExHbWdVaGpMYkcxb1dYVDdrL0VZang3?=
 =?utf-8?B?SDZUMFQ4bUVsZWVsQmVURnl6VXVkdm56UEFYS2hhMzZ0NktBMStLQmg5b2Za?=
 =?utf-8?B?Q0E9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 17e0f6f7-b98f-4042-8385-08dcc8621a6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2024 19:38:05.5501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BXhJ0cA//vryHDXiuuYBtf5vmz6P0WqTQas4Af+e5Sf1JIRyMztN/NhelkbV2BIKPzf3q0cS+cfVQx1XDybcqXcTdkIB/bGdzRBBaUNFNpU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6264
X-OriginatorOrg: intel.com

SGkgTmhhdCwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOaGF0IFBo
YW0gPG5waGFtY3NAZ21haWwuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgQXVndXN0IDI5LCAyMDI0
IDEwOjExIEFNDQo+IFRvOiBTcmlkaGFyLCBLYW5jaGFuYSBQIDxrYW5jaGFuYS5wLnNyaWRoYXJA
aW50ZWwuY29tPg0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtbW1A
a3ZhY2sub3JnOw0KPiBoYW5uZXNAY21weGNoZy5vcmc7IHlvc3J5YWhtZWRAZ29vZ2xlLmNvbTsg
cnlhbi5yb2JlcnRzQGFybS5jb207DQo+IEh1YW5nLCBZaW5nIDx5aW5nLmh1YW5nQGludGVsLmNv
bT47IDIxY25iYW9AZ21haWwuY29tOyBha3BtQGxpbnV4LQ0KPiBmb3VuZGF0aW9uLm9yZzsgWm91
LCBOYW5oYWkgPG5hbmhhaS56b3VAaW50ZWwuY29tPjsgRmVnaGFsaSwgV2FqZGkgSw0KPiA8d2Fq
ZGkuay5mZWdoYWxpQGludGVsLmNvbT47IEdvcGFsLCBWaW5vZGggPHZpbm9kaC5nb3BhbEBpbnRl
bC5jb20+Ow0KPiBVc2FtYSBBcmlmIDx1c2FtYWFyaWY2NDJAZ21haWwuY29tPjsgQ2hlbmdtaW5n
IFpob3UNCj4gPGNoZW5nbWluZy56aG91QGxpbnV4LmRldj4NCj4gU3ViamVjdDogUmU6IFtQQVRD
SCB2NSAwLzNdIG1tOiBaU1dBUCBzd2FwLW91dCBvZiBtVEhQIGZvbGlvcw0KPiANCj4gT24gV2Vk
LCBBdWcgMjgsIDIwMjQgYXQgNTowNuKAr1BNIFNyaWRoYXIsIEthbmNoYW5hIFANCj4gPGthbmNo
YW5hLnAuc3JpZGhhckBpbnRlbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4NCj4gPiA+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBOaGF0IFBoYW0gPG5waGFtY3NAZ21haWwu
Y29tPg0KPiA+ID4gU2VudDogV2VkbmVzZGF5LCBBdWd1c3QgMjgsIDIwMjQgMjozNSBQTQ0KPiA+
ID4gVG86IFNyaWRoYXIsIEthbmNoYW5hIFAgPGthbmNoYW5hLnAuc3JpZGhhckBpbnRlbC5jb20+
DQo+ID4gPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtbW1Aa3ZhY2su
b3JnOw0KPiA+ID4gaGFubmVzQGNtcHhjaGcub3JnOyB5b3NyeWFobWVkQGdvb2dsZS5jb207DQo+
IHJ5YW4ucm9iZXJ0c0Bhcm0uY29tOw0KPiA+ID4gSHVhbmcsIFlpbmcgPHlpbmcuaHVhbmdAaW50
ZWwuY29tPjsgMjFjbmJhb0BnbWFpbC5jb207IGFrcG1AbGludXgtDQo+ID4gPiBmb3VuZGF0aW9u
Lm9yZzsgWm91LCBOYW5oYWkgPG5hbmhhaS56b3VAaW50ZWwuY29tPjsgRmVnaGFsaSwgV2FqZGkg
Sw0KPiA+ID4gPHdhamRpLmsuZmVnaGFsaUBpbnRlbC5jb20+OyBHb3BhbCwgVmlub2RoIDx2aW5v
ZGguZ29wYWxAaW50ZWwuY29tPg0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2NSAwLzNdIG1t
OiBaU1dBUCBzd2FwLW91dCBvZiBtVEhQIGZvbGlvcw0KPiA+ID4NCj4gPiA+IE9uIFdlZCwgQXVn
IDI4LCAyMDI0IGF0IDI6MzXigK9BTSBLYW5jaGFuYSBQIFNyaWRoYXINCj4gPiA+IDxrYW5jaGFu
YS5wLnNyaWRoYXJAaW50ZWwuY29tPiB3cm90ZToNCj4gPiA+ID4NCj4gPiA+ID4gSGkgQWxsLA0K
PiA+ID4gPg0KPiA+ID4gPiBUaGlzIHBhdGNoLXNlcmllcyBlbmFibGVzIHpzd2FwX3N0b3JlKCkg
dG8gYWNjZXB0IGFuZCBzdG9yZSBtVEhQDQo+ID4gPiA+IGZvbGlvcy4gVGhlIG1vc3Qgc2lnbmlm
aWNhbnQgY29udHJpYnV0aW9uIGluIHRoaXMgc2VyaWVzIGlzIGZyb20gdGhlDQo+ID4gPiA+IGVh
cmxpZXIgUkZDIHN1Ym1pdHRlZCBieSBSeWFuIFJvYmVydHMgWzFdLiBSeWFuJ3Mgb3JpZ2luYWwg
UkZDIGhhcyBiZWVuDQo+ID4gPiA+IG1pZ3JhdGVkIHRvIHY2LjExLXJjMyBpbiBwYXRjaCAyLzQg
b2YgdGhpcyBzZXJpZXMuDQo+ID4gPiA+DQo+ID4gPiA+IFsxXTogW1JGQyBQQVRDSCB2MV0gbW06
IHpzd2FwOiBTdG9yZSBsYXJnZSBmb2xpb3Mgd2l0aG91dCBzcGxpdHRpbmcNCj4gPiA+ID4gICAg
ICBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1tbS8yMDIzMTAxOTExMDU0My4zMjg0NjU0
LTEtDQo+ID4gPiByeWFuLnJvYmVydHNAYXJtLmNvbS9ULyN1DQo+ID4gPiA+DQo+ID4gPiA+IEFk
ZGl0aW9uYWxseSwgdGhlcmUgaXMgYW4gYXR0ZW1wdCB0byBtb2R1bGFyaXplIHNvbWUgb2YgdGhl
IGZ1bmN0aW9uYWxpdHkNCj4gPiA+ID4gaW4genN3YXBfc3RvcmUoKSwgdG8gbWFrZSBpdCBtb3Jl
IGFtZW5hYmxlIHRvIHN1cHBvcnRpbmcgYW55LW9yZGVyDQo+ID4gPiA+IG1USFBzLiBGb3IgaW5z
dGFuY2UsIHRoZSBmdW5jdGlvbiB6c3dhcF9zdG9yZV9lbnRyeSgpIHN0b3JlcyBhDQo+ID4gPiB6
c3dhcF9lbnRyeQ0KPiA+ID4gPiBpbiB0aGUgeGFycmF5LiBMaWtld2lzZSwgenN3YXBfZGVsZXRl
X3N0b3JlZF9vZmZzZXRzKCkgY2FuIGJlIHVzZWQgdG8NCj4gPiA+ID4gZGVsZXRlIGFsbCBvZmZz
ZXRzIGNvcnJlc3BvbmRpbmcgdG8gYSBoaWdoZXIgb3JkZXIgZm9saW8gc3RvcmVkIGluIHpzd2Fw
Lg0KPiA+ID4gPg0KPiA+ID4NCj4gPiA+IFdpbGwgdGhpcyBoYXZlIGFueSBjb25mbGljdCB3aXRo
IG1USFAgc3dhcCB3b3JrPyBFc3BlY2lhbGx5IHdpdGggbVRIUA0KPiA+ID4gc3dhcC1pbiBhbmQg
enN3YXAgd3JpdGViYWNrLg0KPiA+ID4NCj4gPiA+IE15IHVuZGVyc3RhbmRpbmcgaXMgZnJvbSB6
c3dhcCdzIHBlcnNwZWN0aXZlLCB0aGUgbGFyZ2UgZm9saW8gaXMNCj4gPiA+IGJyb2tlbiBhcGFy
dCBpbnRvIGluZGVwZW5kZW50IHN1YnBhZ2VzLCBjb3JyZWN0PyBXaGF0IGhhcHBlbnMgd2hlbg0K
PiB3ZQ0KPiA+ID4gaGF2ZSBwYXJ0aWFsbHkgd3JpdHRlbiBiYWNrIG1USFAgKGkuZSBzb21lIHN1
YnBhZ2VzIGFyZSBpbiB6c3dhcA0KPiA+ID4gc3RpbGwsIHdoZXJlYXMgb3RoZXJzIGFyZSB3cml0
dGVuIGJhY2sgdG8gc3dhcCkuIFdvdWxkIHRoaXMNCj4gPiA+IGF1dG9tYXRpY2FsbHkgcHJldmVu
dCBtVEhQIHN3YXBpbj8NCj4gPg0KPiA+IFRoYXQgaXMgYSBnb29kIHBvaW50LiBUbyBiZWdpbiB3
aXRoLCB0aGlzIHBhdGNoLXNlcmllcyB3b3VsZCBtYWtlIHRoZSBkZWZhdWx0DQo+ID4gYmVoYXZp
b3IgZm9yIG1USFAgc3dhcG91dC9zdG9yYWdlIGFuZCBzd2FwaW4gZm9yIFpTV0FQIHRvIGJlIG9u
IHBhcg0KPiB3aXRoDQo+ID4gWlJBTS4gRnJvbSB6c3dhcCdzIHBlcnNwZWN0aXZlLCBpbW8gdGhp
cyBpcyBhIHNpZ25pZmljYW50IHN0ZXAgZm9yd2FyZA0KPiB0b3dhcmRzDQo+ID4gcmVhbGl6aW5n
IGNvbGQgbWVtb3J5IHN0b3JhZ2Ugd2l0aCBtVEhQIGZvbGlvcy4gSG93ZXZlciwgaXQgaXMgb25s
eSBhDQo+IHN0YXJ0aW5nDQo+ID4gcG9pbnQgdGhhdCBtYWtlcyB0aGUgYmVoYXZpb3IgdW5pZm9y
bSBhY3Jvc3MgenN3YXAvenJhbS4gSW5pdGlhbGx5LA0KPiB3b3JrbG9hZHMNCj4gPiB3b3VsZCBz
ZWUgYSBvbmUtdGltZSBiZW5lZml0IHdpdGggcmVjbGFpbSBiZWluZyBhYmxlIHRvIHN3YXBvdXQg
bVRIUA0KPiA+IGZvbGlvcyB3aXRob3V0IHNwbGl0dGluZywgdG8genN3YXAuIElmIHRoZSBtVEhQ
cyB3ZXJlIGNvbGQgbWVtb3J5LCB0aGVuIHdlDQo+ID4gd291bGQgaGF2ZSBkZXJpdmVkIGxhdGVu
Y3kgZ2FpbnMgdG93YXJkcyBtZW1vcnkgc2F2aW5ncyAod2l0aCB6c3dhcCkuDQo+ID4NCj4gPiBI
b3dldmVyLCBpZiB0aGUgbVRIUCB3ZXJlIHBhcnQgb2YgIm5vdCBzbyBjb2xkIiBtZW1vcnksIHRo
aXMgd291bGQgcmVzdWx0DQo+ID4gaW4gYSBvbmUtd2F5IG1USFAgY29udmVyc2lvbiB0byA0SyBm
b2xpb3MuIERlcGVuZGluZyBvbiB3b3JrbG9hZHMgYW5kDQo+IHRoZWlyDQo+ID4gYWNjZXNzIHBh
dHRlcm5zLCB3ZSBjb3VsZCBlaXRoZXIgc2VlIGluZGl2aWR1YWwgNEsgZm9saW9zIGJlaW5nIHN3
YXBwZWQgaW4sDQo+ID4gb3IgZW50aXJlIGNodW5rcyBpZiBub3QgdGhlIGVudGlyZSAob3JpZ2lu
YWwpIG1USFAgbmVlZGluZyB0byBiZSBzd2FwcGVkIGluLg0KPiA+DQo+ID4gSXQgc2hvdWxkIGJl
IG5vdGVkIHRoYXQgdGhpcyBpcyBtb3JlIG9mIGEgcGVyZm9ybWFuY2UgdnMuIGNvbGQgbWVtb3J5
DQo+ID4gcHJlc2VydmF0aW9uIHRyYWRlLW9mZiB0aGF0IG5lZWRzIHRvIGRyaXZlIG1USFAgcmVj
bGFpbSwgc3RvcmFnZSwgc3dhcGluDQo+IGFuZA0KPiA+IHdyaXRlYmFjayBwb2xpY3kuIERpZmZl
cmVudCB3b3JrbG9hZHMgY291bGQgcmVxdWlyZSBkaWZmZXJlbnQgcG9saWNpZXMuDQo+IEhvd2V2
ZXIsDQo+ID4gZXZlbiB0aG91Z2ggdGhpcyBwYXRjaCBpcyBvbmx5IGEgc3RhcnRpbmcgcG9pbnQs
IGl0IGlzIHN0aWxsIGZ1bmN0aW9uYWxseSBjb3JyZWN0DQo+ID4gYnkgYmVpbmcgZXF1aXZhbGVu
dCB0byB6cmFtLW1USFAsIGFuZCBjb21wYXRpYmxlIHdpdGggdGhlIHJlc3Qgb2YgbW0gYW5kDQo+
ID4gc3dhcCBhcyBmYXIgYXMgbVRIUC4gQW5vdGhlciBpbXBvcnRhbnQgZnVuY3Rpb25hbGl0eS9k
YXRhIGNvbnNpc3RlbmN5DQo+IGRlY2lzaW9uDQo+ID4gSSBtYWRlIGluIHRoaXMgcGF0Y2ggc2Vy
aWVzIGlzIGVycm9yIGhhbmRsaW5nIGR1cmluZyB6c3dhcF9zdG9yZSgpIG9mIG1USFA6DQo+ID4g
aW4gY2FzZSBvZiBhbnkgZXJyb3JzLCBhbGwgc3dhcCBvZmZzZXRzIGZvciB0aGUgbVRIUCBhcmUg
ZGVsZXRlZCBmcm9tIHRoZQ0KPiA+IHpzd2FwIHhhcnJheS96cG9vbCwgc2luY2Ugd2Uga25vdyB0
aGF0IHRoZSBtVEhQIHdpbGwgbm93IGhhdmUgdG8gYmUNCj4gc3RvcmVkDQo+ID4gaW4gdGhlIGJh
Y2tpbmcgc3dhcCBkZXZpY2UuIElPVywgYW4gbVRIUCBpcyBlaXRoZXIgZW50aXJlbHkgc3RvcmVk
IGluIHpzd2FwLA0KPiA+IG9yIGVudGlyZWx5IG5vdCBzdG9yZWQgaW4genN3YXAuDQo+ID4NCj4g
PiBUbyBhbnN3ZXIgeW91ciBxdWVzdGlvbiwgd2Ugd291bGQgbmVlZCB0byBjb21lIHVwIHdpdGgg
d2hhdCB0aGUNCj4gc2VtYW50aWNzDQo+ID4gd291bGQgbmVlZCB0byBiZSBmb3IgenN3YXAgenBv
b2wgc3RvcmFnZSBncmFudWxhcml0eSwgc3dhcGluIGdyYW51bGFyaXR5LA0KPiA+IHJlYWRhaGVh
ZCBncmFudWxhcml0eSBhbmQgd3JpdGViYWNrIHdydCBtVEhQIGFuZCBob3cgdGhlIG92ZXJhbGwg
c3dhcA0KPiA+IHN1Yi1zeXN0ZW0gbmVlZHMgdG8gInByZXNlcnZlIiBtVEhQIHZzLiBzcGxpdHRp
bmcgbVRIUCBpbnRvIDRLL2xvd2VyLQ0KPiBvcmRlcg0KPiA+IGZvbGlvcyBkdXJpbmcgc3dhcG91
dC4gT25jZSB3ZSBoYXZlIGEgZ29vZCB1bmRlcnN0YW5kaW5nIG9mIHRoZXNlIHBvbGljaWVzLA0K
PiA+IHdlIGNvdWxkIGltcGxlbWVudCB0aGVtIGluIHpzd2FwLiBBbHRlcm5hdGVseSwgZGV2ZWxv
cCBhbiBhYnN0cmFjdGlvbiB0aGF0DQo+IGlzDQo+ID4gb25lIGxldmVsIGFib3ZlIHpzd2FwL3py
YW0gYW5kIG1ha2VzIHRoaW5ncyBlYXNpZXIgYW5kIHNoYXJlYWJsZQ0KPiBiZXR3ZWVuDQo+ID4g
enN3YXAgYW5kIHpyYW0uIEJ5IHRoaXMsIEkgbWVhbiBmdW5kYW1lbnRhbCBhc3N1bXB0aW9ucyBz
dWNoIGFzDQo+IGNvbnNlY3V0aXZlDQo+ID4gc3dhcCBvZmZzZXRzIChmb3IgaW5zdGFuY2UpLiBU
byBzb21lIGV4dGVudCwgdGhpcyBpbXBsaWVzIHRoYXQgYW4gbVRIUCBhcyBhDQo+ID4gc3dhcCBl
bnRpdHkgaXMgZGVmaW5lZCBieSBjb25zZWN1dGl2ZW5lc3Mgb2Ygc3dhcCBvZmZzZXRzLiBNYXli
ZSB0aGUgcG9saWN5DQo+ID4gdG8ga2VlcCBtVEhQcyBpbiB0aGUgc3lzdGVtIG92ZXIgZXh0ZW5k
ZWQgZHVyYXRpb24gbWlnaHQgYmUgdG8gYXNzZW1ibGUNCj4gPiB0aGVtIGR5bmFtaWNhbGx5IGJh
c2VkIG9uIHN3YXBpbl9yZWFkYWhlYWQoKSBkZWNpc2lvbnMgKHdoaWNoIGlzIGJhc2VkDQo+IG9u
DQo+ID4gd29ya2xvYWQgYWNjZXNzIHBhdHRlcm5zKS4gSW4gb3RoZXIgd29yZHMsIG1USFBzIGNv
dWxkIGJlIGEgdXNlZnVsDQo+IGFic3RyYWN0aW9uDQo+ID4gdGhhdCBjYW4gYmUgc3RhdGljIG9y
IGV2ZW4gZHluYW1pYyBiYXNlZCBvbiB3b3JraW5nIHNldCBjaGFyYWN0ZXJpc3RpY3MsIGFuZA0K
PiA+IGNvbGQgbWVtb3J5IHByZXNlcnZhdGlvbi4gVGhpcyBpcyBxdWl0ZSBhIGNvbXBsZXggdG9w
aWMgaW1oby4NCj4gPg0KPiA+IEFzIHdlIGtub3csIEJhcnJ5IFNvbmcgYW5kIENodWFuaHVhIEhh
biBoYXZlIHN0YXJ0ZWQgdGhlIGRpc2N1c3Npb24gb24NCj4gPiB0aGlzIGluIHRoZWlyIHpyYW0g
bVRIUCBzd2FwaW4gc2VyaWVzIFsxXS4NCj4gDQo+IFllYWggSSdtIGEgYml0IG1vcmUgY29uY2Vy
bmVkIHdpdGggdGhlIGNvcnJlY3RuZXNzIGFzcGVjdC4gQXMgbG9uZyBhcw0KPiBpdCdzIG5vdCBi
dWdneSwgdGhlbiB3ZSBjYW4gaW1wbGVtZW50IG1USFAgenN3YXBvdXQgZmlyc3QsIGFuZCBmb3Jj
ZQ0KPiBpbmRpdmlkdWFsIHN1YnBhZ2UgKHopc3dhcGluIGZvciBub3cgKHNpbmNlIHdlIGNhbm5v
dCBjb250cm9sDQo+IHdyaXRlYmFjayBmcm9tIHdyaXRpbmcgaW5kaXZpZHVhbCBzdWJwYWdlcyku
DQoNCkFic29sdXRlbHksIHRoaXMgc291bmRzIGxpa2UgdGhlIHdheSB0byBnbyENCg0KPiANCj4g
V2UgY2FuIGRpc2N1c3Mgc3RyYXRlZ3kgdG8gaGFybW9uaXplIG1USFAsIHpzd2FwICh3aXRoIHdy
aXRlYmFjaykgYXMNCj4gd2UgZ28gYWxvbmcuDQoNClNvdW5kcyBncmVhdCA6KQ0KDQo+IA0KPiBC
VFcsIEkgdGhpbmsgd2UncmUgbm90IGNjLWluZyBDaGVuZ21pbmc/IElzIHRoZSBnZXRfbWFpbnRh
aW5lcnMgc2NyaXB0DQo+IG5vdCB3b3JraW5nIHByb3Blcmx5Li4uIExldCBtZSBtYW51YWxseSBh
ZGQgaGltIGluIC0gcGxlYXNlIGluY2x1ZGUNCj4gaGltIGluIGZ1dHVyZSBzdWJtaXNzaW9uIGFu
ZCByZXNwb25zZXMsIGFzIGhlIGlzIGFsc28gYSB6c3dhcCByZXZpZXdlcg0KPiA6KQ0KDQpJIHRo
aW5rIHdoZW4gSSByYW4gZ2V0X21haW50YWluZXJzLnBsLCBJIHdhcyBpbiB2Ni4xMC4gRm9yIHN1
cmUsIHdpbGwgaW5jbHVkZQ0KQ2hlbmdtaW5nIGluIGZ1dHVyZSBzdWJtaXNzaW9ucyBhbmQgcmVz
cG9uc2VzIDopDQoNCj4gDQo+IEFsc28gY2MtaW5nIFVzYW1hIHdobyBpcyBpbnRlcmVzdGVkIGlu
IHRoaXMgd29yay4NCg0KU291bmRzIGdyZWF0Lg0KDQpUaGFua3MsDQpLYW5jaGFuYQ0KDQo+IA0K
PiA+DQo+ID4gWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI0MDgyMTA3NDU0MS41
MTYyNDktMy0NCj4gaGFuY2h1YW5odWFAb3Bwby5jb20vVC8jdQ0KPiA+DQo+ID4gVGhhbmtzLA0K
PiA+IEthbmNoYW5hDQo=

