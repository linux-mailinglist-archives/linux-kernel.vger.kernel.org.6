Return-Path: <linux-kernel+bounces-290348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4161F955288
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 23:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED6A32839C3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 21:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D221420D0;
	Fri, 16 Aug 2024 21:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FsHUl6tY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4EC1C578F;
	Fri, 16 Aug 2024 21:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723844345; cv=fail; b=jhXevsE6P5EsA5A2c9RK5tFeDA7LMtqNtwfNPkaOM0aKEUDFdbtbn/Iy4gPNMiT36yYvCVuY8aR/dkEZrQMOe66qa4+pKn6hOH0RvpYRyUCIojLH3Aw+HrfR7u+M90WAxttIyw/5eVDutQSikw78Nt31Xy2x+ZKpJPylfKncpfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723844345; c=relaxed/simple;
	bh=gAxZEKB3ccAQC5sLA6Qoo/sUjXGRcLdZ7suvRfvmpeM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Shhk+Ooul+iPd4xnv64TCE61Fc9/VBZY7mx71saUGFL1RrZDglomTGu+EA16Hvg6F1bInULBYwqW1YoYt/5TNLvjzcopPlTTqjIEt3tHM+4zkEVtL841LzJjBM4upBaOh8AZNhZCOZGCZX/F2xPY2V9Lu6303NTf1eH8l+p2hRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FsHUl6tY; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723844343; x=1755380343;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gAxZEKB3ccAQC5sLA6Qoo/sUjXGRcLdZ7suvRfvmpeM=;
  b=FsHUl6tYosH5K7DNUoxHNRNkdEFDTZOmjhnL8vQ8hKSn3FH56XEmSy5a
   IFnUMNDZH48Y8M30YSp8eOc71/zh0S5IAHNynoxtRO9MVO8VSQPX2M3Ry
   ILhh0EozftK9y62rhfLScWgD2ydFBEOcmnihcwDcmf3oF4ScLD0lygWDz
   8TRrSB0euWS0TKPWubDPwwPDAO1bcMQfj1xcYfYLPHj99/TEeeIz58piu
   kRLY+Rf1Wze22yofeGwn04u4Eb05Cjj0TJyIMhmLLK8Z330BdXyV/pbri
   ZWXG1k27GLghvFjOvBBNTRbYmad54QirjYu+kwLx48oWsR+Ybgj5IXT4N
   Q==;
