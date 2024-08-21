Return-Path: <linux-kernel+bounces-296070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E7D95A52C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 21:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 147AC1C21581
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 19:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF50160887;
	Wed, 21 Aug 2024 19:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YgTRk9b8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71A9A31
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 19:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724267775; cv=fail; b=IM8zXH5mEcfDoQIyUCfRn0xEv0bLYXZbqbzb5zGoGR9+WfwV8wA5E1Hd6x2h8c1HA+5lQ3dc/hstjWuMWIWmCkGkAo+g9LeXCrP3IdHSW+5rO/12gpPg3IUgG6wKi3CC0QkIXPzBDK76heVM9xAMZy9O2Pwyxag9sbQq28sZGLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724267775; c=relaxed/simple;
	bh=MBi4dhSD32T/qxaXDmLNTlS0K1fObmV2iFquI0/+At0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e7QjbIZ5wLFgvEmQ9BCf0S6cBIOXfERVSabWv1lldUOAJaiCzZJN3jqv2M1AQe1PsopeOEnTbJ5ZXy3AWdoSbDxnSoxUuyKCKeogjkPf+/ugj2U3g7VNNSYXFwpT8UWisb6EnEWKe14ksepV3NXyZxpDL+gv4m5kSaQiLUgT6Ag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YgTRk9b8; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724267774; x=1755803774;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MBi4dhSD32T/qxaXDmLNTlS0K1fObmV2iFquI0/+At0=;
  b=YgTRk9b8so36rsciVHLnZojWPaGVLa5yz/Md8ZW+IVz9YOBnPFclSQgO
   9Q1Sb5yeDzFujaVklML/71ubbS8nvl7EtMVjM6fOtI78KIvhRvz7MRrO0
   EiPs30VUgIM64yn5pBznUL2BoRFNKnhk1nRlDHYouED33CcRzd7DMsEtD
   N/nMY5z0WtTqQ3xuzjyEMcCtlp2y5jO1ZE7WGL7a0wBCEtpyLZIDPSCwW
   HNUKN8tu30bHN3yd3PmFR5fMiDomC079MeA0XhI8IQMFWSOgCSJzWlWCt
   ijBGGRq3aXik3FEjgFy17vWLpWAEu4EsnZqQpyPzOeAqHoz/5Dgh2Jzxq
   A==;
