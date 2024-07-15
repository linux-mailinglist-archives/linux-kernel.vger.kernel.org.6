Return-Path: <linux-kernel+bounces-253025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A354C931B77
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 22:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F24D7B21DE4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 20:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2533413A41F;
	Mon, 15 Jul 2024 20:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="se1BUh/4"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C4033C5;
	Mon, 15 Jul 2024 20:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721073876; cv=fail; b=DYPg6pS0KFKspqJvWdMb5gobQscD2yYZNqJ7aRCEN3pWOyiaT8nfX4RxaJ6NbQ2my5Who6RYJlSXfLsxVyNZJef0K6GjJyFuoSFr2qKx0iezTiiymSPef0jkyRm1f/8EOrBmh4y8I+GUDvzSwLoshr1ckpKbmTW8+b9+CZdUmFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721073876; c=relaxed/simple;
	bh=Y7+ZyAkhcoMdrqljiwACQmQZeKBa+4pOAVC481ATJSc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UmQtQbH68ujWfEiZuFkXhEeJsePGztQtsq0WK2IQWUDXojPOP0YWjezkpV49Ijt9p3StDv0xOZEdS66n5y7t/xyCwcyDJvxwUt8H0G6ckSwl+qSJpQusdWX4yiLxlr8jXjEh80Tezg//jpEeTZ2CCIDRUDClhmecoI5pI0NQVTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=se1BUh/4; arc=fail smtp.client-ip=40.107.93.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D8y1BKdNFV5T5bMS8KY7yf0ZnckaQz8l9efrXhscqfBv+f1GihqFmT7+Xo1H4s1p32+E3vRcJGFQHyP6rY2o6v6OxmPyguLeM7uKKn2FlE9W71JPEIlYvD7nss3prU1eML+Fhg1uC/n2S4GQ1aM54lbo3V5XtB/izS3yjkyMAoQQcNruaB9Rqw/yClJFV5xeOP2MEDV2Xey19cwbQ2JTS06/EAzavMDj7Ks9TdLqHztMFHtmqKQ+qAMPRe8TVHn+rhR0wY6x9vdI/8eIyR7x5UO6OU3IAlN1pSMPzONZGiWI8xQXzl5IsgUuuFqG6PawzDNuLtwwo9ER8tUZEXO6nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=itu9WTkQNmw07+QUcfOcQjZP4CNuhfjBRftwcDgVdfU=;
 b=ypk7+kMMSPBl8oNfj5dZlasTZ7TURtQ7ee2OPzJ2GKcfmojQv5fDj6WpzRmVk36Rp8mf/2Rm1lcu1TGfIlL0pawaqA18yWppldpnIrbqfyyDuBwdyoty5E1BjPTDAzNhH/HfsAKySfXZincZcBibIpldergjlS3opEyCTUUzEdexXPfz8JfpuzeqsqkXiTXAZT644NpW8amjQsUY/Emwkqtp6Rr482PcEkum0v4SgCs9VbhctUh4atDDgRmgiIP2Piod5/YwmehGwNO5hrV826ikvzACgDcj6NtCIe88EDcGyHmvltV7iUNT1ZfrRH4XcxmX8G4Z4bBiPR+8Do6/Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=itu9WTkQNmw07+QUcfOcQjZP4CNuhfjBRftwcDgVdfU=;
 b=se1BUh/4/arXfzvt6PxwsVqVh/WjgQXWN+kPI59xCs5S0uPMuh++jk+KQt+XXbOByICq2quUWqN7fir2GttPJRc6G3EJYBica8rjq25KcKt9LPn2OJPLRP/A2HKAeb+aAO22HYfNGiQnQFZSwpYFkbcZ4nIozDV/L432HRiFBts=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM3PR12MB9433.namprd12.prod.outlook.com (2603:10b6:0:47::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 20:04:32 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 20:04:31 +0000
Message-ID: <e8a50a62-9974-4f1c-8ffc-0a1efa477824@amd.com>
Date: Mon, 15 Jul 2024 15:04:25 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v5 04/20] x86/resctrl: Detect Assignable Bandwidth
 Monitoring feature details
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, yanjiewtw@gmail.com,
 kim.phillips@amd.com, lukas.bulwahn@gmail.com, seanjc@google.com,
 jmattson@google.com, leitao@debian.org, jpoimboe@kernel.org,
 rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com,
 jithu.joseph@intel.com, kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com, james.morse@arm.com
