Return-Path: <linux-kernel+bounces-382557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F76C9B0FCA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 22:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4AFEB21DFC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 20:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10A7139CFA;
	Fri, 25 Oct 2024 20:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0KwEFCD3"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0A320C334;
	Fri, 25 Oct 2024 20:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729888303; cv=fail; b=r9lYtczIkCdEZvWRk/WLMqZfXsG5FbO3olesGzDskXq/STOe28fEPX9GWZSpbMf6j27w5kJAunuh7ZTbf/6C2z3qWqp0miQ9ugL5Zg+K4Ta9SPwEF1rmAaPHrP9x7e9f+uF6sjJs3nnSQY19TUoGdr9zl049Y4OVA8SVpet9kM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729888303; c=relaxed/simple;
	bh=DPCb+hGwv9Z0dBe/HNHrqyIKFn4KbQAn9Gm7V2rUUqQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e8fGP3+vvUu55bmC2vfPuNrcQatVXQrrU2mt4s7PCx6bX5nQG7ZHvlcDw8wcHQePVmXkd6wS8np7S752k0XYSAILp35555DM10DFKAVXhDiWXUO/f0nOnIgIVao+CbZ1fnGoXIySmVAnevqX30GwJ7CUgfWDEPbEagUrOsQJtFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0KwEFCD3; arc=fail smtp.client-ip=40.107.92.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E8XThTKzeOPHgSYSmfd+hu9vZ4LJmk43uqp1Li2lNefOLLDy59m6CZtgJ7iIJIa2vc42mYET2tb6cBCdKKIksUJ7e7NMK9cg/p1tMcT1OUZjmhJxH+KRLYKsD5tb/3Q0FzUlaQRcw3asTJDfnE1tXeb+3GZbkMPor6N/hpq4iAUzf95h9FkUR48GBh7YmGWT8EC4g5IUsqf4SbP5OMMWXcqFeIvCdX89rg3eBDQW7c7TSP4nAzE5ZVAi0n1toU/OQrkG35LYNM0tTOeFc/Rrq2CwwW0RQkwj9C9o5831jvTCACQsDigbaSR/HBEu5+zKVBQsZ80X716pERLOVWn9Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LRpOW7C6QVgrHV+NE8BEHqUEAi7QPT/aR1cNTM7VuOM=;
 b=Ytr9w83xGALk9AIoWwSecWEIWSW6lju+uUbNWdQQVkk+S3YgxNNyupCU/2mTkDnzFy1qR5V8/9llD5lj3FPbZiUExxUUwOBbXpdU2rtgno2zuVRen39vj6zEBu2LFwMpz68aYNy+BT3hxpA3Orkk9Em5oZYn3QOValduGDyLSXLd7x+t/i749T8fI/Z+jSt32uS08iweXmaptOqdtm41y/v4entu0/mG6x8EwsvctSptciBc9+odGM3NC5E/yRpDeFY90+ftRrKQTHjNcPiVHsMrabWtceQlt/OxZhpb/u1e/MyGCp7xkrzto+HiSSeuJXy9JjjybasWvFRHF3/uJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LRpOW7C6QVgrHV+NE8BEHqUEAi7QPT/aR1cNTM7VuOM=;
 b=0KwEFCD3xDBEvr1fYNRzZGVGsba0IhT899/fRNbHmv7Ksp6X1YuDJmp7PX+DhsVN+rscEdroq3OMipWpBH8xeZXwypa/5UPbOs6DUizqOPCB9by3Rfr0Fsy92O1MLKqjjMWLtm42+Vf9jf9fIDguVp9BOdDRnCaNZcI5RsyQvzs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH0PR12MB7814.namprd12.prod.outlook.com (2603:10b6:510:288::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 20:31:36 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8093.021; Fri, 25 Oct 2024
 20:31:36 +0000
Message-ID: <c3c3953b-d069-40d3-e7e0-db8c0e7eef40@amd.com>
Date: Fri, 25 Oct 2024 15:31:30 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: RE: [PATCH v8 08/25] x86/resctrl: Introduce interface to display
 number of monitoring counters
Content-Language: en-US
To: "Luck, Tony" <tony.luck@intel.com>,
 "babu.moger@amd.com" <babu.moger@amd.com>,
 "Chatre, Reinette" <reinette.chatre@intel.com>
Cc: "corbet@lwn.net" <corbet@lwn.net>, "Yu, Fenghua" <fenghua.yu@intel.com>,
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
References: <ZwcIkf_oy2oKByNu@agluck-desk3.sc.intel.com>
 <0fedcbd4-487c-4d55-8151-69dc34f41f1d@amd.com>
 <SJ1PR11MB6083FFA19F9387F21C058A09FC782@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <d1986f3f-9db7-4ac9-9fea-56878548ad61@amd.com>
 <SJ1PR11MB608382EB9F40FBDC19DF71C4FC782@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <1baa07f6-0ccc-4365-b7b8-09fe985963cd@amd.com>
 <Zwlj5TQxZphcuDSR@agluck-desk3.sc.intel.com>
 <8af0ce3a-1327-3ffc-ac5c-e495f9cdf5d0@amd.com>
 <ZwmadFbK--Qb8qWP@agluck-desk3.sc.intel.com>
 <ee7771e4-3768-456c-9990-fcd59b4f74af@intel.com>
 <0ee2e67d-c1dd-489e-beef-1f255c5629d6@amd.com>
 <SJ1PR11MB60833A1571413763DE36B538FC442@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <23b5a3d2-91ac-4467-9db0-3de483cfacf9@amd.com>
 <SJ1PR11MB6083583A24FA3B3B7C2DCD64FC442@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <799f514f-b06e-46d9-bfe7-dfd986aef166@intel.com>
 <3b7ca34a-764d-458e-b28c-113dc5419a4e@amd.com>
 <SJ1PR11MB6083DC9EA6D323356E957A87FC4E2@SJ1PR11MB6083.namprd11.prod.outlook.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <SJ1PR11MB6083DC9EA6D323356E957A87FC4E2@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR01CA0029.prod.exchangelabs.com (2603:10b6:805:b6::42)
 To MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH0PR12MB7814:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ccec737-4aa0-4464-1572-08dcf5340599
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y24rUThRT2lYdTFObFJjUTVHRlRXd0xabkZEajQ1TGFIRUJzMkFJVll4Tmxi?=
 =?utf-8?B?NGR2S1A1SkR0K1FrSDNxejRCTHBqMUNkRGdZSzFvRTZTbUxCc1IzT1hNRlNB?=
 =?utf-8?B?NmZvRjQ2Z3Nnc2NDNjhXcEVmUWVabk01QXFabDB1S1dHR2Qyam1VUDllM0Ra?=
 =?utf-8?B?cmdPSjFmd1F1R3YwZWNKclBGTnZobGI3TllpRmczRkRsNll3ZVZZK0NtQStR?=
 =?utf-8?B?ZkdhakthUnpJc3R5T1JwR090Rjhqb1JxeTI1MGZlSkRWZlJOc081STEyd1k3?=
 =?utf-8?B?aTljeXU1UmJMcjFyL2MzQ25wZE5pek0yQWN4QjI2bzA4RnlZdUZ0R2loRnFS?=
 =?utf-8?B?Tm9yRHJCMUxsM3Z2alpWOGx6dXlwREZNRjRwU3RHbnc2d0JxQXlYU1hPSXBt?=
 =?utf-8?B?dHZsMHpDTTdob0hIa1Q1U1gwZGVXaFFtN1g1ZVdlNHJaaEdleWh5ek9nQWty?=
 =?utf-8?B?bjByRy9ha0RvVHJZQXgwcXk2RHJCN2RpQnpNSUN4Rm84OVk4aUxia3VkN1kr?=
 =?utf-8?B?T0FmbXY2b3d4U2tyTnB5VUFJdGhCZzBycnFXWEQ1K2RmcmU4bkR0dlU0amd5?=
 =?utf-8?B?RkQ5bkNmemNWSmpWSi8vZkVhaEppSEdFYzBoZzRDYzFOVmdleHMxZzhUQ3E5?=
 =?utf-8?B?b2JkWWZULzBROUVuSmR1ckhzV0RsNFhXWnhpeEswK2w2ZXhhY0JHUnB3SUtu?=
 =?utf-8?B?RVhjUml1eEovalhZZ0QxU3NBeVdYOS9JWFBYdzB5RFFTRjNHV0FzWXlaVUty?=
 =?utf-8?B?RlBsSUdIaUxscUl2bHpITkpZTkFtb2lGSEZtclQrUkdUYS9TT3FrSmRpbWY1?=
 =?utf-8?B?Y2h0aWQ0WW9xT1RuZklkY3h4dG5MS1BkTXBwOE5ZYWJtKzhzbGQ1YUgvaVlD?=
 =?utf-8?B?QllmTnNpdGlnQ2dwZThqVkNnTDZ2UlRYamVORlZYU3hhNVl3Nm1iYzFrMWEx?=
 =?utf-8?B?NUZzTm00dDFCTWpLV0JWdEFXWk9YVUFaT2FoMUFjLzlzemdYWGpwUUVUcjZT?=
 =?utf-8?B?dHFOblRPYlhmM2o5UENkWlNEbi85eG1BRldaWUFCSWduZHp0b0NGdXREaURv?=
 =?utf-8?B?eE5GQnFOWkFSMVdQZjR0dnArblhLbXU4K3pwMEI2MTNKS1FzWWFOU1pzN004?=
 =?utf-8?B?UFlpNVpOdWVLdkN1cEpCSzhFcEo3OGI1MkJkVDhrUmo1TmxFYU9rWlM1algr?=
 =?utf-8?B?S2gxRmJIMEkydG9TQnpnTVFHZHRpSkF5NlozRFN6SWFOUHZVVXE1TnRXckxN?=
 =?utf-8?B?WWU1bUJ5MTR3ZngzNnJoeFJ1OUw1ay9TZ0ZPMUZjZGsyd1lWRktOODJON1dl?=
 =?utf-8?B?Vk9oeWY4c01pZ1RsVjdVZEtEYlliNXFWaElrZmZuTXNCNWQ1LzJEbnh1dTV4?=
 =?utf-8?B?bWxEV0NoL0lmQk02N2JBUytaVDh0ZCtzRDUyanhFSHlBUmFjczNOUVhaNXlX?=
 =?utf-8?B?MExSUTAyRU5GdnFRb00vQ1E4OXdNMWdNbnFTTW5ycnMrQ0dzWEkwODk4UzYv?=
 =?utf-8?B?QWVtZGVtOFA0MU9ORGV2NmNjOE5LNzVOd3p2QXVRcG9zUXIxcWVKWEhIT3dW?=
 =?utf-8?B?QisrQ05lWVZxc2dFalQxaGRkNzd6RENlNisvcE8zMXJKU01vd1V0ajJPSU9R?=
 =?utf-8?B?ZWt5aDRXbklhN1ZFVGRRVVU0SFkvOHJ5YVZrbjB2V3I2enF0T2lqTGxXeGVk?=
 =?utf-8?B?aFV1UVNObmpuaHlIZ2c1T2YwSVpSQTVUeWNRVHZ2TmZVdndwNFQzL0xselFN?=
 =?utf-8?Q?p3iby+7/W8jpiAkCpFO1ibJQlpxrJ07Xwk9NKBM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TkUvV2YyTXliRWtpSElVbWo4R0ZKOHErVkpFTTFvUDdnYk56Zk1ISUVML1NN?=
 =?utf-8?B?RmhxZjg0SlZNYkxZd1lLMGJOaVArTEdHTVFBTVA1anRwcHo4dTA0YmEwZWw4?=
 =?utf-8?B?Y0JYeTJFMVFXUURMNWhNRWVrQ1ZnWHkyakpxQ1QrVks3dEhPbGpoTVhQVnRO?=
 =?utf-8?B?N0huWXZldG9KajRYdmJQRTQyTG9OM04vMTBKWEtPdlJJTDhvMnRZQVFsZ05Z?=
 =?utf-8?B?dEtBdEVWUzdBSkJDUXIrRFpyVTkwT1FrZnlPSlBtQzVmWEtzd3o4aGorWFRX?=
 =?utf-8?B?N1FpN25oS3dackdaZVRXNDNiOVhVaEliNTBza1ROUTEvc0xuSUdSQUVHdGlT?=
 =?utf-8?B?OWFldmlMVndKMU4yaFV1bTB3Y2lHbi9NcVVScXRDS01BQWNsTVVyc3Bkd1hy?=
 =?utf-8?B?UFUrZXRZTVI5ZkpQQkFZS0RQMUhTN2t3SlU5bHZJbWFERWxNQVVNUEk0WFd4?=
 =?utf-8?B?TDNDT21pM2c3alJvWC83ZllxWGl6NXcvK3NxaEs0OWJldkJqWklvTWdKNksr?=
 =?utf-8?B?NlZaRkJTU1gzQnJjUGtGKzlpNSt3dUZUVGdsOVV0ZC9YdzFRWjFGQTRXVzFl?=
 =?utf-8?B?TFZDOFBVc2RqTmRKRUVIZ01qampDMjdySG9MRGNiMGFkMFE5WmQxRFhGWXI3?=
 =?utf-8?B?UXVTOFcxbVJTYmxkYm5INUZsT21ic2lVZHdMY1NWa3JvbUdmTitMbE9hSFhV?=
 =?utf-8?B?U09ZMlFPc1BFa1hCRG5oVlpnQ3k3R0lsUmQwVFBGd0gzdHlTSlFqaER0anl3?=
 =?utf-8?B?R3ljdENuWGJFTGFNTlBpeUxLZW9VcElGNXpmQUFwMnpjNFhOOWxtREpOT1hE?=
 =?utf-8?B?ZmJZcGZZb1k3WEpvYjA1Ni96eWZFZXdJUFh0ZFJzeGVNaG1FUmI1QjRYWnZ5?=
 =?utf-8?B?Mzh0SGJPQis3Q2lXYmhDUmtMM3dSZHV2UVJFUUNVODc3Q3c1UWgwVW00MDcw?=
 =?utf-8?B?dmJGUUptbzduL2llbnZUcG1GSW1ZckRYOTQ2VE1qV1JaRjRVeUliNFcwN1p5?=
 =?utf-8?B?K1BZV0swaDlacTZ2UWdJKzJPY1VWR0hTYXN4aHR5QWZ1cGdxQXNTVXVWMDZE?=
 =?utf-8?B?UVhGbG9RK3Z2YStaaHZEVG0wRG02ZnlvMU5NZmFuUlhzeld2ZEtocnV5L25S?=
 =?utf-8?B?ZEJxZ3loandvOExLaUo4MnlCQ2hPMHZ5T0FOdGtFQlkwLzJDcGZaTFlLTlA3?=
 =?utf-8?B?bFNMQWJDQUtHdUh5ekZNcWRRZjlFNHpOZUQ5UGtrNkg3UFlKeGVDRU9NUlRI?=
 =?utf-8?B?THRMRk9mOHlRbGsrM2RxOGFkY3kxS1o0R0JkNkQzRm93WnhzdHo5YnlYdUJy?=
 =?utf-8?B?aTZNYk9KUlBMdno2NXFPaEpqZHZNVkdqcGJLWDlOaGpaZ3ZteVNMMGVDVFZI?=
 =?utf-8?B?dG5GZ1dZdTdEWUhWV3ZZaHRlL3Exb2M2UDRBdmpVVWxCN2tMaGhiSm5hUVlP?=
 =?utf-8?B?ZHhUM3JZM29yejFhYUNVUThxajcva0t3Vm1KMUx1c2lXdlh2L2cxVy92UlpI?=
 =?utf-8?B?ZFFYUEJYeGtXRE9uU2lGR0I5bDFoOENkdGM0TTd4RVlaSEhYL2FKNTJSa0Ux?=
 =?utf-8?B?VG5tRmlOMVo4SWxQMVVUYmNSRnVPZ09RYXRmWUdzYmliNFF1dDczZitEbjg0?=
 =?utf-8?B?NGdWM2tkRHpVOXBveFArTFVoV2RZL3RJdW9JY3RlSlZSMlBUdnk2blJJSXla?=
 =?utf-8?B?QTNyQ2NYRzdRVFY2V1ZVTWZyZ0NUV0lYeXpFbWt1UFBpa0ZWRGNRNGRTZ1Vr?=
 =?utf-8?B?MVBrbS9XQmxBZW1vUUU0Wmt2dWJReGErMng4VFQ3cmhCSjNzUUhybW9kSFF4?=
 =?utf-8?B?WFNEN0NLSmZadnB0SGpkVVpvTVlUaUg0MUNWaFc3VHBnbXYzNEdOMWpaYUJU?=
 =?utf-8?B?T2VFdDkyZFdyN3VsbkJPbXBVYkhnK0Z3S0gyQ3pKQTJTVzlIK2VydmhHQjN1?=
 =?utf-8?B?VE9vZXFWUlEyTWFMK2dyY09tcW0rbDBSTi9pdXp6TGZNbnRtUU5STlJaMnJo?=
 =?utf-8?B?UGpwa3lmWXdaR1BBWHJNUjREWFVRRUhISHlyMnZKRWZHMTQyT1FGOXBlc2hs?=
 =?utf-8?B?TkNKdDk3cmplbnVQNytOV0ZFVXcyaEM4UDlHemx2VHdmcnF0MGZsUW1Ibmdm?=
 =?utf-8?Q?9m9I=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ccec737-4aa0-4464-1572-08dcf5340599
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 20:31:36.3052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zwhtqF3kUpbpwptnN3kP5WbJlzTv7imePDdCp7luKPheLlObeUW7HSs0DvrZ/hAa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7814

Hi Tony,

On 10/24/2024 12:37 PM, Luck, Tony wrote:
>>>> Since you seem to want to keep the flexibility for a possible future
>>>> where per-domain is needed. The "available_mbm_cntrs" file
>>>> suggested in another thread would need to list available counters
>>>> on each domain to avoid ABI problems should that future arrive.
>>>>
>>>> $ cat num_mbm_counters
>>>> 32
>>>>
>>>> $ cat available_mbm_cntrs
>>>> 0=12;1=9
>>>
>>> Good point.
>>>
>>
>> Working on this now. Wanted to confirm if we really need domain specific
>> information?
>>
>> To me, it does not seem necessary for the user. User cannot make any
>> decisions based on this information.
>>
>> All user wants to know is if there are global counters available.
>>
>> $ cat num_mbm_counters
>> 32
>>
>> $ cat available_mbm_cntrs
>> 15
> 
> This approach paints resctrl into an ABI corner where it can't later
> update resctrl to track counters per-domain. Maybe you'll never want to do that,
> but some other architecture might want to have that flexibility.

Ok. Fine. Lets keep the per-domain counters.

-- 
- Babu Moger

