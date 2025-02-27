Return-Path: <linux-kernel+bounces-537267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1199CA489D2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 21:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1B383AC691
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 20:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF3E26E962;
	Thu, 27 Feb 2025 20:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lfFFcKvh"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8610224889
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 20:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740687921; cv=fail; b=NNTtQHIFQkksa2sPGuLTV5YgSL4MPH5rgdyXoqYBlt077DO5Q77yO4MwahZ7jwyLa8jfYeF0M1mHsP1mcEJVg/Ysfwth0BhdzKMXR22pCzWGOziP5vBAxotjMMGG7RsG26JQmJ3vTf+Skkgjsm0zFbRV6too7muK+aon5v/fCoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740687921; c=relaxed/simple;
	bh=YmgzC4chyp+9xxuYqwyaz9nyNnR7fuvlfQ5n+gU2+hE=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N6FLELDRhUgn4o5mrQtZiFYJJe+4CDg0U/v6lKusBpMsCPYFJArCBgcYOhbv9BYtGpz3FfZyB2hCiDcopTUVhxreTi4PsS3/CSmmhAqrgVhKo29m6z6sGChz5kiIr0GOAkvoSRTp/LqmtdZGGeq9xnDD636AhkpvEuS1eAgH6p8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lfFFcKvh; arc=fail smtp.client-ip=40.107.243.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=owyC1muqZYwO1PVOB+N2wJHvgTe1ynNSfHxw+yYa+0xb06FGHbnDoY0arwP1pPjffiHvoVQhsQ8C0fzh0PePSqoL6y8n5ikwCT8tS5aWtwC0RfvX0inrwLxgUgYrV73c+bCXFNaQxADQWJkTe+TdkWY0hMR1Nw3w243BFsxJSmeuWQGSkZy9D2FllzVOkxmFigruLGV3BtDayR2rwvoisT1Y0/2zqQT/x7Benbg0ir0jpS8vCCsHDDc6ULOqvUQ5qgxItfDVbZ1M3+MvjqHdqy5Ej5/0XYCzEao1+QmUrrXU2Sh3TduPpk3U/dt7d6QhjSXffB2A6E+WhhcAsjdAGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KzuY4dkMGv17xEPCPYS9HERCfRs0ibpoBQbT9aDBWXQ=;
 b=NClgMc2wQqBO6MuL0CHZKQ2DKAZwlIyKdpT1fjyEZZpr5M3LmY+xrAU/W/RRK9xWYw0GCrJ/O07nQAwXkQ+3LbiZE5OdO3tjcOfIkHnm8dBnyPQpfJ5TRfVbfHQ4vj8kb/VKQWj7KSHHO68tHESM0W8Qyg9L9zWuplyjmEXUbMUT3UXOtNsjcm1EmCKV5bxVgrx5UHZee8YKQNDQ0r+wOayWG06qoetqkhOtXJ0SS88G6/Lem7/ZIg5/LDBW5g1rLGEIKvgsjyI9Yc+Jj/Uky+VEvslTR6UdF1TZxo0Q7IoOD9NpKmZF1q6FwqwwYAbF2lh4zXxj17lt5Q8gNi2n/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KzuY4dkMGv17xEPCPYS9HERCfRs0ibpoBQbT9aDBWXQ=;
 b=lfFFcKvhWT5wBZZXBatKCF2QaUJpQXNuZD6qyOBCoOz9vhZnl0TWztwEsPSH44K78uNAdljhrxxJR0JQKiOwFCk4TbJvIsZLtBqLYr3RVJPwtwWL/JxNqrEyFz+2WpoUvHpjay6J7CblVs3rYC6lbk59hJoMM6+5nubh72pV3q4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH0PR12MB7816.namprd12.prod.outlook.com (2603:10b6:510:28c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Thu, 27 Feb
 2025 20:25:15 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.8466.015; Thu, 27 Feb 2025
 20:25:15 +0000
Message-ID: <08d74c2f-29d8-4fd4-8f03-48c093ef7b61@amd.com>
Date: Thu, 27 Feb 2025 14:25:09 -0600
User-Agent: Mozilla Thunderbird
From: "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [PATCH v6 10/42] x86/resctrl: Remove rdtgroup from
 update_cpu_closid_rmid()
Reply-To: babu.moger@amd.com
To: James Morse <james.morse@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Reinette Chatre <reinette.chatre@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, Tony Luck <tony.luck@intel.com>
References: <20250207181823.6378-1-james.morse@arm.com>
 <20250207181823.6378-11-james.morse@arm.com>
Content-Language: en-US
In-Reply-To: <20250207181823.6378-11-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0062.namprd03.prod.outlook.com
 (2603:10b6:408:fc::7) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH0PR12MB7816:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d34a0d9-ca34-4691-4045-08dd576cd843
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eFkrVm9IYTVPZXdnbjJjVUVIb3lmckZPT1dsM0tUR1hvSkFacVNHWTlpRDB3?=
 =?utf-8?B?UVo5K3AwRFVtMEZ1VFpPakJMT1ozV2E0OVd6SjFBV0IzeDVMVDEyVFBRVmcy?=
 =?utf-8?B?dWJNcHNhV0ZibEsreUtGdGdRcFkwVm85aUlNeU9sQVYzMGNrcm1jMDM4c0Nx?=
 =?utf-8?B?ckRwTWJXUVo5Ym5lQ3BYWW9qdGVYVTg1a2I2SVE2MUlDbU1tdXIzQ2hCZ09M?=
 =?utf-8?B?dSt5TzRNVklmMzBpM04yeCtoZ1llU3RaM0NXQnZjKzdjUCtYM3JMNnJjR1d2?=
 =?utf-8?B?dzBsWkFpaHhRcWVwb1pjOFVyQ2kzSHpKanc0QlJQOVVCVHJidnlBM2ZLNTZF?=
 =?utf-8?B?aWZtcXZOWGhtQXFxQ0g2NXVJeE1JMnB4UFVwei9XdXBDS1pEanA2S0gzang1?=
 =?utf-8?B?L1NOT2QyekZnd2FVeHRBdnFHZTVvbmVRa1RxQUEvZzFOaEtQUUlDV0hCZWp4?=
 =?utf-8?B?QWRubU5JTFlLS0J1STJNVXRSK3NKMk9FQnhWTGtzMDQ1UCtZZTVFSVZ3YzNN?=
 =?utf-8?B?U2Y4dnB5YkZ0R2RxeWJPWm5rOG5SOUNScERLQXRGZ3Y3di8rczNaVVRlekZY?=
 =?utf-8?B?MEN0UGtpZVRvWHk5bm1KdDlyN3NOMHEyc1J3WW5Ka1lMMFRSK3paYVkrRFJ0?=
 =?utf-8?B?RHRSQmRXdUFBQUw0bG10c0oyNTlvZysrQUQyMzFJWWhldDVkdXlhVTVOVFVC?=
 =?utf-8?B?MmlMYTViL0o1LzM0YkhCdHJGV1VQMVlIb0lBTzhyWEkzcWp6TkhXcnFzOUtT?=
 =?utf-8?B?S3VrcmNRWUE2TVYyWEt5OXFKMG90d2hVZzRFUkZXWXNzdlgxYVlkU25BY3FE?=
 =?utf-8?B?N2NLYVNTbGZwamRpcHF3Vk8zNFdLSC81UndGa3NQVTJyQi8zT3BpMGZCNWlW?=
 =?utf-8?B?SnJSVjJXWmNpcTdUNEE0bThoakEvYjVzZGpTSjRpbkF6eUpMSmJwbU9RMWc1?=
 =?utf-8?B?Nk40OGZ6R0lob1QyQkJyMEEvMHNzQmxuYnVNVGlMS2FPVkpwaTZoM1FueTlF?=
 =?utf-8?B?L1Bnak91SnpSL213aXhLSTM2WU1tNVR2d1NBc0lnWmdBY28yeXdCVnIwdjZl?=
 =?utf-8?B?REdISFJkbUVXcHBRY1U4K0IrUlk0YVdKZENvbUgzVjI4RWZOa1Z3QUFGb0dO?=
 =?utf-8?B?d0p0dlFjN2t3TisvRHEwQkNZbEVpTzNBUGt3QmpXcGRzZFRPMDF2VTdEUVBm?=
 =?utf-8?B?SStLWm5kMTE1dFkva1lheTBXMkl0RlV2THhvWmk5dkt5YlRFTlhCdTAwN1p3?=
 =?utf-8?B?L3h5d3pDVzkvR2U2ZzZaemdaWUFSS2ZOTWZxOWsyQ09DWEN1cm9mQmdMNkVj?=
 =?utf-8?B?NmhoVzVMb3JjL2pSUlNpOHNhcEJhRjJHdXcwcmZMa25oT1NxVm91dGsrZ29R?=
 =?utf-8?B?SHo4RHFCZFEvUmVVSmJmblYxN1R4UkkrS2lhTFlGQ2xXNGFYMVVVR1VzU0hj?=
 =?utf-8?B?Q0c4VUl3YXBOZWdnM09Ldlp2M0d0YnZaaEU5QklRSERZNXFjTjZCQU9TTUpJ?=
 =?utf-8?B?WnhmUjhTMHpwQjZYb2NvQ1FCbGRUc3R4UTF4dkdsYk5NWnd3cWdpeXJrd2sw?=
 =?utf-8?B?V3ZBMkFOODFlUS96V1cyeXFXaC9yVjBzQXMxRDdybEczSE56dUxXQnJaUUR4?=
 =?utf-8?B?S1Q3WXZmczdwa0w3aTd0Tk9tOWx0RjRMdHQxVHVXRTI0Mk1uNlVKMm5oMHZD?=
 =?utf-8?B?UEpLa1l5SWp4YlFjditwSUZMeGg4YzJDdzc2U051YndnZTVvdEpya1poUkNJ?=
 =?utf-8?B?akw5ODlHM2dHcDNKQWg4cUFIV08yV1pNaDd2bjFCR1VJQTRxTDhFYUYrazNI?=
 =?utf-8?B?d3JML0NXSDU5NWdkWExCTG5YVGkzUTBBVEc0Q0pvTFp4eXdVK1V5WXAyeFFt?=
 =?utf-8?Q?4QasVdOGHf7Gf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WFJSRDI3ZWp5ZTBWT1FTaFAzb0U0WTkvY25rVnNsc1kvSlpncllERFlSbFBZ?=
 =?utf-8?B?VGJ1ZjNjSkxEcjFxcDE0ZjNiaE9qcG5UTDU1OEs2VXFScE9Sd0dJeFdKazJM?=
 =?utf-8?B?M2tja3Y2Z2JPcFYyYTZVVzg1dURxQTV0UUw1RkFEZVdhVzZZRFluSDN0ME1o?=
 =?utf-8?B?Tmh5RVZ5MWtWTDFzcytMYWo3M0xSYXMyZVplM0hIVzVmMVJCU2h5MjNpd1p4?=
 =?utf-8?B?VTdPZ3Y2RXRYYVB1RllWMmM1UDhlRXloeFB0T2orWTJESk9TK0JQN1ArdGl6?=
 =?utf-8?B?b0VJakVwYm03blFSaUVpdEQ0MHNPTml3WGxJOTdZMVlKVWRJdmdTc0NQSjcv?=
 =?utf-8?B?aUd1c09ZRmN5TDZwcExUWk91aTMyak1STGRRRzhLNS96ZkdTdmRFM1dCVFpj?=
 =?utf-8?B?bm5FbDFFYWxPb0RlNWhLOVZCK2JreU5oMWMvWGlDS0tZZDRwTFJxYmRLYlVS?=
 =?utf-8?B?RXJ1UU9HVVBXVzZocDRvQitFSndDa1pFVzRQaG9HS0ZrUlpLcUJJRFFWVTlq?=
 =?utf-8?B?ZVYxbVlzbmhkTTMwQktQRmp0aTFhdUhWOHU3azM5dGRJWDh5ZjdBaG1sNGdq?=
 =?utf-8?B?OC9yUUszeTREVytqaEZ6Ylg0M2JRSXJ4ckV5Q3RacG53Wi9Ob1hnVEx0Sjls?=
 =?utf-8?B?bEJVR0ZoVzVtd2VpZTBLeHJ5eW1rRGJvL2diVEV1d2tiaG5uUldQTktyUGhT?=
 =?utf-8?B?R2xwSm5KWUMwVlF1SWdiSXdHRjlMNk1VWE1ka3FSelZJaEhhN2Myak1WbjFG?=
 =?utf-8?B?bXg2NURtdENPNlNGSFlmL2RRYW9KTEVqN1Z2Y2JkMXVkMXJYRGNoSGYvTUlu?=
 =?utf-8?B?UnhBWU5oYUFCM3lFcE1icFV5NTE5bUgycXF4UFNZQkMrV0xlWmVxT29neTF6?=
 =?utf-8?B?ZTVEdDZHZ29yTm0zMWh6WXBzQ25EN2NBNVFsS1RzZDlMRmZDcWtCLzFVcjA0?=
 =?utf-8?B?cXZETTRHS1hvR090aG5uWmVUTldhRE10MCt1clo1emxrLzA2TjQzUmN4WE15?=
 =?utf-8?B?UXg3N25aMEtMUTJyZ2pFeU9ocW52bDFabHdJL0VudkR2a2UwNHczcWtVL1Uz?=
 =?utf-8?B?WGFMck5NUXpjby9FZjN0MXFONXFpRUkxbXFFbnVMTUFwbVJUKzg4RVJ6YWU5?=
 =?utf-8?B?cHZvUmYxL0NmMUhSK2d3TXhwelJOMlJTc2F6eEZyWWpIRHIySTc4Yk9POUww?=
 =?utf-8?B?NHdiRTJjMlE0T2xOQVFBMWZIN05XM1Q2bGdSNlV6MVI5QjRZSFByaTJQT0l3?=
 =?utf-8?B?cXV1cEJCdTBaRjZtTGVmM0N0dG9TMC9VNnRuYVFXRS9UVlFMY08zbFRmdFVC?=
 =?utf-8?B?enJuZEtpUTFUMDVOR1BEZS8zb3p1bXVpZW9RUHVsZU1HditObFZQNG02UHFa?=
 =?utf-8?B?VWdFalhRSk5pcVZmNTcvWG5tb1RYd2FYOUFMZ1A2MkxSS0NsekR6aGxFSTlI?=
 =?utf-8?B?NW56a3QrMkxhcTIwNVNsaldiNkxKaWI5d2JlbnlXRm5nbnpDZmMwc0ZXdVNl?=
 =?utf-8?B?S0ZiOFFvajhEU1Z4TE1LUDZiOHJTUVpJN0lXOXQ2aDVaeG1MK3gwZXU1QUI4?=
 =?utf-8?B?eHNucGFVYko4bkNaOURWaXlzbW00VGd1SDJkWmVqanJQb0ZpWC9Bb0U5M1VZ?=
 =?utf-8?B?R2FZVWxhUUZjVi8rU0tqNEtDVWVpZVgyUm1uaE5ERXZmVnVwRVdVcXhZVHhD?=
 =?utf-8?B?SjF2UW1taDMyaXVIWC96M3RacmdRZHZaSytZRHl6TG1XUFhlUFUxQ1BvSXcx?=
 =?utf-8?B?bkp4emVwbVhqSStqWTBTdEJXZHZkRHZzRHczcm1KV0YwQTdjQmo5djg5ajFX?=
 =?utf-8?B?ZEt2M2FJbXllWlZ3ZmQ0NHU0a1ZrZUx4clkwSWUxQW9adnVrRTZQTXlkOTEy?=
 =?utf-8?B?VHVrcm9HOEg2dVFjYUVjb1pqVmdpMDZmaHhzaStpOUozbU1nSTBQeTVNK1BN?=
 =?utf-8?B?cng0S1g4eVNFV3RXSzRveGhJcEkzMXVwa2JWUnBqbm9lSTQ4Q3NvQzVTYTdk?=
 =?utf-8?B?cU12Q244NFZTVFp0MG96blZsemJUcnVZbjVlR21NRjBUMm1HbEVlY1gyVkV0?=
 =?utf-8?B?KzZWMGpUWjRPS2QvQWhtNHQ0L0ttdFVKdmVzZEx6VG1FMVhtMkhROTlkTUVD?=
 =?utf-8?Q?Vz/A=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d34a0d9-ca34-4691-4045-08dd576cd843
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 20:25:15.4497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rTUQwyF84K0GdMsWYEKKgld7ddqYoLEuD1DdNaVLATt6GIkzo3e9lU2TB6gxnnFi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7816

Hi James,

On 2/7/25 12:17, James Morse wrote:
> update_cpu_closid_rmid() takes a struct rdtgroup as an argument, which
> it uses to update the local CPUs default pqr values. This is a problem
> once the resctrl parts move out to /fs/, as the arch code cannot
> poke around inside struct rdtgroup.
> 
> Rename update_cpu_closid_rmid() as resctrl_arch_sync_cpus_defaults()
> to be used as the target of an IPI, and pass the effective CLOSID
> and RMID in a new struct.
> 
> Co-developed-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
> Changes since v1:
>  * To clarify the meanings of the new helper and struct:
> 
>    Rename resctrl_arch_sync_cpu_default() to
>    resctrl_arch_sync_cpu_closid_rmid();
> 
>    Rename struct resctrl_cpu_sync to struct resctrl_cpu_defaults;
> 
>    Flesh out the comment block in <linux/resctrl.h>.
> 
>    No functional change.
> ---
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 17 +++++++++++++----
>  include/linux/resctrl.h                | 22 ++++++++++++++++++++++
>  2 files changed, 35 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index f706e5a288b1..62d9a50c7bba 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -355,13 +355,13 @@ static int rdtgroup_cpus_show(struct kernfs_open_file *of,
>   * from update_closid_rmid() is protected against __switch_to() because
>   * preemption is disabled.
>   */
> -static void update_cpu_closid_rmid(void *info)
> +void resctrl_arch_sync_cpu_closid_rmid(void *info)
>  {
> -	struct rdtgroup *r = info;
> +	struct resctrl_cpu_defaults *r = info;
>  
>  	if (r) {
>  		this_cpu_write(pqr_state.default_closid, r->closid);
> -		this_cpu_write(pqr_state.default_rmid, r->mon.rmid);
> +		this_cpu_write(pqr_state.default_rmid, r->rmid);
>  	}
>  
>  	/*
> @@ -376,11 +376,20 @@ static void update_cpu_closid_rmid(void *info)
>   * Update the PGR_ASSOC MSR on all cpus in @cpu_mask,
>   *
>   * Per task closids/rmids must have been set up before calling this function.
> + * @r may be NULL.
>   */
>  static void
>  update_closid_rmid(const struct cpumask *cpu_mask, struct rdtgroup *r)
>  {
> -	on_each_cpu_mask(cpu_mask, update_cpu_closid_rmid, r, 1);
> +	struct resctrl_cpu_defaults defaults, *p = NULL;
> +
> +	if (r) {
> +		defaults.closid = r->closid;
> +		defaults.rmid = r->mon.rmid;
> +		p = &defaults;
> +	}
> +
> +	on_each_cpu_mask(cpu_mask, resctrl_arch_sync_cpu_closid_rmid, p, 1);
>  }
>  
>  static int cpus_mon_write(struct rdtgroup *rdtgrp, cpumask_var_t newmask,
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index a939c0cec7fe..da3b344d06d3 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -266,6 +266,28 @@ struct resctrl_schema {
>  	u32				num_closid;
>  };
>  
> +struct resctrl_cpu_defaults {
> +	u32 closid;
> +	u32 rmid;
> +};
> +

Can you please explain why this is part of resctrl.h?

Isn't this part of architecture specific definition?

> +/**
> + * resctrl_arch_sync_cpu_closid_rmid() - Refresh this CPU's CLOSID and RMID.
> + *					 Call via IPI.
> + * @info:	If non-NULL, a pointer to a struct resctrl_cpu_defaults
> + *		specifying the new CLOSID and RMID for tasks in the default
> + *		resctrl ctrl and mon group when running on this CPU.  If NULL,
> + *		this CPU is not re-assigned to a different default group.
> + *
> + * Propagates reassignment of CPUs and/or tasks to different resctrl groups
> + * when requested by the resctrl core code.
> + *
> + * This function records the per-cpu defaults specified by @info (if any),
> + * and then reconfigures the CPU's hardware CLOSID and RMID for subsequent
> + * execution based on @current, in the same way as during a task switch.
> + */
> +void resctrl_arch_sync_cpu_closid_rmid(void *info);
> +
>  /**
>   * resctrl_get_default_ctrl() - Return the default control value for this
>   *                              resource.

-- 
Thanks
Babu Moger

