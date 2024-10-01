Return-Path: <linux-kernel+bounces-346843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C7E98C992
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 01:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C14531F24719
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 23:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32601D433F;
	Tue,  1 Oct 2024 23:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AX+IX0fH"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FA41CCEE4
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 23:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727826263; cv=fail; b=NB9HOjETtce3IP/GX+IoDDpC0Z9oA/sMwPWanEpemCBuyrHh3+f0demPbUBBFfbPORiWx/Or0C7KEmwyrhh86hMc3X+hpWH7B4yfdZSKEprC3paT7GJbqQJUUP8zG3GSJBzl1SGW9vnsfzm2izbUglD3E2V2v/TmGRLqrRDun3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727826263; c=relaxed/simple;
	bh=FMdrRbqHBwNKV15v2oECZw8iOaW70Ah5JRWeOvkQe5M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Pe9cCLyYViOB46Bx8F0oeysZrh2aqbyJqE+Yzu0XRnb4cKtFgAx8OEpsDO262pMgPx09KA5EjSy22Z4N3IyuoYTaw71Tf2N9dWN5OINc/98KEofjXFWOMm/2pcHcNGwBePXpsskx+qZU91p3CqnONDOGxcrWFPHZpt/w+CbRLX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AX+IX0fH; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727826262; x=1759362262;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FMdrRbqHBwNKV15v2oECZw8iOaW70Ah5JRWeOvkQe5M=;
  b=AX+IX0fHegLwtz5jA6OnI1mD4MnNPoXDK/pHOSkzr/tlly1lMOb8gWq4
   YD1uZ/svuAbP0pmdYrnFUj1KWp9RHboqD00qT0eZ5rnePSwCMEKn66frt
   oW00+POtwzSIDtsLbTqPiWX/4z5xhEcRvpSyitWc1K9wHDI0ptr4SJb5s
   jzyPDKaNLqx+X3d5OC9e5HfuFyb+Vk40i1n9tOG5I90QS7TwOzsuhbn2q
   JC1bFv+qhLVFZbHymtgUyfM/4iBqm40vyY/GLeIA6fe0UrOjLnuLUzyAl
   OeEt0Yy8sEpMrfHScEIF73NYyJaPd7IEgkgkwxw/BkgIzB5+P9Lm4FXfy
   A==;
X-CSE-ConnectionGUID: InS89s3dQAKk+TpmNGJ/1A==
X-CSE-MsgGUID: N11ppaj+QSmO+qqA9fV53Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="26860577"
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="26860577"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 16:44:21 -0700
X-CSE-ConnectionGUID: LsdfUerFScOn9MbDhiuj9w==
X-CSE-MsgGUID: M+IVfcX1RCSY97upbTk0tA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="97188553"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Oct 2024 16:44:20 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 1 Oct 2024 16:44:20 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 1 Oct 2024 16:44:19 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 1 Oct 2024 16:44:19 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 1 Oct 2024 16:44:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LqG4eUd0swZO2pfoytdOxOai5izcRYgzolN34kQMXg9vHC8tHM3ayEQz0tOAmLAgzIsXFzaHaMrwzJH/BMMmEXr2SffGi5R9A2bkSxyN4JFnw5pvVxrItFRby507OIYk4aVPh+/b+DuJ7yxR+cRMyBJ/NqHc0saD/GXLyhrlGp/OViOMxO7VGy9p/NGeg4FJtKX37SIj19aV6kDojTC21PndTKh8VuUArXa4Hfr1nP7fEk9q3W7Onb7AIH+l2lN7IyBEaljmrpgNNbYQ8JF/lGyydazDLBqh24N1hzMCDwb4tFt0Ptd2hbXBLmRz5yBXT2+Mx7CgpUW/glkRhaM8dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FMdrRbqHBwNKV15v2oECZw8iOaW70Ah5JRWeOvkQe5M=;
 b=p5c8Sr/ajac7fv0hvH9g0i4+KdjY8MpZMLG997VWUagW3cTnWUbnByyT2jsbaHkPlvBm8XgmRSQfi6Q4xEKMGrQyn2cVKj5MjctKNd3FCrb/GQ4oH6wLDwzW/c4Dzkyb2gUNp+kEl8WH3y7rN4QeSz9Lxk7vt5RMuQC8jRm0MFIPyoY+pMSz4OA7Mm5f8+DSCdS7p7SO7pWo408ngzEZazpKPhQsOFngLFIg95IlFUNQ+IGgGtFFy+nT/WbLVp+J4WTjvrMLINqc8S0uGw9uExuI7g9B5ugn4P2WaCwZsHjZ6mVlymczGJALL3uKlJJ+cIZFXNLDMmymYIkIqDWmNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by DM4PR11MB6357.namprd11.prod.outlook.com (2603:10b6:8:b5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Tue, 1 Oct
 2024 23:44:16 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 23:44:16 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Yosry Ahmed <yosryahmed@google.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "nphamcs@gmail.com" <nphamcs@gmail.com>,
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "shakeel.butt@linux.dev"
	<shakeel.butt@linux.dev>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"Huang, Ying" <ying.huang@intel.com>, "21cnbao@gmail.com"
	<21cnbao@gmail.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"willy@infradead.org" <willy@infradead.org>, "Zou, Nanhai"
	<nanhai.zou@intel.com>, "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>,
	"Gopal, Vinodh" <vinodh.gopal@intel.com>, "Sridhar, Kanchana P"
	<kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v9 6/7] mm: zswap: Support large folios in zswap_store().
