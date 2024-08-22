Return-Path: <linux-kernel+bounces-296987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5051795B188
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 11:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2D151F2215F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D6C17C7C1;
	Thu, 22 Aug 2024 09:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Y8/ls95D";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Y8/ls95D"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2079.outbound.protection.outlook.com [40.107.241.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F11D17C228
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 09:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.79
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724318548; cv=fail; b=QyUkhXazs/twy4LQ4k9O7ZL2DUDWL1Q/6BQq76PooM8aAjiY8MYMJXsOaDDpEt8Q/bRUYBEz6qhr2WFNvHBjrovNzXycuzsl/dNVeFQKZmTwvNR4OFldj+4kxzcMfoJIeHmCuHPDrZeSkjibm1Rb2Ga73YqrLmfbUmljh3TL8gs=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724318548; c=relaxed/simple;
	bh=s3ri6z08kvIc8OAOV/JR/LGNuJ4sCvD3KJv5G+LoHeo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qBicjEOMEfO7qdyWqnA6Y4tPQfEa44MUWaOPP++UiyD3IyEZqAnogrM5JZyWT0Z2nI2CRYl7PMIeR5zCyNyO8m237d1M3rcpJhU9s9xxx7fnu53F/oEvnOGsInnPoT0UTTKlYa81OEd9qM8WQzFzju9yzD/yEefMyIRsm3haYfg=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Y8/ls95D; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Y8/ls95D; arc=fail smtp.client-ip=40.107.241.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=zHpGIfOtKJ9t6WDvwUwy8qhDzxnzYsr9zABtcnJ/QhmyzJ6/sMyRcVWovFXgUJGmErjddmzm0vs+E+0xcKc2aNib9kHAjwZh7SRgy/jAKrO/GmqGI0r4Mlj6ccxgxOh88+w4QwhQsd5trzh4yN7BEx6x02zMwYoT8KcQc2XBdlCBLnPN8fh0fQpGnr4x/eqX/QSWpDILR5gESk7OIw7BOJiH1YW868feKwTLKoa+BqQ8Aa0ZjRg7DDWYKXCJ4T/oIOkBgNSDQ5VC9aylYzUqXFbavBbtGreqr+1t3K3oXF2KRCdnFBvvcZSlmdO3toYXR19yZl2NWouhy5mfkizOAQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+K7ZWuicZmgWX1mXSqOlLM0bqPw4TX/6SznUJgZZ4YM=;
 b=hGDjwr5gRwwmVNCxEOiLnO8kwUdLxNukbhTzosetSHCQaJEvWbenm1TvgthsAqe6cxjesci9gLbdVnmjrAZXJO8BocSduPU9Urq9iGA7WMpiVPVmjZdCEgVgD/CxY6LJKY5OHxXbWmxzqrEf9ktm9vRH/pSS9tkrYdf+mZ6mmRtccFoPpINAWXQYd/tJFZsTXLn+DtZLJL8LAHM0PaFIHui3PUAV8CCioZZ/8dscMxeI+yvrvjPQ50sX4MNUAD64OE0DmhpEZa/eYjLD3EMYdeX0u9WJKggPALA3XG5MY+39o2KA46Nyc3bpOt+9MS5+HYflVuVOJ6j62taAuUKYJQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+K7ZWuicZmgWX1mXSqOlLM0bqPw4TX/6SznUJgZZ4YM=;
 b=Y8/ls95D3GRRGnhIuAy6ukFjhxpx3cOLamye/c5gP9DMKXCWVRE8E1UmI2r/HUOxYT9T0jTL52JwFZ3yrKFwkUoAm3MvtN8ICbidU1Bo2M8Ke5+OgcXoe7z6uTPsWpJMG0Ty90L/3eODk7XDDnzBd0Ypc10tMGjpcmZmWf7RCnc=
Received: from AS4P190CA0036.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5d1::7)
 by DB9PR08MB9921.eurprd08.prod.outlook.com (2603:10a6:10:3d3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13; Thu, 22 Aug
 2024 09:22:16 +0000
Received: from AM4PEPF00027A6C.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d1:cafe::7f) by AS4P190CA0036.outlook.office365.com
 (2603:10a6:20b:5d1::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19 via Frontend
 Transport; Thu, 22 Aug 2024 09:22:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM4PEPF00027A6C.mail.protection.outlook.com (10.167.16.90) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7897.11
 via Frontend Transport; Thu, 22 Aug 2024 09:22:16 +0000
Received: ("Tessian outbound 71990416b08d:v403"); Thu, 22 Aug 2024 09:22:15 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: d2a012a22124e986
X-CR-MTA-TID: 64aa7808
Received: from L1f043a82295f.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id EED03D4C-D554-44A1-92F5-38AA5680C4F3.1;
	Thu, 22 Aug 2024 09:22:04 +0000
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L1f043a82295f.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 22 Aug 2024 09:22:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q3m1YnizGZNVqbSM+ZKEfEfG+eJ2js5avkU/XlghL1hRuiVi7ZQtWqpCuqUPh8+Mk35F8mzY4cISVTd5vNL5khRnY0ukJqBgg3frd58lHzGpfTmXGYaWOE+nUBrDucMBPKp6hpmd+8Aa1vHyL/e/2a4I+ERPsfRytndyN6AdYF7cB76lAhSlr+3AQs1yxXwt0z9/O7vTx4jH2w3hz9p+QjNbIei+UsZ5IZN4on8ixEn/rWmU1aUCo+rvFmx8gLk6qKNB3G7/I5sR36k9es0Pg6cF16Lzbp5ZIHVkwOHyA4ndcoclcYcki98OdWCKaDG9iIik3oNirzWq9WAvUGXOKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+K7ZWuicZmgWX1mXSqOlLM0bqPw4TX/6SznUJgZZ4YM=;
 b=lyapcqCSwUA+U8TM9asYJol0MeYa+cSW9DRMyYVMfxnoBE/xLxkYqIzsXt/pIxIncsZ4EKIeuOEwwaO2d5Qhx2uO8+S+VALPmUfDUIEo2Muq2/OnSLcJh6wlXidqZoqTeopjDCyPJDjq184aTER9DYMUSpz5Ru6jKC5T7KJkaf00HaB3OwHIe9GC/kF/pktzMIMXchCa0OWVnf4nITLsNuE1PXKCJ4KrUxM+kC8j+SxlyVYu1vZ/9jeXZp76Oo57UlMfMaQv/dC4j0mXDwu3z7NUbrUsYFCr1zre8ixKJJqyPe3DLzWt79CQO4cgedhyN8jMuTSjdYEInQnTHnGc8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+K7ZWuicZmgWX1mXSqOlLM0bqPw4TX/6SznUJgZZ4YM=;
 b=Y8/ls95D3GRRGnhIuAy6ukFjhxpx3cOLamye/c5gP9DMKXCWVRE8E1UmI2r/HUOxYT9T0jTL52JwFZ3yrKFwkUoAm3MvtN8ICbidU1Bo2M8Ke5+OgcXoe7z6uTPsWpJMG0Ty90L/3eODk7XDDnzBd0Ypc10tMGjpcmZmWf7RCnc=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PR3PR08MB5852.eurprd08.prod.outlook.com (2603:10a6:102:8e::21)
 by VI1PR08MB5375.eurprd08.prod.outlook.com (2603:10a6:803:130::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13; Thu, 22 Aug
 2024 09:21:59 +0000
Received: from PR3PR08MB5852.eurprd08.prod.outlook.com
 ([fe80::f44:d113:1c29:825d]) by PR3PR08MB5852.eurprd08.prod.outlook.com
 ([fe80::f44:d113:1c29:825d%3]) with mapi id 15.20.7897.010; Thu, 22 Aug 2024
 09:21:59 +0000
Message-ID: <1debbea4-a0cf-4de9-9033-4f6135a156ed@arm.com>
Date: Thu, 22 Aug 2024 10:21:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/24] sched/uclamg: Handle delayed dequeue
Content-Language: en-US
To: Vincent Guittot <vincent.guittot@linaro.org>,
 Hongyan Xia <hongyan.xia2@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
 juri.lelli@redhat.com, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 linux-kernel@vger.kernel.org, kprateek.nayak@amd.com,
 wuyun.abel@bytedance.com, youssefesmat@chromium.org, tglx@linutronix.de,
 efault@gmx.de
References: <20240727102732.960974693@infradead.org>
 <20240727105029.315205425@infradead.org>
 <6f39e567-fd9a-4157-949d-7a9ccd9c3592@arm.com>
 <CAKfTPtAS0eSqf5Qoq_rpQC7DbyyGX=GACsB7OPdhi8=HEciPUQ@mail.gmail.com>
From: Luis Machado <luis.machado@arm.com>
In-Reply-To: <CAKfTPtAS0eSqf5Qoq_rpQC7DbyyGX=GACsB7OPdhi8=HEciPUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0192.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::20) To PR3PR08MB5852.eurprd08.prod.outlook.com
 (2603:10a6:102:8e::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PR3PR08MB5852:EE_|VI1PR08MB5375:EE_|AM4PEPF00027A6C:EE_|DB9PR08MB9921:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f90b89b-f704-4760-0aa2-08dcc28bea2a
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?M3U1YzB1NWd0emh0ZjNWZ2RlOHJUS1d2QVVnNE5kWjkrTWdHUGlJTHNuSGpX?=
 =?utf-8?B?QnMrMGxwQnM5dHA3bGo4anBCbWxNaE5yQmxFZGM3NmtxY0JZTitxUGRYMU9s?=
 =?utf-8?B?UlQwcUQyclFobW1NOGNkL3FtYnpxUjQ4eEFGZGYzS3dBMW9qKzM5emM4TlFh?=
 =?utf-8?B?OXp3d1ZmdFZ1Rnc0ajNxWWp1djRCUGdPbGQ4TGNBTFkwVVk2WVp4cXc5ZHNZ?=
 =?utf-8?B?bytKTzcxRVZDdGJGM1lNTzI0NWtKcEtBSzBNaUJ3djBtRVk4T0tlR3Z1bEtI?=
 =?utf-8?B?TmMrbTFDNi8yM0wwM3ZSNW0wM2dDMm1lTjFJbjlZQWw5c0w3VWtMZ3FRZnBh?=
 =?utf-8?B?UHNPUEtSazBBaFBiRmw5Sk14dWNhczRHTDdHbkR2TitndldEMmRmVjVzQjBL?=
 =?utf-8?B?M3BRak1xd0RneW9OcituQnhDWmpuTy9SV0luR0dRcHlTcjBHdUlPcUo1NW1X?=
 =?utf-8?B?TFdaTFMyZkJaLys5ZGMyaExvN3RZUTlwd0Yybldqd0thYnhlUUg2R2N4NTdE?=
 =?utf-8?B?TWFyZHNDMG5wSFBLaU00RjhkWUZQVlJhNDFpYmxJekpJelFUTFBZSW83ZFRa?=
 =?utf-8?B?enVacnMvK3Zoc2x1U1FoK2tuUFQ2QStoWk96dzBYZnRaYTAvZXIzUnRkdTdx?=
 =?utf-8?B?dDZTMnM5dkJXT0VjREJxSUZib3YyUHFVOGVmanM0ZjFxZGcvckROcW9LWkR2?=
 =?utf-8?B?ZlF1KzBHSkEwQ1RjRnpSNnc0aGNwdzFkSTNoQ0QxOGk3WnprcEtVcGlTLytR?=
 =?utf-8?B?T2tTQU4vVGg0dGNydDVCbjRzMWRaUTFyam9PZWZ4Sm9ET3l2Q1hkUzF4eDIy?=
 =?utf-8?B?KzRsc2VmUW5nSXpPUUd2MVBRWDhBTFl5SDFpa3JWa3VlTXhXRWJuR2tVRjdC?=
 =?utf-8?B?Y2lWY2RaanBZbkJmTWVudG9zVkZ5bWUreHR3OTFkbHhoc1Y0MUNCYnVKT0Ri?=
 =?utf-8?B?TmhaY3B0L3BOdStiY0dyZC8wQVgvU1J1K1hVSUVaY21mRnhnSURkK0VadUpw?=
 =?utf-8?B?WVYyU3lxNnBySW9rYjgzQjZlNjRrbm9tQzQvRGZyY3Y0MGxwZVYyUUVEcU9H?=
 =?utf-8?B?TXlOVUtONDFCazlPYlJmSnV2UDZtaTgwemdQV01DZm9iT3dSa1RncUZoTCtN?=
 =?utf-8?B?UmQyc3YrYlYrSDljQ2YrNW1EeEpZbEp6Z2ZGVm5hVUxIZUVWS3FYZlZSUnYy?=
 =?utf-8?B?Um02OGh1OXFLNGI4NWk1d3BtK2pteG5ZQ001UmppOXpqeFlBNHpvS1JIZ1pR?=
 =?utf-8?B?N0JUenlQeVR6UWs2MGdIRjJQYlFzSE1LTGxIYTdrbXk2VjJiRWUzYzlpR3JN?=
 =?utf-8?B?OE5EWW04dHM3cktLdXBrb2N5U2RqOXQ0R2pNaG1QaHpGekgvZHNkb1Z6VUJJ?=
 =?utf-8?B?OVJ2UVFWelVLMGU2LytVM29kTUVZU2Vvbm42OXZ1YXQyQkM1c096a2NPWW5p?=
 =?utf-8?B?NlNzWWswS24vQ1RmZldMSHNTSXRMQk1yZ0FEZDZvUUg0a2ZzZnlBeGpJWENU?=
 =?utf-8?B?ZDlHSUdpSlJPTnAwNUJsNlNaalQxWTd1MzNwN2c4L1FpdkgrcFdKTXFWZjZj?=
 =?utf-8?B?aHZudFJ4UGxaRXVHaVJZMHF5eWVpeDFPaTM3c05TN29FVEZ0ZVV6TDMvU2Zy?=
 =?utf-8?B?M0Z6U1REZlZ2aDhpbldrbGpHQjVIbllZei9hWXY1ZVhnbnlMczNIcXNST0tl?=
 =?utf-8?B?bWt3M2NLWmVscDBqTmZSc2llMm85by9rZmxkTEtwVC9YbnJGR25pdUZWL0VO?=
 =?utf-8?Q?q1lVKsTTkIeH16ON8E=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR08MB5852.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5375
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:102:8e::21];domain=PR3PR08MB5852.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00027A6C.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	ed2c6484-ec78-4c81-8c9e-08dcc28be014
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|35042699022|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NjlwK0orMjVNS1JoVUpOdWYrYlI5aWhBMjhKeEU2WVUxdm5laFZBQUxncmRu?=
 =?utf-8?B?MTRQR01XRDhseUVNSWMrc3o5ODlrSER2L2l2WlRCcHZ0UUo5QjRWeHU3TEps?=
 =?utf-8?B?eWxTQmpHSzFpNU5sTllmdTVaeTFkUmVWODdsZkxob0ZRbTJjWFVPejRzVDJk?=
 =?utf-8?B?SWd5alc3MVBiV0VEalBYNEZsS2Q1cDh5Z0R2WlU5UndNNW5FbjBaUFhJVk9P?=
 =?utf-8?B?ajZOaTIxempDSFg5YmJCV0V1TmpacjNVUE04QVJoaGxEUDlWUTZvSGJvNFJH?=
 =?utf-8?B?c0RVeVgyNzZPaFdYbEFlTGV0SS9yRjhXRDFENTAzUTYrNk5nQU5wRHJ1VmFa?=
 =?utf-8?B?ZkQ0cVU1UWd2eUZhdm9QdUpGTHJRR3ROaVJVR2wwcFNOZmtzcEgzS2UrRVJn?=
 =?utf-8?B?TzFxNW5JdFlKRHR6K3p3Z0haNytDQ28yWFpPZ0pEUWdudDF3VlJIL1hPcTNS?=
 =?utf-8?B?cERieU42dTJtY3UveXRmUmNiY05YMUZtcGlCRHNRSC9sOHVrbXZIMlFJcExh?=
 =?utf-8?B?blRwVlhycFJMZ0llcnBHSFVKaWdkbVp4RjZGWm1qdjF5WGkxWGpBcFExRHJW?=
 =?utf-8?B?dTFGVVN4U1pMUjgxT0ZvdSt3OW9MMWwrYzYxSzhvYVhyV3ZKNzVKUTRLQ21P?=
 =?utf-8?B?QWFrT0QyRkNDU2dxUldnekNjOWRtMi9ESDFuNVZPZFdWejVtQnRvcU1pWlZs?=
 =?utf-8?B?ZGovamlEQ0RicC9pbTA0OFR2UkNORVFQSHY3eVhlM2tSSTBHb0RHOXZ0NU5H?=
 =?utf-8?B?b1FldVp4MThVRkhTNVk2eERGQ0tEczB0V0F2a20zVDBJZ1A3bFZNVHhQR0J5?=
 =?utf-8?B?UGNqdmhjSndnTlFIeFYzcG9DSERjbThOQVlLWEtVUTJIUU05Y1lKQ2F1Q2hj?=
 =?utf-8?B?bUF5c3NVaHRFeEpiVU1XbC9LQUVLaVN1TjBteVdYWkZsV3RMaHFBMTVVMVo3?=
 =?utf-8?B?V0l1ZmEyQjBzbWhBUWxyd053WFplQ1FPMGpYUjZHTTk3V1lqOXBDRDczM09R?=
 =?utf-8?B?TmdGMXFHaFhpMkVqZnhFcFM0cnZlbXR4anBnWk5HUTJTQkc2ajRhTHl5OFEv?=
 =?utf-8?B?UG1QUjJEbDhwU2VHQXZXNk1JT2ROT1JmNVUzOXp4elhHRHBrMzVYT1QvQnlY?=
 =?utf-8?B?dy9xZ0tzcGpreUszK0cwSkV4UU55eWM5MkRJcnd4aDdUOXAzSldWYUlON2pp?=
 =?utf-8?B?OXNFeGxwSHNrWXZ1cGNJdkpMdUtTQUh5OGdSTzBnRVRJZFZ4dW9hS3o2bjJN?=
 =?utf-8?B?RE1uelV1OFFMb1h4NFI4YTYxcUhQZngzZk1SUmRkcUk0QTA3U3grdXBCOHNR?=
 =?utf-8?B?S1oyZ2JzdGZyNVRIWkZWdGVGb05CQmJMSnVUVlF6QzVpT1ZJUHlEeGZ6M093?=
 =?utf-8?B?MWVxU3JZbFArTE1BQlBvbUdVSlVRVTNBUGxTSXlvOEo5cDRTV3VQOUxIQ2ZC?=
 =?utf-8?B?OTBiM1N1OVZlTFpZV2tQWFIwZ0hhVHlmbzB1V2JBbEhwdU9pL3BHNFBRdDZ4?=
 =?utf-8?B?NDc2dmhrMk0xcjR1YnJHNGExa2xHdmQxMFhHY0RyZDBBSGZoZnhyRWVrVkl4?=
 =?utf-8?B?Vzd2bXNGMkRuY09RbFE1bThXV0hPcXRhVU40RG1lQ0FMM0F2MGx3VHNSMnVP?=
 =?utf-8?B?SnNGZkNiVEh6QlFQNFRZOEhmYkttSGRRaEd3N2RTaTVwbFNSYnRUUkhJMEk4?=
 =?utf-8?B?QzdCMDVKcWV5VVNxcHFyaEVYZEIxYzg2V1NZc2tRRXlMTkk5WTRDZE5RRXJ4?=
 =?utf-8?B?ZVdhbURnVmNuNUJ0cElXeWxsSklHeWNNa0NIRFNCYzQvZTVEQ0JhRnBaaUVT?=
 =?utf-8?B?T1hVTzJxUEdkRTUvVlRLelg4TUtpdlVPa3NVU1Erd0tMZ25LSU9PN1FMaWta?=
 =?utf-8?B?WlhYc1lrV0RhUDMrOHpZMmwvQWRxY2pnRm5NTEVyMWExWmc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(1800799024)(35042699022)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 09:22:16.4009
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f90b89b-f704-4760-0aa2-08dcc28bea2a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A6C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9921

