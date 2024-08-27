Return-Path: <linux-kernel+bounces-303814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B718396155C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 19:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4958A282EEC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 17:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269411CF2A4;
	Tue, 27 Aug 2024 17:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ryN11fVw"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917D11C9EC8;
	Tue, 27 Aug 2024 17:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724779401; cv=fail; b=r4Pa/QBTCiRDirxAtkIoa2LB/PC7skV8xIupP72/sNHCe/xuanuOfkku6inmvZSNYqDjHdic5vkxrx/eItrL98JzXtiMSN9zkkfV0gtHa5zWtjyWXmDkZ1bZrLaOLxWmFMSS3wXzEExkXuWKRKfzQISSb1NMeww4j2QxZACsdOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724779401; c=relaxed/simple;
	bh=5N3sOmnvliqKmYDhzmjr9sraC/aZqxjkwTmsPMS+D+w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WBx4jYBwvj3oCtgJN4p77Clv8zkJAg1B5q/2Ix6jjTyPLkaxjWK2uKjdEGPeMDyCkqvlDeNhbtG9fquJ7Fs9LcU6eiw+6tGeLz2pu8JaOe5vncVv0Hj7UOOo+6H7c7N1rWClXYO1keFhOMfPEWn7mnRFBcU8GKSmytS8rAmRxwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ryN11fVw; arc=fail smtp.client-ip=40.107.237.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=df4INgG70jk1YZUfWE72P/6jYpFu6eG+G6vTUgezuA2S5wEJ03C8mvSVQ84Bmr3k0R3mASxALIn0Oh+c3wUvVTL31bBG8DHW51wgmSj3w9lFHWyJWldhyEE4tNqIubQVHaVxRYoO6McDaHjMyN3ml/OzWfEgkGZqwSGG9IjNyg/g4tQpKSfioH2OhzEIn7d31hBJIVkpve4WkvFIn3jZizd3vL9kKvniu+i7Almjw7cbJ8y8M4f8DCU3rPVJWEJLrBs+2aYl9C04Ww8qgp4wP7DnszLnE8ZtQ/g6CqUrEFw+Lg3gV4FaSSdbnqtdDm3MVoG1hwqwNvimcBK7pz8iQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RwBn17xHj7qBC9omspw+dLPxqJQgeGyPa0bszWBExac=;
 b=q1SNY8swRli+dZ1s6TUV1c78BBgAWUXJslRjkMCE0ZJJjO+sJG/zHDNcwsDr9YhvfIgZVsU8lDJWav/D5SKqD/vOsFiO4qOXgNwePfDE1Bee0dtzEYWvadPshageLd0vR0YkDKErAyt1T5uXzdniUSJj4QeJ2hjK0Tu3Xz1jajKrgFqxDQsBFVXEuP+4VZdPw9hb8FmQktoR6T6VQAQDPykNdizOxe5zW3HROmkA/Jnw9FIyUGqMirqab+4LiLXtMXfhw5I0fNoMMJBZFX9PmIZwfuEfKnsZxrlWNpyMJbtVSPHMxHXv8hs4pcOflFLy+iCdNifN5ve4sbsoAtt6jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RwBn17xHj7qBC9omspw+dLPxqJQgeGyPa0bszWBExac=;
 b=ryN11fVwOgEuORfz9+HtRC4VRGGkSvkK2/JAXgzvraUM2HjXWpA40/daSdcRP/wSVqb7vN2UJQ0U1nC73VdMSciEMgA9mFwO8BuJok3YozuPeIILBJtQHdJvUrKuyDGNllbmYrR7ABXBhXVgQsUJlL6VQ3YGhtNdUvH0aAhgVPE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ0PR12MB6807.namprd12.prod.outlook.com (2603:10b6:a03:479::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 17:23:13 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7875.016; Tue, 27 Aug 2024
 17:23:13 +0000
Message-ID: <ce42149f-d92a-4f54-bff5-6ee9adbf0c19@amd.com>
Date: Tue, 27 Aug 2024 12:23:11 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/11] platform/x86/: hfi: add power management callback
To: Perry Yuan <perry.yuan@amd.com>, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com, Borislav.Petkov@amd.com,
 kprateek.nayak@amd.com
Cc: Alexander.Deucher@amd.com, Xinmei.Huang@amd.com,
 bharathprabhu.perdoor@amd.com, poonam.aggrwal@amd.com, Li.Meng@amd.com,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 Xiaojian.Du@amd.com
References: <cover.1724748733.git.perry.yuan@amd.com>
 <d2a39a68666e2dffa8f0ca9ba32deacc722ea2b1.1724748733.git.perry.yuan@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <d2a39a68666e2dffa8f0ca9ba32deacc722ea2b1.1724748733.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0016.namprd11.prod.outlook.com
 (2603:10b6:806:d3::21) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ0PR12MB6807:EE_
