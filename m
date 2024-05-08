Return-Path: <linux-kernel+bounces-173787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 036FF8C0559
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 22:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 274351C22559
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 20:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F66130AE0;
	Wed,  8 May 2024 20:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZMG+ZONU"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B942712F383;
	Wed,  8 May 2024 20:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715198848; cv=fail; b=i+ggJeqNzEd49/ljyiZBuPdV3lgBC1a2RAau34Ply18bNx0foRVDiSjK/YmZUvebmXOJ1SXca4yhN0pifLc2+e7kgBz5aPHniR8LJsS0vgjer48xYxbzF2LiMsdFBTT+KHv5evVEAhOtuwLxzBwyiw3tMcOKhmm1MxcA026wIfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715198848; c=relaxed/simple;
	bh=IiN6m1SKnrqxTnkYR6TquwPwYXYJncNL0tV87CW/RW4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MevwGC3M3xUbezrRgpNqvaLXx58kUmrilwc3/RWE/BNoDkkJDbgL1baXYz/xvQbHz6NKt8I7YHmwnk0p1DjYV5ThuxFm2lnTPc7bKpoaZlvT1I545u0kx+K61GbnBY/UlaKjWGLNide87RT2fMgY2hs/G1s6K5IjpYWAQT2waXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZMG+ZONU; arc=fail smtp.client-ip=40.107.93.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hLQ8gfZhPe4CerrQF0FCHvl9UpXUza64jDWjcPOh1m0aIXCenmZf2hzM+luzgSMpFzLI65InE5MY+nGWQEPWNMJ/H790iIRQYu5xoiwsKGT1C2LCKdX1gtEF4phS/PH/7kR7+/Abnjsmo4F5/2RGy7go1isNoR2mDNe855IleV/N63HTwp0dU/HhiCWw2eUqxGdv/19lRQilgs5fWXpqrZ2vEZdZ4EUmO4YmZVckEyVf1rgnec+TPyXVA46zTyxFVkixB8DIlnG/dZBqgvVly1g1P/dP1rtF0wTIto9HIKMOKqFMuwY3/g9bAPEVYESVjLWR76nIRY26G1Mw/wuFLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sFheLyLDBcqqdjJaM5BSKUUW2vE/LWRKD1bXDOiH9fo=;
 b=VLUV6Nkch8vZ9KTTzOn0IMkaYtFT6ZzrwBMjHMvzXaI6oWcN5Rn7wcoDCTILtZmlU1C51ahvJzP+uBm+6OxlMXUMH60xalWvqT77NHxaNbo4v7jdainuADYs3sh3IfiZwNx84Q9nJXvf9jOsP9Xwuj5Pu9LAjVOgD1ajbE0xF9Nlxca3YN3/sUwzWB6BVdnEbFXeG3DtOyWX69wNwsMW6OOb+fF5UksOgkbsh7JwVloohoEMwxA7MxHVhyndLF/0WOzzKzIt+twgjlfwg+M3TneKXPhWVkrRz9noxThOUP8YYNLU5M/mnZ60uHrWnDzXl+uEqnntNQ7YIhlHlbCqWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFheLyLDBcqqdjJaM5BSKUUW2vE/LWRKD1bXDOiH9fo=;
 b=ZMG+ZONUiLgpl37xiqQQ6OjQ251iet+XfmdPezil2HKoHE8SG4bmN3DJiPR6Vi2gaKuEi43LqlQTKDv3lZC8E6nYCuTQwpmdfxdlikE5u4dHYzaHzp/bWWcbU4QTm4hZmL2BB1xRNRX8GBMEX8N1Qmf4su69CBolU8oeRjylVQM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM6PR12MB4337.namprd12.prod.outlook.com (2603:10b6:5:2a9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Wed, 8 May
 2024 20:07:20 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.7544.045; Wed, 8 May 2024
 20:07:20 +0000
Message-ID: <7e92200e-d68c-4dc4-85c3-7192a23f8cbc@amd.com>
Date: Wed, 8 May 2024 15:07:16 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [RFC PATCH v3 00/17] x86/resctrl : Support AMD Assignable
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
 <48b595cc-5ffe-4507-bffd-335a60fdaab9@intel.com>
 <2016b830-64c7-43bd-8116-bdfd239221e3@amd.com>
 <ea75801f-e56a-486d-85a4-85c57bce0c81@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <ea75801f-e56a-486d-85a4-85c57bce0c81@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0023.namprd04.prod.outlook.com
 (2603:10b6:806:f2::28) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DM6PR12MB4337:EE_
X-MS-Office365-Filtering-Correlation-Id: 1745cacd-d044-4fbf-246b-08dc6f9a77ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007|7416005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aWszZlhtSkwrL0R2SkJRb1RwYkg1T1B0SDlEUVVWc1c2S05xeHAzN0YweWt3?=
 =?utf-8?B?S21iOXBTc3FGYzByeXovWmFpMXcvT0RRUnIxMmxyL1NRZkl6T2dEdFdUUW4x?=
 =?utf-8?B?SjhzU01Zd3IyMWdWb01CN0Z2c1FwSWlMMDBKZGhETElIRmVYTkcvNlpkTmpa?=
 =?utf-8?B?YWFJdk02YmVIYzJsUXQycEUwTWhQTzJjWEdMNHFlOWpBdEVwL01QUUZIelEy?=
 =?utf-8?B?Y3NPS2RLR0VmVmxQT0FLdW9nczZZWDhPR0s1SGVrenhvSVdsSVlNS0g0Z2ZX?=
 =?utf-8?B?aFhacjVwNTdqdDdSOW5pb1hPaWlscDZ2TW9GWmh2WFowa3p6RHE2L1N4K1A1?=
 =?utf-8?B?aERmYWhUWjJoVnlHZWhKTlpiSytxaXBINTdxOHdRVndNNzlFUWFva1pVZGhB?=
 =?utf-8?B?Tm1SOGJSNkpvbVJDYjYxZVNmSEs3UXZuaW9mSTFKUEFiRXFmTVZWNGtEb3V4?=
 =?utf-8?B?RlZ4ZCtiYnJJeE5qTW02ZjhnYjc1QkkxcnVQeUJvd1BaelNCeGZucElNVXJ5?=
 =?utf-8?B?ZnBlZDFWUmVVNG1mL1lMTkE3cGdhTjZpTThGSmVyN2JhK241azgwVGttM1FZ?=
 =?utf-8?B?Z3hJMHE4d0pvdWUrcVpjVzR0RURtbzNSN3VYZWFhMkMwcEJLdGFPRElmSWtQ?=
 =?utf-8?B?MDFxVHQrMzZmbytuV01QZ2RiZk1HMDNSZ0FEeS9VVm1JOXF3WGFHY3Q0SGgw?=
 =?utf-8?B?a0hGak44amdnT1N5Q0pGaXBqVm1nVkMzNFFKeXpja3l5SGdLQ0daR2Rsb1R6?=
 =?utf-8?B?b1NYdW9zVHlHUU8yT3RvVURDV2ZKSVpEMTRGc0k4NnlZNWhTUkdwY25jM1kr?=
 =?utf-8?B?MUR2TkM1cjBKOVhvQmhhaVFMU0FaUWFzbzE0RTVYUEt1L1p6MnNocHdvODlP?=
 =?utf-8?B?VmNLN1BwaFZnZ2M0VFBVbDhLcWlWR0hUVnM3QVQvR3VrTVYycDc2VEFBMWY4?=
 =?utf-8?B?RUtDR1hDamJpZXJqV2ZMeEpQRGUvM3pPdnhDWmNXaEZ6M3pCb00yRWE1NTkz?=
 =?utf-8?B?UW9EUVRLcjAxNVFIeERTbzllUWNaMklLbU5FT3JVb1hqbUNBd1U4VzdiOVVO?=
 =?utf-8?B?bGNOdUI5ZVpIZ0tYYUZZZDh4UGxZdHVOaHBVdGpITGl1MitzeXp5NEdDUjEw?=
 =?utf-8?B?VVpOVm45dHFZdzFrc0dIR3Z1TkpuNTBpWmhMSWh4VlVud3BXTmdNYTlka1oy?=
 =?utf-8?B?aEt0OXVuVHhSRnBIc2RkZmRyRFZjWXNuaEUxTnR0ZVNzbkVsQ3JEUFFsYVNH?=
 =?utf-8?B?NFh4SGpwUzhJVUl6WFMwaUFSZVh6TmRTajJtdjJhRFdubUF3bzExVGZzemZn?=
 =?utf-8?B?Tjd5b2FaSG5lQWtRUTBMc1JFWUZqMmc5NjBZQVZMZGlQQmJ1NDVhQlp2ZUVH?=
 =?utf-8?B?MEYydS9xYy9ma0o0djk1dktQZm9mOEVGc3J2OHNIWG1sRkkrVk9nSUZLbEJI?=
 =?utf-8?B?bUNMUkxXYlBibHg2VTZSdk9uOXhtdUhaemNxUzZDbHBPRVNrYU8ybWk0M1o3?=
 =?utf-8?B?aVdEV3ZYZFg3TDg5Y2prdU5jc0NLeEt0Znc3czFjZzVqM1dMUWN4MnE3dlVy?=
 =?utf-8?B?QSt4Y3J0N2xwTWg2cXBrTUF5V0lKd1MyM3VJUHlIWHQyVjZtQnRvdi9HbVBB?=
 =?utf-8?Q?WQyu6M4tg0tp0DZcG2+cl/FNam5P/Syg6qIcn2rYPieA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFZwcDRlRTNKZEhBUXpncTdtSUdHMXlaSjZZNzZqSUZXTURjOHdtb3hiR29O?=
 =?utf-8?B?Wm9UMGhuWWl6N1gvNHh3QXBsZGFFUnBSM0gvdlBqUnJwRUpqNE1qQUFGeTQz?=
 =?utf-8?B?dnEzbU11NE94MEpZYVpISnl2L092WlRDMzVDckhuTlRpZ1I4NHpWNWduUzho?=
 =?utf-8?B?aDdyU2dhd0huT3pMY0ZpaTg2TUJmbG5xRU1BM3daN3BPVW9Ob0o3aDcwa0k3?=
 =?utf-8?B?aFlqMXE5SUhOZ2NtU0JPWllSclVTSlZ1elB3UGVQTEtKYTBoenJpclpqZE1N?=
 =?utf-8?B?ayt6eGZ0SkFJUUpEZFplUGJ3UUU3VDFucEZPS1czQTJFbjhaYjJMcUN1eEtp?=
 =?utf-8?B?amppM29wN0pxY1hHOS9ab3VPK25sTjVVQlZEUnFCMGh5RklyVTc2VHdUcnFK?=
 =?utf-8?B?TFhMRm1sR3h2NVJ5aGwxTlFVV3ZZZXpCWEo0ZGhia2hCV01CV2w4b3ZlT1Vq?=
 =?utf-8?B?U01naldwMGl6MlM3MkRBUjZPdUljbG10RzBhZEpZKzJTMEw1Mm1NWmVMelp4?=
 =?utf-8?B?a1Jhek9pTkJaRUZhTG9wMEZ3cmd0WXhjT0d3aDVJS0t2bWxnbzZYaER2MEZ2?=
 =?utf-8?B?cFk5bWgxVm5vVUtkN1NvYmRCOVYyK0M4UE5INTlMTjFxOFdVd0EveW9HUkJV?=
 =?utf-8?B?M1hWTUxzM0lDOFpFQmJYQ3JjK0FzUnk0T0dQTm5ObVFWWWhyMURCeVdZUHV1?=
 =?utf-8?B?Zk5LMXpaVUNDbDV3MFpvSDZGZ2svUEhVbjk0VnNiV1JMOEN4UHFwV2RIT0F5?=
 =?utf-8?B?TFdWL2dUUGlVc1BHU2hpazJKZ3JIRXR3ZTNpVGpJUmVwak5UQWpEcGp4a3RC?=
 =?utf-8?B?cTR6Zlh2NU9NY2VFTTJWL3F6TGhRSUViMW9RblVZZnRiQ2oreTE1eUdhNzU3?=
 =?utf-8?B?aldxWGtNbmNpZGtNOE1EL0JiRzJSMlc0NXJGcC80bU9nUjhLK3RWYUg4YXJE?=
 =?utf-8?B?OUpidGVtK1ozWmtJa2gvMitxK2hpSnpqMUsvbWxRREUweFZjVDlDazBFbGNZ?=
 =?utf-8?B?cHVwNTZPdGpVb0hRZGxjbm4wZXcvUzdrVkNsMmloa0cxSmNtRkdxTEd4UzND?=
 =?utf-8?B?YVd4YUZlWDEybnN3R3JYUDU1d01qNEFDVE42RFEyQkFVenlGanlENDhWbmNP?=
 =?utf-8?B?SU84Qk13bytUUWRRaEVaZzhFL1dzeW9qbGhmcndDZ3FnSUtmaWZNL01KQzJG?=
 =?utf-8?B?ZFpvbE9qWUpDTTdpeUs1aTZETHRaZ2FPemZzSDcyR3hleTdLWVkwd0J4MHNv?=
 =?utf-8?B?UVVoSVZmWWlQandKL0psN2x0a0J0VkpyNkdFbVNMOWRQQTBjR2xWeHI1QnRw?=
 =?utf-8?B?YVI1MjI0ZlkrNk9PTi9GYis5Z2ZVQU92UWJzSDRiNzZKeXZ4eHB0VEpwNTRr?=
 =?utf-8?B?OWpQRFFHQ29URTYzaXZhTVV4YWxCK3FWUG9TRXB0Z3RMTTJCUGEwZzNDSkZz?=
 =?utf-8?B?eGhNNTYydUJYeUd6ZEF0ZnQ0clVObG9nb2pWaTdxalZvTU9RdDV3L1Y5czhp?=
 =?utf-8?B?eW41NVZXQ05ENnZCWEJBdVBKaXc2cUhtL1JsaTB2NTFtR3lmWGZIZi9UV3Ux?=
 =?utf-8?B?SGRrdW5Ub0grQ2FQdDN2MW5UUWRwU3ZHK3JmZmV2SVkvUHgrc3ZtbEhxMXda?=
 =?utf-8?B?RVA4b3g5dC81WFYxdG81VlYvdWttTzZocFdOUmFQYzNOM0ZEbUNyWThyZGs2?=
 =?utf-8?B?YzN1SmcxM3MyVWwyZGVXYjMyaVE3d29nZ3pvbC80OTlyV2R4RDlJd3dMUzRK?=
 =?utf-8?B?T002TUFXeWRuKyt6WmZzSStla3dQT0EwdUozZ05Edi8zR0hsSkVCcG5jMHpE?=
 =?utf-8?B?VS9CallxelZhQmd4T2ZVVVRYSTlSSWl5aU55K2VNdUlUb3hVNGcyMjJrS3Aw?=
 =?utf-8?B?U0c5RGYwbVgvbVZ1eHB3U2FMM2g5dFBWTldtdENzd3IvN05Ta0NNTnh4eHQ4?=
 =?utf-8?B?d0kwVmtyR0s5M21ySjNFQTl1cm9SZXcxbzR6blkxNXFWbDVWSHVqdm9kNy9Y?=
 =?utf-8?B?NnU0MkVKd0tYL3pkc0U0T08yNXZtUnJjUlN4SXRnVWEwU251YTdyZmpnRjAz?=
 =?utf-8?B?MVVpY0xCRmRDRm96ODF6d1J0NC82WHVHM2lZN0h0bTMrNDVuQmNKWmFpUXZY?=
 =?utf-8?Q?89xw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1745cacd-d044-4fbf-246b-08dc6f9a77ce
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 20:07:20.7404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b7uglqbI/iq/ro82msbJ6M/IkNBsUBt69MJqNQgFYehmAote2ipQbTQ6S9lIQBHU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4337

Hi Reinette,

On 5/7/24 15:26, Reinette Chatre wrote:
> Hi Babu,
> 
> On 5/6/2024 10:18 AM, Moger, Babu wrote:
>> On 5/3/24 18:24, Reinette Chatre wrote:
>>> On 3/28/2024 6:06 PM, Babu Moger wrote:
>>>
>>>> a. Check if ABMC support is available
>>>> 	#mount -t resctrl resctrl /sys/fs/resctrl/
>>>>
>>>> 	#cat /sys/fs/resctrl/info/L3_MON/mbm_assign
>>>> 	[abmc] 
>>>> 	legacy_mbm
>>>>
>>>> 	Linux kernel detected ABMC feature and it is enabled.
>>>
>>> Please note that this adds the "abmc" feature to the resctrl
>>> *filesystem* that supports more architectures than just AMD. Calling the
>>> resctrl filesystem feature "abmc" means that (a) AMD needs to be ok with
>>> other architectures calling their features that are
>>> similar-but-maybe-not-identical-to-AMD-ABMC "abmc", or (b) this needs
>>> a new generic name.
>>
>> It should not a problem if other architecture calling abmc for similar
>> feature. But generic name is always better if there is a suggestion.
> 
> "should not a problem" does not instill confidence that AMD is
> actually ok with this.

The feature "ABMC" has been used in the public document already to refer
this feature.
https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/24594.pdf

If there comes a conflict then we can change it to amd_abmc. Didn't see
any conflict at this pint.
-- 
Thanks
Babu Moger

