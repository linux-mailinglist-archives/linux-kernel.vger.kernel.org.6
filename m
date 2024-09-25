Return-Path: <linux-kernel+bounces-339543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB979866AB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 21:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8365CB22634
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 19:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECF213D61B;
	Wed, 25 Sep 2024 19:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gmmr0Fab"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9731315AC4
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 19:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727291413; cv=fail; b=XreoaQwIQJ3ZRsCpnN2Hk2p8qoRnUDeb9NZX6M0TMLIoykWCk6RL6tJegr0sCpxS9KE4J6Sa4UZO8e7ZNuT4FkprTq6tvmwCos7GWrYhMU0G/IRrcOxQKKynbsexRbIeSr81Xc7oO7dL3Ww4Elogr02v5rehHhak/8tyk1Gb3vc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727291413; c=relaxed/simple;
	bh=GFJRsa5TwG34nDT4M7D0f5OMICdqbT5mUnMMwSjpRsU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZOkY+ImKcslsGxBM0QIhPym5AfyQ1jj0LtTM5bGWZGUvvzKoXsP+8DyyMe+gXGuP8PPNw43S1Dp7fea5wESzeuLZgywzPt/fG/O3cFn2JxfcZZmwJdTChm7Yi/CkdgakHo6TajzeTLMtClPdkqCUnH0VUxW6PKeirMSFVvSbeV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gmmr0Fab; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727291412; x=1758827412;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GFJRsa5TwG34nDT4M7D0f5OMICdqbT5mUnMMwSjpRsU=;
  b=gmmr0FabSCOd3pw4hLNOsGJsZG1HRvIFiBAvWs5duS+Fysz4itjYIEsh
   MbRKk6X6qrP9+baUWBmJiYRTIxgarr2k2WLD7haoEXIHQvAlkeMs/mBog
   SYXRSN41maVmH5x2HYIZ/eg+Rks5GWcEHlb9I9pjNrpRhY/Ci+B21nPAS
   uPYuSLfZvl1blPn+5zSB+hwp9GT64AdEt45W256DNDLKEMoRXz6BgWgJI
   n41CHl+RZ7ZfleD+BMSyBKDocOT/mBBgRCPloS677uPNp2fET8UtkdOV5
   VrTxqcSP+05BOhFLZs6On7Mfc6TiRwI0AraJeTaoZz7hBHd3u4t7TxCot
   w==;
X-CSE-ConnectionGUID: fX3R/ROzTPqXtqvt7k3eDA==
X-CSE-MsgGUID: KaOblkCWQqyiCgvszgHVYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="51777661"
X-IronPort-AV: E=Sophos;i="6.10,258,1719903600"; 
   d="scan'208";a="51777661"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 12:10:10 -0700
