Return-Path: <linux-kernel+bounces-518321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A26B1A38D30
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 21:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A88A188F147
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 20:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4914B2376EB;
	Mon, 17 Feb 2025 20:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="jnq2DcaM"
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020086.outbound.protection.outlook.com [52.101.191.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DD0225413
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 20:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739823697; cv=fail; b=uoHMyorRiV69r8uN2IS9E/F1DPIw0gbM30yDLUzV+4Hn8yyYlmjmykTLJJczdGu/840RJjrpNvYgROenA1eXXxyUHp3ob8MdYbYxcqxWls2vnrQfhXLdYLYiO+n2O/VBao5dnRJyJof4S7tO5IrITQgc4h9CYjAYjNk8RQMNgYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739823697; c=relaxed/simple;
	bh=1f0z4e3xn2ZseiIvAoBNZx6pQFQ7P0iS7ZYI7m1MY0c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AHVIimaiaL95+mw5BUGGyRqy+5nQKcU5GB1M7QeyfNw1f6L6fidupVZSGIowG4iU2hBXdGMWtaoxFvYBLjeSLPHYgcX6vbGfWGwCQftFV54CiqTWcmqQgI70JNjoRbj+C9Jd2kMFaD4/NVypDf5G8fnwap9rvKuzfw8RyWyRL5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=jnq2DcaM; arc=fail smtp.client-ip=52.101.191.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mFql6/Tk0r5cJYGok4zC+fsWHQ+2TQ9hxUYyG9KoHQQ6lT0755Maj+axObulfKkrmJW80CfhMLhF3COCOyUsbB13la6pFCTbdUiqpVTtSbx4xzkAd6cWMKq+1M99x9e+bB1dKBUWbIR1fV2g51dxCjMCruY9tazW3Yk7OdXJ+mQOxDCYq1heZLLDDOx92LAroQwqVHFgWGwxH1ya1i7XS32gKUtByBArlrLfYa3/03uMK2/HJVtBoQ5IRl0Q6luytFcxvTLZ6Z5U1AzbMZy7nlC8pFj/S8VWI51WZAjo0RYF+PW4E7H3xexX6UBNWkCaezd/yY+3QdD/NzQS+gq8AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nKsPjV9sZlZ9bXEyF6c8KbT13QN2lwFsf+SaiR5zNu8=;
 b=VLOFH4LZ7URIe1f8t7DZWPzZcG6LzJzlfT32WUEp7inQnHbjM3aLHt4xpv9L5VgumjGvwLjaNta6O1ENELsFNcLNu8bWxrYP6x2Q5VhQLq29j1LT2trpfSW2zJxXflheFRoZiAxocp3Bw3FkplS0AtItdWPuyi8aoayOgfdMNWMnFiMm8cUj58R7klVmu3yrBLenj4+JiQAnTu/sC7uOgNa+G2Ncc2yXW6D9LsUnCnxv4h/SVGrXT9EkrE4praDaLE7rLQ4+RNFfd8LYJhyQWtXOcwKnIGG0gKmcVNNGrPLp4V3b91uiEdEYE3C8ErgCrqRvQIFob2yvMmsoGnxpJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nKsPjV9sZlZ9bXEyF6c8KbT13QN2lwFsf+SaiR5zNu8=;
 b=jnq2DcaMpvJb3Ha5/MPF0HkmVfOPmxdpZXUb0ikljb/+faiPdo9qnoppJm9JrlklfkRd9lOuUqiIxoKmkpYM/V3QfaPFRl4uQjhjFdJsvtDXyLQxXNQ9FpzUTKXI3ZfWq2qwmOYYavhLyRNpueOnFi4N2VVgz3LgJvKC3N6VucaqSbLmhLAnPMXISW5I4dfTwMKy3a8sIpwhflWPolkGH4eVYnfcmoWW06x496xB+XxYlld+4qZiC1pbKoZdr503upQJXGJLTCktX5Ndc4Fh1Nr+AmgVK+Eago81s1pVIeHQGqC1FvMYhC3ZgZNhGbsEKFaOc003tB48AXLgfvZadg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB11254.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:147::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 20:21:33 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 20:21:32 +0000
Message-ID: <f68741e0-0cc8-4faa-8144-e1786b9591f1@efficios.com>
Date: Mon, 17 Feb 2025 15:21:31 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] rseq: Make rseq work with protection keys
To: Dmitry Vyukov <dvyukov@google.com>, peterz@infradead.org,
 boqun.feng@gmail.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, aruna.ramakrishna@oracle.com,
 elver@google.com
