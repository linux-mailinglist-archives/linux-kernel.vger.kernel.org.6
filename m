Return-Path: <linux-kernel+bounces-296081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D545895A55E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 21:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86DA31C21CE7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 19:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79BE16EB7B;
	Wed, 21 Aug 2024 19:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VvOaeuVg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C535A16DC11
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 19:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724269268; cv=fail; b=gFz+V8ncEMPzUNmNieJnzNEe/7WTTH8kz3meLHCIcPzxAUWz8NQ0Z0C1FWhjKawQYtuqpOeDNziFkJFFdu1j2HF8JcsG2XJ5FiL1fMfGSq1AxwdtNRWNS5rHU8uGtlGKELqICyZdf4IcXXGg/MWvOK/w+nM92T+g90ZsGcxOgOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724269268; c=relaxed/simple;
	bh=YRr9pxS5Qnb7BlHfxlfno47c1YxGSFHReBCugyCVq7Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WmEfv2EeeAuVIUITo34P4FlHbTqJNRP5qWWHru0aVFZgHRcXSHt7U89uYoEp3jwL6+wFrmsyEpW2Z0g71+ptOp2Gl7Lbxabrv8940mEVCD8XpBkFHJDR0HeqRh+N1q+/vJMm7ffZ6k+de13faKAkkZ6NKavYxbFeEGW8zUDgEoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VvOaeuVg; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724269266; x=1755805266;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YRr9pxS5Qnb7BlHfxlfno47c1YxGSFHReBCugyCVq7Q=;
  b=VvOaeuVgrOvwyyBNScdv8uf0Yv9QJZBLVpeViJUD09D4kSnqcNXF9ALO
   IBZVuPI/in5odyrM6lZDxIvbjrkFHGO+ke/q/SpY2Q+6KEBnNTWumh6De
   JKDt+feSnKvAB6YFHT5uBUqxv9v4e9qr40SUDoPy3Cw2h4wSk9otlC2zE
   kTqeiNAFPHHEWLKhTV89VSj19LAMxozu7j7YOvZFuo8IXNDZmTK0FvfW4
   vQtASsLGqDVDsRRNr9uQbGhhbT0ZIXxo+w2ZwdXn3exFkMAN7X2dytHPT
   pq9qp+hn3Sb2WUJPIBEW6NEAPjWTO1HkMN9g0NT3S7xNq0sh+ystm49Le
   w==;
X-CSE-ConnectionGUID: Dqk7H2ECRsS2zxVpx5YTww==
X-CSE-MsgGUID: 7P8okjWoTVeOxfmaOkJV5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="33220615"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="33220615"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 12:41:06 -0700
X-CSE-ConnectionGUID: anK9wyakTNuJLOstayoAiQ==
X-CSE-MsgGUID: npTPlKI1QS6zZXgVPtDJ5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="65889377"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Aug 2024 12:41:06 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 21 Aug 2024 12:41:05 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 21 Aug 2024 12:41:05 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 21 Aug 2024 12:41:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bnWwh/1SghvZYdlsu6EKHI+I/Jk0o+mqZH2o1i6MrUAfyI4iDKg/3PiwMHWTZaozl+6plN/WzN1iyZ8Mut2TkDRRIwMoxcYAqN22iJV22F3DuCzx99/7VxE2g6MzuX8QG2wAesOrsE5rsoYS0FJqjseVsKxz1d2Y5fhMQlIfoy3YZBfE13ai8IJBH58LBy2iHbPX/SZIojtsDE1AT7NARsvcjG09EvqRNSu8nNiOSqrGDDHT19IJDt5RFL43Zuok6oYFRHREmwom8wEEGqfbGVX5zWLi4fLlvrr3bcjEyyHk8DpZ9Xgz4R8y4VRwO2IFJLXYkIiJLpkkLn8SSSuH4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YRr9pxS5Qnb7BlHfxlfno47c1YxGSFHReBCugyCVq7Q=;
 b=Nkqj37rhcweuNw+4pT50ZcZSVqnsUvlGIl7uMysJjFAmT0wfvbO51mY/LmEGYriv3MyizwVFZWxTXIRJQhXGsJn0HENMzXfv011QcUj9nLJ1NOZo1lZC1FfawSB/kpJPob15a0/Ma2bJyL7Cnq9um4xxfpQbI0SaPuEfsOq2b7rvflKeZX9FDj4ly1vHdSJfSQeC8G3lrYKl5yLVX2FZSf2lqLaPcPQkGqLN5rFUU03yVZkK0fQj80ooWIE8/jBq0z+fzPYCTDm7LP3fLSvOKUbFYQUNdsfmdjpezPG8W2Ma2M0d6G9GSyA300l/Q6AtEw6FZHHAwdeibnSzCN1Iow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by IA0PR11MB7955.namprd11.prod.outlook.com (2603:10b6:208:3dd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 19:41:01 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%5]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 19:40:42 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Nhat Pham <nphamcs@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "yosryahmed@google.com" <yosryahmed@google.com>,
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, "Huang, Ying"
	<ying.huang@intel.com>, "21cnbao@gmail.com" <21cnbao@gmail.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "Zou, Nanhai"
	<nanhai.zou@intel.com>, "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>,
	"Gopal, Vinodh" <vinodh.gopal@intel.com>, "Sridhar, Kanchana P"
	<kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v1] mm: Defines obj_cgroup_get() if CONFIG_MEMCG is not
 defined.
