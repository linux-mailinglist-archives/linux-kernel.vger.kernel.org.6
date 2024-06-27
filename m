Return-Path: <linux-kernel+bounces-233013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1368891B117
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 22:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 868BB1F24EFC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 20:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D7019EEBE;
	Thu, 27 Jun 2024 20:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UX1RQA1q"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C1014D6EB;
	Thu, 27 Jun 2024 20:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719521824; cv=fail; b=iPjrqmrc9Mc9nuQ6/zh7BdgTVc+un5nraEE7fxJiZFXYJcddLgSkOE47Z+bwBnlwvGXwJqNcjbEzNubOjDt+O90WoSkWkw6Qy2v10nf4md0TH1ShgxRphxcV1FXjwjNmwzcpBixIh8xHluRecWXEP9T9TTE7NEGmB+hnySOintk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719521824; c=relaxed/simple;
	bh=1zPLw6nhtKQ4BSb7Pmzh25f42TDyIlg36H3i0cJBsFs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bitBqGKNncCwBHINipMrT5+SK/b5Bs00xdx3N2XHICgojyhxOCoY+0CIib+d8RFz7kV7pAFBX5q7ufZsP5xUlbyxWzBZXocUcIKXWi9KNwR9lFHWpVYy26zhxTZaZyJ2pcBzvuI2ceoq+xvAHitNfXa72Ht8sVrv+ySB5+LoOsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UX1RQA1q; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719521823; x=1751057823;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1zPLw6nhtKQ4BSb7Pmzh25f42TDyIlg36H3i0cJBsFs=;
  b=UX1RQA1qaKzu70g1awxi7h8aVsVTbBbZXt91bcsyP4ANbSlBksmDQpu+
   JSCt2w0VlWz4Xywdnyvjfxgz6zUhpwq1qyScO4gft40DzcZr2O6C2AI7o
   ANe/v1DlW8iLfRngJ0bvg6D/rQFVHD9uf4xbDEzRCFyAXTaJWv+aefnVM
   fRzPQDMvxsLlHrO7t5CwPVanEDwmULqelEt0tN/PsVAhbBCpTYU9vYEnL
   Q3j68vLdEQj+HMHVfzQnKMjQXF0kTjrir2EFOBveCfJe1A/5ZWsCNxaok
   l+Qyr2F4JEA/bdz6xOqt+N1XHmcyyfiAQTzWADrp7hgcy52xCHLFRqUVh
   g==;
X-CSE-ConnectionGUID: P05ZADafTRm4FCsol0dvTQ==
X-CSE-MsgGUID: /2yKmrYhRsSewktRAGRxEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="20444584"
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="20444584"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 13:57:02 -0700
X-CSE-ConnectionGUID: Vnq58zNiQKGc2FwqE9uUnw==
X-CSE-MsgGUID: m3J6FkPKRDej+stHgtSpfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="45154371"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Jun 2024 13:57:01 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 27 Jun 2024 13:57:00 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 27 Jun 2024 13:56:59 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 27 Jun 2024 13:56:59 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 27 Jun 2024 13:56:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HC52XTOqk0E3tDdEFjqOle9qs8Z+1PiUeO8ryDf8T+YzUZU0H1vPNe6DjJPfH5TWwKSL0bwdRD2o7M3Mh4GC/zDh7SqGcbp2tXVyZwOfhIc73IPe95k1qCr5PlUbA/PJcmj68gPAX7Let5KhjSrBwDn/BVyqveg39XzjIryfwHz+bCmz88FVnS/noGaHF+UVEoeNbK92ZXby+DCoW6dhJFJQjrUpiHYyIzyJ1WQzdV29Qd9wCymIFUBBOEo1lvQvheA9QhMe+hj1zqkdVfJVrqKz54uCHu+31i9WAL0tIxRh+n/ucCCjTXrRLBd7VCgem/7dlD7o6RuMmjeKTSuzHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8AksTTqyIAWCwIsGdK81yRfMgMguBv2slb2EUHn5vgs=;
 b=Z4VQSnrl7E0N8Pou1LZOn2I8EtiGG7UpQsSjBcu9IUpfUmWisrrQ7tHPWFl5+zAmr2b1mscM8K2HiTBx09mFza53IPhbmbdUomx1SfxMBTE1xJURjlsoPFg6T9SyzL1bdm1DqXo66qCVVxvsMnjdKyOmmtmcfw6f3u0fkjma9oEdk+fB5FE98Aaw12u+RItNbhsRud5l05lLS2dfQfgNcxqWXjCnY7CfhyzUeJFsPoBh64b8Qr/8kUrNcGPP5sudjSMXcHYT+nHRQ6vbyLYwaSt/6ewPEukoXvBlTBuykzm4LZL3ELDPVrYLb8iSbciUC7/YOQTVJQ+8dapls+3pZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB5796.namprd11.prod.outlook.com (2603:10b6:510:13b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Thu, 27 Jun
 2024 20:56:55 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7698.033; Thu, 27 Jun 2024
 20:56:55 +0000
Message-ID: <81f3bdb1-ebb8-4a90-9cf0-6a2d09ff13e9@intel.com>
Date: Thu, 27 Jun 2024 13:56:51 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/19] x86/resctrl: Introduce mbm_total_cfg and
 mbm_local_cfg
