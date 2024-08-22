Return-Path: <linux-kernel+bounces-297985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A264195C00A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 23:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C841D1C21735
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 21:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5261C9ECE;
	Thu, 22 Aug 2024 21:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wc9101mT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990D11D12FA
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 21:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724360451; cv=fail; b=oggX3/pgsPSH+/mQ6DU5htpdQ2NxzfIVvlQ1g0zMdJZmq08klFxuQUGEf2fXBbadr6Q7ck41GoCWuSZBLNhC+KkzhEFWA4ipmFjR3GclzwJojOzkVgHOYrsqjFd++aMZS1P0tdW+9lJSno/E01naoYaDqViYuWbPBhxDLQGNB6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724360451; c=relaxed/simple;
	bh=oyGKdFD9CnWXLBG5Gj48uwmipZkmTR0sbPMNNXukXGU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=liP/C2xUvnKM+n6wdcxZUQs+9p1w9ua0cn2o1Gje4Ovttv4QhygREAvSiLLbUp0cTXuGblv2/4SJdKgu/xuUYJdIuXnQOq2vNvH0GT49d/JGapSgox8tcnm+WbrTIMrUOql+nTwI72rAAB0ICe+XN/uF1Ct0kj/pTbO1B1Hct8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wc9101mT; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724360450; x=1755896450;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oyGKdFD9CnWXLBG5Gj48uwmipZkmTR0sbPMNNXukXGU=;
  b=Wc9101mTT6pAnlJl2bfGcl6b2Go6XM1Y7jTpgyBrVWhOFlHV8jlUB0LX
   8bhRVR5xPFSBZ2MLDIQtzgy4uhWJ3/exlg/KIZZVYyXgJydvD7haoeok4
   t9VpnH/RPQmYCHGAT3lCSqnBeZhSsriCFMKVFo8CTJOTpsGZE7IaPsdkn
   6F/7rKnJA5FOGAeHfcQDlOlzZMNroWmwVZ0Aq6Oa05FlYU72tFGFGml23
   qYmtZX2hUF5K5UyuKBAo6F2OgGI0M0YEUwXP2DYxELXF9IhXie2G9SWPx
   WCSW+fS+OHotzQmvl0YaJOLcUyn6jXXs3ukuxwVypVNlIxAZp8Wuq7FhS
   w==;
X-CSE-ConnectionGUID: gplCDOQRRfGGXnpS2j0iSw==
X-CSE-MsgGUID: TNd5z4GERB+t+/+JyofLWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="40269340"
X-IronPort-AV: E=Sophos;i="6.10,168,1719903600"; 
   d="scan'208";a="40269340"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 14:00:49 -0700
