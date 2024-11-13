Return-Path: <linux-kernel+bounces-408323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4438C9C7D66
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 22:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 975FAB29A6E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 21:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCDF20C015;
	Wed, 13 Nov 2024 21:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n8+wg78y"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4112076AF
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 21:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731532337; cv=fail; b=fZxzP3pOOU009f0OFoAKi6gi4OUBWcgtFV5HZ73vK3uDZVz/et9DiWH92RfWwQwMnbS+vPz+UGMJFMzH5DZYDx7DiIjAxH3mB+Bt7YsU9VtOZTqnpEzK5vAlODQhaqfptt/onOT+b5KEi9bZ8Zl8ca6n5bUkmutCxn3l+Z2upX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731532337; c=relaxed/simple;
	bh=8TdoiNalmuJQyYGK0zf4uZncC3SvrBPunfLbLVIWgik=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JxYwhF0iHMadezU/+g+Cxp1ZYFNMVFSV9q2z518iRSSXhqEE8x9qDfP0o8Xvtbgj7BbizV5Tb2Rvge7dPon5ah+7XPwdtEthUa9d7NUTeFYrlWbT3sKDG7at1rJmfhTOJWMsiUUJKLHD74aM27rr5GoNpXDEoJhWjrbxUzC6Cug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n8+wg78y; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731532337; x=1763068337;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8TdoiNalmuJQyYGK0zf4uZncC3SvrBPunfLbLVIWgik=;
  b=n8+wg78yceNreXdm0LWLnsN79fAR48QAd2EogehcpGA0oiGO6XHvl9Zd
   UyjK7akWAep0KjHUqFPH2eEuHKcC+mv5HMZo4xd1QHEROVeqquoNT8Y+w
   +Egm8FxLhJaWTIU7Xn2EaXkvdciNFIIMRLDY32ytoMPs51L1Q/79cqzAp
   ZxVep49UxdxoLaDwvNAiIZGes04HuHO9SP9Zg2DbvAnsGq+L7m7+TohNr
   ObvXLTf0dVMqMS5cR6EJNEfmTWNsS443ezhpwKHsbv36g7rv68U2RNCXv
   Y17v5IdyUxaKzK4YXpAvZF9DBgMXXV7koHKQ5CpJ9/Od1ABWTfkjIX/W/
   w==;
X-CSE-ConnectionGUID: fi9yrPmPSpGw9OFcHAiMeQ==
X-CSE-MsgGUID: NqfqampJTCWigfZLNFQsLA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31601904"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31601904"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 13:12:16 -0800
X-CSE-ConnectionGUID: B09vkVbPQ3is3ZN/20XhgA==
X-CSE-MsgGUID: vDeFuI3CRveseWpSrYq4Lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,152,1728975600"; 
   d="scan'208";a="88386042"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Nov 2024 13:12:16 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 13 Nov 2024 13:12:14 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 13 Nov 2024 13:12:14 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 13 Nov 2024 13:12:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rkvcX3tja/UEV+0sKMfhTSdvsfxHNVeSsDGa149YBtTD85W6L+axb0FdZcwOcmTetYhkAnT7cqrhwZjpPDThSxwRYFccrHhfyEyvwH6cDu/o51AhlmIxAdyIqiSMvI/ln2b1ag+T1/UkQaro22R22OeExnXqCyoiNUzsnsWFpktLkpXAxpMlTCYZMaoTY53y1XvffUchZcOMW9rfrM0KCYwUVMAKCjXnj/HLufYEqnKCBYy1VxV74WfuxV5DFJNsI7yR4lgWQsl9ylB9ci5Mu8+8Yc/E945GIdgZIWFCZ+2ZKITaqrGuWBNncuNF65q8LX021R2SZ/UZkbMJ0M/Wjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8TdoiNalmuJQyYGK0zf4uZncC3SvrBPunfLbLVIWgik=;
 b=p/fteBcJHX2Q+JUyWCijIUsaT/K0gHUUV2KHZ+ViaN1TYW/YDvrgsDmBcfPn/oI9/agL9zCcG34H+3bEH2al7Ycuamo8/TLI9z7Wlhnv0vQ2dgPfxDzqQMmpbbUre2BOxDzCrc2Glr77J0BoC9TJw0tz97rG+KGN5cKFCwIWPNlJ4AwOAFvTc96rF8rrAU8N9YXcZfTM4VNBCyXhk21IIa175f6n5LA/zg/FIjRvRaqdk6x1ZGMsr0zI0BjYtPQp5KY2eouokM1yTs0ImAR08ms0V56fFVXXEVkzQ+XnI0/D6b0xUrUB6uFVWeyRpUSkrZevhI5/llWj3ggkQJhNlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by IA1PR11MB7920.namprd11.prod.outlook.com (2603:10b6:208:3fc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Wed, 13 Nov
 2024 21:12:11 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 21:12:11 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Yosry Ahmed <yosryahmed@google.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "nphamcs@gmail.com" <nphamcs@gmail.com>,
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "ryan.roberts@arm.com"
	<ryan.roberts@arm.com>, "Huang, Ying" <ying.huang@intel.com>,
	"21cnbao@gmail.com" <21cnbao@gmail.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>,
	"Gopal, Vinodh" <vinodh.gopal@intel.com>, "Sridhar, Kanchana P"
	<kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v1] mm: zswap: Fix a potential memory leak in
 zswap_decompress().
