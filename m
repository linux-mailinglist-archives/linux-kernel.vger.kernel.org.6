Return-Path: <linux-kernel+bounces-430309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1709E2F02
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 23:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E2CE165909
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 22:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677A2207A2E;
	Tue,  3 Dec 2024 22:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a/eleZ25"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8D71362;
	Tue,  3 Dec 2024 22:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733264671; cv=fail; b=dTzMKxvCBoPtaK5mOXvyxsCnuVl3xAfz17SQYSeZGHPzkYeZjfmA+iWKycuZgJItohO+OE3TW6YM8xJWseaQubezELGpqAKuE1i8fFiG7GaJrNbVdcpAotwKOMYnV6x1OuRxCJPmpuVGcutZ/OUW+2KZ817fVsDdYx3yQr3r8oo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733264671; c=relaxed/simple;
	bh=U9cs12u+Fsz0Ek3Z5Dg/REzGAvx+n0cqbOn8104GRH0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o+OWptEDWfauLyc6QC7R38LRRsWrd5+bnqEI7aFWWqYsdv9l0Ya7I+UoO3tGl3jYZYfYGm9L+NjB70bphEANZ+rYxaR7VhraigbfD593xqiaCanax7qkGLHS2uIiQumzJMILWm0fnDn9zYmtTuRz6/MmFu5rlTa3abIH8izgIac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a/eleZ25; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733264669; x=1764800669;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=U9cs12u+Fsz0Ek3Z5Dg/REzGAvx+n0cqbOn8104GRH0=;
  b=a/eleZ25hzmZRhOjkgZVzR4sG9JNXitI6bx9kNnc5F8PJEhGCRpA00W6
   //FU3GkbJ1YIkTVYgjlpShVo6HIlHppf0rKX8fS3XaGKGdQ58qVdbvtWP
   OHv638jG+/pX2u7YhBv4+norFCZhvrQgBlamczW7HIvonXJNK3P7U7iIl
   dyydYIU9xrS/zsVe3UffEwxFTMRZheqLr+Vj4Q/jwbcaGX0tfMbQ8JJPi
   DUjxffemzweqwtuVLkIIBiCNzHr0f0Jppl6uhDPj/zHRyHGuc/5C9tkVR
   Bz52EViNQ5vuOFRuHJZ2tfn+9fLdyu3i3sYj7B90InpHQF3pDzvv8IE7z
   g==;
X-CSE-ConnectionGUID: zF/8hrSuRJul/p6Z6yyC/g==
X-CSE-MsgGUID: /mV+CubQSWyj7eG3jeLZUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="51032963"
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="51032963"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 14:24:27 -0800
X-CSE-ConnectionGUID: Il4OZdOvRVinRPKsKeofrQ==
X-CSE-MsgGUID: QVlMMjGSQlibmPK7Cau5EQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="98558033"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Dec 2024 14:24:27 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 3 Dec 2024 14:24:26 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 3 Dec 2024 14:24:26 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 3 Dec 2024 14:24:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FFhI3QA7hPOzd0H4jqJ3LHqWiP0cdAPAfV33dbyepzMXHd9AEdk8r1LgSPpprr7hbX3c8XZmHm+vg5O8Moc3N2J7CXFQz1SFh0msjkrt9A+BvHLtDW1TlMM8i2CbQPd9PgTpEeAFbvUatGd9Ifd08aVofe3eyj5ok1VGqfVgA0huhTZCCJnRa8yU+idqLVxTrctXDD7uXO2Pj/dnboxoaAnU0G1W/XljkCvt/ysfPZjLCNIfR2k+oG+EkVJCa2yEQeNmdRvLfL6nYnlfhId1qg0Jzj1t8ZadYKx5hnK3l0Lrvg6MKD8dopjImtVEJBmdTtHW0+M5CSxicvI2ebrg7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U9cs12u+Fsz0Ek3Z5Dg/REzGAvx+n0cqbOn8104GRH0=;
 b=zVpQLFwp1JnsFX+0Jc6lmvPEeVIgRLJozXKARMPwDNfLjbcciDasHa/OOanNWaYtkxAXkJAOH85nYIrGUWT1N+SjX5rtuCi0SgoFF87PFPW1QzAFdAUbQQQqhABcjQhrpcD/3CXyut3+4p0+4f/5sY9GFpMtV/roxEM7a9ydjsOdzQ8mibn4lgWglzjyrv50TBR6ev4B51Il5UOVDlSKo44/XdI09pDPvvAq52aetcZXFZOwL+bXzDFwzDReVi8EHAUWPBgiCOumkcR7EgYAZpSisOe1EAi0NSwf0pDZgoPAM45D8BRV+ZXWm2A0y4SWS/IJ7KA5jr6ay50YhLRpRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by MW6PR11MB8367.namprd11.prod.outlook.com (2603:10b6:303:249::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 22:24:17 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 22:24:17 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Yosry Ahmed <yosryahmed@google.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Nhat Pham <nphamcs@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "ryan.roberts@arm.com"
	<ryan.roberts@arm.com>, "21cnbao@gmail.com" <21cnbao@gmail.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "clabbe@baylibre.com"
	<clabbe@baylibre.com>, "ardb@kernel.org" <ardb@kernel.org>,
	"ebiggers@google.com" <ebiggers@google.com>, "surenb@google.com"
	<surenb@google.com>, "Accardi, Kristen C" <kristen.c.accardi@intel.com>,
	"Feghali, Wajdi K" <wajdi.k.feghali@intel.com>, "Gopal, Vinodh"
	<vinodh.gopal@intel.com>, "Sridhar, Kanchana P"
	<kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v4 09/10] mm: zswap: Allocate pool batching resources if
 the crypto_alg supports batching.
Thread-Topic: [PATCH v4 09/10] mm: zswap: Allocate pool batching resources if
 the crypto_alg supports batching.
