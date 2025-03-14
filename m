Return-Path: <linux-kernel+bounces-560549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F79A60676
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 01:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B8963BF5D3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 00:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269B01FDA;
	Fri, 14 Mar 2025 00:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="MqVkpAgj"
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010014.outbound.protection.outlook.com [52.103.68.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72290623;
	Fri, 14 Mar 2025 00:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741911111; cv=fail; b=kyIcv961plk/NRZeq80sydYW3RcB86JcEwSeHX1Mf0+tQqio22WjQ2/YJC1FoUoJo/vJVWc2wD886QlHZOut+6sTGLxD+RQZiTmG3a6cHW4itFJiMUPgaTbJuALhJiMlGsesFxGswn5esrlFVbJeXW8dxYtxASqmx1SlnInA6uY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741911111; c=relaxed/simple;
	bh=2t6tINF4252ZodYaarKjHsRMEOJYGj/c7fJpDAyFWhM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F9/Cq2tjG+gyyDnwkbehZbQKuwuly14rmOTto3HX+JLITqMDrVgKziKtHlTvA7JeY8cVS14Xn3JERagqJi7nSl6LmfTZSY/cDPR58q2gqZvitz9W6jxSuA4AVXJ5QmqW+5G3YKHkI8YYMgadPZ0yw31JTMpOWV/fJVHteFO3kvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=MqVkpAgj; arc=fail smtp.client-ip=52.103.68.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZD8EC1FqDAjYA4hSz+9kUqFg026m/3cMYvKAts6Mr4hDSIgSD8e5fR9kGYv6LAB7/ufzk9EUB+w+ORXs1l0bUm+uvKr5eTj855RbZYYrlc70/mTFOlfJMJeI+NHqx9p8pXw6mZk2YfiQ0sRYulL9I63PRURr/etA7Rck8BwexFWZnwhqnmQIhTz2Isd3OtXtFzRzsw5AU1uyweek12KD758dcZlAJotpn6WNj+rn6TECC9jPLbOg0oP9vRaGlPjhIMJjIqXaUHBzi/nMJtjh4jTrX7PTk6YK2ImgTZtQkNysPOFW8nrkmtEqTYoQl1Ugp08Wguy7qw967qFWTVW5Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wQdcOThbgc4RrtMFGz8KsxJ+bD+xNw+EmDUAokxWx2g=;
 b=kg6eJw69q6Y1pPAy4SXnudl5RvKm8uOzSbTbF4GD5FzAeP5ils1+hojO+wkTUBpikxABVte7v+wZMYQfJz32KL4EurOOPW+4sWtlG9Nk3SU6a7t0MdCU2VsHPTd/HLmZKknNhOGXM8/Zx/9jyUtP7k+tTQXv0eMxLxbaz1LJbzgFb0Y2rAgOWtvC2sOj1X7sZltnpXbk/TXeTKaUkbsw2Dini2U8ylBkd7YjpcWDPQqZa+z+9pdr9RNSiX/PtYAGEFB+NMShsZyH7zWbbAeZ7YGpHZR7ZtaQCFn9fx7cxMuL318kQek1ptDFjulc1y9uzJQp1f1P1gOg1f15pVEQeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQdcOThbgc4RrtMFGz8KsxJ+bD+xNw+EmDUAokxWx2g=;
 b=MqVkpAgjmA4CoIn8NHpbBnR54+1dVki1uVeMTMx/IUAJA9m/iTCXw+ENDDhQXEGjIOKGSM96iwDJA6nIHTJXTIW2ckvKZVGsDK6ghVkinmRr0dEohBLo9Ll9TDKFpQRaS7+2SQkhzEDLtNOmdvkPf0Xn0hiFghXkNPuGbfEueE7Xbn7kzVoJxH9XB8sRNuebz5VTaGbDMrcs5yguuC2vT+W4+juQNDGiCLnoD+vWddCCIpSI5jqL/jq4uBCo49WFnNNPMLV0GKaiQqfZN3+5piT2iAVPzB/LICDQv8VAkkfJlQoK8564bTUp+djXtS9ohp2KIDlB4oDr8BvoSo4vIA==
Received: from PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:1eb::14) by MAZPR01MB7311.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:46::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.30; Fri, 14 Mar
 2025 00:11:41 +0000
Received: from PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1b4f:5587:7637:c5a5]) by PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1b4f:5587:7637:c5a5%3]) with mapi id 15.20.8511.028; Fri, 14 Mar 2025
 00:11:41 +0000
Message-ID:
 <PN0PR01MB10393B82EB1038F184FD18894FED22@PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM>
