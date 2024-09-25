Return-Path: <linux-kernel+bounces-339538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 077D0986688
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 20:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A5E31C23CE6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 18:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1D81D5ADC;
	Wed, 25 Sep 2024 18:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fdpNtTAU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC6E74C1B
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 18:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727290165; cv=fail; b=JOCdE6Yyv3kPNzvNiFVVatk2wxdbH49iqaw6jVUAtgRNyqTjrC6KlclfAwnIRtjWi9hbrAjjn/p0mwyYGIJrsUN60AgUIs7ru0TUt2cvv+T1ssdPLd1vDf/JSIToJFZhBXOXc0z/nM95D1Tlcpu4otyTl5gtqWPogkFLUGpLUAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727290165; c=relaxed/simple;
	bh=w0DYIBQCYIRfHHaAWEyWKf1uF2A4ek83wSgMEc+NLYQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Uv9APJG4iFlkZRkyAX/723mlJX8jgSMcZ3e/82uVVHlUpl+mpAp/a5DuR8kgQwoceJg/GGom0xwaSHpN9dpzz4C0ym52uCYqnrwWvTmXD2FQcZ1kXUwghBeXyez4JX6r9lVyZ9LJw/2Mk2XTHAH/3xc/2p4AXfsjAVB1rceGDG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fdpNtTAU; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727290164; x=1758826164;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=w0DYIBQCYIRfHHaAWEyWKf1uF2A4ek83wSgMEc+NLYQ=;
  b=fdpNtTAU/W1N1JjAl2BmqUX8Y8aqYf4M+Nvz0ggVYQ77jZXqHefI/vjB
   YaoxCMmUQWX1jjBoLVRoZ+uPTjyJG2hW1p+51hE2WJVEtVeB0DX+uA/e7
   tjp5n7lEBrOmHS+hCnZdv+b2Lb2sO+9WspscOEXZGSc9e8Z6hJRsGan33
   9Z2PbyVttsxxSRY3HlqNQKM2tnl9XBgdyY66JGkm4oKae+TLXjRiUPC1X
   p8FDBsSxUJ1cpIiGaQ5qi8r7VXjk2xe349n/NeWqWOI77l2jOQpA+paRC
   Hvnl+v8OllofiR+B2MYcYc1E+3f4NQJaWsrww6w/rPxRcIDp2xQ8OliO+
   Q==;
X-CSE-ConnectionGUID: cuFkRJP+SNO5j86Z0qKINA==
X-CSE-MsgGUID: M+nBwuITQxqweH3L6zVsoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="26223332"
X-IronPort-AV: E=Sophos;i="6.10,258,1719903600"; 
   d="scan'208";a="26223332"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 11:49:02 -0700
