Return-Path: <linux-kernel+bounces-340778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B50699877B4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 18:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 440271F21AB4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 16:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC066156C40;
	Thu, 26 Sep 2024 16:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aIavY1Ep"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064AE14A4E0
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 16:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727368813; cv=fail; b=Drfsg4dryoUesyZ9vMtrufgeS08dzvUGpQ4IqdoUrPyrfNrBMHbCfplWsnEB8qis5j+A3vaX4MP7TvP4ky2b1TeEIk9DQ/8kSica+dy34EJ5zKVgzDw5DP1XJYAi/clO4eFwOto+JllIOlD/qwx64+mi1I05NJSgxm/fLCbZNVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727368813; c=relaxed/simple;
	bh=Jj0O1rwV7582o4+8oySUlsGG3kN/XH6re0fZfQFDO6I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aqhMAw+AKicF11Q6ee2r6qOixCKw3U1brPQyRGwJQMH3qy3gzKQeqBfekt80fCFk7k1MfPyH3EMRVFBPeYkLgbbv0o8CkSJeAz0zoaTPLLnwwjOF6XFcDeMru3RxSbA/7P0I3lbfSEFPZrlYT544A86TwvuqMP7GaAe5jSrZJtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aIavY1Ep; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727368812; x=1758904812;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Jj0O1rwV7582o4+8oySUlsGG3kN/XH6re0fZfQFDO6I=;
  b=aIavY1EpOJP3WYIEpstvot7AC723WTJSLtOIE2EFfhLLGOokMvEQy5+w
   KbK88ImqVU5t5wCT/WGhzbTw+Sooq9ipk3phdv7w3yTUFJrfbUqmexKEu
   ymEmtErYE/QN/gd664DM0OigqCqr6R04v8P76MYZNSWlZyUIICQxupcS6
   r79r9OFVZ+N3XT2bL28pBENcBCXpDBuwm8JASX5ItoCeeONK/Z7bmUQFE
   btJnQZQFVe+vxx99enOW3kmmJaU/lUhSbXLy9Qg5hHWu8BwoTtssJQdk8
   oys+YjJPFptb1BMt6NxzjDmPK+wRT9n0Qs4HfG6burBPp4hmSERnTvDK/
   Q==;
X-CSE-ConnectionGUID: WnIZSEJ/S42yxFPVtGfyig==
X-CSE-MsgGUID: yMqjuS+VRQCUw6kfUAhtVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="30280238"
X-IronPort-AV: E=Sophos;i="6.11,156,1725346800"; 
   d="scan'208";a="30280238"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 09:40:12 -0700
X-CSE-ConnectionGUID: YR3qXWiGTUKTs3H0JQUKyA==
X-CSE-MsgGUID: Eqk/L7b8ScGAEYqqCVchfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,156,1725346800"; 
   d="scan'208";a="103010888"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2024 09:40:11 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 09:40:10 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 09:40:10 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 26 Sep 2024 09:40:10 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 26 Sep 2024 09:40:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iw5tna1IGzt6FTHGyNCR9rj4E7B0Bm6X5wus6MyJkQOrxtJGdeKpGXF8n6rqJ3BjuzYWWGs8I71jDnWBcXLTi6gSIve6gsTmKPzO+bbueGPusP89wZ/HaL7EmPD2jvPUmS2TyqndFiYF3fQ+FStNshV9hlWs+a6biV0C+xcIlR37QxniNJ5lEw8+H/su0+UOQtOafAPtp2UDg8oWkpuTDOEp0l83l/DPGKEMrGkU5KjZD167ToZUY9PUjEz3GjX4yhDKFdNyPszbBjeb6zYYUkJBMlmxzpf6sYOBAnLvzSnggTFWwUk/YB/3OH2SarRG4fNAMrsV5Q/n/WdqyA6i9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jj0O1rwV7582o4+8oySUlsGG3kN/XH6re0fZfQFDO6I=;
 b=A606OINPZzycgFn9n5rBerAnkYlD2dPtyxdLx2vX/7Wpz42rDGOnuLheFwOhb9kcrrEJtchKq/Hzyup6CWRn28K2fJ5d9gy6iOq/+e7+Yu2AM6Jkw2gMR73eN2bc2FKC574rVYjcExsbMXTNObxSQFTjKITrpJf9FgOgsHpMuHx/4rpjt/JeEmCXvx1QDjaIs63iGpBvMDNzlwcmrcwk5Rj3JhNOd7/vsS6iIf53qb9KetkdtAZlTkyNGFNMbaG66rrSVW7ov+GJwDMu9boByuuv2IuUKhKchgQCWTmsI+4YK75Cv3KkOezERsbIIi2SDdL5OmdH/MyH8qaG5SWnJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by LV3PR11MB8741.namprd11.prod.outlook.com (2603:10b6:408:21d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.29; Thu, 26 Sep
 2024 16:40:07 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 16:40:06 +0000
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
Thread-Index: AQHbDh+C+ZYgIzdq4EuvViy0xt7aPLJnVm0AgAEuMgCAAFEmAIAADdcAgAAFSgCAAAmZgIAADtIAgAAWxLCAAFmCgIAAEe0AgAC+71A=
Date: Thu, 26 Sep 2024 16:40:06 +0000
Message-ID: <SJ0PR11MB56785027ED6FCF673A84CEE6C96A2@SJ0PR11MB5678.namprd11.prod.outlook.com>
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
In-Reply-To: <CAJD7tkYtVR6fi1R2O+jAxVfj7BJ2EKWbXHke9fkv_m=mf5pkFQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|LV3PR11MB8741:EE_
x-ms-office365-filtering-correlation-id: 6d7941b1-9384-4032-0648-08dcde49e094
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?OEhoYkhPVmVQeW9kZ0IrRVo0bmdGN25kWWVhZm5qcEdpUE5sRkI0RVhFcDFo?=
 =?utf-8?B?UjE0UWg0N1FGQ2htMndmNWpHK3kzUjQ0UGZmZ3Fud1J3czY5MXNlcjJDWElP?=
 =?utf-8?B?N29ORVdWZHQ3emlqNUh2VlRNSW5VSkMyN2NLclYzK21KNStjZWloSzhMVk5I?=
 =?utf-8?B?UkZKa3J4RUM4WkM5WTRLc0NENzIrTGtDVVFWa0NwanBnaEx4dXdTVzB0M25t?=
 =?utf-8?B?VFJUT1BpS3lxa1Qwc1lJS2d5YUUvQ1BUcUpKK0pkVExBTW5RY2hzUytpVjN1?=
 =?utf-8?B?MjI1VVRYK3VHME9xYXJhUlBFTW1nam1VVFZRTXZJZFdEaFczU2ovR1RVUlFX?=
 =?utf-8?B?cHZWVVIyTHJvWW4zMEcyaUVSSm9abGczMUNLb3NoZ2lNcUh3V0hBNXdLUEJO?=
 =?utf-8?B?YjcyVVcwa0xVcXRSRm82VnhQTGNCd0hNSk1BRDN0S2tkQjR1N3lZY1JNR2c0?=
 =?utf-8?B?eCs2eDRPci9KLzJMNExySE9GQldJTERVVVBtRklST0s2VnM5bCs3bHZPR2ho?=
 =?utf-8?B?OXcybXN0TUcwd0xqSjBpTVhVWTBvUVNPKzBQeXpkWlhUR3JVa05GQSthNlBX?=
 =?utf-8?B?MmZRZDR0cC9iMlFnZ2lXMk5QeHRydUllTEJ2cDB4TmQzVGhoM3kwVWIxeHN5?=
 =?utf-8?B?U0ZmdlRZM09vQTdXSVdid3NINFJSRkFzbXdiSGY0L3laK21uMVJXVXBBRHha?=
 =?utf-8?B?MlY4ZHVabUZ6d0FqRThCcnQvL3JwRVd0UFpYTjhDSk5DSzFHUzBFSHo3eEht?=
 =?utf-8?B?YUN3bGxnWi9pUTFDRkZ1M1pHRGhSTC9BNjlncG5ZOU9XRUdCcmlCTURmREE4?=
 =?utf-8?B?RWhnS3dFZG9sSkVhVmpLZkJtc2M2TEcwREs1aCs0Q1FuYkxqUlF6QTA5cWVX?=
 =?utf-8?B?bjNDRzRzb2V5dkZ2Vnl0TEgwZ29FQ1VFN3FKenp3emJLTE5QemZzekVOWUV4?=
 =?utf-8?B?UGV4bkVkR2x3ZUgxa3Y3YkYyVVc2cTZWNnBEeXJzMEF4ck1NbC82TGZ3dlcz?=
 =?utf-8?B?THhJTnMrUUlTazh0TkhhVFRQWkdWTDVoUDYvNWZwU0xNWXI4OXhFdFRMTDly?=
 =?utf-8?B?a01uOEZYMURvbWJvYmV4UTlPY1UzaTlpZVFSMWljZ3l0TG50T0JKVGpUM3Mr?=
 =?utf-8?B?amdDSWswK2w0WVlIWlFSRkhRdnpyWTJkR2QzOTE0cGdkaWRQNEdjZG9xaElO?=
 =?utf-8?B?TldWMGdCK1U2N0RhMERGNXVGL0h3L1VmcFI4NW0zM0c1cUdxOGIxSGFDY3cx?=
 =?utf-8?B?UE5qckc4K1hiMTlscC9KMCs0dzJIbHY3VVQwYUpUTTEyOHZEMyswZjE4OUtP?=
 =?utf-8?B?QmZNQ0ZLTGd6Ri80aHNQbm5IOWtlSVR6bGhTcXEwdXdnV1l1cEdFR1JWRlNN?=
 =?utf-8?B?S1ZGRVhRN1BMSkdnYWVCQm5nbVd5elY1cWE2bXJ3bU5HUGo1VU8reXBKWGM2?=
 =?utf-8?B?MGw3ZGJUK05RdzE5RnRIak9qSFFTeU9XdFZVZGQ0NUFwcGJXb3ZLR29oSEJV?=
 =?utf-8?B?K3EyV0x5dllwWlNlMlF5d2lKSGNXdGZTS3dGUWg1K2kxOE44YUQxRG5KN25Y?=
 =?utf-8?B?eWU2ZkZZaU8vNTFRSVFRL0p6dG55Mi9QKzg3SnE2TkFaQ1ZNaFRVUHBEUjNt?=
 =?utf-8?B?cXE0ZXpiNTdHNi9uNE9VcFVxN2Nsa04vVkwvQld5WGw4bENoKzVpM01FR2lQ?=
 =?utf-8?B?RFBBSFlyWnA5Z0NjWHRFZ2lCTHR1ejVoanduRGFSU0lsbTBVVlgwNXo3SGRN?=
 =?utf-8?B?SStWRGhGY0FMT3M4OXdxWTFpRzhSYkZyb1o1U3k2MzI3NFZyOWg4UW5iQUNY?=
 =?utf-8?B?c2NRS0VZcVYwa3AvbWpaQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Zlh5QUlud1dQUStjSHdtb05UT1dLdEdKVWNrZUNMNXhRZlNUcUgwTnRDT1dT?=
 =?utf-8?B?SmgrSlVJdDczQkV2cUIxZm9zcU45OWVCL21ydmJOaUg4VFlrbjREOENmaEI5?=
 =?utf-8?B?aVJpUHRDZVkwcVV6aW8zZ2VmaWNkL3RPeDdRTHFia2tjMjVIZ1JrYS9KdlA0?=
 =?utf-8?B?SFUvSGxlSVMrTEdDLzZyMkpyaHJEZTJYa0J2eXptdUpBMHpFMVNQSlRsVmhl?=
 =?utf-8?B?bUFhQ1dwa0tJUTBCbDV1SWY0RmxBY0ZJTjNRSk5MWnBrL3Y1MGJBTkVKR2lU?=
 =?utf-8?B?Z2dQQkN2WkZLc285SExPRUduNndOUXZXa1M5VnBBek9acXhSb01EVDZDM1Mz?=
 =?utf-8?B?RWJ5VThxNit4bUN3WmJWWExRZ21RR0NXYjlTZnFVeEErSWcvTHBuQ0dNcFQv?=
 =?utf-8?B?aHJ3SEo1WnQxdkN3Sms2Z09PR1lSa0RiS1RGTFhpOUtQUmFDdHg5ZWo3QTV2?=
 =?utf-8?B?Si9MNFBVOEptNTN3MXZDVjFXdTAxMVptZzFpekVra2xWNVUweUZNMHFhdGE4?=
 =?utf-8?B?OEV6bHlObVZTbTN3VUlRYnBUeDZLVS9iT28zNGd1QnRRU0pJbVdJUmZpZUdW?=
 =?utf-8?B?a084eWVLWU1RY0k3bkcyWndIKzBOU3lEbUZQOWJtbWV1eTU1dGp1SU54Nkc3?=
 =?utf-8?B?Rkp4ZUcvMXRWK0V2dkYwT1M5MldjSGl1ZVA5UzI5SGJDZ1RGcmpld3Z2aTkz?=
 =?utf-8?B?bUErT2pWYUVoQnkvTm5uQ2JKblJXaEFsTVpWbS81WHZOaGExZUZJRkFjNkNp?=
 =?utf-8?B?U2NWZXZveXBVVnpzekVpWjVGODZsNXh0Tmh2RzBnMkhSUkt5S0x0WEVJNm9n?=
 =?utf-8?B?S3dNaDhyOU5jd0VhV2kzU1NaVnBEYmpmMGFVUGpwbXF0VHFXNjc4Y2dKY3RG?=
 =?utf-8?B?VUR1MHNRVVl3WlNTaEd4RDVVUGdaNHlyUE04N1RBSzNINUowaEg1WUJXb3hN?=
 =?utf-8?B?V2VEZndHMzdyRnE5ajY3czIvY25FdkNtcVhZMURaRWsxZ2JQS3I4V0xRM3Nm?=
 =?utf-8?B?SGVZVFk2RUtwV3JBaUdoWEdUUlgvNUd2Nkx0UWl3TzBiNnFTVGNhYkxCcFo1?=
 =?utf-8?B?NXBwdWdxS1VlY1g5SDRRZ2IxOUtQeWhZQkRMVEtTOVNpc29vYTB0SFF2aWJH?=
 =?utf-8?B?S3dibjZlYVRjS1Y0YjBPQ2NmYTUydUV4djZvd2tOcURoMW1hOHRaVUpOOWJK?=
 =?utf-8?B?aGEwMFRrMzI1SE1jVDVjTGJTUlRWNkV4dnBpZVpYVngvUmhyd1crdEF1OUNp?=
 =?utf-8?B?N0dsMnRKdERQUUxuTjJNN0FRaDh2UXRSbDk4UEZQbTNCSjNaZm5GY3RaRUhS?=
 =?utf-8?B?SUNKWUV5RFZjblRPb09XR0JtcFVDTzBkbDZpZkpTZFBxQ0NwNnJEc0lsZjBE?=
 =?utf-8?B?bi82YnN3c1NaOU8zWWQzQ0YzeGVyaVp6azFEalNIazJIUTE5d0l0aFBEdEVl?=
 =?utf-8?B?ZDF0YVZMQUR5Zkk2TDRWUVBYQld2T2ZNNm9MZXNHbmRRMlZPVVArVG5HK0xm?=
 =?utf-8?B?WEJNZ2VZZnlNcDlyd0hKaDFSZlpxcTd1anBpZDNTWXJhbUpkOFBlam5CTnhm?=
 =?utf-8?B?amRLYjJSaVVaMnhpbEh2RmhlSlZ0djNhZUppbmZhRWVqUjVkeTZwK1MvRDhs?=
 =?utf-8?B?UUtvUkJaWnpCSDZHYnRxUmVJZmUwS3dMSVlydWJ2cEJidTd3a092NDZRUlFT?=
 =?utf-8?B?Wnl6aGRpcmp4UnVxYWFBdkljb0hTTnQ5TG5zZElwTG1xOXdLL2pSczBKU0NB?=
 =?utf-8?B?OXVBUk1tQ3Bld2VyeVl3QnFoMmRPTnVraTJ3cy9aRUppbGZ4WDBvV09Wckdm?=
 =?utf-8?B?K0IxSU1vaDJqNGZWcmYzUlc2dndYd2UwcnZsQ0xvamYzeWZtWit5T3ZlK3FF?=
 =?utf-8?B?KzZ3MDdnNy9NVjFqalNwZ1BPaEdkTEZEczExb2o3S25HeGxWSmFFeW94TjdZ?=
 =?utf-8?B?VHozSnZwY25zakFkVlFaV0Z5YWJ5Q2IzeXVUMzlsTGhHc1RPZXBKSFNaTzBU?=
 =?utf-8?B?VUgvSWsxSkVuOWdVQnA5Y1BBaHpObjVHRFhnaXJ4aVN5TFFtdldhU1JBU2hz?=
 =?utf-8?B?MytZY1ZVcWxpdDhwK2lFWnI4c3MvQk5malhuV2NtdnE2UnM5eEVFOVowNjh6?=
 =?utf-8?B?R3pqbWVwUnh3NGtRdnMza250YUFtSXg2TlFtUWx2Q2s3Vzh3T2N3RFF1WkZF?=
 =?utf-8?B?MFE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d7941b1-9384-4032-0648-08dcde49e094
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2024 16:40:06.1007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JKPuq+8A/EME9lCPIZyPO734UOgILUOQrlbxoBHO7sNEYVP2zYcLP28UjFvSVzjZlNOapSHpVH78X2zpSyjYTdzvCl7Lrmv8YMDUgYqg1xk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8741
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBZb3NyeSBBaG1lZCA8eW9zcnlh
aG1lZEBnb29nbGUuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIFNlcHRlbWJlciAyNSwgMjAyNCA5
OjUyIFBNDQo+IFRvOiBTcmlkaGFyLCBLYW5jaGFuYSBQIDxrYW5jaGFuYS5wLnNyaWRoYXJAaW50
ZWwuY29tPg0KPiBDYzogSm9oYW5uZXMgV2VpbmVyIDxoYW5uZXNAY21weGNoZy5vcmc+OyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1tbUBrdmFjay5vcmc7IG5waGFtY3NA
Z21haWwuY29tOyBjaGVuZ21pbmcuemhvdUBsaW51eC5kZXY7DQo+IHVzYW1hYXJpZjY0MkBnbWFp
bC5jb207IHNoYWtlZWwuYnV0dEBsaW51eC5kZXY7IHJ5YW4ucm9iZXJ0c0Bhcm0uY29tOw0KPiBI
dWFuZywgWWluZyA8eWluZy5odWFuZ0BpbnRlbC5jb20+OyAyMWNuYmFvQGdtYWlsLmNvbTsgYWtw
bUBsaW51eC0NCj4gZm91bmRhdGlvbi5vcmc7IFpvdSwgTmFuaGFpIDxuYW5oYWkuem91QGludGVs
LmNvbT47IEZlZ2hhbGksIFdhamRpIEsNCj4gPHdhamRpLmsuZmVnaGFsaUBpbnRlbC5jb20+OyBH
b3BhbCwgVmlub2RoIDx2aW5vZGguZ29wYWxAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIHY3IDYvOF0gbW06IHpzd2FwOiBTdXBwb3J0IG1USFAgc3dhcG91dCBpbg0KPiB6c3dhcF9z
dG9yZSgpLg0KPiANCj4gWy4uXQ0KPiA+DQo+ID4gT25lIHRoaW5nIEkgcmVhbGl6ZWQgd2hpbGUg
cmV3b3JraW5nIHRoZSBwYXRjaGVzIGZvciB0aGUgYmF0Y2hlZCBjaGVja3MgaXM6DQo+ID4gd2l0
aGluIHpzd2FwX3N0b3JlX3BhZ2UoKSwgd2Ugc2V0IHRoZSBlbnRyeS0+b2JqY2cgYW5kIGVudHJ5
LT5wb29sIGJlZm9yZQ0KPiA+IGFkZGluZyBpdCB0byB0aGUgeGFycmF5LiBHaXZlbiB0aGlzLCB3
b3VsZG4ndCBpdCBiZSBzYWZlciB0byBnZXQgdGhlIG9iamNnDQo+ID4gYW5kIHBvb2wgcmVmZXJl
bmNlIHBlciBzdWItcGFnZSwgbG9jYWxseSBpbiB6c3dhcF9zdG9yZV9wYWdlKCksIHJhdGhlciB0
aGFuDQo+ID4gb2J0YWluaW5nIGJhdGNoZWQgcmVmZXJlbmNlcyBhdCB0aGUgZW5kIGlmIHRoZSBz
dG9yZSBpcyBzdWNjZXNzZnVsPyBJZiB3ZQ0KPiB3YW50DQo+ID4genN3YXBfc3RvcmVfcGFnZSgp
IHRvIGJlIHNlbGYtY29udGFpbmVkIGFuZCBjb3JyZWN0IGFzIGZhciBhcyB0aGUgZW50cnkNCj4g
PiBiZWluZyBjcmVhdGVkIGFuZCBhZGRlZCB0byB0aGUgeGFycmF5LCBpdCBzZWVtcyBsaWtlIHRo
ZSByaWdodCB0aGluZyB0byBkbz8NCj4gPiBJIGFtIGEgYml0IGFwcHJlaGVuc2l2ZSBhYm91dCB0
aGUgZW50cnkgYmVpbmcgYWRkZWQgdG8gdGhlIHhhcnJheSB3aXRob3V0DQo+ID4gYSByZWZlcmVu
Y2Ugb2J0YWluZWQgb24gdGhlIG9iamNnIGFuZCBwb29sLCBiZWNhdXNlIGFueSBwYWdlLQ0KPiBm
YXVsdHMvd3JpdGViYWNrDQo+ID4gdGhhdCBvY2N1ciBvbiBzdWItcGFnZXMgYWRkZWQgdG8gdGhl
IHhhcnJheSBiZWZvcmUgdGhlIGVudGlyZSBmb2xpbyBoYXMgYmVlbg0KPiA+IHN0b3JlZCwgd291
bGQgcnVuIGludG8gaXNzdWVzLg0KPiANCj4gV2UgZGVmaW5pdGVseSBzaG91bGQgbm90IG9idGFp
biByZWZlcmVuY2VzIHRvIHRoZSBwb29sIGFuZCBvYmpjZyBhZnRlcg0KPiBpbml0aWFsaXppbmcg
dGhlIGVudHJpZXMgd2l0aCB0aGVtLiBXZSBjYW4gb2J0YWluIGFsbCByZWZlcmVuY2VzIGluDQo+
IHpzd2FwX3N0b3JlKCkgYmVmb3JlIHpzd2FwX3N0b3JlX3BhZ2UoKS4gSU9XLCB0aGUgYmF0Y2hp
bmcgaW4gdGhpcw0KPiBjYXNlIHNob3VsZCBiZSBkb25lIGJlZm9yZSB0aGUgcGVyLXBhZ2Ugb3Bl
cmF0aW9ucywgbm90IGFmdGVyLg0KDQpUaGFua3MgWW9zcnkuIElJVUMsIHdlIHNob3VsZCBvYnRh
aW4gYWxsIHJlZmVyZW5jZXMgdG8gdGhlIG9iamNnIGFuZCB0byB0aGUNCnpzd2FwX3Bvb2wgYXQg
dGhlIHN0YXJ0IG9mIHpzd2FwX3N0b3JlLg0KDQpJbiB0aGUgY2FzZSBvZiBlcnJvciBvbiBhbnkg
c3ViLXBhZ2UsIHdlIHdpbGwgdW53aW5kIHN0YXRlIGZvciBwb3RlbnRpYWxseQ0Kb25seSB0aGUg
c3RvcmVkIHBhZ2VzIG9yIHRoZSBlbnRpcmUgZm9saW8gaWYgaXQgaGFwcGVuZWQgdG8gYWxyZWFk
eSBiZSBpbiB6c3dhcA0KYW5kIGlzIGJlaW5nIHJlLXdyaXR0ZW4uIFdlIG1pZ2h0IG5lZWQgc29t
ZSBhZGRpdGlvbmFsIGJvb2sta2VlcGluZyB0bw0Ka2VlcCB0cmFjayBvZiB3aGljaCBzdWItcGFn
ZXMgd2VyZSBmb3VuZCBpbiB0aGUgeGFycmF5IGFuZCB6c3dhcF9lbnRyeV9mcmVlKCkNCmdvdCBj
YWxsZWQgKG5yX3NiKS4gQXNzdW1pbmcgSSBkZWZpbmUgYSBuZXcgIm9ial9jZ3JvdXBfcHV0X21h
bnkoKSIsIEkgd291bGQgbmVlZA0KdG8gY2FsbCB0aGlzIHdpdGggKGZvbGlvX25yX3BhZ2VzKCkg
LSBucl9zYikuDQoNCkFzIGZhciBhcyB6c3dhcF9wb29sX2dldCgpLCB0aGVyZSBpcyBzb21lIGFk
ZGVkIGNvbXBsZXhpdHkgaWYgd2Ugd2FudCB0bw0Ka2VlcCB0aGUgZXhpc3RpbmcgaW1wbGVtZW50
YXRpb24gdGhhdCBjYWxscyAicGVyY3B1X3JlZl90cnlnZXQoKSIsIGFuZCBhc3N1bWluZw0KdGhp
cyBpcyBleHRlbmRlZCB0byBwcm92aWRlIGEgbmV3ICJ6c3dhcF9wb29sX2dldF9tYW55KCkiIHRo
YXQgY2FsbHMNCiJwZXJjcHVfcmVmX3RyeWdldF9tYW55KCkiLiBJcyB0aGVyZSBhIHJlYXNvbiB3
ZSB1c2UgcGVyY3B1X3JlZl90cnlnZXQoKSBpbnN0ZWFkDQpvZiBwZXJjcHVfcmVmX2dldCgpPyBS
ZWFzb24gSSBhc2sgaXMsIHdpdGggdHJ5Z2V0KCksIGlmIGZvciBzb21lIHJlYXNvbiB0aGUgcG9v
bC0+cmVmDQppcyAwLCBubyBmdXJ0aGVyIGluY3JlbWVudHMgd2lsbCBiZSBtYWRlLiBJZiBzbywg
dXBvbiB1bndpbmRpbmcgc3RhdGUgaW4NCnpzd2FwX3N0b3JlKCksIEkgd291bGQgbmVlZCB0byBz
cGVjaWFsLWNhc2UgdG8gY2F0Y2ggdGhpcyBiZWZvcmUgY2FsbGluZyBhIG5ldw0KInpzd2FwX3Bv
b2xfcHV0X21hbnkoKSIuDQoNClRoaW5ncyBjb3VsZCBiZSBhIGxpdHRsZSBzaW1wbGVyIGlmIHpz
d2FwX3Bvb2xfZ2V0KCkgY2FuIHVzZSAicGVyY3B1X3JlZl9nZXQoKSINCndoaWNoIHdpbGwgYWx3
YXlzIGluY3JlbWVudCB0aGUgcmVmY291bnQuIFNpbmNlIHRoZSB6c3dhcCBwb29sLT5yZWYgaXMg
aW5pdGlhbGl6ZWQNCnRvICIxIiwgdGhpcyBzZWVtcyBPaywgYnV0IEkgZG9uJ3Qga25vdyBpZiB0
aGVyZSB3aWxsIGJlIHVuaW50ZW5kZWQgY29uc2VxdWVuY2VzLg0KDQpDYW4geW91IHBsZWFzZSBh
ZHZpc2Ugb24gd2hhdCBpcyB0aGUgc2ltcGxlc3QvY2xlYW5lc3QgYXBwcm9hY2g6DQoNCjEpIFBy
b2NlZWQgd2l0aCB0aGUgYWJvdmUgY2hhbmdlcyB3aXRob3V0IGNoYW5naW5nIHBlcmNwdV9yZWZf
dHJ5Z2V0IGluDQogICAgIHpzd2FwX3Bvb2xfZ2V0LiBOZWVkcyBzcGVjaWFsLWNhc2luZyBpbiB6
c3dhcF9zdG9yZSB0byBkZXRlY3QgcG9vbC0+cmVmDQogICAgYmVpbmcgIjAiIGJlZm9yZSBjYWxs
aW5nIHpzd2FwX3Bvb2xfcHV0W19tYW55XS4NCjIpIE1vZGlmeSB6c3dhcF9wb29sX2dldC96c3dh
cF9wb29sX2dldF9tYW55IHRvIHVzZSBwZXJjcHVfcmVmX2dldF9tYW55DQogICAgYW5kIGF2b2lk
IHNwZWNpYWwtY2FzaW5nIHRvIGRldGVjdCBwb29sLT5yZWYgYmVpbmcgIjAiIGJlZm9yZSBjYWxs
aW5nDQogICAgenN3YXBfcG9vbF9wdXRbX21hbnldLg0KMykgS2VlcCB0aGUgYXBwcm9hY2ggaW4g
djcgd2hlcmUgb2JqX2Nncm91cF9nZXQvcHV0IGlzIGxvY2FsaXplZCB0bw0KICAgIHpzd2FwX3N0
b3JlX3BhZ2UgZm9yIGJvdGggc3VjY2VzcyBhbmQgZXJyb3IgY29uZGl0aW9ucywgYW5kIGFueSB1
bndpbmRpbmcNCiAgICBzdGF0ZSBpbiB6c3dhcF9zdG9yZSB3aWxsIHRha2UgY2FyZSBvZiBkcm9w
cGluZyByZWZlcmVuY2VzIG9idGFpbmVkIGZyb20NCiAgICBwcmlvciBzdWNjZXNzZnVsIHdyaXRl
cyAoZnJvbSB0aGlzIG9yIHByaW9yIGludm9jYXRpb25zIG9mIHpzd2FwX3N0b3JlKS4NCg0KVGhh
bmtzLA0KS2FuY2hhbmENCg0KPiANCj4gPg0KPiA+IEp1c3Qgd2FudGVkIHRvIHJ1biB0aGlzIGJ5
IHlvdS4gVGhlIHJlc3Qgb2YgdGhlIGJhdGNoZWQgY2hhcmdpbmcsIGF0b21pYw0KPiA+IGFuZCBz
dGF0IHVwZGF0ZXMgc2hvdWxkIGJlIE9rLg0KPiA+DQo+ID4gVGhhbmtzLA0KPiA+IEthbmNoYW5h
DQo+ID4NCj4gPiA+DQo+ID4gPiBUaGFua3MsDQo+ID4gPiBLYW5jaGFuYQ0K

