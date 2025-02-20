Return-Path: <linux-kernel+bounces-524357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7435AA3E23E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 18:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 592B33B13EC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B229214212;
	Thu, 20 Feb 2025 17:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D+eRhs8i"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD7121323C;
	Thu, 20 Feb 2025 17:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740071335; cv=fail; b=NXUBWGxs9NIekSqaZe96z8II4C+UUmL3itlXSSfcMXnPIQbp0ysEJL3nGNyiTW92OJwfEQt/lV/QTyWmwIYP0WMnnQXHiIfVDB568OFKLnyKj3lbiKiC4op7ibiUS8yFVF3GrC+5sGmJk6ca3IE4NWusicY2C4rgeNcavzSrYOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740071335; c=relaxed/simple;
	bh=Ahi0/JOhzRvzy257O/d/zm/e2Pm9u4b7Xmyfm6KuVvc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SJjK7yBJ5QmVtHnxrbHFhH1Tqh/vhvoMA3XRCy3exVcImmdfRid4/X/ggZ2seJol7BWqx9EjYeCYfe723AmB78RVHXfSxrmqPgXmyQQZF1v8kW63FMJNZSPrO4lh1iazm8lPhmC3DigJBrpaFab3EtmaizB1qBMlXLA/aRZjbak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D+eRhs8i; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740071333; x=1771607333;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ahi0/JOhzRvzy257O/d/zm/e2Pm9u4b7Xmyfm6KuVvc=;
  b=D+eRhs8inNaELnNii+sAHxuX0TIhP9FoVS0LaXN8VSsE2TZCg1q2dhkt
   EZJSUle+OIRXvnw74y0c1R1h+NeTuHV1B77/tGGaanj1QbH8cMDKXEF29
   08NNrLobmFJDQRQ0Tcyx4mNYjR8F1VLH82/JWvT3TphrXf6J/PBPR7v8N
   owetzqFu8e5x/ajlIHwz6k2IPz/OsSMSZwULBh/L7khQA9BreXHZrRHdE
   w+SZMXzP6JYpexdO3eVspQu1QYAEigAymkHzoj7w6ssIvF3vM2p9DKRkm
   PRR4SbwAlpNlgd4Z/hfy3iVXU6q2C1sL4tUwHFzkHAQlsmRx5W1dYidQM
   A==;
X-CSE-ConnectionGUID: J5uMBHM6RdeD7dWhKHvMuw==
X-CSE-MsgGUID: 47t2ukezR/i5BaptMp3mDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="44646716"
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="44646716"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 09:08:28 -0800
X-CSE-ConnectionGUID: RUhddgn/QF+IDbDcX3nliQ==
X-CSE-MsgGUID: KI4SAA+eQ1OmpM4YhFPhUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="120080701"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 09:08:27 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 20 Feb 2025 09:08:25 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 20 Feb 2025 09:08:25 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Feb 2025 09:08:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mkPf0R9rLd0UVSYGsmb1qRK10sFdscrcOSnz2uYENHzKbebrQOyvy8oBKtmLUn6OZUKpZRT44Hr5LvybD6YRivjVgyb2qBMxV1sLRgUM7kbO681lyYGAVM/vJr+3AqdGQsSb8QPd3uyrfkfOBF1mEJWeGVodDhAbo6ev1/IEMHvXD1t9zNwUnSxfRXwMp4ztYCk63IudP8xI6uc9XsavE1ekiUEGtCmwnLh/hlkDLmiRTg/QPTS8rRRd9K5+dAnHo81ANOKSok5fvenUoJ+PX5IlrTwWnAMUcno/tFlLucgV6YcVFKr+AQt7DJduIfEcSqLMUHPrlGFF3QQ2Axgsqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kIVlXMLk9utlKg5f6dD0yiXYaIWiBolnCYxUzurWeF8=;
 b=lbQ35G8hNR2ThkWkFyh90ov481fn9EOwngMJPtSbvI8IXrKXOjO6AMYLjvrxBNp/GQwkotmA+jxV3JhRmT5uK9gZErX3SUElVO1Z6sTKH8O4zUVkx77vZZv1zVrCK6KTQeV4fi3t6RfMArFNxvppi3N5oTKGPV001vcZUk2w1habkH56RjP9KDKFGfP0tiHDWvvq/RChGDC6XR+6cyeiWbpBvDFXCU4nrPDOg2dIUMu9S1+MDNSw1USxpyxCSu11x9YVnC2YfUEwivEnzRgkS9ds9JN85RuwhHPuOpIOCxGE8jgH7lIGuA93edu2Wu4iEB7JneOiU/I+dOOzYrxM9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CH0PR11MB5297.namprd11.prod.outlook.com (2603:10b6:610:bc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Thu, 20 Feb
 2025 17:08:21 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8466.013; Thu, 20 Feb 2025
 17:08:20 +0000
Message-ID: <2889da50-b654-403c-910e-13b9144596fd@intel.com>
Date: Thu, 20 Feb 2025 09:08:17 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 17/23] x86/resctrl: Auto assign/unassign counters when
 mbm_cntr_assign is enabled
