Return-Path: <linux-kernel+bounces-438418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB039EA11F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 22:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E857B188764F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 21:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E23B19DFB5;
	Mon,  9 Dec 2024 21:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="iXxkfBrQ"
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022118.outbound.protection.outlook.com [40.107.193.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4BD19DF9A
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 21:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733779035; cv=fail; b=KpZu1HgkAxO8IdDW6eJ973TRM2sGG9KeK22q3lbQwx3KZd0IaS2OdhUqfQDWJPlY5DDIRsxkOMUBUFbQBKjGeP+bKXF6g8UaARAiHKGofv8l18+TRTKdw16dSBE85L9wUhIwudnbwoQ47QmbSK6BLpMSYOyKxO5wV0FRWGNnx0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733779035; c=relaxed/simple;
	bh=DVEwHfCkcLP42DpOHBwYA0e16OYXE+ST8FSXqWZAOZE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eYr9kODT9nKWDUCpDaePrjru99Gqa4PQXq8FwkNuW4CluTRerYgVjvO3x42gJxJ1Y/zxJ3e34UDzDCVnRB7Cf4n2Tqyz2alvO0flOt3LShc+32dq2qFeXDw1Cz3TTdSPO/xM7UcHyBghywgu7KeJZRafoQzdsAFrSMGNnngfxAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=iXxkfBrQ; arc=fail smtp.client-ip=40.107.193.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ri+5FEiI9uKQe6yXyGCOTnrNrazMpS71qzOyn29gXi30jJOtQywIKukzPguWFXnlsGhtFVcnbWI7doNHLPPel92Suodaw4e38/4uaNrwjdxT95wfq4kB5FTozOSO71LA+S90z2tK2CHBZt3+0khPYuRHxq3QFV56zaEGM8oWrCmuSzjXmH5KP6NuzHOCpDIXIYTJoMYlq/Gx2bz4dfR8HPYzyewHLGY0NgcbD9SpPZdmlav+8KEqPuEkrPSeucbEvQ6ORekZZobr9w5ErCwbw/0kzIRCSioXqgm4I+KiJLqGNY0bqanI69AA98yPLVGicaqgJzmA8t8b1nTWdP1Obw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R+90oQlPPypVpE7RXfLMwsgHk/uB9Ad6bipBTFlcNWA=;
 b=H2C48Hq/CqS7qrlO8aIMm9b/Kh1tIWax+gzofZsqgdVo4pEjLzxGCzYTu4AYz0Phu1qLhbveKCTaxfC4tVFLPCRlCdvCUQEVn6wLFoiGntxm7piUgE1w4gsJiaa6TlQXUkQcBPDLglY3AhZMQztSzoXkysWjxJRtg94kHd6w6UyPcctZlf4AtUEMu2ZgnUlze1+/Ghx2uja0DyC5PXlUAQtTBdeIilcfa8y9o/QATAIVIrK6nwza/8HWalQdWQyyLWhSrkGOzR2eyS4Qjo/MKJQPsZUm5vBY5jouuZ8v9v+G9rRZllWhe+x/w8L8GgwC7LJP6dsqlUIdmqGOMA0w+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+90oQlPPypVpE7RXfLMwsgHk/uB9Ad6bipBTFlcNWA=;
 b=iXxkfBrQgfK9Hc1/75owclQRko776z1gp/iANMPNT6gYgOshpW3Bj+gJ4hp8PuWyRAzYI58hs5xu5hzeyM7G4mWnwbcxexK59b+BLC0gdOzkug+Az9fsi3XSEeOeLIWFkyzSlwrxe6RK9e6XwcjRdLzQwq6PIa3+qqOyB/CX+sB8eCwCUvUEcWJvqGMpcDQmkSJIuqc1KyvSL0H5+hZbiZ7cYwFJuixYmTf16h9UCKfvw04TbE6Ca1rDJik38B6HlloQit8ae8Rl7Iz8AntDen/iS+2gQnnC7kXMj4IbP8YogpmH9aEhMuNwF3jLXMmM6JgCWLyDw+ukHesPj1ZcBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR0101MB9006.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:5d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 21:17:07 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%5]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 21:17:07 +0000
