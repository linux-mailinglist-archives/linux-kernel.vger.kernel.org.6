Return-Path: <linux-kernel+bounces-170260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1792E8BD439
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 19:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C19F7283135
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 17:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC0C1586F2;
	Mon,  6 May 2024 17:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MJ3G66I9"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86548157499;
	Mon,  6 May 2024 17:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715018243; cv=fail; b=umwHtvNge3jEPDNGYO/LdlCG6YM/B/BIfstkxlylqYcd4TINIyrTJQCJTkjTJLrBxg47cZct7OExlxmKT0kM0YoLsU8vBRT2ue20qBhmNmMF5AUCCEzvhUCsh/VYGIZvXF4uTrDcZA8n9bq6uRnNz/mPo+2l5iq8qQeZEXP1sgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715018243; c=relaxed/simple;
	bh=3kSyHX3gzk33U8m4mLGbqlOHfGBoZ3Lf1agIjDkFxfU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LwZxGx79Ntb4AMY5hgP3WNZKc5oruq2jIifmnKColiRJQNznIvKxKiZpfe70Ff3v1yfpcjNlO9xxDxY49IPThSIInf6r2d7gpQZbdQihehNPw+KL+F9hRO28x7AHUQqmXrKXdDE2MF3qT+Zqle5Ty4M9eUXoPAOQbsqNV7RLU1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MJ3G66I9; arc=fail smtp.client-ip=40.107.243.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cFzsUgj0ZF650hhkVQEn5VsOC58vW2FPUAou5s/5mlRlAOjsK3tz9F4X/tcfSstyIQuM+lRA0tA9GJOKTyyI+Z0t5JhAenzFDkoxjwc9+xxh2/iN/O2mIFYLLAZbmUVNwM+zBkPNbb6DwrLxkcCbBg2HT7E3k03xp2Trek5SkC+0A49LVFWnJ/uFHj91ewws2ZuN6leX8TQWSz2/v42PFQsr+vkEEHkzOYUS8OT1iahokdsPjQFVVrbRNJu+hWy2bgPhKMxIT+/hTqUyQxwZYmEiyNUzq72mKeT7p4LHsgkX2fCsHAvv/YfrD5frM7ok6+JL6bIl5cxXN6RAsClHPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wAgFnbf3DAswlHFf9TPaEDVcGOtxNdkMHIKoycZIuWA=;
 b=BQzdVwqhKFPw9VeXjH6IWIrGuWPmjs/r5GS81Io84O/ul4F8vm2bXNPPrYBf2XzvVV6SEWV1afCV39pwlkPoh3Qu8Vvn7pNuNnkXCUqBtB/1Pr4La5mdDtMCEHGV4gu+ibldprSGHHOZtNgYj+zuliXCZ4nLBOKb2eUCdEBmG5YBO6VubD60YIxndh9IbMB0wRBXIyVlEliQnQDAls78O7jXireMgWcee5WI1r+QSbwO8/vWRlvVSHZbI6brAGOi5jrHcpVoDVJ3hxLqBrH/nzRcXZtlcI63dCQkQG/ziuILXOSl1uwDvA40m7s1/RCJbU9dOAhVH6qTjcDbneLiow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wAgFnbf3DAswlHFf9TPaEDVcGOtxNdkMHIKoycZIuWA=;
 b=MJ3G66I9ORvDqhIM3F56eRBixx0S+nFcxk1thIyNJAh9w7+2Vi9U6QAXZSesOI4UZahfAhhtFsXFRa45NCeHnAMAL3RzGQRF8FiKzwhuKmfpPIA2tPQD6yz1zOnX2pvxpf3O1NeNhnzM6Nq40yFiJdMox3f3EWWXvOUAo5qWLEM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MW4PR12MB6802.namprd12.prod.outlook.com (2603:10b6:303:20f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Mon, 6 May
 2024 17:57:18 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 17:57:18 +0000
Message-ID: <23514112-3125-4cb1-8178-1a8d582e5a5a@amd.com>
Date: Mon, 6 May 2024 12:57:14 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [RFC PATCH v3 01/17] x86/resctrl: Add support for Assignable
 Bandwidth Monitoring Counters (ABMC)
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
References: <cover.1711674410.git.babu.moger@amd.com>
 <1194d7c66607648368fe34460709649b76ab85e3.1711674410.git.babu.moger@amd.com>
 <46fe7620-24c3-4f0c-8877-a529626c5025@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <46fe7620-24c3-4f0c-8877-a529626c5025@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0065.namprd13.prod.outlook.com
 (2603:10b6:806:23::10) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MW4PR12MB6802:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fd28e36-3b5b-4740-ae1e-08dc6df5f896
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|7416005|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S3p0MEhlYkQzT2dBYlljdVJqOUVzUlh3VDB2YTcxYTg2L1F6Uno5ckp4cVV6?=
 =?utf-8?B?Zy84WW9LUHdaVVY1S2RUNk8yTUxOdjdKWFF6N1k3ZDRIYW1ublJ1SWZRSjZJ?=
 =?utf-8?B?b1A2enA1alBpb1FzVVJ3YXNVSDNueXFBSWRjMWNYVkNFblBOc1FRV0YzcXdM?=
 =?utf-8?B?OE1Mcy85WlJEUUZNVW9tVzJTZkcybVd2eEs4bkxMWGJzTFlVcWFSVkEzNllW?=
 =?utf-8?B?U3dweWQ2ZTJ0am9HSzgrSkxQYlVFejZOK2xUZ3pZenpaREdKUUVoQU10aWdx?=
 =?utf-8?B?QUVMUWgwRlc5elVyd3U5aHhLNGhsQldCdXpvenRPcUxEemxTSXNrbFhqSzJW?=
 =?utf-8?B?NVY4bFY4ejMwQ1Z3dGRnS2tWL0dNY2VyWlhrdUs1c3NCSlk5TjhlVkpHd0U3?=
 =?utf-8?B?bkRQZGl1SDZHZGM4aXcyUUFKZGQ1TGpGWk42NUFWNmtXUHNpUVRtbWt4dXda?=
 =?utf-8?B?bjRneCtUTW44WXdQa1k3d0Q4MzJ1UGQ0ZjEwUXFSWTRTTGYyZ1c1Wlpnbmlt?=
 =?utf-8?B?dE5uZFl3WnhIUXZGM3FJbk5CdFJydG55VlVaTW5rMEE1cjMxK283MUVLT2ZI?=
 =?utf-8?B?b1hoUWdLRUNFY1d5eE42VEMvWkNUOTJJcm5FMzdXeVpOT2tiNERzUlFVUzlz?=
 =?utf-8?B?ajU0SzcvODVNZnc0Rmh2RGNyem5BVDIrVVl6Um5CTWtBM0FZNzlReVlnTGpI?=
 =?utf-8?B?dmxUaEk4Sm0wekRWTmVLR2xseklOZWRqVytvb1VKQVRsRlByNHZ0YjUwSDRR?=
 =?utf-8?B?TTJRZlhQU0FwOEVUbmNYR3dJYjRSNDZqUkw4YWVhSHRNdDlUQXJwcG1IZDI4?=
 =?utf-8?B?STA5ZldocWNQWFN4UjBVVGV1YzBsOWdkUTRtaDF2bGRNM0drbHBsVjFxdmRV?=
 =?utf-8?B?MkN2L2E0cVZMbSttUmp1bnlVZ3kxVXFjUWc5a0xtN2dOTUtWWTlGZ1QySnBL?=
 =?utf-8?B?dTVFeTYvYkpibE9EbklNRjRKK2dTZHZiY09YMnp2eE92UFhsSGM5ZGlabklB?=
 =?utf-8?B?UmdMcFE0ZnpDZkhhYnNOUHZPaE03R3QxRW15OWFFRWNEbXI0anFpTG1xd0Jq?=
 =?utf-8?B?Tzh6UGEzN29iRFBvL2N1ZUdMa1hMUzUvWVJnVkoweHdiZnVPV0lLZ1RNd3FQ?=
 =?utf-8?B?bk5qclRvOC9iK2ZnTHk3dU1BVlJVU20rU3hPaVkrNndYekhqSlFsbWI4Mkd1?=
 =?utf-8?B?N1VYakhCUGUvU0gxcG9lRStEeDF1TE54MENQeXZIRDEyMmlPTTJ5NG93dW9C?=
 =?utf-8?B?eGx5cjFDRXp0NEZvWW9pVmdlUXBuaEx4SzhJQkpjZTJGOFpOSjZoK1pqU3Bm?=
 =?utf-8?B?REFBZnJ3VUIvTnRLdWdMdW9CWUF4SW1vK3o0NnFwVHRGbWpISW5kVk0rdlZF?=
 =?utf-8?B?cDJzSjltdWlkZDJMalErMEpNanpqRDlvUndQenpFcGkyYXNXMGpmb0x1N0FY?=
 =?utf-8?B?dzdCVXRhNTErRnQvZHgrcThzYm1rMFlmeFZxMHdEeGZoV3YySUN6Q1lkeGJv?=
 =?utf-8?B?SUhxWUNVeHBDU241bzd3TCs0RDkxdGkycW1lelptL2N5OC9mZGJwaDlGRHk4?=
 =?utf-8?B?c2dwZlB3djN3S3g5TFQwb0VhdjZCTjEzdkg2cDJZY0tMeHNWTTVZaWpwK2dM?=
 =?utf-8?Q?kjl3+8E28GPeaizvKrXUxqwbLx7GxOxsxF+u5FbtfWBo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L2NucVlPTDlCTGdSVzJ3ai9vOUNIV3A4aWlRS1pIVnhULzlsZWh1WHNPVmNI?=
 =?utf-8?B?NzN6RzZGQytXVFNwSTFNNDJzT05jUjdjTXNQTjFVZmtnWGhTT09LUnhGb2NV?=
 =?utf-8?B?Z3UrSjhKSjIrejNXS1JuQUR1cWhkc1FJUzZPWkxYb2JwT08zL0Z1cjdwSU5k?=
 =?utf-8?B?SjVQcDZMM1lBdGdGNis4WDZYdHBMaXVYYWR1OTFYd1lDd0oxbHNXUzd3MlBs?=
 =?utf-8?B?MnJReVU1VEhScGEvZjJwZXpFOStwSVlVTXJ5bmJsNmhHMU9RQUlNeU9iWEFi?=
 =?utf-8?B?R2tIRHFia1RQTVdPMGRqZDVWOER6Z0Z2eXZ2VUxmalNmRlVVSU4vWkRhTHh6?=
 =?utf-8?B?WG5TOCttL2txM0Y5MlBONXV5MTZpaTRIdGNOVTdML0RRQ1pOK2dPVjJiV0Fp?=
 =?utf-8?B?Z0Y1NVN3RjArZHByV0dmSkdWZFZVeC9zU1pORENhaGNWeGt6bkoxbmlZWGFt?=
 =?utf-8?B?YlRwaXlsSUFVT0ZFTytmVjgvTDNVZVdFdG9sZ0xYMXpNZmt3TnJWWG9qSS93?=
 =?utf-8?B?bjRoNDdzTGpSdG5ZZ0RpbC9ZbmxwSkVZWGE4SjJBa1RtMUp5OGhtcUVoWklO?=
 =?utf-8?B?YmdCK0UweDBZaS9Bd0RFcEF3R0dBdllyZ1hrSW1tTldzRWl1RTVXaXhtb241?=
 =?utf-8?B?Ukp1TDQrVmpjTG1xeXRua2lUdHRRUmliUlFTUEluZThwRDIxYi9nVjc3SXlB?=
 =?utf-8?B?UG1vQjNSWTlLYWNLeGN0djBhd0tOc1h3MHMwSThRV0FEZWFmRWZ0USt2ZjBw?=
 =?utf-8?B?S0MvR3JEVkU2QjlUM0xqL0ZYSjVGd0xxK3pxZmtNck9RUnFOOTNTM0x5SGJ2?=
 =?utf-8?B?WmRIY2hsTmllME5LRDBPT1o2S0RMZzljdVdUUDBsRytQbE1HbklQOFVIVnFR?=
 =?utf-8?B?bEZuZyt2d3dzU0VtcDNrSlIwU3AyUU1lL0czQVlmTC9lWXNPRFdXQy9Xd05s?=
 =?utf-8?B?dlU4UTlvTXppcGUzcGxCdGlDL1ZVYzRCRFBmQlZlZG4wRU5lL1pHQVdGd0VL?=
 =?utf-8?B?WVFPcXFqYTJTKzlrb2hkL0J6SDR3a05YR1M3VllQWWlLWDVENkZ5c0NoajVX?=
 =?utf-8?B?cWlmM3VhQzIvaEJMYjc0WlQrT3JKRmY1b3J3TW9CUWpGeHNjUVdlWURMUU5k?=
 =?utf-8?B?eHVmMll1L281RW9IRXZDbHZJOU1GOWl1NU9SWTdWYVpZWUhWUDcycXhoRTV4?=
 =?utf-8?B?UzR2VWN4QU5sRGRNaUZwaTBMV3hBUVJNWFNoYU1ac0xHdFk5VHoyMXllZ29h?=
 =?utf-8?B?RUFIS2pFRDNyN01WeXYwT0RHWnVOWmkvVWV2cTdUM0dLVzNleHBSTXdkbHpq?=
 =?utf-8?B?ZWo4eUlTUjVMU28xTjhBUmlnR1FSdEFQTFR2TkV6bm8rSHc2ckl6YUV6N2Rp?=
 =?utf-8?B?OEhvWE5VWE9oK3pqQXR5cm9PLzlwUk1BU2xWNDl1QzlnTWw5WGJkRXBHZEIv?=
 =?utf-8?B?d0pSeExsdzU0UFU0aTlsdys1eFIySHhnQVBwN1p2L2ZSYUxEeEFkK0FjWVdi?=
 =?utf-8?B?NmpFWlJqMnVUTnlKYXBHR2J1OWZWQUNWS1VoWW1WZVBKRHdpZGtQenplK3dx?=
 =?utf-8?B?NXpuajcweXE4cXRlTGxPcnp0aGg1eGorNmlBMk52ZlMyWVp5MUJ5eThBd1Fw?=
 =?utf-8?B?NktDYk9PdGRaaHEwRi8rZjBaRU1kVTFYS09MV1NObkxZTTN4Y2h6SVpEUlpC?=
 =?utf-8?B?QlZzZWRKRU92VStMTHNDYkNVQXpTODl4R2ZSdkJjZmJ1YUxOWDRHdTBtSGg5?=
 =?utf-8?B?WlpGOXdGdTFLc0RoMmhmZWQ2T0RDZDlkR2JNNGJka215T1VDSVJhK2JSbGJn?=
 =?utf-8?B?OGU3VEVuMzcwWHI3ak52M0s0bTJGb09uRGoxcS9VaytaZ2RPS3Y2U09aREJS?=
 =?utf-8?B?aFZPU3Z0YWhWVDdxd2tXVjk5RlJuNFA4OUtoNVB4bWZZeUkvQVZVcjBVVHov?=
 =?utf-8?B?SHNXOGpuOCs5ZC9Rb2pLbUtSUWc5UDJER1J5c2RjYTdsWTQrTFIvVDQxV29i?=
 =?utf-8?B?MkNqdy9JckNoRTNpbnEzUlJGUTdCMW1TR3d1OUZpREZ5dEcxSDBEdjQwS0Nk?=
 =?utf-8?B?b1BQMGhlUzBycHovN3ZIc1pncEZ2cVRQcWFUTGxoSmt1Z1crRVRUUmdYNnJh?=
 =?utf-8?Q?twns=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fd28e36-3b5b-4740-ae1e-08dc6df5f896
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 17:57:18.6872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EpJeS3wjt/JmA4nqZl5tlzJpR54wmTabfDT05fFtOlM4yUdOrybIBJs5YKJeNeVs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6802

Hi Reinette,

On 5/3/24 18:25, Reinette Chatre wrote:
> Hi Babu,
> 
> On 3/28/2024 6:06 PM, Babu Moger wrote:
>> AMD hardware can support 256 or more RMIDs. However, bandwidth monitoring
>> feature only guarantees that RMIDs currently assigned to a processor will
>> be tracked by hardware. The counters of any other RMIDs which are no longer
>> being tracked will be reset to zero. The MBM event counters return
>> "Unavailable" for the RMIDs that are not active.
> 
> I think it will be helpful to use consistent terms. For example, above uses
> "tracked by hardware" as well as "active". "tracked by hardware" seems more
> specific to me and I think it would help to understand this work if this is
> used consistently.

Sure.

> 
>>
>> Users can create 256 or more monitor groups. But there can be only limited
> 
> I think you write "Users can create 256 or more monitor groups." to match
> with earlier "AMD hardware can support 256 or more RMIDs.". Can this be made
> specific with "Users can create as many monitor groups as RMIDs supported."?

Sure.

> (please feel free to improve)
> 
>> number of groups that can give guaranteed monitoring numbers.  With ever
>> changing configurations there is no way to definitely know which of these
>> groups will be active for certain point of time. Users do not have the
>> option to monitor a group or set of groups for certain period of time
>> without worrying about RMID being reset in between.
>>
>> The ABMC feature provides an option to the user to assign an RMID to the
>> hardware counter and monitor the bandwidth for a longer duration.
>> The assigned RMID will be active until the user unassigns it manually.
>> There is no need to worry about counters being reset during this period.
>> Additionally, the user can specify a bitmask identifying the specific
>> bandwidth types from the given source to track with the counter.
>>
>> Linux resctrl subsystem provides the interface to count maximum of two
>> memory bandwidth events per group, from a combination of available total
>> and local events. Keeping the current interface, users can assign a maximum
>> of 2 ABMC counters per group. User will also have the option to assign only
>> one counter to the group. If the system runs out of assignable ABMC
>> counters, kernel will display an error. Users need to unassign an already
>> assigned counter to make space for new assignments.
>>
>> AMD hardware provides total of 32 ABMC counters when supported.
> 
> I am not sure if you want to mention this. As written this sounds like
> a hardcoded value but it clear from later patches the number of counters
> is learned from hardware.

ok. Will remove it.

> 
>>
>> The feature can be detected via CPUID_Fn80000020_EBX_x00 bit 5.
>> Bits Description
>> 5    ABMC (Assignable Bandwidth Monitoring Counters)
>>
>> The feature details are documented in APM listed below [1].
>> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
>> Monitoring (ABMC).
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> 
> Reinette
> 

-- 
Thanks
Babu Moger

