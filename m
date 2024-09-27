Return-Path: <linux-kernel+bounces-342025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2348F9889C1
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 19:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80B4BB21FF0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 17:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71AB11C0DF1;
	Fri, 27 Sep 2024 17:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="W7cv5RxZ"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5591714AE;
	Fri, 27 Sep 2024 17:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727459250; cv=fail; b=PlbWcfEcStlTdqv2WGhbgCD0w/Q4X65Q3RsEf4UkJeKvBoEuzaXVAF4bmHcgI4lgx2ydhRzQ7VqwfCTqlDplZyJICmxxbyFVTenO8rhdFzDxiQlYIVUCHhtlOpVMH57vIhe165AR/YqoZQMGCwsHx92VVKtskfvgiAgU5/2zX+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727459250; c=relaxed/simple;
	bh=/CB7FMJriypFmFFy+sCv39dfM5kUPzT8/aQum5yIHBc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c6JZYYm+03GG5Yhfl3qwzMDttWu0vaMtxGJx1TpWkXDkG7It3nGR6Wl9/sQDY8hhxYwLHbnYDSGyMkgdDfW3X0HI/dh9Fs0hu4rJSTiVLFNFxCr5uHUSmoyxZa3xh9pOqAPmm8K7N8mKOU1pS5oyeav2R1Qp7A9LKxAXf0V2gNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=W7cv5RxZ; arc=fail smtp.client-ip=40.107.237.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mjaP/HRQzx98zQOzcGH8gMuZPjhI61s4UZFoORBKekCoczJPP218pv0UdJkxx5Ng/Tt5NDCuekGaUetmeWmxwIJybkgzAGREMcZlhdG61uYn20LTBEsKAYtcvAIQQC0DHOkqZFZ13vJrRAG9eV4XmSm20g9IGkAXw/2h/TviF62Pam5ZJhd0vTykO1BuYyZk/U3wTIJ16Hk37NhjVifIyciCw2iIxI5xttu1BRu7Ej00rxW94ijWncaWs7KPnaQBn8MKD7JSPJ6ERgvSIauWE3EZqUpPrLvIMvYNjxMXPHqG/lPjn+HtOW7FGZ7x0VUXZHTcHCUwj3jpsM/hH8Qb9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y8BEKuvlbcROKqND7TwUAzdJh3GhLZmaROVkqRzWiL4=;
 b=HvUQbtW6vJj7JYjJGOO27PM2uC5bWxTiLR/06g6RExsNhSCwBQW7+W6CFng/PSlJcnJHCL6gEHt5sE0MgzZQA+m0h5MZy+iM2Y9Dvcjel6cmgnr8b/IEM0AgIacwMYlJAIs7u80ric5LMsaED33v9IFjB+tnYNwJmKdkThVq/lWoRdMTcNe4NWCPqHIZR7JB/MFa6kv8Z4y5BSbGHoNMWy+FnEfWdUNdEVhRZC27vglygEUSdutkD777JGWtCGslOMO+PoQKx9RaX+b4glAzcj/8F5Db7qQo57ODE0f6j6YACvdApFitKgGHcwJ/z8VAXASbpk7hJGRGfWtRaWv2BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y8BEKuvlbcROKqND7TwUAzdJh3GhLZmaROVkqRzWiL4=;
 b=W7cv5RxZ3ZkRJAdY7Pp215g66Mgwpjmy3YH6GOrO2ZTResFDEx6tQoN8W1mZt0mzBcHPbJnz3Rrywznk58pRw5VYUmSyZUCFqbkGiSaaJniJ4vPtPSnuNoum92CZWESfNgRtpcTdr2J6V24K1o5pId6ebkySCG5Hmy3xQBD+lOE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by MW4PR12MB7239.namprd12.prod.outlook.com (2603:10b6:303:228::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22; Fri, 27 Sep
 2024 17:47:24 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::d22d:666e:be69:117f]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::d22d:666e:be69:117f%5]) with mapi id 15.20.8005.024; Fri, 27 Sep 2024
 17:47:24 +0000
