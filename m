Return-Path: <linux-kernel+bounces-251189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C35469301CB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 23:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E42E283427
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 21:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28CE5A10B;
	Fri, 12 Jul 2024 21:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l5YQDMYx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77F45577E;
	Fri, 12 Jul 2024 21:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720821450; cv=fail; b=frBK1z1cqK1LkReHVgF+Od7dEydRDyFj7+u13BN4LSKhh/SPZSbskya1g203yPQDBhY+7CipXUpqvb4BrgZ2RACZPPRPwQRIyxCXN1rPNprqlslYbqonYZ3eDSymgT7n7VR7ZVw1LB0pkOHQo5EERWpQ5g7Efwl1d20Sl4HKKxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720821450; c=relaxed/simple;
	bh=hro7pAYb7NtM4QuQLWzUH7zT59Rxu77iUul0fVzwnns=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q21NosqyXBLe4ybWutM/7IguSlCeH3My58V02Wi3qMiBT22lhbDYJm2jvhYWUgg/SPBaQNIUlidEAAEI1XkdVNcPzPvVw+ZjqTHXilSvZXK30GfACmc6fAOnOwirZSYkzdbfMqh9E8AgyC28BzugbSrbe+sJyb0dMSB5+GxAkao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l5YQDMYx; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720821449; x=1752357449;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hro7pAYb7NtM4QuQLWzUH7zT59Rxu77iUul0fVzwnns=;
  b=l5YQDMYxV3KzQeB0gXYBTZlRPletpE981RWkZaNyuTZqYbKDq4JuJIST
   Sj2qnUErsLEvVQhxdpddpoobxkzRl8qtMNXhM38j1ASuNY23p+VkUeoVW
   VIejFnHNgGr8giyBdDsux54mYLi39c1iOcgesjiWWduPL1W58PYRjnvbP
   roEmyRLdllPW5C4KXOquHNYHgsazqYJ/ODr+2EkWtNdEKTOV6UwF8DjOw
   z1A0PFXcdZ8RfzhqLOESkBDO0Q4qZlc5QhGqRqZMy0qfDUMcG0bRnvNub
   zS4hhITwRxbF0Xbr9LYnqlOawkDk71lSn5LgaD/GOuS9aNdhYzyOX46oF
   Q==;
X-CSE-ConnectionGUID: CH6povXRR5CyArD+oOxTZw==
X-CSE-MsgGUID: xBq8iWe3QHm0DzEldq1WhA==
X-IronPort-AV: E=McAfee;i="6700,10204,11131"; a="17899868"
X-IronPort-AV: E=Sophos;i="6.09,204,1716274800"; 
   d="scan'208";a="17899868"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 14:57:28 -0700
