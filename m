Return-Path: <linux-kernel+bounces-336801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8271D984108
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 10:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 458D6285458
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCF21527AC;
	Tue, 24 Sep 2024 08:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="HPmP45bK"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2120.outbound.protection.outlook.com [40.107.255.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5D514F9F7;
	Tue, 24 Sep 2024 08:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727167715; cv=fail; b=ZkM2YbJx32ESbWL/wJgl59WZTECFzO5rDAqrKaZEy7sRUJI6guqviT8ZHuNdwWiDzHFmQ+QHRn2q5L3Kt6LV+v+oFLU6RJAeVy6CGU88hmm9+hnEdZQwd4VcYZ2OH1JjdoQrDUAksU631IM2DZ5K+Z3wfmSVPiPK7MnhvIWSw/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727167715; c=relaxed/simple;
	bh=X9tLeceEMc7SspvnQaDDaUPAZwL9nPXLSHQuvoZygyA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nh1NwzI6CGWTVP7MfP5qW3HYLvXRy8OA/laJwwV7b9N2uspj0KcJeDmFmJtuOKoDUcTv1v1kj5Jtf6jJ83WWtohssj4nW14Gy6w5EMx/Wm162TTt8qkxAVr8siR2PWsbtmUzT+rktlCjFNso5AsBJ/i90L5oB02C18xgHRemteQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=HPmP45bK; arc=fail smtp.client-ip=40.107.255.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bfLwRk5OU1LSXrvwKI3B3uVU1MfzncE/TL3phFk7G4G8LmtMGSK0pvKM3d677TRYSZwOmaK/bygfvp8+mIgevlJaJFQKUdA/f3ffHJk+r1eZv2PWVbffnT3VNSv7FQe+pMQSRE/pEmgw1sVjmn2ItwAmPi6lOZMJfXmjYX73+A0FNbTiEOCMSKQ5fl3KszXY+2JwT/enshwP8E9Mrx3rVaa7vzoorKxA78FqHxw5eFLci1aMVlAwqwAvI9rNHUYrqBT+ACld9S31UnLfdCbEEhKD4aVJ4FNuKvheeT5+52r3ZKgWdlL0C40HH6Mk0aSA4K4yRuqODpcn8+QHCnfjXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SHLvkQeom4kr55XQULqM/d+lQ37sC8PUiVG71WueSjQ=;
 b=rprz3Ctu5CG8vp9L8ISPxot+Vko+5FMq9JBvt9c09A22vlHCYtphuBK8lRKbIhJHasWmrnXtyrSccsSkH/491aEREbbqxOGx6HEXubr8n6YYllacUtYilp1Yz25EBQK7BuoYU6JkKqgrs768CK1f8qcDdYYfHR028pi0GJJbkrmiyf8TLIP7G835ylrGsIOBgOGLouM43w1+pXl0qKA+/xRC7VQQfRW6mTFBuTcKnDHMU8WiIT9lmzBzlhsRkrttG2baTxwoE0F5GJc2Yrk6bxsalu9TRj+UV0lYJzt9qxCUfGlq8OWEiZWAwKfU42sGuAVw4hAm7pavdlEKz5ePGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHLvkQeom4kr55XQULqM/d+lQ37sC8PUiVG71WueSjQ=;
 b=HPmP45bKEGqxkl8kATVuSCZkQcPOCB/ERWIczzzIGdjcB9j6w9p/vOgEojfcI3f/lagdAmUmYxhxKlkb24egBiDb9H6HrszRfmccViu7O0tg0lThTFVMXhUhjgNwIIRNrtplGeL+pMPSJ1PUCfaw6pehWJ86MsteGBsgI1gdcRoONfhaRMwcuzoePrZ0SkhL4gEI4GEfSPAEvjT8NAsPWdqJxcsBeMvu4x9AuMdTTQCkNobaOEFyMef40Kjb4xwhFziPcEJv8GrA7XRPgEzuXLrbGH1w+EfQUN/yyysWkvAF13eBKfd3GJjn99N05MgR/TZ5DKYWMCfXC9uVulHAwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com (2603:1096:820:6d::13)
 by KL1PR03MB7598.apcprd03.prod.outlook.com (2603:1096:820:e0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Tue, 24 Sep
 2024 08:48:31 +0000
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::9d11:d1f6:1097:22ca]) by KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::9d11:d1f6:1097:22ca%7]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 08:48:30 +0000
Message-ID: <a5266439-8dc9-40e7-8708-f5b2e9b3c556@amlogic.com>
Date: Tue, 24 Sep 2024 16:48:00 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] clk: meson: Delete a meaningless spinlock from the
 MPLL
