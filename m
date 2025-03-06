Return-Path: <linux-kernel+bounces-549865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FAEA557FA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 22:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A2B618974D1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678F61FC7ED;
	Thu,  6 Mar 2025 21:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YDQfNGtH"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14410207A03
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 21:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741294824; cv=fail; b=PufR+fDb4WWyzUqk6Qs5nztnSTrsoMbTRv7nB4k4pgayN0DD3Miuxc+Z4e/rXEOjRQk3i1BMNGG51sVII1del4lwY7ZhWX23SepOMWS1sbaVQaJ7gdtJc+lYmPs2t3xSUViS0sbDdivZBfz5OSTFOowSK4ztswEjlvELuV+uTpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741294824; c=relaxed/simple;
	bh=C4ik9hhw/juWgkfsEexsveX3BakgUVepNkVCwUku4cc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bSy4R3lUCaUHfpBUy4O6pRhPtm8dPI4uMHx6Rmuj1xaxQ5wWoVECuevmXYHMwVdEKwKv3y+mvAMHHY9Ov/wMzdlOtkjg+ovgYwFk08Aww+hbDNZMW6R59CeQlPr4kqHr5OC0mWGsPZUDI32jpAL/GQtCOPWgkL9M/fxBT503LY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YDQfNGtH; arc=fail smtp.client-ip=40.107.243.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DKdynO0gIO5PeU6qu53aCNlBJPABixzNWHpYSstT1XTdRXhWHozrZDqfOovf+XA94OoZJQABEB+psn74VEMSZt3vTVWII1v6pJmIUwdAaViuhWVE8b5MZa+CHUvmLDEtrz6p8E+LH5OnBdlmlOb+ws1ouMIuvgmGJPn53ukNVfpVpmvuxGCJwoaZ14qAp+Pr5BBpd8LSkAq/oRFp5IxzVSU1GgZSXUjDJkcxhhg3s8jIGojTddvbRp7h0RcwYm2AOe1xieqFNJO+32kWa58UgYZgJCf/D3nThOtrkP/2SYNljrj5LRM7zbfwyfxMPUjt7DgzlRjYEjYbRk1/F3ww0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C4ik9hhw/juWgkfsEexsveX3BakgUVepNkVCwUku4cc=;
 b=Y0Z96mkri+/yR1HfO30vH+H0KBLZXc0eOhtXlsz4TSOa4Kv4k6N6m87Y/71AUqeMbdkqJGU50GGkH/ATJM9Jou4x9ZzT/Y2hWfMeCt7RY5DaS8iHOwTX0QX2WsusRzySfOhQx2MwxjJJeSFuRyNMoeir5Z06B/QIVk3PGF8Kp5CcpjqWLFlFSquAd6Vunm3nxID0cKBdS4V3IubjFPVu5F6wFoRO/pxA/pDV5DSc5zlUdK5VUrpn3ihuqS3jR/xL04ePQRCpbydiG8tJLVMZxymHN7uqS2PJVb0gp7sPDmsHcp0izUpr24hANVIxSSL+1qdr/yAjfO3YgvJX6aMn8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4ik9hhw/juWgkfsEexsveX3BakgUVepNkVCwUku4cc=;
 b=YDQfNGtHuT3992Zqc8zku5j02+Bn5hfJ5fSnc1rNI1bRaCAkJemLIj3xx9NnRNc1kKhMFD1jFPuJ2KBIK4uJDaDNqaWmoGZuQ7hzkeoM4NKLeYdEtTphUvBBVbvoiarecRqeUylewX4ozhj8jN80MHMpc8aF6WfEOhWv5ImcJI3pzizk9ortl1SfDtsZm+QUQzoxSIlhmLElaAUaiXvZhdaKUP3fDFsQcEF+rUuvYIP8Nx94mPCPy/6MgHYPJYoDMJT3sD8kmczyqOyQECLaNYAgf4xW9OUWolbeHi5EG3GZbcm6kj214nVwvpFXMt2ofQVgd55LUDlAf9pOB02r1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 IA1PR12MB7662.namprd12.prod.outlook.com (2603:10b6:208:425::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 21:00:17 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%5]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 21:00:17 +0000
Message-ID: <005ca499-5c38-46aa-95e1-517f8ae6c71a@nvidia.com>
Date: Thu, 6 Mar 2025 13:00:15 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 03/49] x86/resctrl: Remove fflags from struct
 rdt_resource
