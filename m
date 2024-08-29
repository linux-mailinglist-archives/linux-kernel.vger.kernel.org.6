Return-Path: <linux-kernel+bounces-305939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A1A9636AB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 02:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0794286396
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 00:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB6C4C79;
	Thu, 29 Aug 2024 00:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XZpheKi5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B819139E
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 00:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724890059; cv=fail; b=FJE1up4F9d4XjTaqh1MFajYxKWDzvN2ZdyyxlPMHpx5tv8BL0g1lB4encIC2hprzF+OTD9yiMn5/qTLvBuL9Vf4x5QXvJJnsNKFsGxyyuYipkuRP9JfVhLe+9qVOKpaYoXVVogkJHqoS4pK9v1eRbxpJewaIQSrQF7cc9CmhUvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724890059; c=relaxed/simple;
	bh=PuoOHobEQbSPCor4QR/iNcAFC2/meKRPTkBT91o2shs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ugFJTO9NnuekJAPDuHqw2DiI8WaUuomZk4dQ71GGqyH595GEXOXds0dUAePS1z2q1j17NHMFqWSx3mwocdMcbjsJVzXxjrZ63khzwKvBj3Th2VFZ1W3r8DshauOgqFQC3F6KKJORYnRJzDAeSxLB4HSuhlRTUq7kYSVzzsUgjTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XZpheKi5; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724890058; x=1756426058;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PuoOHobEQbSPCor4QR/iNcAFC2/meKRPTkBT91o2shs=;
  b=XZpheKi5xorOwTyKOr4HwqW8ZXZpimxEOBWlf6fl4L6vU8bY/w1WOFzj
   o/F0VQOcIrzKP9l1+KRrr+fQQraPwLZ35Wz7rdUbDbQotiJ2/WycbFOol
   cHpD4a58S9F+keVCdikXbllT+Y0nPCoIVQBJIqK2gIja4A7UR+gSnSpoM
   R3a9fAAoqu9ErY4IJF9z8jC3nuggzl6BG04VIhyfLDDvVjZjJf5O+qJIJ
   lVaVqg11LMxUqhvVuQ9Eb6RjJFJlQIhnmdpJLZt3YaVpqUrz0oz1LtqTc
   wXRCk+4LM7C5z0gpX0bNscw9XQp0JnEWhNpDuqTKDnkoal6JZMxhTBnmI
   Q==;
X-CSE-ConnectionGUID: sI9AtSVDQea9SbbzzCP7pQ==
X-CSE-MsgGUID: 40DznxsgSC+q7HmPQM8+/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="23031241"
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="23031241"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 17:06:42 -0700
X-CSE-ConnectionGUID: dXQ5/Y9QSjeEIiFotTw/sQ==
X-CSE-MsgGUID: 9M9Hx2NbQhmAg3LLFYwT1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="63225871"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Aug 2024 17:06:42 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 28 Aug 2024 17:06:41 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 28 Aug 2024 17:06:41 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 28 Aug 2024 17:06:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MS+LdIeaolewVKxUwvdP8kvwolLHnYQEhhE48sR+A5lrOXkRCJAlZHjaNj9sYOjg1hmVFvni5aKPc4FzHRLShbNoFKGOPE+F3RUOg9l5L6fRDBaDxC6eflwcOI5xYXMmT7u5dAUYfxcTDrG/wvA/L/BnzyphrV/3cmprw1ML2HO30fIzYTuZI3P499tGwIqZa1y1grWHlDp96Ipolpg+EnOMU36yBfQg6R3mr2wWd/XHuByqY1siOOg4pW6wyCNelSI6nRJpA2ujCzeF2ZfPQjK3Ok/uOS7Db4I5EWfy6WVSIlUXORUEsxHRKV2daUZaqctyWCUYw5gsp1eJ7NitqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PuoOHobEQbSPCor4QR/iNcAFC2/meKRPTkBT91o2shs=;
 b=wQdgmxMZSwFx2MjUms+91KJGmhlhxkyK8acUeD+O5L+9xtmeBc7vCdAaiKS8AfR10qxD+90Kb/29dOhc7DNL/G5ByRZHVk/XFlPNhSTb4oSt5jcShY/33gmUZSqCFmngH+HxzNjiFM/MoTx04JKumtf8L31XRbZ5yH/yMRYBj6hQ8KJVxvsY/mCGU8BBZBSvXIrC3fRYwEq5dB8ye95xQJ73bImc4KsEHhUbuk0jxS2M4yvEC1lBBeMPkJe0EBe7JTZCuhzrWLyYLw6/54aH4QjJBzusO1lN900JFVfqCmtls37KmUTo+6gKGLLAFgDeQevYEgCWl5VVSsK8zeAPOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by IA1PR11MB7942.namprd11.prod.outlook.com (2603:10b6:208:3fa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Thu, 29 Aug
 2024 00:06:38 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%5]) with mapi id 15.20.7875.019; Thu, 29 Aug 2024
 00:06:38 +0000
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
Subject: RE: [PATCH v5 0/3] mm: ZSWAP swap-out of mTHP folios
Thread-Topic: [PATCH v5 0/3] mm: ZSWAP swap-out of mTHP folios
Thread-Index: AQHa+S2hY1M67nGQo0+E71Bgb79m17I9MgEAgAAYkEA=
Date: Thu, 29 Aug 2024 00:06:38 +0000
Message-ID: <SJ0PR11MB5678412EE36C10CC0D69D036C9962@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20240828093516.30228-1-kanchana.p.sridhar@intel.com>
 <CAKEwX=Pqm3pjOO-ErOTGnNYKwMas4fdiN0bdUcrPHzfKf-Qryw@mail.gmail.com>
