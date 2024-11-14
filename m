Return-Path: <linux-kernel+bounces-408759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0B59C833A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 07:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A8E22835D9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 06:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7597D1E9066;
	Thu, 14 Nov 2024 06:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M1JehmVo"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129C71E25F7
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 06:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731566237; cv=fail; b=U6N4nWOKw9UtIz/CdDbbHsxH4dU8ZdU/E97MfaanQHsHymFm5Xtq7ldzWi90f1+3hh9+hXjqQX8t6sJklUAVbrGxZnoCI1kVYwW/D1vj868iUbmq6UbgNRzIxFYAUXPtvJl2wdKEO7ieUFt+V5LP9un4EOYyumLPqj8ZcYtYEZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731566237; c=relaxed/simple;
	bh=4XY/GPO89TFFzYxLMoRWhV0TNC0mfkWbdVAPN5/78w8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Dpy9hlNqWi/XM7RRdteNeSpj/NlxkIkhGKAXAzgwIGIaOe/YJIyyKOIcrTWxGaKM/eQSKmCFYAzWInaavo8huKQ0o+A9FB3zdjws1PYb3BXV+typ2TjZAyMEmj4uRTFaKhwJ+Z7PsBizrFgusRA4tn9rorDcO6Ylg27IlfAiGgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M1JehmVo; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731566235; x=1763102235;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4XY/GPO89TFFzYxLMoRWhV0TNC0mfkWbdVAPN5/78w8=;
  b=M1JehmVo08WbISG3U+x1RTzNVBW4digbMqB/jLYU1B9GiS/da5FQc1KY
   JWInDhWn3HRsfB5DbHwmFrlFuvEQ7bSohrVyscv8ke6P7ooL9ygBFUeon
   UZJ7EgC85fuaIs8vhYAWhE1j1j3MbXryex7P5IvZTHCK6ukAUu3THjx9M
   haD8IiILqGpD17v8rTb7q6pA7/lwhX/XkRSS4YZpCDwRUxw1lvRiqGrZf
   5qhOwzCJJT/A0GXIzBgEdu3BzjoPG7YrVR0l695s6hoohJMtELTCDqOWa
   lws5T8DYo2CiIHfap9vJj/2nmutwPfxTRxhFBmbLqBxLs9ef7LZxmM89P
   A==;
X-CSE-ConnectionGUID: ZyMQDDTLR3y/2vjI5ZG/Lg==
X-CSE-MsgGUID: u24VcRNzT7+w2pVhUYNsHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11255"; a="31370091"
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="31370091"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 22:37:13 -0800
X-CSE-ConnectionGUID: WwdDsIxqTwudlqyYs8Y/vw==
X-CSE-MsgGUID: sHhnbKevThCBeR6hL/WOQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="92566687"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Nov 2024 22:37:13 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 13 Nov 2024 22:37:13 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 13 Nov 2024 22:37:13 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.49) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 13 Nov 2024 22:37:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HY1ny7kqWmhdQq4yrcQDGC6sqFryobzRbtGHioL5ogTmGlVILcrTdjrcECo6Rb9u7hLS0dV/03JA+aLpP/P+CM9AlPa2BWHM4mxE3PIJKS4ikWi8mERUIdNksImp6l2WWav5n2zN5hRA31NomBQRf/cMxTzt8LP5aT8wxqtdbRtEw2MJeFJ8kX9xom2F62u0ObRv+0pBYFP2QBWeZcS6aF/qcAScIySY9vs1LbRqwfaSffceseI23A5+Fzf4moeFik35gNu9ZAWE780a3jod5hZBTC4H4njITDgLyN/w32stkN22VzEOPPphWD812tT2tfrdRVFbXKU8CT3ValE6Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4XY/GPO89TFFzYxLMoRWhV0TNC0mfkWbdVAPN5/78w8=;
 b=lvdPXsBdt067ovZz3+EFkbqUD5sQlBODwrKxfggNOo6gr9d/E+jC458G+qrghesBLmsgBsWaHyN4spdIqkTTaY715CZLocRwW5jRCBQCJ9o8LxfOFQ0iJB1jxz0pKq5GyGcLBrSC7zHz8nrc/8kIWvQX3D0AUNgbmHAOy95YZ8fBj2waNpspAzjlzDSzysprefW5RF+krlsbd31cJp9IwW0ZRBWg4+24vRF87meHrRDP/V/K3mZHcbn+Rk4nN3NaboblDqgmSK8IIMhwtwcuZzHMi3Ik0egGQSxsFwR/8vqBv4NoJGxSVPIUnzv0+B1TmIrZzBBSrBmFUBkDyGjO+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by DS0PR11MB6493.namprd11.prod.outlook.com (2603:10b6:8:c3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Thu, 14 Nov
 2024 06:37:10 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.8158.013; Thu, 14 Nov 2024
 06:37:09 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Johannes Weiner <hannes@cmpxchg.org>
CC: Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosryahmed@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "chengming.zhou@linux.dev"
	<chengming.zhou@linux.dev>, "usamaarif642@gmail.com"
	<usamaarif642@gmail.com>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"Huang, Ying" <ying.huang@intel.com>, "21cnbao@gmail.com"
	<21cnbao@gmail.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"Feghali, Wajdi K" <wajdi.k.feghali@intel.com>, "Gopal, Vinodh"
	<vinodh.gopal@intel.com>, "Sridhar, Kanchana P"
	<kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v1] mm: zswap: Fix a potential memory leak in
 zswap_decompress().