Message-ID: <02e2c26c-7fae-40e1-b1a7-3662f879e812@efficios.com>
Date: Mon, 9 Dec 2024 16:17:05 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] Scheduler time slice extension
To: Prakash Sangappa <prakash.sangappa@oracle.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "rostedt@goodmis.org" <rostedt@goodmis.org>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 Daniel Jordan <daniel.m.jordan@oracle.com>
References: <20241113000126.967713-1-prakash.sangappa@oracle.com>
 <20241113185013.GA22571@noisy.programming.kicks-ass.net>
 <f0f681a0-22b4-45f4-85a1-18f140286cbe@efficios.com>
 <896BA407-E19C-4CEB-BF5E-9707543BA365@oracle.com>
 <20241114102834.GM6497@noisy.programming.kicks-ass.net>
 <CF032474-7725-48C1-BA31-A8728C6C06E7@oracle.com>
 <ADA482EF-F2FF-473A-9585-CD5925FA8BC1@oracle.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <ADA482EF-F2FF-473A-9585-CD5925FA8BC1@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0067.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:88::14) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR0101MB9006:EE_
X-MS-Office365-Filtering-Correlation-Id: abbe0203-af95-42f4-a7c4-08dd1896d5f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NFdFZ3lndzFkU0JlOTUveFY1NU44eHd4MkdDS0orMXRrTmJYT2hPbVJIZFBl?=
 =?utf-8?B?aitoTERHNEg5UDdOa2hjelcyTDZISVZncVJVTGVwNDh0eWNnclBVUDZSWVU5?=
 =?utf-8?B?U2x2RDVwQmlOVWdtdFRVMHBnZ2JZY2xicDU4RndxRXViZW92RVhPd2E0Uzh2?=
 =?utf-8?B?aEJKTTdQOER2cVlUQVBudFNnNFBIK3E5MSs0a0drZ0V1d0hLeFkxTUJha1hu?=
 =?utf-8?B?VkZCRXRlSExMNzFGWEx4aEl4eHIvT0JWelZvUTdaT2d4Y3pTeWcvbWRBZ2c2?=
 =?utf-8?B?MmJiWWVXMzBnVXYvTVFVTHJFZ2NKQUVlUmdnT1dQaytMajhrMTdnY0xpY2s2?=
 =?utf-8?B?VXFSMWNPZmxmZVRxTHV4ay95d1g1MWVmTERUZDl4MElMYVNOYzdrQ0F6SUY5?=
 =?utf-8?B?ZVAzeXp3Yzg2MDg0ODh5MERWZnVlQStBK0U4d0NYMU5TK3hwTmpyTGFWeGhP?=
 =?utf-8?B?M2ZjMjNKN2VIMGdIaDBGQUVldnhwcFFsbUpCaFY3NFZVdHd2dm81SFBQQ0g4?=
 =?utf-8?B?NjZ2cEx6WU9tbnNPaVRvVXhXT3VvMEhpK3o2UHJjRjRvWFBkN2FwVk5VQkZL?=
 =?utf-8?B?L0FKdWJBVHdpcmZLQlJMSEtpQmJ0QnE5cEljNTR4UlFpaFhMUXFoS2tjRVV6?=
 =?utf-8?B?MFlhYmc5R2FyWXNacDB2NTl5WmloMXlBUmVtdGRiZHQwTGhuQXowNjVJYmMw?=
 =?utf-8?B?dFljOThWdVpKa0o1anUwd2xXYXdvSmgzNzVBSitNV3hjc2dzcjNuNjRCVDdV?=
 =?utf-8?B?UTQzblJCVEQ0SXFnQS95ZEQzVTFHM09mQTBBcFNNRVJlbHMzckNWa3FzZ0lK?=
 =?utf-8?B?WUJ5bitEdTc5N0tuRUN0QnVNSzJPZzZPekYwbkYvQmJKVlVnZk9BOVFOY3V6?=
 =?utf-8?B?UkhObU9FaG1yM2NKRFVYbzQycTVrVDVaYnNGUzBJczAyYVpWMys5RjdjNXN4?=
 =?utf-8?B?K3BsSElXVktPMUJTc0N6Mm12WjZUN3JnNnlxOFQ2ei9TVkZROC92amFhbEh2?=
 =?utf-8?B?YmJsSVcyb1ZkVmg4emhTSzRiRUE0OG5UZ0VQWWpacTFQU0l0emFONG5aTHFJ?=
 =?utf-8?B?dHVSOGV2WkV5SktCVnRJZ21LYWVvUXo2V1NTR1FYTHlIVWdzNjhDeVl3Y2lM?=
 =?utf-8?B?QzRiaXFHRVozUURuOXZ1Tld5cHVoMVdYS1BYTDkrSmhGWkY0d25uT3hlSzlK?=
 =?utf-8?B?YVd0MGdGNm5ybnluWnczZUF4WEZNQXdTREtxTytSaHVwbGtLckN3Y0k4SDJD?=
 =?utf-8?B?bHNHWnlVSDEvOXZqRGN2K2tQbmF1dGhOaFVhWjlxdVFHOVJ1KzV1T0VhT3Z3?=
 =?utf-8?B?SlZGWTFUdEpwK0ZqUzA3V2J6ZXdqLzhjZklsdFRWUGh0VitoRXJVU1Y0NzZj?=
 =?utf-8?B?V0RrMEpIWHd1MG9HOEhxSTdRbGtETTZkcDBvVzhhQUhITE1xOVNBTFljalhx?=
 =?utf-8?B?M0g5MW50RDlFQ1MvaTdZd2JTQk4rbitQeWcrMFdRNGdzRUZoZUsrM3VSblRi?=
 =?utf-8?B?K0Yyc1BVQzl5emh4V2F5NkVFSVl1akVJeElFUFBiM1BpSkNEMnVoMXF0SlpQ?=
 =?utf-8?B?WDhhdERVMFhBMXRJTllhM2JWM090UmlLK1JRTkUxUW5kYUl4Wk51Z3lJZlAy?=
 =?utf-8?B?UUFTN05seHFvMDJXUDlBVkh4NlNFejkzbzV4VFRMRm02SHZSUUJ2SFpYQ01W?=
 =?utf-8?B?VXBMRnhkeE4yeWlHTGpiVVI2c1krVjZBWDdpdU43M3creEJNRjVhM2V1N3Bv?=
 =?utf-8?Q?sQBEZHd2bsG2sDhjws=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WlFyL1p4Ti90eUVuL2gyd0xFOGhvWnZUNmRTMUNSNDliTGNiZ21UTjBEejNL?=
 =?utf-8?B?WHlDYThrOUhDamxRU2ZGWVo3aFVRMC9qRk81ekFObFExNTlPTmtBV2xlRm1h?=
 =?utf-8?B?MmRFYnNrL3RXNlhWUmhyQUlDY3FCcjJZb3dEMjBsQnRlOGZMYmhTaUtvOUNG?=
 =?utf-8?B?ZUdSdzhQb3VYaVlub1NxaXlnekN4RlRQTU9mK09oZU1lNWxBc2laVHJDU21C?=
 =?utf-8?B?RXMzclFic1c4eENFUmIxcEhESnhHbndNNzJMdkdnQkE1MXFXd2NoSEM4aTM1?=
 =?utf-8?B?bUZMd1RrU0lIYTV6QnNub2dyTWJZbStaN05wdFAvbklpbkxPYjRNY2gxN01F?=
 =?utf-8?B?alhUTnd5RHVSdWJNYzVSNWR6SkFVRkVBbDdZS3pXUG1zRFVxd0lOOUczRitu?=
 =?utf-8?B?SUY2QlR0Uk9Zc0Nwdmk5YlJ4NlQxK2RrQXJ4eVhTeXI2cEFFNk83dUlUV0xw?=
 =?utf-8?B?eDhlUGRKOXJGL2NpQjZvMmxCTlpBZlo1QkNTS0NCemR1NGlteERUWVlNY2RU?=
 =?utf-8?B?YkNIZnB6VHhSWXV3N1RzZ2s2TWhrNmxoODJOSGdCVWJETElRMktjWmN3OSsw?=
 =?utf-8?B?N2ZBZU9GcEJHQmNOVzg2emtvNTJlNG03NDNVbVVSU2tNZkxkaUNyRkxBVkJY?=
 =?utf-8?B?ays4VlYrRmY4b3Z1L2JhdFdmVmZCeG5QSjdxSGk2RU0rc0R2eGk5R0d5b1cw?=
 =?utf-8?B?cStjS0Rsak1oUm9LL1hUWk92NUhEdFZmUWFVVk5WUG55UE8rbzZ3a2lpands?=
 =?utf-8?B?djZabk5CdzlCUlE5ZGpranlmaXpSSVNTVkRham9XU0xtaDh5SHFrWlZDMFZs?=
 =?utf-8?B?cGpBN3VZbk8ycWpGYjk3aUJlYkJ2dWFHNWhHN1Iwc2pBU0hrcDFyMjVvK3ZJ?=
 =?utf-8?B?VTE4Vm1CeHQwYlN2dlgwSVl2UGlFR20xV1RMZ3M5Uk45OEpLQnNPZGl2cmk5?=
 =?utf-8?B?Sjdqa21EcW5DWS9ISXRMekZWTTFtRXJCVGpWYkJVbkhJdFU3WnlubEpxMTh2?=
 =?utf-8?B?cW5qNTdLUDFlbDZyeS9UVmpNU1NGckxsbVkxUG1kZ1E3Wlk1bVE2L0oxMlZ1?=
 =?utf-8?B?UTJ4Sy9BeWpzZG9xdy9GZkxnODh3SjlETkkxT3MrNFR1TVlFN295UHpqT0Rp?=
 =?utf-8?B?RnE3MVhTT3BwK3cyM0VFcHBwenh4UlNuRnJLdG5YWC90ZzNsVjlKSGdURzMz?=
 =?utf-8?B?Uk82QUdMNGR1bU1hcE4ySm9pN2ExV0xWZkFaZVZ1NlJlcEozTW9VZ1dqeVpy?=
 =?utf-8?B?MGJrU3c1NjFPdW1jK2Nkb3dtSjlJa3ozVDZUNzJteWpkb1hIOERzYVFFTnBC?=
 =?utf-8?B?QVBNNkJ0WmdKSkppOHZScmNvS2xzZ2hMZW42UmxHcVVPTjcwMGg4NWdCaW1O?=
 =?utf-8?B?bmE4dmJkOUd0TmF4WkRRN1BuOFJXSDd3c1htZzNiVG50ZDNqTm1xSU5KdTRT?=
 =?utf-8?B?eGd3V1htRlN0N3hLNExlejhrV3NkeFhuZExiK0dad243WTlQSWpjUmVpc2tm?=
 =?utf-8?B?ZWRWRThPeVdmWEpMZkxnZzRaWS9MazlhOFFrVDR6aWNtTzFSK0NKNUgrVEZJ?=
 =?utf-8?B?aVhiZjJyMEtOQ3pBRkpBQ1FHQjg4RVVOMEhCeUdGNWZkMXMzclpUYkFGekJw?=
 =?utf-8?B?RVJ6Ylo1b3FmWHRqT3g1d1JwYTVKTzdNeEJnNUpCYSt3aGxHa2VKWHQvbU0z?=
 =?utf-8?B?QXJVQWlrbkFrVnNNdU54QmxaeEhsVGxRY2ZCVWhtdmlHdXBDS0l4L0Zra0Zp?=
 =?utf-8?B?ejhycXBvZVNHZWJEWDhqV0N5VDhmNDBqQzBwbnpHYzJndzMxQkw4c3VSbXZY?=
 =?utf-8?B?ZHpZeFVVTGRxeTk2MVNVbWN6dXk5ZllpcFY5ODlOTkpsR1JFWEN0bmE2NjhI?=
 =?utf-8?B?U3FJWHEwOXN5akoxdFlEL3NaWXYyLzlhUlM2OGNkbnZqYzBrUlNEM3B4bHJZ?=
 =?utf-8?B?MllUSjlZelR4TFlQWUJ4emM4VkhIRW9jYmk0MTczNE5lb3JVdm1RaURqZVNH?=
 =?utf-8?B?WDA2dkVKRFhyKzdscnVsaGZhNEJCTkdsV2tta3dvckNwSTQyZXdFSTRmVUpG?=
 =?utf-8?B?cmM4SnNzdVBGazZnZWpGRE9KdTNHaU4zZm9IY3hoQ0x0b3VBcHlMZHV3T3V5?=
 =?utf-8?B?dUgxbk8rZUJYRXBuMUZmcHo1OUZveVVUYTNPQ243Uk11cUppZDRXendSSnli?=
 =?utf-8?Q?4cOVNhWuNtyILYeM8QBi4EU=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abbe0203-af95-42f4-a7c4-08dd1896d5f8
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 21:17:07.1565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sEUjRE5mkcG0AgUKdkWtMUkRpsB+AUOeivQI0xDvWbYrN/oIjFOa5dNdCN4cln88OUNXtqP63fp0MP+L1AusOFMLKzDXDc9F1MRZxsajAXg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB9006