To: Dave Martin <Dave.Martin@arm.com>, Peter Newman <peternewman@google.com>
CC: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<tony.luck@intel.com>, <fenghua.yu@intel.com>, <x86@kernel.org>,
	<hpa@zytor.com>, <paulmck@kernel.org>, <akpm@linux-foundation.org>,
	<thuth@redhat.com>, <rostedt@goodmis.org>, <xiongwei.song@windriver.com>,
	<pawan.kumar.gupta@linux.intel.com>, <daniel.sneddon@linux.intel.com>,
	<jpoimboe@kernel.org>, <perry.yuan@amd.com>, <sandipan.das@amd.com>,
	<kai.huang@intel.com>, <xiaoyao.li@intel.com>, <seanjc@google.com>,
	<xin3.li@intel.com>, <andrew.cooper3@citrix.com>, <ebiggers@google.com>,
	<mario.limonciello@amd.com>, <james.morse@arm.com>,
	<tan.shaopeng@fujitsu.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <maciej.wieczor-retman@intel.com>,
	<eranian@google.com>
References: <cover.1737577229.git.babu.moger@amd.com>
 <2119b76ef8be21b1d8b2deedfab23e8e33ba724c.1737577229.git.babu.moger@amd.com>
 <Z7XfcV05ZZkHm6bc@e133380.arm.com>
 <CALPaoCiPkjbTf2He2tXsguxHDtGF+YfVUZScL8dseVc6rvAfvA@mail.gmail.com>
 <ac6860d4-92b4-424e-af4f-d6e3d5722232@intel.com>
 <CALPaoCh8siZKjL_3yvOYGL4cF_n_38KpUFgHVGbQ86nD+Q2_SA@mail.gmail.com>
 <Z7cw4JTp3Hfx/4li@e133380.arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <Z7cw4JTp3Hfx/4li@e133380.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0236.namprd03.prod.outlook.com
 (2603:10b6:303:b9::31) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CH0PR11MB5297:EE_