X-CSE-ConnectionGUID: I6yWyPAsSoGTk6R14shKKg==
X-CSE-MsgGUID: V3F4rw+HTkCpuXQpbotg4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="22785035"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="22785035"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 12:16:13 -0700
X-CSE-ConnectionGUID: K/2Q6yoxT+SXxyxdQ1w13A==
X-CSE-MsgGUID: HmndafihRRSxk2LSAoGxrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="61934111"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Aug 2024 12:16:13 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 21 Aug 2024 12:16:12 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 21 Aug 2024 12:16:12 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 21 Aug 2024 12:16:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JIcDXuUqyTpr6OJwkNCQ4O78KjUWmWWq2vyIJj4qa64bHDndypSmG+F87tWyPDmHova2Q2NmrpV7zG8eME+45IFFpu9/vcqrxCbWNJKkipGFKARZjXxOgTKafo5xrwmcQTRXfYKSP0TUN6jgdYTUK5yJaryMQBsvF2bEWXoPctzSNqSgMyy6O7Bn0o7iqGGaw5tH2SXgQTILAPtW9KF5t6S37gDNvJCURhU2qrS48iXERz+B+B1v5sL95aTbAl0NlldWL5e7Lu9aOFvVJxnxYPrV2GLZPAo6W6BP5ca3QGN/gEm/hkuAnj54rzVy5hoM06X4M/Fso2r0Ju/aBfwKaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ll+saQYtaIrCBEYG3gDS62Cz+sPtUhYH2HbG+2QuZ9Y=;
 b=EkvR/VSB4NuVfbAhOniuV3gU5f+HjmZoCTSIayBudmMr+30AFb+aVaPnxesxSHtNqGRP8/4pJuHCC67QFIA+dNr/mIvXEXjK7ExNpvO0ynfK5WsvUxbojC5ZLXQzVT/Z/4WpZOcjcs0r7rkWMWuI2BKoRMVOV0ya25LyPn+KoqZqAroeCqM66ZtTfkJGjV2+A6GFWNUa9+2Tfqhkyd1+kIyiQBYod3Q4Ea/zcYrd5kv6y+BsHpNfHjtxJwpMRokD3JPI1PzJ8bswbJntFSqwuxWieCmJIR0rCLzdaUGhsURGA29N0Galm1t+1FilzwRb4x0TQjtJwDNPTkNHKLGZ1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by IA1PR11MB6196.namprd11.prod.outlook.com (2603:10b6:208:3e8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.28; Wed, 21 Aug
 2024 19:16:09 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%5]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 19:16:09 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Michal Hocko <mhocko@suse.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "yosryahmed@google.com" <yosryahmed@google.com>,
	"nphamcs@gmail.com" <nphamcs@gmail.com>, "ryan.roberts@arm.com"
	<ryan.roberts@arm.com>, "Huang, Ying" <ying.huang@intel.com>,
	"21cnbao@gmail.com" <21cnbao@gmail.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "Zou, Nanhai" <nanhai.zou@intel.com>, "Feghali,
 Wajdi K" <wajdi.k.feghali@intel.com>, "Gopal, Vinodh"
	<vinodh.gopal@intel.com>, "Sridhar, Kanchana P"
	<kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v1] mm: Defines obj_cgroup_get() if CONFIG_MEMCG is not
 defined.
Thread-Topic: [PATCH v1] mm: Defines obj_cgroup_get() if CONFIG_MEMCG is not
 defined.
Thread-Index: AQHa8zownmBKtHWwPk69pMRSa2JXJ7Ix0leAgABDAqA=
Date: Wed, 21 Aug 2024 19:16:09 +0000
Message-ID: <SJ0PR11MB5678054C737A0588AD87106AC98E2@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20240820195005.5941-1-kanchana.p.sridhar@intel.com>
 <ZsYDoQ7NybCcXADx@tiehlicka>
