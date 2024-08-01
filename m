Return-Path: <linux-kernel+bounces-270820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A3A9445B5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 09:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04C291C21212
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 07:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AF416DC12;
	Thu,  1 Aug 2024 07:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D08vy+bV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B81916D9BD
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 07:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722498270; cv=fail; b=Seipyc49iFqpPlBUYGwpLTe97s2Lpfs6vwFJ/ZlWJg9j15X69lqXm8NHQAD3pns1saoHw7dowH6+4OaUbtC/swb9xupamP73TF2G8aKkPf+hyrDz8FSZTt5ZnjVRyrPQ0ItV5lHmrmS6U6TH/MrbFwd8bNGsPS0CgczpzsiqRVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722498270; c=relaxed/simple;
	bh=KiGWXN2IUrpyHrDdTjIQBuiGYHqR7UGYSz9x1JuCfgc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tBoj6whXu3tn3uDfkJ+hecEJJkxVW7s9wNYncHq3ZJZBhAjDKfrg0SYLw32Ulaapk7XpL5CCFYafGl2R11/K0iAxTa2W6dP4mp+mBBRMG1CEaR2xTBaA2nuXmmDZnPhXxawEk8m1xln6D6PiLkrFVV4A1NeLj1J5XYIMfTAh+ts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D08vy+bV; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722498268; x=1754034268;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KiGWXN2IUrpyHrDdTjIQBuiGYHqR7UGYSz9x1JuCfgc=;
  b=D08vy+bVZOZ2Uu9UCUNFIXhB9h9tMMuJjFi+NGfqQK6hRHPtjBvAxsXc
   ZzSbKbnViL0+yebyh25w+tmPWU40KUJCsXnykrmal/wuicd2dHNJJ5TUZ
   3OfbMmSsmUIG5LDmUAij5RxkF3rg10nER3A5B/KxhgsSsbB46Q4Mo7XVq
   qvqOnF3f0YZn0HSV2Man136HcEWDSRw0LWh7ZHPMFEPofQleD8rV70b2P
   DKrfDzzF+OJwqfon3g4Lh5EFjdrH3tRYPTufMmECmf9c4SPn3m5Rzhhh5
   qGw375wpSr2UJ3b1W0bQqNCTJ6xDSuCGH3LG35Fa/2bRtGdua6mFr2mfH
   A==;
X-CSE-ConnectionGUID: WBJa8wB7RjexxrpT8qgKsQ==
X-CSE-MsgGUID: MPSEk54FQmObGFX76GWTZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="20592540"
X-IronPort-AV: E=Sophos;i="6.09,253,1716274800"; 
   d="scan'208";a="20592540"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2024 00:44:28 -0700
X-CSE-ConnectionGUID: m+vWHBxWSXSCIX1M277coA==
X-CSE-MsgGUID: /OYViqefQ4+NBNenLCjm6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,253,1716274800"; 
   d="scan'208";a="59601838"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Aug 2024 00:44:27 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 1 Aug 2024 00:44:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 1 Aug 2024 00:44:26 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 1 Aug 2024 00:44:26 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 1 Aug 2024 00:44:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mcP+SoKw0bDEJ1bqSi4ptPLxghR2CNWl7L1wRLCMR+WMkuQtVUVcteN505HNBu5S2kH/ybEWzWdu084A1bDw8L8WdCJVvkpG0MslojEZW48pyVw4wTfvutrnSMCcVyE5K9CyMQYYY7drmECPMmSWXtp2oyuhsQ9tF4UUlEj9p56sdan1l+JQDz5t2adR9Utt/lhogxWm1Y8630S4Z9bGKzhJ4asl62kP9CQnH62Ld5xtADUOORiELV3wgcM82jkDiFSpA37cHtUY8bB0C4szy9Fgk9N913B/fXGqsXlPjcwib1e4ATn7D3TgTBMZOTAbBO7VQdIdsA8YdaKR72kkIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kkqi+wcldnCTkAVsXFPbTLWeTOER4b4hT1V0zaF8iBg=;
 b=h0sWG7/UDTPe0hItO58MFCujldnvqOUkosCbwRbVW2/uzAihK+alH+y/O+L3lmOJmHGnaOxnUXQoSmq+U5s1XDBtp5XfYV2M20Sd0cJVn5rpr5PdkOoNb2Fe5s39K+gFy7DuvfVORX+zFdqU1SWjkF5JqBdFgHQ7ZE8dTYcwm3Hy8vxiMbVdpQ0SF5h18lZGX3Kv2cWCegdYVSzIYvp7VHMkOAj3u6A/hJ5Mx396kPyAGACVZ6Y0mdZHStR5+/IwmPoFyVpU7YAA21F88nsPmt2+qMn9ZYfKPDyxlrtszP+KzRtUKTF+fm9eORUGDpk8WGqzRVlm5VZyvp8Demgpuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Thu, 1 Aug
 2024 07:44:23 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::47aa:294c:21c9:a6b8]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::47aa:294c:21c9:a6b8%4]) with mapi id 15.20.7807.030; Thu, 1 Aug 2024
 07:44:23 +0000
