Return-Path: <linux-kernel+bounces-340969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD079879A9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 21:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C600B24A8E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 19:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475EF1714B3;
	Thu, 26 Sep 2024 19:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hsd/oUhe"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22CC1494AC
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 19:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727379386; cv=fail; b=l0zBz/wYiA4jzUW5L/FuoEmqSNbUsUzVy+224uf56WRG6uCvCYnlVUIZhUXUAskl7mibIxtz8Cnk9NB2J9v85VolNdgLqhEBYENRRIkW/Lh5MGHJi0LkXSpH0x9aaSNc0rn7A0s8s+OAoNmC0zs9ar3sIox/ikAQnWrjKherQxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727379386; c=relaxed/simple;
	bh=Yxp0TE7a5fYMx8EaKaWR7Th08wlauYUTVJvLwqOcekE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EwIfhfdK85MYboQWTjd1CN3QN7770/T4eKr+9lUuuQyUwgZxXTu+vY4xhf16kLfcWPqHAFXCsBEAaN2pIRxS9CFFm+ClMIEaEXXsuGDdFnyJTtaVKVrrjw4tMoN3Mo5xDPA5Pf4XcXft5Vq+nerM5ClabJlBrN4O98UBA5rLmeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hsd/oUhe; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727379383; x=1758915383;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Yxp0TE7a5fYMx8EaKaWR7Th08wlauYUTVJvLwqOcekE=;
  b=hsd/oUhe75pQ8eORO6fRE5HmZ3glKls0pSL6ycCrm7w12jY+rFyMxdgi
   PLMf/32DBdI/k153wgZ0BRtJlOixuJKZJZSr3FBa9S3M/D+9dGUGV5Qqj
   3gWKlABi0fUZ/iSpdOFzniHY8OGiJyvz3ZBfqC668ScA+1rwBr4C4qH97
   1c5ksD/M5E8ev6Fg3ztT9+ukRlYNIz8msmNX4nMb3eCikF+G3q7S1X3SD
   sOmZV2bPkS/DcsEpcym/hz8zuGAOrFaMGy4l8HdPQl4Wvuc4ADTkX5nF3
   5MsxPFGkFGn93UEv0KGs0pbZPoKpx5fZWbia5PVp2ktR+uwWGQIFJflY9
   g==;
X-CSE-ConnectionGUID: OrCmdKy9TDCYIX93BIditg==
X-CSE-MsgGUID: WrmiQYdWQQmWFLxzgXk3xg==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="14125575"
X-IronPort-AV: E=Sophos;i="6.11,156,1725346800"; 
   d="scan'208";a="14125575"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 12:36:23 -0700
X-CSE-ConnectionGUID: wK6aaB0ITdqjq/fp4QY91Q==
X-CSE-MsgGUID: n0wvss3PTvKR9YUsaeX+6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,156,1725346800"; 
   d="scan'208";a="76348565"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2024 12:36:23 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 12:36:22 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 12:36:22 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 12:36:21 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 26 Sep 2024 12:36:21 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 26 Sep 2024 12:36:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JYSdqqslcnf6I4ayfO3r4hZZegP9/jHhH7l97VRRz2J60uk2yjdRfjc5dT6Nx2Mh1lb+sCRx7tLd6eAhG0XhgD9bTyEbcoX4l7ueLxpmcb7bVTda3FwPYynPywPbWEfdALAryt/+TOBtF0+vKaYo+XsKg+DCwtrMu8RXvthw4evjOTSoZ81Ia75pW20W0MHlBRPfQjSdUsQP/40QpNivx3Wm87wZtAxUDahD5aB59C+8KweUBLfaVRJHm0olU03fZPFH0Gv0QLw7byUCmlS+qRL67SRsfLzIkA1sK2t87MfaknMiNZDrusyny28aqqnvSC5DmAPZ5KQ3NZFTp3DEcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yxp0TE7a5fYMx8EaKaWR7Th08wlauYUTVJvLwqOcekE=;
 b=S7voaqYU2o2TMghahh28ZVtTWHDiHzbaX3fmna6bL/6GNAsdokmY3DDU0U33zELiuW2VJ/xEm3+D5vGmKsVRSjSmnsbVr9fVp/o0z5d3vijDJAteSwrdbUfM7urWY8NCIrv4RMc3D5RdvqvacdDtDFPnyBMpO/pLMksaVF7uoJV76ILBE1jAUDak+ZQVIAoxQlel1QCpjzR6i8XvsyO41+M5SGrbdMu3AhmVO97z4TEtvzAZZnApYE+J7m3pd+9qdIJVwgEd7L5DbPa4JPhwXjDJbhvi+E6en/eb9aX/EOoN+FkBrgY7Q2UvVMbPcDP5mripREuZ4PygRx0MAEttww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by BN9PR11MB5225.namprd11.prod.outlook.com (2603:10b6:408:132::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22; Thu, 26 Sep
 2024 19:36:18 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 19:36:18 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Yosry Ahmed <yosryahmed@google.com>
CC: Johannes Weiner <hannes@cmpxchg.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"nphamcs@gmail.com" <nphamcs@gmail.com>, "chengming.zhou@linux.dev"
	<chengming.zhou@linux.dev>, "usamaarif642@gmail.com"
	<usamaarif642@gmail.com>, "shakeel.butt@linux.dev" <shakeel.butt@linux.dev>,
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, "Huang, Ying"
	<ying.huang@intel.com>, "21cnbao@gmail.com" <21cnbao@gmail.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "Zou, Nanhai"
	<nanhai.zou@intel.com>, "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>,
	"Gopal, Vinodh" <vinodh.gopal@intel.com>, "Sridhar, Kanchana P"
	<kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v7 6/8] mm: zswap: Support mTHP swapout in zswap_store().