In-Reply-To: <CAKEwX=Pqm3pjOO-ErOTGnNYKwMas4fdiN0bdUcrPHzfKf-Qryw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|IA1PR11MB7942:EE_
x-ms-office365-filtering-correlation-id: 50c83143-3f41-4197-8c53-08dcc7be7407
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UlVYZS96YkpYVXVNWHB1cGJpVkY3WVlDYTZuZWw0QXljWnNTbUtHTGZNTFY3?=
 =?utf-8?B?Q2xobitVU2h5VHBFV2RyUC93MXhaSjlxNWZUSElPbTRrZlc3Z3JOa25LUGwx?=
 =?utf-8?B?Z2RHblJzQkRXVitrZDdMS0VQS1VKN2xlQWVnTHYvSS9ETTRpdTVmNjJLeXVF?=
 =?utf-8?B?bTdKcmxWWVA3d01IdmN0cjdGU05LTEVDbTM0MXpEcUFsWnNreFJtd2xuV054?=
 =?utf-8?B?M1lPMFhZRWVkR04wTE1wd3dETk5JVStYOVFUcVBXRktHeWxGZnFjVmYvREFK?=
 =?utf-8?B?ZHpTNStWc0dUM2ZKUjBVSm9NaTdEOHovZXJzMllzaDVYODZlWnZtWkR5V3B0?=
 =?utf-8?B?cG9HLzZtZ2h3VjNFd1haOGhRZW8xU1NGNHo2Q1hXMExWOTRCMUpFbklYamxY?=
 =?utf-8?B?VDF6N3czV0txeHc4ZDhpTkNzUXFDWTdnQ2VZUUpBR0JsRzNOY0tJa3ZTYUlM?=
 =?utf-8?B?VWpkMm1BOHZwQ2pwOFNSZ0theWpDT3BJLy9VWmZ1a3ViUFg1UUxRYkJUcUpY?=
 =?utf-8?B?c09VWEcxdkxla2ZKdlphdWFvQVJCazA4RXFUR0kxL2pQMS9Ia2grVmFvMVdu?=
 =?utf-8?B?elo4Vk4vTWtIbkczZ0VHYVdML3JWWENtVGF6S2xlRngybjIzRFlhODVUN3pB?=
 =?utf-8?B?LzY3cG5vNUMzSWNLS2E3cnEyUk5zbzFyZzViT3BPVDMrVkhUeVRlSURiV0E0?=
 =?utf-8?B?ekJZYlM5MVNoaGNSa0oxOU9kV1ZMT0NKaWhmdWZmc25sSFlTMU5iSXRjWUZz?=
 =?utf-8?B?WHE0S0pnLzdBRzc5M250ZXpnWjJ6T0RObTBBUTluV3J4eHNyVXFUMFJzVU9z?=
 =?utf-8?B?TGN4bmQwSFFJcEYzck95dVd3YVFxYnQwVjJIbXRIUkduZVNMQjFtOTRDTWJq?=
 =?utf-8?B?UkM1ejJhL3h4S1RaZHRtWDk1NUNPVE4vbExHdmtqT0ZpN2VtU0QweEdsQytY?=
 =?utf-8?B?bnpuR0YzVk0vY1Y3ZjAxU3ZJT0p4WXJ3NGZncU5LazVTbFRVd01weklqTVd4?=
 =?utf-8?B?bnJhVm5WQnFFbXMyMjVqTEJIYjh4djFXSGZJNlU0cm9VVHpBTloyMXlUVWMw?=
 =?utf-8?B?MEE5SStIcDZIbTdNS1VvWUJWeUduUFUwM1p3SU0rZlE5WFcvSTJ5S1BCbisv?=
 =?utf-8?B?QmFUeVdNUmtjL3loVFYzbDRJd3R2d0I4c2VPS2pEWUxoYzFUV0NEelVzd2JM?=
 =?utf-8?B?SFBwaDlvVGpLRk5OZHFtQzd3dTVxRHRUNzdSbWt1eE1RUFZ1dytGdGo5aklI?=
 =?utf-8?B?TDJPU1RvSGhxVmcycHdRQng2RGhBeEdwb3k5MjZSNldIRTFucVdFMCtxQ3NQ?=
 =?utf-8?B?YU9PeDIvR0ZKZm02RXJIS2grTXdnUGtVSEZJY3hoYjRQWE9YMVJ5dEludXkz?=
 =?utf-8?B?dFZwc2YwS0p3ZW1pNUE4M256bHEvMFdET0g4QWkzcTB3S2NTcGFLT0ZITVUy?=
 =?utf-8?B?dXRlRmRHbWlEVHFBZnRNS2Z3bU9OQ3V6MDRtMktlT013QzZsNklMVDI5bXRR?=
 =?utf-8?B?bitXRHllS0lUK0hlOXhidkJpbCtETGoxV2JZbWJoWnBjRVY3dFJsVXFyY3RF?=
 =?utf-8?B?VXBEcXRkT2xwQ2s5R3gwRWkzaXZjaXRJR3NwVU9RckRqR0F3cXZFU2pRbDR5?=
 =?utf-8?B?cEpsSFJJNG5DdUdYVDUxT05EOGVrQUZhamVCRE5QWHdSdWJDcW1hc1pCeHRG?=
 =?utf-8?B?VENNV245dkt1azdSbWtTajJjUEd6ZkpKSnFwWWhrOEJjTkFFUnA1N2o0ZlJG?=
 =?utf-8?B?OXp4dmpxSzBjcHFNSnRBY1h3aEJ2dXBFSGhDditncWtJbkhTZFZwVCs1K2k0?=
 =?utf-8?Q?scbSsXKDvxT07n2CK6CWcgZCm7RrbnCwG+Sh8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWUvbE9uWWRtU05vR0E2NjE2b3gwb0I3SUYrQnJ4VkY4K2c2cUEyNDdsNWJh?=
 =?utf-8?B?T3d2eVdqVlNVQ0plaTI0bGlHbi9rRUFvNitWOVNoQnNvTFBSMVFlaVZrQldx?=
 =?utf-8?B?UW9DOUF2WWN1M3YvUkErVmRUUkllemMrTFM0TzBRZGhLS0ZJakM2UG5ITm5i?=
 =?utf-8?B?cWVLazBmVGVxVTcxTWtGNTFGVkhhNndtck9oY2tGbTk5dnVDR2ZlRXRrY214?=
 =?utf-8?B?OStLV2tNd2JwOUdMa0dJWnVMK1Z3SjJyRDlDWW5vOE1QSnZjaVBNeGE5Z0Jy?=
 =?utf-8?B?REJSZ3hNTC9EN2MvTG9hbjVWWCtpcmlocWd1YXY2OTNKUVpIU01PbDhHZTRu?=
 =?utf-8?B?V2RVWGlqWVVGWndjRUIvZGlVQlQwSGhRak5oNnR5d3hhLzgxdXl0MnFSU2lu?=
 =?utf-8?B?aFVHVE9JdVdTd014ejhMN1huRThzeWVtZ0ZyczVJdmVpUFlQa2lmNHp2N01x?=
 =?utf-8?B?aUxPRDJjQWI1Y1BqQ2E1TjA5TkFFYkFYK0ZKWXkxT0E1a0doa1pzb0RRYmU5?=
 =?utf-8?B?dkIvL1JNZzFnTG5XWnFMdGJiOWZIS1BTb0FUU3V3NjR6T1ZtYTFUUDdoRXNL?=
 =?utf-8?B?MzRnWUVjRlhsUEY2cVVaK1luajZrYmxWU3Z6ZkdlWC9nNjh4dDZtRmpHb3Q2?=
 =?utf-8?B?REJ1UkVDZCtHcFUrVXZHU0daL2IycGRJYi81VlB4Z29vTCt4OE9PRFp5S282?=
 =?utf-8?B?RE5IanVEMWRCMXYrcG4xYmVmVWY2bW1GaG5ySlBsZmFlZ1F2N2d5alI1R3Jx?=
 =?utf-8?B?ZHlwVEFhZVc4YWpIV2JVbytHbmVSQ1pmMFBqOWNzb2JOMVo0QTAzQjVJY1h2?=
 =?utf-8?B?Nk9Zc1RTb0JRekVCY3VRcVA3TkdRVit3TW5TWFg2eUV0UEMzV2F5Q1h1SkZK?=
 =?utf-8?B?aUUxUDA2Ynpvak5FNU1pU3p0OFR1YXZMdUNNQWMwZktWNEF4K0JaRWREUGZU?=
 =?utf-8?B?eFJPOERPVUIvblYzNXU0cmI5STR3dmVMbE45WFp3OGlEMUV0K0txcXd2K3Bl?=
 =?utf-8?B?UldoZkJDbUg1TS9kTC9KZ05aVWNPV3dxM2FsSkRVR21qcVJIdUl2SGJIdUll?=
 =?utf-8?B?bEYwM2h5bS83TGNEeVhSYzdsdG51dnFLQ2tBSktjcWZ6TVF2UmNBbzRXSjZY?=
 =?utf-8?B?WWVyZ1p6ckhOcFg2Q0c0WlB3Z3VDL3U4ZnBLOWo4dFhDelhYWGZPWEVXampE?=
 =?utf-8?B?ODl2bDl0UVJEMUZPOW1CKzlyVGwyMmg0MGNjVUptMjdyblV4WlFCWUdrQWl5?=
 =?utf-8?B?YVVadEVKbFJhSEptZFdkOE9jWFlST041b2ZOTjZIN090dkw5OXFBRmg3NFE0?=
 =?utf-8?B?YlphVEFieXlnVDhuOFI1YURUMU1rLzAybW9SSXNsZFhLbm9UWU12QzRYOWE4?=
 =?utf-8?B?SVNjK0NvRkQvYXA0RXU3TUp6Wnp4MjBhNW9UU1ZLOUVkVTQ2Z2dZT3JMVzh4?=
 =?utf-8?B?Sm0rVzNST042TnJCSGZtWjdVbXZWbmxJNUltLzhqTkVaNWMrZG55WkxPSTVr?=
 =?utf-8?B?YlFlaEI3djI0Q0lUZEFuMFlZTGtvQzhnTnVFOHlaZjEyREFFbXdSaGF5RG1E?=
 =?utf-8?B?QlFiL0lYY2FQTXMzVnFIeEpuUUpLaVBkOUtQUVNuNWVMeGcwaWExMDRCaFFy?=
 =?utf-8?B?bThTdXdwWlROeGlHMU5xZHJZUkl3QzBuV3dKQjlocm9tN2VOdlJCZGxDb3JC?=
 =?utf-8?B?ZnRISTVmRW1BUVZjdElTaktsVEhwSTdsSmxGZFJkcko0emFLNG1lS1ppZTZS?=
 =?utf-8?B?LzZUMm4wLy9SQnVlS1BJY0ZrTzlKQUJRc1JHTHN3VFZDWEI4Q3ltdWwyVWRK?=
 =?utf-8?B?OXNYYU1yNVR1MkVFNWI1UVBTMHFMSExhbWFNcXJVdThzbFNYaHVySlNyKzBJ?=
 =?utf-8?B?dVpzZHBIUXhta0tiSk96SHB0SDhza09DaFpKWTNvVy9LeXJSRlhObUhPR3lj?=
 =?utf-8?B?SUdXWTZma3pGYyttU3kvc1R1TjdCM3NYNUdyS3l5UWkyVVdEQm5EZUNjZ2pu?=
 =?utf-8?B?U014T29Wc05lOG93UTBtaUVmemxJUWJXdmx0TW1SRWp3SW5VMnBWNVpqWXpN?=
 =?utf-8?B?MHcrTURQUTQvYmVBVWhnazZ4Yit6RFMrMW5Vc3dxOUdwSEh1a2MwdWVSNm53?=
 =?utf-8?B?TERtWFpZUVN0Wks1TXZrejczQWZRNXlFOFViUGttSUJaSlcrOU9UdkM5UFIz?=
 =?utf-8?B?SXc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 50c83143-3f41-4197-8c53-08dcc7be7407
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2024 00:06:38.3819
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +vxMRtaaRYZ67ZXzscm9ee3BVe2qtAQwQW9FraTYyhNspqvarYXry7Pi3+IjHOnaLG3tLjH87SE2+Wtwt5cSPcatY27pgVHlUwr7navM7c4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7942
X-OriginatorOrg: intel.com

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE5oYXQgUGhhbSA8bnBoYW1j
c0BnbWFpbC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgQXVndXN0IDI4LCAyMDI0IDI6MzUgUE0N
Cj4gVG86IFNyaWRoYXIsIEthbmNoYW5hIFAgPGthbmNoYW5hLnAuc3JpZGhhckBpbnRlbC5jb20+
DQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1tbUBrdmFjay5vcmc7
DQo+IGhhbm5lc0BjbXB4Y2hnLm9yZzsgeW9zcnlhaG1lZEBnb29nbGUuY29tOyByeWFuLnJvYmVy
dHNAYXJtLmNvbTsNCj4gSHVhbmcsIFlpbmcgPHlpbmcuaHVhbmdAaW50ZWwuY29tPjsgMjFjbmJh
b0BnbWFpbC5jb207IGFrcG1AbGludXgtDQo+IGZvdW5kYXRpb24ub3JnOyBab3UsIE5hbmhhaSA8
bmFuaGFpLnpvdUBpbnRlbC5jb20+OyBGZWdoYWxpLCBXYWpkaSBLDQo+IDx3YWpkaS5rLmZlZ2hh
bGlAaW50ZWwuY29tPjsgR29wYWwsIFZpbm9kaCA8dmlub2RoLmdvcGFsQGludGVsLmNvbT4NCj4g
U3ViamVjdDogUmU6IFtQQVRDSCB2NSAwLzNdIG1tOiBaU1dBUCBzd2FwLW91dCBvZiBtVEhQIGZv
bGlvcw0KPiANCj4gT24gV2VkLCBBdWcgMjgsIDIwMjQgYXQgMjozNeKAr0FNIEthbmNoYW5hIFAg
U3JpZGhhcg0KPiA8a2FuY2hhbmEucC5zcmlkaGFyQGludGVsLmNvbT4gd3JvdGU6DQo+ID4NCj4g
PiBIaSBBbGwsDQo+ID4NCj4gPiBUaGlzIHBhdGNoLXNlcmllcyBlbmFibGVzIHpzd2FwX3N0b3Jl
KCkgdG8gYWNjZXB0IGFuZCBzdG9yZSBtVEhQDQo+ID4gZm9saW9zLiBUaGUgbW9zdCBzaWduaWZp
Y2FudCBjb250cmlidXRpb24gaW4gdGhpcyBzZXJpZXMgaXMgZnJvbSB0aGUNCj4gPiBlYXJsaWVy
IFJGQyBzdWJtaXR0ZWQgYnkgUnlhbiBSb2JlcnRzIFsxXS4gUnlhbidzIG9yaWdpbmFsIFJGQyBo
YXMgYmVlbg0KPiA+IG1pZ3JhdGVkIHRvIHY2LjExLXJjMyBpbiBwYXRjaCAyLzQgb2YgdGhpcyBz
ZXJpZXMuDQo+ID4NCj4gPiBbMV06IFtSRkMgUEFUQ0ggdjFdIG1tOiB6c3dhcDogU3RvcmUgbGFy
Z2UgZm9saW9zIHdpdGhvdXQgc3BsaXR0aW5nDQo+ID4gICAgICBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9saW51eC1tbS8yMDIzMTAxOTExMDU0My4zMjg0NjU0LTEtDQo+IHJ5YW4ucm9iZXJ0c0Bh
cm0uY29tL1QvI3UNCj4gPg0KPiA+IEFkZGl0aW9uYWxseSwgdGhlcmUgaXMgYW4gYXR0ZW1wdCB0
byBtb2R1bGFyaXplIHNvbWUgb2YgdGhlIGZ1bmN0aW9uYWxpdHkNCj4gPiBpbiB6c3dhcF9zdG9y
ZSgpLCB0byBtYWtlIGl0IG1vcmUgYW1lbmFibGUgdG8gc3VwcG9ydGluZyBhbnktb3JkZXINCj4g
PiBtVEhQcy4gRm9yIGluc3RhbmNlLCB0aGUgZnVuY3Rpb24genN3YXBfc3RvcmVfZW50cnkoKSBz
dG9yZXMgYQ0KPiB6c3dhcF9lbnRyeQ0KPiA+IGluIHRoZSB4YXJyYXkuIExpa2V3aXNlLCB6c3dh
cF9kZWxldGVfc3RvcmVkX29mZnNldHMoKSBjYW4gYmUgdXNlZCB0bw0KPiA+IGRlbGV0ZSBhbGwg
b2Zmc2V0cyBjb3JyZXNwb25kaW5nIHRvIGEgaGlnaGVyIG9yZGVyIGZvbGlvIHN0b3JlZCBpbiB6
c3dhcC4NCj4gPg0KPiANCj4gV2lsbCB0aGlzIGhhdmUgYW55IGNvbmZsaWN0IHdpdGggbVRIUCBz
d2FwIHdvcms/IEVzcGVjaWFsbHkgd2l0aCBtVEhQDQo+IHN3YXAtaW4gYW5kIHpzd2FwIHdyaXRl
YmFjay4NCj4gDQo+IE15IHVuZGVyc3RhbmRpbmcgaXMgZnJvbSB6c3dhcCdzIHBlcnNwZWN0aXZl
LCB0aGUgbGFyZ2UgZm9saW8gaXMNCj4gYnJva2VuIGFwYXJ0IGludG8gaW5kZXBlbmRlbnQgc3Vi
cGFnZXMsIGNvcnJlY3Q/IFdoYXQgaGFwcGVucyB3aGVuIHdlDQo+IGhhdmUgcGFydGlhbGx5IHdy
aXR0ZW4gYmFjayBtVEhQIChpLmUgc29tZSBzdWJwYWdlcyBhcmUgaW4genN3YXANCj4gc3RpbGws
IHdoZXJlYXMgb3RoZXJzIGFyZSB3cml0dGVuIGJhY2sgdG8gc3dhcCkuIFdvdWxkIHRoaXMNCj4g
YXV0b21hdGljYWxseSBwcmV2ZW50IG1USFAgc3dhcGluPw0KDQpUaGF0IGlzIGEgZ29vZCBwb2lu
dC4gVG8gYmVnaW4gd2l0aCwgdGhpcyBwYXRjaC1zZXJpZXMgd291bGQgbWFrZSB0aGUgZGVmYXVs
dA0KYmVoYXZpb3IgZm9yIG1USFAgc3dhcG91dC9zdG9yYWdlIGFuZCBzd2FwaW4gZm9yIFpTV0FQ
IHRvIGJlIG9uIHBhciB3aXRoDQpaUkFNLiBGcm9tIHpzd2FwJ3MgcGVyc3BlY3RpdmUsIGltbyB0
aGlzIGlzIGEgc2lnbmlmaWNhbnQgc3RlcCBmb3J3YXJkIHRvd2FyZHMNCnJlYWxpemluZyBjb2xk
IG1lbW9yeSBzdG9yYWdlIHdpdGggbVRIUCBmb2xpb3MuIEhvd2V2ZXIsIGl0IGlzIG9ubHkgYSBz
dGFydGluZw0KcG9pbnQgdGhhdCBtYWtlcyB0aGUgYmVoYXZpb3IgdW5pZm9ybSBhY3Jvc3MgenN3
YXAvenJhbS4gSW5pdGlhbGx5LCB3b3JrbG9hZHMNCndvdWxkIHNlZSBhIG9uZS10aW1lIGJlbmVm
aXQgd2l0aCByZWNsYWltIGJlaW5nIGFibGUgdG8gc3dhcG91dCBtVEhQDQpmb2xpb3Mgd2l0aG91
dCBzcGxpdHRpbmcsIHRvIHpzd2FwLiBJZiB0aGUgbVRIUHMgd2VyZSBjb2xkIG1lbW9yeSwgdGhl
biB3ZQ0Kd291bGQgaGF2ZSBkZXJpdmVkIGxhdGVuY3kgZ2FpbnMgdG93YXJkcyBtZW1vcnkgc2F2
aW5ncyAod2l0aCB6c3dhcCkuDQoNCkhvd2V2ZXIsIGlmIHRoZSBtVEhQIHdlcmUgcGFydCBvZiAi
bm90IHNvIGNvbGQiIG1lbW9yeSwgdGhpcyB3b3VsZCByZXN1bHQNCmluIGEgb25lLXdheSBtVEhQ
IGNvbnZlcnNpb24gdG8gNEsgZm9saW9zLiBEZXBlbmRpbmcgb24gd29ya2xvYWRzIGFuZCB0aGVp
cg0KYWNjZXNzIHBhdHRlcm5zLCB3ZSBjb3VsZCBlaXRoZXIgc2VlIGluZGl2aWR1YWwgNEsgZm9s
aW9zIGJlaW5nIHN3YXBwZWQgaW4sDQpvciBlbnRpcmUgY2h1bmtzIGlmIG5vdCB0aGUgZW50aXJl
IChvcmlnaW5hbCkgbVRIUCBuZWVkaW5nIHRvIGJlIHN3YXBwZWQgaW4uDQoNCkl0IHNob3VsZCBi
ZSBub3RlZCB0aGF0IHRoaXMgaXMgbW9yZSBvZiBhIHBlcmZvcm1hbmNlIHZzLiBjb2xkIG1lbW9y
eQ0KcHJlc2VydmF0aW9uIHRyYWRlLW9mZiB0aGF0IG5lZWRzIHRvIGRyaXZlIG1USFAgcmVjbGFp
bSwgc3RvcmFnZSwgc3dhcGluIGFuZA0Kd3JpdGViYWNrIHBvbGljeS4gRGlmZmVyZW50IHdvcmts
b2FkcyBjb3VsZCByZXF1aXJlIGRpZmZlcmVudCBwb2xpY2llcy4gSG93ZXZlciwNCmV2ZW4gdGhv
dWdoIHRoaXMgcGF0Y2ggaXMgb25seSBhIHN0YXJ0aW5nIHBvaW50LCBpdCBpcyBzdGlsbCBmdW5j
dGlvbmFsbHkgY29ycmVjdA0KYnkgYmVpbmcgZXF1aXZhbGVudCB0byB6cmFtLW1USFAsIGFuZCBj
b21wYXRpYmxlIHdpdGggdGhlIHJlc3Qgb2YgbW0gYW5kDQpzd2FwIGFzIGZhciBhcyBtVEhQLiBB
bm90aGVyIGltcG9ydGFudCBmdW5jdGlvbmFsaXR5L2RhdGEgY29uc2lzdGVuY3kgZGVjaXNpb24N
CkkgbWFkZSBpbiB0aGlzIHBhdGNoIHNlcmllcyBpcyBlcnJvciBoYW5kbGluZyBkdXJpbmcgenN3
YXBfc3RvcmUoKSBvZiBtVEhQOg0KaW4gY2FzZSBvZiBhbnkgZXJyb3JzLCBhbGwgc3dhcCBvZmZz
ZXRzIGZvciB0aGUgbVRIUCBhcmUgZGVsZXRlZCBmcm9tIHRoZQ0KenN3YXAgeGFycmF5L3pwb29s
LCBzaW5jZSB3ZSBrbm93IHRoYXQgdGhlIG1USFAgd2lsbCBub3cgaGF2ZSB0byBiZSBzdG9yZWQN
CmluIHRoZSBiYWNraW5nIHN3YXAgZGV2aWNlLiBJT1csIGFuIG1USFAgaXMgZWl0aGVyIGVudGly
ZWx5IHN0b3JlZCBpbiB6c3dhcCwNCm9yIGVudGlyZWx5IG5vdCBzdG9yZWQgaW4genN3YXAuDQoN
ClRvIGFuc3dlciB5b3VyIHF1ZXN0aW9uLCB3ZSB3b3VsZCBuZWVkIHRvIGNvbWUgdXAgd2l0aCB3
aGF0IHRoZSBzZW1hbnRpY3MNCndvdWxkIG5lZWQgdG8gYmUgZm9yIHpzd2FwIHpwb29sIHN0b3Jh
Z2UgZ3JhbnVsYXJpdHksIHN3YXBpbiBncmFudWxhcml0eSwNCnJlYWRhaGVhZCBncmFudWxhcml0
eSBhbmQgd3JpdGViYWNrIHdydCBtVEhQIGFuZCBob3cgdGhlIG92ZXJhbGwgc3dhcA0Kc3ViLXN5
c3RlbSBuZWVkcyB0byAicHJlc2VydmUiIG1USFAgdnMuIHNwbGl0dGluZyBtVEhQIGludG8gNEsv
bG93ZXItb3JkZXINCmZvbGlvcyBkdXJpbmcgc3dhcG91dC4gT25jZSB3ZSBoYXZlIGEgZ29vZCB1
bmRlcnN0YW5kaW5nIG9mIHRoZXNlIHBvbGljaWVzLA0Kd2UgY291bGQgaW1wbGVtZW50IHRoZW0g
aW4genN3YXAuIEFsdGVybmF0ZWx5LCBkZXZlbG9wIGFuIGFic3RyYWN0aW9uIHRoYXQgaXMNCm9u
ZSBsZXZlbCBhYm92ZSB6c3dhcC96cmFtIGFuZCBtYWtlcyB0aGluZ3MgZWFzaWVyIGFuZCBzaGFy
ZWFibGUgYmV0d2Vlbg0KenN3YXAgYW5kIHpyYW0uIEJ5IHRoaXMsIEkgbWVhbiBmdW5kYW1lbnRh
bCBhc3N1bXB0aW9ucyBzdWNoIGFzIGNvbnNlY3V0aXZlDQpzd2FwIG9mZnNldHMgKGZvciBpbnN0
YW5jZSkuIFRvIHNvbWUgZXh0ZW50LCB0aGlzIGltcGxpZXMgdGhhdCBhbiBtVEhQIGFzIGENCnN3
YXAgZW50aXR5IGlzIGRlZmluZWQgYnkgY29uc2VjdXRpdmVuZXNzIG9mIHN3YXAgb2Zmc2V0cy4g
TWF5YmUgdGhlIHBvbGljeQ0KdG8ga2VlcCBtVEhQcyBpbiB0aGUgc3lzdGVtIG92ZXIgZXh0ZW5k
ZWQgZHVyYXRpb24gbWlnaHQgYmUgdG8gYXNzZW1ibGUNCnRoZW0gZHluYW1pY2FsbHkgYmFzZWQg
b24gc3dhcGluX3JlYWRhaGVhZCgpIGRlY2lzaW9ucyAod2hpY2ggaXMgYmFzZWQgb24NCndvcmts
b2FkIGFjY2VzcyBwYXR0ZXJucykuIEluIG90aGVyIHdvcmRzLCBtVEhQcyBjb3VsZCBiZSBhIHVz
ZWZ1bCBhYnN0cmFjdGlvbg0KdGhhdCBjYW4gYmUgc3RhdGljIG9yIGV2ZW4gZHluYW1pYyBiYXNl
ZCBvbiB3b3JraW5nIHNldCBjaGFyYWN0ZXJpc3RpY3MsIGFuZA0KY29sZCBtZW1vcnkgcHJlc2Vy
dmF0aW9uLiBUaGlzIGlzIHF1aXRlIGEgY29tcGxleCB0b3BpYyBpbWhvLg0KDQpBcyB3ZSBrbm93
LCBCYXJyeSBTb25nIGFuZCBDaHVhbmh1YSBIYW4gaGF2ZSBzdGFydGVkIHRoZSBkaXNjdXNzaW9u
IG9uDQp0aGlzIGluIHRoZWlyIHpyYW0gbVRIUCBzd2FwaW4gc2VyaWVzIFsxXS4NCg0KWzFdIGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI0MDgyMTA3NDU0MS41MTYyNDktMy1oYW5jaHVh
bmh1YUBvcHBvLmNvbS9ULyN1DQoNClRoYW5rcywNCkthbmNoYW5hDQo=

