Return-Path: <linux-kernel+bounces-524871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6F7A3E83B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 00:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D3DA188D664
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 23:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D0C266EFE;
	Thu, 20 Feb 2025 23:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ELGdA+ox"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226A7266192
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 23:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740093558; cv=fail; b=Panwn/efVdAn+FyIbktdYcP/w3nDX5ka7DuUxMu+yYvJW9YmWRoAfMFA+aZjtIpZFcA8ajzbDgPQ2JPSQGk+sY3iZZY4OvhuHK5Kef02KEposJm8uYhPkJynKsB0tnxNk8m5PSgdUCrKfTEo8CZ1UulB3ymYhCwtKwQmAE7xA/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740093558; c=relaxed/simple;
	bh=umR0IStNdw08hbhnXHQ8/Fa3OXlFxNulFgveiZGugBs=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JG8Hn5q2xgiA2DI17rYZl8KjFJ33njF0Vv2FxXU5bZbmiJz3oswWBUkuc2SzoMSsXBNzgZeYDMGxN/Py0+NutTGLLApCFO+1D0ehc+JGuLFXAh1FrzVgrZuJjXLkBTKo/UydLrTw52VE4ZCXKvxXtFqDmTIO+T0+Tg7n4qTrJmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ELGdA+ox; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740093556; x=1771629556;
  h=message-id:date:subject:from:to:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=umR0IStNdw08hbhnXHQ8/Fa3OXlFxNulFgveiZGugBs=;
  b=ELGdA+oxwXgzRwWQSpgen4Y6QBN2qnbxKInVIsSfOM4hQroy6K/I6gfl
   VFAY0AE9Th055YWvnNQXi/K/EAA1EUhJNzaihRfObeD6djRHUd25SAr0T
   nfWHl6i+tephIMB0NqZbWQM6/GXgieDDPdguZv0gSwlGvNaQDjWrSPcDk
   MlCh/ACuXH8A0zVgSnNeIzUOApD4Y9afxUV1CBDHfTVihAIGpNlL4Zv30
   e0klBLQfsD9Emdga4LkRZguJVE1zx+MqPto+Sy6Sj+C/ZdnRygYRn7JN4
   EjsNKRZ8c4yf16/LO1AZ16xDUpZlKIjTR32Jv0NI5avrvPBs8856TAMph
   A==;
