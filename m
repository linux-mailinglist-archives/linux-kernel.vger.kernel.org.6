Return-Path: <linux-kernel+bounces-304499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C84C9620FD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A7F91F24EDE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 07:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7641581F2;
	Wed, 28 Aug 2024 07:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nbX9fFoW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66218156661
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 07:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724830030; cv=fail; b=WHxigVQlR4JvrQqMh52aspWL98nIeBqv0gkJ8Sc0n4rtfoA8qh0sa4yx7DrELlQBSaVxxOPdhwMmhF+BSmbWGCZ0me+Cgx4KP6ROqr17DgyZ7UdIsufZ153sHsm5NOx0YXLgGDF86SEtIxnYrCqvANBwev2N3O3CH8CySna6RzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724830030; c=relaxed/simple;
	bh=idJASu8f7m8ABJFhlZ3IFQABUGSXtNVh8+tWJTUfvFs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I8jwu5vhAmAS7hQ3IZiwYcJaZJdnpPukuFluS/Cu/6Z4GILI5dES+npRHflWT2Ih0YIYehyC/eFz4WD8/6N+6WbeI7Zv4VIiw4Dv34PvYYPadwQ9lAeX3uVOYsv/IeMFWxaIe9qKq+qv4HjB7L9xOe+3MhoNx8ulIg4NNWeOR0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nbX9fFoW; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724830028; x=1756366028;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=idJASu8f7m8ABJFhlZ3IFQABUGSXtNVh8+tWJTUfvFs=;
  b=nbX9fFoWA8L8l3pL6S2/YO0GHT4zptExuaY07G5SEsFS15J0npNsTIvd
   BsKqSaMZYjbIUtO4QMxUL8O+pjAXYdwJZbmiKtdvGM7I5h6ZF/ia+Htx6
   TBfanZgQgmg5MCX1RtEY29dXwfT+Q9a+ghkDL7sftmsIKcIXEgWxSIEM0
   6xDRPuVAu4sGkXDF1wKQiAMrHeBOmX1ooaE1LNnN5rILemDgiFvEDVMQ9
   bo1OyGR/GiO5FlDvzT75jCr8FRmfL6iDO+ZGeGmL/dTRMLqZP0dG2LMPN
   HBq8WaXRDEe5HvjjNmCDI70UYnZqwqr0jiZIcZ+/5v6S40aU04CytvGku
   A==;
X-CSE-ConnectionGUID: BdLtWpAXRZm6qSTJso6MYw==
X-CSE-MsgGUID: 3V2gQzYcTqONdV3hrlzm0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="23469690"
X-IronPort-AV: E=Sophos;i="6.10,182,1719903600"; 
   d="scan'208";a="23469690"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 00:27:08 -0700
