Return-Path: <linux-kernel+bounces-290342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1573A95527B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 23:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B3201C20E29
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 21:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA1B1C461E;
	Fri, 16 Aug 2024 21:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YzQHFZdf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5512F136E21;
	Fri, 16 Aug 2024 21:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723844142; cv=fail; b=CvUVRf+jOx3wGienT8RVgd399B5lAlULRReGglvh7iuE01MQL3kntoS/2gIajK0xKC2Y49FxoPWG+UpHkFwSvC8pMjL6O0XOKDCwo2bb4elqrEWdH+wBzmTElxYBEdyvZ4T/7iCUm3Cj2gLX3/Ak76CYTobSs86okP7OsuBKRsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723844142; c=relaxed/simple;
	bh=tD5ZRRouLUcRxB0iv/dJ2oDxx5VBLo742Ml8ppuYKO8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j+ingRYO/I31MlpzMltplP7zL73jh6bC9n/2QGBayGl1xdXtqbmZ4kbLHPgUXFr3JfgAKxz8iQgWJ+lhZlVI1xQGxZ/e4XgaOWWNlR3Z2jEuuhiuqdGdkFQwynDDXUEXnUQW4PMF6QpHFnd7pdCBwXD1XD79eGHAMdPjQNs7ZNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YzQHFZdf; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723844140; x=1755380140;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tD5ZRRouLUcRxB0iv/dJ2oDxx5VBLo742Ml8ppuYKO8=;
  b=YzQHFZdf11qgvWzMYLzUKTr9Sv3Oabf2Pgxbao/2v5QcDxFQDKyla5oE
   ra+kJcWsdYvDEU4ixv544/KAtkUIpvB0Akuv7t4yH9gN+u7dg/tTjz1O+
   fX9J5DqHb7luL76GTtsU4n5qs2my/yWLMrMsOh8IvL6K6GsQmnwoF25jf
   YfBoUXA2wlM+pyPuPjTHP0phKQgLtFKGNcrcUWnSkjiA0V4Bif3HWqrgM
   hqvQgI+h0uv0qtmHiRAmoiUx+jTBZ+GyyrzE2+COROn1YgY5LVTDHVpjc
   59jySdw6NSBG2r0O1kp0oxFEs5Vgso0MzKzCJNkI3kQYFYeqqomUsQnvg
   w==;
X-CSE-ConnectionGUID: oY6RtXWxTMiLaqG2oKOCiA==
X-CSE-MsgGUID: aJ8W9NKbSDW6D66wciEI6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="25054602"
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="25054602"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 14:35:40 -0700
X-CSE-ConnectionGUID: zdnY2PcCTjO9AbhBAiJRMg==
X-CSE-MsgGUID: YTJTfprLRnmxN1zksR8i4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="90556233"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Aug 2024 14:35:39 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 16 Aug 2024 14:35:38 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 16 Aug 2024 14:35:38 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 16 Aug 2024 14:35:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H36PYX6hQNm1DXjCrqKjZfUedQASWnEh8CC4RJfD2nR/GbjBx8vV3pI3XQs4dfrpCuX0OLW+lf7W4bVkHf5QBaaiW/8h/kLqXWp135LJHA5r3Cd6rar/gjIkrGouONl/cS4JeuppqcPio6EE5y3mEuGq/NOQNte4NU6I2uZq1mpJRjMK9PX8nlNfe5glRQEf+BpM3nKhJOrVf8XeUGscY+zbaqzfwLSL63u9VucVBM5eDPHTx/ohjrZKHwiW3SHR4lIqFj1FzYMRVr/2KdX0GSl/4rlcK4Iis8Y+fQ+rOyiJhZ2WWNoU8JGtkgk/zRigc8tvMEg3hAHfv7YjYVlPNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OccYF4HL7zP2l6vkbDRIjXzPjWoEfpWsxCSOY82RJ7I=;
 b=a1URgYVTjzCBCxE0OQya+ewVDz4N8wQ1Nhvd354KlKm0JY+gF52IPuFTc//FFghnhWMhkQgWGzT8RQEJcWcXBgejlP3wo2ICazVJQJZNFyk4Q3IZIqmb50a2DTSr1VzKTuqHVi9MWEEvscKEeqsW/8x1c4xWbPWYj52vd8rM+a3TzalsL/FFFC06A1GSQSZcW+5fU41aEyaVpBM2LSGpvK3B9oJHOd5P9lUohwkWHp8CKBAxNaxe7apgymSeoZ9h4TrhP4wY/Wbs7Ks59Mva1TTo32n+UuNey0k6ibRaMOodSJjV72ZLlwbaGmnYYShQfBWiXloLRC8X2uLJRC9ZbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SN7PR11MB8112.namprd11.prod.outlook.com (2603:10b6:806:2ea::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Fri, 16 Aug
 2024 21:35:33 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 21:35:33 +0000
