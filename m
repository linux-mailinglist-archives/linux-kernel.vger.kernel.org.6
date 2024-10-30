Return-Path: <linux-kernel+bounces-388410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCEB9B5F43
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 10:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B52401F2224A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 09:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DEF1E32BB;
	Wed, 30 Oct 2024 09:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ICnpjiTf"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF221E2837
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 09:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730281940; cv=fail; b=s9r1onAkTwHZGyLwveexRdXTbvjodvMSAi6cpen3NYi7y0swa/4xGX6K1qzDFwYnCuFq3xTjbmIovwlsIhg+iM6ECmcDnpVI24KzRq9a+WdpivaDYwB6BLkbycS/uJ1ck4ha9hpM72wsmO/wNsmn4sM5M57Au54MOwggEIQL2XI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730281940; c=relaxed/simple;
	bh=nX8UBUvDJUQVPE8ZUbt8evu7YjtLmOeSy35sYGEW52I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oW1bVc9XlLnkHwAfC4gjfVKqtWFOxJmN2YUIRwP7Ynuzipv9qUkzIAUGbxu0XMF7P6HZBmP+vU6JR4eW1+SuGe/1lJ5lTTlI3uyy+hrKOf+q+muQio8LnZb2xE0b/M5s+QBMSCrUR3CogJSZqAFnfohKCxj3mEdvc8eHsAWxn7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ICnpjiTf; arc=fail smtp.client-ip=40.107.244.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fggkOPrxNRPgadk3VfVrZW9AVKHYJxUWSOUtVjHFbxnhD50vQHwabyJLfMt6SvQ/5R0RHmjenc+Fe0ugJw++68kuhzG+Z+VwF3ABPeMjOwttSoIq7gAL17ughZAJdHEMxqp1IzeamgAyskFDLSAi1ZJOiTZKeT2Qii/FQ09Qou/AqP8UJtGzoqe5uU/sOVbFI3Y36RbRiulOsI4tkwbuQKfFPbKg0QiaYF8iokLjSuvFHFWVZW4ueDl2u6ZX4CP81QnLDdiVS+bfFio3ZX8Jpb2m5PaswC2GqwcZaSr/a4iQhCr+QFeWksQU/CEbtjnh+Uv8SXyFrs1e2c7BXhsqOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ky8TaPSmgC9A8rhVKi5R9axXIIaymXMhGs/RrVYj1A=;
 b=acnl4IjyKEFECpEqK1NgJYCYIChVy1F+0qm4XZpdg1SW3eofILImrHoQH+J+Gs1x+2sD+n+39PbB7MYO5tpKag0nDPdyb6mOCG2CIdfYM6qQh4tYUl0PbWMLo7trzByU9ZZFXJmsuTsfW5EDCQUsIZfq+mSKv6pWIBalsTF6com/YYWG0E6Ev3axdsZgRjabsVQhaKnh7i0StiPyzrkAauDorTRuLNgViOEidZ3c0c/fc73t9Zynbjzsfge2eiLNpV1coTb7OXhPjUQOb18bLt8YS5L+9CLa3bhANkNSXKVfE7eekAoXjxYslL0XjxGrKf5EusSTX8fCgIgbfFP/Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ky8TaPSmgC9A8rhVKi5R9axXIIaymXMhGs/RrVYj1A=;
 b=ICnpjiTfhp1HnIkztg+QDIM1Xs0wCg2ag7J9MnxG+Ds9dITcLNFmiTTFphYom7Kjuk5Lj35cKO4TI1tCFPqbB5Qov/btvh1mu7ZKhXH/5V/VF86Uo2QCefbhSnG9PyDfsZISWA5Ls3q0SDEXBvOeCYrhhKw9CbCQCdMt+BoKQXo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by DS0PR12MB7511.namprd12.prod.outlook.com (2603:10b6:8:139::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 09:52:11 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%4]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 09:52:11 +0000
Message-ID: <d5187836-3c1e-4bdb-90a2-779d3c1f086d@amd.com>
Date: Wed, 30 Oct 2024 15:22:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/2] perf: Relax privilege restriction on AMD IBS
To: Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>, Mark Rutland
 <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Stephane Eranian <eranian@google.com>,
 Sandipan Das <sandipan.das@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20241028200153.1466731-1-namhyung@kernel.org>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20241028200153.1466731-1-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PNYP287CA0040.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:23e::17) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|DS0PR12MB7511:EE_
