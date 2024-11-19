Return-Path: <linux-kernel+bounces-415016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC329D3094
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 23:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A7612842D7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 22:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41351C57A5;
	Tue, 19 Nov 2024 22:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LGmt24I+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DB31C1F36
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 22:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732055750; cv=fail; b=sXiMzhOrlA4SfBYJzR05QFZQnAx6HtiZ48kwnjc6islwDqUnPDs3VQuUSZTf0DrSX1/CI7xepByvE8Ze9smioOc2tFgJ7m6e6RYz5Xei9w4DBzUY6h+Z4OK4k+10oCrzpNcbBHg/x8itsP9EDx5OcDDbXO7uhDCk3L8r99CWV/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732055750; c=relaxed/simple;
	bh=ktUzPch44l6Zrps6Lon60kUqqbPFOnufg9i3KlVwVN4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M/21ajM6vzj1++J4jRp1X6/zz2Fvc/aVhMWePWwmmzUgat9HwVrA992xNWX99QkR1/2fiX4QOxOhTaCxTXiIW8oO8qRnGlnwicSUXvqWEI6qhHHub0ny2S4kR6V8d4Q0AWwuGhxGrjC7p0WHQovZVdp0BwnCEKfu8j65fkb9dVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LGmt24I+; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732055749; x=1763591749;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ktUzPch44l6Zrps6Lon60kUqqbPFOnufg9i3KlVwVN4=;
  b=LGmt24I+xR1OmT96c6KxVxUI7Dhwwdum7jO9pdR0UTt8rU/QgFFNDwoN
   BSBCff7l4Ln9noRgJ+YTfSRoqjGKBdhBxRPego5Gtx9nsG3BvTW42t51m
   HaomBufpvBqnw3ZU1OYQ7mDfNQCcrEvphes4V7Sc130yaeZmmYQXR4IvQ
   bZrfhR597V1tHIgo9Cdw44YJleGQP8IO/1jl86bL+nPVTuhr+wC7z9uyd
   V/pKnTdF/KUYlXA1T+dBxJV+UbdZVJqmMY5hDKXQW4+bgax6eH9mafeMO
   p1MSWJg+pTLxSateunxsc15FjRE+rvWtX94eKLHgyclsQxNwPcGPnwJ61
   Q==;
X-CSE-ConnectionGUID: GFoe/tyVRhSJBLJwQdSFQA==
X-CSE-MsgGUID: 9aOpCIozRM+2WgUkmGVaDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11261"; a="43470365"
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="43470365"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 14:35:48 -0800
X-CSE-ConnectionGUID: w9iK4rAGTXa+VxbSsEEb5A==
X-CSE-MsgGUID: H9ibB7NgR3+1oAbmdjS15A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="94765065"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Nov 2024 14:35:47 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 19 Nov 2024 14:35:47 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 19 Nov 2024 14:35:47 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 19 Nov 2024 14:35:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FIvZcXy0S+PzOWR7MaPCd93PS+OHygfqE+DPtTq8MRknFl35vnsyjEOj7rbtyvl9mFgT4YmyWoToIKByp4MNmTHBSbt7XPhJ6m15vPwRDrtao7OrttOsMK5ZhR8e4Wvxa37KaWjTK0CrbTODvnHO/blhKwgunXBnEXtoYmr9Tvs29WoT1/UIAn4Dp3gFkFkI7MjizyMOHgpI8ZOKGzbfA5CcTqybtvrdZz3/dfAwyXs2fJwpT1ZbybZYMy3MdypQkXuQpXDUyMzJHHdeHJ63OJEoph1AUTVAY0GYP4+she9i84apFUCrIOh8mZbDDMNoDQHqLbVAJRYeGBe5v7iAQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ktUzPch44l6Zrps6Lon60kUqqbPFOnufg9i3KlVwVN4=;
 b=ES6JM9ntS6END6rh4Dlkq0igj/ENDPnrGnFCbCJcP+uAN6UhrtoFzAIHwrONEECAW1bbcEH9gqxkuTQwkGIsXK8mOehWMFZ6xVTWo24GKsBtf4hdIay+wjXBMCZXyxqAtDOhhwB6CwTtjmuaD84sQlHerPScffqaLu4K0q6Ot80I1qcBGUuTCgJ0k43ofloJT+/buJCWZtEMKLyjfWFXRyIPBwUCFynyraZmRnPYhoY1Nu+eSSM8+89WEkqSWBqbqFvIkUGwLICur5KHPaSW9PglNfgouc2G0vYomkC9u+S4B0CaBpU68znatKQnxi7wbBMJp9ExVgOF/hf+jpZnMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by CO1PR11MB4914.namprd11.prod.outlook.com (2603:10b6:303:90::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Tue, 19 Nov
 2024 22:35:43 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 22:35:43 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Yosry Ahmed <yosryahmed@google.com>
CC: Chengming Zhou <chengming.zhou@linux.dev>, Johannes Weiner
	<hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "usamaarif642@gmail.com"
	<usamaarif642@gmail.com>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"21cnbao@gmail.com" <21cnbao@gmail.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>,
	"Gopal, Vinodh" <vinodh.gopal@intel.com>, "Sridhar, Kanchana P"
	<kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v1] mm: zswap: Fix a potential memory leak in
 zswap_decompress().
Thread-Topic: [PATCH v1] mm: zswap: Fix a potential memory leak in
 zswap_decompress().