Message-ID: <99a5e8b5-6040-4de7-a185-7a39c16ae0fa@intel.com>
Date: Thu, 1 Aug 2024 15:44:13 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [linus:master] [mm] c0bff412e6: stress-ng.clone.ops_per_sec -2.9%
 regression
To: David Hildenbrand <david@redhat.com>, kernel test robot
	<oliver.sang@intel.com>, Peter Xu <peterx@redhat.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Huacai Chen
	<chenhuacai@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, Matthew Wilcox
	<willy@infradead.org>, Nathan Chancellor <nathan@kernel.org>, Ryan Roberts
	<ryan.roberts@arm.com>, WANG Xuerui <kernel@xen0n.name>,
	<linux-mm@kvack.org>, <ying.huang@intel.com>, <feng.tang@intel.com>
References: <202407301049.5051dc19-oliver.sang@intel.com>
 <193e302c-4401-4756-a552-9f1e07ecedcf@redhat.com>
 <439265d8-e71e-41db-8a46-55366fdd334e@intel.com>
 <90477952-fde2-41d7-8ff4-2102c45e341d@redhat.com>
Content-Language: en-US
From: "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <90477952-fde2-41d7-8ff4-2102c45e341d@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0085.apcprd02.prod.outlook.com
 (2603:1096:4:90::25) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|IA1PR11MB6097:EE_
