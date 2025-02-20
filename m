Return-Path: <linux-kernel+bounces-524521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96520A3E411
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 19:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C32F17E1ED
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 18:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28278214817;
	Thu, 20 Feb 2025 18:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jteCZHZH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B469214214;
	Thu, 20 Feb 2025 18:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740076610; cv=fail; b=I1q0+l2joLDY0BXbX4M2wPKNyuLjgtc0q31GaRHvlnS0LTtr/ChH52tKsGdqqp/qlr4eaxnCq7uNO4lKnOIDv+o7NaOvfPbdgUpTxXkXzm1SWHsTPJSrTZnGY4WDvq3bQg+Qf366DGeAzDE8tKV4dJDWEj++00fDTrijg9o2l2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740076610; c=relaxed/simple;
	bh=PU+bgaDiMhcFD4bWW3N2w52kb1wtlgvXe4UVbTJO8Js=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FpvLQyCnAX5IzhfuGnMFzc+z3u26borfyxe4RE3WIyd0fEFmep/fCj832WLoo0qjVUa5Sm7lhCWHlGZdKCEqVSyjeZGWzZ08//0bZK9vT+gJn3RuzOQvd4wZWy9mbiEGeWvxUEGSI7BY0bcXMiCUUdm9aEMMap/CTk2HJDjyHDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jteCZHZH; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740076608; x=1771612608;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PU+bgaDiMhcFD4bWW3N2w52kb1wtlgvXe4UVbTJO8Js=;
  b=jteCZHZHu2m3YG93d0URWH6bly+7Usi/7yI6ACIaQGTZnqdqvRtM/Gx6
   pf3dtLCO8gnw85ydggIUbwriZtTBmwSHfOvJE49ytU/pEEc2+W+bq5P7+
   af/oBhN4d4J0c0+OQdvqU+o5ggn4++n+qE0ouufgS3yoQ3KvnNO8Zdhn1
   i/IrzloKg0rxyhSBky7ILJyg06I+b/5zBwcZ4HQ1AaAmLjHTQX6EBy/gp
   XwVwJleAVTmqiuwKW/xWFfO7YmJteD4MZtrcAuwoWVtKQDakMTxa1qxyE
   jGmlzZVh9YGW5OfrPyqcP896uIokuHaTiI/Zbb+YxUKBZt4nq4Fe2jqNI
   Q==;
