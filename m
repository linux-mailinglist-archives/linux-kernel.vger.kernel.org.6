Return-Path: <linux-kernel+bounces-172342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8168BF14A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 01:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CF891F25ECB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 23:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1634884E10;
	Tue,  7 May 2024 23:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kayWsCBc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B6584E03;
	Tue,  7 May 2024 23:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123187; cv=fail; b=AFO0HFn8/Otu02EZJ+MXDRRa/It/lTM9/tbo40UXACExbNFdSnnwkMT7q1BHsss8WXYGShSwsVuOrfwYCo2pgfd/G6h3nz+Z3C/RCM573w1hMhf5jaVbB8hKJ12DKVcBNrw4h0QszCXArubfrcdMsfTgggJXAUaRu0CUkZgZZPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123187; c=relaxed/simple;
	bh=ADzZYNwex1K2dUIvvh+obJcsWtNipXenycKlE60lgTw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b28OLnkwi/sc9ZV2vgoomenMkQp/OzUjn7gONW08fB/pP+zuo8HuutZ96uw1Yr/YZbvnqTjVlHx6eLUvUttW+WVxjA4qo6UFaKcQQBEYGJhdCoV9pK4NlHpILWjAi3GCQb7frmAKaSDDVT+mpETorFFMDy29XxUcKu2GZfg072c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kayWsCBc; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715123185; x=1746659185;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ADzZYNwex1K2dUIvvh+obJcsWtNipXenycKlE60lgTw=;
  b=kayWsCBc6gvqJZFE95Fe181QSaeAOyfO07DkyDzyXCf2Hab8RgFb5ZYG
   SgJajwPSEo8Q92PO0+HNo4DY8WTS7wnlfcy55lAYsG1/h0Zq6oJaPRG6+
   fvGvNWVkMefsNiTa+/tlfZ8+Ua4zfo6jJHFH/IyM/JjYjS2v5ZfNyN6d/
   b7zXLjgdu6z6yHkSwvKZ7MHQ3stzatpeDyS4AZuHsekSMZ+uQTL6h/A7r
   3eRie+mG/IiTuiK7LsweArgnpTGRzhnHNTkkS1UsKQa0BQ55x803kPnNQ
   0y6jPY3xnMO6cqVMfBTrWyk2LgwdkHScAFp5H7sStf/xKCYu03TuKYxX2
   Q==;
X-CSE-ConnectionGUID: gAnqzlwPS3ejh1V5rGQIYw==
X-CSE-MsgGUID: zrwi+qq1RpGr7T9KAL/GSg==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="11112604"
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="11112604"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 16:06:24 -0700
X-CSE-ConnectionGUID: ke3CJx0BTI++vkLTlaQc2g==
X-CSE-MsgGUID: G0vPsKj8TQ+eZAwSLtJ9dQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="29239244"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 May 2024 16:06:25 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 16:06:23 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 7 May 2024 16:06:23 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 7 May 2024 16:06:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K6CJqiOZTZssDa3RU7CMTBuq5dYC56kCf+8XHK4aYmj4gx6W/RKWy8CIGs9nvIoZ0DuFOdY91iV7uiIPShYgjXXgEv0kZhwiGMwIMvlfM23fw75SSVVRhgMr0kTupPUwN99XP57pLQc3kxL7Npha2bQRXzjNQNmOAs4qbhZIYAms0FWc0tplHRDp6NH1dNE2bIcGS9+NTrUxAgAmDe7O73xagGjByKWGTVq5i1D7NMM8yZx29qTiaTPz8Sj3wGGLooVFRIuaCkmLJaKEDuv00KXSMPQhNUTcsBq0swuUS771AFHBt6+wuMIuBaQSPC/59RMejoSyeUYvsmS+Uupz5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ThF8pZ3vjxwSmrpJCOWKz1wV0H3hKVd46mu7ZSjjrtM=;
 b=G9zzuaggpItz2/AZnfISaeJ5kfg4ynDUTplkiVw4QomwgDkb1SsqqcMOWH0r3XzbJ9u9bvI8X84BFYp53/n8x/Rm+2KHte9HZdoodmV7OlC717zdNTNs2Q3s9hwKGW/cXNdFeAtVuHwk9AfuZ0h+C7uHIW+H6ey/Rgo2QdYI544rH9+Zse42HLIv/MJo8uPAZs8KlxcGUsbwjfgbDqXaD1rdo4IQZeWBNDs0rLEYF41LZ3nNs+mlSC9Y+uPfvBDwKdUMtj9S6BYQ8EreihGGavmLOELrh7ACJELtSfSEYWbts8c6M/rcCY8bHNUCYg8Nw8SLNC9N+UpbQTu3/GIB7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM6PR11MB4707.namprd11.prod.outlook.com (2603:10b6:5:2a6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 23:06:21 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519%4]) with mapi id 15.20.7544.023; Tue, 7 May 2024
 23:06:21 +0000