Thread-Topic: [PATCH v1] mm: Defines obj_cgroup_get() if CONFIG_MEMCG is not
 defined.
Thread-Index: AQHa8zownmBKtHWwPk69pMRSa2JXJ7IyGPSAgAADIMA=
Date: Wed, 21 Aug 2024 19:40:42 +0000
Message-ID: <SJ0PR11MB5678BCBBA46F1AA205A274F2C98E2@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20240820195005.5941-1-kanchana.p.sridhar@intel.com>
 <CAKEwX=N-xuQume6C+xq0LfhVNOaK9rOiz_0c39GfoBB-4+6eng@mail.gmail.com>
In-Reply-To: <CAKEwX=N-xuQume6C+xq0LfhVNOaK9rOiz_0c39GfoBB-4+6eng@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|IA0PR11MB7955:EE_
x-ms-office365-filtering-correlation-id: f5b2473a-6ae2-4896-3043-08dcc21924cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RlhzcExIY0MwZXVaeFhlVVhOUzJ5TFhWbW5Fd2t6M3ozTmNFZzdaQTMzaVpS?=
 =?utf-8?B?LzRJdkxpcFB0T2NiTHFtUVBFdlgxRnpvaHlDWlpIdHRpa2tIaVV1RlhNYmdK?=
 =?utf-8?B?YXBEVnB4VjlYWUM1TzNwSTNxc2xKT05uL1ZOTkJ4c1ltQXZjTnlOdlE0aldr?=
 =?utf-8?B?UzYyRE9iUTZQWnZSZC84RVg4T2JUdVBheG0wN3dDWXR1QUhidlFqNEo4dnBr?=
 =?utf-8?B?ZVVHYlZ3enhEQmh0K0Q3NGFES2cyM0VjdFFVUjZ3MHh6bEV5NDVmbEhETjFX?=
 =?utf-8?B?WE5YOEp0aDZwSXNyMWwrU3ZHVGswT1VzbVVVdXVUS25JNThxZG5hMGlBRmpM?=
 =?utf-8?B?SUpDSk1UWWlaS0dzd21qand0cmgvS3ByUW5Ra2Y2UXFsYlp6SG1HbWhwaTY3?=
 =?utf-8?B?cm5BdkhuYlFGOGVobCtSRDFnMUFMTlRXVFBjakVleXhuNktWbTJrYjhYSzMr?=
 =?utf-8?B?c08rTTBsTWxlWkNvbnRMa2ZtVUZXeHhRZGc0QzZVWkhGWkszMTFXNmdjYmpv?=
 =?utf-8?B?bjEzVlJDS3hDRVVUMDNkaHZYaUFYeVJ6a083cmJjZTV4RkxUWWhSaXQrWEo3?=
 =?utf-8?B?Y2FmUEZLaWlMdi8vajd0ZVJHNlFzSTBoZU1aTHlIRGJNS1pDNC94RVF6SnlR?=
 =?utf-8?B?REtwdXI3TWlRR2JLZFUwRW1Hb3YyamtGYzMybXhIM3BoYWhhWHVicHBMUXFs?=
 =?utf-8?B?dzFacjdLNGI4UDljL3hlNEhMSm43enNRR0tWZ3hhWEFGR3VkUFk3Zk5NUW5r?=
 =?utf-8?B?aDdSeExlWTRkN0k1eVdKY0c0Z1pmdjNXZDBkZU9aRkZBUXhMd0NHSW51eW9l?=
 =?utf-8?B?cVl0ZkxKdnFKUHpGTXJFdE9FWURFbitiajNMTU9JUVNrTEQ4ZU11RmFqVVZD?=
 =?utf-8?B?QUk4QWdyRE8rYitYYXMzM21kRVBvVWUyMWhGZU5aYWpWb1NFNTJIdzhJdWVr?=
 =?utf-8?B?SXhuV0Y5UlAwTXM3Z3BVblVNSjRyUmlFdUVTdDJZamJnZ0t0ajFhWFdxeGwx?=
 =?utf-8?B?T1Ewa3JQL2lHVDcvdjhRTUpBbDdNWkR4VERsczF2dTFhdytYTmtHMmc5VTVZ?=
 =?utf-8?B?WTVXV2cvR3BSSmNUZ0RTTE9GaDhheHF2SVJUNGwyeUhnM2NiR0s4K0tqeklC?=
 =?utf-8?B?bWRlU1JSYmNMR3JXdkRmVWU0Rkh5YVBYMkxtckwyVUdIc3FWR09ZdFBNc215?=
 =?utf-8?B?a0oremFrNmpFZXNpa0pEZ0NqMWdPcWlMVlhZaWduOGEzSzBNa0xiWGpvVjRV?=
 =?utf-8?B?U0FEMC9odVl4Tk5jZW9HaUZWdHU2ZThUbmpQUlQ3am03RUpKOEFOcEVIa29M?=
 =?utf-8?B?ZEtJTEtlSzFjbW5XbUIvS1pnQko5T0F4cUJwYy80SUNQdEJ2bkc0elcvMCtN?=
 =?utf-8?B?SFp1VlgwYis1U2s3cU9yZEZUSlZacG9FQmxyZnpiUzl1RzJCaXVaWWVNakd1?=
 =?utf-8?B?TitFYWw0M1g3ZXpVSno3K1p5UTFzbkJaKzRBZE5TUm1SaFo5c2hwTG9YN0RE?=
 =?utf-8?B?bWxaWTNoM3lSTUczUUluNW5ONmNCdm5tYlJXbXBvM1FvalpJY0JPRW9zVURX?=
 =?utf-8?B?cDNxdkFBQ3E0UTBrcmVUak9ScWZTL28zY0xZMDQySE9pL08zV1JHOExGMHMx?=
 =?utf-8?B?SVU5cVRUNDZHYUdmNzRuWDRBTURsNDJ6dGFZNFcxS3pIeUtaQmdBdit6Zm5N?=
 =?utf-8?B?OXNjSDRpVVhoNEJqZGppOS9Gblp1dzROQTZyQ25URTg2ckEzaFFQaTVQQUV1?=
 =?utf-8?B?SG9NajEvSW1VTlhyQzdmRlBEckhWdTQrV0s0QnJtL05rZmRDdVBZeVZuTVlD?=
 =?utf-8?B?ZUZsdlVHdFozNGMxdURQT2czV3BiOG5ySHpGVitWSUJ5N0sxTjVHMXYrWnNG?=
 =?utf-8?B?QWV4OEcvMkdDcjNRZlVqSHpTYjZlRWZCSFFYeHR1RXNzVkE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SXFZeVdUajc1Q0VUVVJHQ2dVSUVGSmhXbTdmVjNxUlZSSlFlVEo0bURleGEr?=
 =?utf-8?B?SFhWcXJJWWZrY0VYb3hET2RURTYyeFhtNlNkSDRHTXBET1RqVTdwUUw3QXBr?=
 =?utf-8?B?RVNrVnFheG5zZXNtQ1ZtZ2YrcmhNNTFIOUN5d1RjWVpxalY0Q0c0U0RZWld4?=
 =?utf-8?B?NmRGMkl5bUlpMnVCaTU0OHh0QjVLekkzRFBnK1E3RUJONndVQlk2WGhWV2wz?=
 =?utf-8?B?NkdUa1QwV0pIUjltc2xKa001aGdRMUVPZ0xQUDVsd1BVdmxZYVdGWkdRY0FI?=
 =?utf-8?B?WVIzMUV4RUZEanhYU3ZZZjJLWHArY0MzWlJ5aEFiUUhzdDcveHdRa3hDK05s?=
 =?utf-8?B?OXNJNjhxUG1oT2VWZ3NLZ2Vac2hBdGtwdDVDRHljbmEydVFrVVp6R3VxazBo?=
 =?utf-8?B?UjZyYi9xSm42NjJUMkFqaHUzSDhjUVdQYnEzb2VzOGorNGNveDdLeDRXRzVW?=
 =?utf-8?B?QTJnY3l5WlVJT0dwZlpuZHEya3VYQTRrSk15Y3lTUmY4WDJxT28yV3BYR2Ix?=
 =?utf-8?B?L1hrNU9CdzhFZ2E1MDdPcHNiQ0x2NXBCYkFycTJ1M3ZqdUhoVlRmTnJyUlM5?=
 =?utf-8?B?R09DRENFKzhPTWxCdFNuZUZvL1ZMUU96M3REeDVsN045Nm1kZmdXcWdXQVI1?=
 =?utf-8?B?ekJ3OEhudjJUamhBTEM0cU1PeElXUm1BeXNJWjh6YVRBYzNFMlJvRSt4Q2pN?=
 =?utf-8?B?L05DMWh1ZW5lSFNUZFBDb3AzV2F0cWtibWRvN1E3Y1hrQjB3Qk9ESU85cHkx?=
 =?utf-8?B?K2w0WlVZWlNpV1F5MXJLL2RKaWIwUTJNYUpIOVRjR0dBRU1vVFJsQTZ4RTFV?=
 =?utf-8?B?L3ZGYUVSZ1g1YUFoUFFJd2U1eXB1NkdEcVhHL29yZzJ0RjdCWEJzNTRSMHBk?=
 =?utf-8?B?WUdyWURYL0RxdUlFdm41eXJuNDdzS3NnaVhJVW9mTlUxb3A4cFRBN2R4NmhO?=
 =?utf-8?B?dFZvLzVzdXN0VlExdlJNMVVZSCtDdkNRWW43K1B3dE5mNk9hR0VDUG5iODhs?=
 =?utf-8?B?QmFCSldpTm00Zkl5NmZySFNwdGkyVVgwZ0kzN042cE1RSWV0cFc0ODdyTStQ?=
 =?utf-8?B?cUxLZU5nOS9MTlFiZG9DMzlockhOUkYyU1Jxb3hzWSs0QW5ETkoyTm1zeFFS?=
 =?utf-8?B?MThXUWFvWklPb0hrdmgwaitYeW1iaWNrWE16eFFLVnd4am95ZnUraWExQWhx?=
 =?utf-8?B?NzV6UGUwVU5QQjg3NlZHUjhkMHIyUzYxMGF3bWRldmdnSU4wbTVGNlJHQjVE?=
 =?utf-8?B?YUQ1UFgvTEVSc0tEVWlmTjVoZUdneDIrd3V5VnRiVHVWZ0U2dzB6TUMrZENR?=
 =?utf-8?B?bzZkSjJlSm0zRnRtblpQcE9leDFrMTRsVnV4blpGc2xOcm02WjF4OHBYdzd0?=
 =?utf-8?B?ZCtCcGVtWGJ5TkhmT21pRVdJYlg3Tk9xS0pya0Z5TXdkaXgxbm9XcURIVGY3?=
 =?utf-8?B?RXg1WFJINm9GOFV6WmlzbjNaY2NQcXZRWHZsWHVCS2UreTVZc0FFckZFZy9L?=
 =?utf-8?B?UHFlSmhaTmROMVpTZVFHZWVqTHFhWGZTRXB6eVhKZTg2bS9lNEtGRGxxbFQz?=
 =?utf-8?B?ZXBFRG9MQ0l2SlZRMytpMzlmd0l5a3JmWU41WTRiRjhxUEh6LzZjNVRGYytK?=
 =?utf-8?B?WXpQcjhiWVlGRzZhY05Tb1hrUFBWRjN0dzZ6M21Edmk1aUhaTDBiM2NZV0Vt?=
 =?utf-8?B?NHFPTFgzWVhaY2YxN3lyRzJpL3BWRGNRL2hhL2NCSlpWN3VveU5BbzlnbXFT?=
 =?utf-8?B?THJwbWljRGhWTVVoWHFBUHE4aXdNRFdLa2dRSzFSeEVXQmZDalBCZDRoRXAz?=
 =?utf-8?B?U1NHN2lpZ1FTaGtRQ0ZtNFVkMTA4aVpXRnZaTS9WTmNud0JWMTZiemxSWVc4?=
 =?utf-8?B?TmhTc2lHd2pDS21XVUhjZ1J0RHNIbEhhY1AvVGwrTUdxa2VjOFpmUFd0QWpw?=
 =?utf-8?B?bkk1NDRtelJJOHRKYmwzb2l5djRuNWNNcm1MaWZ0aHdBaThWeVVhQTZzY0lR?=
 =?utf-8?B?Y2dHZHk4SDAwNWFtM3BtRWluc2dGL1RXbGZ2QWpUS1lMa2dtdlRKSUp5SWI0?=
 =?utf-8?B?cGxob0FSYjdtUDQ0YndVbi82clpQRWlFWjRGeUNJaGRRMEw0QmcrUjZTUTRO?=
 =?utf-8?B?bE9Dc3JPOUJEblVaTnFqVE9DYTdTYmNkMFJPZGdSUXNIWTd3VVk1R2FYaXg4?=
 =?utf-8?B?N2c9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f5b2473a-6ae2-4896-3043-08dcc21924cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2024 19:40:42.6793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UIOwM5bF17kNmkqPPKJ9BkZ6T32z3MjEIJ0kbiznfVUwCpubgjry7vwdSpYKXxMuYfcjqEnp7+AXTI2Wa19z220sNbqQ/ZZfZ6CL75bH+FY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7955
