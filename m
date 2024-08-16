Return-Path: <linux-kernel+bounces-290346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F87C955284
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 23:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD5DEB21D53
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 21:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F971C461E;
	Fri, 16 Aug 2024 21:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RJ0mSs7c"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E17E13CABC;
	Fri, 16 Aug 2024 21:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723844278; cv=fail; b=tT79bVcrNPegX+jH3ZVoq4cZ/wykcUNriswjK0zv3YXPs4iHq0eVLJ9YzY5TL4W/gdbhbeaLY8DeThfECHtRFFF5/8RnF5R0ClfvZ30gzoJfDwvQEc7RM7E7T4qe9rzomwFjd/MkpyV72UGYM+4qq+juOzKNerDOASW00Eb+8WQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723844278; c=relaxed/simple;
	bh=s+QjYjR0jze6NqXOFgYVp2+3Xvc2uA4JSAY6cJZYinY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g6Ik6NlP3sojDgZ+Mq47OR/y14jcog1X9ZCYcF7RzvgXOEwqlwyxgbWsuRf6ZTU1gWsBlu0q0XcoB7JBpXAll+Az/Io2w4fJGJP9k3SGesgYl8ZaxMWKj97lQt+5J4EHhqvBoi7ICCdLcThvFJQq2H6JBHYpQQCXTCg9vgmAVQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RJ0mSs7c; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723844277; x=1755380277;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=s+QjYjR0jze6NqXOFgYVp2+3Xvc2uA4JSAY6cJZYinY=;
  b=RJ0mSs7cV7TCjnSXBwsuLwRnX/BrEEifmy0PwRB/HMkV6EqjtQ8ihYLq
   h7ObgYDlkYlBjCwDxoEqo9JrMoh6qCDolm8qXmONg3r/eh41/3e232AJU
   VLfjFX5QM0Jm47ghOF4Hdjd2w96va0e+xeIQU/a9H7tEH27GZ340eNNpw
   +A1vG0X0gZPHssHna9CZpVbujnmJzyrw9q4gmo40HNBe6O4niT8mn011K
   NBKZzM7ZWV9x3akdApx/x8z0nIx/tZgBjTz4KWCyEPjlKc83WlnM+65uZ
   n3ywNnoE8HyD1JaKt5kGe7L/TwKr7w+gLJ/yRM0psl9kkmwrgigEmTzV0
   w==;
X-CSE-ConnectionGUID: vgWZoeHqSsOHzqZodWHaWQ==
X-CSE-MsgGUID: LSGw2nW9SsGgP5513mhlAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="32785663"
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="32785663"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 14:37:56 -0700
X-CSE-ConnectionGUID: lJ5IrbchTvaGVrecMkSGBw==
X-CSE-MsgGUID: OXDhDYCzQ3aWiSPV9fYPfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="59946598"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Aug 2024 14:37:57 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 16 Aug 2024 14:37:55 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 16 Aug 2024 14:37:55 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 16 Aug 2024 14:37:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gZWhnEHGa/ltF7J/gn/D+91mvNfoc7beq1+/WVT3joTg5cwSZqdXk3lKie4e0XwbC+e8x40ep0v7JD3pZ/z5lxNokLZvR/e/wncbdL7vYPPwPcY8PeZrg5jDc80xoDZDGRzUhUx9xq9mgRfulVjBUIA4gKmA5bm30RkE7qp6/UdgujNyNGWGpHirKlIjDDOzhH0lR6NPNxruny6FRS7+ioqyMvkT4bS42CW8luzkdTd8dhHsL0dh5Hck9LlRjM7NMWRxwaxVBDStyVdZeicD/yrYYL/C1m5NtgJ1Tqi1vmQMElUfqW6yYl75KZTVUTkn6b0XF7pphO8Pg7AkdzZtVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yvhRdmlHnvZW42HaJ6vEYQ0IK/1JHA3epx7xwi7EMdI=;
 b=r2rGtUdF7Y89hSHBHG86VZjVKj9MypXfXxSVJagXN+zARUsp2rd57ehdrwus24UmvW3J6rlLrKmOviuZA20YuFG6aoCrIUEiHYNTrU1ARSjZJyYq8Wyf17WwZmYacAdJgwJ2m7/rE6k5kcEWmlSRr9TxksfoFhhIwtWbRfCnhlWzGZGZrEfE+KhLJLs/lRTol4bohg42sIaidMm1pQSZNVWyWZtW+X6Qp78MAhCBXBZs0flNGOS1mXQJeYAceTKNt1AqRu9b4OOFD8d3gR7zoFAYvVTaE+RaTC6dL1oNhew+Ci8rq2GBZGp946Q17m8OhjaXgjSjEcRN65lDOpkhrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH0PR11MB5128.namprd11.prod.outlook.com (2603:10b6:510:39::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 21:37:53 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 21:37:53 +0000
Message-ID: <7e0bfa19-e18d-4c43-917a-c56ad869feb9@intel.com>
Date: Fri, 16 Aug 2024 14:37:49 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 12/22] x86/resctrl: Introduce mbm_cntr_map to track
 counters at domain
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
 <e905666d2341a5a8c8e8bf3a337291375a80e6ce.1722981659.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <e905666d2341a5a8c8e8bf3a337291375a80e6ce.1722981659.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0352.namprd04.prod.outlook.com
 (2603:10b6:303:8a::27) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH0PR11MB5128:EE_