Message-ID: <89d9996e-3414-43f9-82f6-0260a4f49285@intel.com>
Date: Tue, 7 May 2024 16:06:17 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 10/17] x86/resctrl: Add data structures for ABMC
 assignment
To: <babu.moger@amd.com>, <corbet@lwn.net>, <fenghua.yu@intel.com>,
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
References: <cover.1711674410.git.babu.moger@amd.com>
 <c3103dd30bc07070380a01922f66208759afe837.1711674410.git.babu.moger@amd.com>
 <3149b62a-b9a4-49c6-a757-5a0e36df62df@intel.com>
 <b367a6ba-3ff1-4173-bf71-cd7a04bf9882@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <b367a6ba-3ff1-4173-bf71-cd7a04bf9882@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0054.namprd03.prod.outlook.com
 (2603:10b6:303:8e::29) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM6PR11MB4707:EE_
X-MS-Office365-Filtering-Correlation-Id: e62cbd91-a4c6-48fb-85a8-08dc6eea4f1e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015|7416005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b2RUYm5IK2dRa2dPdHB6Uy94d0FkSjZqTVNhdk9XSmpFbUd5REhxYmdEbmwv?=
 =?utf-8?B?U3EwUXJ3azNHSytUQmd1VXhVQXNOVWpLdzNha3QzbFlvSEQwR2pEblVXcWNM?=
 =?utf-8?B?VjdPdDQ4aUQ0UlNvc0NqbzRSZkF1UE5WdWNJbmdGaDhzQkswMEtib1dDV3lq?=
 =?utf-8?B?UDJ5SDlJV1Rpc0o1SnRlQzk5dHJqWHc4K3c4bmQ5TlcxMXJjckVweUY1WWdK?=
 =?utf-8?B?V21oMGwxK0FFRk5OcTQwbDZVeGZXWm4xcGU1RWE1WVE3SEo5UHN3eTdLYnJl?=
 =?utf-8?B?UzJJemVibURMc3R1MGZXdWRoT3ZnSkhNcUw5RGJEYWN6VWV0STlwOC9hVFpO?=
 =?utf-8?B?VUxwWUlEWWxweTl6b05XZTNIMW9IT1JKdTZOKzVqQkJHRk1ab1NUMTJCOTNJ?=
 =?utf-8?B?UmR5OU5QNVZzVWVKL1pZd2lhVk03Q05GeXlFalpTOUxMMjVocHp2TXhTRnli?=
 =?utf-8?B?MjhGd252dS9FN0w4eUZuWnphY0dkRS9qU3l3NUFGaGJXc2tPb09OVzlOZ3ow?=
 =?utf-8?B?Z3AzbkhXdGs1S2YzaENTT2lzU3VMNDBhMXU0aXlDamJBTDY2TGJ3UHg4SmVm?=
 =?utf-8?B?TkYrYVphSTFsNjRsRXRMYitnREl0Qm9YeUhRSlZhMnd6N0duNUQrcGw5aHZN?=
 =?utf-8?B?R0dlYkYvTEdDdVRiVG9Sb0xrNTJXRGI5QkU3eWtGV1lnekFqSXpzUzRNcm5G?=
 =?utf-8?B?OFM3YVlSYzJkcmU1UXlpOWVFT2NCcXRoYlZRSVBMV0RjQ00vQzlyREh0U0lu?=
 =?utf-8?B?SHJ6bmJEcnVudGZkOUEyRFJzcmJGQzJ4bDZIWnlaNlF4Zlc2VForSFdrU3FR?=
 =?utf-8?B?YXhFSlRDVlFvejRHdUNyT25OZWNsbmNjNFBxeWduL1lQaXlUa21WamlhcEM1?=
 =?utf-8?B?QkdQMHZNSExTWFNMcmhOVzc4M291aERxM2pIWTV4OC9aV2tFTlBLOTRManZa?=
 =?utf-8?B?MUozTVNhTzNSeHh5SW1keGMxa1dQS1dXUFVTaGtFdGRldkdsTk9xTjE0VkRK?=
 =?utf-8?B?akJoS0hhc21BdjZROEVyYm5SUXlDcXlvRFp4cHp0L0ZZcmdwaHpqaG82U3ZX?=
 =?utf-8?B?T0Q2eTdmWU5Tclh3MlNCbkpWTHZWeU9HUHhxNWdlcHVyV2JOVk9FNjNpUitK?=
 =?utf-8?B?bmVra3NjL3JpTCtYWThHaXE2SWVFSjU0YmVRTEdhUUZiOGhHd3ZoK2grQkRJ?=
 =?utf-8?B?RnJEVzJPdVpPUEk2WVRrNVZVMWMzVkFLSEx3UmQxZmQvQVpZZ3o1S2RIWW9q?=
 =?utf-8?B?NHkyM1haU0F1TVdtaWxzanJWb0VDcU8rbGtFN0toQlY4YmNrMG1jRlF5Ynlv?=
 =?utf-8?B?QVZkdXlYUXJBaERYSzREalYvRDA4aTBuYlhQQi8xeUlCR0hnK0VFQUxKeW5R?=
 =?utf-8?B?ckI1czZZSm5CSk1uV1AzVzdNVVpJOC9kUnJpMHJZMGY5dWMwelM3eENHMk5v?=
 =?utf-8?B?OHI5S0pDRktyeWFYMWNmYjBreVBHZzVFWHpPNmtmbWJtTldycGdXcmR2ejN0?=
 =?utf-8?B?L2QzU2dwUjdYZHJPVlRPUW5PazF2dnhjdEdxZHZsSkRPMXRQUGNTK2hVMFZU?=
 =?utf-8?B?enMwbTl5cFREV0oxcFdKV3NMbjk3TklWQ3JBUWJJK1hBUjQ2aGV6aHJTQVZ0?=
 =?utf-8?B?ZlBYaHkzazdJQTV1MGNuOHdkNFRHcUpPZkxTMGlhc3gzUlZYclhRaHJvenNl?=
 =?utf-8?B?bFcwZjE4djQ2N1FvTktPMlQxWmlUOGg3QndFOEpkd3VKZTV5aUQxYWlnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yiszb2ZxSlFSTVpYa0hPM1E2ZlhkQ0EyYnA3RXNFSUc5TE0xbzZFcUVUb1FK?=
 =?utf-8?B?cW9NdVFCNHM2cDVremk3Wng1cVlEb3JRV3pkUisvV1VxdHVBRGErWERLQ1RN?=
 =?utf-8?B?SzRXRWJ3MlFxaXJ0cjZwWEdlcVYxUnpzYlJzZVMyK1hzSnRSODJ0T2RVZ3VQ?=
 =?utf-8?B?OVNtSmVmbHZFdHJxbVo1T3E1NWpmVm0zanFQanRRM0FJWm5xWEplRjZYTXox?=
 =?utf-8?B?L0E3MHVWRjNwZ0lwN0J3bGpCdDRhaUp0VS9OWHdKRm5Na29zdDNWTCt1V245?=
 =?utf-8?B?dytNdzI3TFBoSVFDRWZzRFQ3eWN3ZllOeE9PN0h2NFFPZXQ1Q0c2UzBJUm1F?=
 =?utf-8?B?NFRTMzVkRmhQUERjck9na2dLTjIrOWI5aDBoKzNCLzZ6Y0UzSVhxWmRaQVZP?=
 =?utf-8?B?NHNMa1lCdGRjSzEyUUdJdllabTZjUGNseVE0N1doSE13ekZ1akZsbHllcms4?=
 =?utf-8?B?bDVESzF2MTUwV3QvNTN2ZWV6QVcvL20zM3psYUp5S3lnSlZ0eDZIK29JcHNB?=
 =?utf-8?B?S21LbEhmZlpRNVVSaVdyRkxYankwMHdHVmRSbFdPK0dRbnVHSC8zRTc0MUwx?=
 =?utf-8?B?c0c4WWZjWTFKenYxU1E3WUIxWWpCS0ZoMnV0YncyMWtmQVdybjRuMHZGOGlj?=
 =?utf-8?B?amxKeFFWSUtKN3JRUHB5QklORkEwWEZrVGZyNUlvVWliOVBsUWhvcXNYbGZw?=
 =?utf-8?B?SGJETEJoQTFGYkZqcTZWV1lwRmF4UW8zYzhKdjY1NmlqZ1dteW84TVFBb1BK?=
 =?utf-8?B?YXVNNFNRc2F4VUlrWXZhMTJwbUpFNWFYc1VUR1RFR21aY1QvcVBBS09QWVkr?=
 =?utf-8?B?TG82QjNOSnYzd2dUV3Q0OCtvL0tNU0Z6NDNxQkxDWEdYaHg4QnR0Znd5VE9l?=
 =?utf-8?B?RkxMNXBDZjhYSnpWMUhuc3FCVUhiUzRFTEUxaVZQRjZjOUI0d1JVTU01czAy?=
 =?utf-8?B?MW4waHNMV2lvdVZjM3ZFSkJlVFgyV0JXWUdwb0dnSllQSEhTQUFRSERXa3RY?=
 =?utf-8?B?WjNSTWNvNWlOKzhhTG9tTkg1QktFTlZqaThBRm9WazIyenRRa240ZFAveC9r?=
 =?utf-8?B?ekh3ek9oazdyT2xtUkFWYTMxWFNZMnlhWmxHV3FyWmV3emdzYnVMKzZlVlhF?=
 =?utf-8?B?dmlzTTJhcGZvL0FRSy9ZMXFQTXhZdFZuUnMvRXp2TDljbVQzR2JySjNHUFEv?=
 =?utf-8?B?Ri9sRGVKNm1BbDNBcDJ6aUtSM3Y4ZXhKYXBHcWF6bGx6LzZUTFdhcDluT3Bl?=
 =?utf-8?B?ZjlOQ2t3bHg1V3FhSTY5cGpSclJRcjFjdDNpNWg4Mks3OG03Um4ybFV1MEVX?=
 =?utf-8?B?QzFKc0F4MlNMTEJ5MjUzRFBXM3BBanpoOUlLVmM0dGRRSzNxOWZrUEQ4cHV2?=
 =?utf-8?B?NzZmY08yakw4eG56aTkzelUxSmJ0QlBYODl5R0lUa0JVZUpTL1VkcytuNkll?=
 =?utf-8?B?YTNxNXdHVEVLSkZmQ21sbWc0WDZPTlNmdXN1d2ZKTlRIOTNybnYzL2RoYXda?=
 =?utf-8?B?eCtBa1VnTDFnTStWcUt4UFpBdTBhVTJqWis5SE83VHZscEpSKzhIbHNTTEhi?=
 =?utf-8?B?YnRScmJqakQ3NVRBcVJidmt4U2xRdlp2VUE0WmhhbEpRZjZQdG1BRURqTFRk?=
 =?utf-8?B?Vnh6cG5mQkg3L3lGekM2bVlVOHBrcldzR05Ra2tLY1JsSll6cTRwNzRXMGVm?=
 =?utf-8?B?K2F5VFpMRFh6ZHNJOEpCbkkyR25DRVQ5YjBWMDdoVmhwNyt2RGZsRFk4ajlM?=
 =?utf-8?B?UFV0bSs1SFNUK1BwMi9DUm91dlpCb21tMlg2TVRKbmIyWGQ5cnNpcnMrTjlw?=
 =?utf-8?B?YmtLV1NQbkhZTlI4N2R3UFhnOTZhaU5vOUhQbDZnd0hHeUpSWTlFWHliL2dZ?=
 =?utf-8?B?ckVsbmZpc1V5S0d4a0NCQ3BQK2kvSFBCYkI4VTl2ZGM2QzJHTjBkQm1nM3Y5?=
 =?utf-8?B?N3NCN09zeDVMeXVveXN5WjNEUmhUczBUb1ZRL0NSWHVLZ2x5WnhJN3U0UUs0?=
 =?utf-8?B?eDFuSVlpOVdSbi9GL0d1K3E5QXA0cktrVTdKQ1hyUk55Uk1LOExCZjNUc3V5?=
 =?utf-8?B?ZGI2QjFrTklIa2IwR0sybVF0Z1F1UFhFeEI0czZlK21pR043UGIwc1luKzli?=
 =?utf-8?B?V0hiNE5PWVhyeFhCRVZGaEU0VlFCdlIvbG5rLzhxNGQ1bFZKZ3BIdyszcUYr?=
 =?utf-8?B?Q0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e62cbd91-a4c6-48fb-85a8-08dc6eea4f1e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 23:06:21.0659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zFTy7Qfqn1Ay1q4sTGHFBaL/lu/m5U2tYQLjZgthedFOjlz1sxsHzoEi9k87A/FBxcCicQjXSkA7B63ILYP89OYBQtWz+ISsX/yobonkyls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4707
