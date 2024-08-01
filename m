Return-Path: <linux-kernel+bounces-271857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B389453F8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 23:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 276B31C22A8D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 21:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4328B14AD38;
	Thu,  1 Aug 2024 21:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="idXzs1Jn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6813514D6E6;
	Thu,  1 Aug 2024 21:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722546343; cv=fail; b=qYQPzX4irKEW6IjgZLMGGl8TFPPzFWwXg6vRgyxXdKDwCkg6swuw7RYs7wV3OV1c0u7TD/JLCTxjeVlTd99petuEUlRz0tIHMWCay4mJ5TjLwWH+hcTcvO1BMXmG0+VpmkOxXDnkZixbt1eRTxh6fcfKLtG/vJqUNmUQjKSZkao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722546343; c=relaxed/simple;
	bh=6HktH/G3/NGncMSKSaDiH3fW5wHbB7nT6nKu28kGN10=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KXErBj+9MxGas/LYqlIbeJCNoozHzF6CSokfhoz/900pSaXWWYrAqSKWwW0e0fj1H6Ebg3V22aoxFbKY+6pPKhhvJj3C5pHwhxrQRSo/Ck2P4TXqTxWglE6GTyRhq4aM4qqeNrySpOfQaB/ju5r3aWpPjGdRkUu6gLYnc3/MXi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=idXzs1Jn; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722546342; x=1754082342;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6HktH/G3/NGncMSKSaDiH3fW5wHbB7nT6nKu28kGN10=;
  b=idXzs1JnICVf5Bqc/bEM25myC5tZGg+MNsEGIIQSqnE8KrpHOGlqaxMd
   CcdC0T/tE+MFaduCEMaphBiOJe9CiHSbo1Fk6hHmHUm0vv594VIXwYYnd
   CAlUgzXRyGAwocSqVO5b3EfLPEoQkX/lvkTEFs63GB//2aWct+wnDeEUb
   3KzzJ5h0FSnthZqw/CNH7iuKTMEKhvrUK+PGvBDTRgj/Ioar1vcp8rYVU
   Ik3u11vszdSFBSDo/9EdseTRtn53/fIatBSA2/1V5CiHDyze4RoLFJUYJ
   r9+yVeui3p1gsqfHY5muiTQjWtaDa4mkiHrKw+Da8lA3/4EpMqTzKX23c
   g==;
X-CSE-ConnectionGUID: CwRKfSzTQzu3/mMOHPAWTw==
X-CSE-MsgGUID: D6cGXGb4QWqiNm3HfdsxRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11151"; a="20425508"
X-IronPort-AV: E=Sophos;i="6.09,255,1716274800"; 
   d="scan'208";a="20425508"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2024 14:05:41 -0700
