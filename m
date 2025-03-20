Return-Path: <linux-kernel+bounces-570348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CAAA6AF2E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 21:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4F7617D67B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 20:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5683B229B0D;
	Thu, 20 Mar 2025 20:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gsavcUHE"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2083.outbound.protection.outlook.com [40.107.101.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0AE2A1A4;
	Thu, 20 Mar 2025 20:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742502565; cv=fail; b=ZrFO5JwcsVIsTkNR/oTPeRHEsul2clsoW8eTRiB+Nf/1QOnvHDd6zWEddVMJHILMfcu+Iu+5vKgAOagbzzLTw/c2jjl9wUGBqfqvZl996b6YD3D8M8jROKvS8HAbAYSIjg9v5E2YXN1JXuyyaEOawLyjI39w0zz4Js8nEf8w/00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742502565; c=relaxed/simple;
	bh=222yo6iLVt9/WPbPAb5lhYAtXWBVWrGBZ5UJZgs9Czw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KhVvaNQ94OpxEXaNQzjAywyjIPBBxB9dC3HBYdHTEeczg/AbIrKBgY8O/5q93werzYQ2mTpl9kb9GBvoB3dHaNNB/vfYcyAKXQ0nLYv76bLMHNZ+eOYkOyxCULpnwq97Diwhoc5If4AoZ1tLWQ3STv0+RgeliObMXkjyNpYyFmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gsavcUHE; arc=fail smtp.client-ip=40.107.101.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pnmL/lxgyTf7RFPeYYtuOa6RPZ/ayMWBAeN3ZR6I7JvkHGzz+WMTFgIeVhIOQj//UpFOFLKXsjQC21BUu6OFIxxVqdIpw4ruTWCbT9urPHhvtkfIyyw0akpzjr7tBPvsS/hlH6tPgoLJWT9YrnV17Ku8A0rrYKgWfqmgo4n5u4gyosVUJyt/bs7/KyaUN4+2yxORVOzGYoZbSGs/y6hIK6IVaiflSdCrbFwOXXGAQaUwRGcRQ1sqJ1mwdVpPebAzqyjmdjykGc6ldu8V/g3bMHpg1CIoLrovwTqncMB0CB1wnU4/r6yInMNpeaEcf5zTkfrVxIEAw3lF9LpNQeIo8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YrUTLoSgG+MJ5S/FDZA1kCa4WxycjLQaDUBQ7F1vQA8=;
 b=H8MozzGm49ZgRuTJtt+ZkveP+gMG/ImbM5vf1rgrlEQk9t0jhPeLIIaMMJ1a+kZicslOF/WQzCRd9Btq3SzVs8Nryt/RCL6PDtIWtYChl7pcza12AUp9AU5Hv/hiYtyyCzE8igG8zbGB9HVw+0c396gAT4mUy4helKU9KBbGXkDYiMBWrXujwGueSPVNH/+Ob+UywWYKFziX12yeF7d7qkwVKcsF4CzzQz7WwIKTBAj6sAy/8myovO4KKGNbOR6ZI5rLZhzwKdJcxsMt9vmnDUA32s8gmkFGAiHttC02OsAnkrJcNZmkG+mFReGOzW4FRZoZFisY/KFjt70guf0u1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YrUTLoSgG+MJ5S/FDZA1kCa4WxycjLQaDUBQ7F1vQA8=;
 b=gsavcUHEWwNKkD6feJx+LHbUOmx1QxipMq2L5CJrSrM1vtS4pIyovuXFkj+23bz1LLDuSfx2TrqoUE35wccpB7Q6/9Iv6y0A8Tjo1sK3QKCAio8Wm3w5qfZf7wdLwv0skubPGYU0cA0GoneSrwdUOsyc8Bfyc9Ecvg/vOuqODP0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MW4PR12MB7481.namprd12.prod.outlook.com (2603:10b6:303:212::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 20:29:20 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 20:29:19 +0000
Message-ID: <7853e74f-661f-4e24-beb8-560998f230d6@amd.com>
Date: Thu, 20 Mar 2025 15:29:15 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v11 00/23] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
To: Reinette Chatre <reinette.chatre@intel.com>, "Moger, Babu"
 <bmoger@amd.com>, Peter Newman <peternewman@google.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, Dave Martin <Dave.Martin@arm.com>,
 corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 paulmck@kernel.org, akpm@linux-foundation.org, thuth@redhat.com,
 rostedt@goodmis.org, xiongwei.song@windriver.com,
 pawan.kumar.gupta@linux.intel.com, daniel.sneddon@linux.intel.com,
 jpoimboe@kernel.org, perry.yuan@amd.com, sandipan.das@amd.com,
 kai.huang@intel.com, xiaoyao.li@intel.com, seanjc@google.com,
 xin3.li@intel.com, andrew.cooper3@citrix.com, ebiggers@google.com,
 mario.limonciello@amd.com, james.morse@arm.com, tan.shaopeng@fujitsu.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 maciej.wieczor-retman@intel.com, eranian@google.com
