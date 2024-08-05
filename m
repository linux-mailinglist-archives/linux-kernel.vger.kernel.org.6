Return-Path: <linux-kernel+bounces-274643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F068D947B00
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 14:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D3DCB21586
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 12:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE511586C6;
	Mon,  5 Aug 2024 12:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="d5YDiGA6"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2117.outbound.protection.outlook.com [40.107.95.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDC618AED
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 12:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722860547; cv=fail; b=HWQ+7MwkmcWHhB+lZxLECX/35nVw5zbChN+ktNKar5paNnlNQlhh463hpw6Doo+zetCTP63VGpzLBL6VdQXlaD3iiQ0/qf3xeBCER1vFHdUYw39GAV/ltSZ/mgxrfqMbHorKK72aojwTLm3mhmcFjcWoD3EtioelvCrYOZbWvRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722860547; c=relaxed/simple;
	bh=7uI41eWYRT59Fm0mAMUN9i49JE3lG318DNaShRy81Y8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Qm9ICE8GphPmFt6XbDBLZuAseHOGvxkLIX2FuyF8aLbIsrZR6bd6P1WDx7sm2W6W9lp99Fc8QBgKfeP93I3J5Fw6e8XA0VAb8TiwQizUFWQGfC6YfRDvl1w5stq0CYR/AMicMTiLuev3ueyVscQPjswHQAVhjLLplrpMw0mvfLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=d5YDiGA6; arc=fail smtp.client-ip=40.107.95.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IaFI/l3RDNzj9r44AA5k2fPYcclk6+BcZH2gaBtskH0HMKag2D0S9aT2LcxwvuKAboH53bJe1IBLqdGZVww0hnROIYtt86H1/+GZ2iaOwQEbas2yNGmhKBgfrYs8dCGDarpT/vs4VZjdAjMYgYiF4r6y42HVeBoXo8seyBjN8C6rsI6Nob84zjLD8G/54/0b3O+r/cfvPAlq51dtXVMSSNX1cVdEh66zVQESOqFjRhGbV0Rlpk6Mz3ur7KVztNmM7Ycl6170xV69K543nuuduH0mIGCUeOca8FGxv1ROtB2pDyQ3bMvkmrKwPZgJoAVkoUVoXp9FRXv/PTIKi+5W6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aITGJTTBz58Y4+qhJzrLwcQbJN1SPsQFCYd5uvT/Dzk=;
 b=hngxu2IiHZadON8p5ad1m5VVvXQPk6b0aOKHcHkw06q+s7fa883ms1nTwQ6uYXCrDPxWdTQqCcah7YRFL9q8Y6ztHlp3osd53SyYa3cM/l1fb4VnGROlffjTpk+KcgxiUrRM3qt9+EMFTsjx8vLH5oNzRI05LPyIf3vkU3BDn6Jm+eArHqbPKaG4hq0SGSVupBuTcw651fLiZZmkJoGDbyMHkTso8IHEdKoQWVV7knQj8WB8YPoOQFvY9cHfsV5L7GLn2CuQF6Ra4scCRIE4CTJ0bF8ttgHjMamOhjn0CxOpbk9WHhEUy/dRHVM7kMonDAdSUXq29CHD34f53BmySg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aITGJTTBz58Y4+qhJzrLwcQbJN1SPsQFCYd5uvT/Dzk=;
 b=d5YDiGA6aFAkw16Y+GBPUCF1dtJMcZPRNXCtXCqhH91lDe/d+PFIxhQrUws9H4YWY/3vmjE6ngKm9dlS0ulF0QzzsqLTsP1oQD5nFvafCaMYYFHwsrF5y8aGylAIa1rErhgjspGaKxgS+C+i+Mrz1/ashxG6LyWHYUg66t9vrMw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8101.prod.exchangelabs.com (2603:10b6:a03:4f6::10) by
 PH0PR01MB6120.prod.exchangelabs.com (2603:10b6:510:15::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7807.28; Mon, 5 Aug 2024 12:22:20 +0000
Received: from SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9]) by SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9%3]) with mapi id 15.20.7828.021; Mon, 5 Aug 2024
 12:22:20 +0000
Message-ID: <ae1b2d8c-588a-4f0a-b3c9-c869f8dd0f25@os.amperecomputing.com>
Date: Mon, 5 Aug 2024 17:52:10 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf scripts python arm-cs-trace-disasm.py: Skip disasm
 if address continuity is broken
To: James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>
Cc: acme@redhat.com, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 darren@os.amperecomputing.com, scclevenger@os.amperecomputing.com,
 james.clark@arm.com, suzuki.poulose@arm.com, Leo Yan <leo.yan@arm.com>,
 Al.Grant@arm.com
References: <20240719092619.274730-1-gankulkarni@os.amperecomputing.com>
 <7302367c-311f-4655-9a83-3c4034c50086@linaro.org>
 <6920de94-a9c8-47f4-840f-391d1ec85c0c@os.amperecomputing.com>
 <8f6f221b-4c9a-42e1-b8ce-1f492caee184@linaro.org>
 <0a697a54-5dd8-4351-a651-991724690db2@os.amperecomputing.com>
 <ce4af204-874f-404c-a7aa-42dc6693d072@linaro.org>
 <a197123a-be59-4052-9615-cac79ffa357a@os.amperecomputing.com>
 <543813f6-cb1f-4759-b26f-75246750814d@linaro.org>
 <f72038a0-c6b5-4245-8515-3b735ca38cbb@linaro.org>
