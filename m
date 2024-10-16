Return-Path: <linux-kernel+bounces-368705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B129A13B2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 22:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC57B1C2089B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 20:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60AD215F5B;
	Wed, 16 Oct 2024 20:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZdDhbtba"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2074.outbound.protection.outlook.com [40.107.95.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531D82141B9;
	Wed, 16 Oct 2024 20:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729109924; cv=fail; b=ayFe1iuvYhiKn/dVyp0n0CDpDmcK1NyyM/MYE50ZiVJL2892eO7ltoAU+yfsLaCvP8urtJVqG3NuXgi1A40rBwmoo82q4R0Irtm2Xf6uhdN6SvEzKs52paiyj1lIhsPoEa2DZjzK8HxfOowUn9dnGFJCrG/Uc9rOH9R/yWPWRFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729109924; c=relaxed/simple;
	bh=li+Ir8+RqUO8AyyegEBn90ZKLr8SbzCtrQH9XznTqSE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dK3TEaiWeUdOsHUzdiClcx74vGrxTX8dHi6Zj6PqfAALjJUbj8cIY3Mq+kh7UO7CxDzzQJyyJC2e/uJpQY3OxOzv/mpzMhPvQK0wuzoh11cFbMSMlziul+O4yTqoJyuIcgJ8xA6atYD1pWdrRkdK0yiP70lDTsy+WWbvlPgTGL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZdDhbtba; arc=fail smtp.client-ip=40.107.95.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qZGHJoMtZMCaEFiMKsVACDOKqe5h/ilByTjRty21XRL43QVzd1ZLkPUW0dsikr8pc1PMhtppOd2jwrmyRNqSK6QWfNc/faHsdbqEbLv2YeBXVFshufPbLi/o7096hLfm8iUAEV4WeXhzYzjyAjv7sBfucvEdwwHm2J0nMWw/sgSayLFXdceNp+PCLYFlW/L4NL6+lJYueE7KXPcQaAw51mrkCKqoBoM46JXb1x5iBFwsJE+G3geYsXk5CAcMys22HmM9cQTqV47Ss8sPr22J43uRWK6ONEsGKJvUIAoxdt190xgtXvSa8nqOejgiMsyr4jYwAq5YsxHAYRj3MlAx5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a9KR1FP5Fg77TZsui9MCPqCQxw9MLh/jVe/NoqaJfaA=;
 b=cJECALz+5Kl0F4EJlzi8vAUSyVL68jxFlHQJ6kmfbxct1gKuERr9vBwHAev1lJYOgq1i3n7Z2UVZoMSXACTtJnv7ZvZTwS8FMQ3v9cXKpuP58law3zcDN95wG3QPfAp8qxq8fwP8b1XZzeoyxR+ZCMtgCVhzHbiBPpj9Vcw3ICU06bYkduOSjaZslr+FGhVkaiAXkNq0fpX0DoMVPsiwE8fTSwY6vL8X+/c52jW7z9Ovf7DMvKuUl/DwpN7m7Fa2z86GVlL1craHS6+L2Wc5lW63QfeTZ5LY2h5/5JsysCvourRsSZQhOoayF7oAg/Z/vo6kcNQe2XIQ+WRRrdm3eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9KR1FP5Fg77TZsui9MCPqCQxw9MLh/jVe/NoqaJfaA=;
 b=ZdDhbtbabpjz4eBv9R7m2ISINhJo1sMWm7qLCNxspkU36ZASL1BecGolhvhjrOyc7GillLbk+JVJh7N1wZe4TjNxTjlDo98NX4rbJ/t/d7BAy+RoDe3aUIR+nHD2LuCFxXDartGG+P0raDMEau9FkEYtIG5xsCN6icyO7GEehL4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SJ2PR12MB8954.namprd12.prod.outlook.com (2603:10b6:a03:541::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Wed, 16 Oct
 2024 20:18:34 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8048.029; Wed, 16 Oct 2024
 20:18:34 +0000
Message-ID: <72a320c8-13c1-4472-95fd-26eef279ad9b@amd.com>
Date: Wed, 16 Oct 2024 15:18:30 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v8 09/25] x86/resctrl: Add __init attribute to
 dom_data_init()
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, yanjiewtw@gmail.com,
 kim.phillips@amd.com, lukas.bulwahn@gmail.com, seanjc@google.com,
 jmattson@google.com, leitao@debian.org, jpoimboe@kernel.org,
 kirill.shutemov@linux.intel.com, jithu.joseph@intel.com,
 kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com, james.morse@arm.com
