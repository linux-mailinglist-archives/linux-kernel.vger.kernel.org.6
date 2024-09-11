Return-Path: <linux-kernel+bounces-324519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27194974DA7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C701B278B1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 08:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8A617F4E5;
	Wed, 11 Sep 2024 08:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="BkoSHDhQ";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="BkoSHDhQ"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2069.outbound.protection.outlook.com [40.107.249.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C277813B58A
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 08:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.69
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726044948; cv=fail; b=ND4rufFGJXB3LCbFrdXWg5r3GJB8gVS+AeFXYOkgQQ/pTbcqJPmG1FAecPAjX56SQIT6/Jkfp9q2M0Qrd161MImSHpKz/CyeEZ3o0w0trVHgOXAI3gEDgScStQFzdtbwSuvw2Gg/M2tLrZxxLOtnWUjPSjhZ97PkdhK5j5xXWvo=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726044948; c=relaxed/simple;
	bh=VIflkqXpaP9m026/R6F5cvnMAHluMoQZWALC6YTCHcs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AN0vYs2jOFul2IjE40JdrWShKWU+xd9I3yOLL1vF13JY2S02ICdqL3f8u8tEO6c7pgVwhYky6fexis3b2BmaaXmrVYF/407b03i17VDI6MD/xW12TCAXegN8Nyw2D4L+ENwnWLj3QbVWp5r4uOYrFSlq2xt3hpJ1aaWT/M1YnWI=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=BkoSHDhQ; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=BkoSHDhQ; arc=fail smtp.client-ip=40.107.249.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=q0hjvVXuPjvhSNvzA/2SBFSD6jQn2Kuc7n98m9c/OpB1C++FFSCByXX2rxSJeT9G3nSy7TVtD7IyP5XTNkZbu9VpOqQYqQbXwKD6mrzQZ4qKf+eEpdPIszRQJ+EjKQOsPVJpe4mnmKJm2SkNzHUr/j2O2WnthWTnWRwcowFaQITOBx72oqRxGWMxp6l5VqGnc11vIrd6jJj3mSa+ll1ZJvFlfTWiiX1CGfEbjHz6EQ++699TyyhyHH37cZ4Xu4Yv6UaKZ0gjvshaTnZLjoVWeBikvrzb61bIou0xoGH9Igxwp25zDJc/RhG1e/OP7w1KykIwa3NDRgcf9IMl0NSTZg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ig4jeTDQDl4bolVKAGTbYohzH4XPimnfTVhoNzJNvC4=;
 b=tcA5LpMSvGdcYvGNeWLh59ed1rjuOMT8qW1cxTE3rEJTG79r17uafPDCNs37fttvr9wFF9Jh/Bgp1X8Sfn62saMdRLKkvMSx1Fwgsk+P95MoaDxdOtDs3C9FMWcLkyfOJLPsGTFScHeUH7/mIvzMZkwRnY+uJe7RksydCofdufaKmlLs7zGVMXXoIss4YN5qT3YY50N/wMQ9yKkZCgs0yWm3G9GVPkC6UblWa0DMHXwTEcnQyODZviuZ+MDClnpmpULv4EoK8w29p4iURb6eUifTtXFXyuHbX3Jvbq5t20lUGF47UNs7FmbkG4teunO9fyTPTSMCfwgJgKvq3LxiKQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ig4jeTDQDl4bolVKAGTbYohzH4XPimnfTVhoNzJNvC4=;
 b=BkoSHDhQpwPC29JvtTo6bUPX6Uy8fZ458f+9QL2IXMzlyTbWndq5JtjARH/2PrUHumi4DkUEuE+T7WdlCeoBtTwREfb1YUPYfuh2qzzSZ2Opv+oxBM4lf6C3l9VbOXN0+2/AOd1iEDrMXWc2L2cFf6UYWSRkfLpyexGgHt3v0jU=
Received: from AS4P190CA0033.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5d1::13)
 by DB9PR08MB6410.eurprd08.prod.outlook.com (2603:10a6:10:262::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.16; Wed, 11 Sep
 2024 08:55:41 +0000
Received: from AMS0EPF00000199.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d1:cafe::db) by AS4P190CA0033.outlook.office365.com
 (2603:10a6:20b:5d1::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25 via Frontend
 Transport; Wed, 11 Sep 2024 08:55:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AMS0EPF00000199.mail.protection.outlook.com (10.167.16.245) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7918.13
 via Frontend Transport; Wed, 11 Sep 2024 08:55:41 +0000
Received: ("Tessian outbound b109797c3965:v441"); Wed, 11 Sep 2024 08:55:40 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: befd2ebc60ef4425
X-CR-MTA-TID: 64aa7808
Received: from Lb0fd9dfdb6af.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 70D4985A-0F02-4733-9C47-E96BF4EA87DF.1;
	Wed, 11 Sep 2024 08:55:33 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Lb0fd9dfdb6af.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 11 Sep 2024 08:55:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HVTUn/WAeEdGkhhqDtY0J6g8KP8sDVtCJAGpjCu2RqUBPwn6DUtLKIj0N27SYd8i7En4MIMDkyi7lMrYN4bJX3QnIguT2dZXF6EhE9RRiHFvwmKRQDrUB9bs/33wf6eRGUnbf1+tSiQu69ckehYdQ5Lh3LPA5MFtnZJpbXDCs9FQAT/7QzovE9TmbNI3tdED4nDBBXNv0Nm6KCVh6+2AB8le5Ah/Pv5j5S5BibeP6Q6miCCSTh/x3EmjPfG7oIFEuj7/0xg2Eq+3UCmSPjW4BbeE/61/k+o52ZkH7nNZ2m14+gvZqnaY9m0gvngLucKNogm7cxHiJPaj/Bu44Ca/eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ig4jeTDQDl4bolVKAGTbYohzH4XPimnfTVhoNzJNvC4=;
 b=j0VLdI1OgtdfQuvcWQhGPEcIPmGxbtz2/oZVnk4Wp4+8QSoXuPYhh6Yes7mXVFS939drxoMTloeZ21PvEn0ZaaRFVKF8U3Yg7yXX7bXqckbT/bLbu8ZRsTmI8VoQBB/kNWlhQF5rO7DGs78ZemNHNlPK1Aghc4pNNTV0oVBDtpLB4g3oY0AiEK8o4bdnmVDuUf5ayOmzLqOlsYlExA3ZE5H3VNsCirlRibY9Q13F1Zh2+i7h9Rygcq/efTRN8T64bsWHUAdI2ofaIw4o5WAsUtsKoVWRiQHzycy9ymW4DP1FEL9tMLZxyKBPeF/XBVvfRiRdlIcqkajRddHkZmlylA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ig4jeTDQDl4bolVKAGTbYohzH4XPimnfTVhoNzJNvC4=;
 b=BkoSHDhQpwPC29JvtTo6bUPX6Uy8fZ458f+9QL2IXMzlyTbWndq5JtjARH/2PrUHumi4DkUEuE+T7WdlCeoBtTwREfb1YUPYfuh2qzzSZ2Opv+oxBM4lf6C3l9VbOXN0+2/AOd1iEDrMXWc2L2cFf6UYWSRkfLpyexGgHt3v0jU=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PR3PR08MB5852.eurprd08.prod.outlook.com (2603:10a6:102:8e::21)
 by PR3PR08MB5595.eurprd08.prod.outlook.com (2603:10a6:102:83::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.13; Wed, 11 Sep
 2024 08:55:31 +0000
Received: from PR3PR08MB5852.eurprd08.prod.outlook.com
 ([fe80::f44:d113:1c29:825d]) by PR3PR08MB5852.eurprd08.prod.outlook.com
 ([fe80::f44:d113:1c29:825d%3]) with mapi id 15.20.7939.010; Wed, 11 Sep 2024
 08:55:31 +0000
Message-ID: <a8f7aa02-e215-4d06-b6d7-f59c38137d38@arm.com>
Date: Wed, 11 Sep 2024 09:55:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/24] sched/uclamg: Handle delayed dequeue
Content-Language: en-US
To: Peter Zijlstra <peterz@infradead.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Hongyan Xia <hongyan.xia2@arm.com>, mingo@redhat.com, juri.lelli@redhat.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, linux-kernel@vger.kernel.org, kprateek.nayak@amd.com,
 wuyun.abel@bytedance.com, youssefesmat@chromium.org, tglx@linutronix.de,
 efault@gmx.de
References: <CAKfTPtDO3n-4mcr2Sk-uu0ZS5xQnagdicQmaBh-CyrndPLM8eQ@mail.gmail.com>
 <aa81d37e-ad9c-42c6-a104-fe8496c5d907@arm.com>
 <c49ef5fe-a909-43f1-b02f-a765ab9cedbf@arm.com>
 <CAKfTPtCNUvWE_GX5LyvTF-WdxUT=ZgvZZv-4t=eWntg5uOFqiQ@mail.gmail.com>
 <a9a45193-d0c6-4ba2-a822-464ad30b550e@arm.com>
 <20240905145354.GP4723@noisy.programming.kicks-ass.net>
 <20240906104525.GG4928@noisy.programming.kicks-ass.net>
 <8d0d01b9-a430-49cc-93a5-67b4d68aa35c@arm.com>
 <20240910140524.GH4723@noisy.programming.kicks-ass.net>
 <52ca4cea-8f65-434e-af17-e4bf664d9488@arm.com>
 <20240911084528.GJ4723@noisy.programming.kicks-ass.net>
From: Luis Machado <luis.machado@arm.com>
In-Reply-To: <20240911084528.GJ4723@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0241.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::15) To PR3PR08MB5852.eurprd08.prod.outlook.com
 (2603:10a6:102:8e::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PR3PR08MB5852:EE_|PR3PR08MB5595:EE_|AMS0EPF00000199:EE_|DB9PR08MB6410:EE_
X-MS-Office365-Filtering-Correlation-Id: 9509859d-4d95-4e1c-3d18-08dcd23f83a3
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?UG92ejVjRm01bkxoZWZKaFZoWEhWNVlBK2tieVZqdzJHQm9xT3RlU1Z1SVhU?=
 =?utf-8?B?MUo2UCtDOThKdGd4Vm82MkkwSVh5RFdZbzRCVEp0cHkyTUV6dFdwRFFMdFZr?=
 =?utf-8?B?NWJoL0xuZ01Pdk5mak9rLy9zZ3J6NWtvVHFTTE11ZG9jTUxHcWU2M1RINXNJ?=
 =?utf-8?B?QmlGQkp3NnhHZW9wUmd1eUw5UURhVXl5VkNTem5GbTNLcVBHa0VPeEwrbnUx?=
 =?utf-8?B?NGZpcnBOL1dFRkFKaXQ2N296SWEwUkYwREhTQ2x1Z1pzVVNFd3RYTFFYK3BP?=
 =?utf-8?B?c3d0RVVlOWlPNFlGNDFCQ3lBLzRIZEVZWFpLMEVEUkxRVnVJZ3E0Y0wwMkw1?=
 =?utf-8?B?S1Z3Y0x5VmVTU2p1UDRHR2NGQUxFdTRwTTcvV1h4Y2FaZmcyRnhHQ0Y4STBy?=
 =?utf-8?B?dXlzODNTdEhtUnFUOENtWG1rclBUVFRkRHB1UHhhZDlJL1ZxWXdYSzVIZHgw?=
 =?utf-8?B?TWg1VFM1OHV3WEE4cStaRm4vbWRnejFTRlNUTys2bkU4L1REMGNFa3pEWGpl?=
 =?utf-8?B?ejJ5QURCRjZJSGtqbER2RVhKdGdQOUZLa2dqU2E3Ni9aM3h1c29JQldrKzln?=
 =?utf-8?B?dG9EME1Yb3I5NHpkK1dnazBreS9uSzFXMFRZcGtoQTFjbm5sZkFPNXRBMkpH?=
 =?utf-8?B?elljU0RCMXFUM3Q3UHVaWkxLaVp0S0s5K2NqekwxNXVyOTRnU0w5SUdzWEx1?=
 =?utf-8?B?TEJsL25CSHowdGRsSUgxZ1BBdWpnNHliN2xEYmpETE1STmduTk4rcjNpM2Fp?=
 =?utf-8?B?eHZuOEhpVFJ4WkFqSzZ6emVrRjdSYTBYVW9ld3JGRmVvY2JRR0J4aStIOFJ4?=
 =?utf-8?B?RE5Jc0lMWGZub1kyMkcveTBVY1N2RDVPWnVVWmhkcDRNWDRuL25ia0h4Nlhi?=
 =?utf-8?B?Z05LWFFhRUZZTmtpZk00UFMwN3pFZ0RncTg4UC9tMy9wWWw3SStXdjhDeFZh?=
 =?utf-8?B?VkFQbnFSQ3hBazd6TStpdGJZcUl2VlNvRFhhZVVoa0c2Q0sxM2dsQnpSR0JG?=
 =?utf-8?B?UzNLRW9rMWY4Vk5mS0NyYmphcVVKOHh1ZXA1bFBZNVZmU29qSU1Wd2Eva3hW?=
 =?utf-8?B?MW0vRmErR1VFclBRbmRoQmo5SkI1SlpBczZ2aFpEOE1xUWY3SVZibmUzRi92?=
 =?utf-8?B?Vit4Q0dIUHIxeFFCQW9WNDVRc3hKNWdQczFaaVNoZHBUQ0ZEaXNINzdHVWsw?=
 =?utf-8?B?b1ovTFNKK2o2QXJjS3F3bURlR2RaU2lCYlQ4YkVyZU03bDR1bmZLcmtQRVk5?=
 =?utf-8?B?MlJmWmlzN3JianhDQU5sNXlXSE91QUQyd1RCOVF2Sk9idDZGUXVQM2JZemdF?=
 =?utf-8?B?OHdFV1J3bnJyWk9xSmhOeXB2NTlIZlY5Y3dnNnFHSUFMdFkzQ252ZTdKNE5G?=
 =?utf-8?B?dFl5Z2YvcmRnN1Vma2hxK1cvZHJKMGxQU3hzNU5ZWEpneTN6OHBUZnVucUU0?=
 =?utf-8?B?bnlPS0tqSldFenRESldZTmY0N0FKRm0xN2E0cERGVFA5a3drMjVpVHZhZHNI?=
 =?utf-8?B?NE5YTWlBdEV2a1IzbEszcjFnckZTUm41bGViVkIwYW5MQlNCRUZDSVhPczZY?=
 =?utf-8?B?THpTTUxwdXFkYXVQUFh3YXl0SzdFTFVCRGF4SHZqU25YM3A4UHVNSGJadW1u?=
 =?utf-8?B?TVo0SEdyeGJxNWgrSWY5OGZVVGVTVTA4WXV0S1dYY1ZxYUdaSHZLdHVQbXJL?=
 =?utf-8?B?azdZdmJyelVzOG5GZjdBdWI0QnpwWnE4ZW1WQTZ6M0V4UGFoUnJwbjVZdW4z?=
 =?utf-8?B?QURWTWFDdXZsa0svc1M5VWgxK2xyNHJrczdmWnA0YTdzM1oxSWRYZVFnRno1?=
 =?utf-8?B?TnByS3p2UmlkMWJHWitTdz09?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR08MB5852.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5595
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:102:8e::21];domain=PR3PR08MB5852.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF00000199.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	7d82b71a-8580-437e-ec63-08dcd23f7dc2
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cUQrTFlmVm85YnpwQU9jdit4Z2cyOTFhY3haT0VlZXRXc3Vhb2lPMmQrR0ZE?=
 =?utf-8?B?c1BZQmFkbjZpTmpFdDNUOTBxR1RKU1U0Z3VDNXMxdGVFSS9vSmFUSW5OT2x0?=
 =?utf-8?B?eVNkVGpGM0pjY1BBZitPTERQeUZjSVdKNklDTVBwYmNjeE9LTTMySHdRSkJ5?=
 =?utf-8?B?MGZ0K3ArUWx3RzRCQWJodnVpNE1oSWZBYW9weEU3dEM0RWFYd0laVFoydXRI?=
 =?utf-8?B?MG93UWs4bFlHWDc4NktXclhnMWc0NEg2Smk0aEkvNVlVN0ZLNFVxcXJQakNN?=
 =?utf-8?B?azVINGlOd2M2a0pCdndjVk1zZlAvWGpCMndTMEFzN2VISVp2YWgxQWtNUXU5?=
 =?utf-8?B?a1RoL3NzTFdTY3lrMHBRdm9xaVhTSVlnRTRwM29PQ1lPdThiTnVna2E3UmpF?=
 =?utf-8?B?U3RSSlMvM1B2SEd5d2dXOFZyZXpzZVRaTCtJYVEwdEorVHNRMDJUMHF6MXEx?=
 =?utf-8?B?cTZVcytMTEdoQnZtZzJ0TDk4MXVyMVhwV2NiK2haNU1pbEdHeHFRRjRRUjcy?=
 =?utf-8?B?WGF3NjdmbUpNUEtwejhySEFNWFk5aUZpTFpMbmlQL2o3UEl6QXMwZHhScFlh?=
 =?utf-8?B?L1JpbXRUcDJmb1pHYzcrSEoyTm1DaFV4dE1rUCtyanB5RkMxWE1FUy9SUWhQ?=
 =?utf-8?B?bU1keUZkOFczTU9EbTVvUmpja3BYZUNXYWdOSGJ5dUoweWp1SFY1VHg4N3Fv?=
 =?utf-8?B?amRsU1JVcmxkaEZnQjNLcDhMYTlCOFhVZ0ZaVlk3Vld5RXh3UDB0eW1ZdG81?=
 =?utf-8?B?U2lIM1lTaVI5cjZsMEFpSk8rQ2FSdmsybjc3UHJWNjdjZ0k0TnRaT1lRK0pQ?=
 =?utf-8?B?Vk5FejVxNUJ2YStoT1hkNVRSS1k5U3MrcmpQSFRGNGllOE0xN1pGTm5CYTY4?=
 =?utf-8?B?eXZwRnBWNUUvNUF4TGN4WUJKQmhWb2QrMG13QWs5dHB0dGZkWEtkZzVLemJ3?=
 =?utf-8?B?a1p1V0F5dlhlT0hMeHJrTjQzWGVBUnczTkxCSS9aK09TL1JDWXh0NldiTTdh?=
 =?utf-8?B?ZFBsMG5oN05oa1ZuMTVUbU91SCtLZ2g0eWl4Q3BuZXdYc0NlblpteWhscmhj?=
 =?utf-8?B?UVk2U3ZYcjkzcVgwSlBwV0N4am9KYXREaEdTSm1uWGg2a2pCclVFUHZKMzFN?=
 =?utf-8?B?WFFmT3RqWjhTL1JWUFdnZGF4d0RFc2FKd2ZwbjRadUdnTHFYRGpkSjZ6K21O?=
 =?utf-8?B?NzhhV2luUXA1VldaZ1JNeTJMS1dLdmJHNFZjZGlnT3kwVmlhaDJBTGFsUTBu?=
 =?utf-8?B?OVhaamtKV25VMDFLWEdzNkFSNlRQTjQ2bmhYYzhJY1hkaVNVRm81M1VhSktZ?=
 =?utf-8?B?UlRuMGo4ZXpueEdwUUxscktXUDBKOGQ0bFN0RG81QjhucmNudkZ4RTY5TlBi?=
 =?utf-8?B?QS9jb3l0WkpWNWZycTFBaEtxd3NEUjZJT0U2alFHVWtqbGl5QVdldkZRQnpz?=
 =?utf-8?B?QkxlV01GU0FxT0Nrc3dsaEptb0R5RU4rOHRoKzRvMlNNNGNDdWRtZmhVWmV3?=
 =?utf-8?B?Wnd5SW1YYUZTRzc5N0tSV21UWks1ZGFyS3ZoR215TFNjanF4VXEyL2EveSth?=
 =?utf-8?B?ditHd09YM0dySGpqSC9EY2FVdzZIMzhFbnB4bTZsaWRVbXRXektkOEJHVWpy?=
 =?utf-8?B?SGRMKzBRMGhxVXVFTnpTTlhBYWhRclRKMkUyN3NzWDJva0pCb2N2cGE2RlhS?=
 =?utf-8?B?amYyT2pJK2M1bnFJS1RFT1pxRHB0K0xDS2FaTWNUVEdvUkhuR0ZFY0hxRHVM?=
 =?utf-8?B?dkNmTXhlMWFrQ0ZXUjQ1dmFFeU11VDRBV0QzNXRXMzA0blk2YTd1cytHV0dz?=
 =?utf-8?B?d05hdko1L1Vtdldnd3dqd3ZGWHlDM3JvQlhDalhVQ2ZKUHVRVGlOZnNNWGRO?=
 =?utf-8?B?cXMzVUpqd0k3Znk4Vkc4VEJLam9lYlp1RFgrSFQ1VXdxbEIwVFJVTER0ZWFm?=
 =?utf-8?Q?3I58Rs1Zg0Mu0XkSGOs1FvBB5FX3uOSQ?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(35042699022)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 08:55:41.2428
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9509859d-4d95-4e1c-3d18-08dcd23f83a3
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000199.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6410

