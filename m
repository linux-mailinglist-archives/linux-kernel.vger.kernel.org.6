Return-Path: <linux-kernel+bounces-335485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B5797E658
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 09:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B448F2814DF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 07:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828331759F;
	Mon, 23 Sep 2024 07:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GQbicNdX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE43117996
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 07:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727074947; cv=fail; b=Y2hC+TZRjS87mWKVI19fqv8/vJU+zH/I/53kNJ5FGrfhPkPx1Z70zodiv1HglsH1nZWD0unppQy4zIPZX+WJopaG513NYPQC50xHgnaJOgUfDtH5yWTFRPsIw7KG9Skk0kBZvYcSFKsq4E91c5WP53XiuviM/+IdyjtFuJcs8kI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727074947; c=relaxed/simple;
	bh=f6hoigcQbBYOoGP0VAbDi+B1o4/6BTiGJ5xhjv9FoF4=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=ZZQ13R5dm2sk2WMKpncYf07C8/eHjmpYyg3yU+nfeISSU6srPXG+XUHdiy+ZEKdiaB5QOENj9kJYtMnrJatxEvyzofA2Ib8MnKtB8ktI6P/mYtDrVWEhd23grBeOwLSJ1jgBYHDeNPS++meF3X0nFdzbj4w0ueQHYcNu8Mx6tSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GQbicNdX; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727074945; x=1758610945;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=f6hoigcQbBYOoGP0VAbDi+B1o4/6BTiGJ5xhjv9FoF4=;
  b=GQbicNdXBFiwaqYED5zYpkpFTZ8/UktR+GeiC6TPCSQQL70lXKcFfB1g
   mryVoaQUqd+eQEV2JQoObkS0PO3G6kc+fqddBJSPfMIRzld+/giXu5NXH
   pe9ManUCG6MWfr65hXq+XSIUTHjqwI8dq3bF2v26mn9AfPzmbJ9fafI4/
   kAw248r5R7nIThy399yLsMABQ9bKmKdnhhuvK2rKwv2y2kslLpAvYiGvo
   Hrzus+8AZBdy3BblsuKsOQoACIN03DE0wuMELy05IsMVxwe97N5+8UwSE
   Msjk67F5rDTfAAt+T0ZuJYawDNUigCPaUyB9PF6nJ99jk01B2nm/gaqaZ
   Q==;
X-CSE-ConnectionGUID: minBCMe4S5m6QZczrTr7aw==
X-CSE-MsgGUID: 50FR1I7kR0ipVFM2yE01Vw==
X-IronPort-AV: E=McAfee;i="6700,10204,11202"; a="26162382"
X-IronPort-AV: E=Sophos;i="6.10,250,1719903600"; 
   d="scan'208";a="26162382"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 00:02:24 -0700