References: <cover.1728495588.git.babu.moger@amd.com>
 <03077cf67cea1b3ebb00495fd40d1535db27ff8c.1728495588.git.babu.moger@amd.com>
 <b19af235-7ad5-4897-8082-1eabfee849e8@intel.com>
 <7749600f-f281-4cb8-b909-382a69dac56b@amd.com>
 <00ae6b0e-29a2-4240-93af-c460ce4de66a@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <00ae6b0e-29a2-4240-93af-c460ce4de66a@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0006.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::7) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SJ2PR12MB8954:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ad477df-4615-4c8f-2aa4-08dcee1fb5b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SXZQbTgrSFliNkNtKzdqV0p3dHorR3prNE9SMVBwbnFXZVY2V3FRVnVUZ1Ft?=
 =?utf-8?B?SERUdEtrL3k3WkFuZG5tZ0J2WVNLVDRtSGVBU3hhQkFhS21lam9Fd0IxY1lC?=
 =?utf-8?B?RUtSZVovR3UxL3J3UkpBVEFseDJ6aDhITmx5c3FTWUU0WWFGNXZVa25uZmUy?=
 =?utf-8?B?OVNFNFlDdG5NUHVvaytmQnhwb2U5dGttQUY4RDhHTWJDZFNRazIvUDdvTjVN?=
 =?utf-8?B?Q1A5YmZiVUJUTEtVZWI2ZVc1NUUxNEZ0eEZ0QjNqZ2s3aGdpeC9SRi9jVVdQ?=
 =?utf-8?B?N0FnRWNSdDFnN3l1ZVV1MmhQeWdyUFlsR0FsejViUDQrN3MvRTFzeVBERW1Y?=
 =?utf-8?B?NXhQMVRHMTl3eG9IMjhqV2x5NnZVaDh5RFhaeEpVa1htcnJLcDJWcllvTEp5?=
 =?utf-8?B?ejBFdGN1ZnZiajJPeVlleWdwRW0zMVlBejB1OERFcVlsNFMxVEJOYXlZbmsw?=
 =?utf-8?B?Z0E2aklKbktuSWxaanY4MGxaR29CYnMvamMxV1p5QmFLMTlzdWNXN0dGMENH?=
 =?utf-8?B?NVRkdWlDRlZKRUhnM2lESXF3V2R4NmxxOUl2SXQ1ZVpRNFVadER4MTFnWEZD?=
 =?utf-8?B?NHIxNk9aUzN6SDNYbzNyb2tFbjkyZ1RpdUtDWC9SMXdKSE53OFRPVUQzamhm?=
 =?utf-8?B?WElDdy9wRkdWTWRiSXZuVEhVYmVBeU42c1lVS1lMQjdsT1NKdWZ4VHNFdCtr?=
 =?utf-8?B?TWovMVVreTVHd01sNkJVdTdvRkZvZkIzMXd6a3RoNEtkVDhRUUJtSkI5eFpi?=
 =?utf-8?B?RWJUdlRpUU5RTEVBLzJGRU50cWN1UmpiOVE4YmpFc3hsS2hMYndlclZVTjN0?=
 =?utf-8?B?V2tObzRMTGh5NHUwRFV3N1pVOXBiTXFsZXhGWXVORTVuNUZhd1dpcmhqMit5?=
 =?utf-8?B?ZEJTajBaVVRSdTdlUHYzQk1DaXRlem5SQitleHZ6TGRpU2JsQ3Q4TS9TUmNr?=
 =?utf-8?B?aWlYUUdBdkZLTWE4WU9pMGFRektQd3FKMzlKdEdNbEIwNmpJTzE1V0FFV2U1?=
 =?utf-8?B?SC9PMVhwdmY3eVlTK3ZGOCtmT0VMUVZ0UkwzQXN5Q3BsNmxzM3FJWXRsTmt4?=
 =?utf-8?B?eC8zSkVBTmU2a0duWkNVK0tpNCt5c3EycDJwUG9wS1U1SjFZVUJKQ2FTMFUr?=
 =?utf-8?B?bHpVR0lrOU1SckVPUDVmblRKZXpCMDB6QTZWVXJNbXlQdVNkNVNMNUZhOGFx?=
 =?utf-8?B?RTJCcndOUU9qWk5UN0wreUppWEtVVWlVZmYrZGJBNkRjU09iR0xQSW1iZjFp?=
 =?utf-8?B?MlI0RFgzeVJkdFU3aEpVVW1GSmtMSjl3dVVtWjBCbEpyN1VMdnpEOVQ3K1hW?=
 =?utf-8?B?TWlhZTJEZWZnNE1jZ2NnYktaSFIrSHJOVVAzVG1nbktOYW41U1lZenY0OXBC?=
 =?utf-8?B?eW54UGV5Wi9QaU9pSmYvWW1MWmhzeDVITHNURXZsM2sxRkp4MmRxQXlEUENm?=
 =?utf-8?B?NUVNSkZMMytWckhmbUgxMW1ubE9XN2Q0czZFTGhUY1llaW0rRmVMaUlySXla?=
 =?utf-8?B?WTh5MHVVWGJxT2JJdElSTFZFVjdGRVNCaXVHOWZlYXZ0MU5ObXBCSXNESWhw?=
 =?utf-8?B?L0g1NW5LbEVJQUlVSThTREVoQ3I4cHlVK29pQ2dxRTVBZE15UWFieTEzK2s4?=
 =?utf-8?B?S0RpTDdST3ErY0dvMEltNEJkWldEaXg5dm15UDAzWVE4ZkNJRlIyeW9STmtj?=
 =?utf-8?B?ZUtNNGFWUGlaeWZoY3JsalJMN3pWOTFOWCt6QXJYVkFuT20vMWEyR0s2d29G?=
 =?utf-8?Q?YrjSUvOrJhk1XS1gCH5PEC0B0kyfhtOFqfGwy/R?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WCt1bUdUNDdTWnlBT1VIK1Z2M1c2VUYva0VyWTQyWjJtUUY5OXcrcWRqcy91?=
 =?utf-8?B?K2Frc3BTOURjTXZuSFFoakRlVGppdWxtQXgxcnVNdGg3a3ZVd0ZqQXdTZmov?=
 =?utf-8?B?VDNLYTRlampWUkFVLzdud0wxcG90U09rOUtvWThDL2VlYnlBMDFUeFJXMlB3?=
 =?utf-8?B?UUFVQnFsY0c4QnZaR0ZBQnpCbE9VRk9LNU9GT3BkcGJWYVRkRUx4RGlSaWIx?=
 =?utf-8?B?NU04cWRDelBDTmhvYVFNS09pVEN3M1ltWDRzUzNoS0d4K1NSeDBueUNrdEFZ?=
 =?utf-8?B?dHVRQzI0SndOVEQ4NzZvY0NuZ0VvbXZvWFo0dUg2S21FL0NEY3ppQmlvOGlH?=
 =?utf-8?B?TzlUb3N4MlVnbzNoTkdYYkRsQkVIWS9rU3BhZGhQSkVEUWVORXlBQmJNcFJ6?=
 =?utf-8?B?dEg1S0NUMzFSUE1CTGxBUldFdEdJVndPdUxNN0dLSm16YzlmZUJjSXBRZDRo?=
 =?utf-8?B?N0dzR2lvVmtTcy8xektXcFEwRHF4NWdBRjBNOGphZEVQK3BZbkptRFovSUV3?=
 =?utf-8?B?VTdLSWVlLzFSaVE2SFU1cG51VVRuY1k1R2p1K0hiWVQybk82Nk0zRXYyWjh0?=
 =?utf-8?B?SUFyRDlpTzQ2U0lvQ0RMVW43UUk3MW9yazhUQzhIL0FVVDUrNkM5WDd3WWFx?=
 =?utf-8?B?VVpVUDBCeW5tUlRCODh1Y0J3VnJCaUNhcVJJVEV1eDZXcUQycXZ1dlRQR3Fx?=
 =?utf-8?B?bGFnZ1ZNRGUrbzIwclVJOEo4RGtacW5UbXJFZmRDMkNoMWIvY1FjWDFDUmZB?=
 =?utf-8?B?MmJwY0Vhd3dDM0N4UzFGc2xsMmh1UExmRkl6L29HVWg0L3BtN3BsVVNpbmR5?=
 =?utf-8?B?U2ZJMDBsdFpqZzNlQ2Vyd05nN2kyc2VxNEhvYTR1UmltTXg4VkErQVBRMnpW?=
 =?utf-8?B?bFJ0SWR5dlJ6WXkzMHJWbUhlTFhkNW9xbnZTNzRxVUJGUFMxTmZFRG5yYVpj?=
 =?utf-8?B?M1dqcnpCM21lekZHeWhXYUQwbmVpTVZZSHo0bHUzck5JeEFTMlRORWRXaDZR?=
 =?utf-8?B?eTQ1YXpYTUxCeEM0NWZCcENvSWN0ZklCZnlVVFJSWVdsVk1uL1JZN0NUUG41?=
 =?utf-8?B?VVZKc2JLeDMxNU5oVlBLSFJ5N2h3V1Y4a2dwd0VralgzRG4zK28vd2hQcFcx?=
 =?utf-8?B?blp1VUI0b1lGc0dNNmVwWU5YQy81SUV5UGhkL01DUnNVeEEyYSswVTh2SjE3?=
 =?utf-8?B?ZU43bVNFRlBSWC9pTGtTZUE3dVAzMGNCaVNIbFhxQm1lUzdLcFBvTmxjUTNx?=
 =?utf-8?B?c3hyK2FhQXgwMFpuanZhWWdadGgySVUxcUliaVRSMGhmOUxOdFNjalh4bUFn?=
 =?utf-8?B?dVY5aGIraGZPT3YwazNWeUlkMEZaM2RTYko1UGo3Mm9ZeE1hUjhHMmNMZHMv?=
 =?utf-8?B?eXdsSzRsS0ZGK3VUQU1PeExMS0VxVVhQM3MrdkZOS1JpQXY0eVFiRlVRZGVR?=
 =?utf-8?B?ZlV6ZFByOUdFWlgvQWJQcms5V1NRMFcxaTluRFRvVy9xQWpQam4yTU9yNXlH?=
 =?utf-8?B?RlI1MWM2TGx1K1lmVjZQWWgyaWhxSHdoZFZ4TjEzb0JtVzhWd0hsOHNyNms1?=
 =?utf-8?B?MUhYRml0ak4wR3VDekprazVjL0Fmc3BTc0lrRncwR1NwSEdGUis0c29scHl4?=
 =?utf-8?B?Nkl0WU80Q2Mwb3dJYzFXMHZzRlVlREFTdlAvL0ZpbFdBN0JseVBwNzc5SEZH?=
 =?utf-8?B?WDVOVzNqNG03RElUWUhudEE1NHR0bmhuVk1BZzRXL2hVYWhTV1gwdnpubkt5?=
 =?utf-8?B?SDd5S1BPSkZLK1pLU2tITnZnb0FFbktxa29SdmF0QTZsSmZRVzczbFMxMmh2?=
 =?utf-8?B?L1V2bXVzRW96SGhtVGxEVE1Ga3pJY0Z4c3ZaYVRQQU9uYU5qOHFVdmNLejhN?=
 =?utf-8?B?L0Uza1VWVVlHZVQ5QVNuSy9SakE4T3hyR2oxaUQzMit1VFEzZXhGMHJuTit1?=
 =?utf-8?B?QW05MHJBWWF0SmtXNXZ0Uy9kVS9xOHhJSXptbzFZeEwrM3NzNlFoNzAvaFZu?=
 =?utf-8?B?UFFZQUFvVDB1NWIrZ2dsQjBOMVVOK1c2anNSTm1Obi9VVHVJWnBYNkN4a0or?=
 =?utf-8?B?VisxK0Z3UXNQVFRGVEFnREtXM3MweXpMN2lUL0FLdkxKZkovYzJCY3QzazQw?=
 =?utf-8?Q?BuLw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ad477df-4615-4c8f-2aa4-08dcee1fb5b8
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 20:18:34.2619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1a+KcNt48UF6ETuqG3rGtDEiBruLPSzdPApKWKVWdj3KoPNEz52u50Ohnrn6CbAZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8954

