Return-Path: <linux-kernel+bounces-515586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDB0A3667F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 20:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 071503AB38E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 19:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847421C84C0;
	Fri, 14 Feb 2025 19:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="K+kHz+1a"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C5319F121;
	Fri, 14 Feb 2025 19:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739562707; cv=fail; b=dHKCKvJM1BEKqMnB6Cz01g7cx13L79zLZbXsuIcCb7LGs2qU2aYSOWf9TnQ6HCEFN2lujI7WRMMBakIFEEmWYV/tgWEpGsWEMkszWnsmIoNIX4eMxTfN9+Vp39EqTUb2GryuAE3MRgfQXSG6YbWMWKHCTs4jCFjJpBrgDnA9730=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739562707; c=relaxed/simple;
	bh=MzdcbegiekGzn77kWBJ0I8vyJHTfFOoZUQ1WP77qSoQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZggeyfFYzAzlwIOk9tMk130qE16U+RRu+TSTDkt6t+7X8GoJTyefkL9pOeeoxtYpwmLLr7YjaLqPuk1dEddaLXFd4EyykE8wAHshk2dU0M9piNArwx+FkpGlImgKy2JjQcnz85crSrKJfS9NjzXDvRlHxFQDO/Dz9WmwRLFEimE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=K+kHz+1a; arc=fail smtp.client-ip=40.107.236.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GE8zE8DjLGzQr5axr9/DkDj5ysh8I1wIBzgBbCsq87dkI47uSUPjEXyva9uCfZ1bviTiBRn1hQdrYYDYgkULK8KeRSv2one4ZpUWSlILfa7vE9EVKpWJKdb0RO42uVDBdrDP4oxUKFxbcraMzUGUTGEkcGIvVFEsKXTY5YY0mMHGDIMORLu38knW0ipCv3UVuoHo61jwtZnB8/FF3PCxLXYtLzrMYJ4k/sYFsOTq942P26k+9OKEbrYIcpyAl4JnCE28+cJkf2QmvaviqtyJOFxGgOnfAWCMhru6ZjYeWfWNKMkWtJNdJotTtWxRx/xFQycjZ1cCXK7qftQazVAJWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VV6TliAcslgC3IvyWFAL0Il64Xhtfb8EgeZHGx3yWjU=;
 b=i6K32HaWQm15npZyKd+Wd7EwxS5wcD8pzsthqxvrTMfYKh0NGH5q9Wbi21TsO+DDLi3C4YqZUarSiskBy6NY1VtXMLneYytPkEWFdIBc3tqXAlE9dXTAbjOFg6C3fvdxAhq6lEbuatgYqpxKYMwwOauihTODYMCURb+yL0pp34VUkjZFUohNJayaHkd4SQP9AhBOhw6xKexe5VQRIlJk/q6r0S8JXxuD/kn9wKDL2z6jsN+giie+VmXx76yEG7qD6n/0HpztNwc1DYkWWzZsIEO1pAmhECu/f4ldY0KnzNlxDJc4dPGxD1U665CQ5o8eg7ywjLpnT1Un6SWMOrS+mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VV6TliAcslgC3IvyWFAL0Il64Xhtfb8EgeZHGx3yWjU=;
 b=K+kHz+1avc3fN04Aw+Ax0Cv9uiPfO+q1byluQqmd2G8X6mo60/+MeD1c9syca8ig5QNE9VEjZ0l+rQOiEKr57DknoeJYL+i51P8kX0PchzT1pOrPImfcSxdeZmr82+4DwGqk981a08WsE3t5gEyRzghF0CAK5qHWAhYAYbvh8BM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Fri, 14 Feb
 2025 19:51:40 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.8445.016; Fri, 14 Feb 2025
 19:51:40 +0000
Message-ID: <e295deca-647c-4547-a599-9a20cc8741cc@amd.com>
Date: Fri, 14 Feb 2025 13:51:35 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 00/23] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
To: Reinette Chatre <reinette.chatre@intel.com>,
 Dave Martin <Dave.Martin@arm.com>
