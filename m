Return-Path: <linux-kernel+bounces-534477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE51AA46737
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C959B3AAE4D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1F4223711;
	Wed, 26 Feb 2025 17:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="N8mMQ3hJ"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2052.outbound.protection.outlook.com [40.107.101.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5C52222CF
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 17:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740589212; cv=fail; b=aq0uXQG193uJLQDesuvGSbXlKM9IhRl0LOnFwbrZZX9hp2JUGsomCSfwv2Yartz33X8tYPs0bBnuzN83FO/1bP2MnoH/pDmx4rV8ntmop4P3zQDmkIR1QauvfnEvxMNLBROJ7sly+FMX1ZdafIAKDNQPIXwNPYleIEMEJL47tfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740589212; c=relaxed/simple;
	bh=F3tSR6vJEzUrD7tI5KmOxAaISLGN9AWfIv9wJlnNzkA=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=Gcr489Tq9jBWkaPftYDGZrdoL3k9t7CwrPihw/rKVYeIV5IK74JLhNTUNijVdWNMmEzJetaUjp/FkIe2cTRec7+MnEV0CJtbXW3UP/ZcoNBouL7kGhYk7Bg7nlSHLtJkKfRR+EjkCdC6b45VexQ7i2PPs2tPUbPGW382tt6W20g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=N8mMQ3hJ; arc=fail smtp.client-ip=40.107.101.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xVUsEI3VARvZWm5CggE7+Xk7V8tD4TGvvW2PeYEQs0Oiuj88o9s6wULf/jRHv4WasSROIDUIbU9HuaIjCGKbwgZoiNp1USZhdwYZ+zw4tfyoav/D8M5wOzPdy0du95SmaYtWVAvHGADpoY56FKXvDaK0zUbI6UvgvE0Oyhe6f0py7RkBLpFf3yJqGmHYWAUGn5SKf77ya2kwjDO7JKou4v4uiTEWpYn0HySBgRjaKRwZxu60w4ZTQuPyHs/9i07MsBakvcNWyTd1ICBZReR4LIMuyw6+XrB7MMp1ncZvwPX56pYiF8fd+393HCu0UGhgcFsJQTxBWEpyVPTQeMyYOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JqEx0LZaWgZzdD+vsrjQ4IKknMxpsnzs6OskpptPCUU=;
 b=DPsbHUqD59+LB/MQdePY8RpatuqgrQf7gCLXZvTsnIShpcX/YC9BetP7lE97a+32+D17/3JHKC7iBx2g6P2v8HWKqGJBYO3fsfXwlN91kwwlxx2AWYnt257xuMsWGNf+OUE3YOxjvkdm3K7YrGCUM58m2M16/5artLvmaVodbzH+MAefbwak1WU6XWvlmOrCCgLep9GT9W3KrJCmmpHYqnH8VGDguacqvW/ymuAX3jO+Ilyktd8B0vhZLyA18RycTxhlcsbFZYW0Rjemzca0G5iX8CzjtyzH70mx5oBaCEOn1Y5SQQazoNETzYgqymlCn4dkUqkvSQ9X4ZGJRCwCcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JqEx0LZaWgZzdD+vsrjQ4IKknMxpsnzs6OskpptPCUU=;
 b=N8mMQ3hJUxlS3YfEthiJm/Y/9/4Mv1uhLDmCnIw0GsZoPNCYjNMMbQgA/ourYeiAEqyu/S1lq3Dvp+yMIpdPI0IK5zSQhohyp1ZftXyf9gyscDyBQcZXh50QssRguYQn5YwB+/SimwJuooZcYAzyCPBuH48qALJJivQ+u8LsrLs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by SN7PR12MB8170.namprd12.prod.outlook.com (2603:10b6:806:32c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 17:00:07 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%7]) with mapi id 15.20.8466.020; Wed, 26 Feb 2025
 17:00:07 +0000
Message-ID: <680053d3-4cf9-534a-1c52-c6e259b85452@amd.com>
Date: Wed, 26 Feb 2025 11:00:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>, Rik van Riel <riel@surriel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
 dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com,
 nadav.amit@gmail.com, kernel-team@meta.com, linux-mm@kvack.org,
 akpm@linux-foundation.org, jackmanb@google.com, jannh@google.com,
 mhklinux@outlook.com, andrew.cooper3@citrix.com, Manali.Shukla@amd.com,
 mingo@kernel.org
