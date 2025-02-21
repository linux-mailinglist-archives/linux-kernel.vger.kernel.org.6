Return-Path: <linux-kernel+bounces-526434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BD2A3FEAA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2493017AB7E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267951FBCB1;
	Fri, 21 Feb 2025 18:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ygh2BYbC"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDF7250BE5;
	Fri, 21 Feb 2025 18:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740162201; cv=fail; b=OxidzKhd5xHDUUeX4k+gS0fLnAOpp7/InilPQviAYnQngFwlnJe8KPEkrkl+OdjlQYD2FpKdE2pyZc6hK3VgckeflBaLxq47bdMQT41RLM8y0sk7XkBvZIAGEeIaN9owiz6FGyBqcIhffSiKyhOdySsKkHRCLRrqthwwAlBTA3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740162201; c=relaxed/simple;
	bh=HgNaXCcOcTytJ29EoOYtj05RaUV1JuZu2k1Mu/R4EbQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VkRB+gxclpcyrsAIXosqgEggj3v0Lx9Mnltss2Aaa77OvXI6AGNIC3/DrVPDNkqCS1B6jL/SSwLExrcgeKiG8FB+5Zu90EFWn/0OO1qn5DOgsUjUIOZUytPeGmAGMaAuLZBluvPWojmn44mTgPcbm6MeANn4Pwmo2yZgYV3GzqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ygh2BYbC; arc=fail smtp.client-ip=40.107.236.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jSNujWt3Sn5L3GnfZcj2n7eE/m7iH5ZK7J0H1pgjFmv6a3vs36TLuO6zuQW8uy9qVRz9oqdPBDKjyPIGvjiCDY2LPWK5DypHl0DMazTkU2ci657/WmEOHS84VQllrEJ+yuEB57AySCeJBhXRao4ffpxKqH8B1IiIGWTfffvgUFxdya8OxL6i4KCYONwFZRPjw6ArSDlCgSie7YD845uyCNFRyMQ2c/xOBceUbvUPMAvYLaU7cQLOzYr7R4xYrHsZN5oJp/HE5nHzGmI7riYF8nn5qvnIGdReW+NA65DEBvrzd7REYgm/kqdshFdt+1hUzaSg/KCIYi+MrHKOgfeAVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZ88hC6QPuXWECJ7Tct96UujFXfAt3FCCyAl16jp2Xo=;
 b=rvj4Q8k6MTnbkxAz0PA2sCmZitiMz7JxT+leDjmP/5wsji/wHGPnAiddzGku4FQ5ZISKEpJNplBr5Ad6RMe+zSns4nmgbAkxrrAQWxLRAlRFvNCqu3FLd5nlI/Bo7+6wVo8ydzYdxH/iEONQ9w/TZTMrJ6oq+PRDt4wDtmpqW6vF/4zwoQK4NwD8grwEU3DoeK+aKuWnA5bvWGHRUhHDE5ftgi3S942r4w4k3b0gOv4keT3r9lBZ2fq4CS+F9vOAO4s/jucfBvWjseYsuv2lYVZzFazmTVX43bwFylFw5SvZhN5jfnMVrnUKdQkYKjPPHwrsWTDjBdbvdjySnbtVIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZ88hC6QPuXWECJ7Tct96UujFXfAt3FCCyAl16jp2Xo=;
 b=Ygh2BYbCxPhsa7Mvf5LLf8IgULq1bGifP+CNj+GSpwrtJFCvmvclEBb/wuUlD886ORM1vSBHCDEVzPKiUnOQqbR7hiXb2tTDORiLFmZ2ABoZWTQWG/A4MhxAt8GAbdE9V6GnQilGOJle6YuAJS+nEAXetfJ85fZ2lfPioYIIa78=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM3PR12MB9287.namprd12.prod.outlook.com (2603:10b6:8:1ac::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Fri, 21 Feb
 2025 18:23:14 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 18:23:14 +0000
Message-ID: <5f651b5a-3470-4ca8-80dd-4593acef6df4@amd.com>
Date: Fri, 21 Feb 2025 12:23:08 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 17/23] x86/resctrl: Auto assign/unassign counters when
 mbm_cntr_assign is enabled
To: Dave Martin <Dave.Martin@arm.com>,
 Reinette Chatre <reinette.chatre@intel.com>
