Return-Path: <linux-kernel+bounces-333730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2041497CD05
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 19:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1359285560
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 17:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2763D1A2543;
	Thu, 19 Sep 2024 17:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iq7pbsSN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF40199944;
	Thu, 19 Sep 2024 17:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726766791; cv=fail; b=hNFCalZ1/yaKUX/gvZecSN2EdaxBMkQDReUfVWHe4qaT1DUb+gayQzvNKAqrCJIGSxR/S33ImhaSut+9yfWSfKFS/7RUcXC6kPx4oUD1DBUHBbfNA7KAlMDgNhCWg6JdsS82jUSUTJARj9tfS6J7mBJDVfWus2/RkU27h/JW1aQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726766791; c=relaxed/simple;
	bh=E77cvGGMybLiHlg7YAmGQbygR3RVn5seb+vFZK0bef8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bteR/4EPZPGB9dqR+HS37/4D4+XQfZwcUbiLPp8RMHGLIukXeF1En02SPDgQmU/TWqZEQ8aicnnGkfh0w9lwWCPf2Y/1uLBf0DT1OwwEMC0kHS6zgNytp24j/4h6hmdlgJUj4XmmGI22uAZtW4WAnCZDuT7mQByZ1pMGcObl33g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iq7pbsSN; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726766789; x=1758302789;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=E77cvGGMybLiHlg7YAmGQbygR3RVn5seb+vFZK0bef8=;
  b=Iq7pbsSNb58GGRfQ1GV+EKblLERkisxj1czl93CqfXv20DxnY44x3ofP
   KtFA12+u/qQkYUqtPkWbsfQQNlNSAgCZiwaneqmVZR+7uPrb4wNHCha1l
   HnfQbVHu4SJO14YLQBhn1RJSVSUFtI/uFIVY8qpqKyVRtQ4FY+AG5b7gg
   8GxfqNIv1wYeMYCI0/TBOQWBPunjtvmFrnVV85hgBXsxBKYefB/zlRcKF
   BhSNbc0rO4xj00s2/Kow2tcwbe2L6k34d5dRmqiLHjDxd0EieNWE6oQqc
   ztpz8d/vU+iIBKtLSGfOrCZpnVRDAGfov00fGYCBtHdicUu/893Lt401N
   g==;
X-CSE-ConnectionGUID: Sjo5eaVMR6SfDqoOHqJPzg==
X-CSE-MsgGUID: ISsg7a3dTtOlOmZsQM0EBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="25870497"
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="25870497"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 10:26:28 -0700
X-CSE-ConnectionGUID: jCwUIdd5RUuWxyz+9fFAYw==
X-CSE-MsgGUID: fhoZvP37QVWBHH2KB/snrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="74791642"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Sep 2024 10:26:29 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 10:26:28 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 19 Sep 2024 10:26:28 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Sep 2024 10:26:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dT2j8m2nnJFp7eOMsaluDbYqMRZ4kwaqovA1Md7/UxfsUluGLy/JNyNv/SHL21sxdAO+olFXP3eAzOxZoZA4dc5vtf1iE5wfz8AYg9z+yvCHqR7Jebv1HevucJST8FBoDWycfevvq5GJLUDPLvnYXSFtJNYkfFxLZzSLBc8ivUkfNCtSz99zqLM/g2c5fEI2NqNfWWGjAKcvKX5/8TqjWHe3zGN99zSDWlyQ0yug/obx6jk7SCA2zqbgUysQfczzpOP6HAWM0D3fCCG+pweYQuWStZfpfqRndlO9kx0564vd9uYQ9WJPMEQp43ubyOrIpxVYCAgMiu+GcgY0GYaCUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BHcsTwbAe04NIvlmYos5CrwaC3rM3Q/c6FTJTh1hEbQ=;
 b=wvRCVWNpIdOlu0pFQuwXPITiKbEE4CfXzPnAGQszp4yruX+nnB2Dj6Ozo6LHrNw722fJcqtWN9VN2FDAGRplOZcZIYbi6veN2ckxUwwcnvbMGN1PIFD8CAru6GU9+ayEAgIuTbGaNR4SSWwYZy/uLGkfLGyjNUK+H2+2q65mybKMN8owuOAU4Fu5ZMiuxbEwSXagFPvV9i97WLlu10pbe5xBgZah5N4zK9DbWo/Z3iyO9NTyN73ublj4/9vSckhhKCOzYCiqOtEvHdrQl55jJ2rHVVJL/T9LfGny2Cz7A+NkNpuCQVGYJH2b4N1zttX1lO+/hie5ZWf0Ea4ibHQ6Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW5PR11MB5930.namprd11.prod.outlook.com (2603:10b6:303:1a1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Thu, 19 Sep
 2024 17:26:25 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7982.012; Thu, 19 Sep 2024
 17:26:25 +0000
Message-ID: <5b22ebda-79d4-46c0-a8a1-5cefe6ff9f07@intel.com>
Date: Thu, 19 Sep 2024 10:26:20 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 17/24] x86/resctrl: Add the interface to unassign a MBM
 counter
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <fenghua.yu@intel.com>,
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
References: <cover.1725488488.git.babu.moger@amd.com>
 <91e045eb3a3b461c44f61c64b826c9e05ac75abe.1725488488.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <91e045eb3a3b461c44f61c64b826c9e05ac75abe.1725488488.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0095.namprd04.prod.outlook.com
 (2603:10b6:303:83::10) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW5PR11MB5930:EE_
