Return-Path: <linux-kernel+bounces-287424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7573C952795
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 03:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A9971C21B43
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 01:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCAF47772;
	Thu, 15 Aug 2024 01:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kG6hiOVp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D4743AAE
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 01:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723685834; cv=fail; b=hL2SAYCkJzz9UNL5NjIQGRaieydRnAS+4W+lVWAhkY854bUt4ay5BX6h7UVnOavVC8yy2I5zS/qK/m/JqJI8QVbVQsyoGyywOioLAQNxCLLpb8vfOqC08BjDpRqPnYLoJQm/17QsNpgSl2bSzuMnval91FMwi4I+AMTkAx9KM84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723685834; c=relaxed/simple;
	bh=tFtLP5L5ZURSY8xCI3+NirvhvkjGWEDjV98Ss2iDdfA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OHVKg80tUSOZdez6c59wzxZgtyMyfzpGYGVK/Osm3j/ua47q4aBpPdGx99Sf85YgWpzvAT1zHqpH2UPBJ3wQKBZWyucnHNwRq9JRXPPF44TYZQQt0z1KRMkhq1ZQY8iJJ8/n7A3lfFkMeA995C1qScJiv0odVjcT9urwMBmgD+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kG6hiOVp; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723685832; x=1755221832;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tFtLP5L5ZURSY8xCI3+NirvhvkjGWEDjV98Ss2iDdfA=;
  b=kG6hiOVpe7YyzIeTV8RdZWUIfA0+4SAliobMuIselfKALofjpjrbqGC4
   4gdqRGNydlUxcJuISGvf8oMA+12lVZeQ04N7hxo7LNPXvuBHrdIHjlbGH
   9nPaJE6bhuw3Qt4bQfq2VN1y899/hjN+n9d71SoXBBxtnV5bhcoUYAMTs
   MsTm8WekPjBwpIzW7Ug/INSLKXMDR2+ZcUiBaa4r8x5ox/0cF2kXEqqE4
   bsMASSfllbaSBYHdS/U3teheK4KR3LNLUiEjqD3p/hS113HlD7KkKFSXD
   adAOf2KqHTqsZynP2YRTdWgypQJ/a0bItnRwlLmFZ//6AwZbeWStF65ss
   Q==;
X-CSE-ConnectionGUID: 6CGCffG7Tquj9g3MNxoaCg==
X-CSE-MsgGUID: hxu2E16ASC2eKfgUutbzhA==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="21804185"
X-IronPort-AV: E=Sophos;i="6.10,147,1719903600"; 
   d="scan'208";a="21804185"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 18:37:11 -0700
X-CSE-ConnectionGUID: QM/WV5GxTEik9LKgBHKnVQ==
X-CSE-MsgGUID: d7xSscrETS+wnyTe19QLBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,147,1719903600"; 
   d="scan'208";a="82409139"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Aug 2024 18:37:11 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 14 Aug 2024 18:37:10 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 14 Aug 2024 18:37:10 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 14 Aug 2024 18:37:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lQUBiBRqWBDuOQ/HlECCuKJQEbAMnYQj2lk9tfgbktfXEgwaeJ8VeTdZEfC9HLrG62zFkijLyxS0QMERF/eCaqEdN7MxHtFLSaaS1qwodX3mnILd86/RwpacJW9/b2z4hDUvc+x0AzSdxETH0OVbMXs9g7+UH9P3tUHXwjUJSI99GNPR+X5vzNe3bj7gVlOgxLFKi1juhh68T6JUKLZhsJERkBD/USfELgqaUJrxu5Gvyu4J9kCMMguhzPnyPqEO02rzA6ry4YAxczbDjdQ1+hcOfIb1zsRI2P6MluhZVpMqWpgoEp/VuDIHLeE80F3rh84fpHGsZ3aNt8yR0BUuFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tFtLP5L5ZURSY8xCI3+NirvhvkjGWEDjV98Ss2iDdfA=;
 b=TGWDCn4GiSMwpsiBfjSi7V0PjSnR2ajKw4+0y0/mv+YJtVBzSoleaf0zFGrjC5mLje7kfyKlsmXAaSh++ydYOEwAV18eb418ZHhoq14+eglTTdkUykig6F7xeGRkD39SMA5ysvmz6bw5+egnvWz17lfDnkJj2jb8DQyiltOAtuJNh93ytq/J8ICInaez9iGzMtdLFDv1uYCRjJWqGe1NEQHA1fwpDfJq8lKxiUCJYrcqR0b3Jqa+QO3oiUp0yMK5Yav2E5woPitD88TCw9ojg5pEbtJY3bM01y2XdKvHQ6AWEyci12OdGT5m6ocS1QX1ymhadOq3RdidOLBd6YkN1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by PH7PR11MB7962.namprd11.prod.outlook.com (2603:10b6:510:245::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33; Thu, 15 Aug
 2024 01:37:08 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%5]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 01:37:07 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Barry Song <21cnbao@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "yosryahmed@google.com" <yosryahmed@google.com>,
	"nphamcs@gmail.com" <nphamcs@gmail.com>, "ryan.roberts@arm.com"
	<ryan.roberts@arm.com>, "Huang, Ying" <ying.huang@intel.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "Zou, Nanhai"
	<nanhai.zou@intel.com>, "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>,
	"Gopal, Vinodh" <vinodh.gopal@intel.com>, "Sridhar, Kanchana P"
	<kanchana.p.sridhar@intel.com>
Subject: RE: [RFC PATCH v1 2/4] mm: vmstat: Per mTHP-size zswap_store vmstat
 event counters.
Thread-Topic: [RFC PATCH v1 2/4] mm: vmstat: Per mTHP-size zswap_store vmstat
 event counters.
