Return-Path: <linux-kernel+bounces-541046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40360A4B7C6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 07:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7A333AB4B0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 06:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFC71DED56;
	Mon,  3 Mar 2025 06:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FFdNUcXX"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A5E18E76B
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 06:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740981689; cv=fail; b=so4Be/S3VwDWU/dvHYrOfY5XQHemrqmEvqcxiou5hG1W6E+v750HPn4ETdCUf7IUe+d502D5pNVOidsD8Axy+AK0OvlD3yXSf+1dur6cxOGzmwbqPXYCHmUm7gn4wn4b5KiX8KxFWMSmUNKJL583ZAyAuTHUMaRlSOOsl9/CIx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740981689; c=relaxed/simple;
	bh=gSfu0m7uS4BqTHuXRXJTryGmYyZwB6alBIKXNDf9OEI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EdHF6DST18hqj9m2gUM0Ccptv2kh5hhQ73yHATMxqQhRRFf78+PWqGBtKkwZtveKv15b2wU8zDXiLpiy3MpYFPsY67SNdCtuHhc8go2M9wCapKyUim7Clf5Rg6Wgi7kdwGX2IwBbgxEdVKJ+mJMbkG9xb2xWx3lck+kDIvnfGL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FFdNUcXX; arc=fail smtp.client-ip=40.107.220.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WTiz1yKBq0Z0u1KjMrUBRwJQkiWcB1fLO8GUU+pvEsfRthcWvw8XStrqtVdJ+hMjd4/XGTx1KppqjgvVQKSwVXXiYNEyvEL7ud7eJ103niEzOUmhXjSL+D474mnvYyNEPwxtAKwEwzrCYcp4f9tIy0WN09W3WPqrVUge8p6dax5fr/4Q4lP4seaS4WnR8GsaINqZPPmleAMAZzr9pk/b0NmxR80O+BOSJr3JL1Oyut0xwujEcSgLhUMe1rRfY2Y1kt3kTg02oKxtCpyzEn0ZhgGB7Lvh1OjEMe4Yq7cBtwh1Hl7YZUF6UpzEOR3Vccv4IRM1e7Xm0j8Xu8QuPzMXDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nbiRiC/Ayrf/Rv1apiUmhLt3P7uvdtPcCbJt7WImCxc=;
 b=ygfml6N2NZq/XpDRFhtRLSzTPj0JITe4bjv2SFkGJLQ8nDXDgClLVv803FNCwoU8z73nahuFVm+tZ/FryqPUZCaTQ9gIffkN+DJJMciJ2l6H33ybdSEfDQqswmwCWjGDNqwSqJjiQT3B0jKkOb9b0yADaz6xhzh0IM4Dimq9wK+R2qGbHznCUypUfhnIqQ0eQLkQWOS1XJseKUigdgdLt9u1hH/NIJ6j6p8n3kEgCbxyAAI7DmNfSh4XkhIwaGw5l1BRx1emgw7fD7EAVxJjGcrgnXGYzAjAJ3G1vSUvGMX3J0vmrIsqr+o+E89Q29EzttteYXnGfNXgIpIA32cl/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nbiRiC/Ayrf/Rv1apiUmhLt3P7uvdtPcCbJt7WImCxc=;
 b=FFdNUcXXepwXQeRI7VqJG+JDINYid1dZ2OeScrwO4HiYSzHCgRHXmWdJk/0etHW0lmSiTQ/YazDgIers/O6oHzLF2+DWTsIRrwzAwb7huGbsY+PebMZLJ7ii10T6u+EDtyMK6ANfnOT0/yw2m70MDIzrjCgYKGjgipgSz+SVYbQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by DS7PR12MB8249.namprd12.prod.outlook.com (2603:10b6:8:ea::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 06:01:23 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%6]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 06:01:23 +0000
Message-ID: <6c4db425-d3d2-491a-82e6-d8409a2bde9f@amd.com>
Date: Mon, 3 Mar 2025 11:31:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/24] perf: Make perf_pmu_unregister() usable
To: Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org
Cc: lucas.demarchi@intel.com, linux-kernel@vger.kernel.org,
 willy@infradead.org, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
 Ravi Bangoria <ravi.bangoria@amd.com>
