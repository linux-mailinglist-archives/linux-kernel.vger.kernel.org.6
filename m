Return-Path: <linux-kernel+bounces-520513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF90A3AAE4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 22:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 122DE3ACEF2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 21:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FE91D5AC0;
	Tue, 18 Feb 2025 21:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EreGNnjg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF371CF5E2;
	Tue, 18 Feb 2025 21:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739914164; cv=fail; b=CKiYQ1arhhayREBmbY+sJ9UKS9S6V+9WRnpCvIhjoIiofaSMh0+YX4lT4yMrCTDo4effipZPv6CjAUiCFtSIBojU3vb2DrDI+7FScmgE2nHzw/aBLLHgKdlzDlL/yDJglEqNwl/0E11SUx3f9tvIv8jSoMKuVSvOOKgJM1mCnx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739914164; c=relaxed/simple;
	bh=XCHuGEuIJawExPZcx1IHZ4Fru/HHjc2i7iNnzi+u1mw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KnFW4kMJDMEN22LJh3fNsWFjOH/t22uiPgy4b6J6ghKqlcW8xWw4pgkJe4yblu2Nh5fD6ZabD7tmvKgion5LvtBRhj4vNYxbz1xekRRXjpluM5Sm6400mW0M/3rDG/1GT21YHBIQ90If7ZPXuA6mCiOeF4pud8RY5MwVsuuBGoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EreGNnjg; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739914163; x=1771450163;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XCHuGEuIJawExPZcx1IHZ4Fru/HHjc2i7iNnzi+u1mw=;
  b=EreGNnjgsjfMJbcEUqLVcHdQN4VoIOX91yCrZkqOeUbEnHq74/24RqKJ
   SVWEWa/qMsJoJW1+6Yccj6qqTjorM4g9Cjdb8ZlTJ/pFbSNb3UcSEScaz
   ANS70eo9AEjHeUXF/sLTZDFoXWCj2Ls3z6YMmCDtroVi0SvDf/TZwv+SD
   r14ArLMmzrphfMST92zvHwwN9R+ZZA3001i5X2XolNXjBnIqNV04ywb5g
   XqMrLpT5uPt1R5Cdu46zoaKjq2ggFFIbEknjx2l8Qv2g0q6RbIk46iVKL
   OMyfkYtINuC8EUDWOCzpS/X+SmuLPoSO58H7EWrEWc2/IFlZXLpbxaEkm
   A==;
X-CSE-ConnectionGUID: rFhQXqS4Rt6x4zBs/vXbkQ==
X-CSE-MsgGUID: KCHjUFfZRY6cF+jRQ616Dg==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="50843108"
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="50843108"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 13:29:22 -0800
X-CSE-ConnectionGUID: +E7vuiu1SJqmceX9J4uAPw==
X-CSE-MsgGUID: AwIJaizMSfqwj8ToAvU+qQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="114257838"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 13:29:22 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 18 Feb 2025 13:29:21 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Feb 2025 13:29:21 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Feb 2025 13:29:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ygl9ft0g1ngItcwPZt676dRJxC7wNWabA38akGGUwHzS6qDhCQO2dKlO4iZbWw1qHNyY3+VCycTaNV+M/KIr09n62XWi85o+f2vvdf5kzVdArlQHCOSt6nQxQGdEuKAn11KZs9GI/JSO9dfTDCt6oYAKhU25PL9LrE6bmJtlz0WvEW4SD9lxPv1PnBCLQYSTewa1/VxhzwTe6kQYbsrwNhAPHzUpVb44zE2GfhCSxyR4v7RTqUMUd4TM3/HtCCnt+4eKMjYwZU8yCcscnJydfCGMcGq8AUnmTqDbeZbul0gh3w5rMQIB+SqlTIIbZbYLAiVv4R79OpdCs8PL1olbOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3AZJh88xjCNZ276h3ba9UsI8MC6yTmp35HqJhd4wyZQ=;
 b=bess6o22zVQ98MdAg+8noTFiJxpA3zXHG0E3mtk+AcuCPZ9DExoPOUL50VLzidbD3XhX7PAP9FqKGhmOBRZIFLPrYYKNhDnXnTr1vpX+eUJTZCitHIwuiqmU3AMyXBU7ebTILJAJ01CqPCDWgNZv/hajUnHHmXzUKMwCbNjiUKbVnZglZv0Mf3Ja/SgYqt/RrRXprqBwSdb+zG8/AtAVddtrYuoNGZYL+xBXl4vbetNfAlu1rKA7u7vx/MsOAm9qClw9BePWnM0qtenZWtByuB8P/JaCSrQfuO+5V3eohTIewCrTyEezNu5b8MkG0DuFJvRDdwWP262EcpT6unHXyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CH3PR11MB7371.namprd11.prod.outlook.com (2603:10b6:610:151::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Tue, 18 Feb
 2025 21:29:12 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8445.015; Tue, 18 Feb 2025
 21:29:12 +0000
Message-ID: <486ea907-a64c-459f-9210-e25f89f7ad38@intel.com>
Date: Tue, 18 Feb 2025 13:29:09 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 00/23] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
To: <babu.moger@amd.com>, Dave Martin <Dave.Martin@arm.com>
CC: Peter Newman <peternewman@google.com>, "Moger, Babu" <bmoger@amd.com>,
	<corbet@lwn.net>, <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <tony.luck@intel.com>, <x86@kernel.org>,
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
 <Z6zeXby8ajh0ax6i@e133380.arm.com>
 <9e849476-7c4b-478b-bd2a-185024def3a3@intel.com>
 <Z64tw2NbJXbKpLrH@e133380.arm.com>
 <76b02daf-1b45-473e-9d75-5988a11c6887@intel.com>
 <8ef51f28-e01a-4a7d-ba86-059437edb60b@amd.com>
 <a07fca4c-c8fa-41a6-b126-59815b9a58f9@intel.com>
 <CALPaoCh7WpohzpXhSAbumjSZBv1_+1bXON7_V1pwG4bdEBr52Q@mail.gmail.com>
 <bdb48b29-92cf-4f98-b375-25ec84f0941a@amd.com>
 <Z7R9VedhOSp64W7X@e133380.arm.com>
 <56a48b63-7625-4d90-81bb-29a1eb588871@amd.com>
 <81e3993d-2f00-424b-8cf4-341c321149cd@intel.com>
 <698577f3-00c2-496c-b787-506cef589d26@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <698577f3-00c2-496c-b787-506cef589d26@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0293.namprd03.prod.outlook.com
 (2603:10b6:303:b5::28) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CH3PR11MB7371:EE_
