Return-Path: <linux-kernel+bounces-334702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C03E097DAD8
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 01:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA1371C21502
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 23:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B8818DF7A;
	Fri, 20 Sep 2024 23:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mB/Snfga"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C9517CA09
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 23:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726875918; cv=fail; b=ZUB5/7Y1TRunOWvtFozT/EphYpqDsvKBMILsIrlDO+zN+/Wqjo5Br1bXsAtLPe7/OUPN4N6LgDivhRH4SqDDGJstDO0m8ToLoJFEm/rEQ42B6faBMThiIn78VJDeqzmfgckEbnm/xbyGS2ou9JXh85nzegyCUcpQw5dH2KeQBPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726875918; c=relaxed/simple;
	bh=uhdvTg0wS1vevwMwkBqolHakkiVql67b8tcLx4uygKY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lMCkTxQyWj8zwliOqnsEoZl2vDO+bN5g8SN1G1Zf0ZKyyppjyM5iBy/P1Hui7PyUf3XFs2B78nUE6Hits3a2PfxBjGNRo+ZRJGCP2Q3wBkyVzWlNv15GrfnbpZwgrBL+Alr09gO3Gy7fzJfHbcGMoYSSou5zrWDvJUjmhalTFcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mB/Snfga; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726875917; x=1758411917;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uhdvTg0wS1vevwMwkBqolHakkiVql67b8tcLx4uygKY=;
  b=mB/SnfgacWqUOXn3sErclPIgKGoHYdN8ZRznr5UivoKt2C+5XlFQK1UZ
   Nn0oCWbL+g6p3B9LKXVc6JGqGt0ZBQzoXVORATX526OTHiIGs3nHXVJkV
   JQhuCZLok2hd+1TklIPFz77XvnViisSj49XVl5IDux1bKKdJSWD/9cstY
   Nk+CIBJWXdhEWy6+cx7+6M9u4USpK5PMcyS6LH4j2Zs4SoAtEAq443MFG
   2/1uBILj9rk/VgrcrdnfSChZl3UxcQGbDs+UApZ4H+Ct6oV8BgacSjHyN
   HdsxSC+5iQG1LpSOOO6R9DG3013T/C3aWxZl/3omE+Pm+8DHobCYuyIhZ
   g==;
X-CSE-ConnectionGUID: R4Fi42TkTU602cljBfHQ5w==
X-CSE-MsgGUID: f8UCtUOVR02fmyd1iY1A3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11201"; a="25378475"
X-IronPort-AV: E=Sophos;i="6.10,245,1719903600"; 
   d="scan'208";a="25378475"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 16:45:15 -0700
