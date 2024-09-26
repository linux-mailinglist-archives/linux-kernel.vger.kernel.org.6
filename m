Return-Path: <linux-kernel+bounces-340762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E61AB98778B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 18:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EE4E2861AC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 16:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D826015A853;
	Thu, 26 Sep 2024 16:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="U0q5gVWz"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBA715667E;
	Thu, 26 Sep 2024 16:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727368143; cv=fail; b=P13ZGTUya4povn1z982MBwhqw2D4To6lTUs5WtmBZ28aYSgMVcPMx60ZMhTkST35/9PvNgji9mlDSeLH5BHyOSpO1RdShXuoLZ3r/OtAIJgsBh0c0WbjA2lPgtWzBUCTxYqbyGgMY0fbcpVxFms2Q2XPi569UN7e7hdMlDOwthA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727368143; c=relaxed/simple;
	bh=HRIOJPAl7qsTH4EvRaR0IeXcExVTMaYQFt0lXd9N3xM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P+XGDtB2SJ1iuDGT62th7bpaiTu01IqPEIhwpzLud+ThU6Bgm56WcWWZ4+OeeAoQtIGU4M/RVkaz96SvKVHoHDGSWXpNOoHw5s6IUVtWcBLnqwcZlxFeYPZqSKhlbvlFgNm358dqv2fYyd5r+w95Q5bX1Xrv4oVsZjxhzjxZ3d4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=U0q5gVWz; arc=fail smtp.client-ip=40.107.243.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LMLxSUWt9g847ErSKf3g/LjvHfBFFaqGTFGJW+Cnh+HenjySPyYgqjnBZQyYoEM4YwL/Xw5U4R5s0O3INr2AEodspidGmR8rz+64RZ3qwQoX4JuXN2AcBxQILDetMazUd/saPxXmk78EBZV8Olgfl110PzQIqFs/wOftny5nv2QfccGGCwvddpr3J0n+MItYLz496UnsZEktk2GUZ70Mg3eeWNeeS1hQirSBuWrA6qVym/A08iW7MLEbbEWsiBf3aSt9ytMUmoQogMQ2zutqWz1TOx8wqHGwb7iOygl1ym+dzbPIUlGtQoeRqfxgfzDrNu7smsMFiGmfyVPJkiTOEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pc5gfJQx+J6eSaHJ7KSdJorJHJNJC1vRGOZwRlJGT7U=;
 b=FJt1D6jH1z9ND35hV4Lfdoc5rS+mfbzjrdSi+zKkWWY+mzd+lhM+aJTEIoyCjApDMm6z9KQuDI+mirMuek+ahnfsEMyQEN/ZWWx4rCuBKnvD0Kx01ukXBGSSTK/JRnH/49tAwWsuGbScFN/Z8pdU45gU/a3USZQr5oQoIfi9rY1+a1rF4G8+R2DvyDk8yeZyz6t6h3waYajG/Pn4RqNYUQKaxHu15CxO3CboNlh8pM8oE/ibtjvgXCoZ6hBbrk9EqkgRE7mWfQox/63aBKoIV8hfue6SKCPBTWiVF+grr+CG9FQQ1mnnl8Ts7wama26i9qIvPaqqmd6AR1L6FCFgmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pc5gfJQx+J6eSaHJ7KSdJorJHJNJC1vRGOZwRlJGT7U=;
 b=U0q5gVWzGNd8w99vI2mpFW3wOtt2Vy01bZARv6FeuV4IioaR9g9NtQgrzYbbIv209IaCXB37JKVWGXevh6QJcC1y7pEyjcHxSMfShh7jqbgAEyn7jr34yjACjWeyKQNGrFbBjxkxo2itHSDRE9b6IvLiEJ8wTlqxNk4C2AmVSS8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by BL3PR12MB9050.namprd12.prod.outlook.com (2603:10b6:208:3b9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Thu, 26 Sep
 2024 16:28:57 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8005.020; Thu, 26 Sep 2024
 16:28:57 +0000
Message-ID: <791e12c1-ddb4-4d65-877c-a7d887d3ef6c@amd.com>
Date: Thu, 26 Sep 2024 11:28:52 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v7 16/24] x86/resctrl: Add the interface to assign/update
 counter assignment
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
 <39a621b5281753c9f13ad50808d478575cdb52e6.1725488488.git.babu.moger@amd.com>
 <9109e7fd-34e3-485e-bd20-dfd4c68edd01@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <9109e7fd-34e3-485e-bd20-dfd4c68edd01@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0034.namprd08.prod.outlook.com
 (2603:10b6:805:66::47) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|BL3PR12MB9050:EE_
