Return-Path: <linux-kernel+bounces-337604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3E8984C3F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 22:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCD9B1C22B97
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 20:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FCD13B783;
	Tue, 24 Sep 2024 20:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="giGcHs08"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6DF1386C6
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 20:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727210468; cv=fail; b=biyijuMsDVvrif7odEADv8A6IiuoXTMSzUoV86nBP/mkcMSHD5KeHIeD4GcE/N/E9agZtmW1q5go2W8i19e1I2tLwvYWVcVxbFPLs0cganjiKedBEaCHg1n+jud46O7rBrqEz0mlRMitXMInbviZtXzBBQ9AEBJn8atYCuHJFlE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727210468; c=relaxed/simple;
	bh=OYbvjxwczIPV0DwggDjkq/DkboTztGKcFPOFnCtTURM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=opJKcFWhe8Oa6BrLj//6JuVUJQqgmcnh4xPDeqVX2PAzjSJC3ef7eRA//qx+kfIuYqdXIdnPYs480UGMYe2sIxxbVjnwVLkUaljV8Kdu608Hdsd62mmMg+n3Bi53QOC0/maFo/JbWOKjYq1m2IyBmogztOaOBurr2e4rlBfCiT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=giGcHs08; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727210466; x=1758746466;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OYbvjxwczIPV0DwggDjkq/DkboTztGKcFPOFnCtTURM=;
  b=giGcHs08Ec2OiRXA4ed7e8NfrkmsuDTxnIbLxNbZVnZuHG7DGG5PvmUl
   1aDiChBYS6wzQDUTOCh2rvgvfn1KJCLI+GBE8zelEHyc4t8t29O7VzEFw
   rHC5ur42r8Vw8rUWBX2oEPfBFeqvi6DzAS9mp5UL1sKCA4S2E66UY81mB
   rMqfK/S/U9Radp0NyCOci8v/KM/9fOhxqpxp6UsAI74ftlAP3KCau9DW+
   qs++l012//fnPuOl/99ibHHfy7ST4eJx4p2brwlhDBwFHDK5s3oShZbef
   3cCsHinbiQc22gLDlYo2Ey2/uRhCOZQ7aVrzQ7YwVdUz9I1zpgFEb4ngB
   A==;
X-CSE-ConnectionGUID: yE87/egeSjuPj43s3sLQvg==
X-CSE-MsgGUID: ac1XQtdUSiiHWCPCyzo2eQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="26051527"
X-IronPort-AV: E=Sophos;i="6.10,255,1719903600"; 
   d="scan'208";a="26051527"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 13:41:03 -0700