Cc: Babu Moger <babu.moger@amd.com>, peternewman@google.com, corbet@lwn.net,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, tony.luck@intel.com, x86@kernel.org,
 hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org,
 thuth@redhat.com, rostedt@goodmis.org, xiongwei.song@windriver.com,
 pawan.kumar.gupta@linux.intel.com, daniel.sneddon@linux.intel.com,
 jpoimboe@kernel.org, perry.yuan@amd.com, sandipan.das@amd.com,
 kai.huang@intel.com, xiaoyao.li@intel.com, seanjc@google.com,
 xin3.li@intel.com, andrew.cooper3@citrix.com, ebiggers@google.com,
 mario.limonciello@amd.com, james.morse@arm.com, tan.shaopeng@fujitsu.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 maciej.wieczor-retman@intel.com, eranian@google.com
References: <cover.1737577229.git.babu.moger@amd.com>
 <Z6zeXby8ajh0ax6i@e133380.arm.com>
 <9e849476-7c4b-478b-bd2a-185024def3a3@intel.com>
 <Z64tw2NbJXbKpLrH@e133380.arm.com>
 <76b02daf-1b45-473e-9d75-5988a11c6887@intel.com>
 <8ef51f28-e01a-4a7d-ba86-059437edb60b@amd.com>
 <a07fca4c-c8fa-41a6-b126-59815b9a58f9@intel.com>
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <a07fca4c-c8fa-41a6-b126-59815b9a58f9@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0034.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::7) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MN2PR12MB4373:EE_
X-MS-Office365-Filtering-Correlation-Id: 47d39c35-96aa-4916-5261-08dd4d30ffb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RHhjaHFrYnFETmVjUStYOXdqUGxQUXQzcVRpL1ZGYkF4WEordnQrQkE5VHE5?=
 =?utf-8?B?VUNHQ3hFOFAxUTRSZmNsZUkrSm04WEtZVHArbmpCd0tKL1hoUi91eEtzK3pC?=
 =?utf-8?B?elE1VzFoVk1LQjZvaGE4VURhKzdLRzR4MjhvalRjNU4wenBIYm52c1hmSFg1?=
 =?utf-8?B?V094aGlocVVNeDdjQlQ5MzNIQmxuWHRvdEJCaTI5eEtoMHMvM2F5dm1SN0or?=
 =?utf-8?B?MTFiRTdpQ2R0NjJUSnZTODhQVVlPcTltQ0JqSGRFSGh5NzF1NjFVTmpzaDNn?=
 =?utf-8?B?SnlmT05Rci9Xdk53UGc4VStGM1JYdmRSVENVak45Y1Q4b2dHNmxiYlRpVk56?=
 =?utf-8?B?UVBJQTdKS2lBTkJDWlhJbmQ5RDY3N2Z0RjFsOGxOUUc0QVpTcExXVHNGZlBh?=
 =?utf-8?B?eVU3SmljdVJEbFBnVmVENGk0Q0l6K1lUVktPdHdrcStrc3JlNE11blJIK0Ur?=
 =?utf-8?B?UDJLemllQTBaVHFmRGZObHdNUWZXNzc4Y3M1azFycFVjS3hjYTJEL1JRZ05X?=
 =?utf-8?B?d1I0eDVkNHp3L2p0OFRReGt4OFVoTmgyRFNWN2lYYVVNREJFbXYrcWtBaWRx?=
 =?utf-8?B?RHBvK0NsUlNIY0xKamZETkJUMm1ibXF1cmNhQ29MakE3d3JrTFM5RitKcmJK?=
 =?utf-8?B?U01PWFBLejRDZmZudEEvYlZkMWJPT3o2UCt2d21IU3FuTERZSEVjaGdidUZO?=
 =?utf-8?B?LzNQWExIS1lZVUxwbFhMakI2a1pHdWxuTkZweGVTZ3RHd1hRaytsYnp1Skhn?=
 =?utf-8?B?N3RQQXlQY3JoS2xnajdPekRINzFvWW9acUltcW4zaS9BVitYTFZncStoU2lN?=
 =?utf-8?B?Nnc5NXQ1Wk1XOFlTOGxDLzF6U3RIRTF3WkZ1TXZVajJmNXhVWEE2NTBzYlRi?=
 =?utf-8?B?WG5MWmF5d1FOblhlUnBNWlZTckcrNmxETGdwZXhaOTNpaUpRci9kNmtBV2RZ?=
 =?utf-8?B?UiszL2VGUlEyWkw2RWJ6QzR6SkkvTkJBaFR6WUlhQ1VnMENzWlgvTWFycTJk?=
 =?utf-8?B?MUpXSllPMkZ0STZtSHl5bDRSeS9aaEZBd3JIYUxUZXlpQndocWhKZWJ2a0dO?=
 =?utf-8?B?Nmdrb2dKbnZxaGNsTElNY3dhczZ0ODJ2QkRmUVRIYXpvQUpDSkxTb0I2eXFm?=
 =?utf-8?B?Wkx6YXV3Mk9JTjhCOUFzS2NYMHlPc3ViaGhVVW50LzREdWFPYXJqNzYxRlly?=
 =?utf-8?B?Q090MUZnOGlKRTQ4V2ROeVo0OWFTYzBEUlc4aVV0K0cvalZuWTV6cG9MNzJE?=
 =?utf-8?B?Rlgwa2Rickhkd3hWajFpdGFVd0xIRVRubG54djFJWm80MWNHSjNjamZ1QUVt?=
 =?utf-8?B?aTZUQkZxSDcwTGZZNm80V3ZlU3gweldaTGhTR1EyOGRYZkV2M1dSY0UzWnhh?=
 =?utf-8?B?WmNUSW8rZ2ZLdmZnS3Q2K1o1U2FrcldBTGpFancyN1ViS3dlVmlwU2VYTFZs?=
 =?utf-8?B?OXVXQU55NnJrRHhEMTFXNkd2Mm5WWkllZWpSbkl4Sk5HSzBGRkVGdTBjTjJC?=
 =?utf-8?B?cG5uVDFwRExaUzhNcmthVXRDMHVFRHpGaTJjb29tTTRQa1BZZHNlRFFyV0o1?=
 =?utf-8?B?TkQ5c2dQbTkvOEo4eFVoUWI4OVNsd2t0MGpYdUdmWnBDdkVQbEJzamxvbld1?=
 =?utf-8?B?TmVBZUdua1JTY0Ryc0daT0FRSG5tNUNzQUNORy8zSGlYT2J4SGM0d3FQR3dF?=
 =?utf-8?B?eUtmSVR6MVVwTlN5eTYzVWxmSnlmSjl1dFVDU3hZVUVDWWY5cERYNzMyNEFs?=
 =?utf-8?B?V0VWSE1PTzVqcE5yQzBON25iM2pGd3Rpb3Mwd285ajlvc3ZkeVdrellVZm5B?=
 =?utf-8?B?cTRQRmg0clJZWHIvSGRuemhxN2hFYVlJdzc5SFZDOWE2ckhUT1RvRVNxbmJ0?=
 =?utf-8?Q?tYCamU4Y8rnqM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUNGQmlnai8zN05lVm41NHZ4ZHlsV21UUDg2d1gwbmRqcUxlajZyRGs3UUdx?=
 =?utf-8?B?Tm9hS3JhTWhPQjUwK1NERFhYN2ZSK1h6UEEwRGliRURDUHR1WVRkMWY5N1ZZ?=
 =?utf-8?B?U1hBT2NTaXA3VFJCSkFtdG1RclNEWWU5VTNSRWkxTzBFdGtlZlRSTHFXNmI0?=
 =?utf-8?B?d2Q5cWk3U0pTcnMvUnpYd2J3amdFdFV2cUc1THk2UW9KOXRtL3BrVjJ3NVI2?=
 =?utf-8?B?NE9lNXlpam1YN3lKcVFPdnZlVmYxT2hLTkJDbWg3WmRmdDkzeU1USlNZcW05?=
 =?utf-8?B?T1g4NUxmR1Jac1p3Mzc3eWw2UEZObkpoT3ZGZ2o4YWRrNGt1aGF6L0d2K0RK?=
 =?utf-8?B?ZkFxZzVSTmdLbmh4NHFMYkEvT1RqT1pNUjV2T0JRSFYxdEpqWW5oZVFmZytX?=
 =?utf-8?B?b0ZyYXVSOGlSNXhzL0dLNkJJVjc5WktWRndoUTFYYzZKTU1Pcml1d1dqNVNh?=
 =?utf-8?B?UnNDZWlLWWVkaDVVUiszamhVZ1poUFZyWW9HQlNwb1JDeEtkRHZxc0RGWDFx?=
 =?utf-8?B?YVFCVHR5UUNGYlFGOWN0U2VQZDM0WE5FTjV3ZUd2NnNuaE56T0hRRlZ4V2JN?=
 =?utf-8?B?ZE9pNVJZTitNYldzZFFUTUJ3bE5SR0xuYXpoZ1h6dmxla1Q1MHljYnZtbzNV?=
 =?utf-8?B?NnR3eTFGYUI2R2RoZG12bUljK0tNVEhyMlo2SkhibHJzbmUzOXVkRnFmUVR6?=
 =?utf-8?B?dFprSDhRMFhWTTNxejJERXVzeVNXWnVXOUJJQnc4RmJmY3NvcUhZTUZXUzlE?=
 =?utf-8?B?eHA0bU1tcFRrRmpDY0RpeFRLYmxzVVJpTjA2VmxlLzlra052cExhazdUdWt1?=
 =?utf-8?B?N0xFKzlBU2dOWnBISUhTN0diVStDVkpOckRiclpuNEdKRFRKeGtmNDFZOXVZ?=
 =?utf-8?B?a3h4Y3htLzBsUmlmbWtwempJUFh6dFM0a0M3WjVsZU55aXJ1MDhRbHN4anRq?=
 =?utf-8?B?dzErUkxJbVFzbUlQVFFNZjdFK0xGYkQrczJnd1FqY2pXQ3d4MkJHWTJMZm1Q?=
 =?utf-8?B?MnhzU3hiRGtSNDNMQ0NBQW9rdXlUQ056NFhheGlVT1BtekdLYW5QVXJOSk4r?=
 =?utf-8?B?dVZnT0NDWkgrUHBrQWJOb2RTU3ZSRmhpRjVYek9uQzZOTEpaa3VqM2cxVFU5?=
 =?utf-8?B?d0NBdEFhTE55SzRPRkxTakZlMWw1VmVBd0dEQy9hd0IwQTNxcXp0Unh2YjNl?=
 =?utf-8?B?V0RqaHJhdy9pMGhtK0Q1NXJaRS9rMlJwaWp4azVuYno4Mkh0V3JISlcvNDVG?=
 =?utf-8?B?elF5ZEdWQ2J4L1B2dDlqc0l3OXZ1cW1HY25JdW9uUHpnOW1hOHJiRklaY2Nr?=
 =?utf-8?B?bElzbWFCVWFQcUJ3d2p0ZTFtUFZwVGMxN1NTWVRwaGFNRDc5RlVCQlJSWDJ1?=
 =?utf-8?B?V1hRa0Z4WFZOcmxrRXJCQmZEb3pIY3ZDa2hRSEZJd3hJdWl5QkFmUmhyemhB?=
 =?utf-8?B?TzlVUU5CL2o1aDY0NXMrS1VFejZHM1dabjQ0RzRrM0oyWjNDUWN5RGwzbTJ6?=
 =?utf-8?B?d0hGNXVjQ0FEa1hXSFVGNjgvMjFQSG02WHNmeGhEY21RRTU0YW9JeU1zd0dD?=
 =?utf-8?B?d3pGKzVKZXRnR1BpMnc5dzZVbVBZK2Ircit2RWkxZ0h6NThQdmRKNVJOeU15?=
 =?utf-8?B?QnVzNVZ1WDVyY3Q4QjlJUVZuZ0hTdmp4aXhBb3VvYWU3K1Q2dW15TExiNERD?=
 =?utf-8?B?Q1E1Q1czd1BCL281ZjRJWEFNQUdkS01HNHFvUDhLYlB5VnFTRU1FeG5RMHZM?=
 =?utf-8?B?NEtMaUxxWklCcGg1eXZ6S1oxc0Y1VlNDaVlqNXlwRnY0TDhzcWJQUDVqbS9a?=
 =?utf-8?B?Tk1PWFpUTkpPc0FiZVd5NWMxUUh5WGdZcGp5NWlLK2hmaWkyVGxyUmFyTDFB?=
 =?utf-8?B?L1VLQ0tISkx3QkFaREgwTlJlZ2dveFdTVFJKQjlEY1pvUG5YNHVreHk2SkNl?=
 =?utf-8?B?dG0xNVZQRmZLOUVLME5pcFZtL2FRNTRJSTY3U0Z2Z3ROSTA0TWJUT0RvVlp6?=
 =?utf-8?B?VVUwcVk1ZFpudVVHWFA1Q1ZtZHVCZjljODlSd2IxL0wzVFEwZlJ6MGJRdEN1?=
 =?utf-8?B?TURCNUR2cEo4SDM0KzNOaUZSRmtWWmErd25NZ2kwYTFEdFo0bXZOdHZvU3Fw?=
 =?utf-8?Q?fukk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47d39c35-96aa-4916-5261-08dd4d30ffb3
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 19:51:40.1975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fsl8TP+L4iZ/3EjgHX8ogmTXWZDu53/9gpQpXFs6t5NQaxzFnqMqk3Vahe2fL/G9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4373

