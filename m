Return-Path: <linux-kernel+bounces-411520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 642809CFB6A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 01:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24F8C28509A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 00:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF6522071;
	Sat, 16 Nov 2024 00:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dhcoJbpG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D961854;
	Sat, 16 Nov 2024 00:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731715235; cv=fail; b=SFHy5yH8yqB/PZi5gKA2b9Yl1xzdiDYOFYGejNtLnJygzXcS7Z631E6BdsxhEiDShxIadLcrGAPYNX3Jmg+q2Sa1EoMQsTeDigY54eDXQ115KcJmCdMgkdKDgximmjBuJdTbIcknvIwHMAwvDx8hpSd3o3GtOa7+jl2MXDaRkAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731715235; c=relaxed/simple;
	bh=ahpUWPs57CXCfRCcFyhbY8MqYewJtunbXYwBXMOzTdM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TnyumlCvswkXTVkOuEAsLtgBmpIgnT9C4/eKPMrX9Djlg82ynfW3Rk5LNhVaKt2R5gBbBAo4aPi24WqEepN0pvJqzxj3AA8Ud6BI8Tye8L9GhZX+MsiN8+BNZJ31/FLnN3N6IYc78TX/9ame6OaclceLKOyClG08nSmu48U6FqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dhcoJbpG; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731715233; x=1763251233;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ahpUWPs57CXCfRCcFyhbY8MqYewJtunbXYwBXMOzTdM=;
  b=dhcoJbpGUtBf4C2NdptHpyse0z5H94Udfxq3qVGW6510d4oDnC5GQbb5
   kBkQNQXNDv+6+ZbP+7ppEqYY2qCK6Frv9jw8mnLx82zMgUfbquN8EQXlN
   XVLOoaFcpuaULDMlS/aetb41wteX5y57SzUi4plsgTT9qxuaZCmRN0Xji
   kpx/XyxMNxSe+jH60SMCPP+I6zETwjWiFnwS3q2zWyaGKNJmm7JLWILbU
   hdCHMUzLjX++fBg60tf38gf74VZATzxNd5/WJzjlmHB5Es8GwLBAYMCN3
   xN9hmxklxqwDZuMJYsdH2x5qT69BYkYO0qKV662klnNKT8lq4N+FerYOW
   g==;
X-CSE-ConnectionGUID: VoM5FU01QWGumu0BrvS30w==
X-CSE-MsgGUID: EHDruYe3Q+CxKyNNHISLkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11257"; a="42385477"
X-IronPort-AV: E=Sophos;i="6.12,158,1728975600"; 
   d="scan'208";a="42385477"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2024 16:00:31 -0800