Thread-Index: AQHbPXWU4Gc6KD17CkKDJ7pv5ZtEYLLTYjKAgABKBaCAAIvAgIAA4a2QgAAEXQCAAACVwIAACbdg
Date: Tue, 3 Dec 2024 22:24:17 +0000
Message-ID: <SJ0PR11MB5678F262108A0ED22A84698BC9362@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20241123070127.332773-1-kanchana.p.sridhar@intel.com>
 <20241123070127.332773-10-kanchana.p.sridhar@intel.com>
 <CAKEwX=PmKWH4Z4Py9Jti9fcD6qCYJBBRrDF48qdmo8-i+LzzfA@mail.gmail.com>
 <SJ0PR11MB56783454B5985ACD48744772C9362@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <Z066p53LoISwqkmX@gondor.apana.org.au>
 <SJ0PR11MB5678AAEF4F62773847E6307FC9362@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkbui2MTkkGA6_+RDA0oZW2m3rMnUTKp1Fp6tPqp2QLgKw@mail.gmail.com>
 <SJ0PR11MB56789D21AAA0970F9B8AB5CFC9362@SJ0PR11MB5678.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB56789D21AAA0970F9B8AB5CFC9362@SJ0PR11MB5678.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|MW6PR11MB8367:EE_
x-ms-office365-filtering-correlation-id: 49e297d1-6a31-4e1b-6b75-08dd13e939c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|10070799003|7053199007|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cnRrdFY3d2dUWkpVekNiM3NGT1E4QnpVNm14T2lIb3B6Qi9MN2NkbVRGY3hs?=
 =?utf-8?B?ZWtTajZsdFF0Ujk2ZDJ0eUozeWFzaldPSmxBQXJRdEhwdmlnTlB2dkxheEV3?=
 =?utf-8?B?VVQ0Y1BCU0RjUnBLbUl4VjI1MlRsRDExTm55L1BhU3RWV2JRYi9vZ2FLaXJB?=
 =?utf-8?B?aTYwZlZFQ0FXRUM0MWhUVW1WaWRJRVI4WVJmNE5tc3Rudy9qQzFHakVNb3Q5?=
 =?utf-8?B?cXppL2ppVmxPb0ppbGlJMG8vWHlldVgxQS9zUXRyTEpES2FGMUw2TmVXYUJH?=
 =?utf-8?B?N3lYM2tJbmV1RWRRVjNkZXdHVjNKUTlHNmk0ZHRFNENOSjU3K0JqRWFKd2hk?=
 =?utf-8?B?NVpORVNFb0FSOVQ5M0RTdU4veGxhSnpBVGZXYlBmakxJV2thekYzYkxLd21j?=
 =?utf-8?B?VWtiOXFWcWptTTQwWWR0RnBFRFVFeEZRMVA4YmRGeVZFRnlpNE10dXplb2RL?=
 =?utf-8?B?TVA3MHlYeU5RaTBaeFlaQ0lwamppcmxob2lVVXVna0dOOWZzcWtqVCs5ZFJT?=
 =?utf-8?B?RFVmdzFGbXZha05EclNxSmpJMzY4bUdQUWYwUE1FQVIraURqL3BnMlpyeHJZ?=
 =?utf-8?B?ZCtKQ0FHUURrT3ZtU2wvQW54OExmOEhJVVBMS3pMcVp4VFpvWmlhQjR5RW0r?=
 =?utf-8?B?NlFEMEFVcGhQRTRaR05TV0tKM3NTTWlOazhEWGRPL2ZaeGJuSFFNQzdESWtw?=
 =?utf-8?B?MHFtc1VseDVMMTB2d0s2b1lVd0lHd1N5dE15azFMMzUwOC9PZG5jdU5RSUNQ?=
 =?utf-8?B?bWxNWFdURCswSHkyNGx3cHNJbnlzbk1ydzV6UmlKSE1OUnlOVTZZeEpLSjh6?=
 =?utf-8?B?YlVVeFgxNXY4ejg1RkNkUHpoRDVVSXVicEhybVFTQUlrbGRXeHA5cjRZKytx?=
 =?utf-8?B?S0ZPd2wvdzFCMVUzNzNFeHljL1JwK2p0ZTN1S2lTbzc2Vkg5QmNoMXErdjI3?=
 =?utf-8?B?ZHhncmlYZ3htdEZQNFZUTlJmV2dRNHkzMGw0RFFsU3AwU3VLUmxKWXNxYnBz?=
 =?utf-8?B?NSs1U01MbjUvUHNWNGhxMFMvcHVHNFgvUEJLYXBDZmxLQUpHS2t1SzBpRUI5?=
 =?utf-8?B?RWFJVEFtMDVlNDJLYTl3V1BNbWtta3F3Z1ExQytHYkt3eTc3YXlVYmVOSXBS?=
 =?utf-8?B?OW1waW1idlU2TStGZFpRTitNOWc0YXg3TFBOaGVMbHloS2xMM1ZmcXd4MWl0?=
 =?utf-8?B?cFpveW8zdzk5aU9FdHQreTlEZTRvZ0JveHRyN05MMEN0WDdzK3RxSzN2NC9n?=
 =?utf-8?B?K01SYlp2T0RpMWk1dW1xVnBFVm02dGxlb0M1TE9ibEV2WjdjbzJ2NVQybmJo?=
 =?utf-8?B?RW03TmhGQlNiOWNxaGluazRYckFUR282ZTlyOUg3eWphdVcxQ2QwUUYxS2NP?=
 =?utf-8?B?eitsRlFjN0NjTFNLcWJOaU9zR0lEbFRIcEN2MExFWkY5OEhuL1NjOGFVZGJy?=
 =?utf-8?B?VmRvK01iSGhHb2JSLytKV1dDWDRFY0Y1SVpKWEdITkRPV24rMlBoVW9vOFhG?=
 =?utf-8?B?OWFzSTY2VWc5Q0NXZVR1UDk0WkpWQ01WMFhjcnN6QmQxdldvWXFqUTQ4T0Zn?=
 =?utf-8?B?MnNMZXJaVHRMWHlDLzZNaGxaRE9VaDlUbVBJT3RHQWdNT01JUUFKeGowWkJR?=
 =?utf-8?B?aVZ3dElDOW43Z0NMSjFMalFrVjk0RW9OQWwvSHVWRFozWGJRbXRraHZqTExw?=
 =?utf-8?B?bWVCYm45eTJDYTE3c3VES2JHVHkwcnZOTTI2TDliY2Z3TXFOY3E4eXlCWDB6?=
 =?utf-8?B?ZE10UmUyazhiNDRhUmxXT2xUM01DNjBaaXlZRkdaaW8zZkVkZVhwanZWdFYx?=
 =?utf-8?Q?c0L7SeUdQTQ0kb5DQAjO0eCDXWq2ZyrcvPJ/Q=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(10070799003)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WW9TQmhWRzVXeEpjQ2FxZ284L3RESWIrR1p0NmdMNVYyUHJNOHRzWTEzVTNX?=
 =?utf-8?B?NWV3NmRxUVVWcmtEbWMxR2thQm1QenB0cm1VR285N3krZkEvbFZSMnpHVzRx?=
 =?utf-8?B?aklSRTRrelNGeFRGS0JydEVxWTJ6bGl2dkViWEhnYzFVdWJmZmxBR3M3Z0NM?=
 =?utf-8?B?RFNJSXBlTnpUZ1BsMDNVMGlpaGtrV09lclJrSUR3M1NPRVVuMEpoUWVMVDV4?=
 =?utf-8?B?aHZqcjFlc05nczBjQm5XMWlnYmVCZkZNWW9SM1RRL3c1OFBBTnA0NWlVNlBx?=
 =?utf-8?B?Qjh5QVBkTE1mOFZmWVcyeUpiQ1huVlRXeDMwankvODNUa3hrZU84YTVaT1dV?=
 =?utf-8?B?bllFSi83MGxyNURRZkpWc0dOaGRKaFlKVmVpY3hIdGUweU55dlJYZFNMTUVy?=
 =?utf-8?B?V1RuN2R1dTlQL1pxaFNpWE9Yb0tGRCtGY0dqT1FVMHBXdmdlSE95NHdmWWho?=
 =?utf-8?B?V3BnZllmb2ExRERDbFJwc3k4MTliRG1JTnpmS2UwNHpaWXdmVFlhRS8yaERT?=
 =?utf-8?B?aUxheDVBNklZQ3k2RC9RbUkrTTZsNzRhbHdUTDZMQXhaTm9abU8vUGNoWTd5?=
 =?utf-8?B?dVErblVDSTh0QkRwcSt1VWVCeGJRRyt1OTRsbndPTGwrbkljLzU1NWtiMVRq?=
 =?utf-8?B?K3NtM2pmZXQ0OFh0QW9Ed0tDMWgybVJ5eE5RK24xK0krT0FoTGdVYmw1b1Bz?=
 =?utf-8?B?blEzOEJHZ2h4dDdQWFNROE5WYndmVWkzcWlkR2dnUUgvOWVyOWx5UHcyK2Fu?=
 =?utf-8?B?dFhab0w4eXFhdnhCcFVyekQ4SmV3UjZsSGtZbi92NFBWWWZRR3pYTDZWSVpK?=
 =?utf-8?B?aDdTMDU4cGcrRlcyRlI3U3pHOGRtRDQyVXNHR0hlWGtGZFRYZzJHV29nTWFZ?=
 =?utf-8?B?NXhjYUcrWHV6eGNxN0RVQVNDb3hTLzV0SXFXeHM1c3pqTmxOd05NbGt6U3di?=
 =?utf-8?B?TnJFUnRFQnZrTi9KdFdxSEZsV1JKQWtGa0xncy9vSE1EdmRXVCtmdFE3R3A3?=
 =?utf-8?B?NGRic2NaZG5uUDZEUit3R1VLWldHWkoveEFFSjhxS1R6ZEU2ZmJ2V3JYWU82?=
 =?utf-8?B?OHBPZzErbENzUG9pUjZyNzZZSWtKVXdLQWU1dnUwc2JCNmNpZHNEOVRJcUZB?=
 =?utf-8?B?Z25lanFHMk81SENpQWZCUnZxZ1FwVE52UjFONVdTUVRKdk1rMFlMdFdmNU5y?=
 =?utf-8?B?NzdoM1dpVlhTZlVJcVFGaDVjazhJaER1eUxuNXRFc05mVUhxWW9nbTdTb1NV?=
 =?utf-8?B?RU91V3YrRlpVS3JxYVNKL2RBbzRPWVlVR29LYnVrcExiMmFJNmFSaUtvMFJo?=
 =?utf-8?B?cjVFSGtLS2tsWmY1S1pKVk9raC9VS3ZhY3pqZjNjcEQ1bFE2V1psQ3I4cTlV?=
 =?utf-8?B?MVZ6SndGNVQ2T0xzamx4ZmhnUDdUc0VLMUtjZm1tZkVtSkRQdHdpNWRkblJo?=
 =?utf-8?B?MDhDZmZpaU1zbUlwRUE0VjBsY1RLM2kvQTk4eVRlSGc1MjFsNDFublNzSUJ6?=
 =?utf-8?B?dTVtblRsY2o0dXZvV1phYnZVN2cxTEJEcmJNV1FkVVdpRHdWNllBTEpoVUYz?=
 =?utf-8?B?bi9waE84alBUL0tBeUJkYktOaGJIRC9xZUNST09HcVB4YlAxUWRlcXl1V2Ra?=
 =?utf-8?B?VFcvNldib3VTalBPWlQvYkNpN25USlozeEhIR1BNdEtiUzBsbGRlVTZCZ25N?=
 =?utf-8?B?dllaWWRBRFljb2IycW13NUFBb3cwTGdUODllcDFEajlJdGNYaDRZOUhlQUlK?=
 =?utf-8?B?ODVpSW1PNHZzTnNVSkdOeDBLWDU4ZzdFN0FGNnp5UjRVVXBCRS9GNFh4LzRo?=
 =?utf-8?B?a2ZZRWhFaFVRUCs3UkN3RUpIQS9jTURVaml3eTNzRmRFY01UQTBCMXVTVm54?=
 =?utf-8?B?RXFWcWF2dWR1UXVPZ0l1Ry9RcVZtZDZrSjl6Nk5SUVlCejl4N1g1YzVhWmpO?=
 =?utf-8?B?OU9SeWorK3FlQ1dIUDBiT1g3Y0RzcWZlcjdITVliVkpUUE1lcDN3Y0RKdjVQ?=
 =?utf-8?B?NC9GRDV2MlphWFkzOXFqNjJEVmVwaDE5MmNSSGk4S0VQS1BMdFFaTUtvalUz?=
 =?utf-8?B?S3YvdTlObmw2eUZFTDZZeEJFU3NhYlhBYTNrYjJ0SDdvVnp1MUFjcWFSYzJG?=
 =?utf-8?B?d1VEQ1NoK0oxb3l5WEhJU1d3bGlPSjRhdjJFcVhKUWZIeGVzL3REcGNSNm9n?=
 =?utf-8?B?UXpNWFZ0UUg0NXZQcnBmZ2tVRlJCOThWZmFOM1JEenQ2M3d4bkpiNU9uWURH?=
 =?utf-8?B?REdmTmJCUmdaUmFMZ1lZSXMrRFlRPT0=?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 49e297d1-6a31-4e1b-6b75-08dd13e939c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2024 22:24:17.3801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FQC6JFSJIjDsLs/IInmZdnO6NlZ1InyeA7Kw84EJT36tfatCQo1DA6cN+NdWNYZ2ueejT2J0VH/lQ6L28aB3ZTHhH42jy8GDlnNHTTJez5c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8367
