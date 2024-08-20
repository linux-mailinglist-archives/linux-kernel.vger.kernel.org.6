Return-Path: <linux-kernel+bounces-294617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BCB959043
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 00:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 788531F228C6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 22:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D35C1C68BB;
	Tue, 20 Aug 2024 22:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NPNzPgHA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE901E86E
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 22:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724191770; cv=fail; b=s8WxXtM9mOnCHOEf7vKRGHhZ1PrO2dsU9tliNFYKpUKGBnxclAZKBWjwTbKQLdX91Sg0DO/pGFoK1JNk6HtLqjLp3PmJxrFierNj93T2/t5AyqkvRBLba3GHMp/l6gkQhw+vVlf51PUChib+Mp/9WTrw3NY2QpOEKS8p+rBlODw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724191770; c=relaxed/simple;
	bh=0axCkwbQSqpoXTWvsjaOYbzFFhf+TzMNoYsH75tZib0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iR1OhNvMhCaIEkv2yxbG6XlttQm97/MkiusopocvyoKaaME79cjFcxgjAAPJj+otNcGvE12yBEXoMLsDrn+D254Sdn/YVvKKP/AeqRWd+vMzaVkIZ08g45QRRyWEXUagoUZ4WfwP71sRL817ZbR30FMLQdLgjC1uEl629iyRQrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NPNzPgHA; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724191769; x=1755727769;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0axCkwbQSqpoXTWvsjaOYbzFFhf+TzMNoYsH75tZib0=;
  b=NPNzPgHAQaJkN+6y9vtd1yrD7Q71FZXFydmYE1Frt33WgQinG+4mbLrn
   bzBmqO/488Dn6bV7jtgBxm92rxX1/h4cyzX74/p+RV3kwJRx9uNV8pIVk
   B5gOXhnozZDhPjNxXhMhqzPnRbdcWe6FumD5La47MLsNX1nLwSoDENpOZ
   LWus4uYGMF5cjs63tUHbeEKZXOu72JG6ape7l4K3LbrcYNkCl9H6SrrHV
   iyO7vA1xe2JiVSoLWLI5n5sqzzeuEFW0mQkxCiQbRXYdO7atmZizd9ay6
   LSOYQ8JiKYtLJ8EPHCqdgR3ceDjg4o/y9nfWm/f4IWRT3EAsFPf0wMs3z
   Q==;
X-CSE-ConnectionGUID: nNb3zZgnRvm4N1Ect2fmKg==
X-CSE-MsgGUID: rndrkw2ZQ92V0XQqsFHjnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="45047468"
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="45047468"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 15:09:28 -0700
X-CSE-ConnectionGUID: c2lhSMM6QCy2Y2rpTOeShg==
X-CSE-MsgGUID: 1szpopptT4SnG8KDzasRxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="60828676"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Aug 2024 15:09:28 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 15:09:27 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 15:09:27 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 15:09:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F45mDPGqpyj8KYzIEKChurB1uApwsbvp2gp1YLool9ZgBQjvWmFa3uxQoS43oWyZmv8RAHo/I83fEfVsBG4A7rDpThpDTe52WiNZmNTzjvytWHOnqn3zL0RKDk1AfDsBqLlVc9KRpIQiYu32NI86U07vuoGD9NTmd8g1nxsYQeTUMheAAiHgrJqZ2uk+WUeHC9IXuID7gJhU678J+34i4Q4K5xp7LWLVfOYqYyKgkMp8eFe9EPhHcZDeth9UMARbDSxh4YDnFshlX0s8+4SMzB+iyt+tmMZfbUkTYYmFMfSVGNgM9bvZq/TiAPuQkqimPYj4Me2PfmVgG7tE0aiUCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0axCkwbQSqpoXTWvsjaOYbzFFhf+TzMNoYsH75tZib0=;
 b=DnF5vEaO8zSuu0c4MUo1HTP2/wzSoEvswZHv+vnsPYOzyFkYTZX8Lh+xV/0bAlcSmrRzu5f4PuzRsV0mtYFcw2+A3frAcaV52i4/XEOPQRCGZR1FzZXodo8uPAL+ETIt9rMzFf7epT3qQkF2eaJYChTq2T24AnjM5mIMUCuGwW/wVw1ZeNwb3hekIRm+5BvyVQD1tutygcyTdqmt5T64+Wx6WcGLDN7px63DQhwBlWCcHcB6263lC/waMPhO9fHHexxhqYBdNC9FCeoguWBX4CYs9r8Sk2542nAWVLAVkwxvme2R93REtJlCzwegLtHIzeIbFH6/Y+34GalN5wVNLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by DS0PR11MB8134.namprd11.prod.outlook.com (2603:10b6:8:15a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 22:09:24 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%5]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 22:09:24 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Nhat Pham <nphamcs@gmail.com>