X-MS-Office365-Filtering-Correlation-Id: 371ce608-0f2d-4b3f-f04f-08dd51d12d41
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TUlWQWU2WUhYNHh4UVYxYmEyWEtldFFJK0hBMmZINkwwZjhycnJVbDFHaGJM?=
 =?utf-8?B?Q2cxanY4Rkh2RThmNmsweStIZDU1VjhWaC9KM0ttTG9RUHBGYStUSDYzM2Jx?=
 =?utf-8?B?bEQ0L1ZOS2ljc1g5eERkdWxwUTlNS0xWOFhHYTJoVGZXQW9TOHJQL08vVERM?=
 =?utf-8?B?TlROcEhnbDhaL2Z2UTh0L3AxWlBHOWtKQ0ZXOFhJUHQzU212emR5YVhSdEF4?=
 =?utf-8?B?U2NYU3VVZndBQzJ4elVHMkxERXg0M0F0cEVPb2hpNFNvdTdUT2xOYThjcFRz?=
 =?utf-8?B?cXRWeXEyM0VlZHNLeDFSQS96SklsNFE2RStVZXlYUmttcTRQdUNBVURWU2Yw?=
 =?utf-8?B?M3Nta0syL01aWVlwRWlINmdoTzFRSHdDRFpIM2ZOSzNIc2doTWtCM3BkZ1B4?=
 =?utf-8?B?eDJCRnNVRnQya0ZBaGdqc0ZIbGVOTE9ZZVU0MXVIU1dFZWFNK0Z1U3BFT296?=
 =?utf-8?B?N2ZHeWFjcHpQSWlPZmRjRDhZZkVPQjZwMGhISzJBdVdqeEt5NnZpZE52VDJG?=
 =?utf-8?B?N0ZlOGJGSEIzQy9XMEFtNGhmdjd2blpkYzdVbEYxcUh4ZGFGRGY0c05pa2I0?=
 =?utf-8?B?SGtaMnZCL1o5UnlmQVJJWGJFbmd4dFE0MU12a1d0SWxOek9LbjVmbUlwRWt5?=
 =?utf-8?B?eTFiOTJnNUROelVSZWpmYk8wbWtGNWswemNoR1pHejBZQXhXeWRkZytHaXor?=
 =?utf-8?B?M3NmNnRHdmpoK3pkc21wYVBBdThTWTZYK3pRL21Cbjl6QmhubGh5ZTdMQ21B?=
 =?utf-8?B?TGkweXg2dnN1QlY2YmF2WHdsc2Q4VGdBdnlJakZxem9mSXJGbzg5MW9DdzR2?=
 =?utf-8?B?MFBpSlI2TDdJUUttME1jNmg4WHVjMld2RE9qMEt0VUZQamo2dmxCaXRRS1lh?=
 =?utf-8?B?c3VUMDNEZGRiNDQ2SnlGekRuZFZFSzlHMTFoWEtNb05IeE1idHZkUGhTUHR6?=
 =?utf-8?B?TnJ0L3BhdUxVSFZqN1R3RGhKVmJEY0pIdHRCekFhWXBEbkozUUZCektobjFN?=
 =?utf-8?B?cEM2Um5NdE5TSzFWenl6SkdGUjd4c1UxcVA2NjRLK1ZCQUtvVWJHcDl4SjhH?=
 =?utf-8?B?QUFJRWJCSXRYVVNyZHMvS0tHanJiNVc5T0ZQV0g3SkhCU05uR080ejVaYjZ4?=
 =?utf-8?B?dDl3aXBnWWljWnV1OVJqK1NxTFZFa2hvRlRVVWhiU3Z5WG9YbzFNSUFEakdn?=
 =?utf-8?B?ejRjWTJxOHdBWEJueGdKWUtPVmplZ2lwWm5HVk0xTDF6MXIxb2xvTHJSQ1BI?=
 =?utf-8?B?bytYUDhWNHNaZjgreVFEUUVDemJJME8xTmkxVk40QzRFTUtGM05LVkVWOFRI?=
 =?utf-8?B?dFE5VVNYWFQvb3pqNCsreHRuSHV0OXpRVlo3T3Vod080N0FPRDRxUXQ4ZXVO?=
 =?utf-8?B?SDc5aTBQYmg4Q1k2WFY3YWUreG1oaWQ2aGhwSnJVV2hiSUFobFRRMWorVVNU?=
 =?utf-8?B?cE9ZdGFrTytZaHIyYzF0eTNtcnBJL1c3UE45L29ZR09XK0VMdnpxMnBXT2Ru?=
 =?utf-8?B?T040NUlsMjVDbnZyY05JWXQrVEViNnFTL1AwR3l4R0h1U3dLajB6N0w2UlFD?=
 =?utf-8?B?R2JHcTh5U0NWazlncXZGeTgrRTNLM0pja2ZQWW9wRXVsUFArdWJoN0hTaG02?=
 =?utf-8?B?aGZudUJQMnM0VEJ1UUszUUhXdUQ3VU16Zm1yVE14bE82UXlxTTFnbXlMdVVH?=
 =?utf-8?B?c0pURU1hN2pyZkNaQ3ZFMzR0M0hsMFl2bzRwajhGUFk5a1B0T0xhQnBHNkpt?=
 =?utf-8?B?UHlXRVJ4b1JiZGhGVU1mR1EyNFYrQTRUZEpaM2ZIQ3BUcEYwZlhpbUMzejN6?=
 =?utf-8?B?TElaY0Y3bEFnYzZ1REVmVi8xeCtTdW1xRmNqYlo0RnlZNERQbTkrT1o3T1Jx?=
 =?utf-8?Q?jMzmM50ptRNKi?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWFZQVh2ODI1UGF4azdudnA0UTgwSEJzK1F3elgzTWoyNzcrRTRtT2dDNFdx?=
 =?utf-8?B?Q2l1ZVRWVDFzY1cwclFpQ25RTDFWSlExMkFkWS9OeHR0TStoQm1qZnNvTzcr?=
 =?utf-8?B?cEI0S0J2MDVtdEdyN2hOa01zSVVBUUpWNDM3bW5VZ3lTeWc0S0EvdmNwak5P?=
 =?utf-8?B?bkJObXlHSzRDMlpkeUNxc1U4T3piakFta3kvM3QrV2NBeGxKMWFSakVVUGMv?=
 =?utf-8?B?ai9wNzZQNHJ0OExtQkRMTjNXVnJGZzZ4YTlpd0dmbGcwMU1SUEVXVGFXbmxy?=
 =?utf-8?B?ZDlHd0JuR2lmUldoZFZrVldjbURqV3lFUG1RNnpjN2d2ZFR4YWJxdTBNbWtU?=
 =?utf-8?B?SmpmWjlFZCtndXk1R3ZzRFhzT3doemxUbWlPUGhKZGRQZE9Scjhkd3E5ZGxr?=
 =?utf-8?B?M2ZNY1VKQ240cVlBWEVZc2ZMajNjMUZaVUtqOFV5NzJYU2cvY2tPOFNoRlAy?=
 =?utf-8?B?QS9XWnE1NmZJT1pUeEVHTFA5RzFRbm91OCt4N1RGbTlWOGtCTkNCZTYrUFdE?=
 =?utf-8?B?djQ3eFVxQm56TldJTlFiMEFEeE95M3U2dzE3VUM0WWpkRy82ekVLcUhINVM2?=
 =?utf-8?B?bjhnU2p2Mjh6Y0YrbjVoMVFaZDJZeTduY1pjVU5jaGlMcU5YVnNrenBrOS8v?=
 =?utf-8?B?SVgrR2pkZC9GbW1kVVhqNGFXaUpZSmlOV01nYzlJUzB5UTFQS0c0MXQwYXl6?=
 =?utf-8?B?d2pxQnNVSzlseThwUDNLQnFqVCtyNDg5emJ4WW5YbzBLaHFuUW55M0NxeUQ0?=
 =?utf-8?B?RTdpYnhLajBNRnJ2Rks2T0ZJNFk4Ynd3OTl1Mm92MVZrbjR4dCtTUUx2Y0dl?=
 =?utf-8?B?RlhlREZzUmxsbzh1V0VNVnM2a0Z0MWNaVDhobTk2REc1UjVrTHhxWDY1QWlR?=
 =?utf-8?B?cWpJZ2JTU00xMWxBbi9ZaVRPbkhtZThST1k1dm5VMVVpZ2V2SUhEMjhvK0h0?=
 =?utf-8?B?NWdhVmJ6L2owaytkVmhUVkwrNDFOWDQwTVlVanNuYUdNY1c1dks5bkZ5TzVS?=
 =?utf-8?B?T1lHc3NyNlZzVktMV0dkVSs4LzBqUzVqd3pxTWNiYjlBeHV3OEY3OUdWT210?=
 =?utf-8?B?b3lhNEp1Y0F4dWxFRTJPbTFRY05Xam5DNHkzMmNrbyt1dERuOVNobldUWDIr?=
 =?utf-8?B?YnoxMW4vM3lTcjQzajFkaTY0eitXRW1sK0loaFFUQ2JVL01EYWlsLzIyRXM1?=
 =?utf-8?B?dGx0dlk0cXdKNXJEVUhaM2kwRm1SQW5ZRE4yMHZZaTRkQTlleTltcUVCdEw0?=
 =?utf-8?B?VkJLd3hQUGI1Mzl0UHRaZmhpeE9iVHlmNXFxZXFkT0wxR0JoU1VBRFdQYzNH?=
 =?utf-8?B?RFVjczd0eURXcjVzY2RUTGdIZVZTemc4L05PUmMvWU01akFBbEJhZjVDS1ZH?=
 =?utf-8?B?Wkk3S1ozeE83R2JRYU9Ea2plK3FiNG1qcmJ1cW9wNy9XKzlDeUtRTWJOdXdh?=
 =?utf-8?B?cTRiSjlKcXF5Vk5aN2l0RTRCNlNJUWRuWitUTlBhZG1YTXB3RHZBcG5melZR?=
 =?utf-8?B?T25DODdTRTB4ZDlObkl3SS9NT2ZRNmNzY3ZUV3lFcEtTaGVNdVFFRlFYc2cz?=
 =?utf-8?B?RW5VSWh0b1ZmUlJMdzZ2amlNNmRnRWxwUFA5VHExdzRJbXUvZzNDS1JuWlFN?=
 =?utf-8?B?SzlWRGtjSHBHQlBXYStiV1huYkxJbUpCaDdWbXRqc0tGNFYrWGNYUUNkUVRE?=
 =?utf-8?B?NUNsMHJBWEZoYkN3Z2FhU21PdWs5Q0wxUHNwcnhNWVhkZ0tBMjVUalJKbHhC?=
 =?utf-8?B?VWR2S3NFaEhHRE82b0Qxbk8xOU5NaDN0NTV1clhtRXFJNk9ROWU1bEZNenFX?=
 =?utf-8?B?N1hrbTRGOGZJS2pDYTYxbUNTZTlKTWxkeDNRMnV3djBtRTdHZTB4RHF5NWFw?=
 =?utf-8?B?Q005eEFodGpYZ29sVWVuWTJ4ODcrT3E2VVpMYVN3em41aFkzNGxJTVM3YWo2?=
 =?utf-8?B?ekN0UlM0N2ZtYm9TWEg1czZUSnViOXJ1aXFPaEh5U3VnTzVWYWJGOHdTMTVN?=
 =?utf-8?B?TWZoT2xkL3FXVUZibFhIUlh6U2oySGF6M2JocUtJZFN2SStmTCtLdVFvM3Bv?=
 =?utf-8?B?NW5CUUwveWdaMlhJWDk0b09Xc0FLU1BWVWYxc0phaEVORWZ6bnNVMENsejVo?=
 =?utf-8?B?VzlqSEc4elNaZ3VCSEFaR0FVN1lUbVM3N0F1QW92cU5xTG9sRFZoaHBISFVm?=
 =?utf-8?B?Y0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 371ce608-0f2d-4b3f-f04f-08dd51d12d41
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 17:08:20.8385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J8G/Yq1JdlDMtX0mJ7ZTM4tszFVCcCUn/dTX62Q6NZYrD9QrnlvqzyN7bNzhKBnjhyyAWiQAWHCF3qZZeUjl1QCnbxSWccZT3d8oFuxCpVc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5297
X-OriginatorOrg: intel.com