References: <cover.1720043311.git.babu.moger@amd.com>
 <ea967681e5ed7a9c27771d60ef993616e7e1292e.1720043311.git.babu.moger@amd.com>
 <1d0af059-4768-48ce-87ba-7a9a213a3fca@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <1d0af059-4768-48ce-87ba-7a9a213a3fca@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR01CA0037.prod.exchangelabs.com (2603:10b6:a03:94::14)
 To MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DM3PR12MB9433:EE_
X-MS-Office365-Filtering-Correlation-Id: f0ce755b-68c4-48ba-0e60-08dca5095742
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VkI1by9wVmxBR01kRlZYN2xMWVVpUVBJbnd6cC9XZFU3OU5pRG9oVTArV0hr?=
 =?utf-8?B?MGtvdzIySWFuTFhUaG81b2VDMkxMM1VscWgrN1hnNGllL3cxQzdZckdKVUVT?=
 =?utf-8?B?TllHRVZIODRJTjdQYmVXbWJUOHBLZWlqT2FSS1dNOXRzSHNSSWwyZHAvQk9F?=
 =?utf-8?B?RHBHZ2Q5dVhNYkZoUFZLWk11YSt2bENXQTNYeVFpdzhSeEdMREdHdDhjdHRJ?=
 =?utf-8?B?eTNVTFhVQStuOTJqS21GbTREOG1UK3FqRWdwUTBKQ0MzSUpXdnE1V25wc1NS?=
 =?utf-8?B?NTd0dXB2T05wV3R0UFNQNVg4Z3BmQXJrVUhCT0pneENkMC9Fd1Z2cXBXSkgy?=
 =?utf-8?B?NExSY3VyYmxtRVN1M2Z3U2xyUUptQ2FvR2VoZU5Hdk9nNFh6Q3RHdFlvZkxS?=
 =?utf-8?B?M25XcUROY3VsYmk2RE1SVkYxY0tuTERlcjNNWmNWQkhZQmQ3a3dWUWgzYVB1?=
 =?utf-8?B?VVE4aVpBQ1VTRzVwZERETFY2ZjV4cnpJL2ZBaVk4MHZuTXZYcDBYSy9VTW56?=
 =?utf-8?B?QUJEU3FCeGJKa1FYU3ZPRXpvU1JNSytkb2hHZ3FjL25mSWRYWENFdWZoSVdz?=
 =?utf-8?B?VVQzNzZsdHl4YVBkOUk0eGJIVGl6V0Q4QzNHM05ZUytHa09PZzhGaUYvZ2VL?=
 =?utf-8?B?SU4vVE4xK1VhK2Nwa2xqc1RhT0ZhT3hMcEFLOXliazd3RHozTTU0eFo1Wlc2?=
 =?utf-8?B?b3RXWkViaERKc3FTMGlja0h3U0lHbUlEbVpiVWZVQWZNYmJSdFY1cWM4d1JR?=
 =?utf-8?B?SmR6Zkg1dlFDbGZHL2lGZlI3d3VFNjlKcU9HZURlZXpxWHZGb2Z6UHVsbTk2?=
 =?utf-8?B?YjhnSXZ0b1hFOU1nemxPNzFPZ2tnbElNMXN0bTRmNStyZkhkTzRuU2F6elVt?=
 =?utf-8?B?STAzWis4QmJvSGVNRTd0eGoyMWdrWTlMc29xbFBqU0thZWZKUGVOUGo1RlVR?=
 =?utf-8?B?Wi9TRDZOT2NNVWtVOFRnbGgyODJvMURBTC9tRmEyZVVVaXowOWNWMVpGTUkz?=
 =?utf-8?B?b3g0Z2xVenpGUjh5VnhYM1Zsc1JuMGRPNVBWdVVGVXFlcElJNnBLRE9lMXJB?=
 =?utf-8?B?OU9icGcwMHdXQ1VQWmdqa0YySkdLNGZVU1pwakpFY2FuSmIrNEtVODVrZVAr?=
 =?utf-8?B?L0NHL0FIRzYyVmlwd2JmZXVyMTUvTElCV1FOTSsvUGdGeG5hMG02SGRUdFNu?=
 =?utf-8?B?V0hiaFhGaTJVdTJ4L2I5ZXVhT0pZSWRFOStVdVJXOTNOQ2ZBWW94VGcyK2gz?=
 =?utf-8?B?S05WZlVUaG5qbitzTWx2ZmpZK3NFbEJocGRZNjlENy9HWndjM2Q0OXg5dTdV?=
 =?utf-8?B?aVFtV0lPdjdteTV6VHhLemZiY3dBSWx5OVVnQXg3a0RsdlZ5R3VreHlrci9X?=
 =?utf-8?B?Si9GT1plOVBFdUE0RFFQNFFyVXlUcWxsTi9tWXR5QU5GdFVKbmd5WnBVTkoz?=
 =?utf-8?B?eGR4L1puNkpwTVpZK1hEWFY1Rm8vVm1RWlBWVkhIS1JaUWZtMyttQ0svYkZK?=
 =?utf-8?B?VVhkR1NObE5PT1phSmZ5SUF3dTAzU2I4MjVuRFh1dUtXTHcrS1dRa2hmTGRs?=
 =?utf-8?B?SmRsbE51Tk9neERNakRxN29yeVpVc2MwMzN1Y0t4ZXJHaWlWeER3aU9qVS9p?=
 =?utf-8?B?NG03YWxsVGl3OHlJK0xHS2FzOENvUjF1UTVRSkV4VzBsaUtqeXRqN1cxR0JV?=
 =?utf-8?B?cXRGQU9ZOThUK1dheWsrMFYrSk84UnhGUVo2VDhFT1k4MTZXMXlRL0N5Qy85?=
 =?utf-8?Q?z98zb7yVWgJoqM3Bks=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0Q2MFZCaXZjR1BRNFFzYWNjTklObVo2SkUwajd5NnlOdk9XZ3g5a3Eyak1u?=
 =?utf-8?B?MUVoWGJHR2RMOEd3NHhreXBJQVpkWnlvTjFFMGtIOXVTcWNaYjhoSzB5RjNB?=
 =?utf-8?B?NStTQng2cWYwMC9wMXVqNTZMNm1HVnZkMnVJZ0VjUWZBTG5BNWszZzZNVnZR?=
 =?utf-8?B?ZUhWNlM5V2pEVmJwSmJtQm1PV1JiMlk5QjJCankyeW1SU21MLzJUb2IxbUg5?=
 =?utf-8?B?U2lUdEwwYjdsMjdkeU1XQVZ5SVZ2Z0xCbVMzcHhBZm1CSGpabG1JbVQ3R1FH?=
 =?utf-8?B?am14dDNjNXIyVGN6Q1JYemNVK0V4RjJMMi9oZmFsM3NxNmY2YVJHM01XbGZ3?=
 =?utf-8?B?K3lnT1F6ZjN3UFdkN3kycmdZMGUydElKN1NoM3hOazZaTFBZeTdXWlI2VHJL?=
 =?utf-8?B?R1dEMlVSbzBUNWZCUXlTenBuQVNEVlcxK0x6Q2k1azVTcERDRUpKNU5uM28w?=
 =?utf-8?B?T25IZUUwKy81aDNxSVdjdWZ2YStoSGxFeFdBSERKZTF3N1JnNzdIdGErRURS?=
 =?utf-8?B?RUlkRjFQRGVRbHZUMGtjMFdCczdVRnhDOWI3engvTmpMQk5DejZGWm8ySlJT?=
 =?utf-8?B?UkhjNXdTanUyNlV2ajNvcm9sOGZTVkNkbERtSS9LSnJvRjF6ZFM1QnhxNXNS?=
 =?utf-8?B?VFNDVU02Tzh1c2NZcENNb2pzUUVZVC9hMHlLbEJrb3hpK2M2MXgzSDFlWStk?=
 =?utf-8?B?QzByMFhvelZtR1pDYkErWFBnNXpUZ2ttUGFBbEpuYUR5V2hKUGpPbHRsbmov?=
 =?utf-8?B?MzNtbytnRFZEN0NDMVRyd3dmM0U5Yk9sWTF5eHQ2ZlM1WS9FRmkzSjBCYVVF?=
 =?utf-8?B?TXo1TkZGLy9GQTFqKzFtWGdsSk9JVnR3QmE3cXVicjl4ZW5LbDdDSlZScHdx?=
 =?utf-8?B?NWxIUm9NTnRCOFh3bjIvaTJCN1FqM2VDS1dUdVVqd1ozbFBrRUlDaHNXZ3g1?=
 =?utf-8?B?c1R0amJZUjRMTzQ3L2hBOXBDYlN5UE5mQTRuNmxtLzYrSTZEY2FRdHQ1VElS?=
 =?utf-8?B?ZVpTYkJUc042YWN0SGttTm50L2FZUVhpYU5mamg1TUJPbzlyOGtzSk0xL3Y5?=
 =?utf-8?B?SndWcmxjaGp1cnlGZXhJTFlVODZuandZb0E3Wmk0a3JNb3hEaCtlYUpMRUdG?=
 =?utf-8?B?dVduZTVLWlhEZVBYMFhxVmtvUHY5SWdCckRqbjNWVUQ2UkN5dUpFWGpNQitp?=
 =?utf-8?B?VTIyeDNlOE90VnVPRC9EV0FZbWZjWnR3bW9xcWI3NVg0V3FMendhMXVsQkh4?=
 =?utf-8?B?SzR5Z2dYK1l0Wkl1M08vT21VV3M1eElOdW55d2pPYWZheDl1KzdJeFVwTXkv?=
 =?utf-8?B?a2t5V1pQMVJsQjE5K3BKVVBNNlVJWFEzS0t6MExCMCtUbmhpU0ZWRG5hSzN6?=
 =?utf-8?B?ZDhyajRiSnpWWkhJM2Y2KzRRbWZOYzhPOHMyekJweVlKRGNqcGY3YUlYRUVR?=
 =?utf-8?B?bVhEVFE0K0xsa2FoVHBJSFRpTXpkTDF5cmY2bkhwVm95bno2WjlTZEs5VFRF?=
 =?utf-8?B?SHdtTGVYVjlFRlRLcWRVSnd3VFNmaE4wYnZHekRkMUpQL29SZWk5RXh5SlpS?=
 =?utf-8?B?T0plQWhLbDNnVVBrVEF0MUo3V1k3QXluVjIvblUyeTdYVWt4MTJ3SGNxMnpE?=
 =?utf-8?B?SVBxQ0wvMGxpaXgzRGNVK20wQjlJdlgrSzNpNU5mRnFQTU5RdU5uVUJJcjFD?=
 =?utf-8?B?WWhHNzZLUml5OVpFcllkRmIwSGt4SFAveG42N0taMzFGSFAxNXNlK1A2WCsx?=
 =?utf-8?B?TmNQRlcveDhWVUoyMGQ2T0JVNUVoN2xrK2JOcGVFeGhTbFd5cWhaN0tHSVF3?=
 =?utf-8?B?T1VJL2RQNkgxeWZoeDE4L2FLVjFjeFl0WHNGOUN3b0JyTXhFT3hBTEVzNENK?=
 =?utf-8?B?YUY0OHJ3QS85VjAweUx4L2xWOTNTT1FtNXpVeWUyUkNSL3FVck5nTHFCK2xT?=
 =?utf-8?B?ZUoxVFFEWG1lbzY2T2ZXK0VOVEI4NTUwKzVpUDRWWlFEVUNGUnBCVUl1azJa?=
 =?utf-8?B?UFFmSUt3T3g3d1l2T2IxaHdWYnZiQmd6eXltUmhZYlVGWnc5NGJaUkdSRVE0?=
 =?utf-8?B?VVkzWUhjODJhOU5mQi9SUitzZFNSTEN6RVF4ckJWTHQ3WWkyMkR3OEhtbGxC?=
 =?utf-8?Q?xG8Q=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0ce755b-68c4-48ba-0e60-08dca5095742
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 20:04:31.8211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HomdD6DGJMLCJ564Gc5IpKgWuk7W2lVicZIeziwfQlzXfDpG0Vb8l/DXOSW4io/Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9433

