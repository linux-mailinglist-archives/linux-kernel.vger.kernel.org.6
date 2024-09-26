Return-Path: <linux-kernel+bounces-339867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B858986B96
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 05:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A3B01F223F1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 03:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0970E17A918;
	Thu, 26 Sep 2024 03:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HyLw4TcD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37861741C6
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 03:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727323113; cv=fail; b=bs5wAorZLWftYTpwJeyT1+MfXNnAfCtXG+c3ARttRRL6mfv+0yxbO3P+oEZvaaFNR4xG4AFTGyP0MCs8GjDpYVVIHBqjqqXQerDud6SwI/ITZkMN9JTsMYPuXZHSgRyIoQlVrpmd4pMnWWEbOy4eUTFN+QfI292WDtayKq10Q0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727323113; c=relaxed/simple;
	bh=aoAexvkdCgjWVsl7ZCEwsSotCbJxwlTZAYYf1keD0QQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OrL7e5hhu8civfDwGtA0tp+vvqR07+xpM5MC6dtrthsLpuMHGkplRUlhjPouxcizKbr+ebeEBTDYwEMZbqU0GPYw7eqR47l4RvgPWUua5d6a9/KLJ+3tCLCuCnRNylJINVBejnUInxKKTOv4BhUFNPVfcsS7llE3d8VhfhzIEK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HyLw4TcD; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727323112; x=1758859112;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aoAexvkdCgjWVsl7ZCEwsSotCbJxwlTZAYYf1keD0QQ=;
  b=HyLw4TcDxclpvYY0i4RDZfqy3aiVbUsXRhUTyoBsWHD/nZnbq3z38Erq
   xVo0nGG0+Zbp53PhWg1gVHJq7vQJ6NnjLYQhWEN3nVVPR3QY+YbuT87xi
   JNQUQGGLNbdnk8yzI98frs5GG7mTCSgcooQs++gr7/1MRWgFoStkFAEDe
   p+bQjVxtJ29UaCcRXmQ4QtZrI4hbFrmWeW5/GKbbkH8714GLZAQfvpMns
   MZIv5y88qUeS2er8wsILmpOqAQdTpRNj4M0tw2cUvde6s7um6UmLxmUT3
   OV9rxXMizRlybxUxJGKktp9AiNBEXQwijnePUvG1zC3nJRcrSRfCkwzXY
   Q==;
X-CSE-ConnectionGUID: TOiDp0PzR8CfhAV+zhwcRg==
X-CSE-MsgGUID: pEnGRaSAS7u8CWuC5zcRZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="26496979"
X-IronPort-AV: E=Sophos;i="6.10,259,1719903600"; 
   d="scan'208";a="26496979"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 20:58:31 -0700
