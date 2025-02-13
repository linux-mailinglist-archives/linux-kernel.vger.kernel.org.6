Return-Path: <linux-kernel+bounces-513039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 750B5A340E5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA707188B682
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 13:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB9938DC8;
	Thu, 13 Feb 2025 13:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="G8xdiHJ7"
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020116.outbound.protection.outlook.com [52.101.189.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1464524BC09
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 13:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739454957; cv=fail; b=h+MHsvq+F5IGLfg26xPLbEZzCahLFcdTxMOw2A5AFRHU5VV1isY/TiT+/K2csqkrxH4ObOtuBGCn7kBIJrk9rQJozB74lZqDJG/OeDCfN2sYYYqjHlh/FrA+1R+y005fi6+eH4mMnRbrhw27CEpnItQ2mjMDsSRYrHjluwOAWLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739454957; c=relaxed/simple;
	bh=GZWKdNKf5+cX6ZH4AFlk16Vw5/SBgwTGZVKWKRwcbKg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gY4zXoCpRmNL72qkjdl84yshSrZhTwUlreFbyR9fJwWIhO1Vl8iTl4tUyMKwKtW4vRn8GEPg4Wt+BkkKaQu0P/DgMfbiQNL4HMetC7XJyFX3G/OeLFW2h+2S13oDjrVWvwCG2OFaA01oGAW5vk2fAerHNkMhrodBdvs3+KYIQ6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=G8xdiHJ7; arc=fail smtp.client-ip=52.101.189.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EtzFMjBQemIRfoxLJeiA1RA+PBaQQYgNIyZlA43CUPoz+jB2YxL+K7tBeKpuKL61Ay4z/jE4AClbCUWrCyWylrU69uBPvOsPKAnMxcgE3Yil6Orgzcfwtf0qPXN7sfo80DdvJjmD8NknEK+NqFDSiuUU0qmMCwmNPOSFzc8Z9SCggsZO+xVmiSKYrR7Yh8TRYXx0FD2TZdQRViRAEoCryctnX3+ho634KB0KFW6OyTS8WTaFhsNBstansPRAmh2fw0AydU4Jx3SMGkbUJ/iwnelXjnnphwnhkPn0yzFCLYl5PK8V5N3HIKHct5KMbLAQYEi8aC0CgdrDDyLsbV27gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+CDFf+NPeUCkQW4UdQC/TRoPI/KP2B0jvV4FQEzLEys=;
 b=wt0XlQxj78ZAWUnafMZJyI8tZ0bXiKH/ZVpFWZbp3JFPvfYyJZx26z4m1rKYx/lQ4WR+oO5Kxc9GKP4zpQSqFwH+YC9l6Zq1siFO8UnboXqkEzoGQ3VoGvmVhYH4PspJq5pUxrbcVCc6/wzl46IQ8bhIAnWvXCJYOBLYU8hEU0LdpHObxo+hwUZPiQsrAkKJYWxO5i3qde3Suq/w3oj/psNFH+QEp/zkhIg8VgYyjle1bjZ2KlSObL3HG1wU8EC9Rg9zOR9RrCTtA1ujv9biDpk43sa95WdOcu3TDWViFPqfVeKw+D+Iwpw4XY61ce2spM4Qwl/u1jWOi3GUA3WiSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+CDFf+NPeUCkQW4UdQC/TRoPI/KP2B0jvV4FQEzLEys=;
 b=G8xdiHJ7kqNmUwKBl+brO1RJ8kHgxtxYdoN5HNW3jTjjrWriuVn0zJvSuqPfDpQzRpgbnmWhlf7vh0WAbrYUCydkKraeBke2Tk0+TOZVhfQj+hmsgKnL5JJMywN+cJsH9Tt/MogojMCO5m27MRJH4Yyk2LPrEn4oSMhbOyzHnnNLJ5+c+kGM8TUgAkwctcBpBoXKcZyQebnDOHgLCY/+vw3OqZY7bmEKvoKi3DXG1rNc1NewN/Uf8N5MM9xZ4X0vvvOv2XRZtKqEYuuOIpT0AR2I69Omv3s8T6dZ9Fa4EcuQZ5GRWtoSPJzAqeH6S66IHu3qMww5wxHW31tTM1Ot2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR0101MB5975.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:36::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Thu, 13 Feb
 2025 13:55:51 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8445.016; Thu, 13 Feb 2025
 13:55:50 +0000
Message-ID: <1a295a1e-08da-4684-81be-9539773a1c94@efficios.com>
Date: Thu, 13 Feb 2025 08:55:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/3] sched: Move task_mm_cid_work to mm delayed work
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, aubrey.li@linux.intel.com, yu.c.chen@intel.com,
 Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Shuah Khan <shuah@kernel.org>
