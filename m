Return-Path: <linux-kernel+bounces-436099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A67859E8121
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 18:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05B051884117
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 17:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4051465BE;
	Sat,  7 Dec 2024 17:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="t8voRfX0"
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022091.outbound.protection.outlook.com [40.107.193.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FDB22C6CD
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 17:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733591170; cv=fail; b=ABER1o5FhtFQGxY3dthmYV+Ii3K2yuQLaToun8Gf3FvRRaQX+U/vszLAmo/rLZMdgj2sxOphL7lotYYwhs6qCthrflFz8adRJht0Z6DFMiH7jOJVckwCChQfQyEjGfc9ucL3aRvGsEaIBBU9qZkBTLXjwJDFq+i3Abg9RQVORHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733591170; c=relaxed/simple;
	bh=Bvowek68fRXPAMAVhqOLlIWN4OnMk1uXz8wTKLd4yZo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e1iY/0inYfMlO8/zEIt+SVUaVHZtRlMlmRd/BbltSVU2FD9w1U2OX4TcJImMd9NXZjnEIRXvR9XyKAbxOvkDi6ia23EXzoV/o+1uNkMeySblo460vS1db6LyYU51u5WTvHZxD2Z5BJwYve3PEqg902GjkpDJuFRfOIxAAR5DSiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=t8voRfX0; arc=fail smtp.client-ip=40.107.193.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nC5JJh5h/5Pbd7HXiyvLZb8QIA35VyYWw5og4qCN4keFcOk8ub2wlG1kE9PiQXqPWqGHTj17UaEVVeMVY19R7+cmCzZniXau9Tyxi8kOS/2+HSwWXMjsObJmewprMqymc7fK+IDKNRwHHeKE1AwqU7cAk7p5FdUSDeYMgoLqLUCEqERYks+wU7xb8SyUtpQkj8DmYbLaSaApIS5tdF6vCm4ZPRLsnQrGHBIZyPKqkNTjVuqttVwsZZ5EzOiUAQ4nUZ4p2awD8D/py+B7NeENzgEA87que+BCbqf07Z95rIO4ItejKQE+GlAaYQrUZGa1cgXXAdC6M54D+GcN0IczVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=26PPv3SNG1pvZmv1cxFZlvSkJppBlTOXeAeH/IDDz2E=;
 b=BjDLe55enJxMRgAn56zIgqQnqH6/BFb+YGkk4RHobx81j/j60lX1SAf14qPJm0TSKRqIVSMGIIQ/LmlbFchMBj3G/wAwZtSTC7L6ZhhAYrilIeXw2fxaeP7azQmj9P+QZ3ePEBkSEughauMD1u59b5nOSsl/QxNxMAbcpZrgHA3GeJaiMuZJl+4nXb3srqUKi15/gBzET7gGAJL/6vj9rgN6nCWHSO+fywLnpqzz3LOZTIvZd8njRpQdE99gVGqkjCDsEBtmW0CBFRdbZGi/JagPq8PHa4PvmR86Xfxvy3plVYhMC2JRVQxeNHYoMVJvM4y+ld2gIpivm0cCA+sjNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26PPv3SNG1pvZmv1cxFZlvSkJppBlTOXeAeH/IDDz2E=;
 b=t8voRfX0670OS2a4ZQcTkl5I3q+QUWUEeoPjhwQUIF/la/ylXXdraU4sOyyn3LmObzFaIhO4vRe0LVkxjAdMAyU85k9iJx4aeyGi3u9bKJGo5hh3NgGa8K3UZLI4mnddl4tJowaIee+7MrKONnqpY1DiSliTwdiRAFs8tLNE3BhoVcuijrCvdzrncin9sst1lEgvw4GmnxqZj/aJlpen3LaWqadHyoZyEVbxc4i1veyObbonngspp35idIB/8wyziga2pqZwYTjeAHt5IUgBPZE/r5MPT7LNyKq1GqQvz3FmYT6TCtll11/3Kx0rw40UG4bZzScHTldA4HmG/TgmQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by TO1PPF260681B1A.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b08::625) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Sat, 7 Dec
 2024 17:06:06 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%5]) with mapi id 15.20.8230.010; Sat, 7 Dec 2024
 17:06:06 +0000