Thread-Index: AQHa7hMz8a7cvwYlHUeFP9+2SI8vyrImYJeAgAChlMCAAGP+gIAAGAfg
Date: Thu, 15 Aug 2024 01:37:07 +0000
Message-ID: <SJ0PR11MB56783F8762A5AE6FF20BBAF2C9802@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20240814062830.26833-1-kanchana.p.sridhar@intel.com>
 <20240814062830.26833-3-kanchana.p.sridhar@intel.com>
 <CAGsJ_4yWjjY_GqcaJsma9vPsuV29-WFK5Ho9DFZBx=HnL9=nPQ@mail.gmail.com>
 <SJ0PR11MB5678048AA2B4C654E41082D8C9872@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAGsJ_4wuoWKSnzeJ-2Xoc=_du3ZL3Ms8s6K58w8En3_h8-q_ng@mail.gmail.com>
In-Reply-To: <CAGsJ_4wuoWKSnzeJ-2Xoc=_du3ZL3Ms8s6K58w8En3_h8-q_ng@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|PH7PR11MB7962:EE_
x-ms-office365-filtering-correlation-id: 320dc267-5c42-41a8-770e-08dcbccac67c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aTN6L0ZmS2FKSlIvL21rQ0U4L1V1dFFGTTNrNHdMeUZ2NkYrcjFvcFF3ZHhS?=
 =?utf-8?B?Skk4elRhdnlWTnFvSXRpV2JPTFBoVER6dE45S3BHUEZMSDgvdjFJUktkUEFp?=
 =?utf-8?B?Y0RkaGV0aEF0Y05VV0JPQ0pPS2V1S092eUlQOWdjcTNYckc3RDg5a1dsZHM4?=
 =?utf-8?B?clVpM2QyOFdxTWxWQ1p0NGhiWGRXblhRRjIrQ283VnNFTzNVL0NucXBxYmI1?=
 =?utf-8?B?eWFLRGw1Tm1zNXptZnE2Q1drUnllOHhWUUJMUXNjZE1qeVQzeHhRd2thYXEr?=
 =?utf-8?B?cHRSOXpEUmtXRTZpUVU2WEVaR0JuWHZCNDdLMEoxS3lRUFhROWJRSUxraEM5?=
 =?utf-8?B?SDJtMW9oQ0M0ekRUN1EvWE42NWEwYmtCSGFJemg0UUR1VlZLbzFIandILysz?=
 =?utf-8?B?Z0Q3dnY5VlhvZ00rWllpTXRhdjJQSi9TU09uMm1DVWdxZkFGYmZvZTZoaUJt?=
 =?utf-8?B?WnFnQStTWDUyK3RRTHNEZ0h4eFFlTTN0Q3dTV0NYZHN0N2pKN1llb0FKWXBr?=
 =?utf-8?B?RDhDeHkxaUNQdWpJOTcra0daL29IZkFLcTNTaVV6cWc4MlF0NXhyeW5WU1dq?=
 =?utf-8?B?T1E3aWg0YXNVTWFScnpQNmNXOWJSZVNIQllPQjdLQU1qdy9yR2xMY0d3NG9u?=
 =?utf-8?B?bHBQcnlSR1Q1ZDZObzNaNE1PNTRyNENNT3pRREs1alVOeGVXcUJyS2RvaGgx?=
 =?utf-8?B?MkdkRGpCb1oyNTFCRHRnWGg3Z0NjazlJRUFFT2xpVUJQeTIxVDUzQ0dSRXRX?=
 =?utf-8?B?eUt2NlQya2MzM2NvUVpHdzYvTy9UNmpQMFJTYjB3d1BqSTJXMklQQUFmMVNQ?=
 =?utf-8?B?RDBMWjlmQnlYVGZScXVIdkppeWJyeVlUYXcwRVQ3Uis2S0lUaWppS1hSWnRj?=
 =?utf-8?B?YXN4c05EdFZ0ZXdsUllGdXE2ZEovYmdjWTlCMkZwS0I0U0w2SDladmNDc1ky?=
 =?utf-8?B?blVSTDZCdnpWNUtIWndJMko1b1VhZkk0VlpSS1VKTXhRSlo3NmkzZ0N1YTk2?=
 =?utf-8?B?Y3ErN0F0NDJVRkY3eGtuNHpaTHhDK2lPTExhcDNhQmZBQW5ZbDcxSlZiNldo?=
 =?utf-8?B?cE1sY0hSTXlWMEMyM0hTUGltWllUb21GR3dFSmdyd3VaemFJTDRnMW1SSFNN?=
 =?utf-8?B?a1JmMEtvc04zajFoMDVTLzB0REFnQ3dvcW5uRnNERGVtYnpQQnZEZCtDa0Jw?=
 =?utf-8?B?ajNLaTM3a3pBQzNzNklOWXJxcjlrNVVacVI1aStRYnB5ODhjOTRSYWVMU3J1?=
 =?utf-8?B?QUJ0MHhFTGxyb25lYy9MZVJoY1dzY1RITm9zTUlVZnRNeTZKZXBaRHB6RzNU?=
 =?utf-8?B?bnpIUmV3c2x6R0IvdlhRMFhKNjN3UlV0aW8vNnBvVGhaRDlEMXJCdGVLaWRp?=
 =?utf-8?B?UXczMVF2Nm92VmQxbjJIM3BFWCtuK1o5OVhQY25iNGMyNXMxVE5yMEZLa0Zh?=
 =?utf-8?B?NnZoQkl2ZUtYcUROWWxORDRMa2ZxSTZDc1MyYjZYc3A0Z2RzanhCODhJOXdM?=
 =?utf-8?B?ejRRRDZMa1drTWhSMmU5SHpJdUpIZHVjTUhZeVU1R010MENQZ2NlYXFrd2dD?=
 =?utf-8?B?WHdENUUwVGczZmFtTExXU0lPNk5CZGk0NGJIRmVyNC84SjE1bHhVbVZMQXRB?=
 =?utf-8?B?bjJEWDhwV1ExMDdhMG5BZTRqcE84SUNBclo2cmdqa2lIS1hFaStGV1E2Zi81?=
 =?utf-8?B?VzhwM3ZwWHlYY0lLcmNVU3BvMWJ1RnFJNDhKbDMweFV4MXFtWno4R1pIQys4?=
 =?utf-8?B?N2d2VUM5S2haaFU1TkN5L2V1UU9hclZ6djRlZFFtc0kvUno5Z1dlUUNHQ0po?=
 =?utf-8?B?a3ZlM0tTOFBRT0VxL0dkWXEvMTl0L2dSRFZpaDIrUCtQbUpsZkErSXI4MHhM?=
 =?utf-8?B?cVFJdDBneTNOSkRSWndScVBJZmNaK3NieTc0VFh4WnZiYkE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NkZJWXFaQlRZUmxMV1c1eDVVeXV3NmZpUWs4YXRpYmNUSEdWakhGOXlORmQw?=
 =?utf-8?B?a3FHR2g4SktqS1JoalNOUm9VeVI3M0JZQ1VDVFhUcGlVdHVTQmorVGw5Z21P?=
 =?utf-8?B?d2F2TXJqenE0MkdBaHFXK3JFQncxOFRYSWxjS2xNQkFwREE1eFMyVEFBU2VV?=
 =?utf-8?B?TktWQ3FnK0ZSNUlnRkRoOXlVZy9mQUY5enRMWi96R3dQWjZYeGhqTXlVaTVF?=
 =?utf-8?B?U29TL1JqVTlOOGplYVExa1A5b1gzemhtQm91NjJ1MzVHV2tBQ1pXSVdlYkN5?=
 =?utf-8?B?S1kyZSt3ekRodWFzN25VUCtnbUpoZDRxWTV1NUhCMEI4VTdJb1R6b0ZBTjk0?=
 =?utf-8?B?enlrS3hCTTNHWVBWVFR4a1Vtc1BqU3lmaGJmQUQ2bGNZSSs3eTlGZ0NSRHFL?=
 =?utf-8?B?WjVDZkxyR0YwN0dyajk4Y3prQm0ycVJXRTF1U1Z1NHhEOEpwTnJhcU1SWmdW?=
 =?utf-8?B?am1tdyszelk3blBBQWJGRVhNU0ZFSXk5N0ZzcWxOWkFXWWUwOTR5ay83NjV1?=
 =?utf-8?B?dlNGaUxjck9sUlpaU3dHYUVydGRzakhpMXlhU0x4V0Q2Mmw4eUszMHpSN2s4?=
 =?utf-8?B?UE5Ma2UyTWpKVlZNaVp1anladHlyK25NYmFub1VTOFZXRjFjMmdjNXN3SzBk?=
 =?utf-8?B?b0t4TnhHUXZQUVdKSTBPaUxxUklNTnNGcFo5ZXVoR1F5cFY3dVVrcHdUWFll?=
 =?utf-8?B?eEhVSkphaTF4QU9zL01qUzFsQisvV0RzVTRGOFFTbkhJQ1ZHNDZuZ2F4VWVI?=
 =?utf-8?B?ZWxvRlVhSFdPcjNxazQrNERUcHhTQ2VKVm1JazVITUlFelh4TFJRenlhL0VV?=
 =?utf-8?B?dTg3NXRBenVzZTZNbVhNcXRhRzN0b09qcit5N1NJUkozdDN0aEszSlU0KzNK?=
 =?utf-8?B?TDRQamhhWlQ2MWFUOS9HK2pVL0dIZEZ5SkpVRGJhR25wTDRKSWNwaFZWZ3dE?=
 =?utf-8?B?NHI3UHVHV2FyYmFkcHVCWkRiWjlNN2FNN2hYKzlEcnY2QnBJSkFzTTFpRGJM?=
 =?utf-8?B?bFpZaGgxN2dCOVQ2M0lvb0p5K3Y3cXlUTHF1SHRRQ1F1SnE2L0RtVUJzYzR4?=
 =?utf-8?B?QkZka1A4N3BtYXM4UG8wWTVCaklQaC8vU25rRUx5OWF2bmVYK21pWkRJcm5v?=
 =?utf-8?B?ejRUOHBKRnYxWGsxM3dQdjZVcFF2S1RwcG9ZaFBRSFVibUZlazZaM0R3Y0N0?=
 =?utf-8?B?dkptWWZvRUVzczJnWmlrT00yUGdyb09qVWJvU0ZXYWNJVkcwUENXUy9wcThn?=
 =?utf-8?B?V3NVMlRNTHdzcU1TT1dFT051cTJlY0xsTmxuVERLOHRCWnlmSEMrQ2JnN2hx?=
 =?utf-8?B?eUljMmREbnF0cnNuTU0rK3Bzcksvem0vblVXbzBHU2xmaUkvWmtGVyt1S0tF?=
 =?utf-8?B?TnJ2WndUd2IySHIreUl5dURNNEVkUmt4M2gxNzd6Y2hnWmNseS9BSk9pZHhK?=
 =?utf-8?B?VkZqWkxWbm1tYlB3b3NyL1NmUzNqN0dzMkx3VitSMElBbG5WUzNISEJLSFB6?=
 =?utf-8?B?eCtMVVlLc29RQlVFUHdjWnVKc2Fia3UrVndzYWZUUTB6OTFuRS96MWRGUWM3?=
 =?utf-8?B?YUU5SzFzZU9maFJiVkhSdEswblFERzFxMWdsWnNoYVNDSEJXNE1GQjBPbCtT?=
 =?utf-8?B?WVhXMTZYUnlkeHJyZDVUa1RmNmg3bFRkSHZuTjFjanFlaE9xaSs5d0V3NnE1?=
 =?utf-8?B?K2Jna2tEYVJkOEZvTjJSYWhseDRXQzJDWkFXd0YwM3lEbDhaa1JVR3o2eEp4?=
 =?utf-8?B?VmZ1OU5UQUNvNE01SURTdjVXRUYrSW9zQXFmMEhaUFU3TW56Y1BNUFNPOStp?=
 =?utf-8?B?MDVsZWl3L2V6UXhjT0Z5Z3NqV0JtYW15bFAveEJGMHVPU01wTG5VdUhyaWl5?=
 =?utf-8?B?VjhETVhRQ29CNHplNGc5Wi9JcFRSaXJQeGg3MVFSN2J2TWo5eVZUZi9DZlo0?=
 =?utf-8?B?YlJtZ2xpL2duK2hsZ0VFNTlJS0dlTVhvTGNxanZ2aE5DaXpjMDdEZlZFOWZL?=
 =?utf-8?B?R25rRnV4b2FTSk0zMXAyV3UzR1EzMk5YQitVU1pIajNmOEFQN3NLV25EdU40?=
 =?utf-8?B?SUkweFo0cU5sM2UwUmxIMGUxalJDN29Yc1R1bHltUTRySFpjR2hlZkd3WTh6?=
 =?utf-8?B?K1ZJanU4b3FETWhMZEhxSmlRMStHV25EaHBJamNzbXllRUdlWC81THBXR1hB?=
 =?utf-8?B?dzRoekROSGNTYVBPVGxmVDFiamlMUCs2Vys4ZExQNXhKY0J0MklKVnZqckx1?=
 =?utf-8?B?aW1RYkprY0ZxckYxeHN6MXh1b21RPT0=?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 320dc267-5c42-41a8-770e-08dcbccac67c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2024 01:37:07.8831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QAtr/lgQga1V90RX+MygbipefX9VR04HxazboJGZslNQbywkpvBWka44LTTzRDQ8QAyD8XTmJ/bxxq8qjS0flgmEcpvQkjHmsLS5vHDjthA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7962
