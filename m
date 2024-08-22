Return-Path: <linux-kernel+bounces-297228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0553995B4AD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 14:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF386285F6B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 12:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67AA91C9DFA;
	Thu, 22 Aug 2024 12:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="dYNUizZa";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="dYNUizZa"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2050.outbound.protection.outlook.com [40.107.104.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DD91C9DE5
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 12:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.50
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724328500; cv=fail; b=OpYPXdILkDrca/KnurmN76rRoQPK+2jrhcm2NfKFYDFRwBsmABRZ31r6YjdeVP5D6NAJGYNAOlq4hN11qtgWqZm8x9Z8p+h+dVq2Blo1X2KclcFe508AH34sIcwoUyIN+b7odKieCreR2S2HIkhy5p3tIRIAYrGehQY4o3NrIe8=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724328500; c=relaxed/simple;
	bh=qukzkX8M5WJZ/USP0RILYHFzMvpW4hs03TplJvFIbN8=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=smx4tpguK6sIVEw4MMjQja1KouDMydzrNDJVd1Ol4/ZtUGcTYeMVpiLnyhwZYBbwng/DwrFkkRPgBlBCau84aty/Ay0XuLNURW7ENwhwYY5ukugCYE0YhOXabsg3iFATkVij0EqMiSffBA9WVMy1DHh1c754+YgbZu6FMg7NcCg=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=dYNUizZa; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=dYNUizZa; arc=fail smtp.client-ip=40.107.104.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=WwhpCsfAkkhRT/PjNkCpk5+ntI+39Kkc/bMHVtaO979dGAMeS3nwAIdAGWkv1PNVJsNyJMYNd/5ynu4gOsNZIINK1dYQADvGGUl1AI4Tt3adA+TnkcAXIf45zairiJs/eZf8Ka8q84WvELAHg7R9yvjYkkpgYdZUrSsKdkB5OsOwO97Eon8tfy5HW8qFIuqS9Q5/masTKAacH38pEgreOSYh7OfFHPwSToHo2/Hso+U6+vnirIMFviMaTELM5XBKZF7QeaU13SyZmL7T3TdY/vN4brNZhdND+Ojiuc5GIUbNnufeUryCTfLcG5Pxwc5kJffbQUZS8Dlhye8NMsX0CQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RMlwKO3EYt40Ub/9JSyemjtVAq35bjWeFwZ1ViA/0T8=;
 b=ZS+Xezvu9rko4KTfaw409UNs/TP2nqoqRt4700oBJRF9uZQ2QztUHGYiWYacKtU1fLIiA3s3pPBNy7teKvR6xKHX/FBFHo0tkY/x1JS2IcyE1etkSM5Hyjp6M8wGQyjbFM/iRgRSg3b1r1ib9A3TLHN37pog8EmLNSBsda2sk8IjJ+uIfQdgzSCpMEcChUQdz7Gjzw5toF0YrlAVgB/qhl3layxufgZCOJdcJMPjXz5U+r7ZCOybjnYjMwLL1bJeEwlRPKSU5EpTDhohs/kuqw3laL3h3xUGAa0XCuNNOBhVIl2GERX0pSpO6CIb88EH0Cu7Jk79rC+WEyRUq0d5pA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMlwKO3EYt40Ub/9JSyemjtVAq35bjWeFwZ1ViA/0T8=;
 b=dYNUizZaSNqTkF3bHdzjOM2xGURoNd50u1FIWgFAgLuV8sY0HN2zT6nI7KaLWTl3OJHJKHJUsSIeIPcOJF4G0USahlZEgWa85CfHcWiaou5EemtvlNZfMJHJnmSWEqZeyv2pE2cs9DPDjAb7OvOUBzOmAcJ9ieKzxFZVIyStvas=
Received: from DU7PR01CA0033.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::11) by DB9PR08MB6649.eurprd08.prod.outlook.com
 (2603:10a6:10:26c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Thu, 22 Aug
 2024 12:08:13 +0000
Received: from DB1PEPF000509E4.eurprd03.prod.outlook.com
 (2603:10a6:10:50e:cafe::ca) by DU7PR01CA0033.outlook.office365.com
 (2603:10a6:10:50e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19 via Frontend
 Transport; Thu, 22 Aug 2024 12:08:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB1PEPF000509E4.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7897.11
 via Frontend Transport; Thu, 22 Aug 2024 12:08:13 +0000
Received: ("Tessian outbound 8e666bd17457:v403"); Thu, 22 Aug 2024 12:08:12 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: bc39d6f17600a53c
X-CR-MTA-TID: 64aa7808
Received: from Lcd1ae1dabda6.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 2714C33B-E4FD-4B2F-9841-52E9153F89C5.1;
	Thu, 22 Aug 2024 12:08:01 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Lcd1ae1dabda6.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 22 Aug 2024 12:08:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mf6CAaq/WLxGjjs11e9848Jt5p0WEAaP8BWA5OwFFeqv2PJsu4nsD054xh+Jo7C2Yp/z3VBsrzEIfJZv7UoWTK91L6Wpp797BojnDvhj5Ih/db7x8lACABuVGSDIImfd80H3Ng3pkfWTdWWlWi72Zmi/KEUK83FewqpjUNWRntIMEegE24fYRnvpK/9vinOBn4lZ5R7oePTwMNLUdSnEP3fwRYabqP4iZul8zyenDHDYNl2JCWyg4oSRF9IEWs7EX4rSjUvaizfBTt1m05UGBKDf2x62fDYcnsOBgn24N5AKMaVDDvErEceYRNKWsKmpG4LOFO0CovEfHDZDnmOaEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RMlwKO3EYt40Ub/9JSyemjtVAq35bjWeFwZ1ViA/0T8=;
 b=E6xXbLQIP9+pLkGJaxhOLknJPjwaYZ/v5tmc8NpWzrqVqyQ5U0FTVLWFzC46nl8LFUUQB/bTaq/7FKRbKwq+wQtWfCKvxQlX2qtH163NKX6fQykkVsQsY+D72o9RpRtOly2/pd4C8MVZG6avyGskXduVWZQH4g3q4KmSppLXLdQxagLTa2bnq0s8pkncAf84OYB/5XSp0RVSVLydB8g1Zv9myT++tvJxS1XdRnzkCmxKWNfv4ZdFSrIv5txwO6DLB5Zm4SD+ko6Q77qLmi5vf0YkVrsKKWfcsB5sPRLB9lhWbk6f7Idf83T5iDcduUkkqSI4nShrRNA8iBvHr2Q+FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMlwKO3EYt40Ub/9JSyemjtVAq35bjWeFwZ1ViA/0T8=;
 b=dYNUizZaSNqTkF3bHdzjOM2xGURoNd50u1FIWgFAgLuV8sY0HN2zT6nI7KaLWTl3OJHJKHJUsSIeIPcOJF4G0USahlZEgWa85CfHcWiaou5EemtvlNZfMJHJnmSWEqZeyv2pE2cs9DPDjAb7OvOUBzOmAcJ9ieKzxFZVIyStvas=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PR3PR08MB5852.eurprd08.prod.outlook.com (2603:10a6:102:8e::21)
 by DU0PR08MB9535.eurprd08.prod.outlook.com (2603:10a6:10:44d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.11; Thu, 22 Aug
 2024 12:07:58 +0000
Received: from PR3PR08MB5852.eurprd08.prod.outlook.com
 ([fe80::f44:d113:1c29:825d]) by PR3PR08MB5852.eurprd08.prod.outlook.com
 ([fe80::f44:d113:1c29:825d%3]) with mapi id 15.20.7897.010; Thu, 22 Aug 2024
 12:07:58 +0000
Message-ID: <629937b1-6f97-41d1-aa4f-7349c2ffa29d@arm.com>
Date: Thu, 22 Aug 2024 13:07:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/24] sched/uclamg: Handle delayed dequeue
Content-Language: en-US
From: Luis Machado <luis.machado@arm.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Hongyan Xia <hongyan.xia2@arm.com>, Peter Zijlstra
 <peterz@infradead.org>, mingo@redhat.com, juri.lelli@redhat.com,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
 kprateek.nayak@amd.com, wuyun.abel@bytedance.com, youssefesmat@chromium.org,
 tglx@linutronix.de, efault@gmx.de
References: <20240727102732.960974693@infradead.org>
 <20240727105029.315205425@infradead.org>
 <6f39e567-fd9a-4157-949d-7a9ccd9c3592@arm.com>
 <CAKfTPtAS0eSqf5Qoq_rpQC7DbyyGX=GACsB7OPdhi8=HEciPUQ@mail.gmail.com>
 <1debbea4-a0cf-4de9-9033-4f6135a156ed@arm.com>
 <CAKfTPtCEUZxV9zMpguf7RKs6njLsJJUmz8WadyS4ryr+Fqca1Q@mail.gmail.com>
 <83a20d85-de7a-4fe6-8cd8-5a96d822eb6b@arm.com>
In-Reply-To: <83a20d85-de7a-4fe6-8cd8-5a96d822eb6b@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0023.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::15) To PR3PR08MB5852.eurprd08.prod.outlook.com
 (2603:10a6:102:8e::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PR3PR08MB5852:EE_|DU0PR08MB9535:EE_|DB1PEPF000509E4:EE_|DB9PR08MB6649:EE_
X-MS-Office365-Filtering-Correlation-Id: 0471201a-5a54-4312-b740-08dcc2a318d4
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?ejlXSFdhTVdKOUUzTmxmbWUyK3dKL1FZTVdwNVNHR1hHa0U5anl3OVA5YlRZ?=
 =?utf-8?B?ZXZVbDk3aUFZZTdQOURQQUordm40SGdYTnRvRHFBb0craDI4N2FiSmw2S25p?=
 =?utf-8?B?cEVtK2tOdkxrbHdlcHhUOVozbGFJY2FSZXpmQWE0VER0a2I3NWtScWJZbVM5?=
 =?utf-8?B?dWtzY0xKbTVLNVZKSXdIM2pjT1U4eWFUYTc4a0h0UnY3RENvdUcyYnRjZ2FW?=
 =?utf-8?B?WXBZTm5CdysxQXBhQklJc1pxMDNQNWtCclJpVlFGaU0vRElTbHowRTYwanVa?=
 =?utf-8?B?MW13K2hON3JSL2oxVUFBdmMvUFZhWXhQNWVPem85NTY2M3BFSjF0YlIvZG82?=
 =?utf-8?B?Q1RySXVkYUpEYWhVWmowTERPV1lJY3djV3kzU3R4V2VyMDd2dEhudkxuaXpx?=
 =?utf-8?B?UHdxMFBEdEx0WHYwZGRVUHlqWFVBYUhkRFF2bndWRTJPWlBLUzVEc2twNEpJ?=
 =?utf-8?B?RHRORHdPR3dPUnVTV1RjckRUWEp2eFVSalYzeWlxdDFsc1p3SllBdVVIbWdD?=
 =?utf-8?B?M1JCdTdKZXR5S2o4T2oyRy9USGFpdDJRUlRVZmU5Umd0Z1A1SFBEVDRIKzdM?=
 =?utf-8?B?ZTNwdjNHYXBVTUhRYU1qU2tKajZUUXdEcDVrTTVmZW14S1BMV2hVcFVyUml1?=
 =?utf-8?B?TnY1U0Y3T0EvM2dsYXhBYjd6SlBrU1R3OVZ0MlRLUm5kbVV2aThiVkpzNURH?=
 =?utf-8?B?MTkxOENxY0E4NVRLNUVqeEkyRkViKzl4WnZIUE1kRGF3cCtMdUYrMU5kMHQ4?=
 =?utf-8?B?YjdVQWFvZnFzQk44R3B4Q3pud2ZJcGRieGVBT1l6UzF3UEFUcnNVV2lCVjJB?=
 =?utf-8?B?SjdWVHpJR2lKM2RybjFwWlZxNHV0U3ZoT3hKc242M09xNGRTdU1Ia1oxTERT?=
 =?utf-8?B?MjhmMlNkRGVVbFFQUDBTNlI4YkVRb25WaFA0bnQ3Rm1JREJldmNjTWVYUlcz?=
 =?utf-8?B?bnlZMEkyRmxhdTAvd2dTa2NENnRUa3VncGxRMkNTQTVhaTQ1Y2p5UVVNbVFa?=
 =?utf-8?B?TTg2M2Rwc0dTblBxMUNZZW1aSkc1QUdHSENDRE1HVW5qY0NzV1dMS3Jwek80?=
 =?utf-8?B?K1lGYUJObTdOYzFjYXU4WWxiTXMvNXZDMTlUcVhKd2xid2JjRWt2VU5MRVdv?=
 =?utf-8?B?ZkxqRXBKUzNvU1JQRGhtVlJYS0tEdEh5dFIzbGZ4Ti9MNjV4Ly80NnVrdTdG?=
 =?utf-8?B?WlRxMUFlSjM1S1pKdlRQYmk1OVJSM25oYjFaRjA3bDNiRVFSVUxOVENQZTFi?=
 =?utf-8?B?QnhkQ2tVVnAxcVhudHRhNWZrNnRDSVVuMEVqbThZblZTWFlWZnlobEVsZC8y?=
 =?utf-8?B?RzF3clVOcHZHZGcxT0oybm5HUkR1bzRqQWYwS3haQkJRUDc5VE83US9pejVX?=
 =?utf-8?B?b0hGZjl3azZXSmYzTjEyVHNhdWhLTDBjbkFwTWswN1F1RkR2ZTJ5eGFnOW1p?=
 =?utf-8?B?WDJuU2JxU2tSVU1LUWRwb1RpcjFobFpBSnVEaGt6L1lKUmpzd1NWQU8vQXVT?=
 =?utf-8?B?ek9oTitRdVljR0ZDbHdoZ1JEOUNPbEtkajJxVDUxVzYxT2hZY0ZzY1ZIK1hB?=
 =?utf-8?B?blpMSmhDYmo1aEpIb2ZLVW5YUmd4NEJGSmk3cEhoSUlBQzVVV2hHazhOamd5?=
 =?utf-8?B?OTBlejRMazBpakJoYmE4Z1gzZFNpcjd3VGhuQ3pMUzd2ektnS0prSWU1MkhE?=
 =?utf-8?B?RVljdU1keGRuS3dzOVlkZ1ZTeXByMERKTGlvVWFYc3ZuWnpyNFdUT0dQdlZs?=
 =?utf-8?B?OXYxanJROEM0REVoMEVTdW1lK2FhT3dUT1ZraTVwS1E2Y1JIRUVMVnRiZzZk?=
 =?utf-8?B?TnZLMWtRTlF5SjNlNk85QT09?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR08MB5852.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9535
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:102:8e::21];domain=PR3PR08MB5852.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509E4.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	93595cde-8647-46c9-e807-08dcc2a30fee
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|35042699022|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SUE0TUJ5RXcwdTVtQkZ1aXRQbzdJQ3NZd2Zic2lhSXprZDZhMCs2dE0vYTR2?=
 =?utf-8?B?R3JvcjVBZWtOdTR4UCtRcXRuUXdmK0FodXpoRkpRa29vSHB2Yk9lSzVpK1c1?=
 =?utf-8?B?RDhnYmtoV0lFZ2VIekxDdzdDKzh5TkU2MFdvN0pjZ0pzbXRuTUcyNUNQbzJ2?=
 =?utf-8?B?UTRwanJHZVpRdTBuNUNRZ0pUKytCa2wvZ2FFMGZsMW5sckdleXpablozZ1pC?=
 =?utf-8?B?ci8wVmpTR0pPbjVSN2dmRUpwMEZKVG1JREt3elc4cjJMRWdJbXNDMHlQK0xJ?=
 =?utf-8?B?a29HNmtUSGNxN3BRY01WZDFRQkhyZEFCcVVEYlVPMThBellWMFM2TlJFSFJj?=
 =?utf-8?B?WU1sYUtZS2tmdXNRdU56bjk5S211aWw4MzZQUi83YjNtd1hJV1VyZG9aZlJ3?=
 =?utf-8?B?SFh5aWY5QzlSa2pqNmF3aXZTR0ZpaVluR1pNOExkQ2xCVnUydHdyTFl0Z3or?=
 =?utf-8?B?cCtXYXBxL1U5ZWZkaGZ1cFh4ZVBGMkpNc3ZjQkhuWDZ6L0xpWGNkUUlnTmFI?=
 =?utf-8?B?TkxGenpDOEIrNVJzQmRVbjhaTElZaldlN0JpZ0I4ZGlCWFJNODF0VG4wRm5B?=
 =?utf-8?B?UE04SWtaTFVXNTJraXlVOExVVW01MUs4ZzdHSEplc01rbnBrVVZlWjdSYXY2?=
 =?utf-8?B?VTBDYVd5REd5ZlBONTdnMzZTckk3MnlsaVphdHgzSURGL2dMTUZFTy85cHc3?=
 =?utf-8?B?TUhFK3JEeThOYit4UjdGSzM1MVY1Wnhlb255Ynd4S24yWFBCM1I0dGYvU3c1?=
 =?utf-8?B?b0M3Q1E5S1ZsYkZBSnVrdU5OMFlBODl0ZUFvcUYvdkRVTEdmTENHVVVYZjlp?=
 =?utf-8?B?T08yU0l5QnY4N2lteTgyREFLMXVDTyt6QklFYVpaY1p0MzdDbUcwL2UwejUz?=
 =?utf-8?B?U1FaOVJ3Q0JXZGpoZXYySXJKVDY5U2pLcEpSNHZIaER5ZVg3b0pIVGg5aFAr?=
 =?utf-8?B?S2cvdVJPQStxZlRIeWJ0OWszVXN1Wi8rMGJJUHBseVk3TWk5WUFzSy8zSk5U?=
 =?utf-8?B?dmd6UmRORE1lNWxtdDBybWJsVnR4YkhMZ1dRNU1wQXdmcTBYa3NOR0djbUww?=
 =?utf-8?B?NGVOdmtZelJZNjlXdGRUN0QwUG82QkZBbVZERFRsSFhVay9kb2NhUU9lOUxQ?=
 =?utf-8?B?MXlJQ04yZFk4U1A0T0s5QlZ0Q3UvS0dFL1VzSEZobzMwZjhiY0o5UDZjWVRK?=
 =?utf-8?B?VFV1UDhMMmVuVFlwQXlxbU9wQUpsZGpXNnc4cDB3S1ViUk52dmhZeCtVRTZJ?=
 =?utf-8?B?MHUyL0dFQko0c21ocWxhcDFZWVB2cys4Ry9JajRZYkk1ZXdzOTg4MFlOc1BN?=
 =?utf-8?B?U3NpRFZQUjRhT0xRaC9pbUp0b1h3eXFKdnBLU25hRGw1K1AwYXU2dmQxZjA5?=
 =?utf-8?B?c3pSV1kreHZqQmJOeDM4R1RzRDBJeG1OMzAwUFJEU2hWR3h1UHU4Z1lBQSsw?=
 =?utf-8?B?M3FqUDhMR2d6V09BMU9qenBkK3AyR2dFQjIzTFZ0ZXVmclFCNDZrY0xoMm81?=
 =?utf-8?B?NFNpU2p3bUFvMXY4YWo5TnlSbE1IOGNhSHdQdit0eFhzbmxSaUFkTW0wK2gr?=
 =?utf-8?B?dFdZV2hnZksrZGNzelIzM2ZqLytGUVBxTFBHZGpqby9oSDVZT1p2Sy9VV2dO?=
 =?utf-8?B?SzkvMjZ1SmlDaFJJQ0pGWTNjZUZlem1ZN01Ja0pYaWQxSmd6dmhPbHVEUVN4?=
 =?utf-8?B?WWhzalo4TnFDNUJBd3BKcWpGV2xNcjV4ZGM0SjkxVk1raHFSWkZHck5PMFRh?=
 =?utf-8?B?N3hGcGUvQXBnOUNHU0JyTjNwQzNZSVpnMG4xTlNSQnEzSVQ4SVgwM21CL0N1?=
 =?utf-8?B?Yk5qM282WmlxTG4xUG5ibW4wUkZKUXlzZVJaSTBmdVlyRlkxRWNLQ0VLTmpM?=
 =?utf-8?B?djJicGNtTHc4c2xHN3VHeVhnSTlqZlhWSzcyRWp4ZkI4bk9IMzZ6a1V3T1cw?=
 =?utf-8?Q?vz9So4+K3hrTB8gIpW2al1rQe6ZTV2UN?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(35042699022)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 12:08:13.1350
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0471201a-5a54-4312-b740-08dcc2a318d4
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E4.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6649

Vincent,

On 8/22/24 11:28, Luis Machado wrote:
> On 8/22/24 10:53, Vincent Guittot wrote:
>> On Thu, 22 Aug 2024 at 11:22, Luis Machado <luis.machado@arm.com> wrote:
>>>
>>> On 8/22/24 09:19, Vincent Guittot wrote:
>>>> Hi,
>>>>
>>>> On Wed, 21 Aug 2024 at 15:34, Hongyan Xia <hongyan.xia2@arm.com> wrote:
>>>>>
>>>>> Hi Peter,
>>>>>
>>>>> Sorry for bombarding this thread in the last couple of days. I'm seeing
>>>>> several issues in the latest tip/sched/core after these patches landed.
>>>>>
>>>>> What I'm now seeing seems to be an unbalanced call of util_est. First, I applied
>>>>
>>>> I also see a remaining util_est for idle rq because of an unbalance
>>>> call of util_est_enqueue|dequeue
>>>>
>>>
>>> I can confirm issues with the utilization values and frequencies being driven
>>> seemingly incorrectly, in particular for little cores.
>>>
>>> What I'm seeing with the stock series is high utilization values for some tasks
>>> and little cores having their frequencies maxed out for extended periods of
>>> time. Sometimes for 5+ or 10+ seconds, which is excessive as the cores are mostly
>>> idle. But whenever certain tasks get scheduled there, they have a very high util
>>> level and so the frequency is kept at max.
>>>
>>> As a consequence this drives up power usage.
>>>
>>> I gave Hongyan's draft fix a try and observed a much more reasonable behavior for
>>> the util numbers and frequencies being used for the little cores. With his fix,
>>> I can also see lower energy use for my specific benchmark.
>>
>> The main problem is that the util_est of a delayed dequeued task
>> remains on the rq and keeps the rq utilization high and as a result
>> the frequency higher than needed.
>>
>> The below seems to works for me and keep sync the enqueue/dequeue of
>> uti_test with the enqueue/dequeue of the task as if de dequeue was not
>> delayed
>>
>> Another interest is that we will not try to migrate a delayed dequeue
>> sleeping task that doesn't actually impact the current load of the cpu
>> and as a result will not help in the load balance. I haven't yet fully
>> checked what would happen with hotplug
> 
> Thanks. Those are good points. Let me go and try your patch.

I gave your fix a try, but it seems to make things worse. It is comparable
to the behavior we had before Peter added the uclamp imbalance fix, so I
believe there is something incorrect there.

