Return-Path: <linux-kernel+bounces-550430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0BDA55F81
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 05:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16597177900
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 04:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67151922DC;
	Fri,  7 Mar 2025 04:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BnE8dnPc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D6718B476
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 04:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741322117; cv=fail; b=e0KpB86/MvI5Qe3BlzGw+y73aucwLO+6k/z1QC7K/6NIaY+7b0Cf0kPTssYU3bJ1Fq9ZMpIpbmsL3vhhkjnBZc1xtXMF8pDFNppq6GqFWVgglOmemQB4+ZyH2q5YZtYbwudFd/q53q9acEJu4h751POTF2zAMELdeq38DSM2lZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741322117; c=relaxed/simple;
	bh=RHi76x81m2d7yzjyMN833pwxSCWMizE2ZbkfIJrwt5E=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uSJACN2z6KFFsfz1N5h1lafCQlfJpNZe4vhd9pOzQsHUPXxFf6TbY9gvGypmSgPyo6TR3nEAXexQKUg3bOMUIcQC3mrE1aAIXLyjSkKZpUCU8k786tFLkBrDtGSxWoobSt0Lc5RhNbgRjVmqKrDv9YsXoXl94Zr6ilOf+RGoH8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BnE8dnPc; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741322116; x=1772858116;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RHi76x81m2d7yzjyMN833pwxSCWMizE2ZbkfIJrwt5E=;
  b=BnE8dnPcZxtLF/APaEXd3KLEd6q38qBkzONT1ou/yOQUcdkENVQyEzgX
   hspzijSjeS6yuJ6FBSdcXXh5IIkFRCwc6ii/1XX5K5Qg/YQSmzkIvbKpZ
   4YPLX7B/bUEAdjPcuSw1kiMHbH4aK072OShyYa9PacrECJRZfhZSDo0mf
   Dhn2cXfSU1P13MxGFQvs0h3jBCl8zAia/rrn4veL7VbU9oHpRXjU860t1
   XrnoszGTB14BApvaa4AWqpQdSWwj0PwqR7LfhN8vUMrRDisps8GKCiDYP
   JenSzItp/w5Yv4nJfEsCk58XkWMdbigGDZXjqywp+iBdGYA7IVhM+AmAs
   Q==;
X-CSE-ConnectionGUID: wkjZH8neS0+GuW5L/miRzQ==
X-CSE-MsgGUID: Nb2+UH/jS6Ovymc/MJmidw==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="53349398"
X-IronPort-AV: E=Sophos;i="6.14,228,1736841600"; 
   d="scan'208";a="53349398"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 20:35:10 -0800
X-CSE-ConnectionGUID: 6npdxwlERHKDjRwAh7sXbg==
X-CSE-MsgGUID: 0X+HpTNjSkOCjfOHsUGuIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="156428072"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Mar 2025 20:35:10 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 6 Mar 2025 20:35:09 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 6 Mar 2025 20:35:09 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 6 Mar 2025 20:35:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xatZBQFvf/NJgrtVpdsQBGrRJHwI55xDv4nyqOf8nKTRMqj16KX6CIOcWP7SBgkFbOQNuwkLucPTm046kM7EufmEE50tmbAc7hCUNRAw3TivjrryLBNlruRBmMbiM9UV/dZBho2wQY9/uLf36laJvsr2kdnf06VXjLWEXyLYdfgKPPx9SCqEyTa+z6Im4etNRb+WyTtO0Zr1zeP2b4kpm9ATv8KAZrkTRdaV4IknOJROM5ghXvmTRiUO+0V1vByYIJPvy06lIa1y0ZUf/mYcqVwSlTv5pcp9S+ZMn/6eQGN2EUPKipcDF44VpblyIg9MoJf6DGQLSRWpvPMZOpeqHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bv7OpgUHc05/ukJsOai4UEA0h1DcNsCJRti89DzXG9w=;
 b=cSFCgzHQs1fQUAR0iMRhHTIDzzKh9m0QmDnMz+yY/KszWRLWOLkX+yMbnShIfsGiq1zy29A5PuhCrjapASTBaoS6gOqmNsSGdIcMKw8EUYnbD2GNJ5PrH9GGw+T5N3jF0qB7LWoVlM0AzBfwEwJ5h6f1cdyu3cQHe9C8cLhhSuWXtgMfixctK0jAs2ctg8qHDyOS5JyEBfnwfhqPIe17WWOSIG2Up1wQOuuprf+hHDfeEuqINzDd/6DQMNI6pJp68K/TxqwOolE0rsb8ZDxcFxrOYj/zaCwswrAeoS7rTLgWq9RANB2DjqqxZGcQuE0Wncei4elQhXtTGm6msGm1fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA1PR11MB6824.namprd11.prod.outlook.com (2603:10b6:806:29e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 04:34:27 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8511.020; Fri, 7 Mar 2025
 04:34:26 +0000
Message-ID: <2c7ead86-138b-4d26-8524-8109176d791f@intel.com>
Date: Thu, 6 Mar 2025 20:34:22 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 12/49] x86/resctrl: Move rdt_find_domain() to be
 visible to arch and fs code