X-CSE-ConnectionGUID: oI4jxwQgT82nisRYVWPupw==
X-CSE-MsgGUID: IXCumDylRm6cMXCKIu0OOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,245,1719903600"; 
   d="scan'208";a="70779404"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Sep 2024 16:45:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 20 Sep 2024 16:45:14 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 20 Sep 2024 16:45:14 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 20 Sep 2024 16:45:14 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 20 Sep 2024 16:45:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eZUh70Ai1fLjKlkuxw5d1XSgUn6yxp3Zy6u0DKiMpZY+nmzsceOpeK+tkmjlfUnDMno4ysHnZDNt7JSMy5mD7SK3brALa1Ba2dz11jYyKXMw25jMdPgywMC0y4hiu9Ns1rHbwB3N2yaDyedcPOz8iBMIXNRFoXLoryfx15LbI5d5kS+OyHU1kSUVMtr+d9hpMRtRzvQ4nUEIeeqnyg/v2I16At/5reDllC47AaqmDHgXyzglR0WSQwl3MS81Ym32riaNSH3FlaDfqRmEMksu6wTfkWtk95RP536AFLVVSasQM8A6sOpir4n/ItF3dp3LjtcNyE+VabfcM6hkhDYKlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uhdvTg0wS1vevwMwkBqolHakkiVql67b8tcLx4uygKY=;
 b=e0c1Nv68yHYvVh2WVSENmuQq479TPSKl8NW9ACgeoRGOTUBUWoNkCAYNFjEaVHmrz9N87WGjuRkoNxnWNH0lYZ22Uq0IQV6DOn4n25hj9SC0j23nKrjLMis/ovz6uzrjuV8d4k8GpBaB2ejaq6OEICk53gOs01P86LjwWP0FDs7J1Ud7IhKCgJF/2XVjK6UanOd5Hejf012cNqbFJRAjcB28bK9+jVQOFuz8INA3zgQpEZ77xJFejTEyKnfG5owR651xo0knwwF7+wT/kfSq4YkHk5P1EbyzAa6gceFM21zdT2NEOqSjx2rd7gRW35zjxcI3wIlCEAceG6mGkD3JCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by IA1PR11MB7367.namprd11.prod.outlook.com (2603:10b6:208:421::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Fri, 20 Sep
 2024 23:45:11 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.7982.022; Fri, 20 Sep 2024
 23:45:10 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Yosry Ahmed <yosryahmed@google.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "nphamcs@gmail.com" <nphamcs@gmail.com>,
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "ryan.roberts@arm.com"
	<ryan.roberts@arm.com>, "Huang, Ying" <ying.huang@intel.com>,
	"21cnbao@gmail.com" <21cnbao@gmail.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "Zou, Nanhai" <nanhai.zou@intel.com>, "Feghali,
 Wajdi K" <wajdi.k.feghali@intel.com>, "Gopal, Vinodh"
	<vinodh.gopal@intel.com>, "Sridhar, Kanchana P"
	<kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v6 0/3] mm: ZSWAP swap-out of mTHP folios
Thread-Topic: [PATCH v6 0/3] mm: ZSWAP swap-out of mTHP folios
Thread-Index: AQHa+lo8ysIDIejPvUy4b6yFKhIRqLI+1o8AgCEmqqCAAXQNAIAABhKA
Date: Fri, 20 Sep 2024 23:45:10 +0000
Message-ID: <SJ0PR11MB5678E3EFFB2D85257A280E48C96C2@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20240829212705.6714-1-kanchana.p.sridhar@intel.com>
 <CAJD7tkaqp_3YbK_qsq+v2=Q0r4xwTG9PbbPYjQdpTBu_Z7K5_A@mail.gmail.com>
 <SJ0PR11MB567893E61CB522991ED1379EC96C2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkbPcrHYGxCTTj7=YgXFcT6W4iek49cP_yHXWi2ce3jXTw@mail.gmail.com>