X-CSE-ConnectionGUID: 5lxNMZgVSCeBLzM3QBOk7Q==
X-CSE-MsgGUID: VxZqn1hsSoKP6UhY6uDtdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,204,1716274800"; 
   d="scan'208";a="49118343"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Jul 2024 14:57:27 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 12 Jul 2024 14:57:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 12 Jul 2024 14:57:26 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 12 Jul 2024 14:57:26 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 12 Jul 2024 14:57:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HpF5dNOrTUQLl0ydjp7moVCho/8T8IvwhL19e/4lwIfYJsRawzclb6FJV/VMeiaLRwgA+Ytgqwo0FpwgtoxhJYqA5fYODPO83RkKz94Uppjdrze5AHxT1rzqHp4THQw5c8/ZpA2K/Abc5NlZ8KzLmhtgSpzBo5CV5HG6WcPoUvHeDDGlUXI3VYebZ/L+pCUYiyp4n880op3nd8uAwqsJI7f6b//ggptWrNaI9dYgOISo133KmPft2hyOb5Y4ElsC9risracP4GGZsNgt/ydjJIPY0Ph09oilhYFbSYUbrcdvASauiOl7uvlFSp5vfX7lDegBk+AhOCfN4chAKwfrYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qwN4aJoS1P3sxUcFrYCTr8dUBa+UDdDev1YHBVxQLKM=;
 b=uWtopbIIe0qlT0pfoITWNWEx5KebY5r9ek97Ebd75Byd1JPL1uAFkz32rnzQu4WVGZcuEDBze7gLNGWIqL18D7+DXVFDfd82OKZIhQmtrbNhH8i6bRwHyYgpBbR1bLkPBgpUHeu6o/DbwSNbVTPnUzTszv2MMflYqSJDW8ltUVTvhmeeb5Tet2C4D/yAipntAKWQf5jgXzux6hgHbcsMjiddtKokr6cNg0ojDWtccLv7IGao3NfwwJdVChBGJpIwVa4FIEGR32JNmT73dbqb/3gMh8DU6twFqAyYqybIURwp9o3regpZeG+PhjrggAtOQDGN9j5yBTyDSqILfMA5Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SN7PR11MB6725.namprd11.prod.outlook.com (2603:10b6:806:267::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Fri, 12 Jul
 2024 21:57:22 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7741.033; Fri, 12 Jul 2024
 21:57:22 +0000
Message-ID: <7868eaf0-8e06-4a53-a29c-c057ada46bdc@intel.com>
Date: Fri, 12 Jul 2024 14:57:18 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/20] x86/resctrl: Consolidate monitoring related data
 from rdt_resource
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
References: <cover.1720043311.git.babu.moger@amd.com>
 <29280097cecb6a4717d7e8a19249c9790684f67f.1720043311.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <29280097cecb6a4717d7e8a19249c9790684f67f.1720043311.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0133.namprd03.prod.outlook.com
 (2603:10b6:303:8c::18) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SN7PR11MB6725:EE_
