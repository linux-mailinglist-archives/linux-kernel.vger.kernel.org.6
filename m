Return-Path: <linux-kernel+bounces-214166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD48A90806C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 03:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5154F283FF4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 01:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673DE28EB;
	Fri, 14 Jun 2024 00:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="moX/oLYd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DF5801;
	Fri, 14 Jun 2024 00:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718326794; cv=fail; b=KXTNp2fX4wftfscbT6SM3ARVV78i+ytHZBuo8Aq/KyS/yDYtUMDMpDE9+i9inBA0kV1OTRfc/ob+cSE4RjPlsCXDKo2Q/v2KdzWqYk2uhIU/j8sg2cMT2b7g1bK0ERbh2xgeJbSjL0xkAVwwgho2OoeXYqvRZyjsiUKvVwWc0KY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718326794; c=relaxed/simple;
	bh=GNrNY34Wy5NaXO0Bsy52zudJIebAeE5gRNjmCIo2hTQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pydc9X9X1Xoytvazy/OsO7Mi0eJQ2NWUvwlIpStGTcWbPdhe5RVi3SqllnygW6jJCiipCvwFxdhPJ9HkPQb2wxSzHwUdjVmmHYUcZTDH7N17GTqwXpFbspVcrRC+sh00QP6l/orX1Gu8T/ks/doqTZihVePnSML+FbWoWtzdQ4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=moX/oLYd; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718326792; x=1749862792;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GNrNY34Wy5NaXO0Bsy52zudJIebAeE5gRNjmCIo2hTQ=;
  b=moX/oLYdWQ8SZMmLlxEWoksOWKqrcr5jpJBXlTB/cogRQXO4E+jrcLZm
   4W7Hz5hrTn//KRz9xafzrOFJ53Z3kN/zO+3MZVkYal4U3Fu68c6qw2zio
   /xMW/ey7mudsSr21I5FjeO9iSvT0yHd5dwYF9zQZTEpQbKGXcbkrwAVWE
   go5aWJfrV+qtZguVVFuAIzQdsKqEAmO0Bda+V8H3MA0dRuaioVvZR4WMf
   rYPcxeO42m7PQhKGt2g+7Pu0J62p/it26sjfP4pTWi9QQIdWoJSjlYU5y
   MO6BoKfhmGvjGB5XVy/v3ckEAqkHTWX64uR+zh+wESZcAeTU0EsOUDLoV
   g==;
X-CSE-ConnectionGUID: FOQe3cPXQHuh9W5GoW9IhA==
X-CSE-MsgGUID: +NuBKkG3SiaCbj4+PRd+uQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="15030745"
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="15030745"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 17:59:51 -0700
X-CSE-ConnectionGUID: xbpVR3e+QRuYWBD0xudZPg==
X-CSE-MsgGUID: ZURbm+oMQ5SeJjOwtB/zug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="40446059"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jun 2024 17:59:50 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 17:59:50 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 13 Jun 2024 17:59:50 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Jun 2024 17:59:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DuCGLfIxpCmPKZGVmrucjgRUuKMuE0RSojN3krTP7bLmDhEKNqRvVjPSnm6YpSKIpBi+NZJW0ZSkFegd7BywsimAk4mJ2Vrl8OTDxvpEpAL6nJtplfjg9Kfw3Z7ihCtu1kYeR15oydb8o075J8ydbICF8iRw8VmzQl2lz1hXhH87nuAw5F+4tS0Po6Rxxd1K4zoa8XxtM6jmr5gn6C46SaRwJ+UiaVLUsIWlxWctQfDFBP/3XVdniIPzDRwveO/JDT4nKyPN6EER9gaV+nk4rN/TozJBoTn2zqjjSro5tHAj1h3K4Nw7RD4U39QSX1o+l/L89bSLk18vselh0KQfuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pkbaeVSaOEsnTXCfMu72lVYNyskimVagXuPlTswggAE=;
 b=QJFn6EN0qtCq/75epq9pcXxZ+F+W8nyQRKa4DPEGDvxawldRtIkanT1mi0XDj+f/NcwfvBtMiHWny52oJ7n7C6l5gXmvp05Goz7kSiaphlQe6OmUEjoMVNQ5dNdqzvKQ6KIfsXaJ9M0dbbYY+o96q93tNxvLRDMu1FHYnVUfWb8ak9gVAIfr8m5BeZaBaRuCV3tgpigBKBzzGzXj0dlJOuI8fWWfTHJ/4MSMWiY2r//R8yw/syTY3KQvoksAAMSh00Y+REIshmrmc1Lo3cBCK0OlMpAj6sw1kXdORfVkj8D3+VEecjF0kvTSJfBbPz8/szDN1HWGlcGZTjqpcQFFuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ2PR11MB8567.namprd11.prod.outlook.com (2603:10b6:a03:568::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 00:59:47 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7677.019; Fri, 14 Jun 2024
 00:59:47 +0000
