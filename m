Return-Path: <linux-kernel+bounces-411549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CD39CFBCD
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 01:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7002B24713
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 00:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6AF610C;
	Sat, 16 Nov 2024 00:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i/EHfc0z"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B85621;
	Sat, 16 Nov 2024 00:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731717876; cv=fail; b=Jmj86qf+CLUGdK+oye1N4CnSt5I3s0AG9jbKI9waPDfhv0GMvgKnuppkcboVfna8xgtKQ4+tWAoYOmWW1Yrlo8VdAmnVS4rah2MAQl5RTB1Z0l40gtC0FYbKzq5+vkbYhXX/Zu04mN4RuBST8vDiig79uJqSw8R8lzXziysc0cQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731717876; c=relaxed/simple;
	bh=nC15bfJbFDmftLDUoHxv7JiFWR8I6UKYnY/k1IcZRx4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nktzXi2QedLc73k3jUoTArUCYMoUJr2s3QnYK6ySz2g+7Uc0cU1M/xGcozIazh9qC5iORa834DbfPXC/PTphhik7hZ72x393gwx0qrOfJZvjoCt3+iXBcF0lpTHRfX9otSI58PiF1uGXa9WogwCaSkW9BNH8sasvbFf0iRr3LmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i/EHfc0z; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731717874; x=1763253874;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nC15bfJbFDmftLDUoHxv7JiFWR8I6UKYnY/k1IcZRx4=;
  b=i/EHfc0ze3TazUnuY7Wt0Ifczskmv5vCt2hCxTAT8x5PSpkPNHNehGDO
   59wz1Z4lNUIEl3b/r/rh8kJaetcbDlUcPKbPmCMRwIg+NgVZTXU6xwYHD
   p6WEArZdAoh+s2ozA8FWoZG20vhtcR5JR4zbaz4956kGaPidP1IrFoBin
   OvZbH8lvmiYlmxJccwJpMSm1fpcvNjnWwNhFsyWjf/BOUqAXp/+wcBToP
   BnXIzDdRyfv2zuq6ByJkp5e4y/QphRJ5EKIcE9kgFKALjvkDEkT9ec/TQ
   g5BWZilQgf/bl7nX/cGDqSWsi/Z7JHU3yjPEvtvIMig4TROhH51RUr/Qu
   A==;
X-CSE-ConnectionGUID: s4TQvyoXSl2ruFWfB7SD3g==
X-CSE-MsgGUID: zOIUlV5fS2WbIZGGS258wg==
X-IronPort-AV: E=McAfee;i="6700,10204,11257"; a="49173715"
X-IronPort-AV: E=Sophos;i="6.12,158,1728975600"; 
   d="scan'208";a="49173715"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2024 16:44:34 -0800
