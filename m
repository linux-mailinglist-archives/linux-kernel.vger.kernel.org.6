Return-Path: <linux-kernel+bounces-337690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2295D984DA5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 00:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AAE1B22E0C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 22:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E52146D76;
	Tue, 24 Sep 2024 22:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DtL5Sn7G"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26F3768FD
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 22:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727216555; cv=fail; b=nnumQs6texZRVg6WlLTIsm9029WlOtMBUo5DcsuIQsdS5zwIzpyuYGRiaKTeuV1zp9fmPBrLKKP226VrOsYFFSa65WssigsI9udvl4BHbFvzgtzzs+uNppWTKzEmzkhiAelQuI862Sgsl2tbX/iMk7LcLT58DNwLbYUWaUcqTvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727216555; c=relaxed/simple;
	bh=3WXr7YES8zqCoFZN6y5bq10VLqb7/Yhasgq43SBo3+U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oIvIIm5Tx/QWYUIDci43NVq3yT4a7qKQT6sej5hBQyI3LEsMrRPnm0BgT/F5XMSpr++vXrC0MntGznEEuRCQYujC+uH50NIakvOFQPu2rg8eQwC/ftjWvQ02Ms35YOToFP/F7BQnlk83fqAbzQdMrb605DHNbxL39nrWgyebngA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DtL5Sn7G; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727216554; x=1758752554;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3WXr7YES8zqCoFZN6y5bq10VLqb7/Yhasgq43SBo3+U=;
  b=DtL5Sn7GA+VuhjC4XooK0sStCbX15LbytsGyj+kZgeynuJ5CMsiy5AFx
   q25e+WqEKat/ZBU05C3RN1rIHBzyKvS8f9IZ3LPwznjOh8Y6wiyZ95v2w
   l51OjjZHhzmA+sgNFuSBwKk3LiyvLSMUxZOZnKJyCa21lwplafvZFaHdU
   NQB6Svn4g18GlmYkWnjo8PjuXx7btBOP5VNYZhyvlQ71YhN70Ifkb37ZP
   CjRXMlF+/fnoOgZHuzjExply1dG2JQ0WGCCvosZ6l0eoL9BpwYsd5XDgc
   xak2zx7C9o0unXfzhfc/hiG5fBf3FmojlVPx2DJO5mu4sASmUDxrzmBgG
   g==;
X-CSE-ConnectionGUID: weTxGqadRaenusCLyrkJWw==
X-CSE-MsgGUID: n9fOhZMKRDCF9+ualdIkBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="37596273"
X-IronPort-AV: E=Sophos;i="6.10,255,1719903600"; 
   d="scan'208";a="37596273"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 15:22:33 -0700