References: <fc3a67ee-6e97-4b9f-88d9-c24c6dab20c3@intel.com>
 <d1ca9220-1ab7-4a39-819a-03a6069b7ac4@amd.com>
 <CALPaoChLL8p49eANYgQ0dJiFs7G=223fGae+LJyx3DwEhNeR8A@mail.gmail.com>
 <a4ab53b5-03be-4299-8853-e86270d46f2e@amd.com>
 <c1c0a99a-a467-4ae6-80ee-04b6a9cdb6e5@amd.com>
 <Z890Q2GoP6GecwW4@agluck-desk3>
 <04e47d0e-6447-451e-98e4-7ea65187d370@amd.com>
 <6508cf67-3263-432e-892c-9b502b3c6cd4@intel.com>
 <f8a20ed8-6e30-4cff-a96b-8df89a605081@amd.com>
 <d07a70f5-b1ca-4766-a1d9-53988dd9164f@intel.com>
 <14c14b11-5b45-4810-8e46-019c8a67fc90@amd.com>
 <1db8ad73-5194-4821-844a-8fd7cac72ad4@intel.com>
 <9b8653a3-c6fd-4748-a4b5-94d5598d180f@amd.com>
 <20ec195a-c4dd-48d9-89f6-4d48fd438fe8@intel.com>
 <be6d23c8-3e93-4bdc-8b33-d3af7df7cc94@amd.com>
 <7f54f9aa-1102-49ed-b830-6facb6f48366@intel.com>
 <CALPaoCj7aSVxHisQTdKQ5KN0-aNzN8rRkRPVc7pjGMLSxfPvrA@mail.gmail.com>
 <8babbd2a-50ae-4a18-8e48-5421539ef0e6@amd.com>
 <ad3867b7-cf4c-4098-9639-e98d1145617e@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <ad3867b7-cf4c-4098-9639-e98d1145617e@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0011.namprd11.prod.outlook.com
 (2603:10b6:806:d3::16) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MW4PR12MB7481:EE_
