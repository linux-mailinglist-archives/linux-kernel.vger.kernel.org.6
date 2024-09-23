Return-Path: <linux-kernel+bounces-336225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 967C197F0D5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 20:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6187328272B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 18:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7B92E403;
	Mon, 23 Sep 2024 18:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UPyNEuZc"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E33014A85;
	Mon, 23 Sep 2024 18:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727117167; cv=fail; b=KFfild7R8LcH3YRrcpnUBXARkaM8qZS5oq6zd23aaXmliHmNDIkZTteb7Cwe0lLHhzE9/GJwfMXotkmlcDRsBuIDx9kEFNZ5l+NwR5qEnH9sMzsddt0jLQwUZSumuYzaq/MVz9oVKbIgjuYGOBEYRxBo3HODgetkDnwbNL+dC2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727117167; c=relaxed/simple;
	bh=/x5AP1OyP68eGq7I9sXKNHT5Qbqhi2s2BUMsTFwblNA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gqidkDznFKHI3ADo89IOZ+Xqw8eReuKoWLKEU0SKnsT4vDARg/IsWYsCYt+7OZNLItx3albpwyQvXLVFKZ7q8zBjG5T4C4mLM3p5Knhzgsrojz5yVNz8oQAXu/buz1shEWvSGSmExWZSQt1o6DLy4TQfU6MZD2zpCoHARcHYKMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UPyNEuZc; arc=fail smtp.client-ip=40.107.220.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b5L2czLCGuj2ioNUpfHHxTsW2rXPE8eKxQ0C0cmXmcXOroFFN8cTw4BG9FpCO6u7luPEKMSpCc01f9pyWAIUSvMGwXrpLf9EvFlcWsDmHrbR4bIUS5oLlRqzx2opdEOYxEPHZ4Y0t1xIO7vnpIJJ+y4ZQcY3S4+8ARBpZLPZJYCwytuBZ9pnNRFKX0+1NEpf0i3+wbYUQ4CBDSrsTG2JK7cQT66eZlVfFq7DOYmLhk2T+DuQlyqNc/cuY8F+nyL60RvfRnFnZlA62UWT1WHadxjO0z3JZbV9Hg6zN9VHoRmzwHJLpEM99aTzSG1wg/SWKM+1yAwfxX3G2Yoxulmb9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tdAdT2jov9B9xDjFHu6WntDNPy6+LA1kJ4UQuZnzzTM=;
 b=QdzdXfy1FGcttxuI0pWsuHXL5wsbL8rStXJXIKu7LLZ/WLHMNtKnfJ6vPx5DikXt220FazPUWl3MB7LR23yRalskGN9h0r+EmuK2eXWPutibHt5flAs2UIOYV+LM10rq9btZJd6PN2iH0FPdv35lIIatV46vpaJ1wcFzi0VOE/iNR32pu1mH22y2BevoepeTi2d8Wst7WQI/IInHDK3vcyKZ9ducV0N/e2Hqmz4Q1rKoBOAkNZqkfiNeUZnkEUvIESOLDsr+1KbFlPpJ/GAt/YleikT5MBWo9amOzcYRsBlWiMw1XoTze03rWAZIErfc/npFTchsaf7bRgfZtiMQtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdAdT2jov9B9xDjFHu6WntDNPy6+LA1kJ4UQuZnzzTM=;
 b=UPyNEuZcuauYpyu3vixjKXg3qjPuaHZhl5oRHESP6bwXOMrm+KtTnNlffbjN9sEB3Fan3TZX87Gt7MslH5AvXHUKbwxEy2OIl0SC/DxqDcqsNjKGDd6LCkI28IImXGNbltRa8k0/Qp9DbXTRLIrKspRqT5WwYHiNS87tW9EXiN8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH7PR12MB7354.namprd12.prod.outlook.com (2603:10b6:510:20d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 18:46:02 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 18:46:02 +0000
Message-ID: <a3fd2d2c-0045-4316-8181-8165581a1350@amd.com>
Date: Mon, 23 Sep 2024 13:45:58 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v7 11/24] x86/resctrl: Remove MSR reading of event
 configuration value
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
References: <cover.1725488488.git.babu.moger@amd.com>
 <dd3a5803de44391e7496649147d8fd03ebe52525.1725488488.git.babu.moger@amd.com>
 <ea526972-cbdf-41f0-8861-7b4702bdb7d6@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <ea526972-cbdf-41f0-8861-7b4702bdb7d6@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR04CA0012.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::15) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH7PR12MB7354:EE_