In-Reply-To: <ZsYDoQ7NybCcXADx@tiehlicka>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|IA1PR11MB6196:EE_
x-ms-office365-filtering-correlation-id: 9d9fc3d4-e6cc-4d93-8d1c-08dcc215b6d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?notwPQpFdErQo2oAOxcIQp5tjBpMmpOWG2dyrYWY1GWuHGPnk4peMMzRIAj2?=
 =?us-ascii?Q?DiyGS47yQJoU4HeqlzOgZvSb+xtUZo4XM2ORsrj9BNNlg/y9cLFaePI2Aatl?=
 =?us-ascii?Q?FAsP3BWptwDAZ4R3YWoTXWMw5OjonwPnjIxKNFyXNOArb/9noKuEIiq/FU+A?=
 =?us-ascii?Q?z+0djLq/Pp+3pwGKAyW4rMotSU3di3J695deJyMsU6v93qYz7QLKj1aF9TC/?=
 =?us-ascii?Q?509MR3heGb0wv2XuqE07vKb4oo0n50tgXaiewKWK2duAkjFy6twzZVFXvp0e?=
 =?us-ascii?Q?YpguH88ZbuzOzR8FZtjKv05vBT0GzsPtWKNBFfBp39+xauY+2kjYs+13qpHI?=
 =?us-ascii?Q?X8YwM7bRZ1XsCn9E/3vKIvDDG3T4jWTIgPpumtRi332bpNdE4RPEha1zmYlW?=
 =?us-ascii?Q?ou6fEsIoUQUNAxK0N/W5dulGzzQ/ffDRLj/QDB1bee0S9cSAHC+7Gg5ICWWU?=
 =?us-ascii?Q?CG4W9qzpD6J+VVCQs/WOGvqxMGFi4zlXNaw2xtU0TIOfAm1zhOnWrAdY7MiI?=
 =?us-ascii?Q?uvxz05EiSwvnOPbs8hL7A3eqeMcy44yKAdQSAxa+2flM8rELp6aDGvBoLzdq?=
 =?us-ascii?Q?l8DhQZfMbN4TdsdaUrqzrggE508KcraLpAWo7jVtCpSSaX3iKbV5ptdV0oiA?=
 =?us-ascii?Q?h6KabUhiF2kWMYv9XynlYrQ732YcfIAPbzfIeLcxkqjtI4qUmI/rHjFyOIQP?=
 =?us-ascii?Q?SvY3ObH0FJ1J4scmy7MdhUHNbb936xP+zYiFIk6OD7OBy2ii0GeyPe+1mou1?=
 =?us-ascii?Q?D2ZLBCAn/V+XnlOInA7UFvNB0EKJpjAbdPdhoURoZgzKeDtBeFAqUUpm7oVo?=
 =?us-ascii?Q?ueusSTbiU7czUtadZFqy206SMOAdKFtzTeGuNVh4QDMuIKTM91T6wuV5BPln?=
 =?us-ascii?Q?jdWb/2oBjh1i+e72QCfV7DTc0KJ4jQDCf1XT42Dh/7I1Bwrj/PkYYGplT4ZO?=
 =?us-ascii?Q?51QMpNsPyVQKvvyYwHpdvJ0OwR7ElpNo5FQfH0gnGFhlrWrDxKH7JPzPpRXA?=
 =?us-ascii?Q?nsKUlJM6Kw8TaErX8vIbLg1GnRWo9ljZiTHzmjfO1qvMRRtLIKAhpyBBzQqh?=
 =?us-ascii?Q?ROeidgOMa3Uub3cg5ky+3UbA0/KZ5YGvSKWs5tzaSoNaMYhfH3gs5UJIoRSJ?=
 =?us-ascii?Q?+m1F3jgvr/iV7AoITi007RP8fHxn/ibPX+ArjZrSg7zykAKhM6uyCPwG8IBu?=
 =?us-ascii?Q?W0LeTghxYKfayloso803C1G6h2d2frNix+SntgDXVsU6qf4Fz7dWC0TRtXOy?=
 =?us-ascii?Q?5RWeWQycXBf1gxGc/Ix4gwDrJXH6xEcPL7MHnOlwreoPLQA/Aq3gIvaqgucA?=
 =?us-ascii?Q?xHcvVNFfkBf3mwQEGric23UFAvsCm6ffA+OirhoC9Mtu9B9sKurohH+G3Wc+?=
 =?us-ascii?Q?CGtUvyg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/+zkETvFuxsY2BZGJ4AWm6PGkFDkkCP8l9JkAUiRKNf0Mni0kvY80ftwnoKF?=
 =?us-ascii?Q?sxSmEl8k1RHPxlRD01ulM3az148r2xQEhU+6lZ0mfxCG0o1OYx4xaQG5b/j8?=
 =?us-ascii?Q?LjidO7qwJ1RIDRELf/FYQGAR0Kawi6I8tSi5AL2LHby7hLEAzvPhI5FVsPh+?=
 =?us-ascii?Q?W5p6sIz9O9wX6c0bzIEwTZoDWaM3mN9lxuKp7MTehMx5xMHlROpMmuO1ZOtI?=
 =?us-ascii?Q?ukf6XCLXN45Yt3uG9nY3QZ6T7MLOuuDeFqFEJTHViMFldlQW0o5yZZ4DNxg0?=
 =?us-ascii?Q?kndWg2Jf8WKbH9P+nootpPt5TM7R7gV7m40Fh9qMTTzywXQocR0py4ICnXpM?=
 =?us-ascii?Q?sTexxvPq9EYj4pX7WbybL9zPejpBm0Wry82/vbBvLxdv6OO9ljC2gZvommvp?=
 =?us-ascii?Q?MR/5mQGSFqa6LPu6Ern3jn3yWUAISOOHw46q5cWXqKDuc8BB+GrBVfKdvj0y?=
 =?us-ascii?Q?PO1xitCo2Qb8OpADWXTICQzLCVh11NQNrRLMDafgc9zQ9C2OEhCIo59FlLfU?=
 =?us-ascii?Q?zz+SyYWMjQ/Qwau6Zmd+JMS7ES4uwKAxfjiYZ95VDEt0IGEaYlLL4ZJ9BbPF?=
 =?us-ascii?Q?mwUfH3ywg4XenLXqbomiEva+CkucXMsXmV+cNY7rjjVBoXmwmCi0Cm8rtZRt?=
 =?us-ascii?Q?esriuCyc5TcSErs6zKn/eN+WYqYAWPkICOhqo5VcIw3Cij2oVzs+g5qfsQwG?=
 =?us-ascii?Q?/RPohb1Z2Dkx0trNsBkafean7wfeHnJegXeJQvorwlgNEcXmEWUsAbBfm0tP?=
 =?us-ascii?Q?gVC9CT6i2jR0Ha4EIQagRrMWGAcG844qJNaU8kyNjz/BTV4Uwo+Fbdwe1MAC?=
 =?us-ascii?Q?FSv9qqbZ9McB0xcS1il6OGqRChb7HQJUd/ZpqX3EuwjkJ28u4x1NNwPDIHAx?=
 =?us-ascii?Q?VKhtTP6f+LD3p1NaJWejzi7smR8xhUeHtJdmU4MVi52dOJoWPvCcvORQ/G0l?=
 =?us-ascii?Q?D4OfWHBVI8nelcwt246TwklsCj1BTEWS+uliRjU1qUnxbwt3qT99FfaurFXX?=
 =?us-ascii?Q?cdelXNrYuNe2K3Cu6sK4VkXFNACUZeP94lMrq6P5G8NAtsmDHqCgs8+cSX58?=
 =?us-ascii?Q?0YJsCySF357FTBmXYECu9SmtTdQCIhav8vdkyPhQFpmtNUWwjxy+8EqUvUy/?=
 =?us-ascii?Q?lNE3JtR2uYCHI5p/YsBjwn0FM1m/oBNZOvxS+Ix/70OKPnRNRMAMKEP1ddY7?=
 =?us-ascii?Q?Eae9Bdc7P7WptIKHJG7NuRUr7BfmrrAtW5m07cJAG6PdibRa/nSMDL73cCo2?=
 =?us-ascii?Q?rSJ3wRvJrw8QiE2Drjk0PNEQ6rhk0DA31mMEDYVRoxRgSfdnSn2kzRQybyjH?=
 =?us-ascii?Q?8g7B5+FpxNlICEChInqGRUHNq4Oh1XwEvN1Kw76DP9Pvv98j1MPjGnxyYVQ2?=
 =?us-ascii?Q?waAft0WebQCIAcUr9w/5mXSAXTzbVYq+l8QDCZyFpNEcukgQy/gFSsBKOo+H?=
 =?us-ascii?Q?NrtBPkp7zIh71NVqRVE5qfMd54bbO/umaOdgjy9SC8Xpv1NB1t9vEXjgyFzf?=
 =?us-ascii?Q?UGuz54gQTBwIIT0sg/dtytN2UG7Sm8CKAuJVTLFPF4oMrM/Kuib+zNFGftq7?=
 =?us-ascii?Q?mSFRGBNMwJq/sL7fiS2e6/3fLOU2JtSFWJ+wbfGraDBthZIrLnTA696ltlAY?=
 =?us-ascii?Q?IA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5678.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d9fc3d4-e6cc-4d93-8d1c-08dcc215b6d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2024 19:16:09.7196
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t3GHgAy7DtK3wAc2RB8ZVuVXhhtyEIA73z7UBEPA91salNGJN+uvZ/fkzZ/JW4QStpT1kh6QndecuJV3LvrYWp5TvMGYWLMveH+VGXxrL60=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6196
X-OriginatorOrg: intel.com