To: Jerome Brunet <jbrunet@baylibre.com>,
 Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240920-mpll_spinlock-v1-0-5249a9a7e2b7@amlogic.com>
 <1j34lpzbxr.fsf@starbuckisacylon.baylibre.com>
From: Chuan Liu <chuan.liu@amlogic.com>
In-Reply-To: <1j34lpzbxr.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0053.apcprd02.prod.outlook.com
 (2603:1096:4:196::16) To KL1PR03MB5778.apcprd03.prod.outlook.com
 (2603:1096:820:6d::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB5778:EE_|KL1PR03MB7598:EE_
X-MS-Office365-Filtering-Correlation-Id: 48777223-f5d0-4b47-16eb-08dcdc75aa44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UlNUN1lQN2wvNXZtS2ZVbzVzZXVEdk5PQXNkWmJONnVwN3k3M2lHZk1icEFs?=
 =?utf-8?B?N3hoc0lQaTVxU25XcU9ra3o4NTRiTzlKRit0eFFTQlNWYWNRQi81UDM3bG1o?=
 =?utf-8?B?NjRwSE96cDd0eDhUcFh3N3hKYnpPZ1hTNUtjL2dEZlV2TFNTVTY5Y1lHUXd6?=
 =?utf-8?B?V3hna2w0RGRRVFhBL3J6NTFLMFFhRkNtbEVDaXl5Q245U0IxaG4ydW14OXJ2?=
 =?utf-8?B?M203VDlwaEJrd1dZY0Jya2RVNjdSK3NmS0paYnBTMStOK0tlOENRNSsrUE5N?=
 =?utf-8?B?dXRsQ1huMXRQeFYwUEZZSHVZRHA3Wlk3RjhxTFVxTnVza2VNbmN0VGJwakc0?=
 =?utf-8?B?NlI2L0FwS3FjeUE1NGRKN0pGUytwMTE0anBHeHhlQ1cvektkY29admxkM1dO?=
 =?utf-8?B?cFJTSmh5ZytwNWt1N0dBRUdzVlNHanJCcXhkZWs3KythaFlNamFoVlFMakNk?=
 =?utf-8?B?bUhTZkFTZ0xZY2c4Zml6cEVodEZNSVFxVXVrM0NNcVFBcUhKR3o0QmpEeUNl?=
 =?utf-8?B?bEd4YVduWjdBMmRUbXg4Lzdoa0l1QWV1dFZ4WUlUOFllNCttMDBIb3o1RHgv?=
 =?utf-8?B?Q3RjMkpoMllINzBubnY0UGkzSkY3MExOTGY0UUo1VE5iV0ViRU5CcDYyNjd4?=
 =?utf-8?B?eEZWV1lnYXVMN1pVU1ZFRVVwWE1VM3VuamRoSUpLTEZ2T3VFMzhvaVJScy95?=
 =?utf-8?B?aStlM1FyTUptVEZOT1Z5V3V6MmVMemJlcTFhVUxjVFdpaHZRbmZiRkpyWVdM?=
 =?utf-8?B?T2NLUW5lZWYwV3BwYWVSS3JWOTRuelM0Y2toL0RDa1UxTGF5S0d1dWpJbGY5?=
 =?utf-8?B?UGhmUWh6N05sTXh4OWhGU1RZVm5qd1JUcnpKTm9OdUQyalBzRWZja2RGUnBx?=
 =?utf-8?B?VHhxWjFUdW9HYytHYWZqNVY1RWs5cnFIeTJxSEYrZ2VKSjR2ODYwV3VWVHhh?=
 =?utf-8?B?MFp1cTVxVFYyaWJHbGpwVk5naHBadmRxbWs4R21zSWRDUi9YZDNwYTQ2T2M2?=
 =?utf-8?B?ZXBGRWh1MTZhdDgvMlNyeGwwc3l2dWd1KzBLRkNzdzRKRTVCVFJHWlRGNzNL?=
 =?utf-8?B?bzEvclNjZmUzaEMvUG5tQ3FuWFJEMkJndG5Ec0J3ZFhRSUtnUkdaSTVWdk1q?=
 =?utf-8?B?djdkRXdNdEtTai9EdXkzQ09UU0thZmJKakV4eTZYNFc2TzhsWXlRK0dnUjYv?=
 =?utf-8?B?VSs0MTVjWi9WRnBVRUd2YTNyeUxad01qS3dSeDR5VzJLMVpXUEdnQ1lqZmNs?=
 =?utf-8?B?d0NWWk85VGFVemtwVURWblpraFIzc2VMNW9XK3RpWlN4Y20wK20wSXNhSUdJ?=
 =?utf-8?B?c3hjdG5uZ3BKSjBhNHhJKzFBKzFuQXpkcWdxdDJTMXpKd1l0Z3U2OUxVbkR2?=
 =?utf-8?B?dTBNRXNHNDBBRkFmRkQ2T2xEMnZGT1F0cFpldUZ1S0ZNV0J3R3d2TnBab2hM?=
 =?utf-8?B?b0JqWnptY3U0SFJRYnNHNk1xQUN4SHA1bHArdW5JWTdIVG1aVHFVOEtlQ1U4?=
 =?utf-8?B?bkZJN1V4OExzaGovbnh4cCs5Y1NPcHJuVWFYSTJLK0hXZWtibHAvZlAwaDlI?=
 =?utf-8?B?N09JQVhkS2sxeUxQTkluMy9UL0I5ZkoyclYwRkM4alFCUzNNd1V0R0xSL3N5?=
 =?utf-8?B?TXg1RzhPVEdkNEhJTytkYnU1dFZyRXpaQktFb1hyOTNRYitzOG1mSDU3SmFK?=
 =?utf-8?B?aEVkYndtdWM5L2M3TzUvSGJ4czRzT2dFMHdpcWZJWi9yT2F6cnUvK2F3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5778.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V3loeExRMFpaNUtJRmhhZVdIWlA2QW1NQWdiOEhTVXJoYjhkcUxrT0FtOTkx?=
 =?utf-8?B?NjNrNzF3QVpKdlAxVUM5ZU1KR09rMVlFdzBza3BkNTd5NjRmZzU5NTlHaHZ4?=
 =?utf-8?B?OUY0U1UrTmJpVjBvTjBiaFdaMVdzUUQvRlFraWFNV3NqMXJrM2VkYThwVS9B?=
 =?utf-8?B?cFd1eFhZQjRWODMrNXV5MzMrRy9Ka09Td3MwbGNLRHd3NE40bEJrbVN2OFRa?=
 =?utf-8?B?aWtGeGRZcHRaQmhDNkIvYUlJUDVXY3BuQTFLbElqMTNveEVxTWhFOGNBSjBp?=
 =?utf-8?B?QndYQW9xYXdMOFhQQktwTVM0eThCVC9CNTNxc0dtNFFOQ3d3MVFkWHdHc0ps?=
 =?utf-8?B?MHM0UjhoZTFmc2dubUNFc1dBWG1xRzl5dUgxaVlIVzJ4YjhWWldXWHozaytz?=
 =?utf-8?B?bnhmVG1XWHBZTUZBOGVTdWZRYmN2ZUdxSVpKU1ZQWWZjOE44R3pQcFg3STVO?=
 =?utf-8?B?TCs5OXFGUjBzdks5Y0NnR3FLNzBCdmc3Qm5mUUprc01JQk5rUlVkWHFmeE9v?=
 =?utf-8?B?bXhJYWwvOWs5dGxFUHFIUEtibFpKK3VkMVNyZVVaZmpuOFN2UVMzUkV0UnQ5?=
 =?utf-8?B?Qy9QOTluL3Baekp6cE1yTzA0cVBJN21nSXZVTmVFaGNOY1B4eTE4aUdRTlBk?=
 =?utf-8?B?enlYUGRTbzFCdkorbkJQK1FTQTJMUUJVRnZsVy96TDFmaFQrcitOWDYydGNP?=
 =?utf-8?B?REZzY3I2ZVd2RCtQWjZoWEpPVERUeGsvNTVrMmI0c0ZVOHVwUlNqT083TkU1?=
 =?utf-8?B?U1hrSXVYYXMycHpDc3NoUktKUHc2QlFSdzRNOHdUUVZHczliRDdub2dFWnlO?=
 =?utf-8?B?Y3BodW9Hbm9Bck1MSzNlRDI2YU1xdVh0cmdma1lzZ2hkZDRRZnZyWUtUQUFE?=
 =?utf-8?B?REorSTIzNVE2WkhUL3BpWkt3WC90bU5SckhLSFlzWStWZWFDNWxYVWFITzBB?=
 =?utf-8?B?SFNKY3hqVlVOaGZmL2t2UTRqRHljbGJWVFBXM2FVYnJNYXREdGZhNEVJZnFH?=
 =?utf-8?B?M3dZZUVyckNjRGhJb0x1aWRPeDdyZGdMaG5KSjVCTTFmeGJYWkVrZ1V1akh3?=
 =?utf-8?B?Ui9ETWhtdDBXWkpVeXFzUXVDRWl4LzkyMTNMQnRveGFOai93bkZ5ZUVMZ3oy?=
 =?utf-8?B?K083UWQ3YmxNaVAvYzRqOUdnakM2cFBMWDFYcU1UYVZuakVWZEx6WkJyc2M3?=
 =?utf-8?B?ZW5JMFJVY1pGNWFvZ1FPK1JuU2VDdzJycmxLNFNveVJMVEcwcXNiZ0drMEdw?=
 =?utf-8?B?TkhqN2lHMjNnNUh5ak5jT1FJeTJYdkNxTHhOUGVvUUZqZzhvWWNIVWd6V1Bp?=
 =?utf-8?B?TDJlOU53R3RaTytoMWN0QTJmbFpDemp6STVxSUNVVjRSdW5KdXNWVnVTYnEx?=
 =?utf-8?B?dzdhUDd6UzJQQjlvZGJUd2FTeklsczU3NEp1VWxCRjZ6S3J6WFlnTmcwTURD?=
 =?utf-8?B?M05Da3N4UGVab3hScVI2Tm1JT3hKM2Z0WTNnZkVDb1VGZlJXdGEwbHF4aG9u?=
 =?utf-8?B?cWZuVFlEeGljcml4MFY1ejFHMUtvY2R2NFV6VGx5K1E4TWxhSlZyRFl0TUQz?=
 =?utf-8?B?blhiRCsvaUQxZ1NZZVBFaXpMRkt5ZG5nb2pvSHRZZ3dmTStLdnNwU1NYaENU?=
 =?utf-8?B?NGxIV2hpVGdMYnFYaDJYVkUxcndraVJqS1lJVDcvYVZQYmViUm94V3MydHlR?=
 =?utf-8?B?QmIzYStWbzF2ci9hVDNEQ3R6RjZrR3QxRUlQL2E2bG93T0xCMDZ2SzNsdzBZ?=
 =?utf-8?B?Y1d2anZLamttMWRHNWxMSTVLd0NzUjhrTFk4dzZkSjZqMkVKSUdKQjdZcXRk?=
 =?utf-8?B?RE5nV3FVNnNvTkxzNXZaK1l5cllIV2FSVlRCMEpPVmFZZTFrWFlxVytHTnhl?=
 =?utf-8?B?NXozdTZnL2ZDZC80TUNPRzhGdnBlZWZkWjl2R29iTElEMms0ZFZ1a0dydjdw?=
 =?utf-8?B?eE01b0xYR3JtcXh5U3dTM3d5NVdlQ2lwdWd2a0ZIeDRnR1A1QUx5Y21TUnJ5?=
 =?utf-8?B?YTRIVS9VRGZQQ3JZa3BGWldqMkN1T2tST2NTbUlFRHR3dDJSejcvZkpIZFdE?=
 =?utf-8?B?eHVQTDdPWGNSNWtDV3cwN3VNTGprb3lqem8vM1BrNXV0OTVhcFl1TU1ISmhW?=
 =?utf-8?Q?srGTPpWtL2S4fkMJ/HIWjgACm?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48777223-f5d0-4b47-16eb-08dcdc75aa44
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5778.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 08:48:30.7159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QlsxmjxexqKWZCAuXK0gGBZoUEOL+R5GGBWlfY8Pnz9UusJbxzAmT13nbVIkLbs+tOvVtqcdf2cCT96pWCCBQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7598


hi Jerome:

         Thanks for your advice, I will modify the commit message and squash
the patch before sending it.


On 2024/9/24 16:35, Jerome Brunet wrote:
> [ EXTERNAL EMAIL ]
>
> On Fri 20 Sep 2024 at 16:16, Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org> wrote:
>
>> The existing locking mechanism of CCF can effectively avoid concurrent
>> register access. struct meson_clk_mpll_data has no meaning in defining
>> a spinlock repeatedly.
>>
>> In addition, the register corresponding to MPLL does not share the same
>> register with other module drivers, so there is no concurrent access to
>> the register with other modules drivers.
>>
>> Every driver file with mpll defines a spinlock with the same name (even
>> if defined as "static"), giving the illusion of repeated definitions?
>>
>> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
> I'm ok with the patch in general but I have problem with the wording.
> The lock is not meaningless. It has a meaning but it does not serve a
> purpose, at least not anymore. You could write that it is useless, or
> superfluous if you want to, but not meaningless.
>
> Also, please squash the changes. 1 patch for this is fine.
>
>> ---
>> Chuan Liu (6):
>>        clk: meson: mpll: Delete a meaningless spinlock from the MPLL
>>        clk: meson: axg: Delete the spinlock from the MPLL
>>        clk: meson: meson8b: Delete the spinlock from the MPLL
>>        clk: meson: gxbb: Delete the spinlock from the MPLL
>>        clk: meson: g12a: Delete the spinlock from the MPLL
>>        clk: meson: s4: Delete the spinlock from the MPLL
>>
>>   drivers/clk/meson/axg.c      |  6 ------
>>   drivers/clk/meson/clk-mpll.c | 11 -----------
>>   drivers/clk/meson/clk-mpll.h |  1 -
>>   drivers/clk/meson/g12a.c     |  6 ------
>>   drivers/clk/meson/gxbb.c     |  6 ------
>>   drivers/clk/meson/meson8b.c  |  3 ---
>>   drivers/clk/meson/s4-pll.c   |  6 ------
>>   7 files changed, 39 deletions(-)
>> ---
>> base-commit: 0ef513560b53d499c824b77220c537eafe1df90d
>> change-id: 20240918-mpll_spinlock-4b9b55c44fd5
>>
>> Best regards,
> --
> Jerome