X-CSE-ConnectionGUID: aqUqxjlvSbualkrjlvAQCA==
X-CSE-MsgGUID: ukTPU2qISOu4+c5Ad5OzYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,255,1719903600"; 
   d="scan'208";a="76323738"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Sep 2024 15:22:33 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 24 Sep 2024 15:22:32 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 24 Sep 2024 15:22:31 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 24 Sep 2024 15:22:31 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 24 Sep 2024 15:22:31 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 24 Sep 2024 15:22:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gHRXcsPmDH2X/fb/9MMCNqIfc76YvwDGyqcJvahaimITNyejQHrQ3bgLDC8c2oqMNYaiVTgw8fCYGtPfq0Esl560l2uj5T3QuxDruDCY0ezqsHqtwEbGKmYLkwjWWodQIiMaJ8zsbHiQYQBB3EUegLeyy4gMxqyzBNZpfE2seHcGF5W0mfi52DrHCIZFCn9Rd7twMm4c9Vi6GidEtEFQSsTJdDMfs7eKFnx2rTI0qNYm5Wg4EdaKdi30Wt18mLKEb8aJ+5PqEtEb5FFfb/b5z2hZo6f85YI+h8lcXR4YaWnX/wCK/o1hpS6JkNAy/+SszveF2dhYs3dQN/7xi3c8Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3WXr7YES8zqCoFZN6y5bq10VLqb7/Yhasgq43SBo3+U=;
 b=cRykEPhqrq3xSgHb7LfhaqM4/Yro0HOlogUXbRRQNvKUmE6/Ru2Ygfw/GxEU/NGIzD3i6TVTPuDMhgSjskTOyNDBK9sLiKmTUfdtuEy538m5zwZsoDBiwEdytgKQCN1E580hrHuentVzNzd/MIYQe3C6MsM2baMRIL7zixHomYnhSH2NRyOlG+zxerT2y3dEKRhcgcHdtCx0jgMlKsANXakcZIjwEvQovXXZCQ/jDAjrc3QodtWk9GV/RHIApRvxYqYeOhjjsD6q2uWHfuqw6vg19JtUiGCjfUwJAA+SFzKvxjZTqDx2cKA/sObXsiP87+m/p4GAhQxGWx+d2KM/Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by LV3PR11MB8674.namprd11.prod.outlook.com (2603:10b6:408:217::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Tue, 24 Sep
 2024 22:22:27 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 22:22:27 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Yosry Ahmed <yosryahmed@google.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "nphamcs@gmail.com" <nphamcs@gmail.com>,
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "shakeel.butt@linux.dev"
	<shakeel.butt@linux.dev>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"Huang, Ying" <ying.huang@intel.com>, "21cnbao@gmail.com"
	<21cnbao@gmail.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"Zou, Nanhai" <nanhai.zou@intel.com>, "Feghali, Wajdi K"
	<wajdi.k.feghali@intel.com>, "Gopal, Vinodh" <vinodh.gopal@intel.com>,
	"Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v7 3/8] mm: zswap: Refactor code to store an entry in
 zswap xarray.
Thread-Topic: [PATCH v7 3/8] mm: zswap: Refactor code to store an entry in
 zswap xarray.
Thread-Index: AQHbDh+An/NTejqrB0+b0E4zOcMAu7JnT9mAgAAz9SA=
Date: Tue, 24 Sep 2024 22:22:27 +0000
Message-ID: <SJ0PR11MB56782B4EFAD5D9E0B3343705C9682@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20240924011709.7037-1-kanchana.p.sridhar@intel.com>
 <20240924011709.7037-4-kanchana.p.sridhar@intel.com>
 <CAJD7tkZbx3q5soiwu1V9pVNCy35QDXK_SFQa6cr19-kXZgU8xw@mail.gmail.com>
In-Reply-To: <CAJD7tkZbx3q5soiwu1V9pVNCy35QDXK_SFQa6cr19-kXZgU8xw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|LV3PR11MB8674:EE_
x-ms-office365-filtering-correlation-id: b281fe1b-577f-42f6-5b75-08dcdce75f90
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eXNmZmxoeHJFMy96b056SGQzMzlPelRCS3l4QmxOUk00bnM0VGZEblZta2d1?=
 =?utf-8?B?c3o5TDJOSE50SGthWWxESUZmeC9GSXFmRVlmSUtuUnQrc09ITzdJOE9vcTk0?=
 =?utf-8?B?bDFWNXpxK3duSTVybk1sNHJuaDhZR1pOUXJ5QnpSUDF3dmVlQU55amxaZk01?=
 =?utf-8?B?ODVIWm4rbDlVS08yNXh1cWdwMHFrZllPcEUrVmR1ZHNNV0lkZ1BKRE5keWg5?=
 =?utf-8?B?bnVmMEQ2L0Z4REtrK1JLMlh4WlE3WWJsNEpMbDhRZVhCdTVBQzRFNzVPVy9u?=
 =?utf-8?B?eW1Wb1llbmkzajZoWUZmWU5zdDkvc29iN00vTnF0d0hBS0hpelZQOWNta3lI?=
 =?utf-8?B?K2djcUV3VUg2bXQxalNzbVBwNE4vRzkyelNDTDlJNkRCM3RQOUhlZUZlcUlC?=
 =?utf-8?B?Y0lMRmp2QmdJd2VocCtwV1JFcGY4cWZORDBrTDQxd2JHeXhZeGNkUWIrUWFT?=
 =?utf-8?B?N21id0xrbmRVZkZzcjduYTRaRDkzbmRqQ0dnQUFsVVlpUEZpN3RFajh4cWhI?=
 =?utf-8?B?dDFOQWVsaVpuNTAwcDd2Zm40azMrVjJwWVI3b0d1ZFltUTJSUXBEeXllaTJB?=
 =?utf-8?B?c1NudlUrdFBKK0pUeGZ1Rk9BTDQwTlQzSmRweUp0S0RqbC9vTmNhbTVUQ2VK?=
 =?utf-8?B?YjlDS3l2WEVDa3M2cXpTZjJTdTV0d3N3SThTNnVoRUQvUW40VDY3ZEVrVDVM?=
 =?utf-8?B?SzJSTWx5TjZDb0Z3TitDbXNmbVZWbHBTVnpGeVBYdHJtaTBYT3BYR29UeWI5?=
 =?utf-8?B?YXk3QlQ0NkFLSk1PRFhsU29EQzRrYjRzS2tXVlZtV2RlRTRET0J4ekRaZ3ZV?=
 =?utf-8?B?ckxzVWUvM2RBQU05OGY5N3hmVGM5WTVmaEhwZmEzN2xkYzNNTk95YkIwOE4y?=
 =?utf-8?B?Wk95VmJwL3l6NlJQWUd4L3JSNEkvWEN5dlpZcVNDTzZpVEx0YmN2UXp1MlY1?=
 =?utf-8?B?ODliRS9lYUFOYmxjVVIyY3JnYnhpV29pTk11aFZUdnkrQ21jZFlPbjNlZy9B?=
 =?utf-8?B?dTBOV3dGK25ERE04WVVTbytUY00rWkVBWmo5ZTlXOW0rNFZyVGhGd3BhSENX?=
 =?utf-8?B?dFhZaVh5ZzdXNlBuNGc1RXFUUjZtTExqd2VCM2UwdXZ5eUhoYWdwS1M0T29h?=
 =?utf-8?B?LzQ0N0cxdW8zTzRFc2NWZDRwUGJvMldlZ3M5SUdibTJuWDB2QmMvYjlWN1ow?=
 =?utf-8?B?bUJ0VGZJWnhTVy94UFUyVndzOTVBY3VpU1NwMkRwOTF1R0RiYTc0bmJYamFG?=
 =?utf-8?B?Smc3OGQvTU5hNHBUOGpBanhTYW5GakJ0c1BHTmp6eEIxMElVaDFscjVmWXZp?=
 =?utf-8?B?Nk45aTh6M240NE82SVJISG9QM2FpNERBY1dMWmVacGxsRUJGQ3dUSHpKcFc3?=
 =?utf-8?B?NytpYlVGQU51NE9HRWdveXBpRFBSMEFOODl2Z2F0TGtqMHBjSzI3aGxzMVFx?=
 =?utf-8?B?OTNnZ2xyem9RZ1BMMytrVEwvYTZSa0hjMlVScFY4NUlaMUsrU3lLeVhtTTBp?=
 =?utf-8?B?YkZGK3JVM0VBaDdsVjUxZ2pWU3JaclhHQzFVOWN6blZZcVYxTHRMODJKUU5S?=
 =?utf-8?B?Ujl0MENUUHVDbDRsWVVLV0o2MzRxWVVJdzJzaEJROWJLdjZyVjBtbWcwOURt?=
 =?utf-8?B?NzdBaVhad21qeVVXT1pGNDVjSVIzb1dNcXozdGFBRWtLTWNteFlBQVV5V2pQ?=
 =?utf-8?B?bWJmZ2dmbUY1eTJkOFMvU0xlLzl6ckd1VXp3WEVJdXNBeHB6TXBKY2lCV0Q1?=
 =?utf-8?B?TDdueURmVWNJbDAzUTIwMTlDdXQvbXdlb2lZTEt3bUt5bzZNYnp0YXBwN1lH?=
 =?utf-8?B?bWNad0JXT2ZTbklPbkVCUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dC9Pa2RmbzVLbVpZNURXL3RTS1hSWlI3a0JBdVBOVXp3c1p6aXdxR2F4OFVz?=
 =?utf-8?B?d3BlSFIxUVRUcGdEdXFLN0lRODZWNUhuWEtoQ2tPeGZGQjBMWXo4TG5IaDNJ?=
 =?utf-8?B?R1FacXhKNXRYQ1h2RjcrbjZkWTBSbm1pVFdkMEtaeXpobm9TNXJINGV0RzhU?=
 =?utf-8?B?ZS9xbEdERTBnR05vV1l3SkcrN1NYNWN2WHlQUDZjVXlVM3QvbjJOMENiV0RG?=
 =?utf-8?B?VVdTZFIxZCtJb1FrRE9tdmlwNFVZdlFUT0JNMWNpN0hmUXdjaG1UYmFIcW5U?=
 =?utf-8?B?S3BmVHIvd1o1ZDNzVUFvTDdQTE9ObXkxd3ltM0JaaXRkc0ZhZG9tTDhaL0JU?=
 =?utf-8?B?SVpua3hud2U5OHF4K0daazUvNExqSm9Td1NnVjk0OEtoWGh4Z3N3NW8rNTNU?=
 =?utf-8?B?UzlDWk1MWUhqK3RFM3hVODNNNTh4NUhBUVJKdXhyMEdGT0VHNGNma3htTWxB?=
 =?utf-8?B?SVZleGh6NVkyNTlrT05GZW9ZMFltUFlONng2QW16RDRxSkF3YVl5RGRmajVn?=
 =?utf-8?B?WTNFaTlzSUk4YXMwQ3ZPZkNpS2pzNWVuTGlEV3J6SjV5dmU4cGxuQUFuakpt?=
 =?utf-8?B?M3hUY2ZNelZ4eXZTeSt5QU1FMWRmbDNmTlk3Q29nNWdpdkttNkY3VmI3RnFr?=
 =?utf-8?B?SzRzbTg0OTk4Z0UwNFIrUmV4aExmWExIbkJaV1hxNTlSWmNXOXpuNW9rd2hy?=
 =?utf-8?B?NWxxdFQvUDd0enBmMk5VU0h3SDRVTEZCbm8rUHdUVmFjNHlXM25HZWJyYWk3?=
 =?utf-8?B?Y1dhWE5hRW9NeUtKellpbXU1NG42QWczUEtXQ1cySmpwekN0V1FIY3hBRGEr?=
 =?utf-8?B?UTFRY0dsR0crYldDdEx4UVBUbnVVeHFJdHJhZnlheTIvNWhteVFBZkI1eXNj?=
 =?utf-8?B?d3VkN25pRGFPeUhXWjhzbytra2tsZkdKZ2ZMYndIWC8vSG9Uckkwc3hvSjly?=
 =?utf-8?B?TFhWSWtybXIxbmdLNmxpN2NoZ1FvTlVHWjdKcGNsOUpSZHdjR250WitWaGxW?=
 =?utf-8?B?ZktSVGh5UUZ3c2paWjF0RjhJRXNjVFAySHN3MDgxZkdQeSsvSkFuR0ZVVEYx?=
 =?utf-8?B?RCtJa2srQjFXN21lOUxnMUxIM2NXam1mSVI2QlliakZGUllueXl0RjhuSWJu?=
 =?utf-8?B?UWxpL2JtN2Fac2RtME1saTZPaXVRNElxRGFIVFhOeXRrV1BaQ1ZwUGh6akRz?=
 =?utf-8?B?WkxaOTdrVU9jRWV1TkNZUi9OTWQrOUI1eFJQVXgxV1BxL1lsTkE3UVhiM05G?=
 =?utf-8?B?S0s0UkIwVkZjRVpxTVltd2puUWpUQm9zaThabVB2eWwyME1FeHJoOVpqeWlp?=
 =?utf-8?B?b3hWUjc3dC9YanZXTkk0QmpSTFVUTnVYRXBIdG04M0EwaW9pcFZpT2JWZEtE?=
 =?utf-8?B?bWhvdTAyWmxzNWcvY2YzNUlEc0pnbGM1bkJGS2VyWUpJeWJML1RHSWVGWUto?=
 =?utf-8?B?Y3lDelN2VzN5UFlxVkp4NmNhRDV1Y0tVOGRqb0c0cFdQMGJKUnNzTHhwZXh2?=
 =?utf-8?B?TUNWUFpDT0svOW53Q1QrY3l6RU9ZdFlXck5BckpiOUNHWU9nV2RVUEUvbHNz?=
 =?utf-8?B?UFc0WUJFTlkrY0R5eFg4emtZdWwwbFM1dTVMeHcxZVIycEtZTmNaL3JqRVNJ?=
 =?utf-8?B?ZTNrM1cwUk9QdzUzR3NuTjRVSUxEa1dxeEpIK1ZlalhmSGJtcDBQZjh4Nlg1?=
 =?utf-8?B?bG9pUysrNGlnekhLRlVZVjkrTWpTM2krOW05MHFpT1VsaDZ2K0hzTlphZ01t?=
 =?utf-8?B?UHNDSTFlMUtISTVTdGs3ZDhSQmZGTGhNRHU5Smg3ZGdQUE1kWWFFekdBbmhp?=
 =?utf-8?B?Y2RsZmhXK2E0SE9KUVlKNW12ZDVYVVdvSi9VTmVVeGpDYjN5cDNVR3hheUJL?=
 =?utf-8?B?ZmJ5Y0RjNkphMWk2d0syL1lEd2lqZUJmRkY3N0lvZWZQbW1LTitEUTNZR0tH?=
 =?utf-8?B?d21mdGJESHBQU1EvaE9jaEoyUzF2cWZoS3l5S2RGSVlaaW52Q29lK2JMNHda?=
 =?utf-8?B?T2tYOUFYSjZNakticThsaTljcmNYeGNoNCtqbHdzVzZRbzR2RkErMXpxYzZ0?=
 =?utf-8?B?QTNJeWZZNmVmaUhHY0llaUNpeWozWmVWVVRVUG01Z3Z4LzgxVmJkMDE5Rklr?=
 =?utf-8?B?YjZrUHpLTUZoT0hlZ05kSFF0ZGIxeHFpMlFjaUlxS1JyMzJSOXQzU1RzdW5T?=
 =?utf-8?B?ZUE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b281fe1b-577f-42f6-5b75-08dcdce75f90
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2024 22:22:27.8189
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TV1H7aELi/jBpg2PLT6cwUGh6sbSch5BVSiDggtYkhOuBnTqwyV8/ylE7eCfe/sZg2AKC3tEOi5W+zSp348fXKsObVUL7PGyzbRg9nm0gwA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8674
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBZb3NyeSBBaG1lZCA8eW9zcnlh
aG1lZEBnb29nbGUuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBTZXB0ZW1iZXIgMjQsIDIwMjQgMTI6
MTUgUE0NCj4gVG86IFNyaWRoYXIsIEthbmNoYW5hIFAgPGthbmNoYW5hLnAuc3JpZGhhckBpbnRl
bC5jb20+DQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1tbUBrdmFj
ay5vcmc7DQo+IGhhbm5lc0BjbXB4Y2hnLm9yZzsgbnBoYW1jc0BnbWFpbC5jb207IGNoZW5nbWlu
Zy56aG91QGxpbnV4LmRldjsNCj4gdXNhbWFhcmlmNjQyQGdtYWlsLmNvbTsgc2hha2VlbC5idXR0
QGxpbnV4LmRldjsgcnlhbi5yb2JlcnRzQGFybS5jb207DQo+IEh1YW5nLCBZaW5nIDx5aW5nLmh1
YW5nQGludGVsLmNvbT47IDIxY25iYW9AZ21haWwuY29tOyBha3BtQGxpbnV4LQ0KPiBmb3VuZGF0
aW9uLm9yZzsgWm91LCBOYW5oYWkgPG5hbmhhaS56b3VAaW50ZWwuY29tPjsgRmVnaGFsaSwgV2Fq
ZGkgSw0KPiA8d2FqZGkuay5mZWdoYWxpQGludGVsLmNvbT47IEdvcGFsLCBWaW5vZGggPHZpbm9k
aC5nb3BhbEBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjcgMy84XSBtbTogenN3
YXA6IFJlZmFjdG9yIGNvZGUgdG8gc3RvcmUgYW4gZW50cnkgaW4NCj4genN3YXAgeGFycmF5Lg0K
PiANCj4gT24gTW9uLCBTZXAgMjMsIDIwMjQgYXQgNjoxN+KAr1BNIEthbmNoYW5hIFAgU3JpZGhh
cg0KPiA8a2FuY2hhbmEucC5zcmlkaGFyQGludGVsLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBBZGRl
ZCBhIG5ldyBwcm9jZWR1cmUgenN3YXBfc3RvcmVfZW50cnkoKSB0aGF0IHJlZmFjdG9ycyB0aGUg
Y29kZQ0KPiA+IGN1cnJlbnRseSBpbiB6c3dhcF9zdG9yZSgpIHRvIHN0b3JlIGFuIGVudHJ5IGlu
IHRoZSB6c3dhcCB4YXJyYXkuDQo+ID4gVGhpcyB3aWxsIGFsbG93IHVzIHRvIGNhbGwgdGhpcyBw
cm9jZWR1cmUgZm9yIGVhY2ggc3RvcmluZyB0aGUgc3dhcA0KPiA+IG9mZnNldCBvZiBlYWNoIHBh
Z2UgaW4gYW4gbVRIUCBpbiB0aGUgeGFycmF5LCBhcyBwYXJ0IG9mIHpzd2FwX3N0b3JlKCkNCj4g
PiBzdXBwb3J0aW5nIG1USFAuDQo+ID4NCj4gPiBBbHNvLCBtYWRlIGEgbWlub3IgZWRpdCBpbiB0
aGUgY29tbWVudHMgZm9yICdzdHJ1Y3QgenN3YXBfZW50cnknIHRvIGRlbGV0ZQ0KPiA+IHRoZSBk
ZXNjcmlwdGlvbiBvZiB0aGUgJ3ZhbHVlJyBtZW1iZXIgdGhhdCB3YXMgZGVsZXRlZCBpbiBjb21t
aXQNCj4gPiAyMGE1NTMyZmZhNTNkNmVjZjQxZGVkOTIwYTdiMGZmOWM2NWE3ZGNmICgibW06IHJl
bW92ZSBjb2RlIHRvDQo+IGhhbmRsZQ0KPiA+IHNhbWUgZmlsbGVkIHBhZ2VzIikuDQo+ID4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBLYW5jaGFuYSBQIFNyaWRoYXIgPGthbmNoYW5hLnAuc3JpZGhhckBp
bnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gIG1tL3pzd2FwLmMgfCA1MSArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQs
IDM0IGluc2VydGlvbnMoKyksIDE3IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBh
L21tL3pzd2FwLmMgYi9tbS96c3dhcC5jDQo+ID4gaW5kZXggNTliNzczM2E2MmQzLi5mZDM1YTgx
YjZlMzYgMTAwNjQ0DQo+ID4gLS0tIGEvbW0venN3YXAuYw0KPiA+ICsrKyBiL21tL3pzd2FwLmMN
Cj4gPiBAQCAtMTkwLDcgKzE5MCw2IEBAIHN0YXRpYyBzdHJ1Y3Qgc2hyaW5rZXIgKnpzd2FwX3No
cmlua2VyOw0KPiA+ICAgKiAgICAgICAgICAgICAgc2VjdGlvbiBmb3IgY29udGV4dC4NCj4gPiAg
ICogcG9vbCAtIHRoZSB6c3dhcF9wb29sIHRoZSBlbnRyeSdzIGRhdGEgaXMgaW4NCj4gPiAgICog
aGFuZGxlIC0genBvb2wgYWxsb2NhdGlvbiBoYW5kbGUgdGhhdCBzdG9yZXMgdGhlIGNvbXByZXNz
ZWQgcGFnZSBkYXRhDQo+ID4gLSAqIHZhbHVlIC0gdmFsdWUgb2YgdGhlIHNhbWUtdmFsdWUgZmls
bGVkIHBhZ2VzIHdoaWNoIGhhdmUgc2FtZSBjb250ZW50DQo+ID4gICAqIG9iamNnIC0gdGhlIG9i
al9jZ3JvdXAgdGhhdCB0aGUgY29tcHJlc3NlZCBtZW1vcnkgaXMgY2hhcmdlZCB0bw0KPiA+ICAg
KiBscnUgLSBoYW5kbGUgdG8gdGhlIHBvb2wncyBscnUgdXNlZCB0byBldmljdCBwYWdlcy4NCj4g
PiAgICovDQo+ID4gQEAgLTE0MDQsMTIgKzE0MDMsNDQgQEAgc3RhdGljIHZvaWQgc2hyaW5rX3dv
cmtlcihzdHJ1Y3Qgd29ya19zdHJ1Y3QNCj4gKncpDQo+ID4gIC8qKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioNCj4gPiAgKiBtYWluIEFQSQ0KPiA+ICAqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqLw0KPiA+ICsNCj4gPiArLyoNCj4gPiArICogUmV0dXJucyB0cnVlIGlm
IHRoZSBlbnRyeSB3YXMgc3VjY2Vzc2Z1bGx5DQo+ID4gKyAqIHN0b3JlZCBpbiB0aGUgeGFycmF5
LCBhbmQgZmFsc2Ugb3RoZXJ3aXNlLg0KPiA+ICsgKi8NCj4gPiArc3RhdGljIGJvb2wgenN3YXBf
c3RvcmVfZW50cnkoc3RydWN0IHhhcnJheSAqdHJlZSwNCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBzdHJ1Y3QgenN3YXBfZW50cnkgKmVudHJ5KQ0KPiANCj4gDQo+IEkgdGhpbmsg
enN3YXBfdHJlZV9zdG9yZSgpIGlzIGEgbW9yZSBkZXNjcmlwdGl2ZSBuYW1lLg0KDQpUaGFua3Mg
WW9zcnkgZm9yIHRoZSBjb2RlIHJldmlldyBjb21tZW50cyENClN1cmUsIHdpbGwgY2hhbmdlIHRo
aXMgdG8genN3YXBfdHJlZV9zdG9yZSgpIGluIHY4LiANCg0KPiANCj4gPg0KPiA+ICt7DQo+ID4g
KyAgICAgICBzdHJ1Y3QgenN3YXBfZW50cnkgKm9sZDsNCj4gPiArICAgICAgIHBnb2ZmX3Qgb2Zm
c2V0ID0gc3dwX29mZnNldChlbnRyeS0+c3dwZW50cnkpOw0KPiANCj4gDQo+IFJldmVyc2UgeG1h
cyB0cmVlIHdoZXJlIHBvc3NpYmxlIHBsZWFzZSAobG9uZ2VzdCB0byBzaG9ydGVzdCBkZWNsYXJh
dGlvbnMpLg0KPiANCj4gPg0KPiA+ICsNCj4gPiArICAgICAgIG9sZCA9IHhhX3N0b3JlKHRyZWUs
IG9mZnNldCwgZW50cnksIEdGUF9LRVJORUwpOw0KPiA+ICsNCj4gDQo+IE5vIG5lZWQgZm9yIHRo
ZSBibGFuayBsaW5lIGhlcmUuDQoNCk9rLCB3aWxsIGZpeCBpbiB2OC4NCg0KVGhhbmtzLA0KS2Fu
Y2hhbmENCg0KPiANCj4gPiArICAgICAgIGlmICh4YV9pc19lcnIob2xkKSkgew0KPiA+ICsgICAg
ICAgICAgICAgICBpbnQgZXJyID0geGFfZXJyKG9sZCk7DQo+ID4gKw0KPiA+ICsgICAgICAgICAg
ICAgICBXQVJOX09OQ0UoZXJyICE9IC1FTk9NRU0sICJ1bmV4cGVjdGVkIHhhcnJheSBlcnJvcjog
JWRcbiIsDQo+IGVycik7DQo+ID4gKyAgICAgICAgICAgICAgIHpzd2FwX3JlamVjdF9hbGxvY19m
YWlsKys7DQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4gPiArICAgICAgIH0N
Cj4gPiArDQo+ID4gKyAgICAgICAvKg0KPiA+ICsgICAgICAgICogV2UgbWF5IGhhdmUgaGFkIGFu
IGV4aXN0aW5nIGVudHJ5IHRoYXQgYmVjYW1lIHN0YWxlIHdoZW4NCj4gPiArICAgICAgICAqIHRo
ZSBmb2xpbyB3YXMgcmVkaXJ0aWVkIGFuZCBub3cgdGhlIG5ldyB2ZXJzaW9uIGlzIGJlaW5nDQo+
ID4gKyAgICAgICAgKiBzd2FwcGVkIG91dC4gR2V0IHJpZCBvZiB0aGUgb2xkLg0KPiA+ICsgICAg
ICAgICovDQo+ID4gKyAgICAgICBpZiAob2xkKQ0KPiA+ICsgICAgICAgICAgICAgICB6c3dhcF9l
bnRyeV9mcmVlKG9sZCk7DQo+ID4gKw0KPiA+ICsgICAgICAgcmV0dXJuIHRydWU7DQo+ID4gK30N
Cj4gPiArDQo+ID4gIGJvb2wgenN3YXBfc3RvcmUoc3RydWN0IGZvbGlvICpmb2xpbykNCj4gPiAg
ew0KPiA+ICAgICAgICAgc3dwX2VudHJ5X3Qgc3dwID0gZm9saW8tPnN3YXA7DQo+ID4gICAgICAg
ICBwZ29mZl90IG9mZnNldCA9IHN3cF9vZmZzZXQoc3dwKTsNCj4gPiAgICAgICAgIHN0cnVjdCB4
YXJyYXkgKnRyZWUgPSBzd2FwX3pzd2FwX3RyZWUoc3dwKTsNCj4gPiAtICAgICAgIHN0cnVjdCB6
c3dhcF9lbnRyeSAqZW50cnksICpvbGQ7DQo+ID4gKyAgICAgICBzdHJ1Y3QgenN3YXBfZW50cnkg
KmVudHJ5Ow0KPiA+ICAgICAgICAgc3RydWN0IG9ial9jZ3JvdXAgKm9iamNnID0gTlVMTDsNCj4g
PiAgICAgICAgIHN0cnVjdCBtZW1fY2dyb3VwICptZW1jZyA9IE5VTEw7DQo+ID4NCj4gPiBAQCAt
MTQ2NSwyMiArMTQ5Niw4IEBAIGJvb2wgenN3YXBfc3RvcmUoc3RydWN0IGZvbGlvICpmb2xpbykN
Cj4gPiAgICAgICAgIGVudHJ5LT5vYmpjZyA9IG9iamNnOw0KPiA+ICAgICAgICAgZW50cnktPnJl
ZmVyZW5jZWQgPSB0cnVlOw0KPiA+DQo+ID4gLSAgICAgICBvbGQgPSB4YV9zdG9yZSh0cmVlLCBv
ZmZzZXQsIGVudHJ5LCBHRlBfS0VSTkVMKTsNCj4gPiAtICAgICAgIGlmICh4YV9pc19lcnIob2xk
KSkgew0KPiA+IC0gICAgICAgICAgICAgICBpbnQgZXJyID0geGFfZXJyKG9sZCk7DQo+ID4gLQ0K
PiA+IC0gICAgICAgICAgICAgICBXQVJOX09OQ0UoZXJyICE9IC1FTk9NRU0sICJ1bmV4cGVjdGVk
IHhhcnJheSBlcnJvcjogJWRcbiIsDQo+IGVycik7DQo+ID4gLSAgICAgICAgICAgICAgIHpzd2Fw
X3JlamVjdF9hbGxvY19mYWlsKys7DQo+ID4gKyAgICAgICBpZiAoIXpzd2FwX3N0b3JlX2VudHJ5
KHRyZWUsIGVudHJ5KSkNCj4gPiAgICAgICAgICAgICAgICAgZ290byBzdG9yZV9mYWlsZWQ7DQo+
ID4gLSAgICAgICB9DQo+ID4gLQ0KPiA+IC0gICAgICAgLyoNCj4gPiAtICAgICAgICAqIFdlIG1h
eSBoYXZlIGhhZCBhbiBleGlzdGluZyBlbnRyeSB0aGF0IGJlY2FtZSBzdGFsZSB3aGVuDQo+ID4g
LSAgICAgICAgKiB0aGUgZm9saW8gd2FzIHJlZGlydGllZCBhbmQgbm93IHRoZSBuZXcgdmVyc2lv
biBpcyBiZWluZw0KPiA+IC0gICAgICAgICogc3dhcHBlZCBvdXQuIEdldCByaWQgb2YgdGhlIG9s
ZC4NCj4gPiAtICAgICAgICAqLw0KPiA+IC0gICAgICAgaWYgKG9sZCkNCj4gPiAtICAgICAgICAg
ICAgICAgenN3YXBfZW50cnlfZnJlZShvbGQpOw0KPiA+DQo+ID4gICAgICAgICBpZiAob2JqY2cp
IHsNCj4gPiAgICAgICAgICAgICAgICAgb2JqX2Nncm91cF9jaGFyZ2VfenN3YXAob2JqY2csIGVu
dHJ5LT5sZW5ndGgpOw0KPiA+IC0tDQo+ID4gMi4yNy4wDQo+ID4NCg==