X-CSE-ConnectionGUID: F5bCMznoQ5Ohb9j13fsaqQ==
X-CSE-MsgGUID: O5Jh6D2qQ3mI4pa31oucQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="39608043"
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="39608043"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 14:39:03 -0700
X-CSE-ConnectionGUID: 0NGMLjefSz+i99L7XKcsAw==
X-CSE-MsgGUID: BHJfQ9raSG6KAedYBUUuSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="60335504"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Aug 2024 14:39:04 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 16 Aug 2024 14:39:02 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 16 Aug 2024 14:39:02 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 16 Aug 2024 14:38:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dxszfj4hW0o1fE+5Z9LSPBTyzU1ZN9DAmtMoU+60bv29fza7D3JSs5n/dAr1LFAffBnwnUIJuWohHrdPprcpzYY4dL2H0mAMGm56am6BfdiTOIGy1ijVVZ4w6A8YuDj3NXJPhE5TjsCHYmuh/oy13+C2frzna10lVRpKFT0iwZ2Ax+Oez+5ikKfKPG5WeWV0f0qpM0zNQL+5QSpIOgvjFDK93zet1HfPzlayqkWDxkN+XaY26ejUKaAl5sgmuDmOn4QN8Ye87QXEAsF6g69Muv1uioekp4v9is3xnlIzSWP2R70zXi0ZypVecXTfBdy5yAHGsmJA/vTgO9a3e1gndw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Cbt8dJ3dKVXE4IVS/fDfp0JIYvgdWQErpwtabv+INQ=;
 b=Pikbis+daXcyXr4HDAxIeXC7cFDLWda/towit0GTD9aYA0DQdFDGPm2TxEtD4tFpTVkmjMcmpkYsHPpnobVgVShnAd8fNs/jOV7eZstFAFAA7XbtDCI5Tt3mloLUv/TJHYHme3HnChI+lJssiETRuyHGu1Hkdi6U1EHxD++rJ2aT0GgifnqxXrkK2UszJ12lqyuKVUc/sW8ssr9cSHhV+a/szBqpkO5ruXQWmEiTTtEI/rk6hI09AN7wr/yLggqNXH6Qi2a2wT511uBwoQsVu8OpqcQbm7L1KZznGhCtuknXWTk1M79m6UwTxYf8Yu6twcDi99nvxml+pnwfJGPs9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH0PR11MB5128.namprd11.prod.outlook.com (2603:10b6:510:39::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 21:38:55 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 21:38:55 +0000
Message-ID: <34387cbb-4899-4edd-97e0-db66798085d3@intel.com>
Date: Fri, 16 Aug 2024 14:38:51 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 14/22] x86/resctrl: Introduce cntr_id in mongroup for
 assignments
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
 <5b8b1f354c2f4b5eda3fc7f2ba0d4d0b3744fb61.1722981659.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <5b8b1f354c2f4b5eda3fc7f2ba0d4d0b3744fb61.1722981659.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0031.namprd03.prod.outlook.com
 (2603:10b6:303:8e::6) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH0PR11MB5128:EE_