In-Reply-To: <CAJD7tkbPcrHYGxCTTj7=YgXFcT6W4iek49cP_yHXWi2ce3jXTw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|IA1PR11MB7367:EE_
x-ms-office365-filtering-correlation-id: e4375678-22fe-4fa6-14a5-08dcd9ce43af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WThITnFjcUV5MlFKQTREL21LK2hpU1ZHc3g0MjlpZnFGQ0RvZ3lRUHI1OWlM?=
 =?utf-8?B?YkZ2ejRJL3doUWFhNS9QWnBMRnlUYjg0L2lpUW50RnloMlJ6V1lMU1BJNEdV?=
 =?utf-8?B?UHdoLzVGUXRXMCtNVjJYRnc4TWUwcy9TOGFMRG9SREJSSGp1TlBXdzE3UnpL?=
 =?utf-8?B?d0hQdlh4VUlML1JPdzhPV0hjZVJYaGZlQkVoUDlyS2VrMlF1OFdxT000c09n?=
 =?utf-8?B?ZU1jTS9mdG9Tc3VXaGsycDNoNkE2SVFleWQ4UVNFd0VxVmF4Z0pxMFFrSU55?=
 =?utf-8?B?U1hncTFocngvMy9QWUhTOVlsUFEzRkt0ZmVZYTJiZGt6REJmQ01FUWVOdDRn?=
 =?utf-8?B?RThsRFlyejNuNEFKVW5UQ2ExeEREeVBzQURDT0tCbU04a29pQXFhN0hzVklu?=
 =?utf-8?B?bnhucDkxblQ4UFBhR0Z1Rk1hRGF2dkZBejd3cnZzTFZCbHhoenVOd1lETHBO?=
 =?utf-8?B?dnJDYm1UYUN2WnFTY3Z0Vzg2RWhoQTA2Rk93VTFEYTlOZ3pZRTg2ckxxM0c4?=
 =?utf-8?B?SnVQQzdXekpKOHVMOXRabU5RcE93NnpLSS9xTjk1NWxJZWVCTnB4M3NMTytY?=
 =?utf-8?B?ZnpyamE3YUpGaHV6RGJFVHViSlkva2s4dmRaZ0RVQWNUWjFaZXA0T0dYZGhs?=
 =?utf-8?B?d0pVZzBNWmVtcGZkNGdNN2xWaG1aRjQxbUpzNUZNMG40ak5oQWp5akVTeU14?=
 =?utf-8?B?RS9UY2R6bG5sMlcxNkcwZGlTdEttTldHY2lkdkRZWUdCR0NlWjhuUUFpclV2?=
 =?utf-8?B?WktOZk9PUlFiZ3VjRWpjMER3Sk9Ja1ZHTXFUK3NWVmkySlN0M3NyZUlRK3pW?=
 =?utf-8?B?M1A2dVQydUJ5SEhTanljWTFub1doaUl1dmkzUDlUSTQ3YStpTTBLeW44UWNr?=
 =?utf-8?B?U2ppR3NJbVQxTVhURlBFOHBXY2dTTGREb1lsdng0VjU2ODE1bXRJVHB1TWJr?=
 =?utf-8?B?N0RmY210Vlg5SjI1SWhpNTIrNUZJS0crWUpnamNEQTNxVHZtTG4zY1h5dlli?=
 =?utf-8?B?eUo3Z2J4UUlZYUllblBrdEtwQ1UvZkhUemNJM2J2elFvdk1RY2dVcGhQNjdu?=
 =?utf-8?B?WVRJczM5ZHpQcmVKTGVrWkROa1ZTaTU2Z2t2NFlNQ3JqZ29UamdkOC9kanBo?=
 =?utf-8?B?dXZuRU5xZHZHZ1dockMzOFUwRXNXdWdiVWFZbzFKdU1oMlFZSWlDTUxTMjdL?=
 =?utf-8?B?M2tldzN4SnhDOHBJVlAvWmlkVVVqQ21vVjFNN2dsV3dtam1YemVoYnptSnZQ?=
 =?utf-8?B?MVZQQk1MenhlZksyNWZxV2RsUTZKLzlBMFZpUldZMnVIcWRaa1VoR3BJa3A4?=
 =?utf-8?B?cGJEVmNJOVRyUEt1aEp6NXZGcHNKSnlrZUc0Wk9zOGdxMUtPaTd2UEM5dGcx?=
 =?utf-8?B?OWErd2xaNGdrcDA0YkxsZTRENnpjYzZadTJaaU9LSk5uRFZPeFZXOFkxSkcz?=
 =?utf-8?B?VXNVb1ErdDJ0RVA2SzRsS0ZuY0JOM3BVNWpZMmM2QklMS0FpM0FKOWRJNWNV?=
 =?utf-8?B?ODdZZHJ0Nk9kVnI1d0h5Ti93V0hzNFh3aEt4eXdINDY5c0IvZXJpdWtmUXJk?=
 =?utf-8?B?K2VTdFpGU3VDZnJjNnNkVWhxNndDU3NCc1ptTytkTHZQMTJ0TWxtTVllbU5x?=
 =?utf-8?B?Y2Y1eXY4YklFWmY2RXJ0S0I5YmpBeGhQM3dOVHdvRzdmcUhFMTNmeHZOb0lq?=
 =?utf-8?B?czFMUmtrcmFxWk9yWWJVL1ZjM3VXS0QrNlNJK2FnaUpoZ094bXJOdStHdFNv?=
 =?utf-8?B?OUQxU0lsa3R0U00yZlU0OEZQTW8vVm5ZNXJKcWgvbU9NQUJ3TndnaGZUdzhH?=
 =?utf-8?B?a0U4RXJKREkwV1JhM2o5bzcrTWRPY0NSYVZCUHJMMmFDZzJ3S1FvenExQktt?=
 =?utf-8?B?Y2pWWGg2Y2Yzd3dkbTNreitIbWV4bmx1WXFkVWFWKzUxMkE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YWJhNFlXWUJDVnp3eldNTVJlbG5wVXY0MkNTMnhycDdQdENpM1k0Nk93NEsw?=
 =?utf-8?B?eU1GMGJEUi9uWmpxeDJQTDFrYXFyRkYrbjg1NzJnd3FQQkdueGQ0SllxTitH?=
 =?utf-8?B?V2Voak5nYVlES3RXR0JBb2pFeXJ5Mm1qZVJJMS90YiszYWNjNUlnUUlCaUJZ?=
 =?utf-8?B?RlIxZHZicGNXaXYva0Y4dk01UUhEK01WdGlLU3FndDA1MjhsSTBtM282UGk5?=
 =?utf-8?B?eDFUOGxhdEJRUEFDRHZJcHpCY3ZKblVLSjNjZ1pBazYyNkZJUU1LcUp2dlpu?=
 =?utf-8?B?QWgrbmwrSEpTTEVMOUVadjdBeVhyMnRMNkFVOEd5WGNiTWI5TndhRU1SQnhT?=
 =?utf-8?B?ekVMZVdTYThWNW5rZnQ3dkRLdWxIOEQvTERCYnJ5UWg0c05mdTY4bzRXLzMz?=
 =?utf-8?B?SXZ6OC9VN1R2Ni9QbVpjM3hiR0JiZUZTVkVHQ1lqTjZDR2RwREZTdmxEajhk?=
 =?utf-8?B?Wjl0aTF2QTNKTXYyT1gyRFR1WmxvS1oyTWpzWVl5Z25aZzMxVmlMekFNVENq?=
 =?utf-8?B?bzgzYTJPdkRVVUYxdjY1SDdxWXMrTkZYbDI1VGlaSVhTWmJJTytUeFN1TTlN?=
 =?utf-8?B?RDNIai9NMHVmYUtTOW4zYXQyOU9PTlY3V1UwYmFMbmNMSXVwZG1HVWl5aHo4?=
 =?utf-8?B?TTdvOUFJNE15NVM5Nm9lQ0xDTlViVzFtTzFqSDFYVFQ1TXdWQW5GOG1EdEgv?=
 =?utf-8?B?RUJHY1pRVU9VVnk0U0VwWStvdEpscHYwTUk3M2pZVFZnNWNSSlVHSjIrNmda?=
 =?utf-8?B?QjBRNTdUL2lmUG1CSFh1Q0JKMkRZczhsa1pQbzdxQWxLejIvTnBxK3FVODg5?=
 =?utf-8?B?eHpmMnFBTVJqNE1uOXR1NDV4aW03WmR3T0h4VnpnYVdLdzFuNWZqYXFDWGcz?=
 =?utf-8?B?dEw4V3NCVXdxd1dSMGRNSVRQN2g2ejVVSGVQeW0zUjFJaTk1eUVOVzNmQk9L?=
 =?utf-8?B?LzJ6SzlHYUFBTUwzNkZnWGN3QWIzZ2w4NHV2WVVxcmk1cTVWeE93dFpaTVI4?=
 =?utf-8?B?WVlnb3o4K1JoRTlHNjFGdStuaXN2R1FtWTFLMzdpdThlZS9zOHRVWmttaTlL?=
 =?utf-8?B?Ui9JN3gvMDI1T0hicEhmeGJiRDBzd0pCZitLeXlIOFVVcDVRL3hFQWJ2SnE3?=
 =?utf-8?B?cHVRZ2xyUW4zRm9EV0RUNFpOR1J6dVE5NmtvdXZyWkNDV2dPOFRaOGY0MHM5?=
 =?utf-8?B?OHpVZndOTkdXN2dKWFd4anp1ZXh6YittQVY1cmZHVEhvUHJ6RTRmeEJ4akFZ?=
 =?utf-8?B?WUhTT2Z5R0FxZ3R5Y1NmQnBOaU5hOWhRRzk3Vkl0ckhNcGIvT2hySzdFUFZz?=
 =?utf-8?B?bFBkaU0ranVTMHg5WWRZSlgrb3BGR0lKM3kzZkYwUXZHQnE0YThDYWpxejJp?=
 =?utf-8?B?NTFzTHBNOE9zQnJqZFBtUTF4OEkrMzhMV1BEbnlxcHU0RE1OaTQ1TmRZWnBP?=
 =?utf-8?B?TUFFdkVla3ZoWUhvbm1VRmZqdTR4L1NnRUNGakg3bERlb1FhRVp5U2srclc1?=
 =?utf-8?B?RkZWN1g4b1lBOEN6bTNHcnBGN2F3NHZnZTBHYWFhWWtLNXNtUGsvd3ZaV0t2?=
 =?utf-8?B?M2dsT3VQVXRpa3lraTJjMlhxNStUMjlZODZBRlFtWjQzYm1jMWtPcXVxOGZl?=
 =?utf-8?B?d1M4dEFmdU9XNkhDR0FmWUdnOUVEdk9oc2J4ZkJWZFo5U1pwUlpXQXV1NnlW?=
 =?utf-8?B?M3dOYlhnV0h4UWN3WjROM0Vwc2VVdXR0ellYK1o2ekR6QmNlR2xjSy9RV3Bs?=
 =?utf-8?B?b1lzK0orSUxMSTVKNksrVVFjeHd2OFZzRjlhTzdCS1dhVHl1ZG4veVpWV01a?=
 =?utf-8?B?RDVINVNlakh2enRMOG1xOXlkRkRpTWIyYVRDcUtFZ3JXWlNDMVRpUUZqdmVu?=
 =?utf-8?B?bTlQcm4wZ0Y3bTQ3YnRoQlJiTnZnOU9DMkE5OEpoK3dlcTIxbkhPaFhwOEk3?=
 =?utf-8?B?R1ZndmRnVTZJKzFHcHFxYm0zYmFsODh6bDF5YTIxV3JvdEVySUxta0J2UlpN?=
 =?utf-8?B?N1BDL2ZQZ3VnR3phYkJaczRDV0ZlQXh5RXVrQTJrOFVnRy8wSTNXNk9XZi95?=
 =?utf-8?B?bStQOHVQRjA2Q2pvbnd5MGFtdEhadTk4dWNFZ1RiNERnc0JIZ3BIRVlPQVFh?=
 =?utf-8?B?WUNkYjdTNkluRUFzRVlYay8ycUVQSjRjMzJRK1ZSNmo4R3B5L2FvL3JRQzgv?=
 =?utf-8?B?WUE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e4375678-22fe-4fa6-14a5-08dcd9ce43af
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2024 23:45:10.1356
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SNXDqO0+XHd+jsEzTFl8IBdFxVP37jXmQBxsIenMZYhBbhDR9X+lr/D5zqyvkXKNssWoyLa7hGUjO6ie+hFaOvi4qpbpZQZhX+CKWFexKLU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7367
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBZb3NyeSBBaG1lZCA8eW9zcnlh
aG1lZEBnb29nbGUuY29tPg0KPiBTZW50OiBGcmlkYXksIFNlcHRlbWJlciAyMCwgMjAyNCA0OjE2
IFBNDQo+IFRvOiBTcmlkaGFyLCBLYW5jaGFuYSBQIDxrYW5jaGFuYS5wLnNyaWRoYXJAaW50ZWwu
Y29tPg0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtbW1Aa3ZhY2su
b3JnOw0KPiBoYW5uZXNAY21weGNoZy5vcmc7IG5waGFtY3NAZ21haWwuY29tOyBjaGVuZ21pbmcu
emhvdUBsaW51eC5kZXY7DQo+IHVzYW1hYXJpZjY0MkBnbWFpbC5jb207IHJ5YW4ucm9iZXJ0c0Bh
cm0uY29tOyBIdWFuZywgWWluZw0KPiA8eWluZy5odWFuZ0BpbnRlbC5jb20+OyAyMWNuYmFvQGdt
YWlsLmNvbTsgYWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZzsNCj4gWm91LCBOYW5oYWkgPG5hbmhh
aS56b3VAaW50ZWwuY29tPjsgRmVnaGFsaSwgV2FqZGkgSw0KPiA8d2FqZGkuay5mZWdoYWxpQGlu
dGVsLmNvbT47IEdvcGFsLCBWaW5vZGggPHZpbm9kaC5nb3BhbEBpbnRlbC5jb20+DQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggdjYgMC8zXSBtbTogWlNXQVAgc3dhcC1vdXQgb2YgbVRIUCBmb2xpb3MN
Cj4gDQo+IFsuLl0NCj4gPiA+IElmIHdlIHJlYWxseSB3YW50IHRvIGNvbXBhcmUgQ09ORklHX1RI
UF9TV0FQIG9uIGJlZm9yZSBhbmQgYWZ0ZXIsIGl0DQo+ID4gPiBzaG91bGQgYmUgd2l0aCBTU0Qg
YmVjYXVzZSB0aGF0J3MgYSBtb3JlIGNvbnZlbnRpb25hbCBzZXR1cC4gSW4gdGhpcw0KPiA+ID4g
Y2FzZSB0aGUgdXNlcnMgdGhhdCBoYXZlIENPTkZJR19USFBfU1dBUD15IG9ubHkgZXhwZXJpZW5j
ZSB0aGUNCj4gPiA+IGJlbmVmaXRzIG9mIHpzd2FwIHdpdGggdGhpcyBzZXJpZXMuIFlvdSBtZW50
aW9uZWQgZXhwZXJpbWVudGluZyB3aXRoDQo+ID4gPiB1c2VtZW0gdG8ga2VlcCB0aGUgbWVtb3J5
IGFsbG9jYXRlZCBsb25nZXIgc28gdGhhdCB5b3UncmUgYWJsZSB0byBoYXZlDQo+ID4gPiBhIGZh
aXIgdGVzdCB3aXRoIHRoZSBzbWFsbCBTU0Qgc3dhcCBzZXR1cC4gRGlkIHRoYXQgd29yaz8NCj4g
Pg0KPiA+IFRoYW5rcywgdGhlc2UgYXJlIGdvb2QgcG9pbnRzLiBJIHJhbiB0aGlzIGV4cGVyaW1l
bnQgd2l0aCBtbS11bnN0YWJsZSA5LQ0KPiAxNy0yMDI0LA0KPiA+IGNvbW1pdCAyNDhiYTgwMDRl
NzZlYjMzNWQ3ZTYwNzk3MjRjM2VlODlhMDExMzg5Lg0KPiA+DQo+ID4gRGF0YSBpcyBiYXNlZCBv
biBhdmVyYWdlIG9mIDMgcnVucyBvZiB0aGUgdm0tc2NhbGFiaWxpdHkgInVzZW1lbSIgdGVzdC4N
Cj4gDQo+IFRoYW5rcyBmb3IgdGhlIHJlc3VsdHMsIHRoaXMgbWFrZXMgbXVjaCBtb3JlIHNlbnNl
LiBJIHNlZSB5b3UgYWxzbyByYW4NCj4gdGhlIHRlc3RzIHdpdGggYSBsYXJnZXIgc3dhcCBzaXpl
LCB3aGljaCBpcyBnb29kLiBJbiB0aGUgbmV4dA0KPiBpdGVyYXRpb24sIEkgd291bGQgaG9uZXN0
bHkgZHJvcCB0aGUgcmVzdWx0cyB3aXRoIC0tc2xlZXAgMCBiZWNhdXNlDQo+IGl0J3Mgbm90IGEg
ZmFpciBjb21wYXJpc29uIGltby4NCg0KVGhhbmtzIGZvciB0aGUgY29tbWVudHMsIFlvc3J5LiBT
dXJlLCB0aGlzIHNvdW5kcyBnb29kLg0KDQo+IA0KPiBJIHNlZSB0aGF0IGluIG1vc3QgY2FzZXMg
d2UgYXJlIG9ic2VydmluZyBoaWdoZXIgc3lzIHRpbWUgd2l0aCB6c3dhcCwNCj4gYW5kIHNvbWV0
aW1lcyBldmVuIGhpZ2hlciBlbGFwc2VkIHRpbWUsIHdoaWNoIGlzIGNvbmNlcm5pbmcuIElmIHRo
ZQ0KPiBzeXMgdGltZSBpcyBoaWdoZXIgd2hlbiBjb21wYXJpbmcgenN3YXAgdG8gU1NELCBidXQg
ZWxhcHNlZCB0aW1lIGlzDQo+IG5vdCBoaWdoZXIsIHRoaXMgY2FuIGJlIG5vcm1hbCBkdWUgdG8g
Y29tcHJlc3Npb24gb24gdGhlIENQVSB2cy4NCj4gYXN5bmNocm9ub3VzIGRpc2sgd3JpdGVzLg0K
PiANCj4gSG93ZXZlciwgaWYgdGhlIHN5cyB0aW1lIGluY3JlYXNlcyB3aGVuIGNvbXBhcmluZyBD
T05GSUdfVEhQX1NXQVA9bg0KPiBiZWZvcmUgdGhpcyBzZXJpZXMgYW5kIENPTkZJR19USFBfU1dB
UD15IHdpdGggdGhpcyBzZXJpZXMgKGkuZS4NCj4gY29tcGFyaW5nIHpzd2FwIHdpdGggNEsgdnMu
IHpzd2FwIHdpdGggbVRIUCksIHRoZW4gdGhhdCdzIGEgcHJvYmxlbS4NCj4gDQo+IEFsc28sIGlm
IHRoZSB0b3RhbCBlbGFwc2VkIHRpbWUgaW5jcmVhc2VzLCBpdCBpcyBhbHNvIGEgcHJvYmxlbS4N
Cg0KQWdyZWVkLiBTbyBmYXIgaW4gdGhlICJDYXNlIDEiIGRhdGEgcHVibGlzaGVkIGluIHY2LCB0
aGF0IGNvbXBhcmVzIHpzd2FwIDRrDQooQ09ORklHX1RIUF9TV0FQPW4pIHZzLiB6c3dhcCBtVEhQ
IChDT05GSUdfVEhQX1NXQVA9eSksIHdlIHNlZQ0KY29uc2lzdGVudCByZWR1Y3Rpb24gaW4gc3lz
IHRpbWUgd2l0aCB0aGlzIHBhdGNoLXNlcmllcy4gSSB3aWxsIGNvbmZpcm0gYnkNCnJlLWdhdGhl
cmluZyBkYXRhIHdpdGggdjcgKHdpbGwgcG9zdCBlbGFwc2VkIGFuZCBzeXMgdGltZXMpLg0KDQo+
IA0KPiBNeSBtYWluIGNvbmNlcm4gaXMgdGhhdCBzeW5jaHJvbm91cyBjb21wcmVzc2lvbiBvZiBh
biBtVEhQIG1heSBiZSB0b28NCj4gZXhwZW5zaXZlIG9mIGFuIG9wZXJhdGlvbiB0byBkbyBpbiBv
bmUgc2hvdC4gSSBhbSB3b25kZXJpbmcgaWYgd2UgbmVlZA0KPiB0byBpbXBsZW1lbnQgYXN5bmNo
cm9ub3VzIHN3YXBvdXQgZm9yIHpzd2FwLCBzbyB0aGF0IGl0IGJlaGF2ZXMgbW9yZQ0KPiBsaWtl
IHN3YXBwaW5nIHRvIGRpc2sgZnJvbSBhIHJlY2xhaW0gcGVyc3BlY3RpdmUuDQo+IA0KPiBBbnl3
YXksIHRoZXJlIGFyZSB0b28gbWFueSB0ZXN0IHJlc3VsdHMgbm93LiBGb3IgdGhlIG5leHQgdmVy
c2lvbiwgSQ0KPiB3b3VsZCBzdWdnZXN0IG9ubHkgaGF2aW5nIHR3byBkaWZmZXJlbnQgdGVzdCBj
YXNlczoNCj4gMS4gQ29tcGFyaW5nIHpzd2FwIDRLIHZzIHpzd2FwIG1USFAuIFRoaXMgd291bGQg
YmUgZG9uZSBieSBjb21wYXJpbmcNCj4gQ09ORklHX1RIUF9TV0FQPW4gdG8gQ09ORklHX1RIUF9T
V0FQPXkgYXMgeW91IGRpZCBiZWZvcmUuDQo+IA0KPiAyLiBDb21wYXJpbmcgU1NEIHN3YXAgbVRI
UCB2cyB6c3dhcCBtVEhQLg0KPiANCj4gSW4gYm90aCBjYXNlcywgSSB0aGluayB3ZSB3YW50IHRv
IHVzZSBhIHN1ZmZpY2llbnRseSBsYXJnZSBzd2FwZmlsZQ0KPiBhbmQgbWFrZSB0aGUgdXNlbWVt
IHByb2Nlc3NlcyBzbGVlcCBmb3IgYSB3aGlsZSB0byBtYWludGFpbiB0aGUgbWVtb3J5DQo+IGFs
bG9jYXRpb25zLiBTaW5jZSB3ZSBhbHJlYWR5IGNvbmZpcm1lZCB0aGUgdGhlb3J5IGFib3V0IHRo
ZQ0KPiByZXN0cmljdGVkIHN3YXBmaWxlIHJlc3VsdHMgYmVpbmcgZHVlIHRvIHByb2Nlc3NlcyBp
bW1lZGlhdGVseQ0KPiBleGl0aW5nLCBJIGRvbid0IHNlZSB2YWx1ZSBpbiBydW5uaW5nIHRlc3Rz
IGFueW1vcmUgd2l0aCBhIHJlc3RyaWN0ZWQNCj4gc3dhcGZpbGUgb3Igd2l0aG91dCBzbGVlcGlu
Zy4NCg0KT2ssIHRoaXMgc291bmRzIGdvb2QuIEkgd2lsbCBzdWJtaXQgYSB2NyB3aXRoIGFsbCB0
aGVzZSBzdWdnZXN0aW9ucyBpbmNvcnBvcmF0ZWQuDQoNClRoYW5rcywNCkthbmNoYW5hDQoNCj4g
DQo+IFRoYW5rcyENCg==

