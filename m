Return-Path: <linux-kernel+bounces-417325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C179D5288
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 19:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C75A7B2201A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 18:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AAE1BDAA5;
	Thu, 21 Nov 2024 18:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="ouGrVrDR"
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020085.outbound.protection.outlook.com [52.101.56.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DFB1B1D63
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 18:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732213800; cv=fail; b=XGmksMNqIg6UEpfwlxVYxZF6yHxKnjQMXOqxp7ylZVbLeB/ngFBDWwt7x6wlSyJCsJ/Hsr3eyAwZXkx1Og/XaBx3jJqVGhedWVm6DCwfn2dCmcibQOOkogsgDTmZJfRfhOU2vgJSOUwm6X2p+2ovpMIm/dGc5ARVOaNIcAQjaBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732213800; c=relaxed/simple;
	bh=Za4jEu5Er7XZXgNsGblrN4sK3+3qRkOc0FTYrRIz+QU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DAmEl1/iAdZZfcHGoH/mQxMmVhf3LLfr6/bXGqbjrCXzbQ6rmUSc1IDxtjaD9zZOK2k62lIWodODDMBrnmWAE6vmKtWafXeMCvvIF+y6obZ1lqriLl5ekboTOaroTsOsBid4lcyS88M+l7DDggQ7MwhE69hPtRHcb6/zSP9H00s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=ouGrVrDR; arc=fail smtp.client-ip=52.101.56.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VTl3wck0kNPJrBxV62tqy1ANo88AGNSuADyQJVZg/zosXH0CUEFteUuQdeURxXDUywR+IC5Y0mAzNBjnfquzyxmrHZOBJX1q+CCVPNmsEtoWejFsUfAtI0rsNUSFNsDKYYmXfY6nS+88TVMLyPDYaf4Ugr304aZiPhj/2uhzRK3WBGZRzndGsDn18aSqoIQCAgYCTMmtlvkEp93xYZkEUIPYRClMDALUXfNlb+Ha5zxPEZFjBCtvdf46vbfu2PJIeJGLsyeT2fgNLihkhM1ywKDviN++JffgnIfPdkRo0FRfM8Os4t/VUuYfVEEmyY5Qtbtpmx28vgnhd55Ro1YHlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3eUoqQ2RXx2e7DbtA/RDObN8JTBcyb+mWUXoOCCJkeA=;
 b=Pc6eQdF6OcO8yY2bB6U2TiSn8S8bFQ9rY76Dcuqb3VgZA+ppnnNSDnKn1ugfjRqzQIJVh/e6gYnOryN10IwPIDe8yNDfX3fkII+ncdWB8b2Ac+ijwc4idMFdtzM2YvOGgykIGWtREYTKZezYTeKemEgq5s9aKsKe4S1xxwc3mhWU8x5MlUV7U+GHsu1XFL3alDDgc0VuBzTm4YIU4Z9AlN7OiW9GYPaM+l6b3tqkZPdnLeBF2zecAoE+6Jogghl4qNHzoAw9SXbORDz7c7ZXPFoxJTBArSRwTHMWWfovVmMDIOPCjtgtIBp+DO5uhTLP8fIixDOzO6ltub/f9sJN3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3eUoqQ2RXx2e7DbtA/RDObN8JTBcyb+mWUXoOCCJkeA=;
 b=ouGrVrDR+uVyUpkuCkeEofO+pIXZ3p3z2/Y+UNiVe843EObdEBLS9D4wEoWJQWWIP8nT40lj0TqVY49pK1s7CoreeIXTQgR5WBYkO/waSbcgSCEppRO4HYmoiqXZppWAF9Odhd5OvqBhQ/gRrdwVhyK9tkvSPB4mKyYqF2ruuEE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 CO1PR01MB8985.prod.exchangelabs.com (2603:10b6:303:273::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8182.13; Thu, 21 Nov 2024 18:29:54 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%4]) with mapi id 15.20.8182.016; Thu, 21 Nov 2024
 18:29:53 +0000