X-CSE-ConnectionGUID: 1AxjbgYxSv6TxUkD9G6gFQ==
X-CSE-MsgGUID: +2UeVof+RByyhS8FHJf73g==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="51888475"
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="51888475"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 15:19:14 -0800
X-CSE-ConnectionGUID: HjIpDOGjQcau9S5AC8zUHA==
X-CSE-MsgGUID: v+/IFwPyREiKixp9kMzF4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="115189745"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Feb 2025 15:19:14 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 20 Feb 2025 15:19:13 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 20 Feb 2025 15:19:13 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Feb 2025 15:19:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=INmHMddlrLAkdlGwL8ep+TnpJxBrsGxMht5i29wKP+lkLQgknG/l3dlGG4sxpsXDIYkViiaBrhBkHkRfJL6Gr5+CrGL0iaM2KW69uijLHQevx9/AggvLi7HIUsBs9HstBWCR2cpz3ep5aph0LM2KdX3Jdd/cNmVi+84oM04VadMrdxftxN1a3g19RIsLnSVFbyoduO3Hgn9HdWXKnLkEEDvoMhnVRDgeNofRAq3w1TOPmMkusjJjRzY5tjBD+yg/pR7kPdWgyZQIo/w9FgCYuZ6/MxB8JeQ7lEyeIRBhikbluum8rNxBq3oz59vlISEGmTgrIWbcV7QnOTA46zyOsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fh1irsb1CGDxE9DQvaNl09cWZ755ZLO3S5s61PH/LqI=;
 b=v6iAk5ABj7h8AoT1UsRnn5ExI0n47J1c+UWz7y40umAQx2cz2pk0L5wii1q7Ag9BPCHaTLq3VBV82wlIVVUJ2zKIWWpCUosdsCw5u950CHHsPlhhVKsy7wIOXgI+q0bu2YfXlsZDOiv+xDph4G94lo1YyJYksMYZneJzuBr1a8wdqgazHgG1ZkXVhZBJQUFy3pJfG3ByJ8Anyefvps/R95I++O/iDiq4udr6fNaGZLtPmpEnpHRl2NVjRQSuSAwysHC74/whIlUQ2+DxYBopZG07anMz4GShbfMMusA1Mb5WmrOXWIs2cIEym573GWnV7beP1OmRkEqcNiafI+IZZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CH3PR11MB8185.namprd11.prod.outlook.com (2603:10b6:610:159::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 23:19:09 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8466.013; Thu, 20 Feb 2025
 23:19:09 +0000
Message-ID: <464cd44d-b443-4e00-a72a-e78e1bed437e@intel.com>
Date: Thu, 20 Feb 2025 15:19:07 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Change maintainer for RDT
From: Reinette Chatre <reinette.chatre@intel.com>
To: Tony Luck <tony.luck@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, H Peter Anvin <hpa@zytor.com>, x86
	<x86@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
References: <20250131190731.3981085-1-fenghua.yu@intel.com>
 <a6286d1a-33c1-4d36-a93d-94afbaf9cbfe@intel.com>
Content-Language: en-US
In-Reply-To: <a6286d1a-33c1-4d36-a93d-94afbaf9cbfe@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0320.namprd04.prod.outlook.com
 (2603:10b6:303:82::25) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CH3PR11MB8185:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a634592-cb1b-4ef3-3f1e-08dd5204fa70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RVJjZi94M1hpd05GR1lZT2FQeEpGTjRWUWpPR3hOcmN2cUJIclVzQkttVTlN?=
 =?utf-8?B?dktIRnhRZnBpN0VMaTZFclVFWTE1b2NaWFhXREZlcFMyWTBRc2U4b2xDLzVp?=
 =?utf-8?B?cmpyd013VmVpdDVaQnZQeHMyL2NvUkFHbXRDNDMvdXNBSmdJcE4wcko3dWZo?=
 =?utf-8?B?VG8wVXhNdDh4L1BuL3oxSFQ5YmhMUzdqNW5nYlc3VUJZRE02ZWRkQk04MSsr?=
 =?utf-8?B?WVRiOXpEOWtPY01DdERRS29XN0I3RVFUeG1YZlV6T2JRQkczb3crMzMwTCtB?=
 =?utf-8?B?blVuMWV4Mk5ZWDYyZUFod2lLVnhKV1lZRlNrSHVpN1kwV24yeEIzcVhxdnRN?=
 =?utf-8?B?N1ZwUVNpc3ZuZ1lvMGxYeU5aM0JXNStlQjdRdVNVV3F5MHFqbWt1NXVIVlk0?=
 =?utf-8?B?RTZuVXo4RjhYcFFWdXJXWHNyV1E1WmhZOGxjZTZtWXVFU3Bycnl0WHJUeXFF?=
 =?utf-8?B?ZlB6S3lvNE8xN2V3YWJYRlB0WGc2NU16L1htQWtJRUxxU2E3TGplK3hobDVj?=
 =?utf-8?B?VjcvR3I2QlpwVDJ1U3dmVm9sc01aRnlDT3YvNHp1VWFNUGNESEFoOVc1Y1N0?=
 =?utf-8?B?dkt1Q3JEUUNiN3NON3RxYkRQUDhDcmxWWlZLUG9sWHNsdWFsWHJXWWdTeHl6?=
 =?utf-8?B?bzlvcDVzbEVMcXpTcUpiRG9UN2hRL2l5cDBNYXRUTzZET3oxVGJ4RWcxL20w?=
 =?utf-8?B?dGtzd0lkODBrL0tMNFJvYXFScWx3ekYxaWM3NTJXN0E2Y3FkeDFpdk9DbHpp?=
 =?utf-8?B?bjQwZUZESUhwenpYQ0J1UXc1eDFtR05BR2lrYjlqMGc3ak00SEp1YmZHdElU?=
 =?utf-8?B?V1BTNXlNc3AzdWxZTGRydGsxeDdHTVBtMGNsYVZJQ25pampMdFFYQk5CMWNW?=
 =?utf-8?B?WTJ3cXorcW5EblprZGhKcUJLdFQ4QlFLVkM0WXIzZTJGRDh5T1pUMXJMZWdT?=
 =?utf-8?B?MEZYUVlHSEhwcldFbGdXVjE3Ty9kWlNuNkhFYitjY2doMDZDejY4VTNkUDk0?=
 =?utf-8?B?aWRFT2FnMEVjZmxZdnRuZk9BbEpMZHR4YlNzYkQ0THV1VUwrWkEvd2pray9Z?=
 =?utf-8?B?K1laK2lDelN3Z2FlT2lEVXhwL0FnQkpqeXJVZ1Vyb1BvUjBsZFRpSHh6VlNZ?=
 =?utf-8?B?Vkp0VnY5dkIxaUlVMC9WZmhmdXJLMVIzWnJzSUtKamw5bjRYNUFySHFVa1d6?=
 =?utf-8?B?MGdvYjcxcVdqQy9HOUh6YUsyclF0K1ZVSWw2eHdiWlJtWFVCWFVCNEVDQ3dQ?=
 =?utf-8?B?UWxSeitQaTczanlWa0R5U29jWnFQL0IwOXBkMXlBczZ4Wm5hUkpPVWFYMHg5?=
 =?utf-8?B?RHpUQjQ2Q3RGaDdKL3cyZlljYW43RUlTMWc3d29VYlVvRS9obEkrSGpNU2E5?=
 =?utf-8?B?QW5hVm1sTzAxNjA5WlVMSVpsODBlcEZhMTF6c2FMM3plNHdIT2l3emFEMC9h?=
 =?utf-8?B?b2wwRHpIT1FWQW9VcndyV1FEZ2VGNUpBc3Y2akdCdjB3S2xJZFNHa0M1T2FK?=
 =?utf-8?B?K1pMS3kxRUtvazhHNjlLRWlJeGxBLzMrQkZ2ZU1CS2RwS202TC9DZ1NUNE5X?=
 =?utf-8?B?M3BObm5DL2hpbjNJeWg4MmNyNjhpL1c5eDAxbWRrOUNNcWF0dkdOQ2VCVHQ1?=
 =?utf-8?B?RzlBZCtUTTE2WVhlMDlUcGlid0xvaEt3d3VFRkhZQ2RVSFZGNGJXak1CdkV6?=
 =?utf-8?B?RXRKaTE2OGl5MTlRWmhjcHN3QWtaaGU3RnVwUXMwSnBuc2JWSWx2clJnWmxL?=
 =?utf-8?B?ZTBPYlp3V0tUZjY1WU9iQkU3eTErVXB1UFp1dnF4eXBqS3had0hvcW9oUExj?=
 =?utf-8?B?d09sUGxjMzAxd04xaURDSjJwenFhb2t1MGNkYkw0U0dXMTJQUEg1czBmVjI4?=
 =?utf-8?Q?a6hPMWoA+5DhV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEx4VDhJSlY2TDliQy9HcHZITVRrQTRxUFVGbllDcWN5S1JpRDk5cXkzQmJo?=
 =?utf-8?B?bFFpSXBFOWl6VnorZU1QblJPS3BUbWVpYkxqclpVYzVIRGxTeXZkVHlvcTQ3?=
 =?utf-8?B?WlAvK2EvcndDT1c4RkI1TGxiYVdmM0E4VjVPRCtZRVQ4UlA1bVJGK2NPMS9G?=
 =?utf-8?B?VVByZU1ZMmhrM0IxaWhGRmxuWU0wUUVNMGRBc3V0VEw2a0FqVjhKZUpBbUFW?=
 =?utf-8?B?NG5LdldscGlMclRkQ2pUTWlDWC9oV1Q1enFWRXlheThTcEx2QXc2dERDbkhw?=
 =?utf-8?B?ZjAvNEk0RlM1RDBuVlZPL01JVzZLUDd4a1RUS1pBdHAzWVJocTZHNUpEVjMw?=
 =?utf-8?B?RTBXeityL0VLbmtFKytPNkFBN1NrYmVQcndaL3lldWRySW9SOTZ1bnpUMmRX?=
 =?utf-8?B?RE90Uk1UZmpPMll0ZzIvaG5teHVqV3FZNXhDVmdMS0xVZW4yMmx0bURud1ZB?=
 =?utf-8?B?Q2ZZTHBPYmFQK2M0UDNJNVFKdDZ0bTUxeG1vQmZtUVpsTFlJY2szRm0zR21i?=
 =?utf-8?B?ZjRLZUVpWi9ORXZQK0dqaWMvNFRNK1I5d0w2c1BhSm9CUHNuUE1oZjdCQTF2?=
 =?utf-8?B?QlNGUGNYMUxrU0RNMG04Z1pxMUthUnFKT3RrOU44bXJoSkdZaTBpeHZ6dTNk?=
 =?utf-8?B?TFZHalZsdFNWazNzc2tzTC9xQmFQQ2ZybDY1czBnWitqbnFXdWhEL0tPL1d1?=
 =?utf-8?B?NTVUb0d0cStsL2UzdlRSa1g0WU9ENytsdU5RS1VwR0U0a1BBV1pYSXo3WEdI?=
 =?utf-8?B?dFZzMFo0NVFsU3ZOeENGcFpIakt1ZGJHWUV0TVE4TUw0WWUrdC9TNlByMC9J?=
 =?utf-8?B?Z3ZFWTMwRzVSNGlqeGIzajhEM1lvVE1uVlhIL2FFamgya2NicHNyMUUzSkJP?=
 =?utf-8?B?ME13Z21jVWNNSCs5WU0vanQ4cTJzYkxDK0hlb1lIOExQRUFYNU1uamc3eUVM?=
 =?utf-8?B?dWg3OWNUNEwxaCtFRHhIazhDRnB6N1JSaEdBa2p6VitkK2hzUUZ4SzlCZC9G?=
 =?utf-8?B?djV1bTY2Snhta3J5eWRYMThjdXp6amNYUW1jaHo0bHlCbHZuTDBkc0JicW9J?=
 =?utf-8?B?c1FyZ0h5SFNTRDcyZWpjSlpOMEZWUGc0bGRmczAyWHpOcUxBd1F2T016Rm5B?=
 =?utf-8?B?ZnF5SkNFWERRenNmWVJkQlh6M1l1MHRQTlNoc3Q5bkxxcXhqQU1IVlRTVzMv?=
 =?utf-8?B?OG8rNmxIN2M1NTlRT1dWUTJvYjJUZTJURkprdHJtankwakU0VjJXalMvUHU5?=
 =?utf-8?B?NHk4RlE5aE8zTEd1YjRNWHViQkJPZjllQ2dYRGdGRmJ4T1RmSkdweWljVml0?=
 =?utf-8?B?Z081dVpkM3BSdjNXKzJ1RHUwVUlURXlUVXE0VUQ5QXFuQzFWVjRyZHZoeW56?=
 =?utf-8?B?c29Xc1l0TTJTYVVlQ3M0NEpNeVgwRFlKd2F3dGUwaHQ1ZnkrWmhXK3luVWNx?=
 =?utf-8?B?d1hOdVFOL3BuTkx3ajhSRDM3NzRmeWFTMERDMDhnN2VHbno4RDErRGg2WVh1?=
 =?utf-8?B?NEtWVEhLaGVoMndRdVlQVmRqR2dYaWtDTnp3MTdqSFVsbms4UmxBdVVtZklr?=
 =?utf-8?B?d0F0V0NFTDZvcDBCQzJMd2dpR2FmV0V3NVdkbkdoZ2tZQUZYUUNHV1FyK2pI?=
 =?utf-8?B?MnFnd3Y4T0ZBdVduQ2VZaXdwQXBnVU5VZGhxRnFLU1dKNnNHMzBrdG9HY1p4?=
 =?utf-8?B?QXBNTHBRMTZJZm80ZjRBUndBcUpNcm5hQ2ZmMTEvK3JJamt3dVRIS1E5T1JZ?=
 =?utf-8?B?WkkvZmhRWVNjZmZVbTBYaVhqWmZadDVNYVU0U3o0UnJaMUlwZ0VnY295MHlI?=
 =?utf-8?B?ZFZ3Z3Q4a2ZFNlJHNW9uak5pWDFsSzN5ZUxCUXZkTjFnZjhMTEVTUEtJaWlo?=
 =?utf-8?B?Y0VIZW03Wi83elJReHZmandaZ29UcmZlbVdqeTlNSHF0SWx0WmRPTVRSUEZU?=
 =?utf-8?B?cHJpN01FbUFkWXpURURWaVZhUUk0RFFlSThmeUZ2RnRPNGp5dTBJVG03R0NE?=
 =?utf-8?B?bTNlNDlRR2pmdjNjaVNJbXhWRXpxOEUzeG9hQ0JqbXVySGVTbFEzWlVEemY4?=
 =?utf-8?B?SERmUE1pQUZKWjErcTlZNk9qMnd0NDg5V2ZmQXlPbW5CcDgzempNOE1uWDVV?=
 =?utf-8?B?Z2lYdTJTRGczd01uSWtrZW91VFJ2T0ZNb0l0M3lXMk5ZL0JYRnZROG5mN2tS?=
 =?utf-8?B?V1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a634592-cb1b-4ef3-3f1e-08dd5204fa70
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 23:19:09.3450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nC+Ob8PyvUVZ5Ckx8b+zw/zuRtZbCSFoidhYo2supxAcPKrAEb5dXxZPtLzq1WqbbWfCrym3mUtAXeC9jNHckVMcMgFM5g4qut5oIX8fCGU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8185
X-OriginatorOrg: intel.com

(drop failing Fenghua email address)

Hi Boris,

On 1/31/25 1:28 PM, Reinette Chatre wrote:
> 
> 
> On 1/31/25 11:07 AM, Fenghua Yu wrote:
>> Due to job transition, I am stepping down as RDT maintainer.
>> Add Tony as a co-maintainer.
>>
>> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
>> ---
>>  MAINTAINERS | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 08ce00b6c1f3..427779715756 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -19822,7 +19822,7 @@ F:	net/rds/
>>  F:	tools/testing/selftests/net/rds/
>>  
>>  RDT - RESOURCE ALLOCATION
>> -M:	Fenghua Yu <fenghua.yu@intel.com>
>> +M:	Tony Luck <tony.luck@intel.com>
>>  M:	Reinette Chatre <reinette.chatre@intel.com>
>>  L:	linux-kernel@vger.kernel.org
>>  S:	Supported
> 
> Acked-by: Reinette Chatre <reinette.chatre@intel.com>
> 

Could you please consider this patch for inclusion? Fenghua's
email address in MAINTAINERS file does not work anymore.

Thank you.

Reinette