Hi Reinette,

On 2/14/2025 1:18 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 2/14/25 10:31 AM, Moger, Babu wrote:
>> On 2/14/2025 12:26 AM, Reinette Chatre wrote:
>>> On 2/13/25 9:37 AM, Dave Martin wrote:
>>>> On Wed, Feb 12, 2025 at 03:33:31PM -0800, Reinette Chatre wrote:
>>>>> On 2/12/25 9:46 AM, Dave Martin wrote:
>>>>>> On Wed, Jan 22, 2025 at 02:20:08PM -0600, Babu Moger wrote:
> 
> (quoting relevant parts with goal to focus discussion on new possible syntax)
> 
>>>>> I see the support for MPAM events distinct from the support of assignable counters.
>>>>> Once the MPAM events are sorted, I think that they can be assigned with existing interface.
>>>>> Please help me understand if you see it differently.
>>>>>      
>>>>> Doing so would need to come up with alphabetical letters for these events,
>>>>> which seems to be needed for your proposal also? If we use possible flags of:
>>>>>
>>>>> mbm_local_read_bytes a
>>>>> mbm_local_write_bytes b
>>>>>
>>>>> Then mbm_assign_control can be used as:
>>>>> # echo '//0=ab;1=b' >/sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>>> # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_read_bytes
>>>>> <value>
>>>>> # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
>>>>> <sum of mbm_local_read_bytes and mbm_local_write_bytes>
>>>>>
>>>>> One issue would be when resctrl needs to support more than 26 events (no more flags available),
>>>>> assuming that upper case would be used for "shared" counters (unless this interface is defined
>>>>> differently and only few uppercase letters used for it). Would this be too low of a limit?
> 
> As mentioned above, one possible issue with existing interface is that
> it is limited to 26 events (assuming only lower case letters are used). The limit
> is low enough to be of concern.