X-MS-Office365-Filtering-Correlation-Id: f597aad6-c186-456e-97ad-08dcf8c88612
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L2RtZ0tidzBJZmp0dG02Ym8xa3pWSGdsWFptRGJEeHI4K0Zra0lpd0ppZ2RS?=
 =?utf-8?B?UHlkTFRhWndUTjdjbkRmd2oraGVPKzhoVjF3RllJcUZJekVnSXQ0WnR2UW9y?=
 =?utf-8?B?NTNXWHJrSURtdk0xWis0TFRUNGxrVGh4bFluK2hFc1VvZW9SSFp1Q1N1cGZ1?=
 =?utf-8?B?OGZvb0FQbS9aSGZXRzIxYWU4d0dZMm55djg5UHFjVjNlWDJyWnFDcFp0ODNI?=
 =?utf-8?B?eFJlMVZGbnpqWU1XQmdnbnloM2dUcG1yTHFnc1ZxTDJiM2I3QWVZaGZHVkt3?=
 =?utf-8?B?ZCt6dWRpNzlvWjF0UlNiY29adzNHd3NzOXhSSzNQSUNWY1lQejFzZVJDbHc5?=
 =?utf-8?B?M2N0N2xHclJyNnVuYkU1T0pGY0IxT2tFY0NJenNVcGFGMDNpbU5Qd09HU2VH?=
 =?utf-8?B?bkc3L3BwZGIrVnlldElPY29nMEVPV2FSSlNqcWV1UE1reFZ2UCtCL0xvQXVK?=
 =?utf-8?B?OEZoUCt3OGNJTW51WnRHTU9kZVlXSXJTSjBTdFloS2tLMG12emU2WjN4c2Fs?=
 =?utf-8?B?SUNCRVFDWnJRMDZnbnRUclRQeDRBempXVmY4ODFxZ3FYN1lGTjFtVi9zNzJW?=
 =?utf-8?B?NjZ4MnJ3SXkyMzJsVi9IQUdaNkFBOUVnMHpkRXVtaUlhcGM4THA2WmxTcVRt?=
 =?utf-8?B?clllNDdtSDZydWRray8vRnk0MzY1aXlSQjNkUElwa2tpeTA4Z2VkaEdHMXhT?=
 =?utf-8?B?VEQ2OFgzcmd5emlzMm1raXkxVHUySXJzMk5RSitCaWdMSDAyQmJIWTB5MDMv?=
 =?utf-8?B?UzM5cVVoOUVOUDlqeWRwM1dNbmVVOFJQclZoem4wZXlyMzYra3g5YmNsWjBP?=
 =?utf-8?B?UTViSEFjQSs1NTRxamhidGY2ZHdBb0ZjQWY1NnhINDdHRVBKUUNObmZucWtY?=
 =?utf-8?B?Y3h5VS9SdURiVDJQS21YTFNLNFhUVy9yTFBtblN2R0RWbml4Wm5mQi9TbkUw?=
 =?utf-8?B?K2M2empVbmVHcnYxdm1QcXhoYktqanlnYzUwZkdYSFhRZHE3UzJ4SGtJK2FX?=
 =?utf-8?B?L2xVUW5TenYvR3NYQUMxZExlWHEzcHg3dGJqeW84emFSbjhhem9RVWF2N0ho?=
 =?utf-8?B?R0U4RkxSYnZEWVVPazZvcCtCYXdoL2FXNTI1WHEyd0dsd0VxVE4rcTdJQkYr?=
 =?utf-8?B?Z2F5S1VCTEVNeDBkbm5FZGpzWFJLM0Y0Y25jY2YrYWJVUUVpQmg5TGJ1bGpp?=
 =?utf-8?B?aHJud2wzTkNKYVZVMWxMdGFiMCtqV3BLNUtFR2xESWdsOVlwQzRjVVlaRUhs?=
 =?utf-8?B?WEVVVzlPUkhEQ3I4eG5yelhtTUlUTEpKeVJmUkhDZDNFQkR3SkdzRnlwRWlJ?=
 =?utf-8?B?aHBtbUg4LzlVV0VsT1AxVzR0RnFNTUVSc2xhZGpKRTh0SXFjRGRiQXVwQzUw?=
 =?utf-8?B?aERheGhxVjU3SFE1UkVoVHlwN1FlT0NaVnVsL1JEWXpUZGRHOTNkUmxPZFp1?=
 =?utf-8?B?UjJMa01Ta2FaUEVwdExXZjhhNWMrYWhUeXpYK1dEQXErUzN6VzRJSlNMY3kz?=
 =?utf-8?B?UUYrNDB6SW5zMzB3eTQrQnVoTWR6KzhCK1FONWNEdkRaSzhhS3A3WjAwL0c1?=
 =?utf-8?B?VHlxWjBhV29qRExZeWdySVRQUTFFZjhOKzVSQjVFTE53UTBMM0RTUlkzM2pS?=
 =?utf-8?B?ZDJkaVhMb3liRmlxWHJubEFyTHBZSVQxa2lvbFlWSkNkTGNIYmk5ckN0RVVZ?=
 =?utf-8?B?S0xNaExyTVpyQy82Wm1YL3lTOTk0UTZ6RFpHbnRIVFMxQklaOGErZUtVQ0ZK?=
 =?utf-8?Q?khkJOFPKnfQ5hysMKE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cUhZQVBpL1NTRWJzOHMzOFRuakJVVE00SG9NRUUyeUloOEtPajZFVHJxYmkv?=
 =?utf-8?B?dDMxSFVjZHY4UGV3a2VjZ0tZSDBQSFhHR0c2d2dFNi82Mko2VjVESXAwRm9t?=
 =?utf-8?B?ZFF1ejh4V2NST0lJVXllTmgxQnNpalNlZzN3TGgxVVF4VkhKeUdFZDhBNFlU?=
 =?utf-8?B?TngxbGI2dnplYnZJRlNvNXFGalVZUDBqNmlldnV5N0hocy9Ed2Ywemp2ZUZX?=
 =?utf-8?B?NkVmR3gxK01XaXNKYlk1ZGFaTDhPKzZjc3cvMGxEQTBIMzlDL1VCdVRRR042?=
 =?utf-8?B?d2dWYnFDa2hOYjdkOFoxRUhyUmNzM0hyVGw1aXNrbEtHaVVLcFQxdHVURG5r?=
 =?utf-8?B?cHhCQm1RYjVtQityTzFqbW5SdzU5VkcrL2N5OWwzT3lnTHNvaFpVYlRqeHBJ?=
 =?utf-8?B?YWFMY0Z1cXhNYWEzdUgvZ1JIcGI4MnNHSGFBVlpEajlEQTZycTNTOHVVQzF5?=
 =?utf-8?B?YkpiVXlKTFV1T1BQU3JjSUNjQlBpcjJEa2huS3E5T1FHcE1BS09FczZIeDJ4?=
 =?utf-8?B?NmJybUQ5RzdhYXB3LzBxT2hRaFBsSVhrRkJSTEhvMG9QcUZsbkx4ODdwTmRa?=
 =?utf-8?B?TzZLU3VybmJpNmxVbHU5WEtYS2RGSmluTlNPblRIR01TeDcwOU1tQ1d1L2xq?=
 =?utf-8?B?em5DTjJLTjc0RVRqQjk4Z1hKbXZyWno0VHBGYTZ3RE5RUlV2eVZNOExNOUJH?=
 =?utf-8?B?Q09TY1ZUckVXejY3WDVvRVp3dmoyOEhRcytCckVrYUY2TjJ5UnhzMmx4eTZF?=
 =?utf-8?B?WGVKOXJ6cmxuM1h3c2RqQ1N2WWhkNFJvR3BOZDUyb3R4ek5YbGc0QkV3dmxp?=
 =?utf-8?B?QmJJdjlOTFRuTGdsQkV4NDl0bWZybm1ObzhYcmNWc3hGOUp6a1ZEV2xmZ1Q1?=
 =?utf-8?B?Z3ZxOGxHdTFFVnZHVzJZdFlhejI4ZE5oMDdQL1VDdlJpWEFpNFpzY1RpYlJP?=
 =?utf-8?B?THBOUTQrRmszTTJ4NkszeHVtMGxrZFAxTnkveXZtZURKeVoyZkhsVy8rVjIr?=
 =?utf-8?B?UE1UM2xEY2tKZlIrOStnbHBFVU5IcjViSHd6QWF6Ui9UMEJhV0Z6RG9nYVAy?=
 =?utf-8?B?dm1JZlp3Smh0QlQxdk1oNVZRMitBNnZJZFNPMEhzUk8vOGhzenI1Rlhjdm1G?=
 =?utf-8?B?YnNOOVFLSWkwaWE0d3UyaEU5bHJDQ1NHS3hhRG9iR1VMMjZSc0lNeWcvRnpZ?=
 =?utf-8?B?Q3Q0MEdYaTkxZzA1UjBDUlhnNThSdE1vQzVjR0xhRzRJRFFzNFkzbHBsR1dI?=
 =?utf-8?B?czZ2Ui9pTDdPS1dVbTZOV2NLNlB0MkMzS28ybEdJSFEvU09ob3k1bUN0SC9q?=
 =?utf-8?B?Q1RyaE51UmZqOEVmc1lPYjM4KzljSHVuUnNKNUtGUUJ5Y3VjU2FnMUlXbkts?=
 =?utf-8?B?dUxNMlFTUzVISDF0dUg2UUhIbldkVTZuWWtkcEQ2aDhRbEhOVDVMcklqM1NX?=
 =?utf-8?B?VEdrbHp2RnYvVjVNaUV5ajRDczV2N3BXUDFkR0d5VjA1RVJPTEFXT2dEdDdi?=
 =?utf-8?B?SEdScVdaV3BQd1lyN0hJTFJjemROdjRsZWxtSmhVRmRiRkh4VG43aVBjUUVr?=
 =?utf-8?B?UXp4MllxNlZ4NXdmNTdkL2V6Y21vaUk1SlNBQ1ltQ3VWUzB4c0thUmJMcDli?=
 =?utf-8?B?cFd4c2Z1NllHYS9MU0RMbEhHUkprY0ZZbnU3SFJnQ29wdnNKNUNZUU1pUUUx?=
 =?utf-8?B?OVZtUi91dmM1Zmx4TVFSMkZqR2dMUVpqZ2YzeFpkTmJnQXJKckRIVnBTS2Zr?=
 =?utf-8?B?QVh3UUlVL0VTV0I4N0x3Q2U0RGNIUW85Zm5Gd1VPRE1CdXVvU0NSMUxYYVo4?=
 =?utf-8?B?NDI4Vm50VzlZMy93V3NJbk1XMExZeDl4N0FidndiMFdwdTdIbEpKNmxWOW41?=
 =?utf-8?B?dHFjeFFCUGg4dStJZC9RRE80ejRyNEZmU3ZnNi9scXNNTGV2YUd1eEdhcGxa?=
 =?utf-8?B?d0pJaGtELzlIMUh0TkwyZEhHd0hPMWJxcTdGZ25xeC81THpUL1FhREFGTGdl?=
 =?utf-8?B?ZG91NkRsSWlzZWVqZUFOMk8yTVZjMU0zZzVKUzZZNlNPUjloY0Y3Y1pwazk0?=
 =?utf-8?B?ZFZRdDdSUXlJcXVZTW5DeW1RdStvL255L0FaK1dtSTJxaGJnT1Z3aVdWR1VF?=
 =?utf-8?Q?on50+JDQWB3wbmfHAPw1aYAvZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f597aad6-c186-456e-97ad-08dcf8c88612
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 09:52:11.0721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lL0OaTaNtedWmlgNzjSUhUBOiR6s+ZlGM1CJTzP59U1bv04F/S2+pUmG0j0uQFLaVroyXNlVErpBEWOoavqk5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7511

On 29-Oct-24 1:31 AM, Namhyung Kim wrote:
> Hello,
> 
> This is v5 to allow AMD IBS to regular users on the default settings
> where kernel-level profiling is disabled (perf_event_paranoid=2).
> Currently AMD IBS doesn't allow any kind of exclusion in the event
> attribute.  But users needs to set attr.exclude_kernel to open an
> event on such an environment.

For the series:

Reviewed-and-tested-by: Ravi Bangoria <ravi.bangoria@amd.com>