X-CSE-ConnectionGUID: dko+78jpRym7Dage/V+r8Q==
X-CSE-MsgGUID: sGjKNwjGQHC3crdg61WhaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,258,1719903600"; 
   d="scan'208";a="71960822"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Sep 2024 12:10:10 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 25 Sep 2024 12:10:09 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 25 Sep 2024 12:10:09 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 25 Sep 2024 12:10:09 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 25 Sep 2024 12:10:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cX2GntDB72AiOF0wRbCZpBM3cfwRySBfATXN71F3cO+3d/XZaT4xtaKLBNXxQDmQV8tSeZuRBVQzsUHTYCpgbBlmROc+iuIm4/+toEvm/OtJun0/pLdpuQ4tUBg8gaEdUdYxkafHTucRxkzm+RPRgkmaQGhadMbwq1aVaYlAsuC4thACm4RUloHW+SLEe12ft0E4jvVclMVkYefhQbyai4BKaIl0EARIijDLKxjjKngS5Mid2fQH/xywIhY8BZysR8NHaMHeyrIrke+v8jn1t+Cmc/APuc7vOmWin1hYCv9frbpyqS2qZlRz2dKfV9S+b8qbVj2s9VP7ssth76TMYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GFJRsa5TwG34nDT4M7D0f5OMICdqbT5mUnMMwSjpRsU=;
 b=wAeE9rNjjcf9Cpx3NTSk4Jg+W25XlPrgQcftAFVjpW1fBC40sayotOMvKPMxZs8Z2cIAQMU8or9NRwm/FBi5lICa6iYB0ANN62YW0ETmdGyTi4aeDk8iw3S+2xtt97+x2BHnZA1XQ0ywWHHc802R1N5y76719I2zuY2oH2uT7iUdeMxqbz207pLS9yMv+IB1MaDU0Kas61vY+22jEVhY8YeryKG4T0R505gcAs0f94IyT0P85SKTPgXpFBRnmsneIIOISHJOpIBYQcX+tjm1LdHdDtBmGUm/IeMeNZ5SlDL9B0WsnETQjJP4LU2CYAVTozUwFUo8EKgF1QMaL0dKhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by DM6PR11MB4692.namprd11.prod.outlook.com (2603:10b6:5:2aa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Wed, 25 Sep
 2024 19:10:04 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 19:10:04 +0000
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
Thread-Index: AQHbDh+C+ZYgIzdq4EuvViy0xt7aPLJnVm0AgAEuMgCAAFEmAIAABXGg
Date: Wed, 25 Sep 2024 19:10:04 +0000
Message-ID: <SJ0PR11MB56784B0D0EC2348A0ED7542CC9692@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20240924011709.7037-1-kanchana.p.sridhar@intel.com>
 <20240924011709.7037-7-kanchana.p.sridhar@intel.com>
 <CAJD7tkbd=H+=wx0gnu8sh44hOmx7BE3G3oSxi7zt+o3HKJthkA@mail.gmail.com>
 <20240925134008.GA875661@cmpxchg.org>
 <CAJD7tkY8D14j-e6imW9NxZCjTbx8tu_VaKDbRRQMdSeKX_kBuw@mail.gmail.com>
In-Reply-To: <CAJD7tkY8D14j-e6imW9NxZCjTbx8tu_VaKDbRRQMdSeKX_kBuw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|DM6PR11MB4692:EE_
x-ms-office365-filtering-correlation-id: ad1a4d8f-7021-440e-e4c6-08dcdd95a9a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?L2N1cWZWMEtKZGxWQW1HK2JTOU16dllRUWs5aWZaaDFXaU5UZU1wWGtGczdN?=
 =?utf-8?B?dnNoWVFSaFJlTkJaVmNTa3pIdm1ZWHRtS1pvc0JscVUrWkFoSFc4M1NtWGdm?=
 =?utf-8?B?cEpwVjhuZENNZ3gyWFZoOVp2NlFHTE5lQjJvcnZPZWZRKys0a0t3VlRNdmNX?=
 =?utf-8?B?QlpwbkVNaDhydWlIekwySFVwL2NrVG1XaWdzWm5VdmxtbndoMjgyVGU4YWR4?=
 =?utf-8?B?MmVNc1k3bUVuYnp4cndSMklNUytaVTA5Z2dYbjgvWjdPajlqaExNVWhEc3Y4?=
 =?utf-8?B?SmlYaTNiSHN1ZVkzWUlUMlNRMWZJS0tmMUJRRGw1dzBGK3ZxMFdncTRYS1M4?=
 =?utf-8?B?azlBZ1BqNk15eERtMHREQ2wzRlkzbStYT3RzVzh3blNhNHlWRGlIVUlVVVlh?=
 =?utf-8?B?MzBMaWU3WXg0MTdVWGVkVGNVWnpzeFRyMlpNTlhtMzNnQmMzQ0tLYkd0UWli?=
 =?utf-8?B?RGR1T2UxNHhQWE5TelVXU09yalFyMUx4VVNsbGZaNEdzVDlpc1FXeG1hRU1x?=
 =?utf-8?B?VEk4SXdsK3laRWRRY3liaTdER1gxMkdRS2VPdlVMekF4enl3SzQ4MXMyUjlF?=
 =?utf-8?B?ZVUrWTNwQUVzSklocjlKVHkwck0vZW12UDNUcW83TlNOK3BBaUVNVUxzZmlw?=
 =?utf-8?B?dngyalZjNEcvcVlHdjJMNFV0WHJuZEkrQ0tYazNzN3QzMzdFSnc0NTFGQkow?=
 =?utf-8?B?QlVLN0tFaTBUbkw5WjVianNrVU91bGVBbUQ5T3ZkWUFHMWhDcG50T3dJU3R3?=
 =?utf-8?B?Rm9UendIOTFybjZOVnFmS1R5QjJiSnQ3WjVTU1ZSbkNEUHNDSEU4VnFuTTgr?=
 =?utf-8?B?MEg1UWlMS3hkcnVRdXVPUVhQSDZMQ2ZoMUVIdXZiWmY0NGgxLzFhSXpGVTZp?=
 =?utf-8?B?UGUySU9tUnRoZkFoc0ZjV3JmVVJYY2N3SnlncVVhMDg5YnpreTVHTmNqSDk0?=
 =?utf-8?B?ZGliRCtPN1NRRUZHdjdHbFJFY2ZrSjVnTGVoNGpTb1F5bFpkdkhncUJ6WlFr?=
 =?utf-8?B?ZjRTSlVtcG1LUlJia2JjZEM4MWRXNExNcTNWTzVhM2kyWlIvZndNMklzcFI2?=
 =?utf-8?B?MXBKY0NhTDVtOFRZS0E3d3h0Sko3Vk5ndXVEZWhMaHR6dHoyeXc0cG16Z0pZ?=
 =?utf-8?B?dVJxMFR0N0loZk1Mc00vcGVPczA1NGowbjBCUzdSUCtCa3FjaWsvK09VQTJu?=
 =?utf-8?B?UjZ2YisxS1VUa2hNd05zOXhGY09UZ0p3YkFMc1JVbzluWHR6a0ovaDkrWUF1?=
 =?utf-8?B?STZiQUJzM2liVzZZYkpRVHkyODJQckpJekdvSjVUOXBYY0l6cnpkM25pbjY2?=
 =?utf-8?B?V1FRd0xuQXpRWFZXLzQvODYxVkE0VitIVFZLZVZ2M1dOTUgyUGVubExtRnV0?=
 =?utf-8?B?MEl3ZmJnOFJGY2IyMjJEdy8wdHh4RmFTclFiNEYybHJ5YllQako3TXhqQkx0?=
 =?utf-8?B?d1R5QVR4NTlHT3MwV1FER2thTkMrVjNYK3R2V3dwWW5NQWlndTNkbTk1N0pQ?=
 =?utf-8?B?M3AvRXdkZTdCby84anZzcm9jZXZBZ0wzVlFqUmNPOUIyYWJ3QXdvZW9udEw2?=
 =?utf-8?B?Vkx4cnJhYlp3SDdqOVgrejNkZVV1cXpKV05BYWpwekFaeFNxSDNBZ0x5UjZt?=
 =?utf-8?B?YXlWaE5LR0pyOTN3NWExUHNzSTIvSXRmNVZmanhKZmRCOGlIK1h4T2xJTWF1?=
 =?utf-8?B?bU44VmdLekllUFJMaUxqT1R0a3AwUkljRnlGYlk4d2RRWVFJOVU2SDQ5aDVr?=
 =?utf-8?B?OFkyYk1aOG9mZk8yY0EvVXlJMEVma3hRS3RpQlUrQytTcThySll6eVhZNURR?=
 =?utf-8?B?WS9ObmEvK3Q3MHVHRjJ1Zz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UTVwY1BUUzBkbTdtb2VZSVFENk5OdDJod0hxdTE0TFJ1UStSNldhM25iQ0Er?=
 =?utf-8?B?YnFub1hQbjlsNmJ5dzllaktjVk9ITVNPTzk2WEFDUC93QnY1UTFMbEMvUmh6?=
 =?utf-8?B?b2NkYitsTS9lclNid3FQeDEyaVFpRUJXRkZmSDFZK1M2cys0SHV6N0p2alFP?=
 =?utf-8?B?K3E3ckZyK2ZWTjlnYVc2eHc0cXVRTXN6bnp3TVc0U1g5QXFRWmhnSExLdXRh?=
 =?utf-8?B?R29VZElSTUwrdDhJWDFlcG5xeEpZM3VqOElPOWhLNUVGeGEvMHoxZEE3dmpV?=
 =?utf-8?B?SWdqcmlaTEdNV0xOaTVXVndMZlpVcUtYZkVjTjZKcjJQSkphU2RsbzI5cGJu?=
 =?utf-8?B?QlUzbjNzMzNFaW92TllZa1FOcXpJN1lONUM1RkpUbHBpZzV2blhiNUlsMENy?=
 =?utf-8?B?eWhaNXdyRDNFVmlYaElCelRXTzF3NzdnU2VoeDNIVTBsZzdzeEltSkIrVkZi?=
 =?utf-8?B?ais0M3hzL1d2MUlucENJUlpRdllYcFFYdnprREdWbHhxRUV1bll0RndVejZ6?=
 =?utf-8?B?QzBxbDYyekErbC96NlpoQlhncmRXdFFmUUNvRFRZVWRDV3lPWk01YkRMajQ1?=
 =?utf-8?B?d0RZbDlMY0ZIQXRmRmc2QTlkYVdlVS9GbGV5K2RYVUpONHlMRGsvY21KQjg1?=
 =?utf-8?B?V0EvQkI3b3ZkRHZGWVhZbno2ay9qakxkSmdiYzBCY0krK1VIR3Z2VVlxY3Rz?=
 =?utf-8?B?cVhEMEp2ZkRqSUlpV0lnSVBndFliRG5rNmhzSG1TZER0eEkxa0ljaGR1SC9Z?=
 =?utf-8?B?NjVKQ0N6bUk2aU1Wc3E5dWpYYjE2MkxUNC83RjE4aW5oeUdvZ0t3V0xHdnUv?=
 =?utf-8?B?bGFRN09JR3JiV0UvN3NkTGtBclZsejFaeE5lRFltaUxNTGlMM1V4QVptV1Y5?=
 =?utf-8?B?dFJqMUE1djVCYlRPaXZmUndxMzZTeHhmN3hPN2tLYVdJK0VVeXNIZjNubnpE?=
 =?utf-8?B?b3RYaVMvbWZUaE0xTEdLZTZqUmtFejBkYmNCa0xOa2p2TmdMTXVodzRTMTc3?=
 =?utf-8?B?ZE9ZSXlDZ2tIK09SUGEzdUptdjFBN0RPdzYvSVkzczZvdGpqWmlqMHZua2lE?=
 =?utf-8?B?Yy9GK2hvWnR1eXpZMUtiSGwrUDBpa0lmWmNDYlFzd2J4UE81RkNrZXEvVjFV?=
 =?utf-8?B?M0E3UnpzVnRtN0ZCUkJXL3JiOEhTMERLTzQwdFhkOCtNNHVCWVpsUHo4dEJG?=
 =?utf-8?B?ajR1dFpxSEhFS3d1QnZPd3VHVHFWMlIwM2tENHcxSzZoQWFETzNzWGtBSjEz?=
 =?utf-8?B?ZUNLbkJBRGRqRkU1dUw4Q3NLV0toazhZdWI0VXNXSERtMmZHSm85OXV2cDNj?=
 =?utf-8?B?SDRFbzNNVjFza0R6c1lZSHlDM0ZEY0pvbFRqNGZlRHpKeVRscitwSWFkdHVs?=
 =?utf-8?B?aWdqamYwWEpxWTdyeFpyRHhMRjhEbzBrK2ZBZHJlaitDcWVaZEFlTlB4WWhE?=
 =?utf-8?B?SG42REF6bEJBNjZsKzFadE43RjF3NDRidGR6VnVIdTFmeXlQTmFRV2dhNk9L?=
 =?utf-8?B?b0F4WHQxS2RaQkdraThOL1JBWUNuOTQwT2doUHZIWGE5ampXMkhqci9kbGph?=
 =?utf-8?B?Y2pYS3NWcDkrWitpZkVmWi9QNmQxWG9aV09vUjRuRlJRL1NOZGZxS2Y5alRx?=
 =?utf-8?B?NnRjYmRjbmFYUTVRNkRnQzhML01kbjZUc3N0SmRlYTFwNmpVOHRCVlEwSzMw?=
 =?utf-8?B?TVRVQkpRVnVYMFcxMEV0UmcyK1BkdzJzVWtvb0I5T0dhdEFHZTZUcFZ2ZnVN?=
 =?utf-8?B?dGd6NFZaMUxCZE9nTGxwZjEzY0VKS3B1b1N4OFhaZ0dtd0JtM0dNUlJkNUZ5?=
 =?utf-8?B?dnJPQndpSEF1NWVOY0VPanNERGZtYUlVMGNpdEd2YkF0aGhXTEx1NVpHNVFa?=
 =?utf-8?B?azl2dUJyYmtCTHU4azNZTXI1dDFSOC9NNkVUSVI1Kzl6M0NMdDJXM0szSVFi?=
 =?utf-8?B?dWp2YkNrSnZrekVvYnIwTjVyeFdqazd2LzMyVmduZ0xMT3oxd2l1TkpyREtK?=
 =?utf-8?B?TnQ0YW9VSGMzVjFuVmdiSVFXNjZMKzhDNkYxSi9jNmdNZ3IwbHliZzA1NkNr?=
 =?utf-8?B?QkU2bnl5b25TZnZnVjhSWEpoZzZVSFVFeWczdExTUVhWN1M4Nm0zVWU2eXNV?=
 =?utf-8?B?Z1NCUytvYXhmRzMvbGVFL1NqSDEwV2cxS2JKWkozTnBYM0MzZzJHOHZ4bnoy?=
 =?utf-8?B?UGc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ad1a4d8f-7021-440e-e4c6-08dcdd95a9a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2024 19:10:04.5444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gMTdpvQsTIRNWLIPDng1eoGBsKrwQAvDxwOI+5AmP60z3gB31cK81pjJUz7uJIA0RljvS8M+rXPaIxzAALE+/zQpz12x6XT1bbbDXylR+j0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4692
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBZb3NyeSBBaG1lZCA8eW9zcnlh
aG1lZEBnb29nbGUuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIFNlcHRlbWJlciAyNSwgMjAyNCAx
MTozMSBBTQ0KPiBUbzogSm9oYW5uZXMgV2VpbmVyIDxoYW5uZXNAY21weGNoZy5vcmc+DQo+IENj
OiBTcmlkaGFyLCBLYW5jaGFuYSBQIDxrYW5jaGFuYS5wLnNyaWRoYXJAaW50ZWwuY29tPjsgbGlu
dXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LW1tQGt2YWNrLm9yZzsgbnBoYW1j
c0BnbWFpbC5jb207DQo+IGNoZW5nbWluZy56aG91QGxpbnV4LmRldjsgdXNhbWFhcmlmNjQyQGdt
YWlsLmNvbTsNCj4gc2hha2VlbC5idXR0QGxpbnV4LmRldjsgcnlhbi5yb2JlcnRzQGFybS5jb207
IEh1YW5nLCBZaW5nDQo+IDx5aW5nLmh1YW5nQGludGVsLmNvbT47IDIxY25iYW9AZ21haWwuY29t
OyBha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnOw0KPiBab3UsIE5hbmhhaSA8bmFuaGFpLnpvdUBp
bnRlbC5jb20+OyBGZWdoYWxpLCBXYWpkaSBLDQo+IDx3YWpkaS5rLmZlZ2hhbGlAaW50ZWwuY29t
PjsgR29wYWwsIFZpbm9kaCA8dmlub2RoLmdvcGFsQGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6
IFtQQVRDSCB2NyA2LzhdIG1tOiB6c3dhcDogU3VwcG9ydCBtVEhQIHN3YXBvdXQgaW4NCj4genN3
YXBfc3RvcmUoKS4NCj4gDQo+IFsuLl0NCj4gPiA+ID4gKyAgICAgICAvKg0KPiA+ID4gPiArICAg
ICAgICAqIENoZWNrIGNncm91cCBsaW1pdHM6DQo+ID4gPiA+ICsgICAgICAgICoNCj4gPiA+ID4g
KyAgICAgICAgKiBUaGUgY2dyb3VwIHpzd2FwIGxpbWl0IGNoZWNrIGlzIGRvbmUgb25jZSBhdCB0
aGUgYmVnaW5uaW5nIG9mIGFuDQo+ID4gPiA+ICsgICAgICAgICogbVRIUCBzdG9yZSwgYW5kIG5v
dCB3aXRoaW4genN3YXBfc3RvcmVfcGFnZSgpIGZvciBlYWNoIHBhZ2UNCj4gPiA+ID4gKyAgICAg
ICAgKiBpbiB0aGUgbVRIUC4gV2UgZG8gaG93ZXZlciBjaGVjayB0aGUgenN3YXAgcG9vbCBsaW1p
dHMgYXQgdGhlDQo+ID4gPiA+ICsgICAgICAgICogc3RhcnQgb2YgenN3YXBfc3RvcmVfcGFnZSgp
LiBXaGF0IHRoaXMgbWVhbnMgaXMsIHRoZSBjZ3JvdXANCj4gPiA+ID4gKyAgICAgICAgKiBjb3Vs
ZCBnbyBvdmVyIHRoZSBsaW1pdHMgYnkgYXQgbW9zdCAoSFBBR0VfUE1EX05SIC0gMSkgcGFnZXMu
DQo+ID4gPiA+ICsgICAgICAgICogSG93ZXZlciwgdGhlIHBlci1zdG9yZS1wYWdlIHpzd2FwIHBv
b2wgbGltaXRzIGNoZWNrIHNob3VsZA0KPiA+ID4gPiArICAgICAgICAqIGhvcGVmdWxseSB0cmln
Z2VyIHRoZSBjZ3JvdXAgYXdhcmUgYW5kIHpzd2FwIExSVSBhd2FyZSBnbG9iYWwNCj4gPiA+ID4g
KyAgICAgICAgKiByZWNsYWltIGltcGxlbWVudGVkIGluIHRoZSBzaHJpbmtlci4gSWYgdGhpcyBh
c3N1bXB0aW9uIGhvbGRzLA0KPiA+ID4gPiArICAgICAgICAqIHRoZSBjZ3JvdXAgZXhjZWVkaW5n
IHRoZSB6c3dhcCBsaW1pdHMgY291bGQgcG90ZW50aWFsbHkgYmUNCj4gPiA+ID4gKyAgICAgICAg
KiByZXNvbHZlZCBiZWZvcmUgdGhlIG5leHQgenN3YXBfc3RvcmUsIGFuZCBpZiBpdCBpcyBub3Qs
IHRoZSBuZXh0DQo+ID4gPiA+ICsgICAgICAgICogenN3YXBfc3RvcmUgd291bGQgZmFpbCB0aGUg
Y2dyb3VwIHpzd2FwIGxpbWl0IGNoZWNrIGF0IHRoZSBzdGFydC4NCj4gPiA+ID4gKyAgICAgICAg
Ki8NCj4gPiA+DQo+ID4gPiBJIGRvIG5vdCByZWFsbHkgbGlrZSB0aGlzLiBBbGxvd2luZyBnb2lu
ZyBvbmUgcGFnZSBhYm92ZSB0aGUgbGltaXQgaXMNCj4gPiA+IG9uZSB0aGluZywgYnV0IG9uZSBU
SFAgYWJvdmUgdGhlIGxpbWl0IHNlZW1zIHRvbyBtdWNoLiBJIGFsc28gZG9uJ3QNCj4gPiA+IGxp
a2UgcmVseWluZyBvbiB0aGUgcmVwZWF0ZWQgbGltaXQgY2hlY2tpbmcgaW4genN3YXBfc3RvcmVf
cGFnZSgpLCBpZg0KPiA+ID4gYW55dGhpbmcgSSB0aGluayB0aGF0IHNob3VsZCBiZSBiYXRjaGVk
IHRvby4NCj4gPiA+DQo+ID4gPiBJcyBpdCB0b28gdW5yZWFzb25hYmxlIHRvIG1haW50YWluIHRo
ZSBhdmVyYWdlIGNvbXByZXNzaW9uIHJhdGlvIGFuZA0KPiA+ID4gdXNlIHRoYXQgdG8gZXN0aW1h
dGUgbGltaXQgY2hlY2tpbmcgZm9yIGJvdGggbWVtY2cgYW5kIGdsb2JhbCBsaW1pdHM/DQo+ID4g
PiBKb2hhbm5lcywgTmhhdCwgYW55IHRob3VnaHRzIG9uIHRoaXM/DQo+ID4NCj4gPiBJIGhvbmVz
dGx5IGRvbid0IHRoaW5rIGl0J3MgbXVjaCBvZiBhbiBpc3N1ZS4gVGhlIGdsb2JhbCBsaW1pdCBp
cw0KPiA+IGh1Z2UsIGFuZCB0aGUgY2dyb3VwIGxpbWl0IGlzIHRvIHRoZSBiZXN0IG9mIG15IGtu
b3dsZWRnZSBvbmx5IHVzZWQgYXMNCj4gPiBhIGJpbmFyeSBzd2l0Y2guIFNldHRpbmcgYSBub24t
YmluYXJ5IGxpbWl0IC0gZ2xvYmFsIG9yIGNncm91cCAtIHNlZW1zDQo+ID4gbGlrZSBhIGJpdCBv
ZiBhbiBvYnNjdXJlIHVzZWNhc2UgdG8gbWUsIGJlY2F1c2UgaW4gdGhlIHZhc3QgbWFqb3JpdHkN
Cj4gPiBvZiBjYXNlcyBpdCdzIHByZWZlcmFibGUgdG8ga2VlcCBjb21wcmVzaW5nIG92ZXIgZGVj
bGFyaW5nIE9PTS4NCj4gPg0KPiA+IEFuZCBldmVuIGlmIHlvdSBkbyBoYXZlIHNvbWUgZ3JhbnVs
YXIgbGltaXQsIHRoZSB3b3JrbG9hZCBzaXplIHNjYWxlcw0KPiA+IHdpdGggaXQuIEl0J3Mgbm90
IGxpa2UgeW91IGhhdmUgYSB0aG91c2FuZCBUSFBzIGluIGEgMTBNIGNncm91cC4NCj4gDQo+IFRo
ZSBtZW1jZyBsaW1pdCBhbmQgenN3YXAgbGltaXQgY2FuIGJlIGRpc3Byb3BvcnRpb25hdGUsIGFs
dGhvdWdoIHRoYXQNCj4gc2hvdWxkbid0IGJlIGNvbW1vbi4NCj4gDQo+ID4NCj4gPiBJZiB0aGlz
IGV2ZXIgYmVjb21lcyBhbiBpc3N1ZSwgd2UgY2FuIGhhbmRsZSBpdCBpbiBhIGZhc3RwYXRoLXNs
b3dwYXRoDQo+ID4gc2NoZW1lOiBjaGVjayB0aGUgbGltaXQgdXAgZnJvbnQgZm9yIGZhc3QtcGF0
aCBmYWlsdXJlIGlmIHdlJ3JlDQo+ID4gYWxyZWFkeSBtYXhlZCBvdXQsIGp1c3QgbGlrZSBub3c7
IHRoZW4gbWFrZSBvYmpfY2dyb3VwX2NoYXJnZV96c3dhcCgpDQo+ID4gYXRvbWljYWxseSBjaGFy
Z2UgYWdhaW5zdCB6c3dhcC5tYXggYW5kIHVud2luZCB0aGUgc3RvcmUgaWYgd2UgcmFjZWQuDQo+
ID4NCj4gPiBGb3Igbm93LCBJIHdvdWxkIGp1c3Qga2VlcCB0aGUgc2ltcGxlIHZlcnNpb24gd2Ug
Y3VycmVudGx5IGhhdmU6IGNoZWNrDQo+ID4gb25jZSBpbiB6c3dhcF9zdG9yZSgpIGFuZCB0aGVu
IGp1c3QgZ28gYWhlYWQgZm9yIHRoZSB3aG9sZSBmb2xpby4NCj4gDQo+IEkgYW0gbm90IHRvdGFs
bHkgYWdhaW5zdCB0aGlzIGJ1dCBJIGZlZWwgbGlrZSB0aGlzIGlzIHRvbyBvcHRpbWlzdGljLg0K
PiBJIHRoaW5rIHdlIGNhbiBrZWVwIGl0IHNpbXBsZS1pc2ggYnkgbWFpbnRhaW5pbmcgYW4gZXdt
YSBmb3IgdGhlDQo+IGNvbXByZXNzaW9uIHJhdGlvLCB3ZSBhbHJlYWR5IGhhdmUgcHJpbWl0aXZl
cyBmb3IgdGhpcyAoc2VlDQo+IERFQ0xBUkVfRVdNQSkuDQo+IA0KPiBUaGVuIGluIHpzd2FwX3N0
b3JlKCksIHdlIGNhbiB1c2UgdGhlIGV3bWEgdG8gZXN0aW1hdGUgdGhlIGNvbXByZXNzZWQNCj4g
c2l6ZSBhbmQgdXNlIGl0IHRvIGRvIHRoZSBtZW1jZyBhbmQgZ2xvYmFsIGxpbWl0IGNoZWNrcyBv
bmNlLCBsaWtlIHdlDQo+IGRvIHRvZGF5LiBJbnN0ZWFkIG9mIGp1c3QgY2hlY2tpbmcgaWYgd2Ug
YXJlIGJlbG93IHRoZSBsaW1pdHMsIHdlDQo+IGNoZWNrIGlmIHdlIGhhdmUgZW5vdWdoIGhlYWRy
b29tIGZvciB0aGUgZXN0aW1hdGVkIGNvbXByZXNzZWQgc2l6ZS4NCj4gVGhlbiB3ZSBjYWxsIHpz
d2FwX3N0b3JlX3BhZ2UoKSB0byBkbyB0aGUgcGVyLXBhZ2Ugc3R1ZmYsIHRoZW4gZG8NCj4gYmF0
Y2hlZCBjaGFyZ2luZyBhbmQgc3RhdHMgdXBkYXRlcy4NCj4gDQo+IElmIHlvdSB0aGluayB0aGF0
J3MgYW4gb3ZlcmtpbGwgd2UgY2FuIGtlZXAgZG9pbmcgdGhlIGxpbWl0IGNoZWNrcyBhcw0KPiB3
ZSBkbyB0b2RheSwNCj4gYnV0IEkgd291bGQgc3RpbGwgbGlrZSB0byBzZWUgYmF0Y2hpbmcgb2Yg
YWxsIHRoZSBsaW1pdCBjaGVja3MsDQo+IGNoYXJnaW5nLCBhbmQgc3RhdHMgdXBkYXRlcy4gSXQg
bWFrZXMgbGl0dGxlIHNlbnNlIG90aGVyd2lzZS4NCg0KVGhhbmtzIEpvaGFubmVzIGFuZCBZb3Ny
eSBmb3IgdGhlc2Ugc3VnZ2VzdGlvbnMgYW5kIHBvaW50ZXJzLg0KSSB0aGluayB0aGVyZSBpcyBn
ZW5lcmFsIGFncmVlbWVudCBhYm91dCB0aGUgYmF0Y2ggY2hhcmdpbmcgYW5kDQp6c3dhcF9zdG9y
ZWRfcGFnZXMvc3RhdHMgdXBkYXRlcy4gWW9zcnksICBkb2VzICJiYXRjaGluZyBvZiBsaW1pdA0K
Y2hlY2tzIiBpbXBseSB0aGUgc2FtZSBhcyBhIHNpbXBsZSBjaGVjayBmb3IgYmVpbmcgb3ZlciB0
aGUgY2dyb3VwDQpsaW1pdCBhdCB0aGUgc3RhcnQgb2YgenN3YXBfc3RvcmUgYW5kIG5vdCBkb2lu
ZyB0aGlzIGNoZWNrIGluDQp6c3dhcF9zdG9yZV9wYWdlPyBEb2VzIHRoaXMgYWxzbyBpbXBseSBh
IHpzd2FwX3Bvb2xfZ2V0X21hbnkoKT8NCldvdWxkIGFwcHJlY2lhdGUgaXQgaWYgeW91IGNhbiBo
ZWxwIGNsYXJpZnkuDQoNClRoZSBtYWluIHF1ZXN0aW9uIGluIG15IG1pbmQgYWJvdXQgdXNpbmcg
dGhlIEVXTUEgY2hlY2tzIGlzLA0Kd2lsbCBpdCBhZGQgb3ZlcmhlYWQgdG8gdGhlIG5vcm1hbCB6
c3dhcCByZWNsYWltIHBhdGg7IGFuZCBpZiBzbywNCndvdWxkIGEgc2ltcGxlIGxpbWl0IGNoZWNr
IGF0IHRoZSBzdGFydCBvZiB6c3dhcF9zdG9yZSBhcyBzdWdnZXN0ZWQNCmJ5IEpvaGFubmVzIHN1
ZmZpY2UuIEkgY2FuIHJ1biBhIGZldyBleHBlcmltZW50cyB0byBxdWFudGlmeSB0aGlzDQpvdmVy
aGVhZCwgYW5kIG1heWJlIHdlIGNhbiByZXZpc2l0IHRoaXM/DQoNClRoYW5rcywNCkthbmNoYW5h
DQoNCg==