Message-ID: <28cd2683-2ab5-4772-8597-6aaf0aec1f0e@intel.com>
Date: Thu, 13 Jun 2024 17:59:43 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/19] x86/resctrl: Add support to enable/disable ABMC
 feature
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
References: <cover.1716552602.git.babu.moger@amd.com>
 <e4edf1794852cff132b17c8f061f24799d9e79ad.1716552602.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <e4edf1794852cff132b17c8f061f24799d9e79ad.1716552602.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:303:2b::9) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ2PR11MB8567:EE_
X-MS-Office365-Filtering-Correlation-Id: 553daf35-1048-4c47-5b3f-08dc8c0d4928
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|1800799019|7416009|366011|376009;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cDlFV3VMbjRMcDcvU3JaaVk3OWdTUytKVzRtcmtZaGZab3o4NnZjclRWWE1O?=
 =?utf-8?B?MlNBSlZlWUxMMXVXRllqVlY4MG9hdTNiditjN01EU1E4UEU5VVEzU0NxQ2wz?=
 =?utf-8?B?Uk5kQXgzZWs5aFB6WHJtbWhBS3dVWFpGOWR0N3EySmxncGJHTTRzT1VXUG5k?=
 =?utf-8?B?ZSs3ZVpSanR5QmhiWi8wNWZ3SWVtKzdqS0t4NUJpS3BRUkt1L1p5dlIwR01q?=
 =?utf-8?B?NkNOZTBNVitOKzRSUWhCODdSTURsMGI0WmZnNkhxaTdEc1dvR0RtajFYZG91?=
 =?utf-8?B?SzRJZ2lHYWduU3ByNW5ld08wZXJ0ZTlXczBFNmRJdmtxOWFhOWpjM2pjaWph?=
 =?utf-8?B?REVwS1JieHNVZVRENnBXK0tqMy9LTHYrZW81aC9JNTI5R0MyQkM5djBUejYv?=
 =?utf-8?B?YVNJNlF5aTkxU0ZISWlYUHRxMHMzc090MnFPbjJGSnZuczN6REJOTWN6aHhU?=
 =?utf-8?B?THdlZnNwT05tUEcxbDEzVWJ5MndwWnZobVJOWk1EVmxBUTVvekV3VzdSMHJk?=
 =?utf-8?B?LzFocEVIbVhIQ1BEOVhRdTlFdmJYYVowQXIzZVE3VVV0VlNZdTFORWY4czVY?=
 =?utf-8?B?UHNIZkpFTk9Kb054R1o5T3lkYzNheVZmV25SMzVnbG5xcFFBR3dSb0pYVjZD?=
 =?utf-8?B?UFhDTTJ5dzF3dVFML1VwclBYRm1KYkF5WU9LeWJQcTF3S2xFaU9xWlIwWXpG?=
 =?utf-8?B?MWd0TWpPWkNITmd6bnVLeDgxSWcyTjJ6U3hpM3ZiZ1NudGZ0SU1wek9XVWt3?=
 =?utf-8?B?Vk1JWVBWek9lRUlvTWR1eXpKMVQ0V29hZkJFSkdzVGJTYkhROFlwMUdsaDgx?=
 =?utf-8?B?Tjc3RVdseU96bGVldzcweHNrbi80b3ZHOEcyNGhOUjA1RllIeUJ4UklBRnZ6?=
 =?utf-8?B?TjYyT29MWCswT0lLQVpKSTFjYUhRK2xNQXhJSDJVZzdFTkEyaDRya2U5QzFB?=
 =?utf-8?B?UDhXak9NOEoxcUJvUW00bWpXNE9vRG1PR3l6c0Y4UXR5alRqN0E4T1c1SGpG?=
 =?utf-8?B?MkVrMmwyV21aRHV3NFlSRUpSdnNHUTUzMXNSUFdzeGFaaXhEbHhVeVpGLzd1?=
 =?utf-8?B?bHhIMVRkMVlTc292cm5FMmxuM3VBS1VaeGQ2NlhPOFJteEVMS1l0SmJZRU0z?=
 =?utf-8?B?SjFNeFZ5WUxieW9CQXFXUXN5b1RqTjNZZ0gxVUNCV0ZWU2VvaUE4UVRrNmM1?=
 =?utf-8?B?MkQ4dTkrNmFtNUpBZys2WG52bnJHd3h4cmt4bXhLMENGWEJuNUVjckZ2ckww?=
 =?utf-8?B?MmJwOHJ4Wm51akFRYkllZzZneTU5eEhTcmw0VnZUaGZKeUJ2eElOaVFjcjFi?=
 =?utf-8?B?QmxpVjVJbGhXS01vdm9PaCt2MEp1eW5yMlpuSzdCUWNxUkFSejU3K3hXaUtY?=
 =?utf-8?B?TXZrblU5NTUrVmd1dmZiYnFqTWpQMm1iVHh6MDBuOWlzeG1iYVZUMVh4TERB?=
 =?utf-8?B?aHJpQXE5WUJOdHhrYjB4U3hPUjAycnlwbjRZcStSRVZaSDkxOHMrUHVhdEFi?=
 =?utf-8?B?eTdRUVFjdkpSVFZjNkI4RVN2Y1JtVmJHaEkwcDNGRVFuTlpuWHRZUXJiaFla?=
 =?utf-8?B?M3VVVGZmZ25RWWhSMTNwVTluZDRnQ1pKWXF6TjJ4OUthSzROcWRTY2V2cTFw?=
 =?utf-8?B?dlg0R3VWZkIrSUM2QzhPMVhveU1FUkxweTA3UHdjK0kxdWc5MTVNK054NXl6?=
 =?utf-8?Q?COLbjqBduIQUjg5lw4F+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(7416009)(366011)(376009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnpnLzdmNmRNRE9WMEhTMGJ6d216UDhIQVBZT3o5NVFUMDVMTE9kN1VpcWJH?=
 =?utf-8?B?RzBRQmZFM2pvMDkrRWMwMjNuMVBCaU4xUkhld2NwSFM0VU15L0xDaUlidTZr?=
 =?utf-8?B?dSsvMkk2NHpEa0JITGw1c09jbDR0MEFOSWFRclM5SFlKUUR2S0JjV1dTUjI3?=
 =?utf-8?B?YUJ3bnoxQ1FIZC9KUnZGdnF5b3JMKzA4MTJsSzNuQmcycmVVMnNKSjdWb1JY?=
 =?utf-8?B?V3YwVHpJelljRDVsdW9NQWlUSXltQWxMTEhQbFgvYjd1T1Ywa0VTZWtZdFBx?=
 =?utf-8?B?cjVNVTBvRGpiMWRCTGRQbXBVR1JLWXYvWnA2WDJJZmNlUlRINU9YaGZJcEN0?=
 =?utf-8?B?UlBsOHhVL2FhYUxDZDRQTlNqVlVZWDA3TXdadFlNbzh1WElMVjgrb3laSXNO?=
 =?utf-8?B?cnBXa2gvM1lENHVBMk5Ua09GalY3MU03TjVldXN5V091NER0aERMR1plTUhR?=
 =?utf-8?B?L1RlWW1Na2NEenVnRk5Well5aVNMRTR2OU9CWFFjVG1ESVN2SmJpYnlJNlAx?=
 =?utf-8?B?M1NvWjFxMG1xVzZiMHZrMFNZZGhNR083cG1QeUFHMnpRUUpBL0MyRkp2aDE0?=
 =?utf-8?B?SEs2WWpMeCtyUkVMVGc5bXU3OGZycW42a0dqUy9pZC9CQU1JcEVqTG5jdlFY?=
 =?utf-8?B?ejB1Q3dkNnlSZzN6YWNIdjJUMWZoZ2c3emhKMGc1S1BXM3BFTzZ4Q1dKZFVV?=
 =?utf-8?B?c1RqbmJudVB6dEdoVzlEZmZQMDczNXJrRnBHNlI0TGNuRmdBMnhOaWdpRCtk?=
 =?utf-8?B?d1kzd1lZLzlSRjdaMVBKTXR6dFlERVJmZ3duNUV6bHZPbFdWc0JKRHhhQ21h?=
 =?utf-8?B?ZUg5MDlCOUVSZWg1NkZkMDk0cHJlcXdLYnJTb0RNVE5hdFJ2NVN3V2hMK1Zq?=
 =?utf-8?B?elZ6M2dzWm5VL2xVQkt4andndyt4U2JpM05HTUREdmd5NkRnNTB5VWpZNmho?=
 =?utf-8?B?TVF1WFpOeFJMZ0RpU3FDenlIOWdYMjVUUTJwZ3VjNHBtU3pIVE9sbDF6ZG1W?=
 =?utf-8?B?N3loQ0pyZnhXUUJ4ekh3SFJrTkRmWnZyNXUyN0VETzhSbnRmV1U1ZkFVMkxS?=
 =?utf-8?B?dEFFUk04RjhoaHhDWEdXVC92MmZZOFBWVmhBT2VwdDRLWGtTQnZiMXJQZkZB?=
 =?utf-8?B?cTBxZzVJOGw3bkJXb1JJZmtkN2pzc2djTjgvLytEb1NsVnVIL2VYRDhKcmt2?=
 =?utf-8?B?QzE3S2k4Q2Zlb2w2QkR4d3dCeVRsdm1QVkdKbW5DVnJyRjRCakFWRjlJOFFy?=
 =?utf-8?B?UWZEODl4YlpMWDVaMGhIOWgydUo3bFR6NFgrNU04M0hyaU5URFMvWnVDd0lN?=
 =?utf-8?B?TUdGZTNEMzN4bFhDWm1GMUxqaEl3bCszMkFCNXpvWU5OOUtYNHlXajFQeGhE?=
 =?utf-8?B?WmNzMzZZV2toWWFQUmFaK0lvQ0pCWUJzanMzcWtMWUNqMW95SS90VGFMaC84?=
 =?utf-8?B?TGNDaEU0YU5RbG9uSWhpcndUNEM3VWJCWmg1TVdaZFNRN3ZzbnZ2RlZNa3pK?=
 =?utf-8?B?alVidkNmVEs4Nmx3L2R4K3oxN2NITjl3ZVJHYXhTWW9GZlFtOWhoTC8rRkhF?=
 =?utf-8?B?dml6WlA5a21ZaGZxbVBqejlFWWU1YVQvVVR4amllTVpSblRjbjY0QSszR0NY?=
 =?utf-8?B?OWcySDQ5NXRQZ3Ezekd6ZllINVlSWnVCS1lBZFM5KzZVcFZYN3h5UjNUOTRJ?=
 =?utf-8?B?RlV6Qm4xSzRMOGUwT2R6cEtNOUI1RkpIa1JNbFFXdzFqbGNvYy9ZWFp3ajVn?=
 =?utf-8?B?T3pSTzFvS1ppSWIyNzZvdWJnbktGRXNsSVRkbStURWFkcDRUaFBReGM0WElo?=
 =?utf-8?B?cVVCbTRWd2duNHVHVlBZS1JtT3FnMjZtRmJkcy9IV1JZYXhvK1hCVmNDMFdt?=
 =?utf-8?B?b0JOclVUOXlDQXJtRGp5SHk4em9IclpKQ1FuWTYzdmxGTVlsQUkyU3JWaGIx?=
 =?utf-8?B?RmVNTXJFQSsxazZVYWM1ckliTEUxYnZ4UFlVS0wveW8xaUZjY1ZBWWtGeng3?=
 =?utf-8?B?bnh0U1dyaDVaODI1WVVBRjljSTZ4MGk0WGtnOXp1V3dlZGxMTmowTjJZK2d2?=
 =?utf-8?B?UnJKWGdwNkR5SWdlMWwrbkxTc0tCTW9JYXpCWWYrYVdnTERyYmRGNS9IQkdJ?=
 =?utf-8?B?Q3JDYXNxMzFNV292eGp3MXpVOGRxVS9OS3NqSnV6Uyt6ZWl6Z0JIWTA4U1lV?=
 =?utf-8?B?bWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 553daf35-1048-4c47-5b3f-08dc8c0d4928
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 00:59:47.0751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n+NJ8ZA6eI0VB15qHsvJSWacGZ7o9fnzlXyPf6TLX14ubzGZUbU2ZKI+7bzj355W1xgrpw+YqreD3+k9Uq5BrPeR3sqkIw4ac79LECf9mx0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8567
X-OriginatorOrg: intel.com

Hi Babu,

On 5/24/24 5:23 AM, Babu Moger wrote:
> Add the functionality to enable/disable ABMC feature.
> 
> ABMC feature is enabled by setting enabled bit(0) in MSR L3_QOS_EXT_CFG.
> When the state of ABMC is changed, the MSR needs to be updated on all
> the logical processors in the QOS Domain.
> 
> Hardware counters will reset when ABMC state is changed. Kernel internal
> counters need to be reset to avoid overflow condition in the next update.

Please note that there are two "ABMC" features introduced in this series.
First, there is the "abmc" resctrl fs feature that just happens to have
the same name as AMD's "ABMC" (which may be a good motivation to change
this name). Second, there is the architecture (AMD) specific "ABMC" feature
that is enabled in response to user's request to enable the
resctrl "abmc" feature.