X-OriginatorOrg: intel.com

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE5oYXQgUGhhbSA8bnBoYW1j
c0BnbWFpbC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgQXVndXN0IDIxLCAyMDI0IDEyOjI0IFBN
DQo+IFRvOiBTcmlkaGFyLCBLYW5jaGFuYSBQIDxrYW5jaGFuYS5wLnNyaWRoYXJAaW50ZWwuY29t
Pg0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtbW1Aa3ZhY2sub3Jn
Ow0KPiBoYW5uZXNAY21weGNoZy5vcmc7IHlvc3J5YWhtZWRAZ29vZ2xlLmNvbTsgcnlhbi5yb2Jl
cnRzQGFybS5jb207DQo+IEh1YW5nLCBZaW5nIDx5aW5nLmh1YW5nQGludGVsLmNvbT47IDIxY25i
YW9AZ21haWwuY29tOyBha3BtQGxpbnV4LQ0KPiBmb3VuZGF0aW9uLm9yZzsgWm91LCBOYW5oYWkg
PG5hbmhhaS56b3VAaW50ZWwuY29tPjsgRmVnaGFsaSwgV2FqZGkgSw0KPiA8d2FqZGkuay5mZWdo
YWxpQGludGVsLmNvbT47IEdvcGFsLCBWaW5vZGggPHZpbm9kaC5nb3BhbEBpbnRlbC5jb20+DQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjFdIG1tOiBEZWZpbmVzIG9ial9jZ3JvdXBfZ2V0KCkgaWYg
Q09ORklHX01FTUNHIGlzDQo+IG5vdCBkZWZpbmVkLg0KPiANCj4gT24gVHVlLCBBdWcgMjAsIDIw
MjQgYXQgMzo1MOKAr1BNIEthbmNoYW5hIFAgU3JpZGhhcg0KPiA8a2FuY2hhbmEucC5zcmlkaGFy
QGludGVsLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBUaGlzIHJlc29sdmVzIGFuIGlzc3VlIHdpdGgg
b2JqX2Nncm91cF9nZXQoKSBub3QgYmVpbmcgZGVmaW5lZA0KPiA+IGlmIENPTkZJR19NRU1DRyBp
cyBub3QgZGVmaW5lZC4gVGhpcyBjYXVzZXMgYnVpbGQgZXJyb3JzIGlmDQo+ID4gb2JqX2Nncm91
cF9nZXQoKSBpcyBjYWxsZWQgZnJvbSBjb2RlIHRoYXQgaXMgYWdub3N0aWMgb2YgQ09ORklHX01F
TUNHLg0KPiA+DQo+ID4gVGhlIHBhdGNoIHJlc29sdmVzIHRoaXMuDQo+ID4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBLYW5jaGFuYSBQIFNyaWRoYXIgPGthbmNoYW5hLnAuc3JpZGhhckBpbnRlbC5jb20+
DQo+ID4gLS0tDQo+IA0KPiBUaGlzIGlzIG9ubHkgZXhwb3NlZCBiZWNhdXNlIG9mIHlvdXIgenN3
YXAgbVRIUCBwYXRjaCBzZXJpZXMgcmlnaHQ/DQo+IENvdWxkIHlvdSBpbmNsdWRlIHRoaXMgcGF0
Y2ggYXMgcGFydCBvZiB0aGF0IHNlcmllcyAoc2luY2Ugd2UgZG9uJ3QNCj4gbmVlZCB0aGlzIHdp
dGhvdXQgdGhhdCBwYXRjaCBzZXJpZXMpLCBvciBtYWtlIGl0IGNsZWFyIGluIHRoZSBjaGFuZ2UN
Cj4gbG9nPw0KDQpUaGF0J3MgY29ycmVjdCwgTmhhdC4gQWx0aG91Z2gsIGl0IG1pZ2h0IGJlIHVz
ZWZ1bCB0byBoYXZlIG9ial9jZ3JvdXBfZ2V0KCkNCmRlZmluZWQgaW4gdGhlIGNhc2Ugd2hlcmUg
Q09ORklHX01FTUNHIGlzIG5vdCBkZWZpbmVkLiBtZW1jb250cm9sLmgNCmhhbmRsZXMgb2JqX2Nn
cm91cF9wdXQoKSBzaW1pbGFybHkuIFdvdWxkIGl0IGJlIE9rIGlmIEkgaW5jbHVkZWQgYSByZWZl
cmVuY2UNCnRvIHRoZSB6c3dhcCBtVEhQIHBhdGNoIHNlcmllcyBpbiB0aGUgY2hhbmdlIGxvZz8N
Cg0KVGhhbmtzLA0KS2FuY2hhbmENCg==