X-CSE-ConnectionGUID: Gkf0xE6EQCKpk76owUYYlA==
X-CSE-MsgGUID: Ib3nt1PYQKCdpV5hvmBFrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,182,1719903600"; 
   d="scan'208";a="67991663"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Aug 2024 00:27:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 28 Aug 2024 00:27:07 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 28 Aug 2024 00:27:07 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 28 Aug 2024 00:27:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KyKgmQ3nxdmD4kttXBHp38loHYf46cVpoiHjoKCQajUiNdh5qf3jJ/kmdWZGW3WZBBtTC4jDKExC6X3AL22eequghBKksGsRNdIR0vWew+Ml0g+QELfVWJDiolayil+JSrPC8SLNP0GYTxJlIUW/rxgbdGrdPf/m1UjtUTd3ljGjxzlSM3Y0oH4sLjSQFCP1/90BysVl/V7/tFtdPFYNMaQZx3C2cBP7HeRUoHS97AQ2D5zWqT6WH2CtE3Lh1N88v+3jgYQk2uZBAnGC/UqqS/8oBU68n+MKPiQuEAiEQAA7NNax/5HXV4D7GvYMgMjNYsLX9EIk4iEI4kve6x9K2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=idJASu8f7m8ABJFhlZ3IFQABUGSXtNVh8+tWJTUfvFs=;
 b=TlMC+m6PPLyFUv5bg8VmXD4ovSWaGKYz8UkgJB+FIR9p6Py99oKZRom43tproxuo7Ljp07st5xLEiCAqo/YPGUCsG9ny0MWAksvQKeLrUY6D218WW3ftTIh1aeCewYDvdsAMlfd6jwEBhLqOTU85TI3te4tVxbKW48eyld1/530CYLnIHPyG3xiqQziIF50LVvQg54rFudCqd085ZK2CE8osEgykmXKM1uNqN2McVhuv389iap8A7XdSZDxXB4Mb3MDDUc5Kg4CYgzKkmuSODVe/KkMxRJzCdfYLhSzbqi2XDelzOqivmmwfxE/Cyu+oonxb40Tp5YFS1FyWBvazzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by CY8PR11MB7172.namprd11.prod.outlook.com (2603:10b6:930:93::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Wed, 28 Aug
 2024 07:27:04 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%5]) with mapi id 15.20.7875.019; Wed, 28 Aug 2024
 07:27:04 +0000
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
Subject: RE: [PATCH v4 0/4] mm: ZSWAP swap-out of mTHP folios
Thread-Topic: [PATCH v4 0/4] mm: ZSWAP swap-out of mTHP folios
Thread-Index: AQHa8d3OD+uOh/WK5kyI6A6kVnXGhrIxzReAgABJIZCAA+ChsIADqWIAgABIr/CAAV2VgIAAAcEAgAA1wMCAANVQIA==
Date: Wed, 28 Aug 2024 07:27:04 +0000
Message-ID: <SJ0PR11MB567838FB8EA8CCC8479BFEB7C9952@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20240819021621.29125-1-kanchana.p.sridhar@intel.com>
 <CAKEwX=OO6frFa+S3xjtoabB2dY1Y5RN5qjMsVUsgKDK_QuOFzg@mail.gmail.com>
 <SJ0PR11MB5678288EE890E8CB882839CDC98E2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <SJ0PR11MB567801EE747E2810EF183C73C9892@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAKEwX=PYv4Cn_a7WSnbUyhwSBO61xoDPSexXxS0uwwxu5P6XLw@mail.gmail.com>
 <SJ0PR11MB5678E44062CADBE8BAB546F3C9942@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAKEwX=ORuJabxQSehU5E0QNG=Gx6QkyTCb1vek3AOcQuvF54Xg@mail.gmail.com>
 <CAKEwX=MPM8v6WZ3XUD11MkZceo7Y82C0pMTwLJuZX67Wo27WbA@mail.gmail.com>
 <DM8PR11MB5671177E56AB8064336284E3C9942@DM8PR11MB5671.namprd11.prod.outlook.com>