X-MS-Office365-Filtering-Correlation-Id: 679d6669-4600-421c-9717-08dca2bd9b98
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RVJhd2JVVXNpWTlmOVRZaFRtaFlZdTk1cTN5WW5hS3BueDlqSUJwS3lhd2RI?=
 =?utf-8?B?WlUrZ2xrbUpNb2YzWDA5NjB1cXdZWkpKalZnY3RpaHJZSGNVRGRMNmNHaGdx?=
 =?utf-8?B?MVhTamhQVGJVNXRLVE5kSGtTZklvL2J6ZU41VE5wTUVHOWJQNkJzcjlmVWlI?=
 =?utf-8?B?U3ZCY2xJTXNxbXNoS3hhbG9DbzRzNzRhRHdJSFVudDdPemZIcVo1SVIvTldC?=
 =?utf-8?B?TnVoSzZqM2lQMUkwbFVVN3JhaWliMURTZ20vUDVENTFXQVI1NkR5aDZSY1pL?=
 =?utf-8?B?N1htdWlYa3ZneEllMHBiWVlqTTNMK3BFMzl5SG13ZkxXN3hDandKMXVQNUhr?=
 =?utf-8?B?M1gvZGx4Yi91cnordmlFbldKYjJDcm1XdUxuZUpxRkNpcWgwT2h4WVhVVWNW?=
 =?utf-8?B?L2QyMGZVWUJ3YWg3Z3QzTmRPSFlvWktheThERFpoczZ5aWdiRVVUNzZ0MnYr?=
 =?utf-8?B?TlVBWVBqTlNjdFVKcjF5eW5UTWIrdTJwN2tVMU42Ukltb2wxdG5DOUJ6SU1l?=
 =?utf-8?B?MEFxTGNJSkdKbWJrSlRuaS8yQkZTNndSaFRSSDh3QjArVURXZ2ZDZFRMVUV0?=
 =?utf-8?B?QzVpTDdaWEJjMUdTbjVLOHdJUjQ1KzlmL0crTXFBVkNwTUlsa1NOZmFzWFRC?=
 =?utf-8?B?Qmo3a0FwSGFQVHZwWUU2bGk5NEJNb1BzSGJEb2pVNUs0cW1TMTNJTVk1MFE2?=
 =?utf-8?B?Yjk1Z3piNlBPeXdWdXdDOGw0UGdOZXR0Lzhub0Z1QXlKVGY5UEoyZHdxdjRR?=
 =?utf-8?B?SFlLc1BZVThGNm5CSEVPTG50UGRIc0lXenN5MittZTFPYUZFRU9CSC9tTzNt?=
 =?utf-8?B?aWdYRGNDbHN6ejJ4MkpNY04vSFBzbHQwMTJMSzAydkRTNkY4Q2NqSllmKzZq?=
 =?utf-8?B?TjNxNDE1RzAxR1g1VjFTV2cvNlRoY1NVVGdGZk5xZnVxa1MwMThyVHo5ODIv?=
 =?utf-8?B?Ti9IaWVJYjI4YUVCRXpOUDhVNFJ4R2ZRdlRvUExzWTd0STBjWXVzWWo4RHI2?=
 =?utf-8?B?VzltekQwVEU0ZXBBT0tQMnppRmFycVhLQldvc2RJbFk2cWtMbE93OFhhOUFo?=
 =?utf-8?B?MWE3R1A0M0x5Y3I4MW9sYTRzdHhpeEh1WUxmakZnSHpzN0lScEYzVzNNb3BM?=
 =?utf-8?B?T1dEK2VaM2N2Yk1CY2prOFA2ZFkzNkhhd29xNGhDbC9NWHVoSGZyMHpwVjZj?=
 =?utf-8?B?RkRGYVRMZHpMMUkxNjg0b2xaV0JESGtmQTRrbGE3LzFiWnJpeUZLMldxV2Fk?=
 =?utf-8?B?U0dJbG9XWjNtZ2ZlSXlFQTc3R2ZSaXFsWHR5NE1NSm1vVzVoUDBMbVhCNEls?=
 =?utf-8?B?R1dheXdnWVpXUXhTNmc5eHBuV3VBU1JoUVA1OWtVdEJuRDYxR3lYUk5jZldQ?=
 =?utf-8?B?N2svd0NMQXFiVlBUSXFXcTg5RmlCcW5WRjdZbWVucEJEZ2FIZXdZM0FibjFv?=
 =?utf-8?B?cXgxQ05zSVZCZVl1TDRhZ0h0V1FJNllQR0F3eUx6Z1N4Z3BqVnBIU3hTR1Ji?=
 =?utf-8?B?Vk9penBvYmxvNGthZnZGOXhrQzJXVWViZXo2bjVGU2xuWlVmS01JN3dpT0ls?=
 =?utf-8?B?RG1iRUZRNy91d1FEMnhsQXgwdFF6SWRKSm1EZ3plVVJNZHVON0dCQlNsN0Rw?=
 =?utf-8?B?UEFXemtyYjFWV05CQVRaM0NhdmsxTzJleDc4aHdYbWo3Q1hmV2NHcHBxWm1R?=
 =?utf-8?B?N2NYVzh2YTcvbFJack5aMkIzdXFlV3BaYXpMR0xBUlk1VzREV0R5TUJJdFBC?=
 =?utf-8?B?ekVEelNaeXZzMGdMb2dOVVM4Yml2aDE5eXdBNFJteEErMlBqdnpSQmhYWUFP?=
 =?utf-8?B?MG5Ld2JCdkk1VXVPK1NIUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sld6dnN4QnhMdlF0ekJvbWQ4QktTa0VKQjE1L2FadlNOOGpQR080ZnVEWlhB?=
 =?utf-8?B?bDM2dUxmSU4vMU8vRThEK01mTzJHRmdCY3FwcHBQSml6clZOdE1NNHJHY1ly?=
 =?utf-8?B?REh3ZkpSbGQvbWY0ZU5KeEMwY1JuM0ltNHU4N1g3Yk1sQ2Ruemw1SjJGc3M2?=
 =?utf-8?B?R0VqajJ5RmhlZU1ma2xxM0xnOUpCTkZsamFnVTdUNU1ON0VXQk5TQXp3bHhh?=
 =?utf-8?B?ZzJONzBqdEtPVVFNZWpEOTBVaFluckowN2ZHR21DcldUSXZBb1BMcVJLc28w?=
 =?utf-8?B?Mi9sZzBxS0NzSXcwYkdJVzQzVFUwK3BnQ2QwemlTcjVWbElFYUZJMmtXcjJD?=
 =?utf-8?B?YUVZc2dCOUhXSEhWY0F4OS8ycVJHdzcwV2NqRjRQS2dqQ3lHanRSdDVuTmxz?=
 =?utf-8?B?L09HcnBtY3ZyQnVHazdaQVZ5RVZGdTA1OVZvZlFydU01K2JmdGJEa1NBSitH?=
 =?utf-8?B?UUJOR3JyVmo5UTFPRDczTXlZUVVWZWdlT29NSVlLUUc2MDdBTlNJcWQ1bTdO?=
 =?utf-8?B?L3pzeFpnank5Ny9Lc1NLdE5YcXU1cHlhemsxN2pMT3k5RWIwcndFNEpZSDll?=
 =?utf-8?B?Q1VTV0xsOEtYM0ZFMWdXcDEvdGx1bmFnQjZTZmRaRDhrT3Jmd2pKVkR6RFFR?=
 =?utf-8?B?SE9mZjRhelplMDl2cjhLTEdrTnRmVDZ5ZkU2dEdHQ1NMOVFHczV1NXFMQUJo?=
 =?utf-8?B?NFd3V1IrQzVKY1M5QnR1VDJZT2NVVklJMDhSM2E5bXVIU1NWZkdmMzRXRVhr?=
 =?utf-8?B?VjltMDArZ3BtcGlJZXFUNU8wUFlPQWR1QzZjTXZETUx2VzdKNDRiblQ0d2w1?=
 =?utf-8?B?eU9oR0xNOWd0cmRZZUFzWUM5SnBkRGk3OGRnR2c2Z2lRdTE4TUpZZ0FRejRO?=
 =?utf-8?B?WUxnbmZmYmhuV2FrNmlIUTlOdndzcEdrSmIrREFmVVBMaG10eiszaExCSWNp?=
 =?utf-8?B?Y3AydDlTNDZYcENGNjNCZm0ydDhXWHJwUXI0bEFxYXF6K2o1L0ZoY3BDSmZs?=
 =?utf-8?B?R25idzVObjdWL2RkeW1BaTl1QzlhZ1FrNU4zNlhDZ0d4MUJrYnVnY1dEMmNX?=
 =?utf-8?B?bmZaR24xWEtncVlYakRBUGcyYzh6dUxycDRIRDVuTVV4cnFPbFFXYklIQ1c0?=
 =?utf-8?B?SWprNFZGMFQ1SndIZlNjSWxzam9paG9LUTYyeHM4NVFIVnhPYXVqYm5JbWJv?=
 =?utf-8?B?dkFScXV6M3JTK0IvcUhQay9wdC9UQnVycFRYVGtNMnNGWHZkWVQ1eWtCeVRy?=
 =?utf-8?B?eHpyR0ZrOWVtb1R5UnFsQzU1MGJJYk1yM3JUMFZ6bUdZMXlmOXY1cHRTVmky?=
 =?utf-8?B?L2NEV2hmeTFTdUtSblVmU0t0T3k1UnlFdzQ1RzVPbE9xK3k2SDVMcmQ3T1A2?=
 =?utf-8?B?Y0tPTDdOQXdheTFZQWdxTnRxU0puRENNeDVPTUpVbTZrNUdYcGhLRXZnOEJu?=
 =?utf-8?B?L0JKRFh4ZkxRWTBBS2FadVg4dFNFNWJ6OElKSjc5dWcraVBMdEQyNlF0RkV0?=
 =?utf-8?B?Ynd0T3Z3cUhDNktqSUNWSlZPNUVMdEtYUlpIbFB6TmxoTHpEaWd5c3kwL0Na?=
 =?utf-8?B?RE9pNFJsdzJqMSt6eWlRaDhGanQwQTFWVmdNc2JneWEwNi9mTHM5UlBCR0hk?=
 =?utf-8?B?OGIxMlRqNEl1SUhCT0VRaVhUNklBU0lzVnRnTkRwQS9ueUErZTlvNlk5VHNI?=
 =?utf-8?B?d0RHbUtyTjdLOXArMlFya3RYZzM5QmhOV0h6ZHk1OU5IZE1RbWdQMFB2ajli?=
 =?utf-8?B?RG81a1ZkOXBRaGNzR1ZSNGkybVZuK1dMSWh5emRMVFJyajQ4ci9SU2ZJQXBJ?=
 =?utf-8?B?SGRIY0JJMmJrekRqL3hoVUw2TXNXdU5va3YxUEUrOGc3M09LaUdnN1FQOHp0?=
 =?utf-8?B?N0ZMNlpMRmhweXVJWFBpZERScXVOYnNlVCttNjVJUWp3STV0OXEwWlIrTTF1?=
 =?utf-8?B?eTJOVkFydWZ4VjJnYzY1aFFqSjBkaGF6dmp1WmsvWnNiK3lYYVVzNEhDdXNt?=
 =?utf-8?B?d2s4OHlvN05EMmM0VkJYU016MFdaVW9TTVBxSy90cVMvNnFBQ21GSnFkMXF0?=
 =?utf-8?B?ZjNiRC9zdFpRblRMV1U5U2Nwb0wzMldaTkRUK25zWGUraWdHLzd4NHJsRlFQ?=
 =?utf-8?B?YlREMEhUVzJSSzU4VEt3RzYzVDUxQ1BXV3M2TWgxcjljL0UwbWJyYWIzbHNE?=
 =?utf-8?B?NkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 679d6669-4600-421c-9717-08dca2bd9b98
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 21:57:22.4272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eXSpmmj1JTwG4qJ4k5c91DwsE7nAWVjGGkug1HSLePzCnB2BRJ4fyET2d+Fm+8skSyQICcTRuI+/U8qddBzR6t/ZfX2U6mGoBDOnI/n+O1E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6725
X-OriginatorOrg: intel.com