Thread-Topic: [PATCH v9 6/7] mm: zswap: Support large folios in zswap_store().
Thread-Index: AQHbE4XaXdnmYogniUi9EO2aNKPUnLJw9HoAgAAUeVCAAF5igIAAt03ggAABbACAAAF8AIAAR1yAgAAmL4CAAAFHQA==
Date: Tue, 1 Oct 2024 23:44:16 +0000
Message-ID: <SJ0PR11MB567816E2EEA546E103179610C9772@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20240930221221.6981-1-kanchana.p.sridhar@intel.com>
 <20240930221221.6981-7-kanchana.p.sridhar@intel.com>
 <CAJD7tkZh6ufHQef5HjXf_F5b5LC1EATexgseD=4WvrO+a6Ni6w@mail.gmail.com>
 <SJ0PR11MB567830D47190C55F14CE75AAC9772@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkYF+Q2+f-=OK64C1dUqbnMVLLmWU1RDVrfJ9+rjBgqEbg@mail.gmail.com>
 <SJ0PR11MB567885FD8899DA83FB95DE61C9772@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkZk=9Su3vtdFcghD0R+GqSchn5b1L91SgTvxcX79rmdOA@mail.gmail.com>
 <SJ0PR11MB56786A297C3D8DCADC2EF310C9772@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <SJ0PR11MB5678A1858237FBC0DF7A0098C9772@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkZ+mqfKoeJ5d2iCzajoTw8sWduwk4fi20g=wp=4pp_=ig@mail.gmail.com>