X-CSE-ConnectionGUID: OGFl4TZnR1C4LvdCZMd42w==
X-CSE-MsgGUID: 9J2qfM1KRrisuUrv5ttfZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,255,1716274800"; 
   d="scan'208";a="92716484"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Aug 2024 14:05:40 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 1 Aug 2024 14:05:38 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 1 Aug 2024 14:05:38 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.49) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 1 Aug 2024 14:05:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ngyQZLdqQ1w9NB2KJD3HXVNL3ji88yTNfQ6xjlf9ZPhO1gcHIMOyM0jyq5dW4ejEDP8NrhivyE9TML8H8kEiJqNBf0a8HoMYYJs1g7SegnAkwYzJo3E3IB9I7IzIteb+yMLA8bIASl/GTXRoQjIR/c7jIitmyLvDZrMKbVMxEhgF8upYWtrFGVyK7ArQkw7rT6AfjsaXUtBm+iI9DP1QsG6TdBKRW8E7JkbZDhUIA/PeFgYUzun5SifO1xyg7VljxEBp4/kA2OY7rFy/2H0VcFHvQ8/cy1LUhx9F+heAiZ9DkmYl7Xys1Vy3c5pXH3gC2slb+aV57MMoAVFHr+RB8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ql/3srw8TuoiX1p7Qg5K7odpEmxqBMbKQYLBcWzVLOc=;
 b=OZH/ftEeFkCNAWPPXZW5oEp+IkrJrX+L2xFUPChe3uDJ77E0nvQaEEN3lSL7N29ktaXgJvzZW2lULAsp8Uta1xD50xrqm0PHy44hxfzxa5aWEEeTVGjlzyH7pdl1TYwRK8uhFtRACMf6HVugZSIczCgGq2iUSVQ9CrU5UEtACLvuRyNdUM8r2mIglIpWGwxYUONmzKr/XOM9onL40dG1CqGb4uDLLBSIVSmG+CgImjH3i7IKyC07dee3SRD+zsHnOeDx+2nbQ7cUu8NCgwXgeMegw38K4oCNWA46L+/qvjmRjHbRmsdirCL+X4Lqp76kIH43ErTmsRBcMSc3zcDcGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA0PR11MB4687.namprd11.prod.outlook.com (2603:10b6:806:96::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Thu, 1 Aug
 2024 21:05:35 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7807.026; Thu, 1 Aug 2024
 21:05:35 +0000
Message-ID: <77124a1f-5440-4627-955f-9fe1d2f4ae18@intel.com>
Date: Thu, 1 Aug 2024 14:05:30 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/20] x86/resctrl: Initialize monitor counters bitmap
To: Peter Newman <peternewman@google.com>, Babu Moger <babu.moger@amd.com>
CC: <corbet@lwn.net>, <fenghua.yu@intel.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
	<yanjiewtw@gmail.com>, <kim.phillips@amd.com>, <lukas.bulwahn@gmail.com>,
	<seanjc@google.com>, <jmattson@google.com>, <leitao@debian.org>,
	<jpoimboe@kernel.org>, <rick.p.edgecombe@intel.com>,
	<kirill.shutemov@linux.intel.com>, <jithu.joseph@intel.com>,
	<kai.huang@intel.com>, <kan.liang@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<sandipan.das@amd.com>, <ilpo.jarvinen@linux.intel.com>,
	<maciej.wieczor-retman@intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <eranian@google.com>, <james.morse@arm.com>
References: <cover.1720043311.git.babu.moger@amd.com>
 <28866653751deb8405f575e40df6f08affdb25d6.1720043311.git.babu.moger@amd.com>
 <CALPaoChGp+JHeyxsqDvix=t=ik5eTqc3bf+ihUL=RXx5p9r5Cw@mail.gmail.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <CALPaoChGp+JHeyxsqDvix=t=ik5eTqc3bf+ihUL=RXx5p9r5Cw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0348.namprd03.prod.outlook.com
 (2603:10b6:303:dc::23) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA0PR11MB4687:EE_
