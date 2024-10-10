Return-Path: <linux-kernel+bounces-359603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E757C998DE3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 18:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C7A7282CBB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 16:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C92F199E88;
	Thu, 10 Oct 2024 16:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yDhJ1riv"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2049.outbound.protection.outlook.com [40.107.101.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B3A192D67;
	Thu, 10 Oct 2024 16:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728579450; cv=fail; b=AvzcNQFtvf9Wo40TpxPm5+C+jUawZOgNfWlH+VzYergSZRd30bQmdwgo96gNkUbVaHL2rG4WgWI6YrIuDJK3M7+I9XQrOmsc1BIYLHs+LpvT9cbocbRd2tPopZ8PnJFvrtSnUJNd9NyUDTh6JHoMTIvpZmReycyL5vcT8V3kIGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728579450; c=relaxed/simple;
	bh=wjrkJqRnch6Mh/Zyi0ln65A6Ke3FHdCyLb9jEr4WoZA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XfZOJP8PLCSDFNPqcrfvc6e08Hcuvq9Ev5WQ7DQJiVBb/VmvXh6MmddgRh2rYvM3Ja4V44pxmLuvf5d+MnYxQUi0Eja4b1ITIaW+gevUIpYm+cABA8DPT+n8LVdvGKl2Y0ph0/CJl6nE6vkPdLh6nO2NGka9cSfbbXcPRayDHoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yDhJ1riv; arc=fail smtp.client-ip=40.107.101.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lSDAiCT6nN7ExSGMrhIWDgIKzXL7+SBUaKN9dsnrjcO0ylROuXOpjMC6JfsK0JX+CtQ30mqaU+ZG2m2992rMmwL4A6UG7+pDStyALgwVFdJgjvh2VtUehKPCYPeM0M5OKNYrd5PeKl65DOpvZztV1kdFDsEg0R6XrKGRntMAsOeB6S4GHYujQlDJPoEDRUirhRrzKI9hut3fiPFrE53MN007skOpuHLMaCxi5CtUHVPBMBPU5CxQgkiED92mok2y0JuC+9G18IUvFCxe7Afe10J2lpcYZU5ZH13PhBCk68RaJDG/CrT++deZ3AS12k4RsydSiG29CcOGxb/wiL9o6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bE1vIMhTus9pfX8xpR31ecYxHiKLEEpW5AY2P1283Zs=;
 b=DoWqvoWm8dFFRjrzrQgqapNnr3kU6JpgYGG3cW1rILYiRL/bhu6MWva4v15heGb9Ad1ZvV6RNGEpkWRpDpBLgb8og8Y7OZCe+/FbFSMdRQzfsHh1azfWUK6IZqmb/6WOqjL9jniM/GXLQCoJ53pimMwppYfK+Aly77KFOMMwgYIZjbMofkW+FFf4aH0ui3O3kO3lppCbjV0ZNlAiJ70DnP4J/wINMkS21MZayJOkuI0HFtGKFbGKqNTMs1V4azHo4aZGYWzj7MaiBnAkkVH6xFqnSSi+WLgmDwYl+foF85K1H5iuYqtn7Cv/cTPbOByMy1xI1GCw6tDaQ5cKelxOZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bE1vIMhTus9pfX8xpR31ecYxHiKLEEpW5AY2P1283Zs=;
 b=yDhJ1rivAWzg9764iQhizUqjnjCHkwmOfC4ueH7xrnLU+4wBnBJrxkhovFTl71K4qAX7YwS4n6O9RKgCoI8z8ggLjqxQ0JKFT3PVyKw/jQ+x0Vk1vpF3rIzFKs8SwmZGHt2w8il/uam0guM0lzM5Pb8H1jICN9c7Z63sOdFnnSU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DS7PR12MB8289.namprd12.prod.outlook.com (2603:10b6:8:d8::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.18; Thu, 10 Oct 2024 16:57:25 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8048.017; Thu, 10 Oct 2024
 16:57:25 +0000
Message-ID: <0fedcbd4-487c-4d55-8151-69dc34f41f1d@amd.com>
Date: Thu, 10 Oct 2024 11:57:21 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v8 08/25] x86/resctrl: Introduce interface to display
 number of monitoring counters
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "corbet@lwn.net" <corbet@lwn.net>, "Yu, Fenghua" <fenghua.yu@intel.com>,
 "Chatre, Reinette" <reinette.chatre@intel.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "paulmck@kernel.org" <paulmck@kernel.org>,
 "rdunlap@infradead.org" <rdunlap@infradead.org>,
 "tj@kernel.org" <tj@kernel.org>, "peterz@infradead.org"
 <peterz@infradead.org>, "yanjiewtw@gmail.com" <yanjiewtw@gmail.com>,
 "kim.phillips@amd.com" <kim.phillips@amd.com>,
 "lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>,
 "seanjc@google.com" <seanjc@google.com>,
 "jmattson@google.com" <jmattson@google.com>,
 "leitao@debian.org" <leitao@debian.org>,
 "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
 "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
 "Joseph, Jithu" <jithu.joseph@intel.com>, "Huang, Kai"
 <kai.huang@intel.com>, "kan.liang@linux.intel.com"
 <kan.liang@linux.intel.com>,
 "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "sandipan.das@amd.com" <sandipan.das@amd.com>,
 "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
 "peternewman@google.com" <peternewman@google.com>,
 "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Eranian, Stephane" <eranian@google.com>,
 "james.morse@arm.com" <james.morse@arm.com>