Message-ID: <182f0f86-5d52-4fca-99de-ddde2cc39c3b@os.amperecomputing.com>
Date: Thu, 21 Nov 2024 10:29:50 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6.13-rc1] arm64: mte: set VM_MTE_ALLOWED for hugetlbfs at
 correct place
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: will@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <20241119200914.1145249-1-yang@os.amperecomputing.com>
 <Zz96WefRxFL0FMRq@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <Zz96WefRxFL0FMRq@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY3P220CA0011.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:930:fb::7) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|CO1PR01MB8985:EE_
X-MS-Office365-Filtering-Correlation-Id: b9bc1c74-938d-47dd-6aa8-08dd0a5a7e19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QUY4dEk4K0hGSEJPU2gvVSt1dWF0aGlkR3hQM21FMGo1cUYyQ0lYM2Z4YVEy?=
 =?utf-8?B?RnBWbDZTNUFvc0ZjRGVJY1RVZFI1NkhTNGZScksxQkVrSVBKUjdRNnI2WVBl?=
 =?utf-8?B?WXJEakxiOFZTdStkK2Z3N1drOFhxUXZFK0liMGZqNHpCdnQ4UlRpS0dKVDFk?=
 =?utf-8?B?MGtPZHFJTWNvbFM2cW5lS2tRWDJ1VmxhZkdoZ1hnMDAvcnpGd0lYekEzYVZj?=
 =?utf-8?B?ZXBHRllwZGJtazVYTmtpTHpCRERZVU1rRDR3ZS94MUdZMGx5YlkyeFFmUENh?=
 =?utf-8?B?Q003eG0zNDRCOHFvRy84N1VYcTdlVEZCdWNvZVdHdGpwUStPUXVpRWxhYmNi?=
 =?utf-8?B?UTFkUWVnaG5kMlU3TGtsTzZjcVU4d1ZTRkdZNWtYK1AwdXp2MWNXYTFiZGNq?=
 =?utf-8?B?VnE3a1UzRnBTbW82NmtLMjZSblFxLytrS3hHMXBPTk9vZG10YUJTVmVkTEVM?=
 =?utf-8?B?MmZkVWZ3RGh3YkVjb2RDZXlaZjg3eFpMSE5mSVlZU2V4ZFZhTFN4Y3RaMlJR?=
 =?utf-8?B?RmRFKzM5T0RXWEFBcHozZHBpQ0lQSFl0UW5tT0NxbFlFZnJ1eU9WOGYwc1Jt?=
 =?utf-8?B?cXQwT0RPekE0WG8yR3FPR1p6THphcnlISW83K09LQTZhRktuN3I3VEJTNWtX?=
 =?utf-8?B?a3A4bUNtRTVTNGh0ZzZleHo0eWhrSXNvTXMwbnJEYVIwazVrSW0rS282TitZ?=
 =?utf-8?B?ZW1DbWdzVzM0NnpzQkw3Z21XeXY2VUdPMGdidWVPbk01NVRoQmluRU5qUHVr?=
 =?utf-8?B?dFlUZ01sSTVhb0s0TGlLdFhSeDVYak9NQlZtRlFnZnZQVitsb1FFQ2lSUlk3?=
 =?utf-8?B?enBXY0VKQ0ZJRFZqTVU2M0RCcGk3YXl3N3hNVThmc2l1d3pEaWRvd0RlbWp0?=
 =?utf-8?B?ekFXZ0wzR296S1lZc2tkeTlEQmlGRkY0WUNUOHhQWlErMUNHL1VHODdyYnNh?=
 =?utf-8?B?K1k1WFFmRmFqNzZTWkRNVCtuMkVPNHJROU9lN0JHOW9FbWRjRmhoUFpsdDRk?=
 =?utf-8?B?KzdNVWV2KzhPODU2K0RqcFpvYTFJSkUvU0ZTdDdGdmttVVJlQ0h6MWIzS2Rs?=
 =?utf-8?B?NVBHSVd4OWZ3RG9MRkhuVG5uUjRqM3V5bi9kU0xRa3RielJka1k4ZC9HR1hR?=
 =?utf-8?B?RUx3Tzd0VjlUMldBdWhuaXhUaDJKTmxCanhHMlMwYkNWY2J3TlFtQ2taTFVL?=
 =?utf-8?B?bXExa0VycUZiMjNXMlVBM0F3R1ZnWklxYUpkanM0aVN0UnNSQnZzV1BveHcz?=
 =?utf-8?B?NHRNUUxtN1ZHNTdJSFk4Y1VUY0p3cThucmJ4d1ZwYUdqdVVCVEJKYzFyc2VL?=
 =?utf-8?B?T29TelQ4YUNRMUpoYWltbDFFMS9hR0lKMDJzd0Rwcys4NTdMZWh2Ukt0a0ZX?=
 =?utf-8?B?dFFvQ0lnRTJXN3FzelhVM0dzZHU5VmVoYmVpYWdwb1o0MC9XUUF2QkN6V1h3?=
 =?utf-8?B?eHZXRkp5MFh2OFMrS01CZ1Fuc0xLN25VSmxKRVRpVWtkdFFoWjdvVEZscGtW?=
 =?utf-8?B?R0U3VnNYUGEvRW5wMnA5dk9yODllQ29Fd1kwSVVjNWg2UWk5RC9Bei9WVk9k?=
 =?utf-8?B?a0pEbk8vWlkvSmNYMHNRN0ZhTkJ3bHNmYmQyUThGUGNCYmx3cjFseUd3R2FV?=
 =?utf-8?B?L1BuckcwZmdVcDkzVkdtbStpZUs0L042YUhLSHVRdnU1ZjA4TS9FYy9Kamw4?=
 =?utf-8?B?OXFoaDQ0Q3Eva3pFU0F0N01pSTZ6SVFHYVFwRTlaYlZlTHBhN05VYmVnSEt1?=
 =?utf-8?Q?79jageUsaJLX1UMEieLhmhmY6CJi2tSPm+/LzjD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TEYza29YcGFCUDRqSlVIZldiNTF5SmZoRmtTR1NJSmtycUVzUkcwUVIxUHc2?=
 =?utf-8?B?ZUlYU0pxYldSR2pieG9WQWRmYVA1bTNvTjQyKzcwOGJvRFRGNmorRlhRdm1z?=
 =?utf-8?B?eDhLZ1g3REVBNEN6dW85Q3A4ZWFJNFFvUmU3blJxNHNMNElBZGtoeXRvNTB0?=
 =?utf-8?B?TlF2em9NK1hzTFJNMDhDM0lldUVpSXRvZk85N0JpKzFIb3M5QXZyczdtQlQ3?=
 =?utf-8?B?eE9TMkYvdmpEZlg5L2h1SDNEdjR3U09RWi9BYTVBckt1RXROeXpwd2NYdUxM?=
 =?utf-8?B?TGhZMDloNWlGd0piTFkxTnpaa3FTMmhNRlhqdURibWhZa1R1bkhEb1RYYVFj?=
 =?utf-8?B?NUUwa0FNcHJFTUJGOVJsLzUrTk0zbHZraG1EbFhMMDFHK3NmdklyQVZNNU5r?=
 =?utf-8?B?NmdudkFWWVFEOHorZzhPRldOc09ENW9jeUc2TEVzQnl5QWFNTTE0OXVGVHRE?=
 =?utf-8?B?Znc0ZHdsMFZsOVZwYXlmOUl0c1ViSTc4ODQrLzEvT2E1V2RtdmloMndxNGZi?=
 =?utf-8?B?aXVXS2ROZDU1d3BzZGRTb2JuUnltaEhKaVRSWHBMZUxtRGxac1VuSEl1c2k5?=
 =?utf-8?B?VGxBYUd3ZEp6KzFFa2p5ZlVoejRVMWpTSy9XdHQzdGxRRHlaSG1haEdqdzM2?=
 =?utf-8?B?VlhGZXJXdHZiZko4dnZGUkJnLy9WNVpwaVU1UVppZVlBY0o1S0ZBcjQwbzhN?=
 =?utf-8?B?MGJXajNWMXQ3S0p5OVM0OUVYRnpUVkp3M2RhWDdseTNlbWtMUFNKNDczTlE2?=
 =?utf-8?B?Mzh1UW05dFJhRTlUS0pYS0NmbE1rOUIzYU5KOHlENktEN3N4WTZwcUQ2eHE3?=
 =?utf-8?B?Ni9EYlFXOTNLZXlWZ3ZDaWZEdmNvUW5tbjJPZjBZbmRrakJpRnp5TFRMQng2?=
 =?utf-8?B?eGtGODc2ZEc1L1huU3pNM1VDRVk5RlA3ZzBqR1lRd2hUL1R3R05rdWgvYXNJ?=
 =?utf-8?B?blh0c0pWOVQ1OE9GcDV3aVlkeTZiN2ZiYW1OaTNYTDRHY0VxZEU3cjVGN082?=
 =?utf-8?B?VDIvV21mczZ4TmRtRTF1MGdsempicVNtWmdXc2NQSVU2VWJKNjZUU0gwRFVr?=
 =?utf-8?B?bFNzaE9kTkhjWkZUV1Y2VEZPRCs4V3lDV0tJQnNMQ1N3dHZWWGFxRHNwL2pY?=
 =?utf-8?B?OXM3ZFgwaVNMSitCTFZLWFhzR2Q1dUxnUmliYUJDV2dlOUd2WEM0emZOdDF6?=
 =?utf-8?B?VUR0Z2ZvQWxZV3dxQ0owWmpnSUt1YkdxN3JUVnVsSWN0WXlEMHIvV0dFNFNq?=
 =?utf-8?B?SG5ZUis2TVRkRGxERmp2L2JIU1dHS2ExQk9mbEVOa3c2b3c3OVlFZit4RUw0?=
 =?utf-8?B?dXRQWEhzazVpdjBDMThKcHA2ejE3aHoxYS9MdDlwalA5VUpubkdhRllpV3M1?=
 =?utf-8?B?Y2JkdXdxZDFIN1k3VFVHYmhLYXBpOHlqL1liTTA3V3Y2ZU9RYjI1cFFOUk4y?=
 =?utf-8?B?VVZlZHkzcjZPQU5BUjJlTks2UHdub2t0cnFhT1ZGWmFSa3pucG4vVGVoTzdB?=
 =?utf-8?B?aWNBU1ZCVlM5MmJ4WGJ0Yis3cHJvaTBhNUN5QVBFekhNNVNWWFB6dmdoTlNV?=
 =?utf-8?B?SWVYdGFUY0gxdFd4OEVkdTU4RkhUQks4VlFYVGtIMVBzL0luRUcxNjZ4UUtv?=
 =?utf-8?B?cm1BdzZNUjcvMWlFMDY5MXcvRW93UmY4aWFkSk5aVnZVcEdjdko5TGhPaldX?=
 =?utf-8?B?S1NKaUVvbURZYmtyU1pvVjA4KzBweUVFamlkZjFITWtFL1lWSjJBMCtIWVpQ?=
 =?utf-8?B?VmZYczNnNXFua1BPeWZyZUl2RjA0TndNWTlKcHJrMnBhaGczQUp4ZVZRZ0JI?=
 =?utf-8?B?L3E0NFJhTXdZcDFpM3Y4UFkwZTE5a0JwdGVEM2p3MkNyQnVJdWVGWmJTV3R3?=
 =?utf-8?B?aFU3a2U4RjNROHJidmd5RlY1TzVJa3VwakpIMndEeTVEbEV2WFJjVnFvTG40?=
 =?utf-8?B?clNMQ3g2QzNJOU1rQm50Skllb0w2QnlEb0RERElTclpCTmhCajJmdzNmaGxD?=
 =?utf-8?B?V1VYYzhjclJlUFdzOVc4RkdnN081NERjYWdEaEx5SW5YYWw4M1NFZm8vTkJX?=
 =?utf-8?B?a2ZhWFp0WmFhTkdPbG9Oc2s2Tm9XeHJzWmhvVEt5WWw0NlRIZ1N5aG93Zkx3?=
 =?utf-8?B?RW5iL0ZuRnl0TnR4T3BVbExTcWl2emtFWGEwbU1QVVJoMjFGaCtmRmVwUHJy?=
 =?utf-8?B?L2c9PQ==?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9bc1c74-938d-47dd-6aa8-08dd0a5a7e19
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 18:29:53.7774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8eqtrxiRS1uSY2/qXBRV5ujxgdkLMe7Fl7MWZl3ULi4CZjWDA1H+73dv5qunxD0KrcEwnW4JuhdOV/mcg2p3z1xaEsoIQGmGaDqY6SroaL8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB8985