X-CSE-ConnectionGUID: coyj/1/OR421cfOMNbGphw==
X-CSE-MsgGUID: sWj4jaCLSUiVVodvo/UAAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,258,1719903600"; 
   d="scan'208";a="76796516"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Sep 2024 11:49:01 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 25 Sep 2024 11:49:01 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 25 Sep 2024 11:49:00 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 25 Sep 2024 11:49:00 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 25 Sep 2024 11:49:00 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 25 Sep 2024 11:49:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rM58Lw3eskoh56TvOMgWxS8rLy1n/WWgnVON2mBpV+BbYAowd/qrL1dtTOsIy/sb2D5PmLipXFQWBbRqHfMwQt68IQcggK+Vn+QGaIaQVmatRORAFE9G9I8F3cD9JP23QdZZM7uLFIGIbV7tfabG2P8KzZtdd1wBqHkB6INMqzjRJhGwZkhJ7DFdhrxC22YvPESosOBuAVnXJOh89tpotpml49rS0VzTmrF1FQrjJPobZJSf9Fffc2jvkMVItdtzVnFNLz5F6ipRNdCBjzHcKkUj6k6BCSVkXFdifn+Us0hVsC/nd6R3Swu4fOfyd0YK48fcnHuNbMHFVDEXDCd/UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TpW7hSTtlLgyU2Y452wdXNC4YgpWJHHz2/zFSo8RKNA=;
 b=ODjTGM6HYaeTlTUIfWzNG5tjGGqkBS3IlM4D2BS18SuKsSVN/j0ceGimXBGkruDb9t/tHqQ/DF9ErdSstEXb7XvGJwZQYUoupxhhB4uxOT8rDNsKaxZC3pfm6uuMmfENz+S9yp4BpxEyXwMaqsNlg5WRHkUYnTXTpolN+VmIKxz9rkgXuIc7919So1+swhJyEOIWTOFxV9J4h3Px5jEZcD9mTC3NbOU84cdpSBaAF2K/Y1bfJId1bXfFbRtynFNM9nTDBphE4scIdIB2s0Fyue79NkKwcUUImLyYkqAl+pJz2hsqzu0aRcrF4Ees3T93ZshoeIFF9YrckSUI6EWchA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by IA1PR11MB7248.namprd11.prod.outlook.com (2603:10b6:208:42c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Wed, 25 Sep
 2024 18:48:52 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 18:48:51 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Johannes Weiner <hannes@cmpxchg.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "yosryahmed@google.com"
	<yosryahmed@google.com>, "nphamcs@gmail.com" <nphamcs@gmail.com>,
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "shakeel.butt@linux.dev"
	<shakeel.butt@linux.dev>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"Huang, Ying" <ying.huang@intel.com>, "21cnbao@gmail.com"
	<21cnbao@gmail.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"Zou, Nanhai" <nanhai.zou@intel.com>, "Feghali, Wajdi K"
	<wajdi.k.feghali@intel.com>, "Gopal, Vinodh" <vinodh.gopal@intel.com>,
	"Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v7 6/8] mm: zswap: Support mTHP swapout in zswap_store().
Thread-Topic: [PATCH v7 6/8] mm: zswap: Support mTHP swapout in zswap_store().
Thread-Index: AQHbDh+C+ZYgIzdq4EuvViy0xt7aPLJokemAgABIS6A=
Date: Wed, 25 Sep 2024 18:48:51 +0000
Message-ID: <SJ0PR11MB567885530BE248F0625F2D4AC9692@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20240924011709.7037-1-kanchana.p.sridhar@intel.com>
 <20240924011709.7037-7-kanchana.p.sridhar@intel.com>
 <20240925142741.GD875661@cmpxchg.org>
In-Reply-To: <20240925142741.GD875661@cmpxchg.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|IA1PR11MB7248:EE_
x-ms-office365-filtering-correlation-id: 2768922e-b150-45ee-dfa3-08dcdd92b2e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?nG7Jzd1ZleftvgNjUOO4S5IVeji9asXmcZzpN6vohMwQGMqLb5OiwyyzC7J6?=
 =?us-ascii?Q?0CT9SqVnwwjTerqF253eljuSJ1W2wrQbo+kFIi98cR5ByAls/qyAkWLhlVO+?=
 =?us-ascii?Q?OQOzl4mkocsk+UfMBYqDUeoVJqMHjHdjcVNzr2dgCKKdBYI0Ka+Okzi2ws57?=
 =?us-ascii?Q?JhQ7iNyJjYbC47ErjeFC6Cj+h1f+F2owJGuE/4fge48/Lf6+5kaSZV1WqSJm?=
 =?us-ascii?Q?hKHo0rszauciXH1txMcegJv5l8TBoN5W71cVtje4tesZ6IRfmKuy/PLNYadG?=
 =?us-ascii?Q?MCQdUhIaA4bizyGSTbdFlWAsnaNhGOAAXlsVcQzHNClET7ngMZRXiP0se4lX?=
 =?us-ascii?Q?ZTe0utuWUcvahEU1iGyBvKW741cxDtPTfbPivhmXPtq2KB5DX/dt/Ug/DncY?=
 =?us-ascii?Q?Z8X15UQ69G7Cm9NF5209xGxDmV05qlkPgTwk63Bdkbn8pbojAGuA0pwV3pjH?=
 =?us-ascii?Q?lbi5u9H1JpmhorApZCEOiqZ4QxBLFyKu0RVdHXNwZNmx2BCGqyw+JtMyU9+U?=
 =?us-ascii?Q?HM0eHEPHAQjqtSXLVwdeiBIER/DFWgVRcrvGbvFEJr2BNjO3A42SrCUCrzpg?=
 =?us-ascii?Q?Oaol2TFTPcS9q/kBsPjTG5H3J1wWlMyNQdSjLRRzD0Zg8pxjtwWWUfdBB80D?=
 =?us-ascii?Q?dq9UiSb5oe2JUoxSTWTe8IIZDR/wBVSDBWxFztQ25WU1UoYlNp24XpMo7gzk?=
 =?us-ascii?Q?GVgPktQfMzrLvTI8/V+3gYLeJDnkwnuklRwqeoojKwNrJvE+UiTs8mGkP3Sf?=
 =?us-ascii?Q?rg/bhZNI7XtJcN4ygI/1xe1RvlRXYHmjrQanN+89Flw5wRG3uHwEGclssNbj?=
 =?us-ascii?Q?oV0JHaAdBDkEnLLJ1e7C9J3Uuy/eEzqPf9GIXenVeRPCZtBvEup6gt3ph6ko?=
 =?us-ascii?Q?wAwHSaOsxRPWi4rdeWEUsFfL56YhUP81fUe5RBLB6/I9DlIWWXgrv6Qyb3LD?=
 =?us-ascii?Q?H1eYdLo2//H3B3LZadx7PRp5iu02+0DTRZ/+HzdYpD6IMoc+3AmiHr6IYiDf?=
 =?us-ascii?Q?814ntb+DjTl1qKv8L3D7RknBrU+lI1yWv/zQepcDY/TkqKITdZ0eC3lPx4vU?=
 =?us-ascii?Q?vvKnXzv4kWR7tGhR3kHBRwogBfLTiFCAwEZI6ItGH0eaRm3DXgWVonEE/wCR?=
 =?us-ascii?Q?1KJVqTgD8/DvRIWkVaQbm1134OsFANN9tZtS+sdzYUs0ybHhKsYPQvmdWxgK?=
 =?us-ascii?Q?D4fp1JYjJrP1fNFk6jvRMEJ6peb6set4Iouw6HckftfJdWzvqky50XdmeLht?=
 =?us-ascii?Q?hHiiQSZ0QTrAkV+FGiHlJB80/ylsaToPizgSaIR5AE9LgS4yf6n7kDKdrz1y?=
 =?us-ascii?Q?e7bilVn+g7DI3o6kB2WF61qa9PFtuq7ETaSOJ+dhkiJLbA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iBTVHR1C4xR2Niu4HHwTd6YEcfB8sYCu90RXAM+nxIzYmeaLccgDi57pLOl/?=
 =?us-ascii?Q?kOp5YV8/e/ndLlQFN0YTrxBpjJQCLWW97/PjoW1+mRbeyQZP2JHuWIh1bbLv?=
 =?us-ascii?Q?LHBcFjcqAQbUK9xvpS1izEB0cvXw/DLHWJZmnqrsTrOw59D54PmPbijP5oRT?=
 =?us-ascii?Q?l8Z/FQoue23o/xOeP9jWuNaXHA/jt0bdv+FlmARzdza4GerGAn2qgdkOz7w/?=
 =?us-ascii?Q?JZ8HoGJ+yWFe0lhbwokclMMUkUFVrb/iokuT0pmOJdPPbYVZjCaRbvajVDAn?=
 =?us-ascii?Q?CeO3bazhUs8Fl/yeGqY5E3kQv2Z4/ku5oi33yozfSM/++KjjwyliaMT8kAim?=
 =?us-ascii?Q?5RNbC9Ukok9KRYnkPjFiCboR67Ve5vIctGBI7OK86GImxdZ6d5UQ4XzJ+++y?=
 =?us-ascii?Q?Tbs7JQ3A2wj+WgCmm/ojCc3M7ZKDkClUGNKLdiiLkIo/2d3CYQ90u9zTcSvq?=
 =?us-ascii?Q?aRhHyd/58P0x5lldTWLttndM92X+Eq7Adhr1Wnb+twr2iZGo4vgdg9m8gO/S?=
 =?us-ascii?Q?wL207TWcZDR9QnjoSHVzFgOjxGHqwxxRb51sgJW1PAP7kSL6531aSGea0ZIe?=
 =?us-ascii?Q?o0ZWvWPoS8kxFbvhrE8IQ8WApTtmhldGc1TGYSQfMForJEwi1wjTEb7nrSI1?=
 =?us-ascii?Q?cEPSBpjyV4/y3zCelbwYTrxod4JN9HrLf8kS9597lbHumYsOIHouRxj0sfm3?=
 =?us-ascii?Q?8NZsKnqYYLY/EfdJoCRM9h2VGcIUO3FVGLgIyF+Q27CmUiioDwlX9BOJOhSb?=
 =?us-ascii?Q?u4TneMcYhqv0xnPaPwYrg/q65GOMIx7PPYZgzhifjW1StrH5aeeqsmn5x4Jm?=
 =?us-ascii?Q?QXY9c4+X/AQDDfCzJebHsyJ3Bf4z4khm51uvxgTj4tk7F98BMHKs+uWbz4+w?=
 =?us-ascii?Q?YVmQrrz/HdmTN4CvA5yfO7744pOic1GnKKHmdgYojX4AvnneIwQvAA16AFg/?=
 =?us-ascii?Q?GxXmw9jzmd1T4ZSEy5TwJ1XgM+gmQIKhf3MiwtvzEZ5fd7t2WXq4e8EDlJgb?=
 =?us-ascii?Q?XMAKdIPbNkA1wjUzymzthmyLsx+H3T/kDjnDZRSJGDlEexNA5y36muedr1gT?=
 =?us-ascii?Q?jOiHLIdahQK3fWyBZBt6vRFw5rUT+zBL2Wtwh2AH4spghXspmFq+YVLIs8IO?=
 =?us-ascii?Q?5kBPhe9jeEEqMzmaflTdsXpKLkHOmFBo7GZE40pbJ3t3wOcYR7ts8+wMOuaa?=
 =?us-ascii?Q?jpSMKLDM3xv24ZNwqpiUMt13b3Eds3XdswJ4nc8wyb3BBZwDCQms+/yZ0uA7?=
 =?us-ascii?Q?pNxwZrbBpUY1stO1yuG02FR6EMiRQvxKKZCM/x0dfCtnQsycQ9FpuULMLf65?=
 =?us-ascii?Q?Yb0vn7K7keeVtqB7oCBozw2xJiiXe5BC983AuODpD+FZZWSIYywDbeDMxnF4?=
 =?us-ascii?Q?EzSTzZaUXTjR3KIz+aNBTPsdDaoprO4jKimwHQJ8c2WaeY4OdJRNCSx9dKwz?=
 =?us-ascii?Q?Dzuudeah7wHoGlO2rlZYsfujX5ziJzuY3EIKwWvN7F+2uK32S1EDMBoHiY4N?=
 =?us-ascii?Q?F72ASjS4SRE/eqYbsF0eCBa4hPWp32DgpgfuFA12Z41edKBTDrqw7HWp53BU?=
 =?us-ascii?Q?wg2TADB56a7bFwLXUSicegXQkCWq+3AuXhrzD4oUO6MhCxtm0z9jJCcYmzPR?=
 =?us-ascii?Q?PA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5678.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2768922e-b150-45ee-dfa3-08dcdd92b2e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2024 18:48:51.5743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HuJHanf0ns8VH1yn392uPprMQRO6zkQrF77e7NaOmhWa3eaC2IVe4revTYRUGFsY7GGWdFyiFdkU7N3xu/JZg8dY1OeN4LYJ6vKHe7pgOKM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7248
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Johannes Weiner <hannes@cmpxchg.org>
> Sent: Wednesday, September 25, 2024 7:28 AM
> To: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>
> Cc: linux-kernel@vger.kernel.org; linux-mm@kvack.org;
> yosryahmed@google.com; nphamcs@gmail.com;
> chengming.zhou@linux.dev; usamaarif642@gmail.com;
> shakeel.butt@linux.dev; ryan.roberts@arm.com; Huang, Ying
> <ying.huang@intel.com>; 21cnbao@gmail.com; akpm@linux-foundation.org;
> Zou, Nanhai <nanhai.zou@intel.com>; Feghali, Wajdi K
> <wajdi.k.feghali@intel.com>; Gopal, Vinodh <vinodh.gopal@intel.com>
> Subject: Re: [PATCH v7 6/8] mm: zswap: Support mTHP swapout in
> zswap_store().
>=20
> On Mon, Sep 23, 2024 at 06:17:07PM -0700, Kanchana P Sridhar wrote:
> > zswap_store() will now store mTHP and PMD-size THP folios by compressin=
g
>=20
> The hugepage terminology throughout the patches is a bit convoluted.
>=20
> There is no real distinction in this code between PMD-size THPs and
> sub-PMD-sized mTHPs e.g. In particular, I think "mTHP" made sense when
> they were added, to distinguish them from conventional THPs. But using
> this term going forward just causes confusion, IMO.
>=20
> We're going through a big effort in the codebase to call all of these
> things simply "folios" - which stands for "one or more pages". If you
> want to emphasize the "more than one page", the convention is to call
> it a "large folio". (If you need to emphasize that it's PMD size -
> which doesn't apply to these patches, but just for the record - the
> convention is "pmd-mappable folio".)
>=20
> So what this patch set does is "support large folios in zswap".

Sure. Will modify this to be "support large folios in zswap _stores"
as per Yosry's follow-up clarification.

>=20
> > @@ -1551,51 +1559,63 @@ static bool __maybe_unused
> zswap_store_page(struct folio *folio, long index,
> >  	return false;
> >  }
> >
> > +/*
> > + * Modified to store mTHP folios. Each page in the mTHP will be
> compressed
> > + * and stored sequentially.
> > + */
>=20
> This is a changelog, not a code comment ;) Please delete it.

