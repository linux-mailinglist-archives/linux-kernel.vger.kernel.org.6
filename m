Return-Path: <linux-kernel+bounces-262490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BB093C7A9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 19:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E5CA1F2259D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 17:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB27619DF82;
	Thu, 25 Jul 2024 17:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DMFATi14"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE37199E9F;
	Thu, 25 Jul 2024 17:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721928523; cv=fail; b=BzVhZ/cbncAC4DHc2Lxw6LhKhuiqDXCxqTsnn1eRmZ7SCpeWk8H/XzZhqVLKwH9ikP2CPwEnXnL0x5ehi8fc6g6sW3VS/1fuwF1tnpdRsJQxZQ48FCe1gBnWyEEFtPtaxypf9nejEjlJnto7VqxCHdIjgpP26Cw+qsGMyCs7sBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721928523; c=relaxed/simple;
	bh=BPiqDWrPK1kjim3hugjri7gymA4DTK1pcFgx/JGh4mY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bW+yOR3LjcHMB+3Ac80SJgNrb8rTJj0dvBGpJAFkFA54aJ32VflAJX4wjmWYJIdsg/doSrKDJM4HnLbOvjV4QqaJ2E8R+VRgWMCHKpetQVCAkqXpdEjXF47Vh4SZW6ITXxY+8dhHbYBEBSPjT5MLUVxn17DckWbrJh/jmWxiuBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DMFATi14; arc=fail smtp.client-ip=40.107.94.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RgBFdb+vrvfX7LbJkhkGfvceefZxvNJC77hKWJXTc7KYuO3jWcJh4LpeTojRjkajL9u+q2SdNvpalQ3ywxhbjaTxkE9RhGEW3DrVZeHJgRiRXI8DVYY5hkWDyNhayM6xgsHyd7buvMVbSRd2FMlsmstq6H8pVW4+DgAJ9Xkm0mjin8aKsquqeZbmZQJ1P4sFKv8/LkSCW3hUgrIhd97e5nkKchLWpLqMJi9eVsdID1GlTt2spqUj+pmviFb+NKQBXfG+csc3cm3AVdAD4LEWnKPuMS29mlxTjlRcJnql9OKGnfmqIKpV6A3xBjcKXdaXALqOzZrlmSjexjO3fCyCrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/LD/T6GImYxI5mtMsYQQNuVv1tzhlRlkJ/SPLcN25Hs=;
 b=uZm8Do7LTxT9f9ZrGjTFl1HNtezTCCYvesK+/UfobhQleermY7Js2hqw7+Ssp9s01WvDppoki2TxAyHX4DJUkiHkBtOEf2YToKOqeGcK1d7NCvjICemmGZ5+0ftgZIhiEzGxxpIr2sx49mu4QFFAotxYag4fy/t5UjPaq/3kv236isF6XP6HC/YnDvYiLUPd523q1COfKmNyzxegDTnKMJpPCSZBfM+VP7pvHYPGdMMDrGqrtYortRuNZp4Ny+3xryaHF3UGO8e6+1vc/zl/83WOQDAJeGDeqfGt8fqUoTzheF7mYi6PyoWAgYHkYa1Fa9IH1G7WvaRRddbJdVsYAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/LD/T6GImYxI5mtMsYQQNuVv1tzhlRlkJ/SPLcN25Hs=;
 b=DMFATi14aQOtva5VO6iADezv1YYrYa567JinrK7vEawswwyM11VBHVnUMUv6dmO9d42Wb7QKaQX+tvSG7tnXsDsV/BmjfVxQmiu7sjcLaMw/K1/dYKQTqtYBhFujjSyaoWqwQy1RXneKNNyPX4sThBSEZsBL1uxe8ax4iPOOgEc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by IA0PR12MB8695.namprd12.prod.outlook.com (2603:10b6:208:485::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Thu, 25 Jul
 2024 17:28:39 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%6]) with mapi id 15.20.7784.017; Thu, 25 Jul 2024
 17:28:39 +0000
Message-ID: <6535bb31-8f91-4b0a-904c-45f320308966@amd.com>
Date: Thu, 25 Jul 2024 12:28:34 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v5 20/20] x86/resctrl: Introduce interface to modify
 assignment states of the groups