References: <202502131405.1ba0803f-lkp@intel.com>
 <17bda9071b6962414f61668698fa840501819172.camel@redhat.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <17bda9071b6962414f61668698fa840501819172.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0216.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::27) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR0101MB5975:EE_
X-MS-Office365-Filtering-Correlation-Id: a1ea8efe-4d32-43bb-d346-08dd4c36201d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZFBLelZmZGxBRm9JdFFManZydEpFeU5BcTlzQWdLUXd1a2tSU2QxMGxwOGd0?=
 =?utf-8?B?dTFEMEVUcDJlTW1JdURSNUFabldIRkJRRE1NOTlLb2ZxbmFxTWRsVGlNYVhq?=
 =?utf-8?B?YkpCczd2ZzE1SERDNWJrWEp1bHZBZ0ZUMHBNbnVTblpqTjVnWUJxOGtUMTNy?=
 =?utf-8?B?QmlEVFlXUUl1Q0RhZ0pMa2pOc0lvUXRyMDkwRytiSzhjU3ZkRHlKbm5VT25O?=
 =?utf-8?B?NGdVSWd1UTQ3MG9IR1phT2Jad082T05KZ1ZkZXVUSlRpc0FVcUZSUUUvT0hh?=
 =?utf-8?B?TnM2U0pCTnc1NWdLT3M4WGVGcVpwQkptb2hMck5jNTZIVVpiSElydUxCai90?=
 =?utf-8?B?M084c2xFb25xWlh2T3o1aHV2eWJxVkZ1T1pZT3BVTVZpeFdKR2xoZkQzRzAv?=
 =?utf-8?B?U1EyT2Y5Q0FZSjBnUXRRdlNjeFU0OVRrdllIaWFJNTN0TEY1VXJ6emE5aGFn?=
 =?utf-8?B?SEV5NGk0c25NSThMakR5cUFPVUt0MkJRaDIyOXA5U0lOYmNBY3ZST0QzZUxI?=
 =?utf-8?B?ekR0L09yUTNxUEl3SkVXK2I1THZycFF6VElvZnF1RkRHejdUdVJSbmFmRW1W?=
 =?utf-8?B?Wndua2xNZGNqeUVRekVZL3ZiSEVVUXo1ZEtzUDFuekZsMUp5NDJUWEtxcXlz?=
 =?utf-8?B?Vll3QU5NSXZVQ1pYcERqSTdzazNidHl2TWRnUUZraENrVTFXaWUrOTJlRE9u?=
 =?utf-8?B?bG1YdmJwZWNaR2daTkZYeWk2c1A5OEJqQ2FxWVZEcnQ4bEU4NUxYeEZzc2hW?=
 =?utf-8?B?NThPdGtMeGIvVFlPNWV1UlloV2FWV08wdTZTZGcxcmdwMThCaHRmZzZuektv?=
 =?utf-8?B?YzR0NkdLMnd0ZlJiOURqUnh5aWFkaS91Y0E5N1E1Y3Bocm1aM3MvZ09qWmQ1?=
 =?utf-8?B?UHJOZ0FpbFFTU2VDcXJodlBCWlJvSkJXMlBUMUhoZERHdUZBZVhwSUsyRXYy?=
 =?utf-8?B?clRrN3h1ZGVuQllNODU2MWttdFlSeGQrd1RXclBSMjV6T1I2dHhySmpYa2t0?=
 =?utf-8?B?c0p1UHd1c2h4M2txVjJpM3NCTEtlL3BJSWdpazhGMjJFYXFHWXRxb1ZYdTV1?=
 =?utf-8?B?VEpCa1ZmNGFUSUs3bmV0MmJJc1l1UmZOYTRCSGtHZTJKbnQxc3hSdDZkSGk3?=
 =?utf-8?B?aWdpTWFJbHIxbHZMSVA1QUFLaDVYZEtPL2w5Mk9EbkNCcXB4TFZCZlk4MGJ3?=
 =?utf-8?B?TTRXYnZaSDIxbHl0cDQvNEhSU2M5Q1VvdHlteXJvR3N4KzFCNElHWHZmK2xL?=
 =?utf-8?B?ZURYYTYzNFQrOVZ1MkRtWlhRZWI2R3lDVHFoand1WXRqMlBXK1hGZ2ZJYlpr?=
 =?utf-8?B?cnZOVjJlUXhzdSs1S3E1RVpRaE01MVJtSTkyKy9QVEVmd0kxcjMyTVBmUCs5?=
 =?utf-8?B?RXpvNFREZjVkaXVDVFhyWml3SmMza1RPOUpWak5RMjNQeFZNaEU1U3AyVlFz?=
 =?utf-8?B?bmg2NlBJS0gwRTdpOG5lZ0piUDVaY05kYnBRczQzdHg2cDl2WlRnVXptSUdm?=
 =?utf-8?B?OERwKzVheUtoelZnUmlVbXJrZmh4ZjF1WGRXWVRyQjRvNWV1SUp6aE53aXFN?=
 =?utf-8?B?RDMwVUFUekZHbWUzT3QzUC9URGZLVTBpT01ORUI2MnFRNHpKWnBYZkRIR3h0?=
 =?utf-8?B?aDlacHllWWFncHNnazU3enNjTlpBZk1RZG10Y0xPQTlLTUJLOGlNckJvSU91?=
 =?utf-8?B?OENDTjJJTytFZEZ5S2JqUXAvcGhQUmh1M0lwTVdsQXo4QXhBS1F0c2JzZFE2?=
 =?utf-8?Q?CxCeXIYOELzAieoMJP8mRu44/xXhEqrY8W//wit?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjFMTVRoUEJUblppRXpyY1NadmJycmp5L1pwbE1SRlhEcDR2SkpaOVFyTitJ?=
 =?utf-8?B?eHRVSGQzUUpkenNHSzliazA3OFN3ZUJMZkdlejVHOEVuWWFVMUVCeFRpKzBH?=
 =?utf-8?B?Z25TckZFVTZ1VTI4SDFUSVhzb3hWTHdmRTg5T1RpSDFMRkJ5Z1RLU1hEajY5?=
 =?utf-8?B?Rm0rQnhuTEVPcW9vdlJVekc3VE9QemN6Z3AvTDYxYlMrK2VCc0hjcjJZeDhL?=
 =?utf-8?B?MXhJOGFycklxREpBUmtkQ2J5ckZhMm9SN3phaVFKQTRtR2tYeURxUWR1MHdP?=
 =?utf-8?B?QndDZExaa3o1akdEUGZSOGJKcnpMSnEvbGFmSUZZTkMzVFNBaktZZmpVeWRl?=
 =?utf-8?B?bWo3c0UxQWtobEszYkwyN2dKNXF3OERWOTFWL2VmU2dtU25leFAxbWwwMUpH?=
 =?utf-8?B?ZStKVHc1UXRxS0FkVEtHbWxwUmFlRWlSeWdsM2dsR2FPQ2ZFNTNrWEw4d1k3?=
 =?utf-8?B?TWJZdW1xUXhjTzhtajZQR0JxZ25wUjZKcURTSnR3dDJyOTVFTGFFdmxleE1q?=
 =?utf-8?B?eFJxbldCSnZ6RlUyU0dnY2F2WW52aklpYUs2eGFpa25QbVV0NDJqd2p1Wndx?=
 =?utf-8?B?ZVFTb01aWFE3Q0FBMEZ5NlhvZ2oxb0hBVy9WVGtQMzBKQ2o0Ylgrc1A5cW1N?=
 =?utf-8?B?K2FhSmUrenlqZTl4YVRBRTF2aDZZcm5LWkJqMmZRUW12VkFGeHIxeisrWWZl?=
 =?utf-8?B?ejE1dU55TGdaZG1Eelp0aFc1cWdwS2NScHJuS05YNm1FWnlhZ3BCUnhUQVl4?=
 =?utf-8?B?WllXSnJNQjVJN2k4Y1Q4T3Nmd3JyTDVCU1krd0VQU2VVeFg3dzNtZGNTT0h2?=
 =?utf-8?B?cDlNUVh4ekJVVDRyRVBtMDVBQmFpRDRneWE5elhHdC9yR2k1K0w2dEg2bmVD?=
 =?utf-8?B?NHhzejJjeXJheEZkVG1kdC9tMkxUa3RxTzg1VXUvZ1dsZ1VRUDZETlpjK0kr?=
 =?utf-8?B?ZS9XRGkxS1kwd2hPZ1N2dDRCZ0NWcVFnL1FWQ1pMZjJ2TnJLRk50dDY3bzlj?=
 =?utf-8?B?am81cFA2S1ZNRHhyNitHOWF2WGxYUVhodXZpVU1vZE5tcnBSalo4SkRvbUFY?=
 =?utf-8?B?TVc2Ukw0Q01SYklrL1BNdU5ObGJqMzdyQnZqUGViRTBiRVhacHd6aXdLS2Zq?=
 =?utf-8?B?R1lER0lYaHRkd250L1haZ3h0b3U4VkRmRFlzd1htNDM1Nmh2a21iay9sdGVl?=
 =?utf-8?B?RjRQeTUxbVBMa3V6QURhbVlJZ09JYUkzVGZHVUlzOUhYNmxaVzVGSXRrb05o?=
 =?utf-8?B?YU5BQzRldi8xSXBOTGJzSWs1K3pycnU4d3JlQm45ZTlqdkxkUmZEYjNyVVp2?=
 =?utf-8?B?Vi9iMmI1OC8wVHVVTGJCZDZlVHFmL2RnbDRhSUhDYmVCd0l6MlRsdVVJK3RB?=
 =?utf-8?B?VU8xVGdFeFphb1ZtVFUrMDQvUnV0ZnM2a3JmWDJOYm4rdUhDWWVabXg4UGVF?=
 =?utf-8?B?SE1vVDNKbkZoczJFVkpIY0lCdjM5VWZKb0Q0RGEzbEFMdUhGR0ZkaEZuOGlC?=
 =?utf-8?B?OGJHa21WNTNESkRUanRRWVRzQ2hHSEJrY3dNYU9qSU9pS00zV053NlRQbi8w?=
 =?utf-8?B?eUcxbkZuam4wdnQ1S095VWVVdlNRVW1GaWtXMHRid1pKNnVCNmNjbkg2SEFY?=
 =?utf-8?B?MlhrSnNrNE0vODY4L2VXaGo4bWNlcFB0TkhZK1lRZTV2VkRUaXB3cjljMzdR?=
 =?utf-8?B?Q2RkVlhYTzBUVTUrdzhLT2w4OWpaRUhKWGJvd2xPSllvRTJKSXAvNXhzNkJT?=
 =?utf-8?B?bXVFNkpndUQyeFN3dDl0d1FNREFHUjlCSGZDbFJ1bVdCSkhUVTdaai8rSVVo?=
 =?utf-8?B?anlTZk9OSmF5aUw3b1ZCdDNKQldNZkQ5UThtUm1aSm96RzhURGVrOVg5a1Nz?=
 =?utf-8?B?Q2NWVHZSVGdqS3cwQW9iUldaZWd1ck5iRWJScDE5aENnQVJHTC9WNHJVTG15?=
 =?utf-8?B?SXVJbGRTNEF0ZjJ4cnhpNHRiRWN6L3lNUlM1K0ZBRjV2WE5xcGpQY3pFUHdy?=
 =?utf-8?B?YkdjRW9RUFJGYU16L3cwTXVsOHZBTER5ZzdSS2tmQldROWtoMmgxS2lMYnpB?=
 =?utf-8?B?OWZnZXdBSngzNDU0M3daVjd0SDQwZlo3UCszSWhSdnhVeExZWExxcW9GNk8z?=
 =?utf-8?B?ZWxrUDVsWEtZc2QvN3RJVWVTcWtWaWFHNm4zL3lZUGQ5aENHQy95TlBwcGdF?=
 =?utf-8?B?MEdRK3g5ZE1aem5nWWF0aEtYcHRJaTZkbDNFYVAzTEhnamd1VlRWWnphajJx?=
 =?utf-8?Q?ZLw/ztYRoDeFuJMHASlrEWX9rLGp0g0q5TdzEIZlLg=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ea8efe-4d32-43bb-d346-08dd4c36201d
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 13:55:50.8474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bd2+cwBz4/fkAVpgx2Zet3jtoBviDQxrq+yokf4XDrtgZP8TgMGtVka/fowY/Ib0BcbhR/bYNJVKvCS+NJVoCCuXrEw4RwF7scrv2K84Nv8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB5975