X-MS-Office365-Filtering-Correlation-Id: 749e3ef3-5974-4b0b-0f01-08dd67ede436
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M29MQSszenlQM2kyeVJnTEI3a1lZT3R3b1ZMZ2h5TmFUeFlhUWxrR2h5Z0Mx?=
 =?utf-8?B?dXVJejE2UFJqNnZ6NnRzd3ZCa3RyeUlYdFQrc1JkQUNCRncrbW8wZ3RWbkE4?=
 =?utf-8?B?dmpHSnRnZE5TSzBTYktMUzhWY2hHbGg1RlBESkpJOE1XYlZuQ25oV3V5d3Rz?=
 =?utf-8?B?eEg0TitaVERHY3RlWlgvNFYwRndvbWQwYThpMGovLzNFRHRyTWExNVkvc1dV?=
 =?utf-8?B?YmcxODBrNy9LeTBUT3JrMkxrVVZ3a0lsQ3M1Vk5LYmlCTXBFOVBFck45aFFB?=
 =?utf-8?B?MU9MeXJtak9DeXg1eWFGV29BVWlPczhPQWNYaGEwVDZLSWFhM2JwTUpaS0pR?=
 =?utf-8?B?bWxnYno5VjhnTDQrN0dxcERXWmMxUDFRMjB2SjhrTmFlcmlXb2gyeTBjVFRs?=
 =?utf-8?B?N3Fvc1IyY3dtYVIzOVZ5N0VsRnVnMnVjS2lxSnNsRlFWMzhCZjBkSGpSU0I0?=
 =?utf-8?B?dWNnQnczS3lFOEhhSjlRdkdNYlNlcnJURXVpSFZPbm5UNTlFcjE0Nm4yOHhu?=
 =?utf-8?B?Y2RORWZHekxVZEJ3cWtNd1JDUkJpME8zbk9KQ0hEMWxYWEZpczNsdW5jZEZD?=
 =?utf-8?B?TW9wVVBUeEdOVW5NdDdBZTJycmJLeXR3UXRiTkRROVl4Q2E4Z3kvSW9NcGww?=
 =?utf-8?B?RktRUEwyck0rMGpmR2dPY29UNSs3R3NSeis4ZU9CcjF2c3Zuc3hGT0NFY0FI?=
 =?utf-8?B?cEs3b1dFMm9HM21vZ0RLM0hmNFkzbUNIUzROV1dHWlV0Q1JKRnNNdG13NnlP?=
 =?utf-8?B?c1BzN1VxRklDTHY5TTlaRmY1cnUzYklCNW13ZmxjQVdES1padUhSZy9vSlEr?=
 =?utf-8?B?WU5pL0hMZGNmeFNQazRYb3FLaENLRUFNbmx3M3lSUW5RSkd5ZUYwL3ZYWHcy?=
 =?utf-8?B?VDBNK0ZRRERtbm9jNmFhblQ1ZEhObWpyWHJBZTdVUUlGUm0rR281cW5ydDVl?=
 =?utf-8?B?VUpOMGNKYjFqMmhLZWFGNE9kNFU1aWhWWVNXemFpRU5WaVVXYm9ZYzBtTkMx?=
 =?utf-8?B?amRsZHBwTFY0VkpXS0srRmRnekpuVk1YNzZHVUhKZXZ4eGhlWFZyNlZIaGQ5?=
 =?utf-8?B?Rm0xY2lVNThMQnlsSXhKUzZSODhwTjR0NW80N1F4K012RGJOMFFReGlINjZn?=
 =?utf-8?B?ZWxpeVYxeFZ6U2ExUThESUl6TWIrZTFDWnM2WGZzOHJZQW5CZ21aZGFvYitZ?=
 =?utf-8?B?UzZ5YkRkNG10NklCWncyVEdBbktlTXB4L2FvY1hOUzI1Z3NCMERLeEkxYXda?=
 =?utf-8?B?YXk3NU03YXAxZGdZY3NLTVdOQ0ErdmFpb0JESzVsck9tSklTeGNmRFg1VkVZ?=
 =?utf-8?B?WWR6SW9PdGMycS9uRWhvSGREMVNPZ01GRWlodHFmNnBCNFlHQitVZDZvclpV?=
 =?utf-8?B?elh4UTlNMHJ1OStKZkVsM1RBSXgrK2hBVWE3L093ZzRjOU1zTVFocnRnWWZs?=
 =?utf-8?B?WjdHa3dicFlieE1iT1ZaUTl2RFN2TkJBZngyZFFlNWVaTFZEbGhYZmt3UnRM?=
 =?utf-8?B?RVAvYnkyd0l5VkdPMXRiOFhUL3M3blJKblAxVU5jWWFSVklva2k3MFp2ZkhH?=
 =?utf-8?B?Q2hMamtEdExpOFd5QndJdXhtOTI0TGxobVdBZUhiaGRtRnRRYVpFa1F5dHJy?=
 =?utf-8?B?dXVjVTFUdXdoS2RrS1lka2hhdHZvTG9rbzZnNXBlTHl3cHQrQ1RrS0FBS3Z3?=
 =?utf-8?B?em9iMFQwNWF2MXVUZUNXaUdKbUdWTi8wNkJ4MkcvbzZaTFpzMFZBd3M0T1l2?=
 =?utf-8?B?OUJaS1pwVXBWSHFUdmZmcXVsNTdkMjdBWjZLU1RZVGdjdjlWSEQwczZFMW5U?=
 =?utf-8?B?S2tCcXNMeVVTQnhGU2FPZjVyMVBhYVBaOFp4cUFVUWhrUzFjWVF6dVlWa2Zj?=
 =?utf-8?Q?P8qapAM5HepZl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RUZzNkRqd2NNSGNDWG5ObjMvenMra1VXajJpbXFoeDBWZXB3bHZZZDZtb1Z0?=
 =?utf-8?B?ZGxaSk9ucExxbkZIaEVUL2d6aXRVNllDeHJnbnZ0ZlVyN011cUVsOHdhSzFa?=
 =?utf-8?B?V3ZuZHJDZU1BNjF2eGQrNktkME5iMGp4ajVWL3JEU2Rrd2xUM2ZNc1dtcStZ?=
 =?utf-8?B?VHpWN2dYZHVaeVIrWGk5THNtajZMaUFaVEM2NDUxSGVUM1orTjVZbkptS3VX?=
 =?utf-8?B?Y1ZmaGNtczdFTE1VeHFRc1VCRjFUQWMyWEk2aWltTEhVRS9zNXVVVlVRMnVk?=
 =?utf-8?B?czFockcxWFpWSG01MmVMWlVYd0hvWVA3Q2hydGhmY1ZuaWVybUlEQnN1cXBn?=
 =?utf-8?B?T00zb0Rrakw5akJ5bElVWWN5ZUNJYzZ6djlqdjhTZEtRRDZ6Rk9sTUpqdzJR?=
 =?utf-8?B?R1NqZjU1QkxFTUJZak5zSUs5YVlSRFJLcWRma2kySUdTN3lpNzA3ckNSRUZI?=
 =?utf-8?B?OHMxOEdZUlBhd3U5YjYrZno4Y2RwRjZ6eWRPNlEwc2drV0NwWm1QNkREaVpS?=
 =?utf-8?B?Mm80WGdPRTlDUWFRRW80WENDRkh6MHRCcEdBdmJDQzFVV0ZpUHd1VDd0SUx6?=
 =?utf-8?B?a1Y4YUxEVC9pTHNHdDJOS1hTVlRXOUxMb3lLUXptS1dkS0hXcE1MT2d6VSti?=
 =?utf-8?B?RktJSHhwenpwVUs5aEdaa3VOL2lUUEg0MW4wdTh3dXZRTEpER2E1VXdqa243?=
 =?utf-8?B?dTlJQXJyMFFWMlBaKzlTVXg0RCtMZ0MrSTZ4bm9VWjZOY0RFaURkV3IzdWpp?=
 =?utf-8?B?QlV5QjNpbGpQc0pxNTFkVWhLNVFZMjhoVTZRNnZobGdvWjg0eHF2TEx0NEZ4?=
 =?utf-8?B?ak5wMklqSW83V0NLTlpHc3Q5N3U3MmJVUWlQaVBhY2ZzQ3dkSTR6cHF4WURl?=
 =?utf-8?B?NWRCblNNRVZiZGZlMk1pL2hmYmd6U01OMnpBNmNLVkZDa1JHVXk3TFJwYnhP?=
 =?utf-8?B?elNNQWZEWkFFR0lEZmcxVTdGV2ROT0N2NzNDKzVpNHQzemJ6d2d3ZU5HQzhU?=
 =?utf-8?B?NC80cFMwSitpR3BqMmgwYUpJb0hmTXE1Q2ZIRnVGaS90VUo2b1BxMTV2c1Rp?=
 =?utf-8?B?RWRWeUVWL05QTlZVWUdVbEpwNFdvNFJ6MnI5Ni9QcE8rbDVLcG44amFpOHA2?=
 =?utf-8?B?VXVQWHJmcmFpYVVEek53STAxRUo2UXQ2bnR3c0h2NFI3WUFGTXZOM0VSYlJl?=
 =?utf-8?B?MjJ1cXFCMFdlMTI0ZlFEY29BLzZxM1c3L3ZreGpYalU3MlV3UE03MWVTMnU3?=
 =?utf-8?B?SHZ0WHc2bjF6aUd0UzJlQmhwRUhmUkVaMjkvUHJMSWxwYTZpL1NYanZSRGhy?=
 =?utf-8?B?dG05dUwzUmpkMkM0bFJHM3djK01jYnNsdWZPWXJtZWV3QmhGRS9XRTBLYThm?=
 =?utf-8?B?Q0JZRkl2dWlZVUVDNmpHRGQ3d2M4Q3dWaHhvRVhrZjRJZlNmNUU3aS8yQkhR?=
 =?utf-8?B?dEpvQUZoM0tMM044VDlVN2FKWU4zWDhuRytUZTBhcHFqNWtLMzJyeFhxTEZv?=
 =?utf-8?B?MmNFQVR2bjNxS2dUZ3FUbm4wTkQ5SHhYY2Q1S2svU0tTejZ6TmtjMkIwcVBE?=
 =?utf-8?B?bnpMMjE1YTRtb3VwejNXTU1mcWJXYkVOaHBON0xXa2dROWVlSlIzMG50Um5Q?=
 =?utf-8?B?SGtvUHdaQ0pIaFVhRWViV1hNK1piTTdlNkdHR281V3BxY0JxRmh3R0paa29m?=
 =?utf-8?B?enRSeTEzWVZ5Q3lzaER5Mk5TMXIrK1hyRjZCVklESW1XWnAza3dSNXp3Ui9O?=
 =?utf-8?B?bHNIYVpPY0c2QlJQaFZRcnV1bkFPUGUrejE0cUJCSmZuYUtLSStMSy9SbHBS?=
 =?utf-8?B?RzR4MHlDdWhlSURGQmcwZy9KcnoyLzlSV050eE5FZ2xBS3dDV1BTY1lwbHp6?=
 =?utf-8?B?dkhxRU1yUXpRcXljQ1VPd21nMFY5ZTU3OEtiQzRvUUJJMkRaOEQ1Z2o0Z0M3?=
 =?utf-8?B?OWMyaVl3WlNoMFgxbnlWNk4vRm1uMk9tdHJ0N09wN1JoM0RKL0Fqc29UR3Iy?=
 =?utf-8?B?TlJqd0ZTcXdoOHc3cFJ6TXllZ2Q0VXh3SW8wcmplTTkyWXZ5VTN0YzNDRDRx?=
 =?utf-8?B?cmRLbTFJV3pPdVV6ejJOdmViTURBUnpzTTVLK0lWRXFNY0J5TmdybDRsbjdQ?=
 =?utf-8?Q?9ozI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 749e3ef3-5974-4b0b-0f01-08dd67ede436
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 20:29:19.2324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ks6akpT/FdXv0txeAdiSWpH1128VGD7T4pQbofMa+MNOhNrrUnQ9vvlI2j7G/BDh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7481