X-MS-Office365-Filtering-Correlation-Id: 19b684a6-622c-49a9-c8f2-08dcdbfff8f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UFFDNnExZlZSNHBRdWNocFhpV3JoTU1uWmthY3kxMVN4M1luOTVDUmhwTUN2?=
 =?utf-8?B?TXZCV3ByRmdMYzY4cnd1WHNTMHVLQVFZZldXMUxEeDBjanJzS0NLQm45M2Y5?=
 =?utf-8?B?a1VKZVFNd1F1b2UzTFpsL080WjNreTRoUzN1blN6QmlHYm5DRUNKLzFFQnhp?=
 =?utf-8?B?SG1uVjdCUEx6cUsyVUFMNUhvaEJNYUJQaTl0dVRzek1RYjRnVFY1aUpoSlI4?=
 =?utf-8?B?M0ZPM3orVWdVR0p6cHIrTFNXM1ZFTDEyQzBDaXNUamQ2NnBDQ09wU1ZyRDBQ?=
 =?utf-8?B?NUFrNXdqQ0FpTFdOVU1BSEZhMVRabWtyTk9aWnNoYm82enBrNlBuU3dtQzZ2?=
 =?utf-8?B?YVlFMzFoNFBlNkpzcWxNK3Z2M0dxUjgzeXRQNlpNQW95SllmU3d0U00zUEg1?=
 =?utf-8?B?czJySFVGZHJvcGdsK0FTUVNyTkpiMkpCQ1VVMGNUZHBnR3RoaHFVK1BoSDBk?=
 =?utf-8?B?MlRnWUtkL1IzbUxGWnZWWHV6a2FlV0E5dkdqTmFrK2g1cDNrTnBLME9kTHRE?=
 =?utf-8?B?Q0ZzWDdqWEhLOHprYnlKdHRFRHVtUzdDTHU0RjdrMzBTVStSVC9ERlRrU3lX?=
 =?utf-8?B?M3R4NkJET0hzQ2M0eUg0cDdGNU9na29OL0J6RlZEbkhRblVNQjEvWGNKdXRL?=
 =?utf-8?B?RnI2emUzU2V6YmJjWnR6VmNEeW1ab1huSXF2RU8zdlZOK0NxY3BxQTk1eUJZ?=
 =?utf-8?B?MVByUTZDTE4ydjJqeFRuSWZDSExlRFBLU0hublNQMGVyZnhaWGUrZlU0eldj?=
 =?utf-8?B?RWpWMThGNGtqZkZLVlRobnZ0VGJrVVpZcE02NWZ3ZUFac0tIUTUweDAvVXR3?=
 =?utf-8?B?b3RPY3JadnhHRDhzUTIwT2VRSXQ3TDNqTy9pU0c3QWV3YWxzWnVsOHRZdVdq?=
 =?utf-8?B?SlJvMmZzYTVPM3daVDYwa1g0cDBNVVR2VkZCaXZ0cnJhQ0xsRGlWZEtvTXdS?=
 =?utf-8?B?ZkVpSVJRbVNxdVE3MjVWMS9DSzRPcEIrd200VFFaKzhMaVpvU3NidlZ5K1lC?=
 =?utf-8?B?Yk1TOHdCckZadWlBMmpXcjI3NCtXQVFCbEFYb05Zd2dXRUpRL0JPY1dLRy8z?=
 =?utf-8?B?TkRsYWNoeklZTDJNVlNyZ05iU3lzNVpFbE1IQ29HMU5QUXcrNkRKZ3A4QmQw?=
 =?utf-8?B?dkFweGJzbjZoU2gySC95cDZKKzluNTBQWVBGRmY0eFBsS0RQYU5aK1FQQ3NZ?=
 =?utf-8?B?MkFHRUZJR0xNV1BxcWg4U1JrSVhPUElRRmtlNjJSSmllekgweVl6S0x3eXgz?=
 =?utf-8?B?MXBSRVU1cU8rZnhucFNYY2QxeEVmcW9RTmRxOGVtcUhhRTBJN0pGdU8wK0gx?=
 =?utf-8?B?M1lDYnRwdURKZlNONVNaR1prMS9jSUd1L1Izd055eWoxL0RraFBFQTZwSlBC?=
 =?utf-8?B?ZmJTQkdleG8rUk5PMGVJZG1hSU9pUXBtSGlsMzdLWE9pVk9naFpUZU5mYjZB?=
 =?utf-8?B?M3haMld6TnNzVDNicEdhay8rV3daOU9lNDUwVW1iSDVvWTFIZkliY2hrRkJv?=
 =?utf-8?B?MVo5c3FEc2NYNis5d3RNbURqVWs2WktCTDZyd2NMSmZrcTkvMFNJdW44MFFC?=
 =?utf-8?B?ZEZQdHBlSVFpOVV6SHFLSnJRQTZCRWVTZUVCU1J2T3ZuTWlMSndPWXB3YXlC?=
 =?utf-8?B?a0VUb3g1elBQWFBhSDRBRDQrRkRjVVBPTFU3OHdTRGpCaSsydGppOEk4Zytq?=
 =?utf-8?B?TElzNDJxaHRlcFJLcTBQUDI1TXdDa3FxdURSakYrQWZ0dmNiUFN0RXBIM0F4?=
 =?utf-8?B?MnVBbW9Kc1hBMEFzQnk1UUVlam1PTVlienpwVmRsU1B6NUxFdzY1d0tuanRY?=
 =?utf-8?B?dXhCUkUrdjJxVnBrSHRmQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RDl5VFJGTk5RejRPeno2Um5FR2dIVktta09FSjErVXpUcXFGcldUZUFBdTVP?=
 =?utf-8?B?QXhwaDJMNDBoN3cxdkJDL0YzZGtWbEpoVVpzeEZxL0ZMVm5VeEdlYWNyaGVB?=
 =?utf-8?B?Q1RyUVhDK25BVGoyM2hwbzNlR0pDRXZYMFllK2tEVnNZRnp4NkR4T3hubGZi?=
 =?utf-8?B?UUlCbUpvU2Z2b2ZUTnUxVktCM0VZVjR3QUxnYi9ad1NxYWZQaUtJN1V5RHNO?=
 =?utf-8?B?Zy9ucFBFM29sWDhYYWFOT3c2MGpXREtrSlUvemJJMkY2RzNUTWR1bS9yTUU5?=
 =?utf-8?B?bzZDRkE0YzZtZVVvZGV1TkNIc3ZKL1dZbUVLN3lrNHlxa3hZTTl0aFhObUpF?=
 =?utf-8?B?RmxQcit4SkJ2SFF5Zk4xOHcvL2EyM1BFRmdXbFlFamhCbjlCZSs0RDFUWmhP?=
 =?utf-8?B?RE1yZitmNDlMdnRCdFNoelU2OEdzTjdSSTRWbXA4amZ5OHMvLzRoRUJKK3BO?=
 =?utf-8?B?UldhMDBWRDRncEVGLzVxbTgxclA5L3lWdFdWaG1lTjkyaGt6WkEyamdYdkRM?=
 =?utf-8?B?VkhkMFZBNWRsMThseEl1OHVhSFlEQWRvZW9aQ0Uxa1AzdXJCNTB3L3pmemRL?=
 =?utf-8?B?R1MySDdvbVdSTE5meDM1UXlkM2RoakhxMW56KzIwdmtIS04vYVBuQ0hwdzNZ?=
 =?utf-8?B?aldlYXRlSS9sQS9XYTM5eVFqZmhqbUtUekdlVFpISXp4Z2RuWWsyUGFXVVRx?=
 =?utf-8?B?R0ZPRCtkOHEwczd3dzk3bFlodTdic29KMzdVNFczT3JiM2RNSVVNN0VHL1dU?=
 =?utf-8?B?K25YOFQrbzliQUlJTWVoTlNzMk5FWVdGeTYzV1daaHZhZURvcGFrNVV3ekZ0?=
 =?utf-8?B?ZUp0VE5JSTgxdEpwVFZza0h5MUdGUUdOenF1VkZRV3NvUHc0aVdpTUw1WDJ6?=
 =?utf-8?B?b1hodzRTc2U4ai9JWDdJNDExNmVyY09HeUJreXVCbXJOeXhJQlF5WG5LOHpv?=
 =?utf-8?B?dGh2WThOd2kvUU03eG1pdHEzb21pMjZYMjhXMFJEczN6QktRRkx1ZmJ1N2c1?=
 =?utf-8?B?SWc0eW5Mam9MMXZPSTFxZWtqenJNRE4xR0RheTlDbzg5czdueGltWmtiQUU3?=
 =?utf-8?B?YVNVbmNvUDB4VCtETTRiUmh3MGJQa0FLTS9aNW12QUIrNlZpK3JiTHJDTVZD?=
 =?utf-8?B?QlFsR0R3bk82OHFyZERqbktCcjM4MUNsdmlWd1I1WUhBUWhYbWtMWDJwQkdX?=
 =?utf-8?B?WE50aGJzQ0pIVityUnU4Y3I1cVpMN1g4d0luWWs0N2JWekdxL0RJQnJiUmp6?=
 =?utf-8?B?VDBNL1hMRnhac2JlVk9hb2FVakpSazIyVDhoVlAxWGpMak9ueVR2R2JhOW5J?=
 =?utf-8?B?Y3QvcGM0bk5hUFpLcVlTT3g1dXo5QWlNOWMyQ1NWdkFuQW0xVmtsdG1MYzE4?=
 =?utf-8?B?d1NBR3ViK2NKNmM2YVRGVkFEUVY3Z0VqV0hLbXlMRDRDRWtkdjAxTytZMDRs?=
 =?utf-8?B?MVc3azA2Z29mOEpsMVFkM1NPVFFDdllnamRyZXZWL1R5b1BNalNKeEtzYm5Z?=
 =?utf-8?B?QXRuMFp1TTN3Ulg4emJ2aTM3YmhOQXErdTBmcE91SFIwM3lpamc2aW1RVlZZ?=
 =?utf-8?B?VGN2SzVTbERLTy90eTlwNWt5cmpFY1RBUzZpdXhobG1tQldUaTN3Y2xMT3k2?=
 =?utf-8?B?YnBodjIxdDhncC9nQ2w4MnRHK3djZWt3ZHBuVWkwN2JDVHBHTWJDbjZWVTBY?=
 =?utf-8?B?dEwvbDZtd05UR1F6TTJWVy8xMnZrc1FFZFF2V2IyTi9ycTh4ZWRVVmJMaTda?=
 =?utf-8?B?UU12djU2aGlTb0ZnRXhwOFlISFUyR0JobnlmOWIxWWdDcFl2MUxuRmc5ZzY4?=
 =?utf-8?B?TXNlQmFET1kyenlJL05KYzcyNTllRm5GeGsrY2N3Ly9heSs1RWJHVEpWVFZS?=
 =?utf-8?B?MG9sTTZCKyt4cHB5alkzVjkyZ1p1UlYyRVUyRXpqSFdqbTJGQXpaRW9QSzND?=
 =?utf-8?B?dUNLYWdRdXcyREpZZTdadnphWHFVNFZtWkNKMkdrcTVLZGJaUGtqMXRRNTEz?=
 =?utf-8?B?UTRLM0owZ3MzSkI1UHU1Sy9PSlorTDk3Z1ZTL0dSd3lNQjloem9WTUdNTXAv?=
 =?utf-8?B?bDg4clg5WXRwaHVXRWMwSmUwVFZLdWxhVDluQm1rUmRXZnBQTmVhamFucE5y?=
 =?utf-8?Q?HXwQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19b684a6-622c-49a9-c8f2-08dcdbfff8f7
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 18:46:02.1699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xrp0VHSN1GtlGlLfdkW22OU/f3SD38MD80hWM3HYOckWkqMDGcjG41p2chLysIbT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7354

Hi Reinette,

On 9/19/24 11:55, Reinette Chatre wrote:
> Hi Babu,
> 
> On 9/4/24 3:21 PM, Babu Moger wrote:
>> The event configuration is domain specific and initialized during domain
>> initialization. The values are stored in struct rdt_hw_mon_domain.
>>
>> It is not required to read the configuration register every time user asks
>> for it. Use the value stored in struct rdt_hw_mon_domain instead.
>>
>> Introduce resctrl_arch_event_config_get() and
>> resctrl_arch_event_config_set() to get/set architecture domain specific
>> mbm_total_cfg/mbm_local_cfg values.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> 
> This change looks fine, but could the function names be more specific? For example,
>  resctrl_arch_mon_event_config_get()/resctrl_arch_mon_event_config_set()?

Sure. will do.

-- 
Thanks
Babu Moger