X-MS-Office365-Filtering-Correlation-Id: 7116c6ec-a785-45d9-79ea-08dcc6bcee75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Vm8rNmdVbDFVZ2dhMmQ0K3hjMEJpbjVIRzZUZWp3WlVNaFloc3Y2TEtxTmRh?=
 =?utf-8?B?MXdVMFp5dW1BdmE0ZE1nS2ozM1p0aWtISVFvZmducklNelc4NlVjb3cxbjRs?=
 =?utf-8?B?MzY2Y2luY005YTl1a1luTTBlRytyQWlTa2g0UENFSlNOSGJ2ZUpUWW80a3c2?=
 =?utf-8?B?dVFvVkowR0xHbUVnYndNaEV6Wm1GTEtydEtjb2RtSytPWjRpc29UWlZzVjV4?=
 =?utf-8?B?b1ZXVVc2WUJPeDdEK2xFbVdkbGdtRDlXd29XL21NYjl2K0Jmc3dxTXMrOHFC?=
 =?utf-8?B?SEJyY1grT2VYWFBZY0pHYUxTbElaeVJPYk1OTW5vOWZaNmdYdUVXZURINzNn?=
 =?utf-8?B?czBoVkZaOVRoZ1hUZ3YzaVpyNk5peW04MWRlM0p6MytvSVhYS09Mam1lb3lP?=
 =?utf-8?B?QUJIYmVvRFRaaEMyLzBVLzlCQ24yU0w0TVRub1NONlhwWVpmT2hYNG15K3pt?=
 =?utf-8?B?K3NmVkIxdk95dTBvNmozVXhMTkJxQ2kyakNiRFhOc1lxM1NYRjd2ZGNPVGZC?=
 =?utf-8?B?VDNMS1U0RmxwN2tkTzMvUWZTejBZazdFV2JMSCtjYTZxS2pzakxKZXFJeEFy?=
 =?utf-8?B?R1VuTWFYMWdvQ245UitITUJiUTJmOElhY0dTNWYrWWtXUFNySEZYU2tSSjFt?=
 =?utf-8?B?bW1RY1B4R3NmVG5WWmZPL1FyQ0Q0dXFzSzZ0K2tvUnpCREtnQzlkNTFYMG0z?=
 =?utf-8?B?c2Jnc0FEWU9FQXhudTNoOVpDMHJud0MyRG83bHFRNVQxTmhNWUJGbHJvWU5z?=
 =?utf-8?B?QWp2ekhraHpzQXc4Q2FLYlN3V2EwRkVVWG5odHExd3pyV1BjZHp6TkRkTlJ5?=
 =?utf-8?B?cEtJVXlVa0gvakN4OHpselE2MHRQTlFtOWNBV2I4dDJYWDc1UUgxOUMzTW9i?=
 =?utf-8?B?K3AwaHQ2bWQxV0NOcUMzd1dheXdNN0FFcUVkWDZEZ1k1WWFXdnZtUXF1R0lR?=
 =?utf-8?B?VHF1dnVyTXRUTWhLa3hvSjk0N1A3a0RMQWlJMFVHeXBKTFluNE1GeUlHUGlt?=
 =?utf-8?B?OGl5dnJPTmhIVzRqWW5nelVSc0QrT3JNcDROVnZXUDUxLzM0dklIQ3llSkpP?=
 =?utf-8?B?Um9uZENiR0xCVmF6UnRFTXpNT0JmZXNPK2JnS1JRTXU4Z2t5SjBiMk5udVBV?=
 =?utf-8?B?allyOW5uTlFlNDNIdk5xZ05LUkx4clVTd2tsdC90MzN2NzhlT3hwdWkwOEVR?=
 =?utf-8?B?M1RXL1hla1hqYmE2L3U1RURFNURhdHhaT0hnbTRUVXBWTkxYNFNFc1BCVFpi?=
 =?utf-8?B?LzR0b3pDTk0zSkRFcHVYbEpkb3NtZmYrcjFlWjV0ZW1naHdIbjVPb0oxenFs?=
 =?utf-8?B?MTNWaXNIU1lCMHAwejNCbCtVZW9BS1RHUjNaZHRCVlRDRDBoZCtCdm9EQjQ4?=
 =?utf-8?B?REJpUzUveEdibVJTK0VsL0d3Q0ZiSHpTVG9nbXgwODNFTStDZmIyM0x4K2Nn?=
 =?utf-8?B?YjZWV0k5UWIxUVUyQkI5QVozZHRta2VFVzMyaXZqYWJ3WFFWYTU3VkQ4YXJV?=
 =?utf-8?B?cTVrMGwwY1hsUmc4K3NISW15WTFTZ0xMbkNibVN1bktFUUhWVWozOExVbEVl?=
 =?utf-8?B?T2R2VE5PejRROTAybDE5TVhnbWVLTnFlN0ZVU1lKcHRWZWpHUzIzL25lZUFX?=
 =?utf-8?B?S3FrN2lxbnlSd3ZkYk1GOTFNaG5DZVJrYmNOWm5yZDRTVmhDeTYxME1DM1g4?=
 =?utf-8?B?cWNCV1YwUTJTa1ltMTcrc0RqcW9MSmptZkhpeGtUSVBrK01SS3hndjl2TVl4?=
 =?utf-8?B?RUxFSWtxVVM2MWFxM3FoTEFCMHo2NFNrdVdoVWhIWkhXVndreHRucmRVYUIz?=
 =?utf-8?B?UEJRTW1PRHdOclFyOENYdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDc5VDRXc1N6MFlJNUpZT3IzcDVDSmtKRXVJQyszcGJRQm1lK2pLZklFVzBk?=
 =?utf-8?B?MEdNS24xZDhReDJPTk54NXc0VmtHNnd5b0c0cGY2UnQvZmtGa1pkbHplZFNC?=
 =?utf-8?B?TUhmcEwzbklkZmREOFNHTVk3UHNtZFU2MU5PdDdOeW9XSjZ4eEZNNExiRENk?=
 =?utf-8?B?ZkxsQnpxUDdYM2pUTDZrQ2V5MnpWKzNsd21CNXBoWGJuTGgweWZtNkVNbGYz?=
 =?utf-8?B?aFZqT0poR2FhQTMyMnNYOEtWK1hMQzA0M01RamFnOE9RT0k1NTJPTDFtdFkv?=
 =?utf-8?B?OVFibHNNSjU4QTUxMlBrTFhQWUY0TGlkU0lyVFp0RktUU21lMllRb3pTQUhx?=
 =?utf-8?B?ZUw3N2FBczhRZFpPUmNoNTliNGJzUlRJaFoyTGlIRHJ3V2JBU0Z1eURZSSti?=
 =?utf-8?B?SityeWxaR2RrdC9ydEdSdjRTK0J1NW44OWZKMFU2Snh4eU8rTVBJUUFXck1Z?=
 =?utf-8?B?NHNHL2lYR2p1a0Z3aTlteThpVVR0TEo2akR6NWNxTWo2UTRhdDY5bHRONVMy?=
 =?utf-8?B?ZzViTXpGb0dsOEZyMWIvdEl6aU5mYUYzREtJWkJRT2VBS1dlM2tiSk4xMnNa?=
 =?utf-8?B?dXNmdFdKcXJ6S2dkSDZ6Y3dVWDl1VGE0L0drb0pWTnRnN2lCQjAwcnpKbkZt?=
 =?utf-8?B?aHpaVytnMEhaaS81Y09hSU15QUsvQm5kdksyNTkrTWE4MU5Zbmt5ODVlaFEw?=
 =?utf-8?B?MWpBMm8rdTdmOXd5QmhBd0tJcERxcm1pTEFVTTlSUUxPd01FRTQyRWl4SUtr?=
 =?utf-8?B?U1BYNysrcXp3eWsweldUNWFDdW9MT3RFWUFDWDg3Vzl5OHdHMG9GRWhtUkk3?=
 =?utf-8?B?TlBpWHQvTUNjWnJpQ3g0b2w0cUE4ckY0Y0p6WnFVUkkwZC9Ya0xpVkRiUlVL?=
 =?utf-8?B?ZjBWWmdyME5MNTRGMi9UcXFQdEJrWUJlTzBUODg3ZXBnMUN6bnNLMm43TE9j?=
 =?utf-8?B?eHdHZE0wdzlsNUYyS3l4RSsxL1BUTDhhNXpGR3ZVZFJobCs3S0tINExSWEhX?=
 =?utf-8?B?VXR1ZmpkOTBpWS8vWkVqVmpqZ05CbkRMZUNWY3JiQ1VsTXkydGFabHI5Snc2?=
 =?utf-8?B?UHU1MGp0elA3Z3FnVnJIaUZueVBZVldjeFJXeExyeE1KT2MzK3pSam5YSDZx?=
 =?utf-8?B?RkpZSUpzOUpJSXBXVzRHVGtSQmZhMElNdzhFSTFMU3ZmVkhMY0RhajF1TmU4?=
 =?utf-8?B?bXdkZTl3d0R5N3M3UHdYck11aGJDVGhuVnZZcUdQQjVoenF1VmJsdmN5N0xh?=
 =?utf-8?B?cWRic0hCelYzcGwvc2xidlBCS2p5ckc4ZWFnOUZIR2dEMlA1N08rN2lGYnR5?=
 =?utf-8?B?QUpmTWxjMkNUYlpXUy9BTWdrMmpSY0V0cDRrUWFxRzJoelM3MXVsd0VJalBF?=
 =?utf-8?B?Tk5jcVYydi9Kd2QvOEMxU1dyMDFET0FwSE5JemlnRUZDN3VFTGxOSGNOMUht?=
 =?utf-8?B?OUNQQjliZmNCMTk5LzF3M1IycVJlK1FnQ2d6TjUzWHM1RWhkT2hrVzB3enpU?=
 =?utf-8?B?UWttM2VpS2Z2VC9DWmpyS2Q0a0NGNTlERkZCZUcrYnUxSXBzVStjdnpIb1Ry?=
 =?utf-8?B?UGdBTXphY3hXMjNjR0NIUUE2WEVtUHRHWFpKR2NKUm5TYmFJeGExT2Qwelpx?=
 =?utf-8?B?RDZxZEVqM3RkaWJQckxDM3pXMGhDL1JVU2gyNzhVcDhrUzBkRUZhbVRUU2U1?=
 =?utf-8?B?MC9JQlo2dXNieVJtNGFadmlwY2RPWDBkdnhabFFsVlV3M25KU3NnbDFrd0U4?=
 =?utf-8?B?dTNBTTd2b0JvZmc0NzdpMXlybytneVdPaWRWWG0zWGFBUGNOMklnSDA4dnB0?=
 =?utf-8?B?VXRPRU44S0VKVnFhcE9lWWp4K1ZjZ2x1ekhsdi94TWNJa3JFSVlYS1J6M3pM?=
 =?utf-8?B?TUMwN2p0M3UwY055dERNUXBlaHRWMUhzVUpPSkRuVUtsdFNLL0cxYi9GamM0?=
 =?utf-8?B?aXZXS1lYWnhpNmt5c3dkdEljU0NPdHdKS0cxZ2dIb2JWcWN0VlB0OVpJdDlt?=
 =?utf-8?B?Y2w4VmhUTVJ2NnpXcGM0Sm5ocjFIeFhxSUxFTTZPeUc0c2xxWGNuMnNQa3Ry?=
 =?utf-8?B?N2p4L1BNTzB3S0Y1am1Idm94bzdTTUFVbmRCL0F0RmRLR3hPYmoyVlBzeGIy?=
 =?utf-8?Q?1r3tPBGeVrZVhQaSBeLdJ11vu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7116c6ec-a785-45d9-79ea-08dcc6bcee75
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 17:23:13.7901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3zy+k9DZcSSJg/5Fzu3w3Q37yoZW6sky1FSVRmpB70t72q0FlvWnG5zN01YYa4ZBJBIakV4d9hFo0SPF5bVNjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6807

