Return-Path: <linux-kernel+bounces-399709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A3C9C033F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 12:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 821821F21871
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 11:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38C11F4710;
	Thu,  7 Nov 2024 11:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1a1efKQa"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2049.outbound.protection.outlook.com [40.107.96.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD21B1EF923
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 11:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730977379; cv=fail; b=TS/eScetHnU5mpdP3jN9Oe1MX7eMEEB3WDDRaOkP9b+vOSeQzPSsBxn5PTyGcZAWymiyZuQRS/TVJItZTRFv3WHdKF0BLRL+5Uce07zlL1V3QumMkoPz4aJsm8TsULBge9cGjB2j2OJdcI1kenG4j1B0pZDtUYlOK71BFnzIXCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730977379; c=relaxed/simple;
	bh=e91ZA6+CrBO2bp/x+0Z21N8sKXHcjlEjwwsncer/vJM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oFfy6t/8LOFKu766utqLb7jz3OYWcvdhN+Tzt3oNh0xqusbYK0FTYhOmUomjZxEP/YTmjYbSz+L/OSh67Zleo9gIUFTwY0BkSF5jGXhcSsIZwbM7XqIMfsvtvyC0qcLIfz6dRMYiLC+NAy7WxqBnTy4pjOprpSdBpYUR0CeMLO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1a1efKQa; arc=fail smtp.client-ip=40.107.96.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lj5RzcHf92aM1PV+woP3G7mZTeqPXEToqcsGIt/rYHrgCdWL4yevaS80km9use2Cm7vUPnKO1t/4mcLEDBVQ8CZ1C6DG4dBMSeeV8vlSp8aZoEpFPU3l0ieMB+hhEnCxFfJeW2OU7/BwYGcbjpr1kKigpCUlUfemDF4/JIBJTEIJrs/8wbrQeHLMd2V4SVCHv5XGQ3Gg3oMpYf9ntp8gImxz9uq9/k1e87bN5+mmV4KUNtACM4t2N7F5d+oK9KonDfsyFmX9VPz8RBuO9IMCTatKzsiRNlfBfU3yyNXaLQF5WjviVMG4sUefPc+AaLsaxV0+O0ITbfdxRlXKB90BCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=REtIS4y+RYlwxw0nRTfRQ7gbuhBPXI87gvk0c+5Tf5k=;
 b=dlOaVdjzQUmnNECIfsV7ciSI8sudEegV5hmf+8c0QGrLFDPhmHdsaufrGLd703eBIMm6+ddE7gaKHBvrO++17xEYtQq5KBlV5AKDvaYkonl4yqpBUn80Y4xR3qjU9QmmhcrcFtaibajDbV2jx+f4gPxYaYfw//DFYOVanoJP7ZXmY7bejc7IolYQNfZ6IJYnZ/nfAIkamYRFmOgNyzFXw6rIs1vTT21/PQ69taQ7lmRxDYBppWmNJUROmf3t/qMaHTxNUD4Kd1s4xkiN1A8OWa61XBkJCcz8/LLRMG8D0Fx0k67Yc/wVYxBTk3VhDLq7jJzz0yJyaSDEtY7bSttMFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=REtIS4y+RYlwxw0nRTfRQ7gbuhBPXI87gvk0c+5Tf5k=;
 b=1a1efKQaQPvKKlpa2TUeeb4ckFZl/ql0yxO+4gydJxWtGy59wWUBDALSX3cF7i7bYwCY1ZHXICPMbiboPR9bAlsPRprij8YA0zZmYNFJSDkb3w5+WUKxYZURwreWQ+7kfCmV5z/vcANhmLFGkZVb/6VOv9QXbtdK6qc534+I+n0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB8189.namprd12.prod.outlook.com (2603:10b6:208:3f0::13)
 by SA3PR12MB8761.namprd12.prod.outlook.com (2603:10b6:806:312::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Thu, 7 Nov
 2024 11:02:54 +0000
Received: from IA1PR12MB8189.namprd12.prod.outlook.com
 ([fe80::193b:bbfd:9894:dc48]) by IA1PR12MB8189.namprd12.prod.outlook.com
 ([fe80::193b:bbfd:9894:dc48%4]) with mapi id 15.20.8137.019; Thu, 7 Nov 2024
 11:02:52 +0000
Message-ID: <beaed4f3-58f8-b344-ef95-9f3c988ddd49@amd.com>
Date: Thu, 7 Nov 2024 12:02:46 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH] x86/sev: Cleanup vc_handle_msr()
Content-Language: en-US
To: "Borislav Petkov (AMD)" <bp@alien8.de>,
 Tom Lendacky <thomas.lendacky@amd.com>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
 linux-coco@lists.linux.dev
