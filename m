Return-Path: <linux-kernel+bounces-231759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24457919D8B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 04:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FFD61F24628
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 02:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7FCFBEA;
	Thu, 27 Jun 2024 02:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZvcTmfwk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2466D1171C
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 02:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719456575; cv=fail; b=PGrzhJMnvwWlEU9AFHjpLvosj0TMeBLNB3RNoipDwvmMdZFrPuOMbXF69s1vztZQ/7xwz210tIPgcwhS0ye/yzQZvQP93baGzZBFqvW3SLFLNRcrIJaOH2xDE2ONqPMvROiKmGC0FcnZ0oz+HJ7+sWkElngVGEuK4Kv0mCywxBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719456575; c=relaxed/simple;
	bh=BtHg1Lza+kzt7uFVoNNEYhEYAUUqeRfknkpnhg4FsO0=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=L7ccxbgM5XUcqH/Ox3/yVB3V4/y6c6s4Oi02ewh4Ld7GXe26TsKUb0vBndIzP4ox555Mk6U8T3ZiIt8Os4dEMgPPInxGVjqdHjsYbana+kGfuy+0D6Fi06YXT6nobgCwPzkn0ev6lk8r8JUK5KbamPLkajYKenFi1H9SO4/M+hs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZvcTmfwk; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719456572; x=1750992572;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=BtHg1Lza+kzt7uFVoNNEYhEYAUUqeRfknkpnhg4FsO0=;
  b=ZvcTmfwk4BEP1vXNFLsX4d5Aei39MAlczKvCa74ouKy0Kls/bF70n8z+
   nVisv+9eaJMmSAaBoJcENoP6vflb/ZfFvnhMa4PpwOEvebwuRA5arXckw
   OTNEK06qehOOUIYshK6MXlG1cyIaUeJcqsBDm5SeS3VZYwpVTiZKeQ5cV
   CzXeOzSVh4eLUCTWT+0IyI6FBOdtyCcdu/U+UeYTYDQIbAUQgR10e0sUW
   UWpRCg7S83Eh2K9H6ZiSQocFWyJ4xytchxcakJ+0wDy0N8bolQgnWsbhC
   v9x7p9XUnqsk1GFdclS37CeMpsRJ6xIsO6EzXo2AgQnTA0sT5qFKyUZ8E
   Q==;
X-CSE-ConnectionGUID: M3OMExyUS7y3KWmSBgGNSQ==
X-CSE-MsgGUID: nnvZf/7HRluMTLEej+DdYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="16445999"
X-IronPort-AV: E=Sophos;i="6.08,268,1712646000"; 
   d="scan'208";a="16445999"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 19:49:32 -0700
