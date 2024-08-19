Return-Path: <linux-kernel+bounces-291831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 686CB9567BC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 12:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E52EC1F22A6B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 10:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85961586DB;
	Mon, 19 Aug 2024 10:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="S0IhnirY";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="S0IhnirY"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2057.outbound.protection.outlook.com [40.107.104.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED9B13C81B
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 10:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.57
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724061729; cv=fail; b=U0xwqBukXK93BxPpoVg0i5LF127N6aCX61OncoVP2BQ+eGAwW296p39g7caDNJecVk3GlciWbUUggrCzh+Kob1CvpOhWDpPawYgAmqirhyjBl7Gz40wIhtGt9OIh2RXh3IjMGpJY7hs/UhARrtrkWG5R7NVoCBldrnX37C5k/UU=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724061729; c=relaxed/simple;
	bh=GoeHLiXd/3NNODAA4sNbtn62xFffgFzYhjp7vksX8p8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SmiBB4fB37xJkrKNPJc2r2wafuInAnYUACGjOO42u98d3jKvOAsRT45Q08lWEsS+TdN8AxtiB/Uc6BVsH8A6qWB4horVvSX+TeN786jXvgMQ9rXAtZcgbgRuqkwLdU8xxeKonCMsX9NX6SaGSxqI7kjjlOQAQ7qeE34o1SZZ4KU=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=S0IhnirY; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=S0IhnirY; arc=fail smtp.client-ip=40.107.104.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Fs0kSefJwspRlzu+OaR7ywsSCVnTrb5B0J3pAltL1GIV3sPbECSK8XcB02tRb4W8XCgHH3AXos81IPAgHNuBxE52+hVHLXaE26iNC2RIha004xjBV3UrorpoesGzCAyPulHqlmu3xf/YJQBr3/aP2BG0T5sCgPtSnD7eIog1lp3pGa45nRLCNe4HD5T14KKjC/HaoL7noYcACfOwtPgajubprJLKO11vcbYw59P96tztai4fLb5c7kmc6pW/C1EPuWLqW5zmdTdSRRBF2aD0H6vrHnlBy15RJJOWluK0/Cwlx4BiXCHisD9PbZ5tBD1ahiOo2YlIYjiAV7sO9kOOyQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/KK47f8ygZiRIA9+JMD35Uzt/44g1Dt4CIs80S9XE8=;
 b=tUKRka5JUSKwQLzyZbUI42nOS6b2oMdw3GEeEGV8kV3ZxCMmHrK4nalX1jDbyl9kUnMI5Z6LEwkhTerRAuVmyppfT9mgLzgonfGXTieOW1fuzMtW7nNnMSXS6RYKyK+wqfxahKa5H5pPq9m857nuKphbCWAiTcuwcBbt4VKKz4iCEOiBG2rps3QwzQIpnE+SyEORQNgQ8X/6vkPU2OdN373z/9mt+xKUBDZRpYVEMzNYiZySiAt0MVnRBRDhJlMzRF3jApV9b1/eqwPdDzNkRfFi1BFn/DboRiBcgE8EdgZmt2ajdDLQOKJyu9EV+i6c0Azj8Nk8iIS9bcfhCv9vrg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/KK47f8ygZiRIA9+JMD35Uzt/44g1Dt4CIs80S9XE8=;
 b=S0IhnirYExIvQ8ExGBvJhcthg0TyU66dflTkSi7LOMCzb/HSqb73S7QNlnhTsd6+49xQ5msTq73jy1aa2qM0r9sqyu6I7PTPVKQdLnwYbqQoQPVyA4jwcO6TIJE4Qw6xQzmEOQFCTS7SUENiz8kY9r2kq3Wcn7tIgReai+JHQVA=
Received: from DUZPR01CA0081.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::6) by PAWPR08MB10211.eurprd08.prod.outlook.com
 (2603:10a6:102:366::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13; Mon, 19 Aug
 2024 10:01:59 +0000
Received: from DU2PEPF0001E9C0.eurprd03.prod.outlook.com
 (2603:10a6:10:46a:cafe::e5) by DUZPR01CA0081.outlook.office365.com
 (2603:10a6:10:46a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Mon, 19 Aug 2024 10:01:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DU2PEPF0001E9C0.mail.protection.outlook.com (10.167.8.69) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7897.11 via
 Frontend Transport; Mon, 19 Aug 2024 10:01:58 +0000
Received: ("Tessian outbound 3d5aa05142a5:v403"); Mon, 19 Aug 2024 10:01:58 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: cca3f6c3bb1affdf
X-CR-MTA-TID: 64aa7808
Received: from L53c31e129229.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 0127C512-7F5A-49B3-A05B-EE1E5E7FF74D.1;
	Mon, 19 Aug 2024 10:01:47 +0000
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L53c31e129229.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 19 Aug 2024 10:01:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=stiHa419axcwD4ENj2k6yEZBgwgyhAF13DtTikVgMqvRg5BfwHyEU4vxeF7r1QhRmxDdM5VxuV65GS46JlMX4SL94lDNUjG4k8O2vjGlWqqqKN55q5TnMc6nWwsv6OCBk2vbXoq8KSeqOlXBPZAyqFXGQ6K8sOXSAn9pn+YikMv7yXzLeaiwnSuUupaceFJNzi+dfmzhL2iFE1MVjW9fp23CDxUJtAFNU40w6KBOspyHeM17BVLFFfhnTPq/n3SOzcHCuLAXYS3qV/PbYpjyXmiOKGkw+j1lImYDkoXOQ2L1YfpyDwDxy5Y/dyixnkxJrzNDFxOgz6mg0pVkQiugow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/KK47f8ygZiRIA9+JMD35Uzt/44g1Dt4CIs80S9XE8=;
 b=ugB2B8lS/hU8ui76ne+C98V3Ynu2bA/85cnlT48QSlzxNYgg5SjBelJmA6XkSTCwvWQw1mYTOm7Yxf5am3K9BwTUfe1yACGDMbkACRYOHAIvYeBzF+C7NH/9YadWHRobePgpRyB4qPV4aMoSDs7oV54c4gPJemntevWg/rCJUrGW0HxB2tPac/A/xuj/My+mqMRUUyODlJy9QeMx2aRzygjeheXCNgQrMUy7jVqT3gBG9t22r1AKllwOMVaNjLnAs1bDfuLhcG4YwoTGbW10XV/3b746zirJWdOYTQnWFIYYtoT/qZhTE4PBvTxQ+UHe+g1lMJXNlna1fRPa7mY3Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/KK47f8ygZiRIA9+JMD35Uzt/44g1Dt4CIs80S9XE8=;
 b=S0IhnirYExIvQ8ExGBvJhcthg0TyU66dflTkSi7LOMCzb/HSqb73S7QNlnhTsd6+49xQ5msTq73jy1aa2qM0r9sqyu6I7PTPVKQdLnwYbqQoQPVyA4jwcO6TIJE4Qw6xQzmEOQFCTS7SUENiz8kY9r2kq3Wcn7tIgReai+JHQVA=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PR3PR08MB5852.eurprd08.prod.outlook.com (2603:10a6:102:8e::21)
 by GVXPR08MB10809.eurprd08.prod.outlook.com (2603:10a6:150:158::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13; Mon, 19 Aug
 2024 10:01:40 +0000
Received: from PR3PR08MB5852.eurprd08.prod.outlook.com
 ([fe80::f44:d113:1c29:825d]) by PR3PR08MB5852.eurprd08.prod.outlook.com
 ([fe80::f44:d113:1c29:825d%3]) with mapi id 15.20.7897.010; Mon, 19 Aug 2024
 10:01:40 +0000
Message-ID: <f1a2c2d2-6ecc-4cb0-b54d-952a4fb700da@arm.com>
Date: Mon, 19 Aug 2024 11:01:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/24] sched/fair: Implement delayed dequeue
To: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, linux-kernel@vger.kernel.org
Cc: kprateek.nayak@amd.com, wuyun.abel@bytedance.com,
 youssefesmat@chromium.org, tglx@linutronix.de, efault@gmx.de
References: <20240727102732.960974693@infradead.org>
 <20240727105030.226163742@infradead.org>
Content-Language: en-US
From: Luis Machado <luis.machado@arm.com>
In-Reply-To: <20240727105030.226163742@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0006.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::20) To PR3PR08MB5852.eurprd08.prod.outlook.com
 (2603:10a6:102:8e::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PR3PR08MB5852:EE_|GVXPR08MB10809:EE_|DU2PEPF0001E9C0:EE_|PAWPR08MB10211:EE_
X-MS-Office365-Filtering-Correlation-Id: f8af0ff6-235c-4991-2452-08dcc035f6fc
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?czEyMjFyb29wYXhrZFNMcStxZWNDRHZiVUVjWFMxaWs1UWEzT1hzRVVlYlA3?=
 =?utf-8?B?a0dBSnBjZHZ2QVRBQzNlbTF2TnppOWJlbm5LV3NCellRSVk0M0FRTSszalEv?=
 =?utf-8?B?Qzh2VHFZVjBUSklSUWtCYTUvUzVKT21YK0I1MkNJSE54TFRheWxRZDZrdUcx?=
 =?utf-8?B?ckpGQ2dwR3VrVldXZVBIZ1RXNFhScmlQcjY2ajlIRU5TY0g5R0dqZU9GVHdi?=
 =?utf-8?B?cTVVekprL28wV0JHSzRRZm1Td2dMNy83ZkRMMDhjMGtNaHR5Mzc0UTJkQ1dp?=
 =?utf-8?B?TzRmbEg5MGVBZm1qSnZXeWk5Wmx2bHFIeW9rZ0QwT2VvZUF3T1phTjVCWlVO?=
 =?utf-8?B?K1Y0Z1VnNENSTjRiVG95ZElYS3hrNHdJSlZiOE1OTnNYcXBkVGk2ZzJRb2JQ?=
 =?utf-8?B?SFpjV28zNTY4SkJHT252MCtydDU0dEhWUFVnSnQwTmdSR3U0YU8yWit5R1Ur?=
 =?utf-8?B?amdCd20rSjA4OFFscDVXeTVpc0MvV3A4S1lRSHJNWWNZTmxTRUpSMFJ3NytS?=
 =?utf-8?B?ZnFQL0RtemFZc09IS2dnTUphTk1SeUJPTEJXVEZac0M0R000TCtRNnFSNXpW?=
 =?utf-8?B?R09PK1FXbzRicjdNOFBySDFKeGg5S081TkUrcVJJRnBVay9ydXk5YkoramZG?=
 =?utf-8?B?ekhwYWcwV2E0WkdoU25USHZSQWNpcXVSenJ1RUFqc1FnL3hJT1FYU3ZKRWJT?=
 =?utf-8?B?am1Fd2J2akc1OGtnRlZUUzMzTjBySmo1RGV2K0o1bWVQV0ZIUjNQSzY4d1g2?=
 =?utf-8?B?N0pvM0pKZjNobXFIRkFBR0x3clVuZVA5OE5lenV4eWhsWmUyWFppL3YrQ3V5?=
 =?utf-8?B?aFBjd2FVci9BOUpUVCtTNnRwSTJzODVWNU50L2piMGZTOCsvb3RJNmp5a3JN?=
 =?utf-8?B?TkFyK0RiTUExN0N0TU1qV0xndXh3bllQZC9tVkNhUE9GUVVCa0xkUEdhTEpJ?=
 =?utf-8?B?cnp5V2duMHF5UVdvOTMvUStSRGJWOUkrV0MwSU9vOVhLdkN4UEV1WlpIdjdj?=
 =?utf-8?B?bHNoeE1JRjdidjQrMTUzYWhTY0ZaRDU5eDBSYkxDdDJ1UTQwSjY0TG04WmJ1?=
 =?utf-8?B?RmdLeFJ1dUI5ODNoVWFpdXJvMU5GS1lZN2lFVUxHeEZhSHlVeWRKdXd2Qloz?=
 =?utf-8?B?SEp1aE9oMFFKRS9DUndaYW9aeHp6MEN6MnNLOGUvem5oQytkbFBRZXZLaS9U?=
 =?utf-8?B?dmp6ekdQeVNiSU13MlE2ZEZ6bXlKcHpTdVh5WmtGSzFsblp1REtTbi9aWEFk?=
 =?utf-8?B?N1hOTjJXQmIrcERlOVF3NGxrNk5lcFhyUzhSSUhTSkxXVC9JR3BhTk9rcHZD?=
 =?utf-8?B?NzlOWWtiYjJaVGQwNEI4aUtCZmp1Mk1ZMWpDOUVHZnpCN0Yxam0wQVZkbXZa?=
 =?utf-8?B?bkpHUTI2bE5yYWhuRUlwMlhDL3AwOTJwbG1pT0hNSzZWRjZ6VHVYN2lIRzlh?=
 =?utf-8?B?MFJDd0RwdXBnQjZjRUsveDNnU0JYL3ZCTkE2cTFrd01abXRGUy84TFZqOVFz?=
 =?utf-8?B?dWlNZ2FtUGIwZGZmRENxWU9Ya2pFNDhHa3RlZ3ROSnNYYVVHNmQ3UG9ncTJz?=
 =?utf-8?B?U283Z25LMkNyekFyejdJNEJNd2FDSlF3YTIzYUVhZFhpanVjVGxYQ1paSHFr?=
 =?utf-8?B?cGM5Sk1PSjhuQ0J1QUxvYWxYekR5N2J1RFpFaFR4STZMeW1ldFRjMnVhTnhX?=
 =?utf-8?B?S3hpZkFkUmNBUXVFVHV1L2JYcDBWek15MUt2T0dqbisxWnlEWDd5bXY4UU42?=
 =?utf-8?B?UURLVWlzcm1jd2wxclIrWE1KRmdDSlhjOHlSU3pRTTJQY2RPUFhzRTJQeG5I?=
 =?utf-8?B?TmMvTG1sa1BSbjB3RjVHZz09?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR08MB5852.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10809
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:102:8e::21];domain=PR3PR08MB5852.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF0001E9C0.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	98282fc8-24a3-45e8-5561-08dcc035ec0a
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|36860700013|1800799024|82310400026|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bWVyeFNJdXFTaldOb0R5SVg3Z3J2Um9Wd21SenBsWmEzSWpKMTRramdWT3JC?=
 =?utf-8?B?RUR1Wi9GRHZGUTE1TUs3QmZ1R2NUT0wzYXBDWk1GUDZDQTgzZkNqUkVHenRU?=
 =?utf-8?B?UXZmMGE1M2xGME9IMitPRGJFWEpNbnpBQTYyR0M2S3FTQ3IxSmhzN09wU1l0?=
 =?utf-8?B?UXJwbDZKbmJVOXZsK1RXNjlyZDA0WXV2UVVLU0VWQnh5UUgzNUxOcGJmQmgv?=
 =?utf-8?B?ZXhnNHVaQ1piQjcyWGQzMko5VmtJcEd2TGVSNzB1aWhuZnp5QVh4VEpNZDNp?=
 =?utf-8?B?UVlMRk5DaWFUeFVZQ0RxTm5mcUpETlJTZE9UUDJjU2RqNkNHWUpoaFByYTRK?=
 =?utf-8?B?RnY2SXlCRGhxeUZjdVRYSk0xUmlSSFUvaUxRdlB1NGhENzExRVVGOWp1TVRs?=
 =?utf-8?B?cUMxS3BiMnlOTHNmVmJlaXBBbzRORHVFbGphTDhCQjNYNUduMlZGWGtSVTNI?=
 =?utf-8?B?Vk10MXRWREFBN2ZSTFMzM3NEQytjREZJOTI3NDdMc015WCtkZ3A5SHJBeVMr?=
 =?utf-8?B?bWlab1kwbjJoRG82b0xObjRjbVZkNDRhRjVwSXRLMlBpMUprTDRENUlMWGFK?=
 =?utf-8?B?UWM4Rks0M3J4N2ZMUHdxQWxyendDeEFvWTNSUlFTdDA5dUIrRFlTUkxVek84?=
 =?utf-8?B?SXZKa1RSdkVNQ3AzRGlLMDZ5cTN6VUlQZXZMSUVmRWpWYmZ1alVIYVlpNmpI?=
 =?utf-8?B?Qk94elBEVDJXb0YraWoyV0xPVmM1ZG5WVlpsNW03TWNnR3VFTWRQdmRaSncx?=
 =?utf-8?B?RG5vNmtRZjVMaVk4VURQeXU1aHdsdU84VXVBN29CTWQxVnprVXFnRTIrU1h4?=
 =?utf-8?B?Mi9qeW94MFJ3dGc1R01QaHQ3VmNBSnNtaVcydCtvN1IxRlRCcGtaSGxvMnJ0?=
 =?utf-8?B?aG5mOGFZak15WHI3MFlWMWhGNWh1UnRJQVJiUk9EYzFxcEtXYWg3ZlluNTJj?=
 =?utf-8?B?ZitmKzhaWXFJcnhYVnhzT0dYOFZOZlBvVFNkZTdDZnFIQWhxUkpFNEhZVXEw?=
 =?utf-8?B?K2RiV0xraDJtcEJ1cGRLQjM4UzZIK0tQNWZUdWVERFJxZ3RtcDJ0UTNPcWhG?=
 =?utf-8?B?ZHY5d1lLMFp1MnluR21JaHFHeDBGNnVleVBabFVLVUdMbDMwcW5uNWEwZm9m?=
 =?utf-8?B?UDRqWEtacjMrSldXZHlkMVd5bHRxbWhQYXYrZ2orSHBJVUZhQ09FVko3Vm5m?=
 =?utf-8?B?TmVES3NJRUxoVlNjS3V3VjNIUjBGQWhOYXpqb0ZuUk1GSEVJY1kvVTcxblBs?=
 =?utf-8?B?QlBBRlNFZEphell1U2Z6YmVmWFBCYzEyeFFJbzliTFkzdFhwejJONzdrdVFU?=
 =?utf-8?B?aUR4TENFekthVzB3aklPcEo2QmxJQ0F6bWlxYzdNK2JqUEU3M0Z1RDJhdEIv?=
 =?utf-8?B?U3RXZ1Uxc2w1L2pJaDZYMUxkL1hvaUFpWFNaVzNZRGJWaWtyZWg1WDUrRlIv?=
 =?utf-8?B?SmJVN0ZVb0paM0xYdjZQaWxBMVZtamVzWUxaclR4TklWTmcvdlE2UzVkM25z?=
 =?utf-8?B?VnR4T0dHNEZyQW9pM3dWNEUxMlV1NXoxSG1ZcEN4NXJUNmIxWHVERHdGUVhD?=
 =?utf-8?B?Ky9GNnlvcm5mYkM3MnNPemFvdkN4SE8vUzJNUENKY2RHSTBzTTBNMXZkcG80?=
 =?utf-8?B?Mm5ZOURVSXlvWFJpMFJwQ0t4M1BBTy8wZDBSTnZ5Q0pNYVhTNGV5UEd3a3Zs?=
 =?utf-8?B?Wlh5U2RCREZaUzVFcXFxUmJWSUNzM2ErWTVDcXZDcllmUG5QbDNqYUFDeEhR?=
 =?utf-8?B?RmNmVlZyQkNtaEszdU9mZGo4NzdDaWVFaFpxdkI4QS9BelB1QjJjYktNSU1T?=
 =?utf-8?B?c0V3cjVIMm1vUXpiYkgwakJ6TGpCS2VvNmxjWXJkbXVrQ2t2K3NyY2l1UEQ1?=
 =?utf-8?B?UHhHeVJ2NXdYSnpnbDhxRk5wZjYwSXdDUThIaHRqTlY0aEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(35042699022)(36860700013)(1800799024)(82310400026)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 10:01:58.7880
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8af0ff6-235c-4991-2452-08dcc035f6fc
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9C0.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB10211

Hi Peter,

On 7/27/24 11:27, Peter Zijlstra wrote:
> Extend / fix 86bfbb7ce4f6 ("sched/fair: Add lag based placement") by
> noting that lag is fundamentally a temporal measure. It should not be
> carried around indefinitely.
> 
> OTOH it should also not be instantly discarded, doing so will allow a
> task to game the system by purposefully (micro) sleeping at the end of
> its time quantum.
> 
> Since lag is intimately tied to the virtual time base, a wall-time
> based decay is also insufficient, notably competition is required for
> any of this to make sense.
> 
> Instead, delay the dequeue and keep the 'tasks' on the runqueue,
> competing until they are eligible.
> 
> Strictly speaking, we only care about keeping them until the 0-lag
> point, but that is a difficult proposition, instead carry them around
> until they get picked again, and dequeue them at that point.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/sched/deadline.c |    1 
>  kernel/sched/fair.c     |   82 ++++++++++++++++++++++++++++++++++++++++++------
>  kernel/sched/features.h |    9 +++++
>  3 files changed, 81 insertions(+), 11 deletions(-)
> 
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2428,7 +2428,6 @@ static struct task_struct *__pick_next_t
>  		else
>  			p = dl_se->server_pick_next(dl_se);
>  		if (!p) {
> -			WARN_ON_ONCE(1);
>  			dl_se->dl_yielded = 1;
>  			update_curr_dl_se(rq, dl_se, 0);
>  			goto again;
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5379,20 +5379,44 @@ static void clear_buddies(struct cfs_rq
>  
>  static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq);
>  
> -static void
> +static bool
>  dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>  {
> -	int action = UPDATE_TG;
> +	if (flags & DEQUEUE_DELAYED) {
> +		/*
> +		 * DEQUEUE_DELAYED is typically called from pick_next_entity()
> +		 * at which point we've already done update_curr() and do not
> +		 * want to do so again.
> +		 */
> +		SCHED_WARN_ON(!se->sched_delayed);
> +		se->sched_delayed = 0;
> +	} else {
> +		bool sleep = flags & DEQUEUE_SLEEP;
> +
> +		/*
> +		 * DELAY_DEQUEUE relies on spurious wakeups, special task
> +		 * states must not suffer spurious wakeups, excempt them.
> +		 */
> +		if (flags & DEQUEUE_SPECIAL)
> +			sleep = false;
> +
> +		SCHED_WARN_ON(sleep && se->sched_delayed);
> +		update_curr(cfs_rq);
>  
> +		if (sched_feat(DELAY_DEQUEUE) && sleep &&
> +		    !entity_eligible(cfs_rq, se)) {
> +			if (cfs_rq->next == se)
> +				cfs_rq->next = NULL;
> +			se->sched_delayed = 1;
> +			return false;
> +		}
> +	}
> +
> +	int action = UPDATE_TG;
>  	if (entity_is_task(se) && task_on_rq_migrating(task_of(se)))
>  		action |= DO_DETACH;
>  
>  	/*
> -	 * Update run-time statistics of the 'current'.
> -	 */
> -	update_curr(cfs_rq);
> -
> -	/*
>  	 * When dequeuing a sched_entity, we must:
>  	 *   - Update loads to have both entity and cfs_rq synced with now.
>  	 *   - For group_entity, update its runnable_weight to reflect the new
> @@ -5430,6 +5454,8 @@ dequeue_entity(struct cfs_rq *cfs_rq, st
>  
>  	if (cfs_rq->nr_running == 0)
>  		update_idle_cfs_rq_clock_pelt(cfs_rq);
> +
> +	return true;
>  }
>  
>  static void
> @@ -5828,11 +5854,21 @@ static bool throttle_cfs_rq(struct cfs_r
>  	idle_task_delta = cfs_rq->idle_h_nr_running;
>  	for_each_sched_entity(se) {
>  		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
> +		int flags;
> +
>  		/* throttled entity or throttle-on-deactivate */
>  		if (!se->on_rq)
>  			goto done;
>  
> -		dequeue_entity(qcfs_rq, se, DEQUEUE_SLEEP);
> +		/*
> +		 * Abuse SPECIAL to avoid delayed dequeue in this instance.
> +		 * This avoids teaching dequeue_entities() about throttled
> +		 * entities and keeps things relatively simple.
> +		 */
> +		flags = DEQUEUE_SLEEP | DEQUEUE_SPECIAL;
> +		if (se->sched_delayed)
> +			flags |= DEQUEUE_DELAYED;
> +		dequeue_entity(qcfs_rq, se, flags);
>  
>  		if (cfs_rq_is_idle(group_cfs_rq(se)))
>  			idle_task_delta = cfs_rq->h_nr_running;
> @@ -6918,6 +6954,7 @@ static int dequeue_entities(struct rq *r
>  	bool was_sched_idle = sched_idle_rq(rq);
>  	int rq_h_nr_running = rq->cfs.h_nr_running;
>  	bool task_sleep = flags & DEQUEUE_SLEEP;
> +	bool task_delayed = flags & DEQUEUE_DELAYED;
>  	struct task_struct *p = NULL;
>  	int idle_h_nr_running = 0;
>  	int h_nr_running = 0;
> @@ -6931,7 +6968,13 @@ static int dequeue_entities(struct rq *r
>  
>  	for_each_sched_entity(se) {
>  		cfs_rq = cfs_rq_of(se);
> -		dequeue_entity(cfs_rq, se, flags);
> +
> +		if (!dequeue_entity(cfs_rq, se, flags)) {
> +			if (p && &p->se == se)
> +				return -1;
> +
> +			break;
> +		}
>  
>  		cfs_rq->h_nr_running -= h_nr_running;
>  		cfs_rq->idle_h_nr_running -= idle_h_nr_running;
> @@ -6956,6 +6999,7 @@ static int dequeue_entities(struct rq *r
>  			break;
>  		}
>  		flags |= DEQUEUE_SLEEP;
> +		flags &= ~(DEQUEUE_DELAYED | DEQUEUE_SPECIAL);
>  	}
>  
>  	for_each_sched_entity(se) {
> @@ -6985,6 +7029,17 @@ static int dequeue_entities(struct rq *r
>  	if (unlikely(!was_sched_idle && sched_idle_rq(rq)))
>  		rq->next_balance = jiffies;
>  
> +	if (p && task_delayed) {
> +		SCHED_WARN_ON(!task_sleep);
> +		SCHED_WARN_ON(p->on_rq != 1);
> +
> +		/* Fix-up what dequeue_task_fair() skipped */
> +		hrtick_update(rq);
> +
> +		/* Fix-up what block_task() skipped. */
> +		__block_task(rq, p);
> +	}
> +
>  	return 1;
>  }
>  /*
> @@ -6996,8 +7051,10 @@ static bool dequeue_task_fair(struct rq
>  {
>  	util_est_dequeue(&rq->cfs, p);
>  
> -	if (dequeue_entities(rq, &p->se, flags) < 0)
> +	if (dequeue_entities(rq, &p->se, flags) < 0) {
> +		util_est_update(&rq->cfs, p, DEQUEUE_SLEEP);
>  		return false;
> +	}
>  
>  	util_est_update(&rq->cfs, p, flags & DEQUEUE_SLEEP);
>  	hrtick_update(rq);
> @@ -12973,6 +13030,11 @@ static void set_next_task_fair(struct rq
>  		/* ensure bandwidth has been allocated on our new cfs_rq */
>  		account_cfs_rq_runtime(cfs_rq, 0);
>  	}
> +
> +	if (!first)
> +		return;
> +
> +	SCHED_WARN_ON(se->sched_delayed);
>  }
>  
>  void init_cfs_rq(struct cfs_rq *cfs_rq)
> --- a/kernel/sched/features.h
> +++ b/kernel/sched/features.h
> @@ -29,6 +29,15 @@ SCHED_FEAT(NEXT_BUDDY, false)
>  SCHED_FEAT(CACHE_HOT_BUDDY, true)
>  
>  /*
> + * Delay dequeueing tasks until they get selected or woken.
> + *
> + * By delaying the dequeue for non-eligible tasks, they remain in the
> + * competition and can burn off their negative lag. When they get selected
> + * they'll have positive lag by definition.
> + */
> +SCHED_FEAT(DELAY_DEQUEUE, true)
> +
> +/*
>   * Allow wakeup-time preemption of the current task:
>   */
>  SCHED_FEAT(WAKEUP_PREEMPTION, true)
> 
> 
> 

Just a heads-up I'm chasing some odd behavior on the big.little/pixel 6 platform, where
sometimes I see runs with spikes of higher frequencies for extended amounts of time (multiple
seconds), in particular for little cores, which leads to higher energy use.

I'm still trying to understand why that happens, but looks like the utilization values are
sometimes stuck at high values. I just want to make sure the delayed dequeue changes aren't
interfering with the util calculations.

Unfortunately the benchmark is Android-specific, so hard to provide a reasonable
reproducer for Linux.

