Return-Path: <linux-kernel+bounces-191647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9A88D11DE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 04:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1D941C21ACB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 02:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367836F068;
	Tue, 28 May 2024 02:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TYsSUDEQ"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2051.outbound.protection.outlook.com [40.107.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F37C69D3C;
	Tue, 28 May 2024 02:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716862760; cv=fail; b=GiQK97c15r7/LKCu8210QIsRDkagr888CsiQdtMrZ7DlW5owwQhn3srRaGWHuIe10GJrRdbe4RMB5WJesPno9prwTBLzoaO8sGn0ex37zMhQgqM+/w8i7tfkdXmC+0F3Zf4zb2xFbyNZaJ0lttBGT/xb7E1S94ifc+SPkHMyN5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716862760; c=relaxed/simple;
	bh=EkXQbWAIqisn+oTvKNi1t8LqbQhJiMxm//GRumGx4Gs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ionDWyfKM8e0HP1sQtI9Uyar/hua9dIaBV4w6ZioyYQFaL7hNlhstHBOPKv3hIWzkxT5hz4R7qfdmJkZ7oCPGKsf+n6MtiF0ydbSTnaIXoRwdLnWlIgXRAT4Vb84ZqEAvYN+p40EYfI8Gmq2wZfKxisCrUoylaLH24srmpACSf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TYsSUDEQ; arc=fail smtp.client-ip=40.107.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QN8wEDYylAHVDyxlhH06OvA7tC97laWmfgArKISr+tBgzCDhk1lnsxSXoMTXB+uCH2xz/+8ICCY4KaELNSiBJdj+d3DpnHnfYA9cb6g+KCpv8a2mnUeU+NlDQsPPcjCJOO0pz3UzuucMgfbYCFFo/BsLCfbrDL7xMu99atbu5si6Pr1tIGD3x4eklqplRKQWIEQ9LRii1MpD0EC5FEG1s2T7QH4l99+Jnb1UujSeAdVc7aW3MCea8D5ydUcBJrm6ttf0zX2eKr//xlRFdS9vVrAN7Qn0wifnXMfMBTm672c2jAobU0+8HOhU/nDXIeXQHMlyvZ9dOhm460/C9oeAmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0raTXu3EqnyVYsE42cTw/p5dMZTpTP0gz5ZupKWSEpI=;
 b=XqI1nxer0LILqN1GWoN4y/h1R5zywIJCEPJLpTDG/ygnBS/yYW5efi0W78bCH3OLf2bG34EFWzVLoPHKOeJM32e/SrWbtgITcAySw7nbvLHOsELcWfILkXv+Hf6sRKm2zqW3wzYmHdacNHmPLOvOOUC3DGGwHA+ZyYjpeId0cK5Jf/KQDbU+R+rMQfRETyEu/2PdSa81kEyePELpJi2C+8en+1Nqj29/GBbRA2LZf/ZWLpcNyTnkonKr1hwmk/g3+UcY1W0rOLUxk1OZDJTm3pLMUHmI+acgMyxu/L/+C6WxGwF+XrSX4jJX4Y/LDznNmbnF1U1a1uEBoUyuxNFhGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0raTXu3EqnyVYsE42cTw/p5dMZTpTP0gz5ZupKWSEpI=;
 b=TYsSUDEQklIQp15LvFymXVzhXKgZ7FqvBBDJoEBMeq8IwlgOML0tmQm6vFX4IaCHS0uFIiVnQsmrHKF/ByPyMYdJORpbuHo4VoBQiwsO2pVpEB+uysfXGWB/vLUezieNmZE3ykLNuhkPJMi3AG2ayuPj9k+PU94U9QNJA1t0R5I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS0PR12MB9323.namprd12.prod.outlook.com (2603:10b6:8:1b3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 28 May
 2024 02:19:12 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 02:19:12 +0000
Message-ID: <6f4bc109-00d0-47b0-a581-b96a6152545c@amd.com>
Date: Mon, 27 May 2024 21:19:10 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] platform/x86: asus-wmi: add apu_mem setting
To: "Luke D. Jones" <luke@ljones.dev>, hdegoede@redhat.com
Cc: ilpo.jarvinen@linux.intel.com, corentin.chary@gmail.com,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240528013626.14066-1-luke@ljones.dev>
 <20240528013626.14066-9-luke@ljones.dev>