X-CSE-ConnectionGUID: CNaVNTcKRXqR1mATLSM6TQ==
X-CSE-MsgGUID: yRRFoLLITy2JHdvvKEs6bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,268,1712646000"; 
   d="scan'208";a="44193590"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Jun 2024 19:49:31 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 26 Jun 2024 19:49:31 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 26 Jun 2024 19:49:30 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 26 Jun 2024 19:49:30 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 26 Jun 2024 19:49:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fEu0y2de/AlOCyna6afdaV+ZRpNKsLMbMjJRozm8yb/KoN4lVwkwvOnQ5p1m4s9SFerO7RdZdr1Wvhig1KIJsV5obzsc8WE3jV2b+VhU15G1kWP213zMQUofTxmSKyPBJcmS/0szpbZsIoABkVDdKArx292zhfUAuSeqVhG0Ezf1COMsI8W5zwHt6Nh7DcAyrelemD8gxnaE9wr6SK9MHmXVYBie8KOR3G2903pe8ER7TMkLPk5kU1M88Dy5XvJJioDELUgvyNNudUO+dC9yvuNQPuVxeN9g1z9Q5lLeoRSaH1YpTBcw5vQmy8D2u6tM/M6jYxoVpwAsKOQeH2S6mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yZf791V1zyFCDgX/gWNzTUjBEMtsAxCDr0dQc1aw42U=;
 b=QfkOQ4mTmQciAG9XNnSxy7EQkEnJidC1peuqd7fFJT3vvb9BM+7BY01mndjG0Ot8hlrt3Jf/V9mAOZ/C8aCsFhOI+fZv/B03I3hFBPIacb1Vf+UUuN1ekJupmY4/avKp1RkfNdLlpWRETnIcAL/SZwlhP12xqY1eBcsrmGBlEkxRRFWiJDNWKSq9DVrdoV0r6cdzBHq21nWU13Z3mqxDOE4qDFSiN6pQyxcGOLR+dwi1sk28ah1zoiNdh+HWTWP8TrYnrGSmyirDcWZdxoCnWtxiJ9GdJfA25fCAm3A5cdK4+CaHzyQCYv0fsnHAnl8tXfpPs5euiJ4Z1bf59drC/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH0PR11MB4805.namprd11.prod.outlook.com (2603:10b6:510:32::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Thu, 27 Jun
 2024 02:49:27 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 02:49:26 +0000
Date: Thu, 27 Jun 2024 10:49:13 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Mateusz Guzik <mjguzik@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, Christian Brauner <brauner@kernel.org>,
	<linux-kernel@vger.kernel.org>, <ying.huang@intel.com>,
	<feng.tang@intel.com>, <fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [linux-next:master] [vfs]  bdf6091183:  stress-ng.full.ops_per_sec
 633.4% improvement
Message-ID: <202406270909.adb09955-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG3P274CA0023.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::35)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH0PR11MB4805:EE_
X-MS-Office365-Filtering-Correlation-Id: 7977fb3c-6cb4-41eb-0b6a-08dc9653c260
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?cIu00K7NHjI6LLYCBb8IAX/a2ctbL3LBz2XcCkGr7JaIXMepsfLzvY4LKj?=
 =?iso-8859-1?Q?gCc+9/ITKUAPT088qDloety6zzkIUOQVyMufIh46eTO7cADESmJkJCmBqq?=
 =?iso-8859-1?Q?6BJpMkeC6N0yvS91kZS0cRJ3B91pSQTg1niJ2wBIyNd2fhqyQL5JcRcYvr?=
 =?iso-8859-1?Q?SFFRUAPwol1RRV19BxIr64OjsQCAMbnGCanZ7oo8rkA22Uun++nHMLgyU2?=
 =?iso-8859-1?Q?JcQmAxRgaYlEX+Lb+ZhCcMpQJwozm/pCQXEJ7kebRZjejEkgBKzS9/y8FA?=
 =?iso-8859-1?Q?E7jfwi1uVkd6R9o+XjNNVZ8xnFOgx+4MV+Bv0depk0H4AjLL54M2JDOKIG?=
 =?iso-8859-1?Q?xQMXVWhcgBJS8tzZkBaFakp3nOz2QSXMWH+Jd5Q6jLr+mCYQuIyeBRFOyP?=
 =?iso-8859-1?Q?j6bBLR3V6iHzMkK6hPeaEmZ+bv+zRdxPcRLWqb1/AjSbhjz6k/trW+3Flh?=
 =?iso-8859-1?Q?YqyJoS5rCed8i0pTfyNwe2moXkJ+bCzyo9bHSmlwVI3J030BThcXl4I8pA?=
 =?iso-8859-1?Q?FC+MrPZa48LErqMJlndpsQ6U74MTEe/OlMIW12f4NVSLGl6MU+jT+oHY7D?=
 =?iso-8859-1?Q?fhyVh2+7wGSlMo1QxyIiSJzWBJoyENo5Kkcrmwodl6GuWcOXyzYNL4JGJr?=
 =?iso-8859-1?Q?/35GRI3CUssVfX+1zTF+WZae9Ejze8joG1w7IKOPGmHLntYXFrOM+XQqgA?=
 =?iso-8859-1?Q?2V3BcXBz4ONWRpnarbUhquNfNULRua81YRkXFS5MNKDJAH5YRINTU/nQK2?=
 =?iso-8859-1?Q?1ha/58/cAHkUm9draX28+DmfQKQPk2ulGf2gd/0Cyv/BVnYkAltixknvKF?=
 =?iso-8859-1?Q?T1GhRIjE9ZdQlTvifMmShXHX647WCPYZtZAwX608eQSqJoo/gOYbuPLsEE?=
 =?iso-8859-1?Q?rHnWn7stKXHP5wBfuaUnYrG2CYEIWWNklpSViCTBIKAUSKYf6W0KR4d5ZW?=
 =?iso-8859-1?Q?9xaRxVxdxvdeVgISMf5WkxCJJlg82/Kc5V1F9Z8ueaad7lxsEJ4WRv1YzF?=
 =?iso-8859-1?Q?uit3WNAh2I+DoGMwbv/5MOjYCZ0G5618c1wNcO3upktw+c5Wv1xLyqCJTh?=
 =?iso-8859-1?Q?9C/yik/eLm53g1sB7rYUMcAmC7wpb6+gYHsOab+89D4vnww10JwT/Z457t?=
 =?iso-8859-1?Q?A/NEi3NgqETeesEyynfSc7sYzpneTA8vilEouhrGgM6yBksRxCB5XDrKh8?=
 =?iso-8859-1?Q?Tc9ifazXYe6BmzPyYR4DBdpIphoODINUHQW+3/L/PUGRkDlFaVkSgLC9qY?=
 =?iso-8859-1?Q?3vBu/ezd+ppw/BaM1sn0YtP8bGo9s0meT2LEa54IX2R0jzL/A9mcZ3ftpI?=
 =?iso-8859-1?Q?f+/OsysL1We26SJHPbW5wovFRg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Ou7Wz/X413iGuyaU0cm9PSasI6SipzLbC8fGY9iwM/qfsUzeyvBYNvn8G8?=
 =?iso-8859-1?Q?uvg022Bl7zxuG6HCEo6knN1/LYwu3u/0Ot9T7Hy7I99EpMZOhqJ5T6sPi7?=
 =?iso-8859-1?Q?zS9KJVM5eiLWVJSzt3/AG6i2s25LeTr8C971w2mWOpTBVmr+eA0fuNNkqv?=
 =?iso-8859-1?Q?pJzWtkhlogp9xmnwMDVnI75PQv+9ErDGz3vRPm+tdu3awPokaG3UhCsmA2?=
 =?iso-8859-1?Q?LF9dC/4jVSrYmb7wbBFxqiT+YPqAozUtdo/WNBBKTGl9DiPMzt1ipO68to?=
 =?iso-8859-1?Q?VLK3MphNmnxMcVWjREh9zeaY/itt/dxPVEV1S46+LzYJmToikhMsbk9tbK?=
 =?iso-8859-1?Q?cfX7lI5mLZHzoPo/h1Mx2fz21nTxEYKPovuROF3VTuF+hHvOQQlQ+x5Hwz?=
 =?iso-8859-1?Q?rFH1hoGthfCGYs50/MjOXCQ+scQWZNEDTYYcEkOb16EMh59e91zyWW9Vxn?=
 =?iso-8859-1?Q?zJ8f8p3Dpgdz0xTe6xG2Ml5u8UD6gBUnGACVFMeEbzh0UBkkR59CLkmAQz?=
 =?iso-8859-1?Q?LUBoZTE7xFp6eGq/nDFIBkO08/uBsVG55YH8TcKTcCUte9MkZUgp6rdlSd?=
 =?iso-8859-1?Q?EniKEGbkRuHXiNdeWu9j3tzkdOy2vjFp1jql/NBVKpgRdQu1ZpnwPfa7mw?=
 =?iso-8859-1?Q?k41N854q2qEhZYOAsZDtO+JKsgXfwYQxqgd3e6CMp+dEHVmtEz38dHGkM0?=
 =?iso-8859-1?Q?IXHASXRxsVa8fdtb9cQTIxdkPHY++g0OSFhFLX6amFqCgvw0IkARg4MIeZ?=
 =?iso-8859-1?Q?OlYRbhWd0oHci6sDsUzpGVspZcjiyvPQdWJFUAKXmymVAC69mw9EixA4s8?=
 =?iso-8859-1?Q?5KeB+rquZSrMG1GKv57YQUdUYgfr3dkXs1ziCsVzyhR2LBO6h2bx/y5xSn?=
 =?iso-8859-1?Q?2g+i5JnAuNAlVyqIqva5lLa2XhkXM2+x4uwgzPcrUjKZp0zyDu/ODOLrFY?=
 =?iso-8859-1?Q?2qKUs8egAS0htIu75ljUCjV15KPxo0Uy9Nz0sjEV05r53ZtnajUpXBj1TG?=
 =?iso-8859-1?Q?N2qQPHOLdXsBeoiX+T/uoJIgfjpLgo/075bWxz5b/BO3uaP0oGXLltaUZQ?=
 =?iso-8859-1?Q?YB/8pEaLhtGr5CuAZOiUtsGrB+bm+NG/7yIE83eMI6MMeZ32fnqB800fp3?=
 =?iso-8859-1?Q?bE1NJ4Zt4sgjLzUD/+2oj3gNNo4j9kAQ5gxQc7dRkBYM0zFD7ZkTTpU2id?=
 =?iso-8859-1?Q?95skQc+B5lLzv9D6IQ9Uj4SzwTN3mZJx6ciKpNdGPz2rpwIOPcA98GEA5s?=
 =?iso-8859-1?Q?mwU/P7eRdtc2DE+eMvKqW7wdoSiNIQqG7fw1TQKBU0Z7FqZvjJQwSV8j5m?=
 =?iso-8859-1?Q?qoerI58W6l/Fqktc4ymanoBqWi33mgQcWcxBbCbKGdkcNkRq73MRTxxV9v?=
 =?iso-8859-1?Q?OEqrwBFrJqRFyE+fiwjuG0wSoshdMYWrxEV4A4qwQrt0djsqmugQqvhoOg?=
 =?iso-8859-1?Q?yKEocdHNjG0bxqLgoYa5YCsNect/IZjsN7FYYbQK/xPreb04ImM2RVMMLD?=
 =?iso-8859-1?Q?cWqUHyG+g1K0J0lRrEQMYU2PYA2P+C+oB8qOUbCt4F2Hr2Mj8fu7ml9t8N?=
 =?iso-8859-1?Q?8juwdr+FiYFZm28UGatL+EY2w+Egg3m2bbsINElGYN7gU4GeitGBbl7XCp?=
 =?iso-8859-1?Q?33hTxWKh0lM58RPE1dg3CSkBCEQm7Ttnr8y/G+fpPTmqs7O+QMqMW7tA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7977fb3c-6cb4-41eb-0b6a-08dc9653c260
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 02:49:26.9079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CoX1S46xODA8FMInHatq3fPow3guLcKe4dzyCVIqPGrWuym5ov9epLcW3Az4aapssVQZVYlP4GLJ/rhzxJXPQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4805
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 633.4% improvement of stress-ng.full.ops_per_sec on:


