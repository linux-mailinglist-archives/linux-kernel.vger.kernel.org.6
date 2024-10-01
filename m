Return-Path: <linux-kernel+bounces-346410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB0298C465
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 19:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD423285796
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82D21CBEB0;
	Tue,  1 Oct 2024 17:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bkfEbEcH"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C811CBEA6
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 17:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727803741; cv=fail; b=VYtJziUsL4c7UVaT6TX8bgz+vhNtYZQ974VR9mrNfIhefr+T4degTmXlj3XZTO8pv+XxOy5XGBtI94a8R4/V8U/kkrsx5mOr9PEaoLcmLwpyOmV4JiyyScwAKuoTaAqRDPnsAiXUjZW/RjAFe76Pc72ihVeW5UZNktxaE6jjnZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727803741; c=relaxed/simple;
	bh=s1ub2EDslrM9+8rcJ0UHwKSNvNwUEUbuB1D7Kj5fz0g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=goxXa5BVfGr9rH+pDyhIOIIG/0Kyx3dS8Fd2VBFSvAg6VNo+STiXJxFFYzrWGLCqUhoGyy6INjJggkNkazLb5JF48yMYXxyuxnEOsDd3/4QS36ZkFOeWYNIKE2jpViGopf59UCHg14GgQPQ5Timu2Jci/3RW3tqjqq0sjcXxW2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bkfEbEcH; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727803740; x=1759339740;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=s1ub2EDslrM9+8rcJ0UHwKSNvNwUEUbuB1D7Kj5fz0g=;
  b=bkfEbEcH2GvZGornZQNq3qoBGWwcXG8+tFhK8or269z0nWk4vdFBsHEu
   Hs1S2UezOLBX1sKrHROrWWx4/4E1Vzel4xSzN/T/EmItdCkmvWpc6+Skh
   S4CiTyHheecB9Fnrp5DUiC+JPrbtfKGrIM5FAnzEkumJgQJ5J3GN8NxIP
   qZLh3AOg2iiHUDUJ+nV4k5wF+D3Fu9t48wVI/bDp+RvI2lYek6tmxbKuV
   aQr8odcHgc8FvX1hMXaH/sV+S6GimK8Zwko4gReIFLsQia0XEqEvH8C2U
   ANXcYkK+ycOALT1NHDkkhaC7vyB+P5U5S8t6m3LNbxE56ct2BI6xfyx0T
   w==;
X-CSE-ConnectionGUID: 2ICQMymMSmCOtiymgA8CFQ==
X-CSE-MsgGUID: lVlw0fS/RfSrxIfMaeQStg==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="30660423"
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="30660423"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 10:28:59 -0700
X-CSE-ConnectionGUID: 5Oz2+Lq8Qomsv6rDp4RJQg==
X-CSE-MsgGUID: PCI1V8MlTtaVTv2j1F/HtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="78272296"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Oct 2024 10:28:58 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 1 Oct 2024 10:28:57 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 1 Oct 2024 10:28:57 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 1 Oct 2024 10:28:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MDznVy7P9mGVDLrB4ruNckIwd5C3BAWtGVInV2Eu0qyj1fevO7YM91xdpBJ/UihWmNm1MM2aLJOi51aX6eJuGaIhWimoPPHoDwofUX7ngvt/fmhPrI/CBZ39l7MR7MWnnrZzjuKAeDts1FRjRiAcKJmcowe3TWH1xYWOn9fo4L0cAxXPDMJ83kHV6otr46xiQk7EX481dWfoK4+QAnsOKGMoLXlLdyjZoLiUmgHhCGAO9+RriEjQiaOVKD9ULrLY/rx3WcdVLPDKZ8l/MunjdZ0Qm3IUlxJeYYtEPN/E2DrJL/eReOPUwtPX5C432bRt5qY7Aqu21elg2k0ZmY25sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s1ub2EDslrM9+8rcJ0UHwKSNvNwUEUbuB1D7Kj5fz0g=;
 b=AwUEnfKFp9OSejL2bZC3fKcO2JNISc/sRamq37ErZWLKMdI29xRMBhsmhC4Js4iT6o04h+zIqdSDrjzCoHXkLmIq/uNC8Iz09XaRTh7zWoZvYK2JZwoPMfEQmHEnBxtVNt9/B56nUyhN4yAcJaJ4wevdV6EXtL5zePv/ERelzwdD0L6C4MQPehELo2+GPMWoeFsrkBAaJO0HCL0YiBzsEWYUaMb4A1YqJH1yeSkXgwu6uONdmgW4GrAmFcjQSVU+i8pMruCXbxy9RiNvwpwSYpe4xyIsqWPzhyOqFWjk9wbamFcZuekImRnfJBB1LunZulPysjOzK5e7gaVg90SO2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by SA1PR11MB8425.namprd11.prod.outlook.com (2603:10b6:806:385::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 17:28:55 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 17:28:55 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Yosry Ahmed <yosryahmed@google.com>
CC: Johannes Weiner <hannes@cmpxchg.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"nphamcs@gmail.com" <nphamcs@gmail.com>, "chengming.zhou@linux.dev"
	<chengming.zhou@linux.dev>, "usamaarif642@gmail.com"
	<usamaarif642@gmail.com>, "shakeel.butt@linux.dev" <shakeel.butt@linux.dev>,
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, "Huang, Ying"
	<ying.huang@intel.com>, "21cnbao@gmail.com" <21cnbao@gmail.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"willy@infradead.org" <willy@infradead.org>, "Zou, Nanhai"
	<nanhai.zou@intel.com>, "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>,
	"Gopal, Vinodh" <vinodh.gopal@intel.com>, "Sridhar, Kanchana P"
	<kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v10 6/7] mm: zswap: Support large folios in zswap_store().
