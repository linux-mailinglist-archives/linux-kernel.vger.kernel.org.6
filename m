Return-Path: <linux-kernel+bounces-550305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B78A55DBA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 03:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C22BF3B1E7C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 02:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51E216C854;
	Fri,  7 Mar 2025 02:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ddBA3uQT"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2076.outbound.protection.outlook.com [40.107.95.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4BA1465B4
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 02:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741315064; cv=fail; b=ejU9FtJf9i85TUnucuLaWquAv2a9mw77QDeIW+TZxec9Vxfp3qw1FjCm7QqtF8TbIWeN4zzpwFW8bCD99qoY0koaKA+RMaiuz4GVrDQKcRyVh9Uj397IpbZEqO6E31zLhKzWmbSoNph8IsbU7R4R9laWK6GIvPo5ELLz/a5ViLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741315064; c=relaxed/simple;
	bh=KznXFk47V84JXurHmFDy89MoS7kqWpq3g99G505n7to=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t3rW41SrUvezUiMA8o++xgxITbek5K7idvwK/fWcv3Nbpf1LO8KnOpQaTSlq30UyoUiu+wydzNDmDAp75D0GxcTBYKbLfd/3Yxtbp0pHs9towWEbZT0mZcbcDedONRQk8enm6rUQgDZUrU56fJQikQ2dk20qFrrfb9cVPs5iWgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ddBA3uQT; arc=fail smtp.client-ip=40.107.95.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y2RKW76N1QNgB2dzulBjwdxP+42dItpUsUAzC55o4VqGL0ZtFsg4jJIml5Uxzeb7W01jBoM750HAG712c6ZrpEo9m/FxaFqexPxNWHdsvsOuDXjund8soDlgi5xiN3cwkg+ajt/JOOsxq82PLkOioMsldhZEoswmmPQv+1zZgNI0JugQwvFa6+A4ndin1PIfQIHsJntETul9izmZceTf4ekFi+JEPtPI2jeu5y4LgVgdxFBrlfEvzf881bm65dfteb1zwiaF1CFXsRRlk6zKNPF4XXGm9aXKv6vPLX7mEIuO2xMr/AiWm9jDLcCLa34oh091PFmfiBdnDexQmxCmlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yWddirDP24ADT5JJyUVjf7hh9JNXlCo9pMdnAeuqZlE=;
 b=mbImVFJQQLmPwAtjHX7sTK4224OBvH8k2ARNbBvlxE8ZdqEVFF8jf7CZMeBp20VFo3aYirQdYdys0vVT33p3OWpMYBqRs1Z0sVHIrBn2Jy5DqXtdDpS4j11/ITJEJhPPpNjVJHomKgA7BmcuRo61OkWNYE1HpuZTorOOksniPeSOinAqjXQY+PHmZo7cZD05nGJY5LDpgVPESdzLfqgygbbasivFF2XuMSV+shRU70gB8B2QRHI56+pRaxn0Tf4iRCAu14XNCFEixUo6YZv1OQ0xBtd5z4CHXs5QlrqCKCm5/txE5m7qBpL0gLRcJuHvaydPO5tPF+xZ/0Mf8MflXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWddirDP24ADT5JJyUVjf7hh9JNXlCo9pMdnAeuqZlE=;
 b=ddBA3uQTL+H/jeiB5MQ7J6MNUV0HL5IDleShlxsKgxd/S77Al0fcjfYkX6g5f7PtiXtXLazoxP6yhnDRwwaj2M2HsRPzBWNbGi9qzbjEY7OZSWbinw6gxLtqW6Vmmcnn8qiMB9glSe0S+p334rnnUnncjpRUbCP2lFHpZgzc4ZyMVov+Jp6i/3yk+oekvmnAlTz7vKEjOoHVZrBZGs7HJ7kju/ylCkEIfOEYFEl4mrCsjrQQPteqEUVrt3nT/2iNRi2YFtpoY6Xe5gEVJ+MUrKXOG9pkxO4wXdGlvYBhlJRRj/8q2EgBMy7psHfbJmHPOaUhuszxJG3lNU5MOIzmhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 DM4PR12MB6448.namprd12.prod.outlook.com (2603:10b6:8:8a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.17; Fri, 7 Mar 2025 02:37:39 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%5]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 02:37:39 +0000
Message-ID: <f6f98abb-0d4c-4e41-8c83-a3ab919a8fbe@nvidia.com>
Date: Thu, 6 Mar 2025 18:37:36 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 47/49] fs/resctrl: Remove unnecessary includes
To: James Morse <james.morse@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Reinette Chatre <reinette.chatre@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 Babu Moger <Babu.Moger@amd.com>, shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>
References: <20250228195913.24895-1-james.morse@arm.com>
 <20250228195913.24895-48-james.morse@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250228195913.24895-48-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0051.namprd07.prod.outlook.com
 (2603:10b6:a03:60::28) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|DM4PR12MB6448:EE_