X-CSE-ConnectionGUID: LNMVSVGjTdmdj3tDoOsvcQ==
X-CSE-MsgGUID: bbA+qSv9Q0yZlNuerX7RvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,255,1719903600"; 
   d="scan'208";a="76469327"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Sep 2024 13:41:02 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 24 Sep 2024 13:41:02 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 24 Sep 2024 13:41:02 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 24 Sep 2024 13:41:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kUNnrI4DF/WllrbOyy5fjwHExSumjJCSllIuQ2Qo47uwKltfFvIJQVyFoUJcmbe7eBAgrS2SdCeyBwqCJ00x5QaZ5zHcZsWoz5tewNQCB5wLbKIqp8UEiYp2pQ0MF7fFhK8RPfQcAxCMH7Lf0Xx/MDd7uVtUPA5WsSd4aU6Jec1gIvIBjv1NQWdUPIdrwa2l3lsa/7J1Bc3XcITzvIUxrlHxQSJllnps0yqXvrbnNtgoLiMctuOfgXR1+h78/ndv+T4vG+BhOt4F+CeTZGUH3WFFh6BRMxlT8isdljFV5wAxaIfOGGPgTpj8aviIQH+vPpptrsJNnOQMlttvnAERzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OYbvjxwczIPV0DwggDjkq/DkboTztGKcFPOFnCtTURM=;
 b=WwM4UEZfJoyQvqo+z+ekB/WeJKQpEjC1Cwive9MgKGzxJ+Ymv3CnP0dRX4A2EmUPp3HCPh8mDCofLDSi2tL+bVw/3kzAfgQc4RqMj6xgQRgpcfRQdhQhaYZbA0KE8glGH8Fslij/bvUEii7RUoQBmLkml4rmKBTzUO8/DTLsygBW6vvbmuS14Fo212yCsSCPBr0le3bESKIp/FniVKXAZmQvH2Z0+6vJ+xiCt2ie0E70u2N3QZJIf8cbc+ZL2AKAsJkMoAHurF+KpBsoqIB0UVOcjHYlKV39YnC6zY3ZzEOe/CJKkPE+p3YmLCMSyH+U4Ro5q/XO6fYjVplQqYIILQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by PH7PR11MB5941.namprd11.prod.outlook.com (2603:10b6:510:13d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.26; Tue, 24 Sep
 2024 20:40:59 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 20:40:59 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Nhat Pham <nphamcs@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "yosryahmed@google.com" <yosryahmed@google.com>,
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
Thread-Index: AQHbDh+An/NTejqrB0+b0E4zOcMAu7JnLsKAgAA41JA=
Date: Tue, 24 Sep 2024 20:40:59 +0000
Message-ID: <SJ0PR11MB5678A3A7BF6C781C46F3DB20C9682@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20240924011709.7037-1-kanchana.p.sridhar@intel.com>
 <20240924011709.7037-4-kanchana.p.sridhar@intel.com>
 <CAKEwX=ML+8uPUm7fMRKJcvqrctH9qf0tYha0TLr0JxzFSZ-z0w@mail.gmail.com>
In-Reply-To: <CAKEwX=ML+8uPUm7fMRKJcvqrctH9qf0tYha0TLr0JxzFSZ-z0w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|PH7PR11MB5941:EE_
x-ms-office365-filtering-correlation-id: f18166a1-6c43-429c-f7cd-08dcdcd9328b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?V1pMSjUxWExzRUtEcTQ3VFNKZ3p1YUhsaTk0bEhGNXRzeXp6WGk1bnhIRFpv?=
 =?utf-8?B?b3FlbnkyU2lYeUNjbTBseUtwT0VsWVJkelFvdEp4UEdlVzd3bkQrajJjM3gx?=
 =?utf-8?B?Z0F1TjhHUktYS1J6RURPNURsTnpPMFNJK0NRdDJjMCtUNnprUXlsc0VTd09S?=
 =?utf-8?B?WjhTS1F2amhBZVZLZXcydEU1TGNBNXN0c0x1WVFCRDhpMm4xSE1TNDBIT0VZ?=
 =?utf-8?B?Mklxa1hjZkxqM0F6dCtnSUVpZnRpcUFqVnBLNUptQ1piY3NUTVIzVGVCWHdE?=
 =?utf-8?B?RlZZeElINzdsUVZOZkVBYlltMFVNWG1Ic2ZQWnVIMzBWVXdCNFJOUmRjZjJr?=
 =?utf-8?B?d2p2VC9DMjdrMWxVMURldXR3K3I5YzMxWm16THNNNEQvMXVsVHhtT0R0VEUz?=
 =?utf-8?B?ZFZGaWh1ODIxM2ZRL3luaG1ydXNtV3dkeXY2VktUVEVyTEFMWmMzQStsNWQ3?=
 =?utf-8?B?MDhVN0s5VVRwSWRHVnlwMjloQUxDNzFtWmhzWnRKTEpvNm9UbEpQWWhlbVZi?=
 =?utf-8?B?NE9tQ0dSVGRtMXBDb3hyOTM3bGlqMG16ZE1YUWNVeXFhbW80UDZXU2hhdG5E?=
 =?utf-8?B?R0R6Zy9vaHh2ZlA3Y0xiVjBHYitqRitXQnZFdm04Tnd1YmNjQW9MR0RybVIr?=
 =?utf-8?B?UHQvcXgxdDJHZi9kcGQvMkg5K1RDWFIwcGtMb0xXSE5PdnlNaGpPM05qR0ov?=
 =?utf-8?B?cm9GczVkdGdxN3VkVXhuUklTQkQ0czIxcVZ3M0s5SVhWTy9HdDkvRk9aK0lK?=
 =?utf-8?B?TUxtR0Y4M0VIanpuN01BdVd1em1nMDJtZWY5OU9Kck83VncrTUpwUVZRc1BJ?=
 =?utf-8?B?Qlp6TlA5NTdZaTNRREgvbUUwY3B2VnQ1cWx2ajZWdzFMZzkvMlRrTmwrR3E4?=
 =?utf-8?B?UFV4QndYOVp3YzZ3TENMcVVWSEw2My85Q0lUczJhQ2tCdG10MUxiMUJrK3Bo?=
 =?utf-8?B?Zkhxd2hlVm00OEV4TS9HcDBzQzEwMGlvWC9jekt6Z0laWnBkUWNNZk1uRmpt?=
 =?utf-8?B?V0NYSlBFVllGUmJCMXM0N1pBZkpxOEgzOCtUWFdwWUlGS0lrUVM5Zmx4WW1O?=
 =?utf-8?B?QXRCY05nNk1VTnAwWHE4Rys4SnMveGhtd3pxaWRDUnBpL2ZFZ1JKbmRwSGFh?=
 =?utf-8?B?R04vaGhveHpHUVlsSjRDMzBnQ0hzQjltY3M4NXJYUHhTTTNLQ0lOeGp3UUVY?=
 =?utf-8?B?Nm5jUDhPUjdEeVdxTS94b2J2VHNXMEtES3R0dkRrMllQZmI3SUZGT1huNWdl?=
 =?utf-8?B?dEgwZHlVbGlRM1YvSHp6eWlVWDJzaWRMODFSTk0xbVA0UWR3MWZ6Si95L3ds?=
 =?utf-8?B?MDJTUDFmeld2T0djZXF2d0NyNG9IMU9BakpDdkhUcTYyeGlvMENGYzdiRUwy?=
 =?utf-8?B?YVpab29RN3ZxNVFGMjNpMHNqOVJlVnZTZFVVYStSWVZLL0ZLSTFMOFliWUQ2?=
 =?utf-8?B?anJ5WHFybVhOdEtOTHBvbUtYVVVKdkNOZEI1c2M1MDRVVUZRWGhZMGRXcUFG?=
 =?utf-8?B?bnhtSklwOVRiZEZTdktmRlpLZ05JZjUyVzg3ZGFxL3htVFNOa2ZNbmFiWXls?=
 =?utf-8?B?WWt3cFVMS3dxcFRRR09OcDJzQXZTSVppdUV2YzBEcElXK1Z4U3pJQVpMSUpS?=
 =?utf-8?B?ei9uUmpwcVdVRU9ZM2FqMDZtUFZ2WGg1RndzQUZjV1Jocm52NDZPRXV1SWg5?=
 =?utf-8?B?blhGOXNlenQ0S3piMHlKT1JuN2x4UVVTNTNLRVM4eDNtbGhWajcxTHR1V2pI?=
 =?utf-8?B?YjNMU0dQWktCa2YzUEFSZjdieWRTQmxWTmFXaXZITG5zVGlPaGlFRlQyZlZ2?=
 =?utf-8?B?bjRpMzFVdFU0blkzcVhlUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VlBpc3JYQlJ2eTVrOTBLUWkyMGgvajltWUZiVmlZNktMSU9aMVo4bC9jMVZn?=
 =?utf-8?B?VjJ5MFBWb0dHU0Mrekw3clJ4MFhYd2IwSEFWVXRCd25zelNodlVKRUVpRWRi?=
 =?utf-8?B?amhYMDVjNThKdDRNdFd4YkEwNGx1MTlieEsxOW9XQk5FSG80U29KSTZVUW9B?=
 =?utf-8?B?SU1UMHRGU2hham1SQ24xSzhMYjNURFZxWHc3bE1tK2JhYUkxK1dFbUZ5Q0wz?=
 =?utf-8?B?WjFSSDJhTnQvTnZJR1NZYjBDcU5hZ2VQMUh5ZnJuT0xYd3RRZWRMbzIrbkM5?=
 =?utf-8?B?dkNqOGJWZGFTMVduajFDN0FTQnFWUDdMRFpzRU9BV3JpdUIzU3VqMzRMRWc1?=
 =?utf-8?B?dVpiUC9kYjZ0d3U5U25YQ1J6QlpmN3Q2b2NucElJdW5uR2p2eXl5UUg0RERt?=
 =?utf-8?B?UFhlV2NWeitLNHRUTzVvNWJtNjBoYzZ3MzV6Qjh5ZDNCcjJ2d2E4NTVQN2E0?=
 =?utf-8?B?THBVMEN3SXRkQmlZRThad28vNVpQaW82ZUNuL0ZtbjExT3VZSmJkcXZtK2Er?=
 =?utf-8?B?N1JNdGRObnA5aU4rN0pxNFpjWGRWMUdqSlRQd29PcEgvVGs0U29nN2Q1NWl0?=
 =?utf-8?B?d0drSHphcjdmUkI1bzlXeVRlV1prNTZTbnRDOHNOTVpSa1hqbHREakJOajBh?=
 =?utf-8?B?TFhCdWFPRHdndzJYNUc3bmNEYU1XQzFwbk5HZHN4bGl2bDc5ZlUyZGJrbFdk?=
 =?utf-8?B?UU0reTlPZXZWWmVjU1UxbSs4Q1U0ZjdDalhyL0RTeHBiQXdHWDVGT3NNejBK?=
 =?utf-8?B?NmtpcWxsakRnV0I2QWRJdmJ6YTl6Nis0aGdHcENrMmtRQjM5V0JPcmdOK2c3?=
 =?utf-8?B?MWFPR09kWi9WaUsxRmlRQlVnUGh0VmRQbldWaUJXeUpHaytveDFiampmTDJH?=
 =?utf-8?B?S3FMYlVTK1Y4bzV6QldaM1UwVG13TkErYzQrZEM0YlRvUGtWQ0hNaWd6NGpS?=
 =?utf-8?B?bi81T3I2VVBMTGozSFZLU1dWd0U0dDFlNmhXUmxTcUpOZ3VyazZhV0ZoakpE?=
 =?utf-8?B?dlhHYnpsTWVQZzJHU0MvSWhmb1dCOVIzSFBDOXZWbkVwUExOZlRXNkNXcnJS?=
 =?utf-8?B?Nlo1dzFZc1JPT2YyUDd4aWlpYW03VHNMazhpY3BZNERYSytNQVpRem1YNkI3?=
 =?utf-8?B?QzVEY3cvMExjWjZyMVdKZzRIYkRQcnkzRlFyZzNDeDNyUGYvZjZUVWRmc25j?=
 =?utf-8?B?TTBJL2FNZUJyRTcxTkpibEZ4ZStCd01QNHc4ZElXSWcvSWVabmphVU4weGFh?=
 =?utf-8?B?aHEvSlUxSUlCKzI1dGdLVFBQcE9XNysyOGdUMTFaMXUwaDBoZy93OElOYlRU?=
 =?utf-8?B?YndtK25YUXJ4UkhZT1JOKzFmUSswWUhlanlLWG94VmdWK004K1g1Ukx6Wk01?=
 =?utf-8?B?Q25vRXo1ZTZhZEtaYVBCdTZaRmlLVTlxV1hsT0JwL1Q0RnVwYVpCYVNqUnVH?=
 =?utf-8?B?RVc5a1RvVitHV25SUlF5YW9pUi8vc2ZkM2lpVWVtKy82VWR3azhpUE0rS3Ny?=
 =?utf-8?B?NFlsa3BoUVdmT0Q5R1BiY2s1YTdqQVBZSXV2eGs1dlhUWTY0bU0zRXVCano0?=
 =?utf-8?B?b09pcUFEYXdNMS9PSXFRTjJRR1lITU9HRk5ETnEvV2t2R2xTc0dqYlJuV2x3?=
 =?utf-8?B?VDBOM2dqZTlCSTVLam5taWZTdW9nN3Bac0VrY1Nnam9SMVlOd3FCQlhWT2Qw?=
 =?utf-8?B?UzFJWXBvMmR5UEI3bXR6VzZ3aUtOSEpWcUVSSzUwQ0ZJUStEOHhIQ1Bod1Rh?=
 =?utf-8?B?SGFhSDhhQWJpaE1WUFB1RGRVVEh5aXEzdE55UGZ4aFFORjMrMTQ3VTc3Wkx1?=
 =?utf-8?B?QmFramN6WlZLUmFvVnVuMmR0OU5NNDJQWWNtMUhJZlM4amRuSXkxcndWcXdx?=
 =?utf-8?B?aVJjcmw5TlhYQXlxeHRZYmRiWjV1Ni9jUGg2ZUZRNXNCelBBeE9senhrVzlG?=
 =?utf-8?B?ZktZejBRZ2lqRUtzZXF1Q3pxd2piYzdEWEM0YmxNcXpLUjROWUZrdGQyT0NW?=
 =?utf-8?B?THZFM2JQcGkzUERkOGlwMTl3Vmx3UzRvVm1qTTcwdlp0c0QzSkFVUEo5SUNF?=
 =?utf-8?B?NmxZejl4d2NXWmU0am82SE9qWEhSSE1iUUhyUWhkQlFOU2RSTjBDZkJtV2VT?=
 =?utf-8?B?dXNKYy95MkV6c21lbWp2QnJUWHFZcXcyMkVRK2FZL2NiTjFqMHNaZlhJZytu?=
 =?utf-8?B?RGc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f18166a1-6c43-429c-f7cd-08dcdcd9328b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2024 20:40:59.3275
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aPc52UjQKDp3DwYbMP0rWlvSjk8VGiF+o+E+EMgC7I3RFm3vdHXThSk2I+CO2/iqNZfBcVQ2HJl1urJJPy9TleaZMA7+EErvcPsnI8hSzUg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5941
X-OriginatorOrg: intel.com

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE5oYXQgUGhhbSA8bnBoYW1j
c0BnbWFpbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIFNlcHRlbWJlciAyNCwgMjAyNCAxMDoxNyBB
TQ0KPiBUbzogU3JpZGhhciwgS2FuY2hhbmEgUCA8a2FuY2hhbmEucC5zcmlkaGFyQGludGVsLmNv
bT4NCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LW1tQGt2YWNrLm9y
ZzsNCj4gaGFubmVzQGNtcHhjaGcub3JnOyB5b3NyeWFobWVkQGdvb2dsZS5jb207DQo+IGNoZW5n
bWluZy56aG91QGxpbnV4LmRldjsgdXNhbWFhcmlmNjQyQGdtYWlsLmNvbTsNCj4gc2hha2VlbC5i
dXR0QGxpbnV4LmRldjsgcnlhbi5yb2JlcnRzQGFybS5jb207IEh1YW5nLCBZaW5nDQo+IDx5aW5n
Lmh1YW5nQGludGVsLmNvbT47IDIxY25iYW9AZ21haWwuY29tOyBha3BtQGxpbnV4LWZvdW5kYXRp
b24ub3JnOw0KPiBab3UsIE5hbmhhaSA8bmFuaGFpLnpvdUBpbnRlbC5jb20+OyBGZWdoYWxpLCBX
YWpkaSBLDQo+IDx3YWpkaS5rLmZlZ2hhbGlAaW50ZWwuY29tPjsgR29wYWwsIFZpbm9kaCA8dmlu
b2RoLmdvcGFsQGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NyAzLzhdIG1tOiB6
c3dhcDogUmVmYWN0b3IgY29kZSB0byBzdG9yZSBhbiBlbnRyeSBpbg0KPiB6c3dhcCB4YXJyYXku
DQo+IA0KPiBPbiBNb24sIFNlcCAyMywgMjAyNCBhdCA2OjE34oCvUE0gS2FuY2hhbmEgUCBTcmlk
aGFyDQo+IDxrYW5jaGFuYS5wLnNyaWRoYXJAaW50ZWwuY29tPiB3cm90ZToNCj4gPg0KPiA+IEFk
ZGVkIGEgbmV3IHByb2NlZHVyZSB6c3dhcF9zdG9yZV9lbnRyeSgpIHRoYXQgcmVmYWN0b3JzIHRo
ZSBjb2RlDQo+ID4gY3VycmVudGx5IGluIHpzd2FwX3N0b3JlKCkgdG8gc3RvcmUgYW4gZW50cnkg
aW4gdGhlIHpzd2FwIHhhcnJheS4NCj4gPiBUaGlzIHdpbGwgYWxsb3cgdXMgdG8gY2FsbCB0aGlz
IHByb2NlZHVyZSBmb3IgZWFjaCBzdG9yaW5nIHRoZSBzd2FwDQo+ID4gb2Zmc2V0IG9mIGVhY2gg
cGFnZSBpbiBhbiBtVEhQIGluIHRoZSB4YXJyYXksIGFzIHBhcnQgb2YgenN3YXBfc3RvcmUoKQ0K
PiA+IHN1cHBvcnRpbmcgbVRIUC4NCj4gPg0KPiA+IEFsc28sIG1hZGUgYSBtaW5vciBlZGl0IGlu
IHRoZSBjb21tZW50cyBmb3IgJ3N0cnVjdCB6c3dhcF9lbnRyeScgdG8gZGVsZXRlDQo+ID4gdGhl
IGRlc2NyaXB0aW9uIG9mIHRoZSAndmFsdWUnIG1lbWJlciB0aGF0IHdhcyBkZWxldGVkIGluIGNv
bW1pdA0KPiA+IDIwYTU1MzJmZmE1M2Q2ZWNmNDFkZWQ5MjBhN2IwZmY5YzY1YTdkY2YgKCJtbTog
cmVtb3ZlIGNvZGUgdG8NCj4gaGFuZGxlDQo+ID4gc2FtZSBmaWxsZWQgcGFnZXMiKS4NCj4gDQo+
IG5pdDogVGhpcyBwcm9iYWJseSBzaG91bGQgYmUgYSBzZXBhcmF0ZSBwYXRjaC4uLg0KDQpTdXJl
LCB3aWxsIGRlbGV0ZSB0aGlzIGNoYW5nZSBpbiB2OC4NCg0KPiANCj4gPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IEthbmNoYW5hIFAgU3JpZGhhciA8a2FuY2hhbmEucC5zcmlkaGFyQGludGVsLmNvbT4N
Cj4gDQo+IE90aGVyd2lzZSwgTEdUTSA6KQ0KPiANCj4gUmV2aWV3ZWQtYnk6IE5oYXQgUGhhbSA8
bnBoYW1jc0BnbWFpbC5jb20+DQoNClRoYW5rcyBOaGF0IQ0KDQo=