Cc: "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1739790300.git.dvyukov@google.com>
 <0d0e0a0a7136d49af9a8d6a849e1aa4bf086c472.1739790300.git.dvyukov@google.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <0d0e0a0a7136d49af9a8d6a849e1aa4bf086c472.1739790300.git.dvyukov@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0223.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::12) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB11254:EE_
X-MS-Office365-Filtering-Correlation-Id: 74b2af4b-2875-4fdb-0b86-08dd4f90ab56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R3lLTDIwUm9lZUVjQUxxcHh2T01MYmtPYkwxb1gwcE56MnFybVBmcTdobmdi?=
 =?utf-8?B?TU9HUzI0Y3hKV0VJMWtpQTZTZ0Rsa0tHMFo5ZUJHR2pub25STm05ZSt3aFJJ?=
 =?utf-8?B?aHJLSS95QUl5NXcxS0Rzd0pCd2dBd1Q5cGFzYkFlSGJ2Skh6ZndyWmlIZWRv?=
 =?utf-8?B?RVI3ekFhZFpEdE53QVBsLzFKcFh1NmpLN2syZEJaMzhkcjdhUFZmZTg1eFpE?=
 =?utf-8?B?Zk0zd3p2VFVTZnNnOHUxcGFWOUpEckpjMDFPU1VUd3Y2Q0hKRkswSG13YWdC?=
 =?utf-8?B?SGZabk9LSWNCQWZWYlpoc2VwdkI4ZXhQQmxuRFdmOW1XQWdYQjJPWjFqNmx3?=
 =?utf-8?B?M25FK0ErejJrZUsrdTFZSGJWM1I2RmNFcWZWdlFZQ3FLRlhzaXo5QmZibzQ1?=
 =?utf-8?B?V3I1VlVmRXN5VjNUWmRVOHZXa3RiVzNUdFZ3L1BvQVc4bzNxbi9zL2VSaFVr?=
 =?utf-8?B?WldQN3V1TmhjOEhyTWlPenAzWWxTUGN6cE1rZm84Q0pVQlpWRjRLWmJEOVZs?=
 =?utf-8?B?S0pod0tKQ1VsVVB4a0ZybkFNSjJOTHN5SXNXZVNXYTlFNEQ1aGtmdlp3a1hx?=
 =?utf-8?B?bitqYVJBNzB2VWhKemFLSmlJK2JmNTNrNE1GeEVYTjIxZmREMFY3K0ZNbXBt?=
 =?utf-8?B?YTNJUGR3cXpDRTZlM1QwSkZLeG5rR0duTHBXVmIzTVBnbWkrZm1zUkYwdE1t?=
 =?utf-8?B?SVdqV2RBV1NPOUQrcEZqVm1vMG9kN1FCeG8wWnE3SHVJSUJXMjY3b1FBYjFK?=
 =?utf-8?B?ekFHZTNja0lWRjR2Q0QrYk84NzJ6ZGVHU3E0Wk1KMHRGejZXa0NQRlJ2N1ls?=
 =?utf-8?B?Wi9WcGM5OWJJVnBHQ2xRaGJFVGlMMHphMThaQ25rdUZ1NTRNK05kOU1qNExn?=
 =?utf-8?B?bnB6QXllbDJkNWdPc1E4c1g2czFnS052SFBRdXNZZVFtWHZvWk5IUVZ1Nzcy?=
 =?utf-8?B?dytpREovWUtBSEswTThQd0prQkFlSzFCNEhGOFVKVUxGWHJndlJLN2lhWSt3?=
 =?utf-8?B?aVBXRjAwTG4yeE9ZNlBrTmtzVG16U2tkT09LZFQ4R1dzSzZoTEdZSGpFR0J6?=
 =?utf-8?B?MDJic2pINlBYMWNOYmJUVjI3aVErY0ZKWW44UXBya2llYU9lRkZXaEdNenN2?=
 =?utf-8?B?em9ESEowRVlrMUVIWUpNWnpybk80cElZT1Zyc1RSOEY2dkl6TEtRT082R0pL?=
 =?utf-8?B?U2x2TkZ6V2lESTNGV0x5bXVrOFd4NkNyNW12K2t4OUM5VkZROUYveElGNDhp?=
 =?utf-8?B?QTY2UG14R3phUkRycllJWjMvN0xtTnBOQ3hJUHRaeHd0ZG9FVlRKMkhwN0tV?=
 =?utf-8?B?YzVsME5zVVJMQkNTRjhSMjBCNzJCUVNlZWY1R2plMTd0TTJEd0dKeFBZVC9N?=
 =?utf-8?B?ZURRZy96WWw5SVg2RFlKc212MjJZdEtCM3NRbStwd1BLSUVGTWd4bEFTMjIw?=
 =?utf-8?B?V2VFcWhxUTJ6UWpqMnRJZGVKWTdVWEhhYU9MdjN2aUZUTWV6OEY5b3VTS0ZD?=
 =?utf-8?B?TllhdGhBbFBqMVhnMmxWZTI5OW9vTDY3OHpsTUVIOC9jSXFnOGpkcjJ2TlQ1?=
 =?utf-8?B?WGlLK0hrT2Z1ZmVxUC9mQ0syVTRVTFVHMnFJYlNnVHNqazNQZ2Q4NU5PSDVw?=
 =?utf-8?B?M0ttbnNoVkZhMGpsQjcvRU5xTTlHQ1FsSWl5TlNGTzBwSSt1UWxJZHZ1YkQz?=
 =?utf-8?B?K3E5eUEyQWZlN2ZjcVQwVy82R1Noc3dvU0swZW5KZHRQNHVVN3lFL1VzNlIz?=
 =?utf-8?B?bkFUSjVxQU82SlB0Yjl3NkoramFTZnloTWUrZlVjUlBoRWxTam9GZXVOMmVl?=
 =?utf-8?B?Y05RdjFVRVJwUFlvUFJrQ1ZpMXNJQWVuVXBIVDB6Tmk5d21RMjdVUVYySUpo?=
 =?utf-8?Q?D8pICUaVPdYOe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RURoS2w5Q2RiMVlSWTNSVXdWNHBZZXZWbnd0eGFJMzd3N3pPVUl1MmhsTmND?=
 =?utf-8?B?Y1Q2V25oY2pnZHcrL0FpTy9ENzdFeW9GVGtFTFlrTmRMYjVBaTRERXQ5bi9p?=
 =?utf-8?B?Q3hzMWtxZE90MGprYzJkelUzRlRFT0RidGQ1QzJ0ZmFXQXcwdTBNVTZzV2xC?=
 =?utf-8?B?VWpPamR2T0xrSEFSTFlUZ3ZsSDZvRmxsYlJ6MmIvY3JIUmEzVStCUERPeUxN?=
 =?utf-8?B?dHU1MDUxLzdTYWFMYzlnMnM3aDlSMHZ6L0pWU3R4TlAyQ3cyNzA4aS9iNnhB?=
 =?utf-8?B?U0UxTVN4cHg3Yyt1Z09vOEQrQkZNTlptS1hGVUhjTjBDZEF2dXkrcjFEam8v?=
 =?utf-8?B?NXJSbDhhVmNCRDA4Wjd1NG9PVG1wdmo4Vm5VcXozV1B4cXlTZHVpVzdmQ1oy?=
 =?utf-8?B?U2VKUk9iVTlMbUtJWEdPaWNCZ3lhWWQ0SjdaN1ltQkFOSVRsY3VoMGtPMlBB?=
 =?utf-8?B?dlhYOGViVlZCRExLZ1JHMjJkN1pHT05yckI4Q25lbmFyV2hlRlRlaVdBaWds?=
 =?utf-8?B?cWFPQUp4MVcxaVduUmV6SCtQK25YTHpLVzF5N2ZkSkJwKzhSTTIzNkZsc1lp?=
 =?utf-8?B?M0dYVm1vcGtqUHNSang4MFp6a0pOd21aWmVoUzQvWDhXSzdkZ1RDanpvaisr?=
 =?utf-8?B?am5VUVdxMUNBTXZ5U0Q0NXlidXVqM3dON25DV25qQjlvRnpDK0VKaXdEMjRG?=
 =?utf-8?B?Nzg3U2tET2VqWUFlQ2gzdXh5M1NQOExQQTVMZWlJbnpxdXNodFZ2VjRNZ0xJ?=
 =?utf-8?B?Q09iSFJyb1d2blJNM0pib3E2RlRIcmJjTkhaakJNTzYwbmN5WGdXQ3kxNXcy?=
 =?utf-8?B?NzlkNE1TMU5iMnl5ZGZqbVBMb2ZNdzhCUmVXVFVwOG1TRVFWTmV0a1FKeFRz?=
 =?utf-8?B?bnF0MjhldFVkbmtLOXM2bHAwQ3UzbE9DMWJISFlINnozR3JRSnlkMXNaejE0?=
 =?utf-8?B?OU4yT0M3Z0hld09MODgrK3dZaC9CWjAyUm5ibytFeGE0QlRlQVFYVG9LTVR2?=
 =?utf-8?B?U20yUG1XVEt0N1dWNzdvekN6UDNXbmQ0TC9FRVhPSXdsT0hESGk1YVkvTnFN?=
 =?utf-8?B?dTdyaEo2Sm5wN2N1d0RnUWNETjd6Yy9XaHV6UlpjbzJJMHppR0Uyc3FKR2NN?=
 =?utf-8?B?Y05iU0tsZ1hJMElqclQzWjR4bFduSEtaUTlPOE5xWVlkS2I4UDdxSFJZZ2dZ?=
 =?utf-8?B?R080cS9HZURZWFlnSHMzdWNOSS8zQkdFN3lmSU1hR0ZsZFNvaUwrRDJsYlEy?=
 =?utf-8?B?WlA2eVZqdU1pUDMzWnlZVjkyS1VJaUFUNGR5RFY3TzJ1TDNtaXZJcFBhSnBo?=
 =?utf-8?B?Ui9WWTNrTlJ1TjhaTHFrQnZnZHhicUZmZzhFWmVMUzg2SUNrcTJXYkd3TDls?=
 =?utf-8?B?bXlBN2dHd2JNbmo1ZTdkUGhWYXgzS3g5cU83ZUpGY3RkV3ZSVlpodldwM045?=
 =?utf-8?B?dlJHbFkyckMxZFJ3bHV1Tkk5VHF1dytRWnEzcnNOenFZYld6bndYTUNUZ25h?=
 =?utf-8?B?T2lsYXF1RGlmMkFRc1FqbXVsWDFDejErOG1QeUhUeVpqNUJoaXUwTzhudGJ6?=
 =?utf-8?B?R2dtVEZES0JGVVFxbXBGK3REYk9vRCtucGg3bkVMVHBDNmNUODduZXZZQ2tr?=
 =?utf-8?B?akhIOEVFRjZZQ2Z4L1I2SVNMMkdOYzdvSWpuZmRYSWJZMEZhZ3JqU1dnSzF0?=
 =?utf-8?B?VnVtMGhtemx3UjZvZHAyTXRFaVVGbEdyZVBCUVM0WU9TOGZJRFQybGZVdkRK?=
 =?utf-8?B?SXVOcU95QnI3a1dGTjNWb1M2WEFzYlk4Z2s2UWZ6a0E2Ky9mR2Y5MU1kY2hv?=
 =?utf-8?B?SWJMM2Q0dGk5UzlXMTRZa1lpRlFlb3dtM1VjT0hRV1dPYmpNWUtvN052K2kv?=
 =?utf-8?B?MzR6SFhObnhiZ2dIWTNwRm1ZL1padlV2L01rU0pGL2NoOWNCeEFGeHN3dEF3?=
 =?utf-8?B?QUF1YnZrTSs3T3pCOXZaK0I5UDZPUC8zb0RwQml4K3VUOTRuUDhjTlJQdkpE?=
 =?utf-8?B?M2xTY1JOWVpka04zQnhZNEJ0aVF6L0tDdnNwZTNsMW9nYlRUeFVpalcvN1gr?=
 =?utf-8?B?VEFxSkJray9vajMzSUx2SFpxYWkwYVdWcDFmZ0tHNnJSb2lpRTl3emorOW9E?=
 =?utf-8?B?NGt2R0NYUTJkQlFuWFJ1Zm5WanUrdi9BZWxQWjN3SDR5N2RpVnFYTzVYa09M?=
 =?utf-8?Q?KxjdP5yJ6JwJdYoI0k2aJR8=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74b2af4b-2875-4fdb-0b86-08dd4f90ab56
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 20:21:32.6300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pe9+z9Jm3pkeKHdY59ToF6i4MUmFuBDIBlaIiS5EQFwTfp5aD0oN1NbNi85iYyhyLAZO6ya9b2HnNwLjgQiRrxezLdN0sWVFPmp3MEK/M8g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB11254

