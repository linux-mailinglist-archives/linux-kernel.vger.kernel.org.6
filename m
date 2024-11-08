Return-Path: <linux-kernel+bounces-402201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D36189C24FB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 19:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 960152846CA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 18:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DB11A9B41;
	Fri,  8 Nov 2024 18:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dCOfIvzC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FB519994F
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 18:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731091381; cv=fail; b=FzGlDCu+l9OCOsXGwixJVpnXAtek5AR44P7FB2igfEcYhxzIr0D14wQcMJ1pne066h3gesj9i3zReklEsNo2XKQM9Ox1juLkI6Qz1Yz40ujw+/DH9xVgb2WIZfpxyQUEJdy/0M1uhrLNMvmengs9ihMuZ8LIwcjdPLVYU3fwYqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731091381; c=relaxed/simple;
	bh=LJgREsxecaS3DWpzJclzvkgd0ukRUwDQ+l2Lo0YPdSQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CUWEvqNVKLxeqiCaq2RqyKxU0PvxGBcfXpYxTxKxs09Brsun2ZCjgRQENvL88+aj268dO50W0K4Nna1SGFObNSpg29WZSYE2m0y8GWkqArbvil/fh8bCOT5SXztrVLf5tIgT8lkNKCH2z9bmT4e4Knsp3g6EN7CMMkgHoMNCjSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dCOfIvzC; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731091380; x=1762627380;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LJgREsxecaS3DWpzJclzvkgd0ukRUwDQ+l2Lo0YPdSQ=;
  b=dCOfIvzC7jx0zbhUARlEfcxoxDQMQERG9deOlCzkiduCHqwdD4P1Agxl
   Or/kEQmnurGY4+IvXvaCe60jlWm71JgvrkUcgq4FlgRxDvtOpP3MS72ou
   xHTFzuoUFuIqgpEuUF7bZ5eGX4P0FYoz2TSgvn1CBqShFPIrfhxihlHbI
   bB8a9lSOyekQ8ujkQvmPGxDO+9AQOQPTEtKrMUNw8WilOREXg1VKUEbmH
   y7pFu82aSTxXJSylXxioQQ89shlKXHN9GBA8ij2Zk+wegIxJyZpWBro+n
   v/dbzHB7qS7Bb5wAOnBSCAV9li3/mIHjGeHbkNoGQIAzgdnsfrgoToq8F
   g==;
X-CSE-ConnectionGUID: U2rECcCVQhGefl2tXf53FA==
X-CSE-MsgGUID: sSyOo+TVSRy4rMqXFFSx1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11250"; a="33845161"
X-IronPort-AV: E=Sophos;i="6.12,138,1728975600"; 
   d="scan'208";a="33845161"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 10:42:59 -0800
X-CSE-ConnectionGUID: hLhOXy0MQaCIS738KpXGMA==
X-CSE-MsgGUID: cZ2MnPPpTieEPL2NUTt4jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="90507969"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Nov 2024 10:42:59 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 8 Nov 2024 10:42:58 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 8 Nov 2024 10:42:58 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 8 Nov 2024 10:42:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MUsBEl+P1hrjS8IGdLt6xMakvg7no+MWTAS8vr1ZcUL+sASwMVDXSVHtDLr+DnFjHxDDay/DVx8NquBKRkTV/GO645XDjHhqqS4x61zAOtWx9zwMhdMbibwdjJcr8CnKRxTVqp3eNex1IaJy0WqiUXuBamt89eB6sfG0Zwh2/A6n+CveblNFKvaK4wB4i9W1CNtEBbCuPufYOR4PNlOFo/a7ucSY75O2C2U3JIILtDfwMBRPVVFkHAn2+hikjkF2ZMHIlR1tS6XdPNoLPNJqiLCt5tsKd2/sJk0k3xwotmvVWVnmigrqF6tmGOUwbKBTrb+EUfQNdDMLZ3dVEP/I6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zALUw618L1LMaAKhI3Efp3LpiViAK+UvXJfir7plhZY=;
 b=E7ZLqLIWJishCASPSX7gadQrY7KarHG8w2WFZMHQQQdhWerJA5EM8OlhAdySX4s1ECvmM5F5iz4krpPXCtJ9BI4+vFL3kj9XV7YD4M0Vf7mqUtKz3drPs6QXfPYaXtO9SI+QRwtEYvtKtyJe8HTqAwVhHRJeg+ORN39+QsezNVigTgoSMCXB2moYfC8M2XfoCOSiRbl3UBUp7AT3Q99KCfI8cufDAo8uWOisvxArRtgczsM5hRxvwGclGbq2xIcpFk1MU7XxqA+VwVOXP3Gsz6/4CgKdSlJAsZotLcvBZyb70yjWUiikZT5Rgj+uxXkwYx4nZ6nr4DgKtesVut5q4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by SN7PR11MB7017.namprd11.prod.outlook.com (2603:10b6:806:2ac::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Fri, 8 Nov
 2024 18:42:56 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%5]) with mapi id 15.20.8114.023; Fri, 8 Nov 2024
 18:42:56 +0000
