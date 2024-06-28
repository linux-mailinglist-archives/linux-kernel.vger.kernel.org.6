Return-Path: <linux-kernel+bounces-234232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 727F291C418
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 18:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 323B828247D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 16:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405321C9ECF;
	Fri, 28 Jun 2024 16:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZOnMeYyZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50E615698D
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 16:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719593278; cv=fail; b=S+5ikBIh05+6MIaPEu+ubOPbmjFofBPvkScwfiYAM/DqyA9kUZ5clh2yDYvY7fLAGrNoGADBZ4EzZG4I6nuNbRQcwvw/DzQqNj3cpmDmWyVDK0uOAk2m78u61mQpfppSWGWwx4eQXXHm3376TPEU8o9vvWOB9JsfQxQbIcHTkUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719593278; c=relaxed/simple;
	bh=FVSGREJNG+MgPjo/fFaRpaZsHTBm12kP3U2sqV0Kljw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i76apUzPK9dFsh8fo4lKSrIiS5BGNeRC08m9UOxnkOZ1YeUb/NBbz3il+dJy5qduHsqRsxXekcpBH9bQ8A+v1//YRk+ehsVCu5Ww1MRcUnlKVexr/oxU5w/A9iLrnOm/0yu5FvJhZM02DBUcpwfd7M7RBvJdRMrDlfoxFL3rPQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZOnMeYyZ; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719593277; x=1751129277;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FVSGREJNG+MgPjo/fFaRpaZsHTBm12kP3U2sqV0Kljw=;
  b=ZOnMeYyZRUyFgMWRuqD65KFGpXBJTISHnWdnx9wdM1zLBHYU8SqRK8PQ
   l+JLY2QxzyBEb3ldtOTPGiKz6ZvGKMGR7qb0ZbrF73hwQ18/5xBY7i0pp
   4Hi2CsszUxdzNDzjuPioT3V/w+hfoU4CUeFw/r0H16b8+r3OlHugn1bSA
   CT9bTWTmKC0YbT2kxU7tMbdTOZWVCsyBXL5FKMmmJNcAGpQe0QvAPc0AV
   h57rGslHi/11T9GooibeKtkMHGC7gEtoYEO5Ve0o/xIlSvLuraRXgltyL
   6wn2q1YYIyhl+buhpsRRxhsE3wDvblg/9WIk3HmVkEIydrU1fySJ6GRpW
   g==;
X-CSE-ConnectionGUID: XXQDcGTUQgib21ASqrMlbg==
X-CSE-MsgGUID: KVi20zK0TM+DiHolsFPu2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="19686215"
X-IronPort-AV: E=Sophos;i="6.09,169,1716274800"; 
   d="scan'208";a="19686215"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 09:47:56 -0700