Hi Dave,

On 2/20/25 5:40 AM, Dave Martin wrote:
> On Thu, Feb 20, 2025 at 11:35:56AM +0100, Peter Newman wrote:
>> Hi Reinette,
>>
>> On Wed, Feb 19, 2025 at 6:55 PM Reinette Chatre
>> <reinette.chatre@intel.com> wrote:
>>>
>>> Hi Dave and Peter,
>>>
>>> On 2/19/25 6:09 AM, Peter Newman wrote:
>>>> Hi Dave,
>>>>
>>>> On Wed, Feb 19, 2025 at 2:41 PM Dave Martin <Dave.Martin@arm.com> wrote:
>>>>>
>>>>> Hi,
>>>>>
>>>>> On Wed, Jan 22, 2025 at 02:20:25PM -0600, Babu Moger wrote:
>>>>>> Assign/unassign counters on resctrl group creation/deletion. Two counters
>>>>>> are required per group, one for MBM total event and one for MBM local
>>>>>> event.
>>>>>>
>>>>>> There are a limited number of counters available for assignment. If these
>>>>>> counters are exhausted, the kernel will display the error message: "Out of
>>>>>> MBM assignable counters". However, it is not necessary to fail the
>>>>>> creation of a group due to assignment failures. Users have the flexibility
>>>>>> to modify the assignments at a later time.
>>>>>
>>>>> If we are doing this, should turning mbm_cntr_assign mode on also
>>>>> trigger auto-assingment for all extant monitoring groups?
>>>>>
>>>>> Either way though, this auto-assignment feels like a potential nuisance
>>>>> for userspace.
>>>
>>> hmmm ... this auto-assignment was created with the goal to help userspace.
>>> In mbm_cntr_assign mode the user will only see data when a counter is assigned
>>> to an event. mbm_cntr_assign mode is selected as default on a system that
>>> supports ABMC. Without auto assignment a user will thus see different
>>> behavior when reading the monitoring events when the user switches to a kernel with
>>> assignable counter support: Before assignable counter support events will have
>>> data, with assignable counter support the events will not have data.
>>>
>>> I understood that interfaces should not behave differently when user space
>>> switches kernels and that is what the auto assignment aims to solve.
>>>
>>>>>
>>>>> If the userspace use-case requires too many monitoring groups for the
>>>>> available counters, then the kernel will auto-assign counters to a
>>>>> random subset of groups which may or may not be the ones that userspace
>>>>> wanted to monitor; then userspace must manually look for the assigned
>>>>> counters and unassign some of them before they can be assigned where
>>>>> userspace actually wanted them.
>>>>>
>>>>> This is not impossible for userspace to cope with, but it feels
>>>>> awkward.
>>>>>
>>>>> Is there a way to inhibit auto-assignment?
>>>>>
>>>>> Or could automatic assignments be considered somehow "weak", so that
>>>>> new explicit assignments can steal automatically assigned counters
>>>>> without the need to unassign them explicitly?
>>>>
>>>> We had an incomplete discussion about this early on[1]. I guess I
>>>> didn't revisit it because I found it was trivial to add a flag that
>>>> inhibits the assignment behavior during mkdir and had moved on to
>>>> bigger issues.
>>>
>>> Could you please remind me how a user will set this flag?
>>
>> Quoting my original suggestion[1]:
>>
>>  "info/L3_MON/mbm_assign_on_mkdir?
>>
>>   boolean (parsed with kstrtobool()), defaulting to true?"
>>
>> After mount, any groups that got counters on creation would have to be
>> cleaned up, but at least that can be done with forward progress once
>> the flag is cleared.
>>
>> I was able to live with that as long as there aren't users polling for
>> resctrl to be mounted and immediately creating groups. For us, a
>> single container manager service manages resctrl.
>>
>>>
>>>>
>>>> If an agent creating directories isn't coordinated with the agent
>>>> managing counters, a series of creating and destroying a group could
>>>> prevent a monitor assignment from ever succeeding because it's not
>>>> possible to atomically discover the name of the new directory that
>>>> stole the previously-available counter and reassign it.
>>>>
>>>> However, if the counter-manager can get all the counters assigned once
>>>> and only move them with atomic reassignments, it will become
>>>> impossible to snatch them with a mkdir.
>>>>
>>>
>>> You have many points that makes auto-assignment not be ideal but I
>>> remain concerned that not doing something like this will break
>>> existing users who are not as familiar with resctrl internals.
>>
>> I agree auto-assignment should be the default. I just want an official
>> way to turn it off.
>>
>> Thanks!
>> -Peter
>>
>> [1] https://lore.kernel.org/lkml/CALPaoCiJ9ELXkij-zsAhxC1hx8UUR+KMPJH6i8c8AT6_mtXs+Q@mail.gmail.com/
>>
> 
> +1
> 
> That's basically my position -- the auto-assignment feels like a
> _potential_ nuisance for ABMC-aware users, but it depends on what they
> are trying to do.  Migration of non-ABMC-aware users will be easier for
> basic use cases if auto-assignment occurs by default (as in this
> series).
> 
> Having an explicit way to turn this off seems perfectly reasonable
> (and could be added later on, if not provided in this series).
> 
> 
> What about the question re whether turning mbm_cntr_assign mode on
> should trigger auto-assignment?
> 
> Currently turning this mode off and then on again has the effect of
> removing all automatic assignments for extant groups.  This feels
> surprising and/or unintentional (?)

Connecting to what you start off by saying I also see auto-assignment
as the way to provide a smooth transition for "non-ABMC-aware" users.

To me a user that turns this mode off and then on again can be
considered as a user that is "ABMC-aware" and turning it "off and then
on again" seems like an intuitive way to get to a "clean slate"
wrt counter assignments. This may also be a convenient way for
an "ABMC-aware" user space to unassign all counters and thus also
helpful if resctrl supports the flag that Peter proposed. The flag
seems to already keep something like this in its context with
a name of "mbm_assign_on_mkdir" that could be interpreted as
"only auto assign on mkdir"?

I am not taking a stand for one or the other approach but instead
trying to be more specific about pros/cons. Could you please provide
more insight in the use case you have in mind so that we can see how
resctrl could behave with few surprises? 

Reinette