Message-ID: <ee05e1a2-3844-4648-b9d5-7534de94d85e@intel.com>
Date: Fri, 8 Nov 2024 10:42:55 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/cpufeatures: Free up unused feature bits
To: Dave Hansen <dave.hansen@intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
	<x86@kernel.org>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	"Sean Christopherson" <seanjc@google.com>, Tony Luck <tony.luck@intel.com>,
	<linux-kernel@vger.kernel.org>
References: <20241107233000.2742619-1-sohil.mehta@intel.com>
 <7ff32a10-1950-434b-8820-bb7c3b408544@intel.com>
 <3492e85d-4aaa-4dd7-9e6a-c8fdc2aa2178@intel.com>
 <74338393-4F39-4A04-83B1-BA64CE2D2FDA@zytor.com>
 <4c01a30a-67d9-4918-8781-240b78944c42@intel.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <4c01a30a-67d9-4918-8781-240b78944c42@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0191.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::16) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|SN7PR11MB7017:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dbf72f6-ff9a-4fc9-3974-08dd00252949
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RjVYV1Y5ZWJCeUtXaUZOWFp5bXRyZVpVTklMOGxORU42M1pxRVk4VmE1TVlh?=
 =?utf-8?B?bVdYODVld0JsRmJsbkJBWTZLQjR5QVJ5OUJtSE43cTlrSnJvTTcwL1lZZnUr?=
 =?utf-8?B?NW41VUM3S1o1eGRjNytldC9iemxZTDV4b3dJRW1haG5ZNkROa3ZWbHBlTUd5?=
 =?utf-8?B?S3YzNDlSUStOa1JpcGE4a0dpbjlNemxSTUgrK2IrMVY5UkdZVUdQS3dQTE9i?=
 =?utf-8?B?NTVUMjRRTVk3ODlQS0VkNmh2QkhENzJYWTVZYllSS29GcDdkY3M2TU5qYld0?=
 =?utf-8?B?c2M4d3d5RWoyc3I0TUxhc1BmdmhBU3FoSmxYZXJuZlVLNHRpUHJVR3NXOHFq?=
 =?utf-8?B?U2FiOFNVY2FZS1JBZ1p2Vk8vN0ZLMkRGRnpPZE1sMDV6eXRINm5yTnk5aFc3?=
 =?utf-8?B?bzRnNnNlVld0dnh3WWlyQjJiMjN2TUtGa2hkU1ZGVWNZTHRyTDUvWHkwYm13?=
 =?utf-8?B?Z01qRDdESWZJazJlUisyb2NPcXVEb0lsd2E5NUZWcEMvSFY1TUNkSTB2UjZ6?=
 =?utf-8?B?eGlDVGlURDRJQzl1KzAwNWpzK2VHZzNFL3ptaVdDYjhhSGtKSDRwY002L3Rh?=
 =?utf-8?B?RW1kS2oxQkNqSEU0RGNxNUdreVZJdjU3VVdqZHpGcXZNZDByZkJhRGhtbG9h?=
 =?utf-8?B?ZkdxUUFna2VYc2hKVFVQQnBWRjdNVEpDUmFKZTkwU1AreE9zeTZpSVFGMzNn?=
 =?utf-8?B?ZXVVN01FREw4bVRZNmE3akFjc0hxRlJHQ1BSQlZCYmM5NXUvY01IeTFuQ2t4?=
 =?utf-8?B?SHJWeWxDWFEzSHpOdnpYVTZZUWh4Q0NlOTF1dU9QUm81cXoyYmM2dGlLM2xu?=
 =?utf-8?B?NEZhMzdvc1U5djB2aGFqeHFwcnZnak16V0hwcFdFTituN2N6R042WkZYcGxa?=
 =?utf-8?B?NUdTRTRGS3JFQVl6SGlhblZnWjJuckYwRTk2OVZoL2ZGRGxZQmZiR2MrSHE5?=
 =?utf-8?B?dDgySERwUm53NmVMMHRxV3JOVjg5MXRnajdPU2N6QzhKcXJMK254NFk5dUFN?=
 =?utf-8?B?UkFBREE5NEFNMjJQditIdm5RUHdDOThWclBqd0VaOXRPZ25kZ3IveFZpY1pB?=
 =?utf-8?B?dlJTdm40OEVVRWZQRTh6dlFRVVNlaFZPTXJnWUE4SXB2bjZ3Ulp3dEc5K3BX?=
 =?utf-8?B?M0V5MkxhRGV5aVRDVGZhR0JGeDhnaiswU25oWUxMMnhSSVNMS1pLNW9IM0hT?=
 =?utf-8?B?dWgzWEFuTDdzNk5tUUtHdGp2SVRVdVJxS2lyMm5XZTByM1JISDVxZHNPbVJN?=
 =?utf-8?B?c3JSSXJFQlIvOFpBc2xhQng1VE1ZYzFuYVdLSEFVOVJUU0pZbWQ0andvd1RD?=
 =?utf-8?B?WDZhbEQrSUliYlp2UGdnMENvRHVVNTU4aDlBZU1BZ1AxVjR3WUc1aFZGQnlP?=
 =?utf-8?B?YXFNSjI5M21hQnlVc2I3emxlWjV3Z2t2R0F0SHArK1E3b1RWS3IvYmo4V3JE?=
 =?utf-8?B?alZKU3Q2R2VoelVqdnM2NDFJVU1PbkxOYnpHbk96SHY3SWdEYnVYQnBaZlN3?=
 =?utf-8?B?L1hjQkxVcGlZQUtoU1lJZ1FLazNnRlQ5aU9UR0Z1YnVMazhVSytpQU5vTWwx?=
 =?utf-8?B?dnRqWFFxR1hFZStVZSt5dTZJMHpaTkttdGRsd0hTeEQ0cEljSlg0bDdRbG1o?=
 =?utf-8?B?cWNPeGpWRFZaVGFzYmJ0MTlYQ3BuWS9VTmlkeWlYTUMyckc2Q1F1azY0NCtB?=
 =?utf-8?B?ZGR5QTNScHE0L3RRNm1aUVZVUW5kUVlucHJNRy9jQS80OFdMRDJpSDk4TVlM?=
 =?utf-8?Q?k11u8DfZYjwnoJTwX5OOEQC1UkcduuVaszS8eC4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enpjUS9WU25HejdyTzdxbTNxZnJES0VIWEYwWi92QTZzdjhJRk8rQWQ3dUpr?=
 =?utf-8?B?MS9lK3FPMWxJU3pUYkhPZ0VndWdRZFZkUEEvVGdkbTZuMDB6Q05vSVI5ekx4?=
 =?utf-8?B?TmYxYVhadVRDYTFJQ0h1QS9YWEJCN1dsVHN1NHpiTlpYM3NXUVpyVjZyYVpi?=
 =?utf-8?B?cWRXbkpBMWk3UVpWcFhoZGxPRysrRW9BVFBqamVGME1BdEJNU3pmbGxWQ1Ra?=
 =?utf-8?B?TURzTzJITGtEUHFxL0IyQW43Wkl5NVlBYzlYWDVwWFFjVmFjZTY1eXlJdC9O?=
 =?utf-8?B?RkhPR05iOTAwTjF5cnlrWFpQZFZLbW8rY2E3YUkvYkdLREZMaEY0Tyt6WGFP?=
 =?utf-8?B?WlI3L0I1QjVkM0Y0ZmZ2SHVqcml4WmxoalpobW5tTXlEQzhyMkRsSHVRQy9J?=
 =?utf-8?B?a0xRSEJyeWxkRlR1d2QvYjFSSm03NTRLc2cwUlB1TlE1R01vUHFkNXpLSkQr?=
 =?utf-8?B?bVZ2Qk5UTWZoeXRlYWxzam5UMS8rRVczelhEdWtPZ2EyakJMMUYwZC8zbHRB?=
 =?utf-8?B?NTJrVURXUHNxb08yWDFyZXBwbTNjRXBEMHBxY01jMDdvMVAvd2dqMTJCekVF?=
 =?utf-8?B?b09tMFVDVTNKUEdwTXB1ejQ3QzgwTEJsVTJTK2k0YVcrVHBmSGZDQlhsZXkz?=
 =?utf-8?B?MTJGamVpNEtnQ0xlbkpXZGxnK2xsNDNZODlxanNpNm1CV1RKeFlETTN0dGJJ?=
 =?utf-8?B?VDMxNW1ieWZpRW5yb0JNeXBBT2R6MnAwSlJpR3Y5YmNJQndqRDBvMlo3cWVr?=
 =?utf-8?B?bGNSL3lENSsvR0JYdmYwYUUrbGxackdDV2RnN2NkamhZSzhEN3d4b2NVU1hi?=
 =?utf-8?B?aUJIOTByNmdCV04xQUZjbW84ZUF3WGlaTDlRVDlzamEreWxsdkpNbTI0cXdh?=
 =?utf-8?B?RWZnYmV6aTdiUTJrOUV3cEZIQXdYR2t0VkV2bmFUMUpKUzNxVFp6TTFldkFN?=
 =?utf-8?B?NnBRamJXdk9QRHNSYUh0RENFbWM2d29rYk9yOTJ1VGRvQ0cxNFhNNDNsOUs1?=
 =?utf-8?B?MFNNZy83Nk9BM2JQYzJ1ZVluOFlMNTRaSmF3R1BjMW0xNTZ2c0tTdGloUTJp?=
 =?utf-8?B?bXpXZjE0ZW9EMlAzZEFhWEpuU3hEOXh1MlRMMEZXWDQvK3hVeWtwUkNDaGxO?=
 =?utf-8?B?bUxTaS92TkJvRklXTVRvaG44d0c1TlN3SXRoZWZKTk11eStFQXR5M3d5dE9y?=
 =?utf-8?B?c2tOWHZyYTNLb2ErL2xkd3VpaWpPZlhFaGtRMlhoTmlRdGxrVnhIUmFuaTZ3?=
 =?utf-8?B?ZVBuaitKbUJrMDlGazJWNFloWlJtNGdqMmF0VUprL1IzNzRnRVZudGFjc0dj?=
 =?utf-8?B?K25JYjJ2V055Y2RrUGZXWHUzNHhjQXYrc25ZUEVlMjlkWDlIVXdGM3Y0aU02?=
 =?utf-8?B?MCtBY1lzNE1UdW1DR2NrMGM5OFZ1cmpjeCtvN3RBS3JFTmdqOW5UanFBbnFJ?=
 =?utf-8?B?ZGVXZnRVQ2hTV25jTDdVc1JsVXlVSFg4MGozTFBhWk1jd1B1N0FHbERzWWNL?=
 =?utf-8?B?S3VLOWpoY0w1S21tc0hNU2lkRGRSSWZBSGlHTktORGs5aktRZHFpbC9hN3Vu?=
 =?utf-8?B?R3pVWU5RNUQ5SjVhd2svbHRYd2xZRC9hcWwrSzBua0RwMlBJL2xxaHlsWVBy?=
 =?utf-8?B?UDJYMUlOaytmQWY5VHc5N0xrMlprc3NvK2JyYjliVDcwS2JJQmROVnhaeDU4?=
 =?utf-8?B?blBoUjZVbXNJVDV3RE96WmJ0KzcxZEUxUmV1V1N4SXRsbWtEdXc5cW80ZXZm?=
 =?utf-8?B?UDFBYlZ3dlRjNjRtQklEMFFuNzZFaXZTc3NyRE9TR2ZRTlAyNWh0aHhuYWxt?=
 =?utf-8?B?SytnTXU0YmtsZWxOZFdycUNQV2F4OWtvQUYrWkRhUmFGVWRsekFleFZYM25V?=
 =?utf-8?B?bUZiRHgxTkpVeXhIS0N5MmRydU93emhpMit4RDlNd01mR0djSmZvb1c3NE8r?=
 =?utf-8?B?OTFTUlBSQzJna3VpV1NjY2JNOW1qTWtHSXQ4VThIWmpTQVB0andKYjZRRWVX?=
 =?utf-8?B?ang1UnB5M1dVWXB2R3NYL0h6ZHozdVFNNVhyUHVVZm9RSEl4QW5BNUpaUGU4?=
 =?utf-8?B?VDhXcmc4THZSdDVJR0VTSW5pN2dCemNhUEpCUnQyd3Z6UFdKdHF1V3ZXVzVW?=
 =?utf-8?Q?+UNM1hyhOLeAAojDVe55neLGj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dbf72f6-ff9a-4fc9-3974-08dd00252949
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 18:42:56.4310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X2Npo3R2/MOPETd5H3E4yzfWAQwem18gtlanvicvwKGvECg4K7WBbDTYUke4uHE0A0JsWJOgfieJ+QZoY1NoBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7017
X-OriginatorOrg: intel.com