X-MS-Office365-Filtering-Correlation-Id: f0d2b113-409b-48fe-c6ff-08dcbe3baf0a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UWxsbTBCd0RyVlVnRWVaMHpjTG9QdGQrUHdraDZPQU5QcjFpTWV6ZzZzcHlq?=
 =?utf-8?B?dm1IcExiSFRUY0IyWGRNZVc5Y2VEdzd5NnkvbHVsd3NpV1IySXF5ZHFQaEZ2?=
 =?utf-8?B?SHhLZ0NCbGFVZlB1Q1REalFjVERIUHFNOGlQbmJDQnpLNUJPR3Y4VEp4U0xQ?=
 =?utf-8?B?cElJZExzbm4xOFd1Q2hTTzAxaFZuWkNJSzR6Ym5BbVVrQWM3M29KSDc0RVNy?=
 =?utf-8?B?L2kydDFKUzMyS1h0TytqSHBxMU54SmRiUGZTb1ZOcitVdzdGUDR0SVEvWW5u?=
 =?utf-8?B?MEFEVWg0YnpRZnA1YzRTaUtaNnJvQ1FSd1JvbitrMmNzKytzWjNmMDVCd1E1?=
 =?utf-8?B?TWFrdzlDV1g3c3NhN0E1YjNQU2c5cUpMdTN4MnNjYVpLb2NFUFJJcnF6YUFo?=
 =?utf-8?B?SVFmZDFNRUVMTDVmS3pGbG5tLzBOUnArdFpra1BVM3k3Smx0NlJ5akdSRlMx?=
 =?utf-8?B?K282a003czdIaWsySk9YUzF0K25mQ3FHTERvVTRnc3lWSnNuQm9PaDVEMGg4?=
 =?utf-8?B?b3daWG5aeU0vZHc2ZDkrWGwxU2lyL1g1SkU5aGYxdzRpd096NXYxbGptLzZ4?=
 =?utf-8?B?VGZnTlA1czU3MXBUMlM0VmJHSUsycDhtOXREc3NRK285dS8xVWo4T2E2SzlB?=
 =?utf-8?B?c0pXZ29Xd3VXMVZlQUdKM3dwVElmK01mUWxJbEVXVUpHSjJ2bGJoa21vK3Fo?=
 =?utf-8?B?dm11VU8rYjdiTG9DOE45eEpqUW5TNW02WnFUSlcyWU5PWSsxdG05Y1V6eHN6?=
 =?utf-8?B?akk3bzA0WEdrQ1g1T09vYXJzWGJIaUx1M2hwb3dPVHA5dy9uSEVJUlJLWHBE?=
 =?utf-8?B?bEVxUUZNbTlQcFlNSEtOc2dtT2ZZbkx3WWcyVDF2YzRGd3gwVFpJOEM0OWUw?=
 =?utf-8?B?anIzOTFJZDBGdXN4clNTMUprSm16a09WeEZLUTBtaG9pRzVOZlRJdXhsVEJl?=
 =?utf-8?B?TWV2T0hiSzl1TytWUmNmOEk0b1hIVDRLbEp2ZU5xUkluOFhvZTQxUTZidVhJ?=
 =?utf-8?B?QkIwQURoalZyb2YrWW82UmkrRWRBYVhabi94RjgrNG81TW9xUFlCeTlaeGF4?=
 =?utf-8?B?eTV0SHdqYm01eStVK0tHNS9XNk5UU2pHUHVGM1BHMUY4Vks1TXEzTnEvSGd0?=
 =?utf-8?B?Z1k1UkJaaHFMRGZiRzUvWC9XM3UyWHkvK2tVQzhNTi9FN0l2TkpuR0dpYy9o?=
 =?utf-8?B?cUc0S0ZmaCtUN0F6c2k2NWgrRTNkMHR2cnpHWVRZM2ZVeEc5U2xDZVAzcDFm?=
 =?utf-8?B?MUJKMWtzQm15UFNuRW50KzBTMHFKejE3Q0ZWd0Q4TGtyVERZTmRCdDlwbjBn?=
 =?utf-8?B?Y3VqNWk4U3lNZTlUU282M2VzVC9YS05oWnNla2xCaEdYcnBTbzJWL1ZCUGkx?=
 =?utf-8?B?dDRIMlFFeHo0VnBzM05jSVQ2di9iWUh4SjkvbTVhS2ZGVTJCcnZXSzRBWkJp?=
 =?utf-8?B?OFNHQTRFYUhzV0Q4c3lVcVIxQ1FOU0FVSmRha1h2WTl3aXc2L1BiR281TFlW?=
 =?utf-8?B?YzNWak5wZ2ZqRjRPdkxqUUVnNWNSblhtYWcxTlEwUzNoK2RIMU4yWlJtOUVw?=
 =?utf-8?B?ck9WelJHYUc3WDZtQ3cxN0t4YmRkUUdtZ2gwL2tZcmhZNFF6UjR4ZHgwQTJ3?=
 =?utf-8?B?em5WMkdrWGVvYWM4RkZOZzJxMmJBV0liNkIyaGVJNzJzZ1AwMkFaVjNvTkdq?=
 =?utf-8?B?YlZTUUl1aWhDN1NtaGtoS2dMSGlqSmRFNU5KQUNMK05ncjFGeWV2S2lSVXcz?=
 =?utf-8?B?eldqVWtuNHk1SER5eDB0RmJscy9jMTZCTlMwZWxYMHJ0VkhHV2pBenFIeDNG?=
 =?utf-8?B?QjZPYUNmQ2RkWjJPdklPZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0QzZ1U3YisyMHlGV0NiUllVSGtDYlgzckxmZFVYY1FwUGEvTjRUSGRsMWt0?=
 =?utf-8?B?YjcxQ1JXY3laQUlQWWYyQ2ZiU1pZU1l0Z25INGN0MzY1VEkzK3RaTG5ENGdH?=
 =?utf-8?B?ejlFb2p0YVdwYzJXQTJmWVY5S2xxaFJDNEdjaHFocUx1MHZJN3huNlc3bWUy?=
 =?utf-8?B?bzhKMXpHOE91d2hicGEzZldvZlB2ZnFSV2VjRkMyVkJqc0dwUWFtSEJ3a3Ja?=
 =?utf-8?B?d2tlczZ2UFJuUk5nN2VHaUpSVkptVU1EQ3ppMDUxYzg3WUJydmVxV0R2NTZO?=
 =?utf-8?B?VEprZXhoeUJaZFliV0JOTW9DcWgwMzhTQWM5SElPQXdxQUtTV0Y5Z3kxQ1Q0?=
 =?utf-8?B?bWlULzJqM094ZWo3emJmRk50dm5JanZCL2w0KzFxOHJOUmJLMnpGOU1CcG53?=
 =?utf-8?B?WnhEQlA1R2xpUlVIeEtVcXo2MjNoUUtBRkpCL2lyZnpQUGE2QnhvU1pHQWZC?=
 =?utf-8?B?TVByK3JrS1doS2VreHdQOHg5ZkVtM1ZsUlQvQ1poZk85KzZDN1NIK3J0cXVM?=
 =?utf-8?B?QmVtUE81TXduR203REZITndRV3B4cVo3NE11YUZRZDUyT093elZFWEcrVlRi?=
 =?utf-8?B?RWtzVlZ3SWlubHg0bzJuQ3k0MmFobUd2Q0dVbU42TGVEaklKa0MrRXI1USsz?=
 =?utf-8?B?ZzhYSzM2UmY5MmNqY252aHZod2Jsc1lNcXY1MDVYcjlVTWhjU1Ivc29KWTF5?=
 =?utf-8?B?dVJoS1F0NVdORWkzWTlEa1NHcmxyOTlwUXovRkxuRnRJdFcwTDJYOWo2aWJv?=
 =?utf-8?B?d1lOMEdDM0h1VVh2c0pZWWZKVXZUWWpDM28zY2pGdzQ1Zm9iSXRoN1EzODhW?=
 =?utf-8?B?TTVoV2pJb21pcFQ1YW1WblNiMGtRUVdtbzMrSGlhdWtqV3lDbEdSS2srbjhv?=
 =?utf-8?B?WGhlWjd5enVUclhuYXhPZjNmSVV6Y3Y3azB4YmFBRGIwWjBkVHN0NE9WWWVK?=
 =?utf-8?B?RUUrVEVzV01qSmJQMEZWVjBuK09qMFRKcU5RLzF3THFTZGRGWjV6eGF1WEF1?=
 =?utf-8?B?b0RzWmh4RVcxMmtPamV5TlhJTlRGY0FjMDdNelZsLzVFcXdxNjBybmwrWmVN?=
 =?utf-8?B?RUpITTBlak4ySTlpSTE3SVhpRTM5Q0s0T0srRFllY0Z4ZzBoVjZDZHZXaGQ4?=
 =?utf-8?B?cFNmczlRM2RvV1AxTkRwQ3I2Y1NBUHJRT2dNeTlwU1AwUDl5MEpvMFlwZ1pk?=
 =?utf-8?B?WFpGcDZ5R3AyTDIxcDlWRFRyRzBvN1QzeXZUUjNNSStPQU4xUWlhUXlBNVNC?=
 =?utf-8?B?eUxmS2djMGU2UkhUSnF3KytpbnBDYnN1aGoyNHdIVTFnYk11SW0rWStJREhS?=
 =?utf-8?B?VGdrSUZtdmFQc3dkMURERmV2VjdUVWxKbWp1RlVYNTA0TG1VdWkxTm5OYTBZ?=
 =?utf-8?B?Y2tKOWp6N1hlT3VXMnhhMFpCcXRiR1Nwbm5aQ1J6RUJTMThuVSs0OGUyTEo1?=
 =?utf-8?B?NlkrR3lXZ2VsZ0R3ZFVhelhJZTE0UTBDd0o3V2FFQkpJUExrTGdZdVhQVlcw?=
 =?utf-8?B?V21RVExGUHZ5am5UemRZQWJ6OE9tbFpFZnNpWkp0VXg4TjQzUDVnUHlWcCs0?=
 =?utf-8?B?OWg5SVRRMVZ6T0tpeWRxNWRnc0lOeHdRd2FyV3lseXdFSWVvTE5SeXc4aWJC?=
 =?utf-8?B?Qm5FQnljRWorZGtRM0pMTFhGWUlYSnlLajZxQ2haeDB6ZFpkeUVXSFR5Titz?=
 =?utf-8?B?NEdaSlM3SFBjdnZtQVcwYTNUaDhkTTRkSnY1K3c0aVVhWDJ0VkdvakgyaDBB?=
 =?utf-8?B?bkIxMk1jS0VQZmZlT1RacmJBNklnZGpRZGxjd1doc3NKd04yWHhXaTlYTUl0?=
 =?utf-8?B?VWZuNm1VREpQL1k0L3BNYU9nZVhjYUU1UllQRGdVSXNQSjZud3Vndm1IbFV2?=
 =?utf-8?B?dnpXVjhiM2EycDBEUE5FbHY3bG1iQTk3WlE3ZDV0VFJ4eVBWbzNFUGtoOUE4?=
 =?utf-8?B?Um1QcFR4Nys5aXpobktoNFpOWnhjR0xFd0xPV3JLMEZKay9kb1ArdFBpTC9S?=
 =?utf-8?B?Y2FpNlo4Titxak9neldadXZMM2UzT3dDVEtidUVtSHN6d3E2anVCSmI5bTMr?=
 =?utf-8?B?dEN6dUdKcE9HdTZyYnhEc0o3b2grYmxpc1oyTW1JT3dXQWpueUxLcnIxdnBw?=
 =?utf-8?B?eFd2UldsKzZjcUZLaHJGYkcrNy8xazZUV0VLeUc2RXl5MmpqcjlGWmptdWhM?=
 =?utf-8?B?Z2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f0d2b113-409b-48fe-c6ff-08dcbe3baf0a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 21:37:53.0080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oFBv7yB2t14bJJIwP2ZRUbqFFxcoeAsZtS+Xb8q+xvB1egBLPlZGpuTQKwefCycQSafMP/+0GM5/+sQQwNYGq0ZnXW+fTYlz4hEIVFy8uRg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5128