To: Peter Newman <peternewman@google.com>
Cc: corbet@lwn.net, fenghua.yu@intel.com, reinette.chatre@intel.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 paulmck@kernel.org, rdunlap@infradead.org, tj@kernel.org,
 peterz@infradead.org, yanjiewtw@gmail.com, kim.phillips@amd.com,
 lukas.bulwahn@gmail.com, seanjc@google.com, jmattson@google.com,
 leitao@debian.org, jpoimboe@kernel.org, rick.p.edgecombe@intel.com,
 kirill.shutemov@linux.intel.com, jithu.joseph@intel.com,
 kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, maciej.wieczor-retman@intel.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, eranian@google.com,
 james.morse@arm.com
References: <cover.1720043311.git.babu.moger@amd.com>
 <49aa5321f6e81825a0e9e44cef06c243634e341a.1720043311.git.babu.moger@amd.com>
 <CALPaoCjL92Jwm=Ynt+pEpSt5KLVxnJL8KOKymZ=WP+cUufy_Uw@mail.gmail.com>
 <54127ad5-8dce-b783-acf2-61bebd0db86d@amd.com>
 <CALPaoCiv9pFg2kzG9i-mVy4D4EP600x38F+WSXR2DqoZ9GjecA@mail.gmail.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <CALPaoCiv9pFg2kzG9i-mVy4D4EP600x38F+WSXR2DqoZ9GjecA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0090.namprd13.prod.outlook.com
 (2603:10b6:806:23::35) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|IA0PR12MB8695:EE_