References: <cover.1728495588.git.babu.moger@amd.com>
 <c79fdf4196d974325df995eb334221463747689e.1728495588.git.babu.moger@amd.com>
 <ZwcIkf_oy2oKByNu@agluck-desk3.sc.intel.com>
 <8ceeb50a-70d7-4467-b7c1-4f62b1a1eec8@amd.com>
 <SJ1PR11MB608381B9DA3AE26749070BE8FC782@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <SJ1PR11MB608381B9DA3AE26749070BE8FC782@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR18CA0011.namprd18.prod.outlook.com
 (2603:10b6:806:f3::19) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DS7PR12MB8289:EE_
X-MS-Office365-Filtering-Correlation-Id: db7d73ee-a342-4817-4665-08dce94c9de7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Rit2YTFCZGMrR1J1dndSRHkzNW9yMVkwc0ZkOVN2QU9ISUhrRThCMFYrbnFG?=
 =?utf-8?B?dmxScHcyOWdBeW9OK2ViZ21DWWpxVDVnc3k2akVSak1jUzFBWkc0cjNmRFVN?=
 =?utf-8?B?NytlR1FwVVY5SGtKWjg3Z1hQdXljRDMwZjVPSGw4SVlMSXlBenFXbHFUUDN6?=
 =?utf-8?B?Ni9uRm15S1oxSDRDSXM3VzBpbmdnQmNXSG01aGcwM1hDNXFCTjk2Mkx2dEJY?=
 =?utf-8?B?UkxRY3RLNGM3czVDT1ROSnB0SitVelk3SFpCdmxVSzAvbHh0WkZjcVU3dGdJ?=
 =?utf-8?B?akRXNWQxR2lJUGw2ZVRWT0JSa3pVZThYd1BaOE5pNGxQWldIa3FiZkxWSDBi?=
 =?utf-8?B?WCt2c0lsUWhRQjV4aWVwaXByVkJXRG92MHV6SExTK1JJOVQwR2JlOHEvV1dX?=
 =?utf-8?B?WDdTUHBndGgrd2M2SzQ3YmNobTNLVFoybDZGaXI2ZkVTenY5YkN1OHNjSU0x?=
 =?utf-8?B?ZmgwNkpQSm5UWU5sTHRxaGo3RmtlNU0yOGRNVCtmbWRuTjBMRzRGZW14Y3VE?=
 =?utf-8?B?RVhmM05lSGRRRUhDNTNVZ3V0aW1wYmdBSXdvSUl0NUtZR1B4YnJjMmoydVI0?=
 =?utf-8?B?eXMxSlR1ZXZ0QjQvOXorRE0yd2RlM1RoT0I0QlYva2hDcm0wSVJjRkNZdlk2?=
 =?utf-8?B?QndHQVFIdUpRbXFWKzhxRmJsM1BsQkhCcDZ3NlAvNDd4UDJYYVJvNG05RlBo?=
 =?utf-8?B?QnZzaVkwRUZjQkVnb3QxVWNSV3BPeGhGdXNLbi84UnVFTHd4VkRabVFvOGEr?=
 =?utf-8?B?U2l4TGQ0VmJhNXJqZ3hZdnFaakl2U2tGR0lBUE15d3dIY05QOTJ4TW9wZG4y?=
 =?utf-8?B?SmU1Q25pNmxFS056bzI4eEk1d1M1bktmTXE1akhURERWazRlNmp6dnc5K283?=
 =?utf-8?B?L0ZwRnEwOGpTekwwRWIxZ2tvNTgybCtpQTRBVVJRemxmWjJTaW5LYVJ2V3ky?=
 =?utf-8?B?MEhzVTUzVmdLVkxCSmJ1dGowRWpaRngzN21uSkprV3VtV3RHNStBcjVabDZy?=
 =?utf-8?B?T21pS3FHQk5RQ3dSa1ovODdoOHBIVTVIaGVNRkNKVGdBUUdjYjJlT2VnNDFu?=
 =?utf-8?B?bjR2b1BlQzcxQ1kzUE1CcGhwR3BOYVJPV3dFRHQrcjhHeStOQVAyUGplZEJJ?=
 =?utf-8?B?QTFqeGFZTC91bVdQY3RDUVpKOEoxSjlDTGEwUVk5eDNJQUZRMHRTbTlHZjl2?=
 =?utf-8?B?RFU2VWUxaFFnYjRmZncvekRKNnU0UkVGTHdHU2FyWis0bThrRXlOL0l2WFJx?=
 =?utf-8?B?SkhvZUNlRmhxVEVsd2p0VTB4anQrOFEyRGpveXhiRzY2QW15K2NjTjJiNnY4?=
 =?utf-8?B?Wk8zek4yWjM4NzFzR3M3VjRHajFUQVlqYXhDcTRjRTJHYXlIZzRZUFlDVTVm?=
 =?utf-8?B?aFFiZW9namU2QXpKSkQvdG9xMGt1clVkb0Y0TGhuYUo0ZWRlajViMVlqcUNt?=
 =?utf-8?B?R0EwS1RQM2x2ZnhlSTNRQUMvMGw5aVZaU21yTTA0eXJXVHI0bzJBMTAzK1dv?=
 =?utf-8?B?Y3h4azlFQlNEdUlpeTBPSEFyUVdBaG50ekR1Kzk0N0l4WDlVUkI2WWxELzBJ?=
 =?utf-8?B?aFh1Rk5FajJWR2FLckhPSytxODlldkhWY0pPZ01CNFhhVjFiQms3WEZINlVo?=
 =?utf-8?B?V3R6REhhZU1PZXg3ank5S0pzZVpLREREcVFFTW5vQWtCZWcxL3hiOUdSbm1M?=
 =?utf-8?B?UlFvaW1ETklFUEZ3ZzRLODhpZVd3NDdRWElsMlRiUm5iM2ZsQkRrN0lBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?LzJRTnU5ZE5tOWh3Y1RBM08zR3ZMeVpTWGwxNVNXbGVnS0NFOHZZT04vKzNN?=
 =?utf-8?B?YjkxWHU1N3NEcnRpSzZwcG5nM25nWGFxbkpINC9UbzJGUHlYMjZhZjFkVmxw?=
 =?utf-8?B?ZnczMXVYZVBzRGNGdHN4Snl6djg3OEFxamJmVVh4UEptcmhjbzErQlA3YjdW?=
 =?utf-8?B?eTBVdGZBUFRKMWpUQkpWYXZoM1RCblJpaW9mQzJWVCtRY05VdEdHSlBxWE1C?=
 =?utf-8?B?RTRlNWVYNG0zVXNDdklIOEFvd283a0UxUVJEai81QXFBTVpELy91K0pFSGQx?=
 =?utf-8?B?STJlMFFhRGdmRE9TTWJIT2dxNVBYR2k5MkxlNHhzeS95QTZiSXRhUm4wZW9s?=
 =?utf-8?B?UEJlekVqMlRtVk9XR0lnSHY5UURKL2VRbHhZWFVzaTZzdUpuYXlGVWlEVEFP?=
 =?utf-8?B?YnVxUmFzNzE1UUtXcGNGYXBPVytaV3ZlMEl3N01MUU9NSzlDbzQrc1dEZ3hU?=
 =?utf-8?B?UEVPcDJ0WXlMdlNyeXVXNkl3QkRNL1N2NFU3VmgwL3pDWVRxV2JRNUF6Zzla?=
 =?utf-8?B?MnJFSDFVcjVwQVlUYUhveFZLQThJaEtENjAwemhhamE2WUZLbDZteEJNQTR0?=
 =?utf-8?B?VHJuajhWT2ZYeDdET25GM0VjNTYyWXFmd09VNWZWNHZvazFyajgwWjM5emdm?=
 =?utf-8?B?ZTBrLzlpTFJFMjBLQXJ6ZzBnckY0RzF2dmFycVFDS2krNHVNRTFmZnJjOEl2?=
 =?utf-8?B?aVBmazdWSWFKK201eUpFR0NwWFlTdEVmTURxRkN4SmRaRVpCRkhpdWtGWGdw?=
 =?utf-8?B?QjYvV0JGYk9VWDFHRTZzaFUyL2VBVjNhRHZuRk83dmdsVU50ekJsbFhLVi9q?=
 =?utf-8?B?RTM1Zk1pdEQ1TFhmeUtpQnBETkxSUW4rMXFIVXQxclpNeFVTaXlKZno1UVRE?=
 =?utf-8?B?YU9FZ2RleWQ0K00rOXc5dzgvL1o0UzMwSUtrVXByTElVdFVya3Q0SGxsK0Rq?=
 =?utf-8?B?MWdxY2pFWHdleUhZSUtESkNVQUlzcEVyWXhuTTMxUXlBcFBRdDdCVThXdnQx?=
 =?utf-8?B?YlJBSS9CODZXNFhESWZMN3VrTEpYZElIKzdKa0ZsN1MwTE1Rc2lvRnU0WG1l?=
 =?utf-8?B?OHVUOXFweFdSdWlLMkVWVGE5S0xIUHY5MXdrNEhJT2ZVVzZBTGh1a2xUY05O?=
 =?utf-8?B?WHRLNTljTlJCa0xyd2hodlRtMW5VS1V0VVhhWDdaZjEzQTBGRXk2dzdxRFBE?=
 =?utf-8?B?U203Rkp3RHZhM20wcUo3ZTBvUU1yTGtSaVdOMkxGOVFaYUpqL25JK1dTR210?=
 =?utf-8?B?S3VxV2hJcUNaOE9qaHNQZEV0SkZQTkZzNTdQNGtvYlBUTzdHbGV1MlZpSXUx?=
 =?utf-8?B?V09KVTdBN1BrMnJMb1lBcUlaTzBYVElCdmdNZWZlak0xcG5HTGM1TzdyU0xp?=
 =?utf-8?B?UldLdGhDdDhDSndDL0FQOEtkS0l6SUhFejdBOXpyc05tZUR3YU1ZUE9SU2tt?=
 =?utf-8?B?Mkw5MnFHOTF6VXcvU2hTcGJ4VW1NRWlDbXM1R3Jyc3RuNGlPQjFZTVlKL3RL?=
 =?utf-8?B?RVA1dStZSkFCdXhEckJtbmQxSVQ5YVNIYVVwTHpUYk9YNU9MQjRWMk10cXVG?=
 =?utf-8?B?N2N0N3grNlRuTGNzK0hXSkNzUmR2ZzBnUGoxY01lVUVSVVpUcTJvVUFOalI2?=
 =?utf-8?B?eU81TXcrcHFOVk1GZDhXVCtVaDdqbEpyL2twQmVuSUt4L0ZueW00UjJzblla?=
 =?utf-8?B?QWxqajFpdjdvTkdBUk92dGpVL1dLdmI1YU9JaUh0RnZaZTR2NTI2dWZxeGtT?=
 =?utf-8?B?Q1Q1NDhBSEZnR0RXbFVqK0VBVmNaQ3grTXlUU2hoQU9RNUtML1ZnMkI5QkFU?=
 =?utf-8?B?MVNFVUhnQkw0bnFHcjNIanE1Wk44aWozWUFnb0ZxbEM5dmVqTWFNTkFrVDFS?=
 =?utf-8?B?bXI5SVVPaXdwMHQzVjNtVmhMM20wdGFWN3VlZjJibmpCQjM3MzZ4c0RlNWpR?=
 =?utf-8?B?MFVRbXBCUEtDN2JnQ2ZWV2VlbGovZ2JrRHRuNkRrd2R6bWh3ZEQyVEZQakNq?=
 =?utf-8?B?ejVCdWRvOUpTVkNpSW1YQ1V5L2dCM3puL3VUdkNrMERhRGVyaWlSM2ZRRzRi?=
 =?utf-8?B?SHQyeUxqVm5kOFUzcHNtZ3hPSXlIOUFuR29SRGdPRzYwbi9ocmpjY0lneW5y?=
 =?utf-8?Q?2wrs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db7d73ee-a342-4817-4665-08dce94c9de7
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 16:57:25.7436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7XdOY7y+UIcIrIYuPya52KVc/BdDrkP8WRDAkZLvCaQSLzW6JaN7vViqQDGM0es2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8289

