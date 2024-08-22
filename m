Return-Path: <linux-kernel+bounces-296621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C4095ACE1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 07:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E86DAB2194D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 05:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCAB62E64B;
	Thu, 22 Aug 2024 05:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K2PnahK1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AB92E3EE
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 05:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724304660; cv=fail; b=if8trknYyHTaqgHcTXZ9M/fa6HPk57Rrx6Fo5R7dFNeCT70H/tpz51BA+F9wZkZG/hRwEaGY8F7RLgjt0YtsEweAP/sazqNmXOWU483AY6Ze5RwZ6Tk+02VJ1ERtVksT+44hxfvCSRBvGnHoYkf8MY/FQYiMVZAika9Mrl6BUgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724304660; c=relaxed/simple;
	bh=w4zqRr+Avzwpu2KEYiI/8/voTHF49d/6eQ772jiC7fI=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=ZhlEB6ZLg0Uf81bsOYADGtkdD4C2Ef8V16D3t9Z9PnEyJB5PhTRuBbL3oX4dRFwIgqsyvnlXEmEnUzAaW6+y8mp7qflOjBe9eSWq6/qy/X+IJl82DSpj8iUI9LOihGT0QbYzyt2yWLWwRqsgL744dD2FT8Ic5tx07ZfiLO2RuuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K2PnahK1; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724304657; x=1755840657;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=w4zqRr+Avzwpu2KEYiI/8/voTHF49d/6eQ772jiC7fI=;
  b=K2PnahK10R2dZvGxyKJEu3cWknOhzi4oe/5c6IBNSxi6LihSg6wbWfhO
   yQnBrvxcIzFfv2/CPcNvEPj3G2UjZUSedKkFOLE7aBClwuu5iKR4JMt4j
   oV4L3GlvMJTefNNOHsqyaMSqMPKBvllE7MEg0s5CUW95bOwZ3feMZzUX4
   nlPOW7vmsbpQeLCqkDLjNbbtoSP6pjD2QRDHiEGlNVfRp6vdIGYAUM0sn
   YS67RNAmSXGd58p7rTD4rMZ30CHq3V1JBOFplwkbdOPzG9lSVkAn0wOxk
   2wPo0pixefxGE0u7p1ZQ6ljJYfgH5lVD8aG8DzWJIJc95BPkxZCzrpksI
   w==;
X-CSE-ConnectionGUID: 4yT1OSYmRBurm7L0Ht++tA==
X-CSE-MsgGUID: hGSkpOznR1u/a3ZJILW6dA==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="25593086"
X-IronPort-AV: E=Sophos;i="6.10,166,1719903600"; 
   d="scan'208";a="25593086"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 22:30:56 -0700