Message-ID: <d8b2bfb9-6d9f-42e1-ae91-b79cb8dc1901@efficios.com>
Date: Sat, 7 Dec 2024 12:06:04 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] mm: use clear_user_(high)page() for arch with
 special user folio handling
To: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, David Hildenbrand <david@redhat.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Miaohe Lin <linmiaohe@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 John Hubbard <jhubbard@nvidia.com>,
 "Huang, Ying" <ying.huang@linux.alibaba.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Alexander Potapenko
 <glider@google.com>, Kees Cook <keescook@chromium.org>,
 Vineet Gupta <vgupta@kernel.org>, linux-kernel@vger.kernel.org,
 linux-snps-arc@lists.infradead.org,
 Geert Uytterhoeven <geert+renesas@glider.be>
References: <20241207165504.2852058-1-ziy@nvidia.com>
 <20241207165504.2852058-2-ziy@nvidia.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20241207165504.2852058-2-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0179.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8b::8) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|TO1PPF260681B1A:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d524624-8a6a-4ab4-54b0-08dd16e17050
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b0JJT2FxUXN5UmxRVU9TdGZ2UHlObEtSMFdzR1pXWDlOWFNnclJieW4xK2xE?=
 =?utf-8?B?QTlsV3VGaGU2cFB2QmpkVkU3a1hiU0dlUUxYS2xDUHFnZ3IyWjMrcnZncVY2?=
 =?utf-8?B?NDM5SmhmYU1Nd3lhcldGVU9ST2RHSkNyWHVZOU5CTkhSa0NjRXhSUlcrVnJC?=
 =?utf-8?B?N2lLYlIwaUpEYVU5c2trbGhVOTVpUnB1WlZ2am1QYTQzWTc2c0UvaTNqRTJn?=
 =?utf-8?B?bGVYL3FJMk40NnJiMjgxcFdCVlBNdW96TnNEVXRLK3p4YS84OHRxeE5ycXhj?=
 =?utf-8?B?YkhzaDVKRXM0SjNSWlBPekVrUDdoTFN2N00vSmlTcldsZDhUL2pDWXI0SFp5?=
 =?utf-8?B?YnBoVUxzSGhUS0hha0Q5bEo3ZlVwQVo3Y2VXOWlPZGxGdDB0eEJxazhtek55?=
 =?utf-8?B?TXc2Y1V6RU9uak96dmhsc0NnVFlhRWNOOHRFZVdYdUl3c2duL2JQN0ZqaTdS?=
 =?utf-8?B?M2MzbTZvbmF0S015T1FkNTRLOTVwL0JKTjRINGYyZk83Y1B3M1loVHhHNldD?=
 =?utf-8?B?N2U5Z2FpNzl5eHNGWDNDbTAva1N5K1JOanJ4QmFaVW1adnhRSW1HMnFOOGRF?=
 =?utf-8?B?YkRlRDgyczR1cG9rQlFwN3FaRGpWVzRGcU5FUlZ6N252SWplcDJ4WDRPcjRx?=
 =?utf-8?B?MFV3Tk1TR3FnL2ZNRWpGaFVSamtObzl3MDhlRmpHSitKTVpTRGJ1b1AxOERz?=
 =?utf-8?B?cDdpQVBVRzBQUzcyRzNzeVI4R04yRUcvcmlib1huejZOUGFIeGhxdkhNbnNC?=
 =?utf-8?B?ZDJLcFJnUUJTY29GQ2FVNFc4cWx2c3owc1RMdjBTWXg1SUxFM0xRZWovbTJZ?=
 =?utf-8?B?UGoxT1duRFZOZFZNRHY4d2RXZjdtWkVsRkp0VkFWaEJSZHFPZUVxMitpRkRh?=
 =?utf-8?B?SmlRVzZMcllEOEZwMlA0YVl4NjVFNjRNZ0s3cnhFMkx2YnI3bktiMDdzbHg4?=
 =?utf-8?B?eUV5U1poUUNXaG9ucWhEeWVRR3N3NHpwYkdhbFA1SmpiZk5OOWg2NmIwZldu?=
 =?utf-8?B?bDlFWEtUOTFIb0VteVNQYlRnY2d2Y0xEUkJ2YVU0RmVCajBEQWpsQXlsWTFv?=
 =?utf-8?B?TjRoc1QzcFMzOG5lakQxakl1L0dUZHgyWmZReTQvOE05V2U5Mk4rNU1namtC?=
 =?utf-8?B?RXdWVnhuc2ZwUzlxODZmeFFGSEpTdFdncEZIYnBFbk1jWmZtUW0yTWFPdzM5?=
 =?utf-8?B?dWt5cmxHbnkyRkdTNWxzc2JQSEpBRXlUQ2xURlMrYVBxNkxlRFdJZ05TNEhD?=
 =?utf-8?B?Q0taWFFxQmVsaHBnNFVGQmhtWExEa3QvckQ5UTRJZnRpbTUyTzZFZFhEajdx?=
 =?utf-8?B?T0JBdkt1NTNHQVkzS1p0ZUtkU29XWlV1cEpLMlhtdE4vUkkwamwzQkhUTmRn?=
 =?utf-8?B?dDBBaVgreDdTay8xZU1FSFRnRXZ0T1UyRFFBT25JM2I0cUtOWFlyTm1TcVdP?=
 =?utf-8?B?eGRyS2JiT0MvTDdGUUhqbFpYT1lZdlAyKzVrM3A3VXVpcUZ1RDZFSXhpckJw?=
 =?utf-8?B?QklOczJXNUVkRmw2RVRrY1YyYjNXUHZkT2UyUWh0eWFkS2xVVXNZdHBzb1dF?=
 =?utf-8?B?anB4cm81YmdzY0kwQWcrY3lwSFRDZncxRGJBZ0szN1BnMjRrV1BpVmlvL0dY?=
 =?utf-8?B?UTJLMko1VnhhYjJyV0ZBREFxY3UzZFVsUk84dzMwMVNWUHVIaFRTbUVpRklK?=
 =?utf-8?B?VlpkZGRaQWlzbUFQa1kzYlJ5ZEl4d2VzTTFORkZOWGp0SVB4cmNMRXNJK0dV?=
 =?utf-8?Q?Zn1v4f/cAoTMqlBlVk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(10070799003)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dXdvWm5OajJCaENrejl5ZG5BbnV4UnR4SWtENWVxaGJUSVgyYlhqTEFNUkpq?=
 =?utf-8?B?MnB3Zy9jeTh6eS9JUVl4U3F4SkZvQkR2SlFsZ1RNc1ZqWmZnZ1d5MEhtaTRz?=
 =?utf-8?B?Uy9xNmdDVWZBWnNyTkMza21JcGJ2aDNuNXJTUjhLRVdXakxlenBUZ21sOTVY?=
 =?utf-8?B?U1pUM2REYjVXcWlnZi9KVGh3MU16NjhVeVAyNG1adlRxM2hsaTJmZGtQZWpD?=
 =?utf-8?B?bkZFZjUvSWw0RVcyREFWcnlPY3RBRlhhd04xL0R3TGkzQkRZN1hPR2w4ZWR6?=
 =?utf-8?B?RXBHQWRkN1gzOWFBOU5IdmRkNHZkS09CdEk4VjkwMVRnMVBKOFBVSWxwNGk1?=
 =?utf-8?B?NUNvMjBQZTVGWnJ5bDhrY3E4ZkZhQzJmejRrcDJRTGcwcnVlMnh0L2tZVjdM?=
 =?utf-8?B?ZHJNSEZUK280QkZMMENwM0Y5bE5TVENpWlBjeGNZVGRSRFZXUCtoTkRpa1Yr?=
 =?utf-8?B?YldKdFVCQ2FSMU82NldwRUNrMEtxQUpPWno1WGNqeTUwMS8rTWRVbXhOUjdQ?=
 =?utf-8?B?M1hwZVBtYkhoYlhBSUNPenNTeDJ5MFBWaFU4czlWdjFqSnVxQzRqM3JvWjYz?=
 =?utf-8?B?cDBZY01jS25DZzU3dXVvQ1AxOTVhQTNHUGVLdVA3NGtuUE81TVZaUkVrTit3?=
 =?utf-8?B?UGJYSm8wc1pWaFBjVU5lL1VUV3V5SFBiOUMxS3gvSkhLQmtDUmZIenBLU0xB?=
 =?utf-8?B?QTlHaDVFVWpRL1Z3ZDJUdmx6VFZhSEhMUjZRZk5MSnhiMjZwU2FCb1ljSUpU?=
 =?utf-8?B?czh1aEsxZlRKTkNFSFFNQjVST0YvMWZEOU9DVk5UQ0tDc2ZGaDUvb3pOWjd2?=
 =?utf-8?B?WFdqbVBLbU1MVUE4ckdlRlhKR1hFTEhCWDlUYlVFc1FpU2ZPUmF6Wm03Sk9K?=
 =?utf-8?B?bFdibStCRTlyVTlqOTZydnVISUhzWlQwK2Jtb2RRTnkwTTZLM2poaVJ6Umt3?=
 =?utf-8?B?SUNka0RwdWtoWEZXNk0zdHUwa2RNM3VxaVdCOHRnbUZZb0NOVTBaOVppOC90?=
 =?utf-8?B?eUtBSWF3bWZEcFdlc3ZHUVowMFAvOUVGSTRQRUh4Vnk3NkJWeFd5aXYzNnhr?=
 =?utf-8?B?NGJXWjBjcWF0QUFaYnJ5SEwwdkpzeWRxSmFCOHNuNHBYZVVoRVV2UnVZVTJM?=
 =?utf-8?B?c2ZHSER5UWk1OEYraDdqaUxmZ2pQZVFYWUFkcDVlelJCN1YvR2V2aGVrU2ZL?=
 =?utf-8?B?N25IeDJYYVRFNjVKSkRhcEdSMEx2cXllYnUvNmpsQ05LWmd3M1pVTlpoalBT?=
 =?utf-8?B?K0pZZ0hkREJJaTYwKzRxZ2RHZkIvekFBZkRwT1NnYUVsTWxxUzIxS2l5OEFO?=
 =?utf-8?B?V3pVcVc3c1NCbTRORm5oRnhjUno2M2w1LzZ2bUZKNm8zYmppV01pdFh1VEJR?=
 =?utf-8?B?VWlyNkNHR2R5cHR1YS9aNHFDRHpGUFlEVnVVRDZuUTJDZzgvWGVNWFZ1bkVG?=
 =?utf-8?B?TTRaZVNmVHVzWlRiU3NrTFJZZWFrd2FiWDJDaHNSS1Y3bWZHWmVEb3JVVE5M?=
 =?utf-8?B?NEdiaUNVVEV4ZE5SWnZidDNNOU5KYi92V2dDa0M0bWQvOWJwbGVwcjNwOE1I?=
 =?utf-8?B?aXlnUFk1K3BLYndWeUk1Mk9WTloweDBISzJKNTI4eVBiUW9ndjdCTHdVY1hs?=
 =?utf-8?B?M1JpNEJvdkZESkxORStSZ2tZMVduYmh0U0E5dlFRMGs5dWk5cUxBczMxZnEw?=
 =?utf-8?B?WldBUjBVT2lPNlNCa3ZOMFBhU1I5bEtkaXRzWnpRbG1HWEgrZTdBL05iVGxK?=
 =?utf-8?B?bjA2dGRsM1U1MXJqRU1tVDYvMHptQVNxNWVLSklYam1vbk1QSitXMXpjK3Fu?=
 =?utf-8?B?bFg2bnd0RE9uRzZqZ1NYK3EwcDAyMFY2QnJKVDRZMjNFRmNmSndvamZqS2E0?=
 =?utf-8?B?RVhXdk5NQmJaOVRLRmFzZ0VQMW5SYzVVRzVlQXFWOERvZ0VYeFM4c1EyL1pE?=
 =?utf-8?B?eVZEeUFQeXB0aE16bXpDV21IWlRYYVRkZ3ZEU0FrTzFROW5xT2E5V0p5aDVI?=
 =?utf-8?B?Z3liWHVidWVrSExabHdSRndqVGU1QlhZVytYbXl1NFh6aldPTE45dEJvVENw?=
 =?utf-8?B?cGNJbDk4TmRsZFV4anNjdmh5WUFLZVdobWIwVEQ4cWI4M25RYkg3cVFqUzFH?=
 =?utf-8?B?ZGlXSDRNSGs2cEhwVkFDR0xqRDZpK00vVXV0OHhDU3FzUmZ1V3F4bkZLeHFq?=
 =?utf-8?B?RWdJTVh4cXJhUFJLOWQ3QTRLVkNYc2RUUTFZbDVOczJMNkJwUVJHQnFueTFC?=
 =?utf-8?Q?n3W+YIKKGmMTcXQ0CUcLOmHMWcwTKIs9r+qIZGQxEU=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d524624-8a6a-4ab4-54b0-08dd16e17050
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2024 17:06:06.5114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xe0Lq5nlHXTnmHc+qqdaF+5uMFbxqG+hyWVJoGSHMHskZS+MKVhF2P5GSjG7MCBl0O8oWpWCW8iAqt1iZzzVK67OHlCf86mUWV3UvqSwYMo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TO1PPF260681B1A