Other architectures need to support resctrl fs "abmc" feature with something
entirely different.

Please consider this distinction during this series because it is often
blurred.

> 
> The ABMC feature details are documented in APM listed below [1].
> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
> Monitoring (ABMC).
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> ---
> v4: Removed resctrl_arch_set_abmc_enabled and resctrl_arch_get_abmc_enabled.
>      Directly calling resctrl_abmc_enable and resctrl_abmc_disable.
>      Renamed couple of functions.
>      resctrl_abmc_msrwrite() -> resctrl_abmc_set_one()
>      resctrl_abmc_setup() -> resctrl_abmc_set_all()
>      Added rdtgroup_mutex lockdep asserts.
>      Updated commit log and code comments.
> 
> v3: No changes.
> 
> v2: Few text changes in commit message.
> ---
>   arch/x86/include/asm/msr-index.h       |  1 +
>   arch/x86/kernel/cpu/resctrl/internal.h |  8 ++++
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 62 ++++++++++++++++++++++++++
>   3 files changed, 71 insertions(+)
> 
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index e022e6eb766c..5f9a0139e98c 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -1171,6 +1171,7 @@
>   #define MSR_IA32_MBA_BW_BASE		0xc0000200
>   #define MSR_IA32_SMBA_BW_BASE		0xc0000280
>   #define MSR_IA32_EVT_CFG_BASE		0xc0000400
> +#define MSR_IA32_L3_QOS_EXT_CFG		0xc00003ff
>   
>   /* MSR_IA32_VMX_MISC bits */
>   #define MSR_IA32_VMX_MISC_INTEL_PT                 (1ULL << 14)
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index d566251094b2..fabe40304798 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -97,6 +97,9 @@ cpumask_any_housekeeping(const struct cpumask *mask, int exclude_cpu)
>   	return cpu;
>   }
>   
> +/* Setting bit 0 in L3_QOS_EXT_CFG enables the ABMC feature */
> +#define ABMC_ENABLE			BIT(0)
> +
>   struct rdt_fs_context {
>   	struct kernfs_fs_context	kfc;
>   	bool				enable_cdpl2;
> @@ -436,6 +439,7 @@ struct rdt_parse_data {
>    * @mbm_cfg_mask:	Bandwidth sources that can be tracked when Bandwidth
>    *			Monitoring Event Configuration (BMEC) is supported.
>    * @cdp_enabled:	CDP state of this resource
> + * @abmc_enabled:	ABMC feature is enabled
>    *
>    * Members of this structure are either private to the architecture
>    * e.g. mbm_width, or accessed via helpers that provide abstraction. e.g.
> @@ -450,6 +454,7 @@ struct rdt_hw_resource {
>   	unsigned int		mbm_width;
>   	unsigned int		mbm_cfg_mask;
>   	bool			cdp_enabled;
> +	bool			abmc_enabled;
>   };
>   

ok, so here by making "abmc_enabled" a member of struct rdt_hw_resource this is
an architecture specific property. This is reasonable since every architecture
will look different. What is _not_ ok is that this causes the rest of the
series to change resctrl fs to reach into the architecture code. For example,
this work causes mbm_config_show() to now need to peek into struct rdt_hw_resource
to see this value. That is not ok. All of the interactions between this
field and resctrl fs needs to be via arch helpers: resctrl_arch_abmc_enable()/
resctrl_arch_abmc_disable() and resctrl_arch_get_abmc_enabled()/resctrl_arch_set_abmc_enabled().

>   static inline struct rdt_hw_resource *resctrl_to_arch_res(struct rdt_resource *r)
> @@ -493,6 +498,9 @@ static inline bool resctrl_arch_get_cdp_enabled(enum resctrl_res_level l)
>   
>   int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable);
>   
> +int resctrl_abmc_enable(enum resctrl_res_level l);
> +void resctrl_abmc_disable(enum resctrl_res_level l);

Why do these need enum resctrl_res_level parameter?

> +
>   /*
>    * To return the common struct rdt_resource, which is contained in struct
>    * rdt_hw_resource, walk the resctrl member of struct rdt_hw_resource.
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index ca692712b393..9148d1234ede 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2416,6 +2416,68 @@ int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable)
>   	return 0;
>   }
>   
> +static void resctrl_abmc_set_one(void *arg)
> +{
> +	bool *enable = arg;
> +	u64 msrval;
> +
> +	rdmsrl(MSR_IA32_L3_QOS_EXT_CFG, msrval);
> +
> +	if (*enable)
> +		msrval |= ABMC_ENABLE;
> +	else
> +		msrval &= ~ABMC_ENABLE;
> +
> +	wrmsrl(MSR_IA32_L3_QOS_EXT_CFG, msrval);
> +}
> +
> +static int resctrl_abmc_set_all(enum resctrl_res_level l, bool enable)

Should this function and resctrl_abmc_set_one() perhaps have "amd" in the
name just to enforce that this is not filesystem code at all and specific
and unique to AMD.

> +{
> +	struct rdt_resource *r = &rdt_resources_all[l].r_resctrl;
> +	struct rdt_domain *d;
> +
> +	/*
> +	 * Update QOS_CFG MSR on all the CPUs associated with the resource

end of sentence needs "."

This comment about the specific register seems more appropriate to
resctrl_abmc_set_one() though. This function is a higher level
enable/disable of the hardware feature.

> +	 * Hardware counters will reset after switching the monotor mode.

monotor -> monitor

> +	 * Reset the internal counters so that it is not considered as
> +	 * an overflow in next update.

For the first time the term "internal counters" is introduced. What does it
mean?

> +	 */
> +	list_for_each_entry(d, &r->domains, list) {
> +		on_each_cpu_mask(&d->cpu_mask, resctrl_abmc_set_one, &enable, 1);
> +		resctrl_arch_reset_rmid_all(r, d);
> +	}
> +
> +	return 0;
> +}
> +
> +int resctrl_abmc_enable(enum resctrl_res_level l)
> +{
> +	struct rdt_hw_resource *hw_res = &rdt_resources_all[l];
> +	int ret = 0;
> +
> +	lockdep_assert_held(&rdtgroup_mutex);
> +
> +	if (!hw_res->abmc_enabled) {
> +		ret = resctrl_abmc_set_all(l, true);
> +		if (!ret)
> +			hw_res->abmc_enabled = true;

This error handling seems useless since resctrl_abmc_set_all() always returns
0 ... perhaps it should return void instead and this error handling dropped?
With that this function can never fail either and it can just return void,
but this is probably not what we want as the architecture call since other
architectures may fail.

> +	}
> +
> +	return ret;
> +}
> +
> +void resctrl_abmc_disable(enum resctrl_res_level l)
> +{
> +	struct rdt_hw_resource *hw_res = &rdt_resources_all[l];
> +
> +	lockdep_assert_held(&rdtgroup_mutex);
> +
> +	if (hw_res->abmc_enabled) {
> +		resctrl_abmc_set_all(l, false);
> +		hw_res->abmc_enabled = false;
> +	}
> +}
> +
>   /*
>    * We don't allow rdtgroup directories to be created anywhere
>    * except the root directory. Thus when looking for the rdtgroup

Reinette