X-MS-Office365-Filtering-Correlation-Id: 73f37ac6-956a-41ef-fc41-08dcaccf389f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R1g0NFlSVjNDaXQycFBqejdQNHo5enNzc0Q2QjM4b3N6cC9MNUNIOFlxbFJl?=
 =?utf-8?B?S2ZPSmFkSFFTSGJMM25IaWpBb3FodFo2S0VLcnliQVNqbEs2ZGdZQUk5K0wx?=
 =?utf-8?B?b0RMUWFsRDZPYVNRUmw2dVUwUGxPcWwwK2lJTE9seWxsTTM5MzdiNjRGT1Va?=
 =?utf-8?B?UjVvSEIyY01INVdMR2tPbVhDUlRGSkM2eHZreDZTNGZxMncrWFp0Y2lla2RK?=
 =?utf-8?B?cndqZjJQOHhlamRkS0ZQVU9QZFlyZW1paFhhaC92bk1zZDh1MmpyQlNIL215?=
 =?utf-8?B?WXBqYjlpUTJ5a2hFS20yVko0b3lJajk5eWlRWm1qNE52SFkwWkZXNEh2dCs4?=
 =?utf-8?B?N1BDZ0MxaHozMTZka2RZcjNHYVc5M0JkN0hvZVhXR3dSTUx6czVlM2lPUlJN?=
 =?utf-8?B?Sy9XdW4wUGJEckZSUU0yV0xhOW9SNHZZRW1waVhXZWR4SXhISlZMd205Q1Nj?=
 =?utf-8?B?QnF6Nm9rbm9QYkRkVFFSZWtVaVF6MitYS0QrOTNpQ09heklYeGpTNndUWTdy?=
 =?utf-8?B?eVJyNHZuK2VNbFl0bXN1RWwzVEZHUExYWStsUzQrWmtMRzUxNzRnYUtlSFow?=
 =?utf-8?B?T1U3akNOYXJuNnk0Rk5zTzFVY0VHQmpOcWhLRkhTUTY3ekpUelBUYnI5T3Rr?=
 =?utf-8?B?djdYb0RCbkNWRVVvWjVuNzBXei9FeFA3TThHNytiZ0VBRzdEUm54dktwYzkx?=
 =?utf-8?B?K1RGTUFYb1dnRmRHdFRwMFdqSUc2VnI5Q3ZBVC9kTDFBaHVPcWVhNCt2OERE?=
 =?utf-8?B?S1dQNE96QjlQMUROcWRwNVNEeU1JcGlzTGFROVlDNEJRTXBqdmRUSjlYemJm?=
 =?utf-8?B?RjdtQ1c4U043VnBNUXIweFlha2hGZmlQMU01UXl2RWdCdkZZdGF0MTdhc1B1?=
 =?utf-8?B?eElSeVlvaG1kRzB3WWdFdWdlajVNT3RKTnk2TFErTy9iSWNhQWRkd1V2elhC?=
 =?utf-8?B?TjlSYmh0Y0EyR0ZlU0E2eWg5aXU2ZzJ5amdKS2ZkZVQ0RWI4em5qSC9TVkxG?=
 =?utf-8?B?a1V1OGx3MXh4YnhRcWJCUU5hbU5HVXU5Z0tnZmw3eW5raGpIRE9pLzdiay9w?=
 =?utf-8?B?RkwvTEdINVNLTDc1cW85eFljRnZsSi91ZEk3cHcyTEVSc2J4YUNkdU9PZ0dF?=
 =?utf-8?B?dG1WUllHN2I2SjU1bmt3OTFZYUVXUFpFVVAyVnRjZUQzUDg4Q0V5YUhFWFdG?=
 =?utf-8?B?dHFzWVdGcTdob05GZnR2Wi9ZR2F1bnJMZkRWK25FZ09yTkNuYjJkQVZjdTZJ?=
 =?utf-8?B?cUN4Vk84dFpkZU1rM3VHSFlpY1gvMUZTbm1yL1RTNXpTN2lHeGlOTFhmTng2?=
 =?utf-8?B?QnJiUkhibFpFT2FMdVVjRG9oRlNkVXpoZkNnZ3MzU2VZaWU0dVlSeElFcmlK?=
 =?utf-8?B?UFRzRkpQb1hxQzJFeWF2bTZIbVQ0VXBVUzJFeFdWeDNYUkZ4RmcvS2Z5blY0?=
 =?utf-8?B?aHBWeGgzRG13eHJKN1RzOE5VRldXdjhVWnBqb0RKQVlWVVZ4K1JqV0V0bkd6?=
 =?utf-8?B?YUo4L3dEdlRkWXBnUUpRc2R0SnlIK2NLNkwzMXA4N2ZqeFkyMC9NUEg1Z2g5?=
 =?utf-8?B?QVlwQ3hiMWZtWUV1eC83WE92eTJ4MndPUVg3Zi93Lys1ek1XcWxMZ3N4bzBQ?=
 =?utf-8?B?VWZVMXdZeFZ4N1ZqcnkzSVkwbE52N2U3dHE3WldOSnI5NUU2bHZXWSt1ZEM4?=
 =?utf-8?B?UHl1WDBzbWRUYmRmRVZaTElOdFQrWHB6Z3RiWmVKNjlTd2VYYU4wdklIaXp3?=
 =?utf-8?B?aEkzU2tmdW5DRWhGUVdocmdkRjFXNWE3eFJGOWIzY2lvTVI1ZXkvWVhiNncw?=
 =?utf-8?B?WGNuckJlVTUvRkd2VE1uQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Uk5hQ010TG1tK25JR3F0MDB2SExNMEg2ZFRBK0tsWENkUExwMzlNNm1nZS9W?=
 =?utf-8?B?cktaRXpUdkFSbWk1cDdIWCs4Q1pKTzJMVU80ZlhIRk1zRFJ6Q3h5cnpZQW11?=
 =?utf-8?B?Sk0yWlVoV2FGZWg0Rk1MZVNST0gyK2NTclV6QzE4dVZYSDdDK0NYSEN3bVJL?=
 =?utf-8?B?TGdWREs3WFpDOWZHMFZLU2ZnbHkwWmpQdnBONVFQMHRRUGxtdnphSlRPTkpu?=
 =?utf-8?B?aWhJSURyZzZGZTZDbjQycDRJMmxKNGMxOWRIdnMxRldPUGt6eS9lMUxwL2Ja?=
 =?utf-8?B?bjhXUlEwV0FEYytNTVVZbUg2WG5sQWkwMVpyNWxISDFLT1VBcGNVYmlrYWND?=
 =?utf-8?B?YklMYW5OT1RINUZiejNPeGRYVUxKQW5odHlMQjdUZDhOenRrYnFjU09Hc2E5?=
 =?utf-8?B?djZnanJVRFhicEphYXJGUWNSS0JrVUxZZnZmOEVteXZMSDhQNkRnclEwSjZ4?=
 =?utf-8?B?UVVIL1FuTzBDVnhIcFJTek4xdmNGQ09LYjNnV2gvbldvMGltM3J2UGswRGph?=
 =?utf-8?B?SHNBTTBUM0xmUk1YcTRjbytVWUg0bmVrZ3BTRnhybi9jVW93ZzZOSFJ2UGhT?=
 =?utf-8?B?YTltNXQ3MHVsUjFvT2kxOXRpamRKUzlsWktDU0gyRitSc2orZWlkMmp4QnZl?=
 =?utf-8?B?VTJNL254VENFM0V5a1pKOG5OUFA4UUxvK0hYWmM1dEtWNUZrSFo2eExoTnA4?=
 =?utf-8?B?Y1BxYldKd3NpMUd4SGtOSVl3Q1FVMkxqVDF3ZytOSXVTcUYrVFBOR05Dcmo4?=
 =?utf-8?B?ZWNCa1dueEFCLzdibERYM3lrdVd5MzhyVU9DSVZHODRzRGIyVHdDYkxhbE5v?=
 =?utf-8?B?TnZaREpUMUtkTEMxRWlQMElKMjZ3MDkvYlk0cnFNMGZUVWcydGYyMFRmRi83?=
 =?utf-8?B?L1B0Y0k4NU1RTG02MFJsZS9abVEzV1M5MURwZkhJQmZXMWpaUWYzZVZLTnFL?=
 =?utf-8?B?OURpbVpDZ3R1c3VqckIxSjlkZm82dkd5MG90TEJvUFI5SDcwU1pxekx2dUxH?=
 =?utf-8?B?eVA0RWc5aDQveHhVTEdzRXZ4MmVtWS9MSjNqMVVWOFlVL0dzMm5vMGY4U3BH?=
 =?utf-8?B?YjVqaDVkVE5TUVJ4eHBWTDFOYnE3REFqbnVIMDhSUU4zQ2NzVG5ROFZ1Ly8w?=
 =?utf-8?B?d0pkNDQrZHQ3ZTRITWZ4UDgvNDlHdjl3NXFOY0xWZHFLUlJhNFNKUG1uZlR6?=
 =?utf-8?B?dkhkZHRFY3BwNUJxcG5OUEtONjllYjFnWnBvZG9PQU5lZjNSNy9sOTBOZEVw?=
 =?utf-8?B?cm83MGJPOTFNZXJXa3JJenloT2FqWE5rd0ZFVjc5eU5WeW11a3lMeTdDZG1x?=
 =?utf-8?B?ckRkNFkvQWRORlY1UHFOd3kvRjV2aWg4cWEwSWFHWEVZKzdTdWp3NmFWVW1I?=
 =?utf-8?B?NVB2eFBtQUxyazdnbnRKSUlqNXk2M1RTd2lJeE1EaG1KRE9UQU5NbHo1YTVW?=
 =?utf-8?B?c3dTcFE3Y1hVbWtTdzVGdEFJSGZXVWFrRHBwaStBZWtxQzVXQkZxemlUeE1P?=
 =?utf-8?B?akR5RWcrT1JZdmVpM0p1RkttRHdnNlNRWG1XaFE5c3AyaHdLTFFEbFBCbCtD?=
 =?utf-8?B?RjQ5ZHVVc04wOHI1SUcrdDh0QlBkekgyTEZTUEFlWTFhR2laR0ZIMnV5dy9x?=
 =?utf-8?B?K1M1T0tSNGd4ejJOVXpHQmdIVGxhZHU4SEhnVHVwcEZHSFVWbjZjV3I0SkdU?=
 =?utf-8?B?OG1UejRmS0gzT09rcDFPOEFBRjcxWHQyQXRmVkthUUNmaUJDdTVYZFh3RDQz?=
 =?utf-8?B?S2w0SWpVU0pNZHFDTjVudWQ4OFlwRkJRZWdNSjFrOGFkWHY3T000N3RLYzkv?=
 =?utf-8?B?S3BINlRZV3d5eGVsTUhybW52SFRJTGswREpWS25uNm1LL1NQcWxrTGk1Q0Er?=
 =?utf-8?B?L0ZVK1NWS3BTKy9XMU1PUGpwb2NPL1QydzlERU9YU3N3YjVUZ1dNWXExbHJE?=
 =?utf-8?B?eWV5SjhDbldYckVJMU03bDBZKyt0ZGJCb28rTzQvTXRzRVpBK1VCOWcwdGVy?=
 =?utf-8?B?TGRwUU9MYUloR0djN3N1QXRBSlhiT2Y0NzZOMHR6OUJDWEsrVElMSEdZREk1?=
 =?utf-8?B?cTlKMjQ4MytDNThwbllrZWtvbUZSK3h1K3JKZHNWdFlnM1IrRzFabG83d1FL?=
 =?utf-8?Q?uvUc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73f37ac6-956a-41ef-fc41-08dcaccf389f
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 17:28:38.9563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qsn1gU+JKVQHgV+mndIv0WUxT8/32dt09Se1eZb8+7QO2tVzMpfi1tp+fY0YDuVq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8695