X-OriginatorOrg: intel.com

SGkgQmFycnksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmFycnkg
U29uZyA8MjFjbmJhb0BnbWFpbC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgQXVndXN0IDE0LCAy
MDI0IDQ6MjUgUE0NCj4gVG86IFNyaWRoYXIsIEthbmNoYW5hIFAgPGthbmNoYW5hLnAuc3JpZGhh
ckBpbnRlbC5jb20+DQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1t
bUBrdmFjay5vcmc7DQo+IGhhbm5lc0BjbXB4Y2hnLm9yZzsgeW9zcnlhaG1lZEBnb29nbGUuY29t
OyBucGhhbWNzQGdtYWlsLmNvbTsNCj4gcnlhbi5yb2JlcnRzQGFybS5jb207IEh1YW5nLCBZaW5n
IDx5aW5nLmh1YW5nQGludGVsLmNvbT47IGFrcG1AbGludXgtDQo+IGZvdW5kYXRpb24ub3JnOyBa
b3UsIE5hbmhhaSA8bmFuaGFpLnpvdUBpbnRlbC5jb20+OyBGZWdoYWxpLCBXYWpkaSBLDQo+IDx3
YWpkaS5rLmZlZ2hhbGlAaW50ZWwuY29tPjsgR29wYWwsIFZpbm9kaCA8dmlub2RoLmdvcGFsQGlu
dGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggdjEgMi80XSBtbTogdm1zdGF0OiBQ
ZXIgbVRIUC1zaXplIHpzd2FwX3N0b3JlDQo+IHZtc3RhdCBldmVudCBjb3VudGVycy4NCj4gDQo+
IE9uIFRodSwgQXVnIDE1LCAyMDI0IGF0IDU6NDDigK9BTSBTcmlkaGFyLCBLYW5jaGFuYSBQDQo+
IDxrYW5jaGFuYS5wLnNyaWRoYXJAaW50ZWwuY29tPiB3cm90ZToNCj4gPg0KPiA+IEhpIEJhcnJ5
LA0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogQmFy
cnkgU29uZyA8MjFjbmJhb0BnbWFpbC5jb20+DQo+ID4gPiBTZW50OiBXZWRuZXNkYXksIEF1Z3Vz
dCAxNCwgMjAyNCAxMjo0OSBBTQ0KPiA+ID4gVG86IFNyaWRoYXIsIEthbmNoYW5hIFAgPGthbmNo
YW5hLnAuc3JpZGhhckBpbnRlbC5jb20+DQo+ID4gPiBDYzogbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsgbGludXgtbW1Aa3ZhY2sub3JnOw0KPiA+ID4gaGFubmVzQGNtcHhjaGcub3JnOyB5
b3NyeWFobWVkQGdvb2dsZS5jb207IG5waGFtY3NAZ21haWwuY29tOw0KPiA+ID4gcnlhbi5yb2Jl
cnRzQGFybS5jb207IEh1YW5nLCBZaW5nIDx5aW5nLmh1YW5nQGludGVsLmNvbT47DQo+IGFrcG1A
bGludXgtDQo+ID4gPiBmb3VuZGF0aW9uLm9yZzsgWm91LCBOYW5oYWkgPG5hbmhhaS56b3VAaW50
ZWwuY29tPjsgRmVnaGFsaSwgV2FqZGkgSw0KPiA+ID4gPHdhamRpLmsuZmVnaGFsaUBpbnRlbC5j
b20+OyBHb3BhbCwgVmlub2RoIDx2aW5vZGguZ29wYWxAaW50ZWwuY29tPg0KPiA+ID4gU3ViamVj
dDogUmU6IFtSRkMgUEFUQ0ggdjEgMi80XSBtbTogdm1zdGF0OiBQZXIgbVRIUC1zaXplIHpzd2Fw
X3N0b3JlDQo+ID4gPiB2bXN0YXQgZXZlbnQgY291bnRlcnMuDQo+ID4gPg0KPiA+ID4gT24gV2Vk
LCBBdWcgMTQsIDIwMjQgYXQgNjoyOOKAr1BNIEthbmNoYW5hIFAgU3JpZGhhcg0KPiA+ID4gPGth
bmNoYW5hLnAuc3JpZGhhckBpbnRlbC5jb20+IHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4gPiBBZGRl
ZCB2bXN0YXQgZXZlbnQgY291bnRlcnMgcGVyIG1USFAtc2l6ZSB0aGF0IGNhbiBiZSB1c2VkIHRv
IGFjY291bnQNCj4gPiA+ID4gZm9yIGZvbGlvcyBvZiBkaWZmZXJlbnQgc2l6ZXMgYmVpbmcgc3Vj
Y2Vzc2Z1bGx5IHN0b3JlZCBpbiBaU1dBUC4NCj4gPiA+ID4NCj4gPiA+ID4gRm9yIHRoaXMgUkZD
LCBpdCBpcyBub3QgY2xlYXIgaWYgdGhlc2UgenN3cG91dCBjb3VudGVycyBzaG91bGQgaW5zdGVh
ZA0KPiA+ID4gPiBiZSBhZGRlZCBhcyBwYXJ0IG9mIHRoZSBleGlzdGluZyBtVEhQIHN0YXRzIGlu
DQo+ID4gPiA+IC9zeXMva2VybmVsL21tL3RyYW5zcGFyZW50X2h1Z2VwYWdlL2h1Z2VwYWdlcy0q
a0Ivc3RhdHMuDQo+ID4gPiA+DQo+ID4gPiA+IFRoZSBmb2xsb3dpbmcgaXMgYWxzbyBhIHZpYWJs
ZSBvcHRpb24sIHNob3VsZCBpdCBtYWtlIGJldHRlciBzZW5zZSwNCj4gPiA+ID4gZm9yIGluc3Rh
bmNlLCBhczoNCj4gPiA+ID4NCj4gPiA+ID4gL3N5cy9rZXJuZWwvbW0vdHJhbnNwYXJlbnRfaHVn
ZXBhZ2UvaHVnZXBhZ2VzLSprQi9zdGF0cy96c3dwb3V0Lg0KPiA+ID4gPg0KPiA+ID4gPiBJZiBz
bywgd2Ugd291bGQgYmUgYWJsZSB0byBkaXN0aW5ndWlzaCBiZXR3ZWVuIG1USFAgenN3YXAgYW5k
DQo+ID4gPiA+IG5vbi16c3dhcCBzd2Fwb3V0cyB0aHJvdWdoOg0KPiA+ID4gPg0KPiA+ID4gPiAv
c3lzL2tlcm5lbC9tbS90cmFuc3BhcmVudF9odWdlcGFnZS9odWdlcGFnZXMtKmtCL3N0YXRzL3pz
d3BvdXQNCj4gPiA+ID4NCj4gPiA+ID4gYW5kDQo+ID4gPiA+DQo+ID4gPiA+IC9zeXMva2VybmVs
L21tL3RyYW5zcGFyZW50X2h1Z2VwYWdlL2h1Z2VwYWdlcy0qa0Ivc3RhdHMvc3dwb3V0DQo+ID4g
PiA+DQo+ID4gPiA+IHJlc3BlY3RpdmVseS4NCj4gPiA+ID4NCj4gPiA+ID4gQ29tbWVudHMgd291
bGQgYmUgYXBwcmVjaWF0ZWQgYXMgdG8gd2hpY2ggYXBwcm9hY2ggaXMgcHJlZmVyYWJsZS4NCj4g
PiA+DQo+ID4gPiBFdmVuIHRob3VnaCBzd2Fwb3V0IG1pZ2h0IGdvIHRocm91Z2ggenN3YXAsIGZy
b20gdGhlIHBlcnNwZWN0aXZlIG9mDQo+ID4gPiB0aGUgbW0gY29yZSwgaXQgc2hvdWxkbid0IGJl
IGF3YXJlIG9mIHRoYXQuIFNob3VsZG4ndCB6c3dwb3V0IGJlIHBhcnQNCj4gPiA+IG9mIHN3cG91
dD8gV2h5IGFyZSB0aGV5IHNlcGFyYXRlPyBubyBtYXR0ZXIgaWYgYSBtVEhQIGhhcyBiZWVuDQo+
ID4gPiBwdXQgaW4genN3YXAsIGl0IGhhcyBiZWVuIHN3YXBwZWQtb3V0IHRvIG1tLWNvcmU/IE5v
Pw0KPiA+DQo+ID4gVGhhbmtzIGZvciB0aGUgY29kZSByZXZpZXcgY29tbWVudHMuIFRoaXMgaXMg
YSBnb29kIHBvaW50LiBJIHdhcyBrZWVwaW5nIGluDQo+ID4gbWluZCB0aGUgY29udmVudGlvbiB1
c2VkIGJ5IGV4aXN0aW5nIHZtc3RhdCBldmVudCBjb3VudGVycyB0aGF0IGRpc3Rpbmd1aXNoDQo+
ID4genN3cG91dC96c3dwaW4gZnJvbSBwc3dwb3V0L3Bzd3BpbiBldmVudHMuDQo+ID4NCj4gPiBJ
ZiB3ZSB3YW50IHRvIGtlZXAgdGhlIGRpc3RpbmN0aW9uIGluIG1USFAgc3dhcG91dHMsIHdvdWxk
IGFkZGluZyBhDQo+ID4gc2VwYXJhdGUgTVRIUF9TVEFUX1pTV1BPVVQgdG8gImVudW0gbXRocF9z
dGF0X2l0ZW0iIGJlIE9rPw0KPiA+DQo+IA0KPiBJJ20gbm90IGVudGlyZWx5IHN1cmUgaG93IGlt
cG9ydGFudCB0aGUgenN3cG91dCBjb3VudGVyIGlzLiBUbyBtZSwgaXQgZG9lc24ndA0KPiBzZWVt
IGFzIGNyaXRpY2FsIGFzIHN3cG91dCBhbmQgc3dwb3V0X2ZhbGxiYWNrLCB3aGljaCBhcmUgbW9y
ZSB1c2VmdWwgZm9yDQo+IHN5c3RlbSBwcm9maWxpbmcuIHpzd2Fwb3V0IGZlZWxzIG1vcmUgbGlr
ZSBhbiBpbnRlcm5hbCBkZXRhaWwgcmVsYXRlZCB0bw0KPiBob3cgdGhlIHN3YXAtb3V0IHByb2Nl
c3MgaXMgaGFuZGxlZD8gSWYgdGhpcyBpcyB0aGUgY2FzZSwgd2UgbWlnaHQgbm90DQo+IG5lZWQg
dGhpcyBwZXItc2l6ZSBjb3VudGVyLg0KPiANCj4gT3RoZXJ3aXNlLCBJIGJlbGlldmUgc3lzZnMg
aXMgYSBiZXR0ZXIgcGxhY2UgdG8gYXZvaWQgYWxsIHRoZSBjaGFvcyBpbiB2bXN0YXQNCj4gdG8g
aGFuZGxlIHZhcmlvdXMgb3JkZXJzIGFuZCBzaXplcy4gU28gdGhlIHF1ZXN0aW9uIGlzLCBwZXIt
c2l6ZSB6c3dwb3V0DQo+IGNvdW50ZXIgaXMgcmVhbGx5IGltcG9ydGFudCBvciBqdXN0IGZvciBk
ZWJ1Z2dpbmcgcHVycG9zZXM/DQoNCkkgYWdyZWUsIHN5c2ZzIHdvdWxkIGJlIGEgY2xlYW5lciBt
VEhQIHN0YXRzIGFjY291bnRpbmcgc29sdXRpb24sIGdpdmVuIHRoZQ0KZXhpc3RpbmcgbVRIUCBz
d3BvdXQgc3RhdHMgdW5kZXIgdGhlIHBlci1vcmRlcg0KL3N5cy9rZXJuZWwvbW0vdHJhbnNwYXJl
bnRfaHVnZXBhZ2UvaHVnZXBhZ2VzLSprQi9zdGF0cy9zd3BvdXQuDQoNCkkgcGVyc29uYWxseSBm
aW5kIGRpc3RpbmN0IHpzd2FwIHZzLiBiZGV2L2ZzIHN3YXBvdXQgYWNjb3VudGluZyB1c2VmdWwN
CmZvciBkZWJ1Z2dpbmcsIGFuZCBmb3Igb3ZlcmFsbCByZWNsYWltIHBhdGggY2hhcmFjdGVyaXph
dGlvbi4NCkZvciBpbnN0YW5jZSwgdGhlIGltcGFjdCBvZiBkaWZmZXJlbnQgenN3YXAgY29tcHJl
c3NvcnMnIGNvbXByZXNzIGxhdGVuY3kNCm9uIHpzd3BvdXQgYWN0aXZpdHkgZm9yIGEgZ2l2ZW4g
d29ya2xvYWQuIElzIGEgc2xvd2Rvd24gaW4gY29tcHJlc3MgbGF0ZW5jeQ0KY2F1c2luZyBhY3Rp
dmUvaG90IG1lbW9yeSB0byBiZSByZWNsYWltZWQgYW5kIGltbWVkaWF0ZWx5IGZhdWx0ZWQgaW4/
DQpEb2VzIGJldHRlciB6c3dhcCBjb21wcmVzcyBlZmZpY2llbmN5IGNvLXJlbGF0ZSB0byBtb3Jl
IGNvbGQgbWVtb3J5DQphcyBtVEhQIHRvIGJlIHJlY2xhaW1lZD8gSG93IGRvZXMgdGhlIHJlY2xh
aW0gcGF0aCBlZmZpY2llbmN5DQppbXByb3ZlbWVudCByZXN1bHRpbmcgZnJvbSBpbXByb3Zpbmcg
enN3YXBfc3RvcmUgbVRIUCBwZXJmb3JtYW5jZQ0KY28tcmVsYXRlIHdpdGggWlNXQVAgdXRpbGl6
YXRpb24gYW5kIG1lbW9yeSBzYXZpbmdzPyBJIGhhdmUgZm91bmQgdGhlc2UNCmNvdW50ZXJzIHVz
ZWZ1bCBpbiB1bmRlcnN0YW5kaW5nIHNvbWUgb2YgdGhlc2UgY2hhcmFjdGVyaXN0aWNzLg0KDQpJ
IGFsc28gYmVsaWV2ZSBpdCBoZWxwcyB0byBhY2NvdW50IGZvciB0aGUgbnVtYmVyIG9mIG1USFAg
YmVpbmcgc3RvcmVkIGluDQpkaWZmZXJlbnQgY29tcHJlc3MgdGllcnMuIEZvciBlLmcuIGhvdyBt
YW55IG1USFAgd2VyZSBzdG9yZWQgaW4genN3YXAgdnMuDQpiZWluZyByZWplY3RlZCBhbmQgc3Rv
cmVkIGluIHRoZSBiYWNraW5nIHN3YXAgZGV2aWNlLiBUaGlzIGNvdWxkIGhlbHAgc2F5DQppbiBw
cm92aXNpb25pbmcgenN3YXAgbWVtb3J5LCBhbmQga25vd2luZyB0aGUgaW1wYWN0IG9mIHpzd2Fw
IGNvbXByZXNzDQpwYXRoIGxhdGVuY3kgb24gc2NhbGluZy4NCg0KQW5vdGhlciBpbnRlcmVzdGlu
ZyBjaGFyYWN0ZXJpc3RpYyB0aGF0IG1USFAgenN3cG91dCBhY2NvdW50aW5nIGNvdWxkIGhlbHAN
CnVuZGVyc3RhbmQgd291bGQgYmUgY29tcHJlc3NvciBpbmNvbXByZXNzaWJpbGl0eSBhbmQvb3Ig
enBvb2wgZnJhZ21lbnRhdGlvbjsNCmFuZCBiZWluZyBhYmxlIHRvIGJldHRlciBjby1yZWxhdGUg
dGhlIHpzd2FwL3JlamVjdF8qIHN5c2ZzIGNvdW50ZXJzIHdpdGgNCm1USFAgW3pdc3dwb3V0IHN0
YXRzLg0KDQpMb29rIGZvcndhcmQgdG8gaW5wdXRzIGZyb20geW91cnNlbGYgYW5kIG90aGVycyBv
biB0aGUgZGlyZWN0aW9uIGFuZCBuZXh0IHN0ZXBzLg0KDQpUaGFua3MsDQpLYW5jaGFuYQ0KDQo+
IA0KPiA+IEluIGFueSBjYXNlLCBpdCBsb29rcyBsaWtlIGFsbCB0aGF0IHdvdWxkIGJlIG5lZWRl
ZCBpcyBhIGNhbGwgdG8NCj4gPiBjb3VudF9tdGhwX3N0YXQoZm9saW9fb3JkZXIoZm9saW8pLCBN
VEhQX1NUQVRfW1pdU1dQT1VUKSBpbiB0aGUNCj4gPiBnZW5lcmFsIGNhc2UuDQo+ID4NCj4gPiBJ
IHdpbGwgbWFrZSB0aGlzIGNoYW5nZSBpbiB2MiwgZGVwZW5kaW5nIG9uIHdoZXRoZXIgb3Igbm90
IHRoZQ0KPiA+IHNlcGFyYXRpb24gb2YgenN3cG91dCB2cy4gbm9uLXpzd2FwIHN3cG91dCBpcyBy
ZWNvbW1lbmRlZCBmb3INCj4gPiBtVEhQLg0KPiA+DQo+ID4gPg0KPiA+ID4NCj4gPiA+ID4NCj4g
PiA+ID4gU2lnbmVkLW9mZi1ieTogS2FuY2hhbmEgUCBTcmlkaGFyIDxrYW5jaGFuYS5wLnNyaWRo
YXJAaW50ZWwuY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gIGluY2x1ZGUvbGludXgvdm1fZXZl
bnRfaXRlbS5oIHwgMTUgKysrKysrKysrKysrKysrDQo+ID4gPiA+ICBtbS92bXN0YXQuYyAgICAg
ICAgICAgICAgICAgICB8IDE1ICsrKysrKysrKysrKysrKw0KPiA+ID4gPiAgMiBmaWxlcyBjaGFu
Z2VkLCAzMCBpbnNlcnRpb25zKCspDQo+ID4gPiA+DQo+ID4gPiA+IGRpZmYgLS1naXQgYS9pbmNs
dWRlL2xpbnV4L3ZtX2V2ZW50X2l0ZW0uaA0KPiA+ID4gYi9pbmNsdWRlL2xpbnV4L3ZtX2V2ZW50
X2l0ZW0uaA0KPiA+ID4gPiBpbmRleCA3NDc5NDNiYzhjYzIuLjI0NTFiY2ZjZjA1YyAxMDA2NDQN
Cj4gPiA+ID4gLS0tIGEvaW5jbHVkZS9saW51eC92bV9ldmVudF9pdGVtLmgNCj4gPiA+ID4gKysr
IGIvaW5jbHVkZS9saW51eC92bV9ldmVudF9pdGVtLmgNCj4gPiA+ID4gQEAgLTExNCw2ICsxMTQs
OSBAQCBlbnVtIHZtX2V2ZW50X2l0ZW0geyBQR1BHSU4sIFBHUEdPVVQsDQo+ID4gPiBQU1dQSU4s
IFBTV1BPVVQsDQo+ID4gPiA+ICAgICAgICAgICAgICAgICBUSFBfWkVST19QQUdFX0FMTE9DLA0K
PiA+ID4gPiAgICAgICAgICAgICAgICAgVEhQX1pFUk9fUEFHRV9BTExPQ19GQUlMRUQsDQo+ID4g
PiA+ICAgICAgICAgICAgICAgICBUSFBfU1dQT1VULA0KPiA+ID4gPiArI2lmZGVmIENPTkZJR19a
U1dBUA0KPiA+ID4gPiArICAgICAgICAgICAgICAgWlNXUE9VVF9QTURfVEhQX0ZPTElPLA0KPiA+
ID4gPiArI2VuZGlmDQo+ID4gPiA+ICAgICAgICAgICAgICAgICBUSFBfU1dQT1VUX0ZBTExCQUNL
LA0KPiA+ID4gPiAgI2VuZGlmDQo+ID4gPiA+ICAjaWZkZWYgQ09ORklHX01FTU9SWV9CQUxMT09O
DQo+ID4gPiA+IEBAIC0xNDMsNiArMTQ2LDE4IEBAIGVudW0gdm1fZXZlbnRfaXRlbSB7IFBHUEdJ
TiwgUEdQR09VVCwNCj4gPiA+IFBTV1BJTiwgUFNXUE9VVCwNCj4gPiA+ID4gICAgICAgICAgICAg
ICAgIFpTV1BJTiwNCj4gPiA+ID4gICAgICAgICAgICAgICAgIFpTV1BPVVQsDQo+ID4gPiA+ICAg
ICAgICAgICAgICAgICBaU1dQV0IsDQo+ID4gPiA+ICsgICAgICAgICAgICAgICBaU1dQT1VUXzRL
Ql9GT0xJTywNCj4gPiA+ID4gKyNpZmRlZiBDT05GSUdfVEhQX1NXQVANCj4gPiA+ID4gKyAgICAg
ICAgICAgICAgIG1USFBfWlNXUE9VVF84a0IsDQo+ID4gPiA+ICsgICAgICAgICAgICAgICBtVEhQ
X1pTV1BPVVRfMTZrQiwNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIG1USFBfWlNXUE9VVF8zMmtC
LA0KPiA+ID4gPiArICAgICAgICAgICAgICAgbVRIUF9aU1dQT1VUXzY0a0IsDQo+ID4gPiA+ICsg
ICAgICAgICAgICAgICBtVEhQX1pTV1BPVVRfMTI4a0IsDQo+ID4gPiA+ICsgICAgICAgICAgICAg
ICBtVEhQX1pTV1BPVVRfMjU2a0IsDQo+ID4gPiA+ICsgICAgICAgICAgICAgICBtVEhQX1pTV1BP
VVRfNTEya0IsDQo+ID4gPiA+ICsgICAgICAgICAgICAgICBtVEhQX1pTV1BPVVRfMTAyNGtCLA0K
PiA+ID4gPiArICAgICAgICAgICAgICAgbVRIUF9aU1dQT1VUXzIwNDhrQiwNCj4gPiA+ID4gKyNl
bmRpZg0KPiA+ID4NCj4gPiA+IFRoaXMgaW1wbGVtZW50YXRpb24gaGFyZGNvZGVzIGFzc3VtcHRp
b25zIGFib3V0IHRoZSBwYWdlIHNpemUgYmVpbmcNCj4gNEtCLA0KPiA+ID4gYnV0IHBhZ2Ugc2l6
ZXMgY2FuIHZhcnksIGFuZCBzbyBjYW4gdGhlIFRIUCBvcmRlcnM/DQo+ID4NCj4gPiBBZ3JlZWQs
IHdpbGwgYWRkcmVzcyBpbiB2Mi4NCj4gPg0KPiA+ID4NCj4gPiA+ID4gICNlbmRpZg0KPiA+ID4g
PiAgI2lmZGVmIENPTkZJR19YODYNCj4gPiA+ID4gICAgICAgICAgICAgICAgIERJUkVDVF9NQVBf
TEVWRUwyX1NQTElULA0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvbW0vdm1zdGF0LmMgYi9tbS92bXN0
YXQuYw0KPiA+ID4gPiBpbmRleCA4NTA3YzQ5NzIxOGIuLjBlNjZjOGIwYzQ4NiAxMDA2NDQNCj4g
PiA+ID4gLS0tIGEvbW0vdm1zdGF0LmMNCj4gPiA+ID4gKysrIGIvbW0vdm1zdGF0LmMNCj4gPiA+
ID4gQEAgLTEzNzUsNiArMTM3NSw5IEBAIGNvbnN0IGNoYXIgKiBjb25zdCB2bXN0YXRfdGV4dFtd
ID0gew0KPiA+ID4gPiAgICAgICAgICJ0aHBfemVyb19wYWdlX2FsbG9jIiwNCj4gPiA+ID4gICAg
ICAgICAidGhwX3plcm9fcGFnZV9hbGxvY19mYWlsZWQiLA0KPiA+ID4gPiAgICAgICAgICJ0aHBf
c3dwb3V0IiwNCj4gPiA+ID4gKyNpZmRlZiBDT05GSUdfWlNXQVANCj4gPiA+ID4gKyAgICAgICAi
enN3cG91dF9wbWRfdGhwX2ZvbGlvIiwNCj4gPiA+ID4gKyNlbmRpZg0KPiA+ID4gPiAgICAgICAg
ICJ0aHBfc3dwb3V0X2ZhbGxiYWNrIiwNCj4gPiA+ID4gICNlbmRpZg0KPiA+ID4gPiAgI2lmZGVm
IENPTkZJR19NRU1PUllfQkFMTE9PTg0KPiA+ID4gPiBAQCAtMTQwNSw2ICsxNDA4LDE4IEBAIGNv
bnN0IGNoYXIgKiBjb25zdCB2bXN0YXRfdGV4dFtdID0gew0KPiA+ID4gPiAgICAgICAgICJ6c3dw
aW4iLA0KPiA+ID4gPiAgICAgICAgICJ6c3dwb3V0IiwNCj4gPiA+ID4gICAgICAgICAienN3cHdi
IiwNCj4gPiA+ID4gKyAgICAgICAienN3cG91dF80a2JfZm9saW8iLA0KPiA+ID4gPiArI2lmZGVm
IENPTkZJR19USFBfU1dBUA0KPiA+ID4gPiArICAgICAgICJtdGhwX3pzd3BvdXRfOGtiIiwNCj4g
PiA+ID4gKyAgICAgICAibXRocF96c3dwb3V0XzE2a2IiLA0KPiA+ID4gPiArICAgICAgICJtdGhw
X3pzd3BvdXRfMzJrYiIsDQo+ID4gPiA+ICsgICAgICAgIm10aHBfenN3cG91dF82NGtiIiwNCj4g
PiA+ID4gKyAgICAgICAibXRocF96c3dwb3V0XzEyOGtiIiwNCj4gPiA+ID4gKyAgICAgICAibXRo
cF96c3dwb3V0XzI1NmtiIiwNCj4gPiA+ID4gKyAgICAgICAibXRocF96c3dwb3V0XzUxMmtiIiwN
Cj4gPiA+ID4gKyAgICAgICAibXRocF96c3dwb3V0XzEwMjRrYiIsDQo+ID4gPiA+ICsgICAgICAg
Im10aHBfenN3cG91dF8yMDQ4a2IiLA0KPiA+ID4gPiArI2VuZGlmDQo+ID4gPg0KPiA+ID4gVGhl
IGlzc3VlIGhlcmUgaXMgdGhhdCB0aGUgbnVtYmVyIG9mIFRIUCBvcmRlcnMNCj4gPiA+IGNhbiB2
YXJ5IGFjcm9zcyBkaWZmZXJlbnQgcGxhdGZvcm1zLg0KPiA+DQo+ID4gQWdyZWVkLCB3aWxsIGFk
ZHJlc3MgaW4gdjIuDQo+ID4NCj4gPiBUaGFua3MsDQo+ID4gS2FuY2hhbmENCj4gPg0KPiA+ID4N
Cj4gPiA+ID4gICNlbmRpZg0KPiA+ID4gPiAgI2lmZGVmIENPTkZJR19YODYNCj4gPiA+ID4gICAg
ICAgICAiZGlyZWN0X21hcF9sZXZlbDJfc3BsaXRzIiwNCj4gPiA+ID4gLS0NCj4gPiA+ID4gMi4y
Ny4wDQo+ID4gPiA+DQo+IA0KPiBUaGFua3MNCj4gQmFycnkNCg==