In-Reply-To: <DM8PR11MB5671177E56AB8064336284E3C9942@DM8PR11MB5671.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|CY8PR11MB7172:EE_
x-ms-office365-filtering-correlation-id: e01ee986-2e26-4c7a-3be7-08dcc732d0bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RWZCaTJNSElIQTJnL0ZlTi96T09vbjRhSWd4RGJKWTIwSXJ4V01pSGJEQ3h0?=
 =?utf-8?B?R1ZNU1lNZU5CNDhPSkFUdVdCa0hYRVNtcm5laFJKZjhNYWUyRDNGV09NMHFy?=
 =?utf-8?B?MWt3MmtScXI3YXpjbTdiN3ZTRW1qVkhnS0pUZUZyQnVkVDM4UUsyM3hWaTBV?=
 =?utf-8?B?bVJuQm1pNVNsbGxZVEVoTmw3dFM3eTNXMm9SMWdWUzJMWGR4eDRSVjBEM1Vv?=
 =?utf-8?B?bjQ3dnB1YWtHV0EydHZSbGNPYmhYY2dpNWp5OGk2bld3RUtpR0ZVUyt5VFZH?=
 =?utf-8?B?dFVZT0czTThxNk5lODNta05sc2o2VWorVEJBa0dUWURQSjZla3NvNy82N01j?=
 =?utf-8?B?TkFHbjhXTmcrUEVGa1pSbWFNZlBXNC8xRXB0SXlEZVZtWXJSdkJXN0YxQTQr?=
 =?utf-8?B?SHJBZUZ3K25jZFg4bU8zRDBkWmlrTXY1NXd2bWFSOW9FZ1dkLytWTUwwS1VQ?=
 =?utf-8?B?NTBZZndWZmxtN1VGUGY2ZnhXWi92K2UzNS84TXEvNzA1THNVWmJtZmdJK0F1?=
 =?utf-8?B?YUswOFFBeGloQUdBQXZxVmE1QmZPWFZYZ0x6ZGpiUmpEYUp6dkRUYkpCeFZa?=
 =?utf-8?B?by9HTkE0RThVenUxd2UxT1A2ZGNXVjBNT2JRd3p2T0FpZnJKMWVVY3VLRTZL?=
 =?utf-8?B?WGM3c3FhL0N1M1R2UGFQZEJYTnBVdld0VHJYTER6L0l5ODluZGZCZWNmWlNE?=
 =?utf-8?B?N0lKNytaZVV4aE5vRWVybGhwWURoR1h3VlN6VFZ0a3NuaW9LZnBxU1dzUjBn?=
 =?utf-8?B?VzhoeEZad1VlQW5vUXN2MGtUc01qMDJ0aGpVV2I3TEk2cHk5dGY4T21zUEFs?=
 =?utf-8?B?Y2hNS1FpRTVXeHNjZWVEUmYyaG1uK1RwV1UvdzV1cmlLbDFBam9TdERzTVky?=
 =?utf-8?B?cEtqR1VPbHhTY1BXZmRSanF4OEpGT0pCbFJwWVhpc3VCVU11cEpJRitTU204?=
 =?utf-8?B?THhUN3E5cDdTRTF0VUVhTy83VU5TMjJNUUFiQmpIZ1IvL2dnNkZJVU8xRGpz?=
 =?utf-8?B?ekxNVnBkUFdyRUdaZER2ekRoQjVtelUwem5ueTFsWDNzbUxTU2VXdEt0cWxL?=
 =?utf-8?B?RzBnM0trWXhKZDA2NzRZaU14ZmcraTJFa2k3N01odEdBR09teGVwdTA5YmRp?=
 =?utf-8?B?WXFnVmNpRFJQcE9sQW1UQzZ6QmUweFpyWGs1Y1JjZFNwS2dmeG5PdXFpdGNs?=
 =?utf-8?B?YzY2ZG5rcTIwaUFZR2Zpa3Q3YUpkb1lDbkFaK2JCcmxkT1cxSmlsT2JNZnRI?=
 =?utf-8?B?OTNGUUhNd0ZDdlQ5QnBEQlJlZWdHQnBsL1RjU2lqU0JTdWtGT3kwaHBpZGJz?=
 =?utf-8?B?VE1UUTZwcktubFp3RlpINTNEYW9jZGJ3OTZ0c2pXRWR5VXY5OWQvZmpTa2x6?=
 =?utf-8?B?bWJhWTUxa0o5cllxNm9WTE10R1ozRFZsQ1pvcU8zaU14eExZWUFFbXN3SWhj?=
 =?utf-8?B?K3lmV3NzZlZtK2F4MDNOTkgrQzZuSXg5cHArRFg3dW9WZDNXWG5kd25TbmxC?=
 =?utf-8?B?WEU2Zkh3a0gzeVVXNnNITmJMTXNBaHp3SjFXV2RLV29paTBZUk0vWGdmQmtw?=
 =?utf-8?B?S21kTzBoMU9EaW91a3R1OUV0SGcwM2VSS3hxODJiNzRlcDVsWW03eFRjM0pB?=
 =?utf-8?B?TnV6Yld1SlBCd1VEdXE2UUk4WlAzL0UyN252YW5yUHljbksvcjN6Ty9ENURj?=
 =?utf-8?B?aTNocHFQeVgvYzV5ZW1JNW9hSmRUeUpLc3c0TGhaM1dXM3o0RFBBWTBrWkNv?=
 =?utf-8?B?QUVGSWhnem5BWWl0WkxOd1ZaK2o2RUlTOHlxR25LT3VmYklUenBvUTBhYzBl?=
 =?utf-8?B?bDJ1RFRmREpXZTZMZkxIdzJ6ZXZBUFZ0SkpzYmpSeEI3UTVEcnlLdnRHTUVi?=
 =?utf-8?B?aGNOS2ZYNWpNMlRJeWpEdTJxZWxkeitvWDZ5NGlnL256bUE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NE9pUXY3a0h1UlhFMStpK1NRZXduT1RRY3pUWnQrNTJYQ1EzRy85WHBUU3k3?=
 =?utf-8?B?MStOSU15ZVMxZFdKa3Y2eDZuVVoyWWM2cFFyQWZKZWpzNWlkVzFOV1BJN0x5?=
 =?utf-8?B?NUI0N3BNK3paZy91UEM3MkIwSTYvakxyQXNyYUg0ZWROTlM0Z0NVZjc1TTJ5?=
 =?utf-8?B?NlV1NVEwTHowRFVjNUx2bmpSelptS0F3aTFiQVpSZ2RnYzlTVlVTY0Y3Rnp5?=
 =?utf-8?B?SVhFRGkxNUVGbHd0VUpqaFRLcjllVTJjeUNzUmFXcENacEdNaWJqdDRZNTNi?=
 =?utf-8?B?ZHRUakgzR3BZTVFuMjhvRHJReGJKSFk3UVR1RC9TeVlQaVh2Mzk1citQeXhy?=
 =?utf-8?B?N1JnbFpqZnVoWnB3ME9Kamx3SDlqZFFzbXp1b0JSRWtMOEJrVk44Tlh1Nzlq?=
 =?utf-8?B?QWlYYUh4anFpNzJPUzJPTmpIOHFGNXgyT2JOaVhuU0RtRjArVDhmSkFGYzl0?=
 =?utf-8?B?OUJDcStsWCtvWnJvRHBEQ21XOE44Y1JLUERXbkJKQ3B6bU1mcWNJVHFkUTA5?=
 =?utf-8?B?QkVhVUpkLzVGVEkzVE5RVDUrVkc0K292ZFhGSVZXQ2w0Zllab0tiNWdMWHJ6?=
 =?utf-8?B?SWRJVEVseHVFMUJJSk5HMnQvZWVPVmpXRUlZMGMrRDJYZzZHM1NsaEJxeHlB?=
 =?utf-8?B?enFYLytKWkxtQ3hjTnE2RzNETGwrTzRDZXQzcEpGK3M0MHZwWHRQdENUdnRY?=
 =?utf-8?B?UkM2QmFUSzI4aW9iQWhuVFl1NWJxYXd4cy9kaG1FZWt4K3EyRkt0TDJxNXhB?=
 =?utf-8?B?RG1FbXZzdVlvdTFYR29LRmFxWi9PcWFmWVk1dEJCZFU0Zk1Mc29DUVEwMnZr?=
 =?utf-8?B?V2ZUbFB3a3QzWFBYQjNBRnhuZytDcm0xT1NBNi9TS3JFcDZtS2cvZXo5azBU?=
 =?utf-8?B?OTUvbERWbzdDOG9SY1gwTTRBV3BmV0lTZmlhTnNlWndIRzdjcXFQMFFuOXJI?=
 =?utf-8?B?VHE4aVNwdFplRXQxTEYydjJrVWNham05dnJDS0lTVWhEazNYODQvM3drY3px?=
 =?utf-8?B?aFdLdDR6ZklLaGZIdFVHWVF0TENKV1Z3MDlBc1h0aW1uRE9LeCtvU1hodURk?=
 =?utf-8?B?SjV4cmF5dWVYZFBTQ2hTSVpJVk85M2t4SHl6aVBOVjRhbC95WWVPSHFCM0RL?=
 =?utf-8?B?L3JGRGpLOHlGNnp6dm1XVllpMCsyT3BLNEQzUXI2ZldUNVVqUXFGOTNzc1Jr?=
 =?utf-8?B?RWt5cmxhZWdSZVVMSkFQR2xPcEI4TEtzbWJCK3kzZHJJYTR4MGpBc09wRzI5?=
 =?utf-8?B?UURXbnBzTG9ETjlRdEg3UFhnVE4yaU9zV3IxNzRyWDdxNFdXbHNDLytmZEQ1?=
 =?utf-8?B?SzdvQy9sZzVvbGZMWndvOUEyUlBsMnl0RDAyRGZ4am93RDhSSWM5cWlTMDhl?=
 =?utf-8?B?WHVpd2tvMXRUNEpYaW9OSmJuYlJqWmtUVmxDbnBKSTh0Um9pSEEwQ3ppY0ZH?=
 =?utf-8?B?dUY1WFVXYWNCSnpqOHNOODJXRjBMaDlmeXlsWlF0VFd6dnVsN00xQ3ZlMTJK?=
 =?utf-8?B?RlJ3Z29TSCswSE53bTVsblNrVmxVZnNIY2I5MXpOYkx3dVVCa09BTm9kLzNL?=
 =?utf-8?B?RklhK0N4ZGpaOEp6RXNXV0JtNnp3ZGVpUWF6cjFBS3lmdGMwMlpOSG9EZ1Q0?=
 =?utf-8?B?QXI2ZGJqTitRSGw5Rk5sVXZZR0FHV3ZiWEh4azZ0R3VKdnBMb00zblY5QVdZ?=
 =?utf-8?B?cDFhajBOV2lVY00rRXJ4VjNubDh6MzdBbHV6cm1UNkRGd052cVFnUzJKR1F1?=
 =?utf-8?B?SXJleWF0NmNxMnJ4MThET0J3UzNlaWRxeHMzUEhtT3hSUG1TaWw5NTBhVXd2?=
 =?utf-8?B?UG80dGNLTTJkZjNMcWpqMnJvZ2RqNHpFWjRURUt2MEFRZVBXaDhEOFphNm9u?=
 =?utf-8?B?VGpjblBtcnZCYlVLUE5KRFBIZk82NGtzaHpjUVRleURmZzRtdnJqdDduRDNF?=
 =?utf-8?B?emlLdm0vcmorQmo1NThyZUd0RVdFaklCa2hCOU1qSnc3ekhiSHNjZjhEQ0hB?=
 =?utf-8?B?d3NhZlJRUmx3SC9MRjRUYTVSaXI5Wno2ZnEyaitpSlIzNGdBcHp0SDE4RFNK?=
 =?utf-8?B?bnBmZG5NTUVrbzNsbXQrK2drb2tPWTRvTmdtSmoyS2I5TGlQb2lWZXdFS05O?=
 =?utf-8?B?bU9qYi9lS1M5OHFZbGNzQnJFZWlOZ2hBRlBTOWNtTHpzVWtvL2NSR1pUSnpv?=
 =?utf-8?B?Vmc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e01ee986-2e26-4c7a-3be7-08dcc732d0bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2024 07:27:04.4203
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9BhDtiIxqnavZ6jgFAHnsaQ7h/2SKKipK2vJFA/v8vLhlxEDrqgN1KyBGHmm3YIrrs1QyPGe5a4bwoOGPPmAV96d5XTwgqcsjruX2ii2v20=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7172
X-OriginatorOrg: intel.com

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFNyaWRoYXIsIEthbmNoYW5h
IFAgPGthbmNoYW5hLnAuc3JpZGhhckBpbnRlbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIEF1Z3Vz
dCAyNywgMjAyNCAxMTo0MyBBTQ0KPiBUbzogTmhhdCBQaGFtIDxucGhhbWNzQGdtYWlsLmNvbT4N
Cj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LW1tQGt2YWNrLm9yZzsN
Cj4gaGFubmVzQGNtcHhjaGcub3JnOyB5b3NyeWFobWVkQGdvb2dsZS5jb207IHJ5YW4ucm9iZXJ0
c0Bhcm0uY29tOw0KPiBIdWFuZywgWWluZyA8eWluZy5odWFuZ0BpbnRlbC5jb20+OyAyMWNuYmFv
QGdtYWlsLmNvbTsgYWtwbUBsaW51eC0NCj4gZm91bmRhdGlvbi5vcmc7IFpvdSwgTmFuaGFpIDxu
YW5oYWkuem91QGludGVsLmNvbT47IEZlZ2hhbGksIFdhamRpIEsNCj4gPHdhamRpLmsuZmVnaGFs
aUBpbnRlbC5jb20+OyBHb3BhbCwgVmlub2RoIDx2aW5vZGguZ29wYWxAaW50ZWwuY29tPjsNCj4g
U3JpZGhhciwgS2FuY2hhbmEgUCA8a2FuY2hhbmEucC5zcmlkaGFyQGludGVsLmNvbT4NCj4gU3Vi
amVjdDogUkU6IFtQQVRDSCB2NCAwLzRdIG1tOiBaU1dBUCBzd2FwLW91dCBvZiBtVEhQIGZvbGlv
cw0KPiANCj4gDQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBOaGF0
IFBoYW0gPG5waGFtY3NAZ21haWwuY29tPg0KPiA+IFNlbnQ6IFR1ZXNkYXksIEF1Z3VzdCAyNywg
MjAyNCA4OjMwIEFNDQo+ID4gVG86IFNyaWRoYXIsIEthbmNoYW5hIFAgPGthbmNoYW5hLnAuc3Jp
ZGhhckBpbnRlbC5jb20+DQo+ID4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxp
bnV4LW1tQGt2YWNrLm9yZzsNCj4gPiBoYW5uZXNAY21weGNoZy5vcmc7IHlvc3J5YWhtZWRAZ29v
Z2xlLmNvbTsgcnlhbi5yb2JlcnRzQGFybS5jb207DQo+ID4gSHVhbmcsIFlpbmcgPHlpbmcuaHVh
bmdAaW50ZWwuY29tPjsgMjFjbmJhb0BnbWFpbC5jb207IGFrcG1AbGludXgtDQo+ID4gZm91bmRh
dGlvbi5vcmc7IFpvdSwgTmFuaGFpIDxuYW5oYWkuem91QGludGVsLmNvbT47IEZlZ2hhbGksIFdh
amRpIEsNCj4gPiA8d2FqZGkuay5mZWdoYWxpQGludGVsLmNvbT47IEdvcGFsLCBWaW5vZGggPHZp
bm9kaC5nb3BhbEBpbnRlbC5jb20+DQo+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCAwLzRdIG1t
OiBaU1dBUCBzd2FwLW91dCBvZiBtVEhQIGZvbGlvcw0KPiA+DQo+ID4gT24gVHVlLCBBdWcgMjcs
IDIwMjQgYXQgODoyM+KAr0FNIE5oYXQgUGhhbSA8bnBoYW1jc0BnbWFpbC5jb20+DQo+IHdyb3Rl
Og0KPiA+ID4NCj4gPiA+IE9uIE1vbiwgQXVnIDI2LCAyMDI0IGF0IDExOjA44oCvUE0gU3JpZGhh
ciwgS2FuY2hhbmEgUA0KPiA+ID4gPGthbmNoYW5hLnAuc3JpZGhhckBpbnRlbC5jb20+IHdyb3Rl
Og0KPiA+ID4gWWVhaCB0aGF0J3MgYSBiaXQgdW5mYWlyIHN0aWxsLiBXaWxkIGlkZWEsIGJ1dCB3
aGF0IGFib3V0IHdlIGNvbXBhcmUNCj4gPiA+IFNTRCB3aXRob3V0IHpzd2FwIChvciBTU0Qgd2l0
aCB6c3dhcCwgYnV0IHdpdGhvdXQgdGhpcyBwYXRjaCBzZXJpZXMgc28NCj4gPiA+IHRoYXQgbVRI
UCBhcmUgbm90IHpzd2FwcGVkKSB2LnMgenN3YXAtb24tenJhbSAoaS5lIHdpdGggYSBiYWNraW5n
DQo+ID4gPiBzd2FwZmlsZSBvbiB6cmFtIGJsb2NrIGRldmljZSkuDQo+ID4gPg0KPiA+ID4gSXQg
aXMgc3R1cGlkLCBJIGtub3cuIEJ1dCBsZXQncyB0YWtlIGFkdmFudGFnZSBvZiB0aGUgZmFjdCB0
aGF0IHpyYW0NCj4gPiA+IGlzIG5vdCBjaGFyZ2VkIHRvIGNncm91cCwgcHJldGVuZGluZyB0aGF0
IGl0cyBtZW1vcnkgZm9vdCBwcmludCBpcw0KPiA+ID4gZW1wdHk/DQo+ID4gPg0KPiA+ID4gSSBk
b24ndCBrbm93IGhvdyB6cmFtIHdvcmtzIHRob3VnaCwgc28gbXkgYXBvbG9naWVzIGlmIGl0J3Mg
YSBzdHVwaWQNCj4gPiA+IHN1Z2dlc3Rpb24gOikNCj4gPg0KPiA+IE9oIG52bSwgbG9va3MgbGlr
ZSB0aGF0J3Mgd2hhdCB5b3UncmUgYWxyZWFkeSBkb2luZy4NCj4gPg0KPiA+IFRoYXQgc2FpZCwg
dGhlIGx6NCBjb2x1bW4gaXMgc29vb28gYmFkIHN0aWxsLCB3aGVyZWFzIHRoZSBkZWZsYXRlLWlh
YQ0KPiA+IGNsZWFybHkgc2hvd3MgaW1wcm92ZW1lbnQhIFRoaXMgbWVhbnMgaXQgY291bGQgYmUN
Cj4gPiBjb21wcmVzc29yLWRlcGVuZGVudC4NCj4gPg0KPiA+IENhbiB5b3UgdHJ5IGl0IHdpdGgg
enN0ZD8NCj4gDQo+IFN1cmUsIEkgd2lsbCBnYXRoZXIgZGF0YSB3aXRoIHpzdGQuDQoNCkkgd2ls
bCBiZSBzZW5kaW5nIG91dCBhIHY1IHNob3J0bHkgd2l0aCBkYXRhIGdhdGhlcmVkIHdpdGggenN0
ZC4NCg0KVGhhbmtzLA0KS2FuY2hhbmENCg0KPiANCj4gVGhhbmtzLA0KPiBLYW5jaGFuYQ0KDQo=