X-MS-Office365-Filtering-Correlation-Id: 14f71ac1-8df7-4140-d6f2-08dd5d210724
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q3BkYkk4T1JieENtblc2bDgvL25CM2UzYU1idDNEQzRWSXF5b21UVWI1RVJJ?=
 =?utf-8?B?MGJpa2g5OG5rYlJnZjFydmxyblRpTzdvSGNHS2FtamZsUzdDc1lZeGJSNFZs?=
 =?utf-8?B?UnBYcy95di9QZkI2TFAvdXhLYlBlY09DQWtZU2RFOTlKZy9mcG5LY21RT0Nk?=
 =?utf-8?B?RmpuZjdHSXRGTjBuL0dpazZnejcydlF2MG9GNk44bHZVTUd6ZEcyTHd4T1FJ?=
 =?utf-8?B?Tm5GTWg0dnFaRmVpNXppREdQYWZLZWJ6bE1FYnk3Sk5xa3p0QjU4T2VqeS9s?=
 =?utf-8?B?YUtmQklKcVF1SkdOd3o2MFFaNVVPWHczMVgxcGk3UGd2MVdHOTFielhQM1Ey?=
 =?utf-8?B?K0hWQ0xwWmUycDRGM2NLNWZGWUtobm9pVlhQblZZVnhPYm55OG9XVDBXZGhD?=
 =?utf-8?B?TTlSRUJVeGowK1V0MEFHTmRtTDliTnVQQW9EMHRlYzJYYnEreG5kL1ZsNjVL?=
 =?utf-8?B?VGhvVHh6VTlIYTRPOW9LcUJLQ001YzdUOXdHaXdKV1FVSXFOMTVJVENoaG1L?=
 =?utf-8?B?bFBkK0kzWVlpRFJmM2wzT2thZEFIendRczFnaGNFREg3eWVWM1ZHZ2E2L0dy?=
 =?utf-8?B?RGp4Y2tIN3pRUzJYRE94dDQrcmtYaE5mZFRRNlF0eFlSYkQrY3V6ZFNFOFF6?=
 =?utf-8?B?TnNPaXd4VE5vMG5YMitQWWFGaEZRUGhhYkNQMzNjWVZnU3J3Z0ZtQ2Fna2lu?=
 =?utf-8?B?Sk9MUWU0eDIrZzU5bitRcExWVWlNTGdxVmJQV0Z4bEdMVzl3YTEzSnVBbmt4?=
 =?utf-8?B?eDB5TXhBUTV4RVFramRSTDczeVk5TG4xZ0pibTh0blltV3ZCQTF1ekxCNVRP?=
 =?utf-8?B?cWJxOVlGWVl5NUU4eVpOTGVJT0NDYWhMVmpFQUJzcWowY0phTlh0T3Z5QXNn?=
 =?utf-8?B?VTAyK2JzQ2VZbThQdDkrTHRTTlJ5b0RHZG95aXRWMW43NjFpODZEa0V1bnIx?=
 =?utf-8?B?WXZxbzlYWjFrV3JBYmRxWVJnQkUrVzd3NXFpZlQ1WDcrQUY1K1hSbFl6alc3?=
 =?utf-8?B?bFU4OWpZWEh5dDlVN3VrRzJ0a2RLc0FZOWdKa2FzcGdoREhJaFB6T0lnU2F6?=
 =?utf-8?B?NXVITkxQTkhJM1lpd1Q2SC9tSy9rQjZDU2RQakhGalhvRkgwNVlXLzFFbTBL?=
 =?utf-8?B?VUE2K1RGTmhZNjEzMjZ2TVNyeFd3UmdSZmlKbDlyVFdnQ0ducDk1cSsrcXMr?=
 =?utf-8?B?UHVla3lJUWtxamhEc2E0T3NiZHhiMHBLcjk5NzdLeUcyWkxNcEdndzMzWUpF?=
 =?utf-8?B?NTJJZEtJR1FLd1dQZ0FtODZvM3VYNytjOFgxQmZ1bFBwVXFSUENLUWZoWnVi?=
 =?utf-8?B?MTRSRUY3cjVFNVFkMlRXUlh1QXV5S3RNUEFzOFFiMFhESXV3UlBCNXl5dkJ5?=
 =?utf-8?B?S3loRlU4TDh2S2NRUGhpYk9xNGp6OEs0UCt0aGdyaXpkQTRqQ0RzYktsTW5U?=
 =?utf-8?B?aUh4T1J2bjRrakRVcDJjb00reUxRcUttaVJpVHBqdVpzRzBiWXhWOHh3NWE3?=
 =?utf-8?B?T0MzNk1HQjFYTCt0NTdKLzdFNFhsTWRNTlowNUkxa3RaYmpoWlNYUTRmcDdD?=
 =?utf-8?B?RG9KOHZMZWozdjVJNVpqQzJoVHUzcGJCTlV1Vkx3d2EvN3NGMGsxd201cm02?=
 =?utf-8?B?UFlsakNneFBFazk2c3J5cmNMWmdwVE9QRUNtMVJYN2gxcmg4aEpob3R6a3lU?=
 =?utf-8?B?cjF4ZllnWHNGbWNtbUR6TTdTNUR5ZTZBTjVyR0cwdFlyV3hheVJoMHpVb2hG?=
 =?utf-8?B?OEJ6ZS9nMlg5TEZ0elArcGN5bUxXeUUzd1RTTGlISFJDdml0Zi9DWUVMUmcv?=
 =?utf-8?B?OHJCcjRONmxyUnBSV1ZSYUR3eHlZUjRjdHRFYlBCd1NzQ3pQcDFXM29GeURM?=
 =?utf-8?Q?FlLGsoOs8Ll0W?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WlJTS21URUNOaEViTkRxV2NJLzZCOXFEc0tZd09WSFZLZ0FtMVVCRHJyRWlK?=
 =?utf-8?B?UUE0Z1I0S2tRQnc2dFhpQ1VxQi9xS3NUNWtLQk9tcURLMkZwZ3BHWTJKOFV5?=
 =?utf-8?B?TkQ3ekFlUW9JQzdlU25CZVgvNlJReCtHTnd2YklOQTI2Z3hTRko4MCtZQmpV?=
 =?utf-8?B?WjdtTTBEQlprNWFjaDJUK3F4SVVBMW5OY081UWpWOUFoUUUwK2ltOUtiSkw2?=
 =?utf-8?B?UDVHWVZzeHEvWmpiVGdlQ2JhK2YwcjF2cEkxbkZkVnFybm4zYmNKRjZVdnpE?=
 =?utf-8?B?cDNvR2pINmNPcFJvNGUzdnNhUlI5TlF1dHNHa3lVNDcrOENSZytwOHdQZ0Vy?=
 =?utf-8?B?Vm1qcUszbjR6TmVySktEdlVvQzR4cjVqTGJqbDBYK0pZcTErTGU4UHBaSE4w?=
 =?utf-8?B?Q1o3N1RQUGQzK2dNdXgxaGYwTGZoTHBSazdxblk5LzAwRHpXYWozaEJwOWtT?=
 =?utf-8?B?UEV3cHBQTWpxdWJVT2toazVhWHRLS3FwUzY4RTVyakVGMlIxbW1mOUxsQWx1?=
 =?utf-8?B?R0Q0TnMvaTZodnFJQnlsVWNBLzljSFd4YmxZeDVpbVlpU0Q4S3VOQ0ppY1B4?=
 =?utf-8?B?bmw0dk5SVjdYUUJoSVZmbkJPZEdIMWJkaEJFb3FrRzE3VlBWY2pMbzM5dU50?=
 =?utf-8?B?SlBlT3EwczhaTEVFWjR3c1IzTi9hbmQ3b09oOWhqT1M3Y2RnRUdRU1BFclVz?=
 =?utf-8?B?dGM1R3hkZjhuSW5lU2t0a2tSMkF4TDMvK2xLZHlmRUUzLzNQWllvQ3NLY3Nu?=
 =?utf-8?B?eFlCem5ONWpLRCtrQ3FnemRCNjZsTTZaU1Y4b1ltTkFNMzdGUmxnektOQ1Bu?=
 =?utf-8?B?cFhISlljOEkzMlEzTzlRWTAwakU3T3pjZDg5eEpiQ0JINTQvanBvZEFLUksr?=
 =?utf-8?B?bEtCd1RUZFp5bE1icUlRSzRPYXJOYk9yMmpmSnRUWXFuWkZGcnFnbGpMK05L?=
 =?utf-8?B?SnY5RnVuR0FrWmhuWitUUUE1Q3EySGlpWU0rU1gzeEp4MDQvMkFtem5rMVMy?=
 =?utf-8?B?TTFBODErbmtiRFNxVkI2K1ZQNGd2S1lxN0RERy9zN2FIem1mN1hBRGdvWXFu?=
 =?utf-8?B?ZlVjYXNLdWpWNE1Oc3hnclkrWnFOa0VXeG1iVmpFMEFMZThpWkNJMXFSK2lX?=
 =?utf-8?B?dU1YekxxQzlyL2xwSU8vNkRjbjAyYXFaK29BZmpwWHAxaU5xQmVGK2FpNW9n?=
 =?utf-8?B?VW1FUkxwVGpzcFRXdHUwa0wxaVp0MHcxcCthdy9XRkV4dEZrcHVWTE9tYi8v?=
 =?utf-8?B?Zm41TitaZEs2dWs0VzVoNHNsVjlGaWVUVXdjclEvYWtGMGc0Y0xaM1NTZUJH?=
 =?utf-8?B?L0pGUjRrZTRYY1h6RmJQUlY2SHVnalBWZXQrUWtkZ2Fab2Jxcm80Rkd0VTNV?=
 =?utf-8?B?WkdBbFZub1IwTkpqOUFPR3NRcnNTWHROKzJ1RnZmYWZSdEJXY2FyMHlndVBD?=
 =?utf-8?B?Ry9wd1Q0M0JwNGxYT1AzSVRQY05IN1ZtRlVRcWJBbUpYdHNmSXBEbkdkb2ZP?=
 =?utf-8?B?ckk4ekYyeGUxbmxIWE05aGo5SG43Z1VOTFdzT05vVDNuN2U2UXgrenV0a2Uz?=
 =?utf-8?B?cFJDZW9ldlF2NjRGQVJxT3R4NENFZ2xTcThmZC81VnVXMUVncEVuSXlZRXNu?=
 =?utf-8?B?YzZFbmxaL3cvV2d0cGFOR3MwdStNaVZxbjdYT1EvTGlhN0FYSVJ3NFJ0NVIz?=
 =?utf-8?B?WWQydUVXemdQQWNSQ0dtaFNBczVhZ0l3NmZhbGN3U3ZvT3F2REVQRGhtSkR6?=
 =?utf-8?B?a1BTVlM3MzdUcE9pdkhLbWpYcDNYZjBSNyt3UHZKdkl0TmZVSmZlWjg3YnVS?=
 =?utf-8?B?NHYvZGFsMEhrbmlPMzVGQlZaSjd2R2dZVXBjOHIweWdzUGlyOUt0N1NzYW1X?=
 =?utf-8?B?OFZXa3cyWWVodGhBaS9PVXJXMmFiM2hzNzF5a3p2VjU3RmIzTS9hZEMzbUwx?=
 =?utf-8?B?YnpFMTRxa2N1alh1QVhueHJGTkhoN1kzOXh5VE40VWUyZnAzc2ltU1lVVXpG?=
 =?utf-8?B?RmVXa3N6L0ZxRkFkOGU0ZStkMUd1MXNWQVR5UjJOQWNvMWRZdUQ0Y29NbVBM?=
 =?utf-8?B?dFRwellrN0VRWkxmV2NDQ1daazNEVmp5NjJLVUtpU0Z6anIyejJNUVhub2dz?=
 =?utf-8?Q?9EGCvn1qAAq3dbXO37qgaBYfP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14f71ac1-8df7-4140-d6f2-08dd5d210724
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 02:37:39.3596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wPpAGol6zfZqXNv1qAmTvi8pG+SSyx/22uPsc5a4PBAouQBRk0l6kTCDr/+wCxqMwDk5eVYQpTDBv7mVBZugDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6448