X-CSE-ConnectionGUID: 4aok3pSSQryYFSaftfgfIA==
X-CSE-MsgGUID: gDXiix4bSBG6P7xt9iZ17w==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="28473411"
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="28473411"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 10:36:47 -0800
X-CSE-ConnectionGUID: IjqWLOyNSgKysjghdeAwog==
X-CSE-MsgGUID: WwC9Rm+RSK61FFzncnmJ2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120363650"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Feb 2025 10:36:47 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 20 Feb 2025 10:36:46 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 20 Feb 2025 10:36:46 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Feb 2025 10:36:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NHt2AuQYMFGNBYLSRSRRoFpdIEYUykYKjhI1zExz9Lwop0/z7Sc9BpWV0a90Tg8ldF1+XNXQEa6s4Vz2RwTSKTmX2uLFUzM4MZfXjh/bATYDDi+e0sZZ5tCd/5s60/+6hKPA8nMzRZCRRaPdkuSIp7NgTRckaSWjevNfJnCBMcvV4EVB7Y2S2N+AdD/6QOa9Wcx+O/6AGagoGEdGUl130XLjeEv34o+5dEbwYgCBCmy16R47lQhoJ1N1sTEaH6IJCO1RkxsqbVc+hCduZiy4Jy0uvWIAtSNLT0dVgtiVBExEtZx+XhNycda6gPgodTAOurwjTonlydYHB7uxIxp+Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ubkx4U2hujSyHduyKLF6bIDmDSGtoCeTKTkxZiSdsmE=;
 b=wvrWkxgKnQ33ipvoo/XL03j+ai2lJI1J4AlP/Jfze2v2cc5Pn8+Z6j2kO6cedYsf/584G/74HgWJufhpNZ6kCCKXxmvlw2K7E7q8IHj7XOMYami53Icaq72GA60Z/Jp9c8W70XFSTPo/295X523ZD41HF2VK97u0UG/ayWgXBzC8pTI1ktmNlnfdOVeYf3fz975otsetYbzjT4erm4ST2L9A03Qdlc3hNo4SIbg1n/rb1EX6BAdnQmjxthA2xslBHuMf0wzlX5qmc5gB9IacOr91n8fyudAoptanAhzejRvcd3TkDqzvYDt4eG2w6tmhwWsms5xY6GiBZL0LU+9r+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH0PR11MB7633.namprd11.prod.outlook.com (2603:10b6:510:26c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 18:36:22 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8466.013; Thu, 20 Feb 2025
 18:36:22 +0000
Message-ID: <eb435a64-70d4-4821-908d-686243fec7a6@intel.com>
Date: Thu, 20 Feb 2025 10:36:18 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 00/23] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
To: Dave Martin <Dave.Martin@arm.com>
CC: Peter Newman <peternewman@google.com>, "Moger, Babu" <bmoger@amd.com>,
	Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<tony.luck@intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<paulmck@kernel.org>, <akpm@linux-foundation.org>, <thuth@redhat.com>,
	<rostedt@goodmis.org>, <xiongwei.song@windriver.com>,
	<pawan.kumar.gupta@linux.intel.com>, <daniel.sneddon@linux.intel.com>,
	<jpoimboe@kernel.org>, <perry.yuan@amd.com>, <sandipan.das@amd.com>,
	<kai.huang@intel.com>, <xiaoyao.li@intel.com>, <seanjc@google.com>,
	<xin3.li@intel.com>, <andrew.cooper3@citrix.com>, <ebiggers@google.com>,
	<mario.limonciello@amd.com>, <james.morse@arm.com>,
	<tan.shaopeng@fujitsu.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <maciej.wieczor-retman@intel.com>,
	<eranian@google.com>
References: <9e849476-7c4b-478b-bd2a-185024def3a3@intel.com>
 <Z64tw2NbJXbKpLrH@e133380.arm.com>
 <76b02daf-1b45-473e-9d75-5988a11c6887@intel.com>
 <8ef51f28-e01a-4a7d-ba86-059437edb60b@amd.com>
 <a07fca4c-c8fa-41a6-b126-59815b9a58f9@intel.com>
 <CALPaoCh7WpohzpXhSAbumjSZBv1_+1bXON7_V1pwG4bdEBr52Q@mail.gmail.com>
 <ccd9c5d7-0266-4054-879e-e084b6972ad5@intel.com>
 <CALPaoCj1TH+GN6+dFnt5xuN406u=tB-8mj+UuMRSm5KWPJW2wg@mail.gmail.com>
 <2b5a11e3-ee19-47ba-b47e-b7de2818f237@intel.com>
 <Z7dccLOTPzySYTXL@e133380.arm.com> <Z7dqXlOMsw7Kb8F2@e133380.arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <Z7dqXlOMsw7Kb8F2@e133380.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0009.namprd06.prod.outlook.com
 (2603:10b6:303:2a::14) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH0PR11MB7633:EE_