References: <20241106172647.GAZyum1zngPDwyD2IJ@fat_crate.local>
From: "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <20241106172647.GAZyum1zngPDwyD2IJ@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0561.namprd03.prod.outlook.com
 (2603:10b6:408:138::26) To IA1PR12MB8189.namprd12.prod.outlook.com
 (2603:10b6:208:3f0::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB8189:EE_|SA3PR12MB8761:EE_
X-MS-Office365-Filtering-Correlation-Id: 019c0745-0901-4bed-e01a-08dcff1bb9a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MFlTUjNaRWJjUkt1b3RBQWUyOERRWkdMZVJtcHpMRGx6YURMVllyNnZsNDZ0?=
 =?utf-8?B?WjZFdUNIcW9YR0tjUE9BaUhCQ0R0aWZnVGxOYjJZelRnc05KWDcvMHZEUTB2?=
 =?utf-8?B?Q1huNExVb1ltb1hwczNaSW96TmYvZ01BV2VncjAwdTdOOTAvU1VWaUNxbm9l?=
 =?utf-8?B?dDVnZWhndVF4SlFUQ1BQQkZDTDU2V2JGb2RTY3ROZ2RhT0w5cEZLSnpTdEhp?=
 =?utf-8?B?bXF5ZFM5UUMvTytzVDc3cWtvMEh1SFVDQVhDMXZwcUJaV0xqdTlLQXczb3lT?=
 =?utf-8?B?MHB5NVdBOEoyamhHeThrM29zajVQZlVhWFRQMWxSMFNBWHlOWFdkK0VUL0pn?=
 =?utf-8?B?bXBiaGVtUlEwSkZBVkQrWUNDR3NpMHFGL2R4Qy91ZEtWL0h0b2V6aEYrSHUv?=
 =?utf-8?B?Y1lRL0FvN1E1Mi9PeW9TUHVYYmtyb3hiRzJNcUxZaUxwRldKVWQ0S09EUTdX?=
 =?utf-8?B?R29RMTlwQk5QNUFLOHlDZVlxWU44TW80ZC9zOVhJZG9YNW9WWVhyeXZqMkhS?=
 =?utf-8?B?NFRBamxKQXZhanVzVmtYZnQ2WTJIZ3VZcHpSOE5qTXZuZXdSckcvT3I4aU0w?=
 =?utf-8?B?ZEtjTENvRW1qY1F6SVo3UHJmaWFjYlpHcVM5bkFmUGx2QWt6bmxJVXk0UHpC?=
 =?utf-8?B?VUhUbXhQblo5eWNTWlQwcktidVlDY0VOak9CL3NxVjF5c3RCL3BrZGFQNVpx?=
 =?utf-8?B?ZEx5S09NR0JySnh5cEpDREt5YnF2UkxURjBvK2Q2MlBGa1ZJcnFKdjYxNmZw?=
 =?utf-8?B?dkl2aU8wSldaWCtmSldVTnV0NFNhaGgxV0ltanYyTWpNR0lMR3F0NVhQY0Jp?=
 =?utf-8?B?QTF0aXkvVnE0bkh3VWYxZHdiSEkvVVMrTDFvd252SWF4YnRTRTlneVByY3dZ?=
 =?utf-8?B?a3NWQVBJVlBEV0RoN3ZtQXd5aWttZTBQbXowRWQwajArd2NOTkEvVlBTaTFN?=
 =?utf-8?B?RTNDUDQxYnlxeCtQYkdKUTMzbkVxSHl1K0FMMDZJdGgwdk9OY0ErOVhMZUp3?=
 =?utf-8?B?MmRsWDJiT1pGSFNOdFhEWEdIZWhaOEVjUmZSbEIvTmxXekpVVm41ZDZuQlF0?=
 =?utf-8?B?WFNpb0k4bnltTGUxdXFnZUdSdnVZZ25tVmhiYzBJZm9rVkVGRXNUYlRwWnF6?=
 =?utf-8?B?T2paandkSEdUdVZMNGQ3bDgzcFR1M0UvM3p1QjVHSkwxOEJKWkJJNWRKVUp0?=
 =?utf-8?B?OU1LNGRxdzBYRGlHYmQ5VUNWMm1XS3R6d1cwUGxvZ2VFUEowYzZZMmpUN0Fa?=
 =?utf-8?B?RWwxYjhDTStGYjBlYUZPR25WZlpsRHg0d0ZHVXI4UWJzY21ZaVNsY3BsTUxx?=
 =?utf-8?B?Qm9kOVkyUWRWZ082S3VsQ3NibGkvREFDdjVtRWxlOU1OQVFOczFkbjhlNE5K?=
 =?utf-8?B?TGJEUSthSjlqNzNnSGxZM0VKOEdndzdyT3I4M0dPNksxTEFZVUE3VERhVmFK?=
 =?utf-8?B?bzhWN29JS2VpNmViaEJIM1p0dmdYSlY4MFIvY3Y3WXJsZTBrUWN0VWM2L3hY?=
 =?utf-8?B?TGxnMUx0WWM5WDJVK3UwYWQ3dVZ0MG9IbjRyU0l2QU1NalkzUU5UclFaK21z?=
 =?utf-8?B?aW8vdno4RVRxb2JsMjgrT0VWS3NNSTIzbFpFSTRTc0FacXR0TnM4bFBPUXow?=
 =?utf-8?B?bHBTeEp1TWh0Ri9OcVJqeGR1NDE3UHZhY0JHY0tEUDVvYkd6QWpQWW9TQTd6?=
 =?utf-8?B?eUZJVmRtZjQrZnJWcnU0TVN6eFpuS2d4Q1NIODZxcG9HWlN2ZGY3VDR3SVNt?=
 =?utf-8?Q?ZVNS8uhPZj4hb+fxtg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB8189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0ZRTmlzZlErTEhBaXpKTFQ0ZlpwaXJ1NzNsMkJETGdKWTl4cG5qOWNzS0F5?=
 =?utf-8?B?ZjJ2R0x4ZnFDOTlrQjFMQ2ZuTlZhRmxNb3dxbXdCMGw5dXNXYTY1Ymp6TWJC?=
 =?utf-8?B?YXFGenI0TnlnYVI5UUNrUFBqbzFTM1dGZFR0d0dXdzRGSzUrcFdBRW82M3ZY?=
 =?utf-8?B?dUE2UEs1OThnWTc5bEJJTk9QOWRXeHpESXdQamZxTnZaM1k0dE9vZUZ2UXNv?=
 =?utf-8?B?aFQrRnQvNUJtMHAwdDVUVnEvbjJsai8waGowb2RYVkdvU0ZVN3JLVnNtNm1j?=
 =?utf-8?B?ZnNESStqZS9kdndoVWkzWG9BWTBDTkVzakx3RU85VnFYODhUWkNwRW15bWZs?=
 =?utf-8?B?dk1Tb2dVS2REd25RaWgxY0NONlF3ck1yemFyTEk5WjBjRnB1TnBrQXhjMmNE?=
 =?utf-8?B?ZzE4OEl6SDlhaEpCSlU5VjVZbkh6QVRlaC9RMlhPVVVBQ3c4Q3lNV1BkdnI5?=
 =?utf-8?B?Mnkwc0NNbWtLeW1oK2dzZWZpN1gwVFR1UjYrWDBPTmVOK2laZ3ZlZ3VyeW5k?=
 =?utf-8?B?VU5tbzdnSUY4UHBtUXV2WHptL2VLNGdLQjNaWG9hRGdSOTlGQzJaaERndGhR?=
 =?utf-8?B?aVhtRytObUVYYzhPalBFY1h3VWdyMTljZHlIbFFoWlpYVFdXSFdvNEM0UFlJ?=
 =?utf-8?B?MHExRWVFYml3NC9WUFlQVjBPZnRjUTZ2UjB6Z0tlcW84R3QvQUk3M0FObERE?=
 =?utf-8?B?bU9WaDBLeFQ5VE9hRUt4ZGVWamVyUWZnZU5TZWFGQVVLWDBwc0tJSytxb3VX?=
 =?utf-8?B?eXQ4Tzkxd1pySXRnazYwYlk1T0JkSzRDcVQ0NmhCMjArNXRsUmVEY2pteGFh?=
 =?utf-8?B?UDFiek9uUFZJUjRCU216eUhyTE05QThRRXl4UXg2eEE0clUyQU44VWRnT1BL?=
 =?utf-8?B?NE9vd2V3OHR3QlEwNVRZajVlWGM2UUhPU0piMlZGQW9sREIzR1pmMDlvK2VC?=
 =?utf-8?B?RHlNMFBUb1lXQnZ4YU8zNHdnRXZWS2Jwckg1b25LbUpDbGZIYm5XR1VONWtl?=
 =?utf-8?B?dXNuR3lKL3JHZDBucW40Z0ZNcGhISUtFSzIyZ3YrNDhrWTFGN2E0Z0dNTGE5?=
 =?utf-8?B?MEZwT1dLN2tXdWVSd09hOW5yemRudGowR05Gb0NTMlBxeFhlZWVpWU5zak1B?=
 =?utf-8?B?WkNBSi83MUpPclRETHg0dzY3TThtUHVWTUVMVThTL0JJZW8yTXBvakhpTnJp?=
 =?utf-8?B?c1k5Y1c3QjI3OXQybXJFRUNSWFl3MlZ5eHlPVndNWEhNYVNIZHV0elBUU3E5?=
 =?utf-8?B?Zi9LdUs0a3RpMDZpV09kclZKNUNLS3pMeG9oeEhwNHFoR2ViQTArdDZaY25F?=
 =?utf-8?B?Zm9JbDJiblVoK0VBSElnUGtqR3R5aXV6b2Q5UUhVelRiQjQ0eG8yVWllMDUr?=
 =?utf-8?B?ZWl1c3VLRFR2b0kvODhZUmdPb1dDTlZwbTFXRXllWFdyeVpDa1M0U3lsZnlw?=
 =?utf-8?B?VGZhYUZ6QS84a0VaN0JzVjNZSkkyVk5rMUxReGpEN2pBcjZSM3JQeDAxa3kx?=
 =?utf-8?B?cGZUSHZUWVpmWURYbmdNWWJaS3JOSlQ3K3p4L2NmKy82NG5DUmE2ZGVtUXg5?=
 =?utf-8?B?ZkFreHNKODhxNlRQU1RZRlpsUXdiUS8wOEZINTdJN05BOHZMc2RUWWIrZWJU?=
 =?utf-8?B?WlhRMCthWXZlMWZyZVIzVDVBbUhWcjJJbnYvUmQ5MXJTTW1ybjg1dTRFYWlu?=
 =?utf-8?B?dDJoSVFlVkszODQrS2NDNDNVczlvQ0pXczFSaFIzdm9wWWZ6MGhEa3VKYXFO?=
 =?utf-8?B?KzJaNDhQZUtnNitFL1NkdlhCRU16dHBjNzVXQVJ2VXdtTnpWQVl0N1ZFRVF0?=
 =?utf-8?B?ejR1a3ZvM1RWT1hmRW14NXZUN3BRYlJaTUpWZ0tkdVo5MURJRnM1Q3NQR1NH?=
 =?utf-8?B?NVhjTEw3OVFrY1FKc2V1NUVqUk9lVGp1UDd0MCtFUG5WSXkrczdBZzRiUWZx?=
 =?utf-8?B?YmpicFU2d091N1BIcVl0WUVHRWRjL3FqVlBuNVBsQjlzaUxQV0hBdXExS3hD?=
 =?utf-8?B?QXVSWXAzTjhiREdlN3Q0dEdVVUh1ZUtOd1BDSVZybzlwd3JGSE5yTmJ4TDhk?=
 =?utf-8?B?UVpwSzB2N244MmltdGdOSDJNSE5oc1lPZjJoRFR6bVE3YVJvODZHYmY5Um9H?=
 =?utf-8?Q?Cq+rkHLqLHhhSp/7XJzvdVFZf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 019c0745-0901-4bed-e01a-08dcff1bb9a1
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 11:02:52.5010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aOTxUft/5bIGiMfhLoEX1cfS06L9LZzEcAP97uIMGikf+fdAM/iCrkA6NUWVLUm93IYpkTlme4yHzjezEgieuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8761

On 11/6/2024 6:26 PM, Borislav Petkov (AMD) wrote:
> Hi,
> 
> I think we should clean this one up before in-flight patchsets make it more
> unreadable and in need for an even more cleanup.
> 
> ---
> Carve out the MSR_SVSM_CAA into a helper with the suggestion that
> upcoming future users should do the same. Rename that silly exit_info_1
> into what it actually means in this function - whether the MSR access is
> a read or a write.
> 
> No functional changes.
> 
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>

LGTM

With minor comments from Tom,

Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>

> ---
>   arch/x86/coco/sev/core.c | 34 +++++++++++++++++++---------------
>   1 file changed, 19 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
> index 97f445f3366a..1efb4a5c5ab3 100644
> --- a/arch/x86/coco/sev/core.c
> +++ b/arch/x86/coco/sev/core.c
> @@ -1406,35 +1406,39 @@ int __init sev_es_efi_map_ghcbs(pgd_t *pgd)
>   	return 0;
>   }
>   
> +/* Writes to the SVSM CAA MSR are ignored */
> +static enum es_result __vc_handle_msr_caa(struct pt_regs *regs, bool write)
> +{
> +	if (write)
> +		return ES_OK;
> +
> +	regs->ax = lower_32_bits(this_cpu_read(svsm_caa_pa));
> +	regs->dx = upper_32_bits(this_cpu_read(svsm_caa_pa));
> +
> +	return ES_OK;
> +}
> +
>   static enum es_result vc_handle_msr(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
>   {
>   	struct pt_regs *regs = ctxt->regs;
>   	enum es_result ret;
> -	u64 exit_info_1;
> +	bool write;
>   
>   	/* Is it a WRMSR? */
> -	exit_info_1 = (ctxt->insn.opcode.bytes[1] == 0x30) ? 1 : 0;
> -
> -	if (regs->cx == MSR_SVSM_CAA) {
> -		/* Writes to the SVSM CAA msr are ignored */
> -		if (exit_info_1)
> -			return ES_OK;
> -
> -		regs->ax = lower_32_bits(this_cpu_read(svsm_caa_pa));
> -		regs->dx = upper_32_bits(this_cpu_read(svsm_caa_pa));
> +	write = ctxt->insn.opcode.bytes[1] == 0x30;
>   
> -		return ES_OK;
> -	}
> +	if (regs->cx == MSR_SVSM_CAA)
> +		return __vc_handle_msr_caa(regs, write);
>   
>   	ghcb_set_rcx(ghcb, regs->cx);
> -	if (exit_info_1) {
> +	if (write) {
>   		ghcb_set_rax(ghcb, regs->ax);
>   		ghcb_set_rdx(ghcb, regs->dx);
>   	}
>   
> -	ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_MSR, exit_info_1, 0);
> +	ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_MSR, !!write, 0);
>   
> -	if ((ret == ES_OK) && (!exit_info_1)) {
> +	if ((ret == ES_OK) && (!write)) {
>   		regs->ax = ghcb->save.rax;
>   		regs->dx = ghcb->save.rdx;
>   	}