Cc: Peter Newman <peternewman@google.com>, Babu Moger <babu.moger@amd.com>,
 corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
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
 <2119b76ef8be21b1d8b2deedfab23e8e33ba724c.1737577229.git.babu.moger@amd.com>
 <Z7XfcV05ZZkHm6bc@e133380.arm.com>
 <CALPaoCiPkjbTf2He2tXsguxHDtGF+YfVUZScL8dseVc6rvAfvA@mail.gmail.com>
 <ac6860d4-92b4-424e-af4f-d6e3d5722232@intel.com>
 <CALPaoCh8siZKjL_3yvOYGL4cF_n_38KpUFgHVGbQ86nD+Q2_SA@mail.gmail.com>
 <Z7cw4JTp3Hfx/4li@e133380.arm.com>
 <2889da50-b654-403c-910e-13b9144596fd@intel.com>
 <Z7i0etOZcZ9jM/ZU@e133380.arm.com>
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <Z7i0etOZcZ9jM/ZU@e133380.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0041.namprd04.prod.outlook.com
 (2603:10b6:806:120::16) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DM3PR12MB9287:EE_
X-MS-Office365-Filtering-Correlation-Id: 3575c81c-a629-47fe-e1ef-08dd52a4cdc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?emlldXNkQXcrTGkwUExJZFd3Y3NwQVV6SnpFait4VzdyVEhvRmNVR2NsUkRq?=
 =?utf-8?B?enBMVWp4V0ZWelZEVDFpQVM2MTdJQ2hYWFBROE5LaVc4eXhWajRwVGtucnRT?=
 =?utf-8?B?YlZGQUZDZ1NKRHNXaXlwcnFVMm4rZXVoZEVKWUMrT08wNXlLQmlKRGp5RElS?=
 =?utf-8?B?VHVyNkRIbENnQU1Ic092SVVSUzhITktSU2xPU3A2QUNRc05SSjdGTWV2OTBD?=
 =?utf-8?B?eHpVYWM2a0xhS3lDaGQzUTNIaU1jRjRIWG1PTDk5TTc3ZzBxaDJVeXJFcmpn?=
 =?utf-8?B?bGIyb3o2aHdpU0hLVDhDelFtMjNjYWFkZEpGeWVkNjRVOUdpZ0t1anZqRDJL?=
 =?utf-8?B?TkNvNDhpV3BDQjdaYXhOMllYQWl0YWVqa2wvaytxS1JxalIyOEZKVE05UFlQ?=
 =?utf-8?B?OTZXRHFoMkZOUEFkV3pOMWJMMnF5eHE1VWdaRmJHMEQ0M0dhOEhWeFY5Z0ha?=
 =?utf-8?B?K0F5YzRZblpJQ0VMSTlwL0lSdGwwVHVKNjJFRUFHbDFyOEpVa0swTSsrWmlN?=
 =?utf-8?B?azNGTmFXWEsrUEJoWjNCK3R0RXBFWDZtbWpmMDB3VFFxd1AxWXpPZk1xQ0tr?=
 =?utf-8?B?elpqcVJNNkcyN0FEc3IxZmlDa1R4Q1EwUXF3UHJ3NERkZEVQUUpsSGNtbmpK?=
 =?utf-8?B?d1dvYy85eXVYV2hSaG9UOGhPaGtnRTY5bVQ0bm5aRWN6clhIdkxmWlRJM3R4?=
 =?utf-8?B?L29aY3NoRWVrMkpGRDJnbEs3blJUMURlQ2hCQVh6OUMwNFBFeHBoRmJFdXhX?=
 =?utf-8?B?K1YrcHRIcTdFZmNwYzc2ZDFpNGsvZExhV1JnMlh1QUFBVzJrS2lPZHVZSjJN?=
 =?utf-8?B?ZFpZWEZLZng3NUZtcEU3ZGZpWVRBOGMvRXZRcFY0ejFMRlJZdWpLWVpTa2ho?=
 =?utf-8?B?RG1tMnR1Vkw0S3lPRFk1SlFVZVM5a1UxVEJqSnh1VTE1Mlovd1pGSXc5TCtX?=
 =?utf-8?B?SXZKYW9jWmRIcW5WaXlDK0pKb2xIdkxJOW5FcEhhZWZHSEUxdE80WXRiRU1X?=
 =?utf-8?B?Wlh6aHpOS0hLaXJhSTFuNnVIdnhJYUNRQTdkYXk4NXBaZ3NQM0hWcysrS2dn?=
 =?utf-8?B?QzVOajluSDBNNmhxaWtxd0lpeHQxYTYvNEV5b21aZndvTGNkMzdBclBjc1l1?=
 =?utf-8?B?eXBJamtweUZNRU5JV0dXQU9mTlRaSGVSR3o4d1l4QXN2SHRpa3J2NFlyeEZL?=
 =?utf-8?B?VHdYV1B1a1AwblZGRjQvejVhUWpISjVqNG5XdlhYNkNPRTVXeG51SmtlYjdj?=
 =?utf-8?B?cWlUQTlOTEV0RWFnN3padmpWeGFQT1Zna0puUDc0NjBWNWV5NGkvbjk1Ykl0?=
 =?utf-8?B?YnpzeXNNWU1EUWlYeUpyYzlWT2h6RGtvNGR5WXhNeWlhM0pIV1h1Y29pazVI?=
 =?utf-8?B?S3o1VURDcm16U0xDSllhYmlEbmdZZGFDdDA2YnVCN2hxYnJWSVNYZm5nSHJW?=
 =?utf-8?B?QTAvSXZhVzNxb0RETmpZeWdjVnhPZVVmMGt1WGd3UVRFTXVGK21IRUxYL3Iy?=
 =?utf-8?B?amlNTkE0N2dnaGJUdHQ3L0hHMkhldjB4RGxzVlpKL1MxWXh3alIrR2dBOW5p?=
 =?utf-8?B?eW1tTVltN1dXY1JxMHkvOU96ckRwUW1qdTlkOHdlc1g5WmFnY1BZbm00aUs3?=
 =?utf-8?B?eVdZNXFHYWk3MWhwMkh6SjhnYmljM1VFT3Z3aHBzcXdRaS94S25mK0IwOUJ4?=
 =?utf-8?B?NzFwcHVpSGxtV0JqTE52OXNyRS84RGZTa0RkL1FBZ1FQNW9Ybll5aGwrWTdk?=
 =?utf-8?B?SVBpMWdSRkdWaVZscVZOMlFYNTJ2UHRRMnlBQmdlRXU2dUxLUTkvZDQ4cmxZ?=
 =?utf-8?B?RExIYWE5TlovVjlsaExUWWxnWHh0cCtENXVBZGU4Y3FRZGtmaWQ2anR1NWVI?=
 =?utf-8?Q?aUtBOhgRgEuGc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NmE5MUZjYzJ1TjE4VTIrMWxRdndBMGVjNTAwaTJiWGpQSm01REo0ekxDUXlk?=
 =?utf-8?B?ZXdKWXU0djQ4K1NLeFRXSGZlUmI1NkwvU3lyT2lzUVY3VEVJMW0zN0ZCVjlD?=
 =?utf-8?B?bC9UbjVKQndETmE5QzgwU0s2RXJNci94VjJmeFBIWE9KbVNtUUtvQ1ZhcGs0?=
 =?utf-8?B?bDZ4aGpudGlEdXY1d0NJTnc3TUdwKzJ4aWh2Zkc1bE15YmhnVzFybm5KZUV0?=
 =?utf-8?B?MU1JQWtLWDIrMS9jYXExWVFmeUh0MDRpRVk5UlhqNzU3OE9jd0VaL29LWXpl?=
 =?utf-8?B?bHpNSHhSdlZ1SW1QcTNtQU9ZWjBxaitqeWRxY0hBa2JnVnRLL3pWL1Z6VGIr?=
 =?utf-8?B?RDcyaVdMenZ3K0ltMDM4TW5zMG9LL3VESXMrZ1FaZlNjeFFkaW9pNEMyOVhu?=
 =?utf-8?B?SEw2WDFxSVlSaGJhaWxJaGx2VnF1NXZmQTdHeFNHNk5wZ0VZTVNrQlBFZHh1?=
 =?utf-8?B?bTdJZVIybWVSeE5VYzIvMHBEWmd2UGZBSTRIRGpBelNBUTd4bG1oRGtuenRi?=
 =?utf-8?B?eDVRd2hoSWNWRGJpVW1EeFdZTU9QMlh5dGhQWTBlWlJEWHlKY09pQTc5RXZM?=
 =?utf-8?B?R0wrbWFHb2Jyam1BUnZwa1U1VzMvRElKa3J5SmNLRFkzVDdTTXJ4VldrdWtu?=
 =?utf-8?B?aVVUMTdiR3NIRnhVem5XeFg1aWRKb3ZTZHpWTVFGUUFrdWhpUEdIb1NrMEY1?=
 =?utf-8?B?b0Mvc3RuTGE2WFAxQ3MrMFF1MnFLaDJVdWRvNFJ3ZlFCSUdwcVNmTGh4YVVH?=
 =?utf-8?B?MUZtK05HK0VNU21FSWFKek1CSzJxSUo2MFNEUDRiQnYwaDBOV0F4VGMxU0lk?=
 =?utf-8?B?NGE5RCthbkVJWHBWUkRPSndCNTlWdDRyeDVnckxkVzV2ZXhjeDJPdFVIMjlG?=
 =?utf-8?B?UHk0UlJVaExjTllaaitZYUpZVjFoZ0xNc1U0OWZ0eWZxSS83bzNxci93Yjhy?=
 =?utf-8?B?bWdIWkw2enpXNlh0RDBoeXdxYmdBWFQwWXFaMm5Za3BnVW9odjR5WjVWQnpQ?=
 =?utf-8?B?dUNMTkFaU0g0K0dxSUtEaksxZS9rRll3OXg0Vks2ZEczRnJiM3JiSit1ZUUy?=
 =?utf-8?B?cDJ5Ym9VbkE0SHVJNHdPM1JzZGpXc0djcUphU1I0M1orNzJwaE43NjdDa0c4?=
 =?utf-8?B?bFZ2K0NQRFVDNGJEd1AzZHYvWWZkdTBWdXFnZUJ5d0ZBcyt6M1JrSHVRNGNJ?=
 =?utf-8?B?eEhhQkJmVFV6a21UcVJBZC9UOThCQ2RSQmRXQWp2ZWZOUVpTWkN2QjRsM0ds?=
 =?utf-8?B?bjN4cmYzTE5ubFhPS0YyYUJsNzRTNWs0RWkxUmhWb1Azdm0vam8reWd0dkNW?=
 =?utf-8?B?R0l4L25QMzNGMkJHNTlpR0QvTmVpaEdBTlI4OHZtVGpYQ21KNjRZODBBZGZ4?=
 =?utf-8?B?eUFXTUUrTUpTVmtSdTE4M2ErdzF0VEJ1dEJ2dytwUDgrUXNHV0tVRFVTdzEw?=
 =?utf-8?B?YVByaFpYTFE2aE5vZ1JJQW9IdzVqTWtYRFRPQlRVSC82cSsrTmdJOEE4VCtG?=
 =?utf-8?B?RERYam5FTFlDWmNwakFVK2ZaR1kvcklnRURxSS9lRkNTSUowc1UyYWFIRWx5?=
 =?utf-8?B?VHA1cHREKy9ONUpKQXVwVk9FODBucnQwbEM3ZVBla05YNkN5emZiSUtnQldu?=
 =?utf-8?B?a0gxYU1KMmh1TFpMb2oxck5rZTRrYkE3enhGKzB5YnlOaDg2a3pwVzQrNWlB?=
 =?utf-8?B?K1JjcDlBeVh6elZrUkRndnFRZGRlbCtvVmJQcEp0Znp0NlJDN2R4bEtXckZ5?=
 =?utf-8?B?MG81YkxoTTFnbmpNN3FEa2tacGhyR1NtVGpUUnR0TVdGZ0VwRTdaUkdzZUlq?=
 =?utf-8?B?U0ZYb1ZSRWh6dmg3UUdDUzRBam5FM1dxMEVzaUh5MXhtaTI4SmtFOHdCUllG?=
 =?utf-8?B?eGJFZVh0VXRoTng0WWtLajhDRm11ZDMxR2hrNEhZQVJod2wza1BqRDFWeTJY?=
 =?utf-8?B?NTdSaENOaExlLzBSdmRnVGNpeG8waGdKRWg5NkVja3FaVlVPMlpnVkRjVitE?=
 =?utf-8?B?b1RVUE0zWitoN1FCdWFQYjVvSzM2QzQyb3pLYlR0UkRYS0lNekZ2Sm8rdzky?=
 =?utf-8?B?MVNLUFBVSTR3Mk1uaWxoKzNzWXRhN0hKZHdXVFZCa21ZaWJaM1laeCtJRHlV?=
 =?utf-8?Q?mUX4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3575c81c-a629-47fe-e1ef-08dd52a4cdc1
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 18:23:13.8703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tmA9p8hU393OWNa+7WW+cQGHrJQ8xX+lCOrRxB7Ze9OoIEbMIk8cXDJOzA0pPtEP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9287