X-CSE-ConnectionGUID: KAvB+gCxRqq0PXfRKhjMZA==
X-CSE-MsgGUID: W8Og2UolRGeN5esoNXYX+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,259,1719903600"; 
   d="scan'208";a="71602070"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Sep 2024 20:58:30 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 25 Sep 2024 20:58:30 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 25 Sep 2024 20:58:30 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 25 Sep 2024 20:58:29 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 25 Sep 2024 20:58:29 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 25 Sep 2024 20:58:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ux27QnjTuMe/9mQ3AwH4NH1v1l8nnQGv8Pds6VH0gwo3qBoJhxBtVN9+6J4+mQQipcDBvCyvw80A3wwvuTNElo1EFwB6IDk10hAgYypk8Q+Q6g1zqc3zHpr0KyipxYFiaLgMuROEumeZKFNXdno3L2Oy5E83kl3GBAcH3GQb0CXmvOv21/Vi7THI6OpJQwK0yHzPEeafLKtwdZjLEjTNhPHZv/4zbW7Z1Wn7g9gVOpAH+RLj0q/CtXJtADftY2BR5r0IlC6Z9nokItJI3x2tFb3EEPMb0QUFd6cuxyOXknucBzolKhePbnTm11dnXktbP9Hpap9gKEKL0cht1ru5Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aoAexvkdCgjWVsl7ZCEwsSotCbJxwlTZAYYf1keD0QQ=;
 b=MC+vIJtKQFc3ZBn2pxJpSl1hzqG6dhkQ/gCaVdBGzWmsN/FoCKmcqFQ26LmbWzLrlSe6WJYfx86LAqY2fCYg9UpZJ2WKojyKj58+R/HQfjoxeCJvUQXGyBFXe79IOlAnBA6AtyW/niw+d3Ixg9Oe8V5O3pTnFzxRN56DcyKBQj8pXOuAO0106y6QG2cui0+77Tpbyjqywe4LZP51Z6wACGsZzy0kgIHD/p3FSrPBf+x6VMvu6191CAtdkVFgYv/qKM8rW4i+7P56AcKIA7Eh0clSAz42WC9v707VEGXLjY8xGoOBm0SOspTGFmLTICPO8CzumnLSQH6PS4yyshY/5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by DM4PR11MB6065.namprd11.prod.outlook.com (2603:10b6:8:60::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Thu, 26 Sep
 2024 03:58:21 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 03:58:20 +0000
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
Thread-Index: AQHbDh+C+ZYgIzdq4EuvViy0xt7aPLJnVm0AgAEuMgCAAFEmAIAADdcAgAAFSgCAAAmZgIAADtIAgAAWxLCAAFmCgA==
Date: Thu, 26 Sep 2024 03:58:20 +0000
Message-ID: <SJ0PR11MB56781A134838ADDD04731AA3C96A2@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20240924011709.7037-1-kanchana.p.sridhar@intel.com>
 <20240924011709.7037-7-kanchana.p.sridhar@intel.com>
 <CAJD7tkbd=H+=wx0gnu8sh44hOmx7BE3G3oSxi7zt+o3HKJthkA@mail.gmail.com>
 <20240925134008.GA875661@cmpxchg.org>
 <CAJD7tkY8D14j-e6imW9NxZCjTbx8tu_VaKDbRRQMdSeKX_kBuw@mail.gmail.com>
 <20240925192006.GB876370@cmpxchg.org>
 <CAJD7tkY-ayU3Ld+dKTLEEG3U72fGnCbiQgZursK+eGMXif_uzA@mail.gmail.com>
 <20240925201323.GA880690@cmpxchg.org>
 <CAJD7tkbCDe1Y__0vUKt9q0dz_sXM74fKGQo2Zgq9CJ8=FEjH3w@mail.gmail.com>
 <SJ0PR11MB5678EC9681960F39427EABFFC9692@SJ0PR11MB5678.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB5678EC9681960F39427EABFFC9692@SJ0PR11MB5678.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|DM4PR11MB6065:EE_
x-ms-office365-filtering-correlation-id: 4742883d-160c-4dc5-3cc8-08dcdddf760d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QnBkTG54NVdObmRPeVBFZ1greWdiWE5uZWNpWlVveWFxaGMrVUpodFhoTWh1?=
 =?utf-8?B?aWJlbDFINndvUDFSYWczTUVZcDJXbzZxYlBybnRFQWVDR2E5OUFEa2R0QUQr?=
 =?utf-8?B?aG1ZVmE1MFplc2dnQXozaVBmRTNaTXgxTkIzeXFuemk3c0tKeTE2dXVjdGts?=
 =?utf-8?B?N1ZnaEM4eTRiblgydkYvck1KanlBbVo2c0g0RWZZaGtiREFxWGd1Z3Rud3lT?=
 =?utf-8?B?WWJLTUxrd0lra0ozV1BvK1ZncW5JNjk5VUJvRHpOVVE1RW1EWjl2QUYrUkx2?=
 =?utf-8?B?enJ4K3l2TzQ1eGs4cjd3dEFmaFJFck1pa3FDMFR1QkpLYlJWUGdKak1nazVy?=
 =?utf-8?B?eVY5UlA2LzJZTEZDNlRYQlA2QytTaGtuK1RyRnAvWFJMSjlQRkVCWUJmdW9N?=
 =?utf-8?B?akFnSm1NczRPOUhLNVFaU0hkQ0lrVXlYN3lENTlpTURsZUU5dmpvVFBxY015?=
 =?utf-8?B?d3l1a3NJT09FeDQySmtoOXhOSThIc3crSGxZNFZNOE5TS3pYc0VkTTU0RlVz?=
 =?utf-8?B?MHBDNjNjR0ltUHJ6WVE4bldrRnlDWEg3YWtmS1VqbitSNThPWkk4ekx5S1ly?=
 =?utf-8?B?OFhzeE0wbjVaelRMK2t2ZnlGUDgvVlRndFNreW1LQlA0ZW0vZkZDbGNMR2Z2?=
 =?utf-8?B?RkF3V3BRSkRwQmtZdk04cExvZEM1YkFNRlVPTkt5N0h1SUE2UHZYYXcweEdK?=
 =?utf-8?B?Y2JUTXVVRmV1bUFkRGpsbEhSaUhvT2lWcktQV05xckVaNUlrYjRJRlViUGVT?=
 =?utf-8?B?UzAvQWwya014M05DN011SWswa2tjL3g5VVhjQXNlUXRzcC9tTDdnWUZ6M3JV?=
 =?utf-8?B?NVNiY2ZmanU1RFROQm85NjBPdDJwQVlQZy9vOWR1c09lVU5hWFQyUGdKc00x?=
 =?utf-8?B?VXFaaEpFTGJ6Q2RtSzhJbmZGS0piNjFsem1TSndQbGlzeTVkdXdSVnBRRmdH?=
 =?utf-8?B?RWx2MEZKR1AwT1dPQkwvRFRsOG1ScjAxT3krMk4yTjBTeXNwTEdvR3F1RmRu?=
 =?utf-8?B?ZTlLSzduWU01TUVweis4U0U2ZVNSY2doN0duMmJJWGExTm4rVWg5TkNVSHpr?=
 =?utf-8?B?OU9FbGpHUEpKcXVWWVdUakt4amRNZWlmYXAvU28vSkdUTExCQ0xvaG1RTURG?=
 =?utf-8?B?clUxS21VNVZhNlZpTmMrUmMzT1lvaVU1Yk1Cbzlsc2NNUlZvWjFOWlZHeGg0?=
 =?utf-8?B?N3IwZksySnBleHpsbFJhaUZnVlNOZURIdVJiWUVCcVV1VXl6TTFaNzJldk44?=
 =?utf-8?B?ck9TcE5NdlAyTXpFcW1BQXFPQWY2K0NjOThNY0Fyd1hUZzlVYUZIbXlWNmhP?=
 =?utf-8?B?RFYvUjhYVnc5RjY3NE51S0NQTkN1dHJPSkloQWdZTTQ2eFVBSndBWGRnbW1H?=
 =?utf-8?B?cnRhck90b281MWdNcTVLOE1LT0hBTzNyTHFHOHRaZWo1TGttU1NhQzNUclpp?=
 =?utf-8?B?clZKL1FHa2hPaTBmbDFlUllHRjlXeVV5TWN6eDNSMElteUd5TkM0YVRhSndn?=
 =?utf-8?B?TkxXNW9qQUJwR2VRamQxZjlsc0lIbnNqTG94bHVGUWE4c01DV0h2M3FNQm9v?=
 =?utf-8?B?bVY5R1FzSHNJTGFjeTd0em9kaVBWVHI3a1FLL3Jsd3BqTFFEZWU4L3ppWks1?=
 =?utf-8?B?RTBmNzlVY3RraXdDRSszeUpjKzVrckloRksyazZhSTAxeU5jNytwWjhLb3dp?=
 =?utf-8?B?NU1qTk5WVmpaVTJiVktJQWZjL1BvZzdjODZuamN0d0k4czVCZlowaEdmc2dR?=
 =?utf-8?B?QzJOWjdtaThMdDhhUWRDTk9tblkxdnV5T3M2b05hLzBtdGpGejFpek1MTllL?=
 =?utf-8?B?TWhObE13TlN3MTYxckZQMnlzeGl6cVJCQ3ExSkRyWlhQK3BWdEhqa3hTek4z?=
 =?utf-8?B?dHJ6QnJ6Ym9NRmJ4UWpuSlRVRDdVV3dQS1FpRkxmTW9YSWc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q1d4L0RuQ0g2ODRrUFBRVW5Da3JnUzI1cjlXcWxBcXQzSXN0UjExQjJKcnZ4?=
 =?utf-8?B?b3BCTWNwSDRsQXFXcmFZUFJ3dXNCeTQ1MXA4UjhLUlU4dUh5eVdQOWRpakpB?=
 =?utf-8?B?ZW1tTXFNNkxDMFA0Zk1Na2tqNmxZVGtUVG1GaWYvUVpOSkp2RkFLWGRLN0VK?=
 =?utf-8?B?Vnd3czVqU1JnL0FwR1FJRkpGeDlKd0Q5Skp0YzB4cEpVbUVndFVOL3BQb0Z4?=
 =?utf-8?B?Zzd2eXlScjhGNGdhTW1SangwU3QzUmRUcnFjalNDcjlCUWhpai9oOE1wMldH?=
 =?utf-8?B?YVNiWUxtWFBMbEF4cGRRbDZXOWkrTCtyZDlQRVI5d29PNU9CSzFIK2s5eHZO?=
 =?utf-8?B?UnVEVUhMbG5Yays4dm90aVZiVmpHRVVabTIxRlJOSXdLclNmZlpEejRrOSto?=
 =?utf-8?B?ZG5Qazgzb3FOMTkyZFVWWWpZSUdHaFZmeXlpWTJiUUwzWTNLUWw5cnpHbldh?=
 =?utf-8?B?TFV0ZXJYYXZtQzlBYzBMZDBSOFlRQ1c0aWVZUkJEUHlvdGFWNnoxMTNFd2I3?=
 =?utf-8?B?QXBEQWl0ZmZmN0kvaWhnTmVZcHRqWUlKMHdRUi9ycWJ0RFRES096WEpCdVU3?=
 =?utf-8?B?OVN3U210UktKNkF6RzYvYlNtWXBvL1dnNlU2MTcrYms5V1g4anZMRXduY1lJ?=
 =?utf-8?B?ZW93czRwYmRYZHg0YnkzVDY3RHFCV2E1bEN0RWc4NFFTUnpPbVN0ZHFsSnBk?=
 =?utf-8?B?cjhVWktWQnZPSFlPK0Mrc1I1UjRmbXlLenBHbEVEcnovOEJJV0dTZkhtcG1V?=
 =?utf-8?B?T3g0QUQ5VzZCQWRsZGhGWnlvbzc5eitKbWNhT3FpQU42YUY0WmpWNEd5dDRr?=
 =?utf-8?B?RzBYWUpwOEdQcFlCbk8rMTZlK2pHejJIR1owQTdGSE1zQk9HWVRTY2RHQ2d4?=
 =?utf-8?B?UlhZTGJrTWdUaEU4OUszazFnWGpFRHVuRGFvTzVsQUdoL2RwTkRSWk1ickYv?=
 =?utf-8?B?S0JpQ1Jwb2ptSmF3aW5keFJjWWFDZVJMMll5YUxyU2FDZXloYlo0T2VwWnRY?=
 =?utf-8?B?QjF3UEE3Rjd5Mi9Ed1NXSmMvNmxEMFVrcHN6aVZPRStpK25wUFFQYW1MUUp2?=
 =?utf-8?B?Nk1qZW9WM0RDdGRmRFU4dnRDZFFxOG0zLzNXUVEvMGlzMWU1SUR4NStLVWxY?=
 =?utf-8?B?K3cyNUJ2RFd5K2ZSbzFoL1J6VE1LTllhM2pSM0kvcUhZQ0o4VW4wUnJHaUtr?=
 =?utf-8?B?eUxFL0pIbUNBUENGQTJMNHBRQXVhTkVHSHdLNXlFZjlZeXprQkpYZUl6blZH?=
 =?utf-8?B?Wm9VTld3dHUxV252SVVCRy9VRjFoUFVuNVpQcXdZc0tOQVJoWnlaMUVSek85?=
 =?utf-8?B?d0RaK0NNeUZQeEZTV1NBREphNEM1cXlXRzdLYTZUOXA5eEYrWlhrcUdqV1Bq?=
 =?utf-8?B?b3lLdFZxUXRvVVkyM3g0TXAyM2hHU3ZJQzVWMkJUOVV1aUxZT0tkSWcwWExD?=
 =?utf-8?B?WmkzeVN0WEwrSUpMbTloNmRZaUtqbWNHeDFhcWNxeWZUTVNQZ0c2L3FPdHBv?=
 =?utf-8?B?UGplS05tSlYvRnlPaXJyTDFsT0RxZFJNZkkvMDk5bUdZZ2dRbmJoMUhTeXM1?=
 =?utf-8?B?dUVRUFlLRXFyc3phZzh4ZnJuYmZ5dlZBV29xb0dFZWN6TDh0YmZLcUxzWUlx?=
 =?utf-8?B?WitzK2JRZDNhcDIyRXh6eDI3bk9MQmcyeWhpQ2VRRGszWWYwVXh1d2psT1VI?=
 =?utf-8?B?bW1XR2J6M2xDSEJZUEtLQXgrdm1kZzZ6NjB3QTNZU2NGOVNmZm1ZbEdjRjdi?=
 =?utf-8?B?TjFZVnF4aDBKOHN5a0wyTW55MTFKVkc5eWVOQ05TeHR4ZmVTMjZJaytUYnpr?=
 =?utf-8?B?Wk9tdjBpZlZyd21SbzhIbEpUemUzMTJvNUtMSG10aVFHS2JaNjBJV3Y0cHJj?=
 =?utf-8?B?TTNKUXhuNStOVDRxV05US1lQUWNuVzh1WktBRVNQeHZrbFFuV25ERFNiZGNC?=
 =?utf-8?B?WkVsM3hrNnArazc1OFVBR1ZSQlhXa1I4OTlTMFhvWCtHd1NnRkRsaldudGJE?=
 =?utf-8?B?RlVvZVg1aU9HZ2FjbHNzc2tQdmZDTThFQmQvZGNxTUhJZ0JNT0Rod0djdXVT?=
 =?utf-8?B?L3RCVmZSbTdTTmFCd2djVjNJUG14ZWR4M1ZYa3ErQUptT3VLalF3VTFEWEly?=
 =?utf-8?B?UmNZYnFlZ1RLY2dFcXlkSzZrS1FZVUZxNEJsWGpwWDljREZWdENKNTU1RjNP?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4742883d-160c-4dc5-3cc8-08dcdddf760d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2024 03:58:20.7424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CAY+RTxKMkdhLueaN+QqDsyiLwVdjit1BSJCLZyyapsohhdXVsRZFa7/EhcSxzh2MlVX7LMSXyFnAt6beSfDqR7FEK5OnRFPIT72eGMPfAc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6065
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTcmlkaGFyLCBLYW5jaGFuYSBQ
IDxrYW5jaGFuYS5wLnNyaWRoYXJAaW50ZWwuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIFNlcHRl
bWJlciAyNSwgMjAyNCAzOjI5IFBNDQo+IFRvOiBZb3NyeSBBaG1lZCA8eW9zcnlhaG1lZEBnb29n
bGUuY29tPjsgSm9oYW5uZXMgV2VpbmVyDQo+IDxoYW5uZXNAY21weGNoZy5vcmc+DQo+IENjOiBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1tbUBrdmFjay5vcmc7DQo+IG5waGFt
Y3NAZ21haWwuY29tOyBjaGVuZ21pbmcuemhvdUBsaW51eC5kZXY7DQo+IHVzYW1hYXJpZjY0MkBn
bWFpbC5jb207IHNoYWtlZWwuYnV0dEBsaW51eC5kZXY7IHJ5YW4ucm9iZXJ0c0Bhcm0uY29tOw0K
PiBIdWFuZywgWWluZyA8eWluZy5odWFuZ0BpbnRlbC5jb20+OyAyMWNuYmFvQGdtYWlsLmNvbTsg
YWtwbUBsaW51eC0NCj4gZm91bmRhdGlvbi5vcmc7IFpvdSwgTmFuaGFpIDxuYW5oYWkuem91QGlu
dGVsLmNvbT47IEZlZ2hhbGksIFdhamRpIEsNCj4gPHdhamRpLmsuZmVnaGFsaUBpbnRlbC5jb20+
OyBHb3BhbCwgVmlub2RoIDx2aW5vZGguZ29wYWxAaW50ZWwuY29tPjsNCj4gU3JpZGhhciwgS2Fu
Y2hhbmEgUCA8a2FuY2hhbmEucC5zcmlkaGFyQGludGVsLmNvbT4NCj4gU3ViamVjdDogUkU6IFtQ
QVRDSCB2NyA2LzhdIG1tOiB6c3dhcDogU3VwcG9ydCBtVEhQIHN3YXBvdXQgaW4NCj4genN3YXBf
c3RvcmUoKS4NCj4gDQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBZ
b3NyeSBBaG1lZCA8eW9zcnlhaG1lZEBnb29nbGUuY29tPg0KPiA+IFNlbnQ6IFdlZG5lc2RheSwg
U2VwdGVtYmVyIDI1LCAyMDI0IDI6MDYgUE0NCj4gPiBUbzogSm9oYW5uZXMgV2VpbmVyIDxoYW5u
ZXNAY21weGNoZy5vcmc+DQo+ID4gQ2M6IFNyaWRoYXIsIEthbmNoYW5hIFAgPGthbmNoYW5hLnAu
c3JpZGhhckBpbnRlbC5jb20+OyBsaW51eC0NCj4gPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBs
aW51eC1tbUBrdmFjay5vcmc7IG5waGFtY3NAZ21haWwuY29tOw0KPiA+IGNoZW5nbWluZy56aG91
QGxpbnV4LmRldjsgdXNhbWFhcmlmNjQyQGdtYWlsLmNvbTsNCj4gPiBzaGFrZWVsLmJ1dHRAbGlu
dXguZGV2OyByeWFuLnJvYmVydHNAYXJtLmNvbTsgSHVhbmcsIFlpbmcNCj4gPiA8eWluZy5odWFu
Z0BpbnRlbC5jb20+OyAyMWNuYmFvQGdtYWlsLmNvbTsgYWtwbUBsaW51eC0NCj4gZm91bmRhdGlv
bi5vcmc7DQo+ID4gWm91LCBOYW5oYWkgPG5hbmhhaS56b3VAaW50ZWwuY29tPjsgRmVnaGFsaSwg
V2FqZGkgSw0KPiA+IDx3YWpkaS5rLmZlZ2hhbGlAaW50ZWwuY29tPjsgR29wYWwsIFZpbm9kaCA8
dmlub2RoLmdvcGFsQGludGVsLmNvbT4NCj4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHY3IDYvOF0g
bW06IHpzd2FwOiBTdXBwb3J0IG1USFAgc3dhcG91dCBpbg0KPiA+IHpzd2FwX3N0b3JlKCkuDQo+
ID4NCj4gPiBPbiBXZWQsIFNlcCAyNSwgMjAyNCBhdCAxOjEz4oCvUE0gSm9oYW5uZXMgV2VpbmVy
DQo+IDxoYW5uZXNAY21weGNoZy5vcmc+DQo+ID4gd3JvdGU6DQo+ID4gPg0KPiA+ID4gT24gV2Vk
LCBTZXAgMjUsIDIwMjQgYXQgMTI6Mzk6MDJQTSAtMDcwMCwgWW9zcnkgQWhtZWQgd3JvdGU6DQo+
ID4gPiA+IE9uIFdlZCwgU2VwIDI1LCAyMDI0IGF0IDEyOjIw4oCvUE0gSm9oYW5uZXMgV2VpbmVy
DQo+ID4gPGhhbm5lc0BjbXB4Y2hnLm9yZz4gd3JvdGU6DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBP
biBXZWQsIFNlcCAyNSwgMjAyNCBhdCAxMTozMDozNEFNIC0wNzAwLCBZb3NyeSBBaG1lZCB3cm90
ZToNCj4gPiA+ID4gPiA+IEpvaGFubmVzIHdyb3RlOg0KPiA+ID4gPiA+ID4gPiBJZiB0aGlzIGV2
ZXIgYmVjb21lcyBhbiBpc3N1ZSwgd2UgY2FuIGhhbmRsZSBpdCBpbiBhIGZhc3RwYXRoLQ0KPiA+
IHNsb3dwYXRoDQo+ID4gPiA+ID4gPiA+IHNjaGVtZTogY2hlY2sgdGhlIGxpbWl0IHVwIGZyb250
IGZvciBmYXN0LXBhdGggZmFpbHVyZSBpZiB3ZSdyZQ0KPiA+ID4gPiA+ID4gPiBhbHJlYWR5IG1h
eGVkIG91dCwganVzdCBsaWtlIG5vdzsgdGhlbiBtYWtlDQo+ID4gb2JqX2Nncm91cF9jaGFyZ2Vf
enN3YXAoKQ0KPiA+ID4gPiA+ID4gPiBhdG9taWNhbGx5IGNoYXJnZSBhZ2FpbnN0IHpzd2FwLm1h
eCBhbmQgdW53aW5kIHRoZSBzdG9yZSBpZiB3ZQ0KPiA+IHJhY2VkLg0KPiA+ID4gPiA+ID4gPg0K
PiA+ID4gPiA+ID4gPiBGb3Igbm93LCBJIHdvdWxkIGp1c3Qga2VlcCB0aGUgc2ltcGxlIHZlcnNp
b24gd2UgY3VycmVudGx5IGhhdmU6DQo+ID4gY2hlY2sNCj4gPiA+ID4gPiA+ID4gb25jZSBpbiB6
c3dhcF9zdG9yZSgpIGFuZCB0aGVuIGp1c3QgZ28gYWhlYWQgZm9yIHRoZSB3aG9sZSBmb2xpby4N
Cj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBJIGFtIG5vdCB0b3RhbGx5IGFnYWluc3QgdGhpcyBi
dXQgSSBmZWVsIGxpa2UgdGhpcyBpcyB0b28gb3B0aW1pc3RpYy4NCj4gPiA+ID4gPiA+IEkgdGhp
bmsgd2UgY2FuIGtlZXAgaXQgc2ltcGxlLWlzaCBieSBtYWludGFpbmluZyBhbiBld21hIGZvciB0
aGUNCj4gPiA+ID4gPiA+IGNvbXByZXNzaW9uIHJhdGlvLCB3ZSBhbHJlYWR5IGhhdmUgcHJpbWl0
aXZlcyBmb3IgdGhpcyAoc2VlDQo+ID4gPiA+ID4gPiBERUNMQVJFX0VXTUEpLg0KPiA+ID4gPiA+
ID4NCj4gPiA+ID4gPiA+IFRoZW4gaW4genN3YXBfc3RvcmUoKSwgd2UgY2FuIHVzZSB0aGUgZXdt
YSB0byBlc3RpbWF0ZSB0aGUNCj4gPiBjb21wcmVzc2VkDQo+ID4gPiA+ID4gPiBzaXplIGFuZCB1
c2UgaXQgdG8gZG8gdGhlIG1lbWNnIGFuZCBnbG9iYWwgbGltaXQgY2hlY2tzIG9uY2UsIGxpa2Ug
d2UNCj4gPiA+ID4gPiA+IGRvIHRvZGF5LiBJbnN0ZWFkIG9mIGp1c3QgY2hlY2tpbmcgaWYgd2Ug
YXJlIGJlbG93IHRoZSBsaW1pdHMsIHdlDQo+ID4gPiA+ID4gPiBjaGVjayBpZiB3ZSBoYXZlIGVu
b3VnaCBoZWFkcm9vbSBmb3IgdGhlIGVzdGltYXRlZCBjb21wcmVzc2VkDQo+IHNpemUuDQo+ID4g
PiA+ID4gPiBUaGVuIHdlIGNhbGwgenN3YXBfc3RvcmVfcGFnZSgpIHRvIGRvIHRoZSBwZXItcGFn
ZSBzdHVmZiwgdGhlbiBkbw0KPiA+ID4gPiA+ID4gYmF0Y2hlZCBjaGFyZ2luZyBhbmQgc3RhdHMg
dXBkYXRlcy4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEknbSBub3Qgc3VyZSB3aGF0IHlvdSBnYWlu
IGZyb20gbWFraW5nIGEgbm9uLWF0b21pYyBjaGVjayBwcmVjaXNlLg0KPiBZb3UNCj4gPiA+ID4g
PiBjYW4gZ2V0IGEgaHVuZHJlZCB0aHJlYWRzIGRldGVybWluaW5nIGRvd24gcHJlY2lzZWx5IHRo
YXQgKnRoZWlyKg0KPiA+ID4gPiA+IHN0b3JlIHdpbGwgZml0IGV4YWN0bHkgaW50byB0aGUgbGFz
dCA4MDBrQiBiZWZvcmUgdGhlIGxpbWl0Lg0KPiA+ID4gPg0KPiA+ID4gPiBXZSBqdXN0IGdldCB0
byBhdm9pZCBvdmVyc2hvb3RpbmcgaW4gY2FzZXMgd2hlcmUgd2Uga25vdyB3ZSBwcm9iYWJseQ0K
PiA+ID4gPiBjYW4ndCBmaXQgaXQgYW55d2F5LiBJZiB3ZSBoYXZlIDRLQiBsZWZ0IGFuZCB3ZSBh
cmUgdHJ5aW5nIHRvIGNvbXByZXNzDQo+ID4gPiA+IGEgMk1CIFRIUCwgZm9yIGV4YW1wbGUuIEl0
IGp1c3QgbWFrZXMgdGhlIHVwZnJvbnQgY2hlY2sgdG8gYXZvaWQNCj4gPiA+ID4gcG9pbnRsZXNz
IGNvbXByZXNzaW9uIGEgbGl0dGxlIGJpdCBtb3JlIG1lYW5pbmdmdWwuDQo+ID4gPg0KPiA+ID4g
SSB0aGluayBJJ20gbWlzc2luZyBzb21ldGhpbmcuIEl0J3Mgbm90IGp1c3QgYW4gdXBmcm9udCBj
aGVjaywgaXQncw0KPiA+ID4gdGhlIG9ubHkgY2hlY2suIFRoZSBjaGFyZ2UgZG93biB0aGUgbGlu
ZSBkb2Vzbid0IGxpbWl0IGFueXRoaW5nLCBpdA0KPiA+ID4ganVzdCBjb3VudHMuIFNvIGlmIHRo
aXMgY2hlY2sgcGFzc2VzLCB3ZSBXSUxMIHN0b3JlIHRoZSBmb2xpby4gVGhlcmUNCj4gPiA+IGlz
IG5vIHBvaW50bGVzcyBjb21wcmVzc2lvbi4NCj4gPg0KPiA+IEkgZ290IGNvbmZ1c2VkIGJ5IHdo
YXQgeW91IHNhaWQgYWJvdXQgdGhlIGZhc3Qtc2xvdyBwYXRoLCBJIHRob3VnaHQNCj4gPiB5b3Ug
d2VyZSBzdWdnZXN0aW5nIHdlIGRvIHRoaXMgbm93LCBzbyBJIHdhcyBzYXlpbmcgaXQncyBiZXR0
ZXIgdG8gdXNlDQo+ID4gYW4gZXN0aW1hdGUgb2YgdGhlIGNvbXByZXNzZWQgc2l6ZSBpbiB0aGUg
ZmFzdCBwYXRoIHRvIGF2b2lkIHBvaW50bGVzcw0KPiA+IGNvbXByZXNzaW9uLg0KPiA+DQo+ID4g
SSBtaXNzZWQgdGhlIHNlY29uZCBwYXJhZ3JhcGguDQo+ID4NCj4gPiA+DQo+ID4gPiBXZSBtaWdo
dCBvdmVyc2hvb3QgdGhlIGxpbWl0IGJ5IGFib3V0IG9uZSBmb2xpbyBpbiBhIHNpbmdsZS10aHJl
YWRlZA0KPiA+ID4gc2NlbmFyaW8uIEJ1dCB0aGF0IGlzIG5lZ2xpZ2libGUgaW4gY29tcGFyaXNv
biB0byB0aGUgb3ZlcnNob290IHdlIGNhbg0KPiA+ID4gZ2V0IGR1ZSB0byByYWNlIGNvbmRpdGlv
bnMuDQo+ID4gPg0KPiA+ID4gQWdhaW4sIEkgc2VlIG5vIG5vIHByYWN0aWNhbCwgbWVhbmluZ2Z1
bCBkaWZmZXJlbmNlIGluIG91dGNvbWUgYnkNCj4gPiA+IG1ha2luZyB0aGF0IGxpbWl0IGNoZWNr
IGFueSBtb3JlIHByZWNpc2UuIEp1c3Qga2VlcCBpdCBhcy1pcy4NCj4gPg0KPiA+ID4gU29ycnkg
dG8gYmUgYmx1bnQsIGJ1dCAicHJlY2lzaW9uIiBpbiBhIG5vbi1hdG9taWMgY2hlY2sgbGlrZSB0
aGlzPw0KPiA+ID4gbWFrZXMgbm8gc2Vuc2UuIFRoZSBmYWN0IHRoYXQgaXQncyBub3QgdG9vIGV4
cGVuc2l2ZSBpcyBpcnJlbGV2YW50Lg0KPiA+ID4gVGhpcyBkaXNjdXNzaW9uIGFyb3VuZCB0aGlz
IGhvbmVzdGx5IGhhcyBnb25lIG9mZiB0aGUgcmFpbHMuDQo+ID4NCj4gPiBZZWFoIEkgdGhvdWdo
dCB3ZSB3ZXJlIHRhbGtpbmcgYWJvdXQgdGhlIHZlcnNpb24gd2hlcmUgd2Ugcm9sbGJhY2sNCj4g
PiBjb21wcmVzc2lvbnMgaWYgd2Ugb3ZlcnNob290LCBteSBiYWQuIFdlIGRpc2N1c3NlZCBxdWl0
ZSBhIGZldyB0aGluZ3MNCj4gPiBhbmQgSSBtYW5hZ2VkIHRvIGNvbmZ1c2UgbXlzZWxmLg0KPiA+
DQo+ID4gPiBKdXN0IGxlYXZlIHRoZSBsaW1pdCBjaGVja3MgZXhhY3RseSBhcyB0aGV5IGFyZS4g
Q2hlY2sgbGltaXRzIGFuZA0KPiA+ID4gY2dyb3VwX21heV96c3dhcCgpIG9uY2UgdXAgZnJvbnQu
IENvbXByZXNzIHRoZSBzdWJwYWdlcy4gQWNxdWlyZQ0KPiA+ID4gcmVmZXJlbmNlcyBhbmQgYnVt
cCBhbGwgc3RhdHMgaW4gYmF0Y2hlcyBvZiBmb2xpb19ucl9wYWdlcygpLiBZb3UgY2FuDQo+ID4g
PiBhZGQgdXAgdGhlIHN1YnBhZ2UgY29tcHJlc3NlZCBieXRlcyBpbiB0aGUgZm9yLWxvb3AgYW5k
IGRvIHRoZQ0KPiA+ID4gb2JqX2Nncm91cF9jaGFyZ2VfenN3YXAoKSBpbiBhIHNpbmdsZSBjYWxs
IGF0IHRoZSBlbmQgYXMgd2VsbC4NCj4gPg0KPiA+IFdlIGNhbiBrZWVwIHRoZSBsaW1pdCBjaGVj
a3MgYXMgdGhleSBhcmUgZm9yIG5vdywgYW5kIHJldmlzaXQgYXMgbmVlZGVkLg0KPiANCj4gVGhh
bmtzIEpvaGFubmVzIGFuZCBZb3NyeSBmb3IgdGhlIGRpc2N1c3Npb24hIEkgd2lsbCBwcm9jZWVk
IGFzIHN1Z2dlc3RlZC4NCg0KT25lIHRoaW5nIEkgcmVhbGl6ZWQgd2hpbGUgcmV3b3JraW5nIHRo
ZSBwYXRjaGVzIGZvciB0aGUgYmF0Y2hlZCBjaGVja3MgaXM6DQp3aXRoaW4genN3YXBfc3RvcmVf
cGFnZSgpLCB3ZSBzZXQgdGhlIGVudHJ5LT5vYmpjZyBhbmQgZW50cnktPnBvb2wgYmVmb3JlDQph
ZGRpbmcgaXQgdG8gdGhlIHhhcnJheS4gR2l2ZW4gdGhpcywgd291bGRuJ3QgaXQgYmUgc2FmZXIg
dG8gZ2V0IHRoZSBvYmpjZw0KYW5kIHBvb2wgcmVmZXJlbmNlIHBlciBzdWItcGFnZSwgbG9jYWxs
eSBpbiB6c3dhcF9zdG9yZV9wYWdlKCksIHJhdGhlciB0aGFuDQpvYnRhaW5pbmcgYmF0Y2hlZCBy
ZWZlcmVuY2VzIGF0IHRoZSBlbmQgaWYgdGhlIHN0b3JlIGlzIHN1Y2Nlc3NmdWw/IElmIHdlIHdh
bnQNCnpzd2FwX3N0b3JlX3BhZ2UoKSB0byBiZSBzZWxmLWNvbnRhaW5lZCBhbmQgY29ycmVjdCBh
cyBmYXIgYXMgdGhlIGVudHJ5DQpiZWluZyBjcmVhdGVkIGFuZCBhZGRlZCB0byB0aGUgeGFycmF5
LCBpdCBzZWVtcyBsaWtlIHRoZSByaWdodCB0aGluZyB0byBkbz8NCkkgYW0gYSBiaXQgYXBwcmVo
ZW5zaXZlIGFib3V0IHRoZSBlbnRyeSBiZWluZyBhZGRlZCB0byB0aGUgeGFycmF5IHdpdGhvdXQN
CmEgcmVmZXJlbmNlIG9idGFpbmVkIG9uIHRoZSBvYmpjZyBhbmQgcG9vbCwgYmVjYXVzZSBhbnkg
cGFnZS1mYXVsdHMvd3JpdGViYWNrDQp0aGF0IG9jY3VyIG9uIHN1Yi1wYWdlcyBhZGRlZCB0byB0
aGUgeGFycmF5IGJlZm9yZSB0aGUgZW50aXJlIGZvbGlvIGhhcyBiZWVuDQpzdG9yZWQsIHdvdWxk
IHJ1biBpbnRvIGlzc3Vlcy4NCg0KSnVzdCB3YW50ZWQgdG8gcnVuIHRoaXMgYnkgeW91LiBUaGUg
cmVzdCBvZiB0aGUgYmF0Y2hlZCBjaGFyZ2luZywgYXRvbWljDQphbmQgc3RhdCB1cGRhdGVzIHNo
b3VsZCBiZSBPay4NCg0KVGhhbmtzLA0KS2FuY2hhbmENCg0KPiANCj4gVGhhbmtzLA0KPiBLYW5j
aGFuYQ0K