On 2024-12-09 15:36, Prakash Sangappa wrote:
> 
> 
>> On Nov 14, 2024, at 11:41 AM, Prakash Sangappa <prakash.sangappa@oracle.com> wrote:
>>
>>
>>
>>> On Nov 14, 2024, at 2:28 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>>>
>>> On Wed, Nov 13, 2024 at 08:10:52PM +0000, Prakash Sangappa wrote:
>>>>
>>>>
>>>>> On Nov 13, 2024, at 11:36 AM, Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
>>>>>
>>>>> On 2024-11-13 13:50, Peter Zijlstra wrote:
>>>>>> On Wed, Nov 13, 2024 at 12:01:22AM +0000, Prakash Sangappa wrote:
>>>>>>> This patch set implements the above mentioned 50us extension time as posted
>>>>>>> by Peter. But instead of using restartable sequences as API to set the flag
>>>>>>> to request the extension, this patch proposes a new API with use of a per
>>>>>>> thread shared structure implementation described below. This shared structure
>>>>>>> is accessible in both users pace and kernel. The user thread will set the
>>>>>>> flag in this shared structure to request execution time extension.
>>>>>> But why -- we already have rseq, glibc uses it by default. Why add yet
>>>>>> another thing?
>>>>>
>>>>> Indeed, what I'm not seeing in this RFC patch series cover letter is an
>>>>> explanation that justifies adding yet another per-thread memory area
>>>>> shared between kernel and userspace when we have extensible rseq
>>>>> already.
>>>>
>>>> It mainly provides pinned memory, can be useful for  future use cases
>>>> where updating user memory in kernel context can be fast or needs to
>>>> avoid pagefaults.
>>>
>>> 'might be useful' it not good enough a justification. Also, I don't
>>> think you actually need this.
>>
>> Will get back with database benchmark results using rseq API for scheduler time extension.
> 
> Sorry about the delay in response.
> 
> Here are the database swingbench numbers   - includes results with use of rseq API.
> 
> Test results:
> =========
> Test system 2 socket AMD Genoa
> 
>   	Swingbench - standard database benchmark
> 		Cached(database files on tmpfs) run, with 1000 clients.
> 
> 		Baseline(Without Sched time extension):  99K SQL exec/sec
> 
> 		With Sched time extension:
> 				Shared structure API use: 		153K SQL exec/sec  (Previously reported)
> 			55% improvement in throughput.
> 
> 				Restartable sequences API use:	147K SQL exec/sec
>   			48% improvement in throughput
> 
> While both show good performance benefit with scheduler time extension,
> there is a 7% difference in throughput between Shared structure & Restartable sequences API.
> Use of shared structure is faster.

Can you share the code for both test cases ? And do you have relevant
perf profile showing where time is spent ?

Thanks,

Mathieu

> 
> 
> 
>>
>>>
>>> See:
>>>
>>> https://lkml.kernel.org/r/20220113233940.3608440-4-posk@google.com
>>>
>>> for a more elaborate scheme.
>>>
>>>>> Peter, was there anything fundamentally wrong with your approach based
>>>>> on rseq ? https://lore.kernel.org/lkml/20231030132949.GA38123@noisy.programming.kicks-ass.net
>>>>>
>>>>> The main thing I wonder is whether loading the rseq delay resched flag
>>>>> on return to userspace is too late in your patch. Also, I'm not sure it is
>>>>> realistic to require that no system calls should be done within time extension
>>>>> slice. If we have this scenario:
>>>>
>>>> I am also not sure if we need to prevent system calls in this scenario.
>>>> Was that restriction mainly because of restartable sequence API implements it?
>>>
>>> No, the whole premise of delaying resched was because people think that
>>> syscalls are too slow. If you do not think this, then you shouldn't be
>>> using this.
>>
>> Agree.
>>
>> Thanks,
>> -Prakash
> 
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