Hi Reinette,

On 3/19/25 15:53, Reinette Chatre wrote:
> Hi Babu and Peter,
> 
> On 3/17/25 4:00 PM, Moger, Babu wrote:
>> Hi Peter,
>>
>> On 3/17/2025 11:27 AM, Peter Newman wrote:
>>> Hi Reinette,
>>>
>>> On Thu, Mar 13, 2025 at 10:22 PM Reinette Chatre
>>> <reinette.chatre@intel.com> wrote:
>>>>
>>>> Hi Babu,
>>>>
>>>> On 3/13/25 1:13 PM, Moger, Babu wrote:
>>>>> On 3/13/25 11:08, Reinette Chatre wrote:
>>>>>> On 3/12/25 11:14 AM, Moger, Babu wrote:
>>>>>>> On 3/12/25 12:14, Reinette Chatre wrote:
>>>>>>>> On 3/12/25 9:03 AM, Moger, Babu wrote:
>>>>>>>>> On 3/12/25 10:07, Reinette Chatre wrote:
>>>>
>>>>
>>>>> Here are the steps. Just copying steps from Peters proposal.
>>>>> https://lore.kernel.org/lkml/CALPaoCiii0vXOF06mfV=kVLBzhfNo0SFqt4kQGwGSGVUqvr2Dg@mail.gmail.com/
>>>>
>>>> Thank you very much for detailing the steps. It is starting the fall into place
>>>> for me.
>>>>
>>>>>
>>>>>
>>>>> 1. Mount the resctrl
>>>>>     mount -t resctrl resctrl /sys/fs/resctrl
>>>>
>>>> I assume that on ABMC system the plan remains to have ABMC enabled by default, which
>>>> will continue to depend on BMEC.
>>>>
>>>> How would the k existing BMEC implementation be impacted in this case?
>>>>
>>>> Without any changes to BMEC support the mbm_total_bytes_config and mbm_local_bytes_config
>>>> files will remain and user space may continue to use them to change the event
>>>> configurations with confusing expecations/results on an ABMC system.
>>>>
>>>> One possibility may be that a user may see below on ABMC system even if BMEC is supported:
>>>> # cat /sys/fs/resctrl/info/L3_MON/mon_features
>>>> llc_occupancy
>>>> mbm_total_bytes
>>>> mbm_local_bytes
>>>>
>>>> With the above a user cannot be expected to want to interact with mbm_total_bytes_config
>>>> and mbm_local_bytes_config, which may be the simplest to do.
>>>
>>> How about making mbm_local_bytes and mbm_total_bytes always be
>>> configured using mbm_{local,total}_bytes_config and only allowing the
>>> full ABMC configurability on user-defined configurations. This could
>>> resolve the issue of backwards compatibility with the BMEC files and
>>> remove the need for the user opting-in to ABMC mode.
> 
> hmmm, yes, backward compatibility is a big issue with an earlier suggestion
> from me. Users with scripts/tools using mbm_{local,total}_bytes_config
> would expect that to continue to work on systems that support BMEC.
> resctrl could continue to use mbm_{local,total}_bytes_config
> even though the inconsistent interface is not ideal
> 
>>
>> There is no opt-in mode. ABMC will be enabled by default if supported.
>> Users will have option to go back to legacy mode.
> 
> I assume there will still be the opt-in for automatic counter assignment
> on monitor group creation (mkdir)?

Yes. It will be available.
-- 
Thanks
Babu Moger