References: <20250223194943.3518952-1-riel@surriel.com>
 <20250223194943.3518952-7-riel@surriel.com>
 <20250224132711.GHZ7xzr0vdhva3-TvK@fat_crate.local>
 <7c2baf33265444089ab780848de29a1336a9a4cc.camel@surriel.com>
 <20250225203803.GGZ74qK1oZWk8u69O4@fat_crate.local>
 <20250225210300.GHZ74wBP2ogmM5P5lP@fat_crate.local>
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v13 06/14] x86/mm: use broadcast TLB flushing for page
 reclaim TLB flushing
In-Reply-To: <20250225210300.GHZ74wBP2ogmM5P5lP@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0054.namprd12.prod.outlook.com
 (2603:10b6:802:20::25) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|SN7PR12MB8170:EE_
X-MS-Office365-Filtering-Correlation-Id: fbfd8069-d936-4a8f-cc57-08dd5687059e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?KytTczdqWlY4YkJOekNaYmRxVWwxSkdTY3F3WFhRMlFkZmRqWU9UVGhHNVFq?=
 =?utf-8?B?anNZTmMrd1lOWG5kN1I2QkxSa0J5WXExbDJyU0JXMmk3VVJMT0lQdzE4dmVt?=
 =?utf-8?B?ZjBMTklET2k3N1hzV0ltZHFBWDF4dXo0QjBQNzl1Uy9HdnVqbTk2VXdSVWxh?=
 =?utf-8?B?a0lMSjJDMjJCYTBuSFFpbFA5SXpTUE1zTHk0Mk9Bdyt6Uk1icVlweEpMaGJM?=
 =?utf-8?B?dXI1WTBMV1oxOUNMRmZDVzdnd1ZwaXRicGNUSWNEd0JTWTVKMkxWMVZrMDZF?=
 =?utf-8?B?VGFGZ0NYVWJpdXB3RHk5R2VLV25IZU1aL1lzN0hqV0JXaW03SUZHRXp6aHBS?=
 =?utf-8?B?TllocDcyN0VZcjY2ZXpiZlRpcFE1amg4elhGaWM2TTUwNE9STWJpMitqbDc3?=
 =?utf-8?B?Q2tMNEE5THNOaGxDUjhXdUtMMUlWcVBId3lYaW8ydXhYLzkvYWcvd2FSaU9a?=
 =?utf-8?B?T2Rla1dkYjZrODQrTXNyWENBVGgyWC9uQVJoZWk4VnhySHdkNWZmY2JaZDA3?=
 =?utf-8?B?OEhId2NydWpjajJPTC9HR3VYMk1RMk9QTHhYSG9ZY25UN25pOFZ3ZHJCUFB4?=
 =?utf-8?B?WGo5QUtMbzdjVjRYUnFkaklFZXJIcHQySVNuRHpxcU04MkIycXdaNS9YN2Zh?=
 =?utf-8?B?cU04TzVPR214Y21maFhxWkhrQXYvN3MyV0lMNnlxbTZFUTE2Z3p4UHBXeXIz?=
 =?utf-8?B?d2VCcXY5OEQvdXZxOTB4dThDN1dSa0M0SE90ZlhiTG9iRmtEVXVMcjZuZytv?=
 =?utf-8?B?UUJka1lUTmpBZHNRL09LQnAzRzBMb3BsNlFseml1UGNFaWpkSXArSkpmbDFU?=
 =?utf-8?B?QmNGTVFtKzM4WGQybUhpamlmbjBaMDIwNlFMNzdhY3Zmd2FWcXAwWW1YT1JG?=
 =?utf-8?B?cVg1dVlTM0ZWUTRhUERwcWtuTWtZeGxHdWFTY1ZvVkdObFd5Y0pyaVpvUUJs?=
 =?utf-8?B?Tllxa2kzWFprUTRrSWtpcGRveldOblpLR2xRM2NmQW5HcWN4QWZ3bkQ2aG9o?=
 =?utf-8?B?VkZ6S3NjVjBEMnF6U3o5N2YrYUVqR2JPN2Y2emZDdGlLcGMxc1hSaEdncVIw?=
 =?utf-8?B?NlMvZ29iOFRWUFNKcDFJQWdkUFBSQTNwMDZHeERZVXoxL2pDZWRZakI4R2pt?=
 =?utf-8?B?R0FYeFoxM0E2N0IweElWc2lZNWdjMFpTV1RyTjMzZk05YUdOVGJ6ejh5amhF?=
 =?utf-8?B?TFFyUEZEUUJtREpONGFpNG5jQ2E3cFgrdDFGRVVISm1FNUdGa3h0LzQ4WnBI?=
 =?utf-8?B?ZFRJenRzSWJHS1pzTHRxMHQra1lxL0RWTllLNDRONVhmMFc2b0VYMmF3MWt1?=
 =?utf-8?B?ZUJ5ODJKVXIzeHBhanhBNGs4UHI1N09lczYvd2wzWDVtWHBRZFZoa0pJU2JJ?=
 =?utf-8?B?YXJNaGFteTcyeFVyL29XZy9hL3hZUHhyaFArM1NxZ1hGampmemliemE3UjZx?=
 =?utf-8?B?eWZuaDArSC9WT2huUVNDNEwzN25wOXFJRWR6WUFPaVhCYmtoUmdZV0wxYU4z?=
 =?utf-8?B?SGcwbDhjeWxaM2pLRmlSY2NnVWQ3c3NKcHJlZjNXRXpkK0o2T3BoRERiZnJW?=
 =?utf-8?B?WVAwcGFscEs3RUhkUmcvbmRuZ3dnY1Avc1FSUHhKSmpkbW5tRjczaFcvRU1w?=
 =?utf-8?B?S2NYdEo3TkxoTUZhMWxxclRoWHZ4cFNZWHR2alNQemc3SGF3WGprSXZrbGlz?=
 =?utf-8?B?UGhHVW9ZM3FibS92SXQ5NXlhMjAwc0F5aTE3Ynhacm9ON2VPaG1IRXpBemty?=
 =?utf-8?B?MHZ4VVlES2pnTU9aL1dGS1JGb09NVWY5dk5CODhRRU9Gc2huUmpRSk9PRXE1?=
 =?utf-8?B?aEUvd2crQmd3THExSzJvWkhLTWlMK09tM08vdytNUzZFY0pVblVUVkc3Zmw0?=
 =?utf-8?Q?r81mdhmF0mMpp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bDJuM1B6RkhWcW1DM2o0dnFKaVBDNHNXaHI0c2MrVGxMN2ZJQTR2R04xVDYv?=
 =?utf-8?B?RzhSZ29Gb2lVblVVN0RHTVZkU0I0eWxib3BMZHhHU0xhWk92c1NzUFZDQkpl?=
 =?utf-8?B?ZFB4VFBaVW5pY2dVNmpkbXlJdWZ5N3FFWGVIZGY5VkxCV2pHWExLdHR2SWRQ?=
 =?utf-8?B?Rk42N2JkQWUxNXkvZFdMdnRXS3dVN0QrTHpYQVoyWjZFem9HQ0hiMzN5cFRn?=
 =?utf-8?B?YUJFd1o3K1B5dFlqYkhadStVQnBlSzZ0d3RybGsvZTdmdit3RXZDUmdzVGpJ?=
 =?utf-8?B?cVJnanpvRHRGR2JWWHhXYTlRNVN3Zm8vQVN4UWo5d0w2OG14M3BFcWRXZHFW?=
 =?utf-8?B?Mm5jVnZpUS9wdVNtTWYwYlA2UnVjRDB0Zit0UHVjMW1CZERzU3hsbzA3NGZv?=
 =?utf-8?B?UENwN3lOK2JDTW9QUitXRWxlUFRPaFJVRTg0ZEpQdHpTUU9kNjUrc0VFYXRa?=
 =?utf-8?B?d283VDcwYkVpTDh5VzJYTmFDQkwrckp6eDlSNk9xb0tjZmdQZ2NJOXJ5TEt4?=
 =?utf-8?B?VVZjSGsvMjN1d2Iwa2xKcWxsclRBeUpaeEdKMGJ5TjJudm9pN0FXZ0dMblhx?=
 =?utf-8?B?RTdJdkhDbHkvTzFXb2RRV04rcWV3WUlIUTJpKy8zREVYQXJ5LzVxTjlWeXMv?=
 =?utf-8?B?U3RRVGkrbkFJaDlVK2VZRWo5NCt2SFNBZ2xtZHBJVVhxTTBZeU43cGowTTFP?=
 =?utf-8?B?UHV0aTlOUkhZZzNnQjl2SzFyTU01RWZOSjdUVE5kRXlMQlRHdm12ZUtsVWNj?=
 =?utf-8?B?UUFHQ21xLzVjMTI5Rml6ZGVZcDliUTZrenlKK0dYOFdEUi8raVVNbWRqdTZn?=
 =?utf-8?B?a3pxMzZCWFcwZnZEM3c5Z1NNNjg4L2pqM1VnTG9IQUdMOWxwTlNVQWpEaGEz?=
 =?utf-8?B?RWpWRm5xbUlUT1RLUU9wSHVscEZMcUNuRFUyZ3dscHp1VC9WMlRLeWl5cTVN?=
 =?utf-8?B?aU1HNGJkMWFsbjFFTXAwYU80OTZzNWlJa2Zrbm95aTVLWTArN2FIQXBTY1My?=
 =?utf-8?B?QmlVT3JWZVpvRTd5VTQ0SmZ0K25IdkIvYTB0UEVqbjJseXNZWVdMWDRqMnNN?=
 =?utf-8?B?UUZndktPUlNDd0k5NDBRYUZWOEVWYlRvMmxsbUhLRll2SnpSYlJFYzVJRzF4?=
 =?utf-8?B?UllLT1ZJSzlyQUFqWE1zV254QjhnMWZaK3NncCtodUwrdjkyTWRKd0tlQ203?=
 =?utf-8?B?Y2lMMGVqWTNVdGkzUUF6V0F5MytzMUNiTmJKUm5JRjJpSDFSYktHcVN3dkhD?=
 =?utf-8?B?bG0rMFBkNkpTOGc4N1RxRFhqU2tSMGM4dkMwNEJJUVdrQjk5dVJEZm9SaXJa?=
 =?utf-8?B?T1k2K2VtTlpZeVg2cEg3VkxBRUhicG9DVThFZ0owL1BoSnlNN201emVSMFFw?=
 =?utf-8?B?anJoeWRCVDcrbGtaNTNWRDJJWEJwTjBCWHh3RjBydkpMdk4zNTZBQkJTVzZn?=
 =?utf-8?B?d3o3SXBtSGJWQjhJZkQrRnNOc09LakdtRGw5QVdBeGlnK0EvYS9EZy9MeFlB?=
 =?utf-8?B?YUhQSTNJR3hWL01UZnpycTVGN2FNTWVSZkx5OFRHS001enlSOFR2QVNHbXUx?=
 =?utf-8?B?RVZLYmdzRUpkZERoVFJraGQzSGZBd1oycStlbThQT0IvMHhUNDRqSW55T3l4?=
 =?utf-8?B?clA2MzB2S2ZEZWg0ZEhMZ0hscDNxTzZzS0wwZ05ZRjNRQXZtSGg1Qm5wb2p6?=
 =?utf-8?B?MVYzMExsVnVPbUlWTXVyK3RpcmpLT3RCVWxTenNJNmdEUVZSZmZsVHMwVkVl?=
 =?utf-8?B?dmUrVlh4Tms2MEhMd01pYW1BbHJ4aVNlZTFLcE8zRHFTbFlwd3BneGhXekha?=
 =?utf-8?B?YjVEc0xWTitQUzB6M2N3ZEhRS2pVQk1GTDV1cTZ6LzZ6QjV6bncrUXA5RmxK?=
 =?utf-8?B?QVhUS1pHMGpNY3B3OVlqaW5kdmFQS2w4YnFnRnV5LzBOMHNWS2JTUGdXcXV5?=
 =?utf-8?B?MVJjWENaS05qdHVoQWVjcjZSSWU0d1JFSnFsczhHNGxjaXBCcGNvS01kb0VX?=
 =?utf-8?B?WGpZbWE2dkl6endSMDRteTV2cytOTjlpUmdFVWFDQXNScEFJclhYeFJNMGpU?=
 =?utf-8?B?eU5ZbVdwYlM5WFNCTzJCV0trU2ZkUUNzYlhrNTdMSG9wc2NaREN0bTZSTVg4?=
 =?utf-8?Q?ySonk5yDySTI1NGGBhiB9QMTr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbfd8069-d936-4a8f-cc57-08dd5687059e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 17:00:07.2981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /lbJSIeDdF94yPDrismHpdgUzLMhIymdDouSrgN4RNToztnEAVxTzEZqi9xdaQ0Zfzx74/pguNjoNPTi/oW0hQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8170

On 2/25/25 15:03, Borislav Petkov wrote:
> On Tue, Feb 25, 2025 at 09:38:03PM +0100, Borislav Petkov wrote:
>> On Tue, Feb 25, 2025 at 02:17:20PM -0500, Rik van Riel wrote:
>>> Who do we need to ask to confirm that reading?
>>
>> Lemme figure it out.
> 
> Confirmed - that really is the case.

Hmmm... since this is for host/hypervisor TLB handling, this makes me
think that we should always be setting the ASID valid bit with 0 for the
ASID value in EDX[15:0] on all INVLPGB instructions in this series.
Otherwise we will also be flushing any guest ASID TLB entries that match
the conditions, when that isn't intended.

Thanks,
Tom

> 
> Thx.
> 