Thread-Topic: [PATCH v7 6/8] mm: zswap: Support mTHP swapout in zswap_store().
Thread-Index: AQHbDh+C+ZYgIzdq4EuvViy0xt7aPLJnVm0AgAEuMgCAAFEmAIAADdcAgAAFSgCAAAmZgIAADtIAgAAWxLCAAFmCgIAAEe0AgAC+71CAABHrAIAAANsggAADTYCAACB8sA==
Date: Thu, 26 Sep 2024 19:36:18 +0000
Message-ID: <SJ0PR11MB5678DCB6B67A454C83A1501DC96A2@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20240924011709.7037-1-kanchana.p.sridhar@intel.com>
 <20240924011709.7037-7-kanchana.p.sridhar@intel.com>
 <CAJD7tkbd=H+=wx0gnu8sh44hOmx7BE3G3oSxi7zt+o3HKJthkA@mail.gmail.com>
 <20240925134008.GA875661@cmpxchg.org>
 <CAJD7tkY8D14j-e6imW9NxZCjTbx8tu_VaKDbRRQMdSeKX_kBuw@mail.gmail.com>
 <20240925192006.GB876370@cmpxchg.org>
 <CAJD7tkY-ayU3Ld+dKTLEEG3U72fGnCbiQgZursK+eGMXif_uzA@mail.gmail.com>
 <20240925201323.GA880690@cmpxchg.org>
 <CAJD7tkbCDe1Y__0vUKt9q0dz_sXM74fKGQo2Zgq9CJ8=FEjH3w@mail.gmail.com>
 <SJ0PR11MB5678EC9681960F39427EABFFC9692@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <SJ0PR11MB56781A134838ADDD04731AA3C96A2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkYtVR6fi1R2O+jAxVfj7BJ2EKWbXHke9fkv_m=mf5pkFQ@mail.gmail.com>
 <SJ0PR11MB56785027ED6FCF673A84CEE6C96A2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkaRjrPTdCCAA0zSVyAZ2sCKiJUC36J0fsajdtp1i_JZeg@mail.gmail.com>
 <SJ0PR11MB56781678BE55278052EB590CC96A2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkaU4pdGZ4yJrn2z+dECrsbpByrWSc0XcrE6zA_QjSZBSg@mail.gmail.com>