To: <babu.moger@amd.com>, <corbet@lwn.net>, <fenghua.yu@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
	<yanjiewtw@gmail.com>, <kim.phillips@amd.com>, <lukas.bulwahn@gmail.com>,
	<seanjc@google.com>, <jmattson@google.com>, <leitao@debian.org>,
	<jpoimboe@kernel.org>, <rick.p.edgecombe@intel.com>,
	<kirill.shutemov@linux.intel.com>, <jithu.joseph@intel.com>,
	<kai.huang@intel.com>, <kan.liang@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<sandipan.das@amd.com>, <ilpo.jarvinen@linux.intel.com>,
	<peternewman@google.com>, <maciej.wieczor-retman@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<eranian@google.com>, <james.morse@arm.com>
References: <cover.1716552602.git.babu.moger@amd.com>
 <a02dd2b9fa06f360eabe923c5c6d17fa4036aa9a.1716552602.git.babu.moger@amd.com>
 <48e0d78c-5ed8-4b93-8f12-3ce3fd74116c@intel.com>
 <68e861f9-245d-4496-a72e-46fc57d19c62@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <68e861f9-245d-4496-a72e-46fc57d19c62@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P220CA0005.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::10) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB5796:EE_
X-MS-Office365-Filtering-Correlation-Id: d1ff9c50-27ee-4e3c-0bb5-08dc96ebad97
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Sm1MZW03aE1JWU9MQ2xKSzR1UmlsanpBVzB6NFdkbWk0MitZeHBCSFJndUZ1?=
 =?utf-8?B?Zjd6Mk9XTE1MY3RiZjRJL0FncmZDbmNydmpPdWdkSlcvMC85blZ3dU5vRHJZ?=
 =?utf-8?B?K1E2M3hWVFVOQmhMMHRmUkxFQ3hxbDhhSzJXNVdubXFPS2NGbXVTckVaeDhB?=
 =?utf-8?B?QTFnWDNHelNRVVNQeTVYeWZYRDVoRForcG0yMTRCQmpiNmtGaUQ0MjBKdm9a?=
 =?utf-8?B?Vkgyd1BBSnNjTWtPbW54eGg4ZzJQWmhqb0wxdmtWcFNUOGcvTllJU1lpUnNh?=
 =?utf-8?B?Q1FKeXdEYkhueFhxeWd1L2NzUTJLanNRcGM0SUp4MFBkTW4vY3BLM0tVNEhY?=
 =?utf-8?B?R01VbkZoY3lsSnBJQTBpN3JWazRRbTdHa1dDa3piUCsvRjc5SkRyVEcyNVYz?=
 =?utf-8?B?cmdLYjIzNzFMWmtmdTdka0plY0tMU0tMTFFOaS9oLzNpeStoT1lzdkdISEpL?=
 =?utf-8?B?TFdQTzhOK0dibDZESk1YM1A2NFkvYy9FT0h4UmZyellqWmNZdUlzS28yN2tp?=
 =?utf-8?B?UDZsS2xRM2k1U3RraDd3WnNtNEErNmtLY2Y4ZUo0Qk4zY0NhWGhnL0o0ZHBr?=
 =?utf-8?B?YVZQdCtmOUYvNS9QOWZNQnVGdVh6dGg1Y3doc2Jzc2ZYdWg0TDNNbkFTVkdQ?=
 =?utf-8?B?aWs0Q1dYTldjZHpRQUVPUmhXRzJPZ0ppZHhGdTRHU2VwWmszMGZWdHQzdlBH?=
 =?utf-8?B?dDU1VmN5VTRVeUtzNTlxU3BoeVBSU0tPbDlDUUJwRDVhNEZmc1Q1MW8vc3Jt?=
 =?utf-8?B?WHBrOE5ucEYvOE9GK3J2dzZWR0RkV0YxUjhweHVBZm9JZGtRZTlWMlVBQVE5?=
 =?utf-8?B?OUM2TlZXZ21ibnl5ejdrQ0VaVWpZYzJ6blR6TGgybEl3RHlwNVdqdlo3SzBt?=
 =?utf-8?B?QnR4TDdBSVlKYXNINVhVc0Njd1J0ZzU1elAvazZWTFNsaml1Q0hYQWYvQklr?=
 =?utf-8?B?MVAvQ1ZzbmVlWmZIRVUwN2N0eW9tMW1hclpwbXk4cWlBQlJ0RkxCVTV3MkJu?=
 =?utf-8?B?enEzM0R2N2NQdHpEbHVnd2V5Q3h0WkZZSThyTnVnMXVDU3ZxcnJMMTUvNHJi?=
 =?utf-8?B?QjhQeVhWWi9xYTBjQ1BWcmRuSzZQMHlXVDNkSm00Sys1VjBPN3RMZUhNbUJN?=
 =?utf-8?B?Z1Y4MURJTFNMenRxbzdCdUFkRTMxSkRkMjRpY1ZTSVBQaWdUalFuVFVrVW14?=
 =?utf-8?B?Ny8vYlRRNFN0bloyZHZNSnZvLzFTUlcwdktVNDY3dVpHMnlDeGRKUVY0WVRW?=
 =?utf-8?B?aWpCcTU5OXJPNE5PZjZNRHcrYUcwOFJQRGNHRFlNSWNGU1lNTlFtUERHajBy?=
 =?utf-8?B?VDJNRUQxcWdjTmRjT09MRzJqcVdUZDdlUU4wNUE2ZUVjT3h4OWJkTURQWkR0?=
 =?utf-8?B?NXZhQXNoRllUZU00VW93OHcxNzRBZWxLVW1IK3ZOdi9yUU15Z2VmZHRib3Ji?=
 =?utf-8?B?VEcwNjZsZGFuSnNwaStoS29SQ3FyNkcrb0UvNU1PU1ByajJ2cXFKejhWK3N0?=
 =?utf-8?B?aFh5ekJqRFQ5UzRrRnh0dmJUdGJScU0xZkFMRmlXRlNNRjJGR2txUlhOMGd2?=
 =?utf-8?B?aUpRVUt6RklFZUpIWmIxd2F6ZTVFYW5LczJobUtRV0tHUDJaNG1vand5b1pZ?=
 =?utf-8?B?OWJRNWFYMWdvY1BFQmxhYmZVa09SVEVLWnE2Z0I4dmg2dFNUREgrWGhjVGlU?=
 =?utf-8?B?U1dvVVNXMEFqSjhPakdlSTdkTHNFMUdYSVFINGlEZnk4NXpwcnk0aHhUNDdU?=
 =?utf-8?Q?n25y8U3ldAiomUZw34=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmR0Q0xPWlpZWkw1Mk9XeE5ISXJzNDRMbDdCc0w1dnR6akxOdk1MVTEzWm5X?=
 =?utf-8?B?KzlUeHNrNHd2enU2Q3ZaN3lNN0Rsc2NpMjE5SFRva2M5WkViKzlxU2NqaGl5?=
 =?utf-8?B?TW9OMUVhY2NkZllqMGV3QWdJMDlWMERxU0I0cTJFNFJOcWNLblNpK0ovbW4v?=
 =?utf-8?B?N2tmdWpJNlA1UDFFYUQ0WlRRNE42MjY4VlF5RHRLRlU5ZStRaE4yQTBaVFhK?=
 =?utf-8?B?S3BRRDhUTk5XTTZ3dFVxTENEeHFlMnFOVk51aFlxMnJodGlmdmZhbkJqUGp3?=
 =?utf-8?B?NDFXam5vMGhLZXhZdWlGaVZyT0hNOFVycXpjTWpUMjd0UHEyb0RCUUFsaEpM?=
 =?utf-8?B?eVpOck9PNktWRTFEbkEyd2NndVM3cE1EaXZYa1g3b2laQlZKbk03M0hVbEp5?=
 =?utf-8?B?andrelg0YU5HblY4eXZFOVk2OVNkUktYNXhkQ1BoWHp0SUl6VXhlelhuazA5?=
 =?utf-8?B?L3dBUEE1Zy9QcDZ2UnZqZVh6VURrWk1ZTm93YlMweFJ1MjQvVjZ3VkdrWHEr?=
 =?utf-8?B?WEFnVnp3Ny9wNldGNzJlUktuaGdLZXBXUlU5Q1JrcUpDVlNFcm5uZC96QVhF?=
 =?utf-8?B?ak5NaFRxdGVSdUZrSzdNYW4yRnVkQzI4NENyd1pZZ1VLakU1YWxaUE5NUDBD?=
 =?utf-8?B?YlBETk5WMEVZbWx6bjd6M0lkMGpzWEMzY0FrWUswTytKTXcrV25hY3NlbkZH?=
 =?utf-8?B?UFc2TS9DTStMQndKSDZpbEk0cXFJemRmcnVNMFNhbWRUVUdUMkExenJaN1F5?=
 =?utf-8?B?QU5kb1pwMEp6QVFNc2VsVDFzUUhEcHV6ZzlIc1ordyt6OVJCZTQ4clowOUhl?=
 =?utf-8?B?QndBNm9PZ0haRHVKNUYza2I2S2tHVzI3SFdDLzhqVjhOQzhNWmZxN2Zpa1Nx?=
 =?utf-8?B?ZEhLakR3VHRuY1F6b1pQSUZjSHZMbUs0T1ZhL2hxNmltT2hmZUpDV2xSbThY?=
 =?utf-8?B?TWxVbG9OUmhXdU1UOUdvMTE1V2ExdTJib0pHSUlGcklOMU94ZjNOTmd4SHly?=
 =?utf-8?B?UytwWTNCMHFkYkk2UVBMYjUyVUhCKzg5a1RYK0MrYW1KdGV0QWQrWGNCYXFw?=
 =?utf-8?B?LzVWSDNIUjZqenRUTERhTGNpb00yWDVEOFpnM0hkMDlkQ3V5SlZlQWd4eSsw?=
 =?utf-8?B?VC9yZk5veWZTVW9ZbDIrTUQyVEVoWDNGUVN5VlMzNTVzamdrdWtrVXdRTUl4?=
 =?utf-8?B?d1lMQ2NkZFRNeGRyc2cxT25MUVgrdEtSd3d0MEZsN0x5d255WHcxbDl0aUNK?=
 =?utf-8?B?cWRRajB3dHdxTlZNMDBoUDU1eHdWbXFhN0M2bTd1Wld2YXNpeVVMMExjaXN5?=
 =?utf-8?B?clovc0oyK1Jaa1ZCdC9VclBTeHJxUUN1QTV3Vjh5WGk1Sk1jelBzdnlTT3Vi?=
 =?utf-8?B?S3I2V2pkSVE4YmdIb1FaRG5kTlJPd3RJb3hyblpNY01ldEIwSFIxenY4c1pv?=
 =?utf-8?B?Y1Uyd1hZVWxqQ2lucUkvaVJoeEdQQzBPQkhlMjgwc3FLVklxVnRPK3cyNDdR?=
 =?utf-8?B?VHFkUUVvdm80Zm94ZVBDWml2aXVTT2trcEcyenJiV09WVURCejU1UXlDTm8r?=
 =?utf-8?B?SXFYVVZHS0ZmL29FV2dWaGhuYlhybVVEZWdDTkRsWDdJdUdGTStQVXdlNk85?=
 =?utf-8?B?Tk8rQ0JaT2J2a0VxWTd1T3JzdjREbjRxbkl2VFdsRWl4TndaMWJ6NklqenNh?=
 =?utf-8?B?b3owbFRteEFTTlM0LzJYYW9BYVJUS2Q0bVMzYk5jQ2NkYTJuQXZod0RRWlc4?=
 =?utf-8?B?NmdVM0lFV3UwcHZwS09Sd2NKQ0N3Q1BVTkYzMjAvcFl4NjhLc1ZtVWtGWE55?=
 =?utf-8?B?YjN6SDVLZUtoVy9lRW00UVdUVitSUmlCY282dlZEakViRmNQOWFuOGhvY0JC?=
 =?utf-8?B?N3VuWWhkSDJTQkVjeUlTdjlDTVl0Qmc1ekNXUy9NekVuRXVMNGV1aElqbGFP?=
 =?utf-8?B?ZjlwWGtsVmhOZTZCK1ZzWUhGUno1ZjM5enNIejRlQ0VkMTN4Qy9UcVlva2RQ?=
 =?utf-8?B?ckZOcDJGbzNMRHU3WnRFUVpUdzZERVVCRUY1blo1aFN6YklqS0ltaW5oQUsy?=
 =?utf-8?B?UlY4TVNucTdXNTVVajRHRHpWVElYSzVvMWVHcmRLbEZKdjhTNHZwUy96SGVU?=
 =?utf-8?B?NHRWQURDRUMyd0lrQk9rMVgwSmtZQXdPTVdjZXhWYjJNdksrcTlra2lhWTdX?=
 =?utf-8?B?YXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d1ff9c50-27ee-4e3c-0bb5-08dc96ebad97
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 20:56:55.5227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fw0t14Rh8RbQMI4K9LbgRrICdQ3Y3T7FDnf4/v/17VpwKIDikaZ0AWkROjWkl4Ouec5AhdvT4SawlPS1J6/o0VnybSx3e1CulMPeFRnCJxU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5796
X-OriginatorOrg: intel.com