Hi Michal,

> -----Original Message-----
> From: Michal Hocko <mhocko@suse.com>
> Sent: Wednesday, August 21, 2024 8:11 AM
> To: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>
> Cc: linux-kernel@vger.kernel.org; linux-mm@kvack.org;
> hannes@cmpxchg.org; yosryahmed@google.com; nphamcs@gmail.com;
> ryan.roberts@arm.com; Huang, Ying <ying.huang@intel.com>;
> 21cnbao@gmail.com; akpm@linux-foundation.org; Zou, Nanhai
> <nanhai.zou@intel.com>; Feghali, Wajdi K <wajdi.k.feghali@intel.com>;
> Gopal, Vinodh <vinodh.gopal@intel.com>
> Subject: Re: [PATCH v1] mm: Defines obj_cgroup_get() if CONFIG_MEMCG is
> not defined.
>=20
> On Tue 20-08-24 12:50:05, Kanchana P Sridhar wrote:
> > This resolves an issue with obj_cgroup_get() not being defined
> > if CONFIG_MEMCG is not defined.
>=20
> Could you paste the compilation error and which tree this is based on?

Sure, this link contains the compilation error reported by the kernel test =
robot:

https://lore.kernel.org/oe-kbuild-all/202408202320.trSaY2o4-lkp@intel.com/