X-MS-Office365-Filtering-Correlation-Id: f3d96b4c-45ef-4d06-7f73-08dcb26dafa4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QmF3Ym42a3RURVF2dWlQQ05Uc3JBT1ljSmY1cWV3enlZZFU5T0NtWXRNYTha?=
 =?utf-8?B?dlNFNnEzMXFXMDZGQk5mQkdQZFMvNnBmS2JyalVoV282THE4U24zMitsbGpY?=
 =?utf-8?B?UUVYMzhNRmlwajEzMTEwU0Jidnp5bk13Z1c3VkI5bHpXOTJGbnN3SmRENDVF?=
 =?utf-8?B?UUFzcWVSVklyY3BuZmQrdTBnTTNjQXQxMWoyL0hxVi9MT09ZY0FrYUVsZUNC?=
 =?utf-8?B?dkdQWDR6Z0VWdXRjT3R6ZHQySThMaUV5RVVacmFBeXg0SmtsRXdkdWNhM0NN?=
 =?utf-8?B?WEdmYzN0dXlCREgvM2k4WXFWWUxhMEZmcEtocWowY3QwcmcreDJwQTBQck10?=
 =?utf-8?B?RXFaamdGRGhCZ2VnWWJUNzF4NHBMaXR6UnVaaWlIaVhXdyt5cGlUOXBTd2dr?=
 =?utf-8?B?K0N3QkpJSXdWWjBBUzI0VTNWdkdhRVFRUTlVYlRXemoxTXE5Y3RFVzIzc1Y4?=
 =?utf-8?B?bTAzZkowODkzVDZIQWkySVp3V1lWVzZlS2NxV0M1NWN1ZVpCSGw0MnhQZHB2?=
 =?utf-8?B?a3BhMU1sS1RhQWZsUFRJVGFqOHd2T0Jwc1BDVTQ5dVA1VURvdVYyOHo4QXl5?=
 =?utf-8?B?K0t3RVJ3L3JESTZRc3JaMlNFVVIxeFcyT3pBQWRHU3BPMHQ5TFhsOUEvR0ZU?=
 =?utf-8?B?Vk9MWFZDVk1VSWFreEtTQ0JYZjJTSFVFVXVWZUo5cWxPWUV0WXd6Lys1cHd6?=
 =?utf-8?B?MkNHb280NGdDcjVqYnpyaWpVbEtYY3B3RW5temRGRkNXYjdNS1Y3cHpPTUMx?=
 =?utf-8?B?Y2t4VHNuZTV5SHBBczRsdFp4U3dMcjFqM1NTYUVRZGNzV2lDd29EcmxJUDlz?=
 =?utf-8?B?Sng1ejlrRVR4RGZUY1V5VUU0SGRJd3VwZHVuVWZaZnV5aHpQdkwweFhpRVp3?=
 =?utf-8?B?Mm50Y3ZORHBOYUtkOEZGdVVXblhkZ3Q1N2Y1ckRMc0N3OGRSN3l6N0dXcUV5?=
 =?utf-8?B?QWl0ZzVRWUZiMjV5cnZSa1NXajZsNUxGbzdrelFLV0w3R3ZqdUJPQlhzdFNh?=
 =?utf-8?B?TWtlL1RmaGZvc21wQzVlQ0JxRlVZVW1LSFJLZWhkbkxQV3djekhIU1YvdlZO?=
 =?utf-8?B?Q2szUVVtcTlaclZ6a0JqMVFTK205ZmtBN1hMZFh0MzlTN3NyeGdGVUVGaHMr?=
 =?utf-8?B?NFFXVmpId25OMGdhWWFBQUtuaFQrZStVbHFYL2gzWG5wWFl5YUJNU3VncDND?=
 =?utf-8?B?bHVVNml5bkZUYkRGNDJyby85ZTBXUlk4QVlPSFAvR0R0RVFjTjNsWmZYbXVP?=
 =?utf-8?B?bHV0V1lDNlpxVFpWWVZxblkxZUozVC9hVVBpaDg5dG9Hb28yQ2wxODNhejA2?=
 =?utf-8?B?RVBJNEM5ajYxN0N3WGQzbGhSNFlTc0pKaXRJYWkxeHg1emZXVCtSc0dkR0JI?=
 =?utf-8?B?VXZJdkFGTTJwT3k0N0NGTmxaZWdZclNpbDJIenBBdDZGcmZGUUNobEVNY1NE?=
 =?utf-8?B?VS9EakJML1JkTFZLQ0JOcitmOGFjUEdxcVFzY3BwaUNDK3R4aVIxTk5nTVdS?=
 =?utf-8?B?SkNSaUR5RWRjN0g2K1E3SkY2RW9IOWJDRHdlY01iN1pYVmZSVXc2YmhXZVFZ?=
 =?utf-8?B?b1cxTGlxN1ZUWjZmbG1nSTdtYzJ5aHI1WWE2cStrTG9aaWtmTForUkdzQVNv?=
 =?utf-8?B?cS9mOUI2N3B1UFVqU3hqTitISllZZk9TVnVZbUxlb3ROemIvWmZYYTh6OXpq?=
 =?utf-8?B?ZEZrVkdiT2Q0Y2toU290OTBQa1FSWFo1cVVqbTU2UUZWMkVQZzFBZTVrVnVD?=
 =?utf-8?B?d1VVOUwrajJtNEczeVJTQ2E3YnBETlNjMWJNMC9ZanppdEN2eHFiczAvdEVj?=
 =?utf-8?B?RG9hTmNaRkk2N0hONFpGQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmFCeHBQY1pWb29PaW1mbTNwcnNxZ3RhUm5URkJQZjNqOTJ6RHcvd3dVS2ta?=
 =?utf-8?B?ZllrNHUza0h6WDlBNi9mdlZUbmdoMU10cTVOSUJYaGsrNlVlZFExRlJ5OVI2?=
 =?utf-8?B?UXNoSURlSTlhRERVV0xDeHJ0UktGUjdCQnVmVWxrbGJ1SDFIeGozQ1dzTFR0?=
 =?utf-8?B?MTdJWjBpRDBBeGtRdW1OUlYySDd6c0N0N1JrL2ZpZ21JNnpEYWQxdzVqRENF?=
 =?utf-8?B?cGFjek40d0p3Rk9RY2lTL1NVTk9XVHkzZUtOc0FSTm9aSVozc3ZScmZlNTRr?=
 =?utf-8?B?WVFUVitRVHBuRC9wQ0Y1amVJQUhnMGxpcjJVN3JJajB6emgrQkx3azR0SnVW?=
 =?utf-8?B?SGU1bmdxUEpxdVN2SlVWWG0yeWd3R3FidUVVOFYrRDRLbjFQYzlBS1BEUTdR?=
 =?utf-8?B?amV5R3JIbWtaT2MvTWV5U2svUGtVVFZFODJPNHQ2bHRaUFN2RUZ5d2hmRzdT?=
 =?utf-8?B?WXZLdmJ3OGJEcEgzSEE4djhIb3ZFZEtvL3haQUMwaW5IaEFHQTdzVC82VzNi?=
 =?utf-8?B?RjlsOXBjYVZQanJJeDltc2Y0SmxUL1VjWFVudkVjelJzTkdUVGhxcjRVT2lj?=
 =?utf-8?B?NmNQRmdvOThMMjc1V05FTnZ5ZGJmSWVxODVQUkFua2hlckoyL044ajRSTk9v?=
 =?utf-8?B?MW5WTmd2dXZteUJ2ZHREWmlQRysxVWxnRHN0Zm4vV0dPWWNGZk5TTFA0c2cr?=
 =?utf-8?B?SG5DVTFIV0ZqcXN2V0RiZnB2Mk9qVTJyMy9SSW9ndXlRVy8zM0t3L2FjNFVp?=
 =?utf-8?B?V1JhNzlDTmpZWVF2NDdxWmxDUC9jbmFTMm9EVk84NnoySGdxbm1wanpUVllR?=
 =?utf-8?B?N1RNY1p5YjZVNHhlK2FlTjFlZ0lZdEt1bHJoZ0pOV1B6eHVSb0JNV0Frc2NJ?=
 =?utf-8?B?OExOcnRiTmFKTDBycmVEQVU3NGJWc2dvZFNOTUZUdWtvWW9qWEttZDRIRnlB?=
 =?utf-8?B?QXNiWjJJOXNnSStQT2kvQ2RWbmozWTMrcXFLUTlKb0t1NW9ybGFvQ3hwMHFQ?=
 =?utf-8?B?QzZUdnZRMUlXQTB5dFpveEtPYVBmM2VrOEwvQldTbFF0REgrWWNZRGFOMWJ6?=
 =?utf-8?B?WWVUYkVTM2E0ZWNoY0M4OWc1RDNqZHBib2crSG9UbTdwYnBjZ3RzaGVXczdT?=
 =?utf-8?B?SGVVTllwRm1aVG5LY2p1K29sV2Yrd284ZXBZb3VEKzErSVF6Q2R0bzh0OUhw?=
 =?utf-8?B?T2Y2OVJQOE5qVkZEWXQzUnBOU3pEWmdINWY2TTVacThPL3F1TXVMdDV0d2JT?=
 =?utf-8?B?aEFMVE1HK3dpWVU1dUFIN0NyYUNtUmlyWmZpR0xBeDRSVlA0eklodmhJNUZD?=
 =?utf-8?B?L2F1dzJpT0EzVFFtR2JnNk1kaFZJemxhMTJRSHBTL3VIK0hGUkFJSFBPdGww?=
 =?utf-8?B?a3JpRnJoS0pvYzBJckpFdjhpT2NEWk56SE1tak94SE9acXhGclVJTmpFVXZU?=
 =?utf-8?B?Z1NvTEc4TW9FWHRaSGRNbmdydjZJa09IbURMQ0VzYnlYbDNZMXJhcnpaSjUx?=
 =?utf-8?B?TTVoK044MnlLdlN2QlBjOGp1SVhoN1kyWmlVZXVXd0FSUUVwL1VrczBKUHBp?=
 =?utf-8?B?Rlg4Zlh6dGY5cUhoeHZPVmNINzNHSE52VEcwdmlWVTdtTnRpbUgyZjdwSm53?=
 =?utf-8?B?bVJvbXhGaEJDVFBLcTJURkxEL3hnQVM3Rmo0c1JZSzh4NHNtaW9pTzI5Zk0z?=
 =?utf-8?B?c3g3Z1Zrakl1QUxURHphb3c3dlJLKzlTeW5iTWx2TTBEcDkrSy9BenJmaksy?=
 =?utf-8?B?SUFxSjJqUFBldmFhcDNibmwvNUhpT3RaTnZMRFk1SS9PZS9mNFFjTzlFVTk5?=
 =?utf-8?B?MVBhYUsyYXBSdzE2eTNPTUZGZ09uN256STBEcGwvdFF0S1RUVEhXWSswWCtk?=
 =?utf-8?B?TG9yZkp5MVdnajdCclBqMjdWWEp2OWI2VG4xR0RNcDhwN0trM2dVTkljS2Qy?=
 =?utf-8?B?MWFqSDFuMitEcjZnQmVkMWFRVzNCZzN4WlhMbXhyYXh4Tzk2bmQ1b3ZnZlAx?=
 =?utf-8?B?K2Q2SHZvSWZRU29iRlgxZHk1YmFyUncwSkMvQnBlLzd0MkwyaUhFNGFyVFph?=
 =?utf-8?B?RDZIMGg5dGt1T2NMeTV4S3ZQdWtlL1VYRkxpa3k4S0VweDFHRGxSYzVJTXZC?=
 =?utf-8?B?aXFVb0J6Q284QTE1OGkzQWlRdWpzenF2dmxRUVdxQWdNS2lNaCtIbU5oUVRn?=
 =?utf-8?B?SFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f3d96b4c-45ef-4d06-7f73-08dcb26dafa4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 21:05:34.9354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zgHzuIFa8pf8j05jADdM+tnguiXv4dt4+QH8mV7/EhTAKh1uDqfeygBbrYkqwKw6NzOgw2g8XUr7Ck+Noloo3AaK7HtvTlsHtkZQIKEMVzA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4687