Thread-Topic: [PATCH v10 6/7] mm: zswap: Support large folios in
 zswap_store().
Thread-Index: AQHbE8NS/mzK7ddAdUGteugGSqw7kLJxvZiAgABhSHCAAAFcAIAABc2g
Date: Tue, 1 Oct 2024 17:28:55 +0000
Message-ID: <SJ0PR11MB56788B684E26453CE1AD03CEC9772@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20241001053222.6944-1-kanchana.p.sridhar@intel.com>
 <20241001053222.6944-7-kanchana.p.sridhar@intel.com>
 <20241001111045.GA1003400@cmpxchg.org>
 <SJ0PR11MB56786570AA6C6C8EE7FFC0BDC9772@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkYtfHyRgxqb_gGVLfWBHdwzmkD+SRHnBbSdv-59eWLPqA@mail.gmail.com>
In-Reply-To: <CAJD7tkYtfHyRgxqb_gGVLfWBHdwzmkD+SRHnBbSdv-59eWLPqA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|SA1PR11MB8425:EE_
x-ms-office365-filtering-correlation-id: 2d226f7e-5253-4796-f8f5-08dce23e8679
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Ni94NXlLN0QzbS8rVllWVHBtNXRMZ3ZaWUxOOTJra1YrQ3FNeWhTaGFXSHZK?=
 =?utf-8?B?Qzg3TEEvb2IzNUsyNE1WWHpDdFUrYU9iZ0tiaXpWdXVEamhUeEkxQ0piVVUr?=
 =?utf-8?B?SENkaHM2aGVXTjFFTS9qQVNuUXMyV045b1JDUVFpMzEyOXdTMXd4c3pkMnlD?=
 =?utf-8?B?SkdFd2ZKY1luVGUxZTBoQnZHOEE1UmtqMm1KYWZEakNiakw1WTdNTTc0K3h0?=
 =?utf-8?B?aHRrSldTKzR5SW1oUmNoOWlnMHEzZGFOQTJXZVFBTmxUY0JObFlTL1F2TS9E?=
 =?utf-8?B?RXNNS1hCSnJ5TXFUWDRmTkFMZUJTTkNMdEpoZFNCV0ZNc1ZIUnVRd2NHUFdK?=
 =?utf-8?B?UHlyOU5qR25ORXUxTHhsSklMSGFIRUlqNURCamNCMWM1UGxtc3EwZUZDcHN2?=
 =?utf-8?B?STE3bEtEbjB0NHVGbENCbnlGcUtlak1hRXppUURDYWxiVHNIeGdaczBtdXJH?=
 =?utf-8?B?MlhEanhMZUQ1bDZoaUo0MTRtekZhT2N0MnN6b1FsYjkvM0NoaXdiK3JldUhv?=
 =?utf-8?B?TE1EcmY1N2cxY2NPT1FKb1NLL2U3WTVYejRGVGtmeVgwbmp3NWEvUUZreDRZ?=
 =?utf-8?B?cEcrcmtJZnV5SEdjYW1RSUVUdlNucDh0THVLMjhmN1NzclZRYkhocTlFM1Q2?=
 =?utf-8?B?dFhUaG9ENDZ3ekcvd3A2N0xUSlFGMEx0QmdRZzZkZ3F2ZGNFY1RZQ3FzR0NQ?=
 =?utf-8?B?Rmttd0IxSGM1VWZuU3p2NkVWOFRqQXhSeWhvK1dETjlqeDZiZEgrc2gyaXlP?=
 =?utf-8?B?a1VkaytidEpjYlk2UUdlM21CR2J6MnJ1V0RVOVBwZTVsZUVUNG56eWJkZldO?=
 =?utf-8?B?YThLUCtrOE1kbVBhK3ZzaTNKSUFLbFhVeHpod1FlMmhzcXAwOXNLSklxM1cz?=
 =?utf-8?B?bUNlMTZ3dmNXTmpaVCtjT1JDbGdWSDNnK0VpeVJhZmZHMW1OZFNmVG1jMlpH?=
 =?utf-8?B?SFprT2ExRlo5aks0YU1KWVdHUmRUS2ZHZE10Y1NKMlVZUlNnaEF3YVRsTGZj?=
 =?utf-8?B?RWJQaDVqZWo1Z0xwRWRvaWhBNDdoZzh2TXl6UlYrZWdoUG1NWkFOZDhnbnpS?=
 =?utf-8?B?U2ROOGpBRnVMSFJodEhReEhsdWcyRXA0clRObGJqc1hjOVNZaTNCUVhXNlkv?=
 =?utf-8?B?VWtVRStVaFFMUlJUWWdaeFNNZXVEcU43QWtoVW0wa0Y2T0syYTJDL2tkUVNY?=
 =?utf-8?B?WlNqR2dEcUM4bzlQemxvanFaVWE2OVF6REVaNisxUERHc1ZQaW1uOHNGWG9r?=
 =?utf-8?B?TVlrMXpYdHdtcG5YNVVGWGx0ZEJWK1A4OTNlR3V5dEZ6Zmw5M0ZZM0QrKzlx?=
 =?utf-8?B?VHJEeW81Mk90TERwUHNFbFptTGl2SFEwVWU3NVRYazZZUDAvejloNGQvcDRl?=
 =?utf-8?B?SU9lRGlhQUpNczRjTWtaQlVlTUhzZnNtMDRxa1JnL0QrSUtjbDJYN2hwc2Rr?=
 =?utf-8?B?UXQ0b2dkUURtcWRkQ3pIVjRlN01URGZXanhiN3dCck9laDZCYXFEb1ppK3g5?=
 =?utf-8?B?d3dZbythZThSU1pqQ0tLWTFZZDFXbmd5S05Gcm5icFdXanRlZWpJbTR5R29p?=
 =?utf-8?B?ekxOZjVrWnVzaUtoejF2TWsvbFppWFhBNVNLMVRxZWk5UmtNVTZib0I3Wjlt?=
 =?utf-8?B?OXpHNFpmK29oMFozZzVBbUtVUzFyQ3B3YTA1cndOTi9uWUp4YTN6Rk5GOEN4?=
 =?utf-8?B?RUlNSWovT2JCNXM5TnR6NFM2NWlHTU9Vd0ovYmx5WDVwZ1V4ckZBeGM5d2Vt?=
 =?utf-8?B?MU5tQW1IMmI1aloyQkJrdzZCT3VYOEo1dVVaaDU1Smxpck1DcjdyS2UwS1BM?=
 =?utf-8?Q?/6XOZNSEfuBIZSAOKWMMiDA4386Gb6+6alM0c=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWxkTzl2K29vTThtcU5jZTlRK1pPYkZWa2g4YUtvZndxa0RjVFduUVVCV3M1?=
 =?utf-8?B?TFJSTk4ydlltdXNlVFNuNFZPWlZNVy9qanZRSlA3MnhpWjFrQURNWDdoNWxt?=
 =?utf-8?B?UmF6NkFLQUM1SjFad0J4UGNvWllpc01HeHdXMVVPS3hnZ1hvOFJqTVdaeG1i?=
 =?utf-8?B?a2I0RTdHekU3cGFnWUFNamptT1JXMmw4NEwzeFhXWFB0U0xnNjF5RWhBRjc1?=
 =?utf-8?B?d1AxeENKbnI0K0R2TFZ2bW4xcUo2WVJhcmt4VnNhRFRVYzdqVTk3ZnF6RHgv?=
 =?utf-8?B?STk4RzEyR1l5V1lISkg2cHFCckxZakZRTWFlaE9DY25RUXZ4N0lJTVJBSUht?=
 =?utf-8?B?OFY4LzZLZTU5TXg2NGlDcFVNY1pwaU1qTkZvNnNEbkNTZ0NydGZUS3ZiYmk3?=
 =?utf-8?B?a2ROMS9yNEJhZ0NqTVd2Y2Z6Q0N4dG8zQ2pFNi9WV2MxdURyQUFHTmwxaUhS?=
 =?utf-8?B?Z3Z0ME1tOVV1SVVFVFJUd0JvT0tsMS9mdEc2N24rbUhVc1NOZW1xZGpIYUQy?=
 =?utf-8?B?WVV1U3NSTTJTM21QVlVsMEdxeE54NVhKN1pZNG1kcUE4WExQSnNhc1gvUDlM?=
 =?utf-8?B?TVF4YlVqTEtWZG9vR1ZOU1JsVzl1MWc1Y0VVWWpKNHV2NytxaDBUOENjQ24y?=
 =?utf-8?B?SE1KNU1KOXpKZjYyT2VaSlM2QzNsaXI1MERtQkJ0dGt1Q3JRM25TY3JtdlUy?=
 =?utf-8?B?SU05Qy9NazJlNTFkT2lmSk1SbTN3WTA3N2pmZVkxOTV2R2pnU282ZnMvSWkz?=
 =?utf-8?B?VEpmT056aEsveCtsclA2QW5pYW5rYmxIK05GWEJyUkpKZVIxUmhUNGdiWXI4?=
 =?utf-8?B?MjRpRXdvRldnSDVrUlQ2cGpoM3huVjFlTlE4Tjh3cUJFM2I0aEthRG16RTEr?=
 =?utf-8?B?eFdsSU1NcU1YZGRvNzNROU1RNzNwcjB0R0UxdnVWRWtaZjRKUzNEdXk5Unhp?=
 =?utf-8?B?aGp3NHphRWhnMy9UTnJQelFNTmt1b1k2Uis1OWhQNWlYRkJoYk9NSTk5K21H?=
 =?utf-8?B?VC9xZU8xaUpMRDhpTTN6SnNqaFRnOUNlc2FmL1lRd2xrT0tsdHR5aHhVd1VP?=
 =?utf-8?B?VGlJTVYxaUZaSXhIZ0U3R29aMTEzYVY5SXdtTnBDaTY2M1VNZXVsTkJWZDVU?=
 =?utf-8?B?YW1oUU1RWUlCbzBuZFBqTXNiSGVtTFU0WUs4RHRBeU81a3ZhYWZBbUJ5SXlq?=
 =?utf-8?B?OWpRTXQxZ1VReTFyNkFHdEZrSHZOTTVaS0J2QUt5c1NDd3hTSUtkUWpIa3dj?=
 =?utf-8?B?clA5TmdCT3pYd1BOQXdiMUVKY09ISUx1cmJadUdUaUdiaUo4ZDU2cG5XVHNY?=
 =?utf-8?B?M1ZIS0lock1iSjlIL1VEU3QxSzdlemdlV3lYWGZPWGRJU0N4LytlWlhxOU4y?=
 =?utf-8?B?WDU0VzBnKzRvb2xqMEFZM1hnWFk2KzBpRDFTSTdrQjBubnd3UHM4S1dhaXlE?=
 =?utf-8?B?L3BFMU4yTm9mTWlaNTBMYmZqQkhTdWhoRXF4S3pHVzRoOVpTRlRsTFRPSDRq?=
 =?utf-8?B?Ymg0SmlxWW5LZlBEZ1BGVWxRV1FNaEg2NzNNRFNubHM5RzJUVEcrWW4zWVAw?=
 =?utf-8?B?TDRZQmE4NEFUcFlLSGJmRWFtdUU3WEFmVnAxZGdkeStpTFZUTVJmTkJzNlEy?=
 =?utf-8?B?Y0xoQW4zeEgzTTlxNVIyU0c0ZmIwVWlsWHc1UTJzeHltK3hWZWNsRnU1K0pJ?=
 =?utf-8?B?RUg2UGFtZHJNMmU1SmI5Qm5vcnU3a05yc1YrZm1SY1RZWWRidjEycENOa29r?=
 =?utf-8?B?MG5rRUt5WVhRVEZWWUFCMXZydzdBdVhvMFY5cWpDN0M3N1VKcFNHanVKdVE2?=
 =?utf-8?B?YXFWR2U0ZVlMbmZ6MDIvd0pYQlo1dXh1MER3S0dNZWNGUXM3eHJLd3BWNEVx?=
 =?utf-8?B?c2FPa2V4VjZOT1NwZlZwUTZIdnlhWWlocmZxLzZma05oTGFVNGl2RFRjRlhK?=
 =?utf-8?B?OGZBdktEV2FFQ0U3eXhvNmd1bXptREhKRExaUjBwUFZLNXExMUZxakNsT0Q0?=
 =?utf-8?B?dlRwRzBIV3lTbTVBajJGQkYrYjlGcFlFbXBjS0NMdC95Y2ZuOEltQ0FPL1g5?=
 =?utf-8?B?TlR4OWZaMitUQk1ROU9oSnA4OGZXeHh1R091dDFYTnNjd2JZNE0yUkFobmhF?=
 =?utf-8?B?cTdqSFFvRGdNYjR5eTB2eURGYmRzSGR0blJVRFhZWDhXQXpBYXF6T3FMKzRN?=
 =?utf-8?B?d2c9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d226f7e-5253-4796-f8f5-08dce23e8679
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2024 17:28:55.1548
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OiX5iNht664+ZxXHqTeEQsHu5j5xQ7yL975F0m64clmLNlYiP1vgNF4Mngkc97L5/RyvZLAPgsOmmHLHx3JdbDVLuINmHfxJFrWr4tD3joo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8425
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBZb3NyeSBBaG1lZCA8eW9zcnlh
aG1lZEBnb29nbGUuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBPY3RvYmVyIDEsIDIwMjQgMTA6MDQg
QU0NCj4gVG86IFNyaWRoYXIsIEthbmNoYW5hIFAgPGthbmNoYW5hLnAuc3JpZGhhckBpbnRlbC5j
b20+DQo+IENjOiBKb2hhbm5lcyBXZWluZXIgPGhhbm5lc0BjbXB4Y2hnLm9yZz47IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LW1tQGt2YWNrLm9yZzsgbnBoYW1jc0BnbWFp
bC5jb207IGNoZW5nbWluZy56aG91QGxpbnV4LmRldjsNCj4gdXNhbWFhcmlmNjQyQGdtYWlsLmNv
bTsgc2hha2VlbC5idXR0QGxpbnV4LmRldjsgcnlhbi5yb2JlcnRzQGFybS5jb207DQo+IEh1YW5n
LCBZaW5nIDx5aW5nLmh1YW5nQGludGVsLmNvbT47IDIxY25iYW9AZ21haWwuY29tOyBha3BtQGxp
bnV4LQ0KPiBmb3VuZGF0aW9uLm9yZzsgd2lsbHlAaW5mcmFkZWFkLm9yZzsgWm91LCBOYW5oYWkg
PG5hbmhhaS56b3VAaW50ZWwuY29tPjsNCj4gRmVnaGFsaSwgV2FqZGkgSyA8d2FqZGkuay5mZWdo
YWxpQGludGVsLmNvbT47IEdvcGFsLCBWaW5vZGgNCj4gPHZpbm9kaC5nb3BhbEBpbnRlbC5jb20+
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEwIDYvN10gbW06IHpzd2FwOiBTdXBwb3J0IGxhcmdl
IGZvbGlvcyBpbg0KPiB6c3dhcF9zdG9yZSgpLg0KPiANCj4gT24gVHVlLCBPY3QgMSwgMjAyNCBh
dCAxMDowMeKAr0FNIFNyaWRoYXIsIEthbmNoYW5hIFANCj4gPGthbmNoYW5hLnAuc3JpZGhhckBp
bnRlbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiA+ID4gRnJvbTogSm9oYW5uZXMgV2VpbmVyIDxoYW5uZXNAY21weGNoZy5vcmc+DQo+ID4gPiBT
ZW50OiBUdWVzZGF5LCBPY3RvYmVyIDEsIDIwMjQgNDoxMSBBTQ0KPiA+ID4gVG86IFNyaWRoYXIs
IEthbmNoYW5hIFAgPGthbmNoYW5hLnAuc3JpZGhhckBpbnRlbC5jb20+DQo+ID4gPiBDYzogbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtbW1Aa3ZhY2sub3JnOw0KPiA+ID4geW9z
cnlhaG1lZEBnb29nbGUuY29tOyBucGhhbWNzQGdtYWlsLmNvbTsNCj4gPiA+IGNoZW5nbWluZy56
aG91QGxpbnV4LmRldjsgdXNhbWFhcmlmNjQyQGdtYWlsLmNvbTsNCj4gPiA+IHNoYWtlZWwuYnV0
dEBsaW51eC5kZXY7IHJ5YW4ucm9iZXJ0c0Bhcm0uY29tOyBIdWFuZywgWWluZw0KPiA+ID4gPHlp
bmcuaHVhbmdAaW50ZWwuY29tPjsgMjFjbmJhb0BnbWFpbC5jb207IGFrcG1AbGludXgtDQo+IGZv
dW5kYXRpb24ub3JnOw0KPiA+ID4gd2lsbHlAaW5mcmFkZWFkLm9yZzsgWm91LCBOYW5oYWkgPG5h
bmhhaS56b3VAaW50ZWwuY29tPjsgRmVnaGFsaSwgV2FqZGkNCj4gSw0KPiA+ID4gPHdhamRpLmsu
ZmVnaGFsaUBpbnRlbC5jb20+OyBHb3BhbCwgVmlub2RoIDx2aW5vZGguZ29wYWxAaW50ZWwuY29t
Pg0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2MTAgNi83XSBtbTogenN3YXA6IFN1cHBvcnQg
bGFyZ2UgZm9saW9zIGluDQo+ID4gPiB6c3dhcF9zdG9yZSgpLg0KPiA+ID4NCj4gPiA+IE9uIE1v
biwgU2VwIDMwLCAyMDI0IGF0IDEwOjMyOjIxUE0gLTA3MDAsIEthbmNoYW5hIFAgU3JpZGhhciB3
cm90ZToNCj4gPiA+ID4genN3YXBfc3RvcmUoKSB3aWxsIHN0b3JlIGxhcmdlIGZvbGlvcyBieSBj
b21wcmVzc2luZyB0aGVtIHBhZ2UgYnkgcGFnZS4NCj4gPiA+ID4NCj4gPiA+ID4gVGhpcyBwYXRj
aCBwcm92aWRlcyBhIHNlcXVlbnRpYWwgaW1wbGVtZW50YXRpb24gb2Ygc3RvcmluZyBhIGxhcmdl
IGZvbGlvDQo+ID4gPiA+IGluIHpzd2FwX3N0b3JlKCkgYnkgaXRlcmF0aW5nIHRocm91Z2ggZWFj
aCBwYWdlIGluIHRoZSBmb2xpbyB0byBjb21wcmVzcw0KPiA+ID4gPiBhbmQgc3RvcmUgaXQgaW4g
dGhlIHpzd2FwIHpwb29sLg0KPiA+ID4gPg0KPiA+ID4gPiB6c3dhcF9zdG9yZSgpIGNhbGxzIHRo
ZSBuZXdseSBhZGRlZCB6c3dhcF9zdG9yZV9wYWdlKCkgZnVuY3Rpb24gZm9yDQo+IGVhY2gNCj4g
PiA+ID4gcGFnZSBpbiB0aGUgZm9saW8uIHpzd2FwX3N0b3JlX3BhZ2UoKSBoYW5kbGVzIGNvbXBy
ZXNzaW5nIGFuZCBzdG9yaW5nDQo+IGVhY2gNCj4gPiA+ID4gcGFnZS4NCj4gPiA+ID4NCj4gPiA+
ID4gV2UgY2hlY2sgdGhlIGdsb2JhbCBhbmQgcGVyLWNncm91cCBsaW1pdHMgb25jZSBhdCB0aGUg
YmVnaW5uaW5nIG9mDQo+ID4gPiA+IHpzd2FwX3N0b3JlKCksIGFuZCBvbmx5IGNoZWNrIHRoYXQg
dGhlIGxpbWl0IGlzIG5vdCByZWFjaGVkIHlldC4gVGhpcyBpcw0KPiA+ID4gPiByYWN5IGFuZCBp
bmFjY3VyYXRlLCBidXQgaXQgc2hvdWxkIGJlIHN1ZmZpY2llbnQgZm9yIG5vdy4gV2UgYWxzbyBv
YnRhaW4NCj4gPiA+ID4gaW5pdGlhbCByZWZlcmVuY2VzIHRvIHRoZSByZWxldmFudCBvYmpjZyBh
bmQgcG9vbCB0byBndWFyYW50ZWUgdGhhdA0KPiA+ID4gPiBzdWJzZXF1ZW50IHJlZmVyZW5jZXMg
Y2FuIGJlIGFjcXVpcmVkIGJ5IHpzd2FwX3N0b3JlX3BhZ2UoKS4gQSBuZXcNCj4gPiA+IGZ1bmN0
aW9uDQo+ID4gPiA+IHpzd2FwX3Bvb2xfZ2V0KCkgaXMgYWRkZWQgdG8gZmFjaWxpdGF0ZSB0aGlz
Lg0KPiA+ID4gPg0KPiA+ID4gPiBJZiB0aGVzZSBvbmUtdGltZSBjaGVja3MgcGFzcywgd2UgY29t
cHJlc3MgdGhlIHBhZ2VzIG9mIHRoZSBmb2xpbywgd2hpbGUNCj4gPiA+ID4gbWFpbnRhaW5pbmcg
YSBydW5uaW5nIGNvdW50IG9mIGNvbXByZXNzZWQgYnl0ZXMgZm9yIGFsbCB0aGUgZm9saW8ncyBw
YWdlcy4NCj4gPiA+ID4gSWYgYWxsIHBhZ2VzIGFyZSBzdWNjZXNzZnVsbHkgY29tcHJlc3NlZCBh
bmQgc3RvcmVkLCB3ZSBkbyB0aGUgY2dyb3VwDQo+ID4gPiA+IHpzd2FwIGNoYXJnaW5nIHdpdGgg
dGhlIHRvdGFsIGNvbXByZXNzZWQgYnl0ZXMsIGFuZCBiYXRjaCB1cGRhdGUgdGhlDQo+ID4gPiA+
IHpzd2FwX3N0b3JlZF9wYWdlcyBhdG9taWMvenN3cG91dCBldmVudCBzdGF0cyB3aXRoIGZvbGlv
X25yX3BhZ2VzKCkNCj4gPiA+IG9uY2UsDQo+ID4gPiA+IGJlZm9yZSByZXR1cm5pbmcgZnJvbSB6
c3dhcF9zdG9yZSgpLg0KPiA+ID4gPg0KPiA+ID4gPiBJZiBhbiBlcnJvciBpcyBlbmNvdW50ZXJl
ZCBkdXJpbmcgdGhlIHN0b3JlIG9mIGFueSBwYWdlIGluIHRoZSBmb2xpbywNCj4gPiA+ID4gYWxs
IHBhZ2VzIGluIHRoYXQgZm9saW8gY3VycmVudGx5IHN0b3JlZCBpbiB6c3dhcCB3aWxsIGJlIGlu
dmFsaWRhdGVkLg0KPiA+ID4gPiBUaHVzLCBhIGZvbGlvIGlzIGVpdGhlciBlbnRpcmVseSBzdG9y
ZWQgaW4genN3YXAsIG9yIGVudGlyZWx5IG5vdCBzdG9yZWQNCj4gPiA+ID4gaW4genN3YXAuDQo+
ID4gPiA+DQo+ID4gPiA+IFRoZSBtb3N0IGltcG9ydGFudCB2YWx1ZSBwcm92aWRlZCBieSB0aGlz
IHBhdGNoIGlzIGl0IGVuYWJsZXMgc3dhcHBpbmcNCj4gb3V0DQo+ID4gPiA+IGxhcmdlIGZvbGlv
cyB0byB6c3dhcCB3aXRob3V0IHNwbGl0dGluZyB0aGVtLiBGdXJ0aGVybW9yZSwgaXQgYmF0Y2hl
cw0KPiBzb21lDQo+ID4gPiA+IG9wZXJhdGlvbnMgd2hpbGUgZG9pbmcgc28gKGNncm91cCBjaGFy
Z2luZywgc3RhdHMgdXBkYXRlcykuDQo+ID4gPiA+DQo+ID4gPiA+IFRoaXMgcGF0Y2ggYWxzbyBm
b3JtcyB0aGUgYmFzaXMgZm9yIGJ1aWxkaW5nIGNvbXByZXNzIGJhdGNoaW5nIG9mIHBhZ2VzIGlu
DQo+ID4gPiA+IGEgbGFyZ2UgZm9saW8gaW4genN3YXBfc3RvcmUoKSBieSBjb21wcmVzc2luZyB1
cCB0byBzYXksIDggcGFnZXMgb2YgdGhlDQo+ID4gPiA+IGZvbGlvIGluIHBhcmFsbGVsIGluIGhh
cmR3YXJlIHVzaW5nIHRoZSBJbnRlbCBJbi1NZW1vcnkgQW5hbHl0aWNzDQo+ID4gPiA+IEFjY2Vs
ZXJhdG9yIChJbnRlbCBJQUEpLg0KPiA+ID4gPg0KPiA+ID4gPiBUaGlzIGNoYW5nZSByZXVzZXMg
YW5kIGFkYXB0cyB0aGUgZnVuY3Rpb25hbGl0eSBpbiBSeWFuIFJvYmVydHMnIFJGQw0KPiA+ID4g
PiBwYXRjaCBbMV06DQo+ID4gPiA+DQo+ID4gPiA+ICAgIltSRkMsdjFdIG1tOiB6c3dhcDogU3Rv
cmUgbGFyZ2UgZm9saW9zIHdpdGhvdXQgc3BsaXR0aW5nIg0KPiA+ID4gPg0KPiA+ID4gPiAgIFsx
XSBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1tbS8yMDIzMTAxOTExMDU0My4zMjg0NjU0
LTEtDQo+ID4gPiByeWFuLnJvYmVydHNAYXJtLmNvbS9ULyN1DQo+ID4gPiA+DQo+ID4gPiA+IENv
LWRldmVsb3BlZC1ieTogUnlhbiBSb2JlcnRzDQo+ID4gPg0KPiA+ID4gSSB3b3VsZCBjaGFuZ2Ug
dGhhdCB0bw0KPiA+ID4NCj4gPiA+IE9yaWdpbmFsbHktYnk6IFJ5YW4gUm9iZXJ0cyA8cnlhbi5y
b2JlcnRzQGFybS5jb20+DQo+ID4gPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5Og0KPiA+ID4NCj4g
PiA+IGFuZCBkcm9wIHRoaXMgZm9yIG5vdy4NCj4gPg0KPiA+IFRoYW5rcyBKb2hhbm5lcy4gU3Vy
ZSwgdGhpcyBzb3VuZHMgZ29vZC4gU2hvdWxkIEkgcG9zdCBhIHYxMSBmb3IganVzdCB0aGlzDQo+
ID4gc3BlY2lmaWMgcGF0Y2ggd2hpY2ggdGhpcyBjaGFuZ2UsIG9yIGEgdjExIGZvciB0aGUgZW50
aXJlIHNlcmllcz8NCj4gDQo+IEFuZHJldyBjb3VsZCBwcm9iYWJseSBtYWtlIHRoZSBjaGFuZ2Ug
Zm9yIHlvdSB3aGlsZSBhcHBseWluZyB0aGUNCj4gcGF0Y2hlcyB0byBtbS11bnN0YWJsZSBpZiB5
b3UgYXNrIG5pY2VseSA6KQ0KPiANCj4gQWxzbyBzaW5jZSB3ZSBhZ3JlZWQgZnVydGhlciBjbGVh
bnVwIGNhbiBiZSBkb25lIGFzIGEgZm9sbG93dXA6DQo+IEFja2VkLWJ5OiBZb3NyeSBBaG1lZCA8
eW9zcnlhaG1lZEBnb29nbGUuY29tPg0KDQpUaGFua3MgWW9zcnkhDQoNCg==