commit: bdf609118326e7c15f1c7efbc629bd9f7f307231 ("vfs: move d_lockref out of the area used by RCU lookup")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

testcase: stress-ng
test machine: 256 threads 2 sockets GENUINE INTEL(R) XEON(R) (Sierra Forest) with 128G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: full
	cpufreq_governor: performance






Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240627/202406270909.adb09955-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-13/performance/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/lkp-srf-2sp1/full/stress-ng/60s

commit: 
  d042dae6ad ("lockref: speculatively spin waiting for the lock to be released")
  bdf6091183 ("vfs: move d_lockref out of the area used by RCU lookup")

d042dae6ad74df8a bdf609118326e7c15f1c7efbc62 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      0.24 ± 14%      +0.3        0.51 ±  6%  mpstat.cpu.all.usr%
    783327 ±  4%     +12.4%     880472 ±  4%  numa-numastat.node1.local_node
    516588 ±  9%     +15.0%     594316 ±  6%  vmstat.system.in
      8759 ± 73%    +110.7%      18455 ± 41%  numa-meminfo.node1.PageTables
    841412 ± 11%     +18.1%     993556 ±  7%  numa-meminfo.node1.Shmem
      2183 ± 72%    +111.9%       4626 ± 41%  numa-vmstat.node1.nr_page_table_pages
    210196 ± 11%     +18.2%     248382 ±  6%  numa-vmstat.node1.nr_shmem
    782967 ±  4%     +12.4%     879991 ±  4%  numa-vmstat.node1.numa_local
    244258 ±  5%     +21.1%     295853 ±  9%  sched_debug.cfs_rq:/.avg_vruntime.stddev
    456627 ± 76%     -94.3%      26089 ±  6%  sched_debug.cfs_rq:/.load.max
    244258 ±  5%     +21.1%     295853 ±  9%  sched_debug.cfs_rq:/.min_vruntime.stddev
   7656655 ± 11%    +633.4%   56155706        stress-ng.full.ops
    127609 ± 11%    +633.4%     935926        stress-ng.full.ops_per_sec
     59946            +6.6%      63873 ±  4%  stress-ng.time.involuntary_context_switches
      5.96 ± 11%    +597.3%      41.59        stress-ng.time.user_time
      1558 ±  7%     -86.6%     208.33 ±  6%  perf-c2c.DRAM.local
     15021 ±  4%     +59.5%      23957 ±  3%  perf-c2c.DRAM.remote
     15399 ±  2%    +102.6%      31205 ±  3%  perf-c2c.HITM.local
      9938 ±  3%    +103.4%      20217 ±  4%  perf-c2c.HITM.remote
     25337 ±  2%    +102.9%      51422 ±  3%  perf-c2c.HITM.total
     16172 ± 32%    +162.6%      42464 ± 13%  proc-vmstat.numa_hint_faults
     14655 ± 34%     +82.4%      26726 ± 24%  proc-vmstat.numa_hint_faults_local
   1428439            +5.2%    1502110        proc-vmstat.numa_hit
   1164410            +6.5%    1240512        proc-vmstat.numa_local
    169794 ± 14%     +32.8%     225458 ± 14%  proc-vmstat.numa_pte_updates
    185208            +5.9%     196095 ±  4%  proc-vmstat.pgactivate
   1510415            +4.9%    1584896        proc-vmstat.pgalloc_normal
 7.553e+09 ± 11%     +42.2%  1.074e+10 ±  7%  perf-stat.i.branch-instructions
  20529685 ± 22%     +58.4%   32511073 ± 12%  perf-stat.i.branch-misses
     18.77 ±  9%      +9.6       28.36 ±  6%  perf-stat.i.cache-miss-rate%
   5757124 ± 11%     +71.2%    9853953 ±  8%  perf-stat.i.cache-misses
  27469874 ±  9%     +23.9%   34036598 ±  7%  perf-stat.i.cache-references
      2575 ±  2%      +6.1%       2732 ±  2%  perf-stat.i.context-switches
     16.75 ±  8%     -24.4%      12.66 ±  4%  perf-stat.i.cpi
    335.17 ±  2%      +5.4%     353.20        perf-stat.i.cpu-migrations
    119311 ± 12%     -44.0%      66812 ±  5%  perf-stat.i.cycles-between-cache-misses
 3.106e+10 ± 11%     +49.4%   4.64e+10 ±  7%  perf-stat.i.instructions
      0.19 ±  4%     +15.2%       0.22        perf-stat.overall.MPKI
     21.65 ±  2%      +8.2       29.84 ±  2%  perf-stat.overall.cache-miss-rate%
     18.46           -28.3%      13.23        perf-stat.overall.cpi
     98417 ±  4%     -37.9%      61109        perf-stat.overall.cycles-between-cache-misses
      0.05           +39.5%       0.08        perf-stat.overall.ipc
 7.648e+09 ±  9%     +39.7%  1.069e+10 ±  6%  perf-stat.ps.branch-instructions
  20972501 ± 19%     +52.4%   31965991 ± 10%  perf-stat.ps.branch-misses
   5909643 ±  9%     +69.3%   10006290 ±  7%  perf-stat.ps.cache-misses
  27252734 ±  7%     +23.0%   33515970 ±  6%  perf-stat.ps.cache-references
      2461            +6.3%       2615        perf-stat.ps.context-switches
    323.20            +4.6%     338.19        perf-stat.ps.cpu-migrations
 3.146e+10 ±  9%     +46.7%  4.616e+10 ±  6%  perf-stat.ps.instructions
 2.154e+12           +38.9%  2.992e+12        perf-stat.total.instructions
     24.75           -24.7        0.00        perf-profile.calltrace.cycles-pp.dput.terminate_walk.path_openat.do_filp_open.do_sys_openat2
     24.75           -24.7        0.00        perf-profile.calltrace.cycles-pp.terminate_walk.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
     24.74           -24.7        0.00        perf-profile.calltrace.cycles-pp.__legitimize_path.try_to_unlazy.complete_walk.do_open.path_openat
     24.74           -24.7        0.00        perf-profile.calltrace.cycles-pp.complete_walk.do_open.path_openat.do_filp_open.do_sys_openat2
     24.74           -24.7        0.00        perf-profile.calltrace.cycles-pp.try_to_unlazy.complete_walk.do_open.path_openat.do_filp_open
     24.74           -24.7        0.00        perf-profile.calltrace.cycles-pp.lockref_get_not_dead.__legitimize_path.try_to_unlazy.complete_walk.do_open
     24.73           -24.7        0.00        perf-profile.calltrace.cycles-pp.dput.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
     24.71           -24.7        0.00        perf-profile.calltrace.cycles-pp.lockref_get.do_dentry_open.do_open.path_openat.do_filp_open
     24.84           -24.2        0.65 ±  9%  perf-profile.calltrace.cycles-pp.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
     24.85           -24.2        0.69 ±  8%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
     24.85           -24.2        0.69 ±  8%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close
     24.84           -24.2        0.68 ±  9%  perf-profile.calltrace.cycles-pp.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
     24.85           -24.1        0.72 ±  8%  perf-profile.calltrace.cycles-pp.__close
     23.68           -23.7        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock.dput.terminate_walk.path_openat.do_filp_open
     23.67           -23.7        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock.lockref_get_not_dead.__legitimize_path.try_to_unlazy.complete_walk
     23.67           -23.7        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock.lockref_get.do_dentry_open.do_open.path_openat
     23.67           -23.7        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock.dput.__fput.__x64_sys_close.do_syscall_64
     23.63           -23.6        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.dput.terminate_walk.path_openat
     23.62           -23.6        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.lockref_get_not_dead.__legitimize_path.try_to_unlazy
     23.62           -23.6        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.lockref_get.do_dentry_open.do_open
     23.62           -23.6        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.dput.__fput.__x64_sys_close
     74.50           +23.3       97.82        perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
     74.50           +23.3       97.82        perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
     74.52           +23.3       97.84        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
     74.52           +23.3       97.84        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.open64
     74.41           +23.3       97.74        perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64
     74.41           +23.3       97.75        perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
     74.52           +23.4       97.88        perf-profile.calltrace.cycles-pp.open64
     49.65           +47.5       97.18        perf-profile.calltrace.cycles-pp.do_open.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
     24.83           +72.0       96.82        perf-profile.calltrace.cycles-pp.do_dentry_open.do_open.path_openat.do_filp_open.do_sys_openat2
      0.00           +96.0       95.99        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.chrdev_open.do_dentry_open.do_open
      0.00           +96.2       96.18        perf-profile.calltrace.cycles-pp._raw_spin_lock.chrdev_open.do_dentry_open.do_open.path_openat
      0.00           +96.3       96.34        perf-profile.calltrace.cycles-pp.chrdev_open.do_dentry_open.do_open.path_openat.do_filp_open
     49.48           -48.8        0.65 ± 13%  perf-profile.children.cycles-pp.dput
     24.71           -24.5        0.22 ± 12%  perf-profile.children.cycles-pp.lockref_get
     24.74           -24.4        0.31 ± 10%  perf-profile.children.cycles-pp.lockref_get_not_dead
     24.74           -24.4        0.32 ± 10%  perf-profile.children.cycles-pp.__legitimize_path
     24.74           -24.4        0.32 ± 10%  perf-profile.children.cycles-pp.complete_walk
     24.74           -24.4        0.32 ± 10%  perf-profile.children.cycles-pp.try_to_unlazy
     24.75           -24.4        0.34 ± 12%  perf-profile.children.cycles-pp.terminate_walk
     24.84           -24.2        0.65 ±  9%  perf-profile.children.cycles-pp.__fput
     24.84           -24.2        0.68 ±  9%  perf-profile.children.cycles-pp.__x64_sys_close
     24.85           -24.1        0.73 ±  8%  perf-profile.children.cycles-pp.__close
      2.13 ±  6%      -1.5        0.65 ± 13%  perf-profile.children.cycles-pp.lockref_put_return
     99.79            -0.4       99.40        perf-profile.children.cycles-pp.do_syscall_64
     99.80            -0.4       99.42        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.23 ±  2%      +0.0        0.25        perf-profile.children.cycles-pp.ksys_write
      0.08 ±  5%      +0.0        0.13 ±  2%  perf-profile.children.cycles-pp.apparmor_file_free_security
      0.08 ±  5%      +0.0        0.13 ±  2%  perf-profile.children.cycles-pp.security_file_free
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.stress_full
      0.02 ±141%      +0.1        0.07        perf-profile.children.cycles-pp.__x64_sys_pread64
      0.26            +0.1        0.32 ±  2%  perf-profile.children.cycles-pp.write
      0.02 ± 99%      +0.1        0.09 ±  4%  perf-profile.children.cycles-pp.__do_sys_newfstatat
      0.02 ±141%      +0.1        0.08        perf-profile.children.cycles-pp.ksys_read
      0.08 ±  5%      +0.1        0.15 ±  2%  perf-profile.children.cycles-pp.vfs_read
      0.05            +0.1        0.12 ±  3%  perf-profile.children.cycles-pp.__libc_pread
      0.05            +0.1        0.13 ±  2%  perf-profile.children.cycles-pp.read
      0.05            +0.1        0.13 ±  2%  perf-profile.children.cycles-pp.fstatat64
      0.00            +0.1        0.08 ±  4%  perf-profile.children.cycles-pp.mas_rev_awalk
      0.08 ±  6%      +0.1        0.17 ±  4%  perf-profile.children.cycles-pp.apparmor_file_open
      0.08 ±  6%      +0.1        0.18 ±  4%  perf-profile.children.cycles-pp.security_file_open
      0.00            +0.1        0.10        perf-profile.children.cycles-pp.iov_iter_zero
      0.00            +0.1        0.10 ±  3%  perf-profile.children.cycles-pp.read_iter_zero
      0.00            +0.1        0.11 ±  3%  perf-profile.children.cycles-pp.ioctl
      0.00            +0.1        0.12 ±  4%  perf-profile.children.cycles-pp.mas_empty_area_rev
      0.00            +0.1        0.14        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.00            +0.1        0.15 ±  3%  perf-profile.children.cycles-pp.apparmor_file_alloc_security
      0.00            +0.1        0.15 ±  4%  perf-profile.children.cycles-pp.kobject_get_unless_zero
      0.00            +0.2        0.16 ±  3%  perf-profile.children.cycles-pp.security_file_alloc
      0.00            +0.2        0.16 ±  2%  perf-profile.children.cycles-pp.init_file
      0.00            +0.2        0.17 ±  2%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.00            +0.2        0.17 ±  2%  perf-profile.children.cycles-pp.vm_unmapped_area
      0.00            +0.2        0.18 ± 10%  perf-profile.children.cycles-pp.cdev_put
      0.00            +0.2        0.18 ± 10%  perf-profile.children.cycles-pp.kobject_put
      0.00            +0.2        0.19        perf-profile.children.cycles-pp.alloc_empty_file
      0.00            +0.2        0.19        perf-profile.children.cycles-pp.arch_get_unmapped_area_topdown_vmflags
      0.00            +0.2        0.20 ±  2%  perf-profile.children.cycles-pp.thp_get_unmapped_area_vmflags
      0.00            +0.2        0.20        perf-profile.children.cycles-pp.__get_unmapped_area
      0.00            +0.2        0.21 ±  2%  perf-profile.children.cycles-pp.do_mmap
      0.02 ± 99%      +0.3        0.29        perf-profile.children.cycles-pp.vm_mmap_pgoff
      0.02 ± 99%      +0.3        0.31        perf-profile.children.cycles-pp.ksys_mmap_pgoff
      0.06 ±  9%      +0.3        0.40        perf-profile.children.cycles-pp.__mmap
     94.70            +1.5       96.19        perf-profile.children.cycles-pp._raw_spin_lock
     94.51            +1.5       96.01        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     74.50           +23.3       97.82        perf-profile.children.cycles-pp.__x64_sys_openat
     74.50           +23.3       97.82        perf-profile.children.cycles-pp.do_sys_openat2
     74.41           +23.3       97.74        perf-profile.children.cycles-pp.path_openat
     74.41           +23.3       97.75        perf-profile.children.cycles-pp.do_filp_open
     74.52           +23.4       97.89        perf-profile.children.cycles-pp.open64
     49.65           +47.5       97.18        perf-profile.children.cycles-pp.do_open
     24.83           +72.0       96.82        perf-profile.children.cycles-pp.do_dentry_open
      0.00           +96.3       96.34        perf-profile.children.cycles-pp.chrdev_open
      2.12 ±  6%      -1.5        0.64 ± 13%  perf-profile.self.cycles-pp.lockref_put_return
      1.04 ±  7%      -0.8        0.22 ± 12%  perf-profile.self.cycles-pp.lockref_get
      1.06 ±  6%      -0.7        0.31 ± 10%  perf-profile.self.cycles-pp.lockref_get_not_dead
      0.08 ±  5%      +0.0        0.13 ±  2%  perf-profile.self.cycles-pp.apparmor_file_free_security
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.stress_full
      0.00            +0.1        0.07        perf-profile.self.cycles-pp.mas_rev_awalk
      0.00            +0.1        0.08 ±  4%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.00            +0.1        0.09        perf-profile.self.cycles-pp.do_dentry_open
      0.08 ±  6%      +0.1        0.17 ±  4%  perf-profile.self.cycles-pp.apparmor_file_open
      0.00            +0.1        0.10        perf-profile.self.cycles-pp.iov_iter_zero
      0.00            +0.1        0.14        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.00            +0.1        0.15 ±  3%  perf-profile.self.cycles-pp.apparmor_file_alloc_security
      0.00            +0.1        0.15 ±  4%  perf-profile.self.cycles-pp.kobject_get_unless_zero
      0.00            +0.2        0.18 ± 10%  perf-profile.self.cycles-pp.kobject_put
     94.04            +1.5       95.52        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