X-MS-Office365-Filtering-Correlation-Id: c7f61026-1ad4-4362-c1cb-08dcbe3bd40f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U3V4ck5ZUG5rQlNHZGp1UUMzaVlZQ1N4bTladjFEMU5mdWRyNWhLdGp0ZUVU?=
 =?utf-8?B?QnV1USs2MTMwQWNzdXNtckMrTkNaNmxLQVdHbWlHVjJLZ0NmQnI1bGRkZ2dv?=
 =?utf-8?B?UEpKenpQM2Q4bjlYWDMvY0tpaWkyODE5bWtGZjVoRVljNklBdkdDai9EZnZE?=
 =?utf-8?B?dnh6bVNnZjVnR2xvTlBHZG9FZ3g1WjVrM1RvM09TMHBCU081WlNEa3FMNjJi?=
 =?utf-8?B?S2pCYW1Ya2laT205QmtHTnVWS29BNjVSSGFzeE51TVVaQlpXT3F4ZmNtbkNQ?=
 =?utf-8?B?MGhLVFIyQVIwd2xqbmtkbWFlUnNMaU1tRWtucEhvM3lqODRrYkRuaEh6clAr?=
 =?utf-8?B?OXJUUG5XQ1ZNYWZFNldtc1pld1drK2ZqTEpmWFJMSUFPaitwTjJ0K2tLYVFJ?=
 =?utf-8?B?eFhYN200alNLMm5qZlVKblhDOFdhZmJxbmlvUytZb3ltV1F4bitHZFNGTWxt?=
 =?utf-8?B?Tmc5dTVqamlORnU0dWozV1NhUGxDemcycmRxcmNTcXZlL1QzY1RvU3ovWEsv?=
 =?utf-8?B?UGxGcWFpWG5MMTZuaWdmRk5mczRPV2hjeDhKSHlYbW1qWmR5ZlN0L2xuOENs?=
 =?utf-8?B?Y3hlSFhoK1RyT20zMlN0M0tkTCtpT2ZwdGl3VFBrYmtmenVBaFdqaGV4eFpV?=
 =?utf-8?B?RzdBaHBDUENra3FTVmtPRjhqa3VEeWJDUlVqL2tuUitjUHhQVytMQTgzdFB0?=
 =?utf-8?B?b3Rucno4cXV3bFVBbjU1Zk53VVd4NUROaHkySFhrek1RWVFlSjFkYmRRMWtn?=
 =?utf-8?B?M2dzbEt3aXE4UjJFem1nWkxBL29TbEt6Vno1SDRXU1B0Ny82eHNHKzJrUkpS?=
 =?utf-8?B?Nm5iN1RKYVl6dVFMeHNxLzVrUVd3dXkyMWx3Q2h1Nit1dVV6Y3hYZ1NNU2pa?=
 =?utf-8?B?TUJNTXNRcnJ1WUtDSVZ4MURlYWVvamN5SGlWc28vM0hRUnByRFd5elJ3WGpW?=
 =?utf-8?B?YjZsMkVPVlpiK0ZGa3hJOWFXMUI1dlNIMVc2c1NQaS9CRWpTUjdVWkpId1hy?=
 =?utf-8?B?SFBQMzZ3cXRpMXYzNkYxZ0ZyUkVQTUFzcXcyQ1hXYTFJMWozS293SUdKVTdI?=
 =?utf-8?B?RjRhM1VSUXZ5VlgvNU10azVZOXRlWWNLSi9sS0x5OFl4cW1EVzZ5T1hiNC9U?=
 =?utf-8?B?N2tqdTRLd3pSME9xQmhYMXV6VS9oV0hRZUowVGpXaEdjdnFpQlB5R244OVVj?=
 =?utf-8?B?YVVEL3ZmY2drcTA5WU5scE5USkhCMEdIV0FQR1U2L21rM1R0azFHVXMvVWFY?=
 =?utf-8?B?VWF4UHN6aXlPL282eUJTQUNkczRXUjN3aFFpcEgreTFvT0tQdmpMT2YwNW9T?=
 =?utf-8?B?dk5nblJEcXRlNEIreG9HRUlTTTVXMENab0hNNVJrQ092TEZJamNGUzlmcFJN?=
 =?utf-8?B?NTFjVnpobWhEQkkyZ2dVaEMzLzhhRHBXTS91UGtUSnJkQktDMmhJQTI4dHRI?=
 =?utf-8?B?b2tZZ1lsdVRhUCt1ZTd5ZGhzU1pWd3pFV0FibHBVVUM0bWVWa3ErdTIyR2cx?=
 =?utf-8?B?emRUM0VrQnoxMk5WYnZYYUluelAyN1phaUZCQnYrMUorN3JXR2haRDlQcHYy?=
 =?utf-8?B?aFlXb2FDQlFFM3Z4amUzZU5lSU5vTVB0Q2t4czI5eHQ1TEpFamVqK1ZYN011?=
 =?utf-8?B?LzFicmJwMkQweWUzb1hFM3JERGRSNGNCcjlSMkZ1cUdnTGNqZ2hrOXJOamVP?=
 =?utf-8?B?b2owQXdpbUs5VFh5Y0czZnpwcHVBb21pN0hwKzNXMjlOaDZ3ZjhpWmc0Y0hF?=
 =?utf-8?B?RWJaazUxcDFlN3NFVjhvbG1kQXV2VUMrVldWRS9ZTlR5REJwMUg5djhiWW9T?=
 =?utf-8?B?cklTNnpCMTRSUVF6TXVVdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vy8wUHpweGM2YkIwTlAvR0JMSXFsZTRmQy9zRlZMU3FLdFVEOUl6cW9XZEpL?=
 =?utf-8?B?MGVUM3czZlB6WlNUc3pxeXJkT0NzM0N4bHAxbHducEdwY3hjeGtZazdCeEVB?=
 =?utf-8?B?eStFU1ZTQ1lpYjB2N2l0Z3FnMitBUlJTTzl1ZVBFdVBXYlBnbHp4Y3AyenRj?=
 =?utf-8?B?MmkvTkVDMWhzaVVVNVZpbVBhZFZib084bUdrbGV3ZUVuTWU5RnJhTGhOTFMy?=
 =?utf-8?B?VXlmMFJPQjBKei81V1VkdWUwS2IxenhyQmdwZm91RmlnU2UrMnkwUzlYWGMv?=
 =?utf-8?B?ME9MWXFWZjM3cjBLelB1ODRzcDVxbjNPUDc5azIzTlNwY2tBc080ZmNXb2M1?=
 =?utf-8?B?MlQ4NlJZcWlZNVc4UDZwaEVMa0ZzVXlERDNtRS9lVVBFRzNCQ2hYb2J3VW8z?=
 =?utf-8?B?WEFVa1VoYXZZZ0trOEZsZGJkSXlWS1N5UGJyTUpvOEJnY1ZucG94SjFPT2Js?=
 =?utf-8?B?c0t3MDhoMVBUeEVXR0ZodFozY0xVMVZTSjN4dmZHQVdhNnQ2eThnWXUwZVJr?=
 =?utf-8?B?ditvNEVENjdhTkFobWZnejY2a3RuRVBuVHFMSGhpMlM2allrU0kvS0VIR2Qw?=
 =?utf-8?B?LzB0UFdLZnFoSnNLVU0xdTVOUklNRUdZWE5KTHp6WisrUFdGb3pUK0YvNXJo?=
 =?utf-8?B?VmlDa3ZSZlV0VW1KSVdtZ3B3Y3E3YUtScDVwOVFUTWFZVjJZZFNha1lJcm1R?=
 =?utf-8?B?ZTBGem9OdXZ1V1BHeTBScGtOUHJrR0FyS3M1Q3l3N3ZYZUFvV0w0VGxmbDdG?=
 =?utf-8?B?NUMyYklBNW5Hdk0zai9TaWVxbmpXWkM0cXVUb2p3cDIwVzNTTHJkVm1HMmJj?=
 =?utf-8?B?UHVlYlovczZDVU9TdmFoeW1YTUhTOU1KelZJQmNKQU5tcFFxWkRVY1pLZ0Fi?=
 =?utf-8?B?ZkZ2M0ZDZlJWYVZpZ1RralR4WWJEYXpoT0tDMHhMZnRyWGJhNm81MDU1NTF6?=
 =?utf-8?B?aHpjQ2Q5dDg2REtoK3dMN3BvTkJlM3o4YUtkOXp4VnFlLzM0Y2E5M2dOeE10?=
 =?utf-8?B?L3pBNVFZaVZJVHRERkRTSTRydTVNM24xY3A3VGh1K29NUFFLSFh4RTh3RURN?=
 =?utf-8?B?UExtZUtKRUZkMHNzOGpLZjlwc212RFVGMUlnZEdDL2RIb2tBMW5qOUllN1dE?=
 =?utf-8?B?bEJQREVVZ2R6ejIwNVhsM29IRnJEK1BEZTlYdUVJVlROL2w0QWp5T092UTJM?=
 =?utf-8?B?NFlGTlFrM3gxWGptOStCdnZjNUs5RjhOd1dIOXNlcUtsWHkyVzlIZFJyUzQr?=
 =?utf-8?B?WHFDSmd0blNWL0k4cTN2d1NXV0lhVjZRa3ZPUkVOQzZDTEhEYXB5VXV5MWVa?=
 =?utf-8?B?KzNtOGVNMXZ5cGVxTGd4NjVBckU3UVJxYkdvT0dJQnFPWitmWjJkTGJLVWhu?=
 =?utf-8?B?RmdqeXBKMXN6dnowQWNQYTB0OXduTUZieGJqV09CSTlKMm5MbVVtOEp0bmlO?=
 =?utf-8?B?SU8yWWlyMHpBU1g2c0VvU3luZ0x3c21kSUkwc1VCSmZtZkViTUIxZkpJc1NH?=
 =?utf-8?B?VStkZFVtR2wvSmtkN0JOd25RRzMwNWNpZGVkRjZWamMzQ0piSThsMk9IdnND?=
 =?utf-8?B?ZVV5UjJOL1JVWjRuYWxRbjVZblRkVVkzVlNodkx2SnpXR3A2Z2JlVjVEQWdS?=
 =?utf-8?B?TnlOVmwva25CSmRPR0lLMERTZ1EwbmZWY0FOREpEenlEL21LVEZMQndqNG1n?=
 =?utf-8?B?U29hZS9OR3hUZWtvVGhTTm80QXBieWV6NTRrZGpQRk5XaU1lclhmQ3lHUnJx?=
 =?utf-8?B?elpvaHVEWGdUZkdKS2dtZTVVcVBQWmVxZzFWejBiM1FWTGhUNGlMcXNKZ0p6?=
 =?utf-8?B?bUxCTUdHZzd3SGJNZWZ0Mm41MkwyMGRBcUNENHJZS2FuRFhEZUNtajRCZTdR?=
 =?utf-8?B?WlV5dDE0c2VQUUZ3ekJpczIvWUFPdFpMRUo2RnQzLytBVXZ6THNYeG1KRk13?=
 =?utf-8?B?NjVEM1RTRlVDRjlqSnJvYXRUMnBnbzYxSWxRUHNicFFaUGxzczdtdE5tMEly?=
 =?utf-8?B?L2hEMjh1aTg2ZFdZZlMweFdMVUlXTWs1VjFwNUhXRGFtcXlxQVEyNWd1NkJR?=
 =?utf-8?B?S2VZZkxmblVKTjBqck9oZ1I3aXFjL1VUM0R4b1ArVGM0UElrYXBtYzNuVlNR?=
 =?utf-8?B?UklzYU90NXBkZjEwc0FVK0FsVm5wS2tZMGtBQXlkc3orbzRlT20xQUxDcFNL?=
 =?utf-8?B?NWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c7f61026-1ad4-4362-c1cb-08dcbe3bd40f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 21:38:55.0915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 28s/HFuieMOEspGJeYBtakGmoSxNlscHOcmwHNEMRrMhjdYFiyRKbGcpa9Tw4Q+MJGEmwa93QqPWKivtwfvONv3ERtgcMeUS9aOjkqem5Ro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5128