Message-ID: <c43171f4-48c6-b6c3-d71e-1f23367932d7@amd.com>
Date: Fri, 27 Sep 2024 12:47:21 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v7 24/24] x86/resctrl: Introduce interface to modify
 assignment states of the groups
Content-Language: en-US
To: Reinette Chatre <reinette.chatre@intel.com>,
 Babu Moger <babu.moger@amd.com>, corbet@lwn.net, fenghua.yu@intel.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
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
References: <cover.1725488488.git.babu.moger@amd.com>
 <68c8ef0592c653c5b99cd26d982966cd4a41cb31.1725488488.git.babu.moger@amd.com>
 <faf50d1f-d3c1-4a9b-a87f-4598e88dc9a1@intel.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <faf50d1f-d3c1-4a9b-a87f-4598e88dc9a1@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0062.namprd12.prod.outlook.com
 (2603:10b6:802:20::33) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|MW4PR12MB7239:EE_
X-MS-Office365-Filtering-Correlation-Id: e2e83bc2-7deb-4c52-529e-08dcdf1c720d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NHYrc3Q3alNwNjBZaTl3NGduaWs0V1hBMCtlZFE1SWtFYkM2ZmhtaDZrM0NJ?=
 =?utf-8?B?OFJYOHZtdzlmVW5lVU5vYTdxUGYxcTA4dGI4a2pMYUt5d0t6NStaT2taOTBF?=
 =?utf-8?B?MFEzMVo1Q3kwUVh3Q2FaY1RYMkVyWUxBVHhNaEROZVdVeUdLNlNyQ1RVWGpI?=
 =?utf-8?B?TVFxM29PeEFjdVlnYmkwbFlHcklKdmxNVjdoRHdYelF6VFhHdFU3K0tUcmRj?=
 =?utf-8?B?VjdGZnhkR0tVVUU1bjFtSUJxZVV0QkpyeHNOVUpwdDBMYmtJMlV5NjdlczNN?=
 =?utf-8?B?WFlGYzdiekNNK2p4MGtqc1RESE5QNUFhZHNPU0lhS0tqdHE1YTBkSEdMbnBj?=
 =?utf-8?B?b1R2amIvaTVMVG1PN1YraUhzc0cxQ0NYaTZzSERSS1B0RkFJWkxpQUdnUUkz?=
 =?utf-8?B?a2xpK0NzeURtK1N6QmJoUmxic0k0WXpVRlVNb1VIVmh2c09GalNnT0ZsOHF4?=
 =?utf-8?B?N21yQWJUQnFJZnVpdHFRSEd4WndqUGJWek1Yd2lONTJ5USs4eWlkZzRhSlJy?=
 =?utf-8?B?ZTNmMlV3QmhqVHZFdkI4aHFVdWlheFFqZzh6b0NrUXNlV2lHR2RFaXIzQU9s?=
 =?utf-8?B?amZEbngySkxOU28zV20ySDZBRmk1ZmJuSWM2NkhkYVRUTFlmZHoxR0dVL2Vm?=
 =?utf-8?B?c2tvYy9sS1NYYkt1cEhzNm9iOGxJL2YybHhFQlFCVlpTTlVhRDg0MFNiM1V6?=
 =?utf-8?B?ZEZLem9EZkRaZ0o3cGQxQ3l2WFdGUWVoNitPeUpUMTg1MW1LTzJsdWNSMGpV?=
 =?utf-8?B?aUZZVWc0ell4VTRvMFo5Rlh5emFxS0p1VmVLR0FheUFiNExMb0l4eDlyM0kv?=
 =?utf-8?B?aGtiUmVTVFZJTno3UDN0K3JpQkdwMDIzMEt1SkJUVFVkR1Q1TmZRVUt2RHQx?=
 =?utf-8?B?Z2M1KzlJWk1CREZFQWZQSzZ6dVFsL2hLM21MRGFxaWpvem5hSmRSMStzYlA4?=
 =?utf-8?B?RGJoRFNPYnNlcW9Qa0FiZnNvWWt1RWxmSXFXSFdPMFRNMGVTL2RIQklLM1kx?=
 =?utf-8?B?UlhzaXEwbDJ2ODdCRE9jSHRDSERPdjZCTHN1aDU0cnhhalhuSTE0T09qSG1B?=
 =?utf-8?B?R1pnMGp1TVhJTk5yRWJPTGNSQ3ZvN21YQXNZUDJwWmptZVFDSmNKTnBKOERU?=
 =?utf-8?B?VStQYi9mdVB5S1B4Wm8rWE9QRnFFcjZzNzIrcllZZ1dROE42VUt3Z0JBVTRZ?=
 =?utf-8?B?dHNzdEl1b1lEMmZaZDBDYkRwNk8wK2ppT25waTR4Q29OMlJ5aTBLeCtIWUhm?=
 =?utf-8?B?RmZQaTM4QURScnN1RUlNS0FLYVA1bFRHcEVBVGhKWkFrZEx1a29JaFNZRDJs?=
 =?utf-8?B?b2J5YUt5VkppYU0ra2NmRjF4Vm1mRWlmUjdTTkRmM0hwSTFHNm1oczFiZEhp?=
 =?utf-8?B?cENSODB0OVVhUkkrQUptQTNaMEdXS1VIZFVXRnpIK1k3RjZQTTlGVkhYeWJo?=
 =?utf-8?B?TmxWNXNUL1dpRVhWMy9TbnhQNlcyZG1EcmkwSzZsK2pZUUdDZ1Rtbjd4R2Z2?=
 =?utf-8?B?T2tOcWY2RzlXbW1XN2xqbGZFWGVobHBhRG5hZmJGNDZFOE85aTlxR0lIdENy?=
 =?utf-8?B?ZnhwdCt3ZXBlT0x3Um1CWkplenVlVWk3Q21vNUVldGs4NUN1L2RiTmFlTU0x?=
 =?utf-8?B?YlRCNy90TStpSG5VRnNmdEhSNk8rS05LdjBNZHBUcnF3YnZsem5TSDE2dEhx?=
 =?utf-8?B?ejNiTWF3cDBIYUwyVjcwYWJFamZWZ09XYVhqamxOZk83NEdHZ3p2TUxRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WlpFSmN4WlZBYWZaNHNnZUEwaFNQNThUeGlRMS9tRklDaHJUeTNYcWRTYjI1?=
 =?utf-8?B?YTZQbnpOUVJEY0tlcDB3Sm9Ka0k4Uy8yQU4vSUlJWWxXeUt6YzlGZCtPN2gr?=
 =?utf-8?B?eUlHVTFuTlpqYUJnUk9lM0dMOXI0c3I5SVRXa3UwQ3FrS3FmQ3NWc3NPdlRz?=
 =?utf-8?B?UzR1R3RKajZYTnd4MFBibS9jSUlBUWlBL25VV2h3N3BOd0ZJUFFGNGZYWEpk?=
 =?utf-8?B?L0NtSnBvd3V6czM4NFlXRWd0R2thdmtsUUFuWFdqQmhVOHhoZUZTS0xOYlEr?=
 =?utf-8?B?bkVsV3hpODlaamVFS04xMUhBN0htL1A2UnQ4UElGQmE0SkxsTE1FZXE1SS9v?=
 =?utf-8?B?ajVnSXdxUU9MaGJzUXR1QWpOcnEvd3dwQ1QwRGZWMkVmSmJUSWVPUkpXcGFS?=
 =?utf-8?B?cDI4d1ZUejNQUFBlQmlieHBBZnY3RCtuUTJLZVRIWUd4Wk9Fa0lObWJWQWNr?=
 =?utf-8?B?eHBpNkxxNnF1K3l1MGc5TjM2VmxWTVpmbmYvaW96eG44N0FJSEJWN0wxb1lx?=
 =?utf-8?B?VGFTWXl2NDZuUTBOVk11V1hUOXhMQkdodDFKMTdwMTJuaEZrWUc4KzVLZ1Jr?=
 =?utf-8?B?TGpmZXM2aFR2Zy9yRFFaVHUzbVBCTWZTdFZrVmpnZDhtUFl6Z3lOSUZPcDlh?=
 =?utf-8?B?QVR3aFBQZ1l5QldYS3Y5YU5WNjA5VHhYdG5QK2d3Y3RhZEpiMk45T0d1YWJO?=
 =?utf-8?B?MXJrUGxyTnI1Ny82NzJaZ2VXd0JrSTRxckNoQ00wVFNqUTAxbWhsNDREUjFV?=
 =?utf-8?B?YkxiVUdzTFJidmpvNFBmVW9od1JTU2pHUlpCUUpKeTVyVnZOdUFTTHlFNmZz?=
 =?utf-8?B?bmxZS3FyR1Rudm9VWlAzdy9EbjNtVlVIRk55S3BvbEpqQ3V6OGo3dlpjNWMx?=
 =?utf-8?B?ZVJaYi9nVUV5SXlrUE5TQlNhKzZhV2hNQkZUT1lsOEdaYTR0UEJQUCtNNWln?=
 =?utf-8?B?Zy9ZZFBEMXJTaFNnb3FxWG9UOTJZR21ubVhHY0Q1a0lSOWhJaldKRGdpay9y?=
 =?utf-8?B?N3RsUlkzTHV5Z0JqVTFLYUI3dTBKcFdIblJtb2lCQ2NoamZ5T0Y1clFLS0FV?=
 =?utf-8?B?NlNuS3NJdURiYWxqcWExQ3dkSm10KzR5UGw4L01XeFBXbWxVYXJnYlcyTTlx?=
 =?utf-8?B?U2hWSmdVUkFxK0FSRWFQSXJJUDVKeXh3SDZ2ckFsU1dvOVZzZy9OZXJSalN4?=
 =?utf-8?B?ZkNETFdZVHA5TFlaMllUeFVsUmV5VlNpT1prcC9Cc1R4NjBRMGNyUmdDQXJM?=
 =?utf-8?B?Tmh1ZFJVVUZ2NmU4LzRXMG9FV2E1eTZETm5GTXJtUUVDaC82MG5yNnJ1Q3E1?=
 =?utf-8?B?bWZUQTBuZ21Ua0Qra3BoWUF1a0RLTlVEK3ZLam5ld1RXeUlXK2s2TTB2M2NE?=
 =?utf-8?B?Mm8wNWlKZ1dQUVF3d1NjRE00TUNudkpFRWloTHhwZGJJQnVjSEY4MEhWU1dv?=
 =?utf-8?B?VC94RXF6NkhrcHVacDBheXZtaUd3VGdmLzc3NlFEem5ub2tKTzFqamxaZVRz?=
 =?utf-8?B?dEZSOE0wM3VBcWhrVWt2QjJWSGI0SGtXWGt5L292NFRXVy85Z3JiOE1WTzl0?=
 =?utf-8?B?NmVqYllqeitrZW50UnIxL21iSDYxMkttZmFkNkR6VkExU1dBZ2daWVcrNUFT?=
 =?utf-8?B?MVIxWTBwaUhYcW1HY1BGRkdTQk9Ld2pCajk5V1NDYXlibTdoVCtwMTRlTUNZ?=
 =?utf-8?B?djhaWFhOWkVVcmZXWSs4N0lZOHluT2hVaExwU1RnclFwQzFyNW5rSTJOU3lh?=
 =?utf-8?B?U3dPd2FmaDdneGFaSGdhMFlmeUpWUVlrMWswd0d1alNudHVhN09wQjhXN25Z?=
 =?utf-8?B?b2VoV2dMelR0ZEJsaFN3eDA5WkxteHl3aDV3aDJxdUF4ZTRVeWEyTHRQa1Ex?=
 =?utf-8?B?Z1RJTGtGK29xaWVMQkFad0ZWa2V2OGRpcHlOOUt0L1BVdEZ0aUJUMnJnRFZh?=
 =?utf-8?B?N1c5enBUYURDU3pwUit5NTRCaEVvbDBsSWozZjEvUHlaS013WVRIY1lCaGor?=
 =?utf-8?B?eTgzSm1aSDRIMmlEbytWc3MxT0wwNEJKemZEZ3h4OSs0L3IrR3FVNVlCMzdK?=
 =?utf-8?B?M0hoOWNCaW5ibStrOWMzSWk2cTBYZ01QR2g5Y0JwRGp1dTJBaWQ2VjB1aDVt?=
 =?utf-8?Q?ddHCs+c206E03LeRKDpb4SIEe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2e83bc2-7deb-4c52-529e-08dcdf1c720d
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 17:47:24.6563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mTZ+kx0qvjUZkHTEFfVegAyJIvZWO42elLharDc7lAa1HD05f2gRomTc1mJ2Fjw+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7239