X-CSE-ConnectionGUID: PGMoSvw1RbOGRCmsNvhBVQ==
X-CSE-MsgGUID: 0yiyG93MSfKAJmJLqIJ1jA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="93724512"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Nov 2024 16:44:34 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 15 Nov 2024 16:44:33 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 15 Nov 2024 16:44:33 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.46) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 15 Nov 2024 16:44:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U3w+SSIZwFKYFFQC65vcabyae5c8JQG0YyhEBpd783/DBbg61h2MNovpXToxViYYlpV7OM6VMuPNK/B/ot6GX18rmnTC568ugcZZrOstfakBtwXrGYFauyTIylldkd4cgbCIuIRZCY5E8K+ilfF2uaeJ9RiDbOTpHx7kpllvJfzfWHCyMBEQGNfHKtgoMKlkoyJAC3aD439aV185WkbLqHYsDtXtKLLWrq8kI2zqqqWIXEzoOVl2GCXtqnlFindw3saThM8cqftLjPsbG0Q7Xcw+P0xtpzR62rAzPlWTlz3MfPQIZW6T5yEvtjuPYtfeycjBwVFtIrfU3RXBZ1ZVQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7U4PDbPLeCt26bp1yaPiMDxC89A6hsEP1g1aPx97rWI=;
 b=V+/vEyTMnGfEbg8ljP9OmvelLfA4TBy/t/WUw/7AKc6QM3FZ+gy4gCc5bhwJDfmm+MxlKhilx7xp3/P/ZL5xD0O41i1bz187RPZ9Ee7rzuqR12ckP9srcLblKi+NFZD0ECAD2V+SnEo0jIDjB9kqjAXih9Zn4NATN3BtAeKZKpHXyYrua7eJLDk9EMvvMh7Dkew3KtZgq3qjCFNSR7O9ZGMVpXh9mMVXteFcGmo/Od8DmK+cx28gOhiZuTxDNREdha2AigqIefPzfp8as5ZDvYabPXVVoCNYl+tdWg3ZuTNq5VOv1AaHvGnmCKCISILKViBdLif7928P5t99jDgEBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SN7PR11MB7568.namprd11.prod.outlook.com (2603:10b6:806:34e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Sat, 16 Nov
 2024 00:44:24 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8158.019; Sat, 16 Nov 2024
 00:44:23 +0000
Message-ID: <5a7d8ff1-91c7-4e75-9730-3aa0703274a6@intel.com>
Date: Fri, 15 Nov 2024 16:44:20 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 17/26] x86/resctrl: Implement
 resctrl_arch_config_cntr() to assign a counter with ABMC
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
 <a3c2bdf2153882cc955b80b7d0fcdf7af3d09eb3.1730244116.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <a3c2bdf2153882cc955b80b7d0fcdf7af3d09eb3.1730244116.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0273.namprd04.prod.outlook.com
 (2603:10b6:303:89::8) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SN7PR11MB7568:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b452e89-6f41-43e1-d71a-08dd05d7d0dd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WmRVcVBEV2JiYmdhY1pLWGRQaktuOThRZ3lxb2liM2xWNEJqaGZKK3c1Snl2?=
 =?utf-8?B?cUVvYkdxYnFScVVMTm9kNWUxOWhXc3htdDFxck1CcHQ3dEsyYmFOZHRBVEdY?=
 =?utf-8?B?UTFZcVIvQzVQTGVZZU9aZCtTalBKWWRpREFBTEpSNVgrNkRpUk4vVURVOGpa?=
 =?utf-8?B?Zms2dnc3RURnYmE5MlVtUGwzVjFrQXhXdHhVMnU5eUhJdnJwQXVzeEQvaTJ0?=
 =?utf-8?B?U0FibHpBelg1T3BiRWV1b1FwNC8yaGdjNGpKL1hMNHpHRGo2WHkvNlFZWHpo?=
 =?utf-8?B?S2hucFFVWC9OcjZuODRBbGVka1VQbmNSS2RLMGdQL1BpTi9DZUFIUUhUcjBW?=
 =?utf-8?B?dlpGQzhzcFY5dE53N3Q1RXNOSGFzZ3lKMEFSRlBMK3NaYjhqWmkveDU3bktJ?=
 =?utf-8?B?c29OQnRmWnplTVFGa2VzaWRjSmtVZjBvQnpxL2M5aStLWUhpOUZkV214c2sx?=
 =?utf-8?B?emZwRmNsc1dQdW9FNUpMUHZoQ2o1eWd1ek85RWVDaWIvQkNEK0l0dG9lWXE2?=
 =?utf-8?B?NmhkanB3U3NSMWtmSWNMNzNqT3Noa2FaNGJVSFdiQ1RkSDBCQWRiSmVYMUFi?=
 =?utf-8?B?VER6WGt6Z2lDTDkzN1VYRlJNUTBFck80N0NNWU9aTFZsNk1qNkJmSHpFcnZW?=
 =?utf-8?B?YjRvb1FYOHdidVduNUFKenJDakVKdXNJczRZZEY0eFo1c3V4SGRNaUtjSU01?=
 =?utf-8?B?YVlMMUc4Y3BnM2R1TXBaSXZ2SENtQjFyTmZBRE5qUFZsbHFpWEE2QVVOVUtD?=
 =?utf-8?B?Mng1OC81cnRiUUtHcmVNMU5GSWdsYmNPT1lNVHlOUUNIbDhWOGxYZGsrb1RD?=
 =?utf-8?B?Ty9jaDQrVXE4WWMzdGFXbS85U1NZZTc1WGZLYXNMZnNkMWdqd2xPcEVaVVF0?=
 =?utf-8?B?Yml2TEZxcFBHMkF2eE9EYUxReTgzUDVEbC90UU44aHJjcUdQZUZIczhrM3hv?=
 =?utf-8?B?M3J4b3RqQ3Z5dC9IYWp5eUFyOGdXYTVEUHdHeVdFVDhQZStxWEpJak5lRlhG?=
 =?utf-8?B?ZFoxdXYwZ1htNHdYWEF6eDBzdWp5VkFYaFNOOWQrNnpKcTZCOWdGcFpOTXp1?=
 =?utf-8?B?eHNCYmpEUVZrKzQ5RmhQU3lYUkRzbFh2UHZMMVhGR3RkaFZYRmFPcDNzYnZy?=
 =?utf-8?B?V2t4azJNUzRzRXIvYWUxckx6Rm1COUhpTldPcG1jME1vK2QvZHZIbzMxNGE4?=
 =?utf-8?B?T0ZLZnBtVGdMOVRxNThPdG8vK1UwZ1ErekVnQ2ZXN1dxOFFLY3dqTWpyc0J4?=
 =?utf-8?B?dS9HL2t2ajBDVGwzVTdsK3dMMWVZUFA1NzUwRFZwbFlXNi9wVHJydXZVYndi?=
 =?utf-8?B?TWxrUzJJNkppNFo1WTdqUHNGN1NBZW9TMG9ieUxqSWVmMDZWcGdBaS91NmE5?=
 =?utf-8?B?OXVSREErZVBCbFdTbWkyYlRkSzRLNGJjYURVVWIzQUZHT0tvUy9pVDlwelIv?=
 =?utf-8?B?NDE0b1cwU2JQUGMxS0RCblplaC9GQ0ZNQUdrM2d4TkpLQTFRRFZSbFdVbFhI?=
 =?utf-8?B?MzVYcjcwSFdiM204cFU5K25XZmd4VTFBTUdyc3ZKRERpVThZTlJPN1VmS21M?=
 =?utf-8?B?aVhsbktlYzZBQUdSYXVWTDIyelJqVU9OazNVTzZDNU9oakJ0QlliZ3RveCtl?=
 =?utf-8?B?VDNEQk1yNEhFZUdTK0l2amkxWml6dFVSdVpaTXdLekRhVy85VmNSZllFNEdC?=
 =?utf-8?B?UzJ1YmU4Tm9RcEVDNzV4TTgzeGVMTXlqQXdkMWlYU1BsRXRoV3dGTy9vS2Nm?=
 =?utf-8?Q?QYsZwpH50MDJK3R1pywvR9SO7CsMHXcyJKXaAQi?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlNBQytJTkVQUEVKVVVjeWpyVVpoYXJHNVVMOHVtd0lZclh4K21kaHB4QVc3?=
 =?utf-8?B?OWZPdVA4L1dudHZ5YmJtUlZKY1NvRlVaTFNhU2xsSVR6MVlXMVJpNG9abnA4?=
 =?utf-8?B?MWRlSWdZL1Ixa0x0Tklib1VwV3VOVVN4NHdaQVV0NXNLc1lPRi9uTllSMVZP?=
 =?utf-8?B?SC9JcXhEY1U1NSt2ajM4Q3hYaFpDNDkxNkxoNGxMT2E4M3R3bDJ6eVRzZzZD?=
 =?utf-8?B?SkZ2amsyeWZKOWdpQVFLdFg5N3lidzFoVThhSkZHRUlSbTZZWFBFTjZ3MUpN?=
 =?utf-8?B?bk1qSUVVMHFyeURJOXdHaVVDdWtGN29yOVcyQ0t6Q1ZqcEhGL0JSbjRBa0Qz?=
 =?utf-8?B?WHpHK3d2RzB6dHRQWGN5b0dJTGRRV0UwS05wd1RvZ3hhNHZ6bE9SeFBNRk9t?=
 =?utf-8?B?NXE0V3N0K0toVWpaWnltYnFXQmEwK1VQbnJQQWhTNkdsdVZPS0c5ckc0aWdJ?=
 =?utf-8?B?QjdyQzN0aVRQSFcvTnVTb252QUx1djJrU3VpSjgvamY4elJodU80Y0JnZWlL?=
 =?utf-8?B?b1VZQjhPeENLcDlMYnVBRmN2Z2tuY0ZOeEZ0KzQ0ZnZUeTdzbW5INWhsY1l4?=
 =?utf-8?B?NDVwNkdHZnpwdnNBeUxkbUVFaHgyWWRrR2JCYldFZzFlUnFXazI5TFJac2Nn?=
 =?utf-8?B?eTFOTGY1ckF4Z0ZrempSUFR5N2VqMFFFdE5Rd1hBQTZId1JQSVpHU0paMTlk?=
 =?utf-8?B?ZjJGRnh6NmpOYUNEYXVKRG9LbTZUZFJuV3FkRXhXLzMwbXZUZnhQdnJrZVhC?=
 =?utf-8?B?ZVZyek90Y1BHZkVySE9wVnl2QzVNYjZCN1crVWN3T1M0ZjVMa21IZE9lbmtv?=
 =?utf-8?B?ZHJURE9rZ1pUYU92TGVhQlZmVDBidzlVMUxQMTVBaEh5N3NUSEZQT2E4ZW12?=
 =?utf-8?B?bkFaVDhFV3RHdFJYY25sbk5uQ0wvRkJDdG1VeGVmcHFNNzVwczZDZVpvVWJH?=
 =?utf-8?B?dkhkREVnMjViTmhoVEluVHdiL0tFS1doQjAxNTlnWjIwcndqckhycGZ5cHVy?=
 =?utf-8?B?QUNzMGx1aGJXdjdUZy9kVFlHc1lvWExlbzlidXF0UUNaMHZ2Qk0yZ01XZ3FL?=
 =?utf-8?B?QnFRWTAvNTkxcXNWU3JPcXlLbjlvdGVRcm9vT01hN3JoRVpad1ZuM3lOQmh4?=
 =?utf-8?B?VEJUemF0N2QrR2tRakVGNTJIRmJscHpLd1ZsNUtWTDJ4TE9FckhFMkhHVkc5?=
 =?utf-8?B?ZjRKQTgxTWZOdXpkdjhycHFIenBRWGgzM1ZkL0g2dUIrWERxdUNVb25iVlcv?=
 =?utf-8?B?SmJBaVAveU5WdTdzTEJlS05GTSthSnl4R0F5ZTdXYnNvTUJRdWowQ3h5Q0N6?=
 =?utf-8?B?RHFkVzNpSXZOdW1ST2pzdTNOR1FrSmhKdjhwVHVUOFdUaTFJUjlXWUVsOXhC?=
 =?utf-8?B?ZDRKaXNEZnRwQm14NGJBNWgyRk5WYlZyVnJrbk5ZZVRMTThkeUVTMGtsZmtJ?=
 =?utf-8?B?cFVzNnVjOElTZCtBNi80THFrMDY5cjM1TkRvaWM1QXd2KzdRVVZjOTFGVUkz?=
 =?utf-8?B?UXZQNXcwemR3Nk1BRFROY1FGYTdOYVFRMXlMZThsTms1YzFKWEtNSGRwQ0Rj?=
 =?utf-8?B?dFVoRnd6UjZycnRSeWJleHBzS0piNzVnWUxWQjhJaUN2MmttSjB1SGZzajg2?=
 =?utf-8?B?UDBIN3NxVFRVV21SWk9ZU2xmbEJHRVJITU02Z2pzYkM2NStVNkorK0kwSFFF?=
 =?utf-8?B?R2tpL0kxYzZrMEc0VEc1eWNmQStCc1RYbWVMcEVHVmdHcVBxRFU4eHZlcTlr?=
 =?utf-8?B?UUluNlFJbE51cGRvd3lkY3lwczVucHZUSzhhaTFzb2RtL2l5TkdpbkNLdElO?=
 =?utf-8?B?R212OVJBV05lK2tOeU1TQkR1MWxJRndMd093ZDUyTVNNU3pKbWlZYVViZ2RP?=
 =?utf-8?B?NWJvVGJxbUsxWVV2TUEzaDhJMGJlVW9GWHdnUyt5d1kxWGRsMmpjR2pDS0dr?=
 =?utf-8?B?Z1hubTNPQXFmZmYxY1NpN1hsNTIxUkp1Mks2bWtDWnNSdGNRWmR1REozOGky?=
 =?utf-8?B?RUZlbFJUbXBJZ2NVV1Zkd00wZXJkOEVVcnQwVmI0TEVEL0xnSVdBNFd4R1FF?=
 =?utf-8?B?ZVd0eVMwMVpOdnQrVXhoeUdhT2RCMUV6WkFIRmRxSGNNSFozdFptY1FuVFA0?=
 =?utf-8?B?bnFKNElaUWF0bW14cXNBdVhuYmdDOHhwRmJHMi9kWllEYkhuOHNUcGllWjRk?=
 =?utf-8?B?akE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b452e89-6f41-43e1-d71a-08dd05d7d0dd
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2024 00:44:23.8656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ddK4d1AAXDLbkU56dxpskQOR3XfYRNmiNc1gCXK+ryTPAcnwcDp+ZOrhUoknhhAWMjfUdFXHfQvJaRRwgR8MO9VkyLZczyVLC2XQwQ48vyI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7568
X-OriginatorOrg: intel.com

Hi Babu,

On 10/29/24 4:21 PM, Babu Moger wrote:
> The ABMC feature provides an option to the user to assign a hardware
> counter to an RMID, event pair and monitor the bandwidth as long as it is
> assigned. The assigned RMID will be tracked by the hardware until the user
> unassigns it manually.
> 
> Counters are configured by writing to L3_QOS_ABMC_CFG MSR and
> specifying the counter id, bandwidth source, and bandwidth types.

needs imperative tone

> 
> Provide the interface to assign the counter ids to RMID.
> 
> The feature details are documented in the APM listed below [1].
> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>     Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
>     Monitoring (ABMC).
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> Signed-off-by: Babu Moger <babu.moger@amd.com>

Reinette

