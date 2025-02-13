Return-Path: <linux-kernel+bounces-513430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09258A349F0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A38F77A6042
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB6E28A2B8;
	Thu, 13 Feb 2025 16:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eMCOpdod"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753F328960B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 16:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739463701; cv=fail; b=mRPxQ1LWtkBr3af3rM4WSWcmatjpy8uhL4GFy2xhh4TFFZ3z/kOBJwiC0H2yLpDnxyNWhmlQu2DDdX8UQgeInBBY6+zOmURkgg1kmLFewwgQLq7WEybUebiONLg0MGtsjsk9vHqxXZUu4ZnNTvzvtalzoGT3THZTFBqiCkTdXjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739463701; c=relaxed/simple;
	bh=EDlxYMoM65zZ8cVr9ue59rSB4mFHnNsj4zWWLl0SRy4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C/YN+Edn1vKbB9O3lUhcZCJVRYxMRI1ddSdx0OTfKkH4r/3XwUXXnjCNdgA/3By5Esj87KUIqSPhpVDqIemEv0dZgcQk4a7Mpnjp9Aec4hOJ7jGkYCRuqE2G3lW2dMw6aUUpciGVtjb18dlKUl8A2Z3BPCnE/LPXRwytFwo+2bM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eMCOpdod; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739463700; x=1770999700;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EDlxYMoM65zZ8cVr9ue59rSB4mFHnNsj4zWWLl0SRy4=;
  b=eMCOpdodAvrUx0Hmw5lYoWDe89od8aPfmVSOUmsnzryxdzmViBnKFrkb
   7VgBjgM6EXNEpZUxfMEN5MlgGcXO1oUVXyW3o97inB8SGh4LUEcFAd3yp
   P2rBmt25z9XoW9hJkksFS304zEJbgTAY1JHeiLZ6LEzVNwmbf6uoI7NnW
   xJYq9mql4XhXYLb4dwfOFKJSskb+7PV2m6aMb9UdjJMmbVmYmOhDMt9Ky
   zP81DnZe6BfpO+HdWBSngYCwPvVbpqIUlCi29OBq/4wDAQw+d5QuALU4E
   1ioaSdw4CHbpm+4OCQKHTJ7bRe5xd/loUAdDrdpqDJb4exolvX2Hw2DE7
   g==;
X-CSE-ConnectionGUID: sbWuATmlS16x8u1rhvk+lw==
X-CSE-MsgGUID: ZYCwkvyhT0aBTzSmasG3hw==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="57580371"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="57580371"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 08:21:36 -0800
X-CSE-ConnectionGUID: zWI9NaFXSMCbutmSGSbIJQ==
X-CSE-MsgGUID: z882zHQzQ+G7reYFWliumA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="118274934"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Feb 2025 08:21:35 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 13 Feb 2025 08:21:34 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 13 Feb 2025 08:21:34 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Feb 2025 08:21:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wTh8Gp813llKVBqGeqq8j0obrCDiqvFMoqKnyE2NdOn2gXsHpul1SffkLmq6rvsNT8mtgh5/9DYLGA8rdTwVDwpvrSWNiVrPu5CVhbg7r9EZCnaTe3pwwOFkwtsjyCQpzQSR2HzCQK6qYo3OPVWUgOQE9NzQfUfHit6RjY0zfJwXlxS2YZazTI7ABfFo+fpf1072rVCdQzQ0KPAhnOltw1fg1CXkrQ2vo/xZXc5poOYQFh4DQhX7tL0HhfCvkBbFBCkwg9oYLNQc7Nxqu0ZBIcSUVJVXa1rZwK504k8VDwhRn0G3ZDPrKdfoyvmh3lmloJIIb7POJPn662ZvQxucUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qt86PNLnj9x08EPHEY5RtVbZwe1utxorvWi+UkMjU0w=;
 b=wwRee+nM/7Xb0mFh+OVVGsmPlGsDvKDdIdTozjQ7q9sIFhaBHGvpY+KnCWFJ2Xwm/jYcl7AWu0mdiQawGUou2nmnmpVeD+r2tbJa2RM7jjG0sUnhzlxUTAkfF2Q4hy4ypw1HkzoN9xeIdbEKpSLFO7cozV7LxTuT2mTRKDornH2c+wJouI/u7X8WYAzd+bDGx9cZxhREamWv2AipjXUsg/dNN3ZBmwWTtGBuM7r7BUb7fFjNWIZuYRpjc4jd2TMjpEqFsFm4z6GywQi+tQXYBiuatAHB1Dm9xzWkar4KGxhp9hO4MtxOKiPRVWMdk7NEWAiiT52QxvfSAqIh8MW26Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6269.namprd11.prod.outlook.com (2603:10b6:8:97::14) by
 SA0PR11MB4751.namprd11.prod.outlook.com (2603:10b6:806:73::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.13; Thu, 13 Feb 2025 16:21:32 +0000
Received: from DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::af1f:dcc:49bf:1a26]) by DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::af1f:dcc:49bf:1a26%3]) with mapi id 15.20.8422.015; Thu, 13 Feb 2025
 16:21:32 +0000