Content-Language: en-US
From: "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20240528013626.14066-9-luke@ljones.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:806:20::14) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS0PR12MB9323:EE_
X-MS-Office365-Filtering-Correlation-Id: a47ff0da-b50b-4dea-3dba-08dc7ebc908e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ay9BNEZscUFraW8rby9QUUJPT2RsRlZDeUlZZmdLNkVtQ1ZxcU81TFZyTlFP?=
 =?utf-8?B?dmZVckFzYkY0em9wdm94WC9nRUF5UUlIa1NhMFZYUlgzWlg3ZTJoWWI1QmFY?=
 =?utf-8?B?S0ExbDlMeUVUTkVpbkkwK0VlN2w2dSs3SmlhTmdoR2cwNVFZL1FNalNaRHdv?=
 =?utf-8?B?OVU3YkM0TXMxZ0VCSndGRWJObTQ3dVd5UTAvWElxbXkybmdRdFlQb3B1RjhZ?=
 =?utf-8?B?M2FuY1FqYUNLSlBoQ2p5TlRhZ1dEdVJUUEVKV1dCVGE3SDZKU01uWmZyZlFY?=
 =?utf-8?B?R0ZIYkp2UDY3WGF6T0Q4SnVnNXNWYUdjRXZRcmZqdFQyQ0JvU2MxQXBBNDJE?=
 =?utf-8?B?czNSSzVCeXE0MWhRZDkxN0hGajVFaEZEZXlBVGlBWnFNc3VFL0cxVjFzeGlw?=
 =?utf-8?B?SzBETkxpdktZbXExNDluQU9nQ2FITmJwWFJyajBoemJWRDF0eS9EV1RUU1hj?=
 =?utf-8?B?b1QwUlFkaTQvSExUQlFjTERvR3dmZ29sakFUSTcwYTQwRGh2M09LVWxzQUVI?=
 =?utf-8?B?U3Nrd3RzZmQvWGxZcjB6ODkvdDBza1dkUUYvU0JidHAzT2c0SkRnR1gzRzdN?=
 =?utf-8?B?N2ZzYnAwZ0NOTktqQTIwSGh3clNTM2RJOXM1Y0lTaGpHelNnamMvN3Bodnln?=
 =?utf-8?B?bzd0d0Jkd094eXh2N0t5L1Z6UW9CTGtZaWR0b1dKRElUUGFFZGxacDVwY1dv?=
 =?utf-8?B?c3JGR0FiVjJ4QjVpWjRKS3JqZWpYOTN1U05Rdmp2NTB6QnUrWW1OZFdrd3VK?=
 =?utf-8?B?QTRYQ2pwWlJPdnE1T2JSSmtZeTN1NllZOExQWGxoZllsT2FFTmJXZEV2bkZq?=
 =?utf-8?B?dnpWd3JBZ1QzRndGUFF6eVJ2ZTgyQndFVCtPOFlTL0dWdUw0V0kzS1UzZjFt?=
 =?utf-8?B?OU1VUURha2pNNWh0UUsxbGRMcW1OL1BKcUh2UlIra1FkbmJnS1BUdFpHSlpj?=
 =?utf-8?B?R21xVFExRXozQXVVRFFhZGVYK2pjZXk2R1JucnBRUEtVdE9KVXdrdWRXV3NC?=
 =?utf-8?B?RDgrSEhKdkZ0aTZGVEhRaEt6d3hKamptVThjZFJuQk1MVjczQjFJdG5tWGxk?=
 =?utf-8?B?QjR0QUpRWEZpOFYvcEpxOEJ3QnpmdzRCUkVSNnpBcDQzYjFlZ0JFbXhtNjZz?=
 =?utf-8?B?V1hsTndYSlZXNjVzNHVQMUw3dS9wV2J2S2NVeWpJclhuL1ZQZmhVeUtJb2dE?=
 =?utf-8?B?RkpZbUczTTl4TzlxblJZemxFWHNFQWxYcENlWUwzVVJqN3dlNjg1ZHpHT1hK?=
 =?utf-8?B?cHdNSWlGNUF1RkNoa010cWFPVTJHTmZMS0hUSmpHWC9jNjJKOEpPRnN4VXYz?=
 =?utf-8?B?aFJPRzJuZGVzei9VVk5wbzVaL3k0WGl5b0JDWU83eW1OWElQMDkwTzk5UnMx?=
 =?utf-8?B?cERUZ0lweGl1KzA4RUIxWXdsZUt4ZlZrR2hoMjQwbk1DNWxCZVByOFczeU9r?=
 =?utf-8?B?YVlWT1NXNW5WQmNSMkhBMUlsckNPYzNwdyt1bWtVZDBFWm9MQmVDV2pJb3k5?=
 =?utf-8?B?SmFyUHNRUzlwWTQ1bnpBWElrL1pmL0hlLzdabzBtY2dLTmZ1c3MwNWNWcU9w?=
 =?utf-8?B?OTlGbDBRbjI4Q2JZOHFDcUNubGpnaW1URjdNNGorYUhkU2x2c0JYSHRWYWJD?=
 =?utf-8?B?bTZxY1hubWcrL0ppSmF1NE9BSWlYT09jdUx5Z1BjQ0hSRnkrcmxlRWUxQ2F6?=
 =?utf-8?B?T1JXdU4yYnA0U0NiM3Rrd2JZeEtOOHdjMWdzdlZoaTJ2RmxhTUF2bVVnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NVVHV3kyM0tHSE1CTU83SDFGcVVkenRmcUpiQjVNcFYvUWdnWCtycHNnWlpn?=
 =?utf-8?B?VmNhWVYrQlVxclBvcHl5Z2FYZk42SDhKZDZTZWxacWwrUGcrRFkyL0VnN2JS?=
 =?utf-8?B?RlZBRmoxd2ZwVmgwTGdSUEw0dVBTeWFQZFBDYTQ4SE1wWVFqZWd4VjVCR05T?=
 =?utf-8?B?UElMTTFoZm96OHNNbXBidDR3YUxWYm1ScXY2d0daUFBiZlZFZ1JjK0gxZE5C?=
 =?utf-8?B?cjN5Z3JGaEdMajM2amk2SHBxUjliS2RyVnNxME1PaVZyVFZRRjZRSktzUU9W?=
 =?utf-8?B?a3k5Q0VRcXdJYjg3Y3R6UkV4aE5tTUU2MjNSSTNCSG9PQ29RYVRrRjJoWDh2?=
 =?utf-8?B?eUVXcjRhVm1XQzQ0d21DZ2tlSTBUemt0clJJMHNYWC8rK3pPRVJtQk5Ua0tF?=
 =?utf-8?B?MmVhK2hHODZqdnhjYTZvYlZ3aDFVVkk0b3lJUTcrN1JyajRZY1dGVWN1dk1X?=
 =?utf-8?B?dDhEUlZ6Y1V2YlBKd3NYUDNvdldtNzNFeGZkcThVa1NYdXhQYzJRL3dkdVN5?=
 =?utf-8?B?cnZaVEdObEJWa2t5aEFMbHptSDQ3MWZoQTdkN1c0T1dzb0NLTEwrbjVhZlZR?=
 =?utf-8?B?OUp1OXNCNzl1ZUxMNExqaVkyMEZOL2RNVlE5WjM0djdyQSsya09na0NOWHM2?=
 =?utf-8?B?ZUhDaUs2YWhzWk1UMXV5SS9CczlYaEJod2NBaXVTb2s0RUlKTW9BZzNuOWxU?=
 =?utf-8?B?S2FxUW0vSFp1bzMyeXo2SUdvdkVzWHdzclg4UlpzZE5jbnU5ZHlSZDEzZ0hB?=
 =?utf-8?B?QlBYVXhLcmZGaXFHSHBaYnBEcldMbGVOdFZVYytjcGpqWGpuZGE1Z1VTSHFl?=
 =?utf-8?B?WkdPWWNhOE9ha3JrbGFlL1l1ZW9SYU5ndEN3ZjFFMGJ2YUV2SDhBVVlURjMz?=
 =?utf-8?B?UGRXMnRNMXlJM2hhVWNNZzZkTEpNc2FxdWNSR05KUENzeHRDRDJMT3RGelRw?=
 =?utf-8?B?MFUwY3FzUk50VG5qbmwrMURKRnNoaTIrWUh5NmpjQkZCNnhGOWdJbHRCUnlM?=
 =?utf-8?B?VWpoUUFNNVZkS1BNWlpJQmJpUjA1UytaWFVmcUs3S0Yxc0lUVUVGeGJMM2pO?=
 =?utf-8?B?ZFJHWmIzRE90YTJpbFVTbkFRK0NLalBJT3Zvc2UvMFQzamU4ajJHY1d1NTlZ?=
 =?utf-8?B?LzdzUTZGY2JDYkkwNjV6R3QzS25uTjZ3VmtIbXc1Q1kyUFphd2JSb1RJcWRv?=
 =?utf-8?B?WjNtVnp5MzFaZ2pKOFBtRTYwQ2Z6QnVCc2UvL1NWcEFZV2tKZ21OaERQaUUx?=
 =?utf-8?B?S3Z0VVZzRkdmbDdrbDZnQWsyTU5lUHd3MUZUb2NiZmFidDJ3aGc1MzRheXFJ?=
 =?utf-8?B?NXlNdnlVMEdnOXJiQVhHRldLMnlIZWRhZ3dmY09HR1Nlam5RcE9lRGVvN1pW?=
 =?utf-8?B?amJrSThuVnByT0NESmFYNWpPTEw1c2J0YkgvTXJET3ZRUFp3bEsxOVBQV0tY?=
 =?utf-8?B?dzNOUmpmQUdhNXRPU3VnSGdPSzRJK2tUV3M3aGJyVXdnU05nVlk1QjBwR1VN?=
 =?utf-8?B?OGk1dDFINXhPbUlkR3Y0N0ZkQy9JY0xrT0ZtNm55MGFFUDZ4SHNYY3FoaFRR?=
 =?utf-8?B?b0d1Wkw4TUFpcEZBOW82c1p3cm10UWpoRC9mTFo0Ym9STnlBeE1TVk9IdTJL?=
 =?utf-8?B?ZkUzMzlIN1lqOHNhbFF2SlhXcFROZlVhY0NLOFErc0RNZ0cyZ1MzaEl0cDNv?=
 =?utf-8?B?QzBwNGhsNS9kbE1sU2tFWm9kaXJwUVZKNEZpdUhHOTE3WVhwSTg3eE0yREpB?=
 =?utf-8?B?eE01bXN0NEQyL09oMnI5MkJJUUZzZnZzMk1FOGMrVk00U21zdzZnUm4yNUkz?=
 =?utf-8?B?YjJGb3l4UHozQVBTMzAwc0tXcUs4bmlOZWlpS3BMMjNuSVB6WDAxTFY3S2I2?=
 =?utf-8?B?WThlY01VQzVJTkRpVk5XdmxndmI4ckw4S3B2YU5hVEUxUnF6VzhWVXBjeFdS?=
 =?utf-8?B?QzFhWGRPSGlLZERGZmR6ejRMdVR0OENvdGtDenZ2WnJQd2VtZjBzai9RdDht?=
 =?utf-8?B?MEZFZEdVaU1ONFc5L244SHVwL2poUXNRUVJOSnAvSnBXZFJPWndIcVpheVVR?=
 =?utf-8?B?aEZjOEYxcHRyVEdNTTYveEkzNWZ6Q25JR09qYXpYaFFUNmxlMk51NFpvQ0E5?=
 =?utf-8?Q?fm2T6cGRPO8zLVx9Lrqad492j?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a47ff0da-b50b-4dea-3dba-08dc7ebc908e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 02:19:12.5063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OZkLUPxKOE4QHl5iohE/mMCUFpUgx1WCpaNzSHgx4d4Htlh8JMEG6Twh0MaotVmRTsqJDugVjY+I73p1EaFNbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9323