Ok, sure.

>=20
> >  bool zswap_store(struct folio *folio)
> >  {
> >  	long nr_pages =3D folio_nr_pages(folio);
> >  	swp_entry_t swp =3D folio->swap;
> >  	pgoff_t offset =3D swp_offset(swp);
> >  	struct xarray *tree =3D swap_zswap_tree(swp);
> > -	struct zswap_entry *entry;
> >  	struct obj_cgroup *objcg =3D NULL;
> >  	struct mem_cgroup *memcg =3D NULL;
> > +	struct zswap_pool *pool;
> > +	bool ret =3D false;
> > +	long index;
> >
> >  	VM_WARN_ON_ONCE(!folio_test_locked(folio));
> >  	VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
> >
> > -	/* Large folios aren't supported */
> > -	if (folio_test_large(folio))
> > +	/* Storing large folios isn't enabled */
> > +	if (!zswap_mthp_enabled && folio_test_large(folio))
> >  		return false;
> >
> >  	if (!zswap_enabled)
> > -		goto check_old;
> > +		goto reject;
> >
> > -	/* Check cgroup limits */
> > +	/*
> > +	 * Check cgroup limits:
> > +	 *
> > +	 * The cgroup zswap limit check is done once at the beginning of an
> > +	 * mTHP store, and not within zswap_store_page() for each page
> > +	 * in the mTHP. We do however check the zswap pool limits at the
>=20
> Use "folio" and "large folio" as appropriate here and throughout.

Sounds good.

Thanks,
Kanchana