Message-ID: <8e6143e7-008b-4c9b-90d4-b2a8a56bb158@intel.com>
Date: Fri, 16 Aug 2024 14:35:30 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/22] x86/resctrl: Introduce MBM counters bitmap
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
References: <cover.1722981659.git.babu.moger@amd.com>
 <2bdc7920f9dfc24994fe280649cf26dc566a7a90.1722981659.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <2bdc7920f9dfc24994fe280649cf26dc566a7a90.1722981659.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0172.namprd04.prod.outlook.com
 (2603:10b6:303:85::27) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SN7PR11MB8112:EE_
X-MS-Office365-Filtering-Correlation-Id: b2545cc5-a779-4e56-a7aa-08dcbe3b5bf1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RHhvM2grbThnNGFYci9EV1lFUFFuVFVqMHJJYUs2UDg1UG9udzVSak9IWWkz?=
 =?utf-8?B?VVk5N1QrNDZmcVMycjEwTWszbDIwd1FNYTVITHpvZGJPcm5PaFQxcUJBVysr?=
 =?utf-8?B?dnpqYVRvZGJkVk9Fak5FRkVNaUxmcnNOV0x5RkFJWWsrZk0rVEtEV2lMUWp2?=
 =?utf-8?B?WndRVkNYMWFlSGpOOU14ay96Mk5kYUN4Nk5NRHlUbzMyZkNqUWFvb1BWbERP?=
 =?utf-8?B?WXpHSy9ZSDRTc28xOExuMHUrTmJsSTczK0U2azIxSGJaMHF2VzRiVEJOaU9Q?=
 =?utf-8?B?Wkh4RFNOaTlFS01jRWZDeDNENkFhZnllcjZTKy8wYm1ZeFg0TFpBeCtFR2JT?=
 =?utf-8?B?QnAxci96bXlvL1I4UkI0eU41ZktCM1FNNnNOUFE5LzZOeUduNk1IWmdDakpB?=
 =?utf-8?B?NGgyYmY2eVVhdEtMY3pRcUdaWlFLNU1tcENsUnRPTlVETU80TExjZGZHbjN3?=
 =?utf-8?B?R0NlNXJIcjdBMTgzUDNCOFhvV1RvSXFjU0hIYklmU0FXNUwwaXRORFVXVk1F?=
 =?utf-8?B?RWJSZ1lKdHBVUFdSOUtHYThvbzBubnFwSDhmR1g5KzM0VXh3RWdsdWZUeWgz?=
 =?utf-8?B?Q2F5eGNOanplZnN6TUlvT2FpNWxZZG9qNmRsNUZoTmw5UmNDeWdDMXRXM0hI?=
 =?utf-8?B?bGpUc0FlL284V2dpOXhBNy9KbDVUb0Ribms4NFNJOVQ0QkljSzNyZ3FySC90?=
 =?utf-8?B?YU5ZSFRRK2QxeExEbWk4OW01OEFHdVd2bXZTR2xNSThuNjhNTTBvZ0ZMMzIw?=
 =?utf-8?B?a2NmYnJUWjROZnRJNDZub3NZS3RBZThMSzYxVURlUWcyRzBSQnNpYnRVaVdR?=
 =?utf-8?B?NVJYWjR0RXpWUHlrVkNncXZzLzlWS3p0V3F4ZVZGK0FiYVpld1dPM0UwZisy?=
 =?utf-8?B?T2Y2MFpSVGcyNCtXbDZzNTNnUTBGcWdtdnQ2cEZsUGQzSEpMZDZ2WWxkVlJx?=
 =?utf-8?B?QTBoamp2c0lUQjlnRzZKRm0rUUQ5VkQ0R2c3MjFTT1FyVkN4R212NjR1aHM3?=
 =?utf-8?B?REVLRGVJVzNCZmhWTEozMU9lYVZiQmN5dllYSnE2VWFEdGYxMVUweGZWRWhL?=
 =?utf-8?B?L2daS1A5MmtnYkFqenNkcmwvd0IrdWNDMHE0cGNJUHgwSEN6VXFWbm5lUGo2?=
 =?utf-8?B?VE9YazJZc1pYcTR2YWUwSU5la281NTkyUUNUOFI0RDJGbVcvRzNpL3FGS3Fk?=
 =?utf-8?B?b0MxU0l5TXU4VVlRMVZTN2R4MlJYWnhwenFoV3ZVdlFuelpzUXRWcGJwejBo?=
 =?utf-8?B?TFJBNWJOK0svOUFuUXdKQnFqSjRLNGdqcXB1eVFHV0ErT3puV0FDc1NUSWJt?=
 =?utf-8?B?T3hLcmo3THBRelVxZVFKaEd1aGlmR0cvN3ZEcUtXODFuWkFUa3VOZlA0VEQz?=
 =?utf-8?B?bzRGaU50Y0VKaUVxalRmOStBQTcxVHRONGlCWGx5aU9rMWhHSktoRDBLRXUv?=
 =?utf-8?B?WFR0Rmp2RmZ3UldjWExLUVRpenpoVkxxeUNwOGdRaUNEamM3Zno5ZVhnRlFn?=
 =?utf-8?B?cHB3STNCdmZIZ1hiY05Qbmt2ekZNb2liZU5VUDhDekMySDZTMDdSc0NlVTRW?=
 =?utf-8?B?ZkwyYWJjREZNMmFIVGY5dWhVd1ZMdGxPQUpiUXVlYUQ1KzVHKzRRUzMrTWhl?=
 =?utf-8?B?SzlSTjBtY2RiU0VOUWZpd3BHVm9WTFJ0dFV4c1orMDhneVo5YXRCakRWWm1D?=
 =?utf-8?B?U3BUenJjWkVNeFE2WUQ5ZDhmY0x0am03b0lkNEFHYkZwbGpuWTFvc3pPVTRn?=
 =?utf-8?B?NEIwQW5JRHl5b0UzTkY3Ujg5dyt5WGlxQmZLRTFlQitsTFcrN2tlWjRMM1pk?=
 =?utf-8?B?dlF6VWJUa0gxSFBwUkdsUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDIvU3JxQTRIK0hnWEtCYUswMTR0MnEvempjSGlCVlpEN05ZVnB1R2ZDK3Vl?=
 =?utf-8?B?Nk9zc2drNHQ0YUQ0QldCOHEwZHFBS3lCa1dLWHZER1BKODhNUzdKdjVzMGpz?=
 =?utf-8?B?ODk3c24zc1FmYXJCRHdNM3FVN3VMd3NQVHlQWmk2MzUwWXZVcTNqVm5EaWo2?=
 =?utf-8?B?TThJeEl4Vk5aS2pFQS83ZWlSYnY2cVlmSElNeGx1Y3R0eVJTZW5tK016S3ZL?=
 =?utf-8?B?bjZaem5RQjhrZjJnMzRCQjd0ZlAvS0R4dWpFNzRrMndnWHZ3Wi81SVcycW9N?=
 =?utf-8?B?elBzRFJBVk9rdGJCRWhjd2ZGYWNCWndVMXlqL01GczBNY0lVNnBWakg0STEx?=
 =?utf-8?B?Z0U5Wm9qSzdXREZobXhocXlNVWszM2RzcHZPQkZsUUo5T0t2K2JhS3lRVEF1?=
 =?utf-8?B?ZXNFR3R2bDZLUUxUZ1NxVVViQ0JTcks2RFRFRjVjd29jQlRvRnlVMWlzWFkr?=
 =?utf-8?B?UXROYjhhVU5HL2FDeVdEM2RpWlRaelg1bGE5VXpDazB5RjZOM3dGb0JhVjlI?=
 =?utf-8?B?R2JCdmJvcXAwWFFFKzdSbzdmSzkrNkVZdkxPV0h5ZmkxL043T0JyQWF4cHRS?=
 =?utf-8?B?TXNPRHF1SXBBSXRSSC9RN0pta1QxN1lZbWhxelJoTlppaklhK29GZGdoblp3?=
 =?utf-8?B?aFlXcTlHTWlkd3ZLMk5HckFYVStCeFp0QnR3UlpybEd5M2s0TWE0RWJUUzZQ?=
 =?utf-8?B?OGhZUjVDakE5Q3hvK0JIQ2xsMEw0SFYrN1haVFl0NDFUaUJOSGdROC9JOUxx?=
 =?utf-8?B?MjV0MERqSXlwSnR0SkJ4M3NTSUpBQ0FTUk80R1J4aThyNTJCV1NZWE5scWVH?=
 =?utf-8?B?TWk5YlVqSzB0bXd2bldnYnFQSTRqR2xSSDFLNDI4RHl4aDVPcEs2ZmlxQ3NL?=
 =?utf-8?B?amFlMEp4cXpBSE0zdjIyQ3pDQytnVjY4WkluQnBNOG5td3YrYThqS1lBRkhM?=
 =?utf-8?B?RUwxa1hPUEhheGZMR3hkRThva1ZaeEZGSG4wYjZjeHNOZStadnQwU2NMVEwx?=
 =?utf-8?B?MVVZT2hlZ1hRTTdwVjBHWE5JNUVkdFVMSVFCWWVqN3E3YmI5cXkvc1lPYzlB?=
 =?utf-8?B?blQ0a1hNOEJEbHNmUElOSDgwK0x1OUhORk5VcUJCQlh0N1VYcjNFVFZuQWlt?=
 =?utf-8?B?M1RMUk9XbE9YTUd0WksrTmR2cXNod3BUT0J0NnlyLzRKem9CTU4wUTF1b1V2?=
 =?utf-8?B?N3dtd2pOUUUyd2FiN1F6Tlp5TVB6NlFWbXVyd2RCWkNRY1JqT1FXcTdxZ25y?=
 =?utf-8?B?cjFjM0poT2cxR2lGNjB1MHI4aGhDZG9qSERSQU5kRUhrdmx3TEZnK3FKYjlM?=
 =?utf-8?B?WUluMHlkYWhvQ2dEM1JNTURSR3MzR2VrUWhwMlMwUElOWTlFYmEzKzk5T0Jy?=
 =?utf-8?B?QXMycmtHRzJxUi9HbFVGN2RSblhsc2dHamt3cVpFNHlpY0JoNGpyQUluU2xJ?=
 =?utf-8?B?ckNQNzdNa2VhVlBwUXlmUW8ydTdoZ0lqSUM2SHBUclVNMW1vVjZqTGpMbXVG?=
 =?utf-8?B?Wll2dWhYbFFHQnVqc0hZK1dtdW9Sd3dqeSsvS1pCREk4WUNvN1RYODJ0SjBV?=
 =?utf-8?B?N3ZheUdFOVF2a2hVWU80L2k3UVQyakxaMi9aVlpJaWxQTS9XWEpPR0Y3OUps?=
 =?utf-8?B?bkVGTHFXaTRKRnlHZXlmUC9zS1VXbTFKYyt1djRrTmIxRDM3azk3YytHYXB2?=
 =?utf-8?B?cE83MVRNV0tIRXl3TFlsZ0xvc3BON0g5R0pPUklKdVBGa1pyN2dQSXkrbnpu?=
 =?utf-8?B?MWdnTWtOc2pVU0xuMjE0S2Q1elFnbUR6MXVsbHRMNWY0bGRIU1Fuay9qdzVP?=
 =?utf-8?B?V05GSGdGWHo5V0duYmpVRkd6NytFS2N4V0xTR1BjWFc5VU5iVHB0M1VDT0dj?=
 =?utf-8?B?d0RNSmdxM29NMlBzN0YwSlM5amdRU1A4Qkh1Y0dndmx6anlEaEdUa2I0Mk85?=
 =?utf-8?B?L2JUUzRkTXlnTVZ6MW93eUliQkxSczFwcTRtRDkzQXRYbFFBR3FjZnhDZ2pY?=
 =?utf-8?B?WHNqeHgzdnBaKzNRR3JBRHZ3WC9CdXU3WkpjTlJENjNHSy9DbU8zNWNRQlA1?=
 =?utf-8?B?aktNTWRma25ITEYzNnNTMFZ1b2MrWnZ6Q2RJbm5MS2wzTUhGT2ZLQlpHZUdv?=
 =?utf-8?B?dU1BRnpDc0ZMNXR1dmNUWjF1MEI3L1ovbjBMYVAwcWNoZ1QyNksraWlhcGxW?=
 =?utf-8?B?ZVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b2545cc5-a779-4e56-a7aa-08dcbe3b5bf1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 21:35:33.6050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AZQ+5JoGqUqAajmAh3od9H3eFtJ/ny7gHZW4VqVaWEA7c7t9HDxmBqslWiKAYrHhIGezy+lhcOzW3Xl3SMuj5/7R4WxoHUaGsdjIjNo2sTQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8112