On 2024-12-07 11:55, Zi Yan wrote:
> For architectures setting cpu_dcache_is_aliasing() to true, which require
> flushing dcache, and arc setting cpu_icache_is_aliasing() to true changes
> folio->flags to make icache coherent to dcache after clearing a user
> folio, __GFP_ZERO using only clear_page() is not enough to zero user
> folios and clear_user_(high)page() must be used.

The sentence above is rather long and unclear, perhaps split it into
multiple simpler sentences to clarify the intent ?

> Otherwise, user data
> will be corrupted.
> 
> Fix it by always clearing user folios with clear_user_(high)page() when
> cpu_dcache_is_aliasing() is true or cpu_icache_is_aliasing() is true.
> Rename alloc_zeroed() to alloc_need_zeroing() and invert the logic to
> clarify its intend.
> 
> Fixes: 5708d96da20b ("mm: avoid zeroing user movable page twice with init_on_alloc=1")
> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Closes: https://lore.kernel.org/linux-mm/CAMuHMdV1hRp_NtR5YnJo=HsfgKQeH91J537Gh4gKk3PFZhSkbA@mail.gmail.com/
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>   include/linux/highmem.h |  8 +++++++-
>   include/linux/mm.h      | 18 ++++++++++++++++++
>   mm/huge_memory.c        |  9 +++++----
>   mm/internal.h           |  6 ------
>   mm/memory.c             | 10 +++++-----
>   5 files changed, 35 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/highmem.h b/include/linux/highmem.h
> index 6e452bd8e7e3..d9beb8371daa 100644
> --- a/include/linux/highmem.h
> +++ b/include/linux/highmem.h
> @@ -224,7 +224,13 @@ static inline
>   struct folio *vma_alloc_zeroed_movable_folio(struct vm_area_struct *vma,
>   				   unsigned long vaddr)
>   {
> -	return vma_alloc_folio(GFP_HIGHUSER_MOVABLE | __GFP_ZERO, 0, vma, vaddr);
> +	struct folio *folio;
> +
> +	folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma, vaddr);
> +	if (folio && alloc_need_zeroing())
> +		clear_user_highpage(&folio->page, vaddr);
> +
> +	return folio;
>   }
>   #endif
>   
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index c39c4945946c..72d644cc8d9d 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -31,6 +31,7 @@
>   #include <linux/kasan.h>
>   #include <linux/memremap.h>
>   #include <linux/slab.h>
> +#include <linux/cacheinfo.h>
>   
>   struct mempolicy;
>   struct anon_vma;
> @@ -4175,6 +4176,23 @@ static inline int do_mseal(unsigned long start, size_t len_in, unsigned long fla
>   }
>   #endif
>   
> +/*
> + * alloc_need_zeroing checks if a user folio from page allocator needs to be
> + * zeroed or not.
> + */
> +static inline bool alloc_need_zeroing(void)
> +{
> +	/*
> +	 * for user folios, arch with cache aliasing requires cache flush and
> +	 * arc changes folio->flags to make icache coherent with dcache, so
> +	 * always return false to make caller use
> +	 * clear_user_page()/clear_user_highpage()

Missing "." at the end of comment.

> +	 */
> +	return (cpu_dcache_is_aliasing() || cpu_icache_is_aliasing()) ||

I suspect the () around "cpu_dcache_is_aliasing() || cpu_icache_is_aliasing()"
is not needed.

Thanks,

Mathieu

> +	       !static_branch_maybe(CONFIG_INIT_ON_ALLOC_DEFAULT_ON,
> +				   &init_on_alloc);
> +}
> +
>   int arch_get_shadow_stack_status(struct task_struct *t, unsigned long __user *status);
>   int arch_set_shadow_stack_status(struct task_struct *t, unsigned long status);
>   int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index ee335d96fc39..107130a5413a 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1176,11 +1176,12 @@ static struct folio *vma_alloc_anon_folio_pmd(struct vm_area_struct *vma,
>   	folio_throttle_swaprate(folio, gfp);
>   
>          /*
> -	* When a folio is not zeroed during allocation (__GFP_ZERO not used),
> -	* folio_zero_user() is used to make sure that the page corresponding
> -	* to the faulting address will be hot in the cache after zeroing.
> +	* When a folio is not zeroed during allocation (__GFP_ZERO not used)
> +	* or user folios require special handling, folio_zero_user() is used to
> +	* make sure that the page corresponding to the faulting address will be
> +	* hot in the cache after zeroing.
>   	*/
> -	if (!alloc_zeroed())
> +	if (alloc_need_zeroing())
>   		folio_zero_user(folio, addr);
>   	/*
>   	 * The memory barrier inside __folio_mark_uptodate makes sure that
> diff --git a/mm/internal.h b/mm/internal.h
> index cb8d8e8e3ffa..3bd08bafad04 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1285,12 +1285,6 @@ void touch_pud(struct vm_area_struct *vma, unsigned long addr,
>   void touch_pmd(struct vm_area_struct *vma, unsigned long addr,
>   	       pmd_t *pmd, bool write);
>   
> -static inline bool alloc_zeroed(void)
> -{
> -	return static_branch_maybe(CONFIG_INIT_ON_ALLOC_DEFAULT_ON,
> -			&init_on_alloc);
> -}
> -
>   /*
>    * Parses a string with mem suffixes into its order. Useful to parse kernel
>    * parameters.
> diff --git a/mm/memory.c b/mm/memory.c
> index 75c2dfd04f72..cf1611791856 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4733,12 +4733,12 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
>   			folio_throttle_swaprate(folio, gfp);
>   			/*
>   			 * When a folio is not zeroed during allocation
> -			 * (__GFP_ZERO not used), folio_zero_user() is used
> -			 * to make sure that the page corresponding to the
> -			 * faulting address will be hot in the cache after
> -			 * zeroing.
> +			 * (__GFP_ZERO not used) or user folios require special
> +			 * handling, folio_zero_user() is used to make sure
> +			 * that the page corresponding to the faulting address
> +			 * will be hot in the cache after zeroing.
>   			 */
> -			if (!alloc_zeroed())
> +			if (alloc_need_zeroing())
>   				folio_zero_user(folio, vmf->address);
>   			return folio;
>   		}

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