Thread-Topic: [PATCH v1] mm: zswap: Fix a potential memory leak in
 zswap_decompress().
Thread-Index: AQHbNYxgo97ShYNp0k+eAlG8E2BdYbK0sGWAgAAC9UCAAAo2gIAAydcggAAz64CAAATjwIAALQAAgAAWEyCAADkJgIAAFDJA
Date: Thu, 14 Nov 2024 06:37:09 +0000
Message-ID: <SJ0PR11MB56780DD2A8EB343627FE94FCC95B2@SJ0PR11MB5678.namprd11.prod.outlook.com>
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
In-Reply-To: <20241114051149.GC1564047@cmpxchg.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|DS0PR11MB6493:EE_
x-ms-office365-filtering-correlation-id: 87743fd7-43da-4efd-4326-08dd0476c3c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?znYfHNIoQugQfFFvng3CR8tRPNO+zVx+VgcYQBW2gP8kI1J/df7Q+ZEzDx46?=
 =?us-ascii?Q?8T/uTDy2NUQi5GbxFGj3MMGrtUDojUXC4GCHPUtOr12k1nWU4Fvy+qml0uJu?=
 =?us-ascii?Q?K9pOoCY4Gz5n7RrZ9JZ7htqAQB/VPzyLszC8LOxLDbGH26tDZwcPKxgN4mm/?=
 =?us-ascii?Q?PAHvfhbJNhaiSC1Fwmh86EhAVwoTRiLf/vUBivpQhmqQIrbRFmySsVMPH7r+?=
 =?us-ascii?Q?YJTq5zGD1mn1nuRWqytu1g10i8kk6S3f3KdzE5XqQlD4f+YwWBZi5LWQbwqR?=
 =?us-ascii?Q?5bfuOsEgdGerVPfSGRSh4zBZY/0eoRvMpZF2KfZXt69lMUEYkZcvyRp+/DOy?=
 =?us-ascii?Q?WiD1XZ99khRCOF3bpG3C4pek4IyO/GzyNXpbr1iuJibHR/4pQdkXFX4Tr9ND?=
 =?us-ascii?Q?d3cy+S/JTepebg6yzuMIY36Cmy9nnZf9IiqWTDS5K8hkc3Ogj5OF5KvwY9Hb?=
 =?us-ascii?Q?FElCB7IOxqJmA7KnLv/zDGsttY+bREzeSdLZ4Js9cmhBctsR4fSi3mnveJKU?=
 =?us-ascii?Q?DzTrxSvKpcVFOAZdqKd3aEWq99bgC5aXQbfQ7vskx8iy55AloYOLVeRB4+wj?=
 =?us-ascii?Q?F3MZAmTkEtDAeNj66PgSN6FGuZgZXgoHjuIhoVII3k+jSE+iJAPupp3gRPgL?=
 =?us-ascii?Q?YG1NEEcmuPzYeMHTgm3csdx4440fqLmlaFSMq0VfKtGzscSlHXICpVnNjFcn?=
 =?us-ascii?Q?HkZzOlPWTzNqIMsM7vUaYQDI5KW36bqIAzlFNxSdIwY7i1kDTtwq7dRc/xPx?=
 =?us-ascii?Q?//YYGrSL8oVCcFcNC6BYqP9BKf+Slpcyekv4h7yoUOSAcH//3YBksw3jrtbI?=
 =?us-ascii?Q?wIFrC8kgK5RxdO78lkbYIW1VCYvnL/5Y4wLNCJa0g4/BfF/wUeC8PvdWlZh+?=
 =?us-ascii?Q?ALr9wkxYCDRZRoJOQFwNndamhuoRuNM3pIQshCVqDj+X6hoLRczIN/cbfgUN?=
 =?us-ascii?Q?iCj2EQvX0vyWF7pFwwSQcodJKRjOAXtfK7rnVibjVAvXSQFQGqlGVbMOfVpK?=
 =?us-ascii?Q?p7nWzHmIUGRKh3dPQhMjyD4TfYtn5skPbtBGuFkdvcRGynnOD0aQUxk6Tjno?=
 =?us-ascii?Q?RaewgwQTIoIklTYM9ZRsHn57/uggQOYP3nz32zFYwA69N8sMt1+7CdCssKBz?=
 =?us-ascii?Q?WD7oTt4h8VkrOJd4GzaV+Z0F//XAEquzOmdD6bk95riN7PRdKwuEOZ9b43gl?=
 =?us-ascii?Q?MMp5DNFxakYOdSnuXjd0I3bFI1JXF1174Ej3fLx+6e87zn6b9wTDkQJXBwRV?=
 =?us-ascii?Q?EiFVvYp6lAEEmBo9t3e0AaeAHQcc6o3urnsb6siaetDk6VTRGXTop4ypcq9O?=
 =?us-ascii?Q?TXM657AJGoVIu/cX+Jgf1ImMtk/JTEgZiQ+VtA7VQwVq/y8XXEgvRRIGpmYv?=
 =?us-ascii?Q?F3MY0M8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mKTp3UQrVzX3xwVRpyE9TT4ovVynW9quuonbfEYdYXUQXaXr3aOFSW8TPayC?=
 =?us-ascii?Q?VlKuYt7Kb/+sPoHTT1tPirpsr+s0h5qsgQzEasdCuVt+p3CTge7bLgLJJlpT?=
 =?us-ascii?Q?+wyIHsfe9DNJwLCf2BOtlrtKGK/4U4LwpNwKQ7kAsRgLDkndF0l+gDmtGpuB?=
 =?us-ascii?Q?3AKnqALmd0RNMr/kLoMqE0acYqVkG6yaSowhVp76qDbQpBbxL4M3A4vsK1Dy?=
 =?us-ascii?Q?a47aq/iTwl/Y44+cJX4TMeHGHI/7hvBdjh3PrTu+7CuI0JP/qchJCFtlmeiJ?=
 =?us-ascii?Q?EuZLvA0hW+qM2d/lmjybjUbghLY7EE+N6TmRDIO9IppdyospWRh7ePttIHNo?=
 =?us-ascii?Q?aNBbOhpd7UZGe7OPdNJApYQGonUbZZ7qfBVnx8yAhvAfUmAw40GYF7bUq+i/?=
 =?us-ascii?Q?CIpCmlpDqZSoC6WM3ns5j8kK4HunDFAg53+bb/d04QcIBWz7C/F3H+3q326M?=
 =?us-ascii?Q?8P8pEkPcs885XC9Xa17pDUiuWjcujgPiJbjFRxjXooctueAMB+EUKoK50nqH?=
 =?us-ascii?Q?mfL61JB7GPYzTlV02PtHMIY2frUNjz8Dp8llGHg7vTyEK2hL0oIPxwY8/7Mj?=
 =?us-ascii?Q?WpQKTplCFM7jckr2li2jI4g2WLpSmKuteFhAmdvJmg+yg29xLKcsycWiV633?=
 =?us-ascii?Q?4g3SPqm5tyPoLSD+esYeCi3Olv20n+A0GePji9czB7bWS1wD1StbLuZwch+y?=
 =?us-ascii?Q?ZW+MQdsA55DwwlKjT1SQtOJOoGMU7tvgNA2WxplM6hZFN4wWmEEe1ZAbNuXW?=
 =?us-ascii?Q?JgQh468QlIqRt6OLAp5NOhfH+7fiD94eRpHIabaNKklpXGcmlRZ9zKt+BaeX?=
 =?us-ascii?Q?UgDwS9LpRtLPCul8s8J5Ol8FYXPazUmZEEv3nAXbOX26mcNfCKWm1MYeETyG?=
 =?us-ascii?Q?T/1g1myuBayJmY9wtYZVIGSsjEWFJ5HKPSMPp6gxgsbJ2IWSXaSIDeNyVXKb?=
 =?us-ascii?Q?z6/2qZ9U2OM0MycSYqYxZtaBLBOPc3ZEqzQ29pge0Xg/8RmKEc6xaRj4oOPV?=
 =?us-ascii?Q?c1csp7CpioL0fd4j0obKlappLBhk6P7biTYT6iRa7Sa/qOA+C1lHzo/qFbU8?=
 =?us-ascii?Q?WiBCfijq2POBsPvwG+dhKvdHjwKXlR7mCiE+JWXHHvKswwnd9RZF8ainOzEZ?=
 =?us-ascii?Q?wBvwgEECLVr+QZqbkI9oTEPHutwUrCXCHpeMeTpZOQ3nQOdugFPyvJgVlYwm?=
 =?us-ascii?Q?ZgxwLTGJRN/Eb01tv+G87YXbtcOkcEZ82m1V9HmxT5LAgD/DIW48+OwQhugf?=
 =?us-ascii?Q?E/4ps2mq08Ql55DU3TVBXnA8umRhvtaOAyA9VtXIPLXCPXNz8zJjmjfXEM1T?=
 =?us-ascii?Q?raU1cg6Grw/nBTkgk6FuQjVhRFEymTEMYGhcIGWzU0HbNZlA97GQfG97Y9SY?=
 =?us-ascii?Q?pNK2eKUAGPA3uEZBtYuCEIwfwrctrAZmyTjzG85354NTg+nS7t2x0ED9CdvJ?=
 =?us-ascii?Q?TmCTjjih/xLFgTUxjAdRh4d26NaHC+x+0WZ1ZAKSWAonVjLsi0AkySbhThbN?=
 =?us-ascii?Q?yGDDwYJQ/e5zG5GFmMKQsZamJ9wUE1RjELcfJIDLSSMD3RZHfqInaOllGsqk?=
 =?us-ascii?Q?3jmjJcOFuMNoq8NGotETLASHAYD6F95xx/zqtVxDnZH+lwh4uPc7SRgdbsAV?=
 =?us-ascii?Q?Fw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 87743fd7-43da-4efd-4326-08dd0476c3c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2024 06:37:09.3283
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S6ijqCn53OwI6Bq8Midvpjpb7mCIhLtwPs5oNx7qCBC/kuJ2TeYOeG8RqZJyqcSbgsMIVifU3TZYqQaJYFNYhHm1cdnqxUxqNdJtdX6wIN0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6493
X-OriginatorOrg: intel.com