X-OriginatorOrg: intel.com

Hi Peter,

On 7/26/24 3:48 PM, Peter Newman wrote:
> Hi Babu,
> 
> On Wed, Jul 3, 2024 at 2:50 PM Babu Moger <babu.moger@amd.com> wrote:
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 4f47f52e01c2..b3d3fa048f15 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -185,6 +185,23 @@ bool closid_allocated(unsigned int closid)
>>          return !test_bit(closid, &closid_free_map);
>>   }
>>
>> +/*
>> + * Counter bitmap and its length for tracking available counters.
>> + * ABMC feature provides set of hardware counters for enabling events.
>> + * Each event takes one hardware counter. Kernel needs to keep track
>> + * of number of available counters.
>> + */
>> +static unsigned long mbm_cntrs_free_map;
>> +static unsigned int mbm_cntrs_free_map_len;
> 
> If counter assignment is supported at a per-domain granularity, then
> counter id allocation needs to be done per-domain rather than
> globally. For example, if I free a counter from one group in a

It is not obvious to me that counter assignment supported per-domain
requires allocation per-domain. I think this may get complicated when
resources are monitored with one counter when tasks run in one domain
and another counter when the same tasks run in another domain.

> particular domain, it should be available to allocate to another group
> only in that domain.
> 
> When I attempt this using the current series, the resulting behavior
> is quite interesting. I noticed Reinette also commented on this later
> in the series, noticing that counters are only allocated permanently
> to groups and never move as a result of writing to mbm_control.