X-OriginatorOrg: intel.com

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFNyaWRoYXIsIEthbmNoYW5h
IFAgPGthbmNoYW5hLnAuc3JpZGhhckBpbnRlbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIERlY2Vt
YmVyIDMsIDIwMjQgMjoxOCBQTQ0KPiBUbzogWW9zcnkgQWhtZWQgPHlvc3J5YWhtZWRAZ29vZ2xl
LmNvbT4NCj4gQ2M6IEhlcmJlcnQgWHUgPGhlcmJlcnRAZ29uZG9yLmFwYW5hLm9yZy5hdT47IE5o
YXQgUGhhbQ0KPiA8bnBoYW1jc0BnbWFpbC5jb20+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC1tbUBrdmFjay5vcmc7DQo+IGhhbm5lc0BjbXB4Y2hnLm9yZzsgY2hlbmdtaW5n
Lnpob3VAbGludXguZGV2Ow0KPiB1c2FtYWFyaWY2NDJAZ21haWwuY29tOyByeWFuLnJvYmVydHNA
YXJtLmNvbTsgMjFjbmJhb0BnbWFpbC5jb207DQo+IGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc7
IGxpbnV4LWNyeXB0b0B2Z2VyLmtlcm5lbC5vcmc7DQo+IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGNs
YWJiZUBiYXlsaWJyZS5jb207IGFyZGJAa2VybmVsLm9yZzsNCj4gZWJpZ2dlcnNAZ29vZ2xlLmNv
bTsgc3VyZW5iQGdvb2dsZS5jb207IEFjY2FyZGksIEtyaXN0ZW4gQw0KPiA8a3Jpc3Rlbi5jLmFj
Y2FyZGlAaW50ZWwuY29tPjsgRmVnaGFsaSwgV2FqZGkgSyA8d2FqZGkuay5mZWdoYWxpQGludGVs
LmNvbT47DQo+IEdvcGFsLCBWaW5vZGggPHZpbm9kaC5nb3BhbEBpbnRlbC5jb20+OyBTcmlkaGFy
LCBLYW5jaGFuYSBQDQo+IDxrYW5jaGFuYS5wLnNyaWRoYXJAaW50ZWwuY29tPg0KPiBTdWJqZWN0
OiBSRTogW1BBVENIIHY0IDA5LzEwXSBtbTogenN3YXA6IEFsbG9jYXRlIHBvb2wgYmF0Y2hpbmcg
cmVzb3VyY2VzIGlmDQo+IHRoZSBjcnlwdG9fYWxnIHN1cHBvcnRzIGJhdGNoaW5nLg0KPiANCj4g
DQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBZb3NyeSBBaG1lZCA8
eW9zcnlhaG1lZEBnb29nbGUuY29tPg0KPiA+IFNlbnQ6IFR1ZXNkYXksIERlY2VtYmVyIDMsIDIw
MjQgMTo0NCBQTQ0KPiA+IFRvOiBTcmlkaGFyLCBLYW5jaGFuYSBQIDxrYW5jaGFuYS5wLnNyaWRo
YXJAaW50ZWwuY29tPg0KPiA+IENjOiBIZXJiZXJ0IFh1IDxoZXJiZXJ0QGdvbmRvci5hcGFuYS5v
cmcuYXU+OyBOaGF0IFBoYW0NCj4gPiA8bnBoYW1jc0BnbWFpbC5jb20+OyBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gbW1Aa3ZhY2sub3JnOw0KPiA+IGhhbm5lc0BjbXB4
Y2hnLm9yZzsgY2hlbmdtaW5nLnpob3VAbGludXguZGV2Ow0KPiA+IHVzYW1hYXJpZjY0MkBnbWFp
bC5jb207IHJ5YW4ucm9iZXJ0c0Bhcm0uY29tOyB5aW5nLmh1YW5nQGludGVsLmNvbTsNCj4gPiAy
MWNuYmFvQGdtYWlsLmNvbTsgYWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZzsgbGludXgtDQo+ID4g
Y3J5cHRvQHZnZXIua2VybmVsLm9yZzsgZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgY2xhYmJlQGJheWxp
YnJlLmNvbTsNCj4gPiBhcmRiQGtlcm5lbC5vcmc7IGViaWdnZXJzQGdvb2dsZS5jb207IHN1cmVu
YkBnb29nbGUuY29tOyBBY2NhcmRpLA0KPiA+IEtyaXN0ZW4gQyA8a3Jpc3Rlbi5jLmFjY2FyZGlA
aW50ZWwuY29tPjsgRmVnaGFsaSwgV2FqZGkgSw0KPiA+IDx3YWpkaS5rLmZlZ2hhbGlAaW50ZWwu
Y29tPjsgR29wYWwsIFZpbm9kaCA8dmlub2RoLmdvcGFsQGludGVsLmNvbT4NCj4gPiBTdWJqZWN0
OiBSZTogW1BBVENIIHY0IDA5LzEwXSBtbTogenN3YXA6IEFsbG9jYXRlIHBvb2wgYmF0Y2hpbmcg
cmVzb3VyY2VzDQo+IGlmDQo+ID4gdGhlIGNyeXB0b19hbGcgc3VwcG9ydHMgYmF0Y2hpbmcuDQo+
ID4NCj4gPiBPbiBUdWUsIERlYyAzLCAyMDI0IGF0IDE6MzfigK9QTSBTcmlkaGFyLCBLYW5jaGFu
YSBQDQo+ID4gPGthbmNoYW5hLnAuc3JpZGhhckBpbnRlbC5jb20+IHdyb3RlOg0KPiA+ID4NCj4g
PiA+DQo+ID4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiA+IEZyb206IEhl
cmJlcnQgWHUgPGhlcmJlcnRAZ29uZG9yLmFwYW5hLm9yZy5hdT4NCj4gPiA+ID4gU2VudDogVHVl
c2RheSwgRGVjZW1iZXIgMywgMjAyNCAxMjowMSBBTQ0KPiA+ID4gPiBUbzogU3JpZGhhciwgS2Fu
Y2hhbmEgUCA8a2FuY2hhbmEucC5zcmlkaGFyQGludGVsLmNvbT4NCj4gPiA+ID4gQ2M6IE5oYXQg
UGhhbSA8bnBoYW1jc0BnbWFpbC5jb20+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0K
PiA+IGxpbnV4LQ0KPiA+ID4gPiBtbUBrdmFjay5vcmc7IGhhbm5lc0BjbXB4Y2hnLm9yZzsgeW9z
cnlhaG1lZEBnb29nbGUuY29tOw0KPiA+ID4gPiBjaGVuZ21pbmcuemhvdUBsaW51eC5kZXY7IHVz
YW1hYXJpZjY0MkBnbWFpbC5jb207DQo+ID4gPiA+IHJ5YW4ucm9iZXJ0c0Bhcm0uY29tOyB5aW5n
Lmh1YW5nQGludGVsLmNvbTsgMjFjbmJhb0BnbWFpbC5jb207DQo+ID4gPiA+IGFrcG1AbGludXgt
Zm91bmRhdGlvbi5vcmc7IGxpbnV4LWNyeXB0b0B2Z2VyLmtlcm5lbC5vcmc7DQo+ID4gPiA+IGRh
dmVtQGRhdmVtbG9mdC5uZXQ7IGNsYWJiZUBiYXlsaWJyZS5jb207IGFyZGJAa2VybmVsLm9yZzsN
Cj4gPiA+ID4gZWJpZ2dlcnNAZ29vZ2xlLmNvbTsgc3VyZW5iQGdvb2dsZS5jb207IEFjY2FyZGks
IEtyaXN0ZW4gQw0KPiA+ID4gPiA8a3Jpc3Rlbi5jLmFjY2FyZGlAaW50ZWwuY29tPjsgRmVnaGFs
aSwgV2FqZGkgSw0KPiA+IDx3YWpkaS5rLmZlZ2hhbGlAaW50ZWwuY29tPjsNCj4gPiA+ID4gR29w
YWwsIFZpbm9kaCA8dmlub2RoLmdvcGFsQGludGVsLmNvbT4NCj4gPiA+ID4gU3ViamVjdDogUmU6
IFtQQVRDSCB2NCAwOS8xMF0gbW06IHpzd2FwOiBBbGxvY2F0ZSBwb29sIGJhdGNoaW5nDQo+ID4g
cmVzb3VyY2VzIGlmDQo+ID4gPiA+IHRoZSBjcnlwdG9fYWxnIHN1cHBvcnRzIGJhdGNoaW5nLg0K
PiA+ID4gPg0KPiA+ID4gPiBPbiBUdWUsIERlYyAwMywgMjAyNCBhdCAxMjozMDozMEFNICswMDAw
LCBTcmlkaGFyLCBLYW5jaGFuYSBQIHdyb3RlOg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBXaHkg
ZG8gd2UgbmVlZCB0aGlzICJjYW5fYmF0Y2giIGZpZWxkPyBJSVVDLCB0aGlzIGNhbiBiZQ0KPiBk
ZXRlcm1pbmVkDQo+ID4gPiA+ID4gPiBmcm9tIHRoZSBjb21wcmVzc29yIGludGVybmFsIGZpZWxk
cyBpdHNlbGYsIG5vPw0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IGFjb21wX2hhc19hc3luY19i
YXRjaGluZyhhY29tcCk7DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gSXMgdGhpcyBqdXN0IGZv
ciBjb252ZW5pZW5jZSwgb3IgaXMgdGhpcyBhY3R1YWxseSBhbiBleHBlbnNpdmUgdGhpbmcgdG8N
Cj4gPiA+ID4gY29tcHV0ZT8NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFRoYW5rcyBmb3IgeW91ciBj
b21tZW50cy4gVGhpcyBpcyBhIGdvb2QgcXVlc3Rpb24uIEkgdHJpZWQgbm90IHRvIGltcGx5DQo+
ID4gdGhhdA0KPiA+ID4gPiA+IGJhdGNoaW5nIHJlc291cmNlcyBoYXZlIGJlZW4gYWxsb2NhdGVk
IGZvciB0aGUgY3B1IGJhc2VkIG9ubHkgb24gd2hhdA0KPiA+ID4gPiA+IGFjb21wX2hhc19hc3lu
Y19iYXRjaGluZygpIHJldHVybnMuIEl0IGlzIHBvc3NpYmxlIHRoYXQgdGhlIGNwdQ0KPiBvbmxp
bmluZw0KPiA+ID4gPiA+IGNvZGUgcmFuIGludG8gYW4gLUVOT01FTSBlcnJvciBvbiBhbnkgcGFy
dGljdWxhciBjcHUuIEluIHRoaXMgY2FzZSwgSQ0KPiA+IHNldA0KPiA+ID4gPiA+IHRoZSBwb29s
LT5jYW5fYmF0Y2ggdG8gImZhbHNlIiwgbWFpbmx5IGZvciBjb252ZW5pZW5jZSwgc28gdGhhdCB6
c3dhcA0KPiA+ID4gPiA+IGNhbiBiZSBzb21ld2hhdCBpbnN1bGF0ZWQgZnJvbSBtaWdyYXRpb24u
IEkgYWdyZWUgdGhhdCB0aGlzIG1heSBub3QNCj4gYmUNCj4gPiA+ID4gPiB0aGUgYmVzdCBzb2x1
dGlvbjsgYW5kIHdoZXRoZXIgb3Igbm90IGJhdGNoaW5nIGlzIGVuYWJsZWQgY2FuIGJlDQo+IGRp
cmVjdGx5DQo+ID4gPiA+ID4gZGV0ZXJtaW5lZCBqdXN0IGJlZm9yZSB0aGUgY2FsbCB0byBjcnlw
dG9fYWNvbXBfYmF0Y2hfY29tcHJlc3MoKQ0KPiA+ID4gPiA+IGJhc2VkIG9uOg0KPiA+ID4gPiA+
DQo+ID4gPiA+ID4gYWNvbXBfY3R4LT5ucl9yZXFzID09IFNXQVBfQ1JZUFRPX0JBVENIX1NJWkU7
DQo+ID4gPiA+DQo+ID4gPiA+IFdpdGggYWhhc2ggcmVxdWVzdCBjaGFpbmluZywgdGhlIGlkZWEg
aXMgdG8gYWNjdW11bGF0ZSBhcyBtdWNoDQo+ID4gPiA+IGRhdGEgYXMgeW91IGNhbiBiZWZvcmUg
eW91IHByb3ZpZGUgaXQgdG8gdGhlIENyeXB0byBBUEkuICBUaGUNCj4gPiA+ID4gQVBJIGlzIHJl
c3BvbnNpYmxlIGZvciBkaXZpZGluZyBpdCB1cCBpZiB0aGUgdW5kZXJseWluZyBkcml2ZXINCj4g
PiA+ID4gaXMgb25seSBhYmxlIHRvIGhhbmRsZSBvbmUgcmVxdWVzdCBhdCBhIHRpbWUuDQo+ID4g
PiA+DQo+ID4gPiA+IFNvIHRoYXQgd291bGQgYmUgdGhlIGlkZWFsIG1vZGVsIHRvIHVzZSBmb3Ig
Y29tcHJlc3Npb24gYXMgd2VsbC4NCj4gPiA+ID4gUHJvdmlkZSBhcyBtdWNoIGRhdGEgYXMgeW91
IGNhbiBhbmQgbGV0IHRoZSBBUEkgaGFuZGxlIHRoZSBjYXNlDQo+ID4gPiA+IHdoZXJlIHRoZSBk
YXRhIG5lZWRzIHRvIGJlIGRpdmlkZWQgdXAuDQo+ID4gPg0KPiA+ID4gVGhhbmtzIGZvciB0aGlz
IHN1Z2dlc3Rpb24hIFRoaXMgc291bmRzIGxpa2UgYSBjbGVhbiB3YXkgdG8gaGFuZGxlIHRoZQ0K
PiA+ID4gYmF0Y2hpbmcvc2VxdWVudGlhbCBjb21wcmVzcy9kZWNvbXByZXNzIHdpdGhpbiB0aGUg
Y3J5cHRvIEFQSSBhcyBsb25nDQo+ID4gPiBhcyBpdCBjYW4gYmUgY29udGFpbmVkIGluIHRoZSBj
cnlwdG8gYWNvbXByZXNzIGxheWVyLg0KPiA+ID4gSWYgdGhlIHpzd2FwIG1haW50YWluZXJzIGRv
bid0IGhhdmUgYW55IG9iamVjdGlvbnMsIEkgY2FuIGxvb2sgaW50byB0aGUNCj4gPiA+IGZlYXNp
YmlsaXR5IG9mIGRvaW5nIHRoaXMuDQo+ID4NCj4gPiBEb2VzIHRoaXMgbWVhbiB0aGF0IGluc3Rl
YWQgb2YgenN3YXAgYnJlYWtpbmcgZG93biB0aGUgZm9saW8gaW50bw0KPiA+IFNXQVBfQ1JZUFRP
X0JBVENIX1NJWkUgLXNpemVkIGJhdGNoZXMsIHdlIHBhc3MgYWxsIHRoZSBwYWdlcyB0byB0aGUN
Cj4gPiBjcnlwdG8gbGF5ZXIgYW5kIGxldCBpdCBkbyB0aGUgYmF0Y2hpbmcgYXMgaXQgcGxlYXNl
cz8NCj4gDQo+IElmIEkgdW5kZXJzdGFuZCBIZXJiZXJ0J3Mgc3VnZ2VzdGlvbiBjb3JyZWN0bHks
IEkgdGhpbmsgd2hhdCBoZSBtZWFudCB3YXMNCj4gdGhhdCB3ZSBhbGxvY2F0ZSBvbmx5IFNXQVBf
Q1JZUFRPX0JBVENIX1NJWkUgIyBvZiBidWZmZXJzIGluIHpzd2FwIChzYXksDQo+IDgpDQo+IGR1
cmluZyB0aGUgY3B1IG9ubGluaW5nIGFsd2F5cy4gVGhlIGFjb21wX2hhc19hc3luY19iYXRjaGlu
ZygpIEFQSSBjYW4NCj4gYmUgdXNlZCB0byBkZXRlcm1pbmUgd2hldGhlciB0byBhbGxvY2F0ZSBt
b3JlIHRoYW4gb25lIGFjb21wX3JlcSBhbmQNCj4gY3J5cHRvX3dhaXQgKGZ5aSwgSSBhbSBjcmVh
dGluZyBTV0FQX0NSWVBUT19CQVRDSF9TSVpFICMgb2YgY3J5cHRvX3dhaXQNCj4gZm9yIHRoZSBy
ZXF1ZXN0IGNoYWluaW5nIHdpdGggdGhlIGdvYWwgb2YgdW5kZXJzdGFuZGluZyBwZXJmb3JtYW5j
ZSB3cnQgdGhlDQo+IGV4aXN0aW5nIGltcGxlbWVudGF0aW9uIG9mIGNyeXB0b19hY29tcF9iYXRj
aF9jb21wcmVzcygpKS4NCj4gSW4genN3YXBfc3RvcmVfZm9saW8oKSwgd2UgcHJvY2VzcyB0aGUg
bGFyZ2UgZm9saW8gaW4gYmF0Y2hlcyBvZiA4IHBhZ2VzDQo+IGFuZCBjYWxsICJjcnlwdG9fYWNv
bXBfYmF0Y2hfY29tcHJlc3MoKSIgZm9yIGVhY2ggYmF0Y2guIEJhc2VkIG9uIGVhcmxpZXINCj4g
ZGlzY3Vzc2lvbnMgaW4gdGhpcyB0aHJlYWQsIGl0IG1pZ2h0IG1ha2Ugc2Vuc2UgdG8gYWRkIGEg
Ym9vbCBvcHRpb24gdG8NCj4gY3J5cHRvX2Fjb21wX2JhdGNoX2NvbXByZXNzKCkgYXMgZm9sbG93
czoNCj4gDQo+IHN0YXRpYyBpbmxpbmUgYm9vbCBjcnlwdG9fYWNvbXBfYmF0Y2hfY29tcHJlc3Mo
c3RydWN0IGFjb21wX3JlcSAqcmVxc1tdLA0KPiAJCQkJCSAgICAgICBzdHJ1Y3QgY3J5cHRvX3dh
aXQgKndhaXRzW10sDQo+IAkJCQkJICAgICAgIHN0cnVjdCBwYWdlICpwYWdlc1tdLA0KPiAJCQkJ
CSAgICAgICB1OCAqZHN0c1tdLA0KPiAJCQkJCSAgICAgICB1bnNpZ25lZCBpbnQgZGxlbnNbXSwN
Cj4gCQkJCQkgICAgICAgaW50IGVycm9yc1tdLA0KPiAJCQkJCSAgICAgICBpbnQgbnJfcGFnZXMs
DQo+IAkJCQkJICAgICAgIGJvb2wgcGFyYWxsZWwpOw0KPiANCj4genN3YXAgd291bGQgYWNxdWly
ZSB0aGUgcGVyLWNwdSBhY29tcF9jdHgtPm11dGV4LCBhbmQgcGFzcw0KPiAoYWNvbXBfY3R4LT5u
cl9yZXFzID09IFNXQVBfQ1JZUFRPX0JBVENIX1NJWkUpIGZvciB0aGUgInBhcmFsbGVsIg0KPiBw
YXJhbWV0ZXIuDQo+IFRoaXMgaW5kaWNhdGVzIHRvIGNyeXB0b19hY29tcF9iYXRjaF9jb21wcmVz
cygpIHdoZXRoZXIgb3Igbm90DQo+IFNXQVBfQ1JZUFRPX0JBVENIX1NJWkUgIyBvZiBlbGVtZW50
cyBhcmUgYXZhaWxhYmxlIGluICJyZXFzIiBhbmQNCj4gIndhaXRzIi4NCj4gDQo+IElmIHdlIGhh
dmUgbXVsdGlwbGUgInJlcXMiIChwYXJhbGxlbCA9PSB0cnVlKSwgd2UgdXNlIHJlcXVlc3QgY2hh
aW5pbmcgKG9yIHRoZQ0KPiBleGlzdGluZyBhc3luY2hyb25vdXMgcG9sbCBpbXBsZW1lbnRhdGlv
bikgZm9yIElBQSBiYXRjaGluZy4gSWYgKHBhcmFsbGVsID09DQo+IGZhbHNlKSwNCj4gY3J5cHRv
X2Fjb21wX2JhdGNoX2NvbXByZXNzKCkgd2lsbCBsb29rIHNvbWV0aGluZyBsaWtlIHRoaXM6DQo+
IA0KPiBzdGF0aWMgaW5saW5lIGJvb2wgY3J5cHRvX2Fjb21wX2JhdGNoX2NvbXByZXNzKHN0cnVj
dCBhY29tcF9yZXEgKnJlcXNbXSwNCj4gCQkJCQkgICAgICAgc3RydWN0IGNyeXB0b193YWl0ICp3
YWl0c1tdLA0KPiAJCQkJCSAgICAgICBzdHJ1Y3QgcGFnZSAqcGFnZXNbXSwNCj4gCQkJCQkgICAg
ICAgdTggKmRzdHNbXSwNCj4gCQkJCQkgICAgICAgdW5zaWduZWQgaW50IGRsZW5zW10sDQo+IAkJ
CQkJICAgICAgIGludCBlcnJvcnNbXSwNCj4gCQkJCQkgICAgICAgaW50IG5yX3BhZ2VzLA0KPiAJ
CQkJCSAgICAgICBib29sIHBhcmFsbGVsKQ0KPiB7DQo+IAlpZiAoIXBhcmFsbGVsKSB7DQo+IAkJ
c3RydWN0IHNjYXR0ZXJsaXN0IGlucHV0LCBvdXRwdXQ7DQo+IAkJaW50IGk7DQo+IA0KPiAJCWZv
ciAoaSA9IDA7IGkgPCBucl9wYWdlczsgKytpKSB7DQo+IAkJCS8qIGZvciBwYWdlc1tpXSwgYnVm
ZmVyc1tpXSwgZGxlbnNbaV06IGJvcnJvdyBmaXJzdCBoYWxmIG9mDQo+IAkJCSAqIHpzd2FwX2Nv
bXByZXNzKCkgZnVuY3Rpb25hbGl0eToNCj4gCQkJKi8NCj4gCQkJZHN0ID0gYWNvbXBfY3R4LT5i
dWZmZXJzW2ldOw0KPiAJCQlzZ19pbml0X3RhYmxlKCZpbnB1dCwgMSk7DQo+IAkJCXNnX3NldF9w
YWdlKCZpbnB1dCwgcGFnZXNbaV0sIFBBR0VfU0laRSwgMCk7DQo+IA0KPiAJCQlzZ19pbml0X29u
ZSgmb3V0cHV0LCBkc3QsIFBBR0VfU0laRSAqIDIpOw0KPiAJCQlhY29tcF9yZXF1ZXN0X3NldF9w
YXJhbXMoYWNvbXBfY3R4LT5yZXFzWzBdLA0KPiAmaW5wdXQsICZvdXRwdXQsIFBBR0VfU0laRSwg
ZGxlbnNbaV0pOw0KPiANCj4gCQkJY29tcF9yZXQgPQ0KPiBjcnlwdG9fd2FpdF9yZXEoY3J5cHRv
X2Fjb21wX2NvbXByZXNzKGFjb21wX2N0eC0+cmVxc1swXSksIGFjb21wX2N0eC0NCj4gPndhaXRz
WzBdKTsNCj4gCQkJZGxlbnNbaV0gPSBhY29tcF9jdHgtPnJlcXNbMF0tPmRsZW47DQo+IAkJfQ0K
PiAJfQ0KPiANCj4gCS8qDQo+IAkgKiBBdCB0aGlzIHBvaW50IHdlIHdvdWxkIGhhdmUgc2VxdWVu
dGlhbGx5IGNvbXByZXNzZWQgdGhlIGJhdGNoLg0KPiAJICogenN3YXBfc3RvcmVfZm9saW8oKSBj
YW4gcHJvY2VzcyB0aGUgYnVmZmVycyBhbmQgZGxlbnMgdXNpbmcNCj4gCSAqIGNvbW1vbiBjb2Rl
IGZvciBiYXRjaGluZyBhbmQgbm9uLWJhdGNoaW5nIGNvbXByZXNzb3JzLg0KPiAJKi8NCj4gfQ0K
PiANCj4gSUlVQywgdGhpcyBzdWdnZXN0aW9uIGFwcGVhcnMgdG8gYmUgYWxvbmcgdGhlIGxpbmVz
IG9mIHVzaW5nIGNvbW1vbg0KPiBjb2RlIGluIHpzd2FwIGFzIGZhciBhcyBwb3NzaWJsZSwgZm9y
IGNvbXByZXNzb3JzIHRoYXQgZG8gYW5kIGRvIG5vdA0KPiBzdXBwb3J0IGJhdGNoaW5nLiBIZXJi
ZXJ0IGNhbiBjb3JyZWN0IG1lIGlmIEkgYW0gd3JvbmcuDQo+IA0KPiBJZiB0aGlzIGlzIGluZGVl
ZCB0aGUgY2FzZSwgdGhlIG1lbW9yeSBwZW5hbHR5IGZvciBzb2Z0d2FyZSBjb21wcmVzc29ycw0K
PiB3b3VsZCBiZToNCj4gMSkgcHJlLWFsbG9jYXRpbmcgU1dBUF9DUllQVE9fQkFUQ0hfU0laRSBh
Y29tcF9jdHgtPmJ1ZmZlcnMgaW4NCj4gICAgIHpzd2FwX2NwdV9jb21wX3ByZXBhcmUoKS4NCj4g
MikgU1dBUF9DUllQVE9fQkFUQ0hfU0laRSBzdGFjayB2YXJpYWJsZXMgZm9yIHBhZ2VzIGFuZCBk
bGVucyBpbg0KPiAgICAgenN3YXBfc3RvcmVfZm9saW8oKS4NCj4gDQo+IFRoaXMgd291bGQgYmUg
YW4gYWRkaXRpb25hbCBtZW1vcnkgcGVuYWx0eSBmb3Igd2hhdCB3ZSBnYWluIGJ5DQo+IGhhdmlu
ZyB0aGUgY29tbW9uIGNvZGUgcGF0aHMgaW4genN3YXAgZm9yIGNvbXByZXNzb3JzIHRoYXQgZG8N
Cj4gYW5kIGRvIG5vdCBzdXBwb3J0IGJhdGNoaW5nLg0KDQpBbHRlcm5hdGVseSwgd2UgY291bGQg
dXNlIHJlcXVlc3QgY2hhaW5pbmcgYWx3YXlzLCBldmVuIGZvciBzb2Z0d2FyZQ0KY29tcHJlc3Nv
cnMgZm9yIGEgbGFyZ2VyIG1lbW9yeSBwZW5hbHR5IHBlci1jcHUsIGJ5IGFsbG9jYXRpbmcNClNX
QVBfQ1JZUFRPX0JBVENIX1NJWkUgIyBvZiByZXFzL3dhaXRzIGJ5IGRlZmF1bHQuIEkgZG9uJ3Qg
a25vdw0KaWYgdGhpcyB3b3VsZCBoYXZlIGZ1bmN0aW9uYWwgaXNzdWVzIGJlY2F1c2UgdGhlIGNo
YWluIG9mIHJlcXVlc3RzDQp3aWxsIGJlIHByb2Nlc3NlZCBzZXF1ZW50aWFsbHkgKGJhc2ljYWxs
eSBhbGwgcmVxdWVzdHMgYXJlIGFkZGVkIHRvIGENCmxpc3QpLCBidXQgbWF5YmUgSGVyYmVydCBp
cyBzdWdnZXN0aW5nIHRoaXMgKG5vdCBzdXJlKS4NCg0KVGhhbmtzLA0KS2FuY2hhbmENCg0KPiAN
Cj4gVGhhbmtzLA0KPiBLYW5jaGFuYQ0KPiANCj4gPg0KPiA+IEl0IHNvdW5kcyBuaWNlIG9uIHRo
ZSBzdXJmYWNlLCBidXQgdGhpcyBpbXBsaWVzIHRoYXQgd2UgaGF2ZSB0bw0KPiA+IGFsbG9jYXRl
IGZvbGlvX25yX3BhZ2VzKCkgYnVmZmVycyBpbiB6c3dhcCwgZXNzZW50aWFsbHkgYXMgdGhlDQo+
ID4gYWxsb2NhdGlvbiBpcyB0aGUgc2FtZSBzaXplIGFzIHRoZSBmb2xpbyBpdHNlbGYuIFdoaWxl
IHRoZSBhbGxvY2F0aW9uDQo+ID4gZG9lcyBub3QgbmVlZCB0byBiZSBjb250aWd1b3VzLCBtYWtp
bmcgYSBsYXJnZSBudW1iZXIgb2YgYWxsb2NhdGlvbnMNCj4gPiBpbiB0aGUgcmVjbGFpbSBwYXRo
IGlzIGRlZmluaXRlbHkgbm90IHNvbWV0aGluZyB3ZSB3YW50LiBGb3IgYSAyTSBUSFAsDQo+ID4g
d2UnZCBuZWVkIHRvIGFsbG9jYXRlIDJNIGluIHpzd2FwX3N0b3JlKCkuDQo+ID4NCj4gPiBJZiB3
ZSBjaG9vc2UgdG8ga2VlcCBwcmVhbGxvY2F0aW5nLCBhc3N1bWluZyB0aGUgbWF4aW11bSBUSFAg
c2l6ZSBpcw0KPiA+IDJNLCB3ZSBuZWVkIHRvIGFsbG9jYXRlIDJNICogbnJfY3B1cyB3b3J0aCBv
ZiBidWZmZXJzLiBUaGF0J3MgYSBsb3Qgb2YNCj4gPiBtZW1vcnkuDQo+ID4NCj4gPiBJIGZlZWwg
bGlrZSBJIGFtIG1pc3Npbmcgc29tZXRoaW5nLg0KPiA+DQo+ID4gPg0KPiA+ID4gVGhhbmtzLA0K
PiA+ID4gS2FuY2hhbmENCj4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+IENoZWVycywNCj4gPiA+ID4g
LS0NCj4gPiA+ID4gRW1haWw6IEhlcmJlcnQgWHUgPGhlcmJlcnRAZ29uZG9yLmFwYW5hLm9yZy5h
dT4NCj4gPiA+ID4gSG9tZSBQYWdlOiBodHRwOi8vZ29uZG9yLmFwYW5hLm9yZy5hdS9+aGVyYmVy
dC8NCj4gPiA+ID4gUEdQIEtleTogaHR0cDovL2dvbmRvci5hcGFuYS5vcmcuYXUvfmhlcmJlcnQv
cHVia2V5LnR4dA0K