Thread-Index: AQHbNYxgo97ShYNp0k+eAlG8E2BdYbK0sGWAgAAC9UCAAAo2gIAAydcggAAz64CAAATjwIAALQAAgAAWEyCAADkJgIAAFDJAgAAQz4CAAnAwsIAAE8aAgAYeOFCAAANpAIAAAiqQgAAEjwCAACdygA==
Date: Tue, 19 Nov 2024 22:35:43 +0000
Message-ID: <SJ0PR11MB56780456B6808A54954D9EC9C9202@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20241113052413.157039-1-kanchana.p.sridhar@intel.com>
 <CAJD7tkZWDhOXyyZnEYFiS7F4tSV+z6TYXUYiEcrZrRuy_3R=ZA@mail.gmail.com>
 <DM8PR11MB567179534CEE154369CCA174C95A2@DM8PR11MB5671.namprd11.prod.outlook.com>
 <CAJD7tkbLtjQqR-uf8EBoFCWbkYOLHsVh6vJoMZUj+z4eN0GKAQ@mail.gmail.com>
 <SJ0PR11MB56781940E69ABE93FF9076F6C95A2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <20241113213007.GB1564047@cmpxchg.org>
 <SJ0PR11MB5678C24CDF6AA4FED306FC71C95A2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAKEwX=P6mxZ+-5UcunRHeoAVwtZD=UMfKqCGUeun-krJeT8ekg@mail.gmail.com>
 <SJ0PR11MB56785F052557B685054AF74AC95B2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <20241114051149.GC1564047@cmpxchg.org>
 <SJ0PR11MB56780DD2A8EB343627FE94FCC95B2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <9a807484-6693-4e2a-a087-97bbc5ee4ed9@linux.dev>
 <SJ0PR11MB567847C73338BC325FE49D11C9242@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkZ+OM2uiHgHHeNqBeSaptfXw4MG=E280-5PKpeybB=8dQ@mail.gmail.com>
 <SJ0PR11MB5678C6C693444F64E38CE2EBC9202@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkaMMoPjrR7mLNMiFD7nOhUoLBJ22BNQYEPvfPww5d2jTg@mail.gmail.com>
 <SJ0PR11MB5678A7DF494C3FCB687D620EC9202@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkYP9c8Dc1+fuG2i=okFbVf=jBph3cdFmOO0+vAvmcApvQ@mail.gmail.com>