Hi Reinette,

On 10/16/24 13:55, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/16/24 10:32 AM, Moger, Babu wrote:
>>
>>
>> On 10/15/24 22:13, Reinette Chatre wrote:
>>> Hi Babu,
>>>
>>> On 10/9/24 10:39 AM, Babu Moger wrote:
>>>> dom_data_init() is only called during the __init sequence.
>>>> Add __init attribute like the rest of call sequence.
>>>>
>>>> While at it, pass 'struct rdt_resource' to dom_data_init() and
>>>> dom_data_exit() which will be used for mbm counter __init and__exit
>>>> call sequence.
>>>
>>> This patch needs to be split. Please move fixes to beginning of series and
>>> move the addition of the parameter to the patch where it is first used/needed.
>>
>> Sure. Will move the fixes to the beginning.
>>
>>>
>>>>
>>>> Fixes: bd334c86b5d7 ("x86/resctrl: Add __init attribute to rdt_get_mon_l3_config()")
>>>
>>> For this change I think the following Fixes tag would be more accurate:
>>> Fixes: 6a445edce657 ("x86/intel_rdt/cqm: Add RDT monitoring initialization")
>>>
>>> I think for a complete fix of the above commit it also needs to add __init
>>> storage class to l3_mon_evt_init().
>>
>> Yes. Sure.
>>
>>>
>>> The __init storage class is also missing from rdt_get_mon_l3_config() ...
>>
>> 1 internal.h _int rdt_get_mon_l3_config(struct rdt_resource *r);
>> 2 monitor.c  int __init rdt_get_mon_l3_config(struct rdt_resource *r)
>>
>> rdt_get_mon_l3_config() has __init attribute already. But prototype in
>> internal.h does not add the '__init'. Looks like that is ok.
> 
> I also think it may technically be ok since as far as I understand attributes
> the attributes will be merged. Even so, doing so does not match the current
> style where the storage class of declaration and definition are the same. See
> for example the partner function rdt_put_mon_l3_config().

Sure.

> 
>>
>>
>>> fixing that would indeed need the Fixes tag below:
>>> Fixes: bd334c86b5d7 ("x86/resctrl: Add __init attribute to rdt_get_mon_l3_config()"
>>
>> How about addressing both dom_data_init() and l3_mon_evt_init() in a
>> single patch and adding 2 fixes flags?
> 
> ... and add __init to declaration of rdt_get_mon_l3_config() ?

Sure. Will do.

> 
>>
>> Fixes: 6a445edce657 ("x86/intel_rdt/cqm: Add RDT monitoring initialization")
>> Fixes: bd334c86b5d7 ("x86/resctrl: Add __init attribute to
>> rdt_get_mon_l3_config()")
> 
> Reinette
> 

-- 
Thanks
Babu Moger