X-OriginatorOrg: intel.com

Hi Babu,

On 8/6/24 3:00 PM, Babu Moger wrote:
> The MBM counters are allocated at resctrl group level. It is tracked by

Are they not allocated globally? (but maybe that is about to change?

> mbm_cntrs_free_map. Then it is assigned to the domain based on the user
> input. It needs to be tracked at domain level also.

Please elaborate why it needs to be tracked at domain level.

> 
> Add the mbm_cntr_map bitmap in rdt_mon_domain structure to keep track of

"rdt_mon_domain structure" -> "struct rdt_mon_domain"

> assignment at domain level. The global counter at mbm_cntrs_free_map can
> be released when assignment at all the domain are cleared.

"all the domain" -> "all the domains"?

> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v6: New patch to add domain level assignment.
> ---
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 10 ++++++++++
>   include/linux/resctrl.h                |  2 ++
>   2 files changed, 12 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 0047b4eb0ff5..1a90c671a027 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -4127,6 +4127,7 @@ static void __init rdtgroup_setup_default(void)
>   
>   static void domain_destroy_mon_state(struct rdt_mon_domain *d)
>   {
> +	bitmap_free(d->mbm_cntr_map);
>   	bitmap_free(d->rmid_busy_llc);
>   	kfree(d->mbm_total);
>   	kfree(d->mbm_local);
> @@ -4200,6 +4201,15 @@ static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_mon_domain
>   			return -ENOMEM;
>   		}
>   	}
> +	if (is_mbm_enabled()) {

This should also depend on whether the resource supports counter assignment, and that it
is enabled to ensure that r->mon.num_mbm_cntrs is valid.

> +		d->mbm_cntr_map = bitmap_zalloc(r->mon.num_mbm_cntrs, GFP_KERNEL);
> +		if (!d->mbm_cntr_map) {
> +			bitmap_free(d->rmid_busy_llc);
> +			kfree(d->mbm_total);
> +			kfree(d->mbm_local);
> +			return -ENOMEM;
> +		}
> +	}
>   
>   	return 0;
>   }
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index ef08f75191f2..034fa994e84f 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -105,6 +105,7 @@ struct rdt_ctrl_domain {
>    * @cqm_limbo:		worker to periodically read CQM h/w counters
>    * @mbm_work_cpu:	worker CPU for MBM h/w counters
>    * @cqm_work_cpu:	worker CPU for CQM h/w counters
> + * @mbm_cntr_map:	bitmap to track domain counter assignment
>    */
>   struct rdt_mon_domain {
>   	struct rdt_domain_hdr		hdr;
> @@ -116,6 +117,7 @@ struct rdt_mon_domain {
>   	struct delayed_work		cqm_limbo;
>   	int				mbm_work_cpu;
>   	int				cqm_work_cpu;
> +	unsigned long			*mbm_cntr_map;
>   };
>   
>   /**

Reinette