Message-ID: <be7e3c9d-208a-4bda-b8cf-9119f3e0c4ce@intel.com>
Date: Thu, 13 Feb 2025 10:21:26 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] tsm: Unified Measurement Register ABI for TVMs
To: Dave Hansen <dave.hansen@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, "Kirill A. Shutemov"
	<kirill.shutemov@linux.intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>, "Kuppuswamy
 Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20250212-tdx-rtmr-v1-0-9795dc49e132@intel.com>
 <15c69d57-4ffb-4ea1-8cbc-0ba6d3d7b14f@intel.com>
Content-Language: en-US
From: "Xing, Cedric" <cedric.xing@intel.com>
In-Reply-To: <15c69d57-4ffb-4ea1-8cbc-0ba6d3d7b14f@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0040.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::15) To DS7PR11MB6269.namprd11.prod.outlook.com
 (2603:10b6:8:97::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6269:EE_|SA0PR11MB4751:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fe6f6bd-4410-46fc-fbe8-08dd4c4a7a47
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YmFNNVZqamZ5RlE4S3NIZU9qNXJNWjRWNWZPaTVqU2orYUhwL3VncGNtelho?=
 =?utf-8?B?SnByTVowcERLVHhCbExUaEpDR3BrYVF2c0dLbGJ6YXhmeFdPRFVhcG0rc01h?=
 =?utf-8?B?anlhRDI0ckJGYzFla0prYlRhUWFlSXUxUitNZWtEbURkeTZkU2JRUkxjU2VE?=
 =?utf-8?B?ZFJOWU1WdmJiU1M4R2s3RkNYK3VuMXpUdWJxTTRaWXlFYWxIUXEvSTc1SjMz?=
 =?utf-8?B?aU5KNWwyVXYrQnFzUnV6OHFOVlh0Q0JCUUJjVXZKZGFQUEtSaXRiK3FBbU1Z?=
 =?utf-8?B?aDZydFZDdEtOTUtySTlPNjJFNVU4Y3EydUlqQi9HSUpHNkZLWGo5TGhoelBO?=
 =?utf-8?B?Z0lwdWtIZkZsdjlBNXVvVHpLZXFwbUhSZ1NLQjJDZUJJNVF1K3V0STBabW0z?=
 =?utf-8?B?blQ5VWE0OHFRTXpmM3NFSjJrU3hmQmljV1VjaTNITWMvdmdONnFyZTE3V0RN?=
 =?utf-8?B?NHVncHNncWt3ZUIyditsdHM2alRpRzdIMFF3ZzE0WHNscm5pRU1KTWg1MkZH?=
 =?utf-8?B?ZnFyREVQV242ckpVUWhUSEdCYjNYTTRFb2ZXTk9sNlVONEVFOVpscXRYbWR6?=
 =?utf-8?B?OG53M0Y0cDB0dGdZbG1Vc294NURJRjhmaC8xRnVwZnZ5L2R5SWhlclhLRFFZ?=
 =?utf-8?B?WVI3bWpkdnBhdU1YSWRxTEFvUHN5K1hjUmlIVHNyei9rcXJwMXRJQ2VERVlD?=
 =?utf-8?B?OWg3YXVUNDlVUGpTYkYyLzV3eDB1b0JQenBqYjR4ejM4TThXa0dST1BuN2d0?=
 =?utf-8?B?THN5QjNTUTdwUFVwN1B0cGNudHJzTlloNmpOQnJPRE9wZThWTjZRWEpnMk14?=
 =?utf-8?B?a1Uwb3IvQXpyRlFSQzV2bTdydmxMMS93Y1lYSVFxL2QrV3BqL2luZy9kTHMw?=
 =?utf-8?B?S2pMNE1sZ3hBWTNhZ2pMMFBIU1Q3MjNZNlM3aWcwWCtSOW1TbVVwZk9CSyta?=
 =?utf-8?B?d3hYZmI5dXE4OXJsWFpNOHAxUDZjZTdQZEkwb2NwYUZnUjZRSlNHaUtXdTFL?=
 =?utf-8?B?Rk1VcThLWHduQ3IxRWJ1ejdWL2N2NXpSa1hNQnM4Z2NSSFNlc2JJYUtpbm1p?=
 =?utf-8?B?REF6bFN2cHhRNzZXOWovTTdNS01wWFVLNkZkbkVwcFRVcG5PcWdnMksweGVn?=
 =?utf-8?B?OTA3dFBydWprWXNFdUU3eVF2Y1k5bDR5N2ljQlRSTmtwZkZoWmkrR1pWcmxR?=
 =?utf-8?B?ZnJLa2FRRDIvUWh0NkNvbkdQdi9Idy8ydVpmdVA3RGhCazBsRyswZnVycUJh?=
 =?utf-8?B?bEIvbG9lSzArL1FLOVhWaGxaZlZCRjFhZmxoTmw5N3d3SnBrQ0Z2UitzVmZQ?=
 =?utf-8?B?TjRCclg2TXJsZms5SmlqOVhtdmlaR1VPUGVRMHptWG9xVU9mTWFXU0VxL2VU?=
 =?utf-8?B?dWdQeFdIMkdOcysyYmxTekNXUzdoQk0zeHYvZi9WNVJublduY2ZxNU9tejlo?=
 =?utf-8?B?ZEttK1c0MWRCaHZOTjdWNTNFVk50QU9EQ1hnZE54SmgwSWdjSDlscWltVFUv?=
 =?utf-8?B?Z1JET0lRRVZtaU9QLzZHRzBhYy9kenZKa1lwRXVKbERLYmxFM1paT1JQVjRK?=
 =?utf-8?B?S3VEUFRDWHpjRndsUjB2NVBNSTMwR3hwcVpIZUc1UWxUdFlrYnUwTHBydjdU?=
 =?utf-8?B?S1oxRW84emx5NnZuWERNTGFLTVVuWFVycWdNK1JJa29JMHZ2TGh3ZFJ0Q0xO?=
 =?utf-8?B?clB6eENTK3dTaHZmclg3alJuaXpLMm5Mb1ZXV3VBTkI4Qjd3SktjSEVQRWRM?=
 =?utf-8?B?TEl2T2h4YWVpZkN6QTlZaWJNQmFEazJnL1AxS1N4a2dQYk9GcjJVVFhKRW14?=
 =?utf-8?B?UVM2VWR1NHpBWERRNFhsVm1qNGkzN1pBS0N2WW50SU41UkJzUUQxZVJZZUVk?=
 =?utf-8?Q?1P/3hu5ZtA/+x?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6269.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0MzeXlWSDFPTVNWY00zOVh4cWVhK2pSR0huK3lNSGlvYkhVZjdHU3VPSWNL?=
 =?utf-8?B?d0dMK2JiRlVyU1JlTUlnV0QrS2FyMXlVdmZIQVE4c0Q4clRGcFhFdTVxa3Bv?=
 =?utf-8?B?Z2NuVkRta1l2Q20vdWl4V0VUQzBCaTF3a0hOTG1GUjU1SWxFeGlrUSsxZE1Z?=
 =?utf-8?B?WnZueWNHSWRrTkpvVmNnSW03aU9IMlBNRE5ROU9zdWNzYWltRzlISHFyOGtT?=
 =?utf-8?B?ZzJLNSthWmlHVHQ4blJqU3lrd3lXbkVjQWNiQ2xRVXM2aTdqcEhHWEprTEV2?=
 =?utf-8?B?S1V0bC8rSjJQUFdzdENQWDdoTXBSd2oyb0NKRFBPcURmRWJzV3k5dzJzajNq?=
 =?utf-8?B?MS9Wd3gxUW5sOGs4dlZSeTFieTVRZ1BIWFFtc0Q5WGRWYm8zbjBZNzBHUmM0?=
 =?utf-8?B?a3pXSUF6S1lTRWFTMVBFTWJLa3h3aVBnOFRRdFZDaFVNakkyWUFXOUdoSWJB?=
 =?utf-8?B?Zk14Nm8zb2QyaFhHbDFsUVpJY1Y5K0I5K0Nud2YyWG9uZlFWV2d2TXJ0NGNm?=
 =?utf-8?B?aDcxTTJSaFZJRktGZzcyVzZtL0lWSGpYK0wxTGd1WS9DTS9XZHdreEdQWU5Y?=
 =?utf-8?B?SzVndU9CYXlCRHdUc2hHM1Fpcnd4QXBRTURLelljbk1od0R6ekhYbXFWd0Vi?=
 =?utf-8?B?eHdya2RHbkdNaU5GcU9LUWJzUjlZalI0cTRIVnhVb1ZMQkkzUTBUbG5lK1lL?=
 =?utf-8?B?anFkbWVrdWVNVEZUMUx6amlZV1Qwbm14MmxWUnZQdEk3QVYwZnUyc0U2NHpp?=
 =?utf-8?B?TW1vU1VKdlp1RXJUNjJOM1NFMUZJT3ozbVQ0SktpTC9WTzlXY2dENCtBQ1pT?=
 =?utf-8?B?anpLTHROS09idWwxUFJtM3IxOVVpM29oNUxGR21iczZ6UEZEdzN3RVRPdDJQ?=
 =?utf-8?B?Vlh3Rlo4dTZCclJ6WTliWXp0Uk11aVFtK1IzSm56d0swZHh5UEtQa0dXbncr?=
 =?utf-8?B?QmFDMXh4K2xtUjkrcXQ2OUFUTXkzRFJVTUZRMUpxc2tvUEZpQWxmckdKcHg0?=
 =?utf-8?B?L0FuUURWVWVJLy9wcU1wclhyUVBJYXJzRGhOWHA3Mk8xbitIWWJVS3A4OUNo?=
 =?utf-8?B?YkcvVm9NMFNLRVdycm13eWpVWVBWcm0vMFpWWkp4WWVPUmNtU1FuNlhLRFYv?=
 =?utf-8?B?bjg1THZrNHdKNWVrdzZKKytFK0oyUG9taFcrU2ZhOWJqYnBwS0xnUEFLWUVa?=
 =?utf-8?B?NVpEZFU1U2N6OThDVEhNUGlyN1d4V0o4NEIvUmtsTTBVVHFkaEJTWXlzaWY4?=
 =?utf-8?B?dU9yOVRtS1NybEtOekEzNTBYd0kycW42aG12eGFtejFuRVJLUnh2cmgvM1JG?=
 =?utf-8?B?YVZPTVZFVGtTVE1PMSs0UUtialp1OWxaeVBsT21EMnZ0M3ZvQ3RDMHVWQXJG?=
 =?utf-8?B?d3FNUFJqQW11REswRmpDZEsrbytYaW5BK1VUeXFTUHh2enNRRmNxYlByekgw?=
 =?utf-8?B?VDg5cUdPYmZha0RURFZnaFkzQ2tqNlAvalNpdUx5QUkySkZzZ0NvSmM3YVk5?=
 =?utf-8?B?dXNDeXorTk85T0RNWHRTOTZxMmVYcmt5WHFTV0JmZ09MVG80aTJORkxya1RF?=
 =?utf-8?B?QmJzT2s2a1VzOU9QNGY2STBqYldyc1lqSmx5dkZiNEo2Qk1Wb1dsYVA0Tmgv?=
 =?utf-8?B?MU10ZndKSGNvU3FHTll1d2JyRlJnV1NXZmFucjg3dGFOQThOczYycXdsTGty?=
 =?utf-8?B?VC9QTnBkam1EenNHVDF3aUtNQ1dySDYvaklIeFhyTEpmemR3b0hvek9IdU42?=
 =?utf-8?B?bkt3ZWt3dUplazBtN3o4amtacHgzY1EvN0U2d2RVa21mODdYdkxrNDc3Y09E?=
 =?utf-8?B?bWlSYU5xcjdzRDBZQmlsMG9mZ0NNZVFzVkw2NTNNTFI0Z04wUncrdTMyR0c3?=
 =?utf-8?B?dlRwaC8xbzdXQnpac00vSFU0L0I2V0xHQ3M4WWxuN2JBNUxUc1RkY3JmSEhL?=
 =?utf-8?B?OEpXM2M5RG9lMWtWSS8rcnZXcm9XaFE1OW12VDVvK0Vwdmo2bm90NEt3clJ0?=
 =?utf-8?B?aERPZTJtZWN3ZDNqUnFmdndTN2FIZXBVRXdSY21zUzZvN3pWcDZ3ZnM3QlQ3?=
 =?utf-8?B?WmNXcmkvbE40ZTYyRGN2RUNBSm1GQlhrTEkxK0wvSStMK2N6QXloMlpNT1A3?=
 =?utf-8?Q?9vfU+rFSWqv2QVdGd4GXw5FBV?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fe6f6bd-4410-46fc-fbe8-08dd4c4a7a47
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6269.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 16:21:32.1014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yWfUVCVxrPD0J/M+w6RNzJDtibIOcXafMNAxmWXhUKENkNYrzzf/b78esztaOn/O32//1wnzaUDFdyyyWgvm7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4751
X-OriginatorOrg: intel.com

On 2/12/2025 10:50 PM, Dave Hansen wrote:
> On 2/12/25 18:23, Cedric Xing wrote:
>> NOTE: This patch series introduces the Measurement Register (MR) ABI, and
>> is a continuation of the RFC series on the same topic [1].
> 
> Hi Cedric,
> 
> Could you please explain how the benefits of this series are helpful to
> end users?

This series exposes MRs as sysfs attributes, allowing end users to 
access them effortlessly without needing to write any code. This 
simplifies the process of debugging and diagnosing measurement-related 
issues. Additionally, it makes the CC architecture more intuitive for 
newcomers.

