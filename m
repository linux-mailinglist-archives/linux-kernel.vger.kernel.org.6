Return-Path: <linux-kernel+bounces-346380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 423DC98C41A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 19:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B585EB20ED1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAA41C9EC4;
	Tue,  1 Oct 2024 17:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gVHoTsQX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C631CB308
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 17:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727802093; cv=fail; b=RvaqkknQT38TFhrpqrHd6UY9g/nmIdXPHUzwB3toF/+Vq6IcB3tK0TIajFAEV6XnEx8rWAgE8dwCSMTydyb7kPnLULf6IpYfngJLfBuH4zMwarCFLLZBMW1ybSqqPOVZP00jeDcBwKX7Yq+28voct2qh4FnIogk8efHIO0EaE/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727802093; c=relaxed/simple;
	bh=rJk4b1aFdPsP9wcsRwxyT7mxq196KnXblyZXTVN8ulU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gzTXkGasjvoPhEftX7wiab97YuLtGFOtDd6ka5xj+F7GwGkMMgC1K9py/M1I6sDQ0yg6OBtZ68pA3scfX+xPTls2ghnY8p2K4UuPXyHbYtOc8wTrYHOoryjDG/eB2IuISuscDmyvFyz/wRMIo8sAWtZrvwEeYHLxAzov8czolDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gVHoTsQX; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727802092; x=1759338092;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rJk4b1aFdPsP9wcsRwxyT7mxq196KnXblyZXTVN8ulU=;
  b=gVHoTsQXaXsSgk0gRIZuFz4LrCW9ukgYqO0UsF+U1g1lbCwq8sPtkLEW
   pF8DYZY2/Mpva6vZjGd98uItRftVicpfjgeeZ4VNH5EOnl1s83eqWAWHF
   hi57gFiOBwt18zi+Uc3J1Pv3LAcQIViuqsXJWEXlX3THCGNWVWLUc/X1f
   JPDnEG1zEZ0fjcnOQbJisHn/qgBRUkRoRd+Pzb1ZFHgcd9Irs+GtkJTiY
   GB0ovrbFtCMtGtPM/Ny6tRe6UuN538G0ubRdO8OTPyt5r0SspOoLywovT
   jWuibijwpFrOTXGN9tWyco/f2mRkxnEAWceun3f1mHhg4kwIu9YZ1Nxvy
   A==;