X-CSE-ConnectionGUID: YOL61eFETnebhQkcHethRw==
X-CSE-MsgGUID: 4XRJaqz5SaqzEjOm4CW1Tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,158,1728975600"; 
   d="scan'208";a="88872945"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Nov 2024 16:00:32 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 15 Nov 2024 16:00:31 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 15 Nov 2024 16:00:31 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 15 Nov 2024 16:00:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cWGPUOMMh+M0a/LpSuIQ8z1pNlnp8cBNhJujYnw4RTtkNTVkoYYswjWxlW6b1+B7gaDK7l48zUmq7Bm0y+ALQtiiiF4d39A8ZM1gq51+e+aSHkcwx2u82EBWYTw8RLdbjbyUDXvy+SDqv53fEZg49wrfI/h+dyXij0CS5sbAoLuV554exhDCp0KMyBDX4u/4azfTztUXzn2Wm8ic/BYK7Z8C7wyKrFKn9h0xnyjwA85RwROhApq0budki02FCLWSSdrBY/p/Ny9M3629oO2xsS7obRzHOtMHz2Fcwlqd9rJZ4uCC+1yk8g3yGIkchjFsYY7tvcAb6tJN+O6xUyRHPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gyAB+RsHVztWZ+WgHWosb+ZclBybeUAMCACWX008yLU=;
 b=tOYxOQozj7jU52Y6rDqFrt2sBb2R0xB2GWAOHdbPubqLf9TU1fqh3dqzT/iWPE24mH4qE0LDb/g82v0iZeh/1Vbjqqi09Ids08I5ynji/h8jlnu1uMxhDmHHOabblWwPCrGyuDHvozRaBVM3oEC/PA5hewSnGKGA9FHua166tfWJ7HrZ6LKJ9rRFS7Py4ocdzvz4uGF7ioOlnBHHVKOVStawWCy0C0MbhqAhQ1P7DAHrt0NLQ2pPuqAOVj+FLIYg8vTyk85mZ5W6TBNatkG6udjqQ1MF++yqeIka+CFb86xiuIkE8DofwTBKTxhq4JGod2Y36balprOmlQ4TK1TJbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CY5PR11MB6343.namprd11.prod.outlook.com (2603:10b6:930:3c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Sat, 16 Nov
 2024 00:00:25 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8158.019; Sat, 16 Nov 2024
 00:00:25 +0000
Message-ID: <fe518638-a82e-4136-ae77-fa6a7abb4b2e@intel.com>
Date: Fri, 15 Nov 2024 16:00:21 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 08/26] x86/resctrl: Introduce the interface to display
 monitor mode
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <fenghua.yu@intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<thuth@redhat.com>, <paulmck@kernel.org>, <rostedt@goodmis.org>,
	<akpm@linux-foundation.org>, <xiongwei.song@windriver.com>,
	<pawan.kumar.gupta@linux.intel.com>, <daniel.sneddon@linux.intel.com>,
	<perry.yuan@amd.com>, <sandipan.das@amd.com>, <kai.huang@intel.com>,
	<xiaoyao.li@intel.com>, <seanjc@google.com>, <jithu.joseph@intel.com>,
	<brijesh.singh@amd.com>, <xin3.li@intel.com>, <ebiggers@google.com>,
	<andrew.cooper3@citrix.com>, <mario.limonciello@amd.com>,
	<james.morse@arm.com>, <tan.shaopeng@fujitsu.com>, <tony.luck@intel.com>,
	<vikas.shivappa@linux.intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <peternewman@google.com>,
	<maciej.wieczor-retman@intel.com>, <eranian@google.com>,
	<jpoimboe@kernel.org>, <thomas.lendacky@amd.com>