On 11/21/24 10:22 AM, Catalin Marinas wrote:
> On Tue, Nov 19, 2024 at 12:09:14PM -0800, Yang Shi wrote:
>> The commit 5de195060b2e ("mm: resolve faulty mmap_region() error path
>> behaviour") moved vm flags validation before fop->mmap for file
>> mappings.  But when commit 25c17c4b55de ("hugetlb: arm64: add mte support")
>> was rebased on top of it, the hugetlbfs part was missed.  Mmapping
>> hugetlbfs file may not have MAP_HUGETLB set.
>>
>> Fixes: 25c17c4b55de ("hugetlb: arm64: add mte support")
>> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
> Since 5de195060b2e went into -rc7 and my arm64 tree was based on -rc1, I
> did not test this combination. The patch looks fine, so:
>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
>
> So I either merge it via the arm64 tree at -rc1 or Linus picks it up and
> applies it directly during the merging window. Both options are fine,
> it's not essential that MTE + hugetlbfs works at -rc1. Adding Linus and
> Andrew in case they have any preference (and leaving the patch in place
> below).

Thanks, Catalin. Either way is fine to me too.

>
> Thanks,
>
> Catalin
>
>> ---
>>   arch/arm64/include/asm/mman.h | 3 ++-
>>   fs/hugetlbfs/inode.c          | 2 +-
>>   2 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/mman.h b/arch/arm64/include/asm/mman.h
>> index 1d53022fc7e1..21df8bbd2668 100644
>> --- a/arch/arm64/include/asm/mman.h
>> +++ b/arch/arm64/include/asm/mman.h
>> @@ -7,6 +7,7 @@
>>   #ifndef BUILD_VDSO
>>   #include <linux/compiler.h>
>>   #include <linux/fs.h>
>> +#include <linux/hugetlb.h>
>>   #include <linux/shmem_fs.h>
>>   #include <linux/types.h>
>>   
>> @@ -44,7 +45,7 @@ static inline unsigned long arch_calc_vm_flag_bits(struct file *file,
>>   	if (system_supports_mte()) {
>>   		if (flags & (MAP_ANONYMOUS | MAP_HUGETLB))
>>   			return VM_MTE_ALLOWED;
>> -		if (shmem_file(file))
>> +		if (shmem_file(file) || is_file_hugepages(file))
>>   			return VM_MTE_ALLOWED;
>>   	}
>>   
>> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
>> index 1bbf783b244a..2dea122e5b93 100644
>> --- a/fs/hugetlbfs/inode.c
>> +++ b/fs/hugetlbfs/inode.c
>> @@ -113,7 +113,7 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
>>   	 * way when do_mmap unwinds (may be important on powerpc
>>   	 * and ia64).
>>   	 */
>> -	vm_flags_set(vma, VM_HUGETLB | VM_DONTEXPAND | VM_MTE_ALLOWED);
>> +	vm_flags_set(vma, VM_HUGETLB | VM_DONTEXPAND);
>>   	vma->vm_ops = &hugetlb_vm_ops;
>>   
>>   	ret = seal_check_write(info->seals, vma);
>> -- 