To: James Morse <james.morse@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Reinette Chatre <reinette.chatre@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 Babu Moger <Babu.Moger@amd.com>, shameerali.kolothum.thodi@huawei.com,
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
References: <20250228195913.24895-1-james.morse@arm.com>
 <20250228195913.24895-4-james.morse@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250228195913.24895-4-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0062.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::39) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|IA1PR12MB7662:EE_
X-MS-Office365-Filtering-Correlation-Id: 6236d799-fbd8-416c-e547-08dd5cf1e64c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TmF3NEZ2RkFXMVpNU2NYK013blQreUFLYmdTK3QrT3VYZVBRdXpxN2RNUjMv?=
 =?utf-8?B?R3l6NEhEcFdZeTBDcm5RNkhYUGkxR2Nuckd6ZVowYWhLSkxkenZGRFNDOVVF?=
 =?utf-8?B?c1QwZVdtUVdpaVErS2RRcEliZzdxSmlJQllidDZpY29tMWRKVWNSTEFWN21L?=
 =?utf-8?B?RXJMOGNSMElKYWNUWTQ4UEd6VEFxV21PYS9zamM0c2tINFlDRmNoNjF6Zmlo?=
 =?utf-8?B?WVo2Q0d4ZWQ4bkprWnozcE9UeDFadjZvYlZ3Z01Tams5bUJDWmpBR2xDcFR0?=
 =?utf-8?B?dERjV3JUNDhKSzcwU044RHlPcnFVR0JTdWt1Q3ZOVG1ITkdMcXZMMDY3YU1z?=
 =?utf-8?B?TEVXck8zcWh4QmJCTFEvQ2pLYkdDL1FsWnI3Z3k3ZjVuM25mNHU2bk41UU9M?=
 =?utf-8?B?THdjQ1YzbzlLQXZpeEJ0SjU2Mm04aXUrK0Z3bnFrak5naW1zMVdnNWxzVjFH?=
 =?utf-8?B?alYybk9FNnRpbmRSWC8wS1l1eHFiSThaV0Nuc3JpbHE2VlNsbGluZEhreU1q?=
 =?utf-8?B?YThhWUtaaW5rWHIva28zZlBtSkV4QXpqbGNFdkhQTTlSSHNOQ2xFVHR2R0Fh?=
 =?utf-8?B?c1IrMGpsTEd1aGdnanZhSXpVMHlyL3M3ZEhjc281R21BdWdQVFZSVDNnVlQ4?=
 =?utf-8?B?dnllWWZQUVJjYkRHcFBkSFZYQTk2aFArMlVUWnd5WFVlSjRGZU9PQ1NaZWN4?=
 =?utf-8?B?RG9zZzBHQXhWQjU3c0VLSmpRR2xuQmpQT2hFYlJpQzR4dWxNRGFtM0t4bUw0?=
 =?utf-8?B?NUZIVjczdktLTkV2ODNGQVBHR0pHNGhxYnNZQ0RiRTFoM051UDJEc0tZeWVk?=
 =?utf-8?B?NVd0c1ZRV3lpelpaQjhycmtqOW5rZnhqdXhJNHJLTVlvYStPQm4zQ0p3TWxa?=
 =?utf-8?B?Z1VTZmtMUS9sVzNOaHMvd0ZYU3FHdFhLZFRKbmFPYU0zZEZHN3lUYWovMGh1?=
 =?utf-8?B?TW5oby9yaUZPeWZzc3BmYjNZRHBadHpvYnlpeU5TWHprWnJpN0ZEaVoybmJW?=
 =?utf-8?B?S1B1dG5jNG1TcDdsTEp2MEZUWkdpLytmd1c1TFdwb3piV0pzSUhybHpPMkRo?=
 =?utf-8?B?U2pTbVpNU0RkenErd2pwdGwwcS85eE1TTmg1WHNlN1F2RjBDUktOd1Y0bEVa?=
 =?utf-8?B?eU14a2g0dEtoVUtXUldiYkM3bW1EZUtoajJQZ2NSbWJLMjl0akhEb3NTQktw?=
 =?utf-8?B?QkY1NXZTZUdCM2Fjejh5RlV3dVIxVmQvZUpEaFVFQkZrWlRtQmpaZVZLVU05?=
 =?utf-8?B?UFM2b0t0cmhHVllQNm9kMmZ3VDVjOTZBNzQ5dmV5dWNiSk5zVVFmOUpaRHhS?=
 =?utf-8?B?SGxvQmo2MElNbU1QRWFKZ3p0SDZzRHI4Skd1K0tQZEhyalFpQUxhMUZaSmgw?=
 =?utf-8?B?cVpTNU9BRjI1T1FuTnZHUHk0N1ZsVlgxQ2IzdnZEbm5XS0xoVE15Y0JxM09v?=
 =?utf-8?B?OUVPc3MwQk5IS0c4MkV4Z1BLN0dUeDVxY21XSzBZVldDVHR6YUlSU0RVYVlv?=
 =?utf-8?B?MVVDc0tlMlhvYzlIc2RXTWZuZ2NRL3VjYmhVWFI5czRMSWtoM3dWcVU4eWhm?=
 =?utf-8?B?cVBnVVF0ci9jaUZxQVdYR0o2SFU4UHk0WDhmYTl3dVBGTnRjVEk2WWthWTZ4?=
 =?utf-8?B?SFlpT1R1RUV2MnJhczVrQVdYSGt6R3dYZnRZS2NxekNVN0lSVTlvbHg3REFT?=
 =?utf-8?B?SjBlcXl6L0kxOTBtU3NtOG8zUWZhVlJPd3Y3cXdhNnJKSnBQSjdlU3lCOVVk?=
 =?utf-8?B?TWRwQzd6VlBFeFZBYzg2Ty9NUWxNMDNDQTdoTTFDZk8yd2Vkd0hIdzNLT0Ju?=
 =?utf-8?B?cDZNZ21mMmYrbHMyY3llVSs1K1BVYjZhUjZaYWd6eUtKdDY4UHpRbkU5aGlJ?=
 =?utf-8?Q?FuJhBKB7W4wPT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGl5Z2FwNlMwVHA3cGJnOU5qRllaazVlb0pBNUhWS2pkZld0dHd6UTV6N1U0?=
 =?utf-8?B?OHh1RnRYZ3JHK1JVVnZRSjdtbmh3K0NjWElEY21XM2pNVFRvbytnZzhhTEdv?=
 =?utf-8?B?K2duSUdJT25hK3lJZmUrZ3JkS2ZOZVBzUU1jN2g0eVZyUVd0bkVwVUVIbE9C?=
 =?utf-8?B?ZFJjb0ZpR3A0SEtaUk1KamNTMnRlTVc1c1VGQ1RZNWt3Q3dHaVpSa2ZjV083?=
 =?utf-8?B?RTNSSzJ4RGI5Q0h1aUZhdHJUSnczMi93Tm5ldUZXQS81QUFyQ1lxcStZU1NX?=
 =?utf-8?B?SkUvZjJiWkRIM0ZXSmpYeEdQUEczUWRQNUFSUWsxRHBVZ0s0enhJTEVnN0hV?=
 =?utf-8?B?em9KOG42T2JDR1ZZMXgweHJia24wdTJNVENCbldlRWNxSzhPY3NsSVd4dHM3?=
 =?utf-8?B?U0VvN0FSM1JRaHZLRXBvYmlRajdzY20wRVIra0pLdFBaZ0dqbkd2MzA5L1hY?=
 =?utf-8?B?clo2dXNFNy9xbHV6WHE4T0MzRGttdXIwakxqbEx1dDZ1ZTdpanY1YjB4SWZt?=
 =?utf-8?B?MU9XaGNHaUN2S1FkM05lcVd4bTJCbnpzYWJoWVk0NlU3UmJZWloxcTUyVFZL?=
 =?utf-8?B?WEk2UTZFc2EwUzNuYW5MbERnNVUzQzhxZXVqZk9KUEZMemxFVnhYUFo0enJG?=
 =?utf-8?B?ZU55eU5EMzBKcVdDOUxVdTd4eEdUSHZaZmRDVmR0RzdLckM5Zmh3RUZ2NXBY?=
 =?utf-8?B?c0prbXVtNzA3b2VRQVdIRUlzTUJVZEhwR3dXeWxBbGJxK1p1TXo5MDk3VlZH?=
 =?utf-8?B?aFpQQ0VwVnhMQXhza1NoQlhwb29wTmMwcnRkb05jK1FhZTY1cWFPNUlocEpy?=
 =?utf-8?B?bWxyZGJVeS9xUkJnOFg3eHoxcnZpQlFVc0xNV2hENWJYd2FrMmJXTWdrdEVN?=
 =?utf-8?B?SW9SdFNZWkwyNmxBbnpyT2Q3MzlSRm55QnUzQWdRajJoaE9xMVlzTUdBVWdB?=
 =?utf-8?B?OEpWZUVGT2lwdlprU3NMcHZGeTlGVTh0dHNMeFd5Vzd5aE5oVlp4ak1nL1JJ?=
 =?utf-8?B?NjFnRG93cldrSjVrZWVzcjZCSEZzTDExdlh1Y0ZJZnIvdXRkRTR4dFNCdCtS?=
 =?utf-8?B?VHlXYzBuQjZremFVYTFvL1k2VDJONnFUcEVGVldzdk9nSXNxNmlvOFVEblhm?=
 =?utf-8?B?Tm5DQ0xheWwydzJSTGxuK3BBMUk4STdvUUxuUjhtdFdpeWwrWWF5T2pUanVk?=
 =?utf-8?B?MU5aSjBDSU9wRGpzUFQzQmlZK1ZkUWUvUGN4SUl3Vzcya1BlcmtLZDM2TFVP?=
 =?utf-8?B?SzNtaFB5bWNsVE1jZldkMWJsQWNKVnhQTnprZzdSdUJJaElhRGhnZWI5SUR0?=
 =?utf-8?B?WnFXcXBadUZHdWROZndPK2JvNk11ZTMvaVJXQmZaM2loT1lpMnBVYytXSWZh?=
 =?utf-8?B?QVBxWkdoak5xWkpmeS9mRy81QnZBZkkySnJBRVRMeVk2RGk5c21JdkVHK1NV?=
 =?utf-8?B?NCt3R2E2T2RUVzRQOU0wMHRURytiQVRYazZWMGJ3ZWNnM050TlF1aWlXclFP?=
 =?utf-8?B?a21CN0x5a3M0NWhnQ3BLUDhQMU90YVBZY0kyN1U5UEVqRnoyeFhMMGVrOVRN?=
 =?utf-8?B?QnJjWkFITCtKVk1GbWxMZHVBSitYeWMzaUIrL3hHUUpXT0tmR3creHJPQVNW?=
 =?utf-8?B?NkdGWm83YjBKeWNkUTFVS2Qwem5samVVeGhJcUVnNXg2KzBpMGVRVFJsaTJp?=
 =?utf-8?B?alhBbGNyanZzeVczOGRpakpKQUJZcDdMMkUxVFNmRHZIMjU1c2FPQmpZSXhS?=
 =?utf-8?B?R2hGQlpLNzJuWU5NWTFaUlYyeVR3SDlIUElWUVFGelpJcHRJN3ZNSDczb0lm?=
 =?utf-8?B?TzBJRTJpNWVnS2dHUE5JaU5HK1l2dWlENjdMTFNOOGd0UVk3ajZsc1VHVXEr?=
 =?utf-8?B?anVPRFJsQmFsdnBvajVBU3ZIVzFhUE55bnpURWVyb1FTSGZ0MmV3WTM4SXA5?=
 =?utf-8?B?RThpQUF1dmNLNlRxZENqa0NRRHhtaWpMTXFkd2lEQm1Jb3lVK21iQ0NWSHp2?=
 =?utf-8?B?RTczbzVTNW9TSUZhaThKcjF5N3IwR0J4UmNVb3RWRFFlTHdPZlYzeUNFNnNZ?=
 =?utf-8?B?WGFBZjN6MG0vam1OMFZnbUlPUEoxeGl1T3BCak1vb3dRdFNGZkdCZERjVHl0?=
 =?utf-8?Q?5Df+89P8QobHoxh5AQRXDeAte?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6236d799-fbd8-416c-e547-08dd5cf1e64c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 21:00:17.8783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pw6Ni+0yFvLFNKoAWtmkydlbwIGDtiCrJrjggWicqdKAT9qgrjzYvXtXBFNtxmfo10fRS6vhFaWsASq1rWnC9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7662


On 2/28/25 11:58, James Morse wrote:
> The resctrl arch code specifies whether a resource controls a cache or
> memory using the fflags field. This field is then used by resctrl to
> determine which files should be exposed in the filesystem.
>
> Allowing the architecture to pick this value means the RFTYPE_
> flags have to be in a shared header, and allows an architecture
> to create a combination that resctrl does not support.
>
> Remove the fflags field, and pick the value based on the resource
> id.
>
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>


Thanks.


-Fenghua