X-MS-Office365-Filtering-Correlation-Id: 1894e755-20b2-4a73-6fea-08dcde485202
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eG5zQk5DbHUrMCtuTHdsSFQyVGVTK1lURWx1a0FoQmJjcEdDZnhQNjhEN1Y3?=
 =?utf-8?B?dXI0WDZWdHp0aHNveTJGRzc2TmVyRElnU1VtYTFEZDZLRGJIOUtDbVNtVWYz?=
 =?utf-8?B?M3dXRnhHYWhXeW1TOERSazQwSXpMdDFDbkozdXNvL3VicXBJS2F2eW04TnZO?=
 =?utf-8?B?YUNBb1FHS05PQmRqZ0F2K3BwMkY5ZUE4bWtRSG0vV0pwUFJqZXl6NENiT2JM?=
 =?utf-8?B?L1B1WFVkeUtNbHRtbG16Mk5IZncvZEFkZmdWSk1aTlNHcFBMb2dCR1NuS3R0?=
 =?utf-8?B?bm1SRlArQjV5VzFZbTdXRG9EcGxmMWR5T3dzSWRQYVZTZ1RoRXVnWEJBZnIy?=
 =?utf-8?B?ZnU1d0Z2b2kwTURoWWFSNlhwNktNdG5HWFpYN1JsU25vTGE3cTZyZHJXbnNH?=
 =?utf-8?B?ZzFiOWVZb3JXTk9jZ2xxdnM4RHV2SUtJWlZEVHJVeW9ubGxQRXpWTkhmTjFJ?=
 =?utf-8?B?RmVpR2Z6MVZOZnRzWXJld0F1dENWcllYcWx4YnhkVVJ0YVBKSERyN293UzFi?=
 =?utf-8?B?bnhxUktrQzNxN2VnSWMwcjlEd2FVTGo2K0N4Q3loRHRxR1pLaXY1Yi8zMGcv?=
 =?utf-8?B?UHJGVDNVMzBZMDkzbVRuemhnaTkzRTNmRHJ0c0s4Tm14T05RNlNRQTJxT0U1?=
 =?utf-8?B?OXdZZGdnLzBVOGNSaXg2RklMcXFHTjJaVmZSNEVHSjRSU1k2M3V0RmJKcmtu?=
 =?utf-8?B?dkdSTDNQa0tsWjc4dmxvei9QVG1HV0tiQ2RzYTNXV1pqeEVYRXBlZWo1NlZk?=
 =?utf-8?B?MnVlT0RvcVF4MjA3c095VkJNNGRsTzAzb3Zpb3dRQTF1Si9UUzhJOFcrNElz?=
 =?utf-8?B?VnFpREFIaEprWVBKS09sdlErb1hSZ24zeGxDVkR1NUJpZWMvZ3RGNWczTFpI?=
 =?utf-8?B?T01YNEUrbEJvSHEyVkduZVRCdC8xMmhJd1NOMmlsNmQybTFTZ1BPTUNEN3I5?=
 =?utf-8?B?V0VJeG51ZVRobGRRMVU0NkFLRit5dW91SVRld2pTbEMzNE1YMVc3UEZwUzBn?=
 =?utf-8?B?NEdSR0R1TzY5VmE3MmZsRTlFbFBvb1BSQmVLWUdkUU95amNaMGFtZHU1OTdw?=
 =?utf-8?B?czhUNjF1a1dvZVFucVBsR3NkRWp6NlVTMUtoUEkyalAvQThBaUhXV2ZFL01m?=
 =?utf-8?B?QjU4bzFadzB3d3pwdW5wWkwxYjZNaVJSU0N5Nk5Jb291VlE3U2hMU3JyNmtk?=
 =?utf-8?B?SzJvM21oL0JCUUZBUC9sVDhiWHRwQ0lNVkl6NnBXZFpNNllGYzBEVXNDalV4?=
 =?utf-8?B?SllqekQ4Z2prMWNhSjkzY2szcE1VY0E5UzNUWEFrcnpVZXhxbVo5TWlRRlR1?=
 =?utf-8?B?WWUxWThsVk9oYXprQmxDbDluVlJ2dkxra3ZIZXA5RWJaSW1IdWlkOEw2Q21u?=
 =?utf-8?B?QW9wb1hTZzJGT0lFNU1BYmxZQ1phZDNVeDFEK2lzbnQvNnQ4djlxbFlQa1Nn?=
 =?utf-8?B?eVRYejFnUUNwUGZnMlBudlJyK0RCR3FOWlg4bnRubDdBSGJoVEJ4YnZiM3M5?=
 =?utf-8?B?QmloV1hsaVRIZm5zSnVKTkoxczJrR0o4S2hVQjZOdEZnSDRMelJzZXZTdlJY?=
 =?utf-8?B?dnA0YWxyYkpXT1MwQllQQXN6NFc5T1FNY2srNjZaTTQ0WWZpVHdTWVlldXZP?=
 =?utf-8?B?a0h3cllUOW84VEpDY1VGK2JSdzZJTzRrU1g2anNGYmViT3JCK3poNUR0UmJI?=
 =?utf-8?B?MjdlM3VOczNoVlBBYyt5MExlTFg3Ris1cUpCM2tmSjRQcVRzNk9yelh5K3JV?=
 =?utf-8?B?bE8vM3IwV09tbFZTbG1WaFlhRm14ZU5FeTYrN0l4WFNjdlFaMmI0V2J0VHQz?=
 =?utf-8?B?RHoxZTE1a1I4QlN3YWtzUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YmZMdEczL2I1OU1odm4zd2EvYUdzYWJTd3NMbDBoNGxSd1RvcDQwclVBNUdw?=
 =?utf-8?B?amVBYmRJeE1ka0dLaGZmTVN4SkxrZ1JJdUtReHdBV1NDa3duaE5BMjVkUm1y?=
 =?utf-8?B?eHQybzAxa3JwMVFJbHI4TFJZZVlLTS94N2E5RVlyNGltWHNNN3JZVGduWEpo?=
 =?utf-8?B?MEVwRUdNMVNtSnlCNWVaazRrSVVZUHprckppbGh6dEZaY0ordG53dUw0bmVC?=
 =?utf-8?B?bVREYTluSUVDcCswRHBZN1FEYUNTNitUZ2U0NVc5TnBTZFNyQksvTjdjSWtx?=
 =?utf-8?B?V0FzQWUwSkpJQ1Zzbi9VdGlteE5Kc29ZTnZYS1AxQUtPME01MDFSNVNiM2p2?=
 =?utf-8?B?VjB5aXhkTXh1ZEkySTBxVUI4SWtFdk5oWWNTVFhoK0JmKytxYmJQY0V4SVdx?=
 =?utf-8?B?UjUrVWM3WDA4aDlKcTQ5dnEwaHFIVm50NjNaWlVZMkdsS2ZndUZBc1g1NGxS?=
 =?utf-8?B?eXZtOGIyNkhzOGNlNWw3aXVidjc2T0dmdFJLT3pDUFFhNTV3TVhrRTBMVWly?=
 =?utf-8?B?ZHhGSEJiMWZ5QVArVVVLTFlaaDR3NkhvaHlMeWVkT3pSdVRDTjdzVmRFZGM5?=
 =?utf-8?B?YkNtdDBrYXVKZ09FOFc5OWJUSXVuTUduMUlVaitKcW0rQWRtS2V5TkRoS0V5?=
 =?utf-8?B?aXBGZ083R1F2cmZzMXJYcVljMU9aR1huakwxUGh0SWV1a0VqM2VzOFJXdysz?=
 =?utf-8?B?U2pWeG4vQyt4Y1B3QlVrUmU5NU1wL0FLdURDSjRMeEF3eGhDV2duQXVlczJa?=
 =?utf-8?B?dU94SE5xTGE1M0RFYndRL3M3K2ZmYUhaSVhLK1p6S0ZNZWVnaXVkZWtDaDZk?=
 =?utf-8?B?ektJOWoxNXpGN0FYeWJmNHdNZTN5dHR5Q1BsVC9BeEhGMG9IUUtaZ2FSNmF4?=
 =?utf-8?B?ZXBlWTRGd2FFRVJDZzg2YytrN2FsUTVuR0NaTTNDdWkrVk9IYjdVbWJJMElC?=
 =?utf-8?B?dWFRWTRON3VVaE10T3Y2MVR3Q05oMDVCUjBUd2IyRkZDUWhVNmszZ2RMRFVV?=
 =?utf-8?B?emcvKzZoYnFBNEI5QVg1WDJhb0FZd29aRm85ZzY2eW4rUFN4TWVCcm5FZFBW?=
 =?utf-8?B?QjJpTWpaZFlpTGJJeldnb1piVXdyRFVtVnQvdW5WQTZaRWZINUFBZGlyQ0Nl?=
 =?utf-8?B?ZGZqUDA4NWtZdUdhc014YllOYTRweDdMQ1FrZS9Pbk5wTFFSaEZzUmVsT2Nl?=
 =?utf-8?B?S3dRNis3NWpNY1Z1SU5JaEdFRXRncnpIY1U0K2ExZmxSbkZVcDF6MVM2TzZC?=
 =?utf-8?B?RlhGWDVqMmxadS9BLzhJREk5R2phZXZPOUl4NjFEMUVDNm5WSEpsOUxialhY?=
 =?utf-8?B?V0RNRklOY3phb2hQMTRnRnh3dHQvcWt6V3NTUFFnRmdidjBtTWlvVU5DeFN5?=
 =?utf-8?B?NGZOVmVwV3RwbHIrZ0tSbFBTUWE2RmZseHVQaUZnenRxWGdZUWR4NGhrbEdM?=
 =?utf-8?B?WHVPL2hqcVNnNW96WUExRUJSYUJ2cEkvRlJnMS9UTFdCcUlxRXFSSjNWeDZX?=
 =?utf-8?B?NHY4MnNsS2pFbjN2dU0ySmplb3RyR1pUZ0JoR2M1MGxSSmFVNDRjZjVZekpL?=
 =?utf-8?B?dVVuSG1tM1hpbmxxclBBTkVFbmRHU3N5aExITUQyRm9PUUFMVERiUzRtK29a?=
 =?utf-8?B?bWFDeFZOaVVHZEUwY3lVNUg2cUpRdEw5SmhjMjlmWnZtRDFzWTF6Wkk4YXY4?=
 =?utf-8?B?OXM3bHlkTEpJZE1Xczg4Y3ZWVzVWSzZYNEozRWpOYXgyUXc4TzY5bUlnTEQ5?=
 =?utf-8?B?UGhhU0ZQalNHSVNVY0VxdzZYMTZOSXlGRWZTb1c3Z3NCUUl5dFRCTTBydzR2?=
 =?utf-8?B?Lzd0TXJmR2ttNGF6bUhmaU9FOWxrQVZNNUlXRG9OZEp2RWRkRC9KbFdlN3RP?=
 =?utf-8?B?SWROWHNSNjRSVFB6OEFuUGJzMnlSYktVakh3TkRZU1prc0Nxb1hWdFZsOHpV?=
 =?utf-8?B?Z0FYaE1lUEg0bnppZEdyMjI0bmgwYTVCRFlGQkt3MzkrajBzcE1CWnducnRI?=
 =?utf-8?B?Tk1FcmJkQ0lnWEs1OHRGT0xuNDNFTklBUWsySEd0dG50cTlvem1xajVwU3Rj?=
 =?utf-8?B?VXdjTm9EM2VQVEF6SlRlcHc3VkMzU0xQd3Y0bzBNL0VSMi9pSXBaSTA4UGpk?=
 =?utf-8?Q?irF0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1894e755-20b2-4a73-6fea-08dcde485202
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 16:28:57.6525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mqEpB0gBuhdtPQruVqRhwFB1+9njFsrB17ltv4ZWrjyd9bT9xuWwHLKyDr1CXYPY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9050

