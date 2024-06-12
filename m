Return-Path: <linux-kernel+bounces-211007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1550D904BF2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 08:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EB561F21BED
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 06:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7151E16B73E;
	Wed, 12 Jun 2024 06:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="E7lRiZTl"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2083.outbound.protection.outlook.com [40.107.105.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5570F13CAAD;
	Wed, 12 Jun 2024 06:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718175067; cv=fail; b=qsS0zF7uUUQGowknPzO5ZpTww2hjMhVHxsJoLYNwav2VLd+FpJGGijdL8A9LuLs/Je3eTmdsh+B5SfYL3t4i0VttvwfpKGThOwY9rl13ufiNM/jGKj15O5KcNVr3Z9Wy1p+vilfYIK/dppvspIHKM2W2MoKokseSY2ueXUPFa3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718175067; c=relaxed/simple;
	bh=COW0IQn3l4MiMmYw9byfh8ewhHun0RI8n7SC8Z6EN8Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e8gDE8e+/JB4+5r9l4AR+z4OdIKEG4YuupUMBTtPOq0orOUvBvTbZM3braXFLlLPaeZcYRskZ3iTCp30gDT8++w1iSTXFfSLKBNw8x1RFyOq1njeciN+82WYNQFWh1/VLCxdh1+Rba7mCUMQsd2NGGw+Xu1L6FoAh5kdw5QI/Hk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=E7lRiZTl; arc=fail smtp.client-ip=40.107.105.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QzaLo1uzjRLS+WA+DMdZ9hDet2+ohEsRm1qP5yA0lfXdbKWrYktpKJEgYpP3OXhXZWblB9+lP/oNjKsxQkxrBuXMgm5JB/8EkvEGrPaDsgjZQO31maJ9pz9yIGeFyWjY7yIvukjVKFmbAhbLi3OmVMR8pw3U1zcdhggeQLjyG1dM6ZXZRw0ZfGJTuR+bIT7ZcmnsgeqdCSgLQmEki3N04EN0vePjpL9H5iaZnepmyW+8K6Vrr0ciPKYKYIo4KQzwakfPS9Zh4cuFQeni9lxADy8+SrQ/f3k3Wb6LMUoFSmmoTBG4vk7wuMDlm4am+T1WDVjplOC4XkLnqmAfz/85hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6+bY4ESPFcDF/2RCPCpyV9q6qqMfJHDhrPj1nmckFh0=;
 b=aveJWldeBJcCiHZ3hLeNVawBWF+ewQkFjXnleN2xMz6F+BOMpLhwIGmyrFtWV4oL5Q8b9pfi2KV9JOjspSyDJSKsjmS2kV9KD3WDXZXxCXXIelBnlKL7D4OUEcI61fXAJgFnefszRvppdVADK7IgIcu1+P48z6oGoqXuEz/79vlaBa9SSdGLJHF1BbqoPae5brqU/8coAZv/ODMI3c/rBzHCOnI6yYlJHAlfwNzD/h/air8Cw/kYj52sLSTcZRJc465eNKI9yzH/JewTNlU4koniB7XoPblRUKuptIWeGJmAkVaPZdOUUWGYufQt3oB1EcfPIgI5AQ4P10yj0r155w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6+bY4ESPFcDF/2RCPCpyV9q6qqMfJHDhrPj1nmckFh0=;
 b=E7lRiZTlzjRDPsA+qLIo8VcNw5zvp8+Pw6nyQYYpqy5nugWzB9GiA7Xbg8JgbIdTLFeOmeF+ffLU4uFdCQ1BXKGBPQ8yT0gLnO0ffvW3XtDn9DrWzCoMuHASw5ea7oRe8F+6efw2Fi1LqveT4mSz1TOu5ACHrgpBt9pcetpVPv8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from DB9PR02MB9994.eurprd02.prod.outlook.com (2603:10a6:10:462::8)
 by GV2PR02MB8894.eurprd02.prod.outlook.com (2603:10a6:150:b5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Wed, 12 Jun
 2024 06:51:00 +0000
Received: from DB9PR02MB9994.eurprd02.prod.outlook.com
 ([fe80::f9a2:77a1:a5aa:8f8b]) by DB9PR02MB9994.eurprd02.prod.outlook.com
 ([fe80::f9a2:77a1:a5aa:8f8b%4]) with mapi id 15.20.7633.037; Wed, 12 Jun 2024
 06:51:00 +0000
Message-ID: <e0de79ab-63d2-4170-b90b-c714454285fa@axis.com>
Date: Wed, 12 Jun 2024 08:50:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] hwmon: (ina2xx):Add Suppor for passing alert
 polarity from device tree to driver
To: Krzysztof Kozlowski <krzk@kernel.org>, Jean Delvare <jdelvare@suse.com>,
 Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@axis.com
References: <20240611-apol-ina2xx-fix-v4-0-8df1d2282fc5@axis.com>
 <34fe20d5-c67a-44e6-8ec1-566d80e25447@kernel.org>
 <ef71090e-13c7-4ef1-b34e-d6fe9546b705@axis.com>
 <629a1867-94b7-4f89-821a-a38b92189af5@kernel.org>
 <4af156a3-37a6-4995-a3cd-8340c17345c2@axis.com>
 <2e0eeac2-891e-44c8-a1e1-36ec759d1b84@kernel.org>
Content-Language: en-US
From: Amna Waseem <Amna.Waseem@axis.com>
In-Reply-To: <2e0eeac2-891e-44c8-a1e1-36ec759d1b84@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0013.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::19) To DB9PR02MB9994.eurprd02.prod.outlook.com
 (2603:10a6:10:462::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR02MB9994:EE_|GV2PR02MB8894:EE_
X-MS-Office365-Filtering-Correlation-Id: fbccd3e4-b67b-4db1-ea09-08dc8aac04a7
X-LD-Processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|376006|366008|1800799016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S2p3aEJjaVpBTjlWT1F4Q0FYcW5nb01ET05sVjRINlRiL3NyVE9NdEtzRjNa?=
 =?utf-8?B?SFdDc0w3NWtkK0xMRmd5bDIxa2VveTg3ZEpMRyt3blRwbDR4L2xvNkhBS3hU?=
 =?utf-8?B?UHYvNGEzUm1KdG9rOUR1QmVZUlp1d2xPT0ErVGF4NFE0Q3BidStnS1VQcDRs?=
 =?utf-8?B?ZFVzQllBZmh2OUw5aTE3cElXTFB2b0kwYmZEekhxb1ZNbVJzY1JUVU9vOTBX?=
 =?utf-8?B?ekJyaDRKdXQvNTRkTTRhMjJEdG5LWnlKeThsUEhpNXAwV0RMalVQRmtiS09D?=
 =?utf-8?B?d0U2eGE2VkUrMW8vZGtIZWZabzc0VFR1a21MdzNQM2VvNUtGdHFCdUQ4VldO?=
 =?utf-8?B?dTZWdllGMDFhWGQzeDNaYXREVUFDUUg4dk5OZ2dObSt0UjQxZFhIVmpwZmUx?=
 =?utf-8?B?VVhHWHVEMzFBVUpYZ3FkVGZ0L3dFMjM3b3VxK0RJUUVaRjBlNzBuUnVQL0s0?=
 =?utf-8?B?QWRueWUrV3NRSVJIeUFraWJwV1kyVWErTU91WlhNYytDczZxQS9PakMwM3g3?=
 =?utf-8?B?ZHhIS0VFZHhjWHYrZmRQR0wxSjUxTlpLUjhQeGtkd3M4U2h4UGd1R2tvNmpH?=
 =?utf-8?B?ZkVrdFJoWGtyWlN6TlZpMk0wSEc3eHI1Q214N0IyNGpuNWNEU0V5NStrTWlY?=
 =?utf-8?B?dDdyakNGTXkzZ2pQRWFOanIvT1RoRUI1R3RnSExnL2IyZW53K0hwRWhZRWxG?=
 =?utf-8?B?eDRCY09iek94SURkWkUvZ09lUjBLcEM3QzkwRnA0VVE1dFU1T2dxMGhKRkh5?=
 =?utf-8?B?djlZcmd0dWJRaWx6RWNmQkpJR2ZydmhOTnpWeU02U2xlQmNTS1ZkQ1dLSFJV?=
 =?utf-8?B?Um1rV2lnR2ZaMGkzaFJsZTZzRldFenhYRUNBeEQwU1lkTWhWR1BaTWcybDdt?=
 =?utf-8?B?T0xMaGVtR1FTdDh4WW1lVEVEMHVicit3SVgrc21XaUhLOUZJRW9MMEF5RENW?=
 =?utf-8?B?V0pyUTRWU0lqaTZlb1ZkSG9wNUdTeHZSU09wekpqdGNFTXZXbjNuYkpyQ0Nq?=
 =?utf-8?B?TXdLVDBnaDlSREpHM0NSQkFoY0MxYWFMdElmeFV6c1drbStCMjZpY0dxK1Q1?=
 =?utf-8?B?TGZ2VjZ3eW9xd0k3MVR1VG40cVkvMTh1b2VXclkzZDBxL0FzbXFkdkR4VFJ1?=
 =?utf-8?B?ZWVLTEt6Z2pMYVpxaEgwNXN1ZVE2K2xFM1QrYzU1bzVIbWJYMmw1dHdacmcx?=
 =?utf-8?B?YnFWdlBINGRocFBFRkNWL1k0VE9ja01HRjc4OFpiV0lhMmVwcEt6V3o4ZUFM?=
 =?utf-8?B?bVhoME54UjY4TG1rd0RRZER2SDE0UmtrdCtia0NvRHdGNmM4Q2VKWUlqaEtF?=
 =?utf-8?B?RTcxbmF5c3hVUFdYRGI0RmtrNXRYbytiNHJjOXptd1RFcVRHeTNZZHRlSEdT?=
 =?utf-8?B?TXVTOHd1OFJKaGxyTlovK3F3ZEwzOXd0cUNlZ2hEV3p3dXdaKzBnZ3F1MVZU?=
 =?utf-8?B?bEFFODVFaXJkVkpwMEhFMHZ3Rk81UFNPdWhiaTJMc2gyb1lCWG1aUTgrY0do?=
 =?utf-8?B?YVhZMDBzV1p5cmhkRzZxY0ZkRk0vQThFLzNWQnYraE8wVVZLSS9LVFcxQXlP?=
 =?utf-8?B?RFpjYzJSY29VMGhPQnRGSVVVYmRQUmRjOXJmWFhRN1N6RVpqS2VsZFplcmZi?=
 =?utf-8?B?eEVLSzVhVkcrMHpZOFJOZ0VYTGN2OUIwSktRS1RyZktvNys2Y1BpcS9uZm42?=
 =?utf-8?B?bUx5bnU1Q2ZNZ2VYOFpmdzBrbmNZdHd5M21qNytYL2RvcENIcS9jTm5FZ3lr?=
 =?utf-8?Q?tAcb4OLkD9ZFPnvZnk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR02MB9994.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(376006)(366008)(1800799016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z3Fmejd4MHR1cjF1cGQyNjJ1OWtRSTZOdmtXcWdWbXZxZXZqZnBSS3R6M05J?=
 =?utf-8?B?cGY4T3JaK01PWHFJKzVFUThkT0pkR2JVc3Z2dnRYRDJnN3hiYzhZbDhJM3VB?=
 =?utf-8?B?U1lWNGcrWjNvWjdDeG1kdi9ad0c3My9oNmdldXdIUGRXSVZlUkp3aElYSmRx?=
 =?utf-8?B?ZEJIUEFmT3JhOUZyWUpBTGpVWTIrTTNoY0R0VWRVYkNuZzR6SDAvWVhzb0hE?=
 =?utf-8?B?SFJ2a01lYVRrMThhVWtFTWp3VWg4OCtRdnNNVWZTdDVsOGorYnJwN2ZVeTcz?=
 =?utf-8?B?OG1CdXg3bWRPZXBWaHBoVENUbWhPNjJMRkVZbVdwK05STTBObTJqZkZzMit2?=
 =?utf-8?B?ZDh2V3R0L0d4LzhUUHhsU2NLUmlLYzFJMUNxcUxoUThBd3kxQ3NrcDlmeStX?=
 =?utf-8?B?ZFgxYi92YXdFYXkyZHVmQkxNSVVVZFlBcnRMa3pYMU1GcEVzUkVFZVVUM1N0?=
 =?utf-8?B?aHQ2NzEzUUsvdFh6a3JZWGxZbzhqaDRvTVhXMHk4ZzA4SjFwMDlMMTRteFh5?=
 =?utf-8?B?QzEwMGdKZTN1d09XcWJtMmo0ejM2TnhYNkQ4OWlTZkh2SVN5SlR0ZmQ5NXht?=
 =?utf-8?B?VEdyL0tDcVVMWnJFTUM5TFdySlJLbmN1N3JocmJ3bk55cUpyR1ZGcDhyVVJk?=
 =?utf-8?B?VncwWlRnY3VkSkd3cGtuV1hwTm9WbWR6SVFKZ3hPbGVoNmZiM0FmaG9kMGQx?=
 =?utf-8?B?Z0VWdFBvOGFXY2FNN3NUZHJWbW9MNnhSNlcxc2F1OVUrdlV5d3l2VkVjNGR3?=
 =?utf-8?B?UHptQ1ZGWEhmUWZGaS9Ha1hXVDc2cHdjMXlrdEtjcmZwN1lrWnM5S2I1ZmNK?=
 =?utf-8?B?SjdzR1RUSkZNekxYSWJ1bmEvamo3YU4zamdiTGVJbmoxeE1rVVhnYW1CKzZ6?=
 =?utf-8?B?a3lIZld6YU9LRkV2bG5GaG1EYUhQT2MreWptNUc0NkxSL21aTUdLbHg0RzBZ?=
 =?utf-8?B?cWdmRE9oQUs1ZXVRTE9ZRnRpR1lYcmdmb3J5Zjc2anRBV1J3VGIzaTdZdnIy?=
 =?utf-8?B?K0tZRkRhdDZRTjZmaHVRY25Udkdjd3YvY05HVkRNcjN3VFEzTVlpTW9xVXha?=
 =?utf-8?B?UXRIV2dWYlNaa1VaUnhlcWxVV1k1bXd3d1NFYlNBQitmWUNDWldHYnQzZlY5?=
 =?utf-8?B?NzBQNUFSa3FYWmxZREFrenV0aVM3QnlNSFg3RnkyZjF0MDV0dTVZVHhFNHRp?=
 =?utf-8?B?ZUxzUVdlWHQxekoycUphYW1TUzF5VXloaUVkOXNXQ09mOHlkY0lVNFpzMWtl?=
 =?utf-8?B?bFJaSmE1UU9mK0hpenN4ZDJBKzBWUEd5M3BKelVHd09GSnlyUlI5YWh5anNz?=
 =?utf-8?B?WWpPY2paR0VuTlJTWEtGMUR6ZW44OUI5bXRYb1NwUGJTemRxbC8xaCthYkVv?=
 =?utf-8?B?S0hUS2l5d3VhS3hmU1pDL3QvdmNMc2VFbEhDNTlYZmRCOU9OMks4ZG9Ba3BR?=
 =?utf-8?B?WFRCMTdxZG0zc1BIc0NpeFh6UUpwRldoaVA4WkgxYXRYT2FOcnlQNUsxWk8w?=
 =?utf-8?B?NXV6L2R1TEZKaEdYNHFZWkc5SllnZFhwOC9Camo3eGcxZEltbmpkTGNQNm1r?=
 =?utf-8?B?T0kyV2phM0x2SzNPV2RiZUd3UDBheDNZazQ3N0tjWkdrejVOczVOZEg1NGQy?=
 =?utf-8?B?NUVKQTgzc3ZkdGVGTE1jVDRkZUlwcklXTGFweVFMcUJMYnVNcnNBTjgrczJq?=
 =?utf-8?B?aTFoWG9wenhaekZQUVhlYktmMEsrb3A1MkxPY3dteVhKb28yYmJxcisrUW1r?=
 =?utf-8?B?WnRCSjBPVDdjZ1kxa3FDbzRQM2xleHBRRFg4Q0NWaU5VL3NCUnBIMkd5Y2Y0?=
 =?utf-8?B?cm1RTDEzV3BSREljTW1mUTU4UWY2azF4ZC83ZkIzeTlvYU56Sm9lbElxY1BN?=
 =?utf-8?B?N0JuR2o1L3hmMlJhMjZIM3NQdjZ0LzRtMi9tY3FrUVNDRUhzampraFV5UXlM?=
 =?utf-8?B?ZTNMV2l0YzRkNlV3dFdhT1NhM0dSU2s3Z2Y0RWpyRDdJWHdhMGxpOC95M3VT?=
 =?utf-8?B?U2ptRXIzd0pFUzV6TFBGOGIycDZXRkRhN1JNNHBxN0k0RWZ2aGVNTFJCbUFN?=
 =?utf-8?B?VUR3eTRrRjdkQmJ3bU9ncnExQVRoNzNORWpBSjBZUDNMRmZJcnp2V2x3ZTcy?=
 =?utf-8?Q?MgCg=3D?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbccd3e4-b67b-4db1-ea09-08dc8aac04a7
X-MS-Exchange-CrossTenant-AuthSource: DB9PR02MB9994.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 06:50:59.9013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4POx6uKjGVBiEoJWhjGzk/szBPncZGliHxsxQxrcI88knqPVmr6j59lw7MWOeGcj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR02MB8894

On 6/12/24 08:44, Krzysztof Kozlowski wrote:
> On 12/06/2024 08:37, Amna Waseem wrote:
>> On 6/12/24 08:20, Krzysztof Kozlowski wrote:
>>> So you require someone to re-review?
>> Yes that will be great if someone re-review.
> You are joking, right? We have hundreds of other patches to take care of
> and you ignore review tag, so you get duplicated work from the same
> reviewer? That's huge waste of time and actually quite disrespectful to
> our time.
>
> Best regards,
> Krzysztof
>
I donot mean to be disrespectful to the reviewers. Please ignore my 
re-review request.  If the patches needs further changes in the code, I 
will add the tag in the next submission.

Regards

Amna