X-OriginatorOrg: intel.com

Hi Babu,

On 8/6/24 3:00 PM, Babu Moger wrote:
> mbm_cntr_assignable feature provides an option to the user to assign a
> hardware counter to an RMID and monitor the bandwidth as long as the
> counter is assigned. There can be two counters per monitor group, one
> for total event and another for local event.
> 
> Introduce cntr_id to manage the assignments.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v6: New patch.
>      Separated FS and arch bits.
> ---
>   arch/x86/kernel/cpu/resctrl/internal.h | 7 +++++++
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 6 ++++++
>   2 files changed, 13 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index af3efa35a62e..d93082b65d69 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -41,6 +41,11 @@
>   /* Setting bit 0 in L3_QOS_EXT_CFG enables the ABMC feature. */
>   #define ABMC_ENABLE_BIT			0
>   
> +/* Maximum assignable counters per resctrl group */
> +#define MAX_CNTRS			2
> +
> +#define MON_CNTR_UNSET			U32_MAX
> +
>   /**
>    * cpumask_any_housekeeping() - Choose any CPU in @mask, preferring those that
>    *			        aren't marked nohz_full
> @@ -210,12 +215,14 @@ enum rdtgrp_mode {
>    * @parent:			parent rdtgrp
>    * @crdtgrp_list:		child rdtgroup node list
>    * @rmid:			rmid for this rdtgroup
> + * @cntr_id:			Counter ids for assignment

Could this be:
"IDs of hardware counters assigned to monitor group"

Reinette