Hi Reinette,

On 7/12/24 17:04, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/3/24 2:48 PM, Babu Moger wrote:
>> ABMC feature details are reported via CPUID Fn8000_0020_EBX_x5.
>> Bits Description
>> 15:0 MAX_ABMC Maximum Supported Assignable Bandwidth
>>       Monitoring Counter ID + 1
>>
>> The feature details are documented in APM listed below [1].
>> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
>> Monitoring (ABMC).
> 
> <insert snippet about what the patch does>

Ok Sure.

> 
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>> v5: Name change num_cntrs to num_mbm_cntrs.
>>      Moved abmc_capable to resctrl_mon.
>>
>> v4: Removed resctrl_arch_has_abmc(). Added all the code inline. We dont
>>      need to separate this as arch code.
>>
>> v3: Removed changes related to mon_features.
>>      Moved rdt_cpu_has to core.c and added new function
>> resctrl_arch_has_abmc.
>>      Also moved the fields mbm_assign_capable and mbm_assign_cntrs to
>>      rdt_resource. (James)
>>
>> v2: Changed the field name to mbm_assign_capable from abmc_capable.
>> ---
>>   arch/x86/kernel/cpu/resctrl/monitor.c | 12 ++++++++++++
>>   include/linux/resctrl.h               |  4 ++++
>>   2 files changed, 16 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c
>> b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index 795fe91a8feb..87d40f149ebc 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -1229,6 +1229,18 @@ int __init rdt_get_mon_l3_config(struct
>> rdt_resource *r)
>>               mbm_local_event.configurable = true;
>>               mbm_config_rftype_init("mbm_local_bytes_config");
>>           }
>> +
>> +        if (rdt_cpu_has(X86_FEATURE_ABMC)) {
>> +            r->mon.abmc_capable = true;
>> +            /*
>> +             * Query CPUID_Fn80000020_EBX_x05 for number of
>> +             * ABMC counters
>> +             */
>> +            cpuid_count(0x80000020, 5, &eax, &ebx, &ecx, &edx);
>> +            r->mon.num_mbm_cntrs = (ebx & 0xFFFF) + 1;
>> +            if (WARN_ON(r->mon.num_mbm_cntrs > 64))
>> +                r->mon.num_mbm_cntrs = 64;
>> +        }
>>       }
>>         l3_mon_evt_init(r);
>> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
>> index e43fc5bb5a3a..62f0f002ef41 100644
>> --- a/include/linux/resctrl.h
>> +++ b/include/linux/resctrl.h
>> @@ -185,10 +185,14 @@ enum resctrl_scope {
>>   /**
>>    * struct resctrl_mon - Monitoring related data
>>    * @num_rmid:        Number of RMIDs available
>> + * @num_mbm_cntrs:    Number of monitoring counters
>> + * @abmc_capable:    Is system capable of supporting monitor assignment?
>>    * @evt_list:        List of monitoring events
>>    */
>>   struct resctrl_mon {
>>       int            num_rmid;
>> +    int            num_mbm_cntrs;
>> +    bool            abmc_capable;
>>       struct list_head    evt_list;
>>   };
>>   
> 
> How about renaming "abmc_capable" to "mbm_cntr_capable? That would,
> (a) connect the capability to the "num_mbm_cntrs" property, and (b)
> remove the AMD marketing name from the resctrl filesystem code that
> will be shared by all architectures.

"mbm_cntr_capable" does not give full meaning of the feature.

How about "mbm_cntr_assignable"?

-- 
Thanks
Babu Moger