Hi Babu,

On 6/27/24 11:51 AM, Moger, Babu wrote:
> Hi Reinette,
> 
> On 6/13/24 20:43, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 5/24/24 5:23 AM, Babu Moger wrote:
>>> If the BMEC (Bandwidth Monitoring Event Configuration) feature is
>>> supported, the bandwidth events can be configured to track specific
>>> events. The event configuration is domain specific. ABMC (Assignable
>>> Bandwidth Monitoring Counters) feature needs event configuration
>>> information to assign hardware counter to an RMID. Event configurations
>>> are not stored in resctrl but instead always read from or written to
>>> hardware directly when prompted by user space.
>>>
>>> Read the event configuration from the hardware during the domain
>>> initialization. Save the configuration information in the rdt_hw_domain,
>>> so it can be used for counter assignment.
>>>
>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>> ---
>>> v4: Read the configuration information from the hardware to initialize.
>>>       Added few commit messages.
>>>       Fixed the tab spaces.
>>>
>>> v3: Minor changes related to rebase in mbm_config_write_domain.
>>>
>>> v2: No changes.
>>> ---
>>>    arch/x86/kernel/cpu/resctrl/core.c     |  2 ++
>>>    arch/x86/kernel/cpu/resctrl/internal.h |  5 +++++
>>>    arch/x86/kernel/cpu/resctrl/monitor.c  | 21 +++++++++++++++++++++
>>>    3 files changed, 28 insertions(+)
>>>
>>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c
>>> b/arch/x86/kernel/cpu/resctrl/core.c
>>> index ec93f6a50308..856c46d12177 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
>>> @@ -542,6 +542,8 @@ static void domain_add_cpu(int cpu, struct
>>> rdt_resource *r)
>>>            return;
>>>        }
>>>    +    arch_domain_mbm_evt_config(hw_dom);
>>> +
>>>        list_add_tail_rcu(&d->list, add_pos);
>>>          err = resctrl_online_domain(r, d);
>>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h
>>> b/arch/x86/kernel/cpu/resctrl/internal.h
>>> index 5e7e76cd512f..60a1ca0a11a7 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>>> @@ -373,6 +373,8 @@ struct arch_mbm_state {
>>>     * @ctrl_val:    array of cache or mem ctrl values (indexed by CLOSID)
>>>     * @arch_mbm_total:    arch private state for MBM total bandwidth
>>>     * @arch_mbm_local:    arch private state for MBM local bandwidth
>>> + * @mbm_total_cfg:    MBM total bandwidth configuration
>>> + * @mbm_local_cfg:    MBM local bandwidth configuration
>>>     *
>>>     * Members of this structure are accessed via helpers that provide
>>> abstraction.
>>>     */
>>> @@ -381,6 +383,8 @@ struct rdt_hw_domain {
>>>        u32                *ctrl_val;
>>>        struct arch_mbm_state        *arch_mbm_total;
>>>        struct arch_mbm_state        *arch_mbm_local;
>>> +    u32                mbm_total_cfg;
>>> +    u32                mbm_local_cfg;
>>>    };
>>
>> Similar to the abmc_enabled member of rdt_hw_resource, these new
>> members of rdt_hw_domain are architecture specific and should never be
>> touched directly by resctrl fs code, for example, from mbm_config_show().
> 
> Need some clarification here.
> 
> I am thinking you want to introduce architecture specific routines to get
> and set mbm_total_config/mbm_local_config for the domain.
> Something like this.
> 
> +int arch_get_mbm_evt_cfg(struct rdt_domain *d, enum resctrl_event_id eventid)

The prefix for arch specific calls converged to "resctrl_arch_".

> +{
> +       struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
> +
> +       switch (eventid) {
> +       case QOS_L3_OCCUP_EVENT_ID:
> +               break;
> +       case QOS_L3_MBM_TOTAL_EVENT_ID:
> +               return hw_dom->mbm_total_cfg;
> +       case QOS_L3_MBM_LOCAL_EVENT_ID:
> +               return hw_dom->mbm_local_cfg;
> +       }
> +
> +       /* Never expect to get here */
> +       WARN_ON_ONCE(1);
> +
> +       return -1;
> +}
> +
> +void arch_set_mbm_evt_cfg(struct rdt_domain *d,
> +                         enum resctrl_event_id eventid, u32 val)
> +{
> +       struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
> +
> +       switch (eventid) {
> +       case QOS_L3_OCCUP_EVENT_ID:
> +               break;
> +       case QOS_L3_MBM_TOTAL_EVENT_ID:
> +               hw_dom->mbm_total_cfg = val;
> +               break;
> +       case QOS_L3_MBM_LOCAL_EVENT_ID:
> +               hw_dom->mbm_local_cfg = val;
> +       }
> +
> +       return;
> +}
> +

I expected that a call to set the event configuration on an architecture to
also interact with the hardware. Essentially what mon_event_config_write()
does today, but in addition also sets the cached mbm_total_cfg/mbm_local_cfg.

Part of this is done by the new MPAM portion [1]. With that the post-ABMC
implementation of resctrl_arch_mon_event_config_read() may be what you
have as arch_get_mbm_evt_cfg() above and resctrl_arch_mon_event_config_write()
does the same as in [1] but with addition of updating the cached
mbm_local_cfg/mbm_total_cfg within struct rdt_hw_domain. Would this work
for ABMC?
  
Reinette

[1] https://lore.kernel.org/lkml/20240614150033.10454-21-james.morse@arm.com/