Hi Babu,

On 7/3/24 2:48 PM, Babu Moger wrote:
> The cache allocation and memory bandwidth allocation feature properties
> are consolidated into cache and membw structures respectively. In

Let "In preparation ... " start a new paragraph.

Quoting Documentation/process/maintainer-tip.rst:
	It's also useful to structure the changelog into several paragraphs
	and not lump everything together into a single one. A good structure
	is to explain the context, the problem and the solution in separate
	paragraphs and this order.

> preparation for more monitoring properties that will clobber the existing
> resource struct more, re-organize the monitoring specific properties into
> separate structure.

"re-organize the monitoring specific properties into separate structure" ->
"re-organize the monitoring specific properties to also be in a separate structure."

> 
> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

...

> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index b0875b99e811..e43fc5bb5a3a 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -182,6 +182,16 @@ enum resctrl_scope {
>   	RESCTRL_L3_NODE,
>   };
>   
> +/**
> + * struct resctrl_mon - Monitoring related data
> + * @num_rmid:		Number of RMIDs available
> + * @evt_list:		List of monitoring events
> + */
> +struct resctrl_mon {
> +	int			num_rmid;
> +	struct list_head	evt_list;
> +};
> +
>   /**
>    * struct rdt_resource - attributes of a resctrl resource
>    * @rid:		The index of the resource
> @@ -207,11 +217,11 @@ struct rdt_resource {
>   	int			rid;
>   	bool			alloc_capable;
>   	bool			mon_capable;
> -	int			num_rmid;
>   	enum resctrl_scope	ctrl_scope;
>   	enum resctrl_scope	mon_scope;
>   	struct resctrl_cache	cache;
>   	struct resctrl_membw	membw;
> +	struct resctrl_mon	mon;
>   	struct list_head	ctrl_domains;
>   	struct list_head	mon_domains;
>   	char			*name;
> @@ -221,7 +231,6 @@ struct rdt_resource {
>   	int			(*parse_ctrlval)(struct rdt_parse_data *data,
>   						 struct resctrl_schema *s,
>   						 struct rdt_ctrl_domain *d);
> -	struct list_head	evt_list;
>   	unsigned long		fflags;
>   	bool			cdp_capable;
>   };

struct rdt_resource's kernel-doc still refers to the members
removed in this patch. Its kernel-doc also needs an update for the new
member added.

Reinette

