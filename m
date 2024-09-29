Return-Path: <linux-kernel+bounces-343180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2BB989787
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 23:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A44011F21681
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 21:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39405464B;
	Sun, 29 Sep 2024 21:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MOkaCefp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664908F6D
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 21:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727643701; cv=fail; b=BV2rkitR15XCn9Cs3hDDBA45GCjWeHVHmhyYJlZE3yxJRpl6DCCRyH5YpH8RF4tX7qSchSVcfhgDa62m0eS3fqf9K3utIaLsvQaQgtDsNyLFSVgUjkPtGNwrwNjiy5E0soMCw8PrRTYnF7C1Pzhp1zcvA/NccAUTekoHw7U96uA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727643701; c=relaxed/simple;
	bh=Y5hzMf6DvrI33Fx5s83BDjFKs2W/iFznXCUGpjqvBpk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V4EkAm5oDn0llK3O18m8Z8woKzA79Un1FnI7Cqn6SUdjyWwFxq9UffFKD7LvyCM9mGK9gX7oufk+nkf8OVFH4RY/ZEoXf18BUL9IisIBIuGptk19sk4e6xpOLrwYNxkPbLjY+NOF0vlEEEVIj+2eRUNtElRZBMWCJAZV1whoIHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MOkaCefp; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727643699; x=1759179699;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Y5hzMf6DvrI33Fx5s83BDjFKs2W/iFznXCUGpjqvBpk=;
  b=MOkaCefp05RjQ4liirYlLnXWjKfwhkzKcp4TFLFGn3QwsrnSTP44GVQu
   aODg6a3s2VTS57hS5DP+h5YyVk3CRgIFQqYUkNvbjZmCWLhMs19vWD+hY
   oozaDYb2Q/RRhsb+4LYiY6ba5Mbf2Gr0U0YkHHeLEGu8qZKXHg9pSZl/e
   wq06qMuK2jD+F4f8LU0QUXXX2DgunTuNkMPmpkIGPclWFhBUVn/Mllt9R
   3zKso8L0u7ZeREAif4V/f1O1jxNhxXQ1tUa4Vo395k7Jxa4RGg+9TwBSG
   GbjuNxyUZjZjSUvXATJ1O1iGzIJdqKx8t2gQo0BEzRhx/OV+6PkT95XwE
   w==;
X-CSE-ConnectionGUID: 5OwGw/v8TwKkwAj+FrJilg==
X-CSE-MsgGUID: 9tEnBWxGRm+Bh0c4wUDjvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="26898775"
X-IronPort-AV: E=Sophos;i="6.11,164,1725346800"; 
   d="scan'208";a="26898775"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2024 14:01:39 -0700