Content-Language: en-US
From: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
In-Reply-To: <f72038a0-c6b5-4245-8515-3b735ca38cbb@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0048.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::19) To SJ2PR01MB8101.prod.exchangelabs.com
 (2603:10b6:a03:4f6::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8101:EE_|PH0PR01MB6120:EE_
X-MS-Office365-Filtering-Correlation-Id: 73fc9191-88d3-4bd8-5523-08dcb5494048
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K2IvVkhmNkRUQ3RrOXRPdlZ2cFBma2Z3bkRvMkRrMVYzclVIUG9HRUhmeWVx?=
 =?utf-8?B?L1ptVTU3TTNodGF6MHBrRG11N0FuQkI4QnViYWtJM3JOUjE3bmYvdEVqcjFM?=
 =?utf-8?B?YjE4eDZrM2cyQlZpU3gxVzNobzRDTHlKSHkwSzA5U0JHMlE1RzV5UXBteDRo?=
 =?utf-8?B?Qi9laFFEc3IzNThWaG9VaEtrUmY2ZGVLNGJjNUk0WnZUTmFLbXMrL0tVeUdW?=
 =?utf-8?B?U3hRNnJXWXZHcVFKSE8wOWswbXN2R281SXFEWklIWGpJdVNvVU5LM2RmcHZE?=
 =?utf-8?B?cDU0WDV5cjVxckx6UnFpRW82VUhLTHFPQk5DSC8wN21taFVKTFVNaFRVYUFM?=
 =?utf-8?B?MUlvU2tFVlluSks0aFJBZmRKQk9acU9ZaGZka0pOK0dicEM2K0p4OVdmL2dx?=
 =?utf-8?B?S1dkcUx1OXFmMEYxemtNYmFlRERCNjZCQnNUbDIrbnNNOVYwWkJnR0Y3cW1y?=
 =?utf-8?B?TE5VMTVib3VqSDRtdEZVYW5JaEduZm0wb20wallZMDRJTGJJaUVlMGo3VGYv?=
 =?utf-8?B?dzFnMFkvZ2NuNzZ4Z2NZd25XaVhPcUJaZzN2SUtMMm1YZXAxR2xyWFhjVGZl?=
 =?utf-8?B?QzFtcGlsRnJFbTdsZUlSMVd1TTlkL1pHeDFJNDRSME1mV3QzbjNlSUtHU0hm?=
 =?utf-8?B?QjZIanlkSi96QlQ4N0lRN2QySDF2MDlKUmw4NnBzOERFdGZBT1RldUpTM0Ur?=
 =?utf-8?B?QWZIdXpnYzVxUzhUM1VGMG8zV2VaejFiSXIxOW9HaWF5ZE9GN0dSam43dGpV?=
 =?utf-8?B?QTFENzNkZXRyQUFGdHlWakRIVW9Td2VLRk4yTUVxY0xocURLRS9ha2Q2VFlQ?=
 =?utf-8?B?a2FhNTlyK2dkOUJha0dqK1lkNC9xMmN3eXh0RWZCWFkvcUZnQTBIbnhqVHJD?=
 =?utf-8?B?di82cFROUm1HMWVJbjRLU2J4TzNGOGFFdnBiSVpZUnY2M0FpNTc1SUlZUmMr?=
 =?utf-8?B?UXZDNVVXWlMzRytzMHFMNmFiYXREakJiaVRJdSs4aFVtMXNuTE9vSFRXbmJX?=
 =?utf-8?B?MldmYzdCQVN5YUVaajdzWjF5aUZnekZPK0RwT2tIdWhDU0FjdU5ZZmYvS2JY?=
 =?utf-8?B?emh2MlloV3BJNDJuU21VWHBqdENEcmExS3VoRTNxcVlUNlVJb3pEWFZiL2ZN?=
 =?utf-8?B?cmRoQTVNQjRXcjBOWWM3NjgwK2l1Z3d3TW45ZU5pM2E0eWxIME9aTjNzN0s0?=
 =?utf-8?B?OHhCckxkNU5DYXNJUnhBQnN1TERwejAxalpzcjl6bVMveS9ndTBUYlZJZjM5?=
 =?utf-8?B?bWlrK015Y2RhaDRkUEJzRTdscmVKdkpKY1FzYWNIemNYZXg2S01BTGxFUzBv?=
 =?utf-8?B?MjU4Z0ZzVWJtSUlmd21WenZxdkJRQnJYYTRmclhyNkxDUmJZcHd5ZjB0Tk9E?=
 =?utf-8?B?OFBwbkcrbERLQjRZZWhZUFhwSFdIekhhOXVSbTRuMnBCd1ZDZi9KOTJXYWhK?=
 =?utf-8?B?L3dVNnFsaTZJVUhhRTN1U3ZhVGhYNW9KV1ZhK2RzRlBvTDVRd0pVeDNMQVNo?=
 =?utf-8?B?TE5INXIxSHRqeHVaQWxyUWxsQnAzS0VUUjRlZU5tRnU4MkdKYnBxWWZPMWVo?=
 =?utf-8?B?RkdpNXdZODU5Q2N6bFI3MTM0QzJVREozSklXeGc1OU1yeUxKdUpzUTV6WEVs?=
 =?utf-8?B?TkNBMk5KcndndVE5cXlqOGF0eTN1UWZ1OFVuZVlIOVIrUG9pb1pmWmkrRnIr?=
 =?utf-8?B?dVBWM0F2eE1iSTVXQS96VDFpa09Db09lcm95eFNIL2ttQTJ0TU9FeXoxeTF2?=
 =?utf-8?B?L1hoUkNYT3lVOUlDc3FQYWc4dXlNNWQ0MExnazMwdVhnMm1yaGYyUEVLalFj?=
 =?utf-8?B?SWZPa05uRmswdXJFOUg5Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8101.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WWttS294NVNmdGtqODkrd0ZiQ1JYS1djV1J5MmFGTEdJZ0taNjBrZmtuenFr?=
 =?utf-8?B?R215b0tvYjNMSzF4eTM2ZjVuT09CQUQ0bjVRai9UZDQ1V0k1N0JTRU9Xcnlj?=
 =?utf-8?B?VDBLY25qbWJPNTRUb3I0bGRsanVCQUlVL0Y4blNLS2treXYzSHNFQ1ZXZ1py?=
 =?utf-8?B?bVlwWlRMVGpaTnVYMGFBdEZmRU5WYktKcitZR2NDMk54NTRZS2U4SU05RXFi?=
 =?utf-8?B?TC9qV2FNb2ZjM29TTFN6MWpGQUdwV014d3k2c3RURlJvd09qT2pRZU90K2tp?=
 =?utf-8?B?S1UwQlk0dk1yb1lPZFN3cHpIM1JIamlJeGxXWVlycHpTdnJFOGhTL1QrKzN6?=
 =?utf-8?B?SGFwNTJ0ekZoTjh1Z21VeUg0MTBvODEyVmlhVUtiL2ZZV3BlVE9xZlFwVHlv?=
 =?utf-8?B?VEhnVy9LRTFyS0hKNXdlU1RWbUVmbnpaS2tlUk0zMnlLOWFTcC9vV2JqT2hp?=
 =?utf-8?B?UzF0UWlXQTlLRUE2MElaSk5KakhKeUZsMkhWSksxRXUwcEVtTDlKUkNKeWk4?=
 =?utf-8?B?MnRRSmlGSzRZVVNBWDhvd1d4YVFkS2NXNWV5RFU0alJRYkJVNFl3VGRldWJO?=
 =?utf-8?B?MHpDd2RxSWZBZitWcDJLQWthUHZXRGt5VlpEWm51S1A3THdCcXg1QVUremE1?=
 =?utf-8?B?d3hlc3lUSHlZRGk4WmJ4VERMRlVkdE9MNDIwQm14bGN3OU5ieVRNZlcvWEd0?=
 =?utf-8?B?bkczN3hzLzdOMkJMYlh3Z3NXYVlFM1BYNTR4YUdlaDBnd1Z2VUpobTVBd0tW?=
 =?utf-8?B?ZUNmSXpsUWZ3UThzLytuU1JtTEdoVVp4OWNLOTFxcDc2Z1djeGR3SmFWSjVX?=
 =?utf-8?B?RWs2TWhJS2JSL2RDZS9EbCtkTjArcXRyRG9vQVNaZm1rWXYvenkzSmZ2Z2F6?=
 =?utf-8?B?UzBPM1NTUmMxRjdZQjBnTkVVd3ZVUXpzdDZzUE5mR2hzRG5xK2VJWkNKNVN3?=
 =?utf-8?B?QU1uQlBybmY1ZWlzZ2pZOENRN1lDNU5mL1dTYkN1bU9sbWtOZlR2cVZDYnFq?=
 =?utf-8?B?ZjRPOUl3WFYxdWIrWkpEVTdnQ1haOXBmRytITElHaHdMdTVHMXhFMlBJblBV?=
 =?utf-8?B?eFB5UVU1WnZ2cTRWSXN0THE1Z0lBV1NpUTlTcWFqdjNCWFdOak5VOVpZdG0r?=
 =?utf-8?B?c1ZXN0VHUlVkNEtzRmpFbVc4ZVpHVXB5SGRhZWxyLzdpa1Q4UUx6bUZMZ0VI?=
 =?utf-8?B?eVNZNU15UTFGeGY1akc3U1ZCMGtMOHc1cFhPcmE2c0IzdXNBYzBsd3A4V2w5?=
 =?utf-8?B?Nisxdk1LSzhlczlvLytFWW1iV1cxVC9pbHkrbVMyNHRhZ2NIOHozMU9RSDls?=
 =?utf-8?B?Vk9zd1dDbytPNmg0Ukw0SHRJbTlKRDZlaFNmVEZueE9aMVFPZ2RQb0Fadytl?=
 =?utf-8?B?amhIYUJJYm96V3RscFV3RmY5aklhcWd5QUgxaU0xaUJEa29EbXlab0ZtMzJD?=
 =?utf-8?B?TjkvMFRvZ0ZuRVRHeXNoSElNdkxCTTVzVzdRTmpKdy9EQnhXZVY5dnhPdGZJ?=
 =?utf-8?B?OW5pRmRaMkV1UDRWa3RJbnhDMVU4M1ExdjQzWDZDRVNrdXAxUnpxSklVRVFh?=
 =?utf-8?B?MXQwTmh4RUdhNWRzYVpPdlVQbU45V09XOGhLNkVpUkNIcHBOWitYSldYSzRx?=
 =?utf-8?B?OWdweVBva2cxRnB1bHRQNUFqY3JmS2dncEZoNWx6OHhSTEdld3luR0w3TTF6?=
 =?utf-8?B?STllR1JMYTJZSkNndEw1VHAzYXZDVGc0ZDU0Ty9UYUdBYVQ1NWZuUTJScnoz?=
 =?utf-8?B?bDBoRzFINzUxWHFOZUU0YW4zOUp0UUIyQXNnWk1JSXg5czN3RW5Mb1NSVmh5?=
 =?utf-8?B?V1hIQ2R3ZE9aZmVibGppc3RUc3dJalpYM2hKV0pjd01ERjNKME8wY2hrMjJV?=
 =?utf-8?B?NFRhb3dSL2p3YVVsNk5kMldkaWZUUWxhRC9HV25tSnZ1blVaWHY3djFEc244?=
 =?utf-8?B?bzVWS2UwUFA4aWVrZVpjTWpmTHA0b3FpcmJrb2Z1SjRmbjkxUTdsSXlNOVNz?=
 =?utf-8?B?Mkk3SU9SZGorTEpqUE5OM3Q5M0RqTmJUWTlJd0xEcDF4M2VaUnF2NHg4eFoy?=
 =?utf-8?B?SFBGU2pFS1MydW9vZzlQZFBTSkNnZ2tzQ0YwR2doVzEwbjZXT1NqUDFCUGNO?=
 =?utf-8?B?WFdFdms5UGQvTUpYNmpRSGFkN2Yydk9kaEZnQ0RuSUN4RmZwT3hGSUNVbDRB?=
 =?utf-8?Q?xX7A2HZnhZpOaZGPiw0BDVQ=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73fc9191-88d3-4bd8-5523-08dcb5494048
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8101.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 12:22:19.8916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rKgE0sfx5t8GifqjYqpQs2F3PBxBpA8TMN51fNtZnRmW0Bbm/qGXmH2k3XN6T/2kepXC4w2RpzjwQTgZ+Zresri7rCoY0xsy7jw4K0yAJdQIu61M1KoHHgAaRLfaj3jJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6120



On 01-08-2024 03:30 pm, James Clark wrote:
> 
> 
> On 24/07/2024 3:45 pm, James Clark wrote:
>>
>>
>> On 24/07/2024 7:38 am, Ganapatrao Kulkarni wrote:
>>>
>>>
>>> On 23-07-2024 09:16 pm, James Clark wrote:
>>>>
>>>>
>>>> On 23/07/2024 4:26 pm, Ganapatrao Kulkarni wrote:
>>>>>
>>>>>
>>>>> On 23-07-2024 06:40 pm, James Clark wrote:
>>>>>>
>>>>>>
>>>>>> On 22/07/2024 11:02 am, Ganapatrao Kulkarni wrote:
>>>>>>>
>>>>>>> Hi James,
>>>>>>>
>>>>>>> On 19-07-2024 08:09 pm, James Clark wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 19/07/2024 10:26 am, Ganapatrao Kulkarni wrote:
>>>>>>>>> To generate the instruction tracing, script uses 2 contiguous 
>>>>>>>>> packets
>>>>>>>>> address range. If there a continuity brake due to discontiguous 
>>>>>>>>> branch
>>>>>>>>> address, it is required to reset the tracing and start tracing 
>>>>>>>>> with the
>>>>>>>>> new set of contiguous packets.
>>>>>>>>>
>>>>>>>>> Adding change to identify the break and complete the remaining 
>>>>>>>>> tracing
>>>>>>>>> of current packets and restart tracing from new set of packets, if
>>>>>>>>> continuity is established.
>>>>>>>>>
>>>>>>>>
>>>>>>>> Hi Ganapatrao,
>>>>>>>>
>>>>>>>> Can you add a before and after example of what's changed to the 
>>>>>>>> commit message? It wasn't immediately obvious to me if this is 
>>>>>>>> adding missing output, or it was correcting the tail end of the 
>>>>>>>> output that was previously wrong.
>>>>>>>
>>>>>>> It is adding tail end of the trace as well avoiding the segfault 
>>>>>>> of the perf application. With out this change the perf segfaults 
>>>>>>> with as below log
>>>>>>>
>>>>>>>
>>>>>>> ./perf script 
>>>>>>> --script=python:./scripts/python/arm-cs-trace-disasm.py -- -d 
>>>>>>> objdump -k ../../vmlinux -v $* > dump
>>>>>>> objdump: error: the stop address should be after the start address
>>>>>>> Traceback (most recent call last):
>>>>>>>    File "./scripts/python/arm-cs-trace-disasm.py", line 271, in 
>>>>>>> process_event
>>>>>>>      print_disam(dso_fname, dso_vm_start, start_addr, stop_addr)
>>>>>>>    File "./scripts/python/arm-cs-trace-disasm.py", line 105, in 
>>>>>>> print_disam
>>>>>>>      for line in read_disam(dso_fname, dso_start, start_addr, 
>>>>>>> stop_addr):
>>>>>>> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>>>>    File "./scripts/python/arm-cs-trace-disasm.py", line 99, in 
>>>>>>> read_disam
>>>>>>>      disasm_output = 
>>>>>>> check_output(disasm).decode('utf-8').split('\n')
>>>>>>>                      ^^^^^^^^^^^^^^^^^^^^
>>>>>>>    File "/usr/lib64/python3.12/subprocess.py", line 466, in 
>>>>>>> check_output
>>>>>>>      return run(*popenargs, stdout=PIPE, timeout=timeout, 
>>>>>>> check=True,
>>>>>>>             
>>>>>>> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>>>>    File "/usr/lib64/python3.12/subprocess.py", line 571, in run
>>>>>>>      raise CalledProcessError(retcode, process.args,
>>>>>>> subprocess.CalledProcessError: Command '['objdump', '-d', '-z', 
>>>>>>> '--start-address=0xffff80008125b758', 
>>>>>>> '--stop-address=0xffff80008125a934', '../../vmlinux']' returned 
>>>>>>> non-zero exit status 1.
>>>>>>> Fatal Python error: handler_call_die: problem in Python trace 
>>>>>>> event handler
>>>>>>> Python runtime state: initialized
>>>>>>>
>>>>>>> Current thread 0x0000ffffb05054e0 (most recent call first):
>>>>>>>    <no Python frame>
>>>>>>>
>>>>>>> Extension modules: perf_trace_context, systemd._journal, 
>>>>>>> systemd._reader, systemd.id128, report._py3report, 
>>>>>>> _dbus_bindings, problem._py3abrt (total: 7)
>>>>>>> Aborted (core dumped)
>>>>>>>
>>>>>>>>
>>>>>>>>> Signed-off-by: Ganapatrao Kulkarni 
>>>>>>>>> <gankulkarni@os.amperecomputing.com>
>>>>>>>>> ---
>>>>>>>>>   tools/perf/scripts/python/arm-cs-trace-disasm.py | 10 ++++++++++
>>>>>>>>>   1 file changed, 10 insertions(+)
>>>>>>>>>
>>>>>>>>> diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py 
>>>>>>>>> b/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>>>>>>> index d973c2baed1c..ad10cee2c35e 100755
>>>>>>>>> --- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>>>>>>> +++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>>>>>>> @@ -198,6 +198,10 @@ def process_event(param_dict):
>>>>>>>>>           cpu_data[str(cpu) + 'addr'] = addr
>>>>>>>>>           return
>>>>>>>>> +    if (cpu_data.get(str(cpu) + 'ip') == None):
>>>>>>>>> +        cpu_data[str(cpu) + 'ip'] = ip
>>>>>>>>> +
>>>>>>>>
>>>>>>>> Do you need to write into the global cpu_data here? Doesn't it 
>>>>>>>> get overwritten after you load it back into 'prev_ip'
>>>>>>>
>>>>>>> No, the logic is same as holding the addr of previous packet.
>>>>>>> Saving the previous packet saved ip in to prev_ip before 
>>>>>>> overwriting with the current packet.
>>>>>>
>>>>>> It's not exactly the same logic as holding the addr of the 
>>>>>> previous sample. For addr, we return on the first None, with your 
>>>>>> change we now "pretend" that the second one is also the previous one:
>>>>>>
>>>>>>    if (cpu_data.get(str(cpu) + 'addr') == None):
>>>>>>      cpu_data[str(cpu) + 'addr'] = addr
>>>>>>      return  <----------------------------sample 0 return
>>>>>>
>>>>>>    if (cpu_data.get(str(cpu) + 'ip') == None):
>>>>>>        cpu_data[str(cpu) + 'ip'] = ip <---- sample 1 save but no 
>>>>>> return
>>>>>>
>>>>>> Then for sample 1 'prev_ip' is actually now the 'current' IP:
>>>>>
>>>>> Yes, it is dummy for first packet. Added anticipating that we wont 
>>>>> hit the discontinuity for the first packet itself.
>>>>>
>>>>> Can this be changed to more intuitive like below?
>>>>>
>>>>> diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py 
>>>>> b/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>>> index d973c2baed1c..d49f5090059f 100755
>>>>> --- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>>> +++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
>>>>> @@ -198,6 +198,8 @@ def process_event(param_dict):
>>>>>                  cpu_data[str(cpu) + 'addr'] = addr
>>>>>                  return
>>>>>
>>>>> +       if (cpu_data.get(str(cpu) + 'ip') != None):
>>>>> +               prev_ip = cpu_data[str(cpu) + 'ip']
>>>>>
>>>>>          if (options.verbose == True):
>>>>>                  print("Event type: %s" % name)
>>>>> @@ -243,12 +245,18 @@ def process_event(param_dict):
>>>>>
>>>>>          # Record for previous sample packet
>>>>>          cpu_data[str(cpu) + 'addr'] = addr
>>>>> +       cpu_data[str(cpu) + 'ip'] = stop_addr
>>>>>
>>>>>          # Handle CS_ETM_TRACE_ON packet if start_addr=0 and 
>>>>> stop_addr=4
>>>>>          if (start_addr == 0 and stop_addr == 4):
>>>>>                  print("CPU%d: CS_ETM_TRACE_ON packet is inserted" 
>>>>> % cpu)
>>>>>                  return
>>>>>
>>>>> +       if (stop_addr < start_addr and prev_ip != 0):
>>>>> +               # Continuity of the Packets broken, set start_addr 
>>>>> to previous
>>>>> +               # packet ip to complete the remaining tracing of 
>>>>> the address range.
>>>>> +               start_addr = prev_ip
>>>>> +
>>>>>          if (start_addr < int(dso_start) or start_addr > 
>>>>> int(dso_end)):
>>>>>                  print("Start address 0x%x is out of range [ 0x%x 
>>>>> .. 0x%x ] for dso %s" % (start_addr, int(dso_start), int(dso_end), 
>>>>> dso))
>>>>>                  return
>>>>>
>>>>> Without this patch below is the failure log(with segfault) for 
>>>>> reference.
>>>>>
>>>>> [root@sut01sys-r214 perf]# timeout 4s ./perf record -e cs_etm// -C 
>>>>> 1 dd if=/dev/zero of=/dev/null
>>>>> [ perf record: Woken up 1 times to write data ]
>>>>> [ perf record: Captured and wrote 1.087 MB perf.data ]
>>>>> [root@sut01sys-r214 perf]# ./perf script 
>>>>> --script=python:./scripts/python/arm-cs-trace-disasm.py -- -d 
>>>>> objdump -k ../../vmlinux -v $* > dump
>>>>> objdump: error: the stop address should be after the start address
>>>>> Traceback (most recent call last):
>>>>>    File "./scripts/python/arm-cs-trace-disasm.py", line 271, in 
>>>>> process_event
>>>>>      print_disam(dso_fname, dso_vm_start, start_addr, stop_addr)
>>>>>    File "./scripts/python/arm-cs-trace-disasm.py", line 105, in 
>>>>> print_disam
>>>>>      for line in read_disam(dso_fname, dso_start, start_addr, 
>>>>> stop_addr):
>>>>> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>>    File "./scripts/python/arm-cs-trace-disasm.py", line 99, in 
>>>>> read_disam
>>>>>      disasm_output = check_output(disasm).decode('utf-8').split('\n')
>>>>>                      ^^^^^^^^^^^^^^^^^^^^
>>>>>    File "/usr/lib64/python3.12/subprocess.py", line 466, in 
>>>>> check_output
>>>>>      return run(*popenargs, stdout=PIPE, timeout=timeout, check=True,
>>>>>             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>>    File "/usr/lib64/python3.12/subprocess.py", line 571, in run
>>>>>      raise CalledProcessError(retcode, process.args,
>>>>> subprocess.CalledProcessError: Command '['objdump', '-d', '-z', 
>>>>> '--start-address=0xffff80008125b758', 
>>>>> '--stop-address=0xffff80008125a934', '../../vmlinux']' returned 
>>>>> non-zero exit status 1.
>>>>> Fatal Python error: handler_call_die: problem in Python trace event 
>>>>> handler
>>>>> Python runtime state: initialized
>>>>>
>>>>> Current thread 0x0000ffffb90d54e0 (most recent call first):
>>>>>    <no Python frame>
>>>>>
>>>>> Extension modules: perf_trace_context, systemd._journal, 
>>>>> systemd._reader, systemd.id128, report._py3report, _dbus_bindings, 
>>>>> problem._py3abrt (total: 7)
>>>>> Aborted (core dumped)
>>>>>
>>>>>
>>>>> dump snippet:
>>>>> ============
>>>>> Event type: branches
>>>>> Sample = { cpu: 0001 addr: 0xffff80008030cb00 phys_addr: 
>>>>> 0x0000000000000000 ip: 0xffff800080313f0c pid: 12720 tid: 12720 
>>>>> period: 1 time: 5986372298040 }
>>>>>          ffff800080313f04 <__perf_event_header__init_id+0x4c>:
>>>>>          ffff800080313f04:       36100094        tbz     w20, #2, 
>>>>> ffff800080313f14 <__perf_event_header__init_id+0x5c>
>>>>>          ffff800080313f08:       f941e6a0        ldr     x0, [x21, 
>>>>> #968]
>>>>>          ffff800080313f0c:       d63f0000        blr     x0
>>>>>              perf 12720/12720 [0001]      5986.372298040 
>>>>> __perf_event_header__init_id+0x54 
>>>>> .../coresight/linux/kernel/events/core.c  586         return 
>>>>> event->clock();
>>>>> Event type: branches
>>>>> Sample = { cpu: 0001 addr: 0xffff8000801bb4a8 phys_addr: 
>>>>> 0x0000000000000000 ip: 0xffff80008030cb0c pid: 12720 tid: 12720 
>>>>> period: 1 time: 5986372298040 }
>>>>>          ffff80008030cb00 <local_clock>:
>>>>>          ffff80008030cb00:       d503233f        paciasp
>>>>>          ffff80008030cb04:       a9bf7bfd        stp     x29, x30, 
>>>>> [sp, #-16]!
>>>>>          ffff80008030cb08:       910003fd        mov     x29, sp
>>>>>          ffff80008030cb0c:       97faba67        bl 
>>>>> ffff8000801bb4a8 <sched_clock>
>>>>>              perf 12720/12720 [0001]      5986.372298040 
>>>>> local_clock+0xc ...t/linux/./include/linux/sched/clock.h   64 
>>>>> return sched_clock();
>>>>> Event type: branches
>>>>> Sample = { cpu: 0001 addr: 0xffff80008125a8a8 phys_addr: 
>>>>> 0x0000000000000000 ip: 0xffff8000801bb4c8 pid: 12720 tid: 12720 
>>>>> period: 1 time: 5986372298040 }
>>>>>          ffff8000801bb4a8 <sched_clock>:
>>>>>          ffff8000801bb4a8:       d503233f        paciasp
>>>>>          ffff8000801bb4ac:       a9be7bfd        stp     x29, x30, 
>>>>> [sp, #-32]!
>>>>>          ffff8000801bb4b0:       910003fd        mov     x29, sp
>>>>>          ffff8000801bb4b4:       a90153f3        stp     x19, x20, 
>>>>> [sp, #16]
>>>>>          ffff8000801bb4b8:       d5384113        mrs     x19, sp_el0
>>>>>          ffff8000801bb4bc:       b9401260        ldr     w0, [x19, 
>>>>> #16]
>>>>>          ffff8000801bb4c0:       11000400        add     w0, w0, #0x1
>>>>>          ffff8000801bb4c4:       b9001260        str     w0, [x19, 
>>>>> #16]
>>>>>          ffff8000801bb4c8:       94427cf8        bl 
>>>>> ffff80008125a8a8 <sched_clock_noinstr>
>>>>>              perf 12720/12720 [0001]      5986.372298040 
>>>>> sched_clock+0x20 ...sight/linux/kernel/time/sched_clock.c  105 ns = 
>>>>> sched_clock_noinstr();
>>>>> Event type: branches
>>>>> Sample = { cpu: 0001 addr: 0xffff80008125b758 phys_addr: 
>>>>> 0x0000000000000000 ip: 0xffff80008125a8e4 pid: 12720 tid: 12720 
>>>>> period: 1 time: 5986372298040 }
>>>>>          ffff80008125a8a8 <sched_clock_noinstr>:
>>>>>          ffff80008125a8a8:       d503233f        paciasp
>>>>>          ffff80008125a8ac:       a9bc7bfd        stp     x29, x30, 
>>>>> [sp, #-64]!
>>>>>          ffff80008125a8b0:       910003fd        mov     x29, sp
>>>>>          ffff80008125a8b4:       a90153f3        stp     x19, x20, 
>>>>> [sp, #16]
>>>>>          ffff80008125a8b8:       b000e354        adrp    x20, 
>>>>> ffff800082ec3000 <tick_bc_dev+0x140>
>>>>>          ffff80008125a8bc:       910d0294        add     x20, x20, 
>>>>> #0x340
>>>>>          ffff80008125a8c0:       a90363f7        stp     x23, x24, 
>>>>> [sp, #48]
>>>>>          ffff80008125a8c4:       91002297        add     x23, x20, 
>>>>> #0x8
>>>>>          ffff80008125a8c8:       52800518        mov     w24, #0x28 
>>>>>                  // #40
>>>>>          ffff80008125a8cc:       a9025bf5        stp     x21, x22, 
>>>>> [sp, #32]
>>>>>          ffff80008125a8d0:       b9400296        ldr     w22, [x20]
>>>>>          ffff80008125a8d4:       120002d5        and     w21, w22, 
>>>>> #0x1
>>>>>          ffff80008125a8d8:       9bb87eb5        umull   x21, w21, w24
>>>>>          ffff80008125a8dc:       8b1502f3        add     x19, x23, x21
>>>>>          ffff80008125a8e0:       f9400e60        ldr     x0, [x19, 
>>>>> #24]
>>>>>          ffff80008125a8e4:       d63f0000        blr     x0
>>>>>              perf 12720/12720 [0001]      5986.372298040 
>>>>> sched_clock_noinstr+0x3c ...sight/linux/kernel/time/sched_clock.c 
>>>>> 93                 cyc = (rd->read_sched_clock() - rd->epoch_cyc) &
>>>>> Event type: branches
>>>>> Sample = { cpu: 0001 addr: 0xffff8000801bb4cc phys_addr: 
>>>>> 0x0000000000000000 ip: 0xffff80008125a930 pid: 12720 tid: 12720 
>>>>> period: 1 time: 5986372298040 }
>>>>>
>>>>>
>>>>> With fix:
>>>>> =========
>>>>>
>>>>> Event type: branches
>>>>> Sample = { cpu: 0001 addr: 0xffff80008030cb00 phys_addr: 
>>>>> 0x0000000000000000 ip: 0xffff800080313f0c pid: 12720 tid: 12720 
>>>>> period: 1 time: 5986372298040 }
>>>>>          ffff800080313f04 <__perf_event_header__init_id+0x4c>:
>>>>>          ffff800080313f04:       36100094        tbz     w20, #2, 
>>>>> ffff800080313f14 <__perf_event_header__init_id+0x5c>
>>>>>          ffff800080313f08:       f941e6a0        ldr     x0, [x21, 
>>>>> #968]
>>>>>          ffff800080313f0c:       d63f0000        blr     x0
>>>>>              perf 12720/12720 [0001]      5986.372298040 
>>>>> __perf_event_header__init_id+0x54 
>>>>> .../coresight/linux/kernel/events/core.c  586         return 
>>>>> event->clock();
>>>>> Event type: branches
>>>>> Sample = { cpu: 0001 addr: 0xffff8000801bb4a8 phys_addr: 
>>>>> 0x0000000000000000 ip: 0xffff80008030cb0c pid: 12720 tid: 12720 
>>>>> period: 1 time: 5986372298040 }
>>>>>          ffff80008030cb00 <local_clock>:
>>>>>          ffff80008030cb00:       d503233f        paciasp
>>>>>          ffff80008030cb04:       a9bf7bfd        stp     x29, x30, 
>>>>> [sp, #-16]!
>>>>>          ffff80008030cb08:       910003fd        mov     x29, sp
>>>>>          ffff80008030cb0c:       97faba67        bl 
>>>>> ffff8000801bb4a8 <sched_clock>
>>>>>              perf 12720/12720 [0001]      5986.372298040 
>>>>> local_clock+0xc ...t/linux/./include/linux/sched/clock.h   64 
>>>>> return sched_clock();
>>>>> Event type: branches
>>>>> Sample = { cpu: 0001 addr: 0xffff80008125a8a8 phys_addr: 
>>>>> 0x0000000000000000 ip: 0xffff8000801bb4c8 pid: 12720 tid: 12720 
>>>>> period: 1 time: 5986372298040 }
>>>>>          ffff8000801bb4a8 <sched_clock>:
>>>>>          ffff8000801bb4a8:       d503233f        paciasp
>>>>>          ffff8000801bb4ac:       a9be7bfd        stp     x29, x30, 
>>>>> [sp, #-32]!
>>>>>          ffff8000801bb4b0:       910003fd        mov     x29, sp
>>>>>          ffff8000801bb4b4:       a90153f3        stp     x19, x20, 
>>>>> [sp, #16]
>>>>>          ffff8000801bb4b8:       d5384113        mrs     x19, sp_el0
>>>>>          ffff8000801bb4bc:       b9401260        ldr     w0, [x19, 
>>>>> #16]
>>>>>          ffff8000801bb4c0:       11000400        add     w0, w0, #0x1
>>>>>          ffff8000801bb4c4:       b9001260        str     w0, [x19, 
>>>>> #16]
>>>>>          ffff8000801bb4c8:       94427cf8        bl 
>>>>> ffff80008125a8a8 <sched_clock_noinstr>
>>>>>              perf 12720/12720 [0001]      5986.372298040 
>>>>> sched_clock+0x20 ...sight/linux/kernel/time/sched_clock.c  105 ns = 
>>>>> sched_clock_noinstr();
>>>>> Event type: branches
>>>>> Sample = { cpu: 0001 addr: 0xffff80008125b758 phys_addr: 
>>>>> 0x0000000000000000 ip: 0xffff80008125a8e4 pid: 12720 tid: 12720 
>>>>> period: 1 time: 5986372298040 }
>>>>>          ffff80008125a8a8 <sched_clock_noinstr>:
>>>>>          ffff80008125a8a8:       d503233f        paciasp
>>>>>          ffff80008125a8ac:       a9bc7bfd        stp     x29, x30, 
>>>>> [sp, #-64]!
>>>>>          ffff80008125a8b0:       910003fd        mov     x29, sp
>>>>>          ffff80008125a8b4:       a90153f3        stp     x19, x20, 
>>>>> [sp, #16]
>>>>>          ffff80008125a8b8:       b000e354        adrp    x20, 
>>>>> ffff800082ec3000 <tick_bc_dev+0x140>
>>>>>          ffff80008125a8bc:       910d0294        add     x20, x20, 
>>>>> #0x340
>>>>>          ffff80008125a8c0:       a90363f7        stp     x23, x24, 
>>>>> [sp, #48]
>>>>>          ffff80008125a8c4:       91002297        add     x23, x20, 
>>>>> #0x8
>>>>>          ffff80008125a8c8:       52800518        mov     w24, #0x28 
>>>>>                  // #40
>>>>>          ffff80008125a8cc:       a9025bf5        stp     x21, x22, 
>>>>> [sp, #32]
>>>>>          ffff80008125a8d0:       b9400296        ldr     w22, [x20]
>>>>>          ffff80008125a8d4:       120002d5        and     w21, w22, 
>>>>> #0x1
>>>>>          ffff80008125a8d8:       9bb87eb5        umull   x21, w21, w24
>>>>>          ffff80008125a8dc:       8b1502f3        add     x19, x23, x21
>>>>>          ffff80008125a8e0:       f9400e60        ldr     x0, [x19, 
>>>>> #24]
>>>>>          ffff80008125a8e4:       d63f0000        blr     x0
>>>>
>>>> It looks like the disassembly now assumes this BLR wasn't taken. We 
>>>> go from ffff80008125a8e4 straight through to ...
>>>>
>>>>>              perf 12720/12720 [0001]      5986.372298040 
>>>>> sched_clock_noinstr+0x3c ...sight/linux/kernel/time/sched_clock.c 
>>>>> 93                 cyc = (rd->read_sched_clock() - rd->epoch_cyc) &
>>>>> Event type: branches
>>>>> Sample = { cpu: 0001 addr: 0xffff8000801bb4cc phys_addr: 
>>>>> 0x0000000000000000 ip: 0xffff80008125a930 pid: 12720 tid: 12720 
>>>>> period: 1 time: 5986372298040 }
>>>>>          ffff80008125a8e8 <sched_clock_noinstr+0x40>:
>>>>>          ffff80008125a8e8:       f8756ae3        ldr     x3, [x23, 
>>>>> x21]
>>>>
>>>> ffff80008125a8e4 which is just the previous one +4. Isn't your issue 
>>>> actually a decode issue in Perf itself? Why is there a discontinuity 
>>>> without branch samples being generated where either the source or 
>>>> destination address is 0?
>>>>
>>>> What are your record options to create this issue? As I mentioned in 
>>>> the previous reply I haven't been able to reproduce it.
>>>
>>> I am using below perf record command.
>>>
>>> timeout 4s ./perf record -e cs_etm// -C 1 dd if=/dev/zero of=/dev/null
>>>
>>
>> Thanks I managed to reproduce it. I'll take a look to see if I think 
>> the issue is somewhere else.
>>
> 
> At least for the failures I encountered, the issue is due to the 
> alternatives runtime instruction patching mechanism. vmlinux ends up 
> being the wrong image to decode with because a load of branches are 
> actually turned into nops.
> 
> Can you confirm if you use --kcore instead of vmlinux that you still get 
> failures:
> 
>    sudo perf record -e cs_etm// -C 1 --kcore -o <output-folder.data> -- \
>      dd if=/dev/zero of=/dev/null
> 
>     perf script -i <output-folder.data> \
>      tools/perf/scripts/python/arm-cs-trace-disasm.py -d llvm-objdump \
>      -k <output-folder.data>/kcore_dir/kcore
> 

With below command combination with kcore also the issue is seen, as 
reported in this email chain.

timeout 8s ./perf record -e cs_etm// -C 1 --kcore -o kcore \
dd if=/dev/zero of=/dev/null

./perf script -i kcore/data \
--script=python:./scripts/python/arm-cs-trace-disasm.py -- \
-d objdump -k kcore/kcore_dir/kcore


However, with below sequence(same as your command) the issue is *not* seen.

timeout 8s ./perf record -e cs_etm// -C 1 --kcore -o kcore \
dd if=/dev/zero of=/dev/null

./perf script -i kcore/data ./scripts/python/arm-cs-trace-disasm.py \
-- -d objdump -k kcore/kcore_dir/kcore

Do you see any issue with the command, which is showing the problem?
Also the output log produced by these both commands is different.

The below diff that you have shared has no effect on the failing case.

> But I still think bad decode detection should be moved as much as 
> possible into OpenCSD and Perf rather than this script. Otherwise every 
> tool will have to re-implement it, and OpenCSD has a lot more info to 
> make decisions with.
> 
> One change we can make is to desynchronize when an N atom is an 
> unconditional branch:
> 
>   diff --git a/decoder/source/etmv4/trc_pkt_decode_etmv4i.cpp 
> b/decoder/source/etmv4/trc_pkt_decode_etmv4i.cpp
> index c557998..3eefd5d 100644
> --- a/decoder/source/etmv4/trc_pkt_decode_etmv4i.cpp
> +++ b/decoder/source/etmv4/trc_pkt_decode_etmv4i.cpp
> @@ -1341,6 +1341,14 @@ ocsd_err_t TrcPktDecodeEtmV4I::processAtom(const 
> ocsd_atm_val atom)
>           //  save recorded next instuction address
>           ocsd_vaddr_t nextAddr = m_instr_info.instr_addr;
> 
> +        // must have lost sync if an unconditional branch wasn't taken
> +        if (atom == ATOM_N && !m_instr_info.is_conditional) {
> +             m_need_addr = true;
> +             m_out_elem.addElemType(m_index_curr_pkt, 
> OCSD_GEN_TRC_ELEM_NO_SYNC);
> +             // wait for next address
> +             return OCSD_OK;
> +        }
> +
> 
> Another one we can spot is when a new address comes that is before the 
> current decode address (basically the backwards check that you added).
> 
> There are probably others that can be spotted like an address appearing 
> after a direct branch that doesn't match the branch target.
> 
> I think at that point, desynchronising should cause the disassembly 
> script to throw away the last bit, rather than force it to be printed as 
> in this patch. As I mentioned above in the thread, it leads to printing 
> disassembly that's implausible and misleading (where an unconditional 
> branch wasn't taken).

Thanks,
Ganapat