As I understand this is separate from how the counter is allocated, but instead
just a gap in current implementation of intended interface.

> 
> # grep 'g1[45]' info/L3_MON/mbm_control
> test/g14/0=tl;1=tl;2=tl;3=tl;4=tl;5=tl;6=tl;7=tl;8=tl;9=tl;10=tl;11=tl;12=tl;13=tl;14=tl;15=tl;16=tl;17=tl;18=tl;19=tl;20=tl;21=tl;22=tl;23=tl;24=tl;25=tl;26=tl;27=tl;28=tl;29=tl;30=tl;31=tl;
> test/g15/0=_;1=_;2=_;3=_;4=_;5=_;6=_;7=_;8=_;9=_;10=_;11=_;12=_;13=_;14=_;15=_;16=_;17=_;18=_;19=_;20=_;21=_;22=_;23=_;24=_;25=_;26=_;27=_;28=_;29=_;30=_;31=_;
> 
> [domains 2-31 omitted for clarity below]
> 
> # echo 'test/g14/1-t' > info/L3_MON/mbm_control
> # grep 'g1[45]' info/L3_MON/mbm_control
> test/g14/0=tl;1=l;
> test/g15/0=_;1=_;
> 
> # echo "test/g15/1+t" > info/L3_MON/mbm_control
> # grep 'g1[45]' info/L3_MON/mbm_control
> test/g14/0=tl;1=_;
> test/g15/0=_;1=_;

Thank you very much for trying this out.

Reinette