On 5/27/2024 8:36 PM, Luke D. Jones wrote:
> Exposes the APU memory setting available on a few ASUS models such as
> the ROG Ally.
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---
>   .../ABI/testing/sysfs-platform-asus-wmi       |   8 ++
>   drivers/platform/x86/asus-wmi.c               | 109 ++++++++++++++++++
>   include/linux/platform_data/x86/asus-wmi.h    |   3 +
>   3 files changed, 120 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Documentation/ABI/testing/sysfs-platform-asus-wmi
> index ac881e72e374..d221a3bc1a81 100644
> --- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
> +++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
> @@ -245,3 +245,11 @@ Description:
>   		Show the maximum performance and efficiency core countin format
>   		0x[E][P] where [E] is the efficiency core count, and [P] is
>   		the perfromance core count.
> +
> +What:		/sys/devices/platform/<platform>/apu_mem
> +Date:		Jun 2024
> +KernelVersion:	6.11
> +Contact:	"Luke Jones" <luke@ljones.dev>
> +Description:
> +		Set the maximum available system memory for the APU.
> +		  * Min=0, Max=8

What is the unit?  It seems like multiples of something?

> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index f62a36dfcd4b..4b5fbae8c563 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -855,6 +855,112 @@ static DEVICE_ATTR_RW(cores_enabled);
>   WMI_SIMPLE_SHOW(cores_max, "0x%x\n", ASUS_WMI_DEVID_CORES_MAX);
>   static DEVICE_ATTR_RO(cores_max);
>   
> +/* Device memory available to APU */
> +
> +static ssize_t apu_mem_show(struct device *dev,
> +				 struct device_attribute *attr, char *buf)
> +{
> +	struct asus_wmi *asus = dev_get_drvdata(dev);
> +	int err;
> +	u32 mem;
> +
> +	err = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_APU_MEM, &mem);
> +	if (err < 0)
> +		return err;
> +
> +	switch (mem) {
> +	case 256:
> +		mem = 0;
> +		break;
> +	case 258:
> +		mem = 1;
> +		break;
> +	case 259:
> +		mem = 2;
> +		break;
> +	case 260:
> +		mem = 3;
> +		break;
> +	case 261:
> +		mem = 4;
> +		break;
> +	case 262:
> +		mem = 8;
> +		break;
> +	case 263:
> +		mem = 5;
> +		break;
> +	case 264:
> +		mem = 6;
> +		break;
> +	case 265:
> +		mem = 7;
> +		break;
> +	default:
> +		mem = 4;
> +		break;
> +	}
> +
> +	return sysfs_emit(buf, "%d\n", mem);
> +}
> +
> +static ssize_t apu_mem_store(struct device *dev,
> +				    struct device_attribute *attr,
> +				    const char *buf, size_t count)
> +{
> +	struct asus_wmi *asus = dev_get_drvdata(dev);
> +	int result, err;
> +	u32 mem;
> +
> +	result = kstrtou32(buf, 10, &mem);
> +	if (result)
> +		return result;
> +
> +	switch (mem) {
> +	case 0:
> +		mem = 0;
> +		break;
> +	case 1:
> +		mem = 258;
> +		break;
> +	case 2:
> +		mem = 259;
> +		break;
> +	case 3:
> +		mem = 260;
> +		break;
> +	case 4:
> +		mem = 261;
> +		break;
> +	case 5:
> +		mem = 263;
> +		break;
> +	case 6:
> +		mem = 264;
> +		break;
> +	case 7:
> +		mem = 265;
> +		break;
> +	case 8:
> +		mem = 262;

Is case 8 a mistake, or intentionally out of order?

> +		break;
> +	default:
> +		return -EIO;
> +	}
> +
> +	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_APU_MEM, mem, &result);
> +	if (err) {
> +		pr_warn("Failed to set apu_mem: %d\n", err);
> +		return err;
> +	}
> +
> +	pr_info("APU memory changed, reboot required\n");