On 8/22/24 09:19, Vincent Guittot wrote:
> Hi,
> 
> On Wed, 21 Aug 2024 at 15:34, Hongyan Xia <hongyan.xia2@arm.com> wrote:
>>
>> Hi Peter,
>>
>> Sorry for bombarding this thread in the last couple of days. I'm seeing
>> several issues in the latest tip/sched/core after these patches landed.
>>
>> What I'm now seeing seems to be an unbalanced call of util_est. First, I applied
> 
> I also see a remaining util_est for idle rq because of an unbalance
> call of util_est_enqueue|dequeue
> 

I can confirm issues with the utilization values and frequencies being driven
seemingly incorrectly, in particular for little cores.

What I'm seeing with the stock series is high utilization values for some tasks
and little cores having their frequencies maxed out for extended periods of
time. Sometimes for 5+ or 10+ seconds, which is excessive as the cores are mostly
idle. But whenever certain tasks get scheduled there, they have a very high util
level and so the frequency is kept at max.

As a consequence this drives up power usage.

I gave Hongyan's draft fix a try and observed a much more reasonable behavior for
the util numbers and frequencies being used for the little cores. With his fix,
I can also see lower energy use for my specific benchmark.


>> the following diff to warn against util_est != 0 when no tasks are on
>> the queue:
>>
>> https://lore.kernel.org/all/752ae417c02b9277ca3ec18893747c54dd5f277f.1724245193.git.hongyan.xia2@arm.com/
>>
>> Then, I'm reliably seeing warnings on my Juno board during boot in
>> latest tip/sched/core.
>>
>> If I do the same thing to util_est just like what you did in this uclamp
>> patch, like this:
> 
> I think that the solution is simpler than your proposal and we just
> need to always call util_est_enqueue() before the
> requeue_delayed_entity
> 
> @@ -6970,11 +6970,6 @@ enqueue_task_fair(struct rq *rq, struct
> task_struct *p, int flags)
>         int rq_h_nr_running = rq->cfs.h_nr_running;
>         u64 slice = 0;
> 
> -       if (flags & ENQUEUE_DELAYED) {
> -               requeue_delayed_entity(se);
> -               return;
> -       }
> -
>         /*
>          * The code below (indirectly) updates schedutil which looks at
>          * the cfs_rq utilization to select a frequency.
> @@ -6983,6 +6978,11 @@ enqueue_task_fair(struct rq *rq, struct
> task_struct *p, int flags)
>          */
>         util_est_enqueue(&rq->cfs, p);
> 
> +       if (flags & ENQUEUE_DELAYED) {
> +               requeue_delayed_entity(se);
> +               return;
> +       }
> +
>         /*
>          * If in_iowait is set, the code below may not trigger any cpufreq
>          * utilization updates, so do it here explicitly with the IOWAIT flag
> 
> 
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 574ef19df64b..58aac42c99e5 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -6946,7 +6946,7 @@ enqueue_task_fair(struct rq *rq, struct
>> task_struct *p, int flags)
>>
>>         if (flags & ENQUEUE_DELAYED) {
>>                 requeue_delayed_entity(se);
>> -               return;
>> +               goto util_est;
>>         }
>>
>>         /*
>> @@ -6955,7 +6955,6 @@ enqueue_task_fair(struct rq *rq, struct
>> task_struct *p, int flags)
>>          * Let's add the task's estimated utilization to the cfs_rq's
>>          * estimated utilization, before we update schedutil.
>>          */
>> -       util_est_enqueue(&rq->cfs, p);
>>
>>         /*
>>          * If in_iowait is set, the code below may not trigger any cpufreq
>> @@ -7050,6 +7049,9 @@ enqueue_task_fair(struct rq *rq, struct
>> task_struct *p, int flags)
>>         assert_list_leaf_cfs_rq(rq);
>>
>>         hrtick_update(rq);
>> +util_est:
>> +       if (!p->se.sched_delayed)
>> +               util_est_enqueue(&rq->cfs, p);
>>   }
>>
>>   static void set_next_buddy(struct sched_entity *se);
>> @@ -7173,7 +7175,8 @@ static int dequeue_entities(struct rq *rq, struct
>> sched_entity *se, int flags)
>>    */
>>   static bool dequeue_task_fair(struct rq *rq, struct task_struct *p,
>> int flags)
>>   {
>> -       util_est_dequeue(&rq->cfs, p);
>> +       if (!p->se.sched_delayed)
>> +               util_est_dequeue(&rq->cfs, p);
>>
>>         if (dequeue_entities(rq, &p->se, flags) < 0) {
>>                 if (!rq->cfs.h_nr_running)
>>
>> which is basically enqueuing util_est after enqueue_task_fair(),
>> dequeuing util_est before dequeue_task_fair() and double check
>> p->se.delayed_dequeue, then the unbalanced issue seems to go away.
>>
>> Hopefully this helps you in finding where the problem could be.
>>
>> Hongyan
>>
>> On 27/07/2024 11:27, Peter Zijlstra wrote:
>>> Delayed dequeue has tasks sit around on the runqueue that are not
>>> actually runnable -- specifically, they will be dequeued the moment
>>> they get picked.
>>>
>>> One side-effect is that such a task can get migrated, which leads to a
>>> 'nested' dequeue_task() scenario that messes up uclamp if we don't
>>> take care.
>>>
>>> Notably, dequeue_task(DEQUEUE_SLEEP) can 'fail' and keep the task on
>>> the runqueue. This however will have removed the task from uclamp --
>>> per uclamp_rq_dec() in dequeue_task(). So far so good.
>>>
>>> However, if at that point the task gets migrated -- or nice adjusted
>>> or any of a myriad of operations that does a dequeue-enqueue cycle --
>>> we'll pass through dequeue_task()/enqueue_task() again. Without
>>> modification this will lead to a double decrement for uclamp, which is
>>> wrong.
>>>
>>> Reported-by: Luis Machado <luis.machado@arm.com>
>>> Reported-by: Hongyan Xia <hongyan.xia2@arm.com>
>>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>>> ---
>>>   kernel/sched/core.c |   16 +++++++++++++++-
>>>   1 file changed, 15 insertions(+), 1 deletion(-)
>>>
>>> --- a/kernel/sched/core.c
>>> +++ b/kernel/sched/core.c
>>> @@ -1676,6 +1676,9 @@ static inline void uclamp_rq_inc(struct
>>>       if (unlikely(!p->sched_class->uclamp_enabled))
>>>               return;
>>>
>>> +     if (p->se.sched_delayed)
>>> +             return;
>>> +
>>>       for_each_clamp_id(clamp_id)
>>>               uclamp_rq_inc_id(rq, p, clamp_id);
>>>
>>> @@ -1700,6 +1703,9 @@ static inline void uclamp_rq_dec(struct
>>>       if (unlikely(!p->sched_class->uclamp_enabled))
>>>               return;
>>>
>>> +     if (p->se.sched_delayed)
>>> +             return;
>>> +
>>>       for_each_clamp_id(clamp_id)
>>>               uclamp_rq_dec_id(rq, p, clamp_id);
>>>   }
>>> @@ -1979,8 +1985,12 @@ void enqueue_task(struct rq *rq, struct
>>>               psi_enqueue(p, (flags & ENQUEUE_WAKEUP) && !(flags & ENQUEUE_MIGRATED));
>>>       }
>>>
>>> -     uclamp_rq_inc(rq, p);
>>>       p->sched_class->enqueue_task(rq, p, flags);
>>> +     /*
>>> +      * Must be after ->enqueue_task() because ENQUEUE_DELAYED can clear
>>> +      * ->sched_delayed.
>>> +      */
>>> +     uclamp_rq_inc(rq, p);
>>>
>>>       if (sched_core_enabled(rq))
>>>               sched_core_enqueue(rq, p);
>>> @@ -2002,6 +2012,10 @@ inline bool dequeue_task(struct rq *rq,
>>>               psi_dequeue(p, flags & DEQUEUE_SLEEP);
>>>       }
>>>
>>> +     /*
>>> +      * Must be before ->dequeue_task() because ->dequeue_task() can 'fail'
>>> +      * and mark the task ->sched_delayed.
>>> +      */
>>>       uclamp_rq_dec(rq, p);
>>>       return p->sched_class->dequeue_task(rq, p, flags);
>>>   }
>>>
>>>


