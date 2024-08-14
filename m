Return-Path: <linux-kernel+bounces-285842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C38A95135A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 06:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56EFF284278
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 04:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8133CF5E;
	Wed, 14 Aug 2024 04:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TWlOmqjW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908244D8A8
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 04:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723608130; cv=fail; b=DpgNnkYxJel2bEEOakuvXIwQlPLa39YQY4OD6bNKvl4j4WYSOToDDrqJ1aH1qp8GYaw9qbxknJIG6tBZGDJ9C8z1KE3tEy+0+xw+mufnUdQvJzjaTg8zprE1lsmGe1yJ/f7b7TzI6KssZ/5Nq961VixF+x0ssMNRitot5BuSqdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723608130; c=relaxed/simple;
	bh=xe4cg3FnYUrnCWuxCxYift4q67OWqHAfxbPM4dC6CzE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I+zDIrmFiprocY/a95eTS/NWS3/LX9LAVhMJMJTNwOBhhvBxgzvvjxeezaaKuvquqUwuC1+OXJD4DR3fioskWvpq+lqcxUYQgitlTeKmmY4kzTa6DAWjxH7VSjEclI7F0sL9JgRmafx6aqP11uLWpRwUG2aE3DS395txb++g2ZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TWlOmqjW; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723608128; x=1755144128;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xe4cg3FnYUrnCWuxCxYift4q67OWqHAfxbPM4dC6CzE=;
  b=TWlOmqjWy4a3AzKfT1WjzC2hemkB7nhdP+zX3Z/IhVuEy1uMdk0N7cE/
   ikguuzM0sXvZcEAu5nldwBEO7HSBp9My8sVYyGD4HDCFAz+6xRwnBR15L
   eg1NhIqsKcrlyao5EGCKaxPP+KhQDl4OiVG+K5nlzBciwI4eQD4AJTzAP
   +K/ir/nuvrxq9k0vjvOUMMl3sekGHL8rx3q1xvA5U93ulwvWeEY0MYHI8
   OMhNXz6HuwNISLHE/h6+2SNTtMstARJAcUoBibR7Fx0YzQg3ftQT7Mt+I
   yneZs6J/gFfAspsTP9jSN4xQZYSiGET/JCZDczpoVorcCKdLOk6LVefLH
   Q==;
X-CSE-ConnectionGUID: 6ylLkBqfRpyPKKOX0s1ubg==
X-CSE-MsgGUID: jvE/vr70TrmKd5WxjuHP8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="32427128"
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="32427128"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 21:02:08 -0700
X-CSE-ConnectionGUID: egi4ak+MQN6eL/uYQIMAcg==
X-CSE-MsgGUID: /oMrysJuQJWOU//PcmB7fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="82092365"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Aug 2024 21:02:06 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 Aug 2024 21:02:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 Aug 2024 21:02:03 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 13 Aug 2024 21:02:03 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 Aug 2024 21:02:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mBa5drt2reGIhfA1QTJa0D2Q4jkGYW2y+fJCDRtkqOOGz45FXH/5iHxFzPPLRo1TgcrNB56Zzzyq36D8K4c3Eyq/9o8SXSi5EtDLDP5rBFwj3vA9GHh2V4z1RZHILW+8XRqbaVxuiT9iFuudi38JRaTaWI4+9mW9re23Pth2L/cIGqB/vvT/11CXZr9C9LpjKrfQezwrmUWW9pc+ZGNh8Xbz8mGDsekCqJpt66R/ZW0SZStmmSVBDA9VGfDn6pOovMrAwZat4WiYm5/4gyjQRkHY2cDxIelbM3g9AEvNR7JyLsy/TNpQFz42QspTsaqvxZ6ra678k3PZD7db0M6yoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xl1MNUraevSFwKlIaYCtn9Oyty+fzNdcYsSiUqwPKQw=;
 b=XnPmvwxrMswvkfD7K0935rmHC/a8N1Zkg95OKnIBXj8U6nbKAooBzM+hsQnt1O/xvFomBRwvXKHvs8O0sob4IltcVOib//QMXU4qrd8nR6tKQ8c+Q4fgbh/HqjLc0G1rhqpUNKTBzuN+e1Uq1oeWsYGkREoPZqKFhgGxx0MmXMhx+1B9wQ7yQINb8i582NIZX6ei8jwp9lFKjcyWHQbt/FwG/NdutHSSwqrHJbtc/BzlKAijMtpp2O0EaRqHA2iiawpzbIGC/4j90aacShHk3c3U9kM4DsUeyPFOvuhFTwa95247cfvolWnEgdtti6E4dwHeMIplVQTFTEkYwaC23w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA2PR11MB4955.namprd11.prod.outlook.com (2603:10b6:806:fa::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.31; Wed, 14 Aug
 2024 04:02:01 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7828.023; Wed, 14 Aug 2024
 04:02:01 +0000