Thread-Topic: [PATCH v1] mm: zswap: Fix a potential memory leak in
 zswap_decompress().
Thread-Index: AQHbNYxgo97ShYNp0k+eAlG8E2BdYbK0sGWAgAAC9UCAAAo2gIAAydcggAAd4ICAAAwBAIAAAZ+AgAADRHA=
Date: Wed, 13 Nov 2024 21:12:11 +0000
Message-ID: <SJ0PR11MB5678F29933750D2197CA5CE6C95A2@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20241113052413.157039-1-kanchana.p.sridhar@intel.com>
 <CAJD7tkZWDhOXyyZnEYFiS7F4tSV+z6TYXUYiEcrZrRuy_3R=ZA@mail.gmail.com>
 <DM8PR11MB567179534CEE154369CCA174C95A2@DM8PR11MB5671.namprd11.prod.outlook.com>
 <CAJD7tkbLtjQqR-uf8EBoFCWbkYOLHsVh6vJoMZUj+z4eN0GKAQ@mail.gmail.com>
 <SJ0PR11MB56781940E69ABE93FF9076F6C95A2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkZHvHUi0KpEW+M0k5A-9UfAGJzm++gzaaxdCbLsLFVQJw@mail.gmail.com>
 <SJ0PR11MB5678995E8E0B6B39509DB875C95A2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkZGzVM53UWwp+u7UMYu4sumgJhVRhohMqiHP1=8PgTHCA@mail.gmail.com>