> -----Original Message-----
> From: Johannes Weiner <hannes@cmpxchg.org>
> Sent: Wednesday, November 13, 2024 9:12 PM
> To: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>
> Cc: Nhat Pham <nphamcs@gmail.com>; Yosry Ahmed
> <yosryahmed@google.com>; linux-kernel@vger.kernel.org; linux-
> mm@kvack.org; chengming.zhou@linux.dev; usamaarif642@gmail.com;
> ryan.roberts@arm.com; Huang, Ying <ying.huang@intel.com>;
> 21cnbao@gmail.com; akpm@linux-foundation.org; Feghali, Wajdi K
> <wajdi.k.feghali@intel.com>; Gopal, Vinodh <vinodh.gopal@intel.com>
> Subject: Re: [PATCH v1] mm: zswap: Fix a potential memory leak in
> zswap_decompress().
>=20
> On Thu, Nov 14, 2024 at 01:56:16AM +0000, Sridhar, Kanchana P wrote:
> > So my question was, can we prevent the migration to a different cpu
> > by relinquishing the mutex lock after this conditional
>=20
> Holding the mutex doesn't prevent preemption/migration.

Sure, however, is this also applicable to holding the mutex of a per-cpu
structure obtained via raw_cpu_ptr()?

Would holding the mutex prevent the acomp_ctx of the cpu prior to
the migration (in the UAF scenario you described) from being deleted?

If holding the per-cpu acomp_ctx's mutex isn't sufficient to prevent the
UAF, I agree, we might need a way to prevent the acomp_ctx from being
deleted, e.g. with refcounts as you've suggested, or to not use the
acomp_ctx at all for the check, instead use a boolean.

Thanks,
Kanchana