Message-ID: <6dfe3817-702e-40bd-8bdb-0048997c9b01@intel.com>
Date: Tue, 13 Aug 2024 21:01:58 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 19/39] x86/resctrl: Add
 resctrl_arch_is_evt_configurable() to abstract BMEC
To: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, H Peter Anvin
	<hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>, Dave
 Martin <dave.martin@arm.com>
References: <20240802172853.22529-1-james.morse@arm.com>
 <20240802172853.22529-20-james.morse@arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240802172853.22529-20-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0010.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::15) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA2PR11MB4955:EE_
X-MS-Office365-Filtering-Correlation-Id: 0506bafa-942f-4474-0a0e-08dcbc15d996
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dnducFJvTm5nN2NlUHFXL3VPQndSLzNmckJyUVpGOXJtQlZDUEpwbDd1eGJM?=
 =?utf-8?B?TVRMejNucndsc21VSkJVZ2NxME5NLzRZd0NGRHA5RDZDS1dEclVRb08rSjZ6?=
 =?utf-8?B?QVJVSGlTVCtneGdzZ2tnT1pZbWd0MzhYRkVlNDNuUUptUzIxMlRnNzJlTDZ4?=
 =?utf-8?B?dmtONFdIbEVOUm96ZUVsMjljTmpLT3RDSEQ4Q0FhWit4bC9HK0t0TWtlcldS?=
 =?utf-8?B?ckxRU1p6RWpoNStXdm9NV2lEbHdmMFpqdklJbXEwOEQwMEZhQUNUbmI3Z2lk?=
 =?utf-8?B?Y1k2VCtEU2ZBRG8vUzFTK0dBUllXSHVnL25DRFMxVUZPZGtPNGpiV3BWeUtw?=
 =?utf-8?B?dTlaQkcybmI2d0hhTllpSmk0V2cvOWRvRHZHT2Q4SzlSMzlRTTNZUW9IenpD?=
 =?utf-8?B?Y0YrRXZyUFdiRk9yKzViUjJOMGo2T21YaVJaTFpNMXNaNG1jK0xSc3pkWTdV?=
 =?utf-8?B?QXEwOW1nWE9pUWtkVUo0L3VyVnNTUWpWWHZTNDBtRHhSMzdrdHQ4RWtUb0xj?=
 =?utf-8?B?OGthYUp4QlczcmNjbWVyZFpkYkpCVUd0dnAzVXJhVlF3M2hxYnNLSzk0eUNu?=
 =?utf-8?B?ZkRrY09BajJzZ1FHcFNRN0FSZ01QNXR6c21BMHlhUnpwaFU4eldoWVE5NHFw?=
 =?utf-8?B?dEIzYkZPTGhKNVdaL1l1Z29USmwwaFduTHNqUm91enVtOVpTOE9LMENnaEt2?=
 =?utf-8?B?a0h4cmZtdHhvd0J3NUk3ekxhem05RWw3WnFFV3A2b2huVThVaEU1cVFJcHly?=
 =?utf-8?B?S2xqUmh3cGxUeWtLVFoxL3ZpSUtsTHdRSFJBeHVMSllwU1dPc1E0RTFtU1Iz?=
 =?utf-8?B?YWExVCtmVU9sT3lDV3g4dFFtR2N3K0k2ZTNOMldHU3k2QkhYK201ajVwRW9T?=
 =?utf-8?B?cHNiVWhXMzVCRml4QUdUQ1VLWGh1Mm90MzhFUVk4RWJmMEhmc2pVSUo4d1VD?=
 =?utf-8?B?MDVCdW1LdVBCYXBUK0xvWmNzdFpJUHl6dzRzTVYwbUxlVzZoaUdoWnlyWXpH?=
 =?utf-8?B?ZVF1dTB4WWtMM3JabDFqUVB1YlppQlpXQ0tmbTEydXpQOXR3UjBrdldmOVdN?=
 =?utf-8?B?VkNPQ3ZIOXl3TCtsanBITWQ2bU5JZndBcjdKVDNucDNMUVFkOFpVaGQvN2R6?=
 =?utf-8?B?RndGb3RjdFlxZkxPNXRHMC9ZTnY2UDBXMGtFUkc4SlN5YjVNYlFHaTNaS01S?=
 =?utf-8?B?TjBPZTYrbFVDUStJdjBnd2xqWENwZC9ES0xuK1ByQU9CM3VDOGFIVThLQUIr?=
 =?utf-8?B?U3VGbnY3cWg4b3IxTkxVTVhyemxKM0Rpa0w4b29lck1LZzNTYUpKMGVJTXpZ?=
 =?utf-8?B?WjF5SGdicExnaVlJbnhra0hoaEdCWnk3YzdXVDUrelZ3cENRTEYwWjZOU2oz?=
 =?utf-8?B?aFFGVW93ZVNiWlhLbjk5ME1xU3dJZlNmNG9wSTg2a1kvWVdna3NLSm9paktU?=
 =?utf-8?B?UjBTOVc2VzZ4VUo1ZnpBN25XQXpjakxCM2JIb21rc1NWVlVpeHQzd0R3dWxQ?=
 =?utf-8?B?VGx5WVphMWpwUzM1WW41YVZZYzQvQjMwTGtBaTZPZGczODNycWJPZ3d2N3lw?=
 =?utf-8?B?dkFaN1A4SXZVUjBLT1M5NHd3TlFHcHMyUS9sMW9XdEZNemx3dHpIak9nUEt3?=
 =?utf-8?B?VVFBbWJUUnl0dlJKRFJFa1JJL2VKYmVvU012d2NMS0x2d2xZRFdzbzhkS3Uw?=
 =?utf-8?B?bkRwZnlSQWZCQnY1UVRkblVHVitXcHlRYk1pRU1QMGJuZjc2d2ZXVlVmMysy?=
 =?utf-8?B?NGI3MVdMcnNLeEtYMlpYRGEvWG43N0dDNWJNaXd2SWdLMTNyNFpVUVZjYnZT?=
 =?utf-8?B?dW0xaUNKbHlsdi8xbjJ6QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmUyTjd3bHZMVm9sOUd1QXlFRUtYai9nZGl4UUt4VnJYM0kzNi9EMWY2cGtJ?=
 =?utf-8?B?L2hZdmU3WlRuR01VajYzcXg3QmJBR0EwUjZKWDJvbUdUQVIrQ3prb0JCb3lr?=
 =?utf-8?B?Snc3UkVCMkRtZUxQR21nd3ZVblRtWEhKMU1RVGI3SnBOcEJrSGtGVGZ1OGNG?=
 =?utf-8?B?R29wdTRmWnRBcThqdW1yTjZ1LzJzUEdFRmIyazZRMGRGTlJOdUVBa0VuNkNX?=
 =?utf-8?B?S2o5cXFQcnh0TndCOVJQU3d2aGFCMjEvSTN0L2Erc21oaGorNjE0VHNKd1c5?=
 =?utf-8?B?ZkcybUlNUFB4cTFkWk9aZWptNlVDa0lQaW1WMm1LdjN4a290ZVhKRnJQMmdK?=
 =?utf-8?B?WFRkYUNtM2VQNzNNeGZjVUd0UnVnZ1RDSVNDUXN4UWNIN0RLLys4eXhMcWIz?=
 =?utf-8?B?bDNMd0VsUTA3K2l0ekJubmpLTzV5bDVac0l3Q2pNNTFmRWJnVDZBb09YaHhX?=
 =?utf-8?B?aURTYVhpUWpZRkE2akFVRHQ5ZUlZSVBmU1BHbXp4WTRaY2N0b1BaYWlhb2w1?=
 =?utf-8?B?V0hoREwxVE81a0xQYll5c2xoNVNhT2RqclVLYitEU0s0RGNVUWNIYU5WQzV4?=
 =?utf-8?B?Z0RCQWVFNE1TNXVWWUVCZG9NT0dzSXhYeENXd1h1a2NQd3E1ZDhKL1l1RXhK?=
 =?utf-8?B?enEyRUs3MGJEUjVtd2JwV0lTUTdpOTF3Z01tZTR3OStqWHlSQmljeEVhbHFh?=
 =?utf-8?B?NFgycDJENUlzaDlRQ1NmL0RuKzVBRzBjWUdBbjVOejNMaTBGdURuUzN0bXEz?=
 =?utf-8?B?cWkrdjhBY3NVaCtCM2RzanRBT09QMkpvSXpGaWl2T0xSUVhBSkJyQkdRK0lL?=
 =?utf-8?B?b3BVSzRsSEFPM210N1FySDVMRTdqWS9oNWNXdlovZHQ5emNoTXpGOTlka2Fx?=
 =?utf-8?B?K3FLZ25NNHk4dGJyeGFleDd1QmwyRkNmVnhCcW9uT0dIRkdHTjFVK0w0YVIr?=
 =?utf-8?B?Q3hPRC85Wi9ELzZ0b0Uyd1ZQTTJKaXp5cWlMVEc4Qm5OT0FqYnRnQ21BWVJQ?=
 =?utf-8?B?c1JUdkE3ZEdmM1huWW90QW1mUldCOTBwQkE4WFJSV3B6ZVFIMWhqTksxOEFE?=
 =?utf-8?B?VUNyazExRnovS2VtYmpBQlhERFUxVGRBcmg5QmFkZ1djNTBKOXQ0Y3VHVWtN?=
 =?utf-8?B?ZjJGc0dZRFRxMGEyaHhxSTJSd2ZSNytoTWtpYUhuNkIwWE02VW5JMGx2S0RO?=
 =?utf-8?B?SEg0R2pwcFRaVlN5a0oydzN2V2dvT0x0dlpsdENmc3NteXY0WW9QRnZJU3Zn?=
 =?utf-8?B?TXJ4ekZYQS9DNnFQWkJqSTFSQUNleHJ0QVZZUUtrSmtILzNHYmlWUW10ZXZz?=
 =?utf-8?B?bXJSckVrQ01mcGNVcE8vYmRjVElzQ2diSk9BanF2N0xIM3BFNGdSUjNmeTZl?=
 =?utf-8?B?Q294L3lRMVhFK01uMGJPUHhyUjBRWC9SOHdrWUZFWGN6MkYyV2ZUeTVoUjho?=
 =?utf-8?B?OUx6K0s4ZGNZUUc5TE9sNDI3a0Voa1YvVWIxd1prSlNobFBKUVRoTmNPcHNs?=
 =?utf-8?B?YVFoamw4S24vTEVPVXg1a2EwclJCT01mWXYrdHZJaGxMejNRdUpERnp0ZmpR?=
 =?utf-8?B?ZnZqMkxqOUpvR1VJcUxjcFl4TDFkOUFnTUpic2lzWFMySXVKT0YrVEV5VzJ4?=
 =?utf-8?B?aDRTWThSR1kvK0h5dTlwSjVSdk52VDYxbnphOGdUYVF6Ym43eHdScFpaMzk0?=
 =?utf-8?B?dlByUytyaUllWHJLVkpGRHM0NXJsZmhnUzJBMUtDUnVKWC9Ldm80QzFFY1JR?=
 =?utf-8?B?Z0phUWx2ZVc0ZkxBZWdmaWdFcWw0TGpVb3NpUEs1YU1oQ29tbnBoS3QrbHBH?=
 =?utf-8?B?VUZIR1hhTjRiQ1FPaWFwVzdOSjRlM0NncWVvb0g2SEN4UllqbWZUUkFPbFpQ?=
 =?utf-8?B?czNaYWhLZHcvL1d4RjdTS2c3SVdaSHY2VUZYTXJTd3BKR0VLVTFqeUFLSERL?=
 =?utf-8?B?ZWxKemI3WUc5RUZ6SittSHhVNEVmdzM2TEFscWNuSVFDQmNiVlc0Zm9nRm82?=
 =?utf-8?B?SzlqWUhjdVg4UEc1ZlByWk9jYlc4d0doSmRuajFrTk5kMWxLZVcyZVAzdHM1?=
 =?utf-8?B?endndmxtMVE3TkdKUWZQZlJIZ20rd0J0aXZ5YUdQdXhUckJMZ21BQWVtRDVv?=
 =?utf-8?B?VnhyWWE5dENYRXJPMEphNEIxUCtRVDVBRWJTblJTT2tIQlVyQVBraGRVckZR?=
 =?utf-8?B?Ync9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0506bafa-942f-4474-0a0e-08dcbc15d996
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 04:02:01.1614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mx9RlXmkaxHq+AsN0rq7PBZBxq+i7wdWf2cnmKCnK2tDxQmgiEucHp1tFD5/PmSQ5TiNrOiQWHu3ey7m3h1jrRCFMSLHZZvVPpYHl0xoJDE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4955
X-OriginatorOrg: intel.com

Hi James,

On 8/2/24 10:28 AM, James Morse wrote:
> When BMEC is supported the resctrl event can be configured in a number
> of ways. This depends on architecture support. rdt_get_mon_l3_config()
> modifies the struct mon_evt and calls mbm_config_rftype_init() to create
> the files that allow the configuration.
> 
> Splitting this into separate architecture and filesystem parts would
> require the struct mon_evt and mbm_config_rftype_init() to be exposed.
> 
> Instead, add resctrl_arch_is_evt_configurable(), and use this from
> resctrl_mon_resource_init() to initialise struct mon_evt and call
> mbm_config_rftype_init().
> resctrl_arch_is_evt_configurable() calls rdt_cpu_has() so it doesn't
> obviously benefit from being inlined. Putting it in core.c will allow
> rdt_cpu_has() to eventually become static.
> 
> resctrl_arch_is_evt_configurable() uses rdt_cpu_has() from
> resctrl_mon_resource_init(), which isn't marked __init. In addition,

"which isn't marked __init" ... this is no longer accurate, which seems
to indicate that this argument is artifact of this series.

Reinette

