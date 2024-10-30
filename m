Return-Path: <linux-kernel+bounces-388868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1969E9B656F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EDCA1F242C4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 14:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642D01E907F;
	Wed, 30 Oct 2024 14:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="n+gkDL/O"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAD9282ED;
	Wed, 30 Oct 2024 14:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730297750; cv=fail; b=XqaPzNz4UZfpKynh1fUh3yST5ddY8ctsLHpZIamU0EckATDcl3eq4a7ZYHN+wKNAo/DOtZWzoChX78nKfGuuD/xyzEh/Eq/E0l43nhGML40qvwgh7DxjuENsOixKDRWYC/oX1V2NrTYXp2U4yf0BWB/XinzE4hyVtW8TIWzmPx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730297750; c=relaxed/simple;
	bh=JOeF8SplyA9+tqpGdDZizZ0YQXuSapAM5qnF2sGbwrY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=itBpbEcepYgRylNcrbbROYGdeJBt/OjGF3a8I9JgBo8mbfGKzmHnC+QJnVYFZc3/8Def8QfTLz35oS/xp1EjlkDj5mC7J7rMtPJx9EVQOZmAr1wn/stZGsfKl57grXSUfBCsgz0Ald2WrmL+vXNn6s0SrauoyYwaP7FOnsf5O0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=n+gkDL/O; arc=fail smtp.client-ip=40.107.92.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=naGoxVsb3mYmYL40IYcX+yeFf/igJzFJ94DLH9nM+oWLWYPmF9ioaqHlTGmdJXVULbc2U5E9dr4sKGixCJ2BX/CWCVcL1lX1lUDEtZXA9Cz23WJJTsWYiMXfNhj2gxilbYfdTetAfIWVC6e/SMyMdxtfbHbFB6wFBIzEo+w7+gVlhQj/r6NsVD0dHHBVHb2jvQabfsGy6pkPsCeJVhg4+ICUJhrTA0u0ATk4tjd39VBD49ORrF1kfeDFDMBM9FVD/LvAXcbzlDu6FP/HpIzN636ogDj6LWvS+VsBY6lyyRwcIts8jIlzG60+MVr+9JUoPsm71qxcjB7E7iRpbppRKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UObz4yhPm68suZapyNjpNBVe5LrHVFAD14LsGIpCPbk=;
 b=nrJtJcim28QLPKM1L+vjqxtw9i1OUckdfvOJQKNLT5jeK28PWJAZvDO2ReDiqPEKSMmV21kOUzsl74DwOJ3+h7pS84r0T7btXTDYhcRp0LtFF1JGZxMZ+buwm1U5FytqFGte1vMEm0dKmkV7AYbutUSEIvtK23ZfNBM/fPJ1uXSWXnKx1hntQGpI9R5Wdirlz22aNBmKdFEp7vVt5uV8EosNCck6FYc3iHThVWtpJgODO6x16nO8LQU0V41iS3qOgVK7OACJ7R+pTQzc56FXRspdUBg4DZbgMuo/mLGK0hrziuqdQbxgEQ8mm429MiHAWYpwx9MIgWN3flOjlVsojQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UObz4yhPm68suZapyNjpNBVe5LrHVFAD14LsGIpCPbk=;
 b=n+gkDL/OBpZCGVbse0iz38FPrVEf/KlQ+VnARQqvs5D6pkbkKi6+aV8aYXqbR7SlJlFRxAB9YYiF7/AkiA7KS7uKmtfBVwPnbCO3tAtGnSq7/W+PW7kSc6SlU/vWbR/IuCZPSJMmce7eq2IelvtC23Stk0Pbp/lT3JjuhtteRbg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SA3PR12MB9131.namprd12.prod.outlook.com (2603:10b6:806:395::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Wed, 30 Oct
 2024 14:15:45 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 14:15:45 +0000
Message-ID: <def42b17-0cf8-43cd-9ad4-ff43096d55c2@amd.com>
Date: Wed, 30 Oct 2024 09:15:41 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: RE: [PATCH v9 14/26] x86/resctrl: Introduce interface to display
 number of free counters
To: "Luck, Tony" <tony.luck@intel.com>, "corbet@lwn.net" <corbet@lwn.net>,
 "Chatre, Reinette" <reinette.chatre@intel.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Cc: "Yu, Fenghua" <fenghua.yu@intel.com>, "x86@kernel.org" <x86@kernel.org>,
 "hpa@zytor.com" <hpa@zytor.com>, "thuth@redhat.com" <thuth@redhat.com>,
 "paulmck@kernel.org" <paulmck@kernel.org>,
 "rostedt@goodmis.org" <rostedt@goodmis.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "xiongwei.song@windriver.com" <xiongwei.song@windriver.com>,
 "pawan.kumar.gupta@linux.intel.com" <pawan.kumar.gupta@linux.intel.com>,
 "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
 "perry.yuan@amd.com" <perry.yuan@amd.com>,
 "sandipan.das@amd.com" <sandipan.das@amd.com>,
 "Huang, Kai" <kai.huang@intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
 "seanjc@google.com" <seanjc@google.com>,
 "Joseph, Jithu" <jithu.joseph@intel.com>,
 "brijesh.singh@amd.com" <brijesh.singh@amd.com>, "Li, Xin3"
 <xin3.li@intel.com>, "ebiggers@google.com" <ebiggers@google.com>,
 "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
 "mario.limonciello@amd.com" <mario.limonciello@amd.com>,
 "james.morse@arm.com" <james.morse@arm.com>,
 "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>,
 "vikas.shivappa@linux.intel.com" <vikas.shivappa@linux.intel.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "peternewman@google.com" <peternewman@google.com>,
 "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>,
 "Eranian, Stephane" <eranian@google.com>,
 "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
 "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>
References: <cover.1730244116.git.babu.moger@amd.com>
 <265f3700ac0c0d33703806fdc3d096b08c992efc.1730244116.git.babu.moger@amd.com>
 <SJ1PR11MB6083AAE9ACC5EEC584E503E1FC4B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <SJ1PR11MB6083AAE9ACC5EEC584E503E1FC4B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR12CA0025.namprd12.prod.outlook.com
 (2603:10b6:806:6f::30) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SA3PR12MB9131:EE_
X-MS-Office365-Filtering-Correlation-Id: 44b76eb0-b89e-434c-2855-08dcf8ed5885
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RzdCS3pOMzFzVWwrZ3BSRytNdnRuQ0VLbGcrc094MkJDU1lNVXRuY2IwL1cz?=
 =?utf-8?B?MFhOdjQ4Q2JlTUs0YWx1eVFHbmJmQ1dEVzgzSS9Xdk1wUzl0ZW9uSnl2NzlF?=
 =?utf-8?B?TGlkTFpRUVRqSzFXVkNxUDYzenhKT21xMGJIZlJXNFZJVnJrVThDNjQrZnRw?=
 =?utf-8?B?SXl3alpSLzVxQ2Q4cVFNVEdzdHpjemJ1NFAvMktiQnN2eThzWjBTL3Q0eHhv?=
 =?utf-8?B?R3JDV2hrL2hxNTY1aTR5L0VxMFlSOFljRHhNKzRYWmNNOGh4SXpiSDFJSzJL?=
 =?utf-8?B?aVdBZGtrSVI0a083RmxTZE8weHdzQ0NXa21VQjlaUkduR2E3ZUJqQ3MzeVU5?=
 =?utf-8?B?ZmlwNHZaUnJHU2RxMVRnZ2tXYWZOUFYxS25EdnlyWkhFcEQ2VTlLUnJlZC9R?=
 =?utf-8?B?N1BWSnd2bnd0WFlyZmc3UDljM3FhRWF0emdUdHkxWVgza3ZyQVg0dHdOZkVL?=
 =?utf-8?B?cXNrR00zdFE3c3IwNXFtQVFCU3E1NWJYODZ1MHYzTGNGUmdyaGhGRnU0c1pa?=
 =?utf-8?B?dmd5RzhwUFpDYkVkNWxwcFFLRnRNdkxvQ2toc1hZVlNNZHAwOXBJSGdlN2FF?=
 =?utf-8?B?Nk1rYVBKaWZzdmlGaVZUZ1kyZjlOZTZmc05HWXVDaWR5b3ZIWCtpclpvTitk?=
 =?utf-8?B?MHdqMHdpcWhabnhqWVBQdGNmUTNRQ3NBekEwenlKV0pBMVhpYTIvUEthN0xN?=
 =?utf-8?B?QkprTjNlektHSVhteFlJV2lWZHdrTUwrV00yQ1BPNE90SEFxZWdJN3A4M3NG?=
 =?utf-8?B?anBzWlRKMUd5YXc2eDBLN21nREhzZjR2K3R3a2ozOVNuVnVrd01LcW42ZFhL?=
 =?utf-8?B?RldaLzBGR0ZGbkF3Rmdsck8zTWFwRlU5VUkxSFZQTVVxUytVNSthbS8ydmhF?=
 =?utf-8?B?cG4zekRSekREUHJuNWlPTVhXQ1RGdjE4SmNqeVExaDh4cWJuYXp2Zi9aZjdJ?=
 =?utf-8?B?NDVlT1M1YnR5NStLcEQranhzU0dpOUM5NjNYeGpod0M5Z0Q5VmwwdGpEU3ZU?=
 =?utf-8?B?b1dmNkh1NkJobXNkcmZUSlFDRnNGMVJZSkZmT2NGcncySWlaZWNYT1hKVmc4?=
 =?utf-8?B?ZlIxWE5Nak9hK3BLNU9icGxWQk5TQ0ZFYmRwWjJ1VzVlbHpIVkc4cHBzcHA3?=
 =?utf-8?B?WnFtT3VMZnEyb241LzJ6UHJKVHhiaTVDSlh1SGpTMEF2eWJqbXBWODc3c3FO?=
 =?utf-8?B?YlRKRHFqaEQycUg0WS9VNHJ3OE5ySjQxYURqc05yRVdNQVZpd3BET1BneGo4?=
 =?utf-8?B?WXZCT2E3ODk0QU42bWh1QlhTVSs0QlRyR0d5TmduZGVuQzJvc053WmFTd2Mz?=
 =?utf-8?B?eGx0QUxackVjekU0LzZCNDJ1cnF0VFJ2eGdLTHI5L0Y0UlIxaUo5WWJ3T001?=
 =?utf-8?B?elNiV0lTdjJqZDY0T0hQM2VUWWFlS3hGTUgrbTJ2MG1BcVgvNVZMZ0g4NDJC?=
 =?utf-8?B?WHdxMklrQTdSOG5wazV6RXdOSW1tMW5XcUM0Y1oxVk9rQjJjYUROWFpDejZq?=
 =?utf-8?B?SU5kOU5KNWZJMW9lVUQ0dTgwSWdvVTFGWkpOK2kxaDBRajBuVDc2Wmx4VmN1?=
 =?utf-8?B?RTloOGNlMmd1WXlaRlBzM0FoQXJPVGVTYUM4QmF4NUpnb3lNSGowOEhIa0Vu?=
 =?utf-8?B?V1ErWTBYcnlMMWU4QXh3LzQ3OHNBazAwTGxaOVVreGhnc2Q3dXdpZkNpVFgr?=
 =?utf-8?B?RkdxY2kzZnl4TmZQL2wwM2p6V1RqSmc0OENWcmhVV0x4em9UL09CNnNUeFBE?=
 =?utf-8?Q?V3SrP/qFE+nLEdYCFkRC2xfy+sngTs6kipzK68f?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WlNxWlV5ZWJKYUJIZkhsZEpHK0NQcktyVlBleHdvVE9Yc0o3aVlDaDdPVGpq?=
 =?utf-8?B?YWYwdUpheVhuZFJnZUVYK2lwRjFJbE1FOGdJb3VOUW5XTkhsOHQwMmdUYXdk?=
 =?utf-8?B?UFN1cHhQWnNkZWdxeEk0bUNYbFZDQzEyZGk1eFAyMmtmQ3Z2Umk1R0YrY3lL?=
 =?utf-8?B?cW1qMW9kVzFYcXBJV1Y3aG5qMm41SHlGdWwxV1NGZm9MeFF2bndqemtpaEJO?=
 =?utf-8?B?STZBcWFGcmJXdU4ybnUzdTMxZUt6K2dzVllxNVdoNXhXL1RYd1JpRmFFRkM2?=
 =?utf-8?B?aFRpdjdkSjZEYU45VVIzZExVUGkxaHlDRisrM2lQZ0g5Y3NSMk1EVmhHQTJq?=
 =?utf-8?B?bzlHQk9XUkRoa3VrY2dRMFZ0Ymw2cDFiUHJUQzRLbW5SVDIrUGNvU2xSdkxo?=
 =?utf-8?B?NDJKWFFTdGlTU0VPdFZ3VVc2OHFjSVhHTkFvOXBNRktuVmpFTTVwY1oxclQz?=
 =?utf-8?B?Z0FqdmFMZmdZcVJYY093dmVjeCtJVHl6czMrT3VVbzBtVUlXTEErUkxJNGdT?=
 =?utf-8?B?MjI5WjhFVEZ0dTlyZUxFYXlYNkhFT1BWelBrOUwyRDRxU0Rza0JGQWlGMXZY?=
 =?utf-8?B?cFdWK1NYRGx6MlJtNmJZOHFCQnZKWmJOS2Q0aVltOUlkek82aWpIYnIxS2ZV?=
 =?utf-8?B?cXVlYU1JVXk5Wmg3Y1RMV1liRUZZOHh6eC96Tm1Qc0NMdFZCYzhCbHZZeWNv?=
 =?utf-8?B?MHRrRFoxZ1J2Ym5ZVEQ4MGVvZThuM0NBTFdKbTBDN3gxNysvbkJZaWpFeGUr?=
 =?utf-8?B?N0Q5Y3M2Zk56dTNETzR2M1dhMHp6TzRRY0g5bzY2NHE4b3VmWHNzTTNmQUsx?=
 =?utf-8?B?eURRWEtVYTFRRiswMklZNmdtNXlIZFFWbW5LRVF4VUJ2b0c4Q2tOTGsvZlNH?=
 =?utf-8?B?eGp2elliakFMQW5ySGZ6NW11RTh2Z2grZ2Rud0FZUFZ2T2VVVkoyS0RkQkpj?=
 =?utf-8?B?VENvUnlRVE1XUnVwTkRCdlQ0VlExM1Qwbzg4eHVkaFZDMmNCWUZwNDRYU2Z3?=
 =?utf-8?B?OGVLMVYvVGZncmVaNS93WWt0aytIZGZmaVRlU3QzZ0JCMExDQXdHeFN5NkRl?=
 =?utf-8?B?UEpwbVJXNkd2RjkyQ1Nhc1o2a21QbjFvbUtLdFhxL1VjS0I1ak1BdnprV01S?=
 =?utf-8?B?ZTZqa1pTOFJCWWVnanVjMkxNRHVUbEJTMDEwYTl5TVZuV1VQMjI3U3BVL1RY?=
 =?utf-8?B?ejcyalZYTHh3MnVqVENuVnY2dlJnU29UVm53YVZMSklBQXlURzAxeTlOUkxF?=
 =?utf-8?B?WWpXTVZnOTA0Yi9XQURqZHhLRndlYldoMWJMU2lKL0dSYnZQNTF5bHI2VEhz?=
 =?utf-8?B?VTBSNDErV3lhdU45by8yMmZkaHVoYmMreUpOVzFScXhNUk5WY0g3TnlKSFdl?=
 =?utf-8?B?aVJWZnpJbUwvRmVOcHNNZDh3R25iUVdsQVBFS3NHcjBBSGxqQ1crTnRvK1V0?=
 =?utf-8?B?TG52NENiRERBeE9FNU0vMUY3TS9HVFdjTUZrTDY1SHd3c040RnRWaWRvWE5k?=
 =?utf-8?B?bTd5Rm1wdW44amQvMkFNWUNvUnF2cFFwVS8wc3JWY2lHQ202UzlSNS85bk5Y?=
 =?utf-8?B?VFFncW53czlZUTdCVGpwTFpjRVBWclRPL3RFZC8xTVQ5Z0RsUTZyckdVOGd6?=
 =?utf-8?B?UVZQditaVmd1cExzZVNnVTd2UTFWWlhyT1NMb2tjcWgrWjJ2SFV5aVc5WG4w?=
 =?utf-8?B?UzJzeHhCZW4vbXRIMDBEMTdqSFV5eUloNTZLZVdRM2VXSW1reWxuQU1KMnpV?=
 =?utf-8?B?dVNKOHh6eWFuTHBZeE5CazhDeEVCQ05PMjd3amxDS1lkc2JoVVlZTHJWdkdK?=
 =?utf-8?B?OVdSTXhxaFIxRjl2VGY0Z0J4ZHdMeWRxNiswUnVVRFZRYWFXRWI5RjRjemwv?=
 =?utf-8?B?eWRWVzRWSXpyeUdGdWF3YTdsOGttbGc5NzJObUNrZFJuNjVYQ0ZVUUppS080?=
 =?utf-8?B?MzQvQkJ0dHpXRkp2d2NmMlFYZEtrZE9PVmIrZGxJZEU1MWN2RVFGNUVzVmNL?=
 =?utf-8?B?U0dlQ3hXaUxkenlRWEEyTTB6SnBWYVhubkxVc016Zks5K01VcElWaXdEeTBZ?=
 =?utf-8?B?Sk8xMzBFYlB1RkpLWmRrelVJUHJPSnJPTEdLY09XR2FiT1dmMEJuTDVudkdq?=
 =?utf-8?Q?WMWY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44b76eb0-b89e-434c-2855-08dcf8ed5885
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 14:15:45.8085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aAfR4ucrTa6htpLgaj9ITC6xDLau86ldnHSgi6Ie/j6mrPTI9UbjVLq6rjj+2EjH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9131



On 10/29/24 18:57, Luck, Tony wrote:
>> Provide the interface to display the number of free monitoring counters
>> available for assignment in each doamin when mbm_cntr_assign is supported.
> 
> s/doamin/domain/
> 

Sure. Thanks

-- 
Thanks
Babu Moger