Yes. Agree.

> 
> ....
> 
>>>>
>>>> Alternatively, if we want to be able to expand beyond single letters,
>>>> could we reserve one or more characters for extension purposes?
>>>>
>>>> If braces are forbidden by the syntax today, could we add support for
>>>> something like the following later on, without breaking anything?
>>>>
>>>> # echo '//0={foo}{bar};1={bar}' >/sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>>
>>>
> 
> Dave proposed a change in syntax that can (a) support unlimited events,
> (b) be more intuitive than the one letter flags that may be hard to match
> to the events they correspond to.

Yea. Sounds good.

> 
>>> Thank you for the suggestion. I think we may need something like this.
>>> Babu, what do you think?
>>
>> I'm not quite clear on this. Do we know what 'foo' and 'bar' refer to?
>> It is a random text?
> 
> Not random text. It refers to the events.
> 
> I do not know if braces is what will be settled on but a slight change in
> example to make it match your series can be:
> 
> # echo '//0={mbm_total_bytes}{mbm_local_bytes};1={mbm_local_bytes}' >/sys/fs/resctrl/info/L3_MON/mbm_assign_control
> 
> With syntax like above there is no concern that we will run out of
> flags and the events assigned are clear without needing to parse separate flags.

Yes. We need to change our current "flag parsing". It should not be a 
problem.

> For a system with a lot of events and domains this will become quite a lot
> to parse though.
> 
>>
>> In his example from
>> https://lore.kernel.org/lkml/Z643WdXYARTADSBy@e133380.arm.com/
>> --------------------------------------------------------------
>> The numbers are not supposed to have an hardware significance.
>>
>>      '//0=6'
>>
>> just "means assign some unused counter for domain 0, and create files
>> in resctrl so I can configure and read it".
> 
> Thanks for pointing this out. I missed that the idea was that the
> configuration files are dynamically created.
> 
>>
>> The "6" is really just a tag for labelling the resulting resctrl
>> file names so that the user can tell them apart.  It's not supposed
>> to imply any specific hardware counter or event.
> 
> Right.
> 
>> ------------------------------------------------------------------
>>
>> It seems that 'foo' and 'bar' are tags used to create files in /sys/fs/resctrl/info/L3_MON/.
>>
>> Given that, it looks like we're discussing entirely different things.
> 
> I am still trying to understand how MPAM counters can be supported.
> 
> Reinette


Thanks
Babu