Date: Fri, 14 Mar 2025 08:11:34 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] (no cover subject)
To: Zixian Zeng <sycamoremoon376@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Inochi Amaoto <inochiama@outlook.com>, Alexandre Ghiti <alex@ghiti.fr>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, sophgo@lists.linux.dev, chao.wei@sophgo.com,
 xiaoguang.xing@sophgo.com, dlan@gentoo.org
References: <20250313-sfg-spi-v3-0-e686427314b2@gmail.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20250313-sfg-spi-v3-0-e686427314b2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0025.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::10) To PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:1eb::14)
X-Microsoft-Original-Message-ID:
 <731ad3d1-0530-4b09-b9c7-25de816d82e1@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN0PR01MB10393:EE_|MAZPR01MB7311:EE_
X-MS-Office365-Filtering-Correlation-Id: b0b50d33-dbf7-4afd-4440-08dd628ccbc2
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|7092599003|8060799006|15080799006|6090799003|5072599009|19110799003|461199028|3412199025|4302099013|10035399004|440099028|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZjEza2pYa3hvUkJxQzB0YzVDektZVFFnMDdyRmhvSjFSYVNJU09IYndURXNH?=
 =?utf-8?B?L1dkYmtPZTdvUkdNNUFVanFDWXBuMGxMV2h0NUozMGk1RklVc1A3K0hUb05p?=
 =?utf-8?B?aUJac3JJclREZVhodW15bFh5OTFoOVFFeUQwZzQ2SEU5emRIbWJWWlE3WVl3?=
 =?utf-8?B?VXJYWEJyQlptV1dtU1U2UkllNjMyZnBVeElBZnBnczFyMWxnNllTSjZWT2x1?=
 =?utf-8?B?cEt6ZGVsTGV1bVdYcTFtaE5pSTducTNDNzcyalRCUVR0Tm1iaC82UzFQVE1D?=
 =?utf-8?B?TlF0VjRmeDJ6bDF1ZHZNQU5MMktMM0dpUHpsVFhDeDRZV1YvSnZ4VU5ZcGl1?=
 =?utf-8?B?VHNEakg1ODNVUk5BdXh1akk4WExjZURQS3dwSzlBeUpBc3RkT0s4YVlDdVlT?=
 =?utf-8?B?TnZ3cGFwd1dONzU1WncrUDJQeDQ5V2FhQXhQTnhxbkI1M0lycTRGMlpqUWw2?=
 =?utf-8?B?M2tRTm95bWhxSzYrZFlWM1A0TUhJbFZIWWZhNSt2RzFVWDdTWld3aFVpSEtU?=
 =?utf-8?B?dUorVkVtb0lnOFNzYTB5NnVneWZpODJ3SEk0bVRmd1VGLzZJSlIrdmQxUi9P?=
 =?utf-8?B?NHNNK2FwYUpGbWtvQkpUYXRDalFPQk5VNXJxY3J5a0NTK3htR2FJcnE2QTRi?=
 =?utf-8?B?YUpuRjY5MHlUNmwvVWR1YVY5RzQyUlppbEtYMndhTndJYU1aYzVxaEdicG9I?=
 =?utf-8?B?Y1ZUN3JLZnJBdVMzU3ZUbkFwVmkvT0FWN3lOQmxhZFBDZmx3ZXBPUXF5ZTNZ?=
 =?utf-8?B?bFM0cnZTRm0yKzR1d2VuT2VMNnNKMzBEdmhOTllvc1J3VzNKWU1nTDdPWFJ2?=
 =?utf-8?B?Yk5UTWxqV1hYUytwSVpOczIrV21zOWozM1FLY1BkNlltTDJ1bVBjYTlLYjFz?=
 =?utf-8?B?eW85a1RnSmVYTUQ2K1VUalQvYjZxakY3QW13U0gvam1VbHhKQ3JYYW9KWkdM?=
 =?utf-8?B?VTR6VHNRZ3R3TUp4b3V2WE5aQUl3M2pPTEpqTVhpNWwzQjhYN2xFcVNhVVN1?=
 =?utf-8?B?ejdhYmsxbGxkQ1FkcjhpL25MR3BiV1pudUVXSjB3RlRmdVBvMm91TjB5dXdr?=
 =?utf-8?B?eHk4SGcrN05RZ0NOT3M0d3hmUGFUTkJuM2c0WFZQWlRvNHRXSFFMK3A0NkFR?=
 =?utf-8?B?Lzd6cmFXWWFmN1NaUXVpRXlkWGRRLzhEYzR1SUhqYnhIMnBoN1JKQTVneXd2?=
 =?utf-8?B?dFJEcmtPdis3SmcxTXQwZHpjbkJIRzVaZmJRT2V2MEN5azZTL0YrczVCR3Rx?=
 =?utf-8?B?V1BjVXlVR0hyQVhiNG53M291VXA3NTRuK2lYcnRuQVdDUDg5WHZ5TUdMUW1G?=
 =?utf-8?B?RzcvZ0R1VEZ6TXZ4VTA5OWdjaTNPcmlodE0wUTZibGhJQmVBLzVHbXdhbm03?=
 =?utf-8?B?RnVZUjlua3c4eHRpMEFJOEc4YnIza01BdnlKbW1Va0NZOTJaSC94azNXeCtl?=
 =?utf-8?B?T1A2TXQzRGhoYjBtUFB5UFUyclFKeXNtS1lZcDkxN2R6Q2ZoT1JsbkNpblVT?=
 =?utf-8?B?aVcvMmhEMWVQTXlhTCtlUFJNRGNYRmFab0F6Mk5HM0NyUkdFaXdKWVlweWtF?=
 =?utf-8?B?WTlMNHF4RG5CcXFINFg5NzBKSDlaTGRIbk9HeDAyR0wwRFRoc3k4cnV1bThq?=
 =?utf-8?B?dnNxQW1zWFNnbmNOTVgraXVVVDRlRld0Y0x3T3NiRU9zbTBaVDgxNGxIcUxC?=
 =?utf-8?Q?IK3gW1yVrR/p8EFn2AbJ?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YlcvZXV1RUtFU3k0TjQxM1JsL1pkamlObzA0b3VxVlJkQXRtZXBVZmlCMmFL?=
 =?utf-8?B?cEdJM0tIcllObkpwMmM2NE1ZRFN4aGRRVVRPUGd2K2RQWW54Z2NQa1FGdC9l?=
 =?utf-8?B?aVpKaU5XSWFkM2pHcUVoVXlCYUdDYjViVWxJOE9PWTVxUnJxQVAzR2c3ZHNi?=
 =?utf-8?B?b2dOd3J3cHpvRkJSaC9mdnFvaWg1ZFkyRGFkcVF6aU43VnhtKzFOREwzTi9q?=
 =?utf-8?B?Mk9MUEdWMEIxRXpyZnlWbmYwZjRJbWRDaVFiTldrV3RqU1pTei9uSEQ3aFF0?=
 =?utf-8?B?MlNIVHZXQVJ6VUhqZTVUUGRvSUhQR3lPNGVqVW1yR3NYRVRxZ3hkaldUclBk?=
 =?utf-8?B?YjJiRktpQ215djAwcXJMQlRDcGpuWll3VXo5ajhTcnVqeHB0NWlETmgvUlox?=
 =?utf-8?B?S3ZydHFyMnNqMEFLdmVLeEhJTjVCd04rT1VORitCdS9BNzFJTEc1RW5TRmNz?=
 =?utf-8?B?THVWeEkyVmJTaG8vNUtUOUxLbmh1UkNtZnZ3UGFwYnBRTExNdXZBNWtENFJs?=
 =?utf-8?B?enJTdEdOWW1mazVtNGdjSFJ6TjNQNWdCN1JzVWczMnV3cWN6WXVhT1dOTkJo?=
 =?utf-8?B?d0txUkhaM1JZSFFTK0podjFPQStMT3o4dlRzTm1pU3pnY04xL3d0ZlZZYVFK?=
 =?utf-8?B?b3d3WU8yUW1tSlFHaHRCTGdNOTdGT0kyQU52SUxTaHFsYjZNZWNjN1E2ejFs?=
 =?utf-8?B?eW1MelhLVk1QcC84U0dxOGVWYmIrVU92L2gwZU9qTUtHOFhsVzA1dUFseXNV?=
 =?utf-8?B?ZkN5cFo1OS9ncnBvVEd6cDUwNlYvb3dab2szbU43Mi9RNG1OQTd2d1g0c3Ay?=
 =?utf-8?B?c2d6QXBHMnd1TGY1UXR4a2VjRlBrYUExSkJsSDJPRzFUcE9oMUpRdS9vcVNT?=
 =?utf-8?B?ditYR3dUcmpUY2Q5d0wrdkd4Wmp2alhRR29sZVcwNG1xdE95VjFpVXZTQTEy?=
 =?utf-8?B?bFlrdTBiRDcxRWhHYXFReVpFcmtYOVhrUHBjTklOem1QS3pTN3JZUWJJMDBO?=
 =?utf-8?B?MzZUSWh0ekFMQUhxcVBKVHBTQk5FU2c2azQ4STZZbGYrZ1pSVnlZWVVDQ3hK?=
 =?utf-8?B?Q2pIV09kN3pJbHh1R0NROWxIaGZOZXFYYzhhQ3I5aW1QczlJRTljRTB0N3V1?=
 =?utf-8?B?OHFyNXlQV0VEMUlVQVJ5dXNNeVpjTnJnYjJucEVNM1hOUUVOc01SV0twT0JF?=
 =?utf-8?B?L25Sb0ZqdGlyMTRyNjJlTzdxcXdmZHNsVjRNSEJHOXU4MzYxL2NsNEN4YnB4?=
 =?utf-8?B?MWJpbWlTUEFpNmxiSjNyUUZLcEFWMU84S1YrLytJNFBFeFpaWlZxSDdnQXls?=
 =?utf-8?B?UXRURFd1enBDYVVYdE1yNk5KaXNWdVNvc0NKZzNIRVU2WllOQ0UzV3B4RDh4?=
 =?utf-8?B?K243SWxXRmlqQVJkaHJqejZyblVOZGNIcGJnS1VNVTdOcmZKaTNKUEs1bklm?=
 =?utf-8?B?eWhhcnBmeDM0UGdSZG8xeG16b0oxUlE2TDlRL0ZvK1BMNEJGSHNLSjdubDY5?=
 =?utf-8?B?ZEhRWHE2c1gzdmc0U3hpZTFKUEtTVkwvMXM1WHl0cHFLUUpaUGVuejFHcXBS?=
 =?utf-8?B?MTh6WFFaTllQbnJYc2w1SkxzaFJ6bGQvdEVJWGtwekk3VEh3YmNPMVlJSExS?=
 =?utf-8?B?SUZId2hCTmRFVjFCdWI2UDFKVGdHRGpsbHhHRVNpWUNibGFGaklqMnNqNHdH?=
 =?utf-8?B?dC9tWlFJQlRtN3ZIVTltM3g1U0lwS2dDbkFlMFlsb0FESmZqZFVZR0Q4anE0?=
 =?utf-8?Q?9TXsWgRE7AuKdeoPFsN0LlmYCsbsUEK1+KWRU0R?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0b50d33-dbf7-4afd-4440-08dd628ccbc2
