Return-Path: <linux-kernel+bounces-334547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A5C97D89B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 18:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88BBA1C2193B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 16:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763DD17CA1B;
	Fri, 20 Sep 2024 16:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C6+zpS3H"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9CE79C0
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 16:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726851198; cv=fail; b=JfTeoGb2APyAC7lr5l5YZNV0CjpiMbjq1Wjrmuk/hYc36ouWTGQ1VFsluHFCtEzeAz2XxSFK/5L1QaDbpmFGtNLkEpQS7IwbXbpwZUawzpBWCSX+k1JG5xz3mSnMO3db3BUzLuXQl3rg3E2dj4rzfaE0nwFTWF2e36m6NpxXHi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726851198; c=relaxed/simple;
	bh=ezYy6GlXpclcTAhPejChxpo/ilOhDkAak58647YyiJ4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=swdy4m+SlGt7Uyof1XileJXpH/XjHK1HmTfR45RxC0YwX1UMYn4f6Tvhm2JcR/A8ocNDJAcMDpfX/TL0Tr7UTAJ/tcLzZsp222CRGNtPJEX9K+GzbHzjQRJgY2MrA8B9KZxl4Jvc+b/tgJhOMHNa5kC5NdMkKMKdQw8Xlpz/VkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C6+zpS3H; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726851196; x=1758387196;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ezYy6GlXpclcTAhPejChxpo/ilOhDkAak58647YyiJ4=;
  b=C6+zpS3HPyOK4jAJE07pxsy0FMTA77ga8O98GY7dMPgvEFU7dLKBzfpJ
   LN4Lhm1uFTkBGcCnjan+xybi5mV8naT9VmAvNI0BwlhVKDj12O35JsoQ2
   CcX30UiLrVNiRBP5mhn7ZsMCQ+0fik9H06q4o4pbFoV8Ta6RGEO1KW/6Z
   DvWYJu++VXPeUgHkrxIq/T60E1RXT38bA9jNbAGdcC4ZHtxkbW/Pe8h7i
   Y3dfiFJEeT9k5zWUam1qrl4uDbTovD/HgHyRacjekaSfjlRpULVfAQJno
   14Potdg0Ey08YC1xQ3SBnwro5+ey+eMQkCCZO1SuvthW04Nr3Rryjfnul
   Q==;
X-CSE-ConnectionGUID: fkHX7TCcRFOjX6GwympPnA==
X-CSE-MsgGUID: Wjd6KsodQTqO6FwEQod1uQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11201"; a="25384875"
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="25384875"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 09:53:16 -0700
X-CSE-ConnectionGUID: 1j4PpqyLT4SqiX1/lPJQvg==
X-CSE-MsgGUID: RlyJIt7dSQCt5uuQ6tzB/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="93686578"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Sep 2024 09:53:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 20 Sep 2024 09:53:14 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 20 Sep 2024 09:53:14 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 20 Sep 2024 09:53:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nPHQhcOw7JJ/FxklE8tEJbp6Uz8PNf/NjfOt0u1DlkzBewxGPpvdwTeNt9FXZ1qJjeJAk1WhC/wSgm1bmFUdW2ViwhdqgWw8qdZVWwkfZkVe+D7wvUsqX59AOCilalZ1XMwvqv1FGoTLDaaIZB5Vie2YAmrzhICnnqt0Q3RQIpDhQdeUZH8R7Us+hklE7irsMSgxf9o6giJ2YCx2EArmWVOXjO8aeXCUkbwdZ6DYcwbCmWNS4Pey/0HW85gjfowazZZ8vqMdXqxon2ZigBKi1sOewHVl/koinsNhruCkOOhj+P+UpUuyCyHXoIUNtd0qpgnysjvhNALnr43Ra0GKDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ezYy6GlXpclcTAhPejChxpo/ilOhDkAak58647YyiJ4=;
 b=Sx3j0fo3ysWN7y0XI3Jtb7PeqRKp6WAGjfe1F1ecmEtQcG05voZeYxw7uNrw7rnxb1oS5wnO8sAPHRmY4ldtZzLgRa9fiNQNEZVbq6h1ZETQbdQkR5Hb1i7JlFcXn10jylWZSY83J4scrsiwXttXUt3k3y1Xg0x7Yfzvw1o+K40oiqj+Ibl8zKjfRFVlBDu14tlN48MDUStmdpciIA8S9INsALaSuNHDk5mUyhIZCnMFOWvtEEzH0Y5KEy2FRSy50Hkk0MC3LaUNN5SeIeczPTrKQNm7S3ooxFK8E/eHZrz/BzTdSmi29jGtm7ZMWCjKaDuvKo6ZoRsXTrEnkfOFwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by DM6PR11MB4740.namprd11.prod.outlook.com (2603:10b6:5:2ad::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Fri, 20 Sep
 2024 16:53:12 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.7982.022; Fri, 20 Sep 2024
 16:53:12 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: "Huang, Ying" <ying.huang@intel.com>
CC: Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosryahmed@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "ryan.roberts@arm.com"
	<ryan.roberts@arm.com>, "21cnbao@gmail.com" <21cnbao@gmail.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "Zou, Nanhai"
	<nanhai.zou@intel.com>, "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>,
	"Gopal, Vinodh" <vinodh.gopal@intel.com>, "Sridhar, Kanchana P"
	<kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v6 0/3] mm: ZSWAP swap-out of mTHP folios