CC: "Huang, Ying" <ying.huang@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>, "yosryahmed@google.com"
	<yosryahmed@google.com>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"21cnbao@gmail.com" <21cnbao@gmail.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "Zou, Nanhai" <nanhai.zou@intel.com>, "Feghali,
 Wajdi K" <wajdi.k.feghali@intel.com>, "Gopal, Vinodh"
	<vinodh.gopal@intel.com>, "Sridhar, Kanchana P"
	<kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v4 0/4] mm: ZSWAP swap-out of mTHP folios
Thread-Topic: [PATCH v4 0/4] mm: ZSWAP swap-out of mTHP folios
Thread-Index: AQHa8d3OD+uOh/WK5kyI6A6kVnXGhrIt6fDUgAAVm5CAABWne4ABSVRggAFJZYCAAA0p0A==
Date: Tue, 20 Aug 2024 22:09:24 +0000
Message-ID: <SJ0PR11MB56787A1D56023A6B25ABE1A0C98D2@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20240819021621.29125-1-kanchana.p.sridhar@intel.com>
 <87msl9i4lw.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <SJ0PR11MB5678BFAA984BEEBBFC2FC351C98C2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <87ikvxhxfm.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <SJ0PR11MB56784DD616B595FC707E5133C98D2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAKEwX=P8o+hLsdQw_xKymgteLXsBPfDf4kGVKdgE=PNj=b0cMw@mail.gmail.com>