On 8/27/2024 04:36, Perry Yuan wrote:
> From: Perry Yuan <Perry.Yuan@amd.com>
> 
> Introduces power management callbacks for the `amd_hfi` driver.
> Specifically, the `suspend` and `resume` callbacks have been added
> to handle the necessary operations during system low power states
> and wake-up.
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/platform/x86/amd/hfi/hfi.c | 34 ++++++++++++++++++++++++++++++
>   1 file changed, 34 insertions(+)
> 
> diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
> index 57b642c4c522..c3da2edf8590 100644
> --- a/drivers/platform/x86/amd/hfi/hfi.c
> +++ b/drivers/platform/x86/amd/hfi/hfi.c
> @@ -304,6 +304,39 @@ static void amd_hfi_remove(struct platform_device *pdev)
>   	mutex_destroy(&dev->lock);
>   }
>   
> +static int amd_hfi_pm_resume(struct device *dev)
> +{
> +	int cpu, err;
> +
> +	for_each_present_cpu(cpu) {
> +		err = amd_hfi_set_state(cpu, true);
> +		if (err < 0) {
> +			dev_err(dev, "failed to enable workload class config: %d\n", err);
> +			return err;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int amd_hfi_pm_suspend(struct device *dev)
> +{
> +	int err, cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		err = amd_hfi_set_state(cpu, false);
> +		if (err < 0) {
> +			dev_err(dev, "failed to disable workload class config: %d\n", err);
> +			return err;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(amd_hfi_pm_ops,
> +		amd_hfi_pm_suspend, amd_hfi_pm_resume);
> +
>   static int amd_set_hfi_ipcc_score(struct amd_hfi_cpuinfo *hfi_cpuinfo, int cpu)
>   {
>   	int i, *hfi_scores;
> @@ -569,6 +602,7 @@ static struct platform_driver amd_hfi_driver = {
>   	.driver = {
>   		.name = AMD_HFI_DRIVER,
>   		.owner = THIS_MODULE,
> +		.pm	= &amd_hfi_pm_ops,
>   		.acpi_match_table = ACPI_PTR(amd_hfi_platform_match),
>   	},
>   	.probe = amd_hfi_probe,


