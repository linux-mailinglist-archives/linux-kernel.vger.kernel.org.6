Return-Path: <linux-kernel+bounces-369193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2B49A1A26
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 07:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0CF9284243
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 05:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF41143895;
	Thu, 17 Oct 2024 05:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="W4u+dPMy"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2057.outbound.protection.outlook.com [40.107.95.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4C021E3C1
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 05:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729142700; cv=fail; b=jEIRl1NWOmb+hBzjc+wfxPlIfRXuO/6kBkY6l5A1iUUO84O2CaDXDY2ITqDn+jMFP/oB6pvafARw46TVDmgF7Uim6Vysk6p1K6vNi3Bbuhst33dP1QQNw5jJXUIKvFKvcQ0c0kv2H8shfO+lUDQCE6EjoGGJG/KUnXtG+mgACvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729142700; c=relaxed/simple;
	bh=jt2YQUqqMbmghqHF8hy/6pTQhEWLMd0Zkf6FvgOG0ko=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I9JI2ZZH7QPH6su9nHdK8DefC5uSA97GZRs8es5IkGSnBY1/k6eRa7KpOcEW+tPW7wUk7nl83I7Ls5S8D/pv/SZ1WikGFimBFPw+4kI+oNH4GSYN7SVXplixRj7D8oI4/qpAGP3yfM/npRelp2ArIUvLgmseNQWkHhXajeJb3/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=W4u+dPMy; arc=fail smtp.client-ip=40.107.95.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HVPsBFsGo+ov7cUxT2o0RtNpy+lMFLA+l3KYUmOl9KeKyIJfE07EieRTaAWgyGgNRPrXWrghyGpfQyyDviO/g5L53KRV5BvYGhxMseNJjkmIALUMIhMrNdsDJMOeij5AMuZnbI6FP8hB6+oztMlAleuEU9idywIRO0B/Bc8KV6jWx/4YF5Sw/6ruFdOf1JCjf1KH5gRX52H+173D6sdpKmvH9WZV1DWPQUQgK5xCxhRt9aLVk66uiYI0vqjGHbG+8PW6R3NShEPSUR8OQnA2gbRf8Z6sd6/Ljvhc+/mmlczOrpCP3o3FsdO8wxeHyqQJRqBorFW2GjDQdcSxRpP1Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Du7grmsjYwO1ArDsrvxSX/B6y4DtVZSvOuxLv66mc/k=;
 b=apwFPGfO6lFQ/nmvSd0Nu02hfrMRRajYGAe/6cZyREDNwuq0E+2yT/vILUl4ZcXzAm9zeb3Wo8wOj5XQxUtSgSpk1I07DpGZ24p+44ZiKas3YevM4wmrNHBWELcTb/R4KdBG+7YZZXsKHKtcwONXkPerV78gCZR3QVbztPqjWTZBepYJjUK/dTgmO5chjOrjNj5X8kEhSQ2yf7ZyIK6X3ywbliGnvam1T+cmEC3tUhzz7AaM+kxuaTJFQECRPT/cl6orKbM7UTDpWpeu/ZDv5LqByq7laGT6SVcnfMcbUwjuVoXisyAA62T3/gwcur88+Vm8ncSx4l3eDI/zVbj1dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Du7grmsjYwO1ArDsrvxSX/B6y4DtVZSvOuxLv66mc/k=;
 b=W4u+dPMyWYqUHXrXEJQ43wucUltBIH0inHFChWIDJ8rZsJ+T/9f1aMYxo6oZTvWNO4S2MYQg2bUCdOpe5uVbHHhoq1hVvRTnC+bAaTfbcZ39xn9keTLLmSSX8nMDaWwzcihzmseS5sCznAwuDiYdfXQWTZYh/Wojk+LFBtviKuQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6317.namprd12.prod.outlook.com (2603:10b6:208:3c2::12)
 by IA1PR12MB6041.namprd12.prod.outlook.com (2603:10b6:208:3d7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Thu, 17 Oct
 2024 05:24:53 +0000
Received: from MN0PR12MB6317.namprd12.prod.outlook.com
 ([fe80::6946:6aa5:d057:ff4]) by MN0PR12MB6317.namprd12.prod.outlook.com
 ([fe80::6946:6aa5:d057:ff4%7]) with mapi id 15.20.8069.018; Thu, 17 Oct 2024
 05:24:53 +0000
Message-ID: <777c2e42-d669-18de-af1f-675df0ca701f@amd.com>
Date: Thu, 17 Oct 2024 10:54:46 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v3 1/8] x86/sev: Prepare for using the RMPREAD instruction
 to access the RMP
To: Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
References: <cover.1727709735.git.thomas.lendacky@amd.com>
 <4d62cc503d1e3278c3830f24462e3956233760ac.1727709735.git.thomas.lendacky@amd.com>
 <85583be0-5e8a-82ce-a134-95fe9d85a2a7@amd.com>
 <9fb4543c-c876-3f82-f1a9-306e4f35d8dc@amd.com>
From: "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <9fb4543c-c876-3f82-f1a9-306e4f35d8dc@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0026.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::17) To MN0PR12MB6317.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6317:EE_|IA1PR12MB6041:EE_
X-MS-Office365-Filtering-Correlation-Id: 96ca5251-8397-4303-6657-08dcee6c079e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WEZzak9GODVGZU5aU1pvelpISnZyNkVDRDl6WHlzL1FPNGkwcGtZeEtuMW5D?=
 =?utf-8?B?WmtpM2hLRkdsOTR0ZS9vTVFMK0tjTXhXcDNnMHNhMHFFODJrV0JCVVVvQXZi?=
 =?utf-8?B?ekVkSDFtMy9Sa05JdUdwSjlqaU5lcDFTbGxOZDJkcCsyS0V3NmVjeGplWlhB?=
 =?utf-8?B?K0V3Nnl1b0ZBMmRmcU9PUm1xMTNqbzF3djZEVFM2cFFXc2kxemQ4ZzNPQ3NX?=
 =?utf-8?B?VzlZLzVVdEhPVVZtQWNOUmQwOUtzWmlQTVJWY1Ard3VIWkJFTmNKeHJHT2l0?=
 =?utf-8?B?NHlaaEJ0SzUrUjIrNFFOMmlvM2gvN0dZcGVLTmdWbjVMU1I0YWtiWnlMUk5L?=
 =?utf-8?B?b1puSWoxN0lMU21VRVRkdE42WmVoRFh0ekswdXlmWkNNQmtNNVY5enMvU2ZN?=
 =?utf-8?B?NmNia0dESFBHQkkvT3FTSDMvOExwSXhMZ2o4blloaTVFZ3FnMlhFUFBOaDdo?=
 =?utf-8?B?RkJmN1BGRjBIVnA0b05NRjBES0RCeW93RlNFc2JGVnF1aEIwckZsR1ZaL2RC?=
 =?utf-8?B?enFiMjFhRzc2VGRCOHNQenhlWEx6cEhmaEhnTnA4cTlKdG0wTTlpTjFyUjlK?=
 =?utf-8?B?RGpTdkp2MjFTUDUrQkliWkZHMFhvVXJ4a2tIdkN5RnpOUklyM0VEUWsvRzY5?=
 =?utf-8?B?SXlwMFZ4TG1ncnd3ZE1sVFZGamdNb2Y1eUVqb1pUcExqYnVTa2ROaHRZUlY0?=
 =?utf-8?B?cWhaUkxuRlMwYUp4NEVWRHJZb1R5cW1IcThTQWZyYytoSnFMcnkvQ3VkUndk?=
 =?utf-8?B?VENmUXlvZXNTU1dPN0lhdnJEZHZkMDUyV2QvSlZKMktJSGt5blg1T1pOTEVp?=
 =?utf-8?B?Z0YxekJsWkZ3b2ovUFlTVmVkSFhoLzlWdDNYSGZzeS9MM3gyOElQYXhaS0NH?=
 =?utf-8?B?a09sT2xPL3p4a3JxQzEzYjNZSVd2RnVNcGhKL0RNQnNkMWwrcDV0aE5zblhY?=
 =?utf-8?B?ZVpkbzNQSXNEclNPc0VuTUVqam9PYlBEQTlxYTZvZ1IxTWQxaXhyR0tVSzhk?=
 =?utf-8?B?anlkMjliUlFuNVZGdHNmQ0lBRUR0dENEWmM1NlV0MHBGOHlBQjJGeUZVSGhk?=
 =?utf-8?B?cUNFL2t1YStkclgxWE5oMlA5T1EvZC83MTcvakhqS1k1YjlVSFVJMGhWWXF3?=
 =?utf-8?B?N3VLL3hrYlhwVDJEOGFtR001OXp0YklwVUw5RkNXZDF5TUhlUjBENUVCY0dh?=
 =?utf-8?B?bzZmeU14ZCtJdVBJaC9wdU84cjM1UWxVdUNoVS9zTDZ3VXhQZUs1SElYMExW?=
 =?utf-8?B?RWIxbDdqelQrWkpkNUttTm50VmpnWUZ2eW90NnBwZFI0ZFZUbnVzYnVGWUtQ?=
 =?utf-8?B?VkRpYS9VaFM3WXN4c014blc3a24vbzgwRkFVN01TMVVubnBxdFpMYmtxWUZZ?=
 =?utf-8?B?cndmTjBXby9NdXR4NEpUL3pWZ2dXaEhZWjc3WlplZ1MzNXVSbkRGWHcxL0NP?=
 =?utf-8?B?bGF2aTVuSllnUVpxK1lwU3pROVlTVUltc1BIVkZpUVEvNzdLYjFFQURHczlo?=
 =?utf-8?B?cUowUkU4SkdnQTBKN0dydVNwQmI5d3pJQmRVTXFOOWF3WWx0YlFoNHpQUjlZ?=
 =?utf-8?B?akQvV3lXc2dGdGxqNGtEOHFjTXdFb0pPZUFZUWNOY01HUSttd3BHTHlIektj?=
 =?utf-8?B?MEx0L3orR2ZJR0prb2sxa2lhdVpsc1hFNEZkVmlhcGV2Szhxbjg5dnZXWm1x?=
 =?utf-8?B?NVIxeFhkOTRnSDgvOFNjSlIzblR6ekdKZ21pQTh3ZUJCTkJlMmpoa1VMOXhV?=
 =?utf-8?Q?Sdj65jJSIGTkqcPojZAcnT+XxUSIyAeBc3+VlPk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6317.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MThyZjhISjdFMGJyQ1NOcmtWNkdqWmRlRkUyWUo4YjZjVFhwMGhodzVyMWZv?=
 =?utf-8?B?aldsYjFTRXBka0dkbWZBckxEWHFRbTl0ZHlUTVBMTmlVc0x6ZFAwL3lpM3li?=
 =?utf-8?B?Tks3cHFDcDJCYWMrNEFyN3p4R2o2cnBkNUxkaWQ1TlIrREZiaEZiTGt5eEZ3?=
 =?utf-8?B?U2xMalJMMEF1UVYrdHltUzBFV0VUcmI3MG44TUFWRVdyNitLZnp5SkN1UVky?=
 =?utf-8?B?RWlkTWd4MHhMdU1RcE9wK1M2dk13TTYyNkxFY0hERTVpOUxXTnhFSENDZVRP?=
 =?utf-8?B?UHpvOTZicFZST1N1YWd1c3RkWWhLYlZjSWxqL2tQU3dWVjhYTjlxVDl3WnYz?=
 =?utf-8?B?d3ZZWU1Tc1oyZ0wvVjZlT0RtSGVtYTRQT1dXK0hlemFRVXpJcU9hMUhlV2la?=
 =?utf-8?B?K0k0SjlXbEhpZkc3a2p0czVmRk5iM3h3QTdIVjZBbnEvVlg1VWVBOHArQmZO?=
 =?utf-8?B?dW04RXplMkZtLzdwNDNBQzNIYWJJbmlIa1MrdUVyZVljbVN3OHJYY3U0MTlN?=
 =?utf-8?B?Q2hhUmg1SVZNV1g1UHcxTHJ5cXZOTXNTc3dReUoyZVB0cVc5c3hSWnZxWmdo?=
 =?utf-8?B?YzBXUDA1bEtMODJGSzdpUmVCWU1SM3IxeExJWTErNk9jblV5eWpDUUtMN1gv?=
 =?utf-8?B?UzhPYXFza0h2TmRodkduK0YrbmhLS0VJTFF4dzJVK3NCOXhTeXdLSWhTcndL?=
 =?utf-8?B?ZTdsc2VFSDJIUktLNTNIeHFWMS9NKzUyem0rK0VKNUMxNzVwMjNKc3Rudzhl?=
 =?utf-8?B?ZVA1ejdVWUFuQksxallwc3ozYmZ1TWpXd1FqTHh2QnAzZm1KMzB6S0laVkdm?=
 =?utf-8?B?ak9rZG9DeFl6MFppWWpJNlorcW81M1U2SHBDNS8xQ3VDM24ySDk3b1NSNmFG?=
 =?utf-8?B?VFBzc0FRdkJ2YVR3a1dZbXF0bElYNkhQN2hWcWphbkkvSmdlanhPZ1QzWmJO?=
 =?utf-8?B?OVZyYmNoTFlmcHozTzQvbHBsYnFZcUwwQUJwTHZuSGxIN3QzZGhDSUhqYjRD?=
 =?utf-8?B?MWppeUFteVBSZDB1dHV4dzhZeGtoQk1PakFIeEEwY1cvYjRDV3Nna1VGR1VC?=
 =?utf-8?B?OUJMYXdhVE5DOFpuRVFBdzlsMmtNS1BZV1NCNUVDYy8zZEVHL3ZQclRpZ2ZG?=
 =?utf-8?B?Y1dqUGlrWkMvLzhveWhqTXEyd21KSG5EQWhpRmhDUERwVGVJUU9CcU5haGpB?=
 =?utf-8?B?YUNXSUxCQ1lVdWJnZURqY2dmSWVsT2lqOHhCVTBSMzIwYlQ4cnZ6WUNNQmZh?=
 =?utf-8?B?UEVjdlJSZGs2dXVTVGVPcGhINm5nd0NGTVkvQ0NvL2tKc1dkd0dXdHVKdThK?=
 =?utf-8?B?OEVOOWp1SkNBc29xQy9lRnk3c0l5bXNKYnNFZzlaZlEwdDU5QmV0UnE0MEpE?=
 =?utf-8?B?MWtLcW9NVndldkVKMW5FdnJiY3FQSWVEOUJrSHduN2VCQWVadkNSVGxqU1lm?=
 =?utf-8?B?MzdzTWs5Q1VLQlpzeTZIbFZ5dWJjdDArTnhBRjBNcFNLeUp1cm44SXBYM0x0?=
 =?utf-8?B?bk55cFF2WVF1ZitMbVJETUJoZUlXZUEvRG5jMUlveElxSzhaNWpmUWlCTW5N?=
 =?utf-8?B?eEIvS05Idys2VEZRd2Jwdjc0TCtTWElMdyt5cVdEUjV3K2YvNDMxNy9CdXEy?=
 =?utf-8?B?UXlzUkZLQmNzZCtLN1BtSkFlTlNxREZBakViNGFZdHM1cjRPbStCNmlnUW8z?=
 =?utf-8?B?TUlwVjVZU09nNHBMU0s3Z1h1Y3lPT3lwWDBqaEVvRmNMZng3eTdjNXVLa3ZM?=
 =?utf-8?B?aUdWT08rWEk4ekYyV055KzVxQUJqZDBtYldLTzBnVVVKVUxiQklTcENBQXd0?=
 =?utf-8?B?YzBpK0dMTFZlNUtkbHdvRUJHMTlYRm5GUStiMmtoUmV5NStiVTZxS0twY2l6?=
 =?utf-8?B?d2JzMnpFVFVDTUZISjl3eERQK0lEYk5kYk41OGVGZWNZTlVLMVhxYUMwN1Vi?=
 =?utf-8?B?alhWQkttcHNpcXJYZ1RrS2JCN2IyLzcwUWlWSE9vVjFVMnJPMkgzelFkQmFN?=
 =?utf-8?B?cTZaMXpmSDJKa0F2dEN4RDN1TmFQL0U5L0ZwaGtMZENFeENXOWJiNEpUOXZ6?=
 =?utf-8?B?RHNwajMxenY2YzY4RmM1emEycndwRzVXWmFsRGxWaEc4cmVIenVFOWRrZ0RL?=
 =?utf-8?Q?z1uITkgt5YhwURV3lpyv2fSj0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96ca5251-8397-4303-6657-08dcee6c079e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6317.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 05:24:53.4263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x9+woYABuye1GCID7hqWInect33tEAUQOqZblNdToSO7wuI6sxUKV5lcHp6H35deCT3RC2odgkVyKL/taDVf1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6041



On 10/16/2024 8:13 PM, Tom Lendacky wrote:
> On 10/16/24 03:52, Nikunj A. Dadhania wrote:
>> On 9/30/2024 8:52 PM, Tom Lendacky wrote:
>>> The RMPREAD instruction returns an architecture defined format of an
>>> RMP entry. This is the preferred method for examining RMP entries.
>>>
 
>>> +static int __snp_lookup_rmpentry(u64 pfn, struct rmpentry *entry, int *level)
>>> +{
>>> +	struct rmpentry large_entry;
>>> +	int ret;
>>> +
>>> +	if (!cc_platform_has(CC_ATTR_HOST_SEV_SNP))
>>> +		return -ENODEV;
>>
>> Can we rely on rmp_table check in __get_rmpentry() and remove the above check ?
>> If rmp_table is NULL, CC_ATTR_HOST_SEV_SNP is always cleared.
> 
> I'm trying to not change the logic and just add the new struct usage.
> Once RMPREAD is used there is no checking of the table address and if
> SNP is not enabled in the SYSCFG MSR the instruction will #UD.

Sure, makes sense.
 
> The table address check is just to ensure we don't accidentally call
> this function without checking CC_ATTR_HOST_SEV_SNP in the future to
> avoid a possible crash. If anything, I can remove the table address
> check that I added here, but I would like to keep it just to be safe.

Regards
Nikunj