Thread-Topic: [PATCH v6 0/3] mm: ZSWAP swap-out of mTHP folios
Thread-Index: AQHa+lo8ysIDIejPvUy4b6yFKhIRqLI+1o8AgAAPzYCAISk8UIAAdzsmgAB9HzA=
Date: Fri, 20 Sep 2024 16:53:11 +0000
Message-ID: <SJ0PR11MB5678D6D34F8612F5CD86AE55C96C2@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20240829212705.6714-1-kanchana.p.sridhar@intel.com>
	<CAJD7tkaqp_3YbK_qsq+v2=Q0r4xwTG9PbbPYjQdpTBu_Z7K5_A@mail.gmail.com>
	<CAKEwX=PXvLZ0GBgBbxSX5qvB-5dYuQ=5Z88UN3oGmNxFMnMtrg@mail.gmail.com>
	<SJ0PR11MB567839F1CB09EBD24921AA20C96C2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <87msk2vgd4.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87msk2vgd4.fsf@yhuang6-desk2.ccr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|DM6PR11MB4740:EE_
x-ms-office365-filtering-correlation-id: 2e668209-8db4-4826-9619-08dcd994b67a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NkczejFRTUUvS01rZ3prdExiQitZM0Fld0ZMcU1NSzJSN25nZi9MOEtZdk9B?=
 =?utf-8?B?a1ZXazZ3VEJpSUV2VFY3cjAzWlZSUUYxRDFPZDMyMVdveVcyRk1LelVQTDJU?=
 =?utf-8?B?OW1JRzdZQzdRK0tLQi9oT2ZGa2plTTJCVCs4WG41VFp4YmpuMDh5VVpsMmRa?=
 =?utf-8?B?ZkdSdHJtRDVnenlGR0plcUxTQ0pMSzFwM2Y5RUo4cU1ZcEtjWm5EV0xhR2pu?=
 =?utf-8?B?ODBRZ0hrS1NJZFVWR295YTZEeDVCN0xPeTI4ZExVSnhYdHNwZ3VVZTFBOUlT?=
 =?utf-8?B?TkRSUXc3cGg3alB4ME9HbVViTEp4Q2JVL2wxQVh6R1ppVUJRclB4U1ZQL0Fm?=
 =?utf-8?B?NWZnditaeTVzQ2VMd00ySXc2aE1WV0dRN3pRYlFteU0xcDAzWjFOQmZQSmpk?=
 =?utf-8?B?eVRkbkJYcWx1VmljdVAwYllnWGhEbnV0NENocmhjdzNaQ0FiaW5IOWhyS0dv?=
 =?utf-8?B?cUg5alRqMDl1b0loT1dSNUQ4dVVEQTAvcU02aVVvZFhWcXhsaU0vbUtaSmJo?=
 =?utf-8?B?dzBMcldnWi9sS0lLTUthVWZ4VVowZkhKbmtQVmtMNlFQeFczWEVSV0ZpUUEw?=
 =?utf-8?B?Rzd3aXQ4dzlIeWJxbnREOGJXckp4MTBYeWFXSzc2bWQ1VEtDcmhUU1B2U3Nw?=
 =?utf-8?B?VXplWEQzNHpsRmo2eTJWeElmOGJOMlFpdUZqTHFDMm5QRGxtNC8rNEVsUDUx?=
 =?utf-8?B?ckUyeGx3bFlJdnB0WlgvUklJQW1tcGpCM0xST1BhN0pGWHgvQWprL2xOVXN3?=
 =?utf-8?B?Wk8rcld2Q1dtSUZqVEZadTAwelE0YUozVy9WS3lTa2J1TnM0Z25DZVllUEZU?=
 =?utf-8?B?MzdPcmQ3UVZtRGRYa3dGVVhnRElBcWRBTmphMnZmSlZIcjZtYVZEYm14dGVx?=
 =?utf-8?B?NUJtUzQ0OWx2ZVE0WG1VdE9BSWhOVThhYURPV0xXSElqUHFDTENTZDllblA3?=
 =?utf-8?B?dG5WVXUrU21YRkczcVBiMk5zOExkZ3pNNkZZUnkxQm9GNUw1L2FGWTJXWEJ2?=
 =?utf-8?B?QW9ja1RLOVl4QjZuNkJoZHk5ZXVHODFEMUJ3c0VxYXlleG9xOHgrSThjYStx?=
 =?utf-8?B?am9abkZlRFlaa0ZLaEpsWTV3MjVreHZ2c3JRNmdNQjVOMUtoZUc2bzltcE8w?=
 =?utf-8?B?ck5aeGFXVkhVbklkcUR6LzczNnhURkdmc09CVHo2aGxNRzl6c09iTXgvaVpq?=
 =?utf-8?B?bkVOVFBLd082K0pVcmVSeHg0WTk2Lzd5eG5Md05pcjNONG5ZeEJBYVZKMjVo?=
 =?utf-8?B?VkdXbkpUZnVKSmlSUDkyNGhGc3oyN2tTS0NOVUtNUjYyeGpnRFNWUlB4cDFQ?=
 =?utf-8?B?ZzN5YjhLa0J1NWk5RTZrODNua05uMk5NSmFJZ0t0NUpJaXA4NGJQMlRpb1FB?=
 =?utf-8?B?UWZ0OGtIM0pPMWtleTdxc1lHSXVGR3FlWTBQSVNDWGoyYUZubmRyMzgrQ09B?=
 =?utf-8?B?YllPNjRvWDlmL21XSDRZL2Q5cDJOT1p6cCtUNDlNQlZVZVVZUVE0VVF1TTBR?=
 =?utf-8?B?dk00Z0R5UmUwTVc2VUJyeTBmQ0tYYXlzWDBqTUhGbjlGK21MZG9YOGNOWk1k?=
 =?utf-8?B?WTVJWWtSSjlsTHo1YTFOUUNISEhlc0JuajlzWEJFMXQ4SFFwQ1k1ajFXRWJR?=
 =?utf-8?B?ZytqTHhSMVllMStjZU1RclhDRjZ5YVQ3OFdmS2lCVFJIUE02TUdXSWhLMzhO?=
 =?utf-8?B?NjFCay9EL2paY2crMnJWcnhPdHhUa3FGajgwdy9YSE9hVTJHQ1Z6Nmxhc0tZ?=
 =?utf-8?B?M3R4U0xEL2QwZXlaeGNMcm9oQ2NpYVpKZ3ZjSzlFSG1zNTVKeHJPMkhvZHF4?=
 =?utf-8?B?cEhvUEx6eG8rTmlhMkx5cjZCYUxiRUdycDAvNTBTRmY3QTJOZXdRYUZMRDRK?=
 =?utf-8?B?Vmg0RGRnLzVwVTVJQ3I1OXFmYXEwa2QwRmZuV3QyR2JOcUE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z3RKVENvT3VqdzBqVENzQkdzMklMeE53dUlIZmhlb2tqcThjZUwyVDg1YTEy?=
 =?utf-8?B?aFNwQTZ3L3NkN1F5OHJrclN2RS8yNkc0Q0s0RVJXV2JpZHpvS1A5OWt4NXVH?=
 =?utf-8?B?MEFMTityMXpIYURYZW0zOWdyQVptMzE3QjFhb09DeENhZStTeDBzVmt5SnhM?=
 =?utf-8?B?VG1BYWxqKzZaK2JoY3VhWXM5MjJHMWFIc3RIMlVqWjhxZmRHeTVOVUQ5RS9C?=
 =?utf-8?B?RjkwbVhVZ3BaUkZCek45NkxOUXp3TDdSVU03U29KR0ptYkVpN0h0MnhQM0Zn?=
 =?utf-8?B?anorSVFQWjR3aFBrQndLVWRVSUM1L2gvMjJjS29GSjlTTWp5N3lKTHRPZnVt?=
 =?utf-8?B?SVBFMk5Vb1c1ZWhYZ1h5V2lUYnZYZmo0Nis1L0NKZXBsQlpoRndoUDhqR1I2?=
 =?utf-8?B?Q1QvWnIvYkhweXhuV0V2cDY2dk5QcS9vM2hDUUJDM0ZTQ3FZenBCaW5nMDky?=
 =?utf-8?B?RWFKbWI0WC8yaFZMMVZ1WG5pcGs1SVhYM1oyQ2hIbkxnNE0xT20zWlJDN1pl?=
 =?utf-8?B?KzhtL0MwSVZXdXVRR0tkOUxHeitoeFhSOHJ4dk84Y2pseWlOcW1VbHNkSEky?=
 =?utf-8?B?WVhtV3hnNVRuTVl2UDA1dm1QQ0xOMS9hTVpQNFIyT1FRZDFtWFp1bHQ0QXJO?=
 =?utf-8?B?a1A1MnJ6aHh5ajVRcHg2OFVvUEJNejd0QWNhd2dPYmRoK1RCbXNxaFVFK1M3?=
 =?utf-8?B?ZEZlL21BMThLTEhaS0FIaU9mK1ViUXYzQXNra3F2SDUxcjUzZHFIUUdpaTlN?=
 =?utf-8?B?YVNnaUFEcmd3RmVDMTkzdkZDVEE4eVkvNnVyOHd4ZkU3OGMxUTRiOEt1alM1?=
 =?utf-8?B?ZTVhR256S3Zydk1BRmI2TWsxQW56U1FqVWZZTnVyb250S1JvQXVLN2M1MFFz?=
 =?utf-8?B?Y2hrUTVHQkhxN3FjZlJqdUp6ak1mbHRETTQ2eFo4Zm9pYXFBYUxWcE90UzZE?=
 =?utf-8?B?TmFLdnlkU2tMVHBnZUs5R3RmN2hZMVgraE9XYVpIL3ErZFpvY2cvTXo2VUU1?=
 =?utf-8?B?TVcxdEgzS091akJINGEyRi9TUWNEb1pTaHNUR0k4MWtVa2F1Zis4bTkvR1NS?=
 =?utf-8?B?TSs3SXZoQjJPa0hkbTZLcUdxNmhJejVwRkp0MTc4THBETHJtcUNGU1ZmR1RN?=
 =?utf-8?B?b2N1QXQ3VmoxMWROTWdKOWN6VFNKY0FodU4weVhmbTc1WWw1aUJiQTcxV3Ra?=
 =?utf-8?B?RmswN3pUQWpERmJPVEFCKzlWSkdXRTdSMTdOY08xYWpmQlhZK1psdmZRRDNM?=
 =?utf-8?B?bDJ0MDQyb3d2ejUvZUhyeGR1YUZLOWFKZWxDSVlvNUJ0V1Q0UDJkLzdhSVVT?=
 =?utf-8?B?S29DR1RUSCtyNkphamdsVEdrdFNkUWdRQ1IvUHFIbm1vdm5JOHhicmpORnBD?=
 =?utf-8?B?V0YxUjVJQ3c1d0p0bDdnSVVpc2tVVDZET2NNR0cyY01rMjBveFJIWmg3VWRz?=
 =?utf-8?B?SWxoU29YSHVVdkthaCs4V05ZWjAwbHdJVEJDTTltbWUyMzEvTHhVTjJnRGNi?=
 =?utf-8?B?cVlXc0V4QkNUWWpieHNSdm9RUUc3SUUvRDAwNnFGUGlUWkhoV3E4a2t0eEpn?=
 =?utf-8?B?Nmk4VmdybVNPNHFnVnZOYmhFSVNSQWlGL3lIUm12NkI4MHcvdnlUMzY4aDBn?=
 =?utf-8?B?blgwMkVwRGNaVzMrSWZkU0JiaDhjTGkvVW9oZVVERHNXZ3NWZmc2VDluWG1t?=
 =?utf-8?B?eGtydnhKNEdUUE1FcU5JQXZhUjV1ZW1iWi9seU10RFd6cktybDMzTVJkbko4?=
 =?utf-8?B?MXFhVU9ObmZCSGJWMGFlcTBHOTgvMnZKYU93WnorUVoxVWV3cEtxelV0dDBF?=
 =?utf-8?B?MW5qbld4KzNnaENZQTg2Uzl3NDVodkVKaEM3OEZZNU4yOTNkdjMwUVVtdzJa?=
 =?utf-8?B?TGVWV0xRa2lmeE01UjBPT3F0RWV1WEU0b1dBbzl1TjA3clVKWFFIYllieG5j?=
 =?utf-8?B?bW1IVFpIZ25rVnlHeHpGU3FuLytkQkdpcUhEbk4raTRQNnlNRWR2YVhOMlls?=
 =?utf-8?B?RllzUHJybFIxVVJBU1ptOElyeVA1WVdQY2w0TlpIY0RLTENhVVNzMVQrZnBD?=
 =?utf-8?B?aHpESEZQblY1T2lJeVM1Tmh2Z1NKRVI1WmpUbWppanA4VFhzbTRtK2o0R3RW?=
 =?utf-8?B?QitRQzMwRlYxZXdrQWJrdHlJK2RYTjRSVmk3bmVwMHV3cExLSWtNTTYvbUE4?=
 =?utf-8?B?ZVE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e668209-8db4-4826-9619-08dcd994b67a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2024 16:53:11.9501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lijOb8hV6QkTufLnRijPdXvPAH7ijvP4XKwKPaeAXvQK8OZIxKyFs5U6LCKTB0O0GKl1qkBQn0pOGMNn0p09qnuI2XPH4uYwTKHM14qlQg4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4740
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBIdWFuZywgWWluZyA8eWluZy5o
dWFuZ0BpbnRlbC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgU2VwdGVtYmVyIDIwLCAyMDI0IDI6MTIg
QU0NCj4gVG86IFNyaWRoYXIsIEthbmNoYW5hIFAgPGthbmNoYW5hLnAuc3JpZGhhckBpbnRlbC5j
b20+DQo+IENjOiBOaGF0IFBoYW0gPG5waGFtY3NAZ21haWwuY29tPjsgWW9zcnkgQWhtZWQNCj4g
PHlvc3J5YWhtZWRAZ29vZ2xlLmNvbT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxp
bnV4LQ0KPiBtbUBrdmFjay5vcmc7IGhhbm5lc0BjbXB4Y2hnLm9yZzsgY2hlbmdtaW5nLnpob3VA
bGludXguZGV2Ow0KPiB1c2FtYWFyaWY2NDJAZ21haWwuY29tOyByeWFuLnJvYmVydHNAYXJtLmNv
bTsgMjFjbmJhb0BnbWFpbC5jb207DQo+IGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc7IFpvdSwg
TmFuaGFpIDxuYW5oYWkuem91QGludGVsLmNvbT47IEZlZ2hhbGksDQo+IFdhamRpIEsgPHdhamRp
LmsuZmVnaGFsaUBpbnRlbC5jb20+OyBHb3BhbCwgVmlub2RoDQo+IDx2aW5vZGguZ29wYWxAaW50
ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY2IDAvM10gbW06IFpTV0FQIHN3YXAtb3V0
IG9mIG1USFAgZm9saW9zDQo+IA0KPiAiU3JpZGhhciwgS2FuY2hhbmEgUCIgPGthbmNoYW5hLnAu
c3JpZGhhckBpbnRlbC5jb20+IHdyaXRlczoNCj4gDQo+ID4gSGkgTmhhdCwNCj4gPg0KPiA+PiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBOaGF0IFBoYW0gPG5waGFtY3NA
Z21haWwuY29tPg0KPiA+PiBTZW50OiBUaHVyc2RheSwgQXVndXN0IDI5LCAyMDI0IDQ6NDYgUE0N
Cj4gPj4gVG86IFlvc3J5IEFobWVkIDx5b3NyeWFobWVkQGdvb2dsZS5jb20+DQo+ID4+IENjOiBT
cmlkaGFyLCBLYW5jaGFuYSBQIDxrYW5jaGFuYS5wLnNyaWRoYXJAaW50ZWwuY29tPjsgbGludXgt
DQo+ID4+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LW1tQGt2YWNrLm9yZzsgaGFubmVz
QGNtcHhjaGcub3JnOw0KPiA+PiBjaGVuZ21pbmcuemhvdUBsaW51eC5kZXY7IHVzYW1hYXJpZjY0
MkBnbWFpbC5jb207DQo+ID4+IHJ5YW4ucm9iZXJ0c0Bhcm0uY29tOyBIdWFuZywgWWluZyA8eWlu
Zy5odWFuZ0BpbnRlbC5jb20+Ow0KPiA+PiAyMWNuYmFvQGdtYWlsLmNvbTsgYWtwbUBsaW51eC1m
b3VuZGF0aW9uLm9yZzsgWm91LCBOYW5oYWkNCj4gPj4gPG5hbmhhaS56b3VAaW50ZWwuY29tPjsg
RmVnaGFsaSwgV2FqZGkgSyA8d2FqZGkuay5mZWdoYWxpQGludGVsLmNvbT47DQo+ID4+IEdvcGFs
LCBWaW5vZGggPHZpbm9kaC5nb3BhbEBpbnRlbC5jb20+DQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggdjYgMC8zXSBtbTogWlNXQVAgc3dhcC1vdXQgb2YgbVRIUCBmb2xpb3MNCj4gPj4NCj4gPj4g
T24gVGh1LCBBdWcgMjksIDIwMjQgYXQgMzo0OeKAr1BNIFlvc3J5IEFobWVkDQo+IDx5b3NyeWFo
bWVkQGdvb2dsZS5jb20+DQo+ID4+IHdyb3RlOg0KPiA+PiA+DQo+ID4+ID4gT24gVGh1LCBBdWcg
MjksIDIwMjQgYXQgMjoyN+KAr1BNIEthbmNoYW5hIFAgU3JpZGhhcg0KPiA+PiA+DQo+ID4+ID4g
V2UgYXJlIGJhc2ljYWxseSBjb21wYXJpbmcgenJhbSB3aXRoIHpzd2FwIGluIHRoaXMgY2FzZSwg
YW5kIGl0J3Mgbm90DQo+ID4+ID4gZmFpciBiZWNhdXNlLCBhcyB5b3UgbWVudGlvbmVkLCB0aGUg
enN3YXAgY29tcHJlc3NlZCBkYXRhIGlzIGJlaW5nDQo+ID4+ID4gYWNjb3VudGVkIGZvciB3aGls
ZSB0aGUgenJhbSBjb21wcmVzc2VkIGRhdGEgaXNuJ3QuIEkgYW0gbm90IHJlYWxseQ0KPiA+PiA+
IHN1cmUgaG93IHZhbHVhYmxlIHRoZXNlIHRlc3QgcmVzdWx0cyBhcmUuIEV2ZW4gaWYgd2UgcmVt
b3ZlIHRoZSBjZ3JvdXANCj4gPj4gPiBhY2NvdW50aW5nIGZyb20genN3YXAsIHdlIHdvbid0IHNl
ZSBhbiBpbXByb3ZlbWVudCwgd2Ugc2hvdWxkDQo+IGV4cGVjdCBhDQo+ID4+ID4gc2ltaWxhciBw
ZXJmb3JtYW5jZSB0byB6cmFtLg0KPiA+PiA+DQo+ID4+ID4gSSB0aGluayB0aGUgdGVzdCByZXN1
bHRzIHRoYXQgYXJlIHJlYWxseSB2YWx1YWJsZSBhcmUgY2FzZSAxLCB3aGVyZQ0KPiA+PiA+IHpz
d2FwIHVzZXJzIGFyZSBjdXJyZW50bHkgZGlzYWJsaW5nIENPTkZJR19USFBfU1dBUCwgYW5kIGdl
dCB0bw0KPiBlbmFibGUNCj4gPj4gPiBpdCBhZnRlciB0aGlzIHNlcmllcy4NCj4gPj4NCj4gPj4g
QWgsIHRoaXMgaXMgYSBnb29kIHBvaW50Lg0KPiA+Pg0KPiA+PiBJIHRoaW5rIHRoZSBwb2ludCBv
ZiBjb21wYXJpbmcgbVRIUCB6c3dhcCB2LnMgbVRIUCAoU1NEKXN3YXAgaXMgbW9yZQ0KPiA+PiBv
ZiBhIHNhbml0eSBjaGVjay4gSU9XLCBpZiBtVEhQIHN3YXAgb3V0cGVyZm9ybXMgbVRIUCB6c3dh
cCwgdGhlbg0KPiA+PiBzb21ldGhpbmcgaXMgd3JvbmcgKG90aGVyd2lzZSB3aHkgd291bGQgZW5h
YmxlIHpzd2FwIC0gbWlnaHQgYXMgd2VsbA0KPiA+PiBqdXN0IHVzZSBzd2FwLCBzaW5jZSBTU0Qg
c3dhcCB3aXRoIG1USFAgPj4+IHpzd2FwIHdpdGggbVRIUCA+Pj4NCj4genN3YXANCj4gPj4gd2l0
aG91dCBtVEhQKS4NCj4gPj4NCj4gPj4gVGhhdCBzYWlkLCBJIGRvbid0IHRoaW5rIHRoaXMgYmVu
Y2htYXJrIGNhbiBzaG93IGl0IGFueXdheS4gVGhlIGFjY2Vzcw0KPiA+PiBwYXR0ZXJuIGhlcmUg
aXMgc3VjaCB0aGF0IGFsbCB0aGUgYWxsb2NhdGVkIG1lbW9yaWVzIGFyZSByZWFsbHkgY29sZCwN
Cj4gPj4gc28gc3dhcCB0byBkaXNrIChvciB0byB6cmFtLCB3aGljaCBkb2VzIG5vdCBhY2NvdW50
IG1lbW9yeSB1c2FnZQ0KPiA+PiB0b3dhcmRzIGNncm91cCkgaXMgYmV0dGVyIGJ5IGRlZmluaXRp
b24uLi4gQW5kIEthbmNoYW5hIGRvZXMgbm90IHNlZW0NCj4gPj4gdG8gaGF2ZSBhY2Nlc3MgdG8g
c2V0dXAgd2l0aCBsYXJnZXIgU1NEIHN3YXBmaWxlcz8gOikNCj4gPg0KPiA+IEFzIGZvbGxvdyB1
cCwgSSBjcmVhdGVkIGEgc3dhcGZpbGUgb24gZGlzayB0byBpbmNyZWFzZSB0aGUgU1NEIHN3YXAg
dG8gMTc5Ry4NCj4gDQo+IEFyZSB5b3Ugc3VyZSB5b3UgdXNlZCBzd2FwZmlsZSBpbnN0ZWFkIG9m
IGEgc3dhcCBwYXJ0aXRpb24/ICBGcm9tIHRoZQ0KPiBmb2xsb3dpbmcgY29kZSBpbiBzY2FuX3N3
YXBfbWFwX3Nsb3RzKCksDQo+IA0KPiAJaWYgKG9yZGVyID4gMCkgew0KPiAJCS8qDQo+IAkJICog
U2hvdWxkIG5vdCBldmVuIGJlIGF0dGVtcHRpbmcgbGFyZ2UgYWxsb2NhdGlvbnMgd2hlbiBodWdl
DQo+IAkJICogcGFnZSBzd2FwIGlzIGRpc2FibGVkLiAgV2FybiBhbmQgZmFpbCB0aGUgYWxsb2Nh
dGlvbi4NCj4gCQkgKi8NCj4gCQlpZiAoIUlTX0VOQUJMRUQoQ09ORklHX1RIUF9TV0FQKSB8fA0K
PiAJCSAgICBucl9wYWdlcyA+IFNXQVBGSUxFX0NMVVNURVIpIHsNCj4gCQkJVk1fV0FSTl9PTl9P
TkNFKDEpOw0KPiAJCQlyZXR1cm4gMDsNCj4gCQl9DQo+IA0KPiAJCS8qDQo+IAkJICogU3dhcGZp
bGUgaXMgbm90IGJsb2NrIGRldmljZSBvciBub3QgdXNpbmcgY2x1c3RlcnMgc28gdW5hYmxlDQo+
IAkJICogdG8gYWxsb2NhdGUgbGFyZ2UgZW50cmllcy4NCj4gCQkgKi8NCj4gCQlpZiAoIShzaS0+
ZmxhZ3MgJiBTV1BfQkxLREVWKSB8fCAhc2ktPmNsdXN0ZXJfaW5mbykNCj4gCQkJcmV0dXJuIDA7
DQo+IAl9DQo+IA0KPiBsYXJnZSBmb2xpbyB3aWxsIGJlIHNwbGl0IGZvciBzd2FwZmlsZS4NCg0K
SSBzZWUuIFRoYW5rcyBmb3IgdGhpcyBjbGFyaWZpY2F0aW9uLiBObywgdGhpcyBpcyBhIGNvbmZp
Z3VyYXRpb24gd2l0aA0KMTc1RyBzd2FwZmlsZSBvbiBkaXNrICsgNEcgU1NELiBMYXJnZSBmb2xp
b3MgYmVpbmcgc3BsaXQgZm9yIHN3YXBmaWxlDQpwcm9iYWJseSBleHBsYWlucyB0aGUgbWVtY2df
c3dhcF9mYWlsIGNvdW50cyBpbiB0aGlzIGNhc2UuDQoNClRoYW5rcywNCkthbmNoYW5hDQoNCj4g
DQo+IC0tDQo+IEJlc3QgUmVnYXJkcywNCj4gSHVhbmcsIFlpbmcNCj4gDQo+ID4gIDY0S0IgbVRI
UCAoY2dyb3VwIG1lbW9yeS5oaWdoIHNldCB0byA0MEcsIG5vIHN3YXAgbGltaXQpOg0KPiA+ICA9
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0N
Cj4gPiAgQ09ORklHX1RIUF9TV0FQPVkNCj4gPiAgU2FwcGhpcmUgUmFwaWRzIHNlcnZlciB3aXRo
IDUwMyBHaUIgUkFNIGFuZCAxNzlHIFNTRCBzd2FwIGJhY2tpbmcNCj4gZGV2aWNlDQo+ID4gIGZv
ciB6c3dhcC4NCj4gPg0KPiA+ICB1c2VtZW0gLS1pbml0LXRpbWUgLXcgLU8gLS1zbGVlcCAwIC1u
IDcwIDFnOg0KPiA+DQo+ID4gIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiAgICAgICAgICAg
ICAgICAgICAgIG1tLXVuc3RhYmxlIDktMTctMjAyNCAgICAgICAgICAgenN3YXAtbVRIUCB2NiAg
ICAgQ2hhbmdlIHdydA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEJhc2Vs
aW5lICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEJhc2VsaW5lDQo+ID4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgImJlZm9yZSIgICAgICAgICAgICAgICAgICJhZnRlciIg
ICAgICAoc2xlZXAgMCkNCj4gPiAgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ICBaU1dBUCBj
b21wcmVzc29yICAgICAgIHpzdGQgICAgIGRlZmxhdGUtICAgICAgICB6c3RkICAgIGRlZmxhdGUt
ICB6c3RkIGRlZmxhdGUtDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBpYWEgICAgICAgICAgICAgICAgICAgICBpYWEgICAgICAgICAgICBpYWENCj4gPiAgLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQ0KPiA+ICBUaHJvdWdocHV0IChLQi9zKSAgICA5MywyNzMgICAgICAg
ODgsNDk2ICAgICAxNDMsMTE3ICAgICAxMzQsMTMxICAgIDUzJSAgICAgNTIlDQo+ID4gIHN5cyB0
aW1lIChzZWMpICAgICAgIDMxNi42OCAgICAgICAzNDkuMDAgICAgICA5MTcuODggICAgICA4Nzcu
NzQgIC0xOTAlICAgLTE1MiUNCj4gPiAgbWVtY2dfaGlnaCAgICAgICAgICAgNzMsODM2ICAgICAg
IDgzLDUyMiAgICAgMTI2LDEyMCAgICAgMTMzLDAxMw0KPiA+ICBtZW1jZ19zd2FwX2ZhaWwgICAg
IDI2MSwxMzYgICAgICAzMjQsNTMzICAgICA0OTQsMTkxICAgICA1NzgsODI0DQo+ID4gIHBzd3Bp
biAgICAgICAgICAgICAgICAgICAxNiAgICAgICAgICAgMTEgICAgICAgICAgIDAgICAgICAgICAg
IDANCj4gPiAgcHN3cG91dCAgICAgICAgICAgMSwyNDIsMTg3ICAgIDEsMjYzLDQ5MyAgICAgICAg
ICAgMCAgICAgICAgICAgMA0KPiA+ICB6c3dwaW4gICAgICAgICAgICAgICAgICA2OTQgICAgICAg
ICAgNjY4ICAgICAgICAgNzEyICAgICAgICAgNzAyDQo+ID4gIHpzd3BvdXQgICAgICAgICAgIDMs
OTkxLDQwMyAgICA0LDkzMyw5MDEgICA5LDI4OSwwOTIgIDEwLDQ2MSw5NDgNCj4gPiAgdGhwX3N3
cG91dCAgICAgICAgICAgICAgICAwICAgICAgICAgICAgMCAgICAgICAgICAgMCAgICAgICAgICAg
MA0KPiA+ICB0aHBfc3dwb3V0XyAgICAgICAgICAgICAgIDAgICAgICAgICAgICAwICAgICAgICAg
ICAwICAgICAgICAgICAwDQo+ID4gICBmYWxsYmFjaw0KPiA+ICBwZ21hamZhdWx0ICAgICAgICAg
ICAgMyw0ODggICAgICAgIDMsMzUzICAgICAgIDMsMzc3ICAgICAgIDMsNDk5DQo+ID4gIFpTV1BP
VVQtNjRrQiAgICAgICAgICAgIG4vYSAgICAgICAgICBuL2EgICAgIDExMCwwNjcgICAgIDEwMyw5
NTcNCj4gPiAgU1dQT1VULTY0a0IgICAgICAgICAgNzcsNjM3ICAgICAgIDc4LDk2OCAgICAgICAg
ICAgMCAgICAgICAgICAgMA0KPiA+ICAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4NCj4gPiBX
ZSBkbyBzZWUgNTAlIHRocm91Z2hwdXQgaW1wcm92ZW1lbnQgd2l0aCBtVEhQLXpzd2FwIHdydCBt
VEhQLVNTRC4NCj4gPiBUaGUgc3lzIHRpbWUgaW5jcmVhc2UgY2FuIGJlIGF0dHJpYnV0ZWQgdG8g
aGlnaGVyIHN3YXBvdXQgYWN0aXZpdHkNCj4gPiBvY2N1cnJpbmcgd2l0aCB6c3dhcC1tVEhQLg0K
PiA+DQo+ID4gSSBob3BlIHRoaXMgcXVhbnRpZmllcyB0aGUgYmVuZWZpdCBvZiBtVEhQLXpzd2Fw
IHdydCBtVEhQLVNTRCBpbiBhDQo+ID4gbm9uLXN3YXAtY29uc3RyYWluZWQgc2V0dXAuIFRoZSA0
RyBTU0Qgc3dhcCBzZXR1cCBkYXRhIEkgc2hhcmVkDQo+ID4gaW4gbXkgcmVzcG9uc2UgdG8gWW9z
cnkgYWxzbyBpbmRpY2F0ZXMgYmV0dGVyIHRocm91Z2hwdXQgd2l0aCBtVEhQLXpzd2FwDQo+ID4g
YXMgY29tcGFyZWQgdG8gbVRIUC1TU0QuDQo+ID4NCj4gPiBQbGVhc2UgZG8gbGV0IG1lIGtub3cg
aWYgeW91IGhhdmUgYW55IG90aGVyIHF1ZXN0aW9ucy9zdWdnZXN0aW9ucy4NCj4gPg0KPiA+IFRo
YW5rcywNCj4gPiBLYW5jaGFuYQ0KPiA+DQo+ID4+DQo+ID4+ID4NCj4gPj4gPiBJZiB3ZSByZWFs
bHkgd2FudCB0byBjb21wYXJlIENPTkZJR19USFBfU1dBUCBvbiBiZWZvcmUgYW5kIGFmdGVyLCBp
dA0KPiA+PiA+IHNob3VsZCBiZSB3aXRoIFNTRCBiZWNhdXNlIHRoYXQncyBhIG1vcmUgY29udmVu
dGlvbmFsIHNldHVwLiBJbiB0aGlzDQo+ID4+ID4gY2FzZSB0aGUgdXNlcnMgdGhhdCBoYXZlIENP
TkZJR19USFBfU1dBUD15IG9ubHkgZXhwZXJpZW5jZSB0aGUNCj4gPj4gPiBiZW5lZml0cyBvZiB6
c3dhcCB3aXRoIHRoaXMgc2VyaWVzLiBZb3UgbWVudGlvbmVkIGV4cGVyaW1lbnRpbmcgd2l0aA0K
PiA+PiA+IHVzZW1lbSB0byBrZWVwIHRoZSBtZW1vcnkgYWxsb2NhdGVkIGxvbmdlciBzbyB0aGF0
IHlvdSdyZSBhYmxlIHRvIGhhdmUNCj4gPj4gPiBhIGZhaXIgdGVzdCB3aXRoIHRoZSBzbWFsbCBT
U0Qgc3dhcCBzZXR1cC4gRGlkIHRoYXQgd29yaz8NCj4gPj4gPg0KPiA+PiA+IEkgYW0gaG9waW5n
IE5oYXQgb3IgSm9oYW5uZXMgd291bGQgc2hlZCBzb21lIGxpZ2h0IG9uIHdoZXRoZXIgdGhleQ0K
PiA+PiA+IHVzdWFsbHkgaGF2ZSBDT05GSUdfVEhQX1NXQVAgZW5hYmxlZCBvciBub3Qgd2l0aCB6
c3dhcC4gSSBhbSB0cnlpbmcNCj4gdG8NCj4gPj4gPiBmaWd1cmUgb3V0IGlmIGFueSByZWFzb25h
YmxlIHNldHVwcyBlbmFibGUgQ09ORklHX1RIUF9TV0FQIHdpdGgNCj4genN3YXAuDQo+ID4+ID4g
T3RoZXJ3aXNlIHRoZSB0ZXN0aW5nIHJlc3VsdHMgZnJvbSBjYXNlIDEgc2hvdWxkIGJlIHN1ZmZp
Y2llbnQuDQo+ID4+ID4NCj4gPj4gPiA+DQo+ID4+ID4gPiBJbiBteSBvcGluaW9uLCBldmVuIHRo
b3VnaCB0aGUgdGVzdCBzZXQgdXAgZG9lcyBub3QgcHJvdmlkZSBhbg0KPiBhY2N1cmF0ZQ0KPiA+
PiA+ID4gd2F5IGZvciBhIGRpcmVjdCBiZWZvcmUvYWZ0ZXIgY29tcGFyaXNvbiAoYmVjYXVzZSBv
ZiB6c3dhcCB1c2FnZQ0KPiBiZWluZw0KPiA+PiA+ID4gY291bnRlZCBpbiBjZ3JvdXAsIGhlbmNl
IHRvd2FyZHMgdGhlIG1lbW9yeS5oaWdoKSwgaXQgc3RpbGwgc2VlbXMNCj4gPj4gPiA+IHJlYXNv
bmFibGUgZm9yIHpzd2FwX3N0b3JlIHRvIHN1cHBvcnQgKG0pVEhQLCBzbyB0aGF0IGZ1cnRoZXIN
Cj4gPj4gcGVyZm9ybWFuY2UNCj4gPj4gPiA+IGltcHJvdmVtZW50cyBjYW4gYmUgaW1wbGVtZW50
ZWQuDQo+ID4+ID4NCj4gPj4gPiBUaGlzIGlzIG9ubHkgcmVmZXJyaW5nIHRvIHRoZSByZXN1bHRz
IG9mIGNhc2UgMiwgcmlnaHQ/DQo+ID4+ID4NCj4gPj4gPiBIb25lc3RseSwgSSB3b3VsZG4ndCB3
YW50IHRvIG1lcmdlIG1USFAgc3dhcG91dCBzdXBwb3J0IG9uIGl0cyBvd24NCj4gPj4gPiBqdXN0
IGJlY2F1c2UgaXQgZW5hYmxlcyBmdXJ0aGVyIHBlcmZvcm1hbmNlIGltcHJvdmVtZW50cyB3aXRo
b3V0DQo+ID4+ID4gaGF2aW5nIGFjdHVhbCBwYXRjaGVzIGZvciB0aGVtLiBCdXQgSSBkb24ndCB0
aGluayB0aGlzIGNhcHR1cmVzIHRoZQ0KPiA+PiA+IHJlc3VsdHMgYWNjdXJhdGVseSBhcyBpdCBk
aXNtaXNzZXMgY2FzZSAxIHJlc3VsdHMgKHdoaWNoIEkgdGhpbmsgYXJlDQo+ID4+ID4gbW9yZSBy
ZWFzb25hYmxlKS4NCj4gPj4gPg0KPiA+PiA+IFRobmFrcw0K