X-CSE-ConnectionGUID: M5pyPu4uTI2tCA5zxVVjTg==
X-CSE-MsgGUID: upx5Q+ncQSKJArGnDUHIuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,166,1719903600"; 
   d="scan'208";a="92118604"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Aug 2024 22:30:56 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 21 Aug 2024 22:30:55 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 21 Aug 2024 22:30:55 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 21 Aug 2024 22:30:55 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.49) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 21 Aug 2024 22:30:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y6oOHKqgkCqgb4iicgD4vN29SCIeu00uVsf68O1Z25dvv+zUB0iaK6AUR0ck4Cjqsxj4vSSS7Qjb9PiThfn/viKdRoV9af1gW0nSzf0i97P4ByZH0danFnysapoYWg+ual9NtqbMjFHyJoMHw3/LwOtDkehM/y9zlA+kmRvkhyXoYxqtznPwFDXL58Rkh6M89AW64P5qoWELIVj67sExTtuER0jnrDvaDgq8hk8fCaeiqd98sQDaSjgHp66t23sd7RBKXbradMEdIz+led0/LJMa8gvlA1GZGkf/iqNU/NpRxvDzOEnCav2iws0p+mV7P9H4oFCU9/YFRZLW29EUdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tkSbCKT+5dX/N2wcpwdRuFSjAkhgo37o883iTMEgrvw=;
 b=vvyV5UjM1YbflE+3JIZ29pcoBONF45WAf55otK2nlZ2xFTEEB60er0T0NcFwKzXIPePOMR5ElrEmcACFiod7QspWW0CIaEMCQkqdO0qQAQX5PfF41banx9RbbmZrljDXu3L4tg6gKXJQb6NiypOVQT6KTjZDIojygO2mz1stNP1tgWggFN9BvfSujWFrPctDj9/VlFTsxzKxKUjPcKjKZaCU6IDIZeFCOxkgrM5HVsVEq4PP+dRoPhzd16Ka/RUGgUbEp76bVGbCK6WH5LCvs9Fa41X8FVL/w3nWKlvTTh4e7R+UGa4dA6yL60TvSOfEgqrVr/v/50UbC77bJE5sgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ0PR11MB5086.namprd11.prod.outlook.com (2603:10b6:a03:2d1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Thu, 22 Aug
 2024 05:30:47 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 05:30:46 +0000
Date: Thu, 22 Aug 2024 13:30:36 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Zhang Qiao <zhangqiao22@huawei.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	<ying.huang@intel.com>, <feng.tang@intel.com>, <fengwei.yin@intel.com>,
	<aubrey.li@linux.intel.com>, <yu.c.chen@intel.com>, <oliver.sang@intel.com>
Subject: [tip:sched/core] [sched]  c40dd90ac0:
 stress-ng.mlockmany.ops_per_sec 6.9% improvement
Message-ID: <202408221014.cf0a2408-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:3:18::28) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ0PR11MB5086:EE_
X-MS-Office365-Filtering-Correlation-Id: 618a3e74-8caf-4cf3-87a8-08dcc26b932a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?FFS4FXvw+HA7zxUeyWamKoCrbWDK7YfcOjJNPlNOP7KHcCxCcvCJXA5NYW?=
 =?iso-8859-1?Q?wPdG+kc/YICdwuDvXYrNsDIQ6dledveUkARBawILqhfSrfSNIc1pd643Ig?=
 =?iso-8859-1?Q?bMm4xE9EOmiMJoUhApVj5pJ97pGnL0B7HXDxdlQHK1XnRjSxo9xdeFZRGf?=
 =?iso-8859-1?Q?rEEX5l8gLvlJWyLRVTMDrmoFoGGLM/mu1JtJqAh4M+l+EYGatzrWiNUI1W?=
 =?iso-8859-1?Q?N9dsN3Bb9A437iUTxFVaLdSLH9mHhbcyA/OyQOTl5l4rIwUXW4MiDvZi15?=
 =?iso-8859-1?Q?BbQc4foX8YGo6Bm870qIrq57MfVp7w/HH4nNRuAsqdTNcp5zqoY0R5mIy2?=
 =?iso-8859-1?Q?NIcoGpwDXBg2wWd1ncKOJmaeigoVSUDveDsr/xLSbUOH8zSpcNnXWW5TVc?=
 =?iso-8859-1?Q?ypA01p/V1B1PfY2BjQwNeZznASK8IIWAK+qUxeYqtdiEv6vForxmRPzMab?=
 =?iso-8859-1?Q?mti2/2cmyf6OsCSFJW38OXNY1Rin3bFgoMn9ZIwYkU9s5VRAhcCcA3Kqct?=
 =?iso-8859-1?Q?CBEnuHL/+oFFPuYOVHfi9Lmcm8Na9eNwiFaRn/XMZ+3f1H3w/nvuh0uE+q?=
 =?iso-8859-1?Q?5L7W2pCiiaQJMLTlEyougF3fV8L70FJA+XEYVZLbLc/qUibiXAy3PjJmsy?=
 =?iso-8859-1?Q?8j8s47IHBdRuUk8j5UG9T8VG7fm/VK/7rlsQCbfo4gvF9lM+GqshB11G91?=
 =?iso-8859-1?Q?6gLvO05sK91ou6oeCRlyg1t5S/FAnzIPZQnqUu+r38R45k9xzJB9nefju+?=
 =?iso-8859-1?Q?iknGcbz7ev+eLf8Vuga1jcLkCFY2cv0IFQUDBrK5ciX0QBtnTXm2UKk7Jx?=
 =?iso-8859-1?Q?488mY4oxh1wS0UDh+Iqq1rtAgwxIvaCOe62BTovPKK+HCvjX0UVUtI8mmr?=
 =?iso-8859-1?Q?p7a/+w+MZocVPEnhsQaOQdJpNVzO1EHy/DXM9varKCHukhAJ80bQ20H6eE?=
 =?iso-8859-1?Q?08rmQH2wfXCnE13UvbDceaB+yxq08O7KNokTLe/Sc1+Eq+h3gn8yQTSm34?=
 =?iso-8859-1?Q?8dI6Dp96NXG26WLKwXr3+RTN1BRgA/xaT5rk5o57lLet/JyJ2lBdqwnx+4?=
 =?iso-8859-1?Q?yXmslbLbCqCgO1WLWRhooOKCOYWR6tQdPlyinU4AueVQobRppJN+lGe7eg?=
 =?iso-8859-1?Q?QrXlzFgO1Mt5kJkNnvMoNGWVYCl/LXnrAlkRlOAnhAbcuwBP/CYbRPnq1d?=
 =?iso-8859-1?Q?X3avANyw7xY/sSaxF1gGi+qYJd9KkMOcAlMjtMaIAJfsK1nr+pOljV+lpz?=
 =?iso-8859-1?Q?0MwsvC1Q0EmN1pHR7SepoKZ5/BDKpB79c+uVlozcr2oyWI6K2QSOMI+uco?=
 =?iso-8859-1?Q?a4670EwGemuuyWal064+IdQAUV/T4Op+HzQ3fcf1A2tXly+9FLWTuZS3gk?=
 =?iso-8859-1?Q?YW0kSWMly8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?shjcjmI4B6buDfM4C0NT9SgiUSf8SDYyi8myLRvChN4bVXWAyP+gEmXaLH?=
 =?iso-8859-1?Q?hvSg/iV95Sl+AsSWjzxpcHkL+Z4YCzyFRfdASXQYvQVUiN7r6KktAv2Sih?=
 =?iso-8859-1?Q?MNm2g2WLnyFhQ3FkekH+xM9ptWzjFSRldSLcKa71ghWDSXA46SSZPR8hS5?=
 =?iso-8859-1?Q?bt1OpzGHL34IrMZ7CtoZJyy4I24MtyQhGpeznJY1F1eSMDT8KrmzfKXfwU?=
 =?iso-8859-1?Q?iV7eSVZmd4kAm4BvNfxGs/Ap8YLW67WjTROdnYYhhgXroHc+m3ozxEK4GF?=
 =?iso-8859-1?Q?Hn1ZqMpiC5LNKipZll7Z4rcnGwkQgJzHWiiQA33GfmHkiEuYJLScOM0uHk?=
 =?iso-8859-1?Q?eq2M3FemZSni8fk2KxDewdEzM0QRToSX2L6m7MsxjKZ3+S8SklVrV2EKp4?=
 =?iso-8859-1?Q?+IfMUXE22ts3ArpC7hQRVh7/z6tDoQVjPhYfdl/5Xer0uZUC9cSWrJn8RG?=
 =?iso-8859-1?Q?blGL9dywDzz3hAvMZu41B6T3MGajFMx+1I90h53Cd8ffX2Zi5lr5mQQk7j?=
 =?iso-8859-1?Q?ZDm6O4Ui1r7qsd9HlNwk68iFWYPK/G8PJcVmXZxofw01uoRcC3H1TPnfYD?=
 =?iso-8859-1?Q?etxMSjWXz6wE+0X4HtcDGh1hMp7vSvF5veST3WzgTIkVRlDXmRXozphMsl?=
 =?iso-8859-1?Q?334kaq4WThlqorMxL/ZKSyipAHvlss1iB1g25FdoHrQFoXOpbwLojz0Fe0?=
 =?iso-8859-1?Q?OsdrfXprVGQVOxS11rjm++E3xu3xbFsgLGYgqfNh0YkUkKWUWTh6kexMPG?=
 =?iso-8859-1?Q?SpgcXVBCo955qL4IvJHO8Z1kx2uIBLmI0D5iV7ywANIFE9McevNZnrafKL?=
 =?iso-8859-1?Q?tjgLjuYHtB78D2xtv/APeLAsmngzNoZ/J+gm7vLmYamilR06xeyvCAPKeR?=
 =?iso-8859-1?Q?htxRCaOewxdaG7fSMpdCaraGil0b5gBagQC2IHzzzNAtP/W3uHQJP25H8Q?=
 =?iso-8859-1?Q?caEPATAAnBdal0TvigZfBt3vadNZDBvJbhPkQ1/GfjIcCx/3kk5KpfZMof?=
 =?iso-8859-1?Q?HbziYirWMqndEbrt/756LemOLyMm194teoFUMvtuTjp4MrYdd3swI6Eodh?=
 =?iso-8859-1?Q?ecy2ra3TOX0gxMt7qa4nEMUDxH1zSC7ijL0WUhgzF558+2EA8M9ITQoUBF?=
 =?iso-8859-1?Q?JyMaOWQ06LlWq6SfV2b6GLzMkTUcuuGTJ1cCKBV0BpQTj3UUzFS2g3zRki?=
 =?iso-8859-1?Q?j4yPgIV3PKzO8vvVmJA/pWFUrH3Aqpgfg5qkAuRiR//RnCGpAiGcF1NqZi?=
 =?iso-8859-1?Q?e0V3+Lxkx+r8vFTivQoMnmzS12VwTCn0YbU4gaCbYJnDA2L5cBkpsh2FFY?=
 =?iso-8859-1?Q?AzZ/fOEKmRgWmWD1LiQ6YNP4D0Z3lwy2yXVBHJQ3x5X1q+3D82iiEdTVU+?=
 =?iso-8859-1?Q?4tEUp5VFl9fluTkiSFzLd9AVu87jKjv8UWScqVBTkOFAxsPI8WxBTEBi9W?=
 =?iso-8859-1?Q?mSWJSsLwUW3Znf4/OuTfNVRcm7ruXQG1i7bjGEBLkWuWU8myY5O3/9Pv6e?=
 =?iso-8859-1?Q?re00VUxOnB5jN413ccmRFzSLuYaTjWWl7rrs6St/iLIwoQmCfvdL6uuXED?=
 =?iso-8859-1?Q?uUmXFcyOOEj8zqF+v7scubjRhfyVr0/f+ub8oas69/2QL1oOS0QPFnm2eg?=
 =?iso-8859-1?Q?tMkhR9EnTRq67PWjo+2nadPbz2BedovTjN6sa3kcKtgQqkW7g016l2IQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 618a3e74-8caf-4cf3-87a8-08dcc26b932a
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 05:30:46.7777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hAOvhdEQLhtC0rLA2cjoYGWJrhvzmGs7GvgQ8Qky2PxifN/qRN3ng+0jANslw9+6Gg4coCDdyv33f+pAEjU7WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5086
X-OriginatorOrg: intel.com