References: <cover.1730244116.git.babu.moger@amd.com>
 <121c79ea1abe6f21f726d086eba9fa61d31da3f1.1730244116.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <121c79ea1abe6f21f726d086eba9fa61d31da3f1.1730244116.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0213.namprd03.prod.outlook.com
 (2603:10b6:303:b9::8) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CY5PR11MB6343:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fb12288-3acb-4879-2c7a-08dd05d1ac08
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dDFWaG1kTTJDVHN1SUxxWjN3QStQV004bHZGTGVvNGdnL0NGeDB4OFE3YWZU?=
 =?utf-8?B?MTU1OXBlWXljaWpVYmpJNlF1M1pIb0Vacmg3RjQ0dGd2V2J4RnQ2Q3hrVnhz?=
 =?utf-8?B?dG5UQ0d4enVDNlNWZStLb09CbUZSVlFpMythdjRxeXloUFY4VkczQUZqbUFi?=
 =?utf-8?B?ZVRqV3ZnSmJvN09Od2tkMVV2bUNPd2srUTJiUHNTZ05GcXkyYmpTV3ZDNEtp?=
 =?utf-8?B?bDdLaUszV0FYL1Jic1VjMW02Wi9XMHpBcFV2WHdLL0Z0RElwazNXYU1SUTNH?=
 =?utf-8?B?aUpUK2FkQnFkaGtJbUV1ZXFITTV3ZC9qTXVocmo2MDcvUlR4WkdxUjlvUlRr?=
 =?utf-8?B?NW9DcTZ2cHJsWDVva084VnlBdVZmeHNVQk9IcFVLUzBGVXg1QW9nQ2Jib0J4?=
 =?utf-8?B?ZVBON1oybVY5Z0dlVkhvdE4zcVExWWpobGw2QTJxRkhDYUtpVEFxRlBua1px?=
 =?utf-8?B?SEFkR0xjaXV4KzdOREdOWVBYS2xob1BLYitPY0hMTUNrOXhWSEgxWHR5cVhZ?=
 =?utf-8?B?dzl4bGlVcGM2UnRxcW5mVjZmT1dmVUhPM3dXQTJ6YXMzczQvZ2RHNEp1bXBC?=
 =?utf-8?B?dkhwSzlLZ3JTcUZuTm1Bam5SR1lqY1JrT0JVQmMyVkdRME5LRnliMUhFVlN3?=
 =?utf-8?B?KzZBM3VldHZGWkJ5T0FZdExhM3JCTG01WlNGRk1lY0hCaTI5TG9VdFBJTHBQ?=
 =?utf-8?B?d0FnN0oyUUprZS9EK0JUUTJGbFNwaVducTYzSWdpZml1RStmYUJTQms0ZVFr?=
 =?utf-8?B?TjdDV0VnZkkzZW50UDRpQ0VqWWRiSXBrOURQN3hNbWRhN3U2cExmL1BhQzE0?=
 =?utf-8?B?NTVzS0s0dlZ4bjdseitmaXRFZ290aEk5dEJSK2VrS1ZHUUwrd2s3eGxLZFFz?=
 =?utf-8?B?dEg5b1J0dHBIeVhIMi9hMzBGUDRISEdDai9VMHBMVVB4TXJpZ0FQTkRuUmd2?=
 =?utf-8?B?bGFrTWhsZ3QrdmViWjZuTCtDczdLa3NDak9VUDFzOGpLWG53dHJRNVR6aFlN?=
 =?utf-8?B?U3pKbVVnSm9ZU0Z2bVZra0NDeERKVFhsc3VDbTBEL0xiTzVCTmEzVUJmcS9R?=
 =?utf-8?B?ZC9wSDBmUWRuUGRIeGRmSElJVWFvYWVJNzd0RFJCdVdZb0I4MlBPL2JsYzRZ?=
 =?utf-8?B?RzFvSUlZWG9ROURuQ1E3RTB0dUZudlRKR240L3QreHlHSldGandnRkpaNGZY?=
 =?utf-8?B?enZVQTdJZ043aDQ1dHIzckN6Q3JOQlVLdk5XZHpQRnVJbGtMUlBvbjFRZkgx?=
 =?utf-8?B?VU9NSGcrby9TU0tIcEg1TWQrUFRrR1h6V2ltY0dHODdNT2Q5Q1hEMVBOQjNk?=
 =?utf-8?B?MDFQcFdDSHBkY01qdjlYZEFxK1ovTndaZ0VlNm5MajhmdlVrRXlnR2IzV3Vw?=
 =?utf-8?B?MUtuYlFTZjl1YWpIVG9uR213aG5PUFZqSGVSMENOU3owMWxzbUd1Rk5ucHpO?=
 =?utf-8?B?eFBUVjlORitXQW9LREY5cjZkQWZ2MzRzWUJCR1FGLzRLUW9PQjZCcWJ0WXg5?=
 =?utf-8?B?QXJwUmRWSzZLbGw3VkVqT2VkeThLS3hoVi9NaDJ5N0R1YWlGUTlURnpKaHMr?=
 =?utf-8?B?UjZlL3czUlFlZDhWYWFrSENha0YzMFd6KzZYK3J5ZXZ4WDdicENTQ3ZYU24x?=
 =?utf-8?B?dnptU3BoYmlGVGhmNGYvNDRUNzQ4Yk1uQ1pRV2xzc25Zc25waTdjc1RMaG1I?=
 =?utf-8?B?V09WNTlBcTRoTW5ucFZvb2tkb00zT0pkaWRpNG5vSElpZmt5aXRjcitvUS9U?=
 =?utf-8?Q?HLhFiMenHwvBVw7efcMcfN4eIgNJENxcpgUDsZ+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWs0Sm92L2NuYVpiT3RPNjdrZ3hodkhwaXZ0RFcrdFFvNnMvTXFMVjZNelpR?=
 =?utf-8?B?aURCcHQyd0FxT2lkRVI4OSttOVhtUEZPdEpqSVNmU1pTaVJvaE9SRFlVUnRx?=
 =?utf-8?B?ZURTemN0S0ZVTXZQOXVPRnhsS0xCOXpmWTF2dHlVWlE3V0RUTFlQanFwaXRC?=
 =?utf-8?B?azdteVc2eDlCelFqZVZQa0dLbjQvOWJnN3JzbGVheUIvandocmFvY0V2Z3pm?=
 =?utf-8?B?L0EwMnB1bnhpN0lGRFF3bHhGcGhjM1hyb2U2bll4a2hvb250TnJrczJxMUVt?=
 =?utf-8?B?d0FXeW11bGVYQTlXa1lIWGlGM3lrUHFPcXRrR1hKT21JWE4yTTlSSTROeEdE?=
 =?utf-8?B?VkdBMnVjenR0dDJBQ2c0LzNvaktTa3VqZ1NObm11NXV5M0Jlb3NKckpDVmV6?=
 =?utf-8?B?OUVmVjQrTVRRd1J0YUsvSDJEWkxGYUhoTnVnQlJpaTFuZXViWFh6WEhGaWc5?=
 =?utf-8?B?eFRydG5kODN1L2JRYVRMK2Q2L25vVU1jKzVrdG1rMVNyWXhOSGh0OEIrNnVp?=
 =?utf-8?B?R1JyUGtFcGlCL0h3V2M4Q1k3OU9rUFgwTXBvSjdONWdJOFBzcXVhY2lLdWhS?=
 =?utf-8?B?NXBmbHhKNXBKZmdBdmNxU2dsZ01Xb05wM1ZWQThkc0Z0MmR6YStaRlpKd3dC?=
 =?utf-8?B?dzMyazBYOHdvaUtmVjgvd0hZVnhiYTRsMlF6UjliVkE1KzNnUWtsZGNBNkJz?=
 =?utf-8?B?bisxVUkzd2NGQnF1V1RiTHkvbG1kKzJMbi9XeVFnNldXeDZvTTk5T1dwU3Qr?=
 =?utf-8?B?QUI2N1JuOHNpWW1IZ1gvYkZFTTJGRlJtWnFIMm5PNllCMDJqRHA1Ulo5ODBo?=
 =?utf-8?B?enV0L1QxUVVFd1hYdDhQUkNhN2xneHdTUFFMaFBCR3lrTlZUcE81cHNHMnB0?=
 =?utf-8?B?VHE5SGhSVU12N0Vya1FSR2tlWnhyTFY5VXdqbUhHU200RXlmUHRzV1dJTGNy?=
 =?utf-8?B?TitMRUNoYjR4UFVQczRpazFlT28vVk1Mb3FSckhuTmJnMmM1ajBWaXphVm5U?=
 =?utf-8?B?cWl6Ukx4ZU5kMUpSaExGMDdUUWIzd1dxM1VjZitLWUl2bW9xVTVoWmNBakZh?=
 =?utf-8?B?NFR3QStnRDRDM3Y1OWZnOVlBOUxCZ0Q5Vi9rcm5CTXNld044MXlJVHBFTDFm?=
 =?utf-8?B?RXZZR0hVZS9WMkh2UEMwRDE4bGxMMnliUlZ1d21CdFZQY0NXTDdsVzhtcHZy?=
 =?utf-8?B?eUorV2VGK3Z4WTN4bUZDSEo2Ylk1VGZ0bEJMQ09XbXZDN3J3NkM1Nk45L0o5?=
 =?utf-8?B?aU1xMXp1azg1U1Jyc3lJcVhUVHpJbEU0bjE3MG1VVE1FbzNYNm5kQ1hMeEtv?=
 =?utf-8?B?cGV0TlR1T3RpWURtTWRET2VaVDRtZHoweVFEeXJaVFluN1RSc2VUbXBzMU53?=
 =?utf-8?B?Q0lqZmZ6dXI0cGFYWUFNQ3lXeWVBRjU0WngwWUdiMXp2dVBEQUtLYVpLK0Fh?=
 =?utf-8?B?bUtRTkgxR1VKb2NKRjdoRGZDRW1qTUlnUXd1SVgxd3pWUG5ySGZNQTJRTEV4?=
 =?utf-8?B?Y211NDFIZkF0M25EbWl0Y3hjbTZIMFZRQ2dUc01RajdHbnVkMjU3YmZUcHR0?=
 =?utf-8?B?N3RxNnNBWVFxUE4raXVWQldBZXlLTXNmREtwU2JlY21rOWs4VlhaTFEwQmh2?=
 =?utf-8?B?RVFtc2czTTV1dXhmTnR6ejA5eFFsbzNUV0Z4VmF3aFBrNDB3SWUxZlRrZDBr?=
 =?utf-8?B?S2RKd0JoNVdsanVaU2xkYTRQNHAzS1d1Znp6NWtsbnBMdldkeUw5Z2dyVnlU?=
 =?utf-8?B?K1ZiZEdidG9FSnUwdWk3aHRYR0hFSjFsSHEvMUk3VVY3MDg2eVZ5NDV3M2wx?=
 =?utf-8?B?WlpjUHVxODhVQUE2NG15cDNEM0hJZC81dEhZWFRGMllPWGJYaDFCNVFxRlZ1?=
 =?utf-8?B?VU9CdDlKRHkvcmI5M3d0NGI3SkVlblRXTXdmQ1FHeHRMcFhYQnNFTlF1WE51?=
 =?utf-8?B?ZXZPWVFnNERFZXkzRTV0ZElWRFRxRGp3d0FET0RQSEtHTWFIWGpHTVYxV0xW?=
 =?utf-8?B?UlJNTkxpN0daRWxxckNXRDJQYzJnTDJzaUpiNnNnQjMzemtWZ0tyS3VyWmQy?=
 =?utf-8?B?VnNVYkNwRGJFS2dUbGkyK1U3a1dXQSsrUHcrVFZ1RW1LNzNKTkl3LzJmK1h3?=
 =?utf-8?B?WUUweldweFB4R3VCOHJaWndhRHFVOGQwTzhPdktiV2FxbXhtY0JOYmg5U3BX?=
 =?utf-8?B?OFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fb12288-3acb-4879-2c7a-08dd05d1ac08
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2024 00:00:25.1699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QOB/Ed+RVKEbfyWH9FZi/ZbFUW6k9nzwTUH76T9GCBd+sshsPPtZV6/Emd46U7P/Ep9xg01f273UsArLJtDuJ4S+WthP6fJeSx2HvNmDg8U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6343
X-OriginatorOrg: intel.com