Hi Tony,

On 10/10/24 10:58, Luck, Tony wrote:
>> All good points. How about this text:
>>
>> "num_mbm_cntrs":
>> The number of monitoring counters available for assignment when the
>> architecture supports mbm_cntr_assign mode.
>>
>> Resctrl subsystem provides the interface to count maximum of two memory
>> bandwidth events per group, from a combination of available total and
>> local events. Keeping the current interface, users can enable a maximum of
>> 2 counters per group. User will also have the option to enable only one
>> counter to the group to maximize the number of groups monitored.
> 
> Much better. Looks OK to me.

thanks

> 
> New questions:
> 
> 1) Should resctrl provide a file to tell the user how many free
> counters are available? They can figure it out by counting all the 'l' and 't'
> in "mbm_assign_control" and subtracting that from "num_mbm_cntrs".
> But that seems complex.

We have the information already in r->mon.mbm_cntr_free_map.

How about adding an extra text while printing num_mbm_cntrs?

$ cat /sys/fs/resctrl/info/L3_MON/num_mbm_cntrs
  Total 32, Available 16

There are all global counters, we don't differentiate between sockets just
like number of CLOSIDs.


> 
> 2) Even more so because free counters might be different per socket
> if the user did some "0=tl;1=_" assignments as in one of your examples.
> 
> Maybe a UI like:
> 
> $ cat /sys/fs/resctrl/info/L3_MON/free_mbm_cntrs
> 0=5;1=9
> 
> -Tony
> 
> 

-- 
Thanks
Babu Moger