X-CSE-ConnectionGUID: PJke30DdQtqnXQQxUY5a+Q==
X-CSE-MsgGUID: keGAiA0ASYSY0h6Tl4tEzA==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="27082817"
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="27082817"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 10:01:32 -0700
X-CSE-ConnectionGUID: 9zz0a9GsQ/yeWEBWDPGCwg==
X-CSE-MsgGUID: m5sG/pNdQNGLrL/sscmISw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="104511899"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Oct 2024 10:01:31 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 1 Oct 2024 10:01:30 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 1 Oct 2024 10:01:30 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 1 Oct 2024 10:01:30 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 1 Oct 2024 10:01:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bFq5+grG7+URSnrqzmUgFTRGJDE8U28ygUoZr5++b7s48HXX8GznWSLyYVSMawyjVsFSfQeXnYKqTM1+G3vhFgQfT840sUy5rHO5x/RI04q4x/dD8FfcIO3YNO3f21gNadH7g43A/7/OOyhFk2AobRnUjFoUHyeSr/71mNt37WQEvL332Zq1XaaUpcnw1h7w3dWvZOCIHGWV7vjSQrcDFypLrsBzQ2CAnidwRPzwstATFl1GDFQ/HxWx//2HUexTJaSLK+7HneBnDt4OMmB4Bdc1ZsqipBDnBDC5I9TbzIDxcPtbNqhp+61JCMxKFU4yQkqiqqX9VQa3GqNi8uqzlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K53Cu0nu1wOcmND0JT1AG0/MBGjiw6j0DDR0Cp4HIIk=;
 b=xXKQIYzkmu+vkGweZzjD07UjYWii2bz6AqYko4SNOxsf3fkO6ToGqTKxxnVHD5LlvMOuC36fXHdzMLO7mFuuYpaCXsiKlpgIqwBKJAfls0lLLwXJP9MUE+Mr2bDkL6PHfjmohEmt7WDDntD+eN30Au+cGdPTL2WsmK2A2RVqYjuhxoXbRhU29MRLf/QcI/HUjNj9sZaca5QHaAv+i9zSz7zNz7V7Im1ex4ng0KGdY4TZ6HyrqbbaNd5oJg9tNZifDdlBZt7TDlDB2POfysiYp+/1q7DLxXpMLZRzSV83U1LF7HOP5d/5DnYxFlw+AHSmz1aHZNblkl+y0kfB3GuA+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com (2603:10b6:a03:3b8::22)
 by SN7PR11MB6752.namprd11.prod.outlook.com (2603:10b6:806:264::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Tue, 1 Oct
 2024 17:01:22 +0000
Received: from SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c]) by SJ0PR11MB5678.namprd11.prod.outlook.com
 ([fe80::812:6f53:13d:609c%4]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 17:01:22 +0000
From: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
To: Johannes Weiner <hannes@cmpxchg.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "yosryahmed@google.com"
	<yosryahmed@google.com>, "nphamcs@gmail.com" <nphamcs@gmail.com>,
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "shakeel.butt@linux.dev"
	<shakeel.butt@linux.dev>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"Huang, Ying" <ying.huang@intel.com>, "21cnbao@gmail.com"
	<21cnbao@gmail.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"willy@infradead.org" <willy@infradead.org>, "Zou, Nanhai"
	<nanhai.zou@intel.com>, "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>,
	"Gopal, Vinodh" <vinodh.gopal@intel.com>, "Sridhar, Kanchana P"
	<kanchana.p.sridhar@intel.com>
Subject: RE: [PATCH v10 6/7] mm: zswap: Support large folios in zswap_store().
Thread-Topic: [PATCH v10 6/7] mm: zswap: Support large folios in
 zswap_store().
Thread-Index: AQHbE8NS/mzK7ddAdUGteugGSqw7kLJxvZiAgABhSHA=
Date: Tue, 1 Oct 2024 17:01:22 +0000
Message-ID: <SJ0PR11MB56786570AA6C6C8EE7FFC0BDC9772@SJ0PR11MB5678.namprd11.prod.outlook.com>
References: <20241001053222.6944-1-kanchana.p.sridhar@intel.com>
 <20241001053222.6944-7-kanchana.p.sridhar@intel.com>
 <20241001111045.GA1003400@cmpxchg.org>
In-Reply-To: <20241001111045.GA1003400@cmpxchg.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5678:EE_|SN7PR11MB6752:EE_
x-ms-office365-filtering-correlation-id: e4b71dc8-fd99-435e-9d74-08dce23aad3b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?CW7nOVT/DuD7kJo+vgWtI3GCMLh3o4ZV1+54NMdn2rh1U5XAb0b09D8GXc6r?=
 =?us-ascii?Q?6j6mQwhpOr3L0MU+ywu69ApvZMYMZPxSHfZqhv3v5LQxC1kVe2AL5skHwKHq?=
 =?us-ascii?Q?V2w7dKKg05vEJJ+rVpjwPwKkWg6dBXQfksbB5tP08aYyMT3QWRC+d/mZkDUS?=
 =?us-ascii?Q?Olg9jA7lDunPl5jL+crTyM8SCiuuDH2o8kI+EaCyeH7DEAVY59LztxLPYxq9?=
 =?us-ascii?Q?trzgqzc2QVjKS7nEoRqd7bFOAshQE4kotKWQkF6VKamVmTiadR50Ad+oumuq?=
 =?us-ascii?Q?ALbX4Lw5aSaj9ziMb0+M/up2n3J1CXCv6IWBY4ax+9rQUoPgdcsaa7ZRFtfm?=
 =?us-ascii?Q?rfDZB3vQfEjUT3GIGnFwkgROF0Qqn5hIo0LgT6RsCtWldv1gQqw8W3qYodvg?=
 =?us-ascii?Q?r+YGbAuBdIO1BfJaG3W3tD9ip+ZxQRC/CjgPMpRsEHWxNOXMDWjLV3YWPX0N?=
 =?us-ascii?Q?P4GWYyw34IV0ecO2VlI6Btwcw9irMxzpH/6eWAzEm2Rbo6eBKAaSqEtZHvAM?=
 =?us-ascii?Q?G9VE8zmhEmGDru9qU8lCh/Ezjj9smPogrtq3RegarAmS51Riur39nGfYei9y?=
 =?us-ascii?Q?Pp4p06bNOjmswArcG5EpQUF5vHLldiUMofEP8By0jgjAxGjxBKNgsSqmtYfn?=
 =?us-ascii?Q?LtWd/e0ec0g+oKaTQTAMNwxoqPvlNyvdwaOHJgHL6lB9mXRcuktbCT43C64d?=
 =?us-ascii?Q?UJWS5KPQCWPB8HWMHYireM7bVdvLwMdh1AUTabXQUSoJ3LPqfXkUDx16iZtm?=
 =?us-ascii?Q?oNuc64wh2SfSgEfihLlqtX4uRU5lAAT5TYyKYbMxKMlz7gY/Gjva75Kbltzy?=
 =?us-ascii?Q?mnYPbL5q98pjLTrCnVDR/es1X5XDMqm7eEe4pTrDnS5DFNY0Di0xaRHY+EZx?=
 =?us-ascii?Q?HKGnJtb8k4hEtyr5KTpknmmXsxd5UT2hrSZo+i1LZGPZ2jhPKzUjL6LSI5eU?=
 =?us-ascii?Q?NPEv5/Kg8eOeZlV9sFdEQravk0ERhdLNbyjLoUU2AWwfHsSyTvulrO578eqA?=
 =?us-ascii?Q?QRQeJdtjDACqeFgMKpBOvtTm6BzuasI+orkRTWYopkK+J8n+4ruo+cOKcOsj?=
 =?us-ascii?Q?m3RCGLczan4+oBDNrpvgLgDjy//y9gnyJhRaPXfshXJ/qBtX3j4pZKzcO3a+?=
 =?us-ascii?Q?vvx5SbXul4Q+3mNk6g6xZ2jNoQagTIg/HZQhkCRrtzjMqYkl0UOW5BuGMSoq?=
 =?us-ascii?Q?umwM8prfy33ow3LgbCb2U+sfyyB3JLKFapJK0m9zyxdpaXX/GXVpuMMy/oj8?=
 =?us-ascii?Q?6fuNQ/hLKDVQYJMQ8DgRRhw/0Uk/iibSXuMm6Y+R2+SNroq4YHZfkbKGxUyA?=
 =?us-ascii?Q?Q4zUTr0Nzt+iHJkweDbVhSvKNppRr2kdcqv9+6gtpyZ2SM3k7R6ATCmD6ykj?=
 =?us-ascii?Q?cChPfyI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5678.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yX+m6IcEyKEwPvYCLh0FZPCW8HQvF8k9guaz7RNfqDKW36AbbB+jYbnHRDp2?=
 =?us-ascii?Q?HCvm4hyhdwrIaMKrkcoH6VRdZeIEdvSNWVTnNAkDvS7T9ccHTOyay5XsEzWs?=
 =?us-ascii?Q?1Q+Gg1NG2rcbRSzrARl29g6YvSWCDXKQIvnqFrB2Vd98xI7SvbWNMXK8S/qi?=
 =?us-ascii?Q?8e67yS/ps/kCAtJ87t2l58IXqx03/wWOnS2oug1yJurGKnWiOdRwC2Fzyv4X?=
 =?us-ascii?Q?ZZeTRGvKkAp62eZMFpuB3BXqP+SV9UyZrbnMyTQQCyy0upSS9tPpotp3lKJ5?=
 =?us-ascii?Q?gdBscfUtqPmm6/A9bq0eVTUkdwDo/PBuDDFrJitVJAz3lqydE6HKX/A1dqBO?=
 =?us-ascii?Q?Pexcp8e4zb7MnzR1bVw0uo3woMHL7G3rqGfFSzqoBHJpUohsn81DjRmrr66j?=
 =?us-ascii?Q?SHIFQ/WN7jRc9ProlLYk6j3WoSDnFKeWucj200pB8xdiYlviTXABRKROcPSb?=
 =?us-ascii?Q?kCxjmXmEUKAu78qQdZ4iyK5uO6PqwER7sLpC3aC9m4793evPyD6NzvTXZwV9?=
 =?us-ascii?Q?8ZZiLZr6o2J+Bt0T7dD8prvJ/4hJGrzsI0K0zImBOz4slRf0uia7GQioYsBj?=
 =?us-ascii?Q?HylGJRjaril37hSIVNgOc2xqXcn4pvUD7tmTCr9IDs3UkfTMz4hcniB+L4Dr?=
 =?us-ascii?Q?SytD6p6Wpe08AJ4xXm3r7I7EixSJryiEazDB3VoPRW6cjwtHyl+PWeJXHa70?=
 =?us-ascii?Q?AkprW3AwhlW7ONoulsOCiviXMbgQ+++MadQ2py8nvKTPNAPNQRCSigy9gyAf?=
 =?us-ascii?Q?crTavdxtyDGXgjYYnC0wu6W0pSNbap4r9R3w97xSLWh/ka7FiI9H5mFpURFc?=
 =?us-ascii?Q?VYKDE8iFtOtWmBKiFeTeIVpOcXJi8Sw0lbJuhpjF+3FP5PTvdwi9StYvi32o?=
 =?us-ascii?Q?nfMF+xkJTgAsePCYfMX5gKCIYHtBfSNNLRdWbUmt0XyzMStTB4lG2lO4Lq0+?=
 =?us-ascii?Q?t+LZDFuUQbNQsJyrKXiYdN2uvhcoFSRIvp7Fbh2SpRNULDoky1c9/Dh241y+?=
 =?us-ascii?Q?0MIRHIjbjk9T/QlxaOFpfPqYbTq27iSYeUeLEW40K9em3ozWxXBD9MThi1Mb?=
 =?us-ascii?Q?c9agVmq4y5DiX1cikTIfOTB6gS6NlVPBCPuCmn+6Fkc8DSDJsqRUM+sniz9x?=
 =?us-ascii?Q?89jloQRGZeRkPuLU2DPlSlrZ5xzQr6+HUK8N0bclTjrE1orysF2ZX/+OldCi?=
 =?us-ascii?Q?ndMEudlrqweYjlSJwQTNjFr+PD36Ma/Tg4PmsYLNood0mu12sVFvVnl4zrB9?=
 =?us-ascii?Q?lCPZRks2LmpuKCrZVuq8U6SKTYcArZz+nUElSGzt5ClberFWifKQvHkauKve?=
 =?us-ascii?Q?4OcoqVal6WFjw+nkZzBjuPSf6LiTrIhJx8awJCZcSDbwFL6FPxy43h1rNgqK?=
 =?us-ascii?Q?mjwa4gV65c+iNWPaxw2Fe7XqZkq/tGH4aBWyWmK/bnGwSSNQq7rm2a7lJHba?=
 =?us-ascii?Q?sgWMebTwvLj5s1P1WIgp7tUKlwiB4Gzfsjy2a72bVAJfaBievL4FVz8FTKKv?=
 =?us-ascii?Q?rwl5OUyQDtRoWQ+RkZEBOZE9sS0BeqW3ApIuRMhzfeTi1qgjCkeBuG5r07n8?=
 =?us-ascii?Q?wszObrSo6qSOq3LkG6lZpvZhGDBm6GVfIWHYdopgdGvTbmF6W5hGz4hl7Yis?=
 =?us-ascii?Q?0g=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e4b71dc8-fd99-435e-9d74-08dce23aad3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2024 17:01:22.1894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ITphs967Dc0WAAd/O1R8jf0wTx1bgEsQHgtCjTWgSBMalNEM6Tjozo/+fGzfaebc9A8ONs0Sj31yQzIGS9a+c/3wAwmXp+OHR1hDiNB+DpM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6752
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Johannes Weiner <hannes@cmpxchg.org>
> Sent: Tuesday, October 1, 2024 4:11 AM
> To: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>
> Cc: linux-kernel@vger.kernel.org; linux-mm@kvack.org;
> yosryahmed@google.com; nphamcs@gmail.com;
> chengming.zhou@linux.dev; usamaarif642@gmail.com;
> shakeel.butt@linux.dev; ryan.roberts@arm.com; Huang, Ying
> <ying.huang@intel.com>; 21cnbao@gmail.com; akpm@linux-foundation.org;
> willy@infradead.org; Zou, Nanhai <nanhai.zou@intel.com>; Feghali, Wajdi K
> <wajdi.k.feghali@intel.com>; Gopal, Vinodh <vinodh.gopal@intel.com>
> Subject: Re: [PATCH v10 6/7] mm: zswap: Support large folios in
> zswap_store().
>=20
> On Mon, Sep 30, 2024 at 10:32:21PM -0700, Kanchana P Sridhar wrote:
> > zswap_store() will store large folios by compressing them page by page.
> >
> > This patch provides a sequential implementation of storing a large foli=
o
> > in zswap_store() by iterating through each page in the folio to compres=
s
> > and store it in the zswap zpool.
> >
> > zswap_store() calls the newly added zswap_store_page() function for eac=
h
> > page in the folio. zswap_store_page() handles compressing and storing e=
ach
> > page.
> >
> > We check the global and per-cgroup limits once at the beginning of
> > zswap_store(), and only check that the limit is not reached yet. This i=
s
> > racy and inaccurate, but it should be sufficient for now. We also obtai=
n
> > initial references to the relevant objcg and pool to guarantee that
> > subsequent references can be acquired by zswap_store_page(). A new
> function
> > zswap_pool_get() is added to facilitate this.
> >
> > If these one-time checks pass, we compress the pages of the folio, whil=
e
> > maintaining a running count of compressed bytes for all the folio's pag=
es.
> > If all pages are successfully compressed and stored, we do the cgroup
> > zswap charging with the total compressed bytes, and batch update the
> > zswap_stored_pages atomic/zswpout event stats with folio_nr_pages()
> once,
> > before returning from zswap_store().
> >
> > If an error is encountered during the store of any page in the folio,
> > all pages in that folio currently stored in zswap will be invalidated.
> > Thus, a folio is either entirely stored in zswap, or entirely not store=
d
> > in zswap.
> >
> > The most important value provided by this patch is it enables swapping =
out
> > large folios to zswap without splitting them. Furthermore, it batches s=
ome
> > operations while doing so (cgroup charging, stats updates).
> >
> > This patch also forms the basis for building compress batching of pages=
 in
> > a large folio in zswap_store() by compressing up to say, 8 pages of the
> > folio in parallel in hardware using the Intel In-Memory Analytics
> > Accelerator (Intel IAA).
> >
> > This change reuses and adapts the functionality in Ryan Roberts' RFC
> > patch [1]:
> >
> >   "[RFC,v1] mm: zswap: Store large folios without splitting"
> >
> >   [1] https://lore.kernel.org/linux-mm/20231019110543.3284654-1-
> ryan.roberts@arm.com/T/#u
> >
> > Co-developed-by: Ryan Roberts
>=20
> I would change that to
>=20
> Originally-by: Ryan Roberts <ryan.roberts@arm.com>
>=20
> > Signed-off-by:
>=20
> and drop this for now.

Thanks Johannes. Sure, this sounds good. Should I post a v11 for just this
specific patch which this change, or a v11 for the entire series?

>=20
> > Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
>=20
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Many thanks! Really appreciate the code review and comments.

Thanks,
Kanchana