Hi All,

On 2/21/2025 11:14 AM, Dave Martin wrote:
> Hi,
> 
> On Thu, Feb 20, 2025 at 09:08:17AM -0800, Reinette Chatre wrote:
>> Hi Dave,
>>
>> On 2/20/25 5:40 AM, Dave Martin wrote:
>>> On Thu, Feb 20, 2025 at 11:35:56AM +0100, Peter Newman wrote:
>>>> Hi Reinette,
>>>>
>>>> On Wed, Feb 19, 2025 at 6:55 PM Reinette Chatre
>>>> <reinette.chatre@intel.com> wrote:
> 
> [...]
> 
>>>>> Could you please remind me how a user will set this flag?
>>>>
>>>> Quoting my original suggestion[1]:
>>>>
>>>>   "info/L3_MON/mbm_assign_on_mkdir?
>>>>
>>>>    boolean (parsed with kstrtobool()), defaulting to true?"
>>>>
>>>> After mount, any groups that got counters on creation would have to be
>>>> cleaned up, but at least that can be done with forward progress once
>>>> the flag is cleared.
>>>>
>>>> I was able to live with that as long as there aren't users polling for
>>>> resctrl to be mounted and immediately creating groups. For us, a
>>>> single container manager service manages resctrl.
> 
> [...]
> 
>>> +1
>>>
>>> That's basically my position -- the auto-assignment feels like a
>>> _potential_ nuisance for ABMC-aware users, but it depends on what they
>>> are trying to do.  Migration of non-ABMC-aware users will be easier for
>>> basic use cases if auto-assignment occurs by default (as in this
>>> series).
>>>
>>> Having an explicit way to turn this off seems perfectly reasonable
>>> (and could be added later on, if not provided in this series).
>>>
>>>
>>> What about the question re whether turning mbm_cntr_assign mode on
>>> should trigger auto-assignment?
>>>
>>> Currently turning this mode off and then on again has the effect of
>>> removing all automatic assignments for extant groups.  This feels
>>> surprising and/or unintentional (?)
>>
>> Connecting to what you start off by saying I also see auto-assignment
>> as the way to provide a smooth transition for "non-ABMC-aware" users.
> 
> I agree, and having this on by default also helps non-ABMC-aware users.
> 
>> To me a user that turns this mode off and then on again can be
>> considered as a user that is "ABMC-aware" and turning it "off and then
>> on again" seems like an intuitive way to get to a "clean slate"
>> wrt counter assignments. This may also be a convenient way for
>> an "ABMC-aware" user space to unassign all counters and thus also
>> helpful if resctrl supports the flag that Peter proposed. The flag
>> seems to already keep something like this in its context with
>> a name of "mbm_assign_on_mkdir" that could be interpreted as
>> "only auto assign on mkdir"?
> 
> Yes, that's reasonable.  It could be a good idea to document this
> behaviour of switching the mbm_cntr_assign mode, if we think it is
> useful and people are likely to rely on it.
> 
> Since mkdir is an implementation detail of the resctrl interface, I'd
> be tempted to go for a more generic name, say,
> "mbm_assign_new_mon_groups".  But that's just bikeshedding.
> The proposed behaviour seems fine.
> 
> Either way, if this is not included in this series, it could be added
> later without breaking anything.

How about more generic "mbm_cntr_assign_auto" ?

We can add it as part of "struct resctrl_mon" and set it "on" when ABMC 
is detected. It will be part of check in rdtgroup_assign_cntrs() which 
is called when new groups are created. Also, provide  user interface to 
disable it. Seems simple to me.

Thanks
Babu


> 
> 
>> I am not taking a stand for one or the other approach but instead
>> trying to be more specific about pros/cons. Could you please provide
>> more insight in the use case you have in mind so that we can see how
>> resctrl could behave with few surprises?
>>
>> Reinette
> 
> I don't have a strong view either.
> 
> I don't have a concrete use case here -- I was just trying to imagine
> the experience of an ABMC-aware user who wants full control over what
> counters get assigned.
> 
> I agree that the convenience of the non-ABMC-aware user should probably
> take priority over that of the ABMC-aware user, at least in situations
> where the expected behaviour is achievable (i.e., where we didn't run
> out of counters to auto-assign.)
> 
> Cheers
> ---Dave
> 


