Return-Path: <linux-kernel+bounces-195036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CE38D46A2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 10:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 150A6284C2F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 08:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9551474CA;
	Thu, 30 May 2024 08:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="GZYFaZrD"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2085.outbound.protection.outlook.com [40.107.15.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BFC143725;
	Thu, 30 May 2024 08:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717056166; cv=fail; b=V544Vk4l4kGGlxMOlWqZ6d67pLM+N/UdcomkSwWWuK1rz58I7QOY01bpSA9jHoBI7HoaSz3AR8Fh0+VeYFMosWwGCLgwCO/f3C5JXovN35l318Y2urSKyJiZY2F9f6/twjYPQiH4U+9hAC4j9zjRj5xh370VwhZGRgJCLcPojtk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717056166; c=relaxed/simple;
	bh=lYO7PdlunCDxdOZ6oH1I8eQBTbqXV9J/s84Sxpenuzk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cXDQa5YXYCxT9S3qJlOwsBEaCjNDzBC5xECPgYoE88wJfvkMThyWBrFkefmrlBjdwAwLh2tnbA4YKtKw/Hmuj6Ha1dbO+adex6EqZcWWU3nb+D2LrJQhgXEB2aWl4P+MtzTTVWuyg7BQbzIINN/5eTZCUp69YFxCArcXi/pg7XM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=GZYFaZrD; arc=fail smtp.client-ip=40.107.15.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ct88wyf420hr07o5TF04XVhovmw98kV2S2jZrBrYBP5BH+bRuYii1PDlnqC5yCyU5LF6PqD+XC4vz9BmA1U5MapxeZumO+ZIwURHhfoKgVWGjR4SPXtcJfdwKUF0IFmgD6w3/4yKiqbbzGBrt2T0gWd/LcvjDC4cgkKSVia5u4N1UxANckOirosXTB3fbnGVkd/zdwG3lk/VbfcmGP1ummEo/480NL8do5mkKHOvu27Dzlm38XHOtxck+fssmOepqo10RCE5QYc3Bjg68uadQ4vMJ1BdWI1ZuGl+oER/bX/3hXBPzIzmhxcrhmJ3ZHDhqFfrrI9Js0VGO3Z7YtxdsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fH/3Fe+u2ankdvgxe+RjK1iUkEQQJP3rf26zg3TBNzw=;
 b=eAIXbTXcT6i7Kamw4Hooqu1HeYZuH2IjyIk3xiGjXB34WzZZRvaWC1RvmjOKyuw0sf1YB4t+UE/s9HXvXO+Exa93AOOOMFUhqAxBM3VhWHqNORWuUCyu/mnwXWIxbZIJRqSk5u+yOathBT8hG55dh8Dqtvhv1w2NBaGotbUca9CcXzYAl6pVZNwiPQ+xwRD5WzyoYq5cnDQmWVF0Kw8KUwUQcm7u4ElO7QEk8K/F+wj1od9u0tudIN9XsErkzqhvyIZpO+DudmrbbAHccIySa4nnoZ+Miz4E5K51IbJ3EtlAPAZYtN+ni+5Jo5d72oQN028cT1nXvHcZuDGTLMnQMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fH/3Fe+u2ankdvgxe+RjK1iUkEQQJP3rf26zg3TBNzw=;
 b=GZYFaZrDj0XBm1qRKBpQI/N2rI6hrZY6lykOmBFClVL6VqjS90GQMQS2v0tt1wEWwuajBaKhi3TIuCDe7kCduwN4YdaAzM25t8VanGQV14uTf0pqQc//2rOGTgvFcqi1VcRBD19zsweG4x+Y6kNT2qojeaVllsbXaM0Xe+PPTdU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from DB9PR02MB9994.eurprd02.prod.outlook.com (2603:10a6:10:462::8)
 by AS2PR02MB9715.eurprd02.prod.outlook.com (2603:10a6:20b:5e8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Thu, 30 May
 2024 08:02:42 +0000
Received: from DB9PR02MB9994.eurprd02.prod.outlook.com
 ([fe80::f9a2:77a1:a5aa:8f8b]) by DB9PR02MB9994.eurprd02.prod.outlook.com
 ([fe80::f9a2:77a1:a5aa:8f8b%4]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 08:02:42 +0000
Message-ID: <8a41d875-8e6c-43da-90c7-0547648f214a@axis.com>
Date: Thu, 30 May 2024 10:02:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: ti,ina2xx: Add
 ti,alert-polarity property
To: Guenter Roeck <linux@roeck-us.net>, Conor Dooley <conor@kernel.org>
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@axis.com
References: <20240529-apol-ina2xx-fix-v2-0-ee2d76142de2@axis.com>
 <20240529-apol-ina2xx-fix-v2-1-ee2d76142de2@axis.com>
 <20240529-untangled-occultist-5c9804aa9c8f@spud>
 <f41480c8-f149-4826-aa28-549a504df181@roeck-us.net>
Content-Language: en-US
From: Amna Waseem <Amna.Waseem@axis.com>
In-Reply-To: <f41480c8-f149-4826-aa28-549a504df181@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0009.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::24) To DB9PR02MB9994.eurprd02.prod.outlook.com
 (2603:10a6:10:462::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR02MB9994:EE_|AS2PR02MB9715:EE_
X-MS-Office365-Filtering-Correlation-Id: 025755b3-0252-44fb-5a9b-08dc807ee1ac
X-LD-Processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|7416005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?alNqS1Zpa3NTUHNxSVZMR0UzeUhMcWVVU1RraW45ck1GZE9XNXhrM24ydlBu?=
 =?utf-8?B?dDR0T3ZzOThkbkJnZXh1WHkzV055TGpYNEVJZ3A1UldWcEx5L3hnOVdQdkJl?=
 =?utf-8?B?YmtTTHN6aDlMbXR6M0RkbGVpbUlhM283K1J2elpjR0JGdXd3OTJ5YmhIVSsx?=
 =?utf-8?B?TG1pdmhIUm80cmxGT1U5a3hNNlAzYkVmTy9XVkVTcWdEeUo1bEpndHRuWllU?=
 =?utf-8?B?aHFVV1JBU20xMllWMzBRL1VSYWFzNmNaRWttQXVTeGRkM1pKT0h4OGNJa1Fq?=
 =?utf-8?B?R1RpNjlmOW9BaCt2VnZXaXVPMXQ1RTF5TE5jUFVIcU9FOVNRSUt3ZWRaN1BP?=
 =?utf-8?B?RkRHSFFPeE95eFovUmF5NlQ4aGxWNUd3WmdQS05zbFhkWUEwMTNxZlFLNTFl?=
 =?utf-8?B?ekhCbmFYVEVqWEhlaGQraUhpWXpxcmZWenRkYWdGb05ad2dweExQcHNyQS8y?=
 =?utf-8?B?aE9GUlkycUdSa3hPQllWb0tuVDh2VXFDNlY3cFBzY3A0R09aeWl3UjkwV0hN?=
 =?utf-8?B?eWpBQklrbThLekt4RUdOK2RiVnpHSW1hKzFHY29aaGI5eWI2cUIyMFFRUkVz?=
 =?utf-8?B?MGNieHV3N2d1dXVjeU02bUxsTXl1dXhKNzRzYkhpVmF4OVc5VlRseUpqc21t?=
 =?utf-8?B?Qm5jSnNyekpOWEp1UWc2dDY5VFBvSWVRYUtEZXd5ekgzQ1hjeHIxTDZHR21M?=
 =?utf-8?B?Q2xPbGxtWnM5aTVlM3VRZ0xCT1UyT0xNN252TFA4SnpqeHNSdFBNMHNBMEsw?=
 =?utf-8?B?MHhsRGVhT1dRTlEweE1MWXpSSVluOFl2TFdUc3hGeFVOeTY0SzQyQXZhZW1r?=
 =?utf-8?B?Z0xEZVhsTUdNemQ5RkJ3N211MzZVVkFRUnhHY01SVnRLdFF4SGRJbUF0NklK?=
 =?utf-8?B?THUwdUNWNzNLVkhXMkZrWmV4dW1DSmdZelRHZkdEQjZCWS83SHBKZWkvbDF5?=
 =?utf-8?B?bEkxc2k0anltQ1duNzZiVW5WeUlheGlnenFoOFY1bzdhc2ZXQmovVDE4OFZy?=
 =?utf-8?B?b05lTDRHVFRFb3RNQ2hNM3VoTDA1Y0pLNnVJdXZ3MWlqWjFXcGdkaUhnbm1M?=
 =?utf-8?B?Njk5Vk9MQ3ExTTltOC9xb1R4aERUUGJPM0F4QnYrRUExZXA5VVpkNTFxSXNP?=
 =?utf-8?B?TEZ5Z3BsNTUrU0ZPUlNOL1BCSW5rMHkzVE41WncyMkxVTXBzMHVSR0tNSW5q?=
 =?utf-8?B?ZE1rbTNMSDhCZ2taWmpRRnFiTUlYNW1DQ1Y0MEpSaGhJNjg0REFudmF2SWI2?=
 =?utf-8?B?eUpkSThmN3A3YVc5cDAzcmxPTVFTeVJlM3pzbzFIUGs3Ukd2dlFSUU9RSUZi?=
 =?utf-8?B?blJWSzJDOXF5Yzh0ZE9jdHN1bDdoRHdCV2NYRjFXcVZTejlwd3FjOWUxNDU5?=
 =?utf-8?B?bzMxR0V0cWovdkFrRSt3cnMxb01GSnFDalNoUVhsUFl2RFlDL2QyTjcvK2tG?=
 =?utf-8?B?L2dUSGh2K3dDVXJCMXFhQTl4UVBtNUxzaERlQjZ0NTZPdndITXliTnQ1ZXVo?=
 =?utf-8?B?V2RXdG9WendMNlY5R082WnZTL2R2VWZ2aGRkYktrN2hSeGZoa0lMeEhsSXpU?=
 =?utf-8?B?V2lzR0cydWFvTllIK21qMWJDRHJObDhhSTEvTmoxQ1plWnVDSkRmNXpEYmR2?=
 =?utf-8?B?T1lHMXpIT1ZDaUNiQ2VuRlhESWVZMkIwMSs0UzMyNFNLSkZUTFBvSHNvTWhX?=
 =?utf-8?B?cGVhd243V2d2ZVlIRmlkZWpnZWlaUm5Nb3Eza3IzckQ3a01sdjdjN0JRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR02MB9994.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXd1QlBteC9VcWdUL3hTNzdPRmR6cG1QYXFUOXE0bzNjUHM2cEJJNmdBSlJV?=
 =?utf-8?B?Zy9LTmdyMm5ldHhwblpwckNZL09BbHoxSlhWajF1Wkl3dmhMQ0N2T1krSWlK?=
 =?utf-8?B?L3FtRTV2VkRyMjdhOGxTYlNOODVma1dESWZtdDgvODZXZHlhamV5b25HM3ZR?=
 =?utf-8?B?QWpxaUcvczVyc2pBUXo5OGpWVmRTRWUvaUZPanNhNDM1QmdpeGxrcmk4N0Jr?=
 =?utf-8?B?NjlJZ3FvdFFhMWVwMjB5QTN4SEhVbGZSNFZHclFHRW9tYmdvanBXMW1DWk9L?=
 =?utf-8?B?ZTZWVG8yajFIdHFKSDFsM28xRHIzVkl6YzZDcytkUmg1UCtVOUN5bUl0ZjhQ?=
 =?utf-8?B?eHVtRXNsV05sWWNSVGs4MWNsRE1oVWVYOVU3Z2htYlpaRlFEbVc3dUcyaU5Z?=
 =?utf-8?B?cW9FQ2JlTjg3Qzk5aEVCVzA0emFCdVIraGJpaytaTWh1aFVKa1lVQVhaOUpw?=
 =?utf-8?B?M3JhZkFXa1NMNXpjZ3prUUVKVS9pWHVQMVZkU2dNcHB5dEIwclZWbmpJNFpa?=
 =?utf-8?B?WTNRZGRSb3FFMkhyWWkvd1lFbnVmaEs3dWJTcThmdHIvTGVVbERRd1htMkR6?=
 =?utf-8?B?T3k2UUZBYTNOSDkwMkdValVwZ2NqL3V1NmI1VVBGVTRzOEpvUkRxY1J2OTIz?=
 =?utf-8?B?NlQ2QkFxWGRCQlFEMW1GeVVFaEpTd2Jub1B0NzRtQ2NrRlV5UHc5ZEVwMXNi?=
 =?utf-8?B?NHpmZlJURE00dTZJa1VWSFZodlU0Y3BDQXMrSXlRdWt4SWJ4ZVVha0Rxdyto?=
 =?utf-8?B?TllpdGJOTjBhTENSa2FYUDB2NG1tbm1EVnFLa3RxekM1N1owRWFwTXYwcTBE?=
 =?utf-8?B?OE1qbDNrTEU0YzRhbXdoQW9Ld3FSMjZHVGZCZkV6NjhEUS8welA5YVQ1SHhK?=
 =?utf-8?B?WFV1eVlyT3RNNjVSbjlQdEZjQzYzYUxlOUd0OFpuMjEyUXFCNVc4b2ZVemQy?=
 =?utf-8?B?V2l2QjVrS3A1KzA1K2tIUU96b01WbXNua2NBT3dsWUlUajdYalp5Si9BWEVu?=
 =?utf-8?B?M0tSbUQzejdsMjI3cGw5WUtOVy9hUHZGa0xaUytZWE9Fbng1ckhUYzA4bjFv?=
 =?utf-8?B?MmlUMmdQVUhlVE1tYzNTS2EzdkE5Z1RBWGpFVEtvQUVWY2pEcW8xM0FSVU9a?=
 =?utf-8?B?Z2s0eTJPZmVQVzFwNnV2a0VRdFRmb0FScGE2QUhvdXlleGUxdmI2c05jcC9R?=
 =?utf-8?B?Ylc5c1JwVis2OHhVMEJoMmxhZkdoK21BOU9zVGVpY0xsZGlnWjAvZHk3a1ho?=
 =?utf-8?B?Sk9Xazh4TmxtNXArMDVWSWNLbll0T1ZLbXN4M1k0eGxqY3oyRC9qaXA2bnhL?=
 =?utf-8?B?NmtDTk95bEdaUUM3NkM5TVU2VUdZRXlDNGo3dXQ1KzR3NmdNZ2N1VG1lN2Zs?=
 =?utf-8?B?eXc2blM4dDc3RlV2KzNDV09GMUdCaHh5Z3B3U01kNjIwSFd6V1dqMGN6cGUv?=
 =?utf-8?B?RWNXeTZMRWVGMTc2emdaeHhBa3pBUXQySmc4eWM4clJkT202ZWg4K2ZCM3pM?=
 =?utf-8?B?MG9UZDdwcnVWeWxudWcvNU1YNWROUXhEK0ZuampoYks4Si94UERaMWcyWnBV?=
 =?utf-8?B?czVNQm1zcjZrTXdsTnowK0hHd2FNRS8yTUduc0cwNTBVcExhOUdWNUswaW14?=
 =?utf-8?B?enFCREtORjNMVHZPY1puanFqNGg0RjFkTTNTbFllWXAyMjE4RXhDK3NzK3Nk?=
 =?utf-8?B?ZzJ2YmtWTHA1eE5HMkdyWGVvcmZjaml3Z09aZU1HcHF4L2Mxc1E2a2JRVU54?=
 =?utf-8?B?VWMySjJZa1BqYzV6MHdTZ3YrTjhtT1FDQytXTk4wRnZZYlF2M0NJM2diSWg4?=
 =?utf-8?B?bHh3RTEyTGQ5MTlnWDI2RkNrbFJhNnhsMHU0dGYxTk9ERFlLeE1MR3pkV08w?=
 =?utf-8?B?aHB1SXVNVHU1bXNyYzBSMGFFNjZnK2V6ZlhZSUFsb09ZQTdYZXNJWE9iQXFm?=
 =?utf-8?B?ZnNoemU2Mlh0cTcwKy9rZFF5UHlZMG16KzdtSmxmSzZJS29Lc2FIK0lqeDVX?=
 =?utf-8?B?aHp3UjFJNi9jbllYenRkT2hKZ0UvZEQ4QmpBQjE0N3JuNThQSENzUmZxY0sx?=
 =?utf-8?B?VWtZcDY4b0E2T3NoL3YvQzdFRlFHZDdGSVRXc3dGcW85cDBSL3M3K1VlUWdC?=
 =?utf-8?Q?522o=3D?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 025755b3-0252-44fb-5a9b-08dc807ee1ac
X-MS-Exchange-CrossTenant-AuthSource: DB9PR02MB9994.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 08:02:42.1011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rbu3OOFU75MCEAxw+mG38WO08I2AY2r4AAYmkmb3rZl+7tddVWXVnzntqLG2yTy7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR02MB9715

On 5/29/24 18:20, Guenter Roeck wrote:
> On 5/29/24 09:17, Conor Dooley wrote:
>> On Wed, May 29, 2024 at 11:47:44AM +0200, Amna Waseem wrote:
>>> Add a property to the binding to configure the Alert Polarity.
>>> Alert pin is asserted based on the value of Alert Polarity bit of
>>> Mask/Enable register. It is by default 0 which means Alert pin is
>>> configured to be active low open collector. Value of 1 maps to
>>> Inverted (active high open collector).
>>>
>>> Signed-off-by: Amna Waseem <Amna.Waseem@axis.com>
>>> ---
>>>   Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml | 9 +++++++++
>>>   1 file changed, 9 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml 
>>> b/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
>>> index df86c2c92037..5a16d2d94587 100644
>>> --- a/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
>>> +++ b/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
>>> @@ -66,6 +66,14 @@ properties:
>>>       description: phandle to the regulator that provides the VS 
>>> supply typically
>>>         in range from 2.7 V to 5.5 V.
>>>   +  ti,alert-polarity:
>>> +    description: Alert polarity bit value of Mask/Enable register. 
>>> Alert pin is
>>> +      asserted based on the value of Alert polarity Bit. Default 
>>> value is Normal
>>> +      (0 which maps to active-low open collector). The other value 
>>> is Inverted
>>> +      (1 which maps to active-high open collector).
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    enum: [0, 1]
>>
>> There's no need for this to have a value, it's sufficient to be a flag
>> of "ti,alert-active-high". Present would mean active-high and absent
>> active-low. This has the added benefit the devicetree node being
>> understandable to a reader.
>>
>
> Agreed, makes sense. Even better, at the same time simplifies the code.
>
> Guenter
>
>
Agreed. Will do it in next patch

Amna