X-CSE-ConnectionGUID: wbzVHj6URz2/4umrJFdVOw==
X-CSE-MsgGUID: +b2w5zJBRu+wCL0LMbYrRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,169,1716274800"; 
   d="scan'208";a="45213219"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Jun 2024 09:47:56 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 28 Jun 2024 09:47:55 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 28 Jun 2024 09:47:54 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 28 Jun 2024 09:47:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZDy0WdH11t2sPkbCwYWBAEFbMU+sbm5hGHIQaYHRF0h4dpVoiQYWyuifStAQrqZKM6QxaFpKQtMBSR6eg048fMyOojtrDpGscS9Do2ztJXoSd0DxVkip9ILLctIXDDf0Sd6+btJ8r3NrDfvdMtCaL73rwz00SSrVPnVGVa3gpysMtYQ6cwT7rLm417nS2HFUfr4Sg/ZL7q1HNTpVArYXI80k8X+Y41OUu3EO6fXudhmGcj+5F0ql0qPq7HyKW09qdL4tDrqYX2bhUsG8QE6pWt+hJJjIHXdma+0TRc0mS4WJ0yqJtrrnRtS7NMjeBGXyLujgqnPT0EWXI49hDReeYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IR9o4JAXxFXjF6hBCiz3ObNM5SyZrvsPS3UH21pySys=;
 b=A0oVHa06ern0251mX2vfUcooWaAuS5oHQlmC2d1q8kAqOdwthNcL6+ivbxKVGlNaZqwYeNQv9YY3bQYg9Jf3Tp4BD7WwknrF7sn1yPkiifTRMBS9Rg15XIIzghU4mC04/jDuLYmf0Sn+n3nSEyTUMUc2vb7qTUf6Hi+MFYQs1j9DOyvnsYRAN8A5hq06b1DMEvX0Q7+I3e549Zjw2WrOpsPPGiG1uir68W5G95cDA9YG3pjx97xwEwXvJKmbG8hwcilRWfbKsPTRc8QTNKy7XAbwy3BTKF77t9Rkfr3v2Zy/CsUcYoX7cqF6JXmLTDlafeb1lQbqPB72N2hhdvSCCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH0PR11MB4840.namprd11.prod.outlook.com (2603:10b6:510:43::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Fri, 28 Jun
 2024 16:47:52 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7698.033; Fri, 28 Jun 2024
 16:47:50 +0000
Message-ID: <c7b3c16a-afb0-459a-b1ca-c420122f296d@intel.com>
Date: Fri, 28 Jun 2024 09:47:47 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 16/38] x86/resctrl: Move monitor init work to a resctrl
 init call
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
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
	"Dave Martin" <dave.martin@arm.com>, Shaopeng Tan
	<tan.shaopeng@jp.fujitsu.com>
References: <20240614150033.10454-1-james.morse@arm.com>
 <20240614150033.10454-17-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20240614150033.10454-17-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0153.namprd04.prod.outlook.com
 (2603:10b6:303:85::8) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH0PR11MB4840:EE_