X-MS-Exchange-CrossTenant-AuthSource: PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 00:11:41.2332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB7311

Hi, Zixian,

First, it looks like you forgot to write a subject line for your email.

On 2025/3/13 21:11, Zixian Zeng wrote:
> This is tested on milkv-pioneer board. Using driver/spi/spidev.c
> for creating /dev/spidevX.Y and tools/spi/spidev_test for testing
> functionality.
Second, why is there no description of what was changed in the patch 
set? Maybe it was missed.

Introduction to testing can be used as supplementary information, but it 
should not be the main body of this email.

> Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
> ---
> Changes in v3:
> - disable the spi status on sg2042-milkv-pioneer board
Not "disable", should be "Remove", and please capitalize the first 
letter of the sentences.
> - create dt-binding of compatible property
> - replace the general compatible property with SoC-specific in dts
Another relatively important change is about the clock, which you seem 
to have missed.
> - Link to v2: https://lore.kernel.org/r/20250228-sfg-spi-v2-1-8bbf23b85d0e@gmail.com
>
> Changes in v2:
> - rebase v1 to sophgo/master(github.com/sophgo/linux.git).
> - order properties in device node.
> - remove unevaluated properties `clock-frequency`.
> - set default status to disable.
> - Link to v1: https://lore.kernel.org/r/20250228-sfg-spi-v1-1-b989aed94911@gmail.com
>
> ---
> Zixian Zeng (2):
>        spi: dt-bindings: snps,dw-apb-ssi: Add compatible for SOPHGO SG2042 SoC
>        riscv: sophgo: dts: Add spi controller for SG2042
>
>   .../devicetree/bindings/spi/snps,dw-apb-ssi.yaml   |  4 ++++
>   arch/riscv/boot/dts/sophgo/sg2042.dtsi             | 26 ++++++++++++++++++++++
>   2 files changed, 30 insertions(+)
> ---
> base-commit: aa5ee7180ec41bb77c3e327e95d119f2294babea
> change-id: 20250228-sfg-spi-e3f2aeca09ab
>
> Best regards,

BTW, I suggest you wait until 6.15-rc1 comes out before submitting the 
next version, because I have already sent a PR to Arnd for Sophgo DTS.

Regards,

Chen