In-Reply-To: <CAJD7tkYP9c8Dc1+fuG2i=okFbVf=jBph3cdFmOO0+vAvmcApvQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|CO1PR11MB4914:EE_
x-ms-office365-filtering-correlation-id: 508182b2-92ab-4205-013a-08dd08ea80fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZUdhZmlqdmtrUno5ZTNxMkxibEk1dW1FbjVHNGhGcUdyMTBjNFM5TmtOQmR2?=
 =?utf-8?B?d2FtekRrRTBhUE1YN1VCYm05dGU3aGhHSVF0ZWUzSlBaV3RSYk9HN1FYY1Ja?=
 =?utf-8?B?Q2FiYjlPaDJmV3hRTVN4QzlLbkZpRFIvUmpWOWZUckZHU2V5b201RE1TNkc3?=
 =?utf-8?B?bkk4eU80eGhGYnhnT1RnbVhSUDh5SEUzRHliVllvWHI0QTg4TUVpZnRBU3Qz?=
 =?utf-8?B?UkpCamk0b2tHNkJMR3RONWZubm1QRHdYcjk0M0kvbTFES3pVd1hhL2tkeW1B?=
 =?utf-8?B?MEY1a0ZDOGxSZG1JanVrL2dpK2pnYVNxM3c4R1dnakZqL3d0VEpDWDluNmtU?=
 =?utf-8?B?TktOQnkwbkh3QzJNSXplZlVoS1pvQ0RZamorWVdXM1JJeTJTOFdUWlJTZmFP?=
 =?utf-8?B?NUJxaUxhVi9WbThSSEhUZmhEclBrK1kvZVIwZjRWeW9oZEU2YUszYktCWk1Z?=
 =?utf-8?B?UDRkTkxqREVHQlBHRHl4dUU2RktOM21aR1dhTWlMb3NWUzNZclIxWEptV1hE?=
 =?utf-8?B?aTlJYUtUWml4eEdNUDdEeitHbjJsYTJ2RnhUUkRmeWVPYzFHRlFoS3FSdEVT?=
 =?utf-8?B?T29HVUF3M253R3RrNDB0NXZya2tUWnJZSHZqUDlNVFBOZjlnWlhGd0dwcjJm?=
 =?utf-8?B?REgzSXlpVHo0RkJxWktHek53cTJubEpsaUEwTGQ3K0p2NWZrREkvYlExQXV2?=
 =?utf-8?B?d3ZqOWUxc3FwalRaYnEyTWhuMHBlWlA2clhWQlA3ZTNPQVFPZmtPendWQXM1?=
 =?utf-8?B?WWU1OFcyN3Y5dkdJamx6cTIxL2RaZU5zU1o3eGRFeXo1K25DN1FhVER5QXhw?=
 =?utf-8?B?d0hkL0NwL1hFZ2Jrbm1paUg3Z0V0NHM5bmN1KzBYMFFaRWZmVndUaFlNWUxq?=
 =?utf-8?B?dDl2ajZDcGFVaFY3eGdJK2F3SnJJOHpFVVV5a3JnTVYvNWxuVXc2aTdka3Zm?=
 =?utf-8?B?dkVZUHk0RUgrOUFSc0g2bS9WRUcxb1V2SmpSdm45NkZGN1R0LzZ6a0Y4c1RY?=
 =?utf-8?B?blpPTldJVm9xajZISWR4b2tFa0FzUkFTcEVSWFZaQkZNdTRFazRyczNCQnEx?=
 =?utf-8?B?TkR5WHp3NEpGV09OdkQydlBIc2o0VUMyaXdZTzRQblFrdWtzdXlqOExTcUNi?=
 =?utf-8?B?MzhjSnpMczl1cVd1bTdsTkNqejNVZjRUSGVuS0hnQWh3bmMrTFliNy9tNkNJ?=
 =?utf-8?B?K2tPcGhTRzRYQjFTL3VLbTVtQjF1R29QRFl5VUQxd3FoQlpndXVKNFNkZHdn?=
 =?utf-8?B?WFdIMW11YzhzYVFMREJVejBlbEFGQnBUeWVDLzZ1SzZ4Vy9LTkYyeHBjQVVE?=
 =?utf-8?B?UURScUJsZEo1b0xZck44VE5LemVFbHM0b3RHVUc2b3UzT0J5VkJYNUNWcTlO?=
 =?utf-8?B?RFVoc1N2cDY0UnM3SHR6d2tKbjdCdzk3aGpPSHJkanRvVHhMamF1UmdMQTZi?=
 =?utf-8?B?MStjcGJtWWtOUGVXbTRWWWpJcmNkbnJOWnE4WXdNYytnZUlBTndBQjVpUjFw?=
 =?utf-8?B?aWw2Nlp4L0JwOWdEY3lZdFRVZEY3cDNQZDREVkFXT1dKUFpXQ1FqTUltUWdE?=
 =?utf-8?B?VTZEZE1nQ1hSbExBM2FseWpYeEVkUWNDbFVpaW1QU1p0b2ZyNDJMUlR5U3gr?=
 =?utf-8?B?QjIwR0wvUXpJSTlmdzB4bHA3ZmRVVjZJMEg0U2ppdTJPRFJ6UkxoMnFvdjls?=
 =?utf-8?B?ckVGRWk5ZFVOdjVvMEZMZGVYQjQ2TzlsbTd3UWRCbnd0Q1liQW5HbFFMV2xT?=
 =?utf-8?B?MFVRSGt6WDMzMmJXems4ZjhuQ2JvaUJmb1k0WGRQNEx0Nzc3SS83MGhxa0hM?=
 =?utf-8?Q?1iPkeVGcsZGuX1z0iiT22hQiztXQLvauzVr6k=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZGhrVWoyMmRmbEh2NkZtUTVjQlZxK0UvSWZ6eThqWHpiSDNqTmkwU1k3bmEx?=
 =?utf-8?B?dzdCdlBxanBtOXRiTWtIV2NLSHEvS1BFMnJab01LQ3BZYjA4M1BxOTlPMXF6?=
 =?utf-8?B?Yk5Kemw0a2c3RFdudWNpMXVYSGZTWWRCY3Q0RGVqWmJPOURDR1RFV3FrYUcx?=
 =?utf-8?B?Qm4xL2FtZmM2QXd2MHQ1dldGM2VPa0lXRzNkaTFBeWpaRUNrM2xWM3lFQlNT?=
 =?utf-8?B?RUpVUjdrV0k5R3NiRGFqWW5TUFg2dTJLcm1rMkE0RmUzenlkOUxtdWc5anky?=
 =?utf-8?B?MlM4QmFCeDVjODU1ZjMwTGRUcWs2am5XVFhSYnZDN2RtclhmcUtjZk0rU3A0?=
 =?utf-8?B?TkJpQjhaYnZTa2NKb1QrdXNtY24rN0dCaThmak5wNVpDNTVLTHdZaFFaZU1P?=
 =?utf-8?B?YXdOSXBCR3F2a0l0VjgxZUM4RFlOZXo1NFlleVRzOFR1M0QwNW1IREovODNO?=
 =?utf-8?B?d3g2cUNOdS9UYmU2bmJaaWRQaFlvV1dZc3BnWFUwZy9vMUcxQUdMRjlzVDZv?=
 =?utf-8?B?RjBIcHlod29hcEExbUNFUVFtaFZBKytyTjJpZ29TejBZVXNVa2E1aHBrWjNK?=
 =?utf-8?B?amhuRHFJMlNTaTIzMk9UTEprODJIckdNc2dhc29nd09EaisyUTBicEh3Mlg1?=
 =?utf-8?B?ZVFsdjZ5MEo2RGJHUXEyRDJBZXRCK1RvZ3FtUUFMZFFVMnZMWkpSNFlqWUls?=
 =?utf-8?B?VjFBVVBsKzhNa0VxVEF5a05IQk9ZMjlYVEV2N21NQ0Y5OTJxeUp1TG9HVUZF?=
 =?utf-8?B?YXF6RENoUWZJZHpKQ2F5ZmJrbXBiUWtaQW0vUW4rcWhDY1dGR1BkNk0wRkRa?=
 =?utf-8?B?VkFxUFBxVWN2V2FpVExaRS8rT1h0OEdUNnVJc2hqbmtWOC90SzY2VmFWZ3VU?=
 =?utf-8?B?bnoxc2s4aDlnMjJ0UStRcnA1MWJFa1RnVzRXSmZSRmRLVkl6UThmVFFKK0hi?=
 =?utf-8?B?bXArQnM4NENadmJ5UE1ZSDh4ZWVPMEZFZWl4MVlLbVl3c21aUGovUUVTRm5v?=
 =?utf-8?B?ZEROM1pqL3RtR1lwSTBFREs4enZRUGJjVzBGV2FqOHhBcjY1TFFGZkJtaVFX?=
 =?utf-8?B?MFpsUndRNVdmVm55VS9TekpHc3pPczJ1QmxjcXBzTzFONWJOT2xrUkQzdkVB?=
 =?utf-8?B?aFZSMlFmcjlZWUZKcndjRW1XNXpZZ2t1ekEvMXZNUTNqNEhRVVUzQVNDUUx6?=
 =?utf-8?B?ZXZPRlRudkJBU0czNS8zSm41a0NiUENaZlU1RWNWeC9nQ3lQbjdrRXN3K1g1?=
 =?utf-8?B?cWFzZCsyc0JBdUx2S3JwckdHNWJvTTJuRTB6WkNGUnNTWDUzTkcxRmw2Uy9v?=
 =?utf-8?B?VGdUaXhzT084V3NuTnMvTE00ZVpHMnFqVmxsaStIVC9adkZneFVCRmdKb085?=
 =?utf-8?B?bUVyZk8vOUNMZUdUdzZ5TWJRVCtSSUNXZkVTNmtkdUNMN1FGR1crelJEcnly?=
 =?utf-8?B?ZWYrNkxyTi9CV1ZPUzVaUFBzcGRXY04rQ3ViTTlrTmFWLzhkVldLVm1CK1Vx?=
 =?utf-8?B?MGZqbWREbUIvMmlZY1hPYkFZdlRBQ0N5d1paNG1VclNwKzVkUzlqSTI3elhI?=
 =?utf-8?B?RU1KRlZTNG1yTTNuZ0l4ZHJlT09iOXNsWW1GM1hPMmQraUNNdEFwdzA1YzJT?=
 =?utf-8?B?UGdEZTcwT1Z0OHdrN1dZd0l0aTZmZkhqY093bUxQa1NzS2dQNEczeVNpcUNV?=
 =?utf-8?B?Wk1mdE5YZFBmNVRYaUhuZVo4TW1iWUVUa0M0M21OWWlIcEptYWZDYVIvNC9K?=
 =?utf-8?B?ckl6d2M5NWQreTd2cUtnY2R0Q25sL0I3clVHbjVjQjZkSDc4K2pVTGVwUWpl?=
 =?utf-8?B?ek82cklxeXd3Q1RYbzhzbkdjWjRYTDlrR2I3NjlhTDAydkJEdnpaWUhENEpI?=
 =?utf-8?B?NXhybVQ3U0tZOVd4c0Nzd3dXT25FUVBzM1J0NnpBOHpvN3pqYTNOZWFPTkFY?=
 =?utf-8?B?cHZyQ0FxY0k0eFhsRmRSWHM1S1pEUkJQKzMyZytTQjZLcHZaMUcrU0QxSFF5?=
 =?utf-8?B?TEpXbGY0Y0NMV3g4OWhIalBBekt4aUZ0bngvU2RZcFFVeW5Ld0d1bnFRWm9y?=
 =?utf-8?B?c2lkbnoxWW5sRDQvNitza01IczlrYmdNcmxTQ1JBZFpBekFCeW5MRzVabEFn?=
 =?utf-8?B?QytyQ1FNNnNpR0ZGbGpFczdBVHR1SXdjcDE5WFIyNTluRmozRTV3WEVzSjEx?=
 =?utf-8?B?Z1E9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 508182b2-92ab-4205-013a-08dd08ea80fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2024 22:35:43.5769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fRS6UuM4a1AOrkAcG9BMO423CRnWU1I2c2+1WNwYSvPvetu/vanu56UwiRFzQS8CVC0Pl9/ZmEoSWs1esf5zy+SkgboogWTEylunQtz1Ug8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4914