X-MS-Office365-Filtering-Correlation-Id: 395414e4-8a8a-4a6b-4495-08dc97920c19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bFZIQjcrTUZlckczV0w4UGJOOUdtdzVtTFBmMVJZRFZnaHl3ZG5qYlRjQ3N1?=
 =?utf-8?B?cXRoL3J5aXlKSWd0VFZhK1M4MDh1MCtNbmtsZ3A0Y2F5b2lXWjZKdEFVSU1z?=
 =?utf-8?B?THhXYlZRTnVUTEtlRG9waWRPVDdvSk9hREcwMHRaZnhRYjk1dXI4K2RBSTF2?=
 =?utf-8?B?VE16eERueWhGYktGaHdNWGQyVWJ6RjdYWjJSZEdHMDFScTUyYktpZGRvb002?=
 =?utf-8?B?Q0NCS0dJbXY0TCtyQ1ZkeWFkU1FEZTdDOG9Zd3ArQUgya3M0VyttTi96bGRw?=
 =?utf-8?B?aHBTQ2lKc2M5ZE05SGErQ0hmZTRUc0dsSjg3c2pqbE1MZUxMV0E0M2VBeG8w?=
 =?utf-8?B?OFNkSUpNY0JlbHhwSUJLK2o0bU1qNDRtQkhhZXJSNjhheURXekY3bHJpNzBk?=
 =?utf-8?B?dFIvejBBZGpBZDJZQkFPVEdRSllZdVZvUlpHRTFtVnpGNmhRT0F1VjlxUG1N?=
 =?utf-8?B?UjFWaWkzRTEwdHRSckNkR3ZhTnlqZ0E1VmJMdUJoTTlxdU1vRzdrSnNJL1g0?=
 =?utf-8?B?Z2pERmhrUjdKd0R3cVRHbDFZTHZCTklPRUdhQVhOdTRlQVBzVmtMYXZXK1pm?=
 =?utf-8?B?SWxDM1dGTmtZZXhvOHlDa1I4RjZzQUM4NDR5TnpjbUhUVFJsYXZwUXdDVHlS?=
 =?utf-8?B?TlRtSklUZFBpOUJxVDBncGJEbFA4Z1E2aUlRUUFDTmJJc1I4d0g3OVg2bFE2?=
 =?utf-8?B?cWt6YmJKV1VrdGt5ZTlicDlrR1g4VlJZTmZYYjBDRjdyeHFkUzAxNVV5WEx0?=
 =?utf-8?B?ajNreXhRa2Rid0hqdlNqdTVrSy9tdU55U09tNUZmdXRHOUswMnQvTUR4OHkv?=
 =?utf-8?B?Zzl1YWNUaldOOVliZzlCZ01HT1RsbXZ4aTBQRWhGVVFDQWhTOGh4Q3luOE9Q?=
 =?utf-8?B?QjFVK3lkUlltSk9CV1Z6ODFFZEF3cGlSY3EvMTFVV2EyWTNSVnFyWHg1TUxn?=
 =?utf-8?B?OUZtaXpPMnRMdUNEVFRLRHJ4Y0hjcnM4TlRzU3hBTTlTcE1HTUJ5UjNra2VO?=
 =?utf-8?B?VGxuMDFzMWtyb2NVMTJnUEErNU4yU1BFRlFXcm1BTU5yK0QrbFVoNjlGWUJP?=
 =?utf-8?B?QmpwcGdoMkdTb3E2NXZBV1N3RSsyKzgyb0EzbTRIS2ZjL2YzbVJGSFZuK2ZI?=
 =?utf-8?B?am1RVVNlSDl0UTJKcXVLZWxRL3VJS0FwQ1U4ZThKamxzV1hKbmR6VUY2RmYy?=
 =?utf-8?B?cXVveWw2U1JGalZ3Vk5Ea0xMbkt3K3RtYVRrOGs3TnJ0bUluTTBjQlk2R0J6?=
 =?utf-8?B?cmZ5OW14a2xMdHlwcUNOSEkyMG5MRGFYbnl0NGEyZW1NWi82Q2tZUjdtNUVH?=
 =?utf-8?B?OEhaVWhkay96R3FDeTlZUFhURlR0dmE4R0xEUENUbURMaTRyNTQvWHBSc3Ix?=
 =?utf-8?B?c2NHNi9xZWVCbHp3aWwyKzVJd0xIYnhmbXZHN3QzeGFHODk0ckg2Q0FFL2tx?=
 =?utf-8?B?YkdnQ1N4V3VwZkxIZjFLdytFckhOWjliQVBPWExvMEZoZ0hEdmlkTTl0aTJZ?=
 =?utf-8?B?TjdnSjJFRnBxK3ZjeWpKN1d0Q2ZZdEJKbHh1TzYyQktEV2ZPemlFcVE0bXB1?=
 =?utf-8?B?YU5UUDdrOVVBaTZnRUt1UlhRK3Y4OHNINWdxRnV1Q3VNTC9BaTI1TC96bGF0?=
 =?utf-8?B?SkI0T3dqOVE5R055RzAwUm5CYkVJa0VkTXNqNHNtOVRVOHl2K3Bkb0haNXZY?=
 =?utf-8?B?NWRnTGdGUS8rbEZrUS9DaXE3QkYvZjdheW0zRlVpZENvMnhqc3p0TThkOVJu?=
 =?utf-8?B?K29lQWlnRWJyVHhlbVZCVjl1UEVtQnFKTnQ0aXgrek1MRVJmemg5eE03U2xs?=
 =?utf-8?B?YWRKRVdDQWxZeldUWjJVdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STVYUXp1UDdiVW5uQjdFbGkybHJZUlJuZFpLcVA0aXZtNldXcmtqNmZXMkdn?=
 =?utf-8?B?bU5uVXFYUzRzeTc1Nmc3bzBrc01NVTZob0hPeHpCbTNvaUV4RS9pWEx6Sk1P?=
 =?utf-8?B?VDhzbk5peDI5WEJBUVNJTUwrcUpXWHZteGVmaHRiVjJBelRmNitJOThLeG9B?=
 =?utf-8?B?V3BWTlRub1N1djVtMDlMUEZPKzF1Q0RYOUlIWHk5VXcweWRuZENkQVhuOWMz?=
 =?utf-8?B?Z1dKZlZHVXJhdHdYbFBVQ3loQTljTlpISm4wOHR0QzIzTXJOeVdDQ0VvNzRY?=
 =?utf-8?B?bm91aE92OVBFWnZJaE9randieVVFKzNqbkJmbXhMbzVOUWVxazhtTUVXV1BF?=
 =?utf-8?B?bTIvS3lnN2RaMlNXZjY2VjNqL0dtY1pTaW50VHM0ZURCT2k1dGE2cEZyL1pX?=
 =?utf-8?B?MjF4NU5FWkdtQ3RPdzdnWUdUak1pZkVrblBqbnlnWXVxZ0creHpnT0k2cE52?=
 =?utf-8?B?bjlVUzVVVHlESVpnemFDbkdDaHUxZjZ5VER5eDBqSFpQNzMxZzVoblg0MkZI?=
 =?utf-8?B?YkF2dnRwSlZVS00ybkxYZzFCV0taREJ4K0VwakNrbkxGYjhwaklNV3duaTR0?=
 =?utf-8?B?d0dKa2U5M3IvQU1Ub2NNYTJnT3g0dVJUSGhObmtNZTBDRTRJVTRQWXpMakJt?=
 =?utf-8?B?WHVod1czdFRrejVrTzF4ajV3ZDg1S2drcnpoVG1wYVVWZWpyYUR5NmNkN2hi?=
 =?utf-8?B?Vnp6WGxzYk9saUtDa3lIelE3d3dJdDlWTzZLRHZpN1J3b2o2MzRXUTJTRDRi?=
 =?utf-8?B?UGxHa21yN3B4SUwvRGhabEdMV3l0TlRodHczVWNiZ1F6UzMvWnFWQkxZdjg4?=
 =?utf-8?B?ek4zbnJXVWViMWpDWHh3V1dPbXd3dTNxeFAySkJtd2hzZGNidldqQUZCLzZa?=
 =?utf-8?B?VVZWdE1NbXlRN0htUVNxNEg2VGs0UmFZZ3cwQ3B5d3JHQU5jUE42SlBrSWky?=
 =?utf-8?B?TnlkTEV1bGxHTWFCYUJ1aDYrWTIwblN4alhCZWRtYm0rbmRKbTRSaWttTkpV?=
 =?utf-8?B?c1F6b0VxdU9Kei80dTNOL0lsSGl1cGhKYXRkMWloM1IwLzI3Ykg1dXBIVkF5?=
 =?utf-8?B?OE5RZlhNaDJrd0NZMFE5R2RTeHpZd1huNzdIeExXSmpkb3JsT1F4TVpEWnZz?=
 =?utf-8?B?S2k5Tm9XWEwvcjVrTnQ0RHpPalhrWnNPUG1CRnQ4OGZHQWNoUExGSUdkY3pY?=
 =?utf-8?B?dGR0RUZQdVFmTVBRYjIvWE1RdEYycVpDZUEyRGxXVWkyeC9VWDh0NGJEK3V1?=
 =?utf-8?B?c0p6dkxFWUZLWVNSdi9SSitSbDQ1L0cxcGxSb0tkcGxRb1g4Z3hpYjNQYmti?=
 =?utf-8?B?ZWtObDFac290TmtQZmtiQXFHc0ZjTmhvUEw2Z1dweHRUdWtTemQ3aUg5dXV3?=
 =?utf-8?B?aVppRU1mS04yZ2lhcFJPbDQ5YkU5MTBKVW96NG9CRHJIVy81bm45Smk3NG5D?=
 =?utf-8?B?bTFXUktMSHFsS2JITVRhL3cveE1TL1Y3TXRuU05WQ2hkbVRqVTRXT1YvblMv?=
 =?utf-8?B?YW1EcTNsTzVGR3BzQUF5dUJpUmN5MHV1YmwyOXhIdUpacGJUUGR4UXROUHZw?=
 =?utf-8?B?R2VpbHB6RUMxWUpPYzB3cUpRUFd3SVdLRVBPVUpFUFpNdWp5anRJZ3RndTBx?=
 =?utf-8?B?SjVtVkxLOWtzbEZjVm81VWIyNm9mY2FhdGZRTEJhbGlWUHRPQU9KVkJobG1D?=
 =?utf-8?B?S1BPZFU5bzhzcEIwTEtjMDVZb3pHeGMwQ1F3K1Jwdkh3RS9kaUc5dnQrUVp6?=
 =?utf-8?B?cFlaSHpLc2J5OEg1K29JTG5vUWVWTDhQVEZ3bXo2N1REWTJiakd1a05wVUpX?=
 =?utf-8?B?NlZTam1DZVIxaGNTNC8zaXlFZ3NmY29yZkFPbGRJQTEvWXlXMGk0NkZmdHY0?=
 =?utf-8?B?alI0TnRJenJyMTN6aHltWWQ2U0wvVlVISVVBNUVxM0RKbXkyMjJBMTB3ckpQ?=
 =?utf-8?B?Q3JyNThVcDQyOGdMRkl0b1FoRytleGFDSGFBM0xlOExGZjZMR0hNeXAxMWFJ?=
 =?utf-8?B?T1R6UldJajVtY2pWREVXSzZaa2c0MUF4bm52MlRWcG14U0RxNDl0c3ZubXBU?=
 =?utf-8?B?aW4vVXpQWGJxVzkwTFFxU0F5U3hMa0Q2YUdWa093Wmd5Y3gyOVNsSGhJdTBw?=
 =?utf-8?B?RFdHUS9rZDJuMTJxUjRIa0puaUVTVWZCNEJJRmlFQ3FpWjhIUmlsL1JrS1B4?=
 =?utf-8?B?YkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 395414e4-8a8a-4a6b-4495-08dc97920c19
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 16:47:50.5013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OkpXsvTvjzy9wOiOi9/qLgAUuahNS3PEiTMbAqQ9Ac+s3mpyJdM1HMF5ycbPfNsjZnesuXWTsScTBv3X41Npr4Ae+j4X3fk8pfWUQDC2d8A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4840
X-OriginatorOrg: intel.com