X-MS-Office365-Filtering-Correlation-Id: dffdca9a-035d-49d6-7d94-08dcd8d0300b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QTltKzBCYWQwNnV5NDh1UHZhZDNUS1hXZ3RHa1NDRGkyV3VmbVd5dzJnSzdJ?=
 =?utf-8?B?eEhWd0ZYTFBSdlRZSTR2aFY4UUUyamRjR1hFZ3htTndwZE1tZm1CeVhMemM2?=
 =?utf-8?B?RjlrOXdhZzkzMVB6T2ZIU3dXb0dRTVR4UGU5dU8rSXl0Vlo4b1RlYU1URndU?=
 =?utf-8?B?NTlWNUJGNGVCQ0pGZFROT3lGWlFScG5MdXcxb1lQa3NQL04zSEJnVzRiOU9H?=
 =?utf-8?B?aUJOUkw3OVR6ZGExaHUzVWhQNWNMRzJ4TnYzN05XK0JHN2lTVUlWUEdaSEpk?=
 =?utf-8?B?cmtXaXdIZ1o5RG9pRTBadENJdnV2ZllwSE03WVJVTHpwYWs3RXFGTktyb0R0?=
 =?utf-8?B?MjcvMVAvSjFKSUVjNEdtWWNTOWplYzh0bDJOd3hjd0RjUlhiRGF0TEFZeTM3?=
 =?utf-8?B?THFDZXAxNVR2VlN6bnlBOEQ1dHpMM0puNEFkTHR1ZUsrYTd5R01QbzNBRms2?=
 =?utf-8?B?V0ZVanNiaGJoU2Y0ZkhOeHRYQnNGWjFwdXFnL09tV3NjT2E0eFlMMzVtNUFh?=
 =?utf-8?B?azB3UW0weUJadlB3bUZaNHJuYXpDOStaeFRRZ3ovY2VMcjRSV3ZjdDJpdHgy?=
 =?utf-8?B?eC9YYUlzbjlKeEN4elRIRWJ2bWJ6WmExR1pHcWNEb2IxV2pWaWVlZWNWZk5C?=
 =?utf-8?B?N2I4OWw3K29qVjVxQ0dZOTcyRzB6OElja1JxSHJSUHNLNTAvSndqM2JOdWNU?=
 =?utf-8?B?R0ZVazNxQ2hyNlFhV3l4YWxBL2hlMU16Q3IydVMrcHA0MDZUNnU1YmdCT1ZP?=
 =?utf-8?B?Sit4TUIvNWo2NDAxbVliRldxdUlyMzF4NDJpTWZGNTdNajNLeHJ0NGZYU2o3?=
 =?utf-8?B?cVNEdllzK1BJM29lbmRWL3NEdjR0Z25PZWJ1QW1IWkpoV2RSYVErTC9xVjEr?=
 =?utf-8?B?RUFBeFdLVzVPeVdtN3VNcWp4Rllhczd3UjlYeGNaRG4xdjJJSUFtem1oUHlm?=
 =?utf-8?B?Sk9xdlNFdmtFY3RCbkNHdjM4SUM1T0tCMlZuTE1zY2dFV3YyT0lQdzlsTXdh?=
 =?utf-8?B?Njd0Vy9KYmpUUUNOTHFlV04yYWRLdUhEUzNkRC90Um14TE9GWkhEQUVVVDcz?=
 =?utf-8?B?ekdGRi9HdDY5TElCdDdhUkljYkRuR0dFYi80WCtER3hTOVJ0U1N5ZEhFMS9h?=
 =?utf-8?B?KzRIei9uOEE2N21zWnVqN24reXd3QnAyMFJDV1RORHU2c0lOSW1BQ3pYNHZh?=
 =?utf-8?B?MjczMkY3TmhEZXdhNitqb21PMFYwVXJFc0h6ZHBqZDFFUEpGOEdUZ3k1SFZI?=
 =?utf-8?B?Q3ZYUmhlejYxbUdsc0JhYmpZVWN4dERaNm5wbTA4ZXZPa3BicHZzblpGYkVi?=
 =?utf-8?B?Slp1OHpoNGRlT0tZSlNMMGIydHMvNjdLbUdSN2FLUnRZL3lQRHgxS2JaYlp2?=
 =?utf-8?B?bHIrQ1hhbDAzUVA4MG5heEttbmRWdzFoUEIrNWZrNmRkMUoxMkM5Q2Y3aGRY?=
 =?utf-8?B?cENlY3RlR1BoMUk3SkwvYjJCaGNqS3hXN0puQm11ZU5SYVl6blNhWForaEU0?=
 =?utf-8?B?cFl3ejV5aysxOHBIckFlQ1Z5cTdobXlXbzRNaTFtY1JET1dMQjRlSndGUlJY?=
 =?utf-8?B?NEZUZ2x6YUc1cGlHV0ZHU09jR1o5MVdkd3pDK1g0K2RYbmxQRFozYWgvNnVR?=
 =?utf-8?B?L2ZKeHdUVDByVWl6Si9RR3VTQVBNZjRMT2xmL2ZoK1NDQWNpMTZyVUI5V2di?=
 =?utf-8?B?RzFaZVBVSTQ4NWZoZVptVlI1RHpPbVVhNnZmNXRoTVBQQ3dCOG9uUkMwNklX?=
 =?utf-8?B?L3JBakJNMmNmTU1IOWFHcFUwUTAxMGxaNmFNckZ5Wit4WVppWnV1cCtjbHJy?=
 =?utf-8?B?VytpMzh0OWowdjcxUEdxdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sjh2UE1UeG1WR291OEkrR2xxbGFHbjY3dVp4TG1ZaHIwYkRSVy9kTmpaR0Ra?=
 =?utf-8?B?ZEE3VCtHbGVKYzlFTUc4S2h1aW5FT1BmLzlhTEdPMGEwNk1Wekp0QWRkOVZp?=
 =?utf-8?B?TWtoY3RZbS9pZzZmclRMb2pha1FpODFUNDB1cUx5eWRIa2VVbUsyak5FOHEr?=
 =?utf-8?B?WVR0Q0V1bFFPdDhZUm92eVdaZmhnQnk1VDdCVzJSVkRLMS9lbVpWbCtlejZY?=
 =?utf-8?B?RzhpdGo1c0Y2TG9JbHJrdWhkR2lnNHpiNlUvOGdlYTNFaHBoaFU1TjE2Ymdh?=
 =?utf-8?B?cTNEL0VjY2h4bWY1bE1zRG5IMndTRFdjdE9VRUhQV2NCMEl1aEN0KytuYXE4?=
 =?utf-8?B?emxqVis1NmE0eXRLMDc2bFZLYTFTNmV5UWxra2Vaa2xZN0lrbEgydm5PQmU3?=
 =?utf-8?B?ZHprK3J0YnRKM2lUVWhLdzdJM21BY0JVSG91aW9KbmNLWXg5RldnbTU0T2JR?=
 =?utf-8?B?MWVsZVZ4WG1Ed296RndEZURvQ0xqNVFZcUFzRXlnZkUzV3AxNzErSGpRdmtn?=
 =?utf-8?B?VXZzNUoxcHpyNitpdFRGcERub0FMa1hKeWVpa2hjVU8wRWhvQnVnczlwVjNn?=
 =?utf-8?B?M21STkszOUtGR2ZKVVFmN29CZnE0QUtwZW1nWThKYkpUVjZrYXJONWZmalM5?=
 =?utf-8?B?TUIzRkthVUZWNENhTDdyMXRlSll1a1RSWDRMUUxsQU5lVENTWGxqWFZZc3Bh?=
 =?utf-8?B?dU8zY2tzMU1EcWhCTEs3RkdYTVo5RlhUQ0F2WnZKTkVtVk4wbHpPYVkwdlhK?=
 =?utf-8?B?eEtmYlNpZWN0RkNSUlR0WUJqWGFqZmttcXBqam5nYjZSbHFGanRtTWRheEVw?=
 =?utf-8?B?V1AwcWZURWVxc0pEQktWLzZYelJrZ3Ywbnl3RlRUZWcxSVJEVjlCcEw2bmZF?=
 =?utf-8?B?b1E3UnJyeXhhaTlMR1J0cVA0emRzTHRhWWtzTXdoSGYxL0tkRlRhVkt2ODJv?=
 =?utf-8?B?WHBLWUhjMU0rQ1V2eGlGV3ZRcEN2OEhJUGsweEFnWU1ML1kvTk9oeDlUWlMr?=
 =?utf-8?B?T0JsZXlHdmhvYUt1VFkrRGgvbzhyMktOd3ZXRFEvRTFlTXRHVmVsV044RnA0?=
 =?utf-8?B?dU1BUW92TmhSV01STDE4Y0QrTkFtS2p5Wmpodk9MNnhKanJlajgzdkhlY1ho?=
 =?utf-8?B?S1pYNWFvZWlEM2tjMnJPY09jR0tPVlBNbXdPOG9xVHpRelZMd2ZKRG1wcFNk?=
 =?utf-8?B?QWVCZi9jdUVYeXFqK3FzeTd0Q0UzbjVvZSt1RVkyWlByenRqZzlDbUhBeUtF?=
 =?utf-8?B?cTNzWGlsUzNqa2NtWm9nelBvUFZDUmZxaGJQL05EaWlxbzVZUFJvSFZHYUtB?=
 =?utf-8?B?M1c4cmZ1eDFNdkwvRWw4N05HVjV0WldSS1RYS3p0QVBjRGluSGNBWnBtdys1?=
 =?utf-8?B?Ti9uckNKWXZKcEVxbHhMZ2EyeUxOUk5aK0QrYzhCYzJJcC9FY0hxR2RZVEdo?=
 =?utf-8?B?Sk9YN0czZnd4OVZlclptMytZOXBjbzJDSGlodkpLZ1cxa1ZLRkVHcVV3Mjgz?=
 =?utf-8?B?eit1a3lDMFVOUGFsZFNPdUhNVW5oc1c4MkJwTDN0YmhGaERpM0t6RUFLT2dQ?=
 =?utf-8?B?YzI5QmpwSEhoT0s5MjJVZTJzS1JTc1JOZkU0VXhOMGNhUDV1NCtNVi9sUjZo?=
 =?utf-8?B?Q0ZBSUhEQTFFQzNRR0xxUlFlSjZjOElRTTVjSUpwVUIyOC9HS05qaTVJc0FV?=
 =?utf-8?B?VVRsMHg0b0E2SWpPREJySVZFc0d6cFZvR05rZnZTSkVKYTd5ak5jNjVxSERS?=
 =?utf-8?B?dEQxOERKMGdjdVc5WXNIb3NZMnJtSFdkdmV0QXVaU3FndWxjcS9NNWNsMCtJ?=
 =?utf-8?B?c1JET0V0T2xENG1jNjZzWWRQUEcwZnBLK3BienJ5V1R6emdRVnhOenc1SlRl?=
 =?utf-8?B?ZzV5WFlJZWNrN2hITExJWWJ3dk1xZ2U2YzdNRkVPTCtLTHl2ZitXUk1iVlN5?=
 =?utf-8?B?YWorN3B2eUVkOVVsaTd4a09mSU9YUXErN1VzTTd1dzZrWGh4QnpUUmh5RXkx?=
 =?utf-8?B?QlJJdkNuTVlUNHN4dE9TdTNka2tianJ1TWFDWnV6aThMQnoyOU03b3JDalNl?=
 =?utf-8?B?eUVZanhwUHc0U2JveHp2SnNHYkFLTkFrVDFmcndCNzIyRFlQL21pY2tRRmFy?=
 =?utf-8?B?elhNdWZzbFZSVmszQTd4YWY1Q08vTzZLUU4wa1NuNDRLazVreENVYlZieXhI?=
 =?utf-8?B?eXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dffdca9a-035d-49d6-7d94-08dcd8d0300b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 17:26:25.1942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AeFdX6zNt2wQ6I//lPrJ0PRio+n7rLNsitG6fzgnpDRl+EyJYsn22bFKMoPeFwjG0jb8HZ5P1u/OBQkIstRJHS2rRYs8XYQYYH5RYB2wNTw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5930