Hello,

Chen Yu (Cced) helped review this result and gave us below information:

Firstly, it seems that this commit has increased the context switch ratio per
the test. And the overloaded stress-ng.mlockmany prefers more context switch
according to the test score.

Secondly, the mlockmany is to stress the forking and exiting, and this commit
has fixed the vruntime for task forking, so I think this commit is firstly a
fix, and the subsequent performance improvement is a 'side-effect'.

thanks a lot, Chen Yu!


below is full report FYI.


kernel test robot noticed a 6.9% improvement of stress-ng.mlockmany.ops_per_sec on:


commit: c40dd90ac045fa1fdf6acc5bf9109a2315e6c92c ("sched: Initialize the vruntime of a new task when it is first enqueued")
https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git sched/core

testcase: stress-ng
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: mlockmany
	cpufreq_governor: performance






Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240822/202408221014.cf0a2408-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp7/mlockmany/stress-ng/60s

commit: 
  fe7a11c78d ("sched/core: Fix unbalance set_rq_online/offline() in sched_cpu_deactivate()")
  c40dd90ac0 ("sched: Initialize the vruntime of a new task when it is first enqueued")

fe7a11c78d2a9bdb c40dd90ac045fa1fdf6acc5bf91 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      0.33 ±  6%      +0.1        0.39 ±  4%  mpstat.cpu.all.soft%
     24850           +12.5%      27952        vmstat.system.cs
    321532 ±  3%      -5.1%     305193 ±  2%  proc-vmstat.nr_mlock
   1094291            -1.5%    1077939        proc-vmstat.nr_unevictable
   1094289            -1.5%    1077939        proc-vmstat.nr_zone_unevictable
      1203 ±  7%     +14.6%       1378 ±  5%  sched_debug.cfs_rq:/.util_avg.max
    124070 ±  4%      +8.4%     134473 ±  2%  sched_debug.cpu.curr->pid.avg
     11329 ±  3%     +10.4%      12512 ±  4%  sched_debug.cpu.nr_switches.min
    269151            +6.9%     287597        stress-ng.mlockmany.ops
      4482            +6.9%       4789        stress-ng.mlockmany.ops_per_sec
   1013700           +13.7%    1152838        stress-ng.time.involuntary_context_switches
    321785            +6.0%     341166        stress-ng.time.voluntary_context_switches
      0.24            +0.0        0.26 ±  3%  perf-stat.i.branch-miss-rate%
  22351186            +8.7%   24290613 ±  3%  perf-stat.i.branch-misses
     78.51            -0.9       77.60        perf-stat.i.cache-miss-rate%
     25668           +11.8%      28695        perf-stat.i.context-switches
      8.46 ±  2%      +8.5%       9.18 ±  2%  perf-stat.i.metric.K/sec
    271097 ±  2%      +8.5%     294019 ±  2%  perf-stat.i.minor-faults
    271098 ±  2%      +8.5%     294022 ±  2%  perf-stat.i.page-faults
      0.20 ± 44%      +0.1        0.26 ±  3%  perf-stat.overall.branch-miss-rate%
  18381669 ± 44%     +30.8%   24045151 ±  3%  perf-stat.ps.branch-misses
     20985 ± 44%     +34.2%      28161        perf-stat.ps.context-switches
      1289 ± 44%     +23.5%       1591        perf-stat.ps.cpu-migrations
    221777 ± 44%     +30.5%     289386 ±  2%  perf-stat.ps.minor-faults
    221778 ± 44%     +30.5%     289389 ±  2%  perf-stat.ps.page-faults
 2.409e+12 ± 44%     +21.0%  2.915e+12        perf-stat.total.instructions
     23.29            -1.1       22.21 ±  2%  perf-profile.calltrace.cycles-pp.mlock_drain_local.populate_vma_page_range.__mm_populate.do_mlock.__x64_sys_mlock
     23.14            -1.1       22.06 ±  2%  perf-profile.calltrace.cycles-pp.mlock_folio_batch.mlock_drain_local.populate_vma_page_range.__mm_populate.do_mlock
     22.98            -1.1       21.90 ±  2%  perf-profile.calltrace.cycles-pp.__mlock_new_folio.mlock_folio_batch.mlock_drain_local.populate_vma_page_range.__mm_populate
     22.37            -1.1       21.30 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.folio_lruvec_lock_irq.__mlock_new_folio.mlock_folio_batch.mlock_drain_local
     22.37            -1.1       21.31 ±  2%  perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irq.__mlock_new_folio.mlock_folio_batch.mlock_drain_local.populate_vma_page_range
     22.27            -1.1       21.21 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.folio_lruvec_lock_irq.__mlock_new_folio.mlock_folio_batch
     46.09            -0.7       45.36        perf-profile.calltrace.cycles-pp.__x64_sys_mlock.do_syscall_64.entry_SYSCALL_64_after_hwframe.mlock
     46.09            -0.7       45.36        perf-profile.calltrace.cycles-pp.do_mlock.__x64_sys_mlock.do_syscall_64.entry_SYSCALL_64_after_hwframe.mlock
     46.30            -0.7       45.62        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.mlock
     46.31            -0.7       45.62        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.mlock
     46.38            -0.7       45.70        perf-profile.calltrace.cycles-pp.mlock
      0.56            +0.0        0.60        perf-profile.calltrace.cycles-pp.copy_present_ptes.copy_pte_range.copy_p4d_range.copy_page_range.dup_mmap
      0.65 ±  2%      +0.1        0.70 ±  2%  perf-profile.calltrace.cycles-pp.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault
      0.67 ±  3%      +0.1        0.72 ±  2%  perf-profile.calltrace.cycles-pp.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.67 ±  2%      +0.1        0.72        perf-profile.calltrace.cycles-pp.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      0.74 ±  3%      +0.1        0.80        perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.76 ±  3%      +0.1        0.83        perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.86 ±  2%      +0.1        0.93        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault
      0.86 ±  2%      +0.1        0.93        perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.90 ±  2%      +0.1        0.98        perf-profile.calltrace.cycles-pp.asm_exc_page_fault
      1.15            +0.1        1.23 ±  2%  perf-profile.calltrace.cycles-pp.anon_vma_interval_tree_insert.anon_vma_clone.anon_vma_fork.dup_mmap.dup_mm
      0.88 ±  3%      +0.1        0.97        perf-profile.calltrace.cycles-pp.copy_pte_range.copy_p4d_range.copy_page_range.dup_mmap.dup_mm
      1.17            +0.1        1.26        perf-profile.calltrace.cycles-pp.unlink_anon_vmas.free_pgtables.exit_mmap.mmput.exit_mm
      1.04 ±  4%      +0.1        1.15        perf-profile.calltrace.cycles-pp.copy_p4d_range.copy_page_range.dup_mmap.dup_mm.copy_process
      1.06 ±  3%      +0.1        1.17        perf-profile.calltrace.cycles-pp.copy_page_range.dup_mmap.dup_mm.copy_process.kernel_clone
      1.84            +0.1        1.98 ±  2%  perf-profile.calltrace.cycles-pp.anon_vma_clone.anon_vma_fork.dup_mmap.dup_mm.copy_process
      1.89            +0.1        2.02 ±  2%  perf-profile.calltrace.cycles-pp.free_pgtables.exit_mmap.mmput.exit_mm.do_exit
      2.30 ±  2%      +0.2        2.46 ±  2%  perf-profile.calltrace.cycles-pp.anon_vma_fork.dup_mmap.dup_mm.copy_process.kernel_clone
      2.23            +0.2        2.40 ±  2%  perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap
      2.29            +0.2        2.47 ±  2%  perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.exit_mmap.mmput.exit_mm
      2.26            +0.2        2.44 ±  2%  perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap.mmput
      2.46            +0.2        2.66 ±  2%  perf-profile.calltrace.cycles-pp.unmap_vmas.exit_mmap.mmput.exit_mm.do_exit
      0.26 ±100%      +0.3        0.54        perf-profile.calltrace.cycles-pp.next_uptodate_folio.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault
      5.10 ±  2%      +0.4        5.55 ±  2%  perf-profile.calltrace.cycles-pp.dup_mmap.dup_mm.copy_process.kernel_clone.__do_sys_clone
      5.98 ±  2%      +0.5        6.45 ±  2%  perf-profile.calltrace.cycles-pp._Fork
      5.32 ±  2%      +0.5        5.79 ±  2%  perf-profile.calltrace.cycles-pp.dup_mm.copy_process.kernel_clone.__do_sys_clone.do_syscall_64
      5.78 ±  2%      +0.5        6.26 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe._Fork
      5.78 ±  2%      +0.5        6.26 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe._Fork
      5.62 ±  2%      +0.5        6.11 ±  2%  perf-profile.calltrace.cycles-pp.copy_process.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.73 ±  2%      +0.5        6.23 ±  2%  perf-profile.calltrace.cycles-pp.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe._Fork
      5.73 ±  2%      +0.5        6.23 ±  2%  perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe._Fork
      7.30 ±  2%      +0.5        7.83 ±  2%  perf-profile.calltrace.cycles-pp.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      7.42 ±  2%      +0.5        7.96 ±  2%  perf-profile.calltrace.cycles-pp.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.41 ±  2%      +0.5        7.95 ±  2%  perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.41 ±  2%      +0.5        7.95 ±  2%  perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call.do_syscall_64
      7.41 ±  2%      +0.5        7.95 ±  2%  perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.10            +0.5        7.65 ±  2%  perf-profile.calltrace.cycles-pp.exit_mmap.mmput.exit_mm.do_exit.do_group_exit
      7.43 ±  2%      +0.5        7.97 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.43 ±  2%      +0.5        7.97 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
      7.12 ±  2%      +0.5        7.66 ±  2%  perf-profile.calltrace.cycles-pp.mmput.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group
     23.15            -1.0       22.12 ±  2%  perf-profile.children.cycles-pp.__mlock_new_folio
     46.09            -0.7       45.36        perf-profile.children.cycles-pp.__x64_sys_mlock
     46.09            -0.7       45.36        perf-profile.children.cycles-pp.do_mlock
     46.40            -0.7       45.72        perf-profile.children.cycles-pp.mlock
     96.89            -0.2       96.67        perf-profile.children.cycles-pp.do_syscall_64
     96.90            -0.2       96.68        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.13 ±  4%      -0.0        0.11        perf-profile.children.cycles-pp.schedule_tail
      0.08 ±  5%      +0.0        0.10 ±  5%  perf-profile.children.cycles-pp.__wp_page_copy_user
      0.14 ±  3%      +0.0        0.15        perf-profile.children.cycles-pp.obj_cgroup_charge
      0.15 ±  3%      +0.0        0.16        perf-profile.children.cycles-pp.mas_find
      0.23 ±  6%      +0.0        0.25 ±  4%  perf-profile.children.cycles-pp.___slab_alloc
      0.25 ±  3%      +0.0        0.28 ±  2%  perf-profile.children.cycles-pp.__rb_insert_augmented
      0.34 ±  2%      +0.0        0.37 ±  2%  perf-profile.children.cycles-pp.mod_objcg_state
      0.45            +0.0        0.48 ±  2%  perf-profile.children.cycles-pp.__memcg_slab_free_hook
      0.24 ±  5%      +0.0        0.28 ±  6%  perf-profile.children.cycles-pp.wp_page_copy
      0.32            +0.0        0.36        perf-profile.children.cycles-pp.up_write
      0.56 ±  2%      +0.0        0.61        perf-profile.children.cycles-pp.copy_present_ptes
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.__put_user_4
      0.86            +0.1        0.92        perf-profile.children.cycles-pp.lru_add_drain
      0.85            +0.1        0.91        perf-profile.children.cycles-pp.folio_batch_move_lru
      0.85            +0.1        0.92        perf-profile.children.cycles-pp.lru_add_drain_cpu
      0.99 ±  3%      +0.1        1.06 ±  3%  perf-profile.children.cycles-pp.next_uptodate_folio
      0.20            +0.1        0.27        perf-profile.children.cycles-pp.do_wp_page
      0.36 ±  2%      +0.1        0.43 ±  3%  perf-profile.children.cycles-pp.__libc_fork
      0.92 ±  2%      +0.1        0.99        perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
      1.05            +0.1        1.12        perf-profile.children.cycles-pp.down_write
      1.28 ±  3%      +0.1        1.35 ±  3%  perf-profile.children.cycles-pp.filemap_map_pages
      1.16            +0.1        1.24 ±  2%  perf-profile.children.cycles-pp.anon_vma_interval_tree_insert
      0.88 ±  3%      +0.1        0.98        perf-profile.children.cycles-pp.copy_pte_range
      1.18            +0.1        1.28 ±  2%  perf-profile.children.cycles-pp.unlink_anon_vmas
      0.59 ±  6%      +0.1        0.68 ±  5%  perf-profile.children.cycles-pp.__cond_resched
      1.05 ±  4%      +0.1        1.16 ±  2%  perf-profile.children.cycles-pp.copy_p4d_range
      1.06 ±  3%      +0.1        1.18 ±  2%  perf-profile.children.cycles-pp.copy_page_range
      0.67 ±  7%      +0.1        0.78 ±  5%  perf-profile.children.cycles-pp.__schedule
      1.85            +0.1        1.98 ±  2%  perf-profile.children.cycles-pp.anon_vma_clone
      1.91            +0.1        2.04 ±  2%  perf-profile.children.cycles-pp.free_pgtables
      2.30 ±  2%      +0.2        2.46 ±  2%  perf-profile.children.cycles-pp.anon_vma_fork
      2.17 ±  2%      +0.2        2.37 ±  2%  perf-profile.children.cycles-pp.do_user_addr_fault
      2.18 ±  2%      +0.2        2.38 ±  2%  perf-profile.children.cycles-pp.exc_page_fault
      2.30 ±  2%      +0.2        2.51 ±  2%  perf-profile.children.cycles-pp.asm_exc_page_fault
      5.11 ±  2%      +0.4        5.56 ±  2%  perf-profile.children.cycles-pp.dup_mmap
      5.32 ±  2%      +0.5        5.79 ±  2%  perf-profile.children.cycles-pp.dup_mm
      5.99 ±  2%      +0.5        6.46 ±  2%  perf-profile.children.cycles-pp._Fork
      5.63 ±  2%      +0.5        6.12 ±  2%  perf-profile.children.cycles-pp.copy_process
      5.73 ±  2%      +0.5        6.23 ±  2%  perf-profile.children.cycles-pp.__do_sys_clone
      5.73 ±  2%      +0.5        6.23 ±  2%  perf-profile.children.cycles-pp.kernel_clone
      7.30 ±  2%      +0.5        7.84 ±  2%  perf-profile.children.cycles-pp.exit_mm
      7.13 ±  2%      +0.5        7.67 ±  2%  perf-profile.children.cycles-pp.mmput
      7.11            +0.5        7.66 ±  2%  perf-profile.children.cycles-pp.exit_mmap
      7.55 ±  2%      +0.6        8.10 ±  2%  perf-profile.children.cycles-pp.__x64_sys_exit_group
      7.55 ±  2%      +0.6        8.10 ±  2%  perf-profile.children.cycles-pp.do_exit
      7.55 ±  2%      +0.6        8.10 ±  2%  perf-profile.children.cycles-pp.do_group_exit
      7.57 ±  2%      +0.6        8.12 ±  2%  perf-profile.children.cycles-pp.x64_sys_call
      0.05            +0.0        0.06        perf-profile.self.cycles-pp.sync_regs
      0.16 ±  2%      +0.0        0.18 ±  2%  perf-profile.self.cycles-pp.copy_present_ptes
      0.29 ±  2%      +0.0        0.31 ±  3%  perf-profile.self.cycles-pp.__memcg_slab_free_hook
      0.24 ±  2%      +0.0        0.26 ±  2%  perf-profile.self.cycles-pp.__rb_insert_augmented
      0.30            +0.0        0.33 ±  2%  perf-profile.self.cycles-pp.up_write
      0.55 ±  3%      +0.0        0.58        perf-profile.self.cycles-pp.zap_pte_range
      0.50            +0.0        0.54 ±  2%  perf-profile.self.cycles-pp.down_write
      0.94 ±  3%      +0.1        1.00 ±  3%  perf-profile.self.cycles-pp.next_uptodate_folio
      1.15            +0.1        1.23 ±  2%  perf-profile.self.cycles-pp.anon_vma_interval_tree_insert




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


