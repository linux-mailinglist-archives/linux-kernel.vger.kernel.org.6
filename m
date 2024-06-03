Return-Path: <linux-kernel+bounces-199646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBF48D8A34
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 21:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84F2928DBAB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 19:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B245240877;
	Mon,  3 Jun 2024 19:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="pQTwYzXb";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="pQTwYzXb"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2078.outbound.protection.outlook.com [40.107.21.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C8C374EA
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 19:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.78
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717443077; cv=fail; b=c7h5U5YqidbaOk4n/Ds5AvkUReM+qIBkbgoVH9nhq/jri9gcdSWl8z/f68UC5XmqU7C6uqZEZvXVyv+7VhCL1iyqxa7CMpOYciTATMye2HdFDF1ZFhnvetEBYHOZ8Eo0mc/nwF6PymcNgNX2qwOCR8xjf94SN2GKnbdDUyxm4Yg=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717443077; c=relaxed/simple;
	bh=PNGg0nv69YMtDxMSWQc0H1ZoOrEp3qN87gTSEL6Z1NQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LDfoRnIdm0l+yGMdt8EcXj5Dj7q560ZeJqs3B1bEu6LryRrqFb4sUjeX1hCgP49A0sfgWppKxKU2kkK6OfI8bi5GfjkXas4lSyYio9rr3wRqed78+3xjT2hyOJh41N+sDLk6azTkylkHDhO4blTP7WSNgUURcRFrh0NAG7Laie8=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=pQTwYzXb; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=pQTwYzXb; arc=fail smtp.client-ip=40.107.21.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=RMsZrKKVzGrJaZixYWm4GNHJcjjOgJyZkBpsalhpzXp6Y4P3rEvodhyV2hyxBfy4ST1Cls5lS4NgfMZHzBIPhCPGdPyMyX0FO1BB8FlLJb5iVeSYjzeEXhQ6ECeaaLoAAD/RJa6O7/ui1W9qYHR6WUii8npFhKnaxuz6sPIpjREd3yI1pe6GOYyZYIJVkUs4v2rsvSs249uLblj+JW/obBhEcVQSkEu41w58fRXh+FCVIns5ZwtwsyeTSNpHd0ooNmUiJrcBdkTWZrtiz6SDFB4pqueownJRsS9YT9AYjkZWag39gP/YtCknNQcNMNWhsFSW83Zqide6swHvk0wFaw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+kL/4yOwp3wNl+lTBK9Ars1MYv3IvNem/2kouGGFLM=;
 b=XPCrMZzq62fg4x3e+6DrvN/AxJRzlOE4rH+hFZonwr+qyE/dj7kCIngGqTPZPccUwnWpSY2vbd4vLiHFAPrTLKVVBiTQ7pQCJnX7pdd97VrDRNt5xXdPUqlSgwpfLTIuUPWcyQ69uRzvSg1Yz9lFaIeg/eevKXRmiRSLlMqBd+CvHLRBIaJhdflyK5c71+C/oBogQlfry5UFRg1MXWwEgfiBTYqfAzKNtkepSNhPiYGFbYkbh/NH9aryEgpAbnjEe5UwFwA1+Hvvv3oJiu4cR6LaVXNjgMRFibts1TSd9OyV1uSgHMBpZ9mADyF+0tOoQI0tsdy8wfOjD2MMEBpDHw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+kL/4yOwp3wNl+lTBK9Ars1MYv3IvNem/2kouGGFLM=;
 b=pQTwYzXbL5r0GSJKcXmzbUv0KIkNNloYXLqwRXbJ3AJlJKKBthUOS9CIWxEZF1eyso5AsiL/LvKWt8OgFvxp399/2yIzPHIHPGDK3E1TPFGH9jnBVBT7Vbaf7xREkXEyhOqmBKm0Ki/pFGmQMf4z48AXXYSoxD2ug46lwr5CvZc=
Received: from DUZP191CA0021.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f9::25)
 by VI1PR08MB9959.eurprd08.prod.outlook.com (2603:10a6:800:1c1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Mon, 3 Jun
 2024 19:30:55 +0000
Received: from DU2PEPF00028D06.eurprd03.prod.outlook.com
 (2603:10a6:10:4f9:cafe::a1) by DUZP191CA0021.outlook.office365.com
 (2603:10a6:10:4f9::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.29 via Frontend
 Transport; Mon, 3 Jun 2024 19:30:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DU2PEPF00028D06.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7633.15
 via Frontend Transport; Mon, 3 Jun 2024 19:30:54 +0000
Received: ("Tessian outbound a0025cf119c5:v327"); Mon, 03 Jun 2024 19:30:53 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 08a772b12ac01972
X-CR-MTA-TID: 64aa7808
Received: from b3142c94d371.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id AEE7AC73-BD33-47F6-BA4B-0BB385C1BD50.1;
	Mon, 03 Jun 2024 19:30:47 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id b3142c94d371.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 03 Jun 2024 19:30:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h4XOMjac7LRi8RqkU8z52KBErjstnrL2OtkYBYK3KrTRdR7XvdvSSOBQBJFEF5UgUYAvVvkRRZpUyPBEMX9Kv8WSIkm2C87Lj845CIDWyHGfj+IP5WD6L0OaFA4etl6oO8tysb1E0qymUddDJxjk01R8EJIy/zxE7PHWXlaeqttqe/hxH/aMyMHDgRQsiwZzHwcGQaMEPH0hOaYLV8Ma4/+znq53/BIRSDzQ9t0AWxH/FHsMSGmCSRgWg2nDdTieuaDKb0XSZwktpj15ExgMEBEwQ/e/a+iOuKUbL6gZOEtLuwanhI8pn6Zd9PVj67rk+7uIevesk48NZgJ8ukNpzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+kL/4yOwp3wNl+lTBK9Ars1MYv3IvNem/2kouGGFLM=;
 b=GGbjV6oBe8eG1wghkBJvJgx5uGSLE/7r8iEd7l7Y0pZPp0L95Y7NEYgx2Q1bqBEIXUmvfEjNBVn+25Sg4ukrpO0UWyAOKkE+o9sW5fbJwm/i/30UXZse3d2qk073AGxqdNrtJiau1Mi5lCpmCa5tMLs3gdI+BL3BKihGrFktKGnOTijm1g8d+T+LDs3na8pdtJgNMaW386aH8CG9yeu3cUktLnkzVgSJecRbZ10NNPT5CVyxOUv1pXJJFD3kvd+y/qP5NuWnKBJTt5oNborWb3a7NvI6xwiscSuHSsTcfu+QcxqgrGm99EMIUkuzebNcylrrQGK5ZyqXc72dcKppmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+kL/4yOwp3wNl+lTBK9Ars1MYv3IvNem/2kouGGFLM=;
 b=pQTwYzXbL5r0GSJKcXmzbUv0KIkNNloYXLqwRXbJ3AJlJKKBthUOS9CIWxEZF1eyso5AsiL/LvKWt8OgFvxp399/2yIzPHIHPGDK3E1TPFGH9jnBVBT7Vbaf7xREkXEyhOqmBKm0Ki/pFGmQMf4z48AXXYSoxD2ug46lwr5CvZc=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI1PR08MB3919.eurprd08.prod.outlook.com (2603:10a6:803:c4::31)
 by DU0PR08MB7485.eurprd08.prod.outlook.com (2603:10a6:10:355::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Mon, 3 Jun
 2024 19:30:44 +0000
Received: from VI1PR08MB3919.eurprd08.prod.outlook.com
 ([fe80::14e2:874a:b20b:78e5]) by VI1PR08MB3919.eurprd08.prod.outlook.com
 ([fe80::14e2:874a:b20b:78e5%4]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 19:30:44 +0000
Message-ID: <7eac0774-0f9d-487c-97b6-ab0e85f0ae3a@arm.com>
Date: Mon, 3 Jun 2024 20:30:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH 08/10] sched/fair: Implement delayed dequeue
Content-Language: en-US
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
 linux-kernel@vger.kernel.org, kprateek.nayak@amd.com,
 wuyun.abel@bytedance.com, tglx@linutronix.de, efault@gmx.de, nd
 <nd@arm.com>, John Stultz <jstultz@google.com>, Hongyan.Xia2@arm.com
References: <20240405102754.435410987@infradead.org>
 <20240405110010.631664251@infradead.org>
 <3888d7c8-660e-479c-8c10-8295204e5f36@arm.com>
 <1461277e-af68-41e7-947c-9178b55810b1@arm.com>
 <20240425104220.GE21980@noisy.programming.kicks-ass.net>
 <20240425114949.GH12673@noisy.programming.kicks-ass.net>
 <20240426093241.GI12673@noisy.programming.kicks-ass.net>
 <c6152855-ef92-4c24-a3f5-64d4256b6789@arm.com>
 <2fba04b0-e55e-41f4-8b7a-723734fe1ad2@arm.com>
 <20240529225036.GN40213@noisy.programming.kicks-ass.net>
From: Luis Machado <luis.machado@arm.com>
In-Reply-To: <20240529225036.GN40213@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0249.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::21) To VI1PR08MB3919.eurprd08.prod.outlook.com
 (2603:10a6:803:c4::31)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI1PR08MB3919:EE_|DU0PR08MB7485:EE_|DU2PEPF00028D06:EE_|VI1PR08MB9959:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a0cf31d-6611-4817-dfd7-08dc8403af60
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?bitGYmhjUWtueHBOb0lQdmppYk5NOWRPRTY3dzRIb1gyOUFCM1QxVFExZlVp?=
 =?utf-8?B?WW04RWhoUmNsRVJRbXVpQ2YydjdWRVR3dFZ5T3dSb2s5MTFhT3lUYlZiYW55?=
 =?utf-8?B?RTNHZHNVNzF2d0VQdTVjbnkzTHkydE4yVHNqRnVKK1NxUTY3a2pNREhuUmZa?=
 =?utf-8?B?eEJRZEFEYXI2SFQycXlhdEhQSW5OMFVrNFM1MDBhb3g0MHZxR0RWNzJVeXhJ?=
 =?utf-8?B?SEpKdDlWT25zaXNaazN2N1hUbjNQK2FMTGNtSDhTdWk2cFp0YkZFV3h1Z2F6?=
 =?utf-8?B?SHNXazhkcWJrMkZaOXkxOUluUXZIUFVkeTBwM1RTVHVLM3RoZ1hOMWdnb0tV?=
 =?utf-8?B?T2d5ZkF1UnJnNldkOHliL3RDaXBaM3ZFaFZlaWVEUjNlZ2hWb25UamJIVWJh?=
 =?utf-8?B?Q0ZMMVk0U1lhWFZNekx6U2NtUFh0Sk1hMzRxbjcvdXhSOWNsUjFTallUY1Rj?=
 =?utf-8?B?YTBCb1IrZHh2WWYzVGZaVFdXQUpXd3NtNDRnaG5UbitVRkJSNE9vb2pvZGVv?=
 =?utf-8?B?Q1IwS0hwL2lYRWlzYWRpZWRPTmpIRk0va3ZGaG9Dd3BtL1NhY2JtNTdWMjhh?=
 =?utf-8?B?T24wcWxSSVFWakVuQWVDM0dMMkFGdm9KU3FZZ2wwWnB1NVgrWUg5L1FTRlJX?=
 =?utf-8?B?ckZNSmllTmswcGwvQ1BBRndBQVBHUG1lb3d1NkNBcGwwNEhtU0pyUFJzMGhG?=
 =?utf-8?B?VmFSTVlsVmZKZnM4c05QUDlhUlRnYjYrSVlWOWJpV1I4amViSzNSR3RDWWo0?=
 =?utf-8?B?bWZvdHRXMWpWZTBYNVRyTUxLMFFMRkZCVnVkMXRBL2N5VW9RMWNDSHExcmhS?=
 =?utf-8?B?N1JxL1l4NlllNnQzSGlPZ09YaElRaEVDZDAxS244NnlUV3REaFVVY05UODF3?=
 =?utf-8?B?K2lPcmZCeXRzZjFqYnJtUXVJQkc3amcyT2NBRGhqM3BZNVQ5enRBR21ob2dK?=
 =?utf-8?B?b2VpbEd2VDQybWF6NEdqamdZbUhYT2dGRll5cThvZVRacXlmYWhxdzM0UWpm?=
 =?utf-8?B?dkVHYUE4QlB4aFVtMmFqVytJelgvNGYvZHNmWnJLUXpRVkR3UHQwdG5ETXZY?=
 =?utf-8?B?OFhFVFJyNGI5amhibmVlTlBFdjFJSlhRVVRSQU11ckRFbjk5Q3F1cnZudlFT?=
 =?utf-8?B?MVl0M3pJa3pLZ3ZFR0tTdG55WlRPMTBBNGVpNkwyVzBNUHpFOVFaOE9ISkNq?=
 =?utf-8?B?eHBrT3RuNTJSNW03QnZzSDlVR3VFeFdFRlYwK0g3UmRaS0VJeVlvUnBMS0lE?=
 =?utf-8?B?b1RmalQ3TGlHZ25hM2piWjRTNXRzTWJlWkFuL1pXYlhSZDlkMi9ua0VHVXpT?=
 =?utf-8?B?TW5XNnI3K1BMY3grNWZWd2dDRzJSRVdPaVdCaU5VeXdQK3MvWlVEYk9tYUpO?=
 =?utf-8?B?L2RhcHRGbU0xSHBjd2lpL3ZFTjNTN2YzbjJuaFRSeFkvQlJDQkd0NWxlNk9a?=
 =?utf-8?B?eDl3Sk1vQTFvWmZTZUNKeVlYMkUwMGE3eTc0QzRPUHpRSTQ5eHlCSU0vTmRM?=
 =?utf-8?B?cWFzUVZsNmdiLzVhTVMrWUlvUHBlZXNDS0hnV3lTSE5uaitXZk5hdmpzL0FO?=
 =?utf-8?B?bndYTFAzU3d0N0U1bWd3RFBMcklzNmVrOTlzSjJudDQ1RDczS3VsaEVXVmU0?=
 =?utf-8?B?eEsrdVcxMTB2dkRDMXBzSis1Q21IdjNRaGZjVk9BMVYvMXJWMU5MZHlONUNu?=
 =?utf-8?B?RG1tQ1N5U05HaU4vNTJmUzlBekx3a3RTa0FnUWpKUTUvOG9FV3R5U1RTZXJ3?=
 =?utf-8?Q?N6bGXg8axYhkmlOecbfZJg77jkTo7Iyg03J7rzU?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB3919.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7485
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D06.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	1fd02c5a-3d18-45cc-7b6e-08dc8403a97c
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|1800799015|82310400017|35042699013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aTlCT2RsZ0pDNmdnMklyOGd4ZVc4ZDVVZk5ZS1VjUHFiQ0FNTk4vNWtYc2lr?=
 =?utf-8?B?alBlM3M1MFZhWnRoSzJrc3pKQjYvdEU3d1JINnJoWEVjeVN3VktsVGFOR1NI?=
 =?utf-8?B?WCs3MzJ5UGhtYlgzRWF1OTVrZzVnbnd5YVBEZTVsTUpoVVRzcFJ5MGUzMysv?=
 =?utf-8?B?K3lCa1V0bjZUNCtrWm9LTUswOEJMMlFvbTUyTWNDZUFZSGdJcytnejZjT0hL?=
 =?utf-8?B?RVhtSWRXUGI2dXhVbTk4bDBkeTdLKzUwdXlQTlFnSktrdW1udzNkR0ZzaU9G?=
 =?utf-8?B?aWp6M1dHQStmZG9rQ3hSK01NeG5maDRTUnI2ZDhGMXZTemV2UkljWDZqSVNp?=
 =?utf-8?B?THBoRzhnWkVkTWcrQXFsZFM1Yk5IYnFyL3pKTWZDWG1DRm5SbTJtSHZZSXcw?=
 =?utf-8?B?V3NWZWZhTkhHZjlpYmExbThlbEVBcEZya1hWMDQvQmlBSThadnJrWGFlcVdP?=
 =?utf-8?B?VUtRNzYwVUF4YWFNdWNlTksvZ1publhhbVRHalFvM0Vob3p1YU0va3FIcUh6?=
 =?utf-8?B?WDVWNENFdzAzUVRzUGJJUHF6SWZaSDF0Y2xHcFN1RUs4Qnc3SVIzeUR6K3pJ?=
 =?utf-8?B?WnFhSWx0WGM0VXc3MWVERjNIQXArQXlmeGpvVWVLL210SUdQeGtEaWU4Q1Q5?=
 =?utf-8?B?dVRGWmRETmZjQXZEY0VYbUJ1TnVOVUJPenU1MUZEM09EWThBdmREYWVteEow?=
 =?utf-8?B?WVBnT2lpd0U4SWdDQ0tOOHI1aEorb3dCNWVSeGtmeTZ4MmI5UDc3RElBNHIv?=
 =?utf-8?B?b3FpVUZHTFBtWURJNmVzRlhmaExmbzkzQTZwYjFObG1WYTFUbytjUjhKK0RB?=
 =?utf-8?B?V0g2Uk1HTFROVlhxT1BMTG85dmV6aGFCMzV6aGFqSTlmMnBNem5ic0dNcGh3?=
 =?utf-8?B?Y3NkeFIvdjByVzM4U3NZeFp6U3YzMlJaUUk1bjVhem11QVJFU2YyRlhsMGJy?=
 =?utf-8?B?MDMxMWZHR29UNkJWMHVxUWN1ZkxBS1FOVDZxZ1diMGZSeVF2TlV2aDd3WUJI?=
 =?utf-8?B?eEg2eWVoeGhCaXZRaTVFWFZRRXlweEwraFNmRUZIZkt2WG9nQnhZdHhqL2Ns?=
 =?utf-8?B?eHRtZGVpTSsydUdlSEZuM1VRY0FkU2ZtRVBtV3FianBId0NxSmRvQUl4YTkw?=
 =?utf-8?B?cno1TnR1a1BKSnQ4c2lyYkV1WGh2SGpHUGQyU25yelZTOW9mb2J6NUVhenVl?=
 =?utf-8?B?cVVXcmk5TzZYWlFudllta1p3LzBqdmtFZ1NrY2FQcS9jdUZxdW9sd1BTdEZn?=
 =?utf-8?B?RFB2a3BrRWp1aFREamprN29XbzczQWIvSEN6clloRElBTkF6dkY1ODV0ZmNn?=
 =?utf-8?B?YUhvZkZYUjRNbW41a1NWUTNzWU02QkYxWVNoQ3kxTFM1SFdsS092djFQRytC?=
 =?utf-8?B?V05sYkVJMXBJTlpla1Nhb1g0blA1Y0xpMmVRSzdhVzZjUGo1U2NWM0QydnBh?=
 =?utf-8?B?RlVKSVpCaFEyZndWenh0VVJKU1pQNW9jTkd3Vm5McXdEamhBY2tUaFBnV1dD?=
 =?utf-8?B?RnVHdU96ZVlNaURIVzFmeGRHWHlBWkNMak1Xa1h3Q3VMSkFkZmJrcGdIZ0RD?=
 =?utf-8?B?WURWR1VVR01ic2toQW5TVktKZkVCZ1ZXS0pBblJvSDNTK2JrTVRtRnUwL3Ar?=
 =?utf-8?B?b1FROXFRUjVHSWxVT0lFcHVpdkUrRlo2ZmNrT1VhSGp1SS9OS1BMLzVyQTU0?=
 =?utf-8?B?TmpabVZnTjZXbzFjT0pyMm50QWs2MXBWdGJFczZySURxa3dncVNVVVlIV1Ru?=
 =?utf-8?B?YzI2Y2REbktrUDNMYUZvZE11Wjgvb09xN0lYOWdCSlR2RDRieVQvMGcvZDJm?=
 =?utf-8?B?M3BoM2o5ZVRrRkV0VUNHSmNjWDQ1MDQzbEFQNE9YNHVZMWZwRkpVc1JVZkJO?=
 =?utf-8?Q?U+QMIIZuWyKNY?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(1800799015)(82310400017)(35042699013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 19:30:54.1585
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a0cf31d-6611-4817-dfd7-08dc8403af60
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D06.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB9959

On 5/29/24 23:50, Peter Zijlstra wrote:
> On Thu, May 02, 2024 at 11:26:14AM +0100, Luis Machado wrote:
> 
>> Going through the code, my understanding is that the util_est functions seem to be getting
>> called correctly, and in the right order. That is, we first util_est_enqueue, then util_est_dequeue
>> and finally util_est_update. So the stats *should* be correct.
>>
>> On dequeuing (dequeue_task_fair), we immediately call util_est_dequeue, even for the case of
>> a DEQUEUE_DELAYED task, since we're no longer going to run the dequeue_delayed task for now, even
>> though it is still in the rq.
>>
>> We delay the util_est_update of dequeue_delayed tasks until a later time in dequeue_entities.
>>
>> Eventually the dequeue_delayed task will have its lag zeroed when it becomes eligible again,
>> (requeue_delayed_entity) while still being in the rq. It will then get dequeued/enqueued (requeued),
>> and marked as a non-dequeue-delayed task.
>>
>> Next time we attempt to enqueue such a task (enqueue_task_fair), it will skip the ENQUEUE_DELAYED
>> block and call util_est_enqueue.
>>
>> Still, something seems to be signalling that util/load is high, and causing migration to the big cores.
>>
>> Maybe we're not decaying the util/load properly at some point, and inflated numbers start to happen.
>>
>> I'll continue investigating.

Apologies for not getting this earlier, but I wanted to collect as much
data as possible so we can hopefully see what's going wrong with this
particular patch in the series.

(picking up from the previous questions on find_energy_efficient_cpu and
overutilized)

For the rate of calls to find_energy_efficient_cpu, I checked again and
I didn't see any significant differences there. With delayed dequeue
or without delayed dequeue, I see almost the same number of calls,
with the expected small variation between runs.

As for the overutilized part, there is a bit of a change within
find_energy_efficient_cpu. When I first enable delayed dequeue via
the debugfs (I boot up the system with it disabled for a clean state),
I start to see a lot more cases of us bailing out of
find_energy_efficient_cpu due to the overutilized condition.

Strangely though, things seem to stabilize after a while, and the
rate of overutilized conditions when within find_energy_efficient_cpu
goes down to normal levels.

Here's some numbers from a trace session:

Delayed dequeue off (clean state, 2 iterations):
------------------------------------------------

Calls to find_energy_efficient_cpu: 211087
Overutilized when in find_energy_efficient_cpu: 36224

Calls to find_energy_efficient_cpu: 205804
Overutilized when in find_energy_efficient_cpu: 35274


Delayed dequeue on (3 iterations):
------------------------------------------------

Calls to find_energy_efficient_cpu: 204079
Overutilized when in find_energy_efficient_cpu: 86966

Calls to find_energy_efficient_cpu: 207351
Overutilized when in find_energy_efficient_cpu: 111233

Calls to find_energy_efficient_cpu: 208556
Overutilized when in find_energy_efficient_cpu: 77986


Delayed dequeue off again (3 iterations):
------------------------------------------------

Calls to find_energy_efficient_cpu: 210396
Overutilized when in find_energy_efficient_cpu: 34108


Calls to find_energy_efficient_cpu: 210978
Overutilized when in find_energy_efficient_cpu: 33122

Calls to find_energy_efficient_cpu: 210181
Overutilized when in find_energy_efficient_cpu: 33060


Delayed dequeue on again (3 iterations):
------------------------------------------------

Calls to find_energy_efficient_cpu: 202932
Overutilized when in find_energy_efficient_cpu: 35060

Calls to find_energy_efficient_cpu: 206098
Overutilized when in find_energy_efficient_cpu: 57373

Calls to find_energy_efficient_cpu: 199444
Overutilized when in find_energy_efficient_cpu: 33959


On the matter of switched_from_fair() being called with a task
that is sched_delayed == 1, I can confirm I see some occurrences
of that. They are not that numerous, but do happen from time to
time on the trace data. I haven't investigated things in that
direction yet though.

But we do make those tasks sched_delayed = 0 in there, so things
should go back to normal eventually, unless we fail to dequeue
the sched_delayed task properly for this case.

> 
> So I re-read all this util_est stuff again this evening and I am
> confused :-) Please bear with me.
> 
> So the old code does:
> 
> 	dequeue_task_fair()
> 	  util_est_dequeue();
> 	  // actual dequeue -- updates pelt
> 	  util_est_update();
> 
> 
> While the new code does:
> 
> 	dequeue_task_fair()
> 	  util_est_dequeue();
> 	  if (!dequeue())
> 	    return;
> 	  util_est_update();
> 
> 	delayed_dequeue:
> 	  util_est_update();
> 
> 

The above is my understanding as well.

> Specifically, we only call util_est_update() if/when we do the actual
> dequeue -- potentially at a later point in time. Because, as I argued in
> the comments, ttwu()'s ENQUEUE_DELAYED will not actually enqueue the
> task (since it is still enqueued) and therefore the update would be
> spurious.
> 
> However!!, if we do dequeue, then we'll end up updating the EWMA with a
> potentially different task_util(p).
> 
> And this is where the confusion comes... this extra time on the runqueue
> would not be running and thus decreate util_avg, as such task_util_est()
> should be lower than before and tasks should tend towards smaller cores,
> rather than larger cores as you seem to be seeing.

Right. I also expected the util_avg to decrease with more time on the
runqueue. And that might be happening...

> 
> [ there is the 'dequeued + UTIL_EST_MARGIN < task_runnable()' escape
>   clause, which we might be hitting... dunno ]
> 
> In any case, if you haven't tried it already, could I ask you to test
> the below (once you're back in the office)?
> 
> Also, this doesn't really explain why things go sideways once you enable
> DELAY_DEQUEUE and then don't re-align if you disable it again. I mean,
> it should eventually age out the dodgy EWMA contributions and start
> working as expected.
> 
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7008,7 +7008,6 @@ static int dequeue_entities(struct rq *r
>  			SCHED_WARN_ON(p->on_rq != 1);
>  
>  			/* Fix-up what dequeue_task_fair() skipped */
> -			util_est_update(&rq->cfs, p, task_sleep);
>  			hrtick_update(rq);
>  
>  			/* Fix-up what block_task() skipped. */
> @@ -7028,13 +7027,11 @@ static bool dequeue_task_fair(struct rq
>  {
>  	util_est_dequeue(&rq->cfs, p);
>  
> -	if (dequeue_entities(rq, &p->se, flags) < 0)
> +	if (dequeue_entities(rq, &p->se, flags) < 0) {
> +		util_est_update(&rq->cfs, p, DEQUEUE_SLEEP);
>  		return false;
> +	}
>  
> -	/*
> -	 * It doesn't make sense to update util_est for the delayed dequeue
> -	 * case where ttwu will make it appear the sleep never happened.
> -	 */
>  	util_est_update(&rq->cfs, p, flags & DEQUEUE_SLEEP);
>  	hrtick_update(rq);
>  	return true;

... as the above patch unfortunately doesn't improve things. The util_est_update
might be a red herring here.

Exchanging some information with Hongyan today, he was a bit suspicious of the uclamp
behavior with the eevdf complete series applied.

Checking the uclamp code, I see we have some refcounting tied to enqueuing/dequeuing
of tasks, and the uclamp values are organized in buckets.

Just for fun I added a few trace_printk's in uclamp_eff_value, uclamp_rq_inc_id and
uclamp_rq_dec_id.

Booting up the system with delayed_dequeue disabled and running the benchmark, I 
see the uclamp bucket management pretty stable. Tasks get added to the uclamp
buckets but then get removed. At the end of the benchmark, the uclamp buckets
are (almost always) clean of tasks.

Enabling delayed dequeue, I can see the uclamp buckets slowly filling up with
tasks. At the end of the benchmark, I see uclamp buckets with 30, 40 or 50
tasks still. If I do another run, I can see 80, 100 tasks still.

I suspect refcounting might be going wrong somewhere due to delayed dequeue
tasks, but that's more of a guess right now. Hopefully that is useful
information. I'll resume investigation tomorrow.