X-OriginatorOrg: intel.com

Hi Babu,

On 9/4/24 3:21 PM, Babu Moger wrote:
> The mbm_cntr_assign mode provides a limited number of hardware counters
> that can be assigned to an RMID-event pair to monitor bandwidth while
> assigned. If all counters are in use, the kernel will show an error
> message: "Out of MBM assignable counters" when a new assignment is
> requested. To make space for a new assignment, users must unassign an
> already assigned counter.
> 
> Introduce an interface that allows for the unassignment of counter IDs
> from both the group and the domain. Additionally, ensure that the global
> counter is released if it is no longer assigned to any domains.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v7: Merged rdtgroup_unassign_cntr and rdtgroup_free_cntr functions.
>     Renamed rdtgroup_mbm_cntr_test() to rdtgroup_mbm_cntr_is_assigned().
>     Reworded the commit log little bit.
> 
> v6: Removed mbm_cntr_free from this patch.
>     Added counter test in all the domains and free if it is not assigned to
>     any domains.
> 
> v5: Few name changes to match cntr_id.
>     Changed the function names to rdtgroup_unassign_cntr
>     More comments on commit log.
> 
> v4: Added domain specific unassign feature.
>     Few name changes.
> 
> v3: Removed the static from the prototype of rdtgroup_unassign_abmc.
>     The function is not called directly from user anymore. These
>     changes are related to global assignment interface.
> 
> v2: No changes.
> ---
>  arch/x86/kernel/cpu/resctrl/internal.h |  2 ++
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 49 ++++++++++++++++++++++++++
>  2 files changed, 51 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 6a90fc20be5b..9a65a13ccbe9 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -707,6 +707,8 @@ int resctrl_arch_assign_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
>  			     u32 cntr_id, bool assign);
>  int rdtgroup_assign_cntr(struct rdt_resource *r, struct rdtgroup *rdtgrp,
>  			 struct rdt_mon_domain *d, enum resctrl_event_id evtid);
> +int rdtgroup_unassign_cntr(struct rdt_resource *r, struct rdtgroup *rdtgrp,
> +			   struct rdt_mon_domain *d, enum resctrl_event_id evtid);
>  void rdt_staged_configs_clear(void);
>  bool closid_allocated(unsigned int closid);
>  int resctrl_find_cleanest_closid(void);
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 1d45120ff2b5..21b9ca4ce493 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1944,6 +1944,55 @@ int rdtgroup_assign_cntr(struct rdt_resource *r, struct rdtgroup *rdtgrp,
>  	return 0;
>  }
>  
> +static int rdtgroup_mbm_cntr_is_assigned(struct rdt_resource *r, u32 cntr_id)