Hi Peter,

On 7/25/24 12:11, Peter Newman wrote:
> Hi Babu,
> 
> On Wed, Jul 24, 2024 at 6:23 PM Moger, Babu <bmoger@amd.com> wrote:
>>
>> Hi Peter,
>>
>> On 7/24/2024 7:03 PM, Peter Newman wrote:
>>> Hi Babu,
>>>
>>> On Wed, Jul 3, 2024 at 2:51 PM Babu Moger <babu.moger@amd.com> wrote:
>>>>
>>>> Introduce the interface to enable events in ABMC mode.
>>>>
>>>> Events can be enabled or disabled by writing to file
>>>> /sys/fs/resctrl/info/L3_MON/mbm_control
>>>>
>>>> Format is similar to the list format with addition of op-code for the
>>>> assignment operation.
>>>>   "<CTRL_MON group>/<MON group>/<op-code><flags>"
>>>>
>>>> Format for specific type of groups:
>>>>
>>>>   * Default CTRL_MON group:
>>>>           "//<domain_id><op-code><flags>"
>>>>
>>>>   * Non-default CTRL_MON group:
>>>>           "<CTRL_MON group>//<domain_id><op-code><flags>"
>>>>
>>>>   * Child MON group of default CTRL_MON group:
>>>>           "/<MON group>/<domain_id><op-code><flags>"
>>>>
>>>>   * Child MON group of non-default CTRL_MON group:
>>>>           "<CTRL_MON group>/<MON group>/<domain_id><op-code><flags>"
>>>
>>> Just a reminder, Reinette and I had discussed[1] omitting the
>>> domain_id for performing the same operation on all domains.
>>
>> Yes. I remember. Lets refresh our memory.
>>>
>>> I would really appreciate this, otherwise our most typical operations
>>> could be really tedious and needlessly serialized.
>>
>>>
>>> # cat mbm_control
>>> //0=tl;1=tl;2=tl;3=tl;4=tl;5=tl;6=tl;7=tl;8=tl;9=tl;10=tl;11=tl;12=tl;13=tl;14=tl;15=tl;16=tl;17=tl;18=tl;19=tl;20=tl;21=tl;22=tl;23=tl;24=tl;25=tl;26=tl;27=tl;28=tl;29=tl;30=tl;31=tl;
>>> # echo '//-l' > mbm_control
>>
>> What is the expectation here?
>> You want to unassign local event on all the domains?
> 
> Correct.
> 
>>
>> Domain id makes it easy to parse the command. Without that it parsing
>> code becomes  messy.
>>
>> How about something like this? We can use the max domain id to mean all
>> the domains. In the above case there are 32 domains(0-31). 32 is total
>> number of domains. We can get that details looking through all the
>> domains. We can print that detail when we list it.
> 
> This sounds like only a minor simplification to the parsing code. It
> seems like it would be easy to determine if the final '/' is
> immediately followed by an opcode (+-=_) rather than a number.

Ok. Will try to get that working. Will let you know if there are
complexities with that.--
Thanks
Babu Moger

