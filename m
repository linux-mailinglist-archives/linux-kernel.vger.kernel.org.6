Return-Path: <linux-kernel+bounces-405969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F6A9C596F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 14:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02F091F23910
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 13:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C1915A858;
	Tue, 12 Nov 2024 13:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h0aWpSQD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15D91632E9
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 13:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731419113; cv=fail; b=G7lsPndtxQgocxDgSuZPqwdsU31T6vCUPlIX53OdYzzCL1fVfoeJkYooCx3cre8I/iXsXQNGBTQs93U26J6hXdbpssBsWDcWwM/oNz3f2VTpKb6Kx7kPeOEZrqLuXoj7IZZBG8WWG4djeMK0un+VYRGeWRXvr5btU7f0tzWjZ0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731419113; c=relaxed/simple;
	bh=6PHbIurrqcvB0qY1URl6Zc+z8Wu/3StkqTQNBpAkMJU=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=Du48K94eUX4i0FOhqDWklwkHzYJIKJyQF8gdENC4HevNEUFaI6D+qVlBLNuBHqP+hDVI8lcBKAYCGEDuQ1ffKWWk/FQ1ry5XzZoluuC1aERobb9+GgtFKc8fOkpOGdvgCp1eJ1HhXSSgAQDb30Nd8zWcC+qbaANMn0mRBxXu3QQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h0aWpSQD; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731419107; x=1762955107;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=6PHbIurrqcvB0qY1URl6Zc+z8Wu/3StkqTQNBpAkMJU=;
  b=h0aWpSQDlkVBrzilM73T1kiHCF7tjA7hj/k+7T9AnMp7KcSMyLPMKpBd
   v02xmMCcT52p/7BgccxR5i8TkNskrsrz8s+2/plSojxNimBub8P5Bzn5E
   6Txm/aXV5n+ZXT/m5cbPBBwrrRnUqtaYP3sfh0qYZ5cY6eyg04QVPJEFv
   Eg9lY4yyWlIuU55kaS6i8sA4YTl15KBxGutEaRbqAvUek/9FbRhOh9eES
   fJHr0tkXDGvtwOe5OIgkkFQ+P5qAq4pzby+MRCnv2G9Tg80KGerFN/33U
   cpYCKFRa2OidH2FQqfQHlNC4RikjUGWHuYQvUuRMHRpK/wAla2eC7fUbV
   g==;
X-CSE-ConnectionGUID: Y2sCvovsSMOB1+ew6Fng0A==
X-CSE-MsgGUID: tRyTuhoLQvWQBDfgpMluKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31017893"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31017893"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 05:45:06 -0800
X-CSE-ConnectionGUID: We4BftfRQPCy2WVuoz7NpQ==
X-CSE-MsgGUID: RwNIk9YcTOWywr4eF7+OVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="92428875"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Nov 2024 05:45:06 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 12 Nov 2024 05:45:05 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 12 Nov 2024 05:45:05 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.44) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 12 Nov 2024 05:45:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VIccoAlMMXloL9HwbA1l0pbFaEV8+Qpxi82CgCiNeP9VAWAbimaiNQafa2Dzg/UpzqyIvEuohxhuXMy03uOw2kfoVxvmKtkXzC0LYGxOFeM//ksaCDTAwr2uiZswdMoBPDZ5pR9VxLhCKmJKBRiuijoMJATbpoSp0gdfGFwd6gHSTqBLrjye1Gq7Hznhrm0SVZJYRQFDDIEMhjQq/ODg2p0cxiJBoUGcOWHV/ZtzERtoPsFb0znan4Q41aeu67bV1gnLWRLWYsWjgMvlyhEAsQYvB+5uq9is3LZwOQcSjOyldR5W+lc4PtYKiK52DQDXP5Fe/3nTLxElvyQFET3KQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R4/QiVl1S0Sw9QaUV5zQjKEXchBGVa75MjcBJPyV6Hk=;
 b=TnPVa9LCLJ0v3RLgIGqW3xbln5RirC3mMswX6ifJQyCE9AAjlw0tRqBfXkNNSs12JO3XDbRMhTjujJy6n7C6K4+srUQE0omSkpvv/tOfC2bM4b9AE7O5X7nIIZvez8vthOkv79qC5cMUnv03Sa1Urli1PSC7BHVtkw2cB5z+paV+JkZzwleH1W8IFanm0FXhkPrALKFz7skRQI6wTmS6jsXV7QjrDoCV6rXQOjDXiiPCpt7okFgwGlu8tnwU5ILtrM2R5ATo3YCGxZvSzhRlmT4k9CLyNrmGf1zCSKKeEE7ysTu0R/pd3XDZcDdclvMG2H7UuYoai4eF/iCAjrLVAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MW6PR11MB8411.namprd11.prod.outlook.com (2603:10b6:303:23c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 13:45:00 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8158.013; Tue, 12 Nov 2024
 13:45:00 +0000
Date: Tue, 12 Nov 2024 21:44:49 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	<ying.huang@intel.com>, <feng.tang@intel.com>, <fengwei.yin@intel.com>,
	<oliver.sang@intel.com>
Subject: [tip:timers/vdso] [x86/vdso]  e93d2521b2:
 will-it-scale.per_process_ops 65.0% improvement
Message-ID: <202411122153.ab7a1dfe-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0023.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::6)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MW6PR11MB8411:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e7c78de-a32c-4f71-5494-08dd0320333d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?4O/vScdU2yTP6eBnRtlnBl6YxaRI5nR29HLiQUHuAimVM2J5iUSVAzLHsG?=
 =?iso-8859-1?Q?zn5NGqoTp8vqW7J8NeLTmPpuz2VsDxsYw4BnWowXL7UuOP/POeqMqs/8IJ?=
 =?iso-8859-1?Q?L2BTrtMGQ2AOUKe2GSg0X78D/43WZUQhuPIMYqoAEeDSVMjuwa02KXtkRZ?=
 =?iso-8859-1?Q?SGXPgjbVEQUykCeUorkNk4xjFs0ogzF3+E5CVO4vYwEFacS6sPu8GE1tuJ?=
 =?iso-8859-1?Q?UiD8fLlLPtrcxjnDHVVzg7BdShj3Krn5lOFONPPr1oexuKiQsramHtfzuR?=
 =?iso-8859-1?Q?rzIH4iXadVEBshdGcscRnZPLe1zc58BpUl/pFOORzizI+w0uEnFiWMG8cv?=
 =?iso-8859-1?Q?C5em39dINsJtuKr3msR9R56703p/P9tGKp7ceKNj8rGbSrF8i94jT5alzj?=
 =?iso-8859-1?Q?PzQ22vGctU48c2FigYUpFDdooEm27u6L7hlWxZZr02exc4hpgtiUYtM80c?=
 =?iso-8859-1?Q?lL4CqNuWZMJbtP+NmgaVAVJBF1QWMvqcSnsrHkTLC7LJzsWr95JmwY7bU3?=
 =?iso-8859-1?Q?8AdyFC4v5faB8WzYVCwc4rJArcY0DpNdG0MzSqG4N2qK8VW48Akw4L5OS+?=
 =?iso-8859-1?Q?+LBxdfTmzccB7qUOxgwk5MMzo3wfBtsj2MUN+l3GXCVHNyJtExE+qrFHAI?=
 =?iso-8859-1?Q?j3EFrYNuVH2sApDjdqwooDtNUuJzAm/lLcmuIUonJzk2EnsV/HV4dDlnxE?=
 =?iso-8859-1?Q?vxwHAP04UP5syM36TJskQ2GANj0BLXNa7v3Hzd+NeT71icBLUKVZ4pob5X?=
 =?iso-8859-1?Q?8FJDSVhuaV3Axd2ahwnmamqZJDGMH2H8mmx78rgmBpbZab4PXb2JgH4++6?=
 =?iso-8859-1?Q?UuX2Ro+9k5+dITpMKCQGWnvNTalj2RtdTijRKfZuVhAPhS/8cLVWEPC4r4?=
 =?iso-8859-1?Q?6ByaaIgaoPZDAGl54gmMwVqbduPSUI7P1JJpT2OeqVi2ofj47Fe2b/EfW9?=
 =?iso-8859-1?Q?rQXJeSptKVqVgtUy5kpU/RmSjswHVW9IVvCKbAY7TDoYizUfdLSvpg4WxH?=
 =?iso-8859-1?Q?jBqtXsiekR6/dqPIpglXkb9tu/k+8fgMPoUsx5c2IfPvV1QFSWZAiAkyuV?=
 =?iso-8859-1?Q?vf2BwqvYDQ70SLwmkzRDaACSE6SR7/IYRUR6e2waIDyE2oBqzUfXlBDqtk?=
 =?iso-8859-1?Q?z/BRKRZFsqpD3EiM7L0usIpbTkhE5S3w4j7/hTxUMQaCsa4OJIq0exagGI?=
 =?iso-8859-1?Q?kTPjnz9mzEEL3XASPnWm+PgrcLuNIwxLGPGKxeAOhxY1MxizlwvlCiZIDV?=
 =?iso-8859-1?Q?//DEY/bR0hYm1DtW1tIM0xf8CYcniY1ArTCeygFkuN6iiVBpCs9wAaNr9V?=
 =?iso-8859-1?Q?OtfD9aSOwURAriiENTPxo76sk3TCOLIyge0r7Q2Ae98eHhKGkimNYSqVDA?=
 =?iso-8859-1?Q?Wd0iHtkQQm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?NMhav2BIm7Lrr2lRoyt9WSQZXZltaByo/wNYC7XXeU3fsAXtW1RY4p/KZI?=
 =?iso-8859-1?Q?bH/z0HAthwdXeowhDmJaYsYMtwAMO2gb8qlA0by1XZfA+QKvsIWCnNA/rQ?=
 =?iso-8859-1?Q?xuX02Bu6aW/Cc/kLRAx5vx8tp/q1w10Iy0dZNSmi1rcZdk02I4wOpk9fCT?=
 =?iso-8859-1?Q?rHP2VvYuNF6s5UMsDOzlHQjD2fjs1vTwig+tCLy3wZI2nAJUpiTkMAxkri?=
 =?iso-8859-1?Q?wLdCWt/gAPBpMn6Hhkci8f9p5DEMOaeDeNaWbBBu8oXKLl7JrTMXhPi6DZ?=
 =?iso-8859-1?Q?2EQ18FbITQpt8X2hC/rXIhheGggUI09KmUBDASnXERt4tDUdQUwQYEP8NI?=
 =?iso-8859-1?Q?WqXInZ+eJbLjmcYdlbYuVqHz91yvjxXW2RGiZwjzFR0s+R0yVKnT2zoFrx?=
 =?iso-8859-1?Q?M3thymOEMLCaMVH9L0iFqNBLpa0SYI1hY+AUv+791OslrRMCOx8DOAVDYz?=
 =?iso-8859-1?Q?MKVxj0FTNJoi28V4J35dL11thAiO2GfziEXMOC8jBM1LP4QaD5VLqxeeRg?=
 =?iso-8859-1?Q?tpMacsf5dlfCyie/jQgksvUYb8R49r8jiNJFbeun+9TxP14Z3vxwK7UZiW?=
 =?iso-8859-1?Q?t5yxm/4492MXuLtFF9QfCyeiveEoOVXkgG09NW0jNQUOX60CMGS3ebuRVu?=
 =?iso-8859-1?Q?y8hE93ePqwlGH9XBJKWp0VtqZUVHJ5EA4siqO+6jfwRCxLr6TsFMn985Gc?=
 =?iso-8859-1?Q?G5/TXp7xuP2u5Fcn+poWBDGovvBQIIbTyvQ/Yt0EMiTLzJHL+bNCxahUHU?=
 =?iso-8859-1?Q?vFIBGrdmTBOaWK4rmUHxqldGqteZ3Zha65MnF0rRQRwJ3EaqEG6mH0trGZ?=
 =?iso-8859-1?Q?c2LYeOtQBkBLWOoiFY4SoOj5pVh2iXiY05hGDuJG3OdFI+TM5zAuzBvS8Z?=
 =?iso-8859-1?Q?bKHIl9Ega2gpmI0KEIB9pcsy5UyM7VlH/WdG+g4Ps/LhyL/XRoEyUUdu42?=
 =?iso-8859-1?Q?DnkEi82AGJDYjBfCDFH7RfV5Yk8vY8+PUDIDXoaP6c7AywpauRwvTMzwBv?=
 =?iso-8859-1?Q?BBC8bRyKNYnaDOnz4rzmLPvNFgY09/0DJn4Z1snY8UWXKTjT32wuXtRYUI?=
 =?iso-8859-1?Q?PeDiL9jBu5/UFGFv0jCPeIkI+zSd1sEYLxbAsHrRTDwi6+J3N0FcCsAdc9?=
 =?iso-8859-1?Q?vq9HuZogRlUJzcDBE7MTM0MFRCRTZDrK1wxH/aDK5aRYsvE9vb9NhAg8OG?=
 =?iso-8859-1?Q?qlN0c70NZqvMU/kVm3KNXSFce4ns842z55pFYTR31JspeQKuljL504KzNJ?=
 =?iso-8859-1?Q?IdYacIM9v0Bh8pSceafc1LBXV03rH8kZ1FWmFR1QTTZgk3cYxri8ESaR0p?=
 =?iso-8859-1?Q?gOQ7mYNI9P6osU4CMUzMAcE+z0ZWNqRnh5tIOh0b4yGKwv1n0pBg15TRGy?=
 =?iso-8859-1?Q?jPL3wH716PWR8Yh1VWs9HDExGj+KMX7BzCYWwh7/mUGVxbrfBNus9BqcZI?=
 =?iso-8859-1?Q?EAy3D3FIAi1qYFi6wYHFrzAKl9ryhJ54YrRpvwAZL4D0Hz2K6e8SikjLVx?=
 =?iso-8859-1?Q?mLN4azQQ/2vPh+QzCnXVJ9Nd7mbvNOTkhGU6cb+GIOAYrH2r2ybSEGQK7y?=
 =?iso-8859-1?Q?jnoyIckKjcIAExpQ4D4C1LcSf0EvPBOA8ISrwaC/SND0kthrUOeJNKOzV6?=
 =?iso-8859-1?Q?H+gfeJeXQchwGqFl1CZi5hxyar3Mco2v0z?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e7c78de-a32c-4f71-5494-08dd0320333d
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 13:44:59.9427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gBwjywhMMYG/de6lUsPUOGfmr0aGjRIJyw845KgCFKJCEokpCdebbzsnQOTzEaPbgwnidoy0xWeYsJwdjvhHqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8411
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 65.0% improvement of will-it-scale.per_process_ops on:


commit: e93d2521b27f0439872dfa4e4b92a9be6d73496f ("x86/vdso: Split virtual clock pages into dedicated mapping")
https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git timers/vdso


testcase: will-it-scale
config: x86_64-rhel-8.3
compiler: gcc-12
test machine: 104 threads 2 sockets (Skylake) with 192G memory
parameters:

	nr_task: 100%
	mode: process
	test: mmap2
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+-----------------------------------------------------------------+
| testcase: change | will-it-scale: will-it-scale.per_process_ops 113.4% improvement |
| test machine     | 104 threads 2 sockets (Skylake) with 192G memory                |
| test parameters  | cpufreq_governor=performance                                    |
|                  | mode=process                                                    |
|                  | nr_task=100%                                                    |
|                  | test=brk2                                                       |
+------------------+-----------------------------------------------------------------+




Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241112/202411122153.ab7a1dfe-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/process/100%/debian-12-x86_64-20240206.cgz/lkp-skl-fpga01/mmap2/will-it-scale

commit: 
  05a6b8c190 ("x86/vdso: Delete vvar.h")
  e93d2521b2 ("x86/vdso: Split virtual clock pages into dedicated mapping")

05a6b8c190f00792 e93d2521b27f0439872dfa4e4b9 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 3.846e+08 ± 28%     -36.4%  2.446e+08 ± 16%  cpuidle..time
    418838 ± 38%    +102.8%     849541 ± 10%  meminfo.Active
    418790 ± 38%    +102.8%     849501 ± 10%  meminfo.Active(anon)
      8.58           +63.2%      14.00        vmstat.cpu.us
      6469           -17.6%       5331        vmstat.system.cs
      0.47            +0.1        0.53        mpstat.cpu.all.irq%
     19.10            -8.1       10.98        mpstat.cpu.all.soft%
      8.55            +5.6       14.15        mpstat.cpu.all.usr%
     65526 ±119%    +140.0%     157277 ± 48%  numa-meminfo.node0.AnonHugePages
    377619 ± 51%    +113.5%     806275 ± 10%  numa-meminfo.node1.Active
    377619 ± 51%    +113.5%     806270 ± 10%  numa-meminfo.node1.Active(anon)
   6478091           +65.0%   10689793        will-it-scale.104.processes
     62288           +65.0%     102786        will-it-scale.per_process_ops
   6478091           +65.0%   10689793        will-it-scale.workload
  1.39e+08           -17.9%  1.141e+08        numa-numastat.node0.local_node
  1.39e+08           -17.9%  1.142e+08        numa-numastat.node0.numa_hit
 1.465e+08           -17.0%  1.216e+08        numa-numastat.node1.local_node
 1.466e+08           -17.0%  1.216e+08        numa-numastat.node1.numa_hit
      9176 ± 12%     -53.7%       4250 ±  7%  perf-c2c.DRAM.local
    699.67 ± 12%     -54.8%     316.33 ±  7%  perf-c2c.DRAM.remote
      6432 ± 11%     -65.4%       2228 ±  6%  perf-c2c.HITM.local
    456.50 ± 13%     -63.5%     166.50 ±  6%  perf-c2c.HITM.remote
      6889 ± 11%     -65.2%       2395 ±  6%  perf-c2c.HITM.total
     32.00 ±119%    +140.0%      76.78 ± 48%  numa-vmstat.node0.nr_anon_transparent_hugepages
  1.39e+08           -17.9%  1.142e+08        numa-vmstat.node0.numa_hit
  1.39e+08           -17.9%  1.141e+08        numa-vmstat.node0.numa_local
     94420 ± 51%    +113.5%     201608 ± 10%  numa-vmstat.node1.nr_active_anon
     94419 ± 51%    +113.5%     201608 ± 10%  numa-vmstat.node1.nr_zone_active_anon
 1.466e+08           -17.0%  1.216e+08        numa-vmstat.node1.numa_hit
 1.465e+08           -17.0%  1.216e+08        numa-vmstat.node1.numa_local
    104951 ± 38%    +102.4%     212400 ± 10%  proc-vmstat.nr_active_anon
    183178            -1.8%     179889        proc-vmstat.nr_anon_pages
    123753            -4.0%     118849        proc-vmstat.nr_slab_unreclaimable
    104951 ± 38%    +102.4%     212400 ± 10%  proc-vmstat.nr_zone_active_anon
     48833 ± 11%     -32.6%      32903 ± 29%  proc-vmstat.numa_hint_faults_local
 2.856e+08           -17.5%  2.358e+08        proc-vmstat.numa_hit
 2.855e+08           -17.4%  2.357e+08        proc-vmstat.numa_local
    297706 ± 71%     +84.0%     547872 ±  5%  proc-vmstat.pgactivate
 5.555e+08           -19.6%  4.467e+08        proc-vmstat.pgalloc_normal
 5.549e+08           -19.6%  4.461e+08        proc-vmstat.pgfree
      1.78           -22.2%       1.39        perf-stat.i.MPKI
 3.111e+10           +14.6%  3.565e+10        perf-stat.i.branch-instructions
      0.62 ±  2%      -0.1        0.55        perf-stat.i.branch-miss-rate%
 1.901e+08            +1.1%  1.923e+08        perf-stat.i.branch-misses
 2.869e+08           -16.4%  2.397e+08        perf-stat.i.cache-misses
 4.702e+08           -16.0%   3.95e+08        perf-stat.i.cache-references
      6454           -17.8%       5307        perf-stat.i.context-switches
      1.72            -6.5%       1.61        perf-stat.i.cpi
    250.22           -25.4%     186.77        perf-stat.i.cpu-migrations
    967.35           +20.2%       1162        perf-stat.i.cycles-between-cache-misses
 1.615e+11            +7.1%   1.73e+11        perf-stat.i.instructions
      0.58            +6.7%       0.62        perf-stat.i.ipc
      1.78           -22.0%       1.39        perf-stat.overall.MPKI
      0.61            -0.1        0.54        perf-stat.overall.branch-miss-rate%
      1.72            -6.2%       1.61        perf-stat.overall.cpi
    966.41           +20.2%       1161        perf-stat.overall.cycles-between-cache-misses
      0.58            +6.6%       0.62        perf-stat.overall.ipc
   7567490           -35.4%    4886829        perf-stat.overall.path-length
   3.1e+10           +14.6%  3.553e+10        perf-stat.ps.branch-instructions
 1.895e+08            +1.1%  1.916e+08        perf-stat.ps.branch-misses
 2.859e+08           -16.4%  2.389e+08        perf-stat.ps.cache-misses
 4.687e+08           -16.0%  3.937e+08        perf-stat.ps.cache-references
      6431           -17.8%       5289        perf-stat.ps.context-switches
    249.34           -25.4%     186.05        perf-stat.ps.cpu-migrations
  1.61e+11            +7.1%  1.724e+11        perf-stat.ps.instructions
 4.902e+13            +6.6%  5.224e+13        perf-stat.total.instructions
  76371538 ±  2%     -34.1%   50360508 ±  2%  sched_debug.cfs_rq:/.avg_vruntime.avg
 1.042e+08 ±  2%     -25.5%   77615007 ±  2%  sched_debug.cfs_rq:/.avg_vruntime.max
  51222960 ±  7%     -41.4%   30025103 ±  7%  sched_debug.cfs_rq:/.avg_vruntime.min
      0.36 ±  9%     -22.2%       0.28 ±  4%  sched_debug.cfs_rq:/.h_nr_running.stddev
   7616606 ± 32%     -80.8%    1463015 ± 33%  sched_debug.cfs_rq:/.left_deadline.avg
  91543252 ±  6%     -54.7%   41498781 ± 34%  sched_debug.cfs_rq:/.left_deadline.max
  22063165 ± 13%     -69.5%    6724215 ± 32%  sched_debug.cfs_rq:/.left_deadline.stddev
   7616263 ± 32%     -80.8%    1463002 ± 33%  sched_debug.cfs_rq:/.left_vruntime.avg
  91539651 ±  6%     -54.7%   41498664 ± 34%  sched_debug.cfs_rq:/.left_vruntime.max
  22062147 ± 13%     -69.5%    6724178 ± 32%  sched_debug.cfs_rq:/.left_vruntime.stddev
     96606 ± 23%     -60.0%      38633 ± 19%  sched_debug.cfs_rq:/.load.avg
    257955 ± 13%     -48.2%     133525 ± 21%  sched_debug.cfs_rq:/.load.stddev
    181.41 ± 61%     -67.2%      59.42 ± 12%  sched_debug.cfs_rq:/.load_avg.avg
      2844 ±193%     -89.1%     311.17 ± 13%  sched_debug.cfs_rq:/.load_avg.max
     51.61 ± 12%     -66.4%      17.36 ± 24%  sched_debug.cfs_rq:/.load_avg.min
    401.50 ±186%     -86.2%      55.52 ± 12%  sched_debug.cfs_rq:/.load_avg.stddev
  76371576 ±  2%     -34.1%   50360520 ±  2%  sched_debug.cfs_rq:/.min_vruntime.avg
 1.042e+08 ±  2%     -25.5%   77615004 ±  2%  sched_debug.cfs_rq:/.min_vruntime.max
  51222977 ±  7%     -41.4%   30025106 ±  7%  sched_debug.cfs_rq:/.min_vruntime.min
      0.30 ± 10%     -39.4%       0.18 ± 15%  sched_debug.cfs_rq:/.nr_running.stddev
   7616264 ± 32%     -80.8%    1463002 ± 33%  sched_debug.cfs_rq:/.right_vruntime.avg
  91539651 ±  6%     -54.7%   41498664 ± 34%  sched_debug.cfs_rq:/.right_vruntime.max
  22062148 ± 13%     -69.5%    6724179 ± 32%  sched_debug.cfs_rq:/.right_vruntime.stddev
    159.68 ±  5%      -9.9%     143.88 ±  3%  sched_debug.cfs_rq:/.runnable_avg.stddev
      1127 ± 10%     -29.7%     792.14 ±  9%  sched_debug.cpu.curr->pid.stddev
      0.36 ±  9%     -22.3%       0.28 ±  6%  sched_debug.cpu.nr_running.stddev
     10434           -15.8%       8785        sched_debug.cpu.nr_switches.avg
      7252           -19.7%       5821        sched_debug.cpu.nr_switches.min
      2723 ±  4%      -9.7%       2459 ±  3%  sched_debug.cpu.nr_switches.stddev
      4.75 ± 10%     -42.8%       2.71 ± 16%  perf-sched.sch_delay.avg.ms.__cond_resched.__kmalloc_cache_noprof.perf_event_mmap_event.perf_event_mmap.mmap_region
      4.70 ± 13%     -41.8%       2.74 ±  9%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.shmem_mmap.mmap_region.do_mmap
      4.88 ± 14%     -45.8%       2.65 ± 12%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.unlink_file_vma_batch_final.free_pgtables.vms_clear_ptes
      4.94 ±  7%     -46.3%       2.65 ±  7%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.vma_link_file.mmap_region.do_mmap
      4.81 ±  9%     -42.1%       2.78 ±  5%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.vms_gather_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap
      5.05 ± 10%     -45.6%       2.75 ±  6%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write_killable.__vm_munmap.__x64_sys_munmap.do_syscall_64
      4.90 ±  8%     -42.5%       2.82 ±  6%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
      4.89 ±  5%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_bulk_noprof.mas_alloc_nodes.mas_preallocate.mmap_region
      4.81 ±  9%     -44.9%       2.65        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.mmap_region
      4.91 ±  9%     -44.2%       2.74 ±  6%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc.mmap_region.do_mmap
      4.79 ± 10%     -43.4%       2.71 ±  7%  perf-sched.sch_delay.avg.ms.__cond_resched.remove_vma.vms_complete_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap
      0.04 ± 28%     -45.5%       0.02 ± 42%  perf-sched.sch_delay.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      2.92 ± 40%     -71.9%       0.82 ± 47%  perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      4.79 ± 23%     -45.4%       2.61 ± 20%  perf-sched.sch_delay.avg.ms.__cond_resched.unmap_page_range.unmap_vmas.vms_clear_ptes.vms_complete_munmap_vmas
      5.03 ±  7%     -45.3%       2.75 ±  7%  perf-sched.sch_delay.avg.ms.__cond_resched.unmap_vmas.vms_clear_ptes.vms_complete_munmap_vmas.do_vmi_align_munmap
      4.78 ±  7%     -43.3%       2.71 ±  5%  perf-sched.sch_delay.avg.ms.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
      3.92 ±  2%     -28.5%       2.81 ±  2%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      1.66 ± 23%     -48.7%       0.85 ± 58%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
      0.09 ± 16%     -33.7%       0.06 ±  8%  perf-sched.sch_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.14 ± 17%     -57.5%       0.06 ± 15%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.03 ± 17%     -25.7%       0.02 ±  5%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      2.57 ± 10%     -31.4%       1.76 ±  6%  perf-sched.sch_delay.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     13.54 ± 22%     -32.5%       9.14 ± 21%  perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
     18.49 ± 11%     -45.8%      10.02 ±  4%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.vma_link_file.mmap_region.do_mmap
     16.40 ± 12%     -36.0%      10.49 ± 10%  perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.__vm_munmap.__x64_sys_munmap.do_syscall_64
     17.10 ± 12%     -34.7%      11.17 ± 11%  perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
      7.05 ± 35%     -31.1%       4.86 ± 29%  perf-sched.sch_delay.max.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
     13.51 ± 11%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_bulk_noprof.mas_alloc_nodes.mas_preallocate.mmap_region
     13.86 ±  9%     -33.9%       9.17 ±  6%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.mmap_region
     15.92 ±  8%     -33.4%      10.59 ±  9%  perf-sched.sch_delay.max.ms.__cond_resched.remove_vma.vms_complete_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap
     12.90 ±  5%     -40.5%       7.67 ± 11%  perf-sched.sch_delay.max.ms.__cond_resched.unmap_page_range.unmap_vmas.vms_clear_ptes.vms_complete_munmap_vmas
     23.15 ± 18%     -54.1%      10.62 ± 10%  perf-sched.sch_delay.max.ms.__cond_resched.unmap_vmas.vms_clear_ptes.vms_complete_munmap_vmas.do_vmi_align_munmap
     17.65 ± 14%     -33.5%      11.75 ± 11%  perf-sched.sch_delay.max.ms.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
      8.39 ± 31%     -38.9%       5.13 ± 22%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
     12.72 ±  5%     -29.8%       8.94 ±  8%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
     11.11 ± 25%     -47.6%       5.82 ± 17%  perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     19.43 ± 27%     -44.0%      10.88 ± 11%  perf-sched.sch_delay.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     12.12           -16.0%      10.18 ±  7%  perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      2.28 ±  5%     -41.8%       1.33 ±  3%  perf-sched.total_sch_delay.average.ms
     50.86           +12.5%      57.23        perf-sched.total_wait_and_delay.average.ms
     31291           -13.8%      26966        perf-sched.total_wait_and_delay.count.ms
     48.58           +15.1%      55.90        perf-sched.total_wait_time.average.ms
      9.41 ± 13%     -41.8%       5.48 ±  9%  perf-sched.wait_and_delay.avg.ms.__cond_resched.down_write.shmem_mmap.mmap_region.do_mmap
      9.89 ±  7%     -46.3%       5.31 ±  7%  perf-sched.wait_and_delay.avg.ms.__cond_resched.down_write.vma_link_file.mmap_region.do_mmap
      9.62 ±  9%     -42.1%       5.57 ±  5%  perf-sched.wait_and_delay.avg.ms.__cond_resched.down_write.vms_gather_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap
     10.11 ± 10%     -45.6%       5.50 ±  6%  perf-sched.wait_and_delay.avg.ms.__cond_resched.down_write_killable.__vm_munmap.__x64_sys_munmap.do_syscall_64
      9.80 ±  8%     -42.5%       5.63 ±  6%  perf-sched.wait_and_delay.avg.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
      9.62 ±  9%     -44.9%       5.30        perf-sched.wait_and_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.mmap_region
      9.81 ±  9%     -44.2%       5.47 ±  6%  perf-sched.wait_and_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc.mmap_region.do_mmap
      9.57 ± 10%     -43.4%       5.42 ±  7%  perf-sched.wait_and_delay.avg.ms.__cond_resched.remove_vma.vms_complete_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap
     10.06 ±  7%     -45.3%       5.50 ±  7%  perf-sched.wait_and_delay.avg.ms.__cond_resched.unmap_vmas.vms_clear_ptes.vms_complete_munmap_vmas.do_vmi_align_munmap
      9.56 ±  7%     -43.3%       5.42 ±  5%  perf-sched.wait_and_delay.avg.ms.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
      7.85 ±  2%     -28.5%       5.62 ±  2%  perf-sched.wait_and_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
     81.44           +29.4%     105.38        perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      8.56 ± 15%     -26.2%       6.32 ±  6%  perf-sched.wait_and_delay.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    181.83 ±  5%     +39.4%     253.50 ±  6%  perf-sched.wait_and_delay.count.__cond_resched.down_write.shmem_mmap.mmap_region.do_mmap
      1865 ±  3%     -66.5%     625.00 ±  4%  perf-sched.wait_and_delay.count.__cond_resched.down_write.vma_link_file.mmap_region.do_mmap
    223.17 ±  7%     +57.8%     352.17 ±  5%  perf-sched.wait_and_delay.count.__cond_resched.down_write.vms_gather_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap
    417.00 ± 10%     +39.4%     581.50 ±  7%  perf-sched.wait_and_delay.count.__cond_resched.down_write_killable.__vm_munmap.__x64_sys_munmap.do_syscall_64
    554.33 ±  5%     +40.4%     778.33 ±  6%  perf-sched.wait_and_delay.count.__cond_resched.down_write_killable.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
    190.17 ±  8%     +41.8%     269.67 ±  8%  perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.mmap_region
    988.67 ±  3%     +46.6%       1449 ±  4%  perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc.mmap_region.do_mmap
    332.50 ±  8%     +49.9%     498.33 ±  4%  perf-sched.wait_and_delay.count.__cond_resched.remove_vma.vms_complete_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap
    264.17 ± 11%     -46.3%     141.83 ± 46%  perf-sched.wait_and_delay.count.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      4748           -77.6%       1061 ±  5%  perf-sched.wait_and_delay.count.__cond_resched.unmap_vmas.vms_clear_ptes.vms_complete_munmap_vmas.do_vmi_align_munmap
      1328 ±  5%     +57.2%       2088 ±  4%  perf-sched.wait_and_delay.count.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
      2213 ±  5%     +14.1%       2525 ±  2%  perf-sched.wait_and_delay.count.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
     10898           -20.6%       8650        perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      2126 ±  7%     +24.3%       2643 ±  4%  perf-sched.wait_and_delay.count.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     36.97 ± 11%     -45.8%      20.04 ±  4%  perf-sched.wait_and_delay.max.ms.__cond_resched.down_write.vma_link_file.mmap_region.do_mmap
     32.79 ± 12%     -36.0%      20.97 ± 10%  perf-sched.wait_and_delay.max.ms.__cond_resched.down_write_killable.__vm_munmap.__x64_sys_munmap.do_syscall_64
     34.21 ± 12%     -34.7%      22.34 ± 11%  perf-sched.wait_and_delay.max.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
     27.73 ±  9%     -33.9%      18.34 ±  6%  perf-sched.wait_and_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.mmap_region
     31.83 ±  8%     -33.4%      21.19 ±  9%  perf-sched.wait_and_delay.max.ms.__cond_resched.remove_vma.vms_complete_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap
     46.31 ± 18%     -54.1%      21.25 ± 10%  perf-sched.wait_and_delay.max.ms.__cond_resched.unmap_vmas.vms_clear_ptes.vms_complete_munmap_vmas.do_vmi_align_munmap
     35.30 ± 14%     -33.5%      23.49 ± 11%  perf-sched.wait_and_delay.max.ms.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
      4.75 ± 10%     -42.8%       2.71 ± 16%  perf-sched.wait_time.avg.ms.__cond_resched.__kmalloc_cache_noprof.perf_event_mmap_event.perf_event_mmap.mmap_region
      4.70 ± 13%     -41.8%       2.74 ±  9%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.shmem_mmap.mmap_region.do_mmap
      4.88 ± 14%     -45.8%       2.65 ± 12%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.unlink_file_vma_batch_final.free_pgtables.vms_clear_ptes
      4.94 ±  7%     -46.3%       2.65 ±  7%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.vma_link_file.mmap_region.do_mmap
      4.81 ±  9%     -42.1%       2.78 ±  5%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.vms_gather_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap
      5.05 ± 10%     -45.6%       2.75 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.down_write_killable.__vm_munmap.__x64_sys_munmap.do_syscall_64
      4.90 ±  8%     -42.5%       2.82 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
      4.89 ±  5%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_bulk_noprof.mas_alloc_nodes.mas_preallocate.mmap_region
      4.81 ±  9%     -44.9%       2.65        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.mmap_region
      4.91 ±  9%     -44.2%       2.74 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc.mmap_region.do_mmap
      4.79 ± 10%     -43.4%       2.71 ±  7%  perf-sched.wait_time.avg.ms.__cond_resched.remove_vma.vms_complete_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap
     42.49 ±  7%     +32.2%      56.18 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      4.79 ± 23%     -45.4%       2.61 ± 20%  perf-sched.wait_time.avg.ms.__cond_resched.unmap_page_range.unmap_vmas.vms_clear_ptes.vms_complete_munmap_vmas
      5.03 ±  7%     -45.3%       2.75 ±  7%  perf-sched.wait_time.avg.ms.__cond_resched.unmap_vmas.vms_clear_ptes.vms_complete_munmap_vmas.do_vmi_align_munmap
      4.78 ±  7%     -43.3%       2.71 ±  5%  perf-sched.wait_time.avg.ms.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
      3.92 ±  2%     -28.4%       2.81 ±  2%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      1.66 ± 23%     -48.7%       0.85 ± 58%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
      3.46            +9.2%       3.77 ±  3%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     81.41           +29.4%     105.36        perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     18.49 ± 11%     -45.8%      10.02 ±  4%  perf-sched.wait_time.max.ms.__cond_resched.down_write.vma_link_file.mmap_region.do_mmap
     16.40 ± 12%     -36.0%      10.49 ± 10%  perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.__vm_munmap.__x64_sys_munmap.do_syscall_64
     17.10 ± 12%     -34.7%      11.17 ± 11%  perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
     13.51 ± 11%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_bulk_noprof.mas_alloc_nodes.mas_preallocate.mmap_region
     13.86 ±  9%     -33.9%       9.17 ±  6%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.mmap_region
     15.92 ±  8%     -33.4%      10.59 ±  9%  perf-sched.wait_time.max.ms.__cond_resched.remove_vma.vms_complete_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap
    119.67 ± 31%     +78.9%     214.13 ± 23%  perf-sched.wait_time.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     12.90 ±  5%     -40.5%       7.67 ± 11%  perf-sched.wait_time.max.ms.__cond_resched.unmap_page_range.unmap_vmas.vms_clear_ptes.vms_complete_munmap_vmas
     23.15 ± 18%     -54.1%      10.62 ± 10%  perf-sched.wait_time.max.ms.__cond_resched.unmap_vmas.vms_clear_ptes.vms_complete_munmap_vmas.do_vmi_align_munmap
     17.65 ± 14%     -33.5%      11.75 ± 11%  perf-sched.wait_time.max.ms.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
      8.39 ± 31%     -38.9%       5.13 ± 22%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_call_function_single.[unknown]
     12.72 ±  5%     -29.8%       8.94 ±  8%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
     20.17           -15.0        5.21        perf-profile.calltrace.cycles-pp.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap
      9.74            -9.7        0.00        perf-profile.calltrace.cycles-pp.mas_wr_bnode.mas_store_prealloc.mmap_region.do_mmap.vm_mmap_pgoff
      8.92            -8.9        0.00        perf-profile.calltrace.cycles-pp.mas_wr_spanning_store.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      8.18            -8.2        0.00        perf-profile.calltrace.cycles-pp.mas_split.mas_wr_bnode.mas_store_prealloc.mmap_region.do_mmap
     14.46 ±  2%      -7.5        7.00 ±  2%  perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     14.45 ±  2%      -7.5        6.98 ±  2%  perf-profile.calltrace.cycles-pp.handle_softirqs.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork
     14.45 ±  2%      -7.5        6.98 ±  2%  perf-profile.calltrace.cycles-pp.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     14.47 ±  2%      -7.5        7.01 ±  2%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
     14.47 ±  2%      -7.5        7.01 ±  2%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
     14.47 ±  2%      -7.5        7.01 ±  2%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
     14.45 ±  2%      -7.5        6.98 ±  2%  perf-profile.calltrace.cycles-pp.rcu_core.handle_softirqs.run_ksoftirqd.smpboot_thread_fn.kthread
     14.43 ±  2%      -7.5        6.97 ±  2%  perf-profile.calltrace.cycles-pp.rcu_do_batch.rcu_core.handle_softirqs.run_ksoftirqd.smpboot_thread_fn
     10.87            -7.2        3.70        perf-profile.calltrace.cycles-pp.mas_store_prealloc.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
     12.53 ±  2%      -7.1        5.46 ±  2%  perf-profile.calltrace.cycles-pp.kmem_cache_free.rcu_do_batch.rcu_core.handle_softirqs.run_ksoftirqd
      8.37            -6.9        1.50        perf-profile.calltrace.cycles-pp.__slab_free.kmem_cache_free.rcu_do_batch.rcu_core.handle_softirqs
      6.32 ±  2%      -6.3        0.00        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_bulk_noprof.mas_alloc_nodes.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap
      6.22            -6.2        0.00        perf-profile.calltrace.cycles-pp.mas_spanning_rebalance.mas_wr_spanning_store.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap
      6.19 ±  2%      -6.2        0.00        perf-profile.calltrace.cycles-pp.__kmem_cache_alloc_bulk.kmem_cache_alloc_bulk_noprof.mas_alloc_nodes.mas_store_gfp.do_vmi_align_munmap
      6.69 ±  2%      -5.7        0.97        perf-profile.calltrace.cycles-pp.mas_alloc_nodes.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      5.66 ±  2%      -5.7        0.00        perf-profile.calltrace.cycles-pp.___slab_alloc.__kmem_cache_alloc_bulk.kmem_cache_alloc_bulk_noprof.mas_alloc_nodes.mas_store_gfp
      5.63 ±  2%      -5.6        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__slab_free.kmem_cache_free.rcu_do_batch.rcu_core
      5.53 ±  2%      -5.5        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__slab_free.kmem_cache_free.rcu_do_batch
     40.16            -4.0       36.15        perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64
     40.76            -3.7       37.06        perf-profile.calltrace.cycles-pp.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
     41.43            -3.4       38.08        perf-profile.calltrace.cycles-pp.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     41.31            -3.3       38.00        perf-profile.calltrace.cycles-pp.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     41.96            -3.0       38.94        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     43.02            -2.3       40.71        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__munmap
      1.92            -0.8        1.12        perf-profile.calltrace.cycles-pp.mas_alloc_nodes.mas_preallocate.mmap_region.do_mmap.vm_mmap_pgoff
     24.93            -0.8       24.18        perf-profile.calltrace.cycles-pp.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
      2.49            -0.5        1.97        perf-profile.calltrace.cycles-pp.mas_preallocate.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
      0.88 ±  3%      -0.3        0.55 ±  3%  perf-profile.calltrace.cycles-pp.rcu_cblist_dequeue.rcu_do_batch.rcu_core.handle_softirqs.run_ksoftirqd
      0.75            -0.2        0.54        perf-profile.calltrace.cycles-pp.mas_next_slot.mas_find.vms_gather_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap
      0.92            -0.1        0.78        perf-profile.calltrace.cycles-pp.mas_find.vms_gather_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      0.58 ±  2%      +0.0        0.60 ±  2%  perf-profile.calltrace.cycles-pp.kmem_cache_free.vm_area_free_rcu_cb.rcu_do_batch.rcu_core.handle_softirqs
      0.93            +0.2        1.08        perf-profile.calltrace.cycles-pp.mas_rev_awalk.mas_empty_area_rev.vm_unmapped_area.arch_get_unmapped_area_topdown.shmem_get_unmapped_area
      0.52            +0.3        0.80        perf-profile.calltrace.cycles-pp.unlink_file_vma_batch_final.free_pgtables.vms_clear_ptes.vms_complete_munmap_vmas.do_vmi_align_munmap
      0.52            +0.3        0.82        perf-profile.calltrace.cycles-pp.security_vm_enough_memory_mm.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
      0.70            +0.3        1.02        perf-profile.calltrace.cycles-pp.security_mmap_file.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.23            +0.4        1.58        perf-profile.calltrace.cycles-pp.mas_empty_area_rev.vm_unmapped_area.arch_get_unmapped_area_topdown.shmem_get_unmapped_area.__get_unmapped_area
      3.03            +0.4        3.40        perf-profile.calltrace.cycles-pp.vms_gather_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap
      0.70            +0.4        1.10        perf-profile.calltrace.cycles-pp.mas_find.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
      0.70            +0.4        1.11        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.__munmap
      0.70            +0.4        1.12        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.__mmap
      0.88            +0.5        1.34        perf-profile.calltrace.cycles-pp.shmem_mmap.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
      0.77            +0.5        1.25        perf-profile.calltrace.cycles-pp.prepend_path.d_path.perf_event_mmap_event.perf_event_mmap.mmap_region
      2.94 ±  2%      +0.5        3.42 ±  3%  perf-profile.calltrace.cycles-pp.__put_partials.kmem_cache_free.rcu_do_batch.rcu_core.handle_softirqs
      0.73            +0.5        1.23        perf-profile.calltrace.cycles-pp.rcu_all_qs.__cond_resched.zap_pmd_range.unmap_page_range.unmap_vmas
      0.00            +0.5        0.52        perf-profile.calltrace.cycles-pp.__kmalloc_cache_noprof.perf_event_mmap_event.perf_event_mmap.mmap_region.do_mmap
      0.00            +0.5        0.52        perf-profile.calltrace.cycles-pp.allocate_slab.___slab_alloc.kmem_cache_alloc_noprof.vm_area_alloc.mmap_region
      0.00            +0.5        0.54        perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.__munmap
      0.00            +0.5        0.54 ±  2%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.__mmap
      0.00            +0.5        0.54 ±  2%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.__mmap
      0.00            +0.5        0.54        perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.__munmap
      0.00            +0.5        0.54        perf-profile.calltrace.cycles-pp.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.zap_pmd_range.unmap_page_range
      0.00            +0.5        0.54        perf-profile.calltrace.cycles-pp.handle_softirqs.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.zap_pmd_range
      0.00            +0.6        0.56        perf-profile.calltrace.cycles-pp.mas_walk.mas_find.mmap_region.do_mmap.vm_mmap_pgoff
      0.00            +0.6        0.57        perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.zap_pmd_range.unmap_page_range.unmap_vmas
      0.00            +0.6        0.58        perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.zap_pmd_range.unmap_page_range.unmap_vmas.vms_clear_ptes
      0.00            +0.6        0.58 ±  2%  perf-profile.calltrace.cycles-pp.mas_walk.mas_find.do_vmi_munmap.__vm_munmap.__x64_sys_munmap
      0.00            +0.6        0.59        perf-profile.calltrace.cycles-pp.mas_wr_store_type.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      0.97            +0.6        1.60        perf-profile.calltrace.cycles-pp.__memcg_slab_post_alloc_hook.kmem_cache_alloc_noprof.vm_area_alloc.mmap_region.do_mmap
      0.00            +0.6        0.64        perf-profile.calltrace.cycles-pp.touch_atime.shmem_mmap.mmap_region.do_mmap.vm_mmap_pgoff
      0.94            +0.7        1.60        perf-profile.calltrace.cycles-pp.perf_event_mmap_output.perf_iterate_sb.perf_event_mmap_event.perf_event_mmap.mmap_region
      1.16            +0.7        1.83        perf-profile.calltrace.cycles-pp.d_path.perf_event_mmap_event.perf_event_mmap.mmap_region.do_mmap
      0.00            +0.7        0.67        perf-profile.calltrace.cycles-pp.mas_store_gfp.vms_gather_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      0.00            +0.7        0.69        perf-profile.calltrace.cycles-pp.___slab_alloc.kmem_cache_alloc_noprof.vm_area_alloc.mmap_region.do_mmap
      0.00            +0.7        0.73        perf-profile.calltrace.cycles-pp.mas_find.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64
      0.00            +0.8        0.80        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap
      2.06            +0.8        2.88        perf-profile.calltrace.cycles-pp.vm_unmapped_area.arch_get_unmapped_area_topdown.shmem_get_unmapped_area.__get_unmapped_area.do_mmap
      1.38            +0.9        2.25        perf-profile.calltrace.cycles-pp.free_pud_range.free_p4d_range.free_pgd_range.free_pgtables.vms_clear_ptes
     28.60            +0.9       29.50        perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.39            +0.9        2.29        perf-profile.calltrace.cycles-pp.perf_iterate_sb.perf_event_mmap_event.perf_event_mmap.mmap_region.do_mmap
      0.00            +0.9        0.94        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.mmap_region.do_mmap
      1.53            +1.0        2.53        perf-profile.calltrace.cycles-pp.entry_SYSRETQ_unsafe_stack.__mmap
      1.60            +1.0        2.61        perf-profile.calltrace.cycles-pp.free_p4d_range.free_pgd_range.free_pgtables.vms_clear_ptes.vms_complete_munmap_vmas
      1.54            +1.0        2.56        perf-profile.calltrace.cycles-pp.entry_SYSRETQ_unsafe_stack.__munmap
     47.96            +1.0       49.01        perf-profile.calltrace.cycles-pp.__munmap
      2.46            +1.1        3.55        perf-profile.calltrace.cycles-pp.arch_get_unmapped_area_topdown.shmem_get_unmapped_area.__get_unmapped_area.do_mmap.vm_mmap_pgoff
      1.75            +1.1        2.85        perf-profile.calltrace.cycles-pp.free_pgd_range.free_pgtables.vms_clear_ptes.vms_complete_munmap_vmas.do_vmi_align_munmap
      2.06            +1.3        3.35        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.vm_area_alloc.mmap_region.do_mmap.vm_mmap_pgoff
      1.88            +1.3        3.18        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.__mmap
      1.88            +1.3        3.18        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.__munmap
      2.88            +1.3        4.20        perf-profile.calltrace.cycles-pp.shmem_get_unmapped_area.__get_unmapped_area.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
      1.73 ±  5%      +1.4        3.09 ±  3%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.free_pcppages_bulk.free_unref_page_commit.free_unref_page
      3.01            +1.4        4.42        perf-profile.calltrace.cycles-pp.__get_unmapped_area.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
      2.36            +1.5        3.83        perf-profile.calltrace.cycles-pp.vm_area_alloc.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
     29.84            +1.6       31.39        perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
      2.83            +1.8        4.58        perf-profile.calltrace.cycles-pp.free_pgtables.vms_clear_ptes.vms_complete_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap
      2.83            +1.9        4.70        perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.vms_clear_ptes
     30.25            +1.9       32.13        perf-profile.calltrace.cycles-pp.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
      3.05            +1.9        4.96        perf-profile.calltrace.cycles-pp.__cond_resched.zap_pmd_range.unmap_page_range.unmap_vmas.vms_clear_ptes
      1.00 ±  4%      +2.1        3.12 ±  3%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.free_pcppages_bulk.free_unref_page_commit.free_unref_page.__put_partials
      1.06 ±  4%      +2.1        3.20 ±  3%  perf-profile.calltrace.cycles-pp.free_pcppages_bulk.free_unref_page_commit.free_unref_page.__put_partials.kmem_cache_free
      1.08 ±  4%      +2.1        3.22 ±  3%  perf-profile.calltrace.cycles-pp.free_unref_page_commit.free_unref_page.__put_partials.kmem_cache_free.rcu_do_batch
      1.10 ±  4%      +2.1        3.24 ±  3%  perf-profile.calltrace.cycles-pp.free_unref_page.__put_partials.kmem_cache_free.rcu_do_batch.rcu_core
     30.85            +2.3       33.11        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
      3.82            +2.3        6.09        perf-profile.calltrace.cycles-pp.perf_event_mmap_event.perf_event_mmap.mmap_region.do_mmap.vm_mmap_pgoff
      4.00            +2.4        6.44        perf-profile.calltrace.cycles-pp.perf_event_mmap.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
      0.00            +2.9        2.91        perf-profile.calltrace.cycles-pp.mas_wr_node_store.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      0.00            +2.9        2.94        perf-profile.calltrace.cycles-pp.mas_wr_node_store.mas_store_prealloc.mmap_region.do_mmap.vm_mmap_pgoff
     31.91            +3.0       34.90        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__mmap
     36.86            +6.3       43.18        perf-profile.calltrace.cycles-pp.__mmap
     10.33            +7.1       17.48        perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.vms_clear_ptes.vms_complete_munmap_vmas
     11.18            +7.2       18.36        perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.vms_clear_ptes.vms_complete_munmap_vmas.do_vmi_align_munmap
     11.60            +7.4       18.96        perf-profile.calltrace.cycles-pp.unmap_vmas.vms_clear_ptes.vms_complete_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap
     15.11            +9.6       24.66        perf-profile.calltrace.cycles-pp.vms_clear_ptes.vms_complete_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
     16.41           +10.2       26.66        perf-profile.calltrace.cycles-pp.vms_complete_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap
     20.69           -14.7        6.03        perf-profile.children.cycles-pp.mas_store_gfp
     18.70           -12.5        6.21        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     18.35           -12.3        6.01        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     22.06           -10.4       11.65        perf-profile.children.cycles-pp.kmem_cache_free
      9.75            -9.8        0.00        perf-profile.children.cycles-pp.mas_wr_bnode
      8.94            -8.9        0.00        perf-profile.children.cycles-pp.mas_wr_spanning_store
     12.75            -8.6        4.18        perf-profile.children.cycles-pp.__slab_free
     22.25            -8.6       13.69        perf-profile.children.cycles-pp.handle_softirqs
     22.23            -8.6       13.68        perf-profile.children.cycles-pp.rcu_core
     22.22            -8.6       13.66        perf-profile.children.cycles-pp.rcu_do_batch
      8.26            -8.3        0.00        perf-profile.children.cycles-pp.mas_split
      7.78 ±  2%      -7.8        0.00        perf-profile.children.cycles-pp.kmem_cache_alloc_bulk_noprof
     14.46 ±  2%      -7.5        7.00 ±  2%  perf-profile.children.cycles-pp.smpboot_thread_fn
     14.45 ±  2%      -7.5        6.98 ±  2%  perf-profile.children.cycles-pp.run_ksoftirqd
     14.48 ±  2%      -7.5        7.01 ±  2%  perf-profile.children.cycles-pp.ret_from_fork
     14.48 ±  2%      -7.5        7.01 ±  2%  perf-profile.children.cycles-pp.ret_from_fork_asm
     14.47 ±  2%      -7.5        7.01 ±  2%  perf-profile.children.cycles-pp.kthread
      7.41 ±  2%      -7.4        0.00        perf-profile.children.cycles-pp.__kmem_cache_alloc_bulk
     10.88            -7.2        3.72        perf-profile.children.cycles-pp.mas_store_prealloc
      8.62            -6.5        2.10        perf-profile.children.cycles-pp.mas_alloc_nodes
      6.27            -6.3        0.00        perf-profile.children.cycles-pp.mas_spanning_rebalance
      7.06 ±  2%      -5.4        1.70        perf-profile.children.cycles-pp.___slab_alloc
      4.74 ±  3%      -4.7        0.09        perf-profile.children.cycles-pp.get_partial_node
      4.73            -4.5        0.24 ±  2%  perf-profile.children.cycles-pp.mas_destroy
     40.18            -4.0       36.18        perf-profile.children.cycles-pp.do_vmi_align_munmap
     40.77            -3.7       37.10        perf-profile.children.cycles-pp.do_vmi_munmap
     41.44            -3.3       38.10        perf-profile.children.cycles-pp.__x64_sys_munmap
     41.33            -3.3       38.04        perf-profile.children.cycles-pp.__vm_munmap
      7.16            -1.5        5.64        perf-profile.children.cycles-pp.__put_partials
      7.80 ±  2%      -1.1        6.71        perf-profile.children.cycles-pp.__irq_exit_rcu
      8.22 ±  2%      -1.1        7.16        perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      8.25 ±  2%      -1.1        7.19        perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.97 ±  5%      -0.9        0.10 ±  3%  perf-profile.children.cycles-pp.get_any_partial
      0.89 ±  2%      -0.8        0.13        perf-profile.children.cycles-pp.memcpy_orig
     25.04            -0.7       24.34        perf-profile.children.cycles-pp.mmap_region
      1.34 ±  2%      -0.6        0.72        perf-profile.children.cycles-pp.mas_pop_node
      2.50            -0.5        1.98        perf-profile.children.cycles-pp.mas_preallocate
      1.40            -0.2        1.22 ±  3%  perf-profile.children.cycles-pp.rcu_cblist_dequeue
      1.27            -0.2        1.12        perf-profile.children.cycles-pp.allocate_slab
      0.82 ±  2%      -0.1        0.73        perf-profile.children.cycles-pp.shuffle_freelist
      0.35            -0.1        0.27        perf-profile.children.cycles-pp.alloc_pages_mpol_noprof
      0.40            -0.1        0.32        perf-profile.children.cycles-pp.rcu_segcblist_enqueue
      0.32            -0.1        0.24        perf-profile.children.cycles-pp.__alloc_pages_noprof
      0.29            -0.1        0.21 ±  2%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.11 ±  3%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.__memcpy
      0.16 ±  3%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.rmqueue
      0.21 ±  2%      -0.0        0.17 ±  2%  perf-profile.children.cycles-pp.mt_free_rcu
      0.12            -0.0        0.09 ±  4%  perf-profile.children.cycles-pp.__rmqueue_pcplist
      0.10 ±  3%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.rmqueue_bulk
      1.46            -0.0        1.43        perf-profile.children.cycles-pp.__call_rcu_common
      0.15            -0.0        0.13 ±  2%  perf-profile.children.cycles-pp.__free_one_page
      0.06            -0.0        0.05        perf-profile.children.cycles-pp.__get_random_u32_below
      0.06 ±  6%      +0.0        0.08        perf-profile.children.cycles-pp.mm_get_unmapped_area
      0.38 ±  2%      +0.0        0.40        perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.05            +0.0        0.07 ±  6%  perf-profile.children.cycles-pp.alloc_slab_obj_exts
      0.44 ±  2%      +0.0        0.46        perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.22 ±  3%      +0.0        0.25        perf-profile.children.cycles-pp.mas_data_end
      0.07 ±  5%      +0.0        0.11        perf-profile.children.cycles-pp.userfaultfd_unmap_prep
      0.07 ±  6%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.up_read
      0.06 ±  7%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.unlink_anon_vmas
      0.12 ±  4%      +0.0        0.16 ±  3%  perf-profile.children.cycles-pp.unmap_single_vma
      0.08 ±  4%      +0.0        0.12 ±  3%  perf-profile.children.cycles-pp.apparmor_current_getsecid_subj
      0.09 ±  4%      +0.0        0.14 ± 10%  perf-profile.children.cycles-pp.path_noexec
      0.07 ±  7%      +0.0        0.11 ±  3%  perf-profile.children.cycles-pp.uprobe_mmap
      0.06 ±  7%      +0.0        0.11 ±  3%  perf-profile.children.cycles-pp.__pte_offset_map
      0.17 ±  2%      +0.0        0.22 ±  3%  perf-profile.children.cycles-pp.current_time
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.mas_next_setup
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.munmap@plt
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.queued_spin_unlock
      0.13            +0.1        0.18 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock
      0.53            +0.1        0.58        perf-profile.children.cycles-pp.mas_leaf_max_gap
      0.00            +0.1        0.05 ±  7%  perf-profile.children.cycles-pp.get_mmap_base
      0.08            +0.1        0.13 ±  5%  perf-profile.children.cycles-pp.mas_prev_setup
      0.09 ±  7%      +0.1        0.15 ±  3%  perf-profile.children.cycles-pp.vm_get_page_prot
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.flush_tlb_batched_pending
      0.02 ±141%      +0.1        0.07        perf-profile.children.cycles-pp.__kmalloc_node_noprof
      0.10 ±  3%      +0.1        0.16 ±  3%  perf-profile.children.cycles-pp.security_current_getsecid_subj
      0.07            +0.1        0.12 ±  4%  perf-profile.children.cycles-pp.mas_node_count_gfp
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.prepend
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.uprobe_munmap
      0.12 ±  3%      +0.1        0.18 ±  2%  perf-profile.children.cycles-pp.mas_prev_range
      0.10 ±  5%      +0.1        0.16 ±  4%  perf-profile.children.cycles-pp.copy_from_kernel_nofault_allowed
      0.10 ±  3%      +0.1        0.16 ±  4%  perf-profile.children.cycles-pp.unlink_file_vma_batch_add
      0.08 ±  6%      +0.1        0.14 ±  3%  perf-profile.children.cycles-pp.refill_obj_stock
      0.09            +0.1        0.15 ±  2%  perf-profile.children.cycles-pp.mas_next_range
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.khugepaged_enter_vma
      0.05 ± 53%      +0.1        0.11 ± 22%  perf-profile.children.cycles-pp.perf_session__deliver_event
      0.15 ±  2%      +0.1        0.21 ±  3%  perf-profile.children.cycles-pp.vma_interval_tree_remove
      0.06 ± 35%      +0.1        0.13 ± 21%  perf-profile.children.cycles-pp.__ordered_events__flush
      0.06 ± 35%      +0.1        0.13 ± 21%  perf-profile.children.cycles-pp.perf_session__process_user_event
      0.11 ±  3%      +0.1        0.18 ±  2%  perf-profile.children.cycles-pp.downgrade_write
      0.01 ±223%      +0.1        0.08 ± 23%  perf-profile.children.cycles-pp.machine__process_mmap2_event
      0.00            +0.1        0.07        perf-profile.children.cycles-pp.get_align_mask
      0.10 ±  4%      +0.1        0.17 ±  2%  perf-profile.children.cycles-pp.may_expand_vm
      0.14 ±  4%      +0.1        0.21 ±  2%  perf-profile.children.cycles-pp.testcase
      0.11 ±  3%      +0.1        0.18 ±  3%  perf-profile.children.cycles-pp.tlb_gather_mmu
      0.12 ±  4%      +0.1        0.19 ±  3%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      1.25            +0.1        1.33        perf-profile.children.cycles-pp.mas_next_slot
      0.24            +0.1        0.32        perf-profile.children.cycles-pp.vma_merge_new_range
      0.16 ±  3%      +0.1        0.24 ±  2%  perf-profile.children.cycles-pp.lru_add_drain_cpu
      0.14 ±  3%      +0.1        0.22 ±  3%  perf-profile.children.cycles-pp.cap_vm_enough_memory
      0.13            +0.1        0.22 ±  2%  perf-profile.children.cycles-pp.__vm_enough_memory
      0.24            +0.1        0.33        perf-profile.children.cycles-pp.setup_object
      0.16 ±  2%      +0.1        0.26        perf-profile.children.cycles-pp.lru_add_drain
      0.14 ±  2%      +0.1        0.23 ±  4%  perf-profile.children.cycles-pp.static_key_count
      0.16 ±  3%      +0.1        0.25        perf-profile.children.cycles-pp.vma_set_page_prot
      0.16 ±  3%      +0.1        0.25        perf-profile.children.cycles-pp.tlb_finish_mmu
      0.20 ±  2%      +0.1        0.30 ±  2%  perf-profile.children.cycles-pp.ima_file_mmap
      0.28 ±  2%      +0.1        0.38        perf-profile.children.cycles-pp.vma_link_file
      0.18 ±  2%      +0.1        0.29 ±  2%  perf-profile.children.cycles-pp.mas_wr_store_entry
      0.21            +0.1        0.32 ±  4%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.22 ±  2%      +0.1        0.34        perf-profile.children.cycles-pp.fget
      0.28 ±  2%      +0.1        0.42        perf-profile.children.cycles-pp.remove_vma
      0.17 ±  2%      +0.1        0.31        perf-profile.children.cycles-pp.fput
      0.34            +0.1        0.48        perf-profile.children.cycles-pp.apparmor_mmap_file
      0.31 ±  3%      +0.2        0.46 ±  2%  perf-profile.children.cycles-pp.strlen
      0.25 ±  2%      +0.2        0.41 ±  2%  perf-profile.children.cycles-pp.obj_cgroup_charge
      0.23            +0.2        0.39        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.94            +0.2        1.10        perf-profile.children.cycles-pp.mas_rev_awalk
      0.34            +0.2        0.51        perf-profile.children.cycles-pp.atime_needs_update
      0.28            +0.2        0.45        perf-profile.children.cycles-pp.__pte_offset_map_lock
      0.35            +0.2        0.53        perf-profile.children.cycles-pp.__kmalloc_cache_noprof
      0.30 ±  4%      +0.2        0.49        perf-profile.children.cycles-pp.mas_prev
      0.29 ±  4%      +0.2        0.49        perf-profile.children.cycles-pp.kfree
      0.45            +0.2        0.65        perf-profile.children.cycles-pp.touch_atime
      0.34            +0.2        0.55        perf-profile.children.cycles-pp.mod_objcg_state
      0.34            +0.2        0.56        perf-profile.children.cycles-pp.userfaultfd_unmap_complete
      0.30 ±  2%      +0.2        0.53        perf-profile.children.cycles-pp.down_write_killable
      0.00            +0.3        0.25        perf-profile.children.cycles-pp.mas_put_in_tree
      0.42 ±  2%      +0.3        0.69        perf-profile.children.cycles-pp.copy_from_kernel_nofault
      0.62            +0.3        0.89 ±  2%  perf-profile.children.cycles-pp.down_write
      0.42            +0.3        0.70        perf-profile.children.cycles-pp.up_write
      0.48 ±  2%      +0.3        0.77        perf-profile.children.cycles-pp.prepend_copy
      0.53            +0.3        0.82        perf-profile.children.cycles-pp.unlink_file_vma_batch_final
      0.71            +0.3        1.03        perf-profile.children.cycles-pp.security_mmap_file
      0.54            +0.3        0.88        perf-profile.children.cycles-pp.security_vm_enough_memory_mm
      1.25            +0.4        1.61        perf-profile.children.cycles-pp.mas_empty_area_rev
      0.45            +0.4        0.82        perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.63            +0.4        1.00        perf-profile.children.cycles-pp.__memcg_slab_free_hook
      3.07            +0.4        3.46        perf-profile.children.cycles-pp.vms_gather_munmap_vmas
      0.89            +0.5        1.36        perf-profile.children.cycles-pp.shmem_mmap
      0.78            +0.5        1.26        perf-profile.children.cycles-pp.prepend_path
      0.89            +0.5        1.43        perf-profile.children.cycles-pp.mas_walk
      1.31            +0.6        1.88        perf-profile.children.cycles-pp.vm_area_free_rcu_cb
      0.54            +0.6        1.11        perf-profile.children.cycles-pp.mas_wr_store_type
      1.01            +0.7        1.66        perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
      0.95            +0.7        1.62        perf-profile.children.cycles-pp.perf_event_mmap_output
      1.18            +0.7        1.85        perf-profile.children.cycles-pp.d_path
     75.04            +0.7       75.74        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      1.19            +0.8        1.95        perf-profile.children.cycles-pp.rcu_all_qs
      2.08            +0.8        2.90        perf-profile.children.cycles-pp.vm_unmapped_area
      0.00            +0.9        0.87        perf-profile.children.cycles-pp.mas_update_gap
      1.38            +0.9        2.26        perf-profile.children.cycles-pp.free_pud_range
      1.40            +0.9        2.30        perf-profile.children.cycles-pp.perf_iterate_sb
     28.62            +0.9       29.52        perf-profile.children.cycles-pp.do_mmap
      2.79            +0.9        3.70        perf-profile.children.cycles-pp.mas_find
      1.61            +1.0        2.63        perf-profile.children.cycles-pp.free_p4d_range
      2.47            +1.1        3.58        perf-profile.children.cycles-pp.arch_get_unmapped_area_topdown
      1.76            +1.1        2.86        perf-profile.children.cycles-pp.free_pgd_range
     48.10            +1.1       49.23        perf-profile.children.cycles-pp.__munmap
      1.72            +1.1        2.86        perf-profile.children.cycles-pp.entry_SYSCALL_64
      2.89            +1.3        4.20        perf-profile.children.cycles-pp.shmem_get_unmapped_area
      3.01            +1.4        4.43        perf-profile.children.cycles-pp.__get_unmapped_area
      2.37            +1.5        3.85        perf-profile.children.cycles-pp.vm_area_alloc
     29.86            +1.6       31.42        perf-profile.children.cycles-pp.vm_mmap_pgoff
      2.90            +1.8        4.69        perf-profile.children.cycles-pp.free_pgtables
      2.85            +1.9        4.72        perf-profile.children.cycles-pp.zap_pte_range
     30.27            +1.9       32.16        perf-profile.children.cycles-pp.ksys_mmap_pgoff
      3.33            +2.2        5.53        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      3.84            +2.3        6.12        perf-profile.children.cycles-pp.perf_event_mmap_event
      4.01            +2.4        6.45        perf-profile.children.cycles-pp.perf_event_mmap
      2.71 ±  3%      +2.5        5.24        perf-profile.children.cycles-pp.free_unref_page
      2.61 ±  3%      +2.5        5.14        perf-profile.children.cycles-pp.free_pcppages_bulk
      2.63            +2.5        5.16        perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
      2.66 ±  3%      +2.5        5.20        perf-profile.children.cycles-pp.free_unref_page_commit
      3.80            +2.6        6.41        perf-profile.children.cycles-pp.syscall_return_via_sysret
      4.38            +2.7        7.11        perf-profile.children.cycles-pp.__cond_resched
      0.00            +5.9        5.94        perf-profile.children.cycles-pp.mas_wr_node_store
     36.99            +6.4       43.41        perf-profile.children.cycles-pp.__mmap
     10.58            +6.8       17.37        perf-profile.children.cycles-pp.zap_pmd_range
     11.21            +7.2       18.40        perf-profile.children.cycles-pp.unmap_page_range
     11.60            +7.4       18.98        perf-profile.children.cycles-pp.unmap_vmas
     15.13            +9.6       24.70        perf-profile.children.cycles-pp.vms_clear_ptes
     16.50           +10.3       26.81        perf-profile.children.cycles-pp.vms_complete_munmap_vmas
     18.35           -12.3        6.00        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      4.33            -1.1        3.22        perf-profile.self.cycles-pp.__slab_free
      1.71            -0.9        0.81        perf-profile.self.cycles-pp.kmem_cache_free
      0.78 ±  2%      -0.7        0.11        perf-profile.self.cycles-pp.memcpy_orig
      1.23            -0.6        0.66        perf-profile.self.cycles-pp.mas_pop_node
      0.82            -0.4        0.37        perf-profile.self.cycles-pp.___slab_alloc
      1.39            -0.2        1.20 ±  3%  perf-profile.self.cycles-pp.rcu_cblist_dequeue
      0.35 ±  2%      -0.1        0.21 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.65            -0.1        0.54        perf-profile.self.cycles-pp.shuffle_freelist
      0.40            -0.1        0.32        perf-profile.self.cycles-pp.rcu_segcblist_enqueue
      0.21 ±  2%      -0.0        0.17 ±  2%  perf-profile.self.cycles-pp.mas_destroy
      0.12 ±  3%      -0.0        0.09        perf-profile.self.cycles-pp.get_any_partial
      0.20            -0.0        0.17        perf-profile.self.cycles-pp.mt_free_rcu
      0.14 ±  3%      -0.0        0.11 ±  3%  perf-profile.self.cycles-pp.__free_one_page
      0.07            -0.0        0.06 ±  9%  perf-profile.self.cycles-pp.rmqueue_bulk
      0.06 ±  8%      +0.0        0.07        perf-profile.self.cycles-pp.mm_get_unmapped_area
      0.08 ±  5%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.unmap_single_vma
      0.06 ±  7%      +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.vma_link_file
      0.30            +0.0        0.32        perf-profile.self.cycles-pp.mas_alloc_nodes
      0.09            +0.0        0.11 ±  4%  perf-profile.self.cycles-pp.touch_atime
      0.19 ±  2%      +0.0        0.22 ±  2%  perf-profile.self.cycles-pp.mas_data_end
      0.05            +0.0        0.08 ±  4%  perf-profile.self.cycles-pp.prepend_copy
      0.07            +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.up_read
      0.06            +0.0        0.09 ±  5%  perf-profile.self.cycles-pp.uprobe_mmap
      0.06 ±  8%      +0.0        0.09        perf-profile.self.cycles-pp.mas_next_range
      0.06 ±  6%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.userfaultfd_unmap_prep
      0.08            +0.0        0.12 ±  4%  perf-profile.self.cycles-pp.unlink_file_vma_batch_add
      0.08 ±  4%      +0.0        0.12        perf-profile.self.cycles-pp.mas_prev_range
      0.07            +0.0        0.11        perf-profile.self.cycles-pp.apparmor_current_getsecid_subj
      0.09            +0.0        0.13        perf-profile.self.cycles-pp.setup_object
      0.07            +0.0        0.11 ±  5%  perf-profile.self.cycles-pp.testcase
      0.09 ±  4%      +0.0        0.13 ±  2%  perf-profile.self.cycles-pp.ima_file_mmap
      0.07 ±  5%      +0.0        0.11 ±  9%  perf-profile.self.cycles-pp.path_noexec
      0.07 ±  7%      +0.0        0.11 ±  3%  perf-profile.self.cycles-pp.mas_prev_setup
      0.06 ±  6%      +0.0        0.10        perf-profile.self.cycles-pp.__pte_offset_map
      0.12 ±  3%      +0.0        0.16 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock
      0.12 ±  3%      +0.0        0.16 ±  2%  perf-profile.self.cycles-pp.remove_vma
      0.05            +0.0        0.10 ±  5%  perf-profile.self.cycles-pp.mas_node_count_gfp
      0.08 ±  4%      +0.0        0.13 ±  2%  perf-profile.self.cycles-pp.vm_get_page_prot
      0.12 ±  3%      +0.1        0.17 ±  2%  perf-profile.self.cycles-pp.vma_interval_tree_remove
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.flush_tlb_batched_pending
      0.10 ±  4%      +0.1        0.15 ±  7%  perf-profile.self.cycles-pp.current_time
      0.49            +0.1        0.54        perf-profile.self.cycles-pp.mas_leaf_max_gap
      0.08 ±  5%      +0.1        0.14 ±  4%  perf-profile.self.cycles-pp.copy_from_kernel_nofault_allowed
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.__vm_enough_memory
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.get_align_mask
      0.08 ±  6%      +0.1        0.14 ±  3%  perf-profile.self.cycles-pp.refill_obj_stock
      0.10 ±  5%      +0.1        0.16 ±  3%  perf-profile.self.cycles-pp.vma_set_page_prot
      0.09 ±  5%      +0.1        0.15 ±  2%  perf-profile.self.cycles-pp.may_expand_vm
      0.10 ±  3%      +0.1        0.16 ±  3%  perf-profile.self.cycles-pp.do_vmi_munmap
      0.10 ±  3%      +0.1        0.16 ±  3%  perf-profile.self.cycles-pp.downgrade_write
      0.10            +0.1        0.16 ±  3%  perf-profile.self.cycles-pp.tlb_gather_mmu
      0.10            +0.1        0.17 ±  2%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.16 ±  4%      +0.1        0.23 ±  3%  perf-profile.self.cycles-pp.security_mmap_file
      0.10            +0.1        0.17 ±  4%  perf-profile.self.cycles-pp.static_key_count
      0.13 ±  2%      +0.1        0.20        perf-profile.self.cycles-pp.vma_merge_new_range
      0.09            +0.1        0.16        perf-profile.self.cycles-pp.__pte_offset_map_lock
      0.00            +0.1        0.07        perf-profile.self.cycles-pp.unlink_anon_vmas
      0.09 ±  5%      +0.1        0.17 ±  4%  perf-profile.self.cycles-pp.__get_unmapped_area
      0.12 ±  4%      +0.1        0.20 ±  2%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.10 ±  3%      +0.1        0.17 ±  2%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.14 ±  2%      +0.1        0.21 ±  2%  perf-profile.self.cycles-pp.lru_add_drain_cpu
      0.12 ±  3%      +0.1        0.20 ±  4%  perf-profile.self.cycles-pp.cap_vm_enough_memory
      0.14 ±  3%      +0.1        0.22 ±  3%  perf-profile.self.cycles-pp.free_pgd_range
      0.13            +0.1        0.21        perf-profile.self.cycles-pp.tlb_finish_mmu
      0.15            +0.1        0.23        perf-profile.self.cycles-pp.mas_wr_store_entry
      0.79            +0.1        0.87        perf-profile.self.cycles-pp.mas_rev_awalk
      0.14 ±  3%      +0.1        0.23        perf-profile.self.cycles-pp.vm_mmap_pgoff
      0.16 ±  3%      +0.1        0.24        perf-profile.self.cycles-pp.unmap_vmas
      0.13            +0.1        0.22 ±  2%  perf-profile.self.cycles-pp.unlink_file_vma_batch_final
      0.15 ±  2%      +0.1        0.25 ±  2%  perf-profile.self.cycles-pp.atime_needs_update
      0.16 ±  5%      +0.1        0.26 ±  2%  perf-profile.self.cycles-pp.down_write_killable
      0.36 ±  3%      +0.1        0.46 ±  2%  perf-profile.self.cycles-pp.vm_area_free_rcu_cb
      0.17            +0.1        0.28 ±  2%  perf-profile.self.cycles-pp.obj_cgroup_charge
      0.19            +0.1        0.30 ±  4%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.20            +0.1        0.31        perf-profile.self.cycles-pp.fget
      0.12 ±  3%      +0.1        0.23 ±  2%  perf-profile.self.cycles-pp.ksys_mmap_pgoff
      0.29            +0.1        0.40        perf-profile.self.cycles-pp.apparmor_mmap_file
      0.21            +0.1        0.33 ±  2%  perf-profile.self.cycles-pp.d_path
      0.22            +0.1        0.34        perf-profile.self.cycles-pp.__vm_munmap
      0.14 ±  2%      +0.1        0.26        perf-profile.self.cycles-pp.fput
      0.23 ±  3%      +0.1        0.35        perf-profile.self.cycles-pp.shmem_mmap
      0.27            +0.1        0.39        perf-profile.self.cycles-pp.__kmalloc_cache_noprof
      0.23            +0.1        0.36 ±  2%  perf-profile.self.cycles-pp.vm_area_alloc
      0.20 ±  2%      +0.1        0.33        perf-profile.self.cycles-pp.mas_prev
      0.45            +0.1        0.59 ±  2%  perf-profile.self.cycles-pp.do_mmap
      0.21 ±  2%      +0.1        0.34 ±  2%  perf-profile.self.cycles-pp.mas_preallocate
      0.29 ±  3%      +0.1        0.42 ±  3%  perf-profile.self.cycles-pp.strlen
      0.21            +0.1        0.35        perf-profile.self.cycles-pp.free_p4d_range
      0.20 ±  3%      +0.1        0.34        perf-profile.self.cycles-pp.vms_clear_ptes
      0.16            +0.1        0.30        perf-profile.self.cycles-pp.perf_event_mmap
      0.38            +0.1        0.53        perf-profile.self.cycles-pp.down_write
      0.30            +0.2        0.46        perf-profile.self.cycles-pp.vms_complete_munmap_vmas
      0.24            +0.2        0.40 ±  2%  perf-profile.self.cycles-pp.mas_empty_area_rev
      0.24            +0.2        0.40 ±  3%  perf-profile.self.cycles-pp.__mmap
      0.27 ±  2%      +0.2        0.44 ±  2%  perf-profile.self.cycles-pp.security_vm_enough_memory_mm
      0.26 ±  4%      +0.2        0.43 ±  2%  perf-profile.self.cycles-pp.kfree
      0.32            +0.2        0.50        perf-profile.self.cycles-pp.vm_unmapped_area
      0.34            +0.2        0.52        perf-profile.self.cycles-pp.__memcg_slab_free_hook
      0.31 ±  2%      +0.2        0.49        perf-profile.self.cycles-pp.free_pgtables
      0.33 ±  3%      +0.2        0.51 ±  3%  perf-profile.self.cycles-pp.shmem_get_unmapped_area
      0.30            +0.2        0.48        perf-profile.self.cycles-pp.mod_objcg_state
      0.31 ±  2%      +0.2        0.50        perf-profile.self.cycles-pp.copy_from_kernel_nofault
      0.30            +0.2        0.50        perf-profile.self.cycles-pp.userfaultfd_unmap_complete
      0.34 ±  3%      +0.2        0.54 ±  3%  perf-profile.self.cycles-pp.perf_event_mmap_event
      0.40            +0.2        0.60        perf-profile.self.cycles-pp.vms_gather_munmap_vmas
      0.36            +0.2        0.57 ±  2%  perf-profile.self.cycles-pp.mas_store_prealloc
      0.31            +0.2        0.52        perf-profile.self.cycles-pp.arch_get_unmapped_area_topdown
      0.41 ±  2%      +0.2        0.63 ±  3%  perf-profile.self.cycles-pp.perf_iterate_sb
      0.40 ±  2%      +0.2        0.62 ±  2%  perf-profile.self.cycles-pp.prepend_path
      0.25 ±  2%      +0.2        0.47        perf-profile.self.cycles-pp.__munmap
      0.00            +0.2        0.23 ±  2%  perf-profile.self.cycles-pp.mas_put_in_tree
      0.34            +0.3        0.59        perf-profile.self.cycles-pp.do_syscall_64
      0.38            +0.3        0.63        perf-profile.self.cycles-pp.up_write
      0.00            +0.3        0.28        perf-profile.self.cycles-pp.mas_update_gap
      0.40            +0.3        0.68        perf-profile.self.cycles-pp.do_vmi_align_munmap
      0.69            +0.3        0.99        perf-profile.self.cycles-pp.mas_prev_slot
      0.50            +0.3        0.82        perf-profile.self.cycles-pp.unmap_page_range
      0.61            +0.4        0.97        perf-profile.self.cycles-pp.mas_store_gfp
      0.78            +0.4        1.14        perf-profile.self.cycles-pp.mas_find
      0.80            +0.4        1.17        perf-profile.self.cycles-pp.mas_next_slot
      0.57            +0.4        0.95        perf-profile.self.cycles-pp.__memcg_slab_post_alloc_hook
      0.78            +0.5        1.25        perf-profile.self.cycles-pp.mas_walk
      0.85            +0.5        1.38        perf-profile.self.cycles-pp.rcu_all_qs
      0.48            +0.5        1.01        perf-profile.self.cycles-pp.mas_wr_store_type
      0.92 ±  2%      +0.6        1.47        perf-profile.self.cycles-pp.kmem_cache_alloc_noprof
      0.87            +0.6        1.48        perf-profile.self.cycles-pp.perf_event_mmap_output
      1.28            +0.8        2.07        perf-profile.self.cycles-pp.free_pud_range
      1.34            +0.8        2.16        perf-profile.self.cycles-pp.mmap_region
      1.51            +1.0        2.51        perf-profile.self.cycles-pp.entry_SYSCALL_64
      2.18            +1.5        3.66        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      2.33            +1.5        3.85        perf-profile.self.cycles-pp.zap_pte_range
      2.94            +1.8        4.75        perf-profile.self.cycles-pp.__cond_resched
      3.30            +2.2        5.47        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      4.02            +2.6        6.60        perf-profile.self.cycles-pp.zap_pmd_range
      3.80            +2.6        6.40        perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.00            +2.8        2.79        perf-profile.self.cycles-pp.mas_wr_node_store