X-OriginatorOrg: intel.com

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFlvc3J5IEFobWVkIDx5b3Ny
eWFobWVkQGdvb2dsZS5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDE5LCAyMDI0IDEx
OjUxIEFNDQo+IFRvOiBTcmlkaGFyLCBLYW5jaGFuYSBQIDxrYW5jaGFuYS5wLnNyaWRoYXJAaW50
ZWwuY29tPg0KPiBDYzogQ2hlbmdtaW5nIFpob3UgPGNoZW5nbWluZy56aG91QGxpbnV4LmRldj47
IEpvaGFubmVzIFdlaW5lcg0KPiA8aGFubmVzQGNtcHhjaGcub3JnPjsgTmhhdCBQaGFtIDxucGhh
bWNzQGdtYWlsLmNvbT47IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1t
bUBrdmFjay5vcmc7IHVzYW1hYXJpZjY0MkBnbWFpbC5jb207DQo+IHJ5YW4ucm9iZXJ0c0Bhcm0u
Y29tOyAyMWNuYmFvQGdtYWlsLmNvbTsgYWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZzsNCj4gRmVn
aGFsaSwgV2FqZGkgSyA8d2FqZGkuay5mZWdoYWxpQGludGVsLmNvbT47IEdvcGFsLCBWaW5vZGgN
Cj4gPHZpbm9kaC5nb3BhbEBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjFdIG1t
OiB6c3dhcDogRml4IGEgcG90ZW50aWFsIG1lbW9yeSBsZWFrIGluDQo+IHpzd2FwX2RlY29tcHJl
c3MoKS4NCj4gDQo+IE9uIFR1ZSwgTm92IDE5LCAyMDI0IGF0IDExOjQy4oCvQU0gU3JpZGhhciwg
S2FuY2hhbmEgUA0KPiA8a2FuY2hhbmEucC5zcmlkaGFyQGludGVsLmNvbT4gd3JvdGU6DQo+ID4N
Cj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IFlvc3J5
IEFobWVkIDx5b3NyeWFobWVkQGdvb2dsZS5jb20+DQo+ID4gPiBTZW50OiBUdWVzZGF5LCBOb3Zl
bWJlciAxOSwgMjAyNCAxMToyNyBBTQ0KPiA+ID4gVG86IFNyaWRoYXIsIEthbmNoYW5hIFAgPGth
bmNoYW5hLnAuc3JpZGhhckBpbnRlbC5jb20+DQo+ID4gPiBDYzogQ2hlbmdtaW5nIFpob3UgPGNo
ZW5nbWluZy56aG91QGxpbnV4LmRldj47IEpvaGFubmVzIFdlaW5lcg0KPiA+ID4gPGhhbm5lc0Bj
bXB4Y2hnLm9yZz47IE5oYXQgUGhhbSA8bnBoYW1jc0BnbWFpbC5jb20+OyBsaW51eC0NCj4gPiA+
IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LW1tQGt2YWNrLm9yZzsgdXNhbWFhcmlmNjQy
QGdtYWlsLmNvbTsNCj4gPiA+IHJ5YW4ucm9iZXJ0c0Bhcm0uY29tOyBIdWFuZywgWWluZyA8eWlu
Zy5odWFuZ0BpbnRlbC5jb20+Ow0KPiA+ID4gMjFjbmJhb0BnbWFpbC5jb207IGFrcG1AbGludXgt
Zm91bmRhdGlvbi5vcmc7IEZlZ2hhbGksIFdhamRpIEsNCj4gPiA+IDx3YWpkaS5rLmZlZ2hhbGlA
aW50ZWwuY29tPjsgR29wYWwsIFZpbm9kaCA8dmlub2RoLmdvcGFsQGludGVsLmNvbT4NCj4gPiA+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjFdIG1tOiB6c3dhcDogRml4IGEgcG90ZW50aWFsIG1lbW9y
eSBsZWFrIGluDQo+ID4gPiB6c3dhcF9kZWNvbXByZXNzKCkuDQo+ID4gPg0KPiA+ID4gT24gVHVl
LCBOb3YgMTksIDIwMjQgYXQgMTE6MjLigK9BTSBTcmlkaGFyLCBLYW5jaGFuYSBQDQo+ID4gPiA8
a2FuY2hhbmEucC5zcmlkaGFyQGludGVsLmNvbT4gd3JvdGU6DQo+ID4gPiA+DQo+ID4gPiA+DQo+
ID4gPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+ID4gPiBGcm9tOiBZb3Ny
eSBBaG1lZCA8eW9zcnlhaG1lZEBnb29nbGUuY29tPg0KPiA+ID4gPiA+IFNlbnQ6IEZyaWRheSwg
Tm92ZW1iZXIgMTUsIDIwMjQgMTo0OSBQTQ0KPiA+ID4gPiA+IFRvOiBTcmlkaGFyLCBLYW5jaGFu
YSBQIDxrYW5jaGFuYS5wLnNyaWRoYXJAaW50ZWwuY29tPg0KPiA+ID4gPiA+IENjOiBDaGVuZ21p
bmcgWmhvdSA8Y2hlbmdtaW5nLnpob3VAbGludXguZGV2PjsgSm9oYW5uZXMgV2VpbmVyDQo+ID4g
PiA+ID4gPGhhbm5lc0BjbXB4Y2hnLm9yZz47IE5oYXQgUGhhbSA8bnBoYW1jc0BnbWFpbC5jb20+
OyBsaW51eC0NCj4gPiA+ID4gPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1tbUBrdmFj
ay5vcmc7DQo+IHVzYW1hYXJpZjY0MkBnbWFpbC5jb207DQo+ID4gPiA+ID4gcnlhbi5yb2JlcnRz
QGFybS5jb207IEh1YW5nLCBZaW5nIDx5aW5nLmh1YW5nQGludGVsLmNvbT47DQo+ID4gPiA+ID4g
MjFjbmJhb0BnbWFpbC5jb207IGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc7IEZlZ2hhbGksIFdh
amRpIEsNCj4gPiA+ID4gPiA8d2FqZGkuay5mZWdoYWxpQGludGVsLmNvbT47IEdvcGFsLCBWaW5v
ZGgNCj4gPHZpbm9kaC5nb3BhbEBpbnRlbC5jb20+DQo+ID4gPiA+ID4gU3ViamVjdDogUmU6IFtQ
QVRDSCB2MV0gbW06IHpzd2FwOiBGaXggYSBwb3RlbnRpYWwgbWVtb3J5IGxlYWsgaW4NCj4gPiA+
ID4gPiB6c3dhcF9kZWNvbXByZXNzKCkuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBPbiBGcmksIE5v
diAxNSwgMjAyNCBhdCAxOjE04oCvUE0gU3JpZGhhciwgS2FuY2hhbmEgUA0KPiA+ID4gPiA+IDxr
YW5jaGFuYS5wLnNyaWRoYXJAaW50ZWwuY29tPiB3cm90ZToNCj4gPiA+ID4gPiA+DQo+ID4gPiA+
ID4gPiBIaSBDaGVuZ21pbmcsDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gPiA+ID4gPiBGcm9tOiBDaGVuZ21pbmcgWmhvdSA8Y2hl
bmdtaW5nLnpob3VAbGludXguZGV2Pg0KPiA+ID4gPiA+ID4gPiBTZW50OiBXZWRuZXNkYXksIE5v
dmVtYmVyIDEzLCAyMDI0IDExOjI0IFBNDQo+ID4gPiA+ID4gPiA+IFRvOiBTcmlkaGFyLCBLYW5j
aGFuYSBQIDxrYW5jaGFuYS5wLnNyaWRoYXJAaW50ZWwuY29tPjsNCj4gSm9oYW5uZXMNCj4gPiA+
ID4gPiBXZWluZXINCj4gPiA+ID4gPiA+ID4gPGhhbm5lc0BjbXB4Y2hnLm9yZz4NCj4gPiA+ID4g
PiA+ID4gQ2M6IE5oYXQgUGhhbSA8bnBoYW1jc0BnbWFpbC5jb20+OyBZb3NyeSBBaG1lZA0KPiA+
ID4gPiA+ID4gPiA8eW9zcnlhaG1lZEBnb29nbGUuY29tPjsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsgbGludXgtDQo+ID4gPiA+ID4gPiA+IG1tQGt2YWNrLm9yZzsgdXNhbWFhcmlmNjQy
QGdtYWlsLmNvbTsNCj4gcnlhbi5yb2JlcnRzQGFybS5jb207DQo+ID4gPiA+ID4gSHVhbmcsDQo+
ID4gPiA+ID4gPiA+IFlpbmcgPHlpbmcuaHVhbmdAaW50ZWwuY29tPjsgMjFjbmJhb0BnbWFpbC5j
b207IGFrcG1AbGludXgtDQo+ID4gPiA+ID4gPiA+IGZvdW5kYXRpb24ub3JnOyBGZWdoYWxpLCBX
YWpkaSBLIDx3YWpkaS5rLmZlZ2hhbGlAaW50ZWwuY29tPjsNCj4gR29wYWwsDQo+ID4gPiA+ID4g
Vmlub2RoDQo+ID4gPiA+ID4gPiA+IDx2aW5vZGguZ29wYWxAaW50ZWwuY29tPg0KPiA+ID4gPiA+
ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxXSBtbTogenN3YXA6IEZpeCBhIHBvdGVudGlhbCBt
ZW1vcnkgbGVhayBpbg0KPiA+ID4gPiA+ID4gPiB6c3dhcF9kZWNvbXByZXNzKCkuDQo+ID4gPiA+
ID4gPiA+DQo+ID4gPiA+ID4gPiA+IEhlbGxvLA0KPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4g
PiBPbiAyMDI0LzExLzE0IDE0OjM3LCBTcmlkaGFyLCBLYW5jaGFuYSBQIHdyb3RlOg0KPiA+ID4g
PiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
ID4gPiA+ID4gPiA+ID4+IEZyb206IEpvaGFubmVzIFdlaW5lciA8aGFubmVzQGNtcHhjaGcub3Jn
Pg0KPiA+ID4gPiA+ID4gPiA+PiBTZW50OiBXZWRuZXNkYXksIE5vdmVtYmVyIDEzLCAyMDI0IDk6
MTIgUE0NCj4gPiA+ID4gPiA+ID4gPj4gVG86IFNyaWRoYXIsIEthbmNoYW5hIFAgPGthbmNoYW5h
LnAuc3JpZGhhckBpbnRlbC5jb20+DQo+ID4gPiA+ID4gPiA+ID4+IENjOiBOaGF0IFBoYW0gPG5w
aGFtY3NAZ21haWwuY29tPjsgWW9zcnkgQWhtZWQNCj4gPiA+ID4gPiA+ID4gPj4gPHlvc3J5YWht
ZWRAZ29vZ2xlLmNvbT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LQ0K
PiA+ID4gPiA+ID4gPiA+PiBtbUBrdmFjay5vcmc7IGNoZW5nbWluZy56aG91QGxpbnV4LmRldjsN
Cj4gPiA+ID4gPiB1c2FtYWFyaWY2NDJAZ21haWwuY29tOw0KPiA+ID4gPiA+ID4gPiA+PiByeWFu
LnJvYmVydHNAYXJtLmNvbTsgSHVhbmcsIFlpbmcgPHlpbmcuaHVhbmdAaW50ZWwuY29tPjsNCj4g
PiA+ID4gPiA+ID4gPj4gMjFjbmJhb0BnbWFpbC5jb207IGFrcG1AbGludXgtZm91bmRhdGlvbi5v
cmc7IEZlZ2hhbGksDQo+IFdhamRpIEsNCj4gPiA+ID4gPiA+ID4gPj4gPHdhamRpLmsuZmVnaGFs
aUBpbnRlbC5jb20+OyBHb3BhbCwgVmlub2RoDQo+ID4gPiA8dmlub2RoLmdvcGFsQGludGVsLmNv
bT4NCj4gPiA+ID4gPiA+ID4gPj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MV0gbW06IHpzd2FwOiBG
aXggYSBwb3RlbnRpYWwgbWVtb3J5DQo+IGxlYWsgaW4NCj4gPiA+ID4gPiA+ID4gPj4genN3YXBf
ZGVjb21wcmVzcygpLg0KPiA+ID4gPiA+ID4gPiA+Pg0KPiA+ID4gPiA+ID4gPiA+PiBPbiBUaHUs
IE5vdiAxNCwgMjAyNCBhdCAwMTo1NjoxNkFNICswMDAwLCBTcmlkaGFyLCBLYW5jaGFuYQ0KPiBQ
DQo+ID4gPiA+ID4gd3JvdGU6DQo+ID4gPiA+ID4gPiA+ID4+PiBTbyBteSBxdWVzdGlvbiB3YXMs
IGNhbiB3ZSBwcmV2ZW50IHRoZSBtaWdyYXRpb24gdG8gYQ0KPiBkaWZmZXJlbnQNCj4gPiA+IGNw
dQ0KPiA+ID4gPiA+ID4gPiA+Pj4gYnkgcmVsaW5xdWlzaGluZyB0aGUgbXV0ZXggbG9jayBhZnRl
ciB0aGlzIGNvbmRpdGlvbmFsDQo+ID4gPiA+ID4gPiA+ID4+DQo+ID4gPiA+ID4gPiA+ID4+IEhv
bGRpbmcgdGhlIG11dGV4IGRvZXNuJ3QgcHJldmVudCBwcmVlbXB0aW9uL21pZ3JhdGlvbi4NCj4g
PiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+IFN1cmUsIGhvd2V2ZXIsIGlzIHRoaXMgYWxz
byBhcHBsaWNhYmxlIHRvIGhvbGRpbmcgdGhlIG11dGV4IG9mIGENCj4gcGVyLQ0KPiA+ID4gY3B1
DQo+ID4gPiA+ID4gPiA+ID4gc3RydWN0dXJlIG9idGFpbmVkIHZpYSByYXdfY3B1X3B0cigpPw0K
PiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiBZZXMsIHVubGVzcyB5b3UgdXNlIG1pZ3JhdGlv
bl9kaXNhYmxlKCkgb3IgY3B1c19yZWFkX2xvY2soKSB0bw0KPiBwcm90ZWN0DQo+ID4gPiA+ID4g
PiA+IHRoaXMgc2VjdGlvbi4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBPay4NCj4gPiA+ID4g
PiA+DQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gPiBXb3Vs
ZCBob2xkaW5nIHRoZSBtdXRleCBwcmV2ZW50IHRoZSBhY29tcF9jdHggb2YgdGhlIGNwdSBwcmlv
cg0KPiB0bw0KPiA+ID4gPiA+ID4gPiA+IHRoZSBtaWdyYXRpb24gKGluIHRoZSBVQUYgc2NlbmFy
aW8geW91IGRlc2NyaWJlZCkgZnJvbSBiZWluZw0KPiA+ID4gZGVsZXRlZD8NCj4gPiA+ID4gPiA+
ID4NCj4gPiA+ID4gPiA+ID4gTm8sIGNwdSBvZmZsaW5lIGNhbiBraWNrIGluIGFueXRpbWUgdG8g
ZnJlZSB0aGUgYWNvbXBfY3R4LT5idWZmZXIuDQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+
ID4NCj4gPiA+ID4gPiA+ID4gPiBJZiBob2xkaW5nIHRoZSBwZXItY3B1IGFjb21wX2N0eCdzIG11
dGV4IGlzbid0IHN1ZmZpY2llbnQgdG8NCj4gcHJldmVudA0KPiA+ID4gdGhlDQo+ID4gPiA+ID4g
PiA+ID4gVUFGLCBJIGFncmVlLCB3ZSBtaWdodCBuZWVkIGEgd2F5IHRvIHByZXZlbnQgdGhlIGFj
b21wX2N0eA0KPiBmcm9tDQo+ID4gPiBiZWluZw0KPiA+ID4gPiA+ID4gPiA+IGRlbGV0ZWQsIGUu
Zy4gd2l0aCByZWZjb3VudHMgYXMgeW91J3ZlIHN1Z2dlc3RlZCwgb3IgdG8gbm90IHVzZQ0KPiB0
aGUNCj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gUmlnaHQsIHJlZmNvdW50IHNvbHV0aW9u
IGZyb20gSm9oYW5uZXMgaXMgdmVyeSBnb29kIElNSE8uDQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+
ID4gPiA+ID4gYWNvbXBfY3R4IGF0IGFsbCBmb3IgdGhlIGNoZWNrLCBpbnN0ZWFkIHVzZSBhIGJv
b2xlYW4uDQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+IEJ1dCB0aGlzIGlzIG5vdCBlbm91
Z2ggdG8ganVzdCBhdm9pZCB1c2luZyBhY29tcF9jdHggZm9yIHRoZSBjaGVjaywNCj4gPiA+ID4g
PiA+ID4gdGhlIHVzYWdlIG9mIGFjb21wX2N0eCBpbnNpZGUgdGhlIG11dGV4IGlzIGFsc28gVUFG
LCBzaW5jZSBjcHUNCj4gb2ZmbGluZQ0KPiA+ID4gPiA+ID4gPiBjYW4ga2ljayBpbiBhbnl0aW1l
IHRvIGZyZWUgdGhlIGFjb21wX2N0eC0+YnVmZmVyLg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+
IEkgc2VlLiBIb3cgd291bGQgdGhlIHJlZmNvdW50cyB3b3JrPyBXb3VsZCB0aGlzIGFkZCBsYXRl
bmN5IHRvDQo+IHpzd2FwDQo+ID4gPiA+ID4gPiBvcHM/IEluIGxvdyBtZW1vcnkgc2l0dWF0aW9u
cywgY291bGQgdGhlIGNwdSBvZmZsaW5pbmcgY29kZSBvdmVyLXJpZGUNCj4gPiA+ID4gPiA+IHRo
ZSByZWZjb3VudHM/DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBJIHRoaW5rIHdoYXQgSm9oYW5uZXMg
bWVhbnQgaXMgdGhhdCB0aGUgenN3YXAgY29tcHJlc3MvZGVjb21wcmVzcw0KPiA+ID4gPiA+IHBh
dGhzIGdyYWIgYSByZWYgb24gdGhlIGFjb21wX2N0eCBiZWZvcmUgdXNpbmcgaXQsIGFuZCB0aGUg
Q1BVDQo+ID4gPiA+ID4gb2ZmbGluaW5nIGNvZGUgb25seSBkcm9wcyB0aGUgaW5pdGlhbCByZWYs
IGFuZCBkb2VzIG5vdCBmcmVlIHRoZQ0KPiA+ID4gPiA+IGJ1ZmZlciBkaXJlY3RseS4gVGhlIGJ1
ZmZlciBpcyBvbmx5IGZyZWVkIHdoZW4gdGhlIHJlZiBkcm9wcyB0byB6ZXJvLg0KPiA+ID4gPiA+
DQo+ID4gPiA+ID4gSSBhbSBub3QgZmFtaWxpYXIgd2l0aCBDUFUgaG90cGx1Zywgd291bGQgaXQg
YmUgc2ltcGxlciBpZiB3ZSBoYXZlIGENCj4gPiA+ID4gPiB3cmFwcGVyIGxpa2UgZ2V0X2Fjb21w
X2N0eCgpIHRoYXQgZGlzYWJsZXMgbWlncmF0aW9uIG9yIGNhbGxzDQo+ID4gPiA+ID4gY3B1c19y
ZWFkX2xvY2soKSBiZWZvcmUgZ3JhYmJpbmcgdGhlIHBlci1DUFUgYWNvbXBfY3R4PyBBIHNpbWls
YXINCj4gPiA+ID4gPiB3cmFwcGVyLCBwdXRfYWNvbXB0X2N0eCgpIHdpbGwgYmUgdXNlZCBhZnRl
ciB3ZSBhcmUgZG9uZSB1c2luZyB0aGUNCj4gPiA+ID4gPiBhY29tcF9jdHguDQo+ID4gPiA+DQo+
ID4gPiA+IFdvdWxkIGl0IGJlIHN1ZmZpY2llbnQgdG8gYWRkIGEgY2hlY2sgZm9yIG11dGV4X2lz
X2xvY2tlZCgpIGluDQo+ID4gPiA+IHpzd2FwX2NwdV9jb21wX2RlYWQoKSBhbmQgaWYgdGhpcyBy
ZXR1cm5zIHRydWUsIHRvIGV4aXQgd2l0aG91dA0KPiBkZWxldGluZw0KPiA+ID4gPiB0aGUgYWNv
bXA/DQo+ID4gPg0KPiA+ID4gSSBkb24ndCB0aGluayB0aGlzIHdvcmtzLiBGaXJzdCBvZiBhbGws
IGl0J3MgcmFjeS4gSXQncyBwb3NzaWJsZSB0aGUNCj4gPiA+IG11dGV4IGdldHMgbG9ja2VkIGFm
dGVyIHdlIGNoZWNrIG11dGV4X2lzX2xvY2tlZCgpIGJ1dCBiZWZvcmUgd2UNCj4gPiA+IGRlbGV0
ZSB0aGUgYWNvbXBfY3R4LiBBbHNvLCBpZiB3ZSBmaW5kIHRoYXQgdGhlIG11dGV4IGlzIGxvY2tl
ZCwgdGhlbg0KPiA+ID4gd2UgZG8gbm90aGluZyBhbmQgZXNzZW50aWFsbHkgbGVhayB0aGUgbWVt
b3J5Lg0KPiA+DQo+ID4gWWVzLCB0aGlzIHdvdWxkIGFzc3VtZSB0aGUgY3B1IG9mZmxpbmluZyBj
b2RlIHJldHJpZXMgYXQgc29tZSBpbnRlcnZhbCwNCj4gPiB3aGljaCBjb3VsZCBwcmV2ZW50IHRo
ZSBtZW1vcnkgbGVhay4NCj4gDQo+IEkgYW0gbm90IHN1cmUgYWJvdXQgdGhhdCwgYnV0IGV2ZW4g
c28sIGl0IHdvdWxkbid0IGhhbmRsZSB0aGUgZmlyc3QNCj4gc2NlbmFyaW8gd2hlcmUgdGhlIG11
dGV4IGdldHMgbG9ja2VkIGFmdGVyIHdlIGNoZWNrIG11dGV4X2lzX2xvY2tlZCgpLg0KPiANCj4g
Pg0KPiA+ID4NCj4gPiA+IFNlY29uZCwgYW5kIHByb2JhYmx5IG1vcmUgaW1wb3J0YW50LCB0aGlz
IG9ubHkgY2hlY2tzIGlmIGFueW9uZSBpcw0KPiA+ID4gY3VycmVudGx5IGhvbGRpbmcgdGhlIG11
dGV4LiBXaGF0IGFib3V0IHRhc2tzIHRoYXQgbWF5IGJlIHNsZWVwaW5nDQo+ID4gPiB3YWl0aW5n
IGZvciB0aGUgbXV0ZXggdG8gYmUgdW5sb2NrZWQ/IFRoZSBtdXRleCB3aWxsIGJlIGRlbGV0ZWQg
ZnJvbQ0KPiA+ID4gdW5kZXIgdGhlbSBhcyB3ZWxsLg0KPiA+DQo+ID4gV291bGRuJ3QgdGhpcyBh
bmQgdGhlIHJhY2UgZGVzY3JpYmVkIGFib3ZlLCBhbHNvIGJlIGlzc3VlcyBmb3IgdGhlDQo+ID4g
cmVmY291bnQgYmFzZWQgYXBwcm9hY2g/DQo+IA0KPiBJIGRvbid0IHRoaW5rIHNvLCBhdCBsZWFz
dCBpZiBpbXBsZW1lbnRlZCBjb3JyZWN0bHkuIFRoZXJlIGFyZSBhIGxvdA0KPiBvZiBleGFtcGxl
cyBhcm91bmQgdGhlIGtlcm5lbCB0aGF0IHVzZSBSQ1UgKyByZWZjb3VudHMgZm9yIHN1Y2ggdXNl
DQo+IGNhc2VzLiBJIHRoaW5rIHRoZXJlIGFyZSBhbHNvIHNvbWUgZXhhbXBsZXMgaW4ga2VybmVs
IGRvY3MuDQo+IA0KPiBUaGF0IGJlaW5nIHNhaWQsIEkgYW0gd29uZGVyaW5nIGlmIHdlIGNhbiBn
ZXQgYXdheSB3aXRoIHNvbWV0aGluZw0KPiBzaW1wbGVyIGxpa2UgaG9sZGluZyB0aGUgY3B1cyBy
ZWFkIGxvY2sgb3IgZGlzYWJsaW5nIG1pZ3JhdGlvbiBhcyBJDQo+IHN1Z2dlc3RlZCBlYXJsaWVy
LCBidXQgSSBhbSBub3QgcXVpdGUgc3VyZS4NCg0KQW5vdGhlciBpZGVhIHRvIGNvbnNpZGVyIGlz
IGhvdyB6c21hbGxvYyBhdm9pZHMgdGhpcyBpc3N1ZSB0aHJvdWdoDQppdHMgdXNlIG9mIHRoZSBs
b2NhbF9sb2NrKCkgb24gdGhlIHBlci1jcHUgbWFwcGluZyBhcmVhLiBUaGlzIGRpc2FibGVzDQpw
cmVlbXB0aW9uIGZyb20genNfbWFwX29iamVjdCgpIHRocm91Z2ggenNfdW5tYXBfb2JqZWN0KCku
DQpXb3VsZCBjaGFuZ2luZyB0aGUgYWNvbXBfY3R4J3MgbXV0ZXggdG8gYSBsb2NhbF9sb2NrIHNv
bHZlIHRoZQ0KcHJvYmxlbT8NCg0KPiANCj4gPg0KPiA+IEFsc28sIEkgYW0gd29uZGVyaW5nIGlm
IHRoZSBtdXRleCBkZXNpZ24gYWxyZWFkeSBoYW5kbGVzIGNhc2VzIHdoZXJlDQo+ID4gdGFza3Mg
YXJlIHNsZWVwaW5nLCB3YWl0aW5nIGZvciBhIG11dGV4IHRoYXQgZGlzYXBwZWFycz8NCj4gDQo+
IEkgZG9uJ3QgYmVsaWV2ZSBzby4gSXQgZG9lc24ndCBtYWtlIHNlbnNlIGZvciBzb21lb25lIHRv
IGZyZWUgYSBtdXRleA0KPiB3aGlsZSBzb21lb25lIGlzIHdhaXRpbmcgZm9yIGl0LiBIb3cgd291
bGQgdGhlIHdhaXRlciBrbm93IGlmIHRoZQ0KPiBtZW1vcnkgYmFja2luZyB0aGUgbXV0ZXggd2Fz
IGZyZWVkPw0KDQpUaGFua3MgWW9zcnksIGFsbCBnb29kIHBvaW50cy4gVGhlcmUgd291bGQgbmVl
ZCB0byBiZSBzb21lIHNvcnQgb2YNCmFyYml0ZXIgKGZvciBlLmcuLCB0aGUgY3B1IG9mZmxpbmlu
ZyBjb2RlKSB0aGF0IHdvdWxkIHJlc2NoZWR1bGUgdGFza3MNCnJ1bm5pbmcgb24gYSBjcHUgYmVm
b3JlIHNodXR0aW5nIGl0IGRvd24sIHdoaWNoIGNvdWxkIGFkZHJlc3MNCnRoaXMgc3BlY2lmaWMg
aXNzdWUuIEkgd2FzIHRoaW5raW5nIHRoZXNlIGFyZSBub3QgcHJvYmxlbXMgdW5pcXVlIHRvDQp6
c3dhcCdzIHBlci1jcHUgYWNvbXBfY3R4LT5tdXRleCB3cnQgdGhlIG9mZmxpbmluZz8NCg0KVGhh
bmtzLA0KS2FuY2hhbmENCg0KDQo=