In-Reply-To: <CAJD7tkaU4pdGZ4yJrn2z+dECrsbpByrWSc0XcrE6zA_QjSZBSg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|BN9PR11MB5225:EE_
x-ms-office365-filtering-correlation-id: a0af936d-6ef1-49f4-fa92-08dcde627e44
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YWdMNkFFSWRKUDY4TFk1eXZGSUZkTE5lQSs1dzVhMmdraEpSOUx4RnNIM2Jy?=
 =?utf-8?B?RDdoVXliejF2UnY2LzN4bGxhTFpPNVdMT1YzdExyeFlmNWtycWxWN2F6QitV?=
 =?utf-8?B?a2NsZ3R4TmZUZGJyQ2diK08zSlptZ1Q4V1k4OFFJYmIrNWlSaW1NMXBHcU1G?=
 =?utf-8?B?VkQrZEtXaFRHa1VReVBRMG9IVG43d1pBanBCa28wNHRpM0drbDFuZHNWNGY4?=
 =?utf-8?B?ZUVMUTZ4bUpYTUYzeVFBdUFndWxDZjBCZE9yVmJLMHR1MFNrWmpKUi91aWlz?=
 =?utf-8?B?VVJHalVSM0M4KytMRisya3VxSk5uLzZSOGp2WnI5bUN3ZUt6ZEUxWG13eCtt?=
 =?utf-8?B?WW9FNXo4b09kVjVEd3VnZW0wbytuKytta2VJYjA3bTgrYVVIa3c0R2p6OFly?=
 =?utf-8?B?T2pWNUdxMy9JcGF5Wi9PQitWdklCdXFHZHRLTTBlR25KS0JiRnBvMnp4UXZk?=
 =?utf-8?B?VUFtMGdWWE1vOERjQkVhSXlVaG5CQmR3TG9kSmE2VGdNcWhkRXJXNUg5Q2tH?=
 =?utf-8?B?V0x3YUNzbTMvWUY3bEZrSy9pQ1hDU3c3SHl6TEh6Tm84STFBTHFUajZjYmsy?=
 =?utf-8?B?blNGckVXRGo4ZWhJMUNSSGE3OHdhbExPRmVOOG0vMnBRenBPM1pzeHhoUytW?=
 =?utf-8?B?YnoyblhvRkhrOHQxR3pZc0V5blI4NTFQZXlRRWU0U1h6Q3hqejRkclhmd1Bx?=
 =?utf-8?B?V2dNeE8vdHUxSm9iMW96anV5bXAvMVUwZjlISDNlcE8wTzdTaTI4eXN5Q0RI?=
 =?utf-8?B?KytUa0ZGY3FISmVCY0F6SWhZdk1QQTVDakV0Z2V4anBEbEpOOG1IUWZINEw3?=
 =?utf-8?B?S0pQRFQzemNuUDgxajBPYjdUQXpoUm9aM1RYQXpveTd1T3dJc0FMNHVPT2FP?=
 =?utf-8?B?OEJVbWVDSktJaVpEOXo2U3dVVjRxMURONXlMSnRQeC91enhQRURNeDRUaDdD?=
 =?utf-8?B?R1dvRCt2L2RIemVodWlIODc4Z1B5bmhmTmhZbVV0bmM0b1g3eVJxZFFycGZl?=
 =?utf-8?B?YTNlalFNNXkzVGFadlk0M0djbEVycjdVN2RpWjB3YndHNmFycENuNERSU0pj?=
 =?utf-8?B?d1BTdmFnd2EvNG9tOTdQcFdoSDZVUHY0ZjQrNllNQzRiU1k4OXFxNTNWcE5a?=
 =?utf-8?B?Q3NNdCtjbER4RHBQZ3pLeTlaVEorc1dJU0FiRlRSd1Q4OFJ3eDAyNHBoRDBH?=
 =?utf-8?B?K004UnpKTVZ4bU9iYjZhL1ZCZVNMM2w3Um1MRXB3SGFzMDBxMXluMGNPaGhw?=
 =?utf-8?B?ZnM1OHdDTTZjRmRObmdhOFY4SVJuR2w3ZGF2UDl2RlZDTGw3ZWFWekxzL1Fs?=
 =?utf-8?B?eU4zUHYyMzFiTU1KYkdBTjR5QlJnL3BhaFBpVkcvR0NOb2JHRUYyNTlQZ21W?=
 =?utf-8?B?LysyNmNQc0xQcEJxaDFmQlBLVVo1cVZhVEpTcFJBOVhINmdEd2s3bDh0aFhm?=
 =?utf-8?B?NHMrMDVMQ3h1Y1hWeE1JUWdjUWxoVS82aFdnRkw3MzBGdFZQdGYwRkpha29n?=
 =?utf-8?B?dkpwTVhzdzZkRkVIM282ZmxHNkRpU1lpR3RSTmFmQUxWcHY4Qnh6YnFOM0g4?=
 =?utf-8?B?K0YrWUtOUFVPSmpkMHl6aGkxNnp1NnpJTFJRWlA3dnh4V0VrSWVGVkV6UUFD?=
 =?utf-8?B?RTFacTBGRko4YXZLalorNzd4TGVTY2pkS0NoWDE1WXF6aXFHQWw3TTZndHZu?=
 =?utf-8?B?MjFGTXpGbW5OMk9JUWQ1T21nT1FLVTE0WlVFczVsL0llb0NMT0pNbWxZZndo?=
 =?utf-8?B?SnNsc1hTR2xmc2VvSHBMMDNnM3JBOFNzYSt6eG1QR1p3ZlNnT29PZkQ4cmo5?=
 =?utf-8?B?MU9PdTc0U1JzVlJZNzhubTd5Zy9lU3YvdGtLRTJURWlUUGNLZEJsR1NYdUQx?=
 =?utf-8?B?aFU3UnZISTVLRTBDOVZBV1d3RFZqYkt0bUZvTXBDcnpJb3c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eG1MYnFnM3hjZnRSV1N0VXlpZElJYWJjaU93L3lyVDdhRkFwU3dnRjVOR3VL?=
 =?utf-8?B?ajZ4TGlTQ0hSR21ZWG9wWEgyMmVMU1d2RFZxZjdVV0c0dFVxaGl3czVyRHh2?=
 =?utf-8?B?ME4wRnZnWW14VDBCSzMwZTI0TnBsZHZ4cHh3WExmQVRKMVIxWldmcUpzWDF1?=
 =?utf-8?B?ZHFuR0pHM2c3SlV5UkgxOWRHRjQybGUyRjQrcVZwc2VYeVBpL0xSSWMyNEJY?=
 =?utf-8?B?Q21qSXF0VHhTZWgwL25NeWwvRUhNdVAyNDI5OVBoZy9HODRCdWUvQ3RuQmEy?=
 =?utf-8?B?ekV1OXVIRFRDOXU1UWhqZFNybDNHRGV4c281VmxFYys3OFJwMnZEZW81dDMv?=
 =?utf-8?B?YkNNbW5EZ0FIWnM0bEI5LzFLRFBsTUx4YXFYT054elpPbUtUK0FpNXVWL04w?=
 =?utf-8?B?Z3pFTFpOQXdMTThtZVpjMG1SZk5RVGhQVjVGOE9OV2dDT0pWbVVad3o4ODds?=
 =?utf-8?B?ZDJsS0ZKYit6dGtuUzBST1JCTmZNVFRBeW5ydTZtdjJXeE5pNkRtRDRBcXlI?=
 =?utf-8?B?KzJ0dSs4d3ZjR2JFVjVuMDNia0dQVEZZa1JESkRZamxTRUhxeU8wcTdvY2FL?=
 =?utf-8?B?NUlrUzdocnpQRGVKakhWUEJnT1V3dXcvVTNTWFJpSnNGaXRWbTkrT1Fycmlx?=
 =?utf-8?B?QmlKaGRncWFEa3Q4UmU2dm9XN2J6bnpNcjZ0VzhMRzdJNHBUcVFWdXdoSEQ0?=
 =?utf-8?B?VERPT1VTZ2czZ0JFVWFjVGd3bStjZ09LbzJLdkxHdkQ0WFFDWWlWRmR6RHJZ?=
 =?utf-8?B?clZkQndVWGtJOEJzZHp4a1Vmck1vYXZoMmpsaU1hS0poSWoxU3YxN0QxbHZP?=
 =?utf-8?B?Tit5YUJqejJ1RmlZZC9neXlEUWY1NzBKNEZqMkhjTFVuZUdmUW5kSWdmUm9k?=
 =?utf-8?B?WGJhdFJDZlNHN1g4blNlRmRIa0R5blNGcGMxOVUyVjZDajBlWGt1RVZrQmpK?=
 =?utf-8?B?bnBOdXpBeTJZZnY5K3M2Y0xzZWx0NVYrY3hUTUZ5NXZvY3F6Z3U5SWlmSU5S?=
 =?utf-8?B?YUdaMzRaRFpvZndrRHp3Sk5lMStqK21nTEgxZU5wZkZwdTgraWx0TjRCT21h?=
 =?utf-8?B?WDcxQnl3eFZMSWw5bHpwSUM3YWt1Tks3NjhodmtZS0t0dzRDZjVja2xIYjJl?=
 =?utf-8?B?ZjJKU2RXeitHT1grandQQzB6ak5pZzZtMEVmMEFxc3U2YnowV3dSRXFPbzZH?=
 =?utf-8?B?d3RxYXZGRmpxRENMRnVNcG1kZmxrTlByN3hoWEsvYzJFWm8wNUhPelZlUERa?=
 =?utf-8?B?RlQ5L0tFVGhHQnc2bmhyajIrL010a0l4ME9yWlRvdXlJRVhtYU1Sc2lPbHdP?=
 =?utf-8?B?KzRydk12aDJCZ0I4UzVvR0crMG4xRWJlcUhYNlgvSkI2MDNacFVBOU92SXNt?=
 =?utf-8?B?K0JFWllzK3JUQjNnWVZWVEVnOWJOQXpHcWMwYXJXZDlKS05BaXRySHVhdkZ1?=
 =?utf-8?B?bVhWcExvdFNzVU1YaS9KSENxcExMbENIUWN2WlY0TXZvUkwrTnRPOGdpNElu?=
 =?utf-8?B?SnhEZXVxeFkvM0hVdHZGS1ZGY2tuMjZGc20reDAwMjVFYlNPOUtDKzR2WnBj?=
 =?utf-8?B?SFpqWVk1ZzFjUWE4QTlCNS82a3d1dVVESkF2eUZtdkhJbWJKZmlLaEw0NGR6?=
 =?utf-8?B?ZGZ2cVpVVFdPejcyMHc4andqN0RmTUorYnUvSnpIREQ1cWtLWDVra1luWkhW?=
 =?utf-8?B?ZFFkdDlCZTJxMWp6Y0YvWENtZkUzVzM3dnVLY1N4cUd6ak5LR3RDSlN5QnIx?=
 =?utf-8?B?VVlVaXdVUXo5WE51ejViTUNBNHdveDAyVkNMZXlNSk0wcXZxRGovMTNzNEQx?=
 =?utf-8?B?dmJHaHJNMGN5ZERLK0xJQ3pMdm5LUXN2dDEvNnBsQmh4SjVhNGw5bFhsY2RB?=
 =?utf-8?B?WEQvMUhFLzk5bTdLOHhsQnlSL0I1ZmxsS0FQSHc1V0RHZk91eGYySUtadFBv?=
 =?utf-8?B?N0hUK21oYWQwT0h5Ti9UOHZiUDBHSlhKY2hBRzNtY0swKytrSmNDTUlIL0Fy?=
 =?utf-8?B?a3FDOUR0V0RFdkFzOFNHdmhIQ0dKekZDSEhndkRYZWxTWEZDQVVSa25OaVNy?=
 =?utf-8?B?WVE4VjZjZmxaQjJCZmp5U0VsaS9PeFJlRG1SZzkyWlc0cm5zVWx3dUg4d2xr?=
 =?utf-8?B?clUvTlEySmxWMlFQWkxNSURJVFhvbnFOalR4cWlEK0t1cld5VUk3V0pHazVa?=
 =?utf-8?B?eGc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a0af936d-6ef1-49f4-fa92-08dcde627e44
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2024 19:36:18.6032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HZGa+f3ehx6IwCAnv3J4In5jpTfnbsaIuK9/JAMohkc1X6rHluavvRs5q4O8FxxtWjtx+YS3lj5vb3eHxdHDnQwJf9NWSKCtOl+wH0Kt7xw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5225
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBZb3NyeSBBaG1lZCA8eW9zcnlh
aG1lZEBnb29nbGUuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgU2VwdGVtYmVyIDI2LCAyMDI0IDEw
OjM1IEFNDQo+IFRvOiBTcmlkaGFyLCBLYW5jaGFuYSBQIDxrYW5jaGFuYS5wLnNyaWRoYXJAaW50
ZWwuY29tPg0KPiBDYzogSm9oYW5uZXMgV2VpbmVyIDxoYW5uZXNAY21weGNoZy5vcmc+OyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1tbUBrdmFjay5vcmc7IG5waGFtY3NA
Z21haWwuY29tOyBjaGVuZ21pbmcuemhvdUBsaW51eC5kZXY7DQo+IHVzYW1hYXJpZjY0MkBnbWFp
bC5jb207IHNoYWtlZWwuYnV0dEBsaW51eC5kZXY7IHJ5YW4ucm9iZXJ0c0Bhcm0uY29tOw0KPiBI
dWFuZywgWWluZyA8eWluZy5odWFuZ0BpbnRlbC5jb20+OyAyMWNuYmFvQGdtYWlsLmNvbTsgYWtw
bUBsaW51eC0NCj4gZm91bmRhdGlvbi5vcmc7IFpvdSwgTmFuaGFpIDxuYW5oYWkuem91QGludGVs
LmNvbT47IEZlZ2hhbGksIFdhamRpIEsNCj4gPHdhamRpLmsuZmVnaGFsaUBpbnRlbC5jb20+OyBH
b3BhbCwgVmlub2RoIDx2aW5vZGguZ29wYWxAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIHY3IDYvOF0gbW06IHpzd2FwOiBTdXBwb3J0IG1USFAgc3dhcG91dCBpbg0KPiB6c3dhcF9z
dG9yZSgpLg0KPiANCj4gT24gVGh1LCBTZXAgMjYsIDIwMjQgYXQgMTA6MjnigK9BTSBTcmlkaGFy
LCBLYW5jaGFuYSBQDQo+IDxrYW5jaGFuYS5wLnNyaWRoYXJAaW50ZWwuY29tPiB3cm90ZToNCj4g
Pg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IFlvc3J5IEFo
bWVkIDx5b3NyeWFobWVkQGdvb2dsZS5jb20+DQo+ID4gPiBTZW50OiBUaHVyc2RheSwgU2VwdGVt
YmVyIDI2LCAyMDI0IDEwOjIwIEFNDQo+ID4gPiBUbzogU3JpZGhhciwgS2FuY2hhbmEgUCA8a2Fu
Y2hhbmEucC5zcmlkaGFyQGludGVsLmNvbT4NCj4gPiA+IENjOiBKb2hhbm5lcyBXZWluZXIgPGhh
bm5lc0BjbXB4Y2hnLm9yZz47IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiA+
ID4gbGludXgtbW1Aa3ZhY2sub3JnOyBucGhhbWNzQGdtYWlsLmNvbTsgY2hlbmdtaW5nLnpob3VA
bGludXguZGV2Ow0KPiA+ID4gdXNhbWFhcmlmNjQyQGdtYWlsLmNvbTsgc2hha2VlbC5idXR0QGxp
bnV4LmRldjsNCj4gcnlhbi5yb2JlcnRzQGFybS5jb207DQo+ID4gPiBIdWFuZywgWWluZyA8eWlu
Zy5odWFuZ0BpbnRlbC5jb20+OyAyMWNuYmFvQGdtYWlsLmNvbTsgYWtwbUBsaW51eC0NCj4gPiA+
IGZvdW5kYXRpb24ub3JnOyBab3UsIE5hbmhhaSA8bmFuaGFpLnpvdUBpbnRlbC5jb20+OyBGZWdo
YWxpLCBXYWpkaSBLDQo+ID4gPiA8d2FqZGkuay5mZWdoYWxpQGludGVsLmNvbT47IEdvcGFsLCBW
aW5vZGggPHZpbm9kaC5nb3BhbEBpbnRlbC5jb20+DQo+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENI
IHY3IDYvOF0gbW06IHpzd2FwOiBTdXBwb3J0IG1USFAgc3dhcG91dCBpbg0KPiA+ID4genN3YXBf
c3RvcmUoKS4NCj4gPiA+DQo+ID4gPiBPbiBUaHUsIFNlcCAyNiwgMjAyNCBhdCA5OjQw4oCvQU0g
U3JpZGhhciwgS2FuY2hhbmEgUA0KPiA+ID4gPGthbmNoYW5hLnAuc3JpZGhhckBpbnRlbC5jb20+
IHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
ID4gPiA+ID4gRnJvbTogWW9zcnkgQWhtZWQgPHlvc3J5YWhtZWRAZ29vZ2xlLmNvbT4NCj4gPiA+
ID4gPiBTZW50OiBXZWRuZXNkYXksIFNlcHRlbWJlciAyNSwgMjAyNCA5OjUyIFBNDQo+ID4gPiA+
ID4gVG86IFNyaWRoYXIsIEthbmNoYW5hIFAgPGthbmNoYW5hLnAuc3JpZGhhckBpbnRlbC5jb20+
DQo+ID4gPiA+ID4gQ2M6IEpvaGFubmVzIFdlaW5lciA8aGFubmVzQGNtcHhjaGcub3JnPjsgbGlu
dXgtDQo+ID4gPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiA+ID4gPiA+IGxpbnV4LW1tQGt2
YWNrLm9yZzsgbnBoYW1jc0BnbWFpbC5jb207DQo+IGNoZW5nbWluZy56aG91QGxpbnV4LmRldjsN
Cj4gPiA+ID4gPiB1c2FtYWFyaWY2NDJAZ21haWwuY29tOyBzaGFrZWVsLmJ1dHRAbGludXguZGV2
Ow0KPiA+ID4gcnlhbi5yb2JlcnRzQGFybS5jb207DQo+ID4gPiA+ID4gSHVhbmcsIFlpbmcgPHlp
bmcuaHVhbmdAaW50ZWwuY29tPjsgMjFjbmJhb0BnbWFpbC5jb207DQo+IGFrcG1AbGludXgtDQo+
ID4gPiA+ID4gZm91bmRhdGlvbi5vcmc7IFpvdSwgTmFuaGFpIDxuYW5oYWkuem91QGludGVsLmNv
bT47IEZlZ2hhbGksIFdhamRpIEsNCj4gPiA+ID4gPiA8d2FqZGkuay5mZWdoYWxpQGludGVsLmNv
bT47IEdvcGFsLCBWaW5vZGgNCj4gPHZpbm9kaC5nb3BhbEBpbnRlbC5jb20+DQo+ID4gPiA+ID4g
U3ViamVjdDogUmU6IFtQQVRDSCB2NyA2LzhdIG1tOiB6c3dhcDogU3VwcG9ydCBtVEhQIHN3YXBv
dXQgaW4NCj4gPiA+ID4gPiB6c3dhcF9zdG9yZSgpLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gWy4u
XQ0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IE9uZSB0aGluZyBJIHJlYWxpemVkIHdoaWxlIHJl
d29ya2luZyB0aGUgcGF0Y2hlcyBmb3IgdGhlIGJhdGNoZWQNCj4gY2hlY2tzDQo+ID4gPiBpczoN
Cj4gPiA+ID4gPiA+IHdpdGhpbiB6c3dhcF9zdG9yZV9wYWdlKCksIHdlIHNldCB0aGUgZW50cnkt
Pm9iamNnIGFuZCBlbnRyeS0+cG9vbA0KPiA+ID4gYmVmb3JlDQo+ID4gPiA+ID4gPiBhZGRpbmcg
aXQgdG8gdGhlIHhhcnJheS4gR2l2ZW4gdGhpcywgd291bGRuJ3QgaXQgYmUgc2FmZXIgdG8gZ2V0
IHRoZQ0KPiBvYmpjZw0KPiA+ID4gPiA+ID4gYW5kIHBvb2wgcmVmZXJlbmNlIHBlciBzdWItcGFn
ZSwgbG9jYWxseSBpbiB6c3dhcF9zdG9yZV9wYWdlKCksDQo+IHJhdGhlcg0KPiA+ID4gdGhhbg0K
PiA+ID4gPiA+ID4gb2J0YWluaW5nIGJhdGNoZWQgcmVmZXJlbmNlcyBhdCB0aGUgZW5kIGlmIHRo
ZSBzdG9yZSBpcyBzdWNjZXNzZnVsPyBJZg0KPiB3ZQ0KPiA+ID4gPiA+IHdhbnQNCj4gPiA+ID4g
PiA+IHpzd2FwX3N0b3JlX3BhZ2UoKSB0byBiZSBzZWxmLWNvbnRhaW5lZCBhbmQgY29ycmVjdCBh
cyBmYXIgYXMgdGhlDQo+IGVudHJ5DQo+ID4gPiA+ID4gPiBiZWluZyBjcmVhdGVkIGFuZCBhZGRl
ZCB0byB0aGUgeGFycmF5LCBpdCBzZWVtcyBsaWtlIHRoZSByaWdodCB0aGluZyB0bw0KPiA+ID4g
ZG8/DQo+ID4gPiA+ID4gPiBJIGFtIGEgYml0IGFwcHJlaGVuc2l2ZSBhYm91dCB0aGUgZW50cnkg
YmVpbmcgYWRkZWQgdG8gdGhlIHhhcnJheQ0KPiA+ID4gd2l0aG91dA0KPiA+ID4gPiA+ID4gYSBy
ZWZlcmVuY2Ugb2J0YWluZWQgb24gdGhlIG9iamNnIGFuZCBwb29sLCBiZWNhdXNlIGFueSBwYWdl
LQ0KPiA+ID4gPiA+IGZhdWx0cy93cml0ZWJhY2sNCj4gPiA+ID4gPiA+IHRoYXQgb2NjdXIgb24g
c3ViLXBhZ2VzIGFkZGVkIHRvIHRoZSB4YXJyYXkgYmVmb3JlIHRoZSBlbnRpcmUgZm9saW8NCj4g
aGFzDQo+ID4gPiBiZWVuDQo+ID4gPiA+ID4gPiBzdG9yZWQsIHdvdWxkIHJ1biBpbnRvIGlzc3Vl
cy4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFdlIGRlZmluaXRlbHkgc2hvdWxkIG5vdCBvYnRhaW4g
cmVmZXJlbmNlcyB0byB0aGUgcG9vbCBhbmQgb2JqY2cgYWZ0ZXINCj4gPiA+ID4gPiBpbml0aWFs
aXppbmcgdGhlIGVudHJpZXMgd2l0aCB0aGVtLiBXZSBjYW4gb2J0YWluIGFsbCByZWZlcmVuY2Vz
IGluDQo+ID4gPiA+ID4genN3YXBfc3RvcmUoKSBiZWZvcmUgenN3YXBfc3RvcmVfcGFnZSgpLiBJ
T1csIHRoZSBiYXRjaGluZyBpbiB0aGlzDQo+ID4gPiA+ID4gY2FzZSBzaG91bGQgYmUgZG9uZSBi
ZWZvcmUgdGhlIHBlci1wYWdlIG9wZXJhdGlvbnMsIG5vdCBhZnRlci4NCj4gPiA+ID4NCj4gPiA+
ID4gVGhhbmtzIFlvc3J5LiBJSVVDLCB3ZSBzaG91bGQgb2J0YWluIGFsbCByZWZlcmVuY2VzIHRv
IHRoZSBvYmpjZyBhbmQgdG8NCj4gdGhlDQo+ID4gPiA+IHpzd2FwX3Bvb2wgYXQgdGhlIHN0YXJ0
IG9mIHpzd2FwX3N0b3JlLg0KPiA+ID4gPg0KPiA+ID4gPiBJbiB0aGUgY2FzZSBvZiBlcnJvciBv
biBhbnkgc3ViLXBhZ2UsIHdlIHdpbGwgdW53aW5kIHN0YXRlIGZvciBwb3RlbnRpYWxseQ0KPiA+
ID4gPiBvbmx5IHRoZSBzdG9yZWQgcGFnZXMgb3IgdGhlIGVudGlyZSBmb2xpbyBpZiBpdCBoYXBw
ZW5lZCB0byBhbHJlYWR5IGJlIGluDQo+ID4gPiB6c3dhcA0KPiA+ID4gPiBhbmQgaXMgYmVpbmcg
cmUtd3JpdHRlbi4gV2UgbWlnaHQgbmVlZCBzb21lIGFkZGl0aW9uYWwgYm9vay1rZWVwaW5nIHRv
DQo+ID4gPiA+IGtlZXAgdHJhY2sgb2Ygd2hpY2ggc3ViLXBhZ2VzIHdlcmUgZm91bmQgaW4gdGhl
IHhhcnJheSBhbmQNCj4gPiA+IHpzd2FwX2VudHJ5X2ZyZWUoKQ0KPiA+ID4gPiBnb3QgY2FsbGVk
IChucl9zYikuIEFzc3VtaW5nIEkgZGVmaW5lIGEgbmV3ICJvYmpfY2dyb3VwX3B1dF9tYW55KCki
LCBJDQo+ID4gPiB3b3VsZCBuZWVkDQo+ID4gPiA+IHRvIGNhbGwgdGhpcyB3aXRoIChmb2xpb19u
cl9wYWdlcygpIC0gbnJfc2IpLg0KPiA+ID4gPg0KPiA+ID4gPiBBcyBmYXIgYXMgenN3YXBfcG9v
bF9nZXQoKSwgdGhlcmUgaXMgc29tZSBhZGRlZCBjb21wbGV4aXR5IGlmIHdlIHdhbnQNCj4gdG8N
Cj4gPiA+ID4ga2VlcCB0aGUgZXhpc3RpbmcgaW1wbGVtZW50YXRpb24gdGhhdCBjYWxscyAicGVy
Y3B1X3JlZl90cnlnZXQoKSIsIGFuZA0KPiA+ID4gYXNzdW1pbmcNCj4gPiA+ID4gdGhpcyBpcyBl
eHRlbmRlZCB0byBwcm92aWRlIGEgbmV3ICJ6c3dhcF9wb29sX2dldF9tYW55KCkiIHRoYXQgY2Fs
bHMNCj4gPiA+ID4gInBlcmNwdV9yZWZfdHJ5Z2V0X21hbnkoKSIuIElzIHRoZXJlIGEgcmVhc29u
IHdlIHVzZQ0KPiBwZXJjcHVfcmVmX3RyeWdldCgpDQo+ID4gPiBpbnN0ZWFkDQo+ID4gPiA+IG9m
IHBlcmNwdV9yZWZfZ2V0KCk/IFJlYXNvbiBJIGFzayBpcywgd2l0aCB0cnlnZXQoKSwgaWYgZm9y
IHNvbWUgcmVhc29uIHRoZQ0KPiA+ID4gcG9vbC0+cmVmDQo+ID4gPiA+IGlzIDAsIG5vIGZ1cnRo
ZXIgaW5jcmVtZW50cyB3aWxsIGJlIG1hZGUuIElmIHNvLCB1cG9uIHVud2luZGluZyBzdGF0ZSBp
bg0KPiA+ID4gPiB6c3dhcF9zdG9yZSgpLCBJIHdvdWxkIG5lZWQgdG8gc3BlY2lhbC1jYXNlIHRv
IGNhdGNoIHRoaXMgYmVmb3JlIGNhbGxpbmcgYQ0KPiA+ID4gbmV3DQo+ID4gPiA+ICJ6c3dhcF9w
b29sX3B1dF9tYW55KCkiLg0KPiA+ID4gPg0KPiA+ID4gPiBUaGluZ3MgY291bGQgYmUgYSBsaXR0
bGUgc2ltcGxlciBpZiB6c3dhcF9wb29sX2dldCgpIGNhbiB1c2UNCj4gPiA+ICJwZXJjcHVfcmVm
X2dldCgpIg0KPiA+ID4gPiB3aGljaCB3aWxsIGFsd2F5cyBpbmNyZW1lbnQgdGhlIHJlZmNvdW50
LiBTaW5jZSB0aGUgenN3YXAgcG9vbC0+cmVmIGlzDQo+ID4gPiBpbml0aWFsaXplZA0KPiA+ID4g
PiB0byAiMSIsIHRoaXMgc2VlbXMgT2ssIGJ1dCBJIGRvbid0IGtub3cgaWYgdGhlcmUgd2lsbCBi
ZSB1bmludGVuZGVkDQo+ID4gPiBjb25zZXF1ZW5jZXMuDQo+ID4gPiA+DQo+ID4gPiA+IENhbiB5
b3UgcGxlYXNlIGFkdmlzZSBvbiB3aGF0IGlzIHRoZSBzaW1wbGVzdC9jbGVhbmVzdCBhcHByb2Fj
aDoNCj4gPiA+ID4NCj4gPiA+ID4gMSkgUHJvY2VlZCB3aXRoIHRoZSBhYm92ZSBjaGFuZ2VzIHdp
dGhvdXQgY2hhbmdpbmcgcGVyY3B1X3JlZl90cnlnZXQNCj4gaW4NCj4gPiA+ID4gICAgICB6c3dh
cF9wb29sX2dldC4gTmVlZHMgc3BlY2lhbC1jYXNpbmcgaW4genN3YXBfc3RvcmUgdG8gZGV0ZWN0
IHBvb2wtDQo+ID4gPiA+cmVmDQo+ID4gPiA+ICAgICBiZWluZyAiMCIgYmVmb3JlIGNhbGxpbmcg
enN3YXBfcG9vbF9wdXRbX21hbnldLg0KPiA+ID4NCj4gPiA+IE15IGFzc3VtcHRpb24gaXMgdGhh
dCB3ZSBjYW4gcmVvcmRlciB0aGUgY29kZSBzdWNoIHRoYXQgaWYNCj4gPiA+IHpzd2FwX3Bvb2xf
Z2V0X21hbnkoKSBmYWlscyB3ZSBkb24ndCBjYWxsIHpzd2FwX3Bvb2xfcHV0X21hbnkoKSB0bw0K
PiA+ID4gYmVnaW4gd2l0aCAoZS5nLiBqdW1wIHRvIGEgbGFiZWwgYWZ0ZXIgenN3YXBfcG9vbF9w
dXRfbWFueSgpKS4NCj4gPg0KPiA+IEhvd2V2ZXIsIHRoZSBwb29sIHJlZmNvdW50IGNvdWxkIGNo
YW5nZSBiZXR3ZWVuIHRoZSBzdGFydCBhbmQgZW5kIG9mDQo+ID4genN3YXBfc3RvcmUuDQo+IA0K
PiBJIGFtIG5vdCBzdXJlIHdoYXQgeW91IG1lYW4uIElmIHpzd2FwX3Bvb2xfZ2V0X21hbnkoKSBm
YWlscyB0aGVuIHdlDQo+IGp1c3QgZG8gbm90IGNhbGwgenN3YXBfcG9vbF9wdXRfbWFueSgpIGF0
IGFsbCBhbmQgYWJvcnQuDQoNCkkgZ3Vlc3MgSSB3YXMgdGhpbmtpbmcgb2YgYSBzY2VuYXJpbyB3
aGVyZSB6c3dhcF9wb29sX2dldF9tYW55KCkgcmV0dXJucw0KdHJ1ZTsgc3Vic2VxdWVudGx5LCB0
aGUgcG9vbCByZWZjb3VudCByZWFjaGVzIDAgYmVmb3JlIHRoZSB6c3dhcF9wb29sX3B1dF9tYW55
KCkuDQpJIGp1c3QgcmVhbGl6ZWQgdGhpcyBzaG91bGRu4oCZdCBoYXBwZW4sIHNvIEkgdGhpbmsg
d2UgYXJlIE9rLiBXaWxsIHRoaW5rIGFib3V0IHRoaXMNCnNvbWUgbW9yZSB3aGlsZSBjcmVhdGlu
ZyB0aGUgZm9sbG93LXVwIHBhdGNoLg0KDQo+IA0KPiA+DQo+ID4gPg0KPiA+ID4gPiAyKSBNb2Rp
ZnkgenN3YXBfcG9vbF9nZXQvenN3YXBfcG9vbF9nZXRfbWFueSB0byB1c2UNCj4gPiA+IHBlcmNw
dV9yZWZfZ2V0X21hbnkNCj4gPiA+ID4gICAgIGFuZCBhdm9pZCBzcGVjaWFsLWNhc2luZyB0byBk
ZXRlY3QgcG9vbC0+cmVmIGJlaW5nICIwIiBiZWZvcmUgY2FsbGluZw0KPiA+ID4gPiAgICAgenN3
YXBfcG9vbF9wdXRbX21hbnldLg0KPiA+ID4NCj4gPiA+IEkgZG9uJ3QgdGhpbmsgd2UgY2FuIHNp
bXBseSBzd2l0Y2ggdGhlIHRyeWdldCB0byBhIGdldCwgYXMgSSBiZWxpZXZlDQo+ID4gPiB3ZSBj
YW4gcmFjZSB3aXRoIHRoZSBwb29sIGJlaW5nIGRlc3Ryb3llZC4NCj4gPg0KPiA+IFRoYXQgd2Fz
IG15IGluaXRpYWwgdGhvdWdodCBhcyB3ZWxsLCBidXQgSSBmaWd1cmVkIHRoaXMgY291bGRuJ3Qg
aGFwcGVuDQo+ID4gc2luY2UgdGhlIHBvb2wtPnJlZiBpcyBpbml0aWFsaXplZCB0byAiMSIsIGFu
ZCBiYXNlZCBvbiB0aGUgZXhpc3RpbmcNCj4gPiBpbXBsZW1lbnRhdGlvbi4gSW4gYW55IGNhc2Us
IEkgY2FuIHVuZGVyc3RhbmQgdGhlIGludGVudCBvZiB0aGUgdXNlDQo+ID4gb2YgInRyeWdldCI7
IGl0IGlzIGp1c3QgdGhhdCBpdCBhZGRzIHRvIHRoZSBjb25zaWRlcmF0aW9ucyBmb3IgcmVmZXJl
bmNlDQo+ID4gYmF0Y2hpbmcuDQo+IA0KPiBUaGUgaW5pdGlhbCByZWYgY2FuIGJlIGRyb3BwZWQg
aW4gX196c3dhcF9wYXJhbV9zZXQoKSBpZiBhIG5ldyBwb29sIGlzDQo+IGNyZWF0ZWQgKHNlZSB0
aGUgY2FsbCB0byBlcmNwdV9yZWZfa2lsbCgoKSkuDQoNCkkgc2VlLi4gdGhpcyBtYWtlcyBzZW5z
ZSwgdGhhbmtzIFlvc3J5IQ0KDQo+IA0KPiA+DQo+ID4gPg0KPiA+ID4gPiAzKSBLZWVwIHRoZSBh
cHByb2FjaCBpbiB2NyB3aGVyZSBvYmpfY2dyb3VwX2dldC9wdXQgaXMgbG9jYWxpemVkIHRvDQo+
ID4gPiA+ICAgICB6c3dhcF9zdG9yZV9wYWdlIGZvciBib3RoIHN1Y2Nlc3MgYW5kIGVycm9yIGNv
bmRpdGlvbnMsIGFuZCBhbnkNCj4gPiA+IHVud2luZGluZw0KPiA+ID4gPiAgICAgc3RhdGUgaW4g
enN3YXBfc3RvcmUgd2lsbCB0YWtlIGNhcmUgb2YgZHJvcHBpbmcgcmVmZXJlbmNlcyBvYnRhaW5l
ZA0KPiBmcm9tDQo+ID4gPiA+ICAgICBwcmlvciBzdWNjZXNzZnVsIHdyaXRlcyAoZnJvbSB0aGlz
IG9yIHByaW9yIGludm9jYXRpb25zIG9mIHpzd2FwX3N0b3JlKS4NCj4gPiA+DQo+ID4gPiBJIGFt
IGFsc28gZmluZSB3aXRoIGRvaW5nIHRoYXQgYW5kIGRvaW5nIHRoZSByZWZlcmVuY2UgYmF0Y2hp
bmcgYXMgYSBmb2xsb3cNCj4gdXAuDQo+ID4NCj4gPiBJIHRoaW5rIHNvIHRvbyEgV2UgY291bGQg
dHJ5IGFuZCBpbXByb3ZlIHVwb24gKDMpIHdpdGggcmVmZXJlbmNlIGJhdGNoaW5nDQo+ID4gaW4g
YSBmb2xsb3ctdXAgcGF0Y2guDQo+IA0KPiBTR1RNLg0KDQpUaGFua3MsIHdpbGwgcHJvY2VlZCEN
Cg0K

