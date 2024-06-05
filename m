Return-Path: <linux-kernel+bounces-202066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F66D8FC76E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 11:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF8EE1F25335
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 09:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5ECE14BFAE;
	Wed,  5 Jun 2024 09:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="DrkGuHOc";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="DrkGuHOc"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2088.outbound.protection.outlook.com [40.107.249.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8CF49645
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 09:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.88
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717578921; cv=fail; b=UkphtJvqiwd1mFlko2KqoD2rMQ4V7pudSBFv2aSnbrJfiGAp/G/ikwHkVctIiZOxpLNtgSoXhIP5M1wdHJtB4yMnNdGUn6F1/bK8v1YFukTJThj+hu3k1EaegIR/EQiG+6zwgoOZM4/XsvTjV5fi7KfXXGoPGj9LjTu25qnrf9w=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717578921; c=relaxed/simple;
	bh=1Fea4MNBUZnI1QqPgnf0usKyc20GL0jpuGfZoW3OKJE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=APviJ9oRXbkvqkVFNw6oEbMeZJpNIwZuL5VgGNPYKYCw3Ch/Mgvd+bRu4isYfCXd86OmNlXZJzaV5RfQ88MAtrBNl+TxVMGzj4lJebl2i2fDRmnoDHU+HtiQvhMGN1IRgqGIN8VUgMfsqwUziSzC0xpjJ4SSUgFjhsWbfDLAwu4=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=DrkGuHOc; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=DrkGuHOc; arc=fail smtp.client-ip=40.107.249.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=gF4glLPnQ+LkhZdhVsK3WZb3Z20KGVN34sThyU61T9b4yQsD0fkJxafi3oK8VbGaPE2H60iKPbyXthb2F7uxUkTySPm0UXRpMX7iBxAljifP+8EhteSHjZx4Inp9q9gTbRwYx+OM9OC6hco63aTB5+mwo7PV0ACd+WmpBzIHuAkp10BmAwPdNiIGfzW1IW8aTeEsyhmFfWpgv9rQhnTHp/yAlsetb/tdxYEgA//+d3zqStfhxwqcXOejMtC0T1ZUcWHjGH/gWwlzhuqxujqXM5jiu5mHy/byA1n+j64FudrdVc76gWPiKOmrU/Xb00kDsWZx9zuFzKrmm26BOdHYfQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J24h4iGdK2gmb++hGaQmeFdqgb8hYzFHTR1KzTXmgdw=;
 b=eI88n8AMRizNyK4KHD3eiw0vTBsgrHuqz7NmypUcmPSu94qXl4aaQavPjkzhxQ4VIAVCfoPe/zpRhRyduvLGvNrQHKetncEHtbTaZwKegsgPvVDd+UPBZblz27mnkZY0U9knz8qwwVH2WeVIJGDaGYQbUU+Yanr6ooTyPZa26S19EfV/Nx2PLNLpY2MrMuLeMLbd20ZZJYshwGQfxXvTOooA9HbqlyMNr1DwJkAg1fJpIqofPrBKNpCQbIhojmTYblAwQxwcUrrA36AwFscJm8FwMaXZqi8t6ZVxkXoDGCPcGDkBtBY21gcP7lfAv3k51h8wpTIpaYaoAEvZ3Spd+Q==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J24h4iGdK2gmb++hGaQmeFdqgb8hYzFHTR1KzTXmgdw=;
 b=DrkGuHOcdlSwQSpQEF7C+XNShiTKWaLn7GdhekHKpfTHaRLmDs85F5gpR2qqQH2NGUMmiJDJ/heqbWqJMcFagiV1V3htIcfQ2nRLldmL272Giuxoc/PBa9g6XynUFcVuTVWwkOhHUCQzAlpllsFX2RdAaXrfWC1M5+93nvpyR1w=
Received: from AS4P190CA0016.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5d0::10)
 by PAWPR08MB10923.eurprd08.prod.outlook.com (2603:10a6:102:470::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Wed, 5 Jun
 2024 09:15:07 +0000
Received: from AM3PEPF0000A799.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d0:cafe::93) by AS4P190CA0016.outlook.office365.com
 (2603:10a6:20b:5d0::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31 via Frontend
 Transport; Wed, 5 Jun 2024 09:15:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM3PEPF0000A799.mail.protection.outlook.com (10.167.16.104) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7633.15
 via Frontend Transport; Wed, 5 Jun 2024 09:15:06 +0000
Received: ("Tessian outbound d79ebeff6a2c:v327"); Wed, 05 Jun 2024 09:15:06 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 080ce403e1fee024
X-CR-MTA-TID: 64aa7808
Received: from 7856c2d275d8.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id C849D9C1-4E32-45C7-B657-54FCC7DAA84E.1;
	Wed, 05 Jun 2024 09:14:56 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 7856c2d275d8.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 05 Jun 2024 09:14:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j0l5500HyDYV+T4n+xeboDN0Nzx6YRXlFoCGGsW9U3/Xr9OA0JUgcO6/cPkzfXgcRCoKiw3riS4SnL3gmVLXCcH541nnoE2gPXk2oDg4S24ZFNhQD5ckiA1OWJI4GGQozSSCMAdQY+FcEp5xqoD8jI28LpvzGMun7FGmKgbwew6GDe1NJXY2An6VrsLyrtDUAeBZi6AvcC6jVHPyZn6d3dZhukiBG6VOw82NQFTv5yC+Q0DiZd4zUyiMog3zxtD5/VKMpScVnkAo929ZmV4zGKRyv4WU9/2eaeKotBrjjWfJnaodl5LXSsykZj47vF5rMw2sbeT3FH+Z8er6UVL5tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J24h4iGdK2gmb++hGaQmeFdqgb8hYzFHTR1KzTXmgdw=;
 b=DBWNk+zSAdpHaCkxdCWH1MzBVdjuLw8AFmoNlnKyeTcQvYy9B8LoiFoFoSFdDdvSXWgkT2bfhKf0L6sg+ybVEpdZHAs/wTmIu6iwuhfxoEPPr4Z1rDXpiw3P0XFHbqLCy/TvH5yRAOl63NpQcNHoj8CrPa6czI6ps1HqOwKAAkzKiNJshyTfxa6sQYgRex9QL31wJ89bV00bvzAjOgTau09s8oKbYK8OxpabPhj33oqu9UasQkxmck7b/hGsaJoPRPcSl5HKuxwL9EyUXs44lsZWGF+A2K0J9TxsB3r4RhrInVycp5UskYBPj/9N5za3imXgSvauUVo6DGj7P7R6iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J24h4iGdK2gmb++hGaQmeFdqgb8hYzFHTR1KzTXmgdw=;
 b=DrkGuHOcdlSwQSpQEF7C+XNShiTKWaLn7GdhekHKpfTHaRLmDs85F5gpR2qqQH2NGUMmiJDJ/heqbWqJMcFagiV1V3htIcfQ2nRLldmL272Giuxoc/PBa9g6XynUFcVuTVWwkOhHUCQzAlpllsFX2RdAaXrfWC1M5+93nvpyR1w=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI1PR08MB3919.eurprd08.prod.outlook.com (2603:10a6:803:c4::31)
 by AS2PR08MB8645.eurprd08.prod.outlook.com (2603:10a6:20b:55c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.26; Wed, 5 Jun
 2024 09:14:52 +0000
Received: from VI1PR08MB3919.eurprd08.prod.outlook.com
 ([fe80::14e2:874a:b20b:78e5]) by VI1PR08MB3919.eurprd08.prod.outlook.com
 ([fe80::14e2:874a:b20b:78e5%4]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 09:14:52 +0000
Message-ID: <7b26df23-4977-4fad-8721-137a23932b6e@arm.com>
Date: Wed, 5 Jun 2024 10:14:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH 08/10] sched/fair: Implement delayed dequeue
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
 linux-kernel@vger.kernel.org, kprateek.nayak@amd.com,
 wuyun.abel@bytedance.com, tglx@linutronix.de, efault@gmx.de,
 John Stultz <jstultz@google.com>, Hongyan.Xia2@arm.com
References: <20240425104220.GE21980@noisy.programming.kicks-ass.net>
 <20240425114949.GH12673@noisy.programming.kicks-ass.net>
 <20240426093241.GI12673@noisy.programming.kicks-ass.net>
 <c6152855-ef92-4c24-a3f5-64d4256b6789@arm.com>
 <2fba04b0-e55e-41f4-8b7a-723734fe1ad2@arm.com>
 <20240529225036.GN40213@noisy.programming.kicks-ass.net>
 <7eac0774-0f9d-487c-97b6-ab0e85f0ae3a@arm.com>
 <20240604101107.GO26599@noisy.programming.kicks-ass.net>
 <24e09046-74ee-4ebb-ac1a-bdc84568e825@arm.com>
 <20240604191220.GP40213@noisy.programming.kicks-ass.net>
 <20240605072225.GR12673@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Luis Machado <luis.machado@arm.com>
In-Reply-To: <20240605072225.GR12673@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0698.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::11) To VI1PR08MB3919.eurprd08.prod.outlook.com
 (2603:10a6:803:c4::31)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI1PR08MB3919:EE_|AS2PR08MB8645:EE_|AM3PEPF0000A799:EE_|PAWPR08MB10923:EE_
X-MS-Office365-Filtering-Correlation-Id: e0273df1-be40-43e7-72fa-08dc853ffde7
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?Q3A2TktFaEkvTi9KbE85QkRoYW1FbW80enV3cjNxbGJlWU45T0F4MFhrTWRm?=
 =?utf-8?B?RHdleWQyYUxsM1VvWlBNVDdwSUZwSjdNUnVUYWc2NHNkaEM4eWtVUjZwMWtp?=
 =?utf-8?B?YTQ1KytFWGd6RmR0b0ZUdUtZOHo3TUxmVm5wSHJaRStXNy9XV2FZVUFSV3VQ?=
 =?utf-8?B?WEpaVDRUZHFWZ29jdUZ5NlNuR3owc1Z1ekJHYjZ2VUFiT2ZpMDRBaVZraEIz?=
 =?utf-8?B?MFl2Y20zc3ZwNzlWM0ZxQWdWL3J3ak95V3kwSzBIdG8rUThHNC9MbmZwcVp5?=
 =?utf-8?B?c2UxMzc2K0l6aWV2OUxhdnhGMmZsY1MraHNHMHhOWk94ak4vSit3aEZHVXg4?=
 =?utf-8?B?QnAwT01KRHpBRk5RTDJ6NHgzVlExaHpINlQySGlhVlpUZE9uZ0pTK1oyZUZ1?=
 =?utf-8?B?Umo1WWI5c280a1VxUSs5OUNwVm5iSUwrSkdCWU1EcUtocGVPSUxFWUZxOWhE?=
 =?utf-8?B?R2l6aUxRSnhNZmk1UjQwdG5SbVh6TU5zZ0REN0xKeWJxVXI1eS93MHcyc21i?=
 =?utf-8?B?aVo1aVg2SlBaendyTzZQdWQzdkFEd05oT0Z6MHNWZjdqSllaUEFEWk5QUURT?=
 =?utf-8?B?c1pZQWZxell4OE5RdXRtUFBzODh6eGtQS25pTnNvd29LZzZ6MDFzSmlCQ0dE?=
 =?utf-8?B?V3dld2Q0NEhQTEJWWldacUQrK0w3TWhQYVgrRkxRa21aSkhWWGEvVUFNYjVJ?=
 =?utf-8?B?NlFBc3djT20ydXV6U1h4SVR2dmdvZkNiTlhHbEtGcEJMZ2RGczhXL1N4MWw2?=
 =?utf-8?B?OWJkTW5qUWFFUWlZRFFhMDlpQVNOb3ZiQlROOEtndkMzSEk1RFJ0dndXZlky?=
 =?utf-8?B?WEt5N1RZS29xN2laaTRWcmo1cU5uZjFnVVY4VnZ3Vno0UnFOM3gyei9HQmUw?=
 =?utf-8?B?S0JtN3BCbnl6b056WDBJcC9KUlNsRk5Mc2NkR2tpcWw1dDhXeDlmOHNYN1I2?=
 =?utf-8?B?WVBYWTZleHdaZmZLeUhVN3pUU09lcmp3c2diS3lkTlBBaTZjSllxNE1IUEw1?=
 =?utf-8?B?YjJlRm5PbEY3VXRiUWgybnBTQTBmdExCbU5FTmxpbGlpMWYxVWcxc2xjdENm?=
 =?utf-8?B?MmFuazNzRUFydFYvMmliZEdUcUJaNEJLWEsydkZmNllvZTc0R0x1TVJ3NzVn?=
 =?utf-8?B?a211N2xFeUZHY0poMmFwTWVDcUJRbVQxVVdKWmhTd0E2Qnc2aW5OWnQrSFk1?=
 =?utf-8?B?QjIzRGM2Wk56RU82bEhHRGVmeVNJVEQwSmNIcEZlcEpCcjMwMlNvTThSN245?=
 =?utf-8?B?VnpUL2JEc1RMU2tkUG9xakhGNGhmVExKdUtYK1NDOUVGOFJGMWpOUUVDMnFV?=
 =?utf-8?B?ekM4OFRzRFI3Z3RuNjRWVTVYeWVNcGdCT3dBUitzNDV1eE1FUEY4Uk9XYlVh?=
 =?utf-8?B?aHQxYndyNGE5bGtTRmVtcW9DN0FSQ2pNQjB5dTdHYjJ4UTR1QzdxcjZWUzJr?=
 =?utf-8?B?b0RUZXU1eDcrZTZMaHNMSktNSkxaQ2lrMUM5TEtCcm5TSyttdTRJSVlhdVYx?=
 =?utf-8?B?eFlQUzdOUkNqMFczNTk0OWlyRnBuOUdzQnFDZW51V01XZWFaV2lhbGo1Tnoz?=
 =?utf-8?B?b3lQYzV4eEMzMzYrTWttT29IRElEc2hPVGFHVHdObFpYRXJGRHYxNS9Tejhy?=
 =?utf-8?B?UlNmQVo1WGp1UmFiZnpxd0poSjhBK0hLMm15YWNCSi8vSXR5cTBJcGFvR0NN?=
 =?utf-8?B?WWFLQkxja0tCVHlsY2luL3VFU1o4L0dLdzJPUVRYeTN1L2ViaDYzeEVuMkdV?=
 =?utf-8?Q?MF6S06OIFsdo1Se6foJFn0w/mtkCUl5qFgeXKJO?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB3919.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8645
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF0000A799.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	d2dca5a3-62c2-4ffd-f314-08dc853ff526
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|82310400017|1800799015|35042699013|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SkxzSTFmTWNaMHRBMnFHd1prcWpQamVlTVVqK29xWEptUzhIZmVZM3g2K2lr?=
 =?utf-8?B?anIwKzJabVJHOE1mK05UTHlwZ016bGFMdGJJQXQzYy9mOWNJUitUS2Q1ZXZO?=
 =?utf-8?B?SncvMFdFQ21UTCtUZVp1aTBRN1dhQitEeUgzUkZhaXpHUDVKT1pGbVNTS1B3?=
 =?utf-8?B?UlM1aEE5cmJJOG12NWUxVVpPcGdCWUxtaU5lcmhhWGVvdlNGUnpGQlNCclRj?=
 =?utf-8?B?YXQ3aTRhYUJYRDhOM1pQcTlST21RLy9QQjN2NlhPNXpiQ3lVRHljdldJUEVT?=
 =?utf-8?B?bFVUT1c2QnVybExBRTBIKzNiWkxoUk90SFFDd0lsQm9UMEFuUEUwVU9tT1Ur?=
 =?utf-8?B?YTJHcytMTVVIWjJmTlZaREY2dlBid3psN0NwRWNEQ2thdm85Rkp0U0xaWWY0?=
 =?utf-8?B?eXJZTXd4M3pGRXFPTTdpb2xVS3NMdTM5S2hObS9NUkJ3OUd3R25VQUR3bHlw?=
 =?utf-8?B?WVdybVBPQ3R3UHJ3ekJFekZUa3VZVnd2eWp3ZnRCR2dpb2R6K0lBYWYydFlY?=
 =?utf-8?B?OW1FOHdjTXIxbGVBazMwcnVrS1h0YVBkdTA2MTNmc1Bnd29iTjIvL0g3ODh3?=
 =?utf-8?B?RXY0UnpQeVhqSElhbWJNV0ZtUkF1bEplQzBJTEU2eDRCODhKbG96OFZPdUUx?=
 =?utf-8?B?NnlHR2Z5eG1wT3pZVW1kbUVpaDlCTVhLNWc3Ukk2QzVtUEpxWThLTzl2V0RV?=
 =?utf-8?B?Z3YxWjhuWnc0SUx4VUlBeEF4cCtkMW9pU2tvRGV4YlhqK0l2eGdEQTI1aDha?=
 =?utf-8?B?RzlkSjZINFZwVk90b1ZtN0g2RlFacUI3ckMwd2R5YjRWMDJrVG44elVxTlRn?=
 =?utf-8?B?NFlDSllkeGtpS2ZGd2ZDLzMyOUt1T1BiRjVZYVNqVm5FaDVvN0FOZFVNOUhr?=
 =?utf-8?B?VlRldkR2SWtlUjlNR01XVmgyUHJxRktyV3JnTkVlZ1hvcmF0M0Q5ZktUVGZP?=
 =?utf-8?B?N2dxVklJanVWYUUzUmk0aTZoWWp1TDZQUjlYVFVwTDdmTGRxYTVFaysxNCs4?=
 =?utf-8?B?MS8zbEhuZ3ZOd1hyNXRLbWVLOWNMUHBoUDFET2lYWDdnRWRtUHorU05zbHAv?=
 =?utf-8?B?MGVYemtxU2NycEtuQkdTSFlneG1TK0FLaGFoNmFOdkdGQW8wc0RkTFhIcit2?=
 =?utf-8?B?L2NkQUoweFh6L3dvSGNIQTNVSEtLb3hRU2U4TzR6Zm5uZDVSNzNYLzNaTVU0?=
 =?utf-8?B?OHVzeVc5dW9YKzk4L29wOERpeE9sM1F2Y2F6VjhxSWxyK2Eyc29BY2Y4V2d3?=
 =?utf-8?B?WmVDakErWm41QURhVHVySmo0M2ZIMGVvMHpESGY2T29SWklOUDhBWngvN0hT?=
 =?utf-8?B?VlczaWVTaEZiYi9KSFd6UkVuRjZLN2E3M1c4RlQxS1FRUVgrbktXcHlvdTY3?=
 =?utf-8?B?cEtBZzNOcGZYUVQxNHVZYzg3b1l3ZzdBa2M3eGE2d0N2TFpubDhDaG84WHNn?=
 =?utf-8?B?YkFFYXRsY0hOdUlBYkYwQ0lsMG51Zm8zamQzNE9sRm9LL0c4MjhXcXVUblU4?=
 =?utf-8?B?eFgydUdjaW9XQ0lzNVZkOGpXU2FKeGczZmJvZk1Tb1N6dkRyblBQU2ZMTUh0?=
 =?utf-8?B?dUJYK2FmdVVEcEEyM0V3TXo0ZWovNVpsREhuV0dTajdIL1VDZWJzbkFpa1Rs?=
 =?utf-8?B?dVBzM1Foc2xkQzNWQ1BMaE40TTlYdUlnWG1KMGtraTR2YmJFS2J2dW1PS0Uy?=
 =?utf-8?B?MVRMOU9ac1NTVERJMW4ySWVPbXdKNHZYOGIvejdQekNWTkp4cFErb2tRcnVF?=
 =?utf-8?B?S3oyazRNc21kUS9HOWQ3dHNFVEFrTXMzNDhmdmZHWkcwSk1tUG9oa0FYSVAw?=
 =?utf-8?B?UXVGbmdJZUs1M2xBYk5hY25Ic2xaZ3p6K1l1REFoM1lDZXZ0VFp0aUZCbW5W?=
 =?utf-8?B?M1FhSXlqMVBEQzdRMXY1R0JnR0tCYWsvYmYvV2J1QldXWXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(376005)(82310400017)(1800799015)(35042699013)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 09:15:06.8224
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0273df1-be40-43e7-72fa-08dc853ffde7
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB10923

On 6/5/24 08:22, Peter Zijlstra wrote:
> On Tue, Jun 04, 2024 at 09:12:20PM +0200, Peter Zijlstra wrote:
> 
>> But with the above, you skip inc for sched_delayed, but dequeue_task()
>> will have done the dec, so isn't it then still unbalanced?
>>
>> Oh well, I'll go stare at this in tomorrow.

It did not appear to keep things unbalanced towards uclamp_rq_dec, but
might've been luck of not hitting the right code path.

In any case ...

> 
> OK, just before I went to play in my giant hamster wheel it hit me.
> 
> When dequeue_task() 'fails' and sets sched_delayed, we'll have done
> uclamp_rq_dec().
> 
> Then, since the delayed task is still on the rq -- per the failure -- it
> can be migrated, this will again do dequeue_task() which will *agian* do
> a uclamp_rq_dec().
> 
> So now we have a double dequeue -- *FAIL*.
> 
> Worse, the migration will then do an enqueue_task() on the new rq
> causing uclamp_rq_inc(). If you then get a ttwu() / ENQUEUE_DELAYED, you
> can tickle yet another uclamp_rq_inc() for another fail.
> 
> Something like the below avoids uclamp_rq_{inc,dec}() when
> ->sched_delayed, and moves it post class->enqueue_task() such that for
> the ENQUEUE_DELAYED case, we *will* do the inc after ->sched_delayed
> gets cleared.
> 
> Hmm?
> 
> ---
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 9ac1054c2a4bb..965e6464e68e9 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1676,6 +1676,9 @@ static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
>  	if (unlikely(!p->sched_class->uclamp_enabled))
>  		return;
>  
> +	if (p->se.sched_delayed)
> +		return;
> +
>  	for_each_clamp_id(clamp_id)
>  		uclamp_rq_inc_id(rq, p, clamp_id);
>  
> @@ -1700,6 +1703,9 @@ static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p)
>  	if (unlikely(!p->sched_class->uclamp_enabled))
>  		return;
>  
> +	if (p->se.sched_delayed)
> +		return;
> +
>  	for_each_clamp_id(clamp_id)
>  		uclamp_rq_dec_id(rq, p, clamp_id);
>  }
> @@ -1979,9 +1985,10 @@ void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
>  		psi_enqueue(p, (flags & ENQUEUE_WAKEUP) && !(flags & ENQUEUE_MIGRATED));
>  	}
>  
> -	uclamp_rq_inc(rq, p);
>  	p->sched_class->enqueue_task(rq, p, flags);
>  
> +	uclamp_rq_inc(rq, p);
> +
>  	if (sched_core_enabled(rq))
>  		sched_core_enqueue(rq, p);
>  }
> @@ -2003,6 +2010,7 @@ bool dequeue_task(struct rq *rq, struct task_struct *p, int flags)
>  	}
>  
>  	uclamp_rq_dec(rq, p);
> +
>  	return p->sched_class->dequeue_task(rq, p, flags);
>  }
>  

... thanks for the patch! The above seems to do it for me. I can see
more reasonable energy use with the eevdf-complete series. Still a
bit higher. Might be noise, we'll see.

I'll go stare at it and run some more tests on our end with this fix
applied on top and will report back.