Hi James,

On 6/14/24 8:00 AM, James Morse wrote:
> rdt_get_mon_l3_config() is called from the architecture's
> resctrl_arch_late_init(), and initialises both architecture specific
> fields, such as hw_res->mon_scale and resctrl filesystem fields
> by calling dom_data_init().
> 
> To separate the filesystem and architecture parts of resctrl, this
> function needs splitting up.
> 
> Add resctrl_mon_resource_init() to do the filesystem specific work,
> and call it from resctrl_init(). This runs later, but is still before
> the filesystem is mounted and the rmid_ptrs[] array can be used.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> ---
> Changes since v2:
>   * Added error handling for the case sysfs files can't be created.
> ---
>   arch/x86/kernel/cpu/resctrl/internal.h |  1 +
>   arch/x86/kernel/cpu/resctrl/monitor.c  | 24 +++++++++++++++++-------
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c |  9 ++++++++-
>   3 files changed, 26 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 9aa7f587484c..eaf458967fa1 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -542,6 +542,7 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg);
>   void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
>   		    struct rdt_domain *d, struct rdtgroup *rdtgrp,
>   		    int evtid, int first);
> +int resctrl_mon_resource_init(void);
>   void mbm_setup_overflow_handler(struct rdt_domain *dom,
>   				unsigned long delay_ms,
>   				int exclude_cpu);
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 7d6aebce75c1..527c0e9d7b2e 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -1016,12 +1016,28 @@ static void l3_mon_evt_init(struct rdt_resource *r)
>   		list_add_tail(&mbm_local_event.list, &r->evt_list);
>   }
>   
> +int resctrl_mon_resource_init(void)

(Lack of an __init is unexpected but I assume it was done since that will be removed
in later patch anyway?)

This function needs a big warning to deter anybody from considering this to
be the place where any and all monitor related allocations happen. It needs
to warn developers that only resources that can only be touched after fs mount
may be allocated here.

Reinette