X-MS-Office365-Filtering-Correlation-Id: d3bd412a-14d5-44c1-e3ae-08dd50634971
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bVVFWlZ2TU5iNEhmRU9zOFl1d2dWRGhVUis1d1A4ZGtpWEJsZlZvYUc0bUxo?=
 =?utf-8?B?bHY0eGNUWEFKVEZ5MFc1UFI1M0p6WDhsWldtV1V5VitnK3RXcWx1WllCRjU1?=
 =?utf-8?B?SFRib2pPT0Evb0xQYmRoK3RQTXhCR1F3SXp2TFZIdDRSSGI1T1M4cmEwMTZI?=
 =?utf-8?B?ZnlvQVZlb1AwbHhKOXU0MGpZd2tIWGhwTWpOUFVzYi92cUpmYW11WXZ1SFRS?=
 =?utf-8?B?S1RpZGZRbDNZekQrVk1YKy9LQUdXZXFFZDBSajM5N2Z3ZEJHbEt3Nzl2ZDk3?=
 =?utf-8?B?ZWlQaVA5RVFIbkdJcjh1RkZTb1FXV2dZRTJuQksyRmk1Z2tiL1ZSeGcremQ1?=
 =?utf-8?B?eDlDa0gxNVY1Z3R5Mzg2Q243cEhPcFhENXJOdzkweUpnNVp2RS9ZU0hUNEw1?=
 =?utf-8?B?NVBpNmJ1bkJyaFAvQW5sZTJRQlYrSXhYQ092cGhZL3ZQcE9mUmJMbnNkVlBM?=
 =?utf-8?B?YmRuQXVhSXZhbks4bm8wRldhVE9iVTlYVklBM1RHelk5cFVKcS9tTEFHeVhB?=
 =?utf-8?B?dW9JUGNZSVI3V1dMWDRFaFJPMWw0ZDVtSlVra3BpdlE3c1lYU2YrMDlaNGRa?=
 =?utf-8?B?ZXhBcTBBUzhDMGtmVmhCWnd0WnhPSFl6T0tua2NRMGYxTWt3a202ZTM1R0cx?=
 =?utf-8?B?cXY3TVRkODJHelNzNWwyRmZmWmFha2hYM1V4MkNaajBoUGwxbW5IcS84czJk?=
 =?utf-8?B?YWkwT0hqWjA4VWtGMGhvZWdJckV1NXdlQ0NNZzd2bnVuc3BBR2c0MDdzbFVL?=
 =?utf-8?B?bGdzZHJWd0kzdnFDQUM1NTgzbkM3THM1cGx5Y24weUptRkFYb0Vnd0hoN3J4?=
 =?utf-8?B?TmRteFNsLzF6d09NSDlOSjdHUGx2cXdwYi9RRmNhOC93S0xKblN5V0IxRmF4?=
 =?utf-8?B?OU83QndFeHNTc2NNMlZMMGloR3lMY0R6SUZMZzRnTEdjSG1IaTNaS1ZKbXNq?=
 =?utf-8?B?ZTF4Qm9Id3E1L0JpdkEvSlUyTVJGa2dLeDlNTzI3Zzd3b1ZaSkY2WGJkaTJi?=
 =?utf-8?B?ck45bXI4bzUreVYvUU9PNHNRT21DYWNYS2ZkSUNSd2lYaFZ5V2FyamJ3bGtL?=
 =?utf-8?B?SEtvQW96ZXhQZmRzdFV5U1Z5R0hJREpRbCtaTzNtcWsrU0xCYnljYzdnRGRQ?=
 =?utf-8?B?WXFpdXZpNnV6cUxYRHRqUi85U1JheTROM2pPTFFqQ1NRUmRQQVA3aGYxRzAz?=
 =?utf-8?B?dGdvN3d0eGFOYlJ5RnhPOE1yMWhYMzdzamJvYUVndDRScktIOFlmZ2ZsZUY1?=
 =?utf-8?B?Y2RuNzNqMXNhdFNUcVFXT0M1eFJ6KzBrU3kvWm9FZExvdXlEckF5VlYzaHQr?=
 =?utf-8?B?c1RDU1hBbHoyRyttTUdEb3NkcG9naWpPdllOakgzZDhKY2VLOHlYMkwyYWZr?=
 =?utf-8?B?cXY3N1dtdkFiQkdKZG9FbDJnS2tXT05tMm52TU5lems5UlZ2c2dGQVJNOERv?=
 =?utf-8?B?amw1SnVKRGJubmRSMVNyYTdFSXovYmV6dldYaTFZTDM3eGQ4V1ZHZjl4WmpH?=
 =?utf-8?B?QUlKT0JTSlNrMzVKWGhJc1V5czE4ZktPY2F1b1RMR1JRYnhaOUJ2L04xU2lC?=
 =?utf-8?B?cElhaFlJWXhxQjBiV1M5Tm9RTjVkWGNkeEVxKzhYaGRFOUhHNFdldlZqMXps?=
 =?utf-8?B?RWFWeFl5NVoyMmxRWkxmYnY0elRTZWxXeEFoenpSWnJYOWhCcnRPUTFWVTdo?=
 =?utf-8?B?VklzMHpvVWxteTJ5ODFHQ0lXM3QyR3JMTThPVWdrb3dGZXJOajlUbW1tRW1w?=
 =?utf-8?B?MFByUzBXMUhUUXcwY2w1MGJ4TXpEOTRGSG9OemJSc3ZGKzc1N3JGYlRxSEZn?=
 =?utf-8?B?SnhlcmQzT3o1dUU5RzJsM0lXcml0MEwvMjFTS0UyVkd2dU5hMlF1Y1h5c3pN?=
 =?utf-8?B?VVFUZVJsMktpTFVhb2tFZVRNTlc2K045aFIxSEVDa0J6dnc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWViaVhGRFJLVHZCT0c4NGFEdkNEeGUxalcvT1hpcEw2c0N3empCMHhhdHY3?=
 =?utf-8?B?S0MwOHVWQmJPeWJ5bjN6NnFIUTZZMlZZU3lKVTRUVDlXaU5jNm1aZzdVdCty?=
 =?utf-8?B?UStRUkNadm5BWkhHeW42TUVDN1pNSjA3UHhUTjRrMDZ0bDhiWG1UaG1DVGRW?=
 =?utf-8?B?WFhDdGhnTGhhUmVDUTZCTndTNVc2S25hQXRsc0VMVEVRM3JXdFYxNDRHZ3BJ?=
 =?utf-8?B?TWxTb09MbURqZ2tDQXQ3UlFRMkxhRXdPSnplZmVicEZGNkYydnNvYVlUMXhx?=
 =?utf-8?B?REc2SDNhQzREOGpJandoTENOQTRHWnpqV3ZJVk82YlQ5MHFITGNvQk9SdUpz?=
 =?utf-8?B?eFdwRWVHR2lWY3YraWFzZy9CS01IcGNRczNhbUVRNzgxRnU5SkNZcFpLSFlt?=
 =?utf-8?B?YVRWSlJ1aHJSQVg4SXJxWWd0ck44UHRwRllNd3llZHhaS2x6eTc4bnF3QUNF?=
 =?utf-8?B?ZGpncWhSSW5QZGROd210cjF5WUtFU0M5aDZNVGJsQU40R1NNMTZQd3FqM0I0?=
 =?utf-8?B?SUU0Mit0SzhPRDRpR3JNcElzc2dhVDc4Rk1vSVBUdUozOWVDYUxSbDZhOFRV?=
 =?utf-8?B?aWxJM3FqdWZBTjB5NW0vbEcwUWQyT1YwcjRrdElaYkFwRloxZXAxQVFEWm81?=
 =?utf-8?B?bjBkbFdYRWRnYy85UldkMHR0VEZFdDg3ZS9iN1puTE9rTGc3clE5cEgrejFi?=
 =?utf-8?B?cUNWaElzUUJMMHE5bG1RVzQ1L3JjNjk4U2xEeWlEQ0JzUERPWEd6SnJZUS9U?=
 =?utf-8?B?aVZrR3VaenY0SnM3dFZPY2swOW4vM2RRWlkyQjZmcGJzNTFtTHQyMmM2cmxn?=
 =?utf-8?B?K2YyeWNpR29hOXd0RnVwU0VRZzBLWFBnWXNkM2d3NXQrZmR6WWltbUJxVXJ5?=
 =?utf-8?B?akNObXppdWkrcWw1N2FLT1BIVnAzNmQ2Q3loOWxFRGtQOXRxMXRzbWJ0eTZB?=
 =?utf-8?B?MTNMcUtRZ0gvZVAwMFI5OUpBcjhjSzlqTVRiNTRUTmdrWnZTRWRiUUw4Y2J3?=
 =?utf-8?B?YTNTR1I0bXMrdURXWURINnk0TVdiWFo0bFhQT29WUFVtZDNYVWFFbCt2VElE?=
 =?utf-8?B?VDhJYU9yaWVKL3NmRnkwK1NjakJpSTZvY0hQSndrSzhwdHRIZVhIVVRXcldH?=
 =?utf-8?B?NjdISExVTjE0TStqa2xhdVFlSVBudlRrTitTbDN3R3ZxbzJGd1dPMGRBV3Z5?=
 =?utf-8?B?M0ZaeFVlalBQUmFUWmpEa0xKeDIzSHpwR3p0N25TTFFSWjd3NWxLT0M1RjJR?=
 =?utf-8?B?NXBsWnA5SndjK0krSzAvMlZycVJ3VFQrY3NHK3Z4ZG5rRkFyL3lkQ2lxS0wz?=
 =?utf-8?B?Q2haWnRHbUs3SFgrUkxSdWZuOTIwK0JaMVJOMFJQcWx6UWd3SHgvWWx1VjFI?=
 =?utf-8?B?T1lNeW14T3VaUFhjekF3R0dwK3lYWm9IVTR6eXNma08wSktlcWdVaGdzelBU?=
 =?utf-8?B?Q0ppUHdNMFRJVTRsa1ovNE0rU2Z0KzBDbVYzSTRiR2RTUWJrYXRxZllpekZO?=
 =?utf-8?B?VnZCYmtLcnpjWSt4eVphODVmeVgxTnJrQjNNQm9zZFh5UUdtVGdycGM2U3JD?=
 =?utf-8?B?Y0x0Q096bWhzWHVjT3ZqaUs0ZkJiQi9hcEc1Y0xwUXEwaG8yTjZLTUhzSDRh?=
 =?utf-8?B?REhBMmY3RXR5RUxaczU1RnZHMllyRnJnSncydXoxNjNOSWxISkR0RFR4TnZ3?=
 =?utf-8?B?ZDYzQ1FaOEJQS3BFTGJTdUR3MVhmRGhFVWpjZ1daMWtkWk5IWnA3aE1YaVky?=
 =?utf-8?B?TUZuZWN0Zy9zVXBQdnAvenp5TmQ4enkxdG9XQXlIUEVncDF3RDl1NnF3bGhU?=
 =?utf-8?B?YUlTZzlHY21zK3JldDcxQ1I0ellmV1hLNkNqMzhNWmZuY2ltMUR5bnZKMy9Y?=
 =?utf-8?B?aS9iTGlod3Q3ckd1anY5d1RxNnYyVXpDdHZIcHdFMkFkUHhDa1F3MDh2RHNG?=
 =?utf-8?B?VGc4KzRRUkdGMS9VSGU3QmcxWC9Gb3hHWUk5SXJrOXpoZm5aZUo4TDdsL21X?=
 =?utf-8?B?VlV6Nll5eE9RMDE1NDlHZW5LYlZIdHFSME1nRGc2c0hCaTFNVFZMblRFcjFB?=
 =?utf-8?B?ZDV1am1jVGZ4OEhwSVBiNHdjaWo1YUk3bWhhMzF0Z0Y2clJKNmhmSXVZZ2Rv?=
 =?utf-8?B?ZmpJSHFYYUNRc2doRGRIZEFXZHZOcmZQQmh4SXdBckgvMTVEYUJHeHhCQ0xP?=
 =?utf-8?B?akE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d3bd412a-14d5-44c1-e3ae-08dd50634971
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 21:29:12.2604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CXT1T19CYFW0VChrotB7x+d9jgY2B2cFAp/432SKo5jV37PbQ1vH8JLxvo8h29PIxQvumNtUuE88E0qp4WFJdlQtuvT+9v2rjfPL9XlsCZE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7371
X-OriginatorOrg: intel.com