X-CSE-ConnectionGUID: MefaBYBjTqS8DEbvCaK1Og==
X-CSE-MsgGUID: EpcIQQkKQG2ZhFhHZGk07A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,168,1719903600"; 
   d="scan'208";a="62289787"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Aug 2024 14:00:49 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 22 Aug 2024 14:00:48 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 22 Aug 2024 14:00:47 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 22 Aug 2024 14:00:47 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 22 Aug 2024 14:00:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ULRbUBS84+wDrfLkiSwgyPB7p51dQUhPKxOa7ZgK3CFbXBmjfk2Cns7NQoUI0Esfkvug2ODE3Sb3f/iVolNPeORdZNmObcacaExFuGVqw1W6WC1y2at2GzlkGVVckzOHsOMsqnjVDe40Y7+DeAuH8f59XWeSymIrPBjtugmbu0+BjU4Ld+e3DG1SSMoE3f2EvDqZA7n23WXFsOUZd4mvSjtrvaR1u3a2b3B7jvQeHedC1t0i7dBAoDqGltmbznQuRDr7b8pwxtiT6ubgY+huwbGoIgRqXZW+5OunMotkIuFlNBqELe4EGO+/qZ5b62NpyZC+eqCrt9cmjZsHob528Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Bv0CE5pUWxfrC46Xi1n3xd6g4jUPNM07aVx5TeeAB0=;
 b=IBM1a/vlr2JdBeGwDISendMWA4GdIsJE4iqpOOv2c3VicsTKABOp84DyZOvPoB5nck861RVGwHN4HDLnwTfSUm1dkjhSaKRhpnfbu64n+CgBLAXQQHuzOxR3HLolal1iRXfJNbNj6o1HXcO2fSMNoxyK4sBwFah/luQjBIb63iTd7PyiXGjU1Le/Yi45F8Jb2pU9WmF9bWHEbR00MQKoxoPOdRB1EPWdJsWXch4qn2ZXNCsYUrU8tt2WRskBYzXGXs09BMxdhL7mPSQ5+3FdODPk5cQX7NO92mRnCsP//y2GF2DskMjci1DggzL8N09DUIpqqDbTXM35H13PbB1MTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7605.namprd11.prod.outlook.com (2603:10b6:510:277::5)
 by PH8PR11MB6902.namprd11.prod.outlook.com (2603:10b6:510:229::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33; Thu, 22 Aug
 2024 21:00:43 +0000
Received: from PH7PR11MB7605.namprd11.prod.outlook.com
 ([fe80::d720:25db:67bb:6f50]) by PH7PR11MB7605.namprd11.prod.outlook.com
 ([fe80::d720:25db:67bb:6f50%4]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 21:00:43 +0000
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Arnd Bergmann <arnd@arndb.de>, Rohit Agarwal <rohiagar@chromium.org>,
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Lubart,
 Vitaly" <vitaly.lubart@intel.com>, "Usyskin, Alexander"
	<alexander.usyskin@intel.com>
Subject: RE: [RFC] Order 4 allocation failures in the MEI client driver
Thread-Topic: [RFC] Order 4 allocation failures in the MEI client driver
Thread-Index: AQHa7V087DCPK9soEEeGNq7wh9SvYLIumSEAgAKfx4CAAGPmAIAAAN0ggAHra4CAAEfKkA==
Date: Thu, 22 Aug 2024 21:00:43 +0000
Message-ID: <PH7PR11MB7605F68E96E24CEF6C92F8AAE58F2@PH7PR11MB7605.namprd11.prod.outlook.com>
References: <20240813084542.2921300-1-rohiagar@chromium.org>
 <75f758e5-a26f-4f41-8009-288ca2a4d182@app.fastmail.com>
 <4d6f3331-5a9c-46f2-8e27-3484ba6f6eab@chromium.org>
 <25e56199-7af1-4235-8973-cbc351325b8c@app.fastmail.com>
 <PH7PR11MB76050864E8DC9F7389314BF2E58F2@PH7PR11MB7605.namprd11.prod.outlook.com>
 <4a66eea2-c23b-4c34-a5c6-508bf2a6fc47@app.fastmail.com>
In-Reply-To: <4a66eea2-c23b-4c34-a5c6-508bf2a6fc47@app.fastmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7605:EE_|PH8PR11MB6902:EE_
x-ms-office365-filtering-correlation-id: 91b3e8c9-9b98-4781-d74e-08dcc2ed7cd9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?mtXqXOc8sWgW+W0DqtLWgEpt/hGnfwXDAa3qLRmCsj+VYkrrtuur3TiuhhBC?=
 =?us-ascii?Q?c8u8IJgLvIb5tvriJGxlkXGnzsTRpA9PUeGN/dI8SG3vhq875Ta1/pTdH8jo?=
 =?us-ascii?Q?ZKDde5AgKysV7/joeDxfeXfXIC139YXwwkKJbw1hZ5K/LE2TEIz8FhF6NY79?=
 =?us-ascii?Q?uia90VkdGhXzDB4AkwyeAP444WzBOqGDow59TAYTeo4NiVBDLMrUw0V8y7xl?=
 =?us-ascii?Q?aEeeSHlUND0BqRzWdZ/f32d9uhw1adrwX1FtV7geFnyF6yyHkhKgheDAKXzz?=
 =?us-ascii?Q?Bvo9tBJy4/YUMbkxN/6ucF9dXi1J/zLL/MFVFzcySin5vzCQVNdHTXkAk2Pe?=
 =?us-ascii?Q?ukS54l3Bm7MzKEWs84EEYN6sfvi6OYOmkuwRZYl9pgt1v3UNbnOREjU0aPS3?=
 =?us-ascii?Q?7S6meDpp9BOHl3LmslgPVT91A4Bl0qjzhR3ElwujbX6ULUQecRsGFemrT/po?=
 =?us-ascii?Q?31s10bggD8aEXEFPM27SG+bbl9WG7PIwPazsCBu2jt8G57wuc6/liDNe6Pk1?=
 =?us-ascii?Q?PJKAFT1C2hjucl1fHy/vX5aS6zbi87loaP3etL8PzNp9LzHgUKknPlvqBt0n?=
 =?us-ascii?Q?Qq/1l7y1DC4n5l9iJisiPULMUELLCThnrO6aRL3MvTiU7TBV0V+JNOO5rCA8?=
 =?us-ascii?Q?DpMX84nyCAQNy/Z2w1PR+Tg+yv/uiKHL2k1L73jpYO7hMLlUbQrg2U6UhnhA?=
 =?us-ascii?Q?XKjo8GhOU4aorGKHi1H8cuyS9+p+Xpu4L6dC8XDULphWzNjbeG63cYyElEdZ?=
 =?us-ascii?Q?wgdO16BavcktKq1uYvUfflOe7la5l2Q7fV3a2+CAfark3rSjRzBYMHtYCCre?=
 =?us-ascii?Q?8cEfvXtX6a01JaPB/NGx5Ol0n7Jul8opVgnS2yIkB+qVGgdpiYVTwlAVM/6S?=
 =?us-ascii?Q?R/T6e6gOTzyGw7pptzTMXkGNfGiygsaLR86XJxphdZcCH46kSFdShuwuINIH?=
 =?us-ascii?Q?n+KrI/gw6fLS3S5xFRzJCeNhRdVvlKt56O9lVRChmtvWeklP/EBWo1/oyk8S?=
 =?us-ascii?Q?wIkpm2eYricWkUDS5UaaQTq83q+AzMn3DsYPBJNAgtQPp8G3mDv9aE11XY7a?=
 =?us-ascii?Q?i3Q370ZPiLkWEKmnYJCxghfBRkzU0wlwRnGKYFVaozkbExOH0S0wWO42WBhR?=
 =?us-ascii?Q?9LfOdmc6DTDahIl8H0U0npMgFFYFVv8Bc0gyg4uksoRMbDg4LoLnH4lnTbGr?=
 =?us-ascii?Q?W+g2upwmaDsJCjuGuZfkbychgdVF7mlSaOGLkTtGu/SRrkz149KcfC5cH9Jv?=
 =?us-ascii?Q?jJJvN1Gpw8bezC75IORRLbDfHK7XfrlJQc2y+bbtldlQYthx+SWeYFCFM0Ot?=
 =?us-ascii?Q?O+ALf+HIiz0EGnmkC57zgC6+KtU754ah//LBvbG+HsJIGVu0NhRQlTVmeuCe?=
 =?us-ascii?Q?pqobSAY3wZXnu2jOBK0bV60EitIHxcODDQi5Fbdzu0Usj04Ohg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MvSXDyRC46gpw/Pq8pDeiGgA1jLVpaQoI4LiFSQKtkr1i3BHdQN61qHOLbmH?=
 =?us-ascii?Q?RdWeCPVQO3EoDXdtOtBiyWVh1k64+/LIrkdfXzI3dRHf/kt9s9jd22m70c4K?=
 =?us-ascii?Q?2Zhj4YVvalyL4aruxYuTM6bVISYQCLmw7UuvV4jxamNJnSv6RXQcHBtqpseO?=
 =?us-ascii?Q?5gIP40frMYHMxWPNhsdazTzLJydrkA3KcRamL4xIrGIuVxCiG6fNBcgxnN64?=
 =?us-ascii?Q?IQQs/v5qvRsdstaYcWzI4A20/YnDnQPBWZbGjF9X6nuFIHlOXaRAafxtQYlG?=
 =?us-ascii?Q?6ekhrkop/uHv2/fj6C70t6by9kWosMq7vQUZGE6y/ys53qsXZ+ea/OIMmoBk?=
 =?us-ascii?Q?wzM0RVZfRux+7oSQe0HzrIYvYBxqdwn+V3oXS8Wm7RCdfkiN3G+kiqRTXZtD?=
 =?us-ascii?Q?HsIbgZ7z1eUjlYEDIUebrjNoR5rVxk33t8ZGOYkAMldjaq8C+g26oe+ziQ96?=
 =?us-ascii?Q?Tk13iUexuA2Vspro0dMyqAOKA3NYRp/vdCl+6GeDkG8qvCcRf9w5ylkorJ5n?=
 =?us-ascii?Q?CzsEPPaBLN7nYtZ6B1Nidq+VV3Yt3S0Hxjwez9I0RsTg8WukB5s5JKzOs9vY?=
 =?us-ascii?Q?TZ3aML3HA9E81riE+x7T28693DVNVKxC0aQ58hlc46ZQCMUewa5s+5mJTorr?=
 =?us-ascii?Q?FaIThrO7kwswZoJoBytM6WW9JhdaeqiJ2Y8RzosPGir1iAVGNpmAF4mgAzMi?=
 =?us-ascii?Q?pNDukdTg5+jFOLNtBV6bc1tJwUyk9jJ2rb4pzQonAo837mwQ2i+FezU4lny8?=
 =?us-ascii?Q?80cL/6/yofxeXwmEhjnIMVlzrHdgVe75yLcCfvAcQfMv90d86lpUO9lflta1?=
 =?us-ascii?Q?9+C8sLszG+h2rKLFinTs6TVpIUugiaqN6CiU75GB4e7t5BFVLsRZuuYvymHM?=
 =?us-ascii?Q?7JRf9w27c/pLBrLVS7YxYJvpWzirm8t7vEs4KllL0Tu3eegfzJpIaTqLNTKO?=
 =?us-ascii?Q?t5AJiNXV+0k4SjWhvoFyjW4ETcbkkMBN3tRNa5PwaClbqUZRKS3f//WYS/ho?=
 =?us-ascii?Q?lFv1JNlGqee/+c+El8ZGzLpY6oHhwB8+jS7ZVA7jlDhKDo/NamNiXYdBiCdW?=
 =?us-ascii?Q?bf06EPLH6d3qh5MidpnovnoyOY3TePNOADz2zOYJzsfYESoWTpjIs0zhrd/D?=
 =?us-ascii?Q?wkKokm09aHx4zB9BXSGLURtF9DLbA3uhJLaNYPiHz7IINYj1gFla2P1mTKdi?=
 =?us-ascii?Q?dK+mhSuGwlQJSxEP3+k08NqZgD3iAx63mwGSffZJ0ksF9EUGZ6uzvylJVBVR?=
 =?us-ascii?Q?n1sQuQM+GbsI0yTgNJ+7+rahh0DxH8VNZvRugH58WD142/VXnRryYHp0ens4?=
 =?us-ascii?Q?l1jrM41pytzXJMPMBhUHY5rH5lB8JE5U6gcOO2Nom6jKKzobZZSRYJ9XF6cI?=
 =?us-ascii?Q?/Ng16wH2t0Bk8KhBpjwZxJB8S706brJ29DWLmoFd2KE+Jtri65fg7Ah1IwKO?=
 =?us-ascii?Q?Jyci9cUJbz/uj91sQVHNXfqEryFw9NXCddMd93fd5bf5/P71AWVbgmH6y5lT?=
 =?us-ascii?Q?w8EM+7t6/ccdufhOt3n/2XJQHN+IgmdwAkX6lXe24hjCOVJuqc66dzLICCRe?=
 =?us-ascii?Q?6RXilB8leoPUPpgOZQa7hGnU2X6vnWrw/onEvuNC?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91b3e8c9-9b98-4781-d74e-08dcc2ed7cd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2024 21:00:43.7117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Frjz32Kp6kuj7vPVxu99TS1XG8gEFrA4rMgrkTsuxhKJ28BdXeH17ufMiMh4wb/xHSIHCBkryTKdMWfOMBEtEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6902
X-OriginatorOrg: intel.com


> >> On Wed, Aug 21, 2024, at 05:20, Rohit Agarwal wrote:
> >> > On 19/08/24 6:45 PM, Arnd Bergmann wrote:
> >> >> On Tue, Aug 13, 2024, at 10:45, Rohit Agarwal wrote:
> >> >>
> >> >> What is the call chain you see in the kernel messages? Is it
> >> >> always the same?
> >> > Yes the call stack is same everytime. This is the call stack
> >> >
> >> > <4>[ 2019.101352] dump_stack_lvl+0x69/0xa0 <4>[ 2019.101359]
> >> > warn_alloc+0x10d/0x180 <4>[ 2019.101363]
> >> > __alloc_pages_slowpath+0xe3d/0xe80
> >> > <4>[ 2019.101366] __alloc_pages+0x22f/0x2b0 <4>[ 2019.101369]
> >> > __kmalloc_large_node+0x9d/0x120 <4>[ 2019.101373] ?
> >> > mei_cl_alloc_cb+0x34/0xa0 <4>[ 2019.101377] ?
> >> > mei_cl_alloc_cb+0x74/0xa0 <4>[ 2019.101379] __kmalloc+0x86/0x130
> >> > <4>[ 2019.101382] mei_cl_alloc_cb+0x74/0xa0 <4>[ 2019.101385]
> >> > mei_cl_enqueue_ctrl_wr_cb+0x38/0x90
> >>
> >> Ok, so this might be a result of mei_cl_enqueue_ctrl_wr_cb() doing
> >>
> >>         /* for RX always allocate at least client's mtu */
> >>         if (length)
> >>                 length =3D max_t(size_t, length, mei_cl_mtu(cl));
> >>
> >> which was added in 3030dc056459 ("mei: add wrapper for queuing
> >> control commands."). All the callers seem to be passing a short
> >> "length" of just a few bytes, but this would always extend it to
> >> cl->me_cl->props.max_msg_length in mei_cl_mtu().
> >>
> >> Not sure where that part is set.
> >
> > It's allocating maximum header for receiving buffer so it can
> > accommodate any response.
> > Looks like this part can be optimized with pre allocated buffer pool.
>=20
> I understand that it's always trying to allocate the maximum, the questio=
n is
> whether there is ever a need to set the maximum to more than a page. Pre-
> allocating a buffer at probe time would also address the issue, but if it=
's
> possible to just make that buffer smaller, it wouldn't be needed.
>=20
> Is the 64KB buffer size part of the Chrome specific interface as well, or=
 is that
> part of the upstream kernel implementation?

The upstream solution is for newer graphics cards and overall implementatio=
n is different.=20
I'm trying to collect more information myself, it's summer vacation time, s=
o it will take few days.
Thanks
Tomas