Should this return bool?

With function prefix of "rdtgroup" I would expect that an rdtgroup would be one of its
parameters but that is not the case ... this is nothing to do with a rdtgroup.
Maybe something like "mbm_cntr_assigned_to_domain()"?

> +{
> +	struct rdt_mon_domain *d;
> +
> +	list_for_each_entry(d, &r->mon_domains, hdr.list)

Based on function name it is unexpected that it checks the global bitmap and not the
domain lists. The function really needs a more appropriate name to reflect what it
actually does.

> +		if (test_bit(cntr_id, d->mbm_cntr_map))
> +			return 1;
> +
> +	return 0;
> +}
> +
> +/*
> + * Unassign a hardware counter from the domain and the group. Global
> + * counter will be freed once it is unassigned from all the domains.

Could this also get a similar comment as partner function about special
meaning of NULL domain?

> + */
> +int rdtgroup_unassign_cntr(struct rdt_resource *r, struct rdtgroup *rdtgrp,
> +			   struct rdt_mon_domain *d,
> +			   enum resctrl_event_id evtid)
> +{
> +	int index = MBM_EVENT_ARRAY_INDEX(evtid);
> +	int cntr_id = rdtgrp->mon.cntr_id[index];
> +
> +	if (cntr_id != MON_CNTR_UNSET) {

Function can exit early after the MON_CNTR_UNSET check to reduce level of
indentation in rest of function.

> +		if (!d) {
> +			list_for_each_entry(d, &r->mon_domains, hdr.list) {
> +				resctrl_arch_assign_cntr(r, d, evtid,
> +							 rdtgrp->mon.rmid,
> +							 rdtgrp->closid,
> +							 cntr_id, false);
> +				clear_bit(cntr_id, d->mbm_cntr_map);
> +			}
> +		} else {
> +			resctrl_arch_assign_cntr(r, d, evtid,
> +						 rdtgrp->mon.rmid,
> +						 rdtgrp->closid,
> +						 cntr_id, false);
> +			clear_bit(cntr_id, d->mbm_cntr_map);
> +		}
> +
> +		/* Update the counter bitmap */
> +		if (!rdtgroup_mbm_cntr_is_assigned(r, cntr_id)) {
> +			mbm_cntr_free(r, cntr_id);
> +			rdtgrp->mon.cntr_id[index] = MON_CNTR_UNSET;
> +		}
> +	}
> +
> +	return 0;

This function is called many times and there are always paths adding complexity
to handle error from this function ... yet it always returns 0. I expect that it should
actually do error checking of the arch callback that could actually fail on other archs, that
should impact this function's return value and make the need for error handling apparent.

> +}
> +
>  /* rdtgroup information files for one cache resource. */
>  static struct rftype res_common_files[] = {
>  	{


Reinette