On 9/11/24 09:45, Peter Zijlstra wrote:
> On Wed, Sep 11, 2024 at 09:35:16AM +0100, Luis Machado wrote:
>> On 9/10/24 15:05, Peter Zijlstra wrote:
>>> On Tue, Sep 10, 2024 at 12:04:11PM +0100, Luis Machado wrote:
>>>> I gave the above patch a try on our Android workload running on the Pixel 6 with a 6.8-based kernel.
>>>>
>>>> First I'd like to confirm that Dietmar's fix that was pushed to tip:sched/core (Fix util_est
>>>> accounting for DELAY_DEQUEUE) helps bring the frequencies and power use down to more sensible levels.
>>>>
>>>> As for the above changes, unfortunately I'm seeing high frequencies and high power usage again. The
>>>> pattern looks similar to what we observed with the uclamp inc/dec imbalance.
>>>
>>> :-(
>>>
>>>> I haven't investigated this in depth yet, but I'll go stare at some traces and the code, and hopefully
>>>> something will ring bells.
>>>
>>> So first thing to do is trace h_nr_delayed I suppose, in my own
>>> (limited) testing that was mostly [0,1] correctly correlating to there
>>> being a delayed task on the runqueue.
>>>
>>> I'm assuming that removing the usage sites restores function?
>>
>> It does restore function if we remove the usage.
>>
>> From an initial look:
>>
>> cat /sys/kernel/debug/sched/debug | grep -i delay                                                                                                                                                                                                                             
>>   .h_nr_delayed                  : -4
>>   .h_nr_delayed                  : -6
>>   .h_nr_delayed                  : -1
>>   .h_nr_delayed                  : -6
>>   .h_nr_delayed                  : -1
>>   .h_nr_delayed                  : -1
>>   .h_nr_delayed                  : -5
>>   .h_nr_delayed                  : -6
>>
>> So probably an unexpected decrement or lack of an increment somewhere.
> 
> Yeah, that's buggered. Ok, I'll go rebase sched/core and take this patch
> out. I'll see if I can reproduce that.

I'll keep looking on my end as well. I'm trying to capture the first time it goes bad. For some
reason my SCHED_WARN_ON didn't trigger when it should've.

