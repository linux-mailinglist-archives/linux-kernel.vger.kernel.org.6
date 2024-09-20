Return-Path: <linux-kernel+bounces-333926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C08C97CFEC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 04:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 159F01F24EBA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 02:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1361BA34;
	Fri, 20 Sep 2024 02:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EqgCChMp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C05F9CF
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 02:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726799710; cv=fail; b=kCRe2Dj8q0vsMh5+Sc9Xfl9t/Wgp24utpd98lt2CmpYvN8Pm3B+ZWIo74TlszS5V/GD37bhaQa/1hbTa5mRUNTZ8wQOWjGDTcMzA5rLrpLAwVUGz0e97PtMa6bH6S6zQg4DPUdKmTyaGBapElbQR5H3MZUp5ellM1EFLTF2eszE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726799710; c=relaxed/simple;
	bh=tAHDjPO+DQQcCuS2b239JF/y1vOxXASFFQIgZ5xFaMA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uMJ1+1fDBHgukzi/wiOA+8I+8//6rTsu6KOJ7mRzdOmJp4VOgHX2vmJsWeEax9w2staCYZafW72hY6gV9OEUJubOvV13NXtxLqMGl+EQzB2P+bSBjYUsl/xorDSGoyJSWVKXXfHy7CezYJHngmzEm1Kd7AFDpMeBWLk/Cd6y0IA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EqgCChMp; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726799707; x=1758335707;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tAHDjPO+DQQcCuS2b239JF/y1vOxXASFFQIgZ5xFaMA=;
  b=EqgCChMphKP0n+VHCKYlvz8zhz3kOUdiw6PpVIqeOvidww7UXbEV+EYt
   4q25kctbvCv2WxFKn8lw2eB7jvTIsF63BMgWJsTn7IOOuRJ/f5llNdsZK
   zGEbtz/iXW4AlccVtLqsuC6Haa1quX6C78l4XDZPDDY0PSaR+kXBCf2OR
   lwP8jsiBORFbCXtkLTSJJrh1HWToJRpJDUiDTLWuOA0+MsysS6cwDnKdz
   gz0S93cf3rde+QUe76gTqG9GfSGNDxCWS8xABpuAYKy6mNFBOXZ5au7rC
   IWFgy4lmcFe5nDyly4YqMparbHgyKIcTWp6XF0NOF96Wt0AuzMfSbY0X+
   w==;
X-CSE-ConnectionGUID: LHIhh4DZQ56+NtvsDl6Jsg==
X-CSE-MsgGUID: Bl09ORB6SB2xhrwSV37TOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="13602252"
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; 
   d="scan'208";a="13602252"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 19:35:06 -0700
X-CSE-ConnectionGUID: v4CLqe2JSWafOgVvU/pGdw==
X-CSE-MsgGUID: mqk7kr2zTa6z+G3Y1amRtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,243,1719903600"; 
   d="scan'208";a="74676250"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Sep 2024 19:35:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 19:35:05 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 19:35:05 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 19 Sep 2024 19:35:05 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Sep 2024 19:35:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qp91SDpSn4NeGfENG3D6ck2JqTeGSN9HHrEi8JYaWGy9AjXEBRHcwN+ddoaj7y3kiLf1oDdu7AzSDmhFrLcBjfSOcECIZX7VW6PVL+6DohYXN7wSKNs7gDIjTrl4lQGfoLaSwCu4i1ZmxAahDCeIxu+fJh7sTUyELyhqVen1zdHY5V24LqkwO0IEbuhJZpI049uTWQVPVWlJH7WIkDeO13vxRvDpRbYoJDGM0utFPvrEkLzvucIEwrVwCURqeiqN+el7M4ipm6gYXANHQ1nTed3fUyjQsZDctIQNziBXMWIWFVZJCdxAvSEMVL5jW4OHSujON0BX+bFWLi8Tsgi9mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tAHDjPO+DQQcCuS2b239JF/y1vOxXASFFQIgZ5xFaMA=;
 b=fsu5BJ4IVoGTJzN4mPlI3QnO0CWOe4CMIvP9uQbhvQSSNLEeN1VDr1QRQZeNPs3rk9nuZFk6M6n4HBIvc8fdAYSK0HM/+J+v4FNwH4pO1KS5z7H6eqz8zylHkuQu+4IALbEqGqspI0/vlx90u3rLsmpUYnKmKgXnnk3LRZvmnbLNZBTHTn0rCmIQJyMis+UBw+G2st+heN49yewgDppdXt6TGhDHTlDWhXQecbi8KOcRnhH4bDik11kj2NHRUHJFwQ+tt7KXYHTp754/7CA24Jw60rhWbwtCH9QSphkx3FR81IIk4FP3YMj+JIKMcLHbOBjWXLOi+R1YBgZxtBx66A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by CY5PR11MB6319.namprd11.prod.outlook.com (2603:10b6:930:3d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Fri, 20 Sep
 2024 02:34:58 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.7982.018; Fri, 20 Sep 2024
 02:34:58 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Chengming Zhou <chengming.zhou@linux.dev>, Nhat Pham <nphamcs@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "yosryahmed@google.com" <yosryahmed@google.com>,
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, "Huang, Ying"
	<ying.huang@intel.com>, "21cnbao@gmail.com" <21cnbao@gmail.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "Zou, Nanhai"
	<nanhai.zou@intel.com>, "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>,
	"Gopal, Vinodh" <vinodh.gopal@intel.com>, Usama Arif
	<usamaarif642@gmail.com>, "Sridhar, Kanchana P"
	<kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v5 0/3] mm: ZSWAP swap-out of mTHP folios