On 2025-02-17 06:07, Dmitry Vyukov wrote:
> If an application registers rseq, and ever switches to another pkey
> protection (such that the rseq becomes inaccessible), then any
> context switch will cause failure in __rseq_handle_notify_resume()
> attempting to read/write struct rseq and/or rseq_cs. Since context
> switches are asynchronous and are outside of the application control
> (not part of the restricted code scope), temporarily switch to
> premissive pkey register to read/write rseq/rseq_cs, similarly

permissive

> to signal delivery accesses to altstack.
> 
> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
> Cc: x86@kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>   kernel/rseq.c | 36 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 36 insertions(+)
> 
> diff --git a/kernel/rseq.c b/kernel/rseq.c
> index 442aba29bc4cf..31cd94b370ef3 100644
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -10,6 +10,7 @@
>   
>   #include <linux/sched.h>
>   #include <linux/uaccess.h>
> +#include <linux/pkeys.h>
>   #include <linux/syscalls.h>
>   #include <linux/rseq.h>
>   #include <linux/types.h>
> @@ -403,10 +404,13 @@ void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
>   {
>   	struct task_struct *t = current;
>   	int ret, sig;
> +	pkey_reg_t saved;
> +	bool switched_pkey_reg = false;
>   
>   	if (unlikely(t->flags & PF_EXITING))
>   		return;
>   
> +retry:
>   	/*
>   	 * regs is NULL if and only if the caller is in a syscall path.  Skip
>   	 * fixup and leave rseq_cs as is so that rseq_sycall() will detect and
> @@ -419,9 +423,41 @@ void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
>   	}
>   	if (unlikely(rseq_update_cpu_node_id(t)))
>   		goto error;
> +	if (switched_pkey_reg)
> +		write_pkey_reg(saved);
>   	return;
>   
>   error:
> +	/*
> +	 * If the application registers rseq, and ever switches to another
> +	 * pkey protection (such that the rseq becomes inaccessible), then
> +	 * any context switch will cause failure here attempting to read/write
> +	 * struct rseq and/or rseq_cs. Since context switches are
> +	 * asynchronous and are outside of the application control
> +	 * (not part of the restricted code scope), we temporarily switch

Remove "we".

> +	 * to premissive pkey register to read/write rseq/rseq_cs,

permissive

> +	 * similarly to signal delivery accesses to altstack.
> +	 *
> +	 * We don't bother to check if the failure really happened due to

Remove "We".

> +	 * pkeys or not, since it does not matter (performance-wise and
> +	 * otherwise).
> +	 *
> +	 * If the restricted code installs rseq_cs in inaccessible to it
> +	 * due to pkeys memory,

This sentence should be reworded.

  we still let this function read the rseq_cs.
> +	 * It's unclear what benefits the resticted code gets by doing this

restricted

> +	 * (it probably already hijacked control flow at this point), and
> +	 * presumably any sane sandbox should prohibit restricted code
> +	 * from accessing struct rseq, and this is still better than
> +	 * terminating the app unconditionally (it always has a choice
> +	 * of not using rseq and pkeys together).

Note that because userspace can complete an rseq critical section
without clearing the rseq_cs pointer, this could happen simply because
the kernel is preempting the task after it has:

1) completed an rseq critical section, without clearing rseq_cs,
2) changed pkey.

So allowing this is important, and I would remove the comment about
hijacked control flow and such. This can happen with normal use of the
ABI.

Thanks,

Mathieu


> +	 */
> +	if (!switched_pkey_reg) {
> +		switched_pkey_reg = true;
> +		saved = switch_to_permissive_pkey_reg();
> +		goto retry;
> +	} else {
> +		write_pkey_reg(saved);
> +	}
>   	sig = ksig ? ksig->sig : 0;
>   	force_sigsegv(sig);
>   }


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