Hi Reinette,


On 9/19/24 12:20, Reinette Chatre wrote:
> Hi Babu,
> 
> On 9/4/24 3:21 PM, Babu Moger wrote:
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 7ad653b4e768..1d45120ff2b5 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -864,6 +864,13 @@ static int rdtgroup_rmid_show(struct kernfs_open_file *of,
>>  	return ret;
>>  }
>>  
>> +/*
>> + * Get the counter index for the assignable counter
>> + * 0 for evtid == QOS_L3_MBM_TOTAL_EVENT_ID
>> + * 1 for evtid == QOS_L3_MBM_LOCAL_EVENT_ID
>> + */
>> +#define MBM_EVENT_ARRAY_INDEX(_event) ((_event) - 2)
>> +
>>  static int rdtgroup_mbm_assign_mode_show(struct kernfs_open_file *of,
>>  					 struct seq_file *s, void *v)
>>  {
>> @@ -1898,6 +1905,45 @@ int resctrl_arch_assign_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
>>  	return 0;
>>  }
>>  
>> +/*
>> + * Assign a hardware counter to the group.
>> + * Counter will be assigned to all the domains if rdt_mon_domain is NULL
>> + * else the counter will be allocated to specific domain.
>> + */
>> +int rdtgroup_assign_cntr(struct rdt_resource *r, struct rdtgroup *rdtgrp,
>> +			 struct rdt_mon_domain *d, enum resctrl_event_id evtid)
> 
> Could we please review the naming of function as this series progresses? Using such a generic
> name for this specific function seems to result in its callers later in series having even more
> generic names that are hard to decipher. For example, later (very generic) "rdtgroup_assign_grp()"
> calls this function and I find rdtgroup_assign_grp() to be very vague making the code more difficult
> to follow. For example, rdtgroup_assign_cntr() could be rdtgroup_assign_cntr_event() and
> rdtgroup_assign_grp() could instead be rdtgroup_assign_cntr()?  Please feel free to improve.

Sure.

How about rdtgroup_assign_cntr_event() and rdtgroup_assign_cntr_grp() ?

Added grp extension for the second one.

> 
>>  +{
>> +	int index = MBM_EVENT_ARRAY_INDEX(evtid);
>> +	int cntr_id = rdtgrp->mon.cntr_id[index];
>> +
>> +	/*
>> +	 * Allocate a new counter id to the group if the counter id is not
>> +	 * is not assigned already.
> 
> "is not is not" -> "is not"
> 

Sure.

-- 
Thanks
Babu Moger