Thread-Topic: [PATCH v5 0/3] mm: ZSWAP swap-out of mTHP folios
Thread-Index: AQHa+S2hY1M67nGQo0+E71Bgb79m17I9MgEAgAAYkECAAS/JAIAAKHiggACbjACAINo1oA==
Date: Fri, 20 Sep 2024 02:34:58 +0000
Message-ID: <SJ0PR11MB5678B5DFF28E5F21CEC81B11C96C2@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20240828093516.30228-1-kanchana.p.sridhar@intel.com>
 <CAKEwX=Pqm3pjOO-ErOTGnNYKwMas4fdiN0bdUcrPHzfKf-Qryw@mail.gmail.com>
 <SJ0PR11MB5678412EE36C10CC0D69D036C9962@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAKEwX=P3L_uxWs6m9KL_Pqv_LpPpXH4E9gWMT95oi==ZNmqkWQ@mail.gmail.com>
 <SJ0PR11MB5678AEDB9E47BB6267D5885CC9962@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <8545b4d8-ba21-4607-8217-2b7b02ccb4d8@linux.dev>
In-Reply-To: <8545b4d8-ba21-4607-8217-2b7b02ccb4d8@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|CY5PR11MB6319:EE_
x-ms-office365-filtering-correlation-id: 1127829c-f868-4feb-7783-08dcd91cd1f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Zmh3eExjdmpEeCs2aFk5Q0NWZ0VjaytkOC9HR3FET0hNUWlXSUxRb3JGUkgr?=
 =?utf-8?B?UGhUTXd1Vm9xVTlFWFBaNk9WdjBSUU5oeklFcXFDSWlqb1lNTmNhaTRKenZx?=
 =?utf-8?B?a2l4MDUwalRPM2RiUlIwM29YQmFBS2hZeWYxOEdKY2x3bnpFckRNK1JpUjJa?=
 =?utf-8?B?dThpOGxaTDZJdlBoNTkrNEo2eTlhaXZTdzFpa3JqeE4wdytvV0VhUkl2NDB4?=
 =?utf-8?B?dGZzeGJSOXlmTThSRllHVnFzVldMQXpSbE83RnRwOWR2STJ1K29SRDFLY3FU?=
 =?utf-8?B?Tkp1WHNCa3JFNy8rMCtKbUNOd0RqR0NDcDd2WGJ0VDJaem5jZ2QwVmNONHF3?=
 =?utf-8?B?NE5JZmdKZDZMZ0pJL2h6ZWxzSnZsS3J6Vi94NjhmT3NBNjVvbHZrUVlHWEd1?=
 =?utf-8?B?VExLc2o1cG84V3RpWncwa214OSt5VGtjYWIrdUc0MitOVjZVUnlOTnVxVDcr?=
 =?utf-8?B?RlFpVnQyazR4bmpBZ3RyaWJVUUZ3N0JNQWNjK3pldGJNMkU2VlZ2QVRiYWE3?=
 =?utf-8?B?cmZsRjVtcVVtYW1NSTA1eEh2TEVOTWt6OTJVeXNBRjVqRlloRnpmUmpzUHNZ?=
 =?utf-8?B?a3ZPUThRaWtIQ0g1eG9oVGNIZW1ydWtQVmpLVG1qU1BqSzJCeWxEdHpUdlV1?=
 =?utf-8?B?UFBPKy80bFdWOW01bUM3MDVpNTgzNzlMY2NSTUErenpNdUk2QmZZUktaYWNo?=
 =?utf-8?B?RVBqV0NNUlp4NnhraTBXZ2xiK3JlaFpmaUVwSkpYczRCcWl5UHdyOWFrL2E1?=
 =?utf-8?B?Z1dHY1pBdGxzTEFIbEI0WW8zb2N1NHE1eVFPb2wvRDBZQU5IS2lBR2N1RmIv?=
 =?utf-8?B?dnZIQzdNcTUraTNwNFdXMVU3MHRDMVUrVVJYMThrV0wyckh3RFdSeEdRRnJk?=
 =?utf-8?B?SUtjZ0twb2ZVQnM1VWllUXo5M2I4YnJKSjMvUTdYcXdSdzdXQk5nbWpuYjhn?=
 =?utf-8?B?L1cxRTJ0b1krZmZCMFRDb3k4SnBWS0x6T29CclQxWHJwVlZPQjgybGgvVzZK?=
 =?utf-8?B?UmdFT3pqeUNrc0VzdE12VUgzV1htSmMrQTlwVEJBbzAxZElnZjNaUVk2Z3p0?=
 =?utf-8?B?ZGs1THgrMS92ZUc1OXJzdi9HcENzNEdxdDM1WjVHVUZ6UGtDQWVjWStQeXpy?=
 =?utf-8?B?UExiZ1k1YVhTNDJkdWFrVDlWNzgwRVZUNkY5Qm0zTkhBN0Z4M2daTiswOUho?=
 =?utf-8?B?ak54K2cyNHBsMkI3T05ZdEdoMWF6ZWg4OW5jNDNQMGZ6MVBmWksrRnFiWXVJ?=
 =?utf-8?B?anBxKzUyTHprZjI1UXVWRmdFcmdJV2h4aTVVNlhkd1BCWE1ldWlLUER3c3Ir?=
 =?utf-8?B?K0dLSGpaaHpiNkROVkFVMlhNNm5YU1NNNnZIRlhoTTVEU3owcWN2TFZ3VGtL?=
 =?utf-8?B?dkNVbDZpeW11OG1nOFU2LzZUN3B6amdjbGRIOGRFYUU5Mko3L2ozemlmVUd6?=
 =?utf-8?B?dlMzOHFiVlE0MFVSRnUrVm10V0RwNm8wOXV1MjR1azZ5anZFRXhYeWpPUDR0?=
 =?utf-8?B?UlV1YU16bjB6UkdXTkVYMkVDMksyaFd2RVhlUVludjQwN0I3WDV1ZWRGcU1u?=
 =?utf-8?B?M2FsdjVpNWs0a1lzakxock1tU2p6RmlMbDVBSGQvTEZoRndEUkczWkIrVHBU?=
 =?utf-8?B?Ull1d0wwT3RPeVNPa1NwZk9RUUlyS0ZERDM1ZEM5eHVqVFgyRkZVQnVGWHl6?=
 =?utf-8?B?ak9XNE9qQS9SVWtpSnFXaExnS2xGTTh0QTM4Q1dUVmYyWlVqR2VvV1Nra3FD?=
 =?utf-8?B?S29nY2F6SGszamI2Q2pJVUN3RVNkR2ZNU2FDbld3NW8wUFdIb3p2NVlWY3RS?=
 =?utf-8?Q?5X6kJcAFl5kXH0SNoYv5yrKyhimWH5dU8BdSE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YTJ1aWlGMTYxQXl3cmczenZYU2RFK0J6NkZzcktPM3FxdFN5Nit5TzRyekx3?=
 =?utf-8?B?WlByNGkxN1VRWmEwTUZEQ2dScU12bjZZNFc5ZVdjV0I4bWY5aWgyV29ZMU5F?=
 =?utf-8?B?VG1acExlQjB6ZVVkK1laVkdxekc0TzMyTHgrQ0I2SUgwNUY4MG1XV0JxbUdR?=
 =?utf-8?B?VGJldEU4dm5WaXFJem1SQ1lUTGRIejdTQ21wdHBnYnZWSUg0S1dKRGhtdmhF?=
 =?utf-8?B?aUJocXBUSG5BTlBoTjlyblYvcWF4OHo5YVpNTC9LQ005d1h0cjlUOUtiWGIv?=
 =?utf-8?B?UmxYUnFKOStSVjNFbm9ZY3dLMWsxTTFWZU1LRVZyMVlzK2pUNzVOYWZZZjkw?=
 =?utf-8?B?aG5zSmxhZTA0MmJYNXpSRTdqY1lIblBXQ3hyTlY3MjJURlZSaFhlOE5TbkJ6?=
 =?utf-8?B?RnpXMFNERVp4aFNSOGhxNXNIUVNWN2VuNi9yc3RPcnFURWlNTlFFdDlKUmJ6?=
 =?utf-8?B?OTNiWk1vQXZkUkxsRDNBWmkwS1pJYnpienBscW9Bd0twZE5ZOERNUzRId1FL?=
 =?utf-8?B?NDlaRzhHZ0hTamVRMkp2eS9kVnVsRFpDdFYyVXlqa2tERnVESGp6OTRuRlgr?=
 =?utf-8?B?OE9vOVF1UHFCVHBNWk5mZXJwbkxDanNZODZTU3Fzeno3Q0FIdGpRblJSb0FZ?=
 =?utf-8?B?TXh2eDNka2t4TWlyZmZaTjEyYkRHRm1oVGpTNjhuTzNtaWtwTTEvakJBTGYz?=
 =?utf-8?B?SUhHMXlTamc2N29lNUU5Z2ozWFFFRXBNZzJBb0xrYmczWEJzRVlVZWlaalZL?=
 =?utf-8?B?Tnk2azRHYXduekVqVStiSWQ0aFV3QktNdVNjbmxiOWhlYTNkYUg4OFM5MGMz?=
 =?utf-8?B?dEthRE0wRkNqMk9NeFhObWJkMmRaVzVzL0h1M3FmVUtweTJDWk8xRnFyOXpJ?=
 =?utf-8?B?eS9aUVB1SWIxb1k2M0dtVzdXSnN1ZUxBS21PRHc1OENUanV2Q1E3NmRJbFBT?=
 =?utf-8?B?RzdNOEQveWhMYVVmOTRTcFlWektYcENNQXNBN3lsQjd5KzV0V1hDVkFTdnZZ?=
 =?utf-8?B?SkhLTUJEcVdWUVFORVlYektXK0hFZ2QxQkkxaGxnbXc3VDh4MzBJMFpsempm?=
 =?utf-8?B?emlYWDczckRpS2FsdHVJTFhtR2ZER1E1ekxOekFEV0crR0ExV2R0VkQ4MTlj?=
 =?utf-8?B?a2YyKzBWWm01V2hxQWpreXQzRFBZMlowdVNVWDZEcm0yaThrTkNmay9pS0pE?=
 =?utf-8?B?T09oZDBUWlZ5L3k4QllSTzFvMnc3azc3TXlDMlN0U3poRGRwWkxFSkVudHp4?=
 =?utf-8?B?Yno4ZlpOS0p3T1NPZ3JKenpjNkFoSzdLSVNYdXpXNS9BUWEvUmYxOTIzSFlv?=
 =?utf-8?B?Y0hVaHFWWC9Ha0lTaTQzYXVlZEc4MG84MUNWcmJIOHhudkdNNmtWOTEydWht?=
 =?utf-8?B?Y1BNNmFSSkFhdTNCTElJMDI2QmQ2M2EwckRZQm51OEFrVGg0Nk9Dd0F3OXFQ?=
 =?utf-8?B?anE0MXhDV0MwUzM3eW9DRFQyQll4WEJzaDlRSEZGZ2dOZWhTVytSZUV0ei9Z?=
 =?utf-8?B?enE2Z2w4b0J4Yzdja2tTRE56SmN4WEVwOGlJVUV2SHZONmt5VzZPK0V0eGNK?=
 =?utf-8?B?eUU2L0hSQ0h2eHY3S0dXTHlBWmdQZ25nS3hRb29XamoyVll4ZWhYK0piMFRN?=
 =?utf-8?B?NGVUYkZKY0t0aTBWTU0rVGZWWFpRL3JHQXYrdm9SejJsQkZpWW5BaFBDVWdP?=
 =?utf-8?B?dXZpWjRBajZRTWRtcGxyMmhzdFhqRU9CR2xvbC9zUGpVNERHZVJPQm1XQUFl?=
 =?utf-8?B?aHIyTmVJbXJ1RHFpUFliamd1Z3ozMGZjQ1kwUEJvMzdDcHNCaEhNUGh3eUJS?=
 =?utf-8?B?NUprenpydy80R3J5WkM2LzYzNk1uZnVDRXNaTkFpaUtSSWlUMllhYTJ6bmxU?=
 =?utf-8?B?ZDVHdWRVNFlFdFlVZk92VHZ2SkdEN2tuWWtPY3pncHNnTTJrTTc5UGFWcTFh?=
 =?utf-8?B?ZlBWcW1tNmdaRkoxVm1JUGxJMklGNWk3bXZQVEpIM2tUYjluVEdMY1llWGZU?=
 =?utf-8?B?Ryt3UlltODdJMkR3ay9ZVlJzR0RWc1RWOTJ2VnRiSUpXN0k2TEZGdjFxcDBI?=
 =?utf-8?B?UXlCbEkvWkRMVi8zdVpvL0F5ZUR0L2swVkgyZk1XZU51dkt2bEdjbUFYUXZD?=
 =?utf-8?B?T3BoK3hkWlg5bE5nalJMaEQwTHVMRVZIU2NudnJwaUgvUmFFOHJ5L2hUOGpS?=
 =?utf-8?B?Ymc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1127829c-f868-4feb-7783-08dcd91cd1f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2024 02:34:58.4391
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YURjk8L/iLrSwt3F+54dkQRYDUKvRY4qHS6+2gsqDgytvnCK3TU+UOjjRz/kRyrL39xHDSk6XCuhFHBAHXe5nvin8uIXv2AOqTmEYwIyj6I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6319
X-OriginatorOrg: intel.com