To: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>, Babu Moger
	<Babu.Moger@amd.com>, <shameerali.kolothum.thodi@huawei.com>, "D Scott
 Phillips OS" <scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
	"Dave Martin" <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>, Shanker
 Donthineni <sdonthineni@nvidia.com>, <fenghuay@nvidia.com>
References: <20250228195913.24895-1-james.morse@arm.com>
 <20250228195913.24895-13-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20250228195913.24895-13-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0048.namprd03.prod.outlook.com
 (2603:10b6:303:8e::23) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA1PR11MB6824:EE_
X-MS-Office365-Filtering-Correlation-Id: d7b7d9c4-d571-43c8-aa98-08dd5d3157a9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Mm1kdlcyZ1FrUXdZeGF0ekVESTVaWkRJSzUrazFSaTUvcXJCN0E4ZnlyRWRr?=
 =?utf-8?B?ZStKQ0pTQ2lzNGE0Y3RUNTZQZVpkS0NwMTJQallla0o3MllUMVhIc1ZRNHkz?=
 =?utf-8?B?L0JWTkh6SGhaOERBaWFnYlY5d2lJVGh5V2p2bm94WUh5NEdLLzB4UjdYRzAw?=
 =?utf-8?B?NHdoUjBINWg1cTR4WUd3K2F0d0YvbklxWnUzUlB5T2kwZ1BNMCtDcUlHaFpV?=
 =?utf-8?B?MHR4YjVSYkViUUo0cGhkd2hBL2dtamt5bDZWcFV6U3FLNWxZeUN5YWcyTTQ3?=
 =?utf-8?B?T2xkMDlmZkVQS28xcVBuVW9SL0hpNnhwK3I0TFpEeFp1Yng4SGhJcmRxOUpY?=
 =?utf-8?B?OW91Vi9iN1RKazBaOUxMalBtWDF6bS8rK2I2MW9jN0xlV0pTcklVQW13OE1L?=
 =?utf-8?B?OWdqUjVhWkRkOGlmblNDTVk0WWdJTTBwSG0zejU5d1ZxL2dsSWRoZkVTOEpF?=
 =?utf-8?B?OFhhT2tkSHVlcE1weGVkRXhtUGNpQWZpdnJPTjY1VlU4Vnp5K0hBa0hWaXVD?=
 =?utf-8?B?NnFUMG4xS0ZPcU1BVFdSMDBaNW11Y0t3Q3lpUDQvUlV6aVU5K0RwRWd2dkln?=
 =?utf-8?B?SUpqdmhsZDdyM1lEK3A2eFd3QWN1UUpja2ZSSGppWGVzOXBETHR2WFdGR3Qv?=
 =?utf-8?B?ZWs4aldIK1V5cG5rZldOeW1SUkV0WmlQZDA5YlFWSWVBa05HYnVYMHF2L2VD?=
 =?utf-8?B?enVoSW5xSmlSbmRLY01ZMG91bGlaSmRwVTVXSEQ4VkJMY1dKTDBqVVZweHcw?=
 =?utf-8?B?clBOc0dRNjZhZmF5OXU2T003SVQwTy9QOEdERDN4bzRVVkd4bnVzcDRNZjdS?=
 =?utf-8?B?ekY0QVpLZGFaOTBTN2FrQ1pQcTVuNmx0SW51YnJkMTIwV2FXVjZ1QnJScFZL?=
 =?utf-8?B?OERqNHJOSDNyYzhLcFBSclBaS1Azay9LeHNaSmgrcDdPZ3B5M0dEZEl2VHpp?=
 =?utf-8?B?Z1dkM2k1TXRTSXIzdyt5OGpoQjEwSExmS21JR0ZxQklhWWpQNVhZbFRveXhy?=
 =?utf-8?B?T0YzU0F3RDR2M1NLMkhRSmsrbFd2ZkZnQ2kwelJqQ2h2bjNDdjhyTGI1TDE2?=
 =?utf-8?B?QTBZVUpoUHRhMCtLSEg0WE9HdGhLemtaN2V4WWI0NmhjOEVENmlyNTY2WWd2?=
 =?utf-8?B?ZW5Xc0hpQ203OGJRMk9Jbk52Rk85UmxHdEQxZzJGUExiMm5mdWtyaWEra1Bt?=
 =?utf-8?B?RWxUeWJwY0IwaldIZTkvcWU5WjVIa01UQjhpNjhBRnptWXc1SmRaV0Q5YzZT?=
 =?utf-8?B?dGtSZ1ZQOGFJaDJXMDg2Umt3Zms5MUcycTlCOHF0SVpDdkQ5bVBqei9zOE9q?=
 =?utf-8?B?SXJIaERzKzRKU2hKQ1ZGTHJuYkJYblRhVzU4Si85b1g4OHBtTnlBTCsxaWdp?=
 =?utf-8?B?NUJmN0hPUEV0YWFqNmZDbkhYOHNwRlpEUWMrRS9NeXRlTTVpNnpXZTZqcDBH?=
 =?utf-8?B?R3BDUFBOYkxxOTdFcWtyQnVmUHRXaWp5TkUyTlVlT3E0VjdYazVodEMvQVAr?=
 =?utf-8?B?WTRuMW9FRFRPbGxoN3ZSL3FLZ2VGYWprb1B3MUVGR1BKUzZWdlB4TVlLSnk4?=
 =?utf-8?B?SnZJdFBlMzMvdkdCSzR3NGRTZzRNOTlDOHpIZFVJUjlPNHBLVnVVdE1LWTVm?=
 =?utf-8?B?dktwQ2lVUkJaczdHNlhVd1BJcXZXOGJ1QmlQcDg4Z1FCUFhyMG1nNktaYkhD?=
 =?utf-8?B?MG9VVnRBbnpIbEFDVEVab2RhbDhoSFdDWHpkd3lCZWxhZG5wNU1NbHplbHUw?=
 =?utf-8?B?M3lrY0ErM0l6ZFRNcDkxM2NFM3Vyam9PY1hvT0hsS0RZTUMrVUpPN2FoWXZH?=
 =?utf-8?B?dDFPek9QZEZyQ1oyb2ZjaHhxNXYyN0I1N2ljeEV2aFBnVVk1Y1BFU0hMa1pN?=
 =?utf-8?Q?r1G+I+/pS3C20?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2pxeVVqL3ppVG5NNHNObmxSRHdMTVNIRlNvbGRPNTFxWW1UeXF0MjJYTVhD?=
 =?utf-8?B?N3hrRnpIYlkwM1pia25yNlByaEJhay9CWHdWaEdEd0hkeG9UdnNCaTZ6cUlM?=
 =?utf-8?B?Z3d2Tk1oQnFSc2lOZnU0ZWt6TWtuajROYndDRUY5MDM0dEtFMjJkdkNXVkxU?=
 =?utf-8?B?ZHJTTU9EV3lxdE1ZcVQreUtlTGI4aGJ5QkxUTmdpVm02RkVGbm1rV1hNc1Mz?=
 =?utf-8?B?cFFVc1Uxc2Nvb3dJcjB5SEdiRGkzSkt3aHlqTlZIazQxZW5MOEY1TXJZRmNv?=
 =?utf-8?B?YWtNVmJTcDY3Smh0UkNUODNyMER2QldsSno3UG1lZWdQOFJhdjRyNldNb2Jp?=
 =?utf-8?B?b0N2V05LR0NuWnlhNW4xWkpnWldkQU1zUnFHWHZjakxEckluUzNhSUppQjJR?=
 =?utf-8?B?RUV1NDJjSi9KZmIyNGJvQ3RCYSt1M3FqQmhLRlE0KzhjQi9MM0c5eFdtMlRx?=
 =?utf-8?B?Q0FBcXRPejNhdUdydnY0MlJyVlRwbkZiVGJYakE3cnJxT0tpVVRWcVFSYlVP?=
 =?utf-8?B?TUhIYW1XOE5DWnBDR0M2Si9jS3Z1cFBpSjVZOGdUTzNmV0p6a3dLTXFqMyt5?=
 =?utf-8?B?ZHJUQmVYMDVmWGlsN0poYjlxSDIrYTVZQTRJZ2swaVlFcmdjSHBFVUZ0aUkw?=
 =?utf-8?B?MGdVK0FHcGd1L2ZzWkZPdXNZMmFBRHRlS20vbzM1Qjc0RXFJWDRlV05udU9C?=
 =?utf-8?B?OFVvZVA4YVpiM1ZjbHYvenlxQmswMHBSZW1YOWtoUXN5TEFzYTdDaGtGTERa?=
 =?utf-8?B?blJLY2QrcDBMQlNlWEtFcjd6bGJDNUxQdHpEMUREcS9HRVczOG92V0d1S1c0?=
 =?utf-8?B?OTJpQUNaN2dmNGJGRHhoNmRiR2JJVXJuYTNTTE5xcHpOZmtxWkRxUDI2aHZC?=
 =?utf-8?B?eWhtMkVLemcwZGFSZVVIeng0Q1N4WnVMMEYxNWhsd2s3TnB5QXhkTlJsd0FQ?=
 =?utf-8?B?OW9oWDFPVENVcDdreGwxenJjS3c1bkY0RWhMQTk1eWpQdVhaZHViMm14d2pC?=
 =?utf-8?B?U0xoa0pwbzRRZmk2N28xak15U2dXc2FWcGpVVUk5bmZWbFFhS1YrRkhqSENZ?=
 =?utf-8?B?c3RPTmU0UkhtdkFFcXpNMjNrSEp5aXNXd05WaUc3VGNpb0ozc1ZQbzBSRUZn?=
 =?utf-8?B?Q2V5WGI2bkJkUU1DN1lpSUdmRjJtTHBYcm11amJsb3Z6cllWc3l4aWtHMlVI?=
 =?utf-8?B?WUJqTWd2SFI5RzVoMnZucU8rbGlJU3JsY29tMG5EWU1ndUFHMDh6WnBjMTls?=
 =?utf-8?B?UytjY1o2UXlTRzdDdDFrMVduSHM1OFhtU1FOVWhmekpFR2FGVzY4VWI5OHNQ?=
 =?utf-8?B?OFRKUXdTTWY0QnFVOUZhL0pibTRZS2JqUExUQ1R3alZ0ODdsQ3Y5TW1qVXZv?=
 =?utf-8?B?TWFSR0c0MlBKemFiUllNYjZLWkd6SmFqNWRIRFBMbXNzT3NsN2hqcHZ1Q0dU?=
 =?utf-8?B?NHVSYVM5R1dLMnRvNXN3N3ltTFVJV0JCNksvbmdEWmllYWFURlRVRFVURDA4?=
 =?utf-8?B?K0ZzTEtmWHZwMFJFY0htZ2RlQkkva3RtaUxQeER6WnVvK1FrbGJoeGt4N2s5?=
 =?utf-8?B?SEVIMjBYc0k2NEFuTDAweFNIKzQ2UExCSE5qZ1ZUa3pXVmF1N1paS3hXSG9M?=
 =?utf-8?B?bkI2MkcrR0hUR09kbURtdEx2dWY1T0hPaDJsVTZrUnA2ZWtDZ3FlbEE3V2ZI?=
 =?utf-8?B?MEdseDUyeUdGYVRlaHB4WGJFODh3UDgwaEgxdEI4eTJ5MjB6OXVndWd5Tzh0?=
 =?utf-8?B?MjVuRmc2MThwYVpjQmVpQzVISnk1NmVWWXRKTmVNQU1hSGtoZ3I4b0s0YUN4?=
 =?utf-8?B?VFB2Y2RaWWFsODhwaU9aZmhhNGUrbEpQZ1JINlVWcm94NVZPQkN0UjVONGVS?=
 =?utf-8?B?SkFpait0SEpUem5WUDB1MzNuRFVCQ3lzY2xGaDQ1WVVKQ3FHaTk3cmszVGJx?=
 =?utf-8?B?TkN4Nkg4OVpJOUpob1ZRTitKK2FJWEhFRE40S0kwOFlFdXh5ZjhNOTRqWGIy?=
 =?utf-8?B?dlNYVW9qZXovRE1RQTRGK1NPVTVWTDNGTk1hUnRLWG0wWnJuMEI1ZXRyY1RV?=
 =?utf-8?B?a0FGVld6aDhqbllXRzJyYnZBN29TTkVsT1R0UkdFK1hCeUF6Lzh6SmtsVi9o?=
 =?utf-8?B?WTlweU9uM28zUzVmTm8wV3UxZjV4ZnZvZy9CL3U2c2wvMEZVa3R0cXprYjhJ?=
 =?utf-8?B?dHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d7b7d9c4-d571-43c8-aa98-08dd5d3157a9
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 04:34:26.3310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e6smfZeQddNnTR+dTj3EmURuwXdSNQPdSMtEAdoVsDQLeH9UO5PgOBE+IJi7bgr2/n1tsYsEf24uZemKUBfAebMXocafkE/ImKkHX34Zrm0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6824
X-OriginatorOrg: intel.com

Hi James,

On 2/28/25 11:58 AM, James Morse wrote:
> rdt_find_domain() finds a domain given a resource and a cache-id.
> This is used by both the architecture code and the filesystem code.
> 
> After the filesystem code moves to live in /fs/, this helper is either
> duplicated by all architectures, or needs exposing by the filesystem code.
> 
> Add the definition to the global header file. As its now globally visible,

"definition" -> "declaration"?

> and has only a handful of callers, swap the 'rdt' for 'resctrl'. Move
> the function to live with its caller in ctrlmondata.c as the filesystem
> code will not have anything corresponding to core.c.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> 
> ---

| Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette


