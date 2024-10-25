Return-Path: <linux-kernel+bounces-381145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7B09AFAF4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 09:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B48531F23AD8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 07:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF721B6D0A;
	Fri, 25 Oct 2024 07:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WbEfk4op"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8556114F9FD
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 07:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729841399; cv=fail; b=XiVheRy/Uz8Hh/Y1thqRCH5/KjXohGoNk3DHqXBQjng5aMrbioArCgYaRQDfabYHnIcgN0gErXLnaT03evWcR17gtaMaXWLkfMD9bA4lMcvzwpAJ24GU9xVpg1jP9T24bLKf379SnseqUfjXjm6fvtosnRfuPEtaB6tUTO8Ixgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729841399; c=relaxed/simple;
	bh=y382Dp8XaTNmK7R264euYHnIyKv276q3FFXOc/IEnOE=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cBFg88lzGpBv5TgMvp7sNb5LTc9VsDVt2WTID04+6LS2c966lUNpNWjRNspefvxVtdFIPPD47O7Q7QsvLWvYxsQR+cyK+xXaLptC5zk24R+JHID72Pz/SmYEeUzwaQ9HU8rovahvoK2wG6HDRszejQfAPk9+LowAI3BdQAeM5Ik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WbEfk4op; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729841388; x=1761377388;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=y382Dp8XaTNmK7R264euYHnIyKv276q3FFXOc/IEnOE=;
  b=WbEfk4opzSDaqiR1bUjvGxmnOu6/ut22IQRiaTYzfUjYOynD0P8gY4KX
   etA5Aa2lWrggv9wk+tINj6Z8lwzv/nlsf2727i34MpVdyi0c0SjyEQMKY
   K9uzCLov3+1izTwqRp34Mp/efNk2vTYRZvtdIq+ObIZ/+EPvRT5UEcN7M
   5iZAf0dz2hWu7tmVRVuHK3sn0KWHG8KKC5zoZRYB+DwlnhdPqUTSz07RA
   w2hAShGDpHokfBJq+IkjWJJLAz2xZcX8scp9S/cZr45S6zYnLgG1DfHag
   PoIJSIFN5FtwkY1NcI6457xEeDCuBBPAnBagWA5ggkb5UTdLh/Mf/Tf5a
   w==;