Hi Babu,

On 2/18/25 11:32 AM, Moger, Babu wrote:
> Hi Reinette,
> 
> On 2/18/25 12:14, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 2/18/25 7:39 AM, Moger, Babu wrote:
>>  
>>> 3. Use the actual events instead of flags based on the below comment.
>>>
>>> https://lore.kernel.org/lkml/a07fca4c-c8fa-41a6-b126-59815b9a58f9@intel.com/
>>>
>>>  Something like this.
>>>  # echo '//0={mbm_total_bytes}{mbm_local_bytes};1={mbm_local_bytes}'
>>>> /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>
>>>  Are we ready to go with this approach? I am still not clear on this.
>>>
>>>  Reinette, What do you think?
>>
>> I was actually expecting some push back or at least discussion on this interface
>> because the braces seem difficult to parse when compared to, for example, using
> 
> I am yet to work on it. Will work on it after confirmation.
> 
> Here is the output from a system with 12 domains. I created one "test" group.
> 
> Output is definitely harder to parse for human eyes.
> 
> #cat info/L3_MON/mbm_assign_control
> test//0={mbm_total_bytes}{mbm_local_bytes};1={mbm_total_bytes}{mbm_local_bytes};2={mbm_total_bytes}{mbm_local_bytes};3={mbm_total_bytes}{mbm_local_bytes};4={mbm_total_bytes}{mbm_local_bytes};5={mbm_total_bytes}{mbm_local_bytes};6={mbm_total_bytes}{mbm_local_bytes};7={mbm_total_bytes}{mbm_local_bytes};8={mbm_total_bytes}{mbm_local_bytes};9={mbm_total_bytes}{mbm_local_bytes};10={mbm_total_bytes}{mbm_local_bytes};11={mbm_total_bytes}{mbm_local_bytes}
> //0={mbm_total_bytes}{mbm_local_bytes};1={mbm_total_bytes}{mbm_local_bytes};2={mbm_total_bytes}{mbm_local_bytes};3={mbm_total_bytes}{mbm_local_bytes};4={mbm_total_bytes}{mbm_local_bytes};5={mbm_total_bytes}{mbm_local_bytes};6={mbm_total_bytes}{mbm_local_bytes};7={mbm_total_bytes}{mbm_local_bytes};8={mbm_total_bytes}{mbm_local_bytes};9={mbm_total_bytes}{mbm_local_bytes};10={mbm_total_bytes}{mbm_local_bytes};11={mbm_total_bytes}{mbm_local_bytes}
> 
> It is harder to parse in code also. We should consider only if there is a
> value-add with this format.

Please see my comments in [2] for some motivations.

> 
> Otherwise I prefer our current flag format.
> 
> # cat info/L3_MON/mbm_assign_control
> test//0=tl;1=tl;2=tl;3=tl;4=tl;5=tl;6=tl;7=tl;8=tl;9=tl;10=tl;11=tl
> //0=tl;1=tl;2=tl;3=tl;4=tl;5=tl;6=tl;7=tl;8=tl;9=tl;10=tl;11=tl

We could possibly consider some middle ground where flags are separated by
commas and when the amount of used flags reach 26 the interface can use
"two letter flags" or "longer names" or "the actual event name" or ....

> 
> 
>> commas to separate the events of a domain. Peter [1] has some reservations about
> 
> Yes. I would like to hear from Peter.
> 

Reinette


[2] https://lore.kernel.org/lkml/ccd9c5d7-0266-4054-879e-e084b6972ad5@intel.com/

