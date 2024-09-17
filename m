Return-Path: <linux-kernel+bounces-331972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DF497B382
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 19:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85ADD283CA6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 17:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09728188A11;
	Tue, 17 Sep 2024 17:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AAQ10SKi"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF16187FFC
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 17:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726593608; cv=fail; b=W3WO2cKjmuLSV4jVmhT10KcF1WKcFel2sadGrnGtCxAqkDRJHm8ZXkCPaPWz4bcOcze6EqF+L22jdQ1M2MHdzw5HUDjFEx9IKG/b70V0hyEW/DQWEXcXBheLkjEIshpqYVc4Wdoq6VIQnJ1VC+kE0aGxOA/87XPKy/iE7pbwKyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726593608; c=relaxed/simple;
	bh=a4hWSoJK6kotmtvwAiWv6q1CipqV4b2Da4ofW1lpcOk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WEnczyRqqC1BBjcIci6tXqnlqFQFvPuzdY5t4sWaXd4kbXUBk1FJLT6uQ0B/OA1OA+WNbVcBS58tcO5WF55gv5p4ydh3EmNGuEUG+3c7/69XEuUZAmB4ZDkqeX8NLcBy6B7QXtFw1qMfLeJ3WC2D0CmHL/ZZKD3O4bLB6cyI+DY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AAQ10SKi; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726593607; x=1758129607;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=a4hWSoJK6kotmtvwAiWv6q1CipqV4b2Da4ofW1lpcOk=;
  b=AAQ10SKi5XvMGfSs+1xGTqhlzDNsMf2OaBf/qUdAZoGRRLdkIEXzvOof
   tv91KP6iSNmIFMcHtMFFgjInfy8ZWARlFuPhOxrohxXKIETVlN8ntmktF
   +jQtcrbOCqXw1C3/Oy4dQgrTa/kej7BuphHKYEscwry0gI1XT39jxO1Tg
   jJbfsSXbWgTbU4C9coGYbonOh+K++dxroo1GYJybjwNiSQS3jMHu7Cstt
   ewB5pKdIixkC+1Edj4fvrYjSKRueFSJRESgRYTiPBXubZ5TRnNn/hWeDj
   jX5WVJ/8LN3E2HgCAvrtkRCcynMDBNb317I42z8P8gCBV4FPSQPi7pcYX
   g==;
X-CSE-ConnectionGUID: XHQ9CBbNQrKRHJhxZb0Dhg==
X-CSE-MsgGUID: NJmzgCiGQ9OcfyOWEUWVeg==
X-IronPort-AV: E=McAfee;i="6700,10204,11198"; a="25345958"
X-IronPort-AV: E=Sophos;i="6.10,235,1719903600"; 
   d="scan'208";a="25345958"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2024 10:20:04 -0700
X-CSE-ConnectionGUID: z0g+Dip5TyiUaXnZjvFqgA==
X-CSE-MsgGUID: F/b0U1ECQgyLbOCgxNQEjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,235,1719903600"; 
   d="scan'208";a="69364165"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Sep 2024 10:20:04 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 17 Sep 2024 10:20:03 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 17 Sep 2024 10:20:03 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 17 Sep 2024 10:20:03 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 17 Sep 2024 10:20:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fo8G7hv68CDCAdpWZTadzQtCsAyun4DFXVn+ZbxWFyIbg2gww6kEtGS5miPJcaBg9p92SPzWCBJjGgXAClQ0TrJHGMMLf6fSLqq7LT0xMNENLcawH5x1u4MyjMC31QfJ4rumDx/f18tDoZQC0KLkpfkEr/vGXJphRjnAKVJTYU4/yPY9QO30Fmz7JK9jzviTghbUgsuksN1NJiASUeZPCQub1HhfrQOEGlanYv/VGozhRW4XSJ/h9VESxTJrpC7Hhe5B0MNyD3ck/XTyay/fyGBJ5q3Z/U9KLIhT3R4NFVNODzgd23ITF5uJByZ2UYJngmkJ4xg94xmG1rXLpbxX3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPyx4NVUAHtyHxHBACwB/U9CmX6WvBdZfWW13Gt3Sy4=;
 b=PMBgAQZgYeL0gfCQjjDQPpZnq414E07u2VyAAfrnv0hjPJGcvvwDExoEmZqNogPXF5FmpUBR5gNKakXkQY2b33oMKk8xn6GYPbkEr+ajC5+299JflI0f8uWe9E7lfQuWIuRpJVXCkZ9ZZ1DXbAqCrFyu+hCgIot9qKszn83v5DeK3/6o6ivbty5Hn67jRBzr3xbQ6LWJ/ciP9lOkFpVnbA0fGtbb89fLhUowoOtnXWVCiGILxLH6kodMtW0RPeyAc6FKvX6byZI3zucWBBQMYjcUYor26WeDsIagnzYMm23hmcGI9v7r9CisYzkCbN7XcXImPXlm26aUJPbR3qalSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ2PR11MB7671.namprd11.prod.outlook.com (2603:10b6:a03:4c4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Tue, 17 Sep
 2024 17:19:59 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7982.012; Tue, 17 Sep 2024
 17:19:59 +0000
Message-ID: <771f3a74-722e-4966-b319-daa28ce24e86@intel.com>
Date: Tue, 17 Sep 2024 10:19:57 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/resctrl: Avoid overflow in MB settings in
 bw_validate()
To: Martin Kletzander <nert.pinx@gmail.com>
CC: Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, <linux-kernel@vger.kernel.org>
References: <1723949d8053aa74da907165dbdc26755f341736.1726492059.git.nert.pinx@gmail.com>
 <abffe9bc-4c2b-4d44-b521-f138179033e3@intel.com>
 <Zuk5_3qzSfld5dvD@wheatley.k8r.cz>
 <7467f313-761a-42ed-ae2d-cdadfd93db90@intel.com>
 <ZumkrWn7FtiMxESR@carol.k8r.cz>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <ZumkrWn7FtiMxESR@carol.k8r.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0289.namprd03.prod.outlook.com
 (2603:10b6:303:b5::24) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ2PR11MB7671:EE_
X-MS-Office365-Filtering-Correlation-Id: 680e761b-19b8-47b8-53ff-08dcd73cf531
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VU1NYlJORW83ZExFTTZ0YkJUeHhkRkUxUE1sUVR2WFhRZmgvUXBNMkEvQ3hj?=
 =?utf-8?B?aFovSFdhclp3Q1dQSzcvNEk1cGRJdVNyVHZqaldHNkpPaWdlSENpTDNuRksv?=
 =?utf-8?B?WmRTVDhEZ3BhR1JTSW9CbHErbjZUVW4xRlJJbFB4dFdUNHU0OHNadWsvclhR?=
 =?utf-8?B?Q2w5SXVCRzVQcExsTUI5cWpEdTdOMHREbDgxZUIxdnZaQitCblU2b1o2NWJI?=
 =?utf-8?B?UjE1UXZmMXZsQlc2TTlCRm02QTcxR1RmWXJvcHNaaFYza1BPR3NFVitiSmFN?=
 =?utf-8?B?YXVaMTFvS0xNcm9VaGZ2OUNGMjJvWmhTWWkwRjJhMGZrYzNrT29ORGpmcXhk?=
 =?utf-8?B?d25YWTRUL1dudm1nbVpURyswTmJZRVZIZC9CRlJLRzBXL2s2NnNTZ1dQTWht?=
 =?utf-8?B?UE44djFlQnJ5eVJqZ3RuUmdaWENtZzduVlZOOUo4ZW1OMFErV2EyWjBESTRK?=
 =?utf-8?B?WURXU2MrK0ZsRzlkZ3NqZ25CZmRhK0cvTmttd3V4Z0RCbmtZSWJ3NUFoVm9G?=
 =?utf-8?B?Zk1wM1QybzVOMm9DVG14Vmh6ZElGSXZkdVFmcHZaaW5iQVdRTkNHbXlZNE8v?=
 =?utf-8?B?Q2xkQ3VKWWY3bjNzVHZsRmhLTUQ2NCtrNGVWOG4rdDhPUC95clErS1dtbzA3?=
 =?utf-8?B?eDFaL1NHTHo0VWYvb0JyQ3RkMmdoMXd6ZDN6WVhYRmU5NlBKeEt4THN4VWQx?=
 =?utf-8?B?R3c0WXIxNjRnLyt0b2VraldrWGFKdHdFblkwMHZiOFJWSUdHZXl4dGZRTkJy?=
 =?utf-8?B?WHNvYldBYUlGTjE1dlpGQTJhYXJLeVhCWHI2dXZXTXZOekIyL1hDVmY5RENR?=
 =?utf-8?B?MHFJcEU1Nk5GbFJSVmhhdk14VGNFcHR2bGY1TFpXM05NSGJxU3d6cC9BbmU1?=
 =?utf-8?B?d2drZ0NjOWJ5azVWdHRzZE5TQm9Sa285ZU5WUFJaUVB5a2JuTGxXL04wN0pJ?=
 =?utf-8?B?MncyQ1dtQms1akN2dHB0NXNLUXZrclpkUXcrbUxQVjlMR3RqMFU1RnRZYWJy?=
 =?utf-8?B?MWlWNVV3ZnVLMDFCVk1UazFuTFFwNnpxR0l5RW9nZEl6cDgwdGl1YjAxb1Vn?=
 =?utf-8?B?Z2JxSXZYUW9zRGhORXpsNk90ZDhTeVhLSW9JTDNJc1UwOUdFd0crd0Z3azB3?=
 =?utf-8?B?UGgrUkdqbGVvcWxzdVNmTzZhYWNIZ2ZiYk5ENTNXRFZiUHBWekxIYkFCM2Rk?=
 =?utf-8?B?Tkg0NUcxS0U0cERCOWt2SGNhRTNRT2theE84cHRzZjVIc2taRElvVzdTN0Q2?=
 =?utf-8?B?SG9ieVhFTXJ5VnlHelFyMnhXVGtnaDVRS25BQkt0aUtWSWxCbnoxb1VObytj?=
 =?utf-8?B?Nm9RVlh1ditBYUtySzlkbk4wQW4rR0hSdW44NVdYREV2NFpuUG5raDFQenZZ?=
 =?utf-8?B?ZklGS1F5ZXQxZ0MvNVo2bFVyUjFjVXRLODhUS29iczNXNVd4aGxhV1NuMWF6?=
 =?utf-8?B?TEF2Rk9qV0VRMXpNSFpkZ1l1bUZvU0F5bzE4K081UENwenJUd3VhaEgyZWpZ?=
 =?utf-8?B?Z2szcmszSEZtS0VNcmZFWjNHUDlkYy9WRUJwSTRQZ0Q5YXlMV1JQeVBWWnMx?=
 =?utf-8?B?bjBVYWdyUDlENlRMK3pRVjExZmkzQ3Q3MWI5cTdETW9ZU2VEenRkNjFmR2JX?=
 =?utf-8?B?aWpiTEFkenE2Z0lvM1MwSHFmTVU2RFQxNWZOdmV2WWJQRnJlUDVNcUVtSitm?=
 =?utf-8?B?VENnVy91d0RPQjdSWmhPNmczalJ0bVNmOGk2TW5PVWpnZ09hYWswWDFmc2p6?=
 =?utf-8?B?VGJOODljOVJXVjFVZ0NieEV4cE5CWE40bVFyYVpSL1ZEZ0tnU3IxWEJtdnVh?=
 =?utf-8?B?TDRNQzg0QTJQcGlQaVdNZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWYyYUltb3Z5U09KbThIT0RKZXlML1o0TmdaRzF5dUF3aGlVdnphVWNkWkYr?=
 =?utf-8?B?RnZXRWRaRmp0UUVQVmdYaTlSVzBKc3Y1M0NCTXB1dG1qNVQyZnRlN0llRVRH?=
 =?utf-8?B?eHk5T28vOXA5aVJVUHkwWGxmSTlIMFJSQlIvTmxYTk9vYzQyMXRId1ZVWmJ0?=
 =?utf-8?B?ZEtNL3J3UWlSZndUSXVRS0ZwcjV4cjZrSmxUL01JVlIvS2JwRVZaVmxuNkJE?=
 =?utf-8?B?VHFSR2g1YkM2WkE4V2dJcDhadjFCdnlVbjBqbUgxUFFBaFdnT2c1Sld0OXMv?=
 =?utf-8?B?dE9KMmxPUDl0WXVhU1JnWmM1K2Q1YUtqSkxIQ0EyWEdyZEhCRTQ4MnJaL29D?=
 =?utf-8?B?RXdDbmlzSmZaeFJWb1RQT0RjemxOY05WRTE2Vk9nSmEvanJmVVM0Z0pMNlN1?=
 =?utf-8?B?Wlh0VnN0ZEU3VVFNTk4xcXRaby94UjJCTzhOS0dMa016TiswOGEwNGM5bU5B?=
 =?utf-8?B?bnZKc3p1Mk5ncHdHbEczUTBBTjRvbVlQWkUzb3hLZi9yR0JlcDd0aElBUWEw?=
 =?utf-8?B?dWlPa0NJM0JPM0lSWlU0VllTUWxCT25KSjNvNTJFUXI1bFB6dSs3QXROajE0?=
 =?utf-8?B?SGNDNkVNZGpuZUQrS2lqRVkxQTZZTkRGOTlzV0s0ZzMzdFhXeWlFTjVBdDlD?=
 =?utf-8?B?NUJzTlczV20zbjk4S2pJKzFYajlQQjVFMURhRHAwTWQ4N2Y4SkZ4MEVnR0lG?=
 =?utf-8?B?Umt6RzRSUCtFUC9jRnZOczBET3BtVWFCci9QRXhPdlhWRmRWa0lkbDNmNUdY?=
 =?utf-8?B?NnFEZk9SOTdJb3RtQmgwQkE4QjNBeWFRdUZXR1dFRHpNMTFRakJUYUc1ZWtF?=
 =?utf-8?B?TlQycTlSMnllWkJscElFdlJIUGF5REVvSmd6VkFHQ2pCNFdWcS9XWkJTT0F3?=
 =?utf-8?B?Qkw4NzBsZlhmbWNYdGtmazVDWVM0OGlQTmRpSEQ4eHFmOGZ6OWVnL3l2TGIy?=
 =?utf-8?B?Z1h5M1VNYWxwdU5KR0dTSDh0cTErb1o3VlE2bWt3cjIySEJsQ0d3MVc3eHBs?=
 =?utf-8?B?ak9QeG1HZGlEbkw0azdFRTJDanpZTWM2UE9TZktuRFNRMkFxNHg0WGhmY0s1?=
 =?utf-8?B?M0ZyUE93dXZTRHNZMktpbTFLVE5OdDNibXpQNm9hNnczakxqSWxWb08ydzZY?=
 =?utf-8?B?L0F2ZDlsdTk1a0xmSFNDcjFSbzA3S1VQdVkvMjR2KytudUhZU2ZlcHU3TlVB?=
 =?utf-8?B?Y3dBSU9ISTZtTFlpUVdsMHNGK2JibzdrYXVSR2FjWEZObEVJME04aW5PakY1?=
 =?utf-8?B?WGFOdkFlU3p0dDNPME1qZE1zZGNlcUJ4ZjlpMExXK0VzaFVEQ1NaUlV3Tk1o?=
 =?utf-8?B?OUtEUG43amc1elU0YWRIa0YvWnNoSFdEOFh3MWVMWUdzeXZ1WWV0d1h1NjdV?=
 =?utf-8?B?QzNLRXVUeldtMVVzNzVteGswZmthSURjTWRRTHRObU5BamJ2em5KNm5XM3dI?=
 =?utf-8?B?U1JpNmZzeXdjREVTVXd5RXAvb0xGQlM2bkwxdXRWdmF0TXlZVmZhbW9nRWJM?=
 =?utf-8?B?TG9PbzZBVVhoUmhwbmowUzllS25FVzJqMW01UVNaaDZEUUkvbGxVaGIyNUI1?=
 =?utf-8?B?cjdCNXJUdWtEUUZUMnBoNWw0V0VTS3E5MTZWQXNsVE9TbDNGUkZMVkt4QjdQ?=
 =?utf-8?B?ZldEbm9kTmpuRWVxYkNrUVhqQ2QreWc2K1JKK3o4RkNodWpuWWgxTHJjcmcr?=
 =?utf-8?B?U3RTbHdWSDlBZkVQZTNXaWFqVTlvQkFLTS9KSE9IaktPMm02V0V6bk1hMGpX?=
 =?utf-8?B?eDNmbHRCWmhPL0dORjJDOGhmTDF1dHowL0JleUpoNGdyTUpwMWFhVTZPc1kw?=
 =?utf-8?B?OEhLaDNnMWNuWUQxc0FLUS8yWmZKL05nWDBOckZ0QmpTRDFma3N1Uy9uWnJX?=
 =?utf-8?B?MTZKM1BSQzZLNi9rb0JNVHl2VjY4R1FRYjZYYVpPNHhIa1owKzNsK0FPNm5E?=
 =?utf-8?B?Z1BWMlpMaER6NnJHVmRmV0tqRUZZaHRYaUltZEsxQXZ4dWk5MmFlRGhDTE90?=
 =?utf-8?B?c3FQcTZ3Z1lwS3Ivb3hEWVIyeUhxa2lNZmQrLzJLRzY3NUZxMCtxNGVHTnpv?=
 =?utf-8?B?WWVMT09TdjdwS3BVeEV6RnZHWjhCV1JVV20rNWZrRWJlYU8yYktMWkZBQm5x?=
 =?utf-8?B?SVZVVDZyREVKZE5KWEFiVWRRM0crNDJFemxpeTl1VTJxR0h4VzFpUGpjYkk0?=
 =?utf-8?B?Z1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 680e761b-19b8-47b8-53ff-08dcd73cf531
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2024 17:19:59.2664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V3+8Xxmo/ZK3XNboB585XbFIczEg6oMWF6pORCBug2MZDzxSM7mJjVCGdJOv6iBMipMyNvWdA2JFc7ylR6MguWlY/A9t50X1KPXq4UGs9dg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7671
X-OriginatorOrg: intel.com

Hi Martin,

On 9/17/24 8:47 AM, Martin Kletzander wrote:
> On Tue, Sep 17, 2024 at 08:08:50AM -0700, Reinette Chatre wrote:
>> On 9/17/24 1:12 AM, Martin Kletzander wrote:
>>> On Mon, Sep 16, 2024 at 09:56:01AM -0700, Reinette Chatre wrote:
>>>> On 9/16/24 6:07 AM, Martin Kletzander wrote:
>>>>> When resctrl is mounted with the "mba_MBps" option the default (maximum)
>>>>> bandwidth is the maximum unsigned value for the type.  However when
>>>>> using the same value that already exists in the schemata file it is then
>>>>> rounded up to the bandwidth granularity and overflows to a small number
>>>>> instead, making it difficult to reset memory bandwidth allocation value
>>>>> back to its default.
>>>>>
>>>>> Since the granularity and minimum bandwidth are not used when the
>>>>> software controller is used (resctrl is mounted with the "mba_MBps"),
>>>>> skip the rounding up as well and return early from bw_validate().
>>>>
>>>> Thank you very much for finding the issue and proposing a fix.
>>>>
>>>>>
>>>>> Signed-off-by: Martin Kletzander <nert.pinx@gmail.com>
>>>>> ---
>>>>> Changes in v2:
>>>>>   - actually save the value in the output parameter @data
>>>>>
>>>>>   arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 9 +++++++--
>>>>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>>>>> index 50fa1fe9a073..702b1a372e9c 100644
>>>>> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>>>>> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>>>>> @@ -48,8 +48,13 @@ static bool bw_validate(char *buf, unsigned long *data, struct rdt_resource *r)
>>>>>           return false;
>>>>>       }
>>>>>
>>>>> -    if ((bw < r->membw.min_bw || bw > r->default_ctrl) &&
>>>>> -        !is_mba_sc(r)) {
>>>>> +    /* Nothing else to do if software controller is enabled */
>>>>> +    if (is_mba_sc(r)) {
>>>>> +        *data = bw;
>>>>> +        return true;
>>>>
>>>> While this would fix the scenario tested I do not believe this fully addresses the
>>>> overflow issue. As I understand the test wrote U32_MAX to the schemata file,
>>>> which triggered the overflow because of the rounding and is fixed by this patch. Looks like,
>>>> after this patch, writing "U32_MAX + 1" will still trigger the overflow.
>>>>
>>>> The overflow appears to result from some inconsistent type use and not using
>>>> appropriate parsing API that is able to detect overflow.
>>>>
>>>> How about something like below:
>>>>
>>>
>>> That makes much more sense, I have not considered changing the data type
>>> as I wanted to keep the changes at minimum, but your solution is even
>>> better.  Should I leave the fix up to you or do you want me to send a v3?
>>
>> Could you please try it out to ensure it works for you and then send a v3?
>>
> 
> I wanted but the diff has some weird line numbering and could not be
> applied.  I'll write it manually later, test it out, and send a v3.
> Thanks!

Apologies. Please try:

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 50fa1fe9a073..53defc5a6784 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -29,10 +29,10 @@
  * hardware. The allocated bandwidth percentage is rounded to the next
  * control step available on the hardware.
  */
-static bool bw_validate(char *buf, unsigned long *data, struct rdt_resource *r)
+static bool bw_validate(char *buf, u32 *data, struct rdt_resource *r)
 {
-	unsigned long bw;
 	int ret;
+	u32 bw;
 
 	/*
 	 * Only linear delay values is supported for current Intel SKUs.
@@ -42,14 +42,19 @@ static bool bw_validate(char *buf, unsigned long *data, struct rdt_resource *r)
 		return false;
 	}
 
-	ret = kstrtoul(buf, 10, &bw);
+	ret = kstrtou32(buf, 10, &bw);
 	if (ret) {
-		rdt_last_cmd_printf("Non-decimal digit in MB value %s\n", buf);
+		rdt_last_cmd_printf("Invalid MB value %s\n", buf);
 		return false;
 	}
 
-	if ((bw < r->membw.min_bw || bw > r->default_ctrl) &&
-	    !is_mba_sc(r)) {
+	/* Nothing else to do if software controller is enabled. */
+	if (is_mba_sc(r)) {
+		*data = bw;
+		return true;
+	}
+
+	if (bw < r->membw.min_bw || bw > r->default_ctrl) {
 		rdt_last_cmd_printf("MB value %ld out of range [%d,%d]\n", bw,
 				    r->membw.min_bw, r->default_ctrl);
 		return false;
@@ -65,7 +70,7 @@ int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
 	struct resctrl_staged_config *cfg;
 	u32 closid = data->rdtgrp->closid;
 	struct rdt_resource *r = s->res;
-	unsigned long bw_val;
+	u32 bw_val;
 
 	cfg = &d->staged_config[s->conf_type];
 	if (cfg->have_new_ctrl) {