If you're logging something into the logs for this, I'd say make it more 
useful.

"APU memory changed to %d MB"

> +	sysfs_notify(&asus->platform_device->dev.kobj, NULL, "apu_mem");

So this is a case that the BIOS attributes API I mentioned before would 
be REALLY useful.  There is a pending_reboot sysfs file that userspace 
can query to know if a given setting requires a reboot or not.

Fwupd also uses this attribute to know to delay BIOS updates until the 
system has been rebooted.

> +
> +	return count;
> +}
> +static DEVICE_ATTR_RW(apu_mem);
> +
>   /* Tablet mode ****************************************************************/
>   
>   static void asus_wmi_tablet_mode_get_state(struct asus_wmi *asus)
> @@ -4100,6 +4206,7 @@ static struct attribute *platform_attributes[] = {
>   	&dev_attr_panel_fhd.attr,
>   	&dev_attr_cores_enabled.attr,
>   	&dev_attr_cores_max.attr,
> +	&dev_attr_apu_mem.attr,
>   	&dev_attr_mini_led_mode.attr,
>   	&dev_attr_available_mini_led_mode.attr,
>   	NULL
> @@ -4176,6 +4283,8 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
>   	else if (attr == &dev_attr_cores_enabled.attr
>   		|| attr == &dev_attr_cores_max.attr)
>   		ok = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_CORES_SET);
> +	else if (attr == &dev_attr_apu_mem.attr)
> +		ok = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_APU_MEM);
>   	else if (attr == &dev_attr_mini_led_mode.attr)
>   		ok = asus->mini_led_dev_id != 0;
>   	else if (attr == &dev_attr_available_mini_led_mode.attr)
> diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
> index 5a56e7e97785..efe608861e55 100644
> --- a/include/linux/platform_data/x86/asus-wmi.h
> +++ b/include/linux/platform_data/x86/asus-wmi.h
> @@ -121,6 +121,9 @@
>    /* Maximum Intel E-core and P-core availability */
>   #define ASUS_WMI_DEVID_CORES_MAX	0x001200D3
>   
> +/* Set the memory available to the APU */
> +#define ASUS_WMI_DEVID_APU_MEM		0x000600C1
> +
>   /* MCU powersave mode */
>   #define ASUS_WMI_DEVID_MCU_POWERSAVE   0x001200E2
>   

