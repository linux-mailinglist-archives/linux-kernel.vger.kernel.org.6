Return-Path: <linux-kernel+bounces-322958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D309735E3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 13:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCE57286019
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 11:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955BC18801F;
	Tue, 10 Sep 2024 11:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="poGfKFxS";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="poGfKFxS"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2077.outbound.protection.outlook.com [40.107.21.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0D514D431
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 11:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.77
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725966283; cv=fail; b=S7pkiCUJ+lJC9Jv92MfRs8R+tKcK2gNv8OybD2AdDVF0DnAk2jV7bH395Zzqhf4/QbibEapdPEhggmvuEIfQnCkh1uhnCucf7Y2Fvur1w3Zzcl6VN6BHcjyGb4buMmK7ck9xZ6wi9Adwi8SK4f+HGjIheCQMUWeFu+Za1AN+B4o=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725966283; c=relaxed/simple;
	bh=9f347/oGodIGfZMpMQuZryT05U6AJ6Oih+DPSx+xdeQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IfrViinXydseYAQrZu5E/dTU+ssj5XLIPKxtsWSaeKXKuGuNSnFc+4/1qOb59jVW/NEO7xN91+GD3sHfU32aId4wDVMg3ZdJZKzQKfoXIINTRHN6OXyluNoZon3HZJbeALATUrK70SkspVq4fyHxTHsw2yPPBKFiXyt5eM2HfMc=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=poGfKFxS; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=poGfKFxS; arc=fail smtp.client-ip=40.107.21.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=LlVHpQwLr+QmAr7dxwafcXy0Jr6rHZPkz8i9+QlQEUUxZZbB5S3VhcKM0zCjuD2xGqfkkwje8qIE3/wo/H1FuaUTZFXYK5tMQFDi8xGSeNx/8PxLqwW7tYnKZEL8MoUHkZWNXyUxI8HcHhjTKqDu7FANMmwr0DZa9OKzpKiCr7O+k02KIatgE3mXyT18OxR71Y2dG5bKWX6Mi3Fy/3JK3nI657+Z0oTppc4sv7EWrmbYaIcTR0mH0bocWt3NVWFij5qWulhWTDiVpxmVMyz92LZHcRL1PPn/FztpjQ+SfDMh7hxarXxiWFdvTrMcj/hHer+PQbZpXgnAzVn23fTjbA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N7Ypbgwf5JwOKOLz9BCy1bZL2FWDgMlCTxoKox7SSKI=;
 b=APgTR5jvznbxbt20D8AaT1jZ+zsxpKvUbrwl0OquHNlXRCgOysyKKo3zilhrKEeRGvtTUc4g7UAJoiB9wYd4cRxp6aOwmAO8jymVQQFCxxoVpV49jJogGbgTgOqBTf45fjmSZ1+GpTqRLGg5dmHhIfPs0mSl5HAmD1T75QYY1caRilif2Lle4pTn+f/khLb9jOSlIb8AcBt86oaIbLvKmkeI23pTC7Jm9pv1k1YZfpzeedunV5gk3mf1W3W/1jA09pWvESdRDqgqTSnh/VZwXdS/mrmAh2cm+GMHUpNQnSDrX4QYk+zT0rpOehy6nPbEPtK7ZkZrogouxUUsf3KHOg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7Ypbgwf5JwOKOLz9BCy1bZL2FWDgMlCTxoKox7SSKI=;
 b=poGfKFxS8w0tk8ubkQPCM1rquDXhNE7cfPznC2bTbcmdTAVog323Uo8ZruWcUTLD575726VKIPj0vcvAZitaDz6J18Txhxk+JY1ztsHvf+yyNe9+VVN2mWgf0qw6ehQnXAKaLfbnnbyN1RmlefIxQ/NxbHN7qnIeaGwtsBv4m24=
Received: from AM6P191CA0062.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:7f::39)
 by PAXPR08MB6733.eurprd08.prod.outlook.com (2603:10a6:102:15e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.16; Tue, 10 Sep
 2024 11:04:30 +0000
Received: from AM2PEPF0001C70F.eurprd05.prod.outlook.com
 (2603:10a6:209:7f:cafe::a4) by AM6P191CA0062.outlook.office365.com
 (2603:10a6:209:7f::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Tue, 10 Sep 2024 11:04:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM2PEPF0001C70F.mail.protection.outlook.com (10.167.16.203) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7918.13
 via Frontend Transport; Tue, 10 Sep 2024 11:04:29 +0000
Received: ("Tessian outbound 7047db86dc93:v441"); Tue, 10 Sep 2024 11:04:29 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: ea56e849ea7b3b04
X-CR-MTA-TID: 64aa7808
Received: from Ldea07f9b38cd.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id E820B01A-1A86-4CCC-A863-4CCBF9270E1F.1;
	Tue, 10 Sep 2024 11:04:21 +0000
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Ldea07f9b38cd.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 10 Sep 2024 11:04:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UKoRhR4O2iSUjsHwyFe1Vqnsk41pGHJJc6GmVGLB/wtUiPqBSp1dZ+4fkRucNf2H5lpRd1woVaca20VW7lrlk6m7LYyuMoqwApm9Q619RY8D/XHsK7szf8JD6CQh4f90Vo55ML9N2zqXBjp5knng2p5ugG3kumYzk8zjrS9z3q4oVoy1FTj0wtjpuyAQBcQbtN7ydYqOyXmMFN/Irlzul6q5BxlRVYJrPs9YWBVZTx7Mnr6cinybdBDPZf/j8xF7z4wnj5ZXE39fmpodHlte9ksB9UdzExeeIlrMSvBC7tALgjfI4LEmE6oU05M7sh0+qz2dqVGzZRkWr49aCg9isQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N7Ypbgwf5JwOKOLz9BCy1bZL2FWDgMlCTxoKox7SSKI=;
 b=unyrjN97ybQxRhzDQfr0basuPXAOyMHFM4R4RwexAsC0R+btmlfQt8ZE7bAoJ0f0UubOdj4bbJIOldJZC3c4DuDA1G3kCiJMtI4fjkWC2uJQQ7VDSaQ1WsXkRhq2B0/ZYoxn3zqqfoN0vVNGXKgZDnZ/ia24D4fdkYxKqQaNlcxjusigzU2zvZuQ1DIJcNhsD2dfDE1VhauKrHUPjMhuOuchPEG9BodLlVWCEoagAoSl5sSGsXkS8UaQUlH0Wil31XqK2J1ipTGR5+fuPnwJNjUkS8DqVsqSQkekc6t1W8YY/NlCAc3LAQW1dyI/mC+wz6jAOhWwJsVHRmkuat1pbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7Ypbgwf5JwOKOLz9BCy1bZL2FWDgMlCTxoKox7SSKI=;
 b=poGfKFxS8w0tk8ubkQPCM1rquDXhNE7cfPznC2bTbcmdTAVog323Uo8ZruWcUTLD575726VKIPj0vcvAZitaDz6J18Txhxk+JY1ztsHvf+yyNe9+VVN2mWgf0qw6ehQnXAKaLfbnnbyN1RmlefIxQ/NxbHN7qnIeaGwtsBv4m24=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PR3PR08MB5852.eurprd08.prod.outlook.com (2603:10a6:102:8e::21)
 by GV2PR08MB8365.eurprd08.prod.outlook.com (2603:10a6:150:bd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.15; Tue, 10 Sep
 2024 11:04:14 +0000
Received: from PR3PR08MB5852.eurprd08.prod.outlook.com
 ([fe80::f44:d113:1c29:825d]) by PR3PR08MB5852.eurprd08.prod.outlook.com
 ([fe80::f44:d113:1c29:825d%3]) with mapi id 15.20.7939.010; Tue, 10 Sep 2024
 11:04:14 +0000
Message-ID: <8d0d01b9-a430-49cc-93a5-67b4d68aa35c@arm.com>
Date: Tue, 10 Sep 2024 12:04:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/24] sched/uclamg: Handle delayed dequeue
Content-Language: en-US
To: Peter Zijlstra <peterz@infradead.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 Hongyan Xia <hongyan.xia2@arm.com>, mingo@redhat.com, juri.lelli@redhat.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, linux-kernel@vger.kernel.org, kprateek.nayak@amd.com,
 wuyun.abel@bytedance.com, youssefesmat@chromium.org, tglx@linutronix.de,
 efault@gmx.de
References: <CAKfTPtCEUZxV9zMpguf7RKs6njLsJJUmz8WadyS4ryr+Fqca1Q@mail.gmail.com>
 <83a20d85-de7a-4fe6-8cd8-5a96d822eb6b@arm.com>
 <629937b1-6f97-41d1-aa4f-7349c2ffa29d@arm.com>
 <CAKfTPtBPK8ovttHDQjfuwve63PK_pNH4WMznEHWoXQ=2vGhKQQ@mail.gmail.com>
 <CAKfTPtDO3n-4mcr2Sk-uu0ZS5xQnagdicQmaBh-CyrndPLM8eQ@mail.gmail.com>
 <aa81d37e-ad9c-42c6-a104-fe8496c5d907@arm.com>
 <c49ef5fe-a909-43f1-b02f-a765ab9cedbf@arm.com>
 <CAKfTPtCNUvWE_GX5LyvTF-WdxUT=ZgvZZv-4t=eWntg5uOFqiQ@mail.gmail.com>
 <a9a45193-d0c6-4ba2-a822-464ad30b550e@arm.com>
 <20240905145354.GP4723@noisy.programming.kicks-ass.net>
 <20240906104525.GG4928@noisy.programming.kicks-ass.net>
From: Luis Machado <luis.machado@arm.com>
In-Reply-To: <20240906104525.GG4928@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0143.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::22) To PR3PR08MB5852.eurprd08.prod.outlook.com
 (2603:10a6:102:8e::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PR3PR08MB5852:EE_|GV2PR08MB8365:EE_|AM2PEPF0001C70F:EE_|PAXPR08MB6733:EE_
X-MS-Office365-Filtering-Correlation-Id: fbd89e85-989d-48fc-e379-08dcd18857ca
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?bGNLaFJGZkxMTnNoMUl1dC8rSHlBaWZHMUdSU25BOEUzeTJaWGluV0ZyVUR5?=
 =?utf-8?B?TENDaWxVNGRoS05yd0NOaEszRXlXUHZPendLdWFiYUFoUXdlVE1tWTgyTG52?=
 =?utf-8?B?dlpzV3Ayd1dlUzQ2QVk2UjdaalFjV25iT0lPTU45Q0pob0ZrN2M0b211VFBD?=
 =?utf-8?B?VUhCZmlwYUxxQ0F0YzgrS2QybGRvcXVvbldMOXovVU95YkhmVWM4Qkw2YW1j?=
 =?utf-8?B?c0JpWGdaVjRLVlpFeit5YW1DRFBKSHd6dEF3bDRvRUVhSjA0Z0pWc2sxN2l3?=
 =?utf-8?B?MUd1SXh3RVFxeXVPZGlhajk5V1d4dk1nWGNXdExKODFjVEh6Z2tnRXJyUlQ5?=
 =?utf-8?B?OXQrR0RjRXpxeElsbFNHelZtcDRGdWs3SkFObWRkNC81L2x4N1hHMWF5Tjh2?=
 =?utf-8?B?L3djNXlid3V1K2JCNEZlSTcxcGJVWjl0dmNHN1FpRVVEL3RMNGlxT0pKMnRa?=
 =?utf-8?B?Vk1MSW9rMU1iOEF1Z3l1Z3Evc0UzUVkrL0l3UWxlK0JUbzFYTzdCOHBEWWpG?=
 =?utf-8?B?RWd1ZitreE55Y2FHWUQzR083ck5yZ2YzZHBMeDFqNGJBSllrNlFxZUFxamZu?=
 =?utf-8?B?enNIckJsL0lscEtiQ2NxdmtuMmZOenUvd1ZMbm5wMnZkZnlsc0lZRkFtZnFq?=
 =?utf-8?B?OXNQcmpqaUJkQnpKVGs0c1Arclk4RCtWeklad3FweThOcklEdzBSTFFBTkZ1?=
 =?utf-8?B?aG1XR1h5SHZUcXNtY1JCeFF2bHIzb0JZbWpuVTc4VzgrdXFDbFJyNU5LamFM?=
 =?utf-8?B?cVJqU2N4RUM3bHB1djhoWkk1S2pzT3ZzdEF5NVk0YlQ4TW15TE5Zb1N6Qk1s?=
 =?utf-8?B?aFpqNVJpbFpBTUgrc2cxczRKWnE4SkUzbHdVajRMd0tWYWY1SXQweE9wV3Rk?=
 =?utf-8?B?ZFR1allzWFBMOG9tdEZJYVBTbll0NSs4MTRGZFlDTGs4Z3d0aCtLUWVLOTF0?=
 =?utf-8?B?ZmhuOU45S1J5SjRqUlBFTXNjc055VFhrdnBia2RYS05nQkQzYXBuaUx5Qm83?=
 =?utf-8?B?L1JGU1k0T1IzbC8yZ3FSOW5VK0NHUnJQRXpJWUJpL3BjK3poL0FwVWhxcUMv?=
 =?utf-8?B?eGRRR3ROT0lJNUp0SmVRbEUvY1d2ZUU1SHFYaHI4ZCtKSmM1MWRSMWZuRFJB?=
 =?utf-8?B?YTh5YlowdnhhOWVNVjF1WmhzWXFNeTJPdkRDaERDa3J6ejBrbE14R2lEMENB?=
 =?utf-8?B?ZmdlZVY3cVEzVjRYM3RrTjBqWkVPaFhlUVc2Rzk1YWpadHpMbVRFL0FoUEtN?=
 =?utf-8?B?bzFQNy9CWFdCdDFkNjNhc3htUmlXcnRMTWl5KzJYbkhQQkovdi9HOThydWxG?=
 =?utf-8?B?aFVscncyV1A1Sms5dEVKaUFWVUdGcVQ2NkVyN2hERUtFTk0yMkF6cHgzc0Zi?=
 =?utf-8?B?MWh6UktHOXVRMUM5SmliSkRxZ1JWSGVET0pmaFozV3VRbEZSZE1NVjN5Qmph?=
 =?utf-8?B?MWxkMVZZc2VzTXdyakdWR29XUjN1YVFqbVh3dHhnTEhRSnVoMHlVZXdiUlNX?=
 =?utf-8?B?MkV1bGE2VWQyTXJwSEpYcldxcU45OElKejMzVVloQld2MmdHQjU1SmZMbmp5?=
 =?utf-8?B?RWJBR3lwWC9KRDcyRW9NeXo2bHF5NVdBbUJZSFVvcG96cUhXa3hXdHlNcmtl?=
 =?utf-8?B?b1lzQ0NIM25GS2tQVDd2dXRidFNvSmtSMHVwUmV4Kys3QWt0Q3lSanFDQXNZ?=
 =?utf-8?B?TEhaMW9TY2szQnBRb3doY2pqUDgxNDdIcTUvSUVNdFdSLzIxU01Ob3pIdTlN?=
 =?utf-8?B?a1Z3V290dWMyS1FyMHNUOStseHVua21iRmVtYndCZlBIRmRPQXNHLzdLK3h6?=
 =?utf-8?B?MDBRMTUyRXFDNy9yMkQwQT09?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR08MB5852.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8365
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:102:8e::21];domain=PR3PR08MB5852.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM2PEPF0001C70F.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	336e8ccb-fc9f-4d8c-3c15-08dcd1884e46
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|35042699022|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dSsxV3JCOTRpTnJWTnFEckkzK2orM1RoUEJDUkhDRGRFaVhnbkpRNVlLbmxL?=
 =?utf-8?B?YjZ5aFRoWWZPU29CdHgzTGM4cW5hYUlxUkJQUmZHKzQ5d2ZWdFdlUThSZk9Y?=
 =?utf-8?B?ZThhNC8wK3B1bGx4MUNjNE5PNEI0ZlRGcmNPaGtQRkxQZ2loZk9XQmpiRnp2?=
 =?utf-8?B?RHdGZG90SmYwTGZXcVIvd0U0YW9EUGRJM3A0anlDNURsRU5DaVdoK1FhSHBk?=
 =?utf-8?B?eXBoeXFENW5QNFdNT2JCNll6UEtUckFiMi8xb1krNEFRbnZlVUJ2aFBXMTJN?=
 =?utf-8?B?a04yN01zV2hidmNBTTdEeTg2aFNwNjc3cnNmRTBmYW1UaGZ1RXZwU2ZZNzJM?=
 =?utf-8?B?ekJlS3FsckxZeU9qQVg4SmpEN3d5ZFZPOHdPS0xUekhUallpOUlnM0VHZkQv?=
 =?utf-8?B?b0xQcHoxWHovT0xNeWEwOWE0WG5RMk5yVXZ2Q0hqRVZJRmRSVkowZnFsZDdS?=
 =?utf-8?B?S3h6eEk2S1E3dlg2dGx2QStCWFE3VGRhUEk3L0hsam44UE9qWXNQRlVDUzJK?=
 =?utf-8?B?SXpDeGFqWDM4UGRLYTBPWUF6eUpVN0MxM1hQSFp4ay9BblFEV1pTWEVBK1c1?=
 =?utf-8?B?aVpWd0h0a3NsVHB2d3NpSGxmOHA0OUNkVHY4UGpQaDZpOWFtaWJlenlHWllv?=
 =?utf-8?B?VmloUDFjYkphMnM2L0tqMEVwNWR3MktUa2hNTmp1dWlFM3hwSzJ0RldObSsz?=
 =?utf-8?B?OERPQTBLVFp2TVFSaEk5RkxVUUlNL1BvYzRXMmlBelVhb29iQ3FCTVFHcXBK?=
 =?utf-8?B?a2NzbWNhQXlmL3VFdndlYktRMnlWR2hGcWQ0bXFOeDZBR0JXVDJJcjNrWGdt?=
 =?utf-8?B?YkZNMkhsTEU3Vnd0QnQySVprWUVzRDkyR21zMW5FRjR4cExTeGRMZWw1djVN?=
 =?utf-8?B?Q0RVNG5PRVNlTXFha3NEbS9wWG9HSUFDaDZzSGZvT3FhekpPalIvSGVtMFV0?=
 =?utf-8?B?UUdld09TeTFYc0Npb2NQTlgwakovZmZWRVg2Q0REZGpDL0laU3IwcXV4TkNQ?=
 =?utf-8?B?NGFvNHdQRmxYUzErdUV3bDZjZUhqYjB1ZDErMHNVNk5CUDJsU1BxM3dmV2gw?=
 =?utf-8?B?RVM1YUxpRnBudk15MVFkbVBSZDRDV2poYmJ2Mk9mTVQvL0lqVGhkRnp5dHdt?=
 =?utf-8?B?V0dTaE5BWW8vMWIraUkrOWNBTWN5ODF0Vlp1R3ByR1hKMXBaaTZBelNySUsz?=
 =?utf-8?B?MktHblplWURNN3hFL1RuMXRnMEN2aG0yc29vQTBoL1pBZCtDN0FsenRtdGh2?=
 =?utf-8?B?dXdkT0dSaTdTcy9uTVpKOWtBV0d2S2lraExwOFZDV1lwWGtubXdydXdqMFY1?=
 =?utf-8?B?Y29BWGpnTzYyZWhyOWlTU0l2VEhpL29JUHN5dWpTSXdoUUtTU1c1dFJmVStv?=
 =?utf-8?B?V29ObjRQMWFIc05WbFpmckdVMVFESkFReHZNN3lGeGgxdElFVTFEcExYWkJG?=
 =?utf-8?B?dEpvQXRybXFpL1h5ZDEzaW9qS04wU3d1QWJOTjZZQmFBQ0VSQW9VbTJVTmc3?=
 =?utf-8?B?T1p0SGhxdWpmSW9ZSjUzK2psaWxSODM2anFma05wQmRQNS9KZE1wMlBBTEpW?=
 =?utf-8?B?THRPUlJWVm16TGV2a3NaZnlUd3F1WTdMYm5oV3NjaGxTL2VmSnp5UWxtK2t5?=
 =?utf-8?B?bURhVXZCakZPR3JoVWtSMlFMTkVYb1hwWUxQYTMzZ2xVWnJHbGNka2JWcUY4?=
 =?utf-8?B?cFR2S29ZbEVlK0RQZlNoNmdnVk1DRHVubW5ac3EzTTVEVFpKUldnYm9GV2ZX?=
 =?utf-8?B?Y3JzUE9lNi9tdFcwSXdNRExoaW9nSVM1dldMWjc0a1RtendZQ0xRYjFXUGQv?=
 =?utf-8?B?YUdJZ0htWWxhTlB1NUJCZXFFL1RweVo0OVpBUGFSOW5HVzRLNG9WK0xqOHov?=
 =?utf-8?B?MWV2TGgwdTl2elVUSUdqcHhHdlp0MndBTXRmcW1UTkJNaVNRUjQzdGlESnoy?=
 =?utf-8?Q?OVrYJkfxdID2no8SW/NuiI6sm7HOfqFD?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(36860700013)(35042699022)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 11:04:29.7814
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbd89e85-989d-48fc-e379-08dcd18857ca
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C70F.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6733

Peter,

On 9/6/24 11:45, Peter Zijlstra wrote:
> On Thu, Sep 05, 2024 at 04:53:54PM +0200, Peter Zijlstra wrote:
> 
>>> But then, like you said, __update_load_avg_cfs_rq() needs correct
>>> cfs_rq->h_nr_running.
>>
>> Uff. So yes __update_load_avg_cfs_rq() needs a different number, but
>> I'll contest that h_nr_running is in fact correct, albeit no longer
>> suitable for this purpose.
>>
>> We can track h_nr_delayed I suppose, and subtract that.
> 
> Something like so?
> 
> ---
>  kernel/sched/debug.c |  1 +
>  kernel/sched/fair.c  | 49 ++++++++++++++++++++++++++++++++++++++++++++-----
>  kernel/sched/pelt.c  |  2 +-
>  kernel/sched/sched.h |  7 +++++--
>  4 files changed, 51 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index 01ce9a76164c..3d3c5be78075 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -829,6 +829,7 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
>  	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "spread", SPLIT_NS(spread));
>  	SEQ_printf(m, "  .%-30s: %d\n", "nr_running", cfs_rq->nr_running);
>  	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_running", cfs_rq->h_nr_running);
> +	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_delayed", cfs_rq->h_nr_delayed);
>  	SEQ_printf(m, "  .%-30s: %d\n", "idle_nr_running",
>  			cfs_rq->idle_nr_running);
>  	SEQ_printf(m, "  .%-30s: %d\n", "idle_h_nr_running",
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 11e890486c1b..629b46308960 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5456,9 +5456,31 @@ static void clear_buddies(struct cfs_rq *cfs_rq, struct sched_entity *se)
>  
>  static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq);
>  
> -static inline void finish_delayed_dequeue_entity(struct sched_entity *se)
> +static void set_delayed(struct sched_entity *se)
> +{
> +	se->sched_delayed = 1;
> +	for_each_sched_entity(se) {
> +		struct cfs_rq *cfs_rq = cfs_rq_of(se);
> +		cfs_rq->h_nr_delayed++;
> +		if (cfs_rq_throttled(cfs_rq))
> +			break;
> +	}
> +}
> +
> +static void clear_delayed(struct sched_entity *se)
>  {
>  	se->sched_delayed = 0;
> +	for_each_sched_entity(se) {
> +		struct cfs_rq *cfs_rq = cfs_rq_of(se);
> +		cfs_rq->h_nr_delayed--;
> +		if (cfs_rq_throttled(cfs_rq))
> +			break;
> +	}
> +}
> +
> +static inline void finish_delayed_dequeue_entity(struct sched_entity *se)
> +{
> +	clear_delayed(se);
>  	if (sched_feat(DELAY_ZERO) && se->vlag > 0)
>  		se->vlag = 0;
>  }
> @@ -5488,7 +5510,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>  			if (cfs_rq->next == se)
>  				cfs_rq->next = NULL;
>  			update_load_avg(cfs_rq, se, 0);
> -			se->sched_delayed = 1;
> +			set_delayed(se);
>  			return false;
>  		}
>  	}
> @@ -5907,7 +5929,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
>  	struct rq *rq = rq_of(cfs_rq);
>  	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
>  	struct sched_entity *se;
> -	long task_delta, idle_task_delta, dequeue = 1;
> +	long task_delta, idle_task_delta, delayed_delta, dequeue = 1;
>  	long rq_h_nr_running = rq->cfs.h_nr_running;
>  
>  	raw_spin_lock(&cfs_b->lock);
> @@ -5940,6 +5962,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
>  
>  	task_delta = cfs_rq->h_nr_running;
>  	idle_task_delta = cfs_rq->idle_h_nr_running;
> +	delayed_delta = cfs_rq->h_nr_delayed;
>  	for_each_sched_entity(se) {
>  		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
>  		int flags;
> @@ -5963,6 +5986,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
>  
>  		qcfs_rq->h_nr_running -= task_delta;
>  		qcfs_rq->idle_h_nr_running -= idle_task_delta;
> +		qcfs_rq->h_nr_delayed -= delayed_delta;
>  
>  		if (qcfs_rq->load.weight) {
>  			/* Avoid re-evaluating load for this entity: */
> @@ -5985,6 +6009,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
>  
>  		qcfs_rq->h_nr_running -= task_delta;
>  		qcfs_rq->idle_h_nr_running -= idle_task_delta;
> +		qcfs_rq->h_nr_delayed -= delayed_delta;
>  	}
>  
>  	/* At this point se is NULL and we are at root level*/
> @@ -6010,7 +6035,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
>  	struct rq *rq = rq_of(cfs_rq);
>  	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
>  	struct sched_entity *se;
> -	long task_delta, idle_task_delta;
> +	long task_delta, idle_task_delta, delayed_delta;
>  	long rq_h_nr_running = rq->cfs.h_nr_running;
>  
>  	se = cfs_rq->tg->se[cpu_of(rq)];
> @@ -6046,6 +6071,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
>  
>  	task_delta = cfs_rq->h_nr_running;
>  	idle_task_delta = cfs_rq->idle_h_nr_running;
> +	delayed_delta = cfs_rq->h_nr_delayed;
>  	for_each_sched_entity(se) {
>  		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
>  
> @@ -6060,6 +6086,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
>  
>  		qcfs_rq->h_nr_running += task_delta;
>  		qcfs_rq->idle_h_nr_running += idle_task_delta;
> +		qcfs_rq->h_nr_delayed += delayed_delta;
>  
>  		/* end evaluation on encountering a throttled cfs_rq */
>  		if (cfs_rq_throttled(qcfs_rq))
> @@ -6077,6 +6104,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
>  
>  		qcfs_rq->h_nr_running += task_delta;
>  		qcfs_rq->idle_h_nr_running += idle_task_delta;
> +		qcfs_rq->h_nr_delayed += delayed_delta;
>  
>  		/* end evaluation on encountering a throttled cfs_rq */
>  		if (cfs_rq_throttled(qcfs_rq))
> @@ -6930,7 +6958,7 @@ requeue_delayed_entity(struct sched_entity *se)
>  	}
>  
>  	update_load_avg(cfs_rq, se, 0);
> -	se->sched_delayed = 0;
> +	clear_delayed(se);
>  }
>  
>  /*
> @@ -6944,6 +6972,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  	struct cfs_rq *cfs_rq;
>  	struct sched_entity *se = &p->se;
>  	int idle_h_nr_running = task_has_idle_policy(p);
> +	int h_nr_delayed = 0;
>  	int task_new = !(flags & ENQUEUE_WAKEUP);
>  	int rq_h_nr_running = rq->cfs.h_nr_running;
>  	u64 slice = 0;
> @@ -6953,6 +6982,9 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  		return;
>  	}
>  
> +	if (task_new)
> +		h_nr_delayed = !!se->sched_delayed;
> +
>  	/*
>  	 * The code below (indirectly) updates schedutil which looks at
>  	 * the cfs_rq utilization to select a frequency.
> @@ -6991,6 +7023,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  
>  		cfs_rq->h_nr_running++;
>  		cfs_rq->idle_h_nr_running += idle_h_nr_running;
> +		cfs_rq->h_nr_delayed += h_nr_delayed;
>  
>  		if (cfs_rq_is_idle(cfs_rq))
>  			idle_h_nr_running = 1;
> @@ -7014,6 +7047,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  
>  		cfs_rq->h_nr_running++;
>  		cfs_rq->idle_h_nr_running += idle_h_nr_running;
> +		cfs_rq->h_nr_delayed += h_nr_delayed;
>  
>  		if (cfs_rq_is_idle(cfs_rq))
>  			idle_h_nr_running = 1;
> @@ -7076,6 +7110,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
>  	struct task_struct *p = NULL;
>  	int idle_h_nr_running = 0;
>  	int h_nr_running = 0;
> +	int h_nr_delayed = 0;
>  	struct cfs_rq *cfs_rq;
>  	u64 slice = 0;
>  
> @@ -7083,6 +7118,8 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
>  		p = task_of(se);
>  		h_nr_running = 1;
>  		idle_h_nr_running = task_has_idle_policy(p);
> +		if (!task_sleep && !task_delayed)
> +			h_nr_delayed = !!se->sched_delayed;
>  	} else {
>  		cfs_rq = group_cfs_rq(se);
>  		slice = cfs_rq_min_slice(cfs_rq);
> @@ -7100,6 +7137,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
>  
>  		cfs_rq->h_nr_running -= h_nr_running;
>  		cfs_rq->idle_h_nr_running -= idle_h_nr_running;
> +		cfs_rq->h_nr_delayed -= h_nr_delayed;
>  
>  		if (cfs_rq_is_idle(cfs_rq))
>  			idle_h_nr_running = h_nr_running;
> @@ -7138,6 +7176,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
>  
>  		cfs_rq->h_nr_running -= h_nr_running;
>  		cfs_rq->idle_h_nr_running -= idle_h_nr_running;
> +		cfs_rq->h_nr_delayed -= h_nr_delayed;
>  
>  		if (cfs_rq_is_idle(cfs_rq))
>  			idle_h_nr_running = h_nr_running;
> diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
> index fa52906a4478..21e3ff5eb77a 100644
> --- a/kernel/sched/pelt.c
> +++ b/kernel/sched/pelt.c
> @@ -321,7 +321,7 @@ int __update_load_avg_cfs_rq(u64 now, struct cfs_rq *cfs_rq)
>  {
>  	if (___update_load_sum(now, &cfs_rq->avg,
>  				scale_load_down(cfs_rq->load.weight),
> -				cfs_rq->h_nr_running,
> +				cfs_rq->h_nr_running - cfs_rq->h_nr_delayed,
>  				cfs_rq->curr != NULL)) {
>  
>  		___update_load_avg(&cfs_rq->avg, 1);
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 3744f16a1293..d91360b0cca1 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -603,6 +603,7 @@ struct cfs_rq {
>  	unsigned int		h_nr_running;      /* SCHED_{NORMAL,BATCH,IDLE} */
>  	unsigned int		idle_nr_running;   /* SCHED_IDLE */
>  	unsigned int		idle_h_nr_running; /* SCHED_IDLE */
> +	unsigned int		h_nr_delayed;
>  
>  	s64			avg_vruntime;
>  	u64			avg_load;
> @@ -813,8 +814,10 @@ struct dl_rq {
>  
>  static inline void se_update_runnable(struct sched_entity *se)
>  {
> -	if (!entity_is_task(se))
> -		se->runnable_weight = se->my_q->h_nr_running;
> +	if (!entity_is_task(se)) {
> +		struct cfs_rq *cfs_rq = se->my_q;
> +		se->runnable_weight = cfs_rq->h_nr_running - cfs_rq->h_nr_delayed;
> +	}
>  }
>  
>  static inline long se_runnable(struct sched_entity *se)

I gave the above patch a try on our Android workload running on the Pixel 6 with a 6.8-based kernel.

First I'd like to confirm that Dietmar's fix that was pushed to tip:sched/core (Fix util_est
accounting for DELAY_DEQUEUE) helps bring the frequencies and power use down to more sensible levels.

As for the above changes, unfortunately I'm seeing high frequencies and high power usage again. The
pattern looks similar to what we observed with the uclamp inc/dec imbalance.

I haven't investigated this in depth yet, but I'll go stare at some traces and the code, and hopefully
something will ring bells.