Hi Babu,

On 10/29/24 4:21 PM, Babu Moger wrote:
> Introduce the interface file "mbm_assign_mode" to list monitor modes
> supported.
> 
> The "mbm_cntr_assign" mode provides the option to assign a counter to
> an RMID, event pair and monitor the bandwidth as long as it is assigned.
> 
> On AMD systems "mbm_cntr_assign" is backed by the ABMC (Assignable
> Bandwidth Monitoring Counters) hardware feature and is enabled by default.
> 
> The "default" mode is the existing monitoring mode that works without the
> explicit counter assignment, instead relying on dynamic counter assignment
> by hardware that may result in hardware not dedicating a counter resulting
> in monitoring data reads returning "Unavailable".
> 
> Provide an interface to display the monitor mode on the system.
> $ cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
> [mbm_cntr_assign]
> default
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v9: Updated user documentation based on comments.
> 
> v8: Commit message update.
> 
> v7: Updated the descriptions/commit log in resctrl.rst to generic text.
>     Thanks to James and Reinette.
>     Rename mbm_mode to mbm_assign_mode.
>     Introduced mutex lock in rdtgroup_mbm_mode_show().
> 
> v6: Added documentation for mbm_cntr_assign and legacy mode.
>     Moved mbm_mode fflags initialization to static initialization.
> 
> v5: Changed interface name to mbm_mode.
>     It will be always available even if ABMC feature is not supported.
>     Added description in resctrl.rst about ABMC mode.
>     Fixed display abmc and legacy consistantly.
> 
> v4: Fixed the checks for legacy and abmc mode. Default it ABMC.
> 
> v3: New patch to display ABMC capability.
> ---
>  Documentation/arch/x86/resctrl.rst     | 33 ++++++++++++++++++++++++++
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 31 ++++++++++++++++++++++++
>  2 files changed, 64 insertions(+)
> 
> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
> index 30586728a4cd..a93d7980e25f 100644
> --- a/Documentation/arch/x86/resctrl.rst
> +++ b/Documentation/arch/x86/resctrl.rst
> @@ -257,6 +257,39 @@ with the following files:
>  	    # cat /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config
>  	    0=0x30;1=0x30;3=0x15;4=0x15
>  
> +"mbm_assign_mode":
> +	Reports the list of monitoring modes supported. The enclosed brackets
> +	indicate which mode is enabled.
> +	::
> +
> +	  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
> +	  [mbm_cntr_assign]
> +	  default
> +
> +	"mbm_cntr_assign":
> +
> +	In mbm_cntr_assign mode user-space is able to specify which of the
> +	events in CTRL_MON or MON groups should have a counter assigned using the
> +	"mbm_assign_control" file. The number of counters available is described
> +	in the "num_mbm_cntrs" file. Changing the mode may cause all counters on
> +	a resource to reset.
> +
> +	The mode is useful on platforms which support more CTRL_MON and MON
> +	groups than the hardware counters, meaning 'unassigned' events on CTRL_MON or

