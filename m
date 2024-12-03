Return-Path: <linux-kernel+bounces-430223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 789389E2E0A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 22:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42CA41612C9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 21:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1044B204F7A;
	Tue,  3 Dec 2024 21:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WJCz0gNK"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E21A1CFA9
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 21:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733261124; cv=fail; b=lmkf3S4A5p9BAnHDZkl+PpRKy8Hd7VTVJFJHCsVZLI7DDSVm8XpEKszP76vhF1pwES3h2VSpHHwF2Jhg0Oiw1HMOQZQM3wU0wXBagEoxaInf6mdLXI4XZ+nY/NC2Uuv97JcoYbnWrbN3pnpJJmE1e8h/t94yH/KV/hQ1sh9roYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733261124; c=relaxed/simple;
	bh=lPFpIBE63iCrVrDVsntVkHNVN8qfxEtHHFUZStrMNOY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B2YHKl5QsEhKw0Kx9509VWxmTYG8y+q/MLslr9Aya8bf/WN7rFsTqDs+QkgGvJzdzEw+goHhaA6Tr5aX3rzrhCGq8NxgXI/FI63ycnAftwEZhQk//EQPna1XqZMtHHrLS4CZULBKcOON8LcmEYxH4pK5QFZr8f2eoG8BsrO0Bk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WJCz0gNK; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733261122; x=1764797122;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lPFpIBE63iCrVrDVsntVkHNVN8qfxEtHHFUZStrMNOY=;
  b=WJCz0gNKg9d59XyiJnraGt2TLI31IPMWIhrmIHpcc8gliqYAhqJlXL+R
   ddFYJmziT67D9vcKg47/VigCcI7OkLPGzXY3w/VjvDzOhES2J0FBcFq4t
   XRlia2OLJmB0+4BqFtOQFmehTIsP2K1F9vWpIJ8pnRcXWP4HLqoSK4VXO
   pRbsnCZRezG3LVnDD1M5LDTYZXRGzqHukQvxX4JfzQBCnmPQL8QNa269J
   dcrcaYU63jy3TOXPLgd34MTF0V1k0Arkb11N9Q0NvEtBsTuP9gCg0o1je
   TZ9b6m4rTdIlDTDPQj4RTgMslyv5ktJ6LzsiRCRveRhQ+VaExeojUVauW
   g==;
