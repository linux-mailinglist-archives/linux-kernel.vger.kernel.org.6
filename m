Return-Path: <linux-kernel+bounces-195050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C30178D46E2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 10:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E688A1C20BDD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 08:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464F115216E;
	Thu, 30 May 2024 08:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="qGFo9G7c"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2075.outbound.protection.outlook.com [40.107.8.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D29DDA1;
	Thu, 30 May 2024 08:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717057096; cv=fail; b=R/EyzH+69fYjCpei6gUBiTjfK5haZbrFWGM8/Hy49F3nbtUohHaRv1TaixJ+MKzkBlS0UzrUVT3fubTMVQS2vwaX2PLRDkjGzxtT7/FHcuncwSgGOEIN6+7boGo4hu4rGCHNTIWMtEWtPf9gv9MfIqe9ILLtZkR8OlWp+Foj0SE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717057096; c=relaxed/simple;
	bh=7zQIxZJ3NCWUUlWkpYqYk5NkODFwyEUvPUHzTuJJMiU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ml3LIsB0uo2aPvjU+pI4rEPpJnv9kwTUBYPC/uAjE1r91V4JxN0el5Sa0o39bueYHDzLpw2m+6fETiVCPTr03Cv1dxufaklbq6zTnUv2LC4KS53FFjUFuTNiVOOncDYZkgYlMRdvdiQv+PK0Nnn8H2tA9AqslWhTQYVm/lpOf14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=qGFo9G7c; arc=fail smtp.client-ip=40.107.8.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XsgsyhujJ8Xz5j96pV8s3Yc1PUtjxnQhdCasFFJEAW1agrUvc8RpGgG6QPLrN2SQdcva/5Lhof9lJlvIhhf6tikH2v1o2t3TIsnwmdTvLokJd90VuD2NZaiPHr+mHAY+nTlM8k4NxlRL5m5zmJINTf0iJfzSkr4IMRlYUtz4Y4XtxZB6Hhn/008GC2rxgbdVII/d0FHc4HeopoPxraxR25wu9TJNasnIJEGlKUm4ZGBi4+9iZIFMxYRQhaGUEh3OznqmcOgjucvtnE1OOUQeFXrbU7p3QLXHxaV7m3MWPEzuS9PomZlftdsyLUcTRx0BHvCRZ77mfxlsJIt00v9pTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hsOdDpuDO7fgXupti3q5PdZCXWrgXoqhEH3BVQ9S2TI=;
 b=lt9bB7fAvXXiVyYc3A/GKamZ5byPi6w8cgo/0dKEy0IKsF25JDM0aPCC0ZbL8VeDXtmg/VelTi1leB0dtH+nBKl1yZP8cBbpoeOF2wrtP0y0unoy8Xf3MGIX4HRqJN37FE7tqxC7HEEJd3hKJNQXG9/jIJslGMgeiMxPk52ST6X2jvP5W+nJalpafoYNwodNqpxhEoHGkv3OfLKUjKDZ2T+E5+pZlJ66GPHbyTHBERdbDRJaq7C20kEuwbuHa3eIrdOnu8hJZOQi6u4bfCftWGxkhAyW2nvz/xvwxqH0X8RAewanmeJv14Th57vDOXQq/qIAfqb6Lr8Le+/KE0wBPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hsOdDpuDO7fgXupti3q5PdZCXWrgXoqhEH3BVQ9S2TI=;
 b=qGFo9G7c/dtqxZbJQRmBoH3YoO78B0xiCmxDMKi3mhkcAb1fpFDM+s8QbiWHdwF9VgdGKBrZ/3BddHKRPMvLSOTQmPKj5OMTKHUCjyJHy5L4nDIYt96II/mZf5nP6TJ4aoLGbstRAlU4lOiKqE3G0I8Na4Nik0V2e3ZGsILiR0I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from DB9PR02MB9994.eurprd02.prod.outlook.com (2603:10a6:10:462::8)
 by VI1PR02MB6109.eurprd02.prod.outlook.com (2603:10a6:800:18c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 08:18:10 +0000
Received: from DB9PR02MB9994.eurprd02.prod.outlook.com
 ([fe80::f9a2:77a1:a5aa:8f8b]) by DB9PR02MB9994.eurprd02.prod.outlook.com
 ([fe80::f9a2:77a1:a5aa:8f8b%4]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 08:18:10 +0000
Message-ID: <c936db6e-58cd-4445-92a2-9d53ba7f6b8c@axis.com>
Date: Thu, 30 May 2024 10:18:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: ti,ina2xx: Add alert-polarity
 property
To: Guenter Roeck <linux@roeck-us.net>, Krzysztof Kozlowski
 <krzk@kernel.org>, Jean Delvare <jdelvare@suse.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@axis.com
References: <20240529-apol-ina2xx-fix-v1-0-77b4b382190f@axis.com>
 <20240529-apol-ina2xx-fix-v1-1-77b4b382190f@axis.com>
 <1ae97b90-ff20-4238-abe2-f2e5d87fc344@kernel.org>
 <76dd5c0e-cc67-4ad1-8733-d8efdb8a172b@roeck-us.net>
Content-Language: en-US
From: Amna Waseem <Amna.Waseem@axis.com>
In-Reply-To: <76dd5c0e-cc67-4ad1-8733-d8efdb8a172b@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0023.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:a::9)
 To DB9PR02MB9994.eurprd02.prod.outlook.com (2603:10a6:10:462::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR02MB9994:EE_|VI1PR02MB6109:EE_
X-MS-Office365-Filtering-Correlation-Id: e25eb5b6-bd9d-4419-45e0-08dc80810b1d
X-LD-Processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UlNXWisvc2NSRHRHSnVNUkp6R0l1Sm84RElEUEFrY1hxZEtJT1EwaENCVzVZ?=
 =?utf-8?B?TnAwU2hzZHdjN2NGYlVxOVpSV2lkNmpHaWhRL3poaXM2dDBWTkFCRVlUVWJy?=
 =?utf-8?B?OWJBckFPeG93UU8wQ3QxT2Q5VThBUFl6V2oydjNPY2xLU05oMGFmaU1nSEll?=
 =?utf-8?B?RlNVZ29PTG5BOTVvMk9KYXJ2SEtuaVhqblgwVFE4NmU5WFpYRWVITlN6ZmFs?=
 =?utf-8?B?b2tHa1d6Y0ZQRWF5a2J4cnA2MXp2RUgycnpLd0J2TUlrNFZsZDA1TG5rSTFm?=
 =?utf-8?B?a2NuNllDSEFPSi9yN2MyOGpxdUZtMVdLRm1Oa1pGcjVkSkErNTBCdUJrN1Nh?=
 =?utf-8?B?L2Fhc2RxZVJ1K3ZObk0xT1plK0VsUUtKcGwvUlhYMDlTbjhKUzVZZEFLU1BG?=
 =?utf-8?B?Y08wUVdkanFTVzY3alFkb05zRDVidUxQMWtHY1BabkVwYXI4S2c0d25tWWpT?=
 =?utf-8?B?N1RNT0lOcHNTSFQ0cjlhSWJxOWM3ZUI3T2RyUVhUTjNranhhN3hVcCtlcjE4?=
 =?utf-8?B?eFhHd0VBaUNnTmN2enlwVTRJd0ZYRm1BTUVCak5OZjZFSzhsV3BlRXhPaVgv?=
 =?utf-8?B?LzFCbGJmNkVTbWdHVXZTdWNQek1nak8wS0ZQaU1QOVRtMGNxd1UzQkdHY25R?=
 =?utf-8?B?UXZWbnJwdnQvMExKSUh6VnQ4YlFzREJjL0JWL2trbzRWQWF2SFFLQXdUbzdv?=
 =?utf-8?B?Y002c1BlMTBDMzB5UklMWDRuRnFGTFRiNTcyc3VQeHdjdUhjWVUvU0VCVnhU?=
 =?utf-8?B?eHh5aGNjTUd6YXdUb2owWVM0WXJXczJxcXF1QmxMZWM0TlVNcUZSSitrV3Zq?=
 =?utf-8?B?ankwSkV1a1dWOVBWUjNhOTBDK3U5V0J1VGdoNy9POXQyYTlDemh3OFdsSmZF?=
 =?utf-8?B?Qi9kejgwZDNaSzUvUUpoZkpBWTNmVGhOdU8xdEFwT3o5NVhyejUxQS9EcFR6?=
 =?utf-8?B?ZWk5RHd2YzVCeFBhMGJKVlh4RTNTK1MrY1lZYzBkSVEwZGFqREtodlFDQVE2?=
 =?utf-8?B?Rm5KTjZtUzlSak9aM1VnZGZpTDdVTG01UUhMbi8rUXhBZmdubXpGdXVHRHpJ?=
 =?utf-8?B?UWx6ZWtGTE93SDZabUhmNTkyWkdQZFU0ZWlsVUJkYzRKNVhmRkhJZktIdGVS?=
 =?utf-8?B?OGVaRjg1U1NocysvZVgwSlJZWEJseVFrRlgwRFRsQzgxdlMyZytOUVphVjQw?=
 =?utf-8?B?OUJRc1RxMXBNNDZ4bDE4TkIrNnVVdmYwMkNya2tqOGhaV010aFl6Q0EwemI2?=
 =?utf-8?B?WUJUdWJ5M0g5amMxTkZMby9hVzBlNW9KSTRlNTlVRVBteWRzNFcrRzBtZTVF?=
 =?utf-8?B?M1FYanRKTDNiU1prR2l4Y3dzZ0NpODBhVlN2NU9hWERFb2RSZStuOE82V0k4?=
 =?utf-8?B?UlVtYmhFVFlkOUlYR0JzZ3dneWV0T3VVM1N4Q2JPOWVZMzhweFhpR3BZS2ZJ?=
 =?utf-8?B?WUdmSEhFZWdZYjZ6bEdoOHlvTHZyaXpqYnYrU1R0eUdNYWpHYkhjRWJjblpM?=
 =?utf-8?B?TXVwZ3pJaDlXZFBoOWtET1g5a29pcnpBWTUrRWthSkloYUZjSlVLd3dHTHVy?=
 =?utf-8?B?QklUaWN0UHFkRThlL0l5YmZGU2RDQ2FMUFFyeDJGRUxaWFp1anFHa3AxNzk0?=
 =?utf-8?B?V1hTQUlOWXZ4N3ZSTWluQzhhbXltTmltTGUydVhVZGg5WWNqYUtsK2Q5R1Rp?=
 =?utf-8?B?aURGZ1FsNGFtOUhzS2ptVzBtL0Vkbmg5NHBFcWhVQmZSQWVlMnRTMmN3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR02MB9994.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OEhmNXUzWjNVREViQ0RaVU4wdXdFTG9FNVFBWVQyWStnVUEzaDJhbWYrdDhj?=
 =?utf-8?B?R0R2YWlOWlF2RnV4cG01eWo3VUZrVFVvMmZFc09sSWd3SnBYU3VqczBmOC9a?=
 =?utf-8?B?L0JJdWxYMjhrWTNnYUQ2elplMFB5WWJFOCtoOWJJRi9iRWNxRFhEYjJqdUxE?=
 =?utf-8?B?amR6V0c4amx4SHY1VnJXL0Q2SlhDOEdjSWk3RjhKWXhKaG1JQ2JGbmtxblhY?=
 =?utf-8?B?VWZYZjZXajNDZk5ZWmpoeXRxRUV4VHU5Rm82d2lDSkU4bHcwY3dOWXc3TFVi?=
 =?utf-8?B?b1RyL0pDUWFleFFRUnhEZmtnZXVXck53T0ZWUnFPWkIvc2VxVkkvSFBXNkpO?=
 =?utf-8?B?TXBxTXQvTVVVcVlvSGRIWDJSRm1Sbm8yOEVraGZqOHI4RFpKOUlid0txTlBt?=
 =?utf-8?B?TEUzSUIrZXc2OWFCWDF0OWVHMmJ6RlVWc3lhVEZKNWEvbWViQjN1L3FCWHVD?=
 =?utf-8?B?TjV5amgweGNDUmVGam1SMDJNZ0lrQmxRTGR5Q1JiTkk0S2pHZUpKYzNhaVRh?=
 =?utf-8?B?cW1yK2MzaXlaV3B1MnJSVk9LOVJqMUsrWHBCK2dtbTJWTUczUnlhMDlXZzha?=
 =?utf-8?B?QkR6UGFZQ3Y2WVVFZkNvemt3cnhiL0NCZXF5dzMxd2xLNktWTUkzL1Q0TXNF?=
 =?utf-8?B?VEZ2ZTZnN2EwemFNR2lCK3FaOVA2T1pUV3dYMXFXNVZ6SGtpREY4SCtvbU9C?=
 =?utf-8?B?ZVZtak45WTkzMzVuRG9lZmJhaUpwek52dDBYNk9JaDAzQ2VaTmhzOHA1ZWZF?=
 =?utf-8?B?dnd3anZKaUwvdGlGanJJMDdNWnE5TXdqU0Z4SHVDakErdzQrZnZ6aHo4S2dV?=
 =?utf-8?B?VkVjdUJxcHdnYk1JdjFlaC9yR1FmRkFCN0paRjAvYlF6UFBXQzhjS2pWbUFn?=
 =?utf-8?B?clo5dEJ2ZUxOTUt4SlY4dFZETFZPa1hkS1Rrb2hCdFgrck5EN0wxREpub2RU?=
 =?utf-8?B?V1VQVHVESndxaG9JTjBRNVFPNUNMYk9SWDhMakVkR0hKeFRJUllGWlc0eUVN?=
 =?utf-8?B?T3Z3NFRWbUdFMlUxTzZOOEQreVI0NDcxOE5PZ0hqdVRVVWVsYms3dFJaeXpJ?=
 =?utf-8?B?RnRKMmJiWlVhdXZrbU5PcWhIY3EwWFNLTDdyQUNmd3FLbGxMUUFic1RoWVdR?=
 =?utf-8?B?VVZKWi9FQ1BiS3N4Vjc0MnBNVEtSQ0RObnUwdTB1LzJsc0hSZTBRb2tabS92?=
 =?utf-8?B?djlUQUU0RDFIVFZ1WTA0L3dnU1o1ZXpIdEVOZ0VXdEtNaU9yYzRWdmJ1UVpK?=
 =?utf-8?B?VzlxY1lhQ1Zqcm5tb1A4cktoMWFwczRtelNuSlBDS1FPUjVMUFNubDRnaDJZ?=
 =?utf-8?B?TlJiZDV3VnJmQThZV2dBcjkrWjlveDI0MCtEckdqdmIrV0xoS1dBam1meUg0?=
 =?utf-8?B?Ynk4YWMrY1V4WkF1QTIvaXE0QWJlY1NPUVIxUWozbkpoSVR0MWpiQ05naVB0?=
 =?utf-8?B?WUNTNkUvSGNPNm10OGY0cE11dlpHT3F6MElya3UrQjY3NFlBSk01WlhZTHBJ?=
 =?utf-8?B?NHNkQUdpT1l4d3ZTcFo1UGxCU3J4SVIvVG5XQS9uWEo4UDJZeVpaaU83UUdz?=
 =?utf-8?B?TVB3bDVpb3lrZ21MYjR1SnhWRFQrMTA5VFBqdjJTOWN6NEpidlYwWm5hTVA2?=
 =?utf-8?B?STBLMWxqSU5qSkNuYlUrMXZ2anRRd1dyajRkb0I1MjFaSWxhQmEyZFR3eDBw?=
 =?utf-8?B?MjkxY1JET21wMXUrRmpKOUQ3MGFYOURZdE9veGJhL2xleDEzTE9nbDBVL2pJ?=
 =?utf-8?B?aXp6dVJuaGd5VE9TS0pTamZocUZrcWgyN1Bvc3djSDFLRzJ1bVRoY3FHKzIz?=
 =?utf-8?B?MTJNb0RNM1NGTWNGZkllamNBcXd6d25zdUJPNExqekUzY1RkN2V0RTh6cUEw?=
 =?utf-8?B?Z1pNTlZHSUlrdE1oUE9KVlV1L3FES0gxeVJjUUxVZEJHeVlxSmQ1ZThKRDhy?=
 =?utf-8?B?aUwvb0ZDRjYvdjFzOGxIN0xnUFhhbUo4WTdzOUN2VEtSMmo5VzA5NkFWeGNX?=
 =?utf-8?B?S0gyU3RuYnBCOXdnd3FWYWJYdDROVFg5RHIxZlI2WFNMOXo0MGxJQUp0WDE0?=
 =?utf-8?B?OG1nME04NDZZMUpiMGRHVERnUkwvMXNxUUdwSmZQWHBwVy96VSswNzIwSFdi?=
 =?utf-8?Q?003Q=3D?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e25eb5b6-bd9d-4419-45e0-08dc80810b1d
X-MS-Exchange-CrossTenant-AuthSource: DB9PR02MB9994.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 08:18:10.6282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AZuPRv75VxEDgF6xqQdVYHQCDwNQ44RF9kOsYo03eLhp+ygqitVEJHZpNI6VMT8p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB6109

On 5/29/24 16:01, Guenter Roeck wrote:
> On 5/29/24 00:07, Krzysztof Kozlowski wrote:
>> On 29/05/2024 08:07, Amna Waseem wrote:
>>> Add a property to the binding to configure the Alert Polarity.
>>> Alert pin is asserted based on the value of Alert Polarity bit of
>>> Mask/Enable register. It is by default 0 which means Alert pin is
>>> configured to be active low. To configure it to active high, set
>>> alert-polarity property value to 1.
>>>
>>> Signed-off-by: Amna Waseem <Amna.Waseem@axis.com>
>>> ---
>>>   Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml | 9 +++++++++
>>>   1 file changed, 9 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml 
>>> b/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
>>> index df86c2c92037..a3f0fd71fcc6 100644
>>> --- a/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
>>> +++ b/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
>>> @@ -66,6 +66,14 @@ properties:
>>>       description: phandle to the regulator that provides the VS 
>>> supply typically
>>>         in range from 2.7 V to 5.5 V.
>>>   +  alert-polarity:
>>
>> Missing vendor prefix.
>>
>
> Are you sure you want a vendor prefix here ? Reason for asking is that
> many hardware monitoring chips have configurable alert or interrupt 
> polarity,
> only the name is different. Some examples are the JC42.4 standard ("event
> polarity"), adt7410/adt7420 "interrupt polarity", MAX31827 ("alarm 
> polarity"),
> or DS1621 ("output polarity"). We even have a vendor property, 
> "adi,alarm-pol",
> used for MAX31827.
>
> Secondary problem is that not all chips of the series support this
> configuration. INA209 has a configurable "warning polarity", but the
> warning pin and the smbus alert pin are two different pins.
> INA219 and INA220 do not have alert or interrupt output pins.
> Only INA226, INA230, INA231, INA238, and INA260 support configurable
> alert polarity.
>
> Thanks,
> Guenter

I agree with not using vendor prefix with alert-polarity property. 
@Krzysztof Kozlowski what do you suggest?

Amna

>>> +    description: |
>>
>> Do not need '|' unless you need to preserve formatting.
>>
>>> +      Alert polarity bit value of Mask/Enable register. Alert pin 
>>> is asserted
>>> +      based on the value of Alert polarity Bit. Default value is 
>>> active low.
>>> +      0 selects active low, 1 selects active high.
>>
>> Just use string, easier to read. But for sure do not introduce different
>> values than we already have - GPIO HIGH is 0, not 1.
>>
>>
>>
>> Best regards,
>> Krzysztof
>>
>