" than the hardware counters" -> " than hardware counters"?

> +	MON groups will report 'Unavailable' or count the traffic in an unpredictable
> +	way.

I think the above can be confusing to users. It mentioned "*will* report Unavailable"
and then "*or* count the traffic in an unpredictable way". It is not possible for
counter to report "Unavailable" while also reporting unpredictable data.

My concern is that there is no way for a user to know if the platform supports more
CTRL_MON and MON groups than hardware counters and the above seems to imply that counters
may be unreliable ... so how does a user know if counters are unreliable or not?

Can this be made specific to help users know if their platforms are impacted? From
what I know all AMD platforms are impacted so perhaps a straight-forward:

	"The mode is useful on AMD platforms which support more CTRL_MON and MON ..."

I'm concerned that users with Intel platforms may want to use the "mbm_cntr_assign" mode
to make the event data "more predictable" and then be concerned when the mode does
not exist.

As an alternative, is it possible to know the number of hardware counters on AMD systems
without ABMC? I wonder if we could perhaps always expose num_mbm_cntrs as a way for
users to know if their platform may be impacted by this type of "unpredictability" (by comparing 
num_mbm_cntrs to num_rmids).

> +
> +	AMD Platforms with ABMC (Assignable Bandwidth Monitoring Counters) feature
> +	enable this mode by default so that counters remain assigned even when the
> +	corresponding RMID is not in use by any processor.
> +
> +	"default":
> +
> +	In default mode resctrl assumes there is a hardware counter for each
> +	event within every CTRL_MON and MON group. Reading mbm_total_bytes or
> +	mbm_local_bytes may report 'Unavailable' if there is no counter associated
> +	with that event.

If I understand correctly, on AMD platforms without ABMC the events only report
"Unavailable" if there is no counter assigned at the time of the query. If a counter
is unassigned and then reassigned then the event count will reset and the user
will get some data back but it may thus be unpredictable (to match earlier language).
Is this correct? Any AMD platform in "default" mode may thus be vulnerable to
"unpredictable" event counts (not just "Unavailable") ... this gets complicated
because users should be steered to avoid "default" mode if mbm_assign_mode is
available, while not be made concerned to use "default" mode on Intel where
mbm_assign_mode is not available.

Reinette