Error:
kernel test robot noticed the following build errors:

[auto build test ERROR on 8c0b4f7b65fd1ca7af01267f491e815a40d77444]

url:    https://github.com/intel-lab-lkp/linux/commits/Kanchana-P-Sridhar/m=
m-zswap-zswap_is_folio_same_filled-takes-an-index-in-the-folio/20240819-101=
738
base:   8c0b4f7b65fd1ca7af01267f491e815a40d77444
patch link:    https://lore.kernel.org/r/20240819021621.29125-3-kanchana.p.=
sridhar%40intel.com
patch subject: [PATCH v4 2/4] mm: zswap: zswap_store() extended to handle m=
THP folios.
config: sparc-randconfig-002-20240820 (https://download.01.org/0day-ci/arch=
ive/20240820/202408202320.trSaY2o4-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 14.1.0
reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archive=
/20240820/202408202320.trSaY2o4-lkp@intel.com/reproduce)

All errors (new ones prefixed by >>):

   mm/zswap.c: In function 'zswap_store_page':
>> mm/zswap.c:1534:17: error: implicit declaration of function 'obj_cgroup_=
get'; did you mean 'obj_cgroup_put'? [-Wimplicit-function-declaration]
    1534 |                 obj_cgroup_get(objcg);
         |                 ^~~~~~~~~~~~~~
         |                 obj_cgroup_put

My patch fixing the error is based on the mm-unstable branch in this git tr=
ee:

https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/

Please let me know if you need any other info.

Thanks,
Kanchana

>=20
> > This causes build errors if
> > obj_cgroup_get() is called from code that is agnostic of CONFIG_MEMCG.
> >
> > The patch resolves this.
> >
> > Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
> > ---
> >  include/linux/memcontrol.h | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index fe05fdb92779..f693d254ab2a 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -1281,6 +1281,10 @@ struct mem_cgroup
> *mem_cgroup_from_css(struct cgroup_subsys_state *css)
> >  	return NULL;
> >  }
> >
> > +static inline void obj_cgroup_get(struct obj_cgroup *objcg)
> > +{
> > +}
> > +
> >  static inline void obj_cgroup_put(struct obj_cgroup *objcg)
> >  {
> >  }
> >
> > base-commit: 7d0b0d4b77b368b2111fc8b4449e33dfb3c34087
> > --
> > 2.27.0
> >
>=20
> --
> Michal Hocko
> SUSE Labs