X-CSE-ConnectionGUID: CbHgK27pRaakPF+Hx8UDbw==
X-CSE-MsgGUID: n1U8CgzvRiyD2xEvzLhMpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,250,1719903600"; 
   d="scan'208";a="70996413"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Sep 2024 00:02:24 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 23 Sep 2024 00:02:13 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 23 Sep 2024 00:02:13 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 23 Sep 2024 00:02:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jlIJJyb7Ea8ZYtGznrOQuJvfoa2qKHxYB9viqt2DJWjcdCxRMSzkURzcIRlah7T48T7riG7uCeCoakz2xUWGfUV6RvbFyNK9id4p4+Hg00Les8am2xaDqVGoK1yVDh6Wse/xGHlUycyiTAUTFrsdyBI5htVab/TGrf/eogCfE485x0cgpBFU6jW4i0ZXZw77a2jxqgEbXCYbRkcNlSaI9Zdv+9OvTy9S/5R0nSg7oFIW15zhXzgkJRH4Sz3VE38qC2NZk4/997rl0tS/YDCpry4AI8nUe5hnkOdUCsKaYY933q166JYzvdJuNT/4XfjB8AXJ5H1De4cN72HgwxleCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m0kvkNTgTpU3QrTTGR/AIzIm0WrAjo5W5Rd/wpKxFXY=;
 b=XLA+l1aRaToVtr1zdI8vJ1LCMEsyLLZ/Hak9NS4b/8AclU79EfMxPCGIyvR3FNnY0apOsiOYlKjMzE6yFSZqCaHaQIuVkZ46V4260lKInb2F0nfmrlHzteEtEhwwRtt9s+fFARDvcCYVBhEWeZIHwcIgaBbRGEX6LD/T9DgWHkfl6GqB3baLcYp2oOvnbcMaheUsggZXz1RbV5G47Pv2tyZSySm31nG4iu5afS3V89S2F5QxNc7OPuX4FRN+S16NbFE/tfM6TfDywCXbbwssRMaznbUZKeHOcQHdMq2etCanfIBuqtUOu0nTVGKmN/kQiwK6TOPIIp1H6GccQk2/iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA2PR11MB4956.namprd11.prod.outlook.com (2603:10b6:806:112::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 07:02:09 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 07:02:09 +0000
Date: Mon, 23 Sep 2024 15:01:58 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Chunxin Zang <zangchunxin@lixiang.com>, Valentin Schneider
	<vschneid@redhat.com>, Mike Galbraith <umgwanakikbuti@gmail.com>,
	<ying.huang@intel.com>, <feng.tang@intel.com>, <fengwei.yin@intel.com>,
	<aubrey.li@linux.intel.com>, <yu.c.chen@intel.com>, <oliver.sang@intel.com>
Subject: [linus:master] [sched/eevdf]  85e511df3c:  hackbench.throughput
 -13.1% regression
Message-ID: <202409231416.9403c2e9-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR06CA0005.apcprd06.prod.outlook.com
 (2603:1096:4:186::12) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA2PR11MB4956:EE_
X-MS-Office365-Filtering-Correlation-Id: 92e952cc-cc1c-430e-794f-08dcdb9da40f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?q0sHtxnKVno4TCmHby2VwEIAXslhYY45XPT7/LiWCSAgyLufG9bZHj3tQb?=
 =?iso-8859-1?Q?a1LAjl7V0Zl/y28W0iOZKoUWs/HAwRKludhPTptRXBfJ42r3nAmFQdfEd5?=
 =?iso-8859-1?Q?/FG6S/mM2zfSMyoVSN79nLLkl45ELO67UlQIa8IcuZwn3Wb95aoU0VQa5T?=
 =?iso-8859-1?Q?qnop3QTrdJ2YsQvxzvpVK9XzDG32KWTxjOvNXVB0C8HOpQ+WnrxKHwrbbd?=
 =?iso-8859-1?Q?zPJU+s7+rqXnCM/bV7Z0FVdpMO9ew+xVsD/YKWF3YlSLXRF3yOPa2XFhlJ?=
 =?iso-8859-1?Q?F102+Hhpe0bPw8okcVBeKSdFQraZWIDpidplWgMBKa6WhChkeaYK4Gdlc9?=
 =?iso-8859-1?Q?Hrmllmr3lRfRJUNVFWMVPDFQqC/fDaNmFSzUbPEoSoTSw5Sx7EMaUgBwlT?=
 =?iso-8859-1?Q?PWwAb26RSa2qXq6ow5j6UFKWiybKZ16vkvbjPVLN7QvYbCAqfFAO7FlQ1o?=
 =?iso-8859-1?Q?OZftb3pe67V+6VrMqYiTMje5xmfMaXqo0TiU/SWOt6jL7ggdSWmHOAHv4x?=
 =?iso-8859-1?Q?YlLTdh8bm3Qy7N9alI24CFy2wVbh1irYY3ZrNISHF63+YsiToVuED37aBO?=
 =?iso-8859-1?Q?fhLaqLBFNUPVJXylzVuyLwdeCFPPzcWs/3CeJj/Laq5A3TuKe8CfmbiEm2?=
 =?iso-8859-1?Q?mtP+jzLirmo6CqLvt1et3QAs9HcUv1+9Vs9Tox+OxqKhZIXZ0I0DHC2MfI?=
 =?iso-8859-1?Q?ZcwcdK+S+TQC4H+dqHULmrOJFrs2+jirjz6OVYL6SUyjM5z3XYLoEn0IZt?=
 =?iso-8859-1?Q?spL8P6XIBmCFfcip/WTevJPMX0IqFNbbmB6UtKV2KST0SsJd6dvg1aPX3q?=
 =?iso-8859-1?Q?xB8/ejBj/92PBh6aH+Cs7CWB6Ok1yJIrSBncjR0Li7mOInzTyLlHSvWQCh?=
 =?iso-8859-1?Q?z3p93mY+uD7Xu575V9y9EEiQ+NjYC4ikhFWzL9hruerFU+HlDTW0vj14kt?=
 =?iso-8859-1?Q?krEDt7GFaFz4wKrirJzqX1dbHFwcHc3lj92u0nDbf2SA4R6F6/jN6f291/?=
 =?iso-8859-1?Q?4pHU7AmRBeAgyMTEn/Z2dqTPYpKa0p+alFBfd9p+y+XhzPcKbdNzv+Mipu?=
 =?iso-8859-1?Q?0pgiqyzZwcfhc7pYpSaQr9Cx88+mdkaDjKVhRLnxREZFvLFokdo2EBcDND?=
 =?iso-8859-1?Q?aghpquU0+Yo5Wt2C/hjMCKR9uh/S+UXHCSiYkwOawz+E8HYEkBfsrggxyJ?=
 =?iso-8859-1?Q?N6HpD8y1F1VGX6jjK/UZen3xkBN/vK9KISDQUHTh9hqoT2ICSAlPnylVN0?=
 =?iso-8859-1?Q?vYL6nS1fx8SdWjJE20c0MriI7EUf9306QBLK0ZVEZxHlU26agyBYwQvYeA?=
 =?iso-8859-1?Q?ERvR5WDyTvWqRW7ieDUjIh3/fpQcQoDivcLD1Rs3nsKH44A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?KevuHet9exgTfjf7kAWQ3ReaoLECQLqsQVKB2xpDTW65+SuAyqTili5fnU?=
 =?iso-8859-1?Q?6nteYZOqlfOxvUocRqkZOs7iB6CLUENPJYrxBBPSBdHQkwnjnU/dUeblmp?=
 =?iso-8859-1?Q?gwbKeXHsUCC2EL/E1cQznNzdGBZI6Pc84CU9mdx2lyznjmSj8GDqonFboE?=
 =?iso-8859-1?Q?jeMXykklUOzcPLgYdFpR23ehpOLU3wadaCWpmrLao6g3yVkJw5oyEdRy1d?=
 =?iso-8859-1?Q?1h46c+aoBHgxOpTWSca6d1Snl01DZom34gqjDvHBXSVl0VaXwpM3i212Km?=
 =?iso-8859-1?Q?F3MzHd2UuMbX9dgdHM4S4a76d6KNrppt6CC8Osfa8MfcdrrIyV1mQo3lK9?=
 =?iso-8859-1?Q?d8bb0JMci11XFMfweFJB+4yZO3Jb9evhGL0Eaf4baD/45TLCdsgdbWTZOq?=
 =?iso-8859-1?Q?8UJhFW1dS23AYtpuj/VfueaWtUNK2WyP/Us1kQnhIhWo/ra+4SKjZ1z2DB?=
 =?iso-8859-1?Q?aFf2P8Fy43Z1rmmh0b0mPzfjbIjtmSYlUSQalTiyKMV7xWHKbMPdpPLH55?=
 =?iso-8859-1?Q?NjiYhuGFEnD40Znb1N2ZBROdaI8+Zd719GpxTB4Ub2eyiG7OJb1MziPCJ1?=
 =?iso-8859-1?Q?JoC/qIXI4dG3tWnUbo6LVscB6U4cHVACailBdsjzf0CM2S57rlgzswWNkt?=
 =?iso-8859-1?Q?CoIn/RaNmuNPiFYxf3Q3Z5+03Y3/A2H5t1cDytJDNgtRcal4IQXqe6iP1M?=
 =?iso-8859-1?Q?LeTRQkjdiToB36itjXqkYRaMCxThjFJ3K96lI5d2oHU2KeVQyUK2mw7LEQ?=
 =?iso-8859-1?Q?F5crhclwiOBtTRGwqF95ZWLqFFvooZblyLTUIMJL5o2S97cvbD2+cUK8Tc?=
 =?iso-8859-1?Q?d2RNtj47qikoICYlaVd+blABc9hbbb0h/WHimriMoFAkP95DAU26yLhPY3?=
 =?iso-8859-1?Q?kAfGHxA93YKBdX6JhHhn5o/En0/mKZ3vHPPNEtx2sVHOK+Q7sfdGLH+TwX?=
 =?iso-8859-1?Q?XkRIUopa6Re9mZIj69Z/7V5WzQUIzhFJPmITVteaWHfyD8ROspJsOoOvTw?=
 =?iso-8859-1?Q?u4rrtrKvYPm6IkhZ87mWpHId59D4XcQ1wfFJh8Yn65wi4ouB4aemI8IBzJ?=
 =?iso-8859-1?Q?FsEpAJPPzgGI+k4fwsaHeIieTIGGlfdC1oV5aEm1pWttoWO+YG1Z00uKxZ?=
 =?iso-8859-1?Q?mQD+MMxaise3ncWz3KeXk4FFseg4sYL8SKE0np1fq9KlmrYt2Riw+YLqzh?=
 =?iso-8859-1?Q?t99B5i9hh/+y0F1iLn+ahXSJDRqzeTSfb80asi7P0P+ndNcv50sRRBodse?=
 =?iso-8859-1?Q?8seBpHztrCIqFM/GpbPwo8UXAKypUugAKfC6aUyU9jC569VqSc70eeoPM/?=
 =?iso-8859-1?Q?EKeO9p4Gfrkh7C695/8qtKni0dEuYx7YeUkUusHeKyBvPMfRp79GK7Li1l?=
 =?iso-8859-1?Q?MqmgzJRibdNpMgukZ5igXZ63grqxSr1v1dhpUHl0FDaGkwiBRjKaRiizpp?=
 =?iso-8859-1?Q?D0ivI+EYGe/EVJiAPfRMAemuuwgBR33bsOQNxHIwfkITPLVlB0vKCshtLI?=
 =?iso-8859-1?Q?U4DXnE3HggSNGa7AKFi11kI5iNztD1drXV3PyHFX4RMSBpIzcjBU9rkd8p?=
 =?iso-8859-1?Q?C+YgsTYtmo1bs01iwu8bft33xH9fD/d+JfimgvOGf/5JaWWfz87pR7X5tc?=
 =?iso-8859-1?Q?EqqMSCvo8ZoZ0Q7tXyFMnuzqwQoWNrdTWfsgpRgFA3nIzVPrMMTMxHBg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 92e952cc-cc1c-430e-794f-08dcdb9da40f
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 07:02:09.1768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ubqaBuSkb/dag5cZmCr1AJsRQnNfxJWq+h2LmTTaGTKTJ6hBWyBe/p8kpfoHoaQJbhPrRb8pjIsZtgt8ot6HcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4956
X-OriginatorOrg: intel.com



Hello,

FYI. Chenyu (Cced) will post a trial patch soon for below report.


kernel test robot noticed a -13.1% regression of hackbench.throughput on:


commit: 85e511df3cec46021024176672a748008ed135bf ("sched/eevdf: Allow shorter slices to wakeup-preempt")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: hackbench
test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 256G memory
parameters:

	nr_threads: 50%
	iterations: 4
	mode: process
	ipc: socket
	cpufreq_governor: performance



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202409231416.9403c2e9-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240923/202409231416.9403c2e9-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/ipc/iterations/kconfig/mode/nr_threads/rootfs/tbox_group/testcase:
  gcc-12/performance/socket/4/x86_64-rhel-8.3/process/50%/debian-12-x86_64-20240206.cgz/lkp-spr-r02/hackbench

commit: 
  82e9d0456e ("sched/fair: Avoid re-setting virtual deadline on 'migrations'")
  85e511df3c ("sched/eevdf: Allow shorter slices to wakeup-preempt")

82e9d0456e06cebe 85e511df3cec46021024176672a 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    217.40           +13.5%     246.74        uptime.boot
   5391461 ± 19%     +16.5%    6281524 ±  6%  numa-meminfo.node0.MemUsed
    352581 ± 13%     +24.6%     439472 ± 16%  numa-meminfo.node0.SUnreclaim
   4679401           -15.8%    3938145        vmstat.system.cs
    854648           -15.2%     724774        vmstat.system.in
      0.46 ±  2%      -0.1        0.40        mpstat.cpu.all.irq%
      0.03 ±  3%      -0.0        0.03        mpstat.cpu.all.soft%
      3.35            -0.6        2.75        mpstat.cpu.all.usr%
     44542            +2.7%      45755        proc-vmstat.nr_slab_reclaimable
    642130 ± 68%     -71.2%     184909 ± 11%  proc-vmstat.pgactivate
   2170433 ±  2%      +6.8%    2318318 ±  2%  proc-vmstat.pgfault
    138302 ±  4%      +6.7%     147631 ±  3%  proc-vmstat.pgreuse
    623219           -13.1%     541887        hackbench.throughput
    606251           -14.1%     520789        hackbench.throughput_avg
    623219           -13.1%     541887        hackbench.throughput_best
    580034           -14.8%     494354        hackbench.throughput_worst
    174.58           +16.3%     203.09        hackbench.time.elapsed_time
    174.58           +16.3%     203.09        hackbench.time.elapsed_time.max
 1.654e+08            +2.2%   1.69e+08        hackbench.time.involuntary_context_switches
     36869           +17.6%      43340        hackbench.time.system_time
      1172            -5.5%       1107        hackbench.time.user_time
 6.478e+08            -3.5%  6.255e+08        hackbench.time.voluntary_context_switches
 6.354e+10           -11.4%   5.63e+10        perf-stat.i.branch-instructions
 3.226e+08           -12.5%  2.822e+08        perf-stat.i.branch-misses
  94557935 ±  3%     -15.2%   80197744 ±  2%  perf-stat.i.cache-misses
 2.563e+09           -13.7%  2.212e+09        perf-stat.i.cache-references
   4710895           -15.9%    3959720        perf-stat.i.context-switches
      1.86           +14.3%       2.13        perf-stat.i.cpi
    601598           -15.0%     511540        perf-stat.i.cpu-migrations
      7390 ±  5%     +28.4%       9492 ±  2%  perf-stat.i.cycles-between-cache-misses
 3.408e+11           -12.1%  2.997e+11        perf-stat.i.instructions
      0.54           -12.2%       0.47        perf-stat.i.ipc
     23.73           -15.9%      19.95        perf-stat.i.metric.K/sec
      1.66 ± 35%     +28.5%       2.13        perf-stat.overall.cpi
      6006 ± 35%     +33.5%       8020 ±  2%  perf-stat.overall.cycles-between-cache-misses
 5.287e+13 ± 35%     +15.1%  6.083e+13        perf-stat.total.instructions
  13829361           +51.8%   20989754        sched_debug.cfs_rq:/.avg_vruntime.avg
  18756074 ±  5%     +44.2%   27055241 ±  3%  sched_debug.cfs_rq:/.avg_vruntime.max
  12499623 ±  2%     +52.4%   19043277 ±  2%  sched_debug.cfs_rq:/.avg_vruntime.min
      8.93 ±  2%     +14.1%      10.19        sched_debug.cfs_rq:/.h_nr_running.avg
      4.68 ±  3%     +10.0%       5.15 ±  2%  sched_debug.cfs_rq:/.h_nr_running.stddev
      0.44 ± 35%     +75.8%       0.78 ± 19%  sched_debug.cfs_rq:/.load_avg.min
  13829361           +51.8%   20989754        sched_debug.cfs_rq:/.min_vruntime.avg
  18756074 ±  5%     +44.2%   27055241 ±  3%  sched_debug.cfs_rq:/.min_vruntime.max
  12499623 ±  2%     +52.4%   19043277 ±  2%  sched_debug.cfs_rq:/.min_vruntime.min
      0.68           +11.7%       0.76        sched_debug.cfs_rq:/.nr_running.avg
    176.30 ±  3%     -22.8%     136.16 ±  4%  sched_debug.cfs_rq:/.removed.runnable_avg.max
    176.30 ±  3%     -22.8%     136.16 ±  4%  sched_debug.cfs_rq:/.removed.util_avg.max
      8995           +16.0%      10437        sched_debug.cfs_rq:/.runnable_avg.avg
     18978 ±  6%     +13.7%      21579 ±  6%  sched_debug.cfs_rq:/.runnable_avg.max
      2890 ±  4%     +13.9%       3292 ±  3%  sched_debug.cfs_rq:/.runnable_avg.stddev
    415209 ± 22%     -23.3%     318311 ±  3%  sched_debug.cpu.avg_idle.avg
    102333 ±  2%     +30.5%     133496 ±  2%  sched_debug.cpu.clock.avg
    102519 ±  2%     +30.4%     133722 ±  2%  sched_debug.cpu.clock.max
    102127 ±  2%     +30.5%     133254 ±  2%  sched_debug.cpu.clock.min
    101839 ±  2%     +30.5%     132880 ±  2%  sched_debug.cpu.clock_task.avg
    102169 ±  2%     +30.4%     133268 ±  2%  sched_debug.cpu.clock_task.max
     87129 ±  2%     +35.6%     118117 ±  2%  sched_debug.cpu.clock_task.min
     11573           +32.4%      15327        sched_debug.cpu.curr->pid.avg
     14704           +23.9%      18214        sched_debug.cpu.curr->pid.max
      1516 ±  9%     +16.4%       1765 ± 10%  sched_debug.cpu.curr->pid.stddev
      8.92 ±  2%     +14.1%      10.18        sched_debug.cpu.nr_running.avg
      4.69 ±  2%     +10.0%       5.16 ±  2%  sched_debug.cpu.nr_running.stddev
   1232815 ±  2%     +27.3%    1569099        sched_debug.cpu.nr_switches.avg
   1411362 ±  5%     +26.8%    1789325 ±  3%  sched_debug.cpu.nr_switches.max
   1045767 ±  2%     +27.3%    1331341 ±  3%  sched_debug.cpu.nr_switches.min
    102127 ±  2%     +30.5%     133250 ±  2%  sched_debug.cpu_clk
    101071 ±  2%     +30.8%     132194 ±  2%  sched_debug.ktime
      0.00           -25.0%       0.00        sched_debug.rt_rq:.rt_nr_running.avg
      0.33           -25.0%       0.25        sched_debug.rt_rq:.rt_nr_running.max
      0.02           -25.0%       0.02        sched_debug.rt_rq:.rt_nr_running.stddev
    102997 ±  2%     +30.2%     134142 ±  2%  sched_debug.sched_clk
  16347631          +100.0%   32695263        sched_debug.sysctl_sched.sysctl_sched_features
      1.60 ±  2%      -0.1        1.45 ±  5%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.read
      1.50 ±  2%      -0.1        1.36 ±  6%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.write
      0.62 ±  2%      -0.1        0.50 ± 38%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_up_common
      0.78 ±  2%      -0.1        0.71 ±  7%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_sync_key
     39.00            +0.5       39.50        perf-profile.calltrace.cycles-pp.sock_write_iter.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     37.56            +0.6       38.15        perf-profile.calltrace.cycles-pp.unix_stream_sendmsg.sock_write_iter.vfs_write.ksys_write.do_syscall_64
      1.77 ±  2%      -0.2        1.61 ±  5%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      1.87 ±  2%      -0.2        1.72 ±  5%  perf-profile.children.cycles-pp.mod_objcg_state
      0.90 ±  2%      -0.1        0.83 ±  5%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.85 ±  2%      -0.1        0.78 ±  5%  perf-profile.children.cycles-pp.obj_cgroup_charge
      0.10 ±  4%      -0.1        0.04 ±104%  perf-profile.children.cycles-pp.__handle_mm_fault
      0.10 ±  4%      -0.1        0.04 ±104%  perf-profile.children.cycles-pp.handle_mm_fault
      0.10 ±  4%      -0.1        0.04 ±102%  perf-profile.children.cycles-pp.do_user_addr_fault
      0.10 ±  4%      -0.1        0.04 ±102%  perf-profile.children.cycles-pp.exc_page_fault
      0.63 ±  2%      -0.1        0.57 ±  5%  perf-profile.children.cycles-pp.__cond_resched
      0.10 ±  4%      -0.0        0.05 ± 63%  perf-profile.children.cycles-pp.asm_exc_page_fault
      0.32 ±  2%      -0.0        0.28 ±  3%  perf-profile.children.cycles-pp.task_mm_cid_work
      0.32 ±  2%      -0.0        0.28 ±  3%  perf-profile.children.cycles-pp.task_work_run
      0.34 ±  2%      -0.0        0.30 ±  5%  perf-profile.children.cycles-pp.rcu_all_qs
      0.32 ±  3%      -0.0        0.29 ±  6%  perf-profile.children.cycles-pp.__virt_addr_valid
      0.18 ±  4%      -0.0        0.16 ±  7%  perf-profile.children.cycles-pp.__enqueue_entity
      0.23 ±  3%      -0.0        0.21 ±  6%  perf-profile.children.cycles-pp.set_next_entity
      0.14 ±  4%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.__dequeue_entity
      0.06            -0.0        0.05        perf-profile.children.cycles-pp.cpuacct_charge
      0.09 ±  8%      +0.0        0.12 ±  7%  perf-profile.children.cycles-pp.generic_perform_write
      0.07 ± 10%      +0.0        0.10 ± 11%  perf-profile.children.cycles-pp.sched_balance_find_src_group
      0.06 ± 10%      +0.0        0.09 ± 11%  perf-profile.children.cycles-pp.update_sg_lb_stats
      0.07 ± 10%      +0.0        0.10 ± 11%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.13 ±  8%      +0.0        0.16 ±  8%  perf-profile.children.cycles-pp.writen
      0.02 ±111%      +0.0        0.06 ± 13%  perf-profile.children.cycles-pp.set_task_cpu
      0.02 ±141%      +0.0        0.06 ± 11%  perf-profile.children.cycles-pp.ring_buffer_read_head
      0.00            +0.1        0.06 ±  8%  perf-profile.children.cycles-pp.vruntime_eligible
      0.22 ±  8%      +0.1        0.28 ±  9%  perf-profile.children.cycles-pp.perf_mmap__push
      0.23 ±  8%      +0.1        0.29 ±  9%  perf-profile.children.cycles-pp.record__mmap_read_evlist
      0.23 ±  7%      +0.1        0.29 ±  9%  perf-profile.children.cycles-pp.cmd_record
      0.23 ±  7%      +0.1        0.30 ±  9%  perf-profile.children.cycles-pp.handle_internal_command
      0.23 ±  7%      +0.1        0.30 ±  9%  perf-profile.children.cycles-pp.main
      0.23 ±  7%      +0.1        0.30 ±  9%  perf-profile.children.cycles-pp.run_builtin
      0.00            +0.1        0.07 ± 19%  perf-profile.children.cycles-pp.schedule_idle
      0.00            +0.1        0.12 ± 19%  perf-profile.children.cycles-pp.flush_smp_call_function_queue
      0.00            +0.1        0.14 ± 20%  perf-profile.children.cycles-pp.sched_ttwu_pending
      0.00            +0.2        0.15 ± 17%  perf-profile.children.cycles-pp.intel_idle
      0.00            +0.2        0.17 ± 18%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      0.01 ±282%      +0.2        0.18 ± 70%  perf-profile.children.cycles-pp.available_idle_cpu
      0.23 ±  3%      +0.2        0.43 ± 16%  perf-profile.children.cycles-pp.prepare_to_wait
      0.00            +0.2        0.20 ± 18%  perf-profile.children.cycles-pp.cpuidle_enter
      0.00            +0.2        0.20 ± 18%  perf-profile.children.cycles-pp.cpuidle_enter_state
      0.01 ±282%      +0.2        0.22 ± 16%  perf-profile.children.cycles-pp.cpuidle_idle_call
      0.00            +0.3        0.35 ±110%  perf-profile.children.cycles-pp.select_idle_cpu
      0.06 ±  6%      +0.4        0.41 ± 95%  perf-profile.children.cycles-pp.select_idle_sibling
      0.22 ±  2%      +0.4        0.57 ± 70%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.26 ±  5%      +0.4        0.62 ± 65%  perf-profile.children.cycles-pp.select_task_rq
      0.04 ± 77%      +0.4        0.43 ± 18%  perf-profile.children.cycles-pp.start_secondary
      0.04 ± 77%      +0.4        0.43 ± 18%  perf-profile.children.cycles-pp.do_idle
      0.04 ± 77%      +0.4        0.43 ± 17%  perf-profile.children.cycles-pp.common_startup_64
      0.04 ± 77%      +0.4        0.43 ± 17%  perf-profile.children.cycles-pp.cpu_startup_entry
     40.28            +0.4       40.71        perf-profile.children.cycles-pp.vfs_write
     39.04            +0.5       39.54        perf-profile.children.cycles-pp.sock_write_iter
     37.73            +0.6       38.31        perf-profile.children.cycles-pp.unix_stream_sendmsg
      1.50 ±  2%      -0.1        1.37 ±  5%  perf-profile.self.cycles-pp.mod_objcg_state
      1.41 ±  2%      -0.1        1.30 ±  5%  perf-profile.self.cycles-pp.kmem_cache_free
      0.83 ±  3%      -0.1        0.74 ±  5%  perf-profile.self.cycles-pp.read
      0.88 ±  2%      -0.1        0.80 ±  5%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.74 ±  2%      -0.1        0.67 ±  5%  perf-profile.self.cycles-pp.write
      0.70 ±  2%      -0.1        0.64 ±  6%  perf-profile.self.cycles-pp.vfs_read
      0.67 ±  2%      -0.1        0.61 ±  5%  perf-profile.self.cycles-pp.vfs_write
      0.67 ±  2%      -0.1        0.62 ±  4%  perf-profile.self.cycles-pp.__kmalloc_node_track_caller_noprof
      0.52 ±  3%      -0.1        0.47 ±  4%  perf-profile.self.cycles-pp.obj_cgroup_charge
      0.51 ±  2%      -0.0        0.46 ±  5%  perf-profile.self.cycles-pp.kmem_cache_alloc_node_noprof
      0.29 ±  2%      -0.0        0.25 ±  3%  perf-profile.self.cycles-pp.task_mm_cid_work
      0.43 ±  2%      -0.0        0.40 ±  4%  perf-profile.self.cycles-pp.do_syscall_64
      0.34 ±  3%      -0.0        0.31 ±  6%  perf-profile.self.cycles-pp.__skb_datagram_iter
      0.29 ±  2%      -0.0        0.26 ±  6%  perf-profile.self.cycles-pp.__virt_addr_valid
      0.33 ±  2%      -0.0        0.30 ±  6%  perf-profile.self.cycles-pp.__cond_resched
      0.28 ±  3%      -0.0        0.25 ±  5%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.37 ±  2%      -0.0        0.34 ±  6%  perf-profile.self.cycles-pp.__check_object_size
      0.18 ±  5%      -0.0        0.15 ±  6%  perf-profile.self.cycles-pp.__enqueue_entity
      0.21 ±  3%      -0.0        0.18 ±  6%  perf-profile.self.cycles-pp.rcu_all_qs
      0.22 ±  3%      -0.0        0.20 ±  6%  perf-profile.self.cycles-pp.x64_sys_call
      0.19 ±  2%      -0.0        0.17 ±  6%  perf-profile.self.cycles-pp.rw_verify_area
      0.05            +0.0        0.08 ± 23%  perf-profile.self.cycles-pp.update_rq_clock
      0.00            +0.1        0.06 ± 11%  perf-profile.self.cycles-pp.ring_buffer_read_head
      0.00            +0.2        0.15 ± 17%  perf-profile.self.cycles-pp.intel_idle
      0.01 ±282%      +0.2        0.18 ± 70%  perf-profile.self.cycles-pp.available_idle_cpu



Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