X-CSE-ConnectionGUID: q/AIXRjITa6kI3nO0byk/A==
X-CSE-MsgGUID: OSaE7y5hSHiDnCN2yXURvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="44113794"
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="44113794"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 13:25:20 -0800
X-CSE-ConnectionGUID: a1jBUC6iTZaLxq3qHXQ4Vg==
X-CSE-MsgGUID: /QMxC2lIQFeqoKrQQMKK8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="97990162"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Dec 2024 13:25:20 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 3 Dec 2024 13:25:19 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 3 Dec 2024 13:25:19 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 3 Dec 2024 13:25:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SA+5wH9GSUnVwCAL+OFj0DZsC5Nh6t7qEMOlUHKsweLQYBvOwi/1fsqFdmDwT7qRkktJAen56KLqAfttSRluWOsH6yLAvKPc0Qp2/i3gHfva1uPp1Wgod6/q6X3DLLDSjVsGQgTTI9d0RMGesdftk97035gDtPT1MuyZic9ghb18gp+Apopr/XgmPEmu8X7EnNq/5nbfplGFsGvta3qWYvv257WZ8M5knbzxl24NMbv0XxP6eNvWZeGoV5RKXtH7FeNbiCrjvm9vjkSgfYQmm2AnKgM4lz6j7U0Plx8clLXwq2b8Y0ICcMkCuUQHNUzU9OtNUuw6uRt36bdWAsyyVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lPFpIBE63iCrVrDVsntVkHNVN8qfxEtHHFUZStrMNOY=;
 b=pHho/TD1QcRqkxuVcRJ38+uoKauOx0F4/0bkEHc6Ue74QOltqmI1WaBHLkyLq4ecs3PEsk99LS21sn9yplHEd+ujcOWMlJFKtxlXaN76Wd6AzU+chFl3zf1WYMf4mh1qdg9bER1IISvGKjjl/7ruIjy1q2mnjNgS3xiQSqX/N3t6ZGht2hOpXPA1GtK83eYl7R1iSvbz4+47rd2S6EueGp7V4NOjuTSQPNKuxH5z3EoONDP1rl1zhKGBrYlP13X7Acc+c6Ar4Ww648I0x9s6G53Rl93aeDwfdBNU/77E8T+o8E3u0jCinCqYgJ21JvEGZdXSrucTlgS5/p5M0vaOkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by IA1PR11MB7725.namprd11.prod.outlook.com (2603:10b6:208:3fd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 21:25:15 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 21:25:15 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Yosry Ahmed <yosryahmed@google.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "nphamcs@gmail.com" <nphamcs@gmail.com>,
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "ryan.roberts@arm.com"
	<ryan.roberts@arm.com>, "21cnbao@gmail.com" <21cnbao@gmail.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "Feghali, Wajdi K"
	<wajdi.k.feghali@intel.com>, "Gopal, Vinodh" <vinodh.gopal@intel.com>,
	"Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v1 1/2] mm: zswap: Modified zswap_store_page() to process
 multiple pages in a folio.
Thread-Topic: [PATCH v1 1/2] mm: zswap: Modified zswap_store_page() to process
 multiple pages in a folio.
Thread-Index: AQHbQR8z89lEf8biJ0CnjBE4/UFOYbLTX/yAgABbggCAAEw8gIABCWUA
Date: Tue, 3 Dec 2024 21:25:14 +0000
Message-ID: <SJ0PR11MB567887110153519F38044861C9362@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20241127225324.6770-1-kanchana.p.sridhar@intel.com>
 <20241127225324.6770-2-kanchana.p.sridhar@intel.com>
 <CAJD7tkYZSWL9WQ9X9UMLNTbDcF0hX=t90Ouf22WWHrcUvXyPRg@mail.gmail.com>
 <SJ0PR11MB5678D7B05A23EB9DB9ACC267C9362@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkZMzHXWDPsAhd+JTm24LfKG+MT+kOm167EjzuYjCiBq5A@mail.gmail.com>
In-Reply-To: <CAJD7tkZMzHXWDPsAhd+JTm24LfKG+MT+kOm167EjzuYjCiBq5A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|IA1PR11MB7725:EE_
x-ms-office365-filtering-correlation-id: 4dde4990-4117-48de-5a6a-08dd13e0fa6f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|10070799003|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cTJ6N0FoNEEvMUFZdm9ZQXVJTEpNdTN3UDdsQlFGSEYrdGYwWk1WbnlBaDNU?=
 =?utf-8?B?TlhvOGlyYlZac09OVjhoRW5rWDZoeWRQY29ZbUlTdEZMOFNUYXArSjF6RlUw?=
 =?utf-8?B?LzZDbGNCQW5rZzA1R3R1V0VyQnAzNzlKckNUekdlMlQxRHZZcUpoL1F3ZVlS?=
 =?utf-8?B?SUlmckMxemdueGFMM2g0Sk9DZXphVDdydCtBSjZrdTZrOHl6VU4xbWRUeG9J?=
 =?utf-8?B?TVY2dWhJMmtHbWdCOWF5dzdNOWhKRUFTQVZXVWVZVEZFdUdmZDNlL2hMQ2Nv?=
 =?utf-8?B?bWk1aCthcUFOblN3aTNxTmVBOXZsUEwrbmRkcDVqSW5qOVkyRDZLWDNQZGE2?=
 =?utf-8?B?d0tIVTgvck4zbnIzU2h1LytCUmxFWlRJTnQ2MnBEYUlxK0RNcFZycll1eVl6?=
 =?utf-8?B?aTBZU3k4aGVEUHhScHVveTRCVjZ2dFBYc2hXcSt1RWt1cVIyM3grLy94T3N1?=
 =?utf-8?B?SmlrZDNzbkdiV2FQNVZUWUZjSFFEUnd2NG1EWjZiU3hhOEFTZGdIYUpBODcy?=
 =?utf-8?B?TUppQWppL2VhRk1qNzNaR0duSmgzbW5kL0FxT3NnZ2Y3RFNHU09lRjhGKzlV?=
 =?utf-8?B?VzFBOXppREw4akhYRFA1OFRzTDY4Q01xMm5EcFp1OXBNVXFLN0I1L3JUTS9W?=
 =?utf-8?B?OFhWVGZmSktvRlJSdG9ZRm5RQ1NGYWNyQ3RMTjV6dXk5YWp5emFzVkVoQ0VR?=
 =?utf-8?B?akNyejU0NHN4cTN6bW00bDZYREo3VFdYa1ByQVQ1ZWs2ZU9PcldRUGVaVXNq?=
 =?utf-8?B?T1krWG0wU3Ayby9jNW1SM0ZqdmNhWERza3V3NHIwMHk4NGJYSWY1MEZJb251?=
 =?utf-8?B?VkYzKzkvRjdBL1hDVUZIdWVQV2lDSVRRdncxRC8yZFgzUDRUUFJjcytYeTdi?=
 =?utf-8?B?ai8xd2M0RTVPb00ydEYrMG9RNzEvbjlwcnFFRURqWk1rbHNQTW1FT1FOY3Z2?=
 =?utf-8?B?RzFBTFZCdGNzOXFWc1UxQXBzQVdLQUljbWl1YlFtUkJJR2daR2FxRnc2WUNk?=
 =?utf-8?B?NWsrTUFFTGZNYy83Tlltd2NUc2ExQmdyOUxwRDRKRHcrOXRleEpDSWFmeU5p?=
 =?utf-8?B?bThQNG8vb3lGd0UzYjhkc0MxZ2xWMEt6NDhUMHN1eThhbjJ6TWVaMkVUM1ds?=
 =?utf-8?B?ZXVPN21FdndzcjFlYm1qTmcxWTJRb2EyQ2tkaW5FaERKeDVsZ3BxSCtoZnN2?=
 =?utf-8?B?SllIZlNjOFM4ZjVoTDA2WWFkOTRsZ3BsQWxlR0VxVmZYanUrWjduTFJkRkp4?=
 =?utf-8?B?c0JRR3RLS2FISElNMlY1MHpZWnhIMGZCUVV1enUyWG1EU3h6TXlobWNQbTlF?=
 =?utf-8?B?NDVhaVhCM3ovdWRNUXBnZW55NlRFb1FIcTdYK20vT2tucU9RNldSaEh2ZytV?=
 =?utf-8?B?SnllOER6UE1JWjhiQ2N4bDRydWljL3BWTWZCUkZwaWZpalhHTHdiZTRIa3hI?=
 =?utf-8?B?djNwOVdaZzJMNzF6Nk11bVRDQ1k4VmJGQzl2MDNJamZUcVVid0RBQ1dTMUhM?=
 =?utf-8?B?ZE9BbU5US0RXV1Zha3Q1cjlUa3NzQlNBS3hWblZ3alNGL3BOd3MrSkx0d2ZX?=
 =?utf-8?B?elJWdXlPQWxjTy8zUDMxaGdRTktDdG5NeHg5bVM2emR1SFM5aFVZL3loaFZa?=
 =?utf-8?B?QVBkNWZjaCtTSU92SE5MeCtsRm4yQzU3Z00yOEhCNm55N3lKRVdkdjVrLzNx?=
 =?utf-8?B?OFBXbk1XYkNwVmNySUg3ajJCSTMvY2daVFArTWRXZ3VscDR5eEM1dmNGSVBz?=
 =?utf-8?B?VXRJaEM2bTZzY21pSmFnRUllWHoyeHcyaGtVcTE1ZGlMc3cyOTJrVHRoWDJq?=
 =?utf-8?B?aEVNMmt1NHlPemIyNVpLR3ZUMFZpdS9LTnRuTEJwaHZybTR1TGZjWitMTkNX?=
 =?utf-8?B?Z3kwbEg1amNxbi93OHR0dTVQUHdtMXE5a0xrZm5VL1g4MkE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(10070799003)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QXlmQmNGcEhxdlRqd3FIbVl5T0QxZ0k2VVhYQjdUc0ZyWHIrSGxrMlcwdUhw?=
 =?utf-8?B?aTM3Q1Y5RzZENmhRYU9aTFI3UE5mU1FyTkVpL3NKRjF5cXMwNHR0NTJneHZB?=
 =?utf-8?B?dGNCdDdVRUhvSDBMM0R2WW9zTnNNY1ZsRjgwS1Z0d3R1SFdjV2Z6Q2E4aUV4?=
 =?utf-8?B?TjlreFQvZHRObjVmTE83MDd5MTVzUW1rakQ2L0lwOFQyMGhjNlBOUktiV3BX?=
 =?utf-8?B?L2MrK3NuUXVCN2ZSRWFQOTUweldHOHg3V2htUTd1VWJZQnBUc1RWS3lYV3Fv?=
 =?utf-8?B?UFJoL3dPejdobGhoajlKOElKS3M5NVF1eHU3SFdTWW1aK1NnajJ1Z0JTWllx?=
 =?utf-8?B?MWZZc1lYNzNEeFhTRGgrUUUzVDY2RmFpa0tiWjRTb1AvOVpMdXB1MnBiUWVa?=
 =?utf-8?B?bnRpWTdJc0lYV2lMSUNRNEdwY1MzdERXOXRmbENvNEdWSndpeW5Vc1puNU9n?=
 =?utf-8?B?bU1GeXh3akhidUpJVjN5a2oxd3R5ajZpWWp4dnJRYURlb0laNVZZUmlmb1hs?=
 =?utf-8?B?VTNVb0ZXTThMa01aRDVNUHhwQUdaSVVocjh5VE5QZFl1cTRqMTRDZnRiZG1V?=
 =?utf-8?B?aTFOdFY3aFdZSVk3emo1MlllU2tYUmpFeGdFb3VKdndtclZMTEVKanRZTGp4?=
 =?utf-8?B?TWpRMnk2T3orL2d4Q3UwQzZ6WlI3OHUvTSs0Y0Fadk56MTB2NEgrb2dYbEtt?=
 =?utf-8?B?eW5udmhRTjRlNVJEd3QzVXRITkJqUGFlaW1xZ3g3UG9LK2FiMzdHYVQ3S1ov?=
 =?utf-8?B?NExqQmExaFRhYzV1MlNpVHpNeDNJNkF1RktrTWVTNi9hWGl2VURHRTdGRk5R?=
 =?utf-8?B?RXhIWFd4ck50MUVYT0ZJN1hsV2s3L2RFL0pKYWt1eUJXc2tYLzVWc3pJZHZs?=
 =?utf-8?B?VlRGZ2hNUEhjc3FIQmRKZjJPWGdPbmdQK1gxbXpmUG9GQ2R4UWVkWjVEUU03?=
 =?utf-8?B?T1dsemxKdjJhSnMxZVRwUmMwdWZTRVBqeFdtSVJYOGErdjRmdGNFQnN0YVJv?=
 =?utf-8?B?K05EZ25YaDNpd3Y2aVVEWWhpbXQyOEpySTkxWWppWXhUczQ5ckNFdTV5STZz?=
 =?utf-8?B?NnorT3hXZDJSTzBDTDNIOUl2V3ZjY2dFQW9IT3F1Z0lBR2xtOVVPQmF1WWYw?=
 =?utf-8?B?d2hYZmY0QUNkR2xocnYwemVSUU5QeHBqM1E4N1gyRTJqUjlPUTR4NmxyWGk1?=
 =?utf-8?B?NFNEVlZYN3duRUJvbkNPdURsQUNaVkQvMkI3S2lBY1k5cEFYZCs2WUhKYTJX?=
 =?utf-8?B?aUUyTktJb1ZXM1Y3b0xDNHB2TGR1aWhnYWVpWlI3dHFwOE00NGp3TzNsOG5x?=
 =?utf-8?B?Q0ZreHpJeDd3K0g1R21KSGgzNmtkUXI2ejdYUlZrSGhEeDd6YkowUjg1WnFI?=
 =?utf-8?B?RnB4ZlhJRHJKWjVLTnRtakFtMWxMVG1XRnRwaWk1c0x6OFFHK2k2bDZNUnhC?=
 =?utf-8?B?WGhuZks5UlNSREp1andyOG50ZVlxeDIyNmNvbDhDeFNBWjZDYnU1eVBjdWt2?=
 =?utf-8?B?aUtjVUlvVHU3bUVYS2tGZjBIM0pxVFlDaDc2UjE0N3ZldVpCTjlqMGNremhY?=
 =?utf-8?B?c0tWVTZ6QktoVldRbE1XM015U1ZVU1dsdGhCOXlqY1YrbVA0UEtWbjVEYWVF?=
 =?utf-8?B?bnJUV3BQdUJmU0tOelViMzBORXdubEJsK1BjQjJBOTBNSHhab1MrTVp0WjEr?=
 =?utf-8?B?NEpnVFhBVGJndWlCeU4rWklwaURBNU8zNkpRNWZjNlZNOFNianBKRFpSMkh0?=
 =?utf-8?B?VHBuUklPaG1UVmZrejFwL2lOcTFKeU94Z2pXZkYzaDNwTkZERkhyY3VMSUN3?=
 =?utf-8?B?cTdEVzJya0grOVdLY3pTYUpFVndielNtQUNlVlNZMmdVY1NvSi9scjRZR3la?=
 =?utf-8?B?V0hwMThMTElMMS9rbHFVVHNyNXFZVHcyS0x3MzZBN3grYnNONDVvSzloT29i?=
 =?utf-8?B?YXNVRitRT1hnTGdqbFQxQU1SQmFGWVRCSVFwT1hNY09ZUGVsSEZRaHJNcTNC?=
 =?utf-8?B?cmdwRGk4bWlUekF6eG1UTkJ0K3NLTXZnZlA0TjgyWk1IRk5pNGppUHNBaFZz?=
 =?utf-8?B?dnYyQ1Z4ZU1KSFRENjd2ZDZxejZoWlRmM1JWeCtEaU5laXJXSnNaTnh0dGxL?=
 =?utf-8?B?QzBZTG5maUZGR2dzdkVWNHJaTVZWUGVRQzBKNkVjQ1VTZWJqdmphTGZDTGh5?=
 =?utf-8?B?bDNrRnJWa2VxRVF3YUx2RlQvaEk1MnV1TTZuc0lpUnNCVm1HKzFsdmZZd2dN?=
 =?utf-8?B?LytWMXZUU3ZNWkNJeHJMY0dNY2tnPT0=?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dde4990-4117-48de-5a6a-08dd13e0fa6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2024 21:25:15.0812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fXOgNDPnbDPvnprlfe6smjxyuMjNj+qD79qE3SpO3D39hM1+uEBryv+VqCaqyHm/S4msOv6mBF5/iWnp7ACXiO7kTKUQRVGw9Dy00p9Nags=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7725
X-OriginatorOrg: intel.com

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFlvc3J5IEFobWVkIDx5b3Ny
eWFobWVkQGdvb2dsZS5jb20+DQo+IFNlbnQ6IE1vbmRheSwgRGVjZW1iZXIgMiwgMjAyNCA5OjM0
IFBNDQo+IFRvOiBTcmlkaGFyLCBLYW5jaGFuYSBQIDxrYW5jaGFuYS5wLnNyaWRoYXJAaW50ZWwu
Y29tPg0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtbW1Aa3ZhY2su
b3JnOw0KPiBoYW5uZXNAY21weGNoZy5vcmc7IG5waGFtY3NAZ21haWwuY29tOyBjaGVuZ21pbmcu
emhvdUBsaW51eC5kZXY7DQo+IHVzYW1hYXJpZjY0MkBnbWFpbC5jb207IHJ5YW4ucm9iZXJ0c0Bh
cm0uY29tOyAyMWNuYmFvQGdtYWlsLmNvbTsNCj4gYWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZzsg
RmVnaGFsaSwgV2FqZGkgSyA8d2FqZGkuay5mZWdoYWxpQGludGVsLmNvbT47DQo+IEdvcGFsLCBW
aW5vZGggPHZpbm9kaC5nb3BhbEBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEg
MS8yXSBtbTogenN3YXA6IE1vZGlmaWVkIHpzd2FwX3N0b3JlX3BhZ2UoKSB0bw0KPiBwcm9jZXNz
IG11bHRpcGxlIHBhZ2VzIGluIGEgZm9saW8uDQo+IA0KPiBPbiBNb24sIERlYyAyLCAyMDI0IGF0
IDU6MTPigK9QTSBTcmlkaGFyLCBLYW5jaGFuYSBQDQo+IDxrYW5jaGFuYS5wLnNyaWRoYXJAaW50
ZWwuY29tPiB3cm90ZToNCj4gPg0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPiA+ID4gRnJvbTogWW9zcnkgQWhtZWQgPHlvc3J5YWhtZWRAZ29vZ2xlLmNvbT4NCj4gPiA+
IFNlbnQ6IE1vbmRheSwgRGVjZW1iZXIgMiwgMjAyNCAxMTozNCBBTQ0KPiA+ID4gVG86IFNyaWRo
YXIsIEthbmNoYW5hIFAgPGthbmNoYW5hLnAuc3JpZGhhckBpbnRlbC5jb20+DQo+ID4gPiBDYzog
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtbW1Aa3ZhY2sub3JnOw0KPiA+ID4g
aGFubmVzQGNtcHhjaGcub3JnOyBucGhhbWNzQGdtYWlsLmNvbTsNCj4gY2hlbmdtaW5nLnpob3VA
bGludXguZGV2Ow0KPiA+ID4gdXNhbWFhcmlmNjQyQGdtYWlsLmNvbTsgcnlhbi5yb2JlcnRzQGFy
bS5jb207IDIxY25iYW9AZ21haWwuY29tOw0KPiA+ID4gYWtwbUBsaW51eC1mb3VuZGF0aW9uLm9y
ZzsgRmVnaGFsaSwgV2FqZGkgSw0KPiA8d2FqZGkuay5mZWdoYWxpQGludGVsLmNvbT47DQo+ID4g
PiBHb3BhbCwgVmlub2RoIDx2aW5vZGguZ29wYWxAaW50ZWwuY29tPg0KPiA+ID4gU3ViamVjdDog
UmU6IFtQQVRDSCB2MSAxLzJdIG1tOiB6c3dhcDogTW9kaWZpZWQgenN3YXBfc3RvcmVfcGFnZSgp
IHRvDQo+ID4gPiBwcm9jZXNzIG11bHRpcGxlIHBhZ2VzIGluIGEgZm9saW8uDQo+ID4gPg0KPiA+
ID4gT24gV2VkLCBOb3YgMjcsIDIwMjQgYXQgMjo1M+KAr1BNIEthbmNoYW5hIFAgU3JpZGhhcg0K
PiA+ID4gPGthbmNoYW5hLnAuc3JpZGhhckBpbnRlbC5jb20+IHdyb3RlOg0KPiA+ID4gPg0KPiA+
ID4gPiBNb2RpZmllZCB6c3dhcF9zdG9yZSgpIHRvIHN0b3JlIHRoZSBmb2xpbyBpbiBiYXRjaGVz
IG9mDQo+ID4gPiA+IFNXQVBfQ1JZUFRPX0JBVENIX1NJWkUgcGFnZXMuIEFjY29yZGluZ2x5LCBy
ZWZhY3RvcmVkDQo+ID4gPiB6c3dhcF9zdG9yZV9wYWdlKCkNCj4gPiA+ID4gaW50byB6c3dhcF9z
dG9yZV9wYWdlcygpIHRoYXQgcHJvY2Vzc2VzIGEgcmFuZ2Ugb2YgcGFnZXMgaW4gdGhlIGZvbGlv
Lg0KPiA+ID4gPiB6c3dhcF9zdG9yZV9wYWdlcygpIGlzIGEgdmVjdG9yaXplZCB2ZXJzaW9uIG9m
IHpzd2FwX3N0b3JlX3BhZ2UoKS4NCj4gPiA+ID4NCj4gPiA+ID4gRm9yIG5vdywgenN3YXBfc3Rv
cmVfcGFnZXMoKSB3aWxsIHNlcXVlbnRpYWxseSBjb21wcmVzcyB0aGVzZSBwYWdlcw0KPiB3aXRo
DQo+ID4gPiA+IHpzd2FwX2NvbXByZXNzKCkuDQo+ID4gPiA+DQo+ID4gPiA+IFRoZXNlIGNoYW5n
ZXMgYXJlIGZvbGxvdy11cCB0byBjb2RlIHJldmlldyBjb21tZW50cyByZWNlaXZlZCBmb3IgWzFd
LA0KPiBhbmQNCj4gPiA+ID4gYXJlIGludGVuZGVkIHRvIHNldCB1cCB6c3dhcF9zdG9yZSgpIGZv
ciBiYXRjaGluZyB3aXRoIEludGVsIElBQS4NCj4gPiA+ID4NCj4gPiA+ID4gWzFdOiBodHRwczov
L3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtDQo+ID4gPiBtbS9wYXRjaC8yMDI0
MTEyMzA3MDEyNy4zMzI3NzMtMTEta2FuY2hhbmEucC5zcmlkaGFyQGludGVsLmNvbS8NCj4gPiA+
ID4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogS2FuY2hhbmEgUCBTcmlkaGFyIDxrYW5jaGFuYS5w
LnNyaWRoYXJAaW50ZWwuY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gIGluY2x1ZGUvbGludXgv
enN3YXAuaCB8ICAgMSArDQo+ID4gPiA+ICBtbS96c3dhcC5jICAgICAgICAgICAgfCAxNTQgKysr
KysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gPiA+ICAyIGZpbGVz
IGNoYW5nZWQsIDg4IGluc2VydGlvbnMoKyksIDY3IGRlbGV0aW9ucygtKQ0KPiA+ID4gPg0KPiA+
ID4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC96c3dhcC5oIGIvaW5jbHVkZS9saW51eC96
c3dhcC5oDQo+ID4gPiA+IGluZGV4IGQ5NjFlYWQ5MWJmMS4uMDVhODFlNzUwNzQ0IDEwMDY0NA0K
PiA+ID4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3pzd2FwLmgNCj4gPiA+ID4gKysrIGIvaW5jbHVk
ZS9saW51eC96c3dhcC5oDQo+ID4gPiA+IEBAIC03LDYgKzcsNyBAQA0KPiA+ID4gPg0KPiA+ID4g
PiAgc3RydWN0IGxydXZlYzsNCj4gPiA+ID4NCj4gPiA+ID4gKyNkZWZpbmUgU1dBUF9DUllQVE9f
QkFUQ0hfU0laRSA4VUwNCj4gPiA+ID4gIGV4dGVybiBhdG9taWNfbG9uZ190IHpzd2FwX3N0b3Jl
ZF9wYWdlczsNCj4gPiA+ID4NCj4gPiA+ID4gICNpZmRlZiBDT05GSUdfWlNXQVANCj4gPiA+ID4g
ZGlmZiAtLWdpdCBhL21tL3pzd2FwLmMgYi9tbS96c3dhcC5jDQo+ID4gPiA+IGluZGV4IGY2MzE2
YjY2ZmIyMy4uYjA5ZDEwMjNlNzc1IDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9tbS96c3dhcC5jDQo+
ID4gPiA+ICsrKyBiL21tL3pzd2FwLmMNCj4gPiA+ID4gQEAgLTE0MDksNzggKzE0MDksOTYgQEAg
c3RhdGljIHZvaWQgc2hyaW5rX3dvcmtlcihzdHJ1Y3QNCj4gd29ya19zdHJ1Y3QNCj4gPiA+ICp3
KQ0KPiA+ID4gPiAgKiBtYWluIEFQSQ0KPiA+ID4gPiAgKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKi8NCj4gPiA+ID4NCj4gPiA+ID4gLXN0YXRpYyBzc2l6ZV90IHpzd2FwX3N0b3Jl
X3BhZ2Uoc3RydWN0IHBhZ2UgKnBhZ2UsDQo+ID4gPiA+IC0gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgc3RydWN0IG9ial9jZ3JvdXAgKm9iamNnLA0KPiA+ID4gPiAtICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHN0cnVjdCB6c3dhcF9wb29sICpwb29sKQ0KPiA+ID4gPiArLyoN
Cj4gPiA+ID4gKyAqIFN0b3JlIG11bHRpcGxlIHBhZ2VzIGluIEBmb2xpbywgc3RhcnRpbmcgZnJv
bSB0aGUgcGFnZSBhdCBpbmRleCBAc2kNCj4gdXAgdG8NCj4gPiA+ID4gKyAqIGFuZCBpbmNsdWRp
bmcgdGhlIHBhZ2UgYXQgaW5kZXggQGVpLg0KPiA+ID4gPiArICovDQo+ID4gPiA+ICtzdGF0aWMg
c3NpemVfdCB6c3dhcF9zdG9yZV9wYWdlcyhzdHJ1Y3QgZm9saW8gKmZvbGlvLA0KPiA+ID4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBsb25nIHNpLA0KPiA+ID4gPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBsb25nIGVpLA0KPiA+ID4gPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBzdHJ1Y3Qgb2JqX2Nncm91cCAqb2JqY2csDQo+ID4gPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB6c3dhcF9wb29sICpwb29sKQ0K
PiA+ID4gPiAgew0KPiA+ID4gPiAtICAgICAgIHN3cF9lbnRyeV90IHBhZ2Vfc3dwZW50cnkgPSBw
YWdlX3N3YXBfZW50cnkocGFnZSk7DQo+ID4gPiA+ICsgICAgICAgc3RydWN0IHBhZ2UgKnBhZ2U7
DQo+ID4gPiA+ICsgICAgICAgc3dwX2VudHJ5X3QgcGFnZV9zd3BlbnRyeTsNCj4gPiA+ID4gICAg
ICAgICBzdHJ1Y3QgenN3YXBfZW50cnkgKmVudHJ5LCAqb2xkOw0KPiA+ID4gPiArICAgICAgIHNp
emVfdCBjb21wcmVzc2VkX2J5dGVzID0gMDsNCj4gPiA+ID4gKyAgICAgICB1OCBucl9wYWdlcyA9
IGVpIC0gc2kgKyAxOw0KPiA+ID4gPiArICAgICAgIHU4IGk7DQo+ID4gPiA+ICsNCj4gPiA+ID4g
KyAgICAgICBmb3IgKGkgPSAwOyBpIDwgbnJfcGFnZXM7ICsraSkgew0KPiA+ID4gPiArICAgICAg
ICAgICAgICAgcGFnZSA9IGZvbGlvX3BhZ2UoZm9saW8sIHNpICsgaSk7DQo+ID4gPiA+ICsgICAg
ICAgICAgICAgICBwYWdlX3N3cGVudHJ5ID0gcGFnZV9zd2FwX2VudHJ5KHBhZ2UpOw0KPiA+ID4g
PiArDQo+ID4gPiA+ICsgICAgICAgICAgICAgICAvKiBhbGxvY2F0ZSBlbnRyeSAqLw0KPiA+ID4g
PiArICAgICAgICAgICAgICAgZW50cnkgPSB6c3dhcF9lbnRyeV9jYWNoZV9hbGxvYyhHRlBfS0VS
TkVMLA0KPiA+ID4gcGFnZV90b19uaWQocGFnZSkpOw0KPiA+ID4gPiArICAgICAgICAgICAgICAg
aWYgKCFlbnRyeSkgew0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICB6c3dhcF9yZWpl
Y3Rfa21lbWNhY2hlX2ZhaWwrKzsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0
dXJuIC1FSU5WQUw7DQo+ID4gPiA+ICsgICAgICAgICAgICAgICB9DQo+ID4gPg0KPiA+ID4gSSB0
aGluayB0aGlzIHBhdGNoIGlzIHdyb25nIG9uIGl0cyBvd24sIGZvciBleGFtcGxlIGlmIGFuIGFs
bG9jYXRpb24NCj4gPiA+IGZhaWxzIGluIHRoZSBhYm92ZSBsb29wIHdlIGV4aXQgd2l0aG91dCBj
bGVhbmluZyB1cCBwcmV2aW91cw0KPiA+ID4gYWxsb2NhdGlvbnMuIEkgdGhpbmsgaXQncyBmaXhl
ZCBpbiBwYXRjaCAyIGJ1dCB3ZSBjYW5ub3QgaW50cm9kdWNlDQo+ID4NCj4gPiBJIHRoaW5rIHRo
ZXJlIG1pZ2h0IGJlIGEgbWlzdW5kZXJzdGFuZGluZy4genN3YXBfc3RvcmVfcGFnZXMoKSB3aWxs
DQo+ID4gY2xlYW4gdXAgbG9jYWwgcmVzb3VyY2VzIGFsbG9jYXRlZCBkdXJpbmcgYW4gaXRlcmF0
aW9uIG9mIHRoZSBmb3IgbG9vcCwNCj4gPiB1cG9uIGFuIGVycm9yIGluIHRoYXQgaXRlcmF0aW9u
LiBJZiB5b3Ugc2VlIHRoZSAiZ290byBzdG9yZV9mYWlsZWQiIGFuZA0KPiA+ICJnb3RvIGNvbXBy
ZXNzX2ZhaWxlZCIgdGhpcyB3b3VsZCBleHBsYWluIHdoYXQgSSBtZWFuLiBJZiBhbiBhbGxvY2F0
aW9uDQo+ID4gZmFpbHMgZm9yIGFuIGl0ZXJhdGlvbiwgd2Ugc2ltcGx5IHJldHVybiAtRUlOVkFM
LCBhbmQgenN3YXBfc3RvcmUoKQ0KPiA+IHdpbGwgZ290byB0aGUgInB1dF9wb29sIiBsYWJlbCB3
aXRoICJyZXQiIHN0aWxsIGZhbHNlLCB3aGljaCB3aWxsIGRlbGV0ZQ0KPiA+IGFsbCB6c3dhcCBl
bnRyaWVzIGZvciB0aGUgZm9saW8gKGFsbG9jYXRlZCB1cCB1bnRpbCB0aGUgZXJyb3IgaXRlcmF0
aW9uIGluDQo+ID4genN3YXBfc3RvcmVfcGFnZXMoKTsgb3IgcG90ZW50aWFsbHkgYWxyZWFkeSBp
biB0aGUgeGFycmF5KS4NCj4gPg0KPiA+IEhlbmNlLCB0aGVyZSBpcyBubyBidWcgYW5kIGVhY2gg
b2YgdGhlIHR3byBwYXRjaGVzIGFyZSBjb3JyZWN0IGJ5DQo+ID4gdGhlbXNlbHZlcyBBRkFJQ1Qs
IGJ1dCBwbGVhc2UgbGV0IG1lIGtub3cgaWYgSSBhbSBtaXNzaW5nIGFueXRoaW5nLg0KPiBUaGFu
a3MhDQo+IA0KPiBVaCB5ZXMsIHRoZSBjbGVhbnVwIGlzIGluIHpzd2FwX3N0b3JlKCkuDQo+IA0K
PiA+DQo+ID4gPiBidWdzIGluLWJldHdlZW4gcGF0Y2hlcy4gSSB0aGluayB0aGUgaGVscGVycyBp
biBwYXRjaCAyIGRvbid0IHJlYWxseQ0KPiA+ID4gaGVscCBhcyBJIG1lbnRpb25lZC4gUGxlYXNl
IGNvbWJpbmUgdGhlIGNoYW5nZXMgYW5kIGtlZXAgdGhlbSBpbiB0aGUNCj4gPiA+IG1haW4gc2Vy
aWVzICh1bmxlc3MgeW91IGhhdmUgYSByZWFzb24gbm90IHRvKS4NCj4gPg0KPiA+IFN1cmUuIEFz
IG5vdGVkIGluIG15IGVhcmxpZXIgcmVzcG9uc2UgdG8gY29tbWVudHMgcmVjZWl2ZWQgZm9yIHBh
dGNoIDIsDQo+ID4gSSBjYW4gZWl0aGVyIGlubGluZSBhbGwgaXRlcmF0aW9ucyBvciBjcmVhdGUg
aGVscGVycyBmb3IgYWxsIGl0ZXJhdGlvbnMgb3Zlcg0KPiA+IHRoZSBwYWdlcyBpbiBhIGJhdGNo
LiBBcHByZWNpYXRlIHlvdXIgc3VnZ2VzdGlvbnMgb24gd2hpY2ggd291bGQgYmUgYQ0KPiA+IGJl
dHRlciBhcHByb2FjaC4NCj4gDQo+IEkgdGhpbmsgbGVhdmluZyB0aGVtIG9wZW4tY29kZWQgd2ls
bCBiZSBjbGVhcmVyIGZvciBub3cuIFdlIGNhbg0KPiByZXZpc2l0IHRoZSBjb2RlIG9yZ2FuaXph
dGlvbiBsYXRlciBpZiBpdCBnZXRzIG91dCBvZiBoYW5kLg0KDQpTb3VuZHMgZ29vZCENCg0KVGhh
bmtzLA0KS2FuY2hhbmENCg==