In-Reply-To: <CAKEwX=P8o+hLsdQw_xKymgteLXsBPfDf4kGVKdgE=PNj=b0cMw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|DS0PR11MB8134:EE_
x-ms-office365-filtering-correlation-id: 0e0ac65b-f61d-4d9c-1382-08dcc164c042
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?d3BxN2RzQzY3b2tMdnJld0NYTXBLdmQ1cEdBMmRsSjlTKy9WL2xjZ1A5bm1O?=
 =?utf-8?B?Mzd5MmYveUdUanc5bmxMSWlxTEtnd1ZRbzRrbFNhSXRmTXpQSnFUd2ExbDJL?=
 =?utf-8?B?aHBwMFgxTTRoYkgyMTVLRTA1WThFUkhncnFQRENlYkxTVmh0QStyUmFZa3Za?=
 =?utf-8?B?OEo5NjBRY1ArN21ZSXVGWDZhVksyd3Jza3NVaFVnUHdZRjJBUVNDV2ttL0dI?=
 =?utf-8?B?K2Y4MzkvKzJpQ0xDUVNBM0ttRGVTRkUvemluY1JpNGhSQVVlODVQSVhtbzdO?=
 =?utf-8?B?ZS96MkRNZzdVVXNpeHpKQjQ3ajErazcwbUtMRk9xeHVNS0lyTmtIYlZCOXc1?=
 =?utf-8?B?WUgyZ0QwTUtHRURMTHQwWm9BV1dKcm5Da2Q4RTZjanNNSlpqQzZBaTQrSSt0?=
 =?utf-8?B?b1NDeFZuVVRrZGZGQjduRlVyOXFsdFpxOEk4aWlPazR6eFNIM3N2eUxFMVNn?=
 =?utf-8?B?Qi9DTS84bk0zZVNtV2Y5V0VIS1UrNy9hakdyY08xRzQxdHB5STJJbHNTVkhL?=
 =?utf-8?B?TEp4MlRBcXViZ3VINHljRTZjSXBHamkzWC8ycTVvUzlJajZHSURhNjZsNVFw?=
 =?utf-8?B?U1dsWmZzdHpaUnVJMXN6b1JTMXFPejN1dnJIUHNNK3hHcm4yZzZsRFI3Vkxr?=
 =?utf-8?B?aWcyQ2tSQTUvWkFybCtONzVIZWJxeXZwSytQbWduaE9LNHhJcVZ0SFEySzlM?=
 =?utf-8?B?UTVXajdPbC9vMEErNE8zSFZ1Z2o5dUxmdlRuODIzNldtd2YyMGZvWGtTYld0?=
 =?utf-8?B?cmlxZm9nSldHbGJCOUlaZXh5ZEhPY01yNUNqTDBWWDdXRW5pOHdQV2taYkNM?=
 =?utf-8?B?clVvNGNRcldVUzdENnhjbTRyc1lFQXgvV08yeVYzSVgwc2ZGU1lVRk4zQ25N?=
 =?utf-8?B?dDV1SDZDMXhZZGE0aCtLdnpseEk5aDRZbmRRd0tpYk5aY2JPRk1yN2lSWnU5?=
 =?utf-8?B?a3JyNE5qSFp0ZUozUnFDSkRFMVhDR1FiTFNXOXQ4U0tFVFBheVp2QzFtQlB5?=
 =?utf-8?B?KzFKMFJOV1FVNlROR05kZ2ZzTGFYVEZHVUZTMUVScW5LeFlKZllUdk1JUlg1?=
 =?utf-8?B?eEQ4MUhkRUIyZTFyc3lhOTY5eEVCdGhUQitOeUVvcWNiSkx6TVZXUnhNZHM4?=
 =?utf-8?B?bStBMU1qbEVXRFN0eEIwK0N5Z1FKOSsvTzZPZktFUEZRYmRISzdGcUJpMnBG?=
 =?utf-8?B?dzFsMXF1V1prSEliaHNkQTdPNGtVS3QwMUc0TCtnZENqWFU4SElEVXpreHJC?=
 =?utf-8?B?Ti9sbjJmd0hEVmlqMjY1RlA0a3E2NWRPTURGWWpyMjI0MGQvajNpQk43YUVr?=
 =?utf-8?B?NXJIY1BMeGlHQW14bnEvTlhKQTBjcUtnY1ZTVjNHQ0F4aUVLdkk3SzBPY3NK?=
 =?utf-8?B?N1cvOFRUZWcvdG5Wdmx6Qi82MW5sN3g2b1pNQVNaeU1lUWpUSXZBZkNFaEVp?=
 =?utf-8?B?M2FuZFZqSUI0cjY1T0d6Q05uMk5GdTJPajAwcldjdTdBRU01UUdFb055TWt5?=
 =?utf-8?B?S2luVk5nNlc4SkJ1aVhwdGEwSlZJMllKcmJlV2EwNWlyWS9xTENPK0Y3eUlp?=
 =?utf-8?B?Qkt1MHRLMTQrQTdGZGh5YnFDRHRVa3BrbjdNU2tCWGlBVHZzajBqaXI3T2hx?=
 =?utf-8?B?UnVwRWZKQzJ6a3pXTWhWT2RrSFB1WnovQVlyTFl1emRPdmVobkM3UXh6ZEpo?=
 =?utf-8?B?ckY5UEJNRFNZZ3pXSWtZWWJQY2Z4QnN1MUZ6ZVg5U08zdjNvUGdKeHAwRXNs?=
 =?utf-8?B?TGFhSE1tcy9PcmlYWURVbjJESTNyVDZCbUJWR2h5MXpaRnNZZ0dROUNDOStV?=
 =?utf-8?B?ZzJkb2k0RFlGRUhsNVVKM255TmVYSWNGcWZqOFFxbW5yL2JHREszdkZpL1pJ?=
 =?utf-8?B?aFRKRUxMZE1ScWkxODUyNTljS0c2bzUzMTk2MEFicFBwMFE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QUpRdDJTUHFGazlrOC80b0w3ZE5ybms3T1lrbHZ3NDY0VE5CVUVXeFVMTEFC?=
 =?utf-8?B?N0w3NTF4L3hRbnRnUytoeU9ZcnMrUHhJZFpJNE9kNkZqL1J3VkVIQSs1djNm?=
 =?utf-8?B?bnIzVW91WVZuNUh6bWF4U2VEVjRjc3VnUUk0Ry9OWWc5Y1BmWmFCcXVkNXh3?=
 =?utf-8?B?UjFGb2YvSnZ6NkJZWC9UZjZYekhUTlhEcHIvYmpYS01hVUZwQUlWOCtNNGpV?=
 =?utf-8?B?eXFvYkNYWXRmQ3hNa1ZIcVU4UlhNUkFvaUpLOFZabjBvcS9QeWc4WDNVakhn?=
 =?utf-8?B?QStWdWlVWDZhV3VJZWhqeDI5WEl0S2dlWFpidUlCQ0xzODJtcHZhb3FVREJZ?=
 =?utf-8?B?VzBLRFY0MzRaSWpaWlFEK2JvbFBZWE0vaDhLdndNSmtXTWlxcXlHdkpUQnlS?=
 =?utf-8?B?bzV6L2xsY3VJZ2x3S3A0aTM3T0lJVzdzQ2twNTQ2MlJQMkVuZDd1YklBREpU?=
 =?utf-8?B?U25qK2p4bzFtK1REYTVmVS9UYTBlTlY4ZldlWnlCTGM4WGRyVlVRb0hkN2gv?=
 =?utf-8?B?bURIQS9VdnB1bVBBM1o4RlhQSWdlQmRub2NOUFhZdjc2TU5WRW0xWWFMRVk4?=
 =?utf-8?B?ZTBXbVF2V05WdDZwcjNoZWtBL1JlTmlEcG1jNXZ6MFp4QnU3Q0FIUy9TRnhG?=
 =?utf-8?B?Y1Y0bFpxOUVtSFlDZTM0d2hMelFQTVllRERCeGVZdFp0WjFnZ29BczdLVHJP?=
 =?utf-8?B?djZMMjJXd1RhYXpxVDRnaEozemFybndBT1d4TW52UENsd3h2T1owdHNRY2FI?=
 =?utf-8?B?T3B3Nkk0b1hXTlVqT0xzNW9pTmFYRFBCQVJoTkdUTFJJc1gzQjlpNjNJYWU0?=
 =?utf-8?B?TzlQTFE1ZFU3aVY4V1E3UXYzY1ZCb3psQStHc1pLdTZBb2NtWE9RbFpyWlZi?=
 =?utf-8?B?ekpkYjJxc05PYWYyNjc1SEI5S0dKWmVsN29xZDRTNUNzdEs4bWthMHlqNUZN?=
 =?utf-8?B?R2hYRFlqTmVnWE1kR2lIOXBEL3JManBaWTA1WWNGWFBvOG5NZ2k3T01ZeFpm?=
 =?utf-8?B?U0Y5SHB3Z3ZPS0VOZHlOTU45ckRPZ09iOFo4Z29Sb0djTFFTeHoxaFZ2dE9u?=
 =?utf-8?B?NGhwd1pIcHpJWm1HNmlFdkh6Tzl1VDF2VEJsNlJ3WmFGRGd0aldWVFM3SEFG?=
 =?utf-8?B?U2JNWklBcTgyTnBOdDA3eFBVQXI0clY2Yzlwc05zZW1BZ0NxS2lyNkNMV2g3?=
 =?utf-8?B?VHhlbEFYZytjRTlnbmVoUHZOU3VyWGpxUG5TNzRpODBlWndoL0xjUWhEQ0ZN?=
 =?utf-8?B?RTJPYXJ5c2hKQ3drOWFRYWYyVTBya0NqbUkvb1lFZ29EZzRWcnN5OWQ3YUNi?=
 =?utf-8?B?UkZEVlYxMzVRSGcxV2o0c093NFdTTXplemQrWkRvNjloWXZacm12SlJIZnNi?=
 =?utf-8?B?My9MSEp2YWxHODNIVFNEUlBrcnpiYmszOWYyQ29BS3dOYWFXcVZqVjU3cTho?=
 =?utf-8?B?YVFvVkFhRkJXeFZKUkdHcGRBR3lVWjNtL05ZZU9QNVBHSi8zWlZ6SHNaZWFH?=
 =?utf-8?B?dXBROXJ4U2IrVis1VW52SkRoSUQ4VFl6ZHRLQ21Ma25MYmlueFltWi9RQThs?=
 =?utf-8?B?S1kvN0w0ZlRuNEwzcWVySnZ2ODBqb2FoUk1ncTFScnNGdnd6RFFOd0tJV0dk?=
 =?utf-8?B?VVRTZnhub2tSaW93blQ2TUs0Zm9DbEdKRmZuOWZCakhsbDh2elY4TkhVT2tn?=
 =?utf-8?B?bHo4bUZXS2Q4T0IyL1lJWHhOZ1BGakxabVFJRUN5dFpVQUN2Nm05dnM2MFF0?=
 =?utf-8?B?UTUvOVdUNnhKdXc4c0xCVEVUWTRmMGxYN3lZNmxMZjd0cXY2eEsxcWl6YzEx?=
 =?utf-8?B?dGRRRXNXVitUMW5HN2JMQktDU21BQnU0M0c3VWdPKzkwejdxMmNibVk1WCtC?=
 =?utf-8?B?VGZpd1oyQktFems0ckN4M25DUjFqVTBuVld6U2VSdnp1dVFsTzRKU0FTdFl0?=
 =?utf-8?B?WjRObFZaSHErWGxhRGhNVTJlMHFhZHlJY0ZDSUlVbVdCd0RTOHgxdUxmRStU?=
 =?utf-8?B?UHAzRG51R0x4UzdJL2NXZmpCQ2FuVnBjSFIvNHRwNzl1VFhveS9JZzRxRURR?=
 =?utf-8?B?OXNJZFBFTWoyYWMzMjJxYlVYNXlWWHZUNVF0WlpWekFBQlJpSDB5VTMyRU1p?=
 =?utf-8?B?eExOYTZQV3g1OXJzdW1CRnVDenNkazhRQmlEVTNNOERhbkxwMW02VGR1QmxJ?=
 =?utf-8?B?VHc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e0ac65b-f61d-4d9c-1382-08dcc164c042
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 22:09:24.5709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cy8mx4VNXvvMEmsmqNV0tJ9gvf/zUr7x1vDGMRF5Gun5zlSwZ3E52j/fL5Cc1oVnipGtXSHk75muZiNBsHhrkj8QJAymbCFdGYMn28jHV2A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8134
X-OriginatorOrg: intel.com

SGkgTmhhdCwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOaGF0IFBo
YW0gPG5waGFtY3NAZ21haWwuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBBdWd1c3QgMjAsIDIwMjQg
MjoxNCBQTQ0KPiBUbzogU3JpZGhhciwgS2FuY2hhbmEgUCA8a2FuY2hhbmEucC5zcmlkaGFyQGlu
dGVsLmNvbT4NCj4gQ2M6IEh1YW5nLCBZaW5nIDx5aW5nLmh1YW5nQGludGVsLmNvbT47IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBtbUBrdmFjay5vcmc7IGhhbm5lc0Bj
bXB4Y2hnLm9yZzsgeW9zcnlhaG1lZEBnb29nbGUuY29tOw0KPiByeWFuLnJvYmVydHNAYXJtLmNv
bTsgMjFjbmJhb0BnbWFpbC5jb207IGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc7DQo+IFpvdSwg
TmFuaGFpIDxuYW5oYWkuem91QGludGVsLmNvbT47IEZlZ2hhbGksIFdhamRpIEsNCj4gPHdhamRp
LmsuZmVnaGFsaUBpbnRlbC5jb20+OyBHb3BhbCwgVmlub2RoIDx2aW5vZGguZ29wYWxAaW50ZWwu
Y29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDAvNF0gbW06IFpTV0FQIHN3YXAtb3V0IG9m
IG1USFAgZm9saW9zDQo+IA0KPiBPbiBNb24sIEF1ZyAxOSwgMjAyNCBhdCAxMTowMeKAr1BNIFNy
aWRoYXIsIEthbmNoYW5hIFANCj4gPGthbmNoYW5hLnAuc3JpZGhhckBpbnRlbC5jb20+IHdyb3Rl
Og0KPiA+DQo+ID4gSGkgWWluZywNCj4gPg0KPiA+IEkgY29uZmlybWVkIHRoYXQgaW4gdGhlIGNh
c2Ugb2YgdXNlbWVtLCBhbGwgY2FsbHMgdG8gWzFdIG9jY3VyIGZyb20gdGhlIGNvZGUNCj4gcGF0
aCBpbiBbM10uDQo+ID4gSG93ZXZlciwgbXkgdGFrZWF3YXkgZnJvbSB0aGlzIGlzIHRoYXQgdGhl
IG1vcmUgcmVjbGFpbSB0aGF0IHJlc3VsdHMgaW4NCj4genN3YXBfc3RvcmUoKSwNCj4gPiBmb3Ig
ZS5nLiwgZnJvbSBtVEhQIGZvbGlvcywgdGhlcmUgaXMgaGlnaGVyIGxpa2VsaWhvb2Qgb2Ygb3Zl
cmFnZSByZWNvcmRlZA0KPiBwZXItcHJvY2VzcyBpbg0KPiA+IGN1cnJlbnQtPm1lbWNnX25yX3Bh
Z2VzX292ZXJfaGlnaCwgd2hpY2ggY291bGQgcG90ZW50aWFsbHkgYmUgY2F1c2luZw0KPiBlYWNo
DQo+ID4gcHJvY2VzcyB0byByZWNsYWltIG1lbW9yeSwgZXZlbiBpZiBpdCBpcyBwb3NzaWJsZSB0
aGF0IHRoZSBzd2Fwb3V0IGZyb20gYQ0KPiBmZXcgb2YNCj4gPiB0aGUgNzAgcHJvY2Vzc2VzIGNv
dWxkIGhhdmUgYnJvdWdodCB0aGUgcGFyZW50IGNncm91cCB1bmRlciB0aGUgbGltaXQuDQo+IA0K
PiBZZWFoIElJVUMsIHRoZSBtZW1vcnkgaW5jcmVhc2UgZnJvbSB6c3dhcCBzdG9yZSBoYXBwZW5z
DQo+IGltbWVkaWF0ZWx5L3N5bmNocm9ub3VzbHkgKHN3YXBfd3JpdGVwYWdlKCkgLT4genN3YXBf
c3RvcmUoKSAtPg0KPiBvYmpfY2dyb3VwX2NoYXJnZV96c3dhcCgpKSwgYmVmb3JlIHRoZSBtZW1v
cnkgc2F2aW5nIGtpY2tzIGluLiBUaGlzIGlzDQo+IGEgbm9uLWlzc3VlIGZvciBzd2FwIC0gdGhl
IG1lbW9yeSBzYXZpbmcgZG9lc24ndCBoYXBwZW4gcmlnaHQgYXdheSwNCj4gYnV0IGl0IGFsc28g
ZG9lc24ndCBpbmNyZWFzZSBtZW1vcnkgdXNhZ2UgKHdlbGwsIGFzIHlvdSBwb2ludGVkIG91dCwN
Cj4gb2JqX2Nncm91cF9jaGFyZ2VfenN3YXAoKSBkb2Vzbid0IGV2ZW4gaGFwcGVuKS4NCj4gDQo+
IEFuZCB5ZXMsIHRoaXMgaXMgY29tcG91bmRlZCBhKSBpZiB5b3UncmUgaW4gYSBoaWdoIGNvbmN1
cnJlbmN5IHJlZ2ltZSwNCj4gd2hlcmUgYWxsIHRhc2tzIGluIHRoZSBzYW1lIGNncm91cCwgdW5k
ZXIgbWVtb3J5IHByZXNzdXJlLCBhbGwgZ28gaW50bw0KPiByZWNsYWltLiBhbmQgYikgZm9yIGxh
cmdlciBmb2xpb3MsIHdoZXJlIHdlIGNvbXByZXNzIG11bHRpcGxlIHBhZ2VzDQo+IGJlZm9yZSB0
aGUgc2F2aW5nIGhhcHBlbnMuIEkgd29uZGVyIGhvdyBiYWQgdGhlIGVmZmVjdCBpcyB0aG8gLSBj
b3VsZA0KPiB5b3UgcXVhbnRpZnkgdGhlIHJlY2xhbWF0aW9uIGFtb3VudCB0aGF0IGhhcHBlbnMg
cGVyIHpzd2FwIHN0b3JlDQo+IHNvbWVob3cgd2l0aCB0cmFjaW5nIG1hZ2ljPw0KDQpUaGFua3Mg
dmVyeSBtdWNoIGZvciB0aGUgZGV0YWlsZWQgY29tbWVudHMgYW5kIGV4cGxhbmF0aW9ucyENClN1
cmUsIEkgd2lsbCBnYXRoZXIgZGF0YSBvbiB0aGUgcmVjbGFtYXRpb24gYW1vdW50IHRoYXQgaGFw
cGVucyBwZXINCnpzd2FwIHN0b3JlIGFuZCBzaGFyZS4NCg0KPiANCj4gQWxzbywgSSB3b25kZXIg
aWYgdGhlcmUgaXMgYSAiY2hhcmdlIGRlbHRhIiBtZWNoYW5pc20sIHdoZXJlIHdlDQo+IGRpcmVj
dGx5IHVuY2hhcmdlIGJ5IChwYWdlIHNpemUgLSB6c3dhcCBvYmplY3Qgc2l6ZSksIHRvIGF2b2lk
IHRoZQ0KPiB0ZW1wb3JhcnkgZG91YmxlIGNoYXJnaW5nLi4uIFNvcnQgb2YgbGlrZSB3aGF0IGZv
bGlvIG1pZ3JhdGlvbiBpcw0KPiBkb2luZyBub3cgdi5zIHdoYXQgaXQgdXNlZCB0byBkby4gU2Vl
bXMgY29tcGxpY2F0ZWQgLSBub3QgZXZlbiBzdXJlIGlmDQo+IGl0J3MgcG9zc2libGUgVEJILg0K
DQpZZXMsIHRoaXMgaXMgYSB2ZXJ5IGludGVyZXN0aW5nIGlkZWEuIEkgd2lsbCBhbHNvIGxvb2sg
aW50byB0aGUgZmVhc2liaWxpdHkgb2YNCmRvaW5nIHRoaXMgaW4gdGhlIHNocmlua19mb2xpb19s
aXN0KCktPnN3YXBfd3JpdGVwYWdlKCktPnpzd2FwX3N0b3JlKCkNCnBhdGguDQoNClRoYW5rcyBh
Z2FpbiBmb3IgdGhlIGRpc2N1c3Npb24sIHJlYWxseSBhcHByZWNpYXRlIGl0Lg0KDQpUaGFua3Ms
DQpLYW5jaGFuYQ0KDQo+IA0KPiA+DQo+ID4gUGxlYXNlIGRvIGxldCBtZSBrbm93IGlmIHlvdSBo
YXZlIGFueSBvdGhlciBxdWVzdGlvbnMuIEFwcHJlY2lhdGUgeW91cg0KPiBmZWVkYmFjaw0KPiA+
IGFuZCBjb21tZW50cy4NCj4gPg0KPiA+IFRoYW5rcywNCj4gPiBLYW5jaGFuYQ0K