Hi, James,

On 2/28/25 11:59, James Morse wrote:
> When splitting and moving the resctrl code to live in fs/resctrl and
> arch/x86, some code was duplicated. This was done to keep the parser
> in the script that does the moving simple. These extra includes are

As for "parser in the script", my concern is people may forget or don't 
know the context of the python script in the future and get confused 
when reading this patch.

Is it possible to merge this patch into patch 45 which introduces the 
macros? It simplify the patch set and avoid future confuse?

> harmless on x86.
>
> Remove them to allow other architectures to start using fs/resctrl.
>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v6:
>   * This patch is new.
> ---
>   fs/resctrl/monitor.c     | 2 --
>   fs/resctrl/pseudo_lock.c | 1 -
>   2 files changed, 3 deletions(-)
>
> diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
> index d37324f9f95f..3fe21dcf0fde 100644
> --- a/fs/resctrl/monitor.c
> +++ b/fs/resctrl/monitor.c
> @@ -23,8 +23,6 @@
>   #include <linux/sizes.h>
>   #include <linux/slab.h>
>   
> -#include <asm/cpu_device_id.h>
> -
>   #include "internal.h"
>   
>   #define CREATE_TRACE_POINTS
> diff --git a/fs/resctrl/pseudo_lock.c b/fs/resctrl/pseudo_lock.c
> index d26cc1a2a84a..3bee26b8c07d 100644
> --- a/fs/resctrl/pseudo_lock.c
> +++ b/fs/resctrl/pseudo_lock.c
> @@ -27,7 +27,6 @@
>   #include <asm/cpu_device_id.h>
>   #include <asm/perf_event.h>
>   
> -#include "../../events/perf_event.h" /* For X86_CONFIG() */
>   #include "internal.h"
>   
>   /*

Thanks.

-Fenghua