SGkgQ2hlbmdtaW5nLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IENo
ZW5nbWluZyBaaG91IDxjaGVuZ21pbmcuemhvdUBsaW51eC5kZXY+DQo+IFNlbnQ6IFRodXJzZGF5
LCBBdWd1c3QgMjksIDIwMjQgOTo1MiBQTQ0KPiBUbzogU3JpZGhhciwgS2FuY2hhbmEgUCA8a2Fu
Y2hhbmEucC5zcmlkaGFyQGludGVsLmNvbT47IE5oYXQgUGhhbQ0KPiA8bnBoYW1jc0BnbWFpbC5j
b20+DQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1tbUBrdmFjay5v
cmc7DQo+IGhhbm5lc0BjbXB4Y2hnLm9yZzsgeW9zcnlhaG1lZEBnb29nbGUuY29tOyByeWFuLnJv
YmVydHNAYXJtLmNvbTsNCj4gSHVhbmcsIFlpbmcgPHlpbmcuaHVhbmdAaW50ZWwuY29tPjsgMjFj
bmJhb0BnbWFpbC5jb207IGFrcG1AbGludXgtDQo+IGZvdW5kYXRpb24ub3JnOyBab3UsIE5hbmhh
aSA8bmFuaGFpLnpvdUBpbnRlbC5jb20+OyBGZWdoYWxpLCBXYWpkaSBLDQo+IDx3YWpkaS5rLmZl
Z2hhbGlAaW50ZWwuY29tPjsgR29wYWwsIFZpbm9kaCA8dmlub2RoLmdvcGFsQGludGVsLmNvbT47
DQo+IFVzYW1hIEFyaWYgPHVzYW1hYXJpZjY0MkBnbWFpbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjUgMC8zXSBtbTogWlNXQVAgc3dhcC1vdXQgb2YgbVRIUCBmb2xpb3MNCj4gDQo+IE9u
IDIwMjQvOC8zMCAwMzozOCwgU3JpZGhhciwgS2FuY2hhbmEgUCB3cm90ZToNCj4gPiBIaSBOaGF0
LA0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IE5oYXQg
UGhhbSA8bnBoYW1jc0BnbWFpbC5jb20+DQo+ID4+IFNlbnQ6IFRodXJzZGF5LCBBdWd1c3QgMjks
IDIwMjQgMTA6MTEgQU0NCj4gPj4gVG86IFNyaWRoYXIsIEthbmNoYW5hIFAgPGthbmNoYW5hLnAu
c3JpZGhhckBpbnRlbC5jb20+DQo+ID4+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1tbUBrdmFjay5vcmc7DQo+ID4+IGhhbm5lc0BjbXB4Y2hnLm9yZzsgeW9zcnlhaG1l
ZEBnb29nbGUuY29tOyByeWFuLnJvYmVydHNAYXJtLmNvbTsNCj4gPj4gSHVhbmcsIFlpbmcgPHlp
bmcuaHVhbmdAaW50ZWwuY29tPjsgMjFjbmJhb0BnbWFpbC5jb207IGFrcG1AbGludXgtDQo+ID4+
IGZvdW5kYXRpb24ub3JnOyBab3UsIE5hbmhhaSA8bmFuaGFpLnpvdUBpbnRlbC5jb20+OyBGZWdo
YWxpLCBXYWpkaSBLDQo+ID4+IDx3YWpkaS5rLmZlZ2hhbGlAaW50ZWwuY29tPjsgR29wYWwsIFZp
bm9kaCA8dmlub2RoLmdvcGFsQGludGVsLmNvbT47DQo+ID4+IFVzYW1hIEFyaWYgPHVzYW1hYXJp
ZjY0MkBnbWFpbC5jb20+OyBDaGVuZ21pbmcgWmhvdQ0KPiA+PiA8Y2hlbmdtaW5nLnpob3VAbGlu
dXguZGV2Pg0KPiA+PiBTdWJqZWN0OiBSZTogW1BBVENIIHY1IDAvM10gbW06IFpTV0FQIHN3YXAt
b3V0IG9mIG1USFAgZm9saW9zDQo+ID4+DQo+ID4+IE9uIFdlZCwgQXVnIDI4LCAyMDI0IGF0IDU6
MDbigK9QTSBTcmlkaGFyLCBLYW5jaGFuYSBQDQo+ID4+IDxrYW5jaGFuYS5wLnNyaWRoYXJAaW50
ZWwuY29tPiB3cm90ZToNCj4gPj4+DQo+ID4+Pg0KPiA+Pj4+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+ID4+Pj4gRnJvbTogTmhhdCBQaGFtIDxucGhhbWNzQGdtYWlsLmNvbT4NCj4gPj4+
PiBTZW50OiBXZWRuZXNkYXksIEF1Z3VzdCAyOCwgMjAyNCAyOjM1IFBNDQo+ID4+Pj4gVG86IFNy
aWRoYXIsIEthbmNoYW5hIFAgPGthbmNoYW5hLnAuc3JpZGhhckBpbnRlbC5jb20+DQo+ID4+Pj4g
Q2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LW1tQGt2YWNrLm9yZzsNCj4g
Pj4+PiBoYW5uZXNAY21weGNoZy5vcmc7IHlvc3J5YWhtZWRAZ29vZ2xlLmNvbTsNCj4gPj4gcnlh
bi5yb2JlcnRzQGFybS5jb207DQo+ID4+Pj4gSHVhbmcsIFlpbmcgPHlpbmcuaHVhbmdAaW50ZWwu
Y29tPjsgMjFjbmJhb0BnbWFpbC5jb207DQo+IGFrcG1AbGludXgtDQo+ID4+Pj4gZm91bmRhdGlv
bi5vcmc7IFpvdSwgTmFuaGFpIDxuYW5oYWkuem91QGludGVsLmNvbT47IEZlZ2hhbGksIFdhamRp
IEsNCj4gPj4+PiA8d2FqZGkuay5mZWdoYWxpQGludGVsLmNvbT47IEdvcGFsLCBWaW5vZGggPHZp
bm9kaC5nb3BhbEBpbnRlbC5jb20+DQo+ID4+Pj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NSAwLzNd
IG1tOiBaU1dBUCBzd2FwLW91dCBvZiBtVEhQIGZvbGlvcw0KPiA+Pj4+DQo+ID4+Pj4gT24gV2Vk
LCBBdWcgMjgsIDIwMjQgYXQgMjozNeKAr0FNIEthbmNoYW5hIFAgU3JpZGhhcg0KPiA+Pj4+IDxr
YW5jaGFuYS5wLnNyaWRoYXJAaW50ZWwuY29tPiB3cm90ZToNCj4gPj4+Pj4NCj4gPj4+Pj4gSGkg
QWxsLA0KPiA+Pj4+Pg0KPiA+Pj4+PiBUaGlzIHBhdGNoLXNlcmllcyBlbmFibGVzIHpzd2FwX3N0
b3JlKCkgdG8gYWNjZXB0IGFuZCBzdG9yZSBtVEhQDQo+ID4+Pj4+IGZvbGlvcy4gVGhlIG1vc3Qg
c2lnbmlmaWNhbnQgY29udHJpYnV0aW9uIGluIHRoaXMgc2VyaWVzIGlzIGZyb20gdGhlDQo+ID4+
Pj4+IGVhcmxpZXIgUkZDIHN1Ym1pdHRlZCBieSBSeWFuIFJvYmVydHMgWzFdLiBSeWFuJ3Mgb3Jp
Z2luYWwgUkZDIGhhcw0KPiBiZWVuDQo+ID4+Pj4+IG1pZ3JhdGVkIHRvIHY2LjExLXJjMyBpbiBw
YXRjaCAyLzQgb2YgdGhpcyBzZXJpZXMuDQo+ID4+Pj4+DQo+ID4+Pj4+IFsxXTogW1JGQyBQQVRD
SCB2MV0gbW06IHpzd2FwOiBTdG9yZSBsYXJnZSBmb2xpb3Mgd2l0aG91dCBzcGxpdHRpbmcNCj4g
Pj4+Pj4gICAgICAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtbW0vMjAyMzEwMTkxMTA1
NDMuMzI4NDY1NC0xLQ0KPiA+Pj4+IHJ5YW4ucm9iZXJ0c0Bhcm0uY29tL1QvI3UNCj4gPj4+Pj4N
Cj4gPj4+Pj4gQWRkaXRpb25hbGx5LCB0aGVyZSBpcyBhbiBhdHRlbXB0IHRvIG1vZHVsYXJpemUg
c29tZSBvZiB0aGUNCj4gZnVuY3Rpb25hbGl0eQ0KPiA+Pj4+PiBpbiB6c3dhcF9zdG9yZSgpLCB0
byBtYWtlIGl0IG1vcmUgYW1lbmFibGUgdG8gc3VwcG9ydGluZyBhbnktb3JkZXINCj4gPj4+Pj4g
bVRIUHMuIEZvciBpbnN0YW5jZSwgdGhlIGZ1bmN0aW9uIHpzd2FwX3N0b3JlX2VudHJ5KCkgc3Rv
cmVzIGENCj4gPj4+PiB6c3dhcF9lbnRyeQ0KPiA+Pj4+PiBpbiB0aGUgeGFycmF5LiBMaWtld2lz
ZSwgenN3YXBfZGVsZXRlX3N0b3JlZF9vZmZzZXRzKCkgY2FuIGJlIHVzZWQgdG8NCj4gPj4+Pj4g
ZGVsZXRlIGFsbCBvZmZzZXRzIGNvcnJlc3BvbmRpbmcgdG8gYSBoaWdoZXIgb3JkZXIgZm9saW8g
c3RvcmVkIGluIHpzd2FwLg0KPiA+Pj4+Pg0KPiA+Pj4+DQo+ID4+Pj4gV2lsbCB0aGlzIGhhdmUg
YW55IGNvbmZsaWN0IHdpdGggbVRIUCBzd2FwIHdvcms/IEVzcGVjaWFsbHkgd2l0aCBtVEhQDQo+
ID4+Pj4gc3dhcC1pbiBhbmQgenN3YXAgd3JpdGViYWNrLg0KPiA+Pj4+DQo+ID4+Pj4gTXkgdW5k
ZXJzdGFuZGluZyBpcyBmcm9tIHpzd2FwJ3MgcGVyc3BlY3RpdmUsIHRoZSBsYXJnZSBmb2xpbyBp
cw0KPiA+Pj4+IGJyb2tlbiBhcGFydCBpbnRvIGluZGVwZW5kZW50IHN1YnBhZ2VzLCBjb3JyZWN0
PyBXaGF0IGhhcHBlbnMgd2hlbg0KPiA+PiB3ZQ0KPiA+Pj4+IGhhdmUgcGFydGlhbGx5IHdyaXR0
ZW4gYmFjayBtVEhQIChpLmUgc29tZSBzdWJwYWdlcyBhcmUgaW4genN3YXANCj4gPj4+PiBzdGls
bCwgd2hlcmVhcyBvdGhlcnMgYXJlIHdyaXR0ZW4gYmFjayB0byBzd2FwKS4gV291bGQgdGhpcw0K
PiA+Pj4+IGF1dG9tYXRpY2FsbHkgcHJldmVudCBtVEhQIHN3YXBpbj8NCj4gPj4+DQo+ID4+PiBU
aGF0IGlzIGEgZ29vZCBwb2ludC4gVG8gYmVnaW4gd2l0aCwgdGhpcyBwYXRjaC1zZXJpZXMgd291
bGQgbWFrZSB0aGUNCj4gZGVmYXVsdA0KPiA+Pj4gYmVoYXZpb3IgZm9yIG1USFAgc3dhcG91dC9z
dG9yYWdlIGFuZCBzd2FwaW4gZm9yIFpTV0FQIHRvIGJlIG9uIHBhcg0KPiA+PiB3aXRoDQo+ID4+
PiBaUkFNLiBGcm9tIHpzd2FwJ3MgcGVyc3BlY3RpdmUsIGltbyB0aGlzIGlzIGEgc2lnbmlmaWNh
bnQgc3RlcCBmb3J3YXJkDQo+ID4+IHRvd2FyZHMNCj4gPj4+IHJlYWxpemluZyBjb2xkIG1lbW9y
eSBzdG9yYWdlIHdpdGggbVRIUCBmb2xpb3MuIEhvd2V2ZXIsIGl0IGlzIG9ubHkgYQ0KPiA+PiBz
dGFydGluZw0KPiA+Pj4gcG9pbnQgdGhhdCBtYWtlcyB0aGUgYmVoYXZpb3IgdW5pZm9ybSBhY3Jv
c3MgenN3YXAvenJhbS4gSW5pdGlhbGx5LA0KPiA+PiB3b3JrbG9hZHMNCj4gPj4+IHdvdWxkIHNl
ZSBhIG9uZS10aW1lIGJlbmVmaXQgd2l0aCByZWNsYWltIGJlaW5nIGFibGUgdG8gc3dhcG91dCBt
VEhQDQo+ID4+PiBmb2xpb3Mgd2l0aG91dCBzcGxpdHRpbmcsIHRvIHpzd2FwLiBJZiB0aGUgbVRI
UHMgd2VyZSBjb2xkIG1lbW9yeSwgdGhlbg0KPiB3ZQ0KPiA+Pj4gd291bGQgaGF2ZSBkZXJpdmVk
IGxhdGVuY3kgZ2FpbnMgdG93YXJkcyBtZW1vcnkgc2F2aW5ncyAod2l0aCB6c3dhcCkuDQo+ID4+
Pg0KPiA+Pj4gSG93ZXZlciwgaWYgdGhlIG1USFAgd2VyZSBwYXJ0IG9mICJub3Qgc28gY29sZCIg
bWVtb3J5LCB0aGlzIHdvdWxkDQo+IHJlc3VsdA0KPiA+Pj4gaW4gYSBvbmUtd2F5IG1USFAgY29u
dmVyc2lvbiB0byA0SyBmb2xpb3MuIERlcGVuZGluZyBvbiB3b3JrbG9hZHMgYW5kDQo+ID4+IHRo
ZWlyDQo+ID4+PiBhY2Nlc3MgcGF0dGVybnMsIHdlIGNvdWxkIGVpdGhlciBzZWUgaW5kaXZpZHVh
bCA0SyBmb2xpb3MgYmVpbmcgc3dhcHBlZCBpbiwNCj4gPj4+IG9yIGVudGlyZSBjaHVua3MgaWYg
bm90IHRoZSBlbnRpcmUgKG9yaWdpbmFsKSBtVEhQIG5lZWRpbmcgdG8gYmUgc3dhcHBlZA0KPiBp
bi4NCj4gPj4+DQo+ID4+PiBJdCBzaG91bGQgYmUgbm90ZWQgdGhhdCB0aGlzIGlzIG1vcmUgb2Yg
YSBwZXJmb3JtYW5jZSB2cy4gY29sZCBtZW1vcnkNCj4gPj4+IHByZXNlcnZhdGlvbiB0cmFkZS1v
ZmYgdGhhdCBuZWVkcyB0byBkcml2ZSBtVEhQIHJlY2xhaW0sIHN0b3JhZ2UsIHN3YXBpbg0KPiA+
PiBhbmQNCj4gPj4+IHdyaXRlYmFjayBwb2xpY3kuIERpZmZlcmVudCB3b3JrbG9hZHMgY291bGQg
cmVxdWlyZSBkaWZmZXJlbnQgcG9saWNpZXMuDQo+ID4+IEhvd2V2ZXIsDQo+ID4+PiBldmVuIHRo
b3VnaCB0aGlzIHBhdGNoIGlzIG9ubHkgYSBzdGFydGluZyBwb2ludCwgaXQgaXMgc3RpbGwgZnVu
Y3Rpb25hbGx5DQo+IGNvcnJlY3QNCj4gPj4+IGJ5IGJlaW5nIGVxdWl2YWxlbnQgdG8genJhbS1t
VEhQLCBhbmQgY29tcGF0aWJsZSB3aXRoIHRoZSByZXN0IG9mIG1tDQo+IGFuZA0KPiA+Pj4gc3dh
cCBhcyBmYXIgYXMgbVRIUC4gQW5vdGhlciBpbXBvcnRhbnQgZnVuY3Rpb25hbGl0eS9kYXRhIGNv
bnNpc3RlbmN5DQo+ID4+IGRlY2lzaW9uDQo+ID4+PiBJIG1hZGUgaW4gdGhpcyBwYXRjaCBzZXJp
ZXMgaXMgZXJyb3IgaGFuZGxpbmcgZHVyaW5nIHpzd2FwX3N0b3JlKCkgb2YNCj4gbVRIUDoNCj4g
Pj4+IGluIGNhc2Ugb2YgYW55IGVycm9ycywgYWxsIHN3YXAgb2Zmc2V0cyBmb3IgdGhlIG1USFAg
YXJlIGRlbGV0ZWQgZnJvbSB0aGUNCj4gPj4+IHpzd2FwIHhhcnJheS96cG9vbCwgc2luY2Ugd2Ug
a25vdyB0aGF0IHRoZSBtVEhQIHdpbGwgbm93IGhhdmUgdG8gYmUNCj4gPj4gc3RvcmVkDQo+ID4+
PiBpbiB0aGUgYmFja2luZyBzd2FwIGRldmljZS4gSU9XLCBhbiBtVEhQIGlzIGVpdGhlciBlbnRp
cmVseSBzdG9yZWQgaW4NCj4genN3YXAsDQo+ID4+PiBvciBlbnRpcmVseSBub3Qgc3RvcmVkIGlu
IHpzd2FwLg0KPiA+Pj4NCj4gPj4+IFRvIGFuc3dlciB5b3VyIHF1ZXN0aW9uLCB3ZSB3b3VsZCBu
ZWVkIHRvIGNvbWUgdXAgd2l0aCB3aGF0IHRoZQ0KPiA+PiBzZW1hbnRpY3MNCj4gPj4+IHdvdWxk
IG5lZWQgdG8gYmUgZm9yIHpzd2FwIHpwb29sIHN0b3JhZ2UgZ3JhbnVsYXJpdHksIHN3YXBpbiBn
cmFudWxhcml0eSwNCj4gPj4+IHJlYWRhaGVhZCBncmFudWxhcml0eSBhbmQgd3JpdGViYWNrIHdy
dCBtVEhQIGFuZCBob3cgdGhlIG92ZXJhbGwNCj4gc3dhcA0KPiA+Pj4gc3ViLXN5c3RlbSBuZWVk
cyB0byAicHJlc2VydmUiIG1USFAgdnMuIHNwbGl0dGluZyBtVEhQIGludG8gNEsvbG93ZXItDQo+
ID4+IG9yZGVyDQo+ID4+PiBmb2xpb3MgZHVyaW5nIHN3YXBvdXQuIE9uY2Ugd2UgaGF2ZSBhIGdv
b2QgdW5kZXJzdGFuZGluZyBvZiB0aGVzZQ0KPiBwb2xpY2llcywNCj4gPj4+IHdlIGNvdWxkIGlt
cGxlbWVudCB0aGVtIGluIHpzd2FwLiBBbHRlcm5hdGVseSwgZGV2ZWxvcCBhbiBhYnN0cmFjdGlv
bg0KPiB0aGF0DQo+ID4+IGlzDQo+ID4+PiBvbmUgbGV2ZWwgYWJvdmUgenN3YXAvenJhbSBhbmQg
bWFrZXMgdGhpbmdzIGVhc2llciBhbmQgc2hhcmVhYmxlDQo+ID4+IGJldHdlZW4NCj4gPj4+IHpz
d2FwIGFuZCB6cmFtLiBCeSB0aGlzLCBJIG1lYW4gZnVuZGFtZW50YWwgYXNzdW1wdGlvbnMgc3Vj
aCBhcw0KPiA+PiBjb25zZWN1dGl2ZQ0KPiA+Pj4gc3dhcCBvZmZzZXRzIChmb3IgaW5zdGFuY2Up
LiBUbyBzb21lIGV4dGVudCwgdGhpcyBpbXBsaWVzIHRoYXQgYW4gbVRIUCBhcw0KPiBhDQo+ID4+
PiBzd2FwIGVudGl0eSBpcyBkZWZpbmVkIGJ5IGNvbnNlY3V0aXZlbmVzcyBvZiBzd2FwIG9mZnNl
dHMuIE1heWJlIHRoZQ0KPiBwb2xpY3kNCj4gPj4+IHRvIGtlZXAgbVRIUHMgaW4gdGhlIHN5c3Rl
bSBvdmVyIGV4dGVuZGVkIGR1cmF0aW9uIG1pZ2h0IGJlIHRvDQo+IGFzc2VtYmxlDQo+ID4+PiB0
aGVtIGR5bmFtaWNhbGx5IGJhc2VkIG9uIHN3YXBpbl9yZWFkYWhlYWQoKSBkZWNpc2lvbnMgKHdo
aWNoIGlzDQo+IGJhc2VkDQo+ID4+IG9uDQo+ID4+PiB3b3JrbG9hZCBhY2Nlc3MgcGF0dGVybnMp
LiBJbiBvdGhlciB3b3JkcywgbVRIUHMgY291bGQgYmUgYSB1c2VmdWwNCj4gPj4gYWJzdHJhY3Rp
b24NCj4gPj4+IHRoYXQgY2FuIGJlIHN0YXRpYyBvciBldmVuIGR5bmFtaWMgYmFzZWQgb24gd29y
a2luZyBzZXQgY2hhcmFjdGVyaXN0aWNzLA0KPiBhbmQNCj4gPj4+IGNvbGQgbWVtb3J5IHByZXNl
cnZhdGlvbi4gVGhpcyBpcyBxdWl0ZSBhIGNvbXBsZXggdG9waWMgaW1oby4NCj4gPj4+DQo+ID4+
PiBBcyB3ZSBrbm93LCBCYXJyeSBTb25nIGFuZCBDaHVhbmh1YSBIYW4gaGF2ZSBzdGFydGVkIHRo
ZSBkaXNjdXNzaW9uDQo+IG9uDQo+ID4+PiB0aGlzIGluIHRoZWlyIHpyYW0gbVRIUCBzd2FwaW4g
c2VyaWVzIFsxXS4NCj4gPj4NCj4gPj4gWWVhaCBJJ20gYSBiaXQgbW9yZSBjb25jZXJuZWQgd2l0
aCB0aGUgY29ycmVjdG5lc3MgYXNwZWN0LiBBcyBsb25nIGFzDQo+ID4+IGl0J3Mgbm90IGJ1Z2d5
LCB0aGVuIHdlIGNhbiBpbXBsZW1lbnQgbVRIUCB6c3dhcG91dCBmaXJzdCwgYW5kIGZvcmNlDQo+
ID4+IGluZGl2aWR1YWwgc3VicGFnZSAoeilzd2FwaW4gZm9yIG5vdyAoc2luY2Ugd2UgY2Fubm90
IGNvbnRyb2wNCj4gPj4gd3JpdGViYWNrIGZyb20gd3JpdGluZyBpbmRpdmlkdWFsIHN1YnBhZ2Vz
KS4NCj4gPg0KPiA+IEFic29sdXRlbHksIHRoaXMgc291bmRzIGxpa2UgdGhlIHdheSB0byBnbyEN
Cj4gPg0KPiA+Pg0KPiA+PiBXZSBjYW4gZGlzY3VzcyBzdHJhdGVneSB0byBoYXJtb25pemUgbVRI
UCwgenN3YXAgKHdpdGggd3JpdGViYWNrKSBhcw0KPiA+PiB3ZSBnbyBhbG9uZy4NCj4gPg0KPiA+
IFNvdW5kcyBncmVhdCA6KQ0KPiA+DQo+ID4+DQo+ID4+IEJUVywgSSB0aGluayB3ZSdyZSBub3Qg
Y2MtaW5nIENoZW5nbWluZz8gSXMgdGhlIGdldF9tYWludGFpbmVycyBzY3JpcHQNCj4gPj4gbm90
IHdvcmtpbmcgcHJvcGVybHkuLi4gTGV0IG1lIG1hbnVhbGx5IGFkZCBoaW0gaW4gLSBwbGVhc2Ug
aW5jbHVkZQ0KPiA+PiBoaW0gaW4gZnV0dXJlIHN1Ym1pc3Npb24gYW5kIHJlc3BvbnNlcywgYXMg
aGUgaXMgYWxzbyBhIHpzd2FwIHJldmlld2VyDQo+ID4+IDopDQo+ID4NCj4gPiBJIHRoaW5rIHdo
ZW4gSSByYW4gZ2V0X21haW50YWluZXJzLnBsLCBJIHdhcyBpbiB2Ni4xMC4gRm9yIHN1cmUsIHdp
bGwgaW5jbHVkZQ0KPiA+IENoZW5nbWluZyBpbiBmdXR1cmUgc3VibWlzc2lvbnMgYW5kIHJlc3Bv
bnNlcyA6KQ0KPiANCj4gTWF5YmUgYSBsaXR0bGUgbGF0ZSBmb3IgdGhlIHBhcnR5LCB3aWxsIHRh
a2UgYSBsb29rIEFTQVAuDQo+IEl0J3MgYW4gaW50ZXJlc3RpbmcgYW5kIGdyZWF0IHdvcmsuDQoN
ClRoYW5rcyEgQXBwcmVjaWF0ZSB5b3VyIGNvZGUgcmV2aWV3IGFuZCBzdWdnZXN0aW9ucyB0byBp
bXByb3ZlDQp0aGUgcGF0Y2hzZXQuDQoNClRoYW5rcywNCkthbmNoYW5hDQoNCj4gDQo+IFRoYW5r
cyENCj4gDQo+ID4NCj4gPj4NCj4gPj4gQWxzbyBjYy1pbmcgVXNhbWEgd2hvIGlzIGludGVyZXN0
ZWQgaW4gdGhpcyB3b3JrLg0KPiA+DQo+ID4gU291bmRzIGdyZWF0Lg0KPiA+DQo+ID4gVGhhbmtz
LA0KPiA+IEthbmNoYW5hDQo+ID4NCj4gPj4NCj4gPj4+DQo+ID4+PiBbMV0gaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvYWxsLzIwMjQwODIxMDc0NTQxLjUxNjI0OS0zLQ0KPiA+PiBoYW5jaHVhbmh1
YUBvcHBvLmNvbS9ULyN1DQo+ID4+Pg0KPiA+Pj4gVGhhbmtzLA0KPiA+Pj4gS2FuY2hhbmENCg==

