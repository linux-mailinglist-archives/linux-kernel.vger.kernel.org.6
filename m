Return-Path: <linux-kernel+bounces-175918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3508C2722
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 16:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F7302831F0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 14:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55549171078;
	Fri, 10 May 2024 14:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="RlO3Eys8";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="RlO3Eys8"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2076.outbound.protection.outlook.com [40.107.20.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC44EAC0
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 14:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.76
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715352622; cv=fail; b=E1Wb6NQrdSp30xbV70AOepuSEvmU8qAIEA5sWDoBN6Dm6R6IkIsIvZKaskrKjRFdx5+PERhx3M6JTTqvSrUYBJSuKpEV2jIqZDbR+alpgSeeMXjy9gnC2P27zrjKwdEC1+IirZnKb2+fYla7o0p0733RGVTrGae+27JX6G4RGEg=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715352622; c=relaxed/simple;
	bh=VvnnjLfHE3sa0hrF/8pTvJoRxGCV2HhjWozdE2vv7+U=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pHNKGxLFwWWG0zbwTepfOV5GbRz0BZSGBHU2EH00NPq5DHPGuH9bUjPb+3BVqfXEX9Lxzg18X+yOkY2Ao8AZLPkCWqKNsZFmvS4mNYekHpQVNrMTVKslCioabQDKbV7WztYR0KNx6hHWXrSIek8TOc2cIBzUZsK5/b3Ut/iSLFI=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=RlO3Eys8; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=RlO3Eys8; arc=fail smtp.client-ip=40.107.20.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=iHA3+3BwYKR/7uagGhVW52d9s5fR9HfKpa2t7RyyTrxJlcfF/So/jPS3Ssvrq8MCS63NlmiyI8B6lKaAksOH/e7ht4oBm1cSLtotJKejNWKH8JkYMr18vPUdVAMFYZE7FQsHA5gVrwwmk1E0L6qwRHhtZ4DmRlQU5OJaAsrVLrELjnpIsenTnCYRAL379puzIIPO4BLtQ4UKkoyi6c4CeYrvXdYLYr8dOKPSWyu3tzul/ws/Kfon4yv6U/8w1j9YOMeEaABriEswbGjfx9vp43m0W9KnHFNbI38BfrZyHJcvs1WlxziASZ0t7xxXAZI/sALXLJ/5HAXr3HPgGdOhlQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OJCFwTWIZZSWlqgLMFPfTyXkPedheuiw8c+WCM/TEHI=;
 b=XrVWoa4r12aB1k9wJzNW4BtN4azG5i89uV8wGzi/lAxCkn0lssAKikTXaJiw9eMY4wc6exnq3rqj/OXyL+WpTwJnoiRPIEv84+qBkKsxZGhvhytYdLgXb0O3XbpQ/LnFC79dWuLffzkMfOmsz9ADMWimE17jWYSJtVUzH89wa7XgQ+7gQ3GHjzcw2k/MxTQure5m9Mh5Kn6dtjgnnGxb0BtSRvfknDcTEpnrqDQ+lZxOk0zHktijnJroBtSDbLNkUpglZrzl5qX3R9GuJy0UwxjMigBW4d46Vo5XlBfJd7X+/k6oYDcy1vaYBADaOuyA03+guvSQhuJtxP8yFxZb3g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJCFwTWIZZSWlqgLMFPfTyXkPedheuiw8c+WCM/TEHI=;
 b=RlO3Eys8i8zhn2IkSVshfKATVpw5joSXPgJKg80PcxAWSpkgbDEa72HfBYq0FxyWOIonJJaRU1M1uVvCoAUw3be9M/XONoVUyp3NBl272WgD3CfnxwvMG43lS+ZBUtRsp7iRoPMgLEqy3GQpUTmt6+HACHugvekBCcjADsc4K7w=
Received: from DB6PR0301CA0075.eurprd03.prod.outlook.com (2603:10a6:6:30::22)
 by DU5PR08MB10438.eurprd08.prod.outlook.com (2603:10a6:10:521::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Fri, 10 May
 2024 14:50:04 +0000
Received: from DU2PEPF00028D0D.eurprd03.prod.outlook.com
 (2603:10a6:6:30:cafe::67) by DB6PR0301CA0075.outlook.office365.com
 (2603:10a6:6:30::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49 via Frontend
 Transport; Fri, 10 May 2024 14:50:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DU2PEPF00028D0D.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7519.19
 via Frontend Transport; Fri, 10 May 2024 14:50:03 +0000
Received: ("Tessian outbound af213ececc3d:v315"); Fri, 10 May 2024 14:50:03 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 23eb4fd18f21556b
X-CR-MTA-TID: 64aa7808
Received: from a9e0912f220e.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id A4808BC4-DE33-4450-9ADB-76336BF19A6A.1;
	Fri, 10 May 2024 14:49:53 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id a9e0912f220e.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 10 May 2024 14:49:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J/uckQUhNvbLEZ4Es80M+eCST8gqamzFdtn3FWgzUU8gweRJirVy7uNinaWn2QsrOzI3S0G/RHqx9Na48avKvt35PEaKapfgC/8qFGrtGoojk2pjBw+q6iMcLY6s0RRzIn4xXixLjoDj82B5AcxEZZyQREvZAIieS90coaMCk8ofsjiJog56dIP1W8lEaV6D1JQrGIMPWnpH0tapwyQqrmehWFPpta3E8wmzQ1wMIqfWjiBWKoVL63nnOSQ2RJZdW/JWZd457Jq0DFCVXUFwhjq/NJG+nFcEDRXSRK1sMUtXdBR/vqfACJ3hhxZ2cyKm3tJC8slAfDhEJDYIHDPxZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OJCFwTWIZZSWlqgLMFPfTyXkPedheuiw8c+WCM/TEHI=;
 b=XNMtVrir3ELP2daIGSD2gk5PwkK51F2GJ/tHll8ByWJ8lyisssi1OoyAtC/WxRlitTYiSxAM4SWqeuW4Uv1KMi00UsZZkF25FpvubY1HrsMIlV76XqDRBU0bZ25Celzd4xHKRC1MZUx1ub1oKQfmHrucjylUBxk38AcHDAayHzAIoRAZI9EHIdjEYsBd856ZKMkIN3cKZGj0Cc4eznBUJYgQuyLu7Ezau8NBTtbmLD0RX3sS1ru4w0bjvzlK9AsoiDn78R5YqtyynevlzWz8l+W6dniRIlGDwVvXWrt5gNifdf853GPYdmmE/7mdcLpA/gOU59PA3V730UvK0p1KuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJCFwTWIZZSWlqgLMFPfTyXkPedheuiw8c+WCM/TEHI=;
 b=RlO3Eys8i8zhn2IkSVshfKATVpw5joSXPgJKg80PcxAWSpkgbDEa72HfBYq0FxyWOIonJJaRU1M1uVvCoAUw3be9M/XONoVUyp3NBl272WgD3CfnxwvMG43lS+ZBUtRsp7iRoPMgLEqy3GQpUTmt6+HACHugvekBCcjADsc4K7w=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI1PR08MB3919.eurprd08.prod.outlook.com (2603:10a6:803:c4::31)
 by AS2PR08MB9691.eurprd08.prod.outlook.com (2603:10a6:20b:605::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Fri, 10 May
 2024 14:49:50 +0000
Received: from VI1PR08MB3919.eurprd08.prod.outlook.com
 ([fe80::77d4:d040:b19d:6472]) by VI1PR08MB3919.eurprd08.prod.outlook.com
 ([fe80::77d4:d040:b19d:6472%4]) with mapi id 15.20.7544.046; Fri, 10 May 2024
 14:49:50 +0000
Message-ID: <219b8b49-3767-4010-aa68-9e1cf66c2ccb@arm.com>
Date: Fri, 10 May 2024 15:49:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH 08/10] sched/fair: Implement delayed dequeue
Content-Language: en-US
From: Luis Machado <luis.machado@arm.com>
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
In-Reply-To: <2fba04b0-e55e-41f4-8b7a-723734fe1ad2@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0123.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::20) To VI1PR08MB3919.eurprd08.prod.outlook.com
 (2603:10a6:803:c4::31)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI1PR08MB3919:EE_|AS2PR08MB9691:EE_|DU2PEPF00028D0D:EE_|DU5PR08MB10438:EE_
X-MS-Office365-Filtering-Correlation-Id: f51f6459-aee8-4281-de61-08dc710079f3
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230031|376005|7416005|366007|1800799015;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?Tm1JL3dlUGJQUkhSdXd6NDl4NjNPaDdsMVJqbUt4NXAxb0tSWnlCNkFBckhK?=
 =?utf-8?B?bEhPTnI3SUk4aFRMbzJ3TFo0Y2w4V0lHdDZWM0RBUnhZWUtocVZIUTRWcGZx?=
 =?utf-8?B?TzhOeStzVG9aTEpKODVLdk1pU0ZyYmJRRnJsRS9zK05PYnZHT1ZNUWl1L3lx?=
 =?utf-8?B?aDhDKzBGVlovRmVNV20rdkl6emRRcFhURWxpQXR1NXZ5dFNsTUwvblQ5UUxt?=
 =?utf-8?B?V0ltNlJycDVpTjA3bmdBeGVhT2c3TVhiQlI5SVUyMW10Y0xDbjFTY2dtK09v?=
 =?utf-8?B?UXVZd1hzWW9MV1krQjdhRERIY3pvVWYzSzNxOElWYUpkblQ3K0E4VkZUbWt6?=
 =?utf-8?B?YWtZbG80U3FVb0lDUlB2QzNaa1RTS0l0WmZ3bmdGelIzczF0c2wrTTcxUjNj?=
 =?utf-8?B?MmEzelhCUVB1d3NMWXMwalFRUm52MlJsVFA0TDNoTkxuTWw3RGMwV3F4ZDlj?=
 =?utf-8?B?TmJnWDV5dU14UUVGOE9kQ0FTUmxMeDAzc3U5ZWlBdm1ydjlhVTRlTlVXaVVD?=
 =?utf-8?B?YVZWUXh2MmhpZXRJa3gxWi90TkFMdVkzdTZhWG1hKzd3V3RGTythVy9razJ6?=
 =?utf-8?B?VVlSWnhCemlITkVWS1ZGNGRxd3pISmJWbnNxOW5WSFhLQXZkcVJKeTdxZnlj?=
 =?utf-8?B?MGl4NytSenpibk1Lc2M4L3RDVVN2VlFxWk1ZYXRnc2kxUUtPNnY2bjl2MDZ5?=
 =?utf-8?B?aXI0bUFtclBMN1JYYWMvK0JNSmtyajU2U2NDYU9OdnZ5V1pkTDJTb1lyYzNN?=
 =?utf-8?B?UjVCTVpKa0g2SjNPVmZMWUYrZnQvOU12SlVCZWNRMUxXQ1BCWGFCNkFnbVVQ?=
 =?utf-8?B?cm9hNG40N0RDZExOVitZeVplZDRFb01EcENFeHhtaTZienp3b0Y2QlVxQm9C?=
 =?utf-8?B?VHpUZlZqNm4vWncyMnZPWFh5bXdlbmxTQlhUUWlra3lwSVNTMnFsQXMvNkhK?=
 =?utf-8?B?a2VMS2xjZldiQlhFRjJUQ001VllmVnQvTzVMaHlQWjFyMVFxMXQyblVKRWc4?=
 =?utf-8?B?elZRd1RKZ3JoZmtWR2NiSmlFaDZnam9QMFI4ejhOZE1MRWs4K09XK3IxdmhB?=
 =?utf-8?B?MmJjdkdxNTJDVUFvdVZtSW9lSlhoQjdEMkdBSm9FUW8wMHJtWnYwSVZ6Uyt2?=
 =?utf-8?B?ODFYUUdUK0F2b0t3cng3TXVIRkFDNm1KbEpXZUU4VWdkVGxSYW1JRGcyQ0NW?=
 =?utf-8?B?VjI0R1Q3MTBQUU9xajk3a0JZbWcyZ1dzZXVMTWFidzB6M3BqRTNvc3J2OVFF?=
 =?utf-8?B?cWU1czhGMEhaOCsyYWxlR2FoQ1RSbmZHcmxkZjluQ0Z5c3F6TXl0QUY2VkU4?=
 =?utf-8?B?azRJaWZhZGJ4UGJBQzVjaU9OUnU0dmMyaE5tKzBSdVdPbEkraTl6S3R5aTVk?=
 =?utf-8?B?TW9HcnArOEgyNkhZZFkrRWRaUFpYYmNDUDBGUnNaWjRpa2t0YzVNMXEwZmtX?=
 =?utf-8?B?WjlFdTM3T2o0dk9Ib3ZGK3dUVmoyeml2R2svbWF6SE15MzFMa2N6eGF3VkZr?=
 =?utf-8?B?ZUxDZnlrWTZESWIrbXFGSC95YXdGNDZtQm52eVlJeW1YU1BPa2xSRHhLMnVI?=
 =?utf-8?B?V0JXSEZBaHE0c01YQjdITUpBVU5nZFJhQmJDTGZNUFhRMWVJTWU1cVZaWHVZ?=
 =?utf-8?B?Y0dYVEYxYm0rck9lci82WUExWndNSVk5c0x3NC9KeGJodGRQenlNTk0vM0t2?=
 =?utf-8?B?NXRUNGNFdVY1SmN1ZWdtRS94V1h0RHhROHpFeW9BRHlnVkw2THhCU1R3PT0=?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB3919.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9691
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D0D.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	d23e30c5-1da3-4e43-85a1-08dc710071ac
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|35042699013|82310400017|1800799015|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bFlueDVHc0tlM2Z1WHJOdENlRWdXRTdSeVNkalJlNHZjRGVHZklIWm9iVnZk?=
 =?utf-8?B?R2tLQWVmMHRPblVqK0UxU0VvSXd3a0xyREZLQkJVd3BTdWl0MDVsNnJGa0p1?=
 =?utf-8?B?TVA2bXc1d1d4K0s1U0kydmtEdjI5VE9yTGF4MzUxU3NFdTM3akVhOE8yaXcy?=
 =?utf-8?B?dFJwaGhKbitMcU1ZWGJBUXpKcTBUUHRvYlBPcVBucDBYM1hQcDRzV2lqeUww?=
 =?utf-8?B?VDV6Umt2TFo5bFZTd3prcWh2WnZNQzNkQ210V2QzMDA5Nmtaa3gydzZ4N1Yx?=
 =?utf-8?B?NDhBQkNENGJ5YitFckZnL0NYajRMeFVRVlBsTDRsZ0QrdmJDMytkSExEQ0hO?=
 =?utf-8?B?cFBKZFRxdVlQVHlvdXdrU041R05QZFFLRkliT0xNMUFuc0J1bDF6Q2NtdExD?=
 =?utf-8?B?K1JmOGd3TEoxM0h4T3RZc0VDaGdqL0UwUkZoNmhrTGJFclltREFGVEtJZ2J4?=
 =?utf-8?B?ZE1vWlgvQXBBT29aMmdrYm1LV3lHV1dmQUlPenVMN3EvYUlzNEloZlBQVUhs?=
 =?utf-8?B?U053WkMzSTJGWTNUVGtNbFlaZlNIL3k0czJiS1BLcVZhZTJ0Nm1HaDFZUVhE?=
 =?utf-8?B?dFRXdmlzcWZRd2pIS1phZ3g3YnhjWHBFclIwbHJvMnhCcGs0WnExY0FpdXJE?=
 =?utf-8?B?aHJQaHRhR3RLaEp0WVh3ZGM0SXVIVThjR0RWMEJWNmFkYndQUnk5Mm9tQnBQ?=
 =?utf-8?B?SEozYVN4NGM2RjZrajlCYlVHZkMyOXVRL00xVlB4Q2xWdjFsZjdLdzBTaWxw?=
 =?utf-8?B?VHFnM2NvbWV2dlBpWTh2UjhCRHloT3MzK0FlYk0rdHNZN3BxZ2ZoYzVqOFVk?=
 =?utf-8?B?dGg0Z3J4eFBaUUpJK1V6VUozR0YzdkY4ZDA4WVN6d0pyL3FVb3dyYlZHemNH?=
 =?utf-8?B?a2VJVmlZV3dmOHB5dmJsbWtPbFU5b2U5QlJBOWJLMlRmbGpodVNldTlmVVNk?=
 =?utf-8?B?NUNZVDBQaHJrL1pGZWRscDJWVnEvSjErNU5BcXE0Unprb3dSOUNTTGQrTW9i?=
 =?utf-8?B?K0JDdk1ndDhZa0tLNHpJTTJOY1BlT3lUWkMwdFhVZU5NdlJ5VkQrZWJTakly?=
 =?utf-8?B?SlIwOE0wcWpNSDFWajFZTGFoWExOc2lIU0RoaXZRdmRBVGo5a05kMmxXVUhL?=
 =?utf-8?B?all2ZTQrWDZRMVFDNjNMbkN3L3IwQXd2TXV5RnVwekN4MmRhak4xWUhUQ0g3?=
 =?utf-8?B?U0hwNjNWTFlWTTFzZXkydTNGMnpwMmhDY3hBc1RxdUpPVGlJMXh1Y3RtT1J2?=
 =?utf-8?B?VUFJVGdCVk9SaEJueUhmZHVreVFXRmg1RHJhb0NCcm1JOVZsVTM0dlZiZm9o?=
 =?utf-8?B?VUtFVmlBd2phM1JCbUJnOHVObE0rb2l3Y1RsY2cwRVZLamQxNTV5SUpqRFVx?=
 =?utf-8?B?bHlXL0RCdGxlSm44L24xSnRNL1ZWdVZkS0xvSVpPelFlelJBVGFjVVRuOGZx?=
 =?utf-8?B?OFVTamlQcVhRUmpDOXZsK0hqRnMzbHNUMyt0endvbXdZbVkya29raW1YYXJF?=
 =?utf-8?B?bkdubEJQYXhSc1hBajBpMGtmcUg2M28zNUtFbE1vZjFUektqVytyazVObzVP?=
 =?utf-8?B?YmM2WlBKK3d3enNqTEpkRnRUWnh2TGYwZG85RWRpellSZ2M2bjhzeFdmRFRT?=
 =?utf-8?B?UXhqaDR1dVMxSDBmR21IOUgyZHFPTGZHTmEwTDBYWWcxVnVCQWRLbGRrUW92?=
 =?utf-8?B?YU9JZUhveGhvNld5K0J6djVOc0FQRGl5WmhCSWlFQzB5dFZKNnhaK1JhQmhM?=
 =?utf-8?B?MjQ1MkZxbmV6WDIwTnlydkVXQklzQVk2UFhwWUNuUHRsVmVXa3c2WjJ5di82?=
 =?utf-8?B?TTd0R0dCMm9QWEJlZHFFSjZXZHpwZ1lrUWNuOTJqZDJBbjZTVGFFZ2hZcXlR?=
 =?utf-8?Q?WdtxHr98sGgLx?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(35042699013)(82310400017)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 14:50:03.8169
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f51f6459-aee8-4281-de61-08dc710079f3
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D0D.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR08MB10438

On 5/2/24 11:26, Luis Machado wrote:
> On 4/29/24 15:33, Luis Machado wrote:
>> Hi Peter,
>>
>> On 4/26/24 10:32, Peter Zijlstra wrote:
>>> On Thu, Apr 25, 2024 at 01:49:49PM +0200, Peter Zijlstra wrote:
>>>> On Thu, Apr 25, 2024 at 12:42:20PM +0200, Peter Zijlstra wrote:
>>>>
>>>>>> I wonder if the delayed dequeue logic is having an unwanted effect on the calculation of
>>>>>> utilization/load of the runqueue and, as a consequence, we're scheduling things to run on
>>>>>> higher OPP's in the big cores, leading to poor decisions for energy efficiency.
>>>>>
>>>>> Notably util_est_update() gets delayed. Given we don't actually do an
>>>>> enqueue when a delayed task gets woken, it didn't seem to make sense to
>>>>> update that sooner.
>>>>
>>>> The PELT runnable values will be inflated because of delayed dequeue.
>>>> cpu_util() uses those in the @boost case, and as such this can indeed
>>>> affect things.
>>>>
>>>> This can also slightly affect the cgroup case, but since the delay goes
>>>> away as contention goes away, and the cgroup case must already assume
>>>> worst case overlap, this seems limited.
>>>>
>>>> /me goes ponder things moar.
>>>
>>> First order approximation of a fix would be something like the totally
>>> untested below I suppose...
>>
>> I gave this a try on the Pixel 6, and I noticed some improvement (see below), but not
>> enough to bring it back to the original levels.
>>
>> (1) m6.6-stock - Basic EEVDF with wakeup preemption fix (baseline)
>> (2) m6.6-eevdf-complete: m6.6-stock plus this series.
>> (3) m6.6-eevdf-complete-no-delay-dequeue: (2) + NO_DELAY_DEQUEUE
>> (4) m6.6-eevdf-complete-no-delay-dequeue-no-delay-zero: (2) + NO_DELAY_DEQUEUE + NO_DELAY_ZERO
>> (5) m6.6-eevdf-complete-no-delay-zero: (2) + NO_DELAY_ZERO
>> (6) m6.6-eevdf-complete-pelt-fix: (2) + the proposed load_avg update patch.
>>
>> I included (3), (4) and (5) to exercise the impact of disabling the individual
>> scheduler features.
>>
>>
>> Energy use.
>>
>> +------------+------------------------------------------------------+-----------+
>> |  cluster   |                         tag                          | perc_diff |
>> +------------+------------------------------------------------------+-----------+
>> |    CPU     |                   m6.6-stock                         |   0.0%    |
>> |  CPU-Big   |                   m6.6-stock                         |   0.0%    |
>> | CPU-Little |                   m6.6-stock                         |   0.0%    |
>> |  CPU-Mid   |                   m6.6-stock                         |   0.0%    |
>> |    GPU     |                   m6.6-stock                         |   0.0%    |
>> |   Total    |                   m6.6-stock                         |   0.0%    |
>> |    CPU     |                m6.6-eevdf-complete                   |  114.51%  |
>> |  CPU-Big   |                m6.6-eevdf-complete                   |  90.75%   |
>> | CPU-Little |                m6.6-eevdf-complete                   |  98.74%   |
>> |  CPU-Mid   |                m6.6-eevdf-complete                   |  213.9%   |
>> |    GPU     |                m6.6-eevdf-complete                   |  -7.04%   |
>> |   Total    |                m6.6-eevdf-complete                   |  100.92%  |
>> |    CPU     |        m6.6-eevdf-complete-no-delay-dequeue          |  117.77%  |
>> |  CPU-Big   |        m6.6-eevdf-complete-no-delay-dequeue          |  113.79%  |
>> | CPU-Little |        m6.6-eevdf-complete-no-delay-dequeue          |  97.47%   |
>> |  CPU-Mid   |        m6.6-eevdf-complete-no-delay-dequeue          |  189.0%   |
>> |    GPU     |        m6.6-eevdf-complete-no-delay-dequeue          |  -6.74%   |
>> |   Total    |        m6.6-eevdf-complete-no-delay-dequeue          |  103.84%  |
>> |    CPU     | m6.6-eevdf-complete-no-delay-dequeue-no-delay-zero   |  120.45%  |
>> |  CPU-Big   | m6.6-eevdf-complete-no-delay-dequeue-no-delay-zero   |  113.65%  |
>> | CPU-Little | m6.6-eevdf-complete-no-delay-dequeue-no-delay-zero   |  99.04%   |
>> |  CPU-Mid   | m6.6-eevdf-complete-no-delay-dequeue-no-delay-zero   |  201.14%  |
>> |    GPU     | m6.6-eevdf-complete-no-delay-dequeue-no-delay-zero   |  -5.37%   |
>> |   Total    | m6.6-eevdf-complete-no-delay-dequeue-no-delay-zero   |  106.38%  |
>> |    CPU     |         m6.6-eevdf-complete-no-delay-zero            |  119.05%  |
>> |  CPU-Big   |         m6.6-eevdf-complete-no-delay-zero            |  107.55%  |
>> | CPU-Little |         m6.6-eevdf-complete-no-delay-zero            |  98.66%   |
>> |  CPU-Mid   |         m6.6-eevdf-complete-no-delay-zero            |  206.58%  |
>> |    GPU     |         m6.6-eevdf-complete-no-delay-zero            |  -5.25%   |
>> |   Total    |         m6.6-eevdf-complete-no-delay-zero            |  105.14%  |
>> |    CPU     |            m6.6-eevdf-complete-pelt-fix              |  105.56%  |
>> |  CPU-Big   |            m6.6-eevdf-complete-pelt-fix              |  100.45%  |
>> | CPU-Little |            m6.6-eevdf-complete-pelt-fix              |   94.4%   |
>> |  CPU-Mid   |            m6.6-eevdf-complete-pelt-fix              |  150.94%  |
>> |    GPU     |            m6.6-eevdf-complete-pelt-fix              |  -3.96%   |
>> |   Total    |            m6.6-eevdf-complete-pelt-fix              |  93.31%   |
>> +------------+------------------------------------------------------+-----------+
>>
>> Utilization and load levels.
>>
>> +---------+------------------------------------------------------+----------+-----------+
>> | cluster |                         tag                          | variable | perc_diff |
>> +---------+------------------------------------------------------+----------+-----------+
>> | little  |                   m6.6-stock                         |   load   |   0.0%    |
>> | little  |                   m6.6-stock                         |   util   |   0.0%    |
>> | little  |                m6.6-eevdf-complete                   |   load   |  29.56%   |
>> | little  |                m6.6-eevdf-complete                   |   util   |   55.4%   |
>> | little  |        m6.6-eevdf-complete-no-delay-dequeue          |   load   |  42.89%   |
>> | little  |        m6.6-eevdf-complete-no-delay-dequeue          |   util   |  69.47%   |
>> | little  | m6.6-eevdf-complete-no-delay-dequeue-no-delay-zero   |   load   |  51.05%   |
>> | little  | m6.6-eevdf-complete-no-delay-dequeue-no-delay-zero   |   util   |  76.55%   |
>> | little  |         m6.6-eevdf-complete-no-delay-zero            |   load   |  34.51%   |
>> | little  |         m6.6-eevdf-complete-no-delay-zero            |   util   |  72.53%   |
>> | little  |            m6.6-eevdf-complete-pelt-fix              |   load   |  29.96%   |
>> | little  |            m6.6-eevdf-complete-pelt-fix              |   util   |  59.82%   |
>> |   mid   |                   m6.6-stock                         |   load   |   0.0%    |
>> |   mid   |                   m6.6-stock                         |   util   |   0.0%    |
>> |   mid   |                m6.6-eevdf-complete                   |   load   |  29.37%   |
>> |   mid   |                m6.6-eevdf-complete                   |   util   |  75.22%   |
>> |   mid   |        m6.6-eevdf-complete-no-delay-dequeue          |   load   |   36.4%   |
>> |   mid   |        m6.6-eevdf-complete-no-delay-dequeue          |   util   |  80.28%   |
>> |   mid   | m6.6-eevdf-complete-no-delay-dequeue-no-delay-zero   |   load   |  30.35%   |
>> |   mid   | m6.6-eevdf-complete-no-delay-dequeue-no-delay-zero   |   util   |   90.2%   |
>> |   mid   |         m6.6-eevdf-complete-no-delay-zero            |   load   |  37.83%   |
>> |   mid   |         m6.6-eevdf-complete-no-delay-zero            |   util   |  93.79%   |
>> |   mid   |            m6.6-eevdf-complete-pelt-fix              |   load   |  33.57%   |
>> |   mid   |            m6.6-eevdf-complete-pelt-fix              |   util   |  67.83%   |
>> |   big   |                   m6.6-stock                         |   load   |   0.0%    |
>> |   big   |                   m6.6-stock                         |   util   |   0.0%    |
>> |   big   |                m6.6-eevdf-complete                   |   load   |  97.39%   |
>> |   big   |                m6.6-eevdf-complete                   |   util   |  12.63%   |
>> |   big   |        m6.6-eevdf-complete-no-delay-dequeue          |   load   |  139.69%  |
>> |   big   |        m6.6-eevdf-complete-no-delay-dequeue          |   util   |  22.58%   |
>> |   big   | m6.6-eevdf-complete-no-delay-dequeue-no-delay-zero   |   load   |  125.36%  |
>> |   big   | m6.6-eevdf-complete-no-delay-dequeue-no-delay-zero   |   util   |  23.15%   |
>> |   big   |         m6.6-eevdf-complete-no-delay-zero            |   load   |  128.56%  |
>> |   big   |         m6.6-eevdf-complete-no-delay-zero            |   util   |  25.03%   |
>> |   big   |            m6.6-eevdf-complete-pelt-fix              |   load   |  130.73%  |
>> |   big   |            m6.6-eevdf-complete-pelt-fix              |   util   |  17.52%   |
>> +---------+------------------------------------------------------+----------+-----------+
> 
> Going through the code, my understanding is that the util_est functions seem to be getting
> called correctly, and in the right order. That is, we first util_est_enqueue, then util_est_dequeue
> and finally util_est_update. So the stats *should* be correct.
> 
> On dequeuing (dequeue_task_fair), we immediately call util_est_dequeue, even for the case of
> a DEQUEUE_DELAYED task, since we're no longer going to run the dequeue_delayed task for now, even
> though it is still in the rq.
> 
> We delay the util_est_update of dequeue_delayed tasks until a later time in dequeue_entities.
> 
> Eventually the dequeue_delayed task will have its lag zeroed when it becomes eligible again,
> (requeue_delayed_entity) while still being in the rq. It will then get dequeued/enqueued (requeued),
> and marked as a non-dequeue-delayed task.
> 
> Next time we attempt to enqueue such a task (enqueue_task_fair), it will skip the ENQUEUE_DELAYED
> block and call util_est_enqueue.
> 
> Still, something seems to be signalling that util/load is high, and causing migration to the big cores.
> 
> Maybe we're not decaying the util/load properly at some point, and inflated numbers start to happen.
> 
> I'll continue investigating.
> 

Just a quick update on this. While investigating this behavior, I
spotted very high loadavg values on an idle system. For instance:

load average: 4733.84, 4721.24, 4680.33

I wonder if someone else also spotted this.

These values keep increasing slowly but steadily. When the system
is under load they increase a bit more rapidly. Makes me wonder
if we're missing decrementing nr_uninterruptible in some path,
since that is what seems to be causing the loadavg to be off.