In-Reply-To: <CAJD7tkZGzVM53UWwp+u7UMYu4sumgJhVRhohMqiHP1=8PgTHCA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|IA1PR11MB7920:EE_
x-ms-office365-filtering-correlation-id: 0ec39af1-bc3a-4da1-7e81-08dd0427d718
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VW0yZU13SXR6Vm5SeUNJRXBBanFYcVZyWDNHUEY1ZUpXUUhUbHhZUVJmd2Mz?=
 =?utf-8?B?bktQS1hQU1NXamw1OTZPbkQrWnNkYW9lemdzeXVnc0FoUi9CTEJNSTBFUTZq?=
 =?utf-8?B?ODNGN2hHZGNDcXkyVHVxelZoaUllK0RNOVlwQ3V6YmlGTU9pQ0EvWVU0VlVv?=
 =?utf-8?B?bitBQ09UUXV1U3dvYTFVaXU1VEREZjhuODJ6OHcrZnd3RjZDNkZES1kxbGhR?=
 =?utf-8?B?ekRWNDVKb3k3dXIyMzdkNUdzTXhxcDh5Q1dOM0ZsY0dMbU1hV0w2ak5mRFo0?=
 =?utf-8?B?bjllSzZaemUzSHpnei9iVlFFZzJZUkxHeWVrT1Q0KzJ1Z3EyaTZCbDB3aWpj?=
 =?utf-8?B?S0hNS05zTlZ5bTFsdFl3VUF1dVY4bDk1RjJFSG9EenFYM1dtYmg3bVhGcThi?=
 =?utf-8?B?bG5uaVRKa0Fvc09xOStSVUZWdXZMYVNxa1RtYUdDTFova0xLaEd5M0dxWGY2?=
 =?utf-8?B?Smx6eEVrYmRDdWFGdDFnMTBaZU0vUVZwVnB5OW9PeGFUTHRvY05NVHJrMGFS?=
 =?utf-8?B?Z0d5R2VIWVFtWmRWTjJDYXUxUDJMY0JBd0tUUU9JYjI2REpmeEhpZ3dHckhk?=
 =?utf-8?B?R25NQ2l3Z3lRTGZKL2tFdjkzKy9GMFpQM3d0N3pGSnczYmp2cGttQmZKZVFB?=
 =?utf-8?B?ZE44YXJPbGV6SkY5RGpIcVhYazF1UlJBRzdtZDlkY0pXVCtPZ3RZdUJyRGtM?=
 =?utf-8?B?T0NSR3Q2K2Voa2plUHdZcjY0Q21WbDU1SkVQcHo5QktYZmRsVmtZQUdoK3gx?=
 =?utf-8?B?aGR0UlZBVVNZdXBURmhTY2kzUjQxSWxROFF4MUhkK2RBOTNsQ1gyL3M0TE9G?=
 =?utf-8?B?MktZNFJYY3RxZjU1a2d0dzhVTjdvWmFCY0dFNzlMOVE2STZZWW9jTTcwMXdZ?=
 =?utf-8?B?cTIzSmpsMS9XNEpLUXBUcWdKSkJBa1V1Ri9JTVBjLzd5WkhEZVc5N1MzZTk0?=
 =?utf-8?B?NCtXd3NWWGZtSTlTdVlNSHBnemxzNjZUL25JU0ZtaGFZY2VzNnFNM1ZzenZ2?=
 =?utf-8?B?a20rZTdLTnN6b3g4R3hsTDBrTzZxQVZ4WHV3cW5QZ0k4cFhYZTVZNTNOVWtn?=
 =?utf-8?B?cWV4aUZ6RDM3MllTSHo0cFAzUEdiYXBPRG02NDI4NStXa3dMOG1rYmZDTjZU?=
 =?utf-8?B?TG1kZUxFQm9OTTArb0xjQnlUZDZyQU8vR00wS3UrQmNDNysyWDhFdS9ra3po?=
 =?utf-8?B?ZHUrOTlHeXJOVUZZTUxldWx1aFkxNkp5M0wyTVY2VFdlaHF2OVZGcFZkMC9Q?=
 =?utf-8?B?Q0l5YzBWK1dlTjJuSkpGZkVmeHNWSEdEaFBzRWNGamY3ZTdYejYrUWMxcTRY?=
 =?utf-8?B?b2JzWllhRjNVQk5Ea3QydGM4dmpmbDZ1L3A4QTNuYTlQcEZ2UCtXeXBDSTlm?=
 =?utf-8?B?TkxFdnBpa3h3YjBWRWhQQi9oOXdRdWNLaHZpa3djOUhJbTFyN3J2M3pXRnJk?=
 =?utf-8?B?UEVPLzlwWTR0Q2ZtclprelVybEJKUE5MVUVQK3N4OVRCMXRSbmtUbUtPZTBx?=
 =?utf-8?B?TklMTnJ3N1lteXBHM3VuaC9HbVZuZWRjc2FvaFRmUng2SERmekxzK0czODd2?=
 =?utf-8?B?N3FTUnNVSUNXNitiM3dRTVo5U3FveFBtbmhBZmxNdEtaWXl6Rm85SVdjTVc0?=
 =?utf-8?B?Vlk5OHBaNkloVHdpa0JYOEF6aHo1Yy9qb05pMXpLcURrL2QyS2g4NmpiMUlM?=
 =?utf-8?B?QXJkeVBONEZKOW92YmQvMlhaY3ZPWlVoQUU3ZWJEbENUdXNzWnJrN0RUUC9E?=
 =?utf-8?B?MFExbTVlbjdlckFFbkxkNlpNcnN1MkZadGFPVDFJMUdia3dCdUJXc2JkbUth?=
 =?utf-8?Q?FUo+gvDVmfKgSz5hDxdnki8vnRjOW7wufg8eM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cFlPK2hHempHbGhMN0hMYkJ4VC9aMkk1Z2Izd0RkUzNYZXdxS05RamhjbVA3?=
 =?utf-8?B?dlBzdmg0RlJMcnUyNVRRUko4NCs0S0kyR2xtS1Rka0xtSHNDL1hJamQxTUl4?=
 =?utf-8?B?OUFQdDlzd291azM5RUxhY1hBZjhFYWRvRVN1Z1RwREVkZWVpeGVhNEhuNTU4?=
 =?utf-8?B?eCtGcG9ZZW5xL21MRWtGT2U3T2ZSbWk1N0Z0V0FqUlg4UmozMEh0RzdiWHU3?=
 =?utf-8?B?RVkzRXBCTFcyR21zQVNSQktobkRreGorWTFCUTBySnZsWnB6Mnp4WHIwRnRJ?=
 =?utf-8?B?MFhBQS9GU1hUN05hbmtDTXBMMW42bnJYTWFFZm9IcDFZSlFTQTJBSmErWmE0?=
 =?utf-8?B?V2grdXN0Qy9nVytJM2tYelIrd1gzVDllUFppM0Z3WExScTNSM1NIOFdIYlBy?=
 =?utf-8?B?dGJ5ei85dUlFQ3lzUFl0NG9iOXVhZHdXSGZhYzFlcnJwWXNNeG9mNmFkdTV2?=
 =?utf-8?B?b3ltdkdqMWJMeHZhZFcxRXRLZXNvbTBVcVBzRW9TeUYrdlNEOWZUOVNRNVdo?=
 =?utf-8?B?REt3MEFFWDNzUW85cFNscm5VV0dhS1o0Tm5aTFN4cFZpa08yNFBmdlA3c1ZK?=
 =?utf-8?B?a0JQVHZ3dGRlYkhXK1hSWTVuQmlLaWlPWjdEbkdFakxlTDN3dlR6VTkyMDRI?=
 =?utf-8?B?dlZaWHRQRjVtOU9sVkp5QWF5R2JKZExNVWRscjlvMUQyM2F1NzVRbGhCV2pn?=
 =?utf-8?B?Z3hlSjlQT2kzVmE3M29UQm9obVMyeWI4WXJkVTZHcGF1bkNyTmc1MXlMbkFO?=
 =?utf-8?B?YnFUOHE4NFV2RWpEK0lmY0FIWEY1eW9Kc1hjWXUvelRrcnVCRUY5Nld1a1FL?=
 =?utf-8?B?THJCbFJaSk4rYkdsNmhyNlpqSXdCQkRuaDBkTFl4a1RMNlhmSk5FNnNNNTU0?=
 =?utf-8?B?ckpmYko3L0phQlRHMnN1eVZBQnFENVhSeEhKR2taV0dOMHhqV3dKQkt2djZI?=
 =?utf-8?B?UC9lN0lmb0JodDBjL3ZoRkkzVjNqQVk5ZE5LQkJSYkVWdkFYNmZKWVNlYUFH?=
 =?utf-8?B?aGV3czZOTjYzcEdjWVIzeUtYVFRsWU1hcHlyY3hhaVRvbkdHZUFRNVZrdFdK?=
 =?utf-8?B?akRiMUtxZzVKRm03ZU5oT2c4Y3lqN1BONUkyb0pGQ0M2SEQ3RmhkZms2RG82?=
 =?utf-8?B?QlFYelNsODlsQlBqdEZZTVZWRENKK25vODdKakh0Ykt0V1VwRHlXWjM5YlZm?=
 =?utf-8?B?U1hHdDRxSEQveTRwMXhiV2N5eXVLTHlsNWxBTU8raytrTFV3SWl4dkFZTXN0?=
 =?utf-8?B?Z2FlL2s1VDJUZGxhcWsxdkdaMjRUcTREZldUN3U4VXhvcWErcW1iYVYwZ1dv?=
 =?utf-8?B?QjZsdWhFZk1Qa2RFNnNpVzJpNWZLa2lZRXlwdnIyL2xuVlRWcktydW5Xendn?=
 =?utf-8?B?VkZNS1dWQy9Bbzd0aVdtTGUwUk44cVFUYytySWZwNEQ0b21HaU5VTi9jSVV2?=
 =?utf-8?B?QTJEQTF2c3N4SnBLU2JyVlNtaUZkcW1UZkpPWGcyRVZSYUhVUTVpMlBDcVJl?=
 =?utf-8?B?dDlrQThLc3ZvQlFNTDJ5ZEtUdkRpREd1aDYxYVF6emVBVHo4VlZwdDdDNXpB?=
 =?utf-8?B?M0xYTFFQeWxpZno2M2FSZXFVeWRvalMvK3ZYd0JQcEFIK3VSTWcwWkh0QnZi?=
 =?utf-8?B?VFJaM0pWcFJVMm0wMHZ2SUxab3hPTXpHR3VyS1RqV0U2anNRODFXbWNKZUdU?=
 =?utf-8?B?VGVhOFN0UVp1RWNhZ0tEcUlvblUvUDA4QlgrSHI5VWQraGRRQklPQ3UvVXc2?=
 =?utf-8?B?RkRnQkdJUmFUbnJ3NFh5eWk5OVhNSDNtdVhLMEFKQU9tSTQzb3krN0ZoMUtv?=
 =?utf-8?B?a3dhYnNhNTZmS083eDNFeWFoQlUvMEhUYUtPRlZrMnBBZ2Vtb2hUd2VJcU1G?=
 =?utf-8?B?MW9wNkJ0bDhuaSt4czU4M3BET1lrMXJZNFJ5ZDdkdndTaC9vcVVlTllGT0NW?=
 =?utf-8?B?R1Q4RGowUU83d3lQUHFQbVVUa3drZVlKSTBXdHJGUUZSMGM3ZTE2c0dkQVQ3?=
 =?utf-8?B?MEVZemdhbkZicFJZdmNFOC9pRFRSVzRic0RyaHhhWVFWN0JCMHFkME9CeExP?=
 =?utf-8?B?MkRiRUgramkxUVYyMGlwcWNiRmFYTEZCNlFxQW1DVHFMN0NUQ1R2citkTy9l?=
 =?utf-8?B?QjlsTkRVSkVPbXNGd2J4WXYyMnl4dit2ZHNlakh6QXlqUnhBNEkxOVpWY3Bi?=
 =?utf-8?B?ZFE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ec39af1-bc3a-4da1-7e81-08dd0427d718
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 21:12:11.5293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YnckSCj61iYntpfDPQVnX0ElmoWfSNZ3oo+009WE3PjLlfn7XbN5of/61JuvnfX0PD1J97eGEah5SYIy5wQn/GIgAfXHaNtkbvIMhGxHYFc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7920
X-OriginatorOrg: intel.com

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFlvc3J5IEFobWVkIDx5b3Ny
eWFobWVkQGdvb2dsZS5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTm92ZW1iZXIgMTMsIDIwMjQg
MTowMCBQTQ0KPiBUbzogU3JpZGhhciwgS2FuY2hhbmEgUCA8a2FuY2hhbmEucC5zcmlkaGFyQGlu
dGVsLmNvbT4NCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LW1tQGt2
YWNrLm9yZzsNCj4gaGFubmVzQGNtcHhjaGcub3JnOyBucGhhbWNzQGdtYWlsLmNvbTsgY2hlbmdt
aW5nLnpob3VAbGludXguZGV2Ow0KPiB1c2FtYWFyaWY2NDJAZ21haWwuY29tOyByeWFuLnJvYmVy
dHNAYXJtLmNvbTsgSHVhbmcsIFlpbmcNCj4gPHlpbmcuaHVhbmdAaW50ZWwuY29tPjsgMjFjbmJh
b0BnbWFpbC5jb207IGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc7DQo+IEZlZ2hhbGksIFdhamRp
IEsgPHdhamRpLmsuZmVnaGFsaUBpbnRlbC5jb20+OyBHb3BhbCwgVmlub2RoDQo+IDx2aW5vZGgu
Z29wYWxAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxXSBtbTogenN3YXA6IEZp
eCBhIHBvdGVudGlhbCBtZW1vcnkgbGVhayBpbg0KPiB6c3dhcF9kZWNvbXByZXNzKCkuDQo+IA0K
PiBbLi5dDQo+ID4gPg0KPiA+ID4gUGxlYXNlIGp1c3QgcmV3cml0ZSB0aGUgY29tbWl0IGxvZyBh
bmQgQ0Mgc3RhYmxlIChpbiB0aGUgY29tbWl0IGxvZywNCj4gPiA+IG5vdCBpbiB0aGUgZW1haWwg
Q0MgbGlzdCkuDQo+ID4NCj4gPiBJIGd1ZXNzIHRoaXMgcmVmZXJzIHRvIGFkZGluZyAiQ2M6IHN0
YWJsZUB2Z2VyLmtlcm5lbC5vcmciIGluIHRoZSBjb21taXQgbG9nDQo+ID4gKGFzIGZvdW5kIGZy
b20gdGhlIGxhdGVzdCBtYWlubGluZSBnaXQgbG9nKSA/DQo+IA0KPiBZZXMsIHRoYW5rcyENCg0K
U291bmRzIGdvb2QsIHRoYW5rcyBZb3NyeSENCg0KPiANCj4gPg0KPiA+IFRoYW5rcyBhZ2FpbiwN
Cj4gPiBLYW5jaGFuYQ0KPiA+DQo=