In-Reply-To: <CAJD7tkZ+mqfKoeJ5d2iCzajoTw8sWduwk4fi20g=wp=4pp_=ig@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|DM4PR11MB6357:EE_
x-ms-office365-filtering-correlation-id: 3fea67f2-eda0-4a9b-4f2d-08dce272f671
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TkVHd0ZQeVZ0cytnaFJzb0xZUXdNV2d1b0M3SmVadVl2a1JKdjFjTG9wRG9Q?=
 =?utf-8?B?VUZOcEhnakZITDB6SlFSZ09XT2s2dTRLYTkwdDBOQmYyTHk4OVJCd3JKZS9B?=
 =?utf-8?B?Ym5xMVBUb21LTVFobTQ2Nkw3Kyt1VDhqdFRUOXNoMlBkSWw4NE1WYU9EM25t?=
 =?utf-8?B?M1FObTduZWs2dGcyU3JkdVpmOG1IZEVVLy94eUtmditpMDNtRkxmeEFMT010?=
 =?utf-8?B?VXFzQzhPRmdoeVZTdWdhQVJjRlg2U1M4UGZacDhCTndqc2ZkdzdDYUVaRDF0?=
 =?utf-8?B?SnQ2aEZTb2VWWlRYS1JCa1BKSHliKzlVUE83UEtKbUhpR0NucTd5K1djNU1u?=
 =?utf-8?B?bUdLTi9ibnVRQVk1UDNKWndEQVdnOHBUTW9rQzBkSTNkT1lheGJ5VDhzL1J1?=
 =?utf-8?B?bFlwNDBoQUp3SWZqUk93U0xqeTV0RTdGQUNkWjdQRTl3WHI5bXdLeWtUUENq?=
 =?utf-8?B?YkxlaGJTY3hlaVY0TUd6UUJqVkYzMTJ4a0V6QTZreFNzS3hTQWNhSWdKaUhB?=
 =?utf-8?B?bGpqYzNodW4vbEg1ZVVqVnBkdXVOMDRIMUNqZGQ3TDZleTNpM05MUjREUExk?=
 =?utf-8?B?SXZrSiswallzOFZmRExvUUJoSTN1aTlXRzJ0dmluV1VNNWxPcllRSUdWeEhW?=
 =?utf-8?B?UFlWaFZ5MnlrYTdoOVVLb0pvTzlnQnM0N0JNU1ZIWkNjb2ZtVDRUVVNWdG1l?=
 =?utf-8?B?Q0ozbG04bTAyVk1RK1lDVVRFZWpxS1I4ZjR6TXVvVEk2Vng4U2xqZUJHeHVi?=
 =?utf-8?B?czFoQ0JtbmxnazNjcklKblcvYnRiM2ovdEl2cHBrSnZHL01nbUlhZ2d0ZTVp?=
 =?utf-8?B?QXRSUHRyMnJoT0VzWnFTbGl0bXMrRmJBeVRpb2EvNFRMckN0RDNJM2hnME1Q?=
 =?utf-8?B?dWFKZmlDeXJQb0hMUTZKTTJFWmhyUkwydklBb1hwZUV3TWtwRjNpWmJhZzFk?=
 =?utf-8?B?UWVkbmFnbDhIM0lnTXZDRFF3cjl0RGlwRVFwQ2VVR1RRVzUySTJDdkhzaGh1?=
 =?utf-8?B?aFBRZmpiRWkvRHFnVHRDU1djU0llbjIyZk42UFl3OWpFMGJPRUZ1MFQxRTk2?=
 =?utf-8?B?NCs3YzExUmc1TjgvRGQ3UllReXRXeS80UXhhbmJSUXE5R1ZoK3FqekExaGIy?=
 =?utf-8?B?TXpEekpDcWowTHlSb1pxUE1XU2hDRlUzQ1c1djJGYUVZbEwzM2hYRlUzbS9F?=
 =?utf-8?B?cVA2TGg5VzRia1ZwY3NUMW1pbXhYQmN4Y2NCSGFvVWtaZkt5QXMyU0Ewdi9k?=
 =?utf-8?B?T202czlrU29UUllJbFczRkNiNlFVZTFYVzN3VmhoK2JXV1p2aFRCeGpJa1hQ?=
 =?utf-8?B?aHhPOUFGRFhnRVBHNjhTU0o4R0tUKzlwRHNyeHNLQUw5VHdGZG8vaTlycVJS?=
 =?utf-8?B?NDFaV215VVgvb0dMQ2tZQlZ0UEVKK05MVjJwMVdERG1SdzR5RzhsYk9NT3lk?=
 =?utf-8?B?UGppVnpBdk84U0M5RWIyaE5CV0doZ0l5ZkZJTHYwSDBVNktiWmZFUlJscGkx?=
 =?utf-8?B?Uk90SHY4UlJFTy9Tc1daMm1xMWNCZXg4aGd6TVRiaTdTWVlRcy9DZ3ZKb2VP?=
 =?utf-8?B?VVROMldBaUlGd0hjN0VvdlhzSHpHT2E2WjJGZkZXUkJWV0szZTVCaVpaMlZz?=
 =?utf-8?B?alVlLzlJa0k0K1JVNUZ0SGZld1dFOUQwU3FMdlpwNWhpaEFVTE1xOXQxdzQ2?=
 =?utf-8?B?OCs4eGVxVXZycWtGeGI4SUM1a0VOUDRrOFFvWHhWWCtHUGlHK25zMHI5OFU5?=
 =?utf-8?B?S2N1NmtaKzF5V25KQUpRZmpZVW0wai9MK3BsRHdIRWlENklpazRjN28vU1NM?=
 =?utf-8?B?V3VrZlh0Q1Npc2oxZlEzdz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cVBaKzBXU2NZS0R3eW85REpHUTFpTHlhTGdzb2RJalpINzhIS1UrbHFkU3NG?=
 =?utf-8?B?aUxpY3ZsU3VhYnp3d0tZNHpjSXVqbHNJeTcvbXZyNkdFU3hLbE5jRUpDNGla?=
 =?utf-8?B?YjBLNkZRcHhsaFhhRmR5Mld2b1pLUldGUCtoRko2Mis1SWk3WkxWODV4bTBn?=
 =?utf-8?B?aTFjZnh4b1hmLzk4MXJtQ1luZXFOM3hMVG92d0tzelJyNkZVdk1ETmFlRXNQ?=
 =?utf-8?B?ellPcWNzbG5tQzI1T01OTnNXeGZDeUhmMDNmOFVOa2lFL014MlFBaHZaSjFk?=
 =?utf-8?B?c1A5RG54V2lyMm5KSlhyMk1ERmRtZDU5WVkvZzNHcklkTW5OYVNzYUlyK3Rp?=
 =?utf-8?B?QTQwOGVxRDBMUmlobVZHMDZyRGVaM3M5NC9jWGJaeDQxSlFWa3phUXdwdHIv?=
 =?utf-8?B?V0V3dXE4QzdyYmpIOTZvaEpUaFo2SWVPNDYrcFc2U2VnTHZ0bDRHNTdjZm1M?=
 =?utf-8?B?ME9obWY1d2I0QTVRNTVQV0lVSzh5enptcnRzYmFoY2E3b0hsT1RFcTZiZXNr?=
 =?utf-8?B?UEc1cDNUUGl6U3h2dGQvaVdGZWdDWlVITDNsVXlwMkFEbEpmNjdxVGV0bEdR?=
 =?utf-8?B?ZnQvQ1l6aCtic1ZBR2UzdU1USTN0cEhPd2cxRlY5b1V4QXQ2Y3I5NVFmK1N4?=
 =?utf-8?B?NytMZ1ZRRG1vcmROelNValFGSFdPSjIxOWgwVDRkQmhPOGg2OEkwWnVmUEF2?=
 =?utf-8?B?a2hqYUZPaHFyaXZCLytzTUYvU1dLN3FPVTdrUmJQZTVxTkJtVnVFYTIwd1ds?=
 =?utf-8?B?ZVM1ZFU0ZTYvSXQrOW84SUJrZVQxKzV2WDM2ZThjdnlleXRvMGVhMkU5OEFF?=
 =?utf-8?B?dU5lVWJaSk5tUUFRT1R6NnNoYlp5V3JDWjZNWE5PNzQrdDNDTTJjK3VaZUF5?=
 =?utf-8?B?QWduY05wd1pmMHBRN2ErZC8wS3RCbzFERUxPY3Z0ZVhpN1docmt5U0w5bXJU?=
 =?utf-8?B?MmE5ZTFtRmREOFZ6S0hlL3UzczFlSENCYnk4SkI3WktubEtGMnNpRDlrb2Jo?=
 =?utf-8?B?dFlTRTVhbVZEeWJ0aGdlaVh3RHhXOTBlZ0gwMEg1S3hjWHRXQVJ2VUR4N0RY?=
 =?utf-8?B?cm1YNHdTSWwvWEpEcFloKzN5Kzhja0NvNEl3SGQ2dnRERDhiK2o5cVRvaVUr?=
 =?utf-8?B?ZndJUVhDa1I3YzJBUEdaN1Z0anBzUjdqYXBtTlZKdEZlNmJZUDRtUmw1N1F6?=
 =?utf-8?B?aU45MTFTdW9uSUVRWWQ5dkJjc1Y3ZUpQcytueWJKVGhmeUhzaDdRc2dLeUJV?=
 =?utf-8?B?cnRpZVdqWmh0ZjVwcmozU2lzV3NmSWJIQWVXZDc4cnVjTmF1SWxZcU1nclJU?=
 =?utf-8?B?YlUwR2dEZkRNTFRzd3FEblU4eDA0NGJIcDhyRUZKTnFmRVNZTzU3cjNZWUpk?=
 =?utf-8?B?Y05VMGJ2enlxTWpPMDk3dnhsSjJqdHRhSXRXSFp1a3g2VTRvT1FmdDZOMGp2?=
 =?utf-8?B?QStFaUVIbHl5eFR2Umo0Sno2SkE3bnRNSFRNcVRUUHlxZ05QdHBSRDNycTJV?=
 =?utf-8?B?WVFHTDMzYjNsTEdDRHBYakVwM0lkQk9Pa05hYnB5VTgrT1k2R3lkTHRJd0s5?=
 =?utf-8?B?ZExtb2JyUlNqcXcrSDRzOW4vMU13alNzTFlhRG1MbWxidjlDY0Z2MktOQzVD?=
 =?utf-8?B?aDZsZGF2eXhKQTRJalU4UDZwb0NRR2pOcDBEOEhWZHdGcmhGVktMRW9Cblg0?=
 =?utf-8?B?eEg4QTJ3L3U4eStYRzZuLzRsaGZaU291T05lUXIybnAzU3NBWlRFYlJCZ1Zn?=
 =?utf-8?B?MzVZeVYyMUlFdkVuaHkvQkkzbHhLUXIvR3JSSVVEUDYvbTBveC9JZENVY0tU?=
 =?utf-8?B?ZEF5aGU0UjU1L01ENmUvSXJjT3o2ckdlRWNONGszTVBCOGlORW9aSnRuRUJ4?=
 =?utf-8?B?aHM5bS9wVVpnQ2R5VzlHU1NTQWVSV2I3MFZZY04yOUtRbnJmcmE3YnJKYk15?=
 =?utf-8?B?MVhhNk5NeUV1R3RjbTNlZXpwckkwWW9aN2o0RklJYi82N01VZVZLNVk0Vnc3?=
 =?utf-8?B?WWNaY0RQbVVZdkJOblBINFNxdWtRdEFEVElCemhHMjJiQ3FLUTN2U24vYkFy?=
 =?utf-8?B?V0JpQVkza0ZmdWtudzJmUGtSRlhYVURBUWZCQXdiTUFPVHZHS3c1cmg3WnpE?=
 =?utf-8?B?NjVyQzR4WVRGRU05T2Fkbk5lQXRjTU4rUnZxcU1YNXVISnpwb0dOMEloQWRl?=
 =?utf-8?B?T2c9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fea67f2-eda0-4a9b-4f2d-08dce272f671
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2024 23:44:16.8067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HZJSpS8HAYhxMNkaCv8OEOBliOxlrJ+SN2SD5RNd2kT4NlTpnjKYwVCDVG3L33vC+wAo+m+UALlIAsz9lbHjL5yHtmIT+3tSOZl78lVIpQo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6357
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBZb3NyeSBBaG1lZCA8eW9zcnlh
aG1lZEBnb29nbGUuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBPY3RvYmVyIDEsIDIwMjQgNDozOSBQ
TQ0KPiBUbzogU3JpZGhhciwgS2FuY2hhbmEgUCA8a2FuY2hhbmEucC5zcmlkaGFyQGludGVsLmNv
bT4NCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LW1tQGt2YWNrLm9y
ZzsNCj4gaGFubmVzQGNtcHhjaGcub3JnOyBucGhhbWNzQGdtYWlsLmNvbTsgY2hlbmdtaW5nLnpo
b3VAbGludXguZGV2Ow0KPiB1c2FtYWFyaWY2NDJAZ21haWwuY29tOyBzaGFrZWVsLmJ1dHRAbGlu
dXguZGV2OyByeWFuLnJvYmVydHNAYXJtLmNvbTsNCj4gSHVhbmcsIFlpbmcgPHlpbmcuaHVhbmdA
aW50ZWwuY29tPjsgMjFjbmJhb0BnbWFpbC5jb207IGFrcG1AbGludXgtDQo+IGZvdW5kYXRpb24u
b3JnOyB3aWxseUBpbmZyYWRlYWQub3JnOyBab3UsIE5hbmhhaSA8bmFuaGFpLnpvdUBpbnRlbC5j
b20+Ow0KPiBGZWdoYWxpLCBXYWpkaSBLIDx3YWpkaS5rLmZlZ2hhbGlAaW50ZWwuY29tPjsgR29w
YWwsIFZpbm9kaA0KPiA8dmlub2RoLmdvcGFsQGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCB2OSA2LzddIG1tOiB6c3dhcDogU3VwcG9ydCBsYXJnZSBmb2xpb3MgaW4genN3YXBfc3Rv
cmUoKS4NCj4gDQo+IFsuLl0NCj4gPiA+ID4gPiA+ID4gPiA+ICBzdG9yZV9mYWlsZWQ6DQo+ID4g
PiA+ID4gPiA+ID4gPiAgICAgICAgIHpwb29sX2ZyZWUoZW50cnktPnBvb2wtPnpwb29sLCBlbnRy
eS0+aGFuZGxlKTsNCj4gPiA+ID4gPiA+ID4gPiA+IC1wdXRfcG9vbDoNCj4gPiA+ID4gPiA+ID4g
PiA+IC0gICAgICAgenN3YXBfcG9vbF9wdXQoZW50cnktPnBvb2wpOw0KPiA+ID4gPiA+ID4gPiA+
ID4gLWZyZWVwYWdlOg0KPiA+ID4gPiA+ID4gPiA+ID4gK3B1dF9wb29sX29iamNnOg0KPiA+ID4g
PiA+ID4gPiA+ID4gKyAgICAgICB6c3dhcF9wb29sX3B1dChwb29sKTsNCj4gPiA+ID4gPiA+ID4g
PiA+ICsgICAgICAgb2JqX2Nncm91cF9wdXQob2JqY2cpOw0KPiA+ID4gPiA+ID4gPiA+DQo+ID4g
PiA+ID4gPiA+ID4gSSB0aGluayBpZiB3ZSByZW9yZGVyIHRoZSBmdW5jdGlvbiB3ZSBjYW4gZHJv
cCB0aGVzZSBjYWxscywgbWFrZQ0KPiB0aGUNCj4gPiA+ID4gPiA+ID4gPiBjb21tZW50cyBwb3Np
dGlvbmVkIGEgYml0IGJldHRlciwgYW5kIGNlbnRyYWxpemUgdGhlIGVudHJ5DQo+ID4gPiA+ID4g
PiA+ID4gaW5pdGlhbGl6YXRpb25zLiBJIGFtIGFsc28gbm90IGEgZmFuIG9mIHBhc3NpbmcgYSBz
ZW1pLWluaXRpYWxpemVkDQo+ID4gPiA+ID4gPiA+ID4gZW50cnkgdG8genN3YXBfY29tcHJlc3Mo
KSB0byBnZXQgdGhlIHBvb2wgcG9pbnRlci4NCj4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4g
PiA+IERvZXMgdGhlIGZvbGxvd2luZyBkaWZmIGltcHJvdmUgdGhpbmdzIG9yIGRpZCBJIG1pc3Mg
c29tZXRoaW5nPw0KPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiBXZSBzaG91bGRu4oCZdCBi
ZSBhZGRpbmcgdGhlIGVudHJ5IHRvIHRoZSB4YXJyYXkgYmVmb3JlIGluaXRpYWxpemluZyBpdHMN
Cj4gPiA+IHBvb2wNCj4gPiA+ID4gPiA+ID4gYW5kIG9iamNnLCByaWdodD8gUGxlYXNlIGxldCBt
ZSBrbm93IGlmIEkgYW0gbWlzdW5kZXJzdGFuZGluZw0KPiB3aGF0DQo+ID4gPiA+IHlvdSdyZQ0K
PiA+ID4gPiA+ID4gPiBwcm9wb3NpbmcgaW4gdGhlIGRpZmYuDQo+ID4gPiA+ID4gPg0KPiA+ID4g
PiA+ID4gSXQgc2hvdWxkIGJlIHNhZmUuIFdlIGFscmVhZHkgaW5pdGlhbGl6ZSBlbnRyeS0+bHJ1
IGFmdGVyIHdlIGluc2VydA0KPiA+ID4gPiA+ID4gdGhlIGVudHJ5IGluIHRoZSB0cmVlLiBTZWUg
dGhlIGNvbW1lbnQgYWJvdmUgdGhlIGNhbGwgdG8NCj4gPiA+ID4gPiA+IHpzd2FwX2xydV9hZGQo
KS4gQmFzaWNhbGx5IHdlIGFyZSBwcm90ZWN0ZWQgYWdhaW5zdCBjb25jdXJyZW50DQo+ID4gPiA+
ID4gPiBzdG9yZXMvbG9hZHMgdGhyb3VnaCB0aGUgZm9saW8gbG9jaywgYW5kIGFyZSBwcm90ZWN0
ZWQgYWdhaW5zdA0KPiA+ID4gPiA+ID4gd3JpdGViYWNrIGJlY2F1c2UgdGhlIGVudHJ5IGlzIG5v
dCBvbiB0aGUgTFJVIHlldC4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFRoYW5rcyBmb3IgdGhlIGNs
YXJpZmljYXRpb24sIFlvc3J5LiBTaW5jZSB0aGlzIGlzIGEgY2hhbmdlIGluIHRoZSBlbnRyeQ0K
PiA+ID4gPiA+IGluaXRpYWxpemF0aW9uIHdydCB0aGUgbWFpbmxpbmUsIGlzIGl0IE9rIGlmIHRo
aXMgaXMgZG9uZSBpbiBhIGZvbGxvdy11cA0KPiBwYXRjaD8NCj4gPiA+ID4NCj4gPiA+ID4gU3Vy
ZS4gV2UgY2FuIGRpc2N1c3MgaXQgc2VwYXJhdGVseS4gRG8geW91IHdhbnQgbWUgdG8gc2VuZCBh
IHBhdGNoIG9yDQo+ID4gPiA+IGRvIHlvdSBpbnRlbmQgdG8/DQo+ID4gPg0KPiA+ID4gVGhhbmtz
IFlvc3J5ISBJIHdpbGwgc2VuZCB0aGUgcGF0Y2ggc2VwYXJhdGVseS4NCj4gPg0KPiA+IEhpIFlv
c3J5LA0KPiA+DQo+ID4gSSBhbSBwcmVwYXJpbmcgdGhlIGZvbGxvdy11cCBwYXRjaCBzbyBJIGNh
biBzdWJtaXQgaXQgb25jZSB0aGlzIHBhdGNoLXNlcmllcw0KPiBpcw0KPiA+IG1lcmdlZCB0byBt
bS11bnN0YWJsZSAoc2luY2UgdGhlc2UgY2hhbmdlcyBoYXZlIGRlcGVuZGVuY2llcyBvbiBteQ0K
PiA+IGV4aXN0aW5nIHBhdGNoKS4NCj4gPg0KPiA+IElzIG15IHVuZGVyc3RhbmRpbmcgY29ycmVj
dCB0aGF0IHRoZSBmb2xpbyBsb2NrIGFsc28gcHJvdGVjdHMgYWdhaW5zdCBzd2Fwb2ZmDQo+ID4g
aGFwcGVuaW5nIGluIGJldHdlZW4gYWRkaXRpb24gb2YgdGhlIGVudHJ5IHRvIHRoZSB4YXJyYXkg
YW5kIGluaXRpYWxpemluZyBpdHMNCj4gPiBtZW1iZXJzLCB3aGljaCB3aWxsIG5lZWQgdG8gYmUg
dmFsaWQgZm9yDQo+ID4gc3dhcG9mZiAtLT4gLi4uIC0+IGZyZWVfc3dhcF9zbG90KCkgLS0+IHpz
d2FwX2ludmFsaWRhdGUoKSA/IFdvdWxkDQo+IGFwcHJlY2lhdGUNCj4gPiBpdCBpZiB5b3UgY2Fu
IGNvbmZpcm0uDQo+IA0KPiBZZXMsIHRoZSBmb2xpbyBsb2NrIHNob3VsZCBwcm90ZWN0IGFnYWlu
c3Qgc3dhcG9mZiwgYXMgdGhlIGZvbGlvIG11c3QNCj4gYmUgaW4gdGhlIHN3YXBjYWNoZS4NCj4g
DQo+IEZvciBzaG1lbSwgdHJ5X3RvX3VudXNlKCkgKGNhbGxlZCBieSBzd2Fwb2ZmKCkpIHdpbGwg
ZW5kIHVwIGNhbGxpbmcNCj4gc2htZW1fc3dhcGluX2ZvbGlvKCksIHdoaWNoIHdpbGwgbG9va3Vw
IHRoZSBmb2xpbyBpbiB0aGUgc3dhcGNhY2hlLA0KPiBmaW5kIGl0LCB0aGVuIGxvY2sgaXQgYmVm
b3JlIHByb2NlZWRpbmcgdG8gZGVsZXRlIGl0IGZyb20gdGhlIHN3YXANCj4gY2FjaGUgYW5kIHVs
dGltYXRlbHkgZnJlZWluZyB0aGUgc3dhcCBlbnRyeS4NCj4gDQo+IEZvciBhbm9ueW1vdXMgbWVt
b3J5LCB0cnlfdG9fdW51c2UoKSB3aWxsIGNhbGwgdW51c2VfbW0oKSAtPiAuLiAtPg0KPiB1bnVz
ZV9wdGVfcmFuZ2UoKSwgd2hpY2ggd2lsbCBhbHNvIGxvb2t1cCB0aGUgZm9saW8gYW5kIGxvY2sg
aXQgYmVmb3JlDQo+IGRlbGV0aW5nIGl0IGZyb20gdGhlIHN3YXAgY2FjaGUgYW5kIGZyZWVpbmcg
dGhlIGVudHJ5Lg0KPiANCj4gdHJ5X3RvX3VudXNlKCkgd2lsbCBhbHNvIGxvb3Agb3ZlciBhbnkg
cmVtYWluaW5nIHN3YXBjYWNoZSBlbnRyaWVzLA0KPiBsb2NrIHRoZSBmb2xpb3MgYW5kIHRoZW4g
dHJ5IHRvIGZyZWUgdGhlIHN3YXAgZW50cnkuDQoNClNvdW5kcyBnb29kIFlvc3J5LiBUaGFua3Mg
Zm9yIHRoZSBleHBsYW5hdGlvbnMhDQoNClRoYW5rcywNCkthbmNoYW5hDQoNCg==