X-CSE-ConnectionGUID: KYFpNw7tQl6SfG18LrWFBg==
X-CSE-MsgGUID: WpIlHVnHRQCseeIQGMF7WA==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="29612228"
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="29612228"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 00:29:47 -0700
X-CSE-ConnectionGUID: ZduzcyaOQ5yiGTI4LFdFkw==
X-CSE-MsgGUID: tsRfqLy2QYCS0757FQ3QmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="81158593"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2024 00:29:46 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 00:29:45 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 25 Oct 2024 00:29:45 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Oct 2024 00:29:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m1MUQKr/bB8mDOQk2FFy9/ezNPjq5p3FBTW/ZNTN4wcwwXNiKqDHwJfBHLKF4pv2WVDXlAAPetbZRmVhGtZQJi67ZSq3NZ1TV9gA3KmmG1ckUR9v6kgi3v2p6eNdqa9yNfsqVi+j3ajLp8GU2sOIjoyDG1Nf2vSFWXaFuOENzmC+TetL+Aj9nmHsxubXrFqiNF8820tWG1eXcoCaYxjughmnFnMH6EkB+h5J8IGLZA5TNVhjdtKEv85fdfCLv51oG20SbRhlmzoNVSghL32YDGvYEzvT2x0eelL/5dcwDH0WmQ/IGqctBEtSmlXKLpj32S5xojPfRU1LJ2zdBWQ9/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tfg5Wj8N7598v7aXIY9uosgR1+dDA9uaj/6lMzbxx9Y=;
 b=Eok32nDQihE7/GVaDa/hAbCR+6g0MA/27ffxPhFiaVF35B35/Vfb9aFA7fGyrqpy8CYkpr+ES9qKhgFds0QuRbBZb2+KS3ZxdBYWJje9pliLcQlA569yNT9mOKP1IOKjUDJBhQ4DD3Iiq6Dzl1fQJqth+aCu7vRDR+9dRUZkhEhe0BRI9YBxp5j1lt/PB0X5sl3aCuZuYQ7cRxrZayWAlHmYBsqLr8s7abmAX9QEtLI/vC72Z39l2fvtSbzfvNeewQUjnfCeAWTAFxObgZKNmIF8b3/1R+vdLxz7Z8wFmsHG9FqIpGkTVxYrD99DhLjjaOHUY6Q+ADcYM9nr2sdo2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SN7PR11MB6798.namprd11.prod.outlook.com (2603:10b6:806:262::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 07:14:09 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 07:14:09 +0000
Date: Fri, 25 Oct 2024 15:13:54 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Xavier <xavier_qy@163.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<ying.huang@intel.com>, <feng.tang@intel.com>, <fengwei.yin@intel.com>,
	<aubrey.li@linux.intel.com>, <yu.c.chen@intel.com>, <oliver.sang@intel.com>,
	<bsegall@google.com>, <dietmar.eggemann@arm.com>, <juri.lelli@redhat.com>,
	<mgorman@suse.de>, <mingo@redhat.com>, <peterz@infradead.org>,
	<rostedt@goodmis.org>, <vincent.guittot@linaro.org>, <vschneid@redhat.com>,
	<xavier_qy@163.com>
Subject: Re: [PATCH v3] sched/eevdf: Remove the consideration of the current
 task's time in  vruntime_eligible() and avg_vruntime()
Message-ID: <202410251525.9f85854d-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241018145216.1021494-1-xavier_qy@163.com>
X-ClientProxiedBy: SI2PR04CA0014.apcprd04.prod.outlook.com
 (2603:1096:4:197::18) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SN7PR11MB6798:EE_
X-MS-Office365-Filtering-Correlation-Id: 36d1a9e2-c62d-4497-5f88-08dcf4c49e7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?gZ3xxy91AgjufLd+etP4tbHYizIfzvbvgzr0fY81KKx/sADzILRzL40ANa?=
 =?iso-8859-1?Q?ybaJH73AhKYd4GEemrJKXoo3AZZHXGV9fSxtviv6UkyznFL1OkGbm8ekWA?=
 =?iso-8859-1?Q?VTvmd9/xHUySIKLIFhyG8q9yAFtjgJo/xyrtOwscFVduaJfRd9pLGRHQYd?=
 =?iso-8859-1?Q?zoQnHSqAYqbIllFXMBRPDZ02VmBgHpDGJScZLJ9oRSHhsA5wc70j1WfnjB?=
 =?iso-8859-1?Q?Uazf9CvFzBzEX5Zj/iAQcjhY1g9tsxq6aTjjzjMPyONgYuCzXH79mDXWJw?=
 =?iso-8859-1?Q?yjpyfH/w6E+fxY34jgCF5xk7gNO9q9fAAVMNt0GCcKHMdu9N1mfKus/sug?=
 =?iso-8859-1?Q?7OHN9OYKHwDowpIHG8rVp6Sf7k0H07loNRGmwLfZEvGO0bsrr4hZZ3YNF7?=
 =?iso-8859-1?Q?FWEfdW47u5jmyt2tx2/FdfAaawJzZI5n5FSNq75f7BBKT+bPNtReTqI/Cg?=
 =?iso-8859-1?Q?Stj7HLCJ2F7d80KK615BhpFDunZ+RWQ8b27ZcQDNCDg6v0xa+BTSz4NA8W?=
 =?iso-8859-1?Q?DhsGHBYtEfCzGRm/xHvpQvvL6Q+nGBJIo6Ca2kFyQFGzdelDqWXLHV79+1?=
 =?iso-8859-1?Q?EMborna3y9Y/IXtl38DezyY+g6xwbWmQdBzNh6HFlenxoMUqwwvai9J+aW?=
 =?iso-8859-1?Q?+lKOHtsPmdA3kXrpJerRAKAdGPTx6W3aqFWMC6tHnobt6fy4I2SbkpSaaV?=
 =?iso-8859-1?Q?R1l/bx28e2vwxBW6kpuWzpqbDpAfPgPpUl6aWs2FLH80AuNtzSQZIt5lQ4?=
 =?iso-8859-1?Q?pvvM3be+4vZp+TC/4iW98PfT+lEeEML71KI8Btqw3J/gPgYtti9R0kuiEQ?=
 =?iso-8859-1?Q?Q4Sf4jzgeg2Z1scQ02XimNrtHoCoXi0TIdYyC5pVUTII8IsEscm1mjvehY?=
 =?iso-8859-1?Q?sl4pd0xVdkFcv10TTsfdGVksYDGiOghTv3DbB061M5iJS2yGcbqG8gKuzn?=
 =?iso-8859-1?Q?Y9gkT1AO6AcEsG1Bh5LH8XRa4utPxiW9Xzl3VF8Awdoq1ZsEOXt/tnodsN?=
 =?iso-8859-1?Q?Uu6w5/v2HUYIdvjGdWC8BtZrQf3/8AsHeOyRCCouSlphtmre25Efpvt/ZD?=
 =?iso-8859-1?Q?I9luRyX8gT/cAGGVRYBKyUGJsBa2j1a/QjzFB/2mddT7K10tJ7RxO2wyuy?=
 =?iso-8859-1?Q?OiFA9VR8XvQSaBR1KwhWZtq96XSQ/KqoZ+td0biNocgbbGRqhdYOFPfIMs?=
 =?iso-8859-1?Q?mogsIoDZXiSbv0uwlIwMlCwtXSBKS/z7rvuCqlrJX2zzNxhqZwvF3J5YEQ?=
 =?iso-8859-1?Q?i/B61L2SFQCPTlp0q+URTPQjiNMVlbSVZNoGAfjnNtZ3WI5YENIEXMXb+/?=
 =?iso-8859-1?Q?nwhaT5pBaslg+okGpAvu9ox8RA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?jIj9gxBhNMb2JLATkpnkL0bM5xsOZrTpzNOiKyRAAiyyQ4vuqc2ZVAdLOD?=
 =?iso-8859-1?Q?1M5CeO2Y3zJPl1EJQav1KidIJEuasl/7FgNRY7cSDDTv+h4XWMnBDjfNcF?=
 =?iso-8859-1?Q?BfH4/2jWOs3I5elm60pb9K7SG0kzQ3SqJRoq6xpp2lU1Iex1EoTFWSVd6f?=
 =?iso-8859-1?Q?Q/GB9l5pd18dY5Lm323AJQk+N2Yh93IH9XjCJWcCO3DQeyugBBPWdehua1?=
 =?iso-8859-1?Q?gqiAT768/BXEhrFBH3OYV6rT66OzsshLWSkLxqW7EkH9gyu1v9Lk1dZPVW?=
 =?iso-8859-1?Q?le5E2Feo+JluSWXXd9RkF3WZ400ROZcfbGk7c7up4/r71tweLD4FvoSmwS?=
 =?iso-8859-1?Q?wKw8ftIxfQ/eGwVYFmcza5/2ybprFxH4mgPRwtzdFe/tWyYYNIV3mdgsM3?=
 =?iso-8859-1?Q?GWU1VmnGIXv372/Viqsi+rM3H7kccc/xV3gR0TWYVCDerjwnejZy6utXNJ?=
 =?iso-8859-1?Q?ePI/uAH1fjN6aRUVbUQrddB8seCJ/29Rp+43zNC1o+ScV+/NUYuVDk7MJH?=
 =?iso-8859-1?Q?1eovpVS0ggvimmC79YsB6XNRDIh/WIjBYi4XMA0g1kbiPjFL/vytxGBq0U?=
 =?iso-8859-1?Q?ibdV/tIi5PIsmZFGb+6dsDin2IDH2GSGl9EbLFKXJYmYbL2siWwiinaG4C?=
 =?iso-8859-1?Q?KvDiV4oO9ufJtmGkAGUusB3RslkCxMOcMHiCTfSytnTykNyBg12kLztAL/?=
 =?iso-8859-1?Q?ogbA4+BKHbW1QvQfZOiZngEvYThC25Ry7bF1HHX7HNy+sNmNseKLlHF6MA?=
 =?iso-8859-1?Q?HT5XKh0UifiFW0OEFwyOq9Oh/lCVtoo8vYdr3vyS8qZk7y3RytJj8y3asU?=
 =?iso-8859-1?Q?0/8Q5OgaOEoOcA6Mko43IwfEXJP0mFnYC4HmUyj/yOIVQP/sdyMklVvNyM?=
 =?iso-8859-1?Q?x3V9toeh1I+3WfUGHRLRAuBhTMztd63XQLsE213S53R+YmaDxOooruHpTx?=
 =?iso-8859-1?Q?FsxRmUw8wvqfLIhPE9A4hC7seu7M9gNIOcbltWjbLJFwLhwyl56FsCuYy+?=
 =?iso-8859-1?Q?eXlt0CZJpiEGcCYhoM5+01Euza2pns5enncUIydlyJ6xU1fmxoH0MgE4uv?=
 =?iso-8859-1?Q?erSjDm6xgM4C28t5Gjb3zZgLhanzeBClZ891A0ev6+aC6gSUZi71pYK4hy?=
 =?iso-8859-1?Q?obzxY6E6IZt8dtSJKMbjBfc2uKe8M/ORgr60CnHoQPaLSX+d1eNaCD2Bkb?=
 =?iso-8859-1?Q?lhLd3DsjGJtraYInMKVfR8wyMxP5mERn9HcaPziePhqGAGiRTxi7I9IYde?=
 =?iso-8859-1?Q?nJ3cCd7IRj+ELrRYcUNMnxiYqoG6JghgEyBtHO4ufnc99bqzwgfUM8vsCp?=
 =?iso-8859-1?Q?Lf33JuzDV6EQRkMqrbOH/fVjwI2R73jJBTV4dQYjW2RvDkObCugu/WVeD1?=
 =?iso-8859-1?Q?ZxhzfdualE8S7cbIvBbu7Zz8gVj0v20nUtqYJT0BgLZpoeqUfJpXyJkIEm?=
 =?iso-8859-1?Q?5K5xNTId9RrSQxpWm961YLeavje5Z/qItoIjCJhrs7dWEbGwtkXByrYvS3?=
 =?iso-8859-1?Q?oHrcgip2fr8krESjqUeYJ+/kwJ2Rz5Ck5FWpxiLuUmfa2bd4tRhKC3Mrcb?=
 =?iso-8859-1?Q?xLq6XYI202eZHxkwhIhGejmMzvzGLeR8k1waxnjpxuAEqed7/RASVGeVtz?=
 =?iso-8859-1?Q?sKnAHTF2QV5BQiqooz0VJ/ZHEKcurfOY9z5EFwv5fxUQZqnlomxUI8tQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 36d1a9e2-c62d-4497-5f88-08dcf4c49e7d
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 07:14:09.6236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lZd5hmQDIrI9qZ9J+Ad4H6hz1/rHSDohOHSSs5JfQ/VbP6HdLbLaQd1h6QgdFxTAUILnuStxXJ1RdXlMdkNHZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6798
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 3.5% regression of reaim.jobs_per_min on:


commit: e14321ce0d4a9c7a2894b119840a9d58ec4cd25d ("[PATCH v3] sched/eevdf: Remove the consideration of the current task's time in  vruntime_eligible() and avg_vruntime()")
url: https://github.com/intel-lab-lkp/linux/commits/Xavier/sched-eevdf-Remove-the-consideration-of-the-current-task-s-time-in-vruntime_eligible-and-avg_vruntime/20241018-225521
base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git af0c8b2bf67b25756f27644936e74fd9a6273bd2
patch link: https://lore.kernel.org/all/20241018145216.1021494-1-xavier_qy@163.com/
patch subject: [PATCH v3] sched/eevdf: Remove the consideration of the current task's time in  vruntime_eligible() and avg_vruntime()

testcase: reaim
config: x86_64-rhel-8.3
compiler: gcc-12
test machine: 48 threads 2 sockets Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz (Ivy Bridge-EP) with 64G memory
parameters:

	runtime: 300s
	nr_task: 100%
	test: custom
	cpufreq_governor: performance




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202410251525.9f85854d-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241025/202410251525.9f85854d-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_task/rootfs/runtime/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/300s/lkp-ivb-2ep2/custom/reaim

commit: 
  af0c8b2bf6 ("sched: Split scheduler and execution contexts")
  e14321ce0d ("sched/eevdf: Remove the consideration of the current task's time in vruntime_eligible() and avg_vruntime()")

af0c8b2bf67b2575 e14321ce0d4a9c7a2894b119840 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      0.14            +0.0        0.19        mpstat.cpu.all.soft%
    111.00 ± 80%     -89.9%      11.17 ± 23%  mpstat.max_utilization.seconds
      5858 ±  4%      -8.9%       5335 ±  4%  numa-meminfo.node1.KernelStack
     25970 ± 53%     -40.2%      15518 ± 51%  numa-meminfo.node1.Mapped
      5859 ±  4%      -8.9%       5337 ±  4%  numa-vmstat.node1.nr_kernel_stack
      6643 ± 52%     -40.9%       3927 ± 50%  numa-vmstat.node1.nr_mapped
     22526            -9.4%      20413        vmstat.system.cs
     27118            -2.9%      26328        vmstat.system.in
    224657 ±  2%      -9.1%     204143        meminfo.Active
    224625 ±  2%      -9.1%     204111        meminfo.Active(anon)
    239022 ±  2%      -9.0%     217445        meminfo.Shmem
     56114 ±  2%      -9.0%      51064        proc-vmstat.nr_active_anon
     12421            -2.5%      12115        proc-vmstat.nr_mapped
     59755 ±  2%      -9.0%      54398        proc-vmstat.nr_shmem
     56114 ±  2%      -9.0%      51064        proc-vmstat.nr_zone_active_anon
  69086758            -1.1%   68296855        proc-vmstat.numa_hit
  69043741            -1.2%   68247974        proc-vmstat.numa_local
     91813            -7.1%      85252        proc-vmstat.pgactivate
  71568239            -1.1%   70771661        proc-vmstat.pgalloc_normal
  84550200            -1.0%   83664581        proc-vmstat.pgfault
  71455511            -1.1%   70664205        proc-vmstat.pgfree
     51.42            -1.0%      50.90        reaim.child_utime
    200350            -3.5%     193411        reaim.jobs_per_min
      4173            -3.5%       4029        reaim.jobs_per_min_child
    208595            -2.4%     203678        reaim.max_jobs_per_min
      1.37            +3.6%       1.42        reaim.parent_time
      1.54           +48.0%       2.28        reaim.std_dev_percent
      0.02 ±  2%     +46.6%       0.03        reaim.std_dev_time
    675635           -67.8%     217563        reaim.time.involuntary_context_switches
  83620119            -1.1%   82730368        reaim.time.minor_page_faults
      1789            -2.4%       1746        reaim.time.percent_of_cpu_this_job_got
    829.97            -2.1%     812.88        reaim.time.system_time
      4578            -2.1%       4481        reaim.time.user_time
   3394885            -2.5%    3311673        reaim.time.voluntary_context_switches
    427200            -1.1%     422400        reaim.workload
      1.73            -2.8%       1.68        perf-stat.i.MPKI
 3.963e+09            +8.3%  4.291e+09        perf-stat.i.branch-instructions
      2.89            +0.1        3.01        perf-stat.i.branch-miss-rate%
  92238582            +7.8%   99393054        perf-stat.i.branch-misses
 5.351e+08            +7.9%  5.772e+08        perf-stat.i.cache-references
     48004            +2.9%      49407        perf-stat.i.cpu-clock
 5.535e+10            +7.4%  5.946e+10        perf-stat.i.cpu-cycles
      4872            -1.6%       4794        perf-stat.i.cpu-migrations
      2440            -1.7%       2398        perf-stat.i.cycles-between-cache-misses
  2.87e+10            +8.3%  3.108e+10        perf-stat.i.instructions
      0.49            +1.3%       0.50        perf-stat.i.ipc
     21.46            +5.5%      22.63        perf-stat.i.major-faults
     11.61           -15.1%       9.86        perf-stat.i.metric.K/sec
    276192            +9.0%     301016        perf-stat.i.minor-faults
    276214            +9.0%     301038        perf-stat.i.page-faults
     48004            +2.9%      49407        perf-stat.i.task-clock
   5644916 ± 18%  +35162.3%  1.991e+09 ± 17%  sched_debug.cfs_rq:/.avg_vruntime.avg
  17097981 ± 48%  +15093.3%  2.598e+09 ± 16%  sched_debug.cfs_rq:/.avg_vruntime.max
   2702756 ± 10%  +45989.8%  1.246e+09 ± 28%  sched_debug.cfs_rq:/.avg_vruntime.min
   2873896 ± 37%   +9275.7%  2.694e+08 ± 22%  sched_debug.cfs_rq:/.avg_vruntime.stddev
     40604 ± 76%  +1.3e+05%   53761749 ± 49%  sched_debug.cfs_rq:/.left_deadline.avg
   1438807 ± 57%  +70833.0%  1.021e+09 ± 25%  sched_debug.cfs_rq:/.left_deadline.max
    224842 ± 61%  +90999.7%  2.048e+08 ± 25%  sched_debug.cfs_rq:/.left_deadline.stddev
     40603 ± 76%  +1.3e+05%   53761750 ± 49%  sched_debug.cfs_rq:/.left_vruntime.avg
   1438775 ± 57%  +70834.6%  1.021e+09 ± 25%  sched_debug.cfs_rq:/.left_vruntime.max
    224837 ± 61%  +91001.7%  2.048e+08 ± 25%  sched_debug.cfs_rq:/.left_vruntime.stddev
     30025 ± 19%     +54.8%      46483 ± 23%  sched_debug.cfs_rq:/.load.avg
     95346 ± 38%     +72.5%     164455 ± 16%  sched_debug.cfs_rq:/.load.stddev
   5644917 ± 18%  +35161.5%   1.99e+09 ± 17%  sched_debug.cfs_rq:/.min_vruntime.avg
  17097981 ± 48%  +15092.9%  2.598e+09 ± 16%  sched_debug.cfs_rq:/.min_vruntime.max
   2702756 ± 10%  +45988.6%  1.246e+09 ± 28%  sched_debug.cfs_rq:/.min_vruntime.min
   2873897 ± 37%   +9275.6%  2.694e+08 ± 22%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.25 ± 11%     +30.7%       0.33 ± 10%  sched_debug.cfs_rq:/.nr_running.stddev
     40603 ± 76%  +1.3e+05%   53761750 ± 49%  sched_debug.cfs_rq:/.right_vruntime.avg
   1438775 ± 57%  +70834.6%  1.021e+09 ± 25%  sched_debug.cfs_rq:/.right_vruntime.max
    224837 ± 61%  +91001.7%  2.048e+08 ± 25%  sched_debug.cfs_rq:/.right_vruntime.stddev
      0.00 ±223%  +21421.5%       0.23 ± 66%  sched_debug.cfs_rq:/.spread.avg
      0.05 ±223%  +20478.3%      10.64 ± 64%  sched_debug.cfs_rq:/.spread.max
      0.01 ±223%  +20485.4%       1.52 ± 64%  sched_debug.cfs_rq:/.spread.stddev
     93.49 ± 55%     -56.5%      40.71 ± 74%  sched_debug.cfs_rq:/.util_avg.min
      7.50 ± 10%      -2.8        4.65        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
      7.48 ± 10%      -2.8        4.64        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
      8.97 ±  2%      -1.4        7.59        perf-profile.calltrace.cycles-pp.common_startup_64
      8.80 ±  2%      -1.4        7.42        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
      8.80 ±  2%      -1.4        7.42        perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
      8.78 ±  2%      -1.4        7.42        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      8.54 ±  2%      -1.3        7.22        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      8.03 ±  2%      -1.2        6.86        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      7.96 ±  2%      -1.1        6.81        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      3.58 ±  4%      -0.7        2.88        perf-profile.calltrace.cycles-pp.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.55 ±  4%      -0.7        2.86        perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.55 ±  4%      -0.7        2.86        perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.55 ±  4%      -0.7        2.86        perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call.do_syscall_64
      6.16 ±  2%      -0.6        5.53        perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      2.31 ±  7%      -0.6        1.69        perf-profile.calltrace.cycles-pp.asm_exc_page_fault
      2.23 ±  7%      -0.6        1.62        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault
      2.18 ±  7%      -0.6        1.59        perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      2.84 ±  4%      -0.5        2.31 ±  2%  perf-profile.calltrace.cycles-pp.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      2.83 ±  4%      -0.5        2.31 ±  2%  perf-profile.calltrace.cycles-pp.mmput.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group
      2.82 ±  4%      -0.5        2.30 ±  2%  perf-profile.calltrace.cycles-pp.exit_mmap.mmput.exit_mm.do_exit.do_group_exit
      1.87 ±  7%      -0.5        1.36        perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      1.63 ±  4%      -0.5        1.14 ±  2%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      1.73 ±  7%      -0.5        1.26        perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      1.54 ±  4%      -0.5        1.08 ±  2%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      1.00 ±  4%      -0.3        0.70 ±  2%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.98 ±  4%      -0.3        0.68 ±  2%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      1.21 ±  3%      -0.3        0.96        perf-profile.calltrace.cycles-pp.setlocale
      1.24 ±  4%      -0.2        1.01        perf-profile.calltrace.cycles-pp.unmap_vmas.exit_mmap.mmput.exit_mm.do_exit
      0.78 ±  5%      -0.2        0.55 ±  2%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.87 ±  7%      -0.2        0.65 ±  3%  perf-profile.calltrace.cycles-pp.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      1.17 ±  4%      -0.2        0.95        perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.exit_mmap.mmput.exit_mm
      1.14 ±  4%      -0.2        0.92        perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap.mmput
      1.11 ±  4%      -0.2        0.90        perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap
      0.77 ±  7%      -0.2        0.57 ±  3%  perf-profile.calltrace.cycles-pp.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.73 ±  7%      -0.2        0.54 ±  2%  perf-profile.calltrace.cycles-pp.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault
      1.56            -0.2        1.37        perf-profile.calltrace.cycles-pp.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      1.56            -0.2        1.37        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      1.56            -0.2        1.37        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.execve
      1.56            -0.2        1.38        perf-profile.calltrace.cycles-pp.execve
      0.92 ±  3%      -0.2        0.74 ±  2%  perf-profile.calltrace.cycles-pp.zap_present_ptes.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
      1.55            -0.2        1.37        perf-profile.calltrace.cycles-pp.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      1.11            -0.1        0.98        perf-profile.calltrace.cycles-pp.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.00 ±  2%      -0.1        0.89        perf-profile.calltrace.cycles-pp.search_binary_handler.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve
      1.00 ±  2%      -0.1        0.89        perf-profile.calltrace.cycles-pp.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64
      0.97 ±  2%      -0.1        0.86        perf-profile.calltrace.cycles-pp.load_elf_binary.search_binary_handler.exec_binprm.bprm_execve.do_execveat_common
      0.63 ±  6%      -0.1        0.53 ±  3%  perf-profile.calltrace.cycles-pp.free_pgtables.exit_mmap.mmput.exit_mm.do_exit
      0.80 ±  4%      +0.0        0.85 ±  2%  perf-profile.calltrace.cycles-pp.brk
      1.92 ±  2%      +0.1        2.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe._Fork
      1.92 ±  2%      +0.1        2.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe._Fork
      1.91 ±  2%      +0.1        2.00        perf-profile.calltrace.cycles-pp.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe._Fork
      1.91 ±  2%      +0.1        2.00        perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe._Fork
      2.18 ±  2%      +0.1        2.28        perf-profile.calltrace.cycles-pp._Fork
      0.00            +0.5        0.52 ±  2%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.sieve.runloop.multiuser.main
      0.47 ± 79%      +0.7        1.15 ± 14%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.scan_positives.dcache_readdir.iterate_dir
      0.73 ± 56%      +0.7        1.43 ± 12%  perf-profile.calltrace.cycles-pp.dcache_readdir.iterate_dir.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.73 ± 56%      +0.7        1.43 ± 12%  perf-profile.calltrace.cycles-pp.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe.getdents64
      0.73 ± 56%      +0.7        1.43 ± 12%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.getdents64
      0.73 ± 56%      +0.7        1.43 ± 12%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.getdents64
      0.73 ± 56%      +0.7        1.43 ± 12%  perf-profile.calltrace.cycles-pp.iterate_dir.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe.getdents64
      0.73 ± 56%      +0.7        1.44 ± 12%  perf-profile.calltrace.cycles-pp.getdents64
      0.55 ± 78%      +0.7        1.27 ± 13%  perf-profile.calltrace.cycles-pp._raw_spin_lock.scan_positives.dcache_readdir.iterate_dir.__x64_sys_getdents64
      0.58 ± 78%      +0.8        1.34 ± 13%  perf-profile.calltrace.cycles-pp.scan_positives.dcache_readdir.iterate_dir.__x64_sys_getdents64.do_syscall_64
     66.34            +5.5       71.89        perf-profile.calltrace.cycles-pp.sieve.runloop.multiuser.main
     69.74            +5.8       75.52        perf-profile.calltrace.cycles-pp.main
     69.74            +5.8       75.52        perf-profile.calltrace.cycles-pp.multiuser.main
     69.73            +5.8       75.51        perf-profile.calltrace.cycles-pp.runloop.multiuser.main
     16.72 ±  4%      -2.5       14.23        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     16.67 ±  4%      -2.5       14.18        perf-profile.children.cycles-pp.do_syscall_64
      8.97 ±  2%      -1.4        7.59        perf-profile.children.cycles-pp.common_startup_64
      8.97 ±  2%      -1.4        7.59        perf-profile.children.cycles-pp.cpu_startup_entry
      8.97 ±  2%      -1.4        7.59        perf-profile.children.cycles-pp.do_idle
      8.80 ±  2%      -1.4        7.42        perf-profile.children.cycles-pp.start_secondary
      8.72 ±  2%      -1.3        7.38        perf-profile.children.cycles-pp.cpuidle_idle_call
      8.20 ±  2%      -1.2        7.02        perf-profile.children.cycles-pp.cpuidle_enter
      8.18 ±  2%      -1.2        7.00        perf-profile.children.cycles-pp.cpuidle_enter_state
      3.73 ±  4%      -0.7        3.02        perf-profile.children.cycles-pp.x64_sys_call
      3.64 ±  4%      -0.7        2.95        perf-profile.children.cycles-pp.__x64_sys_exit_group
      3.64 ±  4%      -0.7        2.95        perf-profile.children.cycles-pp.do_exit
      3.64 ±  4%      -0.7        2.95        perf-profile.children.cycles-pp.do_group_exit
      4.03 ±  4%      -0.7        3.35        perf-profile.children.cycles-pp.asm_exc_page_fault
      3.77 ±  4%      -0.6        3.12        perf-profile.children.cycles-pp.exc_page_fault
      2.60            -0.6        1.96        perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      6.29 ±  2%      -0.6        5.66 ±  2%  perf-profile.children.cycles-pp.intel_idle
      3.70 ±  4%      -0.6        3.07        perf-profile.children.cycles-pp.do_user_addr_fault
      2.44            -0.6        1.85        perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      3.25 ±  4%      -0.6        2.68        perf-profile.children.cycles-pp.handle_mm_fault
      2.86 ±  4%      -0.5        2.32 ±  2%  perf-profile.children.cycles-pp.exit_mm
      2.84 ±  4%      -0.5        2.31 ±  2%  perf-profile.children.cycles-pp.mmput
      3.00 ±  4%      -0.5        2.48        perf-profile.children.cycles-pp.__handle_mm_fault
      2.83 ±  4%      -0.5        2.30 ±  2%  perf-profile.children.cycles-pp.exit_mmap
      2.88 ±  5%      -0.5        2.42        perf-profile.children.cycles-pp.kernel_clone
      1.81            -0.4        1.38        perf-profile.children.cycles-pp.__x64_sys_execve
      1.61            -0.4        1.18        perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      1.81 ±  2%      -0.4        1.38        perf-profile.children.cycles-pp.do_execveat_common
      1.58            -0.4        1.16        perf-profile.children.cycles-pp.hrtimer_interrupt
      2.37 ±  6%      -0.4        2.00        perf-profile.children.cycles-pp.__do_sys_clone
      2.38 ±  6%      -0.4        2.02        perf-profile.children.cycles-pp.copy_process
      1.58 ±  3%      -0.3        1.24 ±  2%  perf-profile.children.cycles-pp.do_sys_openat2
      1.32            -0.3        0.98        perf-profile.children.cycles-pp.__hrtimer_run_queues
      1.56 ±  2%      -0.3        1.23 ±  2%  perf-profile.children.cycles-pp.vm_mmap_pgoff
      1.48 ±  3%      -0.3        1.16 ±  2%  perf-profile.children.cycles-pp.do_filp_open
      1.48 ±  2%      -0.3        1.17 ±  2%  perf-profile.children.cycles-pp.do_mmap
      1.44 ±  3%      -0.3        1.14 ±  2%  perf-profile.children.cycles-pp.path_openat
      1.30 ±  2%      -0.3        1.00        perf-profile.children.cycles-pp.bprm_execve
      1.78 ±  7%      -0.3        1.49        perf-profile.children.cycles-pp.dup_mm
      1.32 ±  2%      -0.3        1.04        perf-profile.children.cycles-pp.mmap_region
      1.40 ±  5%      -0.3        1.14 ±  2%  perf-profile.children.cycles-pp.do_fault
      1.16 ±  2%      -0.3        0.89        perf-profile.children.cycles-pp.search_binary_handler
      1.17 ±  4%      -0.3        0.91 ±  2%  perf-profile.children.cycles-pp.__schedule
      1.16 ±  2%      -0.3        0.90        perf-profile.children.cycles-pp.exec_binprm
      1.22 ±  3%      -0.3        0.96        perf-profile.children.cycles-pp.setlocale
      1.12 ±  2%      -0.3        0.86        perf-profile.children.cycles-pp.load_elf_binary
      1.55 ±  7%      -0.3        1.30        perf-profile.children.cycles-pp.dup_mmap
      1.35 ±  4%      -0.2        1.10 ±  2%  perf-profile.children.cycles-pp.unmap_vmas
      1.05 ±  5%      -0.2        0.81 ±  3%  perf-profile.children.cycles-pp.__x64_sys_openat
      1.27 ±  4%      -0.2        1.04 ±  2%  perf-profile.children.cycles-pp.unmap_page_range
      1.22 ±  4%      -0.2        1.00 ±  2%  perf-profile.children.cycles-pp.zap_pmd_range
      1.22 ±  5%      -0.2        1.00 ±  2%  perf-profile.children.cycles-pp.do_read_fault
      1.19 ±  4%      -0.2        0.97 ±  2%  perf-profile.children.cycles-pp.zap_pte_range
      0.92 ±  2%      -0.2        0.71 ±  2%  perf-profile.children.cycles-pp.handle_softirqs
      1.17 ±  5%      -0.2        0.96        perf-profile.children.cycles-pp.filemap_map_pages
      1.01 ±  2%      -0.2        0.79 ±  2%  perf-profile.children.cycles-pp.ksys_mmap_pgoff
      0.90 ±  2%      -0.2        0.69 ±  2%  perf-profile.children.cycles-pp.tick_nohz_handler
      0.64 ±  5%      -0.2        0.44 ±  2%  perf-profile.children.cycles-pp.ret_from_fork_asm
      0.58 ±  6%      -0.2        0.38 ±  2%  perf-profile.children.cycles-pp.ret_from_fork
      0.89 ±  2%      -0.2        0.69 ±  2%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.99 ±  3%      -0.2        0.80 ±  2%  perf-profile.children.cycles-pp.zap_present_ptes
      0.35 ±  5%      -0.2        0.16 ±  3%  perf-profile.children.cycles-pp.smpboot_thread_fn
      0.42 ±  6%      -0.2        0.24 ±  3%  perf-profile.children.cycles-pp.kthread
      1.56            -0.2        1.38        perf-profile.children.cycles-pp.execve
      0.80 ±  2%      -0.2        0.61 ±  2%  perf-profile.children.cycles-pp.update_process_times
      0.80 ±  3%      -0.2        0.63 ±  3%  perf-profile.children.cycles-pp.schedule
      0.27 ±  5%      -0.2        0.12 ±  4%  perf-profile.children.cycles-pp.run_ksoftirqd
      0.74 ±  6%      -0.2        0.59 ±  3%  perf-profile.children.cycles-pp.__alloc_pages_noprof
      0.79 ±  6%      -0.2        0.64 ±  2%  perf-profile.children.cycles-pp.alloc_pages_mpol_noprof
      0.70 ±  3%      -0.2        0.54 ±  4%  perf-profile.children.cycles-pp.link_path_walk
      0.86 ±  5%      -0.1        0.71 ±  2%  perf-profile.children.cycles-pp.kmem_cache_free
      0.62 ±  6%      -0.1        0.47        perf-profile.children.cycles-pp.copy_page_range
      0.86 ±  3%      -0.1        0.72        perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
      0.62 ±  2%      -0.1        0.48 ±  2%  perf-profile.children.cycles-pp.elf_load
      0.60 ±  6%      -0.1        0.46        perf-profile.children.cycles-pp.copy_p4d_range
      0.73 ±  4%      -0.1        0.59 ±  3%  perf-profile.children.cycles-pp.tlb_finish_mmu
      0.67 ±  5%      -0.1        0.54 ±  3%  perf-profile.children.cycles-pp.__irqentry_text_end
      0.58 ±  4%      -0.1        0.45 ±  4%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.60 ±  6%      -0.1        0.47 ±  3%  perf-profile.children.cycles-pp.__open64_nocancel
      0.41 ±  5%      -0.1        0.28 ±  5%  perf-profile.children.cycles-pp.menu_select
      0.58 ±  6%      -0.1        0.45 ±  3%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.78 ±  5%      -0.1        0.66 ±  2%  perf-profile.children.cycles-pp.__do_sys_brk
      0.62 ±  3%      -0.1        0.49 ±  2%  perf-profile.children.cycles-pp.__do_sys_wait4
      0.60 ±  3%      -0.1        0.48 ±  2%  perf-profile.children.cycles-pp.do_wait
      0.61 ±  3%      -0.1        0.49 ±  2%  perf-profile.children.cycles-pp.kernel_wait4
      0.46 ±  7%      -0.1        0.34 ±  2%  perf-profile.children.cycles-pp.copy_pte_range
      0.55 ±  4%      -0.1        0.43 ±  3%  perf-profile.children.cycles-pp.sched_balance_rq
      0.69 ±  5%      -0.1        0.58 ±  3%  perf-profile.children.cycles-pp.free_pgtables
      0.52 ±  3%      -0.1        0.41 ±  3%  perf-profile.children.cycles-pp.rcu_core
      0.61 ±  3%      -0.1        0.50 ±  4%  perf-profile.children.cycles-pp.__tlb_batch_free_encoded_pages
      0.61 ±  3%      -0.1        0.50 ±  4%  perf-profile.children.cycles-pp.free_pages_and_swap_cache
      0.59 ±  5%      -0.1        0.48        perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
      0.49 ±  4%      -0.1        0.38 ±  4%  perf-profile.children.cycles-pp.walk_component
      0.62 ±  5%      -0.1        0.51 ±  4%  perf-profile.children.cycles-pp.do_anonymous_page
      0.41 ±  3%      -0.1        0.31 ±  2%  perf-profile.children.cycles-pp.__split_vma
      0.54 ±  4%      -0.1        0.44 ±  3%  perf-profile.children.cycles-pp.perf_event_mmap
      0.46 ±  3%      -0.1        0.36 ±  2%  perf-profile.children.cycles-pp.sched_tick
      0.54 ±  2%      -0.1        0.44        perf-profile.children.cycles-pp.__mmap
      0.54 ±  2%      -0.1        0.44        perf-profile.children.cycles-pp.__x64_sys_creat
      0.55 ±  6%      -0.1        0.45 ±  2%  perf-profile.children.cycles-pp.next_uptodate_folio
      0.50 ±  4%      -0.1        0.41 ±  4%  perf-profile.children.cycles-pp.sched_balance_newidle
      0.61 ±  4%      -0.1        0.52 ±  3%  perf-profile.children.cycles-pp.__irq_exit_rcu
      0.52 ±  5%      -0.1        0.42 ±  5%  perf-profile.children.cycles-pp.perf_event_mmap_event
      0.42 ±  4%      -0.1        0.33 ±  2%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.63 ±  3%      -0.1        0.54 ±  4%  perf-profile.children.cycles-pp.ksys_write
      0.45 ±  3%      -0.1        0.36 ±  3%  perf-profile.children.cycles-pp.rcu_do_batch
      0.50 ±  3%      -0.1        0.41 ±  4%  perf-profile.children.cycles-pp.do_vmi_align_munmap
      0.38 ±  6%      -0.1        0.30 ±  3%  perf-profile.children.cycles-pp.clear_page_erms
      0.61 ±  4%      -0.1        0.52 ±  5%  perf-profile.children.cycles-pp.vfs_write
      0.43 ±  4%      -0.1        0.35 ±  4%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.44 ±  4%      -0.1        0.36 ±  3%  perf-profile.children.cycles-pp.folios_put_refs
      0.28 ±  6%      -0.1        0.20 ±  3%  perf-profile.children.cycles-pp.copy_present_ptes
      0.35 ±  4%      -0.1        0.27 ±  3%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.41 ±  6%      -0.1        0.33 ±  4%  perf-profile.children.cycles-pp.__memcg_slab_free_hook
      0.37 ±  4%      -0.1        0.30 ±  3%  perf-profile.children.cycles-pp.mas_store_prealloc
      0.30 ±  4%      -0.1        0.23 ±  3%  perf-profile.children.cycles-pp.load_elf_interp
      0.38 ±  2%      -0.1        0.30 ±  5%  perf-profile.children.cycles-pp.ksys_read
      0.41 ±  4%      -0.1        0.34 ±  5%  perf-profile.children.cycles-pp.perf_iterate_sb
      0.37            -0.1        0.30 ±  5%  perf-profile.children.cycles-pp.vfs_read
      0.55 ±  3%      -0.1        0.48        perf-profile.children.cycles-pp.wp_page_copy
      0.44 ±  6%      -0.1        0.37 ±  3%  perf-profile.children.cycles-pp.vma_alloc_folio_noprof
      0.22 ±  9%      -0.1        0.15 ±  8%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.30 ±  4%      -0.1        0.23        perf-profile.children.cycles-pp.vms_gather_munmap_vmas
      0.43 ±  6%      -0.1        0.36 ±  3%  perf-profile.children.cycles-pp.do_brk_flags
      0.27 ± 12%      -0.1        0.20 ±  5%  perf-profile.children.cycles-pp.d_alloc_parallel
      0.35 ±  3%      -0.1        0.28 ±  5%  perf-profile.children.cycles-pp.sched_balance_find_src_group
      0.34 ±  7%      -0.1        0.28 ±  3%  perf-profile.children.cycles-pp.mm_init
      0.33 ±  3%      -0.1        0.27 ±  6%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.28 ±  5%      -0.1        0.22 ±  4%  perf-profile.children.cycles-pp.__lookup_slow
      0.33 ±  4%      -0.1        0.27 ±  4%  perf-profile.children.cycles-pp.wake_up_new_task
      0.28 ±  6%      -0.1        0.21 ±  4%  perf-profile.children.cycles-pp.__x64_sys_mprotect
      0.35 ±  3%      -0.1        0.29 ±  3%  perf-profile.children.cycles-pp.__do_sys_newfstatat
      0.34 ±  3%      -0.1        0.27        perf-profile.children.cycles-pp.select_task_rq_fair
      0.38 ±  7%      -0.1        0.31 ±  4%  perf-profile.children.cycles-pp.alloc_anon_folio
      0.41 ±  7%      -0.1        0.34 ±  4%  perf-profile.children.cycles-pp.folio_alloc_mpol_noprof
      0.26 ±  3%      -0.1        0.20 ±  4%  perf-profile.children.cycles-pp.__do_sys_clone3
      0.27 ±  5%      -0.1        0.21 ±  4%  perf-profile.children.cycles-pp.do_mprotect_pkey
      0.40 ±  4%      -0.1        0.34 ±  3%  perf-profile.children.cycles-pp.vms_clear_ptes
      0.30 ±  7%      -0.1        0.24 ±  4%  perf-profile.children.cycles-pp.finish_task_switch
      0.23 ± 10%      -0.1        0.17 ±  5%  perf-profile.children.cycles-pp.open_last_lookups
      0.38 ±  3%      -0.1        0.32 ±  5%  perf-profile.children.cycles-pp.vms_complete_munmap_vmas
      0.16 ± 11%      -0.1        0.10 ±  9%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.30 ±  4%      -0.1        0.24 ±  4%  perf-profile.children.cycles-pp.folio_remove_rmap_ptes
      0.38 ±  6%      -0.1        0.33 ±  5%  perf-profile.children.cycles-pp.unlink_anon_vmas
      0.23 ±  6%      -0.1        0.18 ±  6%  perf-profile.children.cycles-pp.dequeue_entities
      0.23 ±  5%      -0.1        0.18 ±  3%  perf-profile.children.cycles-pp.mprotect_fixup
      0.29 ±  4%      -0.1        0.24 ±  2%  perf-profile.children.cycles-pp.filename_lookup
      0.21 ±  6%      -0.1        0.16 ±  3%  perf-profile.children.cycles-pp.__cond_resched
      0.26 ±  4%      -0.1        0.21 ±  4%  perf-profile.children.cycles-pp.__vm_munmap
      0.29 ±  3%      -0.1        0.24 ±  3%  perf-profile.children.cycles-pp.do_open
      0.22 ±  6%      -0.1        0.16 ±  5%  perf-profile.children.cycles-pp.do_task_dead
      0.26 ±  5%      -0.1        0.21 ±  2%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.20 ± 12%      -0.1        0.14 ±  8%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
      0.25 ±  7%      -0.1        0.20 ±  7%  perf-profile.children.cycles-pp.alloc_empty_file
      0.24 ±  5%      -0.1        0.20 ±  5%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.21 ±  7%      -0.1        0.16 ±  6%  perf-profile.children.cycles-pp.update_load_avg
      0.28 ±  9%      -0.0        0.23 ±  3%  perf-profile.children.cycles-pp.mod_objcg_state
      0.27 ±  4%      -0.0        0.22 ±  6%  perf-profile.children.cycles-pp.update_sg_lb_stats
      0.21 ±  2%      -0.0        0.16 ±  4%  perf-profile.children.cycles-pp.alloc_bprm
      0.26 ±  2%      -0.0        0.21 ±  3%  perf-profile.children.cycles-pp.sched_balance_find_dst_group
      0.28 ±  5%      -0.0        0.24 ±  3%  perf-profile.children.cycles-pp.vfs_fstatat
      0.27 ±  4%      -0.0        0.23 ±  2%  perf-profile.children.cycles-pp.path_lookupat
      0.28 ±  5%      -0.0        0.23        perf-profile.children.cycles-pp.vm_area_dup
      0.19 ±  3%      -0.0        0.14 ±  3%  perf-profile.children.cycles-pp.copy_strings
      0.24 ±  5%      -0.0        0.19 ±  6%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.23 ±  3%      -0.0        0.19 ±  2%  perf-profile.children.cycles-pp.update_sg_wakeup_stats
      0.22 ±  5%      -0.0        0.17 ±  2%  perf-profile.children.cycles-pp.d_alloc
      0.25 ±  3%      -0.0        0.21 ±  5%  perf-profile.children.cycles-pp.do_vmi_munmap
      0.15 ± 17%      -0.0        0.11 ±  8%  perf-profile.children.cycles-pp.lookup_open
      0.25 ±  2%      -0.0        0.21 ±  6%  perf-profile.children.cycles-pp.perf_event_mmap_output
      0.20 ±  7%      -0.0        0.16 ±  2%  perf-profile.children.cycles-pp.set_pte_range
      0.31 ±  5%      -0.0        0.26 ±  4%  perf-profile.children.cycles-pp.down_write
      0.20 ± 10%      -0.0        0.16 ±  4%  perf-profile.children.cycles-pp.mas_walk
      0.22 ±  4%      -0.0        0.18 ±  5%  perf-profile.children.cycles-pp.memset_orig
      0.23 ±  5%      -0.0        0.19 ±  3%  perf-profile.children.cycles-pp.pcpu_alloc_noprof
      0.17 ±  4%      -0.0        0.13 ±  5%  perf-profile.children.cycles-pp.vma_complete
      0.16 ±  3%      -0.0        0.11 ±  4%  perf-profile.children.cycles-pp.get_arg_page
      0.20 ±  8%      -0.0        0.16 ±  4%  perf-profile.children.cycles-pp.__mmdrop
      0.22 ±  8%      -0.0        0.18 ±  4%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.22 ±  6%      -0.0        0.18 ±  6%  perf-profile.children.cycles-pp.enqueue_task
      0.24 ±  5%      -0.0        0.20 ±  3%  perf-profile.children.cycles-pp.lock_vma_under_rcu
      0.26 ±  8%      -0.0        0.22 ±  4%  perf-profile.children.cycles-pp.___perf_sw_event
      0.20 ±  4%      -0.0        0.16 ±  2%  perf-profile.children.cycles-pp.error_entry
      0.18 ±  4%      -0.0        0.14 ±  4%  perf-profile.children.cycles-pp.mas_wr_node_store
      0.17 ± 12%      -0.0        0.13 ±  2%  perf-profile.children.cycles-pp.pte_alloc_one
      0.25 ±  4%      -0.0        0.21 ±  2%  perf-profile.children.cycles-pp.vfs_statx
      0.29 ±  4%      -0.0        0.25 ±  3%  perf-profile.children.cycles-pp.__vfork
      0.20 ±  4%      -0.0        0.16 ±  4%  perf-profile.children.cycles-pp.lookup_fast
      0.17 ±  6%      -0.0        0.13 ±  5%  perf-profile.children.cycles-pp.vma_modify_flags
      0.28 ±  8%      -0.0        0.24 ±  5%  perf-profile.children.cycles-pp.__perf_sw_event
      0.15 ±  7%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.rep_stos_alternative
      0.14 ±  7%      -0.0        0.10 ±  9%  perf-profile.children.cycles-pp.sched_balance_domains
      0.14 ± 19%      -0.0        0.10 ±  8%  perf-profile.children.cycles-pp.__d_lookup_rcu
      0.18 ±  4%      -0.0        0.14 ±  6%  perf-profile.children.cycles-pp.__d_alloc
      0.07 ± 15%      -0.0        0.04 ± 71%  perf-profile.children.cycles-pp.delay_tsc
      0.24 ±  5%      -0.0        0.20 ±  5%  perf-profile.children.cycles-pp.mas_find
      0.22 ±  4%      -0.0        0.18 ±  2%  perf-profile.children.cycles-pp.dup_task_struct
      0.18 ±  2%      -0.0        0.15 ±  3%  perf-profile.children.cycles-pp.__x64_sys_close
      0.40 ±  9%      -0.0        0.36 ±  3%  perf-profile.children.cycles-pp.anon_vma_fork
      0.08 ±  8%      -0.0        0.05 ± 45%  perf-profile.children.cycles-pp.__get_next_timer_interrupt
      0.24 ±  2%      -0.0        0.20 ±  5%  perf-profile.children.cycles-pp.fstatat64
      0.17 ±  5%      -0.0        0.13 ±  2%  perf-profile.children.cycles-pp.shmem_file_write_iter
      0.16 ±  6%      -0.0        0.13 ±  5%  perf-profile.children.cycles-pp.vma_modify
      0.13 ±  2%      -0.0        0.10 ±  9%  perf-profile.children.cycles-pp.vma_interval_tree_insert
      0.14 ± 11%      -0.0        0.11 ±  7%  perf-profile.children.cycles-pp.ktime_get
      0.15 ±  7%      -0.0        0.11 ±  8%  perf-profile.children.cycles-pp.rep_movs_alternative
      0.17 ±  7%      -0.0        0.14 ±  5%  perf-profile.children.cycles-pp.__get_unmapped_area
      0.22 ±  5%      -0.0        0.18 ±  4%  perf-profile.children.cycles-pp.__slab_free
      0.14 ±  4%      -0.0        0.11 ± 12%  perf-profile.children.cycles-pp.sched_balance_update_blocked_averages
      0.14 ±  5%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.step_into
      0.17 ±  7%      -0.0        0.14 ±  5%  perf-profile.children.cycles-pp.__fput
      0.21 ±  6%      -0.0        0.18 ±  4%  perf-profile.children.cycles-pp.copy_mc_enhanced_fast_string
      0.15 ±  6%      -0.0        0.12 ±  8%  perf-profile.children.cycles-pp.__wait_for_common
      0.14 ±  5%      -0.0        0.11 ±  6%  perf-profile.children.cycles-pp.wait_for_completion_state
      0.11 ±  6%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.rcu_sched_clock_irq
      0.09 ±  5%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.clockevents_program_event
      0.14 ±  5%      -0.0        0.11 ±  8%  perf-profile.children.cycles-pp.__libc_early_init
      0.13 ±  7%      -0.0        0.10 ±  5%  perf-profile.children.cycles-pp.enqueue_entity
      0.14 ±  6%      -0.0        0.11 ±  3%  perf-profile.children.cycles-pp.generic_perform_write
      0.12 ±  6%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.get_user_pages_remote
      0.11 ±  8%      -0.0        0.08 ± 12%  perf-profile.children.cycles-pp.sched_balance_softirq
      0.19 ±  5%      -0.0        0.16 ±  2%  perf-profile.children.cycles-pp.__lruvec_stat_mod_folio
      0.18 ±  6%      -0.0        0.14 ±  5%  perf-profile.children.cycles-pp.task_tick_fair
      0.14 ±  5%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.sched_move_task
      0.11 ±  6%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.__get_user_pages
      0.15 ±  6%      -0.0        0.12 ±  5%  perf-profile.children.cycles-pp.schedule_timeout
      0.17 ±  5%      -0.0        0.14 ±  4%  perf-profile.children.cycles-pp.__do_wait
      0.12 ±  7%      -0.0        0.09 ±  4%  perf-profile.children.cycles-pp.perf_rotate_context
      0.16 ±  9%      -0.0        0.13 ±  2%  perf-profile.children.cycles-pp.flush_tlb_mm_range
      0.21 ±  6%      -0.0        0.18 ±  3%  perf-profile.children.cycles-pp.vma_merge_new_range
      0.14 ±  4%      -0.0        0.11 ±  6%  perf-profile.children.cycles-pp.kmem_cache_alloc_lru_noprof
      0.15 ±  6%      -0.0        0.12 ±  7%  perf-profile.children.cycles-pp.pipe_read
      0.06 ±  6%      -0.0        0.03 ± 70%  perf-profile.children.cycles-pp.strnlen_user
      0.14 ±  7%      -0.0        0.11 ±  5%  perf-profile.children.cycles-pp.vma_prepare
      0.15 ±  3%      -0.0        0.12 ±  6%  perf-profile.children.cycles-pp.__x64_sys_munmap
      0.16 ±  4%      -0.0        0.13 ±  8%  perf-profile.children.cycles-pp.up_write
      0.25 ±  4%      -0.0        0.22 ±  4%  perf-profile.children.cycles-pp.__x64_sys_vfork
      0.13 ±  5%      -0.0        0.10 ±  5%  perf-profile.children.cycles-pp.dequeue_entity
      0.14 ±  5%      -0.0        0.11 ±  4%  perf-profile.children.cycles-pp.setup_arg_pages
      0.11 ±  6%      -0.0        0.08 ±  7%  perf-profile.children.cycles-pp.__mem_cgroup_charge
      0.12 ±  5%      -0.0        0.10 ±  8%  perf-profile.children.cycles-pp.__rseq_handle_notify_resume
      0.12 ±  7%      -0.0        0.10 ±  7%  perf-profile.children.cycles-pp.arch_get_unmapped_area_topdown
      0.15 ±  7%      -0.0        0.13 ±  5%  perf-profile.children.cycles-pp.try_to_wake_up
      0.10 ±  4%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.12 ±  7%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.wait_task_zombie
      0.15 ±  4%      -0.0        0.13 ±  6%  perf-profile.children.cycles-pp.__x64_sys_unlink
      0.18 ±  4%      -0.0        0.16 ±  6%  perf-profile.children.cycles-pp.sock_write_iter
      0.15 ±  4%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.08 ±  8%      -0.0        0.06        perf-profile.children.cycles-pp.copy_string_kernel
      0.10 ±  5%      -0.0        0.07 ±  8%  perf-profile.children.cycles-pp.do_dentry_open
      0.09            -0.0        0.06 ± 11%  perf-profile.children.cycles-pp.enqueue_hrtimer
      0.07 ±  5%      -0.0        0.04 ± 45%  perf-profile.children.cycles-pp.read_tsc
      0.12 ±  3%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.begin_new_exec
      0.11 ±  7%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.folio_add_file_rmap_ptes
      0.12 ±  6%      -0.0        0.09        perf-profile.children.cycles-pp.relocate_vma_down
      0.10 ± 10%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.free_unref_folios
      0.10 ± 10%      -0.0        0.07 ±  9%  perf-profile.children.cycles-pp.irq_enter_rcu
      0.11 ±  4%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.vfs_open
      0.07 ± 10%      -0.0        0.04 ± 45%  perf-profile.children.cycles-pp.free_unref_page
      0.06 ±  7%      -0.0        0.04 ± 44%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.10 ±  9%      -0.0        0.08 ±  8%  perf-profile.children.cycles-pp.__vmf_anon_prepare
      0.15 ±  5%      -0.0        0.12 ±  6%  perf-profile.children.cycles-pp.do_unlinkat
      0.13 ±  6%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.mas_wr_bnode
      0.10 ±  6%      -0.0        0.08 ±  8%  perf-profile.children.cycles-pp.release_task
      0.10 ±  7%      -0.0        0.08 ±  7%  perf-profile.children.cycles-pp.sched_exec
      0.10 ±  8%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.inode_permission
      0.08 ± 10%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.08 ±  9%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.pgd_alloc
      0.08 ±  6%      -0.0        0.06 ± 13%  perf-profile.children.cycles-pp.timerqueue_add
      0.08 ±  4%      -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.timerqueue_del
      0.11 ± 10%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.__vm_area_free
      0.18 ±  7%      -0.0        0.16 ±  4%  perf-profile.children.cycles-pp.__wp_page_copy_user
      0.10 ±  8%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.do_open_execat
      0.09 ±  8%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.get_free_pages_noprof
      0.11 ±  5%      -0.0        0.09 ±  7%  perf-profile.children.cycles-pp.rseq_ip_fixup
      0.09 ±  7%      -0.0        0.07 ±  9%  perf-profile.children.cycles-pp.vm_unmapped_area
      0.08 ± 10%      -0.0        0.06 ± 15%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.08 ± 11%      -0.0        0.06 ± 11%  perf-profile.children.cycles-pp.tick_irq_enter
      0.10 ± 11%      -0.0        0.08 ±  8%  perf-profile.children.cycles-pp.memcpy_orig
      0.12 ±  7%      -0.0        0.10        perf-profile.children.cycles-pp.alloc_thread_stack_node
      0.08 ±  9%      -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.native_sched_clock
      0.07 ±  9%      -0.0        0.05 ±  7%  perf-profile.children.cycles-pp.__call_rcu_common
      0.07 ±  5%      -0.0        0.05 ±  7%  perf-profile.children.cycles-pp.perf_event_task_output
      0.11 ±  3%      -0.0        0.09 ±  4%  perf-profile.children.cycles-pp.sync
      0.12 ±  7%      -0.0        0.10 ±  3%  perf-profile.children.cycles-pp.arch_do_signal_or_restart
      0.15 ±  3%      -0.0        0.13 ±  5%  perf-profile.children.cycles-pp.folio_batch_move_lru
      0.10 ±  5%      -0.0        0.08        perf-profile.children.cycles-pp.handle_pte_fault
      0.14 ±  2%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.vm_area_alloc
      0.07 ±  6%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.update_irq_load_avg
      0.09 ±  6%      -0.0        0.07 ±  9%  perf-profile.children.cycles-pp.__put_user_8
      0.07            -0.0        0.05 ±  7%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.09 ±  5%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.getname_flags
      0.07 ±  8%      -0.0        0.05 ±  7%  perf-profile.children.cycles-pp.unlink_file_vma_batch_final
      0.09 ±  6%      -0.0        0.07 ±  9%  perf-profile.children.cycles-pp.vma_link_file
      0.07 ± 14%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.fput
      0.08 ± 10%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.shmem_write_begin
      0.06            -0.0        0.04 ± 44%  perf-profile.children.cycles-pp.terminate_walk
      0.10 ±  4%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.__x64_sys_sync
      0.12 ±  4%      -0.0        0.10 ±  3%  perf-profile.children.cycles-pp.kill_something_info
      0.10 ±  4%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.ksys_sync
      0.08 ± 13%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.task_work_run
      0.13            -0.0        0.11 ±  6%  perf-profile.children.cycles-pp.try_to_block_task
      0.07 ± 15%      -0.0        0.05 ±  7%  perf-profile.children.cycles-pp.d_path
      0.07 ±  5%      -0.0        0.05 ±  7%  perf-profile.children.cycles-pp.exec_mmap
      0.07 ± 10%      -0.0        0.05 ±  7%  perf-profile.children.cycles-pp.free_unref_page_commit
      0.10 ±  4%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.__percpu_counter_init_many
      0.15 ±  3%      -0.0        0.13 ±  3%  perf-profile.children.cycles-pp.lru_add_drain_cpu
      0.09 ±  8%      -0.0        0.07        perf-profile.children.cycles-pp.shmem_get_folio_gfp
      0.09 ±  4%      -0.0        0.07 ±  9%  perf-profile.children.cycles-pp.try_to_unlazy
      0.08 ±  4%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.vma_interval_tree_remove
      0.15 ±  4%      -0.0        0.13 ±  3%  perf-profile.children.cycles-pp.lru_add_drain
      0.08 ±  9%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.__pud_alloc
      0.07 ± 10%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.create_elf_tables
      0.08 ±  6%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.08 ±  8%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.shmem_mknod
      0.09 ± 10%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.__page_cache_release
      0.08 ±  6%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.__memcg_kmem_charge_page
      0.07 ± 11%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.pipe_write
      0.20 ±  5%      +0.0        0.22 ±  2%  perf-profile.children.cycles-pp.__close
      0.10 ±  5%      +0.0        0.12 ±  6%  perf-profile.children.cycles-pp.__local_bh_enable_ip
      0.24 ±  5%      +0.0        0.28 ±  3%  perf-profile.children.cycles-pp.__libc_fork
      0.37 ±  4%      +0.0        0.40 ±  2%  perf-profile.children.cycles-pp.read_write_close
      0.09 ±  7%      +0.0        0.12 ±  5%  perf-profile.children.cycles-pp.do_softirq
      0.50 ±  3%      +0.0        0.54        perf-profile.children.cycles-pp.creat64
      0.52 ±  5%      +0.0        0.56 ±  2%  perf-profile.children.cycles-pp.page_test
      0.81 ±  4%      +0.0        0.86 ±  2%  perf-profile.children.cycles-pp.brk
      2.19 ±  2%      +0.1        2.29        perf-profile.children.cycles-pp._Fork
      1.10 ± 31%      +0.5        1.56 ± 11%  perf-profile.children.cycles-pp._raw_spin_lock
      0.73 ± 43%      +0.5        1.24 ± 13%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.92 ± 38%      +0.5        1.43 ± 12%  perf-profile.children.cycles-pp.dcache_readdir
      0.92 ± 37%      +0.5        1.43 ± 12%  perf-profile.children.cycles-pp.__x64_sys_getdents64
      0.92 ± 37%      +0.5        1.43 ± 12%  perf-profile.children.cycles-pp.iterate_dir
      0.81 ± 42%      +0.5        1.34 ± 13%  perf-profile.children.cycles-pp.scan_positives
      0.80 ± 38%      +0.6        1.44 ± 12%  perf-profile.children.cycles-pp.getdents64
     66.36            +5.5       71.91        perf-profile.children.cycles-pp.sieve
     69.78            +5.8       75.54        perf-profile.children.cycles-pp.main
     69.74            +5.8       75.52        perf-profile.children.cycles-pp.multiuser
     69.73            +5.8       75.51        perf-profile.children.cycles-pp.runloop
      6.29 ±  2%      -0.6        5.66 ±  2%  perf-profile.self.cycles-pp.intel_idle
      0.88 ±  2%      -0.2        0.68 ±  3%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.67 ±  5%      -0.1        0.54 ±  2%  perf-profile.self.cycles-pp.__irqentry_text_end
      0.56 ±  3%      -0.1        0.45 ±  2%  perf-profile.self.cycles-pp.zap_present_ptes
      0.41 ±  5%      -0.1        0.32 ±  2%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.48 ±  5%      -0.1        0.39 ±  3%  perf-profile.self.cycles-pp.next_uptodate_folio
      0.38 ±  6%      -0.1        0.29 ±  3%  perf-profile.self.cycles-pp.clear_page_erms
      0.40 ±  4%      -0.1        0.32 ±  4%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.26 ±  5%      -0.1        0.19 ±  3%  perf-profile.self.cycles-pp.copy_present_ptes
      0.42 ±  9%      -0.1        0.35        perf-profile.self.cycles-pp._raw_spin_lock
      0.31 ±  4%      -0.1        0.25 ±  4%  perf-profile.self.cycles-pp.__memcg_slab_post_alloc_hook
      0.38 ±  6%      -0.1        0.32 ±  5%  perf-profile.self.cycles-pp.filemap_map_pages
      0.26 ±  5%      -0.1        0.21 ±  2%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.20 ±  9%      -0.0        0.15 ±  5%  perf-profile.self.cycles-pp.mas_walk
      0.24 ±  5%      -0.0        0.20 ±  5%  perf-profile.self.cycles-pp.folio_remove_rmap_ptes
      0.28 ±  4%      -0.0        0.24 ±  3%  perf-profile.self.cycles-pp.kmem_cache_alloc_noprof
      0.24 ±  9%      -0.0        0.20 ±  3%  perf-profile.self.cycles-pp.___perf_sw_event
      0.20 ±  4%      -0.0        0.16 ±  2%  perf-profile.self.cycles-pp.error_entry
      0.12 ±  6%      -0.0        0.09 ±  5%  perf-profile.self.cycles-pp.menu_select
      0.14 ± 19%      -0.0        0.10 ±  6%  perf-profile.self.cycles-pp.__d_lookup_rcu
      0.23 ±  5%      -0.0        0.19 ±  6%  perf-profile.self.cycles-pp.update_sg_lb_stats
      0.20 ±  4%      -0.0        0.17 ±  4%  perf-profile.self.cycles-pp.update_sg_wakeup_stats
      0.21 ±  6%      -0.0        0.17 ±  6%  perf-profile.self.cycles-pp.__memcg_slab_free_hook
      0.21 ±  8%      -0.0        0.18 ±  5%  perf-profile.self.cycles-pp.kmem_cache_free
      0.13 ±  4%      -0.0        0.10 ±  8%  perf-profile.self.cycles-pp.vma_interval_tree_insert
      0.19 ±  3%      -0.0        0.16 ±  6%  perf-profile.self.cycles-pp.folios_put_refs
      0.20 ±  7%      -0.0        0.16 ±  7%  perf-profile.self.cycles-pp.__handle_mm_fault
      0.21 ±  6%      -0.0        0.18 ±  5%  perf-profile.self.cycles-pp.__slab_free
      0.20 ±  6%      -0.0        0.17 ±  4%  perf-profile.self.cycles-pp.copy_mc_enhanced_fast_string
      0.16 ±  7%      -0.0        0.13 ±  5%  perf-profile.self.cycles-pp.down_write
      0.16 ±  9%      -0.0        0.13 ±  3%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.15 ±  7%      -0.0        0.12 ±  6%  perf-profile.self.cycles-pp.up_write
      0.10 ±  9%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.cpuidle_enter_state
      0.21 ±  4%      -0.0        0.18 ±  5%  perf-profile.self.cycles-pp.memset_orig
      0.15 ±  7%      -0.0        0.12 ±  7%  perf-profile.self.cycles-pp.zap_pte_range
      0.16 ±  3%      -0.0        0.13 ±  5%  perf-profile.self.cycles-pp.free_pages_and_swap_cache
      0.12 ±  9%      -0.0        0.09 ± 10%  perf-profile.self.cycles-pp.rep_movs_alternative
      0.10 ±  6%      -0.0        0.07 ±  9%  perf-profile.self.cycles-pp.update_load_avg
      0.10 ±  4%      -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.folio_add_file_rmap_ptes
      0.08 ±  9%      -0.0        0.06 ± 13%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.08 ±  4%      -0.0        0.06 ± 11%  perf-profile.self.cycles-pp.mas_wr_node_store
      0.09 ±  9%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.__cond_resched
      0.08 ±  7%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.set_pte_range
      0.08 ±  8%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.vma_interval_tree_remove
      0.11 ±  7%      -0.0        0.09 ±  5%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.07 ±  6%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.07 ±  7%      -0.0        0.05 ±  7%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.07 ±  7%      -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.update_irq_load_avg
      0.06 ±  7%      -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.__task_pid_nr_ns
      0.72 ± 43%      +0.5        1.23 ± 13%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
     65.88            +5.5       71.36        perf-profile.self.cycles-pp.sieve
      0.06 ± 62%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.__pmd_alloc.__handle_mm_fault
      0.07 ± 25%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.__pmd_alloc.copy_p4d_range
      0.12 ± 31%     -95.3%       0.01 ±223%  perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof.shmem_alloc_folio
      0.05 ± 72%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.get_free_pages_noprof.pgd_alloc
      0.07 ± 14%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.pte_alloc_one.__pte_alloc
      0.10 ± 81%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__anon_vma_prepare.__vmf_anon_prepare.do_anonymous_page.__handle_mm_fault
      0.06 ± 81%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__anon_vma_prepare.__vmf_anon_prepare.do_fault.__handle_mm_fault
      0.10 ± 83%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__dentry_kill.dput.step_into.link_path_walk
      0.03 ± 63%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__get_user_pages.get_user_pages_remote.get_arg_page.copy_strings
      0.12 ± 44%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__kmalloc_cache_node_noprof.__get_vm_area_node.__vmalloc_node_range_noprof.alloc_thread_stack_node
      0.08 ± 27%     -97.4%       0.00 ±223%  perf-sched.sch_delay.avg.ms.__cond_resched.__kmalloc_cache_noprof.perf_event_mmap_event.perf_event_mmap.mmap_region
      0.02 ± 35%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__kmalloc_noprof.load_elf_phdrs.load_elf_binary.search_binary_handler
      0.13 ± 60%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__kmalloc_noprof.lsm_blob_alloc.security_prepare_creds.prepare_creds
      0.08 ± 28%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__kmalloc_noprof.lsm_blob_alloc.security_task_alloc.copy_process
      0.08 ± 75%     -86.8%       0.01 ±187%  perf-sched.sch_delay.avg.ms.__cond_resched.__kmalloc_noprof.security_inode_init_security.shmem_mknod.lookup_open
      0.05 ± 26%     -96.9%       0.00 ±142%  perf-sched.sch_delay.avg.ms.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables.exit_mmap
      0.17 ± 57%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__release_sock.release_sock.tcp_sendmsg.sock_write_iter
      0.07 ± 10%     -99.5%       0.00 ±223%  perf-sched.sch_delay.avg.ms.__cond_resched.__tlb_batch_free_encoded_pages.tlb_finish_mmu.exit_mmap.mmput
      0.05 ± 58%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__tlb_batch_free_encoded_pages.tlb_finish_mmu.relocate_vma_down.setup_arg_pages
      0.08 ± 50%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__vmalloc_area_node.__vmalloc_node_range_noprof.alloc_thread_stack_node.dup_task_struct
      0.06 ±  8%   +2931.0%       1.82 ±  4%  perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.10 ± 28%     -86.9%       0.01 ±144%  perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.wait_for_completion_state.kernel_clone.__x64_sys_vfork
      0.15 ± 54%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.aa_sk_perm.security_socket_recvmsg.sock_recvmsg.sock_read_iter
      0.14 ± 33%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.aa_sk_perm.security_socket_sendmsg.sock_write_iter.vfs_write
      0.06 ± 46%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.apparmor_file_alloc_security.security_file_alloc.init_file.alloc_empty_file
      0.10 ± 57%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.cgroup_css_set_fork.cgroup_can_fork.copy_process.kernel_clone
      0.12 ± 61%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.change_pmd_range.isra.0.change_pud_range
      0.06 ± 41%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.change_pud_range.isra.0.change_protection_range
      0.10 ± 34%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.copy_page_range.dup_mmap.dup_mm.constprop
      0.07 ± 64%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.copy_strings.isra.0.do_execveat_common
      0.15 ± 85%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.count.constprop.0.isra
      0.06 ± 53%     -97.1%       0.00 ±145%  perf-sched.sch_delay.avg.ms.__cond_resched.down_read.acct_collect.do_exit.do_group_exit
      0.10 ± 23%     -97.3%       0.00 ±223%  perf-sched.sch_delay.avg.ms.__cond_resched.down_read.walk_component.link_path_walk.part
      0.11 ± 50%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_read.walk_component.path_lookupat.filename_lookup
      0.13 ±132%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write.__anon_vma_prepare.__vmf_anon_prepare.do_anonymous_page
      0.04 ±122%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write.anon_vma_clone.__split_vma.vma_modify
      0.09 ± 18%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write.anon_vma_clone.anon_vma_fork.dup_mmap
      0.08 ± 24%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write.anon_vma_fork.dup_mmap.dup_mm
      0.16 ± 49%     -89.1%       0.02 ±184%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.do_truncate.do_open.path_openat
      0.08 ± 16%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write.free_pgtables.exit_mmap.mmput
      0.08 ± 41%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write.mmap_region.do_mmap.vm_mmap_pgoff
      0.02 ± 46%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write.shmem_file_write_iter.vfs_write.ksys_write
      0.10 ± 62%     -99.0%       0.00 ±223%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.unlink_anon_vmas.free_pgtables.exit_mmap
      0.07 ± 36%     -96.1%       0.00 ±155%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.vma_link_file.mmap_region.do_mmap
      0.11 ±150%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write.vma_prepare.__split_vma.vma_modify
      0.11 ± 45%     -76.5%       0.02 ±173%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.vma_prepare.commit_merge.vma_expand
      0.14 ± 67%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write.vms_gather_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap
      0.05 ±120%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write_killable.create_elf_tables.load_elf_binary.search_binary_handler
      0.02 ± 16%     -68.9%       0.01 ±112%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
      0.05 ± 51%     -97.5%       0.00 ±223%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write_killable.setup_arg_pages.load_elf_binary.search_binary_handler
      0.03 ± 89%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write_killable.vm_brk_flags.elf_load.load_elf_binary
      0.06 ± 58%     -98.7%       0.00 ±223%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.elf_load.load_elf_binary
      0.10 ± 33%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
      0.14 ± 70%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.dput.do_linkat.__x64_sys_link.do_syscall_64
      0.09 ±110%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.dput.path_put.exit_fs.do_exit
      0.14 ± 33%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.dput.path_put.vfs_statx.vfs_fstatat
      0.08 ± 17%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.dput.step_into.link_path_walk.part
      0.13 ± 65%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.dput.step_into.open_last_lookups.path_openat
      0.11 ± 80%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.dput.step_into.path_lookupat.filename_lookup
      0.14 ± 73%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.dput.terminate_walk.path_lookupat.filename_lookup
      0.04 ±130%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.exit_signals.do_exit.do_group_exit.__x64_sys_exit_group
      0.05 ± 54%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.filemap_read.__kernel_read.search_binary_handler.exec_binprm
      0.14 ± 20%     -87.1%       0.02 ±150%  perf-sched.sch_delay.avg.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      0.09 ± 41%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_lru_noprof.__d_alloc.d_alloc.d_alloc_parallel
      0.07 ± 39%     -93.0%       0.00 ±223%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_node_noprof.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
      0.11 ± 72%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_node_noprof.dup_task_struct.copy_process.kernel_clone
      0.10 ± 35%     -93.8%       0.01 ±182%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_pid.copy_process.kernel_clone
      0.10 ± 25%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.anon_vma_fork.dup_mmap.dup_mm
      0.09 ± 37%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.copy_fs_struct.copy_process.kernel_clone
      0.07 ± 92%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.copy_signal.copy_process.kernel_clone
      0.05 ± 54%     -96.3%       0.00 ±223%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.dup_mm.constprop.0
      0.14 ± 88%     -97.8%       0.00 ±223%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.__split_vma
      0.08 ± 25%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.mmap_region
      0.08 ±121%     -99.2%       0.00 ±223%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.vma_link
      0.09 ± 18%     -93.4%       0.01 ±223%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.prepare_creds.copy_creds.copy_process
      0.08 ± 49%     -90.9%       0.01 ±223%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.security_inode_alloc.inode_init_always.alloc_inode
      0.03 ±106%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc.__bprm_mm_init.alloc_bprm
      0.07 ± 85%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc._install_special_mapping.map_vdso
      0.10 ± 72%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc.do_brk_flags.__do_sys_brk
      0.09 ± 77%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.vma_modify
      0.08 ± 41%     -91.9%       0.01 ±148%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.vms_gather_munmap_vmas
      0.09 ± 11%     -92.8%       0.01 ±223%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_dup.dup_mmap.dup_mm
      0.11 ±112%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.mmput.exec_mmap.begin_new_exec.load_elf_binary
      0.09 ± 96%     -97.5%       0.00 ±223%  perf-sched.sch_delay.avg.ms.__cond_resched.mnt_want_write.do_unlinkat.__x64_sys_unlink.do_syscall_64
      0.08 ± 74%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.mnt_want_write.open_last_lookups.path_openat.do_filp_open
      0.02 ± 56%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock.futex_exec_release.exec_mm_release.exec_mmap
      0.06 ± 49%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock.futex_exit_release.exit_mm_release.exit_mm
      0.11 ± 68%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock.pipe_read.vfs_read.ksys_read
      0.06 ± 36%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock_killable.pcpu_alloc_noprof.__percpu_counter_init_many.mm_init
      0.02 ± 63%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock_killable.pcpu_alloc_noprof.mm_init.alloc_bprm
      0.07 ± 24%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock_killable.pcpu_alloc_noprof.mm_init.dup_mm
      0.09 ± 39%     -99.5%       0.00 ±223%  perf-sched.sch_delay.avg.ms.__cond_resched.put_files_struct.do_exit.do_group_exit.__x64_sys_exit_group
      0.06 ± 24%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.remove_vma.exit_mmap.mmput.exit_mm
      0.24 ±211%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.remove_vma.vms_complete_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap
      0.08 ± 68%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.remove_vma.vms_complete_munmap_vmas.mmap_region.do_mmap
      0.09 ± 90%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.shmem_get_folio_gfp.shmem_file_read_iter.vfs_read.ksys_read
      0.08 ±118%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
      0.14 ± 72%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.shmem_undo_range.shmem_evict_inode.evict.__dentry_kill
      0.06 ±  6%    +217.5%       0.19 ± 16%  perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.11 ± 30%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.super_lock.iterate_supers.ksys_sync.__x64_sys_sync
      0.15 ±162%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.switch_task_namespaces.do_exit.do_group_exit.__x64_sys_exit_group
      0.06 ± 71%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.task_work_run.do_exit.do_group_exit.__x64_sys_exit_group
      0.18 ± 88%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.task_work_run.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.06 ± 30%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.unmap_vmas.exit_mmap.mmput.exit_mm
      0.07 ± 60%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.unmap_vmas.vms_clear_ptes.vms_clean_up_area.mmap_region
      0.13 ± 73%     -99.3%       0.00 ±223%  perf-sched.sch_delay.avg.ms.__cond_resched.unmap_vmas.vms_clear_ptes.vms_complete_munmap_vmas.mmap_region
      0.09 ± 27%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.uprobe_start_dup_mmap.dup_mmap.dup_mm.constprop
      0.12           +18.7%       0.15        perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.09 ± 16%     -44.7%       0.05 ± 57%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      0.12 ±  4%     -23.5%       0.10 ± 15%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      0.09 ± 24%     -97.0%       0.00 ±223%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
      0.11 ± 14%     -93.8%       0.01 ±182%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown].[unknown]
      0.09 ± 26%     -92.4%       0.01 ±223%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      0.14 ±  2%     -42.0%       0.08 ± 37%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
      0.06 ±  2%     +19.8%       0.08 ±  3%  perf-sched.sch_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.06 ± 12%    +188.2%       0.17 ± 40%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.01 ± 72%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.unlink_file_vma_batch_final
      0.08 ±  2%     +74.7%       0.13 ±  5%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.02 ± 22%   +9365.4%       2.15 ± 43%  perf-sched.sch_delay.avg.ms.schedule_timeout.io_schedule_timeout.__wait_for_common.blk_execute_rq
      0.07 ± 28%    +480.6%       0.39 ± 57%  perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.04 ±  2%    +417.9%       0.22 ±  5%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.02 ±  6%   +4557.3%       0.91        perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.04 ± 36%     -97.3%       0.00 ±223%  perf-sched.sch_delay.avg.ms.syscall_exit_to_user_mode.ret_from_fork_asm.[unknown]
      0.10 ± 35%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.syscall_exit_to_user_mode.ret_from_fork_asm.[unknown].[unknown]
      0.05 ±  4%   +2256.8%       1.22 ±  3%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.27 ± 80%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.__pmd_alloc.__handle_mm_fault
      0.26 ± 19%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.__pmd_alloc.copy_p4d_range
      0.29 ± 38%     -98.0%       0.01 ±223%  perf-sched.sch_delay.max.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof.shmem_alloc_folio
      0.10 ± 80%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.get_free_pages_noprof.pgd_alloc
      0.41 ± 34%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.pte_alloc_one.__pte_alloc
      0.47 ±105%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__anon_vma_prepare.__vmf_anon_prepare.do_anonymous_page.__handle_mm_fault
      0.17 ± 90%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__anon_vma_prepare.__vmf_anon_prepare.do_fault.__handle_mm_fault
      0.31 ± 74%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__dentry_kill.dput.step_into.link_path_walk
      0.49 ± 69%     -94.2%       0.03 ±223%  perf-sched.sch_delay.max.ms.__cond_resched.__do_fault.do_read_fault.do_fault.__handle_mm_fault
      0.07 ± 73%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__get_user_pages.get_user_pages_remote.get_arg_page.copy_strings
      0.22 ± 23%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__kmalloc_cache_node_noprof.__get_vm_area_node.__vmalloc_node_range_noprof.alloc_thread_stack_node
      0.57 ± 42%     -99.6%       0.00 ±223%  perf-sched.sch_delay.max.ms.__cond_resched.__kmalloc_cache_noprof.perf_event_mmap_event.perf_event_mmap.mmap_region
      0.07 ± 31%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__kmalloc_noprof.load_elf_phdrs.load_elf_binary.search_binary_handler
      0.49 ± 60%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__kmalloc_noprof.lsm_blob_alloc.security_prepare_creds.prepare_creds
      0.21 ± 36%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__kmalloc_noprof.lsm_blob_alloc.security_task_alloc.copy_process
      0.13 ± 82%     -91.7%       0.01 ±187%  perf-sched.sch_delay.max.ms.__cond_resched.__kmalloc_noprof.security_inode_init_security.shmem_mknod.lookup_open
      0.66 ± 41%     -99.8%       0.00 ±142%  perf-sched.sch_delay.max.ms.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables.exit_mmap
      0.23 ± 37%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__release_sock.release_sock.tcp_sendmsg.sock_write_iter
      1.38 ± 46%    -100.0%       0.00 ±223%  perf-sched.sch_delay.max.ms.__cond_resched.__tlb_batch_free_encoded_pages.tlb_finish_mmu.exit_mmap.mmput
      0.19 ± 84%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__tlb_batch_free_encoded_pages.tlb_finish_mmu.relocate_vma_down.setup_arg_pages
      0.25 ± 60%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__vmalloc_area_node.__vmalloc_node_range_noprof.alloc_thread_stack_node.dup_task_struct
      2.77 ± 42%    +823.0%      25.54 ±  6%  perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      1.08 ± 29%     -98.8%       0.01 ±144%  perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.wait_for_completion_state.kernel_clone.__x64_sys_vfork
      0.37 ± 65%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.aa_sk_perm.security_socket_recvmsg.sock_recvmsg.sock_read_iter
      0.28 ± 51%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.aa_sk_perm.security_socket_sendmsg.sock_write_iter.vfs_write
      0.19 ± 60%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.apparmor_file_alloc_security.security_file_alloc.init_file.alloc_empty_file
      0.59 ±149%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.cgroup_css_set_fork.cgroup_can_fork.copy_process.kernel_clone
      0.18 ± 70%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.change_pmd_range.isra.0.change_pud_range
      0.41 ± 43%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.change_pud_range.isra.0.change_protection_range
      0.22 ± 35%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.copy_page_range.dup_mmap.dup_mm.constprop
      0.82 ± 30%     -95.8%       0.03 ±207%  perf-sched.sch_delay.max.ms.__cond_resched.copy_pte_range.copy_p4d_range.copy_page_range.dup_mmap
      0.50 ± 54%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.copy_strings.isra.0.do_execveat_common
      0.34 ± 93%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.count.constprop.0.isra
      0.56 ± 64%     -99.7%       0.00 ±145%  perf-sched.sch_delay.max.ms.__cond_resched.down_read.acct_collect.do_exit.do_group_exit
      0.58 ± 40%     -99.5%       0.00 ±223%  perf-sched.sch_delay.max.ms.__cond_resched.down_read.walk_component.link_path_walk.part
      0.35 ± 85%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_read.walk_component.path_lookupat.filename_lookup
      0.19 ± 87%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write.__anon_vma_prepare.__vmf_anon_prepare.do_anonymous_page
      0.11 ±145%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write.anon_vma_clone.__split_vma.vma_modify
      0.38 ± 21%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write.anon_vma_clone.anon_vma_fork.dup_mmap
      0.22 ± 21%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write.anon_vma_fork.dup_mmap.dup_mm
      0.87 ±110%     -97.0%       0.03 ±197%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.do_truncate.do_open.path_openat
      0.48 ± 42%     -93.4%       0.03 ±223%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.dup_mmap.dup_mm.constprop
      1.03 ± 50%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write.free_pgtables.exit_mmap.mmput
      0.27 ± 45%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write.mmap_region.do_mmap.vm_mmap_pgoff
      0.02 ± 43%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write.shmem_file_write_iter.vfs_write.ksys_write
      0.50 ± 48%     -99.8%       0.00 ±223%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.unlink_anon_vmas.free_pgtables.exit_mmap
      0.37 ± 46%     -99.3%       0.00 ±155%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.vma_link_file.mmap_region.do_mmap
      0.27 ±147%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write.vma_prepare.__split_vma.vma_modify
      0.24 ± 83%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write.vms_gather_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap
      0.17 ±154%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.create_elf_tables.load_elf_binary.search_binary_handler
      1.06 ± 27%     -99.2%       0.01 ±125%  perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
      0.17 ± 52%     -99.2%       0.00 ±223%  perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.setup_arg_pages.load_elf_binary.search_binary_handler
      0.07 ±120%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.vm_brk_flags.elf_load.load_elf_binary
      0.30 ± 71%     -99.7%       0.00 ±223%  perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.elf_load.load_elf_binary
      0.41 ± 44%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
      0.30 ± 55%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.dput.do_linkat.__x64_sys_link.do_syscall_64
      0.26 ± 79%     -88.4%       0.03 ±223%  perf-sched.sch_delay.max.ms.__cond_resched.dput.open_last_lookups.path_openat.do_filp_open
      0.24 ±126%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.dput.path_put.exit_fs.do_exit
      0.44 ± 41%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.dput.path_put.vfs_statx.vfs_fstatat
      1.12 ± 34%     -84.3%       0.18 ± 53%  perf-sched.sch_delay.max.ms.__cond_resched.dput.scan_positives.dcache_readdir.iterate_dir
      0.22 ± 45%     -82.5%       0.04 ±210%  perf-sched.sch_delay.max.ms.__cond_resched.dput.shmem_unlink.vfs_unlink.do_unlinkat
      0.61 ± 43%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.dput.step_into.link_path_walk.part
      0.23 ± 46%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.dput.step_into.open_last_lookups.path_openat
      0.38 ± 97%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.dput.step_into.path_lookupat.filename_lookup
      0.33 ± 88%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.dput.terminate_walk.path_lookupat.filename_lookup
      0.91 ±116%     -88.9%       0.10 ± 95%  perf-sched.sch_delay.max.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
      1.21 ± 37%     -94.3%       0.07 ±218%  perf-sched.sch_delay.max.ms.__cond_resched.exit_mmap.mmput.exit_mm.do_exit
      0.09 ±151%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.exit_signals.do_exit.do_group_exit.__x64_sys_exit_group
      0.28 ± 75%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.filemap_read.__kernel_read.search_binary_handler.exec_binprm
      0.89 ± 14%     -93.2%       0.06 ±146%  perf-sched.sch_delay.max.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      0.30 ± 35%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_lru_noprof.__d_alloc.d_alloc.d_alloc_parallel
      0.13 ± 63%     -96.3%       0.00 ±223%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_node_noprof.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
      0.19 ± 62%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_node_noprof.dup_task_struct.copy_process.kernel_clone
      0.31 ± 54%     -98.1%       0.01 ±182%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_pid.copy_process.kernel_clone
      0.98 ±112%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.anon_vma_fork.dup_mmap.dup_mm
      0.40 ± 59%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.copy_fs_struct.copy_process.kernel_clone
      0.08 ± 77%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.copy_signal.copy_process.kernel_clone
      0.09 ± 75%     -98.2%       0.00 ±223%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.dup_mm.constprop.0
      0.51 ± 89%     -99.4%       0.00 ±223%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.__split_vma
      0.51 ± 57%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.mmap_region
      0.13 ±102%     -99.5%       0.00 ±223%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.vma_link
      0.58 ± 34%     -98.9%       0.01 ±223%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.prepare_creds.copy_creds.copy_process
      0.22 ± 61%     -96.7%       0.01 ±223%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.security_inode_alloc.inode_init_always.alloc_inode
      0.08 ± 77%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc.__bprm_mm_init.alloc_bprm
      0.27 ±117%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc._install_special_mapping.map_vdso
      0.17 ± 80%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc.do_brk_flags.__do_sys_brk
      0.93 ± 31%     -95.1%       0.05 ±219%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc.mmap_region.do_mmap
      0.35 ± 62%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.vma_modify
      0.29 ± 33%     -97.0%       0.01 ±159%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.vms_gather_munmap_vmas
      0.64 ± 43%     -99.0%       0.01 ±223%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_dup.dup_mmap.dup_mm
      0.18 ±105%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.mmput.exec_mmap.begin_new_exec.load_elf_binary
      0.51 ± 58%     -78.7%       0.11 ± 76%  perf-sched.sch_delay.max.ms.__cond_resched.mnt_want_write.do_open.path_openat.do_filp_open
      0.22 ± 97%     -99.0%       0.00 ±223%  perf-sched.sch_delay.max.ms.__cond_resched.mnt_want_write.do_unlinkat.__x64_sys_unlink.do_syscall_64
      0.12 ± 74%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.mnt_want_write.open_last_lookups.path_openat.do_filp_open
      0.03 ± 84%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.futex_exec_release.exec_mm_release.exec_mmap
      0.25 ± 64%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.futex_exit_release.exit_mm_release.exit_mm
      0.17 ± 73%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.pipe_read.vfs_read.ksys_read
      0.65 ± 97%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock_killable.pcpu_alloc_noprof.__percpu_counter_init_many.mm_init
      0.05 ± 98%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock_killable.pcpu_alloc_noprof.mm_init.alloc_bprm
      0.19 ± 39%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock_killable.pcpu_alloc_noprof.mm_init.dup_mm
      0.40 ± 43%     -99.9%       0.00 ±223%  perf-sched.sch_delay.max.ms.__cond_resched.put_files_struct.do_exit.do_group_exit.__x64_sys_exit_group
      0.28 ± 19%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.remove_vma.exit_mmap.mmput.exit_mm
      0.24 ±207%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.remove_vma.vms_complete_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap
      0.25 ± 72%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.remove_vma.vms_complete_munmap_vmas.mmap_region.do_mmap
      0.18 ± 86%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.shmem_get_folio_gfp.shmem_file_read_iter.vfs_read.ksys_read
      0.24 ±144%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
      0.26 ± 38%     -82.5%       0.05 ±136%  perf-sched.sch_delay.max.ms.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin
      0.48 ± 77%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.shmem_undo_range.shmem_evict_inode.evict.__dentry_kill
      3.05 ± 27%   +1002.5%      33.63 ± 17%  perf-sched.sch_delay.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.34 ± 52%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.super_lock.iterate_supers.ksys_sync.__x64_sys_sync
      0.31 ±167%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.switch_task_namespaces.do_exit.do_group_exit.__x64_sys_exit_group
      0.10 ± 61%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.task_work_run.do_exit.do_group_exit.__x64_sys_exit_group
      0.26 ±123%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.task_work_run.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.34 ± 49%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.unmap_vmas.exit_mmap.mmput.exit_mm
      0.14 ± 72%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.unmap_vmas.vms_clear_ptes.vms_clean_up_area.mmap_region
      0.36 ± 81%     -99.7%       0.00 ±223%  perf-sched.sch_delay.max.ms.__cond_resched.unmap_vmas.vms_clear_ptes.vms_complete_munmap_vmas.mmap_region
      0.40 ± 37%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.uprobe_start_dup_mmap.dup_mmap.dup_mm.constprop
      0.19 ± 43%     -86.5%       0.02 ±156%  perf-sched.sch_delay.max.ms.__cond_resched.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.58 ± 34%     -87.9%       0.07 ±213%  perf-sched.sch_delay.max.ms.__cond_resched.wp_page_copy.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      1.40 ± 31%     -88.9%       0.15 ±133%  perf-sched.sch_delay.max.ms.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
      3.97 ± 32%    +285.0%      15.30 ± 31%  perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      1.01 ± 31%    +508.2%       6.14 ± 99%  perf-sched.sch_delay.max.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
      1.06 ± 11%     -88.7%       0.12 ± 71%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      0.43 ± 44%     -99.4%       0.00 ±223%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
      1.15 ± 14%     -99.3%       0.01 ±171%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown].[unknown]
      0.84 ± 51%     -99.1%       0.01 ±223%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      1.59 ± 25%     -63.9%       0.57 ± 60%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
      3.05 ± 20%    +565.2%      20.27 ± 69%  perf-sched.sch_delay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.20 ± 55%   +2047.2%       4.20 ± 45%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.19 ± 49%     -86.6%       0.03 ±151%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.dup_mmap
      0.04 ±108%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.unlink_file_vma_batch_final
      3.80 ± 32%    +567.5%      25.38 ± 20%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.03 ± 24%  +15155.4%       4.96 ± 38%  perf-sched.sch_delay.max.ms.schedule_timeout.io_schedule_timeout.__wait_for_common.blk_execute_rq
      0.21 ± 92%   +1638.3%       3.70 ± 62%  perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.78 ± 36%    +707.2%       6.33 ± 14%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      2.43 ± 29%    +226.7%       7.94 ± 11%  perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      2.52 ± 29%     -64.9%       0.89 ± 83%  perf-sched.sch_delay.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.39 ± 65%     -99.7%       0.00 ±223%  perf-sched.sch_delay.max.ms.syscall_exit_to_user_mode.ret_from_fork_asm.[unknown]
      0.54 ± 43%    -100.0%       0.00        perf-sched.sch_delay.max.ms.syscall_exit_to_user_mode.ret_from_fork_asm.[unknown].[unknown]
      4.74 ± 91%    +283.4%      18.17 ± 25%  perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.06          +218.9%       0.20        perf-sched.total_sch_delay.average.ms
      6.21 ± 60%    +512.8%      38.05 ± 19%  perf-sched.total_sch_delay.max.ms
     11.78 ±  6%     +19.6%      14.08        perf-sched.total_wait_and_delay.average.ms
     78829 ±  6%     -35.4%      50952        perf-sched.total_wait_and_delay.count.ms
     11.72 ±  6%     +18.5%      13.89        perf-sched.total_wait_time.average.ms
     13.85 ±  3%     +48.1%      20.52 ± 11%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
     45.00 ± 63%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.dput.scan_positives.dcache_readdir.iterate_dir
      0.06 ±  5%    +189.0%       0.19 ± 16%  perf-sched.wait_and_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
    105.66 ±  3%     +16.2%     122.81 ±  3%  perf-sched.wait_and_delay.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      3.49 ± 47%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
     10.58 ±  7%     +29.6%      13.71        perf-sched.wait_and_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
    424.15 ± 11%     +49.5%     633.95 ±  6%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
     82.50 ± 68%     -75.1%      20.55 ± 90%  perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
     70.96 ±  5%     +13.0%      80.21        perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     75.58 ±  8%     +29.3%      97.75 ±  4%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     70.17 ± 16%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.dput.scan_positives.dcache_readdir.iterate_dir
     18.67 ± 18%     -90.2%       1.83 ± 85%  perf-sched.wait_and_delay.count.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
    753.00 ±  5%     -99.9%       0.50 ±152%  perf-sched.wait_and_delay.count.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      2179 ±  6%     -36.1%       1393        perf-sched.wait_and_delay.count.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
     21418 ±  6%     -29.7%      15061        perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
     21231 ±  7%     -30.8%      14692        perf-sched.wait_and_delay.count.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
     86.83 ± 10%     -99.2%       0.67 ±223%  perf-sched.wait_and_delay.count.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      1590 ±  5%     -65.0%     556.33 ±  3%  perf-sched.wait_and_delay.count.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
    792.33 ±  8%    -100.0%       0.00        perf-sched.wait_and_delay.count.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
      7701 ±  6%     -19.5%       6199        perf-sched.wait_and_delay.count.pipe_read.vfs_read.ksys_read.do_syscall_64
     77.83 ±  7%     -28.5%      55.67 ±  6%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
    129.67 ±  9%     -28.7%      92.50 ± 18%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.walk_component
      6624 ±  5%     -18.5%       5402        perf-sched.wait_and_delay.count.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      5597 ±  6%     -34.1%       3690        perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      2031 ± 11%     -99.5%      10.00 ±101%  perf-sched.wait_and_delay.count.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      2934 ±  7%     -36.3%       1867 ±  2%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      1005          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.dput.scan_positives.dcache_readdir.iterate_dir
      2375 ±  7%     -98.2%      43.16 ±148%  perf-sched.wait_and_delay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      4.43 ± 50%    +658.9%      33.63 ± 17%  perf-sched.wait_and_delay.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      1796 ± 22%     -35.8%       1152 ± 25%  perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      2200 ± 54%     -92.4%     167.58 ±223%  perf-sched.wait_and_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
    839.75 ± 44%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
      2744 ±  3%     -36.5%       1741 ± 15%  perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      2864 ± 23%     -30.6%       1988 ± 11%  perf-sched.wait_and_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ± 60%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.__pmd_alloc.__handle_mm_fault
      0.33 ± 18%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.__pmd_alloc.copy_p4d_range
      0.17 ± 50%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.get_free_pages_noprof.pgd_alloc
      8.62 ±216%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.pte_alloc_one.__pte_alloc
      0.10 ± 75%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__anon_vma_prepare.__vmf_anon_prepare.do_anonymous_page.__handle_mm_fault
      0.09 ± 86%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__dentry_kill.dput.step_into.link_path_walk
      0.56 ± 76%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__kmalloc_cache_node_noprof.__get_vm_area_node.__vmalloc_node_range_noprof.alloc_thread_stack_node
      0.05 ± 33%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__kmalloc_cache_noprof.perf_event_mmap_event.perf_event_mmap.mmap_region
      0.01 ± 51%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__kmalloc_noprof.load_elf_phdrs.load_elf_binary.search_binary_handler
      0.33 ± 60%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__kmalloc_noprof.lsm_blob_alloc.security_prepare_creds.prepare_creds
      0.56 ± 49%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__kmalloc_noprof.lsm_blob_alloc.security_task_alloc.copy_process
      0.02 ± 71%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables.exit_mmap
     56.87 ±218%     -99.7%       0.15 ±213%  perf-sched.wait_time.avg.ms.__cond_resched.__release_sock.release_sock.__inet_stream_connect.inet_stream_connect
     42.63 ±219%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__release_sock.release_sock.tcp_sendmsg.sock_write_iter
      0.19 ± 10%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__tlb_batch_free_encoded_pages.tlb_finish_mmu.exit_mmap.mmput
      0.02 ± 57%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__tlb_batch_free_encoded_pages.tlb_finish_mmu.relocate_vma_down.setup_arg_pages
      0.43 ± 44%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__vmalloc_area_node.__vmalloc_node_range_noprof.alloc_thread_stack_node.dup_task_struct
     13.79 ±  3%     +35.5%      18.69 ± 13%  perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.13 ± 15%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.wait_for_completion_state.kernel_clone.__x64_sys_vfork
     22.06 ±212%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.aa_sk_perm.security_socket_recvmsg.sock_recvmsg.sock_read_iter
      0.88 ± 44%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.aa_sk_perm.security_socket_sendmsg.sock_write_iter.vfs_write
      0.56 ±138%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.apparmor_file_alloc_security.security_file_alloc.init_file.alloc_empty_file
      0.68 ± 45%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.cgroup_css_set_fork.cgroup_can_fork.copy_process.kernel_clone
      0.05 ± 30%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.change_pud_range.isra.0.change_protection_range
      0.37 ± 20%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.copy_page_range.dup_mmap.dup_mm.constprop
      0.09 ± 45%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_read.acct_collect.do_exit.do_group_exit
      0.08 ± 24%     -96.6%       0.00 ±223%  perf-sched.wait_time.avg.ms.__cond_resched.down_read.walk_component.link_path_walk.part
      0.16 ±127%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_read.walk_component.path_lookupat.filename_lookup
      0.39 ± 18%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write.anon_vma_clone.anon_vma_fork.dup_mmap
      0.35 ± 19%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write.anon_vma_fork.dup_mmap.dup_mm
      0.20 ± 24%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write.free_pgtables.exit_mmap.mmput
      0.07 ± 38%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write.mmap_region.do_mmap.vm_mmap_pgoff
      1.74 ± 37%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write.shmem_file_write_iter.vfs_write.ksys_write
      0.10 ± 65%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write.unlink_anon_vmas.free_pgtables.exit_mmap
      0.06 ± 43%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write.vma_link_file.mmap_region.do_mmap
      0.11 ±150%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write.vma_prepare.__split_vma.vma_modify
      0.02 ±101%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write_killable.setup_arg_pages.load_elf_binary.search_binary_handler
      0.02 ± 52%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.elf_load.load_elf_binary
      0.04 ± 98%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.elf_load.load_elf_interp
      0.11 ± 46%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
      0.80 ± 41%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.dput.do_linkat.__x64_sys_link.do_syscall_64
      0.87 ± 48%     -96.5%       0.03 ±223%  perf-sched.wait_time.avg.ms.__cond_resched.dput.open_last_lookups.path_openat.do_filp_open
      0.13 ±108%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.dput.path_put.exit_fs.do_exit
     46.90 ±158%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.dput.path_put.vfs_statx.vfs_fstatat
     44.86 ± 63%     -95.9%       1.84 ± 36%  perf-sched.wait_time.avg.ms.__cond_resched.dput.scan_positives.dcache_readdir.iterate_dir
      0.06 ± 26%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.dput.step_into.link_path_walk.part
      0.12 ± 69%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.dput.step_into.open_last_lookups.path_openat
      0.17 ±114%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.dput.step_into.path_lookupat.filename_lookup
      0.15 ± 89%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_lru_noprof.__d_alloc.d_alloc.d_alloc_parallel
     85.20 ±219%    -100.0%       0.00 ±223%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_node_noprof.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
      0.65 ± 67%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_node_noprof.dup_task_struct.copy_process.kernel_clone
      0.37 ±  9%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.anon_vma_fork.dup_mmap.dup_mm
      0.72 ± 21%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.copy_fs_struct.copy_process.kernel_clone
      0.05 ± 98%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.commit_merge
      0.05 ± 52%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.mmap_region
      0.04 ± 59%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.vma_modify
      0.08 ±114%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.mmput.exec_mmap.begin_new_exec.load_elf_binary
      1.03 ± 95%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.mnt_want_write.open_last_lookups.path_openat.do_filp_open
     20.87 ± 56%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
     33.59 ±222%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.pipe_read.vfs_read.ksys_read
      0.24 ± 17%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock_killable.pcpu_alloc_noprof.__percpu_counter_init_many.mm_init
      0.37 ± 13%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock_killable.pcpu_alloc_noprof.mm_init.dup_mm
      0.22 ± 52%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.put_files_struct.do_exit.do_group_exit.__x64_sys_exit_group
      0.14 ± 65%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.remove_vma.exit_mmap.mmput.exit_mm
      0.06 ±125%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.remove_vma.vms_complete_munmap_vmas.mmap_region.do_mmap
      1.67 ± 26%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.shmem_get_folio_gfp.shmem_file_read_iter.vfs_read.ksys_read
    146.47 ±213%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
      1.79 ± 18%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.shmem_undo_range.shmem_evict_inode.evict.__dentry_kill
      0.01 ± 22%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.09 ± 26%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.super_lock.iterate_supers.ksys_sync.__x64_sys_sync
      0.44 ± 76%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.task_work_run.do_exit.do_group_exit.__x64_sys_exit_group
      0.09 ± 80%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.unmap_vmas.exit_mmap.mmput.exit_mm
      0.15 ± 65%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.unmap_vmas.vms_clear_ptes.vms_complete_munmap_vmas.mmap_region
      0.37 ± 16%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.uprobe_start_dup_mmap.dup_mmap.dup_mm.constprop
      0.02 ± 43%     -72.9%       0.01 ± 43%  perf-sched.wait_time.avg.ms.d_alloc_parallel.lookup_open.isra.0.open_last_lookups
    105.60 ±  3%     +16.2%     122.75 ±  3%  perf-sched.wait_time.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      1.92 ±217%    -100.0%       0.00        perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      0.13 ± 37%     -98.0%       0.00 ±223%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
      3.24 ±213%    -100.0%       0.00        perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
     10.51 ±  7%     +29.7%      13.63        perf-sched.wait_time.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
    424.06 ± 11%     +49.4%     633.75 ±  6%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
     82.47 ± 68%     -74.9%      20.66 ± 89%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
     75.52 ±  8%     +27.8%      96.53 ±  4%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.05 ± 91%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.__pmd_alloc.__handle_mm_fault
      0.64 ± 17%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.__pmd_alloc.copy_p4d_range
    670.16 ± 70%     -99.6%       2.98 ± 39%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof.vma_alloc_folio_noprof
      0.36 ± 50%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.get_free_pages_noprof.pgd_alloc
    167.66 ±222%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.pte_alloc_one.__pte_alloc
      0.50 ± 96%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__anon_vma_prepare.__vmf_anon_prepare.do_anonymous_page.__handle_mm_fault
      0.31 ± 74%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__dentry_kill.dput.step_into.link_path_walk
      2.62 ±  7%     -75.4%       0.64 ±140%  perf-sched.wait_time.max.ms.__cond_resched.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.06 ± 88%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__kmalloc_cache_node_noprof.__get_vm_area_node.__vmalloc_node_range_noprof.alloc_thread_stack_node
      0.40 ± 52%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__kmalloc_cache_noprof.perf_event_mmap_event.perf_event_mmap.mmap_region
      0.03 ± 57%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__kmalloc_noprof.load_elf_phdrs.load_elf_binary.search_binary_handler
      0.90 ± 71%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__kmalloc_noprof.lsm_blob_alloc.security_prepare_creds.prepare_creds
      1.61 ± 55%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__kmalloc_noprof.lsm_blob_alloc.security_task_alloc.copy_process
      0.47 ± 85%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__put_anon_vma.unlink_anon_vmas.free_pgtables.exit_mmap
    168.98 ±221%     -99.9%       0.15 ±213%  perf-sched.wait_time.max.ms.__cond_resched.__release_sock.release_sock.__inet_stream_connect.inet_stream_connect
    168.89 ±221%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__release_sock.release_sock.tcp_sendmsg.sock_write_iter
      1.66 ± 10%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__tlb_batch_free_encoded_pages.tlb_finish_mmu.exit_mmap.mmput
      0.10 ±104%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__tlb_batch_free_encoded_pages.tlb_finish_mmu.relocate_vma_down.setup_arg_pages
      2.96 ± 13%     -46.0%       1.60 ± 65%  perf-sched.wait_time.max.ms.__cond_resched.__tlb_batch_free_encoded_pages.tlb_finish_mmu.vms_clear_ptes.vms_complete_munmap_vmas
      1.12 ± 66%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__vmalloc_area_node.__vmalloc_node_range_noprof.alloc_thread_stack_node.dup_task_struct
    836.76 ± 44%     -99.8%       1.53 ± 69%  perf-sched.wait_time.max.ms.__cond_resched.__wait_for_common.wait_for_completion_state.kernel_clone.__do_sys_clone3
      3.03 ± 38%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__wait_for_common.wait_for_completion_state.kernel_clone.__x64_sys_vfork
    169.67 ±220%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.aa_sk_perm.security_socket_recvmsg.sock_recvmsg.sock_read_iter
      2.16 ± 41%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.aa_sk_perm.security_socket_sendmsg.sock_write_iter.vfs_write
      1.28 ± 82%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.apparmor_file_alloc_security.security_file_alloc.init_file.alloc_empty_file
      2.09 ± 35%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.cgroup_css_set_fork.cgroup_can_fork.copy_process.kernel_clone
      0.31 ± 39%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.change_pud_range.isra.0.change_protection_range
      0.58 ± 29%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.copy_page_range.dup_mmap.dup_mm.constprop
      1.19 ± 49%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_read.acct_collect.do_exit.do_group_exit
      0.52 ± 41%     -99.5%       0.00 ±223%  perf-sched.wait_time.max.ms.__cond_resched.down_read.walk_component.link_path_walk.part
      0.55 ±138%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_read.walk_component.path_lookupat.filename_lookup
      1.11 ± 44%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write.anon_vma_clone.anon_vma_fork.dup_mmap
      0.76 ± 35%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write.anon_vma_fork.dup_mmap.dup_mm
      2.71 ± 10%     -72.7%       0.74 ±141%  perf-sched.wait_time.max.ms.__cond_resched.down_write.do_truncate.do_open.path_openat
      1.46 ± 31%     -92.3%       0.11 ±223%  perf-sched.wait_time.max.ms.__cond_resched.down_write.dup_mmap.dup_mm.constprop
      1.65 ± 20%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write.free_pgtables.exit_mmap.mmput
      0.22 ± 42%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write.mmap_region.do_mmap.vm_mmap_pgoff
      2.00 ± 33%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write.shmem_file_write_iter.vfs_write.ksys_write
      0.82 ± 51%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write.unlink_anon_vmas.free_pgtables.exit_mmap
      0.33 ± 50%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write.vma_link_file.mmap_region.do_mmap
      0.30 ±131%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write.vma_prepare.__split_vma.vma_modify
      0.76 ± 47%     -99.3%       0.01 ±223%  perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
      0.11 ± 89%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.setup_arg_pages.load_elf_binary.search_binary_handler
      0.11 ± 80%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.elf_load.load_elf_binary
      0.18 ± 79%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.elf_load.load_elf_interp
      0.41 ± 44%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
      2.35 ± 44%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.dput.do_linkat.__x64_sys_link.do_syscall_64
      2.19 ± 41%     -98.6%       0.03 ±223%  perf-sched.wait_time.max.ms.__cond_resched.dput.open_last_lookups.path_openat.do_filp_open
      0.35 ±113%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.dput.path_put.exit_fs.do_exit
    335.13 ±140%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.dput.path_put.vfs_statx.vfs_fstatat
      1005           -99.7%       2.66 ± 20%  perf-sched.wait_time.max.ms.__cond_resched.dput.scan_positives.dcache_readdir.iterate_dir
    169.41 ±219%     -99.6%       0.74 ±149%  perf-sched.wait_time.max.ms.__cond_resched.dput.shmem_unlink.vfs_unlink.do_unlinkat
      0.41 ± 50%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.dput.step_into.link_path_walk.part
      0.23 ± 46%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.dput.step_into.open_last_lookups.path_openat
      0.87 ±117%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.dput.step_into.path_lookupat.filename_lookup
    335.93 ±140%     -99.5%       1.70 ± 70%  perf-sched.wait_time.max.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
      1.72 ± 21%     -96.1%       0.07 ±223%  perf-sched.wait_time.max.ms.__cond_resched.exit_mmap.mmput.exit_mm.do_exit
      0.68 ±134%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_lru_noprof.__d_alloc.d_alloc.d_alloc_parallel
      2.47 ± 10%     -72.3%       0.68 ±142%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_lru_noprof.shmem_alloc_inode.alloc_inode.new_inode
    169.71 ±220%    -100.0%       0.00 ±223%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_node_noprof.__alloc_skb.alloc_skb_with_frags.sock_alloc_send_pskb
      1.46 ± 83%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_node_noprof.dup_task_struct.copy_process.kernel_clone
      2.32 ± 33%     -80.1%       0.46 ±174%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_empty_file.path_openat.do_filp_open
      1.89 ± 29%     -67.6%       0.61 ±141%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_pid.copy_process.kernel_clone
      1.75 ± 57%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.anon_vma_fork.dup_mmap.dup_mm
      2.20 ± 14%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.copy_fs_struct.copy_process.kernel_clone
      0.14 ± 63%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.commit_merge
      0.33 ± 70%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.mmap_region
      2.22 ± 30%     -84.2%       0.35 ±223%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.security_inode_alloc.inode_init_always.alloc_inode
      0.19 ± 67%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.vma_modify
      0.16 ±110%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.mmput.exec_mmap.begin_new_exec.load_elf_binary
    168.83 ±220%     -99.9%       0.23 ±223%  perf-sched.wait_time.max.ms.__cond_resched.mnt_want_write.do_unlinkat.__x64_sys_unlink.do_syscall_64
      1.30 ± 90%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.mnt_want_write.open_last_lookups.path_openat.do_filp_open
     49.02 ± 71%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
    167.38 ±223%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.pipe_read.vfs_read.ksys_read
      1.06 ± 52%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.mutex_lock_killable.pcpu_alloc_noprof.__percpu_counter_init_many.mm_init
      0.62 ± 38%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.mutex_lock_killable.pcpu_alloc_noprof.mm_init.dup_mm
      1.29 ± 28%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.put_files_struct.do_exit.do_group_exit.__x64_sys_exit_group
      0.76 ± 67%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.remove_vma.exit_mmap.mmput.exit_mm
      0.16 ± 75%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.remove_vma.vms_complete_munmap_vmas.mmap_region.do_mmap
      2.31 ± 10%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.shmem_get_folio_gfp.shmem_file_read_iter.vfs_read.ksys_read
    586.41 ±213%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
      2.50 ±  9%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.shmem_undo_range.shmem_evict_inode.evict.__dentry_kill
      2375 ±  7%     -98.3%      41.33 ±148%  perf-sched.wait_time.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1.97 ± 64%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.34 ± 52%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.super_lock.iterate_supers.ksys_sync.__x64_sys_sync
      0.77 ± 60%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.task_work_run.do_exit.do_group_exit.__x64_sys_exit_group
      0.74 ± 79%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.unmap_vmas.exit_mmap.mmput.exit_mm
      0.37 ± 79%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.unmap_vmas.vms_clear_ptes.vms_complete_munmap_vmas.mmap_region
      1.06 ± 67%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.uprobe_start_dup_mmap.dup_mmap.dup_mm.constprop
      2.09 ± 24%     -63.9%       0.75 ±141%  perf-sched.wait_time.max.ms.__cond_resched.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.17 ± 35%     -74.1%       0.04 ±122%  perf-sched.wait_time.max.ms.d_alloc_parallel.__lookup_slow.walk_component.path_lookupat
      1796 ± 22%     -35.8%       1152 ± 25%  perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
    167.97 ±222%    -100.0%       0.00        perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      2200 ± 54%     -92.3%     169.14 ±221%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      1.42 ± 67%     -99.8%       0.00 ±223%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
    170.12 ±219%     -99.8%       0.32 ±218%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown].[unknown]
    168.00 ±221%    -100.0%       0.00        perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
      0.52 ± 15%     -70.5%       0.15 ±145%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.dup_mmap
      2744 ±  3%     -36.5%       1741 ± 15%  perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      2864 ± 23%     -30.6%       1987 ± 10%  perf-sched.wait_time.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