On 2025-02-13 08:25, Gabriele Monaco wrote:
> On Thu, 2025-02-13 at 14:52 +0800, kernel test robot wrote:
>> kernel test robot noticed
>> "WARNING:at_kernel/workqueue.c:#__queue_delayed_work" on:
>>
>> [    2.640924][    T0] ------------[ cut here ]------------
>> [ 2.641646][ T0] WARNING: CPU: 0 PID: 0 at kernel/workqueue.c:2495
>> __queue_delayed_work (kernel/workqueue.c:2495 (discriminator 9))
>> [    2.642874][    T0] Modules linked in:
>> [    2.643381][    T0] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted
>> 6.14.0-rc2-00002-g287adf9e9c1f #1
>> [    2.644582][    T0] Hardware name: QEMU Standard PC (i440FX +
>> PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
>> [ 2.645943][ T0] RIP: 0010:__queue_delayed_work
>> (kernel/workqueue.c:2495 (discriminator 9))
> 
> There seem to be major problems with this configuration, I'm trying to
> understand what's wrong but, for the time being, this patchset is not
> ready for inclusion.

I think there is an issue with the order of init functions at boot.

poking_init() calls mm_alloc(), which ends up calling mm_init().

The WARN_ON() is about a NULL wq pointer, which I suspect happens
if poking_init() is called before workqueue_init_early(), which
allocates system_wq.

Indeed, in start_kernel(), poking_init() is called before
workqueue_init_early().

I'm not sure what are the init order dependencies across subsystems here.
There is the following order in start_kernel():

[...]
         mm_core_init();
         poking_init();
         ftrace_init();

         /* trace_printk can be enabled here */
         early_trace_init();

         /*
          * Set up the scheduler prior starting any interrupts (such as the
          * timer interrupt). Full topology setup happens at smp_init()
          * time - but meanwhile we still have a functioning scheduler.
          */
         sched_init();

         if (WARN(!irqs_disabled(),
                  "Interrupts were enabled *very* early, fixing it\n"))
                 local_irq_disable();
         radix_tree_init();
         maple_tree_init();

         /*
          * Set up housekeeping before setting up workqueues to allow the unbound
          * workqueue to take non-housekeeping into account.
          */
         housekeeping_init();

         /*
          * Allow workqueue creation and work item queueing/cancelling
          * early.  Work item execution depends on kthreads and starts after
          * workqueue_init().
          */
         workqueue_init_early();
[...]

So either we find a way to reorder this, or we make sure poking_init()
does not require the workqueue.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