X-MS-Office365-Filtering-Correlation-Id: 9945b3ee-ae2b-411b-776c-08dd51dd7921
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YSszNWwva1hmK3R6K2E0WVhUdURlN01xYjdZdlM2SG5KMEVDR0E2K0ZGZHBq?=
 =?utf-8?B?ZWpvUWNvYmEwVlgxQ2lKMVhMdUpWeUdvWlU1blhiV0lHbWh0TXFtaHRMUmVZ?=
 =?utf-8?B?TzIyKzZHRVV2UldJQjIrb0tvTXpuK2pzd2Y2c0FaV2tqQ1RGZHhuaEFYRk9F?=
 =?utf-8?B?TXNYUzc0VEtxcXdMemV5MUpQR0RxeENSa1NXaDB2VGx3ZVIwU3pKUmJzR21p?=
 =?utf-8?B?eHdYa0o0NUZ2eTliYjhjV01pam1OMlFWc2tTclo3cTNwb0RDSDhKcURSMGtN?=
 =?utf-8?B?blZqUmJRbnR0UE1ReDBBQXNSQTRzd2g0dXpsUUpWeUxKcCtVaWw3QzVRMFc0?=
 =?utf-8?B?WG9zSmYwaXNWN1pObkdtTWVLSjVLWk9EdS9YcFoyQ3ZnRWVwV1RwNEUybXF0?=
 =?utf-8?B?dEVUQXN1UEZydXBMKzA5TytEdUdzQk9LdGx0UW1lQUJTSUgvUHErODNpNGsw?=
 =?utf-8?B?VC9LZEJmQVlTWTdWUmIzODVWWk1FYkFEai8rZ2tvZksrQ09FSVNISXM0K2Ja?=
 =?utf-8?B?bHFXY2dMRjNVV1ZSa256UWwxQlNJZlZGaE5RNHJ0RnI5bVc5OElPc0tjSW9y?=
 =?utf-8?B?R2FMY0xJRnYzSGVEM1pyMnlkaWlqbUcrYVoycUVuUUxCdXgxMWFoUERSSGtC?=
 =?utf-8?B?UTBOSnMvL2I4cXNPRXhhNmxQUkdJSGxwVk1NRTRCdWlZZDROeVVDZFQ5bFQ4?=
 =?utf-8?B?QllrQXROU2Z0b1p2Um5LOTZodFBKYjV3ODc0ejFsUVpSdE1nVmZoaG1mUFRY?=
 =?utf-8?B?eFBGTmJtN3B4akt1R1RIdWR4Y3BQN3VKbUF0OElXMUtEbURxeUM5RkJtdGJI?=
 =?utf-8?B?RDBENk45Mm1IYmU2bVpvdkhkdFFoSmp4QTdrblZveEoyV082d0x2UC9EWkFj?=
 =?utf-8?B?ck94T3h4NWlwWGtyVEtrdkVBNjNRK0M5YjMybWtxeXJiSklRaFBobVhHTUxX?=
 =?utf-8?B?eEs2c3pwWElkNzlHWE9TMDQ5Z0dyeVlGZEhrU3AwV0pjenhVb0FGY2Rybllk?=
 =?utf-8?B?Q3lYdW1kN3I1OVlUc25LUUZsajNzOFkxb05ZbGJyaEtuRlc3NjFTdkM0M3RU?=
 =?utf-8?B?N2orcmNFNFBmZEFxN0F3Smk0R2lJQ01iZTNXL2tQM0l4cnJ0Tk1jblBvY1Zo?=
 =?utf-8?B?bW1hcndTZEp2MXVINXF6NGlHK3ZqVG5BT3o0Tkp6U3oxcEpkT2ZmdUhLTGt1?=
 =?utf-8?B?UitvWWk4ZW9PK29rTTA0RSthc3VZRXlyOG8xNjJjNzlFdk1PdjVaSXFGUk5J?=
 =?utf-8?B?ZUMzNGsxRWZRYTVOREdoT2FDZEZZR1F5MjFBY2lockV6OEhQMTdPb2FOcmpk?=
 =?utf-8?B?VDJqSVlJc2paMVVmSTlKZ1czNjZnQVhxY0U2YkxVZVlGbEh5S2I2OTZiMWdI?=
 =?utf-8?B?OTNoYzZraVhDdUZyYi9rZGdzRWY2ZjZDL2dIZkt2Q1VFbkVRdENEQjEvd0RN?=
 =?utf-8?B?ejRFdTRwQTBxcSs3eUg5eGJKczFycWwzVkpSd3J1ZlN4OFc3WHlETzlVTGRw?=
 =?utf-8?B?Qy9kbFZJeFZMTVplaGdIWE5iOGxGakpFS3RvTHcxUmZWNVdyQ1hzUk9BZ3FI?=
 =?utf-8?B?VnVxUEtoMThmeTRRNWFCNnN6UHN2OGdsR1JFTTdkdzkxc2hvYUsyYWpiS0d4?=
 =?utf-8?B?NXhWRytEYjA4Q1dnTEFpZjM0RExQVjhKWGRKZERKQXJqc2UvRkc4RVJ3Y0w0?=
 =?utf-8?B?SkxCa2tqdWFxVHlaeFlDUGROdzF4Wld1VC9VTUoxbVFxbEVBYm1tRm5sbzFa?=
 =?utf-8?B?MFNYcXhqMTV0QVgwcDFKcEZSdGMzZ3VLdGlubFpwOENJRWRoaklNTnI1TmpH?=
 =?utf-8?B?dnhiaUN3VFFKenhEZTlPakpEbmtWYXIwQU5zeEsxSXlsWmFxbnJESkJvSTMr?=
 =?utf-8?Q?Z88huIH0X5ism?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFM0dU5XT2d1ZFI0SkpRaFZMQTA5NjNGcVFvYnFTZU0rNVQyK3dyRzNOVzhD?=
 =?utf-8?B?MHc1UG85UTl6RlcranRNTEE2Y09OaE9UdENORU9qNlhPQlJzRWRSamJ4QjIx?=
 =?utf-8?B?NGZHQlROUnpqcW1CbkM3ejljK2JLVjFPbUJpa3Vkd0FXT005dzYwM1YzNXVy?=
 =?utf-8?B?R1pvOUdQdWlkWVJXd3FkSmNQZHdQOEFoblRkbjdpOFMwMWQ1ekpGYXlTYWlY?=
 =?utf-8?B?N2t0ZjJldHlocEJsZ0lBZGtRbXQ0bHJKVTcwNzdTWnIyMERmNnQ1L3dPbi80?=
 =?utf-8?B?SXoxTFlhWTNDQ3B0OTNLWjZQVWpkOGU0a0U5RjNtV25La3JudEs5bFdWdzJh?=
 =?utf-8?B?OFREOW1xdldQUU91cVpqRUE2SkhyeCtySWVOdkNsdFc1dGJYMWMrRW45S0FI?=
 =?utf-8?B?NTQzZWZoRlpDemhOZ2piU3hRbzdDZWoveHVZdERZNEs3SndEUFRMaFJKN0Fh?=
 =?utf-8?B?dEVCRnBnMkQ2YkNJcEcybVV2WXlESXd1dndqK0s2QVFFczZiZm1JeUtoRkhm?=
 =?utf-8?B?eWZWVG1pcVBUdnVoQ3BXUzA2ekZrbUdHZmZsdnEwNitrdkZJMVV2QjIxai92?=
 =?utf-8?B?dk5FY2NGelE2VW41ZWNXQU16MWhGODBzOHF6V0h5b0JMRWZmZVBLMHIzejVH?=
 =?utf-8?B?RURaL1oyRlFKVnVRTFZoMHpkL1BsYjJlaDFmWnE4d1hzcEJ3L29nUFFQd0lS?=
 =?utf-8?B?Sm9zbWRKZmtocjNYT3kxNmErYUp2V3hIRHFVRUtYbGU0TUg1MVhvT04wc3F5?=
 =?utf-8?B?bXArZXRmM3BQMFc3azgyNmt2Nm1lenZYZ0lXZlZJNitOTUJBWEx5Vis1VXQ0?=
 =?utf-8?B?TEEvbVhTMDFsWkY4RkFrUGFDVlNDNUx0eVVURjJWRGlzMFB6U0lZVDgyU2VB?=
 =?utf-8?B?SXAwMkw1MjhBa25LN2xvem5EbjZodGFGaDVrdDl0eUxzYUhqbDhhcmNhdGdB?=
 =?utf-8?B?andSQXQwUEhPQWIxRTBtODdETTJ1M0o0QllWeFNIMXpUMjI3WUlnanVMaFhG?=
 =?utf-8?B?S0t5elFUWXFkTzdnSFhLbkpiRXlqSldWcTVIWFNMQjRWYkpnVUxxeStwemNW?=
 =?utf-8?B?OU5lTXZkbHdBS20zSllCaGg1WXhVQzVRU3pqNWhhVmttZzVCdklqSy9DeTZC?=
 =?utf-8?B?MUt1NnZYdGVVK3VLd2wzbnhtL3JkMDlTVzNzUmxsWndtWDRrbThhWGt6aXRm?=
 =?utf-8?B?Uy9pT2g1M1dBd05hMlF6bFpUcG9oY3VLVVlVVWpKTHNmcXVIcURONkdhTC9x?=
 =?utf-8?B?RlJlbzVvbFRhNFVQR0lWZDJaYU96TGw4czQrWGVxQ0RpYmgxdjFkTm1ZYVN6?=
 =?utf-8?B?S1BmRFVmNW5ncFQvRFJzWHNndWlsU0ZIZk1QQk9RcVpQcEZNS1dVMHhTRlN3?=
 =?utf-8?B?QlpzT3JLaTBJNDh5SS9DV1hEaURBa3J6Zk82bEp2NGNnQ1VYNWN1OGo3ekUr?=
 =?utf-8?B?MlFnU1NNSmlVdnkwdlFhellZb3hJVWZjYkZuSUp4M25BLzk5bGJxUTJmTzhs?=
 =?utf-8?B?N3VQaWV2YTBaRFkwTnhyb1h0dFh0YlJuUUNwdjd2bWE0RnpSemJmbzhHeTYw?=
 =?utf-8?B?TEJMbmNDS1JrbldEK1U4NmNObGNxdEhvaVh4Wm9vYkJlSlVlZVp1ZU84cXQz?=
 =?utf-8?B?dEFBTDJGT29WNmxKT1NpQ1ZTMFFTZ05GNFRsTEs1TlVnNng4MUlUelI2Vk1K?=
 =?utf-8?B?ZXRSR0hBekl3QnJia2pDVUowT1dmcVd3aEhENjYvUExTVm5lajF4S1Zsamhq?=
 =?utf-8?B?S1NaQ0hSRVdkbFRUZGlBSS9BalRWOUNxeFdFRFZkaVI5aFlxVzNGYVFYVXov?=
 =?utf-8?B?MzBwcDZKdVB0dFRlT3k2ZEFNL201aVd1bk11QUtQL05xZWlsSzZ3a25tOFdM?=
 =?utf-8?B?L2t5N1NhT0tqUXgwVVVrL2JpN3UzNVBnUS8rZGg2aWJhU0RITTNEL3p0MnBv?=
 =?utf-8?B?TzlxUzduazFBVFBTWWxPL0ZjUi92Zm02ekdWUG1mSDJIVmhRYUw3R3NMeHk0?=
 =?utf-8?B?dS90RDFtYzA2WFZLWXlsZVJGY1c1OGdsLzNKZjljMXNqcWNKSTkxKzh1cHlr?=
 =?utf-8?B?M2E4VG1abG9uVUVEMDlzcVA5T3FtS2UvMExFZ205T0pobmxDaWI5RHpuME14?=
 =?utf-8?B?OC9MdVhCVVVGZnJ3cGhZL0FmVXpRWEl1VVFHTFhYL1lFcElkQlpuTm11aE5U?=
 =?utf-8?B?RHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9945b3ee-ae2b-411b-776c-08dd51dd7921
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 18:36:22.0528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v40G20PI6X6xmZ4GsXSZCd0R2GmSrNGWuxLiWooW9bNEaqcKOv3JK0peYVW/yAjBcQaIMfSC+IXWSU/yZVYyh/HejIadneOHkmD6k6GT2As=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7633
X-OriginatorOrg: intel.com