X-MS-Office365-Filtering-Correlation-Id: cf981d4f-c9a1-481b-4161-08dcb1fdc2cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cEdkcGJRbHVBdjl5aGpXQlhXaVB4Zm0xbXc0ZlRkcGljWDVSV1hvN0M3bmMz?=
 =?utf-8?B?eVFmSDFVVkN0TG9PYjhqbW9jSG5VZHBnL1RQNEJUZUN0UnYyVXd5azdqRVpR?=
 =?utf-8?B?Y0d1L0RWMzhiQkhUbXZiRUlmYVlFSzJPWU43WnAwV2dFT3NDR1FoK0ZSckpx?=
 =?utf-8?B?cUhMaVJyc0lFVkRsTWRXVmZoMTBhbzVCVy9sOFp3WDBzb1dZRjVVSUhwMmpS?=
 =?utf-8?B?MWpGMlBnNnlRN2NScTN5enZsRUkrZE1GekJucHgzTWk2aHNBWE9MZlVnUGhW?=
 =?utf-8?B?aE1sQmRrMGUzSXBJQzk0MnJtMHBqSk1za1pNQUtrSEoxU0ZuREIydHE4aE90?=
 =?utf-8?B?N0hlTEw2ZGNoZzBET21rWUZYMi84bHZDaXRzdkZBODlpbTNiR0JCZE10R0Q5?=
 =?utf-8?B?eEw2aVM3UjVCQWg3eUZTMVJxelk2emMyaUt5blE5M05mamVqV1l4WGwrTWpN?=
 =?utf-8?B?RkpZUENvZG1HQlJyVXdCNE9kTjRtY1FlYWJ0Rkh2MHY5VG1TMXR3Q0cxdTdt?=
 =?utf-8?B?WkVLQjN5S05qSGJ5d21FTkpjc1BJdUZtZWNzNm1ITlo4WDFhOXpJNzJwbERW?=
 =?utf-8?B?NUFuNXo5bE41cUQvL1RDOUFlZ2RzUkZnaEV1UkRkVDNiMktrWWVTd0UvOWFK?=
 =?utf-8?B?dTZORFQ2WmhobUxqZTBYcDBZNWY0Q1JoMTNmcHZ6MkN4UjJkNUR2TEtJRE1n?=
 =?utf-8?B?SXVqMFNPWjhBZTkyK2Fua25yeTUwQ3FIT0EvRTlYeEVyTllabVV3N0kzUytP?=
 =?utf-8?B?YzYza0xkM0VHMnlkWG0yK2xGdXF6WVJ6R0NVaUl2YUU1QXIvazF3dTYrcEg1?=
 =?utf-8?B?WTlCQ3NueFZ3d28xT2tkbjZoeEVSWlViV25rSHNjeEhyWlF1VTNrbmdxVEgx?=
 =?utf-8?B?YjlxK1ZhQmdVUDN4VnBzajIwODdXRkRmMmFZTW1VZjgzUWwvYURsT1hZbHQ0?=
 =?utf-8?B?VmhGTi9xSzdoc0lob016djFlSjU3cWc5aVpYQnNkN0xhdGV4dThsQWlzQnNr?=
 =?utf-8?B?Um1FdzYvbEt6aGF1MmpxaXFKaEFzRjhDcG5LNlp0UXphY0p3dDBqLy90Rytv?=
 =?utf-8?B?SzM5QXorWElwYnVyWWVHRVRzVGdDc0k1RzBIM1ordUowWXNYeTFnU0M3bFU4?=
 =?utf-8?B?MnR1dnBZRGpnb1pHV2FEc1VXbGxRZU9jMmxMTXVHUkxMUmpRdDhZeVlaTVla?=
 =?utf-8?B?cHZ4OWV3b1hySkIzcUcxV201WkhVMjlsRWpEQXErME9TVG9uOVF1WGFTaW5a?=
 =?utf-8?B?VXdrUGhBV2thTHhhb1lkNjFDSFJFWHFQSlBuUzBob3h0cjh5RFpaMWlRK3Fr?=
 =?utf-8?B?bmk0aWxRdUFDR2RBWnB2YkVTOUlRcHMxY0ZaQjRGMVBPcGVjOVl1TzVrZ0ox?=
 =?utf-8?B?eFlKS0p0Z0lRWmdRdUw3QVFycXhYa3l4VlNNYisyY0lHZlhhUXdNbUxIRmVo?=
 =?utf-8?B?MXhqanRyT2J4eUNQMTBZNXFlVTZrc09SMjZlM0dUZEhnNmZtR0wyeHVhS1dS?=
 =?utf-8?B?d0xSN2lTVVl0V1VsR2FhQ1dHNE5yM3lneUR0TTlSaUl1MzF5RjJZWlEvcDlV?=
 =?utf-8?B?MXN0b3RYV3pNS2JMZ25MZllXUUw3WWJDNlZ4NXRxWGw0M0wrUDhrYW1QVTNO?=
 =?utf-8?B?aE50cjFSQ3NzSEVmZEViN0pNVXhaTWdKbFA4VkhoSkxLaW91N0txcmVwV1pZ?=
 =?utf-8?B?RVlSYnUrcy9IN1plWnJoV1VIWTRHdmplaU54K08yNnZkOTRvTFBYcGdubDRW?=
 =?utf-8?B?RmFXcWtnZXR6ZUM3WGtUOGFHejFNOGFvYmwrVTFJMTVBZ0lOWHBsczJ1aW5w?=
 =?utf-8?B?UklUTGppSGd6dTVtejRsUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWZXKzZBemhMQ0hyTlYwTkpKYi9IVVhXUmNnd3pNUmZ3K2FiMWpVN1dwek9X?=
 =?utf-8?B?cENlZnhCZE5WcjJVM0pXU01hRXFXcEc3SGQxQ1pnYzVMTG94MndvVFEzc2xN?=
 =?utf-8?B?ck82NEZ1NzBlazVLbWcrbDdYOEl0eWtOSEdFVDdWdFNSblp3SlVEZmVsbDJM?=
 =?utf-8?B?WkR6MVBsWDN0N2hTUmJIaEI4UktTWldhNjBvUG9NaGQyUUVFbzRra1ZFSVVr?=
 =?utf-8?B?cVJNY2szL2lXRGJhNjIwVGVYSmhKNmpDVEF0NHhwd3MreTJGM3hmcTJVR0tS?=
 =?utf-8?B?QkthWC8zM0FKdEtDM2E5c3VJcUpMM0ZDVjd0UzZ6MTJNME9zUVdpVFVUWXA5?=
 =?utf-8?B?Mmp4S1pwekRycnpIK1B0bklpamQ4RlFxYlJTb0lNUHEweEQ1RERRNHBVazZE?=
 =?utf-8?B?SkRETXFCeU83R2RUc0xCS255MXByTnB0aGxkak9wSGNlZm95Z0V0Nlo0aDQv?=
 =?utf-8?B?dkcveHpwVW5mc084RHVFaUpRclhpUEkrNTVxS0dUNC9HL0lMNU52VUREdTQ2?=
 =?utf-8?B?RlVyUXR1RnRBN3ZmRjB1RGpiZUNROHN0ZHE3cWNoN0hjRVJ2cnZybUQ5ZjZQ?=
 =?utf-8?B?Tnc4a1RsV3h0d2xpTVlEVVpoTXlPaE5lQmZ5V0J4eG1qOWVwZjAxcnpLaFJv?=
 =?utf-8?B?VFl2MVZhK3hFcjZsZzJkNm84TkF6U1kwNE9tWEhZM1Z0eVErbHZKblZxK0xv?=
 =?utf-8?B?R0M1MVB3ZU13OUQvd1p3UTVKR3grdCtsM29EZEpFOStCMU94aFJ1dExHM2pF?=
 =?utf-8?B?VTgvWi9oa1JySE9EVHc1UzhkbUh1RlVzazlKNk1xdFRzdklZSkZ0M0dXUC9p?=
 =?utf-8?B?Y09hMXR3OExORXVsY2xjSWtOZlk1QWRZWUtsbS9ERFJiNVBSYzhKWlN3bkNV?=
 =?utf-8?B?MXFWKzBYRGdKTG5VTm1INC9RZGgvVVg5bXV6dEY5aXpOZVYyZXFtTmZXa2tx?=
 =?utf-8?B?YzlkV1ZQZ0pPdWZPSmMxcGZYTTRHaXpJL3pGQ3h0SG9TZkpVblNqWEJ3QWts?=
 =?utf-8?B?R0NMdnNITEdkdWZSM3RNK2xvQTYrK2tpWDQ3TGhsZmRESms0R2Vyd3B4OU01?=
 =?utf-8?B?bzZsOXYvQ0dlTmR1cllxUEIwcVlodWZFbDZYQzJxV2ZucGYxM2pqc21Wd1FI?=
 =?utf-8?B?S2RxcUZTZ2xpYTN1dUpyV3FhZi9WWmlrUXk4S0dCeG5qMW85b2Zlb242VnRi?=
 =?utf-8?B?bTN2c05KSTdPa3lLbXdvL29qcWZ2QUVjTVl3dll6RysraWVDUkRGendtR0F4?=
 =?utf-8?B?YlRrSjVGKzd4K01hYzA3WGQ1eEFtbytQcjRieUlQRXZET3NlYjEwVFFQUXkr?=
 =?utf-8?B?Tko0N0owUW9TQ0xmbWROOUhRSXFvcUJXN2h6VzNKbHp5azVFMUZRT3RVeHlF?=
 =?utf-8?B?M1A3V3VSTzZVeEdQVmRkZTlhMGE0NnEzNFVBcW1NRlFSUTJidUpRSFl5cllW?=
 =?utf-8?B?RWEwcVI4OEl4TVA3MlNxdmJaUWk1RncrdmlzdWFIYW9BODkwMDVtd3pSN1NW?=
 =?utf-8?B?cXBtUjBpays5K0szU0NCZDlzeXROUFRMYVJyclR1ZG5hbjd6TUkvTEIrcENn?=
 =?utf-8?B?ckhNb2FTYk5ZMHBrWWYxTmMzRVNpK0plWG1sWWgvcWRVSjM3QnJSS1hsL3B1?=
 =?utf-8?B?TnlpdEZ3aFUwR3k4SWQyYjNkZEFuS3hOaElTZWx6ZXNmaFVsMGxKZUg0V2xK?=
 =?utf-8?B?N1gxTFUxZFVKS3lIREt6bnpteTdtK0xGZkJIM3pYaXpuRFhyRUh2RllLU0RU?=
 =?utf-8?B?THQ0Y2Q3MjlRUjM1TG5XYmdEQUJ3a1A4dVc2RU8yOEJKa0xTRlI0L0ZORUdL?=
 =?utf-8?B?SGt3dlFzTFo4SjNINCthT1krSldtRnEzRk5RRFpjUTQvOUZXenJpUVpyZDZ5?=
 =?utf-8?B?Sk95QVRHWVlldVJVWDFsME9aQ3lxWDVIUHNqaTdpOFlzdTRiUk0yUXpPWU9Z?=
 =?utf-8?B?QmJMVzliSThVU0hSWTViV21KU0dJSGxoSGF3eENIcm9jc2NSR1c0SUxsd1ox?=
 =?utf-8?B?b3dQRk1WQ2txWTd3ZUNWSC80Zkc5MGRWa2lVUG5KaVNlY2lVLzVCT2pDN3hI?=
 =?utf-8?B?WnV3Q0dmMFdZOFo1bCt5S3NGbjdDVldhN3RvdW05eURSNEV3QUh6cjkxMVRv?=
 =?utf-8?B?dCs4d2lXUUM5azk5RUVXcjlocVQ2NGtqQ0V3Q2VxNzgzb0Vwenhnb0RuK2Ez?=
 =?utf-8?B?V1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cf981d4f-c9a1-481b-4161-08dcb1fdc2cc
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 07:44:23.5752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FThVFfVkYgbQrkM8ozy3Rh4FaCz1zRii0OsSJBQwej/tC4qheSWqOK6QUV9su/+vqW1t5laGWqvvJBUgtTruSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6097
X-OriginatorOrg: intel.com

Hi David,

On 8/1/2024 2:49 PM, David Hildenbrand wrote:
> We now have to do a page_folio(page) and then test for hugetlb.
> 
>      return folio_test_hugetlb(page_folio(page));
> 
> Nowadays, folio_test_hugetlb() will be faster than at c0bff412e6 times, 
> so maybe at least part of the overhead is gone.
This is great. We will check the trend to know whether it's recovered
in some level.


Regards
Yin, Fengwei