On 11/7/2024 5:12 PM, Dave Hansen wrote:
> Let's say
> we had an ooooooooold module that did this:
> 
> #ifdef MODULE
> static const struct x86_cpu_id foo_cpu_id[] = {
>         X86_MATCH_FEATURE(X86_FEATURE_P3, NULL),
>         {}
> };
> MODULE_DEVICE_TABLE(x86cpu, foo_cpu_id);
> #endif
> 
> which generated a modalias like this:
> 
> 	alias:          cpu:type:x86,ven*fam*mod*:feature:*0067*
> 
> and then we recycled number 67:
> 
> -#define X86_FEATURE_P3                  ( 3*32+ 6) /* P3 */
> +#define X86_FEATURE_WHIZZY_NEW_FEATURE  ( 3*32+ 6) /* P3 */
> 

Coretemp (hwmon) seems to follow this pattern exactly.

commit 9b38096fde5f ("HWMON: Convert coretemp to x86 cpuid autoprobing")
adds X86_FEATURE_DTS to MODULE_DEVICE_TABLE(x86cpu, coretemp_ids)

commit 2ccd71f1b278 ("x86/cpufeature: Move some of the scattered feature
bits to x86_capability") frees up X86_FEATURE_DTS(DTHERM).

-#define X86_FEATURE_DTHERM     ( 7*32+ 7) /* Digital Thermal Sensor */

commit 765a0542fdc7 ("x86/virt/tdx: Detect TDX during kernel boot")
reuses that bit.

+#define X86_FEATURE_TDX_HOST_PLATFORM  ( 7*32+ 7) /* Platform supports
being a TDX host */

> udev might try to load the old module on a new CPU with
> X86_FEATURE_WHIZZY_NEW_FEATURE that's not a P3.
> 

So an old coretemp module could get loaded when the above TDX bit is
set. Not sure how likely this scenario is or what can we do to avoid it now?

> I sure hope we haven't been using too many of these synthetic features
> in MODULE_DEVICE_TABLE()s, because we tend to move them around, but I
> guess it's possible.

At least features X86_FEATURE_P3 and X86_FEATURE_P4 seem safe to be
recycled as they haven't been used in MODULE_DEVICE_TABLE().