References: <20250205102120.531585416@infradead.org>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20250205102120.531585416@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0022.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::27) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|DS7PR12MB8249:EE_
X-MS-Office365-Filtering-Correlation-Id: 809b5aeb-1b43-4cd6-6f92-08dd5a18d392
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VHZLd2k5dUtkdUpTU2hZbEZnazY3bVVrVVVjdndXRjhPdXBRNElTdlVabWdp?=
 =?utf-8?B?ZHpkc29xWXNGM1luSjZaR1g1VmxudkFpMzdwN2tpNjVyb1hGWUMrcW56RVpM?=
 =?utf-8?B?VmZvM1hsOUVRWUJ1QmwreStpY2ZYNzM4QVdKZ01zdnZKeVJoNC9Oc2VjS2xL?=
 =?utf-8?B?Qkl4MEN1MmhLRUsydC9PZDRPQTRCc0YyVzI3TDRSZmNnVTBFTGZpYTNsSUpp?=
 =?utf-8?B?cUFlUC9VMVZnZmpNODFsOWpjc2h2ckdDVHRJTm9MajhDZlNNeWdyK2xOWXpv?=
 =?utf-8?B?dnJCNFlTZytHTVRpaElZOExaYys1bUVmNU84c1Q1QlRTbXE2WmpqOWlKMFVO?=
 =?utf-8?B?NUd2VGlyQmNQVnd2Vkx0ZFJlL0NSZGFQMTF4NUdBcG5hZG1DVmc5c3JxU1cx?=
 =?utf-8?B?V0ZJdDBGYU1BQldCQWVLV2JNL0FJUVhVSmFvTG1DelBNcnN0YnhibGF0dlY5?=
 =?utf-8?B?NVZQZ3NKWVBtSS83M2MwbGV6bmVTRWdmRzVWWEt3dWRTR1VjYXhvWUxxSmw1?=
 =?utf-8?B?MEVab081U3hyZjFnU2tOa2hLSU9Tb2VJL210ejMxRWFaVHh3MGlwNldJUUFt?=
 =?utf-8?B?NURzTGJwTkVwSnFpazdiN3NFMjRWTUkwL2pHUDhNUUlzY1VWVENoRnBQMmVu?=
 =?utf-8?B?TjYzN2c0Wko4WlFSM0haT2VUQjAvRnlVUFV3U0tvWmp6RHB5TmlXY3B1ZUVO?=
 =?utf-8?B?cjc3Q0lCRjJVZWpOTmpNTlZJc05ERWZhMkh3cHFoNE51UEpET0lvZFJ2N2N1?=
 =?utf-8?B?cTZidURVL3RzVWdGT3NEQjg5dGYwUGxvejVGeXcwOVVSNk01QW1ZMmEvcUJB?=
 =?utf-8?B?bmowSUJCdXF0WVBGWWY3UGlxQjRSQXUrU25mOWVCZW16WXRONjBOeERZdDRH?=
 =?utf-8?B?VDM2WGFFTmVBRTREY0tnK2xhZ3lWQ21SMHRlcEhkZXhvUkVJMXVRcHJORWZV?=
 =?utf-8?B?N3dlMisvM1RzL3IxQ3pWL2h3UG5mVTJLZHU5eUQyWS9UWXFWN1hObmM0eFVU?=
 =?utf-8?B?Y1VKS3JmM0hiaVhQQ3hQTDkvdDFuVm4zaW9Bb0YvQjhrSmRwdlRZZEUzM1Fm?=
 =?utf-8?B?M01mUXAvcW13TjR4MEQrSjZlQ1hXTzZTM2VBWWgwdlVHSkljaHNCbGZFdEVW?=
 =?utf-8?B?R002aW44ZWpoViszYkNkNjlOQkhMZTYyVTdIN1dKK1N6T2ovYjFHakVKT2c1?=
 =?utf-8?B?UTBnclNYclVJTlZkZ09xUldYZmpCT3ArQTF6eTE4cDBUa1RPQWdUMDlZcnh2?=
 =?utf-8?B?RG5PMWVVNkNSN3kxMkpZdjdDbUFDZTVpQlJhT1Y0d1dPblo3bmg1UnRIOVZH?=
 =?utf-8?B?a3d4QWpGOXQ4VTVmMzJ2ZjZrWGdiSm5teDd6Z2M1Wmh3OFExa2xaMldnbVlN?=
 =?utf-8?B?cDliSDY5aXd1NzlJZXRQWW5FS1pORjQ4WDRqdVVYQkpUNmlYT2RndWFIZndo?=
 =?utf-8?B?M1cwblR3OHY3NVpHUHp2YitnM0gvNGNITDNRMGtzQjhCUjVubjNxZGFIMGsy?=
 =?utf-8?B?SWU4aGgzOGN2L3VvMEZaRFgyWlRIWHg2aTd0YkR3TGY3MEo3Y1RnRkdaemJP?=
 =?utf-8?B?TnQyV0FBZXNEZUdQcUpkVUo1dC9iTW4wbXg4Wm1RMUswZys4bU9CSzhaUVg3?=
 =?utf-8?B?bjc2YzdwaDNndTdMV1p3amplWkszbnBxT3pUT24zb1UwY01VTDZ4NU85eGF5?=
 =?utf-8?B?QmZPSEhxOUU1dGkvaE84SXMyR0NLZmY2UVJkZnFSU29zL2QwcjdDdmtkZitO?=
 =?utf-8?B?THl2R1dET0ZqajdrVktlRi9YRGR4elRVSEpHRE1iaUhSU004WWpISXBXZGdF?=
 =?utf-8?B?NkIxeUJweFpJUFNtN2FDSWNOdVF0VWVvb3cweGNkRjdSdXFmbTAvNUdrUEpy?=
 =?utf-8?Q?jjq7vaGE3JsQR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UjJQM2J2VWFOUlM0TWhWeG1PSHhaNTRUNnUrTWRtM0xvYlY3Zlo5dzVocXNw?=
 =?utf-8?B?eG5VMU5TbDhTeWFydzFPbW5BN3kwQjhXVmJobDdINTExRVNLVmgwVEFuVitI?=
 =?utf-8?B?MTd6dGpHMXppQ0grWndRQWVucHJMTUN2UlNSQkJKWkpwZ2srM3o1V3BsNENG?=
 =?utf-8?B?UUxCcDdGTHBWTUwyemI1QVdpRXVzY0VqVUlDS3R1bldiakpMK0FORG1ZYUlT?=
 =?utf-8?B?TU9VV3VQb2xMbHNYQ1VIc01pWWUxYURPN0JvbysydHVvSjRnVUEyVlFlNHoy?=
 =?utf-8?B?UGp6VmhyVHYwc2xPZDBiREJyaTNJVUVkdDlmd0NBNUlnWGoxVWNlM3V5TU9p?=
 =?utf-8?B?NS84MFZEMTNzWFVKT0VNK0EvN096ajFDQnhrQUk1OWs3SEdaWkN1OUx4Wkk5?=
 =?utf-8?B?NEtiNU1va0QrMjFtVDd3U1EwVWF2czdMaFNtT0NXYW4vQkhOTWl0L3dkSWJW?=
 =?utf-8?B?dkRBSm1TaW5hVGdQMEJWZHdjZUZoVG9BcTVkbCtDWlRBdlZoS1kvUWpMWFlp?=
 =?utf-8?B?ZWliTGhSWjdSK0p6Sm1QZUxLanh3VzJTZ0dQTFVZMlNmK01TR2NlMmxVdFll?=
 =?utf-8?B?Ynl4Z0FySWZVNVhvRnpCV2lrVVBRWkl1d01QMnFobklSTlM3Vk9rT09WQlB1?=
 =?utf-8?B?L1FHVDludjhZVkd4Q0ZjZVBWWEV0MUpjR05EVHF6UFNKaWxQWUQya3RHdi83?=
 =?utf-8?B?UkdRaGF6V3BVQlB5dEFlNTdVUEVIY2RpelVNKzVBeUhyRVBIMEV6enBsVlNT?=
 =?utf-8?B?TVRaSHNieDk5WnBZdTcyYlovTGVFeDZvRjVBc25wL25pL2dyNDZaOGJHUW9l?=
 =?utf-8?B?Z1ErNFZ4cE5KZG1udVRGOWQ1elNlZ0UzMk8rMXZpUDNoTGxUMzBFZUhsRExV?=
 =?utf-8?B?YkQ1T2lRMkdWNitqc3RyRGJWZ05zaVJhejhjSnZ1RVBFZmlkQTE3dmxrV25T?=
 =?utf-8?B?Y1ErUHlYUWtXNUhjbkd1QlpzeElRdzFBaGVxaXRLTnEwWUQ4d0ZpK3Bqc3pB?=
 =?utf-8?B?djlDNlM4VEk1Zit5RHE3TU9lZFB4RWN1N1ZuaFgxd2ZodlEyb0VmYjE3ZG1w?=
 =?utf-8?B?T3pBZkpJR25tVlNLRHpKWVh5V1hWZDlNT3ZDazdIbGVLWUdzOTI4NEpnUDVv?=
 =?utf-8?B?d200amZDU09NVkdqTTMxTTNCMldzNWUxa1MveEF0SVcyTTZiOEtpK3o3bHI5?=
 =?utf-8?B?ZVFOQkhDZ1RYZW5XdENNTWFUNUowVWdFUER2OG9IVmljQ1VXOVFOVHBCTUVC?=
 =?utf-8?B?Y2J4N05MTE9XVUwwaDJ6bUgxaDRkdUdRYm5ZdnlwVE9MS0FhVnA5Skl6aW1G?=
 =?utf-8?B?RVhjZ3ZBRkhlZzV5OFhzdnhlYVc1dVBRbFI4cmQ3U2NScksxWlRlbUJBSzNt?=
 =?utf-8?B?YmZrdDkxOEVtTEFjMWhzNVMrelp3MDhBTCswMkJwa0tsOXlNT01kNnd4QjBa?=
 =?utf-8?B?aHU3V1l0dTZLcXhENlhzNkRySDJhMGV2SWhkOTNIb1RmeVNlcVkzSkFaTmx2?=
 =?utf-8?B?YVR4VCtyWk1DeXV1YzlxTWtVRzNhRS9FMit1RUxCcFlQdDQ4SEhyWDFBQWo1?=
 =?utf-8?B?US9TRUJ4YTErWStnZEhGUFNCY3BVcFZrSGtkOG82MEozeGdvV1ZCQUIwZmRH?=
 =?utf-8?B?TVV6SC91MEdiSXhvamRuK0paY050ZitYczdMZFQvbExvU1RPUzRhVTlqUUg5?=
 =?utf-8?B?dEFoU2dueGg2dVhiVk8wMzJVSjBXWng1K2MzckRrdUt1NlJsMkVVRHlNay9G?=
 =?utf-8?B?V29qOVA5M3BDQjU2VjMwWFV6VXdNaFdpbHFlcXVuM0FxWVZXRE1oUWtia1hB?=
 =?utf-8?B?Z2FPQlVoOXM0Wm9KQlgxQXRqcWRFSXpTWGRVUkdzUDlndHFOOVVSTktUQ0Rn?=
 =?utf-8?B?MmRrSVhabFgvR2xLYitmOUhPMkJEbGZhV0hPOVdyUVlNVytIMmxaQ2lweXM4?=
 =?utf-8?B?ZHhuQWdEcW9sRVFyRk1RZUt4eUdPTjY3dDY1Q2xkS0xHUmtTRFBjaXgxZmta?=
 =?utf-8?B?eHJvaXcraWpWSExFUFRyK1VIaHhHT1llRVRzWlRWWWt3UlUzVXVocm1HQ2Rm?=
 =?utf-8?B?TWNHaGdLTkcrNFhhVEVmeDNZQXZGbTk1N1pXNUZJdXdoUVprN3J3cDlGcGts?=
 =?utf-8?Q?hXF1BsjuzEPKvrwXKBix298PQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 809b5aeb-1b43-4cd6-6f92-08dd5a18d392
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 06:01:23.5523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bar9Eu1cPRls0De6rHxDjDqM+NdCvb3sQw20OGAXd5aZwbevbVY6QwfUlyBIwxPf6nghirbQcjzueKFx2osZ+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8249

Ingo, Peter,

On 05-Feb-25 3:51 PM, Peter Zijlstra wrote:
> Hi
> 
> New version of the perf_pmu_unregister() rework. A fair number of bugs
> squashed.  Much thanks to Ravi for writing a stress tester. The robots also
> managed to find a few problems.

I've seen more issues (in addition to what I've already reported) with
v2 as well (I didn't get time to debug those so I didn't report them
here). However, those additional issues appear only with pmu unregister
stress test + perf_fuzzer and IMO pmu unregister is a rare event and I
shouldn't block the inclusion of the series. So, with current set of
issues addressed:

Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>

Thanks,
Ravi