X-CSE-ConnectionGUID: TNdKZ3j5TySn6FJY3UnfrA==
X-CSE-MsgGUID: GCeiRi4pSRq+aF8cygGecA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,164,1725346800"; 
   d="scan'208";a="103887981"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Sep 2024 14:01:38 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 29 Sep 2024 14:01:37 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 29 Sep 2024 14:01:37 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 29 Sep 2024 14:01:37 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 29 Sep 2024 14:01:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rEgD3cROVt6ZFp1xYB5M2owSp/QO+kmbSzEwWnIHGtpmmvSR60bwAKOdZDJv8cxx/vXT+xELqu37idr6l8dDMApTY0laiyeelPME8Y0vAha7+MoKsb62Fm5Rh2Ms35Ykr1S9w1n++z0y4A7i/L2PZjU4Agvh1Cvg45qw0mT8Q6s+nLOaXWgWFE8tsSO3CNkeyjX3zJ+d9yTpXi440AmuwcyG0bgmYLlt5APhu3wNpKVMSnENI1+C3ii9ZvfWCHU9q/a4mhZlx+cn/QwLU+NmEeDoF/SnnXfuJzVB/Zi/pttF0bKUm5l40NVAKbsg0jxFqujU6H8ZqGylOhpfm8oGAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y5hzMf6DvrI33Fx5s83BDjFKs2W/iFznXCUGpjqvBpk=;
 b=zQQLh76H6Su/xrIb9avQjpvUufSeBghA41bfiRjKDtSTh2V6RArSzKsBy9RXO9LxisMkQYUkREgRRudSsPhD3GOaZatc8TRElhUtCzkf3KTFQ6UGDqvfaEoDwea1yW2eADaycdH30N/uBgM+AF5Haji+iNS+z7sF1P+xR2LfVjLc6q89l69F0ujLMbjRnnQcd5C32ebhrRIR8kOwJ91PJJuntpUImekH+kvAuX5WDcuCsmP3Okp+KIB7gnnFF+G8WHO1qHZ/viuPYX1nKUzjbeIu8tn/HM1cqKRrvskfpdzVM/7p3fV9RL4k4q/fpA4blU3zNWQsVNhwcj9Fq9Upgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by SA1PR11MB6967.namprd11.prod.outlook.com (2603:10b6:806:2bb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.25; Sun, 29 Sep
 2024 21:01:33 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.8005.024; Sun, 29 Sep 2024
 21:01:33 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Chengming Zhou <chengming.zhou@linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>, "yosryahmed@google.com"
	<yosryahmed@google.com>, "nphamcs@gmail.com" <nphamcs@gmail.com>,
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "shakeel.butt@linux.dev"
	<shakeel.butt@linux.dev>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"Huang, Ying" <ying.huang@intel.com>, "21cnbao@gmail.com"
	<21cnbao@gmail.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
CC: "Zou, Nanhai" <nanhai.zou@intel.com>, "Feghali, Wajdi K"
	<wajdi.k.feghali@intel.com>, "Gopal, Vinodh" <vinodh.gopal@intel.com>
Subject: RE: [PATCH v8 3/8] mm: zswap: Rename zswap_pool_get() to
 zswap_pool_tryget().
Thread-Topic: [PATCH v8 3/8] mm: zswap: Rename zswap_pool_get() to
 zswap_pool_tryget().
Thread-Index: AQHbEUxt5l9qSZEa6Uizot/zI8AqFrJssCaAgAKSkqA=
Date: Sun, 29 Sep 2024 21:01:33 +0000
Message-ID: <SJ0PR11MB567818DBFC0674C163BBF8B1C9752@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20240928021620.8369-1-kanchana.p.sridhar@intel.com>
 <20240928021620.8369-4-kanchana.p.sridhar@intel.com>
 <2c9d403f-188b-4f15-93d7-36224ef31329@linux.dev>
In-Reply-To: <2c9d403f-188b-4f15-93d7-36224ef31329@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|SA1PR11MB6967:EE_
x-ms-office365-filtering-correlation-id: 3e4967d7-1ecc-466b-ce2c-08dce0c9e63d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VDhSNXRRaklaOS91V0dIMjZicHFXMUNiV3p2d3NPNkhqYlo0OFBETzAxWnl0?=
 =?utf-8?B?bFVIdEt6QW5zdHh1RWRTVDl4NFZ1Mk5UeTVCNHc1N3prZXhqeGJFQWhoNG5m?=
 =?utf-8?B?ai9hMHBzOUdMVjNMdHZoS0xEOTlXTW82WHpuL3NFU0FQVTFmeW9tR21uZzNP?=
 =?utf-8?B?OWJCdlowY3pWbGYwUmQ5Y3lXaDVRZHhsTkJzYXVHaHJ1b1ZycDhRUzZZY0RB?=
 =?utf-8?B?dGNNckZVUlhtNHRyaFF3cDN4bEtqdXNzcW1qQXFCUVRVVm5OZ0ZrODd2NVls?=
 =?utf-8?B?cDUzZTNILy85b0Y0TXhobVFtRzZzdVJuRVlURWtLQ3VLdTlZZmk2bUtsM25h?=
 =?utf-8?B?VmNJVno3NHVENUp2UDdzb1o2MXhnVUNHNlJtVUkvTzFiRHBJUkl6ZFpMQVhz?=
 =?utf-8?B?WUtCS2xKNm9SNGg3S3dSQU5hQTYwdklmQUlCVUtFYWJVZGQ0S0daTXIxYUJw?=
 =?utf-8?B?ZHAvL3JWTnlmTjJPRnBFOFB4dGRPazNVUmJENHNrZlN3a1huTG9WSE9GL0k2?=
 =?utf-8?B?a2FpZkcrWldwT3pKSDkzU0tzVWMrRWxVWmp6VEwzNTN4RDJXZmd1bWhqNlRI?=
 =?utf-8?B?VFdmdEx6UmFqK0NpeVJEY2xCckFDbGt3SjlEOXFrV0N0L04yeU9QVHpha3dP?=
 =?utf-8?B?emxZc1VMd1laVm52aTFXWFpNNWVWaUdtN0UzSWs1R1ZkTU80RE5zQWx5Ujll?=
 =?utf-8?B?S2l1QWdYWnErR0FWNVNLUnMzNS9rYksrOEMvakJGMGJNNVR6RGNvZEVweG5L?=
 =?utf-8?B?THNCeWRqT0FLU25FT1ZzRzJpTUppMzZEODVhdG9ickZkeUcwQlY1ZDRwNis1?=
 =?utf-8?B?RmpaRWRsVTlRaTVhTElRTkUwOEVROE5UdjlLQUNvLzg2dVV6eTBtMnRxM0hq?=
 =?utf-8?B?RjIzN3ZMTE0yZ2xnMUhndmZ6QlBiVUt2QkRXVEcrZnhGYWRXYU95YmZnYjRi?=
 =?utf-8?B?SEtKK1NzNko2Yi80V3NGdW52WW9HWWJpK2NOR0ZCbVNJdW16ZFdHMG9naGdU?=
 =?utf-8?B?eitCdFBMRUEvT3FJNU9mb0srUXU1MFBDK2tiL1A5NmczUk1KR3FaOUxLODND?=
 =?utf-8?B?eFllN1BvYm5nREdJZ3YrWmttUzRiV1dRL3V3OG9wbStoVVc4V1JsS056NjZr?=
 =?utf-8?B?NmNHanpLQ2FDTDhFaThYWW83c2dySnFGYXVtTDVSNWF4b3NrQzZMdGRkeEpq?=
 =?utf-8?B?SVlBNllIQ1lFV1RrbHF2THJYTHpRRmN4N1lCbEVFcWxFRGNSOStLSmZrWDY4?=
 =?utf-8?B?dWtpTHlCVVBna1RvSWRTRUJUaGJKMlJDUXBEeFNaVktrV1djS0NLWnA1Q3JC?=
 =?utf-8?B?WFhmLzZmclBwZUpZUS9JSjNsQ1VqeVFnYkNkTGQ5cHRMMS9nRG0xd2hlcE8w?=
 =?utf-8?B?Tjk1eVF0ZUQrYXE2dGNqTzcrYm9tT2hlNVA1OUtsNkJWa0M1cjRLd01FRWRx?=
 =?utf-8?B?SEduRXRpd3NrcVBWVmNIQjNiM0FsMG95ME9GQXRCOVRmNnpQYURuMWJiMThT?=
 =?utf-8?B?eVUwZnVHR2ZwVEJDQ0F1dEo2MllsKzBVdmwxS0NJQ1pMbnVyTXIwVjlDbUJo?=
 =?utf-8?B?cm5xcTdnSUl4ZnRiS1pnRk9PRjVPSFd6S0Q3c04vSGZkaVlFVS9reDRLU1RS?=
 =?utf-8?B?S254RmJrK1dGcEZQVHFMMWZIajBRaGRYSncrMWJpM1dKYWZqeFRBT0dsaDRE?=
 =?utf-8?B?RDRkOUw1WWRTbitMaFAvSGFCS3c3ZHpkNml3ZEkrUE9nb1NxRWVib2daemU2?=
 =?utf-8?B?eFJCNlFxc3k1ZVVOdFNWSGZwMmF6ZmNnaXBYbkQ2eThSZUpJTjdYcGZtejZY?=
 =?utf-8?Q?baNdjhquk18PjXtXSAEIHK9QG9w9CKNQ4qkjY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmdJZzYwUFFSUHBZZXcrREIvM3FmMzI5aTA2TEx4ZDVIU3hOVkRhQlZzZTlP?=
 =?utf-8?B?RmlJZ0FsVzJ5ajduVEdENnVQN3hPbTAwSytvQ01MQWNCZGpQRzRQSEw0VExB?=
 =?utf-8?B?Q0FGVGtzbldEYnI0SGc1UE9NMEh3T0Fhb2Z3ZVg3R1kxMGgzMHUwOGh5NENW?=
 =?utf-8?B?WEZsNVhmY3prNTU2VWtmT3Z1RTBSamNvRE9Kc1J2NFl1bVdwUUZaSGJ0bVg1?=
 =?utf-8?B?RGd0Y1R2NnJJRXRHTEFuSERVTGJJS3dqK3cvYzEvNXByL2pTNDE1VnFGalFv?=
 =?utf-8?B?dmowSjdhSU5lYTA4VkJlZTNVNXcvcjN4R0F4OTBFMFFoTkNmbmFRQWNobFQr?=
 =?utf-8?B?RUFnbDVpenlMSHFFNmlNMHFIWFlPMlFBV01jdm9vYzJjYVA0eWVId29WOVZ3?=
 =?utf-8?B?M3M4T0JlcFdSelFlMDVTMkM3TFZKZ0EzcGpXUGU1cm5EYWpOQk9CM1RFNC9o?=
 =?utf-8?B?eE1kUjJtL0dHZ2szelRFTng2bmlFOFdaaDFXL1ZoV3ZiSUdBNjZnaWlPSWFu?=
 =?utf-8?B?b0phdkpwby91bUdWbGtGZlRJeit3YlkwbVJLek1BZ2MyWnQxdUtObXJ4YUZ0?=
 =?utf-8?B?dkJRR01lTU5Xa1VTTEpQVk9IN1M1U1dFWHRpc2VRN3VMaU9GM2ora2lmVWdO?=
 =?utf-8?B?TXFNTWlEUkUwN2htb2ovY1JSMEFldkxydmNvQUVDSjVpM3ZIbm40dndwTTV3?=
 =?utf-8?B?UzNpV1Vnd3NtY3BBVFNRZTRsWnRoNjFQeEU3VnVwNWk4Sm5WM1hUa1d3b01Z?=
 =?utf-8?B?czhGQ3NoZlBnN3ZxZ3pUY21IcVd3U3o1VXBEVDVQZFpWbWJZOU8raXpBU1JU?=
 =?utf-8?B?U0pxT2tDMnB4NE5SbWhqV01UVENVK2RBOUdHRng2OStOeVJ1alN2ZytFV1Fz?=
 =?utf-8?B?bUhWOUl5WlBPSHhNNEQxbVNoT1RzOUhEcm1EN0kyK3FUNlgvMjdDVzFNdzJH?=
 =?utf-8?B?VWQ2bWgzNk4wbmdKSDZyZnRHSnV5cTh4K0lQc1hrYTFXNVVXVUJtaUNycGZ2?=
 =?utf-8?B?d1ZONXVVaml2LytQRHAyVHp3ajhPZmV5QnlqUldyc2dnY0NIQ2QzdG5LbjBX?=
 =?utf-8?B?V2p0TjVOU0RMU0IzeXZBdHBNaG1jblM5WW56U2lNU2dGalRyUVhMcHZYMmRm?=
 =?utf-8?B?V1lHRHUrUk5jZk9Ldzh2TUt6aFhkaWhGN25vdVdFa2RLZmRXcm1zR0hMR2dl?=
 =?utf-8?B?NStSVGlKbzk4NGdONGM3OGVTcUlSUmQ2b0tLbFVSRGgvSytDOHV0azEwdjdD?=
 =?utf-8?B?K3pNejJpMlJrbDB5Yk5EYUZEUFVhVUFhWVNudm5zanpTeEdxOGFHVHB4UWh1?=
 =?utf-8?B?RFFGRkdKbFFqRUQwUis4RThkMUZURTBKZjZOVTZGOXdWTEdDWm83UktLaW9T?=
 =?utf-8?B?Ny9IZXlVOHdmdmw4b0t5NmdzL1ROTHZxblFrMGxJZXNmdXh6aWpYRHhFWGFl?=
 =?utf-8?B?Vkl6VTJXaGJmWVZ4bkxqRExDS2I1cXl4T1ovenRUN0QvU29MQ2dlQ1BFZ0RC?=
 =?utf-8?B?TVRWaUtUNHVYLytxWEtBMzZWcW5SaWJ0QWQ1a2pUNExoZ2EvWjRvK0tlTTg5?=
 =?utf-8?B?WlRaOGRQeWJpUWlPbzFSQm85MlI2QXhFRDNrTFFUREhObWdIamF5YUxsVWxO?=
 =?utf-8?B?U3BkQml5MmdvTnQxd3dYaE9Uci9hY2RqTmR6UW9OQjdpV0FSQ093MlZIYnZC?=
 =?utf-8?B?aDlIQ2owSlJNYWZYVUtsS3pxdTRHcXVwMi9FTldoUXRrWGZralpnZFU3Yk5Y?=
 =?utf-8?B?SjBSNVViSkNFNGsrZGJEZlh6WkNLOGxIYXAwYWJUS0tnZUc4aGJjdlFGV1lN?=
 =?utf-8?B?QlJaS20xcU5HQ2Z1TFlneVdWRzN2eUFRdzV6L2ZZeFViLy80SE1MREN3ZHFQ?=
 =?utf-8?B?NHM2NW5reVMwYUdNOXFkMjJoNVJlZnhVSEtuTDcxZ0hqWWVLZUlQWVZYSjNw?=
 =?utf-8?B?THRtMFY4UE5kQ2JIVVF1SDBhbVl2U3FFYmFvaUF1U2xKbEZnQ3dreXgwanBz?=
 =?utf-8?B?a2tGKytua21nTU5nQ0x5SDRCSG9BQ25CdkF1UFdxemF3enBldUlGem8weFR6?=
 =?utf-8?B?SFZnNlN6WXdQQnI4clpJS3RoUnBUK1l1TzdQT045TGk1YUNxYXFOZHlJYjEz?=
 =?utf-8?B?Z2ozQm8zRm5XQnFvdnRNN2F0QysyYzBOTkZhUFJtK2dacE96djI4a3l3bGsw?=
 =?utf-8?B?a3c9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e4967d7-1ecc-466b-ce2c-08dce0c9e63d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2024 21:01:33.5022
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9APgVTDEg077mtfF5bzTxbkie8ccGU5WzXNsCkS6EGwfPHQM7eqm6xrLP4DS+47nkujPYzsl6dtqA0fZRJC92kLT9In74LnyNDoBgmaMklk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6967
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDaGVuZ21pbmcgWmhvdSA8Y2hl
bmdtaW5nLnpob3VAbGludXguZGV2Pg0KPiBTZW50OiBGcmlkYXksIFNlcHRlbWJlciAyNywgMjAy
NCAxMDo0NCBQTQ0KPiBUbzogU3JpZGhhciwgS2FuY2hhbmEgUCA8a2FuY2hhbmEucC5zcmlkaGFy
QGludGVsLmNvbT47IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1tbUBr
dmFjay5vcmc7IGhhbm5lc0BjbXB4Y2hnLm9yZzsNCj4geW9zcnlhaG1lZEBnb29nbGUuY29tOyBu
cGhhbWNzQGdtYWlsLmNvbTsgdXNhbWFhcmlmNjQyQGdtYWlsLmNvbTsNCj4gc2hha2VlbC5idXR0
QGxpbnV4LmRldjsgcnlhbi5yb2JlcnRzQGFybS5jb207IEh1YW5nLCBZaW5nDQo+IDx5aW5nLmh1
YW5nQGludGVsLmNvbT47IDIxY25iYW9AZ21haWwuY29tOyBha3BtQGxpbnV4LWZvdW5kYXRpb24u
b3JnDQo+IENjOiBab3UsIE5hbmhhaSA8bmFuaGFpLnpvdUBpbnRlbC5jb20+OyBGZWdoYWxpLCBX
YWpkaSBLDQo+IDx3YWpkaS5rLmZlZ2hhbGlAaW50ZWwuY29tPjsgR29wYWwsIFZpbm9kaCA8dmlu
b2RoLmdvcGFsQGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2OCAzLzhdIG1tOiB6
c3dhcDogUmVuYW1lIHpzd2FwX3Bvb2xfZ2V0KCkgdG8NCj4genN3YXBfcG9vbF90cnlnZXQoKS4N
Cj4gDQo+IE9uIDIwMjQvOS8yOCAxMDoxNiwgS2FuY2hhbmEgUCBTcmlkaGFyIHdyb3RlOg0KPiA+
IE1vZGlmeSB0aGUgbmFtZSBvZiB0aGUgZXhpc3RpbmcgenN3YXBfcG9vbF9nZXQoKSB0byB6c3dh
cF9wb29sX3RyeWdldCgpDQo+ID4gdG8gYmUgcmVwcmVzZW50YXRpdmUgb2YgdGhlIGNhbGwgaXQg
bWFrZXMgdG8gcGVyY3B1X3JlZl90cnlnZXQoKS4NCj4gPiBBIHN1YnNlcXVlbnQgcGF0Y2ggd2ls
bCBpbnRyb2R1Y2UgYSBuZXcgenN3YXBfcG9vbF9nZXQoKSB0aGF0IGNhbGxzDQo+ID4gcGVyY3B1
X3JlZl9nZXQoKS4NCj4gPg0KPiA+IFRoZSBpbnRlbnQgYmVoaW5kIHRoaXMgY2hhbmdlIGlzIGZv
ciBoaWdoZXIgbGV2ZWwgenN3YXAgQVBJIHN1Y2ggYXMNCj4gPiB6c3dhcF9zdG9yZSgpIHRvIGNh
bGwgenN3YXBfcG9vbF90cnlnZXQoKSB0byBjaGVjayB1cGZyb250IGlmIHRoZSBwb29sJ3MNCj4g
PiByZWZjb3VudCBpcyAiMCIgKHdoaWNoIG1lYW5zIGl0IGNvdWxkIGJlIGdldHRpbmcgZGVzdHJv
eWVkKSBhbmQgdG8gaGFuZGxlDQo+ID4gdGhpcyBhcyBhbiBlcnJvciBjb25kaXRpb24uIHpzd2Fw
X3N0b3JlKCkgd291bGQgcHJvY2VlZCBvbmx5IGlmDQo+ID4genN3YXBfcG9vbF90cnlnZXQoKSBy
ZXR1cm5zIHN1Y2Nlc3MsIGFuZCBhbnkgYWRkaXRpb25hbCBwb29sIHJlZmNvdW50cyB0aGF0DQo+
ID4gbmVlZCB0byBiZSBvYnRhaW5lZCBmb3IgY29tcHJlc3Npbmcgc3ViLXBhZ2VzIGluIGEgbGFy
Z2UgZm9saW8gY291bGQgc2ltcGx5DQo+ID4gY2FsbCB6c3dhcF9wb29sX2dldCgpLg0KPiA+DQo+
ID4gU2lnbmVkLW9mZi1ieTogS2FuY2hhbmEgUCBTcmlkaGFyIDxrYW5jaGFuYS5wLnNyaWRoYXJA
aW50ZWwuY29tPg0KPiANCj4gUmV2aWV3ZWQtYnk6IENoZW5nbWluZyBaaG91IDxjaGVuZ21pbmcu
emhvdUBsaW51eC5kZXY+DQoNClRoYW5rcyBDaGVuZ21pbmchDQoNClRoYW5rcywNCkthbmNoYW5h
DQoNCj4gDQo+ID4gLS0tDQo+ID4gICBtbS96c3dhcC5jIHwgNiArKystLS0NCj4gPiAgIDEgZmls
ZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZm
IC0tZ2l0IGEvbW0venN3YXAuYyBiL21tL3pzd2FwLmMNCj4gPiBpbmRleCBmZDdhOGMxNDQ1N2Eu
LjBmMjgxZTUwYTAzNCAxMDA2NDQNCj4gPiAtLS0gYS9tbS96c3dhcC5jDQo+ID4gKysrIGIvbW0v
enN3YXAuYw0KPiA+IEBAIC00MDMsNyArNDAzLDcgQEAgc3RhdGljIHZvaWQgX196c3dhcF9wb29s
X2VtcHR5KHN0cnVjdCBwZXJjcHVfcmVmDQo+ICpyZWYpDQo+ID4gICAJc3Bpbl91bmxvY2tfYmgo
Jnpzd2FwX3Bvb2xzX2xvY2spOw0KPiA+ICAgfQ0KPiA+DQo+ID4gLXN0YXRpYyBpbnQgX19tdXN0
X2NoZWNrIHpzd2FwX3Bvb2xfZ2V0KHN0cnVjdCB6c3dhcF9wb29sICpwb29sKQ0KPiA+ICtzdGF0
aWMgaW50IF9fbXVzdF9jaGVjayB6c3dhcF9wb29sX3RyeWdldChzdHJ1Y3QgenN3YXBfcG9vbCAq
cG9vbCkNCj4gPiAgIHsNCj4gPiAgIAlpZiAoIXBvb2wpDQo+ID4gICAJCXJldHVybiAwOw0KPiA+
IEBAIC00NDEsNyArNDQxLDcgQEAgc3RhdGljIHN0cnVjdCB6c3dhcF9wb29sDQo+ICp6c3dhcF9w
b29sX2N1cnJlbnRfZ2V0KHZvaWQpDQo+ID4gICAJcmN1X3JlYWRfbG9jaygpOw0KPiA+DQo+ID4g
ICAJcG9vbCA9IF9fenN3YXBfcG9vbF9jdXJyZW50KCk7DQo+ID4gLQlpZiAoIXpzd2FwX3Bvb2xf
Z2V0KHBvb2wpKQ0KPiA+ICsJaWYgKCF6c3dhcF9wb29sX3RyeWdldChwb29sKSkNCj4gPiAgIAkJ
cG9vbCA9IE5VTEw7DQo+ID4NCj4gPiAgIAlyY3VfcmVhZF91bmxvY2soKTsNCj4gPiBAQCAtNDYy
LDcgKzQ2Miw3IEBAIHN0YXRpYyBzdHJ1Y3QgenN3YXBfcG9vbA0KPiAqenN3YXBfcG9vbF9maW5k
X2dldChjaGFyICp0eXBlLCBjaGFyICpjb21wcmVzc29yKQ0KPiA+ICAgCQlpZiAoc3RyY21wKHpw
b29sX2dldF90eXBlKHBvb2wtPnpwb29sKSwgdHlwZSkpDQo+ID4gICAJCQljb250aW51ZTsNCj4g
PiAgIAkJLyogaWYgd2UgY2FuJ3QgZ2V0IGl0LCBpdCdzIGFib3V0IHRvIGJlIGRlc3Ryb3llZCAq
Lw0KPiA+IC0JCWlmICghenN3YXBfcG9vbF9nZXQocG9vbCkpDQo+ID4gKwkJaWYgKCF6c3dhcF9w
b29sX3RyeWdldChwb29sKSkNCj4gPiAgIAkJCWNvbnRpbnVlOw0KPiA+ICAgCQlyZXR1cm4gcG9v
bDsNCj4gPiAgIAl9DQo=