***************************************************************************************************
lkp-skl-fpga01: 104 threads 2 sockets (Skylake) with 192G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/process/100%/debian-12-x86_64-20240206.cgz/lkp-skl-fpga01/brk2/will-it-scale

commit: 
  05a6b8c190 ("x86/vdso: Delete vvar.h")
  e93d2521b2 ("x86/vdso: Split virtual clock pages into dedicated mapping")

05a6b8c190f00792 e93d2521b27f0439872dfa4e4b9 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    691889 ±  3%     +27.6%     882948 ±  4%  meminfo.Mapped
    133140 ± 74%     -81.4%      24791 ± 80%  numa-meminfo.node1.AnonHugePages
    607904 ±  7%     +33.0%     808359 ±  3%  numa-meminfo.node1.Mapped
      8.63          +100.3%      17.29        vmstat.cpu.us
      8314           -25.3%       6214        vmstat.system.cs
      0.44            +0.1        0.51 ±  2%  mpstat.cpu.all.irq%
     27.68           -13.3       14.35        mpstat.cpu.all.soft%
      8.60            +8.7       17.33        mpstat.cpu.all.usr%
  12965384          +113.4%   27664625        will-it-scale.104.processes
    124666          +113.4%     266005        will-it-scale.per_process_ops
  12965384          +113.4%   27664625        will-it-scale.workload
 1.736e+08           -19.9%  1.391e+08        numa-numastat.node0.local_node
 1.737e+08           -19.9%  1.391e+08        numa-numastat.node0.numa_hit
 1.817e+08           -18.8%  1.475e+08        numa-numastat.node1.local_node
 1.818e+08           -18.8%  1.476e+08        numa-numastat.node1.numa_hit
     16373 ±  9%     -65.9%       5577 ±  5%  perf-c2c.DRAM.local
      1291 ±  9%     -73.2%     346.50 ±  8%  perf-c2c.DRAM.remote
     11127 ± 10%     -76.5%       2613 ±  3%  perf-c2c.HITM.local
    890.67 ±  9%     -79.9%     179.17 ±  8%  perf-c2c.HITM.remote
     12018 ± 10%     -76.8%       2792 ±  3%  perf-c2c.HITM.total
 1.737e+08           -19.9%  1.391e+08        numa-vmstat.node0.numa_hit
 1.736e+08           -19.9%  1.391e+08        numa-vmstat.node0.numa_local
    151859 ±  7%     +32.9%     201887 ±  3%  numa-vmstat.node1.nr_mapped
     72299 ±  2%     -12.1%      63516 ±  5%  numa-vmstat.node1.nr_slab_unreclaimable
 1.818e+08           -18.8%  1.476e+08        numa-vmstat.node1.numa_hit
 1.817e+08           -18.8%  1.475e+08        numa-vmstat.node1.numa_local
    173021 ±  3%     +27.9%     221285 ±  4%  proc-vmstat.nr_mapped
      3425            +2.6%       3516        proc-vmstat.nr_page_table_pages
    132432            -5.1%     125672        proc-vmstat.nr_slab_unreclaimable
 3.555e+08           -19.3%  2.867e+08        proc-vmstat.numa_hit
 3.554e+08           -19.4%  2.866e+08        proc-vmstat.numa_local
 6.963e+08           -22.0%  5.434e+08        proc-vmstat.pgalloc_normal
 6.957e+08           -22.0%  5.428e+08        proc-vmstat.pgfree
      2.71           -23.0%       2.09        perf-stat.i.MPKI
 2.511e+10           +12.9%  2.836e+10        perf-stat.i.branch-instructions
      0.80            -0.2        0.63        perf-stat.i.branch-miss-rate%
 2.001e+08           -11.2%  1.777e+08        perf-stat.i.branch-misses
     61.72            -0.9       60.83        perf-stat.i.cache-miss-rate%
 3.723e+08           -17.9%  3.055e+08        perf-stat.i.cache-misses
 6.026e+08           -16.7%  5.019e+08        perf-stat.i.cache-references
      8289           -25.3%       6190        perf-stat.i.context-switches
      2.04            -6.3%       1.91        perf-stat.i.cpi
    311.16           -40.2%     186.10        perf-stat.i.cpu-migrations
    751.46           +21.8%     915.00        perf-stat.i.cycles-between-cache-misses
 1.371e+11            +6.6%  1.461e+11        perf-stat.i.instructions
      0.49            +6.6%       0.52        perf-stat.i.ipc
      2.72           -23.0%       2.09        perf-stat.overall.MPKI
      0.80            -0.2        0.63        perf-stat.overall.branch-miss-rate%
     61.77            -0.9       60.88        perf-stat.overall.cache-miss-rate%
      2.04            -6.3%       1.91        perf-stat.overall.cpi
    751.28           +21.7%     914.64        perf-stat.overall.cycles-between-cache-misses
      0.49            +6.7%       0.52        perf-stat.overall.ipc
   3193278           -50.1%    1594245        perf-stat.overall.path-length
 2.503e+10           +12.9%  2.826e+10        perf-stat.ps.branch-instructions
 1.994e+08           -11.2%  1.771e+08        perf-stat.ps.branch-misses
  3.71e+08           -17.9%  3.045e+08        perf-stat.ps.cache-misses
 6.006e+08           -16.7%  5.002e+08        perf-stat.ps.cache-references
      8260           -25.3%       6169        perf-stat.ps.context-switches
    310.06           -40.2%     185.44        perf-stat.ps.cpu-migrations
 1.366e+11            +6.6%  1.456e+11        perf-stat.ps.instructions
  4.14e+13            +6.5%   4.41e+13        perf-stat.total.instructions
  94529690           -51.8%   45556680 ±  3%  sched_debug.cfs_rq:/.avg_vruntime.avg
  1.32e+08 ±  4%     -48.2%   68428408 ±  4%  sched_debug.cfs_rq:/.avg_vruntime.max
  62148560 ± 10%     -55.0%   27945263 ±  4%  sched_debug.cfs_rq:/.avg_vruntime.min
  12542821 ±  9%     -35.2%    8121613 ±  4%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      1.02 ±  3%      -9.5%       0.93        sched_debug.cfs_rq:/.h_nr_running.avg
      0.43 ±  6%     -27.0%       0.32 ±  6%  sched_debug.cfs_rq:/.h_nr_running.stddev
  15458646 ± 22%     -85.9%    2182180 ± 38%  sched_debug.cfs_rq:/.left_deadline.avg
 1.192e+08 ±  4%     -60.6%   46935074 ± 15%  sched_debug.cfs_rq:/.left_deadline.max
  34580787 ± 11%     -75.0%    8657887 ± 23%  sched_debug.cfs_rq:/.left_deadline.stddev
  15457280 ± 22%     -85.9%    2182172 ± 38%  sched_debug.cfs_rq:/.left_vruntime.avg
 1.192e+08 ±  4%     -60.6%   46934932 ± 15%  sched_debug.cfs_rq:/.left_vruntime.max
  34577859 ± 11%     -75.0%    8657858 ± 23%  sched_debug.cfs_rq:/.left_vruntime.stddev
    149254 ± 23%     -64.7%      52658 ± 29%  sched_debug.cfs_rq:/.load.avg
    313617 ± 13%     -43.9%     175948 ± 22%  sched_debug.cfs_rq:/.load.stddev
     85.33 ± 16%     -77.1%      19.53 ± 21%  sched_debug.cfs_rq:/.load_avg.min
  94529746           -51.8%   45556698 ±  3%  sched_debug.cfs_rq:/.min_vruntime.avg
  1.32e+08 ±  4%     -48.2%   68428408 ±  4%  sched_debug.cfs_rq:/.min_vruntime.max
  62148577 ± 10%     -55.0%   27945297 ±  4%  sched_debug.cfs_rq:/.min_vruntime.min
  12542825 ±  9%     -35.2%    8121614 ±  4%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.99 ±  3%      -9.5%       0.90        sched_debug.cfs_rq:/.nr_running.avg
      0.36 ±  9%     -37.7%       0.22 ± 15%  sched_debug.cfs_rq:/.nr_running.stddev
  15457280 ± 22%     -85.9%    2182172 ± 38%  sched_debug.cfs_rq:/.right_vruntime.avg
 1.192e+08 ±  4%     -60.6%   46934932 ± 15%  sched_debug.cfs_rq:/.right_vruntime.max
  34577860 ± 11%     -75.0%    8657859 ± 23%  sched_debug.cfs_rq:/.right_vruntime.stddev
      1095           -11.7%     967.25        sched_debug.cfs_rq:/.runnable_avg.avg
      2155 ±  6%     -10.4%       1931        sched_debug.cfs_rq:/.runnable_avg.max
    541.97 ± 29%     +44.6%     783.81 ± 11%  sched_debug.cfs_rq:/.runnable_avg.min
    190.05 ±  5%     -15.1%     161.33 ±  5%  sched_debug.cfs_rq:/.runnable_avg.stddev
      1298 ±  6%     -11.9%       1144 ±  5%  sched_debug.cfs_rq:/.util_avg.max
    442.75 ± 26%     +60.4%     710.00 ± 10%  sched_debug.cfs_rq:/.util_avg.min
    108.77 ± 11%     -35.1%      70.64 ± 13%  sched_debug.cfs_rq:/.util_avg.stddev
    712.68 ±  4%     +12.6%     802.68 ±  2%  sched_debug.cfs_rq:/.util_est.avg
      2989 ±  4%     +11.5%       3331 ±  2%  sched_debug.cpu.curr->pid.avg
      1326 ±  8%     -31.9%     903.31 ±  9%  sched_debug.cpu.curr->pid.stddev
      1.02 ±  3%      -9.3%       0.93        sched_debug.cpu.nr_running.avg
      0.43 ±  6%     -26.5%       0.32 ±  6%  sched_debug.cpu.nr_running.stddev
     13005           -23.0%      10008        sched_debug.cpu.nr_switches.avg
     26775 ±  7%     -24.5%      20214 ±  8%  sched_debug.cpu.nr_switches.max
      9677           -28.7%       6895        sched_debug.cpu.nr_switches.min
      3310 ±  6%     -22.4%       2569 ±  8%  sched_debug.cpu.nr_switches.stddev
      5.32 ± 15%     -44.6%       2.95 ± 26%  perf-sched.sch_delay.avg.ms.__cond_resched.__kmalloc_node_noprof.alloc_slab_obj_exts.allocate_slab.___slab_alloc
      5.54 ± 10%     -47.0%       2.93 ±  7%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.__split_vma.vms_gather_munmap_vmas.do_vmi_align_munmap
      5.36 ±  5%     -43.1%       3.05 ±  5%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.vma_expand.vma_merge_new_range.do_brk_flags
      5.39 ±  5%     -44.5%       2.99 ±  5%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write_killable.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.26 ± 25%     -31.6%       1.55 ± 43%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
      0.00 ±223%  +20527.3%       0.38 ±149%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.step_into.link_path_walk.part
      5.19 ±  7%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_bulk_noprof.mas_alloc_nodes.mas_preallocate.commit_merge
      5.22 ±  7%     -42.2%       3.02 ±  6%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.__split_vma
      5.27 ± 10%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.commit_merge
      5.21 ± 12%     -42.6%       2.99 ±  5%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.vms_gather_munmap_vmas
      5.29 ±  7%     -43.3%       3.00 ±  6%  perf-sched.sch_delay.avg.ms.__cond_resched.remove_vma.vms_complete_munmap_vmas.do_vmi_align_munmap.__do_sys_brk
      3.59 ± 18%     -26.3%       2.64 ± 13%  perf-sched.sch_delay.avg.ms.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin
      0.04 ± 26%     -58.5%       0.02 ± 24%  perf-sched.sch_delay.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      5.76 ± 24%     -45.0%       3.17 ± 17%  perf-sched.sch_delay.avg.ms.__cond_resched.unmap_page_range.unmap_vmas.vms_clear_ptes.vms_complete_munmap_vmas
      5.44 ±  6%     -45.4%       2.97 ±  6%  perf-sched.sch_delay.avg.ms.__cond_resched.unmap_vmas.vms_clear_ptes.vms_complete_munmap_vmas.do_vmi_align_munmap
      5.29 ± 10%     -43.1%       3.01 ±  5%  perf-sched.sch_delay.avg.ms.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
      4.33 ±  5%     -31.0%       2.98 ±  2%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      0.12 ± 23%     -46.2%       0.06 ± 27%  perf-sched.sch_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.18 ± 12%     -59.6%       0.07 ± 15%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.04 ± 11%     -32.2%       0.02 ± 10%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      4.73 ±  5%     -57.1%       2.03 ± 11%  perf-sched.sch_delay.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      7.66 ± 28%     -54.5%       3.49 ± 45%  perf-sched.sch_delay.max.ms.__cond_resched.__alloc_pages_noprof.alloc_pages_mpol_noprof.folio_alloc_mpol_noprof.shmem_alloc_folio
     14.40 ± 18%     -47.0%       7.63 ± 13%  perf-sched.sch_delay.max.ms.__cond_resched.__kmalloc_node_noprof.alloc_slab_obj_exts.allocate_slab.___slab_alloc
     18.01 ± 10%     -31.1%      12.41 ± 20%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.__split_vma.vms_gather_munmap_vmas.do_vmi_align_munmap
     22.27 ± 20%     -45.8%      12.07 ± 18%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.vma_expand.vma_merge_new_range.do_brk_flags
     22.89 ± 13%     -48.3%      11.84 ± 11%  perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00 ±223%  +20527.3%       0.38 ±149%  perf-sched.sch_delay.max.ms.__cond_resched.dput.step_into.link_path_walk.part
     16.13 ±  5%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_bulk_noprof.mas_alloc_nodes.mas_preallocate.commit_merge
     19.33 ± 15%     -43.2%      10.99 ±  4%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.__split_vma
     18.16 ± 14%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.commit_merge
     21.41 ± 20%     -37.0%      13.48 ± 19%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.vms_gather_munmap_vmas
     19.61 ± 15%     -44.9%      10.81 ±  5%  perf-sched.sch_delay.max.ms.__cond_resched.remove_vma.vms_complete_munmap_vmas.do_vmi_align_munmap.__do_sys_brk
      3.82 ±  9%     -90.7%       0.35 ±135%  perf-sched.sch_delay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     17.52 ± 17%     -48.8%       8.96 ± 10%  perf-sched.sch_delay.max.ms.__cond_resched.unmap_page_range.unmap_vmas.vms_clear_ptes.vms_complete_munmap_vmas
     24.45 ± 14%     -43.7%      13.77 ± 14%  perf-sched.sch_delay.max.ms.__cond_resched.unmap_vmas.vms_clear_ptes.vms_complete_munmap_vmas.do_vmi_align_munmap
     20.72 ± 23%     -49.7%      10.42 ±  5%  perf-sched.sch_delay.max.ms.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
     16.93 ± 21%     -47.3%       8.93 ±  9%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
     13.48 ± 11%     -29.4%       9.52 ± 15%  perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      2.53 ±  5%     -44.1%       1.41 ±  5%  perf-sched.total_sch_delay.average.ms
     40.68 ±  2%     +22.6%      49.85 ±  2%  perf-sched.total_wait_and_delay.average.ms
     40407 ±  2%     -22.5%      31320 ±  2%  perf-sched.total_wait_and_delay.count.ms
     38.15 ±  2%     +27.0%      48.44 ±  2%  perf-sched.total_wait_time.average.ms
     10.71 ±  5%     -43.1%       6.10 ±  5%  perf-sched.wait_and_delay.avg.ms.__cond_resched.down_write.vma_expand.vma_merge_new_range.do_brk_flags
     10.79 ±  5%     -44.5%       5.98 ±  5%  perf-sched.wait_and_delay.avg.ms.__cond_resched.down_write_killable.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
     10.44 ±  7%     -42.2%       6.03 ±  6%  perf-sched.wait_and_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.__split_vma
     10.42 ± 12%     -42.6%       5.98 ±  5%  perf-sched.wait_and_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.vms_gather_munmap_vmas
     10.58 ±  7%     -43.3%       6.00 ±  6%  perf-sched.wait_and_delay.avg.ms.__cond_resched.remove_vma.vms_complete_munmap_vmas.do_vmi_align_munmap.__do_sys_brk
     10.88 ±  6%     -45.5%       5.93 ±  6%  perf-sched.wait_and_delay.avg.ms.__cond_resched.unmap_vmas.vms_clear_ptes.vms_complete_munmap_vmas.do_vmi_align_munmap
      8.65 ±  5%     -31.0%       5.97 ±  2%  perf-sched.wait_and_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      3.32 ±  2%     +11.8%       3.72        perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     57.28 ±  2%     +49.9%      85.84        perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     10.53 ±  5%     -43.9%       5.91 ±  8%  perf-sched.wait_and_delay.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    842.50 ±  4%     +27.8%       1076        perf-sched.wait_and_delay.count.__cond_resched.down_write.vma_expand.vma_merge_new_range.do_brk_flags
      1206 ±  4%     +42.3%       1716        perf-sched.wait_and_delay.count.__cond_resched.down_write_killable.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
    302.83 ±  5%     +69.4%     513.00 ±  5%  perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.__split_vma
    489.67 ±  5%     +61.7%     791.83 ±  4%  perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.vms_gather_munmap_vmas
    294.00 ±  9%     +54.0%     452.67 ±  4%  perf-sched.wait_and_delay.count.__cond_resched.remove_vma.vms_complete_munmap_vmas.do_vmi_align_munmap.__do_sys_brk
    428.00 ±  9%     -56.8%     184.83 ± 47%  perf-sched.wait_and_delay.count.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      6464 ±  2%     -55.5%       2877        perf-sched.wait_and_delay.count.__cond_resched.unmap_vmas.vms_clear_ptes.vms_complete_munmap_vmas.do_vmi_align_munmap
    106.83 ±100%    +203.9%     324.67 ±  6%  perf-sched.wait_and_delay.count.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
      2713 ±  3%     +26.0%       3418        perf-sched.wait_and_delay.count.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      1574 ±  2%     -13.8%       1356        perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     15305 ±  3%     -30.8%      10590        perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      6825 ±  3%     -40.7%       4048 ±  6%  perf-sched.wait_and_delay.count.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     44.53 ± 20%     -45.8%      24.13 ± 18%  perf-sched.wait_and_delay.max.ms.__cond_resched.down_write.vma_expand.vma_merge_new_range.do_brk_flags
     45.78 ± 13%     -48.3%      23.68 ± 11%  perf-sched.wait_and_delay.max.ms.__cond_resched.down_write_killable.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
     38.67 ± 15%     -43.2%      21.97 ±  4%  perf-sched.wait_and_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.__split_vma
     42.82 ± 20%     -37.0%      26.96 ± 19%  perf-sched.wait_and_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.vms_gather_munmap_vmas
     39.21 ± 15%     -44.9%      21.62 ±  5%  perf-sched.wait_and_delay.max.ms.__cond_resched.remove_vma.vms_complete_munmap_vmas.do_vmi_align_munmap.__do_sys_brk
     48.90 ± 14%     -43.7%      27.54 ± 14%  perf-sched.wait_and_delay.max.ms.__cond_resched.unmap_vmas.vms_clear_ptes.vms_complete_munmap_vmas.do_vmi_align_munmap
      5.32 ± 15%     -44.6%       2.95 ± 26%  perf-sched.wait_time.avg.ms.__cond_resched.__kmalloc_node_noprof.alloc_slab_obj_exts.allocate_slab.___slab_alloc
      5.54 ± 10%     -47.0%       2.93 ±  7%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.__split_vma.vms_gather_munmap_vmas.do_vmi_align_munmap
      5.36 ±  5%     -43.1%       3.05 ±  5%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.vma_expand.vma_merge_new_range.do_brk_flags
      5.39 ±  5%     -44.5%       2.99 ±  5%  perf-sched.wait_time.avg.ms.__cond_resched.down_write_killable.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.26 ± 25%     -31.6%       1.55 ± 43%  perf-sched.wait_time.avg.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
      5.19 ±  7%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_bulk_noprof.mas_alloc_nodes.mas_preallocate.commit_merge
      5.22 ±  7%     -42.2%       3.02 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.__split_vma
      5.27 ± 10%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.commit_merge
      5.21 ± 12%     -42.6%       2.99 ±  5%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.vms_gather_munmap_vmas
      5.29 ±  7%     -43.3%       3.00 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.remove_vma.vms_complete_munmap_vmas.do_vmi_align_munmap.__do_sys_brk
     28.14 ±  6%     +63.3%      45.96 ±  4%  perf-sched.wait_time.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      5.76 ± 24%     -45.0%       3.17 ± 17%  perf-sched.wait_time.avg.ms.__cond_resched.unmap_page_range.unmap_vmas.vms_clear_ptes.vms_complete_munmap_vmas
      5.44 ±  6%     -45.4%       2.97 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.unmap_vmas.vms_clear_ptes.vms_complete_munmap_vmas.do_vmi_align_munmap
      5.29 ± 10%     -43.1%       3.01 ±  5%  perf-sched.wait_time.avg.ms.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
      4.33 ±  5%     -31.0%       2.98 ±  2%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      3.14 ±  2%     +15.9%       3.64        perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     57.24 ±  2%     +49.9%      85.81        perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      5.80 ±  5%     -33.1%       3.88 ±  7%  perf-sched.wait_time.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     14.40 ± 18%     -47.0%       7.63 ± 13%  perf-sched.wait_time.max.ms.__cond_resched.__kmalloc_node_noprof.alloc_slab_obj_exts.allocate_slab.___slab_alloc
     18.01 ± 10%     -31.1%      12.41 ± 20%  perf-sched.wait_time.max.ms.__cond_resched.down_write.__split_vma.vms_gather_munmap_vmas.do_vmi_align_munmap
     22.27 ± 20%     -45.8%      12.07 ± 18%  perf-sched.wait_time.max.ms.__cond_resched.down_write.vma_expand.vma_merge_new_range.do_brk_flags
     22.89 ± 13%     -48.3%      11.84 ± 11%  perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1909 ±102%     -99.6%       8.32 ± 65%  perf-sched.wait_time.max.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
     16.13 ±  5%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_bulk_noprof.mas_alloc_nodes.mas_preallocate.commit_merge
     19.33 ± 15%     -43.2%      10.99 ±  4%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.__split_vma
     18.16 ± 14%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.commit_merge
     21.41 ± 20%     -37.0%      13.48 ± 19%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.vms_gather_munmap_vmas
     19.61 ± 15%     -44.9%      10.81 ±  5%  perf-sched.wait_time.max.ms.__cond_resched.remove_vma.vms_complete_munmap_vmas.do_vmi_align_munmap.__do_sys_brk
     17.52 ± 17%     -48.8%       8.96 ± 10%  perf-sched.wait_time.max.ms.__cond_resched.unmap_page_range.unmap_vmas.vms_clear_ptes.vms_complete_munmap_vmas
     24.45 ± 14%     -43.7%      13.77 ± 14%  perf-sched.wait_time.max.ms.__cond_resched.unmap_vmas.vms_clear_ptes.vms_complete_munmap_vmas.do_vmi_align_munmap
     20.72 ± 23%     -49.7%      10.42 ±  5%  perf-sched.wait_time.max.ms.__cond_resched.zap_pmd_range.isra.0.unmap_page_range
     16.93 ± 21%     -47.3%       8.93 ±  9%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown]
     20.08           -15.7        4.40        perf-profile.calltrace.cycles-pp.commit_merge.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
     20.50           -15.2        5.32        perf-profile.calltrace.cycles-pp.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk.do_syscall_64
     21.47           -14.8        6.71        perf-profile.calltrace.cycles-pp.vma_merge_new_range.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
     20.51           -13.0        7.51        perf-profile.calltrace.cycles-pp.mas_store_gfp.do_vmi_align_munmap.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
     20.47           -11.4        9.05 ±  4%  perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     20.45           -11.4        9.04 ±  4%  perf-profile.calltrace.cycles-pp.handle_softirqs.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork
     20.45           -11.4        9.04 ±  4%  perf-profile.calltrace.cycles-pp.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     20.44           -11.4        9.04 ±  4%  perf-profile.calltrace.cycles-pp.rcu_core.handle_softirqs.run_ksoftirqd.smpboot_thread_fn.kthread
     20.42           -11.4        9.02 ±  4%  perf-profile.calltrace.cycles-pp.rcu_do_batch.rcu_core.handle_softirqs.run_ksoftirqd.smpboot_thread_fn
     20.48           -11.4        9.08 ±  4%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
     20.48           -11.4        9.08 ±  4%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
     20.48           -11.4        9.08 ±  4%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
     13.22           -11.4        1.86        perf-profile.calltrace.cycles-pp.mas_store_prealloc.commit_merge.vma_expand.vma_merge_new_range.do_brk_flags
     18.05           -11.0        7.01 ±  5%  perf-profile.calltrace.cycles-pp.kmem_cache_free.rcu_do_batch.rcu_core.handle_softirqs.run_ksoftirqd
     13.34 ±  2%     -11.0        2.30 ± 10%  perf-profile.calltrace.cycles-pp.__slab_free.kmem_cache_free.rcu_do_batch.rcu_core.handle_softirqs
     25.73           -10.8       14.98        perf-profile.calltrace.cycles-pp.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
     10.38           -10.4        0.00        perf-profile.calltrace.cycles-pp.mas_wr_spanning_store.mas_store_gfp.do_vmi_align_munmap.__do_sys_brk.do_syscall_64
     10.16           -10.2        0.00        perf-profile.calltrace.cycles-pp.mas_wr_spanning_store.mas_store_prealloc.commit_merge.vma_expand.vma_merge_new_range
      8.85            -8.9        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__slab_free.kmem_cache_free.rcu_do_batch
      9.01            -8.5        0.52 ±  3%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__slab_free.kmem_cache_free.rcu_do_batch.rcu_core
      7.55            -7.6        0.00        perf-profile.calltrace.cycles-pp.mas_spanning_rebalance.mas_wr_spanning_store.mas_store_gfp.do_vmi_align_munmap.__do_sys_brk
      7.47            -7.5        0.00        perf-profile.calltrace.cycles-pp.mas_spanning_rebalance.mas_wr_spanning_store.mas_store_prealloc.commit_merge.vma_expand
      6.36 ±  2%      -6.4        0.00        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_bulk_noprof.mas_alloc_nodes.mas_store_gfp.do_vmi_align_munmap.__do_sys_brk
      6.24 ±  2%      -6.2        0.00        perf-profile.calltrace.cycles-pp.__kmem_cache_alloc_bulk.kmem_cache_alloc_bulk_noprof.mas_alloc_nodes.mas_store_gfp.do_vmi_align_munmap
      6.03 ±  4%      -6.0        0.00        perf-profile.calltrace.cycles-pp.get_partial_node.___slab_alloc.__kmem_cache_alloc_bulk.kmem_cache_alloc_bulk_noprof.mas_alloc_nodes
      5.70 ±  3%      -5.7        0.00        perf-profile.calltrace.cycles-pp.mas_alloc_nodes.mas_preallocate.commit_merge.vma_expand.vma_merge_new_range
      5.63 ±  3%      -5.6        0.00        perf-profile.calltrace.cycles-pp.___slab_alloc.__kmem_cache_alloc_bulk.kmem_cache_alloc_bulk_noprof.mas_alloc_nodes.mas_store_gfp
      6.86 ±  2%      -5.4        1.41        perf-profile.calltrace.cycles-pp.mas_alloc_nodes.mas_store_gfp.do_vmi_align_munmap.__do_sys_brk.do_syscall_64
      5.21 ±  3%      -5.2        0.00        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_bulk_noprof.mas_alloc_nodes.mas_preallocate.commit_merge.vma_expand
      6.18 ±  2%      -5.1        1.08        perf-profile.calltrace.cycles-pp.mas_preallocate.commit_merge.vma_expand.vma_merge_new_range.do_brk_flags
     65.17            -3.8       61.41        perf-profile.calltrace.cycles-pp.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
     66.54            -2.5       64.09        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
      3.40 ±  2%      -0.8        2.62 ±  2%  perf-profile.calltrace.cycles-pp.rcu_do_batch.rcu_core.handle_softirqs.__irq_exit_rcu.sysvec_apic_timer_interrupt
      3.41 ±  2%      -0.8        2.63 ±  2%  perf-profile.calltrace.cycles-pp.rcu_core.handle_softirqs.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      2.62 ±  8%      -0.8        1.86        perf-profile.calltrace.cycles-pp.kmem_cache_free.rcu_do_batch.rcu_core.handle_softirqs.__irq_exit_rcu
      1.14 ±  2%      -0.4        0.72 ±  3%  perf-profile.calltrace.cycles-pp.rcu_cblist_dequeue.rcu_do_batch.rcu_core.handle_softirqs.run_ksoftirqd
      0.73            +0.1        0.79        perf-profile.calltrace.cycles-pp.mas_prev_slot.vms_gather_munmap_vmas.do_vmi_align_munmap.__do_sys_brk.do_syscall_64
      0.62            +0.1        0.70        perf-profile.calltrace.cycles-pp.mas_next_slot.mas_find.vms_gather_munmap_vmas.do_vmi_align_munmap.__do_sys_brk
      0.65            +0.2        0.82 ±  2%  perf-profile.calltrace.cycles-pp.kmem_cache_free.vm_area_free_rcu_cb.rcu_do_batch.rcu_core.handle_softirqs
      0.94            +0.2        1.12 ±  3%  perf-profile.calltrace.cycles-pp.vm_area_free_rcu_cb.rcu_do_batch.rcu_core.handle_softirqs.run_ksoftirqd
      0.78            +0.3        1.06        perf-profile.calltrace.cycles-pp.mas_find.vms_gather_munmap_vmas.do_vmi_align_munmap.__do_sys_brk.do_syscall_64
      0.53 ±  4%      +0.4        0.97 ±  2%  perf-profile.calltrace.cycles-pp.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.53 ±  4%      +0.4        0.97 ±  2%  perf-profile.calltrace.cycles-pp.handle_softirqs.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.do_syscall_64
      0.55 ±  4%      +0.5        1.01 ±  2%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
      0.55 ±  4%      +0.5        1.02 ±  2%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
      0.00            +0.5        0.52        perf-profile.calltrace.cycles-pp.mas_pop_node.mas_wr_node_store.mas_store_gfp.do_vmi_align_munmap.__do_sys_brk
      0.56            +0.5        1.07        perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.vms_clear_ptes
      0.00            +0.5        0.52        perf-profile.calltrace.cycles-pp.mas_leaf_max_gap.mas_update_gap.mas_store_prealloc.commit_merge.vma_expand
      4.13            +0.5        4.66 ±  4%  perf-profile.calltrace.cycles-pp.__put_partials.kmem_cache_free.rcu_do_batch.rcu_core.handle_softirqs
      0.00            +0.5        0.54        perf-profile.calltrace.cycles-pp.mas_wr_store_type.mas_preallocate.__split_vma.vms_gather_munmap_vmas.do_vmi_align_munmap
      0.00            +0.5        0.54        perf-profile.calltrace.cycles-pp.mas_update_gap.mas_wr_node_store.mas_store_gfp.do_vmi_align_munmap.__do_sys_brk
      0.00            +0.6        0.55        perf-profile.calltrace.cycles-pp.__pte_offset_map_lock.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
      0.00            +0.6        0.56 ±  2%  perf-profile.calltrace.cycles-pp.obj_cgroup_charge.__memcg_slab_post_alloc_hook.kmem_cache_alloc_noprof.vm_area_dup.__split_vma
      0.55            +0.6        1.12        perf-profile.calltrace.cycles-pp.__get_unmapped_area.check_brk_limits.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.6        0.58        perf-profile.calltrace.cycles-pp.mas_pop_node.mas_wr_node_store.mas_store_prealloc.vma_complete.__split_vma
      0.00            +0.6        0.59        perf-profile.calltrace.cycles-pp.mas_wr_store_type.mas_preallocate.commit_merge.vma_expand.vma_merge_new_range
      0.00            +0.6        0.59        perf-profile.calltrace.cycles-pp.mas_update_gap.mas_wr_node_store.mas_store_prealloc.vma_complete.__split_vma
      0.00            +0.6        0.63        perf-profile.calltrace.cycles-pp.__call_rcu_common.mas_wr_node_store.mas_store_gfp.do_vmi_align_munmap.__do_sys_brk
      0.00            +0.7        0.65        perf-profile.calltrace.cycles-pp.thp_get_unmapped_area_vmflags.__get_unmapped_area.check_brk_limits.__do_sys_brk.do_syscall_64
      0.00            +0.7        0.67 ±  2%  perf-profile.calltrace.cycles-pp.down_write.__split_vma.vms_gather_munmap_vmas.do_vmi_align_munmap.__do_sys_brk
      0.00            +0.7        0.67        perf-profile.calltrace.cycles-pp.down_write_killable.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
      0.00            +0.7        0.68        perf-profile.calltrace.cycles-pp.allocate_slab.___slab_alloc.kmem_cache_alloc_noprof.vm_area_dup.__split_vma
      0.00            +0.7        0.68        perf-profile.calltrace.cycles-pp.__call_rcu_common.vms_complete_munmap_vmas.do_vmi_align_munmap.__do_sys_brk.do_syscall_64
      0.66            +0.7        1.36        perf-profile.calltrace.cycles-pp.check_brk_limits.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
      0.00            +0.7        0.70        perf-profile.calltrace.cycles-pp.__call_rcu_common.mas_wr_node_store.mas_store_prealloc.vma_complete.__split_vma
      0.00            +0.7        0.72        perf-profile.calltrace.cycles-pp.___slab_alloc.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.__split_vma
      0.94 ±  2%      +0.7        1.67 ±  2%  perf-profile.calltrace.cycles-pp.handle_softirqs.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.brk
      0.94 ±  2%      +0.7        1.67 ±  2%  perf-profile.calltrace.cycles-pp.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.brk
      0.00            +0.7        0.74        perf-profile.calltrace.cycles-pp.mas_wr_store_type.mas_store_gfp.do_vmi_align_munmap.__do_sys_brk.do_syscall_64
      0.00            +0.7        0.74        perf-profile.calltrace.cycles-pp.___slab_alloc.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_store_gfp.do_vmi_align_munmap
      0.00            +0.7        0.75        perf-profile.calltrace.cycles-pp.mas_update_gap.mas_store_prealloc.commit_merge.vma_expand.vma_merge_new_range
      0.98 ±  2%      +0.8        1.74 ±  2%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.brk
      0.98 ±  2%      +0.8        1.75 ±  2%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.brk
      0.73            +0.8        1.50        perf-profile.calltrace.cycles-pp.free_pgtables.vms_clear_ptes.vms_complete_munmap_vmas.do_vmi_align_munmap.__do_sys_brk
      0.79            +0.8        1.56        perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.vms_clear_ptes.vms_complete_munmap_vmas
      0.00            +0.8        0.78        perf-profile.calltrace.cycles-pp.userfaultfd_unmap_complete.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
      0.25 ±100%      +0.8        1.05        perf-profile.calltrace.cycles-pp.mas_store_gfp.vms_gather_munmap_vmas.do_vmi_align_munmap.__do_sys_brk.do_syscall_64
      0.00            +0.9        0.92        perf-profile.calltrace.cycles-pp.___slab_alloc.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.vms_gather_munmap_vmas
      0.64            +0.9        1.58        perf-profile.calltrace.cycles-pp.mas_walk.mas_find.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.1        1.06        perf-profile.calltrace.cycles-pp.security_vm_enough_memory_mm.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.2        1.17        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_store_gfp.do_vmi_align_munmap.__do_sys_brk
      0.89            +1.2        2.11        perf-profile.calltrace.cycles-pp.mas_find.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
      1.10            +1.2        2.34        perf-profile.calltrace.cycles-pp.__memcg_slab_post_alloc_hook.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.vms_gather_munmap_vmas
      1.00            +1.3        2.26        perf-profile.calltrace.cycles-pp.perf_event_mmap_output.perf_iterate_sb.perf_event_mmap_event.perf_event_mmap.do_brk_flags
      0.00            +1.3        1.34        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.__split_vma.vms_gather_munmap_vmas
      1.30            +1.3        2.64        perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.vms_clear_ptes.vms_complete_munmap_vmas.do_vmi_align_munmap
      1.38            +1.6        2.93        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.brk
      0.00            +1.6        1.59        perf-profile.calltrace.cycles-pp.mas_alloc_nodes.mas_preallocate.__split_vma.vms_gather_munmap_vmas.do_vmi_align_munmap
      1.68            +1.7        3.40        perf-profile.calltrace.cycles-pp.unmap_vmas.vms_clear_ptes.vms_complete_munmap_vmas.do_vmi_align_munmap.__do_sys_brk
      0.95            +1.8        2.76        perf-profile.calltrace.cycles-pp.mas_preallocate.__split_vma.vms_gather_munmap_vmas.do_vmi_align_munmap.__do_sys_brk
      1.45            +1.9        3.30        perf-profile.calltrace.cycles-pp.perf_iterate_sb.perf_event_mmap_event.perf_event_mmap.do_brk_flags.__do_sys_brk
      0.00            +1.9        1.87        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_safe_stack.brk
      1.78            +2.3        4.06        perf-profile.calltrace.cycles-pp.mas_wr_node_store.mas_store_prealloc.vma_complete.__split_vma.vms_gather_munmap_vmas
      2.15            +2.5        4.62        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.vms_gather_munmap_vmas.do_vmi_align_munmap
      2.30            +2.6        4.94        perf-profile.calltrace.cycles-pp.perf_event_mmap_event.perf_event_mmap.do_brk_flags.__do_sys_brk.do_syscall_64
      2.18            +2.8        4.97        perf-profile.calltrace.cycles-pp.mas_store_prealloc.vma_complete.__split_vma.vms_gather_munmap_vmas.do_vmi_align_munmap
      2.51            +2.8        5.35        perf-profile.calltrace.cycles-pp.vm_area_dup.__split_vma.vms_gather_munmap_vmas.do_vmi_align_munmap.__do_sys_brk
      2.36            +2.9        5.26        perf-profile.calltrace.cycles-pp.vma_complete.__split_vma.vms_gather_munmap_vmas.do_vmi_align_munmap.__do_sys_brk
      0.88 ± 26%      +2.9        3.80 ±  6%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.free_pcppages_bulk.free_unref_page_commit.free_unref_page
      2.60            +3.0        5.56        perf-profile.calltrace.cycles-pp.perf_event_mmap.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.84 ±  7%      +3.0        3.84 ±  6%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.free_pcppages_bulk.free_unref_page_commit.free_unref_page.__put_partials
      0.93 ±  7%      +3.0        3.94 ±  6%  perf-profile.calltrace.cycles-pp.free_pcppages_bulk.free_unref_page_commit.free_unref_page.__put_partials.kmem_cache_free
      0.98 ±  7%      +3.0        4.00 ±  6%  perf-profile.calltrace.cycles-pp.free_unref_page.__put_partials.kmem_cache_free.rcu_do_batch.rcu_core
      0.95 ±  7%      +3.0        3.98 ±  6%  perf-profile.calltrace.cycles-pp.free_unref_page_commit.free_unref_page.__put_partials.kmem_cache_free.rcu_do_batch
     35.50            +3.2       38.74        perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
      3.10            +3.3        6.37        perf-profile.calltrace.cycles-pp.vms_clear_ptes.vms_complete_munmap_vmas.do_vmi_align_munmap.__do_sys_brk.do_syscall_64
      3.07            +3.4        6.44        perf-profile.calltrace.cycles-pp.entry_SYSRETQ_unsafe_stack.brk
      0.00            +4.3        4.26        perf-profile.calltrace.cycles-pp.mas_wr_node_store.mas_store_gfp.do_vmi_align_munmap.__do_sys_brk.do_syscall_64
      3.77            +4.4        8.21        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.brk
      4.26            +4.5        8.79        perf-profile.calltrace.cycles-pp.vms_complete_munmap_vmas.do_vmi_align_munmap.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.32            +9.2       16.52        perf-profile.calltrace.cycles-pp.__split_vma.vms_gather_munmap_vmas.do_vmi_align_munmap.__do_sys_brk.do_syscall_64
     10.24           +11.1       21.32        perf-profile.calltrace.cycles-pp.vms_gather_munmap_vmas.do_vmi_align_munmap.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
     78.70           +11.1       89.81        perf-profile.calltrace.cycles-pp.brk
     20.58           -20.6        0.00        perf-profile.children.cycles-pp.mas_wr_spanning_store
     26.93           -19.3        7.67 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     26.44           -19.0        7.40 ±  3%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     30.76           -15.9       14.88        perf-profile.children.cycles-pp.kmem_cache_free
     20.12           -15.6        4.47        perf-profile.children.cycles-pp.commit_merge
     20.51           -15.2        5.33        perf-profile.children.cycles-pp.vma_expand
     15.12           -15.1        0.00        perf-profile.children.cycles-pp.mas_spanning_rebalance
     21.50           -14.7        6.79        perf-profile.children.cycles-pp.vma_merge_new_range
     31.13           -13.5       17.58        perf-profile.children.cycles-pp.handle_softirqs
     31.11           -13.5       17.57        perf-profile.children.cycles-pp.rcu_core
     31.10           -13.5       17.55        perf-profile.children.cycles-pp.rcu_do_batch
     19.14           -13.5        5.64        perf-profile.children.cycles-pp.__slab_free
     21.09           -12.3        8.74        perf-profile.children.cycles-pp.mas_store_gfp
     11.59 ±  3%     -11.6        0.00        perf-profile.children.cycles-pp.kmem_cache_alloc_bulk_noprof
     20.47           -11.4        9.05 ±  4%  perf-profile.children.cycles-pp.smpboot_thread_fn
     20.45           -11.4        9.04 ±  4%  perf-profile.children.cycles-pp.run_ksoftirqd
     20.48           -11.4        9.08 ±  4%  perf-profile.children.cycles-pp.kthread
     20.48           -11.4        9.08 ±  4%  perf-profile.children.cycles-pp.ret_from_fork
     20.48           -11.4        9.08 ±  4%  perf-profile.children.cycles-pp.ret_from_fork_asm
     11.26 ±  3%     -11.3        0.00        perf-profile.children.cycles-pp.__kmem_cache_alloc_bulk
     25.78           -10.7       15.07        perf-profile.children.cycles-pp.do_brk_flags
     12.99 ±  2%     -10.0        3.02        perf-profile.children.cycles-pp.mas_alloc_nodes
     15.43            -8.6        6.87        perf-profile.children.cycles-pp.mas_store_prealloc
     10.69 ±  3%      -8.3        2.40        perf-profile.children.cycles-pp.___slab_alloc
      7.70 ±  4%      -7.5        0.19 ±  4%  perf-profile.children.cycles-pp.get_partial_node
      5.56            -5.2        0.40        perf-profile.children.cycles-pp.mas_destroy
     65.21            -3.7       61.50        perf-profile.children.cycles-pp.__do_sys_brk
      7.16 ±  2%      -3.3        3.88        perf-profile.children.cycles-pp.mas_preallocate
      9.40            -2.6        6.78 ±  3%  perf-profile.children.cycles-pp.__put_partials
     66.62            -2.4       64.21        perf-profile.children.cycles-pp.do_syscall_64
     10.69            -2.1        8.56 ±  2%  perf-profile.children.cycles-pp.__irq_exit_rcu
     11.09            -2.1        8.99 ±  2%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
     11.12            -2.1        9.03 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      1.76 ±  6%      -1.6        0.16 ±  3%  perf-profile.children.cycles-pp.get_any_partial
      2.19            -1.1        1.10        perf-profile.children.cycles-pp.mas_pop_node
      1.09            -0.9        0.20        perf-profile.children.cycles-pp.memcpy_orig
      1.68            -0.3        1.34        perf-profile.children.cycles-pp.mas_prev_slot
      1.78            -0.2        1.62 ±  2%  perf-profile.children.cycles-pp.rcu_cblist_dequeue
      0.46            -0.1        0.36        perf-profile.children.cycles-pp.alloc_pages_mpol_noprof
      0.43 ±  2%      -0.1        0.34 ±  2%  perf-profile.children.cycles-pp.__alloc_pages_noprof
      0.38 ±  2%      -0.1        0.30        perf-profile.children.cycles-pp.get_page_from_freelist
      0.54            -0.1        0.47        perf-profile.children.cycles-pp.rcu_segcblist_enqueue
      0.12 ±  4%      -0.1        0.06        perf-profile.children.cycles-pp.__memcpy
      0.22 ±  3%      -0.0        0.18 ±  3%  perf-profile.children.cycles-pp.rmqueue
      0.17 ±  2%      -0.0        0.13 ±  2%  perf-profile.children.cycles-pp.__rmqueue_pcplist
      0.27            -0.0        0.23 ±  4%  perf-profile.children.cycles-pp.mt_free_rcu
      0.14 ±  3%      -0.0        0.11        perf-profile.children.cycles-pp.rmqueue_bulk
      0.16 ±  3%      -0.0        0.13 ±  3%  perf-profile.children.cycles-pp.discard_slab
      0.08 ±  4%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.__get_random_u32_below
      0.07            -0.0        0.06        perf-profile.children.cycles-pp.get_random_u32
      0.05            +0.0        0.06        perf-profile.children.cycles-pp.call_rcu
      0.15 ±  2%      +0.0        0.16 ±  2%  perf-profile.children.cycles-pp.sched_tick
      0.06 ±  8%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.can_vma_merge_right
      0.05 ± 45%      +0.0        0.08 ±  8%  perf-profile.children.cycles-pp.tmigr_requires_handle_remote
      0.14 ±  3%      +0.0        0.17 ±  2%  perf-profile.children.cycles-pp.strnlen
      0.27 ±  7%      +0.0        0.30 ±  2%  perf-profile.children.cycles-pp.update_process_times
      0.05            +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.unlink_file_vma_batch_add
      0.06 ±  8%      +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.vma_dup_policy
      0.06            +0.0        0.10 ±  5%  perf-profile.children.cycles-pp.mm_get_unmapped_area_vmflags
      0.02 ±141%      +0.0        0.06 ±  8%  perf-profile.children.cycles-pp.queued_spin_unlock
      0.07 ±  7%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.unlink_file_vma_batch_final
      0.36 ±  4%      +0.0        0.40        perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.30 ±  8%      +0.0        0.34 ±  2%  perf-profile.children.cycles-pp.tick_nohz_handler
      0.41 ±  3%      +0.0        0.46        perf-profile.children.cycles-pp.hrtimer_interrupt
      0.41 ±  3%      +0.0        0.46        perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.18 ±  2%      +0.0        0.23 ±  2%  perf-profile.children.cycles-pp.x64_sys_call
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.__mod_memcg_state
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.arch_vma_name
      0.06 ±  6%      +0.1        0.11 ±  3%  perf-profile.children.cycles-pp.mas_nomem
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.memset_orig
      0.12 ±  3%      +0.1        0.18        perf-profile.children.cycles-pp.mas_next_range
      0.09 ±  4%      +0.1        0.15        perf-profile.children.cycles-pp.unmap_single_vma
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.flush_tlb_batched_pending
      0.02 ± 99%      +0.1        0.09 ±  4%  perf-profile.children.cycles-pp.may_expand_vm
      0.07            +0.1        0.13 ±  3%  perf-profile.children.cycles-pp.userfaultfd_unmap_prep
      0.00            +0.1        0.07        perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.12 ±  3%      +0.1        0.20 ±  2%  perf-profile.children.cycles-pp.anon_vma_clone
      0.00            +0.1        0.07 ±  5%  perf-profile.children.cycles-pp.__x64_sys_brk
      0.02 ± 99%      +0.1        0.10 ±  4%  perf-profile.children.cycles-pp.alloc_slab_obj_exts
      0.09 ±  4%      +0.1        0.16 ±  2%  perf-profile.children.cycles-pp.vma_prepare
      0.07 ±  5%      +0.1        0.14 ±  2%  perf-profile.children.cycles-pp.unlink_anon_vmas
      0.10            +0.1        0.18 ±  2%  perf-profile.children.cycles-pp.free_pgd_range
      0.10 ±  3%      +0.1        0.18 ±  3%  perf-profile.children.cycles-pp.mas_node_count_gfp
      0.06 ±  7%      +0.1        0.15 ±  2%  perf-profile.children.cycles-pp.__pte_offset_map
      0.43            +0.1        0.52 ±  2%  perf-profile.children.cycles-pp.setup_object
      0.07 ±  6%      +0.1        0.16 ±  2%  perf-profile.children.cycles-pp.up_read
      0.12 ±  4%      +0.1        0.21 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock
      0.05 ±  8%      +0.1        0.14 ±  3%  perf-profile.children.cycles-pp.cap_mmap_addr
      0.00            +0.1        0.09 ±  5%  perf-profile.children.cycles-pp.__kmalloc_node_noprof
      0.10 ±  4%      +0.1        0.20        perf-profile.children.cycles-pp.can_vma_merge_after
      0.16 ±  2%      +0.1        0.26 ±  2%  perf-profile.children.cycles-pp.strlen
      0.08            +0.1        0.18 ±  2%  perf-profile.children.cycles-pp.refill_obj_stock
      0.11 ±  5%      +0.1        0.22 ±  2%  perf-profile.children.cycles-pp.khugepaged_enter_vma
      1.36            +0.1        1.46        perf-profile.children.cycles-pp.mas_next_slot
      0.09 ±  4%      +0.1        0.20 ±  3%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.10 ±  4%      +0.1        0.22        perf-profile.children.cycles-pp.mas_prev_setup
      0.11            +0.1        0.23        perf-profile.children.cycles-pp.downgrade_write
      0.18 ±  2%      +0.1        0.31        perf-profile.children.cycles-pp.__vm_enough_memory
      0.09 ±  5%      +0.1        0.23 ±  3%  perf-profile.children.cycles-pp.kfree
      0.09 ±  4%      +0.1        0.23        perf-profile.children.cycles-pp.security_mmap_addr
      0.12            +0.1        0.26 ±  2%  perf-profile.children.cycles-pp.tlb_gather_mmu
      0.14 ±  3%      +0.2        0.29        perf-profile.children.cycles-pp.lru_add_drain_cpu
      0.17 ±  2%      +0.2        0.32        perf-profile.children.cycles-pp.remove_vma
      0.16 ±  3%      +0.2        0.32 ±  2%  perf-profile.children.cycles-pp.vma_adjust_trans_huge
      0.15 ±  3%      +0.2        0.31        perf-profile.children.cycles-pp.lru_add_drain
      0.16 ±  2%      +0.2        0.33        perf-profile.children.cycles-pp.tlb_finish_mmu
      0.18 ±  2%      +0.2        0.34 ±  3%  perf-profile.children.cycles-pp.cap_vm_enough_memory
      0.16 ±  2%      +0.2        0.34        perf-profile.children.cycles-pp.sized_strscpy
      0.14 ±  3%      +0.2        0.33 ±  2%  perf-profile.children.cycles-pp.static_key_count
      0.00            +0.2        0.19        perf-profile.children.cycles-pp.mas_wr_slot_store
      0.18 ±  2%      +0.2        0.38        perf-profile.children.cycles-pp.arch_get_unmapped_area_topdown
      0.20            +0.2        0.40 ±  2%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.22            +0.2        0.46        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.25 ±  3%      +0.3        0.51        perf-profile.children.cycles-pp.rcu_all_qs
      0.30 ±  2%      +0.3        0.56        perf-profile.children.cycles-pp.__pte_offset_map_lock
      0.16 ±  2%      +0.3        0.42        perf-profile.children.cycles-pp.mas_prev_range
      0.25 ±  2%      +0.3        0.52        perf-profile.children.cycles-pp.mas_wr_store_entry
      0.07            +0.3        0.35        perf-profile.children.cycles-pp.mas_put_in_tree
      0.28 ±  2%      +0.3        0.58 ±  2%  perf-profile.children.cycles-pp.obj_cgroup_charge
      0.32            +0.3        0.62        perf-profile.children.cycles-pp.mas_prev
      0.25            +0.3        0.57        perf-profile.children.cycles-pp.init_multi_vma_prep
      0.35            +0.3        0.68        perf-profile.children.cycles-pp.thp_get_unmapped_area_vmflags
      0.30 ±  2%      +0.4        0.70        perf-profile.children.cycles-pp.down_write_killable
      0.36            +0.4        0.76        perf-profile.children.cycles-pp.mod_objcg_state
      0.36            +0.4        0.78        perf-profile.children.cycles-pp.userfaultfd_unmap_complete
      0.38            +0.5        0.84        perf-profile.children.cycles-pp.up_write
      0.57            +0.5        1.10        perf-profile.children.cycles-pp.zap_pte_range
      0.57            +0.6        1.17        perf-profile.children.cycles-pp.__get_unmapped_area
      0.43            +0.6        1.04 ±  2%  perf-profile.children.cycles-pp.down_write
      0.45            +0.6        1.06        perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.69            +0.6        1.30        perf-profile.children.cycles-pp.mas_leaf_max_gap
      0.52            +0.6        1.14        perf-profile.children.cycles-pp.security_vm_enough_memory_mm
      0.66 ±  2%      +0.7        1.33        perf-profile.children.cycles-pp.__memcg_slab_free_hook
      0.67            +0.7        1.36        perf-profile.children.cycles-pp.check_brk_limits
      0.80 ±  2%      +0.8        1.55        perf-profile.children.cycles-pp.__cond_resched
      0.82            +0.8        1.62        perf-profile.children.cycles-pp.zap_pmd_range
      0.80            +0.8        1.65        perf-profile.children.cycles-pp.free_pgtables
      1.46            +1.0        2.51        perf-profile.children.cycles-pp.vm_area_free_rcu_cb
      0.81            +1.2        1.97        perf-profile.children.cycles-pp.mas_walk
      1.12            +1.3        2.38        perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
      1.01            +1.3        2.28        perf-profile.children.cycles-pp.perf_event_mmap_output
      1.32            +1.4        2.69        perf-profile.children.cycles-pp.unmap_page_range
      0.53            +1.4        1.93        perf-profile.children.cycles-pp.mas_wr_store_type
      0.27            +1.6        1.92        perf-profile.children.cycles-pp.mas_update_gap
      1.69            +1.7        3.42        perf-profile.children.cycles-pp.unmap_vmas
      1.46            +1.9        3.32        perf-profile.children.cycles-pp.perf_iterate_sb
      1.72            +2.0        3.75        perf-profile.children.cycles-pp.entry_SYSCALL_64
      2.38            +2.3        4.65        perf-profile.children.cycles-pp.mas_find
      2.34            +2.7        5.03        perf-profile.children.cycles-pp.perf_event_mmap_event
      2.52            +2.9        5.37        perf-profile.children.cycles-pp.vm_area_dup
      2.61            +3.0        5.58        perf-profile.children.cycles-pp.perf_event_mmap
      2.46            +3.0        5.47        perf-profile.children.cycles-pp.vma_complete
     35.52            +3.3       38.77        perf-profile.children.cycles-pp.do_vmi_align_munmap
      3.12            +3.3        6.42        perf-profile.children.cycles-pp.vms_clear_ptes
      3.29            +3.6        6.88        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      2.11 ±  6%      +4.0        6.11 ±  4%  perf-profile.children.cycles-pp.free_pcppages_bulk
      2.22 ±  6%      +4.0        6.24 ±  4%  perf-profile.children.cycles-pp.free_unref_page
      2.16 ±  6%      +4.0        6.18 ±  4%  perf-profile.children.cycles-pp.free_unref_page_commit
      3.16            +4.0        7.20        perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
      3.80            +4.5        8.28        perf-profile.children.cycles-pp.syscall_return_via_sysret
      4.28            +4.6        8.83        perf-profile.children.cycles-pp.vms_complete_munmap_vmas
      1.80            +6.6        8.42        perf-profile.children.cycles-pp.mas_wr_node_store
      7.40            +9.3       16.69        perf-profile.children.cycles-pp.__split_vma
     10.27           +11.1       21.42        perf-profile.children.cycles-pp.vms_gather_munmap_vmas
     78.92           +11.3       90.27        perf-profile.children.cycles-pp.brk
     26.44           -19.0        7.40 ±  3%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      6.00            -1.7        4.30 ±  2%  perf-profile.self.cycles-pp.__slab_free
      1.92            -1.0        0.97        perf-profile.self.cycles-pp.mas_pop_node
      2.01            -0.9        1.09        perf-profile.self.cycles-pp.kmem_cache_free
      0.93 ±  2%      -0.8        0.17 ±  2%  perf-profile.self.cycles-pp.memcpy_orig
      1.08            -0.6        0.52        perf-profile.self.cycles-pp.___slab_alloc
      0.48            -0.2        0.28        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.25 ±  5%      -0.2        0.05 ±  8%  perf-profile.self.cycles-pp.get_partial_node
      1.75            -0.2        1.60 ±  3%  perf-profile.self.cycles-pp.rcu_cblist_dequeue
      0.70            -0.1        0.61        perf-profile.self.cycles-pp.shuffle_freelist
      0.53            -0.1        0.47        perf-profile.self.cycles-pp.rcu_segcblist_enqueue
      0.18 ±  2%      -0.0        0.13        perf-profile.self.cycles-pp.get_any_partial
      0.26            -0.0        0.23 ±  4%  perf-profile.self.cycles-pp.mt_free_rcu
      0.17 ±  4%      -0.0        0.14 ±  3%  perf-profile.self.cycles-pp.__free_one_page
      0.16 ±  3%      -0.0        0.13 ±  2%  perf-profile.self.cycles-pp.discard_slab
      0.07 ±  7%      -0.0        0.05        perf-profile.self.cycles-pp.get_page_from_freelist
      0.09 ±  5%      -0.0        0.08        perf-profile.self.cycles-pp.rmqueue_bulk
      0.05            +0.0        0.06        perf-profile.self.cycles-pp.can_vma_merge_right
      0.06 ±  7%      +0.0        0.08        perf-profile.self.cycles-pp.__vm_enough_memory
      0.13 ±  3%      +0.0        0.15 ±  2%  perf-profile.self.cycles-pp.strnlen
      0.05            +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.mm_get_unmapped_area_vmflags
      0.16            +0.0        0.20        perf-profile.self.cycles-pp.x64_sys_call
      0.09            +0.0        0.13        perf-profile.self.cycles-pp.anon_vma_clone
      0.25            +0.0        0.29 ±  2%  perf-profile.self.cycles-pp.mas_destroy
      0.07 ±  7%      +0.0        0.11        perf-profile.self.cycles-pp.vma_prepare
      0.06 ±  8%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.mas_next_range
      0.08            +0.1        0.13        perf-profile.self.cycles-pp.unmap_single_vma
      0.06            +0.1        0.11        perf-profile.self.cycles-pp.userfaultfd_unmap_prep
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.free_unref_page_commit
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.memset_orig
      0.00            +0.1        0.05 ±  7%  perf-profile.self.cycles-pp.flush_tlb_batched_pending
      0.00            +0.1        0.05 ±  7%  perf-profile.self.cycles-pp.vma_dup_policy
      0.00            +0.1        0.06 ±  8%  perf-profile.self.cycles-pp.mas_nomem
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.06 ±  7%      +0.1        0.12 ±  4%  perf-profile.self.cycles-pp.mas_node_count_gfp
      0.09 ±  4%      +0.1        0.15 ±  3%  perf-profile.self.cycles-pp.remove_vma
      0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.unlink_file_vma_batch_final
      0.08 ±  5%      +0.1        0.15        perf-profile.self.cycles-pp.free_pgd_range
      0.38            +0.1        0.45        perf-profile.self.cycles-pp.mas_alloc_nodes
      0.08 ±  6%      +0.1        0.15 ±  3%  perf-profile.self.cycles-pp.khugepaged_enter_vma
      0.00            +0.1        0.07 ±  5%  perf-profile.self.cycles-pp.security_mmap_addr
      0.06 ±  6%      +0.1        0.14 ±  3%  perf-profile.self.cycles-pp.up_read
      0.05 ±  8%      +0.1        0.13        perf-profile.self.cycles-pp.__pte_offset_map
      0.00            +0.1        0.08 ±  6%  perf-profile.self.cycles-pp.may_expand_vm
      0.10 ±  4%      +0.1        0.18 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock
      0.09            +0.1        0.17        perf-profile.self.cycles-pp.can_vma_merge_after
      0.01 ±223%      +0.1        0.09        perf-profile.self.cycles-pp.unlink_anon_vmas
      0.09 ±  4%      +0.1        0.18 ±  2%  perf-profile.self.cycles-pp.thp_get_unmapped_area_vmflags
      0.12 ±  4%      +0.1        0.20        perf-profile.self.cycles-pp.__pte_offset_map_lock
      0.08 ±  5%      +0.1        0.17 ±  4%  perf-profile.self.cycles-pp.check_brk_limits
      0.14 ±  2%      +0.1        0.23        perf-profile.self.cycles-pp.strlen
      0.08 ±  4%      +0.1        0.17 ±  4%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.08            +0.1        0.18 ±  2%  perf-profile.self.cycles-pp.mas_prev_setup
      0.07 ±  5%      +0.1        0.17 ±  2%  perf-profile.self.cycles-pp.kfree
      0.08 ±  6%      +0.1        0.18        perf-profile.self.cycles-pp.refill_obj_stock
      0.10 ±  4%      +0.1        0.21        perf-profile.self.cycles-pp.downgrade_write
      0.00            +0.1        0.11 ±  3%  perf-profile.self.cycles-pp.cap_mmap_addr
      0.11 ±  4%      +0.1        0.24        perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.10            +0.1        0.23 ±  2%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.10 ±  4%      +0.1        0.24 ±  2%  perf-profile.self.cycles-pp.tlb_gather_mmu
      0.12 ±  3%      +0.1        0.26 ±  3%  perf-profile.self.cycles-pp.lru_add_drain_cpu
      0.14 ±  3%      +0.1        0.28        perf-profile.self.cycles-pp.setup_object
      0.10            +0.1        0.24 ±  3%  perf-profile.self.cycles-pp.static_key_count
      0.14 ±  3%      +0.1        0.27        perf-profile.self.cycles-pp.vma_adjust_trans_huge
      0.13            +0.1        0.27        perf-profile.self.cycles-pp.tlb_finish_mmu
      0.14 ±  3%      +0.1        0.28 ±  2%  perf-profile.self.cycles-pp.__get_unmapped_area
      0.13 ±  2%      +0.2        0.28 ±  2%  perf-profile.self.cycles-pp.sized_strscpy
      0.15 ±  3%      +0.2        0.31 ±  3%  perf-profile.self.cycles-pp.cap_vm_enough_memory
      0.09 ±  4%      +0.2        0.25        perf-profile.self.cycles-pp.vma_expand
      0.15 ±  3%      +0.2        0.32        perf-profile.self.cycles-pp.unmap_vmas
      0.00            +0.2        0.17        perf-profile.self.cycles-pp.mas_wr_slot_store
      0.16 ±  2%      +0.2        0.34 ±  2%  perf-profile.self.cycles-pp.arch_get_unmapped_area_topdown
      0.16 ±  3%      +0.2        0.34 ±  2%  perf-profile.self.cycles-pp.zap_pmd_range
      0.10 ±  4%      +0.2        0.28        perf-profile.self.cycles-pp.mas_prev_range
      0.14 ±  3%      +0.2        0.32        perf-profile.self.cycles-pp.down_write_killable
      0.42            +0.2        0.60 ±  3%  perf-profile.self.cycles-pp.vm_area_free_rcu_cb
      0.17            +0.2        0.36 ±  2%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.24 ±  2%      +0.2        0.42        perf-profile.self.cycles-pp.vma_complete
      0.22 ±  3%      +0.2        0.41        perf-profile.self.cycles-pp.vms_complete_munmap_vmas
      0.19 ±  2%      +0.2        0.38        perf-profile.self.cycles-pp.rcu_all_qs
      0.18 ±  2%      +0.2        0.39        perf-profile.self.cycles-pp.zap_pte_range
      0.20 ±  2%      +0.2        0.41 ±  2%  perf-profile.self.cycles-pp.mas_wr_store_entry
      0.22 ±  2%      +0.2        0.43        perf-profile.self.cycles-pp.mas_prev
      0.21 ±  2%      +0.2        0.44 ±  2%  perf-profile.self.cycles-pp.obj_cgroup_charge
      0.06            +0.2        0.30        perf-profile.self.cycles-pp.mas_put_in_tree
      0.18 ±  2%      +0.2        0.42        perf-profile.self.cycles-pp.vms_clear_ptes
      0.22 ±  2%      +0.2        0.47        perf-profile.self.cycles-pp.perf_event_mmap
      0.20            +0.3        0.47        perf-profile.self.cycles-pp.security_vm_enough_memory_mm
      0.22            +0.3        0.50        perf-profile.self.cycles-pp.init_multi_vma_prep
      0.19 ±  2%      +0.3        0.48        perf-profile.self.cycles-pp.vma_merge_new_range
      0.26            +0.3        0.58        perf-profile.self.cycles-pp.vm_area_dup
      0.36 ±  2%      +0.3        0.70        perf-profile.self.cycles-pp.__memcg_slab_free_hook
      0.30 ±  2%      +0.3        0.65        perf-profile.self.cycles-pp.mod_objcg_state
      0.33            +0.4        0.69        perf-profile.self.cycles-pp.commit_merge
      0.36 ±  2%      +0.4        0.73        perf-profile.self.cycles-pp.do_brk_flags
      0.31            +0.4        0.69        perf-profile.self.cycles-pp.userfaultfd_unmap_complete
      0.26            +0.4        0.66 ±  2%  perf-profile.self.cycles-pp.down_write
      0.33            +0.4        0.74        perf-profile.self.cycles-pp.up_write
      0.36            +0.4        0.77        perf-profile.self.cycles-pp.perf_event_mmap_event
      0.35            +0.4        0.76        perf-profile.self.cycles-pp.free_pgtables
      0.45            +0.4        0.89        perf-profile.self.cycles-pp.__cond_resched
      0.55            +0.4        0.99        perf-profile.self.cycles-pp.mas_preallocate
      0.39            +0.4        0.83        perf-profile.self.cycles-pp.unmap_page_range
      0.37            +0.4        0.82        perf-profile.self.cycles-pp.do_vmi_align_munmap
      0.12 ±  4%      +0.5        0.58        perf-profile.self.cycles-pp.mas_update_gap
      0.35            +0.5        0.82        perf-profile.self.cycles-pp.do_syscall_64
      0.41            +0.5        0.89        perf-profile.self.cycles-pp.vms_gather_munmap_vmas
      0.40 ±  3%      +0.5        0.93        perf-profile.self.cycles-pp.perf_iterate_sb
      0.65            +0.6        1.20        perf-profile.self.cycles-pp.mas_prev_slot
      0.60            +0.6        1.16        perf-profile.self.cycles-pp.mas_leaf_max_gap
      0.49            +0.6        1.05        perf-profile.self.cycles-pp.__split_vma
      0.66            +0.6        1.26        perf-profile.self.cycles-pp.mas_next_slot
      0.50            +0.6        1.11        perf-profile.self.cycles-pp.brk
      0.59            +0.7        1.30        perf-profile.self.cycles-pp.__memcg_slab_post_alloc_hook
      0.61            +0.8        1.38        perf-profile.self.cycles-pp.mas_find
      0.54            +0.8        1.33        perf-profile.self.cycles-pp.mas_store_prealloc
      0.64            +0.8        1.46        perf-profile.self.cycles-pp.mas_store_gfp
      1.10            +0.8        1.93        perf-profile.self.cycles-pp.kmem_cache_alloc_noprof
      0.88            +1.0        1.84        perf-profile.self.cycles-pp.__do_sys_brk
      0.69            +1.0        1.71        perf-profile.self.cycles-pp.mas_walk
      0.90            +1.2        2.05        perf-profile.self.cycles-pp.perf_event_mmap_output
      0.46            +1.3        1.72        perf-profile.self.cycles-pp.mas_wr_store_type
      1.51            +1.8        3.29        perf-profile.self.cycles-pp.entry_SYSCALL_64
      2.22            +2.5        4.72        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.82            +3.1        3.88        perf-profile.self.cycles-pp.mas_wr_node_store
      3.26            +3.6        6.82        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      3.79            +4.5        8.26        perf-profile.self.cycles-pp.syscall_return_via_sysret





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