X-OriginatorOrg: intel.com

Hi Babu,

On 5/7/2024 1:40 PM, Moger, Babu wrote:
> On 5/3/24 18:32, Reinette Chatre wrote:
>> On 3/28/2024 6:06 PM, Babu Moger wrote:
>>> ABMC (Bandwidth Monitoring Event Configuration) counters can be configured
>>> by writing to L3_QOS_ABMC_CFG MSR. When ABMC is enabled, the user can
>>> configure a counter by writing to L3_QOS_ABMC_CFG setting the CfgEn field
>>> while specifying the Bandwidth Source, Bandwidth Types, and Counter
>>> Identifier. Add the MSR definition and individual field definitions.
>>>
>>> MSR L3_QOS_ABMC_CFG (C000_03FDh) definitions.
>>>
>>> ==========================================================================
>>> Bits 	Mnemonic	Description		Access Type   Reset Value
>>> ==========================================================================
>>> 63 	CfgEn 		Configuration Enable 	R/W 		0
>>>
>>> 62 	CtrEn 		Counter Enable 		R/W 		0
>>>
>>> 61:53 	– 		Reserved 		MBZ 		0
>>>
>>> 52:48 	CtrID 		Counter Identifier	R/W		0
>>>
>>> 47 	IsCOS		BwSrc field is a COS	R/W		0
>>> 			(not an RMID)
>>>
>>> 46:44 	–		Reserved		MBZ		0
>>>
>>> 43:32	BwSrc		Bandwidth Source	R/W		0
>>> 			(RMID or COS)
>>>
>>> 31:0	BwType		Bandwidth types to	R/W		0
>>> 			track for this counter
>>> ==========================================================================
>>>
>>> The feature details are documentd in the APM listed below [1].

documentd -> documented

>>> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>>> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
>>> Monitoring (ABMC).
>>
>> This changelog is purely a summary of the hardware architecture. I have not come
>> across a clear explanation on how this architecture is intended to be supported
>> by resctrl. When would resctrl need/want to set particular fields? What is
>> the mapping to resctrl?
> 
> Something like this in the changelog?
> 
> ABMC feature provides an option to assign(or pin) an RMID to the
> hardware counter and monitor the bandwidth for a longer duration.

Regarding "a longer duration":
https://lore.kernel.org/lkml/b5e68d85-4bf2-4e55-a9c1-b39cb7d94db6@intel.com/

> 
> Hardware counters can be configured by writing to L3_QOS_ABMC_CFG MSR.
> Configuration is done by setting the CfgEn field while specifying the
> Bandwidth Source(RMID or CLOS), Bandwidth Types, and Counter Identifier.
> 
> Add the configuration register definition.

This still looks to me like a cryptic description of the hardware architecture.
Could you please spell out to me how the above answers each of my questions?

Reinette