Hi Dave,

On 2/20/25 9:46 AM, Dave Martin wrote:
> Hi again,
> 
> On Thu, Feb 20, 2025 at 04:46:40PM +0000, Dave Martin wrote:
>> Hi,
>>
>> On Wed, Feb 19, 2025 at 09:56:29AM -0800, Reinette Chatre wrote:
>>> Hi Peter,
>>>
>>> On 2/19/25 3:28 AM, Peter Newman wrote:
>>
>> [...]
>>
>>>> In the letters as events model, choosing the events assigned to a
>>>> group wouldn't be enough information, since we would want to control
>>>> which events should share a counter and which should be counted by
>>>> separate counters. I think the amount of information that would need
>>>> to be encoded into mbm_assign_control to represent the level of
>>>> configurability supported by hardware would quickly get out of hand.
>>>>
>>>> Maybe as an example, one counter for all reads, one counter for all
>>>> writes in ABMC would look like...
>>>>
>>>> (L3_QOS_ABMC_CFG.BwType field names below)
>>>>
>>>> (per domain)
>>>> group 0:
>>>>  counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>  counter 1: VictimBW,LclNTWr,RmtNTWr
>>>> group 1:
>>>>  counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>  counter 3: VictimBW,LclNTWr,RmtNTWr
>>>> ...
>>>>
>>>
>>> I think this may also be what Dave was heading towards in [2] but in that
>>> example and above the counter configuration appears to be global. You do mention
>>> "configurability supported by hardware" so I wonder if per-domain counter
>>> configuration is a requirement?
>>>
>>> Until now I viewed counter configuration separate from counter assignment,
>>> similar to how AMD's counters can be configured via mbm_total_bytes_config and
>>> mbm_local_bytes_config before they are assigned. That is still per-domain
>>> counter configuration though, not per-counter.
>>
>> I hadn't tried to work the design through in any detail: it wasn't
>> intended as a suggestion for something we should definitely do right
>> now; rather, it was just an incomplete sketch of one possible future
>> evolution of the interface.
>>
>> Either way these feel like future concerns, if the first iteration of
>> ABMC is just to provide the basics so that ABMC hardware can implement
>> resctrl without userspace seeing counters randomly stopping and
>> resetting...
>>
>> Peter, can you give a view on whether the ABMC as proposed in this series
>> is a useful stepping-stone?  Or are there things that you need that you
>> feel could not be added as a later extension without ABI breakage?
>>
>> [...]
>>
>>>> I believe that shared assignments will take care of all the
>>>> high-frequency and performance-intensive batch configuration updates I
>>>> was originally concerned about, so I no longer see much benefit in
>>>> finding ways to textually encode all this information in a single file
> jjjk> > > when it would be more manageable to distribute it around the
>>>> filesystem hierarchy.
>>>
>>> This is significant. The motivation for the single file was to support
>>> the "high-frequency and performance-intensive" usage. Would "shared assignments"
>>> not also depend on the same files that, if distributed, will require many
>>> filesystem operations? 
>>> Having the files distributed will be significantly simpler while also
>>> avoiding the file size issue that Dave Martin exposed. 
>>>
>>> Reinette
>>
>> I still haven't fully understood the "shared assignments" proposal;
>> I need to go back and look at it.
> 
> Having taken a quick look at that now, this all seems to duplicate
> perf's design journey (again).
> 
> "rate" events make some sense.  The perf equivalent is to keep an
> accumulated count of the amount of time a counter has been assigned to
> an event, and another accumulated count of the events counted by the
> counter during assignment.  Only userspace knows what it wants to do
> with this information: perf exposes the raw accumulated counts.
> 
> Perf events can be also pinned so that they are prioritised for
> assignment to counters; that sounds a lot like the regular, non-shared
> resctrl counters.
> 
> 
> Playing devil's advocate:
> 
> It does feel like we are doomed to reinvent perf if we go too far down
> this road...
> 
>> If we split the file, it will be more closely aligned with the design
>> of the rest of the resctrlfs interface.
>>
>> OTOH, the current interface seems workable and I think the file size
>> issue can be addressed without major re-engineering.
>>
>> So, from my side, I would not consider the current interface design
>> a blocker.
> 
> ...so, drawing a hard line around the use cases that we intend to
> address with this interface and avoiding feature creep seems desirable.

This is exactly what I am trying to do ... to understand what use cases
the interface is expected to support.

You have mentioned a couple of times now that this interface is sufficient but
at the same time you hinted at some features from MPAM that I do not see
possible to accommodate with this interface.
 
> resctrlfs is already in the wild, so providing reasonable baseline
> compatiblity with that interface for ABMC hardware is a sensible goal.
> The current series does that.
> 
> But I wonder how much additional functionality we should really be
> adding via the mbm_assign_control interface, once this series is
> settled.

Are you speculating that MPAM counters may not make use of this interface?

Reinette