X-OriginatorOrg: intel.com

Hi Babu,

On 8/6/24 3:00 PM, Babu Moger wrote:
> Hardware provides a set of counters when mbm_cntr_assignable feature is
> supported. These counters are used for assigning the events in resctrl
> group when the feature is enabled.

"in resctrl group" -> "in a resctrl group"?

> 
> Introduce mbm_cntrs_free_map bitmap to track available and free counters

What is the difference between an available and a free counter?

> and set of routines to allocate and free the counters.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

> ---
>   arch/x86/kernel/cpu/resctrl/internal.h |  2 ++
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 33 ++++++++++++++++++++++++++
>   2 files changed, 35 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 154983a67646..6263362496a3 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -662,6 +662,8 @@ void __check_limbo(struct rdt_mon_domain *d, bool force_free);
>   void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
>   void __init resctrl_file_fflags_init(const char *config,
>   				     unsigned long fflags);
> +int mbm_cntr_alloc(struct rdt_resource *r);
> +void mbm_cntr_free(u32 cntr_id);
>   void rdt_staged_configs_clear(void);
>   bool closid_allocated(unsigned int closid);
>   int resctrl_find_cleanest_closid(void);
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index ab4fab3b7cf1..c818965e36c9 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -185,6 +185,37 @@ bool closid_allocated(unsigned int closid)
>   	return !test_bit(closid, &closid_free_map);
>   }
>   
> +/*
> + * Counter bitmap for tracking the available counters.
> + * ABMC feature provides set of hardware counters for enabling events.

"ABMC feature" -> "mbm_cntr_assign mode"

> + * Each event takes one hardware counter. Kernel needs to keep track

"Each event takes one hardware counter" -> "Each RMID and event pair takes
one hardware counter" ?


> + * of number of available counters.

"of number of available counters" -> "of the number of available counters"?

> + */
> +static DECLARE_BITMAP(mbm_cntrs_free_map, 64);
> +
> +static void mbm_cntrs_init(struct rdt_resource *r)
> +{
> +	bitmap_fill(mbm_cntrs_free_map, r->mon.num_mbm_cntrs);

Apart from what James mentioned about the different sizes, please also
add checking that the resource actually supports monitoring and
assignable counters before proceeding with the bitmap ops.

> +}
> +
> +int mbm_cntr_alloc(struct rdt_resource *r)
> +{
> +	int cntr_id;
> +
> +	cntr_id = find_first_bit(mbm_cntrs_free_map, r->mon.num_mbm_cntrs);
> +	if (cntr_id >= r->mon.num_mbm_cntrs)
> +		return -ENOSPC;
> +
> +	__clear_bit(cntr_id, mbm_cntrs_free_map);
> +
> +	return cntr_id;
> +}
> +
> +void mbm_cntr_free(u32 cntr_id)
> +{
> +	__set_bit(cntr_id, mbm_cntrs_free_map);
> +}
> +
>   /**
>    * rdtgroup_mode_by_closid - Return mode of resource group with closid
>    * @closid: closid if the resource group
> @@ -2748,6 +2779,8 @@ static int rdt_get_tree(struct fs_context *fc)
>   
>   	closid_init();
>   
> +	mbm_cntrs_init(&rdt_resources_all[RDT_RESOURCE_L3].r_resctrl);
> +
>   	if (resctrl_arch_mon_capable())
>   		flags |= RFTYPE_MON;
>   

This is also an example of what James mentioned elsewhere where there is an
assumption that this feature applies to the L3 resource. This has a consequence
that some code is global (like mbm_cntrs_free_map), assuming the L3 resource, while
other code takes the resource as parameter (eg. mbm_cntr_alloc()). This results
in inconsistent interface where, for example, allocating a counter needs resource
as parameter but freeing a counter does not. James already proposed different
treatment of the bitmap and L3 resource parameters, I expect with such guidance
the interfaces will become more intuitive.

Reinette