Hi Reinette,


On 9/19/2024 12:59 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 9/4/24 3:21 PM, Babu Moger wrote:
>> Introduce the interface to assign MBM events in mbm_cntr_assign mode.
>>
>> Events can be enabled or disabled by writing to file
>> /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>
>> Format is similar to the list format with addition of opcode for the
>> assignment operation.
>>   "<CTRL_MON group>/<MON group>/<domain_id><opcode><flags>"
>>
>> Format for specific type of groups:
>>
>>   * Default CTRL_MON group:
>>           "//<domain_id><opcode><flags>"
>>
>>   * Non-default CTRL_MON group:
>>           "<CTRL_MON group>//<domain_id><opcode><flags>"
>>
>>   * Child MON group of default CTRL_MON group:
>>           "/<MON group>/<domain_id><opcode><flags>"
>>
>>   * Child MON group of non-default CTRL_MON group:
>>           "<CTRL_MON group>/<MON group>/<domain_id><opcode><flags>"
>>
>> Domain_id '*' will apply the flags on all the domains.
>>
>> Opcode can be one of the following:
>>
>>   = Update the assignment to match the flags
>>   + Assign a new MBM event without impacting existing assignments.
>>   - Unassign a MBM event from currently assigned events.
>>
>> Assignment flags can be one of the following:
>>   t  MBM total event
>>   l  MBM local event
>>   tl Both total and local MBM events
>>   _  None of the MBM events. Valid only with '=' opcode.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>> v7: Simplified the parsing (strsep(&token, "//") in rdtgroup_mbm_assign_control_write().
>>      Added mutex lock in rdtgroup_mbm_assign_control_write() while processing.
>>      Renamed rdtgroup_find_grp to rdtgroup_find_grp_by_name.
>>      Fixed rdtgroup_str_to_mon_state to return error for invalid flags.
>>      Simplified the calls rdtgroup_assign_cntr by merging few functions earlier.
>>      Removed ABMC reference in FS code.
>>      Reinette commented about handling the combination of flags like 'lt_' and '_lt'.
>>      Not sure if we need to change the behaviour here. Processed them sequencially right now.
>>      Users have the liberty to pass the flags. Restricting it might be a problem later.
> 
> Could you please give an example of what problem may be encountered later? An assignment
> like "domain=_lt" seems like a contradiction to me since user space essentially asks
> for "None of the MBM events" as well as "MBM total event" and "MBM local event".

I agree it is contradiction. But user is the one who decides to do that. 
I think we should allow it. Also, there is some value to it as well.

"domain=_lt" This will also reset the counters if the total and local 
events are assigned earlier this action.


> 
> 
> ...
> 
>> @@ -352,6 +352,98 @@ with the following files:
>>   	 There are four resctrl groups. All the groups have total and local MBM events
>>   	 assigned on domain 0 and 1.
>>   
>> +	Assignment state can be updated by writing to the interface.
>> +
>> +	Format is similar to the list format with addition of opcode for the
>> +	assignment operation.
>> +
>> +		"<CTRL_MON group>/<MON group>/<domain_id><opcode><flags>"
>> +
>> +	Format for each type of groups:
>> +
>> +        * Default CTRL_MON group:
>> +                "//<domain_id><opcode><flags>"
>> +
>> +        * Non-default CTRL_MON group:
>> +                "<CTRL_MON group>//<domain_id><opcode><flags>"
>> +
>> +        * Child MON group of default CTRL_MON group:
>> +                "/<MON group>/<domain_id><opcode><flags>"
>> +
>> +        * Child MON group of non-default CTRL_MON group:
>> +                "<CTRL_MON group>/<MON group>/<domain_id><opcode><flags>"
>> +
>> +	Domain_id '*' will apply the flags on all the domains.
>> +
>> +	Opcode can be one of the following:
>> +	::
>> +
>> +	 = Update the assignment to match the MBM event.
>> +	 + Assign a new MBM event without impacting existing assignments.
>> +	 - Unassign a MBM event from currently assigned events.
>> +
>> +	Examples:
>> +	::
>> +
>> +	  Initial group status:
>> +	  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>> +	  non_default_ctrl_mon_grp//0=tl;1=tl;
>> +	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
>> +	  //0=tl;1=tl;
>> +	  /child_default_mon_grp/0=tl;1=tl;
>> +
> 
> Similar to previous patch, looking at this generated doc does not seem to reflect
> what is intended. Above and below are all formatted as code, the descriptions as
> well as the actual "code".

Sure. Will check again.

> 
>> +	  To update the default group to assign only total MBM event on domain 0:
>> +	  # echo "//0=t" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>> +
>> +	  Assignment status after the update:
>> +	  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>> +	  non_default_ctrl_mon_grp//0=tl;1=tl;
>> +	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
>> +	  //0=t;1=tl;
>> +	  /child_default_mon_grp/0=tl;1=tl;
>> +
>> +	  To update the MON group child_default_mon_grp to remove total MBM event on domain 1:
>> +	  # echo "/child_default_mon_grp/1-t" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>> +
>> +	  Assignment status after the update:
>> +	  $ cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>> +	  non_default_ctrl_mon_grp//0=tl;1=tl;
>> +	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
>> +	  //0=t;1=tl;
>> +	  /child_default_mon_grp/0=tl;1=l;
>> +
>> +	  To update the MON group non_default_ctrl_mon_grp/child_non_default_mon_grp to
>> +	  unassign both local and total MBM events on domain 1:
>> +	  # echo "non_default_ctrl_mon_grp/child_non_default_mon_grp/1=_" >
>> +			/sys/fs/resctrl/info/L3_MON/mbm_assign_control
>> +
>> +	  Assignment status after the update:
>> +	  non_default_ctrl_mon_grp//0=tl;1=tl;
>> +	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=_;
>> +	  //0=t;1=tl;
>> +	  /child_default_mon_grp/0=tl;1=l;
>> +
>> +	  To update the default group to add a local MBM event domain 0.
>> +	  # echo "//0+l" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>> +
>> +	  Assignment status after the update:
>> +	  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>> +	  non_default_ctrl_mon_grp//0=tl;1=tl;
>> +	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=_;
>> +	  //0=tl;1=tl;
>> +	  /child_default_mon_grp/0=tl;1=l;
>> +
>> +	  To update the non default CTRL_MON group non_default_ctrl_mon_grp to unassign all
>> +	  the MBM events on all the domains.
>> +	  # echo "non_default_ctrl_mon_grp//*=_" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>> +
>> +	  Assignment status after the update:
>> +	  #cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>> +	  non_default_ctrl_mon_grp//0=_;1=_;
>> +	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=_;
>> +	  //0=tl;1=tl;
>> +	  /child_default_mon_grp/0=tl;1=l;
>> +
>>   "max_threshold_occupancy":
>>   		Read/write file provides the largest value (in
>>   		bytes) at which a previously used LLC_occupancy
> 
> ...
> 
>> +static int rdtgroup_process_flags(struct rdt_resource *r,
>> +				  enum rdt_group_type rtype,
>> +				  char *p_grp, char *c_grp, char *tok)
>> +{
>> +	int op, mon_state, assign_state, unassign_state;
>> +	char *dom_str, *id_str, *op_str;
>> +	struct rdt_mon_domain *d;
>> +	struct rdtgroup *rdtgrp;
>> +	unsigned long dom_id;
>> +	int ret, found = 0;
>> +
>> +	rdtgrp = rdtgroup_find_grp_by_name(rtype, p_grp, c_grp);
>> +
>> +	if (!rdtgrp) {
>> +		rdt_last_cmd_puts("Not a valid resctrl group\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +next:
>> +	if (!tok || tok[0] == '\0')
>> +		return 0;
>> +
>> +	/* Start processing the strings for each domain */
>> +	dom_str = strim(strsep(&tok, ";"));
>> +
>> +	op_str = strpbrk(dom_str, "=+-");
>> +
>> +	if (op_str) {
>> +		op = *op_str;
>> +	} else {
>> +		rdt_last_cmd_puts("Missing operation =, +, -, _ character\n");
> 
> "_" is not an operation.

Sure. Will remove  this charactor.

> 
>> +		return -EINVAL;
>> +	}
>> +
>> +	id_str = strsep(&dom_str, "=+-");
>> +
>> +	/* Check for domain id '*' which means all domains */
>> +	if (id_str && *id_str == '*') {
>> +		d = NULL;
>> +		goto check_state;
>> +	} else if (!id_str || kstrtoul(id_str, 10, &dom_id)) {
>> +		rdt_last_cmd_puts("Missing domain id\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* Verify if the dom_id is valid */
>> +	list_for_each_entry(d, &r->mon_domains, hdr.list) {
>> +		if (d->hdr.id == dom_id) {
>> +			found = 1;
>> +			break;
>> +		}
>> +	}
>> +
>> +	if (!found) {
>> +		rdt_last_cmd_printf("Invalid domain id %ld\n", dom_id);
>> +		return -EINVAL;
>> +	}
>> +
>> +check_state:
>> +	mon_state = rdtgroup_str_to_mon_state(dom_str);
>> +
>> +	if (mon_state == ASSIGN_INVALID) {
>> +		rdt_last_cmd_puts("Invalid assign flag\n");
>> +		goto out_fail;
>> +	}
>> +
>> +	assign_state = 0;
>> +	unassign_state = 0;
>> +
>> +	switch (op) {
>> +	case '+':
>> +		if (mon_state == ASSIGN_NONE) {
>> +			rdt_last_cmd_puts("Invalid assign opcode\n");
>> +			goto out_fail;
>> +		}
>> +		assign_state = mon_state;
>> +		break;
>> +	case '-':
>> +		if (mon_state == ASSIGN_NONE) {
>> +			rdt_last_cmd_puts("Invalid assign opcode\n");
>> +			goto out_fail;
>> +		}
>> +		unassign_state = mon_state;
>> +		break;
>> +	case '=':
>> +		assign_state = mon_state;
>> +		unassign_state = (ASSIGN_TOTAL | ASSIGN_LOCAL) & ~assign_state;
>> +		break;
>> +	default:
>> +		break;
>> +	}
>> +
>> +	if (assign_state & ASSIGN_TOTAL) {
>> +		ret = rdtgroup_assign_cntr(r, rdtgrp, d, QOS_L3_MBM_TOTAL_EVENT_ID);
> 
> hmmm ... wasn't unassign going to happen first? That would potentially make counters
> available to help subsequent assign succeed.

Good point. I will change the order.

> 
>> +		if (ret)
>> +			goto out_fail;
>> +	}
>> +
>> +	if (assign_state & ASSIGN_LOCAL) {
>> +		ret = rdtgroup_assign_cntr(r, rdtgrp, d, QOS_L3_MBM_LOCAL_EVENT_ID);
>> +		if (ret)
>> +			goto out_fail;
>> +	}
>> +
>> +	if (unassign_state & ASSIGN_TOTAL) {
>> +		ret = rdtgroup_unassign_cntr(r, rdtgrp, d, QOS_L3_MBM_TOTAL_EVENT_ID);
>> +		if (ret)
>> +			goto out_fail;
>> +	}
>> +
>> +	if (unassign_state & ASSIGN_LOCAL) {
>> +		ret = rdtgroup_unassign_cntr(r, rdtgrp, d, QOS_L3_MBM_LOCAL_EVENT_ID);
>> +		if (ret)
>> +			goto out_fail;
>> +	}
>> +
>> +	goto next;
>> +
>> +out_fail:
>> +
>> +	return -EINVAL;
>> +}
>> +
> 
> Reinette
> 
> 

Thanks
-- 
- Babu Moger

